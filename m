Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467DFC38145
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiIHV5l (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIHV5F (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:57:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00A1316ED
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:55:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3328a211611so154257457b3.5
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=FOdYXA0ZEZeFGxTEMOy2snMybODZGQ47ZcBKwefAZGA=;
        b=GCSdO2MEVxK9Oj8yCp1RL84HIPE9phdOwXrJh29yO/AXhQFcrwmazIXaEN3Vvc8prJ
         7ibgUM9AZ7+foHp1KylElJCOy7X9yOqmNEoW7PKfHsZtniYmCw55qKU76hK8tekk5OV/
         rpRwlF6mZtZnitdMW/1TUt31NjUvXIKRx+OAAPaaAbd22IQE9mjLJJALlVwP2x9d3FbP
         nobraqTLx7PMNnEsmxmWnHhZftRCorEBcPUzCc0FU86A2ew6qfEdVQQb0yplG2HmXB7n
         gwXnVTHME+tj6Ho+35AFVkeKPDjAOgSq/s8Jm0l10Zike7UShj+w24OW5yulnPF/YWgB
         l4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=FOdYXA0ZEZeFGxTEMOy2snMybODZGQ47ZcBKwefAZGA=;
        b=M+cvR0bytL9o3SmhTPeBpvkpgn0hoEswfS3R80KF+lGf7g4kZMeXfwxzwudwVVSr/9
         AqAXFH/Tx+pX5A8TUHnXs7ZCxHO55BCuQ05svyaIA87r9j0TGdt4jlP/quiTx5/Guf0R
         GGIOwDF943t2Uxo5DT+UqcCOWkBFjeDmqtD407WSMaZAXzUwzmSsdqvwUX5jHxXqAGIu
         Yb/r4+v3Q2qyV8vYDx/2DgHGOrl38OXPMxdm+nDln+0g4YqJRJ5NZjABFsHIAUqXH8UG
         Kj35qR0VtdRDBRS4ir1fgHOtmpUgeTyjxleMWlCWPCkPQcqohm4d62b5C9Jqnhto90Xz
         lV2A==
X-Gm-Message-State: ACgBeo26OJEhb47CdZ4fm0TSuC+Km/QTqQQS3vGip1HBgKDMQdka7f7Q
        JbBTL9Cufv7l915rDqmqhZQx6VmwPmYuhWfnfBk=
X-Google-Smtp-Source: AA6agR4cwjBEM5ngeMz8OJhUS51aCH+VLhWHgGYQpEix4smq/bn6oTZsK/+QG6LhZrt8Fuq/YMF07fwi7CBwTNUFS8U=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a81:5443:0:b0:329:cd12:e96 with SMTP
 id i64-20020a815443000000b00329cd120e96mr9699307ywb.68.1662674159576; Thu, 08
 Sep 2022 14:55:59 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:55:02 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; i=samitolvanen@google.com;
 h=from:subject; bh=TQl874bpqor9ywOwc/gV6IgIv3bUozCx00xHJLAs6To=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS2MZhLrVqCh+oVTKnuRWIFqHKJ0AmFaxnTOHKh
 baPVjUaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktgAKCRBMtfaEi7xW7qOnDA
 CmOfqxEdlesooL2UZiKRNbfdKmUYKJEkWYpZ39pIT4gX5llHPRn6ulSLkNp/mpKf88x/xhOklD9zlH
 GiLtZYFS8G8/uqM9YX0g5f2F4ep4e0WopNmnCl0DDaTTq8GwNtlmEfNaQHeZCcSBJww6He/cMp/Ek4
 lEZ0hLPA/m4qmzQ2GE5ZIqSBcloIoDguBz6X3Kg9m3rtsygaxc5/SrDQLqup2EhKK5G8FteV02jRgR
 CLIT0bxMG4+1eHVprQFdIAIkXReIiwySwVjaptn/WRx+Ky++ixFr+AQvmyRL+zPb0b3Z0H5RqKNMxD
 ZB8QlSghcEMwJdLW1QPU15rd6hUXWmIYz3cJdIjzotbK+4NrKYL2irVmwVJ6U1GRxISLh00K5ZGOXv
 w2rq6rP3uqyEX0O1uf2ZEOUb62+cdJ07dG0qCuXfCftAp7XvAgWFdtcbeA072ywsoMQaZrrooGxNMP
 MiWdBTEFRIWOc9uhAD+adP4VPsCu6//QntQqutTSkPLPQ=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 20/22] x86: Add types to indirectly called assembly functions
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

With CONFIG_CFI_CLANG, assembly functions indirectly called
from C code must be annotated with type identifiers to pass CFI
checking. Define the __CFI_TYPE helper macro to match the compiler
generated function preamble, and ensure SYM_TYPED_FUNC_START also
emits ENDBR with IBT.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/crypto/blowfish-x86_64-asm_64.S |  5 +++--
 arch/x86/include/asm/linkage.h           | 12 ++++++++++++
 arch/x86/lib/memcpy_64.S                 |  3 ++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/blowfish-x86_64-asm_64.S b/arch/x86/crypto/blowfish-x86_64-asm_64.S
index 802d71582689..4a43e072d2d1 100644
--- a/arch/x86/crypto/blowfish-x86_64-asm_64.S
+++ b/arch/x86/crypto/blowfish-x86_64-asm_64.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 
 .file "blowfish-x86_64-asm.S"
 .text
@@ -141,7 +142,7 @@ SYM_FUNC_START(__blowfish_enc_blk)
 	RET;
 SYM_FUNC_END(__blowfish_enc_blk)
 
-SYM_FUNC_START(blowfish_dec_blk)
+SYM_TYPED_FUNC_START(blowfish_dec_blk)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -332,7 +333,7 @@ SYM_FUNC_START(__blowfish_enc_blk_4way)
 	RET;
 SYM_FUNC_END(__blowfish_enc_blk_4way)
 
-SYM_FUNC_START(blowfish_dec_blk_4way)
+SYM_TYPED_FUNC_START(blowfish_dec_blk_4way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 73ca20049835..f484d656d34e 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -43,6 +43,18 @@
 
 #endif /* __ASSEMBLY__ */
 
+#define __CFI_TYPE(name)					\
+	SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)	\
+	.fill 11, 1, 0x90 ASM_NL				\
+	.byte 0xb8 ASM_NL					\
+	.long __kcfi_typeid_##name ASM_NL			\
+	SYM_FUNC_END(__cfi_##name)
+
+/* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
+#define SYM_TYPED_FUNC_START(name)				\
+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	ENDBR
+
 /* SYM_FUNC_START -- use for global functions */
 #define SYM_FUNC_START(name)				\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index d0d7b9bc6cad..dd8cd8831251 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -2,6 +2,7 @@
 /* Copyright 2002 Andi Kleen */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
@@ -27,7 +28,7 @@
  * Output:
  * rax original destination
  */
-SYM_FUNC_START(__memcpy)
+SYM_TYPED_FUNC_START(__memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
-- 
2.37.2.789.g6183377224-goog

