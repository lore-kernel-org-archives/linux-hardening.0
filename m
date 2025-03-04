Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010054.outbound.protection.outlook.com [52.101.228.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81713B58B
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054480; cv=fail; b=P0ZOv9zzf1rTJLAJeLHb1IQkU7cvaNlPZ/kNXwHOYiHFT69+EY/WSAFP6yxWXLiEUpHTRisbkyL8rL+AIm/GmEDGtZVbVpf2m13Btbf1wdyTuSPWr4qUwqem2lHCenMgLEV2v6n6yb+D+0ZzLPjg3p2GuxRkKlOAPjcmGNL2aNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054480; c=relaxed/simple;
	bh=lA/gjOGp/mO5wjIgfhvpqPIVfP7SdcF5Tw/PX9VEKVs=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=iytvgRnOLnbsCxZVChA8n1NQpF96uQhGRfAzOO3sB+NW5MdQDcsHk7zd2MV0HwL2p/WUkRkMQ4l5Q3qDc1TFpigr2cokh0fbU5t6km+pP9vebh5FMlp3vyxR7i/7JkcxWzTkJ91bLP/SfJKU007ZQkk6l0R19IonzSaYO+s4AD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ZxWl8EdZ; arc=fail smtp.client-ip=52.101.228.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ZxWl8EdZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSiSWm9hAM6mhyQa3su4Fet77gyeDJuvZlDjXh6aWfYAtjpN8swyIjhkx7WE09xTV1A6xvw1nRug9OizOk65R6koxw/WGjGPi/B2WwEynpDe6qNr2P874YgP4M2lozF9ptl9PpDMDbztIHsub/mX07UfGFmgRgyx7iSNg/edEOuYkvwaqiaxedAVBFD2KFnzalKPokpEDifyuU0lR3AbUoCXhFG849z+chIZMe3YgRIyWcy5eq2KT/sZwn4YH3GqhdIXnwYHDuVytWD+3AonO24RiW4J4X/p2Ad67ft7q/zq6knkrZ6FdfnvIv+3vsgAdFqI2k3Iokuj6d2W1g84sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqUs0R9bewcPj6lol7izTT+pFO4zQJ3CTnUNLAgRmnw=;
 b=kE+A1GwvwlmPHyqbbI5YCC3/7cjjbi0FpK2jJgZ29F09ZdWu+M/YFWutO/g7sNOL8zeUwcl6Q2TUNFDzeynKKVJjkhYt9CqXNUuAKh1IVwOxj1dadXOQ/h4GPjJxRNzuwsOO2Kn4U90PMBoclNE0Xn8mqE5Ud5My+ENJB+1mC+AvgtQC8u8H9EXTC/yOtvV24EDuV8JVn7xdYprZZII/N3km4Qc2HkSU09+TDs2DHt6BAzK/FbT+WoPnwndKh1EEnGuVm8Pec9njITmNBR5RktaxbaVAbfsfXfEaUMdKad95ORGWolx/ww9M2ZAk7GhjBkHmIrHLTeBLWI80fYUkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqUs0R9bewcPj6lol7izTT+pFO4zQJ3CTnUNLAgRmnw=;
 b=ZxWl8EdZhPepgrNC9hCJhySfkM8TDhngHcgI10fiegzLS7k/ZQsaZChkxVFR9P6MU0T/I6Klt9EXojfw2PXkg3xJLm6/5yN0OhShFk9PtoUEbdH4XjAVXoAkRbW99Vq+uTMUtugx9Ymbp6QxNJhLXeD/zt7HUxaC6JJ1YmOgDBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:14:36 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:14:36 +0000
Message-ID: <87eczdpmnn.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] fpga: altera-fpga2sdram: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:14:36 +0000
X-ClientProxiedBy: TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::10) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fcee37-d07b-4349-e2b8-08dd5ac24fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+w3PRU7Bl0b0KCGpbYVFnqFamSoL8i5e3BLeGjXz6BJUfuCijF5lP+AEBVkt?=
 =?us-ascii?Q?9c1GZp6kA++OWWLvd38Q4xAECwE2qHfxF1nbLbszQlJ+oGD7KKsF/JZe+V9v?=
 =?us-ascii?Q?DCnk3lDcU5U7ER9AMj5/Hbi7dQfIpQLtTH5QMZWeBX5VQ7x9zFd4DxHviW+7?=
 =?us-ascii?Q?OxF08gPVw0sBoKkFmYZqQNFncXgguNGAVtAG2ALLlr7UoyYUyLa6y5I1Tf4a?=
 =?us-ascii?Q?l8CI0Rp3ovnIHosDVlScqK334F77edZRpMD/xlkfsosss/15VdZHEQewUPlO?=
 =?us-ascii?Q?WCSoszn4BEE4xniVjcyBDZOsYYZiZbP/w06xLcDl1jXHxhNbStwXokYr9OJc?=
 =?us-ascii?Q?scvE9sNyhS8ciDjBYbT3euAmaMVF/lw1+UH3kixkBaHfVGYRyBn7SuBekS2M?=
 =?us-ascii?Q?cF5AoB7iTnsTU6HeWexJy1DVUNcupxcGX3Swe1umWnPD1yxeWbjgyDExcrF6?=
 =?us-ascii?Q?2ep3WtrkIV1CjWKCChjqg53nlTSu22K83Jh6iMCRvxw0ZjwgqePWg/gsv4ip?=
 =?us-ascii?Q?N0ZGQyrz8MT4M9iEHDJT8ePPYYwzeGsVI7SjZNgW0J0oDOwT7JpPUEMwiJ4T?=
 =?us-ascii?Q?3Dzvj5ZxYFwz4URvRVynt2X4kMrHo3JbchOFWYMwgJ9XxOChZrnk2IRiNvLJ?=
 =?us-ascii?Q?IUHGcxlA5lBMH25KFBz29lf99uw5LdBHFepkzv/4d2xOTRpx2prUj2m5q2Ej?=
 =?us-ascii?Q?nfnXDO5qGmn0sdpnuF7V4v8UIUmndegJTYvMYz7Xn2CBq0iMYTRZ067hMdgn?=
 =?us-ascii?Q?A51VuiTEAra9ErQ4UMI/pqjcsZ+wuXSOdQboOlyu4QR1bZGnw9P17Kj3wdRe?=
 =?us-ascii?Q?aGGN4IVA8rWAyivfl4jKC9cwSiT/dSpWjn9zuWtARpW8wG/rwjQy3R+Lri0p?=
 =?us-ascii?Q?HYjSg0WY8dq7Ey0QtmlJYlsFgNUt8cYZNcxW/uMWmnMFqjXLxI+GdGZWFP6I?=
 =?us-ascii?Q?e7zaqsDZxuT7gyiZv4Rg4j5TKDErHiAraPdm3epNpZKBY5awbHuVE70vQEAT?=
 =?us-ascii?Q?RjNUHyd1MtZdQJ0eOAOwYnzDx32otylFy+GQ3Cjb1R6TjiAXpdl8kn/lM4HK?=
 =?us-ascii?Q?1Ett6TNFQjX50nmKiwD2GsZgsOz6YylRaNUqe7h86GjVyvGgz5o3MUdpqnpq?=
 =?us-ascii?Q?/ALe5lNQmN6zfelUbJIlVgbryPLSm/N3HyMWdaIGYlP1tyHLMSg2BsFYSWtP?=
 =?us-ascii?Q?6oVtSu9BgUqIWwIABaFg76Dcm/MnutrH1ll8v/x+AYUodU+ILWTHMqOrnowZ?=
 =?us-ascii?Q?YIv1o487V1GKfp64mAh/teg3hD1XjUBNjsEktcAfScdkvmuL4XioaVpa4Kgf?=
 =?us-ascii?Q?j7fIC+Ve881YwU6f8dvs/uAmiONBQdhGPrTrMKbFLWxM/H3c2+jzngS2/xih?=
 =?us-ascii?Q?pZW8Pbjw/M0ompTtG+ojW8ypGGlKn8k+gGHk/UFzFuCEQRwiUOJVu02mOIdH?=
 =?us-ascii?Q?GPZSiSmj78yyeAlhKJWfgJ24WJNLMg0o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RjIVIRDFp1YezZn6urjBI/lUYoI8K89q+IXv5w1kfZTiBud5Lt4gFiPNwcR6?=
 =?us-ascii?Q?0WJ2Z5zKkbHY+xFgxvpkaV8IXWfZTEfAGtXDAFeEKOXGoxOy1N5fuNO6Lq/7?=
 =?us-ascii?Q?mH+OsNa0LbOm0rz6DYnDtG21r4jGWypwbfZolY+tlbzu4yNp7idPAKZ1TVzY?=
 =?us-ascii?Q?F6uTo7W9B4LyaJnZ39Nk+3OCIJSMafwrp426op7K6dhBTtUv4oUiLyFqbvJf?=
 =?us-ascii?Q?h7RG6RvE9swQewmTMNyMyFAZFjH8YgaOYw0+I9vE6LSYWhKqoBe/EN2BCn5v?=
 =?us-ascii?Q?KZ4K5MpZuLhWTHJS0Nzwm6j7Fy7To5SiSbbfGxecUsZ2N6yeNHZmk3pO6SNh?=
 =?us-ascii?Q?3BFmlNaSaxEfUgWkiwomDQF45IhuZxYC2ECoLylwA++PF1TOFxDZ8z16T+fu?=
 =?us-ascii?Q?ERHnPM8J7Eh7TpHFcIdGSxkJD3Tyyrgebuwl6T16n5gHUmbLYUeQZ7dRJLlV?=
 =?us-ascii?Q?bHgccgZyLHrPPHEdQkngCWq1AT3LBwg//3CItunQoYaE+fL8QPtjPk7HX4Oe?=
 =?us-ascii?Q?wsKZTg/lpMSNZt6pvOSb0sqDEp+NUoH923rOQm2mkld5I3gETrD4fLrQshd/?=
 =?us-ascii?Q?TcJZcW0626sZvive1S6V49zGkW0E9i/k8cqPfy9rPtoQ8H/Mb7lSwnK+EbaS?=
 =?us-ascii?Q?RUXtY8EuEUFzruGN4JKJe/A48V4dO+NJrvWfGHPkYT0nB+hG8WvnBQjyMqgJ?=
 =?us-ascii?Q?uNGTbRe8rRrBKo0vtZvlL+TiaWaePWZVawo+5XzWAH79tBCq80E0lxb/9wma?=
 =?us-ascii?Q?gTsI1CaI6j/Qe90m3puZq3ByWEcGXA7Rme2RahB0wqbBa9OzFUXbsO/s1aED?=
 =?us-ascii?Q?wgV89VEbRCt2Dvdc8GIXxLnpDN2KqnpkOEWXJao5XEQ1PJQuHW6J6fetrlUI?=
 =?us-ascii?Q?kvpub5nS5PorUEJlntCigf2200dspYCcJy8vnDYpB0xWvYUL1NIWCA9PbdV2?=
 =?us-ascii?Q?xd1KhZOawX5fyRgWkb55KzBX41Suk/c6mx/S5u3iz+x1eqMQYB4P08c/BYPw?=
 =?us-ascii?Q?5vtTYvCrMfQstb4GofZkl7Cv51vjQT2n/6bx1J3fatyNw6A0rUBXs0Hi3k5I?=
 =?us-ascii?Q?w+wH6CJgyOX26l26DwBuNKwrs51cfBMbuJ9cbu0oFgkNsWLPAYtQr6lsCifV?=
 =?us-ascii?Q?nBzKJy2DeuYrZiAJTQOy+FkArOYxaXROEfxud6JfDuBjdFOjlfBqYFSvBQLp?=
 =?us-ascii?Q?r+hCnIB2kTFt2N/XXKjoqhUmM1Sgd+4yAJ9p/HAdkbzkIRfnqMzt+/FVyIuE?=
 =?us-ascii?Q?+EjkJLtvlHJ8F/xuIy/cKodr1tj14Rn+SqmyyKAghC+xNViZoBUgyK5Fak8H?=
 =?us-ascii?Q?IxXMnzbrVPj5uRW+8NVmcW1ihjpOciUtSyMpyVfS86XDBVd/qDdVt1fwUf8O?=
 =?us-ascii?Q?dgZWvG5a/eBxIKO9Hpsfd+IbCSTEoxdAnExxqQx+kr4L88rFQJis5lc2xAOI?=
 =?us-ascii?Q?ZK4AZnev5V305YiBIeaUlcjvrT5/OAeVk4943KLjKCevuDhfeEJ3oQkSn5zR?=
 =?us-ascii?Q?eJDtExpzyBOw8TwyBNWlHtPI0jfpJETFu+n0x6gVjPADbT9uTseicTh5DltQ?=
 =?us-ascii?Q?dI5c6QV7W6tHdJhjpn14zb1Y7Bic5UnqH6fhOoVCVDaxL+zubkj/f0HVcWva?=
 =?us-ascii?Q?Bz940qJXTWo/mUD4ZtzJBz8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fcee37-d07b-4349-e2b8-08dd5ac24fd5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:14:36.8073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kH9ZvCT2F6LfjuahRtPmpv2D8SebSWKamJ6F1mKwLx/eIvTVYHPnC1ZkZQt+7IE413JwJmmT6vUQNrmPHquJNiUR2vfpbX5Suv7MJAna76XjcNa0htYq9j0LRKdHEx6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/fpga/altera-fpga2sdram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index e41492988dd6..720696401044 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
+#include <linux/string_choices.h>
 
 #define ALT_SDR_CTL_FPGAPORTRST_OFST		0x80
 #define ALT_SDR_CTL_FPGAPORTRST_PORTRSTN_MSK	0x00003fff
@@ -129,7 +130,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 			dev_warn(dev, "invalid bridge-enable %u > 1\n", enable);
 		} else {
 			dev_info(dev, "%s bridge\n",
-				 (enable ? "enabling" : "disabling"));
+				 str_enabling_disabling(enable));
 			ret = _alt_fpga2sdram_enable_set(priv, enable);
 			if (ret) {
 				fpga_bridge_unregister(br);
-- 
2.43.0

