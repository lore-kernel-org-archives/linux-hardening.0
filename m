Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361244495
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:55:47 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D001F04
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:53:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bd59322dso2024856b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405213; x=1696010013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1DuAf/+ZW6v7oQmMqiRSnBOde6Jc28Je383H2K4ozI=;
        b=eFZseXVf3N54HDMPfBZVTq8gxWB33isNnuzfv0E4vdm6Bgy9ZXBdWX7Df5t37kQWVl
         f9xEpdadh/mbflQhfemsXRjKD7WuKpeGqS5ttW0wB6c/SP4kC504N9Yy+Gxhi9FYJqnD
         IwW8y+vf6iVyDLUA2klcdt+JGTqP1ZanCXJoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405213; x=1696010013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1DuAf/+ZW6v7oQmMqiRSnBOde6Jc28Je383H2K4ozI=;
        b=obDxOc1zN6G23kHVCPCMg+6hXyvPYl1K/XlE8i2wf7yaCa4GunJmKuIEc7d7vtCyhD
         YyjDc43rT0vnXwGSO28JVowhkCUrjQpnL8yf3vtkmANJsv4Nv2XRwZX8bYsCoi4wggVT
         0LCvuCFtsMh1gbCht6cOhWvUTT0WQHzzAQ1W9VXYA8bcHIDxycIo51pUsUG4PJ3Wxywe
         kJBiPm+VKlit8I6C43ZzjGpI+9sEGZjikE4q1XhYL9UB2THU0341e0Cs8haPx6ER/xH+
         NMM+srXOdpPW5zp/hEvGuRztshEyLyTm8AT5y7pd3+NgUFY/WwouINQIVGve1Nv7ZfgI
         seaw==
X-Gm-Message-State: AOJu0YwVujWz5tFTGJ0+tfqerIaiyDRmr2C6dauLDBnosMHrb+uBBEsB
	cVbipysYoL5LTmDS1njMx9VCSg==
X-Google-Smtp-Source: AGHT+IFXuq8R136xW5nVqkU1923m0VVoi8A+AfdyU6CNk0S0T0wMiLniXuESANSpe0yEyArZHXB0TQ==
X-Received: by 2002:a05:6a00:1ac9:b0:690:c1e5:937e with SMTP id f9-20020a056a001ac900b00690c1e5937emr140303pfv.13.1695405212835;
        Fri, 22 Sep 2023 10:53:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x25-20020a62fb19000000b006889081281bsm3434175pfm.138.2023.09.22.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:32 -0700 (PDT)
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
Subject: [PATCH] regulator: da9062: Annotate struct da9062_regulators with __counted_by
Date: Fri, 22 Sep 2023 10:53:31 -0700
Message-Id: <20230922175330.work.066-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=keescook@chromium.org;
 h=from:subject:message-id; bh=jyjltd9IGcWvOg910fwXOz2T1bioU2VSJx7SDglJoh4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSbKq2clcu9Od4D1cu0Gb37wvavMtZYXO0ui
 +p2R9xoGOaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UmwAKCRCJcvTf3G3A
 Jhe6D/0T4QS0EkQ2zac2mAd9FiPbgfHmVh7ksYNRfnLOFwWHQ2OKYTrlpZ4DlKKed6BR/5EGsHM
 PLvNIlPwb6qlX5en77saxlwegJJdG6/Zu0Z28nQ9q2jQooHTLdjGFIAkohpGXx7M6TRqWWaJbKM
 LLYWoOv/xnvAih0XvHN3aSbp/Sw7x8P9GmDOpK1S33ArIsPL3qh6DiYppwS7PAOl54GHR1w6dJs
 6LfowXTPErRdxa3jYFmyba0DB3T5C42AwH55S3NI14xWiRTT3gt4G43i3QV071LUgzWdSwIJlPB
 sH8pVJ2gQIenwfsxWs5lcjlxGYO+znS0K+DCQzFjJPBSLXkJXfBOc+FKRE2tb8FsubbGJGGlThc
 zEomQvNHUJtMW1MT5XNMF2+M9i1LE4ljJh8n/UKr01gCynJCW0wULsrCTc8xdq4wlVTUK0tYaos
 7EyN4lSEzHG9OCqm2vZ6KCKPkBiUZv/WI0dWvn4GEZPwDhc8ZiERFJlfgiEyW+Pd2XVNmCFOGlS
 XbOqvWlu9gaL7C1niB1AZmyE2LU39p93sqhuCQrOYWEJRk86PluoJ7cmk1vpi4OPJJo1oQZ8Mik
 ZEoaKsT8ewvGg01yU7Cdf5vF4Z8Cfp3xS1JGFZc8UCpslNWVvCDqvpTajtGEuxA7B4wCJwz37Gb
 uAmi8qe frPhTiOA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct da9062_regulators.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/regulator/da9062-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 1d354db0c1bd..e0c96f10e570 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -73,7 +73,7 @@ struct da9062_regulators {
 	int					irq_ldo_lim;
 	unsigned				n_regulators;
 	/* Array size to be defined during init. Keep at end. */
-	struct da9062_regulator			regulator[];
+	struct da9062_regulator			regulator[] __counted_by(n_regulators);
 };
 
 /* Regulator operations */
-- 
2.34.1

