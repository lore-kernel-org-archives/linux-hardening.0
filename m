Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C63C65E0
	for <linux-hardening@vger.kernel.org>; Sun, 17 May 2026 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041280; cv=none; b=lT0jkRvIHpTrTgDbxUz8WWgegs2UXPThyzlnKt4BAWT9fWvggyQt7FjOBV6juBYkAekUK7gKrDihXlRxDFxMTRh3douOOI039dyj3lApIfFiip8ZI7O774H5somQQ3kC6G25NWz0NxtC+ifD0vjc6/VTALJNdAJ3T5gsLRU9PAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041280; c=relaxed/simple;
	bh=AgfMqLVnS6YuQEuhwKQ5hHW609zHtmx345KIezt5J0Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu0YTEORlgE59nd/SEeEfXujXxIru03kj7lJk6OhuQMxkG13EMq3Wv3hioXDA0xF/fQxL4VxKABM4lsy1285+SB1UcJPe4/MiHEIyF4T5sU+Pu9AWK1iXetUztdsJr9Hv6ARtqzI8wbh+ntjInkfvVd9xbePnZbq4Mqx6k1W0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=li7PDmv8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li7PDmv8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e82c23840so9532565e9.3
        for <linux-hardening@vger.kernel.org>; Sun, 17 May 2026 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779041276; x=1779646076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+S9zwilvrDZ3FX02ClZfVO+ZKyFuGBJXYxf1fRCPzCo=;
        b=li7PDmv8FHkRGCK5JWionVWSsCu/eAuom7LVWZy8NjjvGqJUYAFa9Ve4SlEAdC0/y4
         1jImpBXIaFKfkplHSBlumQFnHeM41uBnNAq1SZHtYqE3rsXLdmXCC/ZeUiNnoVJ4Rxdm
         1oOnslkuTX/r2AT/3+fUjio0cJowKSNW2voVMOysHqGESysD/Y03YDrxz4kM6dSFdT4Z
         4Txae3DGDzGWHnSCbdjATNm7nkYb8aJSLkQYTAssZCAOxQzgK6H95x+kllytJEslWR5k
         SdndN7gaf1aGMF8BAEXqnbBQZSUB2pTfgjCnd82H7bBMwjPHCk5ppTVCsvRZL3TiJdNV
         DLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041276; x=1779646076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S9zwilvrDZ3FX02ClZfVO+ZKyFuGBJXYxf1fRCPzCo=;
        b=JKcBIfBG9FarLPe6xPm1+PjKmjZDJY3XHedKuJ18Z47BYDr27rYLPZ5KEjfj8vluyo
         WtOIXhFsf7U6/sRtAgXnfHVfV9nEVwMtfRZYvwIY0O3LjsCE4A8663iSsKik2bHnvBTd
         ltcYal6LZjJb4Ateh2auiYsAInjgGTP9f77v0wQ61prrUeIXtOpiLtWfvBjGUZEbVCR7
         NrAPPyVfY/dXZNrxv0A0e98vx8rSDAhQNKU6IbuuakUl7hvGbSjEFXrrnlNCyhEGx+mB
         qve8pGANey2y+oA8auTLhQq0zPmrd0Z8Wu4lOUUAIpLHabrMygSzjrgM43Cq9VMnEZ71
         XxWw==
X-Forwarded-Encrypted: i=1; AFNElJ+EylzDDRoG1q/L7buXvol7EF7Y8S2GA8ZQ+hO1BRCrq2gLcCf8ri9Lr+5Ye2WTwAmHGJGRVywakQ+XAUn1PzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+A0J1MIPasUhcgqiXU9qzMC7FWwSRkUHjTwa25ub0Uy3nSBcI
	JotQIj+ZZjeWe6m+Jlzzgt8g4vAPn7VIoVBEbOUMK5psiXWy3ssaiD1u
X-Gm-Gg: Acq92OETz244tZD3DflxbJR7u6+5YqytPMzUEO4wjvHjCXB5TibtpUL6x8pzMGNvOsJ
	zy6ucZipyl2QQZUX5HYMokeUz/mE0DvTXsx9XoX1olryHGHbGsJcNNYLlkHuTW58W3KqLRI9piE
	gqxbaisg1krAcO4TQQHKJQPusyLkydSYbxwbldKm0CzQqWmoze/bEUrtbCQWWGuh2g1smvkhPy1
	eGLdWhWDpZ8lqXbN3vOyBMZk/3ZVF5ABLtFzjlVaPfJzDuq8EbfwgSf9J3Iz1Vxg94b2gpZJ3X0
	179Ud6XASSzbbPZpJB8WrRn0CzY8gWSKWNbi/NQ5a/YCW0VSrUKjEa9WSGLb4zvMMmmJ4kPw7wX
	HHzDRr+2QtBZcOa529qh4XO3kznK2Tf23/cI3UPI/Mk+IRwuyVYf74QUiBfFAEEQtyS0pENRGEU
	5vLFjh0sNtHjtyz9EMMYofMp5c549k6q2JQ7Dq92OSxtBHcUkuJrr+1CaVajrkYA9XCO2RFXCJ3
	4eqE5FP65T2zoBpir9vZ0CbYtHSX8uOJ+0iQtYtRGsMOTpz/g==
X-Received: by 2002:a05:600c:8189:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48fe6323addmr185385535e9.21.1779041275890;
        Sun, 17 May 2026 11:07:55 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4862209sm207107125e9.0.2026.05.17.11.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:07:55 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 17 May 2026 19:07:53 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 03/10] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <is4rbxohz5icbaslatmjmzhb5oztnh6ytmntgkn3rssjijppb3@mur2heagprdi>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-3-d26bfd20ee3d@analog.com>
 <20260517154745.5fbfcabf@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517154745.5fbfcabf@jic23-huawei>

On 26/05/17 03:47PM, Jonathan Cameron wrote:
> On Fri, 08 May 2026 18:00:19 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add the core AD9910 DDS driver infrastructure with single tone mode
> > support. This includes SPI register access, profile management via GPIO
> > pins, PLL/DAC configuration from firmware properties, and single tone
> > frequency/phase/amplitude control through IIO attributes.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> Hi Rodrigo
> 
> A few really minor things from a fresh look through.
> 
> Jonathan
> 
> > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > new file mode 100644
> > index 000000000000..c75f2ef178c2
> > --- /dev/null
> > +++ b/drivers/iio/frequency/ad9910.c
> 
> > +
> > +static int ad9910_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long info)
> > +{
> > +	struct ad9910_state *st = iio_priv(indio_dev);
> > +	u64 tmp64;
> > +	u32 tmp32;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_ENABLE:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			if (ad9910_sw_powerdown_get(st)) {
> > +				*val = 0;
> > +			} else {
> > +				tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +				*val = (tmp32 == st->profile);
> > +			}
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_FREQUENCY:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			tmp64 = FIELD_GET(AD9910_PROFILE_ST_FTW_MSK,
> > +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		tmp64 *= st->data.sysclk_freq_hz;
> > +		*val = tmp64 >> 32;
> > +		*val2 = ((tmp64 & GENMASK_ULL(31, 0)) * MICRO) >> 32;
> 
> Why in this particular case have this outside the switch / case whereas in others
> you do the full maths and set inside? I'd put it inside and not worry about slightly
> long lines.

for frequency, those calculations are going to be common for the other channels that are
going to be populated by other patches...

DRG up/down and RAM will have tmp64 populated with a FTW value.

> 
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_PHASE:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			tmp64 = FIELD_GET(AD9910_PROFILE_ST_POW_MSK,
> > +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> > +			tmp32 = (tmp64 * AD9910_MAX_PHASE_MICRORAD) >> 16;
> > +			*val = tmp32 / MICRO;
> > +			*val2 = tmp32 % MICRO;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			tmp64 = FIELD_GET(AD9910_PROFILE_ST_ASF_MSK,
> > +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> > +			*val = 0;
> > +			*val2 = tmp64 * MICRO >> 14;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PHY:
> > +			*val = st->data.sysclk_freq_hz;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> 
> 
> > +
> > +static int ad9910_setup(struct device *dev, struct ad9910_state *st,
> > +			struct reset_control *dev_rst)
> > +{
> > +	int ret;
> > +
> > +	ret = reset_control_deassert(dev_rst);
> > +	if (ret)
> > +		return ret;
> No need to sleep at all after bringing device out of reset?
> 
> Sashiko has reasonably been asking about this in other drivers. If there
> is no period needed or it is so quick as to be irrelevant add a comment here.

I do not see any requirement on that in the datasheet.

> > +
> > +	ret = ad9910_reg32_write(st, AD9910_REG_CFR1,
> > +				 AD9910_CFR1_SDIO_INPUT_ONLY_MSK, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_add_action_or_reset(dev, ad9910_sw_powerdown_action, st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad9910_reg32_write(st, AD9910_REG_CFR2,
> > +				 AD9910_CFR2_AMP_SCALE_SINGLE_TONE_MSK |
> > +				 AD9910_CFR2_SYNC_TIMING_VAL_DISABLE_MSK |
> > +				 AD9910_CFR2_DRG_NO_DWELL_MSK |
> > +				 AD9910_CFR2_DATA_ASM_HOLD_LAST_MSK |
> > +				 AD9910_CFR2_SYNC_CLK_EN_MSK |
> > +				 AD9910_CFR2_PDCLK_ENABLE_MSK, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad9910_cfg_sysclk(st, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad9910_set_dac_current(st, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ad9910_io_update(st);
> > +}
> 

-- 
Kind regards,

Rodrigo Alencar
