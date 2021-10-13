Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337C5C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7C161056
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhJMPZJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhJMPZJ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:25:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B970610E6;
        Wed, 13 Oct 2021 15:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138585;
        bh=r4Go4dh0trlbsGP6xRgj/tkJetmXK5uRKN3kIUWn2dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTjBqGENI9J1hRQHCMIOMOmJYdsT+WRhTQOr/eezV4u8ulOYIOQfQNdc54zZnp7vt
         RGCu0UFxGtG2EH/rF4WXKz7vsdhMtV0rDv+v2FfgkQdwg8cR5oCIuPIN4S1p85FoOd
         78pQfL86SbSSvaIgqkxhAefzCdUDHQHy0kFopAm/A1UQ/aAjgIsfrs0wZHflZFnL3k
         xx6M+GFBJkNx8y91/7A//Fy/bGwXd/Rsjdcqtu3/VBGu4Hmlli9w2rZrr7wOgJtT8Y
         BnlcsQTPEV2srn7EcQYr+bKE/q5zm3AsCqEJIyCtB4cJBjWRXSnldgQhnTMTczslyO
         Wp2iJut6UjJnA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 6/9] arm64: smccc: create proper stack frames for HVC/SMC calls
Date:   Wed, 13 Oct 2021 17:22:40 +0200
Message-Id: <20211013152243.2216899-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
References: <20211013152243.2216899-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; h=from:subject; bh=r4Go4dh0trlbsGP6xRgj/tkJetmXK5uRKN3kIUWn2dg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvm82mjLvzjabrwdMggjKzvG7y6a6J+P9fQHWdJX BcIaSamJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5vAAKCRDDTyI5ktmPJMHKDA CT90uHSWGg0U2c5ChDWZ2XV9zpvTw0+gxY0K1gFpCV2fBA83/GD0eHOPhvqIvjWqhjNV0HtIDAc1OS b7OLhQBxkbC7W1gGX3xdGP81E0P6wppREmBWJHMYRvJotMYF3RO9C0MRfQP0LXCY0kXRz9rF/GBPK/ Bx0TnoKmKY95K3390uXkrbVN+y2KkT3NP1+2lS5MEOgOicav8Qd/WW3tjosDk8JTSRqFBVpRf7vlVu IB5ebHxQIl5pCn5Fm22ZI5Y3Zd59MCyr2nXSjeA51w0HcJ5MUiVcTUkzyixnsLzGH5Hxul356bhi77 miEOJ4FsfQrGvw5WPBrzTSbil7UWgN1X7FCRqZjoZcjTDj9tKyZTfj2QVQs+9zAdkeWtEe6GgRAKyU QAM2PkqII8riMZzS+8P6jeYlXu4R6/FdZagRYpFcuswtXihjrTdo56Y7L17QIx/DYb44aaBWVQKjoM EnGL9udMtc/JyYgZwpGL45FdCpc7SUymfVEiorMiNSMhI=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Create proper stack frames using the provided macros for HVC/SMC calling
helpers that use the stack. This adds the PAC return address signing
when enabled, and ensures that the unwinder can deal with occurrences
of these routines appearing on the call stack.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/smccc-call.S | 40 +++++++++-----------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 487381164ff6..b1864880159a 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -32,8 +32,7 @@ SYM_FUNC_END(__arm_smccc_sve_check)
 EXPORT_SYMBOL(__arm_smccc_sve_check)
 
 	.macro SMCCC instr
-	stp     x29, x30, [sp, #-16]!
-	mov	x29, sp
+	frame_push 0
 alternative_if ARM64_SVE
 	bl	__arm_smccc_sve_check
 alternative_else_nop_endif
@@ -47,7 +46,7 @@ alternative_else_nop_endif
 	cmp	x9, #ARM_SMCCC_QUIRK_QCOM_A6
 	b.ne	1f
 	str	x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
-1:	ldp     x29, x30, [sp], #16
+1:	frame_pop
 	ret
 	.endm
 
@@ -74,11 +73,10 @@ SYM_FUNC_END(__arm_smccc_hvc)
 EXPORT_SYMBOL(__arm_smccc_hvc)
 
 	.macro SMCCC_1_2 instr
-	/* Save `res` and free a GPR that won't be clobbered */
-	stp     x1, x19, [sp, #-16]!
+	frame_push 2
 
-	/* Ensure `args` won't be clobbered while loading regs in next step */
-	mov	x19, x0
+	mov	x19, x0		// preserve args
+	mov	x20, x1		// preserve res
 
 	/* Load the registers x0 - x17 from the struct arm_smccc_1_2_regs */
 	ldp	x0, x1, [x19, #ARM_SMCCC_1_2_REGS_X0_OFFS]
@@ -93,24 +91,20 @@ EXPORT_SYMBOL(__arm_smccc_hvc)
 
 	\instr #0
 
-	/* Load the `res` from the stack */
-	ldr	x19, [sp]
-
 	/* Store the registers x0 - x17 into the result structure */
-	stp	x0, x1, [x19, #ARM_SMCCC_1_2_REGS_X0_OFFS]
-	stp	x2, x3, [x19, #ARM_SMCCC_1_2_REGS_X2_OFFS]
-	stp	x4, x5, [x19, #ARM_SMCCC_1_2_REGS_X4_OFFS]
-	stp	x6, x7, [x19, #ARM_SMCCC_1_2_REGS_X6_OFFS]
-	stp	x8, x9, [x19, #ARM_SMCCC_1_2_REGS_X8_OFFS]
-	stp	x10, x11, [x19, #ARM_SMCCC_1_2_REGS_X10_OFFS]
-	stp	x12, x13, [x19, #ARM_SMCCC_1_2_REGS_X12_OFFS]
-	stp	x14, x15, [x19, #ARM_SMCCC_1_2_REGS_X14_OFFS]
-	stp	x16, x17, [x19, #ARM_SMCCC_1_2_REGS_X16_OFFS]
-
-	/* Restore original x19 */
-	ldp     xzr, x19, [sp], #16
+	stp	x0, x1, [x20, #ARM_SMCCC_1_2_REGS_X0_OFFS]
+	stp	x2, x3, [x20, #ARM_SMCCC_1_2_REGS_X2_OFFS]
+	stp	x4, x5, [x20, #ARM_SMCCC_1_2_REGS_X4_OFFS]
+	stp	x6, x7, [x20, #ARM_SMCCC_1_2_REGS_X6_OFFS]
+	stp	x8, x9, [x20, #ARM_SMCCC_1_2_REGS_X8_OFFS]
+	stp	x10, x11, [x20, #ARM_SMCCC_1_2_REGS_X10_OFFS]
+	stp	x12, x13, [x20, #ARM_SMCCC_1_2_REGS_X12_OFFS]
+	stp	x14, x15, [x20, #ARM_SMCCC_1_2_REGS_X14_OFFS]
+	stp	x16, x17, [x20, #ARM_SMCCC_1_2_REGS_X16_OFFS]
+
+	frame_pop
 	ret
-.endm
+	.endm
 
 /*
  * void arm_smccc_1_2_hvc(const struct arm_smccc_1_2_regs *args,
-- 
2.30.2

