Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D2B1DE884
	for <linux-hardening@vger.kernel.org>; Wed,  9 Apr 2025 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180837; cv=none; b=qi9L6oyIKH3q1AGOy42jieUuIUm6g5HmCWdXjJDlsUTfTpD5wyRTsooBPqu6BKD/wy4DlfYkoMyNF3bldSvWHbCg5ETb0W3KQxB0UWBL9zI7OtFv/AwzzNkHq5rVAwxeCm1+aIH3h1uafIsVVwik6Ak13A7RhcH75MTePfiruOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180837; c=relaxed/simple;
	bh=fCEfYtmFH6rGKcVieG+9qEMAsfW+dbKvw5cxExd42eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUJ2BoXfe5+rl2WFqg0MfDGNQ2/5x5y4Q2JlpOgaWOdd6yAVHVo+VQ/ZaCQbrT55aj42ZLn+65GSgecc6V2A20fXuimYC4AZ+kIOKseHHQizWGFoHawwzKTa3NVlo+sYO+8f2NBo/YalO9GGyE8FpuxOQY0sgZWGdrP9/4uc/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuOHV+Pr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuOHV+Pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744180834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEq+Iv/LM2UETreZmi3CwTkcO/puV6AGdcdNXTDUug0=;
	b=LuOHV+PrGFmf3ui/TQZGucgCO0k2Snir49DFdAfyTZkjX+ZTF9bGAho0tj6jcu1zPT5PUg
	jqbAiI0QXcAX5tM4LMe6a99ygWByKA1oxNQ6nyyeYO2NPqiLMiWh0O2L+579ewyJjobixw
	wi8cntaxsEKc+slA5Vv1CSTkKO0eMqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-eJ9JksEPPwCt0cKWPUl8aA-1; Wed,
 09 Apr 2025 02:40:30 -0400
X-MC-Unique: eJ9JksEPPwCt0cKWPUl8aA-1
X-Mimecast-MFC-AGG-ID: eJ9JksEPPwCt0cKWPUl8aA_1744180829
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C0BD1800EC5;
	Wed,  9 Apr 2025 06:40:28 +0000 (UTC)
Received: from [10.44.32.72] (unknown [10.44.32.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AB613001D0F;
	Wed,  9 Apr 2025 06:40:23 +0000 (UTC)
Message-ID: <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
Date: Wed, 9 Apr 2025 08:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] mfd: Add Microchip ZL3073x support
To: Andy Shevchenko <andy@kernel.org>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-2-ivecera@redhat.com>
 <Z_QTzwXvxcSh53Cq@smile.fi.intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <Z_QTzwXvxcSh53Cq@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07. 04. 25 8:05 odp., Andy Shevchenko wrote:
> On Mon, Apr 07, 2025 at 07:28:28PM +0200, Ivan Vecera wrote:
>> This adds base MFD driver for Microchip Azurite ZL3073x chip family.
>> These chips provide DPLL and PHC (PTP) functionality and they can
>> be connected over I2C or SPI bus.
>>
>> The MFD driver provide basic communication and synchronization
>> over the bus and common functionality that are used by the DPLL
>> driver (later in this series) and by the PTP driver (will be
>> added later).
>>
>> The chip family is characterized by following properties:
>> * 2 separate DPLL units (channels)
>> * 5 synthesizers
>> * 10 input pins (references)
>> * 10 outputs
>> * 20 output pins (output pin pair shares one output)
>> * Each reference and output can act in differential or single-ended
>>    mode (reference or output in differential mode consumes 2 pins)
>> * Each output is connected to one of the synthesizers
>> * Each synthesizer is driven by one of the DPLL unit
> .
> The comments below are applicable to entire series, take your time and fix
> *all* stylic and header issues before sending v2.
> 
> ...
> 
> + array_size.h
> + bits.h
> 
> + device/devres.h
> 
>> +#include <linux/module.h>
> 
> This file uses *much* amore than that.
> 
> + regmap.h
> 
> 
>> +#include "zl3073x.h"
> 
> ...
> 

Will fix in the next series.

>> +/*
>> + * Regmap ranges
>> + */
>> +#define ZL3073x_PAGE_SIZE	128
>> +#define ZL3073x_NUM_PAGES	16
>> +#define ZL3073x_PAGE_SEL	0x7F
>> +
>> +static const struct regmap_range_cfg zl3073x_regmap_ranges[] = {
>> +	{
>> +		.range_min	= 0,
> 
> Are you sure you get the idea of virtual address pages here?

What is wrong here?

I have a device that uses 7-bit addresses and have 16 register pages.
Each pages is from 0x00-0x7f and register 0x7f is used as page selector 
where bits 0-3 select the page.

>> +		.range_max	= ZL3073x_NUM_PAGES * ZL3073x_PAGE_SIZE,
>> +		.selector_reg	= ZL3073x_PAGE_SEL,
>> +		.selector_mask	= GENMASK(3, 0),
>> +		.selector_shift	= 0,
>> +		.window_start	= 0,
>> +		.window_len	= ZL3073x_PAGE_SIZE,
>> +	},
>> +};
> 
> ...
> 
>> +struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev)
>> +{
>> +	struct zl3073x_dev *zldev;
>> +
>> +	return devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
>> +
>> +int zl3073x_dev_init(struct zl3073x_dev *zldev)
>> +{
>> +	devm_mutex_init(zldev->dev, &zldev->lock);
> 
> Missing check.

Will fix.

>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init, "ZL3073X");
>> +
>> +void zl3073x_dev_exit(struct zl3073x_dev *zldev)
>> +{
>> +}
>> +EXPORT_SYMBOL_NS_GPL(zl3073x_dev_exit, "ZL3073X");
> 
> What's the point in these stubs?

This function is used and filled later. I will drop it here and 
introduce when it will be necessary.

>> +#include <linux/i2c.h>
> 
>> +#include <linux/kernel.h>
> 
> No usual driver should include kernel.h, please follow IWYU principle.

Will follow IWYU in v2.

>> +#include <linux/module.h>
> 
> Again, this is just a random list of headers, see above and follow the IWYU
> principle.

Ditto.

>> +#include "zl3073x.h"
> 
> ...
> 
>> +static const struct i2c_device_id zl3073x_i2c_id[] = {
>> +	{ "zl3073x-i2c", },
> 
> Redundant inner comma.

Ack

>> +	{ /* sentinel */ },
> 
> No comma for the sentinel.
> 
>> +};

Ack

>> +static const struct of_device_id zl3073x_i2c_of_match[] = {
>> +	{ .compatible = "microchip,zl3073x-i2c" },
>> +	{ /* sentinel */ },

Ack

>> +};
> 
>> +static int zl3073x_i2c_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	const struct i2c_device_id *id;
>> +	struct zl3073x_dev *zldev;
> 
>> +	int rc = 0;
> 
> Useless assignment.

Sorry for that, it was originally necessary.
Will drop.

>> +	zldev = zl3073x_dev_alloc(dev);
>> +	if (!zldev)
>> +		return -ENOMEM;
>> +
>> +	id = i2c_client_get_device_id(client);
>> +	zldev->dev = dev;
>> +
>> +	zldev->regmap = devm_regmap_init_i2c(client,
>> +					     zl3073x_get_regmap_config());
> 
> It's perfectly a single line.

I tried to follow strictly 80 chars/line. Will fix.

>> +	if (IS_ERR(zldev->regmap)) {
>> +		rc = PTR_ERR(zldev->regmap);
>> +		dev_err(dev, "Failed to allocate register map: %d\n", rc);
>> +		return rc;
> 
> 		return dev_err_probe(...);

Will change.

>> +	}
>> +
>> +	i2c_set_clientdata(client, zldev);
>> +
>> +	return zl3073x_dev_init(zldev);
>> +}
> 
> ...
> 
>> +static void zl3073x_i2c_remove(struct i2c_client *client)
>> +{
> 
>> +	struct zl3073x_dev *zldev;
>> +
>> +	zldev = i2c_get_clientdata(client);
> 
> Just make it one line definition + assignment.

Ack

>> +	zl3073x_dev_exit(zldev);
> 
> This is a red flag and because you haven't properly named the calls (i.e. devm
> to show that they are only for probe stage and use managed resources) this is
> not easy to catch.

Will rename zl3073x_dev_alloc() to zl3073x_devm_alloc() to indicate that 
devres is used... Probably will drop zl3073x_dev_exit() entirely and 
take care of devlink unregistration by devres way.

>> +}
>> +
>> +static struct i2c_driver zl3073x_i2c_driver = {
>> +	.driver = {
>> +		.name = "zl3073x-i2c",
>> +		.of_match_table = of_match_ptr(zl3073x_i2c_of_match),
> 
> Please, never use of_match_ptr() or ACPI_PTR() in a new code.

Ack

>> +	},
>> +	.probe = zl3073x_i2c_probe,
>> +	.remove = zl3073x_i2c_remove,
>> +	.id_table = zl3073x_i2c_id,
>> +};
> 
>> +
> 
> Redundant blank line.
> 
>> +module_i2c_driver(zl3073x_i2c_driver);
> 
> ...
> 
>> +#include <linux/kernel.h>
> 
> Just no. You should know what you are doing in the driver.

Will fix.

>> +#include <linux/module.h>
> 
>> +#include <linux/of.h>

Ack

>> +#include <linux/spi/spi.h>
>> +#include "zl3073x.h"
> 
> ...
> 
>> +static const struct spi_device_id zl3073x_spi_id[] = {
>> +	{ "zl3073x-spi", },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
>> +
>> +static const struct of_device_id zl3073x_spi_of_match[] = {
>> +	{ .compatible = "microchip,zl3073x-spi" },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, zl3073x_spi_of_match);
> 
> Move the above closer to its user.

Ack

>> +static int zl3073x_spi_probe(struct spi_device *spidev)
> 
> Usual name is spi for the above, it's shorter and allows to tidy up the code.
> 
> And below same comments as for i2c part of the driver.

OK, will fix.

>> +#ifndef __ZL3073X_CORE_H
>> +#define __ZL3073X_CORE_H
> 
>> +#include <linux/mfd/zl3073x.h>
> 
> How is it used here, please?

Will change to forward declaration.

>> +struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev);
>> +int zl3073x_dev_init(struct zl3073x_dev *zldev);
>> +void zl3073x_dev_exit(struct zl3073x_dev *zldev);
>> +const struct regmap_config *zl3073x_get_regmap_config(void);
>> +
>> +#endif /* __ZL3073X_CORE_H */
> 
> ...
> 
>> +#ifndef __LINUX_MFD_ZL3073X_H
>> +#define __LINUX_MFD_ZL3073X_H
> 
>> +#include <linux/device.h>
>> +#include <linux/regmap.h>
> 
> Ditto. Two unused headers and one which must be included is missed.

The same, forward declaration and inclusion of <linux/mutex.h>

>> +struct zl3073x_dev {
>> +	struct device		*dev;
>> +	struct regmap		*regmap;
>> +	struct mutex		lock;
>> +};

Thank you Andy for the review.

I.

