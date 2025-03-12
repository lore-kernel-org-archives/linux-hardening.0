Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95926645;
	Wed, 12 Mar 2025 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741737843; cv=none; b=XJici4wv4F5C2HF6jQ2icMKLTztA7icOk55Cuw3B4ShopwCDFrOh1hWoxRcunr4F5qVFt4i1CBxGaRAQ0CPIY48Zj5WosPvk31Bb5ZDjqEQ6YKwghKA6Mrch4w1EgmXIcKpfGh3QvJXk9FBFZCvp5rporqrg5nemJwlSwzfwAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741737843; c=relaxed/simple;
	bh=pVvYwXP0gQ1oJIiqQk7qHSzwxsq9T8FMCmlNNJluSIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gs2wyvG6OKe0xis3SR80ulLYN5OINdVtoyvNj4BsQ4u8pdc5hyf9FvS544s6eQAXL7y+z058B0HaJ9tkn/4qDFl2Q68d8wx+LmnAbirx3HRvSlhw6jxpmHBMomOEhxj2QuSVKW+OnQHxe5Xb4wYZS1yQfY0JXatzzMR2MAYMt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4Ab04Ja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4Ab04Ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D609EC4CEE9;
	Wed, 12 Mar 2025 00:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741737842;
	bh=pVvYwXP0gQ1oJIiqQk7qHSzwxsq9T8FMCmlNNJluSIE=;
	h=From:To:Cc:Subject:Date:From;
	b=m4Ab04Ja1tv70a06NpWbU7+CjYmFO8Tt4GmjX0rtwxwjlNrRX3ePmhRrddlrNBSdS
	 AjeQozt2sYWE/b5uE/7kRRs05qExhDVyGm+bIC4e4RmaROQdignp91Qtv/zYJZq4qK
	 gWhqPqwME5RI71jiqt54aM46Mrq2HEUrcbglhNICPMDN/FBQ3D2xtLhg0EGSib5O7r
	 GvWW3GWNXSxWosjhJ5YEf7xJ+2YP91mN+dsP+3LKbrZaJHPqGd4YtbFSYPZA/GzIzF
	 CD8S4uz2q457VkNDoHzyZBMuwjCS1+r319MKrP7gxuF0TnbrfG45/pMUuVd4mv59HV
	 x4yYk0rMFxJFw==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] kunit/fortify: Expand testing of __compiletime_strlen()
Date: Tue, 11 Mar 2025 17:03:56 -0700
Message-Id: <20250312000349.work.786-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336; i=kees@kernel.org; h=from:subject:message-id; bh=pVvYwXP0gQ1oJIiqQk7qHSzwxsq9T8FMCmlNNJluSIE=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkXzud89I3m82RZ/mcSj5FXX+365zq71p1+VdyfKhvN8 q3pynLljlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImEPGH4w7nCpH9R2UfOXymf HJIabBwO+ilccZgWUfMmbH5BddnKawz/E4+JnL+3Wv2SkYD30t9X37RlMnvdVxR1sc/cMtvw6S4 +bgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

It seems that Clang thinks __builtin_constant_p() of undefined variables
should return true[1]. This is being fixed separately[2], but in the
meantime, expand the fortify tests to help track this kind of thing down
faster in the future.

Link: https://github.com/ClangBuiltLinux/linux/issues/2073 [1]
Link: https://github.com/llvm/llvm-project/pull/130713 [2]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 lib/tests/fortify_kunit.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
index ecb638d4cde1..18dcdedf777f 100644
--- a/lib/tests/fortify_kunit.c
+++ b/lib/tests/fortify_kunit.c
@@ -60,6 +60,7 @@ static int fortify_write_overflows;
 
 static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
+static const char * const unchanging_12 = "this is 12!!";
 static char array_unknown[] = "compiler thinks I might change";
 
 void fortify_add_kunit_error(int write)
@@ -83,12 +84,28 @@ void fortify_add_kunit_error(int write)
 
 static void fortify_test_known_sizes(struct kunit *test)
 {
+	char stack[80] = "Test!";
+
+	KUNIT_EXPECT_FALSE(test, __is_constexpr(__builtin_strlen(stack)));
+	KUNIT_EXPECT_EQ(test, __compiletime_strlen(stack), 5);
+
+	KUNIT_EXPECT_TRUE(test, __is_constexpr(__builtin_strlen("88888888")));
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
+
+	KUNIT_EXPECT_TRUE(test, __is_constexpr(__builtin_strlen(array_of_10)));
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_of_10), 10);
+
+	KUNIT_EXPECT_FALSE(test, __is_constexpr(__builtin_strlen(ptr_of_11)));
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen(ptr_of_11), 11);
 
+	KUNIT_EXPECT_TRUE(test, __is_constexpr(__builtin_strlen(unchanging_12)));
+	KUNIT_EXPECT_EQ(test, __compiletime_strlen(unchanging_12), 12);
+
+	KUNIT_EXPECT_FALSE(test, __is_constexpr(__builtin_strlen(array_unknown)));
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
+
 	/* Externally defined and dynamically sized string pointer: */
+	KUNIT_EXPECT_FALSE(test, __is_constexpr(__builtin_strlen(test->name)));
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen(test->name), SIZE_MAX);
 }
 
-- 
2.34.1

