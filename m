Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010026.outbound.protection.outlook.com [52.101.228.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ECE73176
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054531; cv=fail; b=IKWsVWj8i0vlZEZBDAViKSJo6uN9OUcY73UJflCz1mSmdU069p7EVI2uEUX3gK/9YL6yYqyg1LG11Ptj0YXpnHJG7cDc+AQRtvagzFbZlNXfZf8IHtlz/0ngC/+i5U7NaYQuwI2CDoDq6S7YQ8kH3BH7QzC4Q/18kKGk7cK2P9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054531; c=relaxed/simple;
	bh=ZwKYjHxfUNi8cxhfLAWML9/ivwcmdV6NYmcRO9f4SAw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=p6dsuotoqep3+IX+IIXvrkEU6OTKbSyjSxL8Arfe9BH7QoBf87E3nlPeCEhlcXbhUq1eTPxtcyaRVqhPx5QnpSS1kj2ciJTxmKHcOXBnp0GyCmllvP55pQuZq1ShXT4jGyjrZyM90ObuNQpIkv97tMzxxt+MVz6iJdLRCS7yNG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=lx/sq1/O; arc=fail smtp.client-ip=52.101.228.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="lx/sq1/O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnVP2NVPyvV9vf3o+PKhY6gu2JnJ67g4oB7RZCBEJKWathjMRCqLtqmR5CQgcjeKy6+M1V0seMeQ+MozV5YxPElIqTvgDhGTRMQ6vuSq0b/uwv5zuIRdZ7bAdqlUWKOA9OPBHU47ez86ZxkC1rSOH/TdNG6U5H9BMGq5Kf9kwU96wXzTQETsda7P6Y5N2xoeIrhSxRjq497+I5iQ6PppZbA1zbxi/kTrv6cAD7sDkHiAWpuoPnj+Cihp/yV4NjN+Wjul+hXdXuJP13lpRezurW3/o233G4QMyW5dPOXybmWE1MUgpPs19EtRk0cMa0m7CAqnkagSgBfEHjyILch9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPaBxVA2m9vN4bMUj1ZsTFiokdo6w54UAzejLWwo0Ts=;
 b=bKQZMl0bBBxDnGlemirkpOX93q5DRrvvo58cToH88BkF1O3kE35s+szDTcSup4CclRSGIPQWD3A67UbELXE0tu8CDqVaRZrmksdEmNC8MUmi0indsaQG65U2KO7pMry8dn0RtmnYbhfZusZTeOgNqa+7YqIqPRJwKX8sMF9C0JbWLkd6Dwod8TSMrxbEYGevmxW7GOFMyO5GvtbIMDohRmwhFVcCIHrgBFwHccW8Tiuy31H3wv7ImH9RZnfxiXgCEjC8t4gDOtBRh7SaySzsY0RYQ41zfwKNyPUBMfSr/JcUSeEKIpTas8BBDWCaT+vbvYladd62nAU/4GMvacr9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPaBxVA2m9vN4bMUj1ZsTFiokdo6w54UAzejLWwo0Ts=;
 b=lx/sq1/OTGvu/Kdve5pQleYLZ0pOOVLBr8XZzl5/u9p7sd346NyfEeJ++VDsM876KoRQ9ZEYO6dkI8sy08KOYGiV3RNjIsbRcGQRfHq9dcWp8wev3ahxxJcBK0DKOckhrOqIGMJjmvaJgKSJcrhanmH1GfQqlkvXAHzCaFL3+KM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB8061.jpnprd01.prod.outlook.com
 (2603:1096:400:11e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:15:28 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:15:28 +0000
Message-ID: <878qplpmm8.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] arm64: kernel: reloc_test_core: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:15:28 +0000
X-ClientProxiedBy: TYCP286CA0314.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::18) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5dd70b-be00-4f60-abd8-08dd5ac26e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5cZtZXcNGigsdodozmI1Dhj/f4PAg79WJIi+QORJa168pPDzHMiIZii8UBNk?=
 =?us-ascii?Q?n6D+/Q4vc69LV9i3ixbuMeVWqxY7IL3a8uBVNdJ+1Lze2xPW7IH61aLDckYR?=
 =?us-ascii?Q?26BFUtGy+/v7QYNSXIemi3yVf+z1OuZ5uoIZX0ej9d77VBzAIj7Yo0DHmnQk?=
 =?us-ascii?Q?h/y7bbXxefmvD3LI4vxrpSKJtqu9sqZlJDmVSv/WtvXK7ihdxF92InYjrxUP?=
 =?us-ascii?Q?DAd//Bqzkr4cu+dZB7UmUmla9sZveODfIEykNe7TE65WxzXCJOLERoX+LVHD?=
 =?us-ascii?Q?MiSspuw1V+UroFjeWpptGt2k75Xb07zDA68x8u58qFDkSSD/MdNf9BwqmcFG?=
 =?us-ascii?Q?ihuFwi0FtizGGrfagImwGUhFMwqu02qNuTgamZwuceQKcSzipSroB8pakp6B?=
 =?us-ascii?Q?2TPoI6UTPwiefunRM7/ODTWHdyFzuj8ixGro7hyQOVIixle92S92anARYhXM?=
 =?us-ascii?Q?5ZxKNfY0ko+LhPMgaK3FZ9RRPlhM+JY4RPfSR5pRgBKCXlNw3E45Mllw4eTP?=
 =?us-ascii?Q?9c/LkgxW0xAP1n59ssltq0qDtElyDO2a9cZQ3icDYo0bfb6gd7DOwHRPT3AN?=
 =?us-ascii?Q?9SSfHhEsnflgyGJDN2gMXaGsJD5qi8ny+bpcpWvo27wJHTxbMw0dsiDdaVHw?=
 =?us-ascii?Q?BPBMZYJEWR/P/4l8b+gEq9J3QuODnl72os6WFp5EZZzsUmCjcDhDjqMW86RB?=
 =?us-ascii?Q?QKNuDxP2Jy5rxXxkX6sp70r5fA0plzd7w6Adt2CAyCRYGHeP20YGxCIZxW5k?=
 =?us-ascii?Q?Hi/eyqs2pMLjQzJ5WKZD7ZDrVWUZCuGn1MMXCgcfMuFS/zXTEl3n8fVNI9jL?=
 =?us-ascii?Q?nSfd4DP0f3wQwdiiFVSUR7HlHHvzKIQ2saDP6Bf8l85mursdG1mU1sD4gmor?=
 =?us-ascii?Q?bVrD7DJirJJXXGeT7XHr4qZlAkF8bFpCPHvLSJ4qf27In2L8gMrm/zkk9w/w?=
 =?us-ascii?Q?DQF1NleSHuimZo77QkwVfdSy+M+0pS1LE7hO6fo1uPVUMtq6x3V7vlElt+6D?=
 =?us-ascii?Q?t1ndbG0iAXNwT5PD9fE/4wYMaMprPxWkSjYUUC9CiFp0px6vTR/4AI0/heej?=
 =?us-ascii?Q?zGNYohFOuZSRyO84BbEwtA7bPBTQSb780Xr6wIPiHwQdOx1IJy4zw2gUy8id?=
 =?us-ascii?Q?fHzFhpI058p2JWKALSy7VvmbJpJsFqXOy0HaITq9LOJ7RvlJ9ttD9vIp15GD?=
 =?us-ascii?Q?ooqabpoyin0JFLtCoLpfR5zEr0HA5rLl2izcUBFT6cy6FLEBjwXeIwAYWB3q?=
 =?us-ascii?Q?NWVduxsLNgEVAYRODD8vBj/jmereGmPz9p33ItutSoqTqohV/eN7Ed0Nv04O?=
 =?us-ascii?Q?aI/ZqXo9Uw34g4Pt/c/x+ldFpS32JKoOGm9Zm18hA+FL4JAgiCGOXCm0WHU1?=
 =?us-ascii?Q?YN/NxLxTsCcAneD0VoDlgbjX1grxE5aYIg5bT+yubU3BHoEBF6dRYr6kCLGT?=
 =?us-ascii?Q?sfnhl2Wh7iQrJf9Yf5fYXHnXRPoKKLu9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q59mlPFu6O1axNHQBjxRxzvzazwpbD+kBh8ynkqciiLLfVkGLX6bBhrUFJCd?=
 =?us-ascii?Q?m5+tLt+hQaf7wW4yuQSKEHfGSxyt0BnHAGVSe52KUIvf3MKcWcyqthiR36fP?=
 =?us-ascii?Q?V/ydUs85j1VjMgjjgn8YYNcIn2xl1Xjrf/9fYWRNUZzThtdw16F70i09u6+X?=
 =?us-ascii?Q?uw5CEuAEhH4oQ1GbaCqiW8bFeCFbchK1JgZs6A725fgddmEMybEzxULr29/z?=
 =?us-ascii?Q?dfC70z1wY9Ogaevg92OQ+B8CRYGg4MmsD5S/iCiehdGzuZa7jz1xycSN3AvD?=
 =?us-ascii?Q?Hgg3dFLMFUH1ay8BlaauWHMW4iNeQ1ciUYAmqEYqoeZp0a5p2Q7PsWxNFRuf?=
 =?us-ascii?Q?27zjvmr6fT9Xu/Rf3nI08IMVgJYLphREdFhkm2v9y7nUv5X02E4sqfOs5lF9?=
 =?us-ascii?Q?O0c4GIOmKSG0+igHLDKazGfupCvqpl3Eh113EVqcNEwD0dsDq6g3D46cCfep?=
 =?us-ascii?Q?2RBnJnJd1P2lpMdpx7Rf9EH8D3DldaeyJJRHSpXdsV1ajcGZoWRf4+Hk2rC7?=
 =?us-ascii?Q?xVFdfhLOGtc9sqFOsAr6+tEDywcAGTmgB/yJ7s1uOYhIjTnjBa9c9B57h8ri?=
 =?us-ascii?Q?9I/YPaXDOsZ3vBXcBh3rI+PQATIqwK51Yyd1YSBzbW4N0qmZKoPUV5fjd4EG?=
 =?us-ascii?Q?Z213zj8vea2RfWvwHMN0r1f0j+1ob0oRfuuucA1fId+xiKzKRmYqo3Br8GDt?=
 =?us-ascii?Q?l7s+A5iG2m/NVYoCvGfztsxNaNHGe/wQWDkShNIaMgvJvHFQXUNIXy3rY/lA?=
 =?us-ascii?Q?69QdG4Gnk3cBw6ROqRofi060KykaefbZtBEkE6FgL0W5oVTaytmkpPutnapA?=
 =?us-ascii?Q?Htl4dpygi2VhVqv/QWjwfQBH8bt/+kEfg/hM076T3gXM2wYBuHHwHQdLLl82?=
 =?us-ascii?Q?F1ZuUCx+Fss+a1uMxj2E8HavSi+3BpOiMuRfvQDGM61DWY77I+kxwWn9rXEz?=
 =?us-ascii?Q?+L82/kKPfAwXZEr0pmf5cDqO2GGac7mCn+vU3rFpepIMTvQ3ZN3DCMlfFTPs?=
 =?us-ascii?Q?Q+Vl6dEJhoHsW5NDuhSzRKPiYUiiY7sDyOGts1BiFe4lA/PV5Z4a9pwNxrG5?=
 =?us-ascii?Q?ye6fO67vJ+M2/Ac7EONzw7pcf9IuHw+QIcW2SNluefCG5BthZDa/ddaPFW/9?=
 =?us-ascii?Q?tAogZaWwFypPWqCf3QXEIpWUbKijj3ee8F7r2QTB1ibXY0kykS2OQols4t9v?=
 =?us-ascii?Q?YR8GXDiFefxMkhEmPQLfAzsKyZRq2HnElaYaKR/CZODT8wc1h3PrOkmGJfU6?=
 =?us-ascii?Q?TrFQx5zJv7agi7VmbsGwFB5qfBMle/lqVGR5ILXjkUG20zrsMKk0A06icYvz?=
 =?us-ascii?Q?0QEbyrs+S1zu86YS7HF/EB0dEb1bbKyuJrZeC6issnray2PsNwg/OlP8ohjz?=
 =?us-ascii?Q?vbcWWKHVaAiReFtyDW9P8wEbiQ97WUiirZfHXXlP8Jd2QyOBQfRd+j1WrfH7?=
 =?us-ascii?Q?HjND6fAY2RlBGSPeFtVSy2FAiZxGwaQCMiMW0lvl3S1uhfVSgcxbraq9/8R+?=
 =?us-ascii?Q?tv0zvlYtkI9rHARntKuu1GP13NRfPyE2wW9+6OEQKt0uIzS9MRljFCsBQpaa?=
 =?us-ascii?Q?x5mDp5qr234nDuJ5IKDAIdd64ZIizPWJTDPG+XH12ysaWW1Y9uggT1e39O4D?=
 =?us-ascii?Q?3Z1h/H4emXypwsUQW5KCCQk=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5dd70b-be00-4f60-abd8-08dd5ac26e97
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:15:28.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acafK0DGJ7pr9+bSD1MtMIGP1euHnpRnmGxBVhtX1I/UgIDC7KZQSMYpd37xKcGjZLLVYDcvPbnt50uywX6lnvnFmS1V3yE63zNhEIVzY/wy2ReO6ltV7BKfAsAoi0Ta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/kernel/reloc_test_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/reloc_test_core.c b/arch/arm64/kernel/reloc_test_core.c
index 5b0891146054..81d80dd958c4 100644
--- a/arch/arm64/kernel/reloc_test_core.c
+++ b/arch/arm64/kernel/reloc_test_core.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/string_choices.h>
 
 int sym64_rel;
 
@@ -59,7 +60,7 @@ static int __init reloc_test_init(void)
 		u64 ret = funcs[i].f();
 
 		pr_info("%-31s 0x%016llx %s\n", funcs[i].name, ret,
-			ret == funcs[i].expect ? "pass" : "fail");
+			str_pass_fail(ret == funcs[i].expect));
 		if (ret != funcs[i].expect)
 			pr_err("Relocation failed, expected 0x%016llx, not 0x%016llx\n",
 			       funcs[i].expect, ret);
-- 
2.43.0

