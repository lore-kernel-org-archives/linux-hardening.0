Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B951356F
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031593; cv=none; b=ahdouX1Uc39/SyIE5d/9YIoOnzPdm0WcnKAB8zICBBgyo6MCSZTMnKrSLl/m7pPEqXr5ezFdXNJ34L6gY6gNLXYPj8urGl7/6BYZ84c/rkCtqxEm9nTmTn3ILIv3R3g5xLmq5HVE9asmy1kC+ECKYO5byg0Xb1HQJOjFjjD5uxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031593; c=relaxed/simple;
	bh=Viqkdh/QeiMsAZ28ym2NzT6HaKq3qpnp+vTYn7al20o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MNZE3zkukDc4OazwXDXRfysd8M7tlSiWCQ23k4Pmd2Akmi4H63z0gSTTpBb9V2g99vdA61n5tK7y1tXuxMZVGmN8Hqivba5nyJpiXpzOQKuNJGewOYmKvxBPhSUcYcD1KiOrMllKzlIvUe9VckBPfNPe3RBhe5i7/CuERts6Udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGGek6cs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGGek6cs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790031590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcE1DJFbMUcT/SY4ziyQWDDt2BeD/Y65JJ5A9AIGrX4=;
	b=bGGek6cs4Ao+xQ1JsxPPCBmX+aCr9U0vmw9maxbaMcrqNpLv1As2CsgSNHk4vaqEhLoSdJ
	w+1VqzOfM0q8CAac0rUxALcmaycScMpjSIfPtSJYl51rg1mnOPKGi5Z4ckYT2P5VHoMX8q
	pw81pJId2c/Z/BtEfIXPzPkrlATuoPA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-fJdekMYpNxeJ0YW1-W2LLg-1; Mon, 21 Sep 2026 18:59:46 -0400
X-MC-Unique: fJdekMYpNxeJ0YW1-W2LLg-1
X-Mimecast-MFC-AGG-ID: fJdekMYpNxeJ0YW1-W2LLg_1790031586
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a183a0e93so764937885a.1
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790031586; x=1790636386;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HcE1DJFbMUcT/SY4ziyQWDDt2BeD/Y65JJ5A9AIGrX4=;
        b=QL2cAVHAl8alD09sfx7R0XvKUJVtBffd26W+bBSvw4H2BMg9u8YJrOUXx5z2+y66uB
         UiYKlgOlBhmimvUCjoVmNQn6GrUmrro3o4aaLDbKQlQv045db/VS0CLsoqjVIJVIs6Fx
         y6wwVcxe6u1VqPRJ/5+esRi8q8LbHdV5S6wdQiXSneN11hBKMV18jLSvwDsJaGgXzMQa
         lHmLZlVNbGksghj8fPnxSFw5UyBi3DIzGa0pG2adCVwRzrnHmpw5ZknT7yCWiFU2G4EN
         932r9vxP0xg+91VPx/OxKl/QqLJldPMQmwXBGqM9C2NVIx4DvzIutASTiGF137zMr7Ht
         56VA==
X-Forwarded-Encrypted: i=1; AKwUvBwg27UNGpcXZH37iV8Eqo0f2WNKQ1LGcDXkb8ifO/T2OgfGFJ1eZQcZTnTSEOvAJT+Sj1mkcYZCiQcbN4MjpGo=@vger.kernel.org
X-Gm-Message-State: AFuF++k4bINBJUYsdj4HU4vV4Gk3UDdYUXY+JfhAls9LYuYcCa+X3zgf
	i2jv1S1OocuyCHAjXhx8q4c6TnKj1KriskqA4zgRWmjxQTrAgGHT3hglve9tRZ235nIprnelk8X
	KkWC+kLWrKUSGw6q9yDbTL52ZaEpi1L7o1Ji68N29fOtSEFqM3fijuD4+t/5ucbg7LlkdMg==
X-Gm-Gg: AYBFou0jIHINIZosRNXXtVSiEZfONR/VbQiN655UIU3v03+jbDiksS6sJvLLLZPTHX7
	Z/HHvtWvHYJoHAybvRIHXz+FYWcmys+TlnMBSUrnINP2HY0Y9sVFyJnFDt7nV6WzO+g3Bebe2fz
	oZSU0sCimjB6Kk/2Vxi0DMzC1iLrI01WdlvLKt5BFPktWdFkOKS9UxmyXdQbruXJDAHL0LfRAhC
	BH7SxYfeR9SmmGwjleookCN3244397ehITbLqLXED4g0W8mqD67wjz22gsYp5syinu0YLCF/MxQ
	Wr11zs42UxYvwoqkZ7fVNDYxVMJ/l2wj+1InhmDXB240CtGFcVXJsIAx5gGXI+id7jYWlMI=
X-Received: by 2002:a05:620a:29cb:b0:936:e18d:763d with SMTP id af79cd13be357-93c15d5966dmr280207285a.8.1790031586151;
        Mon, 21 Sep 2026 15:59:46 -0700 (PDT)
X-Received: by 2002:a05:620a:29cb:b0:936:e18d:763d with SMTP id af79cd13be357-93c15d5966dmr280203685a.8.1790031585688;
        Mon, 21 Sep 2026 15:59:45 -0700 (PDT)
Received: from redhat.com ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914024f12c3sm971356d6.36.2026.09.21.15.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 15:59:45 -0700 (PDT)
Date: Mon, 21 Sep 2026 18:59:43 -0400
From: Brian Masney <bmasney@redhat.com>
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lee@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	abelvesa@kernel.org, kees@kernel.org, gustavoars@kernel.org,
	p.zabel@pengutronix.de, daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clk: toshiba: introduce a TC9564 SoC clock and reset
 driver
Message-ID: <arG238GS8bMB6DkW@redhat.com>
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260918165234.687224-4-elder@riscstar.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wib1Uh-LcoIB2xkQLLX9-L15yrILkbVJ-7aeHcB6zSM_1790031586
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alex,

On Fri, Sep 18, 2026 at 11:52:32AM -0500, Alex Elder wrote:
> Define a new platform driver that manages clock and reset signals
> within the TC9564 SoC.  There are 21 clocks, which can only be
> enabled and disabled, as well as 13 reset signals.
> 
> Two registers manage the state of the clocks and two others manage
> the state of the resets.  The registers are accessed via a regmap
> supplied by a system controller, which coordinates access to a
> region of memory that will be shared with another driver.
> 
> Access to the memory region is provided via a BAR on a PCIe endpoint
> function embedded in the TC9564 SoC.  For that reason, neither the
> PCIe clock nor PCIe reset can be manipulated by this driver (they
> are assumed always on and deasserted, respectively).
> 
> Similarly, control is not available for the I2C clock and reset,
> because the PCIe subsystem on the TC9564 relies on I2C
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/clk/Kconfig      |  11 ++
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-tc9564.c | 366 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 379 insertions(+)
>  create mode 100644 drivers/clk/clk-tc9564.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66d0e7e65adcb..39346a5cd9a7f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27675,6 +27675,7 @@ M:	Alex Elder <elder@kernel.org>
>  M:	Daniel Thompson <danielt@kernel.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
> +F:	drivers/clk/clk-tc9564.c
>  F:	include/dt-bindings/clock/toshiba,tc9564.h
>  
>  TOSHIBA TC9564 PCI DRIVER
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index f9592fd9ec2bb..50efa10d48450 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -292,6 +292,17 @@ config COMMON_CLK_S2MPS11
>  	  clock. These multi-function devices have two (S2MPS14) or three
>  	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
>  
> +config COMMON_CLK_TC9564
> +	tristate "Toshiba TC9564 clock support"
> +	depends on TC9564_PCI

select RESET_CONTROLLER

> +	default m

default n

> +	help
> +	  This enables support for the clock and reset controller embedded
> +	  in the Toshiba TC9564 (and Qualcomm QPS615) SoC.  The state of
> +	  clock and reset lines is controlled by MMIO to a region managed
> +	  by a system controller; this ensures access to the region is
> +	  coordinated between this and other drivers.

Rather than 'other drivers', outline specifically which other drivers.

> +
>  config CLK_TWL
>  	tristate "Clock driver for the TWL PMIC family"
>  	depends on TWL4030_CORE
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index b18af485d7f03..a98ea8ff92066 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -110,6 +110,7 @@ obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
>  obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
>  obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
>  obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
> +obj-$(CONFIG_COMMON_CLK_TC9564)		+= clk-tc9564.o
>  obj-$(CONFIG_COMMON_CLK_TPS68470)      += clk-tps68470.o
>  obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
>  obj-$(CONFIG_CLK_TWL)			+= clk-twl.o
> diff --git a/drivers/clk/clk-tc9564.c b/drivers/clk/clk-tc9564.c
> new file mode 100644
> index 0000000000000..4f900bc8994a7
> --- /dev/null
> +++ b/drivers/clk/clk-tc9564.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mod_devicetable.h>

Uwe already pointed out removing this.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/clock/toshiba,tc9564.h>
> +
> +#define CLK_CTRL0_OFFSET	0x1004
> +#define RST_CTRL0_OFFSET	0x1008
> +#define CLK_CTRL1_OFFSET	0x100c
> +#define RST_CTRL1_OFFSET	0x1010
> +
> +struct tc9564_clock_init {
> +	const char *name;	/* NULL means unused entry */
> +	u32 offset;
> +	u32 mask;
> +};
> +
> +struct tc9564_clock {
> +	struct clk_hw hw;
> +	u32 which;
> +	u32 offset;		/* CLK_CTRL0_OFFSET or CLK_CTRL1_OFFSET */
> +	u32 mask;		/* Zero means undefined clock */
> +};
> +
> +struct tc9564_reset {
> +	u32 offset;		/* RST_CTRL0_OFFSET or RST_CTRL1_OFFSET */
> +	u32 mask;		/* Zero means undefined reset */
> +};
> +
> +struct tc9564_clocks {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct reset_controller_dev rcdev;
> +	size_t clock_count;
> +	struct tc9564_clock clocks[] __counted_by(clock_count);
> +};
> +
> +#define TC9564_CLOCK_INIT0(_name, _bit)	__TC9564_CLOCK_INIT(_name, 0, _bit)
> +#define TC9564_CLOCK_INIT1(_name, _bit)	__TC9564_CLOCK_INIT(_name, 1, _bit)
> +
> +#define __TC9564_CLOCK_INIT(_name, _reg, _bit)		\
> +	[CLOCK_##_name] = {				\
> +		.name	= #_name,			\
> +		.offset	= CLK_CTRL ## _reg ## _OFFSET,	\
> +		.mask	= BIT(_bit),			\
> +	}
> +
> +#define TC9564_RESET_INIT0(_name, _bit)	__TC9564_RESET_INIT(_name, 0, _bit)
> +#define TC9564_RESET_INIT1(_name, _bit)	__TC9564_RESET_INIT(_name, 1, _bit)
> +
> +#define __TC9564_RESET_INIT(_name, _reg, _bit)		\
> +	[RESET_##_name] = {				\
> +		.offset	= RST_CTRL ## _reg ## _OFFSET,	\
> +		.mask = BIT(_bit),			\
> +	}
> +
> +static const struct tc9564_clock_init tc9564_clock_init[] = {
> +	TC9564_CLOCK_INIT0(MCU, 0),
> +	TC9564_CLOCK_INIT0(INTC, 4),
> +	/* TC9564_CLOCK_INIT0(PCIE, 9), */
> +	/* TC9564_CLOCK_INIT0(I2C, 12), */

A comment would be useful here to outline why these are commented out.
Is the PCIE one comment out because of what's outlined in the commit
message?

> +	TC9564_CLOCK_INIT0(SRAM, 13),
> +	TC9564_CLOCK_INIT0(UART, 16),
> +	TC9564_CLOCK_INIT0(MSIGEN, 18),
> +	TC9564_CLOCK_INIT0(PLL, 24),
> +	TC9564_CLOCK_INIT0(SGMII, 25),
> +	TC9564_CLOCK_INIT0(REFCLKO, 26),
> +
> +	TC9564_CLOCK_INIT0(MAC0_TX, 7),
> +	TC9564_CLOCK_INIT0(MAC0_RX, 14),
> +	TC9564_CLOCK_INIT0(MAC0_125M, 29),
> +	TC9564_CLOCK_INIT0(MAC0_312_5M, 30),
> +	TC9564_CLOCK_INIT0(MAC0_ALL, 31),
> +
> +	TC9564_CLOCK_INIT1(MAC1_TX, 7),
> +	TC9564_CLOCK_INIT1(MAC1_RX, 14),
> +	TC9564_CLOCK_INIT1(MAC1_RMII, 15),
> +	TC9564_CLOCK_INIT1(MAC1_125M, 29),
> +	TC9564_CLOCK_INIT1(MAC1_312_5M, 30),
> +	TC9564_CLOCK_INIT1(MAC1_ALL, 31),
> +};
> +#define TC9564_CLOCK_COUNT	ARRAY_SIZE(tc9564_clock_init)
> +
> +static const struct tc9564_reset tc9564_reset[] = {
> +	TC9564_RESET_INIT0(MCU, 0),
> +	TC9564_RESET_INIT0(MCU1, 1),
> +	TC9564_RESET_INIT0(INTC, 4),
> +	/* TC9564_RESET_INIT0(PCIE, 9), */
> +	/* TC9564_RESET_INIT0(I2C, 12), */
> +	TC9564_RESET_INIT0(UART, 16),
> +	TC9564_RESET_INIT0(MSIGEN, 18),
> +
> +	TC9564_RESET_INIT0(MAC0_MAC, 7),
> +	TC9564_RESET_INIT0(MAC0_PMA, 30),
> +	TC9564_RESET_INIT0(MAC0_XPCS, 31),
> +
> +	TC9564_RESET_INIT1(MAC1_MAC, 7),
> +	TC9564_RESET_INIT1(MAC1_PMA, 30),
> +	TC9564_RESET_INIT1(MAC1_XPCS, 31),
> +};
> +#define TC9564_RESET_COUNT	ARRAY_SIZE(tc9564_reset)
> +
> +static const struct tc9564_clock *hw_to_tc9564_clock(struct clk_hw *hw)
> +{
> +	return container_of_const(hw, struct tc9564_clock, hw);
> +}
> +
> +static const struct tc9564_clocks *
> +tc9564_clock_to_clocks(const struct tc9564_clock *clock)
> +{
> +	u32 which = clock->which;
> +
> +	if (which >= TC9564_CLOCK_COUNT)
> +		return ERR_PTR(-ENXIO);
> +
> +	return container_of_const(clock, struct tc9564_clocks, clocks[which]);
> +}
> +
> +static int tc9564_clk_manage(struct clk_hw *hw, bool enable)
> +{
> +	const struct tc9564_clock *clock = hw_to_tc9564_clock(hw);
> +	const struct tc9564_clocks *clocks;
> +	u32 offset = clock->offset;
> +	u32 mask = clock->mask;
> +
> +	clocks = tc9564_clock_to_clocks(clock);
> +	if (IS_ERR(clocks) || !mask) {
> +		dev_err(clk_hw_get_dev(hw), "invalid clock (%s id %u)\n",
> +			enable ? "enable" : "disable", clock->which);
> +		return -ENXIO;
> +	}
> +
> +	return regmap_update_bits(clocks->regmap, offset, mask,
> +				  enable ? mask : 0);
> +}
> +
> +static int tc9564_clk_enable(struct clk_hw *hw)
> +{
> +	return tc9564_clk_manage(hw, true);
> +}
> +
> +static void tc9564_clk_disable(struct clk_hw *hw)
> +{
> +	(void)tc9564_clk_manage(hw, false);
> +}
> +
> +static const struct clk_ops tc9564_clk_ops = {
> +	.enable = tc9564_clk_enable,
> +	.disable = tc9564_clk_disable,
> +};
> +
> +static void tc9564_clock_disable_all(struct tc9564_clocks *clocks)
> +{
> +	for (int i = 0; i < clocks->clock_count; i++) {
> +		const struct tc9564_clock *clock = &clocks->clocks[i];
> +
> +		if (clock->mask)
> +			regmap_update_bits(clocks->regmap, clock->offset,
> +					   clock->mask, 0);
> +	}
> +}
> +
> +static struct clk_hw *tc9564_clk_hw_get(struct of_phandle_args *clkspec,
> +					void *data)
> +{
> +	struct tc9564_clocks *clocks = data;
> +	unsigned int i = clkspec->args[0];
> +
> +	if (i < clocks->clock_count)
> +		return &clocks->clocks[i].hw;
> +
> +	dev_err(clocks->dev, "invalid index %u\n", i);
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static struct tc9564_clocks *tc9564_clk_init(struct device *dev)
> +{
> +	struct tc9564_clocks *clocks;
> +	size_t clocks_size;
> +	int ret;
> +
> +	clocks_size = struct_size(clocks, clocks, TC9564_CLOCK_COUNT);
> +	clocks = devm_kzalloc(dev, clocks_size, GFP_KERNEL);
> +	if (!clocks)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clocks->dev = dev;
> +	clocks->clock_count = TC9564_CLOCK_COUNT;
> +
> +	clocks->regmap = syscon_node_to_regmap(dev_of_node(dev->parent));
> +	if (IS_ERR(clocks->regmap)) {
> +		dev_err(dev, "failed to get config regmap\n");
> +		return ERR_CAST(clocks->regmap);
> +	}
> +
> +	for (u32 i = 0; i < TC9564_CLOCK_COUNT; i++) {
> +		const struct tc9564_clock_init *clock_init;
> +		struct clk_init_data init = { };
> +		struct tc9564_clock *clock;
> +
> +		clock_init = &tc9564_clock_init[i];
> +		if (!clock_init->name)
> +			continue;
> +
> +		init.name = clock_init->name;
> +		init.ops = &tc9564_clk_ops;
> +
> +		clock = &clocks->clocks[i];
> +		clock->hw.init = &init;
> +
> +		ret = devm_clk_hw_register(dev, &clock->hw);
> +		if (ret) {
> +			dev_err(dev, "failed to register clock \"%s\"\n",
> +				init.name);
> +			return ERR_PTR(ret);
> +		}
> +
> +		clock->which = i;
> +		clock->offset = clock_init->offset;
> +		clock->mask = clock_init->mask;
> +	}
> +
> +	ret = devm_of_clk_add_hw_provider(dev, tc9564_clk_hw_get, clocks);
> +	if (ret) {
> +		dev_err(dev, "failed to add clock hardware provider\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	return clocks;
> +}
> +
> +static const struct tc9564_clocks *
> +rcdev_to_tc9564_clocks(struct reset_controller_dev *rcdev)
> +{
> +	return container_of_const(rcdev, struct tc9564_clocks, rcdev);
> +}
> +
> +static int tc9564_reset_manage(struct reset_controller_dev *rcdev,
> +			       unsigned long id, bool assert)
> +{
> +	const struct tc9564_clocks *clocks = rcdev_to_tc9564_clocks(rcdev);
> +
> +	if (id < rcdev->nr_resets) {
> +		const struct tc9564_reset *reset = &tc9564_reset[id];
> +		u32 mask = reset->mask;
> +
> +		if (mask)
> +			return regmap_update_bits(clocks->regmap,
> +						  reset->offset, mask,
> +						  assert ? mask : 0);
> +	}
> +
> +	dev_err(clocks->dev, "invalid reset (%sassert id %lu)\n",
> +		assert ? "" : "de", id);
> +
> +	return -ENXIO;
> +}
> +
> +static int tc9564_reset_assert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	return tc9564_reset_manage(rcdev, id, true);
> +}
> +
> +static int tc9564_reset_deassert(struct reset_controller_dev *rcdev,
> +				 unsigned long id)
> +{
> +	return tc9564_reset_manage(rcdev, id, false);
> +}
> +
> +static const struct reset_control_ops tc9564_reset_control_ops = {
> +	.assert		= tc9564_reset_assert,
> +	.deassert	= tc9564_reset_deassert,

I'd rather not have the extra spaces because sometimes these get out of
line with new members that need more space. Also tc9564_clk_ops above
doesn't have the extra spaces.

> +};
> +
> +static void tc9564_reset_assert_all(struct tc9564_clocks *clocks)
> +{
> +	for (u32 id = 0; id < TC9564_RESET_COUNT; id++)
> +		if (tc9564_reset[id].mask)
> +			tc9564_reset_manage(&clocks->rcdev, id, true);
> +}
> +
> +static int tc9564_reset_init(struct tc9564_clocks *clocks)
> +{
> +	struct reset_controller_dev *rcdev = &clocks->rcdev;
> +
> +	rcdev->ops = &tc9564_reset_control_ops;
> +	rcdev->owner = THIS_MODULE;
> +	rcdev->dev = clocks->dev;
> +	rcdev->of_node = dev_of_node(clocks->dev);
> +	rcdev->nr_resets = TC9564_RESET_COUNT;
> +
> +	return devm_reset_controller_register(clocks->dev, rcdev);
> +}
> +
> +static int tc9564_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tc9564_clocks *clocks;
> +	int ret;
> +
> +	if (!dev_of_node(dev))
> +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
> +
> +	clocks = tc9564_clk_init(dev);
> +	if (IS_ERR(clocks))
> +		return dev_err_probe(dev, PTR_ERR(clocks),
> +				     "failed to initialize clocks\n");
> +
> +	ret = tc9564_reset_init(clocks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize resets\n");
> +
> +	/* Force all resets to be initially asserted */
> +	tc9564_reset_assert_all(clocks);
> +
> +	/* Force all clocks to be initially disabled */
> +	tc9564_clock_disable_all(clocks);
> +
> +	platform_set_drvdata(pdev, clocks);
> +
> +	return 0;
> +}
> +
> +static void tc9564_clk_remove(struct platform_device *pdev)
> +{
> +	struct tc9564_clocks *clocks = platform_get_drvdata(pdev);
> +
> +	/* Leave all resets to be deasserted when done */
> +	tc9564_reset_assert_all(clocks);

The comment says deasserted but the code calls assert_all.

Brian


> +
> +	/* Leave all clocks disabled when done */
> +	tc9564_clock_disable_all(clocks);
> +}
> +
> +static const struct of_device_id tc9564_clk_ids[] = {
> +	{ .compatible = "toshiba,tc9564-clock" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tc9564_clk_ids);
> +
> +static struct platform_driver tc9564_clk_driver = {
> +	.probe	= tc9564_clk_probe,
> +	.remove	= tc9564_clk_remove,
> +	.driver	= {
> +		.name		= KBUILD_MODNAME,
> +		.of_match_table = tc9564_clk_ids,
> +		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_platform_driver(tc9564_clk_driver);
> +
> +MODULE_DESCRIPTION("Toshiba TC9564 Clock and Reset Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.53.0
> 

