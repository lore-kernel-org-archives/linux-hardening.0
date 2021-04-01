Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E0AC43460
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 23:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E44610E8
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 23:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhDAXdJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbhDAXcu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 19:32:50 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B634C0613B8
        for <linux-hardening@vger.kernel.org>; Thu,  1 Apr 2021 16:32:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y16so4254233pfm.11
        for <linux-hardening@vger.kernel.org>; Thu, 01 Apr 2021 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ygu6iZbbUsR2ZKi8zr0iQyDyVVNKo7dHAEFjMtj8SHY=;
        b=cVUYELPkwyakQO4gpJ1n7nG1A7rYRu+EIAysLbBiPdUejJzOzMX96EChrBRzMBh6zW
         x0dx0cW3zE0Wop2s4iCPSYOfpp1cHt4q/JDYejpAPuJ5EaZ0LDn1eQc/EZSSQ+JcI/Ep
         aSzshOkORkt5as8iBp+LK+0GHTFWu6E+X7Dt6fjBCwDhmMdVOEg0cYoWse5r7hWwupSI
         GIMWTyJUk2Pdk4jDTUiSZMOsvnGKcBr86YBHhdMz5J55XRKRhzQZzbLI8+1/ECst6qrD
         FS5MXyt1H5ODIdkNU7FRNKO5mEHgSlK1RJwyJk198zwyxxkaAm68PyCFKSZaJgsbK+DZ
         4xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ygu6iZbbUsR2ZKi8zr0iQyDyVVNKo7dHAEFjMtj8SHY=;
        b=VWdMe113MW+fGN1TIxUaj4I4TzZqoPgbsJRJKJQW+jPbcNlJl8C2+9uXZgfIPNJ0/N
         H8z1hrPdctdZiPvNe4aeJH1OiQc0ObnoM2jTdHS72CGUb+z4GJOwgdle3VWPEoaaIJDI
         c6W/epT83+MyQzXLgYBEm/MyF8BhH6TvHvAXcoKLL8yOQrAQYWDI4yw7xuLkbN7fp9zH
         2SocodxX8OX8dS3b6B3QclqmHyDjeBCF2fv+4ZlTBzxA1OQ9DGDk5lMeSTMCclH56BIX
         kYHg26yY6CZMAwq/snj3w+ki7YL9aro0SZenV7RTJDXWXiUBdrCaEOo/f6CninOtN5rr
         2Nxg==
X-Gm-Message-State: AOAM533BDZIQ9ljHFHEO4oMDHFmhyIXjV8qtfSZ9Y5pybWRy4pxfJxxj
        fibXz5XHTF++lFTqTzbeelAfBAYr+/QuiWuftpY=
X-Google-Smtp-Source: ABdhPJytGMUSgXoVFpBf4jaOpktUMQEi2HRt1jGw3DzlgyJAUXzE/JwtBHr7mViI1KpDfZlI/n45nehfSKBWCsiw8+4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:9008:b029:e6:f37a:2183 with
 SMTP id a8-20020a1709029008b02900e6f37a2183mr10163478plp.49.1617319955033;
 Thu, 01 Apr 2021 16:32:35 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:06 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 08/18] bpf: disable CFI in dispatcher functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

BPF dispatcher functions are patched at runtime to perform direct
instead of indirect calls. Disable CFI for the dispatcher functions to
avoid conflicts.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3625f019767d..2f46f98479e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -650,7 +650,7 @@ struct bpf_dispatcher {
 	struct bpf_ksym ksym;
 };
 
-static __always_inline unsigned int bpf_dispatcher_nop_func(
+static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
 	unsigned int (*bpf_func)(const void *,
@@ -678,7 +678,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
-	noinline unsigned int bpf_dispatcher_##name##_func(		\
+	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
 		unsigned int (*bpf_func)(const void *,			\
-- 
2.31.0.208.g409f899ff0-goog

