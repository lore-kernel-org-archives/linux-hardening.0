Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCE5C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 27 Feb 2022 18:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiB0SqK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 27 Feb 2022 13:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiB0SqE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 27 Feb 2022 13:46:04 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D713F48E5A
        for <linux-hardening@vger.kernel.org>; Sun, 27 Feb 2022 10:45:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bx5so9229407pjb.3
        for <linux-hardening@vger.kernel.org>; Sun, 27 Feb 2022 10:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNerjKnrLq1mzg7meHtI9HSpdFqh8op60Xx8N1ZiLfw=;
        b=Jr0yJeEZIKJLj1DUJnFBO3uvzL0weaiXKeajxm9pM8JoQNy2uegYOMvaJRLuJ8Uib7
         Pv0U4bOC0mzJS889tXajsXuZEDCxHLF6/3dzjCPuLL7LYMNCxjD0nF6GdeWIPWR8H9Fm
         clw/KWTuD8soQR8FJZpgXCYEHze59giMoUZ+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNerjKnrLq1mzg7meHtI9HSpdFqh8op60Xx8N1ZiLfw=;
        b=aJWHGwlQ7/xHQOeAFimvNSpKmZiWvGn7Jc4e40hVadHkn1Dd3AA/eJSJUphMChmU6D
         HLPH3RWV57luyfHmcV9VAasD2Xf+Z+Z5CFSk7A7eETRV+JzsYA+K+g6ivD6AUYZBFR8f
         jYx1IANotscjduh2HXBbFylmzk04/vlf7EwhtuoQ385bhc6gkBDzOWIIBkD85XvBuPRd
         zclF4dVlHahWfnjQs2LD3xKHSEAIYujjwDORBelVerLHB6J/7pvhLKMHurQRuLVKOLA2
         2W7N8B5fQUCEu2RucNOStbNn8wzpxkbSLAINSviQPficOU1cE0FXwGRshCeG9s/UF+7U
         3Vew==
X-Gm-Message-State: AOAM5322JaeN+TPYXdA2cakRtMZUnNDs7x5H5/2uE8xVOXf1UHAihpqG
        5cN0l9fxCeoEsfcIbKPnZ6FaFA==
X-Google-Smtp-Source: ABdhPJwr3yU+S9CYU72TPvCVp/pkqfJFhYcfUElEnSnBBrukweZBCVubPSK86r4KINp53JP/mq3zxw==
X-Received: by 2002:a17:90a:a78c:b0:1b8:b769:62d0 with SMTP id f12-20020a17090aa78c00b001b8b76962d0mr13075887pjq.227.1645987522189;
        Sun, 27 Feb 2022 10:45:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a00238600b004e1906b3bb2sm10683826pfc.12.2022.02.27.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:45:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 3/7] um: Cleanup syscall_handler_t definition/cast, fix warning
Date:   Sun, 27 Feb 2022 10:45:13 -0800
Message-Id: <20220227184517.504931-4-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
References: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860; i=keescook@chromium.org; h=from:subject; bh=x+dnSolAXYFL3BT0a5kvXMCMP6a5EsT3sg6+p2gJHGU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiG8a7yUYgXa1FT6iIYRcyFYXJrB5R00YlXTwQ84Dl ly57u+qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhvGuwAKCRCJcvTf3G3AJizYEA CNb2bXcut1vDNHAoju2GPOc3OFs0G8V2WKCzzUKRK1IzqIDaSsvmZft2Zh01er3fyOo/fCw+N561JI dQ5RSNtSjGVoEb02yuUbZJRtB96/H1ByjVXwEzt3GmUh+YDqRCQh0516dzh2HKYejN2BpTZOdlSnoi HNT5GnI7w0PJW1CoarvIjIHPg8kQeXRS4LQIb0/xlPQRhr4wqrbQnmumuPRIhcdgCOeqYJYEmGJTWa XDrdOKdghbjEjNJQuwPrXMgxA0nbT5QV9kNPGe5ovoiT/MUw8jAyhmbAGfEffwgMCogtTMNQ31seeB VDr9NFJDVw/R/iIKpSmijT5XKvHnrbmYVscXr4YwhogN11OtdUBcWVcZ1oSkHmT8fnHVwHThhtlXQh r59GYhqhaWouBSz1pb/g/dcpu0530mr96aeOBz0o/ZADYRAPk59CVog0QBSVlILeLJuc2w63STCWPU HhGzGEYn9aWm+kE0jLdCpPi9VmLXZ6hRCtFkxhoujHW9W9YAAcdltYUcy1W1Hf5nSM6AdAvwsIM2cJ XiAk6mLRQydd2hnuKYvux1kouR/u+aqTKC6e384tsqmzrEh1eSZhFjgt3xgqkbOAu0j3EcRxMd6KWP p/0O+lB7e9hnEMcMyLksL0BlODvLslyBwJHpobDwFRAQPTrUdUvNGzIYIsjA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: David Gow <davidgow@google.com>

The syscall_handler_t type for x86_64 was defined as 'long (*)(void)',
but always cast to 'long (*)(long, long, long, long, long, long)' before
use. This now triggers a warning (see below).

Define syscall_handler_t as the latter instead, and remove the cast.
This simplifies the code, and fixes the warning.

Warning:
In file included from ../arch/um/include/asm/processor-generic.h:13
                 from ../arch/x86/um/asm/processor.h:41
                 from ../include/linux/rcupdate.h:30
                 from ../include/linux/rculist.h:11
                 from ../include/linux/pid.h:5
                 from ../include/linux/sched.h:14
                 from ../include/linux/ptrace.h:6
                 from ../arch/um/kernel/skas/syscall.c:7:
../arch/um/kernel/skas/syscall.c: In function ‘handle_syscall’:
../arch/x86/um/shared/sysdep/syscalls_64.h:18:11: warning: cast between incompatible function types from ‘long int (*)(void)’ to ‘long int (*)(long int,  long int,  long int,  long int,  long int,  long int)’ [
-Wcast-function-type]
   18 |         (((long (*)(long, long, long, long, long, long)) \
      |           ^
../arch/x86/um/asm/ptrace.h:36:62: note: in definition of macro ‘PT_REGS_SET_SYSCALL_RETURN’
   36 | #define PT_REGS_SET_SYSCALL_RETURN(r, res) (PT_REGS_AX(r) = (res))
      |                                                              ^~~
../arch/um/kernel/skas/syscall.c:46:33: note: in expansion of macro ‘EXECUTE_SYSCALL’
   46 |                                 EXECUTE_SYSCALL(syscall, regs));
      |                                 ^~~~~~~~~~~~~~~

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220210034353.1065703-1-davidgow@google.com
---
This is just a re-send of the above linked patch, collecting it into this series.
---
 arch/x86/um/shared/sysdep/syscalls_64.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h b/arch/x86/um/shared/sysdep/syscalls_64.h
index 48d6cd12f8a5..b6b997225841 100644
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ b/arch/x86/um/shared/sysdep/syscalls_64.h
@@ -10,13 +10,12 @@
 #include <linux/msg.h>
 #include <linux/shm.h>
 
-typedef long syscall_handler_t(void);
+typedef long syscall_handler_t(long, long, long, long, long, long);
 
 extern syscall_handler_t *sys_call_table[];
 
 #define EXECUTE_SYSCALL(syscall, regs) \
-	(((long (*)(long, long, long, long, long, long)) \
-	  (*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
+	(((*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
 		 		      UPT_SYSCALL_ARG2(&regs->regs), \
 				      UPT_SYSCALL_ARG3(&regs->regs), \
 				      UPT_SYSCALL_ARG4(&regs->regs), \
-- 
2.32.0

