Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA616287247
	for <linux-hardening@vger.kernel.org>; Sat, 11 Jul 2026 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783374; cv=none; b=MVy4nZ7aCRjAuo7OV+TpH6S9MhEV6JnvMEsn7NgCG8khGTGqlqHOKyg78wwlXhMUQ+aD6ODRfkmhef+7jSS0W8Ms3zUMyOJUU4x7Ewb2CnGCcza8XcA3JH3cKbnmmCvzD6Ovi4GUyHoOSNyJT6VduihNy9yRvmw6rNw9R3xBSxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783374; c=relaxed/simple;
	bh=cyISK+85Dz541Qqs0If42ibLezlTMoZfbi29ufY26+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN2HDKeZMXH44Qaird0Lxo6UPYaWlLEZGuWtC/aXdVK/pygp7zpf9tnJQkaro9Lu/yBFG/aZKcytEHb6zgmixM4ou7lkz8cy/lI7CP16rm7uAXd+P17Ij2bhzl6zw3M1GMiRVhXpywpcPfEpVODeoPXh1hUlD9/56qglrB5U3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MhoM3U/I; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MhoM3U/I"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6b554044fso1726133a34.0
        for <linux-hardening@vger.kernel.org>; Sat, 11 Jul 2026 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783783371; x=1784388171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQgvAx06dSlqRMJAhcTe3Z4aoWlaS6qUI00wrJ9Xoq8=;
        b=MhoM3U/IzuZwbWRXMHaESKT/BfhxNnv5SVSMwk5BPx0Vh4jrvbfqx0uJJQLLlH2AwH
         f8nfBAeLOqmOTdk01giiOWSCY8X/XpEcW+6gipKvQA0kpZs7wFffgAzE3wvpL8HDfFyL
         0TzPL5z+/xzNlPtpAwu3OnjYWrD82vzLaiq+g+2EAF7nSVZXT1gYMr/MEWWo5igQTLsa
         iV7jsSUp7W5iJEFn2RGByUjy4IejvEUUVdgwaAJuZg50ulu0tNtKtLtreYk1fHR10gbb
         r4UxH7gShfp3GHN/U6gQWa4X7WId0LLVMdnyYmO8FMHfDHYg5rTOptPmXDMfNBvZ0Tbw
         bkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783371; x=1784388171;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RQgvAx06dSlqRMJAhcTe3Z4aoWlaS6qUI00wrJ9Xoq8=;
        b=VATomuhUbxEhWLyxSJtAGO+Mt7FOnaLC9NOy2liQgtPeJTFgLz5vq6zlOVnZEy6X3H
         k5bvj2UfgUmF1eROWQ+mBwRt69hwei4fWKC2G2k/F6mXhq4jTVx9gj8zQVoxpIGUzIEC
         Dcagye2qasecdRlFyMMyQO/LsAB/BoM+O6Kmc/M6Cv6Vh8inkv1K2ZbrptSb0j3v6hk0
         z2GSqRv0VDBAq4FlWfftaBt3Od2jCYOst/0gxQndcb4/h+W+JSu6GftMBFRXDzYxv5j5
         xNlcInTF7p084f0azWrFsejWFceW8USSOFGLzAQlwx5NDsC22zG7XZ8uQMjvFQO2lwWU
         oqvA==
X-Forwarded-Encrypted: i=1; AFNElJ9v//7d0qN/3X6GSjPs4KeNYhWHYxSQH2eIs6/ZKpq17XGGyJ7bIbktJ08cFrJXge0jxR12EA0cJWUpegcP6PE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbu5hH4VaHxBBtFMqF1HKMi7rOwwPKzxpQmXr8xeGzVQgS/F6x
	XXerYrimGzQM220JCjXChDWBVpZQtY2khgX/jrk1aFd8RDou3Bm5J/rfqEiEz9R/EQk=
X-Gm-Gg: AfdE7cledBcAoNggsfQDEL8HhLnDLmsUa/4d4g16OFo4QXOZSPmVYaxru4yMhuZ436T
	j7h9A1p8sYarW6bM8QVba+4evFmfOXCpWjD39+PTNaE+EPXw3gceilF3PF1XvUsijsaFnJV5Aa6
	zQupfkvOTnUosvRs01wtcFlmN6xNohEqh2h0hj/HrdsZaH3hy4uCXZv2Ej6W3xZGIUhD8B9deaj
	IyTtZNsJbiPFJU4RUWuZnpyZGbr4dvkLE+u8GIex8DVmYEbE8JYe7/E/80wVGrEnW5wxQ1Uruji
	ol8IhQTHp9eJfX5Tvnz/CpYsKLrfu27StrbAYrPjoIR0c1LpzJUSpJCJBFZ+WLP2VuIiSUpjE9M
	9KHS4/UCqg+zh1hnqoowgqz3yb7HGqk668aCA9NNZzmCDbd3t/Mqq0NdL2m5akjj4Pn2EnGUBV6
	wVfhSLMaZBEu7IPX7QKjo7VB24rWgWSVaC/JvXM49MLKGQrTQmVlOxYNsYpnbIP6M=
X-Received: by 2002:a05:6820:4de5:b0:6a3:7b7e:ee6c with SMTP id 006d021491bc7-6a39a6d19b7mr1803639eaf.40.1783783370923;
        Sat, 11 Jul 2026 08:22:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae20782sm9133072a34.4.2026.07.11.08.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:22:49 -0700 (PDT)
Message-ID: <a5c58557-8289-4cd8-85bd-3349e410392d@baylibre.com>
Date: Sat, 11 Jul 2026 10:22:48 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] iio: dac: ad5686: add gain control support
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-7-1bcc8c280e4d@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710-ad5686-new-features-v7-7-1bcc8c280e4d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 6:20 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Most of the supported devices rely on a GAIN pin to control a 2x
> multiplier applied to the output voltage. Other devices, e.g. the
> single-channel ones, provides a gain control through a bit field in
> the control register. Some designs might have the GAIN pin hardwired
> to VDD/VLOGIC or GND, which would have no "gain-gpios" device property,
> being able to set "adi,range-double" if it is hardwired to VDD. The
> vref_mv field is moved down in the struct ad5686_state, so that the
> overall size increase is reduced.
> 

...

> @@ -217,6 +229,82 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  
>  		return ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
>  				    chan->address, val << chan->scan_type.shift);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val == st->scale_avail[0] && val2 == st->scale_avail[1])
> +			double_scale = false;
> +		else if (val == st->scale_avail[2] && val2 == st->scale_avail[3])
> +			double_scale = true;
> +		else
> +			return -EINVAL;
> +
> +		if (st->double_scale == double_scale)
> +			return 0; /* no change */
> +
> +		if (st->chip_info->regmap_type == AD5686_REGMAP && !st->gain_gpio)

This condition is used a couple of times. It could be nice to just add a
st->pin_strapped_gain field to make it self-documenting and use that instead.

> +			return -EINVAL; /* GAIN pin is board-strapped */
> +
> +		st->double_scale = double_scale;
> +		switch (st->chip_info->regmap_type) {
> +		case AD5310_REGMAP:
> +			ret = ad5310_control_sync(st);
> +			break;
> +		case AD5683_REGMAP:
> +			ret = ad5683_control_sync(st);
> +			break;
> +		case AD5686_REGMAP:
> +			ret = gpiod_set_value_cansleep(st->gain_gpio,
> +						       st->double_scale ? 1 : 0);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +		}
> +		if (ret)
> +			st->double_scale = !double_scale; /* revert on failure */
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
