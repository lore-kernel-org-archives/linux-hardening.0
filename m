Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794863676;
	b=aQsLtFAv/2IOpZR7yYeRv00+e/AsuNf8tWsbhEeXBvtHTqUtu7iI9QYuGMReMtwMX0Q7
	 hKEkbgvdqN597hcgFl1mXXUjYaaDpbfaYw5zC1iiaSGHqfPEqCRy2G2JHxmMV+EMQbLBZ
	 pzfdiRfz8XEd3iEGTjVW/fJOLbEvTmSu2kZt+B34B5kJ6w0S16qf4TvHk/DEKf/rwtOrz
	 RgSYgpI/5ob4K04Zn2zIs98zkjmyPwKZbS9l8d0RVAX2eNuYy4O/2z6bmnRVyYw/oq39r
	 yjikKheITprk8BfIo+DXe/sQqN5GXO04f/ONP9EQM1UIv1k3xiMkNMM0vBcgd2vLhiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794863676;
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
	bh=lSszd0nYRFZOgKb7t5YDnIAB9n7g67/DxqvGBvTv9zI=;
	b=Fh2XmzNnZO1iWHu6Bzvl7RCRw70b0Hx8eBSBf0tgJBG97LsdNd1cRjxhX0Bo3w3bnFaJ
	 Ugz0htpiNilzPQ7w1Z68fx8fkpqzmtTRN35C9BS+vYfa+6hv/Dd3b+WfFYoMa1eXj9Opu
	 lKYzhbCljP3y0XakAKZynynp5/XZLrpKS0QJZRanQTu3rW/MpEYd6PwKR4efcI+vdlgfF
	 1gHmCPyQvS/bRn0e53Up8R+Mq5qoWDX6JotqsrLSUxWBmMLkMZmnObyhpa7jHvlfF3uOP
	 E7r7E1OL3+V0vVFpGCKJy9z86fZGsZu15R9qXj3YX0zLt0JqoO5v7cL4mVRMMmJr4Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BbupSrli;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.23
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C767606A322;
	Mon, 16 Nov 2026 21:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C767606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BbupSrli
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbzaTM2g3vFNIQ1Gf44YwnYRxmu8g6+gxeFQEMWOhd109QMrRIj8icQyrp1dzzKdZqCD0agqPSghJgbP4LoiF0n/t0uWL95v1LEav6rCQkQqzY34pD4ZD80sKV2gEz+/14BThFlvOdLI9Id0TkuEXuo7qxCq0Zey1hZtn2Fin3iW2hBGRowuTm2VkpH7/TA7HYIALy8aMI0z2x120VO8BsxQ9hPfgmaj7Z52kcWX+FPli8WYhNCVtMgRUL+LCHQpg+dKKXuTnWY7SKDj/+o/AKBOes5szXfT5iuWVIH+tKvqz46B2JAdtILxDVo6hH2GTzWqAdCKdm1D1Nsqh03gEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSszd0nYRFZOgKb7t5YDnIAB9n7g67/DxqvGBvTv9zI=;
 b=p5HNLjY+fS8tNHiasYRSSpMs0kFYiwOzTZ8s4xlVU4JF6fMXMSH31CYmVFeVsy3uXNzlN8YG0vt8ioZNEx5g08qin6GeQu0WQq+69/AeSdsHHRUy55IEi4porqt5gIKagbvLZ5BRxDbPZStY8DudG0NgN3q++1MQHoWp//UBBciGEH4+doY48oxcBsXTYs8NOOYfk6I9V4glGDAOJ6bnU9ml12W18uqPQ6jUvXt9jmYBgzZ5C8hd89fskIM0VYKe18kMV03HHvfFo9zN7/sIRTjS8SYmZsZwkG/vG6rxhKWDdE82T+FjzfU0Gta1pFjE65ULfPqGLDl9H3C1wUMPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSszd0nYRFZOgKb7t5YDnIAB9n7g67/DxqvGBvTv9zI=;
 b=BbupSrliTm1hUBRj0ZD5jLpCwbGE9qqtwArdckToKUTYnyUheGRgDtD0azzJWBlHRB1HN84YKLllLj0gHqYcvVlVKALIBW7ek2B32GVxpd+oU7Tpur5Wz5VkoodpudJBziHdIyGBjso+B1MFDx9DZWLOxk2akTbyo9lufp8iDAeiTn8opoI+fR+ISBys1nvSNmsWWdhCMWASSVaGMRauRabKMftA3QYP8OU/5iwOoFy4ORkqv+4k50BC+jQfYq705LEQmRB19NEoCaloI+XwQ56Ifp522cTsqN/7NOkHQsVKQm8u/2aXzM2BtZ0KTfJqEYOd0sEQFgX7h06xfxjlzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BR2PPFA055FEBBE.eurprd04.prod.outlook.com (2603:10a6:2d0::cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 21:14:32 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 21:14:32 +0000
Date: Mon, 16 Nov 2026 15:14:20 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org,
	Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
Message-ID: <avtyLPRZB3uC5G_A@SMW015318>
References: <20261109052900.2960473-1-shanchun1218@gmail.com>
 <20261109052900.2960473-3-shanchun1218@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109052900.2960473-3-shanchun1218@gmail.com>
X-ClientProxiedBy: PH7P220CA0123.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::26) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BR2PPFA055FEBBE:EE_
X-MS-Office365-Filtering-Correlation-Id: b6df796e-8538-4a1f-8d3f-08df44269b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|10067099003|4143699003|11063799006|56012099006|261026135527099003|261026130827099003|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261021135927099003|261021130227099003|261021133027099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	k/VC64rHOoZM2oYTalg2NL+GVVzYTPgGorE8Kuc8+BfVffZ4M2+MF/pBXYY9h8Xxjirpq8/mA9w75FNriixDiEkWwe1nbHZ0xVQOVOI72EKlgR+cBkw2UAfZJWdeTsQz2sK3e/12d39O7fs3iX/Vezp247KUn7tYurF6KRVZ5OmHTCMbjIfHmOoJyx0izdV1K8siCwFWGYZr7T9CJnsatdn/G0KEKtplnHFzrDpVWb3Bo5FuoEvlc0XQf0cVQXCly2pQesOIK2xdnyNytWmT9OxOcCKP8hB2c9dxER6kSgysfrCOSEuXodkuJBbI+NMGhJqNqhds3t/ma1AQjl8VV8SdI0skK6e4PCAadjJbKZm2LPQfqvNyvlEZ5ZIAUSxdQqQDPMUmdryxlS/s1u3KZuA3erZWm4jhNsQDJF4uTwvXch/GPRkkzW54bt/hHYdWgqx3TivgnEVee7nB9ro1IVZMjjGtnUANWMj9xtMoyCyjjyxMxLRzvjgwLMiwvQb07wrQCBMooU6YfLubwEWRTZWHoDirxh4eAyVQlz8AJc1U69qdZy29j1J4aG7MBFYNxSHnUKKhm2Erbykok2XsOk8lBEnPerW/bdBeww2GyceQr2euHyDMgtPCXyQtaE/F2HgK+1g1VHkmnn62sQ2VJN4SJCHEWpNASC/YwBWH6ls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(10067099003)(4143699003)(11063799006)(56012099006)(261026135527099003)(261026130827099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261021135927099003)(261021130227099003)(261021133027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jl6yvsazcI9zIeG12513MGRP9vlO/UVMCZ+p9EhH3EuULiHFr18jt13LIyaB?=
 =?us-ascii?Q?EOfep7L3NrcxIp0Dd7b5rKwxw8ZC+IXRM6prjVbn1CtIYYuYdTMRmKe8/LAO?=
 =?us-ascii?Q?ozVTGRpdfjAQREpqGWsRrFX50u1muJlIqfc9/4cbUm8HKUTK3epN76rUFrFK?=
 =?us-ascii?Q?QEc8TP4lzYOvPTDzs7ftM6kHa4YPH5cZbkV9Ojd5gqMu4q0QdtU5RMMQ7zsj?=
 =?us-ascii?Q?AOGp8A8LIY9Wtpxrpe0GN1QaWr0ERa0g0Uedib0wFCTjRp6Od16xZbkHHlIo?=
 =?us-ascii?Q?3a1mWWNgNGHDnJ7RDJFBaAXAt/CzUVmMDbted6vLwl6YK4oDJbGeunmXzZkn?=
 =?us-ascii?Q?8yaCJAh6dKRS8xec+2rm8fTITadh5PwCzqCjY6B24J4D07gn9A4ld8pgRWos?=
 =?us-ascii?Q?mmIeZb5cP0wYKQOD3D6GhauWD1FqDq4GyhRzDiiKFXZkl6HkWa9ZvOME7KOJ?=
 =?us-ascii?Q?z3DEjkdQRwca381vwYwkSbAhLzPa/0XL20xgtWhDfUq0WhsTxRJa6FEdG5gt?=
 =?us-ascii?Q?0w3jGVRAqpMqOGXfbNKTAaGuTDZi3IAhQZpwegSxlor2E8l8L580FHJ0OUI3?=
 =?us-ascii?Q?Op2o0QgvGD2OgzOWdz0u6myhcLD8vRbDCY0s7uKR18lH62Yqo5MG3EkMmDbr?=
 =?us-ascii?Q?0UApoOYVKbYbJyuwxvGgw/K6+q7Is5CuZpA1RZ39kSNg0Hk3gKUGWtNQZS/m?=
 =?us-ascii?Q?IFANV/xLCeWEa1TMx7MaHASQ8A3sOs2rFquaIW4wGaCyyhIj2StocKLXlMEV?=
 =?us-ascii?Q?3T/o6n2ojxS7Wo5fR/9brTiOAqegM+kH9nymvXuAEUSW62RmIHWaIZAMEoof?=
 =?us-ascii?Q?+3QTyAaDQAxhbwEOTewbw9VBxnP7o0446jgEsBNeqW5HFLv5IcrD8Tt7KnVx?=
 =?us-ascii?Q?mXvxoBZ8Vtg/uzU2nbxsMg9QnWgc+LZ44m3Kx9bu3LhwNnSxA2h+lRewlZoS?=
 =?us-ascii?Q?pIael54eqp8gU8IOCeAqnUDlEY4Vz3ZwlLyvltp+ll2SdQQHRtib+DQscwEb?=
 =?us-ascii?Q?UTTV7NrKLnzsrIo2jPptCXCj+uHEHOm7VOVen3jnXQCEpxUhbCVHXrr5ub5Z?=
 =?us-ascii?Q?uSuj5qODlRcxcNV/7eXzsxLF0JKmWllGJ3pzmYCUUG9zCtqbvCNQAQIBUBM1?=
 =?us-ascii?Q?rgKXDkd1x/p7188SV0soK8KRnlouF0I8qPjbKIXY8Zy/BZbXwqDndYiWPnDt?=
 =?us-ascii?Q?vFYDTqmR86HgFZsAM2yffHMdAkUpWEfyN7Xr8tIbDZmPr3HOUzSRBXbObBqU?=
 =?us-ascii?Q?cRF5WkMUhuZZtSfYS5yC5L/lVlFn5uTr1xewXe3twa+pisB9HgDwHRqZo9pj?=
 =?us-ascii?Q?FvGBkl+kUHSDLwmHEsKot/BRl0ja/bYM30hAjHQgAMgTsTO/KBPcZXlo9cNx?=
 =?us-ascii?Q?/yxrSwKPzAc0qSGFms8ijSaNId/KKTskk+yGKnaMLPO0LzqhXcCYJ0HmKfzD?=
 =?us-ascii?Q?W4DzDZ9/+WgxncMeEXhGdaz9ZMQq1NGcpwgGCks9xqsZgNnLm1KFFR/gdjgH?=
 =?us-ascii?Q?pDpxIL3rASKyU3cAUh7rncTf+tlztRTLwPSGfqB0sBwjpF1oef43e+w8+j0E?=
 =?us-ascii?Q?j/vKai3gBdqJOmbXqSqA9znBKSfBXFRCgia/Al+TjJeWU4b6g//W4hvv3Gvg?=
 =?us-ascii?Q?GzVTYZnGFmQ28XQLL55T+DIU/cJCpTkDsEdWRciBu2b3uN4QuqSlQAswulV5?=
 =?us-ascii?Q?18zQWr7eJwt3ZqtkXCiIE4s24tkoAX5IxZ9fyT7fix2HNogGqQVfYbU7P4f+?=
 =?us-ascii?Q?hJqAOY5bBKIquJGTgO7A0Cfw/fys0JM06UUFKr4eL96SwsVhu78y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6df796e-8538-4a1f-8d3f-08df44269b7d
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 21:14:31.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd47N0ucrp6wGP8jODtdWV+6FcfGFlff5nV2EG2S6f8T5/TrPhTZ0m2J30MRiE69vUAdBwG+y7RWoX/vHZzhk/k8vuB47lnGD/aqoE+SW+whD0ibhDjvI3Ul8ZnLvDBg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PPFA055FEBBE

On Mon, Nov 09, 2026 at 01:29:00PM +0800, Shan-Chun Hung wrote:
> Add a driver for the PDMA controller found in the Nuvoton MA35D1 SoC.
> It supports up to 10 channels with memory-to-memory, slave scatter-gather
> and cyclic transfers.
>
> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
> ---
...
> +
> +static struct ma35d1_desc *ma35d1_desc_alloc(struct ma35d1_chan *ch, u32 sg_len)
> +{
> +	struct ma35d1_desc *d;
> +
> +	d = kzalloc(struct_size(d, sg, sg_len), GFP_ATOMIC);
> +	if (!d)
> +		return NULL;

Generally, we use dma_alloc_coherence() or dma pool for desc. There are
extra complex if use kzalloc and dma_map_single(), which will cause second
bounce buffer at swiotlb.

> +
> +	d->sg_len = sg_len;
> +	d->dma_len = sizeof(*d->sg) * sg_len;
> +	d->dma_addr = dma_map_single(ch->dev, d->sg, d->dma_len, DMA_TO_DEVICE);
> +	if (dma_mapping_error(ch->dev, d->dma_addr)) {
> +		dev_err(ch->dev, "dma mapping error for channel\n");
> +		kfree(d);
> +		return NULL;
> +	}
> +
> +	return d;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +ma35d1_desc_submit(struct ma35d1_chan *ch, struct ma35d1_desc *d, bool cyclic,
> +		   unsigned long tx_flags)
> +{
> +	dma_sync_single_for_device(ch->dev, d->dma_addr, d->dma_len, DMA_TO_DEVICE);
> +	d->cyclic = cyclic;
> +	d->ch = ch;
> +
> +	return vchan_tx_prep(&ch->vc, &d->vd, tx_flags);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +ma35d1_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
> +		       size_t len, unsigned long tx_flags)
> +{
> +	int i;
> +	size_t tlen, max_chunk;
> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
> +	struct ma35d1_desc *d;
> +	u32 sg_len, width = 1;
> +
> +	if (ch->request != 0) {
> +		dev_err(ch->dev, "%s: channel is bound to a peripheral request\n", __func__);
> +		return NULL;
> +	}
> +
> +	if (!len) {
> +		dev_err(ch->dev, "invalid memcpy length\n");
> +		return NULL;
> +	}
> +
> +	if (IS_ALIGNED(src, 4) && IS_ALIGNED(dst, 4) && IS_ALIGNED(len, 4))
> +		width = 4;

where are field copy_align, you check it here.

> +
> +	max_chunk = (size_t)PDMA_MAX_CHAN_BEATS * width;
> +
> +	sg_len = DIV_ROUND_UP_ULL(len, max_chunk);
> +	d = ma35d1_desc_alloc(ch, sg_len);
> +	if (!d)
> +		return NULL;
> +
> +	for (i = 0; i < sg_len; i++) {
> +		tlen = min_t(size_t, len, max_chunk);
> +		d->sg[i].src = src;
> +		d->sg[i].dst = dst;
> +		d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(tlen / width) | PDMA_TBINTDIS |
> +				PDMA_OP_SCATTER;
> +		d->sg[i].next = d->dma_addr + PDMA_CH_OFFSET(i + 1);
> +		src += tlen;
> +		dst += tlen;
> +		len -= tlen;
> +	}
> +	d->sg[sg_len - 1].ctl &= ~(PDMA_OP_MSK | PDMA_TBINTDIS);
> +	d->sg[sg_len - 1].ctl |= PDMA_OP_BASIC;
> +
> +	return ma35d1_desc_submit(ch, d, false, tx_flags);

Prep() don't submit request, dmaengine_submit() do it, move it submit()
call back.

> +}
> +
> +static struct dma_async_tx_descriptor *
> +ma35d1_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +		     u32 sg_len, enum dma_transfer_direction dir,
> +		     unsigned long tx_flags, void *context)
> +{
> +	int i, width;
> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
> +	struct ma35d1_desc *d;
> +	struct scatterlist *sgent;
> +
> +	width = ma35d1_slave_width(ch, dir);
> +	if (width < 0)
> +		return NULL;
> +
> +	if (!sg_len) {
> +		dev_err(ch->dev, "SG entry length is zero\n");
> +		return NULL;
> +	}
> +
> +	for_each_sg(sgl, sgent, sg_len, i) {
> +		unsigned int len = sg_dma_len(sgent);
> +
> +		if (!len || len % width || len / width > PDMA_MAX_CHAN_BEATS) {
> +			dev_err(ch->dev, "invalid SG segment length %u\n", len);
> +			return NULL;
> +		}
> +
> +		if (!IS_ALIGNED(sg_dma_address(sgent), width)) {
> +			dev_err(ch->dev, "SG address not aligned to DMA width\n");
> +			return NULL;
> +		}
> +	}
> +
> +	d = ma35d1_desc_alloc(ch, sg_len);
> +	if (!d)
> +		return NULL;
> +
> +	for_each_sg(sgl, sgent, sg_len, i) {
> +		if (dir == DMA_MEM_TO_DEV) {
> +			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_DAFIX;
> +			d->sg[i].src = sg_dma_address(sgent);
> +			d->sg[i].dst = ch->cfg.dst_addr;
> +		} else {
> +			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_SAFIX;
> +			d->sg[i].src = ch->cfg.src_addr;
> +			d->sg[i].dst = sg_dma_address(sgent);
> +		}
> +		d->sg[i].ctl |= PDMA_TXCNT(sg_dma_len(sgent) / width) | PDMA_TBINTDIS |
> +				PDMA_TXTYPE | PDMA_OP_SCATTER;
> +		d->sg[i].next = d->dma_addr + PDMA_CH_OFFSET(i + 1);
> +	}
> +
> +	d->sg[sg_len - 1].ctl &= ~(PDMA_OP_MSK | PDMA_TBINTDIS);
> +	d->sg[sg_len - 1].ctl |= PDMA_OP_BASIC;
> +
> +	return ma35d1_desc_submit(ch, d, false, tx_flags);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +ma35d1_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
> +		       size_t period_len, enum dma_transfer_direction dir,
> +		       unsigned long flags)
> +{
> +	int i, sg_len, width;
> +	size_t offset = 0;
> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
> +	struct ma35d1_desc *d;
> +
> +	width = ma35d1_slave_width(ch, dir);
> +	if (width < 0)
> +		return NULL;
> +
> +	if (!buf_len || !period_len || period_len / width > PDMA_MAX_CHAN_BEATS) {
> +		dev_err(ch->dev, "Invalid buffer/period length\n");
> +		return NULL;
> +	}
> +
> +	if (buf_len % period_len) {
> +		dev_err(ch->dev, "Buffer length not multiple of period length\n");
> +		return NULL;
> +	}
> +
> +	if (period_len % width) {
> +		dev_err(ch->dev, "Period length must be a multiple of DMA width\n");
> +		return NULL;
> +	}
> +
> +	if (!IS_ALIGNED(dma_addr, width)) {
> +		dev_err(ch->dev, "Buffer address not aligned to DMA width\n");
> +		return NULL;
> +	}
> +
> +	sg_len = buf_len / period_len;
> +	d = ma35d1_desc_alloc(ch, sg_len);
> +	if (!d)
> +		return NULL;
> +
> +	/* Split the buffer into period size chunks. */
> +	for (offset = 0, i = 0; offset < buf_len; offset += period_len, i++) {
> +		if (dir == DMA_MEM_TO_DEV) {
> +			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(period_len / width) |
> +					PDMA_DAFIX;
> +			d->sg[i].src = dma_addr + offset;
> +			d->sg[i].dst = ch->cfg.dst_addr;
> +		} else {
> +			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(period_len / width) |
> +					PDMA_SAFIX;
> +			d->sg[i].src = ch->cfg.src_addr;
> +			d->sg[i].dst = dma_addr + offset;
> +		}
> +		d->sg[i].ctl |= PDMA_TXTYPE | PDMA_OP_SCATTER;
> +		d->sg[i].next = d->dma_addr + PDMA_CH_OFFSET(i + 1);
> +	}
> +	d->sg[sg_len - 1].next = d->dma_addr;
> +
> +	return ma35d1_desc_submit(ch, d, true, flags);
> +}
> +
> +static struct dma_chan *ma35d1_of_xlate(struct of_phandle_args *dma_spec, struct of_dma *of)
> +{
> +	struct ma35d1_pdmadev *pdmadev = of->of_dma_data;
> +	struct dma_chan *chan;
> +	unsigned int chan_id, reqsel;
> +
> +	if (dma_spec->args_count != 2)
> +		return NULL;
> +
> +	chan_id = dma_spec->args[0];
> +	reqsel = dma_spec->args[1];
> +	if (chan_id >= PDMA_MAX_CHANS || reqsel > GENMASK(7, 0))
> +		return NULL;
> +
> +	chan = dma_get_slave_channel(&pdmadev->channels[chan_id].vc.chan);
> +	if (chan)
> +		pdmadev->channels[chan_id].request = reqsel;
> +
> +	return chan;
> +}
> +
> +static void ma35d1_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
> +
> +	ma35d1_terminate_all(chan);
> +	vchan_free_chan_resources(&ch->vc);
> +	ch->request = 0;
> +	memset(&ch->cfg, 0, sizeof(ch->cfg));
> +}
> +
> +static void ma35d1_pdma_start(struct ma35d1_chan *ch)
> +{
> +	struct ma35d1_desc *d = ch->desc;
> +
> +	if (d->sg_len == 1 && !d->cyclic) {
> +		writel(d->sg[0].src, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_SA);
> +		writel(d->sg[0].dst, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_DA);
> +		writel(d->sg[0].ctl, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL);
> +	} else {
> +		writel(d->dma_addr, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_NEXT);
> +		ma35d1_pdma_reg_clear(ch, PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL, PDMA_OP_MSK);
> +		ma35d1_pdma_reg_set(ch, PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL, PDMA_OP_SCATTER);
> +	}
> +
> +	/* Memory-to-memory has no peripheral request, so trigger it by software. */
> +	if (ch->request == 0)
> +		writel(BIT(ch->id), ch->base + PDMA_SWREQ);
> +}
> +
> +static void ma35d1_pdma_start_desc(struct dma_chan *chan)
> +{
> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
> +	struct virt_dma_desc *vd;
> +
> +	vd = vchan_next_desc(&ch->vc);
> +	if (!vd) {
> +		ch->desc = NULL;
> +		return;
> +	}
> +
> +	list_del(&vd->node);
> +	ch->desc = to_ma35d1_pdma_desc(vd);
> +	ma35d1_pdma_setup_channel(ch);
> +	ma35d1_pdma_start(ch);
> +}
> +
> +static void ma35d1_issue_pending(struct dma_chan *chan)
> +{
> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ch->vc.lock, flags);
> +
> +	if (vchan_issue_pending(&ch->vc) && !ch->desc)
> +		ma35d1_pdma_start_desc(chan);
> +
> +	spin_unlock_irqrestore(&ch->vc.lock, flags);
> +}
> +
> +static void ma35d1_pdma_complete(struct ma35d1_chan *ch)
> +{
> +	if (!ch->desc)
> +		return;
> +
> +	vchan_cookie_complete(&ch->desc->vd);
> +	ma35d1_pdma_start_desc(&ch->vc.chan);
> +}
> +
> +static irqreturn_t ma35d1_pdma_interrupt(int irq, void *devid)
> +{
> +	int i;
> +	bool handled = false;
> +	struct ma35d1_pdmadev *pdmadev = devid;
> +	struct ma35d1_chan *ch;
> +
> +	for (i = 0; i < PDMA_MAX_CHANS; i++) {
> +		unsigned long flags;
> +		bool done, abort;
> +
> +		ch = &pdmadev->channels[i];
> +
> +		spin_lock_irqsave(&ch->vc.lock, flags);
> +
> +		done = readl(ch->base + PDMA_TDSTS) & BIT(i);
> +		abort = readl(ch->base + PDMA_ABTSTS) & BIT(i);
> +
> +		if (done || abort) {
> +			handled = true;
> +
> +			/* Ack both flags first so a new descriptor is not completed twice. */
> +			writel(BIT(i), ch->base + PDMA_TDSTS);
> +			writel(BIT(i), ch->base + PDMA_ABTSTS);


done = readl(ch->base + PDMA_TDSTS);
abort = readl(ch->base + PDMA_ABTSTS);
writel(done, ch->base + PDMA_TDSTS);
writel(abort, ch->base + PDMA_ABTSTS);

for_each_bit(done | abort) {
	...
}

> +
> +			if (ch->desc) {
> +				if (abort) {
> +					ch->desc->vd.tx_result.result = DMA_TRANS_ABORTED;
> +					ma35d1_pdma_complete(ch);
> +				} else if (ch->desc->cyclic) {
> +					vchan_cyclic_callback(&ch->desc->vd);
> +				} else {
> +					ma35d1_pdma_complete(ch);
> +				}
> +			}
> +		}
> +
> +		spin_unlock_irqrestore(&ch->vc.lock, flags);
> +	}
> +
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int ma35d1_pdma_probe(struct platform_device *pdev)
> +{
> +	int i, ret;
> +	struct clk *pdma_clk;
> +	struct reset_control *rst;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct ma35d1_chan *ch;
> +	struct ma35d1_pdmadev *pdmadev;
> +	void __iomem *reg_base;
> +
> +	pdma_clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(pdma_clk))
> +		return dev_err_probe(dev, PTR_ERR(pdma_clk), "Failed to get clk\n");
> +
> +	rst = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
> +
> +	pdmadev = devm_kzalloc(dev, sizeof(*pdmadev), GFP_KERNEL);
> +	if (!pdmadev)
> +		return -ENOMEM;
> +
> +	pdmadev->irq = platform_get_irq(pdev, 0);
> +	if (pdmadev->irq < 0)
> +		return pdmadev->irq;
> +
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg_base))
> +		return dev_err_probe(dev, PTR_ERR(reg_base),
> +				     "Failed to map pdma global registers\n");
> +
> +	dma_cap_zero(pdmadev->ddev.cap_mask);
> +	dma_cap_set(DMA_SLAVE, pdmadev->ddev.cap_mask);
> +	dma_cap_set(DMA_PRIVATE, pdmadev->ddev.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, pdmadev->ddev.cap_mask);
> +	dma_cap_set(DMA_CYCLIC, pdmadev->ddev.cap_mask);
> +
> +	pdmadev->ddev.dev = dev;
> +	pdmadev->ddev.src_addr_widths = PDMA_SLAVE_BUSWIDTHS;
> +	pdmadev->ddev.dst_addr_widths = PDMA_SLAVE_BUSWIDTHS;
> +	pdmadev->ddev.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_MEM);
> +	pdmadev->ddev.device_prep_dma_memcpy = ma35d1_prep_dma_memcpy;
> +	pdmadev->ddev.device_prep_slave_sg = ma35d1_prep_slave_sg;
> +	pdmadev->ddev.device_prep_dma_cyclic = ma35d1_prep_dma_cyclic;
> +	pdmadev->ddev.device_free_chan_resources = ma35d1_free_chan_resources;
> +	pdmadev->ddev.device_issue_pending = ma35d1_issue_pending;
> +	pdmadev->ddev.device_tx_status = dma_cookie_status;
> +	pdmadev->ddev.device_config = ma35d1_slave_config;
> +	pdmadev->ddev.device_terminate_all = ma35d1_terminate_all;
> +	pdmadev->ddev.device_synchronize = ma35d1_synchronize;
> +
> +	spin_lock_init(&pdmadev->lock);
> +	INIT_LIST_HEAD(&pdmadev->ddev.channels);
> +	for (i = 0; i < PDMA_MAX_CHANS; i++) {
> +		ch = &pdmadev->channels[i];
> +		ch->dev = dev;
> +		ch->pdmadev = pdmadev;
> +		ch->id = i;
> +		ch->base = reg_base;
> +		ch->vc.desc_free = ma35d1_pdma_desc_free;
> +		vchan_init(&ch->vc, &pdmadev->ddev);
> +	}
> +
> +	ret = devm_request_irq(dev, pdmadev->irq, ma35d1_pdma_interrupt, 0, pdev->name, pdmadev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request IRQ\n");

Move irq request after register device()

> +
> +	platform_set_drvdata(pdev, pdmadev);
> +
> +	ret = dma_async_device_register(&pdmadev->ddev);

dmaenginem_async_device_register();

> +	if (ret)
> +		return ret;
> +
> +	ret = of_dma_controller_register(node, ma35d1_of_xlate, pdmadev);

devm_of_dma_controller_register();

Frank

> +	if (ret) {
> +		dma_async_device_unregister(&pdmadev->ddev);
> +		for (i = 0; i < PDMA_MAX_CHANS; i++)
> +			tasklet_kill(&pdmadev->channels[i].vc.task);
> +		return dev_err_probe(dev, ret, "of_dma_controller_register failed\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void ma35d1_pdma_remove(struct platform_device *pdev)
> +{
> +	struct ma35d1_pdmadev *pdmadev = platform_get_drvdata(pdev);
> +	void __iomem *base = pdmadev->channels[0].base;
> +	int i;
> +
> +	/* Stop new requests before the hardware is quiesced. */
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&pdmadev->ddev);
> +
> +	writel(0, base + PDMA_CHCTL);
> +	writel(0, base + PDMA_INTEN);
> +	synchronize_irq(pdmadev->irq);
> +
> +	for (i = 0; i < PDMA_MAX_CHANS; i++)
> +		tasklet_kill(&pdmadev->channels[i].vc.task);
> +}
> +
> +static const struct of_device_id ma35d1_pdma_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-pdma" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_pdma_match);
> +
> +static struct platform_driver ma35d1_pdma_driver = {
> +	.probe = ma35d1_pdma_probe,
> +	.remove = ma35d1_pdma_remove,
> +	.driver = {
> +		.name = "ma35d1-pdma",
> +		.of_match_table = ma35d1_pdma_match,
> +	},
> +};
> +module_platform_driver(ma35d1_pdma_driver);
> +
> +MODULE_DESCRIPTION("PDMA controller driver for Nuvoton MA35D1");
> +MODULE_AUTHOR("Shan-Chun Hung <shanchun1218@gmail.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>
