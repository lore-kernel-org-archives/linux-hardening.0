Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010026.outbound.protection.outlook.com [52.101.229.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242DC13B58B
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054466; cv=fail; b=sGbWEusiBKL05lRwrTJ7ZNJbPcqf/Xq6FdT5BB7emmxPfWYxe0v8EBvWLOi2CLCVeWXmASsCehof+y6dlWB5nMqW4edBQs6leXcxQFuteJqSGPwBoUNJUGuRe971uKqc1QcEvMtHLWSJxu8RtUxU/AFuK29yHy7wk+fW6hiPqIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054466; c=relaxed/simple;
	bh=T4fkUQ9lYI3aCfIH4NQFAF68NHTdjpXBzr/Z6b2x20Y=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=DI9/8V39/bDN/B5PqfT0kBmQ3owlO5kRXfNRZzX0/jXZpRh73yo6tQwo4KOLvGrOlfxRmZOXACXyjbQeNs21iiC8X2jQ7vFH7N+/PH5+C7YBffKxNEd7esKxsTIi+RwCdrJA7TpHkMEWs3k0sKSb7n9hnEhVn1JJ46PGR25RE80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dI+pFfpk; arc=fail smtp.client-ip=52.101.229.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dI+pFfpk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsVk5EV7R7T1j01VtaWLZbGPXbzUIR44v3yKTCGdzSaIZgu8ZvxpnuGsAYc9F2MH2+NuTIKXthBApUW4jZLYcCijJfOTEtVGkOkZQKhe+wtqJfyCQgmLkK1F6ElyzDmS0h/ty/QXm4FCs6wlt0Lhrk/9RFhXKMrd+IELizCIPFsZs/TC68MWktS31NfXtlYIONDpe5HliVTLfEz31ZO1TEX8gbgEmqZAmoyht00317BKsaSi3VUIudPIpg5Ay4D4ZbZbUnR0MIUS1A1nVatiIqpPzT0w2hU9pb9llHpp8aN/a1bcrWpPP3BaBm51T7oKCdG87D0b15x2hdaSZlojOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVf3iZX8eiIzKNEfdToKqcqoLLb5fVXCWZTfo3AcBbc=;
 b=xIGFPebIy14HNz3xcfLZmdclZjTY0mVrff4B7zq+i9Xl6sydnziGPEE/20pO14t1oP1ypvY8OLW++UR/pVC+emVJfODI2khGgaxaAMUSzYB3uiNhchIExKHGUoal+KnKkhlrc/vL2A5EX6GhbvoGTkT3uITvmFAwLqFf9VDS1uYz0K2a/Y9KIrMxLwJHcHxB2vr6YttSeN9HTJw77Ybzcc8E+4RVmUhmrfT0sH1ytaLw+XZp7hTGw+RKUgih9eOjqB8zM7JmnInFOHrXQNR2j0g1DswqtJbzNQ+A7k3tPyMxtN4skJyQAHzsDeGLChD0JFtk9YydiNhajgJWJDHfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVf3iZX8eiIzKNEfdToKqcqoLLb5fVXCWZTfo3AcBbc=;
 b=dI+pFfpkxLT2C9uHEi2GZDI79BpCle+WgRment/sMuGtn0BSvkIqEQ0SCyr4yqN1zHyBZ10rDz3rsk+4kFD8Mf+EdsayjEsUHul7pN6GIKbv3dU4aSBhXgrh+JHTfaTK38CjHphOOVivNSOYsvA0eCfQwlEp8NkPqcX1AFvd4hQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:14:23 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:14:22 +0000
Message-ID: <87frjtpmo1.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] usb: musb: tusb6010: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:14:22 +0000
X-ClientProxiedBy: TYCP286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: b98a7562-e27c-4633-72e2-08dd5ac24791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P4YqCVO0EDBx0RquiGtFONNScd7OZi02VQOSjipi7Vs3MGfehKiHxZqQgCF6?=
 =?us-ascii?Q?oDiTj0UpN4b32uv5JyCy8444X5GvWfUc6lRHHKsf3pxOmy19zNAUdKQOW5Du?=
 =?us-ascii?Q?LtLqDy5kjUio49AlWzbqG+IogMpwPioqX7TKgMFZXwsg+vUSUCPO43HPzhuc?=
 =?us-ascii?Q?JPH7SKLFod0+SBXKlYZiZaUNTYTUgoOFL67DIzvcithXyOwJzlcza94cG+GT?=
 =?us-ascii?Q?9kM1/c+at/QQS+83hsP08fFZImxs5aA2eVc2hdPNY5NzpQ2qEIo7IUImlOjh?=
 =?us-ascii?Q?iS0BR1FQx26wcf38MDX4IYtq9T+VgHXRQwDzwEN0vPC1t0yNfTRkzgOUDPrW?=
 =?us-ascii?Q?oTpPeFIwxZWvR2+eaBPGmsJDcwsWbOtybOFUCJC1VV84vQ4ZuNgNjNTBAcv9?=
 =?us-ascii?Q?Hw3N/zSDCdlCoG3ABAhiso1yRDyHpvVQqykmJN2l+hH7mcYeOn5gawmeK7kl?=
 =?us-ascii?Q?YabKtZQ189UqBd1ll6h3JlBzvLea1m6H+ZSMnM/+k3xdMSVQFu1DT7m4gXWc?=
 =?us-ascii?Q?eDJ33BcaLOTHlRBLOxb4ZJ1piBUovAaXp7GeAVewnN/rHeXWx8MdI+janVA8?=
 =?us-ascii?Q?QxPDjh7M9qk/59ut+HngMkVNJrNCtgCBhzqsmVpcMH+P3oZRlhJainVQ7Qys?=
 =?us-ascii?Q?975yYgkpIiJ4CJFdDZW+1eDVMVETCmMrzF4aHMxKUQEg8G9IrMYVpTFYnmWS?=
 =?us-ascii?Q?yytTPH08PMqv8hRx60I03BTI4gw6SOaM8Se3lSK74DEvM8gXy9fM+UedWt20?=
 =?us-ascii?Q?sY7rVWfXMvfVBCEmxydB5Dqiyz88iS9He0Bnk1qNsM9NQUP9mFW3345IXHt7?=
 =?us-ascii?Q?3GMNsI1w+zJF1NduuDXo77mIv2LHzhb0NiSl1rbn6pwQ6doCEihylhRRK9+/?=
 =?us-ascii?Q?NF9C6LpY228rrhghfic55ybiNOi1rCz5JDSKh3SC1BEWMlQx54XEs90/AXO9?=
 =?us-ascii?Q?M/SVr8V00JpaEFM9JYCLmrtP7xyBj+kDbOFtePFkrfBPQxk3YO+RNSuw2zZ+?=
 =?us-ascii?Q?fEb8vhyU/RAeSk53V6QNRQo95Bn/586njof6THroRuhHTodlRB78zk56fjS8?=
 =?us-ascii?Q?uTQu6LjqrqPenAKaE6bPUkt7l1RpfU3fx4NAE2e/fPY6s757HICINwCZpN8Q?=
 =?us-ascii?Q?oH8/IiWTtgheehh0Aql5oW3Ly+Nlrur3z5sNrHOHMCsLB2BRLx6DSyk1b/Bw?=
 =?us-ascii?Q?mMhO+ngWifgnuCuCeA8J0suH6nUaaJuhKQSdh7R+oG4ZW8MumCURZgmoMVF/?=
 =?us-ascii?Q?imWDXGjS1N9SdPBhIAnCpfqbUtkbfEXcE3j12ZQAj4DvR3XZBTGs496qA6y3?=
 =?us-ascii?Q?b4x54H4BFD8u08TSoYqQ8sTb4dH1q6qpMy4DcvuUn7a7OEy5Vm3Y2bLuUhzM?=
 =?us-ascii?Q?oO9TvUsEMqGLoYRI+0YUw7ynVf1CPRl1DEKwefCh72ZwMYbd/EUswmMa5vvo?=
 =?us-ascii?Q?07CGMuYZ3fAXCcPqu5GaS5OmQBi8n0lr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nw5cKRVkWQPniOmo5Dt1xCRBFNmGYZpfK9br+s16jc7EhXTYwhtwCH1vdet8?=
 =?us-ascii?Q?4ZRLGacM7jXwRKtYRNB8OabZ/bd22TDYq4Drj6sxvf4hhz2QNAfHnVwr+JLE?=
 =?us-ascii?Q?lVWN2E9fM8g5yTAJjaNPMmC4tOoXgQLYLZiraMRgsCib+QMv/57z0xCJMsFc?=
 =?us-ascii?Q?rNQxAqzQtT7cJQU65z4yizJH6sUysliXG6kXT0imye3S+NZIueTAY9eO+zec?=
 =?us-ascii?Q?aPpPlII3PP73uenpM6lVSgTFIxs51mrISSfdmzzrGcYYiOfZ5vjGXQE7XHdI?=
 =?us-ascii?Q?22HRvd6uY99lToDlw/q+xqw1pK9aBUVaLaIFt/rgXjmOUswigcLH/zjGq5f0?=
 =?us-ascii?Q?sUv+QS6Mwq+gjWu11iZ2vTCWnpFXZtzLl7aXota5cNQIsYI0kIwZ7zQT48SE?=
 =?us-ascii?Q?BFuBn7+utPwSIlUH9qOjeQ3iGu8heS9KUeAw6BFibU1R5j1moPvoA3hM0qZn?=
 =?us-ascii?Q?eHv5FYC2SEoggtthkFbWA8JoTxItB4ELyxPTszV1zybbv/aXaMsXFOb8oFKR?=
 =?us-ascii?Q?Eg7KY2L76BPmIwJzNSJOIjY5l4lGIn6dv/zWgTD3BJ72n17YkUPqNz69VlaO?=
 =?us-ascii?Q?yT5nZhfQ60HrYG9CFP/9UmLZXpSNpfMPFt/29ycBtwtnEjHcNhgSYt+vCER7?=
 =?us-ascii?Q?+XYwPr/yOrnY9pQG6SwKP8kjt2AM/QyXVdaDqg0OCGyvt3gVIF9ngetOBx4j?=
 =?us-ascii?Q?IPsSPfr0WyrIK1gfcy5LwJHsHd/Mc5BKXnh/T6AYNhHWZFRndwwLLnk56/e0?=
 =?us-ascii?Q?HgAx+vPSpLCiL/xKQqCFG3zkV2uQ+dAwV2ljU5c4cdTG2ZMLRLncfeOdGUZg?=
 =?us-ascii?Q?RYW/R+B5g9H2Vd64T8Dhe6tKL76l3sSvbnp/Z7gfX7swpIlmgTExexbFg4mC?=
 =?us-ascii?Q?erDtPzjoPfUitoOqD2oYYR51tDwL1IOzxXsqVoLHCw6fof9Wdah3J2yfpW7f?=
 =?us-ascii?Q?Wp3Isnn14HUunoyLJ2oegD7eTOzzSNRyQCf7LSA3id/udSSMtBLBX12zuT3Q?=
 =?us-ascii?Q?MQIq5p/QqtgV8CeHvNwMifKlf4V4EUyxxTTgKaRUgJ/Mh5cXNAAFBoR9Cfsn?=
 =?us-ascii?Q?xuI0PLajbxPd8I5pvtbEJhY7DZzecGYc1lh2WI18qVTb2zFQUFG+oGcSflPs?=
 =?us-ascii?Q?eJJWxtV92LzRiCA7OAkWycCZrnDUjbKnc6Ibe1BcaBoqkGg4Voq992gW2rD8?=
 =?us-ascii?Q?DOSXiPtzi3yMV0WOE9Cw0UlQh1kABHoj+8wtum/iyIY7YyMPUlBI0LtaQyHL?=
 =?us-ascii?Q?+Y8BxvPMbkmTv9FfbDBvOAxfbsXuBCNHglgQLFqLiliIFTvc+F7ptqAM0JT1?=
 =?us-ascii?Q?YjEHDhRx0/pXv73Ewtl7MW/Aa5TS7daUob10a2kordpSWmFcHVLE0dZRSCZl?=
 =?us-ascii?Q?yIIONzBVmPr5KzZgvSiThrRzPGB/k8wQ5okjrW/dfvcBxjkgYFOBnsZaFB/6?=
 =?us-ascii?Q?VK71hrN+//0aptw/+NVwgNnNg8lPE4ysWlcaXi5kndR+aOx+CI1ga6v92FTl?=
 =?us-ascii?Q?7/DgLdysEIztDoaGNocyAdYQ208BHSpVt2XrFrR/E0QB9Pkud1oj/N31gsQR?=
 =?us-ascii?Q?usMeK9cu4SNfjmEeWTA9zEploUy2K4cDApGYHKtxHBEZ5Ku/vqm0K5sdtibu?=
 =?us-ascii?Q?ZhFp9m3JgnHUOdgRXXJaNPY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98a7562-e27c-4633-72e2-08dd5ac24791
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:14:22.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpVtupbtSS7vDNAsuAFuvQkDsF1MFCVBamjpwbcW3PVgK622ekGUupv6EaYWPIUx10P/S6CRC7xzsthwea6HwydVZDzk/ZGr5VhgKJeId16R4pRx1xnfaDzc7IuHbitG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/usb/musb/tusb6010_omap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 60a93b8bbe3c..15d37aff5856 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -109,7 +109,7 @@ static void tusb_omap_dma_cb(void *data)
 	spin_lock_irqsave(&musb->lock, flags);
 
 	dev_dbg(musb->controller, "ep%i %s dma callback\n",
-		chdat->epnum, chdat->tx ? "tx" : "rx");
+		chdat->epnum, str_tx_rx(chdat->tx));
 
 	if (chdat->tx)
 		remaining = musb_readl(ep_conf, TUSB_EP_TX_OFFSET);
@@ -121,7 +121,7 @@ static void tusb_omap_dma_cb(void *data)
 	/* HW issue #10: XFR_SIZE may get corrupt on DMA (both async & sync) */
 	if (unlikely(remaining > chdat->transfer_len)) {
 		dev_dbg(musb->controller, "Corrupt %s XFR_SIZE: 0x%08lx\n",
-			chdat->tx ? "tx" : "rx", remaining);
+			str_tx_rx(chdat->tx), remaining);
 		remaining = 0;
 	}
 
@@ -224,7 +224,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	dma_remaining = TUSB_EP_CONFIG_XFR_SIZE(dma_remaining);
 	if (dma_remaining) {
 		dev_dbg(musb->controller, "Busy %s dma, not using: %08x\n",
-			chdat->tx ? "tx" : "rx", dma_remaining);
+			str_tx_rx(chdat->tx), dma_remaining);
 		return false;
 	}
 
@@ -284,7 +284,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 
 	dev_dbg(musb->controller,
 		"ep%i %s dma: %pad len: %u(%u) packet_sz: %i(%i)\n",
-		chdat->epnum, chdat->tx ? "tx" : "rx", &dma_addr,
+		chdat->epnum, str_tx_rx(chdat->tx), &dma_addr,
 		chdat->transfer_len, len, chdat->transfer_packet_sz, packet_sz);
 
 	dma_cfg.src_addr = fifo_addr;
@@ -314,7 +314,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 
 	dev_dbg(musb->controller,
 		"ep%i %s using %i-bit %s dma from %pad to %pad\n",
-		chdat->epnum, chdat->tx ? "tx" : "rx",
+		chdat->epnum, str_tx_rx(chdat->tx),
 		dma_cfg.src_addr_width * 8,
 		((dma_addr & 0x3) == 0) ? "sync" : "async",
 		(dma_dir == DMA_MEM_TO_DEV) ? &dma_addr : &fifo_addr,
@@ -435,7 +435,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 
 	/* REVISIT: Why does dmareq5 not work? */
 	if (hw_ep->epnum == 0) {
-		dev_dbg(musb->controller, "Not allowing DMA for ep0 %s\n", tx ? "tx" : "rx");
+		dev_dbg(musb->controller, "Not allowing DMA for ep0 %s\n", str_tx_rx(tx));
 		return NULL;
 	}
 
@@ -481,7 +481,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 
 	dev_dbg(musb->controller, "ep%i %s dma: %s dmareq%i\n",
 		chdat->epnum,
-		chdat->tx ? "tx" : "rx",
+		str_tx_rx(chdat->tx),
 		tusb_dma->multichannel ? "shared" : "dedicated",
 		dma_data->dmareq);
 
-- 
2.43.0

