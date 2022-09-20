Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE299C6FA82
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Sep 2022 19:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiITTWN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiITTWL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Sep 2022 15:22:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15A2CCBB
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 12:22:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d82so3638853pfd.10
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JX0ua+LFqhoPxmKV4FkFTEjLOIsGeEC5zMQTZ7gmmn0=;
        b=PWP5PK9w7OmL6GItthJmplzUuDG9moNLPk1mcXR9Camj5lYCFnho3xhjAIJ5jFVdQD
         BnG1hTJQPls+dKR8bJXIqGnHInIPWik0zjjmf2tJQpudCX/SrH/eQGDw6m4VoJNzKtQx
         hZe6UK4yikBf0kLC1TdwbX1/6fADVBSzEcVcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JX0ua+LFqhoPxmKV4FkFTEjLOIsGeEC5zMQTZ7gmmn0=;
        b=FlDsVqG53uzEyT/a9DvOVktIVhEwWKQ1HeiPMc/CBHwJ8AOa0G4VbSW2v7noh550K6
         HMAbGh5h2p/AIfwefjcJZSYOMuD5fqMWqhynUzT/DGkcUvu3HnLGYm31NFQuIulBDml6
         jxeAYQmdOk1TglQX18dVQQeZvEKlcBYqYBEdhptZwqd1P44Uvp/14+2tebJMnolGBKk2
         JwunrRd8JLzV4J5Ceelk3MPgu1u+kVOEP2SM0sftqza9gaNvqWC4aDqE8ThhegMnu+80
         Z6UFRkjuSX/qlNDucacG4v/O2ShCfOCCDKlVYkpPiC90ddsa/8Er9Cn+MEF2/cAY6HGz
         bDjQ==
X-Gm-Message-State: ACrzQf1qYlHeEAzFVohuGZuW8TZ8hjdRgf2TVvVKvFdjngfWMvTxIbAS
        EhAsnkybA0vmdyN1Q8rOo4tvzQ==
X-Google-Smtp-Source: AMsMyM4hPEYquldZYsARoLf9Epv/KmSgPcBvKIvtg1QdMq9AHUvzPJ5F7JBZcSTvNKqzgwJubVJMEg==
X-Received: by 2002:a63:81c1:0:b0:439:ff01:ff81 with SMTP id t184-20020a6381c1000000b00439ff01ff81mr12874505pgd.39.1663701729659;
        Tue, 20 Sep 2022 12:22:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s16-20020aa78bd0000000b0053e7d3b8d6dsm295543pfd.1.2022.09.20.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:22:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/4] fortify: Explicitly check bounds are compile-time constants
Date:   Tue, 20 Sep 2022 12:22:00 -0700
Message-Id: <20220920192202.190793-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920192202.190793-1-keescook@chromium.org>
References: <20220920192202.190793-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6494; h=from:subject; bh=H1LlmpBscaiEe04I7Sh+ZCZmF9ZgzimcwM4cFmtVeLs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjKhLZNwEQUjp9SkNBWAp8JMozzL5lhw11d4e0rr46 SL0SNsGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyoS2QAKCRCJcvTf3G3AJvs7D/ 9VRJeaTb6BW+4YIzT0+1vpKMjjFvHn5Vt8YD9KVShd7IMqv89ggecT7cEPzwYqGULXFFsgBiSMF1eF RQLaTRMR5ET9DQMztatGHuYJM1WoQ9wqcGieTl0s3NfYEknwNaIxb5Do6AvLiy6WLP9YC8rDLOU6jg +9XXHTf0CPxRiD0ZSF9J/S9FG2GTo8TDLLfOv/I51htuw0jhzXDFkGuOXv4k0VpC3ajwZE32iRtsOR KmVQNVPqo/nhKEQyplpeBxIX91oCn4wQR02lg+x7Fa7aXB8oHD7LhnSUpy4wQ3Ns/yG0tmWxfvOmmv rq0ktZA6z33b+Md/dM0CBN8Hs15I3EnViOYjsOb7h3/ou6vD6qhNzYoCGHmlBrEZ2emlCGiti1rMxq 9pkNNpQbxTI/92DbtUQDd5dbji7k0hCyT7aPobMd26ucldxq9F4LiTc+vVyBieBtqNmrNSAqYR1lti L3kgrtO5jJaoS62216+2WDIkVtFsRvHFJv0iqvpdxmFY0l5IH7wlo44icmLQkTSH1w5bEjCuYSQj82 NQbcPMtFm8cWYrSSyJ1drVOW/MUsYOyUY9DUiaTq1w6pZZcWtCaE/3Zph8Zot4spfo3UUcPadycuei DoMLVZPRh0tmtX6CCEzNfHUL3OAUUR+VnrL1n3UnUSa4RSgtuxFZPRpEoSDQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for replacing __builtin_object_size() with
__builtin_dynamic_object_size(), all the compile-time size checks need
to check that the bounds variables are, in fact, known at compile-time.
Enforce what was guaranteed with __bos(). In other words, since all uses
of __bos() were constant expressions, it was not required to test for
this. When these change to __bdos(), they _may_ be constant expressions,
and the checks are only valid when the prior condition holds. This
results in no binary differences.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 50 +++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index ff879efe94ed..71c0a432c638 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -80,6 +80,12 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define POS	__pass_object_size(1)
 #define POS0	__pass_object_size(0)
 
+#define __compiletime_lessthan(bounds, length)	(	\
+	__builtin_constant_p(length) &&			\
+	__builtin_constant_p(bounds) &&			\
+	bounds < length					\
+)
+
 /**
  * strncpy - Copy a string to memory with non-guaranteed NUL padding
  *
@@ -117,7 +123,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
-	if (__builtin_constant_p(size) && p_size < size)
+	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
 		fortify_panic(__func__);
@@ -224,7 +230,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	 * If size can be known at compile time and is greater than
 	 * p_size, generate a compile time write overflow error.
 	 */
-	if (__builtin_constant_p(size) && size > p_size)
+	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 
 	/*
@@ -281,15 +287,16 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 		/*
 		 * Length argument is a constant expression, so we
 		 * can perform compile-time bounds checking where
-		 * buffer sizes are known.
+		 * buffer sizes are also known at compile time.
 		 */
 
 		/* Error when size is larger than enclosing struct. */
-		if (p_size > p_size_field && p_size < size)
+		if (__compiletime_lessthan(p_size_field, p_size) &&
+		    __compiletime_lessthan(p_size, size))
 			__write_overflow();
 
 		/* Warn when write size is larger than dest field. */
-		if (p_size_field < size)
+		if (__compiletime_lessthan(p_size_field, size))
 			__write_overflow_field(p_size_field, size);
 	}
 	/*
@@ -365,25 +372,28 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 		/*
 		 * Length argument is a constant expression, so we
 		 * can perform compile-time bounds checking where
-		 * buffer sizes are known.
+		 * buffer sizes are also known at compile time.
 		 */
 
 		/* Error when size is larger than enclosing struct. */
-		if (p_size > p_size_field && p_size < size)
+		if (__compiletime_lessthan(p_size_field, p_size) &&
+		    __compiletime_lessthan(p_size, size))
 			__write_overflow();
-		if (q_size > q_size_field && q_size < size)
+		if (__compiletime_lessthan(q_size_field, q_size) &&
+		    __compiletime_lessthan(q_size, size))
 			__read_overflow2();
 
 		/* Warn when write size argument larger than dest field. */
-		if (p_size_field < size)
+		if (__compiletime_lessthan(p_size_field, size))
 			__write_overflow_field(p_size_field, size);
 		/*
 		 * Warn for source field over-read when building with W=1
 		 * or when an over-write happened, so both can be fixed at
 		 * the same time.
 		 */
-		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
-		    q_size_field < size)
+		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) ||
+		     __compiletime_lessthan(p_size_field, size)) &&
+		    __compiletime_lessthan(q_size_field, size))
 			__read_overflow2_field(q_size_field, size);
 	}
 	/*
@@ -494,7 +504,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
-	if (__builtin_constant_p(size) && p_size < size)
+	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
 		fortify_panic(__func__);
@@ -508,9 +518,9 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 	size_t q_size = __builtin_object_size(q, 0);
 
 	if (__builtin_constant_p(size)) {
-		if (p_size < size)
+		if (__compiletime_lessthan(p_size, size))
 			__read_overflow();
-		if (q_size < size)
+		if (__compiletime_lessthan(q_size, size))
 			__read_overflow2();
 	}
 	if (p_size < size || q_size < size)
@@ -523,7 +533,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
-	if (__builtin_constant_p(size) && p_size < size)
+	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
 		fortify_panic(__func__);
@@ -535,7 +545,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
-	if (__builtin_constant_p(size) && p_size < size)
+	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
 		fortify_panic(__func__);
@@ -547,7 +557,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
-	if (__builtin_constant_p(size) && p_size < size)
+	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
 		fortify_panic(__func__);
@@ -563,11 +573,13 @@ char *strcpy(char * const POS p, const char * const POS q)
 	size_t size;
 
 	/* If neither buffer size is known, immediately give up. */
-	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
+	if (__builtin_constant_p(p_size) &&
+	    __builtin_constant_p(q_size) &&
+	    p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __underlying_strcpy(p, q);
 	size = strlen(q) + 1;
 	/* Compile-time check for const size overflow. */
-	if (__builtin_constant_p(size) && p_size < size)
+	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-- 
2.34.1

