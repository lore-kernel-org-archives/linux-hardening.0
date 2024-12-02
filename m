Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE270805;
	Mon,  2 Dec 2024 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164226; cv=fail; b=UhJXt4XuHsb/soFJM9gFkKqKren3jLfLiuBP2X3hy0j27kktTlTiXUvJBng6+LV/Jo2JjN0/hSHCETUugmWFcKDGMZnjGT4j36nIe4i0ZZXCQLWNW4b/WsrLyCBmtKCHcHEsbs3JbAYH6r+3ep0FtGKE4entKw457u+DN4646J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164226; c=relaxed/simple;
	bh=KD/gc27PUhMfxpU4Un7Vs+D5JDWp9Enf7gLvUk1HMOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DsAV+RnyJ4+SzHxVGEAQjK/FScNTBmbC7Ha1e22mSGV+kM8GniNXMupVLXDdP1J8pTUWfU69urwd84y2iV7+MI7pdO++AVyVi1VeNyJN/z/ciZSSDITYVlX+5AwI/uDbXpOxwydE/vnaWC57aZnoNAVOSvTMz4T9B1H3pjBuYYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DDIzpFfk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f9KQP4W3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DDIzpFfk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f9KQP4W3"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Hfg95016858;
	Mon, 2 Dec 2024 18:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Lu+8qOdAiJaoGPK/dA
	R7mk4lBERIiSv6/FO3Ezg+WDI=; b=DDIzpFfkGhafhL7SucpmsYFOE4P1tv9QMb
	ToFqMaD2cduiz8UF5Ylpz0dRsXjCvJhr3b9p2Xj97viqbfA4S8f7iELIM2/cBVzw
	6z4mXxjqHoomv90ahL1jOMHVnY6D8LOFKhvj1l7A8Vjns8kadPop+HeOuRsZRlyQ
	ms1FC5Nn4ebTPsRp2Ski8LixaaXi59LafkgxbKFYJCWLFDUenTVT/umP1YPuxvmc
	9XVU0XAGswQW+aBwbhjSUdM3f52W0sROIPhEDtwXIqz1sJJBiZHdIeXKrwS9lSp8
	BMjp92Kq5rk4P/ynVMVUwCLGgOD0hl3ZlybKJ20h3Yi/MEBlLBLw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s9yv990-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 18:29:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2ICYiE001121;
	Mon, 2 Dec 2024 18:29:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s56thv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 18:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkueEHzjdgMCzFMM+2TBZBkxPbKli/xW0Hauc8ZlbafNaB1jYzBkcWPVbylCjfvUl5L4ePz61sHILDlWhGrcGoaCTC/f5yLFPlyXTGP1NMbTOpZEha81gw3UlXVEH0ss/ou9eYaOdcvxmNIfGz2kXJT2aVG3Kkihp2trJNuj3ojuaDX3xGpa41UQgVS4QjF8/TvfpZi7vZlW5XF1qXWkrEBiaJT6Ed3/HLxvy7MTiWNj2GtFOxzxQWTZhBgMunJvNa9Mh1Q7YP8GpL3k9W/51nA5Bx2Zpb7TDDcRgau84omyho0nESYhs6Z8qm5wfJpiK50vyqw0r/fhpPw8V3JGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu+8qOdAiJaoGPK/dAR7mk4lBERIiSv6/FO3Ezg+WDI=;
 b=EIamtulr5VGbBJME9Get0y+8urLdkRJkaPvqmefpg1WeXrqtAgV+J6tuISDSrAKSG7aj2uwUXuljAxPqdwR8jQ/KiBEya21LlVVEPowtDw9/nfAf3WzwlXdmEk7OcmPu7LVedQfdSPrq/1iQZ8zDZ/r8dexN7QR4tVHaSKim9CGrYnSYmPadow1Co0asFsflL35lsZxuw4VAWUnwlDINOhbdvkmkY4iC/caPK5c0Ky9SPwMOjb/7LQ9OvtmDG+5N/xEX3cDJ/PrnpG/nRpIaLXXJDLWUkuSlXcPhwQsD/G9MRdD2yeIx+O1Q1ay9CECqKtiZW3uIGtxDys77WycmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu+8qOdAiJaoGPK/dAR7mk4lBERIiSv6/FO3Ezg+WDI=;
 b=f9KQP4W37RQfQZc7yZhB5YtqjA8GgwM30Bb8n3KK7yvsQf7KtVlAZNdOj6uBIHQPfCJ7y+sCve7VA3q0LHzaLIaPnAaTUb5E1z/fF4Z0YvlWUgvPpPJbQT4ZQin190c3PRodMVwtjJb+bNdyhAc2+2SEe8WX8WwA8L97qR0OGy0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 18:29:38 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 18:29:36 +0000
Date: Mon, 2 Dec 2024 18:29:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <ce2bd3dc-e7aa-41b4-9d57-2cc683b5659f@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125202021.3684919-2-jeffxu@google.com>
X-ClientProxiedBy: LNXP123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::25) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a50d06f-4eaf-4b87-f43e-08dd12ff4635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AZPAE9rhz7b/yOZkELohhE9QILzsD4Wp6PmlK7V4rIZH2oiaaP5fxzsJQPNO?=
 =?us-ascii?Q?uIebH3OtWbYT1p6WAMhgiR8xo6kwtnEBYDNe+4bc0M8vmZxEOa/TFkZwy3Gs?=
 =?us-ascii?Q?IcbnNBXgRcel2Kgoh2DFFxRbO878MUxpNntSA6hSGKWxwaI8pCO/Q7MxsxTC?=
 =?us-ascii?Q?dax3MKA9PsDYgYLnHqWrr6jmyLUigxRblo1VzHKpCv+O+ElyM7KQeW5xS0rl?=
 =?us-ascii?Q?6BjzVpgDqIuAjXpTe+8yHZNwI+ejGCbQp95znocRH9+VC11gyRcDRz7WlptL?=
 =?us-ascii?Q?7FBAV+9yJpmiVElpAFYvGBje1VI4XmCRJU2t+9+6sqNgtRaIst5qY5QN/FMc?=
 =?us-ascii?Q?+1181JFfKzhUbDxEw6hjpC+KkgibvdxuJV5vXf/ZDJFEYX0E9ewhEDb64p+C?=
 =?us-ascii?Q?Rx6kp7IqNawAf0NOVI/mRvheEPv5sI8z8dqd59P4J218z1txsPTUD+uvV2X5?=
 =?us-ascii?Q?ITbVzXYjVMUVfbJgd5AXhNI1YbLAu6DmF/oqNOvdpZh8ibbZyHDM5ZQ9W102?=
 =?us-ascii?Q?eMn5o5U+8LBRXIZEK4cM5jMjCZDfW1ZzvTZBFew2s0yx+QcLmhwp0uYxH31+?=
 =?us-ascii?Q?vJK8bywRQXQh5yXKb/WXF6uJendovMbvWzFIQ+EduRIHGiOzf7rHTyJb1ztl?=
 =?us-ascii?Q?z6dsSvftIAtr08nwO7ftpN1OhkPFiKgoI9ecMaW2mCUObcJCzOuyS9t8ntpX?=
 =?us-ascii?Q?Q0wbEwXlrgSTWcvmMTg9whPr70kg2hNAmItLM6os3M7IJpJteDtem9q/eVXN?=
 =?us-ascii?Q?vBhYhKSSe5RB/kwlFz4i++ybA69A7nJ2+T2uoQnnPU5VCgmTcejxPG9nlBKi?=
 =?us-ascii?Q?RTEQlLqgpZE0tSHbYXnndK6FCYw5/D1izWbsvwJ5/9uXmgISxaPOdNiIpTOb?=
 =?us-ascii?Q?/zJeET4ixWzxcwf7E4nIX9PqCDgebNLP8y8YRAfpG88p6THBXJE3ZB7YDDi/?=
 =?us-ascii?Q?eWzDt6GOIDS9aBZqCjYSbAFSAFHHcUSwprdHohct21u5p1SIL6lvrEb9o7kp?=
 =?us-ascii?Q?6krVB8Vw92NZTdS/X3EXRoK4Gbldw90MT10NrEI14Xrj1Q66AQIIifkzgCUE?=
 =?us-ascii?Q?OX0D3R3pE3cX3N48SQ20f3cu8TSDYxX0oa1HXCRF/uhZR/4V73pLZAVfznCJ?=
 =?us-ascii?Q?zyEgvO/wXgxTgxWgieH28ijRtfK6T9VWHFc7gryxZN82I6WH/JDN90PwDnUO?=
 =?us-ascii?Q?+0fAw86LYxosmlgbqFYyew7PPQDLZeUqj99Ex3JR6NSY3FjAtp3QNH0Exe1E?=
 =?us-ascii?Q?Ekmb08Bry88Xzx6j3c2myXBhk7xzAXTdkn66sxWFOXtrcx2h+/Pc1A3kkm6Y?=
 =?us-ascii?Q?l4z77uhCSiVimxLHBN4yt/aFcs/4TxB1nE8O5epc37Fk2m17bGDuEKipqPwZ?=
 =?us-ascii?Q?Cg5M6Zg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aivoSb4p+f9++qO+mIzry2J995/hTdLrCrUFwvYP96q2nggLQ2leEJxw/gvw?=
 =?us-ascii?Q?0fEwdzVyyF+8p/xXiuN+HXMmQcU46sxeAYC9Z7wnRkF30Q7iiagqAQe/nbjw?=
 =?us-ascii?Q?sJK1qsY3xBKjNSSa/3v3Okx6TZUaoYHB4TergR0XQfnkfewKMzeyeIUs8nGv?=
 =?us-ascii?Q?Wk6XiVAeo8P9UNDUBW7gZGWu4udHwSORy99TjgFYSdipiq+bwwrAB9NyHm7I?=
 =?us-ascii?Q?iVQKAN2mAwuozhvTmdFp0CN3piwmDn3tD2jv7ZjbBSfE4k1SNHuJoCFdcsUc?=
 =?us-ascii?Q?aY3Xh2QGX0sHVd3qfw8mLluttrVdaYxRMtNFBFNTLJ3Y6PE1qQ+kDEFa+mm2?=
 =?us-ascii?Q?loVhG4ej7KAgUcr1Ay6D9jmS7rGzRia/2dlcPXdNq8eQro9Elk7slLMvyVEV?=
 =?us-ascii?Q?d4QIjZmYeydNDDqFKii9nCCKgiP9gurzMQ8YGMoYpTpWunmub5+iuOunUNNl?=
 =?us-ascii?Q?gUyfLwJ2baZE1ks7JBEwOMRifoHpuPGGVlbv90vkgWhiPpLL9cX3t+NxAT8K?=
 =?us-ascii?Q?wbBKJIuztH5+mQXTnGpziQpfjO7j7YCrxwiPniOb0awd/68DDR+hnRPwnKJf?=
 =?us-ascii?Q?s0IIijyEUmhLGfOT1h8qKGSWwBwelY/NADhVk8c/DMsftKjX/9DTF/dTV31p?=
 =?us-ascii?Q?+OiAmowf3ol47QCfoV9Dgkl97oiJW76QUw6vQd3/0MuMx5rlfKoa7D4UrPpS?=
 =?us-ascii?Q?yTQh3hX7qrgv81c8RVw/foIcp/7oOFTy99iCqmCr4vgLd/LzK1OzO2lRjgRV?=
 =?us-ascii?Q?ONjLcnBuG5arZwvD3ap1IwwAqDKL/ny9ZTuYAReofFa4FXkGYAsB8L4vDRnS?=
 =?us-ascii?Q?PIhYsVVuBPTOQMopkXxfMylL+vjfxY51I8i8+PL5nS86kfxx/amKAis8kDkk?=
 =?us-ascii?Q?NPvil5bop5Z7OH1ts6EEd837XkB3zy+3ggd5Y/WQWYgDgptHhnOQF232VKDG?=
 =?us-ascii?Q?o+DuRiKXH2IanVPCXyOOx9WR6UWLQcbXqtQtZ/n9sRLDpV/A+X5BrDdSAQtv?=
 =?us-ascii?Q?LfcKTO95XPMlIaz/T9AgYVr70dSZmt8kOnqU7be8sT9oPdnhwAsl35IgO/a4?=
 =?us-ascii?Q?xAgJ4DQ+1htPGOzZeg8c1xyXWRKbNILyL7griuZY9evPBUAU+tn7BuACFYG6?=
 =?us-ascii?Q?gvnvHQ9XJcWVFyk8WM/nHDkZTzxZauHJVHzNarmP/huW/VLI7u625EnUjISY?=
 =?us-ascii?Q?dE5/u2nSPTX68+ud1+27k53+9UWE2AN/uIkyXnawGY0PKlsa3XKlZ4zPAq8g?=
 =?us-ascii?Q?VSrEetZizBkl7E1yA1sVveVMbrGDIYnhB8Vo4VaQxAAcdj34YV2T7RbKvbyW?=
 =?us-ascii?Q?1hgrMu7CC4VdRqHiFgca8uqmZAUuGYdaL4Dt8/deC+3SZHv9sYxD9mWAd+J1?=
 =?us-ascii?Q?8wrPYswP05un516gu7uNB1EXne/WCj0WQjP8XTjP1SrG0rmwfG6swSUFn+k9?=
 =?us-ascii?Q?a5QTfQJumQN+mr+zqIsv/k3JIse6J1N5grRVsvRoQwx1X1bOVxoIHMWKgbu9?=
 =?us-ascii?Q?wIT18zvNNGCGBmbzlZuiB9WBoizfevoBA4g3YA1szXodgBrQuuAd6YcKIxnw?=
 =?us-ascii?Q?pqhzMIutIjSZhHHdjtyjPnfmVftOafqWk/1FFOktWC8ZMJopUOf22NQrotqA?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oM+oE+Fgkh2ACMzuwXcqPhpidmxhku5B/JfhxjZSYNDSrMwK7plcIPsH7xcncm+hZD6d5OQ+F9X0OjD2b3kp1j89iPANgMGcqI94/G5RzzPJPgCyUbRsp5QmT5OHqG3xS7pYhVxCkini7Ed4ygQXUHBjPHTvWT5EMdcvgXrHyRpSVSRjty2HZIqRziqOpaIHkS8pSWeJ27c8/fKUW7oxKSStR41G6lA5xM0b9DHgc778YKCY0FlTEOY4MjnwhrICX2akpDH5IN8cNt0BXPcJ7QsLpKh3M0UtBzUZ5/p6B0CJceMgd//2JF1xJkOPG5kYQrLoOg+GFNyrpb0oF/lg4jEKmmlSq2rq6/u4DTHHasgRwGuICrgVir/s4dT7JIaQkeM6feDWceTH2rgp9je54gZWouCKHBTe47dPeMEjBOq6Xt4P2sLwZPbml0RZiTLBYrmqEP5XrPtzDJ0owMoJLfJomu8j7q+eRpii16tBTBgaLOzTaZfyso85JN3U39uCxoicNmV0nZz+CvhI8aVFHpDO9cB2kU1KjENChBf6a2pcZe/rtjbpwjsz+LwdXq0HDrqDe4dSvv6tEudEIwoapDdWpCng7npXhJIslgB5hvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a50d06f-4eaf-4b87-f43e-08dd12ff4635
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:29:36.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNd2geli2KGUQXwG2K2yGVYpG9lYfuRhWGIz+NrCdTLhtOt5CdjSUxHqMIy28t1G7/tHqP16Zl/uTsMbdLe0h5mN4Oyh0uuubq4KDuuS3OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_13,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020157
X-Proofpoint-GUID: blVt_V67X2U5_o9RZo7hArmOX0RnGRdP
X-Proofpoint-ORIG-GUID: blVt_V67X2U5_o9RZo7hArmOX0RnGRdP

On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Seal vdso, vvar, sigpage, uprobes and vsyscall.
>
> Those mappings are readonly or executable only, sealing can protect
> them from ever changing or unmapped during the life time of the process.
> For complete descriptions of memory sealing, please see mseal.rst [1].
>
> System mappings such as vdso, vvar, and sigpage (for arm) are
> generated by the kernel during program initialization, and are
> sealed after creation.
>
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [2]. It is sealed from creation.
>
> The vdso, vvar, sigpage, and uprobe mappings all invoke the
> _install_special_mapping() function. As no other mappings utilize this
> function, it is logical to incorporate sealing logic within
> _install_special_mapping(). This approach avoids the necessity of
> modifying code across various architecture-specific implementations.
>
> The vsyscall mapping, which has its own initialization function, is
> sealed in the XONLY case, it seems to be the most common and secure
> case of using vsyscall.
>
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the mapping of vdso, vvar, and sigpage during restore
> operations. Consequently, this feature cannot be universally enabled
> across all systems.
>
> Currently, memory sealing is only functional in a 64-bit kernel
> configuration.
>
> To enable this feature, the architecture needs to be tested to
> confirm that it doesn't unmap/remap system mappings during the
> the life time of the process. After the architecture enables
> ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> Alternatively, kernel command line (exec.seal_system_mappings)
> enables this feature also.
>
> This feature is tested using ChromeOS and Android on X86_64 and ARM64,
> therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
> Other architectures can enable this after testing. No specific hardware
> features from the CPU are needed.
>
> This feature's security enhancements will benefit ChromeOS, Android,
> and other secure-by-default systems.
>
> [1] Documentation/userspace-api/mseal.rst
> [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  .../admin-guide/kernel-parameters.txt         | 11 ++++++
>  Documentation/userspace-api/mseal.rst         |  4 ++
>  arch/arm64/Kconfig                            |  1 +
>  arch/x86/Kconfig                              |  1 +
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
>  include/linux/mm.h                            | 12 ++++++
>  init/Kconfig                                  | 25 ++++++++++++
>  mm/mmap.c                                     | 10 +++++
>  mm/mseal.c                                    | 39 +++++++++++++++++++
>  security/Kconfig                              | 24 ++++++++++++
>  10 files changed, 133 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e7bfe1bde49e..f63268341739 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1538,6 +1538,17 @@
>  			Permit 'security.evm' to be updated regardless of
>  			current integrity status.
>
> +	exec.seal_system_mappings = [KNL]
> +			Format: { no | yes }
> +			Seal system mappings: vdso, vvar, sigpage, vsyscall,
> +			uprobe.
> +			- 'no':  do not seal system mappings.
> +			- 'yes': seal system mappings.
> +			This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=(y/n)
> +			If not specified or invalid, default is the value set by
> +			CONFIG_SEAL_SYSTEM_MAPPINGS.
> +			This option has no effect if CONFIG_64BIT=n
> +
>  	early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
>  			stages so cover more early boot allocations.
>  			Please note that as side effect some optimizations
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> index 41102f74c5e2..bec122318a59 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -130,6 +130,10 @@ Use cases
>
>  - Chrome browser: protect some security sensitive data structures.
>
> +- seal system mappings:
> +  kernel config CONFIG_SEAL_SYSTEM_MAPPINGS seals system mappings such
> +  as vdso, vvar, sigpage, uprobes and vsyscall.
> +
>  When not to use mseal
>  =====================
>  Applications can apply sealing to any virtual memory region from userspace,
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 63de71544d95..fc5da8f74342 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -44,6 +44,7 @@ config ARM64
>  	select ARCH_HAS_SETUP_DMA_OPS
>  	select ARCH_HAS_SET_DIRECT_MAP
>  	select ARCH_HAS_SET_MEMORY
> +	select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
>  	select ARCH_STACKWALK
>  	select ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_HAS_STRICT_MODULE_RWX
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1ea18662942c..5f6bac99974c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -26,6 +26,7 @@ config X86_64
>  	depends on 64BIT
>  	# Options that are inherently 64-bit kernel only:
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 2fb7d53cf333..30e0958915ca 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -366,8 +366,12 @@ void __init map_vsyscall(void)
>  		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
>  	}
>
> -	if (vsyscall_mode == XONLY)
> -		vm_flags_init(&gate_vma, VM_EXEC);
> +	if (vsyscall_mode == XONLY) {
> +		unsigned long vm_flags = VM_EXEC;
> +
> +		vm_flags |= seal_system_mappings();
> +		vm_flags_init(&gate_vma, vm_flags);
> +	}
>
>  	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
>  		     (unsigned long)VSYSCALL_ADDR);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index df0a5eac66b7..f787d6c85cbb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
>  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>
> +#ifdef CONFIG_64BIT
> +/*
> + * return VM_SEALED if seal system mapping is enabled.
> + */
> +unsigned long seal_system_mappings(void);
> +#else
> +static inline unsigned long seal_system_mappings(void)
> +{
> +	return 0;
> +}

OK so we can set seal system mappings on a 32-bit system and
silently... just not do it?...

> +#endif
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 1aa95a5dfff8..614719259aa0 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1860,6 +1860,31 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
>  config ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	bool
>
> +config ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> +	bool
> +	help
> +	  Control SEAL_SYSTEM_MAPPINGS access based on architecture.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  To enable this feature, the architecture needs to be tested to
> +	  confirm that it doesn't unmap/remap system mappings during the
> +	  the life time of the process. After the architecture enables this,
> +	  a distribution can set CONFIG_SEAL_SYSTEM_MAPPING to manage access
> +	  to the feature.
> +
> +	  The CONFIG_SEAL_SYSTEM_MAPPINGS already checks the CHECKPOINT_RESTORE
> +	  feature, which is known to remap/unmap vdso.  Thus, the presence of
> +	  CHECKPOINT_RESTORE is not considered a factor in enabling
> +	  ARCH_HAS_SEAL_SYSTEM_MAPPINGS for a architecture.
> +
> +	  For complete list of system mappings, please see
> +	  CONFIG_SEAL_SYSTEM_MAPPINGS.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config HAVE_PERF_EVENTS
>  	bool
>  	help
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 57fd5ab2abe7..bc694c555805 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapping(
>  	unsigned long addr, unsigned long len,
>  	unsigned long vm_flags, const struct vm_special_mapping *spec)
>  {
> +	/*
> +	 * At present, all mappings (vdso, vvar, sigpage, and uprobe) that
> +	 * invoke the _install_special_mapping function can be sealed.
> +	 * Therefore, it is logical to call the seal_system_mappings_enabled()
> +	 * function here. In the future, if this is not the case, i.e. if certain
> +	 * mappings cannot be sealed, then it would be necessary to move this
> +	 * check to the calling function.
> +	 */
> +	vm_flags |= seal_system_mappings();
> +
>  	return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
>  					&special_mapping_vmops);
>  }
> diff --git a/mm/mseal.c b/mm/mseal.c
> index ece977bd21e1..80126d6231bb 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -7,6 +7,7 @@
>   *  Author: Jeff Xu <jeffxu@chromium.org>
>   */
>
> +#include <linux/fs_parser.h>
>  #include <linux/mempolicy.h>
>  #include <linux/mman.h>
>  #include <linux/mm.h>
> @@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
>  {
>  	return do_mseal(start, len, flags);
>  }
> +
> +/*
> + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> + */
> +enum seal_system_mappings_type {
> +	SEAL_SYSTEM_MAPPINGS_DISABLED,
> +	SEAL_SYSTEM_MAPPINGS_ENABLED
> +};
> +
> +static enum seal_system_mappings_type seal_system_mappings_v __ro_after_init =
> +	IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_ENABLED :
> +	SEAL_SYSTEM_MAPPINGS_DISABLED;
> +
> +static const struct constant_table value_table_sys_mapping[] __initconst = {
> +	{ "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> +	{ "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> +	{ }
> +};
> +
> +static int __init early_seal_system_mappings_override(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	seal_system_mappings_v = lookup_constant(value_table_sys_mapping,
> +			buf, seal_system_mappings_v);
> +	return 0;
> +}
> +
> +early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
> +
> +unsigned long seal_system_mappings(void)
> +{
> +	if (seal_system_mappings_v == SEAL_SYSTEM_MAPPINGS_ENABLED)
> +		return VM_SEALED;
> +
> +	return 0;
> +}
> diff --git a/security/Kconfig b/security/Kconfig
> index 28e685f53bd1..5bbb8d989d79 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,30 @@ config PROC_MEM_NO_FORCE
>
>  endchoice
>
> +config SEAL_SYSTEM_MAPPINGS
> +	bool "seal system mappings"

I'd prefer an 'mseal' here please, it's becoming hard to grep for this
stuff. We overload 'seal' too much and I want to be able to identify what
is a memfd seal and what is an mseal or whatever else...

> +	default n
> +	depends on 64BIT
> +	depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> +	depends on !CHECKPOINT_RESTORE

I don't know why we bother setting restrictions on this but allow them to
be overriden with a boot flag?

This means somebody with CRIU enabled could enable this and have a broken
kernel right? We can't allow that.

I'd much prefer we either:

1. Just have a CONFIG_MSEAL_SYSTEM_MAPPINGS flag. _or_
2. Have CONFIG_MSEAL_SYSTEM_MAPPINGS enable, allow kernel flag to disable.

In both cases you #ifdef on CONFIG_MSEAL_SYSTEM_MAPPINGS, and the
restrictions appply correctly.

If in the future we decide this feature is stable and ready and good to
enable globally we can just change the default on this to y at some later
date?

Otherwise it just seems like in a effect the kernel command line flag is a
debug flag to experiment on arbitrary kernels?

> +	help
> +	  Seal system mappings such as vdso, vvar, sigpage, vsyscall, uprobes.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  Depends on the ARCH_HAS_SEAL_SYSTEM_MAPPINGS.
> +
> +	  CHECKPOINT_RESTORE might relocate vdso mapping during restore,
> +	  and remap/unmap will fail when the mapping is sealed, therefore
> +	  !CHECKPOINT_RESTORE is added as dependency.
> +
> +	  Kernel command line exec.seal_system_mappings=(no/yes) overrides
> +	  this.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> --
> 2.47.0.338.g60cca15819-goog
>
