Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAE35C185
	for <linux-hardening@vger.kernel.org>; Fri, 28 Aug 2026 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787890653; cv=none; b=eSbvpNDvYb1k213pz/AJ1MuoS+sD6W3ldZ6U9mtYuoL8oXtzZ7dtlLN9Hw5QBEZrrU+NvPY3oms6SgWtG8LXNus4rc9W9TdtQoKNh0Y+wB8oW6gqsn/NCPXHuCfJ+8gvWefIRGfSBvESVkFOaHn6gNc4LyAUT2au2moDTPn2tAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787890653; c=relaxed/simple;
	bh=pTqidcm3PAu7POfuygrHb1YbhgmYvPuj7LrPfVSm1kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trbrTTpttsrZuXr9XRN1/4LgfhOyVejmgDSQhTbaOogpztKyYlH2KTQ8SzSWgqSZueHT67e92I1hV/Y1AK4HuynYt75yPHlGYl9vMge/yrGG/p3pf9MEPYAPu3j0XgrlKEpGas6/ozWLOo/1Zi2imySRCawpUsCJZ6GT6W6lFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa4MbNqS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa4MbNqS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6f624c323so4603535ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 21:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787890651; x=1788495451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gO0v4/V9YgV4PqtgQrf2yHSlli7ph+LMnJojXZKVqJY=;
        b=Xa4MbNqSKvXsKGW4bSdxAvYMg9nGINKU8AszGNhh4DjiKGYa4B6pzt1jb1agr1QebN
         feSOZsIzZFkt8dftkzdyLZgRnCRKc9YEJcHAaSPQ29BCiW4aMWBwT5Q0/Tm1lsp4HYNH
         d8dFA/9+tKqKGKvdDYkPw+mcLBqGoVh6TV9op0Lo5CVzXp3ApdHKw/YatDtFWiXVtWJ5
         1GZ4pBzPwn77WdE/+qmfApJbIDwHCDjGPlmJvYY2tPQOI33bv7bMlaxgGj2gzrdA1M+5
         XW8gamS5pbjXcVrp8zK3K4SfLy7YtF0aLFd5sEFVnlk6PTDIYMUpwMijx1E+Nm3b5hdN
         8tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787890651; x=1788495451;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gO0v4/V9YgV4PqtgQrf2yHSlli7ph+LMnJojXZKVqJY=;
        b=OFDnnxEy8W8l/G6XAktYgZq1D3L3TyntftpuFVj8/tRX1/26ai4tmBwe5qthwzCw2G
         c/0hbZGvQCz0RtwbMskY71X6gTlAofRma4GSpEXyLix+J9Hpab5XF50thgO6ORTd5Odv
         imxf9G2yEtRWuRStobOh6lhcj8uMQRIQnt7tPJsmMYJ1umCzuYE5qwRz1gJLgF2RHgyt
         Vxf7Anx6O2U+Or0m/yXVDmURjU+bVZDj4nFzT+9996Hrkv6TFDvWWZh7mHwF05YvE9HH
         wVIYM1OdSHWOoTeCJl2gx70au1tirXZ2kK72azyB/FmsLEPwyQmh1579JT+q4aBebwIt
         m37w==
X-Forwarded-Encrypted: i=1; AHgh+RrauRwEwE9cjAsJh8bf20Q7MAbdIgurNio/zevJG9ATPiCE7qVq6zTSeZ/YyrheqKhcydHz1ZYu27FSx6eX2O0=@vger.kernel.org
X-Gm-Message-State: AFuF++ngD0RQmxwQnhknzxKBBuoZmD7Jbdzt2XgVU3NrCUzu1SUQ/ypi
	VNjKOfLPsxPnMVlDDT2pvs6PhxpA5V4IUAcGFZemlsEe8UNOsaht153X
X-Gm-Gg: AR+sD10FWwtGkRWrfSZwXf+ysbBhzTmNp0gensPGrDbcIf0UglNm4JeGaGuRfLOZiUS
	wIVai2xgPFtol3tSymSh7wb2U9wC95eRMxoKPt/PCSflS7BSBcOHQ22jQx81d6mKXWD0kpjyuB7
	1yOO5zs25SxI2DNXIiVRlvLmn92b+H8UKttnny1LLK+LxOFCFi+bAwHAG8rQnrLYznpd3JLI1Ex
	ZWyTlUj1C/QNBPmCDOZdqjibqWzAMF8f5iXFUiThOZYXHE0YU7Sttcl9NdzFtv9VUcGcD1m6RRj
	6XPrsRYgeQdnP+NxNG9tRshK0RBpxFDa9pr5kFIoDad/a83gwnBgDGNAVsXq+AQ/ivVDcZAcdX2
	aX7yqSVfod6vLsdXGp7bTpZZX4Ost9SWfGh2Jm9d4SPegdlxdYpi0v+3xuqBGBSloPPQMG/g2hf
	jnT4FUlAm41GAVQgIF1N/I56e5LubYCTCsPPWVLg9eB6V7IXcIePPMevrdVbeozB8ik8ksJA==
X-Received: by 2002:a17:90a:dfd0:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-396d0fccf78mr8786188a91.13.1787890650739;
        Thu, 27 Aug 2026 21:17:30 -0700 (PDT)
Received: from localhost ([2804:30c:97d:e800:9454:1179:18df:ab33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d1b38esm1896535c88.3.2026.08.27.21.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 21:17:30 -0700 (PDT)
Date: Fri, 28 Aug 2026 01:18:18 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek
 STK36C61
Message-ID: <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>

Hello Jorijn, few questions inline.

On 08/26, Jorijn van der Graaf wrote:
> The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
> colour sensor (chip ID 0x95) found in the Fairphone 6. Its register
> interface is compatible with the feature set this driver uses: the
> STATE/FLAG bit layout, the data and threshold registers and the gain
> and integration-time fields, verified on that device (the ALS and
> proximity readings scale with their gain and integration-time fields,
> thresholds written through the event interface read back from the
> chip, and the FLAG near/far bit crosses with them). Add its chip ID to
> the known-ID list and the device table entries.
> 
...
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
...
> @@ -417,10 +459,10 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&data->lock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
> -		if (chan->type == IIO_LIGHT)
> -			ret = regmap_field_read(data->reg_als_it, &index);
> -		else
> +		if (chan->type == IIO_PROXIMITY)
>  			ret = regmap_field_read(data->reg_ps_it, &index);
> +		else
> +			ret = regmap_field_read(data->reg_als_it, &index);
The above seems unnecessary. Why changing the comparison from IIO_LIGHT to IIO_PROXIMITY?
After the proposed update we would have the integration time for both light and
intensity channels being read from the same register field?

>  		if (ret < 0)
>  			return ret;
>  
> @@ -428,10 +470,12 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>  		*val2 = stk3310_it_table[index][1];
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (chan->type == IIO_LIGHT)
> -			ret = regmap_field_read(data->reg_als_gain, &index);
> -		else
> +		if (chan->type == IIO_PROXIMITY)
>  			ret = regmap_field_read(data->reg_ps_gain, &index);
> +		else if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
> +			ret = regmap_field_read(data->reg_clear_gain, &index);
> +		else
> +			ret = regmap_field_read(data->reg_als_gain, &index);
Similar question here. What do we accomplish by comparing to proximity instead
of light? Is the gain info the same for light and intensity red/green/blue channels?

>  		if (ret < 0)
>  			return ret;
>  
> @@ -451,7 +495,8 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
>  	int index;
>  	struct stk3310_data *data = iio_priv(indio_dev);
>  
> -	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
> +	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY &&
> +	    chan->type != IIO_INTENSITY)
>  		return -EINVAL;
>  
>  	switch (mask) {
> @@ -462,10 +507,10 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
>  		if (index < 0)
>  			return -EINVAL;
>  		mutex_lock(&data->lock);
> -		if (chan->type == IIO_LIGHT)
> -			ret = regmap_field_write(data->reg_als_it, index);
> -		else
> +		if (chan->type == IIO_PROXIMITY)
>  			ret = regmap_field_write(data->reg_ps_it, index);
> +		else
> +			ret = regmap_field_write(data->reg_als_it, index);
Same pattern, same questions.

>  		if (ret < 0)
>  			dev_err(&data->client->dev,
>  				"sensor configuration failed\n");
> @@ -479,10 +524,12 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
>  		if (index < 0)
>  			return -EINVAL;
>  		mutex_lock(&data->lock);
> -		if (chan->type == IIO_LIGHT)
> -			ret = regmap_field_write(data->reg_als_gain, index);
> -		else
> +		if (chan->type == IIO_PROXIMITY)
>  			ret = regmap_field_write(data->reg_ps_gain, index);
> +		else if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
> +			ret = regmap_field_write(data->reg_clear_gain, index);
> +		else
> +			ret = regmap_field_write(data->reg_als_gain, index);
And here.

>  		if (ret < 0)
>  			dev_err(&data->client->dev,
>  				"sensor configuration failed\n");

With best regards,
Marcelo
