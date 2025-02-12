Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D375148855;
	Wed, 12 Feb 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368981; cv=fail; b=jcMmzT/LizFa2gn+1YuOh3A2gRuGvuU8tJc3XirH/pbqkONiLzZyS5FWKJmqXss2uWDX8vCH+cnsTtaCybeac0/20vOIzrGoFx070F9eBDOLYCyFQirwnKjwSBs+rmBHzW283hYAupaPfzNCDxhexN3zTO2+rfrVoiyxFszp33A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368981; c=relaxed/simple;
	bh=4Rv0OGVxf3lGcjzi7xCcQfxMfGIKVt8l3wiNjfSVCT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jfp73OOZhdsCqfZECbEc7uHwF5jQT1duMKkT+Vv5HZbaWqptXDr+cf7JdDYi2qKASQK/BTacy1grJw2WY/jBoL0XpyoAmTSPMlIosyvIdnkCFz4gZYedbpwckxlrjPzZeRnQQhwJ1Dc4P+w+k49TEbf+3CqhDj83M2LSqkFEhHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MY9opPT9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aTBvCKDx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MY9opPT9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aTBvCKDx"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CDEUAw009393;
	Wed, 12 Feb 2025 14:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4Rv0OGVxf3lGcjzi7xCcQfxMfGIKVt8l3wiNjfSVCT0=; b=
	MY9opPT9ux8CXK7qsRjkFP9yuEw9gLVGXgO2j2S+qO2dpXRJY5m7+DGTZXo38Eqx
	Jveklfq4guRL/bdojjiowBjNJW/IS7VdE4tiGu3jute4YZmWkXRIXEMwjh0O78Ot
	PusOln1LVqx5cQG5FfqaiRVniPYWhd2aEDk7b1qohdoUhWBsvfls3Tn8jOwfb+gK
	sJkGq5LMxfXAmgY0rj9DkNPaGH2yR3Xa7dYvKuCnAJScLJd0VKeTHMsuzKl1wLMG
	W1N/3LoPZ85Q13JYtSsZpUStr80qSH78NF9Jz1qbpqIWZLaNWufkqTVmIPv18LrK
	wiVa9WPNgqlFuFL+O0Ie4g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qafcj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 14:02:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CCi7PT002625;
	Wed, 12 Feb 2025 14:02:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqaaqu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 14:02:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcRsOT29kOHaK9/W0nH3blyEyPsYmBFdaqH0lSeBCu3UeJSCkgE8Hvs71jIxCgOZAF900iJvw+UAQ3GT272KzrpZbKMEGp2lOC3xVxQJJgVeyyhzQyPmVSLPuA8j6Ee+8s0wOKuZpjLw8Zxmu4yIbrzzLUiX38xdmwkbJUYLpM3opEq7x6lvZ995G/1YmeJNU30pSKUQyk35Tlm+Dp+q7+d7NViXLTHVJrA523fgdmVD42B6QlOm1z2cVKqeSQK/nuNPugr4YH3snoAnIKJ3TQPAORHCwjQHv7jjY7s5AIAmzmvTxxG9JnyCTw0TKACkb6WWR8Qcia270bXdTWnfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Rv0OGVxf3lGcjzi7xCcQfxMfGIKVt8l3wiNjfSVCT0=;
 b=PBcsdeWYIJxlYEiI+CAbyy/mgqOf6j46u0+dLlFygJ/B/pmET3XWId9oIYFFteK0yxp1xOfke+r+cu4S4k+s5CObBNsctwpFomechGk3e04iWjaSaO7DL+92BvhmXMZ/7O1crb9MLg6hog6KeVcnyhMk9kURJueO2uZKLFyLm3NsuXprLMYH9J26NHzb5Qa0Yl5Pozgi6waVxKnvWSfEQCKqbk4SOYbMXckS/Cxkg1k5Ob3L2OhwMolvY2e3+FARSijROPXoB8gAROrjQ+Zhdu8AeRDLDXmlPyhL8NwNSeZf68wvhKLi31iVi+nRKddzHSY09B4hb8E2OqWA9zLDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rv0OGVxf3lGcjzi7xCcQfxMfGIKVt8l3wiNjfSVCT0=;
 b=aTBvCKDxzDX2bKk1NSi+qUfYHGfW0vn3K5Qa1ugqKITPgtTGRhbE+9skduKOLx7l8+kdK7FPdBz+KFR/Y7bctBBarXMOiDRoDCKk5TkcM1UZTU2/KzYNMoVb611BkTKEEfXhb1AN4lCW9mukOI28KXqo2Mte9DV3mJz2ACV2PBo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB6491.namprd10.prod.outlook.com (2603:10b6:930:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 14:01:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Wed, 12 Feb 2025
 14:01:54 +0000
Date: Wed, 12 Feb 2025 14:01:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
        jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
        adobriyan@gmail.com, johannes@sipsolutions.net, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
Message-ID: <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local>
References: <20250212032155.1276806-1-jeffxu@google.com>
 <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0096.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ea9e17-3e2f-4216-5e9e-08dd4b6dce36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGFKbklQQmlHT2hhMU94elR3TkNoK25KaEVQMHl2eTVleEY3SXJhbDVRWXN1?=
 =?utf-8?B?SHByclVmN1p6bTE2eFpUelNIZURueTByZS80Q2ZQOW9BTUNlNDA2KzNyR1M0?=
 =?utf-8?B?OFZJZjFqM3pUZmhJYzJCbWNuQmNMVVlZenBpUkNQcEFqdnMwV1IrMlduYXVT?=
 =?utf-8?B?RUtvUUFYN0E3bDV2TTZncXlXZGhkVGkwV3VCZHFBdnc0TnNIcHA0VnY2bVdq?=
 =?utf-8?B?T0hVd2FSREJFd09ZMUI5ckd2NVFyMmFVSjhtc0NNbVhkVWtFRVcvQk8rQkQ0?=
 =?utf-8?B?L3NUMXQvQklrTld0bWNGTzFyTHJIbGpDZlRJTVRISzN0SzlUZWljMnhaZmJl?=
 =?utf-8?B?Q2E4UUNaQlFiZFlOOXBtYUlBWjZpcVBsSWxKK2xHbGpTN3pZYS9Pb09OVVZ3?=
 =?utf-8?B?c3FhYTV2ZU9lRVJvajlrSEsvanJuMGZqeGJCQ0VWYmwwSVFodHpleEMxSGtr?=
 =?utf-8?B?NDhST2lWaGNaU2c0Sm9SSCswcVRiUkVQWkxVWVc1TlpGaStVQ29zUW9TS2Ji?=
 =?utf-8?B?ek5tcC9Oa09KN3ZycXRzdk0wWVdWVXRhUlJNdmQzYTdVbTNrOXIyV2pJenh5?=
 =?utf-8?B?VGsvL3kyWnNxbk82TlBjMEJpM1RVZU5MQk5IWW1FckdSTkRiMVl2Y1NOWnBU?=
 =?utf-8?B?NzhsRVpOUGM0Mkt0aGNRanh5U0cvNVNxVEE1dWtmMTdrTE9KeGFVSjFHSEFw?=
 =?utf-8?B?VGk0TlJjT09oT2NEdGF3SmZNSjFTVFVzT2VkbVNtK3haT0FZRGsxRkZrTHpE?=
 =?utf-8?B?aS81VnFBVmpMN2QwZGQ2Qll6Y3Z3VzEzUEpQVUJZR1RIRGhGQllrcXUyc3dD?=
 =?utf-8?B?QVFRTXRCYnc5WkJZd2dGeTFUS293THhDQjlCSkYwTG9US1ErTFYwN29QZFZZ?=
 =?utf-8?B?T2FISFVFVzZBdlBCcWI3TU5JWkZwa2NvbUEyTkNXaTdxTVE2LzR4OEM4eEE1?=
 =?utf-8?B?bVJzRWl3VTBXanJGK2VpZXN6NyttdWRkMnJxUHZXVVFyRUJmOGFwK0FxM0dr?=
 =?utf-8?B?MTBBSXkrTkJaclpaRFdKQUNSTnNkbDdibFJaVFp2d1VMZVc2UGR5UWZ3Zzkx?=
 =?utf-8?B?TmR4WDNyaUVsVXJkRU9sNVBFYTR2emd0dGh6ZlorZFh5bWl4MmhPZkh1MTgr?=
 =?utf-8?B?RElGMmFXeTd4ejBYelp6UmVhbGZaMXVGY3ZJU2xrUU5pMnoxSHRqdzhNU0xP?=
 =?utf-8?B?dlZocDJkTEtWWlVhblVsOHpqRHUxMnY1amtKRVFpVjF2VkJ1YVUrRmN0SWxY?=
 =?utf-8?B?UlJHNis5ZTVjNVNiMkdsWkpUb0hKc0diTis2R29YVDhNOGhWaGZPWGc5aUU5?=
 =?utf-8?B?MFJMWlJSempONG1JaDdUdmFRd1Y5NDVORzlGRW12TUlmOHpIS2ZqR0t6aWxC?=
 =?utf-8?B?YmpMVi8yTFRsbXZCQm9EczQxZnY3S3R1NUZ0Snp3Q3Y5dUVtMUFpdGNiM0ZU?=
 =?utf-8?B?VWNET0lsa2ZDYTNLdXkxc3pyMDI5UE1DcVh4VlJ1WGI5MUxSKy9qWEN2SWhU?=
 =?utf-8?B?RzZoNE45dGpnNmlvdStsWUNMYmRDTzB1M0U2dkVmb3FVcUUvTUMwUmk1OGxN?=
 =?utf-8?B?c09SdDlML0hRVzBXRFRxNCtITkNCSXdMOE9ZQlFXNXJnamlDRXY1V0dYMTNa?=
 =?utf-8?B?TXJTSUxidm1sb2xQREN0K21mV2NSalhjSFVTc3VDRzVqSXpDMWJTOUhPcWlH?=
 =?utf-8?B?Q1ZXbzkwYm9MckhTZzV5RjVaK2NlMFFSRXZZc3lxYW52ZG1wZHNoRitCUXIx?=
 =?utf-8?B?TG5iZitDNTlUUUlVZDc0R2FvYzdoQTIyMXBOZy90aE5oeEMwWGhyZ2Z5bTRp?=
 =?utf-8?B?bG4zdFFxM1Eza2J5WGFGUjZUSTdQbWVORU03bjl1a1piMXZ2UEUvV0hwa3E1?=
 =?utf-8?Q?G1B0Zw8kttvPm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEM2ekxLWml4UDRZQUlpNFRxazRlQUtzVkwzd296RFFtc1ZUZnhkREhMYWx1?=
 =?utf-8?B?TVROZENYcWIzaE03MUVOL2hkYzFsVmkzWTZJeEdZcThGMGlPSzEvY3ZkbVNq?=
 =?utf-8?B?SzczY0dNMEpNbk1WeFN1bERQaGhsekpQekRpZG9HRlBMYmJZMDJuWUI5SUc4?=
 =?utf-8?B?a3g3U3A4K3NsaEJ5QmVTaEpnUWxOMVlsQTB2VkZIVWJGL25Mb0pMUjd4MXRm?=
 =?utf-8?B?Nkp2NENNaEZrcURpajJGZUJZVHUyQy8vTi9GUFhoT09sQ1dUN0J2cVI5YWxw?=
 =?utf-8?B?QURlZDA3ajc2LzQ1Qy9MbjZFL2VUNlFtbDVOallDaFQzU2krWFNUVGhjdkND?=
 =?utf-8?B?NXBFMndvd0RodUxoakc0OFdXbUt2V3NoTVJiU0VYSXlJSFcxZGtZanBuRzFa?=
 =?utf-8?B?SE0xOUZySWNlc2tsRW1zVzNySjg1SnlGZkVxTkh0Nm1vSGV3T1pORys4SGFv?=
 =?utf-8?B?eGkyOEQvWHpPdUVQQjRjYlVjcTdWeTgwelIvQWRPS09qa0ZsbE5vWXZGMjEz?=
 =?utf-8?B?bm1wR1Y1NVZDY2szQzE1TVVUN3R3aktDcis3VVFKSmNIbWc3bkU4YTZucUts?=
 =?utf-8?B?cGI4WW9FL25VYU9nK1hpMTgrN1g1cEdHU00vQTgvamxjZEY4L3lqMG1iRTRX?=
 =?utf-8?B?K0N5TC91VXZWMVk0UDNFZ2EvTmNvWGNaeG9acUxQcEVlWXVyTjVER3ZORWRn?=
 =?utf-8?B?Nkw5ZC9MMkJaSXB3Uk9XZmwzeEtTNStkWUpGYWg1MUxCaG1CZjNPUTRXK3o4?=
 =?utf-8?B?RmFuV1o4eFFVbUcvVWp4enFWRjdteTMxMzVwVENJdGN6dU5lSFd3QkhyTzQ4?=
 =?utf-8?B?NEhsL0FTcmdZUlN0Umg2bkxJellaa2hPU00yTFJXUmVnRTV0a1YrN1FNUndP?=
 =?utf-8?B?ckRrTEtoU29tNXE1aXBYWng5MU5GQWsyb25YUU9tTnlOTjdoTUlkQU9yM0Y5?=
 =?utf-8?B?MWdGTkxHYXMxSzVrVGpZSXRFTzU4YmtVdi94ZXIwV0Q2VnpZNUNIMTFIc2VT?=
 =?utf-8?B?RUxNQzdjdHM0aWMxUlZRdzIzWkwweERyalc5cUxNR0x0bnFjRXJmVlE2am9K?=
 =?utf-8?B?WSt1WlZIRlVPd3EvRWVtSXh2S2wrTjlXTzIra1FkcVpvcW1oaUpuVXZCSVlY?=
 =?utf-8?B?MC9XVk5aMGpzYmdCejFmdFM3QVNTMWdHVzVMOEhoRE9YR2JYWHg1SU52Q3Jw?=
 =?utf-8?B?VDdPdHRPaElOYVhYL05SN2tCTGNVOXpndDNnS0NCdXlBNzh6ckFXNWJDN0V0?=
 =?utf-8?B?UW0vM1U1c2p6OGNTRjNlYnVOOStZSjRjbnpPZ0F4YkJGZmRCWDdESVJyWnl5?=
 =?utf-8?B?TGxaV1NjQzBocm1RWjkyVDU4R0ZxOWZRQkIyWnhuSTBCSGFDWldEdU02N1J2?=
 =?utf-8?B?M1JBTHoxNmZ0bEtkYkMydkpuUWdtTE5ZRXNEZGo4cDFYZzNSOEdESGVmZUQz?=
 =?utf-8?B?YzBGUnczT1Nsc0RVVytZTlNwOXMyYndRU2hyWjF5VWJqTVZvSFo5R2dva0ZZ?=
 =?utf-8?B?OGg1M09ZVTl2VnY2V29qWmcreHNqZE5vWjdCUW5tVWk0Vzc3ZVBjRlRRSW42?=
 =?utf-8?B?SERJT2hQa0Z4eXp1UnhlWGZiZWFMNzlzR0ZaeFRDZU50L0xXMS9nMGs1Mnc4?=
 =?utf-8?B?azcyM1I5Sk1mL0lyT1NnV0JXWFFOeGJ3ZGIxNlBJUmIwZGw5RHp5NGd6bXJ1?=
 =?utf-8?B?VDZXQ2k0WkNqOEw2emhFS1I5Uko0dkJZUFlKeTBsZVhjS0VTZVNGei9kN1Bx?=
 =?utf-8?B?U2ZoMUtDRnZvdkxOK2h2QXRnbnBVVnZmWjVyUHBWNGFmNTF5V2c1NG1NdEkw?=
 =?utf-8?B?NkJMZWhYNVFZUUt0R3Z6dXJ6Mldwa1RScDM3cndUOFhNeGQ5SzN0cE9WMUIr?=
 =?utf-8?B?U2hFVDJiREhQcmlwSnNSbTd4aGZ5d2ZIekhJcXAyK1F3MlpBbHZnTUY0M3Nh?=
 =?utf-8?B?YjdGbTduVnRtOXRpbitqdDIzMHl6S0FXTnBoZmJkbFRTY3JyL0pPbTYrK2tn?=
 =?utf-8?B?RzJnR3JLNHg2Ykx4MWdLOTdFeG1BK1FHU0Z6UFBvZ1pxcW04eXhtSk5lUGpQ?=
 =?utf-8?B?aGhZbGFDMHM3c1BUcDdpamU0RHN5ZUliR1hBbmNEdldRTkVTbjBSTHU5WW9x?=
 =?utf-8?B?S2lMVE1SRmltZHZndHNSWVh3dEx2MmtGem9TRFphS2hjcXM3a2krYTNpeHVh?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P9ldr0eN8cJx+l2v6avm9aBBcGwg3wq4GLErjebVdYHZDJ4h6AjonXH7QTEALfCOLnbFiuF2/A66V3s18EeUtMOdRPf28ClhGbn1ju1h5JTtT40v7PxXhvAMXC/q/yGra0b4C9vYE2QXxrjP+74zxdMB2i6R9+8qj2UC+CsKffFl5IeVtvrLVOLlU70To0hKQTuNPLCCOuNBEYowrLmDv/skAV1hyoPPItQgVWf158eEQI7VYESwaURSYsT7T5W+dX2VBP50e9U7zG6zp6SZNyF7nbrXPct+ckBzHzafxOTNnHIAWbaORBtJyYwZAT2sSC5j5HgwiXZ2XZKfsxlSjz8ObnD2OQg6xV0zH4HTmtrKzzTr5VTzhQYmUVpUHEgrboUsdNnV89YOlAlElz9lgbY1RtC9hGmy12Lu3NeNZxNoAbViLAieyiBpxZHIfyZ6PoVrLiZtvfRGFHHCXdFF/Ew1+EKHR+GIFi22FfH1YtZQhv71O5jKapnxos83cuSGs/HYuX6QEqdxigpGLyHAed4H4yrTFO7IiPJhIfPnDZuoQn52D6UpCXaeRKKIKaP3SRc4yTZztOBsw6mUR9tiuCVlRGNVhofB+YsmmhlIn9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ea9e17-3e2f-4216-5e9e-08dd4b6dce36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:01:54.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZNM893MI/EwtCoWOckM7Ggi1zukY7vTy0WH7nJafgtMMPM2Mfqj7gxRzp24wPqw8HR/B3PobGJdmM94u5GVRe/a1CerYnvgD48ycblaIA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502120108
X-Proofpoint-GUID: ZjMCbtA3kUYjaa1q0QL4LNkeq39DDjh0
X-Proofpoint-ORIG-GUID: ZjMCbtA3kUYjaa1q0QL4LNkeq39DDjh0

(sorry I really am struggling to reply to mail as lore still seems to be
broken).

On Wed, Feb 12, 2025 at 12:37:50PM +0000, Pedro Falcato wrote:
> On Wed, Feb 12, 2025 at 11:25 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > The commit message in the first patch contains the full description of
> > > this series.
> >
> > Sorry to nit, but it'd be useful to reproduce in the cover letter too! But
> > this obviously isn't urgent, just be nice when we un-RFC.
> >
> > Thanks for sending as RFC, appreciated, keen to figure out a way forward
> > with this series and this gives us space to discuss.
> >
> > One thing that came up recently with the LWN article (...!) was that rr is
> > also impacted by this [0].
> >
> > I think with this behind a config flag we're fine (this refers to my
> > 'opt-in' comment in the reply on LWN) as my concerns about this being
> > enabled in a broken way without an explicit kernel configuration are
> > addressed, and actually we do expose a means by which a user can detect if
> > the VDSO for instance is sealed via /proc/$pid/[s]maps.
> >
> > So tools like rr and such can be updated to check for this. I wonder if we
> > ought to try to liaise with the known problematic ones?
> >
> > It'd be nice to update the documentation to have a list of 'known
> > problematic userland software with sealed VDSO' so we make people aware.
> >
> > Hopefully we are acheiving the opt-in nature of the thing here, but it
> > makes me wonder whether we need a prctl() interface to optionally disable
> > even if the system has it enabled as a whole.
>
> Just noting that (as we discussed off-list) doing prctl() would not
> work, because that would effectively be an munseal for those vdso
> regions.
> Possibly something like a personality() flag (that's *not* inherited
> when AT_SECURE/secureexec). But personalities have other issues...

Thanks, yeah that's a good point, it would have to be implemented as a
personality or something similar otherwise you're essentially relying on
'unsealing' which can't be permitted.

I'm not sure how useful that'd be for the likes of rr though. But I suppose
if it makes everything exec'd by a child inherit it then maybe that works
for a debugging session etc.?

>
> FWIW, although it would (at the moment) be hard to pull off in the
> libc, I still much prefer it to playing these weird games with CONFIG
> options and kernel command line options and prctl and personality and
> whatnot. It seems to me like we're trying to stick policy where it
> doesn't belong.

The problem is, as a security feature, you don't want to make it trivially
easy to disable.

I mean we _need_ a config option to be able to strictly enforce only making
the feature enable-able on architectures and configuration option
combinations that work.

But if there is userspace that will be broken, we really have to have some
way of avoiding the disconnect between somebody making policy decision at
the kernel level and somebody trying to run something.

Because I can easily envision somebody enabling this as a 'good security
feature' for a distro release or such, only for somebody else to later try
rr, CRIU, or whatever else and for it to just not work or fail subtly and
to have no idea why.

I mean one option is to have it as a CONFIG_ flag _and_ you have to enable
it via a tunable, so then it can become sysctl.d policy for instance.

The CONFIG_ flag dependency is critical because we don't want to enable
this on arches that have not been tested against it.

It's vital at any rate that we document everywhere we can that _this might
break some userland that depends on remapping the VDSO_.

>
> --
> Pedro
