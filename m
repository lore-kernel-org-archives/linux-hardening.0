Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9623271FD
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104765; cv=none; b=MdpbsIOKun30PcWo/ZhV5G3AGg6Vj7SIQXdsmwwkMh0+gF5i2jsBRn35AGtj6TmJd5bgsucphR/FqwJDeXQgV/ZJoBNClNTH4xrbVh5JdQKURAVEeId8AAnQCWJosqd69wuOQgqggDaAiA8snlZArW2VDfjTIKMMSPQCeG/dk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104765; c=relaxed/simple;
	bh=1yuJZujnJQq9wJqVPIoiZiDLsjPcYcNjsPmSeto0ClA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF5sxvnsJCciMC8uSHP9uc2/7p8HyeGa3eRVrA1SHs0RmATHVv7mYSvlnslyoh5oDa0wJ8NKX/bLwwkYxHjEEqaczb18g5FXz5VO7kR62J80SwXUWBLcreUGoFQ87/YRTvJ7UQE+velWiV2ZApNMJAF+xPwq+lLEIwHQQxmmGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhOvqbPZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhOvqbPZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb05b1875so1120382f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 04:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779104762; x=1779709562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7glLEzH6ZByBVkx3BNOToB7H47RR2NhR7VOuAUnFczk=;
        b=NhOvqbPZg3CekKfNxlhbRPOYzXmE32W3WSMDG5ZJ1OhN3ck+d6oLCIF3f/CtkKSFRS
         JQ8MWcnz2MMqIaiuRrcHSj9Bw1Zy+06xJ49CCWzg+n5kGJliMgmJvKdmb3HZaAQukVnP
         rcfKms4/Km4svFw/80dx7VSHMUkTLZdWsXQHeD7lh5Oq/vP4atWHYErzQEI9P2hTkW8F
         7KQnCF0HdHQ9zWj/GIvc/J1uLcP36TtVAU0L2GjbyG2ARHkjw32ihQurSveI4j+ZPnuu
         C/P6lvW+DvQss6V0uypMZG8B0jaDtbWXw+a7l48/Zf3X0lPqe8J/1Ryoqaw5ltNWSNvV
         QNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779104762; x=1779709562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7glLEzH6ZByBVkx3BNOToB7H47RR2NhR7VOuAUnFczk=;
        b=DBHjWLr7g/YYFNbyx3w7G/4/nh/duwTOISg+CRxCF3wOJ4m/QZfpGPHbLnYCduhJ0v
         t/nMMBAv4l9dIig2JoUVxnjvb4ef97RYcVPLdgMylXrb2KioQ16v0HHfsLkRUBdJfiMN
         yNcP186/hxrYVUS68moqcZWUBAMFmrwU33H984BBr5RbIOthZm7ktBgXh/kAVrf3teC3
         Fhudnmice+srVyCBEIAWOvqmrJDXisaqNwrlG6O+4L7YIlIfxap/rgdtDPK5Gb8dzGlK
         atlcWHx39kyOyGd0Xq+GXHs3GSjymuL8ujVgG8m6JmnfZ5fP3w8i5GLEpHObLuxeLvtr
         zbTw==
X-Forwarded-Encrypted: i=1; AFNElJ/wSKhQjc1511dz+ZTY9zOMONTNlxN771yjFkW9dgbDqW8xkbi88c5FWSYzu8mMDtvz7nykz5NrvTET+hPX0mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvS9PlpL/iSJlDEkzvAHtvcRed+Hskc5EQmA5kjOwDhDhG+iW
	HxtoZ4BpqPmuXKM7dS0uwxl6XEpZTWAw3Vh1pYgqxmclUR9uJPNY2pD5
X-Gm-Gg: Acq92OGbL2HkYL9fLgbuMGcYKjqfkE6JYpeejzQB7edtaxkLW/34/RTrXqWieaSnbT+
	biY/eLxbbvKrtqXWvZYnwYCQP0Ty2ulVKOPxksDzzML6rEQ7Xn4m/vwjfhhzyF29StYuuS2l2/c
	5HCJiZKBimEkH8XgVN8qMFqpQxQsyv5IolXW2egUaUCvXyVbMpYMpA0FbsBf44Xncf/eqVgy9kA
	KVs078mMZ6+M7stZGNcdYh+9uoids3TEgeYa/X/6M1qnMuj0Bbze0u2VaubDY0DrlEdzEm9W17g
	+GOvgpb9LZ1g9tQQgKoII9XD227Mi+Mf6n5cURhpo6gNwa7CAY8NspTKbPGAHAwPtCtf1S/HmIO
	6ezkw+VvgA6+cr8J2JggJq2hAf4V9KglgXpufq4U4BtW8Otumd4OkfOkrfJdq7sp05tKj3Ypu8+
	AdEB23PDY8ltpDhycg5NB4xEDm52MYS7lujXiM8NwjW8uGbO/J7BEqPrpZPtUVifQ9zz3+LMBKb
	/W+gWE7llX8eu+bx87mwguxc1T7chS/qmu7GN9CoPuKmMFr6kiC1DzYk92l
X-Received: by 2002:a05:6000:2f87:b0:452:c246:ab7a with SMTP id ffacd0b85a97d-45e5c5beb43mr23682888f8f.14.1779104761877;
        Mon, 18 May 2026 04:46:01 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm33901792f8f.24.2026.05.18.04.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:46:01 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 18 May 2026 12:45:55 +0100
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 06/13] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <3hmrlvjzxoh6vasxdku36sin25g36ienzqingm5iu6gqtkeduj@4dxxraojyfic>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-6-31599c88314a@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517-ad9910-iio-driver-v5-6-31599c88314a@analog.com>

On 26/05/17 07:20PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] Incorrect usage of `device_property_read_u32_array` causes single-value property `output-range-microamp` to be ignored.
> - [High] VCO_SEL field is incorrectly set to an out-of-bounds value (7) when the PLL is bypassed.
> - [High] Stack out-of-bounds read in `ad9910_profile_set()` triggered by unvalidated GPIO descriptor count.
> - [High] Missing resource teardown: device reset line is never asserted on driver removal.
> - [Medium] PLL multiplier clamping logic violates the hardware's minimum VCO operating frequency.
> - [Medium] Missing hardware initialization delay after reset deassertion can cause SPI communications to fail.
> --
> 
> commit fb6e130c7d866653f35ab965acf927500a84756c
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> iio: frequency: ad9910: initial driver implementation
> 
> Add the core AD9910 DDS driver infrastructure with single tone mode
> support. This includes SPI register access, profile management via GPIO
> pins, PLL/DAC configuration from firmware properties, and single tone
> frequency/phase/amplitude control through IIO attributes.
> 
> > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > new file mode 100644
> > index 0000000000000..c7b1e474c92df
> > --- /dev/null
> > +++ b/drivers/iio/frequency/ad9910.c
> [ ... ]
> > +static int ad9910_set_sysclk_freq(struct ad9910_state *st, u32 freq_hz,
> > +				  bool update)
> > +{
> [ ... ]
> > +		tmp32 = clamp(tmp32, DIV_ROUND_UP(AD9910_PLL_OUT_MIN_FREQ_HZ, refclk_freq_hz),
> > +			      AD9910_PLL_OUT_MAX_FREQ_HZ / refclk_freq_hz);
> > +		tmp32 = clamp(tmp32, AD9910_PLL_MIN_N, AD9910_PLL_MAX_N);
> > +		sysclk_freq_hz = refclk_freq_hz * tmp32;
> 
> Is it possible for this second clamp to drop the multiplier below the
> minimum frequency constraint? If the input reference clock is 3.2 MHz,
> the first clamp would raise the multiplier to 132 to reach 420 MHz, but
> the second clamp limits it to 127. This results in a VCO frequency of
> 406.4 MHz, violating the hardware minimum. Should the driver return
> -ERANGE instead if the bounds cannot be satisfied?

I suppose that would not be problematic as the PLL does accept that input
frequency. Even though the VCO might not be designed for frequencies as low as
406.4 MHz, we are doing the best effort here to get a proper configuration.
 
> [ ... ]
> > +	} else {
> > +		tmp32 = DIV_ROUND_CLOSEST(refclk_freq_hz, freq_hz);
> > +		tmp32 = clamp(tmp32, 1U, 2U);
> > +		sysclk_freq_hz = refclk_freq_hz / tmp32;
> > +		tmp32 = AD9910_CFR3_VCO_SEL_MSK |
> > +			FIELD_PREP(AD9910_CFR3_REFCLK_DIV_BYPASS_MSK, tmp32 % 2);
> > +		ret = ad9910_reg32_update(st, AD9910_REG_CFR3,
> > +					  AD9910_CFR3_VCO_SEL_MSK |
> > +					  AD9910_CFR3_REFCLK_DIV_BYPASS_MSK,
> > +					  tmp32, update);
> 
> Does setting tmp32 with AD9910_CFR3_VCO_SEL_MSK cause the update function
> to write an out-of-bounds value here? Because tmp32 contains the entire
> mask, the underlying field will be set to 7, but the valid range for the
> vco sel field is 0 to 5.

No, 6 and 7 means PLL bypassed (Table 8 in the datasheet). Also, 7 is the
default value of that bitfield.

> [ ... ]
> > +static int ad9910_profile_set(struct ad9910_state *st, u8 profile)
> > +{
> > +	DECLARE_BITMAP(values, BITS_PER_TYPE(profile));
> > +
> > +	st->profile = profile;
> > +	values[0] = profile;
> > +	gpiod_multi_set_value_cansleep(st->gpio_profile, values);
> > +
> > +	return 0;
> > +}
> 
> Could this cause an out-of-bounds read on the stack? The values bitmap is
> sized using BITS_PER_TYPE(profile), which allocates space for 1 unsigned
> long. If the device tree provides more profile gpios than fit in an unsigned
> long, gpiod_multi_set_value_cansleep() might read past the end of the bitmap
> when iterating over the descriptors.

well, profile-gpios are at most 3 pins. I'll see to constraint that in the
probe function.

> [ ... ]
> > +static int ad9910_parse_fw(struct ad9910_state *st)
> > +{
> [ ... ]
> > +	tmp[1] = AD9910_DAC_IOUT_DEFAULT_uA;
> > +	device_property_read_u32_array(dev, "output-range-microamp", tmp,
> > +				       ARRAY_SIZE(tmp));
> 
> Will this properly read a single-value property? Because ARRAY_SIZE(tmp)
> is passed as the expected element count, device_property_read_u32_array()
> might return -EOVERFLOW and leave the tmp array unmodified if only one
> value is present in the device tree, causing the property to be silently
> ignored.

Ignoring those misconfigurations might be ok too. One can refer to the
bindings to have a proper reference.

> 
> [ ... ]
> > +static int ad9910_setup(struct device *dev, struct ad9910_state *st,
> > +			struct reset_control *dev_rst)
> > +{
> > +	int ret;
> > +
> > +	ret = reset_control_deassert(dev_rst);
> > +	if (ret)
> > +		return ret;
> > +
> 
> Is a teardown action missing for the device reset here? Without adding a
> managed action to assert the reset line, the hardware might remain active
> after the driver is unloaded or if a subsequent setup step fails.

I'd say it can't remain active with the power down pin being handled already.

> Might this also require a hardware delay before the first spi write? The
> datasheet specifies waiting for the internal state machine to become ready
> after a low-to-high transition on the reset line. On fast hosts, the
> immediate spi access might be ignored.

Could not find that info in the datasheet. What is says is that the reset
clears memory elements, e.g. registers are set to default values.

> > +	ret = ad9910_reg32_write(st, AD9910_REG_CFR1,
> > +				 (st->spi->mode & SPI_3WIRE ? 0 :
> > +				 AD9910_CFR1_SDIO_INPUT_ONLY_MSK), false);
> > +	if (ret)
> > +		return ret;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com?part=6

-- 
Kind regards,

Rodrigo Alencar
