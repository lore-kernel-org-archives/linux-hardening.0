Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C7D19F48D
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137301; cv=none; b=cdRJ/f4Ji40uFB0N+f39vv+wOCi7S+udmcE6KmpCrClvYJcA2Bu+CqjSSNLC09EYpbu5LytelfsufS4zyaHSVNDmvf+CiKizzXr1pufLwUZ9NpgvuKR8dyk+sHuno9GL608ihXvUcKCp8edFUEdLpoFDlStzBmwnvfvYZgdZG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137301; c=relaxed/simple;
	bh=3Ulu5iRa187/erhsEnW7U8t8I1IWk8SCV0Rdb9byrzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJlZ2A0avhUAiBnUK1ooUPpasvCT1q5/bQRbZLlqX+s/88pL27HAMDq2VLJv4ChXch2qQVf0Eak20/GR/RaaZMzbOxYx2JjOKcrdLvnRNBuHUKpGKojkePAau5xujP1braK6C9I5eB07FkbYZkzOGh5SIdqTlkg+SOOi6c3wnFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SEXR8sKX; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SEXR8sKX"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29fb6df3781so224758fac.1
        for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 10:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737137299; x=1737742099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+wrQ79XQ4ca9l/d+wViEvNToUhszDfun5nccti3Phg=;
        b=SEXR8sKXzssbTUsA2aY3sV7Ak+Lsl7WXCz46kocrhzkpp7YHo4bVKqkJCxQjIWiMSb
         ArAYm/X5lNPqDXqDO4B7q8JKgVMljTzRDZpULkEwp/HTkNB8MTqyjI9OQRvygWvaHv02
         +ovPnMfxeY2MOl4AbQKHz9VOA3pieCsDRiG4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737137299; x=1737742099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+wrQ79XQ4ca9l/d+wViEvNToUhszDfun5nccti3Phg=;
        b=CpAiBX2nRT2zfTbYULgHeXP0yD+QG1EKgztIWXCgH9sFn4xbjcgM6S1aK9WWZfyzOf
         P4nJR1BWzlzJf1rKU2eQ/8fR4BUHEavjeVtNUSNgQWZ6qb+CDHFtxHy4V0oqte4Fsnco
         Us+HAc2j8wlK84pg/6z959a90pkqUGQzhubTVnKb2V0H6ZRQaBeJO8N3o3DUYcSRa2wB
         MAeflQ5Lc3emaRAbtZWigcwmo15+pRVyakOdFxag2TlPrFtct8LgCK+RxudRdxR418ui
         gQevXJtg2d/cA2u/U2LURLiPA4mvcL9sBlTyC6GXRdJFjNyFv1AZNfQpDJ4BLtyJ9g0f
         SKhw==
X-Forwarded-Encrypted: i=1; AJvYcCVViTODooz0aFP6ZkS6jPHW8PxgqGVd3hRfzQ6l2lU22l8W9CaJO2O1crGfvYgnSROLEcwvk3troRLM12dT4XM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZFwUrBnKRBOGWKVNlpdUSsEfEg4DV2R8zgyXZfYEVD0c7+wl
	STgAKy6nx4RY6y7b4MM0Vebnh7gRohDBLRPD4wSSzoSvDr31PQq0bCCQrgKYYh+FpqtKTODyokZ
	M5q4Zax8qNGC0QCUGVXcJqMh+eywdWO7NOl9s
X-Gm-Gg: ASbGnctTkVzrpYJiqZU8qMrufhtuiWs9tQp0IAN7BBAfo8RNvwtpXlFaASxrGwTP7VW
	DfZmR5/oO9MIfJms24SzwDVRcRJZpKUXTrYi6x5HCX/SfwmEYkbVU+/vWbnaee79vEf4Nrnc=
X-Google-Smtp-Source: AGHT+IFJ8fOBsLikiTC0W7GtLYaUpRBbqTiElAurGL67ZkxvsLPOiPeoJiRmQO4h1oncRiRsa3HsPioiMyw5bUnyoS8=
X-Received: by 2002:a05:6870:71d3:b0:29e:43da:f5da with SMTP id
 586e51a60fabf-2b1c0c55585mr889542fac.9.1737137299036; Fri, 17 Jan 2025
 10:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook> <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook> <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local> <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
In-Reply-To: <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 17 Jan 2025 10:08:07 -0800
X-Gm-Features: AbW1kvbcBFeiMkF_PxC9uDRDzx1jxsdsTHth5wMq9Ux1KdCyDdEQMsSqbOrSvzQ
Message-ID: <CABi2SkXUV2LKpC5m7KOG2Ea==1BufA26cG89sVXutVT+ZTwR+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com, 
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

On Thu, Jan 16, 2025 at 7:49=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Jan 15, 2025 at 12:20:59PM -0800, Jeff Xu wrote:
> > Hi Lorenzo
> >
> > On Wed, Jan 15, 2025 at 11:46=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > Jeff,
> > >
> > > My name is Lorenzo, not Lorenze.
> > >
> > I apologize.
>
> No worries, sorry I realise it was probably a typo! But just in case you
> didn't realise :P
>
> >
> > > I've made it abundantly clear that this (NACKed) series cannot allow =
the
> > > kernel to be in a broken state even if a user sets flags to do so.
> > >
> > > This is because users might lack context to make this decision and
> > > incorrectly do so, and now we ship a known-broken kernel.
> > >
> > > You are now suggesting disabling the !CRIU requirement. Which violate=
s my
> > > _requirements_ (not optional features).
> > >
> > Sure, I can add CRIU back.
> >
> > Are you fine with UML and gViso not working under this CONFIG ?
> > UML/gViso doesn't use any KCONFIG like CRIU does.
>
> Yeah this is a concern, wouldn't we be able to catch UML with a flag?
>
> Apologies my fault for maybe not being totally up to date with this, but =
what
> exactly was the gViso (is it gVisor actually?)
>
It is a typo, should be gVisor.

> >
> > > You seem to be saying you're pushing an internal feature on upstream =
and
> > > only care about internal use cases, this is not how upstream works, a=
s
> > > Matthew alludes to.
> > >
> > > I have told you that my requirements are:
> > >
> > > 1. You cannot allow a user to set config or boot options to have a
> > >    broken kernel configuration.
> > >
> > Can you clarify on the definition of "broken kernel configuration":
>
> Anything that'd unexpected break userland in a way that would be entirely
> unexpected.
>
> Especially so if there is a real disconnect between the person who is
> enabling the feature and the program.
>
> For instance if a distro wants to be big on security, is (as is entirely
> reasonable) concerned about an unsealed VDSO/VVAR/etc. being exploited, s=
o
> turns on the flag, but _doesn't realise_ or doesn't communicate (such a b=
ig
> problem and difficult actually for many distros/vendors) that this will
> break certain programs - and then users do a kernel update, and *bang*
> their whole system is broken.
>
> It's really this kind of scenario I'm worried about.
>
> This is the crux of it really.
>
Ok, thank you for clarifying.

> >
> > Do you consider "setting mseal kernel cmd line under 32 bit build" as b=
roken ?
> > If so, this problem is not solvable and I might just not try to solve
> > it for the next version.
>
> Yeah, I really don't like the kernel cmd line thing, because of this risk
> of disconnect - your justification for it is prima facie reasonable - the
> distro didn't want to enable the thing by default but you want more
> security - but then we have this issue with the possible disconnect betwe=
en
> 'hey here is security feature X' vs. 'security feature X breaks Y, Z +
> alpha'.
>
Ok, the kernel cmd line won't be in the next version.

The kernel cmd line feature exists as a supplementary to KCONFIG, and
has its own user cases. However, this discussion can happen later when
adding a kernel cmd line for this feature.

> >
> > If you just refer to a need to detect CRIU, in KCONFIG or/and kernel
> > cmd line,  this is solvable.
> >
> > > 2. You must provide evidence that the arches you claim work with this=
,
> > >    actually do.
> > >
> > Sure
>
> See my reply to Kees as to what this comprises, sorry if I was not clear
> previously.
>
>
> >
> > > You seem to have eliminated that from your summary as if the very thi=
ng
> > > that makes this series NACKed were not pertinent.
> > >
> > In my last email, I tried to cover all code-logic related comments,
> > which is blocking me.
> > I also mentioned I will address non-code related comments
> > (threat-model/test etc),  later.
>
> Ack.
>
> I felt that you hadn't hit on my fundamental objections and this was in
> effect - a final analysis as to how you would be moving forward with v5 -
> but apologies if you did intend to separately discuss them.
>
> >
> > > if you do not address these correctly, I will simply have to reject y=
our v5
> > > too and it'll waste everybody's time. I _genuinely_ don't want to hav=
e to
> > > do this.
> > >
> > > Any solution MUST fulfil these requirements. I also want to see v5 as=
 an
> > > RFC honestly at this stage, since it seems we are VERY MUCH in a disc=
ussion
> > > phase rather than a patch phase at this time.
> > >
> > Sure.
>
> To be clear - if the series is viable, I want to see it merged. And to
> further clarify - a simpler, smaller version of this that explicitly
> disallows breakage in config options suffices (though we must clarify the
> gVisor + UML things).
>
> If I just wanted to reject this outright, I'd tell you :) (I don't).
>
> I just need to feel vaguely less anxious about breaking things! :)
>
> >
> > > I really want to help you improve mseal and get things upstream, but =
I
> > > can't ignore my duty to ensure that the kernel remains stable and we =
don't
> > > hand kernel users (overly huge) footguns. I hate to be negative, but =
this
> > > is why I am pushing back so much here.
> > >
> > Thanks. You can help me by answering my questions, and clarify your
> > requirements. I appreciate your time to make this feature useful.
>
> Sure, hopefully I have done so, do follow up if anything was unclear.
>
> >
> > Please take note that the security feature often takes away
> > capabilities.  Sometimes it is impossible to meet security, usability
> > or performance goals simultaneously. I'm trying my best to get all
> > aspected satisfied.
>
> Ack, and I realise it's often a difficult trade-off. I just worry about
> compounding complexity in consequences of kernel configuration vs. userla=
nd
> stuff + the disconnect between the two.
>
Understood, thanks for explaining. I value feedback to make the
feature useful/robust.

-Jeff


> >
> > -Jeff
> >
> > > Thanks!
>
> Cheers, Lorenzo
