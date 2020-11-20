Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3660C63777
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA242416E
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIZZAKP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgKTSiQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731284AbgKTSiP (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:38:15 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A90824181;
        Fri, 20 Nov 2020 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897495;
        bh=B0g9mJ2Yy7T9j66O6WmOWpTwanPSFpAdZCjLAf+4ezg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIZZAKP9duMiUTJUprr5+qtyGlkE9hLDXC1cEoLlFTJ9RFOM8GvA+AHIRm3u6xioe
         yt0ExNbFZ/K2HzaMdam0UrNXHiaTtKkEXGfMQACoRXADwlSzfNrnDI51WQBPo5E4YA
         jnpI7UorcVHNbKhR0jpHjaLXtLNPFBsiUHef5i94=
Date:   Fri, 20 Nov 2020 12:38:20 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 110/141] net/packet: Fix fall-through warnings for Clang
Message-ID: <674c24d87ad5b9d00de9094a0efcb647473158b0.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/packet/af_packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index cefbd50c1090..217d44ab3325 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1649,6 +1649,7 @@ static int fanout_add(struct sock *sk, u16 id, u16 type_flags)
 	case PACKET_FANOUT_ROLLOVER:
 		if (type_flags & PACKET_FANOUT_FLAG_ROLLOVER)
 			return -EINVAL;
+		break;
 	case PACKET_FANOUT_HASH:
 	case PACKET_FANOUT_LB:
 	case PACKET_FANOUT_CPU:
-- 
2.27.0

