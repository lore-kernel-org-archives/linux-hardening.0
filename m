Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F2C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A27615A2
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353078AbhI3SHh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353072AbhI3SHe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:34 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35146C061775
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id cr8-20020ad456e8000000b0038251b6e5c4so11493095qvb.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nyhBoKfxi6FxDeRTTSmIOiquDaJDbE0FRQCKwRagYzQ=;
        b=T2lq5gRHvw6HVmjDdKTKIU1Ifpl7jyOJEawY1hRX4vNGm2m2nzy1S8ESeA2a4KNaxe
         xhrDFVZgVoHH7n5+D6FzMG+ADaHIqQfT5a3maFMxqN1us5n6zUhDM/4ui2AjQ/KXJaQC
         fQPzA4TJyo2y4De2ZswfldLfkLbVcxP3yYMEWGBpEZwvQO9/SJLW1/LkkgeDWdzCVDpw
         nyKxKIEzcgDsh/sRCZh3QnyKYWkZOA6Wpc6V+uhnQTPw7D9cJoRvBYcUYu4QH/bAcm6z
         e7AswDeOL40y/jPDduTFcfYjw7Y59rNsNbWUUVP7n2+DL39rBCbsI1hqyvNLKT6ngpT7
         bsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nyhBoKfxi6FxDeRTTSmIOiquDaJDbE0FRQCKwRagYzQ=;
        b=6YgHrFl1BjVmiPYcDwaFJlpdV9k/niyz6nxm3MjCbtFqzWPq72DoCmTL3siPs/rOXl
         BkqosK9N5PmmUB6nusFS46d6PLJf3y7XOGYrPRnB3fgcBaMRSO6aRMJlTCgL23xKNP07
         bE9HSeoLHIzKaMe7VwFPoCg+d+1tU8pSb2heRfoz1vUpx/HmkyAi5G6GQSBonnB3dO0l
         QOayU0oKqqm/11I+ObkUxxkFNh1j0B5Ercl23whjcQCPszbbpiTcF5DZ6fZnlEJgIMDE
         X6FMjHOspO8HpR5Kh3YxYqIG80GVYL/9pJ8eUc+596JJAgVV+YJVVgY3RV4IqV2gS9c+
         MbFQ==
X-Gm-Message-State: AOAM531r31WrX0fj4FVz3VWcYbsrFklLCeoZTFAS+P4+ULbedGqYXR6A
        cVVt89NBehPBgGsOV0BAFlWcP6gq9pcVk6QgKAM=
X-Google-Smtp-Source: ABdhPJww8bG0Sv/OFRh6ZYC4dDKnX2iWbaFo6aoQfxHbUGCC9B7YtHlIYDywb7k5TQZjobzIRlqWU7FhDhse/4Y7wIg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:5cf:: with SMTP id
 t15mr5253298qvz.25.1633025149389; Thu, 30 Sep 2021 11:05:49 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:22 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
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

With CONFIG_CFI_CLANG, the compiler changes function references to point
to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/ftrace.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 832e65f06754..67de28464aeb 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -578,9 +578,10 @@ extern void ftrace_replace_code(int enable);
 extern int ftrace_update_ftrace_func(ftrace_func_t func);
 extern void ftrace_caller(void);
 extern void ftrace_regs_caller(void);
-extern void ftrace_call(void);
-extern void ftrace_regs_call(void);
-extern void mcount_call(void);
+
+DECLARE_ASM_FUNC_SYMBOL(ftrace_call);
+DECLARE_ASM_FUNC_SYMBOL(ftrace_regs_call);
+DECLARE_ASM_FUNC_SYMBOL(mcount_call);
 
 void ftrace_modify_all_code(int command);
 
-- 
2.33.0.800.g4c38ced690-goog

