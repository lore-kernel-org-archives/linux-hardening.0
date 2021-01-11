Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8C8C433E6
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Jan 2021 09:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B516B22AAD
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Jan 2021 09:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbhAKJsQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Jan 2021 04:48:16 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38149 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbhAKJsQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Jan 2021 04:48:16 -0500
Received: by mail-oi1-f175.google.com with SMTP id x13so19506253oic.5;
        Mon, 11 Jan 2021 01:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jOrm8ll+s7jNprkJT0J7zNaUjthIV+pDL76/a4c54DU=;
        b=PNBywkWzBqnYBIoqHs9ZpzZJYN7a+pm2HgP+HuQlMEqAENzOL48QRVAUauhDvfu9Vi
         arGPIxx+Oeugdg2Dh22gHwvvNB6c30HLZg4aMQ8jhlkk37zf3BMvKw3/6m4UGCts6mX3
         C01UtR4OTPCLbAhuiake3QQHWAFyzKTYJ3UmBad6wqLYUYTs36d4crR7YTIU1dsLMg8K
         ioKthWXS6lYpHPEaQsl9GBBVzBJVhXo3qGwPgo3UpZJYh4ZT0L/B/MbBqW8tkqfl6omT
         1JzKjV6/bR4UJq/0b5ss3aRBTolQDjQlYOepnN4UKUMgo6lqpGLH6S0HN9ZmcTtihJay
         GN/g==
X-Gm-Message-State: AOAM533J5x8k8n+/uX+QiFWSRUIeIkFRW8ShROy3OWqpgxaUTM5obDwp
        A5EVDvxEmQAawPhLrSpmwtfCVBz42CMtBMexkd0=
X-Google-Smtp-Source: ABdhPJw4nFPjuYLSwzGtwjnQfDTZ1LMy+YocJGwymqsK0nMUwjkzg5ZXasOXcfThNiuX2VNvmxzE4Ph8aZl9+xEPYNw=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr9537249oih.153.1610358455220;
 Mon, 11 Jan 2021 01:47:35 -0800 (PST)
MIME-Version: 1.0
References: <82487.1609006918@turing-police> <160997457204.3687425.15622431721220616573.b4-ty@chromium.org>
In-Reply-To: <160997457204.3687425.15622431721220616573.b4-ty@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jan 2021 10:47:23 +0100
Message-ID: <CAMuHMdU1YSODgh_T5RxqUqorveAQiy_-gQbF_SwMEj7gvG25qw@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: fix gcc 11 indigestion with plugins...
To:     Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees, Valdis,

On Thu, Jan 7, 2021 at 12:11 AM Kees Cook <keescook@chromium.org> wrote:
> On Sat, 26 Dec 2020 13:21:58 -0500, Valdis Klētnieks wrote:
> > Fedora Rawhide has started including gcc 11,and the g++ compiler
> > throws a wobbly when it hits scripts/gcc-plugins:
> >
> >   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> > In file included from /usr/include/c++/11/type_traits:35,
> >                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
> >                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
> >                  from scripts/gcc-plugins/gcc-common.h:7,
> >                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> > /usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
> >  C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
> >    32 | #error This file requires compiler and library support \
> >
> > [...]
>
> Applied to for-linus/gcc-plugins, thanks!
>
> [1/1] gcc-plugins: fix gcc 11 indigestion with plugins...
>       https://git.kernel.org/kees/c/67a5a6801305

I guess this is the cause of the new "warning: invalid suffix on
literal; C++11 requires a space between literal and string macro
[-Wliteral-suffix]" with gcc 4.9 or 5.4?

https://lore.kernel.org/lkml/20210111094343.3948339-1-geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
