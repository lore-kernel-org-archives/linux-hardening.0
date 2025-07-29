Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018028642F;
	Tue, 29 Jul 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832462; cv=none; b=MLX5JMS2nFWLsG5j0eyoXKPwJ4xddhuFdFbbz1h0hkj99Cm7XvAcizkckJ9TkzET4/c1nToNm2CfL8VQu+AuOlbsfl43Sk1jwmKrKDHP+WzFq51FJEpz7l0e8FSoqgOPid8QvdXSrN/rIaJ30MWzr9P3QsP3asH4gs3D+3BTDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832462; c=relaxed/simple;
	bh=ryAdDvZAKJEIZ/KqORsHe8k9AivcQjbtBA3ELYPMeUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RYt7JGByANcwzAFNxfztmg9BsZB3eoaPeMeUGLcoMddRX0qlwh4kPm3e2+4iMSM3zOI8utmKOHSJftT2gdWm7qTz3fSe9doxxT6/m2B4Y3Z4MdpDKUIvLg14bzJ15xF3Z/NvCWRVsrLQFh990YmrLwD7KgOEbYTjfTugDPQe3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAtgj7kI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAtgj7kI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372B1C4CEEF;
	Tue, 29 Jul 2025 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753832462;
	bh=ryAdDvZAKJEIZ/KqORsHe8k9AivcQjbtBA3ELYPMeUk=;
	h=From:To:Cc:Subject:Date:From;
	b=uAtgj7kI9PQrMHqwvdleiKmnk53FyvUKY8oMczuzsbRwzrb+5JEEY9nm/Y1hlaxlb
	 DKdScVmMzSRMAArMZMnI6tyvxzoA2AP/+I1HhCEqTvOZZacBBe18eF2j/QwwpVFNdC
	 mYzmM/2NElrNX1zM40zkq6t86+/mVYaGG+VPwyKj8IRTHZfV+y1AZQ1Br+79jw66YS
	 SEB5nNjc8lgl3LsZbPLcIZsWTlMa28B7IedopBbpxyGZUDkDknpjmK2LzNva6tyMis
	 nRWLndN5ZHiPMtgYGECNDsUr6QijWXIKQUp6LBKKXwz7kYM4Smuj+F2hRtor461O+n
	 Ih4Z0DZrqJMcQ==
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com,
	Miguel Ojeda <ojeda@kernel.org>,
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
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Uros Bizjak <ubizjak@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] compiler_types: Provide __no_kstack_erase to disable coverage only on Clang
Date: Tue, 29 Jul 2025 16:41:00 -0700
Message-Id: <20250729234055.it.233-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361; i=kees@kernel.org; h=from:subject:message-id; bh=ryAdDvZAKJEIZ/KqORsHe8k9AivcQjbtBA3ELYPMeUk=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmdMTxa05uOZhvknZwpZOKpeO64waS+e4ZZ+31m9q5s+ jJ7/bQ3HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPRr2X4wx0zde1q5VLFmc4r Nn597XXmwt7c0Grb0+5ZvQdzJR2/X2Jk2Du7oit173QvExUG39Zb868JXA8rrb1qtoGf99jLkE/ S7AA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In order to support Clang's stack depth tracking (for Linux's kstack_erase
feature), the coverage sanitizer needed to be disabled for __init (and
__head) section code. Doing this universally (i.e. for GCC too) created
a number of unexpected problems, ranging from changes to inlining logic
to failures to DCE code on earlier GCC versions.

Since this change is only needed for Clang, specialize it so that GCC
doesn't see the change as it isn't needed there (the GCC implementation
of kstack_erase uses a GCC plugin that removes stack depth tracking
instrumentation from __init sections during a late pass in the IR).

Successfully build and boot tested with GCC 12 and Clang 22.

Fixes: 381a38ea53d2 ("init.h: Disable sanitizer coverage for __init and __head")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507270258.neWuiXLd-lkp@intel.com/
Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6888d004.a00a0220.26d0e1.0004.GAE@google.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: correctly split compiler-specific stuff out of compiler_types.h (Miguel)
 v1: https://lore.kernel.org/all/20250729224325.work.019-kees@kernel.org/
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
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
 include/linux/compiler-clang.h | 3 +++
 include/linux/compiler_types.h | 4 ++++
 include/linux/init.h           | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

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
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 4fc8e26914ad..fa4ffe037bc7 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -89,6 +89,9 @@
 #define __no_sanitize_coverage
 #endif
 
+/* Only Clang needs to disable the coverage sanitizer for kstack_erase. */
+#define __no_kstack_erase	__no_sanitize_coverage
+
 #if __has_feature(shadow_call_stack)
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2b77d12e07b2..16755431fc11 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -424,6 +424,10 @@ struct ftrace_likely_data {
 # define randomized_struct_fields_end
 #endif
 
+#ifndef __no_kstack_erase
+# define __no_kstack_erase
+#endif
+
 #ifndef __noscs
 # define __noscs
 #endif
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

