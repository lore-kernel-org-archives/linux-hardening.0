Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C1ECAAD5
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 23:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiH3Xcx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiH3XcI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 19:32:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8387AC31
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dbfb6d2a3so190476057b3.11
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=iSKFadVRGufrYpwT+lMSnNGa80NvrDGJYFfJh0K053o=;
        b=aea7f+jGGqYBZvgs3orCadjUsDfEDwReuGVw99oeGDGf7HEC9SsWjsfrc4GKNaD6hP
         nrq5xjB9KkSqASgIkUlxMnTp8Km6owmHFu3fTgFOv6KvP4eM+abfzLH+8I6bLicq5smv
         eDG6ttbs273TD7DuasPZT7cximHiEM3CmgjyhDFTYjOlX3lg0O71IK8vGJeisE537v0G
         /84LNcC/b5N5SGDtXczpJ448nRkwvexxbTXvAda6YuVil3v0IrjmkMJ6/bHjXAJTWE+9
         ykzvYVbqr9U6P1Z3KvlXY+4NvSLMXaotZL4KkDq1MWLWxgRs+Hlhts6BqiiWRh+Dvfl0
         7e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=iSKFadVRGufrYpwT+lMSnNGa80NvrDGJYFfJh0K053o=;
        b=udkDnL67GvOeNUK/JLMUNGpEL1R6GgdkJB4Urk5/QLxXIdnuug+3CXzkomwk1SdYS5
         GzpRKGh79ZovHYmpFNkSrSX/wYG5iQ/46GYMYfaLe263Yj6Vgx+3hW8DI2Wg2eryhLJd
         d9W36Wi/NQMP6CQTPUKqNVPRxfrBzIZoPaE00T4ESKDHGDOa6mkj/9XWNWjDL4aQRbsQ
         OHmDONQMsvzOzUcg+c3lp3u932pYp2UweHJksBoDYZ6PIEUuZ5crmG37s/qqh7WWfVld
         tye5rWERPnAu+mV+PcGguYea78O1L6sN7ofs/3zK6uDjQOV5yoob/CQTarfQFN+k4m/b
         bYsw==
X-Gm-Message-State: ACgBeo1G4U2hnt531Y4D1D/0IuCBILhbtLQ18CkxKRs0vyoFF1wRp+BK
        NdEwLgGJtOBsVOJbszsmn/S8TAGLsWbcon6XrbI=
X-Google-Smtp-Source: AA6agR4dNWfY0j6qePqn3prvgFjGMASrL7MLejp/isbrgaHY+xJaMD5dtv41AGsWWLDIY+wLuApFeyxpr9oELA8nW+s=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a25:3746:0:b0:69b:a100:521f with SMTP
 id e67-20020a253746000000b0069ba100521fmr9841652yba.135.1661902323439; Tue,
 30 Aug 2022 16:32:03 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:19 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392; i=samitolvanen@google.com;
 h=from:subject; bh=4fEwVbMTS4PhblTx3hjYUyv158cFLGoiHZdYncXlyvM=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3NGeTaUnU1q2XxWRmRjYKzsHzN1uiEteQxzaGl
 2CA0UxGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzQAKCRBMtfaEi7xW7rJdC/
 9UcVy/DfbAoLGh8Ex43l9s3e1xNLlcP/xWCoYq8CUdwrGkU622rRNiEdF+X0NOBHDwK8i7DyRAn0PK
 38Hsd+b1qOoUJlPBVMxl/ymJ3j7zbkQsbJMr5XWRG0N5HmxXjghCylDMKfdDFZ9e3gew1xx1sj24MA
 jxEVQYBIMYZVDIpYDmZgOv1biQKojcsDFIE3lFclQtcPwQLPWap3PVAPVd2oqDMfKGQXNbOaa2Qgio
 doXCrE0dslkp2/yG4QHSM2E2j0fNAKDllqfR6xQcjCU2kr6anScnJ8rolEApP2tMueaLsLoxMwJKbD
 +pf+ycZPrG8GCHpntkBi4jULpc66b3D+JN9ZdgIl7RTqNX2/9XMbns0EOfrhy9gNgoPYd9bhIJpm2k
 1M2frsyMoG+u+4rCsSKGqYfnQJvjamiR5Y6yncD9JRQDvdhecxlWWD/aVLEBel1hFOkANsQfHEESXp
 x6U6Lko1f4miNMWO/ymnQfmQ+cJiFgtDuMnEUqvhkTYsM=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 11/21] arm64: Drop unneeded __nocfi attributes
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

With -fsanitize=kcfi, CONFIG_CFI_CLANG no longer has issues
with address space confusion in functions that switch to linear
mapping. Now that the indirectly called assembly functions have
type annotations, drop the __nocfi attributes.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/kernel/alternative.c      | 2 +-
 arch/arm64/kernel/cpufeature.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c7ccd82db1d2..bba0e630c8bc 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -147,7 +147,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
+static inline void cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 9bcaa5eacf16..d2c66507398d 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,7 +133,7 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __nocfi __apply_alternatives(struct alt_region *region, bool is_module,
+static void __apply_alternatives(struct alt_region *region, bool is_module,
 				 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index af4de817d712..ca6e5ca7104e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1685,7 +1685,7 @@ static phys_addr_t kpti_ng_pgd_alloc(int shift)
 	return kpti_ng_temp_alloc;
 }
 
-static void __nocfi
+static void
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
-- 
2.37.2.672.g94769d06f0-goog

