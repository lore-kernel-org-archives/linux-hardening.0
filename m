Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF15A447819;
	Mon, 17 Aug 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985412; cv=fail; b=MOTd0DrCdyVJKC87q5wfUGTzQ47xpIbGmuXmoWVEajoE8wXctrT5b+5onfQrbaIhuOodASITjpbL5NKrW9ytgok0CZXI9TdNhSOyawdXsRzjftjAiCDJ43ySbRNNZB7/Qx9FmSCsGJEBrKfOmo5Hn/+GRD0mnCmMCOT5cl1bgrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985412; c=relaxed/simple;
	bh=sIkbINLZyAAQ9TFnbuttnr20VZl5Uy203rCZVUjAwks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EZD7rpH5gLCEZEDGoqC53hVjfBNugLkQzlmtb7x+E5HEU+bpbclAUhJk6CNiTMkAqcUhBXltNEK2GRS/W06FAeHPxKkhEt4bErTcfbkucQktazRZ+aNwrI7ELd1rNv3Dmks7jmefeltZtGRBQPKdkB7/X1kiAlbQucAGjM9Agy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N7yWRh0C; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N7yWRh0C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wn68AXRoXs+5Jd4nj2uYeNGIC+Sdf+ZUst4SVQYzOkU2l4LycqkvdMcQ6p++EV2QhItiw0kGm/0RxIWUxdWjKgTQMuok8OMQDF6ceNYFcmFySItQBMKOzBNR2Un8+6x7KZZQwhi3jGFVSvv2PtppVv98n8WUGUqu6986UsU66PSm66KmhFZb1X4OW0Yc8/X8YBW+ZCoM6dOy867h7ytPM0drBVIIzOahCCAXPipxGgy/DUPw3pF+YV0P1RDjqW7aBOxrzgRx2xOY9IpdNkvjz8ccAevSk31TYMmg6LNSyFBEsEsFmCJcfiDmel2Gw1/oYQCzPKOAV507lLQNYICn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP+xReW61x9DVPc1KIECPYpEXVxKO+Il+0rYLR3S5o0=;
 b=ddz52xHk9JcQH86I1JQTuS/YyMAaNmksehZiz7HpXNvEI25iljs/OZ+bRjlbvS41we3LNk38ywbMKmvjRYxEp7DoA2kKexSVBWOBvpfvGTOSjZEQ3Hf18PCBfc80zmVnfDHd813u3X5WSQn4mfZ7k6t0zSdH+d2r15ElaqZwvXgXWq7FxiK2lpe5O/O/06M2hn5Hi/s+7UNRz1OH6zJku2Uy5Q1oIdmvSyDl60zwiUnpZ7YSsAbnPwoonIINCaoyrtbhpMlCuWk/pHtaSV9geJ/PBJbEZdGEABIMT5v5R/Q20Yo4EvBAJeDYJHxGq5YaNAA988haZotVfT/1G6eHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP+xReW61x9DVPc1KIECPYpEXVxKO+Il+0rYLR3S5o0=;
 b=N7yWRh0Cszp7KMtfc0pt/uxYrRaKQxQg50zEwEmC1ft3VxwkPQiugMvYJdSqe0WTc49QG9QE+IfLyuDKC53eFzXLrmRSDYH2M1TVSTpI/TmC1/Yr6NK1DirZTekqCwMKd325AXQsTwp2C0x31t85+omDCGjUJN5YENhXkK+PTJV2uD8xNG3DMagIM0IpMWXjt6LYwtXe7f1+Ag5jUJCMV/Nkt3Dpkk5nff8aV13g35V8TTZ6DHtuDUzc8dq7UVLBac9BYzenNBk0q+SgwUwik62NFDa9PH6KAa4PIvns2MblqnqhjEIyJCXbV1RzbhpCi02W9M4mZ8jodoBORePYDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB9639.eurprd04.prod.outlook.com (2603:10a6:102:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 16:50:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 16:50:07 +0000
Date: Mon, 17 Aug 2026 11:49:56 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pxa: fix double counting of the hw descriptors
Message-ID: <aoM7tGzvc4MtkRHP@SMW015318>
References: <20260817-dmaengine-pxa-v1-1-850c215c1196@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-dmaengine-pxa-v1-1-850c215c1196@pengutronix.de>
X-ClientProxiedBy: PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: eb11b4b5-5868-463b-8622-08defc7f97e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|7416014|376014|10067099003|56012099006|11063799006|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	bQGY7l41pgDgJBzmeUtihCeLzU0LcZUihNQd99E+QXRymIhv4mXYrE2EweY+bbCnNt7z1MI8YMlCrg9wBA7ECAr+ct4j9D9AvYOffj/AZe0doTEwRFdNrIw3HTRCBqZPyEAqivl51JRfKlcF/FvlhKChJ+XpqG2VmWh5bjiOGknmioDqIf9amjAphmw/ldCqHFIBu7GVlTMDFxptRbTZ7mUSO/giTfMUUGCaR6ESLSV8ER1nqfmmKAj0Agkc3O/iEAqIe530QB42xjUhmgBvIpH2j/BtMvR2EgmJ93qRNVx3g1sPgnooPCTZAfXQC5u0rdnciB3bozU9oBzxzCkpH+FbLnKxVn5wBrzKrvrOn+ubBIRhXn1Kg217CN4T+nbtkkESVCy9D/ymQ3TkiKy33LUGo27ORk2q9Fl+f4U/fbCdwA8DDQfqBF3WU3I6euRId2aSPAp6Tv09Ou8F4V0WE1V9mA+8Cm2bgmp612c2cyobsJE1JP55VlsOvhWXFE2UmQ3O5j55s+kVpi5BRM4Szmme37adqLrtwCawxl1h35adbVt9hehFKtqMgQ4+ZzmgmDWUtftDqmLOHD4uUsk4OBkiAdqNiPqgcqcztCz+U9kdav97NeOjr0r+H0LJbTwoXXl1gMHJQZspluauvHPLwZjA6+KTjKHdTz+mx1lzLVyJeh6RPRbYD643YiEp8pe7qDKOnfWQhP8Vr9GjAT/fqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(7416014)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iU0CgkAu/NOaf4EvMxNgjNThFeLCUYjxFl2couEoyuX+EKp7drUDlGtuOb2z?=
 =?us-ascii?Q?IhgojRzPONNynJRFEGqHwHaV/fqHKlJ+ekHUSnPwgex5xkbNowBWgvgVuqYZ?=
 =?us-ascii?Q?3agKOAjSKFjdhHVlkXJ4gLKCPKg76u8IvuVV5JVud4s2PniFl8rbNmryNOS6?=
 =?us-ascii?Q?NiWsNcJyWP3VX6UkeqmciFom3Xud0mXKG8fvm3cUJ1699P3YRmRfnwpM7gJo?=
 =?us-ascii?Q?ovmGOzCVwNHuf0gDVO6Y0M7FBaMaNBvG9aA8rCcDpm5FFS7RuVWnIOARh8wy?=
 =?us-ascii?Q?7+tPBIeyxuOT4jLCvWlBe0Z5dq3D5+wYdMhzQz+abrXlURQP3CaMhqX1Y2Bj?=
 =?us-ascii?Q?Q2tV7TxTnN0p9eJnNslweQGg0AleQITB7PTXZBRJztDNGZPEjJDMaqv4ZjVh?=
 =?us-ascii?Q?NbbJ3eCsnyHnBy4Z/5+6cbZqDcI7X6ohwaSaNdfFY7Uvpt6Icvg6OumWvbPT?=
 =?us-ascii?Q?0A81E2KvDfiuKL1/dM6BWl8tGDglnfjozhbZ/6Z5IFvzfWusmz8CElMNEVMQ?=
 =?us-ascii?Q?P+98IcSWltEQn0rRSlK59Tw/3YkcyRpsKlaHA1eOShyKYmtwITzVDvGpx913?=
 =?us-ascii?Q?m5i78CyQYBt6wwOevI1I4DXhAJ3BESBfaOPGfq41QlGD4EmtNHlQ+6MFJ3C5?=
 =?us-ascii?Q?7BS5vaLNnAY0pDeiGTkX6OPeSZpV0FuT0LmdgLyq0xAyyPcJBfQzvENphPAb?=
 =?us-ascii?Q?rnIWWqce+isaBxjI/3W9vIzgb0kyiB0Wxyym2j/8vHnNOpWB044LxkmJ2yFr?=
 =?us-ascii?Q?SjmqFOR+eKxDV9juxHbCfbxKsQP/Ur6XX2c+Cbdi20jXTz8nM1Eb8tMp3j8b?=
 =?us-ascii?Q?P/YKYOFYzJH+fQTm+3OJyPLLiONt49/y5qKMqZUWoxSmtSwHHYT0Johje2NU?=
 =?us-ascii?Q?vYAgjM1QxujpBuWCtcOrhF+UIXKTseEXwV2r1Y5ngPE9NByM28MLLBN2v57u?=
 =?us-ascii?Q?b7Rlp2nhyREvJIrjDs9xI1u8jB7JV67vtcvgs9e970HxDh7Ed9wQz8GemCPS?=
 =?us-ascii?Q?ZvmaYPQ7DRM6loWvTQXvwG2d487STbsVrIRFtqlQewb/qVBAbXwimPgCu3Yz?=
 =?us-ascii?Q?XzmydQ50oQAFa7cXKuV/wYmDCi2gFM8ewUMPWuEeHxDuXblAmLyzQMdVcoYv?=
 =?us-ascii?Q?wanQaG/w5IR0qgrPvEU2syAdWJP1XaVoiMZTP27JGcOCgF8jITQgas8p4gq0?=
 =?us-ascii?Q?MuCsGPCpAaA2eZIAFjmhSA63NtxgWUPgSizjSaTK0QdwYLX+9+GQvMupswDb?=
 =?us-ascii?Q?UdP9dVMgkwBYiTC8wAhhy5h9ZZgccpqm6wfdxcS32RU3cRKakvGUqqDcjYic?=
 =?us-ascii?Q?nXOyiyGqVqIMhxgHN4iD2ZhQu/7zeDFkZRoU6ieSFurZqo48ja6aP8HgvHFk?=
 =?us-ascii?Q?78D17axH6XClVj3zGZnuEvBs10nzQzsVJC4cs3Nx5mX1y849DXl7qSGviHLo?=
 =?us-ascii?Q?FMn3jj4FrFIdhMWay8evAnT3KToar1jWWqVqe2K82m2Ru+m6vfBRgOjuy5c9?=
 =?us-ascii?Q?2DS6ZmjO5uzF/08z6pWU27aHHJsnm9VyTxTbhQV7BR2mNt/UCMl/K1NT1RwT?=
 =?us-ascii?Q?HJbgDGm27ldJkD7kc4ed5KRqGh3mdpPqM6Y1NZ//YHT35YP7I8c6o9PI9kP/?=
 =?us-ascii?Q?zwh0u8iPhhRrHI7AABT8op6OlalVBlBr+tQWkJV2Mhvmxeg5aEA3tbdqf/Yb?=
 =?us-ascii?Q?PQO7eiHmOmFx9vG5eiN+aNqN5xhNInNGe1wnX6fg3Lxh5xHF2B2mwif9fgeX?=
 =?us-ascii?Q?UjM4Ghyv8HvqlXQjSrOsewkZFXDdM9TnYR9CV8GQ0W746vDsxPIj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb11b4b5-5868-463b-8622-08defc7f97e8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 16:50:07.4847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4dy2uID8stZWiOTE9+94Q8keiphpelUz1lm255/USq6sRflMJi635UPo/dypJ0/go1ssl7HiCqPuMKS7zlVGyc3fLOKmLa87fskltHAvM66uCDp0P0r4fnOHIOkYUzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9639

On Mon, Aug 17, 2026 at 06:09:23PM +0200, Sascha Hauer wrote:
> pxad_alloc_desc() was converted from
>
> 	kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc), GFP_NOWAIT)
>
> to kzalloc_flex(). hw_desc[] is annotated with __counted_by(nb_desc), so
> __alloc_flex() now initializes sw_desc->nb_desc to nb_hw_desc itself.
> The loop below it still increments nb_desc for every descriptor it
> allocates though, so nb_desc ends up being twice the number of
> descriptors that are actually there.
>
> Drop the now redundant increment. The error path has to set nb_desc to
> the number of descriptors allocated so far, otherwise pxad_free_desc()
> would free entries that were never allocated.
>
> Fixes: 69050f8d6d075 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> pxad_alloc_desc() was converted from
>
>         kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc), GFP_NOWAIT)
>
> to kzalloc_flex(). hw_desc[] is annotated with __counted_by(nb_desc), so
> __alloc_flex() now initializes sw_desc->nb_desc to nb_hw_desc itself.
> The loop below it still increments nb_desc for every descriptor it
> allocates though, so nb_desc ends up being twice the number of
> descriptors that are actually there.
>
> Drop the now redundant increment. The error path has to set nb_desc to
> the number of descriptors allocated so far, otherwise pxad_free_desc()
> would free entries that were never allocated.
> ---
>  drivers/dma/pxa_dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index fa2ee0b3e09f8..8252d27be8c3c 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -752,10 +752,11 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
>  			dev_err(&chan->vc.chan.dev->device,
>  				"%s(): Couldn't allocate the %dth hw_desc from dma_pool %p\n",
>  				__func__, i, sw_desc->desc_pool);
> +			/* Only the descriptors below i have been allocated */
> +			sw_desc->nb_desc = i;
>  			goto err;
>  		}
>
> -		sw_desc->nb_desc++;
>  		sw_desc->hw_desc[i] = desc;
>
>  		if (i == 0)
>
> ---
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> change-id: 20260817-dmaengine-pxa-64152bb34313
>
> Best regards,
> --
> Sascha Hauer <s.hauer@pengutronix.de>
>
