Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CCAC54EAA
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Jan 2023 18:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjA0S7l (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 13:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjA0S7k (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 13:59:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16913403E
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 10:59:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso8935265pju.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 10:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FSfRUNSPzw6WDGkk9NuSWJ20Yk15j/9mQUC20/ywjM=;
        b=JbJ16pBT7IqjxBNPjSK5CDUwVUGhR/OnugwG+wWGEsBW1javshnmaTNBawxGtiCTdp
         hjeUc/BFKBLrv2j6Vkzr04dBesVNUv3Ybtgjww3OoV+TcgrPoKLH1c8jWFvG3t1VdV9n
         lLMGQtj07HEe4CIosgl0RZmz4koECGboCUjTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FSfRUNSPzw6WDGkk9NuSWJ20Yk15j/9mQUC20/ywjM=;
        b=zOw102SjEHs1yHc3ezyv45ycf7ynBqt94aJAB70GhUM6DAUkoT+BeBX65CHxsqcOTo
         F8+R6QgS3Ey8aFAH4Ib2SnKpYSgBJ00jXPcD+dNV0/riPmx7I+6PaKZIy7RA2X2vG3wU
         IKCGpaBnr9gZoalhvIF6lYSYFOKokE3kiNshcxUTHb9SgLLo5lKP/SysxSsFONSK6TAi
         +sLcMGPcSp7uQp5NawISXrm++/j7nQah3jhdVprlJUJu9Ykq1GfeDSGc6RHB5BltxGfy
         z2lb2LmVnYPlqiLpxg0As2U1KKQvaD9DI9UpO081OpmnLb8Wx3FaZTIO+xo1QbcwWb5K
         4xVg==
X-Gm-Message-State: AO0yUKVT6sIxS9NpTbedmWVIJZZH+2i198QSq5qL9mN8oAMyF7eUl7bs
        WNHLBqMWVdR59asPPDK8FoDekQ==
X-Google-Smtp-Source: AK7set+R7u95YSQFcv8aA/dNQLjtSYZGUroZHCcbUYOQbH7Or+Zjje8xrH69dqdpqZ+AwKANkcV7Jw==
X-Received: by 2002:a17:903:234b:b0:196:595b:2587 with SMTP id c11-20020a170903234b00b00196595b2587mr2888516plh.20.1674845979328;
        Fri, 27 Jan 2023 10:59:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b00194799b084esm2395292plr.10.2023.01.27.10.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:59:38 -0800 (PST)
Date:   Fri, 27 Jan 2023 10:59:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Pereira <alexpereira@disroot.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Coly Li <colyli@suse.de>, David Gow <davidgow@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [GIT PULL] kernel hardening fixes for v6.2-rc6
Message-ID: <202301271058.9A715143C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Linus,

Please pull this small set of kernel hardening fixes for v6.2-rc6 that
haven't gone via other trees.

Thanks!

-Kees

The following changes since commit 42633ed852deadc14d44660ad71e2f6640239120:

  kbuild: Fix CFI hash randomization with KASAN (2023-01-13 15:22:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.2-rc6

for you to fetch changes up to be0d8f48ad97f5b775b0af3310343f676dbf318a:

  bcache: Silence memcpy() run-time false positive warnings (2023-01-25 12:24:50 -0800)

----------------------------------------------------------------
hardening fixes for v6.2-rc6

- Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST

- Reorganize gcc-plugin includes for GCC 13

- Silence bcache memcpy run-time false positive warnings

----------------------------------------------------------------
Kees Cook (3):
      kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
      gcc-plugins: Reorganize gimple includes for GCC 13
      bcache: Silence memcpy() run-time false positive warnings

 drivers/md/bcache/bcache_ondisk.h | 3 ++-
 drivers/md/bcache/journal.c       | 3 ++-
 lib/Kconfig.debug                 | 9 +++++++++
 lib/memcpy_kunit.c                | 2 ++
 scripts/gcc-plugins/gcc-common.h  | 4 ++--
 5 files changed, 17 insertions(+), 4 deletions(-)

-- 
Kees Cook
