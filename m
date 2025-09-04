Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C01EEA54
	for <linux-hardening@vger.kernel.org>; Thu,  4 Sep 2025 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996928; cv=fail; b=swgJl3mdrDmScpZnxg4ToM4gZfRnbY2Wtw7ZpZhklTwr69JJ9NkMqX/E2VgipUFPd7fuz6nYAjTS5GNqRTZll+0d7bzB1cwXve5U7E7i1YZoiU7nQBdiha/x6hIigGm6HKfWhOKeA9DK3mNmZ4w8yga/qLIgHtxbAn6FmoVz8yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996928; c=relaxed/simple;
	bh=t05m1/X8iBsLAqpQ0r6VAHkJNTs51wy2IKhMDh9g/1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B0kxv5DYV2ItvXvyOC1H9CG56dRFkKFluQtuakwM85hX8hB51rPINAPV1mbPyuA5J0LcxkZ177+0wjH2uZaP55wZIKXena9RZGTA95Oy1m5K4QJAa9JTRDY658joyZdKCVtKGOCBpV637mKdzxPbF723BeJ5BA/CnPAW8ZB68t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZjziNB5g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qm2uNuTC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZjziNB5g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qm2uNuTC"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584EA1Yd019767;
	Thu, 4 Sep 2025 14:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t05m1/X8iBsLAqpQ0r6VAHkJNTs51wy2IKhMDh9g/1Y=; b=
	ZjziNB5g3MJsL58Ni6fXdhg0pTwLmj6oEUXQeJMttwCx83gKyPvvZqm48jeYWQ8Z
	IWpUF7JlhTBeQ36mehwrNKP3efvrxVQendnikcONR+syqtE4giElnTo+cFNzLmRh
	RkWJujdSgjaxOq0HtL+qCATJvNd5SEfikSYfY3ga59FO3ZCkP4+Nmcl4UgdQV6b9
	N5poyKtiMITig8Z3VQSdWR6egjJE6Ileqq05viF/OUX0fzHBN8V1cYQLc9l766mF
	CH1aaThuTC9AXkksTX+l/cx0a8Au8wde6RuvlJ4UCFLH7fQSorr2SQ93mMe+kyxv
	u/VEXaUuCiEFF6QqUs0x5A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yc9pr2v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:41:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584E5BVp031139;
	Thu, 4 Sep 2025 14:41:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbrkv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4NIF/OIvw8clkg4JEqaw8lxzkq6MjnqgdXqkDyh9ztVOIAHZQcOHlAespRPv6kBrm1XHOB14v3Qwyr+6Tfe4Ox8M6IwCWGhk+EuUsCybxt4IQNYrsQ8NtB9YwqaQZ+ZyKdvgtAa05e5Teh2qHjsPE4ePJlIWEkdvabNYP1hwvCuSke71ajXeb/cZVYIVBxq6OcmO7DoB3W116N9ldVdxCnblbuxPZkiwCx2xrjmOsl4BNLkfLeSnCl57vS3zkkhxxLalPzhjRPOwULdzl+fpDL/JlN9oUhtwwTGUUi2b/2NKsvcdBRFMmUMVGb1V/XxbDCiXxBSzkeGA9syWA+3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t05m1/X8iBsLAqpQ0r6VAHkJNTs51wy2IKhMDh9g/1Y=;
 b=hHnMumn//3O+LuUhgnE+VS5d3hl/wSZErRpRijsqL2+oJJFz7d1C6PQvqmk7frz/1t7CnuAuS79ufMUznuTtl+USiDqEVAqxhgGctNl+Ecmk5OZpiv3uS8HcWIz1Hy1ZJNx2ziRULfdOyYyGfwwzntbKG9QnUdGidP22bqt5daVGL1eaumc1vpk9xUV8lCiQpnp2QCgS3q6zhzoJmKJvXWrRzcf4Ai1rGgz5VsP+DgFCbhgcgxYm2x3CbtFYZOe+QAMfftXZA0XI28vCbjr8Sl8HiZsHSAr5SpCzvVkQoWq6zFdzEcPNo/L924Z8QiDTibKdJnLn+nPpD+UjSxq5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t05m1/X8iBsLAqpQ0r6VAHkJNTs51wy2IKhMDh9g/1Y=;
 b=Qm2uNuTCgt6UTxdhX4/J+sLIlkXvdmE0QQuxbWX6Qh7P7p2LFpm3f0vbS8nt1zKA82UcDzhAyJ99u6+KqXwnvEPfFvjzbsklGGmdjy8Q7eNHpoMhxZw0C0lzEaLgSB+3QnLd+9uQ6ftHg7mg4V0/oP1Z/PyrC7zO66OCCU8hJVE=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by SJ2PR10MB7040.namprd10.prod.outlook.com (2603:10b6:a03:4c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:41:40 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 14:41:40 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>
CC: "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        Joseph Myers
	<josmyers@redhat.com>,
        Richard Biener <rguenther@suse.de>, Jan Hubicka
	<hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard
 Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft
	<marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito
 Cheng <kito.cheng@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew
 Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Peter
 Zijlstra <peterz@infradead.org>,
        Dan Li <ashimida.1990@gmail.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Topic: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Index: AQHcEm0Edhok5jEwKk+4kHDo0FX/JbR4MyIAgApPlwCAAKxtAA==
Date: Thu, 4 Sep 2025 14:41:40 +0000
Message-ID: <2D8786B0-EB76-456F-B0AE-0FF9D8862C55@oracle.com>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <84E03295-212C-4A89-8F8E-C5B1BA74C7EB@oracle.com>
 <202509032057.34FA2F6AEC@keescook>
In-Reply-To: <202509032057.34FA2F6AEC@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|SJ2PR10MB7040:EE_
x-ms-office365-filtering-correlation-id: 2739ee43-e87b-47d5-4935-08ddebc128ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1Q1ZXhTcXRzR2xlMkx6OVBmcHJsbVlsUEVEOFd3QVp5VDR2cUY2aUJPdVN3?=
 =?utf-8?B?VkFubHhCZjZMNDJEM0llNHFmanFwaWdQUEplckpHYmNNMG9yUXg2MkxGdjJi?=
 =?utf-8?B?TStWMUE2akYrd01HZGcwMVVzV0ZpcHpuNURlcVAwVDlxNXpWVmY1UjN0R2k0?=
 =?utf-8?B?dTdwZ0RNdmpBbDlSOTg4M01Sa1ltcmNkZk0zODl1M1FBRCtBdHZESFJqUnEv?=
 =?utf-8?B?d3U3aG5tbVFmU0lia0trNU5zbmhQbzVlTzZ0THlXd0VpUjNIb0VMbVpsbFBy?=
 =?utf-8?B?SU9xM1VDS1NWQ1o2YnVnYjRBeFlmdCtwbkdZQTNsN1ErOTZwSk5TRGljVG9C?=
 =?utf-8?B?Q2RyUndMZjVVMmtocDI2NStmTzUvWWNNWWtadWIzZkpETmRBUWNmMUYxaHJZ?=
 =?utf-8?B?dHRKWTBsQzJZeHdlVXBJUDlsUW83YXNkL3RiQkNXVnlzT1RMN2o4SVhNRExn?=
 =?utf-8?B?c0VVaUlDa1VMc2VJR29aYnJIQjNJbXY1UFVBeUFybCszRmJpRWU1ZS9MNlAr?=
 =?utf-8?B?b2tRc21zcUVXRU42Vnl2c1pUNitsV0l0MFFoYWNnVUZEbnQrQ0FpcVM3V29l?=
 =?utf-8?B?aDN1WDFidGFDNlRTanhqNCtuQWVpWVl2NDlSanFJenlQNDVWQSs0cmJKeHJj?=
 =?utf-8?B?NkliWG5TTlZoMGVNSU5ISktqUUZIejdFTWowUWJ4bFBucHd0cVB1NjVoa3lC?=
 =?utf-8?B?OEl2bmNFa1RhNGZlaHVINDNWamEwSmp5Z3NyclZaZFREUTdnTDBrRkE3TlNX?=
 =?utf-8?B?bFNWWlNtTUZRUXNYVVZ5alV3VEVyMEtkSkV6dGNlUHZtRTNPOE9zOHJrTFFL?=
 =?utf-8?B?UFVyS2Q5ZDVEOTUvak1YQU9XTU9UR1pUZUNrb3A4Q3R4bWJzdkUzNjVTZ2FJ?=
 =?utf-8?B?M0dyeERZMkU2QTlPYkN3cEpTVGdYOCtIWFdHNjlKQVhzd0lmcy95d1FZbnNL?=
 =?utf-8?B?WlBuSnZoTVFTZ1pNRWU2Tlc2aTkyMEdNZHZoZjNJWHN5TzdqZXNsenYzUFJu?=
 =?utf-8?B?angwS0lHRytUanh4SGtCNmY3MFk5citaeDdIRFA0d0puM1ZFNDlDcWFWRGxj?=
 =?utf-8?B?SEx3SXIxRWhYS1VSNkdzOHkwVUEwYXp6T2FlcHVZNm0wOG56aXRkT3pEL21o?=
 =?utf-8?B?WHVyRHFhaDkxVUY5QVN2N0taUU9rU3ZTc0VqMmNCSW5TSElOUjRScWppQU5i?=
 =?utf-8?B?SHhpNlFBOU0ySXR4V2dBeHplUEswaUpBU3p2cGdqc3ZFeG8yQzRDaCtmdUov?=
 =?utf-8?B?Z3hnQ1FXYnNVU29iMXcvS1YxNnVEKzF5ZFlFNWVGbSs3ZWd0Mm5YRWpiYlBs?=
 =?utf-8?B?R1RiZDM3VzNZY2c5ZmowUWtIMXZTN2tFam0vOFV2SmJNQ0Fza0VIM29uMTVi?=
 =?utf-8?B?U3BDZTZtcTJaSkQzem1XYXJ1RFZ2Z2pLQzlHdDZUL2tqdXRQWU1PeFYrNTBH?=
 =?utf-8?B?N0R2a3duRzBjaFVRRlhtc0JrVEJHek02Y2ZiZmw0dUxISnFwMUNHUHZzY1VY?=
 =?utf-8?B?ZDVpc2RZSjRES3dMMTlGam9EYlE1dmp1cm00Q3lVYjBxYVBpaEJ3S1lTMHFm?=
 =?utf-8?B?OUFSOHVtRG00eUdndVBrTkdFQmZmWmFyMWgxL1JKV1RTRmNSNENwc2RWZDBF?=
 =?utf-8?B?cGdDT0dEeGVzSlpqZHcvTThqdjM4ZTRvbTlnZ2JNaXV1WFdpSHk3eEhZT3pO?=
 =?utf-8?B?UHZsS2QySTFTajAveTNTdUgybnpKMDVOSG9PanVZYkQ5cFdzTEQwTXhOR2ZO?=
 =?utf-8?B?U0RYRTRsaUxrODRZQmR3akZoZUNXR3h3L0lLcTdTbmdMR0E0L0JSbThmc2lP?=
 =?utf-8?B?SHJHTmxsaXZmcnR1T3pEa0tlWTQ0eTlTM2N6ZzBEbVNhMnJWbTg1dWdtZG9Q?=
 =?utf-8?B?QnhOcEhRT3MrNHR3YmE2aUdhTCthbzVpWlc1K3RaMHFQMW5LKzNtcTZpeDJz?=
 =?utf-8?B?OGdNM0s0V1FxOTVOdVY3OXh4RHBqS1pkWStUcTVKYk41QWowL3dOdUdTWXc4?=
 =?utf-8?Q?tgYWuh5UDDgzd9oaWNsnfxaplO0MwU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0pmeXRHcGVEV08veTFrbHZ6elJpNDFmMXlCKzZDRWp2cUZLT1ZPamI4eDR4?=
 =?utf-8?B?VUgxdzNHdjNTa0tvTFM1cE9FZHRqM2VUUVZ6V2JsTmpQd3c0RDdyKy90VWhv?=
 =?utf-8?B?TEpIVkpJMkpWdnUxajE5TFFVaFZjalhwSi9aRi9DWXB1MXpTb2hPaWN5ZE9Y?=
 =?utf-8?B?VWYwck8yUUJULzFLVSt1ejBuR1BFSERid3U4U2treXZHZHJaOU8yTDUxNmFS?=
 =?utf-8?B?dWltWXlIQ0htS0VNSkN3V0o0ZHp2aDFaNU9mTG0wQVFWTUJFUUZ6cTNuUDZw?=
 =?utf-8?B?K1dSTmdhcER6Skw0NlBsTnpXTVg4bVdlYTM4ZEZRc0ZzNVhWOEZydFZ1WlJ1?=
 =?utf-8?B?emlnakFVMmxMVkptQnR2L0h3bU1qQlJzeW1BdHlTdW9PZDdDU01qRW9IbDFY?=
 =?utf-8?B?UWlYNmZEcFNpUHk1UUZZUmJxME1MUmsrWllJb0ZOc1RmSE1UTk5QSy9aaDNY?=
 =?utf-8?B?RjZneDJOVlVOZTdWM0RPNVFyRHp1dGlPWjQ4aXc4MklyOEVJVHFYdk1PZFlw?=
 =?utf-8?B?NHpDUGNFRXEvZGErTVNTRjVQRnAzUXptWE9KTEIyK1d5aE5SY3J6YkdZYkd5?=
 =?utf-8?B?dGdESGMrYTZtWUVoLzNDRWNSNnBlOEhxQUFvaUZIcDFGaHYwSTRSL3BNTXBI?=
 =?utf-8?B?TFdoYkEzQUU4SEdMTGJLSWNxSnBjUVJ1U0ZxbUdWZXpUdTQ4azhvdzVpdFVH?=
 =?utf-8?B?MmlkVWhXdm53NUQ5TEpTR3ZHU0gxVUZ0S1JheENsVDNrZHdDdDlKTU1Kb3Z5?=
 =?utf-8?B?NFRhOGlSRk8yNkhnV0Qyb203dWUzSEVteXh6Z1hmWWRvdCtDSEdnUlIzd0pJ?=
 =?utf-8?B?UWR2Z2ozbTlUdm1HUWdRTGdkSFA5QW9nSEJDWjRBblpvUXJsd1dqWVRpelJP?=
 =?utf-8?B?UHZYSDVnUnZGeWM4bS81dkh4Z2pYb1pUT1B4SERqUFdIdGRLZVNpN2ZkeTc2?=
 =?utf-8?B?Q3dTWlJSa0J1d3BiQ25OUXFldTltTkJnUUlNRlp3S25PZjh2U1FJZDRiRG5K?=
 =?utf-8?B?YXdOS1JldHgrcDFnaWFNVDIyTXJKcUN5MUlGK24vMVp1cmlpeVFHOGJJeVNS?=
 =?utf-8?B?d1JTNVpkT1l5ajhBeWZNNVcyVk9kODdHSllPRXRqWmpUR2pXSzByT1gweU5I?=
 =?utf-8?B?dUlURXdzRkRrODRFL3dSclZYK3ZucFR5L3dvZzJqaVVGdE1OMzIwZ09pOU9M?=
 =?utf-8?B?SHZBaUdYemltOTJQMjRGMW4xekFWazcxc3NJZGEzOEJvc0wxNjcxZzdUa1Jx?=
 =?utf-8?B?QnJNYjhDOE5KTDU2bUZWckJkRnF6bUlrVlFLUVB4elVWU09ZeGNFVkRtaG8w?=
 =?utf-8?B?RWJVdHdhRy9kaGZGSjZCcVU4QWdsRHo2QlgrcXVqcGFpN29DcHE5VXk4Sm54?=
 =?utf-8?B?bEtka0FCQzJWUFg3ZTJhVU8zbTZLRjg5b1RCOTJRMm1vZXdtWDBQcW5TelV3?=
 =?utf-8?B?clEzY3gxT1h5eElYeG1wK1NyZ05nWDR3SFdMM2JJSnRoUmNVcmRodVBFUExE?=
 =?utf-8?B?VnJURTVEZGhCWUd0M05ORmxsSU5mUTE2aXhiVDlHN2tudzlhTXQxTy94WlIy?=
 =?utf-8?B?SGJSbklMVXdNajBYcWFiWUdRSCtpSUh4ZmY4am44aW9YdCtPRDk2TUViQjlQ?=
 =?utf-8?B?cHJqcmZOT0lWNEVRTDBQOFJxbVVCRExGbjFFUlVsWjhLbEVldmNNbGE3NWpS?=
 =?utf-8?B?WUVIQ3kwaXJYTmp6eTRTTXVWeWZuNjltWWZSNG1LdDllYVNyL0dWYy8wUDJX?=
 =?utf-8?B?NW9aZkhtdk5KdnEyTjFDVUx1ZFJSUjJmTnRLS0Rhc0FrVWxoNVM0VzdkUFFV?=
 =?utf-8?B?Q25VaTUxWUY4ZWwrQWN3VUxiVWtLSWVjdEVYRHh4SFlGa29tVlVSK0k5REN3?=
 =?utf-8?B?TUFHYjhWVUQ1Y2FoNzIrWmZ3MFhxUVV0SHhnL2JqUFg3M0pJMUw3dWhDaGli?=
 =?utf-8?B?Rmt1N3VvZ09vQ204SUU3bFFXU1hpNGVGYkliWVg2WHNJdWthTm5rZ3UrWjJS?=
 =?utf-8?B?bm5sUTVMekljMEJxeVdpUVJkOHFVRDZocDRjdUNLS0hhSStBVElMNjY0dzZp?=
 =?utf-8?B?eHl2VzFENTlzKzliY0pvSHdVL05Pb2RCZkZIcjFNbGJpTC9IUCtvTVpPMFoy?=
 =?utf-8?Q?f3pAo9NoX5kt9gO8tN8MZcDJl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92D216BEA8EE0D4E84103E67801F56A1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m8ZHK+UIU1k09sH2ljbnd7q54zIQv3JCvPJ57uhzOFyWTvv0entwl+sUFalO9AKdVtxNJVdiVwbHp2EboDcZd1sfen1fALvg7edrc+Y9jDwQ5tM1MrJMQfdMiFRidPzkLHcBEKmQlH2WN74j5RHxY1CodelANHkqBZRn8Iyl7oArASOec3VycaOS8SLorV/tRmxp40zhbpfcMy1NDZ2LWkNuf3ZNJgW3XssEAT6xfWLhfqZf+Q5efBcssnftC/Ec4ptV8znviOaBe5YEuevSkiJNjdfSJtnr+jiQoYpn8r+vM76uyf3h04e3wl0YsRV5qd0QGNeQSicKq7H+qUTX4VM/00bCBaNttF223h+A8m8usDiwzrXgWZQaEG/3Fv1/RRC+TPeGbgOpD6KR0br5FFg6rnncZTE6w+MAQNAaFYbN+VjaWYBZZfXvsyqY5mh3htCN5ELoSGBbG5cJH2uB9c0OEezng5BdmdMPK3norMkrFiUYATJ7w1WLuCGZKfVvoSU12nVz9LXz2ZfhAJ0r30y92T8Rhg7QwmKMXc/tCU6meLauvYg3YbBxwLdDQ0rbihgxsvXuGmGZsEVr/XM7WSV9cT/CwWeHuOtWQXfPXT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2739ee43-e87b-47d5-4935-08ddebc128ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 14:41:40.4174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcMxtdpMIVkROcNCObyKY4/9k98lE/j471Z9ID2OhOq3pVHEIzl3EPji0kQGS/MswgxxllTlLhdxgbYeVPb6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040145
X-Proofpoint-GUID: NykUvSzChf59wrifEVZDztn93ESkzO2J
X-Authority-Analysis: v=2.4 cv=DPeP4zNb c=1 sm=1 tr=0 ts=68b9a528 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=UijKE4U-UbcoCd0-igwA:9 a=QEXdDO2ut3YA:10
 a=Bnj77vyxr-wA:10 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: NykUvSzChf59wrifEVZDztn93ESkzO2J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE0MCBTYWx0ZWRfXw4/5n85ugt41
 gfLH4R/mPEWYGYGOkCOkXQ/VOLwmoas4UzWjIjOhb7w6HOyTULt7Lvuv24BSihpklPqiw4DaSTa
 i0KdgXsVuz/tT4qgPl8PxjSck1pkkarf+qGp4P9QZvsQG1196UZWTKwT1UhQL4p1SYs+rQWCxa8
 TDJQurZC+WcuH+vVxJFqsHdrdP6o6uKfhpD4PJRxNkv/QB8k20r03Jl9cNR/gSxq5Lypw8IpxoE
 tAeDBcb48U7Ddxeg0nrEr0l+Ag87aWvtkNsgZt01n2Nb6tNwku6k9xyBWEAgROSLuXhqnVZAIeh
 O+oUwRKFe1KJipk9BwUyyH3BxtAsCZQWKURknKpSUAa6bPqVNgldGVCIHUNmaw2Lah23K9oJnDl
 icQsfRcngpimVRKSkyNemrLQWjxZ3Q==

DQoNCj4gT24gU2VwIDQsIDIwMjUsIGF0IDAwOjI0LCBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+IA0KPj4gQXQgdGhlIHNhbWUgdGltZSwgQSB3cmFwcGVyIHR5cGUgaXMgY3Jl
YXRlZCBmb3IgdGhlIG9yaWdpbmFsIGZ1bmN0aW9uIHR5cGUsIHdob3NlIHR5cGVuYW1lIGlzIA0K
Pj4g4oCcX19rY2ZpX3dyYXBwZXJfdHlwZV9pZOKAnS4NCj4+IA0KPj4gSSBhbSBjb25mdXNlZDoN
Cj4+IA0KPj4gMS4gV2h5IHRoZSBhZGRpdGlvbmFsIHdyYXBwZXIgdHlwZSBpcyBuZWVkZWQ/ICB3
aHkgdGhlIG9yaWdpbmFsIGZ1bmN0aW9uIHR5cGUgKyDigJxrY2ZpX3R5cGVfaWTigJ0gbm90IGVu
b3VnaD8NCj4gDQo+IFRoaXMgd2FzIGNyZWF0ZWQgdG8ga2VlcCBjYWxscyBzb21lIGJlaW5nIGNv
bWJpbmVkIGR1cmluZyBvcHRpbWl6YXRpb24uDQo+IGUuZy46DQo+IA0KPiBpZiAoZnVuYzEpIHsN
Cj4gZnVuYzEoKTsNCj4gcmV0dXJuOw0KPiB9DQo+IGlmIChmdW5jMikgew0KPiBmdW5jMigpOw0K
PiByZXR1cm47DQo+IH0NCj4gDQo+IHRoaXMgd2FzIGdldHRpbmcgY29uc3RydWN0ZWQgYXM6DQo+
IA0KPiBpZiAoZnVuYzEpIHsNCj4gcHRyID0gZnVuYzE7DQo+IGRvX2NhbGw6DQo+IGNhbGwgcHRy
Ow0KPiByZXR1cm47DQo+IH0NCj4gaWYgKGZ1bmMyKSB7DQo+IHB0ciA9IGZ1bmMyOw0KPiBnb3Rv
IGRvX2NhbGw7DQo+IH0NCj4gDQo+IFRoZSBhYm92ZSBpcyBub3JtYWxseSB0b3RhbGx5IGZpbmUg
YmVjYXVzZSBvbmx5IGFkZHJlc3MgIm1hdHRlcnMiLCBidXQNCj4gaW4gdGhlIENGSSB3b3JsZCwg
dGhlIHR5cGVpZCBpcyBhIHBhcnQgb2YgdGhlIGNhbGwuIElmIGZ1bmMxIGFuZA0KPiBmdW5jMiBk
b24ndCBzaGFyZSB0aGUgc2FtZSB0eXBlaWQsIHN1ZGRlbmx5IHRoZSAiZ290byBkb19jYWxsIiBj
YWxsIHBhdGgNCj4gd2lsbCBmYWlsIGJlY2F1c2UgdGhlIGNhbGwgKHRoYXQgY2hlY2tzIHRoZSBm
dW5jMSB0eXBlaWQpIHdpbGwgdHJpZ2dlciBhDQo+IG1pc21hdGNoIHduZSBmdW5jMiB0cmllcyB0
byBiZSBjYWxsZWQgdGhyb3VnaCB0aGUgZnVuYzEtdHlwZWlkLWNhbGwuDQoNCklmIHRoZSBuZXcg
4oCcd3JhcHBlciB0eXBl4oCdIGlzIG9ubHkgdXNlZCB0byBhdm9pZCB0aGUgYWJvdmUgdHJhbnNm
b3JtYXRpb24sIHRoZW4gDQpvcmlnaW5hbCBmdW5jdGlvbiB0eXBlICsga2NmaV90eXBlX2lkIHNo
b3VsZCBiZSBlbm91Z2ggdG8gYXZvaWQgc3VjaCBtZXJnaW5nLCANCk5vIG5lZWQgdG8gY3JlYXRl
IGEgbmV3IHdyYXBwZXIgdHlwZSB3aXRoIHRoZSBleGFjdGx5IHNhbWUgaW5mb3JtYXRpb24gZW1i
ZWRkZWQuDQoNCkRvIEkgc3RpbGwgbWlzcyBhbnl0aGluZyBvYnZpb3VzPyANCj4+IA0KPj4+IA0K
Pj4+IEZvciBpbmRpcmVjdCBjYWxsIHRhcmdldHM6DQo+Pj4gDQo+Pj4gLSBrY2ZpX2VtaXRfcHJl
YW1ibGVfaWZfbmVlZGVkKCkgdXNlcyBmdW5jdGlvbl9uZWVkc19rY2ZpX3ByZWFtYmxlKCksDQo+
Pj4gYW5kIGNvdW50ZXIgaGVscGVycywgdG8gZW1pdCB0aGUgcHJlYWJsZW0sIHdpdGggcGF0Y2hh
YmxlIGZ1bmN0aW9uDQo+Pj4gZW50cnkgTk9Qcy4gVGhpcyBnZXRzIHVzZWQgYm90aCBpbiBkZWZh
dWx0X3ByaW50X3BhdGNoYWJsZV9mdW5jdGlvbl9lbnRyeSgpDQo+Pj4gYW5kIHRoZSBwZXItYXJj
aCBwYXRoLg0KPj4gDQo+PiBJIHNhdyB0aGF0IOKAnGtjZmlfZW1pdF9wcmVhbWJsZV9pZl9uZWVk
ZWTigJ0gaXMgY2FsbGVkIGJ5IOKAnGRlZmF1bHRfcHJpbnRfcGF0Y2hhYmxlX2Z1bmN0aW9uX2Vu
dHJ54oCdLA0KPj4gQnV0IEkgZGlkbuKAmXQgc2VlIHdoZXJlIGl0IGlzIGNhbGxlZCB3aGVuIHRo
ZSBmdW5jdGlvbiBpcyBub3QgcGF0Y2hhYmxlPw0KPiANCj4gVGhlc2Ugd2VyZSBpbiB0aGUgcGVy
LWFyY2ggZnVuY3Rpb24gbGFiZWwgZW1pc3Npb24sIGJ1dCBmb3IgdjIgSSd2ZQ0KPiBtb3ZlZCB0
aGVtIG91dCBhZnRlciByZWZhY3RvcmluZyBob3cgdGhlIHBhdGNoYWJsZSBmdW5jdGlvbiBlbnRy
eQ0KPiBpbnRlZ3JhdGlvbiB3b3Jrcy4NCj4gDQpZZWFoLCBJIHNhdyB0aGVtIHdoZW4gSSByZWFk
IHRoZSBwYXRjaGVzIGZvciB0aGUgYmFja2VuZHMuIC06KQ0KPj4+IA0KPj4+IC0gZ2V0X2Z1bmN0
aW9uX2tjZmlfdHlwZV9pZCgpIGdlbmVyYXRlcyB0aGUgMzItYml0IGhhc2ggdmFsdWUsIHVzaW5n
DQo+Pj4gY29tcHV0ZV9rY2ZpX3R5cGVfaWQoKSBhbmQga2NmaV9oYXNoX3N0cmluZygpIHRvIGhv
b2sgdG8gdGhlIG1hbmdsaW5nDQo+Pj4gQVBJLiBUaGUgaGFzaCBpcyBGTlYtMWEgcmlnaHQgbm93
OiBpdCBkb2Vzbid0IG5lZWQgc2VjcmVjeS4gSXQgY291bGQgYmUNCj4+PiByZXBsYWNlZCB3aXRo
IGFueSBoYXNoLCB0aG91Z2ggdGhlIGhhc2ggd2lsbCBuZWVkIHRvIGJlIGNvb3JkaW5hdGVkDQo+
Pj4gd2l0aCBSdXN0LCB3aGljaCBpbXBsZW1lbnRzIHRoZSBLQ0ZJIEFCSSBhcyB3ZWxsLg0KPj4g
DQo+PiBPbmUgcXVlc3Rpb24gaGVyZSwgdGhlIGZpbmFsIHR5cGVfaWQgd2lsbCBiZSBjb21wdXRl
ZCBieSB0aGUgZm9sbG93aW5nIDIgc3RlcHM6DQo+PiANCj4+IDEuIEl0YW5pdW0gQysrIG1hbmds
aW5nIGJhc2VkIG9uIHJldHVybiB0eXBlICsgcGFyYW1ldGVyIHR5cGVzIG9mIHRoZSBmdW5jdGlv
bi4gDQo+PiAyLiBGTlYtMWEgaGFzaCBvbiB0aGUgbWFuZ2xlZCBzdHJpbmcNCj4+IA0KPj4gSWYg
dGhlIGhhY2tlciBrbm93cyB0aGVzZSwgaXQgc2hvdWxkIGJlIHF1aXRlIGVhc3kgZm9yIHRoZW0g
dG8gY29tZSB1cCB3aXRoIGENCj4+IG1hdGNoZWQgdHlwZWlkLCBpcyBpdD8gDQo+IA0KPiBUaGUg
aGFzaGVzIGFyZW4ndCBjb25zaWRlcmVkIHNlY3JldCAtLSB0aGV5IG5lZWQgdG8gYmUga25vd24v
bWF0Y2ggYmV0d2Vlbg0KPiBjb21waWxhdGlvbiB1bml0cywgYW5kIGV2ZW4gYWNyb3NzIGxhbmd1
YWdlcyAoUnVzdCkuIFRoZSBLQ0ZJIG1pdGlnYXRpb24NCj4gaXMgZnVuZGFtZW50YWxseSBhbiAi
ZXhwbG9pdCBzdXJmYWNlIHJlZHVjdGlvbiIgbWVhc3VyZSBpbiB0aGUgc2Vuc2UNCj4gdGhhdCBp
dCBsaW1pdHMgYW4gYXR0YWNrZXIncyBzZXQgb2YgY2FsbGFibGUgZnVuY3Rpb25zIHRvIG9ubHkg
bWF0Y2hpbmcNCj4gdHlwZWlkcyAoaW5zdGVhZCBvZiBhbGwgZnVuY3Rpb25zIG9yIGFsbCBleGVj
dXRhYmxlIG1lbW9yeSkuIEkgZGlzY3Vzcw0KPiB0aGlzIGEgYmlnIG1vcmUgaGVyZToNCj4gaHR0
cHM6Ly9nY2MuZ251Lm9yZy9waXBlcm1haWwvZ2NjLXBhdGNoZXMvMjAyNS1BdWd1c3QvNjkzMDU5
Lmh0bWwNCg0KVGhhbmtzIGZvciB0aGUgaW5mby4NCg0KUWluZy4NCg0KDQo=
