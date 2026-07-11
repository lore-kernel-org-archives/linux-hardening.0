Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260927B353
	for <linux-hardening@vger.kernel.org>; Sat, 11 Jul 2026 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782598; cv=none; b=B7JOsQphn13LDw36Kl/aBvHnAllIM3Dv9NOj+Z4A9Kg1+7PEbr20CTvvcIzMIH36oCiXRT+RdcBvBuYu6nm+nzkEuQvKUVxSg80m8MOaHnrUOAc464LYu/q3VMqYN5sNn2wc6SCXgPbmlPmaSSHUj0k0VhHxg5v9FhZ1gMbb3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782598; c=relaxed/simple;
	bh=u656KmwHS2NuwcwmZgMH2DXucDEuVNMw+znBt3qpx2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPQBRpLIqciD4QPJQs9Ldps6EQvj97iXj1YpH9gWPtvZM4mrsNiulKj+4GSj88eo821HxPQd1kLqoocWQYO65b3tAE8X/vqgJWlFGPLS2xFS43HRw0+88y1qkiikSnZZiHyprAhBTgDteWm76mJyyyDYcKPDAs0ckext5jUIBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BesgDaNj; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BesgDaNj"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso1598903a34.3
        for <linux-hardening@vger.kernel.org>; Sat, 11 Jul 2026 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783782595; x=1784387395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nr0soaAtqthPp2U17XEZK/Vr4kfG1VMxAbHUIXSh0Dc=;
        b=BesgDaNjNQYR+jKIUeO95DXLO7HZIlzux01aKseMB+0HxqCGKgU+74uGM9z1QDPA6A
         C9C/D6ZKcjQslnOp3+ONoVHoNVIScnRNiUKZMHRhbiGclV+woARoyTuAJ6U4rYo/PMYz
         54Dk4ql8ihuxIg69M69LwFW0Sl4AviGoTXgCXnwA5vdFEEVpHUSsJozLT+BAdRD/nSAN
         rh1Of8Yul+Bc6Uvq1Ee3qMlpbOLfTVSn7rz85xC0k1oU5O87r8XocBptL69BQQJMqBFk
         6eBTQV5vqSQkuEW8fP3cWY2pLp+WeWhH5VXzmbsH3kP/GArcv6RI2rJlY7TpBrOQgx8z
         ngPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782595; x=1784387395;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nr0soaAtqthPp2U17XEZK/Vr4kfG1VMxAbHUIXSh0Dc=;
        b=qyTXOif0gPBelvK7kVoe8l6C7HFrR3hCQD/sC9kkgIIWix2NsIwQp9sg1RsOFzuMfH
         AqmhSaXBGKX7vDPr46k3LaQ/3MrnUyvSmMVBf4uQyolGHRvqBbTK4gGBfZNk13jjZIo9
         xmcQYenOUGznUzufoNVkZJioUUdXx8M5Jum5NqaNqVhOwZg2GLvDR9BonAaLF+F7M59M
         QV33mqTLL6/JeoCnckRLVdMBJfVvwgqv3upNu24e/5CKpfTCkK1OXbvMbMEebb67uo11
         RR8xzpiq4EkqubvYShtqemGDTgs5g6hYn8vnys1bD4LDFbXs794YnWE4iims3VckNlO4
         vFFg==
X-Forwarded-Encrypted: i=1; AFNElJ+pO5oJzGmcaEpSL6VFWU6xqfpeE1NsE4w1lVSYfoBVt15K2/E224ArCaEpO/MDOxAmcLmogbC+wVrHnd4tbVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhw0Wrfo3cGsEONaUDVKu9TZ7sJRYG4iaIB5gl6JstojmBF29
	2Ai6vWCGw2y9qvaUlhn4WmrPk8i3eAcxXX11WR7I6DkhnJjQt9P7nqpmBs98yCrIXSw=
X-Gm-Gg: AfdE7cnIS7M6FHaL4/rXuN6fJ7XIE05We1zvS5nU877I0fPXuH3iWHqDhM23pW2xjsy
	8QNg5LHjrQDDuaEAwt8zQZzGRxakpOuj+E6QX29HL8jE75M/n3BvbuJ65y19YsT4k3u5F/PfDuk
	i1DDCBfRDjj5h1rdBBKTu5n6gQKMuoPGkthS5hkfHuZ/iiAvEtgETCYyCHERPMBTORnWkst5B1g
	Sx0g0XB7V4r8/+iO9CnEzLdeb1FfpYOMpwXekexapDPZsX/GXQsVh9MPmt51YtpSJYzwUJoWW1q
	stRc98eM8XoFtT98sndf5MHeH3Dx/tXps994AP9PORSNcvPDl+xAP+CMvEsCYOfYvvE3y3G6vWK
	ky1kwvVFjRcDdpiebi+5AW9YY1VCDYM7mNIIAAl2r0+bZnNHbes/0sJ1el3O8VJXHMGoGwzDLRO
	I0z13jqZMd4AdN2PPZUMnc04q1QrT1Mc2pBK7a8kT0r7ETE/jb6/rNLNCtLfritekpP+LWR2Z1S
	g==
X-Received: by 2002:a05:6830:2309:b0:7e9:e5c0:e0a with SMTP id 46e09a7af769-7ec095c68cdmr2096634a34.5.1783782595189;
        Sat, 11 Jul 2026 08:09:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae1dddbsm8558095a34.1.2026.07.11.08.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:09:53 -0700 (PDT)
Message-ID: <0b513d21-31e5-497a-9332-7efc3fd3e010@baylibre.com>
Date: Sat, 11 Jul 2026 10:09:51 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] iio: dac: ad5686: read_raw/write_raw: use
 guard(mutex)()
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Maxwell Doose <m32285159@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-5-1bcc8c280e4d@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710-ad5686-new-features-v7-5-1bcc8c280e4d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 6:20 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use guarded mutex lock to facilitate code review when adding new
> attributes. This will allow for early returns, avoiding error-prone
> locking and unlocking in error paths. This also adds missing include
> linux/cleanup.h. Gain-control support will allow the scale attribute
> to be configurable.
> 
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 316f9ccf54d9..df32f46db81e 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -8,6 +8,7 @@
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/dev_printk.h>
>  #include <linux/errno.h>
> @@ -177,11 +178,11 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> +	guard(mutex)(&st->lock);

The commit message should explain why the location we are taking the lock
has moved. Although, I don't see a reason to move it.

> +
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&st->lock);
>  		ret = ad5686_read(st, chan->address);
> -		mutex_unlock(&st->lock);
>  		if (ret < 0)
>  			return ret;
>  		*val = (ret >> chan->scan_type.shift) &
> @@ -202,23 +203,19 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> -	int ret;
> +
> +	guard(mutex)(&st->lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (val >= (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;
>  
> -		mutex_lock(&st->lock);
> -		ret = ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> -				   chan->address, val << chan->scan_type.shift);
> -		mutex_unlock(&st->lock);
> -		break;
> +		return ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> +				    chan->address, val << chan->scan_type.shift);
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
> -
> -	return ret;
>  }
>  
>  static const struct iio_info ad5686_info = {
> 

