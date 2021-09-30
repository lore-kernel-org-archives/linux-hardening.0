Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F80C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC3C61164
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353022AbhI3SJI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353127AbhI3SID (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:08:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079A8C06176C
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:06:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso9722527ybj.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JQBSJ8qj9mW2upriZ1hUokdADKSbuyuOL0tMdMaGIyA=;
        b=s0zb3TFc82fA3XBAkcMpi6oec+ReyD7OcULFaBcO4uVLgtojliDt/V9XqnukzyaPol
         A1j7FIPBDGl1ZjSc0ZQu19AnLj9TllbqEcwRN+TRer3xWWvadPs/ORvRkVe6dvTICt1G
         ZJSeRN291POY2ZwlPuLkPJfEigA5ifAD8VVI7lIAbUsEkdzuPSZyBYmZlQ0B4+zCW2rr
         qqRiFZDvF5dgJaJMlYRAszaI2SitdqSUKgdJ5pFoL9uuyAVwfeRdYywQggtwFRNBko2I
         8/rrf+ej0B9GZ/BRIEXG3mVOFCf/XjamfkW4tLCotoa9+itW1Ey93cSEGhIpV3FRDA+r
         bR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JQBSJ8qj9mW2upriZ1hUokdADKSbuyuOL0tMdMaGIyA=;
        b=xIBCOlK8X4u04l6kAYCVrfcXoQlQRlffY15blhawSzdQVkBQVBuQNJh/42Jtl8Oo+V
         fG9JyubqHbOFZ1Uhoe2fbg21wSsUSQ7XfqMEqM6PLmW/+5hQOeYZwnnmxzR2ixYZ9Wlv
         CATAW34WdlsmsAi9KBK6QdJ2RoSyI8i9HVUWsiVxoVsjZj9/t44L5yyXBeLDpbGHTTou
         vTMI3tYZ5OR5I8FasK2jlA3HctRkSSE/ZF0c7DWsMFJ837YNH02qPaAP4SBNvQvi4RYf
         4HgD3Hpr+tkBGqJEtiMqGJ40AsGNuQhxD51TY87y9yckOfd1eFPRkWAzdOrumLTbJz1a
         qRZA==
X-Gm-Message-State: AOAM5319GwS4BFrmUVTAotaOUChuiuSJXza9VzxdRdsESlKQVxzEmyHw
        9cBGKxzH+og3PC5l1cisSpoBQU5ghAcrm2GJLdg=
X-Google-Smtp-Source: ABdhPJygJzfXzJubcmYgFAfGrc+L5exrHwzMqpfVKfj5yjqfYD02sPYHI+OV9HqYRb8L1IT/rL2I3DNS49v9knmwmuI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a25:21c2:: with SMTP id
 h185mr689359ybh.495.1633025168233; Thu, 30 Sep 2021 11:06:08 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:30 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 14/15] x86, kprobes: Fix optprobe_template_func type mismatch
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The optprobe_template_func symbol is defined in inline assembly,
but it's not marked global, which conflicts with the C declaration
needed for STACK_FRAME_NON_STANDARD and confuses the compiler when
CONFIG_CFI_CLANG is enabled.

Marking the symbol global would make the compiler happy, but as the
compiler also generates a CFI jump table entry for all address-taken
functions, the jump table ends up containing a jump to the .rodata
section where optprobe_template_func resides, which results in an
objtool warning.

Use ASM_STACK_FRAME_NON_STANDARD instead to avoid both issues.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/kprobes/opt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 71425ebba98a..95375ef5deee 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -103,6 +103,7 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 asm (
 			".pushsection .rodata\n"
 			"optprobe_template_func:\n"
+			ASM_STACK_FRAME_NON_STANDARD(optprobe_template_func)
 			".global optprobe_template_entry\n"
 			"optprobe_template_entry:\n"
 #ifdef CONFIG_X86_64
@@ -154,9 +155,6 @@ asm (
 			"optprobe_template_end:\n"
 			".popsection\n");
 
-void optprobe_template_func(void);
-STACK_FRAME_NON_STANDARD(optprobe_template_func);
-
 #define TMPL_CLAC_IDX \
 	((long)optprobe_template_clac - (long)optprobe_template_entry)
 #define TMPL_MOVE_IDX \
-- 
2.33.0.800.g4c38ced690-goog

