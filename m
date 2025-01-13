Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7051D515D
	for <linux-hardening@vger.kernel.org>; Mon, 13 Jan 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803633; cv=none; b=bQsejrp60pFpUjFoEJRKaYk4W6FOcApUNioIITj9uRmYtjnN8T78gkHTYRd8QxKUW0LHliEFW3GUA/0qvz8TpI1Obcm3DZ5JQhZz2SCLXHT4otcHpCx+CpTvwxRxnHayHU4/c1IguIIvlLHwC9BMvvdt4ri1F6qd4vOsuMJyPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803633; c=relaxed/simple;
	bh=olat91GQxaxDc+pcXvumpt/j95n8eFcGc+gP7WrxgsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncV3UQrJJjTE8e1VXbsKke67nw3mKx14Nh4MEJD+HX+4F3ZnmNM3YZkHNKjelozGkZVcDoKzqm0DQ8/9w7ta4ca+z5mvqL6rVTizd2dew489GLWA5FYJFb4u4KgFEbaRgDLCf5AOMOtHtZgNqZgh8lAGdp0mlIAutU2RFWv+n1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q4TFlLlE; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q4TFlLlE"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eba783ec88so491089b6e.3
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jan 2025 13:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736803631; x=1737408431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX7paUWVQzYOHdolBm2Ggf1i9fxv9lpnxlA6gAwDKu4=;
        b=Q4TFlLlEELEgF+36pKEFHYBumVXbX6hxXM+ngwRbSCg2JFRY5w9D4v8y07Lo8tWeB0
         QUy00tOjaAKDKj/3CaI6FGf/J6kViDy9W7z0Jjj0b7Bh5nrpl1u3d4gxITz1gV0tjHcw
         9XF7pVQYalIYKW2e3yb0Re6xyRRvq15wdNiAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736803631; x=1737408431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nX7paUWVQzYOHdolBm2Ggf1i9fxv9lpnxlA6gAwDKu4=;
        b=cKdS1dHzTL+8abY6Xo0Euy2BjEA2Xd2WTLAbGc7BnceHPk0Iy0xRfyPoL3Dk7IImT+
         3XPMeD8u5zlAidCOmvFR3eHMGB1QtbEeNC49GOkF4IXD5R/Tus9s8Ue9DQWJefjepRzm
         Ef9MCxXkmkvEm61eJM7V742nAGfkDrjEVtR/8eUl8D8xjV7lozhg/yMTEP42CqobapO5
         rVm9Ahmfc+sVJYh5vBV/1yVk/CAaInJFtlKjp4qZDdOGmF4CPTqj6ExKn3swDv1A9dvb
         uUWZC/+bXNS7LO+dJUEZcAK4ychFzSXjP0IFkmetjcuMcWZ+Ep1f8mZR16m4ecQVerix
         0fQw==
X-Forwarded-Encrypted: i=1; AJvYcCWlm1s7EyhfmksyuAomQqifWuSFCD4n7klXArV/Y2eHBDFviypPcdtpWsaG4rmHQhAvyoPTHO3htTKUcawlnJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaK7gQplkU5dL9hI7GD5Nw7xU37lS5QeCTxv634iwkXQ6An1WC
	n5YJLqs4UVPqd/J5M2Kz9k197CuYkhSd7LdyfpSX274hBWn5xkMQHjesU3a6E9L9pt14HmZVtZX
	087wqf5OSvAiZcg0HvrStCVVyfOZvs+MysoZk
X-Gm-Gg: ASbGncuRuLxhNy1HPD2VLXXj87CIvcS364rgs09OGtcppF8SASkl6cJmPNxhxzz0DGi
	gqKk3MF3GB5/RhgrCMZ95PV8qfr2ZP7y33fwzOghPCbkhqTg4T3Tu73tIJRtzn5wDHl4=
X-Google-Smtp-Source: AGHT+IFn6qaJ4GZTnnEzK3QHkIiNlV0r0kHgV7xdebKFhv3DtFqpeHH69/5MdaV30LdCYF0hZOEJSRqzSIS/U00SX90=
X-Received: by 2002:a05:6870:ad89:b0:29e:55b8:3865 with SMTP id
 586e51a60fabf-2aa066960c8mr4328842fac.5.1736803630761; Mon, 13 Jan 2025
 13:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook> <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
In-Reply-To: <202501061647.6C8F34CB1A@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 13 Jan 2025 13:26:59 -0800
X-Gm-Features: AbW1kvaCvgUnDTBFFtklwcjCd_tLy64QyQ-5neuhPbLqhT9OYgtbrHnzBNQ5NvQ
Message-ID: <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>, 
	Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 5:12=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Jan 03, 2025 at 09:38:10PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Dec 17, 2024 at 02:18:53PM -0800, Kees Cook wrote:
> > > On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > > >
> > > > Those mappings are readonly or executable only, sealing can protect
> > > > them from ever changing or unmapped during the life time of the pro=
cess.
> > > > For complete descriptions of memory sealing, please see mseal.rst [=
1].
> > > >
> > > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > > generated by the kernel during program initialization, and are
> > > > sealed after creation.
> > > > [...]
> > > >
> > > > + exec.seal_system_mappings =3D [KNL]
> > > > +                 Format: { no | yes }
> > > > +                 Seal system mappings: vdso, vvar, sigpage, vsysca=
ll,
> > > > +                 uprobe.
> > > > +                 - 'no':  do not seal system mappings.
> > > > +                 - 'yes': seal system mappings.
> > > > +                 This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=3D(y/n=
)
> > > > +                 If not specified or invalid, default is the value=
 set by
> > > > +                 CONFIG_SEAL_SYSTEM_MAPPINGS.
> > > > +                 This option has no effect if CONFIG_64BIT=3Dn
> > >
> > > I know there is a v5 coming, but I wanted to give my thoughts to help
> > > shape it based on the current discussion threads.
> > >
> > > The callers of _install_special_mapping() cover what is mentioned her=
e.
> > > The vdso is very common (arm, arm64, csky, hexagon, loongarch, mips,
> > > parisc, powerpc, riscv, s390, sh, sparc, x86, um). For those with vds=
o,
> > > some also have vvar (arm, arm64, loongarch, mips, powerpc, riscv, s39=
0,
> > > sparc, x86). After that, I see a few extra things, in addition to
> > > sigpage and uprobes as mentioned already in the patch:
> > >
> > > arm sigpage
> > > arm64 compat vectors (what is this for arm?)
> > > arm64 compat sigreturn (what is this for arm?)
> > > nios2 kuser helpers
> > > uprobes
> >
> > OK let's not get ahead of ourselves :)
> >
> > VDSOs/gate VMAs are treated quite differently by different arches. So w=
e
> > have to tread _very_ carefully here.
> >
> > I believe PPC doe some 'tricky' things and may actually want to unmap, =
for
> > instance.
> >
> > The problem with this kind of change is we're doing something fundament=
al
> > that impacts _every possible combinatorial combination of configs, arch=
es,
> > and use cases_ for each of these which we seeming - just assume - will =
have
> > no issue with this.
> >
> > This is insufficient, deeply. We need:
> >
> > 1. Strong justification (hand waving won't suffice).
> > 2. Very extensive testing and checking, and _proof_ of this testing bei=
ng
> > performed.
> > 3. Buy-in from arch maintainers.
> >
> > So far this series has provided none of those. This is why I am cautiou=
s
> > and pushing back here.
>
> Sure, I agree. This is why I was suggested the ...ARCH_HAS... Kconfig.
> That will provide the way for 3) to happen. 1) just needs a little more
> details in the commit log, I guess? The goal is attack surface reduction
> in userspace, and remapping shenanigans have become a recent avenue of
> attack.
>
> For 2) there are limits. As you say we may have "every possible
> combinatorial combination", which may not be feasible to test. But
> making it available for the common cases (and of course testing those)
> makes sense.
>
> > And I absolutely will not accept a user being able to turn on a switch =
in a
> > known-broken configuration. This is absolutely unacceptable.
>
> Sure, of course.
>
> > It's equally unacceptable for a user to enable a feature that is
> > untested/confirmed on an architecture.
>
> Agreed.
>
> > So let's be careful about Linus's edict here - the operative part being=
 'if
> > it doesn't break things'.
>
> Right -- I should clarify: I don't mean to say "it should be enabled by
> default", I meant to say that we have a common pattern for making these
> kinds of features available without hiding them behind a build-time
> Kconfig that would have put the features out of reach for system owners
> that only use distro kernels, etc. I was pushing back on an earlier
> comment that I interpreted as rejecting boot params. A boot param (when
> other aspects of the system are sane) is needed for this kind of thing,
> and is the pattern we use for providing optional features that distros
> can make available without enabling them by default.
>
> > > So, if we want to have a CONFIG_MSEAL_SYSTEM_MAPPINGS at all, it shou=
ld
> > > be "default y" since we have the ...ARCH_HAS... config already, and t=
hen
> > > add a CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT that is off by default (si=
nce
> > > we expect there may be userspace impact) and tie _that_ to the kernel
> > > command-line so that end users can use it, or system builders can ena=
ble
> > > CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT.
> >
> > Again, I hate to push on this, but I am simply not going to allow users=
 to
> > enable features we know break things.
> >
> > Users might not be aware this feature is broken for CRIU, and X, and Y =
and
> > whatever else we've not thought about and enable it thinking it helps
> > security, and end up with a broken system.
>
> This will never be a bright line, and I think choice is more important.
> For example, Ubuntu builds with CRIU, but only a tiny set of tools
> actually use it. (I've actually been considering adding a boot param to
> disable CRIU features since they undermine some aspects of userspace
> security.)
>
> Regardless, yes, if we can make this work with CRIU (which I thought
> there seem to be consensus on), let's do it.
>
> > This seems like putting the onus on CRIU users to deal with a known-bro=
ken
> > thing? That seems really unreasonable? And people would just have to ha=
ve
> > the right userland code to work in the kernel with mseal?
> >
> > Yeah I oppose entirely this unless I'm missing something?
>
> Hm, well, the primary goal is for Chrome OS and Android to use this. If
> there is honestly no path forward with CRIU, then hard Kconfig conflict
> it is. I'd much rather have it available for anyone who wants it, just
> like we do with lots of other features. Why force people who want this
> and not CRIU to build their own kernels? We have all kinds of boot params
> that if you set you get a broken system.
>
This patch is intended for ChromeOS and Android and is
feature-complete from their perspective.

To simplify v5, I propose removing kernel-cmd-line and avoiding the
complexities of CRIU/UML and gVisor. The KCONFIG is disabled by
default and will only apply to ARM and Intel architectures.

Later when a generic distribution wants to enable this feature, we can
work out a solution to handle those complexities.

Is this a reasonable path to move forward ?

Thanks
-Jeff

> -Kees
>
> --
> Kees Cook
