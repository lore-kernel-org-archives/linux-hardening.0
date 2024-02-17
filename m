Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD61C291
	for <linux-hardening@vger.kernel.org>; Sat, 17 Feb 2024 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145620; cv=none; b=ZaSYDkSk/fyaYXHh6HML1oC7Bkq2no7WZjcs5zgHvSWD4BUW4qivh3sXyTVglK3SRokE2Yk7FqeCtT4bWPc6uFdQzUuP8Bxmq1ubXXKWP19/z6aFBoBLk7v7meJb0HgW/EWiy4TctNAaLEd37bAgNJl6ZFdqmvi0LxlwCLgS6hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145620; c=relaxed/simple;
	bh=kuoh45Evnx5JyHfck+cgZ7vm+rNwO3DEfwaBM/CzXtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3d6QCeTbGxhYro9pUHYEHY/ap9eQLGDRCRh3SRboUMg5dQ64ZCbjn4GJxffZHLLxhTvUJcRflcmw8hPV4pDOlQgUqWWgxMVxDIZdiRUleJ7/v9aghxCN6IE7JiMo1YW7TdbiB0c7YABmXyqdcrDwlWe5zWQJ4Epn+9QxQaujHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AsKyh1i7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AsKyh1i7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d94b222a3aso26934945ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 20:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708145617; x=1708750417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qdAfjTcONjZuFbVJIFLeD6GXhLkNJkyoK1rJKpx18g=;
        b=AsKyh1i7gSiAco917JNW/VbpJGqDbRvPapj4xwCbAVEXUgv6Kx5YoLEKMgnpw5bjUZ
         jV4ziR78LhoSc2RsaRabVjHVK155ztqZz8uFLrAqoIpEnjNN+jwT+ywFBQDmZzCc6MDS
         wxq9lPFjEGNh8pKxLbSq+SZNrMXh/3aefHB/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145617; x=1708750417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qdAfjTcONjZuFbVJIFLeD6GXhLkNJkyoK1rJKpx18g=;
        b=MkEa8URp3R/GwOry5hC5CXVRA1JMq9yiyZHNAabev6sOrmt8pzeUuPW/BVN+V6TmFm
         vbZzTtt2KaEAM4vF6U1x9c0Mv19nkVDacChxN4i24MMjqP0YIyRn2m1hem+XBMQnzvrU
         yc9D/Al/OdhLbox49iHmkVcuZlvqPDF/tM0DiBYoXM3Yk4gHmztz3AXDTg5OSsrhDjy0
         Fm4jsEojtQLx8gfgGWsYvNVjBm7sQCRmQni09+QhiE4R098iw9Oe6dFunKXgoDDA/wyc
         UgcPUXvqagZD7YmKlBkZqJi1Qj/PLakkQJ7ZTsYc8WQqrmcz1xU2OD/Snb1XeF3Yp/Nc
         Gi/Q==
X-Gm-Message-State: AOJu0YxnfIDYLjlyDIXQb2aqGhjlpQdg5Tt6mIY2ylOZXMda5kH50RLI
	LXwIqHcFP9dQYegPpv4gAR9uA8+laP15Qvqu8NETDM56RLI00aSLJe8VgKDkfQ==
X-Google-Smtp-Source: AGHT+IEEA7cH25c2SnuHT2lLGBTXjPK22F4JueEyhr7TFgx+E6bytot0sa7AxNKmXd0gd+XwMXTAbQ==
X-Received: by 2002:a17:902:d2c2:b0:1db:2d82:e803 with SMTP id n2-20020a170902d2c200b001db2d82e803mr8044720plc.20.1708145617246;
        Fri, 16 Feb 2024 20:53:37 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902d3cc00b001db398d13ecsm621742plb.258.2024.02.16.20.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:53:36 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Puyou Lu <puyou.lu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH v3 2/5] fortify: Allow KUnit test to build without FORTIFY
Date: Fri, 16 Feb 2024 20:48:25 -0800
Message-Id: <20240217045335.1526675-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217043535.make.664-kees@kernel.org>
References: <20240217043535.make.664-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2099; i=keescook@chromium.org;
 h=from:subject; bh=kuoh45Evnx5JyHfck+cgZ7vm+rNwO3DEfwaBM/CzXtM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0DqcqxsshKhN+XVitP/aPp0wIqPepQH/G0HTU
 LaFc4bmVtyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdA6nAAKCRCJcvTf3G3A
 JsyxD/9NuT75fNho8Z/IYQI3bIaDR5+SVoHtJn460dJU895HRVECqQDQK0FH10OwLUPmtsWRNLO
 e3AY4jCBlmVXEUvk312YO4mVGGKOwIrKn4qRGfuwrYIg6di0KWySPoUJlJmKuEeC0crqblr2VCm
 9KdKwIM8rpCcWtVDnfpUdTHtEJDp4t8GB8jwnp3gJQbOgexoO1iHwV6eOQy6pJvdEFaPzv+pcqx
 5b9SD2CIjBFPyY1unxleXUEbKZC7kOkSzcCyEQvAK7UgB7cH+7EhKyaXlPyVrou72mOJUhDHKv0
 bR/kWpMi+iQ2zUIfTpl8jZIQpcxJZ8b3WsTN7mAG5xtpTnVjdzSbfazkWiTpY1AjGy2nUpuOqSD
 jhc8Tw8shjxmcmN6hgY9NfC5PQXVrg1frUMWiNR9fTlaSRIYSp9hlixNzCmHGFCFYKhEuWxYoXv
 gPFCLy8MEGfoUv28zY/TcahYUe338xs7yYeK5Ew7IVFHYtiX7psKu+eOT6oz8C6vQOZ/RmRYMVP
 K6DOuJygGnjnC1XgOib+KqdhTQCJ0KznSI24Z9g/U2hPwJrn8fdDa3LmXFsTE4+riDIDI3RbkmT
 CNmNkScyxcDWDUVFXft/0/JEVwtdhsW/xoLpBw8DTPLFlqaFywHieC3G4G808zoLZnhnI8lTLHN 6/YCwtjCopS6SAw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In order for CI systems to notice all the skipped tests related to
CONFIG_FORTIFY_SOURCE, allow the FORTIFY_SOURCE KUnit tests to build
with or without CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
---
 lib/Kconfig.debug   |  2 +-
 lib/fortify_kunit.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..4e2febe3b568 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2748,7 +2748,7 @@ config STACKINIT_KUNIT_TEST
 
 config FORTIFY_KUNIT_TEST
 	tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
-	depends on KUNIT && FORTIFY_SOURCE
+	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
 	  Builds unit tests for checking internals of FORTIFY_SOURCE as used
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 2e4fedc81621..7a88b5dd3d27 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -22,6 +22,11 @@
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 
+/* Handle being built without CONFIG_FORTIFY_SOURCE */
+#ifndef __compiletime_strlen
+# define __compiletime_strlen __builtin_strlen
+#endif
+
 static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
 static char array_unknown[] = "compiler thinks I might change";
@@ -308,6 +313,14 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
+static int fortify_test_init(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
+		kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y");
+
+	return 0;
+}
+
 static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(known_sizes_test),
 	KUNIT_CASE(control_flow_split_test),
@@ -324,6 +337,7 @@ static struct kunit_case fortify_test_cases[] = {
 
 static struct kunit_suite fortify_test_suite = {
 	.name = "fortify",
+	.init = fortify_test_init,
 	.test_cases = fortify_test_cases,
 };
 
-- 
2.34.1

