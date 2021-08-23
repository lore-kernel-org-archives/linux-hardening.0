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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63983C432BE
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9D9613D5
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhHWROt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhHWROd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:33 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCE6C0613A3
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:50 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id m10-20020a056214158ab029035a6c1e5f3eso12823319qvw.7
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QdQnBYBrTtlb7EbgqCKiS4RqSCRV3iiUzEvkTpjIQRc=;
        b=UKMKXPgsxPVJpHWknSOnrvq5i4Af2vp7VUEDXYmudNQxKlaDg5IP44KGL2ICHIaAUP
         uS4jHYeVyLSsAjIfQZ6EyFjp1JJmN+baPDYfljZpOZIJauKPyphJMpHd+iMjbDn0AyIi
         IOCvKaGjnwYwuw58SENKcTnoZzIxwQCy24omsw2lavoQvMTxZQwK5XjaKvA5YK/he5uC
         oTrVJHC/225xqnIgTFAaIcMjFMx3zZH6Mf/bV2SU868O0sfnMpoWHIz5WoOJkPCtIBkJ
         0khvTREPZ/R+rWMzOEpZc9+m/YzzAa92daDnajT24DMe18qRfuptLrte1KBXnV2z0Ic2
         s4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QdQnBYBrTtlb7EbgqCKiS4RqSCRV3iiUzEvkTpjIQRc=;
        b=je5V0TUxIh5tnt/Lu6s6a4cbf0WRLjZz3iAiY+L7+cNnvCPyxkhGMtYv7CQtUvFHgB
         ASLpa2StJH6huD4CXL14SVfaFB8Zs2BrnPna+68b8BhapyEV2EYkpSNPkJGAnszV1JnO
         NaiJN+wntwIDQG/99t1fPwzz9GGDLkgnNlCK1LiEuJKNe2lseel90Tb/f4dJUyI3KROE
         gwB2L2FZiQu4V3IBp6BzJ4gI5sI5gM/UW17xy/f2XNBzKM74Uga0Z9oTW0c8QQ2CGRgO
         IMveB7KJcC/N2oad6WNCuAvErFUEYFSIbkFHHis0TnxbUemggP6JCtI5GHkEiRqUXSqh
         DTZA==
X-Gm-Message-State: AOAM5303OkY98IIg6GcwskCGwbCVBc7foIxdWL+8rel/vtY3weyy9Puo
        wP5TSrtH54jthOKAEM35OLPzYlzgKTVP21Lw4W4=
X-Google-Smtp-Source: ABdhPJyChryW6mdCOPUw4wQMlYeq6A1vhaSzSiaqRF+46DFpRFp/LiLDnrxItx+PUGIwLHFNJFOXEVyp54xFmj4C5DU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e883:: with SMTP id
 b3mr34406392qvo.23.1629738829630; Mon, 23 Aug 2021 10:13:49 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:16 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 12/14] x86, cpu: Use LTO for cpu.c with CFI
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
indirect call failures. CFI requires Clang >= 12, which doesn't have the
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
2.33.0.rc2.250.ged5fa647cd-goog

