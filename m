Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867E6C07E94
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 10:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAE461208
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 10:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhFDKIV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Jun 2021 06:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDKIV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Jun 2021 06:08:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E93C06174A;
        Fri,  4 Jun 2021 03:06:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso2156027pjb.4;
        Fri, 04 Jun 2021 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pf5SE7QX1W1WgVz/hc8YdWJ4xx7787JaP6QmCVAqxoE=;
        b=VLYoca+LjdLRn8bCCwYSjaI6L2S0m6dN8swFseCxrEsKye123LYAu9MaspToiEeSEi
         GIz9cKCAPs5Y2E2awErocTLFUZOyI7sY31ggrxWf00FVEnQI9Um951+5WXDk2saUIUvS
         HUy1oCG9Lh4vN4tO7o/cw2IkMXACxiTxGoKFkyzKB31GVYyPMsDzF92X/WIDcjG+BaHg
         KfklbZVh0iu91svk76/eCZYcTINCfeq8hrX7W8wNNJRVoqZoYHuSiiUJ6kgO/EVJkxmx
         6o1y6R0Eo4L7dAW3ud/byTwywEiQ09ZKwjLcv3+ebjgzQ1Ex2gFK2JjCtTMBleeTA6hk
         orNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pf5SE7QX1W1WgVz/hc8YdWJ4xx7787JaP6QmCVAqxoE=;
        b=rOKfv0mwEHNZ+SEDh5YyAoHp7xxgn+phMlE1lrXHH3CdRW9vybZ4+5g3zW3UHatoLl
         MC1BJ30/Hz9RfvgC2w31252WPkFv3Up9IAMfZy+/8CWWW+9QQ+jW7PIiij5AzmHB4b60
         Ah3WnS4l5U2f/O4UoylFk8RXCTk7wBwJz7mFUUMfxZ6s2bwoDgCiqjr219dOggr9Iram
         bq03hPqiO1dCGBIG8MEDQiyJ64oglx5025eZLAIjEWUjAJyXLSMtvzA51ZmgpAAdNgD0
         AdX0WOpOB3kyeFogjUHe2iVZd/nnkiaMsZ3P2FkWA2iOgZnmMCZIemWk3w1HX/Q6ldte
         IQoQ==
X-Gm-Message-State: AOAM5305t11wTi1+rjf6MnMv+p9fTq5gGnAOn+XkSjUo2osjJXSkO8L6
        9RERxwsEBn8psoseJWNC0oo=
X-Google-Smtp-Source: ABdhPJxcM2aRdlByR8gUSOwLnPnv17IvwYZqOU54zjVNHVy6E1V8lr6nvqfdK9iEbkPRzmSHDrz9Og==
X-Received: by 2002:a17:90b:3796:: with SMTP id mz22mr16306533pjb.177.1622801178697;
        Fri, 04 Jun 2021 03:06:18 -0700 (PDT)
Received: from localhost (59-102-73-37.tpgi.com.au. [59.102.73.37])
        by smtp.gmail.com with ESMTPSA id g8sm1425288pfo.85.2021.06.04.03.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 03:06:17 -0700 (PDT)
Date:   Fri, 4 Jun 2021 20:06:14 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Next revision of the L1D flush patches
Message-ID: <YLn7FqKAWnmrEDZJ@balbir-desktop>
References: <20210108121056.21940-1-sblbir@amazon.com>
 <cf89f0389379daaaff0cbce9c5f1550866e55e91.camel@amazon.com>
 <202104081319.DAB1D817@keescook>
 <87y2d5tpjh.ffs@nanos.tec.linutronix.de>
 <87tunsofan.ffs@nanos.tec.linutronix.de>
 <202104281307.F9FCF660@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104281307.F9FCF660@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Apr 28, 2021 at 01:08:05PM -0700, Kees Cook wrote:
> On Tue, Apr 27, 2021 at 12:24:16AM +0200, Thomas Gleixner wrote:
> > On Mon, Apr 26 2021 at 10:31, Thomas Gleixner wrote:
> > > On Thu, Apr 08 2021 at 13:23, Kees Cook wrote:
> > >>
> > >> I'd still really like to see this -- it's a big hammer, but that's the
> > >> point for cases where some new flaw appears and we can point to the
> > >> toolbox and say "you can mitigate it with this while you wait for new
> > >> kernel/CPU."
> > >>
> > >> Any further thoughts from x86 maintainers? This seems like it addressed
> > >> all of tglx's review comments.
> > >
> > > Sorry for dropping the ball on this. It's in my list of things to deal
> > > with. Starting to look at it now.
> > 
> > So I went through the pile and for remorse I sat down and made the
> > tweaks I think are necessary myself.
> > 
> > I've pushed out the result to
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/l1dflush
> 
> Oh excellent; thank you for doing this!
>

Thanks again Thomas!

I no longer have access to the bare metal hardware, but I was able to test
this under qemu with some emulation changes. The changes worked as expected.

Folks on the list/cc, appreciate any tested-by or additional reviewed-by
tags if you do happen to review/test.

Thanks,
Balbir Singh. 
