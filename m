Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C648C433E1
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Mar 2021 20:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCCC619CD
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Mar 2021 20:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhC3U6A (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Mar 2021 16:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhC3U54 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Mar 2021 16:57:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53DC061762
        for <linux-hardening@vger.kernel.org>; Tue, 30 Mar 2021 13:57:55 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v10so12569117pgs.12
        for <linux-hardening@vger.kernel.org>; Tue, 30 Mar 2021 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7qD72PIIaKegCCfwDbGOQmh3vj9ZS1vEx5gz0J99Lg=;
        b=lGXEvcGvGErmybYZADN9M9vTPSUkuTyHObRGJdImdyjpniegEiRCqNXNuKcfv+NZFO
         N+oV9d2k2SnKMxRgXkmxzo8dDebK3nVnnQ5Q8P5TFtSSMDWaJcYW5IXBc8Cv2KnGqNUt
         83luJIQTk8q/BV7nZGYGpNRlKsYobxW9FikB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7qD72PIIaKegCCfwDbGOQmh3vj9ZS1vEx5gz0J99Lg=;
        b=tAP+jGyAlwxEKwCBCvu14+GLLS/rOLakCHSmsfKeGQSeAbjpOPUjSv35AuFByZ09/3
         8Dc7WLj1r5rdZ0ZqitqbrhfxkDtWw57HFvrJPJq7ENUXI0zGrSiGUTCDcjRlqxzMSH0Q
         P0lAbkLxesiHLt1qEez1mlRrueQpqq8kIZ2NZQN0iVMpr7vf2z8s8TmRCUlRcywgsaYR
         XxydTB0t4W2/1m2ax6W3FbRYJB581qp9cAlnwbqtbkFGgDFFeLIzVCDLvuDw+DGtjgte
         8a/qCVoY8e7EjPECRYve8IhAw2m8lA0x6Mc0T/2qR+aBNKsmYxdpE8O0QY/vy0HtyxSr
         BLDA==
X-Gm-Message-State: AOAM533JKr89Ol3rjbWyV302BPbjcvOCrqDCfjKYyTDMUBgoNs8oFcd0
        IxQ4Sl0bOq8aFvi0KRoLosJ3WA==
X-Google-Smtp-Source: ABdhPJxIlv/t8e+htb3eFAk1lSzIuiuO94bDCDl9IP1whq6yq56Qms3/b5dJBu6a1Z6nXeAy/BZ/nA==
X-Received: by 2002:a63:338b:: with SMTP id z133mr38473pgz.442.1617137875416;
        Tue, 30 Mar 2021 13:57:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d17sm13938653pfn.60.2021.03.30.13.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 13:57:53 -0700 (PDT)
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
Subject: [PATCH v8 4/6] x86/entry: Enable random_kstack_offset support
Date:   Tue, 30 Mar 2021 13:57:48 -0700
Message-Id: <20210330205750.428816-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330205750.428816-1-keescook@chromium.org>
References: <20210330205750.428816-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=5ebd0a02df09ef237ee07421c9f73e94deeaf170; i=np7yed3mY+gWIWkexmB7CyDLgwsIh0xV2RGaksJc7tI=; m=cc9SLz8pm+mdXOKZLHtRjH7FITDzwHCOKmwFrX1p7io=; p=EuIQlileJ2PUD6W0Q1r2arSRAFiVT/zqDgDnM3BVsdE=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBjkMwACgkQiXL039xtwCam+BAAgyJ fgr3/nTqZn/eYQhhvKuViaCBZLo6l/+H4rxQlTvedji1wqc8cEH1sbGhPpbetwvdv1E5URzjuzmHj KdNMLLG9GNPC46Kj+wXSF6TYDAjM5cN5/gDYo4VtCaToL0CpKQ7ckFQaxaTmeU0fNlFfPSnuB7lkI CiMSuRjNVKM0shhpfIRhpcbrf4pKGtVEI6S2q/Gbf8E9b9CqMBuY6Emsp+RP+E5pIV3MWV+/lWBzW nvw3ooLNtPE4eIIi144Y2qrQIg6kLUEm6bQcJNJ3P5Sl8tPGjpGmC6Na5y+jkQhGtJa8xw8iigpd8 0U/JPVq7sNUY3cC2zuUxjCQndMGeEMC5pqmPYVD5r5EfzWdLjVpna6rY1uIHVjapxIqa47C0SRTR4 5IVkd5ixH0ZqAvdCg7Kmse+MVEFltJ84/dvtt1jVcWTSD810k5uamerLnqHhOTMjxBl870hd23zNW hbNqvHuR9jfFcRe//CAXRojf+E0OfMXwE59pfcMCu+Bd2yJHWaVTzfom6Evz+EH+l/IKLU5TF+fEJ urdE7yT5Eyh8VgMnbExQG1evQIv9UuJeZaNZyqYOT3vycXyscwFxWh3hWDSlYRY7tyBdNfAqe+3U7 o/s2Y+ekI0WlMnWK52ZRX2sTdctKAo9wnnsvddL51SJw6DgLEPu9zjHET5nmRGG4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Allow for a randomized stack offset on a per-syscall basis, with roughly
5-6 bits of entropy, depending on compiler and word size. Since the
method of offsetting uses macros, this cannot live in the common entry
code (the stack offset needs to be retained for the life of the syscall,
which means it needs to happen at the actual entry point).

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

