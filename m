Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB3286D79;
	Thu, 17 Jul 2025 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742384; cv=none; b=fHvSJpOfchnGhXP7FQEvRhSCaS2BGELHdgb/v28lxNdhHLFItt9v2Zu9XeT1dOGjPNzFEjJQu3y28Si0+NLYpy2q+/vW8C7wijH62C82pUMKNCbTtN1tCRkg6t5NlO8xTx+WP1OLxpl3ZozrbIXMyy3GBIwKH3avBn8IBTD21uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742384; c=relaxed/simple;
	bh=K7b6cDJtKe9/SFLCuJhtV0axV7uqnrn26I6lrJ+H1Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JnY6YlLoehvrjym4HZ58pUFlzCTeFBcidoY0cmU/kgfpGgD3Abfa2dkNry/QtIWNkBZ1Zik2SseMmDs9WxXYKQmx0aB5U3QSGGI/cE7OfKI3TMZSAo35I2M7ztLCGQWe3NAjj6WAMd4HJSKYQg0BtBoeeHK6tXlZDtYvlt+hNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY02iqio; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY02iqio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78ABBC4CEE3;
	Thu, 17 Jul 2025 08:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742383;
	bh=K7b6cDJtKe9/SFLCuJhtV0axV7uqnrn26I6lrJ+H1Q8=;
	h=From:To:Cc:Subject:Date:From;
	b=hY02iqioT/0iVgWjoLFg/TT9thzAhTtuNUuvrXS8YvXIQutUWNru5/AP6kVvkBKXy
	 wrjTeoxXkcYF4xriTRyX8H2FypLI6HcV/tQJParOyYkGqO+pTxZ9g/IZ+ad7WSZnX/
	 3UXHFPWCT+fge50n/wD2MnrWdVQKKZ2x/p8TBRuBUrM/7MvuqCBbC++I9VXAt2WvJv
	 CkbBLHdELFpxsrw1yXXWm1PQ1cZrsg4okD3eUxq/XPdotr2WAX5kIH3XTwafm8wKjy
	 HrqGqOFfWLE/aKAyTkP+vU9xfNoPJyDjXV3RMk4XWfBjrZkYDB1g98kkWPUVeLTVNY
	 4NWOIyuPNbT2Q==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Compiler Attributes: Add __kcfi_salt
Date: Thu, 17 Jul 2025 01:53:00 -0700
Message-Id: <20250717085300.work.146-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3458; i=kees@kernel.org; h=from:subject:message-id; bh=K7b6cDJtKe9/SFLCuJhtV0axV7uqnrn26I6lrJ+H1Q8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkVO9/IWDm5yT9ffU8mtbLBu/Oenp+8wX2jjCj1OSune V1MjdrbUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMBHfdkaG+9/E1h07pTS/0in4 c1PAbb2UiofuT1aJ/793mMeD/+aTIkaGs7q79qzgWb2x5uWzsx4hZp/1O6p/+K17LX9XXM1s8t4 uXgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add support for Clang's coming "kcfi_salt" attribute, which is designed
to allow for KCFI prototype hashes to be separated[1]. For example,
normally two "void func(void)" functions would have the same KCFI hash,
but if they wanted their indirect calls to be distinguishable by KCFI,
one could add __kcfi_salt("foo").

To test the result, add a corresponding LKDTM test, CFI_FORWARD_SALT.

Link: https://github.com/KSPP/linux/issues/365 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Bill Wendling <morbo@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: <llvm@lists.linux.dev>
---
 include/linux/compiler_attributes.h | 11 +++++++++++
 drivers/misc/lkdtm/cfi.c            | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index c16d4199bf92..eb3769b6a580 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -164,6 +164,17 @@
  */
 #define __gnu_inline                    __attribute__((__gnu_inline__))
 
+/*
+ * Optional: not supported by gcc
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#kcfi-salt
+ */
+#if __has_attribute(__kcfi_salt__)
+# define __kcfi_salt(STR)		__attribute__((__kcfi_salt__(STR)))
+#else
+# define __kcfi_salt(STR)
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-malloc-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#malloc
diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index 6a33889d0902..11de35d6b4e5 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -21,6 +21,13 @@ static noinline int lkdtm_increment_int(int *counter)
 	return *counter;
 }
 
+/* Function matching prototype of lkdtm_increment_int but separate salt. */
+static noinline __kcfi_salt("separate prototype hash")
+void lkdtm_increment_void_again(int *counter)
+{
+	(*counter)++;
+}
+
 /* Don't allow the compiler to inline the calls. */
 static noinline void lkdtm_indirect_call(void (*func)(int *))
 {
@@ -46,6 +53,25 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 	pr_expected_config(CONFIG_CFI_CLANG);
 }
 
+/*
+ * This tries to call an indirect function with a mismatched hash salt.
+ */
+static void lkdtm_CFI_FORWARD_SALT(void)
+{
+	/*
+	 * Matches lkdtm_increment_void()'s and lkdtm_increment_void_again()'s
+	 * prototypes, but they have different hash salts.
+	 */
+	pr_info("Calling matched prototype ...\n");
+	lkdtm_indirect_call(lkdtm_increment_void);
+
+	pr_info("Calling mismatched hash salt ...\n");
+	lkdtm_indirect_call(lkdtm_increment_void_again);
+
+	pr_err("FAIL: survived mismatched salt function call!\n");
+	pr_expected_config(CONFIG_CFI_CLANG);
+}
+
 /*
  * This can stay local to LKDTM, as there should not be a production reason
  * to disable PAC && SCS.
@@ -193,6 +219,7 @@ static void lkdtm_CFI_BACKWARD(void)
 
 static struct crashtype crashtypes[] = {
 	CRASHTYPE(CFI_FORWARD_PROTO),
+	CRASHTYPE(CFI_FORWARD_SALT),
 	CRASHTYPE(CFI_BACKWARD),
 };
 
-- 
2.34.1

