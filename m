Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF661862;
	Wed, 13 May 2026 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668141; cv=none; b=GO4+BKuIyZK1ug+cLae7J6GH3Ipyuu+HEBQEAFKJTyHC/z4OyRbwP5/tVpjFekvHmt0Gcw/X5a4tivzkEXKXjwxd7sOhsGOCgv154+hBnKEuLqU1JtUAkvwwe9M+tUy3kD3vSTDOeeHdKw3Gxzzve2qfpVcJcaMD9nniHBl7Qbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668141; c=relaxed/simple;
	bh=SMSduI5AnAM9kqchaE8jYdlaOT2npCWPyM5+zGPU3o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYDKM1ik/3O9B5HqW/1wmzAKyEiiKg6Jp6SMjNPd1OSzHBFNyBIAXFff9947oJf3aRJHqhs3O208Ds/1HzW/9Nnpyqym0OepZs0e2qviETBITIxt7XY8ksdYpvx04MmEAFjAKJ7mqOmGz2RgnhcZZdytVVPm7z0JoSu2YZcLvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqTXi24H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqTXi24H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F393C2BCB7;
	Wed, 13 May 2026 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778668140;
	bh=SMSduI5AnAM9kqchaE8jYdlaOT2npCWPyM5+zGPU3o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqTXi24HsgBOAFuKC6Vi/Jw3ToZ3ix8HWddmTwJTDN0Un1xAN5BkYQzXEShkWawTo
	 GbwdlpXAgWvDqvcNS4fj4SamaL21POucJDoSE7gUJ+y6jgqAQeAzM1iOpDyFP3dDYj
	 RbhQq9r3uXj5eja2m/YDTvPvES31K7BtxsHNPpQukkzx1jXDmNwQs88p5AhLbZkYxo
	 WYY1U+LSv7W2Mu8THlmQACiifeBWhl6VW8dk+ILwXNmNO/9dTqLE3RnuJo2ptdVwoS
	 hfHoLk3RKGkwl/5TkgZ09NqeNYyFzaQwl3SN0CdD5rL7XU7NeUhJHKrDEBwv+tCA7/
	 ezv48qxYD1c9Q==
Date: Wed, 13 May 2026 13:28:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
Message-ID: <agRSY-VLLdSqeMT5@kernel.org>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com>
 <CAG48ez1DJ88a0pBCE-Q0VXyDuJgng8zdunb38g4b4JPU88exww@mail.gmail.com>
 <31252c1d-a98d-4635-ab61-ce5b649e256f@app.fastmail.com>
 <CAG48ez2xJwJDgxSH0u2G==9dOQJQxQ7WsQfU14O1H5hEWic1eA@mail.gmail.com>
 <fb5749bb-bc87-4f0b-9ec9-8a1eb7ded3b5@app.fastmail.com>
 <agQ7RMAw51RlNUOj@kernel.org>
 <49d30ffe-b7e1-4b05-89e0-c3fe01348bb6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49d30ffe-b7e1-4b05-89e0-c3fe01348bb6@app.fastmail.com>

On Wed, May 13, 2026 at 10:53:08AM +0200, Ard Biesheuvel wrote:
> 
> On Wed, 13 May 2026, at 10:50, Mike Rapoport wrote:
> > On Tue, May 12, 2026 at 02:56:16PM +0200, Ard Biesheuvel wrote:
> >> On Mon, 11 May 2026, at 16:40, Jann Horn wrote:
> >> > On Mon, May 11, 2026 at 10:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >> >> I think we should simply do something along the lines of the below,
> >> >> considering that the size of a data object tends to correlate with
> >> >> its minimum alignment.
> >> >>
> >> >> I do find it rather puzzling that the compiler emits empty_zero_page
> >> >> *after* zero_page_pfn - ideally, we'd combine the below with
> >> >> -fdata-sections so that the linker sees all individual objects, but
> >> >> I suspect that would create some problems elsewhere.
> >> >>
> >> >>
> >> >> --- a/include/asm-generic/vmlinux.lds.h
> >> >> +++ b/include/asm-generic/vmlinux.lds.h
> >> >> @@ -452,7 +452,7 @@
> >> >>  #define RO_AFTER_INIT_DATA                                   \
> >> >>         . = ALIGN(8);                                         \
> >> >>         __start_ro_after_init = .;                            \
> >> >> -       *(.data..ro_after_init)                               \
> >> >> +       *(SORT_BY_ALIGNMENT(.data..ro_after_init))            \
> >> >
> >> > Oh, neat, I didn't realize that's possible. That seems like a nicer
> >> > approach...
> >> 
> >> Neat but rather ineffective, unfortunately. (I don't see a size
> >> difference with the arm64 defconfig kernel)
> >> 
> >> Given that empty_zero_page only ever gets its address taken, we
> >> might just move it into the linker script if that requires tweaking
> >> anyway. We can just place it at the start of .rodata, which is
> >> already page aligned on most architectures (and will become page
> >> aligned unless EMPTY_ZERO_PAGE is #define'd by the arch linker
> >> script to something else)
> >> 
> >> 
> >> --- a/include/asm-generic/vmlinux.lds.h
> >> +++ b/include/asm-generic/vmlinux.lds.h
> >> @@ -472,6 +472,17 @@
> >>  #endif
> >>  #endif
> >>  
> >> +#ifndef EMPTY_ZERO_PAGE
> >> +#ifndef __HAVE_COLOR_ZERO_PAGE
> >
> > I don't think we want let architectures that don't use colored zero pages
> > redefine it.
> > If it will be really required we can add the ability to redefine
> > EMPTY_ZERO_PAGE later.
> >
> 
> I was actually intending to add use this for arm64 in the next patch. It
> already has a reserved_pg_dir in .rodata which is page-sized (i.e., up
> to 64k in size) and guaranteed to remain all zeroes, so empty_zero_page
> could actually be an alias for that. This is what I had in a previous
> revision, before you turned the empty_zero_page definition into common
> code:

Works for me if from arm64 perspective that's ok :)
 
> https://lore.kernel.org/all/20260320145934.2349881-16-ardb+git@google.com/

-- 
Sincerely yours,
Mike.
