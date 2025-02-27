Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38381271268
	for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692687; cv=none; b=oYefn3CdjEdQx+xpbu5oiErqnnYcvxr2lJebmu9Ud6Kn7UMpE/AqhNMIds1VI69lzzymGwX24SKUj/mc7vGeT+ZawFq5z4C5nk2REHQo5j7HSVx42s7wvT+Suq8lxsfP04faK3T9Y3oIPeMfpPsy6+cGJ2DRK8Gbh8oiVJwUjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692687; c=relaxed/simple;
	bh=n6njHu7ybdBsZiHui7SoRCsudV2bX4MYy8gZpvTckbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvGv3SnuWWrmgz9UOZJIWnwhSREoSrSomYehPrSyzjJ2SV6Ol9J3F/OsCGahS4oq3g87CTXUPT+J9w+Kg+WofW7+z8spXhVZfYtUL9hMIV+p2MoEs6P1Y0LOGKQYaP3hv/TakcOkcp9j11QAbLNbTqdlnAEzhEopl+8DEQPpULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fHu0FEuA; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fHu0FEuA"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5fcde6cdd8bso97685eaf.3
        for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 13:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740692685; x=1741297485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41P9T7rAOn5C903KcslM4I+TaCE2v2OwMWOr2r9y6yc=;
        b=fHu0FEuAOX/0jwIpdBgZIni3fAXQi4QC7sEnk6NuKZwTpmQFNsGxDPL9eIEwH4xCUz
         QX+FmmryD4+D0nY/AIbV0dMeZQ/ZDBH28zdOhkAafTFz+HEWyu/jkXhvdfngbzOmF+U8
         XTOalWs77FjGmZq7EqN8VCRxh2A+lKACmeXIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692685; x=1741297485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41P9T7rAOn5C903KcslM4I+TaCE2v2OwMWOr2r9y6yc=;
        b=qXY8M/WHY1sr8ZjGp8WPWHgYOAv0YFL5IHIkBKRhPgX947wpH1N8fooNnKDFMqFY9g
         tpOBP+we3r8Idox7SK74OwK7E+qPgvXNomswPZBpCBJsSJ+kOBUFdNNl6CrQZ7JvPjXl
         xVzKqRbYogGI/LucqXm/qztZse4P1hTm0q+11OgYKLPmAhcU50uQ3wD4wfE7AdqxT6yq
         nb5TJhQ7pdzFsWcSV8wjTeC36a52CghE7NbzkdcHXraH0+OY2uoicDnqdKqdbSiZjioV
         6m7j0RMysqt1eYIvUkCcsJj9jWXYMQBycCLC7ztd07R9OkKUucRNKRiEkT7A7gT6KGJm
         dI7w==
X-Forwarded-Encrypted: i=1; AJvYcCWeVdqEa7FbCooCyYQ3AH9whtCoRcMKVawj0S4So0yo4pH7xj+Q4nXtmaxPqd5pYAzqNsTqWo79UnQ0xkWypS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmSy58Lsbwal/nA3CmWV2+KYBnho1+xFG2wDxAmUaa7A1WiQ6
	HSCUejR8YSfsGdPduZioN6CLIl13FB/DSRwq2nd0vmTs2sldhuSxySzQf932NwPOJA5+Jmvchys
	X3VhKIyEx1S4UOfpzT9lgkWIFVJFQGuqsPPLh
X-Gm-Gg: ASbGncus+synsU8IT80n9JvfljJGICAswh2nlFPmHvOuj/TKAD6ThDRXzId7UiEEpsK
	gPxFRTPzQgqcr/v3k7yxcSqFGLor8dfC5sBVR+/9sXXlTnaV20tqUulSc+mw9yL50C7uR0ZJF/Y
	uy4ZET8aKvPjRPpivFSWwMC3g2T+sLmQYy+XCr
X-Google-Smtp-Source: AGHT+IFughb8ucHe5DsofFLYJInuUUcNg3DNnlqCne5qRA9aKO1ulCgbX8TUXLDOT+muClmgGU9fnGmggYJ9ApqcZz8=
X-Received: by 2002:a05:6870:d8d0:b0:2b7:c7b4:7df7 with SMTP id
 586e51a60fabf-2c178712c5cmr176343fac.11.1740692685142; Thu, 27 Feb 2025
 13:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-4-jeffxu@google.com>
 <20250225085728-24167715-8562-45a8-86cd-0ea503e4bc73@linutronix.de>
 <CABi2SkUwETzrBSYm0QV9+eoeo0kgA+r2JM4QaFpQqeTiidFEDA@mail.gmail.com> <20250226082701-9057b348-b074-488f-9aca-49ffbc78237f@linutronix.de>
In-Reply-To: <20250226082701-9057b348-b074-488f-9aca-49ffbc78237f@linutronix.de>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 13:44:33 -0800
X-Gm-Features: AQ5f1Jr2cfmQo_Z39J7t8YiLBoePGb9dDRH-76W5jrebQ_aLePoCE7SzRjIwf7A
Message-ID: <CABi2SkXwaJ=s3XqHKu1aFVfcacgxpQ5Ji1_BqaN+ch2i_RnA9Q@mail.gmail.com>
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

Hi Thomas

On Tue, Feb 25, 2025 at 11:35=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Tue, Feb 25, 2025 at 04:48:47PM -0800, Jeff Xu wrote:
> > On Tue, Feb 25, 2025 at 12:08=E2=80=AFAM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > > On Mon, Feb 24, 2025 at 10:52:42PM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> > > > covering the vdso, vvar, vvar_vclock.
> > > >
> > > > Production release testing passes on Android and Chrome OS.
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > ---
> > > >  arch/x86/Kconfig          |  1 +
> > > >  arch/x86/entry/vdso/vma.c | 16 ++++++++++------
> > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index 87198d957e2f..8fa17032ca46 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -26,6 +26,7 @@ config X86_64
> > > >       depends on 64BIT
> > > >       # Options that are inherently 64-bit kernel only:
> > > >       select ARCH_HAS_GIGANTIC_PAGE
> > > > +     select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > > >       select ARCH_SUPPORTS_PER_VMA_LOCK
> > > >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > > > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > > > index 39e6efc1a9ca..1b1c009f20a8 100644
> > > > --- a/arch/x86/entry/vdso/vma.c
> > > > +++ b/arch/x86/entry/vdso/vma.c
> > > > @@ -247,6 +247,7 @@ static int map_vdso(const struct vdso_image *im=
age, unsigned long addr)
> > > >       struct mm_struct *mm =3D current->mm;
> > > >       struct vm_area_struct *vma;
> > > >       unsigned long text_start;
> > > > +     unsigned long vm_flags;
> > > >       int ret =3D 0;
> > > >
> > > >       if (mmap_write_lock_killable(mm))
> > > > @@ -264,11 +265,12 @@ static int map_vdso(const struct vdso_image *=
image, unsigned long addr)
> > > >       /*
> > > >        * MAYWRITE to allow gdb to COW and set breakpoints
> > > >        */
> > > > +     vm_flags =3D VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXE=
C;
> > > > +     vm_flags |=3D VM_SEALED_SYSMAP;
> > > >       vma =3D _install_special_mapping(mm,
> > > >                                      text_start,
> > > >                                      image->size,
> > > > -                                    VM_READ|VM_EXEC|
> > > > -                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYE=
XEC,
> > > > +                                    vm_flags,
> > > >                                      &vdso_mapping);
> > > >
> > > >       if (IS_ERR(vma)) {
> > > > @@ -276,11 +278,12 @@ static int map_vdso(const struct vdso_image *=
image, unsigned long addr)
> > > >               goto up_fail;
> > > >       }
> > > >
> > > > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > > > +     vm_flags |=3D VM_SEALED_SYSMAP;
> > > >       vma =3D _install_special_mapping(mm,
> > > >                                      addr,
> > > >                                      (__VVAR_PAGES - VDSO_NR_VCLOCK=
_PAGES) * PAGE_SIZE,
> > > > -                                    VM_READ|VM_MAYREAD|VM_IO|VM_DO=
NTDUMP|
> > > > -                                    VM_PFNMAP,
> > > > +                                    vm_flags,
> > > >                                      &vvar_mapping);
> > >
> > > This hunk (and the vvar mapping in the arm64 patch) will conflict wit=
h my
> > > "Generic vDSO datapage" series.
> > > That series is already part of the tip tree (branch timers/vdso) and =
scheduled
> > > for the next merge window.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3D=
timers/vdso
> > >
> > > The conflict resolution is fairly easy:
> > > Move the new flag logic into lib/vdso/datastore.c
> > >
> > Thank you for bringing this to my attention.
> >
> > In your change,  it seems lib/vdso/datastore.c implements a
> > vdso_install_vvar_mapping(), then all the architectures call this
> > function.
>
> Correct.
>
> At least all the architectures using the generic vDSO infrastructure,
> which are the ones you care about.
> Sparc for example has its own implementation.
>
> > So merging conflict won't be as straightforward.
>
> Wouldn't it be enough to unconditionally use VM_SEALED_SYSMAP in
> vdso_install_vvar_mapping()?
> The symbol is a noop on architectures or configurations where the new
> functionality is not available or enabled.
>
Yes. That will work.

> > Maybe a better
> > approach is that I continue resolving all the comments, based on the
> > latest main. Then wait for your change to be merged and submit another
> > version.
>
> That would work, too. As you prefer.
Great !

Thanks
-Jeff
