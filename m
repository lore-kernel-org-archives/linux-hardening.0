Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010053.outbound.protection.outlook.com [52.101.228.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530821ABA4
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548186; cv=fail; b=d9W+GLaYC5xPFYn4savbQRPuIkbwZfKijmVw2bKnsIQg+IXG3NTCMDulrYkRgRFLQJ7xEwkUFjHC/cqyzLCNnGRLoxeCvPFJnhGf3tF8NkfvqPrtunmHUueRuzUjl0Ip/hJa6oBweNcJLmdJ2SZyet9doZHPvrYlXfkbPQzT8FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548186; c=relaxed/simple;
	bh=ovUqtYsrQv2CTVdOJRlFpqDAiX77psSGAgilgVcsFZw=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ZyeixR2b2r2DA7plFRrRR4Bqa1ogEksIYIhuKiuWkOgsxbBjG51xiPmiwE7uPOMF0W4r8O+3hNLDNMGo7FYRxNjUxHe/4akzkJ0wYEc0sC2aZgmgpNU9SQYFKd1TjLSiykvuOdt6IDp3F8NSt8OLt3QpbqaBJl0s6FT8ElccJKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=S0zckpBY; arc=fail smtp.client-ip=52.101.228.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="S0zckpBY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCWRHxOyCKwmz0RRlig19wKpTm7UZVsYBXu7pX5VZRxed6tXv/FR8qDA8GBOEU8wXmw3tl/NdfMp1+0w+2nJWIo+A6X7dXtjDc3VORkj0xOa8ct24M9gN4R9R5Mo/VFhkF/+gDlb3jl61vamszUVGYcJSsR18+E7OfJwNUmoCHw6kh1qh/WR4M8vOjXvgqte7xMQ2zqwQbmeYndumliRMijd599t/yzS4Kh3ZJvy6jeoMEj4tkfODm5iT5/WB098bhJMpaEV589Fd0oRupO6WcjCXKrOKnfflodYBXufYOYyydJp7YqOQjWVigFWgfUjNYwmf3ytarIXNEucFRkHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYi489JyylepSFNSXO3t6OWWRhr2SNtbjCP2WCQw6oI=;
 b=Va09zb4GLTT8QO/sv3qtkaJ8uRe4X0fMK8656NkAD04FgTRJUlV08LGvmAvwipgYL9wbzn7DXSQeW2Bfm5jPuADmN//NHLiRS8LvWTyj4KDfSGUMeXYN6evD8bL/HMFeqI8Gss7izHP5cifyoZkQ4Bzqn1TqYQ5XdBQasRKieUfbIug+DdLOIkA1becNVxkPk+a68Mfe3WqT0oHF2mpm22pJ/C3CZRztIjrmH03Kw8OHvfbviYu+6UUqPTY0Sa+quM+oEeVW4QhFyex1kYyrjTmk5IBwna5D/mU7XJsBjrTp2HDFbuzyzfighWxXltZqrER1pR0+vTq+erKe2hsrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYi489JyylepSFNSXO3t6OWWRhr2SNtbjCP2WCQw6oI=;
 b=S0zckpBY6JuL2tGQmkQ8cR+vT8VLmWZXQ2qk+MTaZ00L/hToDCcAbNW4U5WTEEiKoAJu86LkJRezWZTWS76vqkLpPAiwfbbBU5BHte8QvwswSDHYHIhziElWuMfXW/At1r4IEtUap1Vy6uge9GecygbqA663bRQmyPL2YugvImk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY1PR01MB10688.jpnprd01.prod.outlook.com
 (2603:1096:400:327::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 05:36:21 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:35:46 +0000
Message-ID: <87v7sx6zf1.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>, Kees Cook
	<kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 01/10] lib/string_choices: Add str_tx_rx() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:35:46 +0000
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY1PR01MB10688:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ef1c9a-52bb-4b01-ad2b-08dd56276b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LTnLDqpo5ee5t6WMxBgxRGhxml41/GBAykYSRGbfr5JFCg5CoZ46/rtMxBGm?=
 =?us-ascii?Q?GCpX8sMUGr95HWHgx11PlTxh7gnyH1s+o8EQw87K5g/GXSQfInmECkdVKXia?=
 =?us-ascii?Q?eDNWSnaqBnVZ83Q+rYPfZBr/NuGcMvTrODYir+aV9lDNZQZGaBf70rYbeIIC?=
 =?us-ascii?Q?wECIogrwR6KKKTreK86KFnnf3ZahefXAI5bp9HVNvWBjPGCBHsm4GWgRwcFp?=
 =?us-ascii?Q?CUXYj2qhv31AnSzorTz4pRmjgjOMNXhBHSd7U6M7eicHX/v10vzZ7Vko/gPS?=
 =?us-ascii?Q?Wc/NQ4SQy09CIk8ZOwjaZZcBM3MEy4BD0IZGiI/rck0vnNU4D1GRNQPsZRKz?=
 =?us-ascii?Q?78Vx9yuK32xkOk8k/MWilpcat4IfrKkxSZ6xS/2ev+Bv5JoCuXJDaRIG2loe?=
 =?us-ascii?Q?yBKziUGCvclQF3rmIFZTe81qyQlGoL4eg7IP8G17Sv/qV0w0b2+BdtNqU87B?=
 =?us-ascii?Q?iKZoKm0LxC/66IMAUe11zFi7s9VKUKUWYgC4FhKb8ELSG/+9KRXDN6jWmiOq?=
 =?us-ascii?Q?2Rcj77LK3jaWy6eZg6rZqH5S/UAXpgX6XDsRcUp+ClnKuVaAV9bz629b05xO?=
 =?us-ascii?Q?ATv+kOu246rn8X+Im/7gMO3IkK0H+fo4q9dFhYSAoRXvK/QDXUoJCzwB81Pw?=
 =?us-ascii?Q?UZ3jy+JtJj5X9o6jpJRRRSp0m6a++XrHC6+gmsF2/ishK3k6LKQpjxy5qe52?=
 =?us-ascii?Q?A7agdUJEDjDZScNm+qvWlTeEzcl5vVeKkq+UpiwdiJeKaFgBfdVkICfn6Ciw?=
 =?us-ascii?Q?whSY+xXuBFddT59KsE0fzOWuuhNSIR8UhVNVt+jufzVcSN9cbirbkQG7/Mf1?=
 =?us-ascii?Q?V0tWJoFPv3WHdCK9INe7Hsq72DGwq+rIwOGmCKW3Ra55da6I99U77lv6KGc3?=
 =?us-ascii?Q?K978Z0mPpj+biNaT1ohZVsOTEy5HjHBOrPSZOz2VESOIzrefT9P2SKkUhlTm?=
 =?us-ascii?Q?e49aAG460HZpFy6HIXH13Xj9MI39W+iLpwkblGDmTAygwhbCASoFySfli1mj?=
 =?us-ascii?Q?3fpWhkRzDdS7sSXF29u4zbAPiQI94MW3zomhn6+kL6/hpZgpbRKsxqUwHscR?=
 =?us-ascii?Q?5JO2s0qUnzPhdS1lXV8rwD9xVNWzVSGQ6ARw/kB7nA4pXAYUgOriXHUAAvGB?=
 =?us-ascii?Q?papHm4PEZQU/u2l9dR2i/Gyp1XQIiIFUJW/xHhIMug1yyGuJ5DzdsLjEDxDj?=
 =?us-ascii?Q?DEyszyM7+8OKljDJrxatdLe/eNpvsij9XeRmXTcjQJOjIxX9IVcIUE5YDO/F?=
 =?us-ascii?Q?AV7E7wqsMP++JiopclYPdhvMkoffHUiWv736DI+1pacsHm0z2aTUP+57lvdy?=
 =?us-ascii?Q?NE0EnK5Mz7dhgm6n8reJnFdJ6qhoL0Bm4ouPGyZjk93hhVHUQlRiXqoWEIWl?=
 =?us-ascii?Q?ICToXVELS6PylZSHKuoH5GZcP29W1KjavfCux15Sa3cKyqSKJJdoEVcB4Ehi?=
 =?us-ascii?Q?Dh+sXR3bWIIuLSTiNSYu7KMErgQh/x1E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tbkiMtCO+98UFQGf/NXPmWNwH7rpbwAZOd72BX8ImCVIgjDfXO5BwMMCt0ht?=
 =?us-ascii?Q?WTQ6lVwiP8Pm2rqOT3/hZ22+JipE4Z0pyGz7rXU9GVmR6DI8ktb/gqvxGjKi?=
 =?us-ascii?Q?StRFIDlu207XsUIoD+KJAYMv4QjhgqNYsNBsQYzYtF6vaGZlllQBN+sDdjWs?=
 =?us-ascii?Q?JGr65nh547Wkt4+n+wWVA4Brm3FA1aQO23TcjqsRFHOAOyu+L41W13gQj3q+?=
 =?us-ascii?Q?fxwHx6SJ5VIALxGbedoJ7stpCQwvXK7wC/njqiyKO12zOxdkx9yVHKB8Qzv6?=
 =?us-ascii?Q?ZQrx/35qpRvsAr879RXsyoLUlRxxK/mlKe8sp22IApF4vGhENKowp9nTCU1/?=
 =?us-ascii?Q?pkKsdNgNjYKYs9WvS/r9SfElKos1fbX7sPayV8CnE+MS+5WXxfw9asMmZuAK?=
 =?us-ascii?Q?w1aGOh1Um4/oCnSJ2KfKjeB/HU6BkhIa0by5cZksQgDEGAkJImPR5u57mv9I?=
 =?us-ascii?Q?domEsYhJi/XimjqZHwnzLFsVnW0lZ0g0A5cXR8KQvE08e/pxkfTUaO/l4Q78?=
 =?us-ascii?Q?gxAS3++ksTPpwlEKtTcEKP4uXJ/38UHbwhWY998/SXZxBRHHthyXb/w0NAsK?=
 =?us-ascii?Q?vvyNz7IyV9ejZInt9uEttKcoCiDPynjQ8+jbwRDYM9cj8syayTN0p7klWIgz?=
 =?us-ascii?Q?08nVsFFLZt0zn+3zumVv9Jzznj83rvUKFUcVYIm/x9bLbfCbE2gRkX0Atp2X?=
 =?us-ascii?Q?2b4TDKGDY+PtKbLEs1Om679XdWOAuLCiXVCac/2LyZ1LbbSMG7iAcmJzEZPm?=
 =?us-ascii?Q?UPuKKTcsu2/5ProizIFv37lq5BPUuvr7S4hUA94xKqbcpu7MMyz7+3XvZaYj?=
 =?us-ascii?Q?GQkEsfbDenKWtmELweQ0HqLnjF+Vq4k44oY+zEEP0F7aJv/uGsA+QLIGg6gK?=
 =?us-ascii?Q?AwUO31Q8mddvkDaG+aaSPmpXIog2JJnzyNSUSww6HUCWqYwQJu7Nw8FkWvPH?=
 =?us-ascii?Q?f4b0lZetVgUzxB6JJPlrbe1V2aGp7ulDlxk0C6Xl747S6dwDpLBpYyn4jnz9?=
 =?us-ascii?Q?YNurRLX3/147xRYXfzVoqqMHHyMhqiuagvroHSP6QIpjN1p4Z7eMHcGnKEMT?=
 =?us-ascii?Q?3pSfZ0JimbrpEJpqI7HJYpxB7ZOLuDGm+ChXjLtWLEdid4kxk7sWkrBMEkUG?=
 =?us-ascii?Q?R2YK7QpER+ry3MJEFXjeF1L+QBL0cTMDCzI9dFkSr56moRs5I2RXxp5XPviz?=
 =?us-ascii?Q?bdfrJIoXPZMveP/VX03cbXL93v4QjIaAJ5EnAFmpwymbpsdIFGKRXVAPmIJm?=
 =?us-ascii?Q?JB+opGdX0ODLEqhqojywSAT/hXx4sefuZCz2IYjCFotx6yzyfDc1Ta+BbvGD?=
 =?us-ascii?Q?1wDtLKGt7ps7eMz4A0uwxbYsQKe9RA28bhb9FTdBpfPJ9CPVGfg31Fy9PxlI?=
 =?us-ascii?Q?lurG6gMmK5RpFyoyj/1gNTvePKVpA41gyABqqNXT4JUx/yj7dd6WJDjcu6TC?=
 =?us-ascii?Q?2AFpIqlc0lV95W76X3Da6b7pmKMQuPyIHte7yeVrmFFD7Gm1WONEQfDyvZPj?=
 =?us-ascii?Q?Of5IazPaeyg4E9Wj5CHXGv7PhqhRX8Yzxz0/hbc9MpStXccA3HnCwXKF1KXD?=
 =?us-ascii?Q?1N+6XlakipcTGA/CsMc2R58OPO+kkaAEO93MnjYXnp/aL7JGhPm6Jlf+Nf55?=
 =?us-ascii?Q?+REjQbmbRJ2qA/7I7kx4Paw=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ef1c9a-52bb-4b01-ad2b-08dd56276b92
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:35:46.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpeitDJ6ZyBedLHfAnAApA+npd1jnpk/jWAvPVv9IIQOXshKSwLQ+/Lpo8KpKC81Br6UURfbebjTmVhyCYtwmcdGRIsKzSNb098dm6GwySQD2ZhrR38F+iMsZQ0c8iI5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10688

Add str_tx_rx() helper to return "tx" or "rx" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 120ca0f28e95..fbbf1e657806 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -71,6 +71,12 @@ static inline const char *str_true_false(bool v)
 }
 #define str_false_true(v)		str_true_false(!(v))
 
+static inline const char *str_tx_rx(bool v)
+{
+	return v ? "tx" : "rx";
+}
+#define str_rx_tx(v)		str_tx_rx(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

