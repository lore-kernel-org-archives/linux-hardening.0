Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC802C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbiFMSa4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245260AbiFMSak (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618EB7165
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FCE661408
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92592C3411C;
        Mon, 13 Jun 2022 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131615;
        bh=aYHj0TWjykDwNH3sJv2tef5A8aSmjVjkV8KghiY9Qcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjJOLBvihefENCV/199eQYqEFzOY4aBkhvNIaYG6B1kvA/uBg0Cjm4i+X9jdziUOz
         55DRBYmO1P9SpZVJi5Xe3LIYf996huvxqqSi+EYvtdZZ/IFEyMwAxnWDJwjOZi0Qy9
         ABFx89Vtj9W6DN+bDU8jIhJ4fyTTkfHT7YMSwRdu7NUW56rExlqeVmb2RnGPdWL7l2
         ZKvqrleqOe09AO/yO9sCELCpc7zbR9q43yFtRLa5Cg/c1X/LPuo86imtZjahPIbhTw
         Hg/oLEZO/9kC/UaZrHSiwstKDI5Stb3rbCVxWcLr+5RLzZ193SscLrS0Q+EJPulxL0
         qjiQOF2dJ/srw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 21/26] arm64: setup: drop early FDT pointer helpers
Date:   Mon, 13 Jun 2022 16:45:45 +0200
Message-Id: <20220613144550.3760857-22-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; h=from:subject; bh=aYHj0TWjykDwNH3sJv2tef5A8aSmjVjkV8KghiY9Qcs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02UKfnGPZv3BpF+Besz3/0TxnN3nmcoZ6k6QxK1 E6e79s6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNlAAKCRDDTyI5ktmPJEgyC/ 9cdJWzDDtZcuyig7jH9jDtVj4lnPnEicwxTUqBfd/TIaATkQIMJ2dHqordR4HAtnttm3IeYOabtAhK EfgMIzFt/eu7SVSpC+/JLc79AOkzE5wG0UaJKbsCVTH3rLsB/N84AcwLdLF/jyVpLspQnP54GYIVjx bl5RyGOPQe+f3s9TO9vzL5ISgJ6Ns4H+I/QxPW4NRmcIAk0EKg1QEYuptlTe9xhC8RRGzlmPDTHSJW WRFM7x+B6ECH+dZBlMq4otKftBJBRoDLhfaXPg/zMAnENM52sKGP0yEiDNvxgfk6D/Pnk07Pre5ayJ 4adwCbEdDgiAaiO8aRoChmhIp+DBkUzQBszv0py/+gzQAgsvGvkZ6sYLZ7UsH2ovoQsgwUy8Xv5cZ0 nEIRsqepSPItlyeOdIVlDD7VeaPB9gvxQs4aAyNFTlVsWlPvPEJNIyIZfWOPdMKdcgBWuKGBFDAx7t yOu01amLqJPYmDvlDwc+UvxWQXMFbfBzJoQJ/y9bgcnI4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

We no longer need to call into the kernel to map the FDT before calling
into the kernel so let's drop the helpers we added for this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/setup.h |  3 ---
 arch/arm64/kernel/head.S       |  2 --
 arch/arm64/kernel/setup.c      | 15 ---------------
 3 files changed, 20 deletions(-)

diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index 6437df661700..5f147a418281 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -5,9 +5,6 @@
 
 #include <uapi/asm/setup.h>
 
-void *get_early_fdt_ptr(void);
-void early_fdt_map(u64 dt_phys);
-
 /*
  * These two variables are used in the head.S file.
  */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 5a2ff6466b6b..6bf685f988f1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -446,8 +446,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
-	mov	x0, x21				// pass FDT address in x0
-	bl	early_fdt_map			// Try mapping the FDT early
 	mov	x0, x22				// pass FDT address in x0
 	bl	init_feature_override		// Parse cpu feature overrides
 	mov	x0, x20
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index cf3a759f10d4..6c2120afe542 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -163,21 +163,6 @@ static void __init smp_build_mpidr_hash(void)
 		pr_warn("Large number of MPIDR hash buckets detected\n");
 }
 
-static void *early_fdt_ptr __initdata;
-
-void __init *get_early_fdt_ptr(void)
-{
-	return early_fdt_ptr;
-}
-
-asmlinkage void __init early_fdt_map(u64 dt_phys)
-{
-	int fdt_size;
-
-	early_fixmap_init();
-	early_fdt_ptr = fixmap_remap_fdt(dt_phys, &fdt_size, PAGE_KERNEL);
-}
-
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	int size;
-- 
2.30.2

