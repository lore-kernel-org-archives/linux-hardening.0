Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9181322768
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003828; cv=none; b=SU+RTNinJWfCiINDl1Xs+UJk6Q4cqhpcS5tumcDNxlQ+CJ+7Ht/yuf7DaNYNPjmaHYGinI1JvESALp14vwH2OrnKvDNwGZLf+xhmee87AE7UAH5QMmA4J7WYkF9rF2fMTtrPuVLU0yDK+p2iYLF9vrPBb+nEEhJ6kNOQ+uPIdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003828; c=relaxed/simple;
	bh=LKxo0fMd2e5AxYLGvb9IhES/FecwFKryZEiDRHJ+mlw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRuYV6+6vtmfawx76XPkc6ITqerCKiD+Mm+gKW0nHlEhTkLCszoE3DSZNCXKmRk5j0ECzyoAd+gLXKMOjCckiVB8b7o5iJS3eRo3v21T11Y//FWf0CaUvKR7RiAsv732TebaZM1RyC2rId1FjZnSFFiwLDvzf6D3FI+lvVdQjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZubZSRdo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZubZSRdo"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68f36e1663cso9582122a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781003825; x=1781608625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0R1/uOav6x+N5u8la1mzmW5tGVKOxiRp9V60pMgD0IQ=;
        b=ZubZSRdofBGJQftKMUc5iy2QOJ2xfy7ayJgwhOzg3sJji291iZd4dFwgRIADlxzQT8
         /xeEQ4OAYuH7rkpf02eXFbCvdRzHuxMoTK4czdIr0shQfADihfMDpSYxQrV1xK6HatI9
         QsYh9fDuffomalsZMEY22EZAvMpJoztvnb1kx0DaIK7ePvHCWw41T6/R+ZrFwIcPLYMq
         wDCFeZli5C0ZbXIVyStenJFJzu6rm2+yYxtoAXkI84NmfoWtedZaGPBZHRJEFMSjU1kB
         TZOlMUK+9aCPd/BdWmD3XJ97+g8jNkr1jIPDU1AYYN8+WYNG6do3FH31ypWwrxHXfp8L
         bmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003825; x=1781608625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0R1/uOav6x+N5u8la1mzmW5tGVKOxiRp9V60pMgD0IQ=;
        b=D4XuhD5sK0HJy50O4Jx4svP7Gx88nCqdcNDBFt4aq+nAa1D6BsLnNInUIbO9A5h/Dw
         pXxIiSaLkGjv9FUW59MC0t1+SukWb8t2RW/sY4r+Bq0IgtEHkJtDHRbIZ0c404DO2XhH
         tzHNrqNKKsbN2tASx5tQG7lmzfAuhBkHqoy/HuFbTVIv6lhu7gsmn8SmbkBYagaLsMP7
         zVUSHn8uhYDPIRI0x5CclXLDmPNQY0du2opdALDi8NZ//5SI/tDkRel2PUTKGJ14LqfM
         V79a4bFVbQjXe/p95dGTm0y/Eh9LNsznfBg3w9obqr/kJtoyGi+Q8TLG2J7MIgx1w9B9
         gXug==
X-Forwarded-Encrypted: i=1; AFNElJ+f8CaSYZu26VMLOtGLahotymwIV+dmAMP+597akvIrJQKe0PhxigccmcMHW33q2NG2RqGLvFZGps8vR8spEn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxidPiPUSR1N1M2ggbQZ7/dCX20MlWJ629iuXVqinG0LFFYvQ9L
	K/kkgQKwjuo3vGRZMJVN5mc54qURBPv9Z+X3YB3XnumkQwIz1IzrZk1x
X-Gm-Gg: Acq92OFeTwUlxan5RaI2TeNIF9eq2+Mvy0evvikW+F5logZkqj6r1hsuUJ/Sb0mUk/h
	79CbbaaN3pi2TiiicIo8MT9DNvIJlNGTtOzGaj7grAPnBMnxQ7pjjepOz6prUWhHIeLzv/e0VI4
	Uy+49tI8Eu82k0aJDIyS2a6F676I6eBazODXLNCj4hJhkt/BfDumLK42jIUJ1Ty8wGBZv3sJ7bv
	n+ySR5ZFhNFYDWoEmToEVETeqJ18dxrao+5LeFUK515Md74sPLxtRSE+w7K8HrzUZBA6PJgHmoV
	AOT2aJDxhBwao3BHGyfGfdR4mS1SZEEDpDf6x0rcwdUkIBVSrdT8fJihJ2Z54PfNIeo8oEuXeVy
	aWp6aMhv+cIrQ9AAaDQuER6AQGarn+RGRRGabTktOM4mxk84MtjoA237M30OP19/aK554olJob0
	EMo4wJapC/U4EPfMqU3d4VNdfEzHztCn0AJamBpNApk4GrKgZJXHeb5DwnBwjb3sZau2nNMGp+8
	d87Ej6Us9fRbS7FXGLiQ0kxxGF0YZn3xYpvrLiz2t7YEhcBSSMW5Wcowf5b
X-Received: by 2002:a05:6402:3905:b0:68a:c316:34fc with SMTP id 4fb4d7f45d1cf-68fa4e27b23mr8291432a12.9.1781003824324;
        Tue, 09 Jun 2026 04:17:04 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64c2f34asm8762792a12.4.2026.06.09.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:17:03 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 9 Jun 2026 12:17:01 +0100
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, 
	linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 06/12] iio: dac: ad5686: consume optional reset signal
Message-ID: <ltafhuqwbdnj7qadn2p5f7exwcpz4fvr5jaizj7q4peqgt2x4b@z23ss3usjskv>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
 <20260609-ad5686-new-features-v2-6-70b423f5c76d@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609-ad5686-new-features-v2-6-70b423f5c76d@analog.com>

On 09/06/26 10:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Premature reset line deassertion during power ramp-up due to the use of '_deasserted' combined with a manual pulse.
> --
> 
> commit 61717352bc99739a9f89195c3320a934e033ad38
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> iio: dac: ad5686: consume optional reset signal
> 
> Add RESET pin GPIO support through an optional reset control, which is local
> to the probe function, and include a delay for the required reset pulse width.
> 
> > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > index fc3863274b291..700798b80f044 100644
> > --- a/drivers/iio/dac/ad5686.c
> > +++ b/drivers/iio/dac/ad5686.c
> [ ... ]
> > @@ -506,7 +508,15 @@ int ad5686_probe(struct device *dev,
> >  		return dev_err_probe(dev, -EINVAL,
> >  				     "invalid or not provided vref voltage\n");
> >  
> > +	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
> 
> [Severity: Medium]
> Does this prematurely deassert the reset line during power ramp-up?
> 
> Because devm_reset_control_get_optional_exclusive_deasserted() automatically
> and immediately deasserts the reset line upon acquisition, the reset line is
> driven high while the power supply is still stabilizing, before the 5 us
> power-up delay has elapsed.
> 
> This creates an unwanted rising edge on the reset pin during power ramp-up,
> which could cause the device to enter an unknown state or latch up.
> 
> Should this use devm_reset_control_get_optional_exclusive() instead, which
> does not modify the line state during acquisition, allowing the manual toggle
> sequence below to safely reset the device after power is stable?

It has been discussed that it is better to get deasserted and manually create
the reset pulse. Will move this down (after the fsleep(5) power-up time). Or
better move this up (before the regulator enable)...

> > +	if (IS_ERR(rstc))
> > +		return dev_err_probe(dev, PTR_ERR(rstc),
> > +				     "Failed to get reset control\n");
> > +
> >  	fsleep(5); /* power-up time */
> > +	reset_control_assert(rstc);
> > +	fsleep(1); /* reset pulse: comfortably bigger than the spec */
> > +	reset_control_deassert(rstc);
> >  
> >  	/* Initialize masks to all ones */
> >  	st->pwr_down_mask = ~0;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com?part=6

-- 
Kind regards,

Rodrigo Alencar
