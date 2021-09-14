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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E60C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5E160E8B
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhINTNE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhINTMu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:50 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35FC061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:22 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o9-20020ac80249000000b002a0c9fd54d5so13830qtg.4
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fFCvJWug7bauvAerSk8DsPanFpmiKREnwLe0beFIomQ=;
        b=nD5XzlTypImdd/oPybicKlrz8zUhRN9g+uNSLkIczGQJR2I4tjNxtsS7NThpohf75w
         PUiFDcqyOnR9QiX1VMMiRtyt2Cooz7OGyEnta1g7hhOCQv3cl37zL5gtjc7f3aWvOc6p
         gvl1OxyIGiZbOgF121Umexe3usYciXcmOnsTN7IbjpJE8CdZXdzC+xO8nuNZ4XwTZPkk
         atgYAVTZp49mIbJRZbCCVXydFiaeO27Slkc0R1J1+nW2lQ8NVuKHxe+aXtBtYcvHG30s
         I6zB6XmYc9vvc1GmJ7McPMbhLE+Tk/4zvCt/A4AbtxL+q32suxpYQk70AA+BrjTmKmjv
         NNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fFCvJWug7bauvAerSk8DsPanFpmiKREnwLe0beFIomQ=;
        b=YHtB7LkVbHT6UpDo+rQubb88fnA8YsdwPsMz4GCcXEickLpYxh9t9lM9pb47vnHi9O
         TrZFUN4MHgcF5BrIxFaRfZWxYnOWuLN4GJxqh4yBwwp//wgI3F4Db8HEteD/bXwP5c1Z
         r2FAT+yj7KCDdN6pNx8E3azbO/aHffeNwlFBTwMwC6JUxxzz9NM9sREHt2Bxbx3y+2SC
         04ApRXounao/XWKCRcJk5QgU8ggw9DjSQLtFkYISpo9HfzBMH8J3+TwHPSMf8HM45ezP
         HIXL8unF0vI7aAPQ9JsG3zMen1eYDYb7GfYWYK7zMK8RI1nzEU6q3LOiBtd4cy1GOBkq
         A85w==
X-Gm-Message-State: AOAM532e1trj9ee28LTM9WRYps/mlqiNwNXoiXMgpfTw44cRD7RcIEeI
        OJEPwrnzyek9gaN3zsL+nwSKBZqMOZteUKVKbas=
X-Google-Smtp-Source: ABdhPJxUkEbd6MqiNa0YQikYTQZXHSQ16XBIBC4qHqf5VyvIYtbxinPvuPBdcN70cPLeaKLvMQ4B5coQCJnt+UP1ZG0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a0c:9c8a:: with SMTP id
 i10mr6916385qvf.59.1631646681262; Tue, 14 Sep 2021 12:11:21 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:43 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 14/16] x86, cpu: Use LTO for cpu.c with CFI
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

Allow LTO to be used for cpu.c when CONFIG_CFI_CLANG is enabled to avoid
indirect call failures. CFI requires Clang >= 13, which doesn't have the
stack protector inlining bug.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/power/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 379777572bc9..a0532851fed7 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -4,9 +4,11 @@
 # itself be stack-protected
 CFLAGS_cpu.o	:= -fno-stack-protector
 
+ifndef CONFIG_CFI_CLANG
 # Clang may incorrectly inline functions with stack protector enabled into
 # __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
 CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
+endif
 
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
-- 
2.33.0.309.g3052b89438-goog

