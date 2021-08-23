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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08909C432BE
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E438C613D5
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhHWROx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhHWROf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB964C06129F
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f64-20020a2538430000b0290593bfc4b046so17018587yba.9
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+NWMVXrt3P4ge7VqYOvLEIp/M9aVwCe7Nh6ObW2ZBPc=;
        b=hFjJ1e+C1MlypS/buKfzRCFkG/9cMbUhkjqvF3HOWHEYkoz3N7NX8cJhjHTYQ/qtyp
         2tLkviVOtycQi/lT7Bqo3OcvF5r543o3HOh072GAdPadwN2fE/+AWc/LXwi7Khc8Iprd
         SbS56lYw5x7Hx6jf25yadN2fNtqR7HBEz8pcM0/wLAUYbWWpj3reFt5V+3jvDDmjFjFl
         DJ7h/D42e9VHIF14u2DZy+GdSTQ1NQJA0y9trOu84QKzNpJ294yMoilqnBZr1mHcW75V
         nIygPAcoCxwLFE0WK24aLTNS7BBsZvO+WEqh6pxAazj/ovklE/EFg5oIl7Z+edLMSGWr
         oWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+NWMVXrt3P4ge7VqYOvLEIp/M9aVwCe7Nh6ObW2ZBPc=;
        b=e6cJ5cjaT7QMXErWDao3PyZ32r5ZPNNDniQgloc76Pa73z3hckwLc/LYdDTadINywe
         7fz0BKX5IZfu5Yj1GFj8Z189bdzN8GvVJTKZ0cKxe5sitVtzx9S0ICYT6KQGAMuMsZUk
         Ow7+JU1+tTtmDheu/PpmZHfxnEtgDZsWRVyEe+G98fUPqOEN2lpBbSz3+58Co8wDuJi7
         jyAo5SpBQyL7w6v2oa97hWmjf9umPT4Tao/vSQRgWrQe7+31G05iTAuiRrCYSVs7hJO/
         5T+0V1+GdYD7ukoHYguFS/ZhrKqCOlyflzId23XTK/R9D3XlLznE1zxSX0I9Va8ZgveN
         2EdQ==
X-Gm-Message-State: AOAM532qIQIpdDx7dnV8FnEGQcMFAOWLWbx8xxNbJOQ0j0zyV3UbiAka
        /fJr2CL19ynoxA8HOYdRf8qbIllnqO4Epmuk4LQ=
X-Google-Smtp-Source: ABdhPJxClc9bFSSM1trVCieFK4BS23aESsI41IIN3LRY5ta0ot4fK5RLjCtUzOgKw0Vkr1NLBaaYQnrZtNnFvxI7zRA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a25:c60f:: with SMTP id
 k15mr26774743ybf.200.1629738832122; Mon, 23 Aug 2021 10:13:52 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:17 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 13/14] x86, kprobes: Fix optprobe_template_func type mismatch
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
2.33.0.rc2.250.ged5fa647cd-goog

