Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA0C433E2
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D9761990
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCSV3A (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Mar 2021 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhCSV2m (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Mar 2021 17:28:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546AEC06175F
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k4so3540827plk.5
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYr9wVtQr+Yv2YCxxAWFJhlutYOKWxR3zpP8Meqzwc0=;
        b=e2sppvO/nQd9M+oentUIs5EZBk1imYcO2Y6P9oesc5FiLYNAX5oQUh2eSicFEMB/1v
         YGCJGBJlY/OQDCB3klFA9+MjGrNwknRzu7lBP/9E5AQJ+MDfpULf7OP9Y4ckNoRmtBUj
         selUvH1rqIfKFKSdrXdWwzwTT5SotmIt+srGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYr9wVtQr+Yv2YCxxAWFJhlutYOKWxR3zpP8Meqzwc0=;
        b=oGXRRL4DaMHYcY1WT8dNcTcGeT3JTW4CjVlUZn7fHR6gtCZb9uj4d/rYOJ/5gSUxHl
         4wibC8XvviYpZduztGZL9nVaBM/oU0P7fyOmQHaJDcjHNkbAmH/+uSe/ei0EZ/hKMsft
         JY1+Ju2GCL51zqUNQU9qdLr67uiTXEGBdXjHNB5Tgc54f7/vrkqR5wMqjLKWaMAQPOKQ
         wzmmPd+fqfeU5fPhzwsp4fL5uffbEpmD8ej3MBZMsGcxBnJkYFyJQsn0ZERLXMEJa8lO
         l8DoPAN1iNgHpcq4m/IO9CL2cbyt2X5rjMKkBteObeAtBarVHk4GmV7ps0GNkaij+J6i
         2axA==
X-Gm-Message-State: AOAM531Gq/oY3ZmurJfsFHGISX2//egPvGX5aGfUuHWt/4ihWJHggVab
        n/WEEQ7ZnIvDuP5307nDdsS4Bg==
X-Google-Smtp-Source: ABdhPJxJZtzQQ9NDBHr8y2c9/UwW2oc21H/8qpcf3SLyv5Nzuq25MY5g8GZvru/n0ZnOUE0Nb52dKw==
X-Received: by 2002:a17:902:ecc4:b029:e6:1a9f:3397 with SMTP id a4-20020a170902ecc4b02900e61a9f3397mr16226370plh.9.1616189321892;
        Fri, 19 Mar 2021 14:28:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 35sm5758220pgm.64.2021.03.19.14.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:28:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v7 5/6] arm64: entry: Enable random_kstack_offset support
Date:   Fri, 19 Mar 2021 14:28:34 -0700
Message-Id: <20210319212835.3928492-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319212835.3928492-1-keescook@chromium.org>
References: <20210319212835.3928492-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=ab928f13a74b1e09ed2d4740c77a8520d58ab562; i=6FjHrMJQ1a03WxuPiMt8aIK5MW/T0bayLG0SuUm7Wt4=; m=DW/OKOjAEidoxl6ODEV6zN0c7U/uCvK1t/uZsIkKPaM=; p=MOQyOeWlIC4XP1YdIGtrtyC9k7Ng+ZO0cCzQ0e3ME/8=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBVF4IACgkQiXL039xtwCbbYQ//aKC RB12qKUepze20ovzs2yJf0dmT1D50yyLFxRAc+jTyXP0XLbJ4FjRRT5JBH295k/HwE1RzY8E/wyL1 MLQbIX8nGuPSmXw5HI2GnGFwyliiKJ2hRW1qIsIik2Ag5GvGzVxJUmnWTKSZYF5ZxgD1qDIPbIUSK d6iWA9NBX3CVxt5pfyvF11mo6rqTIRjrm7A2YBVh908KfXHgmoEPdeXcQ0Y6AQu4OsMcgc/b22hX3 PICTMo2idK40hULIHc4ur454arQ8xCMQm4eQnPkSxI9InUjpLeJFjKxj8xF37UooMVo8ilnQE2JYT VzuR9stuJol0kzVwzvrPNbAoqL9O2/GZtf3G+iGSNGDyYP8XMxy5jW6h9iODPfGxobtVZc1ggixyR hTXR4AWBQy0r8dEIxV5SVpTrosDo3oz5805pws9kIWS4APOy5B5JoYfLjXNcx//68bsB3aV8qOuv1 YIYF5JwCBED2+oXHJSsSEiUg5sMIrqwj/ya6rbLisnMFpkGqjj79IvMBantlGjtEYUfQ4mB0ykF71 BfjftL6zhB2qWfHdjx2E6gOskLK7aHr/GUprx8lp/9dL0O7wlyQ2OvT49GiwElYVO8Ym05Hgu14tM 3xqTfSxjmZSxhRT/qMds2osQ0KCcqoKGEGf1qC2WVjVbHOZDwQqpOVcoccPHRYDs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Allow for a randomized stack offset on a per-syscall basis, with roughly
5 bits of entropy. (And include AAPCS rationale AAPCS thanks to Mark
Rutland.)

In order to avoid unconditional stack canaries on syscall entry (due to
the use of alloca()), also disable stack protector to avoid triggering
needless checks and slowing down the entry path. As there is no general
way to control stack protector coverage with a function attribute[1],
this must be disabled at the compilation unit level. This isn't a problem
here, though, since stack protector was not triggered before: examining
the resulting syscall.o, there are no changes in canary coverage (none
before, none now).

[1] a working __attribute__((no_stack_protector)) has been added to GCC
and Clang but has not been released in any version yet:
https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=346b302d09c1e6db56d9fe69048acb32fbb97845
https://reviews.llvm.org/rG4fbf84c1732fca596ad1d6e96015e19760eb8a9b

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/Makefile  |  5 +++++
 arch/arm64/kernel/syscall.c | 10 ++++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b47a48a..2d0e5f544429 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -146,6 +146,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_PREL32_RELOCATIONS
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ed65576ce710..6cc97730790e 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -9,6 +9,11 @@ CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 
+# Remove stack protector to avoid triggering unneeded stack canary
+# checks due to randomize_kstack_offset.
+CFLAGS_REMOVE_syscall.o	 = -fstack-protector -fstack-protector-strong
+CFLAGS_syscall.o	+= -fno-stack-protector
+
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-common.o entry-fpsimd.o process.o ptrace.o	\
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index b9cf12b271d7..58227a1c207e 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
+#include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
 
 #include <asm/daifflags.h>
@@ -43,6 +44,8 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 {
 	long ret;
 
+	add_random_kstack_offset();
+
 	if (scno < sc_nr) {
 		syscall_fn_t syscall_fn;
 		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
@@ -55,6 +58,13 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 		ret = lower_32_bits(ret);
 
 	regs->regs[0] = ret;
+
+	/*
+	 * The AAPCS mandates a 16-byte (i.e. 4-bit) aligned SP at
+	 * function boundaries. We want at least 5 bits of entropy so we
+	 * must randomize at least SP[8:4].
+	 */
+	choose_random_kstack_offset(get_random_int() & 0x1FF);
 }
 
 static inline bool has_syscall_work(unsigned long flags)
-- 
2.25.1

