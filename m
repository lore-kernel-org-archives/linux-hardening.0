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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1BDC4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230D860E8B
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhINTNF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbhINTMv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C335C061767
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j4-20020a258b84000000b005a203c5e066so131407ybl.19
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b0EYrut/AMnqvvjXL4pjf9dWfm7AKB9fbO85nvqHRtI=;
        b=QuRKXPpb0p4VvZqUTrg1/JtXx9DPS0drlMlV/0qcrpX0pO4U/nYSz+tYk1ujhIejkD
         KUjt5WBJGivXZVD3BvcE9T95e5Wa7b6edeRs7HcucORjEBPHg4Ms+mONomYYhr3RdO4/
         2bmnQYaMR1inGzhBsPnQcT8f8YlOuqjpuzVpyK5Su48qulySmEnyA/UV8l1dK61CbFxY
         PzmgNHjrhpO+XWMowtXmy2+8igPbHZsVzxeZoPuk7hkBIA+3opkyoq+DI1Uy/RjfYVQd
         rFdNZqvtLUI1z02q4tXaCR9r7/ktKAp/pyrZ8zwW48AMcfXgptBraDCN2VS+V0w72gIw
         yA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b0EYrut/AMnqvvjXL4pjf9dWfm7AKB9fbO85nvqHRtI=;
        b=xxXbtJ/3AgKFUVwWi0OqYPZKkgfYaKqMhtqDLQvpYXmUWiDDpJpcksv53aQQQgdOWF
         9W4b+Mhfhi6RKWjK2iLJdPRNH0kRsrGZ9RFd70Qx+kwN2ThLGzDibhx0nIp4H7Iuhr12
         vyUuhd2b1iyWv+FTGP2NyI2X5TUCfAGKxNZBRr20tXAs5Qjr13ljzoW1EwJxh+Rm+5F8
         GUATH+F4/+AMnziXN8u+leLIeM3ocWX6CGfaHxvjlQKX+gT6wiXnWpFrb5dfMtpWIjcc
         fDe4vqzGDJPC3v0acY5XQ3s2Mq3Fk59FnEFUdy/Tw9HV58kHgbFrda+D8ErN+qDPkq0w
         HPhA==
X-Gm-Message-State: AOAM53171X9hSQxB1kuiROFMPXLviACxObc57bo4/t0kiblFhWE/0pNA
        PZD3bzAmPgN8Z/nAALcdvUFsgm9tV+QyoZQBGDw=
X-Google-Smtp-Source: ABdhPJxhp4NW539pWSgPnc//mdohgsLEl+VSRPA2sl17a4iU7q0uCjSiZtcbjOB2t0939rAsaF/3vGW+4CRTzpwXxMg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a25:5205:: with SMTP id
 g5mr923777ybb.292.1631646686506; Tue, 14 Sep 2021 12:11:26 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:45 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 16/16] x86, build: Allow CONFIG_CFI_CLANG to be selected
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

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled with
Clang >= 13.

Link: https://bugs.llvm.org/show_bug.cgi?id=51588
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e001bbbb425..0df0285d3ed4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,6 +107,7 @@ config X86
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64 && CLANG_VERSION >= 130000
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
-- 
2.33.0.309.g3052b89438-goog

