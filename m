Return-Path: <SRS0=8UcS=EK=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E76AC2D0A3
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B545420739
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 14:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKDOl2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgKDOl2 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Nov 2020 09:41:28 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5960206DB;
        Wed,  4 Nov 2020 14:41:23 +0000 (UTC)
Date:   Wed, 4 Nov 2020 14:41:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
Message-ID: <20201104144120.GD28902@gaia>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
 <8c99cc8e-41af-d066-b786-53ac13c2af8a@arm.com>
 <20201104085704.GB24704@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104085704.GB24704@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 04, 2020 at 08:57:05AM +0000, Szabolcs Nagy wrote:
> The 11/03/2020 23:41, Jeremy Linton wrote:
> > On 11/3/20 11:34 AM, Mark Brown wrote:
> > > On Tue, Nov 03, 2020 at 10:25:37AM +0000, Szabolcs Nagy wrote:
> > > 
> > > > Re-mmap executable segments instead of mprotecting them in
> > > > case mprotect is seccomp filtered.
> > > 
> > > > For the kernel mapped main executable we don't have the fd
> > > > for re-mmap so linux needs to be updated to add BTI. (In the
> > > > presence of seccomp filters for mprotect(PROT_EXEC) the libc
> > > > cannot change BTI protection at runtime based on user space
> > > > policy so it is better if the kernel maps BTI compatible
> > > > binaries with PROT_BTI by default.)
> > > 
> > > Given that there were still some ongoing discussions on a more robust
> > > kernel interface here and there seem to be a few concerns with this
> > > series should we perhaps just take a step back and disable this seccomp
> > > filter in systemd on arm64, at least for the time being?  That seems
> > > safer than rolling out things that set ABI quickly, a big part of the
> > 
> > So, that's a bigger hammer than I think is needed and punishes !BTI
> > machines. I'm going to suggest that if we need to carry a temp patch its
> > more like the glibc patch I mentioned in the Fedora defect. That patch
> > simply logs a message, on the mprotect failures rather than aborting. Its
> > fairly non-intrusive.
> > 
> > That leaves seccomp functional, and BTI generally functional except when
> > seccomp is restricting it. I've also been asked that if a patch like that is
> > needed, its (temporary?) merged to the glibc trunk, rather than just being
> > carried by the distro's.
> 
> note that changing mprotect into mmap in glibc works
> even if the kernel or systemd decides to do things
> differently: currently the only wart is that on the
> main exe we have to use mprotect and silently ignore
> the failures.

Can the dynamic loader mmap() the main exe again while munmap'ing the
original one? (sorry if it was already discussed)

-- 
Catalin
