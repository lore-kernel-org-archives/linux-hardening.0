Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.104
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792562223;
	b=OBlJcBdC9xe3LimZ1Tuidb6E+DZvWDrVi112zO0uDlgrphqTS1XeQWKOyi9rrczFGSaN
	 RQ3xkwyODe08p2e7ouFowxH3I5OIG1y/y+0sn/TsqBKAcXMRPHSsQB7WYtyy7xEnQlToo
	 GCExhQIu2m/XpkAFkf4yK65lVdK2kU7Jt8Y85jEGGlpqdx4/9S9QplmTuR7XKED6RGToR
	 df4fsV0gKWTA/NTbpXFDEBPyKuul/rzHUlr36lPDlKpEjp2XFpbZYS6if9OwTbHdYSISN
	 hu4BlCK9EHnTifsNmFn3iR3KUh8HF51ILTSSF7nlusFRHBs2ewLx4DiTFe71KvQ2kPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562223;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LRQOzOsbeN7g/fWGcKPsLlMcGW4oojhi1L9IA6lcDKQ=;
	b=2A96aqvg7QibGazkYEtEXy4YC7FBOprdXjSsHlIyg++c6WsR761f3FtLe45P6xlC6oVX
	 Hag9sDu9h0EpCXrqpZBGJeQ7BEUd01ouaVRNnzV4wJ2RwLSudCf9wp+IrX4ZtUDs+3J89
	 QvmaeAaI2sdCTK+SWxk/RO0S3LE2mq5/V9RWN2L0sNhhl1wmH7UQjUdTbh3ehh3i65h7y
	 JlAWviT2tWUfHjavMmdXeMJ162++YzmghF8czeD3OGu0quKYQh4iYPRkn2tSlzksYs5mA
	 taq9Ci6P+eoK0JXg7lvT9cWBFrbP4NwY7wHtkTe42mAoozZ9M3egtiIV65gt3l3NsUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=rUPNnAZ8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.104
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023104.outbound.protection.outlook.com [40.107.44.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB83606A31B;
	Wed, 21 Oct 2026 05:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB83606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=rUPNnAZ8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS9EwYWJu0z3RqWnjp5WNu5twyS2K2PD/uG1v6cv08PDUo9kTCWF3gbkW51C9sq+uF/NmD1Ht0oyt8FeRumcms7sH1ChCOdA8QCmQUsHcgbDMcAFWS/tQt5+oVXckmpdna4Qc0SXZ9o+RkjjvmDAjcI/iTAZbgUE/MqAA3MqD6B9c57GuGIgtYs5u+sOhH3kgBsqbpKG54LSBiV5Wp4LS2haGLkRTdZ98h64WqPepDYai4dPZGrU2QhpEi1oiqUdGgXiNv1SnYA0LZbLSBHSXIN7RGukAegzj6pQ50iankcfB+d1CyWqE+9CGOE7j16SPzrwNnSD7y+e5Uluwah71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRQOzOsbeN7g/fWGcKPsLlMcGW4oojhi1L9IA6lcDKQ=;
 b=zEbPrRlx4NUnf87ujwPSssZENCj8SO30y3aOzEuWJxddcvsGnQayIXJ9UZwebWXdG/g7/35ke9KaLxWKg2W+I13lYWvd6FX3fDYuw5+pVMhN6U+PK4gfDBdlA3XOCb2rRWHfmCk+0vbxvQpE/TrNDsqL+gh4YEZh4CU+lK1sB7Znl+YKUdDY5G2QvQFV4TXs1lkV5CndM66lX/7uJXUxS1wVXTSZz+tcYsRfZe4pOo2rb2DJn3SODKN4nhH19nXrkzLQP70JAKqDiuAVtn7iGCTtEU+UOcVM0PyBDleGW86/apgzyOSoYaGJNXKpdpr/0buitu+tfWfdj/WyUWhZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRQOzOsbeN7g/fWGcKPsLlMcGW4oojhi1L9IA6lcDKQ=;
 b=rUPNnAZ8pWY7ypvSd9Khh75JYUqVQhmV3X7kWsH54nzgvfDQLze34W2EKJvlg0jX7ZCvc20EFBATcFY8lR3RSBswLXc0WwzaL8WFP9K0qXHUDAufTzHUhHvRKz7rBGN3+oi6FjLc3AXrNjE/+mhvDFnbtBi2uDlG6/1EiJw8bESEm9i+ilaksdbdsuYiXWszJikMfkWnVubYNUCUnEy6sERgPApcIXQARsWw8iw4zsWEcynHkRbAXEdnHP6q5v1ZfXxqHa1235zrOlwwdHQKpZt59zUGk/oUc3//NjZDlZnVYxfeM6mGru8Q0iVQ/XaJ7HO3eI4K79PVdrQontLsBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by OSNPR03MB9888.apcprd03.prod.outlook.com (2603:1096:604:487::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 05:56:53 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 05:56:52 +0000
Message-ID: <4a633d50-2211-42bf-aeb6-cd72a54a220d@amlogic.com>
Date: Wed, 21 Oct 2026 13:56:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: i3c: Add Amlogic A9 I3C controller
Content-Language: en-GB
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
 linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com,
 Kelvin.Zhang@amlogic.com, junyi.zhao@amlogic.com
References: <20261019-a9_i3c-v1-0-329d819d621f@amlogic.com>
 <20261019-a9_i3c-v1-2-329d819d621f@amlogic.com>
 <2f656848-5f03-40c6-88fa-d1fdae10a03c@kernel.org>
From: Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <2f656848-5f03-40c6-88fa-d1fdae10a03c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25)
 To TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|OSNPR03MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bad24ad-6ced-4cf4-5dba-08df2f381adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|921020|56012099006|4143699003|11063799006|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V9Sl8mH39YVDr3uEqaCZIklz4yswEvqvsNA4Kd0qjodfWod1IVfP/OWdYcim8y4CUDP3lofMveucLFKss50xcAlxyYdOwWMdJenI2TrrhRs9SHME1czO43kxN5hDJjgVF6jZnLKn0vCUAsX+DeUdGROvBjJlz6hi1VIfPpqseuhhz/sX6ctXuhnPMjCTu7UHXFVHrYvQYQtRkAVMK3oQB7Czm3XMbROa3Payg/kIz/iWmK2GF5AZNif3HOFWQIj+CYUJcRiJY9p9zQJOVZKBWMyAMQvf1368nLU4Kcl1X62DHCZYonDFgaRbLkakXpBzAaKxrjK/l7/qLOqEdLdH/bRLirCRiRhbOMDYkt9Bd6dZ4qcM/teil3aZy6y/J//ZGKNgVQhYl5iVrPou75z2wig+K2+pMFZ1Lbxfriqrg5NArtWE7/mE20bpzvNkLEOVZZJrPbfju1kkzYpBs5Ji8npD/B/9AU+3jEl+rsTlZXgKG2NfUsCC1uTeb/TJry4hlfC5+ZGHYlOLWdXuaHoFzcs0D8AuVf48d9F4ubbLkrxZNDu5MGk7xacVDhYdzcdcoF/RtDjfon4aqxjgOB3ge3dK/+PK7JpA6yFjkzFcnFCo5A78GLF2YrThvax8ddC/bH3kBMradhnfvlsYDrlHK00zOWaYJ3o88goz1HQiRT8nYRwc1s/euy7l9Jqqs9G5B8+twDVKrPuV+n16B19bUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(921020)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enlia2grWWJUNnVkU3hBZ3JTbkdJemEweWpudnM5TmoyNE5kVUU4WHJNMzRR?=
 =?utf-8?B?QklCbkh0aUdNbks3Ulg1dGRkSllpaGlMWnhXcTRxRFNtNTlsYzVYNVZSNUZt?=
 =?utf-8?B?TXZLTS9KcHcwNHB0L3ZVbUNkM0VKME4rN3JTVFJDNnBadjhYRzM1LzNWakRs?=
 =?utf-8?B?VUp2alNqZ0lSM0NRWVVnK2lKSzJyelAzTUxqeS9sU0d0dVJuMVdLSFJydURu?=
 =?utf-8?B?NUtrbS9OVlBUMXMraG44bVdwNGhvRHlPeEx3dlNuUDJ1QWFBYS9tbGkwUUtm?=
 =?utf-8?B?K3U2b0V4MU93QUY2bUxrekZ1azQ2aFNmN0tJSjY0T1gzWk9oL0NjTWNLMTBQ?=
 =?utf-8?B?ZWx2UkJ1N2F6N2FWNno0VUFPUzJqVjEwQ3l4WHI5VWlyWWQyc01nU1doTXNV?=
 =?utf-8?B?alIyRzVIZUFNM0N4WXF5bTZpaGpDaFFrL3N0cFpqTkhiU2lYZ29RNlZYb0FM?=
 =?utf-8?B?K01aZ05GY2ZqYm16N2dua1hWUVdqdXRIUllzVmpseTFnZzZtWkRkemlOUkgw?=
 =?utf-8?B?TGswOVNKK0xZTVpMVmNiSHAxMlZZZEVzSzBoaEF4YXpuMENOUGF5RlkvR0Vx?=
 =?utf-8?B?MWNlRXRWQzQvZWxjQ29CWXhSNmFRWlBVb0VuMWdPU3FPRVhsOHNnbHpzSnBC?=
 =?utf-8?B?emw4K2h5UlhIV0d6aXB3bVYveS9yTUE5bUlzczJOeUY3MHN2aUhQV3l2UGVX?=
 =?utf-8?B?ZlJUYXFIMmc4VXVIb1p2MEJFbWozSGpsS0NIVmpWMjE3bVJnajBpeHhvWlZ2?=
 =?utf-8?B?UnRPZXVORXR3RzhvVWpkNmpDZDRaT2tnNFdLcTdiclQvWGdENXFoemZ0Y2Ew?=
 =?utf-8?B?MkhTUXVXcjZaYVJ2UkhhVmdBSVF4QlJzWDdnUlVPc3o4YmVxd05qTGtjYmtv?=
 =?utf-8?B?YkVGSm9KS2hjMFpmV0hmT0FOZTZTQ1VKQnk2ZUpvdU56UkFMRXRkbWZqN2k3?=
 =?utf-8?B?NEZ4UlhzTHVKWk1JNTZNbmthWUR1eGx6MGk1M0d0V2M1d1czaTlaQjBLNHJO?=
 =?utf-8?B?eUFOLzFOcGJhZUNDd2dhOFRIODBmN0FHYnFscGZqU1d3d2djR2gvSlR3anRs?=
 =?utf-8?B?WnJIcFRWZVZXclJVZE0wODNEWG9GRklPbVRlOTdRSDdTM0xtaTNBTmxoV2tC?=
 =?utf-8?B?dGZPUmZsOUdWd0JEby96djVhZzUyNmFCTGErMEhCbnAvb2xKTWJZWnp2a1Ro?=
 =?utf-8?B?MDRCZHlRbi8zTUZvVGU2ck9rck9UQlRjUVVSRklNV2NOZkh6MkFxeDkyUmx0?=
 =?utf-8?B?NUN0MG5DRmxCZi9ReGpIUGxoSGdUZnpLZ0NZYkVaNHZvVVpiSzFSK1dOQ2ls?=
 =?utf-8?B?NTVmVVN3bDY5VmFxVUN6bVdBT0ZYOEF5czNMR1Z4RDlGa1piYjNKeFBHZzhD?=
 =?utf-8?B?U2FFMEZnTit2MjhnZFVCL2c1RVB5S1RjK1ZIV2tFQVZrdGpOdTdZaGVwZWhL?=
 =?utf-8?B?Wk13eGpMMjVpRDRsaUIrMHpxNWpHaUxuTHVtcmFPUjJKR2ZXZFBCYk1XS2xt?=
 =?utf-8?B?cGdlQzk3b2lrQUJyYlRCeEZSS0wxd245Rm5lWmZ0b3dkY3NZOE5QYU8vR2NW?=
 =?utf-8?B?SmZGZkFjSXl0a3VFL0taTTJhYk05OWgwcXpUM1dVTWlUZWQ2ZDd6aWZPa2d3?=
 =?utf-8?B?K1dGMUFxV3JsQzNhVjJ5b0VWcVc5QUt4QXpvWk1JV2NhM1FJVWRyOXpyUU1U?=
 =?utf-8?B?RVdlTGJsWEtFa0hva3RUNDlsRWFwVmpiSDFQLzg3UnJCYXFZczB6VDdldVZ5?=
 =?utf-8?B?eGZVMmRQQmVadmEyYXpGTnpkOUZTSmNua1EzOXFWRFlRYndWUGk1Z3pTTWl1?=
 =?utf-8?B?NndLaTczalRtR2NVVmhUdm5BaFZtV0NOL2pVY2dBQkRubUkyYUMrOStEYks5?=
 =?utf-8?B?MlEwNXd1cHBvU1U5enNTa0tRTkMrT1JrR2pWb2w5NHdTSmJPaFN2ZWE3RlFm?=
 =?utf-8?B?dXFUSFo3Q2cxalo5TVdTVmlxUlpHRWpneGtoZWc1aGd3elk4ajB6aUU3bjF2?=
 =?utf-8?B?aHdSTVNsYkIwS3g0TXJYOXhpMnFyZkZXdDZ6dUVYeDhoNFNGSHdTaExDMTBD?=
 =?utf-8?B?bjlPNm9QdXpRRXNpTU42aVBvYWhpZlNxNkVOdU8rVkdacFpyU1ZEWUZNSHgx?=
 =?utf-8?B?YTFOUFVWT3JlVzhKblYwNml2SDBRUzRYU1p1bzBhQmhXWnpQcjFUU3RrUklH?=
 =?utf-8?B?ODBzOU53cGFhclNsSHFvOTlubHZmYXdvTW0vM3F1c044Tk5DRnFsS2I4QzFL?=
 =?utf-8?B?ZldTUXRDUUpobitNWitjNGxXQzlvY1dYekhiYmJmR0xTV1RYRDM3SHZxelFN?=
 =?utf-8?B?VjcwaWVzNjJoTTJ3YkJZS00xM2swWnRRUDBUUDk5Z2liMWRJWTVUUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bad24ad-6ced-4cf4-5dba-08df2f381adb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:56:52.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glb+lMCusPVC0k/T6oxfVdwSFKmzxL4jxL+APnZedmLVlp3uGdAX8PmPZXegcxIuoOUc7vyouOvdfmAyO9/3qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB9888

Hi Krzysztof,
     Thanks for looking at this.
	
On 2026/10/19 14:01, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 19/10/2026 07:34, Junyi Zhao via B4 Relay wrote:
>> +    i3c@3a7000 {
>> +        compatible = "amlogic,i3c-a9";
>> +        reg = <0x3a7000 0x10000>;
>> +        interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
>> +        #address-cells = <3>;
>> +        #size-cells = <0>;
>> +        clocks = <&clkc 15>,
>> +                 <&clkc 16>;
>> +        clock-names = "pclk", "fast_clk";
>> +        status = "disabled";
> 
> 
> Drop, your binding was not actually tested.

Will delete one, and delete "status" test it again.

> 
> Best regards,
> Krzysztof

