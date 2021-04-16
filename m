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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EA5C433ED
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08036613CF
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbhDPUkF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343964AbhDPUj6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07B6C061342
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c4so7538345ybp.6
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZVSi0+WBJd8cK80BxQ4Osd57SVpFSIT5lMOEx2WBOew=;
        b=b41bDVDJUgY/qmasSTsJuDALMyRKA0DquCDzT5YifV4psrwpRjIE5VqspQws2ol5jn
         mrX51iabMpAK3R8k61X0UplwjTLmDu6yT5/7dmJSNcMpoAeBzwgWl28wQzjmDKk1E7IP
         x1vcjYAP3urux/XhJ6MXq38mVThhrHqGeOlnQ/EaPIny+LP6TdRu1EC/j+CcDLbnokCA
         n5cz5zYxFWJEE6xxZij4vS0empLBUFmEy8aXeEolzwVa0Mz3ntE2Ox0NEstpix12KO6R
         BW1Dz6PBLKNJ+bPORL3EVHS1ggmEfMJ0ilQ/c/pNHTkPumDF625dTGsEJFL6vm647Dgr
         EOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZVSi0+WBJd8cK80BxQ4Osd57SVpFSIT5lMOEx2WBOew=;
        b=H5/RGae51UplmjeuOXWRupgvWNwrBUQl3x2J7c7O5d6uoftDV9Vvs8vLVPZ0sBChIr
         +3UxGyl3t5d+vNxN2p5Qa1JshDm6YCcSYTMUlF600Y7+w2uNTPlJY5o1BZXpZLjwqHhu
         iN+fprkiXfnh6uWxHwSAZrhlm476fD8E8UWPiU9dNSKcWcLeP0i6nlVQipoDwEODq1SX
         PZvMJ3TA93IvyCskcrZV0MnH8rEKQUhW/r90yksnmJ+Emx6AuyLlK6JAUpWdIPikX1H5
         hA4ZZLrz0hn8AtGyEGfykkZQJAGUSRuOo/Q0buWhhlbb5Z/6wJISeIO3sNn+xoyuqbsL
         oyJw==
X-Gm-Message-State: AOAM531u5UzwQl7gslH3cQlXPxxfIhUyOrU+kUqAtt0Vrlx3RPT7E8Ww
        Emt6GbTq62ibSeQ7scFTKQJSIkYNOV1QXPynFNA=
X-Google-Smtp-Source: ABdhPJwp4jV6Uc3XHwPdhaTYb8BA7WByxBbaC9LJGrPzkVX6yoMku4z3I0Vqt531iRR6rqD41CVsz7MEVhSflzBTG8Q=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a25:6885:: with SMTP id
 d127mr1406777ybc.378.1618605555941; Fri, 16 Apr 2021 13:39:15 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:44 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 15/15] x86, build: Allow CONFIG_CFI_CLANG to be selected
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

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bf69d07e46b8..81d2dc568e56 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -106,6 +106,7 @@ config X86
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_LTO_CLANG		if X86_64
 	select ARCH_SUPPORTS_LTO_CLANG_THIN	if X86_64
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
-- 
2.31.1.368.gbe11c130af-goog

