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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17903C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047AC60E8B
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhINTNG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbhINTMv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:51 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF8C0617A7
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:24 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u19-20020a05620a121300b0042665527c3bso675420qkj.14
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oDPSLYTnc85OD2zK5qomWzi0UW7SiJ+z2icJ5bfjJhg=;
        b=STkzKETErTPVmKYOecbZ+n4Oonaom47bcxfZ7rWtvf/ZTfGe6LuX8Tgj7HLce4Ua6Q
         OG2qeypPkfiD36/SOcQQU5jqXt7GbomkUkqhF21K0fRwu1UcWqPz87jeWFIYZHKiUs6s
         lhq9iBx72aPi+GzoDPhA7tzAqDBAcwpDPMb14VC3cw4jkrAa8dPCDGLFA6KNjQiC4P4D
         sVtmhtfEuhPRnUqhARrspLkXJFou/URwuQji3PPRL3blBy8Jz18yqncGgNw7hAo/d6ZT
         GLtxUETDxeY5XCdJjaycV4qNLXfH7LdVrNo2TskUGPaw9C0G7pOTcqc1L/W3OHjqcW5u
         fP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oDPSLYTnc85OD2zK5qomWzi0UW7SiJ+z2icJ5bfjJhg=;
        b=tj9NMC+GpgRGGz/utuxzEZaO/knpZ6gjWATGVON0J1PZcffXDW8VQM/TeXB8LLLmTR
         9qQjB2PlVBuuKFZMLVMkbJBUXtPNfVyQOsiJqkIoUhLxPNQuI65fdE0mVZqjRxKwOVxH
         tQbJGN+ouaa7JZLmLw2701oetRjGaAU/xMXF+LRz40hjdwWNUmvHXu3zNvuwyOhw2NTY
         3RV1AAwzZwNgtD9W5BiXUBIut1XomTGHZabFLM5YcN8DrJFzlW35McOmIqBKbQEdnHmv
         bPhh3b0MqH4YXmHJ2Ta62MWTcTicDQzpGodiI0FzyK9SkisttcKwHwBOO5vbnQlKRtQU
         xc3g==
X-Gm-Message-State: AOAM533RDxW0bhxRSM2lK6h3fCK1johhC9EOhzXfbbtIL8JzghiYSrtj
        9PBC95qbmvJGJx3CNnW/9Drq8nRR68/ZIi6ArfQ=
X-Google-Smtp-Source: ABdhPJxarD0Ys4etjeElxC7U2gHSsLCklNH/KUwhFdTxUDEpAFrBh7xOVz9ivuKAD790VfhUR5IxHgpQGQ12LOPUGeU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:40d:: with SMTP id
 z13mr5046584qvx.38.1631646683964; Tue, 14 Sep 2021 12:11:23 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:44 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 15/16] x86, kprobes: Fix optprobe_template_func type mismatch
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
2.33.0.309.g3052b89438-goog

