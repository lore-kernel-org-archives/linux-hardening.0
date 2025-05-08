Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9838384;
	Thu,  8 May 2025 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727763; cv=fail; b=r44zlklUTfsMEeVkRhy9tAjr2VNIPp/AHbRxPAl2J1/3SVX4cJ9ajun+roJ6ldbXNzLFv6bOgIYIjR41VM3GtiKloIiDgxkOFlDTMsGo+2/oqCCQv34U+0orj/QDCQia1/dMXAWkC1ddKQ8wt7I7cOrKTjcCZLllvBFlqnedLlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727763; c=relaxed/simple;
	bh=qvd8dXIrhk15WeUGh5zb52ssotmEeMT1fo4aSZOdYsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nkd8+Zo6SpozmHoZFsVOpMvWPRJ6aQIG+Q4ku9A4pX+U6jv5k5lMqbpALpNqeWKp5pOQhqHfAMIYEI7BS8ouvWou/bY3OHIGest60czGjSxrt4JOmCY+5yVEED1dv83w2WnDVq2ZMmMxFwFHYZi5cx59Yzc70e4MkkipIZxwXMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JOBs4/Vi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fnFZlF1y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JOBs4/Vi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fnFZlF1y"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548H22CU005238;
	Thu, 8 May 2025 18:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Zt04qlFNPIui7SQgF685LqolVO0yMwBOFvkF6h5pa4Q=; b=
	JOBs4/VicUeEqNNQE7zpKgy2++D1tG45AJw9VvVTSifLgNuCm1Q6MLE32DJcWvql
	xKLbeSrF/PimmJClXb1GBW7JMXK8UMd013J07ZD+DGecgw+QFHNAp14fP9HOdPX9
	853IwdCKXpAbOC6id25NjIhYtPFsV2OCUCmKzruKgH+bMBpskSXefTt8kNd7jYZY
	Krt0anRAPFrdC9beyreT0y52fWkvvlh1nyvA3Xg7VXPy/BMpQso4zwPWkU7+6XIS
	Lrx60KSKSCe56pf87mdyNS0RxJjLA/jjt/rPmrwwhZN5yvOWwHATIW1P2zHuK8mh
	pEGhzqDwDzI+KIf2SzgvkQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46h0nc84fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 18:09:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548HpWrJ025122;
	Thu, 8 May 2025 18:09:06 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010002.outbound.protection.outlook.com [40.93.13.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kj8s1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 18:09:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCL1o/q8SVWRC0zgVDxQd6kOjzRAKellg6OA3DD+Y52YO/jjfigFuGvAz3hiUHRw0U5qw6tsl+hFQ2ogI1fYSPajy+IatQhoEgTIvI8ufmoHbcuEFIOm0jzbY4+E+gkMS86Dltc9HCHzJ1N9+f9LNUyO+TTV16ILkhCgEL9kjyKJ/+3ukUpVeiDhYz3NXrzagPEO9644LVnxM4VbP1XpK+PRi2gKvc+y/pv7/ijjAY5JrkigPFxOqnEZAlRlovtNpKVEcajCGWMrh+eK3wJnKG3OvvpEhN4Wt1LaYy4JDf1/ru9xvMklTkDK+QmGatICzu98uTvH3iqud/lsTT873A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt04qlFNPIui7SQgF685LqolVO0yMwBOFvkF6h5pa4Q=;
 b=JFCrRAzYzVLs7KBmdB25pLUoJGBgJLlzSlnlJSKc7zFMVH0jk6vp+uCiLve+AJ1oMtHmobPEB7H00mrv141gvfE0+Pq4toMP+iaS2sdRdbF5YLKTjvmyWJzoBXjmlLnupBYXxv0sVNQCYXnJyCkWUen6Bc53gdfyI9ftzLb1/maF3OwEjh+Bx2YD0V1hcyR/nQLaiXRWlw2XCkFcraOP9c4z/9F+3wEMbCzsFQ2u34iBIcZvpXY4tfbezZoTXxg1Ic4bACRjTeyAqA/tKvLP4sccSySURCKH9mMTuKdZ6ycyM+NmLQ/J4J2r5WKAdpLWJGA2TIbjcUmBqvWJXK4dEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt04qlFNPIui7SQgF685LqolVO0yMwBOFvkF6h5pa4Q=;
 b=fnFZlF1yIQ7Z5C6AVeV7sieH9hfjRNKpn8kxmH4QLg9t9yfupoaZkd/HIdF1LXa2qtlUVrOZE5xAJ+ZT7OKbOl1V+6iUKynvZxDVss+PGPdxIO6xe0DkwBkFv+4j5sc5ju02SHh/zQ4DWfjq5GbF49M+ikGKnHQAhiFcPok3S/w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7977.namprd10.prod.outlook.com (2603:10b6:8:1a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 18:09:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 18:09:00 +0000
Date: Thu, 8 May 2025 19:08:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: jeffxu@chromium.org, jszhang@kernel.org, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, kees@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv: enable mseal sysmap for RV64
Message-ID: <26e04390-058f-4174-ad6f-3f0afd803fb1@lucifer.local>
References: <5e7f2acd-2eef-4e69-9c11-ba8d1ec0bbc5@lucifer.local>
 <mhng-db41d38d-d3ec-4515-99f9-7368c82d46ca@palmer-ri-x1c9a>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-db41d38d-d3ec-4515-99f9-7368c82d46ca@palmer-ri-x1c9a>
X-ClientProxiedBy: LO4P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 806479ea-57df-43c4-2ff7-08dd8e5b684c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmtabitUS3pQL1BKeE85VURTN2xGUlQxL1UvbzlRWnRWMjJhU2NXaWVZckgz?=
 =?utf-8?B?RllweWJ6VnRXb01RZXhublN5UGRXOTJNWkVwUWw3aEt6cS9YTys3bDJnR1ha?=
 =?utf-8?B?WFUxaUlRSzF4MXdWS2ZLTkFtWkNPK0RZL20xN2MySnd1c0Z3WENwSHRUUS9z?=
 =?utf-8?B?WVB2elRmLzlmRlMrdlFTN1Z1dElXQzFEOVJKYTlid20ydVNRc3VIVUZFSEpM?=
 =?utf-8?B?bDBsdXhxQU5EdGJYRnF6QTBDS3U0N0tNOGZqN3lheStUQkh3MEN6dFZiSWtY?=
 =?utf-8?B?b1NTVlZGZTkrY1lnUXBWVUY3UUpnVlYyc2ovaTBJOUQ0S0o3WnY3c1IzQlJP?=
 =?utf-8?B?STNkeTFGSGV1djZEdTRhTzVDMTYxUGhpVzhQSTVCbmpoRmNiN0p5bUU5TExK?=
 =?utf-8?B?RDJiaE9oUkt3Yk00ZzQ5ZStta1VaeDJ4S25JK1BVbDZqWUhvZ1N1b0VOQ0sr?=
 =?utf-8?B?emZLVVBmdXBmSzJqUGg0YmRFQkdwL2s3eklWTGRWdmdmQmZrUDJwUVlMcGVr?=
 =?utf-8?B?bkVyYWNsSnFWZER0bDZhajFvdGFWWnNDNnhLbG5Sa2haT2VZd1NZZDg3WUNJ?=
 =?utf-8?B?MjZGQ29DTzNCYVpRbHVJYkwxTkZqeGNkUkVFNUZPamJnNnpyekUwQ1l5ZENw?=
 =?utf-8?B?aW1lRE91Nk0wLzJJeEM2c3Z1a3FmWk9mZ05YZzVFR1BjZXRPTk5XS3FFTUdJ?=
 =?utf-8?B?R0FidmVPQlJVRjB5ZmFIdEJYZWhuM0sxbFJ3QUVzRzNYM2VKM0ZjRnZTbU4r?=
 =?utf-8?B?MXNmQXVvQ3VJTmNvZ2ppc2NDd0t0U1lEWE9pckthWlRYSkJuSE44cTRhU1Ex?=
 =?utf-8?B?a1ZVaHAvNURmdW9LZzVmT0Y3d00vVDZWaHNPMEhqYkUrZzZRR2hkSFYrMnRi?=
 =?utf-8?B?eC9pSjFwSjBGRXVxSmp1Q1hRNjlLMzViSnE2Mm5LVSttRjhMbjRxTDNnL3FY?=
 =?utf-8?B?a0w3M0pOVW10aEIrakhPSmpXQ2kyNllDYkxMVnpoTzBhWGxPRGFvc0E1ZG1m?=
 =?utf-8?B?MWQyR1NQSjAzcXJkcTg3c3RNb2lNZTNQRzlmbThJMVRybU9BUDJ3WC9JZXVT?=
 =?utf-8?B?dzhFdkd3S2Q1R3duTG5hNnBRd3lLbFcydzZ3WWZGaHBZL2kwaDVuSk1yVjBt?=
 =?utf-8?B?ZlFxOFFGaHZSTE1pU04vUzRIVjEwLzE5Z0hHQXVCNjViQW1IblNuUi9pYlZQ?=
 =?utf-8?B?Y1VOY0tZeFNXTzRqZGw3M0RUNTRHaHBXMlVxbGs4OW1iV1hGcEtRWFhaeXZG?=
 =?utf-8?B?Tzd4QVA2bHR2SXZWVXExdWFKZXBDOFNDdjFMbU0zQi9RamVJOG4rUWM2dmtn?=
 =?utf-8?B?cEJ2d2lVMzdYN1lycEp5Nk5rTWg2RHU0U3U1M0xwbkgvTStKRndocHkxYWhF?=
 =?utf-8?B?WUw2RFJZM0F5QlcrdzkvYUdEdkRWMzVLMjhMR0FDNjNBQ2Rhc2ozNk5mMjZq?=
 =?utf-8?B?Um1HckdOT0c4TVFwOGE1bEliZFdsYjBuWkNVbWRwYWJkWDhkZDVaNWtOL3p3?=
 =?utf-8?B?aktUZFpUcHdNSXR3KzIxb2ExK25ZV2JQUTFmYzhvLzRCejJLQ2xJQTJHNSth?=
 =?utf-8?B?aVNWdzdPaHdLcEtiWjV3RFVjQWg1dDhJajcxeHZvcTZHWUZxa2tOMHQ4ZCtL?=
 =?utf-8?B?bFdvaUVJWXFEeHdNYlp5UTBsN1pxMDVDbDFIeHpQc29nVHpHazQyZldxM01t?=
 =?utf-8?B?K1FaaXBjMURLbm5HR1Y4dktTOXZVZG0yYkNIcUhFN2ZkQjh6NTBRZlgwWno2?=
 =?utf-8?B?dFJ0UUFKSzNXVlVlVUdQZzk4RjZBRWc4TTA1c2tsaTc2YWI4YnZTNG5qcHdZ?=
 =?utf-8?B?bE9kd0lUem9kUUtCL0J0WEY1dDdsV2VFL2l0MklYMjQ4eTdnNWJKYStsNUVJ?=
 =?utf-8?B?d213VWhKQTFRRzd1VGErRUg3ODZzTDBKS0Fudnk3ZjdlZTNCbXBvWW5QVUN5?=
 =?utf-8?Q?i4igrkS3QW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHFnUlYxTGltdy9wSnBtQnkwc2F2Snp5SXMwc0IrMDRENmU2VXJFR3dMWHpy?=
 =?utf-8?B?S1FIbEROMUJzNnEzOUY2NU1QMU91OUUyOUZFeFVUeGQrVVUrcC9NeTJqbGs1?=
 =?utf-8?B?b1pDQkp4eE04VWVvS1RtVEY3MHZGMzcwb1BycXNING5uZEEwYTFsQ2hvZTBP?=
 =?utf-8?B?ejRrNGRXWHdCeWkwSVpHU3hRS2s5RXNSN0wwSnZydTZCdUNkYUQ0cTJqYUZk?=
 =?utf-8?B?UHk0VXBuTlQ4RWNXYm91T2szN2Examx6aDRVcFVMaUo0TmVpRGpOMTVpcWYy?=
 =?utf-8?B?NGYwVDRVNE9LSmduVExEMk9wZkRtS1AvVDI5eEhEcFYzU3p0anNPZjhmN29Q?=
 =?utf-8?B?TERXcDJuOUhxOHAwNCtzUkNlNDVtRFAyTCs2MXF5V0V4OTdKa0ZtaVhjK3VW?=
 =?utf-8?B?c2hjYWpaN0JPNnFGa3l4Y1dKc0kxaXBHZ2FZVm8veG9JOERwdXVQS21ta0V1?=
 =?utf-8?B?Mk01dUt0dXZTRzlkcmREY09tOUd0T1Ezbml5S1FIYjd4ZE5ZT3BHMXNVMDJn?=
 =?utf-8?B?aE5VVEhnd0Mwcm9VdUg2b09NN1ZXcFF5eUVUa0d4U1NYT0k2M2Z5S2I2UDc5?=
 =?utf-8?B?eDRMcncwVUsraWI2NVFpeGlkN0M5OUxaY0FCR3BTRTZuUmJHV0VRSGZ5WXpp?=
 =?utf-8?B?Qk5rVnBPYkZqTXZGbDZUMUtTcS9EbitzNXlRRHFNU2M0SHhONkxvRktZN2h1?=
 =?utf-8?B?cG5kaUdNeSt5TXlkS3kwa2xTNE1jSlg4VDMrZE1sUUpWRzV1YXcrdE5pRVhv?=
 =?utf-8?B?VmZOb1B5RWlWamZENHlxV3ZPKy9EM1pOc3JHOGFnM3NFbXJqdFBNazdBUEgz?=
 =?utf-8?B?ekNUVnBtYjRRdFdQRDE5TGw1ZWZRQ0dlZzBrb1c4cDhmN1FLTE4vd25XdFRk?=
 =?utf-8?B?YmpYcHlYeC9KMVFHVmhJNWV6UGsyZFFUUVRzUjhtcTV0VWU1UWpXVHhYS0JY?=
 =?utf-8?B?UExocGJPOFFmTUl4czdNSkhnU3p6cEp0OXorS2IzdG04UHB4T2g3aGRRRXhQ?=
 =?utf-8?B?UkoweVdCd2xhQ3A3SU0zbGE2bERJeHFwS0NmKzlSYmpJMjlubGdpUTVNblJm?=
 =?utf-8?B?YWRJaUM3QklUd0dQWnZnT080ZEhNeE5hVFpqZXBVMEQ2YUxscEZvUXczdnk3?=
 =?utf-8?B?QmZ5TmV2ZUhrRHRNZHVmZDJ6LzFicDZ5UGo4aVRtaVA5V1VUZnFUQVlPYjB6?=
 =?utf-8?B?LytUd21IdjF1dkJpTkdnSU1WQmY4NlN0QTFGbytBbmdVcFpSWTJEYmJzVWlF?=
 =?utf-8?B?YjBPdnB3cEJ6UnJaajhxQXFaaGd4a3IyRFlzSVBSTWJSOXdVK1JjWnpIQk1C?=
 =?utf-8?B?bTVabVF4Z3luSTErQW1vYU8vRWlUdS9ESzlUQTlBdHJiaFV5YXY4WHhTYXJw?=
 =?utf-8?B?L3ZaNzR6aFdEZHd0VkFGMUYzOStYVjFYZEN0UjJsREw4RnErMThiTlYrZTMy?=
 =?utf-8?B?RDRONXF5TC9RZFpOTFJJNHhTQmdZc0dlSU1lM0Q3WGFCL2FEYm9wZWFVeHJE?=
 =?utf-8?B?OEZLbG5hc1EyRWxUOXVqbWNBdFNVQ3BYeGdwNHU2dnNSZGc1cW9rbFVJNkkw?=
 =?utf-8?B?dUdoMFQ1NUZRMTJCWEwxRUdsYzJ4Njl4bjVNTU5Ndk05Tk50eTJtQ0RkcUEy?=
 =?utf-8?B?L0VhcXJZall6U01ONGEvTzFIREZIajZrN244WHc2bXEyckNjN2pxbjJiZVMz?=
 =?utf-8?B?ZzkwaEU5UlBYcDJYeEF1eENBU3doejY1dGRZWE5qR1Z0aWFFciszTmNNLzlQ?=
 =?utf-8?B?VEFwa3NqL0FTVnYzYXdnT2JMNGtyRzk5QXZUTndrZ2VxZ0tnaTEyTnNCOXIw?=
 =?utf-8?B?OTZ3YWIyN1E3cEJzMzNOb1JLRGhrOHJDWWsxS0dBOWFkMWREL3VvaVEzWXFL?=
 =?utf-8?B?YThxUXMva0RjMC9qV1oreDBYZDZySkx2QTVjTmV6YVpZV1BWazlkc3pKNUsx?=
 =?utf-8?B?OXBpREpEYit1OEhlcm4zUnZhK3MxVXMwNmJndkpLR0d0bmtoMTN0dVNlSllM?=
 =?utf-8?B?ZGtZak5qNy9QUXc0WXNxc1hsSGVkczJ6OVZqZStGR2JpOVozRWQ0NGtyZVdo?=
 =?utf-8?B?NVNHYVd1dTA0MC9GdVIzR1p1bWxIQUtwYXVFaFFuT3hadDIyNGVJRmxycU5j?=
 =?utf-8?B?R2diQ2VsdWZuZGxkVGRZMERpMFYwdGErSEZ6d3lmbUYzOWdqKzI3U3NKN2V4?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	08e53EpblpJ7+r2JbJLpMZOocRzfEN0pSOOeKjhcLzYIBVauwyryovitYKUN6DCh1yYcDxEKTpSfhakWkAD7GKe4CU6MHz6WVxJa2nMxfg7oTqDfGxb62Bop87Tsq94LVIhayuiEY/liFqAvIFdMHdgrOOquNANR6XKJsV1Jpfar61N8vdj4JFsheEhnvXLaTXrdsT9A/Nu3rBFHYN6OS//jH/h00ixhN56QjpN1bNApv1ZxRkotYobderwKzbKzh3IdGe5Up0ZYoOvd2nLUcytb6Ort4VuNePdqnBx5IF8/RDp8Z2nrOzvBbsXVzUN0P1hs5NJnZjftlhJbxo4n+9mUASFi0tiialPLI1WlS9l0G1TrgoL3VzIdDWJS+24WnAULHp/yAsHJuOoFOlQF9Rl3DHClIu1YIrKHH/pk/5/X5Wk/s3Qp9vTIemxm5XVpPNVXkl+XZOEqj6RVzHpIvM9Qc4CfKA3OyRTJXXEMrSn7zwHBEYHU9n55UrvMIrZivQszsuYbasW1ZwubFuLw7URgPLyQ7jcSSBPhxLspcTcn0/zGcBxwSYnoJ10TxEyL6WgXho420Y6V+YfVIb8FKFncyAsc7tKOM54QbRCbrWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806479ea-57df-43c4-2ff7-08dd8e5b684c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 18:09:00.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJsAHBAiyPwq1GTVif26qEBidbpoc1Dl9RYGHcx0Ip1lUjeCSqcaORFSgvYWI+ViLS+JpPgWcbh326Pe3AyEwsyVumTLkjVnQpyTYCme41I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505080161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE2MSBTYWx0ZWRfX2ksNkl2bDU37 L8i6+mgNB566mDSQz8K+AtnG/mFlxTgE5FuvLkTDOCbB2r+VSeHJEOP91iXYqR+jblP7vXOBYBR IwqTMk2jyZjZpL9cofKgks60IcJHcJ6sddFtvEkxW2CLULsTb/Ok7H9nHm6lKPb5z6+0iQYEyFP
 grYH5rKNe/AfMGJgtyTR3N0fvlEWjsUS6I64gr7LRUMy3ZcbUb5snV+EeLy3klnATGzka+Tyhpg xbJq5XtvW3srz9snzTU6eO10P6voUbG+EBIdKhidEMv946D7yOR+l47YE7v04AiQsNk8eJLKNQx aJUWaeunm+UCAjAQB/Lqll5tZZjqcgykx127wwHHQ7y+8GCIe9HP4gd49BxPI16dtzuj0abk9x4
 +Sf4YrqUM9EwM9B1N1ZewYe4bXH7q9V40RbyZLb8pCofpxzn3PwtU2GlEmGujykC7FR7Fc1b
X-Authority-Analysis: v=2.4 cv=UPvdHDfy c=1 sm=1 tr=0 ts=681cf343 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=iHwBjlyiAAAA:8 a=yPCof4ZbAAAA:8 a=cm27Pg_UAAAA:8 a=FF7RMkhVkAU5Bw5vpBwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uNSKXYNwxGiU6LD0JREI:22 cc=ntf
 awl=host:13185
X-Proofpoint-ORIG-GUID: Zjrapqca3hyWvqO-sshNyHU4fPL5AYcQ
X-Proofpoint-GUID: Zjrapqca3hyWvqO-sshNyHU4fPL5AYcQ

On Thu, May 08, 2025 at 10:39:35AM -0700, Palmer Dabbelt wrote:
> On Wed, 07 May 2025 09:22:09 PDT (-0700), lorenzo.stoakes@oracle.com wrote:
> > On Wed, May 07, 2025 at 09:18:31AM -0700, Jeff Xu wrote:
> > > Hi Jisheng
> > >
> > > It seems mm maintainers might prefer arch change reviewed by arch
> > > maintainer and goes to arch tree, according to discussion in [1], I
> > > don't have an opinion on this,  adding mm maintainers as FYI.
> >
> > Thanks Jeff, appreciate the ping!
> >
> > Jisheng - the main point here is to ensure that the arch doesn't rely in any way
> > on, within the arch code itself, relocating any of these mappings. It's pretty
> > easy to eyeball it and get a sense.
> >
> > Because if this is the case, the arch will be broken by this change should a
> > user enable it, and obviously we'd rather avoid that! :)
> >
> > It's really likely that you're fine, as it'd be unusual for an arch to do this,
> > but I strongly suggest you do so.
> >
> > And yes, I think these should really go through arch trees as explicitly arch
> > code.
> >
> > Thanks, Lorenzo
> >
> > >
> > > On Sat, Apr 26, 2025 at 7:16 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > >
> > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS for RV64, covering the
> > > > vdso, vvar.
> > > >
> > > > Passed sysmap_is_sealed and mseal_test self tests.
> > > > Passed booting a buildroot rootfs image and a cli debian rootfs image.
> > > >
> > > mm maintainers like to get confirmation that the arch doesn't rely on
> > > remapping the VDSO, VVAR, or any other special mappings, see
> > > discussion in [2]
>
> Do you have some description of what remapping is disallowed here?  There's
> not a ton in that referenced thread.

Any remapping of these special VMAs that would be disallowed by mseal that is
being performed by kernel code.

>
> We play a few tricks with remapping, including some aliasing to handle
> different VA widths and text patching (via poke pages).  IIRC those are
> similar in spirit to what's going on in x86/arm64 land, though sometimes the
> exact flavor of the trick matters.  If you've got something I can look at it
> might save me from having to read though the mm code...

To risk sounding grumpy, and it's not your fault of course, but... this is
the... fifth? Architecture where somebody's enabled this without seeming to
understand what the feature does, and I'm a bit tired of it. And every time it's
been _me_ who goes to check :)

Anyway, I guess let me go check again.

So it looks fine to me - the initial mapping to mm->context.vdso done by
__setup_additional_pages() in arch/riscv/kernel/vdso.c appears to be final,
except when vdso_mremap() is invoked, but that's when _userland_ does it,
which this feature strictly disables, but that's fine.

Note that the patch simply indicates that the architecture _supports_ this
feature, the feature itself is disabled by default as it breaks a bunch of
userland, which is why I insisted on it being put behind a config flag for
users who really know what they're doing.

So perhaps I can link to this again in future, what I'm talking about is:

- Any instance of the architecture code, NOT at the behest of userland
  (which we expect the sealing to break), but for its OWN purposes, for
  whatever reason, moving the VDSO, VVAR or other special mapping around in
  virtual memory.

- So you'd really need to be doing something _weird_ for this to be the
  case. It's unlikely but until each architecture is checked we are being
  conservative - so as not to break the kernel (!) - and disabling
  architectures until we know they're safe.

- Sending a patch setting ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS is _very
  explicitly_ stating that you have checked and are certain there are _no
  problems_ with the architecture doing this.

So this is why it's quite annoying to have people enable this with a commit
message like 'enable mseal system mappings' rather than 'I have carefully
checked the architecture code and the architecture does not manipulate the
VDSO, VVAR or special mappings after establishing them, I have also tested
the feature in practice'.

I feel like anybody setting 'ARCH_SUPPORTS_xxx' should - you know - have
determined that the architecture supports xxx. But maybe that's
unreasonable...

>
> and ya, we'll pick it up through the arch tree once one of us can be
> convinced this works ;)
>

Thanks! :) Your skepticism is appropriate. But I do think this will be fine
for risc v.

I'd ideally like to hear from somebody who's checked this on a risc v
system with CONFIG_MSEAL_SYSTEM_MAPPINGS enabled just to be doubly sure.

Thanks, Lorenzo

> > >
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > Cc: Jeff Xu <jeffxu@chromium.org>
> > > > ---
> > > >  arch/riscv/Kconfig       | 1 +
> > > >  arch/riscv/kernel/vdso.c | 2 +-
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > Please consider updating document as part of your patch:
> > > features/core/mseal_sys_mappings/arch-support.txt
> > > Documentation/userspace-api/mseal.rst
> > >
> > > Sample change in [3]
> > >
> > > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index bbec87b79309..3cb0b05eef62 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -70,6 +70,7 @@ config RISCV
> > > >         # LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
> > > >         select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
> > > >         select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
> > > > +       select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
> > > The "if 64BIT && MMU" are not needed here.
> > >
> > > MMU is not checked by MSEAL_SYSTEM_MAPPINGS, which we should,  this
> > > can go to security/Kconfig separately. If you'd like, please submit a
> > > fix to mm tree directly.
> > >
> > > [1] https://lore.kernel.org/all/7EB087B72C4FBDD3+20250417132410.404043-1-wangyuli@uniontech.com/,
> > > [2] https://lore.kernel.org/all/3de559d6-be19-44bc-ba8f-4c52d4bca684@lucifer.local/
> > > [3] https://lore.kernel.org/all/648AB3031B5618C0+20250415153903.570662-1-wangyuli@uniontech.com/
> > >
> > > Thanks
> > > -Jeff
> > >
> > > >         select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
> > > >         select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
> > > >         select ARCH_SUPPORTS_RT
> > > > diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> > > > index cc2895d1fbc2..3a8e038b10a2 100644
> > > > --- a/arch/riscv/kernel/vdso.c
> > > > +++ b/arch/riscv/kernel/vdso.c
> > > > @@ -136,7 +136,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
> > > >
> > > >         ret =
> > > >            _install_special_mapping(mm, vdso_base, vdso_text_len,
> > > > -               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
> > > > +               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC | VM_SEALED_SYSMAP),
> > > >                 vdso_info->cm);
> > > >
> > > >         if (IS_ERR(ret))
> > > > --
> > > > 2.47.2
> > > >
