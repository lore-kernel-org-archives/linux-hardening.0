Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81E6C433ED
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86629613CE
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhDPUjM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhDPUjM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D7C061574
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:38:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f7so7506542ybp.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nrK50TUoHxhq1t3QCwcADDrYS4vmPROmKvSMBMSjkd8=;
        b=gRhfGBlgr6lC+vLBCGA3h0P3QeS+YlEnguE3a1smjDngW4JmMxemA6dTF+XGtXKabn
         T8nFQm9DcIEYEbqFNNu5WzRcg89l/DZWfEovWgxLGFDHEHv7rPeBxLZG7rfnSOlaVEeS
         Y5WvyfTNKeHipDfPXUND3MzOsbKvzlj38279TBTfINg+sV24PiP/y32xOi/qSqa6NApl
         vEsrrlPWl1rLED2YYyBeiinWDcDGOYqY+rEpr0elDFGPgpJhKZDZHlBIUr5RSkY2K9JO
         YAKSSj73GVLKLiu9q6DysP2sgOyvur52fNkzp2lD2QZBf4pN1iM1htvh2/TAPU6DUA3+
         Fw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nrK50TUoHxhq1t3QCwcADDrYS4vmPROmKvSMBMSjkd8=;
        b=ssymYkGVi3Lhylh4p7IZAy+xRa+GWQKdQkq+tZEKB4vIAmWU0ZxpL854Og5UmnSpOH
         zacVgCWL1udBGqy0V4zkegTd7P6tJyQ22U3t2hEsGVjt83OkhPo7puHAakcB7ta6S6k2
         7/Ho2//F0/BZPFf3ejQqmnq1ONx/iHBhAgNM27R08eoN1J0x224QNDHUdi+k+FDeuykq
         PrfwSJ97IBjaUW0dKkmcmmsEorgpvx1pjKa3OaQW+OJ9JxX+mg1173zSkEo/LezfQj/5
         5XWH171U7j+h12F+ThSx+ATITG4rmB8LnIkV6O6XdrsEoTlEMLsHgmft1XSk1sxd62mo
         wEqA==
X-Gm-Message-State: AOAM530050Fl1CALa0Ir4xPtJRB2FhxUp/0e6Zq7LjRODgEVJ5Cqc5as
        g35X1+KWnxKabSFyss0t1n9agYorsERCgpb+U+o=
X-Google-Smtp-Source: ABdhPJw38VMGKTuPgJbCWwJYjBTHj/EMNPz+6cUS0yYMxhEa35lES/al2j0dkU8v2V3Q+uj+sFazVv/ZoOSqdhtSkeQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a25:56c2:: with SMTP id
 k185mr1395704ybb.131.1618605526690; Fri, 16 Apr 2021 13:38:46 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:29 -0700
Message-Id: <20210416203844.3803177-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 00/15] x86: Add support for Clang CFI
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

This series adds support for Clang's Control-Flow Integrity (CFI)
checking for x86_64. With CFI, the compiler injects a runtime check
before each indirect function call to ensure the target is a valid
function with the correct static type. This restricts possible call
targets and makes it more difficult for an attacker to exploit bugs
that allow the modification of stored function pointers. For more
details, see:

  https://clang.llvm.org/docs/ControlFlowIntegrity.html

The first two patches contain objtool support for CFI, and the
remaining patches disable CFI where it shouldn't be used and fix
other smaller issues, such as type conflicts that confuse the
compiler.

Note that the patches are based on next-20210416. You can also pull
the series from

  https://github.com/samitolvanen/linux.git x86-cfi-v1


Kees Cook (3):
  x86/extable: Do not mark exception callback as CFI
  x86/alternatives: Use C int3 selftest but disable KASAN
  x86, relocs: Ignore __typeid__ relocations

Sami Tolvanen (12):
  objtool: Find a destination for jumps beyond the section end
  objtool: Add CONFIG_CFI_CLANG support
  objtool: Add ASM_STACK_FRAME_NON_STANDARD
  static_call: Use global functions for the self-test
  x86: Implement function_nocfi
  x86: Avoid CFI jump tables in IDT and entry points
  x86/ftrace: Use function_nocfi in MCOUNT_ADDR
  x86/purgatory: Disable CFI
  x86, module: Ignore __typeid__ relocations
  x86, cpu: Use LTO for cpu.c with CFI
  x86, kprobes: Fix optprobe_template_func type mismatch
  x86, build: Allow CONFIG_CFI_CLANG to be selected

 arch/x86/Kconfig                    |  1 +
 arch/x86/include/asm/desc.h         |  8 ++++-
 arch/x86/include/asm/ftrace.h       |  2 +-
 arch/x86/include/asm/page.h         | 14 +++++++++
 arch/x86/kernel/Makefile            |  3 ++
 arch/x86/kernel/alternative.c       | 21 +++----------
 arch/x86/kernel/cpu/common.c        |  8 ++---
 arch/x86/kernel/idt.c               |  2 +-
 arch/x86/kernel/kprobes/opt.c       |  4 +--
 arch/x86/kernel/module.c            |  4 +++
 arch/x86/kernel/traps.c             |  2 +-
 arch/x86/mm/extable.c               |  1 +
 arch/x86/power/Makefile             |  2 ++
 arch/x86/purgatory/Makefile         |  2 +-
 arch/x86/tools/relocs.c             |  7 +++++
 arch/x86/xen/Makefile               |  2 ++
 include/linux/objtool.h             |  5 +++
 kernel/static_call.c                |  4 +--
 tools/include/linux/objtool.h       |  5 +++
 tools/objtool/check.c               |  4 +++
 tools/objtool/elf.c                 | 48 +++++++++++++++++++++++++++++
 tools/objtool/include/objtool/elf.h |  2 +-
 22 files changed, 119 insertions(+), 32 deletions(-)


base-commit: 18250b538735142307082e4e99e3ae5c12d44013
-- 
2.31.1.368.gbe11c130af-goog

