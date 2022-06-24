Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817BFC43334
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 13:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiFXNJS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiFXNJR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 09:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F061426E0
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75A8961EA0
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD55C341C0
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656076155;
        bh=RwE1P1pceCLCKyCXOsjVgI303nD43lbNngI9LOWoUQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hmde7ZdSUA6S6+aX/BDh69Z8g5OIWnIRoKUQpj81gsws6zjo21MxPjBXg58WkQ5oU
         yiim8hjFWFd6rn+JEN3rrvo3TVmv4pqR3uV4HQaIiO7+E5Y/zHfXQbmunwCZWR2MvQ
         u4VD4nml6bcgaoXMNybWrKYUTwgr7+aq+DLkA0ycbLwH3O0mUafKo8syY5bytltd4Z
         QIvvY5pcrJTXZWWip6eI+g7soylTntjbyMZ2l1QlLiL0CXHVF1NmReueY6eW35GGWu
         yEAodoLSNZsccYHn19/ysqZa6hZFoZ65kEDBGt0L6AY+SS5DmW3xhIBvljICo6+Xk4
         zp1l7HZl6ttpQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-101e1a33fe3so3646293fac.11
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:09:15 -0700 (PDT)
X-Gm-Message-State: AJIora9u3BK9WDNUOQsae3In4Vv8yYmqnBF+ouscGTe0bFP87DoPEhqA
        7OcN4i15YT8E30bXi8Ca4IL6NZxvM/QmlvHwatU=
X-Google-Smtp-Source: AGRyM1uklO9BAMOqEeYQAn8MVXYL5AFLI2kh0EPud/FADn56f+c1Mw6E050P86JmI2MZovxsb+232Tqs0+lno3sq5XU=
X-Received: by 2002:a05:6870:e98b:b0:fe:219a:2449 with SMTP id
 r11-20020a056870e98b00b000fe219a2449mr1947237oao.228.1656076155066; Fri, 24
 Jun 2022 06:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-20-ardb@kernel.org>
 <20220624130808.GE18561@willie-the-truck>
In-Reply-To: <20220624130808.GE18561@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 15:09:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEqhhMBsYXZOKrj0ycGdFOj++D+MgRR7vsncGQSL7ad6g@mail.gmail.com>
Message-ID: <CAMj1kXEqhhMBsYXZOKrj0ycGdFOj++D+MgRR7vsncGQSL7ad6g@mail.gmail.com>
Subject: Re: [PATCH v4 19/26] arm64: kaslr: defer initialization to late
 initcall where permitted
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 24 Jun 2022 at 15:08, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 04:45:43PM +0200, Ard Biesheuvel wrote:
> > The early KASLR init code runs extremely early, and anything that could
> > be deferred until later should be. So let's defer the randomization of
> > the module region until much later - this also simplifies the
> > arithmetic, given that we no longer have to reason about the link time
> > vs load time placement of the core kernel explicitly. Also get rid of
> > the global status variable, and infer the status reported by the
> > diagnostic print from other KASLR related context.
> >
> > While at it, get rid of the special case for KASAN without
> > KASAN_VMALLOC, which never occurs in practice.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/kaslr.c | 95 +++++++++-----------
> >  1 file changed, 40 insertions(+), 55 deletions(-)
>
> [...]
>
> > @@ -163,33 +169,12 @@ u64 __init kaslr_early_init(void)
> >                * when ARM64_MODULE_PLTS is enabled.
> >                */
> >               module_range = MODULES_VSIZE - (u64)(_etext - _stext);
> > -             module_alloc_base = (u64)_etext + offset - MODULES_VSIZE;
> >       }
> >
> >       /* use the lower 21 bits to randomize the base of the module region */
> >       module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
> >       module_alloc_base &= PAGE_MASK;
> >
> > -     return offset;
> > -}
> > -
> > -static int __init kaslr_init(void)
> > -{
> > -     switch (kaslr_status) {
> > -     case KASLR_ENABLED:
> > -             pr_info("KASLR enabled\n");
> > -             break;
> > -     case KASLR_DISABLED_CMDLINE:
> > -             pr_info("KASLR disabled on command line\n");
> > -             break;
> > -     case KASLR_DISABLED_NO_SEED:
> > -             pr_warn("KASLR disabled due to lack of seed\n");
> > -             break;
> > -     case KASLR_DISABLED_FDT_REMAP:
> > -             pr_warn("KASLR disabled due to FDT remapping failure\n");
> > -             break;
> > -     }
> > -
> >       return 0;
> >  }
> > -core_initcall(kaslr_init)
> > +late_initcall(kaslr_init)
>
> Are you sure this isn't too late? I'm nervous that we might have called
> request_module() off the back of all the other initcalls that we've run by
> this point.
>

Yeah, I just realized the other day that this is probably too late.
subsys_initcall() might be more suitable here
