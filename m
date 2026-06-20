Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547E1E7C2E
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973236; cv=none; b=RCc/vLKIY7nYhXfsLptCk1VOpiPUPyv8ZhkET+a7RRPAMSei6p6e7Rm8qjdsyv/uxLGGGMlNHcRhjKUsY2d9P+EDPb/bPlinurzEBuC+BlIlgUwLJHsHyZ5O0FLrGc6ay5MJV4y3wmw+A/L9A4LWgzjhC5gaILrSqh7ZmNsbF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973236; c=relaxed/simple;
	bh=9ZZdeMqEGteO5Cjp9+wb3clazfiTFHYR33FoYAkV8Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ow8IPAw/puh9OEzSvTmkUu/0afDTLrKhxazchuljIzcoNJuPbMQBwuNzJS+aqKzpd2h3g3JI0rloOYgQ3nILKUIY3Zp3UUOEztxJPjCUVyVHKU61qaEyxPfF2oh0shJ2xyk52KRVdXAzQLNbnKIn50e3/3uE/+5HIiFanC46sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=E9PLdCsE; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="E9PLdCsE"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6b5737bb2so2523922a34.1
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781973234; x=1782578034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8PDHrQnKyyTqXVXmOYBfplcRBPjuSq6GDKn7hYJ0Sg=;
        b=E9PLdCsEsQ/v5zGBh6vDw3m5SE0X+tFq38qJKI0FHKN9dr4wUibm0SxktbCZkx9f37
         x1shPQX86w4W9MnVczezOjLDUByP2k7wixAYNxGdvXeQJeSCH/SMtQGC3BnejPGaYwiX
         wRzQNRKTFX/0GLSc3ZPP67K/kU9/Mpnrv4TlGYjvhn+IITJ0gWelLqvCovdNU5glMWjq
         aRf4gbcr+3amYzbv+QThOhCQERB33/I96/j+C8BBCWNglnjOFHmPfHIyDOPnqWKO/TvO
         VeQlx5Tpxu7k1AXLhPoCuFZovN5oUVYOkWXWws/gvDCVmqTWPBNurqQRxlXX+IDIXyfb
         Qs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781973234; x=1782578034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8PDHrQnKyyTqXVXmOYBfplcRBPjuSq6GDKn7hYJ0Sg=;
        b=bQSdHe71JJEfppEqECxijWPXiBlt6GGu4+ReBuGeTcFRnEPtOuB1cNgum/uZoUQiAq
         9i/TZhEs99q478k7WgQRaeWBo6aOrpy5gd1N1AQw1QMUeGZycn8dzTjQpN2kq9YkUF38
         cVFwyx/ckA9hoozPvIA2F5XzEmpOgATVZD6WtccPZ/S8dr78gcnq3J+gBsPWlou0ovIA
         utQVZlmz2qAPV0fNMbzbfN+qoqgU+iGFcQXBzPoNsHqF0+0CaEsbfFhP+B6ZZW8buIuW
         4/tWJzFKIjwt/68GcqTbWwAZfs6VleDghtWoSqax2841bLGYvQkGm6catDqDXCiJW0pF
         xurA==
X-Forwarded-Encrypted: i=1; AFNElJ8aQvBkfcMxfCx5m95pbYnQA3Ow3WfGxfRJi0QEcYzTRoNEmsEbEiMot9EdV87LO7G4Qt4Qfc4rYXDsXcUbluI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWG19Y6A9jEjOmRvYyoetkMMmTgPuc7ARdyrHo5jjTgfdNBura
	Ku4xfHkOrFtI5GGbWd31ao2lA8Q/lpofBxV0BQTFHeYIec0ETE6FDFngUmd24asyKEw=
X-Gm-Gg: AfdE7ckbd6qBEFGIKrrUx+M3ZIeJa7BSwinufRo62FKxqnoO9dnMSm1w03D0uU/0vg8
	oaYvO9ln9PnKqAt9ligffyWQxiwvhJEs/tHYZ/YDH7e0V9+F5QWz3Mg5oT/k1TYNd5CHcaH4+NP
	QQurb8ry4nadsw6qqQ0zaELowPy0+IJ71Hx73B+9BPjlcdnQNH8R8fDgTc0yPPHW3SjHbAlc4+3
	althigmk3xj1cqzFpEvxOUkKRR3KC+qq/GFwDQqmJY3cYZei6x4JLvpg6wDMjxkyAC/3jt8AzOk
	Vpeo6qykO9bjASUJ/Ml+WisMxT2bvFAtCl4+tju+TWRG5hY0iE2S+IALpPOCNIoiPOi660wVgfF
	bnz6g+P/OhlIHAk4Lm7hQcvRfmCb5WsQ8bly+2VxJKU9UnNuAjv5cBZyf4shIIPtvYMCGoAHB8a
	617UijevEBM3/kFfTCVcw883x9fvPg0zWLz0kOamjj9mr2OgGpE/S0VWY3cND4ZtU=
X-Received: by 2002:a05:6830:2704:b0:7e4:411:7ad with SMTP id 46e09a7af769-7e9323f55fbmr5980088a34.24.1781973233739;
        Sat, 20 Jun 2026 09:33:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3ad0:4082:8242:2d72? ([2600:8803:e7e4:500:3ad0:4082:8242:2d72])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94424ca09sm2018931a34.16.2026.06.20.09.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 09:33:53 -0700 (PDT)
Message-ID: <50a7e765-ba20-45c0-8a13-5e672413b600@baylibre.com>
Date: Sat, 20 Jun 2026 11:33:52 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] iio: dac: ad5686: implement new sync() op for
 the spi bus
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-9-f829fb7e9262@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260616-ad5686-new-features-v3-9-f829fb7e9262@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 3:21 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use of local SPI bus data to manage a collection of SPI transfers and
> flush them to the SPI platform driver with the sync() operation. This
> allows for faster handling of multiple channel DAC writes, avoiding kernel
> overhead per spi_sync() call, which will be helpful when enabling
> triggered buffer support.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686-spi.c | 121 ++++++++++++++++++++++++++++++++-----------
>  drivers/iio/dac/ad5686.c     |   4 +-
>  drivers/iio/dac/ad5686.h     |   8 ++-
>  drivers/iio/dac/ad5696-i2c.c |   2 +-
>  4 files changed, 100 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 6b6ef1d7071f..77c86674d178 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -12,59 +12,91 @@
>  #include <linux/errno.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/spi/spi.h>
>  
>  #include <asm/byteorder.h>
>  
>  #include "ad5686.h"
>  
> +/**
> + * struct ad5686_spi_data - SPI bus specific data
> + * @msg: SPI message used for transfers
> + * @size: number of transfers currently in the message
> + * @capacity: maximum number of transfers that can be added to the message
> + * @xfers: array of SPI transfers, allocated with the provided capacity
> + */
> +struct ad5686_spi_data {
> +	struct spi_message msg;
> +	unsigned int size;
> +	unsigned int capacity;
> +	struct spi_transfer xfers[] __counted_by(capacity);
> +};
> +
>  static int ad5686_spi_write(struct ad5686_state *st,
>  			    u8 cmd, u8 addr, u16 val)
>  {
> -	struct spi_device *spi = to_spi_device(st->dev);
> -	u8 tx_len, *buf;
> +	struct ad5686_spi_data *bus_data = st->bus_data;
> +	struct spi_transfer *xfer;
>  
> +	if (bus_data->size >= bus_data->capacity)
> +		return -E2BIG;
> +
> +	if (bus_data->size)
> +		bus_data->xfers[bus_data->size - 1].cs_change = 1;
> +	else
> +		spi_message_init(&bus_data->msg);

Seems odd that spi_message_init() is called conditionally. What
prevents spi_message_add_tail() from growing the message unbounded
on repeated calls?

> +
> +	xfer = &bus_data->xfers[bus_data->size];
>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
> -		st->data[0].d16 = cpu_to_be16(AD5310_CMD(cmd) |
> -					      val);
> -		buf = &st->data[0].d8[0];
> -		tx_len = 2;
> +		st->data[bus_data->size].d16 =
> +			cpu_to_be16(AD5310_CMD(cmd) | val);
> +		*xfer = (struct spi_transfer) {
> +			.tx_buf = &st->data[bus_data->size].d16,
> +			.len = sizeof(st->data[bus_data->size].d16),
> +		};
>  		break;
>  	case AD5683_REGMAP:
> -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> -					      AD5683_DATA(val));
> -		buf = &st->data[0].d8[1];
> -		tx_len = 3;
> +		st->data[bus_data->size].d32 =
> +			cpu_to_be32(AD5686_CMD(cmd) | AD5683_DATA(val));
> +		*xfer = (struct spi_transfer) {
> +			.tx_buf = &st->data[bus_data->size].d8[1],
> +			.len = sizeof(st->data[bus_data->size].d32) - 1,
> +		};
>  		break;
>  	case AD5686_REGMAP:
> -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> -					      AD5686_ADDR(addr) |
> -					      val);
> -		buf = &st->data[0].d8[1];
> -		tx_len = 3;
> +		st->data[bus_data->size].d32 =
> +			cpu_to_be32(AD5686_CMD(cmd) | AD5686_ADDR(addr) | val);
> +		*xfer = (struct spi_transfer) {
> +			.tx_buf = &st->data[bus_data->size].d8[1],
> +			.len = sizeof(st->data[bus_data->size].d32) - 1,
> +		};
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	return spi_write(spi, buf, tx_len);

If this function no longer writes, should we change the name of
the function to something like ad5686_spi_write_prepare_msg()?

> +	spi_message_add_tail(xfer, &bus_data->msg);
> +	bus_data->size++;
> +
> +	return 0;
> +}
> +
> +static int ad5686_spi_sync(struct ad5686_state *st)
> +{
> +	struct spi_device *spi = to_spi_device(st->dev);
> +	struct ad5686_spi_data *bus_data = st->bus_data;
> +
> +	bus_data->size = 0; /* always reset, even on sync failure */
> +	return spi_sync(spi, &bus_data->msg);
>  }
>  
>  static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  {
> -	struct spi_transfer t[] = {
> -		{
> -			.tx_buf = &st->data[0].d8[1],
> -			.len = 3,
> -			.cs_change = 1,
> -		}, {
> -			.tx_buf = &st->data[1].d8[1],
> -			.rx_buf = &st->data[2].d8[1],
> -			.len = 3,
> -		},
> -	};
>  	struct spi_device *spi = to_spi_device(st->dev);
> +	struct ad5686_spi_data *bus_data = st->bus_data;
> +	struct spi_transfer *xfer = &bus_data->xfers[0];
>  	u8 cmd = 0;
>  	int ret;
>  
> @@ -85,8 +117,21 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  				      AD5686_ADDR(addr));
>  	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
>  
> -	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> -	if (ret < 0)
> +	xfer[0] = (struct spi_transfer) {
> +		.tx_buf = &st->data[0].d8[1],
> +		.len = sizeof(st->data[0].d32) - 1,

Would make more sense to say `sizeof(st->data[0].d8) - 1` since
the buffer is  &st->data[0].d8[1].

> +		.cs_change = 1,
> +	};
> +	xfer[1] = (struct spi_transfer) {
> +		.tx_buf = &st->data[1].d8[1],
> +		.rx_buf = &st->data[2].d8[1],
> +		.len = sizeof(st->data[1].d32) - 1,

And here.

> +	};
> +
> +	spi_message_init_with_transfers(&bus_data->msg, xfer, 2);
> +
> +	ret = spi_sync(spi, &bus_data->msg);
> +	if (ret)
>  		return ret;
>  
>  	return be32_to_cpu(st->data[2].d32);
> @@ -95,12 +140,26 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  static const struct ad5686_bus_ops ad5686_spi_ops = {
>  	.write = ad5686_spi_write,
>  	.read = ad5686_spi_read,
> +	.sync = ad5686_spi_sync,
>  };
>  
