Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF51A264A
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142532; cv=none; b=BzFzAEH071lCGJMcNuCpCjaqHDWtZ0mezmVGF7IDdzdrcrDiMxHZNIigtIjimRMZerobTOwonXGIK3bkf189P/8QdWhq2dfPCx1vjkuka1wBKykhuDx338Bq+H0RqxthofPeuSjeZCQVtVG5LEaIc4ost32/EFjHp9gDjjd+aJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142532; c=relaxed/simple;
	bh=xxSSWaLoPAy3N8uKIuLFr0NseHeAPlAOevUG1Hs7j28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5wSjPhDbBaZjZhIbvZ1GqJ2zsNwmlLJdRMI1rLcUlZqfTXkryYta5SPND6hbsLA3gefSNMLn2bZD+NeLUy6pnD4z2sNSPgErthMNlCJzA4HgN6wQQ+z/XoEjPL292sCAYBHEqhA6Uy4wfRifx8IleUpw68v5d1c2Qd89+hKaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHVelLwc; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHVelLwc"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so26112796d6.3
        for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 11:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737142530; x=1737747330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0NSKWvLWFeR1xeLGL0GyYR3i1t5ClvvGlKBcqjteoM=;
        b=LHVelLwc34+Asg0WhpPD1TgSTV32SDbIxH/ckkxVg+pX7r+/XyOb22y7KVVjsUg0PZ
         6dWlZsNjO1Q9GQA83T10VQkEwL4iF2S/Sln7w7kl2Wnjap05RCYdKvR92vGNEK32PqvO
         agygiqPbcWgG8zBe4hXnnAFCY68iRhkH1mSTqot6O0mqtT/JjQnCiHpQo//JVW6CQzoa
         V0BWutsmQnKTL5Ih+lJO19Cu9/c9DMAORGlqw0jRc+qPqjxghJY0QI3vIqRKxXW3j4Gs
         eXML/wkA9X4lsEie8OxekYkFBmcaobVDvuxXVJe4HH7tIMp4/t55T4v5+BeCg8jVcH8x
         efPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737142530; x=1737747330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0NSKWvLWFeR1xeLGL0GyYR3i1t5ClvvGlKBcqjteoM=;
        b=HiDT0qWWKs5SqtbbLjrWN+VTB3hMUaRON5g9YK6aD45QEdZ5/jvSHWE7Qm9g8yvc+h
         hrBpTZmbzZm7/i55OI3YRpC9LvYCGW5intDr2nZf480JUmaXPD8z/n+4OpT01i0agGJ2
         Sb1Lqk5YhTPNIZgLn09YGm+Hkpy1mVcd886+npa0BPeo1MDiGd5p1cI/AvuHr7dneLeu
         hUr7Zwpo8QjbEIx0oAiMF1Qotukr+qCL5j1xcLggqtIo4TZ6SBwu6wJlQ//qwSgWaplX
         LyuBupUVs/Zk8/l9elfEg2vq5Ynd9GkO/Q/XsNsID9Z/twSmOLG64YFkvvYwM04XaDfS
         aYMg==
X-Forwarded-Encrypted: i=1; AJvYcCVdNZvntCPkh3Yup85pK96iaodA7P5dp8RNi8/w7fiFZIVjKb4FV2+WGgBuqgLVc1Kj2fj8hDT7OwVAJjz/bEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwGfG7YCzxkdJIXN0aID/vQ4EqvCrmRcf6vhrSMa54k5/Brt+b
	V6NWLjZ+i8kWdusvPHwYpESCSqXy02EUiN2sV+CQkn95uboGHEL79D0BWlQn3yL/pQBsnEG8oSk
	rRwl/RnmZ1c60U8xiop09cgHuJuvjr5snjzyj
X-Gm-Gg: ASbGnctHMxPK2CPbjXNMXURH5efjk0+OcSDWEHMz1uK0zh7iVcCNvtdqpoxYLKOEq+/
	8/3Uq8rPlVMqConpHy9BliSIyhCHzYSV2A4s=
X-Google-Smtp-Source: AGHT+IEz+H9K4qcswyKJVr8f/V4dLAGWaZ2IEdJ98YGU1N84YtyCwzuFA8b/FUIFw2oIjZh1saRbCEf/T67kF78Sq4Q=
X-Received: by 2002:ad4:5de1:0:b0:6d8:7e5d:ef1c with SMTP id
 6a1803df08f44-6e1b2180fcbmr73609836d6.21.1737142529803; Fri, 17 Jan 2025
 11:35:29 -0800 (PST)
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
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com> <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
In-Reply-To: <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
From: enh <enh@google.com>
Date: Fri, 17 Jan 2025 14:35:18 -0500
X-Gm-Features: AbW1kvYaXalMuVcN4fChMZ9gaCas0Qmcz-I2_lvsxGYgbIiFv-NPY4ujWyjJTzw
Message-ID: <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Jeff Xu <jeffxu@chromium.org>
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

On Fri, Jan 17, 2025 at 1:20=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Thu, Jan 16, 2025 at 9:18=E2=80=AFAM Pedro Falcato <pedro.falcato@gmai=
l.com> wrote:
> >
> > On Thu, Jan 16, 2025 at 5:02=E2=80=AFPM Benjamin Berg <benjamin@sipsolu=
tions.net> wrote:
> > >
> > > Hi Lorenzo,
> > >
> > > On Thu, 2025-01-16 at 15:48 +0000, Lorenzo Stoakes wrote:
> > > > On Wed, Jan 15, 2025 at 12:20:59PM -0800, Jeff Xu wrote:
> > > > > On Wed, Jan 15, 2025 at 11:46=E2=80=AFAM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > [SNIP]
> > > > >
> > > > > > I've made it abundantly clear that this (NACKed) series cannot =
allow the
> > > > > > kernel to be in a broken state even if a user sets flags to do =
so.
> > > > > >
> > > > > > This is because users might lack context to make this decision =
and
> > > > > > incorrectly do so, and now we ship a known-broken kernel.
> > > > > >
> > > > > > You are now suggesting disabling the !CRIU requirement. Which v=
iolates my
> > > > > > _requirements_ (not optional features).
> > > > > >
> > > > > Sure, I can add CRIU back.
> > > > >
> > > > > Are you fine with UML and gViso not working under this CONFIG ?
> > > > > UML/gViso doesn't use any KCONFIG like CRIU does.
> > > >
> > > > Yeah this is a concern, wouldn't we be able to catch UML with a fla=
g?
> > > >
> > > > Apologies my fault for maybe not being totally up to date with this=
, but what
> > > > exactly was the gViso (is it gVisor actually?)
> > >
> > > UML is a separate architecture. It is a Linux kernel running as a
> > > userspace application on top of an unmodified host kernel.
> > >
> > > So really, UML is a mostly weird userspace program for the purpose of
> > > this discussion. And a pretty buggy one too--it got broken by rseq
> > > already.
> > >
> > > What UML now does is:
> > >  * Execute a tiny static binary
> > >  * map special "stub" code/data pages at the topmost userspace addres=
s
> > >    (replacing its stack)
> > >  * continue execution inside the "stub" pages
> > >  * unmap everything below the "stub" pages
> > >  * use the unmap'ed area for userspace application mappings
> > >
> > > I believe that the "unmap everything" step will fail with this featur=
e.
> > >
> > >
> > > Now, I am sure one can come up with solutions, e.g.:
> > >    1. Simply print an explanation if the unmap() fails
> > >    2. Find an address that is guaranteed to be below the VDSO and use=
 a
> > >       smaller address space for the UML userspace.
> > >    3. Somehow tell the host kernel to not install the VDSO mappings
> > >    4. Add the host VDSO pages as a sealed VMA within UML to guard the=
m
> > >
> > > UML is a bit of a niche and I am not sure it is worth worrying about =
it
> > > too much.
> >
> > I've been absent from this patch series in general, but this gave me
> > an idea: what if we let userspace seal these mappings itself? Since
> > glibc is already sealing things, it might as well seal these?
> > And then systems that _do_ care about this would set the glibc tunable
> > and deal with the breakage.
> >
> > Is there something seriously wrong with this approach? Besides maybe
> > not having a super easy way to discover these mappings atm, I feel
> > like it would solve all of the policy issues people have been talking
> > about in these threads.
> >
> There are technical difficulties to seal vdso/vvar from the glibc
> side. The dynamic linker lacks vdso/vvar mapping size information, and
> architectural variations for vdso/vvar also means sealing from the
> kernel side is a simpler solution. Adhemerval has more details in case
> clarification is needed from the glibc side.

as a maintainer of a different linux libc, i've long wanted a "tell me
everything there is to know about this vma" syscall rather than having
to parse /proc/maps...

...but in this special case, is the vdso/vvar size ever anything other
than "one page" in practice?

> Additionally, uprobe mapping can't be sealed by the dynamic linker,
> dynamic linker can only apply sealing during execve() and dlopen(),
> uprobe mapping isn't created during those two calls.
>
> -Jeff
>
>
> > --
> > Pedro
