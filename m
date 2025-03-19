Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC422F19;
	Wed, 19 Mar 2025 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383511; cv=fail; b=fnAdpGNaI78EMeU/ckEoePKawRSWiXIyVbhyIFT9dw/7Xh10I9cKMCEaT/UpslHmdJnpAzx3v3cI9Ou0nIV5oIC/loWMNACWOcIEmvI5W5Tkd8rO38flJLUAmND7LJe3OUwCKhJouGkvPS4MQEikJvvxf1dvkkcS1tUUsJzBpIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383511; c=relaxed/simple;
	bh=wc7JNkFLa9qPab9+XwoIeMt7Ierx+un6hvx4YtrlTqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh/O+gd0mcUVoayFkJZ3bEcokLNuGV1zViP2QETnY+Og0Mqmkj2GmRS81t5a9CzrPxDukJQZseB/ZRhPyiKK5VtWufO/kD1zFUw59x8ry/VWdISvFpnUUtXeqBYRg9mL7N/OcqP5xuUI76sR6+MTA5LwXzcAxXjkJKBOSiKF9dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mmVqVlr1; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mmVqVlr1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJ26tS1AiO7hFNMgfzS6gO1FZHusyslV1wnsLxL9i8jDHHDyXMzYsCidyTUb86p7C+9WtZ5nVp3HEwqhryTUI9tTHKQm2VAwDw+oNQ/AZS9kveXz3YVPHOdS7nwc4Jf+oFeyqrPjrw//Se7OEkdsz7NTw73QcVQKmoOLxZF8ZSF1sobie1CekU/q50sSDmDuR9mff7D1n5/MMbTBpDRz8OzdrRtNGuzSV/PpUDqo0RRJL3aBd4N5ObPt/XLj+Vm8jrbmV1aDyjI6baKixe795BWDmo463EXyWlqVvyEUsxktpeeeIFa3uTWivNvH1seefyDrjQ4x++DmcAgSq8GHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+RyEqCiFVnYuGI8RoFkiMpJQTDzpEop+yKvN0mOz8c=;
 b=MfzF2HKbY2r8gU/grjQCLRPgjfneygZHoNni7kQKr1RdSz9aqwd7PZq+oScb6gK7GVveWtUt/aF7+3bR9T6rH+qjcz6LJH3cOL7jRCgbws2kFw+xKit2gduK6jaupNxPzU84GlbiR/Dx4HytyrHCuLuEZpk52XcXWLphldZgoAkPU51viTE/4DNRT5YDCZ5b59LQUWd0vapP9+/U/1++qxEISwYDnrJol7Q2s05EV5K/0fQTEnrp+5m7KZHLuDiTuXWcDjyzXIbJXArcghNr6RzhqOREUMYaDizp1kwrh/ZfCqJXB7Q5nXHtmQdTDDad3LN1CoznRPi/0WbmRh3qHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+RyEqCiFVnYuGI8RoFkiMpJQTDzpEop+yKvN0mOz8c=;
 b=mmVqVlr1GLGTCByv846OMsF8zQj4NtbtlCL3YL3m6BJukoD0lZrwyPxF4AEmIl6/9irPQmwJOuuCeiYgB+tmmXvq0A3MwWkDC06ANClmHMrw3wzmfA4C5UWEN4Ipbwtd9pfU3hxIPocmL9pDBijpJHUU/Y0BRPxGNzHT6eiqPAq+b50uwbo05uHFbi5tTvlyZ4oGM5tXeNoHwT7nzBOSpiOZiGoK5aYwsiV/j+totXnQhzvbPvppB3oGaUR7C/ogYsxFMtKyX5w5LdF02Ia8qrgmVMSRMbe1qN8ZfLqAQKKMeoUy+OAWMU9VEkpwzmPQon7fRFNoA4/wmlRqYI1MEg==
Received: from BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 11:25:03 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3) by BY5PR04CA0019.outlook.office365.com
 (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 11:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 11:25:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 04:24:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 04:24:52 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 04:24:51 -0700
From: Willie Thai <wthai@nvidia.com>
To: <krzk@kernel.org>
CC: <andrew@codeconstruct.com.au>, <andrew@lunn.ch>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dkodihalli@nvidia.com>, <gpiccoli@igalia.com>,
	<joel@jms.id.au>, <kees@kernel.org>, <krzk+dt@kernel.org>,
	<leohu@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maryang@nvidia.com>,
	<openbmc@lists.ozlabs.org>, <pmenzel@molgen.mpg.de>, <robh@kernel.org>,
	<tingkaic@nvidia.com>, <tony.luck@intel.com>, <wthai@nvidia.com>
Subject: [PATCH v2] ARM: dts: aspeed: Add device tree for Nvidia's GB200NVL BMC
Date: Wed, 19 Mar 2025 11:24:51 +0000
Message-ID: <20250319112451.4171471-1-wthai@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <93bb3092-7f49-4a7f-ac97-3cf1a62ac39d@kernel.org>
References: <93bb3092-7f49-4a7f-ac97-3cf1a62ac39d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b5526e-2326-4998-cce9-08dd66d8b183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QrD4o91WS0ZQq/5K+kjfG0SfMBrC8aXnl3fa2PRBiZwObMEAyZmjUNA9pBLW?=
 =?us-ascii?Q?lEO8rDou/Z610Rs4Euffariy979oREXYFnxjPMuasw6k2mL9n+yPJ1ItpIa1?=
 =?us-ascii?Q?0j1rAWIHxcGLxNWn1dLTzmu2uG1ec+G22Li25IHO/jDI4NJRHg+iDAAZjkm9?=
 =?us-ascii?Q?06+m94JmuzrZYWpC06Ofrvs7JnpVa/jirexcJf5PT3yh/GeYm6e3eL1uC47D?=
 =?us-ascii?Q?yyalcLx/R6QkFJAHKnUrZf/N6iGReBkwlfYLHKFK0PIi+lssGIibL9dpk2fk?=
 =?us-ascii?Q?SCIQyRHlM6H6aouBYhJ83JHRWBQ8mZe3eOIWNtIPympYKKnGfZqbqR39I8Vv?=
 =?us-ascii?Q?zjGR05X91sGIdlCpxNHGBYiZjWL/A+g0SF7y7wrm40oQk1DeYtlMJHW9C4H4?=
 =?us-ascii?Q?dLwM9G/CrpDEqCl7fCdjWctd/Q0GnwDzU++G+ke6pQRwDdfPFBEgEXzp9R1n?=
 =?us-ascii?Q?jS/CAc0uF7a40J2KInwKl43Y6dyePmRBzJG2XInxQH0cx3x3gBzGSa2/f44Y?=
 =?us-ascii?Q?wqoNlMEMG004Kk8hPFIhzASoTPG9xDD3J7eiDMAETcwUWN/H9FzDKqEOzqT/?=
 =?us-ascii?Q?67PMuMFZC3DRtbBMSKB7iXj+51Jf1AYIzosXW8zw4R92/oMVjPLpJNv+PVJh?=
 =?us-ascii?Q?6arzscRNskSGNKtb+VxKLHG5r3V5WK3wb8QH2Dz4WO3f2K/juwtCjYIzAAlG?=
 =?us-ascii?Q?U4mwQW/oshXJAx2S6dyOTKApEnP6mWml37MWG+DtH+tYD+jz9gv6HW/iT5IK?=
 =?us-ascii?Q?XZQGeILc0gcs+12TLIlL3oeFZnN6xJXJT8qCIv4skO4+Yabis6+KUtTONMyv?=
 =?us-ascii?Q?pxXbzwQN6DZxNrMpbBEc2bHNDARAkycSbbfkMC1gCHKUXp6KhH1qKRqANH4Q?=
 =?us-ascii?Q?v5ZS9wLrG+msdgj7YOTZRVh0q5IDOyBUWlIipV1Lb3G//5zS+A5/V5ernKPC?=
 =?us-ascii?Q?1PESBQ6T4K6aX7KtkHiJmRypVo0LN8mqvQBnC4RhdKGHwV9nlMXt0pmLyK0m?=
 =?us-ascii?Q?r40cDCD+XWDK0bzdfe3Dos6j6/8aC3iZ8AULMy4t6X0aYZ1siObZI11RBYHA?=
 =?us-ascii?Q?d5tg4oJ//Ee9WAPFyD3rQdhnxAYxS73OwuKXBCPk2CzYGp+EcHOITy2xqfbV?=
 =?us-ascii?Q?Le9Ew/+xlGNsMgBCl/IHcgnxczd/l5xD/M4hNO208zw+IhWv/mYzNGNZ54Ty?=
 =?us-ascii?Q?1aTfl0Qz6F3ed7/MPeQJqjn7oK4yxkf1Y27KsR6d5x8Uz0UQd92cgzoo1Qj6?=
 =?us-ascii?Q?QaGvO56UjMj8h2xNiTFsTIa71unM6cvU0Oole0aqvCPthuyaLTMxlE0N/5q0?=
 =?us-ascii?Q?HD4m6ZbskIk0yfRu/ixWX+oxwjH/6PKTcVXdMiL+rJiQFT5MvLwIRnfrtcS+?=
 =?us-ascii?Q?SRetL75eyjIZ6+xV6Tys01l2HOZDs8pq+M/UILHjun8oWRRipbSJvEIlNteo?=
 =?us-ascii?Q?uzEib1G9J1X9eBSHumWIJnjbUVgS64+sZVxycYa8WRLy1kSaQdcZPb1yNpxB?=
 =?us-ascii?Q?CMBdPJrZ/OvNll8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 11:25:03.3496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b5526e-2326-4998-cce9-08dd66d8b183
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790

>> The GB200NVL BMC is an Aspeed Ast2600 based BMC
>> for Nvidia Blackwell GB200NVL platform.
>> Reference to Ast2600 SOC [1].
>> Reference to Blackwell GB200NVL Platform [2].
> 
> Missing blank line
> 

Thanks Krzysztof for the comments !
Will fix in the v3.

>> Co-developed-by: Mars Yang <maryang@nvidia.com>
>> Signed-off-by: Mars Yang <maryang@nvidia.com>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
>> Link: Reference to Ast2600 SOC: https://www.aspeedtech.com/server_ast2600/ [1]
>> Link: Reference to Blackwell GB200NVL Platform: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
> 
> Links do not have text, I think. Just link.
> 

Will fix in the v3.

>> Signed-off-by: Willie Thai <wthai@nvidia.com>
>> ---
>> Changes in v2:
>>   - Fix the SOB name [Krzysztof]
>>   - Fix warnings from scripts/checkpatch.pl run [Krzysztof]
>>   - Fix DTS coding style [Krzysztof]
>>   - Move pinctrl override to the bottom [Krzysztof]
>>   - Drop bootargs [Krzysztof]
>>   - Follow DTS coding style and change naming for leds node [Krzysztof]
>>   - Change flash 0 status property [Krzysztof]
>>   - Change the phy-mode to rgmii [Andrew]
>>   - Remove the max-speed in mac0 [Andrew]
>> ---
>> ---
>>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>>  .../aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts | 1229 +++++++++++++++++
>>  2 files changed, 1230 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
>> 
>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>> index 2e5f4833a073..20fd357a1ee9 100644
>> --- a/arch/arm/boot/dts/aspeed/Makefile
>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>> @@ -50,6 +50,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>  	aspeed-bmc-lenovo-hr630.dtb \
>>  	aspeed-bmc-lenovo-hr855xg2.dtb \
>>  	aspeed-bmc-microsoft-olympus.dtb \
>> +	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
>>  	aspeed-bmc-opp-lanyang.dtb \
>>  	aspeed-bmc-opp-mowgli.dtb \
>>  	aspeed-bmc-opp-nicole.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
>> new file mode 100644
>> index 000000000000..eeec3704a43b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
>> @@ -0,0 +1,1229 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/dts-v1/;
>> +
>> +#include "aspeed-g6.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +
>> +/ {
>> +	model = "AST2600 GB200NVL BMC";
>> +	compatible = "nvidia,gb200nvl-bmc", "aspeed,ast2600";
> 
> Missing bindings.
> 
> Please run scripts/checkpatch.pl and fix reported warnings. After that,
> run also `scripts/checkpatch.pl --strict` and (probably) fix more
> warnings. Some warnings can be ignored, especially from --strict run,
> but the code here looks like it needs a fix. Feel free to get in touch
> if the warning is not clear.
> 

Will add the binding to dt-bindings in patch v3.

> 
> ...
> 
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		led-0{
> 
> Missing space befre {
> 
> This applies everywhere.
> 
>> +			label = "uid_led";
>> +			gpios = <&sgpiom0 27 GPIO_ACTIVE_LOW>;
>> +		};
>> +		led-1{
>> +			label = "fault_led";
>> +			gpios = <&sgpiom0 29 GPIO_ACTIVE_LOW>;
>> +		};
>> +		led-2{
>> +			label = "power_led";
>> +			gpios = <&sgpiom0 31 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +	};
>> +
>> +	buttons {
>> +		button-power {
>> +			label = "power-btn";
>> +			gpio = <&sgpiom0 156 GPIO_ACTIVE_LOW>;
>> +		};
>> +		button-uid {
>> +			label = "uid-btn";
>> +			gpio = <&sgpiom0 154 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +};
>> +
>> +// Enable Primary flash on FMC for bring up activity
>> +&fmc {
>> +	status = "okay";
>> +	flash@0 {
>> +		status = "okay";
> 
> Nothing improved.
> 
> Respond to comment instead of ignoring it.
> 

The property was disabled here: https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi#L172

> 
> 
> ...
> 
> 
>> +
>> +		imux33: i2c@1 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <1>;
>> +			pca9555@21 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> You already got this comment. You must apply such feedback to entire
> file instead of fixing only one issue and relying on us to find all
> instances. It's your task to find all of the instances.
> 

Sure, will modify node names to generic

Thanks !
