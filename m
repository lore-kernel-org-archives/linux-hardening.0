Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183451A752
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750373; cv=none; b=CZ2KIyGf/MK6ibcbcfDJaUmmG56AJK4nuY9IQEYxr/nS4SE0iYbRFlygRC4kWfRbnsu27W0vm0cHVO9mWd5LDi9NKHDs6YeNjf1Lt+YmPzb+auED9hzgA2/Gxe6GchxGlhVG8104TqQQ5WqoNleZnMD0i0khbzGzNdKoeR9eSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750373; c=relaxed/simple;
	bh=cgdTIsvLN3k4z3Fy399y3RouzNXlDfdM4GxnaFqKo1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euigQBnYNz59vX4SM5RRY5Wnuwm4dJvPVRlNL067jzI4ZLit4m3ZWHpG66gpGxENI0HVW33SwoSZ6ygp4DZ1PGwNyA7c3qkmThh/DNKIFfwnAn65huKRKlLsh6MPGYEcusDor0SQdNGVjyF0arkU4d9NBbkjAj1coOJgUqvsHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ZGuBLRhE; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ZGuBLRhE"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76906adso12006061cf.0
        for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789750363; x=1790355163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gz0Z8UG5CcnMHKyka9HjZDC5AoEUzK6J1rcdnedS7dE=;
        b=ZGuBLRhEWxWTofIWK9EjJQXgcSEQTXyA69bDSRqmg90Hdp6XXFj7PA2J4ra1QqC1fi
         KmMaH9+EaT5qZtxfexMRB0/LrdSdI1mxYKk1wzpQPROE/18Qjx6qhRtA2lO1jtAAagvc
         rq3lfn0x6jY+CFVBJzfsnRTRFQgENQvHhct+hDxDj0DBp0ZfJv5xNpVjsQ9S2IG4JXBx
         VmMbE5f0k4m4PoTIgj/hew+TAOL454A0D6vWp7UPwVYGk8jt6qUzQdxFgXfjLAWC8JRM
         +KC384/g2hoOAC9WLAdOzFmHwLAZDXhxpP+c1BUvknMRfMq6zj42G9R9MeOzIpne3RRr
         74qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750363; x=1790355163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gz0Z8UG5CcnMHKyka9HjZDC5AoEUzK6J1rcdnedS7dE=;
        b=gqxwTUkfHign1JnumqUNIcNuI16XErmtaQZjy4D0Nm0i65yHUWYmCPLZPs8ZQx/zBX
         d/981NsCcmE0m8YmOdyNqfO4OWMukLL5It/GUIhiYZds65bWQnegFpd0Irrm5Xg8jbPK
         zTAglf9x3+Z+CNvJzqpWUwpGxxfb+KvTos1IC8pYnQ71A2GQk2jdj+FmfMaR8NBwmyZP
         y45Cjk+eJTcWPLeG/oNmUo7nbWZGtcpn/Y5CFJm8Yd2aoNuCp7reJkDW1uZ4PbGtkKE4
         GSIql7U5+91zK1jq/eGl9lzeM2yUffBYvsIjAD7+ULDHG3jPRTXf9018Kf8XTouWWqjb
         Bpqw==
X-Forwarded-Encrypted: i=1; AKwUvBwzDtnwmM3wk7N+i2kxpN+jJUJcfM4+bAo7C9Gvm5F85yDqaJauTjLLi2zSGt6dv2Yl4K9dQmBIT065fER3AW8=@vger.kernel.org
X-Gm-Message-State: AFuF++kb1rkBVL7fJCkj7CQ6/YXU+vs9e+uXpvG2Q25IqIwseYs+jSjp
	tqScfhFKwcFd/whEwG/A3Enp6Fj9KPCUSXYrdId0Wffc8I1ZJZ+DxC7sbs1a/MS7u8U=
X-Gm-Gg: AYBFou20ss2hvYa7/QiSZ/VIkMPjEccyywwiyj9buIPaGQ4oJ4Lh20kZMUMVR7Eivh4
	Z93gavzTFYjKHXJY3vg2Aggn3vY/+/NvcZVhsT7U0+c3fgqSeUBN8qSVC7O/sBCNQ29C07VB9Gr
	lDmo5cfXmMcCVMksxsRG+LCjzXW0psrfmA0eKkZyWrgxZB97O+tvFW/UEoO9j8I5+rE4f3mbgVh
	3z+dCbd9qYyqTEhoRHfti28Wk7N+3O1ncYqukbDz0fJWffvtaAkpH2x7h7EnEEqqBRQYDBLWeU1
	aRj4xN5gf1J7Qq/afEXMpAdPaIof0rxVcgBj2kGM/Qyz5WV0yYa6E7XOzxvPn40m7fVmCvUYKt9
	+9J9L1cQwIEbMKYNQNqyQvO+cnR5VFx+kXv0L2c+q6TKHXsydTAxjtqlQH1YhypC/V7HRHpg2Oj
	Xvmw51Lew6bwT3LolIt+agae1uQachBAJqHKmGh2TxwlJVWsIxpBmtxqPGuASiJPMoT32y2AXO6
	fvA
X-Received: by 2002:a05:620a:2587:b0:939:6dea:374c with SMTP id af79cd13be357-93bdc8cb85dmr437348985a.48.1789750362574;
        Fri, 18 Sep 2026 09:52:42 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0f0762dsm183582785a.39.2026.09.18.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:52:42 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	p.zabel@pengutronix.de
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] clk: toshiba: introduce a TC9564 SoC clock and reset driver
Date: Fri, 18 Sep 2026 11:52:32 -0500
Message-ID: <20260918165234.687224-4-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918165234.687224-1-elder@riscstar.com>
References: <20260918165234.687224-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a new platform driver that manages clock and reset signals
within the TC9564 SoC.  There are 21 clocks, which can only be
enabled and disabled, as well as 13 reset signals.

Two registers manage the state of the clocks and two others manage
the state of the resets.  The registers are accessed via a regmap
supplied by a system controller, which coordinates access to a
region of memory that will be shared with another driver.

Access to the memory region is provided via a BAR on a PCIe endpoint
function embedded in the TC9564 SoC.  For that reason, neither the
PCIe clock nor PCIe reset can be manipulated by this driver (they
are assumed always on and deasserted, respectively).

Similarly, control is not available for the I2C clock and reset,
because the PCIe subsystem on the TC9564 relies on I2C

Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 MAINTAINERS              |   1 +
 drivers/clk/Kconfig      |  11 ++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-tc9564.c | 366 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 drivers/clk/clk-tc9564.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 66d0e7e65adcb..39346a5cd9a7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27675,6 +27675,7 @@ M:	Alex Elder <elder@kernel.org>
 M:	Daniel Thompson <danielt@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
+F:	drivers/clk/clk-tc9564.c
 F:	include/dt-bindings/clock/toshiba,tc9564.h
 
 TOSHIBA TC9564 PCI DRIVER
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index f9592fd9ec2bb..50efa10d48450 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -292,6 +292,17 @@ config COMMON_CLK_S2MPS11
 	  clock. These multi-function devices have two (S2MPS14) or three
 	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
 
+config COMMON_CLK_TC9564
+	tristate "Toshiba TC9564 clock support"
+	depends on TC9564_PCI
+	default m
+	help
+	  This enables support for the clock and reset controller embedded
+	  in the Toshiba TC9564 (and Qualcomm QPS615) SoC.  The state of
+	  clock and reset lines is controlled by MMIO to a region managed
+	  by a system controller; this ensures access to the region is
+	  coordinated between this and other drivers.
+
 config CLK_TWL
 	tristate "Clock driver for the TWL PMIC family"
 	depends on TWL4030_CORE
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b18af485d7f03..a98ea8ff92066 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
 obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
 obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
 obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
+obj-$(CONFIG_COMMON_CLK_TC9564)		+= clk-tc9564.o
 obj-$(CONFIG_COMMON_CLK_TPS68470)      += clk-tps68470.o
 obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
 obj-$(CONFIG_CLK_TWL)			+= clk-twl.o
diff --git a/drivers/clk/clk-tc9564.c b/drivers/clk/clk-tc9564.c
new file mode 100644
index 0000000000000..4f900bc8994a7
--- /dev/null
+++ b/drivers/clk/clk-tc9564.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/clock/toshiba,tc9564.h>
+
+#define CLK_CTRL0_OFFSET	0x1004
+#define RST_CTRL0_OFFSET	0x1008
+#define CLK_CTRL1_OFFSET	0x100c
+#define RST_CTRL1_OFFSET	0x1010
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
+struct tc9564_reset {
+	u32 offset;		/* RST_CTRL0_OFFSET or RST_CTRL1_OFFSET */
+	u32 mask;		/* Zero means undefined reset */
+};
+
+struct tc9564_clocks {
+	struct device *dev;
+	struct regmap *regmap;
+	struct reset_controller_dev rcdev;
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
+#define TC9564_RESET_INIT0(_name, _bit)	__TC9564_RESET_INIT(_name, 0, _bit)
+#define TC9564_RESET_INIT1(_name, _bit)	__TC9564_RESET_INIT(_name, 1, _bit)
+
+#define __TC9564_RESET_INIT(_name, _reg, _bit)		\
+	[RESET_##_name] = {				\
+		.offset	= RST_CTRL ## _reg ## _OFFSET,	\
+		.mask = BIT(_bit),			\
+	}
+
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
+static const struct tc9564_reset tc9564_reset[] = {
+	TC9564_RESET_INIT0(MCU, 0),
+	TC9564_RESET_INIT0(MCU1, 1),
+	TC9564_RESET_INIT0(INTC, 4),
+	/* TC9564_RESET_INIT0(PCIE, 9), */
+	/* TC9564_RESET_INIT0(I2C, 12), */
+	TC9564_RESET_INIT0(UART, 16),
+	TC9564_RESET_INIT0(MSIGEN, 18),
+
+	TC9564_RESET_INIT0(MAC0_MAC, 7),
+	TC9564_RESET_INIT0(MAC0_PMA, 30),
+	TC9564_RESET_INIT0(MAC0_XPCS, 31),
+
+	TC9564_RESET_INIT1(MAC1_MAC, 7),
+	TC9564_RESET_INIT1(MAC1_PMA, 30),
+	TC9564_RESET_INIT1(MAC1_XPCS, 31),
+};
+#define TC9564_RESET_COUNT	ARRAY_SIZE(tc9564_reset)
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
+		dev_err(clk_hw_get_dev(hw), "invalid clock (%s id %u)\n",
+			enable ? "enable" : "disable", clock->which);
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
+	for (int i = 0; i < clocks->clock_count; i++) {
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
+	unsigned int i = clkspec->args[0];
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
+	size_t clocks_size;
+	int ret;
+
+	clocks_size = struct_size(clocks, clocks, TC9564_CLOCK_COUNT);
+	clocks = devm_kzalloc(dev, clocks_size, GFP_KERNEL);
+	if (!clocks)
+		return ERR_PTR(-ENOMEM);
+
+	clocks->dev = dev;
+	clocks->clock_count = TC9564_CLOCK_COUNT;
+
+	clocks->regmap = syscon_node_to_regmap(dev_of_node(dev->parent));
+	if (IS_ERR(clocks->regmap)) {
+		dev_err(dev, "failed to get config regmap\n");
+		return ERR_CAST(clocks->regmap);
+	}
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
+static const struct tc9564_clocks *
+rcdev_to_tc9564_clocks(struct reset_controller_dev *rcdev)
+{
+	return container_of_const(rcdev, struct tc9564_clocks, rcdev);
+}
+
+static int tc9564_reset_manage(struct reset_controller_dev *rcdev,
+			       unsigned long id, bool assert)
+{
+	const struct tc9564_clocks *clocks = rcdev_to_tc9564_clocks(rcdev);
+
+	if (id < rcdev->nr_resets) {
+		const struct tc9564_reset *reset = &tc9564_reset[id];
+		u32 mask = reset->mask;
+
+		if (mask)
+			return regmap_update_bits(clocks->regmap,
+						  reset->offset, mask,
+						  assert ? mask : 0);
+	}
+
+	dev_err(clocks->dev, "invalid reset (%sassert id %lu)\n",
+		assert ? "" : "de", id);
+
+	return -ENXIO;
+}
+
+static int tc9564_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return tc9564_reset_manage(rcdev, id, true);
+}
+
+static int tc9564_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return tc9564_reset_manage(rcdev, id, false);
+}
+
+static const struct reset_control_ops tc9564_reset_control_ops = {
+	.assert		= tc9564_reset_assert,
+	.deassert	= tc9564_reset_deassert,
+};
+
+static void tc9564_reset_assert_all(struct tc9564_clocks *clocks)
+{
+	for (u32 id = 0; id < TC9564_RESET_COUNT; id++)
+		if (tc9564_reset[id].mask)
+			tc9564_reset_manage(&clocks->rcdev, id, true);
+}
+
+static int tc9564_reset_init(struct tc9564_clocks *clocks)
+{
+	struct reset_controller_dev *rcdev = &clocks->rcdev;
+
+	rcdev->ops = &tc9564_reset_control_ops;
+	rcdev->owner = THIS_MODULE;
+	rcdev->dev = clocks->dev;
+	rcdev->of_node = dev_of_node(clocks->dev);
+	rcdev->nr_resets = TC9564_RESET_COUNT;
+
+	return devm_reset_controller_register(clocks->dev, rcdev);
+}
+
+static int tc9564_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tc9564_clocks *clocks;
+	int ret;
+
+	if (!dev_of_node(dev))
+		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
+
+	clocks = tc9564_clk_init(dev);
+	if (IS_ERR(clocks))
+		return dev_err_probe(dev, PTR_ERR(clocks),
+				     "failed to initialize clocks\n");
+
+	ret = tc9564_reset_init(clocks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize resets\n");
+
+	/* Force all resets to be initially asserted */
+	tc9564_reset_assert_all(clocks);
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
+	/* Leave all resets to be deasserted when done */
+	tc9564_reset_assert_all(clocks);
+
+	/* Leave all clocks disabled when done */
+	tc9564_clock_disable_all(clocks);
+}
+
+static const struct of_device_id tc9564_clk_ids[] = {
+	{ .compatible = "toshiba,tc9564-clock" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tc9564_clk_ids);
+
+static struct platform_driver tc9564_clk_driver = {
+	.probe	= tc9564_clk_probe,
+	.remove	= tc9564_clk_remove,
+	.driver	= {
+		.name		= KBUILD_MODNAME,
+		.of_match_table = tc9564_clk_ids,
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(tc9564_clk_driver);
+
+MODULE_DESCRIPTION("Toshiba TC9564 Clock and Reset Driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

