Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A5C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbiAXRsd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50118 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiAXRsc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E309CB811A5
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F9CC340E8;
        Mon, 24 Jan 2022 17:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046510;
        bh=kBmjChGfVHtfptt13fVh04pzGlJ1Uj7ogIqlHIXKQj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWX8RkR0btj9Tw53wmyh1lFH3wcXvtwFtulZPXOrWN1AHagnq8Zqv11cyGyk4ad5t
         n0PtTtCbTZA5ttekO22Z9kcAnwksVlnOBcvKO6FXoMfc5C2C7+F8peXufvyMYD0/8z
         l8IR7XBfzTi/06T98t6HxXZBN2/dY49BhSezjPWM5B7ssOX05AmYStWj74AjPBsiv+
         BRC4v1QGausEM/aVV1ML0r7CeLXzVxG+NaEXEaebUxZLINl5P26kRASZHweVHIdgNS
         ngqjmPMXW/774cEbBIK1f7mtCSc6v00dbZx/nJL6DMi68nA72h1BCVcF4jLyFGaRRN
         vcZ72SKQ/f1Lg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v5 11/32] ARM: module: implement support for PC-relative group relocations
Date:   Mon, 24 Jan 2022 18:47:23 +0100
Message-Id: <20220124174744.1054712-12-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5346; h=from:subject; bh=kBmjChGfVHtfptt13fVh04pzGlJ1Uj7ogIqlHIXKQj4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYWeuBhQsF3ikfXqO+YfGeTbi2+AvfVgREj5qVw xwbWrOuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mFgAKCRDDTyI5ktmPJM2pC/ 4iBSLZWPiF/mOcOz5TZoO7EPoemwc/tM4q+eCZKPY3enCIx5QoDTL3abUXf2c+GoqpQq8rZKjybH6x z5unKDlpumlbaxhv0JRFhC1uCb3WqMhD43IeoSKvt4gey6jSVBbruoTRyMDyX2Ad6Ix04hoFbBGdU6 uHPqDabj1s08jAuuhScSLH5gp07mNf5rxwsd6nvG1U5M+hhVqkgSvjdc9eBYD7Xtc/K2olVpzBS1Cb taPA1bu0ctDzuujtOlDXv9gyFrxLrpHsnFQ3hlqBQr8RFIgGkIhfMVu+zzQLT+D2fQQsl89snKxqBz Hp/kLp2gKIwTr8MCayeYgvtCT+XWyw0ox1LcqD5cLsh3nGGJZNSAJT4F9XMpeXA0B5ZdCNEAX1Dyz/ TSHN6+4gD11GI8D9pEAsdwKWF1oKpk/3p+48PVmsL2/h7GdRrjez2hHd4xeH1fc4ecamVfzobbjcKI qDBQny6DiGhPdpAFu+bJlWaKtG/BByJCxDnjnCDqGSnpQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add support for the R_ARM_ALU_PC_Gn_NC and R_ARM_LDR_PC_G2 group
relocations [0] so we can use them in modules. These will be used to
load the current task pointer from a global variable without having to
rely on a literal pool entry to carry the address of this variable,
which may have a significant negative impact on cache utilization for
variables that are used often and in many different places, as each
occurrence will result in a literal pool entry and therefore a line in
the D-cache.

[0] 'ELF for the ARM architecture'
    https://github.com/ARM-software/abi-aa/releases

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/include/asm/elf.h |  3 +
 arch/arm/kernel/module.c   | 90 ++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index b8102a6ddf16..d68101655b74 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -61,6 +61,9 @@ typedef struct user_fp elf_fpregset_t;
 #define R_ARM_MOVT_ABS		44
 #define R_ARM_MOVW_PREL_NC	45
 #define R_ARM_MOVT_PREL		46
+#define R_ARM_ALU_PC_G0_NC	57
+#define R_ARM_ALU_PC_G1_NC	59
+#define R_ARM_LDR_PC_G2		63
 
 #define R_ARM_THM_CALL		10
 #define R_ARM_THM_JUMP24	30
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index beac45e89ba6..49ff7fd18f0c 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -68,6 +68,44 @@ bool module_exit_section(const char *name)
 		strstarts(name, ".ARM.exidx.exit");
 }
 
+#ifdef CONFIG_ARM_HAS_GROUP_RELOCS
+/*
+ * This implements the partitioning algorithm for group relocations as
+ * documented in the ARM AArch32 ELF psABI (IHI 0044).
+ *
+ * A single PC-relative symbol reference is divided in up to 3 add or subtract
+ * operations, where the final one could be incorporated into a load/store
+ * instruction with immediate offset. E.g.,
+ *
+ *   ADD	Rd, PC, #...		or	ADD	Rd, PC, #...
+ *   ADD	Rd, Rd, #...			ADD	Rd, Rd, #...
+ *   LDR	Rd, [Rd, #...]			ADD	Rd, Rd, #...
+ *
+ * The latter has a guaranteed range of only 16 MiB (3x8 == 24 bits), so it is
+ * of limited use in the kernel. However, the ADD/ADD/LDR combo has a range of
+ * -/+ 256 MiB, (2x8 + 12 == 28 bits), which means it has sufficient range for
+ * any in-kernel symbol reference (unless module PLTs are being used).
+ *
+ * The main advantage of this approach over the typical pattern using a literal
+ * load is that literal loads may miss in the D-cache, and generally lead to
+ * lower cache efficiency for variables that are referenced often from many
+ * different places in the code.
+ */
+static u32 get_group_rem(u32 group, u32 *offset)
+{
+	u32 val = *offset;
+	u32 shift;
+	do {
+		shift = val ? (31 - __fls(val)) & ~1 : 32;
+		*offset = val;
+		if (!val)
+			break;
+		val &= 0xffffff >> shift;
+	} while (group--);
+	return shift;
+}
+#endif
+
 int
 apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 	       unsigned int relindex, struct module *module)
@@ -87,6 +125,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 #ifdef CONFIG_THUMB2_KERNEL
 		u32 upper, lower, sign, j1, j2;
 #endif
+#ifdef CONFIG_ARM_HAS_GROUP_RELOCS
+		u32 shift, group = 1;
+#endif
 
 		offset = ELF32_R_SYM(rel->r_info);
 		if (offset < 0 || offset > (symsec->sh_size / sizeof(Elf32_Sym))) {
@@ -331,6 +372,55 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			*(u16 *)(loc + 2) = __opcode_to_mem_thumb16(lower);
 			break;
 #endif
+#ifdef CONFIG_ARM_HAS_GROUP_RELOCS
+		case R_ARM_ALU_PC_G0_NC:
+			group = 0;
+			fallthrough;
+		case R_ARM_ALU_PC_G1_NC:
+			tmp = __mem_to_opcode_arm(*(u32 *)loc);
+			offset = ror32(tmp & 0xff, (tmp & 0xf00) >> 7);
+			if (tmp & BIT(22))
+				offset = -offset;
+			offset += sym->st_value - loc;
+			if (offset < 0) {
+				offset = -offset;
+				tmp = (tmp & ~BIT(23)) | BIT(22); // SUB opcode
+			} else {
+				tmp = (tmp & ~BIT(22)) | BIT(23); // ADD opcode
+			}
+
+			shift = get_group_rem(group, &offset);
+			if (shift < 24) {
+				offset >>= 24 - shift;
+				offset |= (shift + 8) << 7;
+			}
+			*(u32 *)loc = __opcode_to_mem_arm((tmp & ~0xfff) | offset);
+			break;
+
+		case R_ARM_LDR_PC_G2:
+			tmp = __mem_to_opcode_arm(*(u32 *)loc);
+			offset = tmp & 0xfff;
+			if (~tmp & BIT(23))		// U bit cleared?
+				offset = -offset;
+			offset += sym->st_value - loc;
+			if (offset < 0) {
+				offset = -offset;
+				tmp &= ~BIT(23);	// clear U bit
+			} else {
+				tmp |= BIT(23);		// set U bit
+			}
+			get_group_rem(2, &offset);
+
+			if (offset > 0xfff) {
+				pr_err("%s: section %u reloc %u sym '%s': relocation %u out of range (%#lx -> %#x)\n",
+				       module->name, relindex, i, symname,
+				       ELF32_R_TYPE(rel->r_info), loc,
+				       sym->st_value);
+				return -ENOEXEC;
+			}
+			*(u32 *)loc = __opcode_to_mem_arm((tmp & ~0xfff) | offset);
+			break;
+#endif
 
 		default:
 			pr_err("%s: unknown relocation: %u\n",
-- 
2.30.2

