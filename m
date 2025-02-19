Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06E286284
	for <linux-hardening@vger.kernel.org>; Wed, 19 Feb 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985476; cv=none; b=Sjs+mknYWIDTL319Xo2B5n0I+VgfALsznr+KVc8jy8ciaQtN31RQ/ZBiExGfUEE4d6Mv9AvdoBWEftAmGHrzkz6g4M+odxnoRD46Su1VA1XsFYTwDnGnczr/Xzbs4sYzdeYd0b6RFi5yHAq8mCRP5GVR3u6aqQopmLPGUFgBJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985476; c=relaxed/simple;
	bh=OVEokc++S9KH6ryzdoMossQu0Y+z5+h9xa01Nfet8/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYM9xOUribA2AlWTbSwBkYiMiAE4lzajY/52apCx5kGopb00zCGGkYtdEaCnL2Wf2XgudnFxk2KxCNCAu9xzquqXRWnKamf74ksp6Qf/6WqAcrrIvRKqFqtmNH35D8jzYFCE9mV+abSprI40FuMPEbh+FDMMZAr3rtKl4T9qu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xbFfkkIH; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xbFfkkIH"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7272f1de42fso1557550a34.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Feb 2025 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739985474; x=1740590274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVEokc++S9KH6ryzdoMossQu0Y+z5+h9xa01Nfet8/g=;
        b=xbFfkkIH/bW1agzpu/VTz5cIVzF1fboMal96aSps5UaGXgRX3/vUdljfQN0+y9+eqP
         MSrL4JllOwi5G02dJAGpLf4/Pmd9sfKtDFeKeG+xoV9w1zbe3Y5lmBbPqSOSQtq+58Ch
         RJMcVVZOC8Sm+PI1oEIQqGObq2Rj8Tb9aCsGw4h52W453Ok4l0DwpTGUmEihT3e6vOFQ
         DUeEiMdP8S1xGa1drjQ8cL+LmG81UML5hjma2diieAI694q6UaLaed006JaxtyxubOUB
         YyFmZfI8e4dNlBFKo4ENFed7qdafue9UhprVtQSPEh8zgX3UmTA8kSoTwUAcxRnt5UNe
         6YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739985474; x=1740590274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVEokc++S9KH6ryzdoMossQu0Y+z5+h9xa01Nfet8/g=;
        b=DfwVp6ApSLYdQLS1YrYvF80PWWbeME3Zq8ZbIYYhCuDlSUI87/WJhWH+isb9fBl9ME
         UqNUoEjMx6v4KEwEYOpwaobkBx+TbpvKlxuyQTYLJvz6VUBQjeMWRk+c5TK1x5yLP1y/
         oU0cMPFXs2EDRXIxyoP8CNecYiAEYnHBOdyvodbUIaXALayYw2O17WWk350Z3bmv/mTq
         Irs9nBhG/TKpkNtGozpkRmFHmJs+zyMft473FimlbNr6PuH+ETw/HdifqMZ3Bddfp4JH
         8coUKpzy/SsC3w712Ph+geS92Br/981Q+EBbDLBjl15Rliqls8r4WOtSbb7oU/OwCf67
         AmEw==
X-Forwarded-Encrypted: i=1; AJvYcCXy8xjeZZ7GjUYWl/vhL8fN/vi8WZhtX4zKXZ8YdR8tqocrxsc95l54lTfDOx5Ms58g6K4jUwoNXy/mIo22tF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJTynURkS0S0alOTWrN3bppAhwQP/Wpc7fAJDKRA0S/cvdY51
	/WwguIMWA/1B9gp3gBMA7gW63CbDAuT9yyM7vcgg0fZSqwR5huPZZNdR0lyE8FjqdSLL6sdLfzz
	wUx2WR4yETW+cVlCpKT6XcppU9q5jjnIUY6Q6
X-Gm-Gg: ASbGnctT3CgJOI5XKIZI6PEv4nAcpjjmZV2p3xSKycoyovFYpuuH6e2FgNPHZ/noVGN
	ciDzUqGB7CEh2MZOhcIzxc5vBt8jMHS2OFW9gBUj1WGADWgN4i04x4NRuozumrUPPSsnyzw==
X-Google-Smtp-Source: AGHT+IFtTKY1jDjL5dUAYxyA8Qit+rF+HdRs0rA/paAkjRr1rXODcHay0xhy+IxufTt79brO1JJ/4wMTQIJGiFmJfCk=
X-Received: by 2002:a05:6830:388f:b0:727:1041:4202 with SMTP id
 46e09a7af769-7273779be8emr4220238a34.21.1739985473786; Wed, 19 Feb 2025
 09:17:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com>
 <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local> <CAKbZUD3kaYEqQFU1TWfJWvtV02ESaMb0_ygadGgeAKo-b+GRcA@mail.gmail.com>
 <202502131240.A57C749@keescook> <CAKbZUD16kfO2OBxY2fMbnmnEinTeKbPpTOLVC=Pc+FbWN_kjcQ@mail.gmail.com>
In-Reply-To: <CAKbZUD16kfO2OBxY2fMbnmnEinTeKbPpTOLVC=Pc+FbWN_kjcQ@mail.gmail.com>
From: enh <enh@google.com>
Date: Wed, 19 Feb 2025 12:17:42 -0500
X-Gm-Features: AWEUYZkrJhHGOE4gkmIH4jm_-jQkhQ0BXH4tsu9GjGg65iZ6RBKYUV0BMKZMxwM
Message-ID: <CAJgzZopodgaJqUmu_DPjUM6GnL5ZOrjn219wsHNv0Em+iyAgvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, jeffxu@chromium.org, 
	akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 6:18=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Feb 13, 2025 at 8:47=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
> >
> > On Thu, Feb 13, 2025 at 07:59:48PM +0000, Pedro Falcato wrote:
> > > On Wed, Feb 12, 2025 at 2:02=E2=80=AFPM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > (sorry I really am struggling to reply to mail as lore still seems =
to be
> > > > broken).
> > > >
> > > > On Wed, Feb 12, 2025 at 12:37:50PM +0000, Pedro Falcato wrote:
> > > > > On Wed, Feb 12, 2025 at 11:25=E2=80=AFAM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org w=
rote:
> > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > >
> > > > > > > The commit message in the first patch contains the full descr=
iption of
> > > > > > > this series.
> > > > > >
> > > > [...]
> > > > >
> > > > > FWIW, although it would (at the moment) be hard to pull off in th=
e
> > > > > libc, I still much prefer it to playing these weird games with CO=
NFIG
> > > > > options and kernel command line options and prctl and personality=
 and
> > > > > whatnot. It seems to me like we're trying to stick policy where i=
t
> > > > > doesn't belong.
> > > >
> > > > The problem is, as a security feature, you don't want to make it tr=
ivially
> > > > easy to disable.
> > > >
> > > > I mean we _need_ a config option to be able to strictly enforce onl=
y making
> > > > the feature enable-able on architectures and configuration option
> > > > combinations that work.
> > > >
> > > > But if there is userspace that will be broken, we really have to ha=
ve some
> > > > way of avoiding the disconnect between somebody making policy decis=
ion at
> > > > the kernel level and somebody trying to run something.
> > > >
> > > > Because I can easily envision somebody enabling this as a 'good sec=
urity
> > > > feature' for a distro release or such, only for somebody else to la=
ter try
> > > > rr, CRIU, or whatever else and for it to just not work or fail subt=
ly and
> > > > to have no idea why.
> > >
> > > Ok so I went looking around for the glibc patchset. It seems they're
> > > moving away from tunables and there was a nice
> > > GNU_PROPERTY_MEMORY_SEAL added to binutils.
> > > So my proposal is to parse this property on the binfmt_elf.c side, an=
d
> > > mm would use this to know if we should seal these mappings. This seem=
s
> > > to tackle compatibility problems,
> > > and glibc isn't sealing programs without this program header anyway. =
Thoughts?
> >
> > It seems to me that doing this ties it to the binary, rather than
> > execution context, which may want to seal/not-seal, etc. I have a sense
> > that it's be better as a secure bit, or prctl, or something like that. =
The
> > properties seem to be better suited for "this binary _can_ do a thing"
> > or "this binary _requires_ a thing", like the GNU_STACK bits, etc. But
> > maybe there's more to this I'm not considering?
>
> Doesn't this exactly kind of Just Work though? "This binary can
> do/tolerate sealing". I would blindly guess that we don't have very
> opinionated shared libraries that do this kind of shenanigans
> unilaterally, so that's probably not something we really need to worry
> about (though I admittedly need to read through the glibc patchset,
> and nail down what they're thinking about doing with linking
> mseal-ready and mseal-non-ready ELF execs/shared objects together).
> The problem with something like prctl is that we either indirectly
> provide some kind of limited form of munseal, or we require some sort
> of handover (like personality(2) + execve(2)), which both sound like a
> huge PITA and still don't solve any of our backwards compat issues...
> all binaries would need to be patched with this
> prctl/personality()/whatever call, and old ones wouldn't work.
>
> The semantics behind GNU_PROPERTY_MEMORY_SEAL are unclear to me (maybe
> the toolchain folks could shed some light?), but it sounds like it'd
> fit perfectly.
> I suspect we probably want to parse this on the kernel's side anyway
> (to seal the main program/interp's segments)[1], then extending them
> to the kernel system mappings should be somewhat trivial...
> I don't think we'll ever get a program that can't cope with sealing
> the system mappings but can cope with sealing itself (and if we do, we
> just won't seal the entire thing and that's _okay_).
>
> Deploying mseal-ready programs could then be done in a phased way by
> distros. e.g chromeOS and android could simply enable the
> corresponding linker option in LDFLAGS and let it rip. Other more
> mainstream distros could obviously take a little longer or test/deploy
> this on all programs not named gVisor and/or after CRIU is okay with
> all of this. We then might not need a user-configurable CONFIG_ (only
> an arch HAS_SYSTEM_MAPPINGS_MSEAL or whatever), nor a sysctl, and
> everyone is happy.
>
> I glanced through libc-alpha again and it seems like the glibc folks
> also seem to have reached the same idea, but I'd love to hear from
> Adhemerval.
>
> Am I missing anything?

Android's a bit interesting because there isn't really a "binary" in
the usual sense. an Android app is basically a shared library of JNI
code dlopen()ed into a clone() of an already-initialized Java runtime
(the "zygote").

that said, i'm not expecting sealing the vdso to be problematic (even
if i'm not sure how useful it is to do so, being unaware of any
exploit that's ever used this?).

for me the tricky part is when it's used for regular user shared
libraries which seems the most convincing use case to me, albeit
mainly for app compat reasons ["stopping apps from poking at
implementation details they shouldn't, which later causes breakage if
the implementation detail changes"]. the irony being that it'll
_cause_ app compat problems by breaking all such things all at once.
so that'll be "fun" for someone to try to roll out!

it also breaks dlclose() (unless your dlopen() was with RTLD_NODELETE,
which is not the default on Android either). that's fine for OS
libraries that have already been loaded by the zygote, but hard to
make a default. that said, i do expect games and banking apps to be
interested to try this when they hear about it.

anyway, in general i think an ELF property per-library sounds
reasonable, matching what we have for arm64 BTI. i have no strong
opinion on the system mappings and what if anything executables should
do, for the reasons given above, but the elf property sounds
reasonable.

> [1] we should probably nail this responsibility handover down before
> glibc msealing (or bionic) makes it to a release. It'd probably be a
> little nicer if we could mseal these segments from the kernel instead
> of forcing the libc to take care of this, now that we have this
> property.
>
> --
> Pedro
