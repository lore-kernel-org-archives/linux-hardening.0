Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1B14EC47;
	Wed, 16 Oct 2024 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729120773; cv=fail; b=OIGkE30oDcBUqAZt81j8msQrRT9MirZcodO1JvQ7WJmEO4Ss7+DRSl2YMQLRborR4C4XnD/C0ufEYeGipTWpbkBOsaB3aJhH7AGxC72B/GK+X9OP2QjpqRm1tyD90s4018z5XU2qv7KeYO8CsdTzCFpy+mSINz5aqfhodff8zsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729120773; c=relaxed/simple;
	bh=7+3LRYVsmsP62QvLR26Yy7IHiRNDQdb0s2GGUSE4edk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mzm0Az0rJ3HDzd4CP+0SoyygsQb4vGBbIGQf7mOjxJj4AaJwAizOFXFLjFj3bRhdadvNKDmr6aDySu9U8QmYo0UiPLZHW0GMSghVhrmXjvnPJutmJm3Ky1+MW3uRt18Zrgv3WUztHo7+sP2XQlOnYtvrCga54ftX2YpUS+t7tkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=irnb3k2h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rbyXdm+w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="irnb3k2h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rbyXdm+w"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GKwabL007320;
	Wed, 16 Oct 2024 23:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=75IZ2WjjPSO4CoWci+58vlD9zlzYNtDsIBgOOOdoShI=; b=
	irnb3k2h+5J0pjX69uBa4cCUwZIdCDYvUHtKFtiB8UmNBshfGWf7adR3bl6IJdhk
	W+gf02MoG0kZOfNa7luNCbmAbOibgWKgzuYplHmvqexltIT2mwAGUXP4Kf1JhFnU
	Urf3sDhsiqOP2IqzL7/lDEbxsq5zcaHP7j6x6EK9/wJMqmxJq2K0Y1J2B9f41RBJ
	Y3wv807TPzYAGrj9Sd1NlswPR2aTPHWfqMnqdmEfuK/AkacUlowm2V0hXCnH/uZo
	/xxMRpeHIswjWnaTh6moTe8cjkt/hGSgfR61uJ/qi7UQY6aWBtEquIFPyXgDaYaw
	EILkOoJEczoI67PyD4HfMA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt52d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 23:18:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GMqABJ019938;
	Wed, 16 Oct 2024 23:18:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9g867-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 23:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTxc4awsZt8DoP6eIu5EGyYfj7j8mwwvXa2hnnVg9x6qwzIpJBMR4/td5f2e9dTp8eL9R3VrRvzh6Z9fKGOnasgji8FmtcEhNSHqlkboeQ477SpK7jsvlMZpLsZzyG+AN/6bIHHDDbQV7KyJSpTNoqEXA0MQC9tKumFgAOSUHMRMjp3lT+w86Xdj9CnvatqFEF+gJ9GS/tErn9N9hAbMXTyYv7y9oSNxaBgRyJHYoPrehW8onvFAbrzcAP3kA8jCpFcZXzgqW2DMeBA6xHSln8YEJKBVm6HV4B/cjsO9XbbLAwweUKsTvgv8ruK+U/h+d/rh7ZHL2Af4cuRdXOnvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75IZ2WjjPSO4CoWci+58vlD9zlzYNtDsIBgOOOdoShI=;
 b=v8BMkQLOHv1sReNPlwXhnAn2t1WSGTcQ5Cdb2hiN68OFcQrZp+zxw0X9ZEexO5fYrDli9f2PPW2Y4KngQC0PmBeVy3InQK53uYKIkGOi7G6uuKRAfaefQGeH7TqkvCWZLb5Kw6j5cQT81DPt18LFZ6blz14MjBmV8gPP57ww7R7IqFKIZDkMZFbv54w+NS2XZfJ9IFacPkcUPsklP1AGCZXuF6xtVlHrONMnpwD1QDDuKxopFBUeedwVINdy5nRD/506yDxuU+pMoFFbqOnWfS4trI4+2QB67K71ACzeTYpanNE2CCl2YF2KsUrQ26zQmJg5j4dHFl5lnxL9rqqT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75IZ2WjjPSO4CoWci+58vlD9zlzYNtDsIBgOOOdoShI=;
 b=rbyXdm+wnmFVD+6wNDzKK8Ww3/ItrDh0Js/tHd/pGz4LVA+1bsSPR+fGDDItjO1ArDf6jKZ7IU0fkr5qLgXSdcYLBi168hZUtZnAG4kz/SY0tBoglk+4eR44SEw35v6fxwscEvRjBHZMCku40offjolanfzaQ8JmCrKKNk9LVqU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 23:18:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 23:18:46 +0000
Date: Wed, 16 Oct 2024 19:18:42 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
        peterz@infradead.org, ardb@google.com, enh@google.com,
        rientjes@google.com, groeck@chromium.org, lorenzo.stoakes@oracle.com
Subject: Re: [RFC PATCH v2 0/1] seal system mappings
Message-ID: <2durheir3u7uv7y5d3zsuxgkxbfhyj6gbef6xiktp2nybf7os2@zppt55ut7f57>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org, 
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, 
	davem@davemloft.net, hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
References: <20241014215022.68530-1-jeffxu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241014215022.68530-1-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f818ec-6d7a-44b8-cd2f-08dcee38e22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFJIV2FnVlNUMHN5QjBxaFpMT3lNV1FIUUw1L1hESUZpNklvT2w4VzV5UlJO?=
 =?utf-8?B?cWhzbytWRlZ1dUJzMmZpZ3dZWlVFMjNnRXJRdnVtbENFRnc2VFBQK25yQWdz?=
 =?utf-8?B?dzZYMXV5VittZENrdWlWTGhKMnlLNWRpWWlVczVyd003QkwxUHArdWovOEs5?=
 =?utf-8?B?UHQ4SlhQUnNqSjBMSWVuVkJzcFVaRXdrNFNFazJ0eXRadVk3dkdGaEhPU1hR?=
 =?utf-8?B?U3JRSmdEWkpZVm1JNXp1QzNHVE4reWdsTGlFTVdIVU1PNTdldlZxeUpTci9y?=
 =?utf-8?B?MkRoeDduR2JjNWtRaDF2eFFSWEhrc1NmNUQ0SDNGTW5GaHJKemh1c3pSYm5Q?=
 =?utf-8?B?NGs2MWRCMVlGV2JFd3lack5GS0k4UHB1ZkpNZmJSaTJiTFBCR0hjRlBaS3J6?=
 =?utf-8?B?VWN0bEt5SXlBR3g1eVNCTmE5c2l3T2Q5MzBqNmhDV2JJVVBoa285bnM2cS9z?=
 =?utf-8?B?RFFZWmN3YWxoTHdSbm5XVnlyaHFENXpYa2ZEWU1rcHdGcFVhTVJ5dFZWTzRZ?=
 =?utf-8?B?UHNzRmZzcTBjZmc1dnVwb0NyWWJjelc0UHV0Z2JTOE9IYWRlcmloRUdBZ0tP?=
 =?utf-8?B?VE5abEF0MTBOZHVzWkZ2Uy94QXBQNmVKbkNBMm9sUVBqeDFqVzM1SFgyZW9l?=
 =?utf-8?B?OE1NWmNaaVJzbjZOZDQ0aWNjQUlKS1RLaU1FV0RxWndnb1ZEWHRidGpPWlhy?=
 =?utf-8?B?ajI0ZTZMZkR1aGdiRmZETHdMNVlySmxHbGR2bSthaU1TQUtIaVdlaUlIall5?=
 =?utf-8?B?WllWN3FWdks3d1BPbUJSdnNWa3NaSjIvS3pJSXJvV3Q1RjZKbFNiSWh0MHhr?=
 =?utf-8?B?a3o4SWNEYnNaZ1Awckx2djVlM1RwWG5yWXpGa3p1bk84Nm0wN3k5NlZqSW5s?=
 =?utf-8?B?YmVmS01rRlkxV1A5bGNNUlJOei9BTkQyNG00aUFYSlYyQnllcTJQb0NUZ2R3?=
 =?utf-8?B?R0w5NTJQV1BvbjRVZ1J2UmE0UUFET3I0ZDZIWk1ua0tlWUVDUlNvRUozcVNW?=
 =?utf-8?B?WmlwSUF6NkZKUWZoNFM5cFJQeEFKRllJZTcxU1oxR1dCOUFaeHMyOHZMUTk0?=
 =?utf-8?B?VjV6eGowVTRTbUtiKytQR3V0VHJKcDI3QjhEOWJxKzRUZDlCRzRBT29vWGRC?=
 =?utf-8?B?YU9QRnlTTU1GSGY0ck1rNGUyMzhuUVVsbVoydFBQTFdlMkhMVHhKbU1hdFY4?=
 =?utf-8?B?b1dxYUZqa21sR01HK3g5OTd1M0lpMnFBVzJ6bWk1SmdzdmZ0enNLQTVVZUZP?=
 =?utf-8?B?UDZIRm5Wb3V4eXNvSDFBNEZwYXE3RVNiVE0zeXo1QWlBOXBmcTloNlBJYUJC?=
 =?utf-8?B?bGdqakZmc2FsNFVSbzh2ZzNkank1MnV5ZXdpNjhqRE5BWnNpQ1NrWmdQSlNZ?=
 =?utf-8?B?L0VZb3Boa2lqM1I4L2hxVlh5SjdHQjQ4di9Cc0xnOGtwR1JHTGFTSkE2NThO?=
 =?utf-8?B?MkhTV2FFaEE5eW9uSURJMzBFV0xPNmltT1F2V1oyb1NYbmwyUnh6YkErUnlS?=
 =?utf-8?B?SGxqOWoyNDFGbWk0WEZmUnBrSWVCRXNnSFlkOUNBOGovM2JtdHdtbjJHWkRM?=
 =?utf-8?B?VVAvdTZtRDBGclIrRVlYSzdITjRYNnlYNENrTitkVlNIYjBlRzc0YkZJeEJU?=
 =?utf-8?B?RkN1cWFxYVNHRXBVWS9tVXhaajYxR3VDaHcwUklrblZSQjBtQUxRWTFicmNN?=
 =?utf-8?B?RVZKZmpnYWgrcUY4WjZ2R2F4b2tUWlM4TUV5NC8zbjJlLyt2THdpYzZMbTd2?=
 =?utf-8?Q?RuFcJIBOdgJ3tqlajCWpP1QSAyIpQR9CoCP49uX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U29XU0dIeWgxYmxPOVFwS201Ym1nK1B6SzlIczZqWGh5U2ZNNGJtZ2RIMlU4?=
 =?utf-8?B?SHU4ZEVHdTIvSjBwSmFPS0xsMkZmWjJYZVJMWWxpc3F5RFNLbnY0a0MxdjNm?=
 =?utf-8?B?YlJuUjZWbWttMnR0NTA2dHJEZXNNQ3Rpd1NxaFFZaTE4WDBvckRjYVZPRjFm?=
 =?utf-8?B?anVYMnBKYWM4YThFS2x0YlVzWUI5U2FmWHhzSnpwdGg0djRaYUU5ekg3TEMr?=
 =?utf-8?B?Q0ptZE0xT2RmalNNM1hhb2ZQU2VVeHNYU3NaTGhlazNVV1dDVVl1MCt4bEND?=
 =?utf-8?B?dHNCd21RRnlYVlNBczFTR3poYWlZTUxUT1VaS2dQRXplTEMwSjNRaVlCZHpS?=
 =?utf-8?B?aDZuQ2J2TW5Sb1hxazlZbXhIazAzdXEyd1BRbUR2bXIxMU8xWjNSME1ZYlFt?=
 =?utf-8?B?ZzhvTDJSRTVoYmVicFowSWMrY2xLL05FZFNuS002dGFJOGtZblVLUEkzT2I1?=
 =?utf-8?B?YmYwdXFYczdORFp3d1llNFBzNFhhRlFlTTJnZmQrZFZsVTZnN0tKR3VnZ1Zy?=
 =?utf-8?B?QXUzVzkxRFRTbzh3WDIxUXhodTJSNGtKOVZGQ1EwQ1VRMVpUUW9odllEbldO?=
 =?utf-8?B?MEdRWnl6ZGZkMHRpZGVoSXJBd3RncHk4WU11ZGxKODZRNUJRK3Rjd0ZlZi9k?=
 =?utf-8?B?QUlqN0oxaDQrTzBFOTZQazhvTEJ6MUROT1J3bFc5WEdrQWJLcGxseVRTWUtZ?=
 =?utf-8?B?cEtidEdVbk41VHZJcXU5SVVLSllKTUdja2lZN3p0T2c1QnEwT2N6L1U0ZVhR?=
 =?utf-8?B?ZmJKaVN5OVlxRWNYZjRyVUttR2U2L0Zrd01ybXhieDd5UmZDc0Fkd0tQelFX?=
 =?utf-8?B?dEMzTVgwQ2ZsekxhMzFNS2F0bGdiSnFVWWV2MzVjdHgrMGVFT0xtQnRhVjd1?=
 =?utf-8?B?dXdScUhIcUNOMkg2UmxkWVBmSDBSTDNjRnR2WkdST2RUUDBGVkpLeXZ4bVhn?=
 =?utf-8?B?YStteUJMZU05dWhjSS9SaXZSdEVidUJWZ2VSMXBJMi8yZWwzNCtCYWZFcVFh?=
 =?utf-8?B?WVFab2JnakxEcmNYTnAyV2VmNWxXamN1N0w4SEIzbzhzK3kxVXBqSDhaanoz?=
 =?utf-8?B?bHM0RDJRRTVqTXZITUtCblg0Tkl6MEowUThJV29LRS9HOW5TckQ2RzlhakFE?=
 =?utf-8?B?ZkdjMmhDMEJLdXhRczkrbmNKL296d05qaFFRY29HWDFaUGsyUXZmbDZLMFd4?=
 =?utf-8?B?dVBFV1FkMStwTktucnArWDNLMUtGamVmZlFVK01RQUlYTUtkU3dhdGJNSTdM?=
 =?utf-8?B?MVJWQXR5bDNPV1J6dHB5Vk95Vk9CQUIxS0d1eXRxb1R3Rkx5aTNEdUVKeHd5?=
 =?utf-8?B?cjVFUEdYNE9tZWp0Y1I0enlqSi9BNUJqSDcrMjhITEYxb3J1RzdMQ0h5d3B1?=
 =?utf-8?B?RG14QnkvVm5Ybkx3NFFzVEo1OVpLeklZZzdUUnNKNkovaDNUbmc5SzBwVjM5?=
 =?utf-8?B?Ym4renF0Mk9aQkxxOTlQdjVPZi9VNWsyUlAyRDlpS096bHkyL1o5NzFrRVZK?=
 =?utf-8?B?VHIrR1MyL0xVYUU4ZklHOWdBcTY1SHc2dFMxSTQ0bkpkczNkV1NiQlYraCtl?=
 =?utf-8?B?ZU1ZeitrTEtIbTF6ZHpRNkl0S285cjRCQ3lETVlFei82UjlmSGZ0WDJyM0Ex?=
 =?utf-8?B?ZmdlYW9YSjBNR1NYSHZjWmUwR1p3MnhqYkdLanpVQ0NjaW9qWkNQZi9NWHZS?=
 =?utf-8?B?L2UyaWlsTGdDRFgvdWhrZ0xzUjIxdUJyd21lbzNzTEs1N3p2c01MZWFITHBh?=
 =?utf-8?B?VUVNVTBCVXlhZDdNSGdqT3JtSW5MemJwRWFkV3NhWmdsVUd1Q1lqZzdZQW04?=
 =?utf-8?B?aHBQd0hVSGtaYjN3VXhvc3BqenhkbVd2bWJUbVRTd0U3aVZHU3ZvaGRVaHdV?=
 =?utf-8?B?TkNaejljekIrTTFOVUVTNHBMc01YMnEyN1JjazJPd00rRE93aG9aZ2N5eTN6?=
 =?utf-8?B?V2FzMXR5YUxRaVl2a2wyaWg3NVdiU2czaE9LS3ZTV29sWDNBVDZNTVlydlRs?=
 =?utf-8?B?Vll3bTJkYWsycEFQUDh1VlNqM2NrNG1MRFhNZDBaVU12RzlvaHNHb3dXYmxm?=
 =?utf-8?B?d0I5SjA2K29XOTBKRlB3WTY3cG5DWlJreUpIdHdlQlpRYnB6djk4MzZGS09j?=
 =?utf-8?B?K3JHeFJTVnRrMkw2V2NodkdnSDFGT2I2bktvRTM4VVpuWTJCb1lZc3NVQXJa?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AeU4njQUPX6/WUG/Z07DqynQjBvfwVQCxAX/it+W+Ae5xVuC0fGpxoHCmuDfYvGJgdzRfar3+hyX06G/GwjCzcnO7vTL4lgDAc+uypdS5tzs97rQdKe/aL+TTnxSR/5kDzQ/Ko16aCHzVEW8InZDQawR3qivw3TBXuRcWiiqEu5LApLcjnfG31EjGNGSq7HjMI80v/yYFQUYcxTFM7tDUBFZVI0gAhfhnHFos2ppp6eekgQw/iiiYjMFgVtmwkgDQeujjpidiYOP7T19/c1zYgfhiQY3empuaqBmoyxL7500+19LYIt2u6vljCfB+Br1ssHTv+wErhheUBqa8gAr1HlzGCVKxa/9UuW/u8S95VxcWSes7a/pff9ztkg3V+9cikTgAmoRMJHQQYtYqqhOsWOOuWxX3fLApkvIhiY6z+839BncLA7VzrVBHpVoq90ZvYVm3FGgZ0v/cIg8zYif/Eh3iF9SP2/x99+6H6dHD4YlmqtG67BKh/jgXniVrq5josdxvaq8/aiDEeJ7JrKyNDB1jT7LvbBx6TvtKBdqvg25fG1HHrbrnKn/tX/obgbVxyPx8Fh66uk9R00R+MuOu6rqsnO63iqUsclUsCXpNS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f818ec-6d7a-44b8-cd2f-08dcee38e22a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 23:18:46.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0XWjOxx3P0+6op2yXF9MMtzoBx3UCAQZTZwKxcSkWPQab+xhjsrV/EdM/FTtwzytZeVOWyzc2UOiis6GbST9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_17,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160149
X-Proofpoint-GUID: QPm_TdMCVhPeTpKSRgum6sA1_mJVdMs7
X-Proofpoint-ORIG-GUID: QPm_TdMCVhPeTpKSRgum6sA1_mJVdMs7

* jeffxu@chromium.org <jeffxu@chromium.org> [241014 17:50]:
> From: Jeff Xu <jeffxu@chromium.org>
>=20
> Seal vdso, vvar, sigpage, uprobes and vsyscall.
>=20
> Those mappings are readonly or executable only, sealing can protect
> them from ever changing during the life time of the process. For
> complete descriptions of memory sealing, please see mseal.rst [1].
>=20
> System mappings such as vdso, vvar, and sigpage (for arm) are
> generated by the kernel during program initialization. These mappings
> are designated as non-writable, and sealing them will prevent them
> from ever becoming writeable.
                              ^ or ever removed.

This is a pretty big deal.  Platforms are trying to make it so that vdso
is the fast path, but if they are removed then things stop using them
and it's not a problem.  This description is robbing them of the
information they need to know that, and it's not in your change log
either.

I had said before that you need to be clear about the inability to
remove the mappings that are sealed, as the description above heavily
implies that it is only stopping them from becoming writeable.

>=20
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [2], thus sealable.
>=20
> The vdso, vvar, sigpage, and uprobe mappings all invoke the
> _install_special_mapping() function. As no other mappings utilize this
> function, it is logical to incorporate sealing logic within
> _install_special_mapping(). This approach avoids the necessity of
> modifying code across various architecture-specific implementations.
>=20
> The vsyscall mapping, which has its own initialization function, is
> sealed in the XONLY case, it seems to be the most common and secure
> case of using vsyscall.
>=20
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the mapping of vdso, vvar, and sigpage during restore
> operations. Consequently, this feature cannot be universally enabled
> across all systems. To address this, a kernel configuration option has
> been introduced to enable or disable this functionality. Note, uprobe
> is always sealed and not controlled by this kernel configuration.
>=20
> I tested CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS,
> which doesn=E2=80=99t use CHECKPOINT_RESTORE.
>=20
> [1] Documentation/userspace-api/mseal.rst
> [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL=
-NrCZxYAyg@mail.gmail.com/
>=20
> History:
> V2:
>   Seal uprobe always (Oleg Nesterov)
>   Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg Nes=
terov)

The only update to the comment I see is the pointer to mseal.rst for a
complete description?

>   Rebase to linux_main
>=20
> V1:
> https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/
>=20
> Jeff Xu (1):
>   exec: seal system mappings
>=20
>  .../admin-guide/kernel-parameters.txt         | 10 ++++
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
>  fs/exec.c                                     | 53 +++++++++++++++++++
>  include/linux/fs.h                            |  1 +
>  kernel/events/uprobes.c                       |  2 +-
>  mm/mmap.c                                     |  1 +
>  security/Kconfig                              | 26 +++++++++
>  7 files changed, 99 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.47.0.rc1.288.g06298d1525-goog
>=20
