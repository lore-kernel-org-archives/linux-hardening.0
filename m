Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76038E8A2
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832222; cv=none; b=FHbFJ1MyZyBPvFLXQp191WZ1beSuhY5LE3WjcsdP31aKE5uMGwgwZ5bVJJ/Xdvf8Re/N+E2Fm4e5zyOdiE7f+yEOIvon3VGlGmvxGmwnwqirJg+bDzJNplzgNbUgoWSPufAAvRD0+3Wor4ZLJMO5C0UItZ9kXposSLyNs98abWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832222; c=relaxed/simple;
	bh=P6type2f9ia7W+jtNklDFADjiY6p1gZkgMA0o7JVx7w=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ulLp/3c3Vl7uf0EGH+MrVtRnrwlf9K92SwpH5/AOebjR0V9xQQUUz3SLwoZiMkgyCqnen4YB3oiC6vZVN+gR2f3TTDzQbBep1PyaIo8bsozXbdLLCRg/dqSlRePkDCpgpuG/hcoBCIxpgL0OnurdiWlGKKuFn3NyaFRMvtImnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hnIEs2eh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hnIEs2eh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so22879765e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791832218; x=1792437018; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S0F2+0OoI7HZ/rhelwEA5d881v+pe1yPl7pnkJOYrdg=;
        b=hnIEs2ehnJ1WcWKYb8Wa06Mkkh/g4/ITM+3GOJokAMWA3/gHLdwp+vXJv7eEKFCaH3
         NlAkgC6VQ6h5IsezcwBMFtL59QMfLDUoCm5iVGq+WdhWMteEa3WOh/6nQ1l3Frx1gkuF
         Jx3U6WjN408mzQIGPFiHDMAYZcyawGmsJHhOJHy7QBVnhe2WUXy8tdqryjJBr2NeS73g
         1bw37LoKbEw1hBIMhfwSgTEYgoTJJ/R05Tko42PitLb+KiET1o6sj4QBzWgR0Z8DHSAT
         NjuYdullMSovaNjno3eNxlRfX3RnPwBcZ3XisI5sqR8DF1Gsaxz1zXe0AtubeeUWo30C
         vhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791832218; x=1792437018;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0F2+0OoI7HZ/rhelwEA5d881v+pe1yPl7pnkJOYrdg=;
        b=UuJKuFXBk63Jyg8kHSDYhIrlbICU3UICkCitN2Rtaw10PR6NwPFsTA4Ss9R8RDkueI
         yMExBHSZ2pzH/sJKrNLKCi6EsYvHoyh17gScY2TL5lUcEfVNYZ2NfXzduLQTJ3y1yxke
         6mWgbv7C0C0HUk5RGRzqR2eWIQiwZcRWX7bnvwrY/gKjvhq/cqGrjCeqkdzbivYpU2Fc
         z/tXS4+Fqe1SepoTdeDnvFLPXBAROPr22r4CKWFbASeuAb0suRcOBI9WVZK5HLt0tm2x
         wzOyrzqR6G2ZBKMufLR7kE2HlPG+dHsifXNJxP4gbybQ7fQD2+v7qPbq5jIHF81Vsv1h
         HCeg==
X-Forwarded-Encrypted: i=1; AKwUvBxl6wqRuKk3F+NrS3qKk+iiHqJINF5bwDxhovQxNPn8LgQ3gH7MeAKJeQTCcIAPHaq2UI5WcMuxgenosDSequE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKx/CW9oQskyb/oEBakJYD0p6le7X/e5GLnHBRfSl0AiNIVXc75
	kAN8IAaSiPTu7EFHbD0wrMd7DLPWKIDfRbUYuqBoFAHW1xQQfKMx2vD/qjKP+AdZ4No=
X-Gm-Gg: AYBFou0jZbncMSglbkCKmyGJY2dsZSCIPWZtyosRp/MYS6zN1uLf/oVQblNCmBHM4FD
	iCBNSdLjzgSHigK4c/mFoX4N3ivM4DOASKdYdLcEYHOg0Dm3fTxX3CEuYTaJ+FzqX4NBdN6MdhQ
	BuNw5xY9jSXqpNrz4ehs5hWYrp/6ytQtjweOrEkYx4LX95Sb7vl0+/RlKvzfAvRV4DRCTOfgKAP
	fo/RoeDxjoUoYKdf7no87GnypjLtAwgMT+23h1qkSD5cnDIFjLWJh2fMZ7O4+N6xNryJQIa3egC
	dlrlFnnqOiinWfJ4Lj8F6u4t9nRbrQH14fkXZo5a1Jlsbua/n8A3A4Nl1yTPUH6J0I76QI3sxa6
	kXKq7ZbnkyOhOLHlMFeYSFk4f8dS2Ykk6UcdSLUApvB48xH3JeKfUy5Xzymqz0U78eGQ/18BX+S
	YXxhpJv8vW3BgO5yP/k+H1pt945iBkW1XCPX44rLONEdOeRG+FqlxCqVnMgRlI/3xz0/Z9IbqhO
	SSP/f1piWTmcgm0UQ==
X-Received: by 2002:a05:600c:46cc:b0:4a1:688d:a41c with SMTP id 5b1f17b1804b1-4a18e4c06a8mr186821395e9.25.1791832218270;
        Mon, 12 Oct 2026 12:10:18 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19c71a1d7sm124895475e9.5.2026.10.12.12.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 12:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/4] clk: toshiba: introduce a TC9564 SoC clock
 driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org, 
 kees@kernel.org, gustavoars@kernel.org, mohd.anwar@oss.qualcomm.com, 
 lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <masneyb@kernel.org>, 
 Daniel Thompson <daniel@riscstar.com>
In-Reply-To: <20261012152408.3729237-3-elder@riscstar.com>
References: <20261012152408.3729237-1-elder@riscstar.com>
 <20261012152408.3729237-3-elder@riscstar.com>
Date: Mon, 12 Oct 2026 21:10:02 +0200
Message-Id: <179183220207.266355.11690534397452731561.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13369; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=P6type2f9ia7W+jtNklDFADjiY6p1gZkgMA0o7JVx7w=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFlnDSYVOUez6nlZhmRPevhexlDeospx5dQ90/Ve3f/W/
 XW3SmdLRykLgxgXg6yYIksNd7X4O0mtL7Om69yGmcPKBDKEgYtTACYyV5/hN8v7BmXfr586Ql5X
 fti70T4nsTfKRLKo/WSl8Q4HZu5+O0aG0zHvYo4u4jt959mUevYHoUk3cq4eunxKzZu1Lf534mp
 uXgA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> Define a new platform driver that manages clocks implemented by the
> Toshiba TC9564 SoC.  There are 21 clocks that can be enabled and
> disabled.  Two of these are reserved, so only 19 can be managed.
> 
> Two registers manage the state of the clocks.  The registers are
> accessed via a regmap supplied by a system controller, because the
> region of memory accessed is shared with other drivers.
> 
> Access to the memory region is provided via a BAR on a PCIe endpoint
> function embedded in the TC9564 SoC.  For that reason the PCIe clock
> cannot be manipulated by this driver (it is assumed to be enabled).
> Similarly, control is not available for the I2C clock, because the
> PCIe subsystem on the TC9564 relies on I2C.
> 
> Reviewed-by: Brian Masney <masneyb@kernel.org>
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v3: - The clock driver now gets its regmap by calling syscon_node_to_regmap()
>       on its device parent's devicetree node
>     - The clock driver now must get its parent clock from devicetree
>     - Added Brian's Reviewed-by tag to the second patch
> 
>  MAINTAINERS              |   1 +
>  drivers/clk/Kconfig      |  12 ++
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-tc9564.c | 268 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 282 insertions(+)
>  create mode 100644 drivers/clk/clk-tc9564.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 746fc8918714..25443a2de1f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28178,6 +28178,7 @@ M:	Alex Elder <elder@kernel.org>
>  M:	Daniel Thompson <danielt@kernel.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
> +F:	drivers/clk/clk-tc9564.c
>  F:	include/dt-bindings/clock/toshiba,tc9564.h
>  
>  TOSHIBA TC9564 PCI DRIVER
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 37a8e35d4178..928fff40597e 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -293,6 +293,18 @@ config COMMON_CLK_S2MPS11
>  	  clock. These multi-function devices have two (S2MPS14) or three
>  	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
>  
> +config COMMON_CLK_TC9564
> +	tristate "Toshiba TC9564 clock support"
> +	depends on TC9564_PCI

Consider "depends on TC9564_PCI || COMPILE_TEST".

This driver gets little build coverage otherwise and it has no
compile-time dependency on the PCI driver.

> +	select MFD_SYSCON
> +	default TC9564_PCI
> +	help
> +	  This enables support for the clock controller embedded in the
> +	  Toshiba TC9564 SoC.  The state of each clock is controlled via
> +	  MMIO to a region managed by a system controller; this ensures
> +	  access to the region is coordinated between this and the reset
> +	  and XGMAC (stmmac) drivers.
> +
>  config CLK_TWL
>  	tristate "Clock driver for the TWL PMIC family"
>  	depends on TWL4030_CORE
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 52d138d4ffc8..a11a8326d79c 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -111,6 +111,7 @@ obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
>  obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
>  obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
>  obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
> +obj-$(CONFIG_COMMON_CLK_TC9564)		+= clk-tc9564.o
>  obj-$(CONFIG_COMMON_CLK_TPS68470)      += clk-tps68470.o
>  obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
>  obj-$(CONFIG_CLK_TWL)			+= clk-twl.o
> diff --git a/drivers/clk/clk-tc9564.c b/drivers/clk/clk-tc9564.c
> new file mode 100644
> index 000000000000..09a4f6a144fd
> --- /dev/null
> +++ b/drivers/clk/clk-tc9564.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device-id/of.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/string_choices.h>
> +
> +#include <dt-bindings/clock/toshiba,tc9564.h>
> +
> +#define CLK_CTRL0_OFFSET	0x1004
> +#define CLK_CTRL1_OFFSET	0x100c
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

Seems like this is only used to get back to the regmap, isn't it ?

> +	u32 offset;		/* CLK_CTRL0_OFFSET or CLK_CTRL1_OFFSET */
> +	u32 mask;		/* Zero means undefined clock */

Is there any such undefined clock ?

> +};
> +
> +struct tc9564_clocks {
> +	struct device *dev;
> +	struct regmap *regmap;
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

Those clock still have no parent, so my previous comment regarding unparented clock
remains unaddressed. 

> +
> +/*
> + * The PCIe and I2C clocks are controllable, but we depend on PCIe
> + * and that relies on I2C, so we don't allow them to be disabled.
> + */
> +static const struct tc9564_clock_init tc9564_clock_init[] = {
> +	TC9564_CLOCK_INIT0(MCU, 0),
> +	TC9564_CLOCK_INIT0(INTC, 4),
> +	/* TC9564_CLOCK_INIT0(PCIE, 9), */
> +	/* TC9564_CLOCK_INIT0(I2C, 12), */

Please don't leave commented-out code. The comment above already
explains why these two clocks are not exposed.

BTW, the comment points more toward CLK_IS_CRITICAL, rather
than removing the clocks.

None of the consumer will ever need those clocks ?

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

Are those really just providing the oscillator parent ?
That is what they will appear to do without a proper recalc_rate()

Their names suggest that maybe, it is not the osc coming out
of them ...

> +	TC9564_CLOCK_INIT0(MAC0_ALL, 31),
> +
> +	TC9564_CLOCK_INIT1(MAC1_TX, 7),
> +	TC9564_CLOCK_INIT1(MAC1_RX, 14),
> +	TC9564_CLOCK_INIT1(MAC1_RMII, 15),
> +	TC9564_CLOCK_INIT1(MAC1_125M, 29),
> +	TC9564_CLOCK_INIT1(MAC1_312_5M, 30),

same here

> +	TC9564_CLOCK_INIT1(MAC1_ALL, 31),
> +};
> +#define TC9564_CLOCK_COUNT	ARRAY_SIZE(tc9564_clock_init)
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
> +		dev_err(clocks->dev, "invalid clock (%s id %u)\n",
> +			str_enable_disable(enable), clock->which);

clocks is an error pointer at this point so this will oops.
Good thing is that this is dead code because it manifest only if there
a hole in your table, which do not have ATM. Drop everything related to
this hole managment that you did not test ... you'll introduce it when
you need it and test it

> +		return -ENXIO;
> +	}
> +
> +	return regmap_update_bits(clocks->regmap, offset, mask,
> +				  enable ? mask : 0);

The dance around clocks and 'which' is only to get to this regmap, right ?

You could just use clk_hw_get_dev() and use the drvdata to get back to it.
That would be a lot simpler.

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

Please implement is_enabled(). This helps disabling unused clocks.

> +};
> +
> +static void tc9564_clock_disable_all(struct tc9564_clocks *clocks)
> +{
> +	for (u32 i = 0; i < clocks->clock_count; i++) {
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
> +	u32 i = clkspec->args[0];
> +
> +	if (i < clocks->clock_count)
> +		return &clocks->clocks[i].hw;
> +
> +	dev_err(clocks->dev, "invalid index %u\n", i);
> +
> +	return ERR_PTR(-EINVAL);
> +}

clk_hw_onecell_data and register it with of_clk_hw_onecell_get() maybe ?

> +
> +static struct tc9564_clocks *tc9564_clk_init(struct device *dev)
> +{
> +	struct tc9564_clocks *clocks;
> +	struct regmap *regmap;
> +	size_t clocks_size;
> +	int ret;
> +
> +	regmap = syscon_node_to_regmap(dev_of_node(dev->parent));
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to get config regmap\n");
> +		return ERR_CAST(regmap);
> +	}
> +
> +	clocks_size = struct_size(clocks, clocks, TC9564_CLOCK_COUNT);
> +	clocks = devm_kzalloc(dev, clocks_size, GFP_KERNEL);
> +	if (!clocks)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clocks->dev = dev;
> +	clocks->regmap = regmap;
> +	clocks->clock_count = TC9564_CLOCK_COUNT;
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

No parent is declared. The input clock from the binding should be the
parent of every gate:

	init.parent_data = &(const struct clk_parent_data){ .index = 0 };
	init.num_parents = 1;

Without a parent, these clocks are orphans with rate 0, and enabling
one never enables the input if it needs to be.

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

These fields are set after the clock is registered. Please fill in the
clock completely before calling devm_clk_hw_register(). Ops may be called
as soon as the clock is registered

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
> +static int tc9564_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tc9564_clocks *clocks;
> +	struct clk *clk;
> +
> +	if (!dev_of_node(dev))
> +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
> +
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "failed to get input clock\n");

Nothing is using this. This is not how you set the parent. See above

> +
> +	clocks = tc9564_clk_init(dev);
> +	if (IS_ERR(clocks))
> +		return dev_err_probe(dev, PTR_ERR(clocks),
> +				     "failed to initialize clocks\n");
> +
> +	/* Force all clocks to be initially disabled */
> +	tc9564_clock_disable_all(clocks);

Why is this needed ? In general a provider should never act the provided
clock on its own. Let the framework deal with the used clocks

At this point you've already register the provider so you may be turning
off a clock on a consumer already using it and also mess with the
enable count.

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
> +	/* Leave all clocks disabled when done */
> +	tc9564_clock_disable_all(clocks);

Same type of problem here, there may be still active consumer at this
point. Please drop .remove() entirely.

-- 
Jerome

