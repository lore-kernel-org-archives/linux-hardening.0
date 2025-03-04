Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010025.outbound.protection.outlook.com [52.101.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27273176
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054560; cv=fail; b=SXvRyNBC6bTGYwFP9VGsOiy8V3M1LmWcCIje4jPIFYpaeLFJCU4uhnOLUTFUmlV4GqftF9gHGP4CwW/C//szioO6A2jg8W+roDeGieaf4Vmciiarj/1HIH36bCgtvp6VwCYV3xu1jBoQJ009L6ySfvIZIFKxjqKriotiQvgqEeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054560; c=relaxed/simple;
	bh=J1jERj283FTpiuJDPCxYnatmGCDJEFwIa9wUUHAlpr8=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=s0nPxJvR8djUsgOC0TYchLZlrlnHEVuzJ5hKIIL1LL/G9uETz7+a80A2ORgNArmZTlKYbFaKo7WksHjNBNw1thtTyHiKs8tVRuGi+oIX/Es8IWb7tBaq7XpHcSghnNAwn+sUpbi9JTb/N9K2Mz6xOAF8aGUl596uoGzScfEldJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Vsy0g/hj; arc=fail smtp.client-ip=52.101.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Vsy0g/hj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re1GiB8HsUvgy1Rnta8WCW6C1h5EhucFUkdwrxfp+RQqx7LL3EmRt6GFUp/ztYYNANMvj18m9eaFbI0NpsnGTzTFrVIcBCc3YGS2HIX3E5wYPzRcj8ufXVIDS3F21rZwKz5b0XTu4pVQFqMy/uliqVh+QGMzm14BsRrvH3ikT2qhGYDyZ0bRTHcD86FaogJ4AusnQOq/ysmzhxiRXeuWZQQ2lpgjZ8h/lMPnSewYN7j3nP+d47SxO9jafbwFUB8sPkkJA4cm+AI9j373r6du/t4cer6aKniw0pGz2S7Ztg1eVq5Vnyq5QoUA3uZ/uvul1GueYj7GTbvL9/x/r1qMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldH3aVxldd2VpPBqvhKy8ec+++HiRPldMc6h0Jvg9Ak=;
 b=YUkAhNrhTAnU0B3l2Oqt1ACw1cU+Ys8YqA75JpdaetajcQ+YkZ81/JYFk3BWLxHYa+C3ceoEBcVt1uA7NCpLvLH1h2XzTTHngVbT92Kz6ibIC/l/kjjkMAeSGYCj/qLPNSoSAeoCV9QtJ6pg48XhBZ5jiAkEGGnvKT2wksr3mS0dApfbOUUsfw/bdrXvOsKSk4q6gaaOANbEkEP7Bys+cKlKdrARQiFks3xe8dPi2dkHEhM7EIw2Y9wPy8QaGOWTznSab9wW1AxZ1twRmBfxahLJLb7A4FTIKOHshoRKgX5GBTpfaVF81VPP0WPYGvEQHdaIRnqXQspyunqQbq/R3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldH3aVxldd2VpPBqvhKy8ec+++HiRPldMc6h0Jvg9Ak=;
 b=Vsy0g/hj8R73St08fOAFJjKzTOumxhmdFHqd7F3wyl5/05aO+LMQKBHwvLPQBx70LTxb52lMUJqJabIekMfi5AAJZP51MhEouC6UmBSy36y8CKC/oLEjU8ZBqW//JconnsNGnV7dRUC85NdjQaka68dePtRUI1RDvKhfovG10qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB8061.jpnprd01.prod.outlook.com
 (2603:1096:400:11e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:15:56 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:15:56 +0000
Message-ID: <875xkppmlf.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] dma: amba-pl08x: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:15:56 +0000
X-ClientProxiedBy: TYCP301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::11) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 15225993-f706-4151-c3a6-08dd5ac27fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0rTGehpnSgOkoPR54Ch6gQ5G/PjNCWAhZ1t3NSwQzmHP8pWSKG6ooZpsmLdP?=
 =?us-ascii?Q?7UTD/TtVBfL5Q3lW8YMORs+1HQ45riDdF8PxMHwwMzEKwht97YATU4w7ONtb?=
 =?us-ascii?Q?nrdhmPCUnyfBT5bqoKZOn+7DqFY1318yTrOwspqhHTYgol293kItZgZsJSJ4?=
 =?us-ascii?Q?RdVHLFaF8VS9LSjxb6w78x23+estoq1GPff1CtQGkBbpucIsXUBxkcUHFEpr?=
 =?us-ascii?Q?5FcvfszJvGSKgqlm5qGHd+CpmgWrbIECYoArSYdrOqY2YtF7wLR+A+NKqeqw?=
 =?us-ascii?Q?UMJEe4JBHVw5JaDzvMgl34t8Gvno+H5ypr9Ll/ZeUH2b2KnXpv6J+X1i0yo4?=
 =?us-ascii?Q?5tQqEm5DG5bS/l1qSF+q4RJma6qsdlv+HAyehAEYpGOA1Gn73Boq0qIlou53?=
 =?us-ascii?Q?2JjuTs/e0DMsE9AgGJHPi3GjPo2R3DZ+EkKuc8A1Xxm9omvQ3y3JTfRv93LE?=
 =?us-ascii?Q?DT1907y4Dn4jLnlnXtF+Wm9UmdLVQ/+eVFKzupKtjoJpRpDtgZRI3x+qtnJW?=
 =?us-ascii?Q?kL7V12TDvv2tk0x2Pz+3IBauFtRbb9paKlAuZd//3nqgwCTlBlEVyI++AeCX?=
 =?us-ascii?Q?pv1lwxmtDBkXOIQzqdfeNaxKaaLg6Q0yGpzz6eTjxrSz9+U9ONRSQQhsQkuJ?=
 =?us-ascii?Q?7dJsL/XsxvTpdAgk4qIEVQYTi2X5vlxYiLKDjpaiZ74hCX1OpvUpzm5jtcRo?=
 =?us-ascii?Q?pkrjQigUtnw9+Ot/KHOIwoofSBzQSyc/dX6j9d2u6oUppv0HuK+Kur5Ljpoc?=
 =?us-ascii?Q?/AOKCsdRPjAvhJuNVavadET0j33MCx3t9yJc3QvvoesGnNFeRtNVFNUHo1dA?=
 =?us-ascii?Q?P27VIN5D+5bJsQK4JmhOEPq6kjZPThHfZdgg5f5ybEPAX5TOg4p7F7J8Y3IZ?=
 =?us-ascii?Q?90GX7ufn6RBot76WhTdcgmd0GJSf/+xGdqIH4FMwZmfr1Kk94Ft5WT3znnwx?=
 =?us-ascii?Q?WvfOrHiapw+5f9/h+HN0RIpr2nNFsE/C/gY/a7ORKsgUik/9bMW102c2vKpr?=
 =?us-ascii?Q?XZSSMPhVO2F/jMgjM766V9r8hZtWTfyDUc/64sdzdR6VNFhBxfgvbGiXdcDN?=
 =?us-ascii?Q?6bWkoVGra2ahUnCCEzexSsL3Tn3PSmAoT3hHhoW9fARdSgr/M/qkXf4DLgE7?=
 =?us-ascii?Q?YUTZYITtTM3CApO972H8jMcm7Vgsosr91IGIGP/2raEtW8dnNkRs9a/9HgFN?=
 =?us-ascii?Q?nYbruzzE+f846Vk2x0lEazsslN1n1hMY5FtAY030hWFFcKR3SEldAVaXnvw8?=
 =?us-ascii?Q?EXDlxMFs/NfQM/tRiQWedVxqN1R9xVEH2+pcTv9D4xcsokWkKG9KmiGAhOod?=
 =?us-ascii?Q?dmUlEOswAcQY5T1mZo7eN1e1YVF9AmVhz55biEySs0lPomXmoW0F7R7lGhFz?=
 =?us-ascii?Q?owMRa7A2GUzAr+vQVXH7X7132V8bpGIaBP2oH1c5ofNTm9yOCc9Hp4aiSzkp?=
 =?us-ascii?Q?SLS6sQx3ZTUuP8zgkavs9rRQGtc2C/Vl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PfMEnfWByAjvPNjhwXYLvdZNyBbIyZxkrigBJtds++33fCfzA2eP7MGZ5/m4?=
 =?us-ascii?Q?o69Kj4Q8Hk1pF49S+twDOkWnPCWckcehxqbzyj6Fuw3CcPwE38kNl618iLM9?=
 =?us-ascii?Q?as19zlR+A8uYJKrpXkAqBwLToh2chXvtWx8jMbXNFfuvL81NCrUaJ0vfvoV1?=
 =?us-ascii?Q?iTbq/BWTohjrXsmbwywOPfEoMXH5Gj8/poxVATRE2ujHeYHPOY+6jj3pyW3J?=
 =?us-ascii?Q?F9dylNXPH1Bhoah2sOVj6wuZgG+f/0N8mWNifCieKKDS+zI6azkc1SjKbYqx?=
 =?us-ascii?Q?maIfzejle7ENMWV5gThd/lxAAjVCm4W9W9euwtiSETdNQQFsmSp6Zn3k75pZ?=
 =?us-ascii?Q?NjTRaTQ7Ixbs9pYkes2TRN6TIQZi6pWHP6zFBiuEW0XLj992RTjJwbW4hA+I?=
 =?us-ascii?Q?43B5kyFG6nYoPbRJ24VJsnE7DTCHMIaPVz6UkKSZX8mWVv623nTS9O7S8LuS?=
 =?us-ascii?Q?gP111R4QRuagFBuLyjn8DfTHkEqCwlWktsyNVfX+cUEwbD0iE0aWTQCU5Z0h?=
 =?us-ascii?Q?AWIdsHwft7DIMGLqwH1RdbHElg4y1zy89rgLcIrcOKYhfDCVfbAB5r3r5f93?=
 =?us-ascii?Q?VBD+UDSiurAgFi0oXCt/aCw3ZMuqEkKJawmUEctnP8E/SjtLhBJEpIVwL8c6?=
 =?us-ascii?Q?+rMdKngo/BGwfnjDvgE86XUDwnzJ7QDXz9VXX9Vi4eIIQRFiBa23ZhNtxrS1?=
 =?us-ascii?Q?f9h8lK9rfyzqcYZOtpaG2KnBFlaRr+OgvM5Hi0TP8Gm+XxuA+dyP40b43/jJ?=
 =?us-ascii?Q?rp+OdhND94fslV6PZP0r3AKMWaTNMwyERRQdZOIoIs29GJAMrS8mGxNdqk1f?=
 =?us-ascii?Q?4Ja9DhcnYp/GBxkAvSEjOEL7sEAojKsWonklWh6hqIUCAZ8TEcdBj/0UePti?=
 =?us-ascii?Q?LN3FbTUI71+mMoT4l5wm9P8VQ1kUKYbk+hGjw8YxJb4fpjQB61ae42O+Z4HV?=
 =?us-ascii?Q?Q9z7Ns3e8bvz/NeTQTqKz97HM7Jy6mFDm6dYIBWpaZK2NR/o/vYAOXBz6AA8?=
 =?us-ascii?Q?FgjTrNEd1PqefaAXtTmSru2xrOc71IB31P7j9bUmX393Ky4vYsYzdpnG6KnS?=
 =?us-ascii?Q?OPGr43w6SwV7QjAp+UApYutvKTXHFosCxYpIpR2c4T1+mMmQOdGyhrf07xl7?=
 =?us-ascii?Q?TQLvcu1Vc5a60Fwr+yDyanE+ISZJ1arIzMXizdNqNmtq2hLM+YvhL9ChcCtj?=
 =?us-ascii?Q?MxSQAStDbulD4PrUHL3QosSHFoxGEpuj5gvsVBUyrPi77uB7YiRG5ZAI5gBK?=
 =?us-ascii?Q?6UclpjMIeb1smwR6jLQDKCtpmNwWAtx/rS2Fm6OfhNNxDDNScmkFFH0gONhF?=
 =?us-ascii?Q?7DaLBMUNWaaT2pmhRTw+vDfx8ppyWJk2R4nTfJCPqpVTk7ml8Q+h5DCcUWh7?=
 =?us-ascii?Q?9/t3Uny5QO/Dn1K7sJsiPs4TlqXwbIb8NJcepAlxYQFbi2HrJl4nf6is5bJU?=
 =?us-ascii?Q?vY3SmGfTg51DW03L2XQpUGMPpSyDj2C/mXFYXgOCswGTFrhP03DeWbSlY2Xq?=
 =?us-ascii?Q?qYs6wemRkitPkmz3c8e/vDnPA2l+s1sd4jolS+lXsbwQ9DvFPDheYEkp6/3f?=
 =?us-ascii?Q?iBi9o6l/oIZH4T7dyDluEC5oLomgYCeXOXsvePq9plEtmqLL0o+vVM+pzHLL?=
 =?us-ascii?Q?IiUyhreUeyVnih62rWYYB9U=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15225993-f706-4151-c3a6-08dd5ac27fa0
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:15:56.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0JZj4aV6XVMRCnBTCMZSmNfwyCMpGF2ntTQFkRR1wocqB72rNrryYe4r+wM87Hhhn7fht/Yg2PKRVJ7ltQj6n0CqExs4RVjKhL4MR9Agt4D3kz0yn68iUaFpRXgssNy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/amba-pl08x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 38cdbca59485..bdabbc2ff7f8 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2094,7 +2094,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_cyclic(
 	dev_dbg(&pl08x->adev->dev,
 		"%s prepare cyclic transaction of %zd/%zd bytes %s %s\n",
 		__func__, period_len, buf_len,
-		direction == DMA_MEM_TO_DEV ? "to" : "from",
+		str_to_from(direction == DMA_MEM_TO_DEV),
 		plchan->name);
 
 	txd = pl08x_init_txd(chan, direction, &slave_addr);
-- 
2.43.0

