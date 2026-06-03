Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6D3ED5BE
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456735; cv=pass; b=osJa54glSjDIHlh3wgtz9HFXU1Eco61nOCRvsCTqhSJOQYKe4hrd1t7JPw0Jn5NiKDzoM8QMAvna9COYYFmdj9zZIM9XLomGx7EKbHhOoDxmRGx2Jr/mXdaygK2E3Ax7xqQHKJWr/KL/gRrL+59w1BFme1bT7lcY6846e+WABmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456735; c=relaxed/simple;
	bh=ha2VCrWzIkljoakXF75qVN/CWb62OxPoMCU95MR8FAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpfSzFsRmXpUjAh/BjP/Bd6JIOmZDMOzFaC9BXgvoBctERt8L2ckze44fiWTm9q74DgjMy4Tjvpy2orryqugxy/HqYPSkMdBD2HM9I1U0J/X2uVoXBfuklAk94VQGLmpJrJXirOEY9b7uq23AkaWKx3eu6DqfT6NqaTuB+XmGcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhZkr4WS; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhZkr4WS"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa68d65d24so3295250e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 20:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780456733; cv=none;
        d=google.com; s=arc-20240605;
        b=NTfccNZxQ5N0GRNytmIRAcFpB31+bqba4P83BfemfA9TedBQ9uuY1d744Bdr6UZqp8
         iY82txsOqVZ85kPgNcIEwpLJCwu/5+9Ud6Wvcaonzn9M48p0ldU3iBkg+MWcyzui959c
         drJvF/0rKi0jrN4UW30pE86WL9FR7G1Abit+uxmqRbZv/3/sp1+ZBOv5oHQCFz/D8hJA
         tFBfsnkwOpxL+FaHIsWeROKE+36nD5tWAGP1h8fr7BGc1mneU/ZlegxW3NC5LbAISWcv
         ndbUiU/hH3bkW7DRq8/AE/Imz9vxeeaRh0DE8y9zOY/R2/zity6p78Knv6ks83lN6Z+t
         45Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=arpa75Qwe0NNiDqa3IrrWREIx40QLuuKEC2G8l7NiGs=;
        fh=vI+f0IoKbkI5YE5dFZyO4X1GgY3nKmufJVSC9HXxtYg=;
        b=MFm7A4dzVBV4H9BdMj5OPoJI00Tgw8PgU1YhNbYPO9cOJ/lHEJFokEN79j1MoxVafG
         F9p4WnotAlNqzdqh9ZIOuOC9JYQdkb/8kPO9G3dcVhMr2/A4X8IOrvPMVpVQRLA74kxb
         6LL9qcaLWS+ghAORKLDDHyd36TY82ZtmSFi2t/Lx8UA07Fikj95HEhO5pQcRl4K6qMZU
         FC4i9r15seSjw4+inNzV6PiXFkS5EeL2ZKSb/btzD/UbLLmtaOWrF/mZuPYGWcunwhVb
         b76KWXHs6L75M9YSMQ7sNG5Afj6VGBBvpBxJLDjGtWfWRXe9pu1hU60cWjlfFTtBFJ/a
         BmzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456733; x=1781061533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arpa75Qwe0NNiDqa3IrrWREIx40QLuuKEC2G8l7NiGs=;
        b=dhZkr4WSlvPQXwz6ZGaHD7KhQj/U06ACl+SW+QPe5vvybTkURSz2guEKsS9VbeVhkr
         g3Tey50LrblWjCPMxlrcL4VeguW+rV3G9pEC6hmMgrbIn46FU53IRmAPZLW6bymKv35J
         DP12QV7c8XWAY69Pv0zTmmRGOLEZ3D1o9VkWsKQwZIu6YXPZFDFSrPqZjUgsvvnxpGDY
         s9/ZxnhNx/ZdGC2YQQDqA7vbbIfJCmfQiR9KoLZ97zIjbtqWIhkocOoOqy5It9jaPSGi
         AkAyslyJJq7XQ3TZp0KuHBOr42WO8RwDic11saRBKKWdvSXAsrUzo0T+k2o0DGxc+QGS
         la4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456733; x=1781061533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=arpa75Qwe0NNiDqa3IrrWREIx40QLuuKEC2G8l7NiGs=;
        b=cEdj7q2QXihs+DsBai62Ltlv7e02JLurZV1H8UUJ1O220D6Gd1xqLR+oOxUYfFkcYn
         rM9dpzbLcOlHtDe3gWObH5ypfCY35GxYSAkJfSYvEwpOYlRm/SrN4ZgaHqHI5IUUxg9A
         7poLAmrJxvQu1Hn6bsZFZ/7n3gWFsuAiRV9sYx3a1K+HE4CZQ876Ksivwos5ne0LCY1l
         cPtsZJCwYsMn4u5IX2YKZZ+VtT1cX+DaL8YpB5FtjvGHMTf8qW4V7c6eurD3eD6EFbHF
         2Oh4qnB9QsdBwWrDjC/wbvtLGoYilCWhPZBR10G5wADufooKmxe/eXAKT3zDuRjSIJGW
         wiqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gKQ50uGxb4oqhoJhDJL5ieJDAyjrq84yPFJEXqaCuzbUzXA2zZKdFN9XESa6dYCeBZw2mLG+Gk24PxIWu9UU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv9mjXVQgNKo5Pek4VU99MtgQHxjbmTrqf5LgBDY7FwasU7v1A
	oVO5YYoACBeI5wHmq3yHRu2LVtxvlWUbkuVMTC1z9ByaawP/7IXW4TPvJoYK/NsnfuUWSX/MnLZ
	xUtCOAoiKpPG3YdkeEvYCQrC0zu6+JM8=
X-Gm-Gg: Acq92OGabnM2q6E5MCKJCGx3BUihSeklAlnT9DT7xr2GJncEPIaqKt5GNTVXG3Vrjjk
	jEChQsgZu7gu/NMDh/9982zO/wiJKgNl+VsjU8cIG3uswN1/SvV964ynyuOfAS3eph2aVb/ufa3
	rtX1A3b0U2BgCMSob0WQGg2E4PYA+LX9+peUHGAPAzKJf1GltidMNouJB52aeE7yiATqCkgt/d7
	Suzn+tAPoq9/XSQp6IAkrHYv0g7YpUp+KX0opmSWVYxEoJcawaupsbpt67OVFnbzkcQD9LveSsr
	hZRWyMBq6lXfZBhsBp35FaZrjItj2WDotYQJdLc/oYnWKe23b7S0rqFAha5Cj51yOv6urLTMcz2
	QAkuYV5mwTjfiM9exHWeCj1K9K8tlDyjRBMf+Aqp2MuiU2+p2AiF/aJtcJ29TMJaOTLkHb0mfZh
	4skfI=
X-Received: by 2002:a05:6512:8050:b0:5aa:7788:d1d3 with SMTP id
 2adb3069b0e04-5aa7c0ec3b3mr265185e87.23.1780456732296; Tue, 02 Jun 2026
 20:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525220628.94833-1-rosenp@gmail.com> <202606020951.6AD1467B@keescook>
In-Reply-To: <202606020951.6AD1467B@keescook>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 2 Jun 2026 20:18:40 -0700
X-Gm-Features: AVHnY4Lw1GRK6hCeEmdqK1CCx2JVGSnFdoljfLVLsP7bAqpTQHxCCJM_QDQI9r8
Message-ID: <CAKxU2N9RjuJnYteS9A38q=Q5nJ+K2VqroHXheW+rd9Vm_8c1XA@mail.gmail.com>
Subject: Re: [PATCH] dma: map_benchmark: turn dma_sg_map_param buf into a
 flexible array
To: Kees Cook <kees@kernel.org>
Cc: iommu@lists.linux.dev, Barry Song <baohua@kernel.org>, linusw@kernel.org, 
	Qinxin Xia <xiaqinxin@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 9:52=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, May 25, 2026 at 03:06:28PM -0700, Rosen Penev wrote:
> > The buf pointer was kmalloc_array()'d immediately after the parent
> > struct allocation, with the count (granule, validated to 1..1024 by
> > the ioctl) trivially available beforehand.  Move buf to the struct
> > tail as a flexible array member and fold the two allocations into a
> > single kzalloc_flex(), dropping the kfree(params->buf) in both the
> > prepare error path and unprepare.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Assisted-by: Claude:Opus-4.7
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  kernel/dma/map_benchmark.c | 29 +++++++++++++----------------
> >  1 file changed, 13 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> > index 29eeb5fdf199..a65da5c7710c 100644
> > --- a/kernel/dma/map_benchmark.c
> > +++ b/kernel/dma/map_benchmark.c
> > @@ -121,35 +121,35 @@ static struct map_benchmark_ops dma_single_map_be=
nchmark_ops =3D {
> >  struct dma_sg_map_param {
> >       struct sg_table sgt;
> >       struct device *dev;
> > -     void **buf;
> >       u32 npages;
> >       u32 dma_dir;
> > +     void *buf[] __counted_by(npages);
> >  };
> >
> >  static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *m=
ap)
> >  {
> > +     struct dma_sg_map_param *params;
> >       struct scatterlist *sg;
> > +     u32 npages;
> >       int i;
> >
> > -     struct dma_sg_map_param *params =3D kzalloc(sizeof(*params), GFP_=
KERNEL);
> > -
> > -     if (!params)
> > -             return NULL;
> >       /*
> >        * Set the number of scatterlist entries based on the granule.
> >        * In SG mode, 'granule' represents the number of scatterlist ent=
ries.
> >        * Each scatterlist entry corresponds to a single page.
> >        */
> > -     params->npages =3D map->bparam.granule;
> > +     npages =3D map->bparam.granule;
> > +
> > +     params =3D kzalloc_flex(*params, buf, npages);
> > +     if (!params)
> > +             return NULL;
> > +
> > +     params->npages =3D npages;
> >       params->dma_dir =3D map->bparam.dma_dir;
> >       params->dev =3D map->dev;
> > -     params->buf =3D kmalloc_array(params->npages, sizeof(*params->buf=
),
> > -                                 GFP_KERNEL);
> > -     if (!params->buf)
> > -             goto out;
> >
> > -     if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
> > -             goto free_buf;
> > +     if (sg_alloc_table(&params->sgt, npages, GFP_KERNEL))
>
> nit: I think it's better to use the params->npages here just because it
> is obviously tied to params->sgt, and reduces code churn for this patch
> (i.e. that line would be left alone).
Fixed. I only did it to reduce line length.
>
> Otherwise looks good.
>
> -Kees
>
> > +             goto free_params;
> >
> >       for_each_sgtable_sg(&params->sgt, sg, i) {
> >               params->buf[i] =3D (void *)__get_free_page(GFP_KERNEL);
> > @@ -166,9 +166,7 @@ static void *dma_sg_map_benchmark_prepare(struct ma=
p_benchmark_data *map)
> >               free_page((unsigned long)params->buf[i]);
> >
> >       sg_free_table(&params->sgt);
> > -free_buf:
> > -     kfree(params->buf);
> > -out:
> > +free_params:
> >       kfree(params);
> >       return NULL;
> >  }
> > @@ -183,7 +181,6 @@ static void dma_sg_map_benchmark_unprepare(void *mp=
aram)
> >
> >       sg_free_table(&params->sgt);
> >
> > -     kfree(params->buf);
> >       kfree(params);
> >  }
> >
> > --
> > 2.54.0
> >
>
> --
> Kees Cook
