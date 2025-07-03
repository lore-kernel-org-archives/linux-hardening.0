Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B02EA756;
	Thu,  3 Jul 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553508; cv=fail; b=dsUvZr+0RcLZ7+Mj79P7bdZFUafeiLaZqmtjX3P6eD+rndRUVXkLdYAv5WKsQR/AkOKUslNPhcNaozGTwyvUtJDHdcPBP1D8nxCxzjzK5AjRUPUns0YWF28ekIfUNu7re91iAQyTrA1CpHSHDaSIMDOMkMmv5CPacrCcFpZbYrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553508; c=relaxed/simple;
	bh=5MOEPH5f5DrnMqVmiHlFIbr4MsXus7YHAvRibT6O5eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zfx6BKMFOId+2sm6hDRg7shoCTXpOZrDtvSz58XEpZZFzdw1xRKOmjDzGntLDn+FDbMY2SjW/9XqyQ744P+vfiGtMUZWNNN46LfECqWUVFNKTS3YaLQ8tunhBfYtEbDH+BpFRlqRzN044zjfhleaD5NWyzKDjEBDssLwTPBTxWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HO3/KjRU; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HO3/KjRU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzcnNpsJG94UPx+b42idS2Zail8LFFyvsTM0IboSlNFz+ApXr56PCfA44A5PGiX1tHVv+fPxp77Pq5eN3BARrffqkkxXpH0JtxAx1ovqW8840fU9kX2JKcjOiR1Uw8tHYZnYmCQ3sflbRq8hoiRC0u9vFdJGaacn51F8Ea+rjqEvM/71uCMAVsdsmSr0mvTTVG2ul0KQhYDF+ffON92It5VMKCk/yw6INVpfBK6h1FBFL4rM4GPIBu2uHbBW37fal9sl4+QBHfDTpnbnmsx+bfxaEX7tluu92Dj5JHe/f7GMLccZCzfy/ZIErwp/jetqQFZuBlv6YsvtMU5ofvuAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x2tkYbn0G82XOJ1cL0At8IfUd1SXx5B92iHaNn0Lxo=;
 b=tZJ1d/8mleDWRU6NDJGfwhhzKnMLRhM95ywDJKmpQCUSVaNly6B6269TqfVyR6v9Vm5p6lrVMs1V9fvPpq2lzAFrCKRl0SQDRLdnESTCl1i1IZToE/EtkDMoHrTcL4KKIQFC3IG7gyuduLifKzL/R0JjdZdROkqhs3hKBvFfKol1IV7IVUF+XwwuA/1zSm3RN6DfO42PRCXjUx4rLFXS+Ix2qo0WPy/iV6kYeri9AYKtgccQao3s5pKYlH5M8/KAafoHJQ6iBfzr5GXA688z2wtwUgK9hhqCa2zIEAvtO4L4Nbtbv/ClsDQcqY06gQ/a6QX82vvhffmXjFAOViip/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x2tkYbn0G82XOJ1cL0At8IfUd1SXx5B92iHaNn0Lxo=;
 b=HO3/KjRUJmbkawEKK4hC68SCEIMQxfFRTY1cOdfxYrAGl04jhAnqeRKMVSDbniKIqH4+FuVMmo+bcSY+9o+nrD+Db64tq6bQE29FHpwKuNdALMcqutg67iw8OrJzJ6dnxw3K7ZqfHj/xvXQCVLNDmjsUE/3ZjhH9t/7hWNSnM+j0UBp7Ig1vnDOtkgyMorZ8fSKo5ADmMVMddaOX7EJ1DQHCZbkujOVGLOtdTzu9HxdkQ/eAo+CHm5VYxBY+I6Mocg4/+MIzgFjv8eEItb0NNIQu+aFyxMMXEfNqdGL2fkFT0TLpETVolGmWlbpw9AhP6qU/tqiDo8sjK8FtB4RwNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10804.eurprd04.prod.outlook.com (2603:10a6:150:214::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 14:38:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 14:38:22 +0000
Date: Thu, 3 Jul 2025 10:38:17 -0400
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
Subject: Re: [PATCH 1/2] dt-bindings: i3c: Add binding for AMD I3C master
 controller
Message-ID: <aGaVz9nwPEUySLM1@lizhi-Precision-Tower-5810>
References: <20250703111428.2111484-1-manikanta.guntupalli@amd.com>
 <20250703111428.2111484-2-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703111428.2111484-2-manikanta.guntupalli@amd.com>
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10804:EE_
X-MS-Office365-Filtering-Correlation-Id: bb756209-021d-4f64-be9a-08ddba3f430d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|376014|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mxJUqKjqkXpvLV1oo94Pa0EXbiPOM3qvEFZyjFmnMGBInwgfdUpv6VJ9fIG2?=
 =?us-ascii?Q?8fHnV3kS/8uSK3jCmZANE9+6e5sv2vQ+HOpuANiB7RjagnVtl0CE+mLcn+rU?=
 =?us-ascii?Q?qorkoMGqjid9nxHZhU0Mk6Io6khFFEV4QeAGol4fHYZ4PaYLuPsgpN0jh7qw?=
 =?us-ascii?Q?MDFWuXNruDj0lkIhdccmK8hN66Bqb1AJq6XoSHopJGPcxosEDYlOl5nyQ+XG?=
 =?us-ascii?Q?fRV7C4g4YQNp4m5zwRojH5s/JR7SP7YasdHLeeTc3OtSe6RhyPY56DmMfLUl?=
 =?us-ascii?Q?58RqdUvQvHF2mM92060UTuZurGLL9sHQlJQUhFXIwkEgnvqK1Sq+N21BYev/?=
 =?us-ascii?Q?nlTbkr3TQ8pftlHdbRo2c7HxuGldh1ALksPEahFLeMRmea+v5EhmQN4Zao/l?=
 =?us-ascii?Q?0RcG10kiOposLc8Hl1/NkG1X8HpV+N8zvI31f5dOCG23CYsb/G5Jjivuum9+?=
 =?us-ascii?Q?2d0areZ3YXtBYHdwI64jtvZgIA8KUPBpolDDGY/tjVKZl9W5R0Gk5ZFbUqJl?=
 =?us-ascii?Q?UGw69T543bSnzNVqLvIDFUCiBx+OQ79pbpTOF3s9DCDiGcIMRVIEGKXF+If9?=
 =?us-ascii?Q?/K/kL+NjvfmH1a9RlLOKMw18xRIrQcDyxijqjswuRnQ7ax9O51EG/3WXcz9g?=
 =?us-ascii?Q?ZvAowemOPur6Sgej+ZtT2UJ/H1WS9qGmGNLRdMxanBu+jbfQwaLJv7ieOrgU?=
 =?us-ascii?Q?ZN/gpp6nFllih8zrhCx5hfcuuTCu1+nETUeZhjehrDU1Yg0W50pEB9azumHV?=
 =?us-ascii?Q?437vnqCefqkuQWqoYrj1auBe5FrzTkRn0sKcVmCZmeTuoPTKatrLvdibjGRc?=
 =?us-ascii?Q?bHqRzyRAUGRG17GCHo7FcjEIuYPZ3BlnaQWLdk7NcAygvjQ1f2yyR5hB3WVK?=
 =?us-ascii?Q?8Jq4MbYL3BHeC0d/4RB69Dz7g4MuNTaryVimrG8Fxd28nPLoc7uOhF29Gfbw?=
 =?us-ascii?Q?0yqkwbo2fxZVf8Ip6mwl278OjVFbr8ISUL+pB6+YZTx+DtKFGcqV6t/ECdb1?=
 =?us-ascii?Q?tXfvIYAIhnVeSmiMzGrwuijKXi79lrDs66CZvSJicvRlyUdmmJdvZz6X+MJ+?=
 =?us-ascii?Q?QatgppaoOyQr8lnIebyCK9nSDoHS7YEZIaYCJ3wab7Np+4wTDuLdc4Hw4Nzd?=
 =?us-ascii?Q?FeNRpQseKMGVZjcARRnVIx1cFjJ6YZl/llYWWwoXrWXmp9/+RUJuPgwUpgeG?=
 =?us-ascii?Q?zFKZTFFzgeQkTqrwRAAN/MxQH/aVdNvNBAoGQLiUiDZGipJnLFl+N+uCh2gd?=
 =?us-ascii?Q?iQR3jNuumT2TjAa3fRlTSzlYkqXWskkUXdDReAnJq+MvAl719MFZjzZbSF3D?=
 =?us-ascii?Q?6Q6HS4sPKFG8E6ptRR2MT4MRK5diYSZimxcz3UGb8TKqlnkkY771DjUN3SMS?=
 =?us-ascii?Q?kTbigAcs2o0xogbHvvRuxkELEgkRamePWUG7xJm2SoJXL1TmHQPK7XBa1E77?=
 =?us-ascii?Q?QDHaYQsU8iogTSFqu0HpSh9/KNj2e5Rp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(376014)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n49gInzaA7eJ4JA6hCctkSESVfRrBJAdes/oLRWmcnAqO68H3W3yoBGzlHtZ?=
 =?us-ascii?Q?kQvyvSQCq2VAw8nHSpmG9DgvLzts6zZ2vLw95hAnCwP4jW4IaJZYzHlzec+J?=
 =?us-ascii?Q?lGiah4YQXZ7fo7SmfsukPrUgABEw+uX3JKR0n5woEF2a5QyecjTNdjT9naO0?=
 =?us-ascii?Q?rgIII/lGBdzCurl+wEKJ1f2ImuqHlqc2EUL+Ew4skRJCLAJF4maZ2tZ+q++Y?=
 =?us-ascii?Q?dg3Qkiu0DaWavQIpdTiCkxwI91FZGA5s6vuk6qtyc8uxBPUsq09XnTddxtvq?=
 =?us-ascii?Q?pDpj300Pkp0kPxMtFcODf5Ji1ssxwDXM9GnSQHtXcnpe+epSOkNd4wZNzFvC?=
 =?us-ascii?Q?U5BGY5ctpsPr3ARiYr87lnkM7MazEAjBD9WNvAIO9Hyo+esvekT1XRUZuNTb?=
 =?us-ascii?Q?zjApR5KPUBsTBj/2UG4Y1PUlh89S0kNwKxZDFsdr/MBwD1EGyyzcW+lSubGf?=
 =?us-ascii?Q?IAsCWZqQ8UJQpKAevNAyfz7pzGjhdXBg8NgFNGYNCo+PX+TOVtC6HN8hFMXy?=
 =?us-ascii?Q?6pDU15ycv3qvgIpU1DfCln0UgjVDkJfObL/h2xwUj14Z9hdPZswM9Or6fpER?=
 =?us-ascii?Q?ZPnwAVre3u1gXGPtZ3iJFJ1NHpWcCcIdZFFgsjBIuNXw3vQkluX3i00bU/MQ?=
 =?us-ascii?Q?bNqFA6vVprCUlbxLPSDmPzaC4s1Zzo/UD+sSgjob6l7f+7ITOQeBzxL63RG+?=
 =?us-ascii?Q?NVf6wSy1TJbiafCPsFKgp8EMv6mtYMvWb2MEZLmhmYjjlTOPcV1XE1Ev86lc?=
 =?us-ascii?Q?jRuFDPJ6Jqe4WCt6MyuNPNVXaHPxmewvER63gEAf/jQw+8+7AJScCiz7bY7v?=
 =?us-ascii?Q?uPn4MGxGKVL1JDQuMqECpEZvMRPpzUBN7KJxYP53lW4sBf51kHNbaI4rit4F?=
 =?us-ascii?Q?Wd63wPlPMs4ZDwXHzoKxeUofiPLDvGcSxRvKuUbMX6KDjZm7Jwru3J8ipMGc?=
 =?us-ascii?Q?HhSug2bpdFNH4yduNTk4Hs/cF2Uke5IFOwk1zvUecVa2acMhj2JXObxCeEvE?=
 =?us-ascii?Q?bFm1lIFYcbILA/gyvDSGyJG93XiE6/2Lh9YSbiSNvGE4QeCYLtabtfjm6M8U?=
 =?us-ascii?Q?uc3aee+LsbA0iFr0arGAH7USY7g3s5zDuKRWDTU8PBkQ9vRNNZ+IGZcs0TjS?=
 =?us-ascii?Q?sJg4+WEEZISRQFnVm2lgTFhEBZi2J/PwQuCNHqM1NPKXnCgikMjCNP2yQEjf?=
 =?us-ascii?Q?VAojv+Jf90oafiVGv1yHSAgDajK4fxQRzoFrFVZ5QROk2Q0I5roH+w0ys3Nm?=
 =?us-ascii?Q?suJ28cLYqiBQt2hquMxfmlPTmpjoKuonxwYznLrKiLHFjBiPc8tJ6VBn15c0?=
 =?us-ascii?Q?POxkM6q3ONOFoJNh37MlUMgWv5VfKQ6gNIecIs6PZ6YizjTin7endBfZaNW4?=
 =?us-ascii?Q?BsiRxLKf+iOqH4RL7SSYrvZ0wL/6uPESmvfcnMjAKCFASMpnGnq7x/hsrQp3?=
 =?us-ascii?Q?z1BtzNxxH63SHstoJb3njBq7kBa/t1x81y5fOC2pIo1cIHv6y5TDir+q2u+P?=
 =?us-ascii?Q?M9kjTsmGFC1046SQ/EXI0lKu5xzpCo035vVXyUA99Tjtpr1TyaL8Ivqhg7zL?=
 =?us-ascii?Q?im9Z9RbYBf9Bs4sUieAocRYyHLEihEammVoN4qwK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb756209-021d-4f64-be9a-08ddba3f430d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:38:22.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOfCjY+vT/spKcJhN//PBtHCYvbCxykX9HEv3jgpHWAsaPt3ZbJLdxezvGyXJ/P4+o+YO9FsfvuRQ/lKE2pJGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10804

On Thu, Jul 03, 2025 at 04:44:27PM +0530, Manikanta Guntupalli wrote:

Subject needn't binding twice.

dt-bindings: i3c: Add AMD I3C master controller support

> Add device tree binding documentation for the AMD I3C master controller.
>
> The controller is represented by the compatible string "xlnx,axi-i3c-1.0".
> The binding specifies required properties including register space, clock,
> resets, interrupts and number of i3c target devices, and provides
> an example usage.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
>  .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
>
> diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> new file mode 100644
> index 000000000000..d4ad3721096f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD I3C master
> +
> +maintainers:
> +  - Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> +
> +description:
> +  The AXI-I3C IP is an I3C Controller with an AXI4-Lite interface, compatible
> +  with the MIPI I3C Specification v1.1.1. The design includes bidirectional I/O
> +  buffers that implement open collector drivers for the SDA and SCL signals.
> +  External pull-up resistors are required to properly hold the bus at a Logic-1
> +  level when the drivers are released.
> +
> +allOf:
> +  - $ref: i3c.yaml#

I perfer put allOf after required, incase need add if-else branch later.

> +
> +properties:
> +  compatible:
> +    const: xlnx,axi-i3c-1.0
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  xlnx,num-targets:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Number of i3c target devices connected on the bus.
> +    minimum: 1
> +    maximum: 32
> +    default: 1

why need this property? i3c is self probe or children nodes in dts.

Frank

> +
> +required:
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i3c@80000000 {
> +        compatible = "xlnx,axi-i3c-1.0";
> +        reg = <0x80000000 0x10000>;
> +        clocks = <&zynqmp_clk 71>;
> +        #address-cells = <3>;
> +        #size-cells = <0>;
> +    };
> +...
> --
> 2.34.1
>
