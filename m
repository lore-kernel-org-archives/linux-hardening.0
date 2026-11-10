Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794335280;
	b=s2BsnwPjhmoj+i5vjj3n7NME5RKn6T/VBcbu5HiLLgXrUXZihJKBYT4I44PhNO3r2Ka8
	 J+YrIbOhVryhUHw25ULn4Q/SGd7YRyUmWgGgkoYhAFOZs8VbDGRtbrOKYNsuRrYlDe+2T
	 C3S/oIftEFhfv4uG1s4GZXy+j8Va5YzQUk4L9nqOolNZ3wXN+y4xhdzMWfb09hA2Q5OWJ
	 lfIqoCbRyvb+w+0V7gKDYiqa68JOzCMzKKmBKeis09DVs+xwc77Z5QaH9ZTgxFujMRAKn
	 64V0GmGK5g6p21EVCWsqHqs9wyLR64w05LQuC+xw6yzxb+IxX0JGr159UP3sUmfEDig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0YLdB3g9tnxFjs9/6VH9nFXGUYkvbUmaGAC4N10mcqc=;
	b=KdkPhqXKxQCSec/OD5nT0XEqA1kl7qHcaKMzMnWNoT4BoRqtpbijz8AroXBFwWss/0Ji
	 phythWf2Yg2rdplnMrQUJ+44/3KtDau398wkBF56eT8ndyDTlYs5qP9wcBj73M8cYdaYU
	 HUxo7k2CUH5sRaPZvgtzIchdYz3zKL+k/oj284Tv+lJcls7efAOZzSat2b3ZRc70X2deR
	 pBIqPxtLmg9EYh3LLblowGBmzDZCPANzHWbIuioY4xdGZuqoFpL3smsa7FsJjh1sKTshs
	 5ffTd7yg7gprcJzTNuXsWkJascV4s3KqXRbs2WndbXS/Bt+YmXC2ofzJf8cv6H4djIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IM8+v6VO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D2606A321
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 18:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 645D2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IM8+v6VO
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so690451f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 10:28:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794335279; cv=none;
        d=google.com; s=arc-20260327;
        b=ggoXw8UAbl8i49145Lqe+V+VTOD8TVrNinWEnLt0/7ihRX7Sqicd3EAr52hgvFnRXk
         OafCcZXF8/CjLzUKd/2jf1jHKUlQBLJgVNIJn2Eioz7oGIEasmW6uB6b9+VvVxEvaKjw
         vsKjkhHBCaL9v9GyEJckgLh4d2RzGQdxWoe2giJGn54xANBbf31Bq8QcnHf0NhDdq8mI
         XXzsDUjtxJIdBoMrvTdoLBTvPEjRDhdmA2GwhD3GQuYp3oBCK/IbPITys5KdCewqFn6O
         cJlR3+4kMNvfnx7Nyh/sM6zhGzJYIUqP+Qp/vRpqoUeDEoHFXe3HemOZ/o+LJMxPo1uC
         a7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0YLdB3g9tnxFjs9/6VH9nFXGUYkvbUmaGAC4N10mcqc=;
        fh=zhPhmgcZw15crjnCNkGA8YJanRYhxzENbdBei97cRdU=;
        b=Ms0BGcogWgxrSkHtzVBhdwno6wMePpukwYH+4pFb2YmfTJLVmrtKzBebg/lLqMem7k
         E/FH0BQeIZX/sGwYC+L8HCd45uRo6oY6dHO8+W+fzkXZ8MA2EfNVpI5zgd2VcQsaQUV1
         TZb3RnyRPO83/Z/2lS+2f6YBtFKvMF6Oqp6KkS0NJJW9UrWkde9nEHe8GhUbNGztoNwE
         CUoL5ARH/rfqfoVovSdPUiSskVIDOPFlH1UfqP7b5zsYMTacevqlMR6HfRsIr/eUJyGk
         cHS3+DXkgIQIzT2MIfnKX/t+K2whPr1XhjCUTmko40WnF7ryCVMiEgu8y0i0YZD8/ED3
         HUMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794335279; x=1794940079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YLdB3g9tnxFjs9/6VH9nFXGUYkvbUmaGAC4N10mcqc=;
        b=IM8+v6VODEbzMLsKcWFuS9S9xmHEUoFxom2xO9uGGR2po2iJ8Dyah1rV6I5MVQIepp
         FfMJQKJo0h45UV+I253ihetGTCLcW/dxxRDVS6h8150p0rNWBiMMaQ2hUEtgkCmQjTD5
         6BcW5zyErZbXnw97oCdTfwLjdyLNUAv2hR1lGm09IFwq1BY8Trf2XHfoNcijdpPeliSd
         i2luqxZEOJcpks0DzraY1rEoQsAvm8hzfHI6o/TmyNwWgrl/L/i9yN9RqJPMTHhvrOMx
         CniLDvEv0mJYgHUBcmLNKldfp0u6a5wZpHp5+JT0t0OSQYx+Rr6giQ6NRElSDUlHR/BG
         w/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335279; x=1794940079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YLdB3g9tnxFjs9/6VH9nFXGUYkvbUmaGAC4N10mcqc=;
        b=RZ43F8dC2+bWF6GxJIrkhobkwkldL4DyjohVJuZalxc+0nvvWYQIi2Pwc9rU4yRHuk
         Kwl6B8YIyYzP2rMCD0MMuOUnamMiw9sgOjSxZcaE785AU2mtOmHTnyO2hicoyG4HeSiL
         19Hc7bGKyXzbYLONPEntV2MRsGKo7wzPepBe0ZIduvEafUX3EJQwaQVRt/GnaZfnJfzL
         7V/tAXnjWOs5aojWIZXicQmfJ7Nci/naxBfIOKQUW0VnR4+QB/YTsWkW9GBJJtk+XWxK
         eA/ab+Bt6x+ZfduANyqKWT2FHyuyjeR98QvtEWmUE+35b1dX49M59YPC1BmnCnHSxbax
         RLZw==
X-Forwarded-Encrypted: i=1; AL+hErEN9W9ySh5Bwvodefn/ub0FghGgHSijkqW1Gc1g9V1jcafO2+d7Ko8qmLYEUGF8s0NxICksphtcUbtOJLDi7xI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sIQ4ZTTpNL7tiohYfdiQ1NTXRrAbO8jqjo3Ieua6RUroaemZa
	vGnxQnkQdidvppxX8W3JJEoxJnGRfgg51rOpYVQWlOHXOjFKL9NMGmuvLsWuovZ+T32/9pS0Zbf
	YBBrwUUCpSwfoeEjjGh8Fdm4+weMLE98=
X-Gm-Gg: AYBFou0EM2Y5rVc9cFzCEgr6qHd7d3funtWMdM21Jd/aAjMAMbutMYphqM5Gu/aLlFl
	FqS0Y0OY9tkgR8OihidGzdzOU1GNbXzeEIDCmJYeKXpT41oSjs/ejLgHyBYgWYnQ1BS/nbFGURD
	sKqnNzMbEXK5qnuAjQOahMqTwZebqrRG+I2HTtCqUCtR0xqBMxpI3qOCsxoCLVds3k287Po0xmr
	7V0Lq4yDU0MpqxbnUHRApEvAoJQ955E1aFMnC9Ojgzq8pXt2mVHcxqynejZLvbkGpnqoyT+NQe/
	PmUNPrAR6SMFRtPLlEMLlZG+qNijS90hZyG3lbc83GP0BslX8sOCdN9fkxl+Z3jfkq7dILO4pqu
	SODdMox0nNfya8laDtU3DuGr17OuK5ygCtixHrkzDRBKSvkFoUw+HXhVVI0WUgB1Tb9lQBxwKcw
	kJuC+x2o9nice2xMsd
X-Received: by 2002:a05:6000:1a86:b0:488:57ad:d5c8 with SMTP id
 ffacd0b85a97d-4982ba3297amr6630503f8f.3.1794335278568; Tue, 10 Nov 2026
 10:27:58 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
 <20261108200800.2b3b15cf@pumpkin> <ed2a6a4e-f480-4b39-9684-0dbd2d55e261@kernel.org>
In-Reply-To: <ed2a6a4e-f480-4b39-9684-0dbd2d55e261@kernel.org>
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Date: Tue, 10 Nov 2026 10:27:46 -0800
X-Gm-Features: AclHuK-s0hGDrA9NemleLuGLRjjsAkkNcY2oEM2MlQ1hpilpfd-nAy6wrrOh58c
Message-ID: <CAPDEY+UxXCg3M3oLxxqjgEOdaVVaHJSwQCyt+=v2zLP8ESWVgA@mail.gmail.com>
Subject: Re: [PATCH] media: verisilicon: Replace strlcat() with seq_buf
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, nicolas.dufresne@collabora.com, 
	benjamin.gaignard@collabora.com, p.zabel@pengutronix.de, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kees@kernel.org, justinstitt@google.com, morbo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:13=E2=80=AFAM Hans Verkuil <hverkuil+cisco@kernel=
.org> wrote:
>
> On 08/11/2026 21:08, David Laight wrote:
> > On Thu,  5 Nov 2026 00:45:18 -0800
> > Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:
> >
> >> In preparation for removing the deprecated strlcat() API[1], replace
> >> the strscpy() and strlcat() calls with seq_buf operations when
> >> constructing Hantro video device names.
> >>
> >> This preserves the resulting strings, including truncation
> >> when the compatible string and suffix exceed the destination
> >> buffer's capacity.
> >
> > This is just stupid...
> >
> > David
> >
> >>
> >> Link: https://github.com/KSPP/linux/issues/370 [1]
> >> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
>
> Nacked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
>
> Just use scnprintf.

Thanks for the reviews, I will simplify it to use scnprintf and send a v2.
>
> Regards,
>
>         Hans
>

Best,
Mariia
> >> ---
> >>  drivers/media/platform/verisilicon/hantro_drv.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers=
/media/platform/verisilicon/hantro_drv.c
> >> index 26e5d5547466..2bfcd45cc55e 100644
> >> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> >> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> >> @@ -17,6 +17,7 @@
> >>  #include <linux/platform_device.h>
> >>  #include <linux/pm.h>
> >>  #include <linux/pm_runtime.h>
> >> +#include <linux/seq_buf.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/videodev2.h>
> >>  #include <linux/workqueue.h>
> >> @@ -883,6 +884,7 @@ static int hantro_add_func(struct hantro_dev *vpu,=
 unsigned int funcid)
> >>      const struct of_device_id *match;
> >>      struct hantro_func *func;
> >>      struct video_device *vfd;
> >> +    struct seq_buf s;
> >>      int ret;
> >>
> >>      match =3D of_match_node(of_hantro_match, vpu->dev->of_node);
> >> @@ -902,9 +904,12 @@ static int hantro_add_func(struct hantro_dev *vpu=
, unsigned int funcid)
> >>      vfd->vfl_dir =3D VFL_DIR_M2M;
> >>      vfd->device_caps =3D V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLA=
NE;
> >>      vfd->ioctl_ops =3D &hantro_ioctl_ops;
> >> -    strscpy(vfd->name, match->compatible, sizeof(vfd->name));
> >> -    strlcat(vfd->name, funcid =3D=3D MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
> >> -            "-enc" : "-dec", sizeof(vfd->name));
> >> +
> >> +    seq_buf_init(&s, vfd->name, sizeof(vfd->name));
> >> +    seq_buf_puts(&s, match->compatible);
> >> +    seq_buf_puts(&s, funcid =3D=3D MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
> >> +                    "-enc" : "-dec");
> >> +    seq_buf_terminate(&s);
> >>
> >>      if (funcid =3D=3D MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
> >>              vpu->encoder =3D func;
> >
> >
>
