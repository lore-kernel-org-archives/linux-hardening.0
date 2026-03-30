Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384373CFF7F
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876815; cv=none; b=M3QbUIDw4HfCqgqnrRA7oPdHITpyM1lXersIn4cH630YQu48dVfrnq5Kf8VdJJPWecfNPCTMnM2EpX6pFYHA1gXo/2EggqsSYAmJraUxNQYn7fOd366mQLM5MpRRMlRqFcXQJx0dEnMsl64Kd663+tpF7MeWWqBGErKcX+P5Y5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876815; c=relaxed/simple;
	bh=HZW2oqrFDucg0/tmmpLC50psVTIubhNBRGZjkaePAI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrlHgl6Q9eHF64zujxo6NBJ+WIJEM7MA/rURolPBZ6usUCA8INiC0GDdGB6eyb2IOXbMm+iBq6BLDtDHA/Uxq2DdmLG76r6FI+6osbqKmuqfV72pB89vkIVfIMWgLIuDmTI3eMOLB0/kw2ZP7zCyWUXZDc4mNPQnB+LZfJh1h6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdnnS/2x; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdnnS/2x"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso36565825e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774876811; x=1775481611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WJtJ9/xLPusko++aTLmU08qrObcTNq16sGagCzREHs=;
        b=GdnnS/2x7M/gzkx8TdzaO6tcuA7ISCTZ9TKbEhQFYqtIN4AaqiXtX9cNSuA9UCJdMy
         ISQ136dV4UwrpoE5JyBh9Err4cwD6DQdXZ8J5Y5RGDesK6ryp0dXeS980Xm8wybxrHdF
         keGf13qEoapkuwFGkvTQJ79uElru548gVBQ8EOJElrmo31YzbGfY2RcQxE/u1L9iDP7x
         qsYCJ2PkyhaGzIQml7edja9N9pFJyQkH41h10H9tmMQc3VM5niK4gCR7mOl2DMdr7JGX
         l+KYZskbyyUTKhOsko3+EtqiEK9aYxyaQxM1V2zZNx+gSvibFn9/OUJl8gF1JTGPWq6P
         w/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876811; x=1775481611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WJtJ9/xLPusko++aTLmU08qrObcTNq16sGagCzREHs=;
        b=P2wOWqSIHpOSJ7PbnhVdCr/N34mA1XiNNmR/3BF9v8/Wqjl+hFB71k1dftS4Ir2Av1
         j58N2lgynYkDjE8swMu/gAcsa9Rxn2Sm5M1U1X3DX3gaC2I+upgxPHZ4oaiVi9TCZwZQ
         okcLSsuTn+reYSf5qMy4cEG158xZG+3ZRDh+Wuomz2CRATgCTgGV2momnmWXtazb2If5
         l/3OemhBYmpnlIehsXGU9tWXCKRwHZUzpGKuo6Q4RbWYKNW4JAyIDtd34j7qYUYCM+4Y
         0Js+98+7jQt1l8IPGcslLvTcKEtcIQ8NlA/FG9GLpFOCejLbXNCTgK1pk8crFCMHb3TO
         fnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6FNSaWjrkP6w6zFyBDV38mKF9F1od2KKrwftlTJdtLyoMxIiqdq9XyiZ8GhYNlnPF7pVTv/yWMhkgkxeKP+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIymG4CjHpnytwdv2dx8xbP+JwSf1BAQSCVbswQeWFayc7UL5
	JxYz7eoKGmkVAQ/bUM/Tadi2yaThkRTbKa57eWWfz/fHqODodOOyGRf3
X-Gm-Gg: ATEYQzwF5IMJhn4i6INR7TrEcgRLf9aMxUdtmVGCRkbJAv7crOtxrW+LtFbY29wvVNC
	g2HSee2EzXZtd+h5hPQLXm9yd0m/Kt6qB086kerQVi0AUj3WfTxz1i6FpvZn+gyRwOCTHZDyBGs
	5DY8kixZoi15DZqYwsHDCUurdSZgRGi7KmUp/DqXnQkp5CVXbGgPZwniYAPXvqJqlmRJL8j2DVA
	whTd6rr8Rxne7eXIkjUZ5sG83+qSfYsbiSn3XRwf3GUWawAT3STc0iobV+lyo14IbODs3JvH6Ke
	6nISD7eachjbNak1uIUjn8WE2zEPKj0M1MBHUi9ElHOnQetBGmWNLqItuOwEaN8K9+M4N76ko4g
	uJMD/hfN3RPlDn17dMRGvgBlnRl/7ezB9U++U5L2s4L3H0A38TZY3YngaCJ/CiFlE2yTRXAh9dh
	Vy1r2f8HGs/qhfbVLsllfjRQOdY673840I4QSWi7PmyWjHup+XaZla+kcc0ynHAzWq4TT72BKSt
	vy+mRNGy+ZixPA2ts8=
X-Received: by 2002:a05:600c:154c:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48727ede0admr214729635e9.24.1774876810462;
        Mon, 30 Mar 2026 06:20:10 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eb52e5sm81322315e9.7.2026.03.30.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:20:10 -0700 (PDT)
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next 2/3] fortify: Optimise strnlen()
Date: Mon, 30 Mar 2026 14:20:02 +0100
Message-Id: <20260330132003.3379-3-david.laight.linux@gmail.com>
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

If the string is constant there is no need to call __real_strlen()
even when maxlen is a variable - just return the smaller value.

If the size of the string variable is unknown fortify_panic() can't be
called, change the condition so that the compiler can optimise it away.

Change __compiletime_strlen(p) to return a 'non-constant' value
for non-constant strings (the same as __builtin_strlen()).
Simplify since it is only necessary to check that the size is constant
and that the last character is '\0'.
Explain why it is different from __builtin_strlen().
Update the kunit tests to match.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/fortify-string.h | 44 +++++++++++++++++-----------------
 lib/tests/fortify_kunit.c      |  8 +++----
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 214d237214d5..758afd7c5f8a 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -58,19 +58,22 @@ void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("
 void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
 void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("detected write beyond size of field (1st parameter); maybe use struct_group()?");
 
-#define __compiletime_strlen(p)					\
-({								\
-	char *__p = (char *)(p);				\
-	size_t __ret = SIZE_MAX;				\
-	const size_t __p_size = __member_size(p);		\
-	if (__p_size != SIZE_MAX &&				\
-	    __builtin_constant_p(*__p)) {			\
-		size_t __p_len = __p_size - 1;			\
-		if (__builtin_constant_p(__p[__p_len]) &&	\
-		    __p[__p_len] == '\0')			\
-			__ret = __builtin_strlen(__p);		\
-	}							\
-	__ret;							\
+/*
+ * __builtin_strlen() generates a compile-time error for 'const char foo[4] = "abcd";'.
+ * But that is a valid source for both strnlen() and strscpy() with a constant
+ * length less than or equal to 4.
+ * __compiletime_strlen() returns a non-constant for such items.
+ * Beware of strings with embedded '\0', __builtin_strlen() can be much smaller
+ * than __member_size();
+ * The return value must only be used when it is a constant.
+ */
+extern size_t __fortify_undefined;
+#define __compiletime_strlen(p)							\
+({										\
+	char *__p = (char *)(p);						\
+	const size_t __p_size = __member_size(p);				\
+	__p_size == SIZE_MAX || !statically_true(__p[__p_size - 1] == '\0') ?	\
+		__fortify_undefined : __builtin_strlen(__p);			\
 })
 
 #if defined(__SANITIZE_ADDRESS__)
@@ -215,16 +218,13 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	const size_t p_len = __compiletime_strlen(p);
 	size_t ret;
 
-	/* We can take compile-time actions when maxlen is const. */
-	if (__builtin_constant_p(maxlen) && p_len != SIZE_MAX) {
-		/* If p is const, we can use its compile-time-known len. */
-		if (maxlen >= p_size)
-			return p_len;
-	}
+	/* If p is const, we can use its compile-time-known len. */
+	if (__builtin_constant_p(p_len))
+		return p_len < maxlen ? p_len : maxlen;
 
 	/* Do not check characters beyond the end of p. */
-	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
-	if (p_size <= ret && maxlen != ret)
+	ret = __real_strnlen(p, p_size < maxlen ? p_size : maxlen);
+	if (ret == p_size && p_size < maxlen)
 		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, p_size, ret + 1, ret);
 	return ret;
 }
@@ -289,7 +289,7 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
 	if (statically_true(p_size < SIZE_MAX)) {
 		len = __compiletime_strlen(q);
 
-		if (len < SIZE_MAX && statically_true(len < size)) {
+		if (statically_true(len < size)) {
 			__underlying_memcpy(p, q, len + 1);
 			return len;
 		}
diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
index fc9c76f026d6..9b3b7201c02d 100644
--- a/lib/tests/fortify_kunit.c
+++ b/lib/tests/fortify_kunit.c
@@ -102,11 +102,11 @@ static void fortify_test_known_sizes(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen(unchanging_12), 12);
 
 	KUNIT_EXPECT_FALSE(test, __is_constexpr(__builtin_strlen(array_unknown)));
-	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
+	KUNIT_EXPECT_FALSE(test, __is_constexpr(__compiletime_strlen(array_unknown)));
 
 	/* Externally defined and dynamically sized string pointer: */
 	KUNIT_EXPECT_FALSE(test, __is_constexpr(__builtin_strlen(test->name)));
-	KUNIT_EXPECT_EQ(test, __compiletime_strlen(test->name), SIZE_MAX);
+	KUNIT_EXPECT_FALSE(test, __is_constexpr(__compiletime_strlen(test->name)));
 }
 
 /* This is volatile so the optimizer can't perform DCE below. */
@@ -128,12 +128,12 @@ static noinline size_t want_minus_one(int pick)
 		str = "1";
 		break;
 	}
-	return __compiletime_strlen(str);
+	return __builtin_constant_p(__compiletime_strlen(str));
 }
 
 static void fortify_test_control_flow_split(struct kunit *test)
 {
-	KUNIT_EXPECT_EQ(test, want_minus_one(pick), SIZE_MAX);
+	KUNIT_EXPECT_FALSE(test, want_minus_one(pick));
 }
 
 #define KUNIT_EXPECT_BOS(test, p, expected, name)			\
-- 
2.39.5

