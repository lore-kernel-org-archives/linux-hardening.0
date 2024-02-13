Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D605062804
	for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862264; cv=none; b=Y3yVcq6fw3+9oTC8NXGNor/kYTdvX6uYyMOHqm9bRYRY05nEYyZqfubcAP4WM6ZHk+HkD3UA03elwKSFHChf7GmhJR5tQoHqqSYLlpZFD38MKJvWDA3JdTSbDxZujaH0PFn6z9lwS2EeIzm0ycZNpnmQgPWaZ0/Ze9XP9l6qMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862264; c=relaxed/simple;
	bh=w7zw3RDumDcJw4/l4C5YmBZxl4Zt2x5/fyHOMuQVKJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7jGDDdqC9sN5dNnUOslhZ6tf6oOslgPvYch4jIk8Q19GZlPmCPVl9/udehjdjA2q80YlPqARFqtL7jQA5cH1oS2sabAtmYs3fQ9U3UkJ4moWVUUpcY9aAH6DC4gTi7E0o6f2EraT3Jlo6EFD37T2CvKuTlk+raopAgdFfY6I+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BTph8EnT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BTph8EnT"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d71cb97937so46678295ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 14:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707862262; x=1708467062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq+faa+uRnVdoYt5O1MIXKxtE4nBr6/M5LGffuvux8w=;
        b=BTph8EnTNQY9ngXMcbbMYn8NCRgzv6DueVRHqDpFZ4jhdFdbY6EqwZEaDkmRdtAEGN
         Fh3NW/TSwP8io3RKGPM44hVGwmanJtIMatiSjJw0ad7vbOTtfhY15M3pcHYWSassdsA/
         NP7YiHTpVxPDrMjT0Lc87WpnR5AhrxBBcwgRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707862262; x=1708467062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq+faa+uRnVdoYt5O1MIXKxtE4nBr6/M5LGffuvux8w=;
        b=ZwpevYHmfI7Z5dzSY/uWdloR5tSqBImDAGguRN89SOTY8y0uJHRzRvgjlyXyaJkzuj
         y1v6qHTPJGbBgHUT6jonF413d+4uDZDsZT0HSrT5UjADKNR5BY3Vj9WfQ27ZD14ikeWb
         iSSP8nHv/37PCZ+SGhtPuNvHaaEBGUuae4ukFfztrfB0o5+fhXpv2SrWh7mzi59HgA5d
         d3yenYDqxgsSFbVN189kQZu+8FcN01AWNbzlHhitmbpk+DqfXH4bQmCzXaZRdq6BCsS5
         P8AraLtdKCkfOI3SOq4Xmhp0/wvFwAo83BEaiNHw5SipbO4iT7OfJYHFAxXFay9OsV2u
         gE5w==
X-Forwarded-Encrypted: i=1; AJvYcCUApA9vVvZibb1PJiq334Xv92yn6pi5tRES1LocqK2y0Pi0R5tKNYalTR5OiRhzAvf6UgmkOeOfZi7WSvtOHd9lxrchfFFZZtel2Z6hmquj
X-Gm-Message-State: AOJu0YzFZvXZ94bz9yDXcSOHfHFTllw6eMCgB7IhJnYgFxxdNg/NX6gh
	kHfuslDpTe3R6b8/Hx4L67rbJ5+tQ9O+zmGpX/nU6qvENiHlPkFkqdfLqkbbSw==
X-Google-Smtp-Source: AGHT+IFuhevrT3Pn4bFgm7Hx0HxMfpSrXLGky9NJYUCWEAFrL/RInQHp8nrpw7xdfCONhsqflR4vgg==
X-Received: by 2002:a17:902:c106:b0:1db:2ad2:6501 with SMTP id 6-20020a170902c10600b001db2ad26501mr846839pli.47.1707862262251;
        Tue, 13 Feb 2024 14:11:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfsMXWI9wSc/hKos78Dh7EFaVBrFk1uq7D5K1pro/Flltvy7lLL625xtkYXBRpkX8Zq8qj8yhH9pZkpU8VZ3BaO7ZeaV5yb2xk+WoT5qN8lhUpGnOmKc7Fn0jOqPk3xQIcHwAxNcQaLlllkB11WhWnBUZW0QOmp2P/NVRLJVJ5aUysqpLj7Ps4MvYYjcSbu73Kcp5krjacV/rZz9TpDCBcn09YGc8QZzA6LZn1yBTRAM6HpIKh63cfLtYarQxOg79z2WMkTy4TT96qMe1SMD9DdYWmBHdAhG8E7hRdxQgbu23y3+VYFyo5pytbB+ofyP/VMJjFgquF5A==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001d8f81ecea1sm2531294plp.172.2024.02.13.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:11:01 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] overflow: Introduce wrapping_assign_add() and wrapping_assign_sub()
Date: Tue, 13 Feb 2024 14:10:59 -0800
Message-Id: <20240213221100.3556356-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220844.it.345-kees@kernel.org>
References: <20240213220844.it.345-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4679; i=keescook@chromium.org;
 h=from:subject; bh=w7zw3RDumDcJw4/l4C5YmBZxl4Zt2x5/fyHOMuQVKJ0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBly+jzo8h8GwH2EtVZTjBhXMhC4DMegJkHNB+k7
 lYuBbCOfMCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcvo8wAKCRCJcvTf3G3A
 JsPjD/9Azkvy9kxSMrniMPJ+LGPUl/M+RKbUrzU+zP9jToskR7pC94WwXHn1fCwodshc0LbJV6c
 z+vDxi+VWJFHccxl2QWClIfZbMv2/ITVxAMoNrSjLWV7/fRpUNL7SHeKwwgbPNwsYyWqhFGdBpk
 zlhaFVhzlHbGdI+42Wqsjc/oQCR2zPbfngje7EX7WChZi0eU4rUOzjfLiyKwHaOtZapXLkUPHJ1
 eFsPwzvQTU68dQnQvs0G1Q74LFLUJhhNeTi8KeYrtND1o46VBtHSucW2zc1qTfCjcqMSlyc4pTR
 8oh46/zxjPUAb7tGjCdQUAYvkiLWD+qNW6zluKXlGURltHSO8bzHb0Hn/qqbbfdPXSCBInD6vv9
 qtZbmj+JXE3y56VSK9rbaEBp1v8327SkolPTmxttjf92xb521/I2UzJUkYwtPb1Q3tiVvzhhxN5
 ldO7XiEo+EbHRFk78hx9PvjxO0PPw+lOjn+8AjsPsqGwjIcdvhHXdqnWr3f0tdwNWLng1upEt3J
 HM/SneD+0nCIf5wVQN/Tw/WesXDeb47hzgKF+uhvzQpYCVBizDll+kIFt7pcN8GUA62aOSuzT33
 JpwcVMsG5DDI+0S6WscVCu8gk0Q+NepEkvltVa9sioHq3andA9Yhp7ZgaFZC+4n4NQXyilD1ODc INpWqjU1LHccF3A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This allows replacements of the idioms "var += offset" and "var -=
offset" with the wrapping_assign_add() and wrapping_assign_sub() helpers
respectively. They will avoid wrap-around sanitizer instrumentation.

Add to the selftests to validate behavior and lack of side-effects.

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marco Elver <elver@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 32 ++++++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 849a49fb496e..09019b19876f 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -80,6 +80,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;						\
 	})
 
+/**
+ * wrapping_assign_add() - Intentionally perform a wrapping increment assignment
+ * @var: variable to be incremented
+ * @offset: amount to add
+ *
+ * Increments @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
+ *
+ * Returns the new value of @var.
+ */
+#define wrapping_assign_add(var, offset)				\
+	({								\
+		typeof(var) *__ptr = &(var);				\
+		*__ptr = wrapping_add(typeof(var), *__ptr, offset);	\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -109,6 +125,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;						\
 	})
 
+/**
+ * wrapping_assign_sub() - Intentionally perform a wrapping decrement assign
+ * @var: variable to be decremented
+ * @offset: amount to subtract
+ *
+ * Decrements @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
+ *
+ * Returns the new value of @var.
+ */
+#define wrapping_assign_sub(var, offset)				\
+	({								\
+		typeof(var) *__ptr = &(var);				\
+		*__ptr = wrapping_sub(typeof(var), *__ptr, offset);	\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index d3fdb906d3fe..65e8a72a83bf 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -284,6 +284,45 @@ DEFINE_TEST_ARRAY(s64) = {
 		"Unexpected wrap " #op " macro side-effect!\n");	\
 } while (0)
 
+static int global_counter;
+static void bump_counter(void)
+{
+	global_counter++;
+}
+
+static int get_index(void)
+{
+	volatile int index = 0;
+	bump_counter();
+	return index;
+}
+
+#define check_self_op(fmt, op, sym, a, b) do {				\
+	typeof(a + 0) _a = a;						\
+	typeof(b + 0) _b = b;						\
+	typeof(a + 0) _a_sym = a;					\
+	typeof(a + 0) _a_orig[1] = { a };				\
+	typeof(b + 0) _b_orig = b;					\
+	typeof(b + 0) _b_bump = b + 1;					\
+	typeof(a + 0) _r;						\
+									\
+	_a_sym sym _b;							\
+	_r = wrapping_ ## op(_a, _b);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _r == _a_sym,			\
+		"expected "fmt" "#op" "fmt" == "fmt", got "fmt"\n",	\
+		a, b, _a_sym, _r);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _a == _a_sym,			\
+		"expected "fmt" "#op" "fmt" == "fmt", got "fmt"\n",	\
+		a, b, _a_sym, _a);					\
+	/* Check for internal macro side-effects. */			\
+	global_counter = 0;						\
+	wrapping_ ## op(_a_orig[get_index()], _b_orig++);		\
+	KUNIT_EXPECT_EQ_MSG(test, global_counter, 1,			\
+		"Unexpected wrapping_" #op " macro side-effect on arg1!\n"); \
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
+		"Unexpected wrapping_" #op " macro side-effect on arg2!\n"); \
+} while (0)
+
 #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
 static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 {									\
@@ -293,6 +332,10 @@ static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
 	check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);	\
 	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
+	/* wrapping_assign_{add,sub}() */				\
+	check_self_op(fmt, assign_add, +=, p->a, p->b);			\
+	check_self_op(fmt, assign_add, +=, p->b, p->a);			\
+	check_self_op(fmt, assign_sub, -=, p->a, p->b);			\
 }									\
 									\
 static void n ## _overflow_test(struct kunit *test) {			\
-- 
2.34.1

