Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B17BC54EE9
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiIHVz1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIHVzY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDAA94127
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:55:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l12-20020a25ad4c000000b006a8e04c284dso6618ybe.11
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=g3Gq9NjDQ4hoNq7pf0wYq1hQ9S7+uZzv+7qsTdt2KdI=;
        b=e6ayS0gC7nTSB7sRK6XqhQ8PkPz9hlgp/RG7EOOdhWea6QvJiQZOd6p6yRF1NZYv/o
         vzQ7PUjvc1GQcMZf/RvGUwpu+aH8P3ZoExhuwot4Tu7nh4eE2MqU4XX/qfmC11xMEW4o
         Y/AZQ0xzwG2Mar5BAt3A1szuyTFm5NvUtfYqEfXV1CSjQcMQ3Q1HdqhaSkzso9vU/bfF
         2S9OU1oxlI5/swmy9dZQTjUadiVrICRahUR+1BkjvlCNWRfP9Mw6o1NCxiHcqC/FEK0/
         FLsQPDJso9Ylk5O0+Jzhs1qE+tMp3ptdqsU96cyzMV7BAd396uxnK/WHPUbXM9y+WcfA
         SKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=g3Gq9NjDQ4hoNq7pf0wYq1hQ9S7+uZzv+7qsTdt2KdI=;
        b=VQaS/dhIBmJ3s4MkRRqUE1iM0+uyFqBScdI/6x8WT/JZ7unKv9/1OLTi5bU1tYlsT3
         zz/XZtfLKUZD2yytO46ROBqbYw2Y8TuMct2Fg9H2Rv7n/ek+TusD20CY8+N9rQHE4j63
         NZr0YpaVF18wfrj5Nk6zEtLci6lIjo8UWDKjxgDL55xsX9SbouxP83u7EV4wuquRqbZ+
         A+/9FEmzV8k6q+7feECEOEUcdc/gXrVlcg+jI/8U8hcPq5HhP9QISqv10FVPSbXfyhwM
         QOjMZmujbJu3ugrrH/LUJy7ByrFUbTlhRCmCKcL7PzIgRh7oz/foBpdxczj6xcdPY5F9
         1vSg==
X-Gm-Message-State: ACgBeo0eb+VYyZDdj6cfzYRwQbkYGY99NcYwKiiZ0gJEKG1TeqpiZ1M8
        BQoLdW9whr52S03Nm2/5/3GO+i/XHcmoSzSFBnM=
X-Google-Smtp-Source: AA6agR4oLa4FfONKqbwF0FpWWwehyzcLO0uVvsqUFNdTCDrYLlJiXgNyonePKOhCzmHaZvZqc+/KvgSAGwpx0OzCFUY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a25:6405:0:b0:695:626f:2f54 with SMTP
 id y5-20020a256405000000b00695626f2f54mr9342982ybb.532.1662674117353; Thu, 08
 Sep 2022 14:55:17 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:46 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3358; i=samitolvanen@google.com;
 h=from:subject; bh=q6/maWZMNVpRPStuCMK4l2y855666X5QfHf+jlPyW9E=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmSzPgBZK/tC4vtUdRH53Ki3URAzr5yoqoKUBNEd
 9pDUmUOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpkswAKCRBMtfaEi7xW7qFOC/
 4zoXFSdT6EVd7MKSkn3bke2rRW5/QfuEhpApzfIEcWm7hYWqvt2j4d0/ZBv/AhDbpfAu63FzvtxKRe
 LIizJqs3rsDJZpaN8FOfE15jM5ZEhcW+XQhXeBb9cPII1xyUjI50Ewak9+QqMAhJKWkpnhCw0ZiuyF
 PkSvSEFK7IsX3rt9E5mGQHKwiO6tST5MVjp6wnXwKiilISNiFuddkn8K9CPBqsGqw7fPEvOYNlUNJw
 Lv8Z2wulw6ah+Tl2+nNV4fPFZsX3KFvWLh0DToEsUurPTa/RX3Is8GCXDKckNFqFTeWwc1UXH9mPuj
 yLGtLW6UtdSWrCAf8feKWj1r8dLd7yCN+z2mTGNfD8tXyUKkrV/e2tC1ZTz8xlxKGF1kJY+loYhPbr
 CsUhah3L7kmv88pnkFBqwxaBm+vHrXGYpar87u4ga69xVDbczil5jN333/KQnbR7bBNMtDdatTv7U8
 u3+F3CuQjOOfIUjzM2EfPHtSCxBwfwZJKRVf7tIBFv3gI=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 04/22] cfi: Drop __CFI_ADDRESSABLE
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
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
index 7713d7bcdaea..7bfafc69172a 100644
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
index 518296ea7f73..8937b020ec04 100644
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
2.37.2.789.g6183377224-goog

