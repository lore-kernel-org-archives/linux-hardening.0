Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05C1F416C
	for <linux-hardening@vger.kernel.org>; Thu,  6 Feb 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857129; cv=none; b=hV06snvKiYYt1K294vpsWrkbhlQwsE11EO8ULtH5WafMiyVq4JeQma4lUtiJ339bZ1PRg9UJihCfN+3eB15Qus4hAEH1evdjBILsDyCQJ5p/7r1kGD358Ge8LtE5ITdj3LUy5pN8gEDyymIdCB4hslaTZckKRmCSt4gS086OeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857129; c=relaxed/simple;
	bh=ncyCUMlwr1q4MwNPZcdzv/OPKNB5ERDfxDAcdsQ59wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5Gt7rgGb2rJ7TpCQdgRO0bqd1DOAAXQAgDGlJfAyy5fm/fLKqak2SnhQEFNciTP8X5ROV59S9aLg6puEAS6hwHCEnH5WOVOEO6DzDQV7bUJnxkGBV60hihIOmSRoqKRlGh5YAs7JrDuXzgA30BCk9/HWcRd4sai22iQttAfKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7krfYcD; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7krfYcD"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fc0b7a4e5dso506108eaf.1
        for <linux-hardening@vger.kernel.org>; Thu, 06 Feb 2025 07:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738857126; x=1739461926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncyCUMlwr1q4MwNPZcdzv/OPKNB5ERDfxDAcdsQ59wc=;
        b=i7krfYcDWGYyZ7Kq5CczAS8wSacEHpta3hhW6GPNk2hnywz54HEykJc+N0WwN15z1r
         yWLKD3uwkF52yiK9AwI14QK8zUhWYt5hTWhRm8MuzIpaGf6Sp1cwhNeMyOlOPdTzVRAa
         LFA2EUfIKRqfPHszNshdc7T/kfnkGMq8vPmxVy5kcp0u/B5HEUtScYN97+4KPgnm2Oq7
         /83ksbHXmd3igvd/jjtv1EqU5oJX7PwU4T4YJexP31y82ZdmB91pOQ+xqbA5OwD8QtQR
         UqRz0fsd336GUPxIJBYIuukuWKBKSwUR/nhfCIqAbun2PNwGoIFUBgOmxH2Nwc48wyXe
         nm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738857126; x=1739461926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncyCUMlwr1q4MwNPZcdzv/OPKNB5ERDfxDAcdsQ59wc=;
        b=qcjIGjylLTQVk3H4Cwxpm8418TEUZEHSGAUlh36nO6BmleaK2/bJwosBauZ5A2RwHi
         GsGkgECNaeE9nNsbiBS1W3YkeMb/SVBVMkqAwNCeX1Es4cTpKRiPXHSUchA3tSw+2qMT
         cgDQtmb+T4n1OsKPxCnRWtijArZisAAvE8ko0yFShfW+lu+cdo9VGV7KUcEkR6mg32wb
         GvpLOkq8qzAhbXQOUFESLiH4QDIeZr+3o8I++ttJg70KqJq1Q53sdIST317kHFRolnlm
         KD0cuhhomPr0UoxF4X7OIBS3BpcKDpu1vmakRIvQyJ5TjajmK0cZfOdpo79R36EDz/Q4
         CfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG+mddm4jexfZkDXW6tzg6e70JipNHOoaA+75SXqYuk4g6tCOrpWKb24PlSbtUBWjjTOaeTW5FghRPtsDinLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFkZzm0Dn4xiExqby/frXRsqhk/T41Zq8LPdbbJCdFTQTwWpZV
	pKV2H+9RQR01CEpvCwu5lKRU8Qbh7SYUzQtoXdlAz/jo5xE1ubj1DiWX1ARuF83cRssNTiLIs8q
	FOsuQ0wZy1/78UPpPP+4SRESU8Vgwof6foMwa
X-Gm-Gg: ASbGncuOFEMKv0AKOZGKD1qYJDg8RDjlEsXiukNSqpkmLUz8jhhWilVM72WT/QZLNTX
	HZF/iZqlVGYRQDDjO4rHfvz93OsIOmBZklU/YbTUXFHnCA6IEnzYcbWFP9j4NRHAnu/38ag==
X-Google-Smtp-Source: AGHT+IGHI7yAVXLvlNlCs3v0SKEotepWb9UfWcG+OprdiS+5n+vsUc8hOcDdllOoto/wJReH3eO28XCwjOAKCK2X1vY=
X-Received: by 2002:a05:6870:80c9:b0:29e:5a89:8ed8 with SMTP id
 586e51a60fabf-2b804f728f1mr4716147fac.11.1738857126288; Thu, 06 Feb 2025
 07:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local> <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local> <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
 <20250206135150-6c770e7d-9af8-4924-b760-82cff5092586@linutronix.de>
 <CAJgzZoq4UOYXaOh=mdUxsNUug9uYWzPX56AtUDL0RgKOx_VnQA@mail.gmail.com> <20250206154810-8b7bf2b4-435c-4930-a787-f9238cd0045d@linutronix.de>
In-Reply-To: <20250206154810-8b7bf2b4-435c-4930-a787-f9238cd0045d@linutronix.de>
From: enh <enh@google.com>
Date: Thu, 6 Feb 2025 10:51:54 -0500
X-Gm-Features: AWEUYZn6CPh2B4zyNHxi4kuReb_Dep_OpvVIHc-KSEs4_biKleMDcUfMPCucf6k
Message-ID: <CAJgzZoqet77Ehd84Qcnz_NZQoKPzhB+7VyJYq4aP2Yo+=f9-jw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Benjamin Berg <benjamin@sipsolutions.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>, 
	Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:28=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Thu, Feb 06, 2025 at 09:38:59AM -0500, enh wrote:
> > On Thu, Feb 6, 2025 at 8:20=E2=80=AFAM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > On Fri, Jan 17, 2025 at 02:35:18PM -0500, enh wrote:
> > > > On Fri, Jan 17, 2025 at 1:20=E2=80=AFPM Jeff Xu <jeffxu@chromium.or=
g> wrote:
> > >
> > > <snip>
> > >
> > > > > There are technical difficulties to seal vdso/vvar from the glibc
> > > > > side. The dynamic linker lacks vdso/vvar mapping size information=
, and
> > > > > architectural variations for vdso/vvar also means sealing from th=
e
> > > > > kernel side is a simpler solution. Adhemerval has more details in=
 case
> > > > > clarification is needed from the glibc side.
> > > >
> > > > as a maintainer of a different linux libc, i've long wanted a "tell=
 me
> > > > everything there is to know about this vma" syscall rather than hav=
ing
> > > > to parse /proc/maps...
> > > >
> > > > ...but in this special case, is the vdso/vvar size ever anything ot=
her
> > > > than "one page" in practice?
> > >
> > > x86 has two additional vvar pages for virtual clocks.
> > > (Since v6.13 even split into their own mapping)
> > > Loongarch has per-cpu vvar data which is larger than one page.
> > > The vdso mapping is however many pages the code ends up being compile=
d as,
> > > for example on my current x86_64 distro kernel it's two pages.
> > > In the near future, probably v6.14, vvars will be split over multiple
> > > pages in general [0].
> >
> > /me checks the nearest arm64 phone ... yeah, vdso is still only one
> > page there but vvars is already more than one.
>
> Probably due to CONFIG_TIME_NS, see below.
>
> > is there a TL;DR (or RTFM link) for why this is so big? a quick look
> > at the x86 suggests there should only be 640 bytes of various things
> > plus a handful of bytes for the rng, and while arm64 looks very
> > different, that looks like it's explicitly asking for a page (with the
> > vdso_data_store stuff)? (i've never had any reason to look at vvars
> > before, only vdso.)
>
> I don't think there is any real manual.
>
> The vvar data is *shared* between the kernel and userspace.
> This is done by mapping the *same* physical memory into the kernel
> ("vdso_data_store") and (read-only) into all userspace processes.
> As PTEs always cover a full page and the kernel can not expose random
> other internal kernel data into userspace, the vvars need to be in their
> own dedicated page.
> (The same is true for the vDSO code, uprobe trampoline, etc... mappings)
>
> The vDSO functions also need to be aware of time namespaces. This is
> implemented by allocating one page per namespace and mapping this
> in place of the regular vvar page. But the vDSO still needs to access
> the regular vvar page for some information, so both are mapped.

ah, i see. yeah, that makes sense. (amusingly, i almost quipped "it's
not like there are _that_ many clocks to go in there" in my previous
mail, forgetting that there are effectively an unbounded number of
clocks thanks to this feature!)

> Then on top come the rng state and some architecture-specific data.
> These are currently part of the time page. So they also have to dance
> around the time namespace mapping shenanigans. In addition they have to
> coexist with the actual time data, which is currently done by manually
> calculating byte offsets for them in the time page and hardcoding those.
>
> The linked series cleans this up by moving things into dedicated pages.
> To make the code easier to understand and to make it possible to
> add new data to the time page without running out of space or
> introducing conflicts which need to be detected manually.
> While this needs to allocate more pages, these are shared between the
> whole system, so effectively it's cheap. It also requires more virtual
> memory space in each process, but that shouldn't matter.
>
>
> As for arm64 looking very different from x86: Hopefully not for long :-)

(even as someone who doesn't work on the kernel, things like this are
always helpful --- just having one thing to understand/your first grep
being relevant is much nicer than "oh, wait ... which architecture was
that?".)

> > > Figuring out the start and size from /proc/maps, or the new
> > > PROCMAP_QUERY ioctl, is not trivial, due to architectural variations.
> >
> > (obviously it's unsatisfying as a general interface, but in practice
> > the VMAs i see asked about about directly -- rather than just rounded
> > up in a diagnostic dump -- are either stacks ["what are the bounds of
> > this stack, and does it have guard pages already?"] or code ["what
> > file was the code at this pc mapped in from?"]. so while the vdso
> > would come up, we'd never notice if vvars didn't work. if your sp/pc
> > point there, we were already just going to bail anyway :-) )
>
> Fair enough.
>
> This information was also a response to Jeff's parent mail,
> as it would be relevant when sealing the mappings from ld.so.
>
> <snip>
>
> > > [0] https://lore.kernel.org/lkml/20250204-vdso-store-rng-v3-0-13a4669=
dfc8c@linutronix.de/
