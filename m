Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793657428;
	b=a5IJT8BaX5ndVEIjN216NnRRF8jKYhREgPWUfWqWzScrsx2u6PmeEpV9wKs6DkDvCIiG
	 cdWUqIRbCNdRfj+9mPiLBs4Jz1AI6WRSe3MyjzPRKE5MZPPxhEyENtSuJvs9PyTU1V86U
	 AcSidZ5J7S+5iqCOlCzcb8gewjgGsiXtsfRgwH355z5H6vbbPoiT92tBBGGgvtrfiz3kb
	 QDY9WqR4+coWuaX45qFqfjgR6pO1Lr7icipFSOYv7WW9/mYYYvQvvgw9TgPabeZovTmZa
	 nJDrToYHofqcqJWMsGC7DWvirSEgQNvMj5LHOYd/8rUDE/nD1nJbpo6dXec/OJuFtCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657428;
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
	bh=TDIvWnwDtKWjPBeSEijuQwbcWng7n4+0E+Frwtf0vvU=;
	b=hXPYAN534ihcT5MRfUH0jyCmmjjXMJP5BpkSu7nLe9svhh+EN/E2BPqU2iei1O+gIVcY
	 tSrVCd6uUGzL9j/z+dO/yKu8RkFHu5vIDKYMuc50JKh7b0foQKSKid0D7T/wfoXukD3OU
	 uEY7CkWCWGCFbT01TUIEDE17V+5Zx4Dl/aPz3TLLD3YsRTDlN4n1YlAad5qcNLt94JLDB
	 +++R7QPe99qsco9LhojrYxXN+tmIQbEWZ7LJebi+/yAfm3htdqc2bPHjKKHyvksTrzSdn
	 D6yhFcFYODFwgi3rCbRdYbGa5saoW836433XqGbNlpsHoGTofIXlWfzygx/bk9RieCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aHFKuFA1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.2
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF564606A335;
	Mon,  2 Nov 2026 22:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF564606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aHFKuFA1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtaedo1MuCDyYftbVBp11tHahPhQsy/CDc35e81vtSXNtegBEoeg1UiInt91+vxVEMGOWkOW88x5zol/TI+mMvwWUUWLT7+gaPzZlwwDa9aj1XyzcVJpkPgwYVWje+rF1Vl/LIWOw6RdllMt2RX3n0KKLHkXWnwesLiJ5B6LNxqNT5p9pi9CMoysVOYJXkpUnTF05gNRqzXeUFZkWzVpiTAR42LqfOfF9BJNEowilRF+9R1KSuBFzzS4hL8YkiIxOL3owSJoDTxkU78ZImg4wB4vg3xv6pLjqHSaivJre91kUWQOHUMaclLqUKcQBiyYY/47rwh+l+hVuQ7TQ9GGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDIvWnwDtKWjPBeSEijuQwbcWng7n4+0E+Frwtf0vvU=;
 b=Cb5vMnqHOKVArDkQDQlNZzgcxuS+tJthUmAWvqH57d71+yawD1VrQ+PQcDTVyIT+keFCnURxb9Aj2RtKpbNEOe4HXtBdzp8b80D92eX76leBpui0lYPBlXmgbZr2GPlE5KhgFtJVuOky3lvRKd1WykC9bk59H5Nl5BGHlqMY6HiLcms6Wk6rvl7Qn2XPaThlh50LLVmmx16MKjZ0CI9UmmUaGqD2yH7RPLuvnLfgtMH9VLjLgfBMjR3LpWuEuxVUqel6Quv8AV3WO8O8Jih1YActGxJwsSqFolGG2tu6rXOyMIx77L6+eUISva2KFnVGKDs/r6j26TBmY/o6/t/NyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDIvWnwDtKWjPBeSEijuQwbcWng7n4+0E+Frwtf0vvU=;
 b=aHFKuFA17Y6s4B7C4LR2cekP056CIIOaUSceHcDsYmd9ZL3qdT5/6Pgi9Sp5yflZiiaPqDitRHAXWc2fvHKzw3+LzrrLnBS2mucoDgGqScWZ9+IJX8VbhKxwj9OY9L/twFzBT7SI7RywAxX0P1yi2cUp97XU2RbjnEFMQpGCGQCXy7D9GcsfdyjWBt0ooOcUoyNtuXQtyL14qJipr9JdGfHJryx56sJKcUybxNGmAbt5qImP8e79ZcwK+H8UgX2UXkyFZAcRvBpWrEm/OQ+rNVhyd1bpMWAGuaiKx+/gNu/O+ZWjuEBpfSlSiSLrOGg1Z/KPvyjGZt4ldfFcKo066w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BR0PR04MB983609.eurprd04.prod.outlook.com (2603:10a6:2c8:60::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 22:10:24 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 22:10:24 +0000
Date: Mon, 2 Nov 2026 17:10:13 -0500
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
Subject: Re: [PATCH v2 1/2] i3c: master: svc: Add amlogic a9 support
Message-ID: <aukKRUYfEABgIruC@lizhi-Precision-Tower-5810>
References: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
 <20261102-a9_i3c-v2-1-0c474bfccffa@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-a9_i3c-v2-1-0c474bfccffa@amlogic.com>
X-ClientProxiedBy: PH7P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BR0PR04MB983609:EE_
X-MS-Office365-Filtering-Correlation-Id: 435c2e1b-9bf2-4e0a-e205-08df392e17bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|261102123227099003|261021133027099003|56012099006|4143699003|11063799006|261021123027099003|261026135527099003|261009223027099003|261009221227099003|261021135927099003|261028144727099003|261022113327099003|261022075727099003|261021130227099003|261022105027099003|261026140227099003|261026130827099003|261022115727099003|261026121527099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	c5Uo9WFT2eH9jRlSei8WRsMyrpxbpMWeUPwKj8AubSFzWSjc7E5e49UTrcjvqlK02pF14leeaxh4m+B3jfV4ZTUNZlt36zIHYDNDB3CEVxwFYj5OBX8cwv0yT6r0K56v066VG5aqTpaY4Q0q4q+mkVnmahXpfuYxYGxDLNMOhoXxxcY777CnCBRoTWxmCwxO0w6XjRSOwXfjPPVB713spsK/uNNUEgDy/YQ027bd2T6tapqQ0z+dsz8WnFV/9bh8yM78V/oJaqT82gYbc7/XyEK/bcco6BEHRNldAWeHz/0cvU5Kx0bkREFmcJYFg6wJkUJjn3Ih53+Hgwdd2bSilZXegNt+8Ttv65SdYpGXnTb/9iC9EQXNRbfSv75DNmY+gHjnr94wEQt+Au9cYa+CbVvg6AwAeinthuzkihMa4HlR0b1+1NqSpHYy+ryfHUqjA2VgEzFjdknYjw/FsLp15pv7Bn4PLfhp+ZOpRv1p0VHi9UhROwIczML9lB5+lVjdUMuOBM+EueTucHIf8qW6gg/O278jT9lotaZFdHP/i2ZSxSNtE5VWfEVuh5Cl5XdFFuTVrSQLFNA8ipzLruSZXz07Nwm5c0HHIzHfPXa5f2c9fispIfUY4kJhylp0L+wJmz1dxBsVGBq6D4ATf7C2fpBjGMp7rmOQ6VqaUFANhQs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(261102123227099003)(261021133027099003)(56012099006)(4143699003)(11063799006)(261021123027099003)(261026135527099003)(261009223027099003)(261009221227099003)(261021135927099003)(261028144727099003)(261022113327099003)(261022075727099003)(261021130227099003)(261022105027099003)(261026140227099003)(261026130827099003)(261022115727099003)(261026121527099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hWR4Rw97bY5wFdAE4mfvclEewc1ZEx71vXPtSxs+8IzT7Bc8NmCWFXX5ZjQi?=
 =?us-ascii?Q?GFwIau9wn0hyPL9O8/sfhg5dR2mrY0Gh8TbKMOvtzQqlewa5WyHB5MptpLg/?=
 =?us-ascii?Q?xwyL8/rYvO67s8FKD0cF7YQRfbGTDmoMNSlgomko369IUyBJtYnBn9ECGfYW?=
 =?us-ascii?Q?cLGib2OSo+HudfEsADYZeP7HbSdt3wQUIkpVPShoRSDp6xNdy4iZVFW/xU+1?=
 =?us-ascii?Q?VDS8wdBAaqoGmwICz6iOdavTYkmxT3uMVDSkR9lCnXbDhjDDpUJCo1App77S?=
 =?us-ascii?Q?aDGdpCMk7F41tt/NI1v0YPeT+l/Fw3Jpo8gBmNoWRNCgRGEZDmEd2uHIoI5i?=
 =?us-ascii?Q?e9ux2PHa9h43SjFPS9WkbGlX1EZUWwqsYSEGjtecmJ7883d2eNRj8+5HSnHg?=
 =?us-ascii?Q?+taS9DuKpJ+pGgXJE0hdeTYizu6/a0E+4pedoyrNd9bx6EQI/NCv8qWyQ/D9?=
 =?us-ascii?Q?lGuFEw6VRpX3vpyC2aUL0BbYU2Bcp+p5aGcuJCTMBKc7GIbQ+LACtlJCOzFM?=
 =?us-ascii?Q?+9dMrppCZeswx9qGK01bWvhm1yDIoPL30yXNJ+3JqG7067YthzyhvRcmaK4c?=
 =?us-ascii?Q?MZf83CxawdS1q0l6J5ojQV/WkwLwF0vBfaFjg0fRmM+5BLsjq07+RGKEhpuV?=
 =?us-ascii?Q?gKOJYdH0w9fIm3krm5m9INJumfZSgEmBwjzRm34lskphlJvDw14mSW+EJD7P?=
 =?us-ascii?Q?KwInmGL6MnMIxG7WqMA3j+5Ts5VgJYoBY4snT7Rv1glzguYQvsVYVEA+h+2B?=
 =?us-ascii?Q?ctYxjOvTDyYb8WHWQDlhSjTwO5GkjZckGADR5smXxjAOrzA8ukX483o0fCnl?=
 =?us-ascii?Q?9ioMLLdJvkNVuf7FqavhiqS63CSAkTlcY2+z8ehWlI/z3Lw78M4GD/Vw/s3Y?=
 =?us-ascii?Q?SQiCEVrtcKh3xaywp8ZVrEhjDF2F9/xLTMnE79ENC4+QsRmDGwXAuHR4TWx0?=
 =?us-ascii?Q?D3cj9Z/HDgTfrFots7dprAAEp+bGVn6HXMadAOyx7IjKIlEDWCvMLX3lcDfZ?=
 =?us-ascii?Q?xJPMQVpi1HVHQlkVHZllbGoZqMe9dOMwzCwwqmhsLD3d/tKgPcuewq9/y1Y8?=
 =?us-ascii?Q?A/E5AYrLgZsIG7gnmFhBK5l1H7OgU6n1oYAZbxI8iuTOu/lXHknYoNHVMCtN?=
 =?us-ascii?Q?BuqLcZIeeQb4P0A3S091VznaD/O0arHklvQND9EQl1Mb5+DZCgBUWr49Gz4f?=
 =?us-ascii?Q?If+9lixfz5YnjhDFG712DdoTmMvENIjXQj8+vTpCB3q9++JHdOEBLe5G7sw7?=
 =?us-ascii?Q?KnF2f2hlQ4qw/D4wHCqJwDiN3JVECRFflL+3kSDto9aHThzftD3mTEJ6dEZ7?=
 =?us-ascii?Q?9kth8JaG2eRgcyXRNhjfduUb2OvB+59Fb7D8Z7CAp1RcGkTNJ1F2p+YKxLuR?=
 =?us-ascii?Q?cgE74f71aydcxnEVtUuKAu2Xzg0c1gs/UGJrOybSlfUdSCwt4XVmkHHx8jDB?=
 =?us-ascii?Q?rLYEPMc40qLnDWLxLwmhk5/hSMvRYYZd2KwibP9iAHMJ0Znm3R55PJFU7q0s?=
 =?us-ascii?Q?2Im0mrBl8UxivI2YEnkJL4s3XlyCIjmk6hmTNtWeGP3k0OGaWI4zbdvQ7ah0?=
 =?us-ascii?Q?SHE2e3DkDnILoq59EQpZQDyuKZfzCcjr+gn6MHFHi5Od91JBmvkvmHzewx6n?=
 =?us-ascii?Q?jmo6f0laPAsN7sDpYANxMi96YFPc3QzjEDin9q4uVQKh0XLWZeVRr87ddPXw?=
 =?us-ascii?Q?jF4XiBx/l8++TCatuWHeaiAD0BTjqt1ubcnnwTPK77nHFWfIiOAWWHUvlI78?=
 =?us-ascii?Q?4/Om9NgLMCqs+ZVm7llpNxJJlfWB9hBNI8MUHbzQXdI38iQDqlyz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435c2e1b-9bf2-4e0a-e205-08df392e17bb
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 22:10:24.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKwz5ZrcW9cQ+clH80lhcaIQGKKbC4gVaOutHLLbM/OibM8McKATTygGX795Z8pKJlwqrVO2SObBTHJGFDHBN4DHKG10XMHdx7LcfKlLegf2KrgruFoEiacMaSvEBDh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB983609

On Mon, Nov 02, 2026 at 07:05:39PM +0800, Junyi Zhao wrote:
> Amlogic a9 SoCs integrate the Silvaco I3C IP, and their peripheral
> clocks vary from the vanilla implementation:
>
>   - The EE-domain controller (amlogic,a9-i3c) takes two clocks,
>     "pclk" and "fast_clk", and the fast clock rate must be
>     programmed before the controller can be used.
>
>   - The AO-domain controller (amlogic,a9-ao-i3c) exposes only "pclk":
>     its bus clock is generated by an internal divider located in the
>     controller's own register space.
>
> Add a vendor_init callback to handle this clock setup.
> Add a vendor_quirks field to describe AO-specific behavior.
>
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 214 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 209 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index e700392f0..98aa6eb0f 100644
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
> @@ -166,6 +167,21 @@
>   */
>  #define SVC_I3C_QUIRK_DAA_CORRUPT	BIT(2)
>
> +/* Amlogic specific registers */
> +#define AML_AO_I3C_FCLK_DIV_CTRL		0x304
> +#define AML_AO_I3C_FCLK_DIV_EN_SHIFT		8
> +#define AML_AO_I3C_FCLK_DIV_SHIFT		0
> +#define AML_AO_I3C_FCLK_DIV_WIDTH		8
> +#define AML_AO_I3C_FCLK_EN_SHIFT		9
> +
> +/*
> + * AML_I3C_QUIRK_AO:
> + * AO is the Always-On domain on Amlogic SoCs (remains powered in suspend).
> + * Its clock is generated by an internal divider located in the I3C
> + * controller own register space.
> + */
> +#define AML_I3C_QUIRK_AO	BIT(0)
> +

There are not much quick now, just put after SVC_I3C_QUIRK_DAA_CORRUPT

#define AML_I3C_QUIRK_AO     BIT(3)

use a unified quirk define.

>  struct svc_i3c_cmd {
>  	u8 addr;
>  	union {
> @@ -195,10 +211,6 @@ struct svc_i3c_regs_save {
>  	u32 mdynaddr;
>  };
>
> -struct svc_i3c_drvdata {
> -	u32 quirks;
> -};
> -
>  /**
>   * struct svc_i3c_master - Silvaco I3C Master structure
>   * @base: I3C master controller
> @@ -257,6 +269,12 @@ struct svc_i3c_master {
>  	u32 mctrl_config;
>  };
>
> +struct svc_i3c_drvdata {
> +	u32 quirks;
> +	u32 vendor_quirks;

Needn't this, direct use quirks

> +	int (*vendor_init)(struct svc_i3c_master *master);
> +};
> +

why need move this struct

>  /**
>   * struct svc_i3c_i2c_dev_data - Device specific data
>   * @index: Index in the master tables corresponding to this device
> @@ -274,6 +292,11 @@ static inline bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
>  	return (master->drvdata->quirks & quirk);
>  }
>
> +static inline bool vendor_has_quirk(struct svc_i3c_master *master, u32 quirk)
> +{
> +	return (master->drvdata->vendor_quirks & quirk);
> +}
> +

Needn't this one

>  static inline bool svc_has_daa_corrupt(struct svc_i3c_master *master)
>  {
>  	return ((master->drvdata->quirks & SVC_I3C_QUIRK_DAA_CORRUPT) &&
> @@ -2011,6 +2034,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	if (!master->drvdata)
>  		return -EINVAL;
>
> +	master->dev = dev;
>  	master->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(master->regs))
>  		return PTR_ERR(master->regs);
> @@ -2019,6 +2043,12 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	if (master->num_clks < 0)
>  		return dev_err_probe(dev, -EINVAL, "can't get I3C clocks\n");
>
> +	if (master->drvdata->vendor_init) {
> +		ret = master->drvdata->vendor_init(master);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	for (i = 0; i < master->num_clks; i++) {
>  		if (!strcmp(master->clks[i].id, "fast_clk"))
>  			break;
> @@ -2036,7 +2066,6 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	if (master->irq < 0)
>  		return master->irq;
>
> -	master->dev = dev;
>  	ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
> @@ -2163,9 +2192,184 @@ static const struct svc_i3c_drvdata npcm845_drvdata = {
>
>  static const struct svc_i3c_drvdata svc_default_drvdata = {};
>
> +/*
> + * Container for the tail clocks of the AO domain variant. The clock HW
> + * structures are registered with the clock framework and must stay alive
> + * for the whole driver lifetime, so they are kept along with the shared
> + * lock used by their gate/divider operations.
> + */
> +struct aml_i3c_ao_clk {
> +	struct clk_gate div_en;
> +	struct clk_divider div;
> +	struct clk_gate gate;
> +	spinlock_t lock;
> +};
> +
> +/*
> + * aml_ao_i3c_tail_clocks - register the internal divider chain that
> + * produces the AO variant's fast_clk, and append it to the clk bulk
> + * array as "fast_clk".  @parent must be "pclk", the only clock the AO
> + * variant exposes (see silvaco,i3c-master.yaml).
> + */

use kernel doc format.

> +static int aml_ao_i3c_tail_clocks(struct svc_i3c_master *master, struct clk *parent)
> +{
> +	struct device *dev = master->dev;
> +	struct aml_i3c_ao_clk *ao;
> +	struct clk_init_data init = {};
> +	char name[64];
> +	int ret;
> +	struct clk_bulk_data *new_clks;
> +	struct clk *fclk;

keep revise Chemistry order

Frank

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
> +	new_clks = devm_kcalloc(dev,
> +				master->num_clks + 1,
> +				sizeof(*new_clks),
> +				GFP_KERNEL);
> +	memcpy(new_clks, master->clks,
> +			master->num_clks * sizeof(*master->clks));
> +	new_clks[master->num_clks].id = "fast_clk";
> +	new_clks[master->num_clks].clk = fclk;
> +	master->clks = new_clks;
> +	master->num_clks++;
> +
> +	return 0;
> +}
> +
> +static int aml_i3c_init(struct svc_i3c_master *master)
> +{
> +	struct device *dev = master->dev;
> +	long fin_freq;
> +	int ret, i;
> +	struct clk *fclk;
> +
> +	if (vendor_has_quirk(master, AML_I3C_QUIRK_AO)) {
> +		/*
> +		 * clk_bulk_get_all() preserves the DT order, and the
> +		 * binding restricts the AO variant to exactly one clock,
> +		 * which is always "pclk".  So clks[0] is the input of the
> +		 * internal divider chain.
> +		 */
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
> +	fin_freq = clk_round_rate(fclk, 25000000);
> +	if (fin_freq <= 0) {
> +		dev_err(dev, "invalid fast_clk\n");
> +		return fin_freq ? fin_freq : -EINVAL;
> +	}
> +
> +	ret = clk_set_rate(fclk, fin_freq);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "setting fast_clk rate failed\n");
> +
> +	return 0;
> +}
> +
> +static const struct svc_i3c_drvdata aml_a9_drvdata = {
> +	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
> +		  SVC_I3C_QUIRK_FALSE_SLVSTART |
> +		  SVC_I3C_QUIRK_DAA_CORRUPT,
> +	.vendor_init = aml_i3c_init,
> +};
> +
> +static const struct svc_i3c_drvdata aml_a9_ao_drvdata = {
> +	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
> +		  SVC_I3C_QUIRK_FALSE_SLVSTART |
> +		  SVC_I3C_QUIRK_DAA_CORRUPT,
> +	.vendor_quirks = AML_I3C_QUIRK_AO,
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
