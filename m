Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D649B5C4
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818658; cv=none; b=hSKAXZYbZNWCXbiQT/D9yoiXQrKix03R8cCFjlorY+l+nSPg5tCBnTk4H0F4m7NitX6lyeg+sjkPT4QlQozzkKRE2DIav/ahPwQ1fX2Oa5XFsIiNlmKQln/l6JfLKzs9dbAQRTEuCZdjuEcU68NUTSSdjy6C5rCoBYituLnuG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818658; c=relaxed/simple;
	bh=34BH/kSJpIh9KVJ+tsa/y9zB5T7tzYe3Y2diyiVZBeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ+wxeI4x0efusncCAVdeYgriFHa/4wyHfn5Bobiw6zqqhnqC5FIGuPdSJ9JBZncANBPORr8p9PBYZSboy/2bPkieUa7od6+goMSpDzdTuNHIedE233hg1bLExoaeSjm12suSr386V9LdHE9+5QBjZkWv1g3ht5RI9JKIjqAK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=xUs1YgUl; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="xUs1YgUl"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917a9f42283so24041806d6.0
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791818655; x=1792423455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NTDz500F18RPZt1gBA+qWVFTBIP+NbG64TbfQgFacE=;
        b=xUs1YgUl4M2L1pO9KGJWLumNkPzGrcXgX7KyHI5eKu2c5rrGW15ZaIx+uu2mH09VgD
         rKCzpoRa3q4JRvrGjNenaObXHcD/2VKGS+PqPgjxBP+5yHp0Xil2BxCAA0gRUNFBew2t
         M4cHqR9M220CEid1zyYZXjGS2h9QWjG7U4QOcvhPrK7hJcinoLAuQzq4p0iYNtiHPkw1
         z6OjdWeZx2OfL+q9fLboZmsD5KjRa8RtP3yvjdpn75Pe+pJBFLDx8PsnDA/5/qhf6hQO
         qwNglGYqbkcZUsPNJAt14Xx8834cKuKxVTVdazXFAbIOH3pdoXw3bJA/vHHoUytXG+Sb
         omYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818655; x=1792423455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NTDz500F18RPZt1gBA+qWVFTBIP+NbG64TbfQgFacE=;
        b=GdcisfPSJN9ItebGSJNUb+zni0xKmj4h0WeD8o2izneTSwcCbFEBLbHchic4q6yoWU
         nqvhddnDt4NJECxy3ar2DMaFMaL/S4fOmspA2SWYIVL0EccAGL+qQs/K79S+6qyFj9+B
         ojYQ5bpEmCubYtbumtLPEmf0maWp2+s93JnGmjUOhyZJAU2tDs7n8linHTfajoNE20f3
         XBJBWDVk1GPEpvAAM3HHmVuepn0Uqy9UIznSdioO6CwPA5ieQmriR8iiF2LsLxC9kEBK
         5E3wl4uuWoiU8XkTlQSTYjMjcTWbLrTYVQErO6m69K484HK6w0n9U8dc6vWNRXOyVix6
         A0Pw==
X-Forwarded-Encrypted: i=1; AKwUvByn6pEWiObN8xmvjrPYXoHS3O3F3UAEoDmXr6QWe1hbeJnIHwAB2kmdv7k+tgm+hRgh8zmB9jgKl9+Xsnc5vt4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzKmc74EMjcRMDTzhXm4HM4uySkInf3uoqVTbibDluRO/gnlKJ
	jK6AK2maBo3XTO/Wn5AfN57FV5CCJIlauMRulz6RcrYW3Bxg6LxjTz/3SoJYAZcXZok=
X-Gm-Gg: AYBFou3ehcINdpyvcULwxiLM2IeFodztDbRS5ckK9AbsCSt2iEskUIdBAnVa/2o9tbM
	uXu9fZEBjbITG95hhlK3h3crOJ8N7CZCMsXEXpNvMZpuVVkdFVuMRd7+6zf014jJp8Yy6MHJGDZ
	RcfhYGhetej58YGwzx9oOyrYWVlIVAR26F0jmB21yLOIhT6VKfAKoVCr1bcm70wb6NXcwf5u2RZ
	WSWEYCfhiGsdzz9n7AA+uzMJFY2H5MSRgcgZpRguZu/qiyB+qqJfoHLcT84kahu6j6mpiuSjOEX
	usz26HSWbKwaYLhkdOZF9+QewvH+7s/znL5aP3zHYydA35qfS4EDtGeOjbawdIIlygE3mlqBWVd
	UFwS+OF6Hu1iPOa06Gzz14nUxGj5LCoqY3Z5CAOFU23TTgbUkqMtFb7+nU4P+CK8h+LIWGf0gyi
	p+TxouXOOmxv9udpEm0kHX0dhI119lWQAb02Em37s+JBw8H0YahGlmKQ7INftl25mNY/LhTKOf/
	1Kjs55kdQBOVw==
X-Received: by 2002:a05:6214:2e45:b0:91b:5d3a:f128 with SMTP id 6a1803df08f44-91b5d3af46dmr162013036d6.51.1791818655135;
        Mon, 12 Oct 2026 08:24:15 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97178de2sm659086d6.0.2026.10.12.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:24:14 -0700 (PDT)
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
	Brian Masney <masneyb@kernel.org>,
	Daniel Thompson <daniel@riscstar.com>
Subject: [PATCH v3 2/4] clk: toshiba: introduce a TC9564 SoC clock driver
Date: Mon, 12 Oct 2026 10:24:05 -0500
Message-ID: <20261012152408.3729237-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012152408.3729237-1-elder@riscstar.com>
References: <20261012152408.3729237-1-elder@riscstar.com>
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

Reviewed-by: Brian Masney <masneyb@kernel.org>
Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - The clock driver now gets its regmap by calling syscon_node_to_regmap()
      on its device parent's devicetree node
    - The clock driver now must get its parent clock from devicetree
    - Added Brian's Reviewed-by tag to the second patch

 MAINTAINERS              |   1 +
 drivers/clk/Kconfig      |  12 ++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-tc9564.c | 268 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 282 insertions(+)
 create mode 100644 drivers/clk/clk-tc9564.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b19c62eabaa7e..20e076fc6221c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28171,6 +28171,7 @@ M:	Alex Elder <elder@kernel.org>
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
index 0000000000000..09a4f6a144fd9
--- /dev/null
+++ b/drivers/clk/clk-tc9564.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
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
+	regmap = syscon_node_to_regmap(dev_of_node(dev->parent));
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
+	struct clk *clk;
+
+	if (!dev_of_node(dev))
+		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get input clock\n");
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

