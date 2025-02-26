Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D114D2A0
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530941; cv=none; b=k98rtko6GFntCPVH4pyfTEMG1eXAKaDGAQpyWAqRoy2wobkTJKGq+3oOlKJSqPcLE/AqjksRyvhka5mFo12b3oxdotVc/kodEJL1/fB+5YV8kp3+fr9GxFomxrxANbKJrycdz/4puyBzcT2MopM6rLTrJPk+bWj5weRjGmSBYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530941; c=relaxed/simple;
	bh=NdAKpzv41KIxBAk3AHe542XBbfiX3FwfgvvJR12NlTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEp77DetWejPb3INBDaTdmPozvDsFZ5Ol3ttIsqK54ruG35ytmCEyL6rkBRfZ7P4LdmXBWjfVRNfp1A2T0LhfIrSZ8LSV6pBmiz4PjwJjyGNoJkMWgME28T8BWyCLNOZE0sFOEs5mPyP2pQwLN2SSDK9615+EOwtkRb4dk83wzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=STuYX3oS; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STuYX3oS"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2a8880c40fdso443298fac.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 16:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740530939; x=1741135739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVjqrV9ooYY5XM2Ro6nNPVrSgDfeAb3Lv275HPJChck=;
        b=STuYX3oS5Dt5tgfWAodnVWqlVl6mGUMsm7vwhuU29x0GQlbhz4GyRJp5X0bX1IqqhK
         5DMXCdDrgAWRN+BOnmazKbkB/Oa961nhJSwXc2Qz+8GFHjdpuuYLzQSYPx+9lD0RkAng
         QicqqrykDDFYRLvIlqhfeoKlYQk1N+todNVkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530939; x=1741135739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVjqrV9ooYY5XM2Ro6nNPVrSgDfeAb3Lv275HPJChck=;
        b=IbP4nA8/5vz0krFU/ubKssd4+6fKc0VAltjdQTvs1GOSlxW4VQPMPE3iuj31q/cn6j
         GaGQ6GamxvfZXQa3m6bj6NKHD5dhlDaQfQoYUcmUZZvDjWKoQNj3NufPH8YNDxVxw2uL
         B1d6JMMXcE3F1znEPqBphmRJsyoD0kRwi2yjY2sntxbtnUrmNcgmPkPuMKWiPfPN14cD
         tMqLlN7IH84DSQc1PpQQjnMygAgStGyXOppkFkEx3womp8ExkNEP19uk0G1/urWraUs8
         mdUAATt0ZiD6ECwtvjuCImsq+NS/M8JCg2ASce8Zs2h8llPsAd94hLn2vQJwAkazf6Ib
         1B5A==
X-Forwarded-Encrypted: i=1; AJvYcCXJzobooci+SA+euVcMVE88qKafH8EOK9RJQExxcVzIkLV05A8UWEcvYYqODgh3ogSJI4CIA+oXCBGtdp1nq64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WRBhPQWpg+HmouaR5dbSSrII+71Xk5Iq/VsLVsO8yWfBQR0O
	bh2STZ4F8tYkhqfp+7Q4dOHBxRpSmDnCUKUNws+4UglE46jzGZFYc0LWN87eADCHMzRvSAIEqhi
	Oxyr7ciRyhWYQrcfJ+sDMI4yIA6dLhRZrKiwo
X-Gm-Gg: ASbGncvcH1gSxzJxZCqDkJPpgpZjvndpOGgbTJ6SVbKK6gV7cklpmxzClSGOFS5d/Kl
	z1BR+Grog5RtdeulobDdmeyf9zRjifhZzwLd3vrwZuooYmnTemS8Zr64vryA1cR3eIOwbJzRvov
	BVDy55/rx6Dc6obU8vl+roQQO5jAC/J8gtAdk=
X-Google-Smtp-Source: AGHT+IGZbr9C3fw/M80D7U25WXvQ+YkVYOhFcuvGjWOO46noie5b+33k+LuPnjzb/dFNh57i49Vsajbe1fap9TbizXk=
X-Received: by 2002:a05:6808:2109:b0:3f4:159d:a27e with SMTP id
 5614622812f47-3f4247df7a0mr5851557b6e.8.1740530938691; Tue, 25 Feb 2025
 16:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-4-jeffxu@google.com>
 <20250225085728-24167715-8562-45a8-86cd-0ea503e4bc73@linutronix.de>
In-Reply-To: <20250225085728-24167715-8562-45a8-86cd-0ea503e4bc73@linutronix.de>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 16:48:47 -0800
X-Gm-Features: AQ5f1JrsyQpU8D8-7sqmxrCWx44j7l_vFI1HjJFXH5LWUwsT0KeRVBq5_z7J_YU
Message-ID: <CABi2SkUwETzrBSYm0QV9+eoeo0kgA+r2JM4QaFpQqeTiidFEDA@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] mseal, system mappings: enable x86-64
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:08=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Hi Jeff,
>
> On Mon, Feb 24, 2025 at 10:52:42PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> > covering the vdso, vvar, vvar_vclock.
> >
> > Production release testing passes on Android and Chrome OS.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  arch/x86/Kconfig          |  1 +
> >  arch/x86/entry/vdso/vma.c | 16 ++++++++++------
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 87198d957e2f..8fa17032ca46 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -26,6 +26,7 @@ config X86_64
> >       depends on 64BIT
> >       # Options that are inherently 64-bit kernel only:
> >       select ARCH_HAS_GIGANTIC_PAGE
> > +     select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >       select ARCH_SUPPORTS_PER_VMA_LOCK
> >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > index 39e6efc1a9ca..1b1c009f20a8 100644
> > --- a/arch/x86/entry/vdso/vma.c
> > +++ b/arch/x86/entry/vdso/vma.c
> > @@ -247,6 +247,7 @@ static int map_vdso(const struct vdso_image *image,=
 unsigned long addr)
> >       struct mm_struct *mm =3D current->mm;
> >       struct vm_area_struct *vma;
> >       unsigned long text_start;
> > +     unsigned long vm_flags;
> >       int ret =3D 0;
> >
> >       if (mmap_write_lock_killable(mm))
> > @@ -264,11 +265,12 @@ static int map_vdso(const struct vdso_image *imag=
e, unsigned long addr)
> >       /*
> >        * MAYWRITE to allow gdb to COW and set breakpoints
> >        */
> > +     vm_flags =3D VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> > +     vm_flags |=3D VM_SEALED_SYSMAP;
> >       vma =3D _install_special_mapping(mm,
> >                                      text_start,
> >                                      image->size,
> > -                                    VM_READ|VM_EXEC|
> > -                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > +                                    vm_flags,
> >                                      &vdso_mapping);
> >
> >       if (IS_ERR(vma)) {
> > @@ -276,11 +278,12 @@ static int map_vdso(const struct vdso_image *imag=
e, unsigned long addr)
> >               goto up_fail;
> >       }
> >
> > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > +     vm_flags |=3D VM_SEALED_SYSMAP;
> >       vma =3D _install_special_mapping(mm,
> >                                      addr,
> >                                      (__VVAR_PAGES - VDSO_NR_VCLOCK_PAG=
ES) * PAGE_SIZE,
> > -                                    VM_READ|VM_MAYREAD|VM_IO|VM_DONTDU=
MP|
> > -                                    VM_PFNMAP,
> > +                                    vm_flags,
> >                                      &vvar_mapping);
>
> This hunk (and the vvar mapping in the arm64 patch) will conflict with my
> "Generic vDSO datapage" series.
> That series is already part of the tip tree (branch timers/vdso) and sche=
duled
> for the next merge window.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dtime=
rs/vdso
>
> The conflict resolution is fairly easy:
> Move the new flag logic into lib/vdso/datastore.c
>
Thank you for bringing this to my attention.

In your change,  it seems lib/vdso/datastore.c implements a
vdso_install_vvar_mapping(), then all the architectures call this
function.

So merging conflict won't be as straightforward.  Maybe a better
approach is that I continue resolving all the comments, based on the
latest main. Then wait for your change to be merged and submit another
version.

Thanks
-Jeff

-Jeff
