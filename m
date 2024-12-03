Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73B18DF81;
	Tue,  3 Dec 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257068; cv=fail; b=GJkspiV5MMijAI6dJdO83LPExq3Z0QQy3eAGFOTe22qOds9MkoslqSxjP59z6B6/vxiuvpGscjBb5UTfk09etSVI8yvObMYKnJ/5p/Wk/HyN9FC6q65NTDs2tHL4JF9aKW2iLL6fi2WIMK+OCc8e1hKuCb6z6AzPv02kQN80zv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257068; c=relaxed/simple;
	bh=KxJhXRNwzozEcmQXE0uVcIUXHFANgh36RnqIUUoTN44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=McZ1trCv7p/DUhdiFDNjRe9xU4+XFqktl8fyX1JaTgXs3u08sxKsHt2EdjqnNJB26ej/CpnWX1oQE9sAZGoGGfCUCFx9kE81xbElDqMcXfqW1AIzfrnCCd2SPT5qiaOPRxA5CR+Ku0sau3RoTh9BgQb0YRgbZwbdP4f6/x0GTHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WTMcxxCc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JZXeHix5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WTMcxxCc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JZXeHix5"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3KBsd3019842;
	Tue, 3 Dec 2024 20:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BceiXg3Qtn2i7DNpD0MCz2etIzIDWRo/odRBTY1HJM8=; b=
	WTMcxxCc8evuNWYByjJsTl86r5nrWpICAlmayM4jdQtEpKB8HrEb5pR2vmval8b6
	f4CR7AZlXi1VMFikXmenlZHdUybwNqV0wGX95fam/dgbaOudRf73T2GBv0CqnqUa
	svvz8jRkYe3RMK3VoVVoPYnj7gbzPNXxn6MD1tWW5VH1S31NofDXw/N+t4BsC62D
	3vpzaOgI891+qnpmRaCqXCF8U2YCl7aGZVqGfEtt264Yfkutw6MhNSbNCWcDBoTf
	nDQuYJ/6djeSRpKr2lfoF7KaFeO3E6NalEWq7pU2DHzpPdSQ3ysKS2h4HYyRqyq/
	t+B+TdkvXTJGN75FYD2Gvw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk8xsax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 20:16:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3J16XI037938;
	Tue, 3 Dec 2024 20:16:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s58vynn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 20:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxEM1VePh67p9lucPmB/s/Q6TUVQOI6OQEzKCO/VLooVJ1F+gS3EWVUAZkbd5YuUxh3cQmHpdzfA44ffEUvR6RI5+D05xsjXwdO91CeHaMjdBSgnHGYivolZVvTKvxGVEEJKyh154XKRRKmicbfsAjs75ZBgtBrg7ePqSHmE0dt6gMMXZf4Eu/TpWgBv89aLOJRwj/RnnZb2GPmtlaNweHlh/v2aZTonbfRLjr/tUIERyTu04ALH3csM+HLMeTZ4rFyaOHxz4gHm6wnTXN7AmdBjqglknRDGb9xyyNo4hhlzjND2FigMWMydrKzmWlGWiIQec4p/FZdjL2CVFNo7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BceiXg3Qtn2i7DNpD0MCz2etIzIDWRo/odRBTY1HJM8=;
 b=mqKjezj1dXpVss4Ug684pCak6cY1FM84OCHb4YYfv5vWXCPoNDR49znbymxVF++B6Ls0hGpSRWHjcX1/1oZAHeClwLLBAu+7eEN+msvlWXEm7xV0PmlyG9NhuUKJb28iRQ/Dqw1kY7xqaCLEwMisfWsDb+/c2tBSaybnCCVr0PQzmsVOXvGDHf6V5bT6tK5PCHcRTwPEQa6700jN0SV8G/lY6A2W/3ilLVZW3Bo2zxyRA4m7dcL6jaucu4Cc+J+wm82oLXPGXlantZ+cLYaD18N61/O5hbuRJD8uNAN202ug+On4zAKUQJ2PzHJQo/oAJUQ6w53raJv/UrD9p+WMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BceiXg3Qtn2i7DNpD0MCz2etIzIDWRo/odRBTY1HJM8=;
 b=JZXeHix5uW6kCI0Bs2iwHX2Dwx/oOnX48T8zeyyzSIMGCkzdHA/AFHnX/HwHyMdFeIOvTq7mwXVWyb9Hvv+YYIwEHni95S1JsJ6FxNxIN1KoBBgB4UO7DbHrSSEOAd8BXLFZhrrEAAHwENSIGBJikraQNr0HginlUhTpx4tS99w=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 20:16:46 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:16:45 +0000
Date: Tue, 3 Dec 2024 20:16:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
        mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
        deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <4e7088eb-b017-4d8b-8e0f-5cb409b112cb@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <ce2bd3dc-e7aa-41b4-9d57-2cc683b5659f@lucifer.local>
 <CABi2SkUFCqy0pWfrOcfC0a0GMVpFODtb=Hunw6WW1D5N-A_MXw@mail.gmail.com>
 <0f22048c-e24f-4539-8af2-63879971f6e1@lucifer.local>
 <CABi2SkW-AmkqooXDDFDTWV3FGJufqXJ19f03uEUSFbkZoQgV8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkW-AmkqooXDDFDTWV3FGJufqXJ19f03uEUSFbkZoQgV8A@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0625.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec1c1f4-5eee-4920-0695-08dd13d768ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHVmakZCcWdaaG40M0xTRGd5ejNIVVFHSEdhbVQ3Njg5dVc5MHZKVFNxOWht?=
 =?utf-8?B?NkVvRW9wbFVKTC95eDJ4RG5menpwV2o0Y1lXYTZ1U2JNVFlvQU94Tjg3am4x?=
 =?utf-8?B?Yis5bnR6dnpaMkJEaC9TN01tSHdSdjhoMU1UekVHc0dBMmJDQm9qa3JwVjV6?=
 =?utf-8?B?bjBGUVR1MG93SGpabWQveEN4V3NQSVVQbkxobkxJNmYxdXM2ZlE2aEV4WmtE?=
 =?utf-8?B?eUhqakhsM2d4eEFsQWdoc0dPZmE5RTd0YTB6Y2x6bWJ3OVdJdzFqU0tUYVRQ?=
 =?utf-8?B?ak9VZnFRWXRQc3pwd1p2VUJ1cU5sdlpLcm05ZG95Qm5yM2N2Y2E2elgxdDVU?=
 =?utf-8?B?dEE1SVVsY243TjkrQ3RpN2lHNWRVWVFNTVhiVVlqNlZwTExzSXFoMy9FOHVh?=
 =?utf-8?B?VzQxN1FjaGhyV0psazNiVlBIdmhWQTBVK3NaZDZoL3ZNTWNVM0hTWE91QmlO?=
 =?utf-8?B?YlM0TWpGVUwycmU2ZUNxeHhWZjhJeHhMTUxrR0kwV2VJOVdTckxIUjM0UVlC?=
 =?utf-8?B?dUNyVDlLdWVoYkZ3bStJd25JdjRzTjFZeERWNXhpVE82cE1Na0dCTFNsVW1E?=
 =?utf-8?B?eUZCNVREL2htVm9nMHkrWEdVL1NlR3poTi9lcmpvcUNlaUVlNkppSVA2MlI4?=
 =?utf-8?B?Uko0RmlOS0I0QU1oNkpOd0o1YktYYzA2cnhnRlRFQ2RlcjJjaGVYMGxJQ2Vs?=
 =?utf-8?B?M2FyUG5EaW9DQUdBN2c2ZGVuM0JaaHc1V0dKVnZQWDFuTktPeHMvVmFoc2ZI?=
 =?utf-8?B?MVdzMzZyanlEZ0luTHJJZ1Yyd1p2QTR1aXI1MXRzbCtXYUE2a0RTSmdNQ2My?=
 =?utf-8?B?UVFFalVucjh3UjVDbi9NdkpKOUdBYmJoTzJwNEVZZ3VtRThzR0FDZVVyRGY2?=
 =?utf-8?B?TGNMakt2ZkZCcjVsMDNNZkxLbzJDOWJMWHJGNW0vd1JiamFDaXkvTHIzR3FW?=
 =?utf-8?B?SWExUG9FNDMxOGYrUDNBbEV4dkV2SU90d1FKeExQZFArenJSbm90T29IL20r?=
 =?utf-8?B?NlpLRlNkdFhGdGFwaXMwMEhiMTl6STF1aktMdktrQkZTcFhmRm05aDBXU1FC?=
 =?utf-8?B?M20raTRqaDhQRVM0dVVJblhOL2tlN3Q5cXVxcjhoVHY2Nk11MFAvL1dqQTJi?=
 =?utf-8?B?MHE3d3hUaDZrWVJCSDR2ZGVLbGxteUlBU0hwVFNESUkwSkJtY2JzOVVQRlNx?=
 =?utf-8?B?MkUxWFoyVm1IRFhSM2dGQWxiZU55RWVka2lzK1VXNlZ6RnU0dHNzM21uR2tN?=
 =?utf-8?B?RmVJL2tmYy9vRG1HNWVUMlFRMUJSNjVsaE1CUzNRVEVzcVVOaG44dWhGVlhB?=
 =?utf-8?B?RXFiWkRpUGd5aC9pSWV6RWV5TzN2SUFXREE2eGhOWnJGeHJYeEd4WUY2NTNr?=
 =?utf-8?B?b24vNGI3KzZuZG1FZUV1RUxKK2Jjc0tiekVNN0ViRnZva0Izd1BtK1gvTEZ6?=
 =?utf-8?B?dXFpSzJ1S29DbmN3d1ZaWTN1T1ptejQvWXZIZEtRZGJRdEZjZWRwaTEwY2Vv?=
 =?utf-8?B?aUw3RUJhMEt3YVA0cmpzU2NoYmh5TW05NUl0NjFQSVFTNjB3VFdHYXdWeEkv?=
 =?utf-8?B?TXhzY3JqZVVUOENGTVlEeXNUc3QyczVoSnYyeE4raVNCQ1doN3RhMFJlSHB6?=
 =?utf-8?B?RnNlN1l1YURTSlVNNkpjL0FWMTVySjJJVXUwMUh3RElldEg3MUgzblcydWRz?=
 =?utf-8?B?MWpQcS9OUVYxVmhxVHJHZ0s3TCtzb056VjJVUXZCSDVqMzZpYVRLcFlwSHRN?=
 =?utf-8?B?aHUrclBRRitBS1RHR3ZFNmJDZFRtRVh3K1J1bER3dFg2UCttaWYrOG5wZzBr?=
 =?utf-8?Q?bnJjqS4p22r6L8tl2PzDed7AkAgU+oV1Zd9R4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmJuZ1RsWXdrc1QraFlSNCtCVmxkYnY5SkNPUUZuTjkvTnVpTThETHFNck1P?=
 =?utf-8?B?VkdDUno3eDBFSmREUmpQd3dWUGhudDdzZjRlbWFHbUpLa3k1K0NseTNyeGI3?=
 =?utf-8?B?YkZnZnlyTFRHNXl4Ulc5eVRaNGlPRlRvVUcxanBQMzNxYzBSSnpBcEg0R093?=
 =?utf-8?B?RUJlcDU4S25CRFRCeS9lY2t5cG5UeGtjeVcvdWcxaHRvUGdnUDlpMEtwdU4y?=
 =?utf-8?B?S05iNmVRdjFva2NFUGIxeExkZkpKcVgxV0VJeGxVc2ViRW5VYjhZZGZ5S3Qr?=
 =?utf-8?B?MzNCY1ZSclBSakZkSG42L2kyOW5XS0dTcWl3OXgrZmdMTWx2Qi9IbDNSVXU5?=
 =?utf-8?B?S3ZyMzRYSG5hL3QrdmR4WFJ3QzdFZENXN3prbmVRWm81ZzN3bXpheFNIQ25K?=
 =?utf-8?B?L1BKSlFWcUIzWUdGZEVMWHplRXkySlRmR0hDZzVvNE51UEVtRkROdVAwWFRu?=
 =?utf-8?B?SGprbFBFU09KM3NhQmVZU043NkVvUEw5YmQ2VitQSXVDZzcrdE9zNDk4WVZa?=
 =?utf-8?B?YmVwV05malp4T0Z5SFlIQWg5SnZYcWN6Qm8rcTZDRXhoN2hBNW9FRFdBYnlB?=
 =?utf-8?B?Nm9aOGpNRWxQQ0pkUXN5NUxyajBDRXM0emxsZDRiTnpXZ0RRbUZKQWMwZFlC?=
 =?utf-8?B?QjNRbWQvb0w0NXlPNWJWRHRHL2RSNGp5ekVvdExtamFzTkpnc2hUSTYvbFgw?=
 =?utf-8?B?YTZ4a3dIYllLN0x0VnhuQzVUQmZxdmxNRTJGYmFLRU1BQzhtQk5xeFFWM1FY?=
 =?utf-8?B?WjUwOGxjMFNRRzFBbXdHNVNMYkJod0VRSlZvb0kvUU1ZRlhuTU83VDRkblN1?=
 =?utf-8?B?Qys4eHZ5ZE91OEUvc3RTQjBzcmZNendwRjl1MUdCYTJydEpwcUJUalNRMkRI?=
 =?utf-8?B?L0l6ZFpFdEtkSnFFS2E4cG5pS1Z3dExteWd1WkwzcXE2WEhXWlNQbHptNzQ5?=
 =?utf-8?B?YmtpU25EWjB1TEszMGNpZm5TY09zb1c2YVZhTUkxMysyTWl5Sno5WjIxSTFS?=
 =?utf-8?B?aU4zVERtNjM1ZVVzNHBHQmpkVEdEYnlucWttbkdlcDJMUlhzVXBXcE5WL2VI?=
 =?utf-8?B?Y1U1cEVWV2lVNU0vSmZUSGt0ZkNRY0hXZTZ3QjR5YnFVbjBXbXdBdWtWWXFS?=
 =?utf-8?B?TUVXVVVOb09aeE9rYjVsZnQ2dlJNSlZTcVNqZFhrdFFFcCtIdlNnWDBIOXl0?=
 =?utf-8?B?c2xiLytQLzhOOEVOMldUUzJ3amUvdThtUW5XZE42RjR0RzZMMDNLNGlvaWVz?=
 =?utf-8?B?UWVpSDJzbGxRcTk1ZXBMOUljWmdnUkcxUi85VWsyNnhrNVpZVFFkcTNZcG9W?=
 =?utf-8?B?ZGRBN3NXSGd3ODlGekczcXVVNGNWSXRsZ2hkN2EyeUZTU3M2dGN2ZlQvTUl4?=
 =?utf-8?B?VHNJWkZMREN5RCtmTkVHTXQ3dnczaElxYkV1YTlqZ3BEa1lldzJuZ2Q3b0lZ?=
 =?utf-8?B?K1A3NThEYjdmcURLdXhmRkxwS2Q3RVdNUE55VFN3STkwa3BUTXpTaTJRUFdE?=
 =?utf-8?B?MjFhdGIzRzFSU0VrNXBUTEMvV3k0T3lkclN6NHZ5czRZdS9CS2pDSWp1Q0F1?=
 =?utf-8?B?K3BCYSt6MnM0RnlvQ1FJTzdjOWFBai91MHFBVzl4Y2gzWkE0a285bjVuTXdJ?=
 =?utf-8?B?elVxdWd2TVpYWlk5eTlhb2FVRlZIcFo1OTVPeENqRXMzd1UyZS8rUmJtbSth?=
 =?utf-8?B?TTdXOTJjUU5uNzRzdHRKYnZuT0ZQYzhtaFNOS3c1TDVJNXlOSTBDZWNacFg4?=
 =?utf-8?B?T2d1ZThwVlN2Z2E4R3FzSVlkeVZPdCtBbC9ESjR6RFFyL2dFSDB3SnNTOGFp?=
 =?utf-8?B?WU1pV2prK2FXaXA3Q0FSVk5UK2x0ai95ckduTDJ1NTNLYXVXT3BXMVRyR0N2?=
 =?utf-8?B?NlhCcHhtVnRpb3F2TjRDY1QxdC9haElpWHFMWGxCZzdPWldQR3BUa2x5YktZ?=
 =?utf-8?B?cnlidmhqcERhcXBEck5jRFo2MXcyejJsclhWM083ejEwdXZEYXJ6THczYWha?=
 =?utf-8?B?cDJpTzJRVWtybW4wVURPUy93M2ZJMnVjamZFY0JCaEVOYUxzK0QzOHUwb011?=
 =?utf-8?B?YXdrQ1hFWXFGanZ6K2MxZEdFelltMHdLRW5pUFZxYytTUk9XQU9kSWxQUkhy?=
 =?utf-8?B?ZnpVSFpyd0dsVGRVUlpreitsS0JXaHFKcXh3dFk3ZWhYZ1pyeU9LaWRxZEx3?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VuJ9BVjE4mjtFWiHvAdjN8QTVp+RHXJWAItXCKpMt7qH8M0e+/oefrYrfxId8/M0W/h2zQvW7HEHsoRIefyhxvAagmVCMU3pxvVnpX7pyG4o9qRXC1uIKewlJvXITjO4sij5JhHVMqVeNPURYr6FDsBk7fVE2t+Q2g6osJlpzwv/Ojb8HGt3j9uPIdOOcYiFXi3O+rpsFSULb96+dnQdE2arkrt4P6tn7ZI+1JVR+lFFemV912OxqC/uA5w/QWT21/C3vJYnqfWMGjR4Qliy7nGS/F5vgJUx3nPKu11Hlnwu1JiubDKM+zKmhcvspknjwTNzGlhcsgPnN8jI/KS6Ntv8Wfm2WMC5la7M/F7hXuHEOnC4MLkbFAdEqMxc59Ty0r/VcvCdckuNyBZV2RCCtTMMEEIzIRzWbWhp04FZwqdDD08x/cABiSYVgNNCDeqjxdYSeMl8y3nBs5ikTQotqi3eyPgAASx9K9Nky69i76Gae9HU+95vfh8c2vVBDyD5FPU9J0Yfc1kZpkb9SuNbGi0+pm7P1wNlN5IK2ND7z260zxfd6HspOa6tWsyYP0gXEdUJjeNmlniJ0LyK/QRwfPmviJERReG7+PLuXB+NB8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec1c1f4-5eee-4920-0695-08dd13d768ec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:16:45.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPeLBUJ6Fd9MCftU3clHgFcP+SUxgCYcHQ4R9bahRfGhYTpc8njWNrBX4hNoehOEXqajR+FEN2KUXFVRFG87Z9OJFChONPcYSwiAKKgmvy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_08,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030166
X-Proofpoint-ORIG-GUID: FcYv-RmWUKHAM40nL37lXie9lbGDaXRE
X-Proofpoint-GUID: FcYv-RmWUKHAM40nL37lXie9lbGDaXRE

NACK.

Unfortunately past experience indicates that engaging in a back-and-forth
is not productive.

Please re-read what I've said and properly address the very serious
concerns raised.

This series is unacceptable in its current form as it allows untested
architectures and known broken configurations to enable this feature.

On Tue, Dec 03, 2024 at 10:19:31AM -0800, Jeff Xu wrote:
> On Mon, Dec 2, 2024 at 11:35 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Dec 02, 2024 at 12:38:27PM -0800, Jeff Xu wrote:
> > > On Mon, Dec 2, 2024 at 10:29 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > >
> > > > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > > > >
> > > > > Those mappings are readonly or executable only, sealing can protect
> > > > > them from ever changing or unmapped during the life time of the process.
> > > > > For complete descriptions of memory sealing, please see mseal.rst [1].
> > > > >
> > > > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > > > generated by the kernel during program initialization, and are
> > > > > sealed after creation.
> > > > >
> > > > > Unlike the aforementioned mappings, the uprobe mapping is not
> > > > > established during program startup. However, its lifetime is the same
> > > > > as the process's lifetime [2]. It is sealed from creation.
> > > > >
> > > > > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > > > > _install_special_mapping() function. As no other mappings utilize this
> > > > > function, it is logical to incorporate sealing logic within
> > > > > _install_special_mapping(). This approach avoids the necessity of
> > > > > modifying code across various architecture-specific implementations.
> > > > >
> > > > > The vsyscall mapping, which has its own initialization function, is
> > > > > sealed in the XONLY case, it seems to be the most common and secure
> > > > > case of using vsyscall.
> > > > >
> > > > > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > > > > alter the mapping of vdso, vvar, and sigpage during restore
> > > > > operations. Consequently, this feature cannot be universally enabled
> > > > > across all systems.
> > > > >
> > > > > Currently, memory sealing is only functional in a 64-bit kernel
> > > > > configuration.
> > > > >
> > > > > To enable this feature, the architecture needs to be tested to
> > > > > confirm that it doesn't unmap/remap system mappings during the
> > > > > the life time of the process. After the architecture enables
> > > > > ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> > > > > CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> > > > > Alternatively, kernel command line (exec.seal_system_mappings)
> > > > > enables this feature also.
> > > > >
> > > > > This feature is tested using ChromeOS and Android on X86_64 and ARM64,
> > > > > therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
> > > > > Other architectures can enable this after testing. No specific hardware
> > > > > features from the CPU are needed.
> > > > >
> > > > > This feature's security enhancements will benefit ChromeOS, Android,
> > > > > and other secure-by-default systems.
> > > > >
> > > > > [1] Documentation/userspace-api/mseal.rst
> > > > > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/
> > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > > ---
> > > > >  .../admin-guide/kernel-parameters.txt         | 11 ++++++
> > > > >  Documentation/userspace-api/mseal.rst         |  4 ++
> > > > >  arch/arm64/Kconfig                            |  1 +
> > > > >  arch/x86/Kconfig                              |  1 +
> > > > >  arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
> > > > >  include/linux/mm.h                            | 12 ++++++
> > > > >  init/Kconfig                                  | 25 ++++++++++++
> > > > >  mm/mmap.c                                     | 10 +++++
> > > > >  mm/mseal.c                                    | 39 +++++++++++++++++++
> > > > >  security/Kconfig                              | 24 ++++++++++++
> > > > >  10 files changed, 133 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > index e7bfe1bde49e..f63268341739 100644
> > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > @@ -1538,6 +1538,17 @@
> > > > >                       Permit 'security.evm' to be updated regardless of
> > > > >                       current integrity status.
> > > > >
> > > > > +     exec.seal_system_mappings = [KNL]
> > > > > +                     Format: { no | yes }
> > > > > +                     Seal system mappings: vdso, vvar, sigpage, vsyscall,
> > > > > +                     uprobe.
> > > > > +                     - 'no':  do not seal system mappings.
> > > > > +                     - 'yes': seal system mappings.
> > > > > +                     This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=(y/n)
> > > > > +                     If not specified or invalid, default is the value set by
> > > > > +                     CONFIG_SEAL_SYSTEM_MAPPINGS.
> > > > > +                     This option has no effect if CONFIG_64BIT=n
> > > > > +
> > > > >       early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
> > > > >                       stages so cover more early boot allocations.
> > > > >                       Please note that as side effect some optimizations
> > > > > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> > > > > index 41102f74c5e2..bec122318a59 100644
> > > > > --- a/Documentation/userspace-api/mseal.rst
> > > > > +++ b/Documentation/userspace-api/mseal.rst
> > > > > @@ -130,6 +130,10 @@ Use cases
> > > > >
> > > > >  - Chrome browser: protect some security sensitive data structures.
> > > > >
> > > > > +- seal system mappings:
> > > > > +  kernel config CONFIG_SEAL_SYSTEM_MAPPINGS seals system mappings such
> > > > > +  as vdso, vvar, sigpage, uprobes and vsyscall.
> > > > > +
> > > > >  When not to use mseal
> > > > >  =====================
> > > > >  Applications can apply sealing to any virtual memory region from userspace,
> > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > index 63de71544d95..fc5da8f74342 100644
> > > > > --- a/arch/arm64/Kconfig
> > > > > +++ b/arch/arm64/Kconfig
> > > > > @@ -44,6 +44,7 @@ config ARM64
> > > > >       select ARCH_HAS_SETUP_DMA_OPS
> > > > >       select ARCH_HAS_SET_DIRECT_MAP
> > > > >       select ARCH_HAS_SET_MEMORY
> > > > > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > > >       select ARCH_STACKWALK
> > > > >       select ARCH_HAS_STRICT_KERNEL_RWX
> > > > >       select ARCH_HAS_STRICT_MODULE_RWX
> > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > index 1ea18662942c..5f6bac99974c 100644
> > > > > --- a/arch/x86/Kconfig
> > > > > +++ b/arch/x86/Kconfig
> > > > > @@ -26,6 +26,7 @@ config X86_64
> > > > >       depends on 64BIT
> > > > >       # Options that are inherently 64-bit kernel only:
> > > > >       select ARCH_HAS_GIGANTIC_PAGE
> > > > > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > > >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > > > >       select ARCH_SUPPORTS_PER_VMA_LOCK
> > > > >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > > > > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> > > > > index 2fb7d53cf333..30e0958915ca 100644
> > > > > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > > > > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > > > > @@ -366,8 +366,12 @@ void __init map_vsyscall(void)
> > > > >               set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> > > > >       }
> > > > >
> > > > > -     if (vsyscall_mode == XONLY)
> > > > > -             vm_flags_init(&gate_vma, VM_EXEC);
> > > > > +     if (vsyscall_mode == XONLY) {
> > > > > +             unsigned long vm_flags = VM_EXEC;
> > > > > +
> > > > > +             vm_flags |= seal_system_mappings();
> > > > > +             vm_flags_init(&gate_vma, vm_flags);
> > > > > +     }
> > > > >
> > > > >       BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
> > > > >                    (unsigned long)VSYSCALL_ADDR);
> > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > index df0a5eac66b7..f787d6c85cbb 100644
> > > > > --- a/include/linux/mm.h
> > > > > +++ b/include/linux/mm.h
> > > > > @@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
> > > > >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > > >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > > >
> > > > > +#ifdef CONFIG_64BIT
> > > > > +/*
> > > > > + * return VM_SEALED if seal system mapping is enabled.
> > > > > + */
> > > > > +unsigned long seal_system_mappings(void);
> > > > > +#else
> > > > > +static inline unsigned long seal_system_mappings(void)
> > > > > +{
> > > > > +     return 0;
> > > > > +}
> > > >
> > > > OK so we can set seal system mappings on a 32-bit system and
> > > > silently... just not do it?...
> > > >
> > > I don't understand what you meant.
> > >
> > > The function returns the vm_flags for seal system mappings.
> > > In 32 bit, it returns 0.
> > >
> > > the caller (in mmap.c) does below:
> > > vm_flags |= seal_system_mappings();
> > >
> > > (The pattern is recommended by Liam. )
> > >
> > > Is that because the function name is misleading ? I can change it to
> > > seal_flags_system_mappings() if there is no objection to the long
> > > name.
> >
> > No, I'm saying that you're making it possible for somebody to enable this
> > feature on a 32-bit system, and to think it's enabled and that they're
> > protected when in fact they're not.
> >
> The kernel cmdline change already has comments about 32-bit:  see:
> kernel-parameters.txt
> "This option has no effect if CONFIG_64BIT=n"
>
> > Which is, security-wise, I think rather unwise.
> >
> > Again it's an argument against a cmdline parameter. See below.
> >
> > >
> > > > > +#endif
> > > > > +
> > > > >  #endif /* _LINUX_MM_H */
> > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > index 1aa95a5dfff8..614719259aa0 100644
> > > > > --- a/init/Kconfig
> > > > > +++ b/init/Kconfig
> > > > > @@ -1860,6 +1860,31 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> > > > >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> > > > >       bool
> > > > >
> > > > > +config ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > > > +     bool
> > > > > +     help
> > > > > +       Control SEAL_SYSTEM_MAPPINGS access based on architecture.
> > > > > +
> > > > > +       A 64-bit kernel is required for the memory sealing feature.
> > > > > +       No specific hardware features from the CPU are needed.
> > > > > +
> > > > > +       To enable this feature, the architecture needs to be tested to
> > > > > +       confirm that it doesn't unmap/remap system mappings during the
> > > > > +       the life time of the process. After the architecture enables this,
> > > > > +       a distribution can set CONFIG_SEAL_SYSTEM_MAPPING to manage access
> > > > > +       to the feature.
> > > > > +
> > > > > +       The CONFIG_SEAL_SYSTEM_MAPPINGS already checks the CHECKPOINT_RESTORE
> > > > > +       feature, which is known to remap/unmap vdso.  Thus, the presence of
> > > > > +       CHECKPOINT_RESTORE is not considered a factor in enabling
> > > > > +       ARCH_HAS_SEAL_SYSTEM_MAPPINGS for a architecture.
> > > > > +
> > > > > +       For complete list of system mappings, please see
> > > > > +       CONFIG_SEAL_SYSTEM_MAPPINGS.
> > > > > +
> > > > > +       For complete descriptions of memory sealing, please see
> > > > > +       Documentation/userspace-api/mseal.rst
> > > > > +
> > > > >  config HAVE_PERF_EVENTS
> > > > >       bool
> > > > >       help
> > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > index 57fd5ab2abe7..bc694c555805 100644
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapping(
> > > > >       unsigned long addr, unsigned long len,
> > > > >       unsigned long vm_flags, const struct vm_special_mapping *spec)
> > > > >  {
> > > > > +     /*
> > > > > +      * At present, all mappings (vdso, vvar, sigpage, and uprobe) that
> > > > > +      * invoke the _install_special_mapping function can be sealed.
> > > > > +      * Therefore, it is logical to call the seal_system_mappings_enabled()
> > > > > +      * function here. In the future, if this is not the case, i.e. if certain
> > > > > +      * mappings cannot be sealed, then it would be necessary to move this
> > > > > +      * check to the calling function.
> > > > > +      */
> > > > > +     vm_flags |= seal_system_mappings();
> > > > > +
> > > > >       return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
> > > > >                                       &special_mapping_vmops);
> > > > >  }
> > > > > diff --git a/mm/mseal.c b/mm/mseal.c
> > > > > index ece977bd21e1..80126d6231bb 100644
> > > > > --- a/mm/mseal.c
> > > > > +++ b/mm/mseal.c
> > > > > @@ -7,6 +7,7 @@
> > > > >   *  Author: Jeff Xu <jeffxu@chromium.org>
> > > > >   */
> > > > >
> > > > > +#include <linux/fs_parser.h>
> > > > >  #include <linux/mempolicy.h>
> > > > >  #include <linux/mman.h>
> > > > >  #include <linux/mm.h>
> > > > > @@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
> > > > >  {
> > > > >       return do_mseal(start, len, flags);
> > > > >  }
> > > > > +
> > > > > +/*
> > > > > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > > > > + */
> > > > > +enum seal_system_mappings_type {
> > > > > +     SEAL_SYSTEM_MAPPINGS_DISABLED,
> > > > > +     SEAL_SYSTEM_MAPPINGS_ENABLED
> > > > > +};
> > > > > +
> > > > > +static enum seal_system_mappings_type seal_system_mappings_v __ro_after_init =
> > > > > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_ENABLED :
> > > > > +     SEAL_SYSTEM_MAPPINGS_DISABLED;
> > > > > +
> > > > > +static const struct constant_table value_table_sys_mapping[] __initconst = {
> > > > > +     { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > > > > +     { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > > > > +     { }
> > > > > +};
> > > > > +
> > > > > +static int __init early_seal_system_mappings_override(char *buf)
> > > > > +{
> > > > > +     if (!buf)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     seal_system_mappings_v = lookup_constant(value_table_sys_mapping,
> > > > > +                     buf, seal_system_mappings_v);
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
> > > > > +
> > > > > +unsigned long seal_system_mappings(void)
> > > > > +{
> > > > > +     if (seal_system_mappings_v == SEAL_SYSTEM_MAPPINGS_ENABLED)
> > > > > +             return VM_SEALED;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > diff --git a/security/Kconfig b/security/Kconfig
> > > > > index 28e685f53bd1..5bbb8d989d79 100644
> > > > > --- a/security/Kconfig
> > > > > +++ b/security/Kconfig
> > > > > @@ -51,6 +51,30 @@ config PROC_MEM_NO_FORCE
> > > > >
> > > > >  endchoice
> > > > >
> > > > > +config SEAL_SYSTEM_MAPPINGS
> > > > > +     bool "seal system mappings"
> > > >
> > > > I'd prefer an 'mseal' here please, it's becoming hard to grep for this
> > > > stuff. We overload 'seal' too much and I want to be able to identify what
> > > > is a memfd seal and what is an mseal or whatever else...
> > > >
> > > I m OK with MSEAL_
> >
> > Thanks.
> >
> > >
> > > > > +     default n
> > > > > +     depends on 64BIT
> > > > > +     depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > > > +     depends on !CHECKPOINT_RESTORE
> > > >
> > > > I don't know why we bother setting restrictions on this but allow them to
> > > > be overriden with a boot flag?
> > > >
> > > The idea is a distribution might not enable kernel security features
> > > by default, and kernel cmdline provides flexibility to let users
> > > enable it.
> > >
> > > This is the same approach as  proc_mem.force_override kernel cmd line
> > > where Kees recommended  [1], I would prefer to keep this as is.
> > >
> > > [1] https://lore.kernel.org/all/202402261110.B8129C002@keescook/
> > >
> >
> > This is flawed on multiple levels. Firstly, from the linked change:
> >
> >         +config SECURITY_PROC_MEM_RESTRICT_WRITES
> >         +       bool "Restrict /proc/<pid>/mem write access"
> >         +       default n
> >         +       help
> >
> > There are no 'depends on'. Yours has 'depends on' which you've just
> > rendered totally irrelevant including _allowing the enabling of this
> > feature in broken situations_ like CRIU, as I mentioned below.
> >
> > For another, the linked feature changes behaviour and a user may or may not
> > want to allow the ability to write to /proc/<pid>/mem which is ENTIRELY
> > DIFFERENT from this proposed feature.
> >
> > Under what circumstances could a user possibly want to write VVAR, VDSO,
> > etc. etc.? It just makes absolutely no sense for this to be a boot switch.
> >
> > So the arguments presented there have zero bearing on this series.
> >
> > > > This means somebody with CRIU enabled could enable this and have a broken
> > > > kernel right? We can't allow that.
> >
> > Please do not ignore review comments like this.
> >
> kernel cmdline is a valid user case.   The reasoning is explained in
> the previous response, it allows users to enable security features
> without having to rebuild the distribution's kernel.
>
> For the concern that CRIU user enables this feature through kernel
> cmdline mistakenly, there is already instruction and comments
> throughout code to make aware of the impact to CRIU after enabling
> sealing for system-mapping. In my view: users who want to enable this
> feature through kernel cmdline  should already have enough context
> about this, i.e. it is an educated decision rather than experimenting.
>
> That said, if we want to protect those CRIU users from mistakenly
> enabling memory sealing,  we could add a check to verify CRIU is not
> enabled, i.e. if CRIU is enabled, the kernel cmd line has no effect.
> Although in my view  this is an extra complicity without meaningful
> benefit -  If it is the user's educated choice, I prefer to honor it.
>
>
>
> > > >
> > > > I'd much prefer we either:
> > > >
> > > > 1. Just have a CONFIG_MSEAL_SYSTEM_MAPPINGS flag. _or_
> > > > 2. Have CONFIG_MSEAL_SYSTEM_MAPPINGS enable, allow kernel flag to disable.
> > > >
> > > > In both cases you #ifdef on CONFIG_MSEAL_SYSTEM_MAPPINGS, and the
> > > > restrictions appply correctly.
> > > >
> > > > If in the future we decide this feature is stable and ready and good to
> > > > enable globally we can just change the default on this to y at some later
> > > > date?
> > > >
> > > > Otherwise it just seems like in a effect the kernel command line flag is a
> > > > debug flag to experiment on arbitrary kernels?
> > > >
> > > > > +     help
> > > > > +       Seal system mappings such as vdso, vvar, sigpage, vsyscall, uprobes.
> > > > > +
> > > > > +       A 64-bit kernel is required for the memory sealing feature.
> > > > > +       No specific hardware features from the CPU are needed.
> > > > > +
> > > > > +       Depends on the ARCH_HAS_SEAL_SYSTEM_MAPPINGS.
> > > > > +
> > > > > +       CHECKPOINT_RESTORE might relocate vdso mapping during restore,
> > > > > +       and remap/unmap will fail when the mapping is sealed, therefore
> > > > > +       !CHECKPOINT_RESTORE is added as dependency.
> > > > > +
> > > > > +       Kernel command line exec.seal_system_mappings=(no/yes) overrides
> > > > > +       this.
> > > > > +
> > > > > +       For complete descriptions of memory sealing, please see
> > > > > +       Documentation/userspace-api/mseal.rst
> > > > > +
> > > > >  config SECURITY
> > > > >       bool "Enable different security models"
> > > > >       depends on SYSFS
> > > > > --
> > > > > 2.47.0.338.g60cca15819-goog
> > > > >
