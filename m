Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7300DC46CA1
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbjIOUNe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjIOUNZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B3630C6
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fbbea0dfeso2143226b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808750; x=1695413550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1ORwL4JwevQxgf11GzdpKoTIBTsgU2jnKyI5O4kARU=;
        b=W6Jqsr4dx+9c054Hceh9tFCoJI6Kjkr2XSrSJ6/7bEdWy2mfbvNoyg3BTkG79CVYLB
         2xY9Pap3K77Ir/BHZmd/zcZ44miyqnuBU6J3TTzOOb/dpWSLMwYGlVtpWfpIvwEnNuYW
         GBNE64FficKr/66D6jaAdJP2zrLfpnJ1EFGzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808750; x=1695413550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1ORwL4JwevQxgf11GzdpKoTIBTsgU2jnKyI5O4kARU=;
        b=tns9iucKOK2xLSSDsjL40FMeyTaA/gvsEK2gBsl5oFPKE9viVGs1qPZZUTxkOoblb2
         MaV7EVFeUCu1ywAAqnPRTTELuZCC85tFgem2fg/Y3nJyOKePlwermUB7Mgi7MB27Sgqk
         ekXpvQcS6yGADWWizK1XZ2db8p/sM+ohCPiWTtPW/pSziyceiDkO5Pe3Xyz0tIPPfwkR
         xkxLHvjENbRO6SIkuSFNs2bGwwtVqaLq3su3VnuFcbbEghjtj2tTiP8eebTMl6sLF85n
         DZjIq7tL0R/kEV/znw5g+3F1hm9NH+IdgpsHdNZRUwakct4MgNjjk+7hEC8J7sxR0qEV
         oLww==
X-Gm-Message-State: AOJu0YxLADXDMn6VlUza9b02bQkWygikef1U9/bUmm+WKUpjHd4VtD9V
        70s8W34v7Vhso5/BSOgBIGJrcQ==
X-Google-Smtp-Source: AGHT+IGM69XeyMqXrJENXIIbK0AJFt00kniNdSM5fG+ubnbAoFnmRMBQxlen4CPemfd4BQw4M58I3A==
X-Received: by 2002:a05:6a00:22ce:b0:68e:2cf2:1613 with SMTP id f14-20020a056a0022ce00b0068e2cf21613mr3157316pfj.3.1694808749928;
        Fri, 15 Sep 2023 13:12:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7850e000000b00682c864f35bsm3433733pfn.140.2023.09.15.13.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: denali: Annotate struct denali_chip with __counted_by
Date:   Fri, 15 Sep 2023 13:12:28 -0700
Message-Id: <20230915201227.never.483-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=keescook@chromium.org;
 h=from:subject:message-id; bh=HPftxSeIdfi4GNcmfYxSI30gQxrnfduSUhsbK/q4I2U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLqrBhnZOaQvbWWLFylIXxeEofmGqQfAApeF0
 9Efh0UjrZ+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6qwAKCRCJcvTf3G3A
 Juq0EAC1p8IKMh8ULf/+9eqSBMFztVKVRNhwH84rJGBubRqa9GmRqG9lJA7HsGhBtR+V+fxtD32
 aZqVfOA9y1Z9LppySZJxzizv01l84QfPm4/2t+Z6lFiJsmAsrSfnLhKi+4RtQgh/ftLa7YFffLk
 DHuuIKIAr+KyklVs9AVhAsQa4PCcANGLyCFK8hImwQQcjhzFhdPLkAwiF4lF5nX9W6Ph/MgtwdG
 zuc4D9tgk1+sUx9keYPl/Q5y7CJOh98r7YuhmgOI5jFo5tGDPtsT5q1JIuXKyIFZktCSc1ZTEIY
 rcFm8dhnnPjfekYmEhvgLkk5F0V9B5sZRpWoRfVctss6CF4CsZTwyEg2FyE3uwdD9Wf1ltQvV82
 wjMq4iftY52seKEp3LGSC5l0D9FbQim2DxswJ4uvsGRT2wPtMXtt0wDgtXR5g9s89pJ9ivLoJMR
 PbNoWJx0vydQXRqqtjv5uI0YdmQ/vBrFSMHF3UwdwPoEdIx2WTk4DephZgfErE3HEzwEEBfa5+z
 apHYb19IwNM3IQ/5LAZm0UrxW8gMt0rwV5Tna98A/fk7W7OntvQEEsHZWKl+Ve3+4Z+drf2kUSA
 a0SDFp8ERUWM1k583PrxiuMXYrA5doWz1lHk5TI+q/wpsU0abnhFZBJk5QtqN/L+ZGsIrQNhKiu
 cL+/10l bmZkd82g==
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

As found with Coccinelle[1], add __counted_by for struct denali_chip.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/denali.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
index ac46eb7956ce..5f2fab022fc5 100644
--- a/drivers/mtd/nand/raw/denali.h
+++ b/drivers/mtd/nand/raw/denali.h
@@ -328,7 +328,7 @@ struct denali_chip {
 	struct nand_chip chip;
 	struct list_head node;
 	unsigned int nsels;
-	struct denali_chip_sel sels[];
+	struct denali_chip_sel sels[] __counted_by(nsels);
 };
 
 /**
-- 
2.34.1

