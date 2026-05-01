Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217FA29A9FE
	for <linux-hardening@vger.kernel.org>; Fri,  1 May 2026 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608330; cv=none; b=aYlRWRw1Bt2LINcSTsgU8ZElb9oxeuUPAnnUqF8s2WE7NRyF+1YJwBGv1f4rWYlZa+2R57fkCdh6k4KNAkEB5M4YWCXqRVVska2vkqD7g8+7Im+b44XcpaAeR23pAu3TwlRtDvICxZuHMD2mEBPnosrNr7NPKoZHX3ePJuKg+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608330; c=relaxed/simple;
	bh=hk9menut7yraUPHKVzEP5HkssZqRW7XKvcYZoS6dtfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRUIzouun/lvB+3z5kRKOxxTXlySLFjHIsKd0y6noDOsFJ63nr976T/bWXzfZ/osQRfiNdGyjpt1r+Cjo6UIUu50MCrD/EvsHo9gy9el/M1i8fouy/x4XrZMkZBGNZmsGPf8hDWkqhvYszqUkF79j6LyHdQYrsgxNFzo+HaHZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl6b16dt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl6b16dt"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83178c0f29cso1096863b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 21:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608328; x=1778213128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NolRfXqrvWqre9Wtxu/jPySBcQ6D9Vpgy/nSf/fmvNk=;
        b=Nl6b16dtLgrpPe+vz/cpSt92ZsollC1dUl6Yyz+qXdWZlII2chW0txBXZDzQaxciMg
         VvUsfyi6grqSj6OhvPM/435KXyRANNQoqg+OcccVM7oFfneZByfzLJ/2zrgw0sGLvy8l
         URbS2+UXyaaT57NikiTjbnRJ0+xM7b0PSs6+QRkmlWVQQFb1/zuSWmagxssQPlX70cmX
         MGEcC2Le4Ck+Tl9H70AQItY2zwlA3Hhdj2pKm/QdPouVn9oeYBSMXVGLAvm4Y0n/Iqj0
         yBR/oTu8QRnHOIIKFHIjuHjYdsTf+cLvAAG1xOQg4vODDkfogb0V3bsD67LfHrgPS+4W
         Evbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608328; x=1778213128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NolRfXqrvWqre9Wtxu/jPySBcQ6D9Vpgy/nSf/fmvNk=;
        b=HM1SkFeRif00B7fQBvWrOJFY0hI9hO6qF/sbX+uA9Ev5l4aZnXhgiyFwF7iPYA+fLw
         daljtlr70o+E3LBZPbdUvDjusubx177iyD1ej6XcYIIJDbf18wC3mc8/I35ht6uoBF6Z
         CmhAtjXFwwv78Qwohm7raUKeq/pFIGW+XvDm0i3HUD0mVXruebOslaGJwfX/p2T2i7Aa
         4LqmYkfwmOxhbuJEZE+s0NmZJX7rxp67D5LEQ61ZUNZfZW03A4QzGPnnF0UiYyMla0MW
         ip0H3Ljlg/vofbC3l6EJn5QCvOJV0My/bOJfQtHZCrAdyjabJHGaE2mu7w5Xvb7uiJkW
         /gRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FQ5jEtnV9ZxSLFbVOaNs6OBM0gDhLmQQfVjrCG8URGZ0U7ahicdMfpAPKQwu05nMWyt1ypSYkpS4GLO13ZPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5f1pYXOwYRV8iAneTSz3mi2FL1/OBoT/Vf42KoNgMDI4MoKKe
	ESNLRdo8PL1U6PADwl2HorqHgE9+8nfXcC+Jji2gmJrJbyaLKBzg79ewnyfMW+Ul
X-Gm-Gg: AeBDiev9rC5d+wZ3OtQcaoq2Topgbh3RHD7wv+aOvkL5/UFgXHTPuFIhJv+yuxOntQr
	Tx7B6fDl1ENEr+FSu4hG6sKzMulkgnUnnzWGsX8QJcdb9uthx0TeRnK4f/o1Cf3PJarwZE18t/D
	W1HhqWXIU4qaZ6emQvcCENHlwDxUp6VvPaIb5ZIOPl2i8nzJbMnYkValk9pVLTS5nEJQnDD3Q0N
	Os7XQmLIFrYlFigvHMC+cPEB+G5CyMQlePbnC2DeXuky21OEeVLVyRpNwPT5KcfoEOj3c1F6FDe
	1BShKLw2pfQjhhpexAppRZ/yVC5jBJnDdgTFnOuqKd9oa5thLa9X8/AR5JnNtmSNOUJljWgw27w
	kH/OItGgkE8MqG8nqCjjYy2HXfdoZHK/gjqugD1lz5HSc/IgRaMUak6n0ojQsCJmzGcZ8I6t74i
	LjusJEzhyTWnrq8qvglM83WZXp5ROzufAn2A==
X-Received: by 2002:a05:6a00:1405:b0:82f:6858:3f6 with SMTP id d2e1a72fcca58-834fd9b5711mr6791526b3a.0.1777608328272;
        Thu, 30 Apr 2026 21:05:28 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582dd55sm1182119b3a.1.2026.04.30.21.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 21:05:27 -0700 (PDT)
Date: Fri, 1 May 2026 12:05:17 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Ze Huang <huang.ze@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alex Elder <elder@riscstar.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] phy: spacemit: Add USB3/PCIe comb PHY driver for
 Spacemit K3
Message-ID: <afQj0ZaVx9gvx5YF@inochi.infowork>
References: <20260430022843.1090138-1-inochiama@gmail.com>
 <20260430022843.1090138-3-inochiama@gmail.com>
 <DI6BHTW4FFN1.2YLR7O1P8F0Y3@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DI6BHTW4FFN1.2YLR7O1P8F0Y3@linux.dev>

On Thu, Apr 30, 2026 at 03:39:51PM +0800, Ze Huang wrote:
> On Thu Apr 30, 2026 at 10:28 AM CST, Inochi Amaoto wrote:
> > The comb PHY on K3 requires to configure a syscon device for the
> > right mux configuration. And it requires calibration before any
> > usage.
> >
> > Add USB3/PCIe comb PHY driver for Spacemit K3.
> >
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/phy/spacemit/Kconfig          |  16 ++
> >  drivers/phy/spacemit/Makefile         |   2 +
> >  drivers/phy/spacemit/phy-k3-combphy.c | 250 ++++++++++++++++
> >  drivers/phy/spacemit/phy-k3-common.c  | 398 ++++++++++++++++++++++++++
> >  drivers/phy/spacemit/phy-k3-common.h  |  27 ++
> >  5 files changed, 693 insertions(+)
> >  create mode 100644 drivers/phy/spacemit/phy-k3-combphy.c
> >  create mode 100644 drivers/phy/spacemit/phy-k3-common.c
> >  create mode 100644 drivers/phy/spacemit/phy-k3-common.h
> >
> > diff --git a/drivers/phy/spacemit/Kconfig b/drivers/phy/spacemit/Kconfig
> > index 50b0005acf66..5fdf18fce499 100644
> > --- a/drivers/phy/spacemit/Kconfig
> > +++ b/drivers/phy/spacemit/Kconfig
> > @@ -23,3 +23,19 @@ config PHY_SPACEMIT_K1_USB2
> >  	help
> >  	  Enable this to support K1 USB 2.0 PHY driver. This driver takes care of
> >  	  enabling and clock setup and will be used by K1 udc/ehci/otg/xhci driver.
> > +
> > +config PHY_SPACEMIT_K3_COMMON_OPS
> > +	tristate
> > +	select MFD_SYSCON
> > +	select GENERIC_PHY
> > +
> > +config PHY_SPACEMIT_K3_COMBO_PHY
> > +	tristate "SpacemiT K3 USB3/PCIe PHY support"
> > +	depends on (ARCH_SPACEMIT || COMPILE_TEST) && OF
> > +	depends on COMMON_CLK
> > +	select PHY_SPACEMIT_K3_COMMON_OPS
> > +	help
> > +	  Enable this to support K3 USB3/PCIe combo PHY driver. This
> > +	  driver takes care of enabling and clock setup and will be used
> > +	  by K3 dwc3 driver.
> > +	  If unsure, say N.
> > diff --git a/drivers/phy/spacemit/Makefile b/drivers/phy/spacemit/Makefile
> > index a821a21d6142..41be7b0388da 100644
> > --- a/drivers/phy/spacemit/Makefile
> > +++ b/drivers/phy/spacemit/Makefile
> > @@ -1,3 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-$(CONFIG_PHY_SPACEMIT_K1_PCIE)		+= phy-k1-pcie.o
> >  obj-$(CONFIG_PHY_SPACEMIT_K1_USB2)		+= phy-k1-usb2.o
> > +obj-$(CONFIG_PHY_SPACEMIT_K3_COMBO_PHY)		+= phy-k3-combphy.o
> > +obj-$(CONFIG_PHY_SPACEMIT_K3_COMMON_OPS)	+= phy-k3-common.o
> > diff --git a/drivers/phy/spacemit/phy-k3-combphy.c b/drivers/phy/spacemit/phy-k3-combphy.c
> > new file mode 100644
> > index 000000000000..66fa6330ad6e
> > --- /dev/null
> > +++ b/drivers/phy/spacemit/phy-k3-combphy.c
> > @@ -0,0 +1,250 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * phy-k3-usb3.c - SpacemiT K3 Type-C Orientation Switch Driver
> > + *
> > + * Copyright (c) 2025 SpacemiT Technology Co. Ltd
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/io.h>
> 
> ...
> 

> > +
> > +	phy->apb_spare = syscon_regmap_lookup_by_phandle(node, "spacemit,apb-spare");
> > +	if (IS_ERR(phy->apb_spare))
> > +		return dev_err_probe(dev, PTR_ERR(phy->apb_spare),
> > +				     "Failed to fine APB SPARE syscon");
> 
> typo, s/fine/find
> 
> > +
> > +	apmu = syscon_regmap_lookup_by_phandle_args(node, "spacemit,apmu", 1, &config);
> > +	if (IS_ERR(apmu))
> > +		return dev_err_probe(dev, PTR_ERR(phy->apb_spare),
> > +				     "Failed to fine APMU syscon");
> 
> 1. typo, s/fine/find
> 2. PTR_ERR(phy->apb_spare) should be PTR_ERR(apmu)
> 

Thanks for pointing that

> > +
> > +	ret = k3_comb_phy_update_config(apmu, config);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to set lane configuration");
> > +
> > +	phy->dev = dev;
> > +	platform_set_drvdata(pdev, phy);
> > +
> > +	ret = k3_phy_calibrate(phy->apb_spare);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to calibrate phy");
> > +
> > +	ret = k3_comb_phy_init_lanes(phy, config);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to init lanes");
> > +
> > +	provider = devm_of_phy_provider_register(dev, k3_comb_phy_xlate);
> > +	if (IS_ERR(provider))
> > +		return dev_err_probe(dev, PTR_ERR(provider),
> > +				     "Failed to register provider\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id k3_comb_phy_of_match[] = {
> > +	{ .compatible = "spacemit,k3-comb-phy" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, k3_comb_phy_of_match);
> > +
> > +static struct platform_driver k3_comb_phy_driver = {
> > +	.probe = k3_comb_phy_probe,
> > +	.driver = {
> > +		.name = "spacemit,k3-comb-phy",
> > +		.of_match_table = k3_comb_phy_of_match,
> > +	},
> > +};
> > +module_platform_driver(k3_comb_phy_driver);
> > +
> > +MODULE_DESCRIPTION("SpacemiT K3 USB3/PCIe comb PHY driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/phy/spacemit/phy-k3-common.c b/drivers/phy/spacemit/phy-k3-common.c
> > new file mode 100644
> > index 000000000000..77c4b4073b96
> > --- /dev/null
> > +++ b/drivers/phy/spacemit/phy-k3-common.c
> > @@ -0,0 +1,398 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/usb.h>
> > +
> > +#include <dt-bindings/phy/phy.h>
> > +
> > +#include "phy-k3-common.h"
> > +
> > +/* PHY Registers */
> > +#define PHY_VERSION			0x0
> > +
> > +#define PHY_RESET_CFG			0x04
> > +
> > +#define PHY_RESET_RXBUF_RST		BIT(0)
> > +#define PHY_RESET_SOFT_RST_PCS		BIT(1)
> > +#define PHY_RESET_SOFT_RST_AHB		BIT(2)
> > +#define PHY_RESET_EN_SD_AFTER_LOCK	BIT(6)
> > +
> > +#define PHY_CLK_CFG			0x08
> > +
> > +#define PHY_CLK_PLL_READY		BIT(0)
> > +#define PHY_CLK_TXCLK_INV		BIT(2)
> > +#define PHY_CLK_RXCLK_EN		BIT(3)
> > +#define PHY_CLK_TXCLK_EN		BIT(4)
> > +#define PHY_CLK_PCLK_EN			BIT(5)
> > +#define PHY_CLK_PIPE_PCLK_EN		BIT(6)
> > +#define PHY_CLK_REFCLK_FREQ		GENMASK(10, 7)
> > +#define PHY_CLK_REFCLK_24M		2
> > +#define PHY_CLK_SW_INIT_DONE		BIT(11)
> > +#define PHY_CLK_PU_SSC_OUT		BIT(23)
> > +
> > +#define PHY_MODE_CFG			0x0C
> > +
> > +#define PHY_MODE_PCIE_INT_EN		BIT(0)
> > +#define PHY_MODE_LFPS_TPERIOD		GENMASK(9, 8)
> > +#define PHY_MODE_LFPS_TPERIOD_USB	3
> > +
> > +#define PHY_PU_SEL			0x40
> > +
> > +#define PHY_PU_CFG_STATUS		BIT(9)
> > +#define PHY_PU_OVRD_STATUS		BIT(10)
> > +
> > +#define PHY_PU_CK_REG			0x54
> > +
> > +#define PHY_PU_REFCLK_100		BIT(25)
> > +
> > +#define PHY_PLL_REG1			0x58
> > +
> > +#define PHY_PLL_FREF_SEL		GENMASK(15, 13)
> > +#define PHY_PLL_FREF_24M		0x1
> > +#define PHY_PLL_SSC_DEP_SEL		GENMASK(27, 24)
> > +#define PHY_PLL_SSC_5000PPM		0xa
> > +#define PHY_PLL_SSC_MODE		GENMASK(29, 28)
> > +#define PHY_PLL_SSC_MODE_CENTER_SPREAD	0
> > +#define PHY_PLL_SSC_MODE_UP_SPREAD	1
> > +#define PHY_PLL_SSC_MODE_DOWN_SPREAD	2
> > +#define PHY_PLL_SSC_MODE_DOWN_SPREAD1	3
> > +
> > +#define PHY_PLL_REG2			0x5c
> > +
> > +#define PHY_PLL_SEL_REF100		BIT(21)
> > +
> > +/* PHY RX Register Definitions */
> > +#define PHY_RX_REG_A			0x60
> > +
> > +#define PHY_RX_REG0_RLOAD		BIT(4)
> > +#define PHY_RX_REG1_RTERM		GENMASK(11, 8)
> > +#define PHY_RX_REG1_RC_CALI		GENMASK(15, 12)
> > +#define PHY_RX_REG2_CSEL		GENMASK(19, 16)
> > +#define PHY_RX_REG2_FORCE_CSEL		BIT(20)
> > +#define PHY_RX_REG2_PSEL		GENMASK(23, 21)
> > +#define PHY_RX_REG3_I_LOAD		GENMASK(26, 24)
> > +#define PHY_RX_REG3_SEL_CBOOST_CODE	BIT(27)
> > +#define PHY_RX_REG3_ADJ_BIAS		GENMASK(29, 28)
> > +#define PHY_RX_REG3_RDEG1		GENMASK(31, 30)
> > +
> > +#define PHY_RX_REG_B			0x64
> > +
> > +#define PHY_RX_REGB_MASK		GENMASK(23, 0)
> > +
> > +#define PHY_RX_REG4_RDEG2		GENMASK(2, 1)
> > +#define PHY_RX_REG4_ENVOS		BIT(4)
> > +#define PHY_RX_REG4_RTERM_SEL		BIT(5)
> > +#define PHY_RX_REG4_MANUAL_CFG		BIT(7)
> > +#define PHY_RX_REG5_RCELL_VCM		GENMASK(11, 8)
> > +#define PHY_RX_REG5_RCELL_BIAS		GENMASK(15, 12)
> > +#define PHY_RX_REG6_H1_REG		GENMASK(19, 16)
> > +#define PHY_RX_REG6_ADAPT_GAIN		GENMASK(21, 20)
> > +#define PHY_RX_REG6_BYPASS_ADPT		BIT(22)
> > +
> > +#define PHY_ADPT_CFG0			0x140
> > +#define PHY_ADPT_AFE_RST_OVRD_EN	BIT(1)
> > +#define PHY_ADPT_AFE_RST_OVRD_VAL	BIT(4)
> > +
> > +#define PHY_RXEQ_TIME			0xb4
> > +#define PHY_RXEQ_TIME_OVRD_POST_C_SOC	BIT(21)
> > +#define PHY_RXEQ_TIME_CFG_AMP_SOC	GENMASK(23, 22)
> > +#define PHY_RXEQ_TIME_AMP_SOC_650M	0
> > +#define PHY_RXEQ_TIME_AMP_SOC_800M	1
> > +#define PHY_RXEQ_TIME_AMP_SOC_870M	2
> > +#define PHY_RXEQ_TIME_AMP_SOC_900M	3
> > +#define PHY_RXEQ_TIME_OVRD_AMP_SOC	BIT(24)
> > +
> > +#define PCIE_PU_ADDR_CLK_CFG		0x0008
> > +#define PHY_CLK_PLL_READY		BIT(0)
> > +#define PCIE_INITAL_TIMER		GENMASK(6, 3)
> > +#define CFG_INTERNAL_TIMER_ADJ		GENMASK(10, 7)
> > +#define CFG_SW_PHY_INIT_DONE		BIT(11)
> > +
> > +/* Lane RX/TX configuration (per‑lane, at lane_base) */
> > +#define PCIE_RX_REG1			0x050
> > +#define PCIE_TX_REG1			0x064
> > +
> > +#define PCIE_PLL_TIMEOUT		500000
> > +#define PCIE_POLL_DELAY			500
> > +
> > +
> 
> ...
> 
> > +static int k3_pcie_phy_init(struct phy *phy)
> > +{
> > +	struct k3_lane_group *lg = phy_get_drvdata(phy);
> > +	void __iomem *phy_base = lg->base + lg->data->offsets[0];
> > +	u32 val;
> > +	int ret;
> > +	int i;
> > +
> > +	val = readl(phy_base + PHY_PLL_REG1);
> > +	val = u32_replace_bits(val, 0x2, GENMASK(15, 12));
> > +	writel(val, phy_base + PHY_PLL_REG1);
> > +
> > +	val = readl(phy_base + PHY_PLL_REG2);
> > +	val = u32_replace_bits(val, 0, BIT(21));
> > +	writel(val, phy_base + PHY_PLL_REG2);
> > +
> > +	for (i = 0; i < lg->data->lanes; i++) {
> > +		void __iomem *lane_base = lg->base + lg->data->offsets[i];
> > +
> 
> > +		val = readl(lane_base + PCIE_RX_REG1);
> > +		val = u32_replace_bits(val, 0, 0x3);
> > +		writel(val, phy_base + PCIE_RX_REG1);
> 
> This looks like a copy-paste bug.
> 
> Read from lane_base but write the modified value to phy_base.
> 

Yes, it should be the lane_base.

> > +	}
> > +
> > +	val = readl(phy_base + PHY_PLL_REG2);
> > +	val |= BIT(20);
> > +	writel(val, phy_base + PHY_PLL_REG2);
> > +
> 
> > +	writel(0x00006505, phy_base + PCIE_RX_REG1);
> 
> Is it intentional? The loop above configured PCIE_RX_REG1, while the
> hard-coded 0x00006505 overwrites what's done for lane0.
> 

Yes, the logic is coming from vendor.

> > +
> > +	/* pll_reg1 of lane0, disable SSC: pll_reg4[3:0] = 0 */
> > +	val = readl(phy_base + PHY_PLL_REG1);
> > +	val = u32_replace_bits(val, 0, GENMASK(27, 24));
> > +	writel(val, phy_base + PHY_PLL_REG1);
> 
> A little confusing here, comment says "pll_reg4[3:0] = 0" but the code is
> modifying PHY_PLL_REG1[27:24]
> 

I think this is is a mistake from the vendor code. IIRC, the
reg4 may could be the [31:24]. As it is divided into four parts.

> > +
> > +	for (i = 0; i < lg->data->lanes; i++) {
> > +		void __iomem *lane_base = lg->base + lg->data->offsets[i];
> > +
> > +		/* set cfg_tx_send_dummy_data to be 1'b1 for disable dash data */
> > +		val = readl(lane_base + PHY_PU_SEL);
> > +		val = u32_replace_bits(val, 1, BIT(13));
> > +		writel(val, lane_base + PHY_PU_SEL);
> > +
> > +		/* disable en_sample_data_after_cdr_locked */
> > +		val = readl(lane_base + PHY_RESET_CFG);
> > +		val = u32_replace_bits(val, 0, BIT(6));
> > +		writel(val, lane_base + PHY_RESET_CFG);
> > +
> > +		/* Dynamic Lock */
> > +		val = readl(lane_base + PHY_MODE_CFG);
> > +		val = u32_replace_bits(val, 1, BIT(2));
> > +		writel(val, lane_base + PHY_MODE_CFG);
> > +
> > +		val = FIELD_PREP(GENMASK(7, 0), 0x10) |
> > +			FIELD_PREP(GENMASK(15, 8), 0x78) |
> > +			FIELD_PREP(GENMASK(23, 16), 0x98) |
> > +			FIELD_PREP(GENMASK(31, 24), 0xdf);
> > +		writel(val, lane_base + PHY_RX_REG_A);
> > +
> > +		val = readl(lane_base + PHY_RX_REG_B);
> > +		val &= ~PHY_RX_REGB_MASK;
> > +		val |= FIELD_PREP(GENMASK(7, 0), 0xb4) |
> > +			FIELD_PREP(GENMASK(15, 8), 0x88) |
> > +			FIELD_PREP(GENMASK(23, 16), 0x28);
> > +		writel(val, lane_base + PHY_RX_REG_B);
> 
> Can we define macros for these values? Just like you did for
> PHY_CLK_CFG.
> 

We can, but I guess this makes no sense. As no detailed document
about these magic numbers, there is no meaningful name for
these numbers and fields.....

Regards,
Inochi

> > +
> > +		/* Set init done */
> > +		val = readl(lane_base + PCIE_PU_ADDR_CLK_CFG);
> > +		val = u32_replace_bits(val, 1, CFG_SW_PHY_INIT_DONE);
> > +		writel(val, lane_base + PCIE_PU_ADDR_CLK_CFG);
> > +	}
> > +
> > +	ret = readl_poll_timeout(phy_base + PCIE_PU_ADDR_CLK_CFG, val,
> > +				 (val & PHY_CLK_PLL_READY), PCIE_POLL_DELAY,
> > +				 PCIE_PLL_TIMEOUT);
> > +	if (ret) {
> > +		dev_err(&lg->phy->dev, "PHY PLL lock timeout\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
