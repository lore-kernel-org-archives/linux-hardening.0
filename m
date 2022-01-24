Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94525C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbiAXRr7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:47:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43106 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240939AbiAXRr6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:47:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 101E5612FC
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C31C340EA;
        Mon, 24 Jan 2022 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046477;
        bh=cSMz9HNmdlyrAxuErbtcZ6pp4jGvOvzYWBgsYjniQbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMxGADB1707YfQgGJjqUlu6R1UWcrkY+OOGUR1EwbpBYLicEQFXf+MDUvgMoDiO/I
         1pknyr6xldFIIR5rIumqZ8ZdL+dZu2rY5YUglY2xKTZxGZIuVu4qYKUP3PlLnkRD5o
         +2yF7GoNM6pMu8IrAvU25avLT9g6vuXx1TH9NoWT6W2Lp+M3u8Lb6SZDUimHEzVgWy
         4q3oRMH0LDl1CBGmgxxDX+19uWVTI3+3qkHnzX0tPwNxxIc3XeZm3zMAY3vmF3Sv6l
         XmrxttnSlQXMzTwGeDTzrGk6R4C9FVH6BoAiAPOszS1yusGqmgPGqleJaZyn2M8tld
         25faApeNEdwrA==
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
Subject: [PATCH v5 01/32] ARM: riscpc: drop support for IOMD_IRQREQC/IOMD_IRQREQD IRQ groups
Date:   Mon, 24 Jan 2022 18:47:13 +0100
Message-Id: <20220124174744.1054712-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3374; h=from:subject; bh=cSMz9HNmdlyrAxuErbtcZ6pp4jGvOvzYWBgsYjniQbI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYDLVhTYXHtrpVrhKsZAsJHAndmZ+M7D40XqAom tZcFECGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mAwAKCRDDTyI5ktmPJFm5C/ 9wiSO+NXhWoc3038aysNFA4nx7pu0yzS2CvDWnVklXa/VpnidEtzxnvCzlmMk90byOlh4ztbvVvPyw 5lQ/dwHSs5+Hc5EENB7bkx/DxQrUIRcqvPeqsRXfd8zgiO8reL+TUNxFLTTnLmW2ZWML91povM8SbB Q5z3u8P3LTJwYu4GCZqURPsovRKo6GibIMcze/w/3CH83lKuELC9U01g8HYl+NQnPUW7rxQhj29rLI mU+8MJvnAV21OGHKLw02QU+q1NPJME4T1nTRhrbb81OroKYL8DeHZPQEcnDDvAwmeLv1BJ302/1H1t 33M+WyKGDxoVPod8yzIqwHN0mQVl+EXxDchG4E0be5sPWHueCJUsB2JhMmCMpOybcehPzzk0eMNC1g iUkpCaoGp/UWHTu5+POnFHSJ9i8ND3cOpHifMD0NAaWxFdy2lYfaARiUU6pS/4+EqWczQvVT4OQIyy QHvWJ4eCxepLkdDJK4kOfiD+KXRRohRNfNKGmOng8SmuE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

IOMD_IRQREQC nor IOMD_IRQREQD are ever defined, so any conditionally
compiled code that depends on them is dead code, and can be removed.

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/hardware/entry-macro-iomd.S | 47 --------------------
 1 file changed, 47 deletions(-)

diff --git a/arch/arm/include/asm/hardware/entry-macro-iomd.S b/arch/arm/include/asm/hardware/entry-macro-iomd.S
index f7692731e514..81441dfa5282 100644
--- a/arch/arm/include/asm/hardware/entry-macro-iomd.S
+++ b/arch/arm/include/asm/hardware/entry-macro-iomd.S
@@ -24,16 +24,6 @@
 		ldrbeq	\irqstat, [\base, #IOMD_IRQREQA]	@ get low priority
 		addeq	\tmp, \tmp, #256		@ irq_prio_d table size
 		teqeq	\irqstat, #0
-#ifdef IOMD_IRQREQC
-		ldrbeq	\irqstat, [\base, #IOMD_IRQREQC]
-		addeq	\tmp, \tmp, #256		@ irq_prio_l table size
-		teqeq	\irqstat, #0
-#endif
-#ifdef IOMD_IRQREQD
-		ldrbeq	\irqstat, [\base, #IOMD_IRQREQD]
-		addeq	\tmp, \tmp, #256		@ irq_prio_lc table size
-		teqeq	\irqstat, #0
-#endif
 2406:		ldrbne	\irqnr, [\tmp, \irqstat]	@ get IRQ number
 		.endm
 
@@ -92,40 +82,3 @@ irq_prio_l:	.byte	 0, 0, 1, 0, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3
 		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
 		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
 		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
-#ifdef IOMD_IRQREQC
-irq_prio_lc:	.byte	24,24,25,24,26,26,26,26,27,27,27,27,27,27,27,27
-		.byte	28,24,25,24,26,26,26,26,27,27,27,27,27,27,27,27
-		.byte	29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29
-		.byte	29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29
-		.byte	30,30,30,30,30,30,30,30,27,27,27,27,27,27,27,27
-		.byte	30,30,30,30,30,30,30,30,27,27,27,27,27,27,27,27
-		.byte	29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29
-		.byte	29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29
-		.byte	31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31
-		.byte	31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31
-		.byte	31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31
-		.byte	31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31
-		.byte	31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31
-		.byte	31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31
-		.byte	31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31
-		.byte	31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31
-#endif
-#ifdef IOMD_IRQREQD
-irq_prio_ld:	.byte	40,40,41,40,42,42,42,42,43,43,43,43,43,43,43,43
-		.byte	44,40,41,40,42,42,42,42,43,43,43,43,43,43,43,43
-		.byte	45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45
-		.byte	45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45
-		.byte	46,46,46,46,46,46,46,46,43,43,43,43,43,43,43,43
-		.byte	46,46,46,46,46,46,46,46,43,43,43,43,43,43,43,43
-		.byte	45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45
-		.byte	45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45
-		.byte	47,47,47,47,47,47,47,47,47,47,47,47,47,47,47,47
-		.byte	47,47,47,47,47,47,47,47,47,47,47,47,47,47,47,47
-		.byte	47,47,47,47,47,47,47,47,47,47,47,47,47,47,47,47
-		.byte	47,47,47,47,47,47,47,47,47,47,47,47,47,47,47,47
-		.byte	47,47,47,47,47,47,47,47,47,47,47,47,47,47,47,47
-		.byte	47,47,47,47,47,47,47,47,47,47,47,47,47,47,47,47
-		.byte	47,47,47,47,47,47,47,47,47,47,47,47,47,47,47,47
-		.byte	47,47,47,47,47,47,47,47,47,47,47,47,47,47,47,47
-#endif
-
-- 
2.30.2

