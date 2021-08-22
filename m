Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2655AC4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134E361220
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhHVHwc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhHVHwU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C20C061575
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a5so8380831plh.5
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afK62obEnzmGfYDuKBrYtTnXazqqlkEC1ozPah846UE=;
        b=i1xyMIsz0UhMBlCsvjT/pELiTurWMqOD2j4e2UXBqBdplCAa1y83+MbpNb56XWzqeO
         QAKKZ4PCJHX5ENT7tbdD1Qop48xhwXxPWQa18bIZtA+oZulK87Fe4IcH0L/gBSLcywph
         YlqdrGLikG1ym2Cde+FxLNEIlqmozwLsogw3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afK62obEnzmGfYDuKBrYtTnXazqqlkEC1ozPah846UE=;
        b=hvP0squA51uFhfTr4FHKov0WhCiv5a60yHGEB7k+i8ZlJPQP4LFLCbYIWeEPRThNgH
         fI928qlfug+UpchkQ35fnJB+SgrBoh3zb8ZFVIJzczDEAgyxsd/ENOFXywoj7iScZTxq
         SOsAkkdo8fjtDqYZ/fRxHXup9F2PLWIYrxeWBYhlLz7EETiyO8phHLpPvQifSVEfDvL6
         cRuktGczwxmGeZzNefKWHbIb2B3GVZd3i5XHgnY+Go1crSwQSwZiW8sfAu1c+ScvpwqT
         SW939a1UY+q+1lJsNlilvERSUwH/XQ5C2bFFNrXuMEfZfbsJMdCFJo14sLy0xx6xIY8u
         4TWA==
X-Gm-Message-State: AOAM533RRKAskfZ78XYg1cevxP6iE4jpIKvOa4RzylE+J7Aqt04nPx6j
        NmQnP1DuDzXmtHjF0emynxQMPw==
X-Google-Smtp-Source: ABdhPJyt9vTod+UDCk2pGBfXA7Fwnfz9KRZEatSExqgoqwWrNN3mNWIOnTbh1rN4qSEz0XR3SWzWbQ==
X-Received: by 2002:a17:90a:f0d1:: with SMTP id fa17mr10237309pjb.33.1629618694325;
        Sun, 22 Aug 2021 00:51:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6sm12184446pfa.44.2021.08.22.00.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 11/25] can: flexcan: Use struct_group() to zero struct flexcan_regs regions
Date:   Sun, 22 Aug 2021 00:51:08 -0700
Message-Id: <20210822075122.864511-12-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4830; h=from:subject; bh=EYs5XTkDgfX0dhdwidOdX6FaFsG9jCZLc3TTzjkErFE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH2bU8gotlTB34YXFJjHIXg8ae98vYx3WpQHASw gnthe4WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9gAKCRCJcvTf3G3AJgKqD/ 9Z4CfeQm+LlR9u2hdSRoxj0L/MvAvQco3KQnzJCSUqFfGSv8JXgqqrSAqqFi0GQy9HPotUyYNNuBCT 0faohp2vDaFgIpzrq584FH3bri2F3JHPAn6ArIQjeW+Va7NAkCpv54OzJ25AHXUt4gyBUDMWa+rjdK A17OTiRtnJAOb1rR7NpkbTsYlpgOB6eJIdEPgdRI154Qf+WhPj9FHP8w3yVBhkaRSMrErjDt6zAHM0 NpzmCJGZpIx5GxdHzUwljAJlS8voqeDUFrMXx2LAPCCfjSLfTCU2TJn5ATfagAAXRFHGdxfjOY69y6 10zGTtkt62/WKoV9X+uy4U8mKv/VS/snTNtU8OFEzk0oAjncL77p9y+bJDxk+z8YH1jdcyF5l8y8H5 s+aVfwd4c/d6/Rw8bJlFdLhJ8rhNU6gLTiWMt4BFAXufSfOvzLJB4IRI+n5hbEj5gX+Aqu9zP4Djrj 8+T6F6VgD3d2vuqyst82VvN9z95rClAZXQLHXPkBryN/cJj9w+rk0Z2VE99dFpmkfFKHq/Cwr8nIie BiqZ0LnnYj6IHTIvSU2pYNSQMsdxg9plh72HFQJyIMIF8e6eyRQGwnKo5HzvoQdpiuNEHpIcfy5xu4 JRrxjWp0GWNdjaU0q/j4j1I2xX20ilwf13nFMCMf/Bwgvz6D4oXTLmoTW5QQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark both regions of struct flexcan_regs that get
initialized to zero. Avoid the future warnings:

In function 'fortify_memset_chk',
    inlined from 'memset_io' at ./include/asm-generic/io.h:1169:2,
    inlined from 'flexcan_ram_init' at drivers/net/can/flexcan.c:1403:2:
./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  199 |    __write_overflow_field(p_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'fortify_memset_chk',
    inlined from 'memset_io' at ./include/asm-generic/io.h:1169:2,
    inlined from 'flexcan_ram_init' at drivers/net/can/flexcan.c:1408:3:
./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  199 |    __write_overflow_field(p_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/can/flexcan.c | 68 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 57f3635ad8d7..b1a261622b76 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -284,31 +284,33 @@ struct flexcan_regs {
 	u32 dbg1;		/* 0x58 */
 	u32 dbg2;		/* 0x5c */
 	u32 _reserved3[8];	/* 0x60 */
-	u8 mb[2][512];		/* 0x80 - Not affected by Soft Reset */
-	/* FIFO-mode:
-	 *			MB
-	 * 0x080...0x08f	0	RX message buffer
-	 * 0x090...0x0df	1-5	reserved
-	 * 0x0e0...0x0ff	6-7	8 entry ID table
-	 *				(mx25, mx28, mx35, mx53)
-	 * 0x0e0...0x2df	6-7..37	8..128 entry ID table
-	 *				size conf'ed via ctrl2::RFFN
-	 *				(mx6, vf610)
-	 */
-	u32 _reserved4[256];	/* 0x480 */
-	u32 rximr[64];		/* 0x880 - Not affected by Soft Reset */
-	u32 _reserved5[24];	/* 0x980 */
-	u32 gfwr_mx6;		/* 0x9e0 - MX6 */
-	u32 _reserved6[39];	/* 0x9e4 */
-	u32 _rxfir[6];		/* 0xa80 */
-	u32 _reserved8[2];	/* 0xa98 */
-	u32 _rxmgmask;		/* 0xaa0 */
-	u32 _rxfgmask;		/* 0xaa4 */
-	u32 _rx14mask;		/* 0xaa8 */
-	u32 _rx15mask;		/* 0xaac */
-	u32 tx_smb[4];		/* 0xab0 */
-	u32 rx_smb0[4];		/* 0xac0 */
-	u32 rx_smb1[4];		/* 0xad0 */
+	struct_group(init,
+		u8 mb[2][512];		/* 0x80 - Not affected by Soft Reset */
+		/* FIFO-mode:
+		 *			MB
+		 * 0x080...0x08f	0	RX message buffer
+		 * 0x090...0x0df	1-5	reserved
+		 * 0x0e0...0x0ff	6-7	8 entry ID table
+		 *				(mx25, mx28, mx35, mx53)
+		 * 0x0e0...0x2df	6-7..37	8..128 entry ID table
+		 *				size conf'ed via ctrl2::RFFN
+		 *				(mx6, vf610)
+		 */
+		u32 _reserved4[256];	/* 0x480 */
+		u32 rximr[64];		/* 0x880 - Not affected by Soft Reset */
+		u32 _reserved5[24];	/* 0x980 */
+		u32 gfwr_mx6;		/* 0x9e0 - MX6 */
+		u32 _reserved6[39];	/* 0x9e4 */
+		u32 _rxfir[6];		/* 0xa80 */
+		u32 _reserved8[2];	/* 0xa98 */
+		u32 _rxmgmask;		/* 0xaa0 */
+		u32 _rxfgmask;		/* 0xaa4 */
+		u32 _rx14mask;		/* 0xaa8 */
+		u32 _rx15mask;		/* 0xaac */
+		u32 tx_smb[4];		/* 0xab0 */
+		u32 rx_smb0[4];		/* 0xac0 */
+		u32 rx_smb1[4];		/* 0xad0 */
+	);
 	u32 mecr;		/* 0xae0 */
 	u32 erriar;		/* 0xae4 */
 	u32 erridpr;		/* 0xae8 */
@@ -322,9 +324,11 @@ struct flexcan_regs {
 	u32 fdcbt;		/* 0xc04 - Not affected by Soft Reset */
 	u32 fdcrc;		/* 0xc08 */
 	u32 _reserved9[199];	/* 0xc0c */
-	u32 tx_smb_fd[18];	/* 0xf28 */
-	u32 rx_smb0_fd[18];	/* 0xf70 */
-	u32 rx_smb1_fd[18];	/* 0xfb8 */
+	struct_group(init_fd,
+		u32 tx_smb_fd[18];	/* 0xf28 */
+		u32 rx_smb0_fd[18];	/* 0xf70 */
+		u32 rx_smb1_fd[18];	/* 0xfb8 */
+	);
 };
 
 static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18 + 0xfb8);
@@ -1379,14 +1383,10 @@ static void flexcan_ram_init(struct net_device *dev)
 	reg_ctrl2 |= FLEXCAN_CTRL2_WRMFRZ;
 	priv->write(reg_ctrl2, &regs->ctrl2);
 
-	memset_io(&regs->mb[0][0], 0,
-		  offsetof(struct flexcan_regs, rx_smb1[3]) -
-		  offsetof(struct flexcan_regs, mb[0][0]) + 0x4);
+	memset_io(&regs->init, 0, sizeof(regs->init));
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
-		memset_io(&regs->tx_smb_fd[0], 0,
-			  offsetof(struct flexcan_regs, rx_smb1_fd[17]) -
-			  offsetof(struct flexcan_regs, tx_smb_fd[0]) + 0x4);
+		memset_io(&regs->init_fd, 0, sizeof(regs->init_fd));
 
 	reg_ctrl2 &= ~FLEXCAN_CTRL2_WRMFRZ;
 	priv->write(reg_ctrl2, &regs->ctrl2);
-- 
2.30.2

