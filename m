Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1C73176
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054591; cv=fail; b=M2r9Hv60ZzkjUVS6k2e2t60YxqpLZNP7AdbUdzgwVebpDqzQ85BRAqQ5z9wmjIrg/1xJMFoM18ZD7PSwJHhb9DaSsupNbDNtLZY6IuQc+KJF4UooE7Xa+Q5X25U+QgdakwsLZBtHapkgQJPDoYAk1/ZM8ZMD5+dxKUJTzj5oLVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054591; c=relaxed/simple;
	bh=JsbNTCfOGaVYy1svISKoWpNa0paWA+mRc8a7N6maTI0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=FdoC0x40ktly6e5WTNSaolAQDmZ444F1cLQNCZX8tvRr9/XRgzZFyfKfKMZBNxL3nE0GxSpPtzoW33ejAp+njBUzVMTtXCEW26vwOmEoHzebMiAKbkjIhnveVi0L9cO9/Dnoz7pcYKt3gUlbQX/MasiQ8u17MVljtQuxTrRucI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dt42fahS; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dt42fahS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrzXmtMOW80WEjiQvmCxS5FW4E7diZYL0w5WmpTZSN4lAZSAEAQAbVOzzZjcpBXW36FFDvgU62xNGo67S07ebj1Fb8uvYb8YhFW8K/grFKWJvusyL5lJtpHF/grzAYVM/Fctu+NafL0B5T4jgKuoXpV+ASWYH81L7Ig8+DMIaQL38b3Zdl5MXnhQh+XxIPYAsDaKmbV4KGvb/koWOATdsPJmGlaUtEVSMbistbBIQL2Ziy6HvbtGG4TC4untu3avSMt98UxZAOs5gEnDrKLuuk5rdKcE4KB/ik1dhOz9mGqPxv+0+K4sTcGfW3U59wt2b6fkWEe5kVWBGN0qxotXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kxO4aQ4Z9s9VtGie2D9V9MfvV2rIVeyxpdbBqckezM=;
 b=RkTl/B0OYltmLdEKqju3yfZDkaji/VDmDywCCBh1DXmWGQpatxjUsWhOHIHxbU+zQ6esbrtsvmge8WzeUsc8wvA0XdAJRJq8XWV8xgfBASltQDnLwB4D1U9Ys8ZiY5s/DvIqghl9JJcEZVXbzNVcgAwuAYBdW53asUMzmr6pIOC80mrZgr2Dz+PewZrKULM+StGiTfToSAH9h8ovpSlp7wJ6UClwGlGLvzhC0zJVD4NTRZIY2KAVMQzo909e+YQ8LcwE6q6ZD+MaCbpgj2mYyek780P9MV1AW//ga/pS7moweBPpm9Rx1CmBH5ANd+/I6MzEYpfZQmubqWYnsSHA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kxO4aQ4Z9s9VtGie2D9V9MfvV2rIVeyxpdbBqckezM=;
 b=dt42fahSKfOGuThknwslkd63QN0KwmSxqXYH/H7bVx/BQnCea69b6ZLs11x2SG5wxToOqoiXQG7iycXPA85jBM+ejAI0fRaFLDQ3r47JeWnimBDNLmUyPr1z/1fcsaxwe2VfFk21qslZczy6FiazP4fyO5rZYLZl9ep3MGbxU34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB8061.jpnprd01.prod.outlook.com
 (2603:1096:400:11e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:16:27 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:16:27 +0000
Message-ID: <871pvdpmkk.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] extcon: rtk-type-c: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:16:27 +0000
X-ClientProxiedBy: TYCP286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 88355591-65f6-4e35-e3e2-08dd5ac29212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wj3D7El+dFcygE2gNOWlNSIXBX2xATfBvghfk6KGpt5n7JGRzI863LV1xP/2?=
 =?us-ascii?Q?HM7yM+mqrNqFmYP++OxvwTUI6W1DWYfG6UJhN/I6phq43hUNB4fWK7g6RIWG?=
 =?us-ascii?Q?dp6h9e7n9Gfa9yGGx7gnMiJISPH2ovi3XJfq8NMKEoRL1mRLOwCpW8sVnZZ8?=
 =?us-ascii?Q?92YZJv65Zper3SxAedrf7xGYXhOZez69BdYs1UQHzelfZuOyvp81lW6pghAh?=
 =?us-ascii?Q?JsGIqB6WXPQyVk65iqPPU+wP55YtQdZcs2JsdhhmhZIXv52ItmnQvzJ7c7iq?=
 =?us-ascii?Q?J6sDPaWxMxb0hUlvMvlWT3ir0M7EZzuMCfe0+QGzZ+hWPYwdSNsLuNBP82Qn?=
 =?us-ascii?Q?Gci7vau+wu/w0/Zv6AIKwLCJDY+AfuzSMRVczKk7N3MIx1h8JFFxlO+nOoGR?=
 =?us-ascii?Q?DTWG3w8PRXaA0G5K+s65f/GW7oAwuJVrzV88/DudJcWj3FoxqxWDMHODCQG9?=
 =?us-ascii?Q?u8QkRsv2O7wMIYo6OAoIdSN9qQG5+EozBydoqZAdIPiKzLZKxdcR2ZHMA2vv?=
 =?us-ascii?Q?V7f+eYjBchHzE8rakPVZeFgf7HTUxTbDdsl6fJfHCYXgLBb0M+lebK/TG02y?=
 =?us-ascii?Q?iSsjGGcON4c6qaAER159nMZUn9SM1G5BIeVnRZnutanhEoJzVse+vAJwuJb9?=
 =?us-ascii?Q?c+6mZrJKj5OYhG3TeprAze4a4ObO0GILyaMv5Pv9crmlZbE0Dy2L54+42Jqm?=
 =?us-ascii?Q?IEzfRkyWVEfmSgXR+moESXGufuDA+/ujNI9M0Sn4JdoNSYh+vsqPzE44jF4c?=
 =?us-ascii?Q?ONUsUQB6vjSr6jvRT/E9pVfJ+l3HHUdOwehNNdw6j1DEDEx7CGXo2KHQlCGU?=
 =?us-ascii?Q?WymTV8Oe00R28jOLswe4D2b1BjjjSihN1RKncxv40m3TGKUxCPcWuAWx1XwV?=
 =?us-ascii?Q?MbFBb2Fd/JX1b4hkAI8XXH/GL20mU649lX0HQP3J8rxJQHAKLMT4G6Ya12Du?=
 =?us-ascii?Q?LRV8R5PSobiKHIk4yfPUhfamFOo6/tRNQym+XWLZ3xcrnQ0fXN7GWcqTF5YA?=
 =?us-ascii?Q?KMz/+lI456C2MObR2sbVqkgtmuI6Z2EmWcslC6Fv4Ewvus9WMPgNmr0HvhsI?=
 =?us-ascii?Q?yeEbXTsEFsHzNPT9QBBcjp2d8qALBnU9RQqv2x223blCrwCcbEuChkr8Ah/i?=
 =?us-ascii?Q?civTJMvmZ30g4KD/ewQRv+1RIOXaSAtLJ26S7BrLmJv15z/c6FGO4l4yg2eb?=
 =?us-ascii?Q?SN6iSDwTmupT+aUapieTShW/qxwm1cphc/Dm0u859kBlgOftfQSHTPEFkI45?=
 =?us-ascii?Q?2VzU+gO2THz6BnnzGS4Bqjmg8uA2C2Kynv/4Jr7gNZSVr94VXzoxAT7YsPXF?=
 =?us-ascii?Q?sj66XAAEKPBjxT+MuTjDKFxGg2eQ2vN3J48oXYhPf0yax95X3RV+3kKzl5uO?=
 =?us-ascii?Q?8FOT4MLOoSogjUczWuFlniBcAmWKo3QxlVvEhoTx7Eb+QC5St0DZ6+ZTfHFP?=
 =?us-ascii?Q?PafY2PLlZC0siazqVjBHEWPEqryBcw1Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpuEU+fihNpzdol97kR0cDudlavos1WqMpwV/Er00RWrIAcfkOGslhjIqTJj?=
 =?us-ascii?Q?LyJaOKgXPDjBUgam5JXAL4kwRV4c/fuBYdLLYvMjyKKH2el+OQOSVnRIeGgN?=
 =?us-ascii?Q?CY9tlcknXJd3+zdb3BF3YPSBw+t/AzNtgTpQ0zBfUJ28hZ03ugpu0vf8K3gL?=
 =?us-ascii?Q?Hz4rt8dtO+UVl09fFWmrSED/aMDhHSNMRB79sdMXlE4RiJBWtnEc279WRsOe?=
 =?us-ascii?Q?F+JxwHDWu9xTCRfQwZwdrDBPFsTgJFTXFxmk5ON+BpHld/tDM9eHLIWdWbI3?=
 =?us-ascii?Q?g4jEb276kuzJakws4Vv++6V6ObckT/tbo/X+nUN0tr0aWJhgLh+MYFGAMSur?=
 =?us-ascii?Q?HYM2fICPMel+YWfakob4GPoMVWKr0/S1W2c9PERzkIbwsdLpzA8FU48yNzeg?=
 =?us-ascii?Q?8uVackyyYjnBcWVGObV+M4cKDQTUH/HC7nNkfQR5TXI8GxmkgqjcRjhR2ZiV?=
 =?us-ascii?Q?30jxkNEVn13iHVphinyTZV9lt4cMmjX2YTCFKwIp/15c5EXwnhSnwN3CILXC?=
 =?us-ascii?Q?UO3hI1CHu4bV2q+MtqkmeH1koHgzdUpPJw8WO7XhApYU2Jq+//9M5Fxl//zr?=
 =?us-ascii?Q?ouWstcqJ4ibQuToWzXCreJ26A8nJeUL6gCrStiV/YHk4Yt2/3yu2xjeoBHXU?=
 =?us-ascii?Q?aKvACMOo0qXFFdnNRAutI2S/1BjLKHeDytKvq4MV1GC8lSozUtiqPj2wh+mo?=
 =?us-ascii?Q?LDUyRP9Qm2w/D8NVAl7T6Xx/XnB+0E/aGAcwy1Qh8eMUfibNsJ8HXUdpX0fH?=
 =?us-ascii?Q?3V49meDOHbozKHci2uvdVPBOIY+QHiVi20Gptzv5NRTDLmfhq6yQoZ/4vINs?=
 =?us-ascii?Q?X6NVFPVR0hPOc4NEu/EXFIPynSvHSoH7tfnz2gWrH00IiGipZMU9Urpui5Rt?=
 =?us-ascii?Q?u7uuLrx9EGgTeuXXQlHbpNnU5q2MotHBQpHv0MEGKM0WbJJ0v6RKfK0gGPE4?=
 =?us-ascii?Q?+1Lmzl4mKZjQOOGYEPnjzhycme9N2ZNjbyhCgCt5estd8pt44+8y24I/dyVo?=
 =?us-ascii?Q?iCTNjanEhbJTOIESrh78NEwi6ue/fg4rh6KYKAsqYdkbE5OXxSpZjo6t6Mwo?=
 =?us-ascii?Q?Y3yAA1mI2ABdNA/oFimRQhWlq/uoYqDk3tTc6ls1Rhf/7qd3LvfO3iF7vPUl?=
 =?us-ascii?Q?jQqi8zhr4jd2QRRl/nC0d4I0e4b/ZfWimR3NUpphI3kZXUvB/14R/3TLhwao?=
 =?us-ascii?Q?j+/1IEUZiqJCMjlT94u/p00yDoODrCwAgz/whxahLPbI0+9Z8CXDAuuc2myl?=
 =?us-ascii?Q?Wb8MB3gmk0LTMMkPyfBJNqnkG1t6z4VkK06Rfk3QZazewFpeVqVLmIKbHbYk?=
 =?us-ascii?Q?Y1pEH14n7gD7mB8RALdAdu1qZzVIWlO6v+I8PbEejOOltGZ/cV4OZXn9jg4s?=
 =?us-ascii?Q?PxSSHEiIieZyh+KTHXG/13n4UV8yrF42u4g8AoM2Z1+8zBe/0leK+1fD47N6?=
 =?us-ascii?Q?zspAnmAvONceto2JRXEtq5FWVVvb4UxU8Pws5QI2O1YFyA92z/n63m/f1eaI?=
 =?us-ascii?Q?uKEpRzHKz4bUNTlC5HE2jFEbwTMTTRXAPAkchETkrtRhGOieMcGus3GbbIuq?=
 =?us-ascii?Q?P7y86c0s0fyp+EipoCrf1mSHTz3ngQ0xetM4g9mSblU9Qf5DeTVB8csTTZcY?=
 =?us-ascii?Q?ope6eQZdnTrzIj6MkzGVAWg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88355591-65f6-4e35-e3e2-08dd5ac29212
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:16:27.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ+3ucbN+TzhbLLe/7dYHmYr8+r1fYIWbS+dMEJUmhkqp8VdEiZtwCoHXyk40DbHqfcCUBBDs1GnxF2p/EecXFcokcaMHbbRI6UEO3NCCW9t609+BVUgpjpSuwYjj4OI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/extcon/extcon-rtk-type-c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index 82b60b927e41..0c4ecc897a2f 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -647,12 +647,12 @@ static void host_device_switch(struct work_struct *work)
 			connector_detached(type_c, DISABLE_CC, USB_DR_MODE_PERIPHERAL);
 	} else {
 		dev_err(dev, "Error: IN unknown mode %d to %s at %s (cc_status=0x%x)\n",
-			cc_mode, is_attach ? "attach" : "detach",
+			cc_mode, str_attach_detach(is_attach),
 			at_cc1 ? "cc1" : "cc2", type_c->cc_status);
 	}
 	dev_info(dev, "Connection change OK: IN %s mode to %s at %s (cc_status=0x%x)\n",
 		 cc_mode == IN_HOST_MODE ? "host" : "device",
-		 is_attach ? "attach" : "detach",
+		 str_attach_detach(is_attach),
 		 at_cc1 ? "cc1" : "cc2", type_c->cc_status);
 }
 
@@ -671,7 +671,7 @@ static irqreturn_t type_c_detect_irq(int irq, void *__data)
 		dev_dbg(dev, "%s: IN %s mode to %s (at %s interrupt) int_status=0x%x, cc_status=0x%x",
 			__func__,
 			type_c->cc_mode == IN_HOST_MODE ? "host" : "device",
-			type_c->is_attach ? "attach" : "detach",
+			str_attach_detach(type_c->is_attach),
 			type_c->at_cc1 ? "cc1" : "cc2",
 			type_c->int_status, type_c->cc_status);
 
-- 
2.43.0

