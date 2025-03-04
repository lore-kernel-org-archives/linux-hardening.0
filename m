Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011019.outbound.protection.outlook.com [40.107.74.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45483BA2D
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132284; cv=fail; b=EFnITGhrywMK/ow9OZwlVArmnS5JAdsWI0AFNk3bNH1Cl9mWAM/z4nrALLGQC6+IxFLbD0mshNXqH0NZq/bniZWKjiE/BgyEtDGgfclXR+IghSyAqyhWvE2TmmiiZlp6fVOECqu7Tb3CyM7Soqp9EoeDNItdB93ha6AB7fPxfuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132284; c=relaxed/simple;
	bh=timKwJ3XjnKDG0dWQ+HzVWtS2q9O1l70im4ErzXM6A0=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nYuGlWphPQ4vjIbv9C17YGr8Dcgo2c9GjnaSei6YyOOxVOV+J9kv6CbFspJiKRay3w1UdmX/XBwF/PU92nywcyls4U/a22NAk3rp9HtYBPngnLMjmOPhmlbeuOPecxwwPOygIp9fdoc692izo7A5txdWE2XrOgEBdWGTEobWIso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=l5QUiiQk; arc=fail smtp.client-ip=40.107.74.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="l5QUiiQk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGAp1dDpOYtAEm9414GQiq1hXdFmhzFTvNeTcZJmc+mn2jOsjTGX1cVMTE9g+mDTSjqmA73gKOhoDkZbxhwmv3BTe5PZ5/AwxvFrT2MaULKOVEIahB72cUuHrDWkY81auKs+XvtLCLByCuwpC/DGtOwzqbqfxib8VlsP33/C9wHvrDap2qE6L9BjMBKfycmixGzCH1QruMCyICRv7fs39QHaEZXCAgNUxeCRuZSonvO9MLHJzopfZeGIsVpe7J02xnEJXh3IDXEQe4PmygssnEUNl7Yx7ijAzzPHI8chpzT69UiQw/6Hiy8SB/J0goM7a1LpbVon1piS5tAcLBAllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHknT3plkKoJWS0pHBR8zLqsZVN0E1miULNR2DvIkzk=;
 b=LDuzDASrXf+EvuMNZXNGNAJ7PEWSGb9bBu3jBRpFKS2CkIqasmLnI1lc7Pry94mPxzrBkkl6dKP3pBCvLLbpKUTCckBp68SEUZH1QxPs/ImobdtZFWiL5eWGaTlB83FX3wh/D9M/a175NrhDzf97YqUCkfbBumRhaWBSXrNftmGgSwsdhlX7krVOQCPilZk1qounvktjJskR5vbamcmDsCG89C0Y57nYVA1sNrqMLUKenDhi19qNpUsrIsFxs3ASMrDRNWkDB1xkI1yxk5acnXvk1ZQOX4/WBwFzAgJkckF2Aj6MSI30q5BKObfJ2TnKN3MkcwWHvqdjaGHK9Nf1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHknT3plkKoJWS0pHBR8zLqsZVN0E1miULNR2DvIkzk=;
 b=l5QUiiQk1I2vOUhqJbzj8QpBXsgFrLG91hGBK7z7/2IM4dZXQqKveA8gNzNP4vVU+H0rOiJ8LOPxji+EZMtuQnLyjq7UxfD68nx56JdGX0nKZeK0/CHAh8/QrPB1pvk2P+4vygsV0ZlEJFEsoj+WknunCQZ1nA0wX7O+RfYNrGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB5964.jpnprd01.prod.outlook.com
 (2603:1096:402:39::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 23:51:18 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 23:51:17 +0000
Message-ID: <87wmd4z762.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/10] lib/string_choices: Add new helpers
In-Reply-To: <202503041222.6A4843E77E@keescook>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
	<202503041222.6A4843E77E@keescook>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 23:51:17 +0000
X-ClientProxiedBy: TYAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:404:15::26) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: e13ac686-3e7d-4e12-6ffb-08dd5b7774ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wOsX4Ogzosh2WtDpNNQMVOUPVbpxqvMFBnKP8azuuf/XBtSWRKKakAo1PUnO?=
 =?us-ascii?Q?PeowH9QpkzLt31lM+pxJe9wfFVKQj8UYBppNsKBDuVBnKyu4p7XyKHsBSANk?=
 =?us-ascii?Q?8XHsYJ3WkcfH230yW++xPpTvFC4sK4Z1JvD4hP4Rc2nX2RbfkeOE3MlUfDOy?=
 =?us-ascii?Q?Be6BMgqJomSZediXBpyrDxWMv5ag8l4HXeD3+bPVvqxlJcPwAS13egYisWxz?=
 =?us-ascii?Q?IY+3e82NBoSJZ/t7kTqfJqlSexjpn49d2PKL79aXEymX83YPL332yuN6NxOX?=
 =?us-ascii?Q?NO2s7RhdOfRnGSScRJTwb6f8TRI3W/d20xxvEgvU9jBkfVcnLGl7Ik/aiNW3?=
 =?us-ascii?Q?rypS12w5rfJwGJIlJjTYAHrU0UdCJc5z6zP8vPCzou9f4ux0bpA+ll2zRroZ?=
 =?us-ascii?Q?1wDcUxVM7fnYbVda5Y5YzFnCuevuf/8TusMuiTNl2sIA/mjEazJ4L1Mn0rWY?=
 =?us-ascii?Q?2mJuAYX+sP6LT20ggDy7o+Deo/8NFvawvciJOjaczB9se/nmITpm9QEUSpRV?=
 =?us-ascii?Q?4DZ2yXgzzD0Mpq0PZX+tS8eHvbJub+YZFc6TTah4psabaBGSsrrOCc6kha37?=
 =?us-ascii?Q?VA0UP4QCQ4UlQM705wfsVjc9P4A/fJHOG1G14USZWFjbabemtRKA+1Na0haB?=
 =?us-ascii?Q?yoFw6ncuRbwt7rFedr3yluMNmQNFCMkwcxFgeu0aUotvHqxqk4Rk16Zy1ANo?=
 =?us-ascii?Q?ay8XVQGHVn4S53A4DeWZyB/uQBAeXeWw5hr/rkfrF1/qEOqPjZz+WYWaBtpo?=
 =?us-ascii?Q?+Om0Tu0PGHDFnqczqWDvObTzx72qVWWiAQqZcXGaAL6nIyB8j28dui1hoN+T?=
 =?us-ascii?Q?+HM9Y3GQ1zgVv8rLef/FzvR1CeiL9QKNBUIx9KQcRGiVtYzoUcKE4S8ExJ8q?=
 =?us-ascii?Q?jnPjHACs6hYx5/okMHYyIBR0hiR3zyNHvT16Fw0GdVMk78njBRJ1xfbig7YH?=
 =?us-ascii?Q?nTPZRyennQkyizM7whYPTqdQXFmoWdVQa+pNcNRB0NO4kcTmLq5+lh7t9mJD?=
 =?us-ascii?Q?FZaCLb4PYBm35FClSfkqYkjC4ALrcZliBYmBqThCq3gGGauPLq/waKHb2pjj?=
 =?us-ascii?Q?dUjiIO29gcLzYPnzP7EPPOTzI1i169G2mhUeWOKwydFccAsMMUCFZlNL7Eyn?=
 =?us-ascii?Q?MLE6ukzsaaD93/dhMtHAHRcblD+DLLuhJpcelJaqjEU0R+CLIE+hIXf+ArjD?=
 =?us-ascii?Q?ycJYy4wcS4M+hUFRwb2WPEYRsJBJMrzEGZAvC7ueB3WZ0/Zlr9kvqMmYPneG?=
 =?us-ascii?Q?/c7Xdl2u4ovAHJ44MAJu7y2N/nmJvoxUx12D91e/mZeMD8YFqe9bW8eJQXtL?=
 =?us-ascii?Q?mBJNX+VV6GIVDmj9kgM34LRpMRTgchjwAcXSoD4oafr1XdWCxg8EDXTwViUx?=
 =?us-ascii?Q?bDu+nxBkyMzTG1ab/ztjdUpKTAuyCIEVtKGE0LFNW7xHdI2CfugfvB0ftjYK?=
 =?us-ascii?Q?ZqbO1l+m7pj87USIUB3Re6k0iHmM349F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8i2LSQoJxs55dM6Caw7b13Nkdjvqf4dUmZGt2JG3UQDuoBWhnqzuxxmngOi?=
 =?us-ascii?Q?WONkTG9Cb3YcyqqiR7M2lwM6J25PFYRwcwTvWMPb9VupZhQ/WhJ2YMLa+sss?=
 =?us-ascii?Q?blxnBNP9danDiHDYBjBtA6SYzX9Ji8VBCx2doijoVyyo9L+EirNkBLt1KAA/?=
 =?us-ascii?Q?fo2AENnF6ENFmuB9ex+wsmq/dMzpUJEiBOAZmbJ3ERcL3vyZPga+2ktWSHSE?=
 =?us-ascii?Q?x1BUZVkuhaBzt/JwnteFtOX06z1S4lEwAwErPVodMsj1DG/ycGOKwZRxngMT?=
 =?us-ascii?Q?VHB05cAUKtgp+QV91hdJcJZup6oiU4nplHzmcl3oaSsLC6Cmqx35wWNXxBrK?=
 =?us-ascii?Q?m9jH0rfRuHI/i5/BkP1KxswYVNeFTe/lgtVe1r05s4jchIRWBBvL6GYFCdL3?=
 =?us-ascii?Q?zqf0AxliDBNJdUUe6NHYOZeicQYUzEKLL5mUOGpNBOCkFLlMTyoWb07qWOzf?=
 =?us-ascii?Q?V+5A/qDrWXjztR03fnoVP6OMKYTXI9fJ6obL9PXlSKwxQm58R1uPWtmyR7+G?=
 =?us-ascii?Q?t7YXiG7LYwnZUp3NdSCZZJ2PIfGe+xz0cIG9Q/RbjahivR+mzqchOAtIDoL6?=
 =?us-ascii?Q?Z1YH41tMudnIKdsGWaGwBSNsYWoPUSu6o5Unc4DrBtF7M26HsFbZBOk6J0Zn?=
 =?us-ascii?Q?ayioz8/LIKJ4BqZHj0wAMXQ5a0q8Clx3h78MyfnFE2ZvVHsWa0jjdejuJYoO?=
 =?us-ascii?Q?TX/z+R4hiAs+3WdNPAV1A03IE/MssUX1voZOdldwe2/HsZtf4iq+QAthIyK5?=
 =?us-ascii?Q?ygOsL1P6bX2RXpgr9UVGLwZ1ee02UOEOQV+5pAjPofohDxuRRGjC4qQewUH7?=
 =?us-ascii?Q?mGEDyn/P2KEL12pWhXGeqG2ABAsIK0L0I1H8y+DQjKBLHullKhoIee22QxcM?=
 =?us-ascii?Q?MF6K/jO0LhnKi3JvPD/+DksStn7Fg5fixly75qd1uY2ooEm0J5UHls/8DK+P?=
 =?us-ascii?Q?jkwG/jYVz11j1lsV2KCjMK/vStTthZhR6v2t8YUSuXG/XklYRYrqAaF2dI7P?=
 =?us-ascii?Q?1Ar1QZxU6CORUsag0u73MY4y8A46a7bFrjYOrXTKbFjn54OOC4rySHcGCqSW?=
 =?us-ascii?Q?2w/VB7FDHek/dymxwYIyM8o08BHCPBBbE7uQiOPJ3HKMuRfOImAerXqFISVE?=
 =?us-ascii?Q?sFkl1w7uPHQrPXtUf4qhuvlUvdBo0cKsrxC8sKoX8YCNgwJqRZ2/uSu6WWkh?=
 =?us-ascii?Q?EdGhq9hsoh2GQsWs04imSmQmkHKeuQaiAmaxBB5ABWgzsypg2Ab/vSfUTwPD?=
 =?us-ascii?Q?t49gKAq3NMbNCpk+K26BeneQQz4Gr24aLjb36hFUqVHI7rnlxbwGI8Q+cgoK?=
 =?us-ascii?Q?D+oPhzGrrKxSPYrfyyr8Lz4KosBybPWA5lIm4o0eXj1s7u2ETOQZ1Eye5F5L?=
 =?us-ascii?Q?DSNeg7aBvVMtvcxtGvEtXLm6g8wHnb+uBiKwJ/SWHNKSuvCoxrLJiIPTQmof?=
 =?us-ascii?Q?nT9KRgunqXZIRiCv7UNgnl6Qtnm5h7kAzMv6ISsM71t2yypWjV4xEa4fiQuD?=
 =?us-ascii?Q?CXS8dZgB0xZYxicdnWYZaJQQoAKfOr8wcqur6RVnK/xRa2KMZKzQzphSGM7D?=
 =?us-ascii?Q?ACBVxT0qjiUAPGevdICAWclt2yWDtMNTbwlncNm912CCET4sKdha63pqCuyz?=
 =?us-ascii?Q?D4e2j5Y8CbE5pj7iQL/t3rg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13ac686-3e7d-4e12-6ffb-08dd5b7774ea
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 23:51:17.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KX7QvKk5yhtI4W8OLZREmIEc1U/zcoH87h5C2oLJX/q9U+Aasn0sLm/nOlQRsAGG4Zt9aQeQXnU+c0RPN8LnjmcLNW6gU/XI8RGHmTtYt3jUnCr9YmrJryJrtQcZPM6I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5964


Hi Kees, Andy

Thank you for your feedbacks

> That said, I would expect the series out of 3/4 patches
> 1) add str_in_out() and/or str_input_output();
> 2) use it in gpio-crystalcove.c
> 3) use it in gpio-wcove.c
>
> This can be easily combined into an immutable tag/branch and pulled by
> the affected subsystems. With your lengthy series it will be ages to
> get it in.
(snip)
> str_in_out.patch:              66 files changed, 130 insertions(+), 136 deletions(-)
> str_tx_rx.patch:               33 files changed, 48 insertions(+), 53 deletions(-)
> str_input_output.patch:        17 files changed, 27 insertions(+), 29 deletions(-)
> str_enabling_disabling.patch:  16 files changed, 25 insertions(+), 25 deletions(-)
> str_Y_N.patch:                 13 files changed, 98 insertions(+), 89 deletions(-)
> str_kernel_user.patch:          7 files changed, 8 insertions(+), 7 deletions(-)
> str_level_edge.patch:           5 files changed, 6 insertions(+), 6 deletions(-)
> str_to_from.patch:              3 files changed, 4 insertions(+), 4 deletions(-)
> str_pass_fail.patch:            2 files changed, 2 insertions(+), 2 deletions(-)
> str_attach_detach.patch:        1 file changed, 4 insertions(+), 4 deletions(-)
> 
> So, IMO, the first 5 are clear winners. The others are probably fine,
> but pass/fail and attach/detach are really not used much.

Thanks.
My plan was add new helper 1st, and use helper (both new and exists) 2nd
on each driver/framwork. But indeed it is not so good from reviewer point
of view. And (aside from the "success/failed" topic) indeed some of new
helper are not good/needed.

I will try to post v3 patch, but want to cleanup before that.
v3 will be above top 5 helpers only.

Thank you for your help !!

Best regards
---
Kuninori Morimoto
