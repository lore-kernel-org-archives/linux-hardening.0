Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505F156653
	for <linux-hardening@vger.kernel.org>; Tue,  4 Feb 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738632512; cv=none; b=A5gupYafw3Wcj03g9Tem+I5NmCFDtrpgLrUsNn4m5ZCFSE9c7+zr0oql/jbIL0HmSJD/b128UGQzFSeng7xprVkRvAOo2cA21JkYags1/xNso42cWZoU62WhtL4UhWIje77F7arH0uhh4ZJ+T1SM916t4f8yDVmHLeBPF8Pee94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738632512; c=relaxed/simple;
	bh=o/048RK8KbfvFNL35mW1RqTvxs6dxfeNWBz91bdQgTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhyHyHW/3IrnbFk5YGTNdgB4OkAzHMtUTffhOtb6d9PFMvwSfJ+vq4y9YxZ/2jiS1hkuxpJVIuC7QWZTaoiY6FBDp3hw4u588U+Q4Rns4DUQ8PeExP0eLThEqlKU31uvNX4R4GjmPAbGDqXG22Mf6AszwocZfqOJpZqQB09kcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=zhh1q7JA; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="zhh1q7JA"
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id eyrktHOMnWuHKf7jktJV8i; Tue, 04 Feb 2025 01:28:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id f7jjtuCZQhQfUf7jjt5CGd; Tue, 04 Feb 2025 01:28:23 +0000
X-Authority-Analysis: v=2.4 cv=Negt1HD4 c=1 sm=1 tr=0 ts=67a16d37
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=3GLQtCDrk5mhnYkuwPoHkA==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=4kty7C-LuapIIgrfkgcA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1bcZbq5etASTQ/kWDMfEYbte/eHZMRZ/ExU1etRZnzk=; b=zhh1q7JAv+tsaL5IvlC2FnHs7K
	kKDgPR9JleRzhjGUg4Io4kM5UQwvl0yLZJPOqbfV0lJhGO8aIRNGJhYiXpHln6mxjAxq7Jx2nrS1A
	m2KobqSFEOybht5GqDgQw6/hDBAsQnroSXdXYouwYMZbhe0g6xhAB5LCx76l8gWtEMFZ/KnCrDsFG
	jxvrTPJ5mVoMzzyFF+pFyXHj/8jCauBVeAzrwYcGuF4A5FEopMVrnvHuokgpCqTG6ywloG7lHmfoW
	XDRgtEURECDMzCQH8S6WtYpetBNLvpd9JtDBXBtW7SUlfzOU/jGfXvVW/f8rb81MlV9cvieKeNxEY
	Xn6gbT2g==;
Received: from [45.124.203.141] (port=55286 helo=[192.168.0.157])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tf7jh-0027Ze-25;
	Mon, 03 Feb 2025 19:28:22 -0600
Message-ID: <82b97884-19a3-4948-8212-d0fd38669ee2@embeddedor.com>
Date: Tue, 4 Feb 2025 11:58:02 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] gpio: 74x164: Annotate buffer with __counted_by()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250203121843.3183991-1-andriy.shevchenko@linux.intel.com>
 <20250203121843.3183991-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250203121843.3183991-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.141
X-Source-L: No
X-Exim-ID: 1tf7jh-0027Ze-25
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.157]) [45.124.203.141]:55286
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfArqBpvv5POiDaz2VFeE0WI4v0KNZviHahUaTCWEhXq8irDZU8OedmyLH/2hhhexiHJb4Jfj9OAC5rqav8aolxX82FeAq6/kVVNGWr9VCi7ZycL1W+S8
 Yo5FLYm1bVdyTS4BAOQpjz9Rd2YNepgRy+l/T6dOfa9bw1HFWvQmJckHyRPwHKU70tspzk3oDl5eEzAJue+cGLC6zuHQv89fn2SUZZojTTOG3X4A9EOcYSf6



On 03/02/25 22:47, Andy Shevchenko wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> volumes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Use struct_size() instead of manually calculating the number of bytes to
> allocate the private structure with a buffer.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/gpio/gpio-74x164.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
> index 70c662bbca7b..7844f8a58834 100644
> --- a/drivers/gpio/gpio-74x164.c
> +++ b/drivers/gpio/gpio-74x164.c
> @@ -30,7 +30,7 @@ struct gen_74x164_chip {
>   	 * register at the end of the transfer. So, to have a logical
>   	 * numbering, store the bytes in reverse order.
>   	 */
> -	u8			buffer[];
> +	u8			buffer[] __counted_by(registers);
>   };
>   
>   static int __gen_74x164_write_config(struct gen_74x164_chip *chip)
> @@ -97,6 +97,7 @@ static int gen_74x164_direction_output(struct gpio_chip *gc,
>   
>   static int gen_74x164_probe(struct spi_device *spi)
>   {
> +	struct device *dev = &spi->dev;
>   	struct gen_74x164_chip *chip;
>   	u32 nregs;
>   	int ret;
> @@ -116,10 +117,12 @@ static int gen_74x164_probe(struct spi_device *spi)
>   		return -EINVAL;
>   	}
>   
> -	chip = devm_kzalloc(&spi->dev, sizeof(*chip) + nregs, GFP_KERNEL);
> +	chip = devm_kzalloc(dev, struct_size(chip, buffer, nregs), GFP_KERNEL);
>   	if (!chip)
>   		return -ENOMEM;
>   
> +	chip->registers = nregs;
> +
>   	chip->gpiod_oe = devm_gpiod_get_optional(&spi->dev, "enable",
>   						 GPIOD_OUT_LOW);
>   	if (IS_ERR(chip->gpiod_oe))
> @@ -133,10 +136,7 @@ static int gen_74x164_probe(struct spi_device *spi)
>   	chip->gpio_chip.set = gen_74x164_set_value;
>   	chip->gpio_chip.set_multiple = gen_74x164_set_multiple;
>   	chip->gpio_chip.base = -1;
> -
> -	chip->registers = nregs;
>   	chip->gpio_chip.ngpio = GEN_74X164_NUMBER_GPIOS * chip->registers;
> -
>   	chip->gpio_chip.can_sleep = true;
>   	chip->gpio_chip.parent = &spi->dev;
>   	chip->gpio_chip.owner = THIS_MODULE;

