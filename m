Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18380B;
	Fri, 14 Feb 2025 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492156; cv=fail; b=VGE7NyFi/v1lB/xw6dESEB3SaSSUW3ArjRPzLLCmG7UaHO9NeRK057KkGdWMZXO94Cz57huuztYNVFW2/gkyD3w2nIWEMMAiw6jMgq/q1jeQ7KMhsGBN09yE++gQQAcP/iF/w6nfKdkUaRwN9u9Q9FsAFe5k9unRh4rh/x8uPjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492156; c=relaxed/simple;
	bh=oCwpwj/5TGsUIVLjjD2DBV7ZmfV78uaEXSMyrfIWlLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UnHvO2fq9C1L5JZh1/hNrg+BJ441hzaJkazJPNetSfwdibwWnctKE21Ci6IUm9p5eswgLJ5nsP5TS2YO6dE9gpcjtkK30oICEOnFqglmEGxY4gHKyzvSyMmaW5gcGn/uTGIhV7J+vIxh3sAo3r2uNDcj3zXiH1dBshaMofX2Sfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nMrxMAz0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kh7F/Mbo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nMrxMAz0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kh7F/Mbo"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DLt5qQ026235;
	Fri, 14 Feb 2025 00:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eLQ+A76MInUPb/htkPq3Y5pnSn1uF7WWPGxFHXD2el0=; b=
	nMrxMAz07tRAlo8QlebA5e2G2ocm9x3gX5L8L1REeFp4wJtrbAqHBAVh0YmfA9pY
	AsneBo2ShvuJ75MMedvk6Q88KyT6/CcHU6QBHraDNmGKyzebwZxdfpI25zoIYLgA
	Wh4JAIKj1rnTMnteckfd683RK4D2rSolKSibFZsN+SSzz4PgoOA0yqd9BjvTgOZ3
	QR4SBDqmnxpPZM1esfnJyib0l64SJcBYslEKFMeR+HPn0dDtmvnHJy6XG4EezUvo
	aeacqmU0n3O4usIQTEUFZsBHniEq12jhpN88/SrVFoVKgJlxT660NXi6BaGKMYC/
	tHyYQgWncq3G+Pu6NbyCzQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tnapwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 00:15:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DM5kfr005367;
	Fri, 14 Feb 2025 00:15:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqcfahm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 00:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOhZZw+lwAvOEb0DbaKu7qmdpDw998wPLOO9a/KMr3K6CBf77GL6tiILt5sOj/9B2dYJ7B7ohQnvyzNfBdQkSVt25997bRluraEr7Qn0+xl14UieG7iX9aOOkGFlT6NhR1qhWW62sLWvCeEFNUN5EKpvIVae8gsiea+5UsbHyDWyMArZTEZA0NnrSkeruT3Hoe7bkcrYDbwIM8cjDSQsiJVr0XlsLJRr/r5aElpQaqyW5ouZ1tyZtqBosibeMXuKMbWEYeK3raGRpzA54NaOhGyf9b6OW6W/pJlT0zlszKJVw80tuhT2EJV5gNlsAH9iEdbyPhVOKMVff5fAU9V0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLQ+A76MInUPb/htkPq3Y5pnSn1uF7WWPGxFHXD2el0=;
 b=OgPA5yg+YAKnO89fprTDa1n8/IcubWOAGd92DjcS0yYyJ/VX8mJvp6vtg5YiIJxf+Z5oxojlxFNfRXsXRfvJ+z1IjM0ViKw4K7IKGeTaOVs2VQOPwKeIDpDE7vqMBC7MLpV5LiAdelQjFk/3AuwTKAb2ASWIt+cXdvKzgNNxAZnFCZFTrLULa9Wz600zQ6y04xA9UpsVDssD2i8DS8+VJYaBq3/J4Gc3uG6FC3esDGROBKr+iK6TQUK9sEOjGNq8LeFUYibM6gij5xVon/Ot+AUgpffTahekEuxX9VUtnbpfJLw9i61zVeT6T2jEbZq2qo+zYHJUcQhgVfSB4ZWb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLQ+A76MInUPb/htkPq3Y5pnSn1uF7WWPGxFHXD2el0=;
 b=kh7F/Mbo9ivqOVt9Ec2wrX5wEypMebkpQfn2Lp+buRzjG3UcQBsii2m8U+crSd3hz33MkdxAAxfOJYMhacGteYECCPO6FtmWFCVxQtvzTErqRCzlWNdQQ//pB66zQS782SstE2oYC0MW6FrE+Jiw9WNibC/S/01apBVz3dal3Wo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB8151.namprd10.prod.outlook.com (2603:10b6:8:204::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 00:15:03 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 00:15:03 +0000
Date: Thu, 13 Feb 2025 19:14:36 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com,
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
Message-ID: <tfoitovawb6zwr7nvwfo2mnbahgtnoo6umvecj5mgtie4b5vuf@sloraia3ppfy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, 
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
 <t5hsasch3aybjujmjzs3shpiorcgzp5pjc4fmz77u574voi3hr@qomzrd2llv2q>
 <CABi2SkX3o-PdeuzownVkFT-oo8tjtaaS9ebOALu+r6O1S6W3sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkX3o-PdeuzownVkFT-oo8tjtaaS9ebOALu+r6O1S6W3sg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6929ac-52cf-4e3e-806d-08dd4c8ca0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1kvZXgzZHZCNFQ0T0pNVkM2VE9yc2NjcEREYmZRUnljaGxXcDYxU083NHhY?=
 =?utf-8?B?NUNId3FZb0RRNlZpVTdTeTlvanhqbUt1Z0daMkU0WTd2N2M4cXZuNXhBQkVs?=
 =?utf-8?B?S1lSdDErMDBGY0ppd1o1U0lmTzVwcXMvRHFyb25LWFNNb3lIV0luMFJmUVNV?=
 =?utf-8?B?eEM0d0d6VDdqU0RqMHFYWStRTXJTV2tqditxMTROdzIxWkVrMi9wMVh5WWh6?=
 =?utf-8?B?KzRpak12a1NDdHMxaWVTbDZibGUvQmhqeWFjaThBa0t3WGJ6eXFBVFJpN2Y0?=
 =?utf-8?B?dEdZN1hsMGpFSGJweURrQSs0eGVRUkdTZ2hGMXFIaVZRUldCM3ltbTFZbEhB?=
 =?utf-8?B?dkFCQ3dGZ1ZpQjd5ZVpBdUxkdSs0M3VONGlHaUpQa3dVbUpqSVFHLzBFQmdG?=
 =?utf-8?B?UDNvakdNTmFLaTRZdldBQ0VnUnJYaENHd1BLdnFjVzlFUHlldlEweEx2S01O?=
 =?utf-8?B?QzZOUUZSVk1HeTZ2clVoMjEweVpqZENCMFdCS0xjYU9DZCs3R0VaVFhVWW1l?=
 =?utf-8?B?MnFWa2M3RnpKRm1HUi8vRnZrSGc2YjVPZFB6aUVlMEN3R1U1YkdXS05aMllm?=
 =?utf-8?B?cHFmeEtyWlBhMzlhVUl2T0lkUzlYZUZJNVdCYjFvMnd6bkhxcEk2K0xWZndu?=
 =?utf-8?B?Tk9Fd1M5S2phSWVXVmRrazdjRjNXYVd3ZEUzbVZFdi9kTkJ0M05IUTZ6bWNC?=
 =?utf-8?B?SlRYU3Qzb1hDY2dZUWhzUDkwZHVqNy9TcE82Y3RJUUcvZ0pieE1vVVd4VW1z?=
 =?utf-8?B?Tnp1WURoNzdLZHRTcGNMNW1jUzNQbTBoYTBDL3gwWjhXZWFkOXdiOWVQUGk4?=
 =?utf-8?B?UGFaaHlyU3VKRkNoNEtjRWU0dnBiUXBSS3ltbVZMZ1pmZGFBZ1psbmIwUkQy?=
 =?utf-8?B?R1MxU1ZNZ0lLTzRiYVdlb3RkLzVzTFcrMXd2OUNVSWdBQ3o5NXgxcnVubFJ5?=
 =?utf-8?B?eVQ1N2RjdVFaR3hoR0xhTGRsYzd4WE9EUzRQaFFaQk9jVTFTcVhsOE5yb3kr?=
 =?utf-8?B?TFdxdnVTRDlsNXZHZGMvY2FPYiszbkNrUXRHZVJINi9BOUV2SHBHWHFKaFg4?=
 =?utf-8?B?Zk9jeERGb3ZEUzVpajJVVGxKeksxRXBYN0RhdHVwVkNzaUNlZ3drVkdhWitU?=
 =?utf-8?B?ZzlVc3lHUjRLdUZXcForMHMwT3BEdncxVy8wa2xvUUR2TTNSbzRPVzlCaG85?=
 =?utf-8?B?MUxyejNhMWl2aGp0WldubDhqdXJURGtJZU5TaGlhUHVmWXVrNytxSjlMRlZx?=
 =?utf-8?B?VzhnY3dXeVNnVkdtVGdjM2dYaHlaOFRTMFdCK2lxV0E4Z255M2NTQk5qbXpv?=
 =?utf-8?B?eUw4N050WXpZdHNEaXdZbnlpN3pKeC9LVmdseE9Kc1BwQjc4SC9qMXVkNmFj?=
 =?utf-8?B?RXFiQyt4by9iWDV6eGl2WjR6Mkd0czhlZEdGYXlqSkpvTWNmS1oyOUh4V3p3?=
 =?utf-8?B?VEZlRU1BZGdmYjNlVlJ0WW1udTFaNjJSY2trcW5VME9YSTNWSy9TU3crcm9B?=
 =?utf-8?B?bGtscTd3Q3VvVW0yR2JWQlVZcWl4ellmNTdIMXlQSjM4Q0kxZ25NeHV0VjJI?=
 =?utf-8?B?eUhBVnRpV2lPd2xQRUNUQi9oSHViNXVmVVB5ZjhONG4zTFJUR1dqMVhKa0NB?=
 =?utf-8?B?QWxMQzdKV1Jucm41QUNtcTVkWjEvL2xIZW04VENONCt3S1ZQY2JxNWVEVVBs?=
 =?utf-8?B?SEE1Wm8zWDlHTkh1TjNmVXpPZDBRT1lWQ0s1VkdOQTlvdDFmRlI3bTJ6dG0x?=
 =?utf-8?B?UERWMXZob1lVMlg2QnJoQk1xRXNLaENKemFmTXZRNTNFcjdwWVFDSi8xUVp1?=
 =?utf-8?B?elg0UmdUME5jZkg0dno0TzhmMzAza3VUVmRCRjRXTG9adFlrVzB1NHQweE9z?=
 =?utf-8?Q?xn2kS9dyEa/rH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T21LaVI3dDVTOUZscWtDMWNKVUpjd1orUTFsTVY0dWRHRTJ2TVdZc1RMd3k4?=
 =?utf-8?B?eTJ2MkIyTzhkb1BqN1hKRlBWQXdxNkhoalZRaEp1MHFsNlIxd1hKWjE1a0Qx?=
 =?utf-8?B?VHpQektlUTFUWUY3eitHeFhQVFpJMjk5SXBWRDlDd1ZyRFJGUlRXUDRBUXJo?=
 =?utf-8?B?M3ZUK2ljS1FQQm9zeTZoTUVBKzNNUndLSndjZVkxUWxQSmJOaVUxVUJFaG40?=
 =?utf-8?B?Z3ZGdThtOUNHam1vUTY2OTlPcmo2N2IyTmpaWGVHdWpVaWxVbjh2VFJReTJX?=
 =?utf-8?B?LzdiWmpyemhuSFVjdkw4QkkxazhjWk0rU3NCRWp4QWtnNmRZMCtsQ2VtdjNQ?=
 =?utf-8?B?UFZ4NUY2VHVMTWZWVkowOHpmT1AwalRVcGx0Y1dIK2w4Z0lxeTgvMEJTdnZk?=
 =?utf-8?B?emxPSzloZFhyS2MydjU2SnN5Q3JLMDJNcEk4WlREcGZNVlZMY3U5cUoybjhL?=
 =?utf-8?B?YU9LVW05M0IvVjluTUFLcGtoS2c4ZTBMWTJEQ3JYckVWNHYvY1F6S1MrQ1NJ?=
 =?utf-8?B?NVhCK25saHJ4cnFOZ1pvbDV5cnllWHlhSG0zYzZiMnNORVByRG9JUHNHajkr?=
 =?utf-8?B?blNETnBVaWJmYlgxRUVVZ0xXRTFBSHZmVm53b1dqcm1sL0FtWUo2WGpzZWdt?=
 =?utf-8?B?dDBxZ0p2NjJCZlR5dVU0dlNSR0tkb2lSem1jeGtLRDJncXFjWXN1a2JwSzBH?=
 =?utf-8?B?SmNBVk8xR2hZb0E1Ukc2dTJiSFFPd3FzMHh1YStoK1g5ZlUvMTEwT21lb0p6?=
 =?utf-8?B?aTlCR25qRU5RbmE2MkZoRmtYb2oxYUN0TWUvT2ppOVN6bWpQZE1LWWZSMjhS?=
 =?utf-8?B?T0RCOG11MlRhakJSdk1sVjR1SlNYR3pmWE1uUjhtK1ZXaGI4S1gySUxzWDFS?=
 =?utf-8?B?WkV6Z3dOekdpUDcrMXZVeGtKR3ZyVlRyNE1TeWN6WWViSHE2Y1pYaWc2aXh3?=
 =?utf-8?B?QTNGZFlJMUhoV2xqd1Y3bzhoMGxwWEZ1ZWY4RFhvRUQxYi9RTWlKVVA4a2xj?=
 =?utf-8?B?NEtKbkhLQ0pMNU12dVJ6dmxiTWJCanZSN01HUmJWM3IxVmdEd091VmN0R05X?=
 =?utf-8?B?VnBaQ2kvOC9GY2J0M2d1NlV0RUVIOFBkSllON0M2NSt5THNyVitYbGsvdjRr?=
 =?utf-8?B?MW5wZzl3MTZjeFArT0RDVGZxL1YybTl1RytRMWU5OFN3U09ySmtFeHVjNVJJ?=
 =?utf-8?B?NE5DelBKMERvWUU3eUppVkNLU0ZFUVRCa09SYUh6dXdBeFA1dG5mRmJCbFMr?=
 =?utf-8?B?MHljTDUvdjdQcmxnU09vdkVXS3g0aHd1YXFuMUJuZVNaaDdZSlo5WWNJRE84?=
 =?utf-8?B?cGlGeDZYeHREWGd5VkY1OTkrVkd1OGJjeWxkOCsySXhpZWY5QnR5S1gzZ09D?=
 =?utf-8?B?b3Vjb3dXdDQycGNTYTdiVGFuUkFnMXlxcUk5YVpvWFVkWkN5TG4rSnI1eEJl?=
 =?utf-8?B?VzMwS0VwRlJwdzFlUGJsbmNVRkIxWklxODlFS0NVWjhxOGozV2thWDRrbkRI?=
 =?utf-8?B?V2VaK2orSzdHYXF5bXl3cFJpYm5va3RaSU90cnVnRzNyZDBMQ0RLS0toQzlo?=
 =?utf-8?B?dkNhcTc3Qnd6UnN0a2ZZU1pVZ0s2M0FHZEpFK3Y5Qi9rR25qQTZTTVFGYXNq?=
 =?utf-8?B?MGx5K203dUE1K2FFZnpaTFNkRVE0dW9LUFExdVFSODhuSC9SSytxNmI4ODc2?=
 =?utf-8?B?RlhMMk81TVlTeFhQS0R0WDRsTXlnVlFaNUIyQkpYU2hET1M5MkV1ejlXRHhO?=
 =?utf-8?B?c1Y0aEdkbGhiRWQzZFQ5b1BBZ0FjL210MXFqSEIwK25EaDdnS1RReVVZTS8w?=
 =?utf-8?B?R1MrUlpncWVYMzBKZTRramxWV3lNQXBZcTZESkFqVUcxTVRtVkZVSEl3aGFO?=
 =?utf-8?B?a0V0N1FCdHdXeGw1aTI2OFlDUm1oRmVNNGdPZjRRU3N5N2xZUmFHLzVJdWRY?=
 =?utf-8?B?Z0Q1Wnh3ZGVrNlY2RmhCYXhqdFRuL3ZCZkFDTy9QUkhjbkgvT1pJTkxBaHZx?=
 =?utf-8?B?alBjK3lUcm5yVmFwNStlOEhNSWVaWDh6MmJ1aGdNMFVnNm9seitKR2xhSzln?=
 =?utf-8?B?Y2xOOE56R0xOY2VsUktEcVNXVXg0OWN1M1l5cm1QQjJaclB4ZzVMV0pqM0gr?=
 =?utf-8?Q?tSY7WVQ9pbkov7dwuIkXjkG+5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P014dx5fNlXMEwnkZutQ3eWMwHcpCDSieD998RBLWgDrpZmdof5wd2A2MeWY2+cSBwU3UMnE90Re8ucP21u7OFkczfymUreh10CYzAOmt4DCaUB1IZH3lwEn/bfc+QIiIjMFnzaEndBk2Y0L8cer56klOVY5bAXRm/0CDY8KByeMk89gBnU0vBfiLM2gSHcx8HpeEtljdklXoHaa70COkgxNip8Egg123aBKYId14c95MNccUAh/4ZNuBHbZqgxB3ufhQbbbQt/jSw6oZWG1abzFKBh8xpQj80UTefFYsKWJAPKpWLHGwTIb2CgLLtzd4etKTRPlB+q32VbRxs3TAA5Drq56IaU9jwnZwkp6SPO/P/nmqhtJ/kbxVoLGS01nDkwzNJCNeWMK8iTOueQSbMwdWFve5iNr1nDTbWNQXXenvGHy0S2ivCPPePERtNTDupjVvofn2dnQrpiuBiYnkhFAARASlC/5J4TvKzYzZzrFLvASuVtgjKiGHDgOOK+gwgiJxR/WWz3fRal67LcdEoecwPZTPt4z25Y/PzmqkWpuvpqoTBwvH3ud1X5jtQixgB8Rl1BfW/8YZrkqthrMiuS2bqrkezj0SinmeKHKBU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6929ac-52cf-4e3e-806d-08dd4c8ca0da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:15:03.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXNS0JOPO08MGsbcL6ao5GwWMxsP+9G7DlX0cT0PXmLl7vcxZqsCgv6qdsQ8Rv7bxHEvG6LXfqzjLoidl5C8CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130170
X-Proofpoint-GUID: woR9PumDPQDoY5-8wTxeshohc-LrkgWA
X-Proofpoint-ORIG-GUID: woR9PumDPQDoY5-8wTxeshohc-LrkgWA

* Jeff Xu <jeffxu@chromium.org> [250213 17:00]:
> On Thu, Feb 13, 2025 at 12:54=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
>=20
> > > > >
> > > > > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part=
 of
> > > > > the build. This is intentional. Any 32-bit code trying to use the
> > > > > sealing function or the VM_SEALED flag will immediately fail
> > > > > compilation. This makes it easier to identify incorrect usage.
> > > >
> > > > So you are against using the #define because the VM_SYSTEM_SEAL wil=
l be
> > > > defined, even though it will be VM_NONE?  This is no worse than a
> > > > function that returns 0, and it aligns better with what we have tod=
ay in
> > > > that it can be put in the list of other flags.
> > >
> > > When I was reading through all of this and considering the history of
> > > its development goals, it strikes me that a function is easier for th=
e
> > > future if/when this can be made a boot-time setting.
> > >
> >
> > Reworking this change to function as a boot-time parameter, or whatever=
,
> > would not be a significant amount of work, if/when the time comes.
> > Since we don't know what the future holds, it it unnecessary to enginee=
r
> > in a potential change for a future version when the change is easy
> > enough to make later and keep the code cleaner now.
> >
> Sure, I will put the function in mm.h for this patch. We can find a
> proper place when it is time to implement the boot-time parameter
> change.
>=20
> The call stack for sealing system mapping is something like below:
>=20
> install_special_mapping (mm/mmap.c)
> map_vdso (arch/x86/entry/vdso/vma.c)
> load_elf_binary (fs/binfmt_elf.c)
> load_misc_binary (fs/binfmt_misc.c)
> bprm_execve (fs/exec.c)
> do_execveat_common
> __x64_sys_execve
> do_syscall_64
>=20
> IMO, there's a clear divide between the API implementer and the API user.
> mm and mm.h are the providers, offering the core mm functionality
> through APIs/data structures like install_special_mapping().
>=20
> The exe layer (bprm_execve, map_vdso, etc)  is the consumer of the
> install_special_mapping.
> The logic related to checking if sealing system mapping is enabled
> belongs to the exe layer.

Since this is an all or nothing enabling, there is no reason to have
each caller check the same thing and do the same action. You should put
the logic into the provider - they all end up doing the same thing.

Also, this is a compile time option so it doesn't even need to be
checked on execution - just apply it in the first place, at the source.
Your static inline function was already doing this...?

I'm confused as to what you are arguing here because it goes against
what you had and what I suggested.  The alternative you are suggesting
is more code, more instructions, and the best outcome is the same
result.

>=20
> >
> > > If mm maintainers prefer a #define for now, that's fine of course. Th=
e
> > > value of VM_SYSTEM_SEAL can be VM_NONE on 32-bit.
> >
> > Thanks.  I think having a flag with VM_NONE on 32-bit is just as sane a=
s
> > a "flags |=3D system_seal()" call that unconditionally returns 0 on
> > 32-bit.
> >
> Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu.c=
,
>=20
> #ifdef CONFIG_64BIT
> [ilog2(VM_SEALED)] =3D "sl",
> #endif
>=20
> If #ifdef CONFIG_64BIT is missing, it won't be detected during compile ti=
me.
>=20
> Setting VM_SEALED to VM_NONE could simplify the coding in some cases
> (get/set case), but it might make other cases error prone.
>=20
> I would prefer to not have VM_SEALED for 32 bit.

But what I posted leaves VM_SEALED undefined for 32 bit, it defines
VM_SYSTEM_SEALED which can be placed, for instance, into
_install_special_mapping() arguments directly.  Reducing the change to
just adding a new flag to the list.  And it's applied to all system
mappings based on if it's enabled on compile or not.

Also:
include/linux/mm.h:#define VM_NONE              0x00000000
so, I'm not sure what evaluation you are concerned about?  It would be
defined as 0.

Thanks,
Liam


