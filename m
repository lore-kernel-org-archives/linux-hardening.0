Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EED2451F0;
	Thu,  6 Feb 2025 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848027; cv=none; b=ev6S5pQzQ8MNAFkBTINT4VAPSJKGFZO5OY7mDefOvOalp2vefrY8PkRq/mP/bz9S521i2gFjoT7h7wLADlMJ0xn6Pt8Y1Ot0Rd6A+6/xyAVpCAtBXvf1C0KnJHgZvNRAOwgnD3x/n5lxWTPnZ43NZmYSHFggfvzG3nnRqFc6fUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848027; c=relaxed/simple;
	bh=85OGFqCAaYhHp9+67jN8c6VZPGWz0QLxevvnw8zRwLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQR6yTzu3ZkYlHVA3+ke0JA7BY83L8dxXdOKxSwcCBYyMSx+TeeMU3KgBvCgCQnxd4R53GmWnyi+TGsMcQLet9v2MbdmYBbU22QlqLBZbbs9N8pBN/L0DRIOPY1A1ZnS+FjEyj9sgOFF3+frFSEcuwlU6Ceq9hiFFGojAMkLBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vsra+7bh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvIe/z1D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vsra+7bh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvIe/z1D"
Date: Thu, 6 Feb 2025 14:20:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738848023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ud3Qu2rXs7gKlmPU8x2diyWcmreX5g6Jir9z7AYo2Q=;
	b=Vsra+7bhKm9lHVvPeMv4HsaPWHQq0miNDYD4giIigcTE6+1b92B9WaqzWrT+Hhbjp9x4hO
	etvZB5QjHgy0MhYdnIdnRqAOlhb6RGf3UT9ohGnEzoODPuqjNCsCHwm7zRtLEDbNZh0ZxX
	1JdnkzAzcUj3XNu/4i+ZL92CL37DzoXS1cVcRiJqSPMngIOAeTtEJ6AhFdKsWf8FZjb8m8
	I+4K3HvD6HkGXwNw4AH7pI9OEl5GND7Uhqp/72nm3UTppsPaMyT/B0vuCCqz8MeThBGCdT
	CnT7lh5XcqFgpH2c0N8vk+zFjAfWsf+KGd3HHQPYylr3cP/OaWCfyFEuA+EEhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738848023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ud3Qu2rXs7gKlmPU8x2diyWcmreX5g6Jir9z7AYo2Q=;
	b=IvIe/z1DEyPwDIET7ND0p6Do1/gTd/Eu+o6lDk7vaU30Voa8a/qwsrPUCezHNX9XvfwWDZ
	ZrVHN26MvqfrHGBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: enh <enh@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Benjamin Berg <benjamin@sipsolutions.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, Liam.Howlett@oracle.com, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <20250206135150-6c770e7d-9af8-4924-b760-82cff5092586@linutronix.de>
References: <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
 <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>

On Fri, Jan 17, 2025 at 02:35:18PM -0500, enh wrote:
> On Fri, Jan 17, 2025 at 1:20 PM Jeff Xu <jeffxu@chromium.org> wrote:

<snip>

> > There are technical difficulties to seal vdso/vvar from the glibc
> > side. The dynamic linker lacks vdso/vvar mapping size information, and
> > architectural variations for vdso/vvar also means sealing from the
> > kernel side is a simpler solution. Adhemerval has more details in case
> > clarification is needed from the glibc side.
> 
> as a maintainer of a different linux libc, i've long wanted a "tell me
> everything there is to know about this vma" syscall rather than having
> to parse /proc/maps...
> 
> ...but in this special case, is the vdso/vvar size ever anything other
> than "one page" in practice?

x86 has two additional vvar pages for virtual clocks.
(Since v6.13 even split into their own mapping)
Loongarch has per-cpu vvar data which is larger than one page.
The vdso mapping is however many pages the code ends up being compiled as,
for example on my current x86_64 distro kernel it's two pages.
In the near future, probably v6.14, vvars will be split over multiple
pages in general [0].

Figuring out the start and size from /proc/maps, or the new
PROCMAP_QUERY ioctl, is not trivial, due to architectural variations.

Trying to construct the size from the ELF header is also problematic as
that only contains information about the vdso code.
The vvars are mapped before the code in memory independently.

A dedicated interface like a prctl() would be actually reliable.
Or theoretically a function from the vdso itself.

<snip>

[0] https://lore.kernel.org/lkml/20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de/
