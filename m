Return-Path: <SRS0=8UcS=EK=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B311C2D0A3
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D32620867
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604481620;
	bh=OB2pEHAq3eSy9zEaaBXh+kvuQPObkvMCdwCMUwzw1JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j2x/XcGV2RsIdL+qQSasWRIurDZG8RFfH9B/7t5Yl1oiY32D6Pbp7YWMBW56+HO/i
	 X+MjJtQ7L99rwtsvBDdnnARFg7odSh5s/pSpQG5tQkIRuP5QsBgsfOjTNFMtviFef0
	 w7rYw4oXJyGm8rcpt5oA7y7mSK95Ovw9YUXMAjNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgKDJUU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Nov 2020 04:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgKDJUT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Nov 2020 04:20:19 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4689E20715;
        Wed,  4 Nov 2020 09:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604481619;
        bh=OB2pEHAq3eSy9zEaaBXh+kvuQPObkvMCdwCMUwzw1JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npUyaTWCrnrKnzUraBfak+xsfoK1LtFuckl7rhvbc/h3cxA+6xI9w8UKKlUbQZNVw
         6tPD9MtchgCKOFA4wTe1S6ViePXtxYkmspUGsrF98MhWwKvTEjSpk2CTB/9TRa+tfT
         3muQirkvuEYhnX6JeB8x0V62+X5I7KfSOSR0tBHE=
Date:   Wed, 4 Nov 2020 09:20:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>, libc-alpha@sourceware.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20201104092012.GA6439@willie-the-truck>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103173438.GD5545@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 03, 2020 at 05:34:38PM +0000, Mark Brown wrote:
> On Tue, Nov 03, 2020 at 10:25:37AM +0000, Szabolcs Nagy wrote:
> 
> > Re-mmap executable segments instead of mprotecting them in
> > case mprotect is seccomp filtered.
> 
> > For the kernel mapped main executable we don't have the fd
> > for re-mmap so linux needs to be updated to add BTI. (In the
> > presence of seccomp filters for mprotect(PROT_EXEC) the libc
> > cannot change BTI protection at runtime based on user space
> > policy so it is better if the kernel maps BTI compatible
> > binaries with PROT_BTI by default.)
> 
> Given that there were still some ongoing discussions on a more robust
> kernel interface here and there seem to be a few concerns with this
> series should we perhaps just take a step back and disable this seccomp
> filter in systemd on arm64, at least for the time being?  That seems
> safer than rolling out things that set ABI quickly, a big part of the
> reason we went with having the dynamic linker enable PROT_BTI in the
> first place was to give us more flexibility to handle any unforseen
> consequences of enabling BTI that we run into.  We are going to have
> similar issues with other features like MTE so we need to make sure that
> whatever we're doing works with them too.
> 
> Also updated to Will's current e-mail address - Will, do you have
> thoughts on what we should do here?

Changing the kernel to map the main executable with PROT_BTI by default is a
user-visible change in behaviour and not without risk, so if we're going to
do that then it needs to be opt-in because the current behaviour has been
there since 5.8. I suppose we could shoe-horn in a cmdline option for 5.10
(which will be the first LTS with BTI) but it would be better to put up with
the current ABI if possible.

Is there real value in this seccomp filter if it only looks at mprotect(),
or was it just implemented because it's easy to do and sounds like a good
idea?

Will
