Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6722144A3;
	Fri,  2 May 2025 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746225685; cv=none; b=FcJMcxEq2yR1jE7vXD25Myq2SkigAVofHSr6QTGqPT1lElm6IRCpYqWxKOSL9WiFQKj/DAaQ7pJ65rFCerVfJLTzC6nIEQye3wxD8QV2bifX7cy1Zx62HdmIvauRuAGtRCSHcv+qEhDl+2DbUw5pgQXL8JCm+GuO2a2oulKgJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746225685; c=relaxed/simple;
	bh=iMli4LPu4gbwRJDmajCNaoP7Mvh1PBOez04czyzkLGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvV5TP1RuUshT+d423fs3rOKIlA0mFggtIZ8AbHKZlhoFtWzzNFLEdz/A98PZfx9UxRgNLQ9m4NbaVdciiYy0pvnB1UHiFhyoI9QEu33w5GZYDcxDge2u8vN+CBsgbVY9yk7wInDd1+Rp3F/vYwZlzPjgt8HMLdZwzFDMWS3T0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1UYjDBI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1UYjDBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB8BC4CEE4;
	Fri,  2 May 2025 22:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746225684;
	bh=iMli4LPu4gbwRJDmajCNaoP7Mvh1PBOez04czyzkLGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=q1UYjDBIcaUAlSmTLA2n55FEA0VJiySgslFBBUxOAOWBMcnre+a/fJoocdLGlV5RU
	 G4UVpf2YoGyAedIR0ML9WUwzrprJ7RoN4etxbZfEr87Ms3XSryi0+TSO9U5YOUbgdp
	 CkGXLNEglArfhNndm5Kc8Au4jbsavYI6Uhbx0nN4scQqEHiPLw5XT3JALE50tD+9MQ
	 54aMi5HBPXztiwZdubiOpKdq7CzHEJkgzGMyKkPqV9+WzRU+tYaFYJHh4N0AdeXjw0
	 FbDqnT11Iicep7Cju2i026t3RfxtOu8EJPsHDiNO0ib5Tb+8m20G2xyYgZqkDgHKT1
	 JqngoVJFF2ajA==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lib/tests: randstruct: Add deep function pointer layout test
Date: Fri,  2 May 2025 15:41:20 -0700
Message-Id: <20250502224116.work.591-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5274; i=kees@kernel.org; h=from:subject:message-id; bh=iMli4LPu4gbwRJDmajCNaoP7Mvh1PBOez04czyzkLGQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmiXvzcSkcWv0qawrH1OktxVpAUq5G/y+zoFUsmz9Ivu LTtje6RjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImcOMLwv/hI6+e7G9K1qpk/ vD4fNTN7kcEkh4PFs36++Ft142RUhgDDf3dxpR8n3my8JZkk9Hiz9Mte3t0fg9mN/s/+K7Xxa3P kY04A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The recent fix in commit c2ea09b193d2 ("randstruct: gcc-plugin: Remove
bogus void member") has fixed another issue: it was not always detecting
composite structures made only of function pointers and structures of
function pointers. Add a test for this case, and break out the layout
tests since this issue is actually a problem for Clang as well[1].

Link: https://github.com/llvm/llvm-project/issues/138355 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Bill Wendling <morbo@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: <linux-hardening@vger.kernel.org>
Cc: <llvm@lists.linux.dev>
---
 lib/tests/randstruct_kunit.c | 79 +++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 14 deletions(-)

diff --git a/lib/tests/randstruct_kunit.c b/lib/tests/randstruct_kunit.c
index c796c8fae263..f3a2d63c4cfb 100644
--- a/lib/tests/randstruct_kunit.c
+++ b/lib/tests/randstruct_kunit.c
@@ -56,7 +56,6 @@ struct randstruct_funcs_untouched {
 struct randstruct_funcs_shuffled {
 	DO_MANY_MEMBERS(func_member)
 };
-#undef func_member
 
 #define func_body(x, ignored)					\
 static noinline size_t func_##x(int arg)			\
@@ -103,9 +102,16 @@ struct contains_randstruct_shuffled {
 	int after;
 };
 
-static void randstruct_layout(struct kunit *test)
-{
-	int mismatches;
+struct contains_func_untouched {
+	struct randstruct_funcs_shuffled inner;
+	DO_MANY_MEMBERS(func_member)
+} __no_randomize_layout;
+
+struct contains_func_shuffled {
+	struct randstruct_funcs_shuffled inner;
+	DO_MANY_MEMBERS(func_member)
+};
+#undef func_member
 
 #define check_mismatch(x, untouched, shuffled)	\
 	if (offsetof(untouched, x) != offsetof(shuffled, x))	\
@@ -114,24 +120,66 @@ static void randstruct_layout(struct kunit *test)
 		   offsetof(shuffled, x),			\
 		   offsetof(untouched, x));			\
 
-#define check_pair(outcome, untouched, shuffled)		\
+#define check_pair(outcome, untouched, shuffled, checker...)	\
 	mismatches = 0;						\
-	DO_MANY_MEMBERS(check_mismatch, untouched, shuffled)	\
+	DO_MANY_MEMBERS(checker, untouched, shuffled)	\
 	kunit_info(test, "Differing " #untouched " vs " #shuffled " member positions: %d\n", \
 		   mismatches);					\
 	KUNIT_##outcome##_MSG(test, mismatches, 0,		\
 			      #untouched " vs " #shuffled " layouts: unlucky or broken?\n");
 
-	check_pair(EXPECT_EQ, struct randstruct_untouched, struct randstruct_untouched)
-	check_pair(EXPECT_GT, struct randstruct_untouched, struct randstruct_shuffled)
-	check_pair(EXPECT_GT, struct randstruct_untouched, struct randstruct_funcs_shuffled)
-	check_pair(EXPECT_GT, struct randstruct_funcs_untouched, struct randstruct_funcs_shuffled)
-	check_pair(EXPECT_GT, struct randstruct_mixed_untouched, struct randstruct_mixed_shuffled)
-#undef check_pair
+static void randstruct_layout_same(struct kunit *test)
+{
+	int mismatches;
 
-#undef check_mismatch
+	check_pair(EXPECT_EQ, struct randstruct_untouched, struct randstruct_untouched,
+		   check_mismatch)
+	check_pair(EXPECT_GT, struct randstruct_untouched, struct randstruct_shuffled,
+		   check_mismatch)
+}
+
+static void randstruct_layout_mixed(struct kunit *test)
+{
+	int mismatches;
+
+	check_pair(EXPECT_EQ, struct randstruct_mixed_untouched, struct randstruct_mixed_untouched,
+		   check_mismatch)
+	check_pair(EXPECT_GT, struct randstruct_mixed_untouched, struct randstruct_mixed_shuffled,
+		   check_mismatch)
 }
 
+static void randstruct_layout_fptr(struct kunit *test)
+{
+	int mismatches;
+
+	check_pair(EXPECT_EQ, struct randstruct_untouched, struct randstruct_untouched,
+		   check_mismatch)
+	check_pair(EXPECT_GT, struct randstruct_untouched, struct randstruct_funcs_shuffled,
+		   check_mismatch)
+	check_pair(EXPECT_GT, struct randstruct_funcs_untouched, struct randstruct_funcs_shuffled,
+		   check_mismatch)
+}
+
+#define check_mismatch_prefixed(x, prefix, untouched, shuffled)	\
+	check_mismatch(prefix.x, untouched, shuffled)
+
+static void randstruct_layout_fptr_deep(struct kunit *test)
+{
+	int mismatches;
+
+	if (IS_ENABLED(CONFIG_CC_IS_CLANG))
+		kunit_skip(test, "Clang randstruct misses inner functions: https://github.com/llvm/llvm-project/issues/138355");
+
+	check_pair(EXPECT_EQ, struct contains_func_untouched, struct contains_func_untouched,
+			check_mismatch_prefixed, inner)
+
+	check_pair(EXPECT_GT, struct contains_func_untouched, struct contains_func_shuffled,
+			check_mismatch_prefixed, inner)
+}
+
+#undef check_pair
+#undef check_mismatch
+
 #define check_mismatch(x, ignore)				\
 	KUNIT_EXPECT_EQ_MSG(test, untouched->x, shuffled->x,	\
 			    "Mismatched member value in %s initializer\n", \
@@ -266,7 +314,10 @@ static int randstruct_test_init(struct kunit *test)
 }
 
 static struct kunit_case randstruct_test_cases[] = {
-	KUNIT_CASE(randstruct_layout),
+	KUNIT_CASE(randstruct_layout_same),
+	KUNIT_CASE(randstruct_layout_mixed),
+	KUNIT_CASE(randstruct_layout_fptr),
+	KUNIT_CASE(randstruct_layout_fptr_deep),
 	KUNIT_CASE(randstruct_initializers),
 	{}
 };
-- 
2.34.1

