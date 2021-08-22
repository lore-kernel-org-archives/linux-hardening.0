Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D945CC4320A
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C265261220
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhHVHwj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhHVHwW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46551C06129D
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 18so12595276pfh.9
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWlzPq33px7me9bXqrWxCUNZOIwKVGghhiRcqTaUGwk=;
        b=gPfKFQMLVsihsWfwjKyXw8eKN9/LYpoy0BfXZWoZghZkjSHDycrMbJLsfQOu8JPnss
         5oj1cHiIsAZM/NfZGsJ2AXCzirKB9d/YsdpxdLXiEYF/rYG9XNJMfRiwQ2ttqAB4J/Q+
         Hm8rWmKxsQMwGnj6/9cjdRQnr8exjxqvMSF74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWlzPq33px7me9bXqrWxCUNZOIwKVGghhiRcqTaUGwk=;
        b=WZfbwjox6gMC/hfORtG3WBDRYdAopth8/RsPXeKHZmKMItDSAhZl+6MGsp3YlL78bI
         soS//nA4Qwcw4cFFadGLA7cfJ/aXFcVtrf819Nxl++AJa3xKBvHcm20L5f6qM9OlLGT/
         xWsgJX4bCDi8B4mvXscj9FV7N0L1MVnkCteLHjKN27gEQww/raHTOiEDJ9QJ36IDCYpG
         oShOzc3qNVsZhXSRRGDiEvylYmtiFcBwUmtE+/Ev+CRGWDvDsypg9hOXnnu+Lr765AXF
         VspULvPynxBdvrVJmE5/lWzlSVwj2EnJjDlo+K20neqGdEioN7TZpKkkK1VAEhjyseUC
         7TlQ==
X-Gm-Message-State: AOAM531OL+U5INerDtTe4hILIg3i+QdLaTFFZrHW1Kd5KN6SXXEgsjTG
        8E7r9D2CY9hBhjKqs1Zd2awG5Q==
X-Google-Smtp-Source: ABdhPJx57q7lBXa6cBxaT0JvGsCsoPZ0V/kpdx3Sk+Dify3+znHSnZYjDt6VLOgoka1ZVHTFRBe4pA==
X-Received: by 2002:aa7:8b07:0:b029:2f7:d38e:ff1 with SMTP id f7-20020aa78b070000b02902f7d38e0ff1mr28148090pfd.72.1629618694880;
        Sun, 22 Aug 2021 00:51:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u16sm14258530pgh.53.2021.08.22.00.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 12/25] cm4000_cs: Use struct_group() to zero struct cm4000_dev region
Date:   Sun, 22 Aug 2021 00:51:09 -0700
Message-Id: <20210822075122.864511-13-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; h=from:subject; bh=XJ28RbiAIR789pL5ljsQmPFQCzt2rgVz2fdwkdxbaR0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH3HlDUPx6be3rlUq/CBmzD2GRCw+0CR7NhVwWw 8Vye4qWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9wAKCRCJcvTf3G3AJqSCEA CNuY2IpYQBx1F7wrvsNNLEopI3m2kTyYLlZtyFsdUm0RGGoBGTywkyBaZO1Edtb4ub6+mqap/aC+SY 2XLyvuCP/jgpm2GALRblFBC48syM/wkzpRMyIo5uZiH54oJf1wwnCjziYmSRLy9OJKYBVj8v+XULQ7 5pgoTn2l8r3lJXYN+PiMNfeww55r6RqbkH+dstdLlUKBwAKur2lj2QVyo2Lm33540agIbJblyncbw9 fq5DGw3Pd/QKuqMIr6XY0skrLTZKRrQzDz+9tlvK6hJm5dSe2NNWEis+W3w9cQVdsrmwxkVNm7ltRk /4RxEsSDvAcw+Vo+KNnMCfkSHp/rxT8lH4l3r2fIpEYKeTUmRvgstPkAjDq58T6nMUR9CiknM9otPV Db14QqEoCl66o3zSZVMihxZd/6VD6NpjmZPHPEprnu2iMnrI5wYDuvqGPpLSQPzAbha9TlvdZy0/MA cFNEFw/QY6nfqTaq2F/HRvlGyaWXstyWj43f1BSgXxwtv5Sn6Ak7ffa8cyu6+/wU253ZxVPhpeRW+A zpMkcwOHeNEEnakTrphUTnKbHw1Xn6Nu/uvAa7K+ZToYKZsfnsArx+2X8DqPKc9y8wMzsdvpO1I06a wupH7l3GAS1uGYa+YmG+RtKpJTHWFEzVgeCqI4WmSAFwevXlrLkYhGA/Od+g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct cm4000_dev that should be
initialized to zero.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/lkml/YQDvxAofJlI1JoGZ@kroah.com
---
 drivers/char/pcmcia/cm4000_cs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 8f1bce0b4fe5..adaec8fd4b16 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -116,8 +116,9 @@ struct cm4000_dev {
 	wait_queue_head_t atrq;		/* wait for ATR valid */
 	wait_queue_head_t readq;	/* used by write to wake blk.read */
 
-	/* warning: do not move this fields.
+	/* warning: do not move this struct group.
 	 * initialising to zero depends on it - see ZERO_DEV below.  */
+	struct_group(init,
 	unsigned char atr_csum;
 	unsigned char atr_len_retry;
 	unsigned short atr_len;
@@ -140,12 +141,10 @@ struct cm4000_dev {
 
 	struct timer_list timer;	/* used to keep monitor running */
 	int monitor_running;
+	);
 };
 
-#define	ZERO_DEV(dev)  						\
-	memset(&dev->atr_csum,0,				\
-		sizeof(struct cm4000_dev) - 			\
-		offsetof(struct cm4000_dev, atr_csum))
+#define	ZERO_DEV(dev)	memset(&((dev)->init), 0, sizeof((dev)->init))
 
 static struct pcmcia_device *dev_table[CM4000_MAX_DEV];
 static struct class *cmm_class;
-- 
2.30.2

