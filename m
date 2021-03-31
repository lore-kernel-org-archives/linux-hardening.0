Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90EFC43462
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 20:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A317461056
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 20:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhCaUzX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Mar 2021 16:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhCaUzF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Mar 2021 16:55:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A67C061574
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 13:55:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f3so198501pgv.0
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0iK0aKBdGLAGxgJdxBWHAkXtURWP8RQAHBQ4WEZMvwk=;
        b=O80I1qRYFis0QEP2XfUi5QmuwGvSB90DuMFYs9l/lstne+luBWTsr65uJ62iLDCgv2
         slT5RMDoy14coCsVm1pHTpe+LvkqhM8T5sK8yGxUIM5tCxXx5gKEqrkRknY6Ui9TtY6D
         6ZCgKdoapWBzd5Qw1n0MUItuc+10q7uZ3o07E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0iK0aKBdGLAGxgJdxBWHAkXtURWP8RQAHBQ4WEZMvwk=;
        b=q+iWNAkEoCnGVZdHipqJDkOgsxJ10Pw5THdPXC1ocGdVhzgu51eduSaP2Yfy0oSF0D
         QTux+RwR8KA5oEQg0dNpEOEHuksPzOVlL6GnLtQE9Y4BadFIYIhUtHmp8ciWFRnbPldh
         t/STzaWc496Eck3UWjb66LIcpmnW450XWhAKsMc1fINlz5EJ8x5omMeL+EpUpkzVX1gc
         ebHwoS1HGEpVJHSumW38XDkrp22MPnwSI/CH6QteYzEbD0Ps6MAiMMHzpYsN0YPYA0cT
         6vUTO/rrMi1+dDTWF9vUyvFWVF07w1qPi8G1oZoxsf+i9O3Ca6GCFb8Y8qsrAveKw7KZ
         vhTw==
X-Gm-Message-State: AOAM531rhhgr7j53YIywQzKbsMLBqztokB9lPEk2cWgPdMwzvkaztYSA
        AKdU/2yiKSYf/PKQpcgNZGUmQg==
X-Google-Smtp-Source: ABdhPJy8vrry5ttMzKtGDoFD4UGzGkIgQ46HazQu3/ypW9VQBUTkwCwIZh5vDLTDD+4pzAECjftiKQ==
X-Received: by 2002:a63:3189:: with SMTP id x131mr4749147pgx.430.1617224104389;
        Wed, 31 Mar 2021 13:55:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u2sm2931157pfn.79.2021.03.31.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/6] x86/entry: Enable random_kstack_offset support
Date:   Wed, 31 Mar 2021 13:54:56 -0700
Message-Id: <20210331205458.1871746-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331205458.1871746-1-keescook@chromium.org>
References: <20210331205458.1871746-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=5ebd0a02df09ef237ee07421c9f73e94deeaf170; i=np7yed3mY+gWIWkexmB7CyDLgwsIh0xV2RGaksJc7tI=; m=bWJ56lJBn9Ma2AQu8aultasTTfx/BX5M5azaoQbfD3I=; p=EuIQlileJ2PUD6W0Q1r2arSRAFiVT/zqDgDnM3BVsdE=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBk4aEACgkQiXL039xtwCZkNw//ZTC fulpMgUjuNgWy175nCejv7Wc89iNO7mwv3oe49PsJk3vxYrWhFCzNOqf8ugoiiSnKu9xRfG055szr UXVKBUlLHqnL0THQdqUL0ddQfXlt9q+qB68ymd9qG4ozNFG+yVPz5th3h7aSW0hgyCacAMpXUvYKL budGVJ8v+36mCTXk3+dvvge1jnAgXjE7koaMPJkT3FxUguHBgTDk0n60AJRpx4ueCx2agaQHrAigc w/E85CFRqmIoi34OyugPauXjPC9DgZqF3shzlNMc99j/6U/oqbiobU+u28MxNfMp92jo4Z9PoTuQM KeGS1zD6W40vE23+559E33uXQJyxe0594UmI9IhCcZlfSr+GJZYZ3aomxbLzoE8PWnetURa/qcQqQ igXIreq2mYRANLWPzBngbej6MeeLuwZ7AhMH+Xm49u3BkfJ/FKCVJkt5wDVQdBxu7PKENX7PxqmpQ FYA/x6zEIqHLrpGmScdyMqQXNO3roTcfGVxuFDS0Jds966MFfHZVkMmdcVk6YW81QK3QbrG+sNmDe fWHwhj0lHritR6K8xFwdp4VSgaxu0/ZOJGkiy8Ub4MhvPPBSE1admRVA7qfTlp4qu+39FgZGXNn8/ fHFWWBa6bbCIPGOj20ah77DM3+KXW+tWp0OpwhIpaRpAyinptUfyu7artSSMI3RQ=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Allow for a randomized stack offset on a per-syscall basis, with roughly
5-6 bits of entropy, depending on compiler and word size. Since the
method of offsetting uses macros, this cannot live in the common entry
code (the stack offset needs to be retained for the life of the syscall,
which means it needs to happen at the actual entry point).

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87lfa369tv.ffs@nanos.tec.linutronix.de/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig                    |  1 +
 arch/x86/entry/common.c             |  3 +++
 arch/x86/include/asm/entry-common.h | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..4b4ad8ec10d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -165,6 +165,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK		if X86_64
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index a2433ae8a65e..810983d7c26f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -38,6 +38,7 @@
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
+	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
@@ -83,6 +84,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
 	unsigned int nr = syscall_32_enter(regs);
 
+	add_random_kstack_offset();
 	/*
 	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
 	 * orig_ax, the unsigned int return value truncates it.  This may
@@ -102,6 +104,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	unsigned int nr = syscall_32_enter(regs);
 	int res;
 
+	add_random_kstack_offset();
 	/*
 	 * This cannot use syscall_enter_from_user_mode() as it has to
 	 * fetch EBP before invoking any of the syscall entry work
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 2b87b191b3b8..14ebd2196569 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_ENTRY_COMMON_H
 #define _ASM_X86_ENTRY_COMMON_H
 
+#include <linux/randomize_kstack.h>
 #include <linux/user-return-notifier.h>
 
 #include <asm/nospec-branch.h>
@@ -70,6 +71,21 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	 */
 	current_thread_info()->status &= ~(TS_COMPAT | TS_I386_REGS_POKED);
 #endif
+
+	/*
+	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
+	 * but not enough for x86 stack utilization comfort. To keep
+	 * reasonable stack head room, reduce the maximum offset to 8 bits.
+	 *
+	 * The actual entropy will be further reduced by the compiler when
+	 * applying stack alignment constraints (see cc_stack_align4/8 in
+	 * arch/x86/Makefile), which will remove the 3 (x86_64) or 2 (ia32)
+	 * low bits from any entropy chosen here.
+	 *
+	 * Therefore, final stack offset entropy will be 5 (x86_64) or
+	 * 6 (ia32) bits.
+	 */
+	choose_random_kstack_offset(rdtsc() & 0xFF);
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
-- 
2.25.1

