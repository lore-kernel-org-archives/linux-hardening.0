Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85665C433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED5264FCF
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCEJXY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhCEJXW (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 04:23:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2C4964F6A;
        Fri,  5 Mar 2021 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614936202;
        bh=gQCVveaA1aybvZEoBTTEwJlDumkrIyeC2KTgqVzYr5c=;
        h=Date:From:To:Cc:Subject:From;
        b=X9k4S8dglfK4M6ExL4rtgGaAE+Anm9Buwf3/ID927iNNob37QcZeOxfcDCsqmc363
         1IVUboPti2v42pFFz2Jj5I0qTEXz+9bE0QqyD03azfXHJTjS6n6bSQZHfuycXbElzg
         9jkotINl7X1gFy4TUVEoJgF/QbruBpHgBA61xXhOtRMujv9D40H/fNxFTrtcvCEmGB
         u13imm9Spsu8/AYAWbaX8ravVLQQ/S6xHYN/bCgZQEbKl2mONsR0bqO9fm7vWXX9TE
         y6OuvKkEJXc+WbdPEHYQA6F/u4rYe6sPwstALrTB2QoeYsrDzEWvFvPx2/ztxmCwvn
         aZTNovh1o+bPg==
Date:   Fri, 5 Mar 2021 03:23:19 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] xfrm: Fix fall-through warnings for Clang
Message-ID: <20210305092319.GA139967@embeddedor>
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
 net/xfrm/xfrm_interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
index 8831f5a9e992..41de46b5ffa9 100644
--- a/net/xfrm/xfrm_interface.c
+++ b/net/xfrm/xfrm_interface.c
@@ -432,6 +432,7 @@ static int xfrmi4_err(struct sk_buff *skb, u32 info)
 	case ICMP_DEST_UNREACH:
 		if (icmp_hdr(skb)->code != ICMP_FRAG_NEEDED)
 			return 0;
+		break;
 	case ICMP_REDIRECT:
 		break;
 	default:
-- 
2.27.0

