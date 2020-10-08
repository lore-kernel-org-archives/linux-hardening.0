Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B92C433DF
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 22:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576B222244
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 22:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602195807;
	bh=uNsdE4XzpK/vqS2xGMfx6CGR668qLPOvLR9vcthds64=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WtV5sbuwlch/YypqqDs8nuUW0WwjG5CPxXihhLyVW/2RHuFzvCrZGbAC2utcA/Cpd
	 nTjlm3bYsve8rePJm4vlQZupOwMzjMTNyfdwTMh0zqUlobcZ8/4g6uPudUN7uGuTSN
	 67qYG0/jtsyBjYrA0ITyXbJrrGGE5WXiRO0qAybY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgJHWX1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 18:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730130AbgJHWX0 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 18:23:26 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 855E7206CA;
        Thu,  8 Oct 2020 22:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602195806;
        bh=uNsdE4XzpK/vqS2xGMfx6CGR668qLPOvLR9vcthds64=;
        h=Date:From:To:Cc:Subject:From;
        b=mCEK/S1izfk8bSQsoAvP7N6RtVZ3joMu5pDrNquwkUMZ/+QWYsvvKE7QLXZjBOdE1
         ZkV1Ma67LFYuycP73de9TdjgEJuENMjQDTNub/SKotbMThPf+xzKIt3rwe83/UgeUk
         1v16nfvhmwJxFw7Bi0zaLqm1uHd7tA4kWUn0Viks=
Date:   Thu, 8 Oct 2020 17:28:49 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: musb: gadget: Use fallthrough pseudo-keyword
Message-ID: <20201008222849.GA18634@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to enable -Wimplicit-fallthrough for Clang[1], replace the
existing /* FALLTHROUGH */ comment with the new pseudo-keyword
macro fallthrough[2].

[1] https://git.kernel.org/linus/e2079e93f562c7f7a030eb7642017ee5eabaaa10
[2] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/musb/musb_gadget_ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 44d3cb02fa76..6d7336727388 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -1024,7 +1024,7 @@ static int musb_g_ep0_halt(struct usb_ep *e, int value)
 	case MUSB_EP0_STAGE_ACKWAIT:	/* STALL for zero-length data */
 	case MUSB_EP0_STAGE_RX:		/* control-OUT data */
 		csr = musb_readw(regs, MUSB_CSR0);
-		/* FALLTHROUGH */
+		fallthrough;
 
 	/* It's also OK to issue stalls during callbacks when a non-empty
 	 * DATA stage buffer has been read (or even written).
-- 
2.27.0

