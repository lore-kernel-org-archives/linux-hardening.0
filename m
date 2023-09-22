Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276CE436B8
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:51:05 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94598CC7
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso2264702b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405052; x=1696009852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3oEkxAEP7bGPEZ+qBOxMzwux9ypcm6j3kmlQze2cxoU=;
        b=iXWPa6zf+GsCL5VuchZLiIXa5IsI9fxJp8AEvCjVS8cyShhjJ85kKl6KLUwIWAv8X4
         Km8CIYeAdsZtR218HFwmqkVf7V+AvgC7l9jryz1q1sEAmBamuLJ+lHoF205gfklOVh1/
         GZfvmTbl2PQy4WW3F5LvzM5kCobc78IBN3zzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405052; x=1696009852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3oEkxAEP7bGPEZ+qBOxMzwux9ypcm6j3kmlQze2cxoU=;
        b=e4QdGDBoxDAbr+RoeZJ04iqAeBZ6tptqEbNn7oMtzgQD3BMTNySbEvO4B9006B2WPs
         ++vGmuQV7G1alSQVU5z7xSjncWV6eNvgLGZb/eygmxVhWuRhmyqCrLPfDz4aGtSZiDU+
         Cvx26CtTfZ7ZsX6mfOHzkgyqylVfupHeZLAac93Wgtnl4b8zhk5Rx/uXyQ2mN2ICs/4d
         XuGYSvrCskbU+xKcRkfgdCBYi2wjvLAH/eKcm9kgptrDIjtFtWR27zYS3cbW/H5xGUwi
         TY9HL/yCF8FUri2yu5a9dxEvKUbHqMLvE41d3sJRO74cFeuGFcKSkAkLTUmiNODERSZC
         xtQQ==
X-Gm-Message-State: AOJu0Yy8Ybu3FrTy1nKTKFdTFtvcFDQDmZPwcI6dYhYoFfQuCHNfEkK2
	J7suwhtvuTRL9slfj258nZL3IQ==
X-Google-Smtp-Source: AGHT+IEjIxVG8g4i5F7jtY8rsnOQ8bukvGhYoHuCsgCOuo++tH0bwxcSf5hGt6Xn7RmONgTG1ZnFfA==
X-Received: by 2002:a05:6a00:2d0b:b0:68e:2d9d:b0cc with SMTP id fa11-20020a056a002d0b00b0068e2d9db0ccmr170192pfb.6.1695405052057;
        Fri, 22 Sep 2023 10:50:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020a62fb12000000b0068fe6ad4e18sm3484364pfm.157.2023.09.22.10.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:51 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: Kees Cook <keescook@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev,
	alsa-devel@alsa-project.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ASoC: apple: mca: Annotate struct mca_data with __counted_by
Date: Fri, 22 Sep 2023 10:50:50 -0700
Message-Id: <20230922175050.work.819-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=keescook@chromium.org;
 h=from:subject:message-id; bh=j4yqmKRzUCzvjLbfaqNFg/RfKie7KU/QXR2i1mhhyZg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdP657tnli5eAN/8roOFU78C7eb8FJ8g94j9+
 W70ZL/MvxiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T+gAKCRCJcvTf3G3A
 JhkwEACoXPDQbe9ClOALZy20QDUufFBZZdIyVDd7vsffjD0NADca1ZAdJibsqdbv0WoKOHbe7dg
 F8Qn9PbceKIap9s4b67hMoSvLv/sRH+NJCuoMirhWdpYRQguwiegMtsMUFcYpoZbJxhsugsZe9t
 DK+ZzfTvFpFasQA9noJDlpzCnqoAk40oyu7hfxITKafl8jzz2KF54cvC9Ou9KHC06x/dfuyUh3Z
 +cmap5XZ3PqL5al8/8bcWjwRep86fpLPje6ZowtIA8Xz6rF7RHkhB8rzFhH6PM2GYovTHn0sJpI
 +pM58i4vueNt/36/5tWQf7yEhHUKyebeEHhEMsMRopJ0EYttF2K4LrdNc0UD/GHQZfvXr3pJ3TB
 vspNBhikEwP/27a3H+GMjqo6WIjzMyesedSKO1UvQRx/Sb9Z06KQfe3crNNJQS6alyp2TzjbfQy
 5gN8LH2Zy5ftPZWfWKFD/E4LWcSC+j6ATdxgH6xHRu/HZYAYHNAriuf8cp5wbT2hhPy36aGjuBq
 Qpw2w7PeKkGdpUHShbLmHqpy7JVnuKcdJ2I7b7BjXcQxlx0jahM77cytS0CSOqHHMpQRiVYQ+W8
 0zmAS/02v7hvny2scuMrpPhpW1fuR7xhIcXejJX0R3d1NNsYsRZ8qVoiJEvRSdm53xxORkZWxEE
 +bzZBeY tCA1uhOQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mca_data.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "Martin Povišer" <povik+lin@cutebit.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/soc/apple/mca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index ce77934f3eef..99e547ef95e6 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -161,7 +161,7 @@ struct mca_data {
 	struct mutex port_mutex;
 
 	int nclusters;
-	struct mca_cluster clusters[];
+	struct mca_cluster clusters[] __counted_by(nclusters);
 };
 
 static void mca_modify(struct mca_cluster *cl, int regoffset, u32 mask, u32 val)
-- 
2.34.1

