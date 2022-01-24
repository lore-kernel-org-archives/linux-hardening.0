Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4469CC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiAXRta (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50686 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbiAXRt3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1F79B811A5
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34BCC340EB;
        Mon, 24 Jan 2022 17:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046566;
        bh=YcKS6pvqINnnIZZfrTl67Gen3pLE7mHp0eRfaLN7syA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egDXXfuQ4TSf3PRYrWimm7oQFFsEmHiFvGnh0zUOO3bNSKuNlLl5mk8cIt7wbg7S6
         Jw0fsqsf62hAwqkY2Zx6rRyzdtaVWHmiGoz2/dltnrNiLm/zTxnt3gC77TfWrWU+V9
         qqdfeU0z6RTvKAAGg2N2PS3RML9D2ptz6f9QJ4VDHwfDN5EFOGPnWmgl4Cqoyc25r+
         AALg2qzJtrYnkSAP0pFrGU4IYe+pUYMQE2L4cyASTTu/hsJPCQcCLHEVdvYlllomzK
         zmR3+2c0oY/dGjyK1MLqCkR1fPdYzZytCg39gISDMaph6VO+YZy28ceO70K0zUcO3/
         6COXNgm7scDlw==
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
Subject: [PATCH v5 28/32] ARM: unwind: disregard unwind info before stack frame is set up
Date:   Mon, 24 Jan 2022 18:47:40 +0100
Message-Id: <20220124174744.1054712-29-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2494; h=from:subject; bh=YcKS6pvqINnnIZZfrTl67Gen3pLE7mHp0eRfaLN7syA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uY32Q+0YokqsvCTLr4wm0frEVTWcQNZVqn499oj RXzHDGiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mNwAKCRDDTyI5ktmPJOwPC/ 0a8Z2SZ6d9c3q9gHjoQgamLOJLFOOg3VHcCNTUb4ljLW5VmPuVXrh7g0XwmKPA3U1TowrdEV9oKgVK Yvo3kuXtD5szQRaAiUgvUUPu8fCsud9j0iA9Qzfp0ktk2GrNIPyF3KYmvg3xvUdywNrdcrvXraI2xv XpXVxNrelI4dO21/BbYh+K7eBOtMGnEiVt/TlXx/d0Fld6fNMoH2LMUw8Ui9bvZxWH+GVu1UlB3kpK fkhXZMLAeGmmmgYjMVJk5oibsJ0vZAD05u2gfa8QMKCNcJ2O0/b9UmQRZ0f8Fsj+whMf0ZEEhn5apb g2r8rMWr+nsCIYvzjKKi+xD1ZubygHM3HVv/t7UvDZQNNN44n6W+cosfvOLPMc/v+1mRaWlzKgs2rI 3mKWAi5NK5Svv2+nJ3DBtU2bDmD0D2nHvRMeELTXTfJ+V1zq5VEAaNhMZsuMatsYua4NO99Qhx599k 4M4mEF8XG6XOXNgAci+1MG0VsNZQecIxV8WPaMXRlQiOs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When unwinding the stack from a stack overflow, we are likely to start
from a stack push instruction, given that this is the most common way to
grow the stack for compiler emitted code. This push instruction rarely
appears anywhere else than at offset 0x0 of the function, and if it
doesn't, the compiler tends to split up the unwind annotations, given
that the stack frame layout is apparently not the same throughout the
function.

This means that, in the general case, if the frame's PC points at the
first instruction covered by a certain unwind entry, there is no way the
stack frame that the unwind entry describes could have been created yet,
and so we are still on the stack frame of the caller in that case. So
treat this as a special case, and return with the new PC taken from the
frame's LR, without applying the unwind transformations to the virtual
register set.

This permits us to unwind the call stack on stack overflow when the
overflow was caused by a stack push on function entry.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/kernel/unwind.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index b7a6141c342f..e8d729975f12 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -411,7 +411,21 @@ int unwind_frame(struct stackframe *frame)
 	if (idx->insn == 1)
 		/* can't unwind */
 		return -URC_FAILURE;
-	else if ((idx->insn & 0x80000000) == 0)
+	else if (frame->pc == prel31_to_addr(&idx->addr_offset)) {
+		/*
+		 * Unwinding is tricky when we're halfway through the prologue,
+		 * since the stack frame that the unwinder expects may not be
+		 * fully set up yet. However, one thing we do know for sure is
+		 * that if we are unwinding from the very first instruction of
+		 * a function, we are still effectively in the stack frame of
+		 * the caller, and the unwind info has no relevance yet.
+		 */
+		if (frame->pc == frame->lr)
+			return -URC_FAILURE;
+		frame->sp_low = frame->sp;
+		frame->pc = frame->lr;
+		return URC_OK;
+	} else if ((idx->insn & 0x80000000) == 0)
 		/* prel31 to the unwind table */
 		ctrl.insn = (unsigned long *)prel31_to_addr(&idx->insn);
 	else if ((idx->insn & 0xff000000) == 0x80000000)
-- 
2.30.2

