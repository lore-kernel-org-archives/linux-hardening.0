Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBBB30EF86;
	Fri, 25 Sep 2026 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790310773; cv=fail; b=oGWpVUBRP7WtTUX7bBlsHhZdjQfxAV9Kj7T0pdIUBPTYmM9l+f/In6yCn8UN09gmGfwGEP38srzUK1GQFFb35AUgt2rcjwvHrbOhKRzK9qwbBuj3RH5c691Q+pbSwXXWgA1lpl1VKuWZbYKxoZlqZkGwsdPx6uEsxtYxA/8peGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790310773; c=relaxed/simple;
	bh=pazCcTIxsW505POgWXQFDmWWDi1wTQUQmZmOuLcRUy8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NUo3MnsBfcwT4Zdr6nn4MzVZb5IOZVQVmBkZXXuk1MKPc7eAYkqbOe/Sc3CbWsk58gNdYUki9LR3MVTfPOVKISHlJBjUkay/yefPcGBdI7eJ84kx2vOi6md5/PSlXDiJWlni2HHW3tx/pihFKcLzOKdnR+Vt6juIuXTJc08ZjPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AiaWFUE6; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AiaWFUE6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTX/9Bvm9knwd2AeCqru+Bwwr2vWxGTlgDS4E9OqJkY+BssQ8pxKkBzbRr0fdpiH7tds6kFtJE7JTysQ2fSP3BLaiK5E7xKo0ylbTMTvJ41jX2GH/p3j1lWFt2AOAuX548Kx/+ZWFPmV9T5Eo3/+p01dLstir174ZgxlXfI0iGMal5p+tpGqx54NfCYOdErAo+z3CVnDT54KgAVH8xm7HoQF+2fgUVN9a5ExEh7QBdHHLtkQjFFLmKT5Q4oSRFNg9/4/nGXfYJKm8dGkpDsEV100NlLQcnmaVA1wnpbUe0kzhNizujX160qB7tjWYvy7qUoxM8zvei/8ae789NSZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NMumamLPsUjip2aJ3R0u6HxC8UmZ1ahMOlQhN17zHI=;
 b=SJvAdiFfy3BKIVNgypCF8uxgKNvEYB/j0GZ6qHqsVC2eHMDxRloEaIqWl7MOFnaikKRe/PnbBDNyEseqgR8mHB/lRKlxoIJJSzyF3LVsABABv/GnKHcwPcIc/UV1T0It1AWZtEI8Y1McFh4Bb+5b3bmDZSiWpOtIo/Oo2TBMFFUOiRS+cXaAkO3jwb8u88HA+wvAiezsJkMCR7U3vOvF3sgOUn4vjd2oz2qJYckblBz8dueBKqje3VoVKYwPWw9RMx7rRRRLiyse5C23S4FK+g/+jsioft6k01gdLYoA4vj3yQ3B+PCY/SYYcNo90cNwqFkd8xQyhGGzmQM1QyFZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NMumamLPsUjip2aJ3R0u6HxC8UmZ1ahMOlQhN17zHI=;
 b=AiaWFUE6kVTunWx8uS1EB+ri1NWsf4VU56SK29JQaDpeJ6C8aykfOykhGQjXQcBscIDrCaDrhLA7Ye5vvXQEUGw3P/KQfGVCwL3D1Y8WcK6f3hqltFhNXD2hUwNMbJL9/7eXlE3Vn5i2/s6+jBeDYzE23hQ4B71LMOn2ZQ8uH0/6sDSFGQxKerNq/dzu/DoYGXSjRzhYBgfTHmPrCszqoCkfAsGov2NAb5jIYEPJ5wK5mTfcYd7TzDqaIwFfzp2B7mEImMQ9EWw9Ssp5ShKAwHIoySqJxTXZobsLKLQ2mLoOOzhO1oVxMHOwM8sCSsAbEDk3ohmSpf7ldhV8bSCTfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV4PR04MB11308.eurprd04.prod.outlook.com
 (2603:10a6:150:297::19) by DBAPR04MB7368.eurprd04.prod.outlook.com
 (2603:10a6:10:1ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 04:32:41 +0000
Received: from GV4PR04MB11308.eurprd04.prod.outlook.com
 ([fe80::b043:b2d1:9a94:1891]) by GV4PR04MB11308.eurprd04.prod.outlook.com
 ([fe80::b043:b2d1:9a94:1891%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 04:32:40 +0000
Message-ID: <c6186100-d43f-4af4-9fc1-3335a441cf2d@oss.nxp.com>
Date: Fri, 25 Sep 2026 07:32:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: s32cc: Remove const from groups allocation type
To: Kees Cook <kees@kernel.org>, Chester Lin <chester62515@gmail.com>
Cc: Kees Cook <kees+treewide@kernel.org>, Matthias Brugger
 <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260917211452.i.365-kees@kernel.org>
Content-Language: en-GB
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20260917211452.i.365-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To GV4PR04MB11308.eurprd04.prod.outlook.com
 (2603:10a6:150:297::19)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4PR04MB11308:EE_|DBAPR04MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 484ef454-30f2-486f-fb0f-08df1abe08cb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|1800799024|7416014|376014|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tYnkNBGobyBGvtYKtSH8Q736lkTM8NdCE1eb5euHihYGN2LRYkS0sGx4OAPP0YPB6PEG8m7gOcgtRvAnkHbg2lQFfXHpeyxnOXcX74Heh5Z6loP5cqjG3FI0TySjkHP9JjT5WeycB6kv5lz1duhdG5tCm2NqKPlR80AKU5Y/qvED5xRdj3dT5hZuYE/DQ4mynyfmgF2oUwupwDE1MwocTF4w3oA1Uih5aRfJ0YVT5YyzE3uSss2MQf9Zx7oMxuset0TWcMT65dercSbGZRcbQwgNUDM/pyO0NUkPfI2Wy4CV6jLmQVFdQT9WG+saoJQdHoeaqC7wUdmXHgAJ0pei/D5553J0HBkHZTjkarwguo7C8AdqIdbARPSaReszAzWU3OnkGkAHqUf0O4ZjkoFAcjJj9b0sUTeDEOYWFVVSRnhO32kCVd43obL2v7Ucs5Cm3ugxs53wfpl/EHVtVPtI/k6ttZBMJ3ysm24e2TXzbdh9QCW9H4RaWu+AA8wtW0HzLim1ii3WvDX39eVg95BKIjwK3ev51yRx3LrSvgNT+Ui/gpkUzMsC9mw8F+v+oaI6d1Wo7zYH71rScr44jOqsygnxJH0cyBJZ5V7Ljxi+qYr4opzu9qkl0GovXF0Spfy/psw1MiytBb3bVBdOrG2PlO433RNBfJjU3MzVhthlrro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV4PR04MB11308.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZMTXRyYWk1eGVlZUk0bmpLQ21yRHlrdzMzUjY1TkJDOE9uVGttNllUa3o0?=
 =?utf-8?B?WVdQaVNXNXg0UGJET1JPVERoVHJpLzNUTVFUYmNxYlROT2JDZFZ6c2xpYitH?=
 =?utf-8?B?K2JJY1NrWkJiTVZQdG1JSldySFI1SndqL2hxSXdWOTU5a2NkNFVPODdXSCtC?=
 =?utf-8?B?RktPbjU4b2dlZkIxeGZrMlZTMHFKcTlnTmJsQUVHY3V3RU8zczdXVDQ5QWNY?=
 =?utf-8?B?UEJrTUljaU9FUkpsV3IzM1p6YmFnY3h0R2Y2SWkwR3RtNENwOE41YzIraFBq?=
 =?utf-8?B?R215MDJqeWg3bExQWFZjSjE4RFpRTC9YYUhWTElydTk0WitNd3hFWGJKWkZx?=
 =?utf-8?B?QlVJWW82WTR6OXgyRGVlOXp6OGpEWW8xY3FEQm9RNDRuZ3BHdkd2Uy9NbXFi?=
 =?utf-8?B?Z3dIdkp1eWhrMC9vSE1yeFFVT3pyYmJXVlNyaGNKcEtOTTVTenNDMFZIMzNF?=
 =?utf-8?B?eEpPVWRTdWRvRlp0aGFRU2dnYWdxODF1K0pqd1ZlOVJxZDJISjNVSDlWN2p1?=
 =?utf-8?B?SHBGVnk2a0ZaQ2FlSStDZjR2dTlwNkJrNVVtWi9FTThneGdsN0NXbnovWWxm?=
 =?utf-8?B?aGIvaXFzQmNWQktkZzFlZEwrcVFycnRPU1dmZERwWXl6UDRRS3dFeXlOOURL?=
 =?utf-8?B?eEYvd0tPNnRxZU9OaWl5b2NUVU8wYlpNL0hxdERKb0JkUElvUHFxN2ZNaEZy?=
 =?utf-8?B?YmtSOWxPeERTUVgvVzBZWnpjUmxJdzErQ1JxN2ljYWRqaUpIUU1LUEUrNG81?=
 =?utf-8?B?Nm4zOEFwZUJQSE5CN1diUlFZVTVyMXErWUo4czUzeGhPLzlGRnVPNjQrdjZa?=
 =?utf-8?B?L2dQREZVWEpNaGNNRjBWcGVpQmZ4VlBLbEJtMzZEK1ZYSk5nRnFYQSt4dW9M?=
 =?utf-8?B?S1hGR2NyQklKTVhKSGs2a21aSHhzYVpuVnNUaFNYdzFaRnZVZ3B6RjliR0o5?=
 =?utf-8?B?RVRMSHFuelVGSURDVUJRWWk5TGQrSzh2UEE4SEhlR0pFNHF6MmNtSGN0OHlG?=
 =?utf-8?B?a0Y5dEJTOFRnWC9rQzdKUlFFbG8wR0ZTL21jelk5OGpMeWFacDdwMWJoTVZT?=
 =?utf-8?B?a2lsbEJOdVpoRThSdWFnSDZCRFdpQjVjZHVFUHJMY2RYTmNlMk53M0NLSHlV?=
 =?utf-8?B?OWZDanVaVnlkOEp0N2xoQkJBMGFxb2JpeFBPc2xPcGQxcXFXNVF0RS8zZXJB?=
 =?utf-8?B?OC9mN0V5YVlNa2VPa2xVeXdzNjNjMkUyRnIzZml1OWl5bmNDUW50VTBkREgr?=
 =?utf-8?B?c0EwRFZackZYYkpqOEQxSHBUM01MYVN0RGFlcWFmWWlsbVh0MDl3TFJyTG9Y?=
 =?utf-8?B?bkVEZy9mZUhtakJZNHNvd25laXEvS2ozUlQzaytOMUFwUXhGLzJMY1pjckZs?=
 =?utf-8?B?b0pZaTUzZXlWdVZpTXN6TTRISE50cE14QjFNYklzNWNibjNWTlBwMDFoNklm?=
 =?utf-8?B?OTllVGJ3dUZxaGdYOERaMjJqNUZVVUxmakpISDNKaEhIcWJtRTVRQlpyblpM?=
 =?utf-8?B?NWtQL0lpYlV2OHJGTEltais4MkhjOWVVRGt5TjdEYnNnaWNPaGR3RkdwN2E5?=
 =?utf-8?B?Q1h5M0VCeXpTQUttWWdENkF5WG4zMThWUnRRTW81eGhrNnozK3Fxb1Y5ZGZP?=
 =?utf-8?B?K093NTRCMncxNGtXbldZYTRXVGs3K09ubmsvaHBHcXVVMjJ6NWhaanIwL3Zx?=
 =?utf-8?B?RjU0OUhxU24rZ0hQcjdnOEVDV28zVndYME1rb2IvQTZVNXhLQWpZdStjNWR5?=
 =?utf-8?B?NjN3bksvc2FoaTk3RGc1OTk1bWtlODhvSUJ5d2U0M203NURZR0Y0bHgrREVr?=
 =?utf-8?B?WVFXSmZuTnlxaGpNaUtRc3hYTGpaTVJsQ20xR3Q0Vk01bWhGS2FwdndhVjFw?=
 =?utf-8?B?dGNtaXRtV3FIOTN6SEs2UndHYlUzeGs0ZHlNVDJrWXcyclZReERRV2JYNUh1?=
 =?utf-8?B?TmttRFBnTERGdnovaXVWajIxYlQrRk5PSS9tZDJRYWhScnBsYTJ1MzB5WldN?=
 =?utf-8?B?cnRiSExFVXdyNTlEUE90S0ZqTEs1QkM5RFJjN283NjFKbThGUGVkdTRHb0dB?=
 =?utf-8?B?UFRZb0pjOFVnbjF2cXpVVjRzbzRZajlFdFEvSE9jSDk3c1dXc1NpZEs1OWgw?=
 =?utf-8?B?NE9KNEpQNk5UQXZuZzNtOGx5ZTJ1T05DL2VJalFoMG9aamcrNXlZN3NmWXZS?=
 =?utf-8?B?N1ZDQUdQK2VLaUc5OGphUHpVSHBPdjhZVExiYk5MNkdrSkJxQWlZdCs0Rkx4?=
 =?utf-8?B?RVFVVUdtQVh3QTR5a1RoTWh4WHl2UEllbk1Ga0J2RnhPZWwxeThTdWJzV1Js?=
 =?utf-8?B?d1VJdWRGY0MzYWJwN0pVMk53RlRqTlRiazBCZHB0NlVITDNhMXFXMkMxSVhr?=
 =?utf-8?Q?p2y+6jHbhuW+FTfs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484ef454-30f2-486f-fb0f-08df1abe08cb
X-MS-Exchange-CrossTenant-AuthSource: GV4PR04MB11308.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 04:32:40.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ub5HO7CSxEDF7PgpuZ2DXonViYjlCHNLPs0ZhcE/ssrn3v7VCuYTGLgQmzlfSDrBVyPziXJRGr9okH7ZoWMH1AJ3dg1M5M1sWFWU/FuxN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7368

On 9/18/2026 12:14 AM, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "const char **", but the converted allocation type
> would be "const char * const *", as the size was taken from
> "*func->groups", whose type "const char * const" is const qualified. As
> there is no general way to remove const qualifiers, take the size from
> the assignment target instead. No change in allocation size results.
> 
> Build tested ARCH=arm64 allmodconfig with GCC aarch64-linux-gnu 16.1.0:
> drivers/pinctrl/nxp/pinctrl-s32cc.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---
> Cc: Chester Lin <chester62515@gmail.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> Cc: NXP S32 Linux Team <s32@nxp.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Jacky Bai <ping.bai@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: <linux-gpio@vger.kernel.org>
> ---
>  drivers/pinctrl/nxp/pinctrl-s32cc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> index 4b40770a38b7..9c4ebae22674 100644
> --- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> @@ -825,7 +825,7 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
>                                      "No groups defined in %pOF\n", np);
> 
>         groups = devm_kcalloc(info->dev, func->ngroups,
> -                                   sizeof(*func->groups), GFP_KERNEL);
> +                                   sizeof(*groups), GFP_KERNEL);
>         if (!groups)
>                 return -ENOMEM;
> 
> --
> 2.34.1
> 

Reviewed-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>

-- 
Regards,
Ghennadi
