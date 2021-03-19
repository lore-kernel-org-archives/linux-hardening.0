Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD29BC433DB
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953326193A
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSV25 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Mar 2021 17:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhCSV2j (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Mar 2021 17:28:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD22CC061760
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x184so6772489pfd.6
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COYequ/Al4vh0bS6DyJKs6KMlXrnC5mSUzfXzkBff1k=;
        b=I8TknAyVLcDhMIatOxfg+fdU62BWJHBXwg3Rx8TWavaNLBa3eNY1/bJ+QswJecZL+u
         dxQZJxpcqrjERo37QE97Ja+SJjY29erRLfmXZqZDZ0A18U3QnAljIYefhpB0s3kMil0o
         OHt2KyuJ0VnoNR446RaOmtyETkgphZPoeTESE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COYequ/Al4vh0bS6DyJKs6KMlXrnC5mSUzfXzkBff1k=;
        b=rY/0o9iLXc0S5P/mEau3ooSPqgOB+dYSawRcCtnNbXqFVX4Fzv1MAeEOsQTBwC5C7r
         jAryWE8tjJd8L0SSaZwLCiDvP6YoawVnTEe7NVc1Ukf53e/urwqdw2Kfn6vbvqRSTxmz
         LrT2ns0Ggmq8BsBLspclfzgVz5xMQJpImA5fvhuCuqJeIeukTXdOD5dCZBDot6qy+k4I
         D6f2E47e691lNnbJkZHrLZq1vjLH00tNwMVs0eDWhmVVNsiaPtuFiLsHfkHQh1WFT+fd
         v210tRRExehXlY4uppMxI98rqIi6cMVUMTXK7L/1IiLUrTW/vvqS5V2lqJion4MHCGJT
         89jw==
X-Gm-Message-State: AOAM533P28Mk1D+7vaBVyczTSPfC/zovfThWlGtl7YrfGaztl9Pak0rQ
        JkHo7UPvOMBj+Ln7uh/rKg9dPg==
X-Google-Smtp-Source: ABdhPJyZr4/GDEamWBieVEFuuZx6Q7tu0xmdbWTaLaDKNdCcZA75rRto0XPpcUkqhpQvA6Nqpe018g==
X-Received: by 2002:aa7:9081:0:b029:1f9:26c9:1609 with SMTP id i1-20020aa790810000b02901f926c91609mr10885048pfa.54.1616189319323;
        Fri, 19 Mar 2021 14:28:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t19sm6136631pgj.8.2021.03.19.14.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:28:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v7 0/6] Optionally randomize kernel stack offset each syscall
Date:   Fri, 19 Mar 2021 14:28:29 -0700
Message-Id: <20210319212835.3928492-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

v7:
- fix copy/paste-o from v6 CONFIG additions.
v6: https://lore.kernel.org/lkml/20210315180229.1224655-1-keescook@chromium.org/
v5: https://lore.kernel.org/lkml/20210309214301.678739-1-keescook@chromium.org/
v4: https://lore.kernel.org/lkml/20200622193146.2985288-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200406231606.37619-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200324203231.64324-1-keescook@chromium.org/
rfc: https://lore.kernel.org/kernel-hardening/20190329081358.30497-1-elena.reshetova@intel.com/

Hi,

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

At the very least, the first two patches can land separately (already
Acked and Reviewed), since they're kind of "separate", but introduce
macros that are used in the core stack changes.

If I can get an Ack from an arm64 maintainer, I think this could all
land via -tip to make merging easiest.

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

 .../admin-guide/kernel-parameters.txt         | 11 +++++
 Makefile                                      |  4 ++
 arch/Kconfig                                  | 23 ++++++++++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/Makefile                    |  5 +++
 arch/arm64/kernel/syscall.c                   | 10 +++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/common.c                       |  3 ++
 arch/x86/include/asm/entry-common.h           |  8 ++++
 drivers/misc/lkdtm/bugs.c                     | 17 ++++++++
 drivers/misc/lkdtm/core.c                     |  1 +
 drivers/misc/lkdtm/lkdtm.h                    |  1 +
 include/linux/jump_label.h                    | 19 +++++++++
 include/linux/mm.h                            | 10 +++--
 include/linux/randomize_kstack.h              | 42 +++++++++++++++++++
 init/main.c                                   | 23 ++++++++++
 mm/page_alloc.c                               |  4 +-
 mm/slab.h                                     |  6 ++-
 18 files changed, 181 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h

-- 
2.25.1

