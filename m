Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C11917F0
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942088; cv=none; b=Bip1eDiLPAGs9tFoZPehtgl59rLJXjklG6e7NxaYToMRvicNa7VFaH33qkw4Q2AHDeMrugo7CIosBNrHsGpGb++516DwTLVQ73hFf5NU8o9y6Gh29KuZp+tvPEBwKTFm/n/N/iiB82TuckWrjx69D2G+P1AXBeEhGO5bGdGCXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942088; c=relaxed/simple;
	bh=2e9dxxABc/1erTn/e2ryhI0NWvYiQdiajCEV5LoHNZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7EU461T2WxwjKTwgplII7B+fdWRrEBfAaHcWQlJrJGAhSMaxiIkGKioRuvRMUD0NcgpIOEnF8UbQu0RCQ2dhDHYtslt5GoA33w8MNcZRIgRIWDkxu3pVkoLM0TjraLe5y+xTFFqS7GZqVFn7iChTIYwB+SjFLny03JRcZ/NDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q3FLonyK; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q3FLonyK"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27080e75bd3so79747fac.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 07:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724942086; x=1725546886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJvOS0jrrStCn1p3egyXOQWxbnH6JNr9A1VShqqaYTk=;
        b=Q3FLonyKQ3S/vr/g77Ih6pxFT6s3WObQxmFCq3vMdw1o7UpCllr6bfGjX489/k02+S
         zocQZC1Ubm7BTLjNdG9C8QPiOlZBYEqv2LvNUPxhvt6giHIvit0dq/kc5dohAllcnSWY
         +P7PUGcpAAqM/q3PvbMwxIK7ycFs43UJZj1/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942086; x=1725546886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJvOS0jrrStCn1p3egyXOQWxbnH6JNr9A1VShqqaYTk=;
        b=DquUSfq1l0X3jB/NQy+vJ2m8JCX7prjzpbAfWpN1Y3LD1mACgekPOv9I1xn730jPWV
         /OKHOfSoRnjwBtYQR2ZFhQcksZSi6G6IBhFlqEmXljLLsVGeegKNWmReqFpK4xPz2Ndh
         Mp3Os8CzGuj38EQSylS2XnB+nkbpK7zjlwz4GtdXP0yj2ypvvaYB+ky8P++6GFjD5LBD
         xlqFWNvKdT3cC79hafBB6y6U8vCRsDgX4MLN4ltCyGaXcZK9XnI7uCdYmybS5ugYEEe4
         bWgfJ8ZiptKhT+qMpVZfb62GEomRF++ZQYg7dN6Q2c4ikYp0oDpT9F+vVv2aOaEtDYZ7
         ah7w==
X-Forwarded-Encrypted: i=1; AJvYcCWAD8uVdZ5BrxTjtfL4ilG69JpfDwRtvuOhJH27SBTyCYOc6zY0JpoUToEzOk2P6X4Sc9SH5UiEHDb+0MuO8X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiEGFHmiG2SgAL1jlIZeEF7sukxJEZB5PLhGK2BqjW/6J29xY
	RuDgcI1bfxPof0sx6WOUVNnRPx0NlruyIP4Fjha4O5jUDwx9heHgP1qYt98b1sSDinxiupBx2kw
	vjdTG0Z7soJnqGl8O15P680AmwmkdGoPnwx0SWtDuxSQNDV4=
X-Google-Smtp-Source: AGHT+IF9LGbiJFVqc1DMjTkah3A1+IPMe1eJBsBwTEaX1TwXJ7fiM5f3el5JFuGiTRRorOR2mHIY3H7LZkeJi5v8rJM=
X-Received: by 2002:a05:6870:d623:b0:260:23eb:5669 with SMTP id
 586e51a60fabf-2779007fb72mr1759062fac.2.1724942085649; Thu, 29 Aug 2024
 07:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <58e47a2e-6556-4a41-9fe5-1378f5257534@lucifer.local>
In-Reply-To: <58e47a2e-6556-4a41-9fe5-1378f5257534@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 07:34:33 -0700
Message-ID: <CABi2SkWkdHErmp3Fjx+_aZXr=V3gBKfE8Nk9ESfB32N+FMCpog@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, 
	rientjes@google.com, keescook@chromium.org, 
	Liam Howlett <liam.howlett@oracle.com>, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:09=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Jeff... come on now.
>
> Please cc- the reviewers of mm/mmap.c on these patches - that's me,
> Vlastimil and Liam. Same for mm/vma.c, mm/vma.h, mm/vma_internal.h.
>
sure, that was a small fix and I thought introduced by Pedro's commit
(which was wrong)

> And it seems like it should be pretty obvious you should cc- Liam when it=
's
> quite literally his code you're changing!
>
> Relevant section from MAINTAINERS:
>
> MEMORY MAPPING
> M:      Andrew Morton <akpm@linux-foundation.org>
> R:      Liam R. Howlett <Liam.Howlett@oracle.com>
> R:      Vlastimil Babka <vbabka@suse.cz>
> R:      Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> L:      linux-mm@kvack.org
> S:      Maintained
> W:      http://www.linux-mm.org
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> F:      mm/mmap.c
>
> On Wed, Aug 28, 2024 at 10:55:21PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > mmap(MAP_FIXED) should return EPERM when memory is sealed.
> >
> > Fixes: 4205a39e06da ("mm/munmap: replace can_modify_mm with can_modify_=
vma")
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
> > +             if (error)
> >                       return -ENOMEM;
>
> Can't we just return the error here?
>
> This is one for Liam, but I'm ostensibly in favour, this does seem valid!
>
> >
> >               vmg.next =3D vms.next;
> > --
> > 2.46.0.295.g3b9ea8a38a-goog
> >
