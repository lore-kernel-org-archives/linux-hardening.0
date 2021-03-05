Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A950EC433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7063D64FE9
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCEJpD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhCEJoc (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 04:44:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9AF064F10;
        Fri,  5 Mar 2021 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614937472;
        bh=GgobffSTcAiTeECG6O7qxm+f9U+aeeZB8FzqmWJtfVo=;
        h=Date:From:To:Cc:Subject:From;
        b=O+N10mDidK1Rp6mDScqxFz7aOECxgf+oe4VOd0e656fvaxuDsrYkMImoELNMHOmqy
         lXgzrub9hV/GEBu1V19P7URuPGUu6NjPN+sR42NKyRvl5QJKu6EpXFVwFZmEmqg63/
         cwhWIwww2B8WBHqE9zLcFRehpY98Zo24Zm9Kx/Vxs2xoubYKndxrjEL5gSNHRqHr3Z
         s0P7KR03b+i//WhmJlk+dbiYq5KJTVq7GFVETWoDs3azSOHvW854szOv3odIY9RujE
         cuAr/o7LUYpMFPeye8sM/nlrafYnGwLghXfKV+Ao8xwyJWORkKEMHjhbzm/tERH7RF
         hBhMwbS5ELzRg==
Date:   Fri, 5 Mar 2021 03:44:29 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] net/packet: Fix fall-through warnings for Clang
Message-ID: <20210305094429.GA140795@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
index e24b2841c643..880a1ab9a305 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1652,6 +1652,7 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 	case PACKET_FANOUT_ROLLOVER:
 		if (type_flags & PACKET_FANOUT_FLAG_ROLLOVER)
 			return -EINVAL;
+		break;
 	case PACKET_FANOUT_HASH:
 	case PACKET_FANOUT_LB:
 	case PACKET_FANOUT_CPU:
-- 
2.27.0

