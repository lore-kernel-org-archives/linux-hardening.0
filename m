Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D2344036
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790637462; cv=none; b=X8W3A+4uqacY4zdtcCZ+gQ2z7ftveunI4gCGwzZ1hUCO6+mF/sqNGmL4RAUNh2IkmbsTtw7lobRoueT+/RDqfJa912lJf7NtyslyDXvQR8A2xFN+lXDIEJxL2N9NsfyddNST0nX6mXttPgmg7nutfsFNgGuC3sHuYUTzPhnN/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790637462; c=relaxed/simple;
	bh=FxdPtTgdE2/uhkG765+gR/55JNOdKMrSuoFsTXo7ILU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HpGE4TKq7s3AybSD5wuByZHgj6AseU8682dxuiMkE8az1b65+bz/gFv+4coZHB4IBLjvhwL3O/u1wxHVw+FUOZfjSm5zsqaw4wmlGtCn/SvjGR8ZvH5wbvPgGfF5XNCyzlsb8/26va81s9FW4whSVM4VcgZJo4/tkQ9smc97u64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wT6WWr/H; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wT6WWr/H"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86ab8302b54so2820278b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 16:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790637461; x=1791242261; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgYdhHRirzaDeDdzeIxud2Mvl3o2ziyuC0fsYtI2DJw=;
        b=wT6WWr/H+xgd2BYWxQt2in+ibe47zaoPE5JCkfXoy2KBV1KqJnryXSo+Lx9zxojzRV
         SMph2ikU5dhkNz/toD1p4fHZz76f5nZpurAr9y3D5gAPw2opyA3S0GjfBp20/URFd8rJ
         h91MQodCXb8uNsfxNeedYIZOvw1qMc3D9UiVRY8cAc90ESA/f8FJBKdVJoH71oqrRS2S
         Uf/xWvHP65iMAujXBKAuVRRJ04Vhc+CZcjWuBCfev7hsrsYVpmbn8cH7zhXLRKgL3Zy4
         hhKBfF6L8R7tAP7P9vNbdEmiqr3j9Hm3F971gGb9qEL2pSO7XmZE44NPKqI1ZWAKHfso
         srpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790637461; x=1791242261;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgYdhHRirzaDeDdzeIxud2Mvl3o2ziyuC0fsYtI2DJw=;
        b=HnGDSbn+SXkI/xStEyOVAEjixPAwvN/LF/Es8ng88fvA1R1lKqew1+aOkr/jiEbt2y
         /XIBtdFDP2Hc8CMBpa5ASKMpH6+eF78nq3k3lYCTzBptvYFA7Ce13KormXD/ONa9nZea
         mJo1fibDdV32p9swyy9RDXZfknUVtOPZgKAPsbsVZgLkYYwtRrMQgjWmWrBPIoyw/LXX
         a8r4p7o3uCLbbiVrRaC9Pyi26f3Su9CffrLforX+SZgVWAtj8kQCWeC1jF9WQJAiMSOQ
         SOjY6u/PYIfOhp0H52PYobuN+OjJgrzUDrJcZVK55RL7XEgENuAOuVL5cqIUdBGybXKP
         HwWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUwcArR+w8Twl6eYB40wYejpniRP7p8wyu6uNncgKA20JDSIbDEpVEjm1b0BYyfD+m7BycxDJVACPUT8ZF3ac=@vger.kernel.org
X-Gm-Message-State: AFuF++mZIfsHTYUMzwcBE1ZVJIEXvwBUW8BhwNLK/c4jilLMPp3VTtDw
	gB2TZX4ClHrsum5VL/L2djlSuJ3r3OAr31CoERi4SiLvT43uejw/9QNBQKSlCzfuznlpfyrfGzm
	A
X-Received: from pfra18.prod.google.com ([2002:aa7:8e92:0:b0:84a:2e0d:e14f])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e85:b0:881:fffd:26af
 with SMTP id d2e1a72fcca58-881fffd2c53mr4983469b3a.44.1790637460762; Mon, 28
 Sep 2026 16:17:40 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:17:37 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928231737.2092716-1-morbo@google.com>
Subject: [PATCH] kasan: add KUnit tests for __counted_by and __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, thomas.weissschuh@linutronix.de, 
	Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"

The '__counted_by' and '__counted_by_ptr' attributes associate a
flexible array member or pointer member with a struct field that holds
its element count. Supporting compilers use these annotations to
compute dynamic object sizes via '__builtin_dynamic_object_size()' and
perform runtime bounds checking with KASAN.

Add KUnit tests ('counted_by_flex_oob_access' and
'counted_by_ptr_oob_access', guarded by CONFIG_CC_HAS_COUNTED_BY and
CONFIG_CC_HAS_COUNTED_BY_PTR respectively) to verify that:

 - '__builtin_dynamic_object_size()' returns the expected byte size for
   annotated flexible array and pointer members.
 - KASAN detects out-of-bounds read and write accesses beyond the
   annotated count.

Allocate the test structures in 'noinline' helpers and hide the
returned pointers with OPTIMIZER_HIDE_VAR() so allocation-size
attributes and compiler optimizations do not mask the '__counted_by'
and '__counted_by_ptr' checks.

Signed-off-by: Bill Wendling <morbo@google.com>
---
 mm/kasan/kasan_test_c.c | 100 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index b9e167ed5be3..f481183c84f1 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -2201,6 +2201,100 @@ static void copy_user_test_oob(struct kunit *test)
 		unused = strncpy_from_user(kmem, usermem, size + 1));
 }
 
+#ifdef CONFIG_CC_HAS_COUNTED_BY
+struct counted_by_flex_struct {
+	size_t size;
+	int array[] __counted_by(size);
+};
+
+/*
+ * Allocate the struct out-of-line to prevent inherent attributes from
+ * affecting the '__builtin_dynamic_object_size' check.
+ */
+static noinline struct counted_by_flex_struct *
+alloc_counted_by_flex_struct(struct kunit *test, size_t size)
+{
+	struct counted_by_flex_struct *s;
+
+	s = kzalloc(sizeof(struct counted_by_flex_struct) +
+		    size * sizeof(s->array[0]), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s);
+
+	s->size = size;
+	return s;
+}
+
+static void counted_by_flex_oob_access(struct kunit *test)
+{
+	size_t size = 128;
+	struct counted_by_flex_struct *s;
+
+	s = alloc_counted_by_flex_struct(test, size);
+
+	OPTIMIZER_HIDE_VAR(s);
+
+	/* __builtin_dynamic_object_size() should return the correct length. */
+	KUNIT_EXPECT_EQ(test, size * sizeof(s->array[0]),
+			__builtin_dynamic_object_size(s->array, 0));
+
+	/* Out-of-bounds assignment. */
+	KUNIT_EXPECT_KASAN_FAIL(test, s->array[size + 1] = 42);
+
+	/* Out-of-bounds read. */
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, s->array[0] = s->array[size + 13]);
+
+	kfree(s);
+}
+
+#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+struct counted_by_ptr_struct {
+	char *ptr __counted_by_ptr(size);
+	size_t size;
+};
+
+/*
+ * Allocate the struct out-of-line to prevent inherent attributes from
+ * affecting the '__builtin_dynamic_object_size' check.
+ */
+static noinline struct counted_by_ptr_struct *
+alloc_counted_by_ptr_struct(struct kunit *test, size_t size)
+{
+	struct counted_by_ptr_struct *s;
+
+	s = kmalloc_obj(struct counted_by_ptr_struct);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s);
+
+	s->size = size;
+	s->ptr = kzalloc(size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s->ptr);
+
+	return s;
+}
+
+static void counted_by_ptr_oob_access(struct kunit *test)
+{
+	size_t size = 128;
+	struct counted_by_ptr_struct *s;
+
+	s = alloc_counted_by_ptr_struct(test, size);
+
+	OPTIMIZER_HIDE_VAR(s);
+
+	/* __builtin_dynamic_object_size() should return the correct length. */
+	KUNIT_EXPECT_EQ(test, size, __builtin_dynamic_object_size(s->ptr, 0));
+
+	/* Out-of-bounds assignment. */
+	KUNIT_EXPECT_KASAN_FAIL(test, s->ptr[size + 1] = 42);
+
+	/* Out-of-bounds read. */
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, s->ptr[0] = s->ptr[size + 13]);
+
+	kfree(s->ptr);
+	kfree(s);
+}
+#endif /* CONFIG_CC_HAS_COUNTED_BY_PTR */
+#endif /* CONFIG_CC_HAS_COUNTED_BY */
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -2280,6 +2374,12 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 #endif
 	KUNIT_CASE(rust_uaf),
 	KUNIT_CASE(copy_user_test_oob),
+#ifdef CONFIG_CC_HAS_COUNTED_BY
+	KUNIT_CASE(counted_by_flex_oob_access),
+#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+	KUNIT_CASE(counted_by_ptr_oob_access),
+#endif /* CONFIG_CC_HAS_COUNTED_BY_PTR */
+#endif /* CONFIG_CC_HAS_COUNTED_BY */
 	{}
 };
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

