Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF71F3BB5
	for <linux-hardening@vger.kernel.org>; Mon,  7 Jul 2025 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919129; cv=none; b=EN/G9leryLliZ4s3pqb3PgkvihZdyC7qDfR9e5ixDLCxl8OSsDCAXqhAsOGQY3Gw5eEC6qLgJR7EsOHaaRBQwZ+f2mPXldwBai/NIflOpqIm4PjoooZL62EWMK8oV6ReD1cdrwyTGSSX/mhh9SkYPmtYP9DrYFuN8LX203ncLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919129; c=relaxed/simple;
	bh=a2ermjSx0vITzpqyJjxM8+Fp4A6dwkUufwczVtr2Yg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kr0HEsj3xEIjZSavhkWII2Dg934eUZOLGMiXdqBm/AzXxR6fDd7sc6aoHSQNdvGZ0Za9Kg1h9HA80JO6fqKanxutmjG1I7OSh2qFPZ1x5KhqVWie6x7fZFo+RQqi2zn+IHKMVHs0FA1QOfCP+SZ1rSqZ1nuwyHiCEnav7FsYu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=b6bERso1; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="b6bERso1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751919127; x=1783455127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zW6R0f8LausFLSC1IVkHr5vyvsReJA1Jdqz/A3wiCFI=;
  b=b6bERso1GWJA4a6eGh3EsttS2AWEo9dcnptv5aEME6yzz0PtNTkvyHXV
   iyu0B2Lqgp8c34Npp1e9HvMBOey+o9GolFg0+cnMZ+M7Yu147tu2hWvN/
   b5PPBWl7XdFTomF8f/smFoMYC9IkPH7YxCE/q/9M3vwGFQPa/sh3tHVdO
   1qes2ZPsVy4Qpf7YZpV9NrgcU5YELU7rml9ftigpoVHV9a4uefPSB7XaH
   hgSPGPq1aJCCpuXnLLuuMkqcLpXM4xKv+Pw1u+/G68SI7UdMQC5IcriZ7
   cjst8jAWxLnmHhlCzMfDeuuD3qOrFzWfibBz8AmH7jlQTuEZfvwS+/A3m
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,295,1744070400"; 
   d="scan'208";a="516134995"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 20:12:03 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:31613]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.124:2525] with esmtp (Farcaster)
 id 037cbc00-35b0-4dbe-87fc-a12451aaab9d; Mon, 7 Jul 2025 20:12:01 +0000 (UTC)
X-Farcaster-Flow-ID: 037cbc00-35b0-4dbe-87fc-a12451aaab9d
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Jul 2025 20:12:01 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 7 Jul 2025
 20:11:59 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <kees@kernel.org>, <linux-hardening@vger.kernel.org>
CC: <gustavoars@kernel.org>, <jgg@nvidia.com>, <leon@kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>
Subject: [PATCH][next] overflow: Add safe add/sub and compare helpers
Date: Mon, 7 Jul 2025 20:11:55 +0000
Message-ID: <20250707201155.16874-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Following a discussion on changes in RDMA subsystem [1], there is a use
for helpers that allow overflow safe comparison between the result of a
sum or a diff between two variables and some third operand. The classic
use case is checking that end address is in range, given start address
and length, but there are probably others. Add helpers that perform
mathematically correct comparison regardles of the types being used.

[1] https://lore.kernel.org/all/20250213144219.GB3754072@nvidia.com/

Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 include/linux/overflow.h   |  34 ++++++++
 lib/tests/overflow_kunit.c | 171 +++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 154ed0dbb43f..c79bde6cee3d 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -99,6 +99,23 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		*__ptr = wrapping_add(typeof(var), *__ptr, offset);	\
 	})
 
+/**
+ * overflow_safe_add_cmp() - Calculate addition of first two parameters and
+ * compare to the third parameter. The returned result is correct even when the
+ * sum wraps-around.
+ * @a: first addend
+ * @b: second addend
+ * @c: comparison operand
+ *
+ * Returns -1 if @a + @b < @c, 0 if @a + @b == @c and 1 if @a + @b > @c.
+ */
+#define overflow_safe_add_cmp(a, b, c)                                        \
+	({                                                                    \
+		typeof(c) __val, __c = c;                                     \
+		__builtin_add_overflow(a, b, &__val) || __val > __c ? 1 :     \
+		__val == __c ? 0 : -1;                                        \
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -145,6 +162,23 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		*__ptr = wrapping_sub(typeof(var), *__ptr, offset);	\
 	})
 
+/**
+ * overflow_safe_sub_cmp() - Calculate subtraction of second parameter from
+ * the first and compare to the third parameter. The returned result is correct
+ * even when the subtraction wraps-around.
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @c: comparison operand
+ *
+ * Returns -1 if @a - @b < @c, 0 if @a - @b == @c and 1 if @a - @b > @c.
+ */
+#define overflow_safe_sub_cmp(a, b, c)                                        \
+	({                                                                    \
+		typeof(c) __val, __c = c;                                     \
+		__builtin_sub_overflow(a, b, &__val) || __val < __c ? -1 :    \
+			__val == __c ? 0 : 1;                                 \
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
diff --git a/lib/tests/overflow_kunit.c b/lib/tests/overflow_kunit.c
index 19cb03b25dc5..f6d94e55a593 100644
--- a/lib/tests/overflow_kunit.c
+++ b/lib/tests/overflow_kunit.c
@@ -1225,6 +1225,174 @@ static void DEFINE_FLEX_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, __member_size(two_but_zero->array), array_size_override);
 }
 
+/* Common test macro for all overflow_safe_*_cmp functions */
+#define TEST_SAFE_CMP(op, a, b, c, expected) do {			          \
+	int result = overflow_safe_ ## op ## _cmp(a, b, c);		          \
+	KUNIT_EXPECT_EQ_MSG(test, result, expected,			          \
+		"expected overflow_safe_" #op "_cmp(%s, %s, %s) == %d, got %d\n", \
+		#a, #b, #c, expected, result);				          \
+	count++;							          \
+} while (0)
+
+static void overflow_safe_add_cmp_test(struct kunit *test)
+{
+	int count = 0;
+
+	/* Basic addition comparisons without overflow */
+	TEST_SAFE_CMP(add, 5, 3, 8, 0);
+	TEST_SAFE_CMP(add, 5, 3, 7, 1);
+	TEST_SAFE_CMP(add, 5, 3, 9, -1);
+	TEST_SAFE_CMP(add, 0, 0, 0, 0);
+	TEST_SAFE_CMP(add, 1, 0, 1, 0);
+	TEST_SAFE_CMP(add, 0, 1, 1, 0);
+
+	/* Test with unsigned 8-bit values */
+	TEST_SAFE_CMP(add, (u8)100, (u8)50, (u8)150, 0);
+	TEST_SAFE_CMP(add, (u8)100, (u8)50, (u8)149, 1);
+	TEST_SAFE_CMP(add, (u8)100, (u8)50, (u8)151, -1);
+
+	/* Test overflow cases with u8 - should behave as if on infinite types */
+	TEST_SAFE_CMP(add, (u8)200, (u8)100, (u8)44, 1);   /* 300 > 44, not 44 == 44 */
+	TEST_SAFE_CMP(add, (u8)255, (u8)1, (u8)0, 1);      /* 256 > 0, not 0 == 0 */
+	TEST_SAFE_CMP(add, (u8)255, (u8)2, (u8)1, 1);      /* 257 > 1, not 1 == 1 */
+	TEST_SAFE_CMP(add, (u8)200, (u8)200, (u8)145, 1);  /* 400 > 145, not 145 == 145 */
+
+	/* Test with signed values */
+	TEST_SAFE_CMP(add, -5, 3, -2, 0);
+	TEST_SAFE_CMP(add, -5, 3, -3, 1);
+	TEST_SAFE_CMP(add, -5, 3, -1, -1);
+
+	/* Test signed overflow cases - should behave as if on infinite types */
+	TEST_SAFE_CMP(add, (s8)100, (s8)50, (s8)-106, 1);  /* 150 > -106, not -106 == -106 */
+	TEST_SAFE_CMP(add, (s8)127, (s8)1, (s8)-128, 1);   /* 128 > -128, not -128 == -128 */
+	TEST_SAFE_CMP(add, (s8)127, (s8)127, (s8)-2, 1);   /* 254 > -2, not -2 == -2 */
+
+	/* Test with larger types */
+	TEST_SAFE_CMP(add, (u32)0xFFFFFFFF, (u32)1, (u32)0, 1);
+	TEST_SAFE_CMP(add, (u32)0xFFFFFFFF, (u32)2, (u32)1, 1);
+	TEST_SAFE_CMP(add, (u32)0xFFFFFFFF, (u32)0xFFFFFFFF, (u32)0, 1);
+
+	/* Test real-world use case: checking if an address range is within bounds */
+	TEST_SAFE_CMP(add, 0xFFFFFFFFFFFF0000ULL, 0x1000, 0x1000000ULL, 1);
+	TEST_SAFE_CMP(add, 0xFFFFFFFFFFFF0000ULL, 0x10000, 0x1000000ULL, 1);
+
+	/* Test with mixed types */
+	TEST_SAFE_CMP(add, (u8)200, (u16)300, (u32)500, 0);
+	TEST_SAFE_CMP(add, (u8)200, (u16)300, (u32)499, 1);
+	TEST_SAFE_CMP(add, (u8)200, (u16)300, (u32)501, -1);
+
+	/* Test with mixed types that would overflow in the smaller type */
+	TEST_SAFE_CMP(add, (u8)200, (u8)100, (u16)300, 0);
+	TEST_SAFE_CMP(add, (u8)255, (u16)1, (u32)256, 0);
+	TEST_SAFE_CMP(add, (u8)255, (u16)256, (u32)511, 0);
+
+	/* Test with mixed signed/unsigned types */
+	TEST_SAFE_CMP(add, (s8)-10, (u8)20, (s16)10, 0);
+	TEST_SAFE_CMP(add, (s8)-10, (u8)5, (s16)-5, 0);
+	TEST_SAFE_CMP(add, (s8)-128, (u16)128, (s32)0, 0);
+	TEST_SAFE_CMP(add, (s8)-128, (u16)127, (s32)-1, 0);
+
+	/* Test with mixed types where the result would overflow in c's type */
+	TEST_SAFE_CMP(add, (u32)40000, (u32)30000, (u16)4464, 1);  /* 70000 - 65536 */
+	TEST_SAFE_CMP(add, (s32)30000, (s32)10000, (s16)-25536, 1); /* 40000 - 65536 */
+
+	kunit_info(test, "%d overflow_safe_add_cmp tests finished\n", count);
+}
+
+static void overflow_safe_sub_cmp_test(struct kunit *test)
+{
+	int count = 0;
+
+	/* Basic subtraction comparisons without overflow */
+	TEST_SAFE_CMP(sub, 8, 3, 5, 0);
+	TEST_SAFE_CMP(sub, 8, 3, 4, 1);
+	TEST_SAFE_CMP(sub, 8, 3, 6, -1);
+	TEST_SAFE_CMP(sub, 5, 5, 0, 0);
+	TEST_SAFE_CMP(sub, 10, 0, 10, 0);
+
+	/* Test with unsigned 8-bit values */
+	TEST_SAFE_CMP(sub, (u8)150, (u8)50, (u8)100, 0);
+	TEST_SAFE_CMP(sub, (u8)150, (u8)50, (u8)99, 1);
+	TEST_SAFE_CMP(sub, (u8)150, (u8)50, (u8)101, -1);
+
+	/* Test underflow cases with u8 - should behave as if on infinite types */
+	TEST_SAFE_CMP(sub, (u8)50, (u8)100, (u8)200, -1);
+	TEST_SAFE_CMP(sub, (u8)0, (u8)1, (u8)255, -1);     /* -1 < 255, not 255 == 255 */
+	TEST_SAFE_CMP(sub, (u8)0, (u8)2, (u8)254, -1);     /* -2 < 254, not 254 == 254 */
+	TEST_SAFE_CMP(sub, (u8)10, (u8)20, (u8)246, -1);   /* -10 < 246, not 246 == 246 */
+
+	/* Test with signed values */
+	TEST_SAFE_CMP(sub, 5, -3, 8, 0);
+	TEST_SAFE_CMP(sub, -5, -3, -2, 0);
+	TEST_SAFE_CMP(sub, -5, 3, -8, 0);
+
+	/* Test signed underflow cases - should behave as if on infinite types */
+	TEST_SAFE_CMP(sub, (s8)-100, (s8)50, (s8)106, -1);  /* -150 < 106, not 106 == 106 */
+	TEST_SAFE_CMP(sub, (s8)-128, (s8)1, (s8)127, -1);   /* -129 < 127, not 127 == 127 */
+	TEST_SAFE_CMP(sub, (s8)-128, (s8)127, (s8)1, -1);   /* -255 < 1, not 1 == 1 */
+
+	/* Test with larger types */
+	TEST_SAFE_CMP(sub, (u32)0, (u32)1, (u32)0xFFFFFFFF, -1);
+	TEST_SAFE_CMP(sub, (u32)1, (u32)2, (u32)0xFFFFFFFF, -1);
+	TEST_SAFE_CMP(sub, (u32)0, (u32)0xFFFFFFFF, (u32)1, -1);
+
+	/* Test with mixed types */
+	TEST_SAFE_CMP(sub, (u16)500, (u8)200, (u32)300, 0);
+	TEST_SAFE_CMP(sub, (u16)500, (u8)200, (u32)299, 1);
+	TEST_SAFE_CMP(sub, (u16)500, (u8)200, (u32)301, -1);
+
+	/* Test with mixed types that would underflow in the smaller type */
+	TEST_SAFE_CMP(sub, (u8)50, (u16)100, (s32)-50, 0);
+	TEST_SAFE_CMP(sub, (u8)0, (u16)1, (s32)-1, 0);
+	TEST_SAFE_CMP(sub, (u8)10, (u16)20, (s32)-10, 0);
+
+	/* Test with mixed signed/unsigned types */
+	TEST_SAFE_CMP(sub, (s8)10, (u8)20, (s16)-10, 0);
+	TEST_SAFE_CMP(sub, (u8)20, (s8)-10, (s16)30, 0);
+	TEST_SAFE_CMP(sub, (s16)-1000, (u16)1000, (s32)-2000, 0);
+
+	/* Test with mixed types where the result would underflow in c's type */
+	TEST_SAFE_CMP(sub, (u16)1000, (u32)40000, (u16)26536, -1);  /* -39000 + 65536 */
+	TEST_SAFE_CMP(sub, (s16)-30000, (s16)10000, (s16)25536, -1); /* -40000 + 65536 */
+
+	kunit_info(test, "%d overflow_safe_sub_cmp tests finished\n", count);
+}
+
+#undef TEST_SAFE_CMP
+
+static void overflow_safe_cmp_side_effects_test(struct kunit *test)
+{
+	int a_orig = 5, a_test = 5;
+	int b_orig = 3, b_test = 3;
+	int c_orig = 8, c_test = 8;
+	int count = 0;
+
+	/* Test that the add macro doesn't have side effects */
+	overflow_safe_add_cmp(a_test++, b_test++, c_test++);
+	KUNIT_EXPECT_EQ_MSG(test, a_test, a_orig + 1,
+		"overflow_safe_add_cmp had unexpected side effect on first argument");
+	KUNIT_EXPECT_EQ_MSG(test, b_test, b_orig + 1,
+		"overflow_safe_add_cmp had unexpected side effect on second argument");
+	KUNIT_EXPECT_EQ_MSG(test, c_test, c_orig + 1,
+		"overflow_safe_add_cmp had unexpected side effect on third argument");
+	count += 3;
+
+	/* Test that the sub macro doesn't have side effects */
+	a_test = 5;
+	b_test = 3;
+	c_test = 8;
+	overflow_safe_sub_cmp(a_test++, b_test++, c_test++);
+	KUNIT_EXPECT_EQ_MSG(test, a_test, a_orig + 1,
+		"overflow_safe_sub_cmp had unexpected side effect on first argument");
+	KUNIT_EXPECT_EQ_MSG(test, b_test, b_orig + 1,
+		"overflow_safe_sub_cmp had unexpected side effect on second argument");
+	KUNIT_EXPECT_EQ_MSG(test, c_test, c_orig + 1,
+		"overflow_safe_sub_cmp had unexpected side effect on third argument");
+	count += 3;
+
+	kunit_info(test, "%d overflow safe comparison side effects tests finished\n", count);
+}
+
 static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(u8_u8__u8_overflow_test),
 	KUNIT_CASE(s8_s8__s8_overflow_test),
@@ -1248,6 +1416,9 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(same_type_test),
 	KUNIT_CASE(castable_to_type_test),
 	KUNIT_CASE(DEFINE_FLEX_test),
+	KUNIT_CASE(overflow_safe_add_cmp_test),
+	KUNIT_CASE(overflow_safe_sub_cmp_test),
+	KUNIT_CASE(overflow_safe_cmp_side_effects_test),
 	{}
 };
 
-- 
2.47.1

