Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620D378823
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048152; cv=none; b=FvjLjtYXFdeAhYHscSdM8po9jFoSStS4tf+QvZVB0Koo8j9C0O6SvVWfNlXnMcFZBr0s/JVIOrelURS3I2fiV2MUMrJYcFPTGsH5U89w2I1CTKFz7/KIYs5VZD8K9lQ9MXSs7rqAnTgbWQQ67p9pGEffoSQseZ0Ifj71q8Ka9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048152; c=relaxed/simple;
	bh=rG4iGZioAprTGKBiz46GgCZK5qEFnPoxgRT+pvl4YO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4tNrYPB2uVY+oIFS9FXy2D7kZmxo8YI1W+f3gmmvKL70CavSV3sG2aS9/ddHA+2otPYJhz6GjCxvwpUE4lWrSOJPiBJBouWAhR4jR2gUtuRQ2xfb9hSlaoch7PRnMeeTbZIW2Mf3vgBfFrIb2T6/AergOiXibuhoDyGp31kTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCXY/CQB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCXY/CQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A2CC19423
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773048151;
	bh=rG4iGZioAprTGKBiz46GgCZK5qEFnPoxgRT+pvl4YO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FCXY/CQBFR0twTRWRwX9Gdvz0U0IS7fBYYi36x/3S77mI0D/B5Ni43MUpxvEbI2xF
	 s5wbs7IG9fW4sh+DHxvJwpbWLCbtbUuQUBsWJwfwIrljmdlcm+reahxzCVjYl9RxGw
	 BuqKm8TwTsV4L/f59fcYhoH4p1OEH4xzukxLVIOkyb7LZfr++ynFjs2khV3vUgTdIh
	 HuiYjraRsVYxz4IUGCcWH7DzOyLHp2wr/Ziyjjza7T7KzhWr20IRfMlgV353dIPU4t
	 YDADp7XSNKfUEqtSf3r6xQf0h99wGH0G9Gfk6GW1ZQ0yvjQS6g+0eyx/NeLJE/i6WA
	 7/M6FKDrET7iw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59de8155501so5830901e87.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Mar 2026 02:22:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmjDx2GbYQqHdEp9dcJt3D7I8FXLvKjwAgqY3d25fM/wsTSZmJC4bgIc8JKQpC2Siqo3NAQkHGtwMzV9FUlaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiLSZplg3sFmZneMTz1NJap+gDz9LyxZ1B46TgQKmTcaMEA0J
	N7Pzt8v+4KAwFLZXwUP88WHtvGNi+FBf4fizenqGg9hQI7T7v+CbidqsNix58IVn4T2Tr5pNSsz
	6Hm8DAuGAwttRyQA/iVwivGNZcKVWgFJfmozBZLtf6A==
X-Received: by 2002:a05:6512:1152:b0:5a0:ff30:5281 with SMTP id
 2adb3069b0e04-5a13cd55eb8mr3200633e87.46.1773048150493; Mon, 09 Mar 2026
 02:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021201.47820-1-rosenp@gmail.com>
In-Reply-To: <20260308021201.47820-1-rosenp@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 9 Mar 2026 10:22:19 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfGkVpk9rBLvwxndjveXemY6t7nWOBX9wqZxc+Qe7aOCg@mail.gmail.com>
X-Gm-Features: AaiRm52w-C0ztrxLFeXv5hewRPxLZddLVCg-vwfhtlv1RCAB78FDBiAvWfha8Tw
Message-ID: <CAMRc=MfGkVpk9rBLvwxndjveXemY6t7nWOBX9wqZxc+Qe7aOCg@mail.gmail.com>
Subject: Re: [PATCH] gpio: ljca: reduce struct allocation
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Linus Walleij <linusw@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 3:12=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrote=
:
>
> Convert connect_mode to a flexible array member to avoid calling
> kcalloc and to combine the allocations.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpio/gpio-ljca.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
> index f32d1d237795..a531aaa0425f 100644
> --- a/drivers/gpio/gpio-ljca.c
> +++ b/drivers/gpio/gpio-ljca.c
> @@ -63,7 +63,6 @@ struct ljca_gpio_dev {
>         DECLARE_BITMAP(enabled_irqs, LJCA_MAX_GPIO_NUM);
>         DECLARE_BITMAP(reenable_irqs, LJCA_MAX_GPIO_NUM);
>         DECLARE_BITMAP(output_enabled, LJCA_MAX_GPIO_NUM);
> -       u8 *connect_mode;
>         /* protect irq bus */
>         struct mutex irq_lock;
>         struct work_struct work;
> @@ -72,6 +71,8 @@ struct ljca_gpio_dev {
>
>         u8 obuf[LJCA_GPIO_BUF_SIZE];
>         u8 ibuf[LJCA_GPIO_BUF_SIZE];
> +
> +       u8 connect_mode[];

Please use __counted_by().

>  };
>
>  static int ljca_gpio_config(struct ljca_gpio_dev *ljca_gpio, u8 gpio_id,
> @@ -400,22 +401,19 @@ static int ljca_gpio_probe(struct auxiliary_device =
*auxdev,
>                            const struct auxiliary_device_id *aux_dev_id)
>  {
>         struct ljca_client *ljca =3D auxiliary_dev_to_ljca_client(auxdev)=
;
> +       struct ljca_gpio_info *gpio_info;
>         struct ljca_gpio_dev *ljca_gpio;
>         struct gpio_irq_chip *girq;
>         int ret;
>
> -       ljca_gpio =3D devm_kzalloc(&auxdev->dev, sizeof(*ljca_gpio), GFP_=
KERNEL);
> +       gpio_info =3D dev_get_platdata(&auxdev->dev);
> +       ljca_gpio =3D devm_kzalloc(&auxdev->dev, struct_size(ljca_gpio, c=
onnect_mode, gpio_info->num),

I'm surprised to learn that there's no devm_kzalloc_flex() yet. I
wanted to ask you to use it but it doesn't exist.

Bart

> +                                GFP_KERNEL);
>         if (!ljca_gpio)
>                 return -ENOMEM;
>
>         ljca_gpio->ljca =3D ljca;
> -       ljca_gpio->gpio_info =3D dev_get_platdata(&auxdev->dev);
> -       ljca_gpio->connect_mode =3D devm_kcalloc(&auxdev->dev,
> -                                              ljca_gpio->gpio_info->num,
> -                                              sizeof(*ljca_gpio->connect=
_mode),
> -                                              GFP_KERNEL);
> -       if (!ljca_gpio->connect_mode)
> -               return -ENOMEM;
> +       ljca_gpio->gpio_info =3D gpio_info;
>
>         ret =3D devm_mutex_init(&auxdev->dev, &ljca_gpio->irq_lock);
>         if (ret)
> --
> 2.53.0
>
