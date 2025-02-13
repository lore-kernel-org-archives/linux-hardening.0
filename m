Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541ED1FFC59;
	Thu, 13 Feb 2025 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480114; cv=fail; b=tpyPmV68z+1iY0lVIpvy4kTqkyCp0MwMT+U/e1L4BA8/Ed0r+pJgqlx8U8WXWLWrEI53rfHv9oXt5qC5L27BCIdfatCyLBPxz8gXCQfyb/suhmKFmdlompnrtd79yw2cjWRM/q1Bn0IN4CHb63q0id1zC+o5sKka4xyV01hjHs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480114; c=relaxed/simple;
	bh=OxShVD2eyYRWNa4NApaCHCiQ1BA+dj/BgBOczTcs67w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cgDqu1W3+pYnPpDduY6+MkKj0f2X5YrrxyiC+Yk00QxWvo8rqBfIlwm7xoNKKDRgdSiU5+fZ3wUzTAtMEbeirYUtDfGPfEbFOYTktwAuCijhVivNLVBj1qRpT06KOen1vxY6a6ALMF/CwWn5KPaZm192LZ1ee/Ev/TS/Y3iMePk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LMdt6Mmf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ERP0pAQI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LMdt6Mmf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ERP0pAQI"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfYJP027481;
	Thu, 13 Feb 2025 20:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sGIASJqAekjaDfNBtVc7NRhbsX99vYx0vIdZz1mYlzc=; b=
	LMdt6MmflbYRnvqd7mEFbYRPvnS1dZs1GTVlTDlcdppUDetednFoI07ng8ZEyUTx
	wHAhLTU0OLilY1KJYV80lCD6WfQra58HbP+vXEuHc/AZebcESJi/W3yO2TrAfSXV
	LR5QRcVrNBWydzmIZ3YEARgOzQ6OCTpkSP5k+iCSq7PC8EC9rCnUwF7eSWyhIUej
	iQBRhdzq2ht+qQ/gmeRzOrV6xRdw2Q5xq/yojZBMgjgcQMEJaH5+fMWvjMcbM2HP
	kIZu2qe0ywEeM50Japfz3g5qUZxsFNQlOCkUdoSEmu4YtXWDL5znvAkg+alXN+ka
	new//V7snNHUII55IOaYLA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qajek5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 20:54:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DKNRiB017607;
	Thu, 13 Feb 2025 20:54:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqjm3mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 20:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTuQ4EWvCe27+Dix//UxagogvCzIywGEGE6Q7CxyTb3KjlLObJjt5xuFiPUJvsceC8E1JpG3ddRVRMg3pK6xNVsZU7U8HCnGsfbLuTH+2AN5BGgwu+afox0M5H3kg0pn0cCwq6qxfJzR/L0PeC7I5ETVfnmZ3lhtr9BbsbCGHCHCiPkHztXHvz/tbcTkF4trOP3JBBTAe+iFTdMN6zzenCHdz2W3SOyAVSww2J9j9d4yEw8xRFpnJ297hRfWyUv+CoYWOdtXZgsHSd7dhrRPYDXrzsNtOpfxHrX+XNLepcxN3LhxIWOpaRswCnLcmzD1HlztXIUtl0VG1PxyzuApUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGIASJqAekjaDfNBtVc7NRhbsX99vYx0vIdZz1mYlzc=;
 b=Qw2wIXWV5CKGT7QI7J+btnPjWwjbPsnIOfmpC1INXEiCHrI2os3h7UNqdNs0hpQKhtQXxDXMgUF3+rxsN80q8Sy5FkpytTo2BaQSaZB8gJUcdU9MZh0XsJgXf0QFftuuiVTMP7A45LqNI3rUHMs1rxc1oDUqLT2zPvN+kiVRon4GYNiKGtjkFKJ3Rr/fCAbq4E0vhobP0Wu83uEGTAJJu2PRIYA2V28VtkuLRxt8C5pklhNX9F+pyeMe+THRyOSeFRSu7kqnm6+df7wjxCLnXccnCyR0Q9DLdSue2wAGOFQYPjG2OUlERxvAOIgJexa0a3uvTnMgtHLzt1axsuN5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGIASJqAekjaDfNBtVc7NRhbsX99vYx0vIdZz1mYlzc=;
 b=ERP0pAQIDyiLI2lT11x8pYWuY7BFFoB/6SZAmRwHUmAkjXJj6wLp/Y+kOx5/fsa84NHshcz8IcpNP692wAh9UQXrfs9CIMWoAioRCP/l3KFV7pZJDhjVL8e9ySqytmiHzbeHZ6NRcvIuGD+d0cnHklbEWOmBOiiu7MiTvjQoTH8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 20:54:25 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 20:54:24 +0000
Date: Thu, 13 Feb 2025 15:54:18 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
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
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
Message-ID: <t5hsasch3aybjujmjzs3shpiorcgzp5pjc4fmz77u574voi3hr@qomzrd2llv2q>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250212032155.1276806-1-jeffxu@google.com>
 <20250212032155.1276806-2-jeffxu@google.com>
 <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
 <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
 <66q7feybn3q2vuam72uwmai322jdx3jtv2m5xmh75l6w6etqiv@knpsyh3o627k>
 <202502131142.F5EE115C3A@keescook>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202502131142.F5EE115C3A@keescook>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0066.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aa3b93-4967-453b-a7ed-08dd4c70992e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGhGWlVnb0ptOGxzVnUwY0VEM1NvcEtRdTNlZDdCYmZKd1RpZVhCYnJmSzZN?=
 =?utf-8?B?Qkk1YUtEYWNwSk1FTytsRk1jcWkxQ3FDYm5kYVM3ZDQxZDBMTnVzSmY0UDZk?=
 =?utf-8?B?YzZHZFFvL0V0bFF1QUZBQ0trbDJkQitYaDdzTTFTWVhMa2VjWmc5dzAxZ0Ir?=
 =?utf-8?B?ZWc4QVVXZ1hlNTVCWmFZWkRPN1lRVGZIZTVsM1QrRmJXNWdTWGg4ZGIyVWhp?=
 =?utf-8?B?Rk9QOTE5SjZ3YjN3ektyNGxXSEF0YzZIcllmYWxUTE1YV0h3bnZLMGM0T1o4?=
 =?utf-8?B?U21hd0dRcUxSbVFkbU9oUC82ME9EREhIYUh1UWhNelFXU3E2UEF2TVVObGM5?=
 =?utf-8?B?WVNUTFA5M1NaMnJGN1dBMTRMZXBZdUVHZm5xbHBoRlU1K092amQwMkM5c2Er?=
 =?utf-8?B?UGhjN2V3OXErWDlBSEsrWFZiTUFvek1iYmdoczBXMTNQMVZvdERUNTlGOHR0?=
 =?utf-8?B?TmhZTTFCWlJUY05yWDcrM0xFUXkwcmF6WUpHeGMrUXBZUWo2dkc0WFJQeHNU?=
 =?utf-8?B?clNqdGN1akJLRFNVY0hGWlpOUlJSdWdlMkgwb1JGOXBlZ0tzbTRyOFV0S2ZK?=
 =?utf-8?B?eGRkeWRKenVqVk5nK0hZalE3NDVEc3BQV0wwc0kxUlZtcXVabnVUdUdjallH?=
 =?utf-8?B?MDFZZ1ozRU5GMUE3dHNPZ1AyZ1E4blZMTlhhYVRORFpVNExydGpHRHJBVVFh?=
 =?utf-8?B?akd3RmFrNVVlTGZlbEVLdVlpR2FsWUdXZ0REdC94ZkFhcjh5aXZpOHBVMEFz?=
 =?utf-8?B?UGphbUtNVmd1N2s3Z0VLZU44NW5CL1FkOHpsRWE0bGdBVmpGa2Z6cVg3ZXdC?=
 =?utf-8?B?MnBiODgremNqdFBQYkMvQXpPNnN1R3JSbUYwQkNVekNHYVpMaXNJbmhRY3FV?=
 =?utf-8?B?T2VpQ1VpcUhGYzBzUW5wZ0Z3U0tod3FWQW8vS2pmWklDTDhUMFp6U1BhT2ls?=
 =?utf-8?B?U1RxUjdvZHlNMGNzMUxLWFJtWHhaMk41SGFoYmplRVAzNnJpUDgxaE1Yei9D?=
 =?utf-8?B?ZVNpYmRBN0Z0STFFdVpiU2lueWtIQ2VZZi9wNGpHMW5hdWVGRVhINXc0TXNr?=
 =?utf-8?B?azMwZXZDemUrd1NFRnVvMGlFUWptWDdab1VRcUFUL29sSkVmTG9kakg0SGI3?=
 =?utf-8?B?R09oZlUyMEYwWXF6R1d3S1k3UkFUTnRlNlByb2k5cUdlU3FjMWV1ZHJGZ0hG?=
 =?utf-8?B?WWN2YlZxR1AxVURDUFZYcTJNQ2xTSmtxVW01UWU0eG50aVJsWjNLbjVFa0lE?=
 =?utf-8?B?VlYyeE1vcDZKbnFsTXdkamdsSVpNVDZVWUhCNHdaVGZhSEpqMEpTcTdFRnJx?=
 =?utf-8?B?aWJGc1dzMHNnQmJNM0NRRVVQUUhnY3FueGloMmpHdVBPNG9CWjJ1eFdSN3Y1?=
 =?utf-8?B?VUlac29PRFdYYXl0a1dMZEhtbFhkY1VuTW04bEc3Sk9NTXJqNmtxdkJRVUg1?=
 =?utf-8?B?Y3dQYVh2RWd6YTFQY0h6VlFxaEdlYjExcFRVcTJYanRWNE5sUHcwaHlIcllt?=
 =?utf-8?B?VTZ0RGkrMFdtSVNQdEV4VkdxTGVYUHFnaWhxQnNVZFJPbXVZb1RWbXJmbkJo?=
 =?utf-8?B?cDlQbGdSZUlwb3Y4WjFFL3MyeG5DZjdaeDlTNnlOcW9TZkNoVjFYanM3QlFN?=
 =?utf-8?B?NXErai83a2wyYjZKVkxxdGJnbzFxMFZ3WHlFTUNBcnNOL2VuaDBWOVlqVzdT?=
 =?utf-8?B?anlySUVmM3NHTkJaWm9NYWtXUVVqMFJVNktTTml1SDd2bTZpS3FGQzlBR1VF?=
 =?utf-8?B?YzVEa0JaVkNCU0ZnbEFCckQ5b3NPNWZ6Z2RTM0VLM05TQklZcDJ3VnBSZzRG?=
 =?utf-8?B?T0FwV3FDbnZVNnluY1gzRVZ4SHdRVUpubGRNak5jOXY5ZER2Rml2ck8vSG9M?=
 =?utf-8?Q?QA7FPLACVGv8D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWFCOXVPbm1xTldlRUROamtjNjdZOFcveDkxWGxQb0VNb21EdE1NcVZubWRJ?=
 =?utf-8?B?SjhzSklCWGw1UDBYTUFJdjdxQW9tWVhkWHZJNEU3UlBrc1RhU3M5RU8ySjBR?=
 =?utf-8?B?NjBIaVdWY0c3RndFWFV3dTk3aCtNdXZDUmxWeFpMMnR6ZVNOQzBpWTNDOUcy?=
 =?utf-8?B?Qmh2dVdaTVNDOVA5OHV6SVYxOHQrQ3U0UFozWnBlNXZaR2JUclZEWk1KcTFY?=
 =?utf-8?B?SFpuN0RlWGtoY2pwYTFmbXUrL3FHZHByWCtweFB5eTZ6dG1tUHZSNHRidmUx?=
 =?utf-8?B?OXllYWYwY0grZnRMN0dsYXZTbkt6VElkTWg2cWt6SFVsZFRnZGluRjFrWUla?=
 =?utf-8?B?MlI1UWpRZ29OZG5mUUxkbG8vdldCYllTbTQvK2tEdm9vZ1dnRmJSWFF6Ri9B?=
 =?utf-8?B?QzBJSzB1M2hrS0Z6L0RBNFQ0a1Z6aCs2MmxDQjNHZFFaOEhRSVZRRkZuY3Rz?=
 =?utf-8?B?MmE3UUNEbDJvMG44UGdISjBMRmR2NzViczlERy9CK3doMGxkZFV1WTdtREZC?=
 =?utf-8?B?SE81Y0p3S3c0S2oxbVR0am1Yb3pNWmRjYWI4Q3Vic1l5bmxFdmZQODcrZDRn?=
 =?utf-8?B?d0VoTFd5NlExN1JVUVpDSTVtenFyZEpuS25zK0dMZEgyR0FCOUxud2tERGNW?=
 =?utf-8?B?RkNaOUc2WFMvSW1pYitNRnQwdWZnT2JTQXh2UytWeTJLVzlnRDFxc01jSlRJ?=
 =?utf-8?B?b21PazhZaWZ5anBuU0o0Z0R4OUV4bDZNYjhoVk1OUWNHbTQ4d2JjNlpQbmxx?=
 =?utf-8?B?TzNNUWtSd1dwVm5VekVrL0pVUWRuK0JMb0ZPb3lCVWhib25xaXgyS3NQVnZS?=
 =?utf-8?B?OENHa05FTElkd1RlZWt5c1pCM3Z5SEJBVVZtemZwd2NXeHQrQW9WdjB2YU9K?=
 =?utf-8?B?VkhPS1BkaW8rWHhFdVd6RW1NbXF3NWZFL051SThhd3FmRE9SK2NoTFhnc0pi?=
 =?utf-8?B?MzNiQ0hCZTNXbUxGVC8wMklNK0RIdjRSQ2tvWmx1cWhVRW9HblNDV2dYSmtW?=
 =?utf-8?B?Q0RWVmNKUDZ4UEorbnFJVlJzTTZmK0V6QWk3WlNZT2tWUDdQSHljYWNLeXdl?=
 =?utf-8?B?azhnVnNXSU5GdHM1c2pQT2J2TjNMaExzekR0NG1yVWRPUWpZTnRLclprZmMx?=
 =?utf-8?B?ZnVoRFNXck94bjlFUVFjdGJHcTZMYmNBS0IwU2dRdHlBMjZlTWJRRUd4Mk1z?=
 =?utf-8?B?eldVdTFYcmljeEt5Rm0vNm9oSzNoTXcrYXdLemRGQXd6aFArVEVhQVNoK29s?=
 =?utf-8?B?RGNNbHRiQkNUdXIyY0drMGljVGNiRFUvUzlHdDQrb3BtR3B4eUFrOGptVmVv?=
 =?utf-8?B?RFdqY2lTNCtJN2dNTlUrdWlad0FTOFRvV3lHbHEzT0lTcmVKbjR3b2o1YnpM?=
 =?utf-8?B?QmFNdWZsMThWbnBEZndweWZkaC9LNGNoOTI4c3QrSVZSWjNMUkg4dzhlYW5s?=
 =?utf-8?B?SktHWmZhVDY2U2U3Y1ZNZkVGYm95cEUrLzZ5T0g1ekRjaitwRjF5NkVRc0tS?=
 =?utf-8?B?dU5BNjQ0VEVwVUU2WnRHTmxTM1drREphU1Z1NzI1MWdaUm9EVXllMVp1WWZR?=
 =?utf-8?B?Ty9GN1dxV0dPcTJiWEVJQnhnT2oraEE2VTVVNkZlQlZTYmhiTXBHU1dXcnJh?=
 =?utf-8?B?VXFzaXNaRmlHTVZSYyttaGEwOEZrMG4rY0lmTldQL054RHdqc21lSTlKanIv?=
 =?utf-8?B?Ym94V1VTajNmVy9lQWdjT0VYN21MWnZTWVh1Ymc2WVBhZ04vRTJQdXlVN3Zr?=
 =?utf-8?B?a0kxbUF2THN0SVhNamU3VjdJRE5jbitoWmw1WXhXOWdCaTlTeEQxVzBlWGM1?=
 =?utf-8?B?dVJhdFlIdGNtYlJvM1dMSDMxRzBkSGVoZVYxT1VSSmFrWjVUbEpIYWlKN21r?=
 =?utf-8?B?eXhpNEJCZlRmQVZ4OG14UWZKeEY4ckFtTjJyOUR3WGFRK0I4Qm10bTZJTlpm?=
 =?utf-8?B?TkJEaDJLZWZSWjErR1pCd0k0eUxsMXhsL0EweTZRQ20zcUc1aGgzNFgyL1lq?=
 =?utf-8?B?RDVBVHVkejZNN0RvSmxUMlFnWXpPcEE4REtlOVdqc2JwL1FSZW92NXNMWU40?=
 =?utf-8?B?OUdUN013am1pMnl0cG1XcjVGcnpzdDBuSW5oT29XZEhlbVpGUVFRNUtYTDhn?=
 =?utf-8?Q?AqbgLEviVyzMDCyNnb/+A1Mkw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kORNkxf6wV9ynf/jrihxP67eV3lceSLfD6STWPTgPK13vwe1kwvJrlQyvYItsf3tOOqxn+NHriRYZitxZu9gwshJ+Gcjjiadb2wNrvp44y3JaMmCIqCWkZDFpAm2xqBocafYJlIgjbqy7RoImsBfQ6Opt1JFJck4raJwm5w5T9EUbYNjAjyB6Vq9+pvKCwunvnhj89uug02d35+2iG0DkMdVfvczsoLY+56oG8fuuhNn8W2qEy0wOKKGDgxVwr5TGDkbXkNpMHnBK4rrwRH8Cqh9npjUossniENEVJ7XUyhBCO7SGUAhR5q+qDo2A1CWD7oEcP57MzTUPez0nz5hOYeJScN3j3aR6YMFDi//ragom8tE3zAZ3a/UjqD3vfj0FVXMHIRrhwjJBOMTNf/StTR97cDhqfBsohrWpHq6Ga2PK1YvdCPcQxwPlQn2rbHsJq9CYuV8uG9tWTpYvd2TIXdRfB+ZFl03nHhY+gl953qYHk4hnEFd70iSdZzPc5P3zCIv/jlJXPRyhQh3dY59AH1UnuRyX+VxXupBoCL2EV7aEfJ/0i71ivPNJOZ62YQ5q3kyjV8cPzA5IRkiIE2AAnCRnrsht/xuxQtMH42YNcM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aa3b93-4967-453b-a7ed-08dd4c70992e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 20:54:24.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTpwqvmSi7CHxgeqAjaoLi1p8fb3vLvDyZDOELbisqHjBCV4ejuxzYexEGU9gnVreAEi8CwFYLRNIMrxsXx44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130147
X-Proofpoint-GUID: 13ahe7XXSdanr2ruD95F-UcALuhZsBKN
X-Proofpoint-ORIG-GUID: 13ahe7XXSdanr2ruD95F-UcALuhZsBKN

* Kees Cook <kees@kernel.org> [250213 15:11]:
> On Thu, Feb 13, 2025 at 01:29:46PM -0500, Liam R. Howlett wrote:
> > * Jeff Xu <jeffxu@chromium.org> [250213 12:17]:
> > > On Wed, Feb 12, 2025 at 7:05=E2=80=AFAM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > ...
> > > > >
> > > > > In this version, we've improved the handling of system mapping se=
aling from
> > > > > previous versions, instead of modifying the _install_special_mapp=
ing
> > > > > function itself, which would affect all architectures, we now cal=
l
> > > > > _install_special_mapping with a sealing flag only within the spec=
ific
> > > > > architecture that requires it. This targeted approach offers two =
key
> > > > > advantages: 1) It limits the code change's impact to the necessar=
y
> > > > > architectures, and 2) It aligns with the software architecture by=
 keeping
> > > > > the core memory management within the mm layer, while delegating =
the
> > > > > decision of sealing system mappings to the individual architectur=
e, which
> > > > > is particularly relevant since 32-bit architectures never require=
 sealing.
> > > > >
> > > > > Additionally, this patch introduces a new header,
> > > > > include/linux/usrprocess.h, which contains the mseal_system_mappi=
ngs()
> > > > > function. This function helps the architecture determine if syste=
m
> > > > > mapping is enabled within the current kernel configuration. It ca=
n be
> > > > > extended in the future to handle opt-in/out prctl for enabling sy=
stem
> > > > > mapping sealing at the process level or a kernel cmdline feature.
> > > > >
> > > > > A new header file was introduced because it was difficult to find=
 the
> > > > > best location for this function. Although include/linux/mm.h was
> > > > > considered, this feature is more closely related to user processe=
s
> > > > > than core memory management. Additionally, future prctl or kernel
> > > > > cmd-line implementations for this feature would not fit within th=
e
> > > > > scope of core memory management or mseal.c. This is relevant beca=
use
> > > > > if we add unit-tests for mseal.c in the future, we would want to =
limit
> > > > > mseal.c's dependencies to core memory management.
> > > > >
> > > ...
> > > > >
> > > > > diff --git a/include/linux/userprocess.h b/include/linux/userproc=
ess.h
> > > > > new file mode 100644
> > > > > index 000000000000..bd11e2e972c5
> > > > > --- /dev/null
> > > > > +++ b/include/linux/userprocess.h
> > > > > @@ -0,0 +1,18 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +#ifndef _LINUX_USER_PROCESS_H
> > > > > +#define _LINUX_USER_PROCESS_H
> > > > > +#include <linux/mm.h>
> > [...]=20
> >=20
> > Also, I don't agree with your stated reason for a new header.
> >=20
> > Please remove this header until it is needed.  It can be added later if
> > it is needed.  If we all had tiny headers because we might need them in
> > the future, we'd have serious issues finding anything and the list of
> > included headers would be huge.
> >=20
> > You have added unnecessary changes and complications to this patch set
> > on v5.
>=20
> In all fairness, I think v5 is significantly less complex overall. Jeff
> used his best judgement with a new header, and I don't think it's
> unreasonable. That it is unwanted is fine, mm.h it is, but I think it's
> clear the intent was trying to make this as least burdensome for the mm
> subsystem as possible.

This version is certainly easier to follow, but it's still more
complicated than it needs to be.  Adding custom headers seems like an
unnecessary addition to previous versions.

I didn't mean this to be a jab or upsetting - and sorry to both of you,
I can see how it could be taken this way.

I was trying to point out that this is the same sort of thing that got
Jeff into trouble with Linus about over-engineering the v8 of the mseal
patch set [1].

...

> > >=20
> > > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
> > > the build. This is intentional. Any 32-bit code trying to use the
> > > sealing function or the VM_SEALED flag will immediately fail
> > > compilation. This makes it easier to identify incorrect usage.
> >=20
> > So you are against using the #define because the VM_SYSTEM_SEAL will be
> > defined, even though it will be VM_NONE?  This is no worse than a
> > function that returns 0, and it aligns better with what we have today i=
n
> > that it can be put in the list of other flags.
>=20
> When I was reading through all of this and considering the history of
> its development goals, it strikes me that a function is easier for the
> future if/when this can be made a boot-time setting.
>=20

Reworking this change to function as a boot-time parameter, or whatever,
would not be a significant amount of work, if/when the time comes.
Since we don't know what the future holds, it it unnecessary to engineer
in a potential change for a future version when the change is easy
enough to make later and keep the code cleaner now.


> If mm maintainers prefer a #define for now, that's fine of course. The
> value of VM_SYSTEM_SEAL can be VM_NONE on 32-bit.

Thanks.  I think having a flag with VM_NONE on 32-bit is just as sane as
a "flags |=3D system_seal()" call that unconditionally returns 0 on
32-bit.

>=20
> > Also, my vote for where you should put this code is clear: it should
> > live with the mseal #define in mm.h.  You're going to need mm.h anyways=
,
> > and that's a big hint as to where it should live.
>=20
> Sounds good.
>=20
> > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > index d0d021b3fa3b..892d2bcdf397 100644
> > > > > --- a/init/Kconfig
> > > > > +++ b/init/Kconfig
> > > > > @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> > > > >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> > > > >       bool
> > > > >
> > > > > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > >
> > > > ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS is more clear.  HAS may mean it=
's
> > > > supported or it could mean it's enabled. SUPPORTS is more clear tha=
t
> > > > this is set if an arch supports the feature.  After all, I think HA=
S
> > > > here means it "has support for" mseal system mappings.
> > > >
> > > > I see that both are used (HAS and SUPPORTS), but I'm still not sure=
 what
> > > > HAS means in other contexts without digging.
> > > >
> > > The existing pattern is to indicate arch support with
> > > CONFIG_ARCH_HAS_N and   security/KConfig to have CONFIG_N as the main
> > > switch. For example, CONFIG_ARCH_HAS_FORTIFY_SOURCE and
> > > CONFIG_FORTIFY_SOURCE. Since the MSEAL_SYSTEM_MAPPINGS is placed in
> > > security/Kconfig, hence I'm following the existing pattern in
> > > security/Kconfig.
> >=20
> > Okay, thanks.  I really think SUPPORTS is more clear, but sticking with
> > whatever your area uses is also fine.
>=20
> Yeah, I've really scratched my head over what the best practice is here.
> There's a real mixture of "HAS" vs "SUPPORTS" across both hardware
> architectural support, software features, interface implementations,
> and compiler behavior that bridges between those. When I've looked in
> the past, it seemed that "HAS" was in the majority, but I've never been
> able to make sense of it.
>=20
> Let me look again. Today, HAS shows:
>=20
> $ git grep 'config .*_HAS_' | grep -v Documentation/ | \
>   awk '{print $2}' | cut -d_ -f1 | sort | uniq -c | sort -n
>       1 ARM
>       1 MAC80211
>       1 PGTABLE
>       1 PPC
>       1 RUSTC
>       1 USB
>       2 ARM64
>       2 SIBYTE
>       2 SOC
>       3 FS
>       3 PAHOLE
>       6 SGI
>       6 TOOLCHAIN
>      10 ARC
>      20 AS
>      32 SYS
>      34 CPU
>      38 CC
>     105 ARCH
>=20
> Looking through them, it's tools (CC, AS, PAHOLE, etc), and
> system/cpu/architecture prefixes, with ARCH being a clear winner.
>=20
> SUPPORTS looks similar, but isn't as widely used:
>=20
> $ git grep 'config .*_SUPPORTS_' | grep -v Documentation/ | \
>   awk '{print $2}' | cut -d_ -f1 | sort | uniq -c | sort -n
>       1 PPC64
>       1 X86
>       2 CLANG
>       2 GCC
>       2 RUSTC
>       8 CPU
>      38 SYS
>      71 ARCH
>=20
> The mips arch is using SYS, and distinguishes between HAS and SUPPORTS
> in the sense of "this kernel HAS support for CPU $foo, which SUPPORTS
> features x, y, z".
>=20
> Looking through ARCH_SUPPORTS, it's all software features. Looking
> through ARCH_HAS, it looks like a mix of hardware features
> and software features. Some software features are more about
> implementation availability, though (so "HAS" makes sense,
> but should maybe be "IMPLEMENTS"?) e.g. ARCH_HAS_SYSCALL_WRAPPER,
> ARCH_HAS_STRNLEN_USER, ARCH_HAS_FORTIFY_SOURCE, ARCH_HAS_ELF_RANDOMIZE,
> ARCH_HAS_STRICT_KERNEL_RWX, ARCH_HAS_STRICT_MODULE_RWX.
>=20
> So, I think I'd agree: this is about a software features and not an API
> implementation nor hardware feature, so let's use ARCH_SUPPORTS_.

This makes sense.  I grepped for both as well and found that HAS
outnumbers SUPPORTS, but there are a lot of each.  I figured using
whatever the subsystem uses is probably the right answer - your answer
is better.

Seeing them in the same kconfig option together gave me pause as to why
they were different.  Thanks for digging into this!


Regards,
Liam

[1] https://lore.kernel.org/linux-mm/CAHk-=3DwjGGgfAoiEdPqLdib7VvQgG7uVXpTP=
zJ9jTW0HesRpPwQ@mail.gmail.com/
