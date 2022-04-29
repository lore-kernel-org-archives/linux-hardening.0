Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE11C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 20:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380951AbiD2Uku (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380896AbiD2UkY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503C58303B
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d188-20020a25cdc5000000b00648429e5ab9so8392013ybf.13
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gEbHgFs6lZ2lHqINgip3igp2EHgtJN39yys4lM28Yvo=;
        b=SaFVW3jXVx8M6aolNzkLVyQeDYZbzqRO7KWtEU0s7ci1omw18PaWzOYuK5758tDqgJ
         /pdjdxdei9jWmzk3zIw3oTE+XswiK7PorZHzgsq4bL1+VChgPuz0iC/N21WzcGY/qRM2
         6JWLbIrhTS9SAvQz7MMzKl0+WgH4XmbeFbiBh2+IVPL72dZ5iBaKryX3AN1s0hPVY4YP
         9bQt1yqW6LnkKYulq8WAbtjiiEhgkR1G+Rp0rnFrwV8hN5rsQYtFyb6s5lo8ZXCf+7D6
         +m7c1oAJxWXgtwRGknWfZgz5PiGIewZRKWdX5+TRIcmMl/JLQ64JSXrUoonAfSIFb+BK
         TB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gEbHgFs6lZ2lHqINgip3igp2EHgtJN39yys4lM28Yvo=;
        b=5AnzccQSJ7jatiVwZgaziEKFZ1yNzu5KnyZJwTAlnZ1mGRYKEIQyOZrjZIKlxTr8WP
         3aFFVaIz2ALXuZU2vSA9YOuosrbB+/8ot9CgTm9x7M9rvw3b+pksDzURK+cJCY1r1gO9
         GdRQnszaMutVFMoFcmV+G3Y3ODi09OBnYOwwNxVZiyQLaScTEFTJdenNh4/b+PZJ/B/E
         6ZvM+gXGgr8DRXNJOjnAjrFdR/gFhXfgYAw4aBMcwBc0viyv/9f8T7RTFNc1Nz4xEksc
         DHVCA+ykZaXxxnQL6ohIJeEm2xqGXyN5K+xMcnO2q8BcAAywmzbVTyhk3JajDsQiEB6O
         C26Q==
X-Gm-Message-State: AOAM530Z+OM4RUZZGOwP2Y8TAhSW1QD+a+uVOinC6hC9BmtmsCzr3ilo
        M/b7IfpDL3I/DE5enpshorf4EQAgqD9aPzMa2Qs=
X-Google-Smtp-Source: ABdhPJxgT/9aX0dsDa8KW+mzDJMfQTvkgU1FZElGfOjFMsqeYE38W+fgWXvD8McWD+ilA728NnLgBmCmjrnuTB/FeAI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:50c1:0:b0:645:8827:ccee with SMTP
 id e184-20020a2550c1000000b006458827cceemr1235151ybb.191.1651264624520; Fri,
 29 Apr 2022 13:37:04 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:30 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369; h=from:subject;
 bh=Og1wzH6F2UpL15DjmLD4N886OfryrjOOCzdPAdTewLk=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExWDDNV9KXYBM56nCJGHcU0XSslxkQdvoI9sPjn
 UaGSs/mJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVgAKCRBMtfaEi7xW7s4kDA
 CayRTWp0pfbkNNkWzA1sCM4Jf74dHv2rjrsx0M4Mu5sNdiCt2HqSZqZ16xxzlHJd3QA+Q/0K9CwUjY
 4ms0S0URAxH9BFNtjc2F9WTrQHV4OGR/ct8SM76W0FjA3jwqKJg4Rbaq636Ftg5FNF748bcjT1BogU
 N6yNWvZSXXQ62G7HD9dXV2ytAikPt71vmX/I7ly/kl6or31Z6G2Br8BUHs2zvPs7OgtfbOIRN/TgX/
 Z/f7/UEILECdxD84CZs9Hfe11i5gANBQmtBgyxURHHIsVe962bP9m+Zn3DDkuql3d+LlM3k1ZwgNfl
 sK2Kq1l4YRTLUcQNcgPXGemiFFX1lWzMxTYQwCzMfDeUlyaHVrs5EQR7ro7n7CEZv61G4bH7w4ysNo
 TAPIP8YcvmvYJaquDG+aMSVUwNrrDVPwRbjy0KkylxqzDhWqsDNhiBIdTK/HvX3PuPB6dxUU+UufwP
 +9unVtIcNlT3JMTufz/3caq6rKwQhkZ0mavOKMcl5DjVY=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 07/21] cfi: Add type helper macros
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

With CONFIG_CFI_CLANG, assembly functions called indirectly
from C code must be annotated with type identifiers to pass CFI
checking. The compiler emits a __kcfi_typeid_<function> symbol for
each address-taken function declaration in C, which contains the
expected type identifier. Add typed versions of SYM_FUNC_START and
SYM_FUNC_START_ALIAS, which emit the type identifier before the
function.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/cfi_types.h | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 include/linux/cfi_types.h

diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
new file mode 100644
index 000000000000..dd16e755a197
--- /dev/null
+++ b/include/linux/cfi_types.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Clang Control Flow Integrity (CFI) type definitions.
+ */
+#ifndef _LINUX_CFI_TYPES_H
+#define _LINUX_CFI_TYPES_H
+
+#ifdef CONFIG_CFI_CLANG
+#include <linux/linkage.h>
+
+#ifdef __ASSEMBLY__
+/*
+ * Use the __kcfi_typeid_<function> type identifier symbol to
+ * annotate indirectly called assembly functions. The compiler emits
+ * these symbols for all address-taken function declarations in C
+ * code.
+ */
+#ifndef __CFI_TYPE
+#define __CFI_TYPE(name)				\
+	.4byte __kcfi_typeid_##name
+#endif
+
+#define SYM_TYPED_ENTRY(name, fname, linkage, align...)	\
+	linkage(name) ASM_NL				\
+	align ASM_NL					\
+	__CFI_TYPE(fname) ASM_NL			\
+	name:
+
+#define __SYM_TYPED_FUNC_START_ALIAS(name, fname) \
+	SYM_TYPED_ENTRY(name, fname, SYM_L_GLOBAL, SYM_A_ALIGN)
+
+#define __SYM_TYPED_FUNC_START(name, fname) \
+	SYM_TYPED_ENTRY(name, fname, SYM_L_GLOBAL, SYM_A_ALIGN)
+
+#endif /* __ASSEMBLY__ */
+
+#else /* CONFIG_CFI_CLANG */
+
+#ifdef __ASSEMBLY__
+#define __SYM_TYPED_FUNC_START_ALIAS(name, fname) \
+	SYM_FUNC_START_ALIAS(name)
+
+#define __SYM_TYPED_FUNC_START(name, fname) \
+	SYM_FUNC_START(name)
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_CFI_CLANG */
+
+#ifdef __ASSEMBLY__
+#define SYM_TYPED_FUNC_START_ALIAS(name) \
+	__SYM_TYPED_FUNC_START_ALIAS(name, name)
+
+#define SYM_TYPED_FUNC_START(name) \
+	__SYM_TYPED_FUNC_START(name, name)
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_CFI_TYPES_H */
-- 
2.36.0.464.gb9c8b46e94-goog

