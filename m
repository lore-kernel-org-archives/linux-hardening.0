Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD7AC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 20:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380868AbiD2Uk0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380880AbiD2UkY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264F83B35
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so8365969ybp.19
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=svE7kVFxuPlWWXguE8ak9oGVScd1Q4Hw38uYtQTvTB0=;
        b=FUoFYj7nrytyx4SQGCiHW92ijRaq67I39GZlpyGeR8NTM7JBhSVqrSH5XEo6AC3s33
         6YkKHAE2q9oeFmrTKUs1tSYTJjtAN96i5EtiDUrkHTNJ7F9pNyevX/fqtpTVyhzDlRbo
         ygW8w7mnl/f/ac4KYXkyTVBJCPUQ7uLY5KreI2pr7rOjr0HziZOezs6YJb+DRgvxqmvU
         2Ojm1ZLAjlxdV9gK1KqwV4JtQZcjNXSEYjw35XVQqvPjpeqRn7S3FLFze1rSeIrqplFC
         BTe4KL/fuc79sjwROMSFVnl3eKltBCdAdu+AkyhU0liNzqOkDRw1+i7197CedoqcHGSp
         XPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=svE7kVFxuPlWWXguE8ak9oGVScd1Q4Hw38uYtQTvTB0=;
        b=RqRdJEFpBSZhF7jgPG9DyF3MdTUo0AlU+OfwUF7RlpIyzI/wOTUH9ocnYvIEhhuqbF
         u8glD3Y1swHSLlsTEJ/8eh8fYfCWYHpt6PtV512DNX+8Tt48+WnMd0naruB2BLcIBx1y
         x1AOm3CPHVQk8GUUhC6kbrbz1ihfIgg0rF9s21qRd6Zrwk9RrdlWsl4R7HWcyhivjU0W
         s29jSkp+KX+pkp5OHunkwKulE95SKjEk6lQd1jLEsWAYf5rvCiPrm/AZZRTPhssZntEx
         LmL6Xttbt31hhoU7mEj8j0Toa5J91vdLw++Pko9zDD0P6tMYINek+QSk+RleUpf5LL9q
         HaUg==
X-Gm-Message-State: AOAM531LIPKE3i4Un9GHiEsGqq/Z5c6C1sqOfZPYVKxscgoaXLY90Hpt
        EogST94Y1bKOD3EEVaxUDZFH2u1eV7yEjXlebX8=
X-Google-Smtp-Source: ABdhPJxy36VnWpTDmVaEj1n6wpH9g3bLRxJK7JnambFm4dQ2hqamT1j8SUFu5O05FMrvWlAjIaN1GHbxJVVSP4ly7Ts=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1ca:b0:648:b241:65be with
 SMTP id u10-20020a05690201ca00b00648b24165bemr1292760ybh.196.1651264620101;
 Fri, 29 Apr 2022 13:37:00 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:28 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; h=from:subject;
 bh=3j3iVyBHsh++mvfP+DxD8j3SrYI24EpoK/VyI7QxUVI=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExVHq3nlFPfzRWE27X7yYpyk4ANovqw9jbo7ZSD
 aCfwoPWJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVQAKCRBMtfaEi7xW7j1FC/
 9mpAG9wikAu1bkYBp0Lg/jv7Wm7fpH2DwKXLlccEeCa1pxSjoSVgx6wZkzGBqugwmN/O7ovT3GkjhQ
 eQ6wRcszZQ7fTIEvFK+vcaeg6XDDudg6DpaxZRR1dAMmt2yUCErrCLOe5tN/ft1R5yKnKLwGRHsYvV
 vUDHffcDPPv60LVfD+5wLq688gEgzU48LyD440gez0N1kY/vqObQpuQlHQTtBE/7qD2ulPR5JdMQu8
 st9Dh0JD/ATz/I1VA+tl38E7FpTEG0fkqECvMS++yK/JtdB1p+lWaUybht6V838s5BbAzbCBuCuG2h
 rAddbV72f5KNjs7b0k+EaHJ0fuNY9jPdM4AFqmgjTDBRmzBmkOUQ0U3lCDBj9dXLor5ywcTq2Iqk1G
 iUekvxJzPaoYKy4o2dQvYBH7YPC2qnSBfn+37GO62vDWM2ayd+N4wwOAQBmy23ARN3CsD5TKITf17Y
 OIawNg6pfn2v1zDPmU2ZUQnd5lwz6WXpEe195D//G1qwQ=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 05/21] cfi: Drop __CFI_ADDRESSABLE
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

The __CFI_ADDRESSABLE macro is used for init_module and cleanup_module
to ensure we have the address of the CFI jump table, and with
CONFIG_X86_KERNEL_IBT to ensure LTO won't optimize away the symbols.
As __CFI_ADDRESSABLE is no longer necessary with -fsanitize=kcfi, add
a more flexible version of the __ADDRESSABLE macro and always ensure
these symbols won't be dropped.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/cfi.h      | 20 --------------------
 include/linux/compiler.h |  6 ++++--
 include/linux/module.h   |  4 ++--
 3 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 4ab51c067007..2cdbc0fbd0ab 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -13,26 +13,6 @@ typedef void (*cfi_check_fn)(uint64_t id, void *ptr, void *diag);
 /* Compiler-generated function in each module, and the kernel */
 extern void __cfi_check(uint64_t id, void *ptr, void *diag);
 
-/*
- * Force the compiler to generate a CFI jump table entry for a function
- * and store the jump table address to __cfi_jt_<function>.
- */
-#define __CFI_ADDRESSABLE(fn, __attr) \
-	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
-
-#else /* !CONFIG_CFI_CLANG */
-
-#ifdef CONFIG_X86_KERNEL_IBT
-
-#define __CFI_ADDRESSABLE(fn, __attr) \
-	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
-
-#endif /* CONFIG_X86_KERNEL_IBT */
-
 #endif /* CONFIG_CFI_CLANG */
 
-#ifndef __CFI_ADDRESSABLE
-#define __CFI_ADDRESSABLE(fn, __attr)
-#endif
-
 #endif /* _LINUX_CFI_H */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 219aa5ddbc73..9303f5fe5d89 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -221,9 +221,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * otherwise, or eliminated entirely due to lack of references that are
  * visible to the compiler.
  */
-#define __ADDRESSABLE(sym) \
-	static void * __section(".discard.addressable") __used \
+#define ___ADDRESSABLE(sym, __attrs) \
+	static void * __used __attrs \
 		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
+#define __ADDRESSABLE(sym) \
+	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer
diff --git a/include/linux/module.h b/include/linux/module.h
index 1e135fd5c076..87857275c047 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -132,7 +132,7 @@ extern void cleanup_module(void);
 	{ return initfn; }					\
 	int init_module(void) __copy(initfn)			\
 		__attribute__((alias(#initfn)));		\
-	__CFI_ADDRESSABLE(init_module, __initdata);
+	___ADDRESSABLE(init_module, __initdata);
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
@@ -140,7 +140,7 @@ extern void cleanup_module(void);
 	{ return exitfn; }					\
 	void cleanup_module(void) __copy(exitfn)		\
 		__attribute__((alias(#exitfn)));		\
-	__CFI_ADDRESSABLE(cleanup_module, __exitdata);
+	___ADDRESSABLE(cleanup_module, __exitdata);
 
 #endif
 
-- 
2.36.0.464.gb9c8b46e94-goog

