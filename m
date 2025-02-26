Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49727702;
	Wed, 26 Feb 2025 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548657; cv=fail; b=f9X0iax58JsY9f3y5ZqkXD8rH3xxgweHWPBKF4jB9UzMBH35dxaGYLWZwDX1Fle1/XiseFvXiW8TDnHOzEXgTNqTg35XetMqpnQvXmWE17TB2fAkbpsN30HsdaV1QhmFiOZd5eqlLTahWnrXWoWhLuHkCKI20D92js6zk4eSUpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548657; c=relaxed/simple;
	bh=KKUW1lgzxQDhKXyqwPh+UZwyAzUyTYTY7g1xl5FdBD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ROeqjKNgwKyfQcOwgbFJ8SRmTm33hOb2qoDDFYvekMN+tSBTuHf3WBj9u+kmPP9W1WuTytHropHQNSYBQKCb4b6DWtk6KXrORw2S7sO3rnHUE8KZhW1yNKKrff857LP5m2e6S7234cWAXD77FSdvNwpSAGYQ6ykQgsMGANpcnHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V+a8EvTz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ei02iFyQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V+a8EvTz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ei02iFyQ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5XcOe021158;
	Wed, 26 Feb 2025 05:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EU7J3QE2ipP0j3joGRynHOfZJpoZRzZ7HPxdCAR/NNU=; b=
	V+a8EvTz80OGymCWWhcs5CXH6nQxCyNFxd2flxJWlKZxueu8MgEiCpVJamKgikhv
	6SKSgK3Pwp56uYi+G/EcRJvsga00OokngjueT0QB+y1UXp0acrAwsiU/TuYxL20s
	SB/tx+tI1yn439PvWupY4unpd3Mp4STqAg8vr53zUZnihu3QrU6rPi2M3HOFxUuk
	OpD2oaw1bt/Zyl4KnBnyi8/+qXSnCjvnrWPoJiL1FH8Eudc5sDzvCcTVfG/FIALe
	dB0a5nVX6WrbbrH0ozjbQjDQ99Tv2NXtBk0tr/WKGTq76uinXa4SjeX7yeZKHYgB
	RTalhy/s0GY3Tg4UCmgFAQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psc8e8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:42:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q4rexN007532;
	Wed, 26 Feb 2025 05:42:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51g81ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6snx7ehSCHMU8EEfVq+ZnsAGSS/GLniOVNPSu68AXv7eIRXfOrqEBKFCXC/Kh5Or3IJodw7Q/6/k939TFHEZfWdWKckDZHg2YF0RE79MFASaiDy7JWHH8+sRE12IC4maSmrGdR8WQ22OGVkpHUAK3xu7fDAlBywfAuH+RyEXCSdkohM40HQaGRt3CFw+SN7Ei9h+8w4Zx+cPYQClKIaF675yRtUll21P/6H2u7VzaE1stRMnXemxBkEeNcCZ9FHDjoewDP5q22C6TP1f++SG5rTNiJ9z0MuxgtW9CS8b1STUsiOKvdVAy3efSR2ajDslahLBJHPi1gnNTgY/+nHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU7J3QE2ipP0j3joGRynHOfZJpoZRzZ7HPxdCAR/NNU=;
 b=sMhRPJlWQkj0LRNbZ7tLMRbr4sn8gCIfC7jzLBVTsmNbwkKY560dQi7y12CEsdJNyh0K8iaZcYaDQNU2VbrcVlMHD6BhS7SBj990nYH6plPZvQ2tur72dAC6qZc/jtiYv3pBqykpsWz8vjfyN1TbWsmjrrIRkIv3T8YrV6I47oAv4pL+QvuifouxCb2lWf51K2Vsjdp78b5g0RrwSkT7wQKz2++aMwggoRcAPgt5Ea8yU4DYYb14oqSS0S24koNUfcHvgFvVOvAJEmwC+ugPfw5X7SvXXiBwtNZno87iJYxV6JkWNxdkQfzbPINK3b8nWdun4tGQkD561LYwhu9RfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU7J3QE2ipP0j3joGRynHOfZJpoZRzZ7HPxdCAR/NNU=;
 b=ei02iFyQ4gagV8mXgBr9Dj7x8ttBWlJn/DBe51Rxk22sYcOvRl3geKAJTBe3X835XDRVzKqTN3ea/AJ8blo5bKi+17QrIqPZKldiSrbsZytMCiG3AR1iS+hjlNf3gEzBMpbTY8WKZa6CjHLKZKyk79p7ReQSLjI3k3Iav1cpXuA=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 05:42:55 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:42:55 +0000
Date: Wed, 26 Feb 2025 05:42:53 +0000
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
Subject: Re: your mail
Message-ID: <f65bd1bf-4e81-454a-afaa-f84c13cc6227@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <e697ee1d-6075-4f24-8365-32aa4bc84d7e@lucifer.local>
 <CABi2SkXcgB1Zjztqc1W4M-5j9z_wMCRaEtK-wLL3x9_qC1aGHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXcgB1Zjztqc1W4M-5j9z_wMCRaEtK-wLL3x9_qC1aGHQ@mail.gmail.com>
X-ClientProxiedBy: LO2P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::8) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 114316d5-5ee0-4b51-6fae-08dd56286b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXkxQzFycE5wZUR0RXM4NldNMlVxRXVWMU01ZmVIMi9yNFgyZWRlNytEMHBr?=
 =?utf-8?B?aC9HQzRtS2laY1hrL24zdW1WRU4wQ091T3dwOUxmcjFqTjVyVVQ0bkxTZ1Vk?=
 =?utf-8?B?TUF1elhJMGtWRVBPd2wvUktKc21JWHU5cHl1Zk5PbjdOenFRYUljSDBTWEl1?=
 =?utf-8?B?R3JjY1RlNDE3NVBzbnhHMWloeml0TC96ZlBKTXNRS1FkK2kxQ3JTS3crdFYr?=
 =?utf-8?B?bnJmNW5nQ1hVNlRibFFzZzhVTWhPKzdLVTI0blUzVFJkcnY2d05ONVprNnRu?=
 =?utf-8?B?clBkcEtxYzZWNVZMSnFZZ01RREk3NU5JUHNZY3VvODIrQitiNEFaWDFTVEhj?=
 =?utf-8?B?Q1kvcWJRU0JtWEVvYmJYUkE4bCtOVkRmRXZEMXFzSnc2VUErYTZONmp4dzI1?=
 =?utf-8?B?WVNWTmMzNjlSR1BiUzhzeUJ2MjhBR0JtMTYwQVZNMDRPK2hXa3hvdkZzcXI1?=
 =?utf-8?B?RWhYSDN1b2hGV1htVWZBRkpySkZYckZhZXVad3JGVnUxYlNxeklzeVhVcWVm?=
 =?utf-8?B?OCs2aGx2Ty8vU3YwdFFQTXZTRjJMMVZpQlZybHpWREpsVHVKZ0RaeWE0WUtq?=
 =?utf-8?B?eDNjdjVrRTgzTlRYNGNhbjc0d0RiSk9obWgyS3FBeHZielVseDIxOEhCVjB2?=
 =?utf-8?B?MUduWmVuRWxQVjJXbzMvUkdzbGVGY3Z4eWdtQ3RiMnJvN0tTQ1o0enRvSkVu?=
 =?utf-8?B?QkxNNHFOaTlJS29kVUJDT3BydEd0VFhTa21GWXdjKzlQRk10TElVdUZiUENT?=
 =?utf-8?B?Y09LL1ZpbWxRaitTM2xuMGRVV1I0aDB5dmg1R0tTdElXSVp2algyZ3FzTWE0?=
 =?utf-8?B?MUMweWVtN1ZmR1h6dVdFdW8yOFQ4VHJ3aGRhcVdaVTV0YytPWERiQitLRnRz?=
 =?utf-8?B?bE5lQjVXRCtKZkVWTkJTRjRiU0JrWjBtdU0zYmJSeDhrMXJLc3k0aU5RSkZS?=
 =?utf-8?B?VjlGNDZCQmdFRUFPRmwrYzlSVW1GUjZnUFE4bTZmWDBHU01malY5Um1zU1h3?=
 =?utf-8?B?Y3FBbVVHV0tuZU9kSmdCakQyemwyQitpbDFwUWphL2xjY3lmekpVNEpYMTU1?=
 =?utf-8?B?WlgwN2JQQytMQlBFb282Mzhyc0I1TEkrZCsvMDZxNHovdzdrQyt2Vkhqd1VO?=
 =?utf-8?B?WDRBaXZiVmpCZmRmZFJyUGJMWDZFNGdEV2hQNW04Ri81cElXTklUTkh2UEZM?=
 =?utf-8?B?NlUwcGM4YndES0tNZzVucXpXM3lVYThZTE13TnE1cmhMM1htdk4yUnI3UTly?=
 =?utf-8?B?aFJNTk9Mc0lRdFhENHM1TFF4eE1hdXJteUFlOUcyeTd6RzdCVTNacE9pQTVZ?=
 =?utf-8?B?MmNORU5OcjNKTFZ6QW1UTEdFdHZQdlNRVklEZ2lsWkRkQ3dVYXZMU0NMYVpI?=
 =?utf-8?B?Z0lJTWZjck8xTVFQRnpXYWdYeUt0Q2RuUUxSeXVSaHhobXpCZUhQb3ZxV0RH?=
 =?utf-8?B?bVg0WExxdThWV3plTzJqeHdmUm1zaUMzTnJLdDJUY2FZSFJ2b2pVVGhRWTNj?=
 =?utf-8?B?bWVsaXVPQmVsaGZQV2Z4aU9IZXp5ZFZycEJwelpPbWJpRzVycDFXSVFwUzFr?=
 =?utf-8?B?M2pwV2pzRFpCUGRGL0xIQkkxRjZ3QnRENGJBYWxaUDJLd0ZaY1VsTGNrS2xL?=
 =?utf-8?B?dGRLdlhZUkx4RzFLYzdXc0p6NTl0cmJwbUlUVmVETWdMKzNaWmNJUjdoSXBa?=
 =?utf-8?B?QlVRK054akJ6Zkxya2lSWkxiWDRVT2pnb0xTZEFKYXFtd1h1TzlVK0NXNVdi?=
 =?utf-8?B?UkU3QlBVek05WFlFV1JHbEtPdzNuTDE1cnJsMkIyR3hCaHAxODNKTFBSK3dL?=
 =?utf-8?B?MmdOaWlMVURxYVpnTHhLcnZORFc3TTUrY3ZvbThQM2pCblJieGpvSTEySmJF?=
 =?utf-8?Q?MkSRiIFspWPjq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2p3SzM5endZWHpOSEVLYjJrSGdFa0JNNVlSb3pLZjNHWVU4VXZ3R3BQSFhI?=
 =?utf-8?B?OU9CZkZLTzkyZGZFcG9BZFd1WkJyaGFtSXFCZnVOOHUraHozeFcrWkM5MEt0?=
 =?utf-8?B?Wk11MDdQZjRoOUtpRVhmdjFUeUhDbFZGdmNuMVo3aW1MbFdzejdCT1RZZDBP?=
 =?utf-8?B?RDhSVnovRUcvSUhPVkpBMWlaaWsxVGFoOEV3QStkblVta3ptOWkzMUpFa2xi?=
 =?utf-8?B?cHJOcklCRElSZlA2UmZtSlFQR0xReVYycC90VnlUZEkrR3JJK2phcEtIb0Fv?=
 =?utf-8?B?S3JSbTI1bDlzN2RJRVYvYWpzWGxlSGt5L09IWHBDTHU3QzczbEYzT0ZHbkNH?=
 =?utf-8?B?Z2l1cmltd2dhM2lEK293V0RwMEx6NXVnMEw1U0pTSHhFSUVUWFQydXFEY3lI?=
 =?utf-8?B?bC9vaG15eUpqRFNYWDBKT3dqbnI5eDNrRWY1OWZGTEZxZ0E4b1BZUzN0bkpm?=
 =?utf-8?B?OHZuVEZDSExoVmI3R2JWT2p5Q0RuZFNrajdLYStObG1BamhoYjAwWGEwRWg2?=
 =?utf-8?B?VWxpbGxPVjZiWkt3Z3p1TnMvK21HK0tiWFBBRXN0VmxqZkoxaUJFeFhISGdl?=
 =?utf-8?B?Uko1d1JhdFc0VDAxRnlPT05qMHRIZkFDdzdEMU9ncHFGZk5nemx1U1ZIOWF1?=
 =?utf-8?B?UExPS2Z0YlVPY1puRnR3T29xaEFQVDQzQ2FrNGYvVktuaklGVXdENlh4VVdY?=
 =?utf-8?B?MEhDdk5SREhtWU41dng4ZWNUZXhzVGU3dG14Ukw1Ymt5ZmZzWTRrcStaRFVL?=
 =?utf-8?B?RVl1OXMvWnhIcFZkNFIvV0R1ZXVOTWdHNGdtSDdWdkVkRitaT2JCb2FFRUhB?=
 =?utf-8?B?VGoxUGk4OE9CVkt0eHZZSGRHcVdxV0VEcURmeXlHSUUxcldjemlyVVBnTXNR?=
 =?utf-8?B?UE1QQytDdkFqNHc5WjYzc2p4WS9IMUo5WEFDV3pHMlF3SG8rQU9SRUxwdDBH?=
 =?utf-8?B?ZGJuSkR1RndkVUs2WmdTTkxLVzk0TnNyQzVyMGxwZm9YWk9JU0N5RWlsdXdx?=
 =?utf-8?B?aVczVXdXZlZaSjlXcTBjRnBzZ21FVWNrMWRRRlFlNXhYUWdKVTdUWUo5elFt?=
 =?utf-8?B?bnFaNGM0dHVsV2xJY2xoRGZSaGNrOTR3WjFxNGRWMFdFSlFRTmVPZFIrMVZr?=
 =?utf-8?B?a2VvckhNM2I3OGI2cDl0MEZaZUFtSmFWQ0lMZUcybkZaNnY1aG9FeEpKZUNu?=
 =?utf-8?B?T0Zrak1MelpXRVpWdHYvU2puWTNWSmROMjVrdDRWVGZsdDdKay94MG93TlNF?=
 =?utf-8?B?SGcrVXhSWkVYV3BSK3FialpNa0IrcXR4ZGplcjE5Vlp0QWFLbW1qS25URm9U?=
 =?utf-8?B?Zjg3SlNXSlh5TmNibkNpMkYyb1BXVFJyTndwVURaWWNtc21lS1RuYmFWaFpo?=
 =?utf-8?B?MUQvSGtiUkdyeVZGb2pNNVc1NEFGdWhtS2tkWVlFbmM2VEVIblJMYVg2Z3Bq?=
 =?utf-8?B?WVFVMU5RT2ZJS0tsczN4REpuZGlSalFQcXpoU2hWdFZNdlVQZXMzTjZqeldG?=
 =?utf-8?B?RldzYnhDVTFkMityZXowUFdVYUhXSjZvLzRRdW53QzRabEtpZlNwbDBaTHhS?=
 =?utf-8?B?WDc1L2tzN1V6Z1VzbjBCZlFWUnF6cStreTBsbUE2OENCbDAxM0J0SDVIdHFL?=
 =?utf-8?B?WVE2eTcrMlJMNXU4cWptdkQ0UU8zaGJvZGpBU25rRVBvNS9VTWlIaDc4Z1N3?=
 =?utf-8?B?SHd2MDgrOEl5NXd4U3pZVHRvZUV5V3FwUDRqQnQ5VFRpK1VqaW1RcTZZNmE1?=
 =?utf-8?B?NXNJYTF3bXhJM0I2a0VQb0xka0NJTlMrRUdyckNqSXNFN05BdDF0Uy82WFFr?=
 =?utf-8?B?QWloSlhSb1NtN2x6VUliaU9KNnlSMytDYXhtaEpnTDlxYnROZkdURnl6eU1a?=
 =?utf-8?B?VHJNVWVUc1VwQ3FySmxrOXJQYjRZTzFmWktrTUxEc0N3NUM1WlZSY0JRdDNa?=
 =?utf-8?B?S1VjeFg0N1hjSGdxQVdTMDZHTWg3NUkxcUhSdTZuaFlOdHhOQ3hYMFVwTGha?=
 =?utf-8?B?dmYvSDBIRHpVUGEvbzhwNHIvVHBZTDA5OG1scTBHeElNdVdCZ3hjTW9oQUxC?=
 =?utf-8?B?WWhydFhteGtPNDhYTWpaTm82enlUTEpaNGM5R3o0MXVxcVNNQi9BR0dybzZW?=
 =?utf-8?B?ZUFHNERvRmN3RWJYdGVvU2d3b2hiSUVBdWZ0UVY5TWlyelBGbmtKRndWZy9x?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8B92210yB0jMlgLHUQ21hKQVxuzEuTOSP7c14sBRhPXD1f6UpDkmsnY1XpuNFaPfCfIdEsdzSdjsQKfomZC7t8Rl2ETx7IKWiQQVcQlzpeL/4dlhDl1WGHNDUjR4gSygZlGsbguC0QDEh0Dvmd259CFyICUHcY1+qB2FJdpVuObtyLnLX0zNaEPd6nQ042AOQwJGALiUUSIHo2nsLBpbRfb0l1XjmayHDTBs5FOrHcyQLLHPZNYe1Pxp9TpkngmEUB7OMm1ZHGPSHf5kmjqTRy8TZpFMzI2w4l3T6/IGA5givFrO/OkFlSmVVpFJ1KuOnpLaSULd5GvdVsANMA208IqakPacixO1s1h0B52cNIQeqcPCs+Acu5siJ/Yvjlh6ImSdgP7koVtuvUtA0tDrKm1+omPZIhSh/lKux8/6VkW0vChvBzNSwPsqWYKnehmYj1R3gwCc/DeVYqN8sQ5dyJd1vEPcgPezGWj+IdveZ+pkhiCqsYPtfmlk5I/DKitFNxsgM3uqygqyRUXoqjY42ZQdrAVnT/I5HXNSc0mZ5Mpjl62lVPPtCg13Z1fkaT2ojnRdufWH7nbHRTJboFMjvI5k9LTZaai0r1dVfpO0R/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114316d5-5ee0-4b51-6fae-08dd56286b30
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:42:55.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOA5XrqiorsuDtRaWAOvTwW4Dh8n2cB19+IlAEHMLWoNgztwIOCFZN2w9fGlrDak5oviZwpSbg8n3NSqVIxAiPxc/55HGcl9aIwICx4JNsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260043
X-Proofpoint-GUID: xLDO75tYB4aIH2Q9-D5jtxxEUJ24Ussn
X-Proofpoint-ORIG-GUID: xLDO75tYB4aIH2Q9-D5jtxxEUJ24Ussn

On Tue, Feb 25, 2025 at 04:12:40PM -0800, Jeff Xu wrote:
> On Tue, Feb 25, 2025 at 7:18 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Jeff - looking further in this series, I asked for a couple things for this
> > series which you've not provided:
> >
> > 1. Some assurance based on code that the kernel-side code doesn't rely on
> >    VDSO/VVAR etc. mapping. I gave up waiting for this and went and checked
> >    myself, it looks fine for arm64, x86-64. But it might have been nice had
> >    you done it :) Apologies if you had and I just missed it.
> >
> Thanks for checking this.
> Do ppc in kernel code unmap/remap  vdso ?
>
> I am aware that userspace can remap/unmap special mappings, but I
> don't know if the kernel will remap/unmap a special mapping. Could you
> please point out the code ?

Again as discussed in other thread, let's leave this until as/when you try
to attack PPC. I am not 100% this is the case, I may be mistaken sure, but
gathered it _might_ be.

>
>
> > 2. Tests - could you please add some tests to assert that mremap() fails
> >    for VDSO for instance? You've edited an existing test for VDSO in x86 to
> >    skip the test should this be enabled, but this is not the same as a self
> >    test. And obviously doesn't cover arm64.
> >
> >    This should be relatively strightforward right? You already have code
> >    for finding out whether VDSO is msealed, so just use that to see if you
> >    skip, then attempt mremap(), mmap() over etc. + assert it fails.
> >
> >    Ideally these tests would cover all the cases you've changed.
> >
> It is not as easy.
>
> The config is disabled by default. And I don't know a way to detect
> KCONFIG  from selftest itself. Without this, I can't reasonably
> determine the test result.

Please in future let's try to get this kind of response at the point of the
request being made :) makes life much easier.

So I think it is easy actually. As I say here (perhaps you missed it?) you
literally already have code you added to the x86 test to prevent test
failure.

So you essentially look for [vdso] or whatever, then you look up to see if
it is sealed, ensure an mremap() fails.

Of course this doesn't check to see if it _should_ be enabled or not. I'm
being nice by not _insisting_ we export a way for you to determine whether
this config option is enabled or not for the sake of a test (since I don't
want to hold up this series). But that'd be nice! Maybe in a
/sys/kernel/security endpoint...

...but I think we can potentially add this later on so we don't hold things
up here/add yet more to the series. I suspect you and Kees alike would
prioritise getting _this series_ in at this point :)

You could, if you wanted to, check to see if /proc/config.gz exists and
zgrep it (only there if CONFIG_IKCONFIG_PROC is set) and assert based on
that, but you know kinda hacky.

But anyway, FWIW I think it'd be useful to assert that mremap() or munmap()
fails here for system mappings for the sake of it. I guess this is, in
effect, only checking mseal-ing works right? But it at least asserts the
existence of the thing, and that it behaves.

Later on, when you add some way of observing that it's enabled or not, you
can extend the test to check this.

Thanks!
