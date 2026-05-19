Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14F48122E
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185152; cv=pass; b=OQomuOxTNOcMrYvcJehGBJQHJuKdYyGZ09RaeZhwK0m7xNz3W8P8b/85PHxS/D2icGLDrGpw6CyKSwl4H58SZGvJKCE/gebhjDXXq9H+FbklAHvBXUHUcaeJL8P363PbEf1EQbxxT9wcUYisu0L/oU9kJmwVh8oVvEbqB6ExLUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185152; c=relaxed/simple;
	bh=czyUKy/5TRWEYZwJjc6/HYigu7VtwCQiu37oSpPfG88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE7ucmgcyjmAAgNmMj39Vfe1uMMhgt/z+SCsvEBOi9BAjJ63RRXfGHac2EFfDNrRqi2iMo3mv8KRnoDKyaoSA6cH8CU/mMRcbwu7fEfXLAELqbRMsqODmhf4h153tHuZhACsypmM9NqI+U8OoAOaYwQrDgeobQ1Si3/sPQYE4DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAMvRBcC; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAMvRBcC"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44c350a5b87so1975351f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 03:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779185148; cv=none;
        d=google.com; s=arc-20240605;
        b=ajffYklWjPyERJHJigrp8UW4KpaILZWn6i6WUnd7LIp2LYmqIhzO/lJOQ+O383pfdO
         Gfli3a+7VuH29YIOMBcvcah1HiFUvuOoccX97zD6L+5sWZ6VaVmzEhDWT8mREFxKRfGp
         JOPk24rM8SIfBx71O/R//SEMpqrjqtEKjCXV6k4L5OisowwsFogPS7800hDFZP/7BpfZ
         Tch7HJFJS6YoIwQIBjObxqQuULo8pC3th2wrPED5DTk9RZuNay8ij+jVDcfzp0dSNTsk
         cHZ04GKox2Xiblh0qABu8iFInqwwEBVQZnF/G/Z5PkqOzA4DJVi6UxBWUJTfX0e3SnZy
         Y0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RiYL6/RjiqiIsp067U9+dXVTX/+7ETKrZ/JSTHkELaY=;
        fh=6E6qXZ4pp3jkuT88P3+G3poRg130D3r58aDe58DX4Xk=;
        b=QUqD2uQMft2cBwFkIqqDGWGqxwY+Myz74kqJ7PxOABAG2pSE2EX3rl4BKx1IkFdxVh
         1FhcC32iwEKYPSupZoJhCPdir69OJmjyBVUezyblxLtDdDgdk+Hkv6zZ4Nm3CVhMVCf3
         0/NMbk2Cpw3RHfRT7qRtGz+ImCAqITdgJeKtld7FTivAHWuZvIwThMmp5k5seqOouYat
         TN5o89A0la/VsSbjx4R9XjyI8A+l262KNRH5GJr3LGrAuYsuW11KyGehWTdAx+v4ql6I
         qL7pCGuFDa5rsOJJz6R3FDC5G6Q07jT4TtY66jEiqrFSl2Umw1mEz0jNamp1CVbtdk1x
         eGlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779185148; x=1779789948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiYL6/RjiqiIsp067U9+dXVTX/+7ETKrZ/JSTHkELaY=;
        b=IAMvRBcC7KgDVLtKWKI4ISN4eoS0ZjDPL79AexCe/c+r27PAdyN0x4u0I74uCq9seA
         DSSGiqsjKnspvetARzkTs2IErDsUBGILVDOOYv5XaJteVxLswnn4xC4pYhXNZZiOtrzk
         qEtSy7fw1V7AAmmrdMhZKUtf0HH1jRaDC2TUnLTJFaNSse1qc7j2UmSTPqpwCf/JRayX
         +d/EYPH8bZr7TOVnGUaprz0L+5hC017w9wapEVuKd47n/raWnUAXRhFtnh+h+/csOTg4
         tXvfn3qce/LnONJ/0fY2zKFoIcGtZJPuSEIoggNHq3hw0vRGVnKsKMj7yAn3x8uIZwRt
         hPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185148; x=1779789948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RiYL6/RjiqiIsp067U9+dXVTX/+7ETKrZ/JSTHkELaY=;
        b=mygi2YtV6BVqgqIcQhb/Lp6VgrNhx6CUCVVsf0lBPuxLQL/arB78U/Uh18vq5qU/ck
         QhLvesF4tSLrFirwpvzWHZWBoWj76o6x2nYKk5z76FG96vBarSw3G3XVHFLsjVfyhN87
         K15JvjcB0Cw93wXq/voe4iKI4q94dpfYHJw6fdAbLoLVWBnQ0+s23QzwReyPHDtacDOq
         pnY21I9MsZiiNDkuGAsVBKcR4yMndg+YAILPjV1DeBOghoX6+TSluoU9Db6CVu5eM+gp
         Y5zZmU+2y5+tupMP89/nnvAIqnj8yXGQQv9G5yGFmVEtKlUFF7lLWiX/1T8ECZpJge2I
         biew==
X-Forwarded-Encrypted: i=1; AFNElJ9aLM74JmMadJEVSV9asSF6PymYCj1SM7zd0mgMSFDHFQXk0ctfkT9OfxHdfZ7cqv9pQpG6sqv9iIfSSPxgko0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypB1pfdGWaOJd4MXap9N05HaLwrI3RDmU9JsYWkl5/dTM3N1v7
	JR1JldD2MTLpg7SgQ/NMkzj3MNnVmuJF/3b19O+i7KSacwr4yV/JIpkOp2/pJqxZ5Qj04wZ+EOO
	Wzo+8ToAbUdLdzKwUmHwn3fAxIaSSENE=
X-Gm-Gg: Acq92OF5B6L2WZtETzehAdM8Bnt9cIbSvw++qGq34N2Jzds3FeyQah4hrFyqPgovpkv
	VMnld/ot2u+kPdvvTmSHx+eC5b0jw+fbYpFb6uXTeKfF3WjYo3yvHro1uBrbhrZqQQPWemcI+Kd
	nL/gNm5J8T7dYto4Cnamd8Gq7TTIHgcC3gXKfq6Ow/88tsGu1tufiBVpF9V5yBJPI9vVp2X1789
	dG+NF5MRd6cCsFlwbcg5QcoMC9sUR8TmEZX59a4ciHHfzamjPxAvSCDhqh/jK65Gzbwl5OjFIu6
	7ZCEVCGlEFhgm2EE+qc+yT8HOVi1Yul7G367gW2fU1s6u48SlXtRwsZqeUfRZ1lZa2b8hJOHUK+
	57cs=
X-Received: by 2002:a05:6000:1787:b0:45b:d5d7:1f59 with SMTP id
 ffacd0b85a97d-45e5c5e3282mr30988684f8f.24.1779185148172; Tue, 19 May 2026
 03:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com>
In-Reply-To: <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 11:05:22 +0100
X-Gm-Features: AVHnY4JoB4T1br5m3mLltNKq-ucASMJuVjuTIoj0NffHxkPFdgR_H0jzHgpPrWU
Message-ID: <CA+V-a8t5NZP5QamrdH2-ViMcShcYh3czLsZ+0kkD_kjUodjTyw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: Fix __counted_by handling after
 kzalloc_flex() conversion
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, May 18, 2026 at 12:08=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, 13 May 2026 at 22:13, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Fix logic issues introduced by the kzalloc_flex() conversion in
> > mmc_test_alloc_mem() due to interaction with the __counted_by
> > annotation on the flexible array.
> >
> > Bounds-checking sanitizers rely on the counter field reflecting the
> > allocated array size before any array access occurs. However, use
> > mem->cnt both as the allocation size and as the runtime insertion
> > index, causing incorrect indexing and potentially invalid bounds
> > tracking.
> >
> > Initialize mem->cnt to the maximum allocated number of segments
> > immediately after kzalloc_flex(), then use a separate local index
> > variable to track successfully allocated entries. Update mem->cnt to
> > the actual number of initialized elements before returning or entering
> > the cleanup path.
> >
> > Also rewrite mmc_test_free_mem() to use a forward for-loop, improving
> > readability and ensuring only initialized entries are freed.
> >
> > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/mmc/core/mmc_test.c
> > +++ b/drivers/mmc/core/mmc_test.c
> > @@ -316,11 +316,13 @@ static int mmc_test_buffer_transfer(struct mmc_te=
st_card *test,
> >
> >  static void mmc_test_free_mem(struct mmc_test_mem *mem)
> >  {
> > +       unsigned int idx;
> > +
> >         if (!mem)
> >                 return;
> > -       while (mem->cnt--)
> > -               __free_pages(mem->arr[mem->cnt].page,
> > -                            mem->arr[mem->cnt].order);
> > +       for (idx =3D 0; idx < mem->cnt; idx++)
>
> for (unsigned int i; ...)?
>
Ok.

> > +               __free_pages(mem->arr[idx].page,
> > +                            mem->arr[idx].order);
> >         kfree(mem);
> >  }
> >
> > @@ -341,6 +343,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsi=
gned long min_sz,
> >         unsigned long page_cnt =3D 0;
> >         unsigned long limit =3D nr_free_buffer_pages() >> 4;
> >         struct mmc_test_mem *mem;
> > +       unsigned int idx =3D 0;
> >
> >         if (max_page_cnt > limit)
> >                 max_page_cnt =3D limit;
> > @@ -356,6 +359,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsi=
gned long min_sz,
> >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> >         if (!mem)
> >                 return NULL;
> > +       mem->cnt =3D max_segs;
> >
> >         while (max_page_cnt) {
> >                 struct page *page;
> > @@ -375,23 +379,26 @@ static struct mmc_test_mem *mmc_test_alloc_mem(un=
signed long min_sz,
> >                                 goto out_free;
> >                         break;
> >                 }
> > -               mem->arr[mem->cnt].page =3D page;
> > -               mem->arr[mem->cnt].order =3D order;
> > -               mem->cnt +=3D 1;
> > +               mem->arr[idx].page =3D page;
> > +               mem->arr[idx].order =3D order;
> > +               idx +=3D 1;
>
> While looking rather ugly, I think starting with mem->cnt at zero,
> and updating it in each step like
>
>     mem->cnt++;
>     mem->arr[mem->cnt - 1].page =3D page;
>     mem->arr[mem->cnt - 1].order =3D order;
>
> would still be better, as it makes the dependency between mem->cnt and
> the size of mem->arr[] clearer (located closer to each other), and ...
>
>
Ok, I will start with mem->cnt at zero; with this I can drop changes
in mmc_test_free_mem().

Cheers,
Prabhakar

> >                 if (max_page_cnt <=3D (1UL << order))
> >                         break;
> >                 max_page_cnt -=3D 1UL << order;
> >                 page_cnt +=3D 1UL << order;
> > -               if (mem->cnt >=3D max_segs) {
> > +               if (idx >=3D mem->cnt) {
> >                         if (page_cnt < min_page_cnt)
> >                                 goto out_free;
> >                         break;
> >                 }
> >         }
> >
> > +       mem->cnt =3D idx;
> > +
> >         return mem;
> >
> >  out_free:
> > +       mem->cnt =3D idx;
>
> ... as having to set mem->cnt twice looks rather fragile to me.
>
> >         mmc_test_free_mem(mem);
> >         return NULL;
> >  }
>
> Regardless, as the patch looks correct to me:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
