Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792559879;
	b=SrJFtPWtdi103s21hwC6cYaaOg8xY6Zb58I3wFxnGyHsv/DgCkOEx7c/OOJymX8ZHF6k
	 0xU9JGXduPgPBpNrHN2NRfNdowku8vc2mJ2jMSPX4xoy1tkHNYuNv+8AkfmhOAgR7/iE1
	 SlX3aL00BCiK4XUdqdMCTxcYzwWHan7zOg0bZpf2JEK6DtsK2m/zLRKeVNlZxUKhFDh5u
	 qdIdXFsonWs15U3ZY2hZ9aHCiT9XtSFLdhwRyjmi/Xn9g0bkp9BkWomNRqNuOwhVu8/b4
	 +pZXirz6SvjBl2LLWC49B2f8zHBb7q89kRM8eaTHlPPd0Y6Sw+LTTsEFuSwB06cja7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559879;
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
	bh=TebaFxd3BKhB9U6R7ULJFxj4xe3Z55zXaPsOwtxtCwo=;
	b=zmACGRYxi7lxTMs66Zh8uPC+YtC2J17Vltjx8JiDSd9RqObq1pPq9S7B0Xmy6C2c6emh
	 ZmnnUyi1J6TQReh5HXC+Iin96hnfOcpujo6yJ9BTcl6DL8XohBfwUUyrnUorkVXHr8jvE
	 AbbOsYYqf4x/QrLzPNAJPvcggnKdXKjeN3jd0/0PU7a+s/Ty0sz+UyWyKd9zE3WHRYgBD
	 hqkgLwG25yJHzXoltRj/poAjg/V4IC7aiU8VgDXAIZgF2yjhhkxeZixt4y5PrGHiEpDh2
	 yhkNSTHDz1oQXetT6BFeb0IyHoEQeWtzjPUQfHAuHFEqasoVRWdj7M+kXJ84bjmPYeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=wuww8OXP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.76
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023076.outbound.protection.outlook.com [40.107.44.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F3606A319;
	Wed, 21 Oct 2026 05:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D7F3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=wuww8OXP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSbRw++RYkutUlhTh1ZLl/KbB5XCatnjUyhLOFcZo3YSsPvmcGE6GlbPgQVngSBjLLCHmT0pRpvZBxyssJar3G3CI9W1YuOQRVgwvGxE1e5gYeKPAPvh/7OJEUAqQGrJ0GLVAf1PnGjyyZy7f2rcTAlvBkz0uJoA5c5Sfp6v7Ut2j3aJvgUyX2UkQMfpRUiLtLM+Iqpqr/O7ZKd01lwCRTIQ8WsyCU5dbhziojP6yZEE+AhiU/1m8oYnKFM9cT0LhJa7Dql2ZlHCvxgPubD4zMNcn8WC9ufiK2kCQ4r/CYJGRIFP/G6Zq+vnJqZA3CoqLJIO/emssPl4R843+yHeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TebaFxd3BKhB9U6R7ULJFxj4xe3Z55zXaPsOwtxtCwo=;
 b=ivKM80l91kNIcYs48z32+MSGuoEfKoiYsRmjgx7QfvtWd96Tt935gFAKjpQ1hYCGQchy0UU6+JfiqIe5v1pu0rSWdO5IwyqzABEeuvgs/TrPMr6TWDAXfFRKXmpgRcxpqRj1M31ZZazvyp74EL66/75LJeYzrh+CjUC6NvdtJ4h3sg6rcjIbEY6WANMsOb9hUzZFnjrSbdxdX9DdMcuNlN1Fap4bjlZwvbkyp9nnYrFH0jNKyZOyeCeRW3Eo1UHsgV06hFdBUeZpffticW4K2Mad/unRqsNrzu3I3cS4XFLfXqJKtG3ov9lUG4ZACokXmsgiwnF4rcZflrsPYb8Kww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TebaFxd3BKhB9U6R7ULJFxj4xe3Z55zXaPsOwtxtCwo=;
 b=wuww8OXPfWZo6evlPSyOOoTM2nvXmp7yWU1fxcZda+r4P49x/4x3wv/9+69hyOLjEH9Yft6FfUsOn4aoFxpjNEhmucQ3eiZBCXX5yB/YgK37tyTMKLAsJsHkbmnLPqW1QWSE//mjyVrglG0nDces4dSsUOst0FfCLegwj2R2tSoxnimdCNze56inkWP/bMbChwkPA49PJ0SDP3yd6TxXxHBB/Brct83CsrGvm7BxIs0R1am+OSMW8B/qkM1kI70iciswTAfJDvn6dzLriBUG3fJiIz9F6TtCs+8jl3Zlc2iXtFyFYpvhYmlAQD/Dk4GaLuW7BTWpXFm9RvQSFiAjJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by TYSPR03MB7641.apcprd03.prod.outlook.com (2603:1096:400:414::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 05:17:54 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 05:17:54 +0000
Message-ID: <5976b6c1-9b65-4da1-8bf3-e3008a373c22@amlogic.com>
Date: Wed, 21 Oct 2026 13:17:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i3c: master: svc: Add Amlogic A9 glue layer
Content-Language: en-GB
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
 linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com,
 Kelvin.Zhang@amlogic.com
References: <20261019-a9_i3c-v1-0-329d819d621f@amlogic.com>
 <20261019-a9_i3c-v1-3-329d819d621f@amlogic.com>
 <98df3ac1-c6ae-4acb-b0ee-ddda92487660@linaro.org>
From: Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <98df3ac1-c6ae-4acb-b0ee-ddda92487660@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0128.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::12) To TYZPR03MB5743.apcprd03.prod.outlook.com
 (2603:1096:400:74::7)
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|TYSPR03MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1c7d30-0aaa-4eed-8ce9-08df2f32a929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|18002099003|10067099003|22082099003|4143699003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|11063799006|5023799004|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	9RYxZ6MHV613Fh+KrWauhJR2Z4jF8diBbNzLpON+1vyF8PDTFT/dL65TB+sxBw7AvVi31PaM8yBtIgXBvAgcmLEqNAr0bkKuczRU2wk91bA6DcFPBGaCXWokhGT7RhS7VRlXRi3sv1EByAzKtSqEriTHNhtulkW5SdnrAi1/yCDN4CnTeR6w/cYnCUKJAqxtYxMgG40LR0yZ3QWNA8tCDiBW+zvyZLmFdeq6hkf1L6uyFAjXA3XNHOxFJdPKNBr98qaGUTaA0tWphXdpdFHJHoGeVjnwYdwbVhe6JUVe8uqfoD5dRAaBLk6D3qtKnymLlgvHl13eGwmbmGbbGtYOQatijTYlF1icFW0mimvA3pViztM/PG7pNXPzTSr0bEDsFUK+fWpPE3UXIynCkgOT5CpJU7ZEaDWYLPkzjExBi+G7jZLprPB8lIRgQWjHvg14zLe0YeaViQOs2yMlMLdGG+/sWPppHklvyJVzRgV19lKg1HJxJYRiXroFRXDrpp84tdKkIBRdVMQodZFOmpH/kUZgED34fbM1vmOUi2fNPZBCQmEz8kDsk5lrMb44/FAQcvz0551kQPxWle4jG9bN+3/Nh5G9C4yVODQZdvCnpHBSb08iaO+IqM35/AYThROw75EvkcOKGD6SFNZ5aPSoy1zk8BjFT5rXJ63wuZX+biOdtRj4U4I442FL5CcQqj0FpAEpnROLON6gk3k7c9KQmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(11063799006)(5023799004)(921020)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFhwOUlYc3dnd3JrU1BtUHYzMzlqVVc5WjhwQ2lZbmdKRTBpQVE4dWtEdmRm?=
 =?utf-8?B?ZnFWVFdXeEV5bmU5T3FSYW1hNXZ1VGx6MGt3SERoMnc1bTNvV2lHVEFpL3gx?=
 =?utf-8?B?RDdsTURxSmtFVTRqVS9KdTJUSG42OEp0ZTZDZ0Q1c1ZCd0JuZk9VODBJdk1D?=
 =?utf-8?B?LzlNRng1N1NrWG9VTkdQd0FBR1duVldnSUZVd2J4K2JkdTIyamd6ZjcyRk52?=
 =?utf-8?B?NFU0NzVpcng1S294Q3d1KzhZTkdzNGFBbVRiT1dWUXhSeWlkeUpWUmc2ZjVq?=
 =?utf-8?B?L3RoeWNGaGgxSDlYWkVkNjhrNFFGMlFYWWVSbHJMWk5pZ1A1WC9SSnlnNEpC?=
 =?utf-8?B?UisxOHJoVzh3T0dQV0h4dVNPTkRsTGpNUkp1LzdIY0xMRTdoNXJzNS9IVlRM?=
 =?utf-8?B?bmxWVDZwaTk2eVFxRG1xUU1oTVdXdkg1TFlYNDdXaXhOSmQySDkvaUFabElq?=
 =?utf-8?B?Zi85YnNKdU5sVlNJSDZNV3RiZktVZm9laFNhN2d4ajFXaXJMK0xvWlBiVEEx?=
 =?utf-8?B?ekRJR1ErZkp1YXZta1BJTnBHTm8wSVRESlc5WlZZZStiVnBoWStmd29HeFpQ?=
 =?utf-8?B?OHNNNDAyLzNqRjJpT1BDcm1HOUYvN2FseWdzTmRyYW5TRnJPU3I4OWJCc2tP?=
 =?utf-8?B?VTdtaTIweUhrYUJVYjFaVjBhd25FbW85dmFaS201RStsMlZvd0U2cWdhSVZk?=
 =?utf-8?B?dVFkSHpyZmlUZnI2TUVKL3pRd1FZaUlMbElpYUhiMkptbTA3eWcrNzhVOGZ0?=
 =?utf-8?B?ZlVRbDJLWXF1M2p4WWp0UlBDMTc1aGwzc3Q1RVJJMGphb3N1eldrMFFDZ1ln?=
 =?utf-8?B?Mm1VaHFUZEt0a2dEUjRtU0c2QmQzdHc2QkhjMGVYR0RjZHk0cHJmZXY0d1JX?=
 =?utf-8?B?dm5sTGkwMFYwU1JkSkp3OTFMQnI5QzNCZWRtUFo0VGRyaktseXVseHpwVXlT?=
 =?utf-8?B?bzlKRkUrSEZvNjJsMXZ3WVFUSnFBeE85UW5JUGJ2WnVYS2pDRXZNaXc3UkM5?=
 =?utf-8?B?RlY4eVlRbzRpd1lwWXRTd0J4MWs3dnJVemVVN0FsZ3pLOW1jUWQ1Z3NtTEFS?=
 =?utf-8?B?dk5nR2p1Ym16enpiZFdMaVlKMDdKWkZWL2R0SW5rMnVCM0FaSFhPeEw3ekp5?=
 =?utf-8?B?ZlNPbHExOGNGU3VJZHpxd2lleWNTVHFmOGZ5SE1LaEkwakhPaGtFbzhyZ0c3?=
 =?utf-8?B?QmMvK0pIQ3pXdy92cW5SbHpvQnNYOXd0OTZyTjNuUVN5RmR4ZXBvZWJaeENW?=
 =?utf-8?B?WDh2WWIvKzZqdWtZRHRJNFpDVWQwVUVRa2pCWDBFWDFQYUlFTkxOeTFIVHFI?=
 =?utf-8?B?emRGNXFLeHBxaG9RTXpybGpJVjVTOUxMWFVBZkdOWUtqeDI2cXJSYlRJNnNv?=
 =?utf-8?B?WUFwTnBVeUNJMkd0MWNUb0ZNQ1VmTDBXcUkvcEE5YmRsOVhhMVZyYnFpNkhZ?=
 =?utf-8?B?V2RNUGkvUzNNRHpSTFBsNTFYYU81MTk1eDhxMVZlcHo0VWQzbUh4RFJzTTdK?=
 =?utf-8?B?UklCZ2MrbnkyUUp0eUdCS2ZOU0x5TisyWFJxTXJRQWFsL2Jsa3BQSllDMENZ?=
 =?utf-8?B?R3c2by83U0UrL2g2TlJoZU44bnRmQkN1Q3NTK3dYOTk2WkRobFREUkdaWGdW?=
 =?utf-8?B?OXhQdjY3Umg5ZHNRZ2VSUFhzMFp6WkhSTkJqdU1iQ0o3RUtXUUJJQStEZFJl?=
 =?utf-8?B?SERRR0Rnb2JrY2ZRK0pDeFhRczF4QVp3TVNRaGdTcnRhcjNBZWFZQ2hKcEYw?=
 =?utf-8?B?M0ZCdk54REdPZ3QyWGRjZnptVkNlMFRwVTBsMmdrWHZnVjVNbVhxNTZSTWk3?=
 =?utf-8?B?YWo3U2x5V1VGVnE0UW5vUDRwdFJLQnNlNGpBS0lvcHVZN1RZTHcvemRrSUV3?=
 =?utf-8?B?QkVDUytucm50NjNTaVgyd0N5T215NFUwU0VrOWVWMzRGdzBxcDRROEJsNFJU?=
 =?utf-8?B?VS9iaTNFYXA3MG4zYmVFczVVRDRwdUY3YStVMDRmTFpFOHBLZjhRNElEMHdv?=
 =?utf-8?B?Zlp6KzdYVUVNM3RmRHFoeTZGR2NqcVV3TXY3cEpxZ21wanNVMitCaVMyazlj?=
 =?utf-8?B?cldWbTBRNDMwWEZ6dXg2Vko4MnNveXFnYkE1YUN6QWFzN3VmTkJkeU5lOGFQ?=
 =?utf-8?B?ZlBDMGo2K1k0VUlGblNuaStoTktucWE4VTVOZ2hjdG4weEFSQi82ZXJFWnRP?=
 =?utf-8?B?ZndLSnoxTm5YcW5xMi9ZYkRIcFlZZU9LK0d2R3FrTE5yVU5nT054eFh0RVJY?=
 =?utf-8?B?Q2doWTl1RVdyN1hrMnJtNXNqRHdoWVgxVEFwaXg4YUFSd3BjU3ExdnRGQXNs?=
 =?utf-8?B?ZFVjSTh6M3VQc2crZjl0ZHA3TlBtczFHSENrWnpQUHhRMmszQ0t1Zz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1c7d30-0aaa-4eed-8ce9-08df2f32a929
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:17:54.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5QzD82JCgk8oPopQfc4FUJmKePQCyIcuJPLjy5lux9HlwlGtBTRsPE5ZgupYAzObRCwozdmk807DTc7FdvtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7641

Hi Neil，
	thanks for your review.

On 2026/10/19 15:40, Neil Armstrong wrote:
> 
> On 10/19/26 07:34, Junyi Zhao via B4 Relay wrote:
>> From: Junyi Zhao <junyi.zhao@amlogic.com>
>>
>> Add support for the Amlogic A9 implementation of the Silvaco
>> SVC I3C controller.
>>
>> The glue layer provides Amlogic-specific operations and resource
>> handling while reusing the common SVC I3C core driver.
>>
>> Add a corresponding MAINTAINERS entry for the Amlogic I3C
>> controller.
>>
>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>> ---
>>   MAINTAINERS                          |   6 +
>>   drivers/i3c/master/svc/Kconfig       |   7 +
>>   drivers/i3c/master/svc/Makefile      |   1 +
>>   drivers/i3c/master/svc/i3c-amlogic.c | 250 +++++++++++++++++++++++++ 
>> ++++++++++
>>   4 files changed, 264 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dffc63af2..478979446 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1398,6 +1398,12 @@ F:     Documentation/userspace-api/media/v4l/ 
>> metafmt-c3-isp.rst
>>   F:  drivers/media/platform/amlogic/c3/isp/
>>   F:  include/uapi/linux/media/amlogic/
>>
>> +AMLOGIC I3C DRIVER
>> +M:   Junyi Zhao <junyi.zhao@amlogic.com>
>> +S:   Maintained
>> +F:   Documentation/devicetree/bindings/i3c/amlogic,i3c-a9.yaml
>> +F:   drivers/i3c/master/svc/i3c-amlogic.c
>> +
>>   AMLOGIC MIPI ADAPTER DRIVER
>>   M:  Keke Li <keke.li@amlogic.com>
>>   L:  linux-media@vger.kernel.org
>> diff --git a/drivers/i3c/master/svc/Kconfig b/drivers/i3c/master/svc/ 
>> Kconfig
>> index 14fa1e542..df3528bc1 100644
>> --- a/drivers/i3c/master/svc/Kconfig
>> +++ b/drivers/i3c/master/svc/Kconfig
>> @@ -18,4 +18,11 @@ config I3C_SILVACO
>>         compatible strings such as "silvaco,i3c-master-v1" and
>>         "nuvoton,npcm845-i3c".
>>
>> +config I3C_AMLOGIC
>> +     tristate "Amlogic I3C support"
>> +     default y
>> +     help
>> +       This selects the Amlogic SoC glue layer support for
>> +       the Silvaco device driver. This driver is used for A9, C5 SoCs.
>> +
>>   endif # SVC_I3C
>> diff --git a/drivers/i3c/master/svc/Makefile b/drivers/i3c/master/svc/ 
>> Makefile
>> index cf18c5da6..695863d1f 100644
>> --- a/drivers/i3c/master/svc/Makefile
>> +++ b/drivers/i3c/master/svc/Makefile
>> @@ -3,3 +3,4 @@
>>
>>   obj-$(CONFIG_SVC_I3C)       += i3c-main.o
>>   obj-$(CONFIG_I3C_SILVACO)   += i3c-silvaco.o
>> +obj-$(CONFIG_I3C_AMLOGIC)    += i3c-amlogic.o
>> diff --git a/drivers/i3c/master/svc/i3c-amlogic.c b/drivers/i3c/ 
>> master/svc/i3c-amlogic.c
>> new file mode 100644
>> index 000000000..82300d6ae
>> --- /dev/null
>> +++ b/drivers/i3c/master/svc/i3c-amlogic.c
>> @@ -0,0 +1,250 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>> +/*
>> + * Copyright (C) 2026 Amlogic, Inc. All rights reserved
>> + */
>> +#include "i3c-main.h"
>> +#include <linux/math64.h>
>> +
>> +/* Amlogic specific registers */
>> +#define I3C_BG_RD_ADDR                       0x200
>> +#define I3C_BG_WR_ADDR                       0x204
>> +#define I3C_BG_WR_CTRL                       0x208
>> +#define I3C_BG_R_TT_LEN                      0x20c
>> +#define I3C_BG_X_CNT                 0x210
>> +#define I3C_BUS_MON_CTRL             0x214
>> +#define I3C_BUS_MON_ADDR             0x218
>> +#define I3C_BUS_MON_DATA             0x21c
>> +#define I3C_BUS_MON_DATA_MAK         0x220
>> +#define I3C_CLK_SLOW_DIV_CTRL                0x224
>> +#define I3C_BG_R_WCNT_CLR            0x228
>> +#define I3C_DEBUG_MODIFY             0x22c
>> +
>> +#define I3C_AO_CLK_SLOW_DIV_CTRL     0x300
>> +#define I3C_AO_FCLK_DIV_CTRL         0x304
>> +#define I3C_AO_FCLK_DIV_MASK         GENMASK(7, 0)
>> +#define I3C_AO_FCLK_DIV_EN           BIT(8)
>> +#define I3C_AO_FCLK_EN                       BIT(9)
>> +#define I3C_AO_DEBUG_MODIFY          0x308
>> +
>> +#define I3C_DEFAULT_FCLK_RATE                25000000UL
>> +
>> +struct amlogic_i3c_priv {
>> +     int num_clks;
>> +     struct clk_bulk_data *clks;
>> +};
>> +
>> +struct amlogic_i3c_drvdata {
>> +     int (*fclk_rate_init)(struct svc_i3c_master *master,
>> +                           struct clk *fclk, unsigned long rate);
>> +};
>> +
>> +static int default_i3c_fclk_rate_init(struct svc_i3c_master *master,
>> +                                   struct clk *fclk, unsigned long rate)
>> +{
>> +     int err;
>> +
>> +     err = clk_set_rate(fclk, rate);
>> +     if (err)
>> +             return dev_err_probe(master->dev, err,
>> +                                  "setting fast clock rate failed\n");
>> +
>> +     return 0;
>> +}
>> +
>> +static int ao_i3c_fclk_rate_init(struct svc_i3c_master *master,
>> +                              struct clk *fclk, unsigned long rate)
>> +{
>> +     unsigned int div_cnt, reg_val;
>> +     unsigned long fin_freq = clk_get_rate(fclk);
>> +
>> +     if (!fin_freq)
>> +             return dev_err_probe(master->dev, -EINVAL,
>> +                                  "can't get I3C fast clock rate\n");
>> +
>> +     div_cnt = div64_u64(fin_freq, rate);
>> +     if (!div_cnt || div_cnt > I3C_AO_FCLK_DIV_MASK)
>> +             return dev_err_probe(master->dev, -EINVAL,
>> +                                  "requested fast clock frequency too 
>> low\n");
>> +
>> +     reg_val = I3C_AO_FCLK_DIV_EN | I3C_AO_FCLK_EN | (div_cnt - 1);
>> +     writel(reg_val, master->regs + I3C_AO_FCLK_DIV_CTRL);
>> +
>> +     return 0;
>> +}
> 
> You could also create a clock divider, register it and use a common 
> clk_set_rate()
> for both setups.
> 

will do.

> Neil
> 
>> +
>> +static int amlogic_i3c_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     const struct amlogic_i3c_drvdata *data;
>> +     struct svc_i3c_master *master;
>> +     struct amlogic_i3c_priv *priv;
>> +     struct clk *fclk;
>> +     int ret, i;
>> +
>> +     master = svc_i3c_master_alloc(dev);
>> +     if (!master)
>> +             return -ENOMEM;
>> +
>> +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     master->drvdata = of_device_get_match_data(dev);
>> +     if (!master->drvdata)
>> +             return -EINVAL;
>> +
>> +     data = master->drvdata->bsp_data;
>> +     if (!data)
>> +             return -EINVAL;
>> +
>> +     master->regs = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(master->regs))
>> +             return PTR_ERR(master->regs);
>> +
>> +     master->irq = platform_get_irq(pdev, 0);
>> +     if (master->irq < 0)
>> +             return master->irq;
>> +
>> +     priv->num_clks = devm_clk_bulk_get_all(dev, &priv->clks);
>> +     if (priv->num_clks < 0)
>> +             return dev_err_probe(dev, -EINVAL, "can't get I3C 
>> clocks\n");
>> +
>> +     for (i = 0; i < priv->num_clks; i++) {
>> +             if (!strcmp(priv->clks[i].id, "fast_clk"))
>> +                     break;
>> +     }
>> +
>> +     if (i == priv->num_clks)
>> +             return dev_err_probe(dev, -EINVAL,
>> +                                  "can't get I3C peripheral clock\n");
>> +
>> +     if (IS_ERR(priv->clks[i].clk))
>> +             return PTR_ERR(priv->clks[i].clk);
>> +     fclk = priv->clks[i].clk;
>> +
>> +     ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "can't enable I3C 
>> clocks\n");
>> +
>> +     master->dev = dev;
>> +     master->bsp_priv = priv;
>> +     ret = data->fclk_rate_init(master, fclk, I3C_DEFAULT_FCLK_RATE);
>> +     if (ret)
>> +             goto err_disable_clks;
>> +     master->fclk_rate = I3C_DEFAULT_FCLK_RATE;
>> +
>> +     pm_runtime_set_autosuspend_delay(dev, SVC_I3C_PM_TIMEOUT_MS);
>> +     pm_runtime_use_autosuspend(dev);
>> +     pm_runtime_get_noresume(dev);
>> +     pm_runtime_set_active(dev);
>> +     pm_runtime_enable(dev);
>> +
>> +     ret = svc_i3c_master_probe(pdev, master);
>> +     if (ret)
>> +             goto rpm_disable;
>> +
>> +     platform_set_drvdata(pdev, master);
>> +     pm_runtime_put_autosuspend(dev);
>> +
>> +     return 0;
>> +
>> +rpm_disable:
>> +     pm_runtime_dont_use_autosuspend(dev);
>> +     pm_runtime_put_noidle(dev);
>> +     pm_runtime_disable(dev);
>> +     pm_runtime_set_suspended(dev);
>> +
>> +err_disable_clks:
>> +     clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>> +
>> +     return ret;
>> +}
>> +
>> +static void amlogic_i3c_remove(struct platform_device *pdev)
>> +{
>> +     struct svc_i3c_master *master = platform_get_drvdata(pdev);
>> +
>> +     svc_i3c_master_remove(master);
>> +
>> +     pm_runtime_dont_use_autosuspend(&pdev->dev);
>> +     pm_runtime_disable(&pdev->dev);
>> +}
>> +
>> +static int __maybe_unused amlogic_i3c_runtime_suspend(struct device 
>> *dev)
>> +{
>> +     struct svc_i3c_master *master = dev_get_drvdata(dev);
>> +     struct amlogic_i3c_priv *priv = master->bsp_priv;
>> +
>> +     svc_i3c_save_regs(master);
>> +     clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>> +     pinctrl_pm_select_sleep_state(dev);
>> +
>> +     return 0;
>> +}
>> +
>> +static int __maybe_unused amlogic_i3c_runtime_resume(struct device *dev)
>> +{
>> +     struct svc_i3c_master *master = dev_get_drvdata(dev);
>> +     struct amlogic_i3c_priv *priv = master->bsp_priv;
>> +     int ret;
>> +
>> +     pinctrl_pm_select_default_state(dev);
>> +     ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
>> +     if (ret)
>> +             return ret;
>> +
>> +     svc_i3c_restore_regs(master);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct dev_pm_ops amlogic_i3c_pm_ops = {
>> +     SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +                                   pm_runtime_force_resume)
>> +     SET_RUNTIME_PM_OPS(amlogic_i3c_runtime_suspend,
>> +                        amlogic_i3c_runtime_resume, NULL)
>> +};
>> +
>> +static const struct amlogic_i3c_drvdata amlogic_i3c_data = {
>> +     .fclk_rate_init = default_i3c_fclk_rate_init,
>> +};
>> +
>> +static const struct amlogic_i3c_drvdata amlogic_i3c_ao_data = {
>> +     .fclk_rate_init = ao_i3c_fclk_rate_init,
>> +};
>> +
>> +static const struct svc_i3c_drvdata amlogic_a9_drvdata = {
>> +     .quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
>> +             SVC_I3C_QUIRK_FALSE_SLVSTART |
>> +             SVC_I3C_QUIRK_DAA_CORRUPT,
>> +     .bsp_data = &amlogic_i3c_data,
>> +};
>> +
>> +static const struct svc_i3c_drvdata amlogic_a9_ao_drvdata = {
>> +     .quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
>> +             SVC_I3C_QUIRK_FALSE_SLVSTART |
>> +             SVC_I3C_QUIRK_DAA_CORRUPT,
>> +     .bsp_data = &amlogic_i3c_ao_data,
>> +};
>> +
>> +static const struct of_device_id amlogic_i3c_of_match_tbl[] = {
>> +     { .compatible = "amlogic,i3c-a9", .data = &amlogic_a9_drvdata },
>> +     { .compatible = "amlogic,i3c-ao-a9", .data = 
>> &amlogic_a9_ao_drvdata },
>> +     { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, amlogic_i3c_of_match_tbl);
>> +
>> +static struct platform_driver amlogic_i3c_master = {
>> +     .probe = amlogic_i3c_probe,
>> +     .remove = amlogic_i3c_remove,
>> +     .driver = {
>> +             .name = "amlogic-i3c-master",
>> +             .of_match_table = amlogic_i3c_of_match_tbl,
>> +             .pm = &amlogic_i3c_pm_ops,
>> +     },
>> +};
>> +module_platform_driver(amlogic_i3c_master);
>> +
>> +MODULE_AUTHOR("Junyi Zhao <junyi.zhao@amlogic.com>");
>> +MODULE_DESCRIPTION("Amlogic I3C master driver");
>> +MODULE_LICENSE("GPL");
>>

