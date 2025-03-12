Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31F19882B
	for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771802; cv=none; b=rkVhEzb0SOGRb0olrf2LY+ZhJneWRTHwZtDd6RO2sgKBiGSKqd58/yjCmg334mQt8EoGgbxOV/kB2g74s2j/9d+dCEw+PcF67mykGu8WANXgJbqYfQfdl/AjhJZsqXKEHB+hWvqMOLi/W4UXUxn/pW9QITW3OfMw3R3x5jrls08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771802; c=relaxed/simple;
	bh=tSws0uqI2SznFPegKFo36/x1ajpurzkT5thUWoEOHMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahaSwJBp7w7NA02HB62JC5vsViJDkr3lRC6FVMtjbCn1mwNHmLgUFOoGzROx+IHF0bYdwwm/Ed/i0KQCmo7MTUU7TZ/z8ytvpsVaCNTQxvQ0sRNwpJuhnNCrIIpQblIBRhl2a7xXJoyEiHKTr8a8RIrBp2UX76EHDoGMvXMy5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Byu/3/6p; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Byu/3/6p"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39149bccb69so2790739f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741771798; x=1742376598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyuIF7ilKCTNWqhGZXvW+3VZuEvP8t1bh6inYFcuoX8=;
        b=Byu/3/6puaWMl+rsnGxPWl8Ed0suD84JKMCKDYYB//q8FhZaKMDm2gPh5VuOMicUcM
         ef9Y7YyDoS5bdOv+a4aAga9fqCz+ko9vkQ41RsI4J5lKPxgnzudl/2uRHX9RqYLYRw2Q
         Sn30nGOOzfdGcrfpog3hu45M2G+28I55SwwLD53paK8ODj8wKbpspWbbYRii61WdIAHx
         fv4RTUh1GzTs2bmNcg6djoGSLsMLZCYViCK7UZ/u7qzRgLfzzhqevI89FrFJcVGffpng
         9fF+iiXXiQke7rOCbmU86eVmM/AebcxBv0l1Xp4DeBs1vzz7Ef5/iUIYSzOgVNaxLnUy
         loMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741771798; x=1742376598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyuIF7ilKCTNWqhGZXvW+3VZuEvP8t1bh6inYFcuoX8=;
        b=mGHfd1MdYp5jurwGbCminYvRopjRX//Uk9uxqRjWDEIbkLFbt7xy1P2WUAyqcqQN/I
         ZQyTlW/XwU+ukkAng+uPHBdohCni513u0PvgOgeFsSke8fRWg2fy4DWEisuOOUjokgY8
         4deVFb6i3AZim7QqVq9qapwrqSL1x8Crd+GxKT4gVJpz5mi0BZrEFs2jcnyVjWEfL6gR
         nGjOkv7aYmbuj7+wIwfwtt34FGudICPv41PUP0emiaWVLsOr1EOQZ5k+NBTJoL6IRusB
         n01ubIIy4XI4oGBVsjmOu/al619epXvNOg3P5rhckaJ4cF03cR3CHsWtCWwgv6pVPWBp
         nsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQpeTlZX98df36DDb/hWnHwvPy3zjrgMs38fnmqDDhpjZqDnTo71oyW6cDTVFjzy8zD9wwXUo/8gB0+rOMNSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykndwP9/Uv4jM3nVp5O/SbA7LeqvxWM8S/MPysIFFXg0FRjRrn
	UGlJOt4L0HTmcXvz/qQqmh110TdYNKpwaeGCtaLDBVoxRWaN0jVi7SLZuzqiqf4=
X-Gm-Gg: ASbGncvEFcYnVt0tREJQ3l80SjCywPd1qRy0ZwApFHM7LqIFuiRraui65jxVeNFpjrI
	/VezmBXcfeNFjBnq8/dD8dBXJs2F49hJHkMOS5ciTKOKtxp9b7H8w/zjDxRKGzGf3Z1l2DViyDT
	wpG3wOeu0ylHUoYU/rsDaVnmwGfFqV/pZVYJO5GAIHfXP6Exg7V1mA88dr1MfNs7Z5vx/IN151P
	6KBoCMswtKJb86Iik0/Y01FxF2QXzUiMbFnQUWObq9S6ts6LRCkPhXqUk0sh+OnIuMZlJXgekPm
	B/kLSWt2u3bWm8zaWjLaP9RyYi05lwbL8YVPpFb6CzWlz3imT/GRo7WN4Np2uzM=
X-Google-Smtp-Source: AGHT+IE2F4vkuyc8O9MHcNrwAiEnvfVrJulNHKbhedDrmtfP3O4s4EHa1Ex0DhHtMpGa2iqxYWd2cg==
X-Received: by 2002:a05:6000:1f8c:b0:391:4835:d888 with SMTP id ffacd0b85a97d-3926bfe0777mr7636212f8f.42.1741771797862;
        Wed, 12 Mar 2025 02:29:57 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdff57sm20942923f8f.37.2025.03.12.02.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 02:29:57 -0700 (PDT)
Message-ID: <f6cc4e64-fc92-40c7-ad5b-90f6da86b811@linaro.org>
Date: Wed, 12 Mar 2025 09:29:55 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] nvmem: max77759: add Maxim MAX77759 NVMEM driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
 <20250224-max77759-mfd-v1-6-2bff36f9d055@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20250224-max77759-mfd-v1-6-2bff36f9d055@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/02/2025 10:28, André Draszik wrote:
> The Maxim MAX77759 is a companion Power Management IC for USB Type-C
> applications with Battery Charger, Fuel Gauge, temperature sensors, USB
> Type-C Port Controller (TCPC), NVMEM, and additional GPIO interfaces.
> 
> This driver exposes the non volatile memory using the platform device
> registered by the core MFD driver.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   MAINTAINERS                    |   1 +
>   drivers/nvmem/Kconfig          |  12 ++++
>   drivers/nvmem/Makefile         |   2 +
>   drivers/nvmem/max77759-nvmem.c | 156 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 171 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d119ed1ff279..bbc92dee7af4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14329,6 +14329,7 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/*/maxim,max77759*.yaml
>   F:	drivers/gpio/gpio-max77759.c
>   F:	drivers/mfd/max77759.c
> +F:	drivers/nvmem/max77759-nvmem.c
>   F:	include/linux/mfd/max77759.h
>   
>   MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 8671b7c974b9..3de07ef52490 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -154,6 +154,18 @@ config NVMEM_LPC18XX_OTP
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called nvmem_lpc18xx_otp.
>   
> +config NVMEM_MAX77759
> +	tristate "Maxim Integrated MAX77759 NVMEM Support"
> +	depends on MFD_MAX77759
> +	default MFD_MAX77759
> +	help
> +	  Say Y here to include support for the user-accessible storage found
> +	  in Maxim Integrated MAX77759 PMICs. This IC provides space for 30
> +	  bytes of storage.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-max77759.
> +
>   config NVMEM_MESON_EFUSE
>   	tristate "Amlogic Meson GX eFuse Support"
>   	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 5b77bbb6488b..a9d03cfbbd27 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -34,6 +34,8 @@ obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
>   nvmem_lpc18xx_eeprom-y			:= lpc18xx_eeprom.o
>   obj-$(CONFIG_NVMEM_LPC18XX_OTP)		+= nvmem_lpc18xx_otp.o
>   nvmem_lpc18xx_otp-y			:= lpc18xx_otp.o
> +obj-$(CONFIG_NVMEM_MAX77759)		+= nvmem-max77759.o
> +nvmem-max77759-y			:= max77759-nvmem.o
>   obj-$(CONFIG_NVMEM_MESON_EFUSE)		+= nvmem_meson_efuse.o
>   nvmem_meson_efuse-y			:= meson-efuse.o
>   obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
> diff --git a/drivers/nvmem/max77759-nvmem.c b/drivers/nvmem/max77759-nvmem.c
> new file mode 100644
> index 000000000000..4c455b242542
> --- /dev/null
> +++ b/drivers/nvmem/max77759-nvmem.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright 2020 Google Inc
> +// Copyright 2025 Linaro Ltd.
> +//
> +// NVMEM driver for Maxim MAX77759
> +
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/device/driver.h>
> +#include <linux/err.h>
> +#include <linux/mfd/max77759.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +
> +#define MAX77759_NVMEM_OPCODE_HEADER_LEN 3
> +/*
> + * NVMEM commands have a three byte header (which becomes part of the command),
> + * so we need to subtract that.
> + */
> +#define MAX77759_NVMEM_SIZE (MAX77759_MAXQ_OPCODE_MAXLENGTH \
> +			     - MAX77759_NVMEM_OPCODE_HEADER_LEN)
> +
> +struct max77759_nvmem {
> +	struct device *dev;
> +	struct max77759_mfd *max77759_mfd;
> +};
> +
> +static bool max77759_nvmem_is_valid(unsigned int offset, size_t bytes)
> +{
> +	return (offset + bytes - 1 <= MAX77759_NVMEM_SIZE);
> +}
> +
> +static int max77759_nvmem_reg_read(void *priv, unsigned int offset,
> +				   void *val, size_t bytes)
> +{
> +	struct max77759_nvmem *nvmem = priv;
> +	DEFINE_FLEX(struct max77759_maxq_command, cmd, cmd, length,
> +		    MAX77759_NVMEM_OPCODE_HEADER_LEN);
> +	DEFINE_FLEX(struct max77759_maxq_response, rsp, rsp, length,
> +		    MAX77759_MAXQ_OPCODE_MAXLENGTH);
> +	int ret;
> +
> +	if (!max77759_nvmem_is_valid(offset, bytes)) {
> +		dev_err(nvmem->dev, "outside NVMEM area: %u / %zu\n",
> +			offset, bytes);
> +		return -EINVAL;
> +	}
> +
> +	cmd->cmd[0] = MAX77759_MAXQ_OPCODE_USER_SPACE_READ;
> +	cmd->cmd[1] = offset;
> +	cmd->cmd[2] = bytes;
> +	rsp->length = bytes + MAX77759_NVMEM_OPCODE_HEADER_LEN;
> +
> +	ret = max77759_maxq_command(nvmem->max77759_mfd, cmd, rsp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (memcmp(cmd->cmd, rsp->rsp, MAX77759_NVMEM_OPCODE_HEADER_LEN)) {
> +		dev_warn(nvmem->dev, "protocol error (read)\n");
> +		return -EIO;
> +	}
> +
> +	memcpy(val, &rsp->rsp[MAX77759_NVMEM_OPCODE_HEADER_LEN], bytes);
> +
> +	return 0;
> +}
> +
> +static int max77759_nvmem_reg_write(void *priv, unsigned int offset,
> +				    void *val, size_t bytes)
> +{
> +	struct max77759_nvmem *nvmem = priv;
> +	DEFINE_FLEX(struct max77759_maxq_command, cmd, cmd, length,
> +		    MAX77759_MAXQ_OPCODE_MAXLENGTH);
> +	DEFINE_FLEX(struct max77759_maxq_response, rsp, rsp, length,
> +		    MAX77759_MAXQ_OPCODE_MAXLENGTH);
> +	int ret;
> +
> +	if (!max77759_nvmem_is_valid(offset, bytes)) {
> +		dev_err(nvmem->dev, "outside NVMEM area: %u / %zu\n",
> +			offset, bytes);
> +		return -EINVAL;
> +	}
> +
> +	cmd->cmd[0] = MAX77759_MAXQ_OPCODE_USER_SPACE_WRITE;
> +	cmd->cmd[1] = offset;
> +	cmd->cmd[2] = bytes;
> +	memcpy(&cmd->cmd[MAX77759_NVMEM_OPCODE_HEADER_LEN], val, bytes);
> +	cmd->length = bytes + MAX77759_NVMEM_OPCODE_HEADER_LEN;
> +	rsp->length = cmd->length;
> +
> +	ret = max77759_maxq_command(nvmem->max77759_mfd, cmd, rsp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (memcmp(cmd->cmd, rsp->rsp, cmd->length)) {
> +		dev_warn(nvmem->dev, "protocol error (write)\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77759_nvmem_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config config = {
> +		.dev = &pdev->dev,
> +		.name = dev_name(&pdev->dev),
> +		.id = NVMEM_DEVID_NONE,
> +		.type = NVMEM_TYPE_EEPROM,
> +		.ignore_wp = true,
> +		.size = MAX77759_NVMEM_SIZE,
> +		.word_size = sizeof(u8),
> +		.stride = sizeof(u8),
> +		.reg_read = max77759_nvmem_reg_read,
> +		.reg_write = max77759_nvmem_reg_write,
> +	};
> +	struct max77759_nvmem *nvmem;
> +
> +	nvmem = devm_kzalloc(&pdev->dev, sizeof(*nvmem), GFP_KERNEL);
> +	if (!nvmem)
> +		return -ENOMEM;
> +
> +	nvmem->dev = &pdev->dev;
> +	nvmem->max77759_mfd = dev_get_drvdata(pdev->dev.parent);
> +
> +	config.priv = nvmem;
> +
> +	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
> +}
> +
> +static const struct of_device_id max77759_nvmem_of_id[] = {
> +	{ .compatible = "maxim,max77759-nvmem", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, max77759_nvmem_of_id);
> +
> +static struct platform_driver max77759_nvmem_driver = {
> +	.driver = {
> +		.name = "max77759-nvmem",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.of_match_table = max77759_nvmem_of_id,
> +	},
> +	.probe = max77759_nvmem_probe,
> +};
> +
> +module_platform_driver(max77759_nvmem_driver);
> +
> +MODULE_AUTHOR("André Draszik <andre.draszik@linaro.org>");
> +MODULE_DESCRIPTION("NVMEM driver for Maxim MAX77759");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:max77759-nvmem");
> 
