Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6BE57880;
	Tue, 14 May 2024 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680483; cv=none; b=KHjy3/rZBkrFFGDvC6nciPA0GI+1bCRjoY5RUNebRLT+A8UnwjxDULF5bMClxvbd95WsP3uZplHMtNObRQ0IumzzKt5br7Gos9ljk1mnG6Gy9oNQaEnhzBlrvLhKSLc/ktd2z3D3q5E7O0Q8NFYSghHrvEDEUPFFp39Q54+NzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680483; c=relaxed/simple;
	bh=DhlsuRve0S/bf9PTRDFvtnsC2Bg9NA5k/tsCkw0kzBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YIcLobuoGjRUgHySPHHsdeNZOEqke/vKYaWFuX1NYM2kaJrdmFG90xWl8guNSE7GbVuGIcx0lE3LiKZtlhM21Jbk/XGUcoQDslWZcVh8TVwEjn+eYOSE5adFq6YvNMSzhjYTkJ41ban+zwpdoLzRX0/1C9nIBgYyyB4GOep4Buk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTv9LLcT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTv9LLcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A03C2BD10;
	Tue, 14 May 2024 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715680482;
	bh=DhlsuRve0S/bf9PTRDFvtnsC2Bg9NA5k/tsCkw0kzBc=;
	h=From:To:Cc:Subject:Date:From;
	b=jTv9LLcTc736u0yF7UNrsYkkDfEwr6/7O8roXeX/951T4+DYGToOqyJyCq2Vw/O/N
	 BCXjwIsRX0UZvUhcS+mNYz/vDjM9+idKe+SrK1g0HNPBWFWgqPoJvXXGwcJrjJ5rhv
	 jSxw2dcKwbaAcs2C/FoUuDf5AAoHilDEUMLjnVelAWfCaXht2hV7TYBUGrylIygXKx
	 2CGs1Qc6Y0pZioC/j8lRHBTI0ORJA3yZnOqLKHP8yXjcF4euCvGIxEJ4NiYBaNp7MR
	 eFlY7/iwoD0K8gUMIERFIAJ8Jmq/jDJk796DojbIndwI5PpGZYlBWGwMofge09rF12
	 m5xjAqfE3hvCg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] ubsan: remove meaningless CONFIG_ARCH_HAS_UBSAN
Date: Tue, 14 May 2024 18:54:26 +0900
Message-Id: <20240514095427.541201-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All architectures can enable UBSAN regardless of ARCH_HAS_UBSAN
because there is no "depends on ARCH_HAS_UBSAN" line.

Fixes: 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 MAINTAINERS          | 1 -
 arch/arm/Kconfig     | 1 -
 arch/arm64/Kconfig   | 1 -
 arch/mips/Kconfig    | 1 -
 arch/parisc/Kconfig  | 1 -
 arch/powerpc/Kconfig | 1 -
 arch/riscv/Kconfig   | 1 -
 arch/s390/Kconfig    | 1 -
 arch/x86/Kconfig     | 1 -
 lib/Kconfig.ubsan    | 3 ---
 10 files changed, 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..01124115a991 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22650,7 +22650,6 @@ F:	lib/Kconfig.ubsan
 F:	lib/test_ubsan.c
 F:	lib/ubsan.c
 F:	scripts/Makefile.ubsan
-K:	\bARCH_HAS_UBSAN\b
 
 UCLINUX (M68KNOMMU AND COLDFIRE)
 M:	Greg Ungerer <gerg@linux-m68k.org>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b14aed3a17ab..284103a56fbb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -30,7 +30,6 @@ config ARM
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_V7 || CPU_V7M || CPU_V6K
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
-	select ARCH_HAS_UBSAN
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..919f470338ed 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -107,7 +107,6 @@ config ARM64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
-	select ARCH_HAS_UBSAN
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 516dc7022bd7..dd974ab9b4e0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -15,7 +15,6 @@ config MIPS
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAS_UBSAN
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index daafeb20f993..afe348ed1202 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -13,7 +13,6 @@ config PARISC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
-	select ARCH_HAS_UBSAN
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_NO_SG_CHAIN
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..185a24424f47 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -154,7 +154,6 @@ config PPC
 	select ARCH_HAS_SYSCALL_WRAPPER		if !SPU_BASE && !COMPAT
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
-	select ARCH_HAS_UBSAN
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if PPC_RADIX_MMU
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..19ce88409c82 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -41,7 +41,6 @@ config RISCV
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_DATA
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8f01ada6845e..789a5128af9a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -83,7 +83,6 @@ config S390
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYSCALL_WRAPPER
-	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4474bf32d0a4..2583d8beb3a2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -100,7 +100,6 @@ config X86
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
-	select ARCH_HAS_UBSAN
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index e81e1ac4a919..0d53e085d4f2 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config ARCH_HAS_UBSAN
-	bool
-
 menuconfig UBSAN
 	bool "Undefined behaviour sanity checker"
 	help
-- 
2.40.1

