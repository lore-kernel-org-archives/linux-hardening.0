Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BB130A4E
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714606327; cv=none; b=OdBmCO6/A+Ewe1aixr2rGkSndhS+0/UXnQjrhYGOuPpzFlk70I7AspBGwO9RWdSwDj7NSRJ1xWTHPFlAb1tJN53BZQQo554Cx5TgNvHpBv1/z0HbtxYu8+KYE1NptiNQPmqHB3L/tvomMZntBKo8tn6eIYD5gxidw/J/LIT3Vdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714606327; c=relaxed/simple;
	bh=gR+vbbH+DAZKRq0E6YtKjSkmnKIDVlaHT0YUysMLekk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPWymZ0J2cGrua9WlQlm1szGQA0Hbf9KjOb08kKlGiP+4kgVvGaluj9uwVxaVosr8/JRIy5HCsBO92oztZ03UnePvLTbI+DQcOjy0KnbIcQCZMdro7EiCVH/bLwAUpGAuV6UjNsfmM0Z72EANz3m5L+QcrPF7ZpBm/mqR2h2vZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R3VgfcK7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R3VgfcK7"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5f807d941c4so5835683a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714606325; x=1715211125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5aYRkpN51w049QI8kd5GYmwlJcVNwDWR08IsNZrqzUI=;
        b=R3VgfcK7yfH5ZhlPB7EiHZ10yJ86+kINOpq9ETnP/ByNhkcy63fCU6x4LTdU2Xf1EJ
         v2j4x1IqSv+tmIZ1v8iFlQV6X55d9cqW+iheGlZun6cjUJAeQ50KW/3ek5lv0T/Z7bhN
         pHkLJRQn/5Glv7r6ipURvbnsAWEudOYQBQVc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714606325; x=1715211125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aYRkpN51w049QI8kd5GYmwlJcVNwDWR08IsNZrqzUI=;
        b=OtM4erf1Q5uCnctpHO8y2WzGGJixyebxX5rWVz6LwF4kZEI91m+l535aoT5mddAgc+
         5yVK3szcikXTlIFgCe4Esh9vREwGUF+jhecSsRqTJm+erG9d3J6f5Wt2BNeSLAZGqfVn
         kUsV62bveToabVobq6B+tIjpOY03kz5si0TeWzUOmxD4a9ZY0KvIvOKNzibBieeLKxGa
         T5A2tVc/7F1xJIMRcTkrzKjdKj/mbdqEVi2tWRPoMrRlj1321ghMwfaJ259X+JI5xwy0
         SALQEwfxHWwZOodNHCb+OPpJ6MjjmOdk50SSEGorBZhs8AuQbt787bEfVEG4JviGB83w
         J0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVBeI8ar1t4pNHlhPeboIQVxqilDooctvao8lldcyvAubyaiELiRA+gYkOjwZXiDq+73J7/D2WTM4qkmOZoEY1NhaqRC87GOtnJSzC4ieMA
X-Gm-Message-State: AOJu0Yz2e17wRn8u/2ID7Ip462cuaZvGNcocrlk7f81mX9pu9GRk8wig
	h3Jyg2kEKLb6KweRvPpp7ZfNbdSPydFHdB8vsKEukMD8P9DhaM5kEV7Elmkaa9rtZ6B0MucMwX8
	=
X-Google-Smtp-Source: AGHT+IGa8p+uT3jz2HKJU5OFB+laRrOgxdSdOB1Ek2KwMVajiqMieGQW9z7DG0y/p/H0ZL/SiW6uDw==
X-Received: by 2002:a17:90a:9e9:b0:2a2:b097:dabc with SMTP id 96-20020a17090a09e900b002a2b097dabcmr403414pjo.31.1714606325247;
        Wed, 01 May 2024 16:32:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id eu6-20020a17090af94600b002b3631c9270sm940768pjb.25.2024.05.01.16.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:32:04 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] string: Add additional __realloc_size() annotations for "dup" helpers
Date: Wed,  1 May 2024 16:32:02 -0700
Message-Id: <20240501233201.work.732-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4405; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gR+vbbH+DAZKRq0E6YtKjSkmnKIDVlaHT0YUysMLekk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmMtDy9nhs2yyzAyRPo+OWZ60gpXhkZ7abujUAL
 Efyxx53AT2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjLQ8gAKCRCJcvTf3G3A
 JuQrD/9WgxbHkFFuFSzqHJjQ+owd03tNBe3B2p5XYbn+bh32+xw6zv2EJ9jADu/Ny/cirlGFKyo
 xPEL1UBWt7Znf7KyM2bcOAHAqlL86MHEuUsDOodkXJCwe3rZMKzksMXwP1SSJ0UrMB8dvx0a7qG
 B2CPRJfVA87nQ6ugbjHfwnJp40GnGunV0cvWl0h9s18MzwI/HzX+ORMOGxGNrXN7ND1vNPS20KK
 BJGLicX92ByUtw4l9L3wxx0D3Mn38M8/y6+WarQ1klNJ2nEPMVq7OXPMpXrULboivNNkqJ941YD
 CpCkOaGlzE/TVOh/TJuOXajES1P6GWx2vxIDjQa+rBOJPmGV/bciYH10LDIhQR4TS+NFZFx9Siv
 gi0ApTVgv/pPoo1M3Bwut3p1QHjbQU+SGZdo/+uz3Gaj/TIM9o/11oH7tjs2yfSB9HP7BlhTZqW
 LUdnMuy9WyC1gyauWr3tRUe6w3jzVE2ok6UhHBuR6I5VhUF+MnsxJv6gh5kZvT6fraVGK+Y7ZKo
 jATH9DgtXFqpBEKElwVpgCNrlbVHYaw36WEZ2cGzNtG1Edo69hxwj5337209IhQTVWBykvdep/s
 V+2dAou+Bjf87f6PFgqCl7Xl0iCmJDn8FbaCXXreyRGxIj7Fbp3N5ZGrauxOqzTzD0TUHbITa43
 aI3uYA6 URXQX8rg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Several other "dup"-style interfaces could use the __realloc_size()
attribute. (As a reminder to myself and others: "realloc" is used here
instead of "alloc" because the "alloc_size" attribute implies that the
memory contents are uninitialized. Since we're copying contents into the
resulting allocation, it must use "realloc_size" to avoid confusing the
compiler's optimization passes.)

Add KUnit test coverage where possible. (KUnit still does not have the
ability to manipulate userspace memory.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/string.h | 13 ++++++++-----
 lib/fortify_kunit.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 86aa6cd35167..10e5177bb49c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,8 +14,8 @@
 #include <uapi/linux/string.h>
 
 extern char *strndup_user(const char __user *, long);
-extern void *memdup_user(const void __user *, size_t);
-extern void *vmemdup_user(const void __user *, size_t);
+extern void *memdup_user(const void __user *, size_t) __realloc_size(2);
+extern void *vmemdup_user(const void __user *, size_t) __realloc_size(2);
 extern void *memdup_user_nul(const void __user *, size_t);
 
 /**
@@ -27,7 +27,8 @@ extern void *memdup_user_nul(const void __user *, size_t);
  * Return: an ERR_PTR() on failure. Result is physically
  * contiguous, to be freed by kfree().
  */
-static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+static inline __realloc_size(2, 3)
+void *memdup_array_user(const void __user *src, size_t n, size_t size)
 {
 	size_t nbytes;
 
@@ -46,7 +47,8 @@ static inline void *memdup_array_user(const void __user *src, size_t n, size_t s
  * Return: an ERR_PTR() on failure. Result may be not
  * physically contiguous. Use kvfree() to free.
  */
-static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+static inline __realloc_size(2, 3)
+void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
 {
 	size_t nbytes;
 
@@ -285,7 +287,8 @@ extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
-extern void *kmemdup_array(const void *src, size_t element_size, size_t count, gfp_t gfp);
+extern void *kmemdup_array(const void *src, size_t element_size, size_t count, gfp_t gfp)
+		__realloc_size(2, 3);
 
 /* lib/argv_split.c */
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 306522fd0aa2..87b873108350 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -363,6 +363,31 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
+static const char * const test_phrases[] = {
+	"",
+	"Hello there",
+	"A longer string, just for variety",
+};
+
+#define TEST_realloc(checker)	do {					\
+	gfp_t gfp = GFP_KERNEL;						\
+	size_t len;							\
+	int idx;							\
+									\
+	for (idx = 0; idx < ARRAY_SIZE(test_phrases); idx++) {		\
+		len = strlen(test_phrases[idx]);			\
+		KUNIT_EXPECT_EQ(test, __builtin_constant_p(len), 0);	\
+		checker(len, kmemdup_array(test_phrases[idx], len, 1,	\
+					   gfp), kfree(p));		\
+		checker(len, kmemdup(test_phrases[idx], len, gfp),	\
+			kfree(p));					\
+	}								\
+} while (0)
+static void fortify_test_realloc_size(struct kunit *test)
+{
+	TEST_realloc(check_dynamic);
+}
+
 /*
  * We can't have an array at the end of a structure or else
  * builds without -fstrict-flex-arrays=3 will report them as
@@ -1046,6 +1071,7 @@ static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(fortify_test_alloc_size_kvmalloc_dynamic),
 	KUNIT_CASE(fortify_test_alloc_size_devm_kmalloc_const),
 	KUNIT_CASE(fortify_test_alloc_size_devm_kmalloc_dynamic),
+	KUNIT_CASE(fortify_test_realloc_size),
 	KUNIT_CASE(fortify_test_strlen),
 	KUNIT_CASE(fortify_test_strnlen),
 	KUNIT_CASE(fortify_test_strcpy),
-- 
2.34.1

