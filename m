Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792593439;
	b=4qZ9FDDenNx+SAnzx/4IRfZXvXqnZrFGCX2TnY/TD3IkvaE0DXILiazKuMT02wRZFLLR
	 GLbwAAgKey/joJ4LC7BWqotVKIbOGRdKJzZHyljVDye8zi8Z1Q9U4GMxcAyLF6zAE1vWS
	 FCn7L3rDsJyrOCP2LG6L1msravfTLOy30CRkL+3K0mvytJ0pZjouAPqAD0MKZdbqgQojK
	 mqEzrQdxxojX4sKDLGv89UlVgbMb4pkKazj/aJrVAghQCImH1+v7C2b4QhkYk7Rmmb2p7
	 mc6WvmgBWmQ0lmVp1oyKGMOA6VjKosAXKKXNWibl+aqMHZk3dtguD5ficdKbLA1FopQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593439;
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
	bh=/zOBCCMcC9+Ss7AsuwDjFtkz7VCjAw/hS+sgCQ3RMwY=;
	b=2VqGc6MQ6OIS2m/M6Vfut53AY5HVNat/4+gjQIxvqhaA205Z51nWD2mTw2pPHcVeMb0U
	 /F9BYFAnBKKeY+oXgScMug6ZbSivNb8AHP8CiP//Tpnu/Qresg0JKcVQGfwyL/k4qSryj
	 bDhoFwr4JBlydzlql9hhnYNIGydidp0xuyYWDEMUEwZymoWwhiQOSiabB1Urc6w6unZjt
	 PXpD1bpYPNZZfUN5lrQ1j56Uikf0OE872sPZKw/qgmwiozQCDGk2QdEU6eiEct9udP6he
	 OA3PioUz3c5048t++hQAZzZ2XtrLHhTPD73aZqdlGwqGBlnuJsFpdiNRQBGeq/IVFfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ucX01732;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.16
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9C606A319;
	Wed, 21 Oct 2026 14:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED9C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ucX01732
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOZOWsqsMYS62hxWa2g5YwWt3gOrMB+7p/XxT540Q8ZGYGSobRrigOSLoS4OcWarynBINPF7Vdidn9fOuxhehh9xFzxMO1RvsUVNQX45nNNcB7Zr/i0+bM1V7mq+AxingWTJDlOdg28DHV6x76YG5byCRJsRQQl2DGjz3SYl6jCgWhXDPuBBXZiV3I0ysGcNeOjtkZN0XzzC1LiEE191J0/aR5y5aUWQqdZw3PWctDzuKiC9V4wg694sx6kbP11cP84SNnxvUsvaKSzUc3R44k7d56Hp755fn1mClXR2bGH5I+TTwmDpjhglzo0iOZeDllCm4CUjfCEa3QdqzBKsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zOBCCMcC9+Ss7AsuwDjFtkz7VCjAw/hS+sgCQ3RMwY=;
 b=m5jhVwzXtevM7bSV+gMpQ3SSKHZ1AtQhkfw+HItp+gmI5S5IWPbmu3jDLrtjfrvpnFoD7bfsPye7GttQUV8NCW4z7BgqkczE4h4WEFsO1+JoRpMmrxbqpD7BlCLTmaaZJ0Tetawy/1vcLhNI9hSfxQVFxcel3hh64AKjT7xnjnCsxr6IA/4Sc3iHGtNDsjBHaVfdxSJ7Fb1dCbIHNH5V+9J3mqQc2c2VJV75cpPgvB2eI80jRliRZFya90UgkqObnoLhWdWbFiQQiKP5zDxmck6hxfq/qm32/AUFQKWUosAnrQMPC+e8sFeeAAn7H3V+1+4BQps7CK6j/V32JJ3IjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zOBCCMcC9+Ss7AsuwDjFtkz7VCjAw/hS+sgCQ3RMwY=;
 b=ucX01732tOwOVCxYuVyeV0CYv22VdmrUOroa+Niuf4fZw271evv+hIaw6C179e6w0DNfzKGYY6KYZd5dwbG3fipx40ZQBHSUTmzBWfr/n5afeglRBd/Ua8i9UXdyVacYhquruS1LI+ie0TvAySCUEO2aDQMDYiDk86GG7kK1QnIMVHNRAKa+RIXvgozj0jhht+MpcEa2Jje+Nf/2lvlUZZMB+gEOVM8XDvUUWeo5tVEBLHdcC80q6bG/+hjy+pwHyHl7hQ4Mz+n3xBRGdnuJen+JID5Y4/KzQqjIKfEYCrqwCOTSrm/+jxWk1Mtu0hqfKbLrFzfPDHo1x3Nfy7PwJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB554873.eurprd04.prod.outlook.com (2603:10a6:800:361::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 14:37:15 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:37:11 +0000
Date: Wed, 21 Oct 2026 10:37:03 -0400
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
Subject: Re: [PATCH 1/3] i3c: master: Rework SVC I3C to support vendor glue
 layers
Message-ID: <atjOD0PwVGDeh2uL@lizhi-Precision-Tower-5810>
References: <20261019-a9_i3c-v1-0-329d819d621f@amlogic.com>
 <20261019-a9_i3c-v1-1-329d819d621f@amlogic.com>
 <atZ-YyEmG-KvUZAF@SMW015318>
 <887f0b2d-3a05-418b-bda5-0b01abbcb409@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887f0b2d-3a05-418b-bda5-0b01abbcb409@amlogic.com>
X-ClientProxiedBy: DS7P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:25c::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB554873:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2be661-942d-411e-7295-08df2f80caa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|6133799003|18002099003|22082099003|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OK5scHxVYjktj1WRuMSTmAjb7hi7fIXj/6fRuR1Np7oPDnIZk5SQy9inA9ByGClZiO+xwAwxGgqAbMC0vteHFau4KnEhtnTJV+W9goCbj7E+RXanri6uj5ki5biYg74tq93RERPXFK1UuU5/EG9D/7qJTALgVD2VrEcrVRzmsK1HDAyDo/I8wVhNIQXfIhWZ0Z7tXBqq8oSJfNvZ9YJWKF9hmubQftZTS+TAO7shEGnevUFi3t2Ze1/WqAF8mxMUcJ7NYqQbbWO4MEAj49CwhusaMIDP9EWwG41XDhmo/AQP7QoKch7kSAhyqTuY4WtTWTKNqbCOIyeF5YoCImcZ6Jzd5uLX5mbSbz6H8Q1IMGKgP5WzbQte2g8rOl5NR+uiT6sdbqATq35JaeyGz+FTRGZtJtG2JOGSi1VVAkiMdCX7Yj9QMXYdYizZ0RjONMsP9xNi5J0JRj0mV0FyezuIStiATZC3OxuhmRv0lE2tbeeuVtGhzGQ0r81bs22rF+eqYgKpZivVTURBSQ3UbkoIObwgT5zKjKEcEWbjJMmcZ8veENSRn/H3Di+cQEHKvk5uGg9vzXWSedZc8ZCNtalXRFoo4dtjDZYxHd8BHE3kgdfrjx4uVJM9DI/iP0uz4iGf1ZRehYb5R2fKdpmmCxvAlKBWEx9YELDlJgs/ASprHSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fH/Nm9VMbmbm3c28hmsWRmiGP9n4j3LGGRwyiDSKkooLNYRdD2t2HwvBWFMz?=
 =?us-ascii?Q?vRfZVXZODkeSxJlHrls+V/ORzUpBnQOgVyJ1IkSZ/RNr7t3iXN+CL7HTwJmK?=
 =?us-ascii?Q?8Cb/WZSADbEJAG+wdK5B20Sl6rX43ITsMXkq6B6ggAqVAwcSeR0jC5IzlNJ4?=
 =?us-ascii?Q?ngxghJruXvIEITL5GOuWGXSll2RdPIBazg+YMUFevwH7KjcCFplCsvBDex+2?=
 =?us-ascii?Q?uSH/vW4egEqN1SJ5vIZ6YBOumfSsBhEhf9UtTFeH8VBKCkXB8x/AfAHos9Sq?=
 =?us-ascii?Q?1kmiv2IIHn+XCueZzbIhuA709K2eK3dDVuKWsePio/j3qjTmesYXvHj5pGT4?=
 =?us-ascii?Q?vVumRw0uF9HH1qoG7l5/22mQXtSvk+s/PyHImeBUKV3OQil0GB19xxxrlpIR?=
 =?us-ascii?Q?qlIlRVYgCL99KExclSalZf2IR4UUSnkbbl1QnWciTQ9IhZwY0199oolPwLtm?=
 =?us-ascii?Q?Q1M4uK6Y3HVSgfujHUs/H0pEpwSox+SecyEygLpbw6oyjtpxcSRh1SlMLJT/?=
 =?us-ascii?Q?Hpxzu0A81W0zLLoUgXEjaO4mL8lwfKFOJO8p1p9vNWAMgr87zpmpUb/KlSi3?=
 =?us-ascii?Q?qnEDSctuIn9bi5PEeFhn9KDgE3eV+5X/VZcINXvL0ijmGqmoWFrqZVs85AIo?=
 =?us-ascii?Q?t5erYDowYx7isWzw5Ae2zVegMTgslKly1DAn3KsFxlg1LM0/nyrmaeE2jZ1c?=
 =?us-ascii?Q?UUVCXfbZBjKsoPM+yNBlhdLnCcvqjh2/yB6BNDIaIsS05AnuQKUF4Hk+b5xI?=
 =?us-ascii?Q?JxB6yTyzJokVzgZHTz1kJaq8chYCHp5KnQV5rih4FL3uw31D4XNJzXFqm9mL?=
 =?us-ascii?Q?X2DAGjnD+Ga8AKvocQxlbwk0czwn1ApOKY980Co1rhX0acl7I+IemU/bvn/2?=
 =?us-ascii?Q?gC6qpyoOcs2BBuXXiNKFLBR6ZcxoiyUiHz0Z5Cz+EcYc6IC8S8WDs4BXtHHL?=
 =?us-ascii?Q?8dYuaWTIMYk25c2OWaeBU9rzQlctY7kCwFc/mH4/La3LSeWiJqjV/uKyne9L?=
 =?us-ascii?Q?XPW5/R1sOz6bYn+CqQ1ialnjJW4fay25cNQXTTQBqFUTSjsw85HyFLtLLF3t?=
 =?us-ascii?Q?Jj4lIHvI3vwOOhmknf6odrcPmSEEAZyzfOz7oOlbIhcDL3WtedqbdN2Odgwh?=
 =?us-ascii?Q?4DWbzlg4nx92v+nrt8FZ0or0JryT/TCDFONRpKmrc1LdFAbkjXH+dFKqaRvN?=
 =?us-ascii?Q?fwsTYs6v9WjxU19clEhtesdvzGpmChoTsQ5SrYY4fZj6EpdP39eFiR6y2xsU?=
 =?us-ascii?Q?GCAIe3kBsInavroBoXBA4sJtNBp0iuSEr9a8bhrai5meDjX0nsNqSt3eIitT?=
 =?us-ascii?Q?T1A8qvLP/r16PYO8QHsnWSTOur7dzXfNOaYvDZzer42UNSfK1ckTmwS5LBvy?=
 =?us-ascii?Q?daLIFYVcH5znESa2MFRXNbU2dmAZuOz3N9FKG3AAfolu3UT1dX1vVY/wEAwx?=
 =?us-ascii?Q?vnxYsBYu9UpwbA4sFhHWmeBIXQETpwoUU2Wrcm0TIDVnHNRd8/jiyrQMnLPu?=
 =?us-ascii?Q?A8o96jTOkkz7ddvY6HX92DM5qfINo9UY1ga/EyCrX1hXADCOVBQKcToeVrBR?=
 =?us-ascii?Q?A9FG8w7fDQEJcvdfjhQii8GSau3sTmASQDLN93Xpc599Eo8IyjXqcFWsZMww?=
 =?us-ascii?Q?DqNVYHGYwqowoWtMVaUSsbYZYvokChFTuXOiQz2snSN2Pn9Mo7CAKqmsCuIh?=
 =?us-ascii?Q?/dwH5q4vkmpFdcYZM/FbZVfpxMBuJyFiLKn86SRskZIp/GkFzF1Ge+9/F+g/?=
 =?us-ascii?Q?5Wfg0Q6+kUi68bja5zh0k90bahYes8W55ibT2m201Wcg/0RHXXRh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2be661-942d-411e-7295-08df2f80caa0
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:37:11.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/2YHTHgzfiwuDgUCGKB7fr6IGIO9ddgF6xE3FmkkIodcXB2BsO0EkJsz+K+w2WpvoBJ2m8pLRB1Of/R48fUKVCLLRWPmgkd3mazjPaLavX3XmyxndBNLCwDxobQAAzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB554873

On Wed, Oct 21, 2026 at 10:56:19AM +0800, Junyi Zhao wrote:
> Hi Frank,
>
> Thanks for looking at this.
>
> Amlogic A9 used the same SVC I3C IP engine, but the integration of it
> differs in the resources *around* the controller, which cannot be
> expressed as another quirks entry:
>
> - On the "ao" instance the bus clock is generated by an internal
>   divider (I3C_AO_FCLK_DIV_CTRL @0x304) programmed directly by the
>   driver; there is no CCF clock to clk_set_rate() on, while the
>   common probe assumes the fclk is a plain enable-able clock.

If it is in I3C memory region, you can do that by use callback. otherwise
should go through clock framework.

>
> - Amlogic added register blocks outside the Silvaco map: a
>   DMA bridge and a bus monitor (0x200..0x22c).

Does DMA bridge only for I3C? It should be go through standard DMA engine.

what bus monitor use for.

>   Enabling the DMA bridge later will need hooks in the common
>   transfer path.

We also need support DMA in future.

>
> Adding A9 support to svc-i3c-master.c directly, would make these
> becomes if-branches in probe()/PM/transfer paths of the shared
> driver, and the next vendor repeats that.

You can use callback function in drvdata.

> With the glue layer,
> i3c-main.c keeps today's logic unchanged: i3c-silvaco.c is the
> current probe code moved as-is (rename with 79% similarity), so
> blame/history is preserved.
>
> If the file move is the main concern, I can keep
> svc-i3c-master.c where it is and only export the alloc/probe/remove/PM/
> interface for glue drivers -- the essential part for me is keeping
> the resource handling out of the common code paths.

Now, there are not much user yet. Rename or re-org only when it becomes
complex enough.

Frank

>
> Also, per Neil's suggestion I'll try modeling the AO divider as a
> CCF clock in v2, which should drop one hook.
>
> Thanks,
> Junyi
>
>
> On 2026/10/20 4:32, Frank Li wrote:
> > [ EXTERNAL EMAIL ]
> >
> > On Mon, Oct 19, 2026 at 01:34:26PM +0800, Junyi Zhao via B4 Relay wrote:
> > > [You don't often get email from devnull+junyi.zhao.amlogic.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > From: Junyi Zhao <junyi.zhao@amlogic.com>
> > >
> > > The SVC I3C controller IP can be integrated into SoCs from different
> > > vendors. Peripheral resources associated with the controller, such as
> > > clocks, may vary between vendor implementations.
> > >
> > > Rework the driver to separate common functionality from
> > > vendor-specific extensions. The common logic is shared across all
> > > implementations, while platform-dependent operations are provided
> > > through vendor-specific hooks.
> > >
> > > Also add a corresponding MAINTAINERS entry for the SILVACO I3C
> > > controller.
> > >
> > > Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> > > ---
> >
> > No big difference. Needn't rework svc-i3c-master.c, you can add amlogic at
> > svc-i3c-master.c directly.
> >
> > Frank
