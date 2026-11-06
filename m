Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.66.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793985351;
	b=4oJuOnBMDXO4uJRS4c9pVW7QzmAtyjMT4n4RTBMPjOAZRUynEC+XQiyysMEnl1JpygQ+
	 OwxojSKjJZCrhYjhBDhil/zlNB7veR2M8mO3BcgJsF014AbUkrMelo/VKF374xF2zbetJ
	 7HacCL2UBeD6YWbCe+BKKY/gl6DqN6sh6PC7fLXUmq21t4eqzMbCAY2VezjqK4MfmPArf
	 S8UjQmDjc8ttjVMr+QbyEuJ9CObX+WVH4zJZOiBAh9p19U61MgSgXXI7a/EEUYf7KRZ5t
	 WU04liYJP4usr1Sk5AkUJ+DsN50mnwW0nMAFlUhXZAjSABavllJJ6P7uQfl0M2OFUTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985351;
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
	bh=0qvd8ipHYup7JlWgGwTg0r9JovCMIPOPza7sYzaBLpU=;
	b=vbzjP8rk98N3BcnXKxdSHBByob1X7I648LTwdSpm2oCDwivVgCXUQXELVJ+wNoRr6NOJ
	 VOEdZP2vNuYpcm5zM9WUIkaVK64srq09zyicsQ0f2nToGt3uKUKK/vdYxN4BZonVo8Vya
	 AHURUNgt2Kt5DxKTwjhK7VdOI0HF08LAStE/IyHQoUnYXIV8xazxgInXMstYiAxZ/z9Zq
	 HfaKRC9Z4fW6RDNKLWuYNmwKg5EOvZUrrosHL1uR62BggiA+sh2ifvCNBV6u9CZYZ4q2U
	 drVKZeLhreLHeML1osNPl4+8OrR1mw9q+jdInVBjAcnMJ80A1arqhC9S9+rQK5OpfPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Zb5kiK35;
	arc=fail smtp.remote-ip=52.101.66.39
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82CC606A335;
	Fri,  6 Nov 2026 17:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D82CC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Zb5kiK35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykLYHA9bM/WqVnowiaI/xAaK9MJe4yWZdIUpvHFahRq/TuysPQHRv/YKIBBmTrjp7FYmcAQUby0Mk+6PeVEGdAAEGwWHxXFoUP/fGe/oPUxkJGZdx41WyxHo5LLLIpJk7opppDUKUCemFtMdrSmarWknSppbLRAgrRRHRQRkLoy6GLdUgxipeDDOrAAT/p6I/Te9I0Wmla3Sen0vbffAUiypXckYT9VXDpuOIePIUKGYacq6S16+Vg573IFtVQN4kWblNmNCiE4QTD5DY8Mdu/kKBzPSUyjFxuKvIyB2kxZpu1sP4JN6sA65CFyOpxOyS+MhRNb3INANI/QdeFhA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qvd8ipHYup7JlWgGwTg0r9JovCMIPOPza7sYzaBLpU=;
 b=VsGT5OLV4t7wGlmBL2AcErIYiNUz4t3hu5mdYfEPxwoF2LebQfG3Z09eMHflk1gVsBIuUnIhSgeP5WIyVMPZb1PQS5w535BnKXQ5jy9ZuvnlWnVQ+cSUAI65FH38LT5t7N8UIikduxLV9bhlGJ/K7wrY7Fc386OpKwxfOXaMK55C+vqhCkpIlJO8j96jFZWqFoeyBrDmSm86tuGniMzfdTxqsnWNCf2XpvbRqeV3LoqumQE8d2W+e/E2/XoZVTn4pX+CW3oMS3CDCWLUZnZh3ty8ULGSs9EhWYnrqXxkcHliBPZt7sG7NMrYT6o9ogJFOh1FHVSawEaINl8SXmamHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qvd8ipHYup7JlWgGwTg0r9JovCMIPOPza7sYzaBLpU=;
 b=Zb5kiK35k/r0sdwrVV9QaeiCxX2rtSrzK5AFzDLr8x2ui/FeM3gFQ/Dfmw6x/xBOTsNnlGp73htgCmw0qLhTKPd3kz57hL+jLWJQbA91/Ff83kE/ULJ3rJoRvgBnT2m0gxmcIYqpq4L5QtcUzwg7HpMLgEY89SDEaOMxH78uWgjpDsAf6fi1Oxvr2pQLDfThqcNoBRYkZD3sy+nIQ1KG+CAgcZJNjxf7BQapkiDXy0I41/0vsGqkNIDf8hwkJizoo7NYsOljZAF0h7t17k5v5xxgFEWxGvCggKq98YWYLjJKXoczvGUi5Hyoa6oA+LALLfYSbC1js2hv7caPqJuU8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 17:15:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 17:15:46 +0000
Date: Fri, 6 Nov 2026 12:15:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>
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
Subject: Re: [PATCH v3 1/2] i3c: master: svc: Add amlogic a9 support
Message-ID: <au4LN40LQAHsPYZ4@lizhi-Precision-Tower-5810>
References: <20261106-a9_i3c-v3-0-804b69b9095b@amlogic.com>
 <20261106-a9_i3c-v3-1-804b69b9095b@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-a9_i3c-v3-1-804b69b9095b@amlogic.com>
X-ClientProxiedBy: PH7P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::27) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAWPR04MB9911:EE_
X-MS-Office365-Filtering-Correlation-Id: 63055a8e-158c-4657-3f38-08df3c29987c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|7416014|376014|366016|18002099003|22082099003|6133799003|10067099003|3023799007|4143699003|11063799006|5023799004|261026135527099003|261026130827099003|261028144727099003|261026121527099003|261026140227099003|261022115727099003|261021121427099003|261022113327099003|261022075727099003|261021135927099003|261021123027099003|261021130227099003|261021133027099003|261022105027099003|261102123227099003|56012099006|261009223327099003|261009223027099003|261009221227099003|261009221727099003|261009220027099003;
X-Microsoft-Antispam-Message-Info:
	GjFC6ZWS2qTLRTYqYU+MpgT+DgrOH32TQtQ9N6L8UIm1mXI1iS/x9e3QK01lKIljmS9+Ib3V2K3uR/wfm1utPhuKnX7r7q3YpaPJMq95qEDnbVyHM9KHY85EAdlIHTLxz1U53EJ3jJ9mcl6AQ/VmoZSkSicyN+PIgYf8E3/DyKkz1WaKpP83Z4XVZ+pIQNS7b1aaDIP7WTIk4e9aqIIgZ5fa10RTCaFccVPjwfIdH2EyLYHETEVcR/V9qeh69xkaAoISyaQakQpa1/o7yinlphDLGGp2vBaJkevJgiusHRU5wREzE/BswkG/Nw55yUi4ry0KIGQUGIc2+1EoDgrSGluthyEM1dJ/oZG1KZRjS5QGv52s6Dv5Ecl8LCoyH/TTDMhhheVbJWlhJVJ7WnuTjVTX0C8fmDjWJeChkHEoNyYL8HL445vz46o6NqWqV4rGkkPNPiR1y51UEIcjYC6EXb958oYnrwS276MNRDT5/GbBhzEkQIUKy5q/McYB3kXeFVzoOiCbmwgaNt3yHPCFbIdMqCab8DRJibXJphicu+PRw7ePsHIPr4CNljlBTAGmiMmBlFuadz5fc8cFYjsa4N1SObzPqcukn0Bv9e79RCDcSNfH2UrYNtz8QMyzgmzHg+UXiM/UfSGAtNCryHp9k+K1D6pWQ+CG0i1n8IZkqss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(4143699003)(11063799006)(5023799004)(261026135527099003)(261026130827099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022115727099003)(261021121427099003)(261022113327099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021130227099003)(261021133027099003)(261022105027099003)(261102123227099003)(56012099006)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009220027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XKQkE+WprccCUD+zi0Gun0mjB4RGkzgtPPNaj2+A0nrbtfU/QLx2t7PqyP3P?=
 =?us-ascii?Q?ls/2CG1VrF+3ByrMlh8apbHpp2I6O+oGkuCCMxql6/s4u8Hlh4XY07IBIu+P?=
 =?us-ascii?Q?ALvN6D3+IILDtJxlTspH2YIqnHXUrwEvZivCx0MS9DFZc+bSLS8CjwpEgunM?=
 =?us-ascii?Q?PPUsqfjsgfWnxDFpFH2Wejv8AZM3+KDs2K75hbRLEE19Xbu26xRg+kbPN940?=
 =?us-ascii?Q?0IusUcqHBLNZkQPVRzXOZoNUDPbiPDLKJ8EbFdsXX1VXVaHoc1YSvLZqa82Q?=
 =?us-ascii?Q?fk4ADspdvbe8bfPkckYsxs4RQxYzT+kQGoycdwSTORZyGaqWza0BEY8OBAAS?=
 =?us-ascii?Q?vQqCGmnNGcIgItgZ0C+OmfXBg9zWewlMv8IsgCDW4V/oH8sCfIbS21UFH9KK?=
 =?us-ascii?Q?ZGPHoZXxaLkh+KeH1Ew+bvnTDu3Rk63AaQUc+fvN+ulCJgpcHM3qVCXk3kQy?=
 =?us-ascii?Q?UklevkFZCZk0tUfwfcVUvi0ordu2qQEX68IEs436pd5CU9hjuSWrSR0m9M3N?=
 =?us-ascii?Q?RNaJvTKm4JdVNI36b90el6yL+NHJUkADP5KcWWpZnPVXWn4ogZUjiYZGlv4H?=
 =?us-ascii?Q?ppruRq9oyp5dDOvp5QDxq0G8zjgnh52Q94AqH66DEjMx98D6PQMtMGK56Yjr?=
 =?us-ascii?Q?pk/vV7iGiCT1zoDBNPtpSWF41R816DWsvZ4M7O1ZMKKvb39EdHOx0WD8UY5E?=
 =?us-ascii?Q?7UkKhVHZoVEsOE1SNB63ne8fZHUsOJMngSv/PtHE3Mxw9vcLL2I79vqBUCV8?=
 =?us-ascii?Q?IlO/2JbP2tl9QlplJ7GUq4pDGN2bk2iZftdsLAqS6SUJNZQgS4PWXJY6geT6?=
 =?us-ascii?Q?0HeL2JDUx3hfcJJ87l13B6WmW5oSB90cL1T7z5lgciLk5usrIPNvw1jdLXmR?=
 =?us-ascii?Q?i66TlG2P3jtWJ8fwd5bxPbPhFOnAeAPqHJc+8X+CKLCV5WQxNhTg9fyrG1dE?=
 =?us-ascii?Q?WIQaqA71u+yeDg++BJ09KaagOkKBWHWroCeOVus2iakdBOYJpIftiKD7PmNW?=
 =?us-ascii?Q?ow2rCUvET2hFYqnZZCqA0cq6WqetGwD5WaUZ7GQBcnsaDNUWtL5m2mCOdqZk?=
 =?us-ascii?Q?OiSn0/yylZCLRghlcuIZOS145xfdCHN2owNTIMllSMK2XvR8/bRluv0H/lSG?=
 =?us-ascii?Q?ZXwv0Uw6yByOyABshbpvruDW9l2AJUA75xyjNLwscvYyL4LpgRfDiRzk8apo?=
 =?us-ascii?Q?BP1RMZDU8sU3KuzZ/XnQHkXvYxLXcIk36MRMeO0OhO6Cy3lZNdJ6I6ghthC+?=
 =?us-ascii?Q?EPm8d+GKXSlepDNelhcMgRPiDhof1RPS3yoJc3HJd9n3pK6t5X0eToWZLgJZ?=
 =?us-ascii?Q?DxgPkXINor1B1hY/uQqYPhyZcEEebL+fLSyUok23/twos1UdOoR9FDL3Ux3B?=
 =?us-ascii?Q?D46CDtcqqmCiKNQGudcFJmiVAnwhsmqbifLKiqDGM4X6zxmc9RhrJ+pAqjV2?=
 =?us-ascii?Q?M9EFpowwGzuL4RxyHsQ0vV4Snq7llvHp3V7sDyueeYVlaUnWmA4NekqcpJYu?=
 =?us-ascii?Q?g99DQqnjuymalgbyFUz5SaPna6BX+WvzrExjRHrpVsWEa8MNrwwzQGwpOERk?=
 =?us-ascii?Q?vPzmSbfixyp6JUD12Lb768X/JVCWD6uo4v3BgRNL+tUkQtAyuFwai2JJLSep?=
 =?us-ascii?Q?qOj5xctZN3EWQD3avD6419AM/glZolxRvNF7GdJGIy/GWbBYeM5ZmozGIrA0?=
 =?us-ascii?Q?QjId4LCG5qMnWw4/h0ozsrLfPu660QxtLT1Uv8yBcQ37MTu1dNQd/uZB27l1?=
 =?us-ascii?Q?eaCjxA6+5j2SPMxKsn1pLI5LyCwJz7PkKk0e3nzcCVBzaAHKV7Hd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63055a8e-158c-4657-3f38-08df3c29987c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:15:46.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIVditln28ZyEJM1qqxLURO7mQhOGX8TJxJZHO3JEFEPKV5i21B2PFqD65DdXfzqI+GSyEChkYvTRno4ivmXu9WhCTR//I8dwWHC9YaOoN0ZFzwgjzxJz9dzpLDoDfcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911

On Fri, Nov 06, 2026 at 03:13:08PM +0800, Junyi Zhao wrote:
> Amlogic a9 SoCs integrate the Silvaco I3C IP, and their peripheral
> clocks vary from the vanilla implementation:
>
>   - The EE-domain controller (amlogic,a9-i3c) takes two clocks,
>     "pclk" and "fast_clk", and the fast clock rate must be programmed
>     before the controller can be used.
>
>   - The AO-domain controller (amlogic,a9-ao-i3c) exposes only "pclk":
>     its bus clock is generated by an internal divider located in the
>     controller's own register space.
>
> Both variants need setup that the generic driver does not perform:
> the fast clock rate must be rounded and set at probe time, and on the
> AO variant the internal divider must be registered with the clock
> framework so that "fast_clk" even exists. The divider registers sit
> in the controller's own register space, so they can only be accessed
> while pclk is running.
>
> Add a vendor_init callback, invoked from the probe with the clocks
> enabled, to handle this. On the AO variant it registers the internal
> divider chain (div_en -> div -> gate) with the common clock framework
> and appends the resulting clock to the clk bulk array as "fast_clk";
> for both variants it then rounds and sets the fast clock rate
> (target 25 MHz). As vendor_init now runs after
> clk_bulk_prepare_enable(), the probe error paths that follow disable
> the clocks on failure.
>
> Extend the quirks bitmask with an Amlogic-specific bit
> (AML_I3C_QUIRK_AO) marking the AO variant's internal-divider
> behaviour. Since the driver now registers clocks through the common
> clock framework, SVC_I3C_MASTER also depends on COMMON_CLK.
>
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> ---
>  drivers/i3c/master/Kconfig          |   1 +
>  drivers/i3c/master/svc-i3c-master.c | 274 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 263 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index da96d2aaa..ac7d246c2 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -47,6 +47,7 @@ config AST2600_I3C_MASTER
>
>  config SVC_I3C_MASTER
>  	tristate "Silvaco I3C Dual-Role Master driver"
> +	depends on COMMON_CLK
>  	depends on HAS_IOMEM
>  	depends on !(ALPHA || PARISC)
>  	help
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index e700392f0..aef56286e 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/completion.h>
>  #include <linux/errno.h>
>  #include <linux/i3c/master.h>
> @@ -166,6 +167,31 @@
>   */
>  #define SVC_I3C_QUIRK_DAA_CORRUPT	BIT(2)
>
> +/*
> + * AML_I3C_QUIRK_AO:
> + * AO is the Always-On domain on Amlogic SoCs (remains powered in suspend).
> + * Its clock is generated by an internal divider located in the I3C
> + * controller's own register space.
> + */
> +#define AML_I3C_QUIRK_AO	BIT(3)
> +
> +/*
> + * Quirks shared by all the Amlogic A9 I3C instances.
> + */
> +#define AML_A9_I3C_QUIRKS	(SVC_I3C_QUIRK_FIFO_EMPTY | \
> +				 SVC_I3C_QUIRK_FALSE_SLVSTART | \
> +				 SVC_I3C_QUIRK_DAA_CORRUPT)
> +
> +/* Amlogic specific registers */
> +#define AML_AO_I3C_FCLK_DIV_CTRL		0x304

Do you have other registers after 0x304? Is it possible create indivial
clock driver for it, reg space is such as 0x300..0x400.

I3C use 0..0x300

So needn't distinguish w/o AO.

Frank

> +#define AML_AO_I3C_FCLK_DIV_EN_SHIFT		8
> +#define AML_AO_I3C_FCLK_DIV_SHIFT		0
> +#define AML_AO_I3C_FCLK_DIV_WIDTH		8
> +#define AML_AO_I3C_FCLK_EN_SHIFT		9
> +
> +/* Target fast clock rate of the Amlogic A9 I3C controllers, in Hz */
> +#define AML_I3C_FAST_CLK_RATE		25000000
> +
>  struct svc_i3c_cmd {
>  	u8 addr;
>  	union {
> @@ -195,8 +221,11 @@ struct svc_i3c_regs_save {
>  	u32 mdynaddr;
>  };
>
> +struct svc_i3c_master;
> +
>  struct svc_i3c_drvdata {
>  	u32 quirks;
> +	int (*vendor_init)(struct svc_i3c_master *master);
>  };
>
>  /**
> @@ -2011,6 +2040,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	if (!master->drvdata)
>  		return -EINVAL;
>
> +	master->dev = dev;
>  	master->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(master->regs))
>  		return PTR_ERR(master->regs);
> @@ -2019,27 +2049,43 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	if (master->num_clks < 0)
>  		return dev_err_probe(dev, -EINVAL, "can't get I3C clocks\n");
>
> +	ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
> +
> +	/*
> +	 * Vendor specific setup may register additional clocks (e.g. the
> +	 * internal divider chain of the AO variant) and program clock rates,
> +	 * so it must run with the clocks enabled.
> +	 */
> +	if (master->drvdata->vendor_init) {
> +		ret = master->drvdata->vendor_init(master);
> +		if (ret)
> +			goto err_disable_clks;
> +	}
> +
>  	for (i = 0; i < master->num_clks; i++) {
>  		if (!strcmp(master->clks[i].id, "fast_clk"))
>  			break;
>  	}
>
> -	if (i == master->num_clks)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "can't get I3C peripheral clock\n");
> +	if (i == master->num_clks) {
> +		ret = dev_err_probe(dev, -EINVAL,
> +				    "can't get I3C peripheral clock\n");
> +		goto err_disable_clks;
> +	}
>
>  	master->fclk = master->clks[i].clk;
> -	if (IS_ERR(master->fclk))
> -		return PTR_ERR(master->fclk);
> +	if (IS_ERR(master->fclk)) {
> +		ret = PTR_ERR(master->fclk);
> +		goto err_disable_clks;
> +	}
>
>  	master->irq = platform_get_irq(pdev, 0);
> -	if (master->irq < 0)
> -		return master->irq;
> -
> -	master->dev = dev;
> -	ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
> +	if (master->irq < 0) {
> +		ret = master->irq;
> +		goto err_disable_clks;
> +	}
>
>  	mutex_init(&master->lock);
>
> @@ -2163,9 +2209,213 @@ static const struct svc_i3c_drvdata npcm845_drvdata = {
>
>  static const struct svc_i3c_drvdata svc_default_drvdata = {};
>
> +/**
> + * struct aml_i3c_ao_clk - container for the AO variant's internal fast clock
> + * @div_en: enables the internal divider
> + * @div: bus clock divider
> + * @gate: output gate of the generated fast clock
> + * @lock: spinlock shared by the gate and divider register operations
> + *
> + * The clock HW structures are registered with the clock framework and must
> + * stay alive for the whole driver lifetime, so they are kept along with the
> + * shared lock used by their gate/divider operations.
> + */
> +struct aml_i3c_ao_clk {
> +	struct clk_gate div_en;
> +	struct clk_divider div;
> +	struct clk_gate gate;
> +	spinlock_t lock;
> +};
> +
> +/**
> + * aml_ao_i3c_tail_clocks - register the AO variant's internal fast clock
> + * @master: I3C master controller
> + * @parent: parent clock of the internal divider chain; must be "pclk", the
> + *          only clock the AO variant exposes (see silvaco,i3c-master.yaml)
> + *
> + * Register the internal divider chain that produces the AO variant's
> + * fast_clk and append it to the clk bulk array as "fast_clk". The caller
> + * must run with the clocks enabled since the divider registers are
> + * accessed during registration. The appended clock is prepared and
> + * enabled here as well, because clk_bulk_prepare_enable() already ran
> + * in the probe with the original clock list.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int aml_ao_i3c_tail_clocks(struct svc_i3c_master *master, struct clk *parent)
> +{
> +	struct device *dev = master->dev;
> +	struct clk_bulk_data *new_clks;
> +	struct clk_init_data init = {};
> +	struct aml_i3c_ao_clk *ao;
> +	struct clk *fclk;
> +	char name[64];
> +	int ret;
> +
> +	ao = devm_kzalloc(dev, sizeof(*ao), GFP_KERNEL);
> +	if (!ao)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&ao->lock);
> +
> +	snprintf(name, sizeof(name), "%s#div_en", dev_name(dev));
> +	init.name = name;
> +	init.ops = &clk_gate_ops;
> +	init.flags = CLK_IGNORE_UNUSED;
> +	init.parent_data = &(struct clk_parent_data) {
> +		.index = -1,
> +		.hw = __clk_get_hw(parent),
> +	};
> +	init.num_parents = 1;
> +
> +	ao->div_en.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
> +	ao->div_en.bit_idx = AML_AO_I3C_FCLK_DIV_EN_SHIFT;
> +	ao->div_en.hw.init = &init;
> +	ao->div_en.lock = &ao->lock;
> +
> +	ret = devm_clk_hw_register(dev, &ao->div_en.hw);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register %s\n", name);
> +
> +	snprintf(name, sizeof(name), "%s#div", dev_name(dev));
> +	init.name = name;
> +	init.ops = &clk_divider_ops;
> +	init.flags = 0;
> +	init.parent_data = &(struct clk_parent_data) {
> +		.index = -1,
> +		.hw = &ao->div_en.hw,
> +	};
> +	init.num_parents = 1;
> +
> +	ao->div.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
> +	ao->div.shift = AML_AO_I3C_FCLK_DIV_SHIFT;
> +	ao->div.width = AML_AO_I3C_FCLK_DIV_WIDTH;
> +	ao->div.hw.init = &init;
> +	ao->div.lock = &ao->lock;
> +
> +	ret = devm_clk_hw_register(dev, &ao->div.hw);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register %s\n", name);
> +
> +	snprintf(name, sizeof(name), "%s#gate", dev_name(dev));
> +	init.name = name;
> +	init.ops = &clk_gate_ops;
> +	init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
> +	init.parent_data = &(struct clk_parent_data) {
> +		.index = -1,
> +		.hw = &ao->div.hw,
> +	};
> +	init.num_parents = 1;
> +
> +	ao->gate.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
> +	ao->gate.bit_idx = AML_AO_I3C_FCLK_EN_SHIFT;
> +	ao->gate.hw.init = &init;
> +	ao->gate.lock = &ao->lock;
> +
> +	ret = devm_clk_hw_register(dev, &ao->gate.hw);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register %s\n", name);
> +
> +	fclk = devm_clk_hw_get_clk(dev, &ao->gate.hw, NULL);
> +	if (IS_ERR(fclk))
> +		return dev_err_probe(dev, PTR_ERR(fclk),
> +				     "tail i3c fast clock failed\n");
> +
> +	new_clks = devm_kcalloc(dev, master->num_clks + 1, sizeof(*new_clks),
> +				GFP_KERNEL);
> +	if (!new_clks)
> +		return -ENOMEM;
> +
> +	memcpy(new_clks, master->clks,
> +	       master->num_clks * sizeof(*master->clks));
> +	new_clks[master->num_clks].id = "fast_clk";
> +	new_clks[master->num_clks].clk = fclk;
> +	master->clks = new_clks;
> +	master->num_clks++;
> +
> +	/*
> +	 * Keep the clk bulk state balanced for the following
> +	 * clk_bulk_disable_unprepare() calls (error paths and runtime PM).
> +	 */
> +	ret = clk_prepare_enable(fclk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "can't enable fast_clk\n");
> +
> +	return 0;
> +}
> +
> +/**
> + * aml_i3c_init - Amlogic A9 specific init, called with the clocks enabled
> + * @master: I3C master controller
> + *
> + * Register the AO variant's internal divider chain and round/set the fast
> + * clock rate for both variants.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int aml_i3c_init(struct svc_i3c_master *master)
> +{
> +	struct device *dev = master->dev;
> +	struct clk *fclk;
> +	long fin_freq;
> +	int ret, i;
> +
> +	if (svc_has_quirk(master, AML_I3C_QUIRK_AO)) {
> +		/*
> +		 * clk_bulk_get_all() preserves the DT order, and the
> +		 * binding restricts the AO variant to exactly one clock,
> +		 * which is always "pclk".  So clks[0] is the input of the
> +		 * internal divider chain.
> +		 */
> +		if (strcmp(master->clks[0].id, "pclk"))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid AO input clock\n");
> +
> +		ret = aml_ao_i3c_tail_clocks(master, master->clks[0].clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < master->num_clks; i++) {
> +		if (!strcmp(master->clks[i].id, "fast_clk"))
> +			break;
> +	}
> +
> +	if (i == master->num_clks)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "can't get I3C fast clock\n");
> +
> +	fclk = master->clks[i].clk;
> +	if (IS_ERR(fclk))
> +		return PTR_ERR(fclk);
> +
> +	fin_freq = clk_round_rate(fclk, AML_I3C_FAST_CLK_RATE);
> +	if (fin_freq <= 0)
> +		return dev_err_probe(dev, fin_freq ? fin_freq : -EINVAL,
> +				     "invalid fast_clk\n");
> +
> +	ret = clk_set_rate(fclk, fin_freq);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "setting fast_clk rate failed\n");
> +
> +	return 0;
> +}
> +
> +static const struct svc_i3c_drvdata aml_a9_drvdata = {
> +	.quirks = AML_A9_I3C_QUIRKS,
> +	.vendor_init = aml_i3c_init,
> +};
> +
> +static const struct svc_i3c_drvdata aml_a9_ao_drvdata = {
> +	.quirks = AML_A9_I3C_QUIRKS | AML_I3C_QUIRK_AO,
> +	.vendor_init = aml_i3c_init,
> +};
> +
>  static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
>  	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
>  	{ .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
> +	{ .compatible = "amlogic,a9-i3c", .data = &aml_a9_drvdata },
> +	{ .compatible = "amlogic,a9-ao-i3c", .data = &aml_a9_ao_drvdata },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
>
> --
> 2.42.0
>
