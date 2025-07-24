Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89891BF58;
	Thu, 24 Jul 2025 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753326164; cv=none; b=FFae6JqD3OIzCDcCv/DOPzac+vM57/8GhOh7fvrgdKGgd5pBAiIHzkHcYZRRyfitssRG8ay089iDDAlH4//gydQVkqhTh9/LMGnd2HqOif9FVEBib6bmb+wcLbu+6NIjzNUEpk3pPFXXjuBcPfxBx4dtFntA2q7tkUElqgWwG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753326164; c=relaxed/simple;
	bh=U/p79L70a5VpLNTwIstkAAGIPIzYyjodcgovbz6Gjk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OA2k9asUkxy6A6eFaxjxW955cEKkrwkA2QpTpPXEa/wjOF+7tfivUYTyn0C8oHbdHL1FCQt6fZNfc7iT4jU2qNj22rkPl2oabfgjv6Ji9mG4XhXCKcIy6FOGASmsyVrF5rIGFMuolqRaw4p3xCAWo27Kcw+metrcNv05kaVtQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnYQFBIs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnYQFBIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB54C4CEEF;
	Thu, 24 Jul 2025 03:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753326164;
	bh=U/p79L70a5VpLNTwIstkAAGIPIzYyjodcgovbz6Gjk8=;
	h=From:To:Cc:Subject:Date:From;
	b=UnYQFBIspKIpgcTKkFbrqWtyT2XR4DQd+96VCjOiHvjB/FldfOtoDJc9loXFVSVqw
	 Nwe0+5tVF6ajPHvCXl1NThkJSNIpMf32Y8R7dr9QvS+DZqhHCIp/I+H+mymFxIy8Xb
	 OBhO6AUSkGxvREgEr/KZpX5MdlcsxNBKCuno94iLNb5Y0DlG1CETho8b9/oXQmPOqf
	 RQfvcuHuW6r4axiwfzI/ASIHI70q2IhiaMQkhS7aOpAwmDnHLYuwQMJBVRiUoBYL3L
	 9bp/68PRf2509LEO188gGvPAd2+CHhlb5GA7m30x2SGaMGAZpm00Iz4r0oLKH0B/tE
	 lxAhJdyqsRhnw==
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] string_helpers: Add KUnit tests for memcpy_and_pad()
Date: Wed, 23 Jul 2025 20:02:40 -0700
Message-Id: <20250724030233.work.486-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7895; i=kees@kernel.org; h=from:subject:message-id; bh=U/p79L70a5VpLNTwIstkAAGIPIzYyjodcgovbz6Gjk8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNiwIs7k2aFfTBP9oq1sTtsnS3+OlGxjW8z9YcX3Cn1 mjjtJjmjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImse8HIcGQC+5Nez5NsTttX zPPycLDdaS0Xd3ix88cP5s/fmhzPmcPw3+HTrS1LHMVZ9Bk8+o89VVlfrTeDf+HFzOYCnvOxt0S eMAAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add KUnit test coverage for memcpy_and_pad():

- Basic functionality with padding, exact fit, and truncation cases
- Edge cases with zero counts and different padding values
- Structure copying with endian-safe validation

The tests validate both string and structured data copying behavior,
ensuring the function works correctly across different boundary
conditions. Each test uses unique padding values to detect any potential
cross-contamination.

Signed-off-by: Kees Cook <kees@kernel.org>
---
This patch was LLM assisted! It did well, but missed the entire concept of
copying non-byte-array objects originally. I tweaked a bunch of the tests.
---
 lib/tests/string_helpers_kunit.c | 156 +++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index c853046183d2..38c26b9fb871 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -611,10 +611,166 @@ static void test_unescape(struct kunit *test)
 		test_string_escape(test, "escape 1", escape1, i, TEST_STRING_2_DICT_1);
 }
 
+/* Test structure for memcpy_and_pad structure copying tests */
+struct test_struct {
+	u8 byte1;
+	u16 word1;
+	u8 byte2;
+	u32 dword1;
+	u8 byte3;
+} __packed;
+
+static void test_memcpy_and_pad(struct kunit *test)
+{
+	char dest[20];
+	const char *src = "hello";
+	struct test_struct struct_dest[3];
+	const struct test_struct struct_src = {
+		.byte1 = 0xAA,
+		.word1 = 0xBBCC,
+		.byte2 = 0xDD,
+		.dword1 = 0xEEFF1122,
+		.byte3 = 0x33
+	};
+	u8 *struct_bytes;
+	int i;
+
+	/* Test 1: Basic functionality - dest_len > count */
+	memset(dest, 0xFF, sizeof(dest));  /* Fill with known pattern */
+	memcpy_and_pad(dest, 10, src, 5, 0x11);
+	KUNIT_EXPECT_MEMEQ(test, dest, "hello", 5);
+	/* Check padding */
+	for (i = 5; i < 10; i++)
+		KUNIT_EXPECT_EQ(test, (unsigned char)dest[i], 0x11);
+	/* Ensure we didn't write past dest_len */
+	KUNIT_EXPECT_EQ(test, (unsigned char)dest[10], 0xFF);
+
+	/* Test 2: dest_len == count */
+	memset(dest, 0xFF, sizeof(dest));
+	memcpy_and_pad(dest, 5, src, 5, 0x22);
+	KUNIT_EXPECT_MEMEQ(test, dest, "hello", 5);
+	/* No padding should occur */
+	KUNIT_EXPECT_EQ(test, (unsigned char)dest[5], 0xFF);
+
+	/* Test 3: dest_len < count (truncation) */
+	memset(dest, 0xFF, sizeof(dest));
+	memcpy_and_pad(dest, 3, src, 5, 0x33);
+	KUNIT_EXPECT_MEMEQ(test, dest, "hel", 3);
+	/* No padding should occur, and nothing beyond dest_len should be touched */
+	KUNIT_EXPECT_EQ(test, (unsigned char)dest[3], 0xFF);
+
+	/* Test 4: Zero count */
+	memset(dest, 0xFF, sizeof(dest));
+	memcpy_and_pad(dest, 5, src, 0, 0x44);
+	/* Should be all padding */
+	for (i = 0; i < 5; i++)
+		KUNIT_EXPECT_EQ(test, (unsigned char)dest[i], 0x44);
+	KUNIT_EXPECT_EQ(test, (unsigned char)dest[5], 0xFF);
+
+	/* Test 5: Zero dest_len */
+	memset(dest, 0xFF, sizeof(dest));
+	memcpy_and_pad(dest, 0, src, 5, 0x55);
+	/* Should do nothing */
+	KUNIT_EXPECT_EQ(test, (unsigned char)dest[0], 0xFF);
+
+	/* Test 6: Different padding characters */
+	memset(dest, 0xFF, sizeof(dest));
+	memcpy_and_pad(dest, 8, "hi", 2, '\0');
+	KUNIT_EXPECT_MEMEQ(test, dest, "hi", 2);
+	for (i = 2; i < 8; i++)
+		KUNIT_EXPECT_EQ(test, dest[i], '\0');
+
+	/* Test 7: Negative pad value (should work as unsigned char) */
+	memset(dest, 0x00, sizeof(dest));
+	memcpy_and_pad(dest, 5, "a", 1, -1);
+	KUNIT_EXPECT_EQ(test, dest[0], 'a');
+	for (i = 1; i < 5; i++)
+		KUNIT_EXPECT_EQ(test, (unsigned char)dest[i], 0xFF);
+
+	/* Test 8: Single byte operations */
+	memset(dest, 0x00, sizeof(dest));
+	memcpy_and_pad(dest, 1, "X", 1, 0x88);
+	KUNIT_EXPECT_EQ(test, dest[0], 'X');
+	KUNIT_EXPECT_EQ(test, (unsigned char)dest[1], 0x00);
+
+	/* Test 9: Large pad scenario */
+	memset(dest, 0x00, sizeof(dest));
+	memcpy_and_pad(dest, 15, "test", 4, 0x99);
+	KUNIT_EXPECT_MEMEQ(test, dest, "test", 4);
+	for (i = 4; i < 15; i++)
+		KUNIT_EXPECT_EQ(test, (unsigned char)dest[i], 0x99);
+
+	/* Test 10: Structure copying - full copy with padding */
+	memset(struct_dest, 0xFF, sizeof(struct_dest));
+	memcpy_and_pad(struct_dest, sizeof(struct_dest), &struct_src, sizeof(struct_src), 0x55);
+
+	/* Verify first struct copied correctly */
+	KUNIT_EXPECT_EQ(test, struct_dest[0].byte1, struct_src.byte1);
+	KUNIT_EXPECT_EQ(test, struct_dest[0].word1, struct_src.word1);
+	KUNIT_EXPECT_EQ(test, struct_dest[0].byte2, struct_src.byte2);
+	KUNIT_EXPECT_EQ(test, struct_dest[0].dword1, struct_src.dword1);
+	KUNIT_EXPECT_EQ(test, struct_dest[0].byte3, struct_src.byte3);
+
+	/* Verify padding area - remaining struct elements should be filled with 0x55 */
+	struct_bytes = (u8 *)&struct_dest[1];
+	for (i = 0; i < sizeof(struct_dest) - sizeof(struct_src); i++)
+		KUNIT_EXPECT_EQ(test, struct_bytes[i], 0x55);
+
+	/* Test 11: Structure copying - partial copy with padding */
+	memset(struct_dest, 0xFF, sizeof(struct_dest));
+	memcpy_and_pad(struct_dest, sizeof(struct_src) * 2, &struct_src,
+		       sizeof(struct_src) / 2, 0x77);
+
+	/* Verify partial struct data copied (first 4 bytes of 9-byte struct) */
+	KUNIT_EXPECT_EQ(test, struct_dest[0].byte1, struct_src.byte1);   /* offset 0: copied */
+	KUNIT_EXPECT_EQ(test, struct_dest[0].word1, struct_src.word1);   /* offset 1-2: copied */
+	KUNIT_EXPECT_EQ(test, struct_dest[0].byte2, struct_src.byte2);   /* offset 3: copied */
+	/* offset 4 and beyond should be padding since only 4 bytes were copied */
+	KUNIT_EXPECT_EQ(test, struct_dest[0].dword1, 0x77777777);
+	KUNIT_EXPECT_EQ(test, struct_dest[0].byte3, 0x77);
+
+	/* Second struct should be entirely padding */
+	KUNIT_EXPECT_EQ(test, struct_dest[1].byte1, 0x77);
+	KUNIT_EXPECT_EQ(test, struct_dest[1].word1, 0x7777);
+	KUNIT_EXPECT_EQ(test, struct_dest[1].byte2, 0x77);
+	KUNIT_EXPECT_EQ(test, struct_dest[1].dword1, 0x77777777);
+	KUNIT_EXPECT_EQ(test, struct_dest[1].byte3, 0x77);
+
+	/* Test 12: Structure copying - truncation (dest_len < count, no padding) */
+	memset(struct_dest, 0xFF, sizeof(struct_dest));
+	memcpy_and_pad(struct_dest, sizeof(struct_src) - 2, &struct_src, sizeof(struct_src), 0x99);
+
+	/* Verify truncated data - only first 7 bytes of 9-byte struct copied */
+	KUNIT_EXPECT_EQ(test, struct_dest[0].byte1, struct_src.byte1);    /* offset 0: copied */
+	KUNIT_EXPECT_EQ(test, struct_dest[0].word1, struct_src.word1);    /* offset 1-2: copied */
+	KUNIT_EXPECT_EQ(test, struct_dest[0].byte2, struct_src.byte2);    /* offset 3: copied */
+	/* offset 4-7: dword1 partially copied (first 3 bytes), last byte remains 0xFF */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	KUNIT_EXPECT_EQ(test, struct_dest[0].dword1, 0xFFFF1122); /* LE: 22 11 FF FF */
+#else
+	KUNIT_EXPECT_EQ(test, struct_dest[0].dword1, 0xEEFF11FF); /* BE: EE FF 11 FF */
+#endif
+	/* byte3 should remain as initialization since truncated at 7 bytes */
+	KUNIT_EXPECT_EQ(test, struct_dest[0].byte3, 0xFF);
+
+	/* Remaining struct elements should be untouched */
+	KUNIT_EXPECT_EQ(test, struct_dest[1].byte1, 0xFF);
+	KUNIT_EXPECT_EQ(test, struct_dest[1].word1, 0xFFFF);
+	KUNIT_EXPECT_EQ(test, struct_dest[1].byte2, 0xFF);
+	KUNIT_EXPECT_EQ(test, struct_dest[1].dword1, 0xFFFFFFFF);
+	KUNIT_EXPECT_EQ(test, struct_dest[1].byte3, 0xFF);
+	KUNIT_EXPECT_EQ(test, struct_dest[2].byte1, 0xFF);
+	KUNIT_EXPECT_EQ(test, struct_dest[2].word1, 0xFFFF);
+	KUNIT_EXPECT_EQ(test, struct_dest[2].byte2, 0xFF);
+	KUNIT_EXPECT_EQ(test, struct_dest[2].dword1, 0xFFFFFFFF);
+	KUNIT_EXPECT_EQ(test, struct_dest[2].byte3, 0xFF);
+}
+
 static struct kunit_case string_helpers_test_cases[] = {
 	KUNIT_CASE(test_get_size),
 	KUNIT_CASE(test_upper_lower),
 	KUNIT_CASE(test_unescape),
+	KUNIT_CASE(test_memcpy_and_pad),
 	{}
 };
 
-- 
2.34.1

