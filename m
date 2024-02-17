Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729461C2BC
	for <linux-hardening@vger.kernel.org>; Sat, 17 Feb 2024 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145623; cv=none; b=YEf4ulDJ+52AadgP6DuA3zihzA/DyPQ9Pyn4FBXQr60zrMEkIvMnbfqEgaR5ImtczdPU4+UypHmY8yTDBoRiI5bKmfIECTed+J4dTZxVhI8p7ZwiNUcioMvw3ug1c804Z0UoS35qEcLs/7R/m1XeneBSm7tulUToJovi9AyEF9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145623; c=relaxed/simple;
	bh=hokFyy8qPsOZQK0QxxkCCaEHdxSLYeLL82uvMMA2NB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COTcwb7DqIrGCLNJFhXR3oKoLVJC0UXUkpDJerhd8Cp9BlkXhaYQMwa1Tup92F+I1FSeY3RHk0DIpsGDa1A/q7sCDK8Nn05l9KpBolcdjEHXZq5Ekw9rO4+BvArmgkPWe1IVjcRJpMzaEc9Seo4wYrt+H7kSu/4K7apsYFaMi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FG2W5ld3; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FG2W5ld3"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c13410a319so1683299b6e.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 20:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708145618; x=1708750418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqD9QSOaWitNrV/YtqVACNtULpzHLxmWAN5VYT7BaOg=;
        b=FG2W5ld3TvsqpUlq58rOIyh9ekRMIEiwkb6iMDnzB1P8lFFbHFdRONpYFyVYldgYm4
         MQ7M+cLoD8vtmNFgoIMgnQ0kxUf7atzJgKO0PVV9KMPWfJcpqi0oR7tzrbjWrRW8wk4g
         cHdilNq5nMKevdHOBkPkL0JsttyMxaGJc13B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145618; x=1708750418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqD9QSOaWitNrV/YtqVACNtULpzHLxmWAN5VYT7BaOg=;
        b=JjdPhtYdf0TpQHfV5BHxzQ8K3eibxu0jp69jutrr9KNu6YHwdfSfBHSE4nqMGtSHdU
         P9k/DWweRMa2q/yNbZ5tn8tzw7nCVmrzWR45m6o8HD2OcI+KcC+sqlxO5ahBUyuQljVm
         ZMNCrQxQqok2hURuAZBYi0ekwTdQNgbU22pfdvKEMdNsyh1M+Q9yLU8YCHElLL5ZRCrg
         OS+VloDpiVQVfS6tH9kPXFxz/K0xrW/Wn3wA+zEW2l3JqZigcf8XxwbRUxlV5e3Avcv8
         suONHhrsd1a9bd4jsyCeKAuiVczufXhR0wwRzK6kSAVx6hAuppabUUKHiDSByk4y2ENC
         XXSg==
X-Gm-Message-State: AOJu0YzeG2HB+wJAX1tryW68dAdIYTX3FIcSNU5dcrOy4LDM6t3on1Bf
	TaUOWqUYxlCxyNl9zD16b/2GYM03VqnKW2k1P8NknTHQ7FkVZG3kJfWP18Q3YA==
X-Google-Smtp-Source: AGHT+IFXk37pqOtFYFj2V8I9XyHtrhE15ZYO/PirOvsAr2uYwIja8ZLk7ltfSNfKur2pJUgG7nOF/g==
X-Received: by 2002:a05:6808:2cd:b0:3bf:d1ea:23bc with SMTP id a13-20020a05680802cd00b003bfd1ea23bcmr7007093oid.49.1708145618428;
        Fri, 16 Feb 2024 20:53:38 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fh14-20020a056a00390e00b006e08c103dddsm756206pfb.192.2024.02.16.20.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:53:36 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	kunit-dev@googlegroups.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Puyou Lu <puyou.lu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] fortify: Provide KUnit counters for failure testing
Date: Fri, 16 Feb 2024 20:48:26 -0800
Message-Id: <20240217045335.1526675-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217043535.make.664-kees@kernel.org>
References: <20240217043535.make.664-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10228; i=keescook@chromium.org;
 h=from:subject; bh=hokFyy8qPsOZQK0QxxkCCaEHdxSLYeLL82uvMMA2NB4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0DqcQaQiJnoleWY/J6HeSpUirntlCXzKCTaUg
 YFFbsxYzRSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdA6nAAKCRCJcvTf3G3A
 JkaGD/0XK03QS4Ju4T33E26ZgsIiEgVjdZlDIYTxV55sr1wcFy8otOKbTu+K0sKJZ0WxnOOAKdQ
 7Nl1pZacWsADJZ98A8gp5O8qDT42vvkXwGmLNsJe+1p4FNyBLlDU2iYuo7o9RNu7QhZRzNGnFNG
 c+UBduxPwil71P59eigc5JsxW10g2JWCvcAIMgcVwxcr3FPEUagdyvIKFUte02xVwsHNH5bVOAI
 FfmldAasLq/m0yVqOP1XF7z/N5sd18qU8UFenMKrFqpNetQammLDnV5h5ZogJwCTTDMTRzSXOaX
 7ZJrCB0t5r7aeCN8hOV1FGH2m/YCXtizW0TDRNzn0OYE8fXH/fwk5TK62Uc0R7XmXXXAUZUilYb
 oxMkNRce+xVZbEQxtSUjJJJT3OOaKbm7snNn1pw8tzc5hhudDPOsWl0gg74/Kp+aoGOUJ3R5otj
 m7yLJdHmvky6Uy3+rglN3Wd6OcesRDY/eHHjUngIUtWEjKSp4+6vmwTKJ58g7+zIaH4R8rIm45w
 X0P7UtrpFh0SJO+xERUA+XYVWYWT98TAVzPEJsIiY9RWfMhEmLBJ3QMNeapZGuPsGoRf/i07SAZ
 xCd1Gnqvwl9OFwPfCIGPvBffCIWiNcs32s70lFLF/Ym7WGDK7lO95lWPQu+vwiQMROYM9joFueK +f7LydPrDdge8Aw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The standard C string APIs were not designed to have a failure mode;
they were expected to always succeed without memory safety issues.
Normally, CONFIG_FORTIFY_SOURCE will use fortify_panic() to stop
processing, as truncating a read or write may provide an even worse
system state. However, this creates a problem for testing under things
like KUnit, which needs a way to survive failures.

When building with CONFIG_KUNIT, provide a failure path for all users
of fortify_panic, and track whether the failure was a read overflow or
a write overflow, for KUnit tests to examine. Inspired by similar logic
in the slab tests.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>
Cc: kunit-dev@googlegroups.com
---
 include/linux/fortify-string.h | 43 ++++++++++++++++++----------------
 lib/fortify_kunit.c            | 41 ++++++++++++++++++++++++++++++++
 lib/string_helpers.c           |  2 ++
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 4f6767dcd933..fbfb90479b8f 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -15,8 +15,10 @@
 #define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
 					 FIELD_PREP(GENMASK(7, 1), func))
 
-#define fortify_panic(func, write)	\
-	__fortify_panic(FORTIFY_REASON(func, write))
+#ifndef fortify_panic
+# define fortify_panic(func, write, retfail)	\
+	 __fortify_panic(FORTIFY_REASON(func, write))
+#endif
 
 #define FORTIFY_READ		 0
 #define FORTIFY_WRITE		 1
@@ -181,7 +183,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -212,7 +214,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, ret);
 	return ret;
 }
 
@@ -248,7 +250,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, ret);
 	return ret;
 }
 
@@ -299,7 +301,7 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
 	 * p_size.
 	 */
 	if (len > p_size)
-		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, -E2BIG);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -357,7 +359,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, wanted);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -366,7 +368,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, wanted);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -395,7 +397,7 @@ char *strcat(char * const POS p, const char *q)
 	const size_t p_size = __member_size(p);
 
 	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p);
 	return p;
 }
 
@@ -431,13 +433,13 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
 	if (p_size < p_len + copy_len + 1)
-		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE, p);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[p_len + copy_len] = '\0';
 	return p;
 }
 
-__FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
+__FORTIFY_INLINE bool fortify_memset_chk(__kernel_size_t size,
 					 const size_t p_size,
 					 const size_t p_size_field)
 {
@@ -472,7 +474,8 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, true);
+	return false;
 }
 
 #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
@@ -571,9 +574,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(func, FORTIFY_WRITE);
+		fortify_panic(func, FORTIFY_WRITE, true);
 	else if (q_size != SIZE_MAX && q_size < size)
-		fortify_panic(func, FORTIFY_READ);
+		fortify_panic(func, FORTIFY_READ, true);
 
 	/*
 	 * Warn when writing beyond destination field size.
@@ -673,7 +676,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, NULL);
 	return __real_memscan(p, c, size);
 }
 
@@ -690,7 +693,7 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 			__read_overflow2();
 	}
 	if (p_size < size || q_size < size)
-		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, INT_MIN);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -702,7 +705,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, NULL);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -714,7 +717,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, NULL);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -727,7 +730,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, NULL);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -764,7 +767,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 7a88b5dd3d27..4ba7d02fdd78 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -15,8 +15,17 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+/* Redefine fortify_panic() to track failures. */
+void fortify_add_kunit_error(int write);
+#define fortify_panic(func, write, retfail) do {			\
+	__fortify_report(FORTIFY_REASON(func, write));			\
+	fortify_add_kunit_error(write);					\
+	return (retfail);						\
+} while (0)
+
 #include <kunit/device.h>
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -27,10 +36,34 @@
 # define __compiletime_strlen __builtin_strlen
 #endif
 
+static struct kunit_resource read_resource;
+static struct kunit_resource write_resource;
+static int fortify_read_overflows;
+static int fortify_write_overflows;
+
 static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
 static char array_unknown[] = "compiler thinks I might change";
 
+void fortify_add_kunit_error(int write)
+{
+	struct kunit_resource *resource;
+	struct kunit *current_test;
+
+	current_test = kunit_get_current_test();
+	if (!current_test)
+		return;
+
+	resource = kunit_find_named_resource(current_test,
+			write ? "fortify_write_overflows"
+			      : "fortify_read_overflows");
+	if (!resource)
+		return;
+
+	(*(int *)resource->data)++;
+	kunit_put_resource(resource);
+}
+
 static void known_sizes_test(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
@@ -318,6 +351,14 @@ static int fortify_test_init(struct kunit *test)
 	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
 		kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y");
 
+	fortify_read_overflows = 0;
+	kunit_add_named_resource(test, NULL, NULL, &read_resource,
+				 "fortify_read_overflows",
+				 &fortify_read_overflows);
+	fortify_write_overflows = 0;
+	kunit_add_named_resource(test, NULL, NULL, &write_resource,
+				 "fortify_write_overflows",
+				 &fortify_write_overflows);
 	return 0;
 }
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 9291dc74ae01..5e53d42e32bb 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -18,6 +18,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/string_helpers.h>
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 /**
  * string_get_size - get the size in the specified units
-- 
2.34.1

