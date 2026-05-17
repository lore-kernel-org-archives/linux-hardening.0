Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764033121F
	for <linux-hardening@vger.kernel.org>; Sun, 17 May 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039039; cv=none; b=XST+iAkIgvxBcyxQ6pYVlZYkUzhMBmISJjSNBWdaQ+2TNrsRf1b18efpuXmGkWQEMyGwIRNLIpIX8cNIYB0F8yqJDayDoPreUVdEbIwgEZVnUBLC6cuLzuXi1NCdA4tGbOEjbISjYMc+acOmTcBqeZ0oWUVtvUR/nsPeTOIRIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039039; c=relaxed/simple;
	bh=ZN+M4Cchoa1lUZGVHkJaXVLB6ZtVvpayoDZ73oWRJAo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu60m3lHQrxDHGK9uGn2cqmMEyvesFRG/XN5msu8cK9s/xKo5LajQl+Kk0cgmrUWz1srdbDulY26HFpFmNaVHMN/mBHCV5SOoC7QHkGzLkAJmgrR++30fxTCflWz3vyof0JgHmvmcUlwUzuS1f/I4dACjuBHZiZrBUJbfn/NPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILn6PBvA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILn6PBvA"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso8605305e9.1
        for <linux-hardening@vger.kernel.org>; Sun, 17 May 2026 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779039034; x=1779643834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biN63ninIqhGSrYMwDyAgi4Qnh2QQxC8g5gMwT2w1jQ=;
        b=ILn6PBvAE4vEIn/gQKL3g1QZDQM5AH+iyz7FsTSK4GO7ra5i1V6PhR423ZdBEhEgKf
         ow+u1wM/oWnxJQZODL4IllpQ/PdI4bIBjCyTpAHOteIZcE2+4ndeC1K6dKIwpcswJMYn
         5Cib4cyH0Eel063IOE3EvRQ9Om1v5TTxs5LzGLQ0w2SzFegUKaiX7HI1BdGF0n1moeLh
         xNWpiqD5pXS920Li9HSx25DDxqovXuZP+LvueVnSmJlg2g5lSuo0sIbFYNZW81k6sYB6
         IILR+Bf/x8n67wqCxWmpRJtOnwAtvqiWgvJ0kDHxiqaQYy5feBVsjPhZdf7tqLFWK/by
         whVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039034; x=1779643834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biN63ninIqhGSrYMwDyAgi4Qnh2QQxC8g5gMwT2w1jQ=;
        b=Az6Aeip3Q3z2BwEUrAsOFo/q4o/zLdLRL4/Cwe/y3GdKNHNMoB6J/NcsdXXKxoYTEb
         3cEnum2y6FigUE02Hs60lcFIGkMIIAyMG4hXB68sMQZe97820HIhF966e3xre7Jq68W/
         LfHAIg3T84rPmW/a3l9vYQWV70UIMfhURfWHlyKurzMy/PQdheyEmpVglfB4Qtj9XbA1
         bSu70hoq/Umjlrk+RsSX7+XT4+jFMasE+pf2trZN+rpLgGhgOsfshVlJjN4WT18rsynL
         vEWa6Hsy3xNQB3Ie6+0pRPVXa78Qm6cjbIzHMyZ9x6MmTQ6goaWyeRb0NBNzLvCbpcNw
         f6GQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S2rF0zQEdC6t6E8DkaCLg75kTFBQ4v6jyGzDrMtJjjnpAf1h+Fi1AcPu/InCHg6LfaS6nX+KPZyfa7jWXs8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0W0rvwJeljM7yKJcaWVEZdc8o2+PjjQ7CjtJest/OFGkobbVF
	lQzcogkZBTdpDVlsvHOetGHRvfeV+LjebTYWc7vW3hu7/kxGKvUjfydj
X-Gm-Gg: Acq92OHQ2UGazfjNGIEMG3GM9uDGyjF7qn+h5qCydM36euYM1kMeAKBjr0E8NmFru9B
	sAmeVT61oTTYZbAzggWjItrY96WXyUw69VGZFiPqd0EetzJ/KWzKlwhWLSvycZEYU11azWOnKdx
	45gbV1tVNGlq/RcQs6a/Il9xwcIlSmWTGR8ak3ow83iBGNB7NuEIZbCqUAVQB2gNuxNMpt1oV4G
	Q7JOIAHsin8NvophGYFk/0Wwjxrqk4lAVilxqpyqKrCUH0b6IYId1IVe5t58Rf1wMatH/lfT9DH
	I0sWjpwPLzBYErdY6NhaiWxsPe742pEgcjbVQVcM2Dbx0y+0RGjjt0k1vpLedFL2ghNWxx/01ML
	gYlEc9N1ohMagijCuHdHgIaI9ljgMAh0OnFxVR96HDSUS3DhWFw7GRtu3CGMp3/Kqmp2xD+Ii16
	DoF67s7FWbiSZYRyhYWylM2/5x4xUI/ZOGF0kMk3Vxym/LNWFY+t51ZMALmAyB1Li3ZdHKoE+ay
	I8eiqczsZFodn8v5LvOt7/edXNF5FPmkKmw/otj+92Iewjdk6Xe8YmE/Q3kuqKX5HgXpC8=
X-Received: by 2002:a05:600d:8448:b0:48f:fb0d:8d86 with SMTP id 5b1f17b1804b1-48ffb0d8ea0mr83999885e9.32.1779039033987;
        Sun, 17 May 2026 10:30:33 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ffed68baesm35541065e9.0.2026.05.17.10.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:30:33 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 17 May 2026 18:30:27 +0100
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
Subject: Re: [PATCH RFC v4 09/10] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <yrabhhhdkzmiuxlqzrrj6a47ftlzwvva7r2korzeszdy4yqrin@xl6obhhnnas4>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-9-d26bfd20ee3d@analog.com>
 <20260517155843.7f833658@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517155843.7f833658@jic23-huawei>

On 26/05/17 03:58PM, Jonathan Cameron wrote:
> On Fri, 08 May 2026 18:00:25 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> > control Parallel Port, Digital Ramp Generator and OSK parameters.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> I'm fine with phase and frequency as defined, but for the scaling it made me wonder.
> For outvoltage0 channels the assumption the value is the peak voltage so if
> we know what input to be modulated by the ramp generator can we express them
> in volts (well milivolts) rather than as a scaling multiplier?

The DAC output is current-based and differential. Voltage conversion would happen
outside the device... using a resistor load or an op-amp transimpedance stage,
and I am no expert on that, but that often requires impedance matching so voltage
levels may depend on the frequency. Then, I suppose that voltage is not the right
unit to use.

The scale here controls the amplitude of the varying signal. Assuming the peak voltage
(amplitude) is constant means we have a constant envelope, but that should not mean
we can't control it or it should not mean that the hardware can have other ways to
control it. That said, scale behaves as a "gain multiplier".

> 
> That seems to me like it fits better with the overall ABI.
> 
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		For a channel that allows amplitude control through buffers, this
> > +		represents the value for a base amplitude scale. The actual output
> > +		amplitude scale is a result with the sum of this value.
> > +
> 
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_roc
> 
> Silly question perhaps but can work out how this related to millivolts/sec
> That might make a more intuitive interface than scaling multiplier per sec
> Perhaps the combination with offset makes this impossible though maybe that
> could be a expressed as a voltage offset?  Afterall if the amplitude being
> scaled is 5V then 5 * (offset + scale) = 5 * offset + 5 * scale
>  
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Amplitude scale rate of change in 1/s for channels that ramp
> > +		amplitude. This value may be influenced by the channel's
> > +		sampling_frequency setting.
> 
> 

-- 
Kind regards,

Rodrigo Alencar
