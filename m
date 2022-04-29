Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAEBC433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 20:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381029AbiD2UlH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380963AbiD2Ukv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652BB852E1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z14-20020a5b0b0e000000b0064848b628cfso8407867ybp.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tv2NfEjyfprEjH/WagRqqCH1hQfxPpGMj5Z2HbEgkRA=;
        b=pB+2omq61Q3217AvI0rEZSjmyFqJ9NJ7YuTSaZYQdZKihILOoXitcHp4Aqk4DfNuJC
         Ii1imHx96bqsVsHF4LbRU0itbEjHrNgVdkQ3irES1Ih8mxUshYfbtfCT+TfHZ/oz1dtP
         NY0q6seVOURhumX36uwOxNHojZ45LOr10er9aVaKi/UiJRMGUW9RPY1W/crXdM6e/nzW
         jbvzkhILVLoFfcKOggaouemXiLcCzeXKkf/R9rS3XSJYuy1mUw5kXCtFqCb5OkWHmIae
         AVmKCEcuaeO8akCJpncoE0TcUuvyXfT1iSaAa7lBOHuy3YgYc6i8BTmI6s6WYnCNi+AU
         t24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tv2NfEjyfprEjH/WagRqqCH1hQfxPpGMj5Z2HbEgkRA=;
        b=2siMndKLfcQzNxuMqfOc1JN12wqAQU5ePur2XK9spFSf20QTi1dkJTpElOOLpoPP4D
         9sLKlNS2PoR7zT5SMv5sSJUT2KmgAdjpWLMaZ242LEZZgPWGkO13Gpz2R3fxEcc3N+0G
         153KnGkcAdkQrPdc6vtpOGErhIGCRUE6kF8MVNVAaON97ffTx/jpJ7csxjn630wyRVes
         jK8QOwV0mfUgeyJZBvCmnvMaN93JZliuJxX+W6EsCsIxNAprrXHK0EbSNlU5/HzufNc1
         GnjquW5VnBr7T4RpwxhRlb13/3h1soWXeXj9XTBJ409H12kFHOCWhpheodj+nfDxo+Sc
         Fdug==
X-Gm-Message-State: AOAM532UWhSCE7L3UOIxnT6eusq2ZSY6Fynbp3E1hSDPG0NkVthl1hEJ
        eTxvb57T0qIkiOumsmXKQIpb12gPqwUavPhJna4=
X-Google-Smtp-Source: ABdhPJzf8F6MhhQvERk6o6aC905EfQk7qKag0BcoEBBD0uWfioudMPTHJnGQUhT5pwFx9Z28Q9LGUrtznvm+L73jrDw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a81:234b:0:b0:2f8:4082:bbd3 with SMTP
 id j72-20020a81234b000000b002f84082bbd3mr1122079ywj.47.1651264638553; Fri, 29
 Apr 2022 13:37:18 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:36 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; h=from:subject;
 bh=tehRW82jP0RyTtdlRN0VdoftCcUQiAtEwsyBl3tnXQM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExXrPGtzBdwEr3WsUJMcTa5SnMpMUdhtG1ELjyr
 Yo4vk3yJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVwAKCRBMtfaEi7xW7gG8C/
 4rBi6pp+EX2VhofKNrL5OB4Nbj0tmkbvch9On+rothI5RrjLElKTQ7rJKCbeCMf/fd9MhXmmy30ZDc
 0i6d/nQFbMUJNbP3YvHszFfVozL5oetNY0LKa1tEWLrl1PmBWiMM1Y0hzUx695EFNuB9Z/IgzAWJHc
 VyKoFSgqL/HZvX7mFYcG2EAsOE+icuxIZICSAVt8NfVenhy3oKckN6+QZSZVHFbTE8sAiAE8x4UgZ4
 nSjkqIrcznKGhg5HogEmdwZzCaAcGZxDqdA0V1aaU4kyfLHFp9XZzKmiiUwTYYSWwvCY9Tvo+xL+Vu
 0CTamYHWDP1HUePZ8CB/mw9CsUeTuhu6zkvuMYcG354jmx7ooV+gAhNyCiEi4fKTuxQ5a1mRQuNNRE
 8SsQdB8squmkfEfpsoDlQCt5QaUw4WeUghUIX9vTwT7ISqGIun7rYMiGMRNi2bz7Bl6AT0hPw82Lgr
 VbBurkClkSn9jw/pGy7ura6cWEncKA6ChV3483s2teTmc=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 13/21] cfi: Add the cfi_unchecked macro
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The cfi_unchecked macro allows CFI checking to be disabled for a
specific indirect call expression, by passing the expression as an
argument to the macro. For example:

  static void call(void (*f)(void)) {
          cfi_unchecked(f());
  }

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/compiler-clang.h | 2 ++
 include/linux/compiler_types.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index c4ff42859077..0d6a0e7e36dc 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -94,4 +94,6 @@
 #if CONFIG_CFI_CLANG
 /* Disable CFI checking inside a function. */
 #define __nocfi		__attribute__((__no_sanitize__("kcfi")))
+/* Disable CFI checking for the indirect call expression. */
+#define cfi_unchecked(expr)	__builtin_kcfi_call_unchecked(expr)
 #endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index bdd2526af46a..41f547fe9724 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -263,6 +263,10 @@ struct ftrace_likely_data {
 # define __nocfi
 #endif
 
+#ifndef cfi_unchecked
+# define cfi_unchecked(expr)	expr
+#endif
+
 /*
  * Any place that could be marked with the "alloc_size" attribute is also
  * a place to be marked with the "malloc" attribute. Do this as part of the
-- 
2.36.0.464.gb9c8b46e94-goog

