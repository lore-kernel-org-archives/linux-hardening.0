Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12EB217F40
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030459; cv=none; b=ViVGBVAYWOSe9B4zgZ7fatdJEonsH106FOEQbFHKzBYDrvrVS5S3A0hTF/uhIcQcHCM5PQUSR8z9gH1HcHogmTZYmrMnSNGtVMjlbGqUIFc8UsqmH+AKGRXC/pAydH10G3dYkIMKdfJ39F2hJxDTW4lRKzvfZNifs+4KCmNGfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030459; c=relaxed/simple;
	bh=v+CymtTSnhzau6gvKAu/GJ76T7dVVsDpnT9yJxPQmtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff1RUc3ZlKvHKsdcl9i1TJGO3mz49Tbkk+sFfHmXpFksxphNg16td6Lm7i4mn2olMcz6JLbYHvxLkCkqnV6zbGUMKn1iraJkjciriypVcqxg9ohzKGU4vMLXUbUSpzbVPQ8waOL/4MKtP87SmBiOYZQhUHPGpfyRXSwWohZiWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YpuA3+Vc; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YpuA3+Vc"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-724daedf8c3so908345a34.3
        for <linux-hardening@vger.kernel.org>; Mon, 03 Mar 2025 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741030456; x=1741635256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TRJ44BH31NUhCHJXuBhqstjp6BiV2xjfEwoVOhwUP0=;
        b=YpuA3+VcdJluMgth9Y1o4DnQ1qkAf3A3HQ4/YSxzFHm9jyBjwoqChGbO1w9NHne3/s
         4kmHxGYUlS/bYmQoj8PZP5ImiT66Yq0bHElT/Cv1sTkD3meaeQrkqBTCwjRsHxAkkJZn
         OSTb1bdVDB4/Boj4ic+RkT4xBIF+CDQWEVk1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030456; x=1741635256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TRJ44BH31NUhCHJXuBhqstjp6BiV2xjfEwoVOhwUP0=;
        b=uKjITvDdrJRvFzdG+Nbzm3GixqcVRaliJXjzs6zqkHy7OsskNwIQCqhUrrlWqyTbvb
         t9L8/cka3LmMiXFCCNVSSMvNZhuJnoKAy07tFQUHHsilLRJX4ROTlBNFVI3CwHB97Isi
         +5yHCTPMeNplIHK4rTdorOSl6HPkzIehFy19R8I5QCWAfoiGHsW+7WyntbR6MGYoAYun
         xnMU8Y4hP1BU2/u4gzp+hSC3q+58YYqhvBNu+B6Mtqw2rZSmMmZ7WL5CRO6DBXb5XgcD
         d/vgZElM+NripluQf7XqOHAUC3T9mCZLY1+QgWAn5oOD4kzmKSy1pUqiMQwcgllnK/pH
         JOEA==
X-Forwarded-Encrypted: i=1; AJvYcCUSPGpm2nmYdUFCEy0tsH8+LAC70nrz2YPyYESrANrDz8ru1uyjVjjf759Zo7Jb2yB/gNw2XQkAuKQ3q3JpdRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvoVSbjwdLg6u3QdP4Cp66tA3uiNBgT46q25LzZ9+NnG/muU8n
	C++MYS2PyZcF+Zvax9a8d/XFaQ81bptreC81GCYSENou7A2jMcFz9M2C6nKThr3JGIkFJpFBdDB
	o9ewqpGMMXulHwN6ta2CCU404UIWitafDBEEq
X-Gm-Gg: ASbGncvsB7B+Qzg2eBEt3Pc9jxDL1b1tK8o1GUAzjT9Ui85ltOTGgPAOcEHyD/v8kTr
	RE0/1dROpBafNCcoTk7hHQJn0I0wXMAstaP67CiQIcqb/opXiZOJTI8UKWUxfcBgdW4DVokU9Kq
	VVdTzmXGZ0jYpHThT/ilWxbQ5utgu2pS9jeUzhwFD7TLJjQk09RGXt/AI=
X-Google-Smtp-Source: AGHT+IEwrg6wY8Y2ouC1pR3h3Bh3ijMUnINP28bst/fv0Tz3SsD+Thqpp0hOQ1CjWKueIO3bwWa1zIY9jvKARU43hRY=
X-Received: by 2002:a05:6808:179f:b0:3f4:3ec:11ff with SMTP id
 5614622812f47-3f558304cd2mr3549126b6e.0.1741030456616; Mon, 03 Mar 2025
 11:34:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303050921.3033083-1-jeffxu@google.com> <20250303050921.3033083-4-jeffxu@google.com>
 <24be17fd-4899-49ae-9b4e-9372fcb4e0cd@lucifer.local>
In-Reply-To: <24be17fd-4899-49ae-9b4e-9372fcb4e0cd@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 3 Mar 2025 11:34:05 -0800
X-Gm-Features: AQ5f1Jq2xY3e4auvFuYbMS1vMNpdRf4M_yrHWrDo25LJ6mNLdQqRcc_Co3iWjCs
Message-ID: <CABi2SkVbu13SQ9HOWHiVUqCddYc9tuphV4L-obDQaEQy5wqx1w@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mseal sysmap: enable x86-64
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org, sroettger@google.com, 
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:01=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> I tried b4 shazam'ing this and there's a problem applying the patch, seem=
s
> maybe a conflict?
>
> Not sure if Andrew can resolve or if something needs to be done here?
>
> Seems to be commit d77a800944d8 ("mm: make DEBUG_@WX dependent on
> GENERIC_PTDUMP")?
>
> Should be a trivial resolve though.
>
This version is based on linux-main, if that helps resolving the conflict.

I can also rebase using the mm-(unstable/stable) branch or other
branches if asked.

Thanks
-Jeff


> On Mon, Mar 03, 2025 at 05:09:17AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> > covering the vdso, vvar, vvar_vclock.
> >
> > Production release testing passes on Android and Chrome OS.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  arch/x86/Kconfig          | 1 +
> >  arch/x86/entry/vdso/vma.c | 7 ++++---
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index be2c311f5118..c6f9ebcbe009 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -26,6 +26,7 @@ config X86_64
> >       depends on 64BIT
> >       # Options that are inherently 64-bit kernel only:
> >       select ARCH_HAS_GIGANTIC_PAGE
> > +     select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >       select ARCH_SUPPORTS_PER_VMA_LOCK
> >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > index 39e6efc1a9ca..a4f312495de1 100644
> > --- a/arch/x86/entry/vdso/vma.c
> > +++ b/arch/x86/entry/vdso/vma.c
> > @@ -268,7 +268,8 @@ static int map_vdso(const struct vdso_image *image,=
 unsigned long addr)
> >                                      text_start,
> >                                      image->size,
> >                                      VM_READ|VM_EXEC|
> > -                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > +                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
> > +                                    VM_SEALED_SYSMAP,
> >                                      &vdso_mapping);
> >
> >       if (IS_ERR(vma)) {
> > @@ -280,7 +281,7 @@ static int map_vdso(const struct vdso_image *image,=
 unsigned long addr)
> >                                      addr,
> >                                      (__VVAR_PAGES - VDSO_NR_VCLOCK_PAG=
ES) * PAGE_SIZE,
> >                                      VM_READ|VM_MAYREAD|VM_IO|VM_DONTDU=
MP|
> > -                                    VM_PFNMAP,
> > +                                    VM_PFNMAP|VM_SEALED_SYSMAP,
> >                                      &vvar_mapping);
> >
> >       if (IS_ERR(vma)) {
> > @@ -293,7 +294,7 @@ static int map_vdso(const struct vdso_image *image,=
 unsigned long addr)
> >                                      addr + (__VVAR_PAGES - VDSO_NR_VCL=
OCK_PAGES) * PAGE_SIZE,
> >                                      VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
> >                                      VM_READ|VM_MAYREAD|VM_IO|VM_DONTDU=
MP|
> > -                                    VM_PFNMAP,
> > +                                    VM_PFNMAP|VM_SEALED_SYSMAP,
> >                                      &vvar_vclock_mapping);
> >
> >       if (IS_ERR(vma)) {
> > --
> > 2.48.1.711.g2feabab25a-goog
> >
