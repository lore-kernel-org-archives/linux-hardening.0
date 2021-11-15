Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE56C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Nov 2021 02:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11EB860FE7
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Nov 2021 02:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhKOCLL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 14 Nov 2021 21:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhKOCLK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 14 Nov 2021 21:11:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E281C061766
        for <linux-hardening@vger.kernel.org>; Sun, 14 Nov 2021 18:08:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r11so991433edd.9
        for <linux-hardening@vger.kernel.org>; Sun, 14 Nov 2021 18:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvrJWIznJS4VyR1Yj5O3vPS/1gMvDOExIbGNjdFADoo=;
        b=UJGHZxlj9YJbpiPTyqZ5/dKpQtr5UBHfZNqsufQJLqn7gOlYZTlfvu+iaOTlcf0p5d
         o37pQRzSI52YwjYX4ibruf+fLW91M+6PZmtH/pO2YeVbVKlF3cPJXsAC1cksmM3+M6CU
         Ga1CACEVifBqisLmcsjfAHeUlY+/Hbn19Pqh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvrJWIznJS4VyR1Yj5O3vPS/1gMvDOExIbGNjdFADoo=;
        b=rFBJxtlfD7eFCYT+XYapFWXwg2FtbezjXmvRVBGDHQCQqSJ1wLnCneT1ffAhgS1/5D
         OQlLqU09m8vQYaRxeG16AnaD0n0Ju0pt+6ZV5XnEeOq6dh/AvPx1XwtEe23CngRtfCyR
         N7/JCXTZB/CdXIUUTs83oJKM8fELUqnXUpPRIAQYQgVMhtr6qMUJec/RyulrZ/23Xoqq
         mxJzpju0zMFuasxlRgUbnx1myRH3jp0tRDVvjIVVG31RXAXp0sz7hBOftWAH8r92UHa2
         2kJoHWamcaHu1MngbldVrbzHv5YXLIqcIMDQupnPqg/XIKHoIfYjWt6lyEkYET3nopRE
         lR3g==
X-Gm-Message-State: AOAM530EfjD/GElHS8ryHAhTCpGBcnWEhpbc4uPJtB/CEc8k9xn9AdZz
        9S7BlDb7+a6E88WxARxIL98hsuZBk9Lh3d8k
X-Google-Smtp-Source: ABdhPJyPersANtdcJ2NkVlf98Fw5+fggVHECrLS5b+WkxMnRTUHmkLO/azImK1YUAaMy7i8inAch9Q==
X-Received: by 2002:a17:906:a08c:: with SMTP id q12mr44659137ejy.443.1636942093572;
        Sun, 14 Nov 2021 18:08:13 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id w24sm5684665ejk.0.2021.11.14.18.08.13
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 18:08:13 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so11172300wmz.2
        for <linux-hardening@vger.kernel.org>; Sun, 14 Nov 2021 18:08:13 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr52818640wmq.8.1636942092763;
 Sun, 14 Nov 2021 18:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20211115011313.GA43897@embeddedor>
In-Reply-To: <20211115011313.GA43897@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 18:07:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaJCEwqKbekSNjziY4RMTKzkRkkrOM4MEZQEo0j3HT=Q@mail.gmail.com>
Message-ID: <CAHk-=whaJCEwqKbekSNjziY4RMTKzkRkkrOM4MEZQEo0j3HT=Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix -Wimplicit-fallthrough=5 error for GCC 5.x
 and 6.x
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Nov 14, 2021 at 5:08 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> -Wimplicit-fallthrough=5 was under cc-option because it was only
> available in GCC 7.x and newer so the build is now broken for GCC 5.x
> and 6.x:

Annoying. And I obviously never saw it because I don't carry ancient
compiler versions.

That said:

> -       default "-Wimplicit-fallthrough=5" if CC_IS_GCC
> +       default "-Wimplicit-fallthrough=5" if $(cc-option,-Wimplicit-fallthrough=5)

I think it would be better to keep the CC_IS_GCC part of the test, for
the simple reason that the clang "make config" is already very slow.

I'm not sure why, but it's annoyingly noticeable, and I've complained
about clang performance before in this area (and the likely cause is
the default build for clang being this horribly inefficient shared
library setup, so it spends ages just doing dynamic linking)

Whenever I do "make oldconfig" with a clang build, and my machine is
under any reasonable load (typically because I'm also doing another
build in another terminal at the same time), it takes several seconds.

Doing the same thing with gcc is noticeably much faster.

In fact, it doesn't even need to be a very loaded machine, this is
basically an empty "re-do config" with gcc vs clang (basically same
config, except obviously for compiler-induced config differences):

  gcc$ time make oldconfig
  real 0m0.929s

  clang$ time make oldconfig
  real 0m1.917s

Two seconds may not seem like a lot, but when the machine is under my
usual build load, that almost 2s easily becomes a "do I need to go for
coffee" delay, since I'm just waiting for the config to finish before
I start the build (since I may end up having to answer questions).

And yeah, it's sad how much faster gcc is.

There was a time when the clang people were proud of their
compile-time performance. Pepperidge farm remembers.

Anyway, I'd prefer to not ask for the clang build to do even more
work, since we know it will fail that '=5' case.

             Linus
