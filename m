Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D615C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7FA61139
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhJMSTG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSTF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08217C061570
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q193-20020a252aca000000b005ba63482993so4167633ybq.0
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=priT/ItP89NRbp00FLsxjKJmgV32/krNE9+XEfqTXTY=;
        b=qeACLMppwPHk2IrRVFy/J4vcJ5jF+NMg/4EXKWH+jw5Ud1qnHi5qD4UqYSql2krOzK
         sxOYKu2KZ+zeGBAaiXtBX+jE8Lq3TxeD4rTp407vCRItN1jXkMU7Dz5xpJR1rZ5puVro
         4VLnq1Ej0Zg56iIbPD/LArb3BEKN/RdMBfq+a7Dp3gwzZ47urAGsDvHl698L3B7vvUWS
         xPEHwxbwHWuHGD3cWs9KXHvxu22jsHjppOHpuhMyZeGiYPbXMpfE4BX3j7X/Clia37Ar
         BYAGUcOeXvIk5FBfgS8YUZqZzd1EwpfcV5iFcvGsCAVo4cg8nHK/Rqp+WLesJZJjGZno
         pxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=priT/ItP89NRbp00FLsxjKJmgV32/krNE9+XEfqTXTY=;
        b=K8NWLwqCdQ5+0DZos+lqjK+RbNdqj8ZCKiwgEorL1m57oAJj20GsQS79YzEdj19Kyq
         acOsc3iJZMUsQtdSk637CotGjRvteyUK+qnMTOuWvP6Di7eX64728JBoTpe7mkCi0R89
         WjiDp3F+d/gVlhfWDP8G6Lgi2JFCLnzwqnT4c4ti3ETrbFbsy4r3vFJLuny+XiBF9/8W
         jUHt5MZ3OOyhugZ28a5WsByP6T4yywdhjEa9+9w1We5EL3tBbIlOiy06wpVUxyuEHonB
         eAoeoMmsQahWRcATlTCSDIAc+iNxv6fP/NXINh0nhtV2fdrcJolpoT9HuGmQIqxw/ART
         lo/A==
X-Gm-Message-State: AOAM5336szwM0awqFFiugZtDi5iboqozdkWS9NiffAmAvWuoBKZIN6rN
        padIvTW25MCMcfxkqHIJil9yNQu2pfR/rdO6+OA=
X-Google-Smtp-Source: ABdhPJztd1f1MlyWBhYjjQnDUCD7svsyJmD3+ie8ZQzvJeHEd0pLrOjqhN6uwvnvtLbopLp2FVxjHTqikvN8GXgvvOY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:2bc1:: with SMTP id
 r184mr1037082ybr.44.1634149021190; Wed, 13 Oct 2021 11:17:01 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:43 -0700
Message-Id: <20211013181658.1020262-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5151; h=from:subject;
 bh=W5OXSe3azui94+7ieiWfTshrba+W4CqrXrs6hnNYQWI=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKYrRgL6whgGGniqMexqPGkEgMj8XN0qVXylQFV
 /gAJWduJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimAAKCRBMtfaEi7xW7sfhC/
 9iYlgV1DRuFeCh2xA6Pek6394Tx/7ZHWgQ0j2OCyEl/ygZimK1+C5T17GgcpaDyelagN4+3/JG3MNo
 d7H5AgbX7fNdz4BShCbpLylb5RZpE3bHdOmT47vq96AaAihVs7zd5ZsEj9DShuMPdA5VIHFBe6Wf43
 q6bHtyC+ppzNqYFk5IJadxrJJuz+Co/LEalkECJ9YWeMCjEaaHKtkgxn0v+bBBolafa/HtTQTj1WZ+
 iW9rTbr6r+o6QxERaMnsWUlZPuzZCjWe+IUdTzALvfrjs4GFc9uMAvMjjSNgEDsrTYFzt4C+Ybyyox
 b5JKrb9hfS1NYW0aFudEnd12vYTk5eaWGIm19rzWYnDpS6v+dS+DzGcHnneNfTzau7tJzsvWzTaSd8
 gmzK7cJ6Wnrdezzs5/vElt4RdYu+4QjCG4RKjmnvjvc1qGix8dN+yNfEkarEv2Eggjw77NjN9Sr6jS
 YUlguJrSFn5Wa22KdWdm+KZn0XSQS0mX75sM2oguliu9Q=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 00/15] x86: Add support for Clang CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This series adds support for Clang's Control-Flow Integrity (CFI)
checking to x86_64. With CFI, the compiler injects a runtime
check before each indirect function call to ensure the target is
a valid function with the correct static type. This restricts
possible call targets and makes it more difficult for an attacker
to exploit bugs that allow the modification of stored function
pointers. For more details, see:

  https://clang.llvm.org/docs/ControlFlowIntegrity.html

Note that v5 is based on tip/master. The first two patches contain
objtool support for CFI, the remaining patches change function
declarations to use opaque types, fix type mismatch issues that
confuse the compiler, and disable CFI where it can't be used.

You can also pull this series from

  https://github.com/samitolvanen/linux.git x86-cfi-v5

---
Changes in v5:
- Renamed DECLARE_ASM_FUNC_SYMBOL() to DECLARE_NOT_CALLED_FROM_C()
  after some discussion about naming.

- Added an explicit include for <linux/cfi.h> to tracepoint.c.

- Updated commit messages based on feedback.

Changes in v4:
- Dropped the extable patch after the code was refactored in -tip.

- Switched to __section() instead of open-coding the attribute.

- Added an explicit ifdef for filtering out CC_FLAGS_CFI in
  purgatory for readability.

- Added a comment to arch_cfi_jump_reloc_offset() in objtool.

Changes in v3:
- Dropped Clang requirement to >= 13 after the missing compiler
  fix was backported there.

- Added DEFINE_CFI_IMMEDIATE_RETURN_STUB to address the issue
  with tp_stub_func in kernel/tracepoint.c.

- Renamed asm_func_t to asm_func_ptr.

- Changed extable handlers to use __cficanonical instead of
  disabling CFI for fixup_exception.

Changes in v2:
- Dropped the first objtool patch as the warnings were fixed in
  separate patches.

- Changed fix_cfi_relocs() in objtool to not rely on jump table
  symbols, and to return an error if it can't find a relocation.

- Fixed a build issue with ASM_STACK_FRAME_NON_STANDARD().

- Dropped workarounds for inline assembly references to
  address-taken static functions with CFI as this was fixed in
  the compiler.

- Changed the C declarations of non-callable functions to use
  opaque types and dropped the function_nocfi() patches.

- Changed ARCH_SUPPORTS_CFI_CLANG to depend on Clang >=14 for
  the compiler fixes.


Kees Cook (1):
  x86, relocs: Ignore __typeid__ relocations

Sami Tolvanen (14):
  objtool: Add CONFIG_CFI_CLANG support
  objtool: Add ASM_STACK_FRAME_NON_STANDARD
  linkage: Add DECLARE_NOT_CALLED_FROM_C
  cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
  tracepoint: Exclude tp_stub_func from CFI checking
  ftrace: Use an opaque type for functions not callable from C
  lkdtm: Disable UNSET_SMEP with CFI
  lkdtm: Use an opaque type for lkdtm_rodata_do_nothing
  x86: Use an opaque type for functions not callable from C
  x86/purgatory: Disable CFI
  x86, module: Ignore __typeid__ relocations
  x86, cpu: Use LTO for cpu.c with CFI
  x86, kprobes: Fix optprobe_template_func type mismatch
  x86, build: Allow CONFIG_CFI_CLANG to be selected

 arch/x86/Kconfig                      |  1 +
 arch/x86/include/asm/ftrace.h         |  2 +-
 arch/x86/include/asm/idtentry.h       | 10 +++---
 arch/x86/include/asm/page_64.h        |  7 ++--
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/include/asm/processor.h      |  2 +-
 arch/x86/include/asm/proto.h          | 25 ++++++-------
 arch/x86/include/asm/uaccess_64.h     |  9 ++---
 arch/x86/kernel/alternative.c         |  2 +-
 arch/x86/kernel/ftrace.c              |  2 +-
 arch/x86/kernel/kprobes/opt.c         |  4 +--
 arch/x86/kernel/module.c              |  4 +++
 arch/x86/kernel/paravirt.c            |  4 +--
 arch/x86/kvm/emulate.c                |  4 +--
 arch/x86/kvm/kvm_emulate.h            |  9 ++---
 arch/x86/power/Makefile               |  2 ++
 arch/x86/purgatory/Makefile           |  4 +++
 arch/x86/tools/relocs.c               |  7 ++++
 arch/x86/xen/enlighten_pv.c           |  6 ++--
 arch/x86/xen/xen-ops.h                | 10 +++---
 drivers/misc/lkdtm/bugs.c             |  2 +-
 drivers/misc/lkdtm/lkdtm.h            |  2 +-
 drivers/misc/lkdtm/perms.c            |  2 +-
 drivers/misc/lkdtm/rodata.c           |  2 +-
 include/asm-generic/vmlinux.lds.h     | 11 ++++++
 include/linux/cfi.h                   | 13 +++++++
 include/linux/ftrace.h                |  7 ++--
 include/linux/linkage.h               | 13 +++++++
 include/linux/objtool.h               |  6 ++++
 kernel/cfi.c                          | 24 ++++++++++++-
 kernel/tracepoint.c                   |  6 ++--
 tools/include/linux/objtool.h         |  6 ++++
 tools/objtool/arch/x86/decode.c       | 17 +++++++++
 tools/objtool/elf.c                   | 51 +++++++++++++++++++++++++++
 tools/objtool/include/objtool/arch.h  |  3 ++
 tools/objtool/include/objtool/elf.h   |  2 +-
 36 files changed, 218 insertions(+), 66 deletions(-)


base-commit: 880e2b8e3151574b9e3419d1fbb06726ddee8b03
-- 
2.33.0.1079.g6e70778dc9-goog

