Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3045540AD
	for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084039; cv=none; b=qDYfbWTkCdSw5KBN0piMWFK5xWglxEChlA0QbNyyRg3nSkYwCIi9y9pa5utmS7kwFShXQ2FFXqf1czqVH5AD1YVglGJ224QjYyN3j/W39Xzih+i4ZyX83UgGX63YariwlTzUYo3qYS0OObsSA0YIRy5J1SnYx/QO1WyWjiKR/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084039; c=relaxed/simple;
	bh=WSdfeY/0K159TMJyPSbYWg5pgAkoB6b1mxTxk/rn788=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAEuvEfkCKgKni52aBGFnHc7b4idiSghjOXgSXUW5AfxV2qM0p0Awj+4x4toF86RlUTXdnoKI1AtWgEDbuGOD1kJT5pE+OUBojrf6mfq+6Jo1Kw3f5Mkq8SMdTghrN5yMXl9KjITCiXQA39Zx0qbsEFgnp/s0IIaltreRYhRJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Z0njjWgk; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Z0njjWgk"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a2015bbfceso6638221fa.1
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790084026; x=1790688826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QydC7bgWG0EuejZPwcV3a+DqQPYaemecyt7vWNS1w14=;
        b=Z0njjWgkxgYupjm7pTX6smX5zlEkJwBSvtmCHtMLVqa0ho0MyL9pbnU6MaZSUFQPfa
         8HnKvZdrJ2dobHMZH4afa9CW5lNN+aVQytgUlOGIHwIHP+6g/cheR8/ZJtv4dB79uos4
         0vposbqNRJ2MMvUGUXXDy74l9EEVfsmJ0bT08P1UTWiUDIcNZucuI3KMZm3KIRb4Tqt3
         yN4H3lzYOtcW4J1qAFwDwmZTdO5w29ZBKCxpHfK/SiVFqDzPQEyDhzMg9J0TJiX4jurq
         xClotg1HNK7qrm8669zzBtdVoeHQVThpFTUWqvRN8w8qPzyxdNYI1xHuir26qacQdfre
         /Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084026; x=1790688826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QydC7bgWG0EuejZPwcV3a+DqQPYaemecyt7vWNS1w14=;
        b=eELPvRATQPY6MLbmlzeqD76mZEjZ076EI8qLOlZS+5YnhjzJyvHdi9tJ0K3FT1np+5
         lvWdgbswLxxJjclPCnpVTi9lmul/b+Hpayzobo/aLsLLPP+Ym4V3cGbbyAkLSBS/L0Sd
         8zFBp/ITBIZ00qhfCow5XZ6nDzO3amyf2nf6wZhhnVTDLoKB9sgVrsYqq/NGfhpKuU9M
         qB+tn/zonOML6dvbgFyRkQZAzTaxm4qjtcvRvYyKt1492T4ft1WAB74D1ao3alyb2so3
         ZQA1pysG+mbaMNc81fj47YlsFUcKBjAQVNOOK/uk9SP33qOvnlxflu2YOAbSifQ/oFNj
         iV4w==
X-Forwarded-Encrypted: i=1; AKwUvBz3KHu3jM2Okk4FM+fZTP7kRhFuOIal9Z6o04UXNusKl/xcw1sS6GioxrCm4B08fE3NGnUf5m61LoPOHBaVN3I=@vger.kernel.org
X-Gm-Message-State: AFuF++n7t0mT4NRqCsWi0rOLYZUmcBzamwXCwd11RpHT4GA9NShPj46N
	XB2eMdRXgBlCYLB3eS6UZunSzsbrEoZv+yDrCkfaRxhMZJrL5n+jZ/+CwFiMhbLuzoA=
X-Gm-Gg: AYBFou3Ux3GrXiocXgEyojOT5hnPu3Qw4P5jdgIyi3v6EBG7iwryxnLZ+A7DRvWXTnc
	gftWNIKTjMR5b/kEevLjb7jVeTLT8zFzUmDvPBVmHm/Cxjtgb5/7odGYnF31DCN+AqUj5WzD5lF
	FGkh61oatFVU1oxdtBeu6wETUxmbpL/qhS3fLR/+YrlqFnPvNjcTiGWuyiwpBKR+qnlcZw5lRtI
	OFewjfDINWADvFI+5A7Ijqu/03mrNgcjaH8EaTRniNHGRJkpikBwWXwGmVn0q128Y8E9f3w69Xq
	WqrixcQEI4Y5x6SfFS4Ed+++pmPN0cwtd7c51Qcf/F7gnyeuTqE7RIwiFg/1Bd31is+UQJVHTPc
	mTQXgSZqRkuCpSxYsdCz6ng69NkWqJO4LRxTNnr4yxUbQe570K2GVv9JEiah6Lk1AUilkgafdOe
	aP0Tdp2Z1pDM1MEBIhJs3ikqtUOWkRykmBmHdtpdKgsNhwsNTDLXczyKNz1BE39vA7+g8TQVU=
X-Received: by 2002:a2e:bcc3:0:b0:3a5:d0c6:46c4 with SMTP id 38308e7fff4ca-3a624d70581mr7729801fa.15.1790084024945;
        Tue, 22 Sep 2026 06:33:44 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a627d82b71sm5924741fa.34.2026.09.22.06.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:33:44 -0700 (PDT)
Message-ID: <0785235b-de06-44d4-9068-ec706eeba848@riscstar.com>
Date: Tue, 22 Sep 2026 08:33:37 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: toshiba: introduce a TC9564 SoC clock and reset
 driver
To: Brian Masney <bmasney@redhat.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, p.zabel@pengutronix.de,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-4-elder@riscstar.com> <arG238GS8bMB6DkW@redhat.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <arG238GS8bMB6DkW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 5:59 PM, Brian Masney wrote:
> Hi Alex,
> 
> On Fri, Sep 18, 2026 at 11:52:32AM -0500, Alex Elder wrote:
>> Define a new platform driver that manages clock and reset signals
>> within the TC9564 SoC.  There are 21 clocks, which can only be
>> enabled and disabled, as well as 13 reset signals.
>>
>> Two registers manage the state of the clocks and two others manage
>> the state of the resets.  The registers are accessed via a regmap
>> supplied by a system controller, which coordinates access to a
>> region of memory that will be shared with another driver.
>>
>> Access to the memory region is provided via a BAR on a PCIe endpoint
>> function embedded in the TC9564 SoC.  For that reason, neither the
>> PCIe clock nor PCIe reset can be manipulated by this driver (they
>> are assumed always on and deasserted, respectively).
>>
>> Similarly, control is not available for the I2C clock and reset,
>> because the PCIe subsystem on the TC9564 relies on I2C
>>
>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   MAINTAINERS              |   1 +
>>   drivers/clk/Kconfig      |  11 ++
>>   drivers/clk/Makefile     |   1 +
>>   drivers/clk/clk-tc9564.c | 366 +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 379 insertions(+)
>>   create mode 100644 drivers/clk/clk-tc9564.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 66d0e7e65adcb..39346a5cd9a7f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -27675,6 +27675,7 @@ M:	Alex Elder <elder@kernel.org>
>>   M:	Daniel Thompson <danielt@kernel.org>
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
>> +F:	drivers/clk/clk-tc9564.c
>>   F:	include/dt-bindings/clock/toshiba,tc9564.h
>>   
>>   TOSHIBA TC9564 PCI DRIVER
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index f9592fd9ec2bb..50efa10d48450 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -292,6 +292,17 @@ config COMMON_CLK_S2MPS11
>>   	  clock. These multi-function devices have two (S2MPS14) or three
>>   	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
>>   
>> +config COMMON_CLK_TC9564
>> +	tristate "Toshiba TC9564 clock support"
>> +	depends on TC9564_PCI
> 
> select RESET_CONTROLLER

Thank you.  The reset and clock drivers were previously separate
and the reset only became available if RESET_CONTROLLER was enabled.
Combining them means I need this.  I will add it.

I also need to select MFD_SYSCON to get syscon_node_to_regmap()
(or perhaps something similar, depending on the answers to my
questions about the proper way to define the syscon).
> 
>> +	default m
> 
> default n

This depends on TC9564_PCI, and if TC9564_PCI is enabled I would
like this to (automatically) be available (at least as a module).

Why do you recommend "n"?

>> +	help
>> +	  This enables support for the clock and reset controller embedded
>> +	  in the Toshiba TC9564 (and Qualcomm QPS615) SoC.  The state of
>> +	  clock and reset lines is controlled by MMIO to a region managed
>> +	  by a system controller; this ensures access to the region is
>> +	  coordinated between this and other drivers.
> 
> Rather than 'other drivers', outline specifically which other drivers.

I was intentionally vague at this point because the one other driver
has not yet gone out for upstream review for this iteration of the
code.  But I do agree with you, so I'll change this to say:

    ... between this and the XGMAC (stmmac) driver.

Then it will be correct without modification once that driver goes
out for review.  Is that better, or do you suggest something else?

>> +
>>   config CLK_TWL
>>   	tristate "Clock driver for the TWL PMIC family"
>>   	depends on TWL4030_CORE
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index b18af485d7f03..a98ea8ff92066 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -110,6 +110,7 @@ obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
>>   obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
>>   obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
>>   obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
>> +obj-$(CONFIG_COMMON_CLK_TC9564)		+= clk-tc9564.o
>>   obj-$(CONFIG_COMMON_CLK_TPS68470)      += clk-tps68470.o
>>   obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
>>   obj-$(CONFIG_CLK_TWL)			+= clk-twl.o
>> diff --git a/drivers/clk/clk-tc9564.c b/drivers/clk/clk-tc9564.c
>> new file mode 100644
>> index 0000000000000..4f900bc8994a7
>> --- /dev/null
>> +++ b/drivers/clk/clk-tc9564.c
>> @@ -0,0 +1,366 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mod_devicetable.h>
> 
> Uwe already pointed out removing this.

Yes, done.

> 
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#include <dt-bindings/clock/toshiba,tc9564.h>
>> +
>> +#define CLK_CTRL0_OFFSET	0x1004
>> +#define RST_CTRL0_OFFSET	0x1008
>> +#define CLK_CTRL1_OFFSET	0x100c
>> +#define RST_CTRL1_OFFSET	0x1010
>> +
>> +struct tc9564_clock_init {
>> +	const char *name;	/* NULL means unused entry */
>> +	u32 offset;
>> +	u32 mask;
>> +};
>> +
>> +struct tc9564_clock {
>> +	struct clk_hw hw;
>> +	u32 which;
>> +	u32 offset;		/* CLK_CTRL0_OFFSET or CLK_CTRL1_OFFSET */
>> +	u32 mask;		/* Zero means undefined clock */
>> +};
>> +
>> +struct tc9564_reset {
>> +	u32 offset;		/* RST_CTRL0_OFFSET or RST_CTRL1_OFFSET */
>> +	u32 mask;		/* Zero means undefined reset */
>> +};
>> +
>> +struct tc9564_clocks {
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	struct reset_controller_dev rcdev;
>> +	size_t clock_count;
>> +	struct tc9564_clock clocks[] __counted_by(clock_count);
>> +};
>> +
>> +#define TC9564_CLOCK_INIT0(_name, _bit)	__TC9564_CLOCK_INIT(_name, 0, _bit)
>> +#define TC9564_CLOCK_INIT1(_name, _bit)	__TC9564_CLOCK_INIT(_name, 1, _bit)
>> +
>> +#define __TC9564_CLOCK_INIT(_name, _reg, _bit)		\
>> +	[CLOCK_##_name] = {				\
>> +		.name	= #_name,			\
>> +		.offset	= CLK_CTRL ## _reg ## _OFFSET,	\
>> +		.mask	= BIT(_bit),			\
>> +	}
>> +
>> +#define TC9564_RESET_INIT0(_name, _bit)	__TC9564_RESET_INIT(_name, 0, _bit)
>> +#define TC9564_RESET_INIT1(_name, _bit)	__TC9564_RESET_INIT(_name, 1, _bit)
>> +
>> +#define __TC9564_RESET_INIT(_name, _reg, _bit)		\
>> +	[RESET_##_name] = {				\
>> +		.offset	= RST_CTRL ## _reg ## _OFFSET,	\
>> +		.mask = BIT(_bit),			\
>> +	}
>> +
>> +static const struct tc9564_clock_init tc9564_clock_init[] = {
>> +	TC9564_CLOCK_INIT0(MCU, 0),
>> +	TC9564_CLOCK_INIT0(INTC, 4),
>> +	/* TC9564_CLOCK_INIT0(PCIE, 9), */
>> +	/* TC9564_CLOCK_INIT0(I2C, 12), */
> 
> A comment would be useful here to outline why these are commented out.
> Is the PCIE one comment out because of what's outlined in the commit
> message?

Yes, that is why.  We are downstream of PCIe, and PCIe in this
case depends on I2C.  So we don't want to mess with these two
clocks or their reset counterparts.

I only provide this for the benefit of documentation.  If someone
happens to see bit 9 set in this register, it means the PCIe clock
is enabled.

Anyway, others have suggested simply removing these comments.
So I'll do what you suggest, but I'm interested to know whether
you would favor just deleting them instead.
> 
>> +	TC9564_CLOCK_INIT0(SRAM, 13),
>> +	TC9564_CLOCK_INIT0(UART, 16),
>> +	TC9564_CLOCK_INIT0(MSIGEN, 18),
>> +	TC9564_CLOCK_INIT0(PLL, 24),
>> +	TC9564_CLOCK_INIT0(SGMII, 25),
>> +	TC9564_CLOCK_INIT0(REFCLKO, 26),

. . .

>> +static const struct reset_control_ops tc9564_reset_control_ops = {
>> +	.assert		= tc9564_reset_assert,
>> +	.deassert	= tc9564_reset_deassert,
> 
> I'd rather not have the extra spaces because sometimes these get out of
> line with new members that need more space. Also tc9564_clk_ops above
> doesn't have the extra spaces.

That's OK with me.  I normally align assignments like this for
readability, but it's obviously an arbitrary stylistic choice.
I'll just use one space, no alignment (just as the clk_ops do
above).  I'll do the same in the platform driver structure
assignments.
> 
>> +};
>> +
>> +static void tc9564_reset_assert_all(struct tc9564_clocks *clocks)
>> +{
>> +	for (u32 id = 0; id < TC9564_RESET_COUNT; id++)
>> +		if (tc9564_reset[id].mask)
>> +			tc9564_reset_manage(&clocks->rcdev, id, true);
>> +}
>> +
>> +static int tc9564_reset_init(struct tc9564_clocks *clocks)
>> +{
>> +	struct reset_controller_dev *rcdev = &clocks->rcdev;
>> +
>> +	rcdev->ops = &tc9564_reset_control_ops;
>> +	rcdev->owner = THIS_MODULE;
>> +	rcdev->dev = clocks->dev;
>> +	rcdev->of_node = dev_of_node(clocks->dev);
>> +	rcdev->nr_resets = TC9564_RESET_COUNT;
>> +
>> +	return devm_reset_controller_register(clocks->dev, rcdev);
>> +}
>> +
>> +static int tc9564_clk_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct tc9564_clocks *clocks;
>> +	int ret;
>> +
>> +	if (!dev_of_node(dev))
>> +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
>> +
>> +	clocks = tc9564_clk_init(dev);
>> +	if (IS_ERR(clocks))
>> +		return dev_err_probe(dev, PTR_ERR(clocks),
>> +				     "failed to initialize clocks\n");
>> +
>> +	ret = tc9564_reset_init(clocks);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to initialize resets\n");
>> +
>> +	/* Force all resets to be initially asserted */
>> +	tc9564_reset_assert_all(clocks);
>> +
>> +	/* Force all clocks to be initially disabled */
>> +	tc9564_clock_disable_all(clocks);
>> +
>> +	platform_set_drvdata(pdev, clocks);
>> +
>> +	return 0;
>> +}
>> +
>> +static void tc9564_clk_remove(struct platform_device *pdev)
>> +{
>> +	struct tc9564_clocks *clocks = platform_get_drvdata(pdev);
>> +
>> +	/* Leave all resets to be deasserted when done */
>> +	tc9564_reset_assert_all(clocks);
> 
> The comment says deasserted but the code calls assert_all.

Oops.  Will fix.  Thank you very much for your review Brian.

					-Alex

> 
> Brian
> 
> 
>> +
>> +	/* Leave all clocks disabled when done */
>> +	tc9564_clock_disable_all(clocks);
>> +}
>> +
>> +static const struct of_device_id tc9564_clk_ids[] = {
>> +	{ .compatible = "toshiba,tc9564-clock" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, tc9564_clk_ids);
>> +
>> +static struct platform_driver tc9564_clk_driver = {
>> +	.probe	= tc9564_clk_probe,
>> +	.remove	= tc9564_clk_remove,
>> +	.driver	= {
>> +		.name		= KBUILD_MODNAME,
>> +		.of_match_table = tc9564_clk_ids,
>> +		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +};
>> +module_platform_driver(tc9564_clk_driver);
>> +
>> +MODULE_DESCRIPTION("Toshiba TC9564 Clock and Reset Driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.53.0
>>
> 

