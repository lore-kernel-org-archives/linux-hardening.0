Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B70C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbiAXRtY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50598 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbiAXRtT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BB91B811AF
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF51C36AE9;
        Mon, 24 Jan 2022 17:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046556;
        bh=3FDhs7S5Ica25HEAyUeDQsXqhjFXC2xvlHsmW9hgBgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Befq5XB9WUD3CIpsl6hMnDLaycPMhoCCmlCNzIrKa7tLDOdW4XdLbngOHtd4hYkj/
         uGheG/SH1ePX6fzga3iDypM6d1Ix26NijzOuqAQia1w22v7u1dNc5aKBZCDLYFZvlg
         Zc9AKjNlz4UQwAHnNCAjIrwQQOfCo2pN8Sq+Gr6d9cvSztYwWr4+twrmnNbuARFtyn
         beWEvHw+WEcJZYKFLjHWmtIBiNc69vlZesLPJMjMbscUu9kJBOTVgyMEaX+tzyjyDv
         oACCnbRAJyns5fNPnKM/xNw8fIa281+GpwwBKoAMIrtHlCK7bmiC2jN2bLWkvaDfGe
         0pwtzCn4pCdow==
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
Subject: [PATCH v5 25/32] ARM: memcpy: use frame pointer as unwind anchor
Date:   Mon, 24 Jan 2022 18:47:37 +0100
Message-Id: <20220124174744.1054712-26-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8309; h=from:subject; bh=3FDhs7S5Ica25HEAyUeDQsXqhjFXC2xvlHsmW9hgBgs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYxrw/HMZYdKW42khW02kBRjUKRXmxfElmB/LVE PM1EPAiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mMQAKCRDDTyI5ktmPJDE0C/ 9/JDIKDSsIoVGdQ+/VPooFk98gHHl85ScW+I8iH1tHQbG5irlLDKM/tZSRu5idPH8hafOSCQHjtiAl R8yfZnZj7vNT7VgS60fnrBrbxSNa0u6njXCfhjE0lfQU0GtH9Wb+M+XWtx8F2R33+CH9NT/GXHpyr1 V2DrLZGSVyRATRLk1wRWgBFy2LqrVSVWxL8rbssc6C31Omx6OZ2UaUv7tAZqY48lnn5coOXu9J4WFW 4NmhdJEKUPcCbv00lW6ZIozXSjCY2P9MUMriLGI2qSfUEtF05QxkZ2etmWjYWHzOMGJENZ04GDFKBI gjdL43KW+mWxHWnWF3+0y767kt1dg+TDkDU47Vn2mC3PZn+zo5Vv2H8JgAYRDkCWglbSX1IQwctF3c 6Vl1nYAvHcz7guUCJLz4JGQk+siFTdXi2OtFecnFGEgXaAAd6uh0ae+hBpiU7nTWcv0S9Cuw9W/uGr o513DO400bJeIzonxzpuIYCgoxZgbJnN8bv5la6y5s7WY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The memcpy template is a bit unusual in the way it manages the stack
pointer: depending on the execution path through the function, the SP
assumes different values as different subsets of the register file are
preserved and restored again. This is problematic when it comes to EHABI
unwind info, as it is not instruction accurate, and does not allow
tracking the SP value as it changes.

Commit 279f487e0b471 ("ARM: 8225/1: Add unwinding support for memory
copy functions") addressed this by carving up the function in different
chunks as far as the unwinder is concerned, and keeping a set of unwind
directives for each of them, each corresponding with the state of the
stack pointer during execution of the chunk in question. This not only
duplicates unwind info unnecessarily, but it also complicates unwinding
the stack upon overflow.

Instead, let's do what the compiler does when the SP is updated halfway
through a function, which is to use a frame pointer and emit the
appropriate unwind directives to communicate this to the unwinder.

Note that Thumb-2 uses R7 for this, while ARM uses R11 aka FP. So let's
avoid touching R7 in the body of the template, so that Thumb-2 can use
it as the frame pointer. R11 was not modified in the first place.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/lib/copy_from_user.S | 13 ++--
 arch/arm/lib/copy_template.S  | 67 +++++++-------------
 arch/arm/lib/copy_to_user.S   | 13 ++--
 arch/arm/lib/memcpy.S         | 13 ++--
 4 files changed, 38 insertions(+), 68 deletions(-)

diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 480a20766137..270de7debd0f 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -91,18 +91,15 @@
 	strb\cond \reg, [\ptr], #1
 	.endm
 
-	.macro enter reg1 reg2
+	.macro enter regs:vararg
 	mov	r3, #0
-	stmdb	sp!, {r0, r2, r3, \reg1, \reg2}
+UNWIND( .save	{r0, r2, r3, \regs}		)
+	stmdb	sp!, {r0, r2, r3, \regs}
 	.endm
 
-	.macro usave reg1 reg2
-	UNWIND(	.save {r0, r2, r3, \reg1, \reg2}	)
-	.endm
-
-	.macro exit reg1 reg2
+	.macro exit regs:vararg
 	add	sp, sp, #8
-	ldmfd	sp!, {r0, \reg1, \reg2}
+	ldmfd	sp!, {r0, \regs}
 	.endm
 
 	.text
diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
index 810a805d36dc..8fbafb074fe9 100644
--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -69,13 +69,10 @@
  *	than one 32bit instruction in Thumb-2)
  */
 
-
-	UNWIND(	.fnstart			)
-		enter	r4, lr
-	UNWIND(	.fnend				)
-
 	UNWIND(	.fnstart			)
-		usave	r4, lr			  @ in first stmdb block
+		enter	r4, UNWIND(fpreg,) lr
+	UNWIND(	.setfp	fpreg, sp		)
+	UNWIND(	mov	fpreg, sp		)
 
 		subs	r2, r2, #4
 		blt	8f
@@ -86,12 +83,7 @@
 		bne	10f
 
 1:		subs	r2, r2, #(28)
-		stmfd	sp!, {r5 - r8}
-	UNWIND(	.fnend				)
-
-	UNWIND(	.fnstart			)
-		usave	r4, lr
-	UNWIND(	.save	{r5 - r8}		) @ in second stmfd block
+		stmfd	sp!, {r5, r6, r8, r9}
 		blt	5f
 
 	CALGN(	ands	ip, r0, #31		)
@@ -110,9 +102,9 @@
 	PLD(	pld	[r1, #92]		)
 
 3:	PLD(	pld	[r1, #124]		)
-4:		ldr8w	r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
+4:		ldr8w	r1, r3, r4, r5, r6, r8, r9, ip, lr, abort=20f
 		subs	r2, r2, #32
-		str8w	r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
+		str8w	r0, r3, r4, r5, r6, r8, r9, ip, lr, abort=20f
 		bge	3b
 	PLD(	cmn	r2, #96			)
 	PLD(	bge	4b			)
@@ -132,8 +124,8 @@
 		ldr1w	r1, r4, abort=20f
 		ldr1w	r1, r5, abort=20f
 		ldr1w	r1, r6, abort=20f
-		ldr1w	r1, r7, abort=20f
 		ldr1w	r1, r8, abort=20f
+		ldr1w	r1, r9, abort=20f
 		ldr1w	r1, lr, abort=20f
 
 #if LDR1W_SHIFT < STR1W_SHIFT
@@ -150,17 +142,14 @@
 		str1w	r0, r4, abort=20f
 		str1w	r0, r5, abort=20f
 		str1w	r0, r6, abort=20f
-		str1w	r0, r7, abort=20f
 		str1w	r0, r8, abort=20f
+		str1w	r0, r9, abort=20f
 		str1w	r0, lr, abort=20f
 
 	CALGN(	bcs	2b			)
 
-7:		ldmfd	sp!, {r5 - r8}
-	UNWIND(	.fnend				) @ end of second stmfd block
+7:		ldmfd	sp!, {r5, r6, r8, r9}
 
-	UNWIND(	.fnstart			)
-		usave	r4, lr			  @ still in first stmdb block
 8:		movs	r2, r2, lsl #31
 		ldr1b	r1, r3, ne, abort=21f
 		ldr1b	r1, r4, cs, abort=21f
@@ -169,7 +158,7 @@
 		str1b	r0, r4, cs, abort=21f
 		str1b	r0, ip, cs, abort=21f
 
-		exit	r4, pc
+		exit	r4, UNWIND(fpreg,) pc
 
 9:		rsb	ip, ip, #4
 		cmp	ip, #2
@@ -189,13 +178,10 @@
 		ldr1w	r1, lr, abort=21f
 		beq	17f
 		bgt	18f
-	UNWIND(	.fnend				)
 
 
 		.macro	forward_copy_shift pull push
 
-	UNWIND(	.fnstart			)
-		usave	r4, lr			  @ still in first stmdb block
 		subs	r2, r2, #28
 		blt	14f
 
@@ -205,12 +191,8 @@
 	CALGN(	subcc	r2, r2, ip		)
 	CALGN(	bcc	15f			)
 
-11:		stmfd	sp!, {r5 - r9}
-	UNWIND(	.fnend				)
+11:		stmfd	sp!, {r5, r6, r8 - r10}
 
-	UNWIND(	.fnstart			)
-		usave	r4, lr
-	UNWIND(	.save	{r5 - r9}		) @ in new second stmfd block
 	PLD(	pld	[r1, #0]		)
 	PLD(	subs	r2, r2, #96		)
 	PLD(	pld	[r1, #28]		)
@@ -219,35 +201,32 @@
 	PLD(	pld	[r1, #92]		)
 
 12:	PLD(	pld	[r1, #124]		)
-13:		ldr4w	r1, r4, r5, r6, r7, abort=19f
+13:		ldr4w	r1, r4, r5, r6, r8, abort=19f
 		mov	r3, lr, lspull #\pull
 		subs	r2, r2, #32
-		ldr4w	r1, r8, r9, ip, lr, abort=19f
+		ldr4w	r1, r9, r10, ip, lr, abort=19f
 		orr	r3, r3, r4, lspush #\push
 		mov	r4, r4, lspull #\pull
 		orr	r4, r4, r5, lspush #\push
 		mov	r5, r5, lspull #\pull
 		orr	r5, r5, r6, lspush #\push
 		mov	r6, r6, lspull #\pull
-		orr	r6, r6, r7, lspush #\push
-		mov	r7, r7, lspull #\pull
-		orr	r7, r7, r8, lspush #\push
+		orr	r6, r6, r8, lspush #\push
 		mov	r8, r8, lspull #\pull
 		orr	r8, r8, r9, lspush #\push
 		mov	r9, r9, lspull #\pull
-		orr	r9, r9, ip, lspush #\push
+		orr	r9, r9, r10, lspush #\push
+		mov	r10, r10, lspull #\pull
+		orr	r10, r10, ip, lspush #\push
 		mov	ip, ip, lspull #\pull
 		orr	ip, ip, lr, lspush #\push
-		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, abort=19f
+		str8w	r0, r3, r4, r5, r6, r8, r9, r10, ip, abort=19f
 		bge	12b
 	PLD(	cmn	r2, #96			)
 	PLD(	bge	13b			)
 
-		ldmfd	sp!, {r5 - r9}
-	UNWIND(	.fnend				) @ end of the second stmfd block
+		ldmfd	sp!, {r5, r6, r8 - r10}
 
-	UNWIND(	.fnstart			)
-		usave	r4, lr			  @ still in first stmdb block
 14:		ands	ip, r2, #28
 		beq	16f
 
@@ -262,7 +241,6 @@
 
 16:		sub	r1, r1, #(\push / 8)
 		b	8b
-	UNWIND(	.fnend				)
 
 		.endm
 
@@ -273,6 +251,7 @@
 
 18:		forward_copy_shift	pull=24	push=8
 
+	UNWIND(	.fnend				)
 
 /*
  * Abort preamble and completion macros.
@@ -282,13 +261,13 @@
  */
 
 	.macro	copy_abort_preamble
-19:	ldmfd	sp!, {r5 - r9}
+19:	ldmfd	sp!, {r5, r6, r8 - r10}
 	b	21f
-20:	ldmfd	sp!, {r5 - r8}
+20:	ldmfd	sp!, {r5, r6, r8, r9}
 21:
 	.endm
 
 	.macro	copy_abort_end
-	ldmfd	sp!, {r4, pc}
+	ldmfd	sp!, {r4, UNWIND(fpreg,) pc}
 	.endm
 
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index 842ea5ede485..fac49e57cc0b 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -90,18 +90,15 @@
 	strusr	\reg, \ptr, 1, \cond, abort=\abort
 	.endm
 
-	.macro enter reg1 reg2
+	.macro enter regs:vararg
 	mov	r3, #0
-	stmdb	sp!, {r0, r2, r3, \reg1, \reg2}
+UNWIND( .save	{r0, r2, r3, \regs}		)
+	stmdb	sp!, {r0, r2, r3, \regs}
 	.endm
 
-	.macro usave reg1 reg2
-	UNWIND(	.save {r0, r2, r3, \reg1, \reg2}	)
-	.endm
-
-	.macro exit reg1 reg2
+	.macro exit regs:vararg
 	add	sp, sp, #8
-	ldmfd	sp!, {r0, \reg1, \reg2}
+	ldmfd	sp!, {r0, \regs}
 	.endm
 
 	.text
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index e4caf48c089f..90f2b645aa0d 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -42,16 +42,13 @@
 	strb\cond \reg, [\ptr], #1
 	.endm
 
-	.macro enter reg1 reg2
-	stmdb sp!, {r0, \reg1, \reg2}
+	.macro enter regs:vararg
+UNWIND( .save	{r0, \regs}		)
+	stmdb sp!, {r0, \regs}
 	.endm
 
-	.macro usave reg1 reg2
-	UNWIND(	.save	{r0, \reg1, \reg2}	)
-	.endm
-
-	.macro exit reg1 reg2
-	ldmfd sp!, {r0, \reg1, \reg2}
+	.macro exit regs:vararg
+	ldmfd sp!, {r0, \regs}
 	.endm
 
 	.text
-- 
2.30.2

