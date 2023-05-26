Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C8EC77B73
	for <linux-hardening@archiver.kernel.org>; Fri, 26 May 2023 16:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjEZQhT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 May 2023 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjEZQhS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 May 2023 12:37:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274FBC
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 09:37:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51f6461af24so617703a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685119037; x=1687711037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Azb9/wXA9VoPaWPI5lGZTtQI0vZpDzZEb+cEjRX2Ydk=;
        b=n0H6EYp3E20SjwfM0SwJuXPC3JEWid26w4lpvxOENCBKtzIH0lhc4Ra+X+3jsxXagO
         tu2yS+JJXHWoS6chG+rRIif1q/iGKy8saTmyeii9q5OBnfjVyNlBgFfFJ+O0gEYUBjhL
         KbhOXFcznqwy7/0irei3Zc0SemodHKJ0+70ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685119037; x=1687711037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Azb9/wXA9VoPaWPI5lGZTtQI0vZpDzZEb+cEjRX2Ydk=;
        b=AC3rxliH5ZsXWwJARgZyKpw9Brq132Ax14n1Bc+vSFBITqprhXfgfvL2+nIDz+7dah
         It/53vG6TYV4FOANfXdtJQ2WkZwz+PUIZlN5uqUsDlIGLj2uIxoVY6LaRCFuXr01k5om
         vSsxukUbb8n4Rl7TFF2lN7a440tuR5566KYL3ivs2ws3imRE2qVcRL7uXDDkuZRRa40i
         qj/d2hYBqWEJsLKPRHOR6CwAYQt277SuIFhVqYp/hZ3db8oQqCC+DE1qCdUOHqW+CrJq
         Ur/7q+MHqVwdZgi25ZTKAYCVBQJxx1pd3MEUs4I6eynAiCEOPPbPkD1mEkBI5caR3hbt
         WWbg==
X-Gm-Message-State: AC+VfDxO0Sdcv88+PTjyNhDuJeah0YaZX0VOTQd0bjBmrC/8MJ3etdZ9
        0fNB4Hx/zFgjskX3CsoG+VffhqQZzJc6qbi8x6Y=
X-Google-Smtp-Source: ACHHUZ5OlMcp05v+8Sy2wQ8qHrpseBKUcgff8PjZUqJZmZSnj0xej2pJJXrPrl0bQVrBkfiVG/zo2A==
X-Received: by 2002:a17:902:b684:b0:1ae:305f:e949 with SMTP id c4-20020a170902b68400b001ae305fe949mr2755604pls.6.1685119037441;
        Fri, 26 May 2023 09:37:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709028f8600b001a96562642dsm3449797plo.277.2023.05.26.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 09:37:16 -0700 (PDT)
Date:   Fri, 26 May 2023 09:37:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-hardening@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: s390/defconfigs: set CONFIG_INIT_STACK_NONE=y
Message-ID: <202305260922.F98F90290@keescook>
References: <ZG+rogQJO+U3kS4a@outflux.net>
 <ZHC3YJ3FHwYxYrMG@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHC3YJ3FHwYxYrMG@osiris>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 26, 2023 at 03:42:56PM +0200, Heiko Carstens wrote:
> Hi Kees,
> 
> > I had this[1] patch pointed out to me, but I couldn't find any discussion
> > about it on public lists. Can you give me some background on this? There
> > haven't been any general workloads identified where this has been
> > a problem, so I'm curious why this was seen as globally an issue on
> > s390. The expectation was to use __uninitialized on any variables where
> > this was noticed as a performance issue, and where the memory safety of
> > the variable could be proven. Turning it off by default seems like
> > rather too much, but perhaps there is something unique to s390 I don't
> > know about. :)
> 
> This was the result of some micro benchmarks being reported "too slow".
> Actually our syscall entry/exit path got naturally slower since we switched
> to generic entry; now we are trying to improve things a bit again.
> 
> There is also this RFC from Sven, which tries to inline some of the
> generic system call functions, in order to avoid function calls:
> https://lore.kernel.org/lkml/20230516133810.171487-1-svens@linux.ibm.com/
> 
> I stumbled upon CONFIG_INIT_STACK_NONE only by accident when wondering why
> the compiler would generate quite some instructions which aren't necessary,
> just to zero variables. For the getpid() system call this makes a runtime
> difference of ~3%, which is quite a bit.

Hm, that does seem high. It implies there are large variable that are
being passed by reference, perhaps in the syscall path? I had similar
problems a while back on x86 but due to stack-protector seeing the
register arrays and thinking they needed protection. I had to explicitly
turn that off for the entry code, since they're provably safe. :)

> What is the overhead on other architectures?

It's been in the noise for real workloads.

> That said: I was also unaware of __uninitialized. But on the other hand,
> there is no sign of __uninitialized in the kernel, nor could I find
> anything that could match in compiler_attributes.h.
> Am I missing something here?

No, nothing missed -- there just have been no workloads identified yet
where it's needed.

> Thanks for bringing this up, I guess if there is some annotation available,
> we can revisit at least the architecture specific entry code, and maybe
> figure out how to avoid most of the extra runtime, but still keep the
> feature enabled.
> 
> (Adding Sven, since I will be offline the next two weeks).

Yeah, if you find a place where it's needed, please add the compiler
attribute and put it to use. It'll give people an example use-case for
it. :)

-- 
Kees Cook
