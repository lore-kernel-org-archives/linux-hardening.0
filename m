Received: from proxy41132.mail.163.com (proxy25212.mail.163.com [103.129.252.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C221767A;
	Tue,  8 Jul 2025 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.252.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955848; cv=none; b=F7fS2mMTOTCw4MFjICUPrP2jqnkgw2cU1kZZ1ovmY+8KxNFtTjiM+kXN+3btLfjXLKGziLGBmk6ts9GsRAOR58EENELe+MHOxPCN8oO/JfK6fWKx5asutHVLKtVPRXtiBQlvkl0xY55VfYJ7IoHWMP9ikQHkh2P+CPwspAFrz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955848; c=relaxed/simple;
	bh=/aKFYVrSUvb56OrqNRONfycO0dOcJVnNkjhGlPHQ+So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngxIusFWDPqdPrZeCvIYwNeKM5uW9gS5R1NNfDa5F8Zik9nlxx8kqPHK7oz7dm+y0H0T6YWd87tnvPJJ+TSYlIXuBi2AMlWdLMZXk7BACwog3hbhQgnw0wPTaxdD4Ke1agF9b3Zoo+3NLgXGioj/UiuGYzVTA/2+0wD6Y/Tz92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=l8Ad+qjC; arc=none smtp.client-ip=103.129.252.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="l8Ad+qjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=1v2q7A3eUCisKbSPt1sKWtN3/8W/h2oe/q3Dw5q7DbA=;
	b=l8Ad+qjCy82aky+IDRPtJ2/GWTwafOPkE7hBppz6+nzp9mKRqGXorBzUEdcxIU
	54SKcYocFTfyq4eBsoWm/+XxaZJ7ZGKv6gS33AfNHKBctgpPYayhj3/WfMNMz3Hc
	kDntGFtpwnVqgOBeqWRoEJ0Ow3hEYeR7tjkBkBCA7g3jk=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDHpsSruGxoCRxMAA--.47451S3;
	Tue, 08 Jul 2025 14:20:29 +0800 (CST)
Date: Tue, 8 Jul 2025 14:20:27 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>, Frank Li <Frank.Li@nxp.com>,
	Markus Niebel <Markus.Niebel@tq-group.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Michael Walle <mwalle@kernel.org>, Heiko Schocher <hs@denx.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Tim Harvey <tharvey@gateworks.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Andre Przywara <andre.przywara@arm.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Kever Yang <kever.yang@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Tobias Graemer <Tobias.Graemer@mt.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: freescale: Add Mettler-Toledo
 Snowflake V2 support
Message-ID: <aGy4qy1kN3RZ6nas@dragon>
References: <20250624110408.128283-1-Wojciech.Dubowik@mt.com>
 <20250624110408.128283-4-Wojciech.Dubowik@mt.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624110408.128283-4-Wojciech.Dubowik@mt.com>
X-CM-TRANSID:Mc8vCgDHpsSruGxoCRxMAA--.47451S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfJr17JF1UKrWrXF4UJr4ktFb_yoW8JFWkKo
	WY93WvkrW5K34UJ3WaqF12kr4UXFnYkrs7KayqyrW3Ja10yan8A3WfXw4qvF48t3W8tFyk
	WrW7Xa4rAay2vws5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYlksUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQ6O82hsuK4nRQAA3i

On Tue, Jun 24, 2025 at 01:04:01PM +0200, Wojciech Dubowik wrote:
> Add initial support for Mettler-Toledo Snowflake V2 terminal.
> The board is using Kontron SL i.MX 8M Mini SoM with 1GB RAM.
> 
> Supported board features:
> * 7" Display with touchscreen
> * RS-232
> * I2S Audio
> * SD-card/eMMC
> * USB
> 
> Signed-off-by: Tobias Graemer <Tobias.Graemer@mt.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mm-mt-snowflake-v2.dts  | 482 ++++++++++++++++++
>  2 files changed, 483 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 0b473a23d120..86f2f1580696 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -128,6 +128,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-iot-gateway.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-innocomm-wb15-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl-osm-s.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-mt-snowflake-v2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-mx8menlo.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-phg.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts b/arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts
> new file mode 100644
> index 000000000000..2bebf528ec37
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Mettler-Toledo GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm-kontron-sl.dtsi"
> +
> +/ {
> +	model = "Mettler Toledo i.MX8MM Snowflake V2";
> +	compatible = "mt,imx8mm-snowflake-v2", "kontron,imx8mm-sl",
> +		     "fsl,imx8mm";
> +
> +	chosen {
> +		stdout-path = &uart3;
> +	};
> +
> +	aliases {
> +		ethernet1 = &usbnet;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 500000 0>;
> +		power-supply = <&reg_5v>;
> +		brightness-levels = <0 100>;
> +		num-interpolated-steps = <100>;
> +		default-brightness-level = <100>;
> +		status = "okay";

We usually use "okay" status to enable "disabled" devices.  It doesn't
seem to be needed here.

> +	};
> +
> +	panel {
> +		compatible = "edt,etml0700y5dha";
> +		backlight = <&backlight>;
> +		power-supply = <&reg_vdd_3v3>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&bridge_out>;
> +			};
> +		};
> +	};
> +
> +	max98357a: audio-codec {
> +		compatible = "maxim,max98357a";
> +		sdmode-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <0>;
> +		status = "okay";

Ditto

> +	};
> +
> +	reg_5v: regulator-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	reg_sn65dsi83_1v8: regulator-sn65dsi83-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SN65DSI83_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	sound-max98357a {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "max98357a-audio";
> +

Unneeded newline

> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&cpudai>;
> +		simple-audio-card,bitclock-master = <&cpudai>;
> +		simple-audio-card,widgets =
> +			"Speaker", "Speakers";
> +		simple-audio-card,routing =
> +			"Speakers", "Speaker";
> +		status = "okay";

Unneeded "okay"

> +
> +		cpudai: simple-audio-card,cpu {
> +			sound-dai = <&sai1>;
> +			dai-tdm-slot-num = <2>;
> +			dai-tdm-slot-width = <32>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&max98357a>;
> +			clocks = <&clk IMX8MM_CLK_SAI1_ROOT>;
> +		};
> +	};
> +};
> +
> +&sai1 {
> +	#sound-dai-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai1>;
> +	assigned-clocks = <&clk IMX8MM_CLK_SAI1>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&i2c1 {

Can we sort the labeling nodes alphabetically?

> +	bootph-all;

Drop u-boot properties.

> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	bootph-all;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	eeprom: eeprom@54 {
> +		compatible = "atmel,24c08";
> +		reg = <0x54>;
> +		pagesize = <16>;
> +	};
> +
> +	touchscreen: touchscreen@41 {

Sort I2C devices in slave address.

> +		compatible = "ilitek,ili251x";
> +		reg = <0x41>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touch>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio3 16 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	lvds: lvds@2c {
> +		compatible = "ti,sn65dsi83";
> +		reg = <0x2c>;
> +		vcc-supply = <&reg_sn65dsi83_1v8>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sn65dsi83>;

Have a newline between properties and child node.

> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;

Ditto

> +				bridge_in: endpoint {
> +					remote-endpoint = <&mipi_dsi_out>;
> +					data-lanes = <1 2>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				bridge_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +					data-lanes = <4 3 2 1>;
> +				};
> +			};
> +		};
> +	};
> +
> +	usbc-cc-controller@61 {
> +		compatible = "ti,tusb320";
> +		reg = <0x61>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbc_controller>;
> +		interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&mipi_dsi {
> +	status = "okay";

Please end property list with 'status'.

Shawn

> +	vddio-supply = <&reg_sn65dsi83_1v8>;
> +	assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>,
> +			  <&clk IMX8MM_VIDEO_PLL1_OUT>,
> +			  <&clk IMX8MM_CLK_DSI_PHY_REF>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
> +			  <&clk IMX8MM_VIDEO_PLL1_BYPASS>,
> +			  <&clk IMX8MM_CLK_24M>;
> +	assigned-clock-rates = <266000000>, <594000000>, <12000000>;
> +	samsung,pll-clock-frequency = <12000000>;
> +	samsung,burst-clock-frequency = <891000000>;
> +	samsung,esc-clock-frequency = <54000000>;
> +};
> +
> +&mipi_dsi_out {
> +	remote-endpoint = <&bridge_in>;
> +};
> +
> +&lcdif {
> +	status = "okay";
> +};
> +
> +&gpu_2d {
> +	status = "okay";
> +};
> +
> +&gpu_3d {
> +	status = "okay";
> +};
> +
> +&ecspi1 {
> +	status = "disabled";
> +};
> +
> +&gpio1 {
> +	bootph-pre-ram;
> +};
> +
> +&gpio2 {
> +	bootph-pre-ram;
> +};
> +
> +&gpio3 {
> +	bootph-pre-ram;
> +};
> +
> +&gpio4 {
> +	bootph-pre-ram;
> +};
> +
> +&gpio5 {
> +	bootph-pre-ram;
> +	status_led_controller_oe: status-led-controller-hog {
> +		gpio-hog;
> +		gpios = <4 GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_hog_status_led_controller>;
> +	};
> +};
> +
> +&pca9450 {
> +	bootph-pre-ram;
> +	regulators {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-0 = <&pinctrl_hog>;
> +	pinctrl-names = "default";
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19 /* \SOM_RTC_INT */
> +			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x184 /* SOM_DIS_ID0 */
> +			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x184 /* SOM_DIS_ID1 */
> +			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x184 /* SOM_DIS_ID2 */
> +			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* SOM_PCB_ID0 */
> +			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26		0x19 /* SOM_PCB_ID1 */
> +			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* SOM_PCBA_ID0 */
> +			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19 /* SOM_PCBA_ID1 */
> +			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x19 /* \SOM_STATLED_RES */
> +			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19 /* \SOM_HUB_RES */
> +			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21		0x19 /* \SOM_SUPPLY_EN */
> +			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x1c4 /* \SOM_COM_RES */
> +			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x184 /* SOM_DBG_GPIO0 */
> +			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x184 /* SOM_DBG_GPIO1 */
> +			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x184 /* SOM_DBG_GPIO2 */
> +			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1			0x184 /* SOM_DBG_GPIO3 */
> +			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x184 /* SOM_AUDIO_SD */
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
> +			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pwm1: pwm1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT		0x6
> +		>;
> +	};
> +
> +	pinctrl_pwm2: pwm2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x6
> +		>;
> +	};
> +
> +	pinctrl_pwm3: pwm3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT			0x6
> +		>;
> +	};
> +
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI1_TXFS_SAI1_TX_SYNC		0xd6
> +			MX8MM_IOMUXC_SAI1_TXC_SAI1_TX_BCLK		0xd6
> +			MX8MM_IOMUXC_SAI1_TXD0_SAI1_TX_DATA0		0xd6
> +		>;
> +	};
> +
> +	pinctrl_sn65dsi83: sn65dsi83grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x19 /* \SOM_DSI_INT */
> +		>;
> +	};
> +
> +	pinctrl_hog_status_led_controller: statusledcontrollergrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4			0x19
> +		>;
> +	};
> +
> +	pinctrl_touch: touchgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19 /* \SOM_TOUCH_RES */
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19 /* \SOM_TOUCH_INT */
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		bootph-pre-ram;
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
> +			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
> +			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
> +			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
> +		>;
> +	};
> +
> +	pinctrl_usbc_controller: usbccontrollergrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* \SOM_USBC_INT */
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		bootph-pre-ram;
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		bootph-pre-ram;
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		bootph-pre-ram;
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
> +		>;
> +	};
> +};
> +
> +&pinctrl_ecspi1 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_i2c1 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_pmic {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_uart3 {
> +	bootph-all;
> +};
> +
> +&pinctrl_usdhc1 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc1_100mhz {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc1_200mhz {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_wdog {
> +	bootph-pre-ram;
> +};
> +
> +&pwm1 {
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	pinctrl-0 = <&pinctrl_pwm2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&reg_nvcc_sd {
> +	regulator-always-on;
> +	regulator-boot-on;
> +	regulator-min-microvolt = <3300000>;
> +};
> +
> +&uart1 {
> +	bootph-all;
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	bootph-all;
> +};
> +
> +&usbotg1 {
> +	bootph-pre-ram;
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	disable-over-current;
> +	dr_mode = "host";
> +	status = "okay";
> +
> +	usb@1 {
> +		reg = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbnet: ethernet@1 {
> +			compatible = "usb424,9500";
> +			reg = <1>;
> +			mac-address = [ 00 00 00 00 00 00 ];
> +		};
> +	};
> +};
> +
> +&usdhc1 {
> +	bootph-pre-ram;
> +};
> +
> +&usdhc2 {
> +	bootph-pre-ram;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	no-1-8-v;
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	vmmc-supply = <&reg_vdd_3v3>;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	bootph-pre-ram;
> +};
> -- 
> 2.47.2
> 

