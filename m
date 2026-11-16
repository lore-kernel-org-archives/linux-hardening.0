Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794862762;
	b=dBs8/9skcr5LyKgukoR6VQRqABLIvWw8wi08eb1dHrtT7HU+d2/7bndg1xm1Bd9mWfXo
	 ZLB9tNXvzBxBVisU+Nu/p1rVYn/OeYeKJVhoR09Yma/QT+AzmIRxCsdWUiaTzPuF35YEV
	 D1RqaHXxuw+3sH6IW9ZsRmxWoGl1uRF7RdguI8oshFb16cnBxU7bCgUa22apSrHkFH2kQ
	 wraxMkXROJXklZy4PqXiuenvtRN3NsfEQ5YlUDohBD87YsJbCU0mKgmNuZvvcvmR7vFOs
	 ax3U66oul0EdM8M0+8v7euB/+abVSPhtKrDM4Cs5kD0btLVtiG9pUEHja3odhoWohnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862762;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gvTC2k4tAd38sWWHouOR+HXkpP1oXwdoSKUjIePrPfk=;
	b=gTKTlf1q7IQVhsaesu+eoxP5btC+jOMtQWF90OBo2Y0KBdf11YaUM/AR2zTKPKdEUgyr
	 ucBlcZ+oUy7EP0liPw8QP7N27BFLJ+iHO1pbBmjVeEh2vsVkzctjXHrT7qjASud2egCEp
	 qV6qKPWoU1jZCJzH+VZPtvJt9LYAlwG5Z2qLITivRB+t863o0tbQGdOmzyeBVoPYkSahq
	 LCghelvIRswFCW35fqPPb781CLZ/aVGtFXH05hHusn3+wwfX9knzu8GUD09dkE/PFqFo7
	 eWDDyW4gilfEDterBjhyOE8ePnxjSoL1r2U3knoLe3o9XLns5pACitgoaL9sx5aObCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lpFQhhDA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.70
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE71606A322;
	Mon, 16 Nov 2026 20:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE71606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lpFQhhDA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdk3qKW608fEopsBorPPFIDDvQKUgb3ALM4TzP3OvNGknk7bYyLBhPcCeMGxqoK6hW97Mzub/3xPm9aJuJNorBiIZ3s+ZxJ3sXYckgt+oQl/JUqahVdRv8sgu1Dk2R3jISflpzzq/mJKQGlxBIqQ74DGAtbHSh1RUmQTz/GbROeceW7aMlLTfawsJWx96C0E/SI5A4dZKCEISQBZ3KShfjeGirsj34nW1fsQ3cCgPnFqJcoYtbaPxeZwKT+lLXNFQBt/fRm6DZ5S7FYtv540CJNcowqZHLL/HDjr1CwEeXG3+2gmk07cIQnVf9Hf3kRhkgSO1EmHfgbY/Ro806G3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvTC2k4tAd38sWWHouOR+HXkpP1oXwdoSKUjIePrPfk=;
 b=t8dHFhQaiUaIIJfnzzozSCCFrURQci6xEwtXRZOzV01KlWjkiEqUNx9XIoJKS1IjPIuZSMEqJl/bZ3C68HChXdcEFRjpqCv7VUO/XPj34F4qSLOpDw+Z24ICorbUbPXTkfts/mboIIUQz9BFvQe82r/rt5h0TUo5svxHfrnxjiI27kLr0lM/+VfT9RMrsro3XU2LTpGiMMA6vgt7j07RXAvi2Qmky0SzURAnXb/luhaktG8O11W1dd1tEg4tFXhuYdyJhoysWLV69nuz8squdyECK4s8v/wwp8oNkhM6yTiHZ+Xk6CPd+o/GBr/K3MZ7UfferpWPk5/xPbSAReq4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvTC2k4tAd38sWWHouOR+HXkpP1oXwdoSKUjIePrPfk=;
 b=lpFQhhDAc50ay3Aw1hFQtydq58Y/+o+E9YEes832WB+0ILI3tPvSrYPeCicuRE+xRX4Hk6AdJ/ufp+R0j51rlnB7FPhgBhC4IIXELd0MM0BKMxghLR4CQTgY5D8oJT75/AGzfZ/KpIhC8m8WhJaLSGHpAX8+KDLc17Gy9ZGACYNtqaz76z96PeUnV42zMNJUPrSTG50e876BIWLGq/depe+ouQhy2P1AuxazkiVjyz1TCkzPFDwEYRvVgfQXoKAFflF8t0A3vPe0ozI1YOBQH+M9XiFn2/LFb6oSWU+yGaFVUD3sInUm94ZvSjI6r4aWSSR5pCbxrLagHNyj38WqUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 16 Nov
 2026 20:59:19 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:59:19 +0000
Date: Mon, 16 Nov 2026 14:59:07 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org,
	Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: nuvoton,ma35d1-pdma: Document
 MA35D1 PDMA controller
Message-ID: <avtum_vwVClf7xhE@SMW015318>
References: <20261109052900.2960473-1-shanchun1218@gmail.com>
 <20261109052900.2960473-2-shanchun1218@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109052900.2960473-2-shanchun1218@gmail.com>
X-ClientProxiedBy: PH7P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 903602b0-eeed-42af-2f1f-08df44247b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|19092799006|376014|23010399003|261021121427099003|261009223027099003|261102123227099003|56012099006|261022105027099003|4143699003|11063799006|261028144727099003|261026140227099003|261026121527099003|22082099003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jleGS+IrXT1K3T3WgUvtEzsL2Im0AGG0X51VTp2Wc7sQ4Xtmhph36AIgnGmNCEICmFaOlr0HHX06Wy+HO0vafPl/jELI9hWiWaw4L0qMj0WSeuU3kTZNA+lLR55iwDJx6k3fVASW2iAEBCyipEEx7+5C0EglPlNy+Z37ohA6mPKMos9Wkmd75u/gUE7Kzrvw2q0rQetgSJK0VoLggGuo3s8jzm/vGH5UuyCEyXn2yyXAnQ7GknN4h21aS3L2OOPYoqrpzleecJNzKt7OTQx1NZESuWmMaVYQQ7Xa4/Hdr1AlJoVnk5jUurmIjj1x3iJqDcJ9zK4U+hMTrIKZMgeJ0PRBnqVYUAii74ZY+7VAG5+E01aAN2WePNyseaKRegWIuPJhR3MlcNu7EQokhTYVOJJ9tQj0ZttSIotptC/46Xy9/x7zkebjXMqrP1JtNy54WR8UWs7B8eZPJ/CU8iPvMIsofiNOvIQp48M61uQOddooUzEjdTWJUcnH37KHKW2hh++kAeM+H+uV9520Cl69u3i8ngHmnLFCeuLkFDm2fkNv5Lhi7JvFkYKVwwQ1sFDEgTkVGWsjpC3Dltj0aqBzEuVO6+iOSFh2t/FW/c3GIVrOpgvIE1CH4bd4W0fd9E8a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(19092799006)(376014)(23010399003)(261021121427099003)(261009223027099003)(261102123227099003)(56012099006)(261022105027099003)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(22082099003)(18002099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bP6yfqwVV3dhJ3dgM8hUHLvL34IMcvYZlZZFK+bBY5PGsS14TiQBnmvQ0Mrl?=
 =?us-ascii?Q?+XQTZOKIDssDUklSCzFt0F43Z5mQDwdw6Z9oF9Rg3U7a34uYzvMeMeWzToVZ?=
 =?us-ascii?Q?1Y3r+oYgLRYiFzz9Lolv8jAa1C/xJa7Ls0y/1IRdwKZt5pG2qkLb2/JJ/zWc?=
 =?us-ascii?Q?LKGzfJyB5UOUDkC/E0gHXhce8Wy05Oye7/1kbzHBksJYsoZTGqboH+YwDbr2?=
 =?us-ascii?Q?qufzkObjG3d0KeX+dGbPDCnn+L021+unvnW81dwY90IGNoBDsGvJiZW3t41r?=
 =?us-ascii?Q?/lpCjW7UN2oIPffQH+uWSlw+NSGT3gmTHQBTKDUc8EozqI35KbJFxKbWS2b5?=
 =?us-ascii?Q?aJyuHiBhUHCLtHexNk3oeO/b8pcEmvhn+RRvVxQkHX+J0KDWn6qVtrAoZf+W?=
 =?us-ascii?Q?vXWj3FQc7kn+BqKvGAIZVzlB7+SZ0TNIfEtdpeXiBbnonIwAOH41GxTiGxCE?=
 =?us-ascii?Q?GT2qyr9VT24tYk3CzvHqwr4Z7tZ9M3ESrDX+R8j6QQzQjTGYQWLgMCEZgr6i?=
 =?us-ascii?Q?cW6RLAAJawzyOP1PupkiXjrVV2KJbqo80K9hQitNP+wWx4z3iNDdvce5CF5T?=
 =?us-ascii?Q?Bm/ahGwozzwmFRiWffVDVCFWNE5qRVBf/vNlpCeRyVNKXHJLMwKDEV9PlxJp?=
 =?us-ascii?Q?6G3m4MVBOALfM0MLzcUQKQ2OyoXtrEmdM97GHqy75wUH27KlyAeN5X5gxD92?=
 =?us-ascii?Q?k54RE8KTgFswfyw400QBGEA+OUFxN20hJxIUjdbBNUe9tyJqP6TmSzwnifsf?=
 =?us-ascii?Q?hwGnVx/BE1c10ZBBcukLcf/4t5EJeBWjMbOaB9Vc2L5wcMjmJKDzlnHE6Knh?=
 =?us-ascii?Q?loxtYEuiJ3CqtjMzx4Dy6n4puLv3LwiSLnxcTwBG/dGDrV8Fo1hktmGaNids?=
 =?us-ascii?Q?/0P4GKMd1wj6PsJA67jCmffsmdrB+tKqtqQVaeTFnje0N6K234rJrMBjvD4l?=
 =?us-ascii?Q?JdQmSSRYV6+vxGFq/gpj3LyjVfUfiR8iRPomafUJCTczBLc7nouC2qgXetca?=
 =?us-ascii?Q?XgI2ahAAJDeu58viECSIW/66TD+fiqeQp4pUz1sFglhwZNg3XUfQo16VLFGS?=
 =?us-ascii?Q?tMjCYalGrCQfcSUK2Xl2fdLFipIZvMvMZJE7q1JxN2wIaz6BdRVuyVC37KJu?=
 =?us-ascii?Q?SlMZMUT60359HOBx9bnGLGXIuKHq+oiTP8KWrntovIIH9ClFvKJDw0IYPIvQ?=
 =?us-ascii?Q?TRZUfkl+Hdkh7VSELAB+APKPCah5arWwq97HQ9Bop2qvCoyZNgkJcJgQQTFu?=
 =?us-ascii?Q?LyAM2h651cmDzIHXiv3bQ8uaQ12W3WxHf6qKp9K6WaHy74jsWfL3ma7eSkEu?=
 =?us-ascii?Q?CMDSq9qKpz9kX9G5F2w3OLkTkrBPzA7ZK+EcV8YtDvMkoFWAQXyGazaXxw3F?=
 =?us-ascii?Q?RWsybgTKH4P4MV0+dfev0sxsis1jfQZ1ixTvoOStiBRirogP4rZuiOeKogY3?=
 =?us-ascii?Q?oWmH2lxnEOyDbJ3zLOSOshu3w3Y4vkCfmB8D2vKH2uix0QxSbKqjeuDHqmNT?=
 =?us-ascii?Q?xmwG5sgE5R4gD/9fihaWKxUEl7viBeOYNi9iWX/PDLHcc6mXbZIun1YnHoJt?=
 =?us-ascii?Q?ctjyKhCWjLVML2wiTqw3SRfd0E30w+mCiV0lA2LIOX70N/CaPjgHKlQCvOCV?=
 =?us-ascii?Q?fvli134HixbKwdjy7Z44gsymqbkewoCh4No7chxCE+laCCMuR5ydfGMkltwH?=
 =?us-ascii?Q?YP0gfu7M+u5WEbIs8Lh5wW2P+YwAV9aO07HRmyjkgXX+EHzhTwMHJBFe6kmN?=
 =?us-ascii?Q?GpC1t19J0PTJum/sRBnItgF4wkQxJeDavhU6VpprejdDSq/78wBK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903602b0-eeed-42af-2f1f-08df44247b4b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:59:18.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj21gRrAo+pCZF8smRwGu/2DyU88yhqgbYjiyO7VpXqB06BttePp/jeF2cGvAohsho+l/y/2gx4hhZDOuK5gBy3Dq8ph/XIaiY1S7ccFIrLIAlTEU3adbrP/v+qfBr9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

On Mon, Nov 09, 2026 at 01:28:59PM +0800, Shan-Chun Hung wrote:
> Add binding for Nuvoton MA35D1 PDMA controller.
>
> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../bindings/dma/nuvoton,ma35d1-pdma.yaml     | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
> new file mode 100644
> index 000000000000..d05971662a5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nuvoton,ma35d1-pdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 PDMA controller
> +
> +description:
> +  The MA35D1 SoC has four Peripheral DMA (PDMA) controllers. Each controller
> +  has 10 channels and performs memory-to-memory, memory-to-peripheral and
> +  peripheral-to-memory transfers.
> +
> +maintainers:
> +  - Shan-Chun Hung <shanchun1218@gmail.com>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-pdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 2
> +    description:
> +      The first cell is the PDMA channel number. The second cell is the
> +      peripheral request source number, as listed in the reference manual.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - "#dma-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        dma-controller@40080000 {
> +            compatible = "nuvoton,ma35d1-pdma";
> +            reg = <0x0 0x40080000 0x0 0x2000>;
> +            interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk PDMA0_GATE>;
> +            resets = <&sys MA35D1_RESET_PDMA0>;
> +            #dma-cells = <2>;
> +        };
> +    };
> +
> +...
> --
> 2.25.1
>
