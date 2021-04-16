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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EB1C433ED
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9766613D1
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbhDPUjT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343711AbhDPUjS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:18 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40266C061756
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:38:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id i12-20020a0cf38c0000b02901a283706bc1so2364925qvk.2
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2V8QAsj+Z02Kd4LR0nXDnyyqH7VtGeWLcnKeL+XD35A=;
        b=CDdGyScpvVmaCh6gbf/jPPbkNh4TnKHQUO41gkbgfdgmxuRVU/J80g77PWmuWvCb5A
         pMuHKl87ofecvT9ftF9y9n5UNOKXQ3SYtVDqIu2TfknnbvyJQ73W0feBd3VhMlWAatvj
         HPbP/xDZKsuJ6eR4p7P9o/OWom0atBPt+gmetLcHMuyVkIGmSugShyqazxYeablZpaKE
         oQOZMnA/xg+zHtMaDtyGVlNJxGTppzLd4ZT3YKlaj5nEXJulXjlMkQrv3xSDsbvVFjd2
         J4v5/OcZHFwASvCTLYApY50UaKflNddGoDlQTGOJ1KLzUBD1bYjrPaUIeo8oI3/05cDq
         F+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2V8QAsj+Z02Kd4LR0nXDnyyqH7VtGeWLcnKeL+XD35A=;
        b=eBJiRsIC8WnixJ1MkJ52cgisHyCxJGjCCOyH26zp49GBcg42bYsmOr1I4vdoRzmF8p
         vW5agS95S5t1phBs3RrkQydSkX2jFvFbmBinvTnls+MDx2tBSx6eI4z2Ieh1SEgQMpX5
         C36zf45uRqnLOxiqaXy3WjWMddR6cYXt84JnBrQ30nK1hoknXCHHH1A1NG2+b2XESvrH
         SVV+Z6gbs+VfhmJARkMDsiyktWfB3L5IL6+G5/7wug0iOr97bDkpTzjk/SXr8Xo0UBB4
         6Rfw1fqCGkXtIs1p45cfBXAmPkbsuQrvfOs6MSdQMefJsqizh9UMd9emHpy+OioGn0hC
         5BsQ==
X-Gm-Message-State: AOAM532CvTdPfy4/GaUKy5B7907P114H/2vqbSC03uVBT563/tYDLRu9
        wkulmIXgra0DPqud56AXc9KTXaGXKTZ+rTh20Vo=
X-Google-Smtp-Source: ABdhPJwBNtOC2GuqNSxtFRo/YW2dNu3RDamX5XVjt9LnAmvk0iapwxRvMqGGPKXU5a2SfpmC16u4n1T5+6nw6sxXmI8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a0c:d80a:: with SMTP id
 h10mr10443081qvj.25.1618605532443; Fri, 16 Apr 2021 13:38:52 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:32 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 03/15] objtool: Add ASM_STACK_FRAME_NON_STANDARD
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

To use the STACK_FRAME_NON_STANDARD macro for a static symbol
defined in inline assembly, we need a C declaration that implies
global visibility. This type mismatch confuses the compiler with
CONFIG_CFI_CLANG. This change adds an inline assembly version of
the macro to avoid the issue.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/objtool.h       | 5 +++++
 tools/include/linux/objtool.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 7e72d975cb76..2f29ce48ab5f 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -66,6 +66,11 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+#define ASM_STACK_FRAME_NON_STANDARD(func)				\
+	".pushsection .discard.func_stack_frame_non_standard, \"aw\"\n"	\
+	".long " __stringify(func) " - .\n"				\
+	".popsection\n"
+
 #else /* __ASSEMBLY__ */
 
 /*
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 7e72d975cb76..2f29ce48ab5f 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -66,6 +66,11 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+#define ASM_STACK_FRAME_NON_STANDARD(func)				\
+	".pushsection .discard.func_stack_frame_non_standard, \"aw\"\n"	\
+	".long " __stringify(func) " - .\n"				\
+	".popsection\n"
+
 #else /* __ASSEMBLY__ */
 
 /*
-- 
2.31.1.368.gbe11c130af-goog

