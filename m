Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8CA3612EF;
	Thu,  7 May 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155859; cv=none; b=HWkj3ZjeNdvXyyPmCXlJxmzXmruKfiN5EZ00ZnQTzXOKxur9BUfP7/1TsXg7WRbF1GPMJPalxch+Ks5/PyVTZ8op32rIqS3g6XTT3wO7L7nKRg0Guu2o/qVWlbzgTDmvi9fR34rTMJaKprM45KguqTNcFXtdQeSpPMmQJPemlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155859; c=relaxed/simple;
	bh=oW6Hq/f1c7nnHXSKe5TyzvPoJWvyESTNg7fUl48Rog0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9GwbBmCyBG+S70MEavCh2KKZ7dLYdjspSzMaE//ZUio9tHf5cgk/2XU6LBM7wajs6Aentlx3fEpxnDTqkaUBK8czd0j8O9VoK6Di7UiVlFHa20eqa0CQ3DgNqB9kKYo9Ri5qu7TwtmDhFhzODHYnpjPbuVAWa2d30BenAyv0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c7r7tsUr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2B4U11ne; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c7r7tsUr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2B4U11ne"
Date: Thu, 7 May 2026 14:10:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778155856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnf2eLwM4+kE1SjnDabjK0264s7bGpHMEasvI8tC1Ds=;
	b=c7r7tsUr+Mfn7uVXgPj25HKQLHBzCNoekFyQiZXMf9vpnnC7aSUpxkjtoxqd6D0WH4jzBX
	tXNdLFEjtfE9OC7V8T4mYEcwq+Z8Mmhx6uW2eSLLfhOhFJPxRgNUU0y0sBEINT2RVYTQPa
	vgtA1S/RoqlF1oGRauLvJL1oEZFX14qwi1iTSB5TORowjkRN3+efCwLU0wIrK1xtHfSwmY
	unYA4Ck2+7vvlqT+tR+s0Fq6P34lc5L6vDl9QOIcikVDoP2grQ+O1Jb0ryCbKTLlq+Y6Te
	bsqA8NJ4R0NE94B2qcNQMhAiWmyfaupEkPlLCpGsgT/E93eEfmxZZdpua7S4BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778155856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnf2eLwM4+kE1SjnDabjK0264s7bGpHMEasvI8tC1Ds=;
	b=2B4U11ne735cTdYGVFsZmWhT33/A2bEvWvslomWiaABRO5XjhPyBKUVz9sM6dpIIjg9GWw
	1WCO/shUNfdNgMCA==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/4] nvmem: Add Raspberry Pi OTP nvmem driver
Message-ID: <gbc67d5odk7d4l3rl66dsyeqazuidfiogfsteiwey53jr47tnu@auterzljztgh>
References: <20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de>

Hi,

replying to sashiko

>commit ee93b9620650bb02f494ab88ef4e18464c95770f
>Author: Gregor Herburger <gregor.herburger@linutronix.de>
>nvmem: Add the Raspberry Pi OTP driver
>This commit adds a new nvmem driver to support OTP registers on Raspberry Pi
>platforms. It accesses the OTP memory through the videocore firmware
>interface.
>> diff --git a/drivers/nvmem/raspberrypi-otp.c b/drivers/nvmem/raspberrypi-otp.c
>> new file mode 100644
>> index 0000000000000..1edf2d5538d04
>> --- /dev/null
>> +++ b/drivers/nvmem/raspberrypi-otp.c
>> @@ -0,0 +1,120 @@
>[ ... ]
>> +struct rpi_otp_priv {
>> +	struct rpi_firmware *fw;
>> +	struct device *dev;
>> +	u32 read_tag;
>> +	u32 write_tag;
>> +};
>> +
>> +struct rpi_otp_header {
>> +	__le32 start;
>> +	__le32 count;
>> +	__le32 data[] __counted_by(count);
>Is the __counted_by attribute safe to use with explicitly endian types?
>On big-endian architectures (which are supported via COMPILE_TEST), the
>native bounds checking logic will evaluate the byte-swapped __le32 value as a
>massive integer (e.g., a count of 1 evaluates to 16777216).
>Does this unintentionally bypass the bounds checking defenses?

Yes that is right on compile tests on big-endian it will bypass the run time
check. I can use the __counted_by_le() macro to disable it on big-endian and
keep it on little-endian.

>> +};
>> +
>> +static int rpi_otp_read(void *context, unsigned int offset, void *buf, size_t bytes)
>> +{
>> +	struct rpi_otp_priv *priv = context;
>> +	struct rpi_otp_header *fwbuf;
>> +	u32 count = bytes / 4;
>> +	int ret;
>> +
>> +	fwbuf = kzalloc(struct_size(fwbuf, data, count), GFP_KERNEL);
>Could an unaligned length request cause an out-of-bounds write here?
>If a caller requests an unaligned length (e.g., bytes = 3), count truncates
>to 0, allocating an 8-byte structure.

I first thought that alignment is checked in the nvmem system (with
nvmem_device::stride and nvmem_device::word_size)  but that is only true for
sysfs accesses. The nvmem_device_read/nvmem_device_write functions call directly
into the callback function of the driver. I guess there should be an alignment
check in this functions as well.

For now I will add an alignment check into my functions.

>> +	if (!fwbuf)
>> +		return -ENOMEM;
>> +
>> +	fwbuf->start = cpu_to_le32(offset / 4);
>> +	fwbuf->count = cpu_to_le32(count);
>> +
>> +	ret = rpi_firmware_property(priv->fw, priv->read_tag, fwbuf,
>> +				    sizeof(struct rpi_otp_header) + bytes);
>> +	if (ret)
>> +		goto out;
>> +
>> +	memcpy(buf, fwbuf->data, bytes);
>With an unaligned bytes request, would this memcpy write past the bounds of
>the 0-count fwbuf array? 
>Should there be an explicit alignment check for bytes and offset at the start
>of the function?

Yes see above.

>> +
>> +out:
>> +	kfree(fwbuf);
>> +	return ret;
>> +}
>> +
>> +static int rpi_otp_write(void *context, unsigned int offset, void *val, size_t bytes)
>> +{
>> +	struct rpi_otp_priv *priv = context;
>> +	struct rpi_otp_header *fwbuf;
>> +	u32 count = bytes / 4;
>> +	int ret;
>> +
>> +	fwbuf = kzalloc(struct_size(fwbuf, data, count), GFP_KERNEL);
>> +	if (!fwbuf)
>> +		return -ENOMEM;
>> +
>> +	fwbuf->start = cpu_to_le32(offset / 4);
>> +	fwbuf->count = cpu_to_le32(count);
>> +	memcpy(fwbuf->data, val, bytes);
>Similarly, could this memcpy write out-of-bounds if bytes is not aligned to
>a 4-byte boundary?

Yes see above.

>> +
>> +	ret = rpi_firmware_property(priv->fw, priv->write_tag, fwbuf,
>> +				    sizeof(struct rpi_otp_header) + bytes);
>> +
>> +	kfree(fwbuf);
>> +	return ret;
>> +}
>> +
>> +static int rpi_otp_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct nvmem_device *nvmem;
>> +	struct rpi_otp_priv *priv;
>> +	const struct rpi_otp_driver_data *data;
>> +	struct nvmem_config config = {
>> +		.read_only = false,
>> +		.word_size = 4,
>> +		.stride = 4,
>> +		.reg_read = rpi_otp_read,
>> +		.reg_write = rpi_otp_write,
>> +		.id = NVMEM_DEVID_NONE,
>> +	};
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	data = dev_get_platdata(dev);
>> +	if (!data)
>> +		return -ENODEV;
>> +
>> +	priv->fw = dev_get_drvdata(dev->parent);
>> +	priv->dev = dev;
>> +	priv->read_tag = data->read_tag;
>> +	priv->write_tag = data->write_tag;
>> +	config.dev = dev;
>> +	config.priv = priv;
>> +	config.name = data->name;
>> +	config.size = data->size;
>> +
>> +	nvmem = devm_nvmem_register(dev, &config);
>Does this devres usage introduce a use-after-free risk during device unbind?
>If an in-kernel consumer holds a reference to the nvmem device,
>devm_nvmem_unregister() drops its refcount but returns while the consumer's
>reference keeps the device alive.
>The devres framework will then proceed to free the priv structure.
>If the consumer subsequently calls nvmem_device_read(), will it dereference
>the freed priv pointer inside rpi_otp_read()?

Wow good catch. This took me a while to understand but i guess it can indeed
cause an use-after-free error error for in-kernel consumers. I will look into
it.
