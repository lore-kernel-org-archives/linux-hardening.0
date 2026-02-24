Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4C2FF14D
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973042; cv=pass; b=IyabRa7EFnVEnps11yPvq9qougMenlr2TNTfzy7pUb3oPtIRE4g5KLNIv1YYYyWA3mX9bOeghoJH2b5fafNG9OHBD7kD9Gs6VEeLTScMB9b2foN5b19H9l5bX7B6hOq8X5Om5aASZXi+PegV1yvy5QbDVGdbAbqNJDu1bvgJExs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973042; c=relaxed/simple;
	bh=tysxSzwdUN/518teR6EyjcfeA3JpqziUCBr4+JhGLkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvxJiykwISDyPfffebAHAwiRYW/n/P6qbr/okS4NX1ZQAR+NRIDC4PYLy2TaPas/fQposFqn3YM6CG1J3X84kbBJ48U/CaI7BA4XNDIO+GWroYa3NtLfrEErnomRAaCul64m2zbe5OMUqcXA00Uc81cHPj/VYISuq1vPbrYbInI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BaXKsn2; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BaXKsn2"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124a635476fso5781291c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 14:44:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771973039; cv=none;
        d=google.com; s=arc-20240605;
        b=arX/CkHcpwlHX+zRunQty1bSBcEx+ozpecD2Od1BJ+jQG+dOyYKg/texOWtlpWq2kf
         R1w6QRl2YSyoSO9RvYK+MYy+xqEIJ8c82ZCKFEIvoLO3JqkgBuLminzxW9Rjlngbrbqf
         GzxqEy+FgPMK+BJRmcMwe/SLsIB9FnqWflvBgJDLVaUvv8nEzitAW+YT0Cc8zVnX6kHk
         lpRIaQV7eMhEg5Gn2hRdyrkKHoDSx3Zs/Wf3RAc5g/7KNOZI74hB3cO+rDZnc87K+Vqz
         9tirfzjD0YMM70OeV+HcZGRf4uO232n4QbcMlziffM+agKsedoXYe2p9VnJbeuYnj4xq
         Udeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0vyzXs6Nuf3YPypneYs9PIt3O29SiUmlFmPJ2dtgRHo=;
        fh=kGbPOfAjgD2I2p5NjEJP6IxNrabaJF5eDO9beTQ8aLQ=;
        b=LaSbyeTstCrQ1mgwrHZvwtCeEcu2YxP+8nbj6EoENztNa6mfxm/6kVCHcLPbKA0L9n
         JTRnZenYV3hLw/rv6aNCtaboRheJPA/SDcwEgkmuQCxdwMzto4J1cyNghljtn3UkHVGz
         crphnVBaSDWzNl+y5xfJRstp29M3AgHVEWnuaeB/qJUYwPoqPkddqudTMVoaB5UjC9qC
         wXf8/gUAzAkYirycuL0TrvhMayMe3PKUWz0tt9XxrwG9LGrEBdrbTb7vYE0E5OcG9/Mb
         OYDjzP7Ijd23bPU/rEyzMVa/c57EvJD0U+d4/I51TCOUEIKb4ZYz6+3oHsgzB+ZDrBlY
         iP2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771973039; x=1772577839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vyzXs6Nuf3YPypneYs9PIt3O29SiUmlFmPJ2dtgRHo=;
        b=1BaXKsn2VaTCfMOCT0m2y2m5Xt8drA3V4QiQzOc6mOR0ujDvNcSMixL3BivY1r2YlO
         bSKa45P9L/IfNOIKf+AQf3GIFRT8zL/FsdBG3gwRY9s+PCVEQVMkyjumOcruIrD0GRrd
         EfGoNOvqsA/ivRTjpHHdjVZHZxh/X4uxtl/7cnROFgjNgI93wye8eSlSbWnBCpHIqs22
         nQ2KCTU3/6hZnPTG4O5K7BxrOcHtWPMLTm07NJ6lsPfWAlGDq3Dh7XWZ77i157ofFm/P
         WTrxJknE3WiePC1y1oO1soP+w2PVdBq8iNmDa4scP8u0JWlLH6Rr8JHzsqmubUenBj35
         jRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973039; x=1772577839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vyzXs6Nuf3YPypneYs9PIt3O29SiUmlFmPJ2dtgRHo=;
        b=VbmhC88sHGxroBlL/HDwwxFU+pjJs8lbZ0zEHChufbpQ9Z9iMa6X4ewv4QfPmhXLId
         1xl7/quVxlchANJ8e/i0gamlFt7/udNgl233uCViv6yc/CWRONofFUWwwZj0Ho1LEtw+
         +YAtBYxHk37u7BEobplcPvFIN8XVvZGGz5Cl7mhqFKyVo5WJeV3z2+Iuv+MVYfJ9uew4
         VTVMrRAOMTVioKEiJappHhh5GEuN7ykaVy3cld6cJWyST7ttmRcCpS71ZDCqZa8bYaj6
         HVE4dDP7pY/NpimthBSZRxQP0N4vJWQEclEvAjUkej51XIAru+1h9TQYslRHzXERN4Br
         2C+A==
X-Forwarded-Encrypted: i=1; AJvYcCWC3wyuvEUtnpFCl9OqbeA+ZZnypG+9kuUlpj74reGC7rmptelEDycBa9X4S6NqkDGEq0mRroDy7L7+fYjSqFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuNdcfTOd+E7hNC6LpmaHTSIVX7sxNBXO+u/2gEry4Nyd5UPpb
	0kLcnnEmRllP13igD5gjnnEnroNpOl5sCVILMUi3wnbszDTV4wGXaEaBqIE8Oxqt73R4Zq3xGfW
	tyN/PXw7zxwYMztRZ/7ipT2eP10/Yc5jNUD+l+wli
X-Gm-Gg: ATEYQzzQfRJO8hOKhYo6bwolQQ1YeW2PPZYuJ/O5HC3AqEz7B9KsE+KJyOmg0Q2POwz
	Bw/3rhr9ZfAiKcM5RcRSS1IZbCL11zziJbmTTGNplhobLRv/PWUWK3gu27z/7k2rQbHuvOL4zvg
	ZGBu8+8OcE39i2+RoD73RfyPrha9lIOlaRwD2DpP303TtneTJzCoE5Cjq6zB3RfC9iCUEefM310
	jxcRtBp1+V4ih2xk08w1kdlSq2lnBXKKl7NlPhdpiUfsiSLoDc2O6iYXAh2DR9H/0echkoUt2aO
	R+iMB1op/CIyPoU4gn3111mQG2Rz/ReQ0xYynw==
X-Received: by 2002:a05:7022:128d:b0:11d:f44c:ad97 with SMTP id
 a92af1059eb24-1276ad11a13mr5314920c88.24.1771973039031; Tue, 24 Feb 2026
 14:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223222226.work.188-kees@kernel.org> <CANpmjNOpXe7tCP7tyR04Hm+a8zdiBWWQdK=US-qTL31mm+Yzkw@mail.gmail.com>
 <202602241316.CFFF256ED6@keescook> <202602241440.1D885B8@keescook>
In-Reply-To: <202602241440.1D885B8@keescook>
From: Marco Elver <elver@google.com>
Date: Tue, 24 Feb 2026 23:43:22 +0100
X-Gm-Features: AaiRm530nNUyIcHEvt2U9h7SlrZ-STR58Elq_z7lf5SVlQwk7vDX4kQaD1idsQ0
Message-ID: <CANpmjNORUfQEVimGFwJtxsuae8VhimHEFWZUnqvtTZ6dC3_o5A@mail.gmail.com>
Subject: Re: [PATCH] kcsan: test: Adjust "expect" allocation type for kmalloc_obj
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Feb 2026 at 23:41, Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Feb 24, 2026 at 01:48:51PM -0800, Kees Cook wrote:
> > On Tue, Feb 24, 2026 at 11:09:44AM +0100, Marco Elver wrote:
> > > On Mon, 23 Feb 2026 at 23:22, Kees Cook <kees@kernel.org> wrote:
> > > >
> > > > Instead of depending on the implicit case between a pointer to pointers
> > > > and pointer to arrays, use the assigned variable type for the allocation
> > > > type so they correctly match. Solves the following build error:
> > > >
> > > > ../kernel/kcsan/kcsan_test.c: In function '__report_matches':
> > > > ../kernel/kcsan/kcsan_test.c:171:16: error: assignment to 'char (*)[512]' from incompatible pointer type 'char (*)[3][512]'
> > > > [-Wincompatible-pointer-types]
> > > >   171 |         expect = kmalloc_obj(observed.lines);
> > > >       |                ^
> > > >
> > > > Tested with:
> > > >
> > > > $ ./tools/testing/kunit/kunit.py run \
> > > >         --kconfig_add CONFIG_DEBUG_KERNEL=y \
> > > >         --kconfig_add CONFIG_KCSAN=y \
> > > >         --kconfig_add CONFIG_KCSAN_KUNIT_TEST=y \
> > > >         --arch=x86_64 --qemu_args '-smp 2' kcsan
> > > >
> > > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > > Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> > > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > > ---
> > > > Cc: Marco Elver <elver@google.com>
> > > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > > Cc: <kasan-dev@googlegroups.com>
> > > > ---
> > > >  kernel/kcsan/kcsan_test.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > > > index 79e655ea4ca1..056fa859ad9a 100644
> > > > --- a/kernel/kcsan/kcsan_test.c
> > > > +++ b/kernel/kcsan/kcsan_test.c
> > > > @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
> > > >         if (!report_available())
> > > >                 return false;
> > > >
> > > > -       expect = kmalloc_obj(observed.lines);
> > > > +       expect = kmalloc_obj(*expect);
> > >
> > > This is wrong. Instead of allocating 3x512 bytes it's now only
> > > allocating 512 bytes, so we get OOB below with this change. 'expect'
> > > is a pointer to a 3-dimensional array of 512-char arrays (matching
> > > observed.lines).
> >
> > Why did running the kunit test not trip over this? :(
> >
> > Hmpf, getting arrays allocated without an explicit cast seems to be
> > impossible. How about this:
> >
> >
> > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > index 056fa859ad9a..ae758150ccb9 100644
> > --- a/kernel/kcsan/kcsan_test.c
> > +++ b/kernel/kcsan/kcsan_test.c
> > @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
> >       if (!report_available())
> >               return false;
> >
> > -     expect = kmalloc_obj(*expect);
> > +     expect = (typeof(expect))kmalloc_obj(observed.lines);
> >       if (WARN_ON(!expect))
> >               return false;
>
> Or:
>
>         expect = kmalloc_objs(*observed.lines, ARRAY_SIZE(observed.lines));
>
> I think the quoted cast is probably better...

The cast is easier to read (no indirection needed to understand it's
just allocating same size as observed.lines).
