Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7A2D8796;
	Mon, 17 Aug 2026 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002433; cv=fail; b=okCg0IEbzlRvbBC+gK5y6wUa1CnfXhNbnPqhTwq2m8EF1SNkKmR66fc/maQBSa4QqfMKzIYJLR0cairdCIIM2aMzd1ZKPkzil79Ce7PdBVlGCP4Vl6efOEiYkmlQoJg3YbNp3CLbv6YDBu+ep7zqpuM4JzrWPE2+iv/YW0X6Prc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002433; c=relaxed/simple;
	bh=cd4AcbSb/zwpCNWGcOL20eSrZn24TGsR+Gn6cw7DvrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gJBgrjFdmSAE+XyrC+31nAszTeJUkbeCxLy+DBILymljfiRK9y+vQkzBJM/j3lZ4pOeVbsP86FNPApjFK08x8Mf0Y0bQYP8hJqqoj4D+zq5cbSlooFf8Lsq6YQ0rW+dnNoa3g8YBjbmDJKBdR3vNoYtClGgdgDWDvU22Gwf3MD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=n60S8IzT; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n60S8IzT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVaPYFJ5MaF6bo8n910XAP2Bln0tcYcRGnJSd1qxMqhJC5Acq6UWryW8clz+Ud45/1pmsKdx/rQJL2rmMAHgPFZGSIE1/9znD8IvS+8JZXifsyhMIs+jNSTXlg5eFUkAVHA1G/aqqHPc+CxECuoQZPE97WpYvMgnO+MSJIDnd0Ovzj4P5Gf/hjVgV5xpfZEdRr4+jjbiyRsnETpC119Pkee4GchwdRq+5HosYzPpt6qyBbGTKhOxncN0PZYJBSUmH296Ht/msOsVFHX3AeYsByhzePUSyvK1kc2NNJ/XmCY7GygfDbGHQUZ/zcV+N3Thgon3430yNROH3eYRcoZ4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rqzeZUn/a7gUDGTprWXHacaejLEZINdeqHR1SyZeZY=;
 b=XGRhBX4SHarCL9qwTZPHz5sZYF9p/E1XGTTCSIVp3optvePVDi0qwP21ZAYGSXGVPRiqNW0fbX2BE6NCideanCrwd27n92B7ZqwtVsvzKuRTT+VvILkpfwPxLTI17d3rIKuyYjNkIL/ptCMcoup30IyYKCYi3ap8qCQMCPrpVZGxB42TkHKmKlMI+jPSgn2rIeprdzEwsXA1E2k6AsBC0y17oHEc1HlpI5iDLDPnD+BNkW1hTldONiBOBh4/l3HAvJkeAZsL1vBrsEdb9lqLLMaiQQNk8gYrHI8IzL/IWgDHGs32EvZekF+UJSaGmQYhmEJCMrWLlBrd4ZmpiKyeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rqzeZUn/a7gUDGTprWXHacaejLEZINdeqHR1SyZeZY=;
 b=n60S8IzTfUiyvDXG0z/QMkQvF/FDbVBEvc4mk/X1KZTI0y76Vu1sKdzRE7TS7UQvgNl+ZOU4+NTXyGah04WKfezZM4Nd1Lv9Be/02ZFnnwhh69RX2rNjQZgCUA6cgHspqyBFBq+onwkhUotN0J6hRnoUa/r7pl0sH23o/alxLRz0zAZerndTHn0I8qZLbf8GopFvUFVz+zamtyiOEuXXgeIM7PbpffyA9wJsSvrO4WSFeCAWnPg21cISXYfgzwcJQrt5UEptTCeJFEY+0ow8TuW4XAQxr+24E2xI4YfuZGvdg+rVEwBSrlfe42Sh/dlZkQsK7pMSp7vLfS1FOzjFEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 21:33:49 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 21:33:49 +0000
Date: Mon, 17 Aug 2026 16:33:39 -0500
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
Subject: Re: [PATCH v2] dmaengine: pxa: fix double counting of the hw
 descriptors
Message-ID: <aoN-M5fFrOFT2lgp@SMW015318>
References: <20260817-dmaengine-pxa-v2-1-f42ab0569a48@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-dmaengine-pxa-v2-1-f42ab0569a48@pengutronix.de>
X-ClientProxiedBy: SA0PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:806:d0::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbcc5b4-008f-4bbb-d542-08defca73974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|1800799024|366016|18002099003|22082099003|56012099006|11063799006|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	ZycxkAVaJxmc3PkZ7nNjbHWbetYaQRi+uKelXjXuUQUIxAin7y+zb+l0DJrSDGrhJySIfKXRvDPrGDrV5qHFttknVUZYF4CPLi9tsF9bPdoGtrcQ9Vosq7FY6yaRdk/HbeMqUb2skcch4848rLpZtgy/de1OvBFdUVwm4llQWSQrNdgcYRj72R0eJ3wl9Cli7SKaRElpxWaCcnpJgkNZANojdGRKY9kajDcUlc7eE8R9/gbGFSiOOTmHyBeIUTDj6TGrdemAJDCkVFjgSl3ytSri7MBt+57qGRKDmJQGh4I2qFhcKHXmGthZ5XRQP2Rx4x2+boRWkG4p5WWyE+x+tNyCQRZMDc9TACz0HzXMJ5l4jaD5/jD12n4Iy904aWMSDN5XDkJvKBzh69RV+0ifj2Tj0VcIMdpodiIZT9ha2yWCUvtQZy7b1ZxyoJGnzJAqrUVt0EXVPvhz5ATR91hBtm1wOAD2EhpUa+VgHzbEHrfe132Dcux83JFkw2sJwe8o8PZvvS051ytnnfMGd4RdKAzZGO7ntmB96ycesoCZ0pWHvZoso+MRTVbR8kMIm824OUT7ThCWXWleP0YEktJJ/JHYAnEFxANeN3bB0Ku0uBslyHhYru+VknyNcOtTk3CL11ZzZVdZ99jmHBSqaeEaCS9i08smlNwuR+8ANZNdbra/2y1d/9sxY521VQTjnn/toGafnv0sPeU5O13z0dk/Ii9SVmRE07X2MZwLIAxEZ0U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6gnTRV0qzcpi2vGpb6HUVgNC48g3Boyp7Yd7jUbHYHEtLVDaT4YaHOvmehQ?=
 =?us-ascii?Q?MrTy0KmjS5m21zHtj6Tf/IzpVmwJequA3Yw2+K4tCJnFX6Msr+58ui3F02bw?=
 =?us-ascii?Q?d7GCHwabnzztztmJzWYhAmB9b1vmvDxHTDU+X44N15uZ+1YmIh3LaOMnPkVz?=
 =?us-ascii?Q?H+q/CuSVNq7jd8Ll5/e87nDLjki1cVyN2frE1V+gskAOIKGIRp81Vgr7VJKX?=
 =?us-ascii?Q?g0cHQVBdrrYHQFqOkuXaqbJx0WL8l7pcZx8ck9v7CCv7r/M0WT7QrQLHtiaA?=
 =?us-ascii?Q?qqoW6zn+bnlQDkhtq7yuaBV6ANmmWklzC9cjMXH19ElIgOTdZGtB6PfXAE+t?=
 =?us-ascii?Q?gHvwV/Jm6t+S6/fC3SlEQHw4bOj76LUBYoMDT1UPnrAzeinvKSSdqZk2VR79?=
 =?us-ascii?Q?6Z1C2aq8ZfvpEMVyF+yatP2lghDM6SUaCpOmm8o6l/qPFiB0bebUUkAlWy91?=
 =?us-ascii?Q?VM5Hbw9A6X62rprCrDcD5XmIyjhK3EUSOxkc+Yxiq/ooh+2FKbAWcP3unGuj?=
 =?us-ascii?Q?1AMO5iiBY2yogkN/rJKDylmQjM5WHiFprO258FnCbiCTeFrOHm9F69gHFGpB?=
 =?us-ascii?Q?ll6ywc62SCmQ608s9aeQeb+PzCOjgwvVlqj+fUmye9ECpXcXGvzmOPj+UNsM?=
 =?us-ascii?Q?dVSMk1fCZt3LDvnfZuC21iuWYJ5XzlTTij0XxLLM5Q6Fh92ku3QJWfoJPrc/?=
 =?us-ascii?Q?kZnSIFhBAQQUfn5XO+ujErHqa5SBWpAk6aZfDzRwjwB0CUscXS3PEo4RDXcZ?=
 =?us-ascii?Q?WLZNbjcgkmueKIfXoN1G72rVnORQ4BYGvasTIvEmllQB2ZW2ljjNq9d0Qdwx?=
 =?us-ascii?Q?h/N/iq5nNB1jrc1gcDLStNSR1+DbsTJzVTDrTW+ltPRpOy22TeYeHqvcEf2q?=
 =?us-ascii?Q?Q2LsZQoM2hZlNX9ksEeUhRu9PgPtBlK6w6NWZNoWtGLFeqVmhGPWc9uYoQTJ?=
 =?us-ascii?Q?q+kPiQ1bI5CnhUjYVLwlaVCOmnchvli/rkwDLZjEFgnhNw973a7wWGUi8l1A?=
 =?us-ascii?Q?8T53HY3BhLb4ugc1OyHqEfZd019kVCytLkX/mLDo2cB0vDcXiRIRZAVlBagj?=
 =?us-ascii?Q?RCFo1LCF7fwRoeyNGT+99TJnOzEB/fJeczb/PoW094x/MZNlnFSfedr0R7Up?=
 =?us-ascii?Q?S2Y64wV4kpw40GgG3qTtAfNW4a6a/F2QsTFWne7HPLEkdJSoJOOSKeJ/woM+?=
 =?us-ascii?Q?LGKA+hxzKZOIoePWb7V63JI4+8DJHNLxdOUPHP0X7AEOJZJa6rP9iq5ymS+a?=
 =?us-ascii?Q?Pok/Xcu4N504gQYsq8USNtq4H9+I+lOEMK1kYDuhJGQhFxS5LaWDJ6FZ3nLH?=
 =?us-ascii?Q?elGOuhDrZTzNJXgaSVRaDQx8ZHhJrL6aOsZP2bzSqcYoTMRp+ZpyeEeHGkxf?=
 =?us-ascii?Q?Y0E9IxJIyEzm8QpSQe/OBtaVV0KzxjikG8qgZExNfPpiy1v90cY3MyEP/gDl?=
 =?us-ascii?Q?GfNoY8z627+SZ+eC13g/wYs9NQCdnMGrfqLTzMnLOmzOoRfSEhL/Rqzjiify?=
 =?us-ascii?Q?BXtKCnMeqQ3UNotqvJV+iDokLPkK5ADNx0XnLbDkeRIfpJx3oH70T/fvgH/a?=
 =?us-ascii?Q?KzfyXnaH500wWEhSZZLXbjReoVItykxAioQpt0ZA81BQTVDCcg7Bm7VabGg3?=
 =?us-ascii?Q?p4Dh/+dyGfGuQrCJvP6+v3Z9KpRz8/nDmidL0s34bfGnEOl6oNozWUg+SGJO?=
 =?us-ascii?Q?DrPqWlZsmYxJtuB7SQiI0I8pcsuI7z0oKtLXs+GjNIP0es3r+N/iQpWIHpiY?=
 =?us-ascii?Q?ry+FRLD0QQZDWgsMrBigpbtdMNdDUxSUDdP67T/530OcUKqIfd3U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbcc5b4-008f-4bbb-d542-08defca73974
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 21:33:48.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJEAcru4qM6SIiQxeBzBEmiBJAN4JMQ0vHjQCI+HuKt4A7DtXOr/u79eDTAhn8p6KmCI0w1pLs3dj8vUBay73PZhaDL9L3WKg8gNaNQEnFi0u7a4MWSPBBv0Uc2feQLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576

On Mon, Aug 17, 2026 at 10:44:33PM +0200, Sascha Hauer wrote:
> pxad_alloc_desc() was converted from
>
>         kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc), GFP_NOWAIT)
>
> to kzalloc_flex(), which sets the __counted_by() counter sw_desc->nb_desc
> itself - but only where the compiler has __builtin_counted_by_ref(), so
> from gcc 15.1 or clang 22.1 on. The loop below it still increments
> nb_desc, which makes it come out doubled there and correct elsewhere.
>
> nb_desc is what pxad_free_desc() iterates over and what
> set_updater_desc() indexes from, so set it explicitly and drop the
> increment. The error path has to lower it to the number of descriptors
> allocated so far, otherwise pxad_free_desc() would free entries that were
> never allocated.
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
> Changes in v2:
> - assign sw_desc->nb_desc manually as it is only automatically assigned
>   for compilers supporting __builtin_counted_by_ref()
> - Link to v1: https://lore.kernel.org/r/20260817-dmaengine-pxa-v1-1-850c215c1196@pengutronix.de
> ---
>  drivers/dma/pxa_dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index fa2ee0b3e09f8..fc43124fefa89 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -744,6 +744,7 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
>  	sw_desc = kzalloc_flex(*sw_desc, hw_desc, nb_hw_desc, GFP_NOWAIT);
>  	if (!sw_desc)
>  		return NULL;
> +	sw_desc->nb_desc = nb_hw_desc;
>  	sw_desc->desc_pool = chan->desc_pool;
>
>  	for (i = 0; i < nb_hw_desc; i++) {
> @@ -752,10 +753,10 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
>  			dev_err(&chan->vc.chan.dev->device,
>  				"%s(): Couldn't allocate the %dth hw_desc from dma_pool %p\n",
>  				__func__, i, sw_desc->desc_pool);
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
