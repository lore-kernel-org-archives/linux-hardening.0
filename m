Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793769536;
	b=unDY0p8AZ29JVZ8cNh2P5iNOrjsKYlJHhRX5EXy2IpQ2Oqasky5m34ZOjttGqsnmWJso
	 yTVU+crRV6v6GRiN5RIQ6QNYAH2drMqJKlDr1uqfMQ6+ciUFwgnURyulei/Wg+sFBpmZk
	 l//Bprgnw1oFuixZIdX4S2QOOTr0wShIF/2u7uMOxo9Mh675g1HSI9D4yHBy+Chjbl819
	 znc0p36gdM5SR84MDoncW8SeKdr4oQfU9sgX4qh8UzTRpRilX89YcEFp/AA6HOTUgpEpV
	 CMNjQ2RmKhzIDvNCHg/M1jUKEYKiZeuYM72S4WgXoFFLX++HvWoy96nwDMDnGALduTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769536;
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
	bh=3zw7mODbL60TzsxJg3cHiPzGSN6gF0uMBrvSx8x/wa8=;
	b=4S8AoSjcxO0Fxme3zWYnoBoig33Ngvnaig3qDvdX7qr6pWnXTU3MSHk/asT4SAI//s0v
	 TNCa16TKEkX1cHa9mBnbTdgd/H3QSUOOutEymg0M+/sSAiMwz1KNXZ4nLw7t/U0G8+CiQ
	 ySpxcHB4Xf8N3l318LgcGHaL6LckSVJuX5lAJ4MeYx2ijYJTgtXBxVwfEsRCV+f4NA0Dh
	 BvbM6QAE2iTJDoUoYbJaH9Bkq9GK54DDDnLmnho2oH/5fkAWgI1mRzgTixgBODs6hwp6Q
	 MWqX0mpNoF5oXqihGHF1eFMqwI+CzjIYQnk3TyUMKjoxaw/tYoG8fxuQVtwlQ9uvUFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=gkL3UzfT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.77
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023077.outbound.protection.outlook.com [40.107.44.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FD606A329;
	Wed,  4 Nov 2026 05:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 956FD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=gkL3UzfT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT51n5CHMhXcAbCiKeP3A2vDhbGYUHV+BxgQcIa1VQ5LTOYzCXHPEcI1oom71YEAivSlLYw8nZDsoxQ1C0Oe4I/hOKNtolLv7qm5rwDoyufQAINmL7oQrpv5hHdjCeAEO8qtsZ/Q4sPA+vNzXXKP1gZPCH9oNoF0TRwc/VxAu3OcsUbJpNanv09AxdShB2ws+BehKGSAJARK8GT3DkBXG+Zpjtgu2gKxSrasCXloc8F1y3bgL+3tMI3MU9eZyQLcXkJdjS2DBiOGuMB9Vq6FvS+Bsf0/683oAifEc1JlwTzkpR6HXs3FMiCBg5GKyQjAH3pIeXyklSXmcFC3+3scKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zw7mODbL60TzsxJg3cHiPzGSN6gF0uMBrvSx8x/wa8=;
 b=eL5cqWRpzJ6ZOba+QWptvNqqKvVlD8msigggQMGyY/OSi1Fx77peon5vQFyluHnqfXkG7h6UFXELaSqLebCJxjmpEQebQXMrzPnhlFpBj7vuBBZSmb2D3EeDci0jBo1k4KXv0hNb9xYF8gBcNKQ/uDf/lq1tHfFGTyHTGIe1cHQmVCIIu+fd1nU165GXoQYQy8yQd1oLwYnDTbGxUhNVkY7k+s+bGrURQkgSLQjq2VBp7ppmfThdTme0xAlO/npuQUbJ14znCR9FcnLCvsA8ktzPxNYuipMOjoFnmuMw3ttBvk5EAOPzhSZyhstCMu14eDPTBr/WRYyJW8nwbMJprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zw7mODbL60TzsxJg3cHiPzGSN6gF0uMBrvSx8x/wa8=;
 b=gkL3UzfTCgXkufcy6nEvPCQuB1eIUZI+FMg7F1WmOO6U7arJw+69uvwNinPj5+3sJbtXyXz6xwhmzw2VTwCjt9ua0nv+sO15WAnRXWHAuu/Ad/Kjmqz4H6ZE++cpbmf25WEq1t0FuctPeWEiib+4EdZJiOZ8M6oTo2StH0ShXuUqmsXyHKRKYkaT2CIeCPogaVGipbv7/Yghki7r7PoIcjT1q/uC6s9v2y1s23gw/5UitPgmFe+mY3d3q4F7ZONLWqPDeFm9eatlDXdUxCzUZaab4LbkhV+18tKZw+s4E3vIdi0BSqGXOvcwggyGbBGgOGn6V5E6pZHqTQkMxLZRQA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by SEZPR03MB6569.apcprd03.prod.outlook.com (2603:1096:101:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 05:18:50 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 05:18:49 +0000
Message-ID: <e2b65a8f-a1c3-47f6-896d-22884907d7b1@amlogic.com>
Date: Wed, 4 Nov 2026 13:18:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] i3c: master: svc: Add amlogic a9 support
To: Frank Li <Frank.li@oss.nxp.com>
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
 <20261102-a9_i3c-v2-1-0c474bfccffa@amlogic.com>
 <aukKRUYfEABgIruC@lizhi-Precision-Tower-5810>
 <2210c679-0577-49b9-b8c9-fffe1d88baed@amlogic.com>
 <auqkKAKRZZ0pA-R3@SMW015318>
Content-Language: en-GB
From: Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <auqkKAKRZZ0pA-R3@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To TYZPR03MB5743.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|SEZPR03MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: df342855-50f4-4565-6d2c-08df3a331bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|261102123227099003|11063799006|4143699003|56012099006|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NhcrMH284r1KyuDLas8MM18ijMVBzeYQ/LKCykFlw7FRLvuE0nCeME5Dqai5LxdUtClc9aaIq05cmV9TYF8+SG/68Txb7BGHNZWtD//h4SKSy0x8wmkO1dOX+5PHevbkFpZYdHvewl9zaSs2jAbaap2LtXnbYuXDrirbm+IlVy3tKRitPK5S86758+QFk4AbfITTCp+zVS3qhC88q9XCSJ4eLJBrwUwScQSTWv8ocWDDYFJFIJx6/tKxw6nBxSwLKNgwo4Q+FDI4Einby+F67r2BjvphTEFg48hP8gByjdYIdfAGgnffKTjEm4BDgaV0gPPjLywfpsUqfE4SRcCqyaFO/NtmSq5M/L8Yomn7MiRDab43/Np1to6zcWFQx0Kh/8ZHqK7Th1EpwB3hAd7jH/XOMeKmqgHRg0BJFDwMfW25aq3E5JWX/NAeTS3oXqhrO/CuagykSWlo+lKSnLbjS23NIlGHNU1OnHf+O/Bip24A9aGi8w3O96hSYn/9QbeHjq9vRDUmsIhV9TXMXjAMLYy9aP2Lw+WLLOVsAaTf49wbJ2V9VJFNDDGHIjBg4taRC7IfLe44D+aNbx9iRH+RXyOqUoSwXeQYOnbJvaAyUckOX5mbVVWkvzifeNvikQ0UgPdU3D7OdOss2lJotzHPX/kEzJxAqFHq0m/QMx8eULA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(261102123227099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmlNNmk0b015bzZhendlejN0a2ZvRjdpbk90Tk9YclA0VmdWRnAwT3orQVlw?=
 =?utf-8?B?Yy9nTW1ibkxkVVIrZFFxbGpuSHhKMkNvQlpZSWN2am4wM0JuR0hUc0l2MTVq?=
 =?utf-8?B?NVkvVW1SMDF4emVVZmZXZGZWeTczY1B1c0NMdVI4RXlqb0dqTTFYZkFERlRu?=
 =?utf-8?B?clhLenh2L2k4TXhickh2YVBZY2t1bS93dGNrZVVhYWs3dVBSb3NOTUdmVUR5?=
 =?utf-8?B?NUNzQmJEWFYyVDBxUitRRjNuSXEzVDVCb0gwN2J6VGh0akVDQnFna2hwWWZk?=
 =?utf-8?B?dHlubndhR1hOM290L28weFVCWklKR2RIT2liUjdYY3RMUEcxaC9OQzRwdDhP?=
 =?utf-8?B?Q1p0UWVDMmM2ZTZNeGFqMXBHMFRVU0pqdE1zc2tCSjlKblRWendSNWRTMjZ3?=
 =?utf-8?B?aTVUdzBTWmQ3UDBhV2E1L1FuUmxUcDhyUUtVOTVNRC9lWUxJbTBCQXlac3J4?=
 =?utf-8?B?bHdWdk96akNZTXNOL0lRWERFcFhkWThnbFJuVVhvMno0ZENIeVFjSms3ZHBL?=
 =?utf-8?B?cldLYW10eER6V3ZKS2JlNElkWTJic3pGcnJEeWxFM3NnZmQvckgxbEprc0Z6?=
 =?utf-8?B?Z1FsOWlMVTlXb2lwcUxCdFhrbDJQV1dCam5vd211MnFndS84cHNHQnh4V2R4?=
 =?utf-8?B?UEhCc0NuVzhoQWZDLzVLaGlacDRGVWFvQ3NXNVl3cTNGVkJsTnhaZFN5bThJ?=
 =?utf-8?B?c0hlakY0Mjlsd3NOejNvSEdiWUFFZ3pnNDA3QmhHN2lwWFBXbmR4aEx4NFNo?=
 =?utf-8?B?M1BVcFdhN3NEOUtYaGVhQlNZdm9oeFJHdUd0T2JSb3lMTzFRV2tYekFKWlUx?=
 =?utf-8?B?VDR3dlRONmpWMk54ekpIQW0zRTJQbHorYTJRQThKdEY1SHkycUt1QUx2RTZV?=
 =?utf-8?B?TlcwMGx2L1pVRktRSGFmaGJ4VUh6aWk3cG9wS0NlQU5jOWdSUndOU2pzeGRq?=
 =?utf-8?B?eXRrRVNNMHlITFNjZHpRcTFienhHM3hsaDlqUlJmYjZyUk5hc2VwYUxOUDUy?=
 =?utf-8?B?TzJ2OGMrcEdmeFRTcVNFd2NaMDJPZmQ4czJWaXoyVHErUkRCdGtxZUFSOHBP?=
 =?utf-8?B?ZldxMjkzMXJFMXR4YUhXdmNPRUI4RnM2bjNEMitWNXhFakVDcWxkVzZibTNt?=
 =?utf-8?B?c25PTlJzNWYvUnlNVVBpMGN3dUhNRHViSUFTQnlIeWJxOXRrTWN4YTJhN2Rt?=
 =?utf-8?B?Q3VkWmtlWEp2RWd2RmYwVG5oS21NNWI0bUUxZ0dEZVhjUTdhNVo0OVQzSFlF?=
 =?utf-8?B?eHliWFBkWHdHZ0VMYnowbkNJQWRrc2NtSzA3ZC9SWUxNUm1sZUxvMlBoSFpD?=
 =?utf-8?B?VnVTRldjMVl3Z0JDc1JXMmxsNWFFM2JISVdnY2NnYzdlNk5NOVVjRitPSGpJ?=
 =?utf-8?B?RUJiTjBZSzhGNVd1OTdlSXpCNmc4SlBMOERkSG4rakRRV3cxV0s0eDBzdXh0?=
 =?utf-8?B?K3c0TmJGV2xvWjRmS3RpelF2dVVGYWY3MExpd08yYmJla1BtSUpVSFRqM2RO?=
 =?utf-8?B?YXg4NEJPSDc4LzBmdDRNVjdlNStIVjFJd0RxSVMxZHdTYVR3S2ZQZlkxWGND?=
 =?utf-8?B?QzJsajlTTHhBb1NIeFV2RWVFQXkyOUlWZkZqcm1XL2NCQ29MNnVESmVFdkh0?=
 =?utf-8?B?dmxkd09vVEtUYUJ3dmE2VUJPR050RkNzM2d4bWJsNkp0ZDhBZFNKMnBYQi9z?=
 =?utf-8?B?ZDY1d2I4VFNOenhSbWhhVUQwQy91VFpUeFh0amJ2OFZNN3lGMHNmSkRHYWp6?=
 =?utf-8?B?d2xIamdaaEVoWmltUDlSZDBBaXBKUi9qZGR6WlR0TzYwYXN5RWtWOGtTdG1S?=
 =?utf-8?B?Q1pwQ3FDUDhxZUJGK2JqTU9ZQzVuS21EZ04yekYxRVdNeEg3ZmxoSGs1VlVk?=
 =?utf-8?B?RWsycTN1N2x2WHVVWGVNcDBqTEw1MTl0U3h4LzVTN0ZwZ3k0NzYwa1BYTFhX?=
 =?utf-8?B?NU93SVBuTFBuQzhrYk5sQ1Rua0ZQc1BoaDJMMVRVVUdIVjlDd0Jkbk52ajho?=
 =?utf-8?B?b3lHOHhyNDJwRFpFRzdrcm5GdThrVEFwRFlnWHVXaXMzazZtRmgxUlg2Vnpm?=
 =?utf-8?B?RWd2R2NWbzZYT2YzOGNRcDVzWmRKTzYwb3JnVmt4eWx2MU5HNE9aOUFTV2ds?=
 =?utf-8?B?ZEtxTVJ1aTMxaUFNT04zbVdFMENvNGhaSVg0Z2dxOHJkSm8wL3oxbzJDRE5N?=
 =?utf-8?B?UmVFU082MU1QZk9ZY01ycjZFT3Z2ZGEvSXE3bEhmVlBFYkY2WnZtazFkNmVj?=
 =?utf-8?B?MXJqUTA0WFZ0UTFsYzQ0U3RzQWhhTnZYazVQZzVjNUNTNSt5bUVsOUNwSlhr?=
 =?utf-8?B?aXlzbUpmMHRldkRGOFlkTFQwTHFvQmhuSE52azY5ZnBZRWRHSEREQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df342855-50f4-4565-6d2c-08df3a331bd7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 05:18:49.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv6POOZ1Skfw5P17xWvu+gaGVCogkZ9TmhDhiZdFJQ+AxYYX/p4phazTg5TuwMxnUwla1OL9ifzACZm7NRkXFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6569

Hi Frank,
	thanks for your detail.

On 04/11/2026 11:19, Frank Li wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed, Nov 04, 2026 at 10:44:59AM +0800, Junyi Zhao wrote:
>> Hi Frank,
>>
>> Thanks for the review.
>>
>> On 03/11/2026 06:10, Frank Li wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Mon, Nov 02, 2026 at 07:05:39PM +0800, Junyi Zhao wrote:
>>>> Amlogic a9 SoCs integrate the Silvaco I3C IP, and their peripheral
>>>> clocks vary from the vanilla implementation:
>>>>
>>>>     - The EE-domain controller (amlogic,a9-i3c) takes two clocks,
>>>>       "pclk" and "fast_clk", and the fast clock rate must be
>>>>       programmed before the controller can be used.
>>>>
>>>>     - The AO-domain controller (amlogic,a9-ao-i3c) exposes only "pclk":
>>>>       its bus clock is generated by an internal divider located in the
>>>>       controller's own register space.
>>>>
>>>> Add a vendor_init callback to handle this clock setup.
>>>> Add a vendor_quirks field to describe AO-specific behavior.
>>>>
>>>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>>>> ---
> ...
>>>> +     int (*vendor_init)(struct svc_i3c_master *master);
>>>> +};
>>>> +
>>>
>>> why need move this struct
>>
>> because callback need param struct svc_i3c_master *master， and if not，
>> compile error. undefined.
> 
> Most likely svc_i3c_master need save a point for drvdata in future.
> 
> You add forward declear before drvdata
> 
> struct svc_i3c_drvdata;
> 

will do.

>>
> ...
>>>> +static int aml_ao_i3c_tail_clocks(struct svc_i3c_master *master, struct clk *parent)
>>>> +{
>>>> +     struct device *dev = master->dev;
>>>> +     struct aml_i3c_ao_clk *ao;
>>>> +     struct clk_init_data init = {};
>>>> +     char name[64];
>>>> +     int ret;
>>>> +     struct clk_bulk_data *new_clks;
>>>> +     struct clk *fclk;
>>>
>>> keep revise Chemistry order
>>>
>> will change order：
>>        struct aml_i3c_ao_clk *ao;
>>        struct clk *fclk;
>>        struct clk_bulk_data *new_clks;
>>        struct device *dev = master->dev;
>>        struct clk_init_data init = {};
>>        char name[64];
>>        int ret;
> 
> 
> longest is first
> 
> struct device *dev = master->dev;
> struct clk_bulk_data *new_clks;
> struct clk_init_data init = {};
> struct aml_i3c_ao_clk *ao;
> struct clk *fclk;
> char name[64];
> int ret;
> 

will do. thanks the detail.

> 
> Frank

