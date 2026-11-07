Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794025926;
	b=ctVzz+5SA+mJMFEwOEHMDzuw1nkiOztEUcVTWhkzpyxSIFUoo3HOajOkX+u8u6pYEO1M
	 aEC7Gu0J2KXTV0oSfIeGqsw+jFx1cz3Wz8eS353DMThwFOzjmRZNh67U9+VSq1Ia8fKvT
	 OZNJCBvPpdESg1Um/LqrzYewduPszmNWcyTpIUb/z0EUt9mwwmMxsla5BpeTM/3IIdMUk
	 5uG5GSHYjJXq7Dti4XIcuXXJkY9nwlB+oz81nrBKMVADLfsDv5gKced+iANMxvvICiDKt
	 Eo42eD/YdDQUAAzB1CIEFaUsUYv9z3PpnMrZ7qX3NIPO1XwHB3X75jgXNtkS4/PBOSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UXb4T+4yF65d01rXW8bhdUP5pOZHT/ojuN1hL7c/AAM=;
	b=dIT0rxGo2Xl4rVK1HUrELSWV8vRlihODLqkSBPOlbC2nnzrOzGb2RsVJZEVn97NNKA7S
	 sDHRtM45E0ARx/kTqPCUoMZQUKpX999D+Emm6DDoPa2j5Ci+MzwxtMkCqEemS+6ydqnbn
	 rSlGqeCAFKjWl1WNbl8KXuMhNAQ4QL/bWq7xh983e8uxoUFbRNYsJ+f81ZUnpoz2cVuZE
	 im1OGciVRs/u6fjL1E22PYORqrKN1rgiyxoElJWwRKG0r2oIUU7PRD+xW/D+GBWmVtufr
	 6fDeW/6nkk39DgX8KhP1edrxPLEA6ky9THZdtUTfpkRjFuYdnqNK7rjWNsPNGxswOog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhTcNhgU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF2606A326
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 04:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10AF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhTcNhgU
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492f0a1b685so712787f8f.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 20:32:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794025924; cv=none;
        d=google.com; s=arc-20260327;
        b=F5SgJZmwLczetXcE1J4NEidWTeO7a1XgHJFVrbg1lMVkgOBzVlLjGsJT6KAKu8hB/T
         CJqixnIZ0XYZPYT9BhkJQ4htvhkjtR830KuQQJunnFQ4QA8QSSxicQ6MPEaTb5Z7HKpD
         PIGu09H/yFxlQMK9mEMX0XrXiRrsPZCKayzTsdQV57z0czwQeHKKM1F7u0X/suf+xBpV
         rx3yZGph89uqEHXbY5pxrXPBNaeJ2RuGOqIAC2iulJd53TtveIaxk+bEJ5p1N8u4hQvH
         gBpw1v5Dkx4f1zc9o/+HIo8eyLBlB/QBSmDiYtMzeH/lWc3pQci8p+H/jPKbE8Miepu9
         jXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UXb4T+4yF65d01rXW8bhdUP5pOZHT/ojuN1hL7c/AAM=;
        fh=93Pcei2AJjaTC/RFY2AafLPjfNsOMIPIY8R1Ws9E29E=;
        b=qLoK9iMruLJYG63ieufy7c+bs2wQW2G+PQtWVUdY4Wnrp8EdO6f2gMdWoI+KX6LG1g
         k6V8MtCE/tEPBC2GfFbPD0tFH52kd/ntHReLsZhkj44bI6yRiy8pAn66vysJLgHzIvPD
         0QrFiGzZq/98hahtP3+gfiLuGVnUtSgjMfkNYZRHhnL3LtfZlHao68Y3+RDHM8PfEczf
         XY4M4zjwqThyoQmXrb7GY9m6fY4ClALcXxWdMZmlgXMbAnqG3N18HP8mgCn3RNLj7GTN
         phrGWggaUhhTvSNHHS7+uMZhhHi7oJg/KPHZp9YfIP11+mSEFIlgKn1tHC0gAGOu4FfY
         /CqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794025924; x=1794630724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UXb4T+4yF65d01rXW8bhdUP5pOZHT/ojuN1hL7c/AAM=;
        b=lhTcNhgUGZGmJscgsQiceRcIbM98qm6Vd0daoPOmsUQVvGAQgB06t4miVd5d7husrA
         ZbCUcz2UrGZeDVRNgZsY/UON1EO3fd5xoug0eFrej8XtNl+VGBszzcyA1t7K7G1nQm/i
         rE/5xon8hFZUYlMs+wL17SN1xbvkSQvwXcTRaXmaIrCt30Af/D0p2VpOo0qSXXh7dzFw
         q+PbVwvJEdCywa/JQ/ESWJX48o3rVt5NvO3WuwMgZKVQS9/SYH35CghdXXCbGpH8LBUk
         ZEdmIgjRABhyXs4RbSCr7HSJTNcodLK6Lpg8ZhcJSNC8ohtxM2an5jqgmdYDMCxSResM
         ROAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025924; x=1794630724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXb4T+4yF65d01rXW8bhdUP5pOZHT/ojuN1hL7c/AAM=;
        b=T1IJhFJWdW8/8cq/KObWcmugkvSgiJguwdnHSRa6/Gv/tT0JWNe5dIwfdus7KVKTvf
         x6AC7zSBisboXJJb3Ovw546jdnOkDuSwdyMr+xPYIb32xP2qtkRPkoS5Oo/2A0SlgenR
         XIH04x7a6lxJ18VYiePdvSLVcv1SIV/rh1RUStOZO4QK6tYiYaRjF57KpG1mVC9ur60P
         wvltefAyWXv8lJgwItDQC1ASSeLkwmPAK6w0Jeishc4SztS0Bd0fc/QQJCRxS1Qr7AXh
         p9QcN81yJEzc4agA0QquNxzC/jHAhNlLtMNZ/h+1A6DWfgXlIV6Uv9ZDE3Q2iOUZcL5d
         rdug==
X-Forwarded-Encrypted: i=1; AL+hErEoVm2p5j5fUEYIgFr+tjQcAV6BazwP8skQ0zrB0fqnJyZT63S6+oxUx6yu97jau3f8V++NKdIriyPuvYexn3o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9ntTt5USEWbvI985txsMQAoKEYmtWiI3mC/FQiu3H/tkoKItN
	Es7KzD7i5Oxz3h0bq6Bmr17bc/dZHBNjTErNfc5VUBOGwLLIA+6+2a/iDnxFAkzexsAE7UdmLFY
	yTMc5BmTYTSNRWwo0ZSM+QDD+NR9cwks=
X-Gm-Gg: AYBFou1KCfslU6UBhmMeNcqCy7uDJCuI2QAmFYGhkZFZDQKJinhFKmfHqAgb+97sRcj
	u+TbTleH15cq2US8hGRENrmCoproAcq/iw9/+wEqjKRp53/lU3CFexK+/hJ8aym0oBTiqM0VaFL
	6Gjfaj1de079q3f5Gj/VnQCfFSr6+IpDdLYlnwjaCCjg1zfR34zergcGH+PZdWdkDC0GaepWmg4
	R2WTNGQzv4L/92hdan3MPzEF5AJXUo8513lq/eKk47BIgzjIcxpUNoLcc1jmC8oiv1GDimraaml
	8/ZqDOboWbix/HAHPIYXn0GpzFSqNFBWQByr9uwg+yawSNuGlxusT2SkgmFPqxLV3f60cuuyMui
	n3hLGvIc6d9PBU6SdFPyOM0PBW46PR9Tv3f4s5NfPhLuAQuNmhvvZ8IrZ30HR4NHIbm8ejm8=
X-Received: by 2002:a05:6000:2c03:b0:493:28c4:331e with SMTP id
 ffacd0b85a97d-49328c435cemr5949999f8f.28.1794025924400; Fri, 06 Nov 2026
 20:32:04 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com> <au2uDjVhB9232IuB@devuan>
In-Reply-To: <au2uDjVhB9232IuB@devuan>
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Date: Fri, 6 Nov 2026 20:31:53 -0800
X-Gm-Features: AclHuK9rBZ-IeP-aPeV2Q8ycPShnWIqSPPLruBPolqxGt1zwis9sIKCEuFaBges
Message-ID: <CAPDEY+Wa2+zxSVz8fewXDP78eA8-3ymAKurXuvB1Dhx7heLMiQ@mail.gmail.com>
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA drivers
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: hverkuil@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kees@kernel.org, justinstitt@google.com, morbo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 2:39=E2=80=AFAM Alejandro Colomar
<alx+linux-hardening@kernel.org> wrote:
>
> Hi Mariia,
>
> > Date: 2026-11-05 23:46:39-0800
> > From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> >
> > In preparation for removing the deprecated strlcat() API[1],
> > replace the strscpy() and strlcat() calls used to construct
> > V4L2 card names in the TEA5777 and TEA575x radio drivers.
> >
> > seq_buf tracks the current write position and remaining capacity
> > across appends, avoiding repeated scans of the destination buffer.
> > This preserves the resulting strings, including truncation behavior.
> >
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> > ---
> >  drivers/media/radio/radio-tea5777.c | 10 ++++++++--
> >  drivers/media/radio/tea575x.c       | 10 ++++++++--
> >  2 files changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/radio/radio-tea5777.c b/drivers/media/radio/=
radio-tea5777.c
> > index fb9de7bbcd19..2b1c7f6ddd60 100644
> > --- a/drivers/media/radio/radio-tea5777.c
> > +++ b/drivers/media/radio/radio-tea5777.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/sched.h>
> > +#include <linux/seq_buf.h>
> >  #include <linux/slab.h>
> >  #include <media/v4l2-device.h>
> >  #include <media/v4l2-dev.h>
> > @@ -255,10 +256,15 @@ static int vidioc_querycap(struct file *file, voi=
d  *priv,
> >                                       struct v4l2_capability *v)
> >  {
> >       struct radio_tea5777 *tea =3D video_drvdata(file);
> > +     struct seq_buf s;
> >
> >       strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> > -     strscpy(v->card, tea->card, sizeof(v->card));
> > -     strlcat(v->card, " TEA5777", sizeof(v->card));
> > +
> > +     seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> > +     seq_buf_puts(&s, (const char *)tea->card);
> > +     seq_buf_puts(&s, " TEA5777");
> > +     seq_buf_terminate(&s);
> > +
>
> Why are the casts needed?

Hi Alex,

I added the casts to make conversions from u8/__u8 to
character-pointer types expected by the seq_buf helpers explicit.

I'm also considering simplifying these two-part string constructions
using scnprintf() instead. Would this approach be preferred?



> Have a lovely day!
> Alex

Thanks,
Mariia
>
> >       strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
> >       return 0;
> >  }
> > diff --git a/drivers/media/radio/tea575x.c b/drivers/media/radio/tea575=
x.c
> > index c37315226c42..e49228eb7c46 100644
> > --- a/drivers/media/radio/tea575x.c
> > +++ b/drivers/media/radio/tea575x.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/slab.h>
> > +#include <linux/seq_buf.h>
> >  #include <linux/sched.h>
> >  #include <asm/io.h>
> >  #include <media/v4l2-device.h>
> > @@ -221,10 +222,15 @@ static int vidioc_querycap(struct file *file, voi=
d  *priv,
> >                                       struct v4l2_capability *v)
> >  {
> >       struct snd_tea575x *tea =3D video_drvdata(file);
> > +     struct seq_buf s;
> >
> >       strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> > -     strscpy(v->card, tea->card, sizeof(v->card));
> > -     strlcat(v->card, tea->tea5759 ? " TEA5759" : " TEA5757", sizeof(v=
->card));
> > +
> > +     seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> > +     seq_buf_puts(&s, (const char *)tea->card);
> > +     seq_buf_puts(&s, tea->tea5759 ? " TEA5759" : " TEA5757");
> > +     seq_buf_terminate(&s);
> > +
> >       strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
> >       return 0;
> >  }
> > --
> > 2.43.0
> >
> >
>
> --
> <https://www.alejandro-colomar.es>
