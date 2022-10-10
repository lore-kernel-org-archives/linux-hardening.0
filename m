Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00761C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 10 Oct 2022 23:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJJXWy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJJXWw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 10 Oct 2022 19:22:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D247E30A
        for <linux-hardening@vger.kernel.org>; Mon, 10 Oct 2022 16:22:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so10497085pjl.0
        for <linux-hardening@vger.kernel.org>; Mon, 10 Oct 2022 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QF7MJOsOtlsQC0EmDUWgyeJyWHdhi+4+5WgA2w3JC3g=;
        b=BkShfqF8SyhtiqZT6gE3y8zPoxJMuIQH4Onh7QKoPkYRNvKmcggwoJaeo/uV3YctSC
         wtbL9DvhBagPC2lx2jXewV6r0qCXPwsLj3TgJKvqISfzlnBLfhGIlFZ9UGxKHKFzorrm
         Zr43goG23541zjyV+AcKGtPLj/KIvCcNlePAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF7MJOsOtlsQC0EmDUWgyeJyWHdhi+4+5WgA2w3JC3g=;
        b=WKNNDBDreokayPWzB71j98cvv/kRwQ14yxlxdGXx+pmliS+5plFtzoAxBJEkBjxtv+
         YpG1mJWQUT9YyrMGECOHvagoCC7sl3GTvXDNHaOj3I8bY5zJ2RGyUqrN1P6H8rLzC9K8
         Px26wiaCPVF7Hin5mdXf9WJUSHBXnzSX4CQViP3wZQctvCJSaL+JnGCgHVj7eemEMPK/
         rzd1LPHutBMZXYFeHQ0aRJwLej5AR8XYmmklv6Ur/kuRIEuv9CWINaLjXyN0Ac63oBWB
         rnlR1+JkXPNcdKUV5MMZHy+w3kj1TQTjEshKXZKN97Pxo4aI6ob8vuxbdMMr/CHAFOXI
         GKgw==
X-Gm-Message-State: ACrzQf3rcFydysG+9DCDN0KY94MY/VbReAl9iBlnR3DpmIABmHEA0Ewl
        XpSN7ZMyn3HTu/ipdrpz0xF3ZjjjPSEtSA==
X-Google-Smtp-Source: AMsMyM5/cujdcT78gRxEog7IR5B+lzupMRJjfjRQboVnh0oymMYyQqzGt6abkUA4YnXyYMd+Nr6iug==
X-Received: by 2002:a17:902:f70e:b0:178:8895:d1fb with SMTP id h14-20020a170902f70e00b001788895d1fbmr21795386plo.166.1665444170373;
        Mon, 10 Oct 2022 16:22:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mp17-20020a17090b191100b0020d24ea4400sm3658254pjb.38.2022.10.10.16.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 16:22:49 -0700 (PDT)
Date:   Mon, 10 Oct 2022 16:22:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, cgel.zte@gmail.com
Subject: Re: [Self-introduction] - Paulo Almeida
Message-ID: <202210101536.A46A0690@keescook>
References: <Y0JrBsGthQIiSzp+@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0JrBsGthQIiSzp+@mail.google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 09, 2022 at 07:32:38PM +1300, Paulo Miguel Almeida wrote:
> My name is Paulo Almeida and as per the instructions listed on the KSPP
> page, this is my self-introduction email :)

Hello! Welcome to the circus. :)

> I will keep it short. 
> 
> - My background is in HPC and AI 
> - I've been writing software for around 20 years now
> - I've written my x86-64 hobbyist OS for fun and in my spare time I've
>   writing a MOS 6502 emulator for the same reason.

Heh, nice. That made me wonder if there was a QEmu port, but it seems
it hasn't been touched in a decade?
https://github.com/AVEx-6502/qemu-6502

Is there a particular 6502 system you're working to emulate?

> - Contributing to KSPP is going to be a side project of mine that I plan
>   to do outside of business hours... so expect a dedication of a few
>   hours per week.

Excellent! We're always glad to have folks helping.

> Q: What topics are you interested in?
> A: kernel driver development, x86 & ARM hardware architecture, Math, Data
> structures, Rust and virtualisation.
> 
> Q: What do you want to learn about?
> A: I see the KSPP project/initiative as a way to get exposed to pieces
> of code that I wouldn't normally come across which is always
> appreciated :)

Yeah, you'll end up uncovering some really weird stuff, as you seem to
have already found[1]. ;)

> I am also aware of the calibre of developers I will be dealing with and
> I'm sure that I will be learning really a lot from them :)

One of the double-edged swords with KSPP is while you get to work with
all the kernel's subsystem maintainers, you also have to work with all
the kernel's subsystem maintainers. ;) You'll learn a lot, but you can
also end up discovering very different requirements as you send patches.

> Q: What experience do you have with security, the kernel, programming, 
> 	or anything else you think is important.
> A: 
> I've contributed to the kernel a few times time in the past for both
> adding features and janitorial tasks.

Excellent! Yeah, it looks like you've been helping clean up some staging
drivers[2].

I see you touched rtl8192u -- there's a lot of duplicate code spread
around in the rtl* drivers. It would be interesting to see those
consolidated some day. If you're interested, it may be worth asking
about it on the wireless list.

> I took the Linux Kernel Internals (LF420) and the Linux Kernel Debugging
> and Security (LF44) courses by the Linux Foundation.

Cool -- did anything stand out for you in those courses?

> As for other experiences, due to the fact that I wrote my hobbyist OS, I
> do have a decent experience with the x86/x86-64 architecture. I also
> spent quite sometime writing static analysis parsers.... so should those
> experiences help anyone or any possible future plan for the KSPP, please
> count on me.

Great! One area that needs some review and testing that is x86-specific
is the userspace CET support[3]. That spans a wide range of from chipset
all the way up through compiler, kernel, and glibc. Getting more people
to try that series out and post results ("it works for me" or "I
couldn't trigger the protection", etc) would be very welcome.

You've already found the "remove the 1-element arrays" work, and there
are plenty more like that on the issue tracker. Trying to really put an
end to strlcpy[4] is ongoing[5] too, as there has been a fairly
concerted effort to remove them lately:

Count of "git grep strlcpy | wc -l" over recent releases:

         v5.17:  1535
         v5.18:  1525
         v5.19:  1507
          v6.0:  1379
        master:   544
 next-20221010:   401

Thanks for introducing yourself!

-Kees

[1] https://lore.kernel.org/linux-hardening/Y0IsXXYnS4DnWkMW@mail.google.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=Paulo+Miguel+Almeida
[3] https://lore.kernel.org/lkml/Y0IsXXYnS4DnWkMW@mail.google.com/
[4] https://github.com/KSPP/linux/issues/89
[5] https://lore.kernel.org/lkml/?q=s%3A%22use+strscpy%22
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=strlcpy

-- 
Kees Cook
