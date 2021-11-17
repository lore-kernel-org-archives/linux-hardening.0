Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE1C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 18:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6901A61BC1
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 18:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbhKQSTm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Nov 2021 13:19:42 -0500
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:36159 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238577AbhKQSTl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Nov 2021 13:19:41 -0500
Received: from MTA-13-4.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id C886A805EF
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 13:16:41 -0500 (EST)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 36EAA18000AC;
        Wed, 17 Nov 2021 13:16:40 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.217])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 9797618000A5;
        Wed, 17 Nov 2021 13:16:37 -0500 (EST)
From:   Jordy Zomer <jordy@pwning.systems>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Jordy Zomer <jordy@pwning.systems>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH] ipv6: check return value of ipv6_skip_exthdr
Date:   Wed, 17 Nov 2021 19:16:10 +0100
Message-Id: <20211117181610.2731938-1-jordy@pwning.systems>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The offset value is used in pointer math on skb->data.
Since ipv6_skip_exthdr may return -1 the pointer to uh and th
may not point to the actual udp and tcp headers and potentially
overwrite other stuff. This is why I think this should be checked.

Signed-off-by: Jordy Zomer <jordy@pwning.systems>
---
 net/ipv6/esp6.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index ed2f061b8768..dc4251655df9 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -808,6 +808,11 @@ int esp6_input_done2(struct sk_buff *skb, int err)
 		struct tcphdr *th;
 
 		offset = ipv6_skip_exthdr(skb, offset, &nexthdr, &frag_off);
+
+		if (offset < 0)
+			err = -EINVAL;
+			goto out;
+
 		uh = (void *)(skb->data + offset);
 		th = (void *)(skb->data + offset);
 		hdr_len += offset;
-- 
2.27.0

