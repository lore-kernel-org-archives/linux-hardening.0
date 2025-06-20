Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A4289E21;
	Fri, 20 Jun 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418440; cv=none; b=j/pxr0rZozMxJNgwVJwJnabHoXfxs4a7VYjh06pQMMrwxqhWm2sf/uqwXtKZNKdYY74DE22I61+BM7JxtPrkJ6S/l941RFloyN2AGHbqMwiRAMYuiibPE8Sp4v608FviVUWNbseWeLIxx/E/j+8dcySfhWEJSa+Ec8kSPzKUKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418440; c=relaxed/simple;
	bh=1J/ZluEQ/v2RVVm+XiPqXcxJV1l7adhp5J+iGqlRXiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OtTsHWe7hNAZrcNbxAx5qOBj6R+fleJPrFzTLQTz6+R5D7SNMhB5JT553i+acAb6rkC/1cgPpv5PVvzsCIiaDa0x4KJwTRhzo9priN22gz6D/+zdcFAjudvnKpYQYN7hzY5anvHlrfHhJXOIQ1HYF4b1xYauwbhwqCMqcETN2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuWSIseF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuWSIseF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41653C4CEE3;
	Fri, 20 Jun 2025 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750418438;
	bh=1J/ZluEQ/v2RVVm+XiPqXcxJV1l7adhp5J+iGqlRXiU=;
	h=From:To:Cc:Subject:Date:From;
	b=WuWSIseFtAFYpLc8QGZ8r5av+itDrOluLVU7VyQMmIiK9YyqTv/h2Q3Unrs3J/Y8j
	 zwc7LeXmwj2hkaCy12phCE3BM3PWhiZDWQRV72ISJTKPYuAniMkmRIqIakAk/FOCDL
	 3pm6OOS8XnOjIA1EqOu21JyGALTRBybD8lJz4/1H7X9Gj5WmrwAw/rx3ZnryPs/b3M
	 XiN5nG7wPjCjU07Hz/UqT2LPgeCMErwnSWa19/IiWzdqW4kAxjOCZGT9lLMQXqIE9p
	 uqJu1TjnzOQnEZnnXt3+Gw/+nwcclTTzAsxapOmqQPkjIkyhT531i2wQp0ik7KTR32
	 8uio97NeR5OAQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Kees Cook <kees@kernel.org>,
	David Gow <davidgow@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lib/tests: split randstruct initializer tests
Date: Fri, 20 Jun 2025 13:20:29 +0200
Message-Id: <20250620112034.3395968-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

kunit code tents to cause problems with stack usage, especially when
sanitizers are enabled.

lib/tests/randstruct_kunit.c:306:1: error: the frame size of 1520 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Splitting up the randstruct_initializers() function into two halves
helps since each side now stays below 1KB of stack even with sanitizers
enabled.

Fixes: b370f7eacdcf ("lib/tests: Add randstruct KUnit test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/tests/randstruct_kunit.c | 65 +++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/lib/tests/randstruct_kunit.c b/lib/tests/randstruct_kunit.c
index f3a2d63c4cfb..74211e2f186f 100644
--- a/lib/tests/randstruct_kunit.c
+++ b/lib/tests/randstruct_kunit.c
@@ -249,16 +249,6 @@ static void randstruct_initializers(struct kunit *test)
 	struct randstruct_mixed_shuffled mixed_shuffled = {
 		init_members
 	};
-	struct contains_randstruct_untouched contains_untouched = {
-		.untouched = {
-			init_members
-		},
-	};
-	struct contains_randstruct_shuffled contains_shuffled = {
-		.shuffled = {
-			init_members
-		},
-	};
 #define func_member(x, ignored)	\
 		.x = func_##x,
 	struct randstruct_funcs_untouched funcs_untouched = {
@@ -274,6 +264,47 @@ static void randstruct_initializers(struct kunit *test)
 			init_members
 		});
 
+	test_check_mixed_init(test, "named", &mixed_untouched, &mixed_shuffled);
+	test_check_mixed_init(test, "unnamed", &mixed_untouched,
+		&(struct randstruct_mixed_shuffled){
+			init_members
+		});
+
+	test_check_funcs_init(test, "named", &funcs_untouched, &funcs_shuffled);
+	test_check_funcs_init(test, "unnamed", &funcs_untouched,
+		&(struct randstruct_funcs_shuffled){
+			DO_MANY_MEMBERS(func_member)
+		});
+
+#undef func_member
+#undef init_members
+}
+
+static void randstruct_contains_initializers(struct kunit *test)
+{
+#define init_members		\
+		.a = 1,		\
+		.b = 3,		\
+		.c = 5,		\
+		.d = 7,		\
+		.e = 11,	\
+		.f = 13,	\
+		.g = 17,	\
+		.h = 19,
+	struct contains_randstruct_untouched contains_untouched = {
+		.untouched = {
+			init_members
+		},
+	};
+	struct contains_randstruct_shuffled contains_shuffled = {
+		.shuffled = {
+			init_members
+		},
+	};
+	struct randstruct_shuffled shuffled = {
+		init_members
+	};
+
 	test_check_contained_init(test, "named", &contains_untouched, &contains_shuffled);
 	test_check_contained_init(test, "unnamed", &contains_untouched,
 		&(struct contains_randstruct_shuffled){
@@ -289,19 +320,6 @@ static void randstruct_initializers(struct kunit *test)
 			.shuffled = shuffled,
 		});
 
-	test_check_mixed_init(test, "named", &mixed_untouched, &mixed_shuffled);
-	test_check_mixed_init(test, "unnamed", &mixed_untouched,
-		&(struct randstruct_mixed_shuffled){
-			init_members
-		});
-
-	test_check_funcs_init(test, "named", &funcs_untouched, &funcs_shuffled);
-	test_check_funcs_init(test, "unnamed", &funcs_untouched,
-		&(struct randstruct_funcs_shuffled){
-			DO_MANY_MEMBERS(func_member)
-		});
-
-#undef func_member
 #undef init_members
 }
 
@@ -319,6 +337,7 @@ static struct kunit_case randstruct_test_cases[] = {
 	KUNIT_CASE(randstruct_layout_fptr),
 	KUNIT_CASE(randstruct_layout_fptr_deep),
 	KUNIT_CASE(randstruct_initializers),
+	KUNIT_CASE(randstruct_contains_initializers),
 	{}
 };
 
-- 
2.39.5

