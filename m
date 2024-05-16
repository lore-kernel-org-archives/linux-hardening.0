Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD915A4
	for <linux-hardening@vger.kernel.org>; Thu, 16 May 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821181; cv=none; b=J3f9YTfAuLNzH5XxqhOOfQ1Mg9kZJejEOhHLRUutRBmLTiQhQ0Xkgxb92rYZX4153aNOf/cJytJhIkNfyU71sP7w5mj7uAdOu0a20GuoFUpX+30a/y+7uqyP2pM9DWvbijA1+QldY+0L5RLIiYL8uYTq8ad1X14znOhDFu9/4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821181; c=relaxed/simple;
	bh=R0ipLoOP+M7zJ/6w0ygX08okJs++8vl3qhrLtApWAqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rVGvw7GfujP4B+/sYDyfd/IwHfSL4AhIdz7fhwYKBbmV5yrFYZD6Jh1tJ0WtrwKzzRGCEn3DwL3RSd9CaVjDkYrr62EUNlKOu70kNSe3ByehnvM43k5qGUNP7a5+Lys3bNgT8tV88UmEqKcoKDspDf1DH/s8rxGTLMAjwLQ9enc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OYbDHjwk; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYbDHjwk"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2baa24c2bso2330187eaf.0
        for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715821179; x=1716425979; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKByB1x2Ra+G7EvspZbKzTea5I7AEV+P8bKknO4K/Pw=;
        b=OYbDHjwkPTJy4I7M1PtzYEDiZMvM2jNsSpadWIgW5uj9w92oLvQ6j7CSvUzbD4ssKk
         1BKOwmfd332T5uu2LqVGcqFOcO/Di+30Wmf8GDWyZBUGbnWmVFNHHaov6iuOKAWu4M6T
         dx9a9pOgiwEDbkfcltN86B2MymkAM2n9fuzGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715821179; x=1716425979;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKByB1x2Ra+G7EvspZbKzTea5I7AEV+P8bKknO4K/Pw=;
        b=H1HaIoEJqv8HU8fYjvnsnwccx/GXIbRRTmkkxJB5tt4tlSr6S97lAdnW8SLWH0EkuA
         HRuSmoXgNEfiHJ518Q5Qk4U6q/32850ZoPA0fGsr3/MRWYAHJdxXDAD/CGzYS6EjOQwT
         OvU8VYfABchGoZ57nlyJ/YoTP+5b8OixzMrSDRMklGROLUHLmObQyJiO92rEtOqmV7zn
         J1pRPbVC/7K4b1hIj70J5pV6BrvA70Ia3sLO6wzVpI67g+/R9GDw2sXz+0y275PdphfH
         wMEUw3veLmN6+HFLUOSeh+SM0MLCXzPVp1NkXol7SwwnHB3tZ+NwAOg4RhSmQoR4sDqI
         GJrA==
X-Forwarded-Encrypted: i=1; AJvYcCXtaIGvzI1WLPeKKJjvM907/rHNaFhOGYNCQH8xRRaMmv7NEO30HCdoyDWOAtI06zdBUNe4anRrlY1LoFvfUh8IH4YEnIdeCuFWRIdm9WOq
X-Gm-Message-State: AOJu0YwI551tL2wkjWOw4rsMv+54LFJkQI169Q4pbcce/2bTWVBrh9Th
	w6gd9+t9sl6yk1X8a6cEFXPdQZf3l10eMjdfiPSeqQ0HBirKByTAqxEne6x87PwKajrNA8APyrE
	CnNiJS2gQAAc9BI8j9Ytt6SqGvUdsSkzgtJQu
X-Google-Smtp-Source: AGHT+IFvkJEPxJ+yngArtr7AMa30DFdKcbfitHwSdnpWJQg42FEsfMf1OWA+u9hWOLZfCwrPgfJkJXFvANLzlkBxt8o=
X-Received: by 2002:a05:6871:215:b0:23f:59fc:e509 with SMTP id
 586e51a60fabf-24172a3d9edmr20301293fac.4.1715821178794; Wed, 15 May 2024
 17:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <d46qb2rkfsagw22u6ishgagsvsmqsu5nrmf5up5mhi6xrwolyt@6ir6g2v63of7>
 <CABi2SkXBpL8qdSMTwe5njWasqidsWDkhme6xw2_38JARrhPRwA@mail.gmail.com> <3rpmzsxiwo5t2uq7xy5inizbtaasotjtzocxbayw5ntgk5a2rx@jkccjg5mbqqh>
In-Reply-To: <3rpmzsxiwo5t2uq7xy5inizbtaasotjtzocxbayw5ntgk5a2rx@jkccjg5mbqqh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 15 May 2024 17:59:27 -0700
Message-ID: <CABi2SkVLqE7WD2MTYpksxA3+BfLLzjibHeJy9saYFvM-GRFy-w@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 3:19=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [240515 13:18]:
> ...
>
> > The current mseal patch does up-front checking in two different situati=
ons:
> > 1 when applying mseal()
> >    Checking for unallocated memory in the given memory range.
> >
> > 2 When checking mseal flag during mprotect/unmap/remap/mmap
> >   Checking mseal flag is placed ahead of the main business logic, and
> > treated the same as input arguments check.
> >
> > > Either we are planning to clean this up and do what we can up-front, =
or
> > > just move the mseal check with the rest.  Otherwise we are making a
> > > larger mess with more technical dept for a single user, and I think t=
his
> > > is not an acceptable trade-off.
> > >
> > The sealing use case  is different  from regular mm API and this
> > didn't create additional technical debt.  Please allow me to explain
> > those separately.
> >
> > The main use case and threat model is that an attacker exploits a
> > vulnerability and has arbitrary write access to the process, and can
> > manipulate some arguments to syscalls from some threads. Placing the
> > checking of mseal flag ahead of mprotect main business logic is
> > stricter compared with doing it in-place. It is meant to be harder for
> > the attacker, e.g. blocking the  opportunistically attempt of munmap
> > by modifying the size argument.
>
> If you can manipulate some arguments to syscalls, couldn't it avoid
> having the VMA mseal'ed?
>
The mm sealing can be applied in advance. This type of approach is
common in sandboxer, e.g. setup restrictive environments in advance.

> Again I don't care where the check goes - but having it happen alone is
> pointless.
>
> >
> > The legit app code won't call mprotect/munmap on sealed memory.  It is
> > irrelevant for both precheck and in-place check approaches, from a
> > legit app code point of view.
>
> So let's do them together.
>
For the user case I describe in the threat-model, precheck is a better
approach. Legit code doesn't care.

> ...
>
> > About tech debt, code-wise , placing pre-check ahead of the main
> > business logic of mprotect/munmap APIs, reduces the size of code
> > change, and is easy to carry from release to release, or backporting.
>
> It sounds like the other changes to the looping code in recent kernels
> is going to mess up the backporting if we do this with the rest of the
> checks.
>
What other changes do you refer to ?

I backported V9 to 5.10 when I ran the performance test on your
request, and the backporting to 5.10 is relatively straight forward,
the mseal flag check is placed after input arguments check and before
the main business logic.

> >
> > But let's compare  the alternatives - doing it in-place without prechec=
k.
> > - munmap
> > munmap calls arch_unmap(mm, start, end) ahead of main business logic,
> > the checking of sealing flags would need to be architect specific. In
> > addition, if arch_unmap return fails due to sealing, the code should
> > still proceed, till the main business logic fails again.
>
> You are going to mseal the vdso?
>
How is that relevant ?
To answer your question: I don't know at this moment.
The initial scope of libc change is sealing the RO/RX part during elf
loading.e.g. .text and .RELO

> >
> > - mremap/mmap
> > The check of sealing would be scattered, e.g. checking the src address
> > range in-place, dest arrange in-place, unmap in-place, etc. The code
> > is complex and prone to error.
> >
> > -mprotect/madvice
> > Easy to change to in-place.
> >
> > - mseal
> > mseal() check unallocated memory in the given memory range in the
> > pre-check. Easy to change to in-place (same as mprotect)
> >
> > The situation in munmap and mremap/mmap make in-place checks less desir=
able imo.
> >
> > > Considering the benchmarks that were provided, performance arguments
> > > seem like they are not a concern.
> > >
> > Yes. Performance is not a factor in making a design choice on this.
> >
> > > I want to know if we are planning to sort and move existing checks if=
 we
> > > proceed with this change?
> > >
> > I would argue that we should not change the existing mm code. mseal is
> > new and no backward compatible problem. That is not the case for
> > mprotect and other mm api. E.g. if we were to change mprotect to add a
> > precheck for memory gap, some badly written application might break.
>
> This is a weak argument. Your new function may break these badly written
> applications *if* gcc adds support.  If you're not checking the return
> type then it doesn't really matter - the application will run into
> issues rather quickly anyways.  The only thing that you could argue is
> the speed - but you've proven that false.
>
The point I raised here is that there is a risk to modify  mm API's
established behavior. Kernel doesn't usually make this kind of
behavior change.

mm sealing is a new functionality, I think applications will need to
opt in , e.g. allow dynamic linker to seal .text.

> >
> > The 'atomic' approach is also really difficult to enforce to the whole
> > MM area, mseal() doesn't claim it is atomic. Most regular mm API might
> > go deeper in mm data structure to update page tables and HW, etc. The
> > rollback in handling those error cases, and performance cost. I'm not
> > sure if the benefit is worth the cost. However, atomicity is another
> > topic to discuss unrelated to mm sealing.  The current design of mm
> > sealing is due to its use case and practical coding reason.
>
> "best effort" is what I'm saying.  It's actually not really difficult to
> do atomic, but no one cares besides Theo.
>
OK, if you strongly believe in 'atomic' or 'best effort atomic',
whatever it is, consider sending a patch and getting feedback from the
community ?

> How hard is it to put userfaultfd into your loop and avoid having that
> horrible userfaulfd in munmap?  For years people see horrible failure
> paths and just dump in a huge comment saying "but it's okay because it's
> probably not going to happen".  But now we're putting this test up
> front, and doing it alone - Why?
>
As a summary of why:
- The use case: it makes it harder for attackers to modify memory
opportunistically.
- Code: Less and simpler code change.

Thanks
-Jeff

> Thanks,
> Liam
