Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BDBC05027
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Feb 2023 19:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBQTiW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 17 Feb 2023 14:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBQTiV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 17 Feb 2023 14:38:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C466E5B2F2
        for <linux-hardening@vger.kernel.org>; Fri, 17 Feb 2023 11:38:20 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jk12so2786255plb.5
        for <linux-hardening@vger.kernel.org>; Fri, 17 Feb 2023 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKKsXZajqAwe6W3hq4W4TjLXNRRTkhvXVuDWAa55fyY=;
        b=mUGUUwMmQdL7yiJ3A/3vV6P1wMLI6SAVScK7i+EWcuQRo+kxjv+fWFNz3IolqSBkyN
         1TJHCL6b1B4soEF0g++QCLyyqwBlCRxdR2mQaPTI5y8hDHATNGjB8RcGzcXu4FhSao/5
         ZOiQCMyCf4SgpUK4gSE26ZtSsFcC5pmMOIvus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKKsXZajqAwe6W3hq4W4TjLXNRRTkhvXVuDWAa55fyY=;
        b=Pl7YIFUY8NUoguJ12e97+ksaqYPVq+NLZuzK3lN1J8GByFnl+uNXVbGEqrDzbPUgnr
         eSy4qHQajJozPXA1TVa0yX9MGijeIAl/ePv0om4XTVYPHXZ211jQwonLRLl9gdEu4sJA
         AyDu0HVs3yQw593Mpwb9oEsAjl69chbjxSyUIDsQ69N8hMLRRDEuD1qiAZk8rC+yaTci
         E5QH56xEX6PEzT9MaCqiVr8j6USS7bkxOh79AXamkhUOk+BfSCWXR3M/2iKYrpbJSURn
         Qg1faHo99lFFkEyPlslW8yF98+F3TIz6rkIMluDOenKnMc2xQ4ZarXrgQgKesuH2yxZk
         rneA==
X-Gm-Message-State: AO0yUKXb9JSaCJKpZ9ApHH/9KCaWcInYVpnd71MB2wOREvdN2+s9kwO7
        wVujdy46+3czuBg0BJfuQEwqPA==
X-Google-Smtp-Source: AK7set+lYu6pNIj7bPGyNSwL2YoZiIEshkV7Lx/VqDnn/qlpC8zu4ILCO1HILl2dofPETM+U9dqiBw==
X-Received: by 2002:a17:90b:1bd2:b0:233:c3e7:bd3b with SMTP id oa18-20020a17090b1bd200b00233c3e7bd3bmr1501084pjb.10.1676662700260;
        Fri, 17 Feb 2023 11:38:20 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a764200b00230e2b6f89esm3241765pjl.12.2023.02.17.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 11:38:19 -0800 (PST)
Message-ID: <63efd7ab.170a0220.3442b.6609@mx.google.com>
X-Google-Original-Message-ID: <202302171129.@keescook>
Date:   Fri, 17 Feb 2023 11:38:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Sam James <sam@gentoo.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-hardening@vger.kernel.org
Subject: [GIT PULL] hardening updates for v6.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Linus,

Please pull these hardening updates for v6.3-rc1. Beyond some specific
LoadPin, UBSAN, and fortify features, there are other fixes scattered
around in various subsystems where maintainers were okay with me carrying
them in my tree or were non-responsive but the patches were reviewed
by others.

Thanks!

-Kees

The following changes since commit be0d8f48ad97f5b775b0af3310343f676dbf318a:

  bcache: Silence memcpy() run-time false positive warnings (2023-01-25 12:24:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.3-rc1

for you to fetch changes up to 78f7a3fd6dc66cb788c21d7705977ed13c879351:

  randstruct: disable Clang 15 support (2023-02-08 15:26:58 -0800)

----------------------------------------------------------------
hardening updates for v6.3-rc1

- Replace 0-length and 1-element arrays with flexible arrays in various
  subsystems (Paulo Miguel Almeida, Stephen Rothwell, Kees Cook)

- randstruct: Disable Clang 15 support (Eric Biggers)

- GCC plugins: Drop -std=gnu++11 flag (Sam James)

- strpbrk(): Refactor to use strchr() (Andy Shevchenko)

- LoadPin LSM: Allow root filesystem switching when non-enforcing

- UBSAN: Improve arm64 trap code reporting

- fortify: Use dynamic object size hints when available

- ext4: Fix CFI function prototype mismatch

- Nouveau: Fix DP buffer size arguments

- hisilicon: Wipe entire crypto DMA pool on error

- coda: Fully allocate sig_inputArgs

- copy_struct_from_user(): Add minimum bounds check on kernel buffer size

----------------------------------------------------------------
Andy Shevchenko (1):
      lib/string: Use strchr() in strpbrk()

Eric Biggers (1):
      randstruct: disable Clang 15 support

Kees Cook (15):
      fortify: Use __builtin_dynamic_object_size() when available
      ARM: ixp4xx: Replace 0-length arrays with flexible arrays
      LoadPin: Refactor read-only check into a helper
      LoadPin: Refactor sysctl initialization
      LoadPin: Move pin reporting cleanly out of locking
      LoadPin: Allow filesystem switch when not enforcing
      drm/nouveau/disp: Fix nvif_outp_acquire_dp() argument size
      ext4: Fix function prototype mismatch for ext4_feat_ktype
      io_uring: Replace 0-length array with flexible array
      net/i40e: Replace 0-length array with flexible array
      crypto: hisilicon: Wipe entire pool on error
      Merge branch 'for-linus/hardening' into for-next/hardening
      coda: Avoid partial allocation of sig_inputArgs
      arm64: Support Clang UBSAN trap codes for better reporting
      uaccess: Add minimum bounds check on kernel buffer size

Paulo Miguel Almeida (1):
      i915/gvt: Replace one-element array with flexible-array member

Sam James (1):
      gcc-plugins: drop -std=gnu++11 to fix GCC 13 build

Stephen Rothwell (1):
      rxrpc: replace zero-lenth array with DECLARE_FLEX_ARRAY() helper

 arch/arm64/include/asm/brk-imm.h            |  3 +
 arch/arm64/kernel/traps.c                   | 21 +++++++
 drivers/crypto/hisilicon/sgl.c              |  3 +-
 drivers/gpu/drm/i915/gvt/firmware.c         |  4 +-
 drivers/gpu/drm/nouveau/include/nvif/outp.h |  3 +-
 drivers/gpu/drm/nouveau/nvif/outp.c         |  2 +-
 drivers/misc/lkdtm/heap.c                   |  1 +
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 +-
 drivers/soc/ixp4xx/ixp4xx-npe.c             |  6 +-
 fs/coda/upcall.c                            |  2 +-
 fs/ext4/sysfs.c                             |  7 ++-
 include/linux/compiler_attributes.h         |  5 ++
 include/linux/fortify-string.h              |  7 +++
 include/linux/uaccess.h                     |  4 ++
 include/linux/ubsan.h                       |  9 +++
 include/uapi/linux/io_uring.h               |  2 +-
 lib/Makefile                                |  2 -
 lib/string.c                                | 10 ++--
 lib/ubsan.c                                 | 68 ++++++++++++++++++++++
 lib/ubsan.h                                 | 32 +++++++++++
 net/rxrpc/ar-internal.h                     |  2 +-
 scripts/gcc-plugins/Makefile                |  2 +-
 security/Kconfig.hardening                  |  3 +
 security/loadpin/loadpin.c                  | 89 +++++++++++++++++------------
 24 files changed, 229 insertions(+), 60 deletions(-)
 create mode 100644 include/linux/ubsan.h

-- 
Kees Cook
