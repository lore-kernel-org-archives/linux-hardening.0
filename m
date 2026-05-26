Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F3397B12
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790039; cv=none; b=Z6Fp6dwCkkYu+SFcgc0wy2qyBZ8I/QxDZhwRNfFiyjir0ae5f+K+O94Z8ie6+YlSSjDEzeyek5ZBkWKkxjUentDcQX6V11WMeL3JpVXZcR0iRFmklyjthokOgToV+8JyUtGZWEjox2enfPh+R7i2AnzCBLX2I5ECIhKh3KEctiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790039; c=relaxed/simple;
	bh=Ublks9CuT5syiY4dPX5P5VSog6DvqLq29kO6wrUNPns=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHOLJ4VRq9WJlHo9ASNGBPMqxbN2sBzC+Hzrb6V3wawCyuoP/5hT33wmLLvUtZtVd2MELb5LOmEhLb2NXQkM6fp9YFcTDHidRM6qZepvuqVT4UnwQqcYp0c+EGuN65Ah9VyH0E0Z532gdMpSarcBsDEkeNP/OrmwUU+76vHZvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFSN00XS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFSN00XS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48fde648a71so67894555e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790036; x=1780394836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBWVkdlUBppiUm4CnKZtDjFMlGPeTrCwu/oPgCeq608=;
        b=oFSN00XS8JSvgHKTtHxo9tD84tNW1qVETBMBCrdtp2ANYbKYzy55a6Bkm+wvs43f8I
         cPnEkwoT3LMw1fHJlL5qqBJUfAbQEauY3Zccz7pAuekrLJt+P6iXBiBmMznl2fIwKw1p
         TZdzFLUGihTaLYkMLrofz+mYEA0DipPVylgFh+PZ3pPat5EpBZ8F5WmGmqXCLblJZaNx
         XsTPMvCirVmpN7JVz8hNsNTO+GFdwit/u0ZB0KBQRBrJRGQSLmA6YTGCetcfzJ3T18Ii
         8G3YM/yxCpu65q8IJD4M3yWJzemSUilaKHPvIfSfEManmI4LE1QYOAIEPGKXNZwwKGLQ
         Z4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790036; x=1780394836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBWVkdlUBppiUm4CnKZtDjFMlGPeTrCwu/oPgCeq608=;
        b=gPx31kKv/NGIfkn2bmNYTBcwpRJ6/YYePMeFDkrxaasV0u3v8dzH8THai8neWwutf3
         oImbX4uoporJNO8Y14sH74qHblHcSjBKM3fKuzs1PB0mOOn75A2+HJZgolpFsDDVxhrE
         G0VQnUkd8C+bDysFyXnCXgjHG/KsScrYdf/G5D8ZAYW8KAYXVov+Xb07R4uGOjstc8bY
         OmNzTUbMRjFJ6rdj7JnTXtnFJJJc5jED6xeO0z8MxQ/so20QV7P2KWt/pQke5Axx4DjI
         Ja9zxggbHI4ngm6jVfkgYBmxZNqj53AwWUKGha+nbuCCJhAxa0+G5StnbcWxdGFQcsPo
         Bupg==
X-Forwarded-Encrypted: i=1; AFNElJ+HYcezXXCqKTWvYQ3Ww6D5JMqU582vR2+aEf55TvzoFTeI2dS5SNCIu5XXjrYYP2XmM9o6MpwnC46Zv3hQatE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIi2DOymT8ip3X3l9M7OfDtOdghiOpAwkOyPaa21EOHyRyFUmP
	px4FdhTdFFOguEWTUwsf79ysU4bnVl0MIIOog1ULGDg7z5tgaM9s2IZS
X-Gm-Gg: Acq92OFMBkvWmliOhl6OtnUzR4qJOodQlrx7JDMoVeHe1AmTfDl+GQhv9pfWhDcgR5O
	9IOdQjqE2MvT9iRbP4LJSa+zjTrCja3c/0J5aN1X5m6StvQOXJ+BW5ltbfeX11KDz3eWls+wQHt
	8/vmTJQ6ii0VY+yNrwZazMI3IRJ0cO+GCvm2OX/Rw+wZTsDx7T9qEjZ5w0+yw7GQ/L2mwId3JVl
	561LGIZZZNqfBXd8wfw5+t8N1zsTSUeAOWEOaKyRFKAy5EO94ltepYHK14nD6Z9XTFbY4k1dUxr
	d47rfJUDVUC7VlFDEzz9bOE1RVLVIgFu6jN6LwI/OwgPzG3uqQkhw5dVwWSrEqd3qU9+wjOamUp
	a7d9lJszhKaud+0u+9MwavHFjA37zGNnOHGjS4xsB5qaCtS9u7yk/eRj0y6qXl/3PwvX87Hsjdt
	nxjnhItR9FOTpFLeMZP+nMHDjwzcKfNM/WNCQiEzKseFfW47x878B3DfM6CF7EVsFjP2eOWLiiH
	tsfNkHTzJpWkViShUyuw7GUof0wi+E9FHZHrIzx3tyx86nc/w==
X-Received: by 2002:a05:600d:4448:20b0:48f:d620:c27f with SMTP id 5b1f17b1804b1-490422687c3mr181089135e9.4.1779790035539;
        Tue, 26 May 2026 03:07:15 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c5eb0sm337780505e9.2.2026.05.26.03.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:07:14 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 26 May 2026 11:07:09 +0100
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
Subject: Re: [PATCH v5 12/13] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <wyxgririrncvg67bisazndqtlj6ylrzkqfgsi7tptjfv7qopwa@rjmtb2aohbay>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-12-31599c88314a@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517-ad9910-iio-driver-v5-12-31599c88314a@analog.com>

On 26/05/17 07:37PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> control Parallel Port, Digital Ramp Generator and OSK parameters.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_dwell_en
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that produces parametric sweeps, this attribute controls
> +		the sweep behavior at the configured limits. It enables dwell mode at a
> +		sweep limit when set to 1. Otherwise, the sweep may stop at the initial
> +		position or restart from that initial position or continue by reversing
> +		its direction.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_roc
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Frequency rate of change in Hz/s for channels that produce linear
> +		frequency sweeps. This value may be influenced by the channel's
> +		sampling_frequency setting.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase_roc
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Phase rate of change in rad/s for channels that produce linear
> +		phase sweeps. This value may be influenced by the channel's
> +		sampling_frequency setting.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_roc
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Amplitude scale rate of change in 1/s for channels that ramp
> +		amplitude. This value may be influenced by the channel's
> +		sampling_frequency setting.

I am thinking about adopting IIO_FREQUENCY and IIO_PHASE to the DRG control
(It is considered for the Parallel port at this point).
That would make the destination configuration a bit more clearer:

* out_frequencyY_en
* out_phaseY_en
* out_altcurrentY_en

which would enable DRG for a given destination.

I would not want to have 6 channels (3 for ramp up and 3 for ramp down),
so I would develop the idea here with that in mind. Otherwise, it may
be ok to have the 6 channels for that.

The DRG have this output pin called DROVER, which indicates when the ramp reaches
a limit (upper or lower), then I was thinking on bring that to be an iio event.
At least initially, to treat the configuration as threshold event control, and not
necessarily having to processs the DROVER interrupt. Mostly because that interrupt
might be to frequent and would be better handled in hardware (by an FPGA IP).
In fact, for certain configurations (slower ramps), CPU would be able to handle
it just fine, specially if user is not very much concerned about deterministic
timing when handling the event.

DROVER indicates both threshold rising and falling events, so I would have something
like:

* events/out_frequencyY_thresh_rising_value
* events/out_frequencyY_thresh_falling_value
* events/out_phaseY_thresh_rising_value
* events/out_phaseY_thresh_falling_value
* events/out_altcurrentY_thresh_rising_value
* events/out_altcurrentY_thresh_falling_value

to configure the DRG limits (upper and lower), which fits well with the idea that
DROVER is the event we are interested in.

Now, we are missing two things: step rate (sampling_frequency) and step (configured with roc).
The problem here is that both of those configuration are applicable to rising (ramp up) and
falling (ramp down) cases.

There is no RoC threshold event, so I am not sure it would make sense to create an
event spec to configure the step with:

* events/out_frequencyY_roc_rising_value
* events/out_frequencyY_roc_falling_value
* events/out_phaseY_roc_rising_value
* events/out_phaseY_roc_falling_value
* events/out_altcurrentY_roc_rising_value
* events/out_altcurrentY_roc_falling_value

But that would allow to reuse that existing iio core/event code to configure the
ramp up/down step with new ABI.
Otherwise, trying to get both ramp up/down configs into a single channel we would
need:

* directly to the device channel attr group:
	* out_frequencyY_rising_roc and out_frequencyY_falling_roc
	* out_phaseY_rising_roc and out_phaseY_falling_roc
	* out_altcurrentY_rising_roc and out_altcurrentY_falling_roc
* or, under the event group with a new event info: IIO_EV_INFO_ROC 
	* events/out_frequencyY_thresh_rising_roc
	* events/out_frequencyY_thresh_falling_roc
	* events/out_phaseY_thresh_rising_roc
	* events/out_phaseY_thresh_falling_roc
	* events/out_altcurrentY_thresh_rising_roc
	* events/out_altcurrentY_thresh_falling_roc 

For the sampling_frequency configuration, which would also require new
ABI to fit both ramp up/down in a single channel:

* directly to the device channel attr group:
        * out_frequencyY_rising_sampling_frequency and out_frequencyY_falling_sampling_frequency
        * out_phaseY_rising_sampling_frequency and out_phaseY_falling_sampling_frequency
        * out_altcurrentY_rising_sampling_frequency and out_altcurrentY_falling_sampling_frequency
* or, under the event group with a new event info: IIO_EV_INFO_SAMP_FREQ   
        * events/out_frequencyY_thresh_rising_sampling_frequency
        * events/out_frequencyY_thresh_falling_sampling_frequency
        * events/out_phaseY_thresh_rising_sampling_frequency
        * events/out_phaseY_thresh_falling_sampling_frequency
        * events/out_altcurrentY_thresh_rising_sampling_frequency
        * events/out_altcurrentY_thresh_falling_sampling_frequency

Lastly, we also have the dwell enable config:

* directly to the device channel attr group:
        * out_frequencyY_rising_dwell_en and out_frequencyY_falling_dwell_en
        * out_phaseY_rising_dwell_en and out_phaseY_falling_dwell_en
        * out_altcurrentY_rising_dwell_en and out_altcurrentY_falling_dwell_en
* or, under the event group with a new event info: IIO_EV_INFO_DWELL_EN
        * events/out_frequencyY_thresh_rising_dwell_en
        * events/out_frequencyY_thresh_falling_dwell_en
        * events/out_phaseY_thresh_rising_dwell_en
        * events/out_phaseY_thresh_falling_dwell_en
        * events/out_altcurrentY_thresh_rising_dwell_en
        * events/out_altcurrentY_thresh_falling_dwell_en

For custom event attributes, maybe iio_info.event_attrs can be used instead
of new event info (or a mix of both).
Another thing we may consider if going for the 6 channel case, would be having
new modifiers: IIO_MOD_FALLING and IIO_MOD_RISING, which might simplify things
a bit.

Let me know about your thoughts on this.

-- 
Kind regards,

Rodrigo Alencar
