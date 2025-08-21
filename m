Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2C3451CE
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803711; cv=fail; b=BaR8ut5EdCofAvCZnjdVpR4+C+puvZT7iZQIIj8Lbd6dhIaRZ4TYgEKXBPtVR+TvxlJHNjoQKVIkma7SKu0p7PRo68cCDpeVxPUbyuuqg6UC8E+5WT3WIDr1ZDBGZO2xQt7JARKXOTeHU7k5FhIaFovkjKKkDODrZCLWuOXf8pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803711; c=relaxed/simple;
	bh=GuS8ernX4QRhyyswkjBAmS7xSEUNaaaOtvCh7Kxf2CA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hN14leP1tvTS81rcT2rFdKm3VU0OI6/pRnFn0Zua2aD6GOBgAE6DsnmQtvXG5wJpL2jpX/9e/Xex09oU3ZjQAUzIVfKDdy3V0ax5fhnONURTkIMX9mrQe4gWeAm7Pz5wItP3v+awG9Kp9bqeIGFqE+GBdzDWHpPMGsC9wAsy5TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pvWwGlVe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gLfceWT9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pvWwGlVe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gLfceWT9"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LJDUll025449;
	Thu, 21 Aug 2025 19:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GuS8ernX4QRhyyswkjBAmS7xSEUNaaaOtvCh7Kxf2CA=; b=
	pvWwGlVeXYaRi2dgY+cVwm+1iZovS0iw+kdDQZBKHiZmk5LospwtoSr+fqxNaE+m
	Udf452OUKvKuISYHaDQiC31duYQNMFRBKdYznMSoqpSBcCFBx2K1gW8ZkGLhamQc
	uBXPz7G5yKS4zF6HJYwm8eselUQ9MdhfdbV2IGapcUGfVz5Yl+PTyAjFpbBBbfp9
	eR5TedCiJZxXiOBqBlmgOBiAot8MXzxSuaysVIhsBOCXT1WRV9rhU/3UvwGB93pu
	6KjSf9XyAKXIq8MptxHS61GFUzd2UzIaVDG/3Z37maUnDw/sPiyPn8wX9VkomXDS
	Y4bN+DRzZLwZQU/ZJQBmSA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0ttm084-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 19:14:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LHk3b9030470;
	Thu, 21 Aug 2025 19:14:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3vsdwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 19:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV8yfs9r07oxvtV8i/O+G7AMsGWQ2RhkoOyj5LgxGmXUpm3HWI0iQBGOgJm9BieAqmye+X8KMB+cw3loZJO2vejFKvE6HR89gLzRiAD1MkdMxO5LFK9D4AGPFE642063uGmgCGFOfs0/PSiNzSrlj6al/qCTaHL411oZKYgQHw1DmOz3UU1w+UEu/8/JQhvv60KRnVL+O2ARufrY8PmNX7qxRrWxamxWy/rLVkDy9iHloqGZyZbTxTA9CW8XpteQGOiz2VHlTJ0VDDePKIbBmW3DGN3SaS7MpPpphDUolXRc7jn7zUGeP+kCassMisCB9d8GWFSOzZvDef3dIH/6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuS8ernX4QRhyyswkjBAmS7xSEUNaaaOtvCh7Kxf2CA=;
 b=v1LOEaiboNE4bPAviKW1oMktoX4J+kk5VQox5dSlE5lkjVl7UqzbPGg69d6R3PX7svReMTp7Pghd85o0sBr2Qz5y4sVEKTcIHODI2D4oT8I/H9xFZBifnUjDIy2EVwCVmd7+90UkDq7IN2nD9IZJZ6J04T3M+TPLQCDvlPG05ZgSrMG+sJv9V8sP8JY/b1sJ4qlvP5JiZLnCIq3hHZKzYTdQI+Xr46FqktJU1ayAF5mUqATlyIr871nYWr2RpN194hoPqS6pVoo7YMx+99/JsVqJ4xDla6pYvHEDs+e6RN1vtHz52sLuPpvb2zZCoKddMRfUgX0GVF2Ve88oOzNU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuS8ernX4QRhyyswkjBAmS7xSEUNaaaOtvCh7Kxf2CA=;
 b=gLfceWT9UQoumV7NO1ZJZ+uEvEpnq24wXBkEHbpidOajO6mPQwZRb542V9b7n+yXwQ52uTmE9o8DnKm6fILZlbhrnF7b6eXpagdaGPw/xW8BqE2x2FRCDG98K+OFNDBVeC2q8HtWpISwyA7VTWelc2TmmzM0uVOuImjBhSiU8cU=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by CH2PR10MB4357.namprd10.prod.outlook.com (2603:10b6:610:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 19:14:32 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47%4]) with mapi id 15.20.8964.019; Thu, 21 Aug 2025
 19:14:31 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>
CC: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        "gcc-patches@gcc.gnu.org"
	<gcc-patches@gcc.gnu.org>,
        Joseph Myers <josmyers@redhat.com>,
        Richard Biener
	<rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw
	<richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov
	<kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>,
        Palmer Dabbelt
	<palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson
	<jim.wilson.gcc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Li
	<ashimida.1990@gmail.com>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
Thread-Topic: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
Thread-Index: AQHcEm0EGi+s8Q35f0a3asvZv7CnCLRsvhQAgACK1gCAADHTAA==
Date: Thu, 21 Aug 2025 19:14:31 +0000
Message-ID: <E69330D6-1302-4BA1-BADD-8C91A096A1FD@oracle.com>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
 <202508210841.8BE6E3C117@keescook>
In-Reply-To: <202508210841.8BE6E3C117@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|CH2PR10MB4357:EE_
x-ms-office365-filtering-correlation-id: afcb29c3-f43b-49f3-72d1-08dde0e6f4cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVNmK0I3TWhoVkVmZThjMmhtRWNaZk5PTTNSbWVXTFRyT1IyNXBvMS9IVEFK?=
 =?utf-8?B?b0ZSV1FqZUpUWllQdTl1OTV2MXZiM291WHZwMzE5VkJWM1F0U3NyMWFkNm9Y?=
 =?utf-8?B?SytoNWhXbllHZzE0UnFlK1dmaUU1Q05hQlhPTXhXRHAwM3Ztd3JyNklzdGFI?=
 =?utf-8?B?RkpZUGhIMkU1KytiYUhmVUhweGVUV3EzQXVFbG1MOU0wWFBkWDNoWCswVE43?=
 =?utf-8?B?bDBkRTI3SG1OeEFnTUJaYjAxVmJkQy9ITTU4K0FmYkVmSVJhRU15MHI2Vmhq?=
 =?utf-8?B?QXlWbjRlazlBZkFQVHllL3QveVYweTJ2TGJPM29pUWgzQitCOFhxQTNBdnp2?=
 =?utf-8?B?VnVERHUycEIwTDBtWjRSM1U3VmhXbmV4RVBZVytWWUVCN0RnNWVLeGtZWEw5?=
 =?utf-8?B?aktoUW1sbjVheitha2lKZjc1S09RbVNQNlVlTEJOb2pXRHNabW1tY3dDY2gy?=
 =?utf-8?B?cEpDaHdNcXVJSEtxU05ycUdRRnNCYWtIK1AvMURuQ0k3aWVXR3pqN1NZd01n?=
 =?utf-8?B?ZkdTT1lmTVRCOU9jMjZrSjJqazd0bUdjUmRQU0plc1VXN0ZoZW0zVUFtV3VN?=
 =?utf-8?B?ZFNXNTFjU0NjeGExQTBDYjBwL0hEQmRId3ZDWDQyQlJlNTMwK2lOM09SQUtv?=
 =?utf-8?B?T0NROUdDazJQTElud3gxUzJ2RHpnQlpnYTVYNkc5RjdkOXNnTU53bUduci9F?=
 =?utf-8?B?bUZSaXV4WHdjVE5FWjdwc3MxRzIwRTFIaTh5U0ZnQXh6ZUVJd0d2ZEdIa0Y5?=
 =?utf-8?B?YmhCNysveTUxN01mSVRNZXNKSEo3SHM1aXZpS0l0VWRTK3JyOFBKdExUOXVr?=
 =?utf-8?B?Z2xSMERRZnNoRjZrVlNNcGlaYkhnYWRkdFkyOGtUb1RQblJESlYvVmRlWkQ0?=
 =?utf-8?B?SS9PWWIzYm13L3lpMit6bU9aYVF1bVYwclBpeGJCbEhKa3R6TjNSbTA2bTJ5?=
 =?utf-8?B?WHNvdHVXRk1aZmN2RzloclJEZ3gvcjIzckJWM29wM2QwNDFtTFYwRmVGN1lS?=
 =?utf-8?B?SFo0TDByUmc0blcvTExNU2hXdkNjWXhodjhJNnFiTENmdThER1RyLzRLM21B?=
 =?utf-8?B?UWpUYVN4L3ppRlJka0M2YjVPNVNYemNpL3FBVVR3MStUeXorRW9OY0xrL2hE?=
 =?utf-8?B?ME5rNXBZL1hyV2xwOFVXVEV0Snkya3oxZGExdk5yL0N3blFkTGt5U1RVY2NI?=
 =?utf-8?B?UHhSREZXQmM5L3dsUmplN2l0ZWFFRE9nbGF5YlV4bmlMd1BRREljSmRRR2Ru?=
 =?utf-8?B?YUJ5QndDR0JuM3NScUp0VDQ2aEtUM1ByZVVZMDd3bXhwTytKaWZxVVR2KzJt?=
 =?utf-8?B?TlZmUWpaQ3o2c2dONjBkWkhoT1g4cS9ham5xL2pESklJVHZvVlNBK0pBMjF4?=
 =?utf-8?B?U2JoSHlHTjMxYmdZY2ZEMit2S3BhWWZjMGNRaXRENTNjdXlWQTV5K0ZwV016?=
 =?utf-8?B?Qmt1R0VhRG5ucGhEZXpYUDVxeFN2ei8raTBLcUdzZlNOcVMvNXhpZDFWTUxW?=
 =?utf-8?B?bUdGZXBnQlg5NldIeHpvNFMzYkQwRnhDbU5TMi9XQk1zWTNEVkFNNUZsdUpE?=
 =?utf-8?B?bmZpYjQwa3RRSEZ0UDdlUzZVYm1hcnhXSDBBUGx5V1RQL0FXM3UrdGg0dTdB?=
 =?utf-8?B?WEdWdmJpQU9SZFliUXMzUTcvd1dmRHh4KzhYODJnTS84WE04S056L0orcVl3?=
 =?utf-8?B?Z3hmQ3Ewb3UzYmJpMW5YbTBRUDhwemJCeUwycUEzaHdMb1E5bnJiaDRBakVx?=
 =?utf-8?B?VUk4cFhXZjQ2SzU2SnpJM1RlMm5mMUhuUlNselk0WE9vL3JmUDIrUDAxbDFY?=
 =?utf-8?B?OU9ubnFuZFJTQVpTU283QmQ3YzYvRkFxOEdTTnQyY0wrMkdQNVlkckx6RW9Q?=
 =?utf-8?B?Nm9VbmdBUWxCSEd6Uk9rVjBXUjBaMTUyVTNNZkUyMi9CeWtSY0hjd2E2Z2Qy?=
 =?utf-8?B?cm4waXFUY211cTFNdkNvQ0hrYUhid256MnJ3NENNbjA3SDRBTXFoUjc0cDJw?=
 =?utf-8?B?dVNlSDdCY29nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RThvZHdlT3JoaU1qRXgrWnhjSWlITWVIYXRPZnVJOGdGM0dkdGkyUlJqRXpZ?=
 =?utf-8?B?YXZoQ2lONEVEbFAyT01LdUlwRUNnYllsdGdqVnFtVHVHdnIvcEJqMGV4Mlow?=
 =?utf-8?B?N2FyaDZiUTRGTlhWZ25iWFlKNUdVelNTblJwaVNuKzlheXVVZW1RQkU0U29x?=
 =?utf-8?B?SnNUcmFReTFtK1d3UWk5TUZDRnZXb3RFTFN4QmtxVnBEOUZZc055dUhGcWZC?=
 =?utf-8?B?a2dLOEVWM2Y1UWVSMXhOdG84TitkQzB2aWZXZ0VuRk16UjlLMjY0amU4SGFN?=
 =?utf-8?B?WitLM2cwUThBK1kvQktRZUdGTk9EZFBCc1BkREptU0hzWHlxb245ZkRUVWpF?=
 =?utf-8?B?N1lMMENTSld6M1NuWUZmN3JkaVpTWkFMd1NaTWxOakVmVjNudTdMaXlYaXJm?=
 =?utf-8?B?WHVUTzBjMjlwRHpkYnJQMDJTQ0dOMFNLcmdxbEVRcDJTdGsxM3BtUVQ2bTFk?=
 =?utf-8?B?dGQ2bWtFRUVRQlgvSWNwcTFiV21mTWM5b1RTSjF2Q25Qa05ib1JqVXUreUZO?=
 =?utf-8?B?ck5NdUIyMWZWVkZ2UlNlK1gvK3ltTDZmMmxDT3hUZ0hCY054ZW8yK1dselFE?=
 =?utf-8?B?QzRCVkg2c0tRRFQzejQxdkFjQUQvTVpxRFBvLzEwbGRFeTNSMDNFOTFaWHBU?=
 =?utf-8?B?UkJ2MzJnbUswSkJ0V3I0RnRPRjhoMU1MS1cvTEQrZWt4MHNtblE0clBma0J3?=
 =?utf-8?B?MkZHbmxGVCtNTlVLQW51elJPak5Wakp5RjQwSlNzbXliMzZjOExkT1RFc2pQ?=
 =?utf-8?B?KzFhRUdqVzFwZ2Q2TllaRXB2WWJLUi9iV3NCZDFiNUJ1ay85Z21iRVZlNHBt?=
 =?utf-8?B?Z1FDNmMwM01nU1c0NUNBWHpMbmpzZlZoUnVJN3ZvUXFBK2YvdVZobkpKSTdv?=
 =?utf-8?B?cmJGL1VoWjNZSzcwT3FvWU41TWhIUWVUU1hOanA1OERhVlMwamo0WHpHVEpo?=
 =?utf-8?B?a2YvaVNEcFhwQnRBQmJtVGFiV3p1d0ZvWHFDWXhrNGpMWGtsZ2cwMWpTVlU0?=
 =?utf-8?B?K2F3aXZ2YzNzb1UvZHBvNjVQTWtnTndwZ05UZUw2dUlQTjBqa3p4WS8wYUY2?=
 =?utf-8?B?d0tkRDFSNVk4TzdWTkRZRWI1ZzhRdy9KZWJlQTh0Wks5RlpIeXV5ZzVHRi9u?=
 =?utf-8?B?Q2VYS05oY1p5QjRhdGVzdllTaENZOTJmbHdhVUY5SWpKTGdBWHorQlZJZ0NB?=
 =?utf-8?B?U002TGk3dVF5RzM3ZUwycDhJZFVhc0tzSTh3eWFiQVpONENiOGxLcnQrbnM5?=
 =?utf-8?B?dUFBODk5VEZEdDNNWS9uTTQ0MDhJYXNKajhvVmFtaVh2andUMnhQYStxa2hX?=
 =?utf-8?B?cE11bjBDbXNwbmN4eG1IcjZPMGZ4ZHpUWGZjMWJtM001bjNzc0VDZVRnVUV3?=
 =?utf-8?B?Mzd2dFltcWppdTFTWVFlUmFSeVc0Q1gyT2trSEVzeTJ1UVJQdFVBbGVZV3Fn?=
 =?utf-8?B?Ull0SzNSVzlnbnVNY1M5dXRXbVpWZGJVTXVOekVXVGFaUjBzc3RMNzN2N1pV?=
 =?utf-8?B?WXRhOFI3bVhSd3B1R0dEVHM5UEQ3UWtLamkzTUJyYnlJS3R5TVZoQllVWEtM?=
 =?utf-8?B?L0RrT1JqZ09SZEZranl0Si9zR2VFM3VCNGgxMU1xdS9ldFlmNGc5RUVMS0E2?=
 =?utf-8?B?ZGhkVkl6MVFTbGMvRHNKTEQ0cWt3T1JUWmxtUkN4WkJCd21ybFRTVTQxZ0N6?=
 =?utf-8?B?WUxPZFBVNno0b1htaGVyNjZ4dUFqc3FQd2VBL0ptNVo5bnprREozWk96QUg1?=
 =?utf-8?B?WlN3T3doR3hoOEliV2toU1h6V2NFYVhzL3NQRnQxbnBDcUNUUXhzbWt1cU5M?=
 =?utf-8?B?YVB4VzFTVEFpK2pBdzltbHVqOGpCRXZkNklpZGtvZXEya2JpZk9Rd25LamVw?=
 =?utf-8?B?dzhGL1NIZmpxYitjOUZVY2NCRTBzd250SXpVM3plTlVYYTRYclI3c0RhZG84?=
 =?utf-8?B?Y00zamdpdllDY2xHMUgxeVpuS1FxZDlOcnpvcG5hcnhWdG55VGV5ME5BQUtM?=
 =?utf-8?B?V0tMY0Evb0ppb3FUV2g5WlpEeCtHTzBKei92NnFaM0NFZXh5dUVHWVFzQXJm?=
 =?utf-8?B?TGV4Z25ycTRQdVllNktKM2VHY1hrWDhGTEU0SDI0aUkzQ2xXdnUzV1BobFBy?=
 =?utf-8?Q?iigl0GRx2GBNWprAp5E0v0lnK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B98368FA5ED8B48A387E8DD742FC11F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S6E5I+CxxHLVEX4yKkb6usZi8Y3WimYT6X8QSQ/Bu6JD/AzcQqxAki/kwfz+7il0Scr+/M5QTmfKFo9ud2KZzDxEG62GC6/p41B0liAZpIW18dXBu8utLMMnbAWYzWW1GaR0OS2QScyrTGMvqTxtUmTFm75NpsaqxesoZP/KVaI5xGWq06kL8LIrbrv+MMtuTCrXylRxMj7ccq71KUXX9p1bHOcVC6xT+EU1sD0jEDabRfMUPoTZcs4Ac+7+T5v6gneQMo+7MUPIFy9NYY3jvxNFdy2rNYQdcoNR0RzdADGywNDKKrK3ludCu8JzwqPicHU4K84cIJT46sDlBZIr3WBkIFZhYqn5u4scn5NiLdkhXw7ZHp+MtavHF/rdxlIRiV3xIUPLw7ZdPK0gkfYbYFi7Rs0sn/1CXyc2Iwm8+l1S5A0Ep/cBBpWBlDJgKbT527PCCbM9e/Igl+1D4dbLq0o3BEy6E5a9mc+4cXjI7g5IPHTgGlK9vUzJhMIfqWdhT3bEiQu4obPpEwjOe7JwNBHoXXAktFlw0s7igBz2iL90No5Nxo4ZpYITZIuNm0jh/vN4aHE3tC94CHACd1RcQ61rWqMi6aOJcm2Mxb6Pc5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcb29c3-f43b-49f3-72d1-08dde0e6f4cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 19:14:31.0266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpqVKSNVvi/pwliWtEpVXsPYvruwTfuvCQPIgxRR1I/sBJnhXBqgQT6ZkWUqaxoN9S/mTQGBXgpKWYOQib8LpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=694 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508210161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX4sj6PwDIR98p
 Syb1rOw4vPfGOXa4hoE7a+urv2cZSg608mk/VzUkrIckmThgy49q+oyN9ZS6tX7rjfjfwiz3mDC
 /Q9vyLfvBcyRlARC8+x0s1lmYU6VbkBDg9oZJXIyrs99X6nCgEIim4HhyqptVPnbxxrYfSFy5FS
 hIeyrLiPTooFhaKxCGxTTO68lg/NZdnsTbdhNDO8M9OMvmcUtXOv+bo6o+0uI5ZN2hyIYHkggMH
 aCfevZA5WL+3zX6CAPt30xBk5Pve1NezcdGoIkpZC4MCZ/uzpZrKs6ltgV+bu2pyTHGk32M5NtM
 6HV1rhjviDBeSwBmiRNfUojNwAZzPZKvIzBtUTZdbrcCM+p6GrYsZb/6L7i/0Utj3wIp/oadd85
 p+akf1b5VqT07zykyQcnJNX00t7SjdBUCzon/4Rth6lB0l9ExRk=
X-Proofpoint-GUID: Zj_DRj56xtzyzc8mjJaRytdSHTYCL34H
X-Proofpoint-ORIG-GUID: Zj_DRj56xtzyzc8mjJaRytdSHTYCL34H
X-Authority-Analysis: v=2.4 cv=V94kEeni c=1 sm=1 tr=0 ts=68a7701b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=dgns49oINhiGsg_JioAA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13600

DQoNCj4gT24gQXVnIDIxLCAyMDI1LCBhdCAxMjoxNiwgS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4gDQo+Pj4gKyAgZWxzZSBpZiAoVFJFRV9DT0RFIChmbnR5cGVfb3Jf
Zm5kZWNsKSA9PSBGVU5DVElPTl9ERUNMKQ0KPj4+ICsgICAgew0KPj4+ICsgICAgICB0cmVlIGZu
ZGVjbCA9IGZudHlwZV9vcl9mbmRlY2w7DQo+Pj4gKyAgICAgIHRyZWUgYmFzZV9mbnR5cGUgPSBU
UkVFX1RZUEUgKGZuZGVjbCk7DQo+Pj4gKw0KPj4+ICsgICAgICAvKiBGb3IgRlVOQ1RJT05fREVD
TCwgYnVpbGQgYSBzeW50aGV0aWMgZnVuY3Rpb24gdHlwZSB1c2luZw0KPj4+IERFQ0xfQVJHVU1F
TlRTDQo+Pj4gKyAgICAgICAgaWYgYXZhaWxhYmxlIHRvIHByZXNlcnZlIHR5cGVkZWYgaW5mb3Jt
YXRpb24uICAqLw0KPj4+IA0KPj4gDQo+PiBXaHkgZG8gdGhlIGJ1aWxkaW5nPyBTZWVtcyBsaWtl
IHlvdSBjb3VsZCBqdXN0IGRvIHRoYXQgd29yayBoZXJlLiBBbHNvDQo+PiBkb2Vzbid0IEZVTkNU
SU9OX0RFQ0wncyB0eXBlIGhhdmUgZXhhY3RseSB3aGF0IHlvdSBuZWVkPw0KPiANCj4gSSBuZWVk
IHRoZSBmdW5jdGlvbiBwcm90b3R5cGUgaW4gdGhyZWUgcGxhY2VzOg0KPiANCj4gLSBhZGRyZXNz
LXRha2VuIGV4dGVybiBmdW5jdGlvbnMNCj4gLSBmdW5jdGlvbiBwcmVhbWJsZXMNCj4gLSBpbmRp
cmVjdCBjYWxsIHNpdGVzDQo+IA0KDQpBIGxpdHRsZSBjb25mdXNlZCB3aXRoIHRoZSBhYm92ZToN
Cg0KRnJvbSBteSB1bmRlcnN0YW5kaW5nLCANCg0KMS4gQXQgZWFjaCBpbmRpcmVjdCBjYWxsIHNp
dGVzLCB3ZSBzaG91bGQgZ2VuZXJhdGUgdGhlIGNoZWNraW5nIGNvZGUgdG8gDQogICAgIEEuIGxv
YWQgdGhlIGhhc2hlZCBwcmVjb21wdXRlZCB0eXBlaWQgZnJvbSB0aGUgY2FsbGVl4oCZcyBwcmVh
bWJsZSANCiAgICAgQi4gY29tcGFyZSBpdCB3aXRoIHRoZSBwcmVjb21wdXRlZCB0eXBlaWQgZm9y
IHRoaXMgY2FsbCBzaXRlDQoNCiAgICBTbywgd2UgbmVlZCB0aGUgZnVuY3Rpb24gcHJvdG90eXBl
IG9mICB0aGUgaW5kaXJlY3QgY2FsbCBzaXRlIHRvIGNvbXB1dGUgdGhlIHR5cGVpZCBmb3IgdGhp
cyBjYWxsIHNpdGUuDQoNCjIuIEZvciBldmVyeSDigJxhZGRyZXNzLXRha2Vu4oCdIGZ1bmN0aW9u
LCB3ZSBzaG91bGQgZ2VuZXJhdGUgdGhlIGZ1bmN0aW9uDQogICAgcHJlYW1ibGUsIGluIHdoaWNo
IHRoZSBwcmVjb21wdXRlZCB0eXBlaWQgZm9yIHRoaXMgZnVuY3Rpb24gaXMgc3RvcmVkLiANCg0K
ICAgIFNvLCB3ZSBuZWVkIHRoZSBmdW5jdGlvbiBwcm90b3R5cGUgb2YgIHRoaXMgZnVuY3Rpb24g
dG8gY29tcHV0ZSB0aGUgdHlwZWlkIGZvciB0aGlzIGZ1bmN0aW9uLiANCg0KVGhlIGFib3ZlIDIg
c2hvdWxkIGNvdmVyIGFsbCB0aGUgS0NGSSBBQklzLiANCg0KV2hhdCBJIHdhcyBjb25mdXNlZCBp
cywgd2h5IOKAnGFkZHJlc3MtdGFrZW4gZXh0ZXJuYWwgZnVuY3Rpb27igJ0gYW5kIOKAnGZ1bmN0
aW9uIHByZWFtYmxlc+KAnSBhcmUgc2VwYXJhdGVkIGl0ZW1zPyANCkZvciB0aGUgZnVuY3Rpb24g
cHJlYW1ibGVzLCBzaGFsbCB3ZSBnZW5lcmF0ZSBmb3IgYWxsIHRoZSBmdW5jdGlvbnM/IE9yIG9u
bHkgZm9yIGFkZHJlc3MtdGFrZW4gZnVuY3Rpb25zIGluDQp0aGUgY29tcGlsYXRpb24/IA0KDQo+
IEF0IGluZGlyZWN0IGNhbGwgc2l0ZXMgKGR1cmluZyB0aGUgZWFybHkgR0lNUExFIHBhc3MpLCBJ
IGhhZCBhDQo+IEZVTkNUSU9OX1RZUEUgYXZhaWxhYmxlIHRoYXQgc3RpbGwgaGFkIHRoZSBmdWxs
IHR5cGVkZWYgaW5mb3JtYXRpb24sDQo+IGFuZCBJIGNvdWxkIHVzZSBpdCBmaW5lLg0KDQo+IEZv
ciB0aGUgb3RoZXIgdHdvLCBpdCdzIGxhdGVyIG9uIGFuZCB0aGUNCj4gVFJFRV9UWVBFKGZuZGVj
bCkncyBGVU5DVElPTl9UWVBFIGhhZCBsb3N0IHRoZSB0eXBlZGVmIGluZm9ybWF0aW9uICh3aGlj
aA0KPiBJIG5lZWQgdG8gYmUgYWJsZSB0byBleGFtaW5lIGluIGNhc2VzIHdoZXJlIHRoZSB0eXBl
ZGVmIG5hbWUgd2FzIG5lZWRlZA0KPiBmb3IgdGhlIG1hbmdsaW5nIHZzIGxvb2tpbmcgYXQgdGhl
IHVuZGVybHlpbmcgdHlwZXMpLg0KDQpUaGVuIHdoeSBub3QgYWxzbyBjb21wdXRlIHRoZSB0eXBl
aWQgZm9yIHRoZSBmdW5jdGlvbiBwcmVhbWJsZSBkdXJpbmcgZWFybHkgR0lNUExFIHBoYXNlIA0K
dGhlIHNhbWUgYXMgdGhlIGluZGlyZWN0IGNhbGwgc2l0ZXMgd2hlbiBhbGwgdGhlIHR5cGVkZWYg
aW5mb3JtYXRpb24gaXMgYXZhaWxhYmxlPyANCg0KUWluZw0KPiANCj4+PiArICAgICAgdHJlZSBw
YXJtID0gREVDTF9BUkdVTUVOVFMgKGZuZGVjbCk7DQoNCg==
