Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E413FD121
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003411; cv=none; b=bYUmf4IWQPyes5WaMZnPJVkRyAEc3Qvj9ZphY8nb2zf48BRCcR/x9axFvW85EOQLNmuu0XtUTq2x2P2fjAlA00I0S7YE0kcogmKQgEhIM7Cb1+/A1Q/hpmv6T6lkxiuIHrFySIKl5JXmNUasDZHBV4vcKbfpE9YxYdicDdY5+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003411; c=relaxed/simple;
	bh=O96mv8mCUvT/nFQ/0Yz/BMdNzocH7igS6slnSuH/62I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC8wwKWf1nG7Y4ReBJBVpb1avFwk/f3Luds8ubtwTNwPUDaOdZTvE6doeYAoDqBbPFwmlYOT7lMFSA8zG6YI9GW+2ATmN+77WBe2uxvq2e5SmLBS4byYj9Xkatjf376L7hV18wdHyMTinS62MTuZnjb/KCljg+u4Ouw0EjkDq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azXwWHL4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azXwWHL4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bf1141c26ecso675559166b.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781003408; x=1781608208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0yh8TvfY56yWAGeoqd/6TqfqKFvUUqJuJp99zBnrgzQ=;
        b=azXwWHL4pit0vmy+wMuCdUzscxnvavh1Z3A1HVepUc21BC/5BemKKolzz4jd81Mh40
         JsZvTkcEb1WePPAfDRVpPL+uou3TWBvv+rxYW8LPJf3brCa81u5rQ3JlINXEyxYsikJX
         h7AzlKuSoy3+XZvcXTLJVpNjK0AkB2xY1rrbBu/OHLkNLDabGm7J4VoF9qiT10Pv5LNt
         IEQDaCkDq04zkElPYuEXSBmqflHeE5g4q70bjnGTcGL2vkpD+6KcpwYh9BsfLQVoFPH8
         5ND+A7HZOhuuFvO57glRcvPbCU9/9wVZpJPE8pDTIgx39nzGd5PBp1QfxTeCA4dqcIcK
         WraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003408; x=1781608208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yh8TvfY56yWAGeoqd/6TqfqKFvUUqJuJp99zBnrgzQ=;
        b=gpidrliWBTA+tjCaz5552bbRYy0rCHLrtZv/SF7EvsqtjYiHXtBi77ERnfTCzY80Rr
         O21RvmOfZW7zXVj4t4HDNIGQBBxWjAxPO5l/v1J4OX9GFXCKjQEdmBGLezw+8zwcl5yb
         e9YftRwpjulvSMhURhAfGGgf9h5GnAtntC0NSGlwcxnlJmZbXwdXRrZQV8sdr9hfiLgS
         RV9jsLsmlaQuq0jjCti/+lE5Tx3Q143+jy48Flng9P2DPgwd5STVY81BWmFlmuZxbkzu
         w5VHptaQnwNl+vDPkib5ox3BO14wKCDwEsQ+o5QLNuL1r3DdZ4lnBNglafd+7FL+hjtu
         qunA==
X-Forwarded-Encrypted: i=1; AFNElJ9L0sxYY7wzKTTgwV78clSSLbstf/E/+QIRETe6ppdrrBFIOA6vLbDSHuOA7wo98+yHr0oaQX+c9zwyoKpXUNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjqjlYl7ReLwyqH4Q0WHEY8H3vVCmaUe6o5UuyQtKuFxTOo5C
	/MmX2jwZySWiVjTvI/7wli2BcI3yBFdy/jND88+O+MUTA6e2ahek0Fpl
X-Gm-Gg: Acq92OG5opnW19hXuD74kHI/G/riy7J6dRM/q0nzaxDdbZV4dhHfSkUTTwjnC5CbUaH
	uy0l31Ia9KYE02dzYGIZqn/BMVOPi1leOREJWD5B1A2bSV1XNf7d/jacbN58jXems1JF3klgcPj
	bq24RkqG6MW6ZbgQB346AppmmISDNtzYH+1e+YomPjGh6vm4AP3ygVVeRoClcmoyDQgSMxm4BhF
	wtWJY9lT9axt9DogMd0s1SzazMDpcGHWWpOOhs1zj8sguLiG3odepNKjLnTeEpu4r+TTCevIwmk
	OA/fEtYAOjTiTu/oAgRczW+M2quR3Ydgy9taMcGMTu2fauZ29PM1ghJ3jLpKA0NHIJPjA4+0TSA
	UFISIUCjsOvQ8TC5Ze09MJ/CMRKAx/D5aTvO/Saoy3aEor1Z7mFG/FZbBhI9mhANClnKD9iD4Rj
	sV8NnzVMHP0PBXZPDeBJ9aPfQuDVg4E/rNYg8g+bl4TqOwEY+W/P3Hixc1duBbwmQgV6OW3nCNJ
	TOw3QzgZaiX9N+VIAHNMwDH1dL2mc9EHJWsoDb57mwfyiCy4A==
X-Received: by 2002:a17:906:f5aa:b0:bec:6c5c:cced with SMTP id a640c23a62f3a-bf372159bf0mr1067104666b.28.1781003408041;
        Tue, 09 Jun 2026 04:10:08 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051c83c93sm1046788266b.16.2026.06.09.04.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:10:07 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 9 Jun 2026 12:10:02 +0100
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, 
	linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 12/12] iio: dac: ad5686: add gain control support
Message-ID: <luo2bvidr3h5gz5qb3ettl2rzzgjsdi6invgzgmm6dx7rki7gn@6faoaxv44vxr>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
 <20260609-ad5686-new-features-v2-12-70b423f5c76d@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609-ad5686-new-features-v2-12-70b423f5c76d@analog.com>

On 09/06/26 10:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] ABI Violation: Exposing a writable sysfs attribute to fix a static hardware configuration.
> - [Medium] State Inconsistency: `st->double_scale` is not rolled back if hardware synchronization fails.
> - [Low] Data Race: Lockless read of `st->double_scale` can race with concurrent writes.
> --
> 
> commit 7fefd2fd08838a6ee5a81a3a819607e02af9d85d
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> iio: dac: ad5686: add gain control support
> 
> This commit adds support for a 2x gain multiplier applied to the output
> voltage. This provides a gain control through a bit field in the control
> register or a dedicated GAIN pin, exposing the scale property as configurable.
> 
> > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > index d9022c6a32016..d49390af71f90 100644
> > --- a/drivers/iio/dac/ad5686.c
> > +++ b/drivers/iio/dac/ad5686.c
> 
> [ ... ]
> 
> > @@ -192,9 +196,14 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
> >  			GENMASK(chan->scan_type.realbits - 1, 0);
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_SCALE:
> > -		*val = st->vref_mv;
> > -		*val2 = chan->scan_type.realbits;
> > -		return IIO_VAL_FRACTIONAL_LOG2;
> > +		if (st->double_scale) {
> > +			*val = st->scale_avail[2];
> > +			*val2 = st->scale_avail[3];
> > +		} else {
> > +			*val = st->scale_avail[0];
> > +			*val2 = st->scale_avail[1];
> > +		}
> > +		return IIO_VAL_INT_PLUS_NANO;
> 
> [Severity: Low]
> Is it possible for a data race to occur here?
> 
> In ad5686_read_raw(), the mutable software state st->double_scale is read
> to determine the returned scale values without holding the st->lock mutex.
> 
> Because st->double_scale can be concurrently modified by ad5686_write_raw()
> (which properly acquires st->lock), this can lead to reading a prematurely
> updated state before the hardware configuration has actually completed.

Valid concern, will add guarded mutex lock in read_raw to the previous patch.
 
> >  	}
> >  	return -EINVAL;
> >  }
> 
> [ ... ]
> 
> > @@ -216,6 +225,63 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
> >  
> >  		return ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> >  				    chan->address, val << chan->scan_type.shift);
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (val == st->scale_avail[0] && val2 == st->scale_avail[1])
> > +			st->double_scale = false;
> > +		else if (val == st->scale_avail[2] && val2 == st->scale_avail[3])
> > +			st->double_scale = true;
> > +		else
> > +			return -EINVAL;
> > +
> > +		switch (st->chip_info->regmap_type) {
> > +		case AD5310_REGMAP:
> > +			return ad5310_control_sync(st);
> > +		case AD5683_REGMAP:
> > +			return ad5683_control_sync(st);
> 
> [Severity: Medium]
> Should st->double_scale be restored to its previous value if the hardware
> synchronization fails?
> 
> In ad5686_write_raw(), st->double_scale is updated before the driver attempts
> to push the change to the DAC via ad5310_control_sync(st) or
> ad5683_control_sync(st). 
> 
> If the underlying SPI/I2C write fails, the function immediately returns the
> error code without rolling back st->double_scale.
> 
> This could cause the driver's cached state to diverge from the actual
> hardware configuration, causing future reads of the scale to return the
> incorrect updated value.

Will ignore that and assume that SPI write error is a platform problem.
At another attempt the cached value can take effect.

> 
> > +		case AD5686_REGMAP:
> > +			/*
> > +			 * Even if the gain pin is hardwired on the board, the
> > +			 * user is able to control the scale such that it
> > +			 * matches the actual gain setting.
> > +			 */
> > +			gpiod_set_value_cansleep(st->gain_gpio,
> > +						 st->double_scale ? 1 : 0);
> > +			return 0;
> 
> [Severity: Medium]
> Does this expose a writable sysfs attribute to fix a static hardware
> configuration?
> 
> The commit introduces a writable scale sysfs attribute to allow users to manually
> match the software scale to a hardwired gain pin. Static hardware properties
> should typically be described via firmware properties (e.g., Device Tree) so
> the driver can expose the correct, immutable scale at initialization.
> 
> If the GAIN GPIO is absent, writing to the scale attribute returns success but
> does not change the physical hardware state, leading to a silent desynchronization
> between the reported scale and the actual physical DAC output.
> 
> Could this mislead generic IIO clients by presenting multiple available scales
> that they believe they can dynamically toggle?

No sure if this is a big concern (assuming that the user has knowledge of the hardware).
An option is to add another dt property to indicate that the gain is doubled in hardware.
Such property cannot be defined alongside the ldac-gpios property. 
 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com?part=12

-- 
Kind regards,

Rodrigo Alencar
