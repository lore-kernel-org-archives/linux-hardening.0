Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011045.outbound.protection.outlook.com [40.107.74.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9321ABA4
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548095; cv=fail; b=kxiE8MlHPdPB8U9nIfympZ6PdFfGNVrm0lWJ/+ip4Bm37MXtft+8S8ha4c3hx4kQdciw8u3766X3nHi2ItEtVwV8EIOl5NyzDJ5ZqQbfZZfNYP/JL9LQyncYVECOblnroGZsCUM8hHf5+3KwR4C0B1Q66Y4rR+AL32q9Rn+JuAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548095; c=relaxed/simple;
	bh=i4AkO6d+yy4jF6msGtXWyllcyZGdt4YO/Lx1vYw029s=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=ZOhmoKnMDA31nuNUVC3wbVQ1HQW4h5CPZvMcSn7numMnTqTh+x5Tych39VQH6wUR094Xb6DKNALUa5N37tfiHiw99GNPDjjgthxLYJBBsg33HEq/L7TWGc7hE2N6v6FJ91ufAXUZpx4AOAL14+qAKPUalyysG/sF12c5jdyVFjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=N8kGpSy1; arc=fail smtp.client-ip=40.107.74.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="N8kGpSy1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdYSntYLs4V19FHdI0EYacuzj//RRka5F3uAnxZl4pxJjcdoJlyqx+0E9hlvnqVQq7rw1KDieFQ2oyZFb9URHOxaJUtz5Q5tGBbyD2zrB040h8ajUxGauhnAXnX9rn4WNF8Hdx7gfzuJpFWXfbiYyD0FD6m2HmXBZXm7H8by140pG6h11lkLsKoVPnu+ssGvNbhGD51Y4+1m9UK2GQN8pjoglDiksxq4Z53ggKyr/n2HPnEDJKRNaVr5AZDTMT7HL+AbEIWH59OhYUBH5EjLUewV7i94PmIozgsLA65WWPrXRQi7ndt8rwkDzCeR0jeU3iYWe1r2gNUdSLdP+ksSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T7ZmqjmlCP07p9p53xUjwnsRomRBL1T4zpXH8nR+nE=;
 b=g+UjFzSPBtTnhu9WGfoYEKVeCosg7r/0WauqjNKZeRcWA+cnJ8nziIHiCq02NAtTb/xYtMgtgvGpz5h9lI4yJ7rccXIhHQ4pkGyqmhQvfdh5GgqQltHweKHRMRCBCRlOWdlIXY/EW754MQ9ei7NVS2gySOTKd/9g2C++bA/4mrXcDl0ZmRhcfQhbf5/h8VnFHVI9S+BiCqXd9JElChQwi4/TfPWA51yGR7QAa16ZSDF1htQuDCn6a3AUoYfQmKw2Yog9TFFccC4Ds9k6bmD+vNcLkUj92DCfLskxJxdlSUw2R/AfK2E0mHaUIv+h+OL6/yB55hLjIoi33XL29NcO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T7ZmqjmlCP07p9p53xUjwnsRomRBL1T4zpXH8nR+nE=;
 b=N8kGpSy1z+QG3BaQo1NDxrO8I691LOPTZN6n1LvEIDb7XcMFm6jBRCkXN948xs9bobJYcD3akTONmBuO+mmKABDQ+tuy55zr50JfWOoFJuBQTNDQGoCKJJb9iK6H+sZUE608diL1P2CddUH8/mLITPgdgD1QU5U1HpH33hOZ/9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY1PR01MB10688.jpnprd01.prod.outlook.com
 (2603:1096:400:327::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 05:34:48 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:34:48 +0000
Message-ID: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 00/10] lib/string_choices: Add new helpers
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:34:48 +0000
X-ClientProxiedBy: TYWP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::22) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY1PR01MB10688:EE_
X-MS-Office365-Filtering-Correlation-Id: 262990e0-c009-4ce7-fd96-08dd562748e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GEpojqfFwNovS3JxUb6ntOUe1WLkWj8H2WsPlcw2vdH4dsdt0wfxxtgO9R3o?=
 =?us-ascii?Q?mjccu6zvPqhKDWbuVz8zxZJcqx1ewuu6y7jPE4syrycbqDcfYMveeF6jx0y3?=
 =?us-ascii?Q?WtVsC8rcbay2+7g9ptdvHSh36j6tnEXTjpk2CwEF5+fUODeB37ET81xV4KQx?=
 =?us-ascii?Q?Nt01QVONi0B+6sR36kFv99UQCW0qlo5vlopu+b44ixPPvjLz7z3sqmfWBjI5?=
 =?us-ascii?Q?JYx2qkgYGEdHtWX1/QJvdfWbWbiZm8ul2SVVpVnXPOhTEeDUxgPKUnFJMBwq?=
 =?us-ascii?Q?wHl2SiaMyQ55U1/T+iOADF48+tmyTTCVR6cB/1MTpUi7P4mTmEdNMAle4Zqv?=
 =?us-ascii?Q?NF/eDE8OfOtV4gWVBl5e/mz9O3kjUgxcfyL1ur0oExxrBYYAWiaV5lVCOrD/?=
 =?us-ascii?Q?pMOpVezhjM9K6rtzIG8qRuXb4OEZH8ga4MF/F9jjiLh8GGykDHmksXgzJHSI?=
 =?us-ascii?Q?7oW2SUvxUqhSwAA3oBoXnih5R8IEDGOXqLhGpZ7o4YwSBIrfiYeNKIPRGy7m?=
 =?us-ascii?Q?tGgZeg6pn876tnsvBUkJeRxv1GK/DyAtYOyhljT517k2jng5BOAuFPhX03zF?=
 =?us-ascii?Q?gzqwGUrX+oYQjrxf2LBXMIrjmau+U7bMKWInLuehp8nrrCsOYDAq/zycnsTT?=
 =?us-ascii?Q?MCnP3rbdNJi31ADK/xhmqdwM6mwlfre++m/OSCAjFwZ2SkqMvPIhJ8r79Gi5?=
 =?us-ascii?Q?2HTSNZhrNiU8OspFg3JeR7ZVmWwsHNhmBMlMB48E7B9hkU9vJY751G6WnFm0?=
 =?us-ascii?Q?Uc8/Ld7iD7ecNF8QdxfcMoM/i0qnZAy6aPTfu1ozQIRjk8isZC7zwBH0Je+j?=
 =?us-ascii?Q?Ozs8jQNmfe0CusAleyl4qvt5i6RtHododgheolSvQNOmuHbC/iE7PCpWUaep?=
 =?us-ascii?Q?f2jiPV2YMfdh/PRIn6nMnZJcO4yqQ+mK9W8A7L0zQuvUoQQY4XzNA5wUUyoX?=
 =?us-ascii?Q?31rI2wMOK+j/VQ8H1Tar49ewbAyTsSHdE0Ekr6ffyyB8bf3NX+qA1GRyJ9ia?=
 =?us-ascii?Q?weH5r4gnmKMlsHo46vhMDj5WeBYXv1wR3ehEj/KJHn3+owi7esU0zz3tCHqa?=
 =?us-ascii?Q?4AziEQFwA698KGUouRBDE4FUDRrQ5ghCseZgQ9CSqhyYSYTEOKFl4D3Tb1n4?=
 =?us-ascii?Q?RjnlcpkqWf+NFoCB3XJijogfpRBUI1Fx9s3hQnZ8gDC59Eps2B7RUjfV0hJ9?=
 =?us-ascii?Q?9m0fcyMEN65qmX7RDg1vyZv+H1SA08mHJCugLwivXc9MJJEHQyXHXs+82ggH?=
 =?us-ascii?Q?5/C1MLVtVrlMAjgRKvd6TWcLZGXvPsUk61i6qTOkcWffL5anP7f6uRUZPrjc?=
 =?us-ascii?Q?u/UnkJUL82VyaKm/25ApX4xo25W795+qWY/YRyG13kX2yM470lvVrzp7419Q?=
 =?us-ascii?Q?Mb4ZheIlkxeXBWWkfc1c/XoHX6M+rKKIZTo11M672dDKrxOkRu2E2G27OIlT?=
 =?us-ascii?Q?ZPcgd0SYpHVQcL53XEXaUZMla1ItuXoc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XeFSyJ6fLp7bYO+IhIXAghH3mv1nceuFGTJT1XU4+jOd6AP/kShRzUMxUw4k?=
 =?us-ascii?Q?YmC9I1dn7auUKMeSNvZx0H2QoFd0e+zDTmlKSiSWsl2xcLybZS/TS57U5hpf?=
 =?us-ascii?Q?yM/36LP990ChzSf3dhjDQ8LmGvM7smpAdthkuARhYwkNyO8slCXsW/5T9nzE?=
 =?us-ascii?Q?GnSxCP17e5z55oD1YQxrrRbfLChYIeTEJTLV+0qn7uVn0wuqunS4bqht7cQW?=
 =?us-ascii?Q?6DuAnPkiJc3qp3Zk+7YyGL0mG8mEZ4vRFNNaZeofjfLExoiC7N5V5hJuZqX/?=
 =?us-ascii?Q?yrhN/1fRRFAlPF4SbMRHubmNXdnMzF+ssBrb2bjYN0dYbXvYSYqLDJes3/uX?=
 =?us-ascii?Q?SfjKTUJB6N6lwdcM1aKuv+sdOrk1FduRJpjQIfefrz41BevoyYJ9dIWExrHs?=
 =?us-ascii?Q?891Hv/r+HEmBWR7bh/QyD4r1RXJB3iBynmLWiskC6H3prZ99xU8VMxFPq0vF?=
 =?us-ascii?Q?QSd9cSLTtcwa1Gdo6AyWYEu8ntb4+JtNDIcdrxl6DlDNbmHvFuqXvQ+slDbA?=
 =?us-ascii?Q?x4mkvGWvxg93yDzTPZ65/dkoDee+zo5d0jK3pfUQfHhL85AV4BmELFnKcu1R?=
 =?us-ascii?Q?VHVM6xkHAuhg3a0+Znzgi9QpF0BigFxf6oNcuwkdLtjGZK3TxlUJo+BjZi7C?=
 =?us-ascii?Q?w7ZZ2qBoJS1Zccb9Tjbp0uZwLOoOS5KxheNFBnfQCIcEPhQFT99SUPos/PNA?=
 =?us-ascii?Q?V8DrqGSyMGtWi6sowEs6SdMSrMCHLVh2qOtLU7JrD1pkRXjYfJBt86HnDWKv?=
 =?us-ascii?Q?TeuBbTfv3yKlvHGDv2WhdN71O8Bk9WyOqFDj4IiwZQUIB1o4lx89jaCPxN1r?=
 =?us-ascii?Q?+v2RnDC9bRHXgEYLqgrMcS6cFCJ6YqNf1+xW934GwBtOoZZszVRPok98oDOe?=
 =?us-ascii?Q?bxQDrsuIFqpL2MlDN15A1Hrxl/HswI4jh0lmv2TLpP7HFBKXv/eGrwU0wvSK?=
 =?us-ascii?Q?RLFpqJHu/OF6sPkNpfzGVPwoSc0oLmcUp0XSimZbraOmrNG3wtfwwPtZjDkw?=
 =?us-ascii?Q?O2n6FTpVjMtvM54jTv3nmmvJ6+NuZuTX8HZUFH5aKHQV6dguh27XwJs/75qp?=
 =?us-ascii?Q?XfUK63xd8u/PpS1vBVqN8oyh2IaqzR6qq+Lavaxgcfdn0akRjLdhNoDvOv9m?=
 =?us-ascii?Q?63q3uisxjvkSU3XcADEJ00mrPfChqAX9QkI1hGwN6gxocxkpaqWpJkf5QqDE?=
 =?us-ascii?Q?9DVry7wh8ZGYPvP2fo8ILXIXYSGvDChPjRraEgRW2qv4QqfsQpH9GDU5QNeh?=
 =?us-ascii?Q?SiFqBl0cnIzLXAbavQhIdR48MtEgW4nApys4M2Fd8+zceCMcszib2q3Em19T?=
 =?us-ascii?Q?nqymhGeUH5cIhlva8lXdPEYx1VnK7vbz+1s/F3bIF43zuTvpIMnnKuPsZkmX?=
 =?us-ascii?Q?ie54+strl/fUaiBcp7ex6170QPJYNH1iUFioZHLwP506lP4qbP5dZBRsMXqw?=
 =?us-ascii?Q?QStkJERpj/JiUkaGA7YWm8+Gw4Y/rWlpJqJPYPRJE7jfjI+bTuI+YZ++kIIc?=
 =?us-ascii?Q?uvQMvxjrAPQSVGv9lJ/OpubeSjU5Fw58adCOgwF/+I1P2GY30aoHhfxU5v5J?=
 =?us-ascii?Q?O7rbmILO1yetao7nG+0rX+LHDfv/yo4At1HBf6u82GSGdhqeo1mUxVisytea?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262990e0-c009-4ce7-fd96-08dd562748e0
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:34:48.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKacJCom8/H7wJfsSRgsxoAtCZmfT8gsBgV1OlYxWOUruOd984TrcHrDiYogs6BPScLiQCVb0z7uOtTVQ53lLt+u9zxyS4B3Ym0VSSxt/6Htr4YbkvpATSCLWnOk7g3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10688

Hi Kees

I would like to use string_choices helper to cleanup the code, but it missing
some of well used string pair in kernel. This patch-set adds it.

Kuninori Morimoto (10):
  lib/string_choices: Add str_tx_rx() helper
  lib/string_choices: Add str_enabling_disabling() helper
  lib/string_choices: Add str_in_out() helper
  lib/string_choices: Add str_input_output() helper
  lib/string_choices: Add str_Y_N() helper
  lib/string_choices: Add str_pass_fail() helper
  lib/string_choices: Add str_to_from() helper
  lib/string_choices: Add str_level_edge() helper
  lib/string_choices: Add str_kernel_user() helper
  lib/string_choices: Add str_attach_detach() helper

 include/linux/string_choices.h | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

-- 
2.43.0

