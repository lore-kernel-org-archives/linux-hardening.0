Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F382417F5
	for <linux-hardening@vger.kernel.org>; Fri,  7 Feb 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738916536; cv=none; b=AAT5t88nZhyboFMjm5bvlkU9TP65QCxIqQxlQujiHs5ujm449ccC/jmuNg7ppUYQWUYLs1nGduJND4Zg8NRcUD2iM1Bfrx81fCQrHtnCmQ6kkS2/NG0aCyVEEaqHIP3qbsYl2vg4smUn+iNzW0Jj0nhVGDufdHRsEVWEzMNg0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738916536; c=relaxed/simple;
	bh=X+TODTh08n7T4pQZBMd1XNG1nUxehOEYbRZSJqN243A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bccc3W5ovW13A1VLULXNYDSbDPEkXG3XsRbTuPfN89XyqatZ+Wpr3tt3lA01DzUv9YbRNgL2bjheRM53OaZ46NATXR4nxPo8wv6EsUNQ/Gj2GB+8Dk7UPaw9aqG9sZH1jLENE6CFa59xuVI9Ixl0kB4/wD4eyCMllzFm9xcic5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pAFdjG3h; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pAFdjG3h"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so1827044e87.0
        for <linux-hardening@vger.kernel.org>; Fri, 07 Feb 2025 00:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738916531; x=1739521331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lWgacNf6bh+1M33xq7pVWKEC7YnXisMf0aMe17zXEY=;
        b=pAFdjG3hWjzGQLxoHDpdj1b4hhhXrOJHHynhycsIFtDPRfqR1ZZoDycUe0Y5g28HAq
         adEVVS+Ap20q1hoM3tKEz6o+5a92xnPmorJzF5120MxzVrtctlwhitFYFbVd1ljubsUn
         Llxd8RGMtc6m5lbGFsZaEXE9BGeuPTwaBOeR4hg1Lbg3TRDJrSrfyKzMQm9fSAKxpBRt
         RaG7/4odqNWXHjUgyEUq+cMjR7zqZI0ZLnPo+aMkbx0MVXy6/YYzTyRq4XRYNhC2f6/z
         91FyE6krgACk3KcITQhRejf1gBv3YsTHx/B7pbo94SjgHuB5/w1QcLaGZmbjMUukKcEw
         2fmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738916531; x=1739521331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lWgacNf6bh+1M33xq7pVWKEC7YnXisMf0aMe17zXEY=;
        b=FH5QJ8EyTsh7LeDyJqMyBV8oHXzM/Ceu9cGMHc/hb+lxQtnsSx6O1FWyEsJ2AjGQIv
         AYchWCw19l7rVccg5jOsfU8BRiYGKPZL3jaWSZi+dX/tmJljqROSaNxE3W9OyyLydeoz
         4qEoW7iE3WmPPG47m8bDFhjI1V5Dcli8QODgisGXFFvwgm9qiqntapjzYIzvhPtfPw8G
         1AyNWeRNQsWB5ekGA7injQ64/QTgYn3dkcAPwJQPHP+SmiFgr2uh6JtDqP4rT5CaBAO+
         zqfCnqR9SLBCDZkAjMwZjdnAI2cwJqCu/MCyk+MLWQOIJjDJh/1EtuMhscMsJC3e1Jl3
         1XUA==
X-Forwarded-Encrypted: i=1; AJvYcCX04hgaWHKPU5clHBk9Vj9x61hnb5UXfo5eqMdbKVBDnMX/Qv/sdqWBP0vcgLEha5ZB4jXhGhtnfOzdPtlA0K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtFIvErDNC9F+9xAYumH5Rod1zKOneVgkdAqW7Gj2ycJ9C07O
	bPau4VrRktb4KY+blBkzcTDq4FFUPHpUAoyiIbP5CGy/kvuiytvYEIrGWTnTxZ+G4dUWudsgNr8
	0zGjbfwU0X7+YP7OtOOMJAGG1fXOnTRy0gtlA8A==
X-Gm-Gg: ASbGncskH6L0t0NtnV9T6Om1OoDtevakZ6uJkoylb4nlMyNw9utGhlZ/6R36to2kz96
	ZBjOa6xWt0ispg6kox8KiKWbjsMayPojvwogv2/APnh37eWmxgOFPz6WaQRFKAdcmFhoIuuu6Bh
	EIxamBM5WTdP1OSjX0o3FpJNLtooI=
X-Google-Smtp-Source: AGHT+IH3lOWJDEyNFqF4SGDBwbHneexUTExw4q0yk+Mr5NBkF1osQYBynSKek1iH4DjeFW9oX1ms2dpIyxQj8JRZbRo=
X-Received: by 2002:a05:6512:2389:b0:544:ecc:1f73 with SMTP id
 2adb3069b0e04-54414aed246mr591246e87.46.1738916531434; Fri, 07 Feb 2025
 00:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203121843.3183991-1-andriy.shevchenko@linux.intel.com> <20250203121843.3183991-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250203121843.3183991-6-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 7 Feb 2025 09:22:00 +0100
X-Gm-Features: AWEUYZnCo3_ak1a9oQqtz5G81m_LZsD1wsiuOglTJ_r8jftIVyyipgvKaYVayyc
Message-ID: <CAMRc=MepZEDg4=DmFu+NhbbK4dNGFgAvTuhD2SviMYESRJFnQQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] gpio: 74x164: Fully convert to use managed resources
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 1:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Convert the driver probe stage to use managed resources.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-74x164.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
> index 0f720d539fa7..920d3b9c1087 100644
> --- a/drivers/gpio/gpio-74x164.c
> +++ b/drivers/gpio/gpio-74x164.c
> @@ -95,6 +95,19 @@ static int gen_74x164_direction_output(struct gpio_chi=
p *gc,
>         return 0;
>  }
>
> +static void gen_74x164_deactivate(void *data)
> +{
> +       struct gen_74x164_chip *chip =3D data;
> +
> +       gpiod_set_value_cansleep(chip->gpiod_oe, 0);
> +}
> +
> +static int gen_74x164_activate(struct device *dev, struct gen_74x164_chi=
p *chip)
> +{
> +       gpiod_set_value_cansleep(chip->gpiod_oe, 1);
> +       return devm_add_action_or_reset(dev, gen_74x164_deactivate, chip)=
;
> +}
> +
>  static int gen_74x164_probe(struct spi_device *spi)
>  {
>         struct device *dev =3D &spi->dev;
> @@ -128,8 +141,6 @@ static int gen_74x164_probe(struct spi_device *spi)
>         if (IS_ERR(chip->gpiod_oe))
>                 return PTR_ERR(chip->gpiod_oe);
>
> -       spi_set_drvdata(spi, chip);
> -
>         chip->gpio_chip.label =3D spi->modalias;
>         chip->gpio_chip.direction_output =3D gen_74x164_direction_output;
>         chip->gpio_chip.get =3D gen_74x164_get_value;
> @@ -149,7 +160,9 @@ static int gen_74x164_probe(struct spi_device *spi)
>         if (ret)
>                 return dev_err_probe(&spi->dev, ret, "Config write failed=
\n");
>
> -       gpiod_set_value_cansleep(chip->gpiod_oe, 1);
> +       ret =3D gen_74x164_activate(dev, chip);
> +       if (ret)
> +               return ret;
>
>         return devm_gpiochip_add_data(&spi->dev, &chip->gpio_chip, chip);
>  }
> @@ -181,7 +194,6 @@ static struct spi_driver gen_74x164_driver =3D {
>                 .of_match_table =3D gen_74x164_dt_ids,
>         },
>         .probe          =3D gen_74x164_probe,
> -       .remove         =3D gen_74x164_remove,

Did you forget to remove gen_74x164_remove()?

Bart

>         .id_table       =3D gen_74x164_spi_ids,
>  };
>  module_spi_driver(gen_74x164_driver);
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
