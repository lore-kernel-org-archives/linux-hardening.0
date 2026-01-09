Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39092218845;
	Fri,  9 Jan 2026 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988759; cv=fail; b=sgtlYpOYhdJZ6asjp3sMjRA0dh8f8rCYleT/YI67NgHlFM7hDhR5Sgopq/1umEYz+q+573B9NfhAI2px8n8a+VLrQqVLzcBASsQZ2dtYGtp5LuAnJnVbWi4baPASq0TpbTiGmU5eHubw43ZFH+om69D4C8YE8ID8JuEJyt/xBY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988759; c=relaxed/simple;
	bh=Pp6C5qQTdEJOVydnTfBS07em9UzEAMh0sqtDELqb4q0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiMf9Ch2BOuybPUnnl7LJiNUNocwWc2YyomBgif0H1xpW66JqcFW0bSfo0Ig2m4YJP4bzEHR5XCillCmh90eyP9dbuwPhhg227P8XDAHYLoafOpKJ/1bZ1DgEdy03UwXigDGNtUnmJeA3fjUTYy7tqzgD2KIt+r41F/VfIA2NN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZN6XKUgt; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZN6XKUgt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt0P6Rn0ZiYyYgw/QS3c8uAq52dUgjs7AuiO7gqQr3afhgTK6JxNkxCjaqcd/MvfgyzZ2B1osDCfuBJNOOpoWmksPDdGADjf09IX+8Sj/ret1yKiQcpwAflcnjS6nQnKxsQa8lCNH9lBEAkFbUeFyI/CUsPHNchJyqDTl4AgzugAg+zANrt5yUEQaD226P/vNl9+t+Vm87cqU0Ve9rGSMzb4u4chAME20kJs5ktAgsXL9l6mbA6A7HSxBTLRsKsZZCKZGZP0tg/VHOo4mdevnxW7bBW33U+MziHWTQBY5MyVS2ktVAA8SqgFRwzTFURp9uS3OBv8va8o9ezjkeF6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaOms306AxpN12G8N4H3u9pj6h/W4QwFeLwI1JNrDqI=;
 b=LRNdkYE/NdAd84G3xr6kmjaepZ0ymb3S0tJnbiWuHpUagwDqRO6jbj2lNG55m0qKdqmnmhr0fDSb2BQV5UDyxySXH7+ewUYvp+rrlLgY52GMOQyuB2oiFOyo9BVAK/DLpUQhIOtO6aJHypAloOCerTRTYQ5PY2jBlR/TpLqNYx2x79u495Z8os1t7NOZx6oQh0/9CPPIvYxvQ0elmXWze0J6tl6amrZnfK06Vk6ov7xrwxDu3E+U/Uv0bB1lMD1eAvruBYqyLTQFZZPA4Dv3s3RnP9F3XIilKGRAtpRTQcgfuDZKZgrdKCBFSVqRx0QRiEvnRggmwfrPKNisA63KBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaOms306AxpN12G8N4H3u9pj6h/W4QwFeLwI1JNrDqI=;
 b=ZN6XKUgtlQbwajPuNt5NXsL02UleFQDzgYhLb31+P02e0xtvWZEYnoEYnTX1x4PFz/Edce7AtQx3weYjhWrR/bov3aO56i0tnFJel0yO/V0rLCFrlScwR1LAcID3BrsAnGz4IQtiCZoOaNhx9Tw1Jcje3jccv7RGcBijMS0hTaU=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by DM3PPF612E8E8B0.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 19:59:14 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::e4) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Fri, 9
 Jan 2026 19:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 19:59:13 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:59:12 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:59:12 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 9 Jan 2026 13:59:12 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 609JxCiB475006;
	Fri, 9 Jan 2026 13:59:12 -0600
Date: Fri, 9 Jan 2026 13:59:12 -0600
From: Nishanth Menon <nm@ti.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Andrew
 Lunn" <andrew@lunn.ch>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux@ew.tq-group.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and
 MBa62xx carrier board Device Trees
Message-ID: <20260109195912.c7wiyzj4qtdlxkh2@tumbling>
References: <cover.1767627010.git.matthias.schiffer@ew.tq-group.com>
 <5df62f37eb84daff28008b8f9d5bd544b2f3a6a4.1767627010.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5df62f37eb84daff28008b8f9d5bd544b2f3a6a4.1767627010.git.matthias.schiffer@ew.tq-group.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DM3PPF612E8E8B0:EE_
X-MS-Office365-Filtering-Correlation-Id: 186c6147-79c2-4c30-1f91-08de4fb98ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f7bfi6xDuo+ms4OQm6ZHH6/ooNoH8QfqiUASVvtNPsOsboEVa+erSjAK4QXM?=
 =?us-ascii?Q?fyr2LnOZj3mtDQ1ZNayGvre2J7YS3qCpQSYm+NlMcnlZ/PGY83ZNWJ7QhuZl?=
 =?us-ascii?Q?z8B7eVZFAvYqjqD9G++J+lLkBZ7WIEi8IxQ+Tn2Je+JtB7izxniPp+FTVWg5?=
 =?us-ascii?Q?9LGxLw+TBirGPKIliYvv+lqe6EaqBDnHRzh++wqjxvWBB6oNEYP26aHU+yjb?=
 =?us-ascii?Q?+2gErF7U+p0GjLXaRS54ZJq7Rmmit0CPvDoy6iz9Br/SsQ1szWyr+veLk11i?=
 =?us-ascii?Q?er4Uhq/xMBqZLBZIFu+DIwDmTv8JX2EixPX0CkY64VMAMlTy5b2TIH9UBWug?=
 =?us-ascii?Q?j71pSA2iPr0XhBRDog+JjQuwAOK/7aa/etuiMN21tiUGrxKeT3740nGtmABn?=
 =?us-ascii?Q?8i2RMZkVdBTAxt64LAWK11kTccdO3DMHu4wHLq4QR0GsPrxEHCImEG0mcsfM?=
 =?us-ascii?Q?BIT7tCe8ok5AwZOPYU9UlicI/DopMY3IIOFHvLKt3FPVKM7ojvT5FJW+7GXP?=
 =?us-ascii?Q?eAG8ZiG+/XYlAKxzxB/awpuIvIzxxJVfzwvUfADQoy99SqIPp3vMUm5RttDe?=
 =?us-ascii?Q?1/slMrcLMgs2wiFmpJsuAmQHKfYzKynukG0am6mf282IFR6IQ+x95NfKtoO7?=
 =?us-ascii?Q?8om6AEUECVJN8+LYEtkUxjBjZgEpZu12Hna32QPNxJtmJp6MKBc+6Qa3Lt6A?=
 =?us-ascii?Q?Cxa18nCxnrouRZ6n9c4DjLgZCvQmcMrddjCp6rvzXSQld3H68mc83T921Q9i?=
 =?us-ascii?Q?zc6TVBiv+tQ7pnu1TTmxyaWFBIvKVftXwRGEfUxAzBj4Pg+Rv/zkyOmef+vC?=
 =?us-ascii?Q?vgFMSfScsf5Y/O9HFk2sqUPIDuO9xGQgd/8W0qM8kAfALr5t3yD9xkm0n1Rw?=
 =?us-ascii?Q?xUJRkwjBhgCawMZ7zKSOOuhM1w4SMWNbZbyLme4z+9CLG6DfcRG4Jfvxv5LD?=
 =?us-ascii?Q?TfB/MYv0AVoEoryalLsAFgRQbHOT35RDthFJo2S5q6iYvMjUb3j8cKiZBWTd?=
 =?us-ascii?Q?WsA4VM063d7DLeaQaTjNM6DTTizjLLx1dfloWiBlJn7tOnbMJBw2UpnJE8Dp?=
 =?us-ascii?Q?c49NPtaIYKEAhrqW5btCHPaPZAxS28FjsfJ6mrlN6CBslUH2xfaJQHpjIzNj?=
 =?us-ascii?Q?IUBNxxT9NKMNrHWtrw5RqFFwTjPVN+5zEnIc0qOJuewiZ8QQZucLKk7TBWqQ?=
 =?us-ascii?Q?8TMtgvbh6cduyzrAtmZVBfhxUZrAmmFx2I5CvWR/mYKtAuJRipDaxb+6jFe1?=
 =?us-ascii?Q?7hbFH7YlMoj7mSxefPeseqb2f+w9VFtgztB7ujYTy12I5ihyCeN4RO9a8Xv2?=
 =?us-ascii?Q?6zmBNiTYMK40hV/XF7zXJcfOdgDNZB816w7wGC761mbeKhE9yBKlkiq0masU?=
 =?us-ascii?Q?Gsbgd7jth/5o2KiL0jBpBl14Exrwu7NTl0yHrltLb07JUq6fw9/6LYehEuUt?=
 =?us-ascii?Q?soG33L0CVSMlioeBc0dhjqSZ9tqTD9K9gcVCNV/jYSHQcsGHI4ei+yNgVl5H?=
 =?us-ascii?Q?HzpOCBx1sqMJotgUIYlzMxHDmfnLevoGU2B8?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 19:59:13.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186c6147-79c2-4c30-1f91-08de4fb98ff9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF612E8E8B0

On 09:14-20260107, Matthias Schiffer wrote:
> The TQMa62xx is a SoM family with a pluggable board connector based on the
> TI AM62x SoCs. Add DTS(I) for the AM625 (2x Cortex-A53) variant and its
> combination with our MBa62xx carrier board.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Few clarifications below..

[...]
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
> new file mode 100644
> index 0000000000000..cca8d0018504d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
> @@ -0,0 +1,930 @@

[...]

> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&backlight_pins>;
> +		enable-gpios = <&main_gpio0 38 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";

Document why disabled?

[...]
> +
> +	panel: panel {
> +		pinctrl-names = "default";

Missing compatible? thinking again.. Should'nt these be part of some
panel dtsi?

> +		pinctrl-0 = <&lvds_panel_pins>;
> +		enable-gpios = <&main_gpio0 36 GPIO_ACTIVE_HIGH>;
> +		power-supply = <&reg_lvds_pwr>;
> +	};
> +
> +	fan0: pwm-fan {
> +		compatible = "pwm-fan";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm_fan_pins>;
> +		fan-supply = <&reg_pwm_fan>;
> +		#cooling-cells = <2>;
> +		/* typical 25 kHz -> 40.000 nsec */
> +		pwms = <&epwm0 1 40000 PWM_POLARITY_INVERTED>;
> +		cooling-levels = <0 32 64 128 196 240>;
> +		pulses-per-revolution = <2>;
> +		interrupt-parent = <&main_gpio1>;
> +		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
> +		status = "disabled";

please document why disabled?

[...]
> +
> +	reg_pwm_fan: regulator-pwm-fan {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&reg_pwm_fan_pins>;
> +		regulator-name = "FAN_PWR";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;

Just checking.. Did you intent a 12v supply for fan?

> +		gpio = <&main_gpio0 62 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +

[...]

> +
> +	lvds_panel_pins: lvds-panel-pins {
> +		pinctrl-single,pins = <
> +			/* (N20) GPMC0_BE1n.GPIO0_36 - LVDS0_RESET# */
> +			AM62X_IOPAD(0x0094, PIN_OUTPUT, 7)

Could you follow the comment convention you have elsewhere? please follow the
same in gpio below etc..
AM62X_IOPAD(....) /* (N20) ... */

btw, panel node uses it as:
enable-gpios = <&main_gpio0 36 GPIO_ACTIVE_HIGH>;

isn't RESET# meant to be active low?

> +		>;
> +	};
> +

[...]


> diff --git a/arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi
> new file mode 100644
> index 0000000000000..1b7d58cb7b936
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (c) 2023-2025 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
> + * Author: Matthias Schiffer
> + */

[...]

> +		regulators {
> +			reg_buck1: buck1 {
> +				regulator-name = "V_VDD_CORE";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
[...]

> +
> +&a53_opp_table {
> +	opp-1400000000 {
> +		opp-hz = /bits/ 64 <1400000000>;
> +		opp-supported-hw = <0x01 0x0004>;
> +		opp-suspend;
> +		clock-latency-ns = <6000000>;
> +		/* Enabled by bootloader if supported */
> +		status = "disabled";

This (bootloader enabling just this node) wont work unless vdd_core
voltage is configured to 0.8v as well, no?

> +	};
> +};
> +

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
