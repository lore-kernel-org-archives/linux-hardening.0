Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793617549;
	b=nrLrAXHZq+zckhJp46gHAZT8q6LtMBlT5WbDQ5QqQ+5nPDbJ2u8L0hkZ2t6IyUbfgCCE
	 rjTbrj2pNIILpv0j7O5j02hX/HR7mR/fJ9GkqufbkpbPJ2XxEKLyLsJT4cTY1nPbbXRF2
	 U9rXIQV6TBdLgJav3Cl2SDx/vIttE+EGRbYn0QcqYYQ3GkdAvpLYv1bK6NbNyggpYKAj0
	 /hcc8+LF1Z52SFKB3Mmy9+1NyDc/oQL1/FxLh/Up0o3f++l77jEVUMXKSw89YpOv4Kb9l
	 1HrGKQwA+WwJAiWNYKuxTDNeE/l5YOpKk2S0+AKMRgJWvOdIVnz0jeBYPCwqa/+A3fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1gXvMn+1f8fv3L0rLVW7vYv/X9QFHtlPWhpk8YRVpL0=;
	b=TnZUZLwf3ySBv+GdAaP9H/Gg9liHazDFWVkJtIr+jI8B1yg15qfgwcXeCjTAlntqxQNB
	 I5DYbuY6uS9JHCRW2qQ56Sx03BKboga9caaTTZmBtflNTCubJcCnjKQ/kg9ESB3qU5zBD
	 eMVdKlcpdPcG+gs7ztVXcv/wGXxFDCKtBr1Gh2zUWDcreL3BRTQpBuIwmjBCMJCjDDWst
	 FcqvSsyiocd3LbacVve29PDjgRId8JIRF6wNss3mOxl+0CsPAN+um03if6ovAB7OeSjkp
	 YnmZYJc0q4wNQds3MosVP5UPZcdVFV292zzLJIY9v/TGDMA7NofcDgP5fWHiWUN+0ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXuVGD3O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF3606A332;
	Mon,  2 Nov 2026 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXuVGD3O
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793617549;
	b=2E9fjyujsyXS0BxHeSy0p6VWUo/mLNEIhofgjHwIjjoBotA3n3nLfYLxPumBZFQiM6Oo
	 gCRbeyKCBdXVx344pYuhPdqFNGfvNXhlbaibM2e6pKXc7Nf9Ug1mYs3d4T/EyCHXl5SMy
	 LA4KajEQdhezDnDjLcFJt7NuZW8vw24m2k8oDlw9g6OVyfN6FN2xdCT5Z/zhICMYtoiKh
	 rMngGslCkOowil1CyAW5glkHQzCBI/2LBmWYOREuvUZNLm29I3qQggsYkaqcV189D55a3
	 SINpqx7JOZ31Tv55bpDmmitbM2rvkcLE1odgZoDq6R4OxrBYOgL2PW9csYI7IKwLZlg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793617549;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1gXvMn+1f8fv3L0rLVW7vYv/X9QFHtlPWhpk8YRVpL0=;
	b=Oha8fDMu9549BwKFZgxZ3/WMmk4+o8uGOJuVjxY3XsLbGdw95fCwOkgVzV0wsG5TboGK
	 cV0fAT8Unceegn+2GwzV90dR8qTdKaaH1OeGSMM8SsS90YzRu36CHcVhwNKTQ/Z3hLRzj
	 4uH+N6tZS5ZVwWsWHOipv8M8jTm7ux63lgPCzfZx5/6YTd8RoowNY43q7Tdr+f7LXtJdk
	 Ns00vjNpmVnkYVVMVkl+Kh2eoRA4DFhec4CH5q8zTiDRNYFROTGimG4UhDK3gaXowWOF9
	 lAmESmlAWL5aTyHjslgZAgwRhHhhwjbhT18je1iNNRQwcC/tDMl1o+zckrEt8RYz8Wg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BFDFB1F00A18;
	Mon,  2 Nov 2026 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793617549;
	bh=1gXvMn+1f8fv3L0rLVW7vYv/X9QFHtlPWhpk8YRVpL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kXuVGD3OHu8RlAwy86QpVT6v1cG2H+FeLLMBlbWtXtF0bi8neuol/BYGzu7ks+PHi
	 gryalbfA+HfkWBvEEsqG7hB4os66RNSLQOjvPke/QJM8c+0JpmlGkcbKbqH5B9iXAY
	 IPi7BCNLkxqHjC5GIP5TNKAijudNXXvd3meksJe+GR9rOOTCXGZFRpsEKi9WT4eo/P
	 RIVSq0wwycykhPO065rWq/cTipE+UBjEQ1/bmhrKtXqrU4yVZQw+xlC1+4NSPQyEuO
	 nIoKPQCYRQYf3/FHsKvBCs9bRyMfAyNpDOL4cI47o8pQ8H1GHGSPNr8gds8LOsoliy
	 DwQJsy/+1Cewg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 33546464A8;
	Mon,  2 Nov 2026 11:05:47 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Date: Mon, 02 Nov 2026 19:05:39 +0800
Subject: [PATCH v2 1/2] i3c: master: svc: Add amlogic a9 support
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-a9_i3c-v2-1-0c474bfccffa@amlogic.com>
References: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
In-Reply-To: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev, 
 linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com, 
 Kelvin.Zhang@amlogic.com, Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793617545; l=9410;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=7CfYTekWIAFas732u48MPAxkQ3RDxZfnMaGiwqp9I/Q=;
 b=8sMtNxgKxdYjvtePlRt7pKpQySX5pz7B8La2kTA6G8X1QGgIETyr+AwYhwBSCFSub4WcJEDe+
 Y4MBTakuUYNA75u61uzZ6+SHVVpnqMqwnouYTQ8CmoW4eo3V6RiUX11
X-Developer-Key: i=junyi.zhao@amlogic.com; a=ed25519;
 pk=hiL5PjGIksGFiWvEx9J3MhQqU/ro6vNbj72NIw4bbvA=
X-Endpoint-Received: by B4 Relay for junyi.zhao@amlogic.com/20260924 with
 auth_id=1054
X-Original-From: Junyi Zhao <junyi.zhao@amlogic.com>
Reply-To: junyi.zhao@amlogic.com
Content-Transfer-Encoding: 7bit

From: Junyi Zhao <junyi.zhao@amlogic.com>

Amlogic a9 SoCs integrate the Silvaco I3C IP, and their peripheral
clocks vary from the vanilla implementation:

  - The EE-domain controller (amlogic,a9-i3c) takes two clocks,
    "pclk" and "fast_clk", and the fast clock rate must be
    programmed before the controller can be used.

  - The AO-domain controller (amlogic,a9-ao-i3c) exposes only "pclk":
    its bus clock is generated by an internal divider located in the
    controller's own register space.

Add a vendor_init callback to handle this clock setup.
Add a vendor_quirks field to describe AO-specific behavior.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
---
 drivers/i3c/master/svc-i3c-master.c | 214 +++++++++++++++++++++++++++++++++++-
 1 file changed, 209 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e700392f0..98aa6eb0f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/completion.h>
 #include <linux/errno.h>
 #include <linux/i3c/master.h>
@@ -166,6 +167,21 @@
  */
 #define SVC_I3C_QUIRK_DAA_CORRUPT	BIT(2)
 
+/* Amlogic specific registers */
+#define AML_AO_I3C_FCLK_DIV_CTRL		0x304
+#define AML_AO_I3C_FCLK_DIV_EN_SHIFT		8
+#define AML_AO_I3C_FCLK_DIV_SHIFT		0
+#define AML_AO_I3C_FCLK_DIV_WIDTH		8
+#define AML_AO_I3C_FCLK_EN_SHIFT		9
+
+/*
+ * AML_I3C_QUIRK_AO:
+ * AO is the Always-On domain on Amlogic SoCs (remains powered in suspend).
+ * Its clock is generated by an internal divider located in the I3C
+ * controller own register space.
+ */
+#define AML_I3C_QUIRK_AO	BIT(0)
+
 struct svc_i3c_cmd {
 	u8 addr;
 	union {
@@ -195,10 +211,6 @@ struct svc_i3c_regs_save {
 	u32 mdynaddr;
 };
 
-struct svc_i3c_drvdata {
-	u32 quirks;
-};
-
 /**
  * struct svc_i3c_master - Silvaco I3C Master structure
  * @base: I3C master controller
@@ -257,6 +269,12 @@ struct svc_i3c_master {
 	u32 mctrl_config;
 };
 
+struct svc_i3c_drvdata {
+	u32 quirks;
+	u32 vendor_quirks;
+	int (*vendor_init)(struct svc_i3c_master *master);
+};
+
 /**
  * struct svc_i3c_i2c_dev_data - Device specific data
  * @index: Index in the master tables corresponding to this device
@@ -274,6 +292,11 @@ static inline bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
 	return (master->drvdata->quirks & quirk);
 }
 
+static inline bool vendor_has_quirk(struct svc_i3c_master *master, u32 quirk)
+{
+	return (master->drvdata->vendor_quirks & quirk);
+}
+
 static inline bool svc_has_daa_corrupt(struct svc_i3c_master *master)
 {
 	return ((master->drvdata->quirks & SVC_I3C_QUIRK_DAA_CORRUPT) &&
@@ -2011,6 +2034,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	if (!master->drvdata)
 		return -EINVAL;
 
+	master->dev = dev;
 	master->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(master->regs))
 		return PTR_ERR(master->regs);
@@ -2019,6 +2043,12 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	if (master->num_clks < 0)
 		return dev_err_probe(dev, -EINVAL, "can't get I3C clocks\n");
 
+	if (master->drvdata->vendor_init) {
+		ret = master->drvdata->vendor_init(master);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < master->num_clks; i++) {
 		if (!strcmp(master->clks[i].id, "fast_clk"))
 			break;
@@ -2036,7 +2066,6 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	if (master->irq < 0)
 		return master->irq;
 
-	master->dev = dev;
 	ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
 	if (ret)
 		return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
@@ -2163,9 +2192,184 @@ static const struct svc_i3c_drvdata npcm845_drvdata = {
 
 static const struct svc_i3c_drvdata svc_default_drvdata = {};
 
+/*
+ * Container for the tail clocks of the AO domain variant. The clock HW
+ * structures are registered with the clock framework and must stay alive
+ * for the whole driver lifetime, so they are kept along with the shared
+ * lock used by their gate/divider operations.
+ */
+struct aml_i3c_ao_clk {
+	struct clk_gate div_en;
+	struct clk_divider div;
+	struct clk_gate gate;
+	spinlock_t lock;
+};
+
+/*
+ * aml_ao_i3c_tail_clocks - register the internal divider chain that
+ * produces the AO variant's fast_clk, and append it to the clk bulk
+ * array as "fast_clk".  @parent must be "pclk", the only clock the AO
+ * variant exposes (see silvaco,i3c-master.yaml).
+ */
+static int aml_ao_i3c_tail_clocks(struct svc_i3c_master *master, struct clk *parent)
+{
+	struct device *dev = master->dev;
+	struct aml_i3c_ao_clk *ao;
+	struct clk_init_data init = {};
+	char name[64];
+	int ret;
+	struct clk_bulk_data *new_clks;
+	struct clk *fclk;
+
+	ao = devm_kzalloc(dev, sizeof(*ao), GFP_KERNEL);
+	if (!ao)
+		return -ENOMEM;
+
+	spin_lock_init(&ao->lock);
+
+	snprintf(name, sizeof(name), "%s#div_en", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_gate_ops;
+	init.flags = CLK_IGNORE_UNUSED;
+	init.parent_data = &(struct clk_parent_data) {
+		.index = -1,
+		.hw = __clk_get_hw(parent),
+	};
+	init.num_parents = 1;
+
+	ao->div_en.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
+	ao->div_en.bit_idx = AML_AO_I3C_FCLK_DIV_EN_SHIFT;
+	ao->div_en.hw.init = &init;
+	ao->div_en.lock = &ao->lock;
+
+	ret = devm_clk_hw_register(dev, &ao->div_en.hw);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register %s\n", name);
+
+	snprintf(name, sizeof(name), "%s#div", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_divider_ops;
+	init.flags = 0;
+	init.parent_data = &(struct clk_parent_data) {
+		.index = -1,
+		.hw = &ao->div_en.hw,
+	};
+	init.num_parents = 1;
+
+	ao->div.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
+	ao->div.shift = AML_AO_I3C_FCLK_DIV_SHIFT;
+	ao->div.width = AML_AO_I3C_FCLK_DIV_WIDTH;
+	ao->div.hw.init = &init;
+	ao->div.lock = &ao->lock;
+
+	ret = devm_clk_hw_register(dev, &ao->div.hw);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register %s\n", name);
+
+	snprintf(name, sizeof(name), "%s#gate", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_gate_ops;
+	init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
+	init.parent_data = &(struct clk_parent_data) {
+		.index = -1,
+		.hw = &ao->div.hw,
+	};
+	init.num_parents = 1;
+
+	ao->gate.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
+	ao->gate.bit_idx = AML_AO_I3C_FCLK_EN_SHIFT;
+	ao->gate.hw.init = &init;
+	ao->gate.lock = &ao->lock;
+
+	ret = devm_clk_hw_register(dev, &ao->gate.hw);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register %s\n", name);
+
+	fclk = devm_clk_hw_get_clk(dev, &ao->gate.hw, NULL);
+	if (IS_ERR(fclk))
+		return dev_err_probe(dev, PTR_ERR(fclk),
+				     "tail i3c fast clock failed\n");
+
+	new_clks = devm_kcalloc(dev,
+				master->num_clks + 1,
+				sizeof(*new_clks),
+				GFP_KERNEL);
+	memcpy(new_clks, master->clks,
+			master->num_clks * sizeof(*master->clks));
+	new_clks[master->num_clks].id = "fast_clk";
+	new_clks[master->num_clks].clk = fclk;
+	master->clks = new_clks;
+	master->num_clks++;
+
+	return 0;
+}
+
+static int aml_i3c_init(struct svc_i3c_master *master)
+{
+	struct device *dev = master->dev;
+	long fin_freq;
+	int ret, i;
+	struct clk *fclk;
+
+	if (vendor_has_quirk(master, AML_I3C_QUIRK_AO)) {
+		/*
+		 * clk_bulk_get_all() preserves the DT order, and the
+		 * binding restricts the AO variant to exactly one clock,
+		 * which is always "pclk".  So clks[0] is the input of the
+		 * internal divider chain.
+		 */
+		ret = aml_ao_i3c_tail_clocks(master, master->clks[0].clk);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < master->num_clks; i++) {
+		if (!strcmp(master->clks[i].id, "fast_clk"))
+			break;
+	}
+
+	if (i == master->num_clks)
+		return dev_err_probe(dev, -EINVAL,
+				     "can't get I3C fast clock\n");
+
+	fclk = master->clks[i].clk;
+	if (IS_ERR(fclk))
+		return PTR_ERR(fclk);
+
+	fin_freq = clk_round_rate(fclk, 25000000);
+	if (fin_freq <= 0) {
+		dev_err(dev, "invalid fast_clk\n");
+		return fin_freq ? fin_freq : -EINVAL;
+	}
+
+	ret = clk_set_rate(fclk, fin_freq);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "setting fast_clk rate failed\n");
+
+	return 0;
+}
+
+static const struct svc_i3c_drvdata aml_a9_drvdata = {
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
+		  SVC_I3C_QUIRK_FALSE_SLVSTART |
+		  SVC_I3C_QUIRK_DAA_CORRUPT,
+	.vendor_init = aml_i3c_init,
+};
+
+static const struct svc_i3c_drvdata aml_a9_ao_drvdata = {
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
+		  SVC_I3C_QUIRK_FALSE_SLVSTART |
+		  SVC_I3C_QUIRK_DAA_CORRUPT,
+	.vendor_quirks = AML_I3C_QUIRK_AO,
+	.vendor_init = aml_i3c_init,
+};
+
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
 	{ .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
+	{ .compatible = "amlogic,a9-i3c", .data = &aml_a9_drvdata },
+	{ .compatible = "amlogic,a9-ao-i3c", .data = &aml_a9_ao_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);

-- 
2.42.0


