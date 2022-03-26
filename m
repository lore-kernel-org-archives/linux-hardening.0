Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B97BC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 26 Mar 2022 19:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiCZTbz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 26 Mar 2022 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiCZTbz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 26 Mar 2022 15:31:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8F932064
        for <linux-hardening@vger.kernel.org>; Sat, 26 Mar 2022 12:30:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p15so18550252lfk.8
        for <linux-hardening@vger.kernel.org>; Sat, 26 Mar 2022 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfLtMPKWOgtbixf5r664NcyfUg09ely2U/JmDYjA8BY=;
        b=F+3ZVjB7BCSCLcZtwiPvR46BWAJVWdiaN3i439/aLf4lD0vcChmXZbsSzeMY76YnAP
         RENdKWXQ/ux4mV+RSnrCv9PyYnLL2iFG+BKvgFzACMUl6/c2Z2wMhjk96WLCFrW6tOyb
         ViEQgfC6S4WqObuYEM6u9bBkGdgNiFF6lCkqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfLtMPKWOgtbixf5r664NcyfUg09ely2U/JmDYjA8BY=;
        b=d044VFOC5lDJHCQBk8XOvuzJJGuEgQIOhmboV8cSzx5uHQ+O8huaND0/lp61oGeTVO
         27Uk33nOCViEAM/TKZPRaIeO0vRlzphOLCctRaZAlUOogvTdZtetLt2AnIGLXdAba015
         EZUVelmSG3C7MnZ8PY45IbL3zyehd6GlALt7OWMTi4hOEylCLQZRk6zJjyA7VlmYX14N
         JH7LFLr2ysHu00eURjkR76x9F8Ptn5vp2TZ0t2aZD+aFxgoKgd1jmXLG6JAnrp++stXy
         l5PpS2TSFpo7D73Q9NRyebHEw9bvhvNCCa+wiwRtxQpzaCn6enQ7cKQomQ9I75kK7VE9
         EsoA==
X-Gm-Message-State: AOAM532KTrjWggq7a0ssU5IjY9ppt4qVZH9hS/K00vuYwgofITflwIiD
        lVZ43cYKmP5AYCkDa2qftdc3mrqtjpy3oFusiR4=
X-Google-Smtp-Source: ABdhPJyyWTWMh5ue+rD2F+fxAv1zsdaYBP/SVWmuGikvm5vVBLULEa/nerkBhpycdemVDamqbkH9Ng==
X-Received: by 2002:a05:6512:1690:b0:448:2372:3e3e with SMTP id bu16-20020a056512169000b0044823723e3emr13225033lfb.324.1648323015984;
        Sat, 26 Mar 2022 12:30:15 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o2-20020a2e7302000000b00249820fb8c5sm1108192ljc.4.2022.03.26.12.30.13
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 12:30:14 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id p15so18550116lfk.8
        for <linux-hardening@vger.kernel.org>; Sat, 26 Mar 2022 12:30:13 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr12850936lfh.687.1648323013613; Sat, 26
 Mar 2022 12:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <202203251443.9BBADFD98@keescook>
In-Reply-To: <202203251443.9BBADFD98@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 12:29:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeGc-BjkDWTYkXzyQu-vf9EEujuT-6=U7Od0DvCUfb8w@mail.gmail.com>
Message-ID: <CAHk-=wjeGc-BjkDWTYkXzyQu-vf9EEujuT-6=U7Od0DvCUfb8w@mail.gmail.com>
Subject: Re: [GIT PULL] FORTIFY_SOURCE updates for v5.18-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 25, 2022 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
>
> It looks like all the dependent trees with related buffer fixes have been
> merged (I was waiting for the scsi tree to get pulled). This has been
> in -next for almost 2 development cycles, and I did overnight build
> testing merged against your tree under the following combinations,
> with no new warnings (there is one Clang 14+ specific issue in
> drivers/net/ethernet/huawei/hinic that we're still tracking down as a
> likely compiler regression[1]):

So how much of this is _completely_ compile-time?

Right now it looks to me like FORTIFY_SOURCE ends up doing two things

 - added runtime checking based on compile-time sizes

 - compile-time errors

How hard would it be to separate the two issues out?

Because if all the compiler issues and warnings have been sorted out,
it sounds to me like the compile-time side could/should be done
unconditionally if there are no runtime downsides.

Hmm?

                Linus
