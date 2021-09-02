Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04068C87FE2
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Sep 2021 16:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542DC615A7
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Sep 2021 16:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbhIBQTk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346300AbhIBQTk (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 2 Sep 2021 12:19:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 778E46187D;
        Thu,  2 Sep 2021 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630599521;
        bh=JcYHOKNx0hNjqmpLEEHso3KVVidsGV0+VqdBVx4KJ+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a6+vJTGRHe9Xk+46Babj4Gu37PjdCTzZYp0DfDtkOJqquwkr/5mOPt4qdYrECoU8t
         49oSyyN+AzKd/DqIfJ7DlWYaJJrRlGox7+furvQdwPKa66x9Te8SlUFYGKH+SCgb7o
         uNTQcaDM5ZWsyxuoR8pdw1g2F7At4e3p1XAQO145v1W5/+g6LTxWNEONuFXdbEpbkv
         jv6ZNJrcDavta44h8cPv1I6sjItQ1f/mzsAKR/dnB/AJgvgq/lkReFAhaLWvTmiOsF
         xdYsndBmLwUTtVzBXMQnoVNjY1SqfANX4zVIHMaeL8xtf97NFimFW2Tt36qW3MtCzT
         j1JEI1UPDLqPQ==
Received: by mail-ot1-f54.google.com with SMTP id i3-20020a056830210300b0051af5666070so3200908otc.4;
        Thu, 02 Sep 2021 09:18:41 -0700 (PDT)
X-Gm-Message-State: AOAM530NEJklET1K1auVD1gnvWx6mwsyR0aN/tJdaWxGQPNbQcIqf0ly
        C9e5xQi85MTlqOc2lwuQ/Ve7b5hIZpexuWtOUKI=
X-Google-Smtp-Source: ABdhPJxfaiUX2hrLyMECVCPFUe0KB68VWCzNVh8WiWCsq55R8cwzjxP/YB85hPhk+fGyzUWOXODcvPEpwiPMUcAX4EE=
X-Received: by 2002:a05:6830:444:: with SMTP id d4mr3261443otc.108.1630599520694;
 Thu, 02 Sep 2021 09:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210902155429.3987201-1-keithp@keithp.com> <202109020904.976207C@keescook>
In-Reply-To: <202109020904.976207C@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 2 Sep 2021 18:18:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGfQuEFOh79TZ089+9eP4S5svWgTMbZLugmD8Hq9b=fMQ@mail.gmail.com>
Message-ID: <CAMj1kXGfQuEFOh79TZ089+9eP4S5svWgTMbZLugmD8Hq9b=fMQ@mail.gmail.com>
Subject: Re: [PATCH 0/2]: ARM: Enable THREAD_INFO_IN_TASK
To:     Kees Cook <keescook@chromium.org>
Cc:     Keith Packard <keithp@keithp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Maninder Singh <maninder1.s@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 2 Sept 2021 at 18:07, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Sep 02, 2021 at 08:54:26AM -0700, Keith Packard wrote:
> > Placing thread_info in the kernel stack leaves it vulnerable to stack
> > overflow attacks. This short series addresses that by using the
> > existing THREAD_INFO_IN_TASK infrastructure.
>
> Very cool! Thanks for working on this. If you want, you can refer to the
> KSPP bug for this too:
> https://github.com/KSPP/linux/issues/1
>
> (Anyone want to do MIPS?)
>

I take it this breaks the GCC plugin based per-task stack protector,
given that it emits code to mask the stack pointer and apply an offset
to the resulting value.

It would be nice if we could replace this with something suitable for
THREAD_INFO_IN_TASK, and if it is suitable enough, try and get the
GCC/Clang folks to adopt it as well (which was never going to happen
for the stack pointer mask/offset approach)

Where can I find these patches? I don't see them on linux-arm-kernel@
