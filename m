Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE8C433EF
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 18:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A3D60E73
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 18:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhIESXO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 5 Sep 2021 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhIESXO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 5 Sep 2021 14:23:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D3C061757
        for <linux-hardening@vger.kernel.org>; Sun,  5 Sep 2021 11:22:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s3so7304045ljp.11
        for <linux-hardening@vger.kernel.org>; Sun, 05 Sep 2021 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuzVizyAuYqHM0AliftUFw5ek+vQ04sENoGLph3J4G8=;
        b=AIFCfiSSpGgY7MUaHEa3Qj4MKzCJxCu0f6raW0F39EQvOva5pXNOooqwk5WLrYzBfM
         NuO+/AshqrQSL9zlmUOYTsetjWA2F16etVq3ZYxSdEu7BRnbZxAH0vF2j9gSHIJrzVz9
         ZkOeBSiFuWw/3g0HD+rnzcW/qkb65bbSttM54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuzVizyAuYqHM0AliftUFw5ek+vQ04sENoGLph3J4G8=;
        b=Lr9WYlwwE7hpzSkoC80yVrni2YREdCYSJMEOadCZAe1WA6AZo8jp8BqPURoF61j/y1
         luMrUwAGF54ayCetzUQS2gyq2SA2S9AKw3bwtiXLr+pSf6St69o/judw3VdmjBoXpT/z
         3QRNxckotWWNCC//01LPTwmT1CSB0caoHIdIoNBxzC4zYS6vgVoz4g5JjxwNdazclICx
         iIqcAVZj4/0rTuYihN4oyj/BnvGYS6IR5VY9cbvsz/P9qkEFiH5GzTohsJXlQsse1tOI
         +90sLkDOmiEUyw1cgFHIG7Uh13kR4AAazbFJF53joy4GatSuiWVj2t+mmEeW6OAxP8CX
         pZ5Q==
X-Gm-Message-State: AOAM532nCcDT8fHGXP8Wp4mPpYA7OU2bA05LoCATXJOJmczOeDQ6RySi
        2r6s3o4uHdkIGWT9mc8tAbKoddaOudvFVkWhe5I=
X-Google-Smtp-Source: ABdhPJyAxQSLnLXbxxAs0BkuxBwiebAQsg1gj9qcMgnA166poArYJVYWdSEFjHxmJGOTwIMVIxMkwA==
X-Received: by 2002:a2e:a4dc:: with SMTP id p28mr7451381ljm.61.1630866128229;
        Sun, 05 Sep 2021 11:22:08 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id f20sm781658ljc.81.2021.09.05.11.22.05
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 11:22:06 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id j12so7294532ljg.10
        for <linux-hardening@vger.kernel.org>; Sun, 05 Sep 2021 11:22:05 -0700 (PDT)
X-Received: by 2002:a2e:96c7:: with SMTP id d7mr7555806ljj.191.1630866125415;
 Sun, 05 Sep 2021 11:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <202109022012.756B6B5B79@keescook> <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
 <45312958-B844-4B4C-9808-8205866675A1@chromium.org> <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
In-Reply-To: <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Sep 2021 11:21:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4EG=kCOaqyPEq5VXa97kyUHsBpBn3DWwE91qcnDytOQ@mail.gmail.com>
Message-ID: <CAHk-=wj4EG=kCOaqyPEq5VXa97kyUHsBpBn3DWwE91qcnDytOQ@mail.gmail.com>
Subject: Re: [GIT PULL] overflow updates for v5.15-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Sep 5, 2021 at 10:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sadly, I don't think linux-next checks for warnings.
>
> I really want to enable -Werror at some point, but every time I think
> I should, I just end up worrying about another random new compiler (or
> a random old one).
>
> We do have -Werror in various configurations (and in some sub-trees).

Whatever. I'll just make a new config option, make it 'default y', and
it will be on for anybody doing allmodconfig builds etc.

And if people have new compilers, or odd configurations that still
cause warnings, they can turn it off, but hopefully this will make
compiler warnings in linux-next (or any other automated builds) cause
a lot more noise.

              Linus
