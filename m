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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B4C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F96560E8B
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhINTMx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbhINTMp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C68C0613EF
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:14 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c27-20020a05620a165b00b003d3817c7c23so660935qko.16
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Be3mh0Heurxu9hJFvemOYTuJUhV3+qi/M0uRvmj0wVs=;
        b=DDt3LXDIM6D14nTNIFjpw3vKg5ni9Dz/m//OwVfRby+FVF3IiVLeiYeagFlA2lEI6e
         pJcRKjCH7Vt+DbMmLiH6A1nCSXP9DpX+708QFWosI26p3rx1+ewRY6PDvEejIlMtvL/R
         AvWJFHqIolAdE65gAczGCFErRp3qqne6IhCMeo62vlXwT+bmLHk16qy8BcTpgT6U0Ik8
         n0I40GCMgwmCnz9UBlcpUvN/0RAs6xhSeUuBplHbULzrfvprgMZqB7IQWtJl+Bvu/Hl/
         4Csa6RoPGYw+yh7DBTluINMrluyotliQWlOFFo3q6fOLah7KAO1WuV1XrEYsgTiImq5w
         ZZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Be3mh0Heurxu9hJFvemOYTuJUhV3+qi/M0uRvmj0wVs=;
        b=OSMhaVj+K1IhQmsVDLklRWRvhA6cp+jf9fECjzRIKayhE4YMMcF3dCg8culdTIZCaD
         KLBY6Phm91vve3q5mwGrhXa0F19XDGyG2R1P3oPxJZcQ3JC9g4Sn/4q72bJ2q3vXRKsA
         bsCx026u0N8EMu/OkhmKlSq+hmrDG1uI7IeD4N8bc2poBtkCr2iv8tz1SxKgJ0gTKTtT
         PuflE1G8+d+cXknQeqmzOZgLkRUN158XcZWO7jet21i7MreDzA6UygoyRcz4o7x2pbK9
         o8L+33iugStaoW16rnbwgfkRIQBVFT4SIp2SE7v41izWvUKJ95z19FB7F2q7l7066SV2
         q+nA==
X-Gm-Message-State: AOAM5300v2MFyq9Cg8pOhSp5u+kSo1LLuz/NLxfyiTnNzgE7+k0B8+jS
        wJ2XHljD4GLuIWAVdLrOvnzhu1ydgPdU0mClb5M=
X-Google-Smtp-Source: ABdhPJyXXGJ7Gi5RRDxl0Fxr3hT8RF4DN7XFQKLXWH7dlLm+ZZpT6iG28weHPCTPYeBMToGTvJQdxxi9X1J6cCMl/44=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b286:: with SMTP id
 r6mr7155507qve.33.1631646673546; Tue, 14 Sep 2021 12:11:13 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:40 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 11/16] x86/purgatory: Disable CFI
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

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..ed46ad780130 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -31,7 +31,7 @@ KCOV_INSTRUMENT := n
 # These are adjustments to the compiler flags used for objects that
 # make up the standalone purgatory.ro
 
-PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
+PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel $(CC_FLAGS_CFI)
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
-- 
2.33.0.309.g3052b89438-goog

