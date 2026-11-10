Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794336080;
	b=GC8Pg2w3ocmwX0019PXLBraBUlji/SXRDPR6CR7zKAm08ltby4EFk+x0q5kmhwIbHgXL
	 1+b0f01XHNkzBV0xVLDX7KpqtLACw3kl2v0oy+Pwf0HBOvrwGbLXC322hozAFiUTzwhcc
	 Wf9QBC7VLLsvFG1V2XtBRgdFz9eVTX6sU8QLGCBs8vJOmEsrnUroXHY3r6Zra2O5ovGO0
	 zN5SntgbCqXmn1T7+vBilwD1ezZFh6Q+8c34UmL6+gVg+Wrrz5mLzwbOuPdUk5T8CMg8d
	 ZwBnU2J5ltIaUoo/b7ijCYX0uIbkqEe4uFwx9rV/RF/fl68tHwjdWdyfzDioNdYfS2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=av4ENrPPV1tGMkw5tLRd7+RJ2zUb0Iw82xvXCZIZOuU=;
	b=moJqYDKym2tlJrxRAvgqXvpG41DZCD+ZA8gHklMghAb+gF1XrDbQ8zwe+BQlDLywZxwK
	 HB8Yae4MHcRjZ2U0L0ICExA5oEKyiEylr9We4vMWKlUkYw+g3YfGv8oskhmVyGaPWCuu6
	 EGEWujiF8SHhf6cx6YtDvG28evll52c3+aODaJYSIyfA+L8FzJ4X56PJaH/DnAaONRIlt
	 N7wGYFiIpg2+PUUefe0Wu9Q3JJAYbjasxVtIcZ+7Lu5U6pskH+UTPI/zm0Qd/cf89HnQ2
	 H4Ysxvci0pHQ5Joy4wh8EM9olncfntRSLyLEyyfORo7jLHZWjqXYqtDgxbKeOwJDPHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DtcS/EXD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DA60A6F4F
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 18:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B44DA60A6F4F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DtcS/EXD
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso16605485e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 10:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794336078; cv=none;
        d=google.com; s=arc-20260327;
        b=WzMkl5hRVLul9MEzOiC2MjPrz8aVCIquBHMDkhS84w5ykvJWuDhiuykeXqyh6ZHo/R
         Ii8q5/UDSEzswKI4pRy6MLhLTWCxm+9eeWGRRTzq+7uhTmO+HTrWxTA9w5KZS94U0pNO
         ii18PZoLPYHAtAarJrW7D1CVl4TsiI+JR5HDzp9Xxd8MnXhnSgD/lPG3OpoZFbi4qen3
         0HKiDGzp4J1Ta0qpf13fMTpM4kED/Os6KRlwtjBhKYiZyinlsU4eQHt5ssodqYLZpg9x
         3tjDiXxlRLoBhmEl+Vbb6I/z/FW92OF92x67A0kLUj9Ek6/5MPjHXG0r6N/LAlmwAFeY
         jBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=av4ENrPPV1tGMkw5tLRd7+RJ2zUb0Iw82xvXCZIZOuU=;
        fh=GomwHqWuC8PHqB8GFqkxHjPkLntbLcS3PjOQ0QzV8BU=;
        b=HvpFHV+QPZxTs47jNw5+LsdD5OgHjZcA8pTZoqj2+DHds6Bf3u/TREmJzjEooSxYXA
         b25/KUJJCgaMhDQ94FEeybBMV0r9lRD2wwZ1FIQmB22r/kloAb2RFuFvQsX9dx/XTQ5J
         t9BPgzHJ+8vnHZi/WkU8cHpivL5L5cwWiU5JD+6Y2VZMxyAILB5bGEIn6/MxvM9L1e4Y
         TEYtCiyAJxkRzJiHjr+yzaB2lTu5V5cz6/Hr0RYJuw9nzwXHzEHjxmNzv4cks4GY/G3O
         K3qscPhWe+9JVjNKncP+luNtowuIYCm5+y/w2JoIhZ5B+vb50II4y44BboGMDyOc0yi4
         UcEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794336078; x=1794940878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=av4ENrPPV1tGMkw5tLRd7+RJ2zUb0Iw82xvXCZIZOuU=;
        b=DtcS/EXD9Ce+96Ky5V6gDgJEKfa8GTqySzpgPBqvf+DY8iFoulGaFbygjpNNvjG/jX
         CFeUtcWzvnPfCOu1H5kobRE8nwug+xDTEUERU4B6M59NUgrJ1evjNpEeDcVAbesU4Uyj
         hlrjUAthBeVRD8Qb4uzBlnjokI7iy/1e3Fyuye2yUNSt8i2CB4Z4gvMul/+ZeO/bUv8K
         QVZxdvamx3o4dwIWpG9m4m3Xpj6vC+K3wGn1eTjpjB0N5qY531tLbw9bNgZtJDU8qDCV
         jcfFyWlXhJQqIjO7bo+Ch/eZCNRN6Ln++xQ4tvg6vvBN7qtKqydo1aEMqufS9zaCxXtG
         94Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794336078; x=1794940878;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=av4ENrPPV1tGMkw5tLRd7+RJ2zUb0Iw82xvXCZIZOuU=;
        b=ShUhdP5aCib7Jt59eXUqZ+2VUgUJwAXC/6EbQFH0U4i+kOtc3/DVSSiA18oli2X4s5
         q9FRFom5s5sdYp87H+NEzntZZhVNzyRDuQD20hx+OpjuvwAfwX5ANN9HegRgO5EIiYh9
         yOuiVrUxGAMEhZ2zvmPd1UDD7IUy3GD3m+8lftb8ybo+FAvOWypC/LqsvSYxL7f9BkGg
         x3NvdP9vefgjX/IHfIDb02qUSmL0ge+ACCND6UFNdDlWHfxUj9ykyI3SVJ41xBSS5q7o
         zexbJ+nqlh2B9DUUCOs6OgzgMtM1a0MROz+O2gBTqR/UhKIOJlPwvHhQLso8VElmR+6s
         rxOA==
X-Forwarded-Encrypted: i=1; AL+hErEW3DOF6MaTMwX9w3c2Ut2uWSOeGxKlntGH3ySmfdBet1fZ2R0I0qdB9x87XTfgLDp6Ij2z2U19p1fp12SKkeM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oiU3cR2llGxhvKxQ0Dqphl6pBfrzy+UH4OLJUIjxoit7AUEsp
	gU5pPK8cGew2L862EIzZH/iF6kDIt89F6X+ltKKT30sED+pH7bBvLcZdF6BU66mU2HSwqg/svL7
	v/WAmbwYNmoro4tOyUnsX2UgYw1HKWNo=
X-Gm-Gg: AYBFou2bGq8EPGZOcVRUzT39JtnKFi+4k8wrh5o24xBHrw7hkdY1+19g+kalBfDUEhM
	YZTTRsMaedNA0kOb7MGC6+4pxK4Hx8bVlOQS/LFmNgtyoqkgi7Gjc19ac/kbdQ449R5CouVQwab
	lago5KyO2woJ3rk8FyqqrjyNw+642oiLX+HzHcXarcGn+cEHK3DNmyKkvxGl7dFKdqTn+RrWApm
	Hk40tjTbFhftPM7iQMmqa/jHq3DiRVKrB4TFbDawhsQh8XP9pfnQ5bQ8dtUSxjfBU6BtK3hRZD3
	BVEzayPSl444/jtdZoQ7q18WV9amoPeC84OxFAWRYHCp2WA+zpHmAxdHTeokzix+3a9hKjGXu9T
	gYpa8oduv1AqpwgPQofwXxytoOHGHb4oWalwbgUEvNoMj+MvgqvszNe/RfqbUPpS3fPZwlYZ2
X-Received: by 2002:a05:600c:4e41:b0:4b7:6942:39be with SMTP id
 5b1f17b1804b1-4ba0234ed60mr59966285e9.24.1794336077840; Tue, 10 Nov 2026
 10:41:17 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
 <cd073632-0919-4015-8daf-39cfe24391e8@kernel.org> <20261110135444.7d8070ec@pumpkin>
In-Reply-To: <20261110135444.7d8070ec@pumpkin>
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Date: Tue, 10 Nov 2026 10:41:06 -0800
X-Gm-Features: AclHuK9_7M2m4zG_NQ4qW5SK5DvtnSnNqDvZRn6nCgKPOE6JXbdQL3_rS3KQX_Y
Message-ID: <CAPDEY+X=pVsiY5cib8e_Vu3KNW0QNV6hXF+GSLs9gyD8rMXa6w@mail.gmail.com>
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA drivers
To: David Laight <david.laight.linux@gmail.com>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>, hverkuil@kernel.org, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, 
	morbo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 5:54=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 10 Nov 2026 11:08:30 +0100
> Hans Verkuil <hverkuil+cisco@kernel.org> wrote:
>
> > On 06/11/2026 08:46, Mariia Nikitash wrote:
> > > In preparation for removing the deprecated strlcat() API[1],
> > > replace the strscpy() and strlcat() calls used to construct
> > > V4L2 card names in the TEA5777 and TEA575x radio drivers.
> > >
> > > seq_buf tracks the current write position and remaining capacity
> > > across appends, avoiding repeated scans of the destination buffer.
> > > This preserves the resulting strings, including truncation behavior.
> > >
> > > Link: https://github.com/KSPP/linux/issues/370 [1]
> > > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> >
> > Nacked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
> >

Hi,



> > This is silly. Just use scnprintf().
>
> Or wait for someone to add a call that just does what is needed.
> In this case the first stscpy() returns the length (and it is often
> known).
> So you could have:
>         len =3D strscpy(buf, tea->card[, buflen]);
>         len =3D strscpy_at(buf, len, " TEA5777"[, buflen]);
> or:
>         len =3D strscat(buf, buflen, tea->card, " TEA5777", ....);
> or some variant that will do a strnlen(buf, buflen) to get the offset.
>
> But it really is best to leave the strlcat() calls in there for now.
>

Thanks Hans and David for the feedback.

I agree that seq_buf is too complex here. I'll look into using
scnprintf() as Hans suggested.

David, I also see your point about leaving strlcat() in place until a
more suitable append helper is available. I'll revisit the approach
before deciding on a v2.


Best,
Mariia

> David
>
> >
> > Regards,
> >
> >       Hans
> >
> > > ---
> > >  drivers/media/radio/radio-tea5777.c | 10 ++++++++--
> > >  drivers/media/radio/tea575x.c       | 10 ++++++++--
> > >  2 files changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/media/radio/radio-tea5777.c b/drivers/media/radi=
o/radio-tea5777.c
> > > index fb9de7bbcd19..2b1c7f6ddd60 100644
> > > --- a/drivers/media/radio/radio-tea5777.c
> > > +++ b/drivers/media/radio/radio-tea5777.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/init.h>
> > >  #include <linux/module.h>
> > >  #include <linux/sched.h>
> > > +#include <linux/seq_buf.h>
> > >  #include <linux/slab.h>
> > >  #include <media/v4l2-device.h>
> > >  #include <media/v4l2-dev.h>
> > > @@ -255,10 +256,15 @@ static int vidioc_querycap(struct file *file, v=
oid  *priv,
> > >                                     struct v4l2_capability *v)
> > >  {
> > >     struct radio_tea5777 *tea =3D video_drvdata(file);
> > > +   struct seq_buf s;
> > >
> > >     strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> > > -   strscpy(v->card, tea->card, sizeof(v->card));
> > > -   strlcat(v->card, " TEA5777", sizeof(v->card));
> > > +
> > > +   seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> > > +   seq_buf_puts(&s, (const char *)tea->card);
> > > +   seq_buf_puts(&s, " TEA5777");
> > > +   seq_buf_terminate(&s);
> > > +
> > >     strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
> > >     return 0;
> > >  }
> > > diff --git a/drivers/media/radio/tea575x.c b/drivers/media/radio/tea5=
75x.c
> > > index c37315226c42..e49228eb7c46 100644
> > > --- a/drivers/media/radio/tea575x.c
> > > +++ b/drivers/media/radio/tea575x.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/seq_buf.h>
> > >  #include <linux/sched.h>
> > >  #include <asm/io.h>
> > >  #include <media/v4l2-device.h>
> > > @@ -221,10 +222,15 @@ static int vidioc_querycap(struct file *file, v=
oid  *priv,
> > >                                     struct v4l2_capability *v)
> > >  {
> > >     struct snd_tea575x *tea =3D video_drvdata(file);
> > > +   struct seq_buf s;
> > >
> > >     strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> > > -   strscpy(v->card, tea->card, sizeof(v->card));
> > > -   strlcat(v->card, tea->tea5759 ? " TEA5759" : " TEA5757", sizeof(v=
->card));
> > > +
> > > +   seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> > > +   seq_buf_puts(&s, (const char *)tea->card);
> > > +   seq_buf_puts(&s, tea->tea5759 ? " TEA5759" : " TEA5757");
> > > +   seq_buf_terminate(&s);
> > > +
> > >     strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
> > >     return 0;
> > >  }
> >
> >
>
