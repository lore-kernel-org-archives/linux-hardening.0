Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F1328B71;
	Tue, 19 May 2026 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182077; cv=none; b=TDvEs4I+J2SR4LRYw3iUhbTfRxewedKVhCXpLFMH731wqcdfvhqLgC2n8cuH4sVQyK/UiprDTfBJ3bbEb9XpRlKrnIo/9+0nlVEjWF74RlUn09gmaOe5dJxr3Od9lpDOk7BrpIcm1Ur0Pj9vDUCRtHcIQ9Hwh7wx6Tuz3jwpx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182077; c=relaxed/simple;
	bh=Mqca+sIczHcRH9cxA65CfR72LWGCQu0BnAbz5JAdmic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX63rjDIm8F8RrRLbQ8cJjbd4CziF/sVpSzuxD+lBTdB2qd5Opcp+y+RJ5Qqs+L+xMaObaVsfaOnDg7lDYx7sbWJHg52ixzQL6gB7Bg9TGmem3s/w4vbiawJaD/bi26/BaxLDdwWtFR6456zwANS+EknBfvbXIKeh5PKEDsLY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFdOrz+G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MoJiPS4U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFdOrz+G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MoJiPS4U"
Date: Tue, 19 May 2026 11:14:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779182074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JTiRIOvyrnbBe56DNVUfZzfjuOs0jdrr1NH4cMoTGyM=;
	b=uFdOrz+GgwEtLYeIM+wqq0pdhsZG3lN7XAJlA1KS9vnj3pKHHX/LTAMFavpc07ShXcv8KX
	MV5xgkv/AP7PGQhddTKgPpCzVhUXR2ybLV39NeptPLv6/+dhQoao7uDMC81nnak1YNK9gu
	KT39jzZNwp9wj8D2+FJklrfjbe1lSdrLHO5r4Tfdf3dVzaez6NK7qr060KpxISVkItW/AF
	3TdgrOcRA8EniPuISHgOhqtD9aX0zGbVzbWMgWcCzEyvJLFpbMJwL64q5Ta5zvbZNrT6Dp
	yJHq+lzQNtggOng2EjWQKgN30TrV9DzpceLFrfA7GUcEc3zeQqMbb23pfjU56Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779182074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JTiRIOvyrnbBe56DNVUfZzfjuOs0jdrr1NH4cMoTGyM=;
	b=MoJiPS4UpagsPqF4WAMNPHpPn5nNqYyVRaH9bgZ10wI5dxKm1fB0sX8i14FUGA8ZFZQsCk
	VqQlNxT4zisXVhAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 2/5] nvmem: Add the Raspberry Pi OTP driver
Message-ID: <20260519110041-2d8d92c2-d265-43d1-848f-bf9231a106c8@linutronix.de>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
 <20260508-rpi-otp-driver-v4-2-cf8d725d8821@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-rpi-otp-driver-v4-2-cf8d725d8821@linutronix.de>

On Fri, May 08, 2026 at 04:42:45PM +0200, Gregor Herburger wrote:
> Raspberry Pis have OTP registers which can be accessed through the
> videocore firmware. Add a nvmem driver to support these OTP registers.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> ---
>  drivers/nvmem/Kconfig                      |  10 +++
>  drivers/nvmem/Makefile                     |   1 +
>  drivers/nvmem/raspberrypi-otp.c            | 130 +++++++++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |   9 ++
>  4 files changed, 150 insertions(+)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 74ddbd0f79b0..aac31f43385e 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -483,4 +483,14 @@ config NVMEM_QORIQ_EFUSE
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem_qoriq_efuse.
>  
> +config NVMEM_RASPBERRYPI_OTP
> +	tristate "Raspberry Pi OTP support"
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)

The '&& !RASPBERRYPI_FIRMWARE' clause looks weird, is it really necessary?

> +	help
> +	  This driver provides access to the Raspberry Pi OTP memory via the
> +	  nvmem subsystem. The driver supports the customer OTP as well as the
> +	  device specific private key OTP (BCM2712 only).
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called raspberrypi-otp.

While we are here: The empty line here is now missing.

>  endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 7252b8ec88d4..8ca2095e068f 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -95,3 +95,4 @@ obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
>  nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
>  obj-$(CONFIG_NVMEM_QORIQ_EFUSE)		+= nvmem-qoriq-efuse.o
>  nvmem-qoriq-efuse-y			:= qoriq-efuse.o
> +obj-$(CONFIG_NVMEM_RASPBERRYPI_OTP)	+= raspberrypi-otp.o
> diff --git a/drivers/nvmem/raspberrypi-otp.c b/drivers/nvmem/raspberrypi-otp.c
> new file mode 100644
> index 000000000000..393640cb9e32
> --- /dev/null
> +++ b/drivers/nvmem/raspberrypi-otp.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/overflow.h>

This looks unused.

Instead maybe add linux/types.h, linux/align.h

> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +struct rpi_otp_priv {
> +	struct rpi_firmware *fw;
> +	struct device *dev;

This looks unused.

> +	u32 read_tag;
> +	u32 write_tag;
> +};
> +
> +struct rpi_otp_header {
> +	__le32 start;
> +	__le32 count;
> +	__le32 data[] __counted_by_le(count);
> +};
> +
> +static int rpi_otp_read(void *context, unsigned int offset, void *buf, size_t bytes)
> +{
> +	struct rpi_otp_priv *priv = context;
> +	struct rpi_otp_header *fwbuf;
> +	u32 count;
> +	int ret;
> +
> +	if (!IS_ALIGNED(offset, 4) || !IS_ALIGNED(bytes, 4))
> +		return -EINVAL;

Isn't this already enforced by the nvmem core?

(...)

> +static int rpi_otp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct nvmem_device *nvmem;
> +	struct rpi_otp_priv *priv;
> +	const struct rpi_otp_driver_data *data;
> +	struct nvmem_config config = {
> +		.read_only = false,
> +		.word_size = 4,
> +		.stride = 4,
> +		.reg_read = rpi_otp_read,
> +		.reg_write = rpi_otp_write,
> +		.id = NVMEM_DEVID_NONE,
> +	};
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	data = dev_get_platdata(dev);
> +	if (!data)
> +		return -ENODEV;

I would do this before the devm_kzalloc().
> +
> +	priv->fw = dev_get_drvdata(dev->parent);
> +	priv->dev = dev;
> +	priv->read_tag = data->read_tag;
> +	priv->write_tag = data->write_tag;
> +	config.dev = dev;
> +	config.priv = priv;
> +	config.name = data->name;
> +	config.size = data->size;
> +
> +	nvmem = devm_nvmem_register(dev, &config);
> +	if (IS_ERR(nvmem))
> +		return dev_err_probe(dev, PTR_ERR(nvmem), "error registering nvmem config\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver raspberry_otp_driver = {
> +	.probe	= rpi_otp_probe,
> +	.driver = {
> +		.name	= "raspberrypi-otp",
> +	},
> +};
> +module_platform_driver(raspberry_otp_driver);
> +
> +MODULE_AUTHOR("Gregor Herburger <gregor.herburger@linutronix.de>");
> +MODULE_DESCRIPTION("Raspberry Pi OTP driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:raspberrypi-otp");

Instead of the manual module alias here and the implicit matching of the
platform driver this should use an explicit matching table:

static const struct platform_device_id foo_id[] = {
	{ "raspberrypi-otp" },
	{}
};
MODULE_DEVICE_TABLE(platform, foo_id);

static struct platform_driver raspberry_otp_driver = {
	...
	.id_table = foo_id,
};
module_platform_driver(raspberry_otp_driver);

(...)
