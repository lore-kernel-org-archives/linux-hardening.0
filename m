Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0EA36C0DE
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773092900; cv=pass; b=PoaLaj7ceJnf2MPmPjYaYtf1BJvH/nBtfQxZ9EX3e0TyoUUvwF5HgH3vud9af1pdxpgHUDGwh3aVEFBQPXbIvf7QGHp7z8CNroKj4N6Jp952ZBlHC4uADsuLTHOxxKriXg7LHKf4S/9CP+Xd6l5dIOT9m4L9+Phm9p9kFutr0ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773092900; c=relaxed/simple;
	bh=reB98/yRVFc8H7HxCp3Xcemlmnv0aKaA9sTYRsUfEyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqlBa113okYeludLh9DQ3OwZkEXDA7BnALq5+QmnrJYTEsgdTOhf9BB9aclexH9Lzlf8tlTzpGf9Y9/PwYxvriTjEY8lmkjWrXL8UXDniuLibS5V3M5F847uApAff9MXdLPFfwfOZL+YnfimOYsPghJgjB+o6NidexeWzu8SAyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL+c+KDm; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL+c+KDm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f97c626aaso2049697166b.2
        for <linux-hardening@vger.kernel.org>; Mon, 09 Mar 2026 14:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773092897; cv=none;
        d=google.com; s=arc-20240605;
        b=g7PurRH9CthYNQgq0wnLP4KX0IqNjRawEjvC2IrXQ15NlD8eIWkr2cIFRjrmZLqunt
         5pFOx0JT12FkTuolNygo0CCxSeaKrJkiZiE1QClXxZslcMx9QhoTlAqt4OFQuobR57GK
         69HBNFnApnSaGZcpLWdAS7V/swJ8QkKOZ17YC3Xig7/CZw2SD7FmmzzvQNO2uyilrqhj
         rjJ4e99Wtor6UzM4ogTxW4BzOR3xwbN09YadWnCfcqa8gCP6+f8A7Wzat5vqntHkQJfd
         ir1l9ah7n/aRMJFj8Ys9w0wyL3b82h9/62kTIYtir5L0UX9a6OuLEqfbPuC+GQf75q7f
         drDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+RW4Bksv15WvnsXHAkZ2+BYLVycvOxPzx1oOl5MaTG4=;
        fh=D6BKSq8jwLgo9vWnIvxwXWc4Q3friwJNIy1Wysixymw=;
        b=jKqo1Sv+/g8Wya7U2qeSVCVY0uE1ceaOayFoSTq65WdZ3Y355HRxx4cLbS+zWiBydK
         8DbkIPiaQVtg+OyDejdKn7/SSln7sOpPcmQjEgfQFZGSnlEyBaERjHH2zL6MIMWZ3qMk
         rl3jf3OGz6faOxdKr/lCkdPNoiPDy5u2uJp1IC6tlyN3OJ7Dlu63DiPwjObBOvqjQzYy
         RbzbRhX+2SmJN/evJRh+tRPfOTbJH4/ls6ZCMY2SRTwl9aSBE3dV3P3Zm01SUALL/MKj
         Yk8lVcRxlwPKMmTOGCtvsvUV5RFY5o6zna4Wv6F0Zl+EOgGe+JR6NPJ207bGYU0cw8n6
         b2dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773092897; x=1773697697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RW4Bksv15WvnsXHAkZ2+BYLVycvOxPzx1oOl5MaTG4=;
        b=HL+c+KDmW6RROoYegpsQPGH16Jv2jXdYubq/ZbLerdGPvHm6E3pNukVDbsW/ilcmYt
         rbHQC2p2Ax2l6/s4UYnUP96u/IN+fDWV6WUjkF81TbdfEg6iCj/mxx76955oojL0SXr4
         kl9Ur/Y6aHet+lIIHbmrSd4+HVQx8UeI/Ab42le7Ko0paqKB0Dpjl2ZzRDtUAChQg/Ki
         C4Qq23SS1M1PH7e7rh5ROvvomRcEeuRG1KRfpkjsOZUStSOW0b6pnY1SCkl6znHQYUo8
         QRdBns+l3bKeCK1DP0fB+gFb+ZNR5+Vrc/q69swtpn98ittqRyv1ZIgUVraCm69s7uif
         B2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773092897; x=1773697697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RW4Bksv15WvnsXHAkZ2+BYLVycvOxPzx1oOl5MaTG4=;
        b=K41RzqF86opHtQkx22ogyxxNVduH5ibs/Cz01N7isEmguZpo8ibtSrTqOW5rPSCJge
         0QtbXOEt1jJWtfCkMS3HdqJDEdus/8jjcYi2ppVYEo2ahykOic2oupR3Ln1iL6UwDbTq
         n4d7gDgIh09KTFfbYkWuBqQJYR+FRQNJxsBffKYr1+zt8lGRGjIJYLUmj+RK68eTvZDr
         OqOwugZwIkxX4KjZ/ca8qe8VhGdvquwB1bIuMXsOvRtR6XqSPTYF+7lELn/yW1Li22ZQ
         P07Bc+PmwUcTBihDmIvKAu2L84jAXD8Po7I/i/0QIMjgkzCI/hZBbM/cxQKD6xuwhHUK
         bS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiUR72a+qsVY/hiEr/5aMNDiVNLRBDqC49Tf/Q3krR7p6k2Bv034mnGnQRjd0Fvw2H9PiYaeRz9hdKtQ15WNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2w+bslOJe9FF5rYdS3lvEBhjowzDmdQ9NxBsQkmEwYMiHGqdZ
	F6QYX1pa22k48IMC+133LHh/1EIjl8TZidQukRbDb2OxMVVDjOyaEP73o66W2kc0AJFVMj9vYND
	Ye166fypXMfJ7sy/YdlUhLwzS0Vah9GY=
X-Gm-Gg: ATEYQzyES+gMD94Vat5DpSoDSpb46ujYMYY44E2YqiliYzmH8+fj8tsOonKd5e7CXM8
	lFwFgCb1ihVzJoK3s5uPGlYCLT20tT+doBG9rkDJOwECm751WOJSqrODzHYHZXCKZb6QxVnUcYc
	Z3Ukoh/3R8/KknARCCGcZR/76I8ds/v8Bf/YQJZsDf7N8QfGyhqh0uZtXSzXFl7FcmyJFOAWLh2
	0CPfoRpg0wPz+pAlQweN+vXH++6kw9fk0PMzFvwT1RDCdSYml0ymwWM10QrytX3VoDgtabvRlDf
	OXYsq5CtBfhq1pC9JZjFhiEHRPflWaaWcYpwa4K74OOm8rylPFpSkxpAuhwrjm/6DZpyt5uuYky
	K010Bc3iF3ZMlDwDN
X-Received: by 2002:a17:907:7ba6:b0:b94:1d92:7e8 with SMTP id
 a640c23a62f3a-b942de06f52mr753184366b.27.1773092896698; Mon, 09 Mar 2026
 14:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021201.47820-1-rosenp@gmail.com> <CAMRc=MfGkVpk9rBLvwxndjveXemY6t7nWOBX9wqZxc+Qe7aOCg@mail.gmail.com>
In-Reply-To: <CAMRc=MfGkVpk9rBLvwxndjveXemY6t7nWOBX9wqZxc+Qe7aOCg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 9 Mar 2026 14:48:04 -0700
X-Gm-Features: AaiRm531jvLGP3p0QNkfjPaWbYM9v3XkvbwhlEnwIJao5lsqtECDEEmPxAwb-OM
Message-ID: <CAKxU2N8Zm6Hg-pr14RS9SCsOWGu2kF3gy4RVuQThMvM1CfLEtQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: ljca: reduce struct allocation
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Linus Walleij <linusw@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 2:22=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Sun, Mar 8, 2026 at 3:12=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
> >
> > Convert connect_mode to a flexible array member to avoid calling
> > kcalloc and to combine the allocations.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/gpio/gpio-ljca.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
> > index f32d1d237795..a531aaa0425f 100644
> > --- a/drivers/gpio/gpio-ljca.c
> > +++ b/drivers/gpio/gpio-ljca.c
> > @@ -63,7 +63,6 @@ struct ljca_gpio_dev {
> >         DECLARE_BITMAP(enabled_irqs, LJCA_MAX_GPIO_NUM);
> >         DECLARE_BITMAP(reenable_irqs, LJCA_MAX_GPIO_NUM);
> >         DECLARE_BITMAP(output_enabled, LJCA_MAX_GPIO_NUM);
> > -       u8 *connect_mode;
> >         /* protect irq bus */
> >         struct mutex irq_lock;
> >         struct work_struct work;
> > @@ -72,6 +71,8 @@ struct ljca_gpio_dev {
> >
> >         u8 obuf[LJCA_GPIO_BUF_SIZE];
> >         u8 ibuf[LJCA_GPIO_BUF_SIZE];
> > +
> > +       u8 connect_mode[];
>
> Please use __counted_by().
Counted by what?

__counted_by(gpio_info->num); does not work.
> >  };
> >
> >  static int ljca_gpio_config(struct ljca_gpio_dev *ljca_gpio, u8 gpio_i=
d,
> > @@ -400,22 +401,19 @@ static int ljca_gpio_probe(struct auxiliary_devic=
e *auxdev,
> >                            const struct auxiliary_device_id *aux_dev_id=
)
> >  {
> >         struct ljca_client *ljca =3D auxiliary_dev_to_ljca_client(auxde=
v);
> > +       struct ljca_gpio_info *gpio_info;
> >         struct ljca_gpio_dev *ljca_gpio;
> >         struct gpio_irq_chip *girq;
> >         int ret;
> >
> > -       ljca_gpio =3D devm_kzalloc(&auxdev->dev, sizeof(*ljca_gpio), GF=
P_KERNEL);
> > +       gpio_info =3D dev_get_platdata(&auxdev->dev);
> > +       ljca_gpio =3D devm_kzalloc(&auxdev->dev, struct_size(ljca_gpio,=
 connect_mode, gpio_info->num),
>
> I'm surprised to learn that there's no devm_kzalloc_flex() yet. I
> wanted to ask you to use it but it doesn't exist.
I'm sure a treewide commit will be applied when it gets introduced.
>
> Bart
>
> > +                                GFP_KERNEL);
> >         if (!ljca_gpio)
> >                 return -ENOMEM;
> >
> >         ljca_gpio->ljca =3D ljca;
> > -       ljca_gpio->gpio_info =3D dev_get_platdata(&auxdev->dev);
> > -       ljca_gpio->connect_mode =3D devm_kcalloc(&auxdev->dev,
> > -                                              ljca_gpio->gpio_info->nu=
m,
> > -                                              sizeof(*ljca_gpio->conne=
ct_mode),
> > -                                              GFP_KERNEL);
> > -       if (!ljca_gpio->connect_mode)
> > -               return -ENOMEM;
> > +       ljca_gpio->gpio_info =3D gpio_info;
> >
> >         ret =3D devm_mutex_init(&auxdev->dev, &ljca_gpio->irq_lock);
> >         if (ret)
> > --
> > 2.53.0
> >
