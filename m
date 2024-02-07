Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1A7F7C6
	for <linux-hardening@vger.kernel.org>; Wed,  7 Feb 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319466; cv=none; b=HmrkFpEr5I5qTdUxV4lWVp77KY7gWf2i6dWBk9BniPs2EwwoEVoMCO0Blg+BBJN6UfNqb6xSdUm9ImpTHBddeGTR94USmjNvR40JsWyrnvNIpwl5oDg9leRRko4Ed3/y7S7e5D31anq2VFjxThHcrwJuDRvSeQ9PvLlGF3m5lz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319466; c=relaxed/simple;
	bh=b+f38qUkFmR/TObhuk4Sc9oAIjIVix3f9cue4x2E+Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PPp97U/VUspyHGFF1zxQ/+c89y+19GSyEXkqQyi3G0M0KWdF2y3mpQPTON8aW0NeXQgelys+azXRaG2oiTF2kIWa+JCNIBNsm5+PK1pxA9ipvOdoDK2762q/UNNxy/ILq56IX49gTH5qnOoTqGGkQsQHTGnfIhSFG1x6mxsCKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JBIVdMvP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JBIVdMvP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e05b72fd56so489237b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 07 Feb 2024 07:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707319464; x=1707924264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS67DoS9siTadX6XoYgXOlZJ6JIdy0dS80ufVgX7tK4=;
        b=JBIVdMvPNnF6RPdgl2iHwXIbNLUqX4G7NT3Z1lxSja6MxJ0WB/vOyTPXo1Z3BybPcn
         euhxJWI55qkUCiy8dRVsNqsk2HGkPNJSPlAYwVV2yXkccPV8+uczQpApNtmCOGOIVXqP
         wgtWanZYVTpfRlH9zKTr5yHvyD5xprBFphUHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319464; x=1707924264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS67DoS9siTadX6XoYgXOlZJ6JIdy0dS80ufVgX7tK4=;
        b=axqiCzr+gtEjkf+bb5k4pzvrFcP5WHyJROmBpV2MmRfAImRx01WorxbA0in4wtIOuw
         JbO3dGalzWc+YymSM6ej2u2MUbrL/zwOg4wzGZoGNV5z/6rDGyg3uZNhb8kguk2P6qa0
         +vwdiYFN0uTuCkTHYmKiZ4zA+eLRpYD6vy6VE6rtWYZIWvb1oSROlzIp54/oIQDUB9E2
         DY00YlUNYUD+UxPZAofsRT/pm1wwDfoPpAczSdpxASt4RD/oBbaggfqH28pMq3ELT+eh
         3FKl1u/DV7rsZpINbcYFplxfbhGCLzmp/nQLLNELw1xVJW5HTOSB5Cyj49bul4+UlUqL
         /00g==
X-Gm-Message-State: AOJu0Yx9OYGSVP42jsBoiXNY4CZ/KtbcpfL6tBD6XAWbNnxf0YC02KTk
	YwxIFYVPGuGWD7tsbExdu198nc5cvpw1H55WP04CvZYz6YVY7PD5xspKBXyr8A==
X-Google-Smtp-Source: AGHT+IFUcocC4XnpVqDe2Cc7L4KZjuB8L7+KvILaGiDKsEtkE1PiI1j//YdGAhxS7w+NThyiBJAs1g==
X-Received: by 2002:a62:e808:0:b0:6e0:4759:88f2 with SMTP id c8-20020a62e808000000b006e0475988f2mr2859734pfi.4.1707319464393;
        Wed, 07 Feb 2024 07:24:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXBOpyOHYtegSSIq/IJhy7kL4duoh6ZuyM5qMboZBxX/G7RrHYR++R99WNEcOUnXI6KnarH1HZ5u6ABO+0tqmLJVid+lKKcT9YVau0ZRDJHdHc4m95pvTSHf3bTIk5MuY08HX1ap36lOpemY6l+UV8UzdnHJhSwvS3EFIK4pdxx+hnHKCgOJABdIIdAVxtKAiSoKW06bUcIT3zzIzGYU3ICiTZwFXNny7dl9xkyshUOm6kfpCcbizEGaSpaDiBBhV6dJtBuqwaamzv3R66PGhtnBIm6ttIdELZ1YxBN3bhzXbzECLj5lc4vp9Air1FskXIpdiNhKpISQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m9-20020aa78a09000000b006ddcfbe736esm1754674pfa.97.2024.02.07.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:24:23 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
Date: Wed,  7 Feb 2024 07:24:19 -0800
Message-Id: <20240207152422.3855315-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207152317.do.560-kees@kernel.org>
References: <20240207152317.do.560-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5602; i=keescook@chromium.org;
 h=from:subject; bh=b+f38qUkFmR/TObhuk4Sc9oAIjIVix3f9cue4x2E+Fo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlw6Cj3wFGEbnwDxyh6eIuINKUEK64qoLls8qiq
 SfHBN0h+Y6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcOgowAKCRCJcvTf3G3A
 Jv6xD/0XhE55ZAZLm9uMEhycDNqaeAR5W6+/KhWbDn/Fk6wA4T2KzKrV/PJHcl/ZDfJm533RMVj
 zZa0cP44ZXsejZND+BZzJ7dYJo1Pq5Et5DRjQRd63Af6SIACjAIDJvG/LWKHQjexVvZJP+ykAGA
 7SbXzpne4OjrZRbKXRt2lJxcpX8zT4Q1Yn7OYX0GWkH5Z2gtw6Qe3SqAFud1knCAZrwXI4de+bX
 mfucHuDRhytInGLFdYr/Nz48LdqGJQnxfCKmNhpVANcNPo3eR3j7ewlieG6aNl+b90hfVp8nobx
 Y4Idi/+T9KgnAXzSlujsb3yrLQbvnuRD96Y3ZnUfhZ71XB8q2APa29ZUZ7d0Gzc99/7S5aVBBcE
 d6gjh5HU2kg5lvRhlC/sM2oHaXaDabBqF0Xr02kmjxhkEFwSDRvcnUPWtR2v0G4glcdyKNrHqOV
 ArLh8Gdm2sTR7g4XhC+vChZJgdYcsUlNvFX6eUWa8hOkNyrwtuxQN6+ZxiwWJZa8RTLMFhEg+Qh
 aA9I0WyCdp6VadzwkgEeG8uiB4RvFRRN4eW5P6DpvHSP0suL2BvDAO7h0m1b/Dg7OyCyVWr6BS9
 s5eY5y5+Q7w6lzkWhBCEQM31XmSxe8oNASCpnUbQWnKZUVQVoq4QBDiiKqOSfjANccJdqNiElA1 0q9RcTfa1raCYew==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Provide helpers that will perform wrapping addition, subtraction, or
multiplication without tripping the arithmetic wrap-around sanitizers. The
first argument is the type under which the wrap-around should happen
with. In other words, these two calls will get very different results:

	wrapping_mul(int, 50, 50) == 2500
	wrapping_mul(u8,  50, 50) ==  196

Add to the selftests to validate behavior and lack of side-effects.

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marco Elver <elver@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 48 ++++++++++++++++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 24 ++++++++++++++++----
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4e741ebb8005..849a49fb496e 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -64,6 +64,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
+/**
+ * wrapping_add() - Intentionally perform a wrapping addition
+ * @type: type for result of calculation
+ * @a: first addend
+ * @b: second addend
+ *
+ * Return the potentially wrapped-around addition without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define wrapping_add(type, a, b)				\
+	({							\
+		type __val;					\
+		__builtin_add_overflow(a, b, &__val);		\
+		__val;						\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -77,6 +93,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
+/**
+ * wrapping_sub() - Intentionally perform a wrapping subtraction
+ * @type: type for result of calculation
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ *
+ * Return the potentially wrapped-around subtraction without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define wrapping_sub(type, a, b)				\
+	({							\
+		type __val;					\
+		__builtin_sub_overflow(a, b, &__val);		\
+		__val;						\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
@@ -90,6 +122,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
+/**
+ * wrapping_mul() - Intentionally perform a wrapping multiplication
+ * @type: type for result of calculation
+ * @a: first factor
+ * @b: second factor
+ *
+ * Return the potentially wrapped-around multiplication without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define wrapping_mul(type, a, b)				\
+	({							\
+		type __val;					\
+		__builtin_mul_overflow(a, b, &__val);		\
+		__val;						\
+	})
+
 /**
  * check_shl_overflow() - Calculate a left-shifted value and check overflow
  * @a: Value to be shifted
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index c527f6b75789..d3fdb906d3fe 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -258,20 +258,36 @@ DEFINE_TEST_ARRAY(s64) = {
 									\
 	_of = check_ ## op ## _overflow(a, b, &_r);			\
 	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
-		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
+		"expected check "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
 		a, b, of ? "" : " not", #t);				\
 	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
-		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
+		"expected check "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
 		a, b, r, _r, #t);					\
 	/* Check for internal macro side-effects. */			\
 	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
-	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
-	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump,			\
+		"Unexpected check " #op " macro side-effect!\n");	\
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
+		"Unexpected check " #op " macro side-effect!\n");	\
+									\
+	_r = wrapping_ ## op(t, a, b);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
+		"expected wrap "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
+		a, b, r, _r, #t);					\
+	/* Check for internal macro side-effects. */			\
+	_a_orig = a;							\
+	_b_orig = b;							\
+	_r = wrapping_ ## op(t, _a_orig++, _b_orig++);			\
+	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump,			\
+		"Unexpected wrap " #op " macro side-effect!\n");	\
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
+		"Unexpected wrap " #op " macro side-effect!\n");	\
 } while (0)
 
 #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
 static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 {									\
+	/* check_{add,sub,mul}_overflow() and wrapping_{add,sub,mul} */	\
 	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
 	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
 	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
-- 
2.34.1

