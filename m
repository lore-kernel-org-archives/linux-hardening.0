Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098E8CCA47D
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Jun 2022 23:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350957AbiFJXgT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350156AbiFJXgI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A1D289F36
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d11b6259adso5747767b3.19
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XQzoa9Hbm2J1FC5lebup2zdYvg5ee8G3jglBmtbWdMA=;
        b=US507XUeqVBOul77B/VFOWIwS4pd3nIRPg+pGiozRhuxzzq2ZnTjYUWOH5Wd6LLiYe
         odE9mwv9yV9x0+KlQ/9R+5gEDSTkmcRlkll00lTsC6yUBgkIjuT+tFphrdbUGExqAKFz
         WzP1Qu5a+FDuRY847PYNDCZS4fzfn4KJZ9dadgjIE7gN0eya/Z/TI5ux/cASDbBX2TWf
         rNsdxf4qMXc8dQh7Ya7uf8Jznp8DQsF8asaWuv4VvhY46bn853FzwbM3IHpR3/Au+skp
         GQNKqDqu7sOBaiy0hkdkdtF0+Ertcwcm0ztyAe1iJkbSCGIXyeh8AvXFl6Q4XZmo/a3f
         4jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XQzoa9Hbm2J1FC5lebup2zdYvg5ee8G3jglBmtbWdMA=;
        b=ICZyStS+IVu/PF/J7uvcLp0zC/5pTZm/Mz4OK5NViaR45Wx4jEIQvG25tlnPYfg+Jq
         cO6MKNd98DBK7v1H5yQ3pUHM5WaCLDA6HNdkVyZcvb/1Xqcm1EeTYfBgf3pLcA3xShma
         0BKF4kRAW9/hLVW3IvA1jc3WrT3h64JevTL4bwlpT0fTqJgM+doeX7AVlE0ecT2OeUcP
         H0BtcGYLBc0oUugGWQTfZaYNJacvyE2w2FLwQyGIunEvSTm7dl1gTq2ydrYgOd++L0AP
         SC1iA+C/pq+V/KJTyYJxxghByCZcXqrJXfzzu1Tm/D7Gl97LeqTtagGb6PzOmd6x/fIL
         uG0g==
X-Gm-Message-State: AOAM531brr11nHczpa0kSqT+vIGKeCltVGyBM9XGaUuYdoBVqKJYLDqY
        d2MlRXxUud3sdrCx9WhWSOmrcmF0YUR/VR+AZUQ=
X-Google-Smtp-Source: ABdhPJxOnfCH6DmxniOqq2LkeH9gEZ3RgiYPiLFCUyVjRAHWiCSIASDSQFq5utQqSEA9eUYUOU+8UPE87gxIjEN26Og=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1109:b0:663:62f6:7f3e with
 SMTP id o9-20020a056902110900b0066362f67f3emr32789459ybu.516.1654904140205;
 Fri, 10 Jun 2022 16:35:40 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:03 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; h=from:subject;
 bh=gUQdQPsX7uTYFsHphyP8RuFjJc28btkAaQrsu/mKELw=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UuEWWSmMhEikQU/hTXdinKYos9UVVSPfvxrQiP
 ClWVaKeJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLgAKCRBMtfaEi7xW7kZGDA
 COpVnTMk0wBQa7hTfdzIF4Ot91or7ZDsSbiPCq1+UcotRG/hvz9f7vHFLNSiP89hfxEvavNqjwV4Jm
 OTY0iPVk4K3Wa6znkh1BopxAj6JlwZHgreOk4ErPvm+Siw78HaVMI/mSFQY9F1fkAHM7oq0p45Buge
 qTxH3b+yIsdrzk4Ezns5qRjuQR6NneX+YLOECH/JyNvebJnc+EhShXdBdM9Pk+DgYRv7w4cdf7XhDz
 q/W5n5pxD3JcmG1ubc5OZzs576mGicLLcjJo4Uy1eG00c7ve5/wGx/1oFlUvz71kJXKKBybjDyLFyH
 pU2Wrrmx9Zss3VzZeghtF8OgIiP5KD9g1YZ3xdLTlQqqWZbkDesd9KJND9PbD/jGz7jtkfvWfuCvJN
 YFNG8BeeUs9Qv1lNWXyXsDnr/tS2tkgoNrEqXPLMzBDC87C4siR44Xvtl59iNhmdnk2vwNmfw1wnTt
 KzcKq5PR5AGUDfbwTKrDzWvZZdTjeuETSpGdZ15XGWrE0=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 10/20] arm64: Drop unneeded __nocfi attributes
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
index 6770667b34a3..ca0140d0b8cf 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -143,7 +143,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 7bbf5104b7b7..e98466bab633 100644
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
index 42ea2bd856c6..f6f9694d0448 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1645,7 +1645,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static void __nocfi
+static void
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-- 
2.36.1.476.g0c4daa206d-goog

