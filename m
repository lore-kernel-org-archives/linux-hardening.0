Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49363FA3742
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Oct 2022 19:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiJ0TDb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Oct 2022 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiJ0TDa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Oct 2022 15:03:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE805C4F
        for <linux-hardening@vger.kernel.org>; Thu, 27 Oct 2022 12:03:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so2338731pjd.4
        for <linux-hardening@vger.kernel.org>; Thu, 27 Oct 2022 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9re30L3Qf1nWwfY1dsIhAySAPn0ZrFVWEIZ6hesyg0=;
        b=fnIImG0iDucSTCyvxGTxY3d9lDdBvL7ROo88gDYrVx3xsPfdBvt1S2y+w/INuTYEWz
         FtNj8P0QY4I+xSWJssWO3K96FRG7Xcdw9VF/dwMA7x7XsCoenHjoq94xVVxrfqn1cvwG
         VA5mWwTUi7/N9k0hUuttlg+nynQ7Fixhdd/to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9re30L3Qf1nWwfY1dsIhAySAPn0ZrFVWEIZ6hesyg0=;
        b=YZh1KQkjKFI1xZWrbYuG5NpqY/AAJY6i5rLVFpmCPDgfGOPqgDTa94+zPM2F3E261s
         /nYLyBYNxO0Rs6Nwq93tmwTSWmOneR5obSPtqqfh3zd1OWhAFlRfBWMhiLGhXu+iPUv1
         8Maosr/DyaecCYv1yBSbIke3xfhL8CPY6HzahIti9yUcFEfLkMGywpP4QJHOC0eVpYzW
         bmrFEYn15Zx8kimMx7dJLjnuvCYEtr/LXkrzshKtWJa3Zx5bSVgEsoWc0ZrZmoMviiut
         TAYVVB+oYko+lnqcxe9F5I2Jqd2f9mEIAsWhvM91Pj0LYCZX3AnVEe7ls7kroRmgP1dR
         ef1Q==
X-Gm-Message-State: ACrzQf3qzJY7f/RYF9yH3ftrb6gYEVG3lUy51gWWaBtiMPRgxrRjTZWq
        pF3dD0epTDg7PnvwL9dC89lgPQ==
X-Google-Smtp-Source: AMsMyM6uuk3qiJ1+V1Zd5xs1pexoyzJGJiyIkrfAYgcsIlVtEeXMZwR4mhWPlpFWNxoVtEGbOx9Oew==
X-Received: by 2002:a17:902:f683:b0:184:d45b:a096 with SMTP id l3-20020a170902f68300b00184d45ba096mr49382092plg.23.1666897409281;
        Thu, 27 Oct 2022 12:03:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a46cf00b0020a0571b354sm1276584pjg.57.2022.10.27.12.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:03:28 -0700 (PDT)
Date:   Thu, 27 Oct 2022 12:03:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: [GIT PULL] hardening fixes for v6.1-rc3
Message-ID: <202210271203.1CABE4152@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Linus,

Please pull these hardening fixes for v6.1-rc3.

Thanks!

-Kees

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc3

for you to fetch changes up to 72c3ebea375c39413d02113758319b74ecd790bd:

  overflow: Refactor test skips for Clang-specific issues (2022-10-25 14:57:42 -0700)

----------------------------------------------------------------
hardening fixes for v6.1-rc3

- Fix older Clang vs recent overflow KUnit test additions. (Nick
  Desaulniers, Kees Cook)

- Fix kern-doc visibility for overflow helpers. (Kees Cook)

----------------------------------------------------------------
Kees Cook (2):
      overflow: Fix kern-doc markup for functions
      overflow: Refactor test skips for Clang-specific issues

Nick Desaulniers (1):
      overflow: disable failing tests for older clang versions

 Documentation/core-api/kernel-api.rst |  6 +++++
 Documentation/driver-api/basics.rst   |  3 ---
 include/linux/overflow.h              | 38 ++++++++++++----------------
 lib/overflow_kunit.c                  | 47 +++++++++++++++++++++++++++--------
 4 files changed, 58 insertions(+), 36 deletions(-)

-- 
Kees Cook
