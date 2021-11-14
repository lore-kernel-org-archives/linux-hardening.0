Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D73C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 14 Nov 2021 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DBF60FDA
	for <linux-hardening@archiver.kernel.org>; Sun, 14 Nov 2021 21:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhKNV2z (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 14 Nov 2021 16:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbhKNV2r (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 14 Nov 2021 16:28:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C25C061767
        for <linux-hardening@vger.kernel.org>; Sun, 14 Nov 2021 13:25:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z5so2916887edd.3
        for <linux-hardening@vger.kernel.org>; Sun, 14 Nov 2021 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZSSynsKcz8SQQ9wlQiwyLd1LjN5A0/Q7Az2vBog8fs=;
        b=f/viiwPOa9QV59R4dkB8sPRey//vAi2MFsdmXxOnQDPgzBE5u6TsL8/xevZYp8DEoj
         E9DBrfwFkIxLTkn+Ciwp2Pk5aalk/Tl6op7yjcFs+9R219irGePGGHcCsQImGNUgixv8
         J51bTeoO3LyQrNlcHCfVtoFUoRdWd7B/iriEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZSSynsKcz8SQQ9wlQiwyLd1LjN5A0/Q7Az2vBog8fs=;
        b=7evk5X/BOILOu8Y/ni54nx7GmVUH6Qe3b1SBrxukzFXKlemKoXrEtL1df2b17kX2nz
         DTVZicTFF3nL4Qsh5jiOklGNnfbkIRq4NevQqJ6bhxCsdrS9yyIE5uSCj38jMxvSMmgb
         DwB7U0Dv+5exLyubk4vMd5u12Buy9Qs3hhi0zBk0nSO5qVXEYfbspo1PH9TV4u7xvNfK
         H5bf8DII0Ivht5+7F6qyN58xYYpmf/NQW1jMGAlonjGttXSCgIFLjbWm03Qlv2OlD+lJ
         kXeZLSkGdgALYXGrG1MpiqYY7QwJiMm16ngOwSxsdBdfZ00iS8z86hgS11rvz7HOSii9
         ma3Q==
X-Gm-Message-State: AOAM533hMBH97nKK4WhWwr4CfWK62jvqGiLjiDdkKSQuzWoaaotmv6XI
        BJgLbCerss+94DtO+0OjVcD+tc2HfWIWYcyd
X-Google-Smtp-Source: ABdhPJyy1GpQq+uIUa631wLZq7RyhY1eZfprzIwkOuRg19Le3gnTK9g5CC5JsDwkBc1C/J72D+2WcA==
X-Received: by 2002:a17:907:8a12:: with SMTP id sc18mr43419024ejc.274.1636925150473;
        Sun, 14 Nov 2021 13:25:50 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id w24sm5446516ejk.0.2021.11.14.13.25.48
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 13:25:49 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso8930866wmr.4
        for <linux-hardening@vger.kernel.org>; Sun, 14 Nov 2021 13:25:48 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr51964221wmc.152.1636925148688;
 Sun, 14 Nov 2021 13:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20211114005725.GA27075@embeddedor> <YZF9MY6rRLQwdTgM@archlinux-ax161>
In-Reply-To: <YZF9MY6rRLQwdTgM@archlinux-ax161>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 13:25:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgqEfw1wFcj98VxyvnoDsUhmYm_P_KuFOpEWe5zmYAp1w@mail.gmail.com>
Message-ID: <CAHk-=wgqEfw1wFcj98VxyvnoDsUhmYm_P_KuFOpEWe5zmYAp1w@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add support for -Wimplicit-fallthrough
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Nov 14, 2021 at 1:18 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> It feels a little odd to have this in Kconfig but if it works and gets
> the warning enabled, then so be it.

We've actually been actively moving more and more of the compiler
flags configuration to Kconfig time.

The Kconfig language makes it fairly easy and natural to do these
days, and in some cases the compiler flags end up having a number of
other dependencies (not in this case, but look at things like
CC_HAS_KASAN_GENERIC etc, where the existence of some compiler flag
ends up then also affecting whether other options can be enabled).

So the whole "move it to config time" ends up being the direction
we've been going, and the only really unusual case here is that it
ends up being done as a string config rather than as a boolean.

And that's just because the different compilers also have different
flags in this case ;(

              Linus
