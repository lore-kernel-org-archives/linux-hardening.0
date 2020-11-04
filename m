Return-Path: <SRS0=8UcS=EK=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA136C2D0A3
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 15:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B7C2074F
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 15:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgKDPUj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:20:39 -0500
Received: from foss.arm.com ([217.140.110.172]:38746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbgKDPUj (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Nov 2020 10:20:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A500F139F;
        Wed,  4 Nov 2020 07:20:38 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A553F719;
        Wed,  4 Nov 2020 07:20:35 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:20:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
Message-ID: <20201104152032.GC7577@C02TD0UTHF1T.local>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
 <20201104092012.GA6439@willie-the-truck>
 <87h7q54ghy.fsf@oldenburg2.str.redhat.com>
 <d2f51a90-c5d6-99bd-35b8-f4fded073f95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2f51a90-c5d6-99bd-35b8-f4fded073f95@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 04, 2020 at 11:55:57AM +0200, Topi Miettinen wrote:
> On 4.11.2020 11.29, Florian Weimer wrote:
> > * Will Deacon:
> > 
> > > Is there real value in this seccomp filter if it only looks at mprotect(),
> > > or was it just implemented because it's easy to do and sounds like a good
> > > idea?
> > 
> > It seems bogus to me.  Everyone will just create alias mappings instead,
> > just like they did for the similar SELinux feature.  See “Example code
> > to avoid execmem violations” in:
> > 
> >    <https://www.akkadia.org/drepper/selinux-mem.html>
> 
> Also note "But this is very dangerous: programs should never use memory
> regions which are writable and executable at the same time. Assuming that it
> is really necessary to generate executable code while the program runs the
> method employed should be reconsidered."

Sure, and to be clear we're not trying to violate the "at the same time"
property. We do not want to permit simultaneous PROT_WRITE and PROT_EXEC
at any instant in time. What we're asking is to not block changing
permissions to PROT_EXEC in the absence of PROT_WRITE.

I think that the goal of preventing WRITE -> EXEC transitions for some
memory is sane, but I think the existing kernel primitives available to
systemd don't allow us to do that in a robust way because we don't have
all the relevant state tracked and accessible, and the existing approach
gets in the way of doing the right thing for other mitigations.

Consequently I think it would be better going forward to add a more
robust (kernel) mechanism for enforcement that can distinguish
WRITE->EXEC from EXEC->EXEC+BTI, and e.g. can be used to forbid aliasing
mappings with differing W/X permissions. Then userspace could eventually
transition over to that and get /stronger/ protection while permitting
the BTI case we'd like to work now.

> If a service legitimately needs executable and writable mappings (due to
> JIT, trampolines etc), it's easy to disable the filter whenever really
> needed with "MemoryDenyWriteExecute=no" (which is the default) in case of
> systemd or a TE rule like "allow type_t self:process { execmem };" for
> SELinux. But this shouldn't be the default case, since there are many
> services which don't need W&X.
> 
> I'd also question what is the value of BTI if it can be easily circumvented
> by removing PROT_BTI with mprotect()?

I agree that turning BTI off is a concern, and to that end I'd like to
add an enforcement mechanism whereby we could prevent that (ideally the
same mechanism by which we could prevent WRITE -> EXEC transitions). 

But, as with all things it's a matter of degree. MDWE and BTI are both
hurdles to an adversary, but neither are absolutes and there are
approaches to bypass either. By the time someone's issuing mprotect()
with an arbitrary VA and/or prot, they are liable to have been able to
do the same with mmap() and circumvent MDWE.

I'd really like to not have BTI silently disabled in order to work with
MDWE, because the risk is that it gets silently disabled elsewhere. The
risk of the changing the kernel to enable BTI for a binary is not well
known since we don't control other peoples libraries that might end up
not being compatible somehow with that. The risk of disabling a portion
of the MDWE protections seems to be the least out of the options we have
available, as unfortunate as it seems, and I think we can come up with a
better MDWE approach going forward.

Thanks,
Mark.
