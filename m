Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BA6C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiAXRs3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43452 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbiAXRs2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E297C612FC
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E611C340EA;
        Mon, 24 Jan 2022 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046507;
        bh=gslX7T5TrnrvLT9MZy1Flj2WrIS21TNN7skRYLf2cB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+a5guIYJlWG0aQFL6ayUD51PzanAJgDDgnDfW4LDhKjBHpJPfBnyNTp7CodzotYt
         j+43QO7ApP7aTNE0aGiO+yNDOjriTcSTJRFCIUtpCmhlk/TtQntCrhyjbqjAg59Cug
         7J8VI7jGjsu+XOPtimzzNle0oJKjKJh54l0ScMqVCAPi6+35CL5ZTLUDzFpPMB7gA9
         DGn/DBSfpm7LizBGy13UMCG3xBraowXXOdPZ4UtgnTt9WaO5Jhmn49a/3zhVcqymwO
         Au1LJImb7idCjPN8j2OomvVvJOJkll6BvUsbe3eR4BqKRWxiy4G62Rn3HtDTovwHmo
         l/1fyL2wNBLgA==
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
Subject: [PATCH v5 10/32] ARM: entry: preserve thread_info pointer in switch_to
Date:   Mon, 24 Jan 2022 18:47:22 +0100
Message-Id: <20220124174744.1054712-11-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; h=from:subject; bh=gslX7T5TrnrvLT9MZy1Flj2WrIS21TNN7skRYLf2cB4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYViXFUcknkrsWItgSrA5jHKmMET02bvqQS6Nlf hymjRTOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mFQAKCRDDTyI5ktmPJDsfC/ 9zjEN2ZvHm9mEpB4TxzHpRwKwUGhOBMrdIKOLOP02+8pK9cgRhfsTFQ1xdecWiVUocIxcYbX8Va8ab bHudQRdStxiniZH5BCgDRQQSjvbpBkXYM6AMqMydSFebuOfjgGRYfPctGRv1J/w96+Fort9W3hL1vD AgiC2oTKLzFRru112J2nmm6gLsy6+qcPnCsy6VmfJI2gRXp6YZbduuw+V1K96HOK9B1xLmmeAfljR6 ZR79XLrUQm/VVkPf3AOsz9bzXpeVy7g6Tgl3dnK8HyrhcAHxBf8MCRV6KTEeKfBEaSGAP/U+N5cyc+ 4cLRgVCp9xNlqlriYw6jBoox09IWj043Kak4TimBXeoPtTPceF8uaJFXDkalB+nbstVZ1QxNFdt9jJ AjaN7h6ubhXSZShzzmqzMTKl0Kw6AE0Cx/Q9qunERV8XgBRbwsieOsbVCbFyr3Gf7Q9LnM5k/dCIt9 ptLw7MJhF148+gi9L3l0iten9uINUfYSu8MJnnIG6eOXw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Tweak the UP stack protector handling code so that the thread info
pointer is preserved in R7 until set_current is called. This is needed
for a subsequent patch that implements THREAD_INFO_IN_TASK and
set_current for UP as well.

This also means we will prefer the per-task protector on UP systems that
implement the thread ID registers, so tweak the preprocessor
conditionals to reflect this.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/kernel/entry-armv.S | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 9d9372781408..5e01a34369a0 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -744,16 +744,16 @@ ENTRY(__switch_to)
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
 #endif
 	switch_tls r1, r4, r5, r3, r7
-#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	ldr	r7, [r2, #TI_TASK]
+#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP) && \
+    !defined(CONFIG_STACKPROTECTOR_PER_TASK)
+	ldr	r9, [r2, #TI_TASK]
 	ldr	r8, =__stack_chk_guard
 	.if (TSK_STACK_CANARY > IMM12_MASK)
-	add	r7, r7, #TSK_STACK_CANARY & ~IMM12_MASK
+	add	r9, r9, #TSK_STACK_CANARY & ~IMM12_MASK
 	.endif
-	ldr	r7, [r7, #TSK_STACK_CANARY & IMM12_MASK]
-#elif defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO)
-	mov	r7, r2				@ Preserve 'next'
+	ldr	r9, [r9, #TSK_STACK_CANARY & IMM12_MASK]
 #endif
+	mov	r7, r2				@ Preserve 'next'
 #ifdef CONFIG_CPU_USE_DOMAINS
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
 #endif
@@ -762,8 +762,9 @@ ENTRY(__switch_to)
 	ldr	r0, =thread_notify_head
 	mov	r1, #THREAD_NOTIFY_SWITCH
 	bl	atomic_notifier_call_chain
-#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	str	r7, [r8]
+#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP) && \
+    !defined(CONFIG_STACKPROTECTOR_PER_TASK)
+	str	r9, [r8]
 #endif
  THUMB(	mov	ip, r4			   )
 	mov	r0, r5
-- 
2.30.2

