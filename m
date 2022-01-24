Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE257C4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbiAXRtb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbiAXRtb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEA8C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:49:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A97460FDB
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2930CC340E8;
        Mon, 24 Jan 2022 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046570;
        bh=E6GmgEOc+vQafTW9XEhCWB4pMdBWsplIssEM1Ai0U3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H89+2sb18ngW36M/WDIkM/ybOiSCbRo7tNjmk9jLk/UXVn4MDvhJE+u9OzpMpTXuH
         5xY3T6/lv/PXVbHI9L2mOOv6IOrt1UIPYOZzzm3nO8Ak56Ll3Ybm7anKizNwDjXxvG
         Fpive1QuOZLdF+EKOK56ztIO0z/B0mdkgWpluHHmvWOM/Y2s8Vdag/MppOEqlHjXXy
         /3H+yXhe/s6GZj8jGBNcuaex2RwggFy2764z6S/Ck6lI6ZkMQZD9ma+hdLvaO1UPq9
         kOToJLQzsXoTvaJWgkuUKITTTgS/6hiZXaiIYYxbjdwp4Ewe8UdcY92UwvgdwTt8dm
         ZJiPYpK7ivIQw==
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
Subject: [PATCH v5 29/32] ARM: entry: rework stack realignment code in svc_entry
Date:   Mon, 24 Jan 2022 18:47:41 +0100
Message-Id: <20220124174744.1054712-30-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3424; h=from:subject; bh=E6GmgEOc+vQafTW9XEhCWB4pMdBWsplIssEM1Ai0U3c=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uY5RDYWgucV+8Glqrn8Wi0LCwplEl4eTtkjLHN4 JrB3C2eJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mOQAKCRDDTyI5ktmPJOQhC/ wK6kHr+LrcKAbaF+Su+9znZGr/TaIYvbUT1J1MHKLUOTKj9NpRaLAdRFga1Wj4Afxf4Jdkci0VgGaI PCtAUITVecptOShKWXtzRwO7ghWF/DOO4rzOa+XCwpVWJuqEvsR1ljYXEyl9tSK2fbrOe0vbB19N1m ZG4M9JmYC4/m05BP9pksQS5B0VCV1x5wgv1aacaeEZKyY4BYJA/W/d28D/rtg0I2vWR40uihRHFR+f P4Gd0g1+zPECoANL+PlYuYvS7QA4gYHNB36E+Z1g79FHAfHaicFYGveIeziE1OSK2nKI9g724SLSj9 skdFmP8RKmpr94E8hAmKptK4AF/HcPMb1Rj2UAXM23y7IT7odTERSmr/aYdS2s6tuD1x7OC3j1fknj 14qDQnmooW7nBDuLjGtJi74qcztLapMTOIQncTZ9RbzydvnlIQT03I9UihZg5QZNFGzCoHlnWquyqA C3dtjgxzmRPwacc5jmwMfOVZAD9BN8dodbxTh3o6X1hHE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The original Thumb-2 enablement patches updated the stack realignment
code in svc_entry to work around the lack of a STMIB instruction in
Thumb-2, by subtracting 4 from the frame size, inverting the sense of
the misaligment check, and changing to a STMIA instruction and a final
stack push of a 4 byte quantity that results in the stack becoming
aligned at the end of the sequence. It also pushes and pops R0 to the
stack in order to have a temp register that Thumb-2 allows in general
purpose ALU instructions, as TST using SP is not permitted.

Both are a bit problematic for vmap'ed stacks, as using the stack is
only permitted after we decide that we did not overflow the stack, or
have already switched to the overflow stack.

As for the alignment check: the current approach creates a corner case
where, if the initial SUB of SP ends up right at the start of the stack,
we will end up subtracting another 8 bytes and overflowing it.  This
means we would need to add the overflow check *after* the SUB that
deliberately misaligns the stack. However, this would require us to keep
local state (i.e., whether we performed the subtract or not) across the
overflow check, but without any GPRs or stack available.

So let's switch to an approach where we don't use the stack, and where
the alignment check of the stack pointer occurs in the usual way, as
this is guaranteed not to result in overflow. This means we will be able
to do the overflow check first.

While at it, switch to R1 so the mode stack pointer in R0 remains
accessible.

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/kernel/entry-armv.S | 25 +++++++++++---------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 38e3978a50a9..a4009e4302bb 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -177,24 +177,27 @@ ENDPROC(__und_invalid)
 	.macro	svc_entry, stack_hole=0, trace=1, uaccess=1
  UNWIND(.fnstart		)
  UNWIND(.save {r0 - pc}		)
-	sub	sp, sp, #(SVC_REGS_SIZE + \stack_hole - 4)
+	sub	sp, sp, #(SVC_REGS_SIZE + \stack_hole)
 #ifdef CONFIG_THUMB2_KERNEL
- SPFIX(	str	r0, [sp]	)	@ temporarily saved
- SPFIX(	mov	r0, sp		)
- SPFIX(	tst	r0, #4		)	@ test original stack alignment
- SPFIX(	ldr	r0, [sp]	)	@ restored
+	add	sp, r1			@ get SP in a GPR without
+	sub	r1, sp, r1		@ using a temp register
+	tst	r1, #4			@ test stack pointer alignment
+	sub	r1, sp, r1		@ restore original R1
+	sub	sp, r1			@ restore original SP
 #else
  SPFIX(	tst	sp, #4		)
 #endif
- SPFIX(	subeq	sp, sp, #4	)
-	stmia	sp, {r1 - r12}
+ SPFIX(	subne	sp, sp, #4	)
+
+ ARM(	stmib	sp, {r1 - r12}	)
+ THUMB(	stmia	sp, {r0 - r12}	)	@ No STMIB in Thumb-2
 
 	ldmia	r0, {r3 - r5}
-	add	r7, sp, #S_SP - 4	@ here for interlock avoidance
+	add	r7, sp, #S_SP		@ here for interlock avoidance
 	mov	r6, #-1			@  ""  ""      ""       ""
-	add	r2, sp, #(SVC_REGS_SIZE + \stack_hole - 4)
- SPFIX(	addeq	r2, r2, #4	)
-	str	r3, [sp, #-4]!		@ save the "real" r0 copied
+	add	r2, sp, #(SVC_REGS_SIZE + \stack_hole)
+ SPFIX(	addne	r2, r2, #4	)
+	str	r3, [sp]		@ save the "real" r0 copied
 					@ from the exception stack
 
 	mov	r3, lr
-- 
2.30.2

