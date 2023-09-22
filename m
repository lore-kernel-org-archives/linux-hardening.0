Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF243ABD
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:52:27 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4666EE62
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578a6bb11ecso1893715a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405129; x=1696009929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpqiqZm2BGAxLAQ6OdHDPuq752RxFysRxRW91bm8OjQ=;
        b=DPx9UYnVDmAgv087WLH2OS4ffv1QZPJ26HCnjx7aLlOqShPOIqKp/u+i40F6pJjiFz
         PP3I9l907MsAiOKsC0GZGDToJFT+lDJCAD5C2KNTeDStcmpiX1Uxm43rHpr5MaHAskUP
         iIHd9E7rr7m5+zWJmKZQN1dM4wqgCj9EYZIlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405129; x=1696009929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpqiqZm2BGAxLAQ6OdHDPuq752RxFysRxRW91bm8OjQ=;
        b=qfYDYo7VBHaVwU67i0LXlvs8Sr1/3Omo/wRLG55CFsCCBmlpj1HX3r/bQ/DjP6Q2br
         hHXbSAhBkFiVfJYUOOCxJ6L4K5+dN/PwEuG+oMK8Vr0yV8dr6ifpKZnP0gjiqGVQTbRZ
         vNFrjceH9+npCQur4y4EFsZmuhNtkQJSsvx2nc31wQoABSLZGIgNBGN6138qHguAxXXR
         /WiWiQaKVIQlltT7pc3jTj6W4gTXtkEEzVAWa3t56HQ9EDC2ik/zyh/O37ZRfk+gTtWT
         Fn9TlRXQpmak6YcO/czAgJIHOnkw8aXPDYzmBPF3VCtD5gqwDDQaPiTrEI0VZpDXofne
         0FdQ==
X-Gm-Message-State: AOJu0YwqPjGXZVSmcdYMX07Xfn9O2vnZvcHpjotrv+8iGUVe1BzKyF/Q
	1VI/SeihZVRhJk9CnxF+wZOD3A==
X-Google-Smtp-Source: AGHT+IGxfNPicAEJhdDWx4Ql68n4egqT6i6RZ0S8ScwK1faDEmQciRT0Gd57r8K+JlrUvwVe+I6JqQ==
X-Received: by 2002:a17:90a:608f:b0:274:729a:bcd9 with SMTP id z15-20020a17090a608f00b00274729abcd9mr366502pji.43.1695405129127;
        Fri, 22 Sep 2023 10:52:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ne10-20020a17090b374a00b00277246e857esm8872pjb.23.2023.09.22.10.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:08 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Support Opensource <support.opensource@diasemi.com>
Cc: Kees Cook <keescook@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] regulator: da9063: Annotate struct da9063_regulators with __counted_by
Date: Fri, 22 Sep 2023 10:52:07 -0700
Message-Id: <20230922175207.work.576-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ZdGIk5VtLtTn1AcHf5ktUG4eqSdrMBwaMfBOFKHGDSk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRHsC8woGcucLGBBK/2VeJ7ydLTnSW6b+X8+
 p9ed/qBYhOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3URwAKCRCJcvTf3G3A
 Jn0UEACoNbrcfq2k9xjIrqekuseq4tGHpvnrzKgvzV7tiw61SxQF7JunIspuLs34jo63kYlHjez
 1maQE9Str8/eS26qLtM9+nfNH6FOgg7Qj150jrfYP87hwcjl43SORasxhYVZXPuS+KOcuUzgfEk
 BVt3U8+FkMOUUFCVi45OGumu/OwdfCwbbgb3CsAgqqjvWSMSpOu7tYzU3EhgRqbShtFEDI6mm/v
 hWvfASughriswZRRdh0lC9e577cdfeF5JKFdG3L+gXUeZSPiM81UCPkeGUrzkmlOUOpyb8+hLsr
 JP0ed3mZMjQgKXbKIwfyakVvTx0q4vTdF7B5v2p4I1j9LDriQm6Lp3v9XQ9+coKktG/ddH2KZ8J
 YAo5je8kcvHcsk7WZYj9u+WgoIoZJAXMKE/gsjuiYFJuSRfcxOnKIbgCnCrlQPw2SzI9/j1Vvg0
 4eKpA4lwuCNH+bJSIEvBI5+jvJT6FlaAgKqPGyQzEcln1to1DFWoCfm2I1AjGMmNdyOrLha2OGQ
 kcov3mwlkJR8+q6XW3dwBE0JuRcEAvWpzBV8IH3m179Z3qQO3tpypI5E4KseKxmjYPHBRWKJOTK
 40hQpD9foa4kSVvbWRIJCX7+4fQBODbBI5GX0WvmZEQxrmfxA12ST36l0nUPbBi5n56UrE8tiiP
 7ewlZXF sf7w5Cfg==
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

As found with Coccinelle[1], add __counted_by for struct da9063_regulators.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/regulator/da9063-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index a0621665a6d2..82bf321ae06f 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -158,7 +158,7 @@ struct da9063_regulator {
 struct da9063_regulators {
 	unsigned int				n_regulators;
 	/* Array size to be defined during init. Keep at end. */
-	struct da9063_regulator			regulator[];
+	struct da9063_regulator			regulator[] __counted_by(n_regulators);
 };
 
 /* BUCK modes for DA9063 */
-- 
2.34.1

