Return-Path: <SRS0=1bDI=EB=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB11C4363A
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Oct 2020 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197F2217A0
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Oct 2020 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784619AbgJZP6f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:58:35 -0400
Received: from foss.arm.com ([217.140.110.172]:43166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784512AbgJZP4v (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Oct 2020 11:56:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05B5C1042;
        Mon, 26 Oct 2020 08:56:50 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D86B3F719;
        Mon, 26 Oct 2020 08:56:48 -0700 (PDT)
Date:   Mon, 26 Oct 2020 15:56:35 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-hardening@vger.kernel.org, libc-alpha@sourceware.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <20201026155628.GA27285@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022075447.GO3819@arm.com>
 <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com>
 <202010221256.A4F95FD11@keescook>
 <20201023090232.GA25736@gaia>
 <cf655c11-d854-281a-17ae-262ddf0aaa08@gmail.com>
 <20201026145245.GD3117@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026145245.GD3117@gaia>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 26, 2020 at 02:52:46PM +0000, Catalin Marinas via Libc-alpha wrote:
> On Sat, Oct 24, 2020 at 02:01:30PM +0300, Topi Miettinen wrote:
> > On 23.10.2020 12.02, Catalin Marinas wrote:
> > > On Thu, Oct 22, 2020 at 01:02:18PM -0700, Kees Cook wrote:
> > > > Regardless, it makes sense to me to have the kernel load the executable
> > > > itself with BTI enabled by default. I prefer gaining Catalin's suggested
> > > > patch[2]. :)
> > > [...]
> > > > [2] https://lore.kernel.org/linux-arm-kernel/20201022093104.GB1229@gaia/
> > > 
> > > I think I first heard the idea at Mark R ;).
> > > 
> > > It still needs glibc changes to avoid the mprotect(), or at least ignore
> > > the error. Since this is an ABI change and we don't know which kernels
> > > would have it backported, maybe better to still issue the mprotect() but
> > > ignore the failure.
> > 
> > What about kernel adding an auxiliary vector as a flag to indicate that BTI
> > is supported and recommended by the kernel? Then dynamic loader could use
> > that to detect that a) the main executable is BTI protected and there's no
> > need to mprotect() it and b) PROT_BTI flag should be added to all PROT_EXEC
> > pages.
> 
> We could add a bit to AT_FLAGS, it's always been 0 for Linux.
> 
> > In absence of the vector, the dynamic loader might choose to skip doing
> > PROT_BTI at all (since the main executable isn't protected anyway either, or
> > maybe even the kernel is up-to-date but it knows that it's not recommended
> > for some reason, or maybe the kernel is so ancient that it doesn't know
> > about BTI). Optionally it could still read the flag from ELF later (for
> > compatibility with old kernels) and then do the mprotect() dance, which may
> > trip seccomp filters, possibly fatally.
> 
> I think the safest is for the dynamic loader to issue an mprotect() and
> ignore the EPERM error. Not all user deployments have this seccomp
> filter, so they can still benefit, and user can't tell whether the
> kernel change has been backported.
> 
> Now, if the dynamic loader silently ignores the mprotect() failure on
> the main executable, is there much value in exposing a flag in the aux
> vectors? It saves a few (one?) mprotect() calls but I don't think it
> matters much. Anyway, I don't mind the flag.

I don't see a problem with the aforementioned patch [2] to pre-set BTI
on the pages of the main binary.

The original rationale here was that ld.so doesn't _need_ this, since it
is going to examine the binary's ELF headers anyway.  But equally, if
the binary is marked as supporting BTI then it's safe to enable BTI for
the binary's own pages.


I'd tend to agree that an AT_FLAGS flag doesn't add much.  I think real
EPERMs would only be seen in assert-fail type situations.  Failure of
mmap() is likely to result in a segfault later on, or correct operation
with weakened permissions on some pages.  Given the likely failure
modes, that situation doesn't feel too bad.


> The only potential risk is if the dynamic loader decides not to turn
> PROT_BTI one because of some mix and match of objects but AFAIK BTI
> allows interworking.

Yes, the design means that a page's PROT_BTI can be set safely if the
code in that page was compiled for BTI, irrespective of how other pages
were compiled.  The reasons why we don't do this at finer granularity
are (a) is't not very useful, and (b) ELF images only contain a BTI
property note for the whole image, not per segment.

I think that ld.so already makes this decision at ELF image granularity
(unless someone contradicts me).

Cheers
---Dave
