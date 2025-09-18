Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3128DB54
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221449; cv=fail; b=gRBmMb2z/Dntzv6x8905NQJ3wEl5ypNPoU1H7Bt7da+ScIgOphsraZ/mfHW12xovWFMTDGwGSyVo+tE2AYLcX/MhL8YzOA7BTA236/WApg7Qa9wozAaWWeGH0PC23sLNYFmz9IfBkJMWdjY3ITmlgCXmZBe5RXbHBde6bKZqF1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221449; c=relaxed/simple;
	bh=Lv23sOtTT/I+x0vODxBkxNKfPrLmmrXmE1Tzq8oAaRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xn85R5FSr6MuCatz2qz+YGoKOs8D3YNaXYjftCRlCc6O5pEDZNtUAtBw4rqpwiJYpsc35B0ByGEi9fSgO2pqvEgtGCw9X1udVvqomh9Rlyah8VQzKdErHKdCUwMAymp83QHlU16/Eb5gPbT+KbKRdOrnsauzwFvzknLrZpW0wH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l8D7+zh6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I/UdqGUn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l8D7+zh6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I/UdqGUn"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IG1rxh007042;
	Thu, 18 Sep 2025 18:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Lv23sOtTT/I+x0vODxBkxNKfPrLmmrXmE1Tzq8oAaRc=; b=
	l8D7+zh69CV2D/T+397IHkYHVcpKPSb7+8FFL+Sws1Hi+ducyo2Vr0UaGh5FZDSb
	RRWdZIHOz2BlttNFoAdVTz3qlK4E5Hu8ga7dz90A9s6cAfbP9UdzvrBQpJ6DTnnf
	nIX9apg0t7pCXKJL5I+C4pgbfvxYjrxb3LDsHQK4V187wtfDOm6tHvwZxKdAIxt+
	GbcteZBbuK33afUq2/BhH05rXkVs6eXdfOpN4CSf8W+gwxPYmcgc5p3qazkXOkUB
	olCKwTjOzv4TBljtU4lCyOWgs5A9xNYr7gP3M9q70Ym/HJhLylnW6M8GV+08OCaN
	u64GSe/WHrxGihWPbh65Ow==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kc7k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:48:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHQrxu027359;
	Thu, 18 Sep 2025 18:48:20 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2nu7v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqTV5CCtRaQwQX3GbHFCKDQXU6Pc/DJMcOvSn3jpJIpYGAHpvbtuAqRtZYmajs+WWFp5DqNaLs+lXhGDkWc19XbPUBevh+4iAIIvMjoBb4yNzGYZyZIytci6XChzFh9zy9yfOMSprzwwGm1zafRgcO/RtQrROK3Emst6JIfWPkBrn4l1JRP0xHcp3HE1f0xTDXnkIXSL4ucQ10xt747F+oYzzlYlv6NNhuxXy7UviQ9PwzytRob7K4A6OOUEsLQPuutxBhCYQ+y5fF/ixCjz8wQlLAmetUFmuqKUgv7ruAyZU+bY414Jm0qmiIoJnistgsUfzcdpyVni4DMJa3zy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv23sOtTT/I+x0vODxBkxNKfPrLmmrXmE1Tzq8oAaRc=;
 b=kKQNxW/INvuVfdGiOdbu6+Hh20UaQcNPACBb+s79IBOtVgQiZxjpcr1qpvU6NFDTLT0BKrcNVlfC5OKMVJHnhjMsIjs5dj0kVzcFCuDbC5gl9TZyzsCxkhQaA1r8WXN0crN0e7NSeqXyA8FskhSWArDxN0DUR7v2oGBsDiN/n0XiPs28N4yzAZEBh3HDEitWqfggEBlJgIkuEIXac8e31zcQeYoou2moLK/26zKoUGw7OyIGqvIrY/Q+sgk+ZQDM90XxEUVzUR1w64LQ9QgNSULT2Kiuidm08Yyr5Ijp91x7MpoM8wGY03q9RGnuUQ0eMQSmDYQf1CuFTyEwZ31kxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv23sOtTT/I+x0vODxBkxNKfPrLmmrXmE1Tzq8oAaRc=;
 b=I/UdqGUnVDHhXaoJ1ZPXQSi3vjDJMk62rX+UgNwv+yOLYtCfJjZInZsouQVgl0QX9OmzPX1KdP6KawB3fEp9g8EEBIGD0mZdd2frDGDyTfM0OXd35Yw8jJVox31eKANcfA5uF853sR+HXol40RjPlf//eAGJgczOeNA/3JtINX4=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by IA0PR10MB6723.namprd10.prod.outlook.com (2603:10b6:208:43f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 18:48:04 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 18:48:03 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>
CC: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
        Martin Uecker <uecker@tugraz.at>, Richard Biener <rguenther@suse.de>,
        Joseph
 Myers <josmyers@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan
 Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft
	<marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito
 Cheng <kito.cheng@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew
 Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Dan Li
	<ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de
 C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Topic: [PATCH v3 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Index: AQHcJQWCX+/DZs40NE+NxElz4QOQyrSXZ74AgAB9CgCAAUxyAIAAFrGAgAAHhIA=
Date: Thu, 18 Sep 2025 18:48:03 +0000
Message-ID: <1F77CFF9-9105-4F3A-A7AC-E3A0D2E95162@oracle.com>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-2-kees@kernel.org>
 <6F94A091-6948-4220-A972-236055C2440A@oracle.com>
 <202509171307.DC9740ABAB@keescook>
 <306E5909-C77F-415E-A2F4-6FAE3E5740DB@oracle.com>
 <202509181112.B39B490E@keescook>
In-Reply-To: <202509181112.B39B490E@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|IA0PR10MB6723:EE_
x-ms-office365-filtering-correlation-id: eb3f35d9-8c69-4b4f-6539-08ddf6e3e656
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODRUT2syTkUxeWFqKzZ0blgzd1lhQlprNXJJQnVsRHNITGFqOW51K3lvcXhw?=
 =?utf-8?B?RUpIMFdCQ29wTEJjdWdaK1M3djFuK0VLUnp3M2dzQnI3aVJheW1BSUh4c05i?=
 =?utf-8?B?cEdFUVVVWXRSdnJPVFBWNW1FTkVQVU5aU3ZvcmJJMjVnSTkwOGNuRmVtZE5K?=
 =?utf-8?B?QWJZcktpanlQVWswNnFUWktxRnNBWXpneXBwYVJZaE9SUDIrSEkza3d5cmlx?=
 =?utf-8?B?ZmJScmt0emw4dlVWMnQyeE5EY1g4dlRjUzBWN0oxTEJUcGdjMkRnUnpNNU1B?=
 =?utf-8?B?R3ZSN2dKOE02ZzI1V3NHZjFpK0tEVENNeSt1ZWliSzkxekRrdGg3emJwU2pz?=
 =?utf-8?B?b3pWZDlQUWJBU2xNYUpVZysrZWhZU0xiUFZtOGU3dmVHYnZ2ckdqaTJLQlhE?=
 =?utf-8?B?U0ZmbmM1czlSV1R3RTBHaG9tbEZDY28xT3VwclMyVmRONmhVSTdUUnJya1Bq?=
 =?utf-8?B?WU9uLzhyaSs3N1FsQWZSYno3T1ZBd2loVFdYTVBla21pMTEydzNZSjNKT2hW?=
 =?utf-8?B?cWd4bzJmUUNYNkpjOG9ReDZYcWs0K2Q1MVNiOVNFdm1kTUROUkhLdDVTcEdv?=
 =?utf-8?B?ZmpHeHZ3MTFyVC9sWmtjeXBOaUY0aHRPZityTkppRmFBRmo5NDNsTUkyYzFB?=
 =?utf-8?B?WFJyZFo5T2kvNXVaNnpRZzJCb1RsMU51ckl6Y2I0VmVlZWJuWk9Ld3prZGhq?=
 =?utf-8?B?VlloWWJwMUhDNHZQWjFDY0lXU2dqemkvTzhZTURGMzJVSkJmeUdJTnhuUkcr?=
 =?utf-8?B?WmpmK2R2cFBONDdDR3U0RENtWk1RYU1mTmpwUGxZb1IrRGU2VEtVR2pMbTdV?=
 =?utf-8?B?TEhicEJMWnVxenNaWlMvZzkrcEtrWnI2cUUza2RaUENVaUhQS05uMy8zQllI?=
 =?utf-8?B?cmx0MGpyalZBdGNIUkd6c2N2VzJPTHZpdlE0UlhEWDkrN0FBMUJQVDFIMWJa?=
 =?utf-8?B?VVk1OC9NaHdlSUpkWFV6eFE4anJ6bE85bXpHb044ZVVDc1VEUFV0SzhwYkJn?=
 =?utf-8?B?MHJFWjB4alh5QjMzOFNlMEZvVkNzbEoxWjFHcXpEd0dMK2d5cCtiVFdlaFRR?=
 =?utf-8?B?U3M5L1FwZUY0Ym13OGhOSXVPblhYckU2SHBEeTE4bGpCbHR2WjVrSDZNc2hN?=
 =?utf-8?B?NFdjQzhpT1VtNjRYYnBrNEh2VHVnOXdqS2Vnd3lpRG1Fd2FMWHoxRmdrUmRq?=
 =?utf-8?B?Vmxqak0vTlZSQWlUVks0UnlkWktIYmtpbXhSZmJ3WDJWMUQvR3h1VHhPYitu?=
 =?utf-8?B?elVQc01VU1o2elk5Wm1aUmUyL2JBMGZ2L2FiTE1SMkZhU0NiMGRKemtOemNB?=
 =?utf-8?B?MDhSSXlZb2V0Q3d4cGRhTHVSRS9zalBLUHBuOGFZREprYldXQThOSlFaT2pl?=
 =?utf-8?B?UUdUZWxvR2FCNnk3WEhlejRnWmVpY3VTUEJ0S2tINUo1VUJiVXd1RExwaENh?=
 =?utf-8?B?Z0FLZlZJcElUbmtlNVNyenJ0bFRDZDdDSnc0cWVPS212N1B4c2VaTGxqZG1w?=
 =?utf-8?B?bFFUQ0NHNS91VE84Yzk1a2pjNWhTVWNQck5LSjhMNmNKeXgyOFl4U3B6Yld1?=
 =?utf-8?B?SU10TWlMOWE5eVdqMDdGKzJXRzl1cThQYTRLeW5wdkZhWGVwQUcyUzhkOHdn?=
 =?utf-8?B?b1hXS0hMTHdUMzEydVpheFByUlFnRWpaT0tleUEwSDFrVXJCUlNQckkyaE5R?=
 =?utf-8?B?TmlhUm9uQjlDdVB4RzRtOTUvWHNBOHZKZVQrbC9JTlY4UzFRSndmNmJNcWE0?=
 =?utf-8?B?ZjZnOFQ3cjIvS0hWTDE1dzZoYmY4clNRQzJGT25xdkRad2EvSVViM1BRRXMv?=
 =?utf-8?B?VUV1UlJrZ0xCUy96Q281elNEcnhLUGFVTnBYRXNMa1pTVTFJUEIzRzVsNXNX?=
 =?utf-8?B?SFp2TjRCa1dMbFhDVWl3UVJYR0krNVUvejhsQUZRcitFQkJOWVhCMVF3N3Av?=
 =?utf-8?B?eWN3d1cxelJyRmRtY3NITXdIMHk0WnlTcFZGNXREV2RNRi8wL0gzaGlpYjR0?=
 =?utf-8?B?MGJpSXFEUGxnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ak0yT1l1a3VnTjZVRlZYdFo0V2hXWmlnU0lMRnQzdjVTcU1oU0QwdHZ0YWR3?=
 =?utf-8?B?R0hoOFRZRDRLakN3Q25nNVRrZHNLMTdJNGY2NTVwN3lQMWpTYXB6eTZObHlR?=
 =?utf-8?B?d0JuMGVxa1diaEkrdGJqYW1aNkZIYWlNUlJEMW5scDgxRjFoRnhObStLNTJu?=
 =?utf-8?B?MFZRQndvUG5yVWttbWUwWDVNaldxMUdwYmcwT1VIWWxBbjJyQXY5aTA0WCtz?=
 =?utf-8?B?VWJEWWxqa0VQa1VOOGU5cjNGUzZvOVYvYk01Q0l0bUxnU0lMOHVrZDl0SWta?=
 =?utf-8?B?Q3NKaUNZNGFYeGdEZzl0SXRBMC9FQmRNb2dGUmZ6Q3BqTDFCc3VrQWxNc0xF?=
 =?utf-8?B?dUJlbERoNkdvVnBmamtzUitiOXYxYlQrdUJjWUwwMVpsMzdkdGgzbVJudElm?=
 =?utf-8?B?QzlSUkptenhqWWhPWUZKem9QTUdkVHZKZjJvd1FnM21mSjhiUEZUQlI4NG1M?=
 =?utf-8?B?VnArUitoZjNUc2VPNHFvZjdiTDUwcVAxcUlicHA0NHFPN3V3RVRJSDJ2cFc1?=
 =?utf-8?B?T01NeVo4MVltREV6WlA3Z21XRkZnZFBQb0M5RVZoS2VobjRyeEtIejB4Wi93?=
 =?utf-8?B?TFZFcGRMUjBzVWJLL0x4R0xKVEJ6dUxQRnExaGUxS0dlM253aE5yazdrdUNJ?=
 =?utf-8?B?M2hVTi9MNmYyeVRCYXJ0azVMWkF3THhkNFZpRlJpeG5zcUlteFdWT1N5MnI4?=
 =?utf-8?B?OXF1aWVBMHdkVWJScXcrQy9IT1N0U2M0QWdQV3MvSGFYVU1SQkN2L09kUDVE?=
 =?utf-8?B?dDlTRzhxd0lSRFZpSUNoemdvbkhDVnZIZzdaQkR4MjB5VldpRG9YOFljZ3JS?=
 =?utf-8?B?VTlMYnc0UlJZMmlsTmllTC9zNUVFcXRYTTFUeTloNGlnd0NhOWNJektCNDVE?=
 =?utf-8?B?Z3lob0J4TGdBSnI5MytwdnR1dWxBNHV2dFQ1TWdIV2dWWWMySjdxcEVIa2dm?=
 =?utf-8?B?OTQ0ZWtjVXBZMC9wb1BiWTExRVdiWjArTUloRXJPaWdxbkFtUGt2NFJ2aFpw?=
 =?utf-8?B?cWF1WUlXclhGZGJWNzArbHYraTMyOFNpdlpZY2RtaERqbHBuSXMzQXBVSzBS?=
 =?utf-8?B?Tkh0cnhEbTU2aXlIWm5vSFhjQy90QmhqOEw2YXpyaTJsUGNtdm1DRms2YXhK?=
 =?utf-8?B?NWNlYzhqMTJmMG1qdlFzRnQ3a0MrVXFnVEtIeUpsMEVPcFdaM3Jac0liN3Ew?=
 =?utf-8?B?YTlML3ptSUlBT2w5eDdhNE9KZ0k3Yit2VU96clRJZGdDQnZ5L3o5VXFwRStz?=
 =?utf-8?B?WW1KdzhVcnR6WVlPTnJtWDFQK1gySnBrK2tTdG5tR29GcHVCZnNCMFhiVExS?=
 =?utf-8?B?ZnpRdkpOYjlNT25jcFZXL1Jma1ZBTndhVzdZVHFERVZtZ093ZWZvVXhkanVY?=
 =?utf-8?B?NnNGM092dTZoWTNXdStrSy9UZmJoQ3lKYXN4VEIzSGtaTlRQbnFkTTRyZzNv?=
 =?utf-8?B?bEF2NFpTNDRoTTFXTDAxNExiaEIrSzVLNVFMaERhcmlSMkUxYldSSkZHUEFz?=
 =?utf-8?B?emdnUzZHOU01VVZuQ09xbWlland5YmN2dm9HSjI5VW8zLzFnRG1aN2RLUFUv?=
 =?utf-8?B?eUxwWG4wZTZjZ3lsUVI0VmIxYitWWVFLbW9FQWpXRFc5clpIOGVQbWZmQmVq?=
 =?utf-8?B?SCtFb0RDYTFlRjdzUWJkaFphYjBIcjhnM1RQdnZ4eHhtcU5ReTM0c2hJQVlN?=
 =?utf-8?B?TVkyZGtqcTRkQnVwdjZDMklFRE9yYjN5Q0VGejVTV2JXeEtBQkswbFllSjh4?=
 =?utf-8?B?ZlhSVElTSUxhVENIczlEWXNWS1ZocStmRGlwN0wrWHlZd0tSZjlMTjZRTXJn?=
 =?utf-8?B?L1Q5emhuWmQwZjAxWEpvbXltdkRPMkJUQjh3SkRuSXlOUlZvMW53UDAzRjNO?=
 =?utf-8?B?M1JBR3JyNmVNKytzTUZoK1pmYlZkblp0VDE5SURqaXRrZ3J4RDVseFN4VGtn?=
 =?utf-8?B?WnpIV2JJTFEwV29GTXVQTVl6MzlzaEo1NEFiOUpqeC9pUmNXRWhnTktSSUxj?=
 =?utf-8?B?TzJvc3Vad1cwRkZCekIxR2xqcmVvcStaQ3ROMytJeXE5OW5ldGVWcGJJSFB3?=
 =?utf-8?B?aktIVUo4QnY2cEt1SHBOK2hYQ2pBeFh3aFJmNEVXYTVZOWI2UjV5VzdiNWxF?=
 =?utf-8?Q?Sd24Ep7hR5tOty5JbCGmfp8Tk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13684034F122A64185F8A29D01C611BA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oSQKz+vvk25rTeLybtilOypp/YFA1Pz1rPx4+Jzx31tbkFnEYI2DxbpkQq7OWmh83oEvS71wZJw0diirYp4pLyPfX54gDQPjG1DB+UVrihywbXeGiJc7juPSqtnq/myKFI2m38N6ie3o8pzBZOdc+KFSCM8C597ZIRghnpy6gasDe/xsTEP1BtlwpcEu0VTrtwktxKFj9ZAyq0ilnmQ4RlammWg/KCm415BVL4/Xil8Tp/Xj7gmynS/vIbDCc7NOtBab62XNPsa2N4lp3l8ezeOzYHZswfZd/twmB61sqSvOI4dyPJUKzjgGGiW2SkeLhIWBzisbciSY0w2KF0dbjAvy7FDDk8IIOywuzvndgdrchxst0HJE+48xub+zYCxBS85Iq3Mb9okf9/ha/JudZysz1YQbIvSufNCRPMYI9FzyFqhddC53roff1+8bCB+HoefMMA5kawv3T8/teces7awhqcJBSe1sJoe9JqayxL8ZKo06T+c+Bnd+0MvGRfEd77R4mEava7jGsP4Jogp/hhW+SAsLzIzj0fUUiXgXt5a17yhXWs6rW+CwmnDgMhed/O8QlJTx+wtF1Y5n1dL9X6pqZUjlMhmtnu6XSEzPay4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3f35d9-8c69-4b4f-6539-08ddf6e3e656
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 18:48:03.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3efboet/FX1E/5LUdez/RG0Z1hAGLpwVJyoVO9lrEgu6OxHteBTj2AfwFpUliSPCP9bMS5hV1MV8PrQp2pm9JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180167
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cc53f6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=FPNMDJl49moUuye7S9sA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12083
X-Proofpoint-GUID: HL3VF1PN7DFZYQKVCpET3PnmkVnJeENi
X-Proofpoint-ORIG-GUID: HL3VF1PN7DFZYQKVCpET3PnmkVnJeENi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX8K9TulA5e77U
 CMlPROtUNzd2XmF/0OpHm7R+s4t1r9iW0lfAhOiKTxZAmotU/o8LL8bxdmZ+FngjzPuXHhRuM+d
 Nehq1tnaVj6lr5ABf9208n5cn6KJqUv+pzZ1hltbT1mdy3NKRRNP/AhvFDOHE+lrUXVGozLpc7V
 ShiaNjd5qkm9xZajmgniZ/37hXq/bjmMTvibkEWGuvzzdjhQbDmFLOfqZ/8lP4XYbgTb+7JKymX
 PxYy4ZKyAeDmdpiKdA1WYLynX/n/wDbDZ5Ct6kwBz2Jl7nmnVBokwnBXRtz/tIJmb6aeFMZ9L6B
 Maj/yUp61lEyOWXvbP4ziWpKlTqT+aFQhVjEnSugYtsEjYaAY9RPT7vR8ZFaJIcKsi5hqOKI4uT
 Pmi/VgxdyIJ78uu9kqTsPFsO5a+GvQ==

DQoNCj4gT24gU2VwIDE4LCAyMDI1LCBhdCAxNDoyMCwgS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4+Pj4+ICstIEV4dGVybmFsIGZ1bmN0aW9ucyB0aGF0IGFyZSBhZGRy
ZXNzLXRha2VuIGhhdmUgYSB3ZWFrIF9fa2NmaV90eXBlaWRfJGZ1bmMNCj4+Pj4+ICsgIHN5bWJv
bCBhZGRlZCB3aXRoIHRoZSB0eXBlaWQgdmFsdWUgYXZhaWxhYmxlIHNvIHRoYXQgdGhlIHR5cGVp
ZCBjYW4gYmUNCj4+Pj4+ICsgIHJlZmVyZW5jZWQgZnJvbSBhc3NlbWJseSBsaW5rYWdlcywgZXRj
LCB3aGVyZSB0aGUgdHlwZWlkIHZhbHVlcyBjYW5ub3QgYmUNCj4+Pj4+ICsgIGNhbGN1bGF0ZWQg
KGkuZSB3aGVyZSBDIHR5cGUgaW5mb3JtYXRpb24gaXMgbWlzc2luZyk6DQo+Pj4+PiArDQo+Pj4+
PiArICAgIC53ZWFrICAgX19rY2ZpX3R5cGVpZF8kZnVuYw0KPj4+Pj4gKyAgICAuc2V0ICAgIF9f
a2NmaV90eXBlaWRfJGZ1bmMsICR0eXBlaWQNCj4+Pj4+ICsNCj4+Pj4gDQo+Pj4+IEZyb20gbXkg
cHJldmlvdXMgdW5kZXJzdGFuZGluZywgdGhlIGFib3ZlIHdlYWsgc3ltYm9sIGlzIGVtaXR0ZWQg
Zm9yIGV4dGVybmFsIGZ1bmN0aW9ucw0KPj4+PiB0aGF0IGFyZSBhZGRyZXNzLXRha2VuIEFORCBk
b2VzIG5vdCBoYXZlIGEgZGVmaW5pdGlvbiBpbiB0aGUgY29tcGlsYXRpb24uIFNvIHRoZSB3ZWFr
IHN5bWJvbHMNCj4+Pj4gSXMgZW1pdHRlZCBhdCB0aGUgZGVjbGFyYXRpb24gc2l0ZSBvZiB0aGUg
ZXh0ZXJuYWwgZnVuY3Rpb24sIGlzIHRoaXMgdHJ1ZT8NCj4+Pj4gDQo+Pj4+IElmIHNvLCBjb3Vs
ZCB5b3UgcGxlYXNlIGNsYXJpZnkgdGhpcyBpbiB0aGUgYWJvdmU/DQo+Pj4gDQo+Pj4gWWVzLCB0
aGlzIGhhcHBlbnMgdmlhIGFzc2VtYmxlX2V4dGVybmFsX3JlYWwsIHdoaWNoIGNhbiBiZSBjYWxs
ZWQgdW5kZXINCj4+PiBhIGZldyBjb25kaXRpb25zIGluIGdjYy92YXJhc20uY2MuDQo+PiANCj4+
IE9rYXkuIFBsZWFzZSBjbGFyaWZ5IHRoaXMgaW4gdGhlIGRlc2lnbiBkb2MuDQo+IA0KPiBJIG1l
bnRpb24gaXQgbGF0ZXIgaW4gdGhlICJiZWhhdmlvcmFsIiBzZWN0aW9uOg0KPiANCj4gLSBhc3Nl
bWJsZV9leHRlcm5hbF9yZWFsIGNhbGxzIGtjZmlfZW1pdF90eXBlaWRfc3ltYm9sIHRvIGFkZCB0
aGUNCj4gIF9fa2NmaV90eXBlaWRfJGZ1bmMgc3ltYm9scy4NCj4gDQo+IEkgaGFkIGxlZnQgb2Zm
IGltcGxlbWVudGF0aW9uIGRldGFpbHMgKGkuZS4gImNhbGxlZCBmcm9tDQo+IGFzc2VtYmxlX2V4
dGVybmFsX3JlYWwiKSBpbiB0aGUgImNvbnN0cmFpbnRzIiBzZWN0aW9uLiBIb3cgd291bGQgeW91
DQo+IGxpa2UgdGhpcyBhcnJhbmdlZD8NCg0KVGhlIG9yaWdpbmFsIGFycmFuZ2VtZW50IGlzIGdv
b2QuIC06KQ0KDQpJIGd1ZXNzIHRoYXQgSSBkaWRu4oCZdCBtYWtlIG15c2VsZiBjbGVhciBpbiB0
aGUgYmVnaW5uaW5nLCB0aGUgZm9sbG93aW5nIGlzIGEgbW9kaWZpZWQgdmVyc2lvbiBvZiANCnlv
dXIgcHJldmlvdXMgcGFyYWdyYXBoOg0KDQorLSBBbiBleHRlcm5hbCBmdW5jdGlvbiB0aGF0IGlz
IGFkZHJlc3MtdGFrZW4gYnV0IGRvZXMgbm90IGhhdmUgYSBkZWZpbml0aW9uIGhhcw0KKyAgYSB3
ZWFrIF9fa2NmaV90eXBlaWRfJGZ1bmMgc3ltYm9sIGFkZGVkIGF0IHRoZSBkZWNsYXJhdGlvbiBz
aXRlLiBUaGlzIHdlYWsNCisgIHN5bWJvbCBoYXMgIHRoZSB0eXBlaWQgdmFsdWUgYXZhaWxhYmxl
IHNvIHRoYXQgdGhlIHR5cGVpZCBjYW4gYmUNCisgIHJlZmVyZW5jZWQgZnJvbSBhc3NlbWJseSBs
aW5rYWdlcywgZXRjLCB3aGVyZSB0aGUgdHlwZWlkIHZhbHVlcyBjYW5ub3QgYmUNCisgIGNhbGN1
bGF0ZWQgKGkuZSB3aGVyZSBDIHR5cGUgaW5mb3JtYXRpb24gaXMgbWlzc2luZyk6DQorDQorICAg
IC53ZWFrICAgX19rY2ZpX3R5cGVpZF8kZnVuYw0KKyAgICAuc2V0ICAgIF9fa2NmaV90eXBlaWRf
JGZ1bmMsICR0eXBlaWQNCisNCg0KSXMgdGhlIGFib3ZlIHRoZSBjb3JyZWN0IHVuZGVyc3RhbmRp
bmc/IA0KDQo+Pj4gDQo+Pj4+PiArc3RhdGljIHVpbnQzMl90DQo+Pj4+PiAra2NmaV9nZXRfdHlw
ZV9pZCAodHJlZSBmbl90eXBlKQ0KPj4+Pj4gK3sNCj4+Pj4+ICsgIHVpbnQzMl90IHR5cGVfaWQ7
DQo+Pj4+PiArDQo+Pj4+PiArICAvKiBDYWNoZSB0aGUgYXR0cmlidXRlIGlkZW50aWZpZXIuICAq
Lw0KPj4+Pj4gKyAgaWYgKCFrY2ZpX3R5cGVfaWRfYXR0cikNCj4+Pj4+ICsgICAga2NmaV90eXBl
X2lkX2F0dHIgPSBnZXRfaWRlbnRpZmllciAoImtjZmlfdHlwZV9pZCIpOw0KPj4+Pj4gKw0KPj4+
Pj4gKyAgdHJlZSBhdHRyID0gbG9va3VwX2F0dHJpYnV0ZSAoSURFTlRJRklFUl9QT0lOVEVSIChr
Y2ZpX3R5cGVfaWRfYXR0ciksDQo+Pj4+PiArIFRZUEVfQVRUUklCVVRFUyAoZm5fdHlwZSkpOw0K
Pj4+PiANCj4+Pj4gVGhlIGFib3ZlIGNhbiBiZSBzaW1wbGlmaWVkIGFzOg0KPj4+PiArICB0cmVl
IGF0dHIgPSBsb29rdXBfYXR0cmlidXRlICjigJxrY2ZpX3R5cGVfaWTigJ0sIFRZUEVfQVRUUklC
VVRFUyAoZm5fdHlwZSkpOw0KPj4+IA0KPj4+IFVnaCwgSSB0b3RhbGx5IG1pc3VuZGVyc3Rvb2Qg
dGhlIGV4YW1wbGVzIEkgc2F3IG9mIHRoaXMuIEkgdGhvdWdodCB0aGV5DQo+Pj4gd2VyZSBjYWNo
aW5nIHRoZSBzdHJpbmcgbG9va3VwLCBidXQgbm93IHRoYXQgSSBsb29rIG1vcmUgY2xvc2VseSwg
SSBzZWU6DQo+Pj4gDQo+Pj4gI2RlZmluZSBJREVOVElGSUVSX1BPSU5URVIoTk9ERSkgXA0KPj4+
ICgoY29uc3QgY2hhciAqKSBJREVOVElGSUVSX05PREVfQ0hFQ0sgKE5PREUpLT5pZGVudGlmaWVy
LmlkLnN0cikNCj4+PiANCj4+PiBpdCdzIGp1c3QgcmV0dXJuaW5nIHRoZSBzdHJpbmchDQo+Pj4g
DQo+Pj4gSSB3aWxsIHRocm93IGF3YXkgdGhlICJjYWNoaW5nIiBJIHdhcyBkb2luZy4gSSB0aG91
Z2h0IGl0IHdvdWxkIGFjdHVhbGx5DQo+Pj4gbG9vayB1cCB0aGUgYXR0cmlidXRlIHVzaW5nIHRo
ZSB0cmVlIHJldHVybmVkIGJ5IGdldF9pZGVudGlmaWVyLCBidXQgSQ0KPj4+IHNlZSB0aGVyZSBp
cyBubyBvdmVybG9hZGVkIGxvb2t1cF9hdHRyaWJ1dGUgdGhhdCB0YWtlcyBhIHRyZWUgYXJndW1l
bnQuDQo+Pj4gDQo+Pj4gKmZhY2UgcGFsbSoNCj4+IA0KPj4gLTopDQo+IA0KPiBPa2F5LCBzbyBJ
IHRyaWVkIHRvIHJlbW92ZSB0aGlzIGFuZCByZW1lbWJlcmVkIHRoYXQgaXQncyBhY3R1YWxseSBj
YWNoZWQNCj4gbm90IGZvciBsb29rdXBfYXR0cmlidXRlLCBidXQgZm9yIGJ1aWxkX3RyZWVfbGlz
dCBjYWxsIGNhc2U6DQo+IA0KPiAgICAgIHRyZWUgYXR0ciA9IGJ1aWxkX3RyZWVfbGlzdCAoa2Nm
aV90eXBlX2lkX2F0dHIsIHR5cGVfaWRfdHJlZSk7DQo+IA0KPiAgICAgIFRZUEVfQVRUUklCVVRF
UyAoZm5fdHlwZSkgPSBjaGFpbm9uIChUWVBFX0FUVFJJQlVURVMgKGZuX3R5cGUpLCBhdHRyKTsN
Cj4gDQo+IEZvciBfdGhhdF8sIEkgbmVlZCBhICJ0cmVlIiBhcmd1bWVudC4gU28gaW5zdGVhZCBv
ZiBidWlsZGluZyBpdCBlYWNoDQo+IHRpbWUsIEkgaGF2ZSBpdCBidWlsdCBhbHJlYWR5LCBhbmQg
SSBjYW4gZ2V0IGF0IGl0cyBzdHJpbmcgZm9yDQo+IGxvb2t1cF9hdHRyaWJ1dGUgdG9vLiBTbyBJ
IHRoaW5rIHRoaXMgY29kZSBpcyBnb29kIGFzLWlzLg0KDQpSaWdodCwgdGhlIGtjZmlfdHlwZV9p
ZF9hdHRyIGlzIHN0aWxsIG5lZWRlZCBmb3IgdGhlIHB1cnBvc2Ugb2YgbmV3IHR5cGVfaWQgYXR0
cmlidXRlLg0KDQpCdXQsIGZvciB0aGUgZm9sbG93aW5nDQoNCj4gKyAgdHJlZSBhdHRyID0gbG9v
a3VwX2F0dHJpYnV0ZSAoSURFTlRJRklFUl9QT0lOVEVSIChrY2ZpX3R5cGVfaWRfYXR0ciksDQo+
ICsgVFlQRV9BVFRSSUJVVEVTIChmbl90eXBlKSk7DQoNClRoZSBhYm92ZSBjYW4gYmUgc2ltcGxp
ZmllZCBhczoNCisgIHRyZWUgYXR0ciA9IGxvb2t1cF9hdHRyaWJ1dGUgKOKAnGtjZmlfdHlwZV9p
ZOKAnSwgVFlQRV9BVFRSSUJVVEVTIChmbl90eXBlKSk7DQoNCk5vIG5lZWQgdG8gY2FsbCBJREVO
VElGSUVSX1BPSU5URVIgKGtjZmlfdHlwZV9pZF9hdHRyKSBhcyB0aGUgZmlyc3QgYXJndW1lbnQg
Zm9yIHRoZSBhYm92ZSBjYWxsLg0KDQpIb3BlIHRoaXMgaXMgY2xlYXIuDQoNClFpbmcNCg0KDQo+
IA0KPiBUaGFua3MhDQo+IA0KPiAtS2Vlcw0KPiANCj4gLS0gDQo+IEtlZXMgQ29vaw0KDQo=
