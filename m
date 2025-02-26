Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B125D537
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548191; cv=fail; b=l0MVEb7tWthF0WcjCK4+U4S1kk/5YCO+vn20yZjwUs4Epu4nQPmuIhxBRl8bqhdwgtRfww8CXD6oPCUgEenRwVXy6ubLr824sEYyfCOU7Ta8Mk2qvPPzEDfrLs/QcNNwX7l/F8N+OGdPfKfSu2mLXWgB0lhL6hOa9LFPtq7x/U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548191; c=relaxed/simple;
	bh=db+xrlxM8o8tMb12tYIv4bqw8kCI1tDlODy2NNKYtJ0=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=B8WQzTpA0UMsDQdz/kV0nSQKRA8ugxUea7+SFlG/j7RRkfYQnh5/aPxvgaBKttKHkmnEpFV7ICWPAAsFYVIpf0qgiLcluL28y0LFt8EspHsF/2jEnP43F16bHF5N0SOyWN8CTh/DxcgCnzUm4eSJ8GeWlKMsfSFHJ5VghGGZcRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JYjRSGsZ; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JYjRSGsZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGJ2z1OVqSsUyeATeVfyB3BTwdyfeb4nOmiXczVK2mHbOdW2sU9H+4qzZwpDv6/UcyvIQdHMwv/l3Ep/tmX7xwYMkw2cE7yB//35nUfH9xCxSWR5W0LFspOPWmOEFHTqGbGv6Jhrjrn83aN9i1H9ayyMvBmNu1g3UD9LoKOkMxrDHVrBOy9WL1gWUQ5se0c4OuUEvJGi7iaMRcToW0F2SR+prAuQyQOAaySbB0mtPOICYRv61Kr+v0UTPmlbevusj31Ed4/ekcNf40bn1YtrGDVnlCS5W8bxr6TOSVlk6E+UCKybpwRFVUDM98tsTcV6hGt2rzRsU+EWS3/PwO0KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thgO2IDWH16GCdzE8kiQgSaVCwVDfs6NOtfFq0Zocuo=;
 b=hDD0SiAFMf7rwD1cy1X2FOlc+YQVwmvM/7y9NQMNVqHH0psQu3dbpJBUUXaoo9tQG7ZgMKpb2xYPf05B2Rf9e0NmKAGO+aM3aLz++2rpeLSzP+jDHSb4kanHjhSfdxfQV6p7f8FLInkuMslL7/7nyY+Rd2CVYZXk8TvxJJ0WK0x7ipLECHUKtrDy8DNJcAW1LFAAh4mbHPgRM/a13LDBeRtqTmohvL0w8KRVfTs1tnj06iFWUC2EhkAR47oHxFqH/pTtgGGTSBI//L3tTd8V5hSiOBC4nOE9HHx9aERkh/0N90TEp8cyRnZENTmSlWCShZwZ0Bj5BjkdwpWAaylZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thgO2IDWH16GCdzE8kiQgSaVCwVDfs6NOtfFq0Zocuo=;
 b=JYjRSGsZM0xPueyVi5XM1hx0OfhpCAcj5OM12CCsdY8JUDeiVGDYMtTJor4M4fg0DeOJ48/5yG3X3sdSV00wZZN20GNfSCQqZ4Hia2XEgDk10uHky/YwAS/u6EvertIpR4h+dV3njraRAdeDs/mOGPcGsVxX32axpe0DI80xylg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12800.jpnprd01.prod.outlook.com
 (2603:1096:604:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 05:36:24 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:36:24 +0000
Message-ID: <87mse96ze3.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 08/10] lib/string_choices: Add str_level_edge() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:36:21 +0000
X-ClientProxiedBy: TY2PR06CA0037.apcprd06.prod.outlook.com
 (2603:1096:404:2e::25) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12800:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fa279c-62b8-44bf-e7a8-08dd5627803b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1BWaWxZ+akHui2yfiQzDaAg1OAl8WTpddfR02qb0y9nPdwrWCOiYi/lNCgIP?=
 =?us-ascii?Q?+YVQrlOuJetLsjlI9eru/xd7bw23Mlu7SiBgG1ntFbnLsoqGxZBBxemshLnI?=
 =?us-ascii?Q?GC8/zIi//HGwoMKa6be1QgYfmZ11Iqu/KnTzgYUSGE0VYCzgnmcE4jrkMcxJ?=
 =?us-ascii?Q?3+fmyhborAxRcrztpyRvqrDikH6vdT65vZcHTV2g5trU5ZLaDlYgUvMR2xHq?=
 =?us-ascii?Q?Y+MmiO6s3BvJe+x7mBgC8KQuKDSbIYHPI0gL3hfUIAvwuU7Nx7VvRHnrYzrK?=
 =?us-ascii?Q?HmTat4VFbtVkKKje2x5maZRL0DXHrxfptwr8PWMO2QjG7Z/qu/k62C4hE+iQ?=
 =?us-ascii?Q?jyrYrG0j+gWqLIH9yl2EV52SJY4ao5z06G3EAHxEnEITdve7M9ReP8od8WEB?=
 =?us-ascii?Q?hNoLIxrEtl/PIKTuDuiuUKLMSRCxQRUeW1wpmVA8vDyBCTzw1JKIPTdZhGbF?=
 =?us-ascii?Q?VLvGu6QEbLDpO3fM3K1rnxaOAEplePrNW85ff5dCrR3Oay+NVyXNIg/ipOQo?=
 =?us-ascii?Q?gyJu+qLfQYofopJEjokE8HpnkBKnOldeM2Qy/HpPPYYNjZo1oQGtzXXGdCAD?=
 =?us-ascii?Q?s7khs9kOHWzYO5iG35sW26ZLh9HyfqzDjjhxP5lfeXY8UU07Hl9h+z7DUMd0?=
 =?us-ascii?Q?fW0iiMP4iBCGYU8Rsr5JClepjUseKQp4rY2L4rHN/RbJMWAKCUYZ9Hq7dSyA?=
 =?us-ascii?Q?MG9Uj03PNtoYXwOEQhlu0/cJr0fmJdhmCMMIY+yW+c6fUSMAXWMm2CdA2NUk?=
 =?us-ascii?Q?wOGg6Pt6+egeqosKvnfy0lm8T3TgogDHVl3JWMwKzgV0/jU5ZXs/+LstnCvE?=
 =?us-ascii?Q?iKrLtNKLlKdRMRZF5HdqulOfiak9IA+6+cpZXPOSAvmmULL6A3Q/RzADIM2M?=
 =?us-ascii?Q?hrSExM7aTgLykRHP992m93SPFo1BvB6qmc6K28d8GOzbsPPpVrtYO3A4oCrb?=
 =?us-ascii?Q?4TzZBfxmDNVvYsVlMg0yBloKNGR8lSnGT6TI2tI0ya9yDdj6hA+XgYb9+SAZ?=
 =?us-ascii?Q?1yBY65lFPGM5SFwP/gUw7knY56/Vd0ch4y2gwwd+WR6LRV2mbP7c6k9ScJy9?=
 =?us-ascii?Q?la9zu+ukOxkbbfwkpJ1yOm2O9OKzLHJLe2aEkN+3MTs+Ef0wwY38Ki66vdFc?=
 =?us-ascii?Q?vz2cE80Ob8hyqDp0EOSoTWACaZlE39u2CC70xYQF5cYk9/4Q6uTzXOCKnFYJ?=
 =?us-ascii?Q?3RorLXINk9Fj1D+g4OwLWF+mLj17sXLRKJ1pUTtcz4F3FjmfEZ8Ir3sr1zDx?=
 =?us-ascii?Q?LKo7jg4y/TLpH8uoVjJG6eMGu4a7HVlQ9Y85xYFgpVUPEAgO4xgAHxkeL4Sd?=
 =?us-ascii?Q?uhxHAm7ozeZ+6TmhHaUjJOSj+hI7v3Nh20VSAvkQaeIPYYsCQWxx3VuzR+Ms?=
 =?us-ascii?Q?DKX3JpBfMALtYfuwkAeDuwlgycl6yMqXRM7ORr7PeMWBCwmZGJc+VDMbBOwf?=
 =?us-ascii?Q?KZQDd/RjXRHyBVdFHFqntdvpR+TrB7EN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JAEtjtgs1ML2RJ3biigk8sWtxYeU//+ZHvxd4RTzt/BsmdHfJf0+7ZMR+kRw?=
 =?us-ascii?Q?o6kV06pHCJySEkN4523fX5DuzyLKxUQRCdEO9tOSKwfYGkiHerU4bTD8/Go3?=
 =?us-ascii?Q?a25ndBlQ4LLikV65VVfByJVY3qVSsiwSozLjhv+hxRv6pv8XUS0PfQuBSn31?=
 =?us-ascii?Q?t5/0LUVFsV2uk//PUzZb757DFV8/qhA4ewE5tYGiiEBabRJJhpRaT2Jt89xI?=
 =?us-ascii?Q?VGkXAGL0ZgGuxSF8p4Hrujmiy5jv0Zwshj5mDqyOAtA0lNkFkobHlkHukU3R?=
 =?us-ascii?Q?+vtVlo9kRkSteMBP9z0od3yRvmv2q24FA/8QM31c8Gjzm3Z+VTWUQ014oHXF?=
 =?us-ascii?Q?eOF1TndCTt6KrYiK92xj0GnTlqzlGDaZFr5llWO6kplaSWcl62INH7JZtnGZ?=
 =?us-ascii?Q?dEPvRuEcj/jVTxdq0+fRC1zwTfcXcCxuwl2ugJzMsUgTKDyfacWYJZqAqleI?=
 =?us-ascii?Q?5jkit+Cg3ibXHkOsXhtyOgZcilJN/yDENzM6njpw9Qoe7TcTjX7qdae2mIr4?=
 =?us-ascii?Q?8DeJSYlgiuQ0Rb3kk7n8mvrpl3NCHmOwDnREQRk/2qlb3NoA+wal1L/kP20j?=
 =?us-ascii?Q?yFl1fc+VBdW8HkPwwsSlfdlaKr6OPBYHS+UPCsI6o9NN2VFrtm62XPqUwGSj?=
 =?us-ascii?Q?ZkVjueF7Ig8HCu9UBkqNv9dpbrjiMTyjgeLDivkQjBqfEoaOXnNPmNEaPPH1?=
 =?us-ascii?Q?lLIS81kNgCxsfeztDQw4fQz8lbRNrFTStCNcjpzf2kotxUgsYnWcgXANbFlm?=
 =?us-ascii?Q?PcIs/P7hwdkGAZBgsnIYNEwhoOdxYijKc0GWajcqI9Jf+VAQVoegrQUiWILu?=
 =?us-ascii?Q?kYZiD32mewm7/koXqZuemkgrjnsDv7iFvvXp6+Qtr+HXRWwrZeosh2omljjl?=
 =?us-ascii?Q?yO4n2WKqHxhh2Opd8d3rPDr9AXIEIXx0dZbZQTiIthMd4+91VYQs3ooOyczO?=
 =?us-ascii?Q?tT3ALMiAeSoNlPWNiYGC9y2KdKRK/J4hLCg0FtaN7Kz9BeE58GuyUL9Yfcs3?=
 =?us-ascii?Q?Jmfxx1Vgl4xh8s+kcbsDMvNz0f5wm7mwN+ZMwaBVXIwMrhGut3yLUFkh0QcX?=
 =?us-ascii?Q?oX8D8vyk6EZ059nRPqgnOxlYmYhQDkqt6/5V31o9ShIH14FqDGPHg039FXRO?=
 =?us-ascii?Q?erKtbnrPv3dnwP7pxFS17EG5b/ydJVUW/CjJzGccDOai/khuy4doWdfOAygD?=
 =?us-ascii?Q?jyVPRBBYzGZrPolkEsvPBbsZAsAvs6kgAocaOgdtdtjz7eLJ0JmpYKiyxmnm?=
 =?us-ascii?Q?pH80MOqBSQsdy81/s0gCmEE6dFjBIDAQF0i8slVLu36DQjP3ZyDfD36qXUN9?=
 =?us-ascii?Q?/ybenyM/WR5xwYghYuLBX7crCu28N6e2p2ssSW1kcvVuWgpMXA0H2cPpdRYG?=
 =?us-ascii?Q?sZuZt7PyVcNRPB82YaF03qb80Wm/0eUR4CHTY1HRrQrGLs9vuXdjoj9AlRkp?=
 =?us-ascii?Q?TkkWtdeQdxmfEcpqwUVK6jrcbPcfzX0PSA+CibET+tcUYeWK5Z4ebbOQ2j5b?=
 =?us-ascii?Q?9p/FsooGaBRYYeHFaaWcjKUEa5WHeQyqbHoS+muxQfAChtowDvpSurkweynF?=
 =?us-ascii?Q?TblWw80J1Lp0G4umlitKRRmrz4Xt7SgkKuBrMd96pv6ZP9gxkXjASIDZntwL?=
 =?us-ascii?Q?fsm4ZL2JJZQFqOoQIPZrkLA=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fa279c-62b8-44bf-e7a8-08dd5627803b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:36:21.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSUizNRFBqKZ0UbWyyepX9LL1KRuB4tYJD3c1ZF+a9qPUf2+nWACPRE9n/ljvaEsRAeBk+uW0ZH4O7y+9AIt7LtWdHET/s6MCueXLzexUHuWWl5uW9rJKRGjcZfRPGQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12800

Add str_level_edge() helper to return "level" or "edge" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index e07a9a5e403e..1965d3a5976b 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -113,6 +113,12 @@ static inline const char *str_to_from(bool v)
 }
 #define str_from_to(v)		str_to_from(!(v))
 
+static inline const char *str_level_edge(bool v)
+{
+	return v ? "level" : "edge";
+}
+#define str_edge_level(v)	str_level_edge(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

