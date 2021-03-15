Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548EDC4332E
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D9264F67
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 18:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhCOSDD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Mar 2021 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhCOSCk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Mar 2021 14:02:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C5BC06174A
        for <linux-hardening@vger.kernel.org>; Mon, 15 Mar 2021 11:02:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x7so7079223pfi.7
        for <linux-hardening@vger.kernel.org>; Mon, 15 Mar 2021 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYr9wVtQr+Yv2YCxxAWFJhlutYOKWxR3zpP8Meqzwc0=;
        b=PJ3T01c5ZmSw41q5MAxkemIUNEX541whNOtK/oVGkgDvEXke5s57A/1q9tzDzo+AEJ
         17TwxsQhxMpKr12YLaf51slHhYzShk72wq3LA7Tf1jp2ZGhrKU21lUBPzS/02MQjUN4a
         8BNS0yFQ9mNrfIeZXkahph53aQpbFJsZAfitI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYr9wVtQr+Yv2YCxxAWFJhlutYOKWxR3zpP8Meqzwc0=;
        b=bMAGTh1fa8vLxh7HCu2zoEMUSU5h92qjHeiAvC+OZVNvRNHOxZ+yDVALZr4kcwmvHq
         CjJCXviBVkfljMYcHEagvyVnOG8zWTyW24lR++9q5e+WOC6Pdz7OT0gejUgdGhAA1gX1
         PbygQ3TojGAMBeEug/RCNSzv0ioXqmx5aPsFdiQFpYoZPfysO5JWbfEGFlvTda6rCZSH
         ko792B8F+292QSQ234fwMOiP+tj9lkcJEgHy4fbum0mQOvxGV3WhyEA+FsycNOFNtQL0
         Ou8OQzCLapwRTvnwmurMMyQvgsFfFqK9jrYepgVfZL/zmrToTGpK8qusCfQlY00Xtp+n
         J8Iw==
X-Gm-Message-State: AOAM532XgsSDHdW+M2e5p0Vpz7zSiKsDy+DObIbaDH+j3V6u5xr6bMxY
        /LufOWI7v3mZqWVMDTH86WwF/A==
X-Google-Smtp-Source: ABdhPJypLz3rt4xSDEfwAQI69keGjt8wki/cYUqoCZg01pG+rs+SU3iIC2Rhxqq4jRLey7oHOmrHHw==
X-Received: by 2002:a65:6208:: with SMTP id d8mr260022pgv.365.1615831359582;
        Mon, 15 Mar 2021 11:02:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w188sm14531942pfw.177.2021.03.15.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:02:38 -0700 (PDT)
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
Subject: [PATCH v6 5/6] arm64: entry: Enable random_kstack_offset support
Date:   Mon, 15 Mar 2021 11:02:28 -0700
Message-Id: <20210315180229.1224655-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315180229.1224655-1-keescook@chromium.org>
References: <20210315180229.1224655-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=ab928f13a74b1e09ed2d4740c77a8520d58ab562; i=6FjHrMJQ1a03WxuPiMt8aIK5MW/T0bayLG0SuUm7Wt4=; m=DW/OKOjAEidoxl6ODEV6zN0c7U/uCvK1t/uZsIkKPaM=; p=MOQyOeWlIC4XP1YdIGtrtyC9k7Ng+ZO0cCzQ0e3ME/8=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBPoTQACgkQiXL039xtwCZ8+hAAok1 EQH02pRdoiRp9m8tbYTx8Kv8urKXluNaNLKQ8VjvRmjYSBNnvpTWI/n09jSnhzsXmY3lP9KFBiiSR vTF18ZmisLjVh1++NAWmL4zJNQExvXHxdxXvrzs6I0wIm+3ULPb+9DxBwwzeFIOlTC0AHfkarOIvI JPzaUMXvv+p+TiFW12lULVfRIkjZeTY8diwqSzXhh0Z+sJFZt0H5C9CzgjNlKMnNDGj2r4ie5i14O 4pSTw5xa/wRNzIDemET+Cl6r5cxlzMmyUnwKxL8cQl2HF2ysqiZFcCqUrsFdHWMiO8p9js8+hJjdr DnVs/0zGx9OvIObQq8Cs6RXEWpOQT91MbY6iWdLYoP1I+4vwxcR7P2bIm8kvDtL/P+YEVghQCMAi/ Nbw7LFXshsWv4OkJT8XZvnuYTdN/6HIL6Pz1V74YC5b4+90rxYBfG6Di9MIxsJk6X3QQh6+yznoDJ YmtysrTNSPGMXjKDJfs3f3yKIpWSePYSb9w6LZMFUww5o0vdipqLGAv4onWHWsatjKjTN7Qi8Qy2v z/gu45senClYLMA4IqByUxpO7K0pVhkjIJ9bCuGqylQg37zdDD/h9fh1xGKCCzDeGBHjt88zBIQy0 1RmtN5iz/6GO6LViI+zmCV5RpDsDtBtZA7ZIuS5jlamNSIEmDoQBVdxK0QuCHdbw=
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

