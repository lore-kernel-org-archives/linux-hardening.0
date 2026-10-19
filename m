Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792441972;
	b=sFlqP9TWS8ApPzqT6ugxeB72nvCc9SScITjT5rtLhifjxcrQ7ugPgeBFsg9mhs+pV0ui
	 bMMfHQmVFqupNM4s/E4ohYXejpQD48L68r1V1jM1ER80ZoQGQQXjnX+zv527KpGiTSlip
	 aXnmxPrgEbeeLWXjHbhDXlnv2U1gbOBqwpTaEOYQPZIGlplzh7cjqSRMCQGCBnzTpjH9m
	 fRbg23DJIq1BlJA1EdxaICupBUZW56H7+UXKoJ0hbg16tCQ/ZFEt+9Czt4RwY5+4q6btz
	 h5mhgyNX2s0s9NhvfYFxSD1twad1JaSZfu24aL8zcUPo/TnJoBfVuJ43+jL8/x3MK7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441972;
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
	bh=NnZVSzSXcAj3KELfmay509eAzpFndEelCVPDyrd+ROQ=;
	b=foH1maRDmzSC5gldWD1Ez4suMD8z3i56g2UmnhfskIKF+yq0efC6qdeSz+W94cgEayTZ
	 2LeIn4Jr+tXQRRdEn0iuUgVwQ9zBog7XzkWyP2QZ1r3jC79IfNAk0x5EGP9e7vqgaIYEG
	 v8V2kZv8IhSB5J8xfVLvuhUay2nkE7BF8v6TvBOxwBwErTG3WJQ1UtVchtUSnLm9xfPxI
	 rgha3HI3ZLZOn6sx9zU1SVbivuY5tmLV3D2IJIxcHlMrb2TJdn/vu36YrhBWqSIFxTP6c
	 6NVfGsiV1RcXxdYEFEfh4It8BjMmCAMBSh7jtDx412xiIuUQqYPGry0g/A1P8CYCWxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QEOJVKki;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.19
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE5606A31C;
	Mon, 19 Oct 2026 20:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DDE5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QEOJVKki
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKt2Dy7G2p3m/VuaQNpSZC7N21BgzccDqsdc4DYd1fawknPwEog9YSdCYWVqPIbh9WUVd/fGxGoUOUT4bqjzsIS3AUP6piCXDQTT+3gGBmxgMl5g9gqMPcpTbd0s40jMiFVf/H0ini8WEvSmCn5DaMAghvBYQDnBwhREN7M0zQVZAx15gTJVeVsqG++ksIldfg05zcq9JTMhXVqTReaI/KL+j6FihEZS2hhTtRJPvznPDsMJhONHqYv/SylaR9JSYnlX9yWEkkjN/B5DD7e7WI55RT0mvkJiQAF0mmz02gaYHaGdXXXjK0OBPbOfLarO/dXZF7reyw7R/YW/61D1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnZVSzSXcAj3KELfmay509eAzpFndEelCVPDyrd+ROQ=;
 b=DUQsDw9fLb1SHqv0Ql+XEwkHhZtg7bsGUT35jAXUlpuP7n7qu0lVS7t0/iLoBNcUzZzZw75TaPkv3fSrswNKBuukVoJy1kcMfLhWlBAYZ4pys/CuHxepaH1t2ywcc7jHcYs+kKq1XYLQFTdBAROB4L/qiOVJ/vhVnbDOCbaG0ax9zd4hLetZ6agc0Y8rRuBjxYW25191S5Mzj3tMejI9tbE7SYRJHnJjzGtmi4dJSj2/MZNMLzy1rEJYMHwECzRGUlz8w3t9nlid8ImddcoF9lJdWbeCxi0NBqn/gWlvVDtj1AYw7Ud0ZwiRx0Y3kUd0xLzXx+INme1fbn2G1z5gBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnZVSzSXcAj3KELfmay509eAzpFndEelCVPDyrd+ROQ=;
 b=QEOJVKkimIDql3c30i6gpuqhn2Re4zLf6R0vrFmK7CmjQQSkaaVJYixKvQeJJ09jZSkci5qk4vjJlJ41PJubaoeT5veclyWffie3YaLdLQvpehfLXnjs0JbKGVz56JCzcq9uzNOdtZv9bvObvOOnK8Y7np+xysn7MtMlhy/CPzdi6OwZ2lnoaSiEWpGZ/yFQ5EylSlz5lNPeND4jNknNLhBx9xjjvfXE1dRzTzuKL4HJEii8m93cGB4KaX4rr6YTof8EvqgHK06pJZvo7SA5dVp9MoBbGx1IX6ReV5vapme6x42Q6CKq3WLCJR9mafE+a1VWTYVw9rlra05PWFRUbA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 20:32:48 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 20:32:48 +0000
Date: Mon, 19 Oct 2026 15:32:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: junyi.zhao@amlogic.com
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
	linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com,
	Kelvin.Zhang@amlogic.com
Subject: Re: [PATCH 1/3] i3c: master: Rework SVC I3C to support vendor glue
 layers
Message-ID: <atZ-YyEmG-KvUZAF@SMW015318>
References: <20261019-a9_i3c-v1-0-329d819d621f@amlogic.com>
 <20261019-a9_i3c-v1-1-329d819d621f@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-a9_i3c-v1-1-329d819d621f@amlogic.com>
X-ClientProxiedBy: PH8P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::34) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: c99f35e9-54c0-49e1-ee0f-08df2e2023a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|23010399003|366016|6133799003|18002099003|10067099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dbgPGYwX89F4FXPQGY/Mj4N21QTpE5JwwtD6zKPDn1qYgGNHHTRVdLLNjU7rcOjECU2EgZHzdHzk8Bs3s5/HGtRIuQLltpNnr7nsxq0iWr8+2xckN07z81WZFvlylOyv3WszY2azO/mWMLQv3dPaGH0/nYCSPKzstkGJBMR91DQ0igqu2HIYFinayVMdUZbFwFI/WdNgRSYRKIDqA4hOSbP0j5hq/OP2Fr+xTGuqiqqAu+TvZIzsRzM/h2VC4m0Uz+mr5cEPpCBqBdAvtFtEPvTtzIKUfNTdAcu4UHc7q3VSALT49iKANrcwqB2TlPCWFnV1GQoT2Qt2kGfZcNnX6vytuOkIPvVNmmJ3+CEfum6ad/eUTjTMb/wz6nX3ZzA+Rx/40gXkTS4eWRJO121OThJEksCs//Mvimm2l9j9vJD+NU9QMWnWM+Ab1hmK3MhCiRkeezEPEwUrh/5jB9DtOvAmqCHZ7saIkgxgxOFbG1Gh1u+jHKt/0zIVglS4jM93HQFM5sVcbDwMISuor3wCtkeUFCJNGP9Ocfx3etKhaH2vUM4pUQMvmTqovWPmn4guESSyOYfvSZj9v+yKy+Acw2tCgtQUOTDf6TrE6fyTd0j8eCgd4wKEjJBO+bYzApMGl1aXMCa9YPJGUEt+0XkMVKILVCKe8zuBq6SaSLbsUS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yh9oizP5hJ7Bo3Rpc/ri6d/2r/yMxrtrg7faHR4VZyIxm/HIWGnkd/38xlVE?=
 =?us-ascii?Q?mLFn1/jfVJn9zQi4xAPLIwwSBhv45qo38WhXCH6KFjttI+Hs85YIDPDV2wUh?=
 =?us-ascii?Q?qkl+e8+O9yogrNoVpPJkPXnSElBPfPteOFOnFOBicH08+AU0LisrjmEUzAwh?=
 =?us-ascii?Q?lEcBN8Dn6NmKwbXswtDALAOzd37q93DkSZYNkwD253Xw1q1OtX4VKYGg+WhO?=
 =?us-ascii?Q?CLnONv6GaOXxRxZqAaz1IdwdQACv5EAZ/vMvQ/Ny69Nb7O/bksk1ma3s/FDd?=
 =?us-ascii?Q?2x5aRkJp8PW9mpVFwrYR6Aw7+7NfEKoXmhmubH9yTNTWs76guhu+lh+M047C?=
 =?us-ascii?Q?ImppGgfVSEFJXSKD2IpUkZAV+Mqj0VUp70tBi42gXWQnk7NqZ6ch2Frp6/sV?=
 =?us-ascii?Q?0qYSnsYJAIpS1S7MejbTEHrt2VVhi41MFd5XKWjoCbBVkL1tITovmNqrN3G1?=
 =?us-ascii?Q?xz/1HAXxGuYOKJHIUiG8aK3ZxdX8CTkWfA3HE9VmiVHWZhA4zrFGGBKJM9S1?=
 =?us-ascii?Q?NwDLJd+VSZUZwIHtWNKeAZVP2gGJi1RmXUMAew6hmhIVkLaOKBCW4qxtuklL?=
 =?us-ascii?Q?AFJcFSPgxboT7qsJhaPgrFv3IPLoSvXpb/bESJez6Gsq2ZvO8KUdnlvj08Wj?=
 =?us-ascii?Q?6mahB+va0tX0kJ8s8AISNlPHnnkE05E0G+VJKkmeySpgksp7GlVG+vSstJ2c?=
 =?us-ascii?Q?Y0Ca6kJJBjsrr181nMraAEskBZ8rAptKDI5KUWYPHGf795JOvaxFVWurSGrK?=
 =?us-ascii?Q?gXJAHUv9ATUATCenQ8wVt6Y2TOrfdSZIUKUqTCtuNjrDg8b8A4SNMpWm9ufd?=
 =?us-ascii?Q?mLx8nJ7VHOAChPrSFAmaK3yLZnUw6/r/zGq0DNngzvlC1qmrRvrtWPQBdMBw?=
 =?us-ascii?Q?XZRAxaN6RcDbn8vekkxHVSpourW569ihU4C4OBB/YpLcHEh2U+QCpzZV1ooe?=
 =?us-ascii?Q?XVtvSLAvNyy9JCBKthZaOSYlckjuzWrbrjgXyL2X2meDKm506cIWf6C3z9G4?=
 =?us-ascii?Q?qqHoCH+h+NhkfZAIGAIN+9q3v1g2U4K7pS3fitBoBxSWeNCtYbh5djRSvFeP?=
 =?us-ascii?Q?TxCxchpK5gCiSYuThWJ0gr0W6IhoARg5zkBDz95UAFrDlP2yTX3hOmu+xtuX?=
 =?us-ascii?Q?HOo4EECqNQ/XmoXhZIm8zdviuyP/95wIb9Mb7/WTf1wRWSYh0cteAjg3+IKV?=
 =?us-ascii?Q?6q5OfAlgKcioGbnZnDNaIFzASYrDo16a8ebi5AzclxLaaDc23Qcxg4Ma8kFA?=
 =?us-ascii?Q?boCYTT5QL7vLqBFetb2XU5bIp2kcyYpghBYrB8FLR11lns+yCezNz2Ao9Rpr?=
 =?us-ascii?Q?KfohuVfMHWwA2GSuKWfuzbjz2NORpj7i8msEPoacUnIvUoiXu198wlphiq2i?=
 =?us-ascii?Q?PO3YwqGHvImFJpzG+AHoNimXNgTr9pNThOAW75ZaviQ6GQdSmyCknDP7M8uP?=
 =?us-ascii?Q?ucg7FhfOqX8gr8Tr/n+33fmY4/Kwy0sT3WWqHedyeViECw03g8u6ZmDvDU2m?=
 =?us-ascii?Q?nxvSyoYe0drFVyqKSAzxLfF8L0ubYuAhirVujzJeVVBDyhIJ3KAeT43mC2b4?=
 =?us-ascii?Q?nErjiuX96X+dSA5W0nx7JkyryxmyNZGzYEeG0qDCDv1JJ8DB6QKnDeA3b/7N?=
 =?us-ascii?Q?SHxZhn5tMo4oDUgiTJjzDZKVZ5yL10aoKBgiFrJXwpzL0vSqZWrKekVlBbag?=
 =?us-ascii?Q?dwZ6QPAZgJBMybcC9kLOsXFY/8d3qBb3ElHKzfYP/uK5dBjCisJxhUV+r0UQ?=
 =?us-ascii?Q?wO40kNI3kYXTJ7RLic902d7X5GVRlH89WeWh/fohvWdw1TBzwqkv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f35e9-54c0-49e1-ee0f-08df2e2023a4
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:32:48.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrfLepdCehiW98B6anBCBN0ZyOXdfg52vQki4hiVQo8+RBcEXdEwNFAxNz9BrDBvCbjrgHzrYh48WMggXLtzP+5UZnXebENKzrULzPkyp+9E2poaKzDOVPldf0wyyiUc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

On Mon, Oct 19, 2026 at 01:34:26PM +0800, Junyi Zhao via B4 Relay wrote:
> [You don't often get email from devnull+junyi.zhao.amlogic.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Junyi Zhao <junyi.zhao@amlogic.com>
>
> The SVC I3C controller IP can be integrated into SoCs from different
> vendors. Peripheral resources associated with the controller, such as
> clocks, may vary between vendor implementations.
>
> Rework the driver to separate common functionality from
> vendor-specific extensions. The common logic is shared across all
> implementations, while platform-dependent operations are provided
> through vendor-specific hooks.
>
> Also add a corresponding MAINTAINERS entry for the SILVACO I3C
> controller.
>
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> ---

No big difference. Needn't rework svc-i3c-master.c, you can add amlogic at
svc-i3c-master.c directly.

Frank
