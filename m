Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D64CC43217
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244237AbiAXRtZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244427AbiAXRtX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC9C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:49:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C456B811AC
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441EBC36AE2;
        Mon, 24 Jan 2022 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046560;
        bh=S9VAgvS7Dq3pQmUaE1sjfY4F28GrRzw4QsaVdM6p2cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smbyr4J+IEJmplCjnf5mh8XUWXi3I+59MepPE4oLOdy2pkLKTQgrLJQzj4xXTLHK4
         ScBKty3+LceT/7B023UuEnsrMJ1f55/gDXKabQjKHvGEbkfYAyUkieUXDIPhTQsDw+
         I+zzmezPaa/biK9pQWoQ/7ONfFVlNNWQYOi+qnwbKSf/Jkd3a7vCnslj432iBjO3sN
         9agB5qoGZN8nPwngk8zZW5p0hvNqh+5nfen2z1Tg6dnYMzmGunkMDafzI50Y9LS4Sx
         6ZM46ruvSat1Tb8lea/rOs0OZlusCO3ede3ByI9ABBMZzlhzWx8WuSTuQtjq6Pm8AC
         /slrOeLAo4YyA==
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
Subject: [PATCH v5 26/32] ARM: memmove: use frame pointer as unwind anchor
Date:   Mon, 24 Jan 2022 18:47:38 +0100
Message-Id: <20220124174744.1054712-27-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6060; h=from:subject; bh=S9VAgvS7Dq3pQmUaE1sjfY4F28GrRzw4QsaVdM6p2cE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYz0OjoiDentb6t7pZtc080VYIAGPoHXehiwE+w IX4gUl6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mMwAKCRDDTyI5ktmPJBavDA CSrS7Cos4dYkj0uU4By5+ZpsWY+H6R4VS+UV6mUUUeLYfxdzcImuarmQTSV2aIagBKV7LhSEVDlH1p pYdEf6exNAtbDwUvt+0UxhzhXVbYkH9fOeG58RSDZev1cuk/pyGsL7bo54RXPb6X96NlYox/yOwg6N DcpZJAi/SsfamP1KZWT1VEVudzRxJ1dOz/cO6B+CfsINrTEpH11sSFqD/sTFb8ISP5j5JN2rIj+9j3 Q2HyEhexeQfuaCzZORwecK2fDOo3NyQmk3vWzUr9rXFB2UlbMjL5T7FPcS6cuDzqosEUbMLfuWQXT4 soCXjO8RAhc9f0/9nfpx2PaVarPXj8qBORobSsbsxdTh+sZ1ClZUwQEoAROcoYq4aPYtViZMSDJGhB 9xfiCvDpI0gp14QB6YcQpT564kNg6WSu4+49RwF/lWbhHzAIuN+XDRGHFwpmICMkJwjLidra/LORpw iotYP1PBsJET8JoErr+ZU7ksK5RrcNGlX3Clpqay8mYck=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The memmove routine is a bit unusual in the way it manages the stack
pointer: depending on the execution path through the function, the SP
assumes different values as different subsets of the register file are
preserved and restored again. This is problematic when it comes to EHABI
unwind info, as it is not instruction accurate, and does not allow
tracking the SP value as it changes.

Commit 207a6cb06990c ("ARM: 8224/1: Add unwinding support for memmove
function") addressed this by carving up the function in different chunks
as far as the unwinder is concerned, and keeping a set of unwind
directives for each of them, each corresponding with the state of the
stack pointer during execution of the chunk in question. This not only
duplicates unwind info unnecessarily, but it also complicates unwinding
the stack upon overflow.

Instead, let's do what the compiler does when the SP is updated halfway
through a function, which is to use a frame pointer and emit the
appropriate unwind directives to communicate this to the unwinder.

Note that Thumb-2 uses R7 for this, while ARM uses R11 aka FP. So let's
avoid touching R7 in the body of the function, so that Thumb-2 can use
it as the frame pointer. R11 was not modified in the first place.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/lib/memmove.S | 60 +++++++-------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
index 6fecc12a1f51..6410554039fd 100644
--- a/arch/arm/lib/memmove.S
+++ b/arch/arm/lib/memmove.S
@@ -31,12 +31,13 @@ WEAK(memmove)
 		subs	ip, r0, r1
 		cmphi	r2, ip
 		bls	__memcpy
-
-		stmfd	sp!, {r0, r4, lr}
 	UNWIND(	.fnend				)
 
 	UNWIND(	.fnstart			)
-	UNWIND(	.save	{r0, r4, lr}		) @ in first stmfd block
+	UNWIND(	.save	{r0, r4, fpreg, lr}	)
+		stmfd	sp!, {r0, r4, UNWIND(fpreg,) lr}
+	UNWIND(	.setfp	fpreg, sp		)
+	UNWIND(	mov	fpreg, sp		)
 		add	r1, r1, r2
 		add	r0, r0, r2
 		subs	r2, r2, #4
@@ -48,12 +49,7 @@ WEAK(memmove)
 		bne	10f
 
 1:		subs	r2, r2, #(28)
-		stmfd	sp!, {r5 - r8}
-	UNWIND(	.fnend				)
-
-	UNWIND(	.fnstart			)
-	UNWIND(	.save	{r0, r4, lr}		)
-	UNWIND(	.save	{r5 - r8}		) @ in second stmfd block
+		stmfd	sp!, {r5, r6, r8, r9}
 		blt	5f
 
 	CALGN(	ands	ip, r0, #31		)
@@ -72,9 +68,9 @@ WEAK(memmove)
 	PLD(	pld	[r1, #-96]		)
 
 3:	PLD(	pld	[r1, #-128]		)
-4:		ldmdb	r1!, {r3, r4, r5, r6, r7, r8, ip, lr}
+4:		ldmdb	r1!, {r3, r4, r5, r6, r8, r9, ip, lr}
 		subs	r2, r2, #32
-		stmdb	r0!, {r3, r4, r5, r6, r7, r8, ip, lr}
+		stmdb	r0!, {r3, r4, r5, r6, r8, r9, ip, lr}
 		bge	3b
 	PLD(	cmn	r2, #96			)
 	PLD(	bge	4b			)
@@ -88,8 +84,8 @@ WEAK(memmove)
 		W(ldr)	r4, [r1, #-4]!
 		W(ldr)	r5, [r1, #-4]!
 		W(ldr)	r6, [r1, #-4]!
-		W(ldr)	r7, [r1, #-4]!
 		W(ldr)	r8, [r1, #-4]!
+		W(ldr)	r9, [r1, #-4]!
 		W(ldr)	lr, [r1, #-4]!
 
 		add	pc, pc, ip
@@ -99,17 +95,13 @@ WEAK(memmove)
 		W(str)	r4, [r0, #-4]!
 		W(str)	r5, [r0, #-4]!
 		W(str)	r6, [r0, #-4]!
-		W(str)	r7, [r0, #-4]!
 		W(str)	r8, [r0, #-4]!
+		W(str)	r9, [r0, #-4]!
 		W(str)	lr, [r0, #-4]!
 
 	CALGN(	bcs	2b			)
 
-7:		ldmfd	sp!, {r5 - r8}
-	UNWIND(	.fnend				) @ end of second stmfd block
-
-	UNWIND(	.fnstart			)
-	UNWIND(	.save	{r0, r4, lr}		) @ still in first stmfd block
+7:		ldmfd	sp!, {r5, r6, r8, r9}
 
 8:		movs	r2, r2, lsl #31
 		ldrbne	r3, [r1, #-1]!
@@ -118,7 +110,7 @@ WEAK(memmove)
 		strbne	r3, [r0, #-1]!
 		strbcs	r4, [r0, #-1]!
 		strbcs	ip, [r0, #-1]
-		ldmfd	sp!, {r0, r4, pc}
+		ldmfd	sp!, {r0, r4, UNWIND(fpreg,) pc}
 
 9:		cmp	ip, #2
 		ldrbgt	r3, [r1, #-1]!
@@ -137,13 +129,10 @@ WEAK(memmove)
 		ldr	r3, [r1, #0]
 		beq	17f
 		blt	18f
-	UNWIND(	.fnend				)
 
 
 		.macro	backward_copy_shift push pull
 
-	UNWIND(	.fnstart			)
-	UNWIND(	.save	{r0, r4, lr}		) @ still in first stmfd block
 		subs	r2, r2, #28
 		blt	14f
 
@@ -152,12 +141,7 @@ WEAK(memmove)
 	CALGN(	subcc	r2, r2, ip		)
 	CALGN(	bcc	15f			)
 
-11:		stmfd	sp!, {r5 - r9}
-	UNWIND(	.fnend				)
-
-	UNWIND(	.fnstart			)
-	UNWIND(	.save	{r0, r4, lr}		)
-	UNWIND(	.save	{r5 - r9}		) @ in new second stmfd block
+11:		stmfd	sp!, {r5, r6, r8 - r10}
 
 	PLD(	pld	[r1, #-4]		)
 	PLD(	subs	r2, r2, #96		)
@@ -167,35 +151,31 @@ WEAK(memmove)
 	PLD(	pld	[r1, #-96]		)
 
 12:	PLD(	pld	[r1, #-128]		)
-13:		ldmdb   r1!, {r7, r8, r9, ip}
+13:		ldmdb   r1!, {r8, r9, r10, ip}
 		mov     lr, r3, lspush #\push
 		subs    r2, r2, #32
 		ldmdb   r1!, {r3, r4, r5, r6}
 		orr     lr, lr, ip, lspull #\pull
 		mov     ip, ip, lspush #\push
-		orr     ip, ip, r9, lspull #\pull
+		orr     ip, ip, r10, lspull #\pull
+		mov     r10, r10, lspush #\push
+		orr     r10, r10, r9, lspull #\pull
 		mov     r9, r9, lspush #\push
 		orr     r9, r9, r8, lspull #\pull
 		mov     r8, r8, lspush #\push
-		orr     r8, r8, r7, lspull #\pull
-		mov     r7, r7, lspush #\push
-		orr     r7, r7, r6, lspull #\pull
+		orr     r8, r8, r6, lspull #\pull
 		mov     r6, r6, lspush #\push
 		orr     r6, r6, r5, lspull #\pull
 		mov     r5, r5, lspush #\push
 		orr     r5, r5, r4, lspull #\pull
 		mov     r4, r4, lspush #\push
 		orr     r4, r4, r3, lspull #\pull
-		stmdb   r0!, {r4 - r9, ip, lr}
+		stmdb   r0!, {r4 - r6, r8 - r10, ip, lr}
 		bge	12b
 	PLD(	cmn	r2, #96			)
 	PLD(	bge	13b			)
 
-		ldmfd	sp!, {r5 - r9}
-	UNWIND(	.fnend				) @ end of the second stmfd block
-
-	UNWIND(	.fnstart			)
-	UNWIND(	.save {r0, r4, lr}		) @ still in first stmfd block
+		ldmfd	sp!, {r5, r6, r8 - r10}
 
 14:		ands	ip, r2, #28
 		beq	16f
@@ -211,7 +191,6 @@ WEAK(memmove)
 
 16:		add	r1, r1, #(\pull / 8)
 		b	8b
-	UNWIND(	.fnend				)
 
 		.endm
 
@@ -222,5 +201,6 @@ WEAK(memmove)
 
 18:		backward_copy_shift	push=24	pull=8
 
+	UNWIND(	.fnend				)
 ENDPROC(memmove)
 ENDPROC(__memmove)
-- 
2.30.2

