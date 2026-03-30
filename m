Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1126F29C
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876813; cv=none; b=I+gC/emRpArZ0juTk9v3MQjSn/NPIrMleDH5gzmC8apZTChJ4hkjd7/fK4yUCZktRcUQWt/+F03brliL6LTEvOzBC4q7JUXY9JlpWl7YelUQQ98CoDHeUavzSHRS8cA/FkLNzNmIgLGWvKWD68+Jb2Bl6BFq3gitiq/bkHicZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876813; c=relaxed/simple;
	bh=3YWFDzWxZ3WGYfmZ0A23V87Rn40MxC8xYfA2yqnoHOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IK+4nxgvEoNFr7z+z0o7f1glTTtMLb847djdMFr4X1sm6Nik9Z4uDrOLjSVrvd3jiPb1Kc5Lxp/ChEp5JoPpUnyrhRcKN0FpXVhwelBMsynF/gnTkpXwnQYh1rzbLhQdhEGocM65U5Ts8iAF+5dp8TRYKAhPRKlEeydsfz8w9Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObT63NzR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObT63NzR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4870206f73bso27225395e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774876810; x=1775481610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/3iE861Wo3FM8pZvJTPy+1u03UK0/+dHCbLjC4fM40=;
        b=ObT63NzRn4ym+TPAV8+tlVNbEfQryecmWy7iel4zB/8RRQ//XlB7Ua9d+dHmjVMVjF
         6gIAqXNTZwSZlXf0pv2cElZH4GTKFiRmx/qN5z3y2fLHq9D1a9yLu/Cc5GlTDduCWbWT
         SWsKysGDvZeiJN6NbQkaLYtdjxzm3yFrIcCuIKy+aUk5yWWBQEsVM0LVIHsD2hV3cs99
         2GiWKsNfZ62qfSJpMEvXdXXaIYAOVPiifdncRhZmtINwmD2in6Si4hn+536nk6xJQPpi
         thTKQBMeWRcYyCWiBqN7GNnPLxIWBeirbPK+12fDReQeG170eoDr8/g6ueap505gXUEh
         55mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876810; x=1775481610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/3iE861Wo3FM8pZvJTPy+1u03UK0/+dHCbLjC4fM40=;
        b=j2XwsIq9V+wPf7ZeiaLFvN7AK+AI1+DejBzYJtx+lEJb0ZJspuweNKhiL2igSMj5jF
         lr4TlEv9e+v110X65mDJhIyO6GhFpln3oi36fMoHjo8CHheug4XZhcf4Uz0CMVNzzDFu
         LAjeTPIhygP7nNnbBoF8MFRT9gZUsb/SvIrexXucb8LiV5pfTH8P6/3dB0DVbX8tLejn
         brZhuclcv788FHaMZ2rUk8PUIzjZ7chK0Lz6EOsL7AtH6dFo3R7Nxguh69kGIMurqjsy
         vjVGHJK9X2VeblXTs/vW1iz1pZWmeHn4MvCuRxa4Hge2l1XmDaOULS2vidNGcjIkB1MX
         KW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgNMgUlkVO/krigYoXIi37LoXBYSbmr2jLe76kG/Kswe755//EMWPMhYgN8ZcraGu9iXHXrxwlvJ4Kz0V9oJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFiZRHTwAPQ/K0NfQA3GuLKQcq3Z9EC08diZmlCBL2nLKjk0nJ
	rrbtbE9U2uJhTkut16lDf5JO7YNQqnGGcjfQbDXn5JPi+u3YKa0FxOK6
X-Gm-Gg: ATEYQzwvV2a6NA9Dn6jfspdNNZ+IENv+YX1bmgpOhRy/vUy66jkJ9CfMPhlZyJWqtZ+
	htWCh9FjpVDuTkR/qMq7BhM5ZUjzK82y0aX/m+I7A3p2XkzwRjCAXOVY6G5q7EA2TWJriB/s8hM
	AWN//PyV/7BNsMQaE+wwScDRL9d5efvzgnYeZI6YdzTD4VFR0K19OtQft1+rfZage8tYsetzHv4
	YbVeWl+riwT2CZSzWxZsCZHgBIFflwF+0KWTi/gRbweLyziCk81fF/jiRx+TCgVvbzUe8O3zhoX
	rSBT7US0z+65yUI/kpnTdTaIEdRrCDJuaIxJOWs2/gZKiI0UHwduPJj+O7POi2MTKe3fdZ3df5Z
	lBafdQ1zbxVC8mnq+90WvTXzjfrq6qtfSQDR3Umzw9EMX+TY3SnJR0bqbW+YAHpDcquQZwbl7xj
	pfFfSpuMCqiOoZh8lZ35Bcgj3pZ4T65aEVT5qq/F4Ps5PxGVUG63YH4A13Oe/PNIGMQ+F8oMnao
	Npc/0FLoiiWw8gKVB8=
X-Received: by 2002:a05:600c:4fc4:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-48727f3b3bamr213966315e9.15.1774876809890;
        Mon, 30 Mar 2026 06:20:09 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eb52e5sm81322315e9.7.2026.03.30.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:20:09 -0700 (PDT)
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next 1/3] fortify: replace __compiletime_lessthan() with statically_true()
Date: Mon, 30 Mar 2026 14:20:01 +0100
Message-Id: <20260330132003.3379-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260330132003.3379-1-david.laight.linux@gmail.com>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

__compiletime_lessthan(a, b) is exactly the same as statically_true(a < b)
Replace the former by the latter.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/fortify-string.h | 47 +++++++++++++++-------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 171982e53c9a..214d237214d5 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -154,11 +154,6 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define POS0			__pass_object_size(0)
 #endif
 
-#define __compiletime_lessthan(bounds, length)	(	\
-	__builtin_constant_p((bounds) < (length)) &&	\
-	(bounds) < (length)				\
-)
-
 /**
  * strncpy - Copy a string to memory with non-guaranteed NUL padding
  *
@@ -196,7 +191,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 {
 	const size_t p_size = __member_size(p);
 
-	if (__compiletime_lessthan(p_size, size))
+	if (statically_true(p_size < size))
 		__write_overflow();
 	if (p_size < size)
 		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p_size, size, p);
@@ -287,14 +282,14 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
 	 * If size can be known at compile time and is greater than
 	 * p_size, generate a compile time write overflow error.
 	 */
-	if (__compiletime_lessthan(p_size, size))
+	if (statically_true(p_size < size))
 		__write_overflow();
 
 	/* Short-circuit for compile-time known-safe lengths. */
-	if (__compiletime_lessthan(p_size, SIZE_MAX)) {
+	if (statically_true(p_size < SIZE_MAX)) {
 		len = __compiletime_strlen(q);
 
-		if (len < SIZE_MAX && __compiletime_lessthan(len, size)) {
+		if (len < SIZE_MAX && statically_true(len < size)) {
 			__underlying_memcpy(p, q, len + 1);
 			return len;
 		}
@@ -469,12 +464,12 @@ __FORTIFY_INLINE bool fortify_memset_chk(__kernel_size_t size,
 		 */
 
 		/* Error when size is larger than enclosing struct. */
-		if (__compiletime_lessthan(p_size_field, p_size) &&
-		    __compiletime_lessthan(p_size, size))
+		if (statically_true(p_size_field < p_size) &&
+		    statically_true(p_size < size))
 			__write_overflow();
 
 		/* Warn when write size is larger than dest field. */
-		if (__compiletime_lessthan(p_size_field, size))
+		if (statically_true(p_size_field < size))
 			__write_overflow_field(p_size_field, size);
 	}
 	/*
@@ -557,15 +552,15 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 		 */
 
 		/* Error when size is larger than enclosing struct. */
-		if (__compiletime_lessthan(p_size_field, p_size) &&
-		    __compiletime_lessthan(p_size, size))
+		if (statically_true(p_size_field < p_size) &&
+		    statically_true(p_size < size))
 			__write_overflow();
-		if (__compiletime_lessthan(q_size_field, q_size) &&
-		    __compiletime_lessthan(q_size, size))
+		if (statically_true(q_size_field < q_size) &&
+		    statically_true(q_size < size))
 			__read_overflow2();
 
 		/* Warn when write size argument larger than dest field. */
-		if (__compiletime_lessthan(p_size_field, size))
+		if (statically_true(p_size_field < size))
 			__write_overflow_field(p_size_field, size);
 		/*
 		 * Warn for source field over-read when building with W=1
@@ -573,8 +568,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 		 * the same time.
 		 */
 		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) ||
-		     __compiletime_lessthan(p_size_field, size)) &&
-		    __compiletime_lessthan(q_size_field, size))
+		     statically_true(p_size_field < size)) &&
+		    statically_true(q_size_field < size))
 			__read_overflow2_field(q_size_field, size);
 	}
 	/*
@@ -699,7 +694,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 {
 	const size_t p_size = __struct_size(p);
 
-	if (__compiletime_lessthan(p_size, size))
+	if (statically_true(p_size < size))
 		__read_overflow();
 	if (p_size < size)
 		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, p_size, size, NULL);
@@ -713,9 +708,9 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 	const size_t q_size = __struct_size(q);
 
 	if (__builtin_constant_p(size)) {
-		if (__compiletime_lessthan(p_size, size))
+		if (statically_true(p_size < size))
 			__read_overflow();
-		if (__compiletime_lessthan(q_size, size))
+		if (statically_true(q_size < size))
 			__read_overflow2();
 	}
 	if (p_size < size)
@@ -730,7 +725,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 {
 	const size_t p_size = __struct_size(p);
 
-	if (__compiletime_lessthan(p_size, size))
+	if (statically_true(p_size < size))
 		__read_overflow();
 	if (p_size < size)
 		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, p_size, size, NULL);
@@ -742,7 +737,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 {
 	const size_t p_size = __struct_size(p);
 
-	if (__compiletime_lessthan(p_size, size))
+	if (statically_true(p_size < size))
 		__read_overflow();
 	if (p_size < size)
 		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, p_size, size, NULL);
@@ -755,7 +750,7 @@ __FORTIFY_INLINE void *kmemdup_noprof(const void * const POS0 p, size_t size, gf
 {
 	const size_t p_size = __struct_size(p);
 
-	if (__compiletime_lessthan(p_size, size))
+	if (statically_true(p_size < size))
 		__read_overflow();
 	if (p_size < size)
 		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, p_size, size,
@@ -793,7 +788,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		return __underlying_strcpy(p, q);
 	size = strlen(q) + 1;
 	/* Compile-time check for const size overflow. */
-	if (__compiletime_lessthan(p_size, size))
+	if (statically_true(p_size < size))
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-- 
2.39.5

