Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7F2877F5
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894586; cv=fail; b=VuSorWXp4Q7L4pZKsJawhGFYo6YHJReLSCpl/H1I/W0AGy04KpHtAjFzVWMnaAtTy+bQSjzCsEMVZsHmi42QFionDQuKAOUokYnvSZwi/UQxF72YBSn1JQuopTSyIFi/9oHVu/sAll9dqsobvWn2viwLYWWUaCsbC94TA256aTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894586; c=relaxed/simple;
	bh=EpUAxqtYN7pF8TsVoudoQVh7LcVVgcu88E8kYMTlXmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uhSaYmO77G5B0ed9BJemLmDhNWTD4i8MKY87VgTyaGpWtqYGGT4EAlOstWmz3b27bnWPUqSEeKufLYi3xmdqsGQeZ0rOcKONZQq3+MGiya5fk3Uoyhgx/VXnHji5eLBKuVWNtybxyNW+9g5gsn5AzjMLL4oItS3J9hXzjsQCwIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bVm/YkGz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=koSStCF+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bVm/YkGz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="koSStCF+"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MJBtpo032676;
	Fri, 22 Aug 2025 20:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=x6cs9T7IDXugLfxrSwyAEvLiIrbgHTYdohQmdPE6jek=; b=
	bVm/YkGz6Xcpw/XOImMF+1SEX7ACbWre1CpnPcrKjDvFi66I8LADgvZpnK3L505m
	XvwUKOhCrTdpUepSWo4I0wYkM0Ni4YrnBR885drdGLE0xlMBXI5tvIPUxRK1vZwP
	wz9UOJn3bW+p7QrBe6cH/QdAWhqgrOQaaG7pS3goxXqHlGDbecX1ovwYn8isgubj
	ezoPzAsa+Yu3H6U5aGUYyk09E50va7pDNO/We6s/702Ok0Bkq18LUuUlwBWdzPYF
	4oLqQT4mS9/Jx3zmjBKPIx2PhMeO/IofTg9T/c/jjgxzXtDIdrb5JbuDlsfC+28k
	IxFt0fMTRq1iuTZNAwT36w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pw1a0a33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 20:29:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57MJH9v1030293;
	Fri, 22 Aug 2025 20:29:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3x3s2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 20:29:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anPazyL/3MERaXSXuRItkYEs3NByPWIiogRw/AK8k5W5PZoKZn8d0vm9pZrNboeOG91ixi+XY3QveCIzy8uNqBJ+Z5EufDaJU3kF/XNEroiatVkeyRBtdset7JWxcpNMOsE81aMK1PPYG/t7ie60C1/M5h7QM2FcMeM6xEoxigUsmiSHrJj0iemScDiApv1LVvM24wYfprz3AD3HdCpEoJ6SHGY8kGu1KRYYdw16TdiFxxmOBJofsKy5ly0K1+FD528Uiwpbs9eesNUJxNiLVxa8yAdJ1NUkVO61KP9lFxH7037lpkxrsZd+21WLm1QIRgIwGtR+YFrTkKGtVxCRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6cs9T7IDXugLfxrSwyAEvLiIrbgHTYdohQmdPE6jek=;
 b=sC0Ble0wB3V9UVWvnEFLPJtwKe4DrfJx5bDm39fNvPqMef9BKZ0vI6k7tSX3yMeX9zEh8O0NN5IW3EqfZDGSWkqBLurUpEGgT4r8csgyJJ9UYlpeMUBc8ZcyeG+9oElO5ajSp4wCNvKYH5t6CSAQCmRFdPI+fPiDo4t+UtXr0v9aTfhmN3ioKavHW6njLx5Pw5Fy/KfAO2yVtKWQxRUKFkiJrIWTstE/VfKLV7xBAK0kHpqZgxPD62ve2j3PWi045SwMF3Myl1DDAdAg2132XK5cWY5OMpJTzNad0GYkttsIhX1jAnYuKMyNW9Jdr51Wdz8ywXY6150o8qftDLRNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6cs9T7IDXugLfxrSwyAEvLiIrbgHTYdohQmdPE6jek=;
 b=koSStCF+uLDM/+FjK4U2y150iUdaOC3bYL3XBKeOl9QN/Lj+hWZgW1xxj2Ax53k709kriJSGOgvx2/9zOinOaLGWz6jNTmQdlYjb/JQ/9FAiJnq+EnVOcO/oSat4fqPHN9kkZ0eMeZfWTG9YD/W01gJwdQ0HFc90tOc/pdgGe70=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by CO1PR10MB4530.namprd10.prod.outlook.com (2603:10b6:303:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 20:29:17 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47%4]) with mapi id 15.20.8964.019; Fri, 22 Aug 2025
 20:29:16 +0000
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
Thread-Index:
 AQHcEm0EGi+s8Q35f0a3asvZv7CnCLRsvhQAgACK1gCAADHTAIAAJaIAgAEovICAAECGgIAAGFOA
Date: Fri, 22 Aug 2025 20:29:16 +0000
Message-ID: <0F3CAA68-8C9E-49AC-8B12-95BE8E92475C@oracle.com>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
 <202508210841.8BE6E3C117@keescook>
 <E69330D6-1302-4BA1-BADD-8C91A096A1FD@oracle.com>
 <202508211258.8DEE293@keescook>
 <22C19D00-58D7-4854-915E-C7B8CDB3317E@oracle.com>
 <202508221149.F19A56772@keescook>
In-Reply-To: <202508221149.F19A56772@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|CO1PR10MB4530:EE_
x-ms-office365-filtering-correlation-id: 10e51282-3a23-4d94-8ab1-08dde1ba90d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yjz/V0DgXT3h9B2SDvuHG2KPVPfbx0B3l3//qChm8HUI1Xc1GyXCjpa8qUso?=
 =?us-ascii?Q?G+YmuGpoQ0pL1Q5U1iR2cyTdX2fI7K4D3Xhdm9F4GKUIekWp59xKH/LaveCH?=
 =?us-ascii?Q?JBVPb/9nGsk7m1Ly+qV+kUXb2hR//aPyodt4fAGLLxLJ5N8xDQOqu+loSy+q?=
 =?us-ascii?Q?urP5mwAw0jly6FnDXT4eHmjjnRrNtQuoI1nUvgv+S6KwtnOwG+2eV4YdpOn5?=
 =?us-ascii?Q?fUYhqFyENZB9rTz406+Hfg878S1CAY5im2evY6vwrUvRka7/VqV2hyfymYfG?=
 =?us-ascii?Q?u1rxQgLEFIVgeJHJlhCbtJ/3WhGdDp8XA0be8ptFFksgJfZZ4mynVs2ZJtDL?=
 =?us-ascii?Q?BIqnxCu7OLtoXUEyXlRaElNDC+e1EHTDwumlckPoLt07RKUn5FUpkhX5r8JW?=
 =?us-ascii?Q?PhhO338PFXcWdZStkRvk8Hg4UGUCJsWLkhcFnbCjtpbn19vXGre3VQnW/Z4Z?=
 =?us-ascii?Q?o1U7Ud6cREGjSNO5fPHEso1qVau2nLx2JsR29coO2W4SwcbOFdH+wEb1wbf3?=
 =?us-ascii?Q?LEc816QZj+ZYgOsOUBkBUr9vr9gSoUyw2L6Soj/pSA1T+rM9HYoiWjZF4Tjx?=
 =?us-ascii?Q?Zojccg/BeciEY2tNQpKhABrDZgKT+zH9LbShKvKQ6HIIpshu1gQtTEuzJsi7?=
 =?us-ascii?Q?qcIo+pkmGyh0GDgobiK6scEma8JOB9Pj04KqT7ws+lTRoDqHYQ7yRgrVm2kg?=
 =?us-ascii?Q?7qWaG9ttZ90//zPZ8/0u91zDcLClAmlMVoUUB5eJcA2JEZxwiHPJZfBuLLU4?=
 =?us-ascii?Q?dDr5NYf5AUFhWw+bwPNc39yHcVqY+OplahR5lcC4tainLQfQ+2bT5PqC528J?=
 =?us-ascii?Q?eoWTH47BTYoJy6tR287PamABrXVkEujqGAIEMkEQ5WDGOIr/0OptVuoVKa4b?=
 =?us-ascii?Q?KjwOyQ7MGBGM+KEKMZUojFdfPJ8mJ9uRanldVODiRC59kyVK9Cg/iSk5Dndk?=
 =?us-ascii?Q?aEc5zJMI/gzSU7/oWmRBQD6zjqMyuqYPylV8hS8AQLyuaTDN03b9fysFxx9A?=
 =?us-ascii?Q?QP6jZglsJhzalqFn8jMMEdRta2QlOXTV0y8QkwL1V6tkIDzmDKHXlPNbIU4O?=
 =?us-ascii?Q?Mu92xoiejPc/EjEwglB2AnFr7KkD0gP0RlPmpZLTpCpnN067dYny0rYeEnic?=
 =?us-ascii?Q?ZQIdg20mFWStXzulozZL4z23nHeIiP389OExA0ulPLx3Af8dV72nqGcU8mm+?=
 =?us-ascii?Q?CbhwZqIXFoDQFl80Ke3nATNrBBn7wrOUy41EJJq16Ge9sIJRi0M/bpwppUz0?=
 =?us-ascii?Q?sJF+VRlyJrNkyodYcb157xH8i1VLAakbcrTDEbS9AoxqAS7kZfwmUFjl3lUs?=
 =?us-ascii?Q?tsmpDCd/WCFoWvSxamxR88eCwnoQ+N4RiAPtSZ0pj824o3qE879RwJy6Bto4?=
 =?us-ascii?Q?GoGxBeUbl8pzmy2Xpkxnk6zeKUftuwTZjUEdbIzUL3lm6GY0kX+IuBL9Pg8g?=
 =?us-ascii?Q?XR5r7pBs5zovw1Zfy0XuPaabMzVK/KJ+07GfGl1lvkn9xgLb0xmDlQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EF4WBhWbLO9RWIn9+f2GPgnGmfG66p5Z+b/IpTn+ytPkhk2/NnjWIq9Ez4Cq?=
 =?us-ascii?Q?4H6GYatkl9eYFZBHfMSX0gGqhbKK1NMnlxfppMfPQ20zYch84l5CLSukalie?=
 =?us-ascii?Q?d+lKiU2NSnH144Hcrvkvyvv5LHtuLACDjHHfkvQ7TAkrXfpY9KK4zYsXn+NW?=
 =?us-ascii?Q?lhFA68yDMk7O490462fh4keOj1gjGoK6AIrAhEWJ/gTrER5RqxA885BrKqtS?=
 =?us-ascii?Q?2hyL0Xs+pfqqraRN599sstCCrBn7xhkiQj3zGhU1h/dFZPnhgA9L0NLvE3Fk?=
 =?us-ascii?Q?TtlMIONLFyFkRoQWPfMtflee+HgLAoissEoO/13fwkKLIaQ9TnVNjtyuVb4e?=
 =?us-ascii?Q?zNVr24ziTB/MeuPy9rjtwdJP7asEzabmJyFyuBVfArrBTr2OyR4zxbIdiVLc?=
 =?us-ascii?Q?gY4ISykKxLytc9D1UEczaQ809T990AHVC6l/2jZGYhaqxqSec2Pf26bfcfaN?=
 =?us-ascii?Q?21abIzF5ljH6/E0+gDQnMDVe3vFaBpiTqyylPSN+WBz7LKA3Ku7GJ51aQVkq?=
 =?us-ascii?Q?Up56KsC6SkKjdhDAW7rFYH3sYbR08dTKublzTH5lHuWG1mcbHau2IjQhuIH3?=
 =?us-ascii?Q?GDikt0fozh/d07wmHhCuiHXrDCBzr/YhNT0RJ5s8MX4q4YC52VELwpTwdDtP?=
 =?us-ascii?Q?/Jlp2icVr3Pr8rPArUVh3yvSoJQ6QTKup5BKlHtbH8iUl6kyyUsbuPtPw4MP?=
 =?us-ascii?Q?vJ+BpUDe60A7xWXqSdoGwpPH82eYcb1OZYCPHn5D6rbZl7Fc+3Hn3moD+yh7?=
 =?us-ascii?Q?yqeCJ7D9+o/m7z8yPQmbmM9rBU90wcTTfbJL97Eou7HfgdAr7iJRPDdhQ7XQ?=
 =?us-ascii?Q?0rhWJ0XYDTtvoOxM/PpbRWaKVIk660GDFwxgBGvWFr5JzkNKJdsxvK64xnVr?=
 =?us-ascii?Q?RGhvqg7f7gzKaKZU3ee5kc7tX8FakPk1mxd0esQaTKt0Q8m9+5nbvsBSGzsi?=
 =?us-ascii?Q?cGYTqExZUZ9zBSYfqbFMHg1wqTooGh4+vGQGkmnQHBrJzVI/3k4VILJa+ry2?=
 =?us-ascii?Q?jLGgtE2DAzWiZcNKR3p/2eOc+1dh7M7qRYw4b4bbQx6SjQmtYbU/CenpqcT7?=
 =?us-ascii?Q?KK7JiZROq/CeUDCd1qZtlIBREodFPZ/B7yIJLpPtpqd2S4YFPCGhRN9xUEPX?=
 =?us-ascii?Q?Z8Qg8Ohdk43pr+WCyOc7lVywiS5TpqsVUJREHYPI3/MWfLeUJnzDhVgaKMQk?=
 =?us-ascii?Q?K80sCH4rjCYohutP0KFLDozyNfvcO2c8xLxuN8BUUZiluYccAMDQN5DEBoA9?=
 =?us-ascii?Q?Z1mFl8WyGQw2Xg3oMpK9bsJfNUdCrnVKzlv/XBua4ZmhJl3Vl+d+wkFz3LfC?=
 =?us-ascii?Q?/sCorR7QIDy/NkywBuGGNmxC/zClyDyATgAjTAC3xfNP7XYAPBnwnEOdewpo?=
 =?us-ascii?Q?YFH2OFHTfLpKWbBt8txZPjrrGzCEvSNZzyVA+Q5WAZyebBqX7PCtBtgh9s0m?=
 =?us-ascii?Q?xW2ccf7EyqYpZOHfefgFs3/QVvu9Ae8aR/V4suAp5YuQfCTSuvJyI25Q9c8H?=
 =?us-ascii?Q?OTvS0NLdTz7Tj7f84a2Z52ovRNfuyiXlbpN2jQLSZvjxvtTeX5uSRdsMncGI?=
 =?us-ascii?Q?ImlVLGiG+jOECHZnaMLHGomhNqmQ6z3NyXV9VXt+?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AAE8BF09379FED4790139BF892D72B05@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UdGiiKwaOmhcNrdzbHEhxmB0fhd8LHEsPLbdcDHtpxCZAsX06aHa+5G6j6/yON8JF59Gczzy2GU5TDVsgkSC2mvppML2x0ttCBWS2YGt19YHS16rag+8UpbVcF6q9H/Y0mgGvXedKHHaav5B777TRH9ZUsRBYr10x3SEQSYRSHxJvBTzydOsjvlzBkUIK5doN8dRsnyQcri7RdcXElFeB2F4SSpe0tpgJ0uporqhRwKJZ/QM97m1c30fimJfMNVZB8F9vR3VXWhBd+9tctIeuZ90vsUYB2CgEJUStawwhMdUe8ls4y6elXOsxO9c6meHJgCVTvJ93w5TO/mUANpoyVrhMGJ8SWRSbEr9CTsYSzH5y8+0XbTCikdQ2ab6Oujw8MdY0LYYfsILL4wzTwmYfvl5T8NLZa8q4sazmJRDSeV8oCv4LnIS0dK5YG569WuOD8zDpTL7wvTa+cvDELGAl1xcJ2hB2vnrDTHTXM7daAVlXmJWyFBtBG1tyfLF90o7jEFedMs2E5dEgp1ZjTAPEo6u2DzHiCWAnNeIH9MfmJKkGkdNTKFaeCeXe70ivZ+B0iiBnMHzg5ojuDWrroFLUomU0YI4PKKHj0u2SxG7PgY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e51282-3a23-4d94-8ab1-08dde1ba90d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 20:29:16.5909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIVFOGxU5hksj0l30D2p+BuNBlgZouiukjXLsj92HWfwGXzxWqaInw8O04dyuQFKe4EdYevPLG9kpusKgWSj2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508220190
X-Authority-Analysis: v=2.4 cv=b6Ky4sGx c=1 sm=1 tr=0 ts=68a8d321 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=9YzkHXGW99CnoPPj3zwA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX5YaaUiLKnuck
 L57JvSU96oEDfmKEytrSA0pdweDvzRwAcfCjxytxZCBlMeyK2xJNwpbb6Qn59wvmulYXxzV86e+
 YfBpWQ71a+G9PeYzGwSEnv14l8wYeD/nYBKcA3xcRPRZw4Cj1duSYHy6Lsc4jF7VagIxqkTcUiO
 2Mhh4WpLkgCJj7fAWNNDCri37H74HzjBMDqKy5QqNEVcaxS9f9gUlyM8jRI7sX++dwucKephhxc
 x/wYtCJTMmW8kLBME83Mv43ooKBi4xXSmCz//N6C6f0oMVV37e8NS88bJGkyzNWtgMjG51xLdHB
 G/HDa5W6p7h/MRUR+MxDXHJO5vXjtqWIDuv8vJH2kVFZRXnufQxGzw6pJdDxWO5PsY037LVxkcN
 0vfezWhc91ruQQF7mdXTUWfUybls6Q==
X-Proofpoint-ORIG-GUID: DdpfjF_ssZz5PU2BmwY8yicPjMwpJ7m3
X-Proofpoint-GUID: DdpfjF_ssZz5PU2BmwY8yicPjMwpJ7m3



> On Aug 22, 2025, at 15:02, Kees Cook <kees@kernel.org> wrote:
>=20
> On Fri, Aug 22, 2025 at 03:11:16PM +0000, Qing Zhao wrote:
>>> On Aug 21, 2025, at 17:29, Kees Cook <kees@kernel.org> wrote:
>>> For non-static functions, we cannot know if other compilation units may
>>> make indirect calls to a given function, so those functions must always
>>> have their kcfi preamble added. For static functions, if they are
>>> address-taken by the current compilation unit, then they must get a kcf=
i
>>> preamble added.
>>=20
>> Oh, yeah, I see. without lto or whole-program-mode, we cannot determine=
=20
>> whether a extern function is address taken or not. Therefore, we have to=
=20
>> treat ALL extern functions conservatively as address taken.=20
>>=20
>> So, from my understanding, the complete list that need to compute the ty=
peid from the function prototype is:
>>=20
>> - At indirect call sites
>> - all indirect call sites; (At the call site)
>> - At function preambles
>> - all address-taken static functions  (At the function definition)
>> - all extern functions  (At function declaration or function definition?=
? Please see my question below)
>=20
> For "extern functions", the logic is split as:
> - "all extern function definitions get preamble"
> - "all extern function declarations without a definition that are
>   address-taken get __kcfi_typeid_ symbol"

Okay.=20
>=20
>>> The other case is emitting the __ckfi_typeid_FUNC weak symbols, which i=
s
>>> used for link-time resolution with non-C code (i.e. raw .S assembly)
>>> which doesn't have access to the C type system to calculate the hashes
>>> on its own, and needs to have a way to build its own kcfi preambles.
>>=20
>> So, for such functions, there should be an extern function declaration i=
n the C code.=20
>> But the definition of such function is not available in the C code we ar=
e compiling.=20
>> Therefore the weak __ckfi_typeid_FUNC symbol is emitted at the function =
declaration
>> point for such function when we compile the C code?=20
>>=20
>> And the typeid (the hash value) for such routine is computed at the func=
tion declaration=20
>> point too.=20
>>=20
>> Is the above understanding correct?
>=20
> Correct, the kcfi_typeid symbol and value are emitted at function
> declaration point, but only if such function is address-taken.
>=20
>> Then for the other extern function whose definition is in the C code of =
other modules that might
>> be compiled later, should the typeid is computed at the declaration or t=
he definition?
>=20
> It is computed and emitted just for externs that are address-taken.

Okay.=20
>=20
>>> This
>>> is how Linux constructs its assembly function entry points:
>>>=20
>>> #ifndef __CFI_TYPE
>>> #define __CFI_TYPE(name)                                \
>>>       .4byte __kcfi_typeid_##name
>>> #endif
>>>=20
>>> #define SYM_TYPED_ENTRY(name, linkage, align...)        \
>>>       linkage(name) ASM_NL                            \
>>>       align ASM_NL                                    \
>>>       __CFI_TYPE(name) ASM_NL                         \
>>>       name:
>>>=20
>>> That way all the asm functions can be be indirect call targets without
>>> knowing the hash value (which will be filled in at link time).
>>=20
>> Okay. I see.  This is the case for the extern function whose definition =
is in the assembly file. (Not available in
>> the C code)
>=20
> Right, and sometimes we have to explicitly perform a no-op
> address-taking to make sure a symbol gets generated:
>=20
> /*
> * Force the compiler to emit 'sym' as a symbol, so that we can reference
> * it from inline assembler. Necessary in case 'sym' could be inlined
> * otherwise, or eliminated entirely due to lack of references that are
> * visible to the compiler.
> */
> #define ___ADDRESSABLE(sym, __attrs)                                     =
       \
>        static void * __used __attrs                                      =
      \
>        __UNIQUE_ID(__PASTE(__addressable_,sym)) =3D (void *)(uintptr_t)&s=
ym;
>=20
> #define __ADDRESSABLE(sym) \
>        ___ADDRESSABLE(sym, __section(".discard.addressable"))
>=20
> $ git grep KCFI_REFERENCE
> include/linux/compiler.h:#define KCFI_REFERENCE(sym) __ADDRESSABLE(sym)
> arch/x86/include/asm/page_64.h:KCFI_REFERENCE(copy_page);
> arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memset);
> arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memmove);
> arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_prog_runX);
> arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_callback_fn);

I am curious on why the compiler eliminates an external routine completely =
in the file if it's address-taken in that file.=20
Why an additional no-op address-taken is needed here.=20
>=20
>=20
>>> I assume I just didn't see how yet. :) I wasn't able to identify nor
>>> store the typeid for function definitions that ultimately end up gettin=
g
>>> .s file output.
>> So, the problem only exists for the external functions whose definition =
is NOT in the C code?
>=20
> Yup!
>=20
>>> I couldn't figure out how to find these during the GIMPLE pass. Oh,
>>> perhaps I can do this with an IPA pass? That should let me walk all
>>> functions including externs. I'll give it a try...
>=20
> Adding the IPA pass to find all functions worked perfectly. I was able
> to remove all the weird DECL reconstruction and just use the original
> FUNCTION_TYPE info for the typeids.

Nice. So this new IPA pass is invoked even when O0?

Qing

>=20
> -Kees
>=20
> --=20
> Kees Cook

