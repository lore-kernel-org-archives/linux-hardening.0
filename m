Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A3C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 13 May 2022 20:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384174AbiEMUWq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 May 2022 16:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384134AbiEMUWm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 May 2022 16:22:42 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57B6165D44
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:18 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y73-20020a638a4c000000b003c63424fb3aso4664454pgd.17
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f+v85zCmompJWMzZo0Lo44MXyCG4blaViTEubU7Q5pk=;
        b=MESMouEFY2G4SFqcafmefQWoFCP7ps3QB1tZ46af/jtYe6cn5zcxOwxTwft4N8E1NQ
         +UuIHuj5VEcDhbnPdN1c0OsP0m7BBsr8MIip1QKYnYg6zeoMy088Pl9eVtEl5uK0saGo
         XtR42j6pIymFijnyo6XcDzAed95J3W7UJ8IviGf6zqWy//NvXfkBj+GJVwnuCt9lcOFH
         Z4nLVMl3mKjxxgvlkFCBZewyyE5+nMu5wsw21EWC3AA96x/4tIfvIZsY75Roh12akrho
         avQ626Wx3RZtmrx/IEAGQSI1UB2H2FZgt4JgCTLLjEpfu6Qdx7RMgQixkMV7q4jIt2ca
         yN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f+v85zCmompJWMzZo0Lo44MXyCG4blaViTEubU7Q5pk=;
        b=2LF4DyTeXH7+qJ0z074twPTidth9fW0sDRBb2/xZ1gZBeTmSmqAFXGQc6bEzxlyMeN
         fqfvgRll5/C/pp92ijcXpQJ6BVfZ6r4mSgVdzQ2v4l/KjocIvgb5g+Clt3yM83rhyyNe
         HrJvl7UE0/LgWMBtuX6XU5mLT0mHdEb91DkhNnaittXHsVw3psd0KrPosTMCkRWOEquf
         ED7eXx3Zxk3MqoWvCmagnlE2Ilx5MDkl3i0ierX4eZloz8gqAo31r0Brmhyu6AzV3XtE
         E78212KoY7Hk0w61Dj3PkLBv59xC4bC/WbA98HUiMvCy61ZFHHDrmLEUVh6VCq6hKCry
         eBFw==
X-Gm-Message-State: AOAM531szqA4DTi9uRKXRm6aMTdUbO38Vzu0HCqIBj0oSUmGZgPQtFZG
        uzDh+nAei4bmX3goatfQ+2oRlePwMTfwGzw984Y=
X-Google-Smtp-Source: ABdhPJwfcFjFJSZbXy4dFXWlYx0UTPoVmJGQDFAqlwZxMLFtphKEHH2VS3sWnVMuhcTFKwv+pj6ccI88tY8WuVvcx7E=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:aa7:88d1:0:b0:510:3ee2:3f25 with SMTP
 id k17-20020aa788d1000000b005103ee23f25mr6048858pff.41.1652473338024; Fri, 13
 May 2022 13:22:18 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:45 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369; h=from:subject;
 bh=TboG0ryIg4JgbMTsV2OXgx0SX/UFOnu1UldMJxVt8Po=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3j4WY4BkbqYI6dC/ZfJbPOV8T4fFdqndEpsBM/
 hV5fbI2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn694wAKCRBMtfaEi7xW7gMxC/
 4pxFRx4HmL+KUme/ZjGLLUnoT9FbQCcyon3/8qR0GI2jddZNW3zIDnAihW+p9AayVGcFBw/cucqeD6
 aXfUmw4i5Efc8tn7VJtIfgwBMJEeT97CO0koKO1cJfqhLgyPXQDEp5x3qbmJIPEvXkFbMwd9T0no37
 HPRxilpeC2rxuO4N07WfXvHHMyvz873twQyminhgkImNDn8LWrzNZD2TYLXYTmCSbYCFGu5tXSDEhw
 ZHK28QweaPZFMYbk0wN8AvV4LKrTN0/LJoOuYP485lixfm/DeCd/25TzV57VDBt4ZfW/VlEHh4RkgX
 cFHax638u12jlXDQHJK2SS7MLmlojw27IhKgnEszme11T0yFry4yEqhhcfa1m4PMtHA6DBWFAZjYwA
 CCw/0R+hbTncTA8X3SMH0fWDvX+13ZsaiGA+rH7eLAG+M6F+T6JF6K+96BK3G6xvoablbMV270wlb8
 +GZCYAV3P1rotvaWrcFV5saGNcr9RR12T6hfVDEQ+LtAA=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 07/21] cfi: Add type helper macros
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
2.36.0.550.gb090851708-goog

