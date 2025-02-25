Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011071.outbound.protection.outlook.com [40.107.74.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A8367;
	Tue, 25 Feb 2025 03:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454847; cv=fail; b=EfNPZp82bw5O3A5yN7UUsbak6qucixVhIaJV9JjPYzwxuHUn/qNS1XCl4BFgMu22693rRomvW8s7PKwa1W48Mr9GmLx+uFy4STPYD2a6MB5OvMZxgR/3blK2Ixa/z0q7uFUFQqCNJ+jGG336VuPJWVZ7pXInjXwA0tmrHg2CQi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454847; c=relaxed/simple;
	bh=z6mcIvtnUWQYOQSvoBFPx7/JUFx4NBk/iJaVeNNqlyw=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=IY/7G3q7rbZgQGAl2r2iL2zev8MoAPjauPbMUznXBdHo89PTz4Ci3ly8F/ehtS3GRFdVzoYjvEeOTyaiaZIR4LhJRniLgHuniuqPo+cQybVNcZC4kqSHro+S5056yZs2cignNvZlfLedhcc1kSQ2sU7xGkRaVSXrgyqDp92nN8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WbJE7U5v; arc=fail smtp.client-ip=40.107.74.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WbJE7U5v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ2TeuLGZAur884/bOvioEvmlHtzc5QKqenm4XbIOL0D3YOa/iccLQjE82pAkwhRbQSwqOyOpUgegvwcKsFBJQhwSP/9eFs7R4w2eAgZ718ZfhMJ/J4hW2oR1vyxc2/0fznnggcf3/SpsDuwwWIxcqBb8gbsqJYBtR2KGqB5n4kIc7veRGvGqoJkF8AQUaNhYI08OM+BB93YXwo+OY+BO/FT+qX6wO9NAiuP7OkK+5hb++/vPbpCV0pJSPII2n23bquo9zvRNZ2KbS+Y9LCC54B+SMooFWRSF5Bq/vbKjnl+I3u0CY49WS7kGTgVhxko5EL8jH2hgloU17oJQ40wIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuFNEbDIeFDpvp/TS+4r0Jg88+KbBSbgpG3yZXIVHZI=;
 b=DZLjvv27EPFbzgb6YXJ7eK0zkkK5lJIewKiXi9+nwqSyaXVcXP/kYkq8weXCugZFvRCVCyhlFWLrypJJ3GCItohpPcESibjgma/U8rt8Px92hxe+si/hY4vduj+cKkUarBB6+z1uG6PkJ1qfr9opzemDTeYUD8azjgEj/TfQzJAOy7IHeWKim5yoLK2/WFI+uT9pMgI49IwQ+tyKZFLHI2DkBCI9goRBWAzy/6Md+IqIkPIDhqaYC8x087ZR9ScjdAmHlTxK5e0yhtSYsyPNExhhOcvaNDTO2e1HlUvUdbkCWBuGqHmIJ1yySHb8a6jWW/V4qbu978QHA04dHwlT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuFNEbDIeFDpvp/TS+4r0Jg88+KbBSbgpG3yZXIVHZI=;
 b=WbJE7U5v2/VrCNhstL1Ii8bpFbVQiLlzqIjJaGGKJ6xYBR63kxMkWLiH7C8CLNCp/NWyOhMdRr9CLWNY+1zqF6FqdQJq+1OSgMow6DqA17psYEVGbv49TtsF0L4FSvbICYLPFTERMK5noFJ+716pYeFwobcQNqVbr47ROFyfE/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY4PR01MB12797.jpnprd01.prod.outlook.com
 (2603:1096:405:1e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 03:40:41 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 03:40:40 +0000
Message-ID: <87bjuqsnd3.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Question about strings of string_choices.h
In-Reply-To: <202502241928.4405326B13@keescook>
References: <87eczmssrp.wl-kuninori.morimoto.gx@renesas.com>
	<202502241928.4405326B13@keescook>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 25 Feb 2025 03:40:40 +0000
X-ClientProxiedBy: TYCPR01CA0198.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::19) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY4PR01MB12797:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d8decf-ccab-4350-d1ed-08dd554e2cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+4jBuNVA7PFZqoQvnoy9Hs92KNn7fLmaYc+azvDlf+jjZSlf00RR1B4BXkpB?=
 =?us-ascii?Q?V3jUOxI8rWE2Uidc50fe6WJkT7OgHXtOY37L7ozwErlHCu2yXD4DIm34B6yR?=
 =?us-ascii?Q?QHSKDkRAWFnhuPH/s4O4N1yihyKn1u+fmUwE/j1dWPr7zXYM2xlcBHE38WXt?=
 =?us-ascii?Q?SIzu36o8lWC3W28YXUdmW7hJLU7CYw3RWbhLxXnQJrcUt0fFJ8x3Ooe2rDZ5?=
 =?us-ascii?Q?8AvpE4tRGJV1ZiyLeuIa9GaVPIypbRM5fZgf9k+MyWTtoUnmaAdVERsnmjvF?=
 =?us-ascii?Q?OC4PRZAQP4s9XQbu3iaVRjajjHpCb5k3W88u0vXd9SQH7dBR10KlVywudjkm?=
 =?us-ascii?Q?5EdDjFZzsZQWVTt3HCzEcCzqp1PZIBeCzI9G8BatgX/9wj3sna6B+yo44mR3?=
 =?us-ascii?Q?30Uhs7rhFoYMznIsNVewD211rb0HilnQ+amID1b3LrgZJWQwYmFZUpeGy48H?=
 =?us-ascii?Q?Rc6QdJHWG+f7iZ/CmBt4zVKT02SA8YuYTVIwSYrOaVTLih3EWFiC3m+/LjAy?=
 =?us-ascii?Q?URPMkDzc/pzFL36QQb5dXyxo5xi4JpDEkCBhQWKfg7ueUih6yd9jYck5W8vr?=
 =?us-ascii?Q?mEIsBmcyBQSwd9AbLUX0t8PcME+NhFAp50SvnT4eOKugRnBJXlVTNpHpBZGs?=
 =?us-ascii?Q?l4i9oJ0D2d3il0pOWQ6Yp5+q50eWYg3txWRPDkOepRBeqPmQoZB0AcUyfwSi?=
 =?us-ascii?Q?Vor0EpGZzSWk28enMRGxeEkLUWD/sLjIzzewW5nuJcQaTfh+uWhRYkeqLnxc?=
 =?us-ascii?Q?9PrWc8/rYDRO5HQ+Z7Q6FsgAsk6aPoF9Q5+BkIEx6q8enaEThVedMdfxPsT5?=
 =?us-ascii?Q?LKQSt7Q3LALGlyblPGkA52b/Tb6pv0l+u+3QnziI7yT5h934zi3/NmGuXeKb?=
 =?us-ascii?Q?E3CcqdZwtbRT/ZRKL5nMMmYeyVEtgjg4eOb3dTXBb0w0nt+/QLzKpJMVuUKg?=
 =?us-ascii?Q?B/ow1ZYQrvRcQU5hR/knFyH9bHocIQEByd9/Vmn0KRp0C5dFBn0Kf1Lr2asp?=
 =?us-ascii?Q?0bHknOR9HGUvaYKYL01qIcAc8FExIeO1JIDYHi4+yHnryflnTKRSoPE1HCZh?=
 =?us-ascii?Q?e9gu7sIm0uo6EURwn0lEDvNuGFi24nDwU6owYR9eYuClR/seIix9X60Hz9KP?=
 =?us-ascii?Q?nYGZlssvWX2MtJstz01a52AiqavQ+bBAfobMPUEbQEBBZVYuydO+fXZTiJYo?=
 =?us-ascii?Q?XqyKrwC5A2ofrviUg8exUCO7RxJmIejDEy7WjUSpktMmgDPJAafSA7ste5UO?=
 =?us-ascii?Q?Oc/LMUUDfa3SeIBX/oMa12bwW7/xZ6g5f91YRc9RFPrCxbb08L3x+LLieiP/?=
 =?us-ascii?Q?N5+ztw0V7P1hy8rzwhjV4VFQx2Lv64ftg7cZY1fIOc3EudZ6lxm1CQKdemwx?=
 =?us-ascii?Q?acIfySMVWEYHaHCCLbHiiqhgP/Bn5JW2oOfxYJHhMD2n2rUQvMEOObkeosLo?=
 =?us-ascii?Q?fGkYOWuxcywDG0AVxgWdOyP3xcIhHhVh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UdWt+Nf15ysIs3ei+M+c+5q0hMMwUZ286ydKTara+x9pOsYR9SKjYAkv+Xvl?=
 =?us-ascii?Q?nlajt066COMFZ0NBewWe1ThmchRIBM67BYlepEtCFYHdhMia6U4f2Aa74GPi?=
 =?us-ascii?Q?iFW5ZfteFH+7HsSHocfNf5fARGROLPLWzN0i13jlyvUT4Ux7BO/i05MEbxt7?=
 =?us-ascii?Q?zGcJnhNQS+vAYGuiTrcZIO8yvA9l6uk5yeOgUsO5J2D0XP5oOH0XoMZG86q0?=
 =?us-ascii?Q?duUzvtIyY7aXM0h7mU4J7fituW5QE7zQi1BJ10Krjok66c3x+NzBPy0Y5rok?=
 =?us-ascii?Q?HJJDgqThk4tlCDNI/4GmpqdJrrXLozTUcMxuORqOAdDNNq1emUYxpMl1RSDS?=
 =?us-ascii?Q?YjbNqupw11J8UuBfPO32oW2Z2zRQDfAt90Ckvp2yeuGw/rwvmvjhPa46OJdQ?=
 =?us-ascii?Q?PbEuXXnzRnCzCxPHvPPIQNy/mLcfjoYC7VVwhcOg13VtH4ovPe2nSCRswgnU?=
 =?us-ascii?Q?NVQs7DCzK/Bz2QoTORi1G5tOuTtWgQyDha63izjRFEz0vIzqzIbfyfeBvTqn?=
 =?us-ascii?Q?IwSmQrAf706R/U35NGe2OEdtoTRuUAJPHRlnT+YRvtYiBh3yCLyWBPcgFtad?=
 =?us-ascii?Q?xe1UwwBBuUys8B2z0ZvpaH4FoUPiUhYp7vEaa/BQ+IbWE6auQugDr3U7O+ry?=
 =?us-ascii?Q?a4kl1KGVMTnSm/RGJU40lss01aIS9Hcv3vcREbdY27iZcRE5hSPzLUow4jLP?=
 =?us-ascii?Q?mT7+zU9St0dyTlRdC4NTcTSPJg3iSXlWZ9ZlOl7P4r/e5LQDka1HOqTZ6jpw?=
 =?us-ascii?Q?rANr+Axzv+W29+2Wcl+K7xKUW7jtj0U5iX49XCCvwUvcrjKG2ewApsfSaDfZ?=
 =?us-ascii?Q?Bxq3kIUwDRaCk4zunmgqTTbu9HEJY7PvLEMuIVmZV8CXBQLD5vLtG0UAvspv?=
 =?us-ascii?Q?uWfuIR+u6PBOo87XHSNK9ptD2e34WOa/bQbfVKRfiSAimCkJbb1fGLdTFcuV?=
 =?us-ascii?Q?IDWHlzKH479DcNrBzE92hEquoQLkuHFb2lbYKBAwZmi4FBhwP6UfZir/kQog?=
 =?us-ascii?Q?2i9B/iy2zDm9SHGOGbT0aBd1AyNMZMj8CIDziM/0smc02RXonYnJWBzyVbei?=
 =?us-ascii?Q?Bo7A07jmGwNqIF/i/P0HykfPOS7QgajtWsgU3JdxfNCvVa6p2+HVkjEIeYkZ?=
 =?us-ascii?Q?eFebcQ7971ybvmYk+KXSwT7FRQzCNLTu1gA0VbDZuJ5/mquzWgeHM/SnZxOo?=
 =?us-ascii?Q?cVJQOYrl5q+XfMj/iHp67J8uOCF1Z+Sv0g1Pcf4guso101b9CcF8G56bDXJ1?=
 =?us-ascii?Q?xmscPo5tIiiYspFJ4v+AMmXy9YUiJkVXfsLfXOrSWvDEmzoHsyUPHGvun3rd?=
 =?us-ascii?Q?91K8nHUmpFOgZ6t6GWzH+vQAQ0weWibAC8NQ/V/SE9PunCKrmEPpcunnD7o7?=
 =?us-ascii?Q?BPIyNi1jNIaDQhOzUVlktqyNL9gsaxvW+bom4CEeH1IGjmwve9NfaiSpOWaI?=
 =?us-ascii?Q?FTACTqpxDG/py//2E4tHbNHBrYE26/YA7S1gviUW5H6l506ST6y2n21CytSk?=
 =?us-ascii?Q?7DCHReyyD7+/g2sJxvWKRY4dOQJwH5TIoX2oSn+J9yvHKpoFO3oWV6rFLKTu?=
 =?us-ascii?Q?V19O3ozcMQ+FrgeGGNdKDsCGreG8raXQqWovzxgkPAw2TIM2ZwpJ5ibAZPgq?=
 =?us-ascii?Q?mRbB7KRkMRWFfIJtJs+HaIs=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d8decf-ccab-4350-d1ed-08dd554e2cf3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 03:40:40.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vp3+sTjQpQTyRggDMJ9TH7qPDP1MlVwHcl1jsAMqLjWJzhHb33t8GgTzH0bqtuvngHyWqE/efBDf7X80GhqMe6sqEpJlUCIvFTf3nqr76cdo6GaEG25nulSzoPQe5pcG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12797


Hi Kees

> > I would like to use string_choices helper, and want to add well used
> > but not yet supported strings. But before that I would like to ask one
> > thing about it.
> > 
> > I wonder is it guaranteed that the strings were persist after the
> > function returned ? In normally, function local variable will disappear
> > when it returns from the function. But I'm not sure in case of
> > static inline const, etc.
> > 
> > If it is guaranteed, I'm very happy.
> 
> Yes, the compiler puts them in the .rodata section, so they will always
> be present.

Thanks. Nice to know !

Best regards
---
Kuninori Morimoto
