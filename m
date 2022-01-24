Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44470C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbiAXRti (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244765AbiAXRtg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C550BC06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:49:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E49CB811B1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71116C340EA;
        Mon, 24 Jan 2022 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046573;
        bh=+pQufvmuN+DCXpLjIRbTCfkOyyA2xiTpUnjNr7Ivoi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNC2WlvY8UnzKemIy7LWXbEHs8Z7HSH0HKQYDmIDyrkbdVf11ZEKcsize7uRhtQGf
         peF32BcCsOtx4+iDZxppY88GES7DnAzO8TPywGvAyeDgptZtGEIgVR+Df05NDdx7EJ
         2XjYgbAzAItdawO6VCbeUm7YuLADEMoZaHcIcTDmh+KLCufz6t24C9vhf4/Y6zPTRU
         LElRSoBx6+mHo2BspZHPsdX3UxDXqxqwuETdRGDys1aVyceYVZ2A84WnQma44B0eqq
         QHfwZRlV8CxdZCoerSk+d2sO8JJx21b+usymv3dkIpDPdrsmNSqt7y33Bc1T7XBboO
         YqvisY3D3FeQA==
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
Subject: [PATCH v5 30/32] ARM: switch_to: clean up Thumb2 code path
Date:   Mon, 24 Jan 2022 18:47:42 +0100
Message-Id: <20220124174744.1054712-31-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; h=from:subject; bh=+pQufvmuN+DCXpLjIRbTCfkOyyA2xiTpUnjNr7Ivoi8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uY7MBmcoyuFXL9bDPe0NTsfpZSWvkHt5AlfuZ9d huKQsieJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mOwAKCRDDTyI5ktmPJLBBC/ 0QLzsXlHtFMVjLGgsO74jLKztyCpjEDt3dcnYOT4F3sBBvhatgBAFvsMdO7Za9qQ0FOYmIqdN6lJ1x 6rQsuSMvDIXerwAUfuWLqGmVio3a2LtTbZ5zTrYr7QCbvQ1xMZAn5wRV8qBqY9Gre7ZlKRmbjcYbkX PptLuPrd6gVBpeMIBHXd8TT9Em0oZPQqDsUUtDqSlEb3/5nF+vuSXbyKuLcZ0K4iuRmZNo3xX5L7rZ t5TfZmpuHNud8b8TyNMHs0jlfI+WoZI0zwHkfZaqOO5yESfSQWLyos6QvSJk3mSJ0RLKvN1IDDxar2 GIV2qLc4LhndrH6+xAovQBISv++pLDKQYM7si2NywvXS6Ox4ZQ6l832vuohTRo7pT700nzXqIwIQov CC9UwVc6itBnM+L5C93Oe07nsy2dgsFYWH5wcQNMqz3l4UzhmRu81//rOQIZKgu/3BTPrNPEsvo0Cv XUsxHMKItLjst5m8z+ZRXniC9Z6GZC+nQ3bVKeXedjALw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The load/store-multiple instructions that essentially perform the
switch_to operation in ARM mode, by loading/storing all callee save
registers as well the stack pointer and the link register or program
counter, is split into 3 separate loads or stores for Thumb-2, with the
IP register used as a temporary to capture the target address.

We can clean this up a bit, by sticking with a single STMIA or LDMIA
instruction, but one that uses IP instead of SP.

While at it, switch to a MOVW/MOVT pair to load thread_notify_head.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/entry-armv.S | 24 +++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index a4009e4302bb..86be80159c14 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -773,14 +773,14 @@ ENDPROC(__fiq_usr)
  * r0 = previous task_struct, r1 = previous thread_info, r2 = next thread_info
  * previous and next are guaranteed not to be the same.
  */
+	.align	5
 ENTRY(__switch_to)
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
-	add	ip, r1, #TI_CPU_SAVE
- ARM(	stmia	ip!, {r4 - sl, fp, sp, lr} )	@ Store most regs on stack
- THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
- THUMB(	str	sp, [ip], #4		   )
- THUMB(	str	lr, [ip], #4		   )
+	add	r3, r1, #TI_CPU_SAVE
+ ARM(	stmia	r3, {r4 - sl, fp, sp, lr}  )	@ Store most regs on stack
+ THUMB( mov	ip, sp			   )
+ THUMB( stmia	r3, {r4 - sl, fp, ip, lr}  )	@ Thumb2 does not permit SP here
 	ldr	r4, [r2, #TI_TP_VALUE]
 	ldr	r5, [r2, #TI_TP_VALUE + 4]
 #ifdef CONFIG_CPU_USE_DOMAINS
@@ -805,20 +805,22 @@ ENTRY(__switch_to)
 #endif
 	mov	r5, r0
 	add	r4, r2, #TI_CPU_SAVE
-	ldr	r0, =thread_notify_head
+	mov_l	r0, thread_notify_head
 	mov	r1, #THREAD_NOTIFY_SWITCH
 	bl	atomic_notifier_call_chain
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP) && \
     !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 	str	r9, [r8]
 #endif
- THUMB(	mov	ip, r4			   )
 	mov	r0, r5
 	set_current r7, r8
- ARM(	ldmia	r4, {r4 - sl, fp, sp, pc}  )	@ Load all regs saved previously
- THUMB(	ldmia	ip!, {r4 - sl, fp}	   )	@ Load all regs saved previously
- THUMB(	ldr	sp, [ip], #4		   )
- THUMB(	ldr	pc, [ip]		   )
+#if !defined(CONFIG_THUMB2_KERNEL)
+	ldmia	r4, {r4 - sl, fp, sp, pc}	@ Load all regs saved previously
+#else
+	ldmia	r4, {r4 - sl, fp, ip, lr}	@ Thumb2 does not permit SP here
+	mov	sp, ip
+	ret	lr
+#endif
  UNWIND(.fnend		)
 ENDPROC(__switch_to)
 
-- 
2.30.2

