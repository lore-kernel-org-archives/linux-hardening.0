Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB62319873;
	Thu, 22 Jan 2026 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091923; cv=none; b=aamtTDbTpJsCNCky+8Joip/7/h147wZlp8ufjYXvAMPdie0V8vuyu+9ltm6Va9EmGzko2pgPUiUrqw1dTqCqqPR/xdNgJnN8Gev6eUxbvHeviu41eomPcyP1zjOc9t8A+CUhOC9axtSZslwI9ADHw6kVmRyW61pTtZAO5ko8hg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091923; c=relaxed/simple;
	bh=iByQo8eij422qauN6fry2e80FcUR/Ti7ouNkqlgXpgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiuI79aH/MwC/kCo6oMNvkA9tz8V8+OCc1+Nfw0Rb9kG2HBKO3DtHs/5TT3nsMsjsA4NWoftS7Faewa7Hk9bQur3+fRiQ8Sgo/htqRIL1HSpVTKRW3ADrzjO36oMnbDEdQrDxbXWb/gOEEk/RHO3tPCNKkpJ6ZzQ9ym0gK5GgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NdlcJkWr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NdlcJkWr"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9475240E00DE;
	Thu, 22 Jan 2026 14:25:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4BRwvGoZQRQm; Thu, 22 Jan 2026 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769091916; bh=NAIFPx3sK3cpUIUYyaCVcE3s9ryqv4NTih6zst0kCME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdlcJkWrP9vxJYHucZUF/6JkWPayAIFr408dOzMY13sLFR/m7FFaQy0pLZ3KLBvEn
	 u54i6k7Ju1cqXSRz4leeN8DvCRK9Npo9diP+HSESWf/q/QeM6fOWlyvcvkTP2b5g7+
	 o7YgzQJEGBOQNt26nm2CZWDzZ2w0X8pkN0QNlRZG2vU0oef+KAlTJH3+s3ohWy6Nrn
	 /PRM06Gs9lqVMKm5wNTZR47YL5PmDPz3PgQrof1Osa59IgS1qSP41hRBDelsvxUUqG
	 vNY6GEg65J8C8Gwuzj2WgMD2QyXdPoMb22leEVMNPo8oLQB11mv0V9eG6WiQmtg+aI
	 qiO9GkqNh5T0lE/PrMaZVTbFIWx0XxVkiWLaU222KCzTSycTW2oOx1U5rn18s/Cy0L
	 w75vsrzm30gM63SssAjEGdy7m7+roX9gFLaSeCYhPOY8HgCzrrr4c9VEx9+VNfx5FI
	 N5BvT7npHsTs8Bxgm+ePmG3Z7WEjnb/5YPIJ/v185ojRF999nmhMMLQnunj8TVMRX5
	 DzjdFcBKY8RamJj/rI9K93exIiW9fSeWm8F22a2fZCWw/cs8pGRBdMQ8jcUdqV2uiJ
	 4xMGsP8F0uf6JFgsLib8uFDEdksz2qBjnm9OPBzpZuIxxWpwuAa3lFXTg/cv4HiHvz
	 s+zTdqKbYuV/lneVUS2xImrQ=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 18A8440E027A;
	Thu, 22 Jan 2026 14:25:03 +0000 (UTC)
Date: Thu, 22 Jan 2026 15:25:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 01/19] x86/idt: Move idt_table to __ro_after_init
 section
Message-ID: <20260122142502.GFaXIzPox9KTcjLwNf@fat_crate.local>
References: <20260108092526.28586-21-ardb@kernel.org>
 <20260108092526.28586-22-ardb@kernel.org>
 <20260122130839.GFaXIhV9SPFzS-RDnj@fat_crate.local>
 <CAMj1kXFK-Xf73wHDnidhDdMpb=UrWaf3vQhnggmNqOJspKYqvg@mail.gmail.com>
 <20260122135831.GCaXItB6KFO_HRqGcD@fat_crate.local>
 <CAMj1kXEVEbZGaVKdLp-95ffFv_cy181sB791LJYptkL+ap3VhQ@mail.gmail.com>
 <20260122141606.GDaXIxJuTqPFyqmVJG@fat_crate.local>
 <CAMj1kXH6XCTCeEFDkn+8zygWR=Oq-h57VV3YyX+n+CjH98eNKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXH6XCTCeEFDkn+8zygWR=Oq-h57VV3YyX+n+CjH98eNKg@mail.gmail.com>

On Thu, Jan 22, 2026 at 03:20:39PM +0100, Ard Biesheuvel wrote:
> Fair enough. What I meant to say is that if your BSS placed on a 2M
> boundary or is sufficiently larger than that, some of it will be
> mapped using PMDs, and this change will prevent those from being
> broken up into page mappings. If your BSS is too small to be covered
> by huge page mappings in the first place, this change obviously does
> nothing (except fixing a bug on i386)

That makes more sense. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
