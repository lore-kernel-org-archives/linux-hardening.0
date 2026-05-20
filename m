Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFDC400E0E
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302855; cv=none; b=f7pd6AlAQjNbPY0YNR6R7AlFFJjzNMw21z+9H+B3wINUD4YcClg0NhR+oOg67vr5DCK5MffQxVukFxm++wybkkbO7JphCyyjYTY93+8meq0WDa40TRVAwRDsiGfscXs5dvbzVpTeqOtPEagBqTX6nmtYiidU5su0TwCyuJfglRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302855; c=relaxed/simple;
	bh=GtWAvNoa8liocTFIE29GV3PrLzqRKVIbyQdAYPsgXsg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPb1VHBcOFLNqm63FIV8xNvi+4FpZN49s/ni0MuB6+Lx80enHAV7e64dGYRq9Pua1sabcu43EWdLfF3Inq/LqQG5iHUO01mQG+5yvbwFvPz6KF38pGfPxiilt0hrGHNEqQDUnsg2rWdOZG5XOlwk9OTPE+Ygm50+5cI5nv3N/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQAVt12I; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQAVt12I"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-459bf19e87bso3192313f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779302852; x=1779907652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hEwaR6TEFLYShpta6veHoxTDP0ik8niJki4wmQa0RY=;
        b=EQAVt12IbPCrpc2rNHDrbX2HJWDPnRSLUJ3LwZMumBGjkgVcHLhN2JE9sX26byQqM1
         fJtY9osxEJydypLMFZKL9mJiMD4ffHzmJ34EkXWh/5fEUCH/OBA8ez7e01BHYSddZz05
         rzwzhq0tbdwbyM1J3Q8Mpmsx0og6xco2+KF65emtihqCh0DSxwvTZ65KsbJEurlYeIYz
         kmA7J7vdlWQvKbGaDCTNlxlDS8bu1/HnSRkBIjvPPwK/jM+L3dOfcvz2tryfa8/pFCHf
         n1w0lZxOVFwootJB/FmqRSLNDJKg6seXTr4UN3V3c+1SbJVyqm7q42tHtdzqkOGRlzVR
         s96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779302852; x=1779907652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hEwaR6TEFLYShpta6veHoxTDP0ik8niJki4wmQa0RY=;
        b=s9ZAr0bwP0P2EwBkleW7H/hEc9TPCwxZs2WVhTMtZ0wn3kOjQyUS2FS6ixfYDviS17
         PcCjZIhe2EAWTn8O5FZNtWR89VSayIAp3GRz6o8DJnu9EFb0rPtQPY5fr95h836N+qIj
         SGUkbgAuP5OLGpHC4cZIKHc9T5tR425xa0fgCONmGwZSZGnCRFquRpb9AnQT1wPdrUBo
         1mWnaL50jlpCziSf7M8FW2H3IVZQdvdTT18r7Mz/r/8kMNXG66kzw8hvje1OLd4CsKXT
         0449jKhx97xhKkaGZyfyVyE2wLpEFXQFbbwrmLDpXWJEghqvZVh8wEPnun4fBhd1zSdW
         GhTg==
X-Forwarded-Encrypted: i=1; AFNElJ+73qDcdvtCW8C2yisysG1ohPEFmULGwJWaGfkiVEkG1NGy48wlgdsbOxFvroHIamFRlR330C4GspWwxDXoE8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3B/BN16CPGzylzAaMAWHmTyqI4MHX/QTkINfgovvAkomdiZa9
	tPstzdnjksIw/kItYJZFTR23HlExTx5QQA0d5dli8EmK9lNtLvym+7m5
X-Gm-Gg: Acq92OE0ARor/3eOz91TZa/TCwFPWpZOPUNjSymZ4lrHCyG9+GCdEuyYbdZghH8RKKf
	dYDxVuKvyywJm+G4FEAO7IHPBgB7DORH39k4HM0AhH/n+Im/ibACrhwBNp0fSGuW28C86bjJDVv
	Y9XhvH/tZ8GVvX85UAc4YuISgf3SjLdY5J3dxoVEl4E07qFDV0z+lFNmzT1tIt8QDbm+tV8dl39
	hii0v0ufiDvY2WlY8PNp9cehkuhdAMgXAIaSagLJcOn9S9nYA1ae+ETZhRPlZcfztIIxJpVSxHz
	+wfXYJTFOEf+ngILqxcH29ylezgtHSGmfjYmyveApLIdl9Z9ypSoqcGYza9MakjkPqxgR6rw4wh
	LVhKjzb97r3GWjD/XRUi1QONNWsPmdsqFD7uVvnbne9vGj8tnVYvH2UQTfQErezXnbuL6uq/oa3
	Ma61KbmV3sO+WPBwtmHHLT/2K1NMP6cjCMqFlGdbj1FtdOOBA0FCW1UsGgwDnnGFm3sLldESxUJ
	dk4me3Xe1oyTwk4RHvR0D7eIerjTblX97ZW7X+YLt8esCRN4qjUdR7jWC/k
X-Received: by 2002:a05:6000:2401:b0:43d:7275:c1eb with SMTP id ffacd0b85a97d-45e5c5dadeamr41206197f8f.39.1779302851879;
        Wed, 20 May 2026 11:47:31 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm56929827f8f.12.2026.05.20.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:47:31 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 20 May 2026 19:47:25 +0100
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
Message-ID: <vqqvn2cgs3fbp5mq6xfac7iyosaqfrvgngqur4x355a3at7slo@ylrtd6fhi33a>
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

> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that allows frequency control through buffers, this
> +		represents the base frequency value in Hz. The actual output frequency
> +		is derived from this offset combined with the processed buffer sample
> +		value.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_scale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that allows frequency control through buffers, this
> +		represents the frequency modulation gain. This value multiplies the
> +		buffer input sample value before it is added to a frequency offset.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that allows phase control through buffers, this
> +		represents the base phase value in radians. The actual output phase	is
> +		derived from this offset combined with the processed buffer sample
> +		value.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that allows amplitude control through buffers, this
> +		represents the value for a base amplitude scale. The actual output
> +		amplitude scale is derived from this offset combined with the processed
> +		buffer sample value.
> +

This will become just offset with altcurrent channels. I noticed we have a IIO_PHASE
iio_chan_type, could we have a IIO_FREQUENCY too? Parallel port needs actual raw
frequency values in that case to be written to the dma buffer.

Then we may have buffer capable channels for the parallel port:

out_altcurrent120
	offset
out_phase120
	offset
out_frequency120
	scale
	offset

Problem is that the math for the actual frequency output is:

	f_OUT = f_FTW + (f_RAW * FM)

where f_FTW is a base frequency (already scaled), FM is a
modulation gain and f_RAW is the contribution from the parallel
port, which is the already scaled:

	f_RAW = RAW * f_SYSCLK / 2^32
	f_FTW = FTW * f_SYSCLK / 2^32

so the above becomes:

	f_OUT = (FTW * f_SYSCLK / 2^32) + (RAW * f_SYSCLK / 2^32) * FM
	f_OUT = (FTW/FM + RAW) * f_SYSCLK * FM / 2^32

if I make:

	SCALE = f_SYSCLK * FM / 2^32
	OFFSET = FTW/FM
	f_OUT = (OFFSET + RAW) * SCALE

That would work for a IIO_FREQUENCY channel type, problem is that both
scale and offset would depend on the modulation gain (FM)... I suppose
scale should be setting that and offset assumes it is constant to act
only on FTW.

I suppose we can keep altcurrent for other modes as phase and frequency
can be attributes (knobs) for them. However, in parallel mode we are effectively
pushing frequency, phase or amplitude values into the buffer.

The polar destination is a corner case, but can be solved when both
phase and altcurrent channels are enabled. When that happens we can
change the scan_type with has_ext_scan_type = 1, so the 16-bit data
bus is split between the two.

With the above, all of those *_offset and *_scale custom ABI can be dropped. 

-- 
Kind regards,

Rodrigo Alencar
