Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3580ECAAA1
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 23:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiH3Xct (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiH3XcG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 19:32:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EC172EE7
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:31:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dce8cae71so190071397b3.8
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=xCc9uuNccPEaVQMS2s0Cmbndoz8x1OikM8TQU2p/PE0=;
        b=nH7CGzt09tUbSHSP0XWszujyNVus7iperihjwd1dE9u2mZgMby5GfquRmubKg8Jqh8
         giH2SAX8fzeDcvNNz4xRUeZED/AHEVSe2EuhAXtDiOj5uIzKeAgGoYzaeSxMgiYqZ8Y6
         e5An5TYrB/CCB6bEetpcdvhjpVhY4hetnDH50VSlL/qTGk1tfCxq+4wWVmzRP7d363br
         saZlLKBl6H8+rycwlczCKRIRy5Ez5SdxuII0+LmIki2ADeaKSrK8wfYtKKTD4db0TRm+
         iqF5GLv96WzvtzQB9u9LQq/3707Ah68f6nHHdv/h+P6bf3qs5RIL3Y1RfiFs2Oijy+ye
         A5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=xCc9uuNccPEaVQMS2s0Cmbndoz8x1OikM8TQU2p/PE0=;
        b=jluPIl14ByysQpCTCily1+EnHMexd/bXjqtLRJ2ngxLWGbnr4jur8D0jR1XsejKZwv
         DoaCSLTMupmWuQARpJHv5is+lCwMT0MgfrYmFfNke3NpG62jWbPzc3zFSQBgVLhyoJ1F
         ON8dS43qiJ8gVj1i4ZRrPiMjZMgGSfFxz8jn+RBFpKNkEuuzRFoJ2DmAL+hRxX/N5q2O
         y3c2l6i5XspIPet2EsYrm8nfulWKEUdITuRy/m9F7MxzOq/+qqlgIJssN6HF6fwY5IFi
         mCWHfi0IV+G9wcMo0uZZGEFiLh5G5tnzlYOrmWaPgXeGGDgl3H+AjkvHOqdLBXEJTUDB
         LZJQ==
X-Gm-Message-State: ACgBeo2hGHsyYV5ZYTdYi1oXFLXpB8IKO3n4YYpKLk57+KSf6ZIDrP1i
        isVd2AdfpLQCrb5UvvYUOxIrmSSAl3meW2p5s7A=
X-Google-Smtp-Source: AA6agR4qaYQdZ4xvx/SG0GN0jLKs7LULbyIZkGlZFdXi8C/5fvuRyPds0byQ/MlelLkLHjrgf8nulFq9Wd6cj3msxGQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a81:48d4:0:b0:340:a478:49a9 with SMTP
 id v203-20020a8148d4000000b00340a47849a9mr16297855ywa.364.1661902317205; Tue,
 30 Aug 2022 16:31:57 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:17 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3867; i=samitolvanen@google.com;
 h=from:subject; bh=dZ0t0cN28M7OF6REwBdzrNBq4nPUpgahVwqpYuj4zJQ=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3N8zN8blzdSyUyIYRgvgdWIMjZGYVU6Rzg0w+j
 C4X8UWOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzQAKCRBMtfaEi7xW7kZhDA
 CdKnZfEgEG2Ozl80ackvyrbUgIGmvki88WIUyUV1b+eFTKVywz4GJGjVq5KFqlV7wN6B1XEM9Qznmf
 Wq411slEydLsFb2LHdN929yVuI0DRA0Kiy6ESYz6H2tlVzk9t7tQOAU7Qkqe1is80gZ9cZvZLrq8xz
 HtZzat9tSPYaeKlsMXW7X+i8BcrzfTK7B9pkfKrVh6JDDIrsrzVOZRtvg9LHm2F4vD1y3SGvVR/+iP
 CzyoOEugc1Qs6t+OWaZtk6rnMv2rcLujNWCREToQKojHp/U4P4m765JgfpVHMxc8p1xlx1M9tJzrGh
 MgpVa7Re97mLd69cuGFw2TKSrI+UVdaLtzWpEPYEzsMxhaxwTDx3ZoJvEOX/ueYSWhFx9nluHvBQFx
 kIGHij+QrreHgYm9TrS++3Y0dA2uNUPktM58KP7vLxj9ixHU0ofEwhqPAuXo5RfLFSceSTJn8jrATA
 2Tp4RpbLiuIWL92fo6kRn6MgJAK33J8UKuiO+qUpzYMRI=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 09/21] arm64: Add types to indirect called assembly functions
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
SYM_TYPED_FUNC_START for the indirectly called functions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
index 7837a69524c5..8b9f419fcad9 100644
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
@@ -185,7 +186,7 @@ SYM_FUNC_END(cpu_do_resume)
  * This is the low-level counterpart to cpu_replace_ttbr1, and should not be
  * called by anything else. It can only be executed from a TTBR0 mapping.
  */
-SYM_FUNC_START(idmap_cpu_replace_ttbr1)
+SYM_TYPED_FUNC_START(idmap_cpu_replace_ttbr1)
 	save_and_disable_daif flags=x2
 
 	__idmap_cpu_set_reserved_ttbr1 x1, x3
@@ -253,7 +254,7 @@ SYM_FUNC_END(idmap_cpu_replace_ttbr1)
 SYM_DATA(__idmap_kpti_flag, .long 1)
 	.popsection
 
-SYM_FUNC_START(idmap_kpti_install_ng_mappings)
+SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	cpu		.req	w0
 	temp_pte	.req	x0
 	num_cpus	.req	w1
-- 
2.37.2.672.g94769d06f0-goog

