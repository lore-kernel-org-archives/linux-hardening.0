Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F444B693
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241778; cv=none; b=jhrmNccY6hgH+Hcd1JP0ybPkEkBTS4OEZ7GfjB7t/f41T99t+WSn0BNh2Rnqn9ESDrPJBHTnutsq7FQ/JHsP+L2Tn93bfzRvhmRRzA8ritoHYWKc4yZbL1l7k+BOEzXhff1wePswAmKTUBlxvNu5G/q4coJpNHENf3tBwbstIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241778; c=relaxed/simple;
	bh=mywOQrWMWFVFDki0RIs1d34z1OHjO3osLzVxFR7tLz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drhtqbXd/UcBxwOaPVcDTIR+7bwTCAcfRhEOkaLEMk4WXw6WbHO3lzOuJiVDnZp7GYQ8dIbTDIuSOWxQLbwPF/Odrcr78Nr2tbmjWze3ZANu2X0P8jspgWBkwUhl95PZGjp8eCPp1IoUnKSTCti+GLR946v2d7CCPhpDMljYAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=qlQDfizQ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="qlQDfizQ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53397325663so21861971cf.1
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 16:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791241774; x=1791846574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnCAgo/qchAranRI+SGaVK55jNTJ728XC8v65yvcy00=;
        b=qlQDfizQo3v7iJobsIMEqjIgRxTn2TnvingHzp/O2Z0xJ+xWgbn/uUYa3bgIiWlW2k
         UgG+8uvdEg89RT+yzik15RxMZ8tWA63xw4xmdmPvmj0erSkgWzxSAVBJi134Chm66apH
         L6FJIi96xtcVFp+JVRiroJvcUHUDNuDNHqDXLFm5aEifBlOKOYfB6J7mH835+jCdwJbQ
         7PpvnkOGsSOGVlY9TVdh4lnBEDcqOsU5KJe3bd3mdg80WTZEIZwusr70HSKkrqAEfawu
         zw40KbQc21k5pLY3j1PxGAyfxkvCJECX5trJR/gt7SbDpy3CC8l6rvyKOswiZek1MhUV
         wv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791241774; x=1791846574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lnCAgo/qchAranRI+SGaVK55jNTJ728XC8v65yvcy00=;
        b=yxk3lH819vX1/4tBDBVpdFrtVT6em/1z7YChiuBdOXyv5LNiUJZm8ng99v+3jmc6YK
         SAJXANe/iB5a1NLfWiZUvX6DtkhTlB7r7U30BHQgLxkMSEu4QpCrg9Zrf0+u1L97+nfl
         FQGLf3RPuNtNo6XK80niE7xZEbNevHdod1Myn6YzLiwqRXF+JvnUl2vfGVU+k6Hbmrus
         Q//dPm3RyTfaQQDDCkhH239Lvwcivbc3+iJW6Wxid/C1M70+IUNATBV0gQsvZcudvT/H
         trP6Pch1lNxxstsXiwT173AXTu7PO8G1a/pRZJEW+MIsAxNwc3jHd5zwrauWfAs/jbbX
         8Jsg==
X-Forwarded-Encrypted: i=1; AKwUvByD9um6eVa5Gy2yw4MfNVC+ZapoVwJ5gTQXR2tJFnUTHIvKj06wrjOoHiCIXOs0bxvJVkaBdflp9N1i9kEJIUg=@vger.kernel.org
X-Gm-Message-State: AFuF++meW0o3tBwBmCkfkwxDVfKQHqljJHX+Ligum6W51jsZP3TllJ9Y
	tynTiaZY2nxSybZXKX1rjfY0XCqXWenE3wjTp2Zgj24uRxAHoUYSf7ELLSMs1sGY3GM=
X-Gm-Gg: AYBFou1286iSQ6ExclqdNvNshakaVi0HGAqRgaz/CKeK2OTTGu4G257j+lSCJyUhs4v
	W99tpBcb2IMp0gWGJdgoHNYeUvOrBz7bUh5Wk1h2uudciJaViQ75efGhN7xvK0Rul7EpT1iNddY
	c1uPXuUEF+v5BWm4+T02vZm3egEwwZt5L1UGhMWbbf7cKdiq4mlrRYMSTs6TYkGDjTZ8gCO5Twk
	Uocjib/v48CGSOlMLiATBNfxUGf6M1Ea1notxDIMQazSXSs1wzF7AlQ3OGNukqOJ5Cia7aUnC75
	FDsi3ML7rgWWlCFipLm4LYv8rFQi2l964fqVi4qb5q1+6kF8sWctI0yK4NsBOtEIFKePeiLanTN
	Rnk4yPoYQ/0/PTSa+rnCOngoR1sIhRLYrrbXABh9kwaG7lrsMLiMVUy0zvQCk2r23A30pKN8C+z
	wrAp7Hp1C1V39vu6a7fSPOiVXsL4NA+FlC5Y0/fMM6yVmLwEIxg3LGsB3OlrEqqpibZZXovRlT4
	z8=
X-Received: by 2002:a05:622a:c85:b0:532:cacd:e420 with SMTP id d75a77b69052e-53511b4c991mr154017491cf.6.1791241774601;
        Mon, 05 Oct 2026 16:09:34 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-919442ce1c4sm89892116d6.3.2026.10.05.16.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 16:09:34 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org
Cc: abelvesa@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	danielt@kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Thompson <daniel@riscstar.com>
Subject: [PATCH v2 2/3] clk: toshiba: introduce a TC9564 SoC clock driver
Date: Mon,  5 Oct 2026 18:09:25 -0500
Message-ID: <20261005230927.2000398-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005230927.2000398-1-elder@riscstar.com>
References: <20261005230927.2000398-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a new platform driver that manages clocks implemented by the
Toshiba TC9564 SoC.  There are 21 clocks that can be enabled and
disabled.  Two of these are reserved, so only 19 can be managed.

Two registers manage the state of the clocks.  The registers are
accessed via a regmap supplied by a system controller, because the
region of memory accessed is shared with other drivers.

Access to the memory region is provided via a BAR on a PCIe endpoint
function embedded in the TC9564 SoC.  For that reason the PCIe clock
cannot be manipulated by this driver (it is assumed to be enabled).
Similarly, control is not available for the I2C clock, because the
PCIe subsystem on the TC9564 relies on I2C.

Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Only implement clock functionality, not reset functionality
    - Get the definition of of_device_id from <linux/device_id/of.h>
    - Dropped a comma that followed a ternminating empty array entry
    - Config option COMMON_CLK_TC9564 now selects MFD_SYSCON
    - Clarified in config help text that the reset and stmmac drivers
      also use the config syscon

 MAINTAINERS              |   1 +
 drivers/clk/Kconfig      |  12 ++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-tc9564.c | 262 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 276 insertions(+)
 create mode 100644 drivers/clk/clk-tc9564.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 860cf437574cf..18139dc2add92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28133,6 +28133,7 @@ M:	Alex Elder <elder@kernel.org>
 M:	Daniel Thompson <danielt@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
+F:	drivers/clk/clk-tc9564.c
 F:	include/dt-bindings/clock/toshiba,tc9564.h
 
 TOSHIBA TC9564 PCI DRIVER
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 37a8e35d41783..928fff40597ee 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -293,6 +293,18 @@ config COMMON_CLK_S2MPS11
 	  clock. These multi-function devices have two (S2MPS14) or three
 	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
 
+config COMMON_CLK_TC9564
+	tristate "Toshiba TC9564 clock support"
+	depends on TC9564_PCI
+	select MFD_SYSCON
+	default TC9564_PCI
+	help
+	  This enables support for the clock controller embedded in the
+	  Toshiba TC9564 SoC.  The state of each clock is controlled via
+	  MMIO to a region managed by a system controller; this ensures
+	  access to the region is coordinated between this and the reset
+	  and XGMAC (stmmac) drivers.
+
 config CLK_TWL
 	tristate "Clock driver for the TWL PMIC family"
 	depends on TWL4030_CORE
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 52d138d4ffc88..a11a8326d79cb 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
 obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
 obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
 obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
+obj-$(CONFIG_COMMON_CLK_TC9564)		+= clk-tc9564.o
 obj-$(CONFIG_COMMON_CLK_TPS68470)      += clk-tps68470.o
 obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
 obj-$(CONFIG_CLK_TWL)			+= clk-twl.o
diff --git a/drivers/clk/clk-tc9564.c b/drivers/clk/clk-tc9564.c
new file mode 100644
index 0000000000000..2e90e85b6215f
--- /dev/null
+++ b/drivers/clk/clk-tc9564.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/device-id/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/string_choices.h>
+
+#include <dt-bindings/clock/toshiba,tc9564.h>
+
+#define CLK_CTRL0_OFFSET	0x1004
+#define CLK_CTRL1_OFFSET	0x100c
+
+struct tc9564_clock_init {
+	const char *name;	/* NULL means unused entry */
+	u32 offset;
+	u32 mask;
+};
+
+struct tc9564_clock {
+	struct clk_hw hw;
+	u32 which;
+	u32 offset;		/* CLK_CTRL0_OFFSET or CLK_CTRL1_OFFSET */
+	u32 mask;		/* Zero means undefined clock */
+};
+
+struct tc9564_clocks {
+	struct device *dev;
+	struct regmap *regmap;
+	size_t clock_count;
+	struct tc9564_clock clocks[] __counted_by(clock_count);
+};
+
+#define TC9564_CLOCK_INIT0(_name, _bit)	__TC9564_CLOCK_INIT(_name, 0, _bit)
+#define TC9564_CLOCK_INIT1(_name, _bit)	__TC9564_CLOCK_INIT(_name, 1, _bit)
+
+#define __TC9564_CLOCK_INIT(_name, _reg, _bit)		\
+	[CLOCK_##_name] = {				\
+		.name	= #_name,			\
+		.offset	= CLK_CTRL ## _reg ## _OFFSET,	\
+		.mask	= BIT(_bit),			\
+	}
+
+/*
+ * The PCIe and I2C clocks are controllable, but we depend on PCIe
+ * and that relies on I2C, so we don't allow them to be disabled.
+ */
+static const struct tc9564_clock_init tc9564_clock_init[] = {
+	TC9564_CLOCK_INIT0(MCU, 0),
+	TC9564_CLOCK_INIT0(INTC, 4),
+	/* TC9564_CLOCK_INIT0(PCIE, 9), */
+	/* TC9564_CLOCK_INIT0(I2C, 12), */
+	TC9564_CLOCK_INIT0(SRAM, 13),
+	TC9564_CLOCK_INIT0(UART, 16),
+	TC9564_CLOCK_INIT0(MSIGEN, 18),
+	TC9564_CLOCK_INIT0(PLL, 24),
+	TC9564_CLOCK_INIT0(SGMII, 25),
+	TC9564_CLOCK_INIT0(REFCLKO, 26),
+
+	TC9564_CLOCK_INIT0(MAC0_TX, 7),
+	TC9564_CLOCK_INIT0(MAC0_RX, 14),
+	TC9564_CLOCK_INIT0(MAC0_125M, 29),
+	TC9564_CLOCK_INIT0(MAC0_312_5M, 30),
+	TC9564_CLOCK_INIT0(MAC0_ALL, 31),
+
+	TC9564_CLOCK_INIT1(MAC1_TX, 7),
+	TC9564_CLOCK_INIT1(MAC1_RX, 14),
+	TC9564_CLOCK_INIT1(MAC1_RMII, 15),
+	TC9564_CLOCK_INIT1(MAC1_125M, 29),
+	TC9564_CLOCK_INIT1(MAC1_312_5M, 30),
+	TC9564_CLOCK_INIT1(MAC1_ALL, 31),
+};
+#define TC9564_CLOCK_COUNT	ARRAY_SIZE(tc9564_clock_init)
+
+static const struct tc9564_clock *hw_to_tc9564_clock(struct clk_hw *hw)
+{
+	return container_of_const(hw, struct tc9564_clock, hw);
+}
+
+static const struct tc9564_clocks *
+tc9564_clock_to_clocks(const struct tc9564_clock *clock)
+{
+	u32 which = clock->which;
+
+	if (which >= TC9564_CLOCK_COUNT)
+		return ERR_PTR(-ENXIO);
+
+	return container_of_const(clock, struct tc9564_clocks, clocks[which]);
+}
+
+static int tc9564_clk_manage(struct clk_hw *hw, bool enable)
+{
+	const struct tc9564_clock *clock = hw_to_tc9564_clock(hw);
+	const struct tc9564_clocks *clocks;
+	u32 offset = clock->offset;
+	u32 mask = clock->mask;
+
+	clocks = tc9564_clock_to_clocks(clock);
+	if (IS_ERR(clocks) || !mask) {
+		dev_err(clocks->dev, "invalid clock (%s id %u)\n",
+			str_enable_disable(enable), clock->which);
+		return -ENXIO;
+	}
+
+	return regmap_update_bits(clocks->regmap, offset, mask,
+				  enable ? mask : 0);
+}
+
+static int tc9564_clk_enable(struct clk_hw *hw)
+{
+	return tc9564_clk_manage(hw, true);
+}
+
+static void tc9564_clk_disable(struct clk_hw *hw)
+{
+	(void)tc9564_clk_manage(hw, false);
+}
+
+static const struct clk_ops tc9564_clk_ops = {
+	.enable = tc9564_clk_enable,
+	.disable = tc9564_clk_disable,
+};
+
+static void tc9564_clock_disable_all(struct tc9564_clocks *clocks)
+{
+	for (u32 i = 0; i < clocks->clock_count; i++) {
+		const struct tc9564_clock *clock = &clocks->clocks[i];
+
+		if (clock->mask)
+			regmap_update_bits(clocks->regmap, clock->offset,
+					   clock->mask, 0);
+	}
+}
+
+static struct clk_hw *tc9564_clk_hw_get(struct of_phandle_args *clkspec,
+					void *data)
+{
+	struct tc9564_clocks *clocks = data;
+	u32 i = clkspec->args[0];
+
+	if (i < clocks->clock_count)
+		return &clocks->clocks[i].hw;
+
+	dev_err(clocks->dev, "invalid index %u\n", i);
+
+	return ERR_PTR(-EINVAL);
+}
+
+static struct tc9564_clocks *tc9564_clk_init(struct device *dev)
+{
+	struct tc9564_clocks *clocks;
+	struct regmap *regmap;
+	size_t clocks_size;
+	int ret;
+
+	regmap = syscon_regmap_lookup_by_phandle(dev_of_node(dev),
+						 "toshiba,config-syscon");
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to get config regmap\n");
+		return ERR_CAST(regmap);
+	}
+
+	clocks_size = struct_size(clocks, clocks, TC9564_CLOCK_COUNT);
+	clocks = devm_kzalloc(dev, clocks_size, GFP_KERNEL);
+	if (!clocks)
+		return ERR_PTR(-ENOMEM);
+
+	clocks->dev = dev;
+	clocks->regmap = regmap;
+	clocks->clock_count = TC9564_CLOCK_COUNT;
+
+	for (u32 i = 0; i < TC9564_CLOCK_COUNT; i++) {
+		const struct tc9564_clock_init *clock_init;
+		struct clk_init_data init = { };
+		struct tc9564_clock *clock;
+
+		clock_init = &tc9564_clock_init[i];
+		if (!clock_init->name)
+			continue;
+
+		init.name = clock_init->name;
+		init.ops = &tc9564_clk_ops;
+
+		clock = &clocks->clocks[i];
+		clock->hw.init = &init;
+
+		ret = devm_clk_hw_register(dev, &clock->hw);
+		if (ret) {
+			dev_err(dev, "failed to register clock \"%s\"\n",
+				init.name);
+			return ERR_PTR(ret);
+		}
+
+		clock->which = i;
+		clock->offset = clock_init->offset;
+		clock->mask = clock_init->mask;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, tc9564_clk_hw_get, clocks);
+	if (ret) {
+		dev_err(dev, "failed to add clock hardware provider\n");
+		return ERR_PTR(ret);
+	}
+
+	return clocks;
+}
+
+static int tc9564_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tc9564_clocks *clocks;
+
+	if (!dev_of_node(dev))
+		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
+
+	clocks = tc9564_clk_init(dev);
+	if (IS_ERR(clocks))
+		return dev_err_probe(dev, PTR_ERR(clocks),
+				     "failed to initialize clocks\n");
+
+	/* Force all clocks to be initially disabled */
+	tc9564_clock_disable_all(clocks);
+
+	platform_set_drvdata(pdev, clocks);
+
+	return 0;
+}
+
+static void tc9564_clk_remove(struct platform_device *pdev)
+{
+	struct tc9564_clocks *clocks = platform_get_drvdata(pdev);
+
+	/* Leave all clocks disabled when done */
+	tc9564_clock_disable_all(clocks);
+}
+
+static const struct of_device_id tc9564_clk_ids[] = {
+	{ .compatible = "toshiba,tc9564-clock" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tc9564_clk_ids);
+
+static struct platform_driver tc9564_clk_driver = {
+	.probe = tc9564_clk_probe,
+	.remove = tc9564_clk_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = tc9564_clk_ids,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(tc9564_clk_driver);
+
+MODULE_DESCRIPTION("Toshiba TC9564 Clock Driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

