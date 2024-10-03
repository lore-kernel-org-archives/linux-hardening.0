Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A880748D;
	Thu,  3 Oct 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990477; cv=none; b=ig6//xcDwCRX/jBme97WCx1WGAcd7WBy1b8iYbylmeA12bFMWhsF8jozPMqhaI2XIhjOEmUVcCdoRR1qgaob5m4WvwGzs6c+9aSQdIyCuuqW6hgrzyRqTRNFEDpaE2aQXQiDuQ9gJw368Pi52eEUinmgU05k2QKIyO9+xqRMKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990477; c=relaxed/simple;
	bh=MyO0mEN1r8H/oKU5bxpARWbwameUHysvIHiV6FcP700=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmFm4WNn4umj33A3uNU+LW7SykQnR1Su5Mtlf/ZQhG54bYbdLbxb17tJplGu0s8mwCIveWfbLhtY0zWrlpPsqRi9BztxzI9l/BZEkvdiCyjXc19+Q+ujKrQJQAcyhwa1yIf+y4ubqdc3M4qWpYSDvvVD/5c5UeRl13ncu58dY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPg34YVs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPg34YVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE41C4CEC5;
	Thu,  3 Oct 2024 21:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727990477;
	bh=MyO0mEN1r8H/oKU5bxpARWbwameUHysvIHiV6FcP700=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPg34YVsXCAp7pJvZLK0zV3RJMEwEU7lOh0UIO7ZIcVp2soY8IlkVcYY0wYWWwe9F
	 LXHbVw2ZP5ZeOni+gTiOn8h3ecqgft9fwWHIRCt/4TX/YS/U1enNW6+64j7SBcclQf
	 kJs9NB6B1xNxM2JpmdJwDwz9o9+wcqkS0tgEHhHIvdV5tTc3qrIKwwM4c4cnR1PX8G
	 j7L+gwuiKsklCWGiLh2gxOSv/1/JXOmR+uDi5zqv0pdD5mLM9tWsa0HsI2vtTvMK+1
	 LE5pw4I0IScZfYrsun5cZiS8RBmYs8gUW5fo6u3ZO97qX9wloVcNfpxBs6GtbauAvX
	 /iAIHpjg1Ddtg==
Date: Thu, 3 Oct 2024 14:21:13 -0700
From: Kees Cook <kees@kernel.org>
To: Jason Montleon <jmontleo@redhat.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, linux-hardening@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-riscv@lists.infradead.org
Subject: Re: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with
 FORTIFY_SOURCE enabled
Message-ID: <202410031417.A5AB8BA5@keescook>
References: <B2A62C7F-45BA-43E1-975F-5AF0197CD2C3@kernel.org>
 <CAJD_bP+43=XXD7p3fRfDxCbj=_YedgVLv38XO4iOAw94a+4PHg@mail.gmail.com>
 <202409221511.9AF49BD@keescook>
 <CAJD_bP+6qCgseo9of-cKW3+nH_UbGFwPo6WRbqqcneOZ+EEtOw@mail.gmail.com>
 <800CC050-E858-409C-A565-A6EF430E1B25@kernel.org>
 <CAJD_bPKNbKo5tj4OV4MpgtSN6_FXfmQtBFgVFzZeZapCPNT6PA@mail.gmail.com>
 <eb7354f6-98bd-45c6-a616-733637848a14@ghiti.fr>
 <CAJD_bPKHA5+Ta1vzokN-TXJU4bk4OA5QTXEEvAwmzLzmW8YtTQ@mail.gmail.com>
 <f9d17698-0c74-42b7-acc8-3ca3adf3ba4d@ghiti.fr>
 <CAJD_bP+ZYKFaeZ2hQXjAZda=RhLkfnXfGLW-ZYTrOV4GfNRzpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD_bP+ZYKFaeZ2hQXjAZda=RhLkfnXfGLW-ZYTrOV4GfNRzpA@mail.gmail.com>

On Thu, Oct 03, 2024 at 01:12:59PM -0400, Jason Montleon wrote:
> On Thu, Oct 3, 2024 at 10:41 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
> > So I was able to reproduce the issue on qemu by adding a few tweaks, and
> > indeed we trap in __warn_printk() on a virtual address but MMU is not
> > enabled yet.
> >
> > The following diff though allows me to pass this failure but I can't get
> > much further in the boot since the tweaks I added won't allow it, can
> > you give the following a try?
> >
> > diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> > index 8a27394851233..4913f3b3f198c 100644
> > --- a/arch/riscv/errata/Makefile
> > +++ b/arch/riscv/errata/Makefile
> > @@ -2,6 +2,10 @@ ifdef CONFIG_RELOCATABLE
> >   KBUILD_CFLAGS += -fno-pie
> >   endif
> >
> > +ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
> > +KBUILD_CFLAGS += -D__NO_FORTIFY
> > +endif
> > +
> >   obj-$(CONFIG_ERRATA_ANDES) += andes/
> >   obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
> >   obj-$(CONFIG_ERRATA_THEAD) += thead/
> 
> Yes, this worked.

Thanks for testing!

Yeah, this matches similar fortify disabling in other early boot areas.
Usually it's part of a common header, but setting it via the Makefile
also works. I'll leave it up to the riscv maintainers! :)

-Kees

-- 
Kees Cook
