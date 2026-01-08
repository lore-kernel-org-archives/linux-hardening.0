Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D693C00BD;
	Thu,  8 Jan 2026 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864492; cv=none; b=NEPEksHlfT2n1gKFUOrKnABqYofYy5byZN5ehi14eIne7E+OmeFXW66yTsg1SmBvIcyVTRAqMzJ55w3Io8OQXB9jRbrThk5GdQ/lrzlHKKle9V3L1CQdBBksh0Rv6vfIzahV8r0X/Fa8dG1GRkGCYce6QLRmUvH4UIiMjU3i7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864492; c=relaxed/simple;
	bh=y7+ntK2Mt9pILeLN4kBUmNH8SM9X4UPDlejQNxGasJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6w/ukgLkqUTiFV+MYZ5uXlkV0xDQLhd2NWCtIF06q6MqfoM7V0JdcuT0i/xWFs1wM8+4s3tT66RKIv4PqYYOj9whNvhlH8TqC5MdmylH0+HrODYuAw/VRVhr+EmynwIJoYbw8/s2Jnr1duIOMRdCAZcGNFaK4ASHBpFCDbQq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsC3ggSJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsC3ggSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86249C116C6;
	Thu,  8 Jan 2026 09:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864489;
	bh=y7+ntK2Mt9pILeLN4kBUmNH8SM9X4UPDlejQNxGasJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OsC3ggSJUJoRtalHOVJReVeodhSqFx019MuAGLoupQYSBgGSW6nES1QJvHzLr9UNG
	 7ae3prPAfNetXGub/D1Ak/AY3lbQZ7diNheQEWgZNjxHgt0XUPMiY4DVX3+ypWGeSj
	 KfFPD+0wkU3/EhL4R8rksiQtymz0AU7R5mP8H4ZslvtvOLEHT0oGBIPFOGxpUGrE2n
	 3GmdDCcBwr8uU18MTMzYl7ZaqfjGDc9DcQJdqA0wW5fbkjOjSNU3QW2MA0KyncaauB
	 kNMx5t9jDdX+T8JIIH2lg5zJKipNnPUwZKX4iNYSL4LC3QU91uk3cpB2agkDRxFh6G
	 fuXFFFCURtp6A==
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
Subject: [RFC/RFT PATCH 05/19] x86/efistub: Simplify early remapping of kernel text
Date: Thu,  8 Jan 2026 09:25:32 +0000
Message-ID: <20260108092526.28586-26-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107; i=ardb@kernel.org; h=from:subject; bh=y7+ntK2Mt9pILeLN4kBUmNH8SM9X4UPDlejQNxGasJ4=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+gvfZrNboPT8O+zuI83B0R2Z+WBL0aYdFw5Fk9cv7e IJMp13oKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNRzWJkaE+NzTzx4LFJ72y9 KyUfjLiPSvKvemDzovpr6OR3lR335BkZJrmuWvF1z503r0zXc6mFMGzeu2997tegCYqft7wKOeJ nxQQA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Now that the kernel's .text, .rodata and .inittext are all covered by a
single ELF segment, there is no need to remap .inittext separately.
Instead, remap the entire region in a single call.

This remapping is needed because the EFI stub hands over to the core
kernel while running in long mode, using the page tables provided by the
firmware.  Recent so-called 'MS secured core' (tm) PCs are more strict
when it comes to separating writable from executable mappings, and so
for compatibility with such systems, any code that may be callable
during early boot (i.e., before the kernel switches to its own page
tables) must be remapped executable explicitly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile       | 2 +-
 arch/x86/boot/compressed/misc.c         | 4 +---
 arch/x86/include/asm/boot.h             | 2 --
 arch/x86/kernel/vmlinux.lds.S           | 2 --
 drivers/firmware/efi/libstub/x86-stub.c | 4 +---
 5 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 68f9d7a1683b..bc071bdcd11e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -76,7 +76,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__start_rodata\|_sinittext\|__inittext_end\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__data_segment_start\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index d37569e7ee10..1ea419cf88fe 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -329,9 +329,7 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
-const unsigned long kernel_text_size = VO___start_rodata - VO__text;
-const unsigned long kernel_inittext_offset = VO__sinittext - VO__text;
-const unsigned long kernel_inittext_size = VO___inittext_end - VO__sinittext;
+const unsigned long kernel_text_size = VO___data_segment_start - VO__text;
 const unsigned long kernel_total_size = VO__end - VO__text;
 
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index f7b67cb73915..02b23aa78955 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -82,8 +82,6 @@
 #ifndef __ASSEMBLER__
 extern unsigned int output_len;
 extern const unsigned long kernel_text_size;
-extern const unsigned long kernel_inittext_offset;
-extern const unsigned long kernel_inittext_size;
 extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1dee2987c42b..6772fe9a9957 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -196,8 +196,6 @@ SECTIONS
 	 */
 	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
 		*(.altinstr_aux)
-		. = ALIGN(PAGE_SIZE);
-		__inittext_end = .;
 	}
 
 	DATA_SEGMENT_START
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cef32e2c82d8..ffe30ef73fda 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -890,9 +890,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
 
 	*kernel_entry = addr + entry;
 
-	return efi_adjust_memory_range_protection(addr, kernel_text_size) ?:
-	       efi_adjust_memory_range_protection(addr + kernel_inittext_offset,
-						  kernel_inittext_size);
+	return efi_adjust_memory_range_protection(addr, kernel_text_size);
 }
 
 static void __noreturn enter_kernel(unsigned long kernel_addr,
-- 
2.47.3

