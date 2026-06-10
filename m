Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1528391E52
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079934; cv=none; b=rMJlwZJRkmsGYHqMJ+j1xaQZxdL0Ssbb0+LOKwXcxzvYoWqTP3UKQWruntSJnd74LZhFHzP94xBcyhhg25uBIL7bP8QBpzByqoV+hsbAQ1k+kNpgnh1pszr2fm6/btY/SoIONQMD2GrAg43FX6gz+rj1MrVcCYWWrFX9mOnTCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079934; c=relaxed/simple;
	bh=XufgtRG46mdSA4Xe5u8SghU6O2aObVMltjAQFLvDA1A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEs3ylA62ckFHSYpZf9kyyFE84JX8Gug3E4RlE99DlZoBrwiQuO/ZiMZu8pPogPLjxjgJE7l8XEnyK+gY+U40OaAXdO9UOVPtpPfXP6tCS8szRQ0frgsho/+96ZObOG/MR9DsdkYVN+zHCFjGEC8YrC4PAb56E7aFHCA2geEMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCkl4X/a; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCkl4X/a"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bec450b950dso946003866b.2
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079931; x=1781684731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7t+E3OPQw+KHv8N8LE2/GMvZZqMpNz2+txgaF9YQSss=;
        b=jCkl4X/agg8S8HrqzM2iNkG4+pxFcg89/rJeuajaH6U7tMFr2fNejhgmWiXgcxumig
         QqxMmcKmraAbMQZ2wQC02vKL1e3G1XwsaQKfi1l5+o/kwvubO88vLEnxlfSP7LnvRPl0
         hZa1mE8VHdooy5T3K5TWJ/EV1MOy9cRtfu4dJHMyU7yCfzasLOJkrORG3kMDRJ2hwEhP
         v39A8bk/Jagchph8Ql3LeROrHL1f7AyBxY86fIvbJaLbElHUjfHEYiiQXIIPPcpSHo/e
         2z1Ec9RY5Bu61q5IV+ARN7bd770gFRxVn8F1GIB9qKHMaxHkkaq7/eTuyT4gRFVYiN0R
         3CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079931; x=1781684731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t+E3OPQw+KHv8N8LE2/GMvZZqMpNz2+txgaF9YQSss=;
        b=AW9OCYa0uH5Wl6TzdyaKxUZpGY/oBhtSwoQLvKEU1Ehm4MqGhbP9DvkKBzWIGiVDWY
         4wbt46J4nop1gznqLqq1ugfTMIyZ+dx2iviFD57yxB8Jo3nDwd2hywXCMIK/Njsp1l7Z
         7cr42MZ2Ybmau0smlFeBalBMxBFLD09g8HORaFX7wJtrJ8pOvotb/htOA/Q3Oy2cqj0p
         7a7QoOsfEi+pkHf0XlPnT2iEiWDD6k29kX63dK22xp3rTipLsPP8EljDv3UNiMgBtipe
         D/1MOqlhiQoxcgx+FOVLLtJdww2hTO2QA+zRtNRAwE4lCIZRt1QyT8xrZZJBEYdJfBbX
         gLBA==
X-Forwarded-Encrypted: i=1; AFNElJ8zaPmbsCHnO1vTZPVE50lWsZ7AWsLlJmT7hyfWJ9os1PI7BgVaV5ZQlQrjhjfOZCFQpOozyvShaJfeGcBdmHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2Vo2OHx1ds87hVThwktqKs1MkDsnlfW3c3SQHEBVdzjdnynx
	lYAlBne5jwTAIUJjaYzYmJpbX2qdHEOEW6kEzZJ4OEXP0Fk/cIOfQCwR
X-Gm-Gg: Acq92OEe+nlE5RRGETqyxf81kBx75o8A7UYX7cvdSJJZ0lRN0f1CzDCYsDxHrhl9NY2
	LtJgS+ScU7x8kFjbnYb0d20bIe/Q7O2pKuamp51sUrRSz+/0gR8LcMlEipfXlhTs/Q93mNFeYYg
	wpjOtLVqu4Bn2paoE+1iC1Q9eJ5YW/aJ3ejNDG9h2MhgbuhorexBsjtNcW7wqpMTAjjiDQhYUXm
	e0FeEWBDjZmvM+7lvxGPZ1FN1CRpmmlaVooVPv2Jc4FwbSul31z2Ly8yu41hooWRJuXQuxAR7DC
	+pxW4o3drnMafc69y2LNzqpLmZWC81ATsQvYVKhG0acMY/DSjitV7UTi4tOpLkd6K3wIKf0IrEh
	oKjJwUpjENc2sp//iDNCtyGUyR4TjLKO6NYbnCNE77ZDiCjTzmZGfmLF/vIFyUYOYz4rK/iRMrz
	ozHD6JVCgZeP4T1KBvlV4hteJnWrUZvG9kmjr4swVV/xX4DnTldbLiVwEAgKDpIjdkUQZ7FZMP7
	w+eXDJ7poPaTDB4cFiG57jH6IJHbUG5EVY75yfetk3cUyZFpA==
X-Received: by 2002:a17:907:e113:b0:bfa:f563:929c with SMTP id a640c23a62f3a-bfaf5639aacmr42627266b.17.1781079931011;
        Wed, 10 Jun 2026 01:25:31 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e0280asm1148630966b.33.2026.06.10.01.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:25:30 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 10 Jun 2026 09:25:25 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 12/12] iio: dac: ad5686: add gain control support
Message-ID: <kzfu37rchq7zjus7jpsy745zfvw3zvpz57l7yqvddolwhb4yth@c7qx3pdq7tjy>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
 <20260609-ad5686-new-features-v2-12-70b423f5c76d@analog.com>
 <aihYO_X9YEqabaFi@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aihYO_X9YEqabaFi@ashevche-desk.local>

On 09/06/26 21:15, Andy Shevchenko wrote:
> On Tue, Jun 09, 2026 at 11:13:07AM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Most of the supported devices rely on a GAIN pin to control a 2x
> > multiplier applied to the output voltage. Other devices, e.g. the
> > single-channel ones, provides a gain control through a bit field in the
> > control register. Some designs might have the GAIN pin hardwired to
> > VDD/VLOGIC or GND, which would still be fine for this patch, that allows
> > the scale property to be configurable with two available options.
> > vref_mv field is moved down in the ad5686_state struct, so that
> 
> Slightly better to use same terminology as in C and documentation, id est
> 
> "...the struct ad5686_state, ..."
> 
> > overall size increase is reduced.
> 
> ...
> 
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
> > +		case AD5686_REGMAP:
> > +			/*
> > +			 * Even if the gain pin is hardwired on the board, the
> > +			 * user is able to control the scale such that it
> > +			 * matches the actual gain setting.
> 
> Rebalance the line lengths to
> 
> 			 * Even if the gain pin is hardwired on the board,
> 			 * the user is able to control the scale such that
> 			 * it matches the actual gain setting.
> 
> makes it more consistent.

Thanks for looking into this one. I will address sashiko's concern here
as userspace might not be fully aware of hardwired signals.
Will drop this commment. 
 
> > +			 */
> > +			gpiod_set_value_cansleep(st->gain_gpio,
> > +						 st->double_scale ? 1 : 0);
> > +			return 0;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> ...
> 
> > +	unsigned short			vref_mv;
> 
> _mV

Renaming would need to be a separate refactoring patch. I'll just keep
as is and just have the field moved down.

-- 
Kind regards,

Rodrigo Alencar
