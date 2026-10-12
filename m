Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D348EC64
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835165; cv=none; b=MlkWkZfWrIu9h4CXsjkJIzAqz2fCPd6MeQ6bs08Tcw5cJPYqycV1JfbEbyP+zCy792wJwzJzbFKD9lZj35iMIXNWg5NxfVSw2v0bw9WXBMkfvkCAZUQWOSfnYrNpYVRde9xrKrd2PxoDe+74a5ooAVEGAaH78w0X5Ga8Ow9mQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835165; c=relaxed/simple;
	bh=W9aJcZ9a4vyNN7ZzMoEZ+7SiibSwoQI9DS+fHznHRYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TA0l/BDo6PvUYWOaFDvlhD4JJKA3pqMGtmXr49IkXFOGjr/e3K/wbHin44vLHxvSqHwe8gXK/g4rwrUc9P3aPrkHZiWA2aSlY15g6ZQvxfRWiGpAAALY1CrzcDSDsCh9FnhDu1VSwTDNQygUnrOQNEV8GgAqB1QnO8DrMjtFuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=S0wM4J/w; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="S0wM4J/w"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5339381b46eso23752851cf.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791835161; x=1792439961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAWTZN30kCbwQpO/YGvYysEeNKQ6p0wo7IxFjRZ55zc=;
        b=S0wM4J/wmh34AT8OzNJq1F+Xp85FaxKaHvcxPxY2ZZua3B2EC+SWGxPSISJ989Ttkk
         8X/ZKMgSY2VykJ7XVVkXRaUMKEYnHpVNg+wVclMiP6LxQaAIokVzbCTm0kUvbVnOLqyX
         dUSJU0icTsdOx8nIrWP8pdOuvgjZy9Yop2FLCqMz9ii15JGvqjfb1Y9KEDHQBuDG35x7
         ixtUcWRcWylqcRgeXV+YNqgJ18qAdXnztyBvwwmgmw9/WL60CcggpW8WVCa/vLLjO12c
         ZnjLAVZWvzDb/oRRN0GcP9YYqD3jzzinxfa3LfMQYR/KygX1AJwh3/zG7ufBbH3cXJky
         6pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791835161; x=1792439961;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DAWTZN30kCbwQpO/YGvYysEeNKQ6p0wo7IxFjRZ55zc=;
        b=mYdY0XtN+8dEl8nyl9oeJzSbDQXndST90kdBtFs8ah3MByxlgOfgSj8/KVIO7k2Lbk
         VXXcAnEAG/REqaVSDXfkEDEjWeja0JbPT8wl/0VivQXOaX/xR3LGGzZeB5OG1DcBT1+i
         Y8Qv5bLqYtrY3/uAHZ/4KTIZhhxdD+4oRU3z4eGPxxGs38TBozBRtSezkGqSbtOf8++n
         +X4pm1VoNxxidKJTwWq+7fBK45jcFC0YQkBW85gtGGLag/cZ5u8qKNW53TFmgWMYoYvI
         xnrVKt0HnNYISH8hNYtbDNGBVd1j4mnSSLVYQUtTPB7kVmei2U/EVcpnW9jsjrcFHQ93
         7MVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZWI+Bz4FZkz/41iNEXbKhKYaqDKq5FrVkL6aev5iFH5T2ga012+OTqLcayO9VTT5kNJ4gWTGNuM5Je+1UdK0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWTFmI908atNGL3JAb/WxcaR9Y0tf9adQ5cKPOU6ypU2TnNw+W
	qU0QoakR2vyrNIFNyz4YcoxNMNuGa1t4NHMBi6PhBjWd6F6o2AN1FBfPOEd8F673OrY=
X-Gm-Gg: AYBFou3JpnrI8VbR/O08OmQHKSLJiOw9dHhyMWTJiulG7kI/oF04MWwdQSCYpgvgX8j
	+UuyzCBr9Ovk8WSTswbX5QzgNaIX7Cp9YObHe2BU1ietQeg+R3BMJZSxqFG3a+HWvO81hBPN0I+
	crt4xhntaJPW/kaPNeKIObXJMtaLcxhEx+4ww5LMf8BNP6LEAUE7AV7cpYZlHUpvv+GmAChJ/WQ
	6/bs+iB0IGeE8/xqXW3X42YEbj4woehKfeZqHTGLp2FdEISaP0lUEXOjG0hDcmSmKoD2VgoCtRn
	ocWMB3rU0AIfOPeFoYYPdJS3sqrCX5X6RKs7LY7PDrDddu4i745EOPDJGW3mrZeZHqj3uxPJewI
	TgQjf93KalcirgMp/JMxVoO6/PO7pb4493+YmOj2FjzzXDIp5uZWZYRmo2DGnUOIbONO5kTSGD3
	MhSVswkVFuwfJ1qXvRjAWCqR8Hwc2aOt6y2daOM/DhW+T2xMRdd7z2E2MVhdsWrK+Nr1mif10=
X-Received: by 2002:a05:622a:144a:b0:533:3bf7:49e5 with SMTP id d75a77b69052e-5359facf0e9mr163429641cf.23.1791835161002;
        Mon, 12 Oct 2026 12:59:21 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b79a186sm87032691cf.20.2026.10.12.12.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 12:59:20 -0700 (PDT)
Message-ID: <10007ecc-3604-4c58-9da7-f056dd4355a1@riscstar.com>
Date: Mon, 12 Oct 2026 14:59:18 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] clk: toshiba: introduce a TC9564 SoC clock driver
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Brian Masney <masneyb@kernel.org>,
 Daniel Thompson <daniel@riscstar.com>
References: <20261012152408.3729237-1-elder@riscstar.com>
 <20261012152408.3729237-3-elder@riscstar.com>
 <179183220207.266355.11690534397452731561.b4-review@b4>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <179183220207.266355.11690534397452731561.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 2:10 PM, Jerome Brunet wrote:
>> Define a new platform driver that manages clocks implemented by the
>> Toshiba TC9564 SoC.  There are 21 clocks that can be enabled and
>> disabled.  Two of these are reserved, so only 19 can be managed.
>>
>> Two registers manage the state of the clocks.  The registers are
>> accessed via a regmap supplied by a system controller, because the
>> region of memory accessed is shared with other drivers.
>>
>> Access to the memory region is provided via a BAR on a PCIe endpoint
>> function embedded in the TC9564 SoC.  For that reason the PCIe clock
>> cannot be manipulated by this driver (it is assumed to be enabled).
>> Similarly, control is not available for the I2C clock, because the
>> PCIe subsystem on the TC9564 relies on I2C.

Thanks a lot for this review.  I respond to all of your
comments below.

>> Reviewed-by: Brian Masney <masneyb@kernel.org>
>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v3: - The clock driver now gets its regmap by calling syscon_node_to_regmap()
>>        on its device parent's devicetree node
>>      - The clock driver now must get its parent clock from devicetree
>>      - Added Brian's Reviewed-by tag to the second patch
>>
>>   MAINTAINERS              |   1 +
>>   drivers/clk/Kconfig      |  12 ++
>>   drivers/clk/Makefile     |   1 +
>>   drivers/clk/clk-tc9564.c | 268 +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 282 insertions(+)
>>   create mode 100644 drivers/clk/clk-tc9564.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 746fc8918714..25443a2de1f7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -28178,6 +28178,7 @@ M:	Alex Elder <elder@kernel.org>
>>   M:	Daniel Thompson <danielt@kernel.org>
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
>> +F:	drivers/clk/clk-tc9564.c
>>   F:	include/dt-bindings/clock/toshiba,tc9564.h
>>   
>>   TOSHIBA TC9564 PCI DRIVER
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 37a8e35d4178..928fff40597e 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -293,6 +293,18 @@ config COMMON_CLK_S2MPS11
>>   	  clock. These multi-function devices have two (S2MPS14) or three
>>   	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
>>   
>> +config COMMON_CLK_TC9564
>> +	tristate "Toshiba TC9564 clock support"
>> +	depends on TC9564_PCI
> 
> Consider "depends on TC9564_PCI || COMPILE_TEST".

Yes.  I normally prefer doing that, but haven't actually tried
to cross-compile this code on other target architectures yet
and didn't want to encounter "unrelated" errors.

I will do so before I send the next version so I can add
COMPILE_TEST.

> This driver gets little build coverage otherwise and it has no
> compile-time dependency on the PCI driver.
> 
>> +	select MFD_SYSCON
>> +	default TC9564_PCI
>> +	help
>> +	  This enables support for the clock controller embedded in the
>> +	  Toshiba TC9564 SoC.  The state of each clock is controlled via
>> +	  MMIO to a region managed by a system controller; this ensures
>> +	  access to the region is coordinated between this and the reset
>> +	  and XGMAC (stmmac) drivers.
>> +
>>   config CLK_TWL
>>   	tristate "Clock driver for the TWL PMIC family"
>>   	depends on TWL4030_CORE
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index 52d138d4ffc8..a11a8326d79c 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -111,6 +111,7 @@ obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
>>   obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
>>   obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
>>   obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
>> +obj-$(CONFIG_COMMON_CLK_TC9564)		+= clk-tc9564.o
>>   obj-$(CONFIG_COMMON_CLK_TPS68470)      += clk-tps68470.o
>>   obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
>>   obj-$(CONFIG_CLK_TWL)			+= clk-twl.o
>> diff --git a/drivers/clk/clk-tc9564.c b/drivers/clk/clk-tc9564.c
>> new file mode 100644
>> index 000000000000..09a4f6a144fd
>> --- /dev/null
>> +++ b/drivers/clk/clk-tc9564.c
>> @@ -0,0 +1,268 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/device-id/of.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/string_choices.h>
>> +
>> +#include <dt-bindings/clock/toshiba,tc9564.h>
>> +
>> +#define CLK_CTRL0_OFFSET	0x1004
>> +#define CLK_CTRL1_OFFSET	0x100c
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
> 
> Seems like this is only used to get back to the regmap, isn't it ?

If you mean the "which" field, it is mainly used for
that purpose, yes.  It's also used in a warning message,
but that only occurs if it's a bad value, which I don't
think will ever happen.

If we just trust that clk_hw_get callback function won't
get called with a bad clock, the "which" field can probably
be eliminated, and the result will be a little simpler.

If you were referring to something other than "which" please
say so.

>> +	u32 offset;		/* CLK_CTRL0_OFFSET or CLK_CTRL1_OFFSET */
>> +	u32 mask;		/* Zero means undefined clock */
> 
> Is there any such undefined clock ?

There isn't any more.  There was at one time, because the
list of clock IDs was enumerated, and two were skipped.
Krzysztof said to eliminate the hole in that range.  So
this comment can go away now.

>> +};
>> +
>> +struct tc9564_clocks {
>> +	struct device *dev;
>> +	struct regmap *regmap;
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
> 
> Those clock still have no parent, so my previous comment regarding unparented clock
> remains unaddressed.

You're right.  I added a parent in devicetree, but did not
have these clocks point back to it.

We have this set of clocks with fixed frequencies, but no
definitive definition of how they're derived.  So the best
I can do is have them all refer back to the single 25 MHz
input clock.
> 
>> +
>> +/*
>> + * The PCIe and I2C clocks are controllable, but we depend on PCIe
>> + * and that relies on I2C, so we don't allow them to be disabled.
>> + */
>> +static const struct tc9564_clock_init tc9564_clock_init[] = {
>> +	TC9564_CLOCK_INIT0(MCU, 0),
>> +	TC9564_CLOCK_INIT0(INTC, 4),
>> +	/* TC9564_CLOCK_INIT0(PCIE, 9), */
>> +	/* TC9564_CLOCK_INIT0(I2C, 12), */
> 
> Please don't leave commented-out code. The comment above already
> explains why these two clocks are not exposed.

OK.  My main goal was to document those bit numbers.

> BTW, the comment points more toward CLK_IS_CRITICAL, rather
> than removing the clocks.

That's a good idea (and it documents the bits).
> None of the consumer will ever need those clocks ?

To the best of my knowledge, no.

>> +	TC9564_CLOCK_INIT0(SRAM, 13),
>> +	TC9564_CLOCK_INIT0(UART, 16),
>> +	TC9564_CLOCK_INIT0(MSIGEN, 18),
>> +	TC9564_CLOCK_INIT0(PLL, 24),
>> +	TC9564_CLOCK_INIT0(SGMII, 25),
>> +	TC9564_CLOCK_INIT0(REFCLKO, 26),
>> +
>> +	TC9564_CLOCK_INIT0(MAC0_TX, 7),
>> +	TC9564_CLOCK_INIT0(MAC0_RX, 14),
>> +	TC9564_CLOCK_INIT0(MAC0_125M, 29),
>> +	TC9564_CLOCK_INIT0(MAC0_312_5M, 30),
> 
> Are those really just providing the oscillator parent ?
> That is what they will appear to do without a proper recalc_rate()

They are fixed clocks that can be gated, but their
rate cannot be changed.

Looking at __clk_core_init(), should I define a
recalc_rate() callback that just returns the
equivalent of get_rate()?

> Their names suggest that maybe, it is not the osc coming out
> of them ...

We have requested a clock tree that explains exactly
how these clock rates are derived from the 25 MHz
oscillator.  They're all fixed rates, and although
we could easily speculate how they're derived, we
don't have the documentation.
>> +	TC9564_CLOCK_INIT0(MAC0_ALL, 31),
>> +
>> +	TC9564_CLOCK_INIT1(MAC1_TX, 7),
>> +	TC9564_CLOCK_INIT1(MAC1_RX, 14),
>> +	TC9564_CLOCK_INIT1(MAC1_RMII, 15),
>> +	TC9564_CLOCK_INIT1(MAC1_125M, 29),
>> +	TC9564_CLOCK_INIT1(MAC1_312_5M, 30),
> 
> same here
> 
>> +	TC9564_CLOCK_INIT1(MAC1_ALL, 31),
>> +};
>> +#define TC9564_CLOCK_COUNT	ARRAY_SIZE(tc9564_clock_init)
>> +
>> +static const struct tc9564_clock *hw_to_tc9564_clock(struct clk_hw *hw)
>> +{
>> +	return container_of_const(hw, struct tc9564_clock, hw);
>> +}
>> +
>> +static const struct tc9564_clocks *
>> +tc9564_clock_to_clocks(const struct tc9564_clock *clock)
>> +{
>> +	u32 which = clock->which;
>> +
>> +	if (which >= TC9564_CLOCK_COUNT)
>> +		return ERR_PTR(-ENXIO);
>> +
>> +	return container_of_const(clock, struct tc9564_clocks, clocks[which]);
>> +}
>> +
>> +static int tc9564_clk_manage(struct clk_hw *hw, bool enable)
>> +{
>> +	const struct tc9564_clock *clock = hw_to_tc9564_clock(hw);
>> +	const struct tc9564_clocks *clocks;
>> +	u32 offset = clock->offset;
>> +	u32 mask = clock->mask;
>> +
>> +	clocks = tc9564_clock_to_clocks(clock);
>> +	if (IS_ERR(clocks) || !mask) {
>> +		dev_err(clocks->dev, "invalid clock (%s id %u)\n",
>> +			str_enable_disable(enable), clock->which);
> 
> clocks is an error pointer at this point so this will oops.

Wow, you're right, and it's used twice in that dev_err().
I'll fix this.

> Good thing is that this is dead code because it manifest only if there
> a hole in your table, which do not have ATM. Drop everything related to
> this hole managment that you did not test ... you'll introduce it when
> you need it and test it
> 
>> +		return -ENXIO;
>> +	}
>> +
>> +	return regmap_update_bits(clocks->regmap, offset, mask,
>> +				  enable ? mask : 0);
> 
> The dance around clocks and 'which' is only to get to this regmap, right ?
> 
> You could just use clk_hw_get_dev() and use the drvdata to get back to it.
> That would be a lot simpler.

OK, that sounds much better.

> 
>> +}
>> +
>> +static int tc9564_clk_enable(struct clk_hw *hw)
>> +{
>> +	return tc9564_clk_manage(hw, true);
>> +}
>> +
>> +static void tc9564_clk_disable(struct clk_hw *hw)
>> +{
>> +	(void)tc9564_clk_manage(hw, false);
>> +}
>> +
>> +static const struct clk_ops tc9564_clk_ops = {
>> +	.enable = tc9564_clk_enable,
>> +	.disable = tc9564_clk_disable,
> 
> Please implement is_enabled(). This helps disabling unused clocks.

OK, that's easy.

> 
>> +};
>> +
>> +static void tc9564_clock_disable_all(struct tc9564_clocks *clocks)
>> +{
>> +	for (u32 i = 0; i < clocks->clock_count; i++) {
>> +		const struct tc9564_clock *clock = &clocks->clocks[i];
>> +
>> +		if (clock->mask)
>> +			regmap_update_bits(clocks->regmap, clock->offset,
>> +					   clock->mask, 0);
>> +	}
>> +}
>> +
>> +static struct clk_hw *tc9564_clk_hw_get(struct of_phandle_args *clkspec,
>> +					void *data)
>> +{
>> +	struct tc9564_clocks *clocks = data;
>> +	u32 i = clkspec->args[0];
>> +
>> +	if (i < clocks->clock_count)
>> +		return &clocks->clocks[i].hw;
>> +
>> +	dev_err(clocks->dev, "invalid index %u\n", i);
>> +
>> +	return ERR_PTR(-EINVAL);
>> +}
> 
> clk_hw_onecell_data and register it with of_clk_hw_onecell_get() maybe ?

I'll look into that.

> 
>> +
>> +static struct tc9564_clocks *tc9564_clk_init(struct device *dev)
>> +{
>> +	struct tc9564_clocks *clocks;
>> +	struct regmap *regmap;
>> +	size_t clocks_size;
>> +	int ret;
>> +
>> +	regmap = syscon_node_to_regmap(dev_of_node(dev->parent));
>> +	if (IS_ERR(regmap)) {
>> +		dev_err(dev, "failed to get config regmap\n");
>> +		return ERR_CAST(regmap);
>> +	}
>> +
>> +	clocks_size = struct_size(clocks, clocks, TC9564_CLOCK_COUNT);
>> +	clocks = devm_kzalloc(dev, clocks_size, GFP_KERNEL);
>> +	if (!clocks)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	clocks->dev = dev;
>> +	clocks->regmap = regmap;
>> +	clocks->clock_count = TC9564_CLOCK_COUNT;
>> +
>> +	for (u32 i = 0; i < TC9564_CLOCK_COUNT; i++) {
>> +		const struct tc9564_clock_init *clock_init;
>> +		struct clk_init_data init = { };
>> +		struct tc9564_clock *clock;
>> +
>> +		clock_init = &tc9564_clock_init[i];
>> +		if (!clock_init->name)
>> +			continue;
>> +
>> +		init.name = clock_init->name;
>> +		init.ops = &tc9564_clk_ops;
> 
> No parent is declared. The input clock from the binding should be the
> parent of every gate:
> 
> 	init.parent_data = &(const struct clk_parent_data){ .index = 0 };
> 	init.num_parents = 1;

Yes, understood.  I neglected to do this.

> Without a parent, these clocks are orphans with rate 0, and enabling
> one never enables the input if it needs to be.


> 
>> +
>> +		clock = &clocks->clocks[i];
>> +		clock->hw.init = &init;
>> +
>> +		ret = devm_clk_hw_register(dev, &clock->hw);
>> +		if (ret) {
>> +			dev_err(dev, "failed to register clock \"%s\"\n",
>> +				init.name);
>> +			return ERR_PTR(ret);
>> +		}
>> +
>> +		clock->which = i;
>> +		clock->offset = clock_init->offset;
>> +		clock->mask = clock_init->mask;
> 
> These fields are set after the clock is registered. Please fill in the
> clock completely before calling devm_clk_hw_register(). Ops may be called
> as soon as the clock is registered

Yes, you're right.  I'll fully initialize the clock structure
before registering.

> 
>> +	}
>> +
>> +	ret = devm_of_clk_add_hw_provider(dev, tc9564_clk_hw_get, clocks);
>> +	if (ret) {
>> +		dev_err(dev, "failed to add clock hardware provider\n");
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return clocks;
>> +}
>> +
>> +static int tc9564_clk_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct tc9564_clocks *clocks;
>> +	struct clk *clk;
>> +
>> +	if (!dev_of_node(dev))
>> +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
>> +
>> +	clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(clk))
>> +		return dev_err_probe(dev, PTR_ERR(clk),
>> +				     "failed to get input clock\n");
> 
> Nothing is using this. This is not how you set the parent. See above

It will once I have the clocks get properly parented.

>> +
>> +	clocks = tc9564_clk_init(dev);
>> +	if (IS_ERR(clocks))
>> +		return dev_err_probe(dev, PTR_ERR(clocks),
>> +				     "failed to initialize clocks\n");
>> +
>> +	/* Force all clocks to be initially disabled */
>> +	tc9564_clock_disable_all(clocks);
> 
> Why is this needed ? In general a provider should never act the provided
> clock on its own. Let the framework deal with the used clocks

The intent was to start with everything disabled--a known
state.  Sashiko pointed out this races with a user that
could get the clock right away, so I intend to do this
by initially disabling all the clocks before they're
all registered.

> At this point you've already register the provider so you may be turning
> off a clock on a consumer already using it and also mess with the
> enable count.

Yes, understood.  This will be done in the proper order.

> 
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
>> +	/* Leave all clocks disabled when done */
>> +	tc9564_clock_disable_all(clocks);
> 
> Same type of problem here, there may be still active consumer at this
> point. Please drop .remove() entirely.

Exactly (as I responded to the Sashiko message that said roughly
the same thing).

This was a great review.  I really appreciate it.

					-Alex
