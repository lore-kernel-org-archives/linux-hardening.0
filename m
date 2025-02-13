Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC11419A9;
	Thu, 13 Feb 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471462; cv=fail; b=BmFDikAcbE+3hejV2KdPLLCLGZVAEpL7Ne1Ux6u79tIzlcBA6WEIKqOgN3JvjKF9p/KDzVTF9T1LTGL/FOX/ZjtYVBbsiFmBeOvGlyz1+CclJLd9mPcMt2ZD41XjHr8jIqspp+MGxXHi6AqkGneUPGwUe4t36h0oPgF0y3V/wSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471462; c=relaxed/simple;
	bh=kGtSATLz91SnKIelD8407qLOkeFzhN4y/0Ue0d7lFFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pbAOtELgBuVqJ/Rus6P2neM0uwVGQuSOiSoHtdpKMWCkw2t4dK57pN045qu2P6K4HIdkZdGCrPHwWpPD5XDB/N3UddcgiF+zeKDuRx5C6e8+47QcOfAxoxzAiTkhhH/1xwwnrt+3kR8FEGs7saeVGBpp6oDA+NbL1p5Ktx27vAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dNl3r17s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SpYZkrmo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dNl3r17s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SpYZkrmo"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfgWm015284;
	Thu, 13 Feb 2025 18:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ya369UoJpLJRjMLgt0D4m87GFwBHR892fKs3fxpgugk=; b=
	dNl3r17srlz86brnqc45LwEXWrtzrKQCqJIR2ORDSP0KmzpxKDuXoUViV4hxySaR
	d7VNj3Z/wnwjpx5IJKJFEawqNGVP6DTAQL/+odLsVOWELmCi3nzdwflwgnhee54D
	SHLHD9X+9k56wVjpAGfwxR7cLnNXgxCOjBfwgoVHyhyT4ZmrW3IiE3eZiPL0ejid
	tMtps5zKl8qVhUk07a3Fc2JAeykLDIGmoqKR1K7kt+4sGwOpUHOba91AF4SI2pqz
	DOr6ZH+ohn4JLnzoqgCJ0Jvc32zv0y5OSr+d91/TjvTagmu7XXi97389dGZuE11F
	g4YXUDxZPz8uD0mHQXpb9Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4a59d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:29:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHF4mv017452;
	Thu, 13 Feb 2025 18:29:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqje285-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSz69bz3kfKB6BvmE/NtQBWY956IaBMD5WC+HzrhFXg9rsbvHVGHe4TVwrXaUECqoT9x8P80ZxRxQsmFxEayOpv5KIU7GTA1q5olDho2KikJHOzO6D3kvJ1C3qkUyDpjyVwcdzHYg7tqY1cBzMi9fnfdDErbKE3GEXbJBBYU72SexymvxYQe1XKequJfub7QgOn64ijMaV3l8WS7UZewV5MCIal96WJ6R0Ny1ZQk/PFLppAZOqpmyaLXZYBmSTy59dRjdTaJstqVUiz1rci2YakqDiZwLSidIkf6mJRQKi2eOKZK/hkyAvedE3PTmR/zeRWnSOiRE0MUlPJrueHdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya369UoJpLJRjMLgt0D4m87GFwBHR892fKs3fxpgugk=;
 b=twih2pfqT+D8Oyu6paXFZXS4WBMuqTIEOPGtevm/X1nDt5kPgq9l/FgN/6LLLLDjQMZjYQYskQD8RE+mT5KsAdw46GTX+xQ5br8sgzVBV3UO8DgsqF4bkwLRN1+06hor4yS4dCpohhWm7MqJPcc/rb7zsfnrF1BC3cKcHutkYjtNOUz3uPK69Afd0KAKFWhbxF8Mpw5srUvOjpRln8nIAFMwDoDu2NcV7dA8xRsGj3ZT33ty1jjG8VvLfdPffoEn1gE6jZ3tqxl3Zru74vXdaflvJwqaDpfSCRL9/zcMC7/Lwxsa8K4UgxC6bc2MwzyVvRnPbGegglYAaZJ/NcGVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya369UoJpLJRjMLgt0D4m87GFwBHR892fKs3fxpgugk=;
 b=SpYZkrmoDOOKUOYwWnU0/3ARpajKlA8gqvfKWVxKkzQ1SCjuWJU1friiQ/u2zulvcV3cUWnl5/c6rLa3oJx4rCB/p187fpaE5vfWqzypcmWyexBIZAqONyBUcMCQ/N8LQPlHM9ySbeOJKIfd94B/KY3VwP7RuKs/1DiNlSxnIxw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB5803.namprd10.prod.outlook.com (2603:10b6:a03:427::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:29:52 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 18:29:52 +0000
Date: Thu, 13 Feb 2025 13:29:46 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
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
Message-ID: <66q7feybn3q2vuam72uwmai322jdx3jtv2m5xmh75l6w6etqiv@knpsyh3o627k>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, keescook@chromium.org, 
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: b4189902-93ec-4a30-b8ab-08dd4c5c680b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjRPNEFaajhtOUl1dVBwclpldENTMnVZU3B3YWVIUmUyc3NneFZoSHdYV2c1?=
 =?utf-8?B?Z2JORkFNS21CaTE0cnh2SlRFMWxheEVHWTlGd3BJZnZnRDUzNHdUenFybkc0?=
 =?utf-8?B?OFFGYXdRaTAyQ0VBNENTMGZsdDhFUi9uSUhLcUFCME9NNDF0RDA3VjBUamxR?=
 =?utf-8?B?SWExNWtHbzZqRmo1TUhHZ0JTN2NpTVhWTkhSWjZLWjA5ajJHU29KaWNGYlpU?=
 =?utf-8?B?WFdkbE1xeTEraUpqN3QzQTFVbUw3cUNzNE5zVC8xSis5amNnVit5L3R3YWds?=
 =?utf-8?B?dnVjeXg4MFlnZ3Rtc1YvY0hNenJ0K25mWFFobXR2R2hIbUllUHhCWVJ4UFZQ?=
 =?utf-8?B?TXFQZmxvTWlZWlBaNGM4MXhQaUFIcnBKYkE4cms5SC9tR2wrZWFFeDFpODN3?=
 =?utf-8?B?QWRScXg1YVFXbTVhK25TZFNXTkx5TmthbzRSc21MR2QyL0JGUmJXTmpGTlli?=
 =?utf-8?B?MEJvdEVHMTVnVjMyNXp1Z2JBVDh1aGpkbGtSWkpiaTNaaUNKaHdSK0l0MlYx?=
 =?utf-8?B?NlJzdWdEbUllbVdnT3hQWTBDekNacCthS1NxaDJaQXd4OCtyTkVSRlZNR0R6?=
 =?utf-8?B?bXB4d1VGaCtQU0RqYkp0U2h4RVhNaWk5aExzd3BkTnJsQTVCUzg1ODdUM1NG?=
 =?utf-8?B?d3NJbXc5bVFBd1RKMGFXN01MQUQxUFZWWVpwNFFrNFdMNURlZVFzYTN6cnJ4?=
 =?utf-8?B?KzVYYWx3K3VlV0ZSNjNQaWJlTEF4eVR4dk1DUW5OVDI3QTZzKzU5OEpSMXl0?=
 =?utf-8?B?RURldlBaM3RrVi91emw0eE9YdVNaTjJpaDNGZVE4RWNHSTg1dlRRaEVIVldm?=
 =?utf-8?B?d1BhQVBTZEJ6QlJLU2s1YkVsYW1FMkh3UzdEbTBqY1Q1Z0lIUGFjd3UyWGl2?=
 =?utf-8?B?SC9ZYUFLamtCYnd5cFJpdFpibjhGNlI1ZnBITEVKNU5qQUExODlFcUQxTkpi?=
 =?utf-8?B?QlJVRWpIM280ZlIyMFE4UENHbmhINk5jOE5uNkVuK09MV3duMmFTemU1dDlz?=
 =?utf-8?B?R2Nid0JtNVQ5eS9SL2hkTzRnR2c0ZXNNU1dPcHFtbGM1aFpudGRSSFFyOWhu?=
 =?utf-8?B?YzlrYVNpYzNONlE4VkNFeW9UUFNtaGttbWVTTHJ6TmNwQm5SdXhuOFY4RmNH?=
 =?utf-8?B?UkwwVDNWSFM4eUI2YmpqNDB3Z1FYTmpqdjV2dEJHazFsU0xneU5aVVNnVWhH?=
 =?utf-8?B?ZVBjWmNjRGgwS2NXSUlZeVEvaDNMNHdjQ0FTNEVSSTNCTXBmVUloeUhSSmJF?=
 =?utf-8?B?MUduNlczbldRZE4wL2sxQmRUSDhCS3ZPMFJuRmR6L0ZiNU8weXVITFh3RFJ4?=
 =?utf-8?B?TlcybS9XdnZGSjdqVktxaFpxbVdvSWtZbk53TG0yOWR5dzY1VGZQNzFrcTRk?=
 =?utf-8?B?TUtvMFFZdUFZa0liWXVYTS9Zd3RJeTJrTUtLS2RicHY4Zmh0WG82OG55ay9H?=
 =?utf-8?B?RE16Nkl6VVdvRVkvZnFDQUhEV0twNDNCT2JJQk4zUjhxa2gwMVFrQStBdll0?=
 =?utf-8?B?K0VoUElyblZEWXNIQnZmUFJ2QTVhK0hsdXlHbndtTUVmWjMyUWo1aFk4QllR?=
 =?utf-8?B?MWFlTHBLYXhxdnpLMHZjelFKV3dvS2R6dy9BVFd6bWJHcEZldVFNeG5iUi9B?=
 =?utf-8?B?K016czg1OWJ1emhhMGh4bGpUa3dTUTRDLzBmNm9vYjlhUlhiMCtIampzdjE2?=
 =?utf-8?B?MEZ1dkVGZlEvZjVDZ1hrczdyL0VwUHg0QlBUeEJ1bzJrdndzSk9wWDdUbDVI?=
 =?utf-8?B?cTMvQU9Yc2VjVmwrMDZxZGhDY2lJcVVQTStPZUxSRC9BSkVHRkJuTU12bnpy?=
 =?utf-8?B?d2tDTkNQZk5ueG5iTHF2UHp3QWdmVmlvbFVTQXp3MzloVzBjWmRDSXVrQXdU?=
 =?utf-8?Q?JCowa0S29a7md?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlJmQ2I3dFhlZHpRaHRpa3k5TFh2K1YwZm1vcnNlOVZwZHQvZFUrbWxGM2FQ?=
 =?utf-8?B?V3MyMVg2aVpyaFZjNEdRS3hEN01LbjFGZXFUVXhiSFUxWVZZWVIwWXhNdWth?=
 =?utf-8?B?ZmJRR3o0M012NmV5NGNYRTk4ZjFaY1hlSFkvWnR1RFdVQndIN0dWcGQ5dDVH?=
 =?utf-8?B?MUFLeWQ2aE9LbWF6REI3WmxoK3hxdXlMclhRdlNhK1o5Q051azdiVHc5WnRW?=
 =?utf-8?B?ellaNzUwZXFiMGEybVl0dkU1cjRNbVFTR2RNYWRSYlYwakVJL3g5VUd6WDE5?=
 =?utf-8?B?YWc2WUI0dzA5UDVWYjNQOFVYdGRWWHRnMTZySFAxZlVTWW1Sekd5S3l0S2w1?=
 =?utf-8?B?aVMvVjRTTEJkdDdpVG1laTZGMnhKckFtS3BQOFBoOXRrT1RsbGlBNG5VL2hV?=
 =?utf-8?B?RlFXdWhYT2NOSjIxblB3MExVWEY2T0dsOE5IWjVOQ3FBMlFmcEJnS2wydFRC?=
 =?utf-8?B?YTdmbTYvZlloSkhsTC9PUWV3b0lyVFBUUHFWeW5rMm56dktOR0tid1N0WXJt?=
 =?utf-8?B?RlkrY2xzOFEzVmEvak9rdVlBZVBKc29BYzl6ZVVSV1J4YUZzcjlwNlJ4OEFp?=
 =?utf-8?B?SFlrZTJ3VGg1blhscG96aDlQZjk3S2k2STZKZnY2a0xSSEZqcDhYNE9xNGRZ?=
 =?utf-8?B?WXdjWE1EMW9naVlUTTI1ZzAwRGpUM0hKMVZGUCtKTGYzaExRVWhIU0F3N1Vm?=
 =?utf-8?B?Z1VoU2dOa2s2TUJuMHBPNmRzOWNtMXNRMFlsY1A5ZEhiWFV4blN3QzJyUGdK?=
 =?utf-8?B?MHJJY1lycEsrUmhDQTBCS0JTZ2FaYmpHSWdHUndYNUF0QjZWbVhZV2g3bzNn?=
 =?utf-8?B?ZnNpR3ZsVXo4czQxaG1KbTlUcjFkNEwyMnNyNnpKWWJnenRvV0JSdC9naEQv?=
 =?utf-8?B?NUJiemZhWXR6S0pwYkRnTktSRnRoVmM0N2RYVHg0TlcwaER3cVpxamxNZUlx?=
 =?utf-8?B?UHJMSElRWDRDczNOWDRPNGwrczFqd0FoSGloMnpYRnJvdC9Pd0hqOUhuMFVR?=
 =?utf-8?B?ZG9PTmgvRkJTTUdlSGt4b0pGZ3pzV1dwekUrRTcrZmd3ZlhCck02YS94bWZq?=
 =?utf-8?B?Y3J2SXlUdXZTVWErNUZXYUNNSlJqeHJhQVdDYmY4YURiRDZoSzVnekxLNXhY?=
 =?utf-8?B?Q2VBTllHOG5iWGFtNHBtc2tTRmFUYStEUytFZkdyYzRYeUkyQUNxb24yVmdM?=
 =?utf-8?B?R2oxcS9xUTY1a2Qvc3NuYTJBc29seDFYL2tUYVBFMm1jNEJIYzVYUnJhRmd3?=
 =?utf-8?B?eENYd2tZNnBOVjAvaDVMZ3hIcVFMeU0vY1crQzMvTHQ1R2pxZzg1MUxjZ1d1?=
 =?utf-8?B?Y3ZQbkRoRkNyeDJOYTVlalNVV0U1MkthNStLc0FGUHVhWWF0UTBWbVBvV0R4?=
 =?utf-8?B?b1loYXZGejN2azhLdWNVOEorTmlRTDlUZW1XZE1KWXhlSHlrcFFyL2t6aVdt?=
 =?utf-8?B?cXNVcWVmVm9aM0djNmpTRUpGbEFKSkZLVGducUEvR1JKYUJRUDM0enREMkZz?=
 =?utf-8?B?SXJkRU8zUjZ3QURxMTBqQVAxdHNWR1d4TFVZVHhHa1h5bnU5eFVKM1BQa0ly?=
 =?utf-8?B?ZHByVTUzeG1MR0J6N3Zlb2hXelpPaC8zR2VBbnkzd0d5d3E1QkxVK1RtK2ZT?=
 =?utf-8?B?Ukp5YlMreHh2YkdCZXF0dlNWamxXcXJ2S2NLRkxLRm55RTk3YU5GQlJ1WHBu?=
 =?utf-8?B?ZWxWZU45R0NiM2hGcnFBWTZtV0JhcFBIeVo1LzVMbzlyTm5PdUJPS0JSRk1l?=
 =?utf-8?B?bFI5MDZINGN4dXhMMzRMb1hzS0dZN0ZldWRTWGZEU1p4WS82a2kwWTlyYUEw?=
 =?utf-8?B?NVFlZ0dNcUNXWFpqcUJSZTRDOVN5WnVTN3VkYTFGamZsVDRWQzNWbHpsU0xP?=
 =?utf-8?B?aHJnUkx2S1BBQzZuem85K3dEamRVRnhpOURSRnFpSm5yeHFHR25CdmlzSEMr?=
 =?utf-8?B?V2hGNnJJYjRvTGdMckhtdkFKaWtmN1pXYXNpUStiNW5ZSktNSjdIbjhwMHdo?=
 =?utf-8?B?WlFGL2RIOGxVVkRPeG9kL01ESXVHdnM0Z1pVWEFFbGNDUEFOdHdpTGxwSVFQ?=
 =?utf-8?B?L3l6MWV2dUFSWGZydHZPWk5SaVNkc3d3UFVYWXorNk91MHp5d01YaXlwYmR1?=
 =?utf-8?Q?05XivUlkeala3W7S8yhJ10Yf3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2ydj+clssTPqnFHif/l40pwTC7yCzVEw7ULkR5BhIrroCU+vEkhTB42dpeatz2wgq4QfHI0TVgsVyY4q6ELiGVcgbH+KkNVvRyqcne9CxHRcR/FMMYYD5j6YPTITMsfcq1oY+2nkooOmu6YfLxX1uP699gtvC2LTtyY9Fmy8RXbXA+N/ohSjQxLs7a7Ka7kxpcqPQ6xxXeEBige+Nf17UJKSJpJxut+u1/FVGDolFVgVn/hRFMf5IKSfEJ6hZYBhnPGtKJwlmLuy3nYFJDN0xTxvc8EtIb0J31skrysuO6VFHq4RQ6TNhJL+19KDbHgTVkwuBWBZHbuT54aXWP1B8FuUu0zpYLkB532CyHWkj+SaNq/KIiuVnSbr68vAuIF8F7nfbpdj3p4gh4D1tFjDzignxr72UjKAOxLCTFfDM60l9tW2Tqg73nKy3q/HYfVx4n/TOjkUv9X5spYXBS7BuhuAFT/RuMPu9lrDxELlnjmjyDOmeWqpLKUqll2G1i5Cv9PwOLgMGv7Ychy2wdqwQhVFBitXMjwOUkJUksJU6gkvLVSskZHx9qCyRL1A5IbNROk5OvZrpCKN4ygvkznE9w5MjNY1C7xEDBHyJDCQ4Ms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4189902-93ec-4a30-b8ab-08dd4c5c680b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:29:52.5181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5f1Fp+9Umtc7orUwRN2/cCkQODlM+9hFv2QeKp6PKa06fVPaWcI1DqJ5ivwJ901nUbc8Ei85imT8PVyPcpc7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130131
X-Proofpoint-ORIG-GUID: -ScDjK7gwTleqZiRSLUoFM_AwtrPnoOT
X-Proofpoint-GUID: -ScDjK7gwTleqZiRSLUoFM_AwtrPnoOT

* Jeff Xu <jeffxu@chromium.org> [250213 12:17]:
> On Wed, Feb 12, 2025 at 7:05=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> ...
> > >
> > > In this version, we've improved the handling of system mapping sealin=
g from
> > > previous versions, instead of modifying the _install_special_mapping
> > > function itself, which would affect all architectures, we now call
> > > _install_special_mapping with a sealing flag only within the specific
> > > architecture that requires it. This targeted approach offers two key
> > > advantages: 1) It limits the code change's impact to the necessary
> > > architectures, and 2) It aligns with the software architecture by kee=
ping
> > > the core memory management within the mm layer, while delegating the
> > > decision of sealing system mappings to the individual architecture, w=
hich
> > > is particularly relevant since 32-bit architectures never require sea=
ling.
> > >
> > > Additionally, this patch introduces a new header,
> > > include/linux/usrprocess.h, which contains the mseal_system_mappings(=
)
> > > function. This function helps the architecture determine if system
> > > mapping is enabled within the current kernel configuration. It can be
> > > extended in the future to handle opt-in/out prctl for enabling system
> > > mapping sealing at the process level or a kernel cmdline feature.
> > >
> > > A new header file was introduced because it was difficult to find the
> > > best location for this function. Although include/linux/mm.h was
> > > considered, this feature is more closely related to user processes
> > > than core memory management. Additionally, future prctl or kernel
> > > cmd-line implementations for this feature would not fit within the
> > > scope of core memory management or mseal.c. This is relevant because
> > > if we add unit-tests for mseal.c in the future, we would want to limi=
t
> > > mseal.c's dependencies to core memory management.
> > >
> ...
> > >
> > > diff --git a/include/linux/userprocess.h b/include/linux/userprocess.=
h
> > > new file mode 100644
> > > index 000000000000..bd11e2e972c5
> > > --- /dev/null
> > > +++ b/include/linux/userprocess.h
> > > @@ -0,0 +1,18 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_USER_PROCESS_H
> > > +#define _LINUX_USER_PROCESS_H
> > > +#include <linux/mm.h>
> >
> > Why is this in a new file and not mm.h directly?  Anyone who needs to
> > use this will pull in mm.h anyways, and probably already has mm.h
> > included.
> >
> The commit message includes the reason. I've snipped and left the
> relevant portion for easy reference, please see the beginning of this
> email.

This is a _really_ good reason NOT to stack the entire patch set
description into a single patch description.  Within the above 111 lines
of text, I missed that statement.

When Andrew takes the first patch, he'll put the patch description in
there, and then we can actually concentrate on the patch with the
limited context of what is going on.

If it doesn't go through Andrew's branch, then we can fall back to each
patch standing on its own with the change stating why things are done.


Also, I don't agree with your stated reason for a new header.

Please remove this header until it is needed.  It can be added later if
it is needed.  If we all had tiny headers because we might need them in
the future, we'd have serious issues finding anything and the list of
included headers would be huge.

You have added unnecessary changes and complications to this patch set
on v5.

>=20
> > > +
> > > +/*
> > > + * mseal of userspace process's system mappings.
> > > + */
> > > +static inline unsigned long mseal_system_mappings(void)
> > > +{
> > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > +     return VM_SEALED;
> > > +#else
> > > +     return 0;
> > > +#endif
> > > +}
> > > +
> > > +#endif
> >
> > Looking in mm.h, there are examples of config checks which either set
> > the bit or set it to 0.  This means you wouldn't need the function at
> > all and the precompiler would do all the work (although with a static
> > inline, I'm not sure it would make a big difference in instructions).
> >
> > For instance, you could do:
> > #ifdef CONFIG_64BIT
> > /* VM is sealed, in vm_flags */
> > #define VM_SEALED       _BITUL(63)
> >
> > #ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > #define VM_SYSTEM_SEAL          VM_SEALED
> > else
> > #define VM_SYSTEM_SEAL          VM_NONE
> > #endif
> >
> > #else /* CONFIG_64BIT */
> > #define VM_SYSTEM_SEAL          VM_NONE
> > #endif
> >
> > Then you can use VM_SYSTEM_SEAL in the system mappings function in the
> > list of flags instead of having a variable + calling the static
> > function.
> >
> > I didn't look close enough to see if the 32bit version is necessary.
> >
> I'm aware of the other pattern.
>=20
> VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
> the build. This is intentional. Any 32-bit code trying to use the
> sealing function or the VM_SEALED flag will immediately fail
> compilation. This makes it easier to identify incorrect usage.

So you are against using the #define because the VM_SYSTEM_SEAL will be
defined, even though it will be VM_NONE?  This is no worse than a
function that returns 0, and it aligns better with what we have today in
that it can be put in the list of other flags.

Also, my vote for where you should put this code is clear: it should
live with the mseal #define in mm.h.  You're going to need mm.h anyways,
and that's a big hint as to where it should live.

>=20
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index d0d021b3fa3b..892d2bcdf397 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> > >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> > >       bool
> > >
> > > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> >
> > ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS is more clear.  HAS may mean it's
> > supported or it could mean it's enabled. SUPPORTS is more clear that
> > this is set if an arch supports the feature.  After all, I think HAS
> > here means it "has support for" mseal system mappings.
> >
> > I see that both are used (HAS and SUPPORTS), but I'm still not sure wha=
t
> > HAS means in other contexts without digging.
> >
> The existing pattern is to indicate arch support with
> CONFIG_ARCH_HAS_N and   security/KConfig to have CONFIG_N as the main
> switch. For example, CONFIG_ARCH_HAS_FORTIFY_SOURCE and
> CONFIG_FORTIFY_SOURCE. Since the MSEAL_SYSTEM_MAPPINGS is placed in
> security/Kconfig, hence I'm following the existing pattern in
> security/Kconfig.

Okay, thanks.  I really think SUPPORTS is more clear, but sticking with
whatever your area uses is also fine.

...

Thanks,
Liam
