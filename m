Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48A1A9B2C
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737144926; cv=none; b=TZiZsz7vvgTV3ZJaoZHUWzSG2eiY8stuVTSTQPqv6t8X80tuMzvnyF1J/YypeJ4gxhSZ6iL6i+PzUbpRTk4tYneIFq9TH3SwET09rFmZXGiysbc6z/WdFMmupyo3zd34NWey5hSMrH/uTGHxkeyCxznjpalUw3lvpRsxZ6NuQjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737144926; c=relaxed/simple;
	bh=Akx68EPp3QxPFV9VbYQBLGaRECiVB/V3fJMJGx83hVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JM0qbg8uqg9Mpm39lv2Oh7JLWaPCYWggo+/mL9a5GJcXdnW66qfXTQo5RSYjHQ8P0lb7TWKwQ2skNsG4aDE6Aq1XvxuVisNwUFLoNZJOR84WFy/ZLSirP4IUWR/NOYzHTKZ9qpbfvBlX+g3qnmoe5XQZY0RqStKWW0OjeVd19oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XrmN/caM; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XrmN/caM"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f2e32b44dfso151880eaf.2
        for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 12:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737144924; x=1737749724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp9zLJvqXDsmT/YVqgMgXNRqVduI1VilfID2VFMHy6U=;
        b=XrmN/caMAsCZwr480y2EyoefPb2N9mYFEmoGP6NtBCx1u5SPoyRjQJWYSXzhpzl/lt
         Fu5gYiM9Li5tz++KOGn86KOeuCpF08PqwTZw+RgffFyUVX9ys7cOQ+F9cyJSHaJZXSZL
         9I5dkOcvlNH/ZGart9cEFu+bJdFXmn0ZOMzdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737144924; x=1737749724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp9zLJvqXDsmT/YVqgMgXNRqVduI1VilfID2VFMHy6U=;
        b=pXHLEvIDKnuseS8WLLnl35kGHXdNtVPPo6VOfWHfle8a2Fjp7zdk57mUsv8n2MQ8VW
         2SlAdUmvL1FuAH9HH/pYFIO1jDWLrZoHThDylMw0l0W4TaGDhn/+1wFPeU4bBmKt8vCo
         7Z4FzSkdlX6+9DJYIdu3vkiqQ9/0EhJW5wQAfp/2osnf3rRu2OcPBimt+z3Hr5yMY8iP
         P/dFtVTzu7pEey5Zp1DgPiWpxgQVTsNtQ2fKqXY1aT7OAhFg/QIbyBl22+GXBGd5bFAC
         Yz6yCVW9jrCOUoZ55CmXKvuezckRSgL9zRtJn2ispx/W68bAheYXZs9I5W5Si0O5GkHf
         tPnA==
X-Forwarded-Encrypted: i=1; AJvYcCV6v1cpS4R9NxwK3gWsjHqnbLpSOmdkFmx09lMqFhkP6KrIGmzZpLDMQDFml6lvSKyVQS27/WhVZJRa6vOpmiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/qEjjpFosa8uDa+uPitYbIGHdJ5jvVMWZkHwI4APNh1dAexV
	mzKmyvZcR5JLWCwzFtK8Eo3l+uKv5mANyO44ePxd1hldV7E3V+M9RVQhT0JZn3FrsbF5NZCjjBV
	5j3KRK7+plZfZetVx313VmE4C9Vz3mGdgaxq0
X-Gm-Gg: ASbGncsQfVYhg2y7/Bh+JM/vznD9JLXuG1SJY2EYkr33yUYicCsBghHXXb4uk0Sn3Wb
	ykzfZCEx5JKQfMV/sTx+AFrcSMwTDUkJJTQykVMF+219TFY7PmbKaqeYfLzRBORgkrkNoCn0=
X-Google-Smtp-Source: AGHT+IHEiGZ03eQhEBIhf5BLtIbqWWBcvn9z4gLXJ+XfmzEQCNzjg8hVb4Vq5Q2pOuijlkAJjAklJOQqoxYk9yK9yHo=
X-Received: by 2002:a05:6830:61cc:b0:71e:1849:5ed9 with SMTP id
 46e09a7af769-7249da5eb30mr838648a34.2.1737144924050; Fri, 17 Jan 2025
 12:15:24 -0800 (PST)
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
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local> <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com> <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
In-Reply-To: <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 17 Jan 2025 12:15:12 -0800
X-Gm-Features: AbW1kvbfX_Ez_y9xI_Jf2U6tPOlD28z0La4l01YzXYWsN_RQRxp1A3CG0IIWSyM
Message-ID: <CABi2SkUwnQMqPGuQA855uifCr0AKBYN6j0i-k9g+WzRgsf4jww@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: enh <enh@google.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, Benjamin Berg <benjamin@sipsolutions.net>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:35=E2=80=AFAM enh <enh@google.com> wrote:
>
> On Fri, Jan 17, 2025 at 1:20=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wro=
te:
> >
> > On Thu, Jan 16, 2025 at 9:18=E2=80=AFAM Pedro Falcato <pedro.falcato@gm=
ail.com> wrote:
> > >
> > > On Thu, Jan 16, 2025 at 5:02=E2=80=AFPM Benjamin Berg <benjamin@sipso=
lutions.net> wrote:
> > > >
> > > > Hi Lorenzo,
> > > >
> > > > On Thu, 2025-01-16 at 15:48 +0000, Lorenzo Stoakes wrote:
> > > > > On Wed, Jan 15, 2025 at 12:20:59PM -0800, Jeff Xu wrote:
> > > > > > On Wed, Jan 15, 2025 at 11:46=E2=80=AFAM Lorenzo Stoakes
> > > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > [SNIP]
> > > > > >
> > > > > > > I've made it abundantly clear that this (NACKed) series canno=
t allow the
> > > > > > > kernel to be in a broken state even if a user sets flags to d=
o so.
> > > > > > >
> > > > > > > This is because users might lack context to make this decisio=
n and
> > > > > > > incorrectly do so, and now we ship a known-broken kernel.
> > > > > > >
> > > > > > > You are now suggesting disabling the !CRIU requirement. Which=
 violates my
> > > > > > > _requirements_ (not optional features).
> > > > > > >
> > > > > > Sure, I can add CRIU back.
> > > > > >
> > > > > > Are you fine with UML and gViso not working under this CONFIG ?
> > > > > > UML/gViso doesn't use any KCONFIG like CRIU does.
> > > > >
> > > > > Yeah this is a concern, wouldn't we be able to catch UML with a f=
lag?
> > > > >
> > > > > Apologies my fault for maybe not being totally up to date with th=
is, but what
> > > > > exactly was the gViso (is it gVisor actually?)
> > > >
> > > > UML is a separate architecture. It is a Linux kernel running as a
> > > > userspace application on top of an unmodified host kernel.
> > > >
> > > > So really, UML is a mostly weird userspace program for the purpose =
of
> > > > this discussion. And a pretty buggy one too--it got broken by rseq
> > > > already.
> > > >
> > > > What UML now does is:
> > > >  * Execute a tiny static binary
> > > >  * map special "stub" code/data pages at the topmost userspace addr=
ess
> > > >    (replacing its stack)
> > > >  * continue execution inside the "stub" pages
> > > >  * unmap everything below the "stub" pages
> > > >  * use the unmap'ed area for userspace application mappings
> > > >
> > > > I believe that the "unmap everything" step will fail with this feat=
ure.
> > > >
> > > >
> > > > Now, I am sure one can come up with solutions, e.g.:
> > > >    1. Simply print an explanation if the unmap() fails
> > > >    2. Find an address that is guaranteed to be below the VDSO and u=
se a
> > > >       smaller address space for the UML userspace.
> > > >    3. Somehow tell the host kernel to not install the VDSO mappings
> > > >    4. Add the host VDSO pages as a sealed VMA within UML to guard t=
hem
> > > >
> > > > UML is a bit of a niche and I am not sure it is worth worrying abou=
t it
> > > > too much.
> > >
> > > I've been absent from this patch series in general, but this gave me
> > > an idea: what if we let userspace seal these mappings itself? Since
> > > glibc is already sealing things, it might as well seal these?
> > > And then systems that _do_ care about this would set the glibc tunabl=
e
> > > and deal with the breakage.
> > >
> > > Is there something seriously wrong with this approach? Besides maybe
> > > not having a super easy way to discover these mappings atm, I feel
> > > like it would solve all of the policy issues people have been talking
> > > about in these threads.
> > >
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
That will be an interesting mm feature, i.e. query the vma information
given an address.  ASLR might be a thing to consider, there are
sandbox solutions to block the read on /proc/pid/maps, such as
landlock.

The glibc's dynamic linker gets the mapping size info from the elf
header of the .so, during execve() call. In a previous attempt of
glibc sealing the vdso, the size of vdso.so (in PT_LOAD) was found to
be inaccurate. To make the thing more difficult, the vvar size might
not be present, iiuc.

> ...but in this special case, is the vdso/vvar size ever anything other
> than "one page" in practice?
>
yes. on x86, the vdso size can be two pages long.

> > Additionally, uprobe mapping can't be sealed by the dynamic linker,
> > dynamic linker can only apply sealing during execve() and dlopen(),
> > uprobe mapping isn't created during those two calls.
> >
> > -Jeff
> >
> >
> > > --
> > > Pedro
