Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB7C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Dec 2022 18:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiLWSkH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Dec 2022 13:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWSkG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Dec 2022 13:40:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5F1572D
        for <linux-hardening@vger.kernel.org>; Fri, 23 Dec 2022 10:40:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so9509022pjp.1
        for <linux-hardening@vger.kernel.org>; Fri, 23 Dec 2022 10:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/K5s6GQ5c0Fl7h8Q3vjGYSICC8DwtoPDk3CYf+DbHR0=;
        b=bBjEl+jjssxnMJPc+K1JNmIFXEx2lWOLSHwlOQ/M3JiZ58DP+dad09cwvP8wsY1FYU
         UkHtTeG7i9TaXVCNDzwlbqyj2ZezrKd06FybmG8T4GF8DkYbJRJE5KupEi8zCYWt2/Oj
         HeVm5TOzkkwncKxD/gB9vB4CNxhy08X0/FEFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/K5s6GQ5c0Fl7h8Q3vjGYSICC8DwtoPDk3CYf+DbHR0=;
        b=Y5e8VOLX7RwEwEhOdQWZR1AfOLCB7W/YjJzouc761GrC//nAWdgtSFAUZ12HSl2XCw
         7wSzxKMb98F9RXzNdiHnlEVwwWT2lZKVmPN/7OJ5otfolBmRXwjS0MoL2N3AEly8QNWg
         mQdL8h1j5VeOQViQouSHi7PHW5dRKm33FBLssQQa1UEgEV0dKY87aQVA8IFSBQiv3jRH
         S+yzjAK0OcdOt81s+Bt2tIKg7qvSqqaHANDVdDyWPdGnbncweYzmjsld4gmtQbhmQB0i
         U68DeVLRkc7C0vCVJiZOxoguLKPZHr7DRN6IpfOxyiS+Uv8GyTdfqi/4jniAwQQ6RWGs
         5fyg==
X-Gm-Message-State: AFqh2kozzNlxmNk1bCB5WOo2Xs6WF1GjXJyI0JTQCoIsZETgssq7c9jC
        FWphj75xTZki7Jp/hG/VnSFuRQ==
X-Google-Smtp-Source: AMrXdXs+QHPmxwDy7aPJ1g+JYLej95aQhHI3yqa4ZuGWIBwyQi/3+rmMhhK70nTpgnK71s48rvMTEg==
X-Received: by 2002:a05:6a21:788f:b0:b2:2e66:482d with SMTP id bf15-20020a056a21788f00b000b22e66482dmr17159162pzc.50.1671820804375;
        Fri, 23 Dec 2022 10:40:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17-20020a63f751000000b0047712e4bc51sm2576700pgk.55.2022.12.23.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:40:03 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:40:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [GIT PULL] kernel hardening fixes for v6.2-rc1
Message-ID: <202212231039.504D027B9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Linus,

Please pull these kernel hardening fixes for v6.2-rc1. (Yay typos.)

Thanks!

-Kees

The following changes since commit d272e01fa0a2f15c5c331a37cd99c6875c7b7186:

  ksmbd: replace one-element arrays with flexible-array members (2022-12-02 13:14:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.2-rc1-fixes

for you to fetch changes up to cf8016408d880afe9c5dc495af40dc2932874e77:

  cfi: Fix CFI failure with KASAN (2022-12-23 10:04:31 -0800)

----------------------------------------------------------------
kernel hardening fixes for v6.2-rc1

- Fix CFI failure with KASAN (Sami Tolvanen)

- Fix LKDTM + CFI under GCC 7 and 8 (Kristina Martsenko)

- Limit CONFIG_ZERO_CALL_USED_REGS to Clang > 15.0.6 (Nathan Chancellor)

- Ignore "contents" argument in LoadPin's LSM hook handling

- Fix paste-o in /sys/kernel/warn_count API docs

- Use READ_ONCE() consistently for oops/warn limit reading

----------------------------------------------------------------
Kees Cook (3):
      LoadPin: Ignore the "contents" argument of the LSM hooks
      docs: Fix path paste-o for /sys/kernel/warn_count
      exit: Use READ_ONCE() for all oops/warn limit reads

Kristina Martsenko (1):
      lkdtm: cfi: Make PAC test work with GCC 7 and 8

Nathan Chancellor (1):
      security: Restrict CONFIG_ZERO_CALL_USED_REGS to gcc or clang > 15.0.6

Sami Tolvanen (1):
      cfi: Fix CFI failure with KASAN

 Documentation/ABI/testing/sysfs-kernel-warn_count |  2 +-
 drivers/misc/lkdtm/cfi.c                          |  6 ++++-
 kernel/Makefile                                   |  3 ---
 kernel/exit.c                                     |  6 +++--
 kernel/panic.c                                    |  7 ++++--
 security/Kconfig.hardening                        |  3 +++
 security/loadpin/loadpin.c                        | 30 ++++++++++++++---------
 7 files changed, 36 insertions(+), 21 deletions(-)

-- 
Kees Cook
