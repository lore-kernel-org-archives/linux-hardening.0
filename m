Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2F64CFC
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661547; cv=none; b=oaWIRQI00R9kMa7hhO38fgpEZ8hoP9g+2r2JnbjBuMtULQbAs51PUWoPcW1H5MT6fNloNnyczTNMeOMS5MiagoeoAxsbAZqvTPTZMlJwR2KflhDvnJJIYmZrgvlXUrEFDTAH9Q8vMzFP3MyRw8yiHBmydC4j3tZT3QH3ZZuk8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661547; c=relaxed/simple;
	bh=zLbS8ODF0z137yrUyr8Axq4iaxcWoLKgEWh3WjjWlz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bYRSKbfCBF1E8duKdqO0SY77Ig1iDFRm0+06Q00j65XtGNPHr2Y6PQ81KJzitL6HTcBPJZORat+zx3+oUNTBo3TM7oKialKE3Cd6dZhtvzO6uBujS7/Mt6sRsc3VdRmX2avsYHRYnSz6t9WufPLH2DKK7tmx/K9t1jjBjww3SVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B1eQ9ouS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B1eQ9ouS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3ca546d40so68757055ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714661545; x=1715266345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWweKXFrFEkCsPdE7nP0/G3wcxDTmjAB5LxHWc+P9DU=;
        b=B1eQ9ouSJZoiX54Yb8DKJg9j4EINyOuFmSltlE3wm5g8iQnx9tamU0vTl9AawdGPcz
         xhpEA54DsVFsqxWSLi+7YgQTWqS3ZJXgJ8juDU3wrQ70OiyKt2m/FWlXxFOenj7RoHrC
         GU+ni0ZbNC+oTVIeA7brSl6lJejW9cMwMd7LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714661545; x=1715266345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWweKXFrFEkCsPdE7nP0/G3wcxDTmjAB5LxHWc+P9DU=;
        b=gHYQN6GkPRua0fD5NDyOWBfZhf2aPhF/5reMm2wUPIyJFAuZOGvbMPU5rKf37X2upj
         xG5VRqR5jvVUxafBeFk14iIeJmYxxG3samDhxVhS78cWuZVAuLTDQB7L8FvDMlOPkLpe
         w3ubXAKViK2f8dWIh4Dr64lpg4aosXEoLqdulvwACrIH/id0xJh/I0iLXEok0sS3I39j
         XqOd4FWgekT9szfAD4M+hremqdE/xU2HZp4kXhJiSxAmMENJx8yukETEyq0bqIG9NhL5
         DbfTTNJeFP65YmH+BTkZaWBQnYdw3IR3Kfer8CLtUTEzzjJaFAz+NFPwk+RzoGz4nZr2
         QVjA==
X-Forwarded-Encrypted: i=1; AJvYcCVczMIoVNw9n/qmcB72pkbulAFKEfhdeA4r35eA6gS8X9MDC5MMxJA877g4sck+llN2guI0shW7OHLo/ep+8q1UXoTMXpvY9bezwM+ZjZdl
X-Gm-Message-State: AOJu0YzNMdykLO7Q7usLh+iN16B8QTl2FJC3vpkhSNObw8C2BFebfo6D
	1XRcuDSj1wTYieYFNza4V7G161DbkNa7/v+4f4rPcvIGp0nHYKtmiOHYlg7LMhomSBKbbDP3X5w
	=
X-Google-Smtp-Source: AGHT+IHVPNhcIilbYRycs9H+6Ov6JMpElqWXMVCfNskH2RvhYuYMOEilYAa/5fUncOtEioHR1Q6A+Q==
X-Received: by 2002:a17:902:d3d3:b0:1ea:9596:11df with SMTP id w19-20020a170902d3d300b001ea959611dfmr6029699plb.32.1714661545446;
        Thu, 02 May 2024 07:52:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id qc3-20020a17090b288300b002a46aca870asm3255359pjb.33.2024.05.02.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:52:25 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] string: Add additional __realloc_size() annotations for "dup" helpers
Date: Thu,  2 May 2024 07:52:21 -0700
Message-Id: <20240502145218.it.729-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4499; i=keescook@chromium.org;
 h=from:subject:message-id; bh=zLbS8ODF0z137yrUyr8Axq4iaxcWoLKgEWh3WjjWlz4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmM6ilI5lXYV7EB9Om3uCGMQdscNOrpz9iX9JHo
 hBuJ9ziVhaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjOopQAKCRCJcvTf3G3A
 JuoZD/9xVonPh1Os8i0HOHmdDbzpC1BsWB7Sit1KHrwZQNGkNkFve9Pd+uTE5t+yry5bIhJxESA
 L30S5XBnG8azcbRX3JYx80Y5TTC5FdvtDRTF6zZbKZeZOV+Zch/dulo6/fjsD7rIbSGlcyh6ja8
 pyOKmu7Ydc75t65+xRYmNmnBdxo2UdqaQAY0YdyqYmAD6GTz68Xzezhp9jhS6rNgKIGRcJkFsqi
 C3rr22VLZqrlsin0DwU0MMxf5YHyohWGQgERA8It+DTRaRnBnsrXYqT36Ftl1w8LVQDbM/QyCFT
 /D0B6LI3XniHkh/uPU69b5hvSw+vBbUg/On5q5C5dGFlkukVIHRy8WC4jBwY/fLQSr8DO5TfGtl
 5USIDp8uMjNmTeF2UBES5NbkTLrDPHxWOzSEG0ftNpNXS+gduX5eBhQIajOeD4p/kMnCz38XBIU
 H/KbLLX1VYyOOSQ89MKVtWCDBlr1DCSKY5QwbLU6VPaoUmR6heFdu/IvDjPOme4jHrMPYl/bIqM
 +USJvManf+F8SYtWyP8Tx4rnAUwiwDr2HRzP+r5rilPY7DOrhAz57hIE5cd2zmHCQfwCaumOYcY
 2h6Q29virxplEzaTzxhB6CtZjnVa9Ym0Kg2dAky7dx2NoC/8CC0jiB1s/AVWeVAd1qMtQW4JIl0
 I1Q3e9n 84x3YA9w==
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

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 v2: change variables names to keep added line continuation lengths similar
 v1: https://lore.kernel.org/r/20240501233201.work.732-kees@kernel.org
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
index 306522fd0aa2..d2377e00caab 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -363,6 +363,31 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
+static const char * const test_strs[] = {
+	"",
+	"Hello there",
+	"A longer string, just for variety",
+};
+
+#define TEST_realloc(checker)	do {					\
+	gfp_t gfp = GFP_KERNEL;						\
+	size_t len;							\
+	int i;								\
+									\
+	for (i = 0; i < ARRAY_SIZE(test_strs); i++) {			\
+		len = strlen(test_strs[i]);				\
+		KUNIT_EXPECT_EQ(test, __builtin_constant_p(len), 0);	\
+		checker(len, kmemdup_array(test_strs[i], len, 1, gfp),	\
+			kfree(p));					\
+		checker(len, kmemdup(test_strs[i], len, gfp),		\
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

