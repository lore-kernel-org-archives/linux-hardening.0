Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374F236434;
	Thu,  6 Feb 2025 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855726; cv=none; b=Fzi3vDZQnkn23PHP5s9hPmgnzCtR/tPHO5lFICXWnNcaIMkXRcE7pOUdykJ1zZHRx+SrmEMj+hS/uzCk/k1GqzEmRISHghWGao2a3FHDyOjqe0N1qMSoqHvkG2rScNAVfqq35fvBPsSb2pXmDudK2Gh1rHQrQag+d013ZtdFhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855726; c=relaxed/simple;
	bh=9P6z6qkIa7X3sG5KnL/62de7knrUnWehSvv+N1F30f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nfhq/XskfF7f8xt5CRiWZ0rSP8r/eV5JFbN9XyXL/WUPRNP6IYWdrPfBGC8cv3EWcyFDnrrI0e0lHlfPzk0bdXw4qME4ULa8dX7rF3XOwSaLvHvzr9pOfTRM/gWcc4cbyQ0cYOK9B0OaGAyewOA04Ecu653bvJn4jUB7Y4zsn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tlh/g8Ot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cqK6j6ll; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tlh/g8Ot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cqK6j6ll"
Date: Thu, 6 Feb 2025 16:28:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738855722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pzgi0H/WeUn7swVZfsiMmckSC5AK7mrOGQcHWEcUMU=;
	b=tlh/g8OtwsWmbmER9SDkG9c831UOhZXdva7Zhf+YuZq03IZ/EyhwWltxZTNOfKfHDlCwaj
	kuxfFvnhqW2YsnnifCQ4XT92SjW9KoK2IBqdgvBcy4ShDvFCNZTag8aSD1m49cZZjuj7dL
	UqiiXOcuyKtyupfL+thxnXvN53+fEYUVleTYDuXLeVMsp0WBvSKissYOjCh0IFUgtoLnC1
	TXkhrDiJsCUnBTbXiFSV2sBrbuCTPpW2K2xpJu+B+JBYbRBWnhHovp0A54FMUSBMVB+U9c
	UXeHaSv4q1yM7P7y9tfY3JQJIIq5SNzUBcpQNlMk2TiD2jIJ/O7in6GblgO+7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738855722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pzgi0H/WeUn7swVZfsiMmckSC5AK7mrOGQcHWEcUMU=;
	b=cqK6j6llxwUEqU96sGGSNcJQ1we0zqT8Zb6lF01qXPYy9zBw39FOUFhrvsqtY/g2xLQy9X
	CINXiWSkqWLUPoAw==
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
Message-ID: <20250206154810-8b7bf2b4-435c-4930-a787-f9238cd0045d@linutronix.de>
References: <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
 <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
 <20250206135150-6c770e7d-9af8-4924-b760-82cff5092586@linutronix.de>
 <CAJgzZoq4UOYXaOh=mdUxsNUug9uYWzPX56AtUDL0RgKOx_VnQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJgzZoq4UOYXaOh=mdUxsNUug9uYWzPX56AtUDL0RgKOx_VnQA@mail.gmail.com>

On Thu, Feb 06, 2025 at 09:38:59AM -0500, enh wrote:
> On Thu, Feb 6, 2025 at 8:20 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > On Fri, Jan 17, 2025 at 02:35:18PM -0500, enh wrote:
> > > On Fri, Jan 17, 2025 at 1:20 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > <snip>
> >
> > > > There are technical difficulties to seal vdso/vvar from the glibc
> > > > side. The dynamic linker lacks vdso/vvar mapping size information, and
> > > > architectural variations for vdso/vvar also means sealing from the
> > > > kernel side is a simpler solution. Adhemerval has more details in case
> > > > clarification is needed from the glibc side.
> > >
> > > as a maintainer of a different linux libc, i've long wanted a "tell me
> > > everything there is to know about this vma" syscall rather than having
> > > to parse /proc/maps...
> > >
> > > ...but in this special case, is the vdso/vvar size ever anything other
> > > than "one page" in practice?
> >
> > x86 has two additional vvar pages for virtual clocks.
> > (Since v6.13 even split into their own mapping)
> > Loongarch has per-cpu vvar data which is larger than one page.
> > The vdso mapping is however many pages the code ends up being compiled as,
> > for example on my current x86_64 distro kernel it's two pages.
> > In the near future, probably v6.14, vvars will be split over multiple
> > pages in general [0].
> 
> /me checks the nearest arm64 phone ... yeah, vdso is still only one
> page there but vvars is already more than one.

Probably due to CONFIG_TIME_NS, see below.

> is there a TL;DR (or RTFM link) for why this is so big? a quick look
> at the x86 suggests there should only be 640 bytes of various things
> plus a handful of bytes for the rng, and while arm64 looks very
> different, that looks like it's explicitly asking for a page (with the
> vdso_data_store stuff)? (i've never had any reason to look at vvars
> before, only vdso.)

I don't think there is any real manual.

The vvar data is *shared* between the kernel and userspace.
This is done by mapping the *same* physical memory into the kernel
("vdso_data_store") and (read-only) into all userspace processes.
As PTEs always cover a full page and the kernel can not expose random
other internal kernel data into userspace, the vvars need to be in their
own dedicated page.
(The same is true for the vDSO code, uprobe trampoline, etc... mappings)

The vDSO functions also need to be aware of time namespaces. This is
implemented by allocating one page per namespace and mapping this
in place of the regular vvar page. But the vDSO still needs to access
the regular vvar page for some information, so both are mapped.

Then on top come the rng state and some architecture-specific data.
These are currently part of the time page. So they also have to dance
around the time namespace mapping shenanigans. In addition they have to
coexist with the actual time data, which is currently done by manually
calculating byte offsets for them in the time page and hardcoding those.

The linked series cleans this up by moving things into dedicated pages.
To make the code easier to understand and to make it possible to
add new data to the time page without running out of space or
introducing conflicts which need to be detected manually.
While this needs to allocate more pages, these are shared between the
whole system, so effectively it's cheap. It also requires more virtual
memory space in each process, but that shouldn't matter.


As for arm64 looking very different from x86: Hopefully not for long :-)

> > Figuring out the start and size from /proc/maps, or the new
> > PROCMAP_QUERY ioctl, is not trivial, due to architectural variations.
> 
> (obviously it's unsatisfying as a general interface, but in practice
> the VMAs i see asked about about directly -- rather than just rounded
> up in a diagnostic dump -- are either stacks ["what are the bounds of
> this stack, and does it have guard pages already?"] or code ["what
> file was the code at this pc mapped in from?"]. so while the vdso
> would come up, we'd never notice if vvars didn't work. if your sp/pc
> point there, we were already just going to bail anyway :-) )

Fair enough.

This information was also a response to Jeff's parent mail,
as it would be relevant when sealing the mappings from ld.so.

<snip>

> > [0] https://lore.kernel.org/lkml/20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de/
