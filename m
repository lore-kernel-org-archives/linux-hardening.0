Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF856576EB9
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197109; cv=none; b=pVrUdIxA4bTivJ1HddScLoqYnkiYNmQYiI2Up5rYbXAy3Gyo9LAUNqxp/FVTQUCS8CinpDPvWNfuqu9Htji8hYf/Q7l95g23gw8WjuLwQlOtgPBWB3IVclTEUyMzgXutjMoR3cCDIYS+//Y5YZk+CBYJfKlUzRQLc6rrr/QQSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197109; c=relaxed/simple;
	bh=CnMF7v4cVD2NWW476ulng2IfM18YIgH5scwjktb+jms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QwWufBsl5nLW13AQapWvPFGgZyM9VeNiuCNiUDL9/Mo9CtOO/mvYbkQ+TZ6l1CDMQmaR381N/0WH2eVeFhcS/gniOvjvwKbp/fNBODiSwBX4S2b4+1WaNoLfyCUwLNgH04OB6B3BsjNYXq03zgaPw9IW2ihUVxna42sGNQHPVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NvOuet18; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NvOuet18"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so15492125e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790197103; x=1790801903; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4Mxoo0BjytpbcPdlZ9wg50FxPDTNNYaSFfcT2mT85c=;
        b=NvOuet18ag6cuq2O65ZBbBn+J9q2Vihac91rIOl5eww0tiKs1X31bJH/enZC37IfjH
         py7PIZWzNX8sXe27jWwcasWfW3qvz2dAYgqIh8xEimCXCRlRP3dQkB6Y+3GqNk4W3x1F
         6+6rnw8AqVEfYGKLGLdf4PRLXn+Z5Rm4dQC5W79q9q9JAF1SdLhrHEIlcjOLcqAO/B0E
         N5syi61UAc0HRm2zF9h5iPDP+vEVlmmMPFIgnuvEmWMPz8F5qG0TA30eTDv6Cid0Lafb
         haoBH1+diXOmkjQvRv3DmhDSZYlQTrpUJ4W+4EgCfv8frTkvrmWt5+Y3zQHXzjQZYZv7
         Rw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197103; x=1790801903;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z4Mxoo0BjytpbcPdlZ9wg50FxPDTNNYaSFfcT2mT85c=;
        b=gdROCGOndzrpplxXmMz2uit+A1irU9ntleGbEcYij/subjz4vAWcM7sH3jY4q47+NC
         c7hdz3V47Y2nPmH8yEAR3bPH043MUCcA1hJ+4PIoAewJU+xN4tUsbR9XlOWaaBbh7VD7
         RGuANjUA9TZgkbgCNY6aimTIXtCCj7yGsggf9dDSke7IqiT9OCE89ED73vBJNjZb41f0
         hXIsCngUEZbRRsDmlEMA3Yfd9zQUx3I9FxjGdk4YVyMY6mbqL3sWV21cYdMx7Bth/GvM
         6foLtY5tzLCDppvJqlW0Qh1modp4fMg/CIz8KlM0tjQ3Ea0nOHNArFukAMpwq3VJzwoB
         Pr6w==
X-Forwarded-Encrypted: i=1; AKwUvBxOXnl2Q50gvm62p1CLuWtBYHWpkDj0yxak5qFrksa+e07ss9Dhrzw6dO9t3eR1bvUjZpqN7VUIDOapZwazP6k=@vger.kernel.org
X-Gm-Message-State: AFuF++n1s9vsS4FF8TEcH8R6smI3axWcp7T5oyiIcPTEKDmEKIBlFHHO
	22InczGiesenCh4BNhHjHqv2jodHMY/1awNLZod9SmcswNGkJPHhJB0xNYqWGwrGXCc=
X-Gm-Gg: AYBFou31fSDmMEo82mSCRS0rNwKGo6NgTdLtwvJpz5RLw24NArtTbRxaYhvNnoG56DL
	/npFlUznZyTFDGDNb3wm0/gfMeLqnuImDoBTIcEqA3BDyHiw9OppFjXgWAZYEux+mHclbgoJqlw
	neO+mX0yq/jxuO+dxorrh157oViPBgYnzBiarcQ8eDRXZAJvXo+MCvaewhb3FqDj/pahI89vX2Y
	jLpmVOsW+NlrfDu8Kyd7PYh6J5VXeD0lTjMDBPbvKVf757nBS91R8oqzNjdVcy+NyVFpNfAwZJT
	Echa/PfBZ1jtFU6UJ1cSnhnKTIyhgkNBchOxZdjtR5FaLnrXKpMgEkC/SB5ELqkkjcBOlYvMxbD
	GVzTiBR2P8oXU/qL42VOeZg5UaOK0SF9ooUbCe3SSUuF1OSr79KO34RLmdWE/Seyj+bC0UVDjiF
	qksKQXu4R1vdy6laGIMxIXJ28TbljPWytzJ/kYu80awl5z8AlMg02zMyphuhHyLBhg9TdYnez5s
	qA+VvahUEI63XMwTQA=
X-Received: by 2002:a05:600c:4689:b0:499:be2d:c290 with SMTP id 5b1f17b1804b1-49fe66b4001mr7015405e9.9.1790197103011;
        Wed, 23 Sep 2026 13:58:23 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ded2b7sm12132335e9.10.2026.09.23.13.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:58:22 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Alex Elder <elder@riscstar.com>, Brian Masney <bmasney@redhat.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, p.zabel@pengutronix.de,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clk: toshiba: introduce a TC9564 SoC clock and
 reset driver
In-Reply-To: <0785235b-de06-44d4-9068-ec706eeba848@riscstar.com>
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-4-elder@riscstar.com> <arG238GS8bMB6DkW@redhat.com>
 <0785235b-de06-44d4-9068-ec706eeba848@riscstar.com>
Date: Wed, 23 Sep 2026 22:58:21 +0200
Message-ID: <1jcxu3adn6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On mar. 22 sept. 2026 at 08:33, Alex Elder <elder@riscstar.com> wrote:

> On 9/21/26 5:59 PM, Brian Masney wrote:
>> Hi Alex,
>> 
>> On Fri, Sep 18, 2026 at 11:52:32AM -0500, Alex Elder wrote:
>>> Define a new platform driver that manages clock and reset signals
>>> within the TC9564 SoC.  There are 21 clocks, which can only be
>>> enabled and disabled, as well as 13 reset signals.
>>>
>>> Two registers manage the state of the clocks and two others manage
>>> the state of the resets.  The registers are accessed via a regmap
>>> supplied by a system controller, which coordinates access to a
>>> region of memory that will be shared with another driver.
>>>
>>> Access to the memory region is provided via a BAR on a PCIe endpoint
>>> function embedded in the TC9564 SoC.  For that reason, neither the
>>> PCIe clock nor PCIe reset can be manipulated by this driver (they
>>> are assumed always on and deasserted, respectively).
>>>
>>> Similarly, control is not available for the I2C clock and reset,
>>> because the PCIe subsystem on the TC9564 relies on I2C
>>>
>>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>> ---
>>>   MAINTAINERS              |   1 +
>>>   drivers/clk/Kconfig      |  11 ++
>>>   drivers/clk/Makefile     |   1 +
>>>   drivers/clk/clk-tc9564.c | 366 +++++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 379 insertions(+)
>>>   create mode 100644 drivers/clk/clk-tc9564.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 66d0e7e65adcb..39346a5cd9a7f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -27675,6 +27675,7 @@ M:	Alex Elder <elder@kernel.org>
>>>   M:	Daniel Thompson <danielt@kernel.org>
>>>   S:	Maintained
>>>   F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
>>> +F:	drivers/clk/clk-tc9564.c
>>>   F:	include/dt-bindings/clock/toshiba,tc9564.h
>>>   
>>>   TOSHIBA TC9564 PCI DRIVER
>>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>>> index f9592fd9ec2bb..50efa10d48450 100644
>>> --- a/drivers/clk/Kconfig
>>> +++ b/drivers/clk/Kconfig
>>> @@ -292,6 +292,17 @@ config COMMON_CLK_S2MPS11
>>>   	  clock. These multi-function devices have two (S2MPS14) or three
>>>   	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
>>>   
>>> +config COMMON_CLK_TC9564
>>> +	tristate "Toshiba TC9564 clock support"
>>> +	depends on TC9564_PCI
>> 
>> select RESET_CONTROLLER
>
> Thank you.  The reset and clock drivers were previously separate
> and the reset only became available if RESET_CONTROLLER was enabled.
> Combining them means I need this.  I will add it.

Why did you combine them ?

it would be a lot better if the reset were handled in
drivers/reset rather than in clock. There has already been some work to
move reset from clock back to reset. This often involve auxiliary drivers.

>
> I also need to select MFD_SYSCON to get syscon_node_to_regmap()
> (or perhaps something similar, depending on the answers to my
> questions about the proper way to define the syscon).
>> 
>>> +	default m
>> 
>> default n
>
> This depends on TC9564_PCI, and if TC9564_PCI is enabled I would
> like this to (automatically) be available (at least as a module).
>
> Why do you recommend "n"?
>
>>> +	help
>>> +	  This enables support for the clock and reset controller embedded
>>> +	  in the Toshiba TC9564 (and Qualcomm QPS615) SoC.  The state of
>>> +	  clock and reset lines is controlled by MMIO to a region managed
>>> +	  by a system controller; this ensures access to the region is
>>> +	  coordinated between this and other drivers.
>> 
>> Rather than 'other drivers', outline specifically which other drivers.
>
> I was intentionally vague at this point because the one other driver
> has not yet gone out for upstream review for this iteration of the
> code.  But I do agree with you, so I'll change this to say:
>
>     ... between this and the XGMAC (stmmac) driver.
>
> Then it will be correct without modification once that driver goes
> out for review.  Is that better, or do you suggest something else?
>
>>> +
>>>   config CLK_TWL
>>>   	tristate "Clock driver for the TWL PMIC family"
>>>   	depends on TWL4030_CORE
>>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>>> index b18af485d7f03..a98ea8ff92066 100644
>>> --- a/drivers/clk/Makefile
>>> +++ b/drivers/clk/Makefile
>>> @@ -110,6 +110,7 @@ obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
>>>   obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
>>>   obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
>>>   obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
>>> +obj-$(CONFIG_COMMON_CLK_TC9564)		+= clk-tc9564.o
>>>   obj-$(CONFIG_COMMON_CLK_TPS68470)      += clk-tps68470.o
>>>   obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
>>>   obj-$(CONFIG_CLK_TWL)			+= clk-twl.o
>>> diff --git a/drivers/clk/clk-tc9564.c b/drivers/clk/clk-tc9564.c
>>> new file mode 100644
>>> index 0000000000000..4f900bc8994a7
>>> --- /dev/null
>>> +++ b/drivers/clk/clk-tc9564.c
>>> @@ -0,0 +1,366 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +/*
>>> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
>>> + */
>>> +
>>> +#include <linux/bits.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/mod_devicetable.h>
>> 
>> Uwe already pointed out removing this.
>
> Yes, done.
>
>> 
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset-controller.h>
>>> +
>>> +#include <dt-bindings/clock/toshiba,tc9564.h>
>>> +
>>> +#define CLK_CTRL0_OFFSET	0x1004
>>> +#define RST_CTRL0_OFFSET	0x1008
>>> +#define CLK_CTRL1_OFFSET	0x100c
>>> +#define RST_CTRL1_OFFSET	0x1010
>>> +
>>> +struct tc9564_clock_init {
>>> +	const char *name;	/* NULL means unused entry */
>>> +	u32 offset;
>>> +	u32 mask;
>>> +};
>>> +
>>> +struct tc9564_clock {
>>> +	struct clk_hw hw;
>>> +	u32 which;
>>> +	u32 offset;		/* CLK_CTRL0_OFFSET or CLK_CTRL1_OFFSET */
>>> +	u32 mask;		/* Zero means undefined clock */
>>> +};
>>> +
>>> +struct tc9564_reset {
>>> +	u32 offset;		/* RST_CTRL0_OFFSET or RST_CTRL1_OFFSET */
>>> +	u32 mask;		/* Zero means undefined reset */
>>> +};
>>> +
>>> +struct tc9564_clocks {
>>> +	struct device *dev;
>>> +	struct regmap *regmap;
>>> +	struct reset_controller_dev rcdev;
>>> +	size_t clock_count;
>>> +	struct tc9564_clock clocks[] __counted_by(clock_count);
>>> +};
>>> +
>>> +#define TC9564_CLOCK_INIT0(_name, _bit)	__TC9564_CLOCK_INIT(_name, 0, _bit)
>>> +#define TC9564_CLOCK_INIT1(_name, _bit)	__TC9564_CLOCK_INIT(_name, 1, _bit)
>>> +
>>> +#define __TC9564_CLOCK_INIT(_name, _reg, _bit)		\
>>> +	[CLOCK_##_name] = {				\
>>> +		.name	= #_name,			\
>>> +		.offset	= CLK_CTRL ## _reg ## _OFFSET,	\
>>> +		.mask	= BIT(_bit),			\
>>> +	}
>>> +
>>> +#define TC9564_RESET_INIT0(_name, _bit)	__TC9564_RESET_INIT(_name, 0, _bit)
>>> +#define TC9564_RESET_INIT1(_name, _bit)	__TC9564_RESET_INIT(_name, 1, _bit)
>>> +
>>> +#define __TC9564_RESET_INIT(_name, _reg, _bit)		\
>>> +	[RESET_##_name] = {				\
>>> +		.offset	= RST_CTRL ## _reg ## _OFFSET,	\
>>> +		.mask = BIT(_bit),			\
>>> +	}
>>> +
>>> +static const struct tc9564_clock_init tc9564_clock_init[] = {
>>> +	TC9564_CLOCK_INIT0(MCU, 0),
>>> +	TC9564_CLOCK_INIT0(INTC, 4),
>>> +	/* TC9564_CLOCK_INIT0(PCIE, 9), */
>>> +	/* TC9564_CLOCK_INIT0(I2C, 12), */
>> 
>> A comment would be useful here to outline why these are commented out.
>> Is the PCIE one comment out because of what's outlined in the commit
>> message?
>
> Yes, that is why.  We are downstream of PCIe, and PCIe in this
> case depends on I2C.  So we don't want to mess with these two
> clocks or their reset counterparts.
>
> I only provide this for the benefit of documentation.  If someone
> happens to see bit 9 set in this register, it means the PCIe clock
> is enabled.
>
> Anyway, others have suggested simply removing these comments.
> So I'll do what you suggest, but I'm interested to know whether
> you would favor just deleting them instead.
>> 
>>> +	TC9564_CLOCK_INIT0(SRAM, 13),
>>> +	TC9564_CLOCK_INIT0(UART, 16),
>>> +	TC9564_CLOCK_INIT0(MSIGEN, 18),
>>> +	TC9564_CLOCK_INIT0(PLL, 24),
>>> +	TC9564_CLOCK_INIT0(SGMII, 25),
>>> +	TC9564_CLOCK_INIT0(REFCLKO, 26),
>
> . . .
>
>>> +static const struct reset_control_ops tc9564_reset_control_ops = {
>>> +	.assert		= tc9564_reset_assert,
>>> +	.deassert	= tc9564_reset_deassert,
>> 
>> I'd rather not have the extra spaces because sometimes these get out of
>> line with new members that need more space. Also tc9564_clk_ops above
>> doesn't have the extra spaces.
>
> That's OK with me.  I normally align assignments like this for
> readability, but it's obviously an arbitrary stylistic choice.
> I'll just use one space, no alignment (just as the clk_ops do
> above).  I'll do the same in the platform driver structure
> assignments.
>> 
>>> +};
>>> +
>>> +static void tc9564_reset_assert_all(struct tc9564_clocks *clocks)
>>> +{
>>> +	for (u32 id = 0; id < TC9564_RESET_COUNT; id++)
>>> +		if (tc9564_reset[id].mask)
>>> +			tc9564_reset_manage(&clocks->rcdev, id, true);
>>> +}
>>> +
>>> +static int tc9564_reset_init(struct tc9564_clocks *clocks)
>>> +{
>>> +	struct reset_controller_dev *rcdev = &clocks->rcdev;
>>> +
>>> +	rcdev->ops = &tc9564_reset_control_ops;
>>> +	rcdev->owner = THIS_MODULE;
>>> +	rcdev->dev = clocks->dev;
>>> +	rcdev->of_node = dev_of_node(clocks->dev);
>>> +	rcdev->nr_resets = TC9564_RESET_COUNT;
>>> +
>>> +	return devm_reset_controller_register(clocks->dev, rcdev);
>>> +}
>>> +
>>> +static int tc9564_clk_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct tc9564_clocks *clocks;
>>> +	int ret;
>>> +
>>> +	if (!dev_of_node(dev))
>>> +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
>>> +
>>> +	clocks = tc9564_clk_init(dev);
>>> +	if (IS_ERR(clocks))
>>> +		return dev_err_probe(dev, PTR_ERR(clocks),
>>> +				     "failed to initialize clocks\n");
>>> +
>>> +	ret = tc9564_reset_init(clocks);
>>> +	if (ret)
>>> +		return dev_err_probe(dev, ret, "failed to initialize resets\n");
>>> +
>>> +	/* Force all resets to be initially asserted */
>>> +	tc9564_reset_assert_all(clocks);
>>> +
>>> +	/* Force all clocks to be initially disabled */
>>> +	tc9564_clock_disable_all(clocks);
>>> +
>>> +	platform_set_drvdata(pdev, clocks);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void tc9564_clk_remove(struct platform_device *pdev)
>>> +{
>>> +	struct tc9564_clocks *clocks = platform_get_drvdata(pdev);
>>> +
>>> +	/* Leave all resets to be deasserted when done */
>>> +	tc9564_reset_assert_all(clocks);
>> 
>> The comment says deasserted but the code calls assert_all.
>
> Oops.  Will fix.  Thank you very much for your review Brian.
>
> 					-Alex
>
>> 
>> Brian
>> 
>> 
>>> +
>>> +	/* Leave all clocks disabled when done */
>>> +	tc9564_clock_disable_all(clocks);
>>> +}
>>> +
>>> +static const struct of_device_id tc9564_clk_ids[] = {
>>> +	{ .compatible = "toshiba,tc9564-clock" },
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, tc9564_clk_ids);
>>> +
>>> +static struct platform_driver tc9564_clk_driver = {
>>> +	.probe	= tc9564_clk_probe,
>>> +	.remove	= tc9564_clk_remove,
>>> +	.driver	= {
>>> +		.name		= KBUILD_MODNAME,
>>> +		.of_match_table = tc9564_clk_ids,
>>> +		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>>> +	},
>>> +};
>>> +module_platform_driver(tc9564_clk_driver);
>>> +
>>> +MODULE_DESCRIPTION("Toshiba TC9564 Clock and Reset Driver");
>>> +MODULE_LICENSE("GPL");
>>> -- 
>>> 2.53.0
>>>
>> 
>

-- 
Jerome
