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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC25C43461
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6001E613CE
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbhDPUj1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbhDPUj0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:26 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C55C06175F
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:01 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x7-20020a05622a0007b029019d73c63053so6762919qtw.16
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QGx/+5PSv4vcds8exhIxEpB6elgUIYsSVqcIzQ7CoY0=;
        b=uZKwdvxXSJVGChXYzLBAPig4b5FYoGeda5NKSXNeIL575TrHj+mv7A6/+z9Q1ULF47
         GnFegjvKKkl7mkg0kCeRTvHVoMkOPQN9NFKfTvTwa4rdwn1TJsA5bNIMe2sPLez4NF9l
         2Zg20J9c4zB9EqzOqCvBBzry6ki6GWBqYQH443gpTia0Wf9cAczRPhdZ+E6sQJ8CTBKE
         1G1jUiuRdYGYN+c+LThtYloKLH/8suUpE9jkMdU9MkLjVtKiVSy0McDLo32SbABPtaPs
         hqf4xH9PZJw6//EfRMRXxYTvr61J5xf4WOR74HouKDc984vllZj1WXQz1AXJFvc01LUB
         eYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QGx/+5PSv4vcds8exhIxEpB6elgUIYsSVqcIzQ7CoY0=;
        b=hOYORPsCgb8Ss4vtPsk4tMLlls4605nIQYRjZpFYz9DBEyI1be7nsXOB3agy1NY9xt
         rGnTYBIWTh7OBnl29G9DpZvqEwzg2/AfwbghRWy0jh+bHK7x2m7+hQHpBLko8XTTCUa5
         MtdJabMiPbhEGweZu8yuSwbEtawlPs+OzGlu6RtYvxnoi4YZx/xGuOvrOb5ppTPNSnrm
         72cHrobNGY7fdDS0/uxyK+EKA+HvTSo1gH6/yUrvp3x/qcgJwTEIQiENHypI1jXfKybR
         u1B38IMq/3I1deoyBqCtgVyOHQ1jdlocs85XwaVf+gNjndaleMuIX41B41gAp6g5KVki
         pSQA==
X-Gm-Message-State: AOAM533JbOFYTL9fpbsT6RnrKP7hOBKFCWWPaUYZT2gzILE3g1l8LoND
        OZh4G4iQNrk6EaPgA2tHPfmKuhgoPLw4y3lhaeE=
X-Google-Smtp-Source: ABdhPJyRVTTcyMgTah2hEg8Htw3gAC/nsLNQLXzjNNIB9gT6Tqpqgc0Ua2gQrpl1CRkqaDZyjPHxQmaRFDS26fQTb/Y=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a0c:f946:: with SMTP id
 i6mr10263185qvo.42.1618605540208; Fri, 16 Apr 2021 13:39:00 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:36 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 07/15] x86/ftrace: Use function_nocfi in MCOUNT_ADDR
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

With CONFIG_CFI_CLANG, the compiler replaces the __fentry__ address in
MCOUNT_ADDR with the address of a CFI jump table. Use function_nocfi()
to get the actual function address.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 9f3130f40807..0b7567994f4a 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -6,7 +6,7 @@
 #ifndef CC_USING_FENTRY
 # error Compiler does not support fentry?
 #endif
-# define MCOUNT_ADDR		((unsigned long)(__fentry__))
+# define MCOUNT_ADDR		((unsigned long)(function_nocfi(__fentry__)))
 #define MCOUNT_INSN_SIZE	5 /* sizeof mcount call */
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
2.31.1.368.gbe11c130af-goog

