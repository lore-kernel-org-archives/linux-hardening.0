Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F23016E0
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772996063; cv=pass; b=aiTr798RoiC8VBjPlwAUnJzE+6bCUHi3u7/P6R/vBwH5KodhEUxsNh9vzWvWCnlIqm0+VVOqsEjBlXr6C9/LitSq0HDALCEVpVZtKMTRJhooyKg4WsHp2Fk9xQlTXHiYUl19BwB/ScVXrYFQkq7Hd7A0Cdg/XOUz9wOYq7dg9e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772996063; c=relaxed/simple;
	bh=4WkA3TH3CpqNnjjKk237hd7jy7cuqFxp3MQHuN2Tqiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itFmOstWIoZuj67GGCHx/x3aHfTQ5iejrcvmcaK5Fr+wEsIKq54x29O9ykAteY6BYKjCqZjHrGreS8ZuWGYZ253JT1JVyuT0blBk1WhtQhvmuFZReG8YoBCdtbK6Gge4cT6tE2x1pOeA+gRx8ZGilWS8QWTsPgXoZ802zVCuk9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZCqsB3/; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZCqsB3/"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b96d784828bso131910766b.3
        for <linux-hardening@vger.kernel.org>; Sun, 08 Mar 2026 11:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772996060; cv=none;
        d=google.com; s=arc-20240605;
        b=U4iPyzx/N4VRDV00uU0YVnhuqqCBOcJ42kW4HD+xDzRxn5IuC4OQ6JzuOHborW06j5
         ZDsZzavWJpG0SjWna2azX/T4Kcrka9E6DA3F4Fivch7tik5huDk2F890foSU1NVBbytn
         Pzi0UTuJ7SSMxve7cqAmwCLcj6w7fobIDN04hlEZrCSjCvh6UyAc8j+FQmdjIXxZu0Tf
         Qkr0qeCofe8xyQGfwO6DEN36vdCLVJzCl0IzsIG2EwZr32ILRYGGE+pcYpqR0H6KWphC
         umbT46KB6eaP7h2ew+3dkflDOSjLZpWaki7gLHIv75Cjlh+0ZPXMdMqp5w87DatOMTyy
         hH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pzx1bQVa70pFv3Ce8nvdnPUapYfUkF9U6niOOnzrcbA=;
        fh=deLy/3fdP+C+mFUu4aa7ML4H/R9HesFAw2iAP7xLKmw=;
        b=CW11d/FRQP2Vyxnl8avkwAzSShSVK35AKJeZ7MaU0jeYZGfxa8fJ7gyxCBP/KTA/3B
         EspF0nXNkttnt6NwLpcEdEUtIHRwLyhP6JjElAJv/Stgq3TlwIsVBrO5A9g0mayyeCtG
         79t40C3EwbddMRo+j87mX08oINPUbP5eE2niBzHrrNVEM0mcgsZbRlwqqvGO7vjWmqLq
         bBwLI4oHL6DvYHCkaQB8rY2zYxuVsjnnVpyyFhtofdRciMPvX8sOiY2ZXjjDgNexcZJE
         /6vwQhzBxwpAGey3BuSOJHWi3TZYqs1PA7hQQk44sEkXSMprvvy6gCNOMEKRqlZ3Ssjb
         XnNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772996060; x=1773600860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzx1bQVa70pFv3Ce8nvdnPUapYfUkF9U6niOOnzrcbA=;
        b=DZCqsB3/fl1li2f1uoIY/YiJjp64MkLs87edWA7ic6DSa+ZTJWEm3bWQ0pFAHkpC1N
         yYNCpFxkrNR4wQXxuYcnPSzany2kopquwsKAG33xXUXOzR+wPpbiZ/v/VhmeDrvBYdsT
         P+O3l0O68dGiPR4HHYmVVvSCi21u88TkUPM5xcfiVXZo/wq51nqOasL+Kd0pPU1ktIKE
         zKbbMvowbbLGaVWJVqJKM9na3z4PN0e1CPsk4qCmaTONa42ACS5sPyv79L0ztuSLhd/S
         yTnQ0lE+5aDCumH0wjDYOCUAC4se9HuU4+/BmmGVYjZX9Cya/YEdQHEMNTL5oNmEB8GU
         p8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772996060; x=1773600860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzx1bQVa70pFv3Ce8nvdnPUapYfUkF9U6niOOnzrcbA=;
        b=NWd+UT26IOTRfMYGvonJerR/5p4KVcHIJlL4MDEtZ5weOnFzuiexJvQfW9gVB+Kqip
         BwVYWhHej2jYA45kiz0B2b80ix424bTlsdhgAQKvYDxoMJ9k9w17RKXTW30keAKsYJ4R
         Iu78VpIPoXAcZn7Rk9h3x3J/Tb3UGy/XGS56EaZN9ZAKpI0WfgcdjHkcfhq9RQMpGZBp
         rgzg98Yav+tgrlcRsVRwVbLMii0yZJHAYhsb64pezis8xyFRZQc945jBiQqfcUTh9fj+
         CatVjRSwgfTnRjF88h67G8EioPW1d2uUAzU2BNZJrOHryB2cpqOKh1BX5JjnyptnnLPZ
         +LSg==
X-Forwarded-Encrypted: i=1; AJvYcCWAnUkgIs95hHoB5hqeMtj1doUAwKTGkRpxboe/lOJr78ncOz3YACJXQeWYgXXJPI5DFADGSRhuqx3lUFgLzlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVee3SLTdu1If0jwzhDBCBvQ4LE/Ausc0LoHXstpCUakCTsayp
	LgWfdSdtqVILyYwROL4U0hNzwKR6PThze1Tg7ed6gHNpNnsbgcpzdpy1BEUBsjeYRBDMx/WTQgN
	ik7CWgMYGfPR7Lv67x+LzIv22MJMgIuY=
X-Gm-Gg: ATEYQzw3GqEG2yEDTb4CyKaHseoZuu9yvGVfqGw2J4WGJ/2Z8m6Xt2f5YYJBUB7jvLs
	Gxn7TmvTYG2f9d0yk6sbRdgEuduf87L9bhKJWAMjBCGbQuoYEgqEAsrMiMMUdEkx7T911uoa5Wh
	HFZEYAdciPooT9ZcLVnm62KyEygbtqRbEdxv7OuhVsbAc60mbK7+wyDZiofLmbxb9tBJrTyNYxc
	rzuDNQibJcPNGWtkrsn/ejsjocb/mnpchbTyimsny8zrnhhK9FQY5hWaST+d383Ire9gf68Kfpi
	jZvb2yUhztXid4btGT1EsxtzWXxBRUWSYO5UXAhyKviZVVv+qnIbf2vgHboQNFNK3GHZnbzQ533
	d9speufvePpok9osF
X-Received: by 2002:a17:907:9481:b0:b8f:e98b:4952 with SMTP id
 a640c23a62f3a-b942e01d395mr456827866b.41.1772996059506; Sun, 08 Mar 2026
 11:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021201.47820-1-rosenp@gmail.com> <aa1pZdYEU8QkI_8x@kekkonen.localdomain>
In-Reply-To: <aa1pZdYEU8QkI_8x@kekkonen.localdomain>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 8 Mar 2026 11:54:07 -0700
X-Gm-Features: AaiRm51QfrWs8BNS_2Luw1Q-fQPrrzLS7J3qivjkJpr7RC7inVJkQajYBh-ovwM
Message-ID: <CAKxU2N9WCtyoEhdZk=GY=3kuYkv3NKrRZ6kNE8-feGYp5AXTbQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: ljca: reduce struct allocation
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 5:19=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rosen,
>
> Thanks or the patch.
>
> On Sat, Mar 07, 2026 at 06:12:01PM -0800, Rosen Penev wrote:
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
> >       DECLARE_BITMAP(enabled_irqs, LJCA_MAX_GPIO_NUM);
> >       DECLARE_BITMAP(reenable_irqs, LJCA_MAX_GPIO_NUM);
> >       DECLARE_BITMAP(output_enabled, LJCA_MAX_GPIO_NUM);
> > -     u8 *connect_mode;
> >       /* protect irq bus */
> >       struct mutex irq_lock;
> >       struct work_struct work;
> > @@ -72,6 +71,8 @@ struct ljca_gpio_dev {
> >
> >       u8 obuf[LJCA_GPIO_BUF_SIZE];
> >       u8 ibuf[LJCA_GPIO_BUF_SIZE];
> > +
> > +     u8 connect_mode[];
> >  };
> >
> >  static int ljca_gpio_config(struct ljca_gpio_dev *ljca_gpio, u8 gpio_i=
d,
> > @@ -400,22 +401,19 @@ static int ljca_gpio_probe(struct auxiliary_devic=
e *auxdev,
> >                          const struct auxiliary_device_id *aux_dev_id)
> >  {
> >       struct ljca_client *ljca =3D auxiliary_dev_to_ljca_client(auxdev)=
;
> > +     struct ljca_gpio_info *gpio_info;
> >       struct ljca_gpio_dev *ljca_gpio;
> >       struct gpio_irq_chip *girq;
> >       int ret;
> >
> > -     ljca_gpio =3D devm_kzalloc(&auxdev->dev, sizeof(*ljca_gpio), GFP_=
KERNEL);
> > +     gpio_info =3D dev_get_platdata(&auxdev->dev);
>
> You can do this assignment in variable declaration.
I avoided doing so to keep reverse christmas tree order. I can still
do so if desired.
>
> > +     ljca_gpio =3D devm_kzalloc(&auxdev->dev, struct_size(ljca_gpio, c=
onnect_mode, gpio_info->num),
>
> This line is a bit long, I'd wrap it.
Will fix.
>
> > +                              GFP_KERNEL);
> >       if (!ljca_gpio)
> >               return -ENOMEM;
> >
> >       ljca_gpio->ljca =3D ljca;
> > -     ljca_gpio->gpio_info =3D dev_get_platdata(&auxdev->dev);
> > -     ljca_gpio->connect_mode =3D devm_kcalloc(&auxdev->dev,
> > -                                            ljca_gpio->gpio_info->num,
> > -                                            sizeof(*ljca_gpio->connect=
_mode),
> > -                                            GFP_KERNEL);
> > -     if (!ljca_gpio->connect_mode)
> > -             return -ENOMEM;
> > +     ljca_gpio->gpio_info =3D gpio_info;
> >
> >       ret =3D devm_mutex_init(&auxdev->dev, &ljca_gpio->irq_lock);
> >       if (ret)
>
> --
> Kind regards,
>
> Sakari Ailus
