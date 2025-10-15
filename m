Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336D2FF144
	for <linux-hardening@vger.kernel.org>; Wed, 15 Oct 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517304; cv=fail; b=C7bh8/NoIITDCC9bidYQrND/phVsOPDFp2Off3JICuWabjN3Mx/PCJrZefTpa4TGitnzN0T1jc3QNUVrcR+ufHMK5jr/zbkj8bOBw/vfwBU6ILSGFV+2MyZXzE2lmLrLM5JqEvf4npopCv9T3J+YWmZkPm5KRLHdYR5IRJGmkaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517304; c=relaxed/simple;
	bh=UL+j57E/iWCloaD2THeVXgcYzxAqziJEob/t3vgy9IE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AsjSJSDxPYbF6zkwgD5Lgu6LKUsrFgLrrniRcbaXJXGBhvJFdZ+UBymBZr4M2aBolC2KfjouPQg8dDQZFf55SKF+17FqX/3Gh8PB/1lV2cbXDcPoSzQe0BmHXFAK4LncNNNHE5ay+MUwlp9DExkR/IhlG+Y3rEvy+da8+Ut7VdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k+IzdHMD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c9/0MmxV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k+IzdHMD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c9/0MmxV"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F4uEdf000983;
	Wed, 15 Oct 2025 08:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hWi0SrEQRsHI8EPAW5jRvbkMUURaXLmQWcoYLAwYxTI=; b=
	k+IzdHMDaoiPQTqfHLVCccFTqpAtQZUhVbbShWqbKn/ob29r69xgYryvH0oE6zFI
	G+PV35V34xV9sX7Aw63ccppeWm+FU4TRv8/rJyziXpci+1+qkO2HTXHNodyg3IsP
	JTiRV2A+z8U09ZURoRDRElk7gVXC3JnjodDa58kuBuvDDf6MbUnNdYqU826UnOkT
	bNPf4ioB5mwrRsm6w0n3xOs6bmz6CzBeHZoX0gQY+VvzViPZhFt9MVNhhm8neoIs
	TSXzw7H7XAUO4rCaJURzokP6C/VO5H9BFh2SbPCRFSuGfIADev+xChjs/i90Kpxy
	RIk+Vwh0jhvKV1cLkZFlOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtyp49x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 08:34:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F7Xoe4037964;
	Wed, 15 Oct 2025 08:34:48 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpg2tw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 08:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNkBH1LjIoXVtbVrrTS+HeVJEjumLiNWW0ka3Knfd7RGNq1GC4W/ixp7xTsq+3QgwxMY4PyAuXzvH74E13gG7fRgMRxf079Qc6TkGPBfe92cvzZMa4mlcAUybJ9I/4bz6rNnzbwWOD7AXXugP7ZO1zKmY5ztKyp2QJvgeJbdUu3/u14+93A/JNmr/ZyqsMnK2X3nmAyj9CCbw7c6NpwwgcvljbxH6s+vy7u1wxksMeSme2bvNGLgwa0pTK6ycQrPYGTq7I0NuUAuFfvRbkYrkPaVDzdrauVIANqIHV/PJ07GOQkHnpd/DNtZ6vfjMNA66SCqsDt+/qckYeECTq8pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWi0SrEQRsHI8EPAW5jRvbkMUURaXLmQWcoYLAwYxTI=;
 b=PWA4eMD4drsLv6w7sf0acroweWSEivCi95KGMRgDsC1hH07T0yH8Gvvwe9Z9Qyxb4WN1XRDKl1hJT/evHIW0S6lbWq0dzYig65z4uRkUHTjWtjxR+MHJL51N6ciVHHk3jDUoUWbf6rQxzUfJ8jTGc0ieU/4qcceiJrCMe4FULhyLUYfhKsC1H2dhXvtPzA1pXg10MpWpxFQhhPi7f9BtPIwzJbVPlxmrMRNuvTOTG+nMDapsP7yGGrAcUDqDZo9dziuyKQsCilhbllIwK1y3LrzmgEkrcyXo7ZUjPdHBFD//f8PKvLUV5Q0xVvbS0yZpBN5MCvpolr+h4PVaklWpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWi0SrEQRsHI8EPAW5jRvbkMUURaXLmQWcoYLAwYxTI=;
 b=c9/0MmxVpU2cwKIT5hp/BQIqO3wFfignU81GYhRoCAP9kHvVgR1hqO43g/CIybxQJDcOi4Q1xvt1ApSaDLOeN378iRSRotE9mearW32P1U5quiE/dTsle0wxeVTVFoUzvbejISteD6FhS4TOQCutFwcRhIVD4N8e8HHcBTADlzE=
Received: from CY5PR10MB6011.namprd10.prod.outlook.com (2603:10b6:930:28::16)
 by BLAPR10MB4820.namprd10.prod.outlook.com (2603:10b6:208:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 08:34:44 +0000
Received: from CY5PR10MB6011.namprd10.prod.outlook.com
 ([fe80::3aca:a3f6:e92f:782e]) by CY5PR10MB6011.namprd10.prod.outlook.com
 ([fe80::3aca:a3f6:e92f:782e%5]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 08:34:44 +0000
Message-ID: <d146466d-e5b6-450d-8b6c-c27ecc87b310@oracle.com>
Date: Wed, 15 Oct 2025 11:34:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
To: Qing Zhao <qing.zhao@oracle.com>, Kees Cook <kees@kernel.org>
Cc: Claudiu Zissulescu <claziss@gmail.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <20250826042212.work.202-kees@kernel.org>
 <D882BBEB-31E0-48A9-A595-BC5B47EE4899@oracle.com>
Content-Language: en-US
From: Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>
In-Reply-To: <D882BBEB-31E0-48A9-A595-BC5B47EE4899@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0091.eurprd04.prod.outlook.com
 (2603:10a6:803:64::26) To CY5PR10MB6011.namprd10.prod.outlook.com
 (2603:10b6:930:28::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6011:EE_|BLAPR10MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f0dc8a-9fe6-4b8d-a388-08de0bc5b0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUhJVmVhT055eG1qTVNKVGM1OFczY0xIaDhRK0VLcThaeFcxYzlubmV0ZVVz?=
 =?utf-8?B?MnF5YWdGRHp3WDJrU1Bjc0d0ZVIyUmQ0ZGNLR3IzMEl3TmMvem5pc3p0RXky?=
 =?utf-8?B?Y3NmaXMyam1ocWJoSDJyODR3TzBpUDZqNEdZZHQ5THVIWFdRVFhZdmo4YXZt?=
 =?utf-8?B?UU1aU3dEN1RzTUlGUEVGVitJSHNwQ2VPcmloZ3g5emtvOU54U0dsS3pyZGZL?=
 =?utf-8?B?dEt1SWxNY0pSSVdFMW80U2JjK2RrVDlPeHFhTm05WndxZitIcHJMSGE2L3pi?=
 =?utf-8?B?UEdYRE9tcXNXL1BGQlhNU1V4V0dCWEQwZmUxbU90N2ZDbUEvc3p3dHdsdnJW?=
 =?utf-8?B?MUpFUDJYUzRONGRES0sycVdaNGFNM3RZblQrYlZycWE5ZSt3QzlUMEFwVitO?=
 =?utf-8?B?R1FhYkpBa2RrWWd0dkQ5QVlHeDlVTXIyZEl0ZGdrL3JnUHc2cWJwMnEvRWRK?=
 =?utf-8?B?dDNHTzUrWFJtMEZGN21Hb3JFYW5GZkhScHJMQWhzZjE2cmp2WHJMQXY1T2VV?=
 =?utf-8?B?aHVaaENwZWloZVdmK3dxQWlNcUpnVjdZT1NQUWdldWp3YTVublJLSmE4Tysy?=
 =?utf-8?B?UnJLTjlPRXJXcGdwd1pWblQ2dFAvdXY4dnVITVJ3Nk5uQ21YdGxvbEFRWk5U?=
 =?utf-8?B?VHJUbG56Z1BUUW9pTnUzMHpzdEt0QTJtV1dteWJGVHNIYXVxVTR5d0V0L0tl?=
 =?utf-8?B?ZVIwamh1QnV3QTNpa0hLc0U5c3Znbml0Zk9VNjRzOHFPVndrdng0aUFOSTBU?=
 =?utf-8?B?aER0SkhMSUtJN0JqYWtoazcvUzF5K1AzU25tRzUxMEprWmhuN0JCcW9FNXB1?=
 =?utf-8?B?MWJLYk9KZ2dlR2xFKzdKNnF3SlNEZ3NkMDNkSzVlRm5vUWpNYU00eGpYMzRC?=
 =?utf-8?B?MVc5YkN0UWZwMlRQQXNicmxuVWVYUDdBem01Wk9sNkt6ZFlRQzh3ZTJDVTl3?=
 =?utf-8?B?UzkxMzN1dlpzbEREeWFkSjNFTFZKRVY4RkI4M1lBSUdDTkV5WUFPSmt1Yklv?=
 =?utf-8?B?NFo4czhTQ0E4VVRTZzhhWWFBN1hxdlhWSHRLRHp5YmVIUDdVck5PNlpXSW05?=
 =?utf-8?B?a001THk5L29LNVl6VUJBTjg0RjV3T1hyY0dJVkFvdWgwSTBab21KRk14VFd4?=
 =?utf-8?B?NE9TcGtuZ0ZZSS9EelQ3Si94VXp4aXR3OUwvYkppZ1VWUVNkeGMvWjBEd1pX?=
 =?utf-8?B?RHdFVVJOZHBPcXZEYW42TFZrNlpRSHFKYVl3bWtZN2pDUlJ4dzFES1pUL1dq?=
 =?utf-8?B?K241bHFwWjdXUzJaZVQreHFSU2I0MVpIZGdkVCthV2pMeWtLTHVHMm94eFN2?=
 =?utf-8?B?VWlRWHBCYUQ4V3Q0d3BHbnNFeTJXb1FCU3FJUURxZGtUcnE1NU56TW9wUCt3?=
 =?utf-8?B?RCthKzZIcHlTdGYxQVpqZmhkNEYraE16eW5pemFON1R5Rm1ZSm1GYTMwR2Ry?=
 =?utf-8?B?cUZqNEhiWERQN1YrSDFZekxvZEZNR0NNRVFEMW9oTW90WDRkd1lBeG5YV0FY?=
 =?utf-8?B?d1hVOUZYU0svR0JsM1V1WG1YRU4yUGs3dDBZWVJpLzBRZW5kM2FQSjBxdHEy?=
 =?utf-8?B?OW5aOXNoNkxMR1d6WjI4MGFhVDZXNGd2NVoyVzFjUmJ2Z01WZ3VLWnUydWw2?=
 =?utf-8?B?NE9GWEUyQmt2Wnl3ZlpPY0lnYzl4OXZqcndRdFFhUm5ENTBFZVUzdG45UGpJ?=
 =?utf-8?B?TktXUHNRN1NJZXFNNm5uem1oOFNGMjNudHZjMEh4NEhFWCs1ZFBEbTZuSlZF?=
 =?utf-8?B?TlR2TFV2NlVxdVoyTDZvajFSL2lLR1l1NFBEZVIzWFIvdGpiZ0xYNTdBRTh6?=
 =?utf-8?B?T2w5MjBNWm5xRFJzZE1qc3JiYTlKVSs2b2tZN3M0R3EzS0d2UGNNbGtWb1Mz?=
 =?utf-8?B?WjlpVkc1SmVnVnlIdWlnWHNyZmhoaFJHSldiTW00YlUwVEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUJ5ZVl1Z1JObXJmZ1YyQjRoR2s1SXYvMlBzK0FybGV4TC82N29ST2RScTRs?=
 =?utf-8?B?TVIraDBwSkRHZHV3YkpWQTJDd2ZZVjVuVjdsK3UzUmdHSmlkanlqa0dmelha?=
 =?utf-8?B?NzJzSEJwelJycCsrcnVEYnpDY2Nld28vdm5teDdJUnJQZEd3YWRqclUvYktj?=
 =?utf-8?B?WEpVaC9EQ3dXeDJ5a1pWZFprcUJmcUtld3B5MS9WZXEvSFplMlpJVHlHZlZ3?=
 =?utf-8?B?SHBHbEFnQk55Q05FUnlGbGRhWnh6MWdJcVY3aDlHSkNoZWVqRWtQZlk4K2Ux?=
 =?utf-8?B?ald5UVRpRXF1ay9GdUtoOVdXTTlEMTRvTzBBNldXR1FvVUNLbDdpRmQzeVd2?=
 =?utf-8?B?Z0FQZXc5clVRcDR0UVRudDMrMkNoU0JTNUVKc05MSVJXQldpdjMwR1JWTjZT?=
 =?utf-8?B?N0dpQ3oxS1RYOEd1MlZ2b04vanRLb1hhZVVNYTZQNmRYUkUrUmVqekJCcVhC?=
 =?utf-8?B?TjhFYUEvSnlFMmczVnhMRi9RdHdxaGdyY0gzTjNpUnlpUTVMSGZKbTdtaStP?=
 =?utf-8?B?SGpQVmc0MDZRaitTdXNwWGNBVVVIZUY1Ni91UTNWT0R5cXJKa0QyUXE5RzIy?=
 =?utf-8?B?MjBnSVNoRHVOUTQvckR5R0duOFMrZWZTaTl6bEh2UFdURGV0amowemlpL2Qx?=
 =?utf-8?B?NWc5a0pXZ2tlcW9MZjNRcGdMM1RLa3NtTS9XdmJhQ1g4eWx2UFBNQjQzTTF2?=
 =?utf-8?B?ejhISVlKR29mbmtaWlVJeFZOdjQ3RmZkeG82YzdKQ1NnUkFXRy9PdkRaWWc1?=
 =?utf-8?B?d0pUaGxmNERveUt3RWxtMlFCbkV4R1ZveXlXem9yaEErM0oyUlovUXBnMytx?=
 =?utf-8?B?MS9zN3ZhZnF5RkhDbWZvdWZBWjlLdGdlOGpzSGlTd2d2eitpaFg0bUFKVEx4?=
 =?utf-8?B?MFRKWThRYVFROTZ5M3hYU3JFTGdrZG1zM21Hb0xNR2NnQ240dmVWaDlPM3dQ?=
 =?utf-8?B?cFROM1lNV2MxRjN6TG1PWXpaeDlUWGtOazMxdW12ODI1UVBpTUxIalZMQjVY?=
 =?utf-8?B?V2tyUnVOVGJHSWhFYUU3cFBLQzlOcmsvdnNERVZiRmtjZzNYUTFibzVyWm5L?=
 =?utf-8?B?L0t6RXVOUVcyeSt1WlQxZXBlekVDQWtvT1ZRai9RME9KOUxXZ3VEdEFYYitq?=
 =?utf-8?B?MmJBUG9TR3Z0em1WMDB6VjlORk80WFI4NVdVU0xPd2tQbWJKMWNBMlhVUkFS?=
 =?utf-8?B?VVUxS3hlODZVS2k3WHZSZUZOL0tSVGNydmEzUFFMMFE3ZkIwSmZmSTdjR3J0?=
 =?utf-8?B?VklzcGRPUXBqQlFPZ2lvbjdVSzZwQ1hQTWtEOVNCZjkreFRvdWpqbDF2SSsy?=
 =?utf-8?B?aWVjKzc0RjY2N0IrWGNLdUk1Qi9FTjlpVDRlaXJhMDVrT25oNEVhZXhvQVJS?=
 =?utf-8?B?dDNxVG1RYkQ1NGtPdkJ5eXVGdmdIaURnSm83RGlWVXlZajdFdHczZ3d3NFZD?=
 =?utf-8?B?czVLT3RXc3lvVmJ6Y3lRa0tKdkhPQkV1K3FtV0xDaXJkQThNQ1hyb3JNRjdG?=
 =?utf-8?B?VFdQTy9FOXFldmRWZGM0TjkvSVNnZE5lV1lodWtRQXNhVUFPcnJQcCtCQVZh?=
 =?utf-8?B?QUIwYkVwNkw5UkJtUDdScWZnTk0yZFhHaXMyMDRlVE5HYUx6bGVlbWdQWEZO?=
 =?utf-8?B?aGFkQVU4R3Y0cUVXejh2dGZqQ0cyNW5HYVdrU0s5WmU2ZnZFZXZqeVY2QStZ?=
 =?utf-8?B?aERLc3dFZThlN3JFR0g3WU9xRWRVZkNSVFpYUjFNL2VrSXJzbmN0bkQ0YjYv?=
 =?utf-8?B?c1ZJb2J6YWJob3AzSFJhNUhTSWdWUEh2YS9qSVQyNlJmb2xmT280eW9hRDZn?=
 =?utf-8?B?eXJYMk1yT0Z4WTA1S1U2ZXVnbGszeFR5K3JFK09rSVNINHhRT0ZUWld3SVFB?=
 =?utf-8?B?UmdBSmQzMFhIYVRmT1hHY0t1K3pwMi85NGEwSkN6QmtacE1OSlRMSS94dUtD?=
 =?utf-8?B?RUxmcFN0UC9FN20rU0EzTDZPT2JINjVvWTBTMHQzemJUZnc3cGJOSUUyUUhu?=
 =?utf-8?B?THI5dXpXSm9TWWQyZEFPV2NpVmZPbk5uZjl0QW5zMXBEVzJxYW9QNnYvOXV6?=
 =?utf-8?B?bmJVNXNOaEl5OEdKWmJMcHZsRnRCeUpDeVFiKzA4L08yVWVvUmZIMTdxRW9t?=
 =?utf-8?B?UXd5VDNucFcwWHB2WDNGdy8xTHVZZ3hVbmtZNWVTS2NhQXE4OEk5d1FiaHAv?=
 =?utf-8?Q?GAIAm4XQ9UYrBwYs1LOIhXumQCQteaURp4aCZRy3aTl5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+pVf5gBRngA4an4ozdqLKZIaFQRSOPOCDr2RD9ZpdsY8aHk+OSLUSYxZrW3LZb7l9Y9enE/LMKHZ8h16++Tk3kplHGQ7hekAiSvawYIdEe2Ysn5rxZWaniz1i+N6OuIWgi6QCdQdGWOemjh73QiZFryU8SCNyc8w3P424ih9bmSOafa/3SfuR7WYWebzDzv1Gqugc2snEWWyEKME7PzMZbbb4oY2dFr83TI9qpDue6DPUDR7LqAFo5evCs45cnI9JRZ7xzAPAANYQ3tFDE2VowjOpxJRa4Se1matKWi6hBCKQg7vo5qd0dl6sGd5dzF9DPA8GhOJtVoFqKRse8gFfcbK0p2qE9ttSwLbLgSyQ4nyuV1CmZ84T9sAUbmQXjhgbuFtzSbouuCdRO5BO3s9DBAjuuT/rLflFjExL/FqAsP18kKjmaqvOPMXAeeQgHlFUl7fOg3IsUMai9+HbKXToKoV7w4W43mmTJ6+VJWzt2kUB/kVcS2fTa7X7nNMcx9AHIq/Xv7NSZP2HEgADmuGYeemTQXho0Ea+bTavJJKLLwPgQw080B1/BvLdAdq3vF94Kf5jBRgQGIQCfBmRk1rgzvhB9UPS/dE0QgYbC+fy8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f0dc8a-9fe6-4b8d-a388-08de0bc5b0fc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:34:44.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfJjktiAO9XayVe+WU5S1O5gmtSquaJvgnNlQor3d+ONcwEjVKtTTxs3j3Rm8IhIgK0511fV0GS6E9zbMhizmkQM/ycERuK+OiLRAkcKVC0Y3KY/0QWAs3Fu3D/0ziCV92f7zD4sXLscFtzg2VQ3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150065
X-Proofpoint-GUID: KzdDK0FlNPxdfKzBScSR2Db5FG_a59pP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfXzpA0/aSQTOzX
 tqtUzr2ZB9TcsWtpethB9/lKO//oMDfYxliYWeC8iYX4eqqD8NSybLofP21Up8SdHlUU8AMITTz
 VL+I6VuWsMlWsj50kWGEte9Qmnz8y2j13o3arwSWDFy+3ElrwVNfJZug0/Ih77rJByEiHuh9eWJ
 jgEaq7RJAwwTHlje8qxFQ7Ef/6hO/VcY3xL90CV3bD11tUj+8PD/1ek0yo7MuLLnN8Li4rrYb+v
 CjW3iGf836gyVXLqrpVtGvSkMCpFRRxtT8H9FiRhtK485eMCkqMM29WPRUgZd8xdijx5tiYoh1u
 Djr1zMiMCQSg+xzHyKDGXQu2cWBE3qusqcDlaP5N7wHanOdwCsP3DgNc+/SDairjn5zbebgYvNd
 nUEwwCe59HaXAywYXAlQK4wxvEAcoxfAgf3Me8oCk4lOL2k1hTA=
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68ef5caa b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=vQ6_Ke3Azbx6Dq8yeXsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: KzdDK0FlNPxdfKzBScSR2Db5FG_a59pP

Hi,

Sorry for this delay, my gmail account has marked this patch mail as 
spam and delete it.

LGTM, and thank you for your contribution.

Please let me know if you need my help to apply the patch,
Claudiu

On 10/14/25 11:14 PM, Qing Zhao wrote:
> CC’ing Claudiu’s oracle email account.
> 
> Qing
> 
>> On Aug 26, 2025, at 00:22, Kees Cook <kees@kernel.org> wrote:
>>
>> The ARC builtin functions __builtin_arc_ffs and __builtin_arc_fls
>> perform pure mathematical operations equivalent to the standard
>> GCC __builtin_ffs function, which is marked with the const attribute.
>> However, the ARC target-specific versions were not marked as const,
>> preventing compiler optimizations like common subexpression elimination.
>>
>> Extend the ARC builtin infrastructure to support function attributes
>> and mark the appropriate mathematical builtins as const:
>>
>> - __builtin_arc_ffs: Find first set bit (const)
>> - __builtin_arc_fls: Find last set bit (const)
>> - __builtin_arc_norm: Count leading zeros (const)
>> - __builtin_arc_normw: Count leading zeros for 16-bit (const)
>> - __builtin_arc_swap: Endian swap (const)
>>
>> gcc/ChangeLog:
>>
>> * config/arc/builtins.def: Add ATTRS parameter to DEF_BUILTIN
>> macro calls.  Mark mathematical builtins (FFS, FLS, NORM, NORMW,
>> SWAP) with attr_const, leave others as NULL_TREE.
>> * config/arc/arc.cc: Add support for builtin function attributes.
>> Create attr_const using tree_cons.  Update DEF_BUILTIN macro to
>> pass ATTRS parameter to add_builtin_function.
>>
>> gcc/testsuite/ChangeLog:
>>
>> * gcc.target/arc/builtin_fls_const.c: New test.  Verify that
>> const attribute enables CSE optimization for mathematical ARC
>> builtins by checking that duplicate calls are eliminated and
>> results are optimized to shift operations.
>>
>> Signed-off-by: Kees Cook <kees@kernel.org>
>> ---
>> .../gcc.target/arc/builtin_fls_const.c        |  35 ++
>> gcc/config/arc/arc.cc                         |  11 +-
>> gcc/config/arc/builtins.def                   | 308 +++++++++---------
>> 3 files changed, 197 insertions(+), 157 deletions(-)
>> create mode 100644 gcc/testsuite/gcc.target/arc/builtin_fls_const.c
>>
>> diff --git a/gcc/testsuite/gcc.target/arc/builtin_fls_const.c b/gcc/testsuite/gcc.target/arc/builtin_fls_const.c
>> new file mode 100644
>> index 000000000000..cb1da946d377
>> --- /dev/null
>> +++ b/gcc/testsuite/gcc.target/arc/builtin_fls_const.c
>> @@ -0,0 +1,35 @@
>> +/* Test that const attribute enables CSE optimization for ARC builtins.  */
>> +/* { dg-do compile } */
>> +/* { dg-options "-O2" } */
>> +
>> +int test_fls_cse(int x)
>> +{
>> +  /* Two calls to the same const builtin with same argument should
>> +     be optimized to a single call plus a multiply-by-2 operation.  */
>> +  int a = __builtin_arc_fls(x);
>> +  int b = __builtin_arc_fls(x);
>> +  return a + b;
>> +}
>> +
>> +int test_ffs_cse(int x)
>> +{
>> +  /* Same pattern for __builtin_arc_ffs.  */
>> +  int a = __builtin_arc_ffs(x);
>> +  int b = __builtin_arc_ffs(x);
>> +  return a + b;
>> +}
>> +
>> +int test_norm_cse(int x)
>> +{
>> +  /* Same pattern for __builtin_arc_norm.  */
>> +  int a = __builtin_arc_norm(x);
>> +  int b = __builtin_arc_norm(x);
>> +  return a + b;
>> +}
>> +
>> +/* { dg-final { scan-assembler-times "fls\\s+" 1 } } */
>> +/* { dg-final { scan-assembler-times "ffs\\s+" 1 } } */
>> +/* { dg-final { scan-assembler-times "norm\\s+" 1 } } */
>> +
>> +/* Verify that the result is multiplied by 2 using left shift.  */
>> +/* { dg-final { scan-assembler "asl_s\\s+.*,.*,1" } } */
>> \ No newline at end of file
>> diff --git a/gcc/config/arc/arc.cc b/gcc/config/arc/arc.cc
>> index bb5db977c800..5c34d9c78907 100644
>> --- a/gcc/config/arc/arc.cc
>> +++ b/gcc/config/arc/arc.cc
>> @@ -6705,7 +6705,7 @@ arc_cannot_force_const_mem (machine_mode mode, rtx x)
>>
>> enum arc_builtin_id
>>    {
>> -#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK) \
>> +#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK, ATTRS) \
>>      ARC_BUILTIN_ ## NAME,
>> #include "builtins.def"
>> #undef DEF_BUILTIN
>> @@ -6723,7 +6723,7 @@ struct GTY(()) arc_builtin_description
>> static GTY(()) struct arc_builtin_description
>> arc_bdesc[ARC_BUILTIN_COUNT] =
>> {
>> -#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK) \
>> +#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK, ATTRS) \
>>    { (enum insn_code) CODE_FOR_ ## ICODE, N_ARGS, NULL_TREE },
>> #include "builtins.def"
>> #undef DEF_BUILTIN
>> @@ -6855,8 +6855,11 @@ arc_init_builtins (void)
>>      = build_function_type_list (long_long_integer_type_node,
>> V2SI_type_node, V2HI_type_node, NULL_TREE);
>>
>> +  /* Create const attribute for mathematical functions.  */
>> +  tree attr_const = tree_cons (get_identifier ("const"), NULL, NULL);
>> +
>>    /* Add the builtins.  */
>> -#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK) \
>> +#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK, ATTRS) \
>>    { \
>>      int id = ARC_BUILTIN_ ## NAME; \
>>      const char *Name = "__builtin_arc_" #NAME; \
>> @@ -6866,7 +6869,7 @@ arc_init_builtins (void)
>>      if (MASK) \
>>        arc_bdesc[id].fndecl \
>> = add_builtin_function (arc_tolower(name, Name), TYPE, id, \
>> - BUILT_IN_MD, NULL, NULL_TREE); \
>> + BUILT_IN_MD, NULL, ATTRS); \
>>    }
>> #include "builtins.def"
>> #undef DEF_BUILTIN
>> diff --git a/gcc/config/arc/builtins.def b/gcc/config/arc/builtins.def
>> index e3c57804c84f..ae230dcea749 100644
>> --- a/gcc/config/arc/builtins.def
>> +++ b/gcc/config/arc/builtins.def
>> @@ -20,7 +20,7 @@
>>     builtins defined in the ARC part of the GNU compiler.  Before
>>     including this file, define a macro
>>
>> -   DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK)
>> +   DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK, ATTRS)
>>
>>     NAME:    `__builtin_arc_name' will be the user-level name of the builtin.
>>              `ARC_BUILTIN_NAME' will be the internal builtin's id.
>> @@ -29,194 +29,196 @@
>>     TYPE:    A tree node describing the prototype of the built-in.
>>     ICODE:   Name of attached insn or expander.  If special treatment in arc.cc
>>              is needed to expand the built-in, use `nothing'.
>> -   MASK:    CPU selector mask.  */
>> +   MASK:    CPU selector mask.
>> +   ATTRS:   Function attributes like "attr_const" for the `const' attribute
>> +            or "NULL_TREE" for no attribute.  */
>>
>> /* Special builtins.  */
>> -DEF_BUILTIN (NOP,        0, void_ftype_void,        nothing,     1)
>> -DEF_BUILTIN (RTIE,       0, void_ftype_void,        rtie,        !TARGET_ARC600_FAMILY)
>> -DEF_BUILTIN (SYNC,       0, void_ftype_void,        sync,        1)
>> -DEF_BUILTIN (BRK,        0, void_ftype_void,        brk,         1)
>> -DEF_BUILTIN (SWI,        0, void_ftype_void,        swi,         1)
>> -DEF_BUILTIN (UNIMP_S,    0, void_ftype_void,        unimp_s,     !TARGET_ARC600_FAMILY)
>> -DEF_BUILTIN (TRAP_S,     1, void_ftype_usint,       trap_s,      !TARGET_ARC600_FAMILY)
>> -DEF_BUILTIN (ALIGNED,    2, int_ftype_pcvoid_int,   nothing,     1)
>> -DEF_BUILTIN (CLRI,       0, int_ftype_void,         clri,        TARGET_V2)
>> -DEF_BUILTIN (SLEEP,      1, void_ftype_usint,       sleep,       1)
>> -
>> -DEF_BUILTIN (FLAG,       1, void_ftype_usint,       flag,       1)
>> -DEF_BUILTIN (SR,         2, void_ftype_usint_usint, sr,         1)
>> -DEF_BUILTIN (KFLAG,      1, void_ftype_usint,       kflag,      TARGET_V2)
>> -DEF_BUILTIN (CORE_WRITE, 2, void_ftype_usint_usint, core_write, 1)
>> -DEF_BUILTIN (SETI,       1, void_ftype_int,         seti,       TARGET_V2)
>> +DEF_BUILTIN (NOP,        0, void_ftype_void,        nothing,     1, NULL_TREE)
>> +DEF_BUILTIN (RTIE,       0, void_ftype_void,        rtie,        !TARGET_ARC600_FAMILY, NULL_TREE)
>> +DEF_BUILTIN (SYNC,       0, void_ftype_void,        sync,        1, NULL_TREE)
>> +DEF_BUILTIN (BRK,        0, void_ftype_void,        brk,         1, NULL_TREE)
>> +DEF_BUILTIN (SWI,        0, void_ftype_void,        swi,         1, NULL_TREE)
>> +DEF_BUILTIN (UNIMP_S,    0, void_ftype_void,        unimp_s,     !TARGET_ARC600_FAMILY, NULL_TREE)
>> +DEF_BUILTIN (TRAP_S,     1, void_ftype_usint,       trap_s,      !TARGET_ARC600_FAMILY, NULL_TREE)
>> +DEF_BUILTIN (ALIGNED,    2, int_ftype_pcvoid_int,   nothing,     1, NULL_TREE)
>> +DEF_BUILTIN (CLRI,       0, int_ftype_void,         clri,        TARGET_V2, NULL_TREE)
>> +DEF_BUILTIN (SLEEP,      1, void_ftype_usint,       sleep,       1, NULL_TREE)
>> +
>> +DEF_BUILTIN (FLAG,       1, void_ftype_usint,       flag,       1, NULL_TREE)
>> +DEF_BUILTIN (SR,         2, void_ftype_usint_usint, sr,         1, NULL_TREE)
>> +DEF_BUILTIN (KFLAG,      1, void_ftype_usint,       kflag,      TARGET_V2, NULL_TREE)
>> +DEF_BUILTIN (CORE_WRITE, 2, void_ftype_usint_usint, core_write, 1, NULL_TREE)
>> +DEF_BUILTIN (SETI,       1, void_ftype_int,         seti,       TARGET_V2, NULL_TREE)
>>
>> /* Regular builtins.  */
>> -DEF_BUILTIN (NORM,       1, int_ftype_int,     clrsbsi2,      TARGET_NORM)
>> -DEF_BUILTIN (NORMW,      1, int_ftype_short,   normw,         TARGET_NORM)
>> -DEF_BUILTIN (SWAP,       1, int_ftype_int,     rotlsi2_cnt16, TARGET_SWAP)
>> -DEF_BUILTIN (DIVAW,      2, int_ftype_int_int, divaw,         TARGET_EA_SET)
>> -DEF_BUILTIN (CORE_READ,  1, usint_ftype_usint, core_read,     1)
>> -DEF_BUILTIN (LR,         1, usint_ftype_usint, lr,            1)
>> -DEF_BUILTIN (FFS,        1, int_ftype_int,     ffs,           (TARGET_EM && TARGET_NORM) || TARGET_HS)
>> -DEF_BUILTIN (FLS,        1, int_ftype_int,     fls,           (TARGET_EM && TARGET_NORM) || TARGET_HS)
>> +DEF_BUILTIN (NORM,       1, int_ftype_int,     clrsbsi2,      TARGET_NORM, attr_const)
>> +DEF_BUILTIN (NORMW,      1, int_ftype_short,   normw,         TARGET_NORM, attr_const)
>> +DEF_BUILTIN (SWAP,       1, int_ftype_int,     rotlsi2_cnt16, TARGET_SWAP, attr_const)
>> +DEF_BUILTIN (DIVAW,      2, int_ftype_int_int, divaw,         TARGET_EA_SET, NULL_TREE)
>> +DEF_BUILTIN (CORE_READ,  1, usint_ftype_usint, core_read,     1, NULL_TREE)
>> +DEF_BUILTIN (LR,         1, usint_ftype_usint, lr,            1, NULL_TREE)
>> +DEF_BUILTIN (FFS,        1, int_ftype_int,     ffs,           (TARGET_EM && TARGET_NORM) || TARGET_HS, attr_const)
>> +DEF_BUILTIN (FLS,        1, int_ftype_int,     fls,           (TARGET_EM && TARGET_NORM) || TARGET_HS, attr_const)
>>
>> /* ARC SIMD extenssion.  */
>> /* BEGIN SIMD marker.  */
>> -DEF_BUILTIN (SIMD_BEGIN, 0, void_ftype_void, nothing, 0)
>> -
>> -DEF_BUILTIN ( VADDAW, 2, v8hi_ftype_v8hi_v8hi,  vaddaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VADDW, 2, v8hi_ftype_v8hi_v8hi,   vaddw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VAVB, 2, v8hi_ftype_v8hi_v8hi,    vavb_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VAVRB, 2, v8hi_ftype_v8hi_v8hi,   vavrb_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VDIFAW, 2, v8hi_ftype_v8hi_v8hi,  vdifaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VDIFW, 2, v8hi_ftype_v8hi_v8hi,   vdifw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMAXAW, 2, v8hi_ftype_v8hi_v8hi,  vmaxaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMAXW, 2, v8hi_ftype_v8hi_v8hi,   vmaxw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMINAW, 2, v8hi_ftype_v8hi_v8hi,  vminaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMINW, 2, v8hi_ftype_v8hi_v8hi,   vminw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMULAW, 2, v8hi_ftype_v8hi_v8hi,  vmulaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VMULFAW, 2, v8hi_ftype_v8hi_v8hi, vmulfaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMULFW, 2, v8hi_ftype_v8hi_v8hi,  vmulfw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMULW, 2, v8hi_ftype_v8hi_v8hi,   vmulw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VSUBAW, 2, v8hi_ftype_v8hi_v8hi,  vsubaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VSUBW, 2, v8hi_ftype_v8hi_v8hi,   vsubw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VSUMMW, 2, v8hi_ftype_v8hi_v8hi,  vsummw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VAND, 2, v8hi_ftype_v8hi_v8hi,    vand_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VANDAW, 2, v8hi_ftype_v8hi_v8hi,  vandaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VBIC, 2, v8hi_ftype_v8hi_v8hi,    vbic_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VBICAW, 2, v8hi_ftype_v8hi_v8hi,  vbicaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (    VOR, 2, v8hi_ftype_v8hi_v8hi,     vor_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VXOR, 2, v8hi_ftype_v8hi_v8hi,    vxor_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VXORAW, 2, v8hi_ftype_v8hi_v8hi,  vxoraw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VEQW, 2, v8hi_ftype_v8hi_v8hi,    veqw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VLEW, 2, v8hi_ftype_v8hi_v8hi,    vlew_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VLTW, 2, v8hi_ftype_v8hi_v8hi,    vltw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VNEW, 2, v8hi_ftype_v8hi_v8hi,    vnew_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMR1AW, 2, v8hi_ftype_v8hi_v8hi,  vmr1aw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMR1W, 2, v8hi_ftype_v8hi_v8hi,   vmr1w_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMR2AW, 2, v8hi_ftype_v8hi_v8hi,  vmr2aw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMR2W, 2, v8hi_ftype_v8hi_v8hi,   vmr2w_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMR3AW, 2, v8hi_ftype_v8hi_v8hi,  vmr3aw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMR3W, 2, v8hi_ftype_v8hi_v8hi,   vmr3w_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMR4AW, 2, v8hi_ftype_v8hi_v8hi,  vmr4aw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMR4W, 2, v8hi_ftype_v8hi_v8hi,   vmr4w_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMR5AW, 2, v8hi_ftype_v8hi_v8hi,  vmr5aw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMR5W, 2, v8hi_ftype_v8hi_v8hi,   vmr5w_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMR6AW, 2, v8hi_ftype_v8hi_v8hi,  vmr6aw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMR6W, 2, v8hi_ftype_v8hi_v8hi,   vmr6w_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMR7AW, 2, v8hi_ftype_v8hi_v8hi,  vmr7aw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMR7W, 2, v8hi_ftype_v8hi_v8hi,   vmr7w_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VMRB, 2, v8hi_ftype_v8hi_v8hi,    vmrb_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VH264F, 2, v8hi_ftype_v8hi_v8hi,  vh264f_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VH264FT, 2, v8hi_ftype_v8hi_v8hi, vh264ft_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VH264FW, 2, v8hi_ftype_v8hi_v8hi, vh264fw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VVC1F, 2, v8hi_ftype_v8hi_v8hi,   vvc1f_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VVC1FT, 2, v8hi_ftype_v8hi_v8hi,  vvc1ft_insn, TARGET_SIMD_SET)
>> -
>> -DEF_BUILTIN ( VBADDW, 2, v8hi_ftype_v8hi_int,  vbaddw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VBMAXW, 2, v8hi_ftype_v8hi_int,  vbmaxw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VBMINW, 2, v8hi_ftype_v8hi_int,  vbminw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VBMULAW, 2, v8hi_ftype_v8hi_int, vbmulaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VBMULFW, 2, v8hi_ftype_v8hi_int, vbmulfw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VBMULW, 2, v8hi_ftype_v8hi_int,  vbmulw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VBRSUBW, 2, v8hi_ftype_v8hi_int, vbrsubw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VBSUBW, 2, v8hi_ftype_v8hi_int,  vbsubw_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (SIMD_BEGIN, 0, void_ftype_void, nothing, 0, NULL_TREE)
>> +
>> +DEF_BUILTIN ( VADDAW, 2, v8hi_ftype_v8hi_v8hi,  vaddaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VADDW, 2, v8hi_ftype_v8hi_v8hi,   vaddw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VAVB, 2, v8hi_ftype_v8hi_v8hi,    vavb_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VAVRB, 2, v8hi_ftype_v8hi_v8hi,   vavrb_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VDIFAW, 2, v8hi_ftype_v8hi_v8hi,  vdifaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VDIFW, 2, v8hi_ftype_v8hi_v8hi,   vdifw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMAXAW, 2, v8hi_ftype_v8hi_v8hi,  vmaxaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMAXW, 2, v8hi_ftype_v8hi_v8hi,   vmaxw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMINAW, 2, v8hi_ftype_v8hi_v8hi,  vminaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMINW, 2, v8hi_ftype_v8hi_v8hi,   vminw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMULAW, 2, v8hi_ftype_v8hi_v8hi,  vmulaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VMULFAW, 2, v8hi_ftype_v8hi_v8hi, vmulfaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMULFW, 2, v8hi_ftype_v8hi_v8hi,  vmulfw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMULW, 2, v8hi_ftype_v8hi_v8hi,   vmulw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VSUBAW, 2, v8hi_ftype_v8hi_v8hi,  vsubaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VSUBW, 2, v8hi_ftype_v8hi_v8hi,   vsubw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VSUMMW, 2, v8hi_ftype_v8hi_v8hi,  vsummw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VAND, 2, v8hi_ftype_v8hi_v8hi,    vand_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VANDAW, 2, v8hi_ftype_v8hi_v8hi,  vandaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VBIC, 2, v8hi_ftype_v8hi_v8hi,    vbic_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VBICAW, 2, v8hi_ftype_v8hi_v8hi,  vbicaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (    VOR, 2, v8hi_ftype_v8hi_v8hi,     vor_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VXOR, 2, v8hi_ftype_v8hi_v8hi,    vxor_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VXORAW, 2, v8hi_ftype_v8hi_v8hi,  vxoraw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VEQW, 2, v8hi_ftype_v8hi_v8hi,    veqw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VLEW, 2, v8hi_ftype_v8hi_v8hi,    vlew_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VLTW, 2, v8hi_ftype_v8hi_v8hi,    vltw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VNEW, 2, v8hi_ftype_v8hi_v8hi,    vnew_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMR1AW, 2, v8hi_ftype_v8hi_v8hi,  vmr1aw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMR1W, 2, v8hi_ftype_v8hi_v8hi,   vmr1w_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMR2AW, 2, v8hi_ftype_v8hi_v8hi,  vmr2aw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMR2W, 2, v8hi_ftype_v8hi_v8hi,   vmr2w_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMR3AW, 2, v8hi_ftype_v8hi_v8hi,  vmr3aw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMR3W, 2, v8hi_ftype_v8hi_v8hi,   vmr3w_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMR4AW, 2, v8hi_ftype_v8hi_v8hi,  vmr4aw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMR4W, 2, v8hi_ftype_v8hi_v8hi,   vmr4w_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMR5AW, 2, v8hi_ftype_v8hi_v8hi,  vmr5aw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMR5W, 2, v8hi_ftype_v8hi_v8hi,   vmr5w_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMR6AW, 2, v8hi_ftype_v8hi_v8hi,  vmr6aw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMR6W, 2, v8hi_ftype_v8hi_v8hi,   vmr6w_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMR7AW, 2, v8hi_ftype_v8hi_v8hi,  vmr7aw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMR7W, 2, v8hi_ftype_v8hi_v8hi,   vmr7w_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VMRB, 2, v8hi_ftype_v8hi_v8hi,    vmrb_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VH264F, 2, v8hi_ftype_v8hi_v8hi,  vh264f_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VH264FT, 2, v8hi_ftype_v8hi_v8hi, vh264ft_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VH264FW, 2, v8hi_ftype_v8hi_v8hi, vh264fw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VVC1F, 2, v8hi_ftype_v8hi_v8hi,   vvc1f_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VVC1FT, 2, v8hi_ftype_v8hi_v8hi,  vvc1ft_insn, TARGET_SIMD_SET, NULL_TREE)
>> +
>> +DEF_BUILTIN ( VBADDW, 2, v8hi_ftype_v8hi_int,  vbaddw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VBMAXW, 2, v8hi_ftype_v8hi_int,  vbmaxw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VBMINW, 2, v8hi_ftype_v8hi_int,  vbminw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VBMULAW, 2, v8hi_ftype_v8hi_int, vbmulaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VBMULFW, 2, v8hi_ftype_v8hi_int, vbmulfw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VBMULW, 2, v8hi_ftype_v8hi_int,  vbmulw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VBRSUBW, 2, v8hi_ftype_v8hi_int, vbrsubw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VBSUBW, 2, v8hi_ftype_v8hi_int,  vbsubw_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* Va, Vb, Ic instructions.  */
>> -DEF_BUILTIN ( VASRW, 2, v8hi_ftype_v8hi_int,  vasrw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VSR8, 2, v8hi_ftype_v8hi_int,   vsr8_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VSR8AW, 2, v8hi_ftype_v8hi_int, vsr8aw_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN ( VASRW, 2, v8hi_ftype_v8hi_int,  vasrw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VSR8, 2, v8hi_ftype_v8hi_int,   vsr8_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VSR8AW, 2, v8hi_ftype_v8hi_int, vsr8aw_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* Va, Vb, u6 instructions.  */
>> -DEF_BUILTIN (  VASRRWi, 2, v8hi_ftype_v8hi_int,   vasrrwi_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VASRSRWi, 2, v8hi_ftype_v8hi_int,  vasrsrwi_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VASRWi, 2, v8hi_ftype_v8hi_int,    vasrwi_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VASRPWBi, 2, v8hi_ftype_v8hi_int,  vasrpwbi_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VASRRPWBi, 2, v8hi_ftype_v8hi_int, vasrrpwbi_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VSR8AWi, 2, v8hi_ftype_v8hi_int,   vsr8awi_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (    VSR8i, 2, v8hi_ftype_v8hi_int,     vsr8i_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (  VASRRWi, 2, v8hi_ftype_v8hi_int,   vasrrwi_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VASRSRWi, 2, v8hi_ftype_v8hi_int,  vasrsrwi_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VASRWi, 2, v8hi_ftype_v8hi_int,    vasrwi_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VASRPWBi, 2, v8hi_ftype_v8hi_int,  vasrpwbi_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VASRRPWBi, 2, v8hi_ftype_v8hi_int, vasrrpwbi_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VSR8AWi, 2, v8hi_ftype_v8hi_int,   vsr8awi_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (    VSR8i, 2, v8hi_ftype_v8hi_int,     vsr8i_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* Va, Vb, u8 (simm) instructions.  */
>> -DEF_BUILTIN (  VMVAW, 2, v8hi_ftype_v8hi_int,   vmvaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VMVW, 2, v8hi_ftype_v8hi_int,    vmvw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VMVZW, 2, v8hi_ftype_v8hi_int,   vmvzw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VD6TAPF, 2, v8hi_ftype_v8hi_int, vd6tapf_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (  VMVAW, 2, v8hi_ftype_v8hi_int,   vmvaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VMVW, 2, v8hi_ftype_v8hi_int,    vmvw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VMVZW, 2, v8hi_ftype_v8hi_int,   vmvzw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VD6TAPF, 2, v8hi_ftype_v8hi_int, vd6tapf_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* Va, rlimm, u8 (simm) instructions.  */
>> -DEF_BUILTIN (VMOVAW, 2, v8hi_ftype_int_int, vmovaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VMOVW, 2, v8hi_ftype_int_int,  vmovw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VMOVZW, 2, v8hi_ftype_int_int, vmovzw_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (VMOVAW, 2, v8hi_ftype_int_int, vmovaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VMOVW, 2, v8hi_ftype_int_int,  vmovw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VMOVZW, 2, v8hi_ftype_int_int, vmovzw_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* Va, Vb instructions.  */
>> -DEF_BUILTIN ( VABSAW, 1, v8hi_ftype_v8hi,  vabsaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VABSW, 1, v8hi_ftype_v8hi,   vabsw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VADDSUW, 1, v8hi_ftype_v8hi, vaddsuw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VSIGNW, 1, v8hi_ftype_v8hi,  vsignw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VEXCH1, 1, v8hi_ftype_v8hi,  vexch1_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VEXCH2, 1, v8hi_ftype_v8hi,  vexch2_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VEXCH4, 1, v8hi_ftype_v8hi,  vexch4_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VUPBAW, 1, v8hi_ftype_v8hi,  vupbaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VUPBW, 1, v8hi_ftype_v8hi,   vupbw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VUPSBAW, 1, v8hi_ftype_v8hi, vupsbaw_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VUPSBW, 1, v8hi_ftype_v8hi,  vupsbw_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN ( VABSAW, 1, v8hi_ftype_v8hi,  vabsaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VABSW, 1, v8hi_ftype_v8hi,   vabsw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VADDSUW, 1, v8hi_ftype_v8hi, vaddsuw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VSIGNW, 1, v8hi_ftype_v8hi,  vsignw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VEXCH1, 1, v8hi_ftype_v8hi,  vexch1_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VEXCH2, 1, v8hi_ftype_v8hi,  vexch2_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VEXCH4, 1, v8hi_ftype_v8hi,  vexch4_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VUPBAW, 1, v8hi_ftype_v8hi,  vupbaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VUPBW, 1, v8hi_ftype_v8hi,   vupbw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VUPSBAW, 1, v8hi_ftype_v8hi, vupsbaw_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VUPSBW, 1, v8hi_ftype_v8hi,  vupsbw_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* SIMD special DIb, rlimm, rlimm instructions.  */
>> -DEF_BUILTIN (VDIRUN, 2, void_ftype_int_int, vdirun_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VDORUN, 2, void_ftype_int_int, vdorun_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (VDIRUN, 2, void_ftype_int_int, vdirun_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VDORUN, 2, void_ftype_int_int, vdorun_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* SIMD special DIb, limm, rlimm instructions.  */
>> -DEF_BUILTIN (VDIWR, 2, void_ftype_int_int, vdiwr_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VDOWR, 2, void_ftype_int_int, vdowr_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (VDIWR, 2, void_ftype_int_int, vdiwr_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VDOWR, 2, void_ftype_int_int, vdowr_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* rlimm instructions.  */
>> -DEF_BUILTIN (   VREC, 1, void_ftype_int,    vrec_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (   VRUN, 1, void_ftype_int,    vrun_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VRECRUN, 1, void_ftype_int, vrecrun_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VENDREC, 1, void_ftype_int, vendrec_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (   VREC, 1, void_ftype_int,    vrec_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (   VRUN, 1, void_ftype_int,    vrun_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VRECRUN, 1, void_ftype_int, vrecrun_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VENDREC, 1, void_ftype_int, vendrec_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* Va, [Ib,u8] instructions.  */
>> -DEF_BUILTIN (VLD32WH, 3, v8hi_ftype_v8hi_int_int, vld32wh_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VLD32WL, 3, v8hi_ftype_v8hi_int_int, vld32wl_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VLD64, 3, v8hi_ftype_v8hi_int_int,   vld64_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (  VLD32, 3, v8hi_ftype_v8hi_int_int,   vld32_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (VLD32WH, 3, v8hi_ftype_v8hi_int_int, vld32wh_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VLD32WL, 3, v8hi_ftype_v8hi_int_int, vld32wl_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VLD64, 3, v8hi_ftype_v8hi_int_int,   vld64_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (  VLD32, 3, v8hi_ftype_v8hi_int_int,   vld32_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> -DEF_BUILTIN (VLD64W, 2, v8hi_ftype_int_int,      vld64w_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VLD128, 2, v8hi_ftype_int_int,      vld128_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (VLD64W, 2, v8hi_ftype_int_int,      vld64w_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VLD128, 2, v8hi_ftype_int_int,      vld128_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> -DEF_BUILTIN (VST128, 3, void_ftype_v8hi_int_int, vst128_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN ( VST64, 3, void_ftype_v8hi_int_int,  vst64_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (VST128, 3, void_ftype_v8hi_int_int, vst128_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN ( VST64, 3, void_ftype_v8hi_int_int,  vst64_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* Va, [Ib, u8] instructions.  */
>> -DEF_BUILTIN (VST16_N, 4, void_ftype_v8hi_int_int_int, vst16_n_insn, TARGET_SIMD_SET)
>> -DEF_BUILTIN (VST32_N, 4, void_ftype_v8hi_int_int_int, vst32_n_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (VST16_N, 4, void_ftype_v8hi_int_int_int, vst16_n_insn, TARGET_SIMD_SET, NULL_TREE)
>> +DEF_BUILTIN (VST32_N, 4, void_ftype_v8hi_int_int_int, vst32_n_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> -DEF_BUILTIN (VINTI, 1, void_ftype_int, vinti_insn, TARGET_SIMD_SET)
>> +DEF_BUILTIN (VINTI, 1, void_ftype_int, vinti_insn, TARGET_SIMD_SET, NULL_TREE)
>>
>> /* END SIMD marker.  */
>> -DEF_BUILTIN (SIMD_END, 0, void_ftype_void, nothing, 0)
>> +DEF_BUILTIN (SIMD_END, 0, void_ftype_void, nothing, 0, NULL_TREE)
>>
>> /* ARCv2 SIMD instructions that use/clobber the accumulator reg.  */
>> -DEF_BUILTIN (QMACH,      2, long_ftype_v4hi_v4hi,   qmach,      TARGET_PLUS_QMACW)
>> -DEF_BUILTIN (QMACHU,     2, long_ftype_v4hi_v4hi,   qmachu,     TARGET_PLUS_QMACW)
>> -DEF_BUILTIN (QMPYH,      2, long_ftype_v4hi_v4hi,   qmpyh,      TARGET_PLUS_QMACW)
>> -DEF_BUILTIN (QMPYHU,     2, long_ftype_v4hi_v4hi,   qmpyhu,     TARGET_PLUS_QMACW)
>> +DEF_BUILTIN (QMACH,      2, long_ftype_v4hi_v4hi,   qmach,      TARGET_PLUS_QMACW, NULL_TREE)
>> +DEF_BUILTIN (QMACHU,     2, long_ftype_v4hi_v4hi,   qmachu,     TARGET_PLUS_QMACW, NULL_TREE)
>> +DEF_BUILTIN (QMPYH,      2, long_ftype_v4hi_v4hi,   qmpyh,      TARGET_PLUS_QMACW, NULL_TREE)
>> +DEF_BUILTIN (QMPYHU,     2, long_ftype_v4hi_v4hi,   qmpyhu,     TARGET_PLUS_QMACW, NULL_TREE)
>>
>> -DEF_BUILTIN (DMACH,      2, int_ftype_v2hi_v2hi,    dmach,      TARGET_PLUS_DMPY)
>> -DEF_BUILTIN (DMACHU,     2, int_ftype_v2hi_v2hi,    dmachu,     TARGET_PLUS_DMPY)
>> -DEF_BUILTIN (DMPYH,      2, int_ftype_v2hi_v2hi,    dmpyh,      TARGET_PLUS_DMPY)
>> -DEF_BUILTIN (DMPYHU,     2, int_ftype_v2hi_v2hi,    dmpyhu,     TARGET_PLUS_DMPY)
>> +DEF_BUILTIN (DMACH,      2, int_ftype_v2hi_v2hi,    dmach,      TARGET_PLUS_DMPY, NULL_TREE)
>> +DEF_BUILTIN (DMACHU,     2, int_ftype_v2hi_v2hi,    dmachu,     TARGET_PLUS_DMPY, NULL_TREE)
>> +DEF_BUILTIN (DMPYH,      2, int_ftype_v2hi_v2hi,    dmpyh,      TARGET_PLUS_DMPY, NULL_TREE)
>> +DEF_BUILTIN (DMPYHU,     2, int_ftype_v2hi_v2hi,    dmpyhu,     TARGET_PLUS_DMPY, NULL_TREE)
>>
>> -DEF_BUILTIN (DMACWH,     2, long_ftype_v2si_v2hi,   dmacwh,     TARGET_PLUS_QMACW)
>> -DEF_BUILTIN (DMACWHU,    2, long_ftype_v2si_v2hi,   dmacwhu,    TARGET_PLUS_QMACW)
>> +DEF_BUILTIN (DMACWH,     2, long_ftype_v2si_v2hi,   dmacwh,     TARGET_PLUS_QMACW, NULL_TREE)
>> +DEF_BUILTIN (DMACWHU,    2, long_ftype_v2si_v2hi,   dmacwhu,    TARGET_PLUS_QMACW, NULL_TREE)
>>
>> -DEF_BUILTIN (VMAC2H,     2, v2si_ftype_v2hi_v2hi,   vmac2h,     TARGET_PLUS_MACD)
>> -DEF_BUILTIN (VMAC2HU,    2, v2si_ftype_v2hi_v2hi,   vmac2hu,    TARGET_PLUS_MACD)
>> -DEF_BUILTIN (VMPY2H,     2, v2si_ftype_v2hi_v2hi,   vmpy2h,     TARGET_PLUS_MACD)
>> -DEF_BUILTIN (VMPY2HU,    2, v2si_ftype_v2hi_v2hi,   vmpy2hu,    TARGET_PLUS_MACD)
>> +DEF_BUILTIN (VMAC2H,     2, v2si_ftype_v2hi_v2hi,   vmac2h,     TARGET_PLUS_MACD, NULL_TREE)
>> +DEF_BUILTIN (VMAC2HU,    2, v2si_ftype_v2hi_v2hi,   vmac2hu,    TARGET_PLUS_MACD, NULL_TREE)
>> +DEF_BUILTIN (VMPY2H,     2, v2si_ftype_v2hi_v2hi,   vmpy2h,     TARGET_PLUS_MACD, NULL_TREE)
>> +DEF_BUILTIN (VMPY2HU,    2, v2si_ftype_v2hi_v2hi,   vmpy2hu,    TARGET_PLUS_MACD, NULL_TREE)
>>
>> /* Combined add/sub HS SIMD instructions.  */
>> -DEF_BUILTIN (VADDSUB2H,  2, v2hi_ftype_v2hi_v2hi,   addsubv2hi3, TARGET_PLUS_DMPY)
>> -DEF_BUILTIN (VSUBADD2H,  2, v2hi_ftype_v2hi_v2hi,   subaddv2hi3, TARGET_PLUS_DMPY)
>> -DEF_BUILTIN (VADDSUB,    2, v2si_ftype_v2si_v2si,   addsubv2si3, TARGET_PLUS_QMACW)
>> -DEF_BUILTIN (VSUBADD,    2, v2si_ftype_v2si_v2si,   subaddv2si3, TARGET_PLUS_QMACW)
>> -DEF_BUILTIN (VADDSUB4H,  2, v4hi_ftype_v4hi_v4hi,   addsubv4hi3, TARGET_PLUS_QMACW)
>> -DEF_BUILTIN (VSUBADD4H,  2, v4hi_ftype_v4hi_v4hi,   subaddv4hi3, TARGET_PLUS_QMACW)
>> +DEF_BUILTIN (VADDSUB2H,  2, v2hi_ftype_v2hi_v2hi,   addsubv2hi3, TARGET_PLUS_DMPY, NULL_TREE)
>> +DEF_BUILTIN (VSUBADD2H,  2, v2hi_ftype_v2hi_v2hi,   subaddv2hi3, TARGET_PLUS_DMPY, NULL_TREE)
>> +DEF_BUILTIN (VADDSUB,    2, v2si_ftype_v2si_v2si,   addsubv2si3, TARGET_PLUS_QMACW, NULL_TREE)
>> +DEF_BUILTIN (VSUBADD,    2, v2si_ftype_v2si_v2si,   subaddv2si3, TARGET_PLUS_QMACW, NULL_TREE)
>> +DEF_BUILTIN (VADDSUB4H,  2, v4hi_ftype_v4hi_v4hi,   addsubv4hi3, TARGET_PLUS_QMACW, NULL_TREE)
>> +DEF_BUILTIN (VSUBADD4H,  2, v4hi_ftype_v4hi_v4hi,   subaddv4hi3, TARGET_PLUS_QMACW, NULL_TREE)
>> -- 
>> 2.34.1
>>
> 

