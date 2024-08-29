Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95167433B1
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941994; cv=none; b=IL7M+tDHIOfrYJP1A81QmlT3fHzYxb+SiLr8pnX8kjGlw1lS2iP7FcIuQMt9mlSAQ8yvVMaJlmiWm2TR+MKits0SaEGBLwkB9c+uVe+Gf0x+V9s6V6DzD1CDegTta9R190vuONmiHq75OVMHF/wWSnNfERdyfI94wdHCRIN4Ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941994; c=relaxed/simple;
	bh=QCvqAFnGFMNbSVCxX5lIIRujCTMnziArQz+X1SNf3gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpQmiPLYcJJ2q+0974k5u1DRyz3GFGvSmxpjaDhqwZf7dxsnz4vF0/4kzVxifNhfBbxBLe5z3AaiNUd6y5xWpwHCDJ3Or7cc55Tgsz6J60D9m9Np/bYQAgSNZdL2fbpMAOzGPkWJLBc0AcOxj/2F3o377608bZH6PAyGgHNbURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HHMoWu3m; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HHMoWu3m"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-26ffc596adaso77061fac.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724941991; x=1725546791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbjfLJ2fqDDhqtUpB4c2guraSJR6Tgu7wwzcqEJUoY0=;
        b=HHMoWu3m+2932ShGnBrz27f35dpBlXeGlWvS7K6orNHtFeszLxMCkJgbvZJHaMDyo8
         cLXTIo5piZdpkTY8ghXGeU8e6f2m7uTwgZhYPHU1jesiqh+iTFT/y1leXDUl45P0p6tQ
         OBrGr0sAdRRNPGQ6fDra3ZkOr0afIoxAwGF8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941991; x=1725546791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbjfLJ2fqDDhqtUpB4c2guraSJR6Tgu7wwzcqEJUoY0=;
        b=t70iXQjb/OgXrfQNkDQZ5hBN4/93hJVmVJxBiHBOtJfRTAIiIydCHqlXAiQiclLVqy
         oHXqCdkHUGdxqV9fTv5YW5CRKPbKwW80Wqi5GVVeaxXzVC7KPn4oDKRNZQkSxObZuVIC
         BJtLxu7Q1MMRhANRuW1mtvA3yhsZAiRf7WRLXOMkmoA4helga8kbQw12G6rQo4pvO9uS
         YR02DC8Y27ieE42XB0n2Jkyw6Hfl1S8HLS25ruW4kYmmF2IGcDVUHpjVk9dFEGBRCPEp
         5RjohPDfTNCzpUCsNBPYJXLzK0VpS+myte/cVw1N4TgmjgCGmuP4qXA6JT8D1WdE5qOq
         7Yxw==
X-Forwarded-Encrypted: i=1; AJvYcCXNaKk66b/4wWvPBbUPGo4oh1SEJH06u/kD0webxEupMRif45VWkZaIGHYL2YTdhavx79GGMi23X/1sJVdCrAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoaMeg3+fh8C76XcJ5Vndh94LG1riIhzmFak1cQuy6zjAq/Lo
	l7CXoewf0AWb6wauRXKxszd5oCNsCv3yeXtqeVhbipaeVzLpYi8niFXgQvdvZkjEPvIaoQWeUkm
	d9dCU8s8Q14M0KJVJT47JYPPKUjhDITo90Vv+
X-Google-Smtp-Source: AGHT+IF7hEs4r13r9Gs1wT8QNsV78DzGrCss8ANs+XXz5eK3kud3soytApHKrEVu7yGI7fuxaztQAt7RmbjOdNAlsjA=
X-Received: by 2002:a05:6870:a70b:b0:260:23bb:1087 with SMTP id
 586e51a60fabf-2778fd5b726mr1752368fac.0.1724941991020; Thu, 29 Aug 2024
 07:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <jxov546uro5lffibw5asff3m25pfnondbp3nrqc3fde322h3on@ypkdkju4xaho>
In-Reply-To: <jxov546uro5lffibw5asff3m25pfnondbp3nrqc3fde322h3on@ypkdkju4xaho>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 07:32:58 -0700
Message-ID: <CABi2SkXxkzypPiXpjk+fuXBpdgkpCWD=z-Rzk=zFbSkY7xON1g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, rientjes@google.com, 
	keescook@chromium.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 4:38=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> +CC vma reviewers
> On Wed, Aug 28, 2024 at 10:55:21PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > mmap(MAP_FIXED) should return EPERM when memory is sealed.
> >
> > Fixes: 4205a39e06da ("mm/munmap: replace can_modify_mm with can_modify_=
vma")
>
> Thank you for the patch!
> This Fixes: is wrong, the bug was added during Liam's rebasing of his mun=
map patch
> set on mine.
>
ok.

> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  mm/mmap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 80d70ed099cf..0cd0c0ef03c7 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1386,7 +1386,10 @@ unsigned long mmap_region(struct file *file, uns=
igned long addr,
> >               mt_on_stack(mt_detach);
> >               mas_init(&mas_detach, &mt_detach, /* addr =3D */ 0);
> >               /* Prepare to unmap any existing mapping in the area */
> > -             if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > +             error =3D vms_gather_munmap_vmas(&vms, &mas_detach);
> > +             if (error =3D=3D -EPERM)
> > +                     return -EPERM;
>
> Not sure if it makes sense to special case this. We should probably deal =
with this inside
> vms_gather_munmap_vmas and just pass through the error we get.
>
> Otherwise LGTM. Liam?
>
> (we should also squash this into the offending commit)
>
> --
> Pedro
