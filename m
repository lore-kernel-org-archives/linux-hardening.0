Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80721A8F6D;
	Tue, 18 Feb 2025 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920729; cv=none; b=tdLlnEUrsCr6PagQpELdU+/mmsRsBvgWx5ktVBbDQFDVAf4Rcb79orNxlGNDEWf2tCp0Bqldg+qlxrFielQ7HWJe72JRl6ycyuxs+AQYeEw0e4AUT/bIlr6THOdj6tPFNyOuO+Kpr2C1ydwzTa3B+QWNiR9xMFp9993FeFh+dng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920729; c=relaxed/simple;
	bh=cJZKYboTxb8eI3E86OVhHv0iNOUs21llNDOF1MXgUYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9rYK8rLd6MOXeZNt594LZfmmw8UEIoA9vSvnXgaPClhLzlwQqsaW5Hl57sXjJ4rJYyVCk0WJYc3SAYxI5w0nc9Kw8S16k33p9Xl7tzJKlXpXLNLeKPJkJa7PzgGV3HXtvUH+/RQs1V7IMVyTNziNQ4WHW28ujvvabn9Rc8bu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K55JzAyE; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K55JzAyE"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4bda3ea7076so214316137.0;
        Tue, 18 Feb 2025 15:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739920726; x=1740525526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJZKYboTxb8eI3E86OVhHv0iNOUs21llNDOF1MXgUYQ=;
        b=K55JzAyE2wIYgILOKknlyEnDIj371xveSIOCWq6cQCjN8KadZ7skLubXcZf2725Ec1
         L0MAb3SdW80/K65yENfxhZ24Ww/VIpYDLFjf44N41o/8A1kw68/kIWpbwJ3qXhmKt0M8
         W01IW4+5Ugkw3AvKAKNdR8qD3Ojh+B3q8/6qtx6+v6MifvnakuKa/kmx/tgJiKRZWKPL
         IjqRpA4PQweoBNzP3qFG6erKlrSPyZFiu4f89sa9la1b5gQ3NrdzLSEwEbhCQvCEYw8p
         0rk6U2MugXfkUkna1AoIwXEr7WzH7DznfwJ5se5y7HI4j7L3XMPZzaFK1EyhYaHbvs2F
         48YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739920726; x=1740525526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJZKYboTxb8eI3E86OVhHv0iNOUs21llNDOF1MXgUYQ=;
        b=O4URmECjmhomeVwplhHCLgA+yHuHjg3xNrKb7/fZSrW7BemkJRg9Ca+fpNgvbXlD6k
         poA5UOi5wdLne8e4CA7QttJi3tzrFazR0FHFZzTC/ZHFxsDYzKRe906gx9307u+2jlmq
         tlXxPBSPTtmyo+iAPWJNgCcWt94s23K0K+U5v4Q1CNDVlwumqOAOWF4BlZX39xezjguL
         EAFBQk8Milr5Xs+xoJQxtWGjhZ5ymcVyQjAxHft4JkV1rxdmvTIJl6o92fVGhFBy/P7s
         qo0PlIlvVW6uTYpHjZ94/pF/iOQd/rTDRYTM5eI3smgKClzAvhJiwPPQnfgoIPtaSMVF
         hNig==
X-Forwarded-Encrypted: i=1; AJvYcCUbGuDs060tDZnevNXxNN9QwT3F7r5929aSC3GTagUX6SBu9F/N1BN0GI+J92Kob+GHnXAkrC1J8yEbmnQkv5Y=@vger.kernel.org, AJvYcCXDjRkWXbKxRTEj5CMmt9SW8v44J+fDTRhtvOl56hyxcm7VUPP42AHz1ee8Omeulit9Uqiao6SLymRa1I2z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6t0nBZLm5JIrvFkr75pPBIcTPbyg9t4P+PSMWUE7p4IkPLRBU
	hwRmAWdogTLVU5fcYQfhGAPUdQLolTo69w73Vys4+qc7baS56Fq/yAQUf/1YnNpZV8MVd5w6SIj
	uKJUQNpDg60GDb9yPe8KXPMxgchM=
X-Gm-Gg: ASbGncvx1kHz6Bko42OOQuj/JMOG36pG8harfnjdP28cSimJt4bu7dOn04j6jrHTiqX
	f4H/iAp9xWg1fP52iTZimuDY1B8eaKv2BnK03H2wMRP/2evldL3Bud7w49saWt26UYten/P4w5A
	nkukl5DwDe1wnFZ+7NORX0tPicdSyY
X-Google-Smtp-Source: AGHT+IGKGQRQAl8RdXEgVYEV0wpJE87L/FaWCi6brr9B7QBb3fpm0Lts0CWlx0AMzHd2VMZ1ZcRSNSvzuIQRVBJawkc=
X-Received: by 2002:a05:6102:f10:b0:4b2:9e5d:baf with SMTP id
 ada2fe7eead31-4be84525188mr1413338137.11.1739920726529; Tue, 18 Feb 2025
 15:18:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com>
 <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local> <CAKbZUD3kaYEqQFU1TWfJWvtV02ESaMb0_ygadGgeAKo-b+GRcA@mail.gmail.com>
 <202502131240.A57C749@keescook>
In-Reply-To: <202502131240.A57C749@keescook>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Tue, 18 Feb 2025 23:18:34 +0000
X-Gm-Features: AWEUYZnpYHWvn6nqeVyLXVg13y8CRbOGKz08G_TnkGN6y5dwD6CgxjUxA5BE0y4
Message-ID: <CAKbZUD16kfO2OBxY2fMbnmnEinTeKbPpTOLVC=Pc+FbWN_kjcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, jeffxu@chromium.org, 
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
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:47=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Feb 13, 2025 at 07:59:48PM +0000, Pedro Falcato wrote:
> > On Wed, Feb 12, 2025 at 2:02=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > (sorry I really am struggling to reply to mail as lore still seems to=
 be
> > > broken).
> > >
> > > On Wed, Feb 12, 2025 at 12:37:50PM +0000, Pedro Falcato wrote:
> > > > On Wed, Feb 12, 2025 at 11:25=E2=80=AFAM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wro=
te:
> > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > >
> > > > > > The commit message in the first patch contains the full descrip=
tion of
> > > > > > this series.
> > > > >
> > > [...]
> > > >
> > > > FWIW, although it would (at the moment) be hard to pull off in the
> > > > libc, I still much prefer it to playing these weird games with CONF=
IG
> > > > options and kernel command line options and prctl and personality a=
nd
> > > > whatnot. It seems to me like we're trying to stick policy where it
> > > > doesn't belong.
> > >
> > > The problem is, as a security feature, you don't want to make it triv=
ially
> > > easy to disable.
> > >
> > > I mean we _need_ a config option to be able to strictly enforce only =
making
> > > the feature enable-able on architectures and configuration option
> > > combinations that work.
> > >
> > > But if there is userspace that will be broken, we really have to have=
 some
> > > way of avoiding the disconnect between somebody making policy decisio=
n at
> > > the kernel level and somebody trying to run something.
> > >
> > > Because I can easily envision somebody enabling this as a 'good secur=
ity
> > > feature' for a distro release or such, only for somebody else to late=
r try
> > > rr, CRIU, or whatever else and for it to just not work or fail subtly=
 and
> > > to have no idea why.
> >
> > Ok so I went looking around for the glibc patchset. It seems they're
> > moving away from tunables and there was a nice
> > GNU_PROPERTY_MEMORY_SEAL added to binutils.
> > So my proposal is to parse this property on the binfmt_elf.c side, and
> > mm would use this to know if we should seal these mappings. This seems
> > to tackle compatibility problems,
> > and glibc isn't sealing programs without this program header anyway. Th=
oughts?
>
> It seems to me that doing this ties it to the binary, rather than
> execution context, which may want to seal/not-seal, etc. I have a sense
> that it's be better as a secure bit, or prctl, or something like that. Th=
e
> properties seem to be better suited for "this binary _can_ do a thing"
> or "this binary _requires_ a thing", like the GNU_STACK bits, etc. But
> maybe there's more to this I'm not considering?

Doesn't this exactly kind of Just Work though? "This binary can
do/tolerate sealing". I would blindly guess that we don't have very
opinionated shared libraries that do this kind of shenanigans
unilaterally, so that's probably not something we really need to worry
about (though I admittedly need to read through the glibc patchset,
and nail down what they're thinking about doing with linking
mseal-ready and mseal-non-ready ELF execs/shared objects together).
The problem with something like prctl is that we either indirectly
provide some kind of limited form of munseal, or we require some sort
of handover (like personality(2) + execve(2)), which both sound like a
huge PITA and still don't solve any of our backwards compat issues...
all binaries would need to be patched with this
prctl/personality()/whatever call, and old ones wouldn't work.

The semantics behind GNU_PROPERTY_MEMORY_SEAL are unclear to me (maybe
the toolchain folks could shed some light?), but it sounds like it'd
fit perfectly.
I suspect we probably want to parse this on the kernel's side anyway
(to seal the main program/interp's segments)[1], then extending them
to the kernel system mappings should be somewhat trivial...
I don't think we'll ever get a program that can't cope with sealing
the system mappings but can cope with sealing itself (and if we do, we
just won't seal the entire thing and that's _okay_).

Deploying mseal-ready programs could then be done in a phased way by
distros. e.g chromeOS and android could simply enable the
corresponding linker option in LDFLAGS and let it rip. Other more
mainstream distros could obviously take a little longer or test/deploy
this on all programs not named gVisor and/or after CRIU is okay with
all of this. We then might not need a user-configurable CONFIG_ (only
an arch HAS_SYSTEM_MAPPINGS_MSEAL or whatever), nor a sysctl, and
everyone is happy.

I glanced through libc-alpha again and it seems like the glibc folks
also seem to have reached the same idea, but I'd love to hear from
Adhemerval.

Am I missing anything?


[1] we should probably nail this responsibility handover down before
glibc msealing (or bionic) makes it to a release. It'd probably be a
little nicer if we could mseal these segments from the kernel instead
of forcing the libc to take care of this, now that we have this
property.

--=20
Pedro
