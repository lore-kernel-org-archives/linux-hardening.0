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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E0DC433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DADC60FEA
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbhDPUkB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbhDPUjp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF246C061756
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:14 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id x7-20020a05622a0007b029019d73c63053so6763251qtw.16
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FPDsGN9VxUr9HuESYx96922vymwwzjs8QWYi8GhO73I=;
        b=NTYpXeosNimRBGGmucRjoE00W8NM0Y5fsJHRXZQ2FQwcxJabVh3LDoPD8NbPRSXsQe
         +XIZw3ebF6vfwAHwaUz1pwLY7KbMlcVILybOnArv0MRqzZ74UeaLk6AV/wCjzfbun0hm
         S44xFa9RyuptHOgznNTCr+cI3BSxBoMQyk0Zo7orsLdLFsYGBRJCAwd57qULlZnzii6i
         AUgRhhN3hgRuRfGLpEEhYm2OUUvv6vdBNk5icg0znV2/GZwZ9kUUC0jEFDqVKIbwa/QX
         dd6wxcIZKNZ63/v3+WisYQEl2Ar2rFyrjD+HMswTMc1pM5HJAtTlXX7LZqep5l5iEweD
         7nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FPDsGN9VxUr9HuESYx96922vymwwzjs8QWYi8GhO73I=;
        b=cDc06cM7wVC4xTGlsnKnG25ncO2I6ZDs4S5HR4uZFhapgKf1Ji0mUXoj2WzaKYPYXR
         rm0nT00BZucH3PxiPPwTdAzy9poE10LHtIan94+f1l+iMhALA+WQ7Jc1U/rQtjAQdThp
         FLgiIGnhgxYwKmyBmT35Yrwu756GQejnwEnIb5FP59H+29NgAa4dqcBYFd5pw6unAKIV
         zHkkLcx6x19QwEnCFCgbDpZhl5F1G8JIGmIfPOyJuUGo86a842b0P17tRxWuvgCDv7em
         9Fb6mahCkEFvCh5/oBadBLv7hJHuMYHjfnMTDjU7B+1GfA7TsAulhxYmYW3mf3C1FLin
         PTog==
X-Gm-Message-State: AOAM533IPfFVaTyr/J0FtKXAujAsq8K0BRtFvhTcvxlnS2XecG+Th9mF
        Kix9CyDXyrIaruPDlgRN5OlJBR1KgfuvreRC/w4=
X-Google-Smtp-Source: ABdhPJy2b1+yl10yJE5fG8RWtCYAtcoZXXH3wjGdxTjWEEgcZSrEnAK7qHMwYiCcuiK1dRZgW1J8K1qp6q+4EcdFP3c=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:19e7:: with SMTP id
 q7mr10609949qvc.34.1618605553952; Fri, 16 Apr 2021 13:39:13 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:43 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 14/15] x86, kprobes: Fix optprobe_template_func type mismatch
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

The optprobe_template_func symbol is defined in inline assembly,
but it's not marked global, which conflicts with the C declaration
needed for STACK_FRAME_NON_STANDARD and confuses the compiler when
CONFIG_CFI_CLANG is enabled.

Marking the symbol global would make the compiler happy, but as the
compiler also generates a CFI jump table entry for all address-taken
functions, the jump table ends up containing a jump to the .rodata
section where optprobe_template_func resides, which results in an
objtool warning.

Use ASM_STACK_FRAME_NON_STANDARD instead to avoid both issues.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/kprobes/opt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 71425ebba98a..95375ef5deee 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -103,6 +103,7 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 asm (
 			".pushsection .rodata\n"
 			"optprobe_template_func:\n"
+			ASM_STACK_FRAME_NON_STANDARD(optprobe_template_func)
 			".global optprobe_template_entry\n"
 			"optprobe_template_entry:\n"
 #ifdef CONFIG_X86_64
@@ -154,9 +155,6 @@ asm (
 			"optprobe_template_end:\n"
 			".popsection\n");
 
-void optprobe_template_func(void);
-STACK_FRAME_NON_STANDARD(optprobe_template_func);
-
 #define TMPL_CLAC_IDX \
 	((long)optprobe_template_clac - (long)optprobe_template_entry)
 #define TMPL_MOVE_IDX \
-- 
2.31.1.368.gbe11c130af-goog

