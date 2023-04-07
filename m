Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF7C76196
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Apr 2023 19:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDGT1V (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Apr 2023 15:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDGT1U (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AE7D9B
        for <linux-hardening@vger.kernel.org>; Fri,  7 Apr 2023 12:27:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c3so73274pjg.1
        for <linux-hardening@vger.kernel.org>; Fri, 07 Apr 2023 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpmYIoKSG+bC/EWBdXHIYxWKV0IWyEKuI3ZQc6us+A8=;
        b=F+HAwdY7eeJ2WKEwInnupD0H+spu9svm5pepxNInUxklY1HCXUiZ05nIcUNVeONcpq
         t8ueYfgMtZ+jUu5kwlfZxnABsPVU2CqUkn1Xlr5v7rv9en8TyK6OTh+U5RtN1CMNmmPY
         Qfm1nv3hesLm+CPRdI4J414Lk/P2NnRdXaCbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpmYIoKSG+bC/EWBdXHIYxWKV0IWyEKuI3ZQc6us+A8=;
        b=BIMMkuEczjaPLFAHObNb7BRO/1x2ObYWL+3YPyTvsp314SHtq5CgePUIOj+gupKJGA
         vSyd+24/+4e8WPtkfOpHkiDU9YbbDm1V9TZCyIV0V1gJR7kS3NMAc4fgHjMX4f5Y4+wK
         sB2Ndk3jzQzwVsvHGXgTZD8cThr9z6AXpzk5u1bGFlufkXminvVGTdIONsW3J2yJCyTc
         H2Ksbuf922rksbAo4vzw/fbrXEaZcZ9Vsd1LCrzShJ6FKhRqvxJBmEu3vZokD86/WPqg
         FhxRP0loPnb6avqFBUqnS26gJdgJGcGsPr/w+ctBG+66tTMKxBbsceCABexLcQb6zXVR
         gamA==
X-Gm-Message-State: AAQBX9feExL6oKXWwF25NHXFdiPrcjFpTe2I10oIs2OZwOlrUefG6shY
        yZexbiqUuy58N57BHPMqxY1hNg==
X-Google-Smtp-Source: AKy350bD1nQlktrVd50Zo2X8QH+oEyb0B5GpEmAXZbfGLCFV+saJoXDsbwyu5VW3NVMybli8ZUr8EA==
X-Received: by 2002:a17:903:41c5:b0:1a1:ad5e:bdb2 with SMTP id u5-20020a17090341c500b001a1ad5ebdb2mr4468616ple.57.1680895638680;
        Fri, 07 Apr 2023 12:27:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b0019a70a42b0asm3279520plz.169.2023.04.07.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:27:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        "Cezary Rojewski" <cezary.rojewski@intel.com>,
        "Puyou Lu" <puyou.lu@gmail.com>, "Mark Brown" <broonie@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "David Gow" <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Liam Howlett" <liam.howlett@oracle.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Yury Norov" <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Sander Vanheule" <sander@svanheule.net>,
        "Eric Biggers" <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v2 04/10] fortify: Use const variables for __member_size tracking
Date:   Fri,  7 Apr 2023 12:27:10 -0700
Message-Id: <20230407192717.636137-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6730; h=from:subject; bh=SSZfz6yUPPV5wd89ZA5b2ejqzcpRfr59G2a0gR0Awhw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6TIJi+gaVbi3MpQAYBKFCYpjiec9gLXN093SAh NZNzo76JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJmYPD/ wLsXYH/G8E6yYT5G2XKnEeJaXuRuok+IQ+uVR2+VumKXcCutZWabgwgw/6hYBoly4cip5xKsGSOolj siFfb3wiVIgk+ATU+amRGI6rCB++1V0AOZEhSdzLWT/8LZWeMSmQd2D0oKBEij5nJmGG7oVuLqbTaz r/g9tnF1+VpROXnU2cVYlCUrekjyn/2sJTkSlP+8prTTHrlY79R/aSpT7urQ+ijpbrhWq5GuI+48fz Spzcpn0EGqIMAT0qPsGU+vsxWbGGc1ccw3bKM5nAzUcDDyHLL/lZGMUg8VVl27LWtJcKN4XN0XDYYZ I/LAxugDV/x8LgmoL8sIoadF5m6+Csx7hpDckIrMBlMC+cC06oVVP5UmapYfvc51DtZp3YiwPezA+v 03dbcaHFspcvmi2pt8HkRFMRArS8FlHmmucaG97ovKX4875xq4ti/jDYIE5+fD75tHTUESBxQzF4NR qbNqSz6DpJfW68i12chqpf1StvIhjTzLKKnbQPomUQdhxW/1E4Mz8DFSCYxvSHCz0ez9GhB01FYCzf cDbQQCTxIP4xa2wxnh2p2nmEb3t7jTxap/4mLOdlteAe8ETCfms841Tv1OkYbhblfUvbCtEpCbUgDa 4TrUjqTqWxIh6ObdwKjOUqepHrYQUJRgYKXLUs901D199gogI/jI/npD6kdw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The sizes reported by __member_size should never change in a given
function. Mark them as such.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c9de1f59ee80..fae1bf4bd543 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -20,7 +20,7 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
 ({								\
 	char *__p = (char *)(p);				\
 	size_t __ret = SIZE_MAX;				\
-	size_t __p_size = __member_size(p);			\
+	const size_t __p_size = __member_size(p);		\
 	if (__p_size != SIZE_MAX &&				\
 	    __builtin_constant_p(*__p)) {			\
 		size_t __p_len = __p_size - 1;			\
@@ -142,7 +142,7 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 __FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
 char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 {
-	size_t p_size = __member_size(p);
+	const size_t p_size = __member_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
@@ -169,7 +169,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
-	size_t p_size = __member_size(p);
+	const size_t p_size = __member_size(p);
 
 	if (p_size == SIZE_MAX)
 		return __underlying_strcat(p, q);
@@ -191,8 +191,8 @@ extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(st
  */
 __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size_t maxlen)
 {
-	size_t p_size = __member_size(p);
-	size_t p_len = __compiletime_strlen(p);
+	const size_t p_size = __member_size(p);
+	const size_t p_len = __compiletime_strlen(p);
 	size_t ret;
 
 	/* We can take compile-time actions when maxlen is const. */
@@ -233,8 +233,8 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
 __kernel_size_t __fortify_strlen(const char * const POS p)
 {
+	const size_t p_size = __member_size(p);
 	__kernel_size_t ret;
-	size_t p_size = __member_size(p);
 
 	/* Give up if we don't know how large p is. */
 	if (p_size == SIZE_MAX)
@@ -267,8 +267,8 @@ extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
  */
 __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, size_t size)
 {
-	size_t p_size = __member_size(p);
-	size_t q_size = __member_size(q);
+	const size_t p_size = __member_size(p);
+	const size_t q_size = __member_size(q);
 	size_t q_len;	/* Full count of source string length. */
 	size_t len;	/* Count of characters going into destination. */
 
@@ -318,10 +318,10 @@ extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
  */
 __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
 {
-	size_t len;
 	/* Use string size rather than possible enclosing struct size. */
-	size_t p_size = __member_size(p);
-	size_t q_size = __member_size(q);
+	const size_t p_size = __member_size(p);
+	const size_t q_size = __member_size(q);
+	size_t len;
 
 	/* If we cannot get size of p and q default to call strscpy. */
 	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
@@ -394,9 +394,9 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 __FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
 char *strncat(char * const POS p, const char * const POS q, __kernel_size_t count)
 {
+	const size_t p_size = __member_size(p);
+	const size_t q_size = __member_size(q);
 	size_t p_len, copy_len;
-	size_t p_size = __member_size(p);
-	size_t q_size = __member_size(q);
 
 	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __underlying_strncat(p, q, count);
@@ -639,7 +639,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
 __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 {
-	size_t p_size = __struct_size(p);
+	const size_t p_size = __struct_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
@@ -651,8 +651,8 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 __FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
 int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t size)
 {
-	size_t p_size = __struct_size(p);
-	size_t q_size = __struct_size(q);
+	const size_t p_size = __struct_size(p);
+	const size_t q_size = __struct_size(q);
 
 	if (__builtin_constant_p(size)) {
 		if (__compiletime_lessthan(p_size, size))
@@ -668,7 +668,7 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 __FORTIFY_INLINE __diagnose_as(__builtin_memchr, 1, 2, 3)
 void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 {
-	size_t p_size = __struct_size(p);
+	const size_t p_size = __struct_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
@@ -680,7 +680,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
 __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 {
-	size_t p_size = __struct_size(p);
+	const size_t p_size = __struct_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
@@ -693,7 +693,7 @@ extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kme
 								    __realloc_size(2);
 __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp)
 {
-	size_t p_size = __struct_size(p);
+	const size_t p_size = __struct_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
@@ -720,8 +720,8 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 __FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
 char *strcpy(char * const POS p, const char * const POS q)
 {
-	size_t p_size = __member_size(p);
-	size_t q_size = __member_size(q);
+	const size_t p_size = __member_size(p);
+	const size_t q_size = __member_size(q);
 	size_t size;
 
 	/* If neither buffer size is known, immediately give up. */
-- 
2.34.1

