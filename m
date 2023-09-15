Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B81FCD37AF
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbjIOUOH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbjIOUNk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6352D50
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c43b4b02c1so7445155ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808771; x=1695413571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0w8YyWBkyxxpFXFEsJXWeSdcXhaKX7qg2CNvqyy5fgg=;
        b=RyDAX7ACq5A92wSogwHmcvX3MKIc9KfQi0TZijDBgFjz2xT/h3BIZBqMAmzR4D2i6Y
         C/UJWt2DcZ7/vFrTfxp32PyUoOKV9vpq04fYLUeDvmk44vQDsqM0W3dv4qNPbgT9uVtU
         CfSdr2ZMBv/oIeEMbskzmmep/TqGctkGhQJDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808771; x=1695413571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0w8YyWBkyxxpFXFEsJXWeSdcXhaKX7qg2CNvqyy5fgg=;
        b=YWHpJVy5TMmQBn5HkDwpkrRcULSd7ToXj7qGixSuk6uv7hZWJonf8ZzLMmbxgwOmj4
         vzEAAN+VwDfbT89BFW0W5ztY4UAFMiv3sj8jHMTtYhosKjYxVo0VBpm0E3MtMqSF9/TJ
         zD9TibfD3APC8+D99OJJGV7889hoZJmkLSQ+vPp9EyXsfhUk3inx2WQKoah6j3OJhIga
         RVs7nnfjEoyYcRT1172HhjTv9llFbJ9zPIGQB+q8FAIvq48fG3ZNvZ30FpHLiUjrO3Ky
         OUNaXPhW6EW3IixSa65TWbDhph8tkKVr45LZfzGWYusJLnOm22N/kuZXiE0sBHjxkG3p
         usIA==
X-Gm-Message-State: AOJu0Yx1IhYyskYllMqIq836akHxTVZQqOm9vTUyy4aAAQBICXRhOPeh
        YRkB50wbw8/D3VKe9+/J/FKQnw==
X-Google-Smtp-Source: AGHT+IGEP+XX4TcWFwL6riCxf7EV59zw6/4+xl/jX5TKVK+vuyzRqiTZSZ3ZHUIdArWZJdh1HlOnLQ==
X-Received: by 2002:a17:902:ecc5:b0:1bf:13a7:d3ef with SMTP id a5-20020a170902ecc500b001bf13a7d3efmr3048022plh.66.1694808771246;
        Fri, 15 Sep 2023 13:12:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b001bd41b70b65sm3864242plo.49.2023.09.15.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: meson: Annotate struct meson_nfc_nand_chip with __counted_by
Date:   Fri, 15 Sep 2023 13:12:49 -0700
Message-Id: <20230915201249.never.509-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=keescook@chromium.org;
 h=from:subject:message-id; bh=viN3aFTUGlYqsHbJQcNa6oOS8nJqeFdRFpqtC0E5D+8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLrBAAO11BUsQ+oKxBzlepi1zMsCl8lRLHvB4
 qk/2KM3zKKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6wQAKCRCJcvTf3G3A
 JtFUD/4hfU9qPge0NwGnOrmrFpYmEsF1rZXGB7tjkgsjW4R11jE9il/8UIN9g8stacwGCBzLUSS
 mH+V4qUpwjDF0Vgztzj5EOz7jL0SUK05t+kAfxhir1eu+TnBxzScuL5kBFOGrCgttmRtseZC1QI
 W+9JjUA8xzBc0eX1m4eYJ0HXcBky9b9mgpiVTgrh5ZL5aFlaEXos2XiL4dRwbR5e72Zb3wUCnDv
 yMj9FU25KEJUcfcKLFE5fwvgnTk4zYKoVa001Mc8YJgJAxBrKtX9htMtzaR4HmBK4KEEkMnMehB
 HVDtcTnjsrQ7AmRrkuLkAj1Bah6SCH5LQEhEg0xmyLSD4csxgBeBSJ4a6wbKdwMAzkIbm1o5ACt
 NqIVZYqLASf787XFgOE8PA+1FJHr9EnDESUCgjWz64KdBIhs4l2CJyA6id6v3XYLU5vzdkJrAqK
 HJfrvwTc7Bg2Vs1RoOyXRXGcdwYb4stM2Vp0f7BGUhvRDk5F+Vh6M80kPxS/rJwv+KWuAeCipEw
 RWcbhpHBVe4oPJ/HWaMDO+RcXNJscIUwz7fU3UMhLSggbkK/h4czEGJTOmpoOncxQK921laWWKB
 59G8tSqmjF3lRjjxBh3wvyKvp8D/Fiu7/pHROejMOREf89AymCCZDQtmwn6ug7Eu9gcc3qEKHQm
 gzt6Re4 SCuWvuVA==
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

As found with Coccinelle[1], add __counted_by for struct meson_nfc_nand_chip.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Liang Yang <liang.yang@amlogic.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/meson_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 25e3c1cb605e..378f28ce6a74 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -128,7 +128,7 @@ struct meson_nfc_nand_chip {
 	u8 *data_buf;
 	__le64 *info_buf;
 	u32 nsels;
-	u8 sels[];
+	u8 sels[] __counted_by(nsels);
 };
 
 struct meson_nand_ecc {
-- 
2.34.1

