Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFE0C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9415D61A05
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353048AbhI3SHY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353054AbhI3SHX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:23 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B285C06176A
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:40 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id m1-20020a05620a290100b0045e5e0b11e6so14220049qkp.23
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yAjbLnc/4a+xG0iJA7167YzRctoMe7iQs3Th7exl8y0=;
        b=SvlcxRI3GX2nd8j9Q0bgxfBDF3ydh6ydlHg7K7EZljsvTET8asCVHOloFKQ7TRijza
         vN0HjN5JaVANlUkWbGRwoLqyCgaugjgFLtXJHICFTckU6s8u5Nw3D5IRqZLMoisvtJT2
         lwK7V/I2GkKyyR8M8zIipdubdj0hm5i89gRWQrdBh2hPr2MdTtfMRvAeGSHtTIvOdIhf
         ZgQHGgegg2kyvZYqJy9o/zJ24gjETr43HBOkQdJxZ72YKuNL5hp0p+5Nx8/E20tIzHQZ
         64R8fZAjx4IFoTPSPIENZysfkgVYoNGXhh3++DuTcKc8F+NymV7l7WKLPlMjk4zfml8u
         QopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yAjbLnc/4a+xG0iJA7167YzRctoMe7iQs3Th7exl8y0=;
        b=dFHGot7eoqQ9y9nXpoPDmQrLEG+XayvL81ieiZIUCRVjqZW310NHwqPuGqkVlcQaxu
         iCdI8NEjag7vxMkl/mBr5lVNmTK6NwyXTYJLo/AptKGTocZBzFRhZznW6I/thF4+M4/L
         I++GBi1JSLGldLX3L3vsu6eoOq0qKbwC4IPMvOO+buRXgdhuSB8shn4J32Z0rRMVmgJ4
         ctb94B1k+ZuczzFJQRtfkKf4Nq5g3r7l05zts2HeXO1KK1TS9WjYxGBKP4hAiY5v6IHs
         /ro0DzQNh5MnXOFZamMe1M0Lbp/DBB8onHFHs9O06lrlgNf2YI0DGn01PNuA/og6MPZ+
         aV8A==
X-Gm-Message-State: AOAM533MTN2hCeYo86qNKxFIbdIHSisVbnTzAkd7VDsrIRBFNBhmzXHs
        RrMJwv0aO1ePBzAiJ3Zc3XuZz89bdtiZIde0Jww=
X-Google-Smtp-Source: ABdhPJzSSSnwMdWUnZcSCWxApNcxtPczjvh4ogkn8fqf5fL6TvlzIOJjfdSg+b9xxcs7cfAmBGB0tTMcLHwNPjr9GOk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a0c:9d05:: with SMTP id
 m5mr5140529qvf.30.1633025139519; Thu, 30 Sep 2021 11:05:39 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:18 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 02/15] objtool: Add ASM_STACK_FRAME_NON_STANDARD
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

To use the STACK_FRAME_NON_STANDARD macro for a static symbol
defined in inline assembly, we need a C declaration that implies
global visibility. This type mismatch confuses the compiler with
CONFIG_CFI_CLANG. This change adds an inline assembly version of
the macro to avoid the issue.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/objtool.h       | 6 ++++++
 tools/include/linux/objtool.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 7e72d975cb76..080e95174536 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -66,6 +66,11 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+#define ASM_STACK_FRAME_NON_STANDARD(func)				\
+	".pushsection .discard.func_stack_frame_non_standard, \"aw\"\n"	\
+	".long " __stringify(func) " - .\n"				\
+	".popsection\n"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -127,6 +132,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define ASM_STACK_FRAME_NON_STANDARD(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 7e72d975cb76..080e95174536 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -66,6 +66,11 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+#define ASM_STACK_FRAME_NON_STANDARD(func)				\
+	".pushsection .discard.func_stack_frame_non_standard, \"aw\"\n"	\
+	".long " __stringify(func) " - .\n"				\
+	".popsection\n"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -127,6 +132,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define ASM_STACK_FRAME_NON_STANDARD(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
-- 
2.33.0.800.g4c38ced690-goog

