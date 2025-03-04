Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010005.outbound.protection.outlook.com [52.101.228.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78213B58B
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054495; cv=fail; b=ijdwhdOao7sGaiAsJwVFdQWQHvWd8UIsC5U2ohK653zEADHSv71I9gpAZSSOS4cBbMTfaPM2FdFdhbbro7WPn6v8FTo49gJ1TLubZxQWfr7w4EGhoTM2zrSAW4+zRq9ZkbmB7pal4MhOcAzIauyFwk4iQhQCxbKarDgxQDa2NOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054495; c=relaxed/simple;
	bh=1ccAUWBSb3fURro1pEUwJ7II1kJE+CxTVdqQf+vCDlk=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=arEkjDc1Zs+Iu4eXVjYiCg/6/vmJZiEoTL60PW0amH3ahQ5ACjSiqlSM+gD3KxJRAoBvtb+WQ5UNrTSCbRPvR57vzI0nbO/D8c3RCXB9SGrenbiks7uIQxUg3LUyyBrOIJWNUo68B9UEPTy2Ep+kmMTpuFZvbHEWg7fWEViH3fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=h9YU9CWm; arc=fail smtp.client-ip=52.101.228.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="h9YU9CWm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe189e4j26wLJnSBo6ZEETX+8gmuXdkRGn98VkmZULx322ncGBptPYVSV5FChDJ77HhHwiaisIY1TxKPhUqIx+Pt9dke28ApE+S2qcJfbVkq0a+TtxDI1PF3pfeHuebxM1yfOObKJyBQZn1oyuZIpsEL+A+w7ZFFpN1v5ddAF2DBANgWjzn3J26AU8KlmmD9KjHmMxAGUTlQFTXwvGGRpYTaPIlqw3gS9Fkmu+qGmkjHBGVTvTDYdRoViwliK2Sf0Gnsl6fKgFGgzJNBv/BztBQI+ylbK3dgAs9BpvRM8EqHGExBPznfWXGXzuDWUXsIdHljIZks8+QRbIFAhiGZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB4WqRgs04O4AMRVFCAfkn/jPxjWnL7Oy6Xb+LlZaA0=;
 b=F66sFlO4eblvMdKY6CTqRTcEWRBMrrkLg25ruwNAd/kbKr2tVKruBnWwtzxl3HwNeYs7U4R6mw083FN3YS3T4SNPNKza5Iw26RSied/krNCQ6mNaCiNRx62En2UR9CIrzSV1gf8Ic++B2Vp2EakBHjJ3gr26+n+uCJpAITxnHwllCSmMnDwSiQZ3V2PGdCkyQFNCG0jMFVi9c4cwiWmbRnvSj80DcOg0cXQmVxC+u/YkgM8uRO2NP8FWfRvQI1rL27wnahRYJwB2eQL5DYjY8k6ezdfwnO5JvpRRiIrOeXN+FH9cgT7M6dJrSPMd3Qt6NFpoRHUlo4BiaOP3x11r0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB4WqRgs04O4AMRVFCAfkn/jPxjWnL7Oy6Xb+LlZaA0=;
 b=h9YU9CWm1SK/Ug6cQcdRfq+Mm2Z3NEkffhj+1nSy5HBvCw5bjo339CGLX6vHdUS/g1Qha7Oc1Xs0ASRRHuszGe3yKOFsJ5Vvuh6To5FDO1RaNkQBOf9CY/Q0ydR6a0enzQ/6VvfkAiSg7rZwfx+KAcgWD6v2J3lAAipbILNjXEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYTPR01MB11089.jpnprd01.prod.outlook.com
 (2603:1096:400:3a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:14:51 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:14:51 +0000
Message-ID: <87cyexpmn9.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] gpio: xra1403: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:14:51 +0000
X-ClientProxiedBy: TY2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:404:a6::25) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYTPR01MB11089:EE_
X-MS-Office365-Filtering-Correlation-Id: 756851d7-f331-453a-ca44-08dd5ac25882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dmCy+wd1co9w/R8BrGPtCXbssP1QecFJJ5TpOH52RlUxfYFmig6KpsgQejau?=
 =?us-ascii?Q?mGJokON2J1bVOJGpbfPWMoQpszkYhwLfbllBBwDjzjAV9IEBUi1oeYa3SSrj?=
 =?us-ascii?Q?945S7dMlKU1Q3/N3EXnEBdFKnGHpDehgNAHoGuNOYW1gcrXbYFPEUa+cwnuC?=
 =?us-ascii?Q?GOPDFH/3h/Xk6CkEqatTXpoSN6Ye4RBtUpU8OCmAuKYAMkJnhiE75eRaMIU1?=
 =?us-ascii?Q?FO9O1lKvC0uDhv7/ubPsO04iD5NCQT+zb3lvVlNWi1E1FWKXhVxQgaoi/xBk?=
 =?us-ascii?Q?3TntdFCDNB74nG5FsGBqhKCEQfolLrzM83zY7RdHq6ouj1IZNdxmW3YKZoQo?=
 =?us-ascii?Q?HLu2Dfj+lD+J6WqNYL0X7e9rx5JcGod7KkODdkOqXuZRLq3qntnjqN09mfmH?=
 =?us-ascii?Q?u7fuhl6S/xqM/fMrtiHBCvvKO26nAKAZbG2zuR5zyplhA/vOrgO4CMPWfnt3?=
 =?us-ascii?Q?h5x+xtUo8PttofWmqVN8kQQa52KLAguv7Fs/g8DQuRdcorOO89BbL2E4ehlf?=
 =?us-ascii?Q?PDa740L38xUwGZ7E+kiohGFlDDp8o+chtAQ4Zxy/9prETeq+1BMX18345Mjh?=
 =?us-ascii?Q?2zlDWgsbRp+V7eJ2lIC4Xb+jxv0PhQXDRanhb+6bfR868BbpWxTbEE6jbK17?=
 =?us-ascii?Q?FSWC9wA1FLlsvP8f3viFEvsX9kdPgWkfnn84oEC5RS5RBuyb9mPbT0AMWzPd?=
 =?us-ascii?Q?plaGGxhpEOxL9rKOHTUYh9O/qou4MXQ+F4foBpSihSJC2LXeQuBmaqbZ7tO8?=
 =?us-ascii?Q?ifczOCdTBnB9Tw5o8K4Rx44a0L/jnuGs78WKjAhUwhM11wZ3vb0wuKT+kQsc?=
 =?us-ascii?Q?aJ6Vv//RgaOgw7YpC8tt56+SjZbeuew1UHiiM2HxifIwzHVhCTwirLto4Kxn?=
 =?us-ascii?Q?uGa0Z/ayTsypXDAZBR+gVY5PPgGfpA/nbHtJ9lTKDXcQ7rL+zu73FAxIl/G/?=
 =?us-ascii?Q?fEIKKth1VADOoR61RbIzkaRM8lSbR7WEH3rJ7d6BQ4dwUTxzQA0uK9Y4aUjb?=
 =?us-ascii?Q?iVTGGXUxIX5QQgc1qILZwDKHGjz8uNsFZ6TEPx9qL/OXdBlwSU6DSEdnI4H9?=
 =?us-ascii?Q?5hqvfsSfCjzPOm0U4pVn9/s4a7wEgHJtXtQqXfYoiHnqBZLOxmS8A4kMd7Q0?=
 =?us-ascii?Q?GUelTztqIvMLVcF07Uwq50FVs3qLB3VooPASmEPbrqyHbgcki/CPFwFeJ1ve?=
 =?us-ascii?Q?EggUAEnsjeOrYeTceef3rBpYz7HCF+JNGHF7A8PMy/u7VY/vJGjPoVDw3pC0?=
 =?us-ascii?Q?qrq8L5UBLOfSyEILa5x2JdORiX3nbwkAGyiGsCLfmjDWBF6EgEPD/wLyTpkW?=
 =?us-ascii?Q?10rPEuT2txYzkwxeMkpr17Bibr1zv1fvE1xDrmH9UXvWhM+WrVwEz25c3Cbw?=
 =?us-ascii?Q?sv9FIncpT/MT/A/+e0dbUq+MTKR/9x94ilwhEkFpl57W7XCMxlbQrSPLl5F7?=
 =?us-ascii?Q?hy16hwFLRRk5yv7zFusqUNXY4V0GMsQQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KfPSnRmnKjXBoMdtWe46twhzyNEhYAFUWme6GHv1kaf/aFQ5o+UksCHhH8t9?=
 =?us-ascii?Q?dcplqlygJgxZJH4ssg2GEjG9uWsqM5edObjtZCcjqVDJ68YHrNwfHE7Odw/Q?=
 =?us-ascii?Q?PPQja3qqc0emtLKdAqufj14t88X8r9e3zFfrwPajKQjBnjrNJgjnsGo/gyJW?=
 =?us-ascii?Q?35HZ2w/Htt48tO3xYC9xQXDSMfYD67ikCmqzfSv1w3zUxsKUzRaeoQ5gHBnj?=
 =?us-ascii?Q?XJL+rncuciTtCpKkvToZfwdrdPk/NzskMBnjneat/pBBURV8RVk7K+N4ytVp?=
 =?us-ascii?Q?awUkDWFnKggU+qMsf67HKTBWqecMfeeC5M1DtW3S+CabJHrsBPowIgmNleK9?=
 =?us-ascii?Q?+tpmQshXTYrP7r4O6e9umV3YG5dESxe1gOKvNjqxzOg+9mfCoYr0bQJHH85t?=
 =?us-ascii?Q?l53sVfULhqiUOgdrhQOKfEzuZFsrXsXu6GF2ZKdWhQH5cFjzljiz0L1VMdgg?=
 =?us-ascii?Q?7kfVU23oV5aLIVLtxbVY7TGhnsFgZDGCvTndlap3yeZdFFRFHXU+GrMeYWu0?=
 =?us-ascii?Q?QkeUw0YLAEksu2U9ZvPZaZwsv2oM+R62zLKe18KuqldZdYshwmoGwc94BYh+?=
 =?us-ascii?Q?XEkO/tHzcP3wQ90Q+G5gKHLyUbYEwE7c2PlChOc/BPYrKS1ya4giPkcVyEkV?=
 =?us-ascii?Q?s0Ui8ldh+YQj7+jXxRW00P9CDPGNeQJWC0DIfcUrwGpLn9UptWsU6tfwnoPg?=
 =?us-ascii?Q?6+4m3AbaDqI6t/K0gnc+dlZ0pGnwLjQk1FbraTayhv4JBIfLH+TLOp5Ip5Fj?=
 =?us-ascii?Q?kD3n8bJBHqCEArC04S2aMUwYyxIIpspYZUPI9BYccxQzDvj5Kjn5IiAA1OG4?=
 =?us-ascii?Q?AGk7efXnjFqXFAnMQOWm0ByLgnAmYLEyPR2GhHrNLGwypFLT8ANCx5yLwJf6?=
 =?us-ascii?Q?iadr2tBxP0i/guTeQuGcW0hduCzufhJGOktwMrVW/miJs6/fIw4xuPqhXwe7?=
 =?us-ascii?Q?vXiI+FSocWQyEmwxxvERwXdL//hehoU3g4unaoP86Df2Ll1S6/upbXDcUaZR?=
 =?us-ascii?Q?lpYVVuBvsh/EavHqkXpTKxqb9hUHHuJT1qjotK2qIRbs0jrN0cKw0SY7w4st?=
 =?us-ascii?Q?yCbjEjjD6Ni7uk3DXF3sqPqY6JJBHaef8SUojG97YCNbmJX+JLlcXVeX45T3?=
 =?us-ascii?Q?Mi+C5GYK6/t6KFu9qNlJ70Q/hyby8dJP4MY4c3ypqoCdaz+ciXzSGnfKaEl6?=
 =?us-ascii?Q?R/BBUdyQ5tVQEf9vQ2+MjbLTgsq3jwzMN3RamgImQNf4yRYyRc8do8Zk2qQv?=
 =?us-ascii?Q?CmofClI0MTT2+ThwEc4sHc1h1WwgpVfTGH0joHNNEtOE2gPvTjsZ1/OVNxyb?=
 =?us-ascii?Q?TMx857kVVMEtS/x0/qQnMY3n0Xkd8g+OUFqEKHxbiNNLoei6Fo+izMNXq2cU?=
 =?us-ascii?Q?zaQc2AE7RjeWV4stENUeOCGOcypOuom6Wfe1mVwMZsp5DMAoE9m0JzMxCTUP?=
 =?us-ascii?Q?liEDpL9zYDv7ux0TAK+0lfeS7E3TaF1+j2WmpgxIA7mTanF+N5jxngx0cB0A?=
 =?us-ascii?Q?Cu4MHkhTenCm/yRLpS+B7UHL3cDVSTWyVDmC23Wd0cQJxkI4THxdLrj90wM1?=
 =?us-ascii?Q?HSKzELXe3Po8M48pUow5WNFqTy0fa7Wd8K3d4ktltUUHY23EV946772wovJl?=
 =?us-ascii?Q?YEs+sbVsgANXFfX4Pq49OjA=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756851d7-f331-453a-ca44-08dd5ac25882
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:14:51.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7M4p42K47Q+5WKwtL7d43Y9wbRU//pwEC0VUH7Zb+GweJ0vW8t7uUTD2/o2hTOFNF+dppPWkcXtxKOdZ31q58FskLP8uYbDOIAzVZaPNXcJZaZNxukBkSCN59cQb9bgJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11089

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/gpio/gpio-xra1403.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
index dc2710c21c50..ad6b86941307 100644
--- a/drivers/gpio/gpio-xra1403.c
+++ b/drivers/gpio/gpio-xra1403.c
@@ -139,8 +139,8 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	for_each_requested_gpio(chip, i, label) {
 		seq_printf(s, " gpio-%-3d (%-12s) %s %s\n",
 			   chip->base + i, label,
-			   (gcr & BIT(i)) ? "in" : "out",
-			   (gsr & BIT(i)) ? "hi" : "lo");
+			   str_in_out(gcr & BIT(i)),
+			   str_hi_lo(gsr & BIT(i)));
 	}
 }
 #else
-- 
2.43.0

