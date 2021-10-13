Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1101C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 17:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34CA60E54
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 17:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbhJMR75 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhJMR74 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 13:59:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF3C061760
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k26so3171700pfi.5
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tovZs/fMamUNhc9V1ZyRuitMxRBIyX1nI5NaXzCb1hY=;
        b=G2qErgjv5HIfhOUry8jDhzJppHdZE25hAmIYtv/loO+niQCfapFhBGvRWsOBJLizPg
         AWT7H19YivWexKf2RxMOYI7qy7LBwic4NCRwwvkEPxTK85KAECjiBduVd79ggD6MNlQ3
         PwMusKJy8PAMRDONeipR+AKRPwnMTeTPncnCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tovZs/fMamUNhc9V1ZyRuitMxRBIyX1nI5NaXzCb1hY=;
        b=pI9OsgFPYs26PiiaB31f1DVZTTqbEe0MAVD5z7YPynRyjytxCJKi8ywga7AqmV1SxC
         667iJP53hnRQKmLZVfdsd+w4mSMJsdMq24pmrlKc9lNfRyxXFKsb57dYgXJrssAL8s4/
         /IgFjBJ//QFfDKQhFDd5ijzvxei4VNSvrQZ0T/Xc4zMRTHE2SKjUGERrqMYCaSFHDR/+
         rUj8YoHA6tgFIHSI0hOnC56DNBUg1XGW3XlwW09jR06k/ADE+OXpbPD9vvYbhhTU/QQb
         AKizoRbslH/4lGmbnB8YR5TM9MJwPdE9BcTd1ttAWoJxzbmJKpRgX2gSMrIDf692E2Qm
         nK3g==
X-Gm-Message-State: AOAM530gyvbx+F1+X001zcx4AGYIuc9Ed5Lq5JqYLJAfeDXaHFfR9r5+
        NXSR5142uQhtyGMhnZsHdRH2QA==
X-Google-Smtp-Source: ABdhPJzCKTW81GqeouHKZKjp+D5/8WyFEtj3voLvuSJY69lPRmI2Nh2pCbNkaKmEWld21LKZUBGxgQ==
X-Received: by 2002:a05:6a00:8c7:b0:44c:a7f9:d8d1 with SMTP id s7-20020a056a0008c700b0044ca7f9d8d1mr756635pfu.49.1634147872423;
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d67sm155299pfd.151.2021.10.13.10.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/4] x86: Various clean-ups in support of FGKASLR
Date:   Wed, 13 Oct 2021 10:57:38 -0700
Message-Id: <20211013175742.1197608-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; h=from:subject; bh=PRf65j0JLkeyuy0M8f8WYpGBuH2Z9LGCXYFpyuGxQQ4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhZx4UR5tiE4MGhsX6k9YeysDLLv8D+UhwbD5cdGmc M3oPcB6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYWceFAAKCRCJcvTf3G3AJsetD/ 9jqt/mMainURcBkfvabgTOLY7SRxtWhpfdp++dz9638RboQjKK/pgK1aMBtMqEAT0nvJtZGoM2JGjl V+W0N3WaIATR8h73k+fgtgD2zIagC7IibIhV06Tj3tSztXwCvEe+tMaQEfpYFaaNc/Tw5lFpcx4AKx eOphkWsQSvzyQIq1F6dX7QXLn5HZjCQB5QAOo21siALDbAAExXUqGoc1W96ILJuAVCg3nJCP92pADz gOfRDCvPwI+1/WEdpe8qgDpI+EhrRs+3z+D1sBi3S+WsQthGxnoj+Cr8yYyeOih10wCOnixEutJAo6 0jhz01Bn5Wv78B0vwxSp2uPs1Qw2mf5zsDwbQdCaqj+cQbqEcyTNRlxcwsAkgU1V5oSYh5XyNbORRM pxZxmtir61MsEkHgx8juWagLoab5D7Tszt5m6y0a+y0CpqFjR98b+P2jLHtN9j83QEnE+lYx8pXH9k VER+Yrzu6DTNobQcAwJiObxxWzRnvrmHqfU49BF92SBkov6axqsXziXbS5fjRJmN6ZceJpeCW7SvIA XRdw/QgHEV2Wf/dyRZAPBySso5Dra6Ry1KaDBHtULwsy7NCjSLZQupWLz/v/Q9/yDafPmMJmkMN6GK 6vru6cw6mIsWUB6Fwck+eMzTdtk1gEuxfrDG3sD2Q+pNjVW9752yKR7iCnXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

These are a small set of patches that clean up various things that are
each stand-alone improvements, but they're also needed for the coming
FGKASLR series[1]. I thought it best to just get these landed instead
of having them continue to tag along with FGKASLR, especially the
early malloc() fix, which is a foot-gun waiting to happen. :)

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20210831144114.154-1-alexandr.lobakin@intel.com/

Kees Cook (2):
  x86/boot: Allow a "silent" kaslr random byte fetch
  x86/boot/compressed: Avoid duplicate malloc() implementations

Kristen Carlson Accardi (2):
  x86/tools/relocs: Support >64K section headers
  vmlinux.lds.h: Have ORC lookup cover entire _etext - _stext

 arch/x86/boot/compressed/kaslr.c  |   4 --
 arch/x86/boot/compressed/misc.c   |   3 +
 arch/x86/boot/compressed/misc.h   |   2 +
 arch/x86/lib/kaslr.c              |  18 ++++--
 arch/x86/tools/relocs.c           | 103 ++++++++++++++++++++++--------
 include/asm-generic/vmlinux.lds.h |   3 +-
 include/linux/decompress/mm.h     |  12 +++-
 7 files changed, 107 insertions(+), 38 deletions(-)

-- 
2.30.2

