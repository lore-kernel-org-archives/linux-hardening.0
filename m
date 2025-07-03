Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FDF2DE6F8;
	Thu,  3 Jul 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556281; cv=fail; b=YMam2aOfuDfLbSUyaa3CVW+1YmWBG8+bA8CkFChY/Y8Ws1+SSokeh3k8iogEQpmz1THT3k9LPaQJp+IVYqLUocl6SgEaV8xfHKNuIyb0YxFWobnzGVCKOPhdiYfmM7if5txMLjqG+qG3f3H3JeHWtM+aJufReGRhA/BERY1qgdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556281; c=relaxed/simple;
	bh=lXZf24WdU90bclsqORQoSR6v0NLhSfvzPMd8XB7+qoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cc0FuJFda0lYTqjzQZsq/MbHJ5XD9CN9lp4Hr3bpxlnZDYkq81mSApAz8vfzPN+OwkLYB76O+BCBq8PNpORjF+neOUXo9xS/5KpFu1fgEad0rTza6mj1UydxOQVQ4vwP5KRaCfV2n+JD5EQbCHfZiLfjJ2aWCW+nWsNNaVfF1gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UzCtoTG3; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UzCtoTG3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKVPrVQGkoHRyZjce+uTiEIytdrFN+7iEjOzVLS7AKvhqe3JJpW2lV1zz0XnH1atODxI4pmu00S1FkvO/e+RDpoIgTnbirbU+mfvfo1ogKtem4Fk7fC9ikPRVJV4PyyZvgzVMJRVnU1O2npG9NyiXprrJCJlIWM/XjWjFsT7serfSU2F/ih4im3GlzhOorb9IVypbwyZahzcyZaPHqPZ0Z42gVOfjxLb7TOcPIZoeQXg9wLVROJvNjOEt3ezrDbIJjFb0z57K+GcF+IjVQ5HCPh+323MqNZrvRHh54KvdTdY81PU/sflvjRKkTXcPxodQjt+gac7MrbYBtktgGKwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBiC/S5k4dgsGGX5t3VHPQt3tWRCJzWevYBmyMLj+GU=;
 b=qycKAo3cItcvWLyaypPRbMwB/Qid37Zt5hLTtZCPnafGkbtlivX7ac9zVmDJAZS8IMc+SfXuHp/xSGkzGOndKCKhv39iCB5vOft/ae0UfEHHmUkwOGIVBdJJIpjd9C5+PZP+XWCsoJOcM8wVZjvMUTKL7p0WC526RjIvEofWxEveHqIiArsEPbQrFIPNhwf2JieHKvxXW7IWWDUPuuR2mLqBypqYNqKJObPd1e04wbwDsVxydGG2XJlLwBK9xsVicb/E7pEubuY122Rw2633IsYNc/9YbMAyhj/tHv5IxKCp3/h5bJQI8roF2IaQxOcWzjewFffPjFSUrcajVANYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBiC/S5k4dgsGGX5t3VHPQt3tWRCJzWevYBmyMLj+GU=;
 b=UzCtoTG3lYIPP+cmXXgitUpZ3xjgyaJTIVULphqfVqzCeDMF7EgqOhAVZJGycqRXAcPY5CR0/8uCoqZCq4Y57moUZPdxr7KRPoB3S5CW2Idw/026MGmmBixoOXyraZvP+V8gZI1k+TRRPY5rskYuXNTfxnczWc1wajCVushnlDVZTgQTeTx4/lF6I6/VehqnsYh6SIxQkX5DQdyAStZRZxY75lghFtZID/ty1gslDFxGg1/tHxuDa33OZvf0KXv/mpo9XD32TnFiaV0PL3DeZCfF/+xTDAjB4wTkNg/oRo9MPHAiK3geDU8kPYN6CYc7dTSgLLsVER1uCzejMAppNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB9015.eurprd04.prod.outlook.com (2603:10a6:20b:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 15:24:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 15:24:34 +0000
Date: Thu, 3 Jul 2025 11:24:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com
Subject: Re: [PATCH 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <aGagmFK6Fw2s+Kk3@lizhi-Precision-Tower-5810>
References: <20250703111428.2111484-1-manikanta.guntupalli@amd.com>
 <20250703111428.2111484-3-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703111428.2111484-3-manikanta.guntupalli@amd.com>
X-ClientProxiedBy: AM8P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df713e5-70e6-4490-740f-08ddba45b6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ueVY9AS8ygyexHnuayVaWXAcbcJGC2QTAyL5NOdxoaymblkb5hUVvQy9mMff?=
 =?us-ascii?Q?goKRPw+/n6lrvnmo6zQOdNtkZ4RNiG2zoBgh+WwaGRkUdU8FWZExUn1+LULu?=
 =?us-ascii?Q?xSM78fXzN5bJDg2cSQVQYd7SsGxkRA/7yGjjlbro/63SFMJ10u2hHcV4btcd?=
 =?us-ascii?Q?ajcgm5vXuUvHUk2SOBZk7Z4zT/D/K+perl2gCpFEEyjh0DYhX+CW26UUBVid?=
 =?us-ascii?Q?+QiaJqSrCgSYZ0RUlBjX7jYPxAHkOIRFnI1fKgPdv0QehLDY2yS4chWzwFdA?=
 =?us-ascii?Q?rY2y5SGdjs6vm94f038+/KtHQTs1Sv032A6gtj7XtHUOXA4nuLo2Gvm1q2lw?=
 =?us-ascii?Q?A8IcaHP9H2pNtImCtMMaoSWS4x2BmvOwxi/7mCOj7297fNwHxt93Ou01Qdqh?=
 =?us-ascii?Q?QPU1fxecW6kHS3xpYsT28QZEN0vrULLEd5NMfcMXYcISfYtvjwapYdKi5QqZ?=
 =?us-ascii?Q?uPS27cnCdtIsEAeyT813ST3hxYwcWnIrnnD4nb2nDUEh0RXJP7zkIfFnUWxf?=
 =?us-ascii?Q?dijLgQroltCbo+1vAbN448BN2C7EKXplHfTn6bcBGQ6wtG5O6KGNXqdHUUB3?=
 =?us-ascii?Q?fkasRfqgl1YQbZ1w8Iba5pUlyzxzDI9JrRXcGos2XtapRvmGmXl75bdxin5I?=
 =?us-ascii?Q?6yaAnlRx1oizR+FUCuLplJrP6n4oMVAPPXHFAvHhxuC94EUbmcfuWtUpee2n?=
 =?us-ascii?Q?xhSY8+t1bTn69eh6uIxA7yugYCdDlvd31RmH4ZeHpiSSX7/ugquob4//4R5O?=
 =?us-ascii?Q?fNVjyF4AXLQDjs2n/FGJX/4n/aTmozg6IeGejESZWbvJmRz6dmPYFvm3efDg?=
 =?us-ascii?Q?Pbm1SXFzZbi532q7OJTf03MwZeNAqVqiU9z/Q1ASZi9df2BPoTCa6PqX0E62?=
 =?us-ascii?Q?xifpy98398g/NnzARbYXZoeTmjFao9YZEi3pWOm/VBEINpjEvS/BmH/9WDEa?=
 =?us-ascii?Q?qN6wEgmwNCm7yIf7xFBktejHmeu7RL+uB78u8fLLBloQ6gICDcwF6g3jLTUD?=
 =?us-ascii?Q?cXG2nYGGIwd1yjf2fzxEwcd3IWjSPKjHFG24kJEsSQUt5ZXxsVrjB2hHLQFh?=
 =?us-ascii?Q?PjdL/RxK5KLwyAbnYsqg10vPgjDiXQSMvoVPKwOsBpwX+7HACiFPQqiXfeSD?=
 =?us-ascii?Q?Nr67xO/6GXnIUpAKwML4F5VmQejjTZbsyGQOPgrBlN2y8+tXRagcQue6KyeI?=
 =?us-ascii?Q?/IiscnQsoUu0OKN/U5uNSFpTq0J2eEbdBOEUCF5Q0hqYQ8j/TuajRlE2dUcd?=
 =?us-ascii?Q?DaV0JRNcZZugw0oGZptR50JJE9pTPjPfrjPXq5FUoeZQ5VAxfHgAQ0D1Rkgi?=
 =?us-ascii?Q?H7/nwlcklD7/5DC4X1oEMVdwGdgOxuFM4SNG0Ehh3q0I3c8W4EZt/swjGe1s?=
 =?us-ascii?Q?MjcUE+f1Tdx4ZqZTJkoCo2oy1PXWnjeXfQ77QFYlWKua3oN+6Xi1JI7X2GpB?=
 =?us-ascii?Q?SUN1YenObyE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uxMYqNmHbmhNJd4cURrXcXLkhcO++bhqqR98elj2nDBASjkBIB+Yrdg2scRE?=
 =?us-ascii?Q?0Dvtl/4sgqFxvx5s/ibV6KsvZj0Gdr2FKB8c0q4q/RQrTR1SnTQ6ql1casTQ?=
 =?us-ascii?Q?d6c/+CrV3g7JmblfyDvMcG3iNDWuSGhR1PP4rhvIpPezkXmKXBJmelWt88rT?=
 =?us-ascii?Q?JWgXeZxQ2SMGmCXY0zDjZmWplSchVPEKTgRT0Pn5wWky1cGNp6ojgySY8C3Y?=
 =?us-ascii?Q?f5OQirP8SQ87AkI86/YINC35/ipEWxVGxdYgujbFGVqHDDGSyU7ltEDPdYZ5?=
 =?us-ascii?Q?xtcCT868KEOHJyrW++zSnHeBkh2OqCh2OTFwupsFdjQ6NsXw1/4msyAcaRzv?=
 =?us-ascii?Q?AlIz79WNhsVuj/QW4eY84L695d20lkuY4bJmRnpoeWNg32Nx4jNjRvyDz5y8?=
 =?us-ascii?Q?CJ4A5CcdDL0MS21tGkn/mhWp9H8J8Idai/UVGOfS9g2eh3WyuIwT24kvTmF5?=
 =?us-ascii?Q?fjqUrm2Vek9X6RC6F+FB8jKc0J78uElGGFtf0Hw8wxvRGRvO0750/lnluQgW?=
 =?us-ascii?Q?g4BvWIQ4VXYblncQAwjYOV8A4bUEIM4ZlfwFkC8JfoHBIjNBorEokJDbsYjs?=
 =?us-ascii?Q?CrWnff9X/gFT1Uxk3JId+kg8EuTzu3Xr/rvq6qOMhXTlET6S6LEnw5l5z8tM?=
 =?us-ascii?Q?3ja+3aBNfa4C8h89mLmJzt7QSgKt3mOkmcTRWvj8ei9ASVX/VCYedwx/NsAg?=
 =?us-ascii?Q?CHXX32pcW01PYtCLGxFpEvvWt6Nx1D9zig6YojttYrGLtmfLsaDxZoi+Y/Hy?=
 =?us-ascii?Q?n0rp/NTKWp26SX89qlrlT+d5vptgQ52wiLeDJt1YAuTy9LBz1BxfwtYzbPMa?=
 =?us-ascii?Q?H/oJXohN/xuW6bbw5JSAXdajokTjSANTNwvDUxcFdbJfAxCVp1ak47VTU9pd?=
 =?us-ascii?Q?3rPWe9vxcA89Dqoo+ajSkM+dg/YXgYsyjhW4/bKQ+Ds+ult+4lChkOHmsiv9?=
 =?us-ascii?Q?S9VlDrQEazb2yoy/VTChvWJ0czY91S/Zq6q+V9fO0FWqu5b4eoq5SL6M4C8f?=
 =?us-ascii?Q?YdWv3UPnrOM4gvwTwElwr7+mvzdqssZTJsH34NX1YdARXLpYEFsZYp3H1w1J?=
 =?us-ascii?Q?TNb8NcwCNeKbMmFyx+EaRkCJu1hIwuUOodeKM5qvitjjVgntXNPwg5QvHFZH?=
 =?us-ascii?Q?0VZV4U+rqPIiXzW1QuRi4Fzxt0clJW63+e0AJgbXHbzyEZnaC5iptElqJ4jj?=
 =?us-ascii?Q?0ChARNEcUqTHCIEOuZJM7ZVgNsgAcEj5D8FE/YyMulKZG8c+z9jW4njN89QY?=
 =?us-ascii?Q?AMpAAFXJcjBFFdU0DCe1qKb+JJU6Z95FWI2FftxG38M9mZ1I979bMfMG/FOi?=
 =?us-ascii?Q?zgIbt/YcNZwbDJXuv0G3mlFIB9aKy61sdCLkRTyXGk156LIFEYrerzfXxuUH?=
 =?us-ascii?Q?6qCJPJl43OVO+uxIz1A0yw+6SWzv18wHVF+xZ1rBrON2yPNe/heIoIQ/SzDi?=
 =?us-ascii?Q?j0Qt/KnHPrcLZDoZcN9CY15T07pRxjOy/Sdicv5p2fdmRtVkRgbiPk/owU9n?=
 =?us-ascii?Q?cNUZ6ggpQN8Ak11pKV1gV4KiKUwiUn+Eqzld5dui3IG3J2mySOXTN7mMSM4e?=
 =?us-ascii?Q?cRHi9hv9DVwa5JL1uo/kj4D5oIqp0JYpWLNBeEgO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df713e5-70e6-4490-740f-08ddba45b6d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:24:34.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsOCQUqV7ixGZTU06LfuYPoZyy1v4yjK9IGSClpdBMXlWYlsUEKjnQ2061KzSA+k9/hsh8lydb03+9RFoHKrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9015

On Thu, Jul 03, 2025 at 04:44:28PM +0530, Manikanta Guntupalli wrote:
> Add an I3C master driver and maintainers fragment
> for the AMD I3C bus controller.
> The driver currently supports the I3C bus operating in
> SDR pure i3c mode,

Does it support i2c mode? if not, look like break spec. If spec allow
i3c only mode, please let me know.

> with features including Dynamic Address
> Assignment, private data transfers, and CCC transfers in both
> broadcast and direct modes.

can you warp at 75 char, and extern space line between two paragraph
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
>  MAINTAINERS                         |   7 +
>  drivers/i3c/master/Kconfig          |  16 +
>  drivers/i3c/master/Makefile         |   1 +
>  drivers/i3c/master/amd-i3c-master.c | 945 ++++++++++++++++++++++++++++
>  4 files changed, 969 insertions(+)
>  create mode 100644 drivers/i3c/master/amd-i3c-master.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cb9e55021cb..28ee1554cb0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11416,6 +11416,13 @@ L:	linux-i2c@vger.kernel.org
>  S:	Maintained
>  F:	drivers/i2c/i2c-stub.c
>
> +I3C DRIVER FOR AMD AXI I3C MASTER
> +M:	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> +R:	Michal Simek <michal.simek@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> +F:	drivers/i3c/master/amd-i3c-master.c
> +
>  I3C DRIVER FOR ASPEED AST2600
>  M:	Jeremy Kerr <jk@codeconstruct.com.au>
>  S:	Maintained
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index 77da199c7413..a77d288d2464 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -1,4 +1,20 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +config AMD_I3C_MASTER
> +	tristate "AMD I3C Master driver"
> +	depends on I3C
> +	depends on HAS_IOMEM
> +	help
> +	  Support for AMD I3C Master Controller.
> +
> +	  This driver allows communication with I3C devices using the AMD
> +	  I3C master, currently supporting Standard Data Rate (SDR) mode.
> +	  Features include Dynamic Address Assignment, private transfers,
> +	  and CCC transfers in both broadcast and direct modes.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called amd-i3c-master.
> +
>  config CDNS_I3C_MASTER
>  	tristate "Cadence I3C master driver"
>  	depends on I3C
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index 3e97960160bc..c0167aa1f1b3 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_AMD_I3C_MASTER)		+= amd-i3c-master.o
>  obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
>  obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
>  obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
> diff --git a/drivers/i3c/master/amd-i3c-master.c b/drivers/i3c/master/amd-i3c-master.c
> new file mode 100644
> index 000000000000..741aa854f925
> --- /dev/null
> +++ b/drivers/i3c/master/amd-i3c-master.c
> @@ -0,0 +1,945 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I3C master driver for the AMD I3C controller.
> + *
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i3c/master.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/unaligned.h>
> +
> +#define XI3C_RESET_OFFSET			0x04	/* Soft Reset Register */
> +#define XI3C_CR_OFFSET				0x08	/* Control Register */
> +#define XI3C_ADDRESS_OFFSET			0x0C	/* Target Address Register */
> +#define XI3C_SR_OFFSET				0x10	/* Status Register */
> +#define XI3C_CMD_FIFO_OFFSET			0x20	/* I3C Command FIFO Register */
> +#define XI3C_WR_FIFO_OFFSET			0x24	/* I3C Write Data FIFO Register */
> +#define XI3C_RD_FIFO_OFFSET			0x28	/* I3C Read Data FIFO Register */
> +#define XI3C_RESP_STATUS_FIFO_OFFSET		0x2C	/* I3C Response status FIFO Register */
> +#define XI3C_FIFO_LVL_STATUS_OFFSET		0x30	/* I3C CMD & WR FIFO LVL Register */
> +#define XI3C_FIFO_LVL_STATUS_1_OFFSET		0x34	/* I3C RESP & RD FIFO LVL Register */
> +#define XI3C_PID0_OFFSET			0x6C	/* LSB 4 bytes of the PID */
> +#define XI3C_PID1_BCR_DCR			0x70	/* MSB 2 bytes of the PID, BCR and DCR */
> +
> +#define XI3C_CR_EN_MASK				BIT(0)	/* Core Enable */
> +#define XI3C_SR_RESP_NOT_EMPTY_MASK		BIT(4)	/* Resp Fifo not empty status */
> +
> +#define XI3C_RESP_CODE_SHIFT			5
> +
> +#define XI3C_BCR_MASK				GENMASK(23, 16)
> +#define XI3C_DCR_MASK				GENMASK(31, 24)
> +#define XI3C_PID_MASK				GENMASK(63, 16)
> +#define XI3C_PID1_MASK				GENMASK(15, 0)
> +#define XI3C_WR_FIFO_LEVEL_MASK			GENMASK(15, 0)
> +#define XI3C_CMD_LEN_MASK			GENMASK(11, 0)
> +#define XI3C_RESP_CODE_MASK			GENMASK(8, 5)
> +#define XI3C_ADDR_MASK				GENMASK(6, 0)
> +#define XI3C_CMD_TYPE_MASK			GENMASK(3, 0)
> +#define XI3C_CMD_TID_MASK			GENMASK(3, 0)
> +#define XI3C_FIFOS_RST_MASK			GENMASK(4, 1)
> +
> +#define XI3C_EVEN_PARITY_LUT			0x9669
> +#define XI3C_MAXDATA_LENGTH			4095
> +#define XI3C_MAX_DEVS				32
> +#define XI3C_DAA_SLAVEINFO_READ_BYTECOUNT	8
> +
> +#define XI3C_I2C_MODE				0
> +#define XI3C_I2C_TID				0
> +#define XI3C_SDR_MODE				1
> +#define XI3C_SDR_TID				1
> +
> +#define XI3C_WORD_LEN				4
> +#define XI3C_PM_TIMEOUT_MS			1000
> +
> +/* timeout waiting for the controller finish transfers */
> +#define XI3C_XFER_TIMEOUT			(msecs_to_jiffies(1000))
> +#define XI3C_XFER_TIMEOUT_MS			1000
> +
> +#define xi3c_wrfifolevel(master)						\
> +	((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_OFFSET) &		\
> +	       XI3C_WR_FIFO_LEVEL_MASK))
> +
> +#define xi3c_rdfifolevel(master)						\
> +	((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_1_OFFSET) &	\
> +	       XI3C_WR_FIFO_LEVEL_MASK))
> +
> +struct xi3c_cmd {
> +	void *tx_buf;
> +	void *rx_buf;
> +	u16 tx_len;
> +	u16 rx_len;
> +	u8 addr;
> +	u8 type;
> +	u8 tid;
> +	bool rnw;
> +	bool is_daa;
> +	bool continued;
> +};
> +
> +struct xi3c_xfer {
> +	struct list_head node;
> +	struct completion comp;
> +	int ret;
> +	unsigned int ncmds;
> +	struct xi3c_cmd cmds[] __counted_by(ncmds);
> +};
> +
> +/**
> + * struct xi3c_master - I3C Master structure
> + * @base: I3C master controller
> + * @dev: Pointer to device structure
> + * @xferqueue: Transfer queue structure
> + * @xferqueue.list: List member
> + * @xferqueue.cur: Current ongoing transfer
> + * @xferqueue.lock: Queue lock
> + * @membase: Memory base of the HW registers
> + * @pclk: Input clock
> + * @lock: Transfer lock
> + * @pid_bcr_dcr: Poniter to PID, BCR and DCR value
> + * @num_targets: Number of i3c target devices
> + * @addrs: Slave addresses array
> + */
> +struct xi3c_master {
> +	struct i3c_master_controller base;
> +	struct device *dev;
> +	struct {
> +		struct list_head list;
> +		struct xi3c_xfer *cur;
> +		/* Queue lock */
> +		struct mutex lock;
> +	} xferqueue;
> +	void __iomem *membase;
> +	struct clk *pclk;
> +	/* Transfer lock */
> +	struct mutex lock;
> +	u64 *pid_bcr_dcr;
> +	u32 num_targets;
> +	u8 addrs[] __counted_by(num_targets);
> +};
> +
> +static inline struct xi3c_master *
> +to_xi3c_master(struct i3c_master_controller *master)
> +{
> +	return container_of(master, struct xi3c_master, base);
> +}
> +
> +static int xi3c_get_response(struct xi3c_master *master)
> +{
> +	int ret;
> +	u32 resp_reg, response_data;

try keep reverise christmas tree order

> +
> +	ret = readl_poll_timeout(master->membase + XI3C_SR_OFFSET,
> +				 resp_reg,
> +				 resp_reg & XI3C_SR_RESP_NOT_EMPTY_MASK,
> +				 0, XI3C_XFER_TIMEOUT_MS);
> +	if (ret) {
> +		dev_err(master->dev, "AXI I3C response timeout\n");
> +		return ret;
> +	}
> +
> +	response_data = readl(master->membase + XI3C_RESP_STATUS_FIFO_OFFSET);
> +
> +	/* Return response code */
> +	return (response_data & XI3C_RESP_CODE_MASK) >> XI3C_RESP_CODE_SHIFT;

use FIELD_GET()

> +}
> +
> +static void xi3c_master_wr_to_tx_fifo(struct xi3c_master *master,
> +				      struct xi3c_cmd *cmd)
> +{
> +	u8 *tx_buf = (u8 *)cmd->tx_buf;
> +	u32 data = 0;
> +	u16 len;
> +
> +	len = cmd->tx_len;
> +	if (len > 0) {
> +		len = (len >= XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
> +		memcpy(&data, tx_buf, len);
> +		tx_buf += len;
> +		cmd->tx_len -= len;
> +	}
> +	cmd->tx_buf = tx_buf;
> +
> +	/* Write the 32-bit value to the Tx FIFO */
> +	iowrite32be(data, master->membase + XI3C_WR_FIFO_OFFSET);
> +}
> +
> +static void xi3c_master_rd_from_rx_fifo(struct xi3c_master *master,
> +					struct xi3c_cmd *cmd)
> +{
> +	u8 *rx_buf = (u8 *)cmd->rx_buf;
> +	u32 data;
> +	u16 len;
> +
> +	/* Read from Rx FIFO */
> +	data = ioread32be(master->membase + XI3C_RD_FIFO_OFFSET);
> +
> +	/* Data extraction to rx_buf */
> +	len = cmd->rx_len;
> +	if (len > 0) {
> +		len = (len >= XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
> +		memcpy(rx_buf, &data, len);
> +		rx_buf += len;
> +		cmd->rx_len -= len;
> +	}
> +	cmd->rx_buf = rx_buf;
> +}

Is it possible base one
https://lore.kernel.org/linux-i3c/20250624-i3c-writesl-readsl-v3-0-63ccf0870f01@analog.com/T/#m46ce28ebfbc6726310d9ade4d75dd8111083a378

Need extend API to support big endian API. Or swap buffer before use it.

> +
> +static void xi3c_master_write_to_cmdfifo(struct xi3c_master *master,
> +					 struct xi3c_cmd *cmd, u16 len)
> +{
> +	u32 transfer_cmd = 0;
> +	u8 addr;
> +
> +	addr = ((cmd->addr & XI3C_ADDR_MASK) << 1) | (cmd->rnw & BIT(0));
> +
> +	transfer_cmd = cmd->type & XI3C_CMD_TYPE_MASK;
> +	transfer_cmd |= (u32)(!cmd->continued) << 4;
> +	transfer_cmd |= (u32)(addr) << 8;
> +	transfer_cmd |= (u32)(cmd->tid & XI3C_CMD_TID_MASK) << 28;
> +
> +	/*
> +	 * For dynamic addressing, an additional 1-byte length must be added
> +	 * to the command FIFO to account for the address present in the TX FIFO
> +	 */
> +	if (cmd->is_daa) {
> +		xi3c_master_wr_to_tx_fifo(master, cmd);
> +
> +		len++;
> +		cmd->is_daa = false;
> +	}
> +
> +	transfer_cmd |= (u32)(len & XI3C_CMD_LEN_MASK) << 16;
> +	writel(transfer_cmd, master->membase + XI3C_CMD_FIFO_OFFSET);
> +}
> +
> +static void xi3c_master_enable(struct xi3c_master *master)
> +{
> +	writel(readl(master->membase + XI3C_CR_OFFSET) | XI3C_CR_EN_MASK,
> +	       master->membase + XI3C_CR_OFFSET);
> +}
> +
> +static void xi3c_master_disable(struct xi3c_master *master)
> +{
> +	writel(readl(master->membase + XI3C_CR_OFFSET) & (~XI3C_CR_EN_MASK),
> +	       master->membase + XI3C_CR_OFFSET);
> +}
> +
> +static void xi3c_master_init(struct xi3c_master *master)
> +{
> +	u32 data;
> +
> +	/* Reset fifos */
> +	data = readl(master->membase + XI3C_RESET_OFFSET);
> +	data |= XI3C_FIFOS_RST_MASK;
> +	writel(data, master->membase + XI3C_RESET_OFFSET);
> +	usleep_range(1, 2);
> +	data &= ~XI3C_FIFOS_RST_MASK;
> +	writel(data, master->membase + XI3C_RESET_OFFSET);
> +	usleep_range(1, 2);
> +
> +	/* Enable controller */
> +	xi3c_master_enable(master);
> +}
> +
> +static struct xi3c_xfer *
> +xi3c_master_alloc_xfer(struct xi3c_master *master, unsigned int ncmds)
> +{
> +	struct xi3c_xfer *xfer;
> +
> +	xfer = kzalloc(struct_size(xfer, cmds, ncmds), GFP_KERNEL);
> +	if (!xfer)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&xfer->node);
> +	xfer->ncmds = ncmds;
> +	xfer->ret = -ETIMEDOUT;
> +
> +	return xfer;
> +}
> +
> +static void xi3c_master_free_xfer(struct xi3c_xfer *xfer)
> +{
> +	kfree(xfer);
> +}
> +
> +static u8 xi3c_even_parity(u8 p)
> +{
> +	p ^= p >> 4;
> +	p &= 0xf;
> +
> +	return (XI3C_EVEN_PARITY_LUT >> p) & 1;
> +}

There are parity8(), does it work?

> +
> +static int xi3c_master_read(struct xi3c_master *master, struct xi3c_cmd *cmd)
> +{
> +	unsigned long timeout;
> +	u16 rx_data_available;
> +	u16 data_index;
> +
> +	if (!cmd->rx_buf || cmd->rx_len > XI3C_MAXDATA_LENGTH)
> +		return -EINVAL;
> +
> +	/* Fill command fifo */
> +	xi3c_master_write_to_cmdfifo(master, cmd, cmd->rx_len);
> +
> +	timeout = jiffies + XI3C_XFER_TIMEOUT;
> +	/* Read data from rx fifo */
> +	while (cmd->rx_len > 0) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(master->dev, "XI3C read timeout\n");
> +			return -EIO;
> +		}
> +
> +		rx_data_available = xi3c_rdfifolevel(master);
> +		for (data_index = 0;
> +		     data_index < rx_data_available && cmd->rx_len > 0;
> +		     data_index++)
> +			xi3c_master_rd_from_rx_fifo(master, cmd);

Maybe it is common problem, if read size bigger than FIFO size.  During
CPU read FIFO,  if system schedule happen at this time. SCL will stall.
but I3C spec allow max stall time is 100us.  Target side will be timeout.

You can add simple dev_err() dump a message in loop and transfer size bigger
than fifo size, see what happen.

> +	}
> +	return 0;
> +}
> +
> +static int xi3c_master_write(struct xi3c_master *master, struct xi3c_cmd *cmd)
> +{
> +	unsigned long timeout;
> +	u16 wrfifo_space;
> +	u16 space_index;
> +	u16 len;
> +
> +	len = cmd->tx_len;
> +	if (!cmd->tx_buf || cmd->tx_len > XI3C_MAXDATA_LENGTH)
> +		return -EINVAL;
> +
> +	/* Fill Tx fifo */
> +	wrfifo_space = xi3c_wrfifolevel(master);
> +	for (space_index = 0; space_index < wrfifo_space && cmd->tx_len > 0;
> +	     space_index++)
> +		xi3c_master_wr_to_tx_fifo(master, cmd);
> +
> +	/* Write to command fifo */
> +	xi3c_master_write_to_cmdfifo(master, cmd, len);
> +
> +	timeout = jiffies + XI3C_XFER_TIMEOUT;
> +	/* Fill if any remaining data to tx fifo */
> +	while (cmd->tx_len > 0) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(master->dev, "XI3C write timeout\n");
> +			return -EIO;
> +		}
> +
> +		wrfifo_space = xi3c_wrfifolevel(master);
> +		for (space_index = 0; space_index < wrfifo_space && cmd->tx_len > 0;
> +		     space_index++)
> +			xi3c_master_wr_to_tx_fifo(master, cmd);
> +	}
> +	return 0;
> +}
> +
> +static int xi3c_master_xfer(struct xi3c_master *master, struct xi3c_cmd *cmd)
> +{
> +	int ret;
> +
> +	if (cmd->rnw)
> +		ret = xi3c_master_read(master, cmd);
> +	else
> +		ret = xi3c_master_write(master, cmd);
> +
> +	if (ret < 0)
> +		goto err_xfer_out;
> +
> +	if (xi3c_get_response(master))
> +		goto err_xfer_out;
> +
> +	return 0;
> +
> +err_xfer_out:
> +	xi3c_master_init(master);
> +	return -EIO;
> +}
> +
> +static void xi3c_master_dequeue_xfer_locked(struct xi3c_master *master,
> +					    struct xi3c_xfer *xfer)
> +{
> +	if (master->xferqueue.cur == xfer)
> +		master->xferqueue.cur = NULL;
> +	else
> +		list_del_init(&xfer->node);
> +}
> +
> +static void xi3c_master_dequeue_xfer(struct xi3c_master *master,
> +				     struct xi3c_xfer *xfer)
> +{
> +	mutex_lock(&master->xferqueue.lock);
> +	xi3c_master_dequeue_xfer_locked(master, xfer);
> +	mutex_unlock(&master->xferqueue.lock);
> +}
> +
> +static void xi3c_master_start_xfer_locked(struct xi3c_master *master)
> +{
> +	struct xi3c_xfer *xfer = master->xferqueue.cur;
> +	int ret = 0, i;
> +
> +	if (!xfer)
> +		return;
> +
> +	for (i = 0; i < xfer->ncmds; i++) {
> +		struct xi3c_cmd *cmd = &xfer->cmds[i];
> +
> +		ret = xi3c_master_xfer(master, cmd);
> +		if (ret)
> +			break;
> +	}
> +
> +	xfer->ret = ret;
> +	complete(&xfer->comp);
> +
> +	xfer = list_first_entry_or_null(&master->xferqueue.list,
> +					struct xi3c_xfer,
> +					node);
> +	if (xfer)
> +		list_del_init(&xfer->node);
> +
> +	master->xferqueue.cur = xfer;
> +	xi3c_master_start_xfer_locked(master);
> +}
> +
> +static void xi3c_master_enqueue_xfer(struct xi3c_master *master,
> +				     struct xi3c_xfer *xfer)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
> +		return;
> +	}
> +
> +	init_completion(&xfer->comp);
> +	mutex_lock(&master->xferqueue.lock);
> +	if (master->xferqueue.cur) {
> +		list_add_tail(&xfer->node, &master->xferqueue.list);
> +	} else {
> +		master->xferqueue.cur = xfer;
> +		xi3c_master_start_xfer_locked(master);
> +	}
> +	mutex_unlock(&master->xferqueue.lock);
> +
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
> +}
> +
> +static inline int xi3c_master_common_xfer(struct xi3c_master *master,
> +					  struct xi3c_xfer *xfer)
> +{
> +	int ret, timeout;
> +
> +	mutex_lock(&master->lock);

all mutext_lock, please use guard(mutext)(&master->lock);

> +	xi3c_master_enqueue_xfer(master, xfer);
> +	timeout = wait_for_completion_timeout(&xfer->comp,
> +					      msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS));
> +	if (!timeout)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = xfer->ret;
> +
> +	if (ret)
> +		xi3c_master_dequeue_xfer(master, xfer);
> +
> +	mutex_unlock(&master->lock);
> +	xi3c_master_free_xfer(xfer);
> +
> +	return ret;
> +}
> +
> +static int xi3c_master_do_daa(struct i3c_master_controller *m)
> +{
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	struct xi3c_cmd *daa_cmd;
> +	struct xi3c_xfer *xfer;
> +	u8 pid_bufs[XI3C_MAX_DEVS][8];
> +	int addr, ret, i;
> +	u8 data, last_addr = 0;
> +	u8 *pid_buf;
> +
> +	if (master->num_targets == 0 || master->num_targets > XI3C_MAX_DEVS) {
> +		dev_err(master->dev, "Invalid / No target devices connected\n");
> +		return -EIO;

Please refer:
https://lore.kernel.org/linux-i3c/20250626-adi-i3c-master-v4-0-3846a1f66d5e@analog.com/T/#t
the method to handle num_targets.

> +	}
> +
> +	master->pid_bcr_dcr = kcalloc(master->num_targets, sizeof(u64), GFP_KERNEL);

only this function use pid_bcr_dcr, needn't put it into master

you can use
	void * __free(free) pid_bcr_dcr = kcalloc(); to simple below error
message

> +	if (!master->pid_bcr_dcr)
> +		return -ENOMEM;
> +
> +	xfer = xi3c_master_alloc_xfer(master, master->num_targets + 1);
> +	if (!xfer) {
> +		ret = -ENOMEM;
> +		goto err_daa_mem;
> +	}
> +
> +	/* Fill ENTDAA CCC */
> +	data = I3C_CCC_ENTDAA;
> +	daa_cmd = &xfer->cmds[0];
> +	daa_cmd->addr = I3C_BROADCAST_ADDR;
> +	daa_cmd->rnw = 0;
> +	daa_cmd->tx_buf = &data;
> +	daa_cmd->tx_len = 1;
> +	daa_cmd->type = XI3C_SDR_MODE;
> +	daa_cmd->tid = XI3C_SDR_TID;
> +	daa_cmd->continued = true;
> +
> +	for (i = 1; i < master->num_targets + 1; i++) {
> +		struct xi3c_cmd *cmd = &xfer->cmds[i];
> +
> +		pid_buf = pid_bufs[i - 1];
> +		addr = i3c_master_get_free_addr(m, last_addr + 1);
> +		if (addr < 0) {
> +			ret = -ENOSPC;
> +			goto err_daa;
> +		}
> +
> +		last_addr = (u8)addr;
> +		master->addrs[i - 1] = (u8)addr;
> +		addr = (addr << 1) | xi3c_even_parity((u8)addr);
> +
> +		cmd->tx_buf = (u8 *)&addr;
> +		cmd->tx_len = 1;
> +		cmd->addr = I3C_BROADCAST_ADDR;
> +		cmd->rnw = 1;
> +		cmd->rx_buf = pid_buf;
> +		cmd->rx_len = XI3C_DAA_SLAVEINFO_READ_BYTECOUNT;
> +		cmd->is_daa = true;
> +		cmd->type = XI3C_SDR_MODE;
> +		cmd->tid = XI3C_SDR_TID;
> +		cmd->continued = i < master->num_targets;
> +	}
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	if (ret)
> +		goto err_daa_mem;
> +
> +	for (i = 0; i < master->num_targets; i++) {
> +		ret = i3c_master_add_i3c_dev_locked(m, master->addrs[i]);
> +		if (ret)
> +			goto err_daa_mem;
> +
> +		master->pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
> +						   get_unaligned_be64(pid_bufs[i]));
> +		dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, master->pid_bcr_dcr[i]);
> +	}
> +
> +	kfree(master->pid_bcr_dcr);
> +	return 0;
> +
> +err_daa:
> +	xi3c_master_free_xfer(xfer);
> +err_daa_mem:
> +	kfree(master->pid_bcr_dcr);
> +	xi3c_master_init(master);
> +	return ret;
> +}
> +
> +static bool
> +xi3c_master_supports_ccc_cmd(struct i3c_master_controller *master,
> +			     const struct i3c_ccc_cmd *cmd)
> +{
> +	if (cmd->ndests > 1)
> +		return false;
> +
> +	switch (cmd->id) {
> +	case I3C_CCC_ENEC(true):
> +	case I3C_CCC_ENEC(false):
> +	case I3C_CCC_DISEC(true):
> +	case I3C_CCC_DISEC(false):
> +	case I3C_CCC_ENTAS(0, true):
> +	case I3C_CCC_ENTAS(0, false):
> +	case I3C_CCC_RSTDAA(true):
> +	case I3C_CCC_RSTDAA(false):
> +	case I3C_CCC_ENTDAA:
> +	case I3C_CCC_SETMWL(true):
> +	case I3C_CCC_SETMWL(false):
> +	case I3C_CCC_SETMRL(true):
> +	case I3C_CCC_SETMRL(false):
> +	case I3C_CCC_ENTHDR(0):
> +	case I3C_CCC_SETDASA:
> +	case I3C_CCC_SETNEWDA:
> +	case I3C_CCC_GETMWL:
> +	case I3C_CCC_GETMRL:
> +	case I3C_CCC_GETPID:
> +	case I3C_CCC_GETBCR:
> +	case I3C_CCC_GETDCR:
> +	case I3C_CCC_GETSTATUS:
> +	case I3C_CCC_GETMXDS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int xi3c_master_send_bdcast_ccc_cmd(struct xi3c_master *master,
> +					   struct i3c_ccc_cmd *ccc)
> +{
> +	u16 xfer_len = ccc->dests[0].payload.len + 1;
> +	struct xi3c_xfer *xfer;
> +	struct xi3c_cmd *cmd;
> +	int ret;
> +	u8 *buf;
> +
> +	xfer = xi3c_master_alloc_xfer(master, 1);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	buf = kmalloc(xfer_len, GFP_KERNEL);
> +	if (!buf) {
> +		xi3c_master_free_xfer(xfer);
> +		return -ENOMEM;
> +	}
> +
> +	buf[0] = ccc->id;
> +	memcpy(&buf[1], ccc->dests[0].payload.data, ccc->dests[0].payload.len);
> +
> +	cmd = &xfer->cmds[0];
> +	cmd->addr = ccc->dests[0].addr;
> +	cmd->rnw = ccc->rnw;
> +	cmd->tx_buf = buf;
> +	cmd->tx_len = xfer_len;
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = false;
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	kfree(buf);

the same here, use __free(kfree)

> +
> +	return ret;
> +}
> +
> +static int xi3c_master_send_direct_ccc_cmd(struct xi3c_master *master,
> +					   struct i3c_ccc_cmd *ccc)
> +{
> +	struct xi3c_xfer *xfer;
> +	struct xi3c_cmd *cmd;
> +
> +	xfer = xi3c_master_alloc_xfer(master, 2);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	/* Broadcasted message */
> +	cmd = &xfer->cmds[0];
> +	cmd->addr = I3C_BROADCAST_ADDR;
> +	cmd->rnw = 0;
> +	cmd->tx_buf = &ccc->id;
> +	cmd->tx_len = 1;
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = true;
> +
> +	/* Directed message */
> +	cmd = &xfer->cmds[1];
> +	cmd->addr = ccc->dests[0].addr;
> +	cmd->rnw = ccc->rnw;
> +	if (cmd->rnw) {
> +		cmd->rx_buf = ccc->dests[0].payload.data;
> +		cmd->rx_len = ccc->dests[0].payload.len;
> +	} else {
> +		cmd->tx_buf = ccc->dests[0].payload.data;
> +		cmd->tx_len = ccc->dests[0].payload.len;
> +	}
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = false;
> +
> +	return xi3c_master_common_xfer(master, xfer);
> +}
> +
> +static int xi3c_master_send_ccc_cmd(struct i3c_master_controller *m,
> +				    struct i3c_ccc_cmd *cmd)
> +{
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	bool broadcast = cmd->id < 0x80;
> +
> +	if (broadcast)
> +		return xi3c_master_send_bdcast_ccc_cmd(master, cmd);
> +
> +	return xi3c_master_send_direct_ccc_cmd(master, cmd);
> +}
> +
> +static int xi3c_master_priv_xfers(struct i3c_dev_desc *dev,
> +				  struct i3c_priv_xfer *xfers,
> +				  int nxfers)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	struct xi3c_xfer *xfer;
> +	int i;
> +
> +	if (!nxfers)
> +		return 0;
> +
> +	xfer = xi3c_master_alloc_xfer(master, nxfers);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		struct xi3c_cmd *cmd = &xfer->cmds[i];
> +
> +		cmd->addr = dev->info.dyn_addr;
> +		cmd->rnw = xfers[i].rnw;
> +
> +		if (cmd->rnw) {
> +			cmd->rx_buf = xfers[i].data.in;
> +			cmd->rx_len = xfers[i].len;
> +		} else {
> +			cmd->tx_buf = (void *)xfers[i].data.out;
> +			cmd->tx_len = xfers[i].len;
> +		}
> +
> +		cmd->type = XI3C_SDR_MODE;
> +		cmd->tid = XI3C_SDR_TID;
> +		cmd->continued = (i + 1) < nxfers;
> +	}
> +
> +	return xi3c_master_common_xfer(master, xfer);
> +}
> +
> +static int xi3c_master_i2c_xfers(struct i2c_dev_desc *dev,
> +				 struct i2c_msg *xfers,
> +				 int nxfers)
> +{
> +	struct i3c_master_controller *m = i2c_dev_get_master(dev);
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	struct xi3c_xfer *xfer;
> +	int i;
> +
> +	if (!nxfers)
> +		return 0;
> +
> +	xfer = xi3c_master_alloc_xfer(master, nxfers);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		struct xi3c_cmd *cmd = &xfer->cmds[i];
> +
> +		cmd->addr = xfers[i].addr & XI3C_ADDR_MASK;
> +		cmd->rnw = xfers[i].flags & I2C_M_RD;
> +
> +		if (cmd->rnw) {
> +			cmd->rx_buf = xfers[i].buf;
> +			cmd->rx_len = xfers[i].len;
> +		} else {
> +			cmd->tx_buf = (void *)xfers[i].buf;
> +			cmd->tx_len = xfers[i].len;
> +		}
> +
> +		cmd->type = XI3C_I2C_MODE;
> +		cmd->tid = XI3C_I2C_TID;
> +		cmd->continued = (i + 1) < nxfers;
> +	}
> +
> +	return xi3c_master_common_xfer(master, xfer);
> +}
> +
> +static int xi3c_master_bus_init(struct i3c_master_controller *m)
> +{
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	struct i3c_bus *bus = i3c_master_get_bus(m);
> +	struct i3c_device_info info = { };
> +	u64 pid1_bcr_dcr;
> +	int ret;
> +
> +	if (bus->mode != I3C_BUS_MODE_PURE)
> +		ret = -EINVAL;
> +
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev,
> +			"<%s> cannot resume i3c bus master, err: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	/* Get an address for the master. */
> +	ret = i3c_master_get_free_addr(m, 0);
> +	if (ret < 0)
> +		goto rpm_out;
> +
> +	info.dyn_addr = (u8)ret;
> +
> +	/* Write the dynamic address value to the address register. */
> +	writel(info.dyn_addr, master->membase + XI3C_ADDRESS_OFFSET);
> +
> +	/* Read PID, BCR and DCR values, and assign to i3c device info. */
> +	pid1_bcr_dcr = readl(master->membase + XI3C_PID1_BCR_DCR);
> +	info.pid = ((FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr) << 32) |
> +		    readl(master->membase + XI3C_PID0_OFFSET));
> +	info.bcr = (u8)FIELD_GET(XI3C_BCR_MASK, pid1_bcr_dcr);
> +	info.dcr = (u8)FIELD_GET(XI3C_DCR_MASK, pid1_bcr_dcr);
> +
> +	ret = i3c_master_set_info(&master->base, &info);
> +	if (ret)
> +		goto rpm_out;
> +
> +	xi3c_master_init(master);
> +
> +rpm_out:
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
> +	return ret;
> +}
> +
> +static void xi3c_master_bus_cleanup(struct i3c_master_controller *m)
> +{
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
> +		return;
> +	}
> +
> +	xi3c_master_disable(master);
> +
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
> +}
> +
> +static const struct i3c_master_controller_ops xi3c_master_ops = {
> +	.bus_init = xi3c_master_bus_init,
> +	.bus_cleanup = xi3c_master_bus_cleanup,
> +	.do_daa = xi3c_master_do_daa,
> +	.supports_ccc_cmd = xi3c_master_supports_ccc_cmd,
> +	.send_ccc_cmd = xi3c_master_send_ccc_cmd,
> +	.priv_xfers = xi3c_master_priv_xfers,
> +	.i2c_xfers = xi3c_master_i2c_xfers,
> +};
> +
> +static int xi3c_master_probe(struct platform_device *pdev)
> +{
> +	struct xi3c_master *master;
> +	int ret;
> +
> +	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
> +	if (!master)
> +		return -ENOMEM;
> +
> +	master->membase = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(master->membase))
> +		return PTR_ERR(master->membase);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,num-targets",
> +				   &master->num_targets);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to read xlnx,num-targets\n");
> +		return ret;
> +	}

	if (ret)
		return dev_err_probe(...);

> +
> +	master->pclk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(master->pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(master->pclk),
> +				     "Failed to get and enable clock\n");
> +
> +	master->dev = &pdev->dev;
> +
> +	mutex_init(&master->lock);
> +	mutex_init(&master->xferqueue.lock);
> +	INIT_LIST_HEAD(&master->xferqueue.list);
> +
> +	platform_set_drvdata(pdev, master);
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, XI3C_PM_TIMEOUT_MS);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);

devm_pm_runtime_enable();

> +
> +	ret = i3c_master_register(&master->base, &pdev->dev,
> +				  &xi3c_master_ops, false);
> +	if (ret)
> +		goto err_rpm_disable;
> +
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_put_autosuspend(&pdev->dev);
> +
> +	return 0;
> +
> +err_rpm_disable:
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static void xi3c_master_remove(struct platform_device *pdev)
> +{
> +	struct xi3c_master *master = platform_get_drvdata(pdev);
> +
> +	i3c_master_unregister(&master->base);
> +
> +	pm_runtime_disable(master->dev);
> +	pm_runtime_set_suspended(master->dev);
> +	pm_runtime_dont_use_autosuspend(master->dev);
> +}
> +
> +static int __maybe_unused xi3c_master_runtime_suspend(struct device *dev)

use moderm method, needn't __maybe.

> +{
> +	struct xi3c_master *master = dev_get_drvdata(dev);
> +
> +	xi3c_master_disable(master);
> +	clk_disable_unprepare(master->pclk);
> +	return 0;
> +}
> +
> +static int __maybe_unused xi3c_master_runtime_resume(struct device *dev)
> +{
> +	struct xi3c_master *master = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(master->pclk);
> +	if (ret)
> +		return ret;
> +
> +	xi3c_master_enable(master);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops xi3c_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(xi3c_master_runtime_suspend, xi3c_master_runtime_resume,
> +			   NULL)
> +};

use DEFINE_RUNTIME_DEV_PM_OPS()

Are you sure need runtime_pm because I3C support IBI, does IBI can trigger
host irq without enable clock.

> +
> +static const struct of_device_id xi3c_master_of_ids[] = {
> +	{ .compatible = "xlnx,axi-i3c-1.0" },
> +	{ },
> +};
> +
> +static struct platform_driver xi3c_master_driver = {
> +	.probe = xi3c_master_probe,
> +	.remove = xi3c_master_remove,
> +	.driver = {
> +		.name = "axi-i3c-master",
> +		.of_match_table = xi3c_master_of_ids,
> +		.pm = &xi3c_pm_ops,

pm_ptr(&xi3c_pm_op);

Frank
> +	},
> +};
> +module_platform_driver(xi3c_master_driver);
> +
> +MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
> +MODULE_DESCRIPTION("AXI I3C master driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>
