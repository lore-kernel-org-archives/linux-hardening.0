Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007544465
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:52:38 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FEE212E
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c59c40b840so23184775ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405137; x=1696009937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vS2A/5dfe44fdutyd/MiPveuUUECUoSz6xv9hgdL9I=;
        b=bfUHz6XXRnRpJEF46ZA5PC9vA+b6e8q+KZKP6DUcV7gI70h1CVN2NRwC39WnNjjRzq
         BMALG3hLjRB2MxHR9CJY4G1R7iDgFRVFoO7hP2Klo1xB7q9zGYOiFRo8Z7XuaC78DLq2
         1RKl9cBmQkXVeuT4dOUy7LL3jo8oJ8XAcZ4wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405137; x=1696009937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vS2A/5dfe44fdutyd/MiPveuUUECUoSz6xv9hgdL9I=;
        b=NNkibyOutDsJmtKdb4xypXi97hf0on8vVwql9DjbQCM9PmyVYkqNk8/Of/dBEVQcyq
         JIiTiCHBZh6hbhe34vxQXXMRYkaCr+kGFU1TfqkCPRmcZLLC1X59pwrBIFUgcgB6bF0d
         pbZ89nzCGU9x9UdWRGKyFc7Lc1JBAXB59oq+bqCRHkGWIttbK4jk3zRvHeegSeV4G2JV
         RA2zyweX8ypSbQHm2mbaHQuWnM31r+ICy9NK86TrYODKM4FHzeLLyOCIN7ho1RcdDpFB
         kSo4w+4f7U63PpxOqMKrY4xduR9FIHwTy2GsZPxFub5Kb2kp4D0GdLSTjbtywjg6bAHJ
         Mtng==
X-Gm-Message-State: AOJu0YyhL5VJCte2Sy6wVAOaZl+y4OE8QR0SYU3eoWLAuWHhpfrCgXLn
	zPWgZ1TOsyNBXkgXXwCHJSN3vw==
X-Google-Smtp-Source: AGHT+IFPIMsBddESEV+xOT00BhEEOms1XoGEZoRj82rSsZ2HtFooQgjZAAkVZk20RkrZp+QDDYHM1w==
X-Received: by 2002:a17:902:8649:b0:1bc:6c8:cded with SMTP id y9-20020a170902864900b001bc06c8cdedmr113191plt.67.1695405137609;
        Fri, 22 Sep 2023 10:52:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001bba3650448sm3770726plk.258.2023.09.22.10.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:17 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kees Cook <keescook@chromium.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] memory: atmel-ebi: Annotate struct atmel_ebi_dev with __counted_by
Date: Fri, 22 Sep 2023 10:52:15 -0700
Message-Id: <20230922175215.work.122-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=keescook@chromium.org;
 h=from:subject:message-id; bh=F2UmaICz1ZTVLb3quzX04fcrOpSbHmBx25EYuMmk16s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRP0nnZBp76GGrjxSd3FerVZS4q3b8aU5/c2
 uN1YtxC8fOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UTwAKCRCJcvTf3G3A
 Jo+7EAChYPLRXO7X9nu9DEjWcNXCDEwK+/GRj855SWig73fP9fl2tV2PrcgDrC5LYyxuBpgGKYn
 x4Q6Vq+o80FOTdfMfJbZmmT9UVRojn1JY/y2UpRhEL475+ARS+IMf2fb1hO1bra2VPZhwfr1Rcc
 BN/3E75dldOHjy86D3B1SuSaRBATOQj7ZY/ID0Dnc3n2z4EQPF7jhXBNwA25DA8N37VdWsD8N/l
 F77FKDmnqOoQIFQS/wwyACE5Ivl1tkyB6RoXD2AU7TGDa0CnKZ0JCHSQn178K5DMd1xZEgBIIju
 s5EvBmv8TrzTpG88MwGp/gxEuotr23xn48cm5svdgl393nGbJZokdzrRQxaD4oiUKirMfZuqRHl
 vlG4rbuP6U8HsBAcNCFI6xo//gccjTSMdDTqtRi4cCfgJPuwHnJQ+J3EffL067Z48pDPdS6DJZ4
 Eoq+pEGY8sPX/NAwFYJ+J7W8juJKWxNi544rahU5/6+QdjHnD48mVdG0DsFTEPA8fEzGqwD4Fir
 KH1cMmB7Ig96TfJWl1Rw85uRglKKFjrH9MuH+6XGXCypjqlo7KWHPKhHZcP2ty0rYKVGM2OW7fr
 e3h0Pkk2ZUbrUha6RZ5apKyCesPgWEbSt09RtpcJwGa0yrORQW80+5zJ4vghwfJKtnyucqa73g6
 z/RJ3ag hxTiMUUA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct atmel_ebi_dev.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/memory/atmel-ebi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 635966d705cb..ec6100bc94c5 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -30,7 +30,7 @@ struct atmel_ebi_dev {
 	struct atmel_ebi *ebi;
 	u32 mode;
 	int numcs;
-	struct atmel_ebi_dev_config configs[];
+	struct atmel_ebi_dev_config configs[] __counted_by(numcs);
 };
 
 struct atmel_ebi_caps {
-- 
2.34.1

