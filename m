Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82217F7;
	Wed, 26 Feb 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555312; cv=none; b=hwO4JMwkmeFf4gK1GlMa6rbLK89lhXsfBxF9LPiM+dO4OngBCEafcw/3IJSp4E32tWY6DkLQNsuR5TsZ3vi3YC2SelN6/Tpm3XiEtknWnpzu0FU2UK1bfZlzDBiufeoHqhZ+DJxCOowFy2yQ/rUl6KNc42VfSpT00jZC9O+CFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555312; c=relaxed/simple;
	bh=95//k1EBPKb7DyIji7MIRLGiojlFtrEAPOd91FSv4xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyZkayl8KacW7UNBAtmvlaROZXArD/aMjK967nZ+ErpGJWYFlraPFsQ+pgVWQdahm3foD9CPvl8b2hA1hQ3Ybdj3ZF7xz+muwLhP0+QfgnWgb3oXOUIUfOafxfEpnCFd4Xcj/O/bqBSyWScGNmepj4s0ZQ0RVJ+drlyNA0HNIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZpme/w+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GG5eJRbw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZpme/w+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GG5eJRbw"
Date: Wed, 26 Feb 2025 08:35:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740555307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scHHpoERaISGWPCPSfxNtAEwSLspOWsXVfCnJqqdlO0=;
	b=qZpme/w+VIp8r455uKbsVXT4drb1iNMy5qXAcQFs566PspJzxeb2LW204xs8gTekXPRYiw
	dPtVIaYre4dX3YpqyIrhcC6cJjV1FGZCwodgj1YV7F/a5f96xeRwhyPa8mmeC8lyNNZrdq
	1lZ82Lxmgma94Z/boUSYX1V04+PplNLe58UJ3PreQEae9Bi58DNY13+7e06xrOjVXvyU2K
	xwrP0tSdbU6E6uQdX/Rs+OCuh/xDwmdwjFeWzGsEjp/AGWGn5b0Jh2//rN3j08iFScYT+w
	m92Lho6vcSA32o25Cx7cZ69QNKLnCcy3/TC+PMojRWprwHSzQtVgX2TiAm2w1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740555307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scHHpoERaISGWPCPSfxNtAEwSLspOWsXVfCnJqqdlO0=;
	b=GG5eJRbw2mKG7jVbCJ3hQcaxb87U5Koj3eTzeWIDDQ0u/Zk9dj2CkkjwGU22Nvgc3WbEwW
	+pVAJiTdu6pP/DBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, adobriyan@gmail.com, johannes@sipsolutions.net, 
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Subject: Re: [PATCH v7 3/7] mseal, system mappings: enable x86-64
Message-ID: <20250226082701-9057b348-b074-488f-9aca-49ffbc78237f@linutronix.de>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-4-jeffxu@google.com>
 <20250225085728-24167715-8562-45a8-86cd-0ea503e4bc73@linutronix.de>
 <CABi2SkUwETzrBSYm0QV9+eoeo0kgA+r2JM4QaFpQqeTiidFEDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUwETzrBSYm0QV9+eoeo0kgA+r2JM4QaFpQqeTiidFEDA@mail.gmail.com>

On Tue, Feb 25, 2025 at 04:48:47PM -0800, Jeff Xu wrote:
> On Tue, Feb 25, 2025 at 12:08 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> > On Mon, Feb 24, 2025 at 10:52:42PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> > > covering the vdso, vvar, vvar_vclock.
> > >
> > > Production release testing passes on Android and Chrome OS.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  arch/x86/Kconfig          |  1 +
> > >  arch/x86/entry/vdso/vma.c | 16 ++++++++++------
> > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 87198d957e2f..8fa17032ca46 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -26,6 +26,7 @@ config X86_64
> > >       depends on 64BIT
> > >       # Options that are inherently 64-bit kernel only:
> > >       select ARCH_HAS_GIGANTIC_PAGE
> > > +     select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > >       select ARCH_SUPPORTS_PER_VMA_LOCK
> > >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > > index 39e6efc1a9ca..1b1c009f20a8 100644
> > > --- a/arch/x86/entry/vdso/vma.c
> > > +++ b/arch/x86/entry/vdso/vma.c
> > > @@ -247,6 +247,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
> > >       struct mm_struct *mm = current->mm;
> > >       struct vm_area_struct *vma;
> > >       unsigned long text_start;
> > > +     unsigned long vm_flags;
> > >       int ret = 0;
> > >
> > >       if (mmap_write_lock_killable(mm))
> > > @@ -264,11 +265,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
> > >       /*
> > >        * MAYWRITE to allow gdb to COW and set breakpoints
> > >        */
> > > +     vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> > > +     vm_flags |= VM_SEALED_SYSMAP;
> > >       vma = _install_special_mapping(mm,
> > >                                      text_start,
> > >                                      image->size,
> > > -                                    VM_READ|VM_EXEC|
> > > -                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > > +                                    vm_flags,
> > >                                      &vdso_mapping);
> > >
> > >       if (IS_ERR(vma)) {
> > > @@ -276,11 +278,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
> > >               goto up_fail;
> > >       }
> > >
> > > +     vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > > +     vm_flags |= VM_SEALED_SYSMAP;
> > >       vma = _install_special_mapping(mm,
> > >                                      addr,
> > >                                      (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
> > > -                                    VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> > > -                                    VM_PFNMAP,
> > > +                                    vm_flags,
> > >                                      &vvar_mapping);
> >
> > This hunk (and the vvar mapping in the arm64 patch) will conflict with my
> > "Generic vDSO datapage" series.
> > That series is already part of the tip tree (branch timers/vdso) and scheduled
> > for the next merge window.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=timers/vdso
> >
> > The conflict resolution is fairly easy:
> > Move the new flag logic into lib/vdso/datastore.c
> >
> Thank you for bringing this to my attention.
> 
> In your change,  it seems lib/vdso/datastore.c implements a
> vdso_install_vvar_mapping(), then all the architectures call this
> function.

Correct.

At least all the architectures using the generic vDSO infrastructure,
which are the ones you care about.
Sparc for example has its own implementation.

> So merging conflict won't be as straightforward.

Wouldn't it be enough to unconditionally use VM_SEALED_SYSMAP in
vdso_install_vvar_mapping()?
The symbol is a noop on architectures or configurations where the new
functionality is not available or enabled.

> Maybe a better
> approach is that I continue resolving all the comments, based on the
> latest main. Then wait for your change to be merged and submit another
> version.

That would work, too. As you prefer.
