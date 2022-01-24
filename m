Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6499CC4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbiAXRsf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43556 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiAXRse (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CDC761312
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E16C340EB;
        Mon, 24 Jan 2022 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046513;
        bh=YhN3QJGzpYUXpQwGEXw+ci07ZoekkfIoc5ZDfaXpolY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugJcKpWfRF3r2V7E6qVihyl2wrRxRV4aQOpcbybKvIvkU3PZcAU8h6AFBV+eBzdmU
         avHZBEVF8WvWOugfTR9TVp05OEztf6bwO47hgEl7+6hX7p+K3TGiby8Gr6ODlcc3zZ
         zDY6RUOFC3R0IHtF2PB0L4b96MWMuLfwmuY46UVSfKFsEdv97A4E5wIzmo3kn+gxxP
         FjAxm9dM5LZhsUHA09IH9q9pG5kJdlyfJJZRqa4qsOwFdarCvISVuVOyTqv6uylz9p
         jt9z8c7bocmaTN302suOTGZgwdi0XurvbZJ3z5McXWjoyiJBU14cMYZaa9upmfYphG
         OMhT8I2yoSPGA==
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
Subject: [PATCH v5 12/32] ARM: assembler: add optimized ldr/str macros to load variables from memory
Date:   Mon, 24 Jan 2022 18:47:24 +0100
Message-Id: <20220124174744.1054712-13-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3676; h=from:subject; bh=YhN3QJGzpYUXpQwGEXw+ci07ZoekkfIoc5ZDfaXpolY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYY8XhWWCvJjXsZiYsX7wfoz9aWEplGFkAecTZb wKKXA22JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mGAAKCRDDTyI5ktmPJCtrC/ 47CN3ftvcb+Ch2vEH6ny+Ae+FD2UEGbf4OUvepURhboK55NqZ46AqBCXkBAx2EQzy7cePJ/7Ttl6lj T939KjdFgjUFI+wWiLvgTrk8kEDVNQdSqgxbSz1I9USBonk4n8JXSMC/j+/dTHVwvHdJ3zTaW7YJl1 1kYDlJrdqAw5BWfNLS9bmtCXYfTBpB67XaBnMt2eiEyiQcYV6y6J0TZpHrnijpMQ4NfQ8wkAmlF3fy QM5vM2VD0xjE6Q/UItsHm8SubOmCWYCtx4IAQPrOmiLdjhOkpu2ppNucWsvtnrz3S+Cg8XV4VMm3Ao qjeTx22DAhAvFu9ATD5KH/FZU1blUztq3b1N1LKk9lEqiT9ZWe7tQPPIRhmJ9r+SC2868bvxJ6LZdT QEHp/rpNESP8gAYHPLGRZKseZ0YY2jjpwNae4hnzYzXUXwTvTyBBpA9TlEPL4SCz4n7wgMCQSh7r/v LzKPoSW6VE+TtfJTKs7GLomAA62MSvhH7dvbS0aViLzVM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

We will be adding variable loads to various hot paths, so it makes sense
to add a helper macro that can load variables from asm code without the
use of literal pool entries. On v7 or later, we can simply use MOVW/MOVT
pairs, but on earlier cores, this requires a bit of hackery to emit a
instruction sequence that implements this using a sequence of ADD/LDR
instructions.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/Kconfig                 | 11 +++++
 arch/arm/include/asm/assembler.h | 48 ++++++++++++++++++--
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 99ac5d75dcec..9586636289d2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -139,6 +139,17 @@ config ARM
 	  Europe.  There is an ARM Linux project with a web page at
 	  <http://www.arm.linux.org.uk/>.
 
+config ARM_HAS_GROUP_RELOCS
+	def_bool y
+	depends on !LD_IS_LLD || LLD_VERSION >= 140000
+	depends on !COMPILE_TEST
+	help
+	  Whether or not to use R_ARM_ALU_PC_Gn or R_ARM_LDR_PC_Gn group
+	  relocations, which have been around for a long time, but were not
+	  supported in LLD until version 14. The combined range is -/+ 256 MiB,
+	  which is usually sufficient, but not for allyesconfig, so we disable
+	  this feature when doing compile testing.
+
 config ARM_HAS_SG_CHAIN
 	bool
 
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 7d23d4bb2168..7a4e292b68e4 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -564,12 +564,12 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	/*
 	 * mov_l - move a constant value or [relocated] address into a register
 	 */
-	.macro		mov_l, dst:req, imm:req
+	.macro		mov_l, dst:req, imm:req, cond
 	.if		__LINUX_ARM_ARCH__ < 7
-	ldr		\dst, =\imm
+	ldr\cond	\dst, =\imm
 	.else
-	movw		\dst, #:lower16:\imm
-	movt		\dst, #:upper16:\imm
+	movw\cond	\dst, #:lower16:\imm
+	movt\cond	\dst, #:upper16:\imm
 	.endif
 	.endm
 
@@ -607,6 +607,46 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	__adldst_l	str, \src, \sym, \tmp, \cond
 	.endm
 
+	.macro		__ldst_va, op, reg, tmp, sym, offset=0, cond
+#if __LINUX_ARM_ARCH__ >= 7 || \
+    !defined(CONFIG_ARM_HAS_GROUP_RELOCS) || \
+    (defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
+	mov_l		\tmp, \sym, \cond
+#else
+	/*
+	 * Avoid a literal load, by emitting a sequence of ADD/LDR instructions
+	 * with the appropriate relocations. The combined sequence has a range
+	 * of -/+ 256 MiB, which should be sufficient for the core kernel and
+	 * for modules loaded into the module region.
+	 */
+	.globl		\sym
+	.reloc		.L0_\@, R_ARM_ALU_PC_G0_NC, \sym
+	.reloc		.L1_\@, R_ARM_ALU_PC_G1_NC, \sym
+	.reloc		.L2_\@, R_ARM_LDR_PC_G2, \sym
+.L0_\@: sub\cond	\tmp, pc, #8 - \offset
+.L1_\@: sub\cond	\tmp, \tmp, #4 - \offset
+#endif
+.L2_\@: \op\cond	\reg, [\tmp, #\offset]
+	.endm
+
+	/*
+	 * ldr_va - load a 32-bit word from the virtual address of \sym
+	 */
+	.macro		ldr_va, rd:req, sym:req, cond, tmp, offset
+	.ifb		\tmp
+	__ldst_va	ldr, \rd, \rd, \sym, \offset, \cond
+	.else
+	__ldst_va	ldr, \rd, \tmp, \sym, \offset, \cond
+	.endif
+	.endm
+
+	/*
+	 * str_va - store a 32-bit word to the virtual address of \sym
+	 */
+	.macro		str_va, rn:req, sym:req, tmp:req
+	__ldst_va	str, \rn, \tmp, \sym
+	.endm
+
 	/*
 	 * rev_l - byte-swap a 32-bit value
 	 *
-- 
2.30.2

