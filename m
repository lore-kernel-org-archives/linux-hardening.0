Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5103456DF7;
	Mon,  5 Oct 2026 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193200; cv=none; b=f0NFJP7lZem+/uFwaHJ1UUKa5OE360uCCIe9W2O2rGtlg356R0WkgJNTvKCQYS6bB0DZnE7INgdbiCPBhyqT53thTgk1Dvk3qD3d72uhaat6JBUFoePIqOP1f7tV7WlgAbs6bzzMTWM94EN8iTGDVjLkXi25xObQFdQGdVtrno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193200; c=relaxed/simple;
	bh=dZqaVEMkMsvnLB4knzso3sC80VZrS3VpEn9EcK5gSgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcrpnIAH5gS4IsM0rr8B8/KYijXn8FQroBCPwLZVMlix3jB0EpiZRTRVlGYkCyJhL/khdzQcg/yyRxrPpuIvDPkn/p5N/GduezB37+40gZgSDzmvm1FE3UMZj511fa7Zo53LSD4ojMsHOfup71KRJK3korUP1FXIZWa2QJokfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClE1enZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClE1enZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C581F000FF;
	Mon,  5 Oct 2026 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791193191;
	bh=R+OW8qZ/8Z1xmR8Z8rFTwHf1YOIvisi5Vg+5hWQxj8w=;
	h=From:To:Cc:Subject:Date;
	b=ClE1enZJTDGEwfipmLMu/DU0gs1dKXhgSjedX2Xhi74DCTEEBFRJfspe5csuV+uLn
	 jgJsHCFVZTQcaIGJenJBdhP24dot4BEiFPqcc99MyDwdiXAj7bV17lvr5IwR+wG5sf
	 F8s1H+THDp8Fme3BLs7Qad/ddTfJfMf75Xb35xR5+rZaiFkjcIYhL4tAcwX/LHcxVt
	 hrtVe4Qgo1zkVdhjkGo3Ph2vWoY+SmfD6KTda/WIYLNEnlw9RgTLQzjYoPChlBqv/d
	 4vzqrwm5j7ZONV8sUivzrqrwqwKizwy9djVqc/6FkhvWe7oOhjackXZFesZ6rgIjMP
	 a8C+RjfXIv7wQ==
From: Kees Cook <kees@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/stackinit: Clean up XFAIL under instrumentation
Date: Mon,  5 Oct 2026 02:39:49 -0700
Message-ID: <20261005093945.i.566-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3538; i=kees@kernel.org; h=from:subject:message-id; bh=dZqaVEMkMsvnLB4knzso3sC80VZrS3VpEn9EcK5gSgA=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHC1INeqZNM+LgWyswce8uSbnTM7evm3JUc//Be88Oy v8IP2t/tKOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAiDmWMDEf6liaL3l5f787r 1e0RZPSzc96WaUmMgb6tqV5CnT+ZgSr+eK4xmb7pkpRS4b+n/MlZkhM9ynh2W3VWbtzGG+7uH8U GAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Commit 8530ea3c9b97 ("Kbuild: remove structleak gcc plugin") dropped
the stackinit GCC plugins, so there is no longer a gradient of test
coverage. Collapse the now identical USER_PASS, BYREF_PASS, STRONG_PASS
into a single INSTRUMENTED_PASS definition.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 lib/tests/stackinit_kunit.c | 40 +++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/lib/tests/stackinit_kunit.c b/lib/tests/stackinit_kunit.c
index 4788f6c10c04..d589536afa20 100644
--- a/lib/tests/stackinit_kunit.c
+++ b/lib/tests/stackinit_kunit.c
@@ -369,17 +369,13 @@ union test_small_end {
 	char four;
 };
 
-#define ALWAYS_PASS	WANT_SUCCESS
-#define ALWAYS_FAIL	XFAIL
+#define ALWAYS_PASS		WANT_SUCCESS
+#define ALWAYS_FAIL		XFAIL
 
 #ifdef CONFIG_INIT_STACK_NONE
-# define USER_PASS	XFAIL
-# define BYREF_PASS	XFAIL
-# define STRONG_PASS	XFAIL
+# define INSTRUMENTED_PASS	XFAIL
 #else
-# define USER_PASS	WANT_SUCCESS
-# define BYREF_PASS	WANT_SUCCESS
-# define STRONG_PASS	WANT_SUCCESS
+# define INSTRUMENTED_PASS	WANT_SUCCESS
 #endif
 
 /*
@@ -388,7 +384,7 @@ union test_small_end {
  * test expectation based on CONFIG_INIT_STACK_NONE above.
  */
 #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 240000
-# define BYPASS_PASS	STRONG_PASS
+# define BYPASS_PASS	INSTRUMENTED_PASS
 #else
 # define BYPASS_PASS	XFAIL
 #endif
@@ -443,23 +439,23 @@ DEFINE_STRUCT_TESTS(old_zero, ALWAYS_PASS);
 DEFINE_UNION_TESTS(zero, ALWAYS_PASS);
 DEFINE_UNION_TESTS(old_zero, ALWAYS_PASS);
 /* Struct initializers: padding may be left uninitialized. */
-DEFINE_STRUCT_INITIALIZER_TESTS(static, STRONG_PASS);
-DEFINE_STRUCT_INITIALIZER_TESTS(dynamic, STRONG_PASS);
-DEFINE_STRUCT_INITIALIZER_TESTS(runtime, STRONG_PASS);
-DEFINE_STRUCT_INITIALIZER_TESTS(assigned_static, STRONG_PASS);
-DEFINE_STRUCT_INITIALIZER_TESTS(assigned_dynamic, STRONG_PASS);
+DEFINE_STRUCT_INITIALIZER_TESTS(static, INSTRUMENTED_PASS);
+DEFINE_STRUCT_INITIALIZER_TESTS(dynamic, INSTRUMENTED_PASS);
+DEFINE_STRUCT_INITIALIZER_TESTS(runtime, INSTRUMENTED_PASS);
+DEFINE_STRUCT_INITIALIZER_TESTS(assigned_static, INSTRUMENTED_PASS);
+DEFINE_STRUCT_INITIALIZER_TESTS(assigned_dynamic, INSTRUMENTED_PASS);
 DEFINE_STRUCT_TESTS(assigned_copy, ALWAYS_FAIL);
-DEFINE_UNION_INITIALIZER_TESTS(static, STRONG_PASS);
-DEFINE_UNION_INITIALIZER_TESTS(dynamic, STRONG_PASS);
-DEFINE_UNION_INITIALIZER_TESTS(runtime, STRONG_PASS);
-DEFINE_UNION_INITIALIZER_TESTS(assigned_static, STRONG_PASS);
-DEFINE_UNION_INITIALIZER_TESTS(assigned_dynamic, STRONG_PASS);
+DEFINE_UNION_INITIALIZER_TESTS(static, INSTRUMENTED_PASS);
+DEFINE_UNION_INITIALIZER_TESTS(dynamic, INSTRUMENTED_PASS);
+DEFINE_UNION_INITIALIZER_TESTS(runtime, INSTRUMENTED_PASS);
+DEFINE_UNION_INITIALIZER_TESTS(assigned_static, INSTRUMENTED_PASS);
+DEFINE_UNION_INITIALIZER_TESTS(assigned_dynamic, INSTRUMENTED_PASS);
 DEFINE_UNION_TESTS(assigned_copy, ALWAYS_FAIL);
 /* No initialization without compiler instrumentation. */
-DEFINE_SCALAR_TESTS(none, STRONG_PASS);
-DEFINE_STRUCT_TESTS(none, BYREF_PASS);
+DEFINE_SCALAR_TESTS(none, INSTRUMENTED_PASS);
+DEFINE_STRUCT_TESTS(none, INSTRUMENTED_PASS);
 /* Initialization of members with __user attribute. */
-DEFINE_TEST(user, struct test_user, STRUCT, none, USER_PASS);
+DEFINE_TEST(user, struct test_user, STRUCT, none, INSTRUMENTED_PASS);
 
 /*
  * Check two uses through a variable declaration outside either path,
-- 
2.55.0

