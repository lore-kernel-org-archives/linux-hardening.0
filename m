Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796D235348;
	Thu,  6 Feb 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738859860; cv=none; b=tAU0fWETMppvGv80BxgV/lK4ncMm1V6y+fI+enDTHnb0OOdihYR8WFz5TcU4LOHTJqMxi9k1xEgXLw1XSqmN7zrYj8S9JqHPwqvqWjzS00jcFbheHfJNut59nNPKGNY+myITlwt0CAkhU40LGkIsji465qdF/msc7bgbRVx4vDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738859860; c=relaxed/simple;
	bh=sNvJvOF8y6VXiET6ilpfyyAjGJeJqktPKUEv7Nl8xfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/guPF7jDg3q/ZYV622WceoQKLO2jTl5bn84ojd95uGh8LSSCjEvfP5HFJHjAJIRg62bbapiiJsqt8xTlRhC1/9T7/xW8LGWsfyYXF8TM+m4kH4BlHKtO0zwcsjfmL1jMuedvq3L4GozsJVAI4DRXwCqF3KcMRNzsuZPwo5SL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pv/P/fPM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yr1rKdJF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pv/P/fPM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yr1rKdJF"
Date: Thu, 6 Feb 2025 17:37:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738859857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cKpi3TqgXVRtiUpDMLIZvQ3+RhRyWRW43y/M0D5WBE=;
	b=pv/P/fPMf5uh2H3P7A82LYI0NFBgvhnOb3HhM2tHkxgj6s8zvJHb/2NiLSVJqEEcDC53WS
	O3Pk6tlW93BAUfpLCqlE+bOlZd6P7wzTlu6DvfQ41MJ3HguwzCrt2UbsPHfa7dMOVX4QB3
	12bNbfX+K1zFkDk34x8kXWr06cuCX1Qsl/PxbPHgGLG97XLfSu253zId1WjaGinbETVo4/
	spfF9ebEW7vnGIEyoJrQyJSHl0PDAuSoE/tm37GGgjMGMAiO9pmRfC58Nv8v7Eyoid/Blx
	PVdMEVP1ynOljbR+sYtunFBv5FbhtjlkV0FzQNvFwNohQ6iHXAThyHDPeVldEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738859857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cKpi3TqgXVRtiUpDMLIZvQ3+RhRyWRW43y/M0D5WBE=;
	b=Yr1rKdJFhTBpl9ZuDGcyRFDeMRr3Ci5sDxWUnGLuinFF6cpe7/u/+obL4UJDR6PchjhujV
	LFfZefoUf0eFbzAA==
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
Message-ID: <20250206172243-bec6d9b7-c0b5-44af-908d-c7190b63c0e4@linutronix.de>
References: <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
 <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
 <20250206135150-6c770e7d-9af8-4924-b760-82cff5092586@linutronix.de>
 <CAJgzZoq4UOYXaOh=mdUxsNUug9uYWzPX56AtUDL0RgKOx_VnQA@mail.gmail.com>
 <20250206154810-8b7bf2b4-435c-4930-a787-f9238cd0045d@linutronix.de>
 <CAJgzZoqet77Ehd84Qcnz_NZQoKPzhB+7VyJYq4aP2Yo+=f9-jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJgzZoqet77Ehd84Qcnz_NZQoKPzhB+7VyJYq4aP2Yo+=f9-jw@mail.gmail.com>

On Thu, Feb 06, 2025 at 10:51:54AM -0500, enh wrote:
> On Thu, Feb 6, 2025 at 10:28 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > On Thu, Feb 06, 2025 at 09:38:59AM -0500, enh wrote:
> > > On Thu, Feb 6, 2025 at 8:20 AM Thomas Weißschuh
> > > <thomas.weissschuh@linutronix.de> wrote:
> > > >
> > > > On Fri, Jan 17, 2025 at 02:35:18PM -0500, enh wrote:
> > > > > On Fri, Jan 17, 2025 at 1:20 PM Jeff Xu <jeffxu@chromium.org> wrote:

<snip>

> > > > x86 has two additional vvar pages for virtual clocks.
> > > > (Since v6.13 even split into their own mapping)
> > > > Loongarch has per-cpu vvar data which is larger than one page.
> > > > The vdso mapping is however many pages the code ends up being compiled as,
> > > > for example on my current x86_64 distro kernel it's two pages.
> > > > In the near future, probably v6.14, vvars will be split over multiple
> > > > pages in general [0].
> > >
> > > /me checks the nearest arm64 phone ... yeah, vdso is still only one
> > > page there but vvars is already more than one.
> >
> > Probably due to CONFIG_TIME_NS, see below.
> >
> > > is there a TL;DR (or RTFM link) for why this is so big? a quick look
> > > at the x86 suggests there should only be 640 bytes of various things
> > > plus a handful of bytes for the rng, and while arm64 looks very
> > > different, that looks like it's explicitly asking for a page (with the
> > > vdso_data_store stuff)? (i've never had any reason to look at vvars
> > > before, only vdso.)
> >
> > I don't think there is any real manual.
> >
> > The vvar data is *shared* between the kernel and userspace.
> > This is done by mapping the *same* physical memory into the kernel
> > ("vdso_data_store") and (read-only) into all userspace processes.
> > As PTEs always cover a full page and the kernel can not expose random
> > other internal kernel data into userspace, the vvars need to be in their
> > own dedicated page.
> > (The same is true for the vDSO code, uprobe trampoline, etc... mappings)
> >
> > The vDSO functions also need to be aware of time namespaces. This is
> > implemented by allocating one page per namespace and mapping this
> > in place of the regular vvar page. But the vDSO still needs to access
> > the regular vvar page for some information, so both are mapped.
> 
> ah, i see. yeah, that makes sense. (amusingly, i almost quipped "it's
> not like there are _that_ many clocks to go in there" in my previous
> mail, forgetting that there are effectively an unbounded number of
> clocks thanks to this feature!)

Tiny clarification:

The additional, namespaced clocks do not use additional space in the
global time vvar page. They live in a dedicated, dynamically allocated,
per-namespace page. So the used space within a vvar page does not change
at runtime and can never run out. The amount of vvar mappings per
process is also constant.

The namespaced time vvar pages have the same structure layout as the
global one, but not all fields are used and some are used differently.
Specifically the namespace pages only contain the offsets to the base
clock and the dynamic clock data is read from the global page.

<snip>
