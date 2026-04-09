Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14F34CFCF
	for <linux-hardening@vger.kernel.org>; Thu,  9 Apr 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752965; cv=pass; b=eSPhCf0ywvAFRX8+4IuCpOXB/NUv94Y3dc/f+N8R4UjZuo4p/jKwOQ36JJL0OzdOZJr1U+UTphVcTr18I+e3NpBiwgSs+3/gQ8OcgazuMymdZsPvomS+Q6CcUK6zQ1p4j5jSHqtXz41ZuKkDQNgLwuuY//cQj8obgdB2DkyDvpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752965; c=relaxed/simple;
	bh=hKugp+ULINOS5kKhHT2xfbsSJ2A49voOiwbZC2xAVJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEpqqLl3EV41VPuK60CJm7zwI9xW7C/cAU/pnHOMha8vJoqTNoiJscVDNsuz+U+IGyP29hkAHwYUDea9/MLm031i3Jgfy9IsiEDWTNuC7Q4qkVJNKpFWKpJTTfxbBsuC1v5BgiAHF8TtvqryiDul+FMFXnpIZjxp6guOPpcWtng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGGOkLwm; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGGOkLwm"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so175193766b.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 Apr 2026 09:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775752962; cv=none;
        d=google.com; s=arc-20240605;
        b=kSPYvsZsinkXK6JASKndECBKjS/k0bswuYufwyVIkpV+h+Y1PBW+IO2McMtpEV6HpM
         T+NOKwnFPSvm64odL4drKCQod8NJrB10Vje6hWgVRWBQ+EQYX5RQ5JhlaCLIKddhgErS
         VvqSs2brjq5vSQBtyBGqRhYfnWXl3GZXUwC7CWUtqbCd5smwtHKEaRWvNGgwvYOdJh0w
         eUVXu1+ke08mmUECVzITh7iI46v4/XTQxGAlq5CgV5AwD+K0qa33m0aOpN3XXyz4BEmM
         JGycUNnfxok/+cIMBti0LWA/dQdPcQvsaHeDJUt58dNdZGxudd1c31owjerV4XiTjF/Y
         iT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K9uJxnLGDNnIdYqHeQRahaQ1TtxtmtWKqNcMyk5dx84=;
        fh=q07t8KKrDjiJUqC3SK3izqUrphcAVuYisQmzIbMuihQ=;
        b=YS0j6734gnoxjdjT91HCB+IjtsTlslJao7HV7mx+2XoYJ88wI7o6YesbH4Ikw1sMQl
         s2Fvk5sSsMbaqXJgJqlVI3lWnrSDGIfmhD9myITuKled/sImE8ySBSNd+mS91+189Nfn
         7aZF0JIh74+Z1fr+/dpgbKI/u9O6a+lQRMLuvW4x0jnaxbrggyUIKLPdpZ9HfwfXSHAO
         uI7p3QoppAdZvtdcBRYKeig9YvmALKSsWMjeAT2ION7QDFIBwBxCo5XAfMI5ZAmDNrWj
         sP8OoR3QRsAElWRCZtksOgSgTQz7Xc782ELvTtfI7pBRrwIsHYcysMi6wOO52OA/lf8e
         qduw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775752962; x=1776357762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9uJxnLGDNnIdYqHeQRahaQ1TtxtmtWKqNcMyk5dx84=;
        b=rGGOkLwmdB8IRFT/Oqe7N1GeWMnFmyvPmwlpBOYpEtWTmvlkQ5vUML+nYnyQ+XLu5Z
         uYAcu90OfZ2fXsLW84/1mZ/8Kt6lJ39EjihhNOZEId7tTwtp80bW2XzmYdMH2IHEbd1X
         0tVv6X1WMzerHmabpmX8goj7KDAB8zZONk7qdxQaBAEDNUaFIZyELGFdKtw+T3uKZPCr
         pqVOgGDRJbwETRmB9yBZQDWiK/W+qKonJgZm4QcM3NBeIH6XWmZLoGB0eGV3PWNm7f/l
         slMZvrRRxw9Qb8Y81G/BHZpmLg5EEHYlzw4sVagAYxKWrAsNMi8kZxXrkilUUxmxq01N
         aT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775752962; x=1776357762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9uJxnLGDNnIdYqHeQRahaQ1TtxtmtWKqNcMyk5dx84=;
        b=qLVgazbm7TOQVKQyZoTXln6dOOFwSsHcQEItEA8ilJKLdX/NAO/D9zBYOZC9shoEQS
         7qZjcxFct7TAUhx99a10HNX2YMDttM4MDNxdEpHVrzmROSRP2jmvSjn0xXGWUyjxU+s8
         mFp+DKb60uuEuICU647ym1rMK4fsVengHk/67ydMHHPLDwKUnWSjATzoyTiIuG6SAVUT
         O71OD47UWEBVh04nFsKje7/bAl/DmOePfytLy4oyOdo/DJ2pUUfGWVQlwasExAr3QKKv
         ewqfa0yGlxRnIA7ReOIWn82for+I51z1O83yIlcVZMY/qYoVMnvsOdkXEX7VfpGEnF+H
         B6nw==
X-Forwarded-Encrypted: i=1; AJvYcCXt+KjERzcPaq0JUF4HVKXlhxaXDSvRDVRNi9BpCpcXjoayRrfUvGhYnL+m1avfe/llXj14/6zsB08CHMygmyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy113cm3NnFolZxErc3+x16u+qvQsng+CmpGcBOnniTxugFeT8Z
	EA/vOo+K1K7HDt5LemlSYbYLm7F+FdRCuYSrzMMSHEJ5uBAT15CORgA2oYOj7Mn6YOI3R9Zzy7r
	msXO+pHLHAkxv93TIigQ2Gw6f+Mfrayo=
X-Gm-Gg: AeBDiesrcGvdMIEsDRyBmrE4dogG/MmlDWrIroCviZOthOFKMdrojbqu8aUvsnVvJpt
	uqFJx1nlAxbcMYN6FVFxBA5GdGXMK8UBlacxlxSB2N0vXXvtsQ6FNPYR5MghgXYp0SW+YR7phyo
	P/rlp5T/A3FCJU/a8tA0+YKZfeipDSWWFTpuSly7+molRqu9lJd7MkCxUKQUqVFpQM6DvCqi9Xs
	i8VE8XmLGECqVlwhpUr2qhFOwVfKRrPcdP6BQeNVoRawHIJ5VnMk9wFUzoqS/eFpRy6ky0QnUfu
	dWkGB+QeEyTSrBjIFlUV4vgwXfFKx/MevO1C221beBL1hgb89g9wnkKsKbp3TZCu4Bgae8guAg2
	Apg0/COwA988aBNHn
X-Received: by 2002:a17:907:da9:b0:b9c:6ef1:ed18 with SMTP id
 a640c23a62f3a-b9c6ef20e65mr1388642766b.25.1775752961768; Thu, 09 Apr 2026
 09:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330211844.14796-1-rosenp@gmail.com> <20260409151253.GH3290953@google.com>
In-Reply-To: <20260409151253.GH3290953@google.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 9 Apr 2026 09:42:29 -0700
X-Gm-Features: AQROBzBXh3oiBSZQlFW_uV6Y_ikrzIX2Q3pO-LJZnyxbWTu2DIf54LLL33LjVuI
Message-ID: <CAKxU2N9xHS25zhcqwmOpXbgdMN-WDiOcDLTEgHs6WbqPuJ__dQ@mail.gmail.com>
Subject: Re: [PATCH] leds: qcom-lpg: allocate channels with main struct
To: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 8:12=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 30 Mar 2026, Rosen Penev wrote:
>
> > Use a flexible array member to combine kzalloc and kcalloc. This
> > required moving the struct lpg_channel definition up as flexible array
> > members require a full definition.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/leds/rgb/leds-qcom-lpg.c | 117 +++++++++++++++----------------
> >  1 file changed, 56 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-q=
com-lpg.c
> > index f6061c47f863..83cedf4a0cbf 100644
> > --- a/drivers/leds/rgb/leds-qcom-lpg.c
> > +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> > @@ -80,58 +80,8 @@
> >  #define SDAM_PAUSE_HI_MULTIPLIER_OFFSET      0x8
> >  #define SDAM_PAUSE_LO_MULTIPLIER_OFFSET      0x9
> >
> > -struct lpg_channel;
> >  struct lpg_data;
> >
> > -/**
> > - * struct lpg - LPG device context
> > - * @dev:     pointer to LPG device
> > - * @map:     regmap for register access
> > - * @lock:    used to synchronize LED and pwm callback requests
> > - * @pwm:     PWM-chip object, if operating in PWM mode
> > - * @data:    reference to version specific data
> > - * @lut_base:        base address of the LUT block (optional)
> > - * @lut_size:        number of entries in the LUT block
> > - * @lut_bitmap:      allocation bitmap for LUT entries
> > - * @pbs_dev: PBS device
> > - * @lpg_chan_sdam:   LPG SDAM peripheral device
> > - * @lut_sdam:        LUT SDAM peripheral device
> > - * @pbs_en_bitmap:   bitmap for tracking PBS triggers
> > - * @triled_base: base address of the TRILED block (optional)
> > - * @triled_src:      power-source for the TRILED
> > - * @triled_has_atc_ctl:      true if there is TRI_LED_ATC_CTL register
> > - * @triled_has_src_sel:      true if there is TRI_LED_SRC_SEL register
> > - * @channels:        list of PWM channels
> > - * @num_channels: number of @channels
> > - */
> > -struct lpg {
> > -     struct device *dev;
> > -     struct regmap *map;
> > -
> > -     struct mutex lock;
> > -
> > -     struct pwm_chip *pwm;
> > -
> > -     const struct lpg_data *data;
> > -
> > -     u32 lut_base;
> > -     u32 lut_size;
> > -     unsigned long *lut_bitmap;
> > -
> > -     struct pbs_dev *pbs_dev;
> > -     struct nvmem_device *lpg_chan_sdam;
> > -     struct nvmem_device *lut_sdam;
> > -     unsigned long pbs_en_bitmap;
> > -
> > -     u32 triled_base;
> > -     u32 triled_src;
> > -     bool triled_has_atc_ctl;
> > -     bool triled_has_src_sel;
> > -
> > -     struct lpg_channel *channels;
> > -     unsigned int num_channels;
> > -};
> > -
> >  /**
> >   * struct lpg_channel - per channel data
> >   * @lpg:     reference to parent lpg
> > @@ -216,6 +166,55 @@ struct lpg_led {
> >       struct lpg_channel *channels[] __counted_by(num_channels);
> >  };
> >
> > +/**
> > + * struct lpg - LPG device context
> > + * @dev:     pointer to LPG device
> > + * @map:     regmap for register access
> > + * @lock:    used to synchronize LED and pwm callback requests
> > + * @pwm:     PWM-chip object, if operating in PWM mode
> > + * @data:    reference to version specific data
> > + * @lut_base:        base address of the LUT block (optional)
> > + * @lut_size:        number of entries in the LUT block
> > + * @lut_bitmap:      allocation bitmap for LUT entries
> > + * @pbs_dev: PBS device
> > + * @lpg_chan_sdam:   LPG SDAM peripheral device
> > + * @lut_sdam:        LUT SDAM peripheral device
> > + * @pbs_en_bitmap:   bitmap for tracking PBS triggers
> > + * @triled_base: base address of the TRILED block (optional)
> > + * @triled_src:      power-source for the TRILED
> > + * @triled_has_atc_ctl:      true if there is TRI_LED_ATC_CTL register
> > + * @triled_has_src_sel:      true if there is TRI_LED_SRC_SEL register
> > + * @channels:        list of PWM channels
> > + * @num_channels: number of @channels
> > + */
>
> Should we be reordering the kerneldoc descriptions for '@channels' and
> '@num_channels' here to correctly match the updated order in the struct b=
elow?
Yeah probably.
>
> > +struct lpg {
> > +     struct device *dev;
> > +     struct regmap *map;
> > +
> > +     struct mutex lock;
> > +
> > +     struct pwm_chip *pwm;
> > +
> > +     const struct lpg_data *data;
> > +
> > +     u32 lut_base;
> > +     u32 lut_size;
> > +     unsigned long *lut_bitmap;
> > +
> > +     struct pbs_dev *pbs_dev;
> > +     struct nvmem_device *lpg_chan_sdam;
> > +     struct nvmem_device *lut_sdam;
> > +     unsigned long pbs_en_bitmap;
> > +
> > +     u32 triled_base;
> > +     u32 triled_src;
> > +     bool triled_has_atc_ctl;
> > +     bool triled_has_src_sel;
> > +
> > +     unsigned int num_channels;
> > +     struct lpg_channel channels[] __counted_by(num_channels);
> > +};
> > +
> >  /**
> >   * struct lpg_channel_data - per channel initialization data
> >   * @sdam_offset:     Channel offset in LPG SDAM
> > @@ -1475,12 +1474,6 @@ static int lpg_init_channels(struct lpg *lpg)
> >       struct lpg_channel *chan;
> >       int i;
> >
> > -     lpg->num_channels =3D data->num_channels;
> > -     lpg->channels =3D devm_kcalloc(lpg->dev, data->num_channels,
> > -                                  sizeof(struct lpg_channel), GFP_KERN=
EL);
> > -     if (!lpg->channels)
> > -             return -ENOMEM;
> > -
> >       for (i =3D 0; i < data->num_channels; i++) {
> >               chan =3D &lpg->channels[i];
> >
> > @@ -1603,18 +1596,20 @@ static int lpg_init_sdam(struct lpg *lpg)
> >
> >  static int lpg_probe(struct platform_device *pdev)
> >  {
> > +     const struct lpg_data *data;
> >       struct lpg *lpg;
> >       int ret;
> >       int i;
> >
> > -     lpg =3D devm_kzalloc(&pdev->dev, sizeof(*lpg), GFP_KERNEL);
> > +     data =3D of_device_get_match_data(&pdev->dev);
> > +     if (!data)
> > +             return -EINVAL;
> > +
> > +     lpg =3D devm_kzalloc(&pdev->dev, struct_size(lpg, channels, data-=
>num_channels), GFP_KERNEL);
> >       if (!lpg)
> >               return -ENOMEM;
> >
> > -     lpg->data =3D of_device_get_match_data(&pdev->dev);
>
> You just NULL-ptr-derefed yourself.  Did you test this?
This can never return NULL. All compatible entries have a
corresponding data value pointing to a statically allocated struct.
>
> > -     if (!lpg->data)
> > -             return -EINVAL;
> > -
> > +     lpg->num_channels =3D data->num_channels;
> >       lpg->dev =3D &pdev->dev;
> >       mutex_init(&lpg->lock);
> >
> > --
> > 2.53.0
> >
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
