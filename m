Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2F2264BD
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876068; cv=fail; b=qw7FSLdzJrbH9auWTeNR4Mn1uC6VA1FmDGc28KAAYx/ci0z3KZuUG2QcCiIVr7ClKEk+VVGxV5zSX0CcBIkBLnvSK1VkQ4if+h5y/cNbNTUfvYtDXSdU3iBLj1si9Gh5hPYf2axP0JHk6SC7ue8CexMEvCw2Ikv882FuskRWEQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876068; c=relaxed/simple;
	bh=OXpHfhNghtCMcpa+l7a0vHq3tmBLVZXjYo2qLV4pYc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qnl3DU6x+7K+9S7iIwxMJ9A+1FBFrjhqjE18kbTFqFqsqPSP9fHKPhHJ5CCPt7s/ok1cHSIXoVngCFlyLOg/oKmXI3lIq6EZwYvu0Krdl7LOgxzHaLQo8kAyxZHDx3zB+6dD3GL99gPlBx7SgaLbnF6oalM0uUXaG+JA4eS6Vak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l8mrKPDP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QnPR9yCa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l8mrKPDP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QnPR9yCa"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MFH2Gr023643;
	Fri, 22 Aug 2025 15:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OXpHfhNghtCMcpa+l7a0vHq3tmBLVZXjYo2qLV4pYc4=; b=
	l8mrKPDPq6U6cOoUUGXUUVXBf0ZyR02mYI9G1+Wm1Ir2BrdtJ1SMbm6JNy147e80
	I/YBa538V9OOlQ4bOdlhQ7Mw6rssrOMkWUBca+QiQd30HlomoSx42QpbVx1Lmno2
	YtLlqvmLz2wPMyNXzE5nze7fn+BzMh8cpASVaKiNG3a4lwDU4Tc1HGExAFv7ew65
	9VnTydXUbqIlP+ZYrmOx7Ow4hBYUdMyajKQbbqPko6AJUezppxjJ+Ac9LEMltAn8
	mAgvI+rQ5jex41ob/yXXh8VMcft53e99vI8Fgj7052ViOuLYy7rGr90W0bFNJ2ex
	Z+s+gsEGl7GuMrPL1CL5NQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pa269k5r-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 15:20:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57MEFUOK030214;
	Fri, 22 Aug 2025 15:11:20 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3wswuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 15:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyttUUJyPCS4i+u0+p8im0cb+udvJwD4R8WIndHQE77IWJBJHFAjrLf6dUVUwkkW/9oIZ8G6lIqoAk51stszhA9C85oWAH1BfR2F9pxrpRRlzY2HzamROKTv3fzs0NHI7TVk20uP3Pn5i8n9S9rvQCGNsgCHGKl5XlWplytzW8fp2MwNzWowjee8RhAOO+ByLibWOL5VqtgCvlGVuI81m+6gn1YobYUOrouYmHioBcDq2/wuNxgL5peZJeaq6rixYVRuE6jjj0D9dHT1n39EhFIQeH8hl4aV5K4o/LdJFGbVUeEh0uMibx6cQnuXRU7i9LXGk1U1PoqJCUyMvbyj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXpHfhNghtCMcpa+l7a0vHq3tmBLVZXjYo2qLV4pYc4=;
 b=asV0PiD093Ecf/8+yPjbjq6v8ParFv222Ix+8Xlal1fznIVy6f1BNabkMFqg9dqy30SLJauXN75GSJ9hyBtTxW/bZfPiTDqYYAicBK80uJO+CL9duDkScoz0Cmg/tWC54UrxGXNv9Weo5k62iamCTM+mLYmWPS1LqOHo2nl8fkr6PCe4CTFESqovo45aaMOOiAGdlDfBP2k40PyU9mYgp2h0yGV6gKNgYCk1TIsOij+pcSNWTpTCBCQUuWSKolS2Bq7qgIa507vzL0zTFJTBQOswCWZzygC6yDRUN2r6kfWLS2GzaS2i6W0JsrUNJOVIVD/LX54f2y7XK+NZtKYrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXpHfhNghtCMcpa+l7a0vHq3tmBLVZXjYo2qLV4pYc4=;
 b=QnPR9yCa3Vwv6EerXTPQX3xsIUhoNZEBTTd1dskFHIHF8Wqfy2I6e5UE7wQDJ5N1LzlZtAT3d3+Jw0BmDrpHnAsPo3xoWsBydzQoHvP/M4lyvnLtWZmC7SLSG6KnJ0fqlK/0iHmOx2IBubK1XVhlqtmL4qPiNHEJHb42lWI+DGA=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 15:11:16 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47%4]) with mapi id 15.20.8964.019; Fri, 22 Aug 2025
 15:11:16 +0000
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
Thread-Index: AQHcEm0EGi+s8Q35f0a3asvZv7CnCLRsvhQAgACK1gCAADHTAIAAJaIAgAEovIA=
Date: Fri, 22 Aug 2025 15:11:16 +0000
Message-ID: <22C19D00-58D7-4854-915E-C7B8CDB3317E@oracle.com>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
 <202508210841.8BE6E3C117@keescook>
 <E69330D6-1302-4BA1-BADD-8C91A096A1FD@oracle.com>
 <202508211258.8DEE293@keescook>
In-Reply-To: <202508211258.8DEE293@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|PH0PR10MB4696:EE_
x-ms-office365-filtering-correlation-id: 4d47316d-7129-4958-b76c-08dde18e23ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWh6NENPMTFDTVVwRW5kYzRPTGI2NGZPejJTN2k5M2ZSL1ppeU5uYXQxQzFl?=
 =?utf-8?B?dkFjbW1YNjlWdWQwSjBjUW9ZcjFHbGNpYnlvcFlPeVptRGRuVHV2dEgyQy9w?=
 =?utf-8?B?cTZOd1Z1eUxIZmhwWlhVbHYzaEt2UGhrSzB0SFBVRklyT3daTlEyd2IrdjZL?=
 =?utf-8?B?NlM2czUvMG9VT3EwWTV2K0pHY0dsTE9Ub1pLTXphL1ZTeUtocGwrUzZKaFB5?=
 =?utf-8?B?dlRZbllxSlZkOU5ESmFoSFZsVEFPc1IxSzREa2srZ0dVYXpuTkFXdUsva1Jw?=
 =?utf-8?B?dlVEVGh5bnhNaUZ4bmt4WEUvT3BKdlRXSHVhRXJJWHduOGZoV1EvY3JuZ3Vx?=
 =?utf-8?B?bTNrN0pIWU1td1U0ckxpdlo4NVU3ZWlDVU9taWVlUzdneHhDQnBlV2RCNERP?=
 =?utf-8?B?blJnaFNTUFpkV0tqT3hXd3hsZzNaeXArdm5MVWJ1RWN2ZHhHeVlPbUgxZ3ND?=
 =?utf-8?B?cXY0TXV4dUNLT3ZQcXpLRjd2eVo2YjJ2b3BOV3VpRmNEeGlPanNZTXllYTlV?=
 =?utf-8?B?UDNKTVpDbVJpY05qNWVmdVpUaThSeWZhK2FPZ2N5cTdPZ2l1R2RGamNQVVJv?=
 =?utf-8?B?RGR2RFp6NmQ4Q2lzdjdsSGZuNUxPWUhxSU9FajNQeityV3BtRzBIejl2bk42?=
 =?utf-8?B?UWNPY1lEd1FUbE5EeHk3ck1qVXFEVy9NTi92NG5FZkdDSjU1VmtUVUVlT3VN?=
 =?utf-8?B?cTFxMllYMlpIcHZMSWZwZnVBYytaek8yQU80N0ZlamlGcStRUmVHT3J6bzFs?=
 =?utf-8?B?WDlLcFVHZURVSllGT2M3eU5IMWtXcnk5TGJCMXJXelc2d2ZDbnE2aHBER1U4?=
 =?utf-8?B?dnpvU0V6WkRlQmFIK0VxWXU2ZjRWWHFMeHk3dnZaSDd6d2g0MnNMUHUwMmxM?=
 =?utf-8?B?aTZuNEdFcE9UTXBLWVZmc2R1c204c1ZlYlhoL1BiaVprckdUdDF6U1E3b0I5?=
 =?utf-8?B?Tm5FaVpXV3FwaXp2UExCVm13NVJnU2lZdnNRUlZQc01IWXZyWkMycDhlaHUv?=
 =?utf-8?B?RGczMnFCY0xsQ2hlWGZZYUp0MVZTSXFPOXR1cDBvL2x2V2s5QjJpOXhSS0Ja?=
 =?utf-8?B?bkpuR3N3QnZvUENLSXIrVmdyZFFLdlpEVkRpN3BuQjdsbFpYVExtdXVWcTgy?=
 =?utf-8?B?MFhzbGVSQWk4aUtZZW9xSHU0eGxWWkIyY1g1S2c2S1VKdkNFOVJqRnUwLzNB?=
 =?utf-8?B?YnkwcThQV3RoL0psMW1VR25ER1UyeXg1SU5FejRzMmJlR2xyTURVaTZTaDB5?=
 =?utf-8?B?QjE0TUV5aWtoYUJLbzcxY1E4WXBkbVIxR2ZBcFR3YmwwUko1Z0RXMmlsT3Y2?=
 =?utf-8?B?Z3NLQ01WRkprVGNSdlduN3MzbUJuWituazVjOEJtZUhMKzR6czR4bTBSQ3pS?=
 =?utf-8?B?ak5CRFF6RUdkSURXNTlEY3JDLzBaQnhDZlpzc3pWcWs1aXlSQkowcVR0TGZ4?=
 =?utf-8?B?Yk16SVd6LytWMTdCUGxPaXJDdThObUJhWEtreHNRV0tHV2Vmb2ZoSVV1NnhC?=
 =?utf-8?B?N1pJWm9ZbXZVOUhRR3lxUHN6MXhTRHVUTDIyL01GM3FsMkNNUGMyYVBuTlVp?=
 =?utf-8?B?Y0IwOTQyY0VWMFg1WHNvU2VVVGFuOU5UQWFKTVBFcGpTZlZwdUxoUFlGNUFL?=
 =?utf-8?B?S3cwOWpZSC85MEV1NWhsQWlhd3grZWY4MityV0lRTmw5U242Rld6VGdQMW1K?=
 =?utf-8?B?dTA1TlJRSjliZzQxZlltWXZxaWhHMkFNMEIzUG9EYTlJbTg4YzN0ai80SjNK?=
 =?utf-8?B?ZnZudnRMNUthcWpGRzRaSk9yMGZkdGZzR1l4QTJTekxidE92SXBqL3BvazRI?=
 =?utf-8?B?eVVsL1ZYTEVXVXljeWFqaWY4dnFLVlhYbDNCd0JEb3BoLytjWTBQK2Fkd3BH?=
 =?utf-8?B?elpNRVdkS015R0xBdTVhc3JzcDdvb2FxNEJRTGwvK0s2RVZPUDNNenlGZXRo?=
 =?utf-8?B?SUllMnNFSWJxNjgwWnk2MU03U2RwTzV2QSt4Y2dLbGt2VmVrcW00TnU3dGIx?=
 =?utf-8?B?Rm9lUEdKY0FRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THZiVUVzUHRqamhlUzhxR1JTNnFKSzJjUFFmdXpqN3pZZFYvdDRINWtnbWVI?=
 =?utf-8?B?N0x4NFBxNHpyMDZYbXNXelJ3RDQ4dkU2YVpFK1hhT3JYL1RYVGw2cDNTT2dh?=
 =?utf-8?B?TFlOSlNiUk5pb1NBcmI1ZU16RmZpdzFzWWk3M0tZR2VoK2pYWm0yV0g4eTMy?=
 =?utf-8?B?SnVKTE90OWZnTDFtemFyY1FxVlpkb2VPMkd3WHNSb2NINjM0MmVXRGNlZllT?=
 =?utf-8?B?RFg4NE1qV01kYUgrWUhXN0N5YUN6bkhiRzV2aVh5SmJpcVpyS0J1Q0h3TExn?=
 =?utf-8?B?Q2M5aWc3NzNheEhUWVp6WjR5eHZNSEoyZEZLM0xSVWJ3d1ljNGpMM2MzbUds?=
 =?utf-8?B?TG1ZSmY5L3RwaGdLd1UweGdWajhnU0tCeHFtWFRNenFyR1lVc1JINFcvSE5T?=
 =?utf-8?B?aWJjVXZLUU96bitQSHJKU2s5QUxOcXhibnpJVWtHakUwQUtvMGpXNWorWVNh?=
 =?utf-8?B?aHF4Y2dtRmtKYmcvNWxZckRQSnB4Q0s1SlBKYmYrZnJWWDJkY3FXeFlBVzRs?=
 =?utf-8?B?U1Y2UVNuUS9HdHpOVWdhS3VicU1xZUh6cUFwenVpWDlhcmpBUnBybXJlMDhn?=
 =?utf-8?B?Y0F4djY4RnIrMEdXYnhqbkRUYjI3eVFoZXVENmYxOWlENCtHdGdFZXBDTUlt?=
 =?utf-8?B?cjlNSDIzWGc1R0FBRXF1TzRNT2d5OTcvL3p0UUloaVY4UEdTQXRFYmhrbFNP?=
 =?utf-8?B?QU1oQWs5NzZHNkpvZitoWHVNNUc0MzFtRitNemdEMitqdVg2dUFsTWxGWUpa?=
 =?utf-8?B?Zk45Z0ZhdTM2NTZ3UG5sU0h1VEJkbVhTZUswVWFsRy9RaHZTOGFod2k5ekpO?=
 =?utf-8?B?TGtIUXF4SDdLeFhNZkwyUXdBaFNxRFdnNkh4VDNyU3R3NzRnaTZwanpmR1Vy?=
 =?utf-8?B?ZDYwL2RXaSsraUp4V2pJeXpvR1BNTDc0Y3hsY3R1bVZXd0E3bEF4cnFZYURE?=
 =?utf-8?B?SEhScGluUGQra3NXczJxclFvd2JOb0xTYXk1RXF2KzRuOXNGam1LNytRQVkz?=
 =?utf-8?B?a3pJMmtQTWh0WDE1ZHN1RU0yQ2l1bjFvWStPR3k1V1pRWEdDekRuM0NpZ0lN?=
 =?utf-8?B?NlRNQjFIK0dIT1hUQ2FxWVN1S1FkM0hncE9UaVQrN1BQdnJpU0c3UnFTVHFK?=
 =?utf-8?B?dEdYVzU0YXBGbWpicFdHWjRycStzcXIveEZ2ME4yQ2ZaSVNMaFNFZ1pnNWwx?=
 =?utf-8?B?aWNBcUFMR08zRCsvcnM4MkZSYkVFRHhZdWdpZjJzZldvOVpJVlZXdW1Dbkth?=
 =?utf-8?B?ejBFeDh2ODc1TFJVMU8vREFlYlZyNi9NQ09Ra3laaVhva3p6UGROK3AyWUFz?=
 =?utf-8?B?RmFKK1R4U214KzhPWGJudUUwdTAydnoyNytVT083aXdmRElob1BzWHNJaVFX?=
 =?utf-8?B?VVZwV3FnYkZ2cXUxRWdqYmdOYWRmUDh6N3RnV0RvWmkwWlg3eTFpWVF6VWFi?=
 =?utf-8?B?RmUyWlliL3FQMlg3Y1RXZk15clYrZ21yTVI5emdpdzF1TzcrcGdXMTBEdkVK?=
 =?utf-8?B?WEsva3ErUVQwMENnSkZkOW1kTmIrbjhMMXFwN0lQT1lrN0Y1bEhlaWk5K0Fn?=
 =?utf-8?B?U3l4bytpYk80UzBFbW55bFVqbWM2YXJoWXBHK3dwMlhwTkRwNWQ5eThEd09V?=
 =?utf-8?B?bDcwSXpsb2s5dTR5V1g5d3paVE01R0g2Vm9pNFRVUFprUDByMnVKVzVoSFor?=
 =?utf-8?B?Sm55VFZpdG8zVlFQZUxrN2dtczlDOEVHVkc5Y1dZVDVLdmkwK1JlVkUvMzcw?=
 =?utf-8?B?WjlXZ0h3eGUwSWZteER3U3F3Ujgxa1F4Ny9GMHlkcnJEMGhRUkQzbWV2RTBz?=
 =?utf-8?B?T2oxV1ZpajhMbWE5blZVSXhGdlVVaXVHUDFQRXNsMGUrNkpvR2tWeVJwZy9K?=
 =?utf-8?B?cjNtRm5vUnZPT0prTHRvQUIyak9DSHFyTnRicFd0K2NPMzZteVlHRnVaTXFp?=
 =?utf-8?B?eUpXNVQxOWlCdHJwVmg1cmt3VUM4SWF5MW9rSisrMm94L1cxRmt3amErZDVM?=
 =?utf-8?B?M091M2xRaDFrbnoxTndZWVVKOGkvL3VrMlFmemhLYThSeTFjbDhYN09EeFo3?=
 =?utf-8?B?SU1odjR3ZEcrZjI5WktGVXRWQUs4OGoxOGlMUlBWTG5pYzJHakJIWW04T05S?=
 =?utf-8?B?YVVqNCtMVjJ6eWNOa1BBaHlWU2VzZFdoNlhJVG55NzF0UHlNVXJJeCt2cmZq?=
 =?utf-8?B?V1BKcFVIQUI0SUJEcGxhYmFzQzc4enVVSlRhbVBvazNIMmRGNmtZSWhLOXRv?=
 =?utf-8?B?cUJlMUExMndpN1h3UEdVbUxsYTVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9C41EB8A2CB8A458841E321FFB2A043@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JSOmDYlra2v/k1XxQoU1xt17bhlH6/xYE+JvC6wu9Yn/V5ICvm4SRAybuU3eXFqBjcaRsICZef9hHj8rHYBUEZTTuk4N60bF1G49X5x8Vx9H9SFllPHBaO3mFHbjwnHG6ffsGkPJYkeVW5NR246Td9IHxJd6+VoIo2uu2dICNtAMAWTLaVXyOQvilWy6lY3sQBwQhtefUVQiY6fNrdzsGwpSs7hBSK5zuo1l0MQD0ir60ywc5GRl02e9itLxK4JjqRCH85iukbPBomVt9augFzbi0ytxHCLPopVhDKeY/j3QG9+Gr9F+dgr/fefkMFY2vi14M0JhQpjZA6dbnVDC39FJJVFT4nVuydXTqEKlwlnO8WpQlS9NkLkjzhC1kUWEDwx/4j/6aKFkwMhhrLQJo9OsrBxGPZHc51kylmo46ebf/v0u5ViJyJBGWJTBXMskvL6Fk5AJloAtmSmBGGo64CPcbnQeuIzgLejVaXpRN1NWDemTxpKIFnRKHibFfE2xpZ1E6XKJS3For8Lm6lVPca5kO/j468icsRH2CtViYW0xOZJUoG0xjjvYYHgQrlEubNv7tbKyZnmmdMfK+XhmuX59q6xVbhC3yizsTXNqSk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d47316d-7129-4958-b76c-08dde18e23ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 15:11:16.1719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNTZF6YD2YozpQ7uzMPdYjGjVtEEqcfUluTUYTsRNgFzuVc79Srv+py6Rp3Opb1b1yHZU2STyM2Hxar97iMGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508220136
X-Authority-Analysis: v=2.4 cv=ZPiOWX7b c=1 sm=1 tr=0 ts=68a88acb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=zuUB9w-e2FEOFLZ2-JoA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13600
X-Proofpoint-GUID: DPcfmZerPwGM1eEjcYvHhjwNwWP02ZPa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE2OCBTYWx0ZWRfX6w9psefnDdKv
 SdTJqgdVjvqGohhSxlsu3D503KdXZL65eT1rJPy8p/XwxDmWUUIUv3Xe/I8FQo2QC4hybtRw9jR
 Y05RIrbp67dxufrz13sfo7U7c7DQ1gs4vWBemE8nOL+2qOclq5e0cEAysKnb6jAsq9BjsZG2IL0
 X94LbAGA58ITQyehxQAd+xbxytNRQCOa2OzLn+Bvf75rmj7W1zuWaGnto9sSXWeGAQZ234QpkO5
 o3Sq2xhWqBpm4TnQBmFaZ6aFPK6erGimg9iOIH92czdHVnYAULreZuNXjZfk1ih0mY+wpTW4l/X
 Jht8aeC7sqyEAG/0YEBrpqZKdbxupOqMEybW6Nf1pf08OWZOggKfvxkhSW/hwP7tDgKFstZ0WIK
 NidsHG6hvWPEv+aJ2MVxFUQfKoLtVZcXeAwlSmcbzRdOeN4k+Tc=
X-Proofpoint-ORIG-GUID: DPcfmZerPwGM1eEjcYvHhjwNwWP02ZPa

DQoNCj4gT24gQXVnIDIxLCAyMDI1LCBhdCAxNzoyOSwgS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBBdWcgMjEsIDIwMjUgYXQgMDc6MTQ6MzFQTSArMDAw
MCwgUWluZyBaaGFvIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBBdWcgMjEsIDIwMjUsIGF0IDEy
OjE2LCBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4+
PiArICBlbHNlIGlmIChUUkVFX0NPREUgKGZudHlwZV9vcl9mbmRlY2wpID09IEZVTkNUSU9OX0RF
Q0wpDQo+Pj4+PiArICAgIHsNCj4+Pj4+ICsgICAgICB0cmVlIGZuZGVjbCA9IGZudHlwZV9vcl9m
bmRlY2w7DQo+Pj4+PiArICAgICAgdHJlZSBiYXNlX2ZudHlwZSA9IFRSRUVfVFlQRSAoZm5kZWNs
KTsNCj4+Pj4+ICsNCj4+Pj4+ICsgICAgICAvKiBGb3IgRlVOQ1RJT05fREVDTCwgYnVpbGQgYSBz
eW50aGV0aWMgZnVuY3Rpb24gdHlwZSB1c2luZw0KPj4+Pj4gREVDTF9BUkdVTUVOVFMNCj4+Pj4+
ICsgICAgICAgIGlmIGF2YWlsYWJsZSB0byBwcmVzZXJ2ZSB0eXBlZGVmIGluZm9ybWF0aW9uLiAg
Ki8NCj4+Pj4+IA0KPj4+PiANCj4+Pj4gV2h5IGRvIHRoZSBidWlsZGluZz8gU2VlbXMgbGlrZSB5
b3UgY291bGQganVzdCBkbyB0aGF0IHdvcmsgaGVyZS4gQWxzbw0KPj4+PiBkb2Vzbid0IEZVTkNU
SU9OX0RFQ0wncyB0eXBlIGhhdmUgZXhhY3RseSB3aGF0IHlvdSBuZWVkPw0KPj4+IA0KPj4+IEkg
bmVlZCB0aGUgZnVuY3Rpb24gcHJvdG90eXBlIGluIHRocmVlIHBsYWNlczoNCj4+PiANCj4+PiAt
IGFkZHJlc3MtdGFrZW4gZXh0ZXJuIGZ1bmN0aW9ucw0KPj4+IC0gZnVuY3Rpb24gcHJlYW1ibGVz
DQo+Pj4gLSBpbmRpcmVjdCBjYWxsIHNpdGVzDQo+Pj4gDQo+PiANCj4+IEEgbGl0dGxlIGNvbmZ1
c2VkIHdpdGggdGhlIGFib3ZlOg0KPj4gDQo+PiBGcm9tIG15IHVuZGVyc3RhbmRpbmcsIA0KPj4g
DQo+PiAxLiBBdCBlYWNoIGluZGlyZWN0IGNhbGwgc2l0ZXMsIHdlIHNob3VsZCBnZW5lcmF0ZSB0
aGUgY2hlY2tpbmcgY29kZSB0byANCj4+ICAgICBBLiBsb2FkIHRoZSBoYXNoZWQgcHJlY29tcHV0
ZWQgdHlwZWlkIGZyb20gdGhlIGNhbGxlZeKAmXMgcHJlYW1ibGUgDQo+PiAgICAgQi4gY29tcGFy
ZSBpdCB3aXRoIHRoZSBwcmVjb21wdXRlZCB0eXBlaWQgZm9yIHRoaXMgY2FsbCBzaXRlDQo+PiAN
Cj4+ICAgIFNvLCB3ZSBuZWVkIHRoZSBmdW5jdGlvbiBwcm90b3R5cGUgb2YgIHRoZSBpbmRpcmVj
dCBjYWxsIHNpdGUgdG8gY29tcHV0ZSB0aGUgdHlwZWlkIGZvciB0aGlzIGNhbGwgc2l0ZS4NCj4g
DQo+IENvcnJlY3QuDQo+IA0KPj4gMi4gRm9yIGV2ZXJ5IOKAnGFkZHJlc3MtdGFrZW7igJ0gZnVu
Y3Rpb24sIHdlIHNob3VsZCBnZW5lcmF0ZSB0aGUgZnVuY3Rpb24NCj4+ICAgIHByZWFtYmxlLCBp
biB3aGljaCB0aGUgcHJlY29tcHV0ZWQgdHlwZWlkIGZvciB0aGlzIGZ1bmN0aW9uIGlzIHN0b3Jl
ZC4gDQo+PiANCj4+ICAgIFNvLCB3ZSBuZWVkIHRoZSBmdW5jdGlvbiBwcm90b3R5cGUgb2YgIHRo
aXMgZnVuY3Rpb24gdG8gY29tcHV0ZSB0aGUgdHlwZWlkIGZvciB0aGlzIGZ1bmN0aW9uLiANCj4+
IA0KPj4gVGhlIGFib3ZlIDIgc2hvdWxkIGNvdmVyIGFsbCB0aGUgS0NGSSBBQklzLg0KPiANCj4g
Rm9yIG5vbi1zdGF0aWMgZnVuY3Rpb25zLCB3ZSBjYW5ub3Qga25vdyBpZiBvdGhlciBjb21waWxh
dGlvbiB1bml0cyBtYXkNCj4gbWFrZSBpbmRpcmVjdCBjYWxscyB0byBhIGdpdmVuIGZ1bmN0aW9u
LCBzbyB0aG9zZSBmdW5jdGlvbnMgbXVzdCBhbHdheXMNCj4gaGF2ZSB0aGVpciBrY2ZpIHByZWFt
YmxlIGFkZGVkLiBGb3Igc3RhdGljIGZ1bmN0aW9ucywgaWYgdGhleSBhcmUNCj4gYWRkcmVzcy10
YWtlbiBieSB0aGUgY3VycmVudCBjb21waWxhdGlvbiB1bml0LCB0aGVuIHRoZXkgbXVzdCBnZXQg
YSBrY2ZpDQo+IHByZWFtYmxlIGFkZGVkLg0KDQpPaCwgeWVhaCwgSSBzZWUuIHdpdGhvdXQgbHRv
IG9yIHdob2xlLXByb2dyYW0tbW9kZSwgd2UgY2Fubm90IGRldGVybWluZSANCndoZXRoZXIgYSBl
eHRlcm4gZnVuY3Rpb24gaXMgYWRkcmVzcyB0YWtlbiBvciBub3QuIFRoZXJlZm9yZSwgd2UgaGF2
ZSB0byANCnRyZWF0IEFMTCBleHRlcm4gZnVuY3Rpb25zIGNvbnNlcnZhdGl2ZWx5IGFzIGFkZHJl
c3MgdGFrZW4uIA0KDQpTbywgZnJvbSBteSB1bmRlcnN0YW5kaW5nLCB0aGUgY29tcGxldGUgbGlz
dCB0aGF0IG5lZWQgdG8gY29tcHV0ZSB0aGUgdHlwZWlkIGZyb20gdGhlIGZ1bmN0aW9uIHByb3Rv
dHlwZSBpczoNCg0KLSBBdCBpbmRpcmVjdCBjYWxsIHNpdGVzDQoJLSBhbGwgaW5kaXJlY3QgY2Fs
bCBzaXRlczsgKEF0IHRoZSBjYWxsIHNpdGUpDQotIEF0IGZ1bmN0aW9uIHByZWFtYmxlcw0KCS0g
YWxsIGFkZHJlc3MtdGFrZW4gc3RhdGljIGZ1bmN0aW9ucyAgKEF0IHRoZSBmdW5jdGlvbiBkZWZp
bml0aW9uKQ0KCS0gYWxsIGV4dGVybiBmdW5jdGlvbnMgIChBdCBmdW5jdGlvbiBkZWNsYXJhdGlv
biBvciBmdW5jdGlvbiBkZWZpbml0aW9uPz8gUGxlYXNlIHNlZSBteSBxdWVzdGlvbiBiZWxvdykN
Cg0KDQo+IA0KPj4gV2hhdCBJIHdhcyBjb25mdXNlZCBpcywgd2h5IOKAnGFkZHJlc3MtdGFrZW4g
ZXh0ZXJuYWwgZnVuY3Rpb27igJ0gYW5kIOKAnGZ1bmN0aW9uIHByZWFtYmxlc+KAnSBhcmUgc2Vw
YXJhdGVkIGl0ZW1zPyANCj4+IEZvciB0aGUgZnVuY3Rpb24gcHJlYW1ibGVzLCBzaGFsbCB3ZSBn
ZW5lcmF0ZSBmb3IgYWxsIHRoZSBmdW5jdGlvbnM/IE9yIG9ubHkgZm9yIGFkZHJlc3MtdGFrZW4g
ZnVuY3Rpb25zIGluDQo+PiB0aGUgY29tcGlsYXRpb24/DQo+IA0KPiBUaGUgb3RoZXIgY2FzZSBp
cyBlbWl0dGluZyB0aGUgX19ja2ZpX3R5cGVpZF9GVU5DIHdlYWsgc3ltYm9scywgd2hpY2ggaXMN
Cj4gdXNlZCBmb3IgbGluay10aW1lIHJlc29sdXRpb24gd2l0aCBub24tQyBjb2RlIChpLmUuIHJh
dyAuUyBhc3NlbWJseSkNCj4gd2hpY2ggZG9lc24ndCBoYXZlIGFjY2VzcyB0byB0aGUgQyB0eXBl
IHN5c3RlbSB0byBjYWxjdWxhdGUgdGhlIGhhc2hlcw0KPiBvbiBpdHMgb3duLCBhbmQgbmVlZHMg
dG8gaGF2ZSBhIHdheSB0byBidWlsZCBpdHMgb3duIGtjZmkgcHJlYW1ibGVzLg0KDQpTbywgZm9y
IHN1Y2ggZnVuY3Rpb25zLCB0aGVyZSBzaG91bGQgYmUgYW4gZXh0ZXJuIGZ1bmN0aW9uIGRlY2xh
cmF0aW9uIGluIHRoZSBDIGNvZGUuIA0KQnV0IHRoZSBkZWZpbml0aW9uIG9mIHN1Y2ggZnVuY3Rp
b24gaXMgbm90IGF2YWlsYWJsZSBpbiB0aGUgQyBjb2RlIHdlIGFyZSBjb21waWxpbmcuIA0KVGhl
cmVmb3JlIHRoZSB3ZWFrIF9fY2tmaV90eXBlaWRfRlVOQyBzeW1ib2wgaXMgZW1pdHRlZCBhdCB0
aGUgZnVuY3Rpb24gZGVjbGFyYXRpb24NCnBvaW50IGZvciBzdWNoIGZ1bmN0aW9uIHdoZW4gd2Ug
Y29tcGlsZSB0aGUgQyBjb2RlPyANCg0KQW5kIHRoZSB0eXBlaWQgKHRoZSBoYXNoIHZhbHVlKSBm
b3Igc3VjaCByb3V0aW5lIGlzIGNvbXB1dGVkIGF0IHRoZSBmdW5jdGlvbiBkZWNsYXJhdGlvbiAN
CnBvaW50IHRvby4gDQoNCklzIHRoZSBhYm92ZSB1bmRlcnN0YW5kaW5nIGNvcnJlY3Q/IA0KDQpU
aGVuIGZvciB0aGUgb3RoZXIgZXh0ZXJuIGZ1bmN0aW9uIHdob3NlIGRlZmluaXRpb24gaXMgaW4g
dGhlIEMgY29kZSBvZiBvdGhlciBtb2R1bGVzIHRoYXQgbWlnaHQNCmJlIGNvbXBpbGVkIGxhdGVy
LCBzaG91bGQgdGhlIHR5cGVpZCBpcyBjb21wdXRlZCBhdCB0aGUgZGVjbGFyYXRpb24gb3IgdGhl
IGRlZmluaXRpb24/IA0KDQo+IFRoaXMNCj4gaXMgaG93IExpbnV4IGNvbnN0cnVjdHMgaXRzIGFz
c2VtYmx5IGZ1bmN0aW9uIGVudHJ5IHBvaW50czoNCj4gDQo+ICNpZm5kZWYgX19DRklfVFlQRQ0K
PiAjZGVmaW5lIF9fQ0ZJX1RZUEUobmFtZSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCj4gICAgICAgIC40Ynl0ZSBfX2tjZmlfdHlwZWlkXyMjbmFtZQ0KPiAjZW5kaWYNCj4gDQo+
ICNkZWZpbmUgU1lNX1RZUEVEX0VOVFJZKG5hbWUsIGxpbmthZ2UsIGFsaWduLi4uKSAgICAgICAg
XA0KPiAgICAgICAgbGlua2FnZShuYW1lKSBBU01fTkwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXA0KPiAgICAgICAgYWxpZ24gQVNNX05MICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiAgICAgICAgX19DRklfVFlQRShuYW1lKSBBU01fTkwgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KPiAgICAgICAgbmFtZToNCj4gDQo+IFRoYXQgd2F5IGFsbCB0aGUgYXNtIGZ1
bmN0aW9ucyBjYW4gYmUgYmUgaW5kaXJlY3QgY2FsbCB0YXJnZXRzIHdpdGhvdXQNCj4ga25vd2lu
ZyB0aGUgaGFzaCB2YWx1ZSAod2hpY2ggd2lsbCBiZSBmaWxsZWQgaW4gYXQgbGluayB0aW1lKS4N
Cg0KT2theS4gSSBzZWUuICBUaGlzIGlzIHRoZSBjYXNlIGZvciB0aGUgZXh0ZXJuIGZ1bmN0aW9u
IHdob3NlIGRlZmluaXRpb24gaXMgaW4gdGhlIGFzc2VtYmx5IGZpbGUuIChOb3QgYXZhaWxhYmxl
IGluDQp0aGUgQyBjb2RlKQ0KDQo+IA0KPj4+IEF0IGluZGlyZWN0IGNhbGwgc2l0ZXMgKGR1cmlu
ZyB0aGUgZWFybHkgR0lNUExFIHBhc3MpLCBJIGhhZCBhDQo+Pj4gRlVOQ1RJT05fVFlQRSBhdmFp
bGFibGUgdGhhdCBzdGlsbCBoYWQgdGhlIGZ1bGwgdHlwZWRlZiBpbmZvcm1hdGlvbiwNCj4+PiBh
bmQgSSBjb3VsZCB1c2UgaXQgZmluZS4NCj4+IA0KPj4+IEZvciB0aGUgb3RoZXIgdHdvLCBpdCdz
IGxhdGVyIG9uIGFuZCB0aGUNCj4+PiBUUkVFX1RZUEUoZm5kZWNsKSdzIEZVTkNUSU9OX1RZUEUg
aGFkIGxvc3QgdGhlIHR5cGVkZWYgaW5mb3JtYXRpb24gKHdoaWNoDQo+Pj4gSSBuZWVkIHRvIGJl
IGFibGUgdG8gZXhhbWluZSBpbiBjYXNlcyB3aGVyZSB0aGUgdHlwZWRlZiBuYW1lIHdhcyBuZWVk
ZWQNCj4+PiBmb3IgdGhlIG1hbmdsaW5nIHZzIGxvb2tpbmcgYXQgdGhlIHVuZGVybHlpbmcgdHlw
ZXMpLg0KPj4gDQo+PiBUaGVuIHdoeSBub3QgYWxzbyBjb21wdXRlIHRoZSB0eXBlaWQgZm9yIHRo
ZSBmdW5jdGlvbiBwcmVhbWJsZSBkdXJpbmcgZWFybHkgR0lNUExFIHBoYXNlIA0KPj4gdGhlIHNh
bWUgYXMgdGhlIGluZGlyZWN0IGNhbGwgc2l0ZXMgd2hlbiBhbGwgdGhlIHR5cGVkZWYgaW5mb3Jt
YXRpb24gaXMgYXZhaWxhYmxlPw0KPiANCj4gSSBhc3N1bWUgSSBqdXN0IGRpZG4ndCBzZWUgaG93
IHlldC4gOikgSSB3YXNuJ3QgYWJsZSB0byBpZGVudGlmeSBub3INCj4gc3RvcmUgdGhlIHR5cGVp
ZCBmb3IgZnVuY3Rpb24gZGVmaW5pdGlvbnMgdGhhdCB1bHRpbWF0ZWx5IGVuZCB1cCBnZXR0aW5n
DQo+IC5zIGZpbGUgb3V0cHV0Lg0KU28sIHRoZSBwcm9ibGVtIG9ubHkgZXhpc3RzIGZvciB0aGUg
ZXh0ZXJuYWwgZnVuY3Rpb25zIHdob3NlIGRlZmluaXRpb24gaXMgTk9UIGluIHRoZSBDIGNvZGU/
IA0KDQpRaW5nDQoNCg0KPiBGb3IgZXhhbXBsZSwgZG93biBpbiBpeDg2X2FzbV9vdXRwdXRfZnVu
Y3Rpb25fbGFiZWwoKSwNCj4gSSBoYXZlIHRoZSBkZWNsIChidXQgaXQncyB3YXkgbGF0ZSk6DQo+
IA0KPiBpeDg2X2FzbV9vdXRwdXRfZnVuY3Rpb25fbGFiZWwgKEZJTEUgKm91dF9maWxlLCBjb25z
dCBjaGFyICpmbmFtZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRyZWUgZGVj
bCkNCj4gDQo+IEkgY291bGRuJ3QgZmlndXJlIG91dCBob3cgdG8gZmluZCB0aGVzZSBkdXJpbmcg
dGhlIEdJTVBMRSBwYXNzLiBPaCwNCj4gcGVyaGFwcyBJIGNhbiBkbyB0aGlzIHdpdGggYW4gSVBB
IHBhc3M/IFRoYXQgc2hvdWxkIGxldCBtZSB3YWxrIGFsbA0KPiBmdW5jdGlvbnMgaW5jbHVkaW5n
IGV4dGVybnMuIEknbGwgZ2l2ZSBpdCBhIHRyeS4uLg0KPiANCj4gLS0gDQo+IEtlZXMgQ29vaw0K
DQo=
