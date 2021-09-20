Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41548C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 01:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211E661175
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 01:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhIUBea (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhIUBeU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 20 Sep 2021 21:34:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C60C124A53
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 11:08:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t4so11662834plo.0
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hidIkJOKxCMVjbSvcxBw4U/mexFomA4sB5K9H+f3WZo=;
        b=YW3OQ3doANQVp1KjDrjbbQtADmm1NDefevCVHKSXV34nKQJGQAZ9M4ueYT8C1vliki
         ENy7So7EsVBBjS37/XBuJinomCdYV1rAxvWqc+WgBbiOmshS2xMYgICQOYn2dJ7Ilgx0
         9YyQIHcTNeDh+hTu2oK81q33SDgK7xCE0e/EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hidIkJOKxCMVjbSvcxBw4U/mexFomA4sB5K9H+f3WZo=;
        b=37qtc6Rs5JzDjPXsxBNoGQy3VewTvzJxDySKdSPFMwwcnePXST9mkZr3vVWzSsevhn
         +ej8x06L1llN6JI8wXBd3pLzHyBoRv963S9P5zWoQakWHDdUrNvXwXUQMbalt7AKhxbc
         37+oVT0ziJo1Mfbjaa4vHfKNcLaYtBpiCm/awIFhqdQxc31EF4RQJfm5ozV0GTEgOlw5
         cY/1s9oYEp8rB5nHCrCumY3BLaBCwiDvmVTLoRkWxPa0edcdtC3w429cRawKCuyI1zdl
         UqAtVj+BPexGVyXVIcqvqsBer/xYeURqXTLartltJhRU3TomJ2mhXbAzfuwW4t2Exqhq
         F1WA==
X-Gm-Message-State: AOAM533MYpKEAvXK4L18jyZGckPqewKvqA97qnIoiG1cLR5D7j7YFP3m
        nDNkUdTYUNjprUtlR0ijDCrUSNAmNjL++A==
X-Google-Smtp-Source: ABdhPJyTejndKcYPkqiARVizqhdRS/CsuWoMu0OGDr/hDpO999aoEAPPh/CMIwMPA3BVgYw8G0hldw==
X-Received: by 2002:a17:90a:86:: with SMTP id a6mr347372pja.190.1632161337429;
        Mon, 20 Sep 2021 11:08:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 126sm17743348pgi.86.2021.09.20.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:08:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] overflow: Implement size_t saturating arithmetic helpers
Date:   Mon, 20 Sep 2021 11:08:52 -0700
Message-Id: <20210920180853.1825195-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920180853.1825195-1-keescook@chromium.org>
References: <20210920180853.1825195-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10506; h=from:subject; bh=aYbE79r+2GzCEDXJOePs8DpTGJtx17vsz1taPQytKw4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhSM40XMzPcxqU+i87Qyjr/YrDY3MzjZfDUSZglvKq R2vvk2GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYUjONAAKCRCJcvTf3G3AJoNaD/ 9wzLJ/LA3yNwGiPPhyoEIXSh1K0Rf/I36tZrncmN75R61nEQiYBnSu2FKF3W8XjD75O1hSzIVAx/Kq qyJJkUu605H9OfKnkz7n3a1o/g1wQaNbBq2raVXcRiB2kHiFMt+jYjIsZJlGPmnSfjHOq73McArMR7 pvEy1Yf9CwFgIeT3CSONCDoj7fEtXgwUUoFcQBFcZfgWIas97wDlYZ/8ku+/YiPbv6OGCcVWvhC3xZ DjsocvAkjbY0pEzsZ41xoadoSr+3vprdTz4YUFAJxJKTS1Qu47qdOIHqF0/KSgz14sYZR13HoSemmP ukglbTAIHWuUI1h9Ku5gi5DqQqRINyJ+wq4x3bJg6aKSSOOiwjop4HjpP2qEsBHQeZURGQgBOp4hqu 0b9N7nwDNxvokaNW1GP9s1t+0r8u3Eggyowe4J1LbW+PUg4dvfpZ3tCVGY7a/D6xvVmaVPhSx97Tf5 wc+g8r/XbEy7HGauYJC9fHeiiQVy4Ij/SvXjuc2Qs8lGePBslFp1fcw9qBhynkKh7p1p9OjMlaWu/s oCNu/MhPjRL/r4s98GTmoNnFGbwAIyXzP0GAE5gGAW6T9aHfxY/nlH/2bZfUTwHFzbrzzU2ioI+joU N4fI9jmwd4MyZ1LN4ItVowhoenl91k9s8r61KFXekm10pKLJts6qdSri5uog==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to perform more open-coded replacements of common allocation
size arithmetic, the kernel needs a saturating (SIZE_MAX) helper for
addition and multiplication. It is common in allocators, especially on
realloc, to add to an existing size. For example:

        p = krealloc(map->patch,
		     sizeof(struct reg_sequence) * (map->patch_regs + num_regs),
                     GFP_KERNEL);

There is no existing saturating replacement for this calculation, and
just leaving the addition open coded inside array_size() could
potentially overflow as well. For example, an overflow in an expression
for a size_t argument might wrap to zero:

	array_size(anything, something_at_size_max + 1) == 0

Introduce size_mul() and size_add() helpers to perform size_t promotion
and saturated calculations for use in such allocations. With these
helpers it is also possible to redefine array_size(), array3_size(),
flex_array_size(), and struct_size() in terms of the new helpers.

As with the check_*_overflow() helpers, the helpers are wrapped in a
__must_check function that passes through the size_t result. In order
for the helpers to be composed with themselves, they must have unique
variable names to avoid shadowing, so this uses a similar method to what
is already done in minmax.h for constructing unique names to be passed
in as arguments to the statement expression that does the actual work.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Len Baker <len.baker@gmx.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 140 ++++++++++++++++++++++++---------------
 lib/test_overflow.c      |  61 +++++++++++++++++
 2 files changed, 149 insertions(+), 52 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4669632bd72b..cd154d47807c 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -117,6 +117,77 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	(*_d >> _to_shift) != _a);					\
 }))
 
+/*
+ * As with __must_check_overflow() above, this is used to wrap the
+ * size_t output from a statement expression macro.
+ */
+static inline size_t __must_check __must_check_size(size_t size)
+{
+	return size;
+}
+
+/*
+ * Internal logic for size_mul(). Takes variable names from UNIQUE_ID
+ * so that the local variables here will never collide with other local
+ * variables (for example, with itself).
+ */
+#define __size_mul(factor1, factor2, __factor1, __factor2, __product)	\
+({									\
+	size_t __product;						\
+	size_t __factor1 = (factor1);					\
+	size_t __factor2 = (factor2);					\
+	if (check_mul_overflow(__factor1, __factor2, &__product))	\
+		__product = SIZE_MAX;					\
+	__product;							\
+})
+
+/**
+ * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
+ *
+ * @factor1: first factor
+ * @factor2: second factor
+ *
+ * Returns: calculate @factor1 * @factor2, where both values are
+ * evaluated as size_t, with any overflow causing the return value to
+ * be SIZE_MAX.
+ */
+#define size_mul(factor1, factor2)					\
+	__must_check_size(__size_mul(factor1, factor2,			\
+				     __UNIQUE_ID(__factor1_),		\
+				     __UNIQUE_ID(__factor2_),		\
+				     __UNIQUE_ID(__product_)))
+
+/*
+ * Internal logic for size_add(). Takes variable names from UNIQUE_ID
+ * so that the local variables here will never collide with other local
+ * variables (for example, with itself).
+ */
+#define __size_add(addend1, addend2, __addend1, __addend2, __sum)	\
+({									\
+	size_t __sum;							\
+	size_t __addend1 = (addend1);					\
+	size_t __addend2 = (addend2);					\
+	if (check_add_overflow(__addend1, __addend2, &__sum))		\
+		__sum = SIZE_MAX;					\
+	__sum;								\
+})
+
+/**
+ * size_add() - Calculate size_t addition with saturation at SIZE_MAX
+ *
+ * @addend1: first addend
+ * @addend2: second addend
+ *
+ * Returns: calculate @addend1 + @addend2, where both values are
+ * evaluated as size_t, with any overflow causing the return value to
+ * be SIZE_MAX.
+ */
+#define size_add(addend1, addend2)					\
+	__must_check_size(__size_add(addend1, addend2,			\
+				     __UNIQUE_ID(__addend1_),		\
+				     __UNIQUE_ID(__addend2_),		\
+				     __UNIQUE_ID(__sum_)))
+
 /**
  * array_size() - Calculate size of 2-dimensional array.
  *
@@ -128,15 +199,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * Returns: number of bytes needed to represent the array or SIZE_MAX on
  * overflow.
  */
-static inline __must_check size_t array_size(size_t a, size_t b)
-{
-	size_t bytes;
-
-	if (check_mul_overflow(a, b, &bytes))
-		return SIZE_MAX;
-
-	return bytes;
-}
+#define array_size(a, b)	size_mul(a, b)
 
 /**
  * array3_size() - Calculate size of 3-dimensional array.
@@ -150,65 +213,38 @@ static inline __must_check size_t array_size(size_t a, size_t b)
  * Returns: number of bytes needed to represent the array or SIZE_MAX on
  * overflow.
  */
-static inline __must_check size_t array3_size(size_t a, size_t b, size_t c)
-{
-	size_t bytes;
-
-	if (check_mul_overflow(a, b, &bytes))
-		return SIZE_MAX;
-	if (check_mul_overflow(bytes, c, &bytes))
-		return SIZE_MAX;
-
-	return bytes;
-}
-
-/*
- * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
- * struct_size() below.
- */
-static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
-{
-	size_t bytes;
-
-	if (check_mul_overflow(a, b, &bytes))
-		return SIZE_MAX;
-	if (check_add_overflow(bytes, c, &bytes))
-		return SIZE_MAX;
-
-	return bytes;
-}
+#define array3_size(a, b, c)	size_mul(size_mul(a, b), c)
 
 /**
- * struct_size() - Calculate size of structure with trailing array.
+ * flex_array_size() - Calculate size of a flexible array member
+ *                     within an enclosing structure.
+ *
  * @p: Pointer to the structure.
- * @member: Name of the array member.
+ * @member: Name of the flexible array member.
  * @count: Number of elements in the array.
  *
- * Calculates size of memory needed for structure @p followed by an
- * array of @count number of @member elements.
+ * Calculates size of a flexible array of @count number of @member
+ * elements, at the end of structure @p.
  *
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
-#define struct_size(p, member, count)					\
-	__ab_c_size(count,						\
-		    sizeof(*(p)->member) + __must_be_array((p)->member),\
-		    sizeof(*(p)))
+#define flex_array_size(p, member, count)				\
+	size_mul(count,							\
+		 sizeof(*(p)->member) + __must_be_array((p)->member))
 
 /**
- * flex_array_size() - Calculate size of a flexible array member
- *                     within an enclosing structure.
+ * struct_size() - Calculate size of structure with trailing flexible array.
  *
  * @p: Pointer to the structure.
- * @member: Name of the flexible array member.
+ * @member: Name of the array member.
  * @count: Number of elements in the array.
  *
- * Calculates size of a flexible array of @count number of @member
- * elements, at the end of structure @p.
+ * Calculates size of memory needed for structure @p followed by an
+ * array of @count number of @member elements.
  *
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
-#define flex_array_size(p, member, count)				\
-	array_size(count,						\
-		    sizeof(*(p)->member) + __must_be_array((p)->member))
+#define struct_size(p, member, count)					\
+	size_add(sizeof(*(p)), flex_array_size(p, member, count))
 
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 7a4b6f6c5473..01a469ff7ff6 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -588,12 +588,73 @@ static int __init test_overflow_allocation(void)
 	return err;
 }
 
+struct __test_flex_array {
+	unsigned long flags;
+	size_t count;
+	unsigned long data[];
+};
+
+static int __init test_overflow_size_helpers(void)
+{
+	struct __test_flex_array *obj;
+	int count = 0;
+	int err = 0;
+
+#define check_one_size_helper(expected, func, args...)	({	\
+	bool __failure = false;					\
+	size_t _r;						\
+								\
+	_r = func(args);					\
+	if (_r != (expected)) {					\
+		pr_warn("expected " #func "(" #args ") "	\
+			"to return %zu but got %zu instead\n",	\
+			(size_t)(expected), _r);		\
+		__failure = true;				\
+	}							\
+	count++;						\
+	__failure;						\
+})
+
+	err |= check_one_size_helper(5,	       size_add, 2, 3);
+	err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  1);
+	err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  3);
+	err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX, -3);
+
+	err |= check_one_size_helper(6,	       size_mul, 2, 3);
+	err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  1);
+	err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  3);
+	err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX, -3);
+
+	err |= check_one_size_helper(0, flex_array_size, obj, data, 0);
+	err |= check_one_size_helper(sizeof(*obj->data),
+				     flex_array_size, obj, data, 1);
+	err |= check_one_size_helper(7 * sizeof(*obj->data),
+				     flex_array_size, obj, data, 7);
+	err |= check_one_size_helper(SIZE_MAX,
+				     flex_array_size, obj, data, -1);
+	err |= check_one_size_helper(SIZE_MAX,
+				     flex_array_size, obj, data, SIZE_MAX - 4);
+
+	err |= check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0);
+	err |= check_one_size_helper(sizeof(*obj) + sizeof(*obj->data),
+				     struct_size, obj, data, 1);
+	err |= check_one_size_helper(SIZE_MAX,
+				     struct_size, obj, data, -3);
+	err |= check_one_size_helper(SIZE_MAX,
+				     struct_size, obj, data, SIZE_MAX - 3);
+
+	pr_info("%d overflow size helper tests finished\n", count);
+
+	return err;
+}
+
 static int __init test_module_init(void)
 {
 	int err = 0;
 
 	err |= test_overflow_calculation();
 	err |= test_overflow_shift();
+	err |= test_overflow_size_helpers();
 	err |= test_overflow_allocation();
 
 	if (err) {
-- 
2.30.2

