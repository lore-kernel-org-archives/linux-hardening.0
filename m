Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC01AA1D9;
	Tue, 29 Jul 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829015; cv=none; b=skVZV6toGXRAgAttRcJqTrYeI90s12dP7NUZf1FRuZRQxh3bDYVbO4A5Ufs0tSQfE39+QaBZa3MJJMu81oYVc5VeGrjvkBo/5Ung0CMRTMetDqW1p28YeZxekhHlJr/QIAuC0cdF4o/8vTWMtDuROCuPk2dsJ+8JgHM4iDxMDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829015; c=relaxed/simple;
	bh=oTdYiE23IWd2hrwmuA8C9kEdsJ1UHqb9arQdLsQ2bvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=puwZHSGTqUVkE1Emk2CwXoszvOCFqCqnCh4WhDMCcToL4NGFscaw4g8bmHjrKHrLdWEVtmHbzRbKNR9usshdCNi0vogXnvJP5rziTsM9i5snTU/qKbOefxFeiieIjyEEXBmRLwPm2bUJ8uxI7CF/9TRRKI9oZZA3oDbySL+WiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbz5frpJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbz5frpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE56C4CEEF;
	Tue, 29 Jul 2025 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829015;
	bh=oTdYiE23IWd2hrwmuA8C9kEdsJ1UHqb9arQdLsQ2bvc=;
	h=From:To:Cc:Subject:Date:From;
	b=Rbz5frpJLBa6F6s41xo03v2BD1kk9wTm6eVzw6fQOUDUT5+zfo113PlWw5rTJ7l1o
	 8K8n1yy4UCXM3LlrsZa0BxRHa/20YXcE+TI/vCyMUqdEJPEHCyPrjomoyaCFJG6A4x
	 j1EM6/KNMIJxCXXCBVDryo8pU6znwJKwlq9n7FhaJo5n2GCDeroqzzeYEQEtLHguAX
	 5WxNeMgEd5Ige0hU4WomyM7Z6Sr+J+owN7hxkzWj9xbNRURyP9VRcw424ERLZdZkV6
	 yc5JTkZM4TinMDx/qiGwZiB8Gw7CavhsDsB1KepWVGhwcRG3R8pPioluEwVXBprPuh
	 GW28p4zV8CY8w==
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marco Elver <elver@google.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	"Kirill A . Shutemov" <kas@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] compiler_types: Provide __no_kstack_erase to disable coverage only on Clang
Date: Tue, 29 Jul 2025 15:43:33 -0700
Message-Id: <20250729224325.work.019-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3887; i=kees@kernel.org; h=from:subject:message-id; bh=oTdYiE23IWd2hrwmuA8C9kEdsJ1UHqb9arQdLsQ2bvc=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmdflPCszbbFi44W9iQ8q2gw/i09Nzfa4Tbf+yQm+p+o 91pw+e+jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlY5jAyXKh/vjRxp6Sb7Qd3 zzrb27l/vv3+zL8u+czsYw8CHz8qrGT4H/Cto7I35pXRwyshkX3LBZnljLpZXflSuq59Zr6atc6 VHwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In order to support Clang's stack depth tracking (for Linux's kstack_erase
feature), the coverage sanitizer needed to be disabled for __init (and
__head) section code. Doing this universally (i.e. for GCC too), created
a number of unexpected problems, ranging from changes to inlining logic
to failures to DCE code on earlier GCC versions.

Since this change is only needed for Clang, specialize it so that GCC
doesn't see the change as it isn't needed there (the GCC implementation
of kstack_erase uses a GCC plugin that removes stack depth tracking
instrumentation from __init sections during a late pass in the IR).

Successful build and boot tested with GCC 12 and Clang 22.

Fixes: 381a38ea53d2 ("init.h: Disable sanitizer coverage for __init and __head")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507270258.neWuiXLd-lkp@intel.com/
Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6888d004.a00a0220.26d0e1.0004.GAE@google.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Kirill A. Shutemov <kas@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/x86/include/asm/init.h    | 2 +-
 include/linux/compiler_types.h | 7 +++++++
 include/linux/init.h           | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 6bfdaeddbae8..5a68e9db6518 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -5,7 +5,7 @@
 #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
 #define __head	__section(".head.text") __no_sanitize_undefined __no_stack_protector
 #else
-#define __head	__section(".head.text") __no_sanitize_undefined __no_sanitize_coverage
+#define __head	__section(".head.text") __no_sanitize_undefined __no_kstack_erase
 #endif
 
 struct x86_mapping_info {
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2b77d12e07b2..89e2c01fc8b1 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -378,6 +378,13 @@ struct ftrace_likely_data {
 # define __signed_wrap
 #endif
 
+/* GCC does not like splitting sanitizer coverage across section inlines */
+#ifdef CC_IS_CLANG
+#define __no_kstack_erase	__no_sanitize_coverage
+#else
+#define __no_kstack_erase
+#endif
+
 /* Section for code which can't be instrumented at all */
 #define __noinstr_section(section)					\
 	noinline notrace __attribute((__section__(section)))		\
diff --git a/include/linux/init.h b/include/linux/init.h
index c65a050d52a7..a60d32d227ee 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -51,7 +51,7 @@
    discard it in modules) */
 #define __init		__section(".init.text") __cold __latent_entropy	\
 						__noinitretpoline	\
-						__no_sanitize_coverage
+						__no_kstack_erase
 #define __initdata	__section(".init.data")
 #define __initconst	__section(".init.rodata")
 #define __exitdata	__section(".exit.data")
-- 
2.34.1

