Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C631D61BB
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jan 2025 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967760; cv=none; b=RFos7JlKnQJewrCdcZZwAg+33Vz95uxogThZ3GWuhu/d6XSdeLmgU1OLTM9AOKnZfss8y4HqNxb/PBaZofBhojnZrpS9xGccCBIT5oeyRKcobHK6rddRChcOUEhj4iydR9ufZi6toyyeBD579Y+TT4//AmJ/yIjb8EbfdmVSx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967760; c=relaxed/simple;
	bh=3ighn12Eyz8HISDTVC+v2Jp0v9sQYJJc6UmXW3L7mvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udjMAKXsJ2WhrQc/XsqwdS/M0d1cl0rGEYmTJWiL6v0AYtqmBk7dGufQ6F3cByP/GZG/J/yhYzxU/bwZxDtVK0MmtD893MhVl2cTok6BHpxKBuzf58Er2HQeat/lRjt2EAJMENU6ZrgAmf+btUweFOb2qHbQVYro2s4pVXt1U1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nm45Blz/; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nm45Blz/"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb8583e9f0so22487b6e.1
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jan 2025 11:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736967758; x=1737572558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR553TrwrqpCCgJhzSi22uMSFUqd9KOEdzBBC2gdpdM=;
        b=nm45Blz/NyaSfcMzVjyqphInv8cN3vAnh5tcGC5m0jOkZS/4/6tv7hHfU39dilUClK
         sR/Oq24Pk2B8FSVWkmiK9/br5ORJ04rC457Tj/RKncp7GS65GGXWAZ0S2u0aWgJX72XA
         3J022+qHwpuKCrF4XSL++bGnXMD8zadbeyLN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736967758; x=1737572558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR553TrwrqpCCgJhzSi22uMSFUqd9KOEdzBBC2gdpdM=;
        b=wBbQExXH0vm05WGyuzj+7g5URQZOzLzbZH3JGJpI+FfWiCLDQQ+cbjCB9/jRPew0QI
         P83O7NJAg97UU1qMuN9mFkiWzlyBPRvVLMHyIW+rkdmlIgATK94mxAZS8Qf6EZ+rIV/C
         HDbgyyAwAbeC7GCzgH8NV+E5GnKPavccKwUdkoz6piFA0apdXhnncyRgvUi14OHSVCi7
         Fjqr6PNlh+WgYtUq8yxa4bEnjwML7X5otM5uhKJUVb0hDC07sc8fiuvwzFVqB467c491
         V+gPTVS+VWgzajNSoZwSczTedG9MRwgEYzMHB4H4fVoYyOYhgPeltUaXuV1o8Ab9RGix
         YDBA==
X-Forwarded-Encrypted: i=1; AJvYcCUdNwia9xR5CdnmgN6KvIYlAAAsaqkxdqHjwp3sSCgAw/r4+GqzzUTbZFj/2GI8fS7pFYBNhyz0A4KUYAYTcyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz731FBwOe/Dyc2M468X14OkASCheAtHPgkxSBdFFmIvCPVS0kO
	eYfdaesYT+i0ES5cMYamDEuJuGx8eAkuLubJtPZ/hwpLqI8yY1rAbkELDY4fd8ze7g4qfYaFllG
	gXXGgc4cVJmCr9OChiInqBZ0uKsO+529x4vmo
X-Gm-Gg: ASbGncv92v2nLqP8oNTZ386FuxEp9+dab8HSUgKzYP2oiqE9L/+KspHZhIPIS0aAPXA
	fw4uPIeBQWVl2kO503k731U60XbKcQBQ8+QrB7IJC1vd1gdNUcDjJ6KQxFOOMnpWMl0NRh7o=
X-Google-Smtp-Source: AGHT+IHJDYeJ5X0NO40gYrCx6Nf+CyMxD/lyuS+UJt1ruVzlXnqHay0LNFC2x3q6Z8XDTFcnvw2j69mY7aWEtcnWIuA=
X-Received: by 2002:a05:6870:de17:b0:29e:1875:222d with SMTP id
 586e51a60fabf-2aa06530726mr6681786fac.1.1736967757563; Wed, 15 Jan 2025
 11:02:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook> <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook> <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
In-Reply-To: <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 15 Jan 2025 11:02:26 -0800
X-Gm-Features: AbW1kvYn2BAPo5WR7fYl8bHiH30P-gCiaywMoquNyqXZp_TgZxuUPDbEj7X10Wo
Message-ID: <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
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
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	Benjamin Berg <benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 1:26=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Mon, Jan 6, 2025 at 5:12=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> >
> > On Fri, Jan 03, 2025 at 09:38:10PM +0000, Lorenzo Stoakes wrote:
> > > On Tue, Dec 17, 2024 at 02:18:53PM -0800, Kees Cook wrote:
> > > > On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote=
:
> > > > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > > > >
> > > > > Those mappings are readonly or executable only, sealing can prote=
ct
> > > > > them from ever changing or unmapped during the life time of the p=
rocess.
> > > > > For complete descriptions of memory sealing, please see mseal.rst=
 [1].
> > > > >
> > > > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > > > generated by the kernel during program initialization, and are
> > > > > sealed after creation.
> > > > > [...]
> > > > >
> > > > > + exec.seal_system_mappings =3D [KNL]
> > > > > +                 Format: { no | yes }
> > > > > +                 Seal system mappings: vdso, vvar, sigpage, vsys=
call,
> > > > > +                 uprobe.
> > > > > +                 - 'no':  do not seal system mappings.
> > > > > +                 - 'yes': seal system mappings.
> > > > > +                 This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=3D(y=
/n)
> > > > > +                 If not specified or invalid, default is the val=
ue set by
> > > > > +                 CONFIG_SEAL_SYSTEM_MAPPINGS.
> > > > > +                 This option has no effect if CONFIG_64BIT=3Dn
> > > >
> > > > I know there is a v5 coming, but I wanted to give my thoughts to he=
lp
> > > > shape it based on the current discussion threads.
> > > >
> > > > The callers of _install_special_mapping() cover what is mentioned h=
ere.
> > > > The vdso is very common (arm, arm64, csky, hexagon, loongarch, mips=
,
> > > > parisc, powerpc, riscv, s390, sh, sparc, x86, um). For those with v=
dso,
> > > > some also have vvar (arm, arm64, loongarch, mips, powerpc, riscv, s=
390,
> > > > sparc, x86). After that, I see a few extra things, in addition to
> > > > sigpage and uprobes as mentioned already in the patch:
> > > >
> > > > arm sigpage
> > > > arm64 compat vectors (what is this for arm?)
> > > > arm64 compat sigreturn (what is this for arm?)
> > > > nios2 kuser helpers
> > > > uprobes
> > >
> > > OK let's not get ahead of ourselves :)
> > >
> > > VDSOs/gate VMAs are treated quite differently by different arches. So=
 we
> > > have to tread _very_ carefully here.
> > >
> > > I believe PPC doe some 'tricky' things and may actually want to unmap=
, for
> > > instance.
> > >
> > > The problem with this kind of change is we're doing something fundame=
ntal
> > > that impacts _every possible combinatorial combination of configs, ar=
ches,
> > > and use cases_ for each of these which we seeming - just assume - wil=
l have
> > > no issue with this.
> > >
> > > This is insufficient, deeply. We need:
> > >
> > > 1. Strong justification (hand waving won't suffice).
> > > 2. Very extensive testing and checking, and _proof_ of this testing b=
eing
> > > performed.
> > > 3. Buy-in from arch maintainers.
> > >
> > > So far this series has provided none of those. This is why I am cauti=
ous
> > > and pushing back here.
> >
> > Sure, I agree. This is why I was suggested the ...ARCH_HAS... Kconfig.
> > That will provide the way for 3) to happen. 1) just needs a little more
> > details in the commit log, I guess? The goal is attack surface reductio=
n
> > in userspace, and remapping shenanigans have become a recent avenue of
> > attack.
> >
> > For 2) there are limits. As you say we may have "every possible
> > combinatorial combination", which may not be feasible to test. But
> > making it available for the common cases (and of course testing those)
> > makes sense.
> >
> > > And I absolutely will not accept a user being able to turn on a switc=
h in a
> > > known-broken configuration. This is absolutely unacceptable.
> >
> > Sure, of course.
> >
> > > It's equally unacceptable for a user to enable a feature that is
> > > untested/confirmed on an architecture.
> >
> > Agreed.
> >
> > > So let's be careful about Linus's edict here - the operative part bei=
ng 'if
> > > it doesn't break things'.
> >
> > Right -- I should clarify: I don't mean to say "it should be enabled by
> > default", I meant to say that we have a common pattern for making these
> > kinds of features available without hiding them behind a build-time
> > Kconfig that would have put the features out of reach for system owners
> > that only use distro kernels, etc. I was pushing back on an earlier
> > comment that I interpreted as rejecting boot params. A boot param (when
> > other aspects of the system are sane) is needed for this kind of thing,
> > and is the pattern we use for providing optional features that distros
> > can make available without enabling them by default.
> >
> > > > So, if we want to have a CONFIG_MSEAL_SYSTEM_MAPPINGS at all, it sh=
ould
> > > > be "default y" since we have the ...ARCH_HAS... config already, and=
 then
> > > > add a CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT that is off by default (=
since
> > > > we expect there may be userspace impact) and tie _that_ to the kern=
el
> > > > command-line so that end users can use it, or system builders can e=
nable
> > > > CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT.
> > >
> > > Again, I hate to push on this, but I am simply not going to allow use=
rs to
> > > enable features we know break things.
> > >
> > > Users might not be aware this feature is broken for CRIU, and X, and =
Y and
> > > whatever else we've not thought about and enable it thinking it helps
> > > security, and end up with a broken system.
> >
> > This will never be a bright line, and I think choice is more important.
> > For example, Ubuntu builds with CRIU, but only a tiny set of tools
> > actually use it. (I've actually been considering adding a boot param to
> > disable CRIU features since they undermine some aspects of userspace
> > security.)
> >
> > Regardless, yes, if we can make this work with CRIU (which I thought
> > there seem to be consensus on), let's do it.
> >
> > > This seems like putting the onus on CRIU users to deal with a known-b=
roken
> > > thing? That seems really unreasonable? And people would just have to =
have
> > > the right userland code to work in the kernel with mseal?
> > >
> > > Yeah I oppose entirely this unless I'm missing something?
> >
> > Hm, well, the primary goal is for Chrome OS and Android to use this. If
> > there is honestly no path forward with CRIU, then hard Kconfig conflict
> > it is. I'd much rather have it available for anyone who wants it, just
> > like we do with lots of other features. Why force people who want this
> > and not CRIU to build their own kernels? We have all kinds of boot para=
ms
> > that if you set you get a broken system.
> >
> This patch is intended for ChromeOS and Android and is
> feature-complete from their perspective.
>
> To simplify v5, I propose removing kernel-cmd-line and avoiding the
> complexities of CRIU/UML and gVisor. The KCONFIG is disabled by
> default and will only apply to ARM and Intel architectures.
>
> Later when a generic distribution wants to enable this feature, we can
> work out a solution to handle those complexities.
>
> Is this a reasonable path to move forward ?
>
If a complete solution is desired, we can continue to discuss the
open/unresolved items.

This summarizes code logic requirements/comments.

1> Enable the feature per architecture (Lorenze)
Current state: Already in current patch (v4)

2> CONFIG_SEAL_SYSTEM_MAPPINGS
Current State: In v4, this depends on !CHECKPOINT_RESTORE. This
dependency is unhelpful for gVisor and UML (which don't depend on
CRIU) and should be removed.

(next step): remove !CHECKPOINT_RESTORE dependency.

3> Per process prctl (Andrei Vagin, Benjamin Berg)
Current state: Not in v4.  Andrei suggested using prctl for opt-out.
This shouldn't depend on CRIU/CAP_CHECKPOINT_RESTORE (since gVisor is
a different feature)

(next step): Add this opt-out prctl under the new KCONFIG:
CONFIG_SEAL_SYSTEM_MAPPING_WITH_PRCTL_OPTOUT

4> kernel cmd line:
Current state: This is in v4. Lorenze  commented that the new kernel
cmd line doesn't have effect on the 32 bit build, so users might think
it is enabled but not.

This is due to the fact that the 32 bit kernel doesn't support
mseal(), i.e. mseal.c is not even built under 32 bit.

Standard practice when processing kernel cmd lines with incorrect
input is to do nothing (no logs or crashes). Addressing this is
difficult unless mseal is supported for all architectures.

These are all the code logic related comments. Did I miss anything ?
Other non-code related comments (threat-model, tests, etc) will be added la=
ter.

To simplify the next version (if no agreement is reached), I can focus
on items 1 and 2. This would satisfy ChromeOS and Android, as well as
distributions and users who don't use CRIU/UML/gVisor (likely the
majority). Items 3 and 4 could be addressed later.

Comments, suggestions, and alternative approaches are welcome.

Thanks
-Jeff






> Thanks
> -Jeff
>
> > -Kees
> >
> > --
> > Kees Cook
