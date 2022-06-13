Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF940CCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiFMSao (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241854AbiFMSa2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184EAB7DE9
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B72661414
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5805C341C0;
        Mon, 13 Jun 2022 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131627;
        bh=7bEEAr1IuXGFMQ9oQhOhsUOIFI41qpVRjxgl/UArHFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gctsx+MBI8p8C07K4vjsJO+Hcb9pmqeTa46pzU73hLGcVtMYFYD6Zz9e+jLKNQEN1
         N2YIQQSFGX8hrPONbUZXA3xx3GzTY6SHHhMcYqiv7cdoEa/Iz5q+Nge62ECKLRZQmq
         vMM8D/K9NfrAHQkSGwghzfG2kifdVcTxQ5fN3+E3nFSPLZrliAPMzsW/z7V2BvkyzV
         o38QqJmEDWgHUva/QvGxksodvMUxVtnrMVMAlUPrb4uxkVI4iaMyPpUGgnwLrsWwXP
         +D4PBTXrMeOFYM5NnWs8Oujh979ZYq5B/5czx15qcjNNMk7+tfxbvB5f3qvEBj2o2L
         du/eX5wp7rDzw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 26/26] arm64: kernel: move ID map out of .text mapping
Date:   Mon, 13 Jun 2022 16:45:50 +0200
Message-Id: <20220613144550.3760857-27-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; h=from:subject; bh=7bEEAr1IuXGFMQ9oQhOhsUOIFI41qpVRjxgl/UArHFA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02dF7jrfeBfxO4ZmE0qR882hk457VzfK5qUww9/ Mvyi4uSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNnQAKCRDDTyI5ktmPJM5oC/ wMei4QKjdtUEkKtscA1dyjZJOBFfnlIajikSjO2HuGR8f5dSoWF4wsr8UiOtN1ONlYvapj2x110v50 N1JiOG5l2HrDh+NoOD2PSF44cdXu36dZBElXG9OWmpx6j4m6HmvmHSiNQonVopS2fbSicb9ICeySln 2q0CLWgrRNRxV+MnyML4+LMVCbsLQkaRZ1VlnrXEWULse4pUwHdVr7f1Ki+uY5NcfBuiIu2UKTLMP+ k0tFgPAWJBmdY6RAsK1kRaFK1bp8nugkoFyWCvjra9dkdSBgV05bS9rQH3rknDvll2p5hAjgGOh+3Y I6zTYBmHGom0F81yoR3/k1jpIi4ha5zTh6kad40gFx4oHCDjUZgbe4QbfCa70GuVf76Ug5fhNV9wmD GDWPjF7dDpdv/vwzH795mH+pUqPVVirmz8DSeNVEEjsrL6Yrw41lzGiP7eXMhcKbB7VP6nI/fpK2qw xN6SbVJZTSVH3lLdN455NYm4Lww1hv5DxLFvjuyUGIueg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Reorganize the ID map slightly so that only code that is executed via
the 1:1 mapping remains. This allows to move the ID map out of the .text
segment, given that it no longer needs exec permissions via the kernel
mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S        | 5 ++++-
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 arch/arm64/mm/proc.S            | 2 --
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 834afdc1c6ff..eb959d3387b4 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -525,7 +525,7 @@ SYM_FUNC_END(__primary_switched)
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
-	.section ".idmap.text","awx"
+	.text
 
 /*
  * Starting from EL2 or EL1, configure the CPU to execute at the highest
@@ -617,6 +617,7 @@ SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
 	ret
 SYM_FUNC_END(set_cpu_boot_mode_flag)
 
+	.section ".idmap.text","awx"
 	/*
 	 * This provides a "holding pen" for platforms to hold all secondary
 	 * cores are held until we're ready for them to initialise.
@@ -658,6 +659,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	br	x8
 SYM_FUNC_END(secondary_startup)
 
+	.text
 SYM_FUNC_START_LOCAL(__secondary_switched)
 	mov	x0, x20
 	bl	set_cpu_boot_mode_flag
@@ -717,6 +719,7 @@ SYM_FUNC_END(__secondary_too_slow)
  * Checks if the selected granule size is supported by the CPU.
  * If it isn't, park the CPU
  */
+	.section ".idmap.text","awx"
 SYM_FUNC_START(__enable_mmu)
 	mrs	x3, ID_AA64MMFR0_EL1
 	ubfx	x3, x3, #ID_AA64MMFR0_TGRAN_SHIFT, 4
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 3830c6c66e46..d51aa4bbd272 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -169,7 +169,6 @@ SECTIONS
 			LOCK_TEXT
 			KPROBES_TEXT
 			HYPERVISOR_TEXT
-			IDMAP_TEXT
 			*(.gnu.warning)
 		. = ALIGN(16);
 		*(.got)			/* Global offset table		*/
@@ -194,6 +193,7 @@ SECTIONS
 		TRAMP_TEXT
 		HIBERNATE_TEXT
 		KEXEC_TEXT
+		IDMAP_TEXT
 	}
 
 	. = ALIGN(SEGMENT_ALIGN);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 9ffdf1091d97..7b22e2afe8a0 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -107,7 +107,6 @@ SYM_FUNC_END(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
-	.pushsection ".idmap.text", "awx"
 SYM_FUNC_START(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -163,7 +162,6 @@ alternative_else_nop_endif
 	isb
 	ret
 SYM_FUNC_END(cpu_do_resume)
-	.popsection
 #endif
 
 	.pushsection ".idmap.text", "awx"
-- 
2.30.2

