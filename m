Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE82CD37A7
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbjIOUNd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbjIOUNQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA042D6D
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fb2e9ebbfso2122302b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808742; x=1695413542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbgir45P8c3Pig3O82d5C6ZtsdrQshUxHqzUl7LRBJ8=;
        b=JnSLagM2GJ/sivdTHmyoopz72F+W5Iem9lwet38/5o8TTRnue6roVp6C2v2YvVMq2L
         6gwOK4CPBIY77WwXwSCb7T1Fzqsel1doLmTZVmOELiplWOqlcwgO8Y4nepFndJMAwDTd
         wBwVSrNxI+jpXiegtIJp7i5q44KX1Yw/IDdbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808742; x=1695413542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbgir45P8c3Pig3O82d5C6ZtsdrQshUxHqzUl7LRBJ8=;
        b=dqS0vLbivju9njeDf53aIfDxa4CXUzPbDl5YTxekeE5F7onUn0yyIvR3P8a3hoIxXZ
         SLqaGq6QnDR/tvYIXR2waeAbz5RcIT74StrO5hRGCyTRORLIOn3hj6mHK1u5pyUpEyj2
         woGnCAr9nyg7bAnoGE9POUTP7kIIhLP6ZfP1WpLiUTHxqICRN/ZIJp8HXY1H0zQXhdiH
         DalnjArSVKbAWbMwJ3DWQ9JMvSok9PZfJD2dtMs/n6lS7LRNU4Nt6FA21+fWtHI2+v8Z
         9EBhLBZ1IE8NBNpr1ZblZUoRlr9iV8bWNGwucjNaWSKvC7APdtdflr3jPgBa18izrmWY
         W0Ug==
X-Gm-Message-State: AOJu0Ywp5ytWBbp+xor//95HZFU02oZhVCe6M4DVl7vaP4FOsGwo0n/O
        wXjV0FM3zBxluKkmnglb5wIBMQ==
X-Google-Smtp-Source: AGHT+IFhBgyUlPiD5xyzulG3JBRm1U+iu40tZkfPFsrc4zrlynDTyADHna0tENdTjWY4mEIPQKAfVA==
X-Received: by 2002:a05:6a20:160e:b0:14b:887a:6d70 with SMTP id l14-20020a056a20160e00b0014b887a6d70mr3499753pzj.15.1694808742247;
        Fri, 15 Sep 2023 13:12:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a21-20020a62e215000000b0068c6e666066sm3327765pfi.111.2023.09.15.13.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: atmel: Annotate struct atmel_nand with __counted_by
Date:   Fri, 15 Sep 2023 13:12:20 -0700
Message-Id: <20230915201219.never.352-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Tdr7pAr2Wb4/8w/gmPSQOqizdA4eTmvQlqS8OoRKddg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLqkv2XZPgk3DLyZFw3FAR71jSeYJBJnbdcTE
 k2PsyMAmBKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6pAAKCRCJcvTf3G3A
 JoNrD/9bXYCBxADrZNHe5KYuXZa2MpAe6bX4jbfGcBcOh/Ugaq5DHdiRZ1029txqS953Eg+J7pJ
 4a2Ae0PAfgHBWg+DTNZgpFuZdZVjmmA+C2Jek1oRG9j1sOPzK5g3dEKzqM0T3SCSG9ltaBGAaXB
 4mJ4oJVZsywrSPmpnBsHloni/CITMF65he+pl9MzG+gt8XiGtiVO9x82Ja5P+VDx3HnlQtkfvwJ
 uiZaJb0o3mZArnjWMPTMzx5Vr8FDd1RgiqgfdCuANBN9rBs4ZPZKbqK6dHz3KMLFxw34Vs9g5DW
 QL1OeYO/nsO9COQqGEG+Eju7ASKKedTGsFLqzdxxeORZre7+qJJkxSs/UcA8DHWkYS/HpZtvLtF
 BSBdlZHteJ/HlYfTPTWd/jIBjFsSdRUkKzIgDb4BPhSyHbrZ0jKOCs79l2Fk9mhZ+7DpLh83VpG
 lnaDwD5gbMFG6RFosKr+j2LMBNcqtLSNBJC57ZcgvECQNgGy3oFq+m0Mne3Sg68G3TnakTjFtI0
 lFmUUvubrfVj6jPZfm113wYcvENBIVGjC59zqFpg4AUbAOpULsLLbf4ihMaxOXG2yCI6Nb8bnRT
 tUygiBi5+DcAgoQCg4tO393PtyIKRx54A5CsFCeC8iCVwKqdd+FnSBzCCQOZkxU93X7wLijiaWp
 EOhkDTw GDHW+fKw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct atmel_nand.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 3f494f7c7ecb..4cb478bbee4a 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -165,7 +165,7 @@ struct atmel_nand {
 	struct atmel_pmecc_user *pmecc;
 	struct gpio_desc *cdgpio;
 	int numcs;
-	struct atmel_nand_cs cs[];
+	struct atmel_nand_cs cs[] __counted_by(numcs);
 };
 
 static inline struct atmel_nand *to_atmel_nand(struct nand_chip *chip)
-- 
2.34.1

