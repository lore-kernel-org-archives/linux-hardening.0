Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7977C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07AB61A08
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353056AbhI3SH2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353061AbhI3SH1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:27 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E86C06176C
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:44 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bi20-20020a05620a319400b0045df2735d63so14321445qkb.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UPn3WtDbLCsbJwfnPoAfGXnHgXkJDxwgkdwnBZu0rd0=;
        b=LRSomAQTsHguWWIKiMw9RL00G2RwUJwWty90kpxqVCwzfIlu+csku0f3xJTJ72BD6F
         yXJ22lD7BN8EYgnROAkXZRaywcWzJXpqzXsLDih1PLHbwhivOr2f+PMAriDNh+MUeZOP
         BCfzOtSkQg4k+23cBSVoFXCUxo1PKOZKKI6nLGtBCUmQM28BvI5ySpHt3V+xhHmaoVke
         y/8c5MuDXtIcVFOK0LYzBdy2v3gW9BnfQ+0YsarknLZGD87mbIzFlQUBx3V2C7uN5GWz
         aRkaAtBBlCAJ2TXIaBGq/HcSEJ6D+ZmZyUgAgCRMXr9MaU+Dhc5FMWM922utY0OBExHd
         LqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UPn3WtDbLCsbJwfnPoAfGXnHgXkJDxwgkdwnBZu0rd0=;
        b=e7lYcSNvZbkMIyKCAijcmwtJi027ftc0DgHmMzdjqogqZtspv/8/KUuUvRIFjG165M
         dS1kBnKLhAfmKElFahYk4388G2L88LXP3XzKq06UJejPJaaLJSXTJBMuk0rSodgWoIjU
         PbfwINKauGSzHJJV4DGpUn3vP1MDIH2VhATFlt0D9ZHwx0DWlMgdAu0K4fufkNkDsfKU
         CgObHxetP6dijsVmhQi43PPzPSxrBkMw7cJCjIJJpaRWcpPcpgiTQBJtwxn9npUFjuUu
         sjDLjeiBqBhUaXYPa5ZTu8Lu93L53HhGEr9B0Ycyue/eNFFaurLXAlRT5hF3fWPEgfgG
         893g==
X-Gm-Message-State: AOAM532Z3qcMQohmGh4RBYqOPPl371+dDkVZ+WRZXi4GbGq5Wuxav4mI
        wSN6pQI8ELuBUMQcfRm9rn1mJiiQBf9WWbZcKQc=
X-Google-Smtp-Source: ABdhPJyt+DoXC8M8wV+eSBDlDe6RpKid8twadzBUYb7JQ4nxap7WFvIXyFpTNj3EkS84jhtbCdxnm7bYEDsu1PiKEJk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a0c:c189:: with SMTP id
 n9mr6585773qvh.5.1633025144137; Thu, 30 Sep 2021 11:05:44 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:20 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
which defines a stub function that immediately returns and when
defined in the core kernel, always passes indirect call checking
with CONFIG_CFI_CLANG. Note that this macro should only be used when
a stub cannot be called using the correct function type.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 include/linux/cfi.h               | 13 +++++++++++++
 kernel/cfi.c                      | 24 +++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f2984af2b85b..5b77284f7221 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -407,6 +407,16 @@
 	KEEP(*(.static_call_tramp_key))					\
 	__stop_static_call_tramp_key = .;
 
+#ifdef CONFIG_CFI_CLANG
+#define CFI_EXCLUDED_DATA						\
+	. = ALIGN(8);							\
+	__start_cfi_excluded = .;					\
+	KEEP(*(.cfi_excluded_stubs))					\
+	__stop_cfi_excluded = .;
+#else
+#define CFI_EXCLUDED_DATA
+#endif
+
 /*
  * Allow architectures to handle ro_after_init data on their
  * own by defining an empty RO_AFTER_INIT_DATA.
@@ -430,6 +440,7 @@
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
 		SCHED_DATA						\
+		CFI_EXCLUDED_DATA					\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
 		__start___tracepoints_ptrs = .;				\
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 879744aaa6e0..19f74af8eac2 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -20,6 +20,17 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
 #define __CFI_ADDRESSABLE(fn, __attr) \
 	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
 
+/*
+ * Defines a stub function that returns immediately, and when defined and
+ * referenced in the core kernel, always passes CFI checking. This should
+ * be used only for stubs that cannot be called using the correct function
+ * pointer type, which should be rare.
+ */
+#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
+	void fn(void) { return; } \
+	const void *__cfi_excl_ ## fn __visible \
+		__section(".cfi_excluded_stubs") = (void *)&fn
+
 #ifdef CONFIG_CFI_CLANG_SHADOW
 
 extern void cfi_module_add(struct module *mod, unsigned long base_addr);
@@ -35,6 +46,8 @@ static inline void cfi_module_remove(struct module *mod, unsigned long base_addr
 #else /* !CONFIG_CFI_CLANG */
 
 #define __CFI_ADDRESSABLE(fn, __attr)
+#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
+	void fn(void) { return; }
 
 #endif /* CONFIG_CFI_CLANG */
 
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 9594cfd1cf2c..8d931089141b 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -278,12 +278,34 @@ static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
 	return fn;
 }
 
+extern unsigned long __start_cfi_excluded[];
+extern unsigned long __stop_cfi_excluded[];
+
+static inline bool is_cfi_excluded(unsigned long ptr)
+{
+	unsigned long *p = __start_cfi_excluded;
+
+	for ( ; p < __stop_cfi_excluded; ++p)
+		if (*p == ptr)
+			return true;
+
+	return false;
+}
+
+static void __cfi_pass(uint64_t id, void *ptr, void *diag)
+{
+}
+
 static inline cfi_check_fn find_check_fn(unsigned long ptr)
 {
 	cfi_check_fn fn = NULL;
 
-	if (is_kernel_text(ptr))
+	if (is_kernel_text(ptr)) {
+		if (unlikely(is_cfi_excluded(ptr)))
+			return __cfi_pass;
+
 		return __cfi_check;
+	}
 
 	/*
 	 * Indirect call checks can happen when RCU is not watching. Both
-- 
2.33.0.800.g4c38ced690-goog

