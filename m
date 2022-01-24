Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA36AC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbiAXRs5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43754 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbiAXRsy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 487826124A
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AE0C340E8;
        Mon, 24 Jan 2022 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046533;
        bh=xDLguYLJMr2DMzYb/HljYnvnaduK5/+FMV5hI3zvvO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEesfrm9t1oaNFyPjbugxMiSefi95H0VMmzkQE4NIZxzGDrc/XJE8a4fM1XFs8wiv
         VCzxoTt3ck67c3tV+LJqylAosrekCM7I3pnV8SiU1JD8l408FDz5hM4W3hLLwrBvZ7
         AQ9S70fbdTRmgVBOfnidpU8rECJQ9aa7lrei4HlrwcTulPz4NocZrYc2m77cSSX6tZ
         RWGknX3MTZ9O8BRSWqZkfzhDlDvZpUEgIb8IHu0RPO/HdBkorsObK6466VpHG2Y5QS
         ji7a0/XRi0t91jkVmILLKR49aiDAxny1+mnprjWgPD2AtPImmOhGH4zYJGgca6A89p
         YiJrQMYd2DRQA==
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
Subject: [PATCH v5 18/32] ARM: unwind: support unwinding across multiple stacks
Date:   Mon, 24 Jan 2022 18:47:30 +0100
Message-Id: <20220124174744.1054712-19-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3602; h=from:subject; bh=xDLguYLJMr2DMzYb/HljYnvnaduK5/+FMV5hI3zvvO0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYkvKQTioAHibgOPfZJnK3coc3CsBMfh5Q5wlMj 9fesCNOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mJAAKCRDDTyI5ktmPJGecDA CiHdK2+5VQLqKaXTF6s65bpf/U41Ndw1DIlAFgSvKP30gupmn65RgobD/IVoN8TQ5NquTR13+0chgz G0z3IJF2l8C2WJSihNTychXX5gGji4nepbBqz028Urwz24aT8ziXX69AV6Tf6v6qZ6gMnY8/HNgexM BdJqfScR1p7rc9FMUWUSKgoEKFWMvrh1TgxDvbLHecZcd7hVfkPflsM38GdM3LCnNgvntqYGyoFY/A KlgnBc59fd+7bHOUSHs/Dq5NrJLF5idxrKV/8XwGm/+5iqSp9WnGTehmqGxL1o66Mim6FA8hqs9AML msqb6j3wFHeewsVBOmZQnVGe0u6ZyPeoS223t/4SAo6bRexWCLNq/wvdyFHbN2XVkUsA2utNIZa7Ya /KVIeQY5aWVt3IEfPvHirwH8/OoVgG0Khh1VsbJwjzWgH3dgUJ6mKWxC56XnNMy5pBi9VOY5aavZw/ X33Uviap4roATB/IJtJGAriXyRew0ThpnpuSvjlifmx/U=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Implement support in the unwinder for dealing with multiple stacks.
This will be needed once we add support for IRQ stacks, or for the
overflow stack used by the vmap'ed stacks code.

This involves tracking the unwind opcodes that either update the virtual
stack pointer from another virtual register, or perform an explicit
subtract on the virtual stack pointer, and updating the low and high
bounds that we use to sanitize the stack pointer accordingly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/kernel/unwind.c | 25 +++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 59fdf257bf8b..9cb9af3fc433 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -52,6 +52,7 @@ EXPORT_SYMBOL(__aeabi_unwind_cpp_pr2);
 struct unwind_ctrl_block {
 	unsigned long vrs[16];		/* virtual register set */
 	const unsigned long *insn;	/* pointer to the current instructions word */
+	unsigned long sp_low;		/* lowest value of sp allowed */
 	unsigned long sp_high;		/* highest value of sp allowed */
 	/*
 	 * 1 : check for stack overflow for each register pop.
@@ -256,8 +257,12 @@ static int unwind_exec_pop_subset_r4_to_r13(struct unwind_ctrl_block *ctrl,
 		mask >>= 1;
 		reg++;
 	}
-	if (!load_sp)
+	if (!load_sp) {
 		ctrl->vrs[SP] = (unsigned long)vsp;
+	} else {
+		ctrl->sp_low = ctrl->vrs[SP];
+		ctrl->sp_high = ALIGN(ctrl->sp_low, THREAD_SIZE);
+	}
 
 	return URC_OK;
 }
@@ -313,9 +318,10 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 
 	if ((insn & 0xc0) == 0x00)
 		ctrl->vrs[SP] += ((insn & 0x3f) << 2) + 4;
-	else if ((insn & 0xc0) == 0x40)
+	else if ((insn & 0xc0) == 0x40) {
 		ctrl->vrs[SP] -= ((insn & 0x3f) << 2) + 4;
-	else if ((insn & 0xf0) == 0x80) {
+		ctrl->sp_low = ctrl->vrs[SP];
+	} else if ((insn & 0xf0) == 0x80) {
 		unsigned long mask;
 
 		insn = (insn << 8) | unwind_get_byte(ctrl);
@@ -330,9 +336,11 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		if (ret)
 			goto error;
 	} else if ((insn & 0xf0) == 0x90 &&
-		   (insn & 0x0d) != 0x0d)
+		   (insn & 0x0d) != 0x0d) {
 		ctrl->vrs[SP] = ctrl->vrs[insn & 0x0f];
-	else if ((insn & 0xf0) == 0xa0) {
+		ctrl->sp_low = ctrl->vrs[SP];
+		ctrl->sp_high = ALIGN(ctrl->sp_low, THREAD_SIZE);
+	} else if ((insn & 0xf0) == 0xa0) {
 		ret = unwind_exec_pop_r4_to_rN(ctrl, insn);
 		if (ret)
 			goto error;
@@ -375,13 +383,12 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
  */
 int unwind_frame(struct stackframe *frame)
 {
-	unsigned long low;
 	const struct unwind_idx *idx;
 	struct unwind_ctrl_block ctrl;
 
 	/* store the highest address on the stack to avoid crossing it*/
-	low = frame->sp;
-	ctrl.sp_high = ALIGN(low, THREAD_SIZE);
+	ctrl.sp_low = frame->sp;
+	ctrl.sp_high = ALIGN(ctrl.sp_low, THREAD_SIZE);
 
 	pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
 		 frame->pc, frame->lr, frame->sp);
@@ -437,7 +444,7 @@ int unwind_frame(struct stackframe *frame)
 		urc = unwind_exec_insn(&ctrl);
 		if (urc < 0)
 			return urc;
-		if (ctrl.vrs[SP] < low || ctrl.vrs[SP] >= ctrl.sp_high)
+		if (ctrl.vrs[SP] < ctrl.sp_low || ctrl.vrs[SP] > ctrl.sp_high)
 			return -URC_FAILURE;
 	}
 
-- 
2.30.2

