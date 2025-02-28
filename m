Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FB25BACB;
	Fri, 28 Feb 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738843; cv=fail; b=OTh88TJEEvAi1YNYhvgsWzAGEB4gJUOpP4poh2lf80MPudIvzbYZ6RGiVeHiA5WwBor/s0XQoaqIj+gG1EDjG5iwMBOtrRDfarccCjVo0YRsGSy2CUoNvdR9EmRsItPVFU2StTYm18xHwQVAFQeUMRBnvrvdH88/LpZxb7ZYuSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738843; c=relaxed/simple;
	bh=iPFwu6WkqCJ3uMOVRwQCi23qhBUNWg397Q3UIhx78/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jCY0rzVbPYKITQ+/fmdS2x2GvcxzPF8uQvqpDnpJAWrn+6+KIZE3qsdLKwAngxto3LActgujMg8YRUngxPhssFZAkxG4cZwX9eYNgFUxJBuaFsMxWASL+31t1nsuzN+flr9iD5WFIiM5zKR1aNLTBX1wz8dVlpN98v0iJd746sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DjP15hg0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i9O0KLQl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DjP15hg0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i9O0KLQl"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S9Bde5010412;
	Fri, 28 Feb 2025 10:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iPFwu6WkqCJ3uMOVRwQCi23qhBUNWg397Q3UIhx78/A=; b=
	DjP15hg0Cp/FCMag9xAnlcwqVvTHkabqR1pkHOrnMeGVEghauGwJ1FZMl6IU6uOo
	RxkxGdCj+thjsGskoyFfSKBWLGb7b/33TSGYUXsPj7deja9a9LQoGbHD+pGwTOTt
	lqQU2FJjLOOuwTu0XDdXThWWDWPxXgq0Ju8rB3qoppUVgrV3qWDBM9SXEwozDzWK
	41wKRjAoEZ6JZasSWQOdlRYEfDbomBJcTcRzZQ6+YjTn+vR5J00sj5X/FhmbQgxW
	KT1jfgX1O6wBzcoJvaDAPGCutcD1srv3PLAYb4Nl6+Xa+SLyRfe0+5lHMB9hJm+/
	5W/QAxUrvRa0ZrZ1lvWaYA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse59n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 10:33:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SA4mMg010336;
	Fri, 28 Feb 2025 10:33:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51d5e37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 10:33:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpAsRanaFa9/+SzIC38cKBrZo6+Azrt4WLJ4GG7/d5eL/BIsxW1bZK4Q2XYSvg2I7V1HnaCQaLNgnSA/gemNLQk7tl9rWqhcZhb/uamZYl8b1iC36wGiTcLKrmDZHJ6DugkeOckpikNQ+nUts62SwX9IVWAnJHntt7qE9SkbrIH6YQbGS1/dFAcxoIByb66MlPdrzc7AcMUF5zVtM1iEq9hiq+cMfDCdVsxgYLX1VbPaQQ3YfI/aqLzZ9JGyubKwsWSWxttJkckHRNuZGvrmQarISfFQ86zpbNv9hZf9KIDwgjVjuQ/aDpPewJZD1dbQen4wEPvaqCusa7j+dPhdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPFwu6WkqCJ3uMOVRwQCi23qhBUNWg397Q3UIhx78/A=;
 b=XRhWa3CjWuaGVimCo4y+8wxcw0yM9ZLvORZO6c6WSJzJ9zNCPC6TRuUmV5/beT3ZWzdXFOPGcKZXRV9GvxCVEhZC7lGRyG4++osaBSmtDbZF4UdoyXL2skVDb3ArU5pkytmwEwRk5aWFd57BpSwfeUl3qYtNx4NYFuAD8MV43WNfWHp9Oooo+RduJx52FQz3jy6zVp04ZYsv3++juZBVzSS3cj65Q624fEOsodXLfkjdXxRfn0+fzm4yL1KHJoWQIE0KL5SrwixPeEle2ZN5uQigKr2WI/6GoYkctgNHc/WExJKyvz/NkuDIhLhzn4HPHAhA4p2kmh4dmKiyDS8m7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPFwu6WkqCJ3uMOVRwQCi23qhBUNWg397Q3UIhx78/A=;
 b=i9O0KLQlztNFQ/3InqYFcU0PX2JP77jWkhWb31XMNZAGvRdobbUnZNAPnqqb0ro91acv6l8aC8Tr31HYfilL/yxwYWT7ZN6xD/ABus8ZTzFHdBwQUdF2hSW0NHCbTyVx0JMZfifA8o+KimbO4pE361vMVzM6FblK7p+OB3wA2s4=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB7524.namprd10.prod.outlook.com (2603:10b6:8:15c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 10:32:59 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 10:32:59 +0000
Date: Fri, 28 Feb 2025 10:32:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v7 0/7] mseal system mappings
Message-ID: <99321ece-9afd-4f2b-8fd9-864ac627aac0@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <30b4de93-70e8-4384-ae56-9f6b6cf0f347@lucifer.local>
 <CABi2SkXkfFAMhmXP1CKHCZMxdKWcHx8T9_0-nwBPWycTbxOctQ@mail.gmail.com>
 <afbaee91-3bea-4127-9dc1-7b43b0090229@lucifer.local>
 <CABi2SkVcbuxm5j7xekSuyV=9goKxAPcDE_7OEz2JLds1+K0j0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVcbuxm5j7xekSuyV=9goKxAPcDE_7OEz2JLds1+K0j0Q@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::22) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 55334f5d-69ce-463a-eb54-08dd57e345ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVV5ellZYlJJRjU5VXprRXlXR3dYMkF4STh6VlJDQi9yaTVOVGg5ckxVSGY1?=
 =?utf-8?B?dStmOWsyUUJ2TGpaUlU0L0ttVWtoRFc2V1RBYlpUVllMRXJGQjFHWjRub2g0?=
 =?utf-8?B?Ump2a05hZk1DQXRXb2kvb3Z3UkFYQTdMWFNzdFRwWTZ1Mjd5T3EzWlJmM2NY?=
 =?utf-8?B?cDMwbC9Nc3pIcjdpaWk1L1hZMnNWQUt5V1BjczRvQ2MyOFBFN1BMR2hRWU1L?=
 =?utf-8?B?Y1IzLzNXYWl6UlJyR3lEYTF2OXRXREFmWG9vZFdDcHh1OW91bHVDZWZkdFlk?=
 =?utf-8?B?M2h1QTNxSjRyT3NZSjl1MC9WVmMvNjc5YkNRUzV5dTNSaHd5TStBN3hCeDk4?=
 =?utf-8?B?NjYyM2pqMmJuV0k3ZVF4MEl1RGl1WC91UUJtcUhTd2s1REp6aDVQUUgzUzds?=
 =?utf-8?B?by9ObndRazRXWEd0YS9UNTVHaVQvUUsxaTZvSW9vNlNYT1lrRWs3ZnZTS3hE?=
 =?utf-8?B?Um1IY25ZRWZwWUw5WWxuWVd2MXgzMnZhaHJ2aDZ0VTZFYTY5cU1MUVMrNndF?=
 =?utf-8?B?R0ZCZWNvOGhzSjNzVDJ3SktZOTliZjlKcnYzRlhsL1VIaUtrbFJoUEVLaUZD?=
 =?utf-8?B?Sm82dHQ2M1IvZVVYeW10QkVmMUZMc1p5YzRPbzZTdG1COFlaMWFiNldxRWNt?=
 =?utf-8?B?NTIyenBLK2VTa25HVTBWZVNPSzRQSkxHUFhsTlRVQ1hkb25aNW5FaUVJNytB?=
 =?utf-8?B?NXNITFVnYXpvU0phT2VSUUtLQUVxaFdiMk5KSmROUnNzL2FBcEkzOEhSV2Fn?=
 =?utf-8?B?REpQczZIYklocmhIcU4zdGIrTlVxY0hnakpFT2tDSDE4YUk5Yi8waW1MVmRQ?=
 =?utf-8?B?cnovOGRidlNTd0dUb0hENFhGcC81NVNHaHlNSjhKS3B1TmhmZVowcnEwanpP?=
 =?utf-8?B?K3V1L01uSkMzSjVuYzRNOVhiT29QaEMxQkY3TEhJT2JQNjNEZFdpZzA2V1dN?=
 =?utf-8?B?OGFodXBYR0FTRStHOUlISFhkcnFQeDlsRDN4d1NyNUh3dGxhVWRKdysyTTRo?=
 =?utf-8?B?bGYzRlNnQUt1aFgzOFBpbjVOQll3MklTajcwTXRFNTFFRHJqajNLREhtaVQ0?=
 =?utf-8?B?SFdkRWxRY051Mncza1Y3ejM2OXpCU2FGY2diMGd5MEJaMTRwMWRiWUgyamQ2?=
 =?utf-8?B?NWQvUEhlcXpiamFSU3BFVmwvYm93VE40c3hQc2RpMUwzNFYvTUpyamk5NVlx?=
 =?utf-8?B?eWRCSysyNmhKT1o0VmlqL2RSeWdmRXF4eHVlYjVMZ2dXQmZ4SEVObkc4VTJn?=
 =?utf-8?B?SWtONitRZ3JPc2hzckI0OVR4azVkd3pQNkJvSmZLZGFNNzlla3I3am85YWpI?=
 =?utf-8?B?dUJnb2Erb3l1ZFZjYTJqOUtnZmFYVk14bW4zeGc2OGhlZGlPb3pWUEhyd3Ir?=
 =?utf-8?B?blQxanlkZ2pSdmZjU3A2S1c0MXlOL0xUeDJzRXFXbU9mbXE1ZjJhYTNtOUla?=
 =?utf-8?B?NUYwb2JPbTkzNU1ocm5pN3lnVmJOdEpwV2lCSGhVaXBDY21uVG1ZbjF3b1ZH?=
 =?utf-8?B?b0hnTFRzYndNUi85NVhBSjBXZWR5U2VkU1p6cGFrQzhrTjBSa0EwcVk1Wmcz?=
 =?utf-8?B?VUU4Vit5Qm05b1cwU1YrMjZHVHVZVGVNQlZ1d3IzSXl0Y2JwM3NlTGpraEw0?=
 =?utf-8?B?cndQWmpla1MxYkMrQkdLRjdPQ0p0VUw4d3J2eStVdzdEbUp2ZlM5aUt4YU5D?=
 =?utf-8?B?SHNFdDNIbFdsMEJaa3NhaHozQ2NqTEhNQ1V3aEg0TmtKbk9tWEdZMXJUY1BS?=
 =?utf-8?B?ZkY3M296N2FwTlM5MXpiYis4U0xXaktjYUU1bmdSQ285K0xUT2VBQjZQeU1v?=
 =?utf-8?B?VVBPVm1TVFVCUGxTMFFvbEQ2MEJpRlZmaTRxdmlnNWVoUDlwVHpiZXl2aVpG?=
 =?utf-8?Q?EITvdsT2bkRlF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVV2eEVTT0lEV2p3YUFDelErUDVUd2swbmlENkRFcWV0OVlORjQxaVVpcFM3?=
 =?utf-8?B?aGxWMnlFajRxbjVQaXhHLzliQXg3N1ZLVjNmVW9nWHFSdmRWeTk1WGN4N05x?=
 =?utf-8?B?ZGpyMXJQc3Job3prZTlmMTRNNzdORUJ1RGtiOCtjdGhtSnB5djFqYnpPZVhv?=
 =?utf-8?B?NFNDUC9tenAweFU2K1pCQnA4V05XbzY5bTZjRW1hSENXTkRneGFlaEVjcWls?=
 =?utf-8?B?L3pzM251Z3J3Y2ErajBtNXZKZGpIb29JWTltdWdKVHllRTNKRHNjbUlkKzdp?=
 =?utf-8?B?bTNvTDNJMFdXOTZoU09ZdmtxbGQxaVdhR25CT0NXNEJ5RUc2VkVFeExoa2tZ?=
 =?utf-8?B?R3JuOEpuUzdLKzBQd3p5Y2VLdUdXYzZzUDdmNk9PcFpTYjhkYkZIcDBKOHZO?=
 =?utf-8?B?aVpYek42c1JrMWxKTVEwakZpVmMyY29zdG9yckJtV1R3b0lRVUgxNnFUYVpQ?=
 =?utf-8?B?ZWRZN3RlQUJjUmNkWWdwVmhzOVdQdEh4M3ZVNGk0TGpxb21nSXpoaUZ6ZWZN?=
 =?utf-8?B?Z2ZBK2dSUnhtWHZwOGVHbGZvQUxkSnN5bWRDN1k2TjBqMFYxNWdqc0JSb1cy?=
 =?utf-8?B?U0Q4T1F6QjZ1Sk5RNUh4Wm1vNXdGZzhReEZDSVVmbERnSFZBNlNKM2xnYWJL?=
 =?utf-8?B?V0RxNW5UWEkyaVlEM0krNmFpWXdIcFVJZkJQZzYzQUxTZUtwMkxqL25Rbzhl?=
 =?utf-8?B?bUg2dVNtVzFZaEtwbGdVbkRhN2lPTzJST3FkeVBJY2p5TmRJMXV5cE9Lc3cv?=
 =?utf-8?B?ZnVsUTRMb3VSRGswaFlyQ1NmdE1PZ1E4dFZXd2w0YVFDSXltd1p4T3pZU1R2?=
 =?utf-8?B?bUVORTB2cFNnd2JmNER2TUZGV2d6ZUhvSUFyMEFwaHdwSDJySUtvWEU4VWsr?=
 =?utf-8?B?UDRUS1BrS0VuMnpvZ3ptNGIwVCtuR0h0TFUxb3M1VnMxb0p6QUczTFR2UHU2?=
 =?utf-8?B?NHFwRHZoL010L2FYeFp2dlBMNkdsenJmYmdHY3QveTREcXN3Y1kra1NTV3BP?=
 =?utf-8?B?Smp1dFE1bG5uaFVtWUpXUXpiTmNwdVV2Z2lmMUttSGp6RkpaalBFYXZlU1VW?=
 =?utf-8?B?YS85aUlsZjFjV1JQZm8rQXV4U0V6R1ZjOHNKUzIrL3VxMjc1TkpQWHlZdjhy?=
 =?utf-8?B?em5mMDJhWVJqRGloNDROK1NNVHM1ODNKMnNDckhwY0ZKY1ZxY0JOS0FiNXNk?=
 =?utf-8?B?dUF0ZzRMOCt0cVZyZGpTUWxFbUd2TkpBUzliVDhHT2hMQm03MEh0WmsyQWd3?=
 =?utf-8?B?djhTNkw1d3FZWGpGMnF2ejh3M2tnQTQwSjVpRnFkZ3NPN2tDT1NCNXdYUVpX?=
 =?utf-8?B?NkVrZTR0QVJkbTdDYjlLbWliMGpIeG8yQUFGVzJ4cWkwUEdjOE5lNkZ5Q2h3?=
 =?utf-8?B?N1RuWGVUSGc2akFpZWdMM0lkZUxjZ2k0Y1BObEtPbmRwRGJMQjVZbVdJNm5r?=
 =?utf-8?B?eE56dVhqZ2diN05LRGMyUlUzSThlTjYxbmhBYWMydE8vTkVnVVRnbG9HT01w?=
 =?utf-8?B?T0ZINmt6RXpHQ1hmUEtYVitKNkQ3Q0NKNFdLK1VTUTFJbjRRcWtFL0NDeVBY?=
 =?utf-8?B?RVI0UE1jdFhaZUR2QWUrM2FpckN1Wi9MVjhBb0FScUcxUHFDWnpNZjI2M3lu?=
 =?utf-8?B?S3RXL3Ivd0xvbk90V2UvVVBhMGs4U0Z3Mk41ekJHYmJZVTFnT2ZNL0dmc2lY?=
 =?utf-8?B?M2JVd3RyQk1SdW5SYnUza0pEV1pKVWQ3ajM1MkkwTEp5RXNlMko2RGRRaXFL?=
 =?utf-8?B?L2s1b0tCTUIzYURwYWYwTEJyZ2lWN0R2RUZQeWUyTWFvNVQvOGRSbDdFQWc2?=
 =?utf-8?B?UzFZS3U1TkxCWHVuWThPMy9hV2ZNRDc0UU50cGV4WmxMVFAwcWdSS0F0T0RW?=
 =?utf-8?B?ZkM0NFdvVWN5T3A1TmlPY3NwU0ZVRmtSZ2xNME9YTVIvblZ2VjRNMzM0ODFv?=
 =?utf-8?B?VVdrTU1LT1ZGNkVvSUhqcEpraWhTWHBrQ2VMMklQcGlrc3daSlJCckppTEhO?=
 =?utf-8?B?SjRpTysza3dLM281bVhlUlFaZmlJOXFsQlhFdkxKSlBkdSt2a3FzRktwR1hk?=
 =?utf-8?B?Z1FrSFZ0dENOQUdVTjVrWkpBWS9ndGZkUEU3c2RwaXRiZG14WFAxWFZkNjhp?=
 =?utf-8?B?dE1qNVVRNCtUVlRZelVhMnZtY01kYlQ5clNlN3RENWNrZzVIMEhMbk1DNEMz?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uyqew8H5vzP/GI3Qi/EnWXxOVKC4iVYulq6zkhVYBTsz5j55igDAC8tMydl8DB+d7FwakCEJW2t8WDZJDmhe2QN4nMgvqA+zxZ+jSmx0CYQ5pkC7Ydnsl8HYInl1Fe2f4qLd8xp1kMKtr2oucoAbggjBxdcgj6+bTZD6FhK/b8+1egkNuGsvExfLZbtlm0EA/ctkfpPLjcmdSK0T1e3XdkQYysRYiZhoffsGddo59Y8k1y2LafAjHOyxEFaC0YhtCHrvnIEJJLVqCx/JI6inOJMjIeC01L2yIzxAgtP2QRMzzXfF+GINtJ3L04Zj7y1KvgU3oCJ2rJm3xUOfY1l/1QNf4pMN2KC5sJARDpheZ1n4ItkVa0CKHSfyrWIGrC/9+09HERvV3ifO7/qahsEgCuphvUpxd6Ae5Tds46I9IQG1G4tEkD7HvzVJIwVljpuzqqlziv1ZYynj2j9cuatCU/mGtRF/npzzmnH2+4IVNRKp8IZS5YXv9SxPjUI7WiX/WvnDWzFh3M3brJJcUDgydODrajEOJYXjqytXv/cCSYrhqsrCuCnanSLQbYsUQXymOHPgyR8YbcyD7J4YZgkUthRgV72lwEBFOS942fJrW5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55334f5d-69ce-463a-eb54-08dd57e345ad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:32:59.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo3MxrKgp09ylrhp02RAgh68DV1HoOWB0HuiQGSj50H12qF40q5FzgoTPrl3zJNVnAVZE5kVeDJ50LYTwczUKNpqp/3yP1GCKrIfKgOFElg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280075
X-Proofpoint-ORIG-GUID: l8s9NCvspQw-ezHUcy51fsn73Qz1Y_Zi
X-Proofpoint-GUID: l8s9NCvspQw-ezHUcy51fsn73Qz1Y_Zi

On Thu, Feb 27, 2025 at 03:43:07PM -0800, Jeff Xu wrote:
> On Tue, Feb 25, 2025 at 10:01 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 04:17:01PM -0800, Jeff Xu wrote:
> > > On Tue, Feb 25, 2025 at 2:32 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > BTW can we please drop the 'mseal, system mappings' prefixes on this
> > > > series, it's really weird and makes it really hard for me to actually read
> > > > the individual summary lines for each commit. 'mseal:' will do.
> > > >
> > >
> > > I am not sure.
> > > I had comments about adding mseal, system mappings, as prefixes, and I
> > > think it is reasonable.
> >
> > No it's really horrible (sorry I know it's hyperbolic but it really really looks
> > horrid to me) , I've never seen prefixes like that before in mm in my life and I
> > don't think it adds anything.
> >
> > I also find it MIGHTY confusing.
> >
> > Please remove this :) you can git log the relevant files to see the conventions
> > people use. Typically xxx: has something really short and sweet for the 'xxx'.
> >
> > I realise this is subjective, but it's a small thing and would be helpful for
> > parsing your series at a glance.
> >
> I need a prefix to group the patches, especially when the first patch
> is just a config change. "mseal" won't work because this patch isn't
> about core business logic of mseal.
>
> How about "mseal sysmap:"?

OK let's go with that as a compromise. This isn't a huge big deal.

>
> -Jeff
