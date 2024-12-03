Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1518B463;
	Tue,  3 Dec 2024 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211379; cv=fail; b=ua/YZC+JMaOHNPB1kKtoyiShCkyYJD3yBE4bc6ZD05t92o7+2Df3CBXx8RIcM4deF8Bp3rlvAHhIHABnk+hs08rtznfMrwq5XsjH3Kfmj61VfH+JZXM8ZZcQZ2hQ7EF+HU77wNWm/6zS1OI/RI19ibRjE0jO/iyM37GR9L7LncM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211379; c=relaxed/simple;
	bh=G2GfGQsdjacFU38c9eDwR0I5ePEW8eDrINSS8tUQrIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EPzMFoD3Dyu5eZQTkjF5bT0H76ZM+ui5j62XUIsgqV70fey7bxImA1e1gyMwq/cco9Zt5So+kmb8LZdaWKLSj5MiG8QMe5gVRtFg6wvuqzhX9souXyWQ39F2stoUV4EnuAkYCXmI7/zT2rTz7KZxpmjJJ8hSue7iYahhAgEe4Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HpXT4abo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JVNf0YcZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HpXT4abo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JVNf0YcZ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37XZtI002563;
	Tue, 3 Dec 2024 07:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=//DC+Lp6WwcFBrVM4hl83EEzIspNx3skAF5qLpCA36s=; b=
	HpXT4abo9a0qEucMOQyo9JsbikDdO17/8HscMgRt/6ad/azI8NGMKzjJ16KlfmPW
	srf7Gavc4M4qHUr3GLhP9rbIgnV4LjvSxASfhZWKIe889dTVmrjQCshobYWnLYUV
	R4eBNI5kkO5hVdcQUCrPYy9OGNaQ/Z1CCyhAqOc/mjo5FzyV2YXgEXpTbGsG4xuz
	yBk/LbROJRylbRj8pnWDFvOBm9aEV/OfRJREJs1HiIINPFmnuAMrMLrepft32i6o
	bdaK3IdtwqZ5nSdze+4suSfBlt+lf0w6JQTL+1gqQAquiG/fTaRlfr8z8NZhwmTG
	GTesat7pHFzAK3xFi8Qy4A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smadd2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 07:35:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B36Z9Vj031386;
	Tue, 3 Dec 2024 07:35:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836tm17h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 07:35:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFtgCqWXayJXSBPTARo2co6b9fo0eLhbhFk/00dtkJ7bJOCdK3HAGtoe0kJ24wBKqb7J4KYTkQF/13+/WceWllEsLOXeSlVesRZkrY1b3ehg0G1kCuvwL/f8IEWw0BEgITh//H9JT/3UjSRDyvPBmWlu6SomHOM1b5JYSNXq4mVVz/TERlKVzo6Y+xb77zpRukGmhl2jpbpmWxo+jH+KiQxUezFavF54nC4A7AaLtdh/SxAICuFEBdVERkImDk8g+N0ETDTNPEJ2mlW/HAMk840T+6PNkZJ34zq3MXY6l+qG5wkNQxh4vecFSXFvla0/QGJ+eADPwAMvuAtKkPh3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//DC+Lp6WwcFBrVM4hl83EEzIspNx3skAF5qLpCA36s=;
 b=bqrvPJqiE9ou9EESn+Hzn6uIXf66fjdWVKPcHay/QIVCGfWIxLMofPnySpzznW/uH++a2xYHVk1e0n0WX6WmreK5ZVxHMJqbsgUcnPNd1DHVk72ZT/vk7bSTGHRR3sBAyWzHR0OkrbdruoX6aLMkxELhnTwRNOUqZfXgCC98YMWuQsG2Y7RUWIPp44U2pJfah8BORMnUTKvWKtMR8z67qPYUlEy159IxFJhSVsuDp0tqPgn8HfAf1XPQGBexvmF7yDNj43VYnFHEnwB01bdJQeUWLGehHNV3KGiDgibQfPJdJHa1lQeojjLjbICrj1oYN2ToOt2OLPuEpEoQx+iiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//DC+Lp6WwcFBrVM4hl83EEzIspNx3skAF5qLpCA36s=;
 b=JVNf0YcZED3TQXcmhFSYNOGGUj2ieH/9p527WcdJM721pGV2Nl4pcMAizfZQrQN8RUPFYzunA2PR3QgCl9+h1Lhv5yy2Xl5ayeMnl/p40Dg1sF+Evgg8v8WiyNDD2txeUdYDcTth0ckNWXEJLuI6q5UNqe7m1E2wCkLDucs9ytc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA3PR10MB8188.namprd10.prod.outlook.com (2603:10b6:208:502::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 07:35:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 07:35:24 +0000
Date: Tue, 3 Dec 2024 07:35:18 +0000
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
Message-ID: <0f22048c-e24f-4539-8af2-63879971f6e1@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <ce2bd3dc-e7aa-41b4-9d57-2cc683b5659f@lucifer.local>
 <CABi2SkUFCqy0pWfrOcfC0a0GMVpFODtb=Hunw6WW1D5N-A_MXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUFCqy0pWfrOcfC0a0GMVpFODtb=Hunw6WW1D5N-A_MXw@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA3PR10MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b975d11-ede5-4656-1a7b-08dd136d0cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3k4RjBEdkl1eC9NTVJyUHVYekl1NHNqeU9hVEpZZ01OeEl5K3FXL1hvZWhW?=
 =?utf-8?B?TjN5RVFZajU2eC8vZEY2R2cyN0FTc09MQWZZZlg4dkVTNjZSeTNxYytXTzhJ?=
 =?utf-8?B?dzNGNVhrYm81TGxhcmVQQU5NSmVkSHY4L1Bwalo5blMzNEVwd1B5Szc1a3Bj?=
 =?utf-8?B?NE1tdFltU09QTkxScHNFNkdRTFNIUnNZSkN3Znp2a3dKbk1NaDQvNEJZcHBh?=
 =?utf-8?B?KzhDSTQ3UnVhWll0QThRZ3B0Z01JRjhocEN6NHlmMVd4V1J5aVBkWENRNzE5?=
 =?utf-8?B?d2dEZTFCR08vTWFhUXhHQUVVZ1JKM0xnZ3YvOElaNHhKejBzT1dxNW1jVmlE?=
 =?utf-8?B?RXE2dlR4UC9uVjMvUkg2RGJHY3NFdlFLUG9iMlVnbHVHOWRPeE5rS0hGellN?=
 =?utf-8?B?YkhZUGdnM3hWOHJqR2o0aStWZzMvd1VDU0JqT0RsMTFrTkF4cG9tZkZHc21n?=
 =?utf-8?B?U3Jlc2QranJLcDV6UFJZZmhPRU5FLzZFbGd2YTBnUTRiamVORWpLRXAzWEgy?=
 =?utf-8?B?dE5jOU13Nm55NzRZUHUzZmt5anpXcHdvaUh4Qjc0MnBvc2VLSGhmY25EeTYr?=
 =?utf-8?B?M1pPSlhGckxPS2JPSUZUNFJ0d0RET21SbGZqTThlTFQ2YUh2QkNYb2ZMT2lE?=
 =?utf-8?B?SHQwTWFrcFRwblJoWWF1WlozNFZRM1hUM014aWtxQ2V4clBxNXNON1UwOVlo?=
 =?utf-8?B?V2JLejJUbnJ5c3hUZURsVU1NZTV4SzlYY3RmMTh6YktvWVlGRzJqQmpGdkVU?=
 =?utf-8?B?VUF2bUJ4Q3l4eXIrRXBUL0dSY0tCSmtBQzJMeUZQTUZaM2xHaWlQbmVXbkQ2?=
 =?utf-8?B?TVh1ZzM3SldZbkk0MjNmdmVaODl5d2JYcnA5M0ViMnFJd2YyWFJQMVpNQk1r?=
 =?utf-8?B?T2pCRTAzS25OM2FKbjVxaFpNVGNBMXozbytnWUxRSGxVVkpsaXdUNW53dHp2?=
 =?utf-8?B?bzUxdWpsdEt5UG1leHJ2TUU4cVRKakRHVlM0bVhrTzBoM2ZnZStaRHJ4Nlo1?=
 =?utf-8?B?cVlBMTh4SEI2Z2c2MTE5RmY3dFJBdVBDVDNxa2FET1JWUXZ3Q1o5MThmVTdQ?=
 =?utf-8?B?QUxJTkFubWh0STQwVGRLSnExblJBSC9tRGR6ZnViK2Q1WlJQZDJQYVVPaXVU?=
 =?utf-8?B?OXMvZjdabWJPWWFMUTdPam1TZ2JvdlhQNXI5WC9jenpCSEdxUzVEdjNiOE1o?=
 =?utf-8?B?SHRoTkZWQ3FVNnNpbGJiSytwMzVFbDAyZkxvWDJWeEc3WFIxYm1qSm5UOGtk?=
 =?utf-8?B?TmVjeGxZNlFIWXVrWGtZMEd1NjVqQVhKcG5QNlpQcFp5QVRnNVZRWHZwTCtG?=
 =?utf-8?B?cUZXVURCMnJoZFZqRncvZElXU0Rkb1RleUtpcmhBYjJMc1I1VjA3SkJCUm9x?=
 =?utf-8?B?Z3lpajBnYjFEdnJYNW1MRWtWUEVjQVdqUFE0U2RvWHkrTlB3Y29xY3ZXUTVi?=
 =?utf-8?B?QVgzeVdDb1pDM2g3Y2IyemUwa3lkc3dHdzZUdWpOZzdnOE5mWlhmbTlQUXlw?=
 =?utf-8?B?WVZjUkJLUjZaTDN2UHlmMXpkR3JENjZLMVVCY2hibWNtMEFZblRXaGpGeUVY?=
 =?utf-8?B?R1NGQkZISFYyN2x0S0RmNlN3OXU2SXBESTd0Tm14YXVrYXJYUW5XUTZ4V3pW?=
 =?utf-8?B?eEpsR25Scm8vZkp2K0QxOGZUajBhUXNaMGtKQTZkblNvdGd0TkRmTU03WkI2?=
 =?utf-8?B?K2VyQlZiTzU5ejA5ZkRmNHY0RnJOQ09QTHFaZXh5T2g4c09uMERFdnlkWTA4?=
 =?utf-8?B?ODdPcTJybmdsOW81OUF5R3E1dUFEQmFISWtvWGU0ZklIMjkya2UxRlVOa1NL?=
 =?utf-8?Q?kYrHQIADm9qDQQyvpcfyzG5ODp0ZEDM3Y1+RU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjJVdlI3SGkyZ3cwdWdIVExzZ01jd3BuYXJmLzJNN3FHVDJxNE81emV5Y2Yv?=
 =?utf-8?B?R1BmRFVNVi81Mjgrckg2RTU2ZVNqTFc4V3ZSOUR4QS9Kd2NLYU5tczZkb2dV?=
 =?utf-8?B?QjlSZHduYlVvQ3ZVRjVvb2FuVEllN3AwYWlEbFdtaGl4M2YvOTBudzdFdmUv?=
 =?utf-8?B?bEd5VnV5N3kzcDZLOWUxVGZjUmpCNlQ2elBVQXBpajRIbHp3UUpaN0VYNGN3?=
 =?utf-8?B?K0g0UW9sVTBXUE5YOERkQlZodnk4TExPZkV4eERjMkQ2NElwclJXdkdaNkFZ?=
 =?utf-8?B?SG0xQzVZWUxZSVg1RTNzSndBMTdhbjk1QlFoUnpJN2UvSWQ0NDUxcVpiemZG?=
 =?utf-8?B?RS9WUEgvQlNaRGg2NlFVS1pNNG9nVFNPdWt2cGR4V3NEVy9JSks1QnhlNXVO?=
 =?utf-8?B?bGFiS3lOMlBJVFZOQ1A0VDdrRWhXcktwUVdSU1hzSHAyZEd3dVJnaVVDK3dI?=
 =?utf-8?B?di9hbjlRT0YvQlUzQ005MGxxWms2UUlWZ1F6cWlXZG9qZ1J4Mk9yWCs3clNo?=
 =?utf-8?B?VXdsSExLb2ZYb2FUSkl4ZjlFWnhjekxTYVY0V0VwV0xhZjdXdVJmajZSR2hZ?=
 =?utf-8?B?amI5ZUlOV1FBYVJacWxVdlloYXo1NG15RjhTbERxNTQrd2Y2YzFWcEVROXov?=
 =?utf-8?B?ek5PaVBRRHF0d0pTWkx6NmUwUW5lbEhuQ2VtbWtuL1dDSHhsZGkzaEk5VnFR?=
 =?utf-8?B?ZllBTElsVk00WnllK0VqanBrT1FtUVp1dEdWeGxCckxSZTcrcG9LOXZPM2ho?=
 =?utf-8?B?TEFSb1lkMFRhRUFkWGdFSnZZWDJpV0xXY1JkTHVTenV2eld4ZzRCTzAzZmY5?=
 =?utf-8?B?dUI4clZYbGgybWZ0SHVsWjRsUGx1bHlSckx4SlFsb3FpK0lJUkdjT3BSLzB0?=
 =?utf-8?B?MCtITVhGa29kclRSQ3B5T2xJVFFuWE42TlBJNlhDajE4YzF4SWVhYUF1NDBj?=
 =?utf-8?B?L3JhaTZVYmEvUkdEMlVieVlwallKZUNTcExRTnE0SFFubFRza2Mxby93K2VP?=
 =?utf-8?B?MkFwNHN0T3RiRTVpVVluWDMxTklmb1FCSWVvOElPZTZmSDZkRE5Vb2R3NCsv?=
 =?utf-8?B?a01Fa1JONFRPaHRUVFFhOVlGQWZkRzBwZTdBVUkyeEwySUwyUlpIRFFmSzNR?=
 =?utf-8?B?b1ZZMnI3Ti9WVzZ6OWlRMmc0Ulo5RUxHZGVnUEtLM1ljUlhiazI3dmNiTVBG?=
 =?utf-8?B?Wks0ZlVHQWlyZVJJZnJzcEVLRHdvOGJjNVlxRlA5SExlYnFrUlZXczNSdVVq?=
 =?utf-8?B?TC9qMmVJZE9PaTNZTFY4SGszMVVSL0hCNkZMNzdBSEducjNUWklXcGR1eG9O?=
 =?utf-8?B?T0lmWHNkVDhXUUhJdHFUV1FlMi9ob0pJZndFRENsNUxWUGhtNEFxRU9xNGFz?=
 =?utf-8?B?OFREdmttSE8zamF6SHl2SnhmektuRHprVm9mVE5teDY5M1h0a3F0MmFYQWVz?=
 =?utf-8?B?dTRvQXZ1b1U3OHBFRE9nclplMGZDREZHM1cwSEQxbXhUK1RLQlB4N09XVUp4?=
 =?utf-8?B?MzB6SG16OVRvemNEcHFlYjN6enVzYWh0alNZWXlCUEFOUUVzNkZvYmE0UnNB?=
 =?utf-8?B?MXl2MS9peDlaVjdiWldZZ1l0dDhUNGpOVnVSUlRHeXdwTEpmVEZxUForQ0dl?=
 =?utf-8?B?RGtHYk1UV2pCczJiblFuWGRaaml3QjU2c3dLV3JBV2hjYkV2QnpySHM5OHM3?=
 =?utf-8?B?R3ZuSVJuSjNWb2tZcUplRUM4d0FoVmkremJ1ZVFLMEE3Y05zbUZ2bDE5dU9m?=
 =?utf-8?B?VXhab2dsQm1GakhyMzU5dzNxOUxnNG5KZWNoVHE2TjlPSk5Fa2hWcHQvOUda?=
 =?utf-8?B?TVozUVFKaG5QQU02Vi9vaHQrVEdwRHVpNGNVcHVOTlMxWTRDclRtUFpXS0tD?=
 =?utf-8?B?aG5uWVVsQldUQnowL3VFTjRsUGxzTUhQOXBrTVV0aU5UODNicFkyd256b0pz?=
 =?utf-8?B?eUluQlpFMW9SbU0ySEdkZFZnUkJUZE1PMEJmZmtzQWptVFNpVGNVMjBSdU9F?=
 =?utf-8?B?K0pDVzA2NXRkS1lhTWI5dE9zbjVhNkxxSDZudE9CN2dzVWFkbWp5NUVRVXVU?=
 =?utf-8?B?NEtQNHpmbEUvQzhSZ1VIbitLTkxTa0VpSjk0ZWRielpyNVZmWmE3WkN1VVRV?=
 =?utf-8?B?KzYxUlMvU2Z4WlNNVmVSS1k3VjhVS1M3V0czelRJMXZOOWxIbHRXQkt4LzNJ?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E3eFbSv6UViucQG0Ms1Kv28i8YZ0DWnesqaLUO+QmN3ElYy5zvmkvugFb/59W8GFHL2L0DeNlcixYfs+93U3uy13eX2e1rY37WqHNx9q8VMveMzUPKimlT+Bd09rAUqzMHu/I47Du7WbkRlALRdzzz7j7zGhVD+a96ZzETKu/eIjc855mBBIUhmqwOgQosLWeax2Y8p2qqGQkKwRxp3Ggx887uhpBl76t/J0oTIAIbYyx4yvgmKg1WDBXSCw8B8CC6+io27bgMTQnOD+SaUN1GxoS/q4yjHZ20M5Zur4pcn+Pt9/K/KKo+DykR0swEAm00cyjMTnQxFIpB+LS0W1m8joydHVOmviC6wNJ3UgKo50a7VBXA52cxRVz0X5XZrsQGsbQGGLypGbshuEW7hpDsIaYqT35lEBHOlDaSZia9UFPQtFASHq1OjVys42GTpjGJn5Za+N7F8CITSKi3OlnZ7x52Lcm8I3yHY84+J0JMNYLZUeB3LLYHPufqh5ElcjqEK68oqUxG6Aj+9VtLEKYjtMaf/fPsZOCohyl0xTEYl/C+tHepYoWVpww/YwE9WBWR7uzyEDGX8jUfHl44ZcXMYl0oa4wxzplvN09quJ+xE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b975d11-ede5-4656-1a7b-08dd136d0cc6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 07:35:24.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnt/bWER2TCewM9T67yxUHLjSgf3ltdm7kKfRU6qWepzF1K1W52TJep1fwk2ijQ9hf70Gn3zVnkVvlOqWsfgaiIaJ1qjf4xLxBLkYJRRdnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030063
X-Proofpoint-ORIG-GUID: thbJj5cPllToL4VYaYMx47QBqezSAdUb
X-Proofpoint-GUID: thbJj5cPllToL4VYaYMx47QBqezSAdUb

On Mon, Dec 02, 2024 at 12:38:27PM -0800, Jeff Xu wrote:
> On Mon, Dec 2, 2024 at 10:29 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > >
> > > Those mappings are readonly or executable only, sealing can protect
> > > them from ever changing or unmapped during the life time of the process.
> > > For complete descriptions of memory sealing, please see mseal.rst [1].
> > >
> > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > generated by the kernel during program initialization, and are
> > > sealed after creation.
> > >
> > > Unlike the aforementioned mappings, the uprobe mapping is not
> > > established during program startup. However, its lifetime is the same
> > > as the process's lifetime [2]. It is sealed from creation.
> > >
> > > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > > _install_special_mapping() function. As no other mappings utilize this
> > > function, it is logical to incorporate sealing logic within
> > > _install_special_mapping(). This approach avoids the necessity of
> > > modifying code across various architecture-specific implementations.
> > >
> > > The vsyscall mapping, which has its own initialization function, is
> > > sealed in the XONLY case, it seems to be the most common and secure
> > > case of using vsyscall.
> > >
> > > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > > alter the mapping of vdso, vvar, and sigpage during restore
> > > operations. Consequently, this feature cannot be universally enabled
> > > across all systems.
> > >
> > > Currently, memory sealing is only functional in a 64-bit kernel
> > > configuration.
> > >
> > > To enable this feature, the architecture needs to be tested to
> > > confirm that it doesn't unmap/remap system mappings during the
> > > the life time of the process. After the architecture enables
> > > ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> > > CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> > > Alternatively, kernel command line (exec.seal_system_mappings)
> > > enables this feature also.
> > >
> > > This feature is tested using ChromeOS and Android on X86_64 and ARM64,
> > > therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
> > > Other architectures can enable this after testing. No specific hardware
> > > features from the CPU are needed.
> > >
> > > This feature's security enhancements will benefit ChromeOS, Android,
> > > and other secure-by-default systems.
> > >
> > > [1] Documentation/userspace-api/mseal.rst
> > > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         | 11 ++++++
> > >  Documentation/userspace-api/mseal.rst         |  4 ++
> > >  arch/arm64/Kconfig                            |  1 +
> > >  arch/x86/Kconfig                              |  1 +
> > >  arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
> > >  include/linux/mm.h                            | 12 ++++++
> > >  init/Kconfig                                  | 25 ++++++++++++
> > >  mm/mmap.c                                     | 10 +++++
> > >  mm/mseal.c                                    | 39 +++++++++++++++++++
> > >  security/Kconfig                              | 24 ++++++++++++
> > >  10 files changed, 133 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index e7bfe1bde49e..f63268341739 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -1538,6 +1538,17 @@
> > >                       Permit 'security.evm' to be updated regardless of
> > >                       current integrity status.
> > >
> > > +     exec.seal_system_mappings = [KNL]
> > > +                     Format: { no | yes }
> > > +                     Seal system mappings: vdso, vvar, sigpage, vsyscall,
> > > +                     uprobe.
> > > +                     - 'no':  do not seal system mappings.
> > > +                     - 'yes': seal system mappings.
> > > +                     This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=(y/n)
> > > +                     If not specified or invalid, default is the value set by
> > > +                     CONFIG_SEAL_SYSTEM_MAPPINGS.
> > > +                     This option has no effect if CONFIG_64BIT=n
> > > +
> > >       early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
> > >                       stages so cover more early boot allocations.
> > >                       Please note that as side effect some optimizations
> > > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> > > index 41102f74c5e2..bec122318a59 100644
> > > --- a/Documentation/userspace-api/mseal.rst
> > > +++ b/Documentation/userspace-api/mseal.rst
> > > @@ -130,6 +130,10 @@ Use cases
> > >
> > >  - Chrome browser: protect some security sensitive data structures.
> > >
> > > +- seal system mappings:
> > > +  kernel config CONFIG_SEAL_SYSTEM_MAPPINGS seals system mappings such
> > > +  as vdso, vvar, sigpage, uprobes and vsyscall.
> > > +
> > >  When not to use mseal
> > >  =====================
> > >  Applications can apply sealing to any virtual memory region from userspace,
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 63de71544d95..fc5da8f74342 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -44,6 +44,7 @@ config ARM64
> > >       select ARCH_HAS_SETUP_DMA_OPS
> > >       select ARCH_HAS_SET_DIRECT_MAP
> > >       select ARCH_HAS_SET_MEMORY
> > > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > >       select ARCH_STACKWALK
> > >       select ARCH_HAS_STRICT_KERNEL_RWX
> > >       select ARCH_HAS_STRICT_MODULE_RWX
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 1ea18662942c..5f6bac99974c 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -26,6 +26,7 @@ config X86_64
> > >       depends on 64BIT
> > >       # Options that are inherently 64-bit kernel only:
> > >       select ARCH_HAS_GIGANTIC_PAGE
> > > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > >       select ARCH_SUPPORTS_PER_VMA_LOCK
> > >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> > > index 2fb7d53cf333..30e0958915ca 100644
> > > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > > @@ -366,8 +366,12 @@ void __init map_vsyscall(void)
> > >               set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> > >       }
> > >
> > > -     if (vsyscall_mode == XONLY)
> > > -             vm_flags_init(&gate_vma, VM_EXEC);
> > > +     if (vsyscall_mode == XONLY) {
> > > +             unsigned long vm_flags = VM_EXEC;
> > > +
> > > +             vm_flags |= seal_system_mappings();
> > > +             vm_flags_init(&gate_vma, vm_flags);
> > > +     }
> > >
> > >       BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
> > >                    (unsigned long)VSYSCALL_ADDR);
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index df0a5eac66b7..f787d6c85cbb 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
> > >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
> > >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > >
> > > +#ifdef CONFIG_64BIT
> > > +/*
> > > + * return VM_SEALED if seal system mapping is enabled.
> > > + */
> > > +unsigned long seal_system_mappings(void);
> > > +#else
> > > +static inline unsigned long seal_system_mappings(void)
> > > +{
> > > +     return 0;
> > > +}
> >
> > OK so we can set seal system mappings on a 32-bit system and
> > silently... just not do it?...
> >
> I don't understand what you meant.
>
> The function returns the vm_flags for seal system mappings.
> In 32 bit, it returns 0.
>
> the caller (in mmap.c) does below:
> vm_flags |= seal_system_mappings();
>
> (The pattern is recommended by Liam. )
>
> Is that because the function name is misleading ? I can change it to
> seal_flags_system_mappings() if there is no objection to the long
> name.

No, I'm saying that you're making it possible for somebody to enable this
feature on a 32-bit system, and to think it's enabled and that they're
protected when in fact they're not.

Which is, security-wise, I think rather unwise.

Again it's an argument against a cmdline parameter. See below.

>
> > > +#endif
> > > +
> > >  #endif /* _LINUX_MM_H */
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 1aa95a5dfff8..614719259aa0 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1860,6 +1860,31 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> > >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> > >       bool
> > >
> > > +config ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > +     bool
> > > +     help
> > > +       Control SEAL_SYSTEM_MAPPINGS access based on architecture.
> > > +
> > > +       A 64-bit kernel is required for the memory sealing feature.
> > > +       No specific hardware features from the CPU are needed.
> > > +
> > > +       To enable this feature, the architecture needs to be tested to
> > > +       confirm that it doesn't unmap/remap system mappings during the
> > > +       the life time of the process. After the architecture enables this,
> > > +       a distribution can set CONFIG_SEAL_SYSTEM_MAPPING to manage access
> > > +       to the feature.
> > > +
> > > +       The CONFIG_SEAL_SYSTEM_MAPPINGS already checks the CHECKPOINT_RESTORE
> > > +       feature, which is known to remap/unmap vdso.  Thus, the presence of
> > > +       CHECKPOINT_RESTORE is not considered a factor in enabling
> > > +       ARCH_HAS_SEAL_SYSTEM_MAPPINGS for a architecture.
> > > +
> > > +       For complete list of system mappings, please see
> > > +       CONFIG_SEAL_SYSTEM_MAPPINGS.
> > > +
> > > +       For complete descriptions of memory sealing, please see
> > > +       Documentation/userspace-api/mseal.rst
> > > +
> > >  config HAVE_PERF_EVENTS
> > >       bool
> > >       help
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 57fd5ab2abe7..bc694c555805 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapping(
> > >       unsigned long addr, unsigned long len,
> > >       unsigned long vm_flags, const struct vm_special_mapping *spec)
> > >  {
> > > +     /*
> > > +      * At present, all mappings (vdso, vvar, sigpage, and uprobe) that
> > > +      * invoke the _install_special_mapping function can be sealed.
> > > +      * Therefore, it is logical to call the seal_system_mappings_enabled()
> > > +      * function here. In the future, if this is not the case, i.e. if certain
> > > +      * mappings cannot be sealed, then it would be necessary to move this
> > > +      * check to the calling function.
> > > +      */
> > > +     vm_flags |= seal_system_mappings();
> > > +
> > >       return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
> > >                                       &special_mapping_vmops);
> > >  }
> > > diff --git a/mm/mseal.c b/mm/mseal.c
> > > index ece977bd21e1..80126d6231bb 100644
> > > --- a/mm/mseal.c
> > > +++ b/mm/mseal.c
> > > @@ -7,6 +7,7 @@
> > >   *  Author: Jeff Xu <jeffxu@chromium.org>
> > >   */
> > >
> > > +#include <linux/fs_parser.h>
> > >  #include <linux/mempolicy.h>
> > >  #include <linux/mman.h>
> > >  #include <linux/mm.h>
> > > @@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
> > >  {
> > >       return do_mseal(start, len, flags);
> > >  }
> > > +
> > > +/*
> > > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > > + */
> > > +enum seal_system_mappings_type {
> > > +     SEAL_SYSTEM_MAPPINGS_DISABLED,
> > > +     SEAL_SYSTEM_MAPPINGS_ENABLED
> > > +};
> > > +
> > > +static enum seal_system_mappings_type seal_system_mappings_v __ro_after_init =
> > > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_ENABLED :
> > > +     SEAL_SYSTEM_MAPPINGS_DISABLED;
> > > +
> > > +static const struct constant_table value_table_sys_mapping[] __initconst = {
> > > +     { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > > +     { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > > +     { }
> > > +};
> > > +
> > > +static int __init early_seal_system_mappings_override(char *buf)
> > > +{
> > > +     if (!buf)
> > > +             return -EINVAL;
> > > +
> > > +     seal_system_mappings_v = lookup_constant(value_table_sys_mapping,
> > > +                     buf, seal_system_mappings_v);
> > > +     return 0;
> > > +}
> > > +
> > > +early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
> > > +
> > > +unsigned long seal_system_mappings(void)
> > > +{
> > > +     if (seal_system_mappings_v == SEAL_SYSTEM_MAPPINGS_ENABLED)
> > > +             return VM_SEALED;
> > > +
> > > +     return 0;
> > > +}
> > > diff --git a/security/Kconfig b/security/Kconfig
> > > index 28e685f53bd1..5bbb8d989d79 100644
> > > --- a/security/Kconfig
> > > +++ b/security/Kconfig
> > > @@ -51,6 +51,30 @@ config PROC_MEM_NO_FORCE
> > >
> > >  endchoice
> > >
> > > +config SEAL_SYSTEM_MAPPINGS
> > > +     bool "seal system mappings"
> >
> > I'd prefer an 'mseal' here please, it's becoming hard to grep for this
> > stuff. We overload 'seal' too much and I want to be able to identify what
> > is a memfd seal and what is an mseal or whatever else...
> >
> I m OK with MSEAL_

Thanks.

>
> > > +     default n
> > > +     depends on 64BIT
> > > +     depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > > +     depends on !CHECKPOINT_RESTORE
> >
> > I don't know why we bother setting restrictions on this but allow them to
> > be overriden with a boot flag?
> >
> The idea is a distribution might not enable kernel security features
> by default, and kernel cmdline provides flexibility to let users
> enable it.
>
> This is the same approach as  proc_mem.force_override kernel cmd line
> where Kees recommended  [1], I would prefer to keep this as is.
>
> [1] https://lore.kernel.org/all/202402261110.B8129C002@keescook/
>

This is flawed on multiple levels. Firstly, from the linked change:

	+config SECURITY_PROC_MEM_RESTRICT_WRITES
	+	bool "Restrict /proc/<pid>/mem write access"
	+	default n
	+	help

There are no 'depends on'. Yours has 'depends on' which you've just
rendered totally irrelevant including _allowing the enabling of this
feature in broken situations_ like CRIU, as I mentioned below.

For another, the linked feature changes behaviour and a user may or may not
want to allow the ability to write to /proc/<pid>/mem which is ENTIRELY
DIFFERENT from this proposed feature.

Under what circumstances could a user possibly want to write VVAR, VDSO,
etc. etc.? It just makes absolutely no sense for this to be a boot switch.

So the arguments presented there have zero bearing on this series.

> > This means somebody with CRIU enabled could enable this and have a broken
> > kernel right? We can't allow that.

Please do not ignore review comments like this.

> >
> > I'd much prefer we either:
> >
> > 1. Just have a CONFIG_MSEAL_SYSTEM_MAPPINGS flag. _or_
> > 2. Have CONFIG_MSEAL_SYSTEM_MAPPINGS enable, allow kernel flag to disable.
> >
> > In both cases you #ifdef on CONFIG_MSEAL_SYSTEM_MAPPINGS, and the
> > restrictions appply correctly.
> >
> > If in the future we decide this feature is stable and ready and good to
> > enable globally we can just change the default on this to y at some later
> > date?
> >
> > Otherwise it just seems like in a effect the kernel command line flag is a
> > debug flag to experiment on arbitrary kernels?
> >
> > > +     help
> > > +       Seal system mappings such as vdso, vvar, sigpage, vsyscall, uprobes.
> > > +
> > > +       A 64-bit kernel is required for the memory sealing feature.
> > > +       No specific hardware features from the CPU are needed.
> > > +
> > > +       Depends on the ARCH_HAS_SEAL_SYSTEM_MAPPINGS.
> > > +
> > > +       CHECKPOINT_RESTORE might relocate vdso mapping during restore,
> > > +       and remap/unmap will fail when the mapping is sealed, therefore
> > > +       !CHECKPOINT_RESTORE is added as dependency.
> > > +
> > > +       Kernel command line exec.seal_system_mappings=(no/yes) overrides
> > > +       this.
> > > +
> > > +       For complete descriptions of memory sealing, please see
> > > +       Documentation/userspace-api/mseal.rst
> > > +
> > >  config SECURITY
> > >       bool "Enable different security models"
> > >       depends on SYSFS
> > > --
> > > 2.47.0.338.g60cca15819-goog
> > >
