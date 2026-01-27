Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCD336ECE
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507375; cv=none; b=dHjLhZEHEeV+0fQJjsOFDuZUzMXyn0Yc3aPeh5zhvO3K7/aN9+XXUJbjjNujTuyaUr2tmgj8kY6kdNRef170GvROjXrENVGfeDMAc4QH9+q6rWcvTJ5knj++C5ARiQfSdIEVcG4LoUeGljPWwJBrcIcX1ToGxQjUrfoTwR25+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507375; c=relaxed/simple;
	bh=7ffJyHAC8J/GkSpmEQneS6c4rnD8WljExEpFryTMzaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvhCWOvqCsZ6dIwKfkOjmR++AmhZZRKB2rpJP1P/vCRQKJ0I3zY6s/yPxEhPbofk913RDu7fkdpHunqTIGwisEXJj6VekusZcCOnHfGneqtwKiNrNc23qov+wYCztdbEnOJR61Ra1K2eXMPd4sU6/1HhYyEP/XtCtng3DMZyQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzqWxbJq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzqWxbJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54690C2BCB0
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769507375;
	bh=7ffJyHAC8J/GkSpmEQneS6c4rnD8WljExEpFryTMzaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LzqWxbJqFOchXJuo8YLJENnYCYFOPrgCtVbCV46w0GlcHrASlofAHnhSJ7DITkkut
	 Mmb4pBpElwoSbgNjdFGoWbdXY50Nf6kF5meKch2Xrp39YQcS1HFZDeVfp4Dp0B0Y9A
	 xXVYsckbaOR0bq9vv0ydHb3ExobRGgR3rL9idl9BewSsG/Y7OSvkRgWNb2dkvMkjaU
	 VocjzPRS1ZsjxZZLTM3h/egB00sUy+KrZZ7U7vaN5gumA8ftItQSjD4KgV+LFYHCrs
	 +gUlVuyWz1wofey7FvbUxbsahbDPYOSokHtnHnl3y1q0MKFhP3q6hXKT25KWKqvz/u
	 CrRDeIH6tm6Vg==
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a79ded11a2so33988965ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 01:49:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfyEIyhooWMKnrp5NNzulc3LRxHMx2sDC/50a53cDZd12LFFRZSgGqK/7j8yFqwSQO9fDl5mQ+WpntWj6r+TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyztpDY8EKeU+dGEwbXADIqQQQaiNRlA03u3I4Lmbx4RHD9Z4p
	K/Y+q6AZ4cFt/gTho4Yy8YcUUjpR7YQVfhjyzxq2nQmKD3AI1i8Pnmf0p6tR96gaCQyxGcsU6kb
	m0KR/2kLMP/2cRHJ49VoyQXazye9QmuQ=
X-Received: by 2002:a17:903:198d:b0:295:570d:116e with SMTP id
 d9443c01a7336-2a870dc8cd3mr12948505ad.41.1769507374856; Tue, 27 Jan 2026
 01:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-13-ardb+git@google.com> <3d59a8d9-a382-48d8-b79c-f5c23e86c1b7@arm.com>
In-Reply-To: <3d59a8d9-a382-48d8-b79c-f5c23e86c1b7@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Jan 2026 10:49:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF4k9EstLkxdNje_rwTehdu2MYvyh7n+4GoMWNcjcHYcA@mail.gmail.com>
X-Gm-Features: AZwV_QjbFJ48-GJAX5IbCu5heqXiBoewnTMcOOsWNGmC7SW2Fjs46gnJ_q-g0r0
Message-ID: <CAMj1kXF4k9EstLkxdNje_rwTehdu2MYvyh7n+4GoMWNcjcHYcA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] arm64: Move the zero page to rodata
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 10:34, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 26/01/2026 09:26, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The zero page should contain only zero bytes, and so mapping it
> > read-write is unnecessary. Combine it with reserved_pg_dir, which lives
> > in the read-only region of the kernel, and already serves a similar
> > purpose.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/vmlinux.lds.S | 1 +
> >  arch/arm64/mm/mmu.c             | 3 +--
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > index ad6133b89e7a..b2a093f5b3fc 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -229,6 +229,7 @@ SECTIONS
> >  #endif
> >
> >       reserved_pg_dir = .;
> > +     empty_zero_page = .;
> >       . += PAGE_SIZE;
> >
> >       swapper_pg_dir = .;
>
> Isn't there a magic macro for getting from swapper to reserved? That will need
> updating?
>

Why? This just adds an alias to refer to the same allocation.

> /*
>  *  Open-coded (swapper_pg_dir - reserved_pg_dir) as this cannot be calculated
>  *  until link time.
>  */
> #define RESERVED_SWAPPER_OFFSET (PAGE_SIZE)
>
>
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 9ae7ce00a7ef..c36422a3fae2 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -66,9 +66,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
> >
> >  /*
> >   * Empty_zero_page is a special page that is used for zero-initialized data
> > - * and COW.
> > + * and COW. Defined in the linker script.
> >   */
> > -unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
> >  EXPORT_SYMBOL(empty_zero_page);
>
> What's the benefit of giving it it's own place in the linker script vs just
> declaring it as const and having it placed in the rodata?
>

Because it collapses the two into one.
