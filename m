Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA313B28A
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419827; cv=none; b=Dp7oD3qCfEV9uhmVxcJzar5UO0IgxHsiIgDNYVn84JhN1JLENgut5ZQuWqZNpSRoK3x60rSt78MTQRqzgMdqqlfstdcQ9Zb0MTbWH9d7P912YQYzdeitDgoBrqibMAWWEYwtq6g0cU1DMR1eC+S9Gi/Hlfr2EHRaoL18cFOkLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419827; c=relaxed/simple;
	bh=JUpgKGKNZbsX+goUd06248PhOZ+lxWWD96tmeNIMNOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRhl3uant3I4EBOmgWS/K9RdKCLmHt5yW8XIYxFNEyXOVXiIH58nHHswgvLNhpE3YbLBEzneuxoBBR9hc8iG8Qbjj5Ti8Aejr/3m00oXthr1yvyKhPwCqKwBa1bfr0o3KlELSsd92vV9uJs8l9xl36eGIuIBv0L23y7v7Xwt0tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C0G1ja+E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C0G1ja+E"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso30478535ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714419825; x=1715024625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRYBya/NOm9RXOTNWuX4vwtPazKcBlRxHRUkoGXSiKM=;
        b=C0G1ja+E7piSwauJ5UZWpViKCRtkNRQ8UgPbvJW8sU3du7qPcDTigUlrn1coQw1ULU
         Ai/seyhuX1zMFRSBXE3ura4eZr2esSTbaMbKl9gZ+OShjv5uHHLZBXQa3j0RBULVN4p9
         +MCUIRZMP1DZUPWF/bQVGJ5esGefh9FfKACfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419825; x=1715024625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRYBya/NOm9RXOTNWuX4vwtPazKcBlRxHRUkoGXSiKM=;
        b=v/azcHrTBiGbuZpHZybgHWCvxwxXSM2Vljm7boPTNtJTXt1iLw6S0StFq73/4mgwA7
         CCUSNXbvd3yTpaNnJN8Km9Hoe4JOYIKGcOmNBg+RzUpAj4jWNCWHCIf9uPbM1ENntURV
         WZnEvP88oIsJJm+tE4TbfdANyhaTdGD3wt/tEyTZW7h1ltwYjJQM6iN2y1uUXZKj4sZO
         viQz1VbzfN5kjP9g5RTd61cuql0as7s1OjzLUxvYav/wJtsN73aLCjFCr7Sxkid2s0pr
         3e7OLDSFhZMcC0nRfkrSnYIpkzeIPGyHWYR7hr5clMhtQ8kZGgsj20dh4AiATM9iuzMZ
         G0iA==
X-Gm-Message-State: AOJu0Yxlh/pvUfbEFvDukFjg5z1pp8ynqFv06vefXiS0C6NA2aNMoywI
	9FzxgZNd9IwBm2WgbmwSDiczXbc6/mcNMD1iuAuMqy3Z3NtvBdMivbnAx+L/bi6OYrX2rTCt3JI
	=
X-Google-Smtp-Source: AGHT+IEyC7ogmQtpfq2jo163UzMRiI3EiBb8cTzX64dp7MosCyMenO8FJJ+ZXzfk/yzWptwVIRo+Ig==
X-Received: by 2002:a17:903:2283:b0:1eb:152a:5a6e with SMTP id b3-20020a170903228300b001eb152a5a6emr12905147plh.3.1714419824877;
        Mon, 29 Apr 2024 12:43:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kk4-20020a170903070400b001e245d90d6fsm20746055plb.59.2024.04.29.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:43:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kunit/fortify: Rename tests to use recommended conventions
Date: Mon, 29 Apr 2024 12:43:39 -0700
Message-Id: <20240429194342.2421639-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429194019.work.664-kees@kernel.org>
References: <20240429194019.work.664-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7993; i=keescook@chromium.org;
 h=from:subject; bh=JUpgKGKNZbsX+goUd06248PhOZ+lxWWD96tmeNIMNOQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmL/ht3kH8jQ6I7GxOBKaT2BHrhS0HCqY8ttL3e
 N5+zsXoDrOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZi/4bQAKCRCJcvTf3G3A
 Jjb6D/4xa6k2pRKjbWYWw+EZDTEriLKigrM+f7KCMCkw9VXD3I8Xor/2q0DK8VvwjfUloRRpMNO
 nzPUHrgUCFPi8t65MWNmGrWnKEtFVfBAABh0gs6o3yQDVPE/ITCwqJ7uQP2V4xxwqxadJ9vPiho
 24+nE4GW1DDd16YnWhDSG0owW9chrw/m3uO6QhsOvVrRBOOrPN2Jry8E2fK0nEJnWcWylerHO14
 nyVs8wIppyuyJipDGCbBkmFqQdW66F2A8DLmpXC39GY2dMM5OdZtbehGDPxxE9Dyhax2I3TaMnb
 WWR+lNexeyPxdSOpMFGVVLdynmIqDT6pgheulUUFq7nRHBFZHMwcLk1qOHNZddih2SaH8vEjvVg
 8JcqyxJb9N/B+V/cv44g2Sj9Tg0gSRmIPgKGfWkVC/tj6T6mFjhMbZB0K31euPuVZAQHFK6pOe7
 g2OKqZiMOMDGGEXJyKcEzAIO6iO4Vwu48UEQ56nX0DGpZjMR817QU28v927nYDMepndlied5+Fo
 8/a5tO5PoPolqjqQSAFQCyTvhHW0fcknSs0iUlxs++9t4SJIUvFa+WosoLwaz6AB572Sg7vfvzr
 h3P013V3beqvyXumqSBYAeW8ge+Mbt9AYxtXvGj9odD81yx3ollWb0HtVi8+ptTf5+LFeiKb6AL oxlIE6tfGq0dlVg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The recommended conventions for KUnit tests is ${module}_test_${what}.
Adjust the fortify tests to match.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
---
 lib/fortify_kunit.c | 80 ++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 493ec02dd5b3..6f9a86c94538 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -64,7 +64,7 @@ void fortify_add_kunit_error(int write)
 	kunit_put_resource(resource);
 }
 
-static void known_sizes_test(struct kunit *test)
+static void fortify_test_known_sizes(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_of_10), 10);
@@ -97,7 +97,7 @@ static noinline size_t want_minus_one(int pick)
 	return __compiletime_strlen(str);
 }
 
-static void control_flow_split_test(struct kunit *test)
+static void fortify_test_control_flow_split(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, want_minus_one(pick), SIZE_MAX);
 }
@@ -173,11 +173,11 @@ static volatile size_t unknown_size = 50;
 #endif
 
 #define DEFINE_ALLOC_SIZE_TEST_PAIR(allocator)				\
-static void alloc_size_##allocator##_const_test(struct kunit *test)	\
+static void fortify_test_alloc_size_##allocator##_const(struct kunit *test) \
 {									\
 	CONST_TEST_BODY(TEST_##allocator);				\
 }									\
-static void alloc_size_##allocator##_dynamic_test(struct kunit *test)	\
+static void fortify_test_alloc_size_##allocator##_dynamic(struct kunit *test) \
 {									\
 	DYNAMIC_TEST_BODY(TEST_##allocator);				\
 }
@@ -361,7 +361,7 @@ struct fortify_padding {
 /* Force compiler into not being able to resolve size at compile-time. */
 static volatile int unconst;
 
-static void strlen_test(struct kunit *test)
+static void fortify_test_strlen(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	int i, end = sizeof(pad.buf) - 1;
@@ -384,7 +384,7 @@ static void strlen_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
 }
 
-static void strnlen_test(struct kunit *test)
+static void fortify_test_strnlen(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	int i, end = sizeof(pad.buf) - 1;
@@ -422,7 +422,7 @@ static void strnlen_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
 }
 
-static void strcpy_test(struct kunit *test)
+static void fortify_test_strcpy(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[sizeof(pad.buf) + 1] = { };
@@ -480,7 +480,7 @@ static void strcpy_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
 
-static void strncpy_test(struct kunit *test)
+static void fortify_test_strncpy(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[] = "Copy me fully into a small buffer and I will overflow!";
@@ -539,7 +539,7 @@ static void strncpy_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
 
-static void strscpy_test(struct kunit *test)
+static void fortify_test_strscpy(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[] = "Copy me fully into a small buffer and I will overflow!";
@@ -596,7 +596,7 @@ static void strscpy_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
 
-static void strcat_test(struct kunit *test)
+static void fortify_test_strcat(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[sizeof(pad.buf) / 2] = { };
@@ -653,7 +653,7 @@ static void strcat_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
 
-static void strncat_test(struct kunit *test)
+static void fortify_test_strncat(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[sizeof(pad.buf)] = { };
@@ -726,7 +726,7 @@ static void strncat_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
 
-static void strlcat_test(struct kunit *test)
+static void fortify_test_strlcat(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[sizeof(pad.buf)] = { };
@@ -811,7 +811,7 @@ static void strlcat_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
 
-static void memscan_test(struct kunit *test)
+static void fortify_test_memscan(struct kunit *test)
 {
 	char haystack[] = "Where oh where is my memory range?";
 	char *mem = haystack + strlen("Where oh where is ");
@@ -830,7 +830,7 @@ static void memscan_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
 }
 
-static void memchr_test(struct kunit *test)
+static void fortify_test_memchr(struct kunit *test)
 {
 	char haystack[] = "Where oh where is my memory range?";
 	char *mem = haystack + strlen("Where oh where is ");
@@ -849,7 +849,7 @@ static void memchr_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
 }
 
-static void memchr_inv_test(struct kunit *test)
+static void fortify_test_memchr_inv(struct kunit *test)
 {
 	char haystack[] = "Where oh where is my memory range?";
 	char *mem = haystack + 1;
@@ -869,7 +869,7 @@ static void memchr_inv_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
 }
 
-static void memcmp_test(struct kunit *test)
+static void fortify_test_memcmp(struct kunit *test)
 {
 	char one[] = "My mind is going ...";
 	char two[] = "My mind is going ... I can feel it.";
@@ -891,7 +891,7 @@ static void memcmp_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
 }
 
-static void kmemdup_test(struct kunit *test)
+static void fortify_test_kmemdup(struct kunit *test)
 {
 	char src[] = "I got Doom running on it!";
 	char *copy;
@@ -951,31 +951,31 @@ static int fortify_test_init(struct kunit *test)
 }
 
 static struct kunit_case fortify_test_cases[] = {
-	KUNIT_CASE(known_sizes_test),
-	KUNIT_CASE(control_flow_split_test),
-	KUNIT_CASE(alloc_size_kmalloc_const_test),
-	KUNIT_CASE(alloc_size_kmalloc_dynamic_test),
-	KUNIT_CASE(alloc_size_vmalloc_const_test),
-	KUNIT_CASE(alloc_size_vmalloc_dynamic_test),
-	KUNIT_CASE(alloc_size_kvmalloc_const_test),
-	KUNIT_CASE(alloc_size_kvmalloc_dynamic_test),
-	KUNIT_CASE(alloc_size_devm_kmalloc_const_test),
-	KUNIT_CASE(alloc_size_devm_kmalloc_dynamic_test),
-	KUNIT_CASE(strlen_test),
-	KUNIT_CASE(strnlen_test),
-	KUNIT_CASE(strcpy_test),
-	KUNIT_CASE(strncpy_test),
-	KUNIT_CASE(strscpy_test),
-	KUNIT_CASE(strcat_test),
-	KUNIT_CASE(strncat_test),
-	KUNIT_CASE(strlcat_test),
+	KUNIT_CASE(fortify_test_known_sizes),
+	KUNIT_CASE(fortify_test_control_flow_split),
+	KUNIT_CASE(fortify_test_alloc_size_kmalloc_const),
+	KUNIT_CASE(fortify_test_alloc_size_kmalloc_dynamic),
+	KUNIT_CASE(fortify_test_alloc_size_vmalloc_const),
+	KUNIT_CASE(fortify_test_alloc_size_vmalloc_dynamic),
+	KUNIT_CASE(fortify_test_alloc_size_kvmalloc_const),
+	KUNIT_CASE(fortify_test_alloc_size_kvmalloc_dynamic),
+	KUNIT_CASE(fortify_test_alloc_size_devm_kmalloc_const),
+	KUNIT_CASE(fortify_test_alloc_size_devm_kmalloc_dynamic),
+	KUNIT_CASE(fortify_test_strlen),
+	KUNIT_CASE(fortify_test_strnlen),
+	KUNIT_CASE(fortify_test_strcpy),
+	KUNIT_CASE(fortify_test_strncpy),
+	KUNIT_CASE(fortify_test_strscpy),
+	KUNIT_CASE(fortify_test_strcat),
+	KUNIT_CASE(fortify_test_strncat),
+	KUNIT_CASE(fortify_test_strlcat),
 	/* skip memset: performs bounds checking on whole structs */
 	/* skip memcpy: still using warn-and-overwrite instead of hard-fail */
-	KUNIT_CASE(memscan_test),
-	KUNIT_CASE(memchr_test),
-	KUNIT_CASE(memchr_inv_test),
-	KUNIT_CASE(memcmp_test),
-	KUNIT_CASE(kmemdup_test),
+	KUNIT_CASE(fortify_test_memscan),
+	KUNIT_CASE(fortify_test_memchr),
+	KUNIT_CASE(fortify_test_memchr_inv),
+	KUNIT_CASE(fortify_test_memcmp),
+	KUNIT_CASE(fortify_test_kmemdup),
 	{}
 };
 
-- 
2.34.1

