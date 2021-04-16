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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CDBC43460
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAB6613E6
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbhDPUjc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343890AbhDPUjb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC96C061574
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e187so7576786yba.15
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J/3dnbJfzRIYPiLZ29JeQVmGqxNfmSrQVz3MPRfXLik=;
        b=C1v0nYpduTETBzAnfgkloqCZcO6Q97ocPxTXwj9rz0cYRY1dSeCrIo8x6XrDSS122V
         VJjSz9XLtPk0uN1M0YsByoXHb8rT8SVmZvaEdCP+Xem1YERoiy+SeqmSQBJxMeJe3/dM
         /KbpqMGJcGAPkCNc+0HeMq5pSfKRC2vEEA4sLcaqdR8dZ5HuCSA1VpRTGjMcxL7EFAX7
         pS6bZvDioUkNGAXCeCLKq3cc9TQtXI5m1Wkt57+kKfk68CGbe4EnisAGXfcTr7MeYTaS
         fISLtNo26AcbMWxaQqaIJhU8AAfRWVDgpJCXhIfKMxuREyB7HoL5PvGIFu6lXVBc5YX+
         gxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J/3dnbJfzRIYPiLZ29JeQVmGqxNfmSrQVz3MPRfXLik=;
        b=icHbm1V5YxD65o9/yH49VbI3z09WXRF2vWxKliHjVEyoBvHHpaf1erpRY+T5/rwZfE
         w2jFkpE0fj+qEdtn+Zn2E+Uaz+nGaTdVPJ8R4hNF6GGSYELATdJHVEK8rr+O3RuVCrqY
         +scJBPZuGxh/2jeCQ6TXZPJkkFuWJct7UmC++BE2gjA2EQ4mdASFvDVh+UJIqO7pbmFV
         YYhglJ/J0B+7B5KG3OX78jL8nA3q4nmO15n8tj5R9yTOO6MdVuFsfeYNj44SDqP8N0vM
         UJHdSCY4sOTIV4n+cXW6SDf4FYZNfJcSPNcaqaZNwQ91NgvUgCKCyH9JlPOqSQPiAzX/
         OjbA==
X-Gm-Message-State: AOAM532qqF0aOU6UhDMe/iMn53s76+CAbwfYt4AbRiCdiuVC/JOiBhyw
        M4JGCIdOeWucNxqlkP57h1no9MXWDhSk900R/ME=
X-Google-Smtp-Source: ABdhPJyGkURYC9hpCmMRic8vWKlPFMV4UVmYBjgU6nnKa+YbMY5uJGuz8n+jOaVSP0ulbCEmSFkr4i0o/RLDruB8Glg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a5b:94d:: with SMTP id
 x13mr1332772ybq.368.1618605544016; Fri, 16 Apr 2021 13:39:04 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:38 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 09/15] x86/alternatives: Use C int3 selftest but disable KASAN
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

From: Kees Cook <keescook@chromium.org>

Instead of using inline asm for the int3 selftest (which confuses the
Clang's ThinLTO pass), this restores the C function but disables KASAN
(and tracing for good measure) to keep the things simple and avoid
unexpected side-effects. This attempts to keep the fix from commit
ecc606103837 ("x86/alternatives: Fix int3_emulate_call() selftest stack
corruption") without using inline asm.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/alternative.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6974b5174495..669a23454c09 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -496,23 +496,10 @@ extern struct paravirt_patch_site __start_parainstructions[],
  *
  * See entry_{32,64}.S for more details.
  */
-
-/*
- * We define the int3_magic() function in assembly to control the calling
- * convention such that we can 'call' it from assembly.
- */
-
-extern void int3_magic(unsigned int *ptr); /* defined in asm */
-
-asm (
-"	.pushsection	.init.text, \"ax\", @progbits\n"
-"	.type		int3_magic, @function\n"
-"int3_magic:\n"
-"	movl	$1, (%" _ASM_ARG1 ")\n"
-"	ret\n"
-"	.size		int3_magic, .-int3_magic\n"
-"	.popsection\n"
-);
+static void __init __no_sanitize_address notrace int3_magic(unsigned int *ptr)
+{
+	*ptr = 1;
+}
 
 extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
 
-- 
2.31.1.368.gbe11c130af-goog

