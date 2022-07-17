Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E24CC433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Jul 2022 14:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiGQOpA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Jul 2022 10:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiGQOop (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Jul 2022 10:44:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEE1FD27
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 07:44:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so12192599edc.4
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HlrziZZ76Peg4qV5xEsTcKPFlstjpM1SL9BDNiXfu2c=;
        b=DS8vDfy5PisUHpo8QkxoxfYYXqiO9hj+fmk/WC8pM7VlVfPf4QI7fKq+8iWyFlBosN
         xOaKReN1tr6gKUlm2poGf/qYOY0t1sShwW+dhRV//mwtfmSuMpaD81F4Kwf9rs0vMp7F
         xavWty7gfUG6G+PTd+tLOjuyv7MUqoAAUViF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HlrziZZ76Peg4qV5xEsTcKPFlstjpM1SL9BDNiXfu2c=;
        b=7wJPMb/V9prCO6UpC1PMYVgIcgGiU/rcyk2lM4OiOftiPmpT8uitrC83CZVNoo6U3r
         x6E61x5lQSbv5yMlRr4aI+z8B8wh90qUqAuD4A+NNkWa/TFUW+t7Hp+A6ESGlk/HcN13
         Ej9EE/KZCcMp07z7iqmobY4zo7wVpOkh0JhNd/X/5T9S0yT2TrPHLoYHz4xbpBD277Be
         BZVJYsO/q7tjAeUmOho0KTDFcDQao4lZ9EDO2lW+LDmrCYCgzvkUoKldW+86dItYd4Wj
         3gImqU5k8BFitkRD8qRn49Rg45LCGHPMnMLnvlhDJSM7Za0MTLZkEu+w/h7z53WOrZYb
         YB7A==
X-Gm-Message-State: AJIora8DvYPa1P+n50fwCY5mYi82iO8ekcmiGchRwCTAzdoINadjjgm3
        i/jH8Z0oKLnt2UiCWUReKZHlBwpoZBNjnBNC
X-Google-Smtp-Source: AGRyM1tIg92iReAguGlFyhdu2B70sdkAsb7i3UNUAdEfqj5rpUEMYrPRnBy5uUzlifXbfdBMpaavkQ==
X-Received: by 2002:a05:6402:1e94:b0:43a:9e92:bf2 with SMTP id f20-20020a0564021e9400b0043a9e920bf2mr31659156edf.248.1658069081602;
        Sun, 17 Jul 2022 07:44:41 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709064e1000b006fe9f9d0938sm4459421eju.175.2022.07.17.07.44.39
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 07:44:40 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id n12so694054wrc.8
        for <linux-hardening@vger.kernel.org>; Sun, 17 Jul 2022 07:44:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr18844596wrb.442.1658069078907; Sun, 17
 Jul 2022 07:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
In-Reply-To: <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 07:44:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
Message-ID: <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jul 17, 2022 at 2:13 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> I was trying to check it. With gcc-11 the assembly code generated is
> not using memset, but using __memset.
> But with gcc-12, I can see the assembly code is using memset. One
> example from the assembly:

You could try making the 'args' array in 'struct prom_args' be marked
'volatile'.

Ie something like this:

  --- a/arch/powerpc/kernel/prom_init.c
  +++ b/arch/powerpc/kernel/prom_init.c
  @@ -115,6 +115,6 @@ struct prom_args {
           __be32 service;
           __be32 nargs;
           __be32 nret;
  -          __be32 args[10];
  +        volatile __be32 args[10];
   };

because I think it's just the compilers turning the small loop over
those fields into a "memset()".

              Linus
