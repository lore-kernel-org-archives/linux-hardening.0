Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E991C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BE060F21
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhJMPZP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhJMPZO (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EC2E6113E;
        Wed, 13 Oct 2021 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138591;
        bh=PXB3zQXwY0Jqsa61K53dco0RurO4Co2tyKwXIIahwnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvkjWd9jJn9hTlts0gCzjeMwFGqLvmSiTgqzZQgJYQrrre+w9S8miXZTN7BiPKrdD
         7/wsGHO77mhRXWMCAPF0gTKtdgn7jJ28QaY2+7OUCHMn00tm/sta5oGi/6iDVDK8i0
         xoGAvqSSjxF8zoxGiU5GphBr5nGgw5+ln8DXxHiUx0xVoLObpcLFKQxZQplAhj2XoO
         ealTmacuXXqtJkmtrwuOiMZpwrapBT9S0uG5TfpychI5LgmjOxn54lmyFXr3bg+tHx
         luED3OJUkb7Hg7RWcYp3FpMBRIv5QDtn4E+K1ZrpCW3m0TIO6m4U1e+pClGkHRLAKi
         UK1PIrfxpOCzw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 9/9] arm64: implement dynamic shadow call stack for GCC
Date:   Wed, 13 Oct 2021 17:22:43 +0200
Message-Id: <20211013152243.2216899-10-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
References: <20211013152243.2216899-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9853; h=from:subject; bh=PXB3zQXwY0Jqsa61K53dco0RurO4Co2tyKwXIIahwnI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvnCc0tGMlh3ZCFYjZM2hyOSuNfLhbLZgsGho1t0 P7mNuiGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5wgAKCRDDTyI5ktmPJJeeC/ 9lm4HJNbi4cGb6v06k8mFyWNcgjJHCh3uOLd71S/+nknFxy1El071KwD5LlBnfRRdIIucHHYtYupK9 nFSpJ4KwteZH57ktKejg1WvAFkg0oCy4KllJBnAQuQUnVoeGRczXfRLYuffk2n5TJe7Xqok9zQQ2kS o0simTEfnjIjltwa5n4oF7wwuqsFFU9xiEzkpRDMwdzLyaMzdpIRmFKBzvNdtdD09PfjojMiNcovZo M6LBrXwe5Wb1T/vzCxoyUS61YlqLFcpjPZRHDYq/hm0etgKpCv2Lc2KHbsJfPCnX6Y5UTQG8Sjl/kb lm7VpQmFdmxpElNQt9aC2AeDvUE8MDoqxNNUwjZknODCWiIWjCey/87M+rZdilLnDU+gS4oTA7NHuK UKiXp3Th+UH+xHhQcwWilZB/0STKi0indpgYnUUY73g93SlPznpfi8vN/KjYDw011uyUxDl0vNTQo/ yoGxvrhrr9/965QV5fCTP7uiaLyhvoGffecTuBO1XjDhs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Implement support for the shadow call stack on GCC, and in a dynamic
manner, by parsing the unwind tables at init time to locate all
occurrences of PACIASP/AUTIASP, and replacing them with the shadow call
stack push and pop instructions, respectively.

This is useful because the overhead of the shadow call stack is
difficult to justify on hardware that implements pointer authentication
(PAC), and given that the PAC instructions are executed as NOPs on
hardware that doesn't, we can just replace them.

This patch only implements this for the core kernel, but the logic can
be reused for modules without much trouble.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Makefile                      |   4 +-
 arch/Kconfig                  |   4 +-
 arch/arm64/Kconfig            |   8 +-
 arch/arm64/kernel/Makefile    |   2 +
 arch/arm64/kernel/head.S      |   3 +
 arch/arm64/kernel/patch-scs.c | 223 ++++++++++++++++++++
 6 files changed, 239 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 7cfe4ff36f44..2d94fed93d9d 100644
--- a/Makefile
+++ b/Makefile
@@ -933,8 +933,8 @@ LDFLAGS_vmlinux += --gc-sections
 endif
 
 ifdef CONFIG_SHADOW_CALL_STACK
-CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
-KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
+CC_FLAGS_SCS-$(CONFIG_CC_IS_CLANG)	:= -fsanitize=shadow-call-stack
+KBUILD_CFLAGS				+= $(CC_FLAGS_SCS-y)
 export CC_FLAGS_SCS
 endif
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c7102643..21eeec66bf4c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -596,8 +596,8 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 	  switching.
 
 config SHADOW_CALL_STACK
-	bool "Clang Shadow Call Stack"
-	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
+	bool "Shadow Call Stack"
+	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
 	help
 	  This option enables Clang's Shadow Call Stack, which uses a
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 742baca09343..6d74822fd386 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -81,7 +81,7 @@ config ARM64
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
-	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK || CC_IS_GCC
 	select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_CFI_CLANG
@@ -353,6 +353,12 @@ config KASAN_SHADOW_OFFSET
 config UNWIND_TABLES
 	bool
 
+config UNWIND_PATCH_PAC_INTO_SCS
+	def_bool y
+	depends on CC_IS_GCC && SHADOW_CALL_STACK
+	select UNWIND_TABLES
+	select ARM64_PTR_AUTH_KERNEL
+
 source "arch/arm64/Kconfig.platforms"
 
 menu "Kernel Features"
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 3f1490bfb938..42b9bd92d51e 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -73,6 +73,8 @@ obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
 obj-y					+= vdso-wrap.o
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
+obj-$(CONFIG_UNWIND_PATCH_PAC_INTO_SCS)	+= patch-scs.o
+CFLAGS_patch-scs.o			+= -mbranch-protection=none
 
 obj-y					+= probes/
 head-y					:= head.o
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 17962452e31d..5d50d212d3ae 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -447,6 +447,9 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
+#ifdef CONFIG_UNWIND_PATCH_PAC_INTO_SCS
+	bl	scs_patch_vmlinux
+#endif
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
diff --git a/arch/arm64/kernel/patch-scs.c b/arch/arm64/kernel/patch-scs.c
new file mode 100644
index 000000000000..878a40060550
--- /dev/null
+++ b/arch/arm64/kernel/patch-scs.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 - Google LLC
+ * Author: Ard Biesheuvel <ardb@google.com>
+ */
+
+#include <linux/bug.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#define DW_CFA_nop                          0x00
+#define DW_CFA_set_loc                      0x01
+#define DW_CFA_advance_loc1                 0x02
+#define DW_CFA_advance_loc2                 0x03
+#define DW_CFA_advance_loc4                 0x04
+#define DW_CFA_offset_extended              0x05
+#define DW_CFA_restore_extended             0x06
+#define DW_CFA_undefined                    0x07
+#define DW_CFA_same_value                   0x08
+#define DW_CFA_register                     0x09
+#define DW_CFA_remember_state               0x0a
+#define DW_CFA_restore_state                0x0b
+#define DW_CFA_def_cfa                      0x0c
+#define DW_CFA_def_cfa_register             0x0d
+#define DW_CFA_def_cfa_offset               0x0e
+#define DW_CFA_def_cfa_expression           0x0f
+#define DW_CFA_expression                   0x10
+#define DW_CFA_offset_extended_sf           0x11
+#define DW_CFA_def_cfa_sf                   0x12
+#define DW_CFA_def_cfa_offset_sf            0x13
+#define DW_CFA_val_offset                   0x14
+#define DW_CFA_val_offset_sf                0x15
+#define DW_CFA_val_expression               0x16
+#define DW_CFA_lo_user                      0x1c
+#define DW_CFA_negate_ra_state              0x2d
+#define DW_CFA_GNU_args_size                0x2e
+#define DW_CFA_GNU_negative_offset_extended 0x2f
+#define DW_CFA_hi_user                      0x3f
+
+static unsigned long get_uleb128(const u8 **pcur, const u8 *end)
+{
+	const u8 *cur = *pcur;
+	unsigned long value;
+	unsigned int shift;
+
+	for (shift = 0, value = 0; cur < end; shift += 7) {
+		if (shift + 7 > 8 * sizeof(value)
+		    && (*cur & 0x7fU) >= (1U << (8 * sizeof(value) - shift))) {
+			cur = end + 1;
+			break;
+		}
+		value |= (unsigned long) (*cur & 0x7f) << shift;
+		if (!(*cur++ & 0x80))
+			break;
+	}
+	*pcur = cur;
+
+	return value;
+}
+
+extern const u8 __eh_frame_start[], __eh_frame_end[];
+
+struct fde_frame {
+	s32		initial_loc;
+	s32		range;
+};
+
+static int scs_patch_loc(u64 loc)
+{
+	u32 insn = le32_to_cpup((void *)loc);
+
+	/*
+	 * Sometimes, the unwind data appears to be out of sync, and associates
+	 * the DW_CFA_negate_ra_state directive with the ret instruction
+	 * following the autiasp, rather than the autiasp itself.
+	 */
+	if (insn == 0xd65f03c0) { // ret
+		loc -= 4;
+		insn = le32_to_cpup((void *)loc);
+	}
+
+	switch (insn) {
+	case 0xd503233f: // paciasp
+		*(u32 *)loc = cpu_to_le32(0xf800865e);
+		break;
+	case 0xd50323bf: // autiasp
+		*(u32 *)loc = cpu_to_le32(0xf85f8e5e);
+		break;
+	default:
+		// ignore
+		break;
+	}
+	return 0;
+}
+
+static int noinstr scs_handle_frame(const u8 eh_frame[], u32 size)
+{
+	const struct fde_frame *fde;
+	const u8 *opcode;
+	u64 loc;
+
+	/*
+	 * For patching PAC opcodes, we only care about the FDE records, and
+	 * not the CIE, which carries the initial CFA directives but they only
+	 * pertain to which register is the stack pointer.
+	 * TODO this is not 100% true - we need the augmentation string and the
+	 * encoding but they are always the same in practice.
+	 */
+	if (*(u32 *)eh_frame == 0)
+		return 0;
+
+	fde = (const struct fde_frame *)(eh_frame + 4);
+	loc = (u64)offset_to_ptr(&fde->initial_loc);
+	opcode = (const u8 *)(fde + 1);
+
+	// TODO check augmentation data
+	WARN_ON(*opcode++);
+	size -= sizeof(u32) + sizeof(*fde) + 1;
+
+	/*
+	 * Starting from 'loc', apply the CFA opcodes that advance the location
+	 * pointer, and identify the locations of the PAC instructions.
+	 */
+	do {
+		const u8 *end;
+
+		switch (*opcode & 0xC0) {
+		case 0:
+			// handle DW_CFA_xxx opcodes
+			switch (*opcode) {
+				int ret;
+
+			case DW_CFA_nop:
+			case DW_CFA_remember_state:
+			case DW_CFA_restore_state:
+				break;
+
+			case DW_CFA_advance_loc1:
+				loc += 4 * *++opcode;
+				size--;
+				break;
+
+			case DW_CFA_advance_loc2:
+				loc += 4 * *++opcode;
+				loc += 4 * *++opcode << 8;
+				size -= 2;
+				break;
+
+			case DW_CFA_def_cfa:
+			case DW_CFA_def_cfa_offset:
+			case DW_CFA_def_cfa_register:
+				opcode++;
+				size--;
+				end = opcode + size;
+				get_uleb128(&opcode, end);
+				size = end - opcode;
+				continue;
+
+			case DW_CFA_negate_ra_state:
+				// patch paciasp/autiasp into shadow stack push/pop
+				ret = scs_patch_loc(loc - 4);
+				if (ret)
+					return ret;
+				break;
+
+			default:
+				pr_debug("unhandled opcode: %02x\n", *opcode);
+				return -ENOEXEC;
+			}
+			opcode++;
+			size--;
+			break;
+
+		case 0x40:
+			// advance loc
+			loc += (*opcode++ & 0x3f) * 4;
+			size--;
+			break;
+
+		case 0x80:
+			opcode++;
+			size--;
+			end = opcode + size;
+			get_uleb128(&opcode, end);
+			size = end - opcode;
+			continue;
+
+		default:
+			// ignore
+			opcode++;
+			size--;
+			break;
+		}
+	} while (size > 0);
+
+	return 0;
+}
+
+int noinstr scs_patch(const u8 eh_frame[], int size)
+{
+	const u8 *p = eh_frame;
+
+	while (size > 4) {
+		const u32 *frame_size = (const u32 *)p;
+		int ret;
+
+		if (*frame_size != -1 && *frame_size <= size) {
+			ret = scs_handle_frame(p + 4, *frame_size);
+			if (ret)
+				return ret;
+			p += 4 + *frame_size;
+			size -= 4 + *frame_size;
+		}
+	}
+	return 0;
+}
+
+asmlinkage int noinstr scs_patch_vmlinux(void)
+{
+	return scs_patch(__eh_frame_start, __eh_frame_end - __eh_frame_start);
+}
-- 
2.30.2

