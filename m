Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB52EC43460
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 20:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBB161056
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 20:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhCaUzX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Mar 2021 16:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhCaUzE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Mar 2021 16:55:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE13C06174A
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 13:55:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k8so167084pgf.4
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bZ3bzKOfhPGnPGG60VssYCADe64CpCvkm0duGoaMAA=;
        b=iK6Dd1WzfTgZlYmEbgnA8JsN6ev91O3XgM9qgKS6kJCpEDzjxzvzwCL7RPAIIEpMPO
         m6g+Zrkan6Wwii54JTWoNBmrYZfJ1o2xcdda5yUzNDrzCoTAdDL5oMoveSYaiu0rppz9
         QW6uvmXPJPJYn+Oeme3ufD9LvkkfwQLu9XavI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bZ3bzKOfhPGnPGG60VssYCADe64CpCvkm0duGoaMAA=;
        b=qMsm46M70SJnvF5GgZxEQxz8DrpUZhd8mF5Z9pJosr56qL8vmj9zcg4dCo6KjwiZ3M
         klkMS7O/QzE6s+2OWbJrLP0Wmgn0+VR5VsYYXUUyyETLr4evVNOom8TLGKAgzOqmZn21
         SFfcd2eMmwLN1j4fNwsaS3CpzEFTg37WfSP3Zcu2/e8PoD5QPXdFd0BkRA4f8nMB446v
         wgvYl++ukvC5xcWPwjhR6TCBxwJkmBBTfPnHJ/z20iCzFhDZNtbUdnoIh6i3I3incU4D
         gLnrM3XiQ+P3ci4Hqb3n+kgrQqlMjsaCy4jEm9Wy/isDPHl32SVO1VRdfWN6JSxqO2td
         ySmg==
X-Gm-Message-State: AOAM531kWz+yFYh0T31RbsHMYr9N4KbBDHlsFcmivahIoQPmBvNK8X6i
        xsBrll+wokqH/AD+08zeynMk4A==
X-Google-Smtp-Source: ABdhPJzUF8uhkl0raN0ODpiCdyJAh9H7iGlPFlGsUGF89srEBkCnpo3FL1QwTdlnzj6Suocxnxa0yg==
X-Received: by 2002:a63:af51:: with SMTP id s17mr4640944pgo.405.1617224103801;
        Wed, 31 Mar 2021 13:55:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v18sm4189804pgo.0.2021.03.31.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/6] Optionally randomize kernel stack offset each syscall
Date:   Wed, 31 Mar 2021 13:54:52 -0700
Message-Id: <20210331205458.1871746-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Will (and Mark and Catalin),

Can you take this via the arm64 tree for v5.13 please? Thomas has added
his Reviewed-by, so it only leaves arm64's. :)


v9:
- comment position nit (tglx)
- Added tglx's Reviewed-by
v8: https://lore.kernel.org/lkml/20210330205750.428816-1-keescook@chromium.org/
v7: https://lore.kernel.org/lkml/20210319212835.3928492-1-keescook@chromium.org/
v6: https://lore.kernel.org/lkml/20210315180229.1224655-1-keescook@chromium.org/
v5: https://lore.kernel.org/lkml/20210309214301.678739-1-keescook@chromium.org/
v4: https://lore.kernel.org/lkml/20200622193146.2985288-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200406231606.37619-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200324203231.64324-1-keescook@chromium.org/
rfc: https://lore.kernel.org/kernel-hardening/20190329081358.30497-1-elena.reshetova@intel.com/

This is a continuation and refactoring of Elena's earlier effort to add
kernel stack base offset randomization. In the time since the earlier
discussions, two attacks[1][2] were made public that depended on stack
determinism, so we're no longer in the position of "this is a good idea
but we have no examples of attacks". :)

Earlier discussions also devolved into debates on entropy sources, which
is mostly a red herring, given the already low entropy available due
to stack size. Regardless, entropy can be changed/improved separately
from this series as needed.

Earlier discussions also got stuck debating how much syscall overhead
was too much, but this is also a red herring since the feature itself
needs to be selectable at boot with no cost for those that don't want it:
this is solved here with static branches.

So, here is the latest improved version, made as arch-agnostic as
possible, with usage added for x86 and arm64. It also includes some small
static branch clean ups, and addresses some surprise performance issues
due to the stack canary[3].

Thanks!

-Kees

[1] https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
[2] https://repositorio-aberto.up.pt/bitstream/10216/125357/2/374717.pdf
[3] https://lore.kernel.org/lkml/202003281520.A9BFF461@keescook/


Kees Cook (6):
  jump_label: Provide CONFIG-driven build state defaults
  init_on_alloc: Optimize static branches
  stack: Optionally randomize kernel stack offset each syscall
  x86/entry: Enable random_kstack_offset support
  arm64: entry: Enable random_kstack_offset support
  lkdtm: Add REPORT_STACK for checking stack offsets

 .../admin-guide/kernel-parameters.txt         | 11 ++++
 Makefile                                      |  4 ++
 arch/Kconfig                                  | 23 ++++++++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/Makefile                    |  5 ++
 arch/arm64/kernel/syscall.c                   | 16 ++++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/common.c                       |  3 ++
 arch/x86/include/asm/entry-common.h           | 16 ++++++
 drivers/misc/lkdtm/bugs.c                     | 17 ++++++
 drivers/misc/lkdtm/core.c                     |  1 +
 drivers/misc/lkdtm/lkdtm.h                    |  1 +
 include/linux/jump_label.h                    | 19 +++++++
 include/linux/mm.h                            | 10 ++--
 include/linux/randomize_kstack.h              | 54 +++++++++++++++++++
 init/main.c                                   | 23 ++++++++
 mm/page_alloc.c                               |  4 +-
 mm/slab.h                                     |  6 ++-
 18 files changed, 207 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h

-- 
2.25.1

