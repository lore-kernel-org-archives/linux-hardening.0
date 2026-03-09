Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADC366DB5
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041565; cv=pass; b=eFDb7r+gQjfcdVUEZtaCRVzrZHDM8sBIZnv00kzUkO5ub5pmNjXMBYjD/JTeV1XDn3k1HU6bwvWLUgAKCiztTqVnIFtyaxQJvzhvJ/fAyMHmTToyJJhd5FFF4hr1loF9LaVT+OdB5kN341ZgZX4zXlugBW1VNAnQ5BxFEYd/jro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041565; c=relaxed/simple;
	bh=DH1rJ36nVJLLDjqFDxgTmWF1Mwn1wYvC+/hgWQyJHqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0z82n6UpBjTGY/1lh4EwIRZm80lJ5veMKv9ncvJAvbGd9g6j0L2g+pi6giTa04rUD3ZwUDzM7yTFopZrri9n4z+y03KLslVGab00d55KUjciCIdIYBpHZgWyTrLhQm4oEEw3hDuLhGrUbXSrWfU2/7sBL1ulMlHKSxKe16Os+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IslhMmYS; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IslhMmYS"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so1472893266b.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Mar 2026 00:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773041562; cv=none;
        d=google.com; s=arc-20240605;
        b=JATuqBYDFosdS7GRm57Zf1VKXq3cwgQsLQA6Sj/zzTKdmRjSdd29LSzRDe+UxgTEs0
         vxdC5FYv8zZScqIah4OfKZdYhd7xPavCj0e+LkjvVPT6DUplyeqInB09/BtPRs8PjBmJ
         PtnrzvSouYeabKWBuLLYLUMr+v+2AiHJ+OOOa6Na1S7E5E9wIi7/kIPP0/PciYjoW9/n
         rHapb+ilfzJ4np9CQbtwC6F2by30h+zGIVIfqfDnBG0hPZUhM792kCd8aMeJrKbfd4/7
         1a8GO0zhgptV1lZ60lDvWH7Xev1wiyuJ2OKioDlqKY9RzafdTMrs8x3FNgNSyMp9mwTi
         YoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=akeSupG5m8VPhkGeEV9BLXdavZm3NemGKXEB5aL2sYo=;
        fh=3S6TuKd/aBYhFJnR3c/Ng1zph0NzGdm857ZOQrPZnx0=;
        b=ZYj2Fb2EhD0x9Vq2cRa5nMlINOt+7ia0hNZrf9DDBKxgzUkxYs7fkMG67+UTgCh8DG
         zpE/Ig6S30zzhFIm1CmTR8WkPOl+ZCeUj1pipiKIt804Pthy09u2CYXvkbLWPPaqkQhA
         4jMlD95wui4qnAw0K+o++EB5WDffAhe0kXe+oYjIfo8+RN3jIJLfmGhGilU1J+9mvwlv
         cdbJhivVJue5qw5Nu67gaAmKlk9OR5qmNS2/wyH1G7dbGPF6e0MWjWZu//M58iLqBhqn
         ORULnR/gsc/LxhW4hmvx2cFOjqNqgUlMFCp4Be1tDqDOHX3IN20ZchtxEqj6QlelIx5G
         LMKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773041562; x=1773646362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akeSupG5m8VPhkGeEV9BLXdavZm3NemGKXEB5aL2sYo=;
        b=IslhMmYSh4HvKBypGRrLam7J90egy/IZTMjg/bBpBwrTSUzpkwGnq38R3VgVadvEzd
         aQwrlQ+rgQTBV/OqQorA23i7xqw66zq+X9XLVukkleNxDJf5qyA2jwpZBNf6sobYJHo8
         gRVe1hoIGT4Cep6HyWwJ6HUBeLElXoXb7Rhq2K/cJz+DsJLaTCeUZhR5MkGQnEIq6lHY
         gLzeGDzDmFRs2SYZGKAds3iggKpBN97LS4YeHdOrehDlwkszLG4Z7G33jmu77Y7+7k5U
         JOKGX1KCe3DOb+t/6Wwp+B2Kn0aJ44mf9GYKfbs+7h4hyXwR7MwG2+I/fmfEIgrZ+1Vz
         d96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041562; x=1773646362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akeSupG5m8VPhkGeEV9BLXdavZm3NemGKXEB5aL2sYo=;
        b=tj+NYhb8w2IqWYpJyBlSi72ATE4GW8zNY8ThlNXL1j94b3xrwKkzbI2I8kLNRevFm4
         oJI+VdB2+oYscJ3c8wMCEDFjrmU6Seiy3f2zlbTe8xA7cL+DDH5W3wobNmOY+t7zfGpB
         L3ZEPAFbK1KmoIvKkeawMDOR22UAv7ukl1Zz9jDBWUdtd79Scnbxtq76pf4SUrFtP43E
         44KvANvr3eQYoSfgI8l9J4K2JGMX1x3Ouqb1APqMhzsclTC5gQVS1dLMJG1Tyq448ErS
         FR2qaQZcRWh6knOKCXbkz33qPkKP6Cg0YvDLTtD2UKcF1qu4SgVVeVE2j1Fdj6iPpGDW
         18LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc+7uH65GobASfSeky/zkF/gRDNczZcYBLxS9bxihR/8JdgxPFRTIrg3Di3QQIMmGmNFpHcqVFRFsN6C6Cs5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtv+Ow5UUn3w7U+dwvUp+zmka/0RBznHciKjL9RxoTHGu6/cpu
	SeZlQn0EumzZ0QISlg1KCN9GfWaC5vGv/7CQzAnwDnPZmF6msy313GplI/nRHJxe+8t2smUnIPp
	Gy3mvAs5iq4pfPgyKJ/fnErKZtqFqWUw=
X-Gm-Gg: ATEYQzz2z2kmXZGUMk1UBMN2parCnXrgVSZVuyw/y5CnwwTXlMRxjWdyl5NBI/rvbSw
	c+QdxeRZIy3htrzQklysFzMHWrTr8kEet/SxcQyQGMlgtBu7f399hMIf0UYK/PtKWrayI/YgKPW
	7rSUpbIfYto7gOBG6gQbmThv94MkaJjbeiDm0qeqejU2kFhWRo6Ubxi4eb/EAZYwVQXMkVGHA05
	dNrraHRv2oUbDY7ilaC17lMjCjuJQJJayz7o3wc2eS/8Es6Tp5unE87/ojd1gcyZZFS8u1ErRFY
	CCVBDvUarLFo6BTdmMQ9hTviwPZ3KUDteYBGk+omDaeOrMSGQnUFLpjfn6yNBoekSTVgN5MpIYK
	50ffBng==
X-Received: by 2002:a17:907:2d9e:b0:b97:7a:768e with SMTP id
 a640c23a62f3a-b97007a8663mr61285566b.12.1773041562142; Mon, 09 Mar 2026
 00:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021201.47820-1-rosenp@gmail.com> <aa1pZdYEU8QkI_8x@kekkonen.localdomain>
 <CAKxU2N9WCtyoEhdZk=GY=3kuYkv3NKrRZ6kNE8-feGYp5AXTbQ@mail.gmail.com> <aa50jIM0Xexg1hiQ@kekkonen.localdomain>
In-Reply-To: <aa50jIM0Xexg1hiQ@kekkonen.localdomain>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 9 Mar 2026 00:32:31 -0700
X-Gm-Features: AaiRm53KxlLd6cSb2N0U-kkIOonQLqmLftHrhzNhnzCzOcZN0Sz_D8pG2cchpVs
Message-ID: <CAKxU2N_kb-CGHkbZhfht+HauKj31q-W=vkN6TG35=zQw5n2Lfg@mail.gmail.com>
Subject: Re: [PATCH] gpio: ljca: reduce struct allocation
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 12:20=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rosen,
>
> On Sun, Mar 08, 2026 at 11:54:07AM -0700, Rosen Penev wrote:
> > On Sun, Mar 8, 2026 at 5:19=E2=80=AFAM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rosen,
> > >
> > > Thanks or the patch.
> > >
> > > On Sat, Mar 07, 2026 at 06:12:01PM -0800, Rosen Penev wrote:
> > > > Convert connect_mode to a flexible array member to avoid calling
> > > > kcalloc and to combine the allocations.
> > > >
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > > >  drivers/gpio/gpio-ljca.c | 16 +++++++---------
> > > >  1 file changed, 7 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
> > > > index f32d1d237795..a531aaa0425f 100644
> > > > --- a/drivers/gpio/gpio-ljca.c
> > > > +++ b/drivers/gpio/gpio-ljca.c
> > > > @@ -63,7 +63,6 @@ struct ljca_gpio_dev {
> > > >       DECLARE_BITMAP(enabled_irqs, LJCA_MAX_GPIO_NUM);
> > > >       DECLARE_BITMAP(reenable_irqs, LJCA_MAX_GPIO_NUM);
> > > >       DECLARE_BITMAP(output_enabled, LJCA_MAX_GPIO_NUM);
> > > > -     u8 *connect_mode;
> > > >       /* protect irq bus */
> > > >       struct mutex irq_lock;
> > > >       struct work_struct work;
> > > > @@ -72,6 +71,8 @@ struct ljca_gpio_dev {
> > > >
> > > >       u8 obuf[LJCA_GPIO_BUF_SIZE];
> > > >       u8 ibuf[LJCA_GPIO_BUF_SIZE];
> > > > +
> > > > +     u8 connect_mode[];
> > > >  };
> > > >
> > > >  static int ljca_gpio_config(struct ljca_gpio_dev *ljca_gpio, u8 gp=
io_id,
> > > > @@ -400,22 +401,19 @@ static int ljca_gpio_probe(struct auxiliary_d=
evice *auxdev,
> > > >                          const struct auxiliary_device_id *aux_dev_=
id)
> > > >  {
> > > >       struct ljca_client *ljca =3D auxiliary_dev_to_ljca_client(aux=
dev);
> > > > +     struct ljca_gpio_info *gpio_info;
> > > >       struct ljca_gpio_dev *ljca_gpio;
> > > >       struct gpio_irq_chip *girq;
> > > >       int ret;
> > > >
> > > > -     ljca_gpio =3D devm_kzalloc(&auxdev->dev, sizeof(*ljca_gpio), =
GFP_KERNEL);
> > > > +     gpio_info =3D dev_get_platdata(&auxdev->dev);
> > >
> > > You can do this assignment in variable declaration.
> > I avoided doing so to keep reverse christmas tree order. I can still
> > do so if desired.
>
> How does that affect it? There doesn't seem to be a dependency here -- an=
d
> even if there was, the dependency obviously has priority.
It's just cosmetic.
>
> > >
> > > > +     ljca_gpio =3D devm_kzalloc(&auxdev->dev, struct_size(ljca_gpi=
o, connect_mode, gpio_info->num),
> > >
> > > This line is a bit long, I'd wrap it.
> > Will fix.
> > >
> > > > +                              GFP_KERNEL);
> > > >       if (!ljca_gpio)
> > > >               return -ENOMEM;
> > > >
> > > >       ljca_gpio->ljca =3D ljca;
> > > > -     ljca_gpio->gpio_info =3D dev_get_platdata(&auxdev->dev);
> > > > -     ljca_gpio->connect_mode =3D devm_kcalloc(&auxdev->dev,
> > > > -                                            ljca_gpio->gpio_info->=
num,
> > > > -                                            sizeof(*ljca_gpio->con=
nect_mode),
> > > > -                                            GFP_KERNEL);
> > > > -     if (!ljca_gpio->connect_mode)
> > > > -             return -ENOMEM;
> > > > +     ljca_gpio->gpio_info =3D gpio_info;
> > > >
> > > >       ret =3D devm_mutex_init(&auxdev->dev, &ljca_gpio->irq_lock);
> > > >       if (ret)
> > >
>
> --
> Kind regards,
>
> Sakari Ailus
