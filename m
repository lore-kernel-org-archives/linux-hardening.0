Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813224C9D;
	Wed, 26 Nov 2025 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764134252; cv=fail; b=XhNl+/uveeqDX30tLdilMSv9NhwrJW9un6DKLGBagWZ5rQSXAG8CkSxfy0lKEiBwC+4eljrlLPm9Pb1EjWP0LlneZ+okv4cfvJMWAFc8iWeWfWjctrT1Zslt7t0RT13HWxouwhP+79Gr/4nOCHki50mdfEVIFWX/jDf44+/7htY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764134252; c=relaxed/simple;
	bh=QAlHQQ1SkhFn5aoKyv3nbB6i6BU3/OwuZvebu+o1apQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QywM8mFxpxKBYY0Ukctn2BR9iJ6oeP8vRi4xf+ibdRSjeCTC8p3El0s9s6EAyFsDr22616Gty5XIblPWAoPvR389G1gznrKdrCWbb4vCW2Xwrz5nIOXXTj/vSO0TQY441rpox96Bxsk+Yg2sQaKtE7tQcK7AoUtfuLy9f47bXrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o2hEyJRj; arc=fail smtp.client-ip=52.101.52.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o2hEyJRj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwkUiQKqr5BN3v2Hw+piX43N+Yx/gwXSP30kly+ox+y5KzLqmJod7jrmVxOhLD7Ip1L9ljQHaImyfiDUutpmWJ5kDTGKTQ0KGRhoMj2ZB6OO5a2eqxfJS9w/jEJhRRxEmajKQ4EJb7z6m8IYxr6AqvxN024AtnTuR1oYFgNluqML7dnUNqjgRZC+7ZOCerrsFPJnuxnUQ8B0aFo01CtHMLcZ8EEZ8A7KV2T6YexqHYtItZDxCGIxgz9wvcNHmu20g6b+0JtXmnwcBFyUxd+DV/YYweiCRS/rfkGvTpHoNtj8ChhUbP9Kpc/Vl6WT94+o4CcYnNywf16lvaj9JrwGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwEg0U6WynGSW7ntwUYDanmk6MOD1d2L72jr8RdfcwU=;
 b=gfymW2xxJ+I/jmHxZoCR1GSjQfB/0SXMPOBrQNFSmLlyPv6+K7JsJ6LB/hX5nW/+8HV4ElSY4AChw1CuTih/kc9o+BiYia8xwOv8s673o+baMNjYenPm3LWlsVbiOvfuzPHcS+vwdaz0FVs/Ff6ja4an7+1TMbbyEdWtKL4OrN8ljQBb1p4lGGFoIZsOoJ1/LOnMEAp+/a3JrF77/BMEfzwkpFhHwThqOQjQ+gox/qAY8UulC3fjmhc40gwcTJztXldCvSIGRetAPr1QlZHqiiGBwC6OI+mw5F2wq8RJRn5Heiy2VeMcBdqJNh63p6fiopH9JAG1BMlT9cylmRAixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwEg0U6WynGSW7ntwUYDanmk6MOD1d2L72jr8RdfcwU=;
 b=o2hEyJRjifudbUcmBTR3PiMcBHmrfJ3szyQuo7CRyhPp1/creHFZv6er1ABqdghBXsyEGcSPVT6ydCeY3QUXtKkStLwxhVFBz8M10oG9PzXMkZx03TDdkzY0L03o1IaAMPKy/yVB8i3RMFKU3Po8JLB2AXJouSFTG0YiE2tVlas=
Received: from SN7PR04CA0105.namprd04.prod.outlook.com (2603:10b6:806:122::20)
 by IA0PR10MB7623.namprd10.prod.outlook.com (2603:10b6:208:493::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 05:17:25 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::53) by SN7PR04CA0105.outlook.office365.com
 (2603:10b6:806:122::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 05:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 05:17:25 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 23:17:25 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 23:17:25 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 23:17:25 -0600
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AQ5HKHZ657597;
	Tue, 25 Nov 2025 23:17:21 -0600
Message-ID: <671625aa-f5da-4e34-9c8c-7a1da282aa5e@ti.com>
Date: Wed, 26 Nov 2025 10:47:20 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and
 MBa62xx carrier board Device Trees
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Andrew
 Lunn" <andrew@lunn.ch>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux@ew.tq-group.com>, Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>
References: <cover.1762775119.git.matthias.schiffer@ew.tq-group.com>
 <0079cc291c78b94068f3d8c59df103e951247acc.1762775119.git.matthias.schiffer@ew.tq-group.com>
 <d13a95659bdd1c840dfaa46afd6d8583f1b7c88f.camel@ew.tq-group.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <d13a95659bdd1c840dfaa46afd6d8583f1b7c88f.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|IA0PR10MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a18369e-895d-4208-c73c-08de2cab1620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZER4UmNWYmhISmNwYzJXa3J5eE5oRDZJQzBaYlc1akZ0MXVmbCtUZVBZVjMw?=
 =?utf-8?B?UWdNVUNYRktsUEwwSFlwQ2dlUEtmK0NGbVdsM2h4ME5BVVpVaUEvTjZTL2t3?=
 =?utf-8?B?RnVTNnBlMUViY0pkU2pYaitJTC9seGU1YXRnRjFUSXc0RVR2Ykt1T1cwRktG?=
 =?utf-8?B?YjJxUzRSWEhSTytlOXNFK1ZVa2dHNFA0V1M4M1pDeG1kYUtyYUdjc0llMU5C?=
 =?utf-8?B?OWJaK3JxTjNlL0FNS2FlNy9TUGNXbm92WkkwdjVseEFOUldRT3ZNMFN3dGhR?=
 =?utf-8?B?cmkwWTdCQ01YNG4xb2JOUjF1OWJCdVNvNnBFSFRPcnVhTk1Zb3o2VU5UbXR2?=
 =?utf-8?B?WnpZdXAwNnN6a3FELzByMms3NytyYzZTeDlIVGFZZWVDcjJzYWkvM2creUxZ?=
 =?utf-8?B?Y016UG9vRy9hemI5VGFlbUlUczc1TGF5cEVvdXJVYzdMUURBWWhDUUZMWjlF?=
 =?utf-8?B?VFhOZkZid2k5N3djNld3K0ZOTFJleTBXTnZrTzZyVjhubS9yMUhJTGdoRTVT?=
 =?utf-8?B?dld1emJzb05QQ3lWZkFoa3ZpK2twU0drUFBBYmdTbXZYOFpiL1cyM01VTFYz?=
 =?utf-8?B?RHpYT1lkcEpna2paYVFScUw0NEJOaHZCdFlCamtZcHhoVXpJVmRkYzJxSUlM?=
 =?utf-8?B?dmZ3ZDZ0dE4rTm9KVzh2UURMbHBmWE1KbVZuTVNVc3NYNkRkaUk5bFQzZ0tR?=
 =?utf-8?B?MUc3Snp3UEh1TXBZTFBLcDN1eDFIbkxnVmdjeXNTRHdPM3pzajh2L1Jmck0v?=
 =?utf-8?B?cHJTRGpudFlQVEFySkZrNWNhUUtJTTBBU3VOeVIzMk1VdEN4eWViNGt3UlpW?=
 =?utf-8?B?TmpHVmNVRmZ6TCs2SWZ6NFpsak04Tm1WWTdldVIxQW05NEx2Q0syQmkvdDhH?=
 =?utf-8?B?b3ZxbTQ0eEs5YjZlbU9DdDhOOVh1R3ZRRktJSzBJVUFDT3RQd05qalFPdFNq?=
 =?utf-8?B?NitkaEpnUm9sc0htQld6QUVLYy94RG9QM2hpc1Zac0FXcHBiMjBNcCtDdU9O?=
 =?utf-8?B?NWwvVnhWc1FoNE1ERm1adjF3M1I3VE1RL281RlIzUTJXUTR6UlJDYzU2Qkda?=
 =?utf-8?B?WlExZXMzSHdJK2NmVCttNGQzODA2TWZ2akJrOVIrV0R1Yk90VmNkaVlXdTBu?=
 =?utf-8?B?cXQvbENFS2hiSTNCa1c0dXBpMFBVSC8vWDdyZ3IrK2N0RzU0TlhrZ3ZmVXY2?=
 =?utf-8?B?dlA0WW5ZWWlmWStUTnlPR0dQeTFLWXdHZVIvWk94YjZac0kvdE9ncFArZC9N?=
 =?utf-8?B?MUhsT3Q2V3V5cjFOSVNKWFdudEhBZFZYZUhWTTBjK3JzRTk2TTZRRzBwNUJp?=
 =?utf-8?B?R2xkNWFwK2hoekVCVFNQMitTNDM5V05jdDV5Snh6STIvVVczR05PejVudTJz?=
 =?utf-8?B?WUl4V1U2c2pwTzdrVXdoWmx4d1IzczRvTmI0SldJMWRLWXFyZ3dFUXpVNS9P?=
 =?utf-8?B?YWpZaUtBM2Y2WllqTnBIaWVjMitnSGRnRmtzYmEybDhCNHJZS3M0aXdmdnB4?=
 =?utf-8?B?d3BpNUQvSFFqU3psQjBQdTBMeEJHdTRZd0FBTkJyTi9QNy9pSUgrRkd1T1Iw?=
 =?utf-8?B?bzdGeFdzN3lwQmpGV1g3M2Z0aEhFVk5UVTN2Nm9TQkUxOHArN2RBaVVMTGlC?=
 =?utf-8?B?RVNrUjB2THE2Uy9RWGZSQWZWQXNEdlBWVzB0azBTREsrM3VvUVozNjhwaW03?=
 =?utf-8?B?V2VlT043SGtlWm9KLytwckNHcjRwUS9NQUd1YzkwbXlPV0x4b3pjQ1Qxdytj?=
 =?utf-8?B?WFFWSDFqak5jdnJaejdyZHpHMjBMZTBhQUVoTWVUc1FINSs0US95Q1JzQXRq?=
 =?utf-8?B?Y1dmNXdGKzBmK2ZrWllwczVjZ3A2T0Y0T0dYWXRjK2VVb1owOUxJd0NQUFB3?=
 =?utf-8?B?KzRKaDVnbnJ4bVRrSW5VRG5mLzJXYkpyQTBuME02ZnhKNjhyZ3lRakROOVNR?=
 =?utf-8?B?RHBjWkgxdzdVcTFGcG1EcEkveVJ2U2cxSnFLRTFiVklSL3Mra3RGK29vTTJK?=
 =?utf-8?B?TWhTMUt5dWs5ZlE2dFJyOTlhcC83OWlEQkJNQzM2UElhNHNUQnp1UHJBSm9B?=
 =?utf-8?B?eTQwMERhdStOeW5Qakp4QnF4TjllU3A0Yk0zVk9nV1dWS1BkMXJyZVAxK1NJ?=
 =?utf-8?Q?EKZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 05:17:25.5165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a18369e-895d-4208-c73c-08de2cab1620
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7623

Hi Matthias,

On 25/11/25 15:32, Matthias Schiffer wrote:
> On Mon, 2025-11-10 at 12:49 +0100, Matthias Schiffer wrote:
>> The TQMa62xx is a SoM family with a pluggable board connector based on the
>> TI AM62x SoCs. Add DTS(I) for the AM625 (2x Cortex-A53) variant and its
>> combination with our MBa62xx carrier board.
> 
> Hi Vignesh,
> 
> do you have any further comments? Can we get this in for 6.19?
> 

Oops, this somehow fell through the crack, my apologies!

I have already sent out the PRs for v6.19. Sorry, this would need to
wait for v6.20 cycle.

[...]


-- 
Regards
Vignesh
https://ti.com/opensource

