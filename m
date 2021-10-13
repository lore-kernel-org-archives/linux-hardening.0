Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE83EC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE4160FDA
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhJMPZL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhJMPZL (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:25:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51BC261151;
        Wed, 13 Oct 2021 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138587;
        bh=WAUPlo+6rkxh20C/Rd3ch6Ny8CbqlBcV9dvmBueVhJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rydVf2ZGqPUhh8gXLX+BLmUJKyj2OPvFwDS5Xg0Htl5WbXoml3sP3XUgRJpSTQsPj
         D5tR9TZx5SQaIMp25PCPU5LkOdLbnrMjzaE+8hPT2Up6VvDWVrTl7epVfraOqDhu8d
         bvPnxIirWIralEu7PksYEN1BANaHw4Tv5W/L3L1/9wYW1/y+rT46III0OW/1PO/OPs
         YhnAao6Raji9ay6merftk6FkoxwF7xMWlnTWbZ0eZrq1HLicSxP5CP3HQLs/qdLgsv
         5XrX14PTKJTIvzSK+1t8AoBI8w66mkfgkCqiCfLuwKSrFCxRp1lQbO+5BLuIW/8rTk
         nUzVagDxFEbLw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 7/9] arm64: assembler: add unwind annotations to frame push/pop macros
Date:   Wed, 13 Oct 2021 17:22:41 +0200
Message-Id: <20211013152243.2216899-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
References: <20211013152243.2216899-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4153; h=from:subject; bh=WAUPlo+6rkxh20C/Rd3ch6Ny8CbqlBcV9dvmBueVhJc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvm+f+lPsOaLzrEcFZ+XSixPrrCB/OfJN0rxMhvG 39kq5QqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5vgAKCRDDTyI5ktmPJHBfC/ 9OkG6Igq017oaBMCAEjx3/AiCKQMrbpzgwdfz9dG43g4m6sv+kOaGkVS7e0mTgzkY6WMprx8oK7Pty 7dexFNDKaeVKwgsfOQDTG4aw9IPmYin6BBoohz0Aen3JnkNUXSmHZI2hftinPr1JHJNciqi04zCCAw gQiXFE47ZTwkqofmsA78KbS1e8i/KQA5PYlBfthuXl0HTp5pvHoU79KG/rdNU+vN57zlfGOZlKCUNb TG6Nn6hFDYjcMIP68RMdHIwXTJchgW/xqNFrlbHMQbrFnysJlDzVj3SsundzCmXCOeSs0fH6ffHGRk hYNKNI46VoadcwjttB4ULrjROO6yR25+lZnBlGFurUgpe0lRiiNf0dH2KpT5gcSiG+lu63xv/F38U9 QaYut8C4ryl+BsMDCAA2s4Mjs/5ZnO7jGBlVcN31/DrIAcm+BRtt0Ed8N9O2QsIGTGW/nW78gMM3tL tIo8K0EQqYUWAmAILNS+PZDeqoc08/XTkmW+yROezSU3E=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to ensure that we can unwind from hand rolled assembly
routines, decorate the frame push/pop helper macros that are used by
non-leaf assembler routines with the appropriate annotations.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h | 26 +++++++++++++++++++-
 arch/arm64/include/asm/linkage.h   | 16 +++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ceed84ac4005..cebb6c8c489b 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -664,9 +664,10 @@ alternative_endif
 	 *              the new value of sp. Add @extra bytes of stack space
 	 *              for locals.
 	 */
-	.macro		frame_push, regcount:req, extra
+	.macro		frame_push, regcount:req, extra=0
 #ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
 	paciasp
+	.cfi_negate_ra_state
 #endif
 	__frame		st, \regcount, \extra
 	.endm
@@ -681,14 +682,29 @@ alternative_endif
 	__frame		ld
 #ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
 	autiasp
+	.cfi_negate_ra_state
 #endif
 	.endm
 
 	.macro		__frame_regs, reg1, reg2, op, num
 	.if		.Lframe_regcount == \num
 	\op\()r		\reg1, [sp, #(\num + 1) * 8]
+	.ifc		\op, st
+	.cfi_offset	\reg1, -.Lframe_cfa_offset
+	.set		.Lframe_cfa_offset, .Lframe_cfa_offset - 8
+	.else
+	.cfi_restore	\reg1
+	.endif
 	.elseif		.Lframe_regcount > \num
 	\op\()p		\reg1, \reg2, [sp, #(\num + 1) * 8]
+	.ifc		\op, st
+	.cfi_offset	\reg1, -.Lframe_cfa_offset
+	.cfi_offset	\reg2, -.Lframe_cfa_offset + 8
+	.set		.Lframe_cfa_offset, .Lframe_cfa_offset - 16
+	.else
+	.cfi_restore	\reg1
+	.cfi_restore	\reg2
+	.endif
 	.endif
 	.endm
 
@@ -708,7 +724,12 @@ alternative_endif
 	.set		.Lframe_regcount, \regcount
 	.set		.Lframe_extra, \extra
 	.set		.Lframe_local_offset, ((\regcount + 3) / 2) * 16
+	.set		.Lframe_cfa_offset, .Lframe_local_offset + .Lframe_extra
 	stp		x29, x30, [sp, #-.Lframe_local_offset - .Lframe_extra]!
+	.cfi_def_cfa_offset .Lframe_cfa_offset
+	.cfi_offset	x29, -.Lframe_cfa_offset
+	.cfi_offset	x30, -.Lframe_cfa_offset + 8
+	.set		.Lframe_cfa_offset, .Lframe_cfa_offset - 16
 	mov		x29, sp
 	.endif
 
@@ -723,6 +744,9 @@ alternative_endif
 	.error		"frame_push/frame_pop may not be nested"
 	.endif
 	ldp		x29, x30, [sp], #.Lframe_local_offset + .Lframe_extra
+	.cfi_restore	x29
+	.cfi_restore	x30
+	.cfi_def_cfa_offset 0
 	.set		.Lframe_regcount, -1
 	.endif
 	.endm
diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index 9906541a6861..d984a6750b01 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -4,6 +4,9 @@
 #define __ALIGN		.align 2
 #define __ALIGN_STR	".align 2"
 
+#define SYM_FUNC_CFI_START	.cfi_startproc ;
+#define SYM_FUNC_CFI_END	.cfi_endproc ;
+
 #if defined(CONFIG_ARM64_BTI_KERNEL) && defined(__aarch64__)
 
 /*
@@ -12,6 +15,9 @@
  * instead.
  */
 #define BTI_C hint 34 ;
+#else
+#define BTI_C
+#endif
 
 /*
  * When using in-kernel BTI we need to ensure that PCS-conformant assembly
@@ -20,29 +26,37 @@
  */
 #define SYM_FUNC_START(name)				\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	SYM_FUNC_CFI_START				\
 	BTI_C
 
 #define SYM_FUNC_START_NOALIGN(name)			\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
+	SYM_FUNC_CFI_START				\
 	BTI_C
 
 #define SYM_FUNC_START_LOCAL(name)			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
+	SYM_FUNC_CFI_START				\
 	BTI_C
 
 #define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
+	SYM_FUNC_CFI_START				\
 	BTI_C
 
 #define SYM_FUNC_START_WEAK(name)			\
 	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
+	SYM_FUNC_CFI_START				\
 	BTI_C
 
 #define SYM_FUNC_START_WEAK_NOALIGN(name)		\
 	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
+	SYM_FUNC_CFI_START				\
 	BTI_C
 
-#endif
+#define SYM_FUNC_END(name)				\
+	SYM_FUNC_CFI_END				\
+	SYM_END(name, SYM_T_FUNC)
 
 /*
  * Annotate a function as position independent, i.e., safe to be called before
-- 
2.30.2

