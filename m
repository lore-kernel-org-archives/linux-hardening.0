Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3744C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Feb 2022 06:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiBXGEr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Feb 2022 01:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiBXGEq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Feb 2022 01:04:46 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC17F2325D9
        for <linux-hardening@vger.kernel.org>; Wed, 23 Feb 2022 22:04:17 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 139so917153pge.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Feb 2022 22:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBQhUdnhsD8RfcUU30uApq8m70WZYUmsL7PCUmornGQ=;
        b=euV4TcJ4C7XWuUsWe8K/AvIu2OQaD6q8iwxN9TTOS2rnDJUK2X2vp84zXQH8nNYOqh
         ZBsmFV/XioxweiYKrT2/r3vovVNXoCaUX00VyKdRLtcTqRpt741OCIBvnAtYZ9u4cAwt
         /VE0GfxT8YhWO1xqsMd+A12AMl3ai738YZyYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBQhUdnhsD8RfcUU30uApq8m70WZYUmsL7PCUmornGQ=;
        b=7nvKVA4eZKiWpx6LYY4swhyhFDIFblKAbxuVvAx/PqeZ9ndrWLZS51CYc8p3M4hZeS
         UpYwc6YUQdDPOxE9Pk55QH/GLuWy+HEdp8vCnJg9yP6QHwua65vnSynVSIyg5ZDRZVmR
         mPuEBQF+NZdr/CeXlRiBkfP3wWzQClh9my5b8mLOj5PJDleSAdmzUieesl20q88ILHJw
         YpGLCheWa7+MpZKTkVGEVUFyxsmNJD/0xRlJUv9d28GXJkaKhiWT6ogtRgK6Hzq+KMYc
         PMLdbOiBVNEy0hifkrcG0DaxgFcpbtQRYkZD+2ornIagpzcHmsP7qIi9wDPtsymQEh56
         av/w==
X-Gm-Message-State: AOAM530eBfWIy1FsCkieasnKOxbrfpZs4E8C1bcey2hi+Ztt04UH2rr5
        uMM22YU5QFf0h0WkOBpY2z/JwA==
X-Google-Smtp-Source: ABdhPJz5zO8JdHm6dSoWSwfIO1VWInEM6QBCKhwLgEtUt+tZNNicCZ5CqCgHy1wgDXemleJIwK7ewQ==
X-Received: by 2002:a63:2006:0:b0:364:56b6:868 with SMTP id g6-20020a632006000000b0036456b60868mr1093390pgg.493.1645682657153;
        Wed, 23 Feb 2022 22:04:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13sm1581760pfj.205.2022.02.23.22.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:04:16 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen Huang <chenhuang5@huawei.com>,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] riscv: Rename "sp_in_global" to "current_stack_pointer"
Date:   Wed, 23 Feb 2022 22:04:11 -0800
Message-Id: <20220224060411.1855683-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; h=from:subject; bh=2XfQlbZt/VASlkLb1MSCqElmqb6vbL4RS4z2QFk7tCM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFx/afSrkh8EYDR9D3m2YLzo8QsdHAeHLqKFsMf9L Ex0rEESJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcf2gAKCRCJcvTf3G3AJtYID/ 0R5bxSy2t3cd2QP9ELfq7URD/MGmGsTdjcoofRxSpM1eQZVOiBdeDWyUE+LCujt1n3EWeG9/KLdXHX /WQ95qcvvpE+17Eg+C5rUZC1nHPqEQ5TYzJhNsXY8rTBarxYZf099cwM2Wy/avRalVegpLM+goW0UV OHjqi4ZqHmo5oR79DpD//6hr1R6HEDxIYm2s78ssVhOhxhENJt3LmwqRl1AvpZfRusHp60S/QlKM3X XHH8Nvin/kjfTRPlr6DOGM1rcRVTBgPRTICC+upoS1B0P2v04wOCMEezgWviLq0x4URVJoik/xShCm LCZxmDp9D9FEY8fjy9oGP/T5H0oTdKvJSiDOvPc9daTTskU/zyoGTJLHlfnJ3reli9mCBct2m22LtC JlZ8eU/Nhhh/ja8zJghB2ag5+d0fD67sDPHNZH4jZkmbr0GY7JfRAdiWws7peBAprqURBGMslsW+q0 D1Qjatg8yvome9CgoujRVSBd0VznUSLKOEIYOqy9ZHT08XSHe3zWMH/xHwosPsbg5CF34jKh1uDlVE YLhkHVNCLjImiNXZGAh9hAS4g4son5YFfbbPnNT1DnPvxQN6dounkk7vIKeGD41EeyRiFEV5KrON6N wWEzFHPipr0uNzR4ddaOg1HZnK8+T5mGQYA0aNoK0hyBwwTGOBeYOqPaLE8A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

To follow the existing per-arch conventions, rename "sp_in_global" to
"current_stack_pointer". This will let it be used in non-arch places
(like HARDENED_USERCOPY).

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jisheng Zhang <jszhang@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Chen Huang <chenhuang5@huawei.com>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/riscv/Kconfig               | 1 +
 arch/riscv/include/asm/current.h | 2 ++
 arch/riscv/kernel/stacktrace.c   | 4 +---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..b120c32697af 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,7 @@ config RISCV
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_WX
diff --git a/arch/riscv/include/asm/current.h b/arch/riscv/include/asm/current.h
index 1de233d8e8de..21774d868c65 100644
--- a/arch/riscv/include/asm/current.h
+++ b/arch/riscv/include/asm/current.h
@@ -33,6 +33,8 @@ static __always_inline struct task_struct *get_current(void)
 
 #define current get_current()
 
+register unsigned long current_stack_pointer __asm__("sp");
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_CURRENT_H */
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 201ee206fb57..278380e2e956 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -14,8 +14,6 @@
 
 #include <asm/stacktrace.h>
 
-register unsigned long sp_in_global __asm__("sp");
-
 #ifdef CONFIG_FRAME_POINTER
 
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
@@ -77,7 +75,7 @@ void notrace walk_stackframe(struct task_struct *task,
 		sp = user_stack_pointer(regs);
 		pc = instruction_pointer(regs);
 	} else if (task == NULL || task == current) {
-		sp = sp_in_global;
+		sp = current_stack_pointer;
 		pc = (unsigned long)walk_stackframe;
 	} else {
 		/* task blocked in __switch_to */
-- 
2.30.2

