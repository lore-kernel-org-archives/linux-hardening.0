Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9C4915BE;
	Mon, 28 Sep 2026 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585468; cv=fail; b=gPkkgt1EAv/CFcO6RNOM8mtBoSqe2xm4WnG5/57TDxdH+uUf72jnep8rN/d5lGQB7w/PaQFxDimx9JCY2YWVCsxp0x771qHN39Dl4lacuEE4sBPOQB1R4xpYnDtIH27GGm6mTa3flGRpAkcXc3sjba2/MeOquc9XgCGut2rj23k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585468; c=relaxed/simple;
	bh=wuwVv4HovOPZx5aaSkogkGyZKzDEY5Ajt49E5zbkwxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SH1AyxgRGWLpC5WS4PdyiZ/97z8XWtqCkzfBgu9DiCYwd0kvbaLTlXTvPO8z/b1Qzhmx4gJGMscU0W6T/p4994HSB19UJgT6B3WmGr26YPn4VlkJKuUqk0/FJPKjmwww7rOGT+Z37mKDhx2DVvOQKC5TXfQKrB9aAQZI9SNbmX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hv0fP8D8; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xYt9xy3/; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hv0fP8D8";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xYt9xy3/"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S81uNF1053068;
	Mon, 28 Sep 2026 03:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=XQIxiaSOjUgNtcLoHTGN5+tHcfhROsqUkK8EAUOZz1I=; b=
	hv0fP8D8JJ2CuyMFHhpD4lUSEAJCH0qVy9h9oevIuqMfWzV8BqHp7qPHW/cqG202
	jy3m+dSlYeUiMaYPXlYpWHEispKfkmCyjHF4oM8dAUoQfbtfAb0wzmtyQdN9mLff
	Lhaz6WouCTrmP96EbHEU0tAZbfaOSKsZG5q0bmnenk0mfk4yicIOj9CYch4aS/g/
	eoKQxU0J0KVpcmNBZHxcJS/1D26pUBxHgsQppCGvJGeR63FKJzs9JYJZHFX+Yc4C
	g3uwv4SadadrXl1402nhV1LCb8lEA7Pw1dEbeCQtHtlSu4Mh1Vg942JchGlsGn1j
	bNVJcXtOOUhqVYir7+q8UA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020109.outbound.protection.outlook.com [52.101.85.109])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gxafj9ksu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 03:51:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmQibscmDFcOtPbn27889qn5HIJS3fSW2BiQYutQdgNItif6nSy++Yyr9I56WptfQd0wTu7MABUz3+INYIOvRvcW8T6d97EfIh8Q5A5Bf8m1j+yODH8fvBxSQNgwaKkt27XT875Bvc7Xnep6pT4+yAC7/fh4dYvUbDHekcCQeZP0+8DoKIvmN5majG0dpce8rwzLmEe7YKTIhBLrniszuyOelTLAJfbhxxW3nTIWt/zylehfieuceklbkGhDubW01cthG+mlby0zRhbF8bnEPtWcH6XsO/CZSMLLCIKdARGlIHx8sZ5HzXw4UXLsdju//JVDW5e9bFG6qVjni/fn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQIxiaSOjUgNtcLoHTGN5+tHcfhROsqUkK8EAUOZz1I=;
 b=AwptnpBokbbUue2Cwvm1KaUjM3zzcYQCqTSg7Z0iV7UJQYHpUW+1+ZNAiLLnGkpPr/TbbxIJfwndgOEHXAmlMrkhoD8ZPU34nBSjQRLMmN822Qh5pIE3lfmRmAQn2KiPkmT9voWzYCs56+uYsySRQGNcFKc0aXBbQrzyEM+BH/I31Lj0L+K/3Vkeaxo3M6Wgo+5l0yCm1kqQrMKRTkuu5OzD26kJQabDxQrdJPx9OyCjsEKk0aGtzj5yRaA6AG09qjjdgeqGFiybFR9aVibSVmt6BctNW7rEkknvSvhnjPplLa2G9xAInwqOQxnfqOlQ2B4qIWPurOq59PbrWv4FnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQIxiaSOjUgNtcLoHTGN5+tHcfhROsqUkK8EAUOZz1I=;
 b=xYt9xy3/tMJfQGY9dLfl/Ik9ecXPYWul0u4Jvi+Z0oCRKYG5aWwIoXtYss56vsNJ7067ESoY4bHszJrWFLU7cc6UwGxwceYqMEcVurrSWT5WaqSVvCBuqbMA6jSTQ5FDrfFeSCyWpFZ5ftc5rlaTv08tPX4yqi1NYNepA0Q6oJc=
Received: from MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::16)
 by DS7PR19MB6230.namprd19.prod.outlook.com (2603:10b6:8:9a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Mon, 28 Sep 2026 08:50:58 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:303:80:cafe::60) by MW4P223CA0011.outlook.office365.com
 (2603:10b6:303:80::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 08:50:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 08:50:56 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0E484406540;
	Mon, 28 Sep 2026 08:50:55 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E0B6F82254B;
	Mon, 28 Sep 2026 08:50:54 +0000 (UTC)
Message-ID: <fb409745-856d-44c6-b9a9-387bb7499811@opensource.cirrus.com>
Date: Mon, 28 Sep 2026 09:50:54 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: Annotate struct cs_dsp_coeff_ctl with
 __counted_by_ptr
To: Bill Wendling <morbo@google.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
References: <20260928044513.1330392-1-morbo@google.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20260928044513.1330392-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|DS7PR19MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 73349ffb-8223-4cea-fd9f-08df1d3d9ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|61400799027|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003|16102099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4Gx+9/FwGwr0snyOsNzL5geGTGFdUR3Mcnrmi3nyG5IeJKE0lkuaoBo7bQSsJQtXgg1b6ViC2sgHLUCQ4dqMTZXmdfa3RdV3yHeos/jc9+vtvSbMh4lIQdgvyZ0xaVFJ2eBF7VFXsaytWjp9URc+2EpCDh5Zy8xEoeBfeIvVbogV1+2wCi+IrKE3T91i7qNIO/iNRVtSUg991i3ZNwjGgxZqoShTW+iEeHnZ1VJ7M9AA0kQvDqhzwkLAUurOLYnK1AXp0bg9Dip06U8oJYoUu3lLLc9Jjm/00Lcop1asqiZKsBoHuXAmJcHddDXVoiY2ThMOUVf/LwxLziMHzdo6X7YpuzctWQmbqBVVQwCdroitgpoYwR1pjnf0I7SYVcW/VrFgER3sbQV8OAIu7Lt1WT8V0edMOcauo8t5hczGcJ0y3H2MeMJkwJ2LYwwPhZXXiKwh5eBP0i9rMABeSmzvBZ1PDLL7CIFv1O012zjxp7bg6m6teJW+30ykMvXcDmFuy5Ci0y4mIghj2Mvy8/N5EY8C/Ie3m4VO+6Gp4q6wC1Kd9OM9fsphl6+WAA9LsuMO+Wmlf6a/UJBAbCzZH4umnbEu5oyaUR0f2DW6N+l/zTM5XzMxWQ38JG7n48rVJPqg/a2J3SebF9VWZ0ZtSQV2KOg0heKE0+5x0w5BKBrU1zuo/2YtRMR7kWWXngxYpKbCKhkLqXVir8qimfVeQcUIEg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(61400799027)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(16102099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w7oyFP4DisjC40NuKek1nLUDrK44YeGbOb0cFgxfCXBC5kaohRYgePeas0+63PkQV1zNH2rgzRz1tt/WjLDf9eR3z2ANBywmdpClYOv8sCyH4Qq4RqBSy5mCqlD1Qxsmx/xXP8GYxLpqhODbOGNqW8nZwG7SaLpB+PcpbPjTFlXXFaS8cipxk4DjqNfspjZ47YuuMf3+jrDj4YgZJgQonNEAOvEdOzket/VGVTZhNTYX83tSs+68tdRfDqP3n49wdO21jtjXxtrF1m9+mnsFThdc0elmI1Ps+FCe9IQFVXuRCKQD3yMBfLswxpGu7vyntqRzVR6+zdRxFHosaD8StM76sezC1TuqtuqBRuiXYiy0RQRFFs4uQYvqpOR3j/P/+yRkn79pMnYlTSSnCIccHxQ/X6qlmIIM+YAlPx5zHQFII9kGGivMH61ofdM/XDIA
X-Exchange-RoutingPolicyChecked:
	VEbRWchIJ2V6LlsPFVBp7sxP1jjA7YEPEUlK66XenUpgWrRkKhErQvkQNbSa6QlgG3T1OzuPkYYhNHOZiQd2BAmoFdq0OZK10XukAMRNRooK0U/erm+o02+sHTj/nkCP9JD+CwnrczDupg255qmpq17cR+aX6Bnac51fu9LNpEwF3DJFoOGJMoq418M09/qtupy7VeqWZWYczoe5QLnYyFMpPtI60n8YlLBY5oZlQJ9GURADdwL6aRsfyo4JnkXBfJYByFpWZ805Uzmb8LTB9GUzGwRQK5QvzEo3xDAzUudMoAxQROFQyxviPUFHIBjG/dllDIKjk108GgZy0a1qZw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:50:56.4660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73349ffb-8223-4cea-fd9f-08df1d3d9ca0
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6230
X-Authority-Analysis: v=2.4 cv=GtLXaU1C c=1 sm=1 tr=0 ts=6aba2a76 cx=c_pps
 a=zEwEPAIedI49nOb3SM4JYA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=w1d2syhTAAAA:8 a=jtjyibz1FnmDeDUDwVcA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=0lgtpPvCYYIA:10
X-Proofpoint-ORIG-GUID: Dkd2AETn8mmeNcvj6hBIg0xpegHA43oA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX1WuWR1UG7kqF
 xhkrs5av0ymsRIqMyPXwcyFNIm692YEQIHkyq9DJp1YZlfLREUXSba4TgoinezvknXeGfhUNNUj
 kMTetVc+NOvdZqfYanJ4Nd+oNmfO/TlowbzTRo4KWzFTo2eqFGyOW6w0Nedf9nre/vCTfdqso8+
 Nze3FzFwru4zEIo9TM46lOhZq6yL/cLS9k7HlEwhWau2l2Z4H2KbXDzAfZBxbAdvxtfJfD+q7/V
 cBTa6UNT6cuT+cmJdnN3nhs/Gh0swnrm+9896hKSz9XIItNdKIwAzH2nJfgEPLkgeA4pukTAWdH
 T/LB7O2vn5uhAbG2EpELmv4I3csAOSUPKEbgsSqcGC5atEUOZNW5UklHvI8beZXpH1MW/OI79HA
 NnRMmzm9TD4Nywr0zdpUQi43Yswn5VxzN10LIXNVE+pBPiwwF4ekE6KI8XfNet3RYOoWyDBIOFU
 KmbM8DJX3kO8Ur8Mr5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX65sO3mg+MeJ4
 287UJ8aJUzVKz0HPSBHspPUR/Ab69/+fBj4EWyIbiHNIQstZlnpjAurGD6vpMdu0wkpAh9PmBoU
 TPq1ab40AxomF7XZccXRgFM4JIfkRFY=
X-Proofpoint-GUID: Dkd2AETn8mmeNcvj6hBIg0xpegHA43oA
X-Proofpoint-Spam-Reason: safe

On 28/09/2026 5:45 am, Bill Wendling wrote:
> Annotate the 'cache' pointer member of 'struct cs_dsp_coeff_ctl' with
> the '__counted_by_ptr' attribute. This allows the compiler and KASAN
> to perform run-time bounds checking on accesses to the 'cache' buffer,
> preventing potential out-of-bounds reads or writes.
> 
> The 'cache' pointer points to a buffer of size 'len' bytes, allocated
> to hold the cached value of a DSP coefficient control. The 'cache' and
> 'len' are initialized in 'cs_dsp_create_control()'.
> 
> Every subsequent access to 'ctl->cache' is strictly validated to
Is that true?
When I last looked at these __counted_by they were only checked by
a subset of library functions (which was documented) so I was still
able to write code that overran the buffer.

However, recent compilers might do more checking now.

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
