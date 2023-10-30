Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F719442
	for <linux-hardening@vger.kernel.org>; Mon, 30 Oct 2023 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b8L1xxz+"
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD0FA
	for <linux-hardening@vger.kernel.org>; Mon, 30 Oct 2023 14:44:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c515527310so69691661fa.2
        for <linux-hardening@vger.kernel.org>; Mon, 30 Oct 2023 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698702283; x=1699307083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vV6LUALjEgXum7J0cVqVp/nxnO2QeGajqSPsDE93otM=;
        b=b8L1xxz+GnVFQNWNj7UYmBrXLMk0m8IHfDRdJO+WReo0znAtSD2f3BfZ2mIq1/qnls
         cP553R5uoDYDDYznRvgZ9PAXiVsXlnCZEWzqexf+O5yrfuWlkymCVBRcFFx84IwdgEhw
         YM6XvvlO4WWuDHo7uTxzMvH5zsuU4HVQJqAKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702283; x=1699307083;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV6LUALjEgXum7J0cVqVp/nxnO2QeGajqSPsDE93otM=;
        b=dG1/230b9kmiz8dGOEPGydg/5iYeT1jtU9hz+is9aTfIrGw0OBtudBv3OzOpW+9VWa
         iqSHC4yuHfMcGq6qVIVCCumhdV1biDPRyhr+RVfPIk/82jBxdP9hDWrWWIptls6FRDeX
         FMC+wI0sgyMkOsGQGURa9dT/w2B890GVz9t0RXiHZyCN4JdBKDhKUCGiC2mRvthBx8CI
         mu0c9QXBCIWT+EXiXkV2M0+sFql2MTK4O/4ezmdFD6Rti9ssXwaabO8U/ay/Obs98T5l
         l6jPCkFMSJQyc31VHJpforTtPmvtP1yNRk0lp8KZ+zP+HRIxZkqo83mFwwF87FQ3IRnd
         yBAA==
X-Gm-Message-State: AOJu0Yz0XCaciFsJ0KEtzdSOsBMzIrAwmSXG9W6UFtrFDkINq0laflCE
	rtpA5Y038EO9K+Cp+aeH5djacFEsVToNcp72AeJAPA==
X-Google-Smtp-Source: AGHT+IHqSIzjgZOzASsrpcTN+znEYKknuoJ5PzARcbqh9kTTYG2hb257Ok/CF0rJYa5zdY6TUg1dKd9LH/gRHKUI/po=
X-Received: by 2002:a2e:9812:0:b0:2c5:844:9e75 with SMTP id
 a18-20020a2e9812000000b002c508449e75mr8625502ljj.8.1698702282875; Mon, 30 Oct
 2023 14:44:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Oct 2023 14:44:42 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231028162638.5b477ded@jic23-huawei>
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
 <20231028162638.5b477ded@jic23-huawei>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 30 Oct 2023 14:44:42 -0700
Message-ID: <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
To: Jonathan Cameron <jic23@kernel.org>, Justin Stitt <justinstitt@google.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Jonathan Cameron (2023-10-28 08:26:38)
> On Thu, 26 Oct 2023 23:53:28 +0000
> Justin Stitt <justinstitt@google.com> wrote:
>
> > We're doing some needless string copies when trying to assign the proper
> > `prop` string. We can make `prop` a const char* and simply assign to
> > string literals.
> >
> > For the case where a format string is used, let's allocate some memory
> > via kasprintf() and point prop to it.
> >
> > This also cleans up some deprecated strncpy() uses [1].
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Seems reasonable to me.
>
> +CC Gwendal (+ Stephen) as it's Gwendal's driver and I think they are still actively
> maintaining it.

Thanks! I have some review comments.

> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > index 438f9c9aba6e..c8547035cb47 100644
> > --- a/drivers/iio/proximity/sx9324.c
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -885,7 +885,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
> >  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
> >  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> >       unsigned int pin_defs[SX9324_NUM_PINS];
> > -     char prop[] = SX9324_PROXRAW_DEF;
> > +     const char *prop = SX9324_PROXRAW_DEF;

Do we need this define anymore, or the initialization?

> >       u32 start = 0, raw = 0, pos = 0;
> >       int ret, count, ph, pin;
> >       const char *res;
> > @@ -899,7 +899,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
> >       case SX9324_REG_AFE_PH2:
> >       case SX9324_REG_AFE_PH3:
> >               ph = reg_def->reg - SX9324_REG_AFE_PH0;
> > -             snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
> > +             prop = kasprintf(GFP_KERNEL, "semtech,ph%d-pin", ph);

Do we not care if the allocation fails? We just use the default?

> >
> >               count = device_property_count_u32(dev, prop);
> >               if (count != ARRAY_SIZE(pin_defs))
> > @@ -913,6 +913,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
> >                       raw |= (pin_defs[pin] << (2 * pin)) &
> >                              SX9324_REG_AFE_PH0_PIN_MASK(pin);
> >               reg_def->def = raw;
> > +             kfree(prop);

We need to free it in other places too, like if the count doesn't match.
It may be easier to extract this section and just have 4 string
literals.

	switch (reg_def->reg) {
        case SX9324_REG_AFE_PH0:
		reg_def = sx9324_parse_phase_prop(dev, reg_def, "semtech,ph0-pin");
		break;
        case SX9324_REG_AFE_PH1:
		reg_def = sx9324_parse_phase_prop(dev, reg_def, "semtech,ph1-pin");
		break;
        case SX9324_REG_AFE_PH2:
		reg_def = sx9324_parse_phase_prop(dev, reg_def, "semtech,ph2-pin");
		break;
        case SX9324_REG_AFE_PH3:
		reg_def = sx9324_parse_phase_prop(dev, reg_def, "semtech,ph3-pin");
		break;

> >       case SX9324_REG_AFE_CTRL0:
> >               ret = device_property_read_string(dev,
