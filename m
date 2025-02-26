Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36C22578C;
	Wed, 26 Feb 2025 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594450; cv=fail; b=ZxzR61+3Xs1or5uHbSLvPhvPbSQe4M4cJhiaRy+CBbyBAFAGJU4aOQUWFY+/L4lzI0z2ImMPNE7et5DOcS6EffRD2WwOi7vr7lkj68Cw3PFut/Fbz2Kr8bFggHyBBHASO3GeE8Y2iayo9QNO/G6SG7rKvMsZuR0gANUV2Tlmh8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594450; c=relaxed/simple;
	bh=ht3nwHO9nMjfKFQJCP4LopbH5Zc6RcQX9kszr4ahTUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mUUTttb4rKH9kF4oPUGUunjFzHK1LlI6kJ0NTSqEAAUiLtdXNG0xdVGpDP8B9myoJWi977A2EATp3/J6wZzSJ9EAbUyqZm8PQ5H4Ls+jTFKo939gK4+HdJR4WDp8b9Krnvj5xORIa5LdK0szDg15ckISen1mzcTdoMKZGDLsGxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UMV5m48r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZDlE3J4f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UMV5m48r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZDlE3J4f"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QHtZjY031133;
	Wed, 26 Feb 2025 18:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=MOXO/+LEGqoQklGUnr
	QI0BoiYh9RsYDQYBoU/B8BCfM=; b=UMV5m48rAPZuOgGrYDMY0zLx+aTFdPSxKX
	0H7EJHZkwGRd8VMZ+YiIe0SwunnOLTBKdPbY3eITkZfqkpMNz3U17OOMKGKdG4d8
	a2XLYT7tRZPmsTA9GyNpHG/MXQfPIXw6zMhKoBjQY1vrjSNRrE4mNEcho1ggY9cz
	ViLjWitGvanDb2LWxyutuDIISRLgtAJr7ypcS9C5/vv3GNy9p7Txzh1fPB7w1cd8
	RMEq7IJfCcBKI1YLzHjht2HdtUY7wZ0uwrjCsEVcqB6KW3MEZqCc9IYtHwN1Rc8c
	kQ65O2pgH7xsmqkqtlM579YXh1ukDrwb0Ap3/l2E0bT+8fN9KVdQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse9sj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 18:25:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QHImoV012589;
	Wed, 26 Feb 2025 18:25:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51caa5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 18:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT/bcOnCd/fARlw1XurGd01AGPFqnjuxbtEVLPqtwwhL5ao5CX2X80/fskapmddJmBvCYnysVKcET/BDh2k6Ped4UTEt3tSdfjvV6L6/LFBzcPlj2NaTJFX1A8zY/3QI0INX0MfaDw0swUAcW7tF2XvKbLtg8kd2BChdS+ZkOj82YzEZMK2Ed1v+RbTL3iyaEXOjh5txB+/pr3fjfWCOaTKXBY+laaQyoOtR7InJqyjqn3hBitzl/mHXZApa7AbuNvnzC006l4j4TrIM9X+acvLA6gePyenxvghLSPsc6YLjcrer/7cRskozA8g3McOArfH1pPT8Xbt/GtCTNDyA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOXO/+LEGqoQklGUnrQI0BoiYh9RsYDQYBoU/B8BCfM=;
 b=UFnRwW6oX9OjWvKKvnxMpt2QnW+tbCIsAZkFFgFEQdgs7pRmqNHsxx+uIdlE1cAK9IRN3uXXFThz82IovlTgdb14edvK/Ata7VppGX3WOMB4S1zy6uTgTp8HNqZRvU/AT2a8F3xD0cEtf/Nj0/xbF7wzduq5fBKdMIQd8r698xwKNPWGAyrvL7wiOs08IQZieBE+LSRN/z414MipXbtqdLftyLIRLMp+bdAh20xajhnAwmuFr1hf9tCUBDgIA+lNcukGAs+gwuGwGrox3zq21y2P7+nRMO72Pk6wbJ0TePx9i3p4XNe0wgWMHXuTOEjnNg//0yPrYHoB3LUdW/pmUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOXO/+LEGqoQklGUnrQI0BoiYh9RsYDQYBoU/B8BCfM=;
 b=ZDlE3J4fW9VycqH/NBBSrTBtW6tlCD1i/phOvODEHTP1cSzQ7GgPBnv01DWKhoSSSSo0pUFxp5u+KnhDoPkKSGg+r3xUlOO81Zlk0znyT8yasFDfEdg30mKAq95RpEl1dcuBxGQzLvikLoocNRKE6DKBUGEowUoo13prIWG/yTU=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 18:25:40 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 18:25:40 +0000
Date: Wed, 26 Feb 2025 18:25:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
        jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
        avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
        adobriyan@gmail.com, johannes@sipsolutions.net,
        pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
        anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Message-ID: <ba83f8c3-6f8f-4ed9-81ec-104f72ea4ef1@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com>
 <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
 <20250226180135.GI8995@redhat.com>
 <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
 <20250226182050.GK8995@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226182050.GK8995@redhat.com>
X-ClientProxiedBy: LO0P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::9) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: c23fc211-3b27-4218-d344-08dd5692f8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RuOUSbUxsDkkK5nADgjqVd+kW4nJFEd28liv9thC6y7K9HdBWbjrhIBeuT/7?=
 =?us-ascii?Q?gbw9+rW4ArRrJKipxJEOfAZ0X16QYyZG9kFEgGNTufQpv0JXEOBSoFV5A7Hk?=
 =?us-ascii?Q?iox5Ych0FDdjFu8/b+lvFchgswrmIcIhyOS5q5da0E5JRThHS1f2hitZj2TH?=
 =?us-ascii?Q?gnXfaMrQ/+4VFczYMkGuOd3L5j9UPvs73MUdz8K/VHi4mFjRZMN5kni/kiVx?=
 =?us-ascii?Q?S6F/wthnlUhGCLX0vjMqV2RfO3ga3nUdyMXjDkbr7hTWZ3L/nwG47upaZPQ5?=
 =?us-ascii?Q?K3ZfJi1tDo8WAVAFScf81XPfnVk4H9I3gHoB/F7IT9VsnCvafTR8z+9Z/yqN?=
 =?us-ascii?Q?Kvp5MZKF8vQRnxZK7ZgRmrZZlm6Dr/XbU1pyZZ9CF9uAEYAbXQV9/13y6ydW?=
 =?us-ascii?Q?0t+eDkG1oA0Wo6RutgvnqNqCM/ZCwbrFPITxZyP7DZspsn/DZxZoC2i12ai/?=
 =?us-ascii?Q?I6aMD4OR2UOBbYaK2Ti7n2y17fMG5An9outA+2iVHjIceayKhyBxuZ/Ga8Ln?=
 =?us-ascii?Q?LkJzs7k+w93kSOPoPsjYvWfJ1VDTtldy2lda1GKis4TGLKPqt4zGOVMWs77i?=
 =?us-ascii?Q?v9BQqKPpl3OHNh7xyGqP/L3oBaFlRcm0HqCoT/hDw6tA3yP0xvZ4oZpUcAr7?=
 =?us-ascii?Q?hH2V5okLDsbLaE9pXtM+rp0MNrSiQElCeP9tX7NmQ4V7TAjmUE8/G+1nwOn1?=
 =?us-ascii?Q?iYPeh19xjuWR97e9JQ+BONqo4Op7BiCYGqDd5Y7r/P00Gr9xq/H34Pt53SMZ?=
 =?us-ascii?Q?HqmD3Oas4cXO3gq60ANBp9i2AD2rtybC7pakg370JvWokGFqohMfqN7h0iDt?=
 =?us-ascii?Q?KVT9i8CLoo41L8qR18VmHpNTbDM0ha9r4movsKv97AApDqBC2pe5lUxIiRM3?=
 =?us-ascii?Q?Go0kMEshgn7Y/BPTbtx9ZeHIIhx/czmJC8NeRCffqBsAYs46I1afatjYuC01?=
 =?us-ascii?Q?OHO8zGsEDTntWJGTgmWUAfniVDjxtRZzgs3uV4jcGvxWqBlWrLgRiY1elXaq?=
 =?us-ascii?Q?xR3d+6m/iyNMpEMTGdvrDVodnduOjvWuOt1fcXd9J/LyyiyDQkCw9hRB6bhS?=
 =?us-ascii?Q?GARNBi3B2sGCPS2NB1+HY3ZtKupljdZcRsAqJ67Kw24uA4tC0AQRrQRAtDM4?=
 =?us-ascii?Q?b71W89Ao+x2Ti9xLwbYpViJT4eSQzKZ2K29XvBcyDXQxdp5ysNerSrevop8R?=
 =?us-ascii?Q?PJPUwT4OlT/DL+kPphILGkuhTtZa4bX/bnxq1q0klhQs6Exm8kwTuf5wEuPt?=
 =?us-ascii?Q?lFnvT5irx695AAPUpuT6+6W/co4zYhZYsEUOdzgU9YGA0OL7k7UMSu9O8Pc0?=
 =?us-ascii?Q?KaK4FKdbhCnKzXWWVhNeYYsf8DxCnPhpdKxeR2bWukSP/lfbclhms5YmteHy?=
 =?us-ascii?Q?5JF1BSQ85q9l/HCaoFZNTCqPcUnn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DT2Krn2Jcjv13ghh1hUo8VBZXOKNugqePvZjlP3tlh1tLJ3ZehNJXiLmYttf?=
 =?us-ascii?Q?sCqDB6p5HR/9lDBLpT9mB9nAuQiabD7WTpalHJsaxB/8GbtPdftXG/GHGJFP?=
 =?us-ascii?Q?baEILS5olSZnRrpzPUnepBtfOK8hfwZqUVY2rSA9uySpr+sU9HYUvzu6W6tr?=
 =?us-ascii?Q?WDnrEsSLNU7OIpMr+PZIzw/eUdPzAXMcIiPdhqvOqXrK0fLQBqYQyimUwZt7?=
 =?us-ascii?Q?Ws0KJpB3Ycxgq+X6EsYhT4sL9KYMJgp6X1NvGTMfdSrcKqMPtIbj73nLGVIa?=
 =?us-ascii?Q?jMteac5oUbH/V2uALT/immiUqi4H7N1H3ZTF4oMQMmGsJ7G5IhkVVeXWTdKg?=
 =?us-ascii?Q?z+E7+1cWbUATVhW85bu8XVRfNfkQaK/m9Ga7/Kj9d6+JALkbw2IKoYL2WB4k?=
 =?us-ascii?Q?MSRI1PTrVYYh+Z0aOGNhN9TNs+H9eGBpDwunJKEOc58cWaQz3V3fqCxengKy?=
 =?us-ascii?Q?HKIFUSx74LN3jpTFH2K6rsybHPvOzy+sJX5KQfEgidiA0ow+5T0C21zwefhr?=
 =?us-ascii?Q?eZ+ko8/c7l+WnMcIW9MgJ+c7mfMPwv2RPmNQ8kHgQZCHXh5J4U7u1hhJcPUj?=
 =?us-ascii?Q?FYxu2v4J7nJmc/Y+dzUoqclMrW3VgGwiQgCpt/XhTeJpgRifkrLc3jFZlmTl?=
 =?us-ascii?Q?ywvKYzX/uXwOySzRv9LS7BRK8bc/BpSj3syHvcadnMf0komDuSOgYHxgqZlE?=
 =?us-ascii?Q?8eCzTF4N9dXO/cQT51TrO5eeXgyvoeO23TaC7lgWOYVHx70B69KJI+rDRpKh?=
 =?us-ascii?Q?7FbJvqSGGNXEbLvtTwzWBABC1S68BxQq+aEAR64wjs0AFuMgRdQGK+lRUQpO?=
 =?us-ascii?Q?jE/Lw5WE7O2afRsi7w3peEPp50ZLEqf9DPFpGjUnbXKj13ykfJ+CpjDk117w?=
 =?us-ascii?Q?WOoIGsMrnNiiUaBugcB1ygQpdTHPO6Iteo+ZNIp8vSK9SboRM4QaoPdYvq4A?=
 =?us-ascii?Q?/QNz7Lt/JMeTVQoyqPpbxPeWymIPeFkcC2TKDbf8DEIIFb4TCivMp0tLAvsI?=
 =?us-ascii?Q?y01bS5wYVALUED5lwH0xrdIOzX+3F+stxbXK+Yi/4sDQx19WQO2o/pGUlorM?=
 =?us-ascii?Q?ua6Aoo7fm8lIQGSJbxXgP+bXjPofo99SK9qH328/aNISLi3xhUiZifdY1hFa?=
 =?us-ascii?Q?6rRUirZjZegliTRDODlzkXvbtburavGCIUCICcgpUuW3PDbcpjWPMYPN4GoH?=
 =?us-ascii?Q?qdHpuDxTeMhUpPIaISeBUcHvhwuXMm3yj65K/xHOCUSm0/+PEa02Saol8OSQ?=
 =?us-ascii?Q?bWxRDU8AjwcnoQCKwqLulAVTPSXkvCqTpeghNQDWU8/5hZwwTdAPWZ8/bHWD?=
 =?us-ascii?Q?QTuF/h31moYA1o09IJZzB8InR5yu03b94lBseKZ26L4qEO6hlbE3AaSUy0sR?=
 =?us-ascii?Q?G7hLJ2QhQ1yMNdp4ZW6HfZZpDhr94XMNbhUgy+gY/DBwr/HhCnVxBEYZoz0K?=
 =?us-ascii?Q?SD5tJx1i0U9RRtR/brv1SwknlYjDrQhp6Zt2rUOWHhHCfDamOMIK2OJnS7zs?=
 =?us-ascii?Q?AnI72JHjbHazS0qEbXFkpS2CH+Apuh5UHtK4AZIcJ2tLBOyqbeun0XPhI8Or?=
 =?us-ascii?Q?sRaz0oVAfKK3yXqJAXBzcjmpkXnB3DuCZHFl4aZf/6YSh9k/6ptqdOM8epH5?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zWftZaQYfk89lfc7dTLmLVZ6GzRco9lHRjMTDRqPpe5l6Z0+taXs87wd4lSntCeU2XYMJ1xF1VPMiugQm/nJPrzvo78XW/L6l5k0CocrwsKGXDmIJyjcf/E9MpTF7R/xandjuBUL7DVBME8J+7PPhoVZYRXHpQEs14aH3E7JwQaqWMuOcYjLV6BtbMB85QT7cIEymMmRayz9lgOFnYVLgFajcy9XvRn9x9yJ36lZGRH4vDUoHab3EnZzvAASONEX5f10TiVXFdYSdGc3/pFlnmO6LJl26t+yu/WYwOS6oDKDyBGjnzE19qRJn9jruCdhnbewwcijk5Bfd+/MXG5WRo/h/pXi51O8HgXV+S2mjbBUUSapA5pNDHv+9f73u9nZKumuO4aPva3H9Yh1qpfU2ozCPl222ABREQqEbhgX1kSC40iIhLzmaD8kWO+Mj/wVqVtX0u5sx9fkUR5VhPhQ/16ojy4tJF/2QYsKxIy42KyAeeQmq2GQ33mU4bdPT/m6CRepPnQGB/saxjvYqfTno/2Yb0OjdhshW2AJZOZp/Ksf2HVSZoRK7ymCzYVuqE00mYkFlFsLRWB4gU4gfOlXj8z01dsV1i2eyZFBVXLj0Vs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23fc211-3b27-4218-d344-08dd5692f8ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 18:25:39.9573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG7fm0OyWeVkruFwVy7D7HtY2vazk3mY2AfPEMbblzlhKymlvtyeVsfutX4EGm8OuNiUSlBFhx5TAw+qZDoZ1/NVjMMnTrk6X5Je7TXrQUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502260145
X-Proofpoint-GUID: RG-2KJAmt5mdNldBaPGWE0l4wixvYCea
X-Proofpoint-ORIG-GUID: RG-2KJAmt5mdNldBaPGWE0l4wixvYCea

On Wed, Feb 26, 2025 at 07:20:50PM +0100, Oleg Nesterov wrote:
> On 02/26, Lorenzo Stoakes wrote:
> >
> > Like I said, Jeff opposes the change. I disagree with him, and agree with you,
> > because this is very silly.
> >
> > But I don't want to hold up this series with that discussion (this is for his
> > sake...)
>
> Neither me, so lets go with VM_SEALED_SYSMAP.
>
> My only objection is that
>
> 	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
> 	vm_flags |= VM_SEALED_SYSMAP;
>
> looks unnecessarily confusing to me,
>
> 	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMAP;
>
> or just
>
> 	vma = _install_special_mapping(...,
> 				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMAP,
> 				...
>
> looks more readable. But this is cosmetic/subjective, so I won't argue/insist.

Agreed. This would be good.

>
> > Jeff - perhaps drop this and let's return to it in a follow up so this series
> > isn't held up?
>
> Up to you and Jeff.
>
> But this patch looks "natural" to me in this series.

OK, I mean in that case I'm ok with it as-is, as you confirms there's no
issue, I've looked at the code and there's no issue.

It was only if we wanted to try the VM_SEALED thing, i.e. _always_ seal
then it'd do better outside of the series as there'd be a discussion about
maybe changing this CONFIG_64BIT thing yada yada.

>
> Oleg.
>

Jeff - in that case, do NOT drop this one :P but do please look at the
above style nit.

Let's keep things moving... :)
