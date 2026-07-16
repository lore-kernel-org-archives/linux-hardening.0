Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119D42252E
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207115; cv=none; b=HjBYdX0Vlny5HUdU7s7B82rGSniZ7N/Lx5I/JVP2KxZOhCXCiIHeUm0vQIeyjwMCILm6nl6Kcz0JZMK00CTaP8DE6az4tsp9RNm+SjZQZR9K9zl35nree8Do36R8/iO+Mtx4Pgl6uD4YOS6EqF1fgdke1yGw6kYKWKy269DKXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207115; c=relaxed/simple;
	bh=Ph5O7sdd3xwfE3bGAXgs+upkajj44wtizah1gh+lDoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRdhiO9nI1/jZsqMdG4sLTvgjpOFGrpfMuTsxZNZbJ+BUH5pyii3/YwCBB4hrEvkEO/v3RBin1wDKQyZ8O4holMXW0AboJ60QlXR3KhXnamjJ8YgTG1/CUum2MN9GvCIKb7erkIdkd61A7NYT6Kf3ROYyLcXIIABTkKjjvDPXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCidRpY5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCidRpY5"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so21665825e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784207113; x=1784811913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HkXEhjWw8RR39Frioop/yuVyZX8tqDl1VlP5PStyz6E=;
        b=QCidRpY5AiaVnAGt/yYU+uDtue9x62zA+cXUGm40lcq9F61JrpLXcF9VtcxXSjo1vv
         qhzNqXq3KxPXAW190NuvTegi2UNDwCCtJhNxaXR+MIPGhgQ2Dm6jnQf8/XGsddWZywtu
         tK0YPLZ7FZ4rSxKp29JCbBRD9afsHb0bt87y01CS27vUiSOUx06fTcDR2IfjGJ/f4yuG
         ljfyls41AveZEoFpkyfrKWFyjxZ8F7vtFj5t9u7WhhJNHJySsiCRelAr6kQBexJhY+dg
         hPA3V4nrXC21Hem5fA8vX1aLOMdNjALlaZAI1QHKCGpxcHKQIvyfKvDj+1OMRUjWvHLL
         wQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784207113; x=1784811913;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HkXEhjWw8RR39Frioop/yuVyZX8tqDl1VlP5PStyz6E=;
        b=kSTK7Ezn12dejbcoGVWnKJorNThA5RDIVJGfGWrRPBGi7y0i8WcVfrTWrcD3rvCEgd
         8lNPKXH8K+6mtFOwVJ7Fgq/PAtOIYIZXY+1KVt8jggrwHHQWFkRanSmrkjDPlNWp6LBM
         m1K2mjqO1iMXS631Oer95/E9Vyw+drQXWj4YgK2jc/NTvgZdCGd5JPmQy4rdxUWqTTr2
         CSZAfBa4LGu60lWNWQRMwJ/5uhIKusOOlvHFaRhqjOP9lXUHNweAcdmdUwbXFaJRaL6l
         V9PGL141r1+RtC8L5DCMzLg48MmI1BDto+fhZu8kOcAkgVS3VN6MJN3isecSQImU321+
         5pug==
X-Forwarded-Encrypted: i=1; AHgh+RpAA3Rg4m2MbN6z5mVgByjD8j4shxd7++PzmVrW9cqqA/I13iGUQqkMhSilBpX15MJGtkzOU6W4d5tbzTomV5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWaT9I0iS+FYwyyxHoqxsWGuHF04p+TGcfB0ez48livxlciWuj
	wfHoYwAJFmq4na6+x9x+oHOkWWwIGPOeJCgYm8jzh2BDqObIfxn0G43L
X-Gm-Gg: AfdE7cl+PHeVapqXeKn9KWT058uFIIUw8YVZwNHZgena6i/bhASLteozuHaaKHOm7uX
	sTax5TTGhAa+sYs9HOZfBQZaFwMFLRdDCkEm2oNPm30EsqV6H7u98NXGP5B1RFZQz7FZJfAOCnR
	fG5suz/uHRuNWM7O8/nAKUOJ7hY3EOp4FP0uEx06nwB7A9VQzMdhBC0VFTOs1ReR/QLc6D8IqDO
	Fnt5Uk/hUwzAtH2POQACI4zvcgvG0/ErV8uyoMz11G5YwgDYBH+Y0h2M/NRCIPUMNawtJGxc4ex
	r7hMr+WI5fwkbkJuVIc001JzkNtJ+IzzZccKSPdI4sxdffidfi1Vj4df3eoffadO4tso4CAQc42
	niOLpXmyZ23JiFTTPLA7hU9z8G7ugopVlEzNCOb3h7lCa2hDEUg0StDBh0JFJsujvZbRwMAAP9P
	5zTluX9aTmQP/DjmsRrOL/j5jRszIZ6vrda8LXZs0Y6Tff8SBI6FEulnpo9S8TwBYMf3P/kEG+I
	0aHXyIQymOAwi7IWwe6p4YSK3xtsuES5FeNCA56ILzjJAdgpPijXvOXejlPVoMrifgQL4RYJ59w
	2CGPdbov0gq8iUgt8iQnnkXTwPSL1m2rSNLBHcpJ4PdGI3GlplceXAggt2ofQmRbmESNMsIJfQB
	HOf45aGIVxLbt
X-Received: by 2002:a05:600c:354e:b0:493:e38b:182d with SMTP id 5b1f17b1804b1-493f881800dmr243163685e9.22.1784207112542;
        Thu, 16 Jul 2026 06:05:12 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e7d22asm57635025e9.1.2026.07.16.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:05:12 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:05:09 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match
 data
Message-ID: <20260716150509.00002557@gmail.com>
In-Reply-To: <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
	<20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 13:14:18 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Verify that chip_info pointer is not NULL. If a user binds the driver
> using driver_override via sysfs with a device name not present in the
> id_table or of_match_table, match data will be NULL.
> 
> Fixes: 0eb1728461a1 ("iio: dac: ad5686: drop enum id")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260710113149.53EC51F000E9@smtp.kernel.org/
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 713fe71ad1e7..d34250647aa4 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -479,6 +479,9 @@ int ad5686_probe(struct device *dev,
>  	struct iio_dev *indio_dev;
>  	int ret, i;
>  
> +	if (!chip_info)
> +		return -ENODEV;
> +
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return  -ENOMEM;
> 

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
