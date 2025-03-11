Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3BB264F93
	for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741731189; cv=none; b=JXz5RGF+3q4uWqcGDW/HeElhs/6kSv4CoOYOEc6GdexQJgVzQ8HqvX2SF88qkq9myM8oTTqCV4D/e6yiGx5pGWphl/6X6DGRgFsingiN5KnDHtPK92Igk0fKWAu7lBmo610r3GxEITXqpOAZ1qLsPvR9mHlxmfDCkir1gL7h6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741731189; c=relaxed/simple;
	bh=/m2scfei2Ytzh5tu9Nw/wGalvCrzP8JZJmXDECgc3h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hp0UCh6RnxO/ttAzdNoqs16HX5pD3wHylAeo4zYz5X4BcmaJ2zvdt15ZlPG5I340/uE1Hw8hj6YB3FKpFgfwsmX3Tj/ZRspkdydBkIF/sUFrNqe71sZANV6bMjsUsBMAv5LSsma6TcYSpTKBwjzzD92e9Xa/S45wk/55pIr8+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZTDg1D0r; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZTDg1D0r"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72b7c8c8537so263786a34.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741731187; x=1742335987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gx/uI7Jj+LFnh/Y9Cm66/wk2fyG/s7LdrL3JXmhnGY=;
        b=ZTDg1D0ryFXRp5GlDcrzjKLGw6BJkINECL7kurvTS4XmJ7njzfSh7K/B61705i/pxM
         +ZD8R2Q49Jh+aJuHbMGx82FMNJamqH266JVhibaprjadjzF0t+YP5riTczhQsKf9mDdB
         crfTvajdHPqG229PkoR3+wmGs0dnk5iJEFWVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741731187; x=1742335987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gx/uI7Jj+LFnh/Y9Cm66/wk2fyG/s7LdrL3JXmhnGY=;
        b=prrnX7mXvjqdk6U7ayyydqiiQdbmkHeLyOgikBBJU+Z3Z25MuHm5Wg5YaRGH10vugS
         7eekGdn37ekLuxd6X4SFZMgVqjyt7GM4UaUt+zR2gdUphEUAUdp5ptb/1kwPNkAqU8f+
         yjOKs43VR62sHJvfCzcOi7Bo/suLTXkXi1u+MI6LEV2w2DhWuQbPgxpVH5ofpnL5QMxi
         JmWMXeyo/p/+jipnY9E0fLoxdipjpitwGYV7g4SGAng9iET3q1UxYnPiAOY4ZW7XDZsc
         pzQMAac1pLCHjec7eM4wBJcbd/d6fdZhjX4/fUo/L3Y4hhxmOTivKhvebaeQNNhg0+Sj
         Lqrg==
X-Forwarded-Encrypted: i=1; AJvYcCWevMCo0JchQ9qjmRT+yeQYqdyMUMcIsvLZ2Byn3LKf4G304Z7SaWzDnbfjpPAEWoAJAHm2Gn5tyfMyJ1Y9Rm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFs9TRX86B2YoyRv17laCW5u5UpQklPHtvo+PVTuaDmLCYM2MN
	LUckRYLR+hBd1xChGj1J3ypHvfVycCvmmw9xD4mCcbzNYOQQD+7GmQm2AjTMSguxvHZqSUakD9I
	hVQgf5Iy89MWzFqDavMc7+RZTXtCWvMdut3ESO7qgCUS+u/bbvA==
X-Gm-Gg: ASbGncs+BQ04jSv0umv4Nms8GxBM27pG7dYFRhiaegs55Ipyxx1FAuny15ILQB2v0Oq
	SaJKJeBRM/zxjyp3lLnUB3VsKr4M4epRE5rWpVfPJ6zaS2FX/CCIVJSGNTEAuUqnxmewcvBgAu8
	kJu6qRJuMb3vFvpmyRylZ6FpdU
X-Google-Smtp-Source: AGHT+IF6cHOCc1/WT6rYQME8ZwTzRijq4TF0n6zKoV4EldL5MeMYHAbxupldljEVnQ7QDui54Qopy4486X05dA/Olqo=
X-Received: by 2002:a05:6830:3808:b0:727:32f5:df87 with SMTP id
 46e09a7af769-72b9b51ba95mr1072927a34.4.1741731187229; Tue, 11 Mar 2025
 15:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311123326.2686682-1-hca@linux.ibm.com> <20250311123326.2686682-3-hca@linux.ibm.com>
 <CABi2SkXWD4Pg7Y7TG9fMV9eat_1fOGwHjvEUKHXREN+pRe18NA@mail.gmail.com>
In-Reply-To: <CABi2SkXWD4Pg7Y7TG9fMV9eat_1fOGwHjvEUKHXREN+pRe18NA@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Mar 2025 15:12:55 -0700
X-Gm-Features: AQ5f1Jp67jwM-684SO1tDeImf4lP5e9Q1ZLCVvcfHKRXZQkMxKgJL8mewS-yfP0
Message-ID: <CABi2SkXzqJ10NW3j1y-FtmrheDkqzL5QgMcN9UN6UvhbXFHCuQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 2/2] mseal sysmap: enable s390
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One more thing: do you want to update mseal.rst to add s390 as
supported architecture?

Currently in the mseal.rst:
 "The following architectures currently support this feature: x86-64 and ar=
m64."

Thanks
-Jeff

On Tue, Mar 11, 2025 at 2:55=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Tue, Mar 11, 2025 at 5:33=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com=
> wrote:
> >
> > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on s390, covering the
> > vdso.
> >
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/Kconfig       | 1 +
> >  arch/s390/kernel/vdso.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 608a965e2344..93b880992596 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -141,6 +141,7 @@ config S390
> >         select ARCH_SUPPORTS_DEBUG_PAGEALLOC
> >         select ARCH_SUPPORTS_HUGETLBFS
> >         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
> > +       select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> >         select ARCH_SUPPORTS_NUMA_BALANCING
> >         select ARCH_SUPPORTS_PER_VMA_LOCK
> >         select ARCH_USE_BUILTIN_BSWAP
> > diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
> > index 70c8f9ad13cd..430feb1a5013 100644
> > --- a/arch/s390/kernel/vdso.c
> > +++ b/arch/s390/kernel/vdso.c
> > @@ -80,7 +80,7 @@ static int map_vdso(unsigned long addr, unsigned long=
 vdso_mapping_len)
> >         vdso_text_start =3D vvar_start + VDSO_NR_PAGES * PAGE_SIZE;
> >         /* VM_MAYWRITE for COW so gdb can set breakpoints */
> >         vma =3D _install_special_mapping(mm, vdso_text_start, vdso_text=
_len,
> > -                                      VM_READ|VM_EXEC|
> > +                                      VM_READ|VM_EXEC|VM_SEALED_SYSMAP=
|
> >                                        VM_MAYREAD|VM_MAYWRITE|VM_MAYEXE=
C,
> >                                        vdso_mapping);
> >         if (IS_ERR(vma)) {
> > --
> > 2.45.2
> >
> Great ! one more architecture uses this feature.
>
> Reviewed-by: Jeff Xu <jeffxu@chromium.org>
