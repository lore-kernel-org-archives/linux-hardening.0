Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAFD42E4BD;
	Thu,  8 Jan 2026 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864491; cv=none; b=m1rIdKxppSptmr5H4laa50KZ/r7IqCV3oFPmBunyynvZpMe3gx83CvoCbOhs0rtZat0egJ7o6z0oel5SGFnj4CMP7G3rSZjBVyEQZMaWvt81vbvIdfvkKymCggEHN4GFxEk5UZJtFWvvQd9fHqYqFAJM/oaukdo01Ejsl7BrpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864491; c=relaxed/simple;
	bh=a+iRDcQFjVTEhia5ujevgzffPacAq1ZV18BVECjd1m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4/bUkwKCE7KQVUlF4IyEqGBjriJwpYoIbIjL9eDtMr0ILgPOTwhU6BLiObQe4NLcwLuXKa1dMHBGVmDnbFB4GjWaNH6q1lE3XhPx4xvP0+j13W0FJ4bnoPQoJrlzwbN42FcWdkRvMb1rubUXhbTndn5uJph5ZryzEojntBDbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilhdXDzT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilhdXDzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C159FC19424;
	Thu,  8 Jan 2026 09:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864487;
	bh=a+iRDcQFjVTEhia5ujevgzffPacAq1ZV18BVECjd1m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilhdXDzTZC4TYjd5qMZgDnGow11a9Dz4cMm/Ik7MyzvYLLo60RCrcBWdGBf2mF9zz
	 4gLvnVVi/rlyppRcVEtsOvmkHXFa6JhHAdS9clbJ/BCd0qsc3M/4qthZAh63thZAyA
	 pRE+CcHOxtJ6SVagsLyMjxPiFgQ3A+vSzqWsd/9+Q0voYek7nRYK3ROF1I1Pa3xN5G
	 tyG3w31yNP9OFJGdXzHxh65dBJbXORz9oSsBU9FF3OOxl5i6UOnl7FFwypsXE2j138
	 JQe8XRoR1/j9alyAPXr94Xgs0tXD0u/1i4bqujdSAMPUzQWfrMrxEWfTEacfNU3s9n
	 wn6QcuCBALo1Q==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC/RFT PATCH 04/19] x86: Make the 64-bit bzImage always physically relocatable
Date: Thu,  8 Jan 2026 09:25:31 +0000
Message-ID: <20260108092526.28586-25-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8005; i=ardb@kernel.org; h=from:subject; bh=a+iRDcQFjVTEhia5ujevgzffPacAq1ZV18BVECjd1m8=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+gmeGmv/pgBX375f/rsycqqm//d7LeBnLp6bNToLaN ufP/CjpKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPp3cXwv/CMX0lJeZzbfOuy +mOT/j6OFVjy/p70iph7si85JnceP83I0N9TFnBo2ouzk9xDTndzRT8J05rvoZy0gnfL+b9O/17 e4wQA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

On x86_64, the physical placement of the kernel is independent from its
mapping in the 'High Kernel Mapping' range. This means that even a
position dependent kernel built without boot-time relocation support can
run from any suitably aligned physical address, and there is no need to
make this behavior dependent on whether or not the kernel is virtually
relocatable.

On i386, the situation is different, given that the physical and virtual
load offsets must be equal, and so only a relocatable kernel can be
loaded at a physical address that deviates from its build-time default.

Clarify this in Kconfig and in the code, and advertise the 64-bit
bzImage as loadable at any physical offset regardless of whether
CONFIG_RELOCATABLE is set. In practice, this makes little difference,
given that it defaults to 'y' and is a prerequisite for EFI_STUB and
RANDOMIZE_BASE, but it will help with some future refactoring of the
relocation code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kconfig                   | 40 ++++++++++++--------
 arch/x86/boot/compressed/head_64.S |  4 --
 arch/x86/boot/compressed/misc.c    |  8 ++--
 arch/x86/boot/header.S             |  8 +---
 4 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80527299f859..bf51e17d5813 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1931,7 +1931,7 @@ config EFI
 config EFI_STUB
 	bool "EFI stub support"
 	depends on EFI
-	select RELOCATABLE
+	select RELOCATABLE if X86_32
 	help
 	  This kernel feature allows a bzImage to be loaded directly
 	  by EFI firmware without the use of a bootloader.
@@ -2028,8 +2028,9 @@ config PHYSICAL_START
 	help
 	  This gives the physical address where the kernel is loaded.
 
-	  If the kernel is not relocatable (CONFIG_RELOCATABLE=n) then bzImage
-	  will decompress itself to above physical address and run from there.
+	  If the kernel is not relocatable (CONFIG_RELOCATABLE=n) and built for
+	  i386, then the bzImage will decompress itself to the above physical
+	  address and run from there.
 	  Otherwise, bzImage will run from the address where it has been loaded
 	  by the boot loader. The only exception is if it is loaded below the
 	  above physical address, in which case it will relocate itself there.
@@ -2064,16 +2065,22 @@ config PHYSICAL_START
 	  Don't change this unless you know what you are doing.
 
 config RELOCATABLE
-	bool "Build a relocatable kernel"
-	default y
+	bool "Build a relocatable kernel" if X86_32
+	default X86_32
 	help
-	  This builds a kernel image that retains relocation information
-	  so it can be loaded someplace besides the default 1MB.
+	  This builds a kernel image that retains relocation information so it
+	  can be placed someplace besides the default PAGE_OFFSET + 1MB. This
+	  is a prerequisite for KASLR.
 	  The relocations tend to make the kernel binary about 10% larger,
 	  but are discarded at runtime.
 
-	  One use is for the kexec on panic case where the recovery kernel
-	  must live at a different physical address than the primary
+	  On i386, where the virtual and physical load offset of the kernel
+	  must be equal, this also allows the kernel image to be placed at a
+	  physical load address that differs from the compile time default. On
+	  x86_64, this is always permitted.
+
+	  One use is for the kexec on panic case on i386, where the recovery
+	  kernel must live at a different physical address than the primary
 	  kernel.
 
 	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
@@ -2082,7 +2089,7 @@ config RELOCATABLE
 
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image (KASLR)"
-	depends on RELOCATABLE
+	select RELOCATABLE
 	default y
 	help
 	  In support of Kernel Address Space Layout Randomization (KASLR),
@@ -2118,7 +2125,7 @@ config RANDOMIZE_BASE
 # Relocation on x86 needs some additional build support
 config X86_NEED_RELOCS
 	def_bool y
-	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
+	depends on RELOCATABLE
 	select ARCH_VMLINUX_NEEDS_RELOCS
 
 config PHYSICAL_ALIGN
@@ -2131,12 +2138,13 @@ config PHYSICAL_ALIGN
 	  where kernel is loaded and run from. Kernel is compiled for an
 	  address which meets above alignment restriction.
 
-	  If bootloader loads the kernel at a non-aligned address and
-	  CONFIG_RELOCATABLE is set, kernel will move itself to nearest
-	  address aligned to above value and run from there.
+	  If the bootloader loads the kernel at a non-aligned address and it
+	  is built for x86_64 or CONFIG_RELOCATABLE is set, the kernel will
+	  move itself to the nearest address aligned to above value and run
+	  from there.
 
-	  If bootloader loads the kernel at a non-aligned address and
-	  CONFIG_RELOCATABLE is not set, kernel will ignore the run time
+	  If the bootloader loads the i386 kernel at a non-aligned address and
+	  CONFIG_RELOCATABLE is not set, the kernel will ignore the run time
 	  load address and decompress itself to the address it has been
 	  compiled for and run from there. The address for which kernel is
 	  compiled already meets above alignment restrictions. Hence the
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d9dab940ff62..8a964a4d45c2 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -143,7 +143,6 @@ SYM_FUNC_START(startup_32)
  * for safe in-place decompression.
  */
 
-#ifdef CONFIG_RELOCATABLE
 	movl	%ebp, %ebx
 	movl	BP_kernel_alignment(%esi), %eax
 	decl	%eax
@@ -152,7 +151,6 @@ SYM_FUNC_START(startup_32)
 	andl	%eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
 	jae	1f
-#endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
 
@@ -312,7 +310,6 @@ SYM_CODE_START(startup_64)
 	 */
 
 	/* Start with the delta to where the kernel will run at. */
-#ifdef CONFIG_RELOCATABLE
 	leaq	startup_32(%rip) /* - $startup_32 */, %rbp
 	movl	BP_kernel_alignment(%rsi), %eax
 	decl	%eax
@@ -321,7 +318,6 @@ SYM_CODE_START(startup_64)
 	andq	%rax, %rbp
 	cmpq	$LOAD_PHYSICAL_ADDR, %rbp
 	jae	1f
-#endif
 	movq	$LOAD_PHYSICAL_ADDR, %rbp
 1:
 
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 0f41ca0e52c0..d37569e7ee10 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -314,12 +314,10 @@ static size_t parse_elf(void *output)
 			if ((phdr->p_align % 0x200000) != 0)
 				error("Alignment of LOAD segment isn't multiple of 2MB");
 #endif
-#ifdef CONFIG_RELOCATABLE
-			dest = output;
-			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
-#else
 			dest = (void *)(phdr->p_paddr);
-#endif
+			if (IS_ENABLED(CONFIG_X86_64) ||
+			    IS_ENABLED(CONFIG_RELOCATABLE))
+				dest += (unsigned long)output - LOAD_PHYSICAL_ADDR;
 			memmove(dest, output + phdr->p_offset, phdr->p_filesz);
 			break;
 		default: /* Ignore other PT_* */ break;
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9bea5a1e2c52..b72e6055e103 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -332,7 +332,7 @@ initrd_addr_max: .long 0x7fffffff
 kernel_alignment:  .long CONFIG_PHYSICAL_ALIGN	#physical addr alignment
 						#required for protected mode
 						#kernel
-#ifdef CONFIG_RELOCATABLE
+#if defined(CONFIG_RELOCATABLE) || defined(CONFIG_X86_64)
 relocatable_kernel:    .byte 1
 #else
 relocatable_kernel:    .byte 0
@@ -342,14 +342,10 @@ min_alignment:		.byte MIN_KERNEL_ALIGN_LG2	# minimum alignment
 xloadflags:
 #ifdef CONFIG_X86_64
 # define XLF0 XLF_KERNEL_64			/* 64-bit kernel */
-#else
-# define XLF0 0
-#endif
-
-#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_X86_64)
    /* kernel/boot_param/ramdisk could be loaded above 4g */
 # define XLF1 XLF_CAN_BE_LOADED_ABOVE_4G
 #else
+# define XLF0 0
 # define XLF1 0
 #endif
 
-- 
2.47.3

