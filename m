Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011052.outbound.protection.outlook.com [52.101.125.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB073176
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054570; cv=fail; b=dxM/qwEq028d5mBSA04IfSDH6OdXTJOXUoaSiXl33YT6J1UwcZaeJVbose3+rhz/TTILWwX1IKQ2eM4OM0SaQ+0APlpQFU5wEm5qUGe2UMZ1XU0Z62XQtAd0y7Om5hr8POWHvsVPXW2a+Rh3b/uB/hXVBqk5QCPkYj/DMZlaHzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054570; c=relaxed/simple;
	bh=Rf1YU9kYXiYo2JsFjt2ZAcTszCzjEWjmSdcjHnGZk9g=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fbxFRA3ri8MNmgNxDfOOWl/sbbwvszqOxo+twACza6C2o7gky3OSYFahXqJ/XRDaR/LrFTndeLW8JGBg6j49tDn6Yy31+QXQY5B3FZDqtUf+qpANFrtSVtJ8+/SgGJ/wm044DJ7e3qG+stYb/qUw2a5l0mLu+H7/mEIeXo3z68c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=pDdL8amt; arc=fail smtp.client-ip=52.101.125.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="pDdL8amt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGzyQyWZKIXDaPYQCwZppNzPIiL+ZvjDWamXbQYHaROxp/4UBV+rnLJnBs2AYLhv4Het4uR0tdrireJjh01K8rm1snPL6AAtzy13ewGwKJlXQqUu2gSCA1qhR5SnYeMucrXbKDbRsEcapI2f3Ib/CbQ5EWj6VTLvxXtVc9Y3aWIcITFfd5xiSLShzId+7AVQIxNHEPe1xb64EQOUKBbA89nfuq2kueMraPa3xwcu1Vj1+DaL+At8fpjYJSoAklY4Dca5x5GRgI3ScNB7ZOL1yfI/CKNskF1HfCiJnH0JtzOOfuWvtOEw7Wd14AjnSXMBTluxK5+aCWjhLh17TrL7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3IQ6WApaW2rg5jdEG0R3jdQjRYoFd0UgknjDzaEAN0=;
 b=ubWmgw/JwNO8JfWLyxQftZvNdC8QSNXxqsjaVWUFbZuE+Pf22UMmyV/xbjEBqOAqh6SbFHQByuye1GGGDeGg9QmoAvxpl4/eTpJ2sguZOANGYBI40pZk2aS1c/y/h4nf0us+dxBy9ofa/oS2qcozP5BpEyCjJBhqcHQqP5k6EARG99sLCdjFkOtmTU9D8mjiro6QGunwP6EOXbeugQO+ILf4bo5oGMMcHj/MCS6nGXJ3ZJm7JZKdbR+oefvti1CyfqdePUJNqO+NrbrTLJ+gwTt2m3UoNUXVj7Pn6d9cKSKhJVxqYuCVXR7RcyFMbIXhw/vs/Hr1OlUFzS96/XAS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3IQ6WApaW2rg5jdEG0R3jdQjRYoFd0UgknjDzaEAN0=;
 b=pDdL8amtqYjP3oPdsHWcoeufHKOYBs+fpROYNlynsEG9TueTGL8NLjgEBqs/2AUqIi15r/X+FXkzxDtaHNAJuEMpT7m2v1i1lXJ94/+pO3heIKvsG7OeGWzHHtWv3NUU463CmXKoXW1PJZF/fSPO8cmUcYXJe56wIjL6Ddgs8NA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB8061.jpnprd01.prod.outlook.com
 (2603:1096:400:11e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:16:07 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:16:06 +0000
Message-ID: <874j09pml5.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] acpi: pci_irq: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:16:06 +0000
X-ClientProxiedBy: TYAPR01CA0009.jpnprd01.prod.outlook.com (2603:1096:404::21)
 To TYCPR01MB10914.jpnprd01.prod.outlook.com (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c878b5f-ac2d-4489-3f74-08dd5ac28595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PhjOJ/r4pzdg2iObqdCY3U61fxP4LqhfQ/2Ai+RPM2k3T0wIywOD3WB/7/sv?=
 =?us-ascii?Q?msd1zjhTCKf2NdnQZgbR5RmrNoq56aA5w3K33FXLPtqtNr3ycBCcJmXTDS0p?=
 =?us-ascii?Q?A8Vmtt47bxJELkqksoDfMpoqH1yuItVsuwfuH24IKbnHjo5a76Q9M2o/7LN2?=
 =?us-ascii?Q?nrJPKJy50BSgXqeB/ZxJKSUc8gYexmdtU6E6JMO8wXX7TbfwCsgw6XTGZe4d?=
 =?us-ascii?Q?YSPnb9wg8ZLNDHXe6m8qD1brz9HT5Ahi+bZ718rTbQkipNBTxBb3/4i0FrKL?=
 =?us-ascii?Q?JHLacCW0tEfE+Q2jmBR/rq0STmvMPe259dR4AK82Ql1wGMTQ/CiOPWgKwLqt?=
 =?us-ascii?Q?i8m8zX79CJ+z/k7qiQfLP6Kl6Z9owDQYXYGG5MElekxlOhUgumz/lvXDxmBG?=
 =?us-ascii?Q?/xwThjcGhzvT90iwzpTrP95HYVSK1bpZWqS1ojl3flMwjmIOBfbYNq2wKlul?=
 =?us-ascii?Q?JghvBdsxEJ0VrclBxT0vaPymyujPHVDAPrU0RHDv3FgzWxi2+//LQtoB+as9?=
 =?us-ascii?Q?yVS9sNTrXYm3xe92tHuWzQ2ez5MH1pF5CpN3bpqVEbtqIHZDAuqak3cAtRxU?=
 =?us-ascii?Q?5rIMV3IUaOPTivBuFUWp1iedDfxtrXNDckvfxX7CRsGSk86AIyOjpr4nmC10?=
 =?us-ascii?Q?Rlc/RqkdhmqDauRTB32zsC99r/UqoA1tpJtGUIiVYTwuOz4SRl5LdsAJQacX?=
 =?us-ascii?Q?89LsBzxX19MQiNUunEahPRJ/nhHife6i0OeMlPQLWmEWK8UWI5U7vQGn6Ivb?=
 =?us-ascii?Q?mzhYJiOPJn1YtiiCO1YEe35R/hN0mvQIFgBhN3DrZIe70LJWi1M5fFCfdkLa?=
 =?us-ascii?Q?UsZm0oUOQ95KUMluUPrlMwjJ2I7KxP3BBNDaY2FNkDWiwLBVkEUX/3cKK0gd?=
 =?us-ascii?Q?UwyuWBz20TzGsqVY3VMkLQPxlWSWOeBuIZCfT2Ao4yKuXTUtvHx9g+PamGiC?=
 =?us-ascii?Q?Wi/UbtmxozqVaNKjw2L5xN6bKpDb9XjTfRyhhj1E/ZJJWVYbaPtvO9ZxnSPl?=
 =?us-ascii?Q?dUNXBiFnD/7AbtRyBmAp9uTwe8CcSXKPRouTD89ixdMIap+ZnpRDIY0yS/kJ?=
 =?us-ascii?Q?6qk2vM4X3/u6FSvWuladMnkj6Bb0xuak5gsqW+gRSQtVRlmBjP+QFNVsh8de?=
 =?us-ascii?Q?68kSWa1pfAEactKPmsZ+jIpu7rVKnK7IeSxz/EzmQ4iHZWD7VJ3jFvoR+xVz?=
 =?us-ascii?Q?rjQpIo6/thXKTYYyg75Tj3y+OjA9p8umlTAcAcjrDasdBpBAd+1k2sVjupMy?=
 =?us-ascii?Q?f1XbfW1KPGqxjX3Q8xec3iNDmxUgLMKV4E6/Bl5mVvag5dKPA/LZvUgV8gCB?=
 =?us-ascii?Q?X6aGDirElGaSuYuPwwWBg8sSd/9zH8imQ2JckJxoQ3lrpjvrmVCuPj5yKx2t?=
 =?us-ascii?Q?v14ehNeuIrra31iQXNIX8IXWhST5ZeUjpTb5bHMPqKLiSCGDTMguuQFo6zz2?=
 =?us-ascii?Q?LhhnJSqAeUApOqMOR3hSUYRi8NEjRqpn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hyqog1g43qUA5jNOyfTbX/60kuRX5yTWBABeQWXIqpLoXOTJU88NJeU8piOx?=
 =?us-ascii?Q?BhCA4rmhspOAmsNem/afpgyspM7O3yBuGTSvWxvUH3ehUjQ4h/5OPfXutxEj?=
 =?us-ascii?Q?umS9JPvKbRDEd6l0cb+v7F5CwL/XBWkQq9oK2xeG10zEt5qjJwLCJmgYjftQ?=
 =?us-ascii?Q?gGP4GtDh9w5X+5E1VmgAoZBHjUy+iAzGf478403HfxR3+tvR64XLb1VAzu1H?=
 =?us-ascii?Q?/6uOlTH81h13kwcvTCmQkT6P3S2f/qrSdk6RdO9imj9/L4L0K289F7q9I/Re?=
 =?us-ascii?Q?oZsM1Cdyy2/IW1ov0aPlFfJYqwzxCeNc1aOfbiws+EJUDheLw5uQzWjruO1n?=
 =?us-ascii?Q?wCu8N1QiYLN+1AHfDm3cUhDO8QIGNMx8+dI4JRk9O5g2eksq99V/pMQszo27?=
 =?us-ascii?Q?B+DyPLe+sGMORThmf8OvKcsa2nFmffZzR1TJPxKsxT4SsyXpfjcl4TXxNk1A?=
 =?us-ascii?Q?B3Nka1uHl4/QhXaX6VkchEk3xpOgAB+NDPDvWAoYv5a10lumWuyJel8iqTbp?=
 =?us-ascii?Q?f/PISA1oasyu+M9d84zcWVpdxAVNLUNmR2mni0oW14akpxTvogrAyf+Ci4uD?=
 =?us-ascii?Q?Lny9b5idYSN9nJ0/XiMQyHt+YxNoJ/x7gs2S9cntwbPc3PhE5gqmClLhRgOo?=
 =?us-ascii?Q?2I2OAUe4DWb8Bw6AlJfpDlCWrM2+2epCKI8eG3iQHR+pe2XdVo/VA622oRK2?=
 =?us-ascii?Q?Hvg0IMb2PFCtqVzBVsJSok4eO/4oc9+sDI88OWKLuKyZVwp/r2LIWCJYV44i?=
 =?us-ascii?Q?Rin+SrykMef/IHFzp9S0+pYwC8Nyy+eAvLxpJBq38CXSK4yYzTBcHSLWJPkJ?=
 =?us-ascii?Q?MXfqkLK1s8TFJo1eNceB2Fq25HFWpMJi9/Kik1/WK2rl+/w+ufPN1YnGWzGv?=
 =?us-ascii?Q?hWXkJGoV/phtENmU5mWvNM2DbR17wZb2KUn8c1QmIWvGY1yhQPRBDTcw2YZx?=
 =?us-ascii?Q?evVYYIab4xtvZyZhLQFv0uZaFgsl6Z7xGxxiz/jZHl3wtOoT+4V2e7d9ffxx?=
 =?us-ascii?Q?kiMOvPfSXFy33dOUgZDVn9aud4fY8F5wdL3D/PR8rkIpSLtYXqMCFY16GW5m?=
 =?us-ascii?Q?jKdq8L8tUPCfj6fk+AXIlDnkWjJ5WcjAX2SeBl0SCpqT+RnkapShd8910MLM?=
 =?us-ascii?Q?6vf/VZifnSyY25MDm9dN44oQyQh6936gjjpzx831dEF6/xrwn99oH9Ag3Dod?=
 =?us-ascii?Q?OVabh3Bg4k8FgfKqiKdntAizViB7vunwGQ4dXEMLoXNMJQy8YHE4k3w/fMl5?=
 =?us-ascii?Q?ZcJRgUOA7r+TG5818xlLeBW27fVIdSxYpU/hACOrXAYoK88iS8UVIA57/vRU?=
 =?us-ascii?Q?LHYSz/EpSWJuaTCVYSDzm2zQYAezjZoWgyVKe0NxFBJ0NU/RgKVfncHwW6/0?=
 =?us-ascii?Q?fxknllyWtxXqB65ChkvdeJHvcipxm87i3L3fhK/Jlt3oTDm4EOR6qNa2TW8w?=
 =?us-ascii?Q?cPk/LfspMkpPRKWPIRybsBEQKaEzdXaERzRFihMg5Mz+qCoHB4M9V7aJAMGQ?=
 =?us-ascii?Q?nULU/udGacgbJgtEtpmqb+CdHda9gY+yoQUnuNTucR+GCt7VezscMw6smXZm?=
 =?us-ascii?Q?LFtlJ70Jaql4eQm0aFhUP3ToRofJ+DMhEQrqJ77shycT5GekQucB97/HyS/S?=
 =?us-ascii?Q?wKjT2VE+O4bHy/0+p8FXlf8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c878b5f-ac2d-4489-3f74-08dd5ac28595
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:16:06.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54oMaX6N1RIKXPNSHu83QmZg0ezAxJP/umiSAV8FkZPsfhAIg8QphoV+nxlruV7mmxgdhS9pTgPNWGJG0Qkn4zf8k5QMXNDwPB6fnTApC20gpDdF8UtaKwyw1C/BvcOG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/acpi/pci_irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 630fe0a34bc6..c193f25f3c56 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/interrupt.h>
 
 struct acpi_prt_entry {
@@ -467,8 +468,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 
 	dev_dbg(&dev->dev, "PCI INT %c%s -> GSI %u (%s, %s) -> IRQ %d\n",
 		pin_name(pin), link_desc, gsi,
-		(triggering == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
-		(polarity == ACPI_ACTIVE_LOW) ? "low" : "high", dev->irq);
+		str_level_edge(triggering == ACPI_LEVEL_SENSITIVE),
+		str_low_high(polarity == ACPI_ACTIVE_LOW), dev->irq);
 
 	kfree(entry);
 	return 0;
-- 
2.43.0

