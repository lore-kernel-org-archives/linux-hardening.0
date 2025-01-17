Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25F1537AC
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138034; cv=none; b=kbCvpWxR4VQq1PIX9AXRTLqQHb/rfu2qFCJgg1Ap77ir4xnHhmoLngSrNBFZaeAQNdw4XpYATeJbTW0bbizZRhPkLlKx+UErm8TqX43VCODbj9xev27HXb/61q0kJJKtb5iLEYpEvWauZW7+f2l5oJvYVVWbH1x3dAgtKCJTKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138034; c=relaxed/simple;
	bh=bbQBMPUjJx7aPJ/U49Rx11gOQ/pV1v+6ZUDpCB1Im7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9ceNg3ffbg2mD/4v2ywN2VaQnSl2IJVNY2sNUJW6L0cxVuY1gsbTT5iXWe7BkxTyUN2p8e41H7WqETROkZIpLMs+t+/b/H7mMCgKvRgSizVpQ96VvAp82X2S6/LWODvbymWglGoFAhTTeuyt29gRkVNlJ0HBGCiPXxWMEY8bgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A0vS2f2p; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A0vS2f2p"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f302223fe1so80201eaf.1
        for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737138032; x=1737742832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/fo6mTZutKR3QAHE0Pj8Nd1lbI+SJ+/TzDYibg9toM=;
        b=A0vS2f2pmojHcB2Hhe72PH7Phaptu1SY46o7wo2vQ0FzAUoooHVwlc8tfqLalJr05V
         nsA9FDb5yGCFDPYW/p3TMcVSUdBDja/4M/gEyvf3rhOCqJ0EOGDr4w0BLhVQI/6uiT10
         4dUa7oFI+TCpyRPgBPRCjMT1J0eY8KGWfRsUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737138032; x=1737742832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/fo6mTZutKR3QAHE0Pj8Nd1lbI+SJ+/TzDYibg9toM=;
        b=uZ/6NN65O5KyqxSXL9Gb9LamzCTqw9OKR3dUIVt+X7l3ZS+IIY1aQ65RxpGsRGozrR
         rdj05hjMUrU3D50mlJ+DvrB8A8P5Hx/Rv6kAF7pQmQvDacA7+0SIY1syIjj13FBsvzc3
         n2dj8/qf5cGUWRDjV2agOGR8jBfW9Y578N9gbJBjRc+bp6yOQQ6YTWa3YKaexqeCu9AD
         Yg9sA7mC55RkstQA1tLIqBIP8QYKoclbZcsEnttcl0mH4oSbrn4ijEYfm1WABXtpmCko
         rcTupujgAW497eL/LpgEeCiJq5MCtnx/WiDlQoFdBi8Ta5s57utJ6uTaz+DQ2mDnVri+
         pVWw==
X-Forwarded-Encrypted: i=1; AJvYcCUf0OX4XiBZP0Dev5X4J1j6oGlTXzUUy28oUkVMDWrCQx0jWBHGIINGwthDxo2qLEwGvk6dmaJHY01zCcmNDNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztq+3tf8Hv/W9k+QIT4sMuKllur2Ycf7SQKxRm/3TsPhJT3Owh
	U5EKJf9/z+lNwRCrSEIqheNqInrryLD7ysmmII6TKSwFfEMl01D+8QvPSPPbbKXeKk+VkJTC26c
	ARGzoXlqaxa3zm6nYSt2kTVDuBviA7YvDC9me
X-Gm-Gg: ASbGncugZ+UhA8s5f+aZ+GtnLBxaWmFB8EiQscjgbf1DYVR16JXCnpEwJelbck9BqI9
	6tawtTa7TWsER04xRROC9nxwvFvHyhvPpGYYIbgVu8j8gM8jgCto3icMULB/0Z0jzWqxg5vM=
X-Google-Smtp-Source: AGHT+IEl14ZsVUuRQs9kENiOI/ccHALGPnLCzkhX2kYLVq1g67aUGEjWWSC3kkfQ60mKfp+6ZE7STELJxCWfkQ+V3xQ=
X-Received: by 2002:a05:6870:218c:b0:29e:37d7:3f56 with SMTP id
 586e51a60fabf-2b1c0d516b9mr698878fac.12.1737138032234; Fri, 17 Jan 2025
 10:20:32 -0800 (PST)
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
In-Reply-To: <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 17 Jan 2025 10:20:20 -0800
X-Gm-Features: AbW1kvakDKAevh2HLCVhk1nyOYdN4y1OuVm2uoByUvbbZ392IzJafigOqPdV0eM
Message-ID: <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
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
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>, 
	Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 9:18=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Jan 16, 2025 at 5:02=E2=80=AFPM Benjamin Berg <benjamin@sipsoluti=
ons.net> wrote:
> >
> > Hi Lorenzo,
> >
> > On Thu, 2025-01-16 at 15:48 +0000, Lorenzo Stoakes wrote:
> > > On Wed, Jan 15, 2025 at 12:20:59PM -0800, Jeff Xu wrote:
> > > > On Wed, Jan 15, 2025 at 11:46=E2=80=AFAM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > [SNIP]
> > > >
> > > > > I've made it abundantly clear that this (NACKed) series cannot al=
low the
> > > > > kernel to be in a broken state even if a user sets flags to do so=
.
> > > > >
> > > > > This is because users might lack context to make this decision an=
d
> > > > > incorrectly do so, and now we ship a known-broken kernel.
> > > > >
> > > > > You are now suggesting disabling the !CRIU requirement. Which vio=
lates my
> > > > > _requirements_ (not optional features).
> > > > >
> > > > Sure, I can add CRIU back.
> > > >
> > > > Are you fine with UML and gViso not working under this CONFIG ?
> > > > UML/gViso doesn't use any KCONFIG like CRIU does.
> > >
> > > Yeah this is a concern, wouldn't we be able to catch UML with a flag?
> > >
> > > Apologies my fault for maybe not being totally up to date with this, =
but what
> > > exactly was the gViso (is it gVisor actually?)
> >
> > UML is a separate architecture. It is a Linux kernel running as a
> > userspace application on top of an unmodified host kernel.
> >
> > So really, UML is a mostly weird userspace program for the purpose of
> > this discussion. And a pretty buggy one too--it got broken by rseq
> > already.
> >
> > What UML now does is:
> >  * Execute a tiny static binary
> >  * map special "stub" code/data pages at the topmost userspace address
> >    (replacing its stack)
> >  * continue execution inside the "stub" pages
> >  * unmap everything below the "stub" pages
> >  * use the unmap'ed area for userspace application mappings
> >
> > I believe that the "unmap everything" step will fail with this feature.
> >
> >
> > Now, I am sure one can come up with solutions, e.g.:
> >    1. Simply print an explanation if the unmap() fails
> >    2. Find an address that is guaranteed to be below the VDSO and use a
> >       smaller address space for the UML userspace.
> >    3. Somehow tell the host kernel to not install the VDSO mappings
> >    4. Add the host VDSO pages as a sealed VMA within UML to guard them
> >
> > UML is a bit of a niche and I am not sure it is worth worrying about it
> > too much.
>
> I've been absent from this patch series in general, but this gave me
> an idea: what if we let userspace seal these mappings itself? Since
> glibc is already sealing things, it might as well seal these?
> And then systems that _do_ care about this would set the glibc tunable
> and deal with the breakage.
>
> Is there something seriously wrong with this approach? Besides maybe
> not having a super easy way to discover these mappings atm, I feel
> like it would solve all of the policy issues people have been talking
> about in these threads.
>
There are technical difficulties to seal vdso/vvar from the glibc
side. The dynamic linker lacks vdso/vvar mapping size information, and
architectural variations for vdso/vvar also means sealing from the
kernel side is a simpler solution. Adhemerval has more details in case
clarification is needed from the glibc side.

Additionally, uprobe mapping can't be sealed by the dynamic linker,
dynamic linker can only apply sealing during execve() and dlopen(),
uprobe mapping isn't created during those two calls.

-Jeff


> --
> Pedro
