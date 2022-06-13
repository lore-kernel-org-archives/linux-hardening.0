Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F419ACCA47F
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245492AbiFMSbO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245293AbiFMSa4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1742248D2
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F1E7612DF
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA7CC36AFE;
        Mon, 13 Jun 2022 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131600;
        bh=um43QG7Uixnp9Q4aH+kmw/A/kYTdr1jsi3GWxNDLRw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RVwK2MPpXQKj6TZG4qz6Cn9lUpPmKqxQrS6R9XrjBWA+SpDO+L62YrgWYJ/7k80il
         ngAVerQpuft8yNmQdDHgfLkl0a+tqR+mO/H0bt6YBasT/2oJ9E02MhhE6QGpdbXBBK
         GEK4vyTGWz3ZOhzdyVbjkZJXVzmnHpkpxI7A2Cqm49f8e8mEBP7QXcMBg9y5Av2+ed
         td4aYR0PKpTKouMjqwBaWUBUzZxADEHflc4CyAINmJVqEJgH8KrZrLihjrN+1Vms6B
         Bo1BYFYkBk0oIXtDSu6tyAeK6bwIPaxBZDKqUgQ6T+bPj2ItjBJJHuIFebo3aCIX0V
         fqQDtrsmv7ZPA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 15/26] arm64: idreg-override: use early FDT mapping in ID map
Date:   Mon, 13 Jun 2022 16:45:39 +0200
Message-Id: <20220613144550.3760857-16-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544; h=from:subject; bh=um43QG7Uixnp9Q4aH+kmw/A/kYTdr1jsi3GWxNDLRw0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02KPYJryZ7RskFoMzvysSLYOyZ2ZkPCClfF18Ju YyYnsZ2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNigAKCRDDTyI5ktmPJLtDC/ 9jUF/xfdwtuurCZ4YmAGylsnrQiExCmJ4GYn+8Szg+IPPh33HuZkS5sMr/9B90stk2PF0bUr5tmcKy oRiH2XIEomLRSuQDNm7SnULF/9nkTlewtZrbo/yu+jdD1rxsBGJxyCm3KCiIRZYUlWK+WyT44Mk/Vf DAgzDTOkoSihCgShg2v30vuv4ToEhycdgkqeTixfdWVQOOQeY0HHo48Jrg+LLQz9EFk0rajVurV0fD WrECQfXLyddTOH3ZMOhgY5CRhb4FJlpwTQXgSux1rSij2OL+D+eoOdxjopsSXgw7F3eAC+hmVIJpq8 WhbJMvI6jLEdX5Kz6650MgNaMQaXZ/2W9Lf6eGdVTBmalIN8X6v3gMh5CrZXnahF+wagrxrrSVRpE1 f+QoEcSnzlDKwB7xOgZ54XZc7VbBH/O61KNVg3di/OBBY5DgxBeYSPSIGMAFevQcPlk6qLE8mFXBnI nooVzcBB4iuR2tvdrmhSpARmSnW9WivJby8wKPGYuiGFY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Instead of calling into the kernel to map the FDT into the kernel page
tables before even calling start_kernel(), let's switch to the initial,
temporary mapping of the device tree that has been added to the ID map.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S           |  1 +
 arch/arm64/kernel/idreg-override.c | 17 ++++++-----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 8283ff848328..64ebff634b83 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -472,6 +472,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 #endif
 	mov	x0, x21				// pass FDT address in x0
 	bl	early_fdt_map			// Try mapping the FDT early
+	mov	x0, x22				// pass FDT address in x0
 	bl	init_feature_override		// Parse cpu feature overrides
 #ifdef CONFIG_RANDOMIZE_BASE
 	tst	x23, ~(MIN_KIMG_ALIGN - 1)	// already running randomized?
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 8a2ceb591686..f92836e196e5 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -201,16 +201,11 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 	} while (1);
 }
 
-static __init const u8 *get_bootargs_cmdline(void)
+static __init const u8 *get_bootargs_cmdline(const void *fdt)
 {
 	const u8 *prop;
-	void *fdt;
 	int node;
 
-	fdt = get_early_fdt_ptr();
-	if (!fdt)
-		return NULL;
-
 	node = fdt_path_offset(fdt, "/chosen");
 	if (node < 0)
 		return NULL;
@@ -222,9 +217,9 @@ static __init const u8 *get_bootargs_cmdline(void)
 	return strlen(prop) ? prop : NULL;
 }
 
-static __init void parse_cmdline(void)
+static __init void parse_cmdline(const void *fdt)
 {
-	const u8 *prop = get_bootargs_cmdline();
+	const u8 *prop = get_bootargs_cmdline(fdt);
 
 	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !prop)
 		__parse_cmdline(CONFIG_CMDLINE, true);
@@ -234,9 +229,9 @@ static __init void parse_cmdline(void)
 }
 
 /* Keep checkers quiet */
-void init_feature_override(void);
+void init_feature_override(const void *fdt);
 
-asmlinkage void __init init_feature_override(void)
+asmlinkage void __init init_feature_override(const void *fdt)
 {
 	int i;
 
@@ -247,7 +242,7 @@ asmlinkage void __init init_feature_override(void)
 		}
 	}
 
-	parse_cmdline();
+	parse_cmdline(fdt);
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
 		if (regs[i]->override)
-- 
2.30.2

