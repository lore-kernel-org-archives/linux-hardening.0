Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69344C432BE
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49187613D3
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhHWROM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhHWROJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C20C061575
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q13-20020a25820d000000b0059a84a55d89so2205358ybk.23
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lxH2THwhI3Qe5Ttkn8lFxBN9sgkFppCXnD9o+HEQt4c=;
        b=clXBTTvWafHptQxivAAs02Xsf78wzwIee94Uist3VB9hWv0u9+qhyaei+sQq4bLoD+
         HxTjZbNdSnKQ99oB3OjMTGaCYiKMmy+TIIVMTCJcuCl1wrEpVyWL282w4uOEUykR8tR9
         lCdvEYJXiG4PNueYtDqzea5u5mZkI2ZVKtfZnNjtvFuft80p8GpGUZY6XXif3YKCmjr8
         /kitQ9h0nTDwZpBmDx1909mY2zn26YqZ3jcVNQGvlwg4ljsteUeWmQUFMi4Iy/fobLdv
         jgcS83fxf1vj0P56X9yzLj8UyuMzZXbY6qAhugWiBNsZ8spGab+4+puJsPQzRdoSOpkD
         oZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lxH2THwhI3Qe5Ttkn8lFxBN9sgkFppCXnD9o+HEQt4c=;
        b=UnefA/nFtRFqbcbC0E+mV0wAZ/th+enfK3AtK2mnQEp+8uptdoBTXzJufQVf9o4P54
         vMjuK5doGV1y3C4rvLpyHUdW9y8X2SuRbkuz30I4RncVXV1RAOpSUJ0gEZ8NXG0X2edf
         6xgGhsDCTZhEimr2efbC9QJVMzeXSJPuF6xWWftBM263GB4CB1x0rMgfOHJdlZiL+idy
         mStsndPZU/duNe3WG6UUxrRmZVQP9mqIFjU3x/0lRDgzoC70hOf96YdWIrLAj098Y0d8
         azm7eL0Dqcdp6gJX2wxZ8Sggvz1EJTxBoeLT82114zLrjLmHAuvA6z/7XJo9JARWO1Xz
         M9lA==
X-Gm-Message-State: AOAM531pwbf/CGvwy4hj0YfmQYHLIFxwzXo+8FFaGeDH+JY2MFyHMj56
        VkIAGy7zJniu6rFWIROcl+hHmSVTn2G6pClhvYo=
X-Google-Smtp-Source: ABdhPJwgJassWTX4IPyN5BK8l1pmUGCxuEHsXyQ/l7/G4vVmhHnTk/ei6QPYEFZdD9Br5yoU1X9TevDOttzxSM4cZ9E=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a25:74ca:: with SMTP id
 p193mr6595783ybc.28.1629738806054; Mon, 23 Aug 2021 10:13:26 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:06 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 02/14] objtool: Add ASM_STACK_FRAME_NON_STANDARD
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
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
2.33.0.rc2.250.ged5fa647cd-goog

