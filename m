Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011016.outbound.protection.outlook.com [40.107.74.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB133D8
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052633; cv=fail; b=Vw6ZP+97FqYdVxTCPTilOINSEHM+UcYYIdtKtxavwkoogEQwrotvSeFjmH9iQUevPQG9OQYiY84Gs8zP4A898Xji1CoI+iGu1QqpTD6UZMX8cfxMhBA/1uYCZQhBR3NVl7ASNSzatYRQF1yzZnc+MOk7y6UIPj+uGhQeg4AliM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052633; c=relaxed/simple;
	bh=UP4XBqxKBKqacvQakRCdortYe4OC3MXMuDZZWPe1GBU=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nhLcdzybyekNoS1ehlYZXmPchB/cQeuHVZ3xNv5TXQWYCMqC48CwUKjcqCTuWzSIvNLuN7FL2xTH7pGXEFt2pbQ2uHcby+oNhjnVvKKYPM0Zhu5tM69QS44KTEIXgiBMF0ZuegP6QQPagtbxBnSbVolEVy35LHQL0RutDahE2DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Xyg6rf7J; arc=fail smtp.client-ip=40.107.74.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Xyg6rf7J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhL71aQ8mVUSICwQ36KiKCiR/BkcDYovky06SoP8sDvZ9SVDjds+kCtC61LRL6Mheo9yvcttvb4QneCZ13MgE/WFn+Au/LQuoJ+9VMo4ieJp7ggCwPnbu9qPVu/maVsHCdjdiaN1NntR9hWfvI2f5BXi1mkc2uW1TAaGiDHAq1FCTUZdRp99SFNgiWmrUWXNoH8AQ44TQN4+ljcPv6AmxeetnA25DAZo5+TNIpYJMamk6J7LU2ZraDyGjoCrcDzZ2Tx2a2uxYyCiRFE+D6n+pFpDITffMcRd3MH5V1WPMvmNi9yBSMc9tt70uKHP3tw+A3mIWzrGZLBgpoDw3kCTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJaz8el7coH97QGuKBIDh92ktJz0bSqsPAVuMfEgw+Y=;
 b=asuQh8icjUvt1vx1nYXdRVX3HWYR8Yh6fiugLTkF1neeQ9hJnKUohOcAXEH2/DwSHOZQOQ+6bSDY9/JIPbqm0PCyHfeDJdi3oU+VBwYQNYIsTABqsPMpVofEwJF0uYvlstJWErKl9E9c3Ob8htX6PNXWeTks/HiePLmn+6PMvaMtB1UjIyVtOe98y7o5tr065i31ItavXby1Hlm3xZLGkQZlwOo7YPWSeFz3qqh5w1VegiJVI7gH2iTKDhYqcWl+OUdnNjxClU7arVvOT/E97LLqMw3MZkRBtAdOCC+B63D7ZJv4VY9e+4gfSlqFk0YlsBlmnH8Fl9OeemTX5xeFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJaz8el7coH97QGuKBIDh92ktJz0bSqsPAVuMfEgw+Y=;
 b=Xyg6rf7J8bi1dTECPWTBiTgc4paSlf4BGnZ9n9+ZTUsvhvXgs5GucAMBGLwUHKjTCPbUZgIl9F4GCMoTYuJmVnL0mTuEq33LFPU3yOo9Gr5koe3L4dwlocdGz9VjFHnSMyARrtCNRBxdh+2IMF1goZdL0tnKRvHcps0rpXAt4J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS7PR01MB12008.jpnprd01.prod.outlook.com
 (2603:1096:604:23f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 01:43:48 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:43:47 +0000
Message-ID: <87wmd5po30.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/10] lib/string_choices: Add new helpers
In-Reply-To: <202503030912.11512B29@keescook>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
	<202502281143.149423E53@keescook>
	<87o6yjyqeb.wl-kuninori.morimoto.gx@renesas.com>
	<CAHp75VdX-ZMf-mYrnA=DYszK8KvjVfi0kz30WfHRN_oYOJR_Hw@mail.gmail.com>
	<202503030912.11512B29@keescook>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 01:43:47 +0000
X-ClientProxiedBy: TYCP286CA0317.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::7) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS7PR01MB12008:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c39967-32d0-4b1c-5e59-08dd5abe01c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QxkJfemx83KSuK453SBzTQsV7o14xp1WA+VnXCnvh0Lk/0AeNmuBqQpwMt9w?=
 =?us-ascii?Q?Q3GA8xnsECS2qy7MSBjCk6fyH1MlaMsvv5T7fnk5/LlVGgVLo4/cFZwb2PX+?=
 =?us-ascii?Q?44NAs63TnSsEZODyCjMy1uQF5GeUSk9K404XRKdE6FbkCfMoKuckXySEY9re?=
 =?us-ascii?Q?CPzhs0JMpp5d9ksbFuE3QkX1YZRY0Cnxv0EnC/fUzu1GXRw9pqcl1VcjnaK0?=
 =?us-ascii?Q?WuDUfr0rpr7t7GFhpI/ddqoACaXpGw9Oavvf3Z9MslSxNcVxq/UIqV81/hxy?=
 =?us-ascii?Q?/LKEke4naZYm26mQQKU/mu/SpCXmTyHA8KF2F4giBKUVWVvpM3s+vaY7ZA6r?=
 =?us-ascii?Q?8FYkih3nCf/62XG2BVljZzt+ltIki9eRzzQLttHACVxW50WZhYPVjw/X+TCD?=
 =?us-ascii?Q?vJHxRquaXjiEVO4fyfKE/ibg4gQ26zfgDLoekv/g18ta0Y6VGFpxbj3zhCbh?=
 =?us-ascii?Q?Q4/Nb5cnJs5QwPggrH9Me6r3j+2REJ3feYu6UopLvsrN3TOXCez3BbScmmW1?=
 =?us-ascii?Q?giSzBz3RmcFp6w7D8ekmjTn8d9rtSMMahhKklT7zi5tB3xGdd00s4z1E/eTg?=
 =?us-ascii?Q?P5pqVAJFBQcq2lXBlDsLQxUWfO9zSR6vNFBkdJiiC6fzadaYQQqTqnAZxaak?=
 =?us-ascii?Q?ok4AhdxWWm0oX/tqT8L9iAgaUbgYDPr0y2sviLfHIqHhUmqak7wBWG9FPUJV?=
 =?us-ascii?Q?fdBNjxl9E/z2qSWTSCCzLq+rjBWAIFqncH+8yso4jEsvX3A5b/nMlGWz0AH/?=
 =?us-ascii?Q?FGIxT/uQNTMxx13Y4YbEakxVrpDrfmU1YpFFyrhupmL2XdiMIgBfutHlrpdE?=
 =?us-ascii?Q?bK8gisqy6mD4M+XrStx5QhvcZKo4XIEzzTEsrZ9UXb3GzZDKvEhQnUNlib7U?=
 =?us-ascii?Q?ppQVSIbSqerB4nCg452QcqdW6FXzcMOCT5bUBkoH7AXoXGDYDuEchZSFZIQT?=
 =?us-ascii?Q?ezqnLJNqDXhljI9pA+cFjgg7x6iqkKJq+CqFvq+0AHv7omXCrUKo0bU9jaNZ?=
 =?us-ascii?Q?9d9ng8K9Tg77X3U5ZSTAaxYO74rF+Df1OitGIUooczWlyghVj7kEcDJxD0Ae?=
 =?us-ascii?Q?A5Q5fSe9BTFX6ivfMvc1xFwwUbrWHy57PK2Lw53KYPFcbtDchXQVRFpR+KNt?=
 =?us-ascii?Q?+M1XSMh7DOUVIFSW8mNpMTmmBTw2xE+Jn4/9BX9nAOf+N2aVIVZN98lKEnnq?=
 =?us-ascii?Q?gBnucN/m40gkfnFoTlJmk+WOoeNR20FiHUqF9wXsFTs1paujAPAmjGjB/68N?=
 =?us-ascii?Q?FEJ23D5krYkOMRjbiwRcDh+MUi1v7HxO22Mv6DrstbJe0PqkDHVZ0QiP5oHr?=
 =?us-ascii?Q?yDZf2WYUis/jeUErCd0X1E7bPEgVEGLjIrgNF4CV8Gc6j8XmxxJXqnutfo4g?=
 =?us-ascii?Q?j/muQF9KzXnTwJTGhuyD+pvSCUvR47UKm7vDOLwuxQfunJ0PEUMSJuZVCLZI?=
 =?us-ascii?Q?i2jeHAZDa712hf7f0kT1cbc2DFPPkQhM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uzvnU/2YUeerUo8ddVItly3FYKUEpBFB6S4xSjVXh3sQajVp0GUq7XEFVpUQ?=
 =?us-ascii?Q?awzS1o9CRr0DMQZURUu0tEeMIl9QgOJ3OAdDlsd4ueMVsA4qYImK3r6RYUK3?=
 =?us-ascii?Q?IzMVC0+Dv3gw5Bjyeg/aJjHyh/4ZuQvDbUH8V6azorsEZvGkIzKx4yM/51k8?=
 =?us-ascii?Q?OIGoJ8KVXm6lItVD5QRUdi1Acqct3wyOW7/fyoI5fw7SoKKrWqNNF5rIvAwK?=
 =?us-ascii?Q?/A0BfUXCJJZkA86+y+4FKAixIb7hS9mQb+/2amzNdQ5MPQ0zNz9Cbs4xzV9P?=
 =?us-ascii?Q?IVs0aN1UUhKptDZL9eEtLf1zrpniqBnmIbbOnRxTRa+gwLpFOn+pI78UDNQn?=
 =?us-ascii?Q?hVGKYiKP0awRG4JunmrR1C1CgWWKJj4HbADT1/xmSJqf7VCA4T5J9oAuoQJz?=
 =?us-ascii?Q?RIEPHRQnATjvCYVddLFDbDggXbuT4MLdsHmbZpe01vABYvKctGe+kTaHZs/U?=
 =?us-ascii?Q?RH51I+5idQ0bCFZvzDGUMRKULm6ZURo+NmNviVzr+7U6P56fZdI0JzPkEcmT?=
 =?us-ascii?Q?mv5F+qswnSSgMKWNrh0Xl3ulvnjVG9JVCLjyCGcGFcWEJw8VtTBn4W80OX4V?=
 =?us-ascii?Q?42vvSshRU39BzrOE1K1RTzqcYHtMtZ5waz8OWYG/iFuv3t8kNJ8sHahgKCi/?=
 =?us-ascii?Q?eiwNtk2I+q5nMq1vNVQBCE35Pfe2+1EU1i2m+XrL1o0hLsSunC0pMatJlivm?=
 =?us-ascii?Q?AzLrTJUJdTwU3KwoddDuhyYRNtoD65+D9BtgUaV/P3p6S7DR5KOanOWPeSUb?=
 =?us-ascii?Q?Ecs0yz4DP4AE5mDOpRAL2JUsekxm1A3QSjXZjInTTW30AfZxhCm1sd2ab4WQ?=
 =?us-ascii?Q?1ZLSR+1sv92uRgVEp8DDI8Csn9NiMusIV8RUqGhY5gEjpEwdDl6zOYnypcBh?=
 =?us-ascii?Q?lkoO4RhOtBqL0ytNAmj0ErtOFpZWLFK5OcvENoiBZcag7gBtftgFGSVN7doX?=
 =?us-ascii?Q?dWML6KB0QU3saGuQUmtrHhXHALPaCGCUzACNgzNN8gLAWMCSbOTXraNOj+aA?=
 =?us-ascii?Q?uZlNqmL/bJW2qy4NuwRJq1HLjPGYf0MPQso5X+PX7Yc8ccoA+zyNMXRrRxib?=
 =?us-ascii?Q?JUkCMaXZOOaYlDcB4aTa/1OqMyjJRbJPZDdCC18+gRmb8AauVW5ZxCvr/8vS?=
 =?us-ascii?Q?k8yukxL8JmaXKvaTo1yehTb2W46KEHrJhKJ25GgKA8LA5Y4YkueC5hB+l5eC?=
 =?us-ascii?Q?8ttapXAhGHV8wpWF9UX41+DUlr5Og4sEs4TR+MzIu7Mh/4dEwtz/sdBDXSdn?=
 =?us-ascii?Q?t2FSJfpsl3FTehDRsHwKPGMjDgzAjgBPUVISNFFvTlzrpX1+Lm8eZqlS/N1f?=
 =?us-ascii?Q?DIg9WUE49IH/2TjuOp/q+CWgfEDjSFPDbUHJbmASYr3XD0Nj0CoToiwmi9uW?=
 =?us-ascii?Q?rBmymKEhtq1ctmwros5wPYZYW1fv98KkEZVLc3HLfxN6Qx/C4yXnOAxN0oKN?=
 =?us-ascii?Q?bdRtTGw/PVrUPhCFs6OFxEBaOYmjbe7Mm3DOEtYc1ru0shxOkXoIDfQIX8/t?=
 =?us-ascii?Q?ysVt5PsDnz+7SGGTAocAxNSlW284kCB7BF0+M5rFM9mawlIDWnkd30D82gJJ?=
 =?us-ascii?Q?jDd4wVb5xDvySlE6aEKpCwhKjmJc71rwcLOxLe0KgZDLEO1cJNkGALw/B3aC?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c39967-32d0-4b1c-5e59-08dd5abe01c8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 01:43:47.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwSwkHZKCRVrqv2aA/18vMRd0hUWgZroYQ3kUd4ahqUJamcooD2rHx0gK0R5OwV6F3XxtZnSdbBusTPCIAolIu1smFha/kNUmbgW5tBijbxTUstxardnZ/J/lJIpuG6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12008


Hi Kees, Andy

Thank you for your feedback

> > > > Do you have some Coccinelle scripts or other patches that show the use
> > > > of these helpers? We tend to avoid adding new helpers to the kernel
> > > > unless there are active uses of them.
(snip)
> > I am not Kees, but my point of view on this is that you may take one
> > subsystem which, for example, I can review (listed as a Designated
> > Reviewer or Maintainer in the MAINTAINERS) and add sample patches from
> > it. It will speed up the process as my tag would suffice. Also you can
> > add into the cover letter the statistics (how many drivers are
> > affected (per subsystem/folder) by each of the new helpers in the
> > upcoming series.
> 
> Yeah, I'd say just post the series you have and in the cover letter
> refer to this series as a prerequisite.

OK, I will post v2 patch which includes sample patch which is using
new string helper functions.

Thank you for your help !!

Best regards
---
Kuninori Morimoto
