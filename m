Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H+HCa4Du"
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA1D0
	for <linux-hardening@vger.kernel.org>; Wed, 13 Dec 2023 16:59:06 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso105240281fa.0
        for <linux-hardening@vger.kernel.org>; Wed, 13 Dec 2023 16:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702515544; x=1703120344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLPQRFERPZKZe4sP96FP5UOkMogbBRWOBLXtIS+wgKA=;
        b=H+HCa4Dum7Yqt6M+Vya5PNZ9+zhC6v6nSGCkjXiZNSJL8vobmRR9jQwjxW9HeiWm6H
         SeWzH4GxlydbCrGFArGv7H1LSq0cu1QFXCQsoQ8RV8qH00V/rvt2NhGll4r2mMlY8KJV
         khPbSsqL01hzPqoON5GpJEB1bXDyXt7eVLVB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515544; x=1703120344;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLPQRFERPZKZe4sP96FP5UOkMogbBRWOBLXtIS+wgKA=;
        b=OXH41opQyjnaVBeWIF5RfeKl5+1HoYquMmce4nkT9ccEcBlzgmA9wPVYvX3ftFqYvP
         9gVg5wAIlNB5AWetebhKyfRmG8OV+hVpotGTwjrMjJzdJOxpNK0iYXNNuiIdThQie7Xt
         h3m1owKyB1I05W05axYP1uCg5ZHZ2c08fJA3VHTzaxCUWrKHtTnLNXyq2qVwzx/j+MiF
         43BKirDbjxe9JlYywzNDJXbdUC8R6UAvq1PExhAaK0oESHpYZEpb90bT8u1yiRh66Yrl
         Dnk0+gC5B4bGoKXmBm/A2opvdqtYYpLHjU7qoYZRF6oi3OAfwhc2sJgKT8WggWrYzDC8
         M5Kg==
X-Gm-Message-State: AOJu0Yzq6M/qDUCeKTdAUBAxjLmutdyoqaeXUmqu+oSd2xGeaGFcMB+B
	awny3r9zp7H9olgNCPrR1QDP6IklfhXoVry3p/jdrw==
X-Google-Smtp-Source: AGHT+IEunZGd9tNek4p895u1vSnibbU895Lddmz8b+pc8eZ7RAYfA5ccHN3CMRjZTHj2uRjOAKt0XYWsogRcyShRfeY=
X-Received: by 2002:a2e:a4b8:0:b0:2cc:1d91:83fc with SMTP id
 g24-20020a2ea4b8000000b002cc1d9183fcmr2754449ljm.30.1702515544589; Wed, 13
 Dec 2023 16:59:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 16:59:04 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
References: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 13 Dec 2023 16:59:04 -0800
Message-ID: <CAE-0n50U47OKs50bOf91HoOayVJEj=H6P-cpyZ_46pX8CVZ4BQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: sx9324: avoid copying property strings
To: Jonathan Cameron <jic23@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Justin Stitt (2023-12-11 16:42:52)
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 438f9c9aba6e..e3bc30b57b19 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -873,6 +873,32 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
>                                         20000, 2000000);
>  }
>
> +static u32 sx9324_parse_phase_prop(struct device *dev,

return u8? because that's the type of struct sx_common_reg_default::def.

> +                                  struct sx_common_reg_default *reg_def,
> +                                  int idx, const char *prop)
> +{
> +       unsigned int pin_defs[SX9324_NUM_PINS];
> +       int count, ret, pin;
> +       u8 default_def;
> +       u32 raw = 0;
> +
> +       default_def = sx9324_default_regs[idx].def;

Do we need to do this? Isn't this reg_def->def?

> +
> +       count = device_property_count_u32(dev, prop);
> +       if (count != ARRAY_SIZE(pin_defs))
> +               return default_def;

return reg_def->def?

> +       ret = device_property_read_u32_array(dev, prop, pin_defs,
> +                                            ARRAY_SIZE(pin_defs));
> +       if (ret)
> +               return default_def;

return reg_def->def?

> +
> +       for (pin = 0; pin < SX9324_NUM_PINS; pin++)
> +               raw |= (pin_defs[pin] << (2 * pin)) &
> +                      SX9324_REG_AFE_PH0_PIN_MASK(pin);
> +
> +       return raw;
> +}
> +
>  static const struct sx_common_reg_default *
>  sx9324_get_default_reg(struct device *dev, int idx,
>                        struct sx_common_reg_default *reg_def)
> @@ -884,35 +910,30 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  #define SX9324_PIN_DEF "semtech,ph0-pin"
>  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
>  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"

Can you send a followup to remove these defines?

> -       unsigned int pin_defs[SX9324_NUM_PINS];
> -       char prop[] = SX9324_PROXRAW_DEF;
> +       const char *prop = SX9324_PROXRAW_DEF;

This can be left unassigned now, right?

>         u32 start = 0, raw = 0, pos = 0;
> -       int ret, count, ph, pin;
>         const char *res;
> +       int ret;
