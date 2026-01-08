Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890D3C009C;
	Thu,  8 Jan 2026 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864486; cv=none; b=tgjmr09b6QItq49wSyeWN5JW6k3g3svwMBJr0v9svN28C7cJ61wVmsm5V9BTJ1UNyM+i0RGeaVPHHFBdIpUEk1ROOuuhfGkwqMfigxBZX0sJ5mqOoSHKOqSqvBlmkMiLTa67AmrwZDDVEm9b2OUGqRYch0tw9MkJEXZiuzVq0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864486; c=relaxed/simple;
	bh=++9jVLNSlkjAvs72B62sajS/8LrDcF+jVHHJT4hHbLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IG7xzKxotYqcO2AV2+8dRbA6bPIxVF3ZIHoG1KHo79n9vaBoeQK3nuvg54rDL5+of3XeCcohz2LU0S2bEgc2PbfrZNlMPqfqQtYw3dbrGGNHHJMW42Kpy+wAj+1NPcq7aMvtkPbYNe/RSSdYOebEWr5K9qmmhdHK5rg5rn9V/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcn9Qoob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcn9Qoob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C43C16AAE;
	Thu,  8 Jan 2026 09:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864484;
	bh=++9jVLNSlkjAvs72B62sajS/8LrDcF+jVHHJT4hHbLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mcn9QoobFMoA+8L297yR6DmX0UxtmgACy9eSYyMFjObuzrzRc63JLn3IrrR1HBxee
	 F8tm+Am2ByX9P1K4zRvmly+LMLY/bHMg2d9O+kpEWGMpCf1ayLSALUiQNxQ3MA62Je
	 rChg/6OV1d8Gl6dhnfPZcapS/dEG5gE4YCEizNtQM1DOIOw7t7yGSwLe4++I7v0TeL
	 ool420qM+xSHb149NBHE8bLHoJ1O5UYFSM/a9vsPIpTkGgJKhOttj7RwPYtjzKs03l
	 StQCq4zpoPnpr75TweomAps0PFdQm6aI4dq/zs/johcW0b9t+nUJqwS9rOi6XZYF6d
	 GyqDxpP0BK7mQ==
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
Subject: [RFC/RFT PATCH 03/19] x86: Combine .data with .bss in kernel mapping
Date: Thu,  8 Jan 2026 09:25:30 +0000
Message-ID: <20260108092526.28586-24-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9081; i=ardb@kernel.org; h=from:subject; bh=++9jVLNSlkjAvs72B62sajS/8LrDcF+jVHHJT4hHbLU=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+gptZ77OM0aVFRyIzzB2+ZK3a7B8Y5rEu4sqFy7Lne /abXmLuKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO59YaRYVbnqWUiFqEs2XdZ bod/eTJh71H9TQt/3zz1/kDaon2uE1Yx/NP4I/NL/4iyi3+zvYB++cvbrOcVzk5afN015v0VTT5 eZhYA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The primary mapping of the kernel image is made using huge pages where
possible, mostly to minimize TLB pressure (Only the entry text section
requires alignment to 2 MiB). This involves some rounding and padding of
the .text and .rodata sections, resulting in gaps.  These gaps are
smaller than a huge page, and are remapped using different permissions,
resulting in fragmentation of the huge page mappings at the edges of
those regions.

Similarly, there is a gap between .data and .bss, where the init text
and data regions reside. This means that the end of the .data region and
the start of the .bss region are not covered by huge page mappings
either, even though both regions use the same permissions (RW+NX).

Improve the situation, by placing .data and .bss adjacently in the
linker map, and putting the init text and data regions after .rodata,
taking the place of the rodata/data gap. This results in one fewer gap,
and a more efficient mapping of the .data and .bss regions.

To preserve the x86_64 ELF layout with PT_LOAD regions aligned to 2 MiB,
start the second ELF segment at .init.data and align it to 2 MiB.  The
resulting padding will be covered by the init region and will be freed
along with it after boot.

defconfig + Clang 19:

Before:

  0xffffffff81000000-0xffffffff82200000    18M  ro  PSE  GLB x  pmd
  0xffffffff82200000-0xffffffff8231c000  1136K  ro       GLB x  pte
  0xffffffff8231c000-0xffffffff82400000   912K  RW       GLB NX pte
  0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE  GLB NX pmd
  0xffffffff82a00000-0xffffffff82b40000  1280K  ro       GLB NX pte
  0xffffffff82b40000-0xffffffff82c00000   768K  RW       GLB NX pte
  0xffffffff82c00000-0xffffffff83400000     8M  RW  PSE  GLB NX pmd
  0xffffffff83400000-0xffffffff83800000     4M  RW       GLB NX pte

After:

  0xffffffff81000000-0xffffffff82200000    18M  ro  PSE  GLB x  pmd
  0xffffffff82200000-0xffffffff8231c000  1136K  ro       GLB x  pte
  0xffffffff8231c000-0xffffffff82400000   912K  RW       GLB NX pte
  0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE  GLB NX pmd
  0xffffffff82a00000-0xffffffff82b40000  1280K  ro       GLB NX pte
  0xffffffff82b40000-0xffffffff82c00000   768K  RW       GLB NX pte
  0xffffffff82c00000-0xffffffff82e00000     2M  RW  PSE  GLB NX pmd
  0xffffffff82e00000-0xffffffff83000000     2M  RW       GLB NX pte
  0xffffffff83000000-0xffffffff83800000     8M  RW  PSE  GLB NX pmd

With the gaps removed/unmapped (pti=on)

Before:

  0xffffffff81000000-0xffffffff81200000     2M  ro  PSE  GLB x  pmd
  0xffffffff81200000-0xffffffff82200000    16M  ro  PSE      x  pmd
  0xffffffff82200000-0xffffffff8231c000  1136K  ro           x  pte
  0xffffffff8231c000-0xffffffff82400000   912K                  pte
  0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE      NX pmd
  0xffffffff82a00000-0xffffffff82b40000  1280K  ro           NX pte
  0xffffffff82b40000-0xffffffff82c00000   768K                  pte
  0xffffffff82c00000-0xffffffff83400000     8M  RW  PSE      NX pmd
  0xffffffff83400000-0xffffffff8342a000   168K  RW           NX pte
  0xffffffff8342a000-0xffffffff836f3000  2852K                  pte
  0xffffffff836f3000-0xffffffff83800000  1076K  RW           NX pte

After:

  0xffffffff81000000-0xffffffff81200000     2M  ro  PSE  GLB x  pmd
  0xffffffff81200000-0xffffffff82200000    16M  ro  PSE      x  pmd
  0xffffffff82200000-0xffffffff8231c000  1136K  ro           x  pte
  0xffffffff8231c000-0xffffffff82400000   912K                  pte
  0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE      NX pmd
  0xffffffff82a00000-0xffffffff82b40000  1280K  ro           NX pte
  0xffffffff82b40000-0xffffffff82e3d000  3060K                  pte
  0xffffffff82e3d000-0xffffffff83000000  1804K  RW           NX pte
  0xffffffff83000000-0xffffffff83800000     8M  RW  PSE      NX pmd

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 91 +++++++++++---------
 arch/x86/mm/init_64.c         |  5 +-
 arch/x86/mm/pat/set_memory.c  |  2 +-
 3 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3a24a3fc55f5..1dee2987c42b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -61,12 +61,15 @@ const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 #define X86_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
 
 #define X86_ALIGN_RODATA_END					\
-		. = ALIGN(HPAGE_SIZE);				\
-		__end_rodata_hpage_align = .;			\
-		__end_rodata_aligned = .;
+		. = ALIGN(PAGE_SIZE);				\
+		__end_rodata_aligned = ALIGN(HPAGE_SIZE);
 
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
+
+#define DATA_SEGMENT_START					\
+	. = ALIGN(HPAGE_SIZE);					\
+	__data_segment_start = .;
 #else
 
 #define X86_ALIGN_RODATA_BEGIN
@@ -76,9 +79,14 @@ const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 
 #define ALIGN_ENTRY_TEXT_BEGIN
 #define ALIGN_ENTRY_TEXT_END
+
+#define DATA_SEGMENT_START					\
+	. = ALIGN(PAGE_SIZE);					\
+	__data_segment_start = .;
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+
 /*
  * This section contains data which will be mapped as decrypted. Memory
  * encryption operates on a page basis. Make this section PMD-aligned
@@ -171,43 +179,6 @@ SECTIONS
 	RO_DATA(PAGE_SIZE)
 	X86_ALIGN_RODATA_END
 
-	/* Data */
-	.data : AT(ADDR(.data) - LOAD_OFFSET) {
-		/* Start of data section */
-		_sdata = .;
-
-		/* init_task */
-		INIT_TASK_DATA(THREAD_SIZE)
-
-		/* equivalent to task_pt_regs(&init_task) */
-		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
-
-#ifdef CONFIG_X86_32
-		/* 32 bit has nosave before _edata */
-		NOSAVE_DATA
-#endif
-
-		PAGE_ALIGNED_DATA(PAGE_SIZE)
-
-		CACHE_HOT_DATA(L1_CACHE_BYTES)
-
-		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
-
-		DATA_DATA
-		CONSTRUCTORS
-		KEXEC_RELOCATE_KERNEL
-
-		/* rarely changed data like cpu maps */
-		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
-
-		/* End of data section */
-		_edata = .;
-	} :data
-
-	BUG_TABLE
-
-	ORC_UNWIND_TABLE
-
 	/* Init code and data - will be freed after init */
 	. = ALIGN(PAGE_SIZE);
 	.init.begin : AT(ADDR(.init.begin) - LOAD_OFFSET) {
@@ -229,7 +200,8 @@ SECTIONS
 		__inittext_end = .;
 	}
 
-	INIT_DATA_SECTION(16)
+	DATA_SEGMENT_START
+	INIT_DATA_SECTION(16) :data
 
 	.x86_cpu_dev.init : AT(ADDR(.x86_cpu_dev.init) - LOAD_OFFSET) {
 		__x86_cpu_dev_start = .;
@@ -358,6 +330,43 @@ SECTIONS
 		__smp_locks_end = .;
 	}
 
+	/* Data */
+	.data : AT(ADDR(.data) - LOAD_OFFSET) {
+		/* Start of data section */
+		_sdata = .;
+
+		/* init_task */
+		INIT_TASK_DATA(THREAD_SIZE)
+
+		/* equivalent to task_pt_regs(&init_task) */
+		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
+
+#ifdef CONFIG_X86_32
+		/* 32 bit has nosave before _edata */
+		NOSAVE_DATA
+#endif
+
+		PAGE_ALIGNED_DATA(PAGE_SIZE)
+
+		CACHE_HOT_DATA(L1_CACHE_BYTES)
+
+		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
+
+		DATA_DATA
+		CONSTRUCTORS
+		KEXEC_RELOCATE_KERNEL
+
+		/* rarely changed data like cpu maps */
+		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
+
+		/* End of data section */
+		_edata = .;
+	}
+
+	BUG_TABLE
+
+	ORC_UNWIND_TABLE
+
 #ifdef CONFIG_X86_64
 	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
 		NOSAVE_DATA
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 9983017ecbe0..6c2120dd5607 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1397,9 +1397,8 @@ void mark_rodata_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
 	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
-	unsigned long end = (unsigned long)__end_rodata_hpage_align;
+	unsigned long end = (unsigned long)__end_rodata;
 	unsigned long text_end = PFN_ALIGN(_etext);
-	unsigned long rodata_end = PFN_ALIGN(__end_rodata);
 	unsigned long all_end;
 
 	printk(KERN_INFO "Write protecting the kernel read-only data: %luk\n",
@@ -1435,8 +1434,6 @@ void mark_rodata_ro(void)
 
 	free_kernel_image_pages("unused kernel image (text/rodata gap)",
 				(void *)text_end, (void *)rodata_start);
-	free_kernel_image_pages("unused kernel image (rodata/data gap)",
-				(void *)rodata_end, (void *)_sdata);
 }
 
 /*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6c6eb486f7a6..ad4d55f2413b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -554,7 +554,7 @@ static pgprotval_t protect_kernel_text(unsigned long start, unsigned long end)
 static pgprotval_t protect_kernel_text_ro(unsigned long start,
 					  unsigned long end)
 {
-	unsigned long t_end = (unsigned long)__end_rodata_hpage_align - 1;
+	unsigned long t_end = (unsigned long)__end_rodata - 1;
 	unsigned long t_start = (unsigned long)_text;
 	unsigned int level;
 
-- 
2.47.3

