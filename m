Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE743CE78;
	Wed, 22 Jul 2026 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740666; cv=fail; b=A6YLTtBv1l27RRYXlDT9+oye98JBn9UQ0n3Nu4+Xlxu+TkvQbx4x+BIR05JxCmxBbFqssHp4V8gkJRM2CR8xl3Yy7cVnAop41B0Z7Gr3YXwVhs+Zw6fSA3LbRiL33I9a/PViZej7Y5UcoHjJ7OYYJuE5j7X3URemgZCQt3heWPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740666; c=relaxed/simple;
	bh=4Aj36HkmJqWfTn24ZI7CcVaTkQbwciAeJm2sf6UKk70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HgGvi/lDmaJNUAlzYmWywelZ4SUruqDQRcDJZzx8dy2XGUlnJYhqmfe4FuCoKF5Ygv9JmdDOaTvxIDqWp5XqZkP0FjT83+xYRuAdfKg06bKRy4E0N8gz62xSB8KlBjklLqu6nDDTJ/N1MuZRRY4C0M6iBuXxnpbn8RHZjc1ShY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eSzAaa2A; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eSzAaa2A"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFXoMS931297;
	Wed, 22 Jul 2026 17:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Aj36HkmJqWfTn24ZI7CcVaTkQbwciAeJm2sf6UKk70=; b=eSzAaa2AIBIJTWud
	8S52gT+K0fVNM7LsnZSlEjQzqv9AnLZkE8lmoEE0BGsn6PZb7GQTEhfsSwWJVMgY
	2vbmFFjZ6Bb9urEXz2MBtZZ1tDsU7qIl/uFK0+c/gHMYGMQb8vMLgJe1fHbCtRQf
	qCvhk4kZh1EGgp8OLy7PQBxrL18V/Y9v88mD3wnsInCYRXM7jw9wjQjWQO36Y289
	/748ULw4BBSyaMePrCCN5QSVynYf0qx3848zC8rAE87tmGDahS6I612Hl3F9L6bA
	gvU88ud8XkndltB6FEkY15dGtg+WgpWt7vehvcY+6mWX4ghUSRkoqC7xn5RHeV63
	KWju1w==
Received: from co1pr08cu001.outbound.protection.outlook.com (mail-co1pr08cu00104.outbound.protection.outlook.com [40.93.10.100])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fju22a3aj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:17:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9H8bIqheSbKcx97lR/QtRSDhXp+K7tO1PtAsahFDqyKB4Awk5bzu3V6len0aaA4uGexIKcKXA6mpMY6/dJuxzJOss8gMCD29eFlVSwEeq7zs5cKC3BjhF4N/p4aN/xmDI7AipL8NC1+I3Rzwnu605ALJ9Bgj+ITwDAz9ncK3KLn65I4TDZRAcsb8Kfpzi09X1UbEeFD2vsQm8F0iQxjsOebM50IG8ZypuGHevSxUfxveMAKjmiIvdoG7HTddBBzo1nC780dXkxDKmTFoXWdN5M/n57J9vs6oXtXKbl8MnZ94ebIN3jpda3WTloSOt8pLxBbsUmgXZp9Lfn/39sjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Aj36HkmJqWfTn24ZI7CcVaTkQbwciAeJm2sf6UKk70=;
 b=JgrNYXnKmET+AVytm0Yh8myuw/wC0VjaxVcBQRMTrG8Rzl1N9HJcNGr/GViKTNGbgcXCuYS/47aKf834gfEpoKYLdyvV/cu7aUGNsml8bHv8HZctXsoeYz7RyOQ2Ol4YGs4GnAxzg/kwG7JDICHQaxDWyL3KfZgcSjlwH+fYLJaNbV6O1zXTxNNQaXxndfRLr2jD6ndBgU9LCf9tTxFdfjs+lNha3C94y02Op5EO3aPx7bsMjn4jdoRSc+Y7KOpf5oErFEwCHdTTr8ShSrmRnCAqCyxS0bFBAaM4hfgTaToPCABBprWFdg047SlMIa36D2YbOdajjyHq6aNeZ+yHDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BN0PR02MB8128.namprd02.prod.outlook.com (2603:10b6:408:167::20)
 by SA2PR02MB7515.namprd02.prod.outlook.com (2603:10b6:806:145::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:17:37 +0000
Received: from BN0PR02MB8128.namprd02.prod.outlook.com
 ([fe80::258a:329d:ab31:4fea]) by BN0PR02MB8128.namprd02.prod.outlook.com
 ([fe80::258a:329d:ab31:4fea%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:17:37 +0000
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: Nicolas Schier <n.schier@fritz.com>
CC: "nathan@kernel.org" <nathan@kernel.org>,
        "kees@kernel.org"
	<kees@kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>,
        "gustavoars@kernel.org"
	<gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "nsc@kernel.org" <nsc@kernel.org>
Subject: RE: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plugin
 path
Thread-Topic: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plugin
 path
Thread-Index: AQHdGCssV6LViFJIekmJ/hnsw1ANibZ5oUQAgAAqXpA=
Date: Wed, 22 Jul 2026 17:17:37 +0000
Message-ID:
 <BN0PR02MB8128563CD267288E68943157E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>
References: <20260720093545.3836066-1-jaihindy@qti.qualcomm.com>
 <20260720093545.3836066-2-jaihindy@qti.qualcomm.com>
 <20260722-ubiquitous-stork-of-hail-3ba047@l-nschier-aarch64>
In-Reply-To: <20260722-ubiquitous-stork-of-hail-3ba047@l-nschier-aarch64>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR02MB8128:EE_|SA2PR02MB7515:EE_
x-ms-office365-filtering-correlation-id: a60e11a4-2312-467b-5152-08dee81520ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|3023799007|38070700021|10067099003|4143699003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info:
 suI2GmpaSz9Pi+2AwLQ+uh7CqjbRj3I9JYbG7xr4xyp4O5gpEUP64be783X/bGpD1J46cdXySZleu+YIytysHjzR/5l05SVREkn6VyB+RHa0D8kQYBMRWB2rWOmrXHBxl6yPLWIngEObaWLjvrwtwi3gij4VEsSFUm5j59Vd4aG10ZSDsxL/toAJ/2mYOVt4FlLXU7Yz6KmZ0oERnmmfNGaxalxmm3D/DUI+IP1sxIM8fP6uZsBFUeqW2jPaPCH898Jhh+0IzDDUJ/bQLu90q+0tjrZ3Xvydu/w4Dpr3orpjUYZJQpUaRWVW2ASgRZpqTlJoZ9FJ2+E+gX69lS/8XvFKU4QOuNFR5JPOSXJ6twnS1sEyCvrW8FEdOHl/RBt9AbztF12EPGX1lVgtLDEp16VPu8OSRVi9YkOlNzWd9yTA/3fbqoqazSBOGAIKJuIf9TbA85Csw3yasIIW1SCnR7IYf3W3AdRJe0iFubfMehCH/0Wo1ovLdxfGefq8Nyx6YS9uP6+HGRbVxyhcL6Bvb1MEUTwAjHoIzL0B5WoCa9TGlFfGc/s+sllh6lUDIrQLhIoaxyMVivOiW4V2M8jJIBgk3+2ke+PYYzUbxR1rnkVlT3g3OuDYD35a/eyDI60YY/36pY4kfJqEs8fxpAd92GlY6RhtNiAWPB3s9NMm3p708P0lnb2c4LKOYaPmvsaAE0mSlwC7a4bimBmPIhn43nm+DgCSiUu9xVcwlZltB5M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR02MB8128.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlhCUVFTcHAyRW5vaFhnbHdVMU5aTU53ckhsN2swbEQ0aHVEYmFmKzNDbXBx?=
 =?utf-8?B?ekdhQlVMa3BBUEZoUVlkUHp4bTl4dCt5NVZLakgxaGVJblBmMjNiRGdERlhs?=
 =?utf-8?B?WDRUT2NXcjFHcTN2MjJxRHFZVFFsOE5tUElHYnNUbWhEcVZHWHd6RGxkcmE3?=
 =?utf-8?B?Nm1aSy84eDdsUkZOQjRZeEhsMXV5YlNZZnQyempMbmQ2SGxlN3JXNHlYcU9l?=
 =?utf-8?B?Tnl5NTNZajUvK0Rtc1hVNFg4QThSSHVOSVlhc3I1WEF3OVpCK1BWa1BqM0RD?=
 =?utf-8?B?eGFWSC9mYy9oUXMyNHNSUjQyZ2drTjkzKzZnZHQ3cXB3a2drOUFiNkhYTm5D?=
 =?utf-8?B?SVYxNWJZM2hlSFNxckQ2NURYN0NWeTZQamxYeEhQZmw4NGh3aS9pbGFBdXlv?=
 =?utf-8?B?Q1FxMnFZc2Q1T0F1R2ZIcVMwSXZXK0RFNklKU2gzNER5MHNZUlRWTWl6OU1x?=
 =?utf-8?B?YmUrNXRBSElCRmJHN2NlRmlHQy9wSkZLbHp1MmtBdkxjdXhNSGhtK1JOc2l6?=
 =?utf-8?B?ZWlRaTNzQ0NZamR5VUR6QjNHVktlbVlnbm0yVTBJUm10WXhhclBTMGtvQTJp?=
 =?utf-8?B?QlBHeTBCYjVGNGxGQjNrV3J4TTlrTWpscVU4YUk3ZWMxU3JpUGxrMVN4MXRI?=
 =?utf-8?B?RGZqaXM1T2tjdTJVT2FTbU1LQTVNT296NS9LSlM2eDF2dkRDRFJCU2VxTTFD?=
 =?utf-8?B?VEZtdDNWd1dFUDlQUXFxeUdkWTVrbVZuNjBhbnMyVmdFMHd6NDJxUytHRHpF?=
 =?utf-8?B?M0d4SXU4aUpXNERPTXNtUTVRWDA1N0xaR1lSRVpBZGZpRTVZdlBqY2FNT3pl?=
 =?utf-8?B?d1JMZlVtdGZxeWd1MzVPTUNkdjNCSmRDMFVsQnYxeG5QUTVxcGFLVGpjV1Zv?=
 =?utf-8?B?bVYzakR5dzkvcU03UmJqc1MzZzdBK1dzdUoyTU5RVVI4WWtUT0plSmxzM1Br?=
 =?utf-8?B?d0dOQS81Qmt0NkJmeEVqZFEzdHBrMUFsVzdERG0wc0MxRFMrK3luSGxxZjB1?=
 =?utf-8?B?NGtuUkNLY3NkUE1zTGZOa1hPbkVIcitFQ01sTkM4RGJ5UXJaNC9pYTUvVWMr?=
 =?utf-8?B?eDRPdTlMZGhGVWFKWmY5YzVTRGs5OEFYQ0kwYWdWcE5ZTTFKSU5sdTllalBW?=
 =?utf-8?B?bnUrS08zbTV0VHBiZkNJckdacHF4MU5zQmJUZTB0YThaYTJPOHRZWTN5S1RE?=
 =?utf-8?B?QnhFWFNKL3pPUU1LSDFsSUtEcXNKOC9aMUp3THZlazJwc3BSY25DZWhKZFli?=
 =?utf-8?B?SzlvRnVHWnZ5NzdGekRTSlVGdXhKR2ZHeWpwbXJ5Y3pwZmFxSlR4N0lac3l6?=
 =?utf-8?B?WUhTQ2xBN1pQWDk5RTZNYkFoSnlJOEpXK29wS1dLbWw5MCt5RlJ2V0VvNktY?=
 =?utf-8?B?NDdPTXVOOUx2Rm1Kbi9KaEs4WGpDYndkK0xyajk2RGZmQ2xEVUFXVktIVUVK?=
 =?utf-8?B?YnBaZWNkOCtMMDl4aTNPUkQ0anFpQUd6QTEzSXdFV2FIbGNuZWlxZENKdDVw?=
 =?utf-8?B?RTNTTGdhdU9QN0VLUnhub1ZHMmJ2NEhtNXBxTzdFWkFOZmprM2ZTVzhyVjNj?=
 =?utf-8?B?K0o5WHExbUZJQkp3T1lJWGlJSElHZ0NyT3VkQzNjc1VnR1gxTXV6UXpqbDR1?=
 =?utf-8?B?aWRWVEpxcGlqcHQ0OVIxSjJDZHZMT0pjQkwweU9uMU4rM09oaisrZVpRR1dH?=
 =?utf-8?B?TnhvdUxmSEpVZCtjclduMXZybVZIRHZLZ1NnS0x5NVhhVG4wSXA5L240NmVm?=
 =?utf-8?B?ZDNpNUFzYUdjZVFZNHorSjdYNFByRm5sZmQycDEwZG96aFhLSHJnQ2pIYndD?=
 =?utf-8?B?eEVvTzhNZkU4NnhvUndyV1M0dHRJK1pTb3hmN1NXSzFERml2THl5ZkcyajBE?=
 =?utf-8?B?cEJOSE0rM3NNUVg4bHQyTjN5NU9hR1lodFFtZkRxRy8xa0lBelowRnpoTGR6?=
 =?utf-8?B?cUZCT2xIQ0xhaU1PeHJFeUVkVTlnRmNGcHl2dWVFRkNBZmtmdlJKcEs1aHY1?=
 =?utf-8?B?cHp2Zld1MXRKWDQvV3g2bit3c0VGbFM0SnloYlE1aWlQRTZReUJiUzlPMXQ3?=
 =?utf-8?B?Q3FESUYvcUNxZkNoWmhhV0VQd2NsV2U4NkU4dDNOdVRKaVBXNmRGYVhydGF0?=
 =?utf-8?B?UElCT0xDbVVXMFB6MHBiR3lXcVVuV3NDeW5rcXRVUDFaSVlIaHNhZjExbE43?=
 =?utf-8?B?bkpJUWVHaVNGT2dJcDJ3bXN2MFNCVUlFM1ovQWhjdDhnRVkxd0J3NUR5Qit0?=
 =?utf-8?B?bEFYbGJuRDZCeHp5OW9HemxxZXhBcWtITHhnanNrMlhoN1Q1YU1PaVdpb0s3?=
 =?utf-8?B?aEphS3dLVjRxMjNxTWNIUlNCemNrWDBzWnp5SE9Jajc5Vi83cXJ5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hwLcDULGkZHccKjWj+F2h0DXjHrL2o+IzOIrlEAov0OFcDg8tJHDb8wYkXTUamdwtZSqknbPjwQLHnix1S227HAXRJAcWFbN8IExa6TCeEt7Yc7iVMhFLtAyk6hu8gwHFEAtXvuGJzbr1OPe/z4S84WNI07IuRnmvWWMX4o72fK9lWGXEkuzZZ7L1KgAkfn4xpMt07tFp8+yL6iRXSwQTB4pYcieLmeIX+mU/RwbbkbDFCYsORHqjS0fj8zceTsws1/ItSDX/Zng1VHRbC8/9AuCSduCRZYWU3Tc4p/N8uofT2bnya/jbSFkEMvPqw6xDbu6B6qjVqxEYBs7RKBHQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QSEz0Jb9z2XRyhHigBCGUB9g46Hw9Dj41PSuRVPTcueburWNBBM9SJMyhWD+wyG9HqvQ8GYlCTkZjOjlVvXWUb07sdS+7wAHEEA12rh1ywp7+kkihHFyEMMDjKLi9XVQsee13eq8xNCa03yO9KzJscaRLdxvpMGDjM7VgZhC8xSwuph90EGW3HCe7EiiLCDQgWENlOY2ZjFUIkeX5pYJZ6mLWFesh5BahtkabtiYMCZmeIhz/rUn9IlVRtTuoJ9MaEifCkM81X+rpgNpRAZIcvo0CSCQy+PooWuTUf1vIbPYyV2uw3Glrt7arKBWRO2InkdIRef+Lh6vLAMYfjXgg8Bocg1/X/cSK6Z86YGmDUAN97L669yKIoYKaXQgM8Ezc4OLtylgPTQW3Otk6O5OLy/if6sxEa5JRNdKTLF49uLEwprwVywwjiSXKhs/NkivaebJvtRDyHxw6h7t0TTn+0ss1C1moa7Ul0gRPA/qiNmpUjMD1q5NMY7fBZbvxRPrYuPxbL/rRdK/cquYFV0KhuWvB9VpVLf+fWVrWOkRS7FgJ1S1QZrixDK1ME63I+VJSEiYxLou3fC493UoKb4KHRfwxgVa0qgIxUkYSlyuPomuEuwKIXkzKtwywotLLQCE
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR02MB8128.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60e11a4-2312-467b-5152-08dee81520ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:17:37.3254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWbkzrY9pfZmvDQVhS+tQ+WvFhMdgWu502lyM6R90zKxfe79WrBDHHw2aN3sKDtx63byDADiV6ZFpV3as5T1Pwjpy1n9Hn/fMJQ9zBO75kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7515
X-Authority-Analysis: v=2.4 cv=X4Bi7mTe c=1 sm=1 tr=0 ts=6a60fb36 cx=c_pps
 a=vSKo55tUflx2CybR9Niq7g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=Vjf_3FlGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=Y7P7WLLH_9Xxuhd08-UA:9 a=QEXdDO2ut3YA:10 a=QjO3InYhOC9_N663RsT6:22
X-Proofpoint-GUID: _hYVs8QvIbNPDG1EB4SjBWHn03j03xgt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE3MCBTYWx0ZWRfX7kAGyX7UF6N8
 DZSkwaMdreZECBFIMXWkAk7WqYAccgnIHggV0DD/2zpyITPZOcRqNkrugdVYjRTh14mgHtTJbAi
 1xv614m1pdXXdxp4FVzh0U5XwURVyWA=
X-Proofpoint-ORIG-GUID: _hYVs8QvIbNPDG1EB4SjBWHn03j03xgt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE3MCBTYWx0ZWRfX589U+UENEtPV
 cbTYEkBBVyq8QOQKw7dAXm/s1RtffLrCw4lM/kp7nekeggFe04FaSoRyIG5Y7dkK0wy0KxklBeZ
 qsrIUu36WnyA9aGo4raYLqQXBjrdzRWcoXzTKyzqAnLmGx4beMspaXtSCkX0yIrckpSjAxE0c1N
 ZJfQHObznwojYwhRXWMZJldvNLIKVOqhjmrwL/0BRG4bx4LVt0s/IhUSso198Vb+biEB7FS2WAL
 DYT3CouX4wAGHO4e5rcZ7G3acUoZgosOTX82jYkcy/iMKNGV55OCkCb8zV3T+alifGqWsP/9l0r
 H9NFd0ge8jUnUd1/8EfNwRnnVmPPdNiXuE8lHBgkHf+Qc/Vo5AygjbwuiEOsEtirMyadMyUn6oQ
 PRZsAHekqHl8CuvtEqi6/tfWdlCbeMMsAtVP7m6zSzf8vX4W0qEzH0sBi2vStoy8AAFkVKrSn/g
 LiY+Mwo1lHMA1XmLZeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220170

DQpIaSBOaWNvbGFzIFNjaGllciwNCg0KVGhhbmtzIGZvciBsb29raW5nIGludG8gdGhpcyBhbmQg
Zm9yIHRoZSBzdWdnZXN0aW9uLg0KDQpUaGUgaXNzdWUgaXMgb25seSBvYnNlcnZhYmxlIHdoZW4g
YnVpbGRpbmcgb3V0LW9mLXRyZWUga2VybmVsIG1vZHVsZXMgd2l0aCBDT05GSUdfS1NUQUNLX0VS
QVNFPXkgZW5hYmxlZC4gSSBkaWQgbm90IG5vdGljZSB0aGUgcHJvYmxlbSBmb3IgaW4tdHJlZSBr
ZXJuZWwgb2JqZWN0cy4NCg0KQXMgYW4gZXhhbXBsZSwgaW4gb3VyIHNldHVwIG1zbV9rZ3NsLmtv
IGlzIGJ1aWx0IGFzIGFuIG91dC1vZi10cmVlIG1vZHVsZS4gVGhlIGFic29sdXRlIHBhdGggdG8g
dGhlIHN0YWNrbGVhayBwbHVnaW4gZ2V0cyBlbWJlZGRlZCBpbnRvIHRoZSBEV0FSRiBwcm9kdWNl
ciBzdHJpbmcgYW5kIGNvbnNlcXVlbnRseSBhcHBlYXJzIGluIHRoZSBnZW5lcmF0ZWQgbW9kdWxl
Og0KDQpyZWFkZWxmIC0tZGVidWctZHVtcD1pbmZvIFwNCi4vdG1wL3dvcmsvPG1hY2hpbmVfbmFt
ZT4tcWNvbS1saW51eC9rZ3NsLWRsa20vMC4wK2dpdC9pbWFnZS91c3IvbGliL21vZHVsZXMvNi4x
OC4wLXJjNi0wMDI2My1nM2Q1ZGI2Nzk3YjVmL3VwZGF0ZXMvbXNtX2tnc2wua28gXA0KfCBncmVw
IGZwbHVnaW4gfCB0YWlsDQoNCk91dHB1dDoNCkRXX0FUX3Byb2R1Y2VyIDogR05VIEMxMSAxNS4y
LjAgLi4uIFwNCi1mcGx1Z2luPS9sb2NhbC9tbnQvd29ya3NwYWNlL2FiaGkvUUxJLU1BSU5MSU5F
L2J1aWxkL3RtcC93b3JrLXNoYXJlZC90YXJnZXQtcmlkZS1zeC9rZXJuZWwtYnVpbGQtYXJ0aWZh
Y3RzL3NjcmlwdHMvZ2NjLXBsdWdpbnMvc3RhY2tsZWFrX3BsdWdpbi5zbyBcDQotZnBsdWdpbi1h
cmctc3RhY2tsZWFrX3BsdWdpbi10cmFjay1taW4tc2l6ZT0xMDAgLi4uDQoNCg0KQXMgY2FuIGJl
IHNlZW4gYWJvdmUsIHRoZSBmdWxsIGJ1aWxkIHBhdGggdG8gc3RhY2tsZWFrX3BsdWdpbi5zbyBp
cyByZWNvcmRlZCBpbiB0aGUgRFdBUkYgbWV0YWRhdGEgb2YgdGhlIG91dC1vZi10cmVlIG1vZHVs
ZS4NCg0KSSBoYXZlIG5vdCB5ZXQgdHJpZWQgeW91ciBwcm9wb3NlZCBzaW1wbGlmaWNhdGlvbjoN
Cg0KLWtzdGFjay1lcmFzZS1jZmxhZ3MteSArPSAtZnBsdWdpbj0kKG9ianRyZWUpL3NjcmlwdHMv
Z2NjLXBsdWdpbnMvc3RhY2tsZWFrX3BsdWdpbi5zbw0KK2tzdGFjay1lcmFzZS1jZmxhZ3MteSAr
PSAtZnBsdWdpbj1zY3JpcHRzL2djYy1wbHVnaW5zL3N0YWNrbGVha19wbHVnaW4uc28NCg0KDQpB
dCBmaXJzdCBnbGFuY2UgaXQgZG9lcyBzZWVtIHJlYXNvbmFibGUgZ2l2ZW4gdGhhdCBLYnVpbGQg
Y2hhbmdlcyB0aGUgd29ya2luZyBkaXJlY3RvcnkgdG8gS0JVSUxEX09VVFBVVCBkdXJpbmcgY29t
cGlsYXRpb24uIFBsZWFzZSBMZXQgbWUgdHJ5IHRoaXMgYXBwcm9hY2ggd2l0aCB0aGUgb3V0LW9m
LXRyZWUgbW9kdWxlIGJ1aWxkIGFuZCBJJ2xsIHJlcG9ydCBiYWNrIHdpdGggdGhlIHJlc3VsdHMu
DQoNClRoYW5rcyBhZ2FpbiBmb3IgdGhlIHN1Z2dlc3Rpb24uDQoNClRoYW5rcyAmICBSZWdhcmRz
LA0KSmFpaGluZCBZYWRhdg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBO
aWNvbGFzIFNjaGllciA8bi5zY2hpZXJAZnJpdHouY29tPiANClNlbnQ6IFdlZG5lc2RheSwgSnVs
eSAyMiwgMjAyNiA4OjE2IFBNDQpUbzogSmFpaGluZCBZYWRhdiA8amFpaGluZHlAcXRpLnF1YWxj
b21tLmNvbT4NCkNjOiBuYXRoYW5Aa2VybmVsLm9yZzsga2Vlc0BrZXJuZWwub3JnOyBsaW51eC1r
YnVpbGRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJuZWwub3JnOyBn
dXN0YXZvYXJzQGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5zY0Br
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gc2NyaXB0czoga3N0YWNrX2VyYXNl
OiB1c2UgcmVsYXRpdmUgc3RhY2tsZWFrIHBsdWdpbiBwYXRoDQoNCkhpIEphaWhpbmQsDQoNCk9u
IE1vbiwgSnVsIDIwLCAyMDI2IGF0IDAzOjA1OjQ1UE0gKzA1MzAsIEphaWhpbmQgWWFkYXYgd3Jv
dGU6DQo+IEdDQyByZWNvcmRzIGZ1bGwgY29tcGlsZXIgY29tbWFuZCBsaW5lcyBpbiBEV0FSRiBw
cm9kdWNlciBzdHJpbmdzIGJ5XG5kZWZhdWx0LiBXaXRoIENPTkZJR19LU1RBQ0tfRVJBU0UsIHRo
ZSBzdGFja2xlYWsgcGx1Z2luIGlzIGN1cnJlbnRseVxucGFzc2VkIHVzaW5nIGFuIGFic29sdXRl
IC1mcGx1Z2luIHBhdGgsIHdoaWNoIGNhbiBsZWFrIGhvc3Qtc3BlY2lmaWNcbmJ1aWxkIHBhdGhz
IGludG8gZGVidWcgYXJ0aWZhY3RzLlxuXG5SZXNvbHZlIHRoZSBzdGFja2xlYWsgcGx1Z2luIGRp
cmVjdG9yeSByZWxhdGl2ZSB0byB0aGUgY3VycmVudCBidWlsZFxuZGlyZWN0b3J5IGFuZCB1c2Ug
dGhhdCBpbiB0aGUgLWZwbHVnaW4gb3B0aW9uLCBmYWxsaW5nIGJhY2sgdG8gdGhlXG5leGlzdGlu
ZyBhYnNvbHV0ZSBvYmp0cmVlIHBhdGggd2hlbiBuZWVkZWQuXG5cblRoaXMga2VlcHMgcGx1Z2lu
IGxvYWRpbmcgYmVoYXZpb3IgdW5jaGFuZ2VkIHdoaWxlIGF2b2lkaW5nIGFic29sdXRlXG53b3Jr
c3BhY2UgcGF0aHMgaW4gcmVjb3JkZWQgY29tcGlsZXIgZmxhZ3MuDQoNClBsZWFzZSBub3RlOiB3
aGlsZSB0aGUgcGF0Y2ggYmVsb3cgaXMgYXBwbGljYWJsZSwgeW91ciBjb21taXQgbWVzc2FnZSBp
cyBicm9rZW4gKCJcbiIgaW5zdGVhZCBvZiBuZXdsaW5lcykuDQoNCg0KDQoNCkNhbiB5b3UgZ2l2
ZSBtZSBhIGhpbnQgb24gaG93IHRvIHJlcHJvZHVjZSB0aGUgZGVzY3JpYmVkIGJlaGF2aW91cj8N
CkkgZW5hYmxlZA0KDQpDT05GSUdfREVCVUdfSU5GTz15DQpDT05GSUdfREVCVUdfSU5GT19EV0FS
RjU9eQ0KQ09ORklHX0tTVEFDS19FUkFTRT15DQoNCmFuZCBidWlsdCB3aXRoIE89YnVpbGQgYnV0
IGNhbm5vdCBmaW5kIHRoZSBwYXRoIHRvIHRoZSBwbHVnaW4gZGlyIGluIGFueSANCmJpbmFyeSBi
dWlsZCBhcnRpZmFjdCBJIGdyZXAnZWQuICBXaGF0IGRvIEkgaGF2ZSB0byBkbyB0byBmaW5kIHRo
ZSANCnBsdWdpbiBwYXRoIHRoZXJlPw0KDQpbLi4uXQ0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9N
YWtlZmlsZS5rc3RhY2tfZXJhc2UgYi9zY3JpcHRzL01ha2VmaWxlLmtzdGFja19lcmFzZQ0KPiBp
bmRleCBlZTdlNGVmN2I4OTI2Li4wMDZkMTBmM2I3N2EwIDEwMDY0NA0KPiAtLS0gYS9zY3JpcHRz
L01ha2VmaWxlLmtzdGFja19lcmFzZQ0KPiArKysgYi9zY3JpcHRzL01ha2VmaWxlLmtzdGFja19l
cmFzZQ0KPiBAQCAtMSw3ICsxLDEwIEBADQo+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wDQo+ICANCj4gIGlmZGVmIENPTkZJR19HQ0NfUExVR0lOX1NUQUNLTEVBSw0KPiAta3N0
YWNrLWVyYXNlLWNmbGFncy15ICs9IC1mcGx1Z2luPSQob2JqdHJlZSkvc2NyaXB0cy9nY2MtcGx1
Z2lucy9zdGFja2xlYWtfcGx1Z2luLnNvDQo+ICtzdGFja2xlYWstcGx1Z2luLWRpciA6PSAkKG9y
IFwNCj4gKwkkKHNoZWxsIHJlYWxwYXRoIC1tIC0tcmVsYXRpdmUtdG89JChDVVJESVIpICQob2Jq
dHJlZSkvc2NyaXB0cy9nY2MtcGx1Z2lucyAyPi9kZXYvbnVsbCksIFwNCj4gKwkkKG9ianRyZWUp
L3NjcmlwdHMvZ2NjLXBsdWdpbnMpDQo+ICtrc3RhY2stZXJhc2UtY2ZsYWdzLXkgKz0gLWZwbHVn
aW49JChzdGFja2xlYWstcGx1Z2luLWRpcikvc3RhY2tsZWFrX3BsdWdpbi5zbw0KDQpBcyBLYnVp
bGQgY2hhbmdlcyB0aGUgd29ya2luZyBkaXJlY3RvcnkgdG8gS0JVSUxEX09VVFBVVCBidWlsZCBk
aXIgZm9yIA0KY29tcGlsYXRpb24sIEknZCBhc3N1bWUgdGhhdCAnJChvYmp0cmVlKS8nIHNob3Vs
ZCBqdXN0IGJlIHJlbW92ZWQgYW5kIA0Kc2NyaXB0cy9nY2MtcGx1Z2lucy9zdGFja2xlYWtfcGx1
Z2luLnNvIGJlIHRoZSBhbHdheXMgbWF0Y2hpbmcgcmVsYXRpdmUgDQpwYXRoIHRvIHRoZSBwbHVn
aW46DQoNCi1rc3RhY2stZXJhc2UtY2ZsYWdzLXkgKz0gLWZwbHVnaW49JChvYmp0cmVlKS9zY3Jp
cHRzL2djYy1wbHVnaW5zL3N0YWNrbGVha19wbHVnaW4uc28NCitrc3RhY2stZXJhc2UtY2ZsYWdz
LXkgKz0gLWZwbHVnaW49c2NyaXB0cy9nY2MtcGx1Z2lucy9zdGFja2xlYWtfcGx1Z2luLnNvDQoN
CkRvZXMgdGhhdCB3b3JrIGZvciB5b3U/DQoNCktpbmQgcmVnYXJkcywNCk5pY29sYXMNCg==
