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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D1CC4320A
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4A7613D3
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhHWROO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhHWROO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55344C061575
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q13-20020a0ce9cd000000b003608f06491fso12841384qvo.18
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y1wIG3cVmpd4xa85rFblMllcZ1GkvMzjnLxgyrp1PBQ=;
        b=UR5N0BFHElSUkBSQFS7IRnWg9ye3xqrC5uWs8Q58L6k3/X1XKRNrA0b6ehi0z1pnnh
         ukv2NIX/yGhQHUQBIEnDv1+cIrOjwfFZSQ637+UhTmgo+C6lB8E4467KEsleaRyVuf8l
         LPm0vmMrIjXRI57/Cv/NSIuPQrsNU2YNe+BpyduzKpebsO4w79niuksN+bCJ7kh4+OXF
         gJIXP9xP7N6dZ5l1Y5lsws/L8BqOlJZx7r9BC2EaX5KnKiaZWGztILBnY2O1xs/dtFDa
         JcRF7rBXaSKygF4C7yECJgsmhIToViDgDVHmiSMFeskY7MXNZ7If7xfI+TUGfPl3JQNh
         KLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y1wIG3cVmpd4xa85rFblMllcZ1GkvMzjnLxgyrp1PBQ=;
        b=WbDjm0ldLWULJsPQbKGD4yj+6iMvo2k4VROigXVUIUGj6W7anEw+YHCHUZduNeeAqs
         4QkWpnvNBjPkglI67GGTXS/zDe01XNJ7tZX08xUL9fZSR5m/ZM0yMwT4TsbtJ2R4RcIX
         bQTZ1Qxpu2Q6aHQue71O7glI7UO3ctcTt3PFraqEIPT6Cm9rcf/8gzMmaF62Q8/lbUeY
         D0eeWW+Bz4kHXEJMfaMC7czhErsKFIIBNlwwOcmPo0JCBmJGZ7AI5JmDm81oAv05T6zB
         meunOv4wMq/z8ceqTI9AirL7kqbZiUrXJmN3Exi2Ntah250yJUpB2z78UIhjNs8bu6YR
         S+8w==
X-Gm-Message-State: AOAM532l6XMRueRUdxzPJZaiHBM3D6lju1aqnjnTotwcwgUPxkzJboZY
        mLSDkpM0SN77ybaaaB85ZDx19Jr/ACz7RYnOwKw=
X-Google-Smtp-Source: ABdhPJziyOvP+QWBDtSJeOoqGBazQWys1QijMPFocO7Y1Epuyme1bD5gJNucc356VALDlG5Je49i62tUqSF88NWcLqc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:29cd:: with SMTP id
 gh13mr33753444qvb.25.1629738810535; Mon, 23 Aug 2021 10:13:30 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:08 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 04/14] ftrace: Use an opaque type for functions not
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
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
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
index a69f363b61bf..6fdfbcc14608 100644
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
2.33.0.rc2.250.ged5fa647cd-goog

