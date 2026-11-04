Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793761020;
	b=CFBTPHKY+ffiUsFk5uTXj/18bU4TsJ79/eXwUf9aU8yyLbZU0mWETsPo8V4xIGe1Sv+e
	 t2LAu68rLwMttwJ1kiSfCMQPSF6FCPoslm61g6AIwoTspLAqM4K3Uchx+ks3iUkM48Omu
	 cUkA31lEBRjhMiAK6WQtmYMa8nJcRGNlI2kHve+5ZuPaNs8U+Dbd+yhsUKUo7Uf/5OSzR
	 hZA+yA0BOozQpTOOqfdwF2rPj/niCPP0PDeWzYFtRi3qSVCTrcOtt1wXNAyOvEsQDv/3t
	 d8u/feofjM6M0Un+M3tjlxU7nL4adXOuX03I68NMcaEv+tuSpNabd231MJZxK6GIF/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761020;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=8kTSHYe2PmDWTTe7hYxhWdiWvwV+RaQmp+hwD9PpEZ0=;
	b=sFhy326lr+8UaSm0Q8U6KzfRkKg8f5Vn4/u4ZtjaZL6J2tUzhMWfk/taM5gFpzMyjsTH
	 KbGQXA7L/mBaAvbQn3LQ5fviqSIK51CeYGVk7atyMRkzT3bJ5EcnoPuvnBNqBe+crsp+l
	 U8tcMTYqa55P/57RI8eCgrQQOx3UUqJxIpyGldC+OWEKco17TDVcDbHYuTLsPq2+Ce7Lx
	 mD9MYT3lLbuPMXfBMwp2+3euWpZTWdUkA2Nf2+YgEqSQJYRTOBU18iCuSI2jSFlX0pc5t
	 5Eq6mkCguu/8WSoFuJcsg4jITYsIznux6Vy4oKY0FimXVerVfNdeQnYYYW8k9sSzSTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=Xd6HgY2k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.124
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023124.outbound.protection.outlook.com [52.101.127.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CCB606A332;
	Wed,  4 Nov 2026 02:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1CCB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=Xd6HgY2k
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdmXeCVMHxFJN6ChWLT6/YpxgmmLfjeO1D5FiqC9lvTUtaICJ0Ylxw1J09/OdUxmwzk/h1As/A1Zjl3C6Yk1z6jULraRPkgP5IlzIhWMr+ri9MMoeWALjSENV7pgp2cke3fXmv+vo6OJwHMNPsLAw0wwcdn1rzqrNibvQmRCPb/mjw+bzUd2ydX03A9Qrp0HXzPz37zEYlGVFkH8QbonofJRRPk/9QeDSwVPnNQ9M9b9yvr43WV2de9e97JmnL+j1ci7hCj/PF6Yb3lPhVYC+A1gjHzdcoPLMk/H1YId8uInCkX/NF1D3Ut1n3cTCFw17/Vx+6JG29dPGshYOzoJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kTSHYe2PmDWTTe7hYxhWdiWvwV+RaQmp+hwD9PpEZ0=;
 b=ZLHi6L4nbypOMN9P/58+Ox4Ld0GQpgQGObpdHh36RoEN3C2b82Cewj32ogPuJ+KHJ/HeusGvrzhvgsGI8npFHMbeOo3faj3iCc7yByBphk2fd3Qp+NtJhi7IKc9wwzhFtDTL2rcOKMz8u38nSH9nkXUCcwGhFJgsN+7HxuJN+UtM1bySlY+VYROyXzxfNx6NxCK+zn7bNkr0EEtp0DIwrblNUalGpy7LmcYbuRz35nAVzyRQ2bj3D+GV13fkpG6ibwtEIhzsHUqTMlC6aKwxx2CnllPu3DroxOV5HPKXjFIFYfAbFVnYvynp6IrSxnydfHT9HIOaw/cdiE2FUbOXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kTSHYe2PmDWTTe7hYxhWdiWvwV+RaQmp+hwD9PpEZ0=;
 b=Xd6HgY2kmeIkow/BNP2EHCneyBVMtCqMMXTpWXjrDxwhfRlpMdROdmKR0nLJQsLJpglohHo0yNbre9JbqzEQxMAgWuMOkgfHozrUslR7lzFPLitSgOKsbvJWQwg+kde9HSkXRFO1HI/yo6OzT2R5kRpHvkv5kuPPlQIv9Y7sCw0FH1ToznDLy0To1mI5EBTBqc0HXC0wXSGD2PCkBFpMKxCrtyJz4Db+mn9g+VQfTczJAKPqu1QIXdrRqfAe96fHPblZDn4ilnyQP2MSnBInhV26vDZfGrePr8amfXbQP7+9RC1SFSSm8N5UlsxkmacdLC3bVW/ly0sPMsOuDXi/IQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by TY8PR03MB10498.apcprd03.prod.outlook.com (2603:1096:405:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 02:56:56 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 02:56:56 +0000
Message-ID: <811e78bf-7d5c-43ad-885d-0573e25e3d81@amlogic.com>
Date: Wed, 4 Nov 2026 10:56:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: i3c: silvaco,i3c-master: Add Amlogic
 A9 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
 linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com,
 Kelvin.Zhang@amlogic.com
References: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
 <20261102-a9_i3c-v2-2-0c474bfccffa@amlogic.com>
 <20261103-emotional-objective-jaybird-0627b5@quoll>
Content-Language: en-GB
From: Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <20261103-emotional-objective-jaybird-0627b5@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:990:4::6) To TYZPR03MB5743.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|TY8PR03MB10498:EE_
X-MS-Office365-Filtering-Correlation-Id: 140244b6-20c0-447a-66a6-08df3a1f4982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	CQvLIjVVLZ9nI0NbooPpwo3nLuEZcY8VgrNpi2JF1s5NhLs0oSUhGa9sfwpNo9ShJdUOQ/C5N5j4KODp5hXTqMbo2kLzsMgWMNUbJ4uztn35O1fHBqBvmRSmcbbxFuYaPK5eDy36m6sEasNIifFTGYR5sUdrMcvAHjp/c3OY5fgaRDKPNceqL+69abnBiVv3LvKT/TJn5LfZAS25MsEvectWZk23210gX4sMv9aUuw2fxewdCFW4RaPQzuLDjw6ZRPMj1t1uwDq2E5qU3fM3M4LQ5D2jqAVkGgEYfPNjJmT9ZDDG8m02SMGSiwYU9DF9fZZXRY4O9mq4q/f34+5uX3qs6nqjXG6vLCB3vrBpAOqe+oEn5NvOQnw8eCzT4syfPohCMaLU4PKSMTHV1kMqlg/a/kujgmlpb3q7GEVf94GL/0LQx44jZkQtc62IfQjIdRoPqSQjIPITp6p6GO52u/AEsHzaF9WXa+CEMFkIhrk9F7Ka6r7f7Sa/zQVJcPbQN4q7OW30K0azJK0P7t+XRMREV0f5fWVJ7NUgNN6LwjYu3KyENuYWwPkQkAkYtoqhUkX8xdj6qRRFXC9rhbSWWJdejjHuJsMH06iZ8tkxQTqjjQNP0lRzHZ5Qd99f8g4fWa/z/ngztb4stNP5ApvMDbEbehzyDM7w+8WtIjv44Pk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnhNRTVtZFpwdTk2MC9Rb09MQm5Laml2aW1zYjNMOXJzdENPSlRHbTV4UXF4?=
 =?utf-8?B?cGdMS0dWVi83RUZBTFdCcDk5eUlkczdaa1M4L2lGcUlsd2ZkT2Y2MGs3bS90?=
 =?utf-8?B?RlpFekFXMzhjN29QSmQ3VEcyajlxMUxSY01HQnpQTVdmUkVDRFkwaFJFc2FR?=
 =?utf-8?B?OVBueHYzRzF5c1VFOHJjL1R3WFQyZE1zTkpRU3VSYnRIWVVWV284cU5PLzhI?=
 =?utf-8?B?RllBUytRY2hTcFBna2M2MUlaYTlwV0I1RHFiUVVyOEZZZzErTjBXNVBTTEdS?=
 =?utf-8?B?NmFaakdZV2lwa2NhNFJrNDl2dFBGWG9uZTVhSkFGcVA2VGJjMUtMNzhBYWVp?=
 =?utf-8?B?clFCNFNHS0tLdnZPK3kyQ05IWnEvU1d4MzRmMU5jdTQvWXRLdC9Bb2RTTVRC?=
 =?utf-8?B?TzRuVUZNc3BaQ0E3d2JiT3ROYWlRRUxyZS9Tek1nM3pQNlVHMWRRVk1lSytI?=
 =?utf-8?B?QzV5QVV5M1NtWFB3N3l0eVpxNE9LR0U3dWpHT1ZURytKODJocnRkZnZwS0tx?=
 =?utf-8?B?U2JOejJpai83aXl3QXJJUGp3YlJiQ0p5aXdKdzBPaE5SYnFwbnp4dUplUlNj?=
 =?utf-8?B?TFJ4U0YvVStmS3FQZkxJQmtmaWEwa1hOU0dhM0E2MU5jcFFXRVRMZnR1Y0F5?=
 =?utf-8?B?SjczL0FTUS9meHR6LzdodEdhS2FvMWhnWTgyenVYS2orREdmbFRzZER4M00z?=
 =?utf-8?B?UWVvYTZDNWxmTHNUZFJHVTlNSG02S3FuYXBzNDMzZTFMY0xXQ0dtN21vRmkr?=
 =?utf-8?B?L2liM1BjOVQ0WUpsWGorSGpSK291OVVkTVI0UWZzdE9WVWZFTzdJaXBrMStt?=
 =?utf-8?B?YUJJbjVXZTZtTzBPcHBvbmNkSXdUbmxhd1BPTmZmT0RXd0IrRThvblpzMVBX?=
 =?utf-8?B?QUFkVlY3U3E2WndWU2NRNWRqMGhsK0hPTktpblU4Wmo0aWtvMGVTMXNUZUl3?=
 =?utf-8?B?M3c3Sm8zOVB0ZU14Zms0bkZaWU8rcjZOeXlCcFR1d1dVVU1iUVVWRjQ1cjRN?=
 =?utf-8?B?NWVNNEZCbFB5YTEzS0gwSFA5MEgrQUozelIrTGFtY1o5a2NLb21jbVVDd3pj?=
 =?utf-8?B?dkdpTXBLa3ZkeW5MSUdsditMV0svVnoyQkUzbnJ6Z3hmTTRtUVFNcmh6NXdU?=
 =?utf-8?B?ZzRPSERybk5ZNk1DajAyVUQrUEhzZWt1QUhRVHUxeTFscFVhV2RJZHN6dm1u?=
 =?utf-8?B?KzlKT3B2Q2NoNFZ5d1J5dVU5Tk42cUFoblFSS1JGR3JCZnNvV21tcVNYQUZV?=
 =?utf-8?B?QitMOUIxUUw3bHdTMFNxOVcwY210ME5wblFmTUU1d2RpQVo3cjdzODBwNFhB?=
 =?utf-8?B?T01uckNla0JvQXpTU3p3bllxZEJCdEk0SVJJcmxzcER4VVJhckF6cWROL0VN?=
 =?utf-8?B?N2s1YndmNFBtVmc5bTNEMGI3QzNQNzcyTVJQRzNDYjVwQUNpdUM4TEdJYVB2?=
 =?utf-8?B?ZmUwbGQ1NWUwUHBIak40VHhydmNHQ08rTkJkcEM1UzRoVDFiMzRuVnhRTHNW?=
 =?utf-8?B?ZEpmZ3FlOWdUMy94ZDQyL2RGS21zTEp4am5DeVVvbW1mU1lURVdUak1YV0Vx?=
 =?utf-8?B?MDZxV2pySy9xc3RrdFYwQmQzbFlubHhReDFmTHRpc2VuZjF3SUhrSGlWQWt1?=
 =?utf-8?B?a0tqNzZMYU1SN2xCTFdidnFPR0VISy9zSzZ2ZG91UXZ5YmpYM2RnYWlXZm04?=
 =?utf-8?B?Uy9KSTl2VXc4cEJDRlpjMm9NVnJWZ1ZVdUtpMnp5NUpjVHV0MEF5d0xFRm5u?=
 =?utf-8?B?VURCWXkyUDg5cGpIaXQwRUV2eVhwUVdYajkvTVNMaUwzdGNPQnVQbjExTDVy?=
 =?utf-8?B?TmRURlJOcWNXMmJsRmJ6SWNyRjhQbHdkQmZZRkNldGJVY1FKa0xjRVMreXZ5?=
 =?utf-8?B?L0J6a0ZSRitKQWx1UXNnYzhTOEVtTE5SblNISUtUcGpWY0o0aWJtQjhndHFw?=
 =?utf-8?B?ckhqSjFCYUoxUWhqZ21LVHVJRHNxNFp2UVdKbFlld3NNUldTblNUQVIra0JP?=
 =?utf-8?B?UXhOQVMycmxTWXNuN1ZjYUxDZFdvRUw5NE41UmZnUkV4U3RDRDJVM1pnWlp6?=
 =?utf-8?B?Ri8rMHVBQTZYYkorcDJKb3AvVzFSK1Y1TGVhZUFWRXVEeDc0NVpuZnFsOXFk?=
 =?utf-8?B?ekZqUkxqYm00Z09SQVBpUkt2YnJqakI4Q1V1cVhvQXJLV2RGaW51a3FMbjEy?=
 =?utf-8?B?aEc3UWFnbTZPaDhuZzJQcnk2eDVzSC80Y09rYi9RMWNFcW1Bc0EzNUh6UHBR?=
 =?utf-8?B?TjBmejk0SlVlbUE1QjdDdVlHY1hGODNpdDcwbUJrNHQ1cjlDQXNGNUY2L2Ny?=
 =?utf-8?B?MjlQMTR1MjNDSFdWNG04TnZVK0g2cmsvcUFoMVVqL1VaVERxTHJQQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140244b6-20c0-447a-66a6-08df3a1f4982
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 02:56:56.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cg0nLALjXQVN60c/tnZyjjoCzOZgPBoBcsME8JwgmLduiNYXEwDJu9rLEwnqZczFNeTtH7CMFtALkbrlYkAj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR03MB10498

Hi Krzysztof,
     Thanks for your review.

On 03/11/2026 19:42, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On Mon, Nov 02, 2026 at 07:05:40PM +0800, Junyi Zhao wrote:
>> Amlogic A9 SoCs integrate the Silvaco I3C IP with two controller
>> instances:
>>
>>    - amlogic,a9-i3c for the EE domain, which takes two clocks,
>>      "pclk" and "fast_clk" like the NXP variants;
>>
>>    - amlogic,a9-ao-i3c for the Always-On (AO) domain, which exposes
>>      only "pclk": its bus clock is generated by an internal divider
>>      located in the controller's own register space.
>>
>> Allow both compatibles with the "silvaco,i3c-master-v1" fallback and
>> enforce the per-variant clock counts.
> 
> This we see in the diff, but we do not see WHY.

i will add a description of the I3C peripheral integratation detail at

hardware-level.

> 
> Best regards,
> Krzysztof
> 

