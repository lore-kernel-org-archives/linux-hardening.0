Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1F4E4300;
	Fri, 18 Sep 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743049; cv=fail; b=DXwQVcsuxErOd0At/IfqEP6MHT/bqTCtXpAiBhgJdO24K43HGsmV6cxvgfxT2JivfY7tvtbB/B3n/enrORuW07FiWMI3O5oeJc0V3mFuJD8/JZytDHdKcHLJfDOesgBB3BzrvVmNqfzg5fg/EIPlr/MtOGd7liJuHI9B0GbHNVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743049; c=relaxed/simple;
	bh=Qdynx131qEYgpzi8PTJpkEoG8ef6zqnsVjto6MpWr4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htEC9DhVim9G7hyROxtl5lKxrg1R6bRRa6RyPi2thLgmO2pxPMS05iIdGZdvpT9WPBDd+050xkfoQNj3onPrO1elMgu2wjxVmzjlr5vHmWOL1MxWbNK1lA46z0Fv0BK+rEH+9/QUuVCHaNkUANCGreh7xVpsltn89LlcuMUKVkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GtYQEHrQ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=PJ6AltfB; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GtYQEHrQ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="PJ6AltfB"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IEG64K2848158;
	Fri, 18 Sep 2026 09:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=/QutKLftvQ3Pv0Yi3X
	PAu2uTqUxgvpJx+BSk33KyCTc=; b=GtYQEHrQV9eK8DI29bFyPovNNZVsbZfvel
	npkQNiaIlhBzXmV0kC7PTNZ4bP5OTYFF+e0CFl6LCKGXMUSnzLCY0jjTi1kRe7lZ
	ViZtAWV35pTfwBjj4xhZLfN+RGJyzyYv/iX8IjYjujZKxP2yItonJn2t9rdds6GZ
	k1iNhFzwcWXTH5f9kBnu4nFA4TpOcXTWMGCJP0nvlgwv3MRf9HlDCcXuPnX1dQtE
	klRbpM+IxhAD6Jj4u6LfzBuhsBjvaowgMvawW1YalZ81uiNDZAZ/Y2GrHZI92g7M
	RGrhwMtzs3kZk0fLNNH5HTxrac40XxQYyt29rezEUxWbp1n9mSPg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020117.outbound.protection.outlook.com [40.93.198.117])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gregu2fra-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 09:49:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K68ArHKliWfL8brsDaDgcrC6AwDRf+KDImu8hffJUa7KrEp98hUbbh+/h/M/gIa5SYrhaV5qUAP1iekuz9FvPUF0ajg5iryB76t+orlVS/TBsNB56cWkVBY4U2Ktu5Rih2hLUrRSsUl4ry6HzZ7EsK8MR7rvkNIYtkr+i9tWESa7JSJ3z9oYAIDebNLHBMiwY6e9vXp0L2BjopJY5+vRdEJIp6X3y1ymYisltDERowd+pEvrXkyFYLdYYpdMbQJd2IuOi9dGBYgbsiOIFOBbV6+5qQ5cKxgZ4nnayRhY3Fp2ivTqdeo2YnxK7Riqm/stCxpDtFpp6GHVqK04MhSSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QutKLftvQ3Pv0Yi3XPAu2uTqUxgvpJx+BSk33KyCTc=;
 b=sFAoy8IzXHQCHxwpu20FjUfEXze1tYbHpDjNoghaisNXsN+0EYhLBKEann38TDRpzgocH48UjUq24uN1gkE+EL0mKSLttbh96IWBOmQPWtVKm7R15zVRdt+9sI9D2Jm1Dwu+5K/XPrn55TbC7ALBMIdl1DDk2HKkaSfgIadJrQs+0R25J8Bk3X5C9QTgIT5GZxV3mkTFJbYbtSL2w4Q1U5P0YaaYVWkrHelR6T6JouKSU9ibDmqnFN/SIUO/91HnHhKpRMaq79RxJ7ciw2PSXtP/y6dFMLoMwWJUvhUfLt14edKjVeMEzqEDrXWjSmqk7TIFPwb+ANp3zP5B5/P0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QutKLftvQ3Pv0Yi3XPAu2uTqUxgvpJx+BSk33KyCTc=;
 b=PJ6AltfBAwGV4ZHPWPmZvLCA/FWe2pjD/CCw+UdG+nVIZIMei2L6cV11n30gzph6YufIwBxMch0Ex7tkVMa5cKltwIZ0/SFTByiDRpL/j6cemNq/rIcXJ+cOLD/Tql0ax/L254ayJK8L3SuxV7yZrUcQd9Npov2xzfgEk4YBrOM=
Received: from CH0PR03CA0072.namprd03.prod.outlook.com (2603:10b6:610:cc::17)
 by IA6PR19MB670622.namprd19.prod.outlook.com (2603:10b6:208:5ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:49:43 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::98) by CH0PR03CA0072.outlook.office365.com
 (2603:10b6:610:cc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 14:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 14:49:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D8B43406542;
	Fri, 18 Sep 2026 14:49:40 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C113D82254B;
	Fri, 18 Sep 2026 14:49:40 +0000 (UTC)
Date: Fri, 18 Sep 2026 15:49:39 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Kees Cook <kees@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <kees+treewide@kernel.org>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrew Davis <afd@ti.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: wm8904: Add const to drc_texts allocation
 type
Message-ID: <aq1Pg6kHHC/YwS9M@opensource.cirrus.com>
References: <20260917211042.i.810-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917211042.i.810-kees@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|IA6PR19MB670622:EE_
X-MS-Office365-Filtering-Correlation-Id: 228813ba-da4c-4926-03b9-08df159412a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|61400799027|23010399003|7416014|376014|10067099003|18002099003|22082099003|16102099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XGPitaxwobIJX3BlK+UY+6zaJ6ZjBkHhUQnTgD8nsLu27ceY8OWrcvTycnqUJqfeSN70u6jX8boh/IGBH8H+xhfvuTHm4q7lk8u5ZWnRJxr2fQ5UffwQNp6JlZC75FZIpcgNbMbGz9t4SnyWqp7PDU46Zfk8XmSp+Tee4eYysHEkpPy+DgQnME3qOuyTUFDLYFaJ+Lx64iRr/XheIQPOw9nP4v1KOGE/+4U4nBtUgsJ6/SFeHHRv7xJdPVPnoJpQ79MtZIQhJ0CGKNBYvieqWMmNGzhEv8lMk5buZD0YpdkxjqLBvWtbp4hXdVY8dKKnXBItjoHE8yY+ciNP1dcBk4DXkFgUf92227Bf6vaIcDicCvCK6MqqxJuex7dVrp6MCDLnA8/Annz8Qen5jyqV36ef9yDl/XCIRQsMQmpoO3wEHi/y7BPyWO3ZvvCctYrRfv2GwD0THz4O3X3ilLaJ/U39kim8GEX7zuNOx0VycIuHQlp03KiTKSkk7q0xR9k+V+ndlnq52LgU+qWXvWmZ5Hq6L5avckNdu2DGNugSK7J7nIFrDePK2uOcCAKuS09NpwkeQGSxMUhEYZczVIbSEfN3QlD0X4+gDGz54JsDZHWUBlRUHks+tmQjzNW2oE+iTVGN8wzTyuTmGs/BEd2f9o53eA7MmSv+EYrl76iZXlpgb0u+bbeXFVpadlcLrrm4m5nt0NItNEWHhkov1EtRTg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(61400799027)(23010399003)(7416014)(376014)(10067099003)(18002099003)(22082099003)(16102099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ooqJlk5tnOkOyyZ1eYhKlBl+itEJtrX0AXzB/b35nY0/o9XHs5ZBTXva4OvEXhNGU14FnGGUwwwjd+BvaV1Ip9PosFHJ9OCFteNiEic8IwfcKg8GaEXaQEoL8rVD5OR7UXvbXPw03Xx6Kp5xMEXTDCK0OA+rn6brFLH07BrhpZb42wJvxGe5WNC7KssBdQpBjGXml/HodkHQKw+FVuNgDUgz695h7EO6plzVhT1AmvU1S/dAIbBhgw8q0QyYnYGeXfmd2mDPcqV5fnLA8s2JAnqY69A6LqcCITfu/kvZuhQYJ1MZtnsuapd9ihq57cbSJ/StXJ5VSIXuQSjak7DHCww2Vhmyl2C8a6awyYNTNYUE5KE8e/1M1KtsOlPcsQWHjTcwcWXSQKZ0LuexCTjsAnnW2iG7mrv+qWTRiP0k4C/2aby+xRrnP7uwdAMiqb7B
X-Exchange-RoutingPolicyChecked:
	3kpAxNLGdxHdAMrY7mS0ao0gVks2DbnZMlFDn4VtUFPl198KsIHB82Mic5of8RJykds0WvJhoXEkKqS0nynTRPus5ZL+ClEb0eDL473Y6ErXL5CUwhoBdEq5Jd2qdXw5QT1BxClanhPVzUiKcP61AsS7EIpxDuRMUiJ4tSoHHgT/bO98KOwcET7PMOISpeg+fcHkrxoiuniQt85q7Jr8qVTIU/uEu0FcDniiL2hgZIqROs6BL/Po3yGg6BiclBqGUAypj1p6bEr65iNmbjRHS6bZwsLNAfQF7wRF1VaTxH7mIE39xhzAAvDiXHG8ZoIVbCfYc81PmmDSRF0aDGGuIA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:49:41.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228813ba-da4c-4926-03b9-08df159412a6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR19MB670622
X-Authority-Analysis: v=2.4 cv=f8Ddl+yM c=1 sm=1 tr=0 ts=6aad4f90 cx=c_pps
 a=UIcKv52QUy3ZqpRAVMOEHw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=xPH-2WeAMKhyT3qgJ8UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxMCBTYWx0ZWRfX1NMV//TOy2Ua
 KidR0o0eSyihDxFQCmPXeqQXZQvn/XR3o7BB3NWT3VWTyOpmBUHRapcBNEiEoW0xfgCFIHbqtDo
 jJ+OmO7CIFPSIfnfOD6F12Dy+maCxlU=
X-Proofpoint-GUID: 8bYAAJBhq4vGLfy551VsEtxHr8xFnQSN
X-Proofpoint-ORIG-GUID: 8bYAAJBhq4vGLfy551VsEtxHr8xFnQSN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxMCBTYWx0ZWRfX7DbyI0V1oUEM
 NfR8iqg5kewnjPUoEChpKST8efU8vy8foSNa1T3YJKq0DJ2hsuo4bMFDEKD6y9lvWxnH9wGq1hV
 l3EIzRZslGBrDGVYdK/K+yK5i/AIPApj2Cnu+PohUGq5hCAMz87HbOR2uhx7dVoNu7PjJTt/z//
 p9SJKG/CgznaxZrZDEvFpQokdYUrSEHlJcYK2Wxf33ADQWMCQHYlTmiLKaFcTUFrXsM2hHjZqe/
 UPhpo72pwQDgEjQ9H33UO5yk8/cyfRBZXshHaaT8bG0Gej6ttDrcjV8fu3j16huP4s3hHk6ss+i
 iHQrc673lStixn2PjPBjMaOp8v7leIRUd2uy0utE9/FC8X4a8iRCnjiPeORpa9vDssymtQz6oBF
 8C+coha9CeT+pXMYY4u3sv/mUcxxUn/HdxuKAJgpm+Rj1u13BEyw3GNtpOyaPkLDVrd1ZHrltEo
 L7QwhGrvkeE/3kOG9hA==
X-Proofpoint-Spam-Reason: safe

On Thu, Sep 17, 2026 at 02:10:43PM -0700, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> The assigned type is "const char **", but the converted allocation type
> would be "char **", which is the same type without the const qualifier.
> As there is no general way to safely add const qualifiers, take the size
> from the assignment target instead. No change in allocation size
> results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> sound/soc/codecs/wm8904.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
