Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795463401;
	b=a+ORUIrbYkA2z7TQYUGgfwj4Ztk2w6bTqMu0tSjI3byMSJ6Rcue3dsH+egK4QHQvM4lV
	 pLC9BwqGXLAlQriO0vpVl3FCGXy7ke/T57Im8dT/6shWJMou2FUsgGis2mTNrGJtbxHPl
	 pfgiDLBu2iFc5A6VJjo/kOopwSV17LiLT1HbdwADSTmSPrRqtNLBBsPwZrmMNfy0hZAbL
	 Yrv+rItvxMOfjK0i/GwZQp/afU1T3BdaywYLA/MnDCkeCIBLu/8z7I8NbbLOmNuhCJBDn
	 SyCsI26/BIr9r4N/yoB/PoCTJqoqATi5QXBWH+XBwrKLJszhsC92LnfjbVkPp8jcNnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463401;
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
	bh=p8KtVLNBxWMdVF0wgv2MyChF8SQdarThzta1G7UJ0JE=;
	b=r8ReMZR7rTqCf5qnb5hbXDdoJg4VDtTVYBqMCnD9ijtvZLiT0gS7b4BNibREUQv5/3jk
	 KCuObah8AsJUxkvc1ly9RMvfKwDOFdHYN7sO1IXhT4zN3BCwXjwOvN5t/OZpJ2Gl1quW5
	 gAgdt+EvOonId/B1jpad6F19qhjak4yMkWcOs8ry5qUMt6pSCdJFak3WJB3mIa1WmkhWC
	 yN38eQPxH5JvfyUxWmehhRT9CNHbtZw5lALg2z8kuf2+DxvHtV5K8IvY9JeXEGocsbVM0
	 FgICsBmyggPREimq/DABsyHn5sPuqdnfocTzi3AyayogAW9YutA6CxW8ln44w8Gaw8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=C1emWgBK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.47
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FECB606A689;
	Mon, 23 Nov 2026 19:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FECB606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=C1emWgBK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxh77RPZLqeDOL1Ne+vPE6WB8WbJ/rKNostGOmYYTIDB58o648oVTAQp3oOyYq7evncrB2qkVe5tIXHajUBcD01W94JoIlRD469dNx+3CaoXxit2VzIWFsb+PoAySCo+YP6vzBqOoRXpitEksfMr5LxUyoM1C/r6g6qg7KT1HPtGxMT/pxpq/dUfLDrBC3ik38II9zvQcx4T2hWYPXQuQV9wk12Hs3+QbDCi7XY6uCxVHCZZ+Pzqi/zARNSeb6gw1aV1enAJKYezZcL/TgwqMoH8Zf1OH0dDCVPWlNYAomb63Z0Mn30JStcY9nJg01uS7T84KIoxvWiFuoKpMXSO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8KtVLNBxWMdVF0wgv2MyChF8SQdarThzta1G7UJ0JE=;
 b=CuXvGyMam2KXn6qHtN3ELqQ+PwhApQupiUulBJgQdQMJ98AIMtmc3AdOnl+sacksNP+FH6bZJJPXnGbr1/joz4oNC3kw2tfQAvCPFu+XCZe6BVCzHFGDhflQ8JlBSa+qR1QrVGknvyPNQsd/G8uAR9FwKOR0CBFWYlGu/Hhi56xhprSc/sgtMmbi5PcTgJKg7omO3VUHcKrZ84a9IZ9GSA/Nb8Y/EQQgF+5vdYhc+qquSMbebD6wfKXzNYGeu6Atm0TShNBjRF7rvKrESGzq0nuWQALngV1BBZsbO07Uxn/T8Jw2MYYmhc5J57blyqC09T2iiMVSF3Spz7Q6e3JOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8KtVLNBxWMdVF0wgv2MyChF8SQdarThzta1G7UJ0JE=;
 b=C1emWgBKKwOpc/eVwccTXu1MS7ai4qsWNkXMWk/dgJ5aUt2+fQlQ9FrYl3fPlPDom4jFTKWr9Kl8eBzPmVs+ErX3bUaHYHig+8GlvwtQldJAe2mtfXSguhpfrTxg/WJZPe81BZnBXhwB5tH2SSh8oSwdOwJB9IGmRbQS+NGiCuCQ1WbOYY2BKWGZaBlthbUnF8Xenw4B5IeycER/hOweQI+PnUkedPAc9bb2aNs/7z15OrEzGVTRJZlkGuDZTr9iRLfRVihevOLwfpWj2T+brljHrjcodz9+EB38D09vU7CTGbCALGdRX6ylToWxkH8dzhv4EHSbLj/c1s5gveB8Xg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 19:49:57 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 19:49:57 +0000
Date: Mon, 23 Nov 2026 14:49:47 -0500
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
Subject: Re: [PATCH v5 2/2] i3c: master: svc: Add amlogic a9 support
Message-ID: <awSY2zq0raAmAGxr@lizhi-Precision-Tower-5810>
References: <20261119-a9_i3c-v5-0-6ec51f8fb59d@amlogic.com>
 <20261119-a9_i3c-v5-2-6ec51f8fb59d@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-a9_i3c-v5-2-6ec51f8fb59d@amlogic.com>
X-ClientProxiedBy: PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 49315519-c531-4aca-8c59-08df499af370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|19092799006|261009220027099003|10067099003|5023799004|11063799006|4143699003|261021133027099003|261021130227099003|261022075727099003|261021135927099003|261021121427099003|261026121527099003|261026130827099003|261021123027099003|261022115727099003|261022113327099003|261022105027099003|261026135527099003|261026140227099003|261028144727099003|261102123227099003|56012099006|261009221227099003|18002099003|261009223327099003|261009223027099003|261009221727099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NNx1cdwvvCJm+c0pcC25kc9YDJtBtA5EkusOqcqmYfzgEtFXg0GQOmZfwdb+QiLlHXB0NXDhRiblpJG9FlHYMOGR5WFEK7SEHSBfX02kvAIN9framAJXBxUPWWm6xQrSQ1Vr/Twj85/1heVW5o5uEtnkoIBtmJO8uTdewCuP5AtI+0/eUEyOfxIf3J9HD9qcUjO1FZar402+ciQ6nY00aGEaZJmCendlO3u2Va43Z1qHVv/9N6n+7hDpszdCU0w19KwhPGUNCjZnHe9uNbsBe1KtjJeZ3MPcSRJVrntTwwGirrNkEwkvJyk3SLskXA2djhYbQe58rftOnNhBW9FlAIAC7tvzqKSAZpAh7pAl40XL8vgDCnKpnzbveKzuDMGc5MIQfE+2X6BL6E8e1WI2qtEG7Yne9vXGf98FuJkDqoeyzYoiCwAzQUQ+/jdPqcSBt1DBoTd3apP2ST6GBn7AGpk4SqaMDFm2xRaXYn+2vrJom9PH2YbmhoII5ymGnme7EWyB+xf4d7toI2NO9fRvy5ERvMlelPTN4P55nex4+sBVqN/VTxtFfNpO0+vjOwvxoHRn01o3IbLC62uVxFZgpC8xmisizF/u8TICaX6ZYiZCPbLhpkp5EclBFNo+W5GCqc7h1f8kDn6wR9i60CXQjj43wOAhXhRNrjlQr1nguFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(19092799006)(261009220027099003)(10067099003)(5023799004)(11063799006)(4143699003)(261021133027099003)(261021130227099003)(261022075727099003)(261021135927099003)(261021121427099003)(261026121527099003)(261026130827099003)(261021123027099003)(261022115727099003)(261022113327099003)(261022105027099003)(261026135527099003)(261026140227099003)(261028144727099003)(261102123227099003)(56012099006)(261009221227099003)(18002099003)(261009223327099003)(261009223027099003)(261009221727099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nX4bTsBS4N2KalEwMjWxy6Go2urw9yih/moVbSkWLGqyuEH/KDX6TdipR3qn?=
 =?us-ascii?Q?JSAuTF9j5DEfCMR98LQqXyUgG5oxXvfSeDY7N4mvjxeCTbmP2+MTWKAw35mB?=
 =?us-ascii?Q?gqvE+lPtH7A2bQABo1oFn+scun/jxf6AfI1Wff43EKVn/JYnJ9FPCFZKh4Gn?=
 =?us-ascii?Q?uK9KCHk8EbO3VW/71FJwmC/91t/e5kKOA3/6NnQiCfrnY5HxfnYwVQeD7Xd7?=
 =?us-ascii?Q?Eq63/P8CIvWaBS1oKXSCGdwbZ9KUfo0kKrRlBC5ZFpQAo03cOWf9k3uDB1W1?=
 =?us-ascii?Q?VuFPwJ1m4xCZIYkvEi4sGTHlFFRSMw1upn7UTrZVGbYfFaG7GA0J9kBRYrtn?=
 =?us-ascii?Q?X1ZGiVMahQ/3eM3ifZaa2iXnLMAv3jX1FQIzKNUL0HnMnBN1ua+xz35NTBjb?=
 =?us-ascii?Q?hXGs7llEWPHzdhzL5r0YvQzfnblMAP3iUJyhsooKE+pIwDacrms4p6wcz5R6?=
 =?us-ascii?Q?c71bvtb9X7zOldMW0/9pJsRhzUNgYeYIrlVA0etHGRoQRffwYn/d5woMUPqg?=
 =?us-ascii?Q?rLJDB8+tORWRRIFyZP8zf6M/SyM1U9PbngdXtHdP0vxi5CBQgsuZ1rN+ZJPG?=
 =?us-ascii?Q?V+xs3vTGAdA/FVx9pn/n6aZ3579iMxDfkpl8t88AwcacXdUCxRoSL9MELgjm?=
 =?us-ascii?Q?FWPp93iLxTvQK/pmpHC7x30YcM/pweW2ET4GXxp7XI/i6epSd8m8+ZAwbQDG?=
 =?us-ascii?Q?Jo2Axrx6PmilgVBDzd1/YvFgx5vju6edT7cJJyxf925GQsNilR1giHup2MyH?=
 =?us-ascii?Q?BfPBzHvENFVQC6WZT0pTnoP3/NhnW6+YA7xDsh5mDVBXZQWKNhEwy+YXTDXH?=
 =?us-ascii?Q?O0eY5ltCnpUxINMAD9dYVGiNGaf6MWeynDycxXoEBwKvvnv2QId1GWQ7xhu0?=
 =?us-ascii?Q?iw/jyLkTpE7ZJoLPSHaMwCDyPwcK5bZQuRSEQd0qkUjy3hll933T8H5HtSuD?=
 =?us-ascii?Q?IRNotUZY8GXfRPTJdJIa6w+wZ4e2FXTqOfDx8zNz4ochM9HXiPZWgr0eAYiw?=
 =?us-ascii?Q?gzwQk0PenyYiKR1V9rS3ZhevbRWqzfa7b5FrpbtaTSXBnsHxojbvNTlT56Ef?=
 =?us-ascii?Q?tfja+fWYe+R+IDT5oCW4Xi5EBSbWtaP2Toh2ihdox4u6GM6VGJ7sjLrTnCnr?=
 =?us-ascii?Q?wvlP4L1dnXJZNusmwCoCYNJJqEbQZlskeCqNUr2kNiQDtyyIDpXvKjavXGce?=
 =?us-ascii?Q?nbtBQwgRylr8CGYani7dQw+4Ggd3XLZG1hwK7seXaApe7ekvB6IipmbL4OEA?=
 =?us-ascii?Q?lrmQ+30Tw0NIw8uw54vAFRzHj6Fl0QTVr76EYfu2bSVW1obN885/arWLSnba?=
 =?us-ascii?Q?tEVp6AfSd3CqgNMKPCZfeylLr3yHUWAIUTauvmMuKhLYSMbHOHlIWRO6PUys?=
 =?us-ascii?Q?c9Px8BqtfcB1yWjgHloaWbz2YUSQo3VnS/PavcBJ9mC/jhkTg1qdbxigwHB1?=
 =?us-ascii?Q?crO92jCbXLJ4PFmvNFChTRfLzxgsZ/XvWv7x7BwKnF1LKCaAmwPAxQqDlYki?=
 =?us-ascii?Q?ulgpXHlKhzB8FZ4Qvj0fba0AKX9h764Ba10rZCfaNTUhPkdDVa7ucmW3NgyR?=
 =?us-ascii?Q?KSxuDkNxi3EeEskGytJPtKF01CUQ2VMD33Lj/RXa00S7OPwRbQSr7uAB50Al?=
 =?us-ascii?Q?q2zqsvAAbyFU80Sv5NiSnrTY4nlVG3ZPSOqTZpFEPKX+0o2aRAP0rCrmeFP0?=
 =?us-ascii?Q?0va6drgMxROmGZeBr2xD4fLzpEloBQXElB6TRQj8Cf/9p1Y0NsV4diP8BDh8?=
 =?us-ascii?Q?AMHuta0IPDrXSvwjjxYG8Pznn0KjT7pqpq6/FWXjgA17Qf1Xyh95?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49315519-c531-4aca-8c59-08df499af370
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 19:49:57.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snN9FDv2Ng96zTx0TiA206r/MU63dDhjp4zbrPjjB1ztkfychR1TZf3Zs8EAoRL82dCETvv944/J4XufvoLZZ6xMsUpT9rg8rbgoshB0nETHuInMaRz5vs96rn+P5bdZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8774

On Thu, Nov 19, 2026 at 12:22:47PM +0800, Junyi Zhao wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i3c/master/Kconfig          |   1 +
>  drivers/i3c/master/svc-i3c-master.c | 301 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 287 insertions(+), 15 deletions(-)
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
> index e700392f0..d73817106 100644
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
> @@ -1997,6 +2026,30 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
>  	.set_speed = svc_i3c_master_set_speed,
>  };
>
> +/**
> + * svc_i3c_master_find_clk - find a clock by name in the clk bulk array
> + * @master: I3C master controller
> + * @id: name of the clock to look up
> + *
> + * Guard against clks[i].id being NULL, which can happen when the
> + * "clock-names" property is missing or shorter than the "clocks" property.
> + *
> + * Return: the index of the clock in the bulk array, or -ENOENT if it is
> + * not present.
> + */
> +static int svc_i3c_master_find_clk(struct svc_i3c_master *master,
> +				   const char *id)
> +{
> +	int i;
> +
> +	for (i = 0; i < master->num_clks; i++) {
> +		if (master->clks[i].id && !strcmp(master->clks[i].id, id))
> +			return i;
> +	}
> +
> +	return -ENOENT;
> +}
> +
>  static int svc_i3c_master_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -2011,6 +2064,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	if (!master->drvdata)
>  		return -EINVAL;
>
> +	master->dev = dev;
>  	master->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(master->regs))
>  		return PTR_ERR(master->regs);
> @@ -2019,27 +2073,39 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	if (master->num_clks < 0)
>  		return dev_err_probe(dev, -EINVAL, "can't get I3C clocks\n");
>
> -	for (i = 0; i < master->num_clks; i++) {
> -		if (!strcmp(master->clks[i].id, "fast_clk"))
> -			break;
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
>  	}
>
> -	if (i == master->num_clks)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "can't get I3C peripheral clock\n");
> +	i = svc_i3c_master_find_clk(master, "fast_clk");
> +	if (i < 0) {
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
> @@ -2163,9 +2229,214 @@ static const struct svc_i3c_drvdata npcm845_drvdata = {
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
> +	init.flags = CLK_IGNORE_UNUSED | CLK_OPS_PARENT_ENABLE;
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
> +	init.flags = CLK_OPS_PARENT_ENABLE;
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
> +	init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_OPS_PARENT_ENABLE;
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
> +	/*
> +	 * Keep the clk bulk state balanced for the following
> +	 * clk_bulk_disable_unprepare() calls (error paths and runtime PM).
> +	 */
> +	ret = clk_prepare_enable(fclk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "can't enable fast_clk\n");
> +
> +	new_clks = devm_kcalloc(dev, master->num_clks + 1, sizeof(*new_clks),
> +				GFP_KERNEL);
> +	if (!new_clks) {
> +		clk_disable_unprepare(fclk);
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(new_clks, master->clks,
> +	       master->num_clks * sizeof(*master->clks));
> +	new_clks[master->num_clks].id = "fast_clk";
> +	new_clks[master->num_clks].clk = fclk;
> +	master->clks = new_clks;
> +	master->num_clks++;
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
> +		 * internal divider chain.  Check the clock count and name:
> +		 * a DT node without clocks or clock-names leaves clks or
> +		 * clks[0].id NULL.
> +		 */
> +		if (master->num_clks != 1 || !master->clks[0].id ||
> +		    strcmp(master->clks[0].id, "pclk"))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid AO input clock\n");
> +
> +		ret = aml_ao_i3c_tail_clocks(master, master->clks[0].clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	i = svc_i3c_master_find_clk(master, "fast_clk");
> +	if (i < 0)
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
