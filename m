Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C4C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 13 May 2022 20:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384144AbiEMUWq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 May 2022 16:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384152AbiEMUWn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 May 2022 16:22:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E316D4A8
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d134-20020a25e68c000000b006483b1adcc3so8189090ybh.11
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qSFqHEoM0jVY7Xc145M1tC6JaMH9LeBcrCGvTvckEBI=;
        b=cByubZC95NZHiGgqSDuLONtA3X/WkLE+HVnc2mzvEL8ZduMsM8hhr6bGQhjb5MAoBf
         AlxWoFJljgvPJAPexGdsYAU2nkBf2511z76YHeCLBBKG0AAYVqG85Ns8p0H5W1w5vphk
         R+kEXvZ920Vz9rWKPcwDnTjphfS8yAb1vP3H2TwcJedrvDrAz0I2StTob25tINYtK41w
         dFHR1/CxVJuaplVjk1XnKzaYEW6m/C1cuf3Iqs0DUZ9htCJOpUbLQuifBjU1Cnimx+Bw
         DryMNF1HR27a9YQqZ5rpnYIGLfjb9lXH9MM5byY46h79zx0IWoycyOAqIAeODvAlCl4n
         g0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qSFqHEoM0jVY7Xc145M1tC6JaMH9LeBcrCGvTvckEBI=;
        b=WuqQJuNM5cFdTeKe0018rZgv1snojCvHeTnFBIJKP58q6P3v80KB16iec7olVkzwkJ
         1Qxyuiku+ZCgu11pIl6vVAeTAqpRMHr5//uKn7rcyM24+ECNtpc4PyiTGXHkkNpHPLUB
         mk9uHjh0q4NZlFtbn8krGDSqdL4hYmZYFSel5IISG6bG3/UGfzg5oOPmvBTmsveWjD/F
         RGo5n6cHbyllsWeW5lskHmLg2uAGTt1DZ743R8L166y8AHulHesoPECJAd1+Bs+3eoTB
         JTP9hvrKyhNhGvVNxaFA5UVFg2qAin9GHnBLraoqjAaD68zgosgMCh3pS+0pqd7/RMHv
         Nx3Q==
X-Gm-Message-State: AOAM533dckM42m909nOZoUyYKKLTsRRr/CwBLvogR7upFA64RQk2rSf8
        8qjWs/PPxCx+Zs5gN0L+8Oi0Y4JXPFfbaAlcIS4=
X-Google-Smtp-Source: ABdhPJxDA6ZdqsEPj1xJDYsYUmAOPwqTrdnMoq/rG+psn5HvqkJ8fzRIKNGmJ0yGoi6cJV7H5UV2gjxi7x01RpVxzCs=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:84:b0:63d:4a3d:eb5 with SMTP
 id h4-20020a056902008400b0063d4a3d0eb5mr6762470ybs.145.1652473342924; Fri, 13
 May 2022 13:22:22 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:47 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3798; h=from:subject;
 bh=4TCS/TOOZQmpZTvnkB/4gv9RquE2CFE6aPMp1ORi+F8=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3keudw4QkzukoMzVjW96Vw+mRxd/N17uuheg4o
 ZrrHzi+JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695AAKCRBMtfaEi7xW7mAnC/
 9MFFSpVcCRnjn6y/sZgCMgB5v8SzFD4fcUMRzQdCuywzauLs6IVlf2abTnws4RBuqt7xXRPaT0d/Tp
 CCDvoWoZFKFeNWuUyQQdq8O7hdkgMuRAE+YdBhUJj7/b8NNcxtC//EOkOMwUrddtnhRe+mpqu114Wt
 x0LCWvLmWILbkSArCygz4rgemA07WPWqt5qveGMr/+j2gvuZlXXlrz8HUewJ30uyHQeeeFk8dXRH41
 Q59fHATagQlVvKd+rYHMie0iY8PA0hShyA8NRIc3pLg+ZezhtHPudqd7m93l8758xWWMK/RGkNUWqc
 yIWBB4W3oOfq6RzuUShftpo40PN+Gp2cNvGocpje01s8dROy4bqL2HYjWmLS1nJN4v9PEsMc0KdLMy
 IbmU/jfkO9j3mbRV3Eg2GqPE/h5IpHeC/yo4w6LEJ69OktyEoM6DTD+k0eg3RitzHvCPjTnnf2eE0E
 NwIRPdYI8Xg4cSruMxRSdJXpLJx6qOsiQBXk9HWActwcE=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 09/21] arm64: Add types to indirect called assembly functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With CONFIG_CFI_CLANG, assembly functions indirectly called from C
code must be annotated with type identifiers to pass CFI checking. Use
SYM_TYPED_FUNC_START for indirectly called functions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/crypto/ghash-ce-core.S | 5 +++--
 arch/arm64/crypto/sm3-ce-core.S   | 3 ++-
 arch/arm64/kernel/cpu-reset.S     | 5 +++--
 arch/arm64/mm/proc.S              | 5 +++--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/crypto/ghash-ce-core.S b/arch/arm64/crypto/ghash-ce-core.S
index 7868330dd54e..ebe5558929b7 100644
--- a/arch/arm64/crypto/ghash-ce-core.S
+++ b/arch/arm64/crypto/ghash-ce-core.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 
 	SHASH		.req	v0
@@ -350,11 +351,11 @@ CPU_LE(	rev64		T1.16b, T1.16b	)
 	 * void pmull_ghash_update(int blocks, u64 dg[], const char *src,
 	 *			   struct ghash_key const *k, const char *head)
 	 */
-SYM_FUNC_START(pmull_ghash_update_p64)
+SYM_TYPED_FUNC_START(pmull_ghash_update_p64)
 	__pmull_ghash	p64
 SYM_FUNC_END(pmull_ghash_update_p64)
 
-SYM_FUNC_START(pmull_ghash_update_p8)
+SYM_TYPED_FUNC_START(pmull_ghash_update_p8)
 	__pmull_ghash	p8
 SYM_FUNC_END(pmull_ghash_update_p8)
 
diff --git a/arch/arm64/crypto/sm3-ce-core.S b/arch/arm64/crypto/sm3-ce-core.S
index ef97d3187cb7..ca70cfacd0d0 100644
--- a/arch/arm64/crypto/sm3-ce-core.S
+++ b/arch/arm64/crypto/sm3-ce-core.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 
 	.irp		b, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
@@ -73,7 +74,7 @@
 	 *                       int blocks)
 	 */
 	.text
-SYM_FUNC_START(sm3_ce_transform)
+SYM_TYPED_FUNC_START(sm3_ce_transform)
 	/* load state */
 	ld1		{v8.4s-v9.4s}, [x0]
 	rev64		v8.4s, v8.4s
diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 48a8af97faa9..6b752fe89745 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -8,6 +8,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 #include <asm/sysreg.h>
 #include <asm/virt.h>
@@ -28,7 +29,7 @@
  * branch to what would be the reset vector. It must be executed with the
  * flat identity mapping.
  */
-SYM_CODE_START(cpu_soft_restart)
+SYM_TYPED_FUNC_START(cpu_soft_restart)
 	mov_q	x12, INIT_SCTLR_EL1_MMU_OFF
 	pre_disable_mmu_workaround
 	/*
@@ -47,6 +48,6 @@ SYM_CODE_START(cpu_soft_restart)
 	mov	x1, x3				// arg1
 	mov	x2, x4				// arg2
 	br	x8
-SYM_CODE_END(cpu_soft_restart)
+SYM_FUNC_END(cpu_soft_restart)
 
 .popsection
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 50bbed947bec..dfa715315551 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/pgtable.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/asm_pointer_auth.h>
@@ -184,7 +185,7 @@ SYM_FUNC_END(cpu_do_resume)
  * This is the low-level counterpart to cpu_replace_ttbr1, and should not be
  * called by anything else. It can only be executed from a TTBR0 mapping.
  */
-SYM_FUNC_START(idmap_cpu_replace_ttbr1)
+SYM_TYPED_FUNC_START(idmap_cpu_replace_ttbr1)
 	save_and_disable_daif flags=x2
 
 	__idmap_cpu_set_reserved_ttbr1 x1, x3
@@ -224,7 +225,7 @@ SYM_FUNC_END(idmap_cpu_replace_ttbr1)
  */
 __idmap_kpti_flag:
 	.long	1
-SYM_FUNC_START(idmap_kpti_install_ng_mappings)
+SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	cpu		.req	w0
 	num_cpus	.req	w1
 	swapper_pa	.req	x2
-- 
2.36.0.550.gb090851708-goog

