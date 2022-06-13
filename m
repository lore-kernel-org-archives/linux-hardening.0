Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6C5CCA47D
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245293AbiFMSbP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbiFMSbA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:31:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25342B640C
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD90C61121
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A75FC36B01;
        Mon, 13 Jun 2022 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131603;
        bh=S9LYQJwCVtOofosFai5+YO1U27PWPWy//Cw6PdVBb08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJnS2cmE8CdgHIJBH4Hu3DGLGwDLGPpWCmRarDJcO2ryfN3YKpaTCpfAAkh0CWlTr
         cPufGoFjfRlcPNGsOHWnrAEAFsOpjb8w99+mrF/oIvub4hC8Uu0QEEuYPNGJmNna0l
         1N+6JJ0wzzb7sH0ifVC3dLe7QSpTzP+YfIGao8Pj6jeBc/9DoUZ16OvElNVLg+GYHP
         Zn8JCjmZmnDZkNlz1GwTK5TZWQhFrrDtNZmtC6cvcAvocIuaAUzrcM+I/nsDY+By/l
         AkSFk0+BhWMZxlRPM7GjHPlctcqLQ0FzfLz0BsIzDSB80hWvuKYZztWsuy7X/9KSj9
         ACl7AFLokJ6VQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 16/26] arm64: head: factor out TTBR1 assignment into a macro
Date:   Mon, 13 Jun 2022 16:45:40 +0200
Message-Id: <20220613144550.3760857-17-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; h=from:subject; bh=S9LYQJwCVtOofosFai5+YO1U27PWPWy//Cw6PdVBb08=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02L/ftUuweNGM01fa8DyZ6EK7EUNj8NyNmf74z6 7QKfPa2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNiwAKCRDDTyI5ktmPJKsfC/ 9M4VKd89dRdoCxh5fbiBxMaP713z9uBf2paJO//SLoXNqAeJQq7hCXnMsrQFlK+4srbvyLCft950r6 b+7/CqF/2NfaSShaahyr8W/4IDUCFgFOiscpe9LLvMUf0xfV/0QzyGu7OPIHAbqWJJGHlGl/MgYFQ7 WXAU9iSZVWLwUALwNMOgp4ANPYjgBgvHfiSIFKZNBLBDjpca542Nl8aWgPxKFmBeGKgFXUnoA6+HXE dt5JYdV+jm6R1h0CnfNMl58xNOn8rEQtea7IOitk0zJ5+bN8/lpkFuCcU6zDNOLqm3bq866Fzd426f X+ZjTIOHgYQKd+u1B2DRFFEaUu/hBzAa1jrASp8aFv8iLq9gn/kdD8PH7XMXNTKkJDoy5JBNBQZ4Qj Vla9/DKDR27b+MfDdDU1WQiNwi6jTeOEbQRY+5BTuyLifwTc1tiSTSiwMyNL0tPhMNUVeazsj2H5ed jLiO84U4FqUR5I2fGgxHm+5ba0tbtihkcK4t5H+R5WTfg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Create a macro load_ttbr1 to avoid having to repeat the same instruction
sequence 3 times in a subsequent patch. No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h | 17 +++++++++++++----
 arch/arm64/kernel/head.S           |  5 +----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 9468f45c07a6..b2584709c332 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -479,6 +479,18 @@ alternative_endif
 	_cond_extable .Licache_op\@, \fixup
 	.endm
 
+/*
+ * load_ttbr1 - install @pgtbl as a TTBR1 page table
+ * pgtbl preserved
+ * tmp1/tmp2 clobbered, either may overlap with pgtbl
+ */
+	.macro		load_ttbr1, pgtbl, tmp1, tmp2
+	phys_to_ttbr	\tmp1, \pgtbl
+	offset_ttbr1 	\tmp1, \tmp2
+	msr		ttbr1_el1, \tmp1
+	isb
+	.endm
+
 /*
  * To prevent the possibility of old and new partial table walks being visible
  * in the tlb, switch the ttbr to a zero page when we invalidate the old
@@ -492,10 +504,7 @@ alternative_endif
 	isb
 	tlbi	vmalle1
 	dsb	nsh
-	phys_to_ttbr \tmp, \page_table
-	offset_ttbr1 \tmp, \tmp2
-	msr	ttbr1_el1, \tmp
-	isb
+	load_ttbr1 \page_table, \tmp, \tmp2
 	.endm
 
 /*
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 64ebff634b83..d704d0bd8ffc 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -722,12 +722,9 @@ SYM_FUNC_START(__enable_mmu)
 	cmp     x3, #ID_AA64MMFR0_TGRAN_SUPPORTED_MAX
 	b.gt    __no_granule_support
 	update_early_cpu_boot_status 0, x3, x4
-	phys_to_ttbr x1, x1
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
-	offset_ttbr1 x1, x3
-	msr	ttbr1_el1, x1			// load TTBR1
-	isb
+	load_ttbr1 x1, x1, x3
 
 	set_sctlr_el1	x0
 
-- 
2.30.2

