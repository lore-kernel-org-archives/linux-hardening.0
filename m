Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558941B346
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475251; cv=none; b=mOq0L0fc7Fo6/IsebU4ymB3kXb61u/WXPwU4eKCyh2YgwsAXiYUs3w1QHQs5zFObZ6gteN76f27LZdz35UXYK8nidKh846IotPqKBneq4CW5Okd51zLckAsXEgkyQsmdwZKePTlJKXEOntn3VG+OcqXUOm/DSLfUexGcG/1rpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475251; c=relaxed/simple;
	bh=LumPu9r+mU+AnVH6fxprfAR9qbofx4edE4J4MDl1xdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdhUgihoQeVgIdmWDKxTzZCRjS56Iz+BV6HBiq0Oy2ZQyeDQ3e51z5wI59AFFoofEn7RZZTcUv9h90y+r/jwwdCrL3jqWwHAqnwBjB8ZQCpP0Y7+A+wJNpU8pEA4YThCkiX7dBMl1uoBgDRTtxRYOv3GXoZB5RejJAFtd/X0BAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZq4RFbW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZq4RFbW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so93302325e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 03 Jun 2026 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780475249; x=1781080049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgsYYdbc7FC5Ra24DrI1H09WIybYU7rqzf3pPkcoQ7k=;
        b=PZq4RFbWUQV0XeD+9B8dsXzJJ7eSaOUTEi4U5+HrnW7DrF7/TTNO4MnnSgvmmxdkI7
         eqxPuDi8VR+M2QguQmh1+MYDiiWf/ttsurwgCEBP9kN6El0bc1K2dfdvfniv8IAIgoat
         DJLLPC9l2RtTbhYImHQLbq9nQImSobpNQDRPQEiBgCixxxgwgM5AZphXjq0qF/wM3MS3
         RiZsdZOx6aLkUon9q32yetH4Dok3QNOdiXkSi48Rh9He18p8S7fcmDdiZhu6ABKW+7NW
         /gkD4lb9aKH5LdPe2ca0gmen+wJB0Yj5Y8oKys2A4pXKZoX+VOOir5BPS5vF8QQlsdUE
         BD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780475249; x=1781080049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgsYYdbc7FC5Ra24DrI1H09WIybYU7rqzf3pPkcoQ7k=;
        b=Yk1OizxHgrvuniU+tyoylX63TDe7mQ8npyXxDlY5I78dhUbnnjwC8+swKMEP9p7jMw
         01os0eL8dUL8rPI8T0Em/obF4cYD8ModMPdkgXIqyVMyrL9upyPv20CsK25au0i1wziW
         1eZ7o2XVMbSqbOInNcUBXh2GK6cVwUWTMfn/pzkTYRZCT44b1RekU5MTOGVsHFsDrWeE
         AaE27x7I7GsZvuWCc3KmmBvAugLngOxZsGn0no9Z6mV/bOln9zPhmTOgZPedgAKGMv1H
         5uXBYVOWuJvgnfxpDt9IthxXFLkzG5NlpUiygXjQlKzuZDzmFn06YO+yKCL0no5ruydg
         XWsw==
X-Forwarded-Encrypted: i=1; AFNElJ9JqKpnC+PnoRcslLWHNlHqXHZ23f6wVxMSuoOTs66OT0ByLi9hr+Ze31+EnV3I6m7Aa8dPjkScxC5CAlQoZkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5xBWUUx0lQxIr0szrzKJT8FmaGPZxtwxbKzJH9bnkZvnEO81
	T1DQWcSYBjNJ0HLWUpbqpCzT+JjRV8PW2quxNOMger9w+VnDJTt+JpBd
X-Gm-Gg: Acq92OHxKfS2IHpngkTYuWY3tjGaLMPvTH4hj6cThEiakeJsnKHW3GS3bY6eso/eW8v
	ghzxre91PFQHPpC8U9MdJKAxr2lNDtaxKee6Nlc3eUh0y+sKCaT4yosymatlZXoT+/71ut1/7D9
	bRY04tlEXj5tlp+f4J5erYMvLtDypoK80DJ3emuZgVRemSI3iXV8HgCGeIzKI0iQcPq7ah1spsF
	7EXjFd5KWdJahNQDWhsN93Kl49YWJj4fKeHzeUh7cURQrFcdTPcCl1cb8S6bj8GB74sdlLH6xRP
	iqACxWaQt20QOD3/UvkKzf3rFniLdIFif768Z2jNfbzX7q2XOo0rps+LI+7m9TKla5UytKHlGgy
	ldZrC2P+TeA1PpglOMMoFgZv9VMFXkNVzOgsqAJ/ONmiicWuzHRh9VOnCBLdnckY7fo+U6+NEqh
	pY11cfjyq5LXXYVYqLfzaDs5PQ6Q==
X-Received: by 2002:a05:600c:6748:b0:490:9df1:f0d5 with SMTP id 5b1f17b1804b1-490b5fe64d9mr38872955e9.28.1780475248655;
        Wed, 03 Jun 2026 01:27:28 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm5814991f8f.9.2026.06.03.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 01:27:28 -0700 (PDT)
Date: Wed, 3 Jun 2026 09:28:26 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 06/12] iio: dac: ad5686: consume optional reset signal
Message-ID: <ah_k9A9535Vz6PCw@nsa>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-6-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602-ad5686-new-features-v1-6-691e01883d27@analog.com>

On Tue, Jun 02, 2026 at 05:33:53PM +0100, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add RESET pin GPIO support through an optional reset control, which is
> local to the probe function. Also, include delays for power-up time and
> reset pulse width.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 4a8c587ff116..345ca2436332 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -8,12 +8,14 @@
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/delay.h>
>  #include <linux/dev_printk.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/sysfs.h>
>  #include <linux/wordpart.h>
>  
> @@ -471,6 +473,7 @@ int ad5686_probe(struct device *dev,
>  		 const struct ad5686_chip_info *chip_info,
>  		 const char *name, const struct ad5686_bus_ops *ops)
>  {
> +	struct reset_control *rstc;
>  	struct ad5686_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret, i;
> @@ -506,6 +509,16 @@ int ad5686_probe(struct device *dev,
>  		return dev_err_probe(dev, -EINVAL,
>  				     "invalid or not provided vref voltage\n");
>  
> +	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(dev, PTR_ERR(rstc),
> +				     "Failed to get reset control\n");

On top of what Andy stated, I'm fairly sure
devm_reset_control_get_optional_exclusive() returns with the GPIO
asserted.

> +
> +	udelay(5); /* power-up time */
> +	reset_control_assert(rstc);
> +	udelay(1); /* reset pulse: comfortably bigger than the spec */
> +	reset_control_deassert(rstc);
> +
>  	/* Initialize masks to all ones */
>  	st->pwr_down_mask = ~0;
>  	st->pwr_down_mode = ~0;
> 
> -- 
> 2.43.0
> 
> 
