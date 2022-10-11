Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C6AC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 19:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKTwz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 15:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJKTwy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 15:52:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63648DED7
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 12:52:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so14198203pjf.5
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36gaJztTD7Uu2ZW2RLea6uFAwy/jXLZpWVXv/XfktXk=;
        b=Ve10jUZNmwwesY9R1A80/NYL/FfWUbHXrhExvnW+e4bBQwh/VXhEWIe1rVNb6kNQO3
         Y/iGpkcCDUQ8Og6r7kTfPmy6pZJ3ULV64SzUSXsx4Q8999N2aHcnT4uQBYzkc6h6fGts
         e4mBsOK2LLjfX0V2jrrbWTg9tC7QjMGhYNZKDkHM5miX0X58+GsqJ9JM9uX9awi3EcLm
         lGQznNB81V81YvWMN57F+vd9TdBlGsfBaNxfVM7Iy9sLBx9iNeFGZiM0SvUqgUoEXtA2
         EwmqjC7HhRnwu9LAokQjlwG2d2GGNgzyKstUmJvRwdkxSo45WwMNuq/ymIgk2iWnxvho
         8CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36gaJztTD7Uu2ZW2RLea6uFAwy/jXLZpWVXv/XfktXk=;
        b=yKFtfBjWCT82PUtZ3GFJRzzn7TXE/w/uoeW71M4WI+c4ma/86JwXEZhtPkQ6UBg7Ig
         HUVj8QvJWX0+FPgEt5uk3C4lgtVlycS48aBigJBECMUD1iY2J9Wmh0Jlrk1NGmZTG7fY
         MQFkORrMPGaFmN2XR5VPdGwNRmZQHCfruYn2G38vnSg/V9n2j5kJOUE95rLQEx48H8ku
         5nl8EiCOzyyIFtAJNpX6s4Pp9V07X/leIpPyCF5gi8485kZhk+gtxAlugf5GKZvD7xGW
         7Q8aKflnQ4Vv3aQcakMv48ZWhVvVO/jgAwet4wBSU+FwGBtmcQWw7wO0t2n3A0/fRzIS
         /2yA==
X-Gm-Message-State: ACrzQf0L05nj+uQ1pX7U3oh8YSp6vjEkgqulQKseZ16yTPLrofY3H/M2
        6YPLVeox2ffhqUxBkLNaBD+eRgaGT/D86Q==
X-Google-Smtp-Source: AMsMyM6b/qVJbOYPS7tg5QgUOOoQo3VomJKaOtMazJqomEAVjhKZDan2ROXerFPGVONXDjOPaInHsQ==
X-Received: by 2002:a17:902:e547:b0:178:2aee:ab1d with SMTP id n7-20020a170902e54700b001782aeeab1dmr25332814plf.29.1665517972888;
        Tue, 11 Oct 2022 12:52:52 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id cp7-20020a170902e78700b00172a670607asm8889363plb.300.2022.10.11.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:52:52 -0700 (PDT)
Date:   Wed, 12 Oct 2022 08:52:47 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, cgel.zte@gmail.com
Subject: Re: [Self-introduction] - Paulo Almeida
Message-ID: <Y0XJjxP/BzoqZ+ts@mail.google.com>
References: <Y0JrBsGthQIiSzp+@mail.google.com>
 <202210101536.A46A0690@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210101536.A46A0690@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 10, 2022 at 04:22:48PM -0700, Kees Cook wrote:
> On Sun, Oct 09, 2022 at 07:32:38PM +1300, Paulo Miguel Almeida wrote:
> > My name is Paulo Almeida and as per the instructions listed on the KSPP
> > page, this is my self-introduction email :)
> 
> Hello! Welcome to the circus. :)
> 
Thanks =)

> >   writing a MOS 6502 emulator for the same reason.
> 
> Heh, nice. That made me wonder if there was a QEmu port, but it seems
> it hasn't been touched in a decade?
> https://github.com/AVEx-6502/qemu-6502
> 
> Is there a particular 6502 system you're working to emulate?
> 
Yes, there is. I am trying to emulate Ricoh 2A03 (RP2A03). That's the
slightly modified 6502 CPU used in the NES system. It's a really
well-documented platform so I chose that one to dip my toes in writing
virtualisation-related software.

> > I took the Linux Kernel Internals (LF420) and the Linux Kernel Debugging
> > and Security (LF44) courses by the Linux Foundation.
> 
> Cool -- did anything stand out for you in those courses?
> 
I'm easily amused by debugging/instrumentation techniques and the
kernel has so many of them for various specific niches.

What really stood out at the time was learning how versatile ftrace can
be to the point that this "debugging/tracing" utility is one of the main
gears of kernel live patching. Initially it felt wrong but after
wrapping my head around it, that was a very creative solution.

> > As for other experiences, due to the fact that I wrote my hobbyist OS, I
> > do have a decent experience with the x86/x86-64 architecture. I also
> > spent quite sometime writing static analysis parsers.... so should those
> > experiences help anyone or any possible future plan for the KSPP, please
> > count on me.
> 
> Great! One area that needs some review and testing that is x86-specific
> is the userspace CET support[3]. That spans a wide range of from chipset
> all the way up through compiler, kernel, and glibc. Getting more people
> to try that series out and post results ("it works for me" or "I
> couldn't trigger the protection", etc) would be very welcome.
> 
That sounds like it's my cup of tea :) I just finished reading the Intel
CET paper, it's an interesting approach with lots of things to be
tested. Thanks for the recommendation, I will get involved with that. 

> You've already found the "remove the 1-element arrays" work, and there
> are plenty more like that on the issue tracker. Trying to really put an
> end to strlcpy[4] is ongoing[5] too, as there has been a fairly
> concerted effort to remove them lately:
> 
> Count of "git grep strlcpy | wc -l" over recent releases:
> 
>          v5.17:  1535
>          v5.18:  1525
>          v5.19:  1507
>           v6.0:  1379
>         master:   544
>  next-20221010:   401
> 
Fingers crossed! I saw many patches for the strlcpy replacement so you
seem to be well covered for that... I will continue with the one-element
array changes and try to get involved with the support for Intel CET =)

Thanks for all the suggestions Kees!

Paulo A.
