Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60B2923B6;
	Tue,  4 Mar 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109928; cv=none; b=NdPWHH2age6QzPc85vPRNoT/Ek/Yu6Oj9fiJPzqc4TNwQJmq44YRN4LAcDyOqqXe2I8gLhull9hfkCK3v50lpzDJ2I+LNPPwZ/o9Vmy6w1n+Qxe0kRK1j7TFXkn0g7gst5VtLMDylQ7oY+WeDvQIUG+syW0NcGBSCyutTr91JaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109928; c=relaxed/simple;
	bh=zU5caYQO5b1oHRAv+SsibCFiieRoE+s8buOnLkoA+C4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DSGLDaHdQW48CJdyOcrs6f5xGAvoCUlBMCcB/mbKLltc7jGjuI/6ZrKzKyFd6Fzg9RXFI5LuJP+w9hRmss63IjnqjqytigpWbgOWefhIdLpJnpluqsZNGdRRwOgfpu2vxWSg+m9ZloYcvXMeSqbMZmZQAdMbg3fze9IQTY3VuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoqOSEwF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoqOSEwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260FFC4CEE5;
	Tue,  4 Mar 2025 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741109928;
	bh=zU5caYQO5b1oHRAv+SsibCFiieRoE+s8buOnLkoA+C4=;
	h=From:To:Cc:Subject:Date:From;
	b=UoqOSEwFZET/tJ7hA0NMK2AG4IWrsCK5+6FzESXVTAPtzD1iOf7vbfqn9TYDYWRwG
	 bwkigff0oMQ5SKGNDrKdekpvAfEefrPoVqwQwplOZArewnF0mLKH4ixZhWSupogDRZ
	 vXO/i7Uq2yGAesRJQWYVlQ1t/Hc3VJ3feyoYa5wEEUm0m2+ON3e6pp6v3ZInjE7MAz
	 mozug4s7Lo8k0rYGS//xGKGDoODcYiNIjmlWWscdjR8swSU2LOWcKIdTVerF3+2yVq
	 L08Sd43h0b6CmQUG3qfPvgkucycnzvtC/vHntX3KNNKtFfPL6S9lY2FVBW3eq4aHQJ
	 m0DQOra27RBkw==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] kunit/overflow: Fix DEFINE_FLEX tests for counted_by
Date: Tue,  4 Mar 2025 09:38:40 -0800
Message-Id: <20250304173835.work.970-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3889; i=kees@kernel.org; h=from:subject:message-id; bh=zU5caYQO5b1oHRAv+SsibCFiieRoE+s8buOnLkoA+C4=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnHrebfVToi2LOM3XrZsXc2pgeKIw3ZrQQsfjDaHNp+Y MIGEW63jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkcMmf4HxYpf+nc4uma2xrn NqzdFun1m0P38ssDc9f7cxx+dknq33lGhkt2Bc5/t+7WduPw5v9wN7f0Nk/7xWO8NUsSzGxdf/U e5gQA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Unfortunately, __builtin_dynamic_object_size() does not take into account
flexible array sizes, even when they are sized by __counted_by. As a
result, the size tests for the flexible arrays need to be separated to
get an accurate check of the compiler's behavior. While at it, fully test
sizeof, __struct_size (bdos(..., 0)), and __member_size (bdos(..., 1)).

I still think this is a compiler design issue, but there's not much to
be done about it currently beyond adjusting these tests. GCC and Clang
agree on this behavior at least. :)

Reported-by: "Thomas Weißschuh" <linux@weissschuh.net>
Closes: https://lore.kernel.org/lkml/e1a1531d-6968-4ae8-a3b5-5ea0547ec4b3@t-8ch.de/
Fixes: 9dd5134c6158 ("kunit/overflow: Adjust for __counted_by with DEFINE_RAW_FLEX()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 lib/overflow_kunit.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 5222c6393f11..894691b4411a 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1185,22 +1185,40 @@ struct bar {
 
 static void DEFINE_FLEX_test(struct kunit *test)
 {
-	/* Using _RAW_ on a __counted_by struct will initialize "counter" to zero */
-	DEFINE_RAW_FLEX(struct foo, two_but_zero, array, 2);
-#ifdef CONFIG_CC_HAS_COUNTED_BY
-	int expected_raw_size = sizeof(struct foo);
-#else
-	int expected_raw_size = sizeof(struct foo) + 2 * sizeof(s16);
-#endif
-	/* Without annotation, it will always be on-stack size. */
 	DEFINE_RAW_FLEX(struct bar, two, array, 2);
 	DEFINE_FLEX(struct foo, eight, array, counter, 8);
 	DEFINE_FLEX(struct foo, empty, array, counter, 0);
+	/* Using _RAW_ on a __counted_by struct will initialize "counter" to zero */
+	DEFINE_RAW_FLEX(struct foo, two_but_zero, array, 2);
+	int array_size_override = 0;
 
-	KUNIT_EXPECT_EQ(test, __struct_size(two_but_zero), expected_raw_size);
+	KUNIT_EXPECT_EQ(test, sizeof(*two), sizeof(struct bar));
 	KUNIT_EXPECT_EQ(test, __struct_size(two), sizeof(struct bar) + 2 * sizeof(s16));
-	KUNIT_EXPECT_EQ(test, __struct_size(eight), 24);
+	KUNIT_EXPECT_EQ(test, __member_size(two), sizeof(struct bar) + 2 * sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __struct_size(two->array), 2 * sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __member_size(two->array), 2 * sizeof(s16));
+
+	KUNIT_EXPECT_EQ(test, sizeof(*eight), sizeof(struct foo));
+	KUNIT_EXPECT_EQ(test, __struct_size(eight), sizeof(struct foo) + 8 * sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __member_size(eight), sizeof(struct foo) + 8 * sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __struct_size(eight->array), 8 * sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __member_size(eight->array), 8 * sizeof(s16));
+
+	KUNIT_EXPECT_EQ(test, sizeof(*empty), sizeof(struct foo));
 	KUNIT_EXPECT_EQ(test, __struct_size(empty), sizeof(struct foo));
+	KUNIT_EXPECT_EQ(test, __member_size(empty), sizeof(struct foo));
+	KUNIT_EXPECT_EQ(test, __struct_size(empty->array), 0);
+	KUNIT_EXPECT_EQ(test, __member_size(empty->array), 0);
+
+	/* If __counted_by is not being used, array size will have the on-stack size. */
+	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY))
+		array_size_override = 2 * sizeof(s16);
+
+	KUNIT_EXPECT_EQ(test, sizeof(*two_but_zero), sizeof(struct foo));
+	KUNIT_EXPECT_EQ(test, __struct_size(two_but_zero), sizeof(struct foo) + 2 * sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __member_size(two_but_zero), sizeof(struct foo) + 2 * sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __struct_size(two_but_zero->array), array_size_override);
+	KUNIT_EXPECT_EQ(test, __member_size(two_but_zero->array), array_size_override);
 }
 
 static struct kunit_case overflow_test_cases[] = {
-- 
2.34.1

