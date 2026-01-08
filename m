Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7C44484A;
	Thu,  8 Jan 2026 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864529; cv=none; b=P2jIJW5pKr3CnNdZUcrvKXbrAEG+UH/0SOg7wCzvZ1KVaEYwNwzTbWvZ5KUQgqKVhqjiT/95ZszhXOzoENlgkuL/jhbw+sft80nUl57xpA4jwLvIXv/7jlqGHA3B9NoRcWOT0eBxL+KdFrG3HZMckgG0l6MA+eV6V64Xcnvuh8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864529; c=relaxed/simple;
	bh=OhsEzHir8OBQE+v0lxOGIwf/pL9va7usB5B7SPjaMso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHi1IMvoTb5JxZHgR82uM8XQjeDNGM2OVGys+DR0Mr0aX0J7ufqxCb9Mw0xwZr2GZ8bIaaZBwPAko46A2Lr2rtTJaEzAoA4qw0TeWjtZLZpi3IKNADTk1NjX67ueV6TTosbj/g4ZFF3Q7JS7blXaIePSQuT4MWwVPSvy4C9OiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv89xaTY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv89xaTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDE2C19424;
	Thu,  8 Jan 2026 09:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864528;
	bh=OhsEzHir8OBQE+v0lxOGIwf/pL9va7usB5B7SPjaMso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yv89xaTYLQzPTEmHc7sQvhrDbB/7L7x4clGSSM+4qnVeRv2zZyh3NRvtEqt3X8exu
	 Y6v0SAph6/AZ1c6CwxDHT0TgCxPPG6xeasEjacraQgMNAYv8eWX0y81eKuzVbAmT27
	 q+dZdgGI6+gRrjIiTm9iDrMY7TPIToHnxRvy8djBwF/y3de8D4zab4d1O1ZHfKA8Lo
	 VshgkH/0/m24TirP9nbc6oFADb8leF+rdvB5MITT4yynEpPnn6/fRA91dJLpq39BAV
	 lxKIx7pOnRVeGWI/bi2YA8eVjQ9BMP3QXNse9iUvfpzDQy/aimRhjy6NLCwG/R4pIF
	 qCWDIi8xf1XtQ==
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
Subject: [RFC/RFT PATCH 19/19] x86/kernel: Switch to PIE linking for the relocatable kernel
Date: Thu,  8 Jan 2026 09:25:46 +0000
Message-ID: <20260108092526.28586-40-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4330; i=ardb@kernel.org; h=from:subject; bh=OhsEzHir8OBQE+v0lxOGIwf/pL9va7usB5B7SPjaMso=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+QkGm4DrfnC6Lhdwbb7IbHI/sVGN/t5xtQ57k89U8b Bd3drJ1lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkkxTP8Zj+re+KpyWyf+3qO x2Z+EggW216Tl2vCaf7ci9dy4Q4rLkaGW/anC620Il4tO1bOc/pfyrOl86Xefd9WwLhVYufZK3u deAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

If the toolchain supports RELR relocation packing, build the virtually
relocatable kernels as Position Independent (PIE) Executables. This
results in more efficient relocation processing for the virtual
displacement of the kernel applied at boot, using RELR relocations that
take up only a fraction of the space occupied by ordinary RELA
relocations.

More importantly, it instructs the linker to generate a binary that is
really meant to be relocated at boot, using data structures that are
intended for this purpose. Doing so is important for a couple of
reasons:

- Relying on --emit-relocs is problematic, because it produces the
  static relocations that are consumed by the linker as input, and these
  are not meant for describing a runtime relocatable image. For example,
  the linker may apply relaxations that result in the code and the
  static relocation going out of sync (and ld.bfd and ld.lld already
  handle this in a different way).

- The 'relocs' tool relies on manually kept allow/deny lists of symbol
  names. These are needed because ELF absolute/relative symbol
  designations are often inaccurate.

- x86 deviates from other architectures in the kernel when it comes to
  its implementation of boot-time relocation, making it difficult to
  implement further enhancements (e.g., fgkaslr, EFI zboot) in a
  portable manner.

Note that this means that all codegen on x86_64 should be position
independent, to be compatible with PIE linking, but only if KASLR is
enabled. On i386, no changes to the codegen are needed, as the ordinary
position dependent relocation model is supported by the linker when
operating in PIE mode.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kconfig              |  3 ++-
 arch/x86/Makefile             |  5 +++++
 arch/x86/kernel/vmlinux.lds.S | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b3a64cfe04cf..2aa50aa8dc68 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -103,6 +103,7 @@ config X86
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
+	select ARCH_HAS_RELR
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_STRICT_KERNEL_RWX
@@ -2129,7 +2130,7 @@ config RANDOMIZE_BASE
 # Relocation on x86 needs some additional build support
 config X86_NEED_RELOCS
 	def_bool y
-	depends on RELOCATABLE
+	depends on RELOCATABLE && !TOOLS_SUPPORT_RELR
 	select ARCH_VMLINUX_NEEDS_RELOCS
 
 config PHYSICAL_ALIGN
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b211d6c950aa..7eac705c4ff4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -258,6 +258,11 @@ endif
 
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
+ldflags-pie-$(CONFIG_LD_IS_LLD)		:= --apply-dynamic-relocs
+ldflags-pie-$(CONFIG_LD_IS_BFD)		:= -z call-nop=suffix-nop
+ldflags-$(CONFIG_RELOCATABLE_PIE)	:= --pie -z notext $(ldflags-pie-y)
+LDFLAGS_vmlinux				+= $(ldflags-y)
+
 #
 # The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
 # the linker to force 2MB page size regardless of the default page size used
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6772fe9a9957..cfaf6ab80684 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -127,6 +127,9 @@ PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
 	note PT_NOTE FLAGS(0);          /* ___ */
+#ifdef CONFIG_RELOCATABLE_PIE
+	dynamic PT_DYNAMIC;
+#endif
 }
 
 SECTIONS
@@ -201,6 +204,21 @@ SECTIONS
 	DATA_SEGMENT_START
 	INIT_DATA_SECTION(16) :data
 
+#ifdef CONFIG_RELOCATABLE_PIE
+	/DISCARD/ : {
+		*(.interp .dynbss .eh_frame .sframe .relr.auth.dyn)
+	}
+
+	.dynamic	: { *(.dynamic) } :dynamic :data
+	.dynstr		: { *(.dynstr) } :data
+	.dynsym		: { *(.dynsym) }
+	.gnu.hash	: { *(.gnu.hash) }
+	.hash		: { *(.hash) }
+	.init.rela	: { *(.rela.*) *(.rela_*) }
+	.init.rel	: { *(.rel.*) *(.rel_*) }
+	.init.relr	: { *(.relr.*) }
+#endif
+
 	.x86_cpu_dev.init : AT(ADDR(.x86_cpu_dev.init) - LOAD_OFFSET) {
 		__x86_cpu_dev_start = .;
 		*(.x86_cpu_dev.init)
-- 
2.47.3

