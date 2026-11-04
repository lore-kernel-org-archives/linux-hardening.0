Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760309;
	b=5DMA9wuATkutZO+jPWX9pWdUr1XEnFKwyhn9lOpgeZeRqXMxtuE2aANmYfZHTtPuTbs9
	 ToqsfbI0GjUtWXbNulpJRylxkoA7Z136+g4GOk48AtIQiNk1SOZP2y6UY2s47TqrOsV6D
	 5HRHhqk2evibC1FGU8Y6y9Rk3+e2BSimM+Jaq7d73JyWpJ5osq/QZ0cietZ+MgGD0gLD8
	 2mqy+Nf7mmkJWs5JppLbJelgGzO58c4pbR6v05w1MZ3wIyydHzVNK68rAIp4yCboYFMlN
	 PAaH7nhFAAf1kcFjS+eipquNsiUnicmIRdb/palTYf2EuF0su4/bgcfS6jdNeW5HS6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760309;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
	bh=xH8Q1RuxlusIDCm2TPFXSzx0V5XzVkSLxF1iwoFhMX0=;
	b=OGDTJizDve1ET6nt39E6h10jX/4PKEISSX5qhSr8TJ0EPF/v4+PBuLJvSzT4agG8D29j
	 OUm2CGZuP51GkTUE1W9Iwwxz+ZoohhgXoLkC38F96T1xN4i9bVm3QXpvdjO4VVE/xAa+t
	 AmJSDWmmmVgtnw/iXvyBEYeo9/+y53XOB/r0jHclFREmv9iXyvICQR3B5xLIESW3FIsh2
	 lBKO1RutewAkMWlNUOhzn5wjHEKn/SS386A0lnNU/ZAzwcO7li8JSoQii+QWp5kciRq7o
	 DZWljlZas3urk5isrdMk8+OZQDyg6U5cp1RB8BuaZF/u9uK1pjrygGZx5/4DGBZxCKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=glOU1Ea0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.140
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023140.outbound.protection.outlook.com [40.107.44.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320E0606A331;
	Wed,  4 Nov 2026 02:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320E0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=glOU1Ea0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saU9WTiwVfUSHP1FuPrn5nGNppZGlgTWmRyJ3vP0kAGbNZAS+BF7ohrVkPxYGp42Gc9gHBDDcp2ghD4Ut1iGCXbNaIJHPVkfCAs8ttefXtJSvNUFginGAgRlBXZvWFWTbo7YSnChLXyln0nNJRadD0Qp2CsGrtWv+Ac/ZUu0ISVK1Twk3n3inYAqmesM5NEsfps2UR+oMJfnSuZLLHEt70veDuLo0GMh+2Gk7l8wQVtBSBxS4Oq+17s7ZWSgVS0HU7RdKA+aAUC+MWRSZtjfSXaOi4udA3wlG747UGyqXdgAKX4bn1UgeoCMFQx+/je/x1FOsqwJqKXWAkNAaeMuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH8Q1RuxlusIDCm2TPFXSzx0V5XzVkSLxF1iwoFhMX0=;
 b=jI6c9SUi5I70ZS4XRfogE2FSKsyZjlipuGZGrzdGhy20r1Sjj1bmvAh38kl9WnV5Q7zpK9NyJKG49+kSNmIhqMdfu6bQxvdto9JE0YN22GGiMviSbnEfVkeYUkqqyX5mRW7ZyC8ok55ymQnpc7Y2UHAyTfodRfTaptM/ZlhetNMti8BjwtgOgXOcsWXWYkqlXmeeVUuc64LOazuYSkE+SJQZGEv0iyTOvLpENXFrAeyYnszrrjELT7mVFUEO87OBtqwvPG/01JUFSusGBA1TqQ9NCpSq8F1Dhz6S2CBon4ak4BPnTOpXLZs01mhOy/xzwW4dCjI25cwyMYHVbpcgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH8Q1RuxlusIDCm2TPFXSzx0V5XzVkSLxF1iwoFhMX0=;
 b=glOU1Ea0w3PSR4Z6l/o3REfqVtpgDK51Phz8FTYMFPzGvqXlEagVD66q1SgXmxJdVWaXLT3MlG1EFlhnKbjBkky+hDRbiIRBSbdg/8kli5np7LoIB61f1Q4wqJeV99GeElREXkSgBCIrduKhB4dCydbGus8EUVHQE0+1mmhyagZJTfxSSadSsi8zk+E5GKkQHFA8dV5dkmUNpMMjILw2C7wD8+KN9jOG8OM2Vxw6Uox+Sj10CJ7yYxo6c1Rxy/XQAUz9aigpBK1T1ZsCd1W8gZUfm16fTCA6T37TbrKTS6ZMLWJfbGbTZEaXVr3GgpzdhwoINiAadCuJrOiG4ROFaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by TY0PR03MB6882.apcprd03.prod.outlook.com (2603:1096:400:265::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 02:45:04 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 02:45:04 +0000
Message-ID: <2210c679-0577-49b9-b8c9-fffe1d88baed@amlogic.com>
Date: Wed, 4 Nov 2026 10:44:59 +0800
User-Agent: Mozilla Thunderbird
From: Junyi Zhao <junyi.zhao@amlogic.com>
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
Content-Language: en-GB
In-Reply-To: <aukKRUYfEABgIruC@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:990:4::15) To TYZPR03MB5743.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|TY0PR03MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 12232d74-bea2-4a3c-65e3-08df3a1da123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|11063799006|56012099006|261021121427099003|261021123027099003|261021130227099003|261021135927099003|261009221227099003|261021133027099003|261009223027099003|261022115727099003|261022105027099003|261102123227099003|261022075727099003|261022113327099003|261026130827099003|261026121527099003|261028144727099003|261026135527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	C0qJry7rT7mMwjbjvG7ovxY7T8aWxeYURokR7/d8Jw4sEm5MQfCLdVDKI3CK2jF87WMx0nmT//tuQOTFxDz+GFeBG/z0bhLiUusaF9QiL1MYFYewWEoW24EJBgU3DK7ntyGu/eICpGmBEK1wPO4n81vkwkQuoJ/F7KFTQoRFzUxqIbzub/p5MIF0XXbaUpxnrYQ0S2CrhDX5UlrulIfLkNdYtp1lNpT/YjwU3H3ODXqXWYKC9dnZDvrT+JCQnpyVZebVmQc0wbohA+xvvcsYc6BtA04BvzJLUSzi9UtbWJKygepvUkevgFZRNZN2842ogGQrfRfxunzBybChgP5rydbyIDEkXv2MEDvMcRcsac6WYtjfu+oApfSKTD7OPk1Cz3Ab8oeRR1RQeev0uiy4/btDZI/MAu09gGqUs2HsO4wepij2Qnz9un6KS8lZjjzkKgjBGW6zZ+BZTdpJ8i0LO5UHsCqk5kxW8qCIY3Fmd+f2Y6hd8yA1G4ZZyJYw0jZA0r3C0zpmn0/6km71YhmlgeIdHpN33rWwa2oTVkO0dzwG9BbLiuxFf0/9sOVQeuUEspHyyj/dNqJS991Pkk4zpsdTLKJZiCYnEEgw4N458evNmm8V72ZZqrJcrysNMW3zGO1ksxsqPtC1+kN/4VEnalAu6H4waSDD5C0zfkvTxYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261021130227099003)(261021135927099003)(261009221227099003)(261021133027099003)(261009223027099003)(261022115727099003)(261022105027099003)(261102123227099003)(261022075727099003)(261022113327099003)(261026130827099003)(261026121527099003)(261028144727099003)(261026135527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0JmYXFQbUZjbEowRmFYc1d5T1hlR0M2eXhzSGNkTFhzQnk0WlhHcGZLazRF?=
 =?utf-8?B?SGJqNU80RnZpdGNKaWxLbmlSWHhpbFBjUWhQOWl6ZC9NRTZGUlJFcTh1T2w4?=
 =?utf-8?B?TWgrbVYyUGdNcjF2TDdjRFJVM29la0lHMDF1RDFYM0JOTTlJZ2ZFUi91MjlJ?=
 =?utf-8?B?YW1PaTEyMFhlekpTQ3BFMEFhVVZwQmdydTNpdWNST09hNnVwcnp2T3k1Zkw4?=
 =?utf-8?B?TmFmaGJFbmVRZTZHY3JIZnJZUndiYi9uUy9PTDBsMnB0NHJxUTRTNDBTbkpP?=
 =?utf-8?B?dm5UeDlaOFY2WGFQYS9SQm9qdEh0ZFg4ZWk4d2FESCt5WUJMbTRnSXpVNnQ0?=
 =?utf-8?B?MEpsNXg5b0VRTEpNcWdYdklQaGdqMHdqTGJrOWladVBFTnRzcy90ZVBzVjdN?=
 =?utf-8?B?KzE2UkZqaHlIcFRuSkFvZzROUVFFRldPMUtLTHcycHhSeWFQcys4TEtCRWJ2?=
 =?utf-8?B?SkppcDV4Q0hITUVQSXZ6eDAzVmgyQU9abnRobVlDbGRTQUU4YXRTbk14YjNF?=
 =?utf-8?B?Z3gwV0tWNVFpckErVXc5OGZLSmpUS2wvMy9xTTFSK3pLTXg3TG05MmticDBh?=
 =?utf-8?B?U2RNbHpqa21WdTJaVExhcytTMHVGZkVscXArTXB3aklZRGJWTHkrZkZmWnZn?=
 =?utf-8?B?d1Rhd2J2eDQ3L2hhYTZHUThWS1dUbjBqdzJrOU56a29WdlU3Umx4TENzcFZP?=
 =?utf-8?B?TWpVTFUvVHJzanIzRnFvQ2lvamwvV0RxNUlNSGVuRzR2UFdxc2Zvd0p2OFA5?=
 =?utf-8?B?YzFxcjdNWSt6R2tqNW84dll6U01NRWRpczE3YWVqOUQ2ejJ5Sm9mdzRMSmxI?=
 =?utf-8?B?ei9xQVZzY0M2NTJackVLNjZ5cHYvUUlmdjd5aGlrZUZ3Ynp5dk5BVnNYcklS?=
 =?utf-8?B?WGZYWEJBZWF1SmFWYklBb3AvMGVJQk93SnlaNDBEOVVsb0FKbTJwcmd4Nmky?=
 =?utf-8?B?eW95L0hqSk1Za2pMQUc3RnloWmQvZmdNZ091OGdydkRKQVFKYWlvSWJ5empt?=
 =?utf-8?B?cDh2WS9lR0M0SlVpamRaWHBCWWtpVzQrRExLbURhZCtnYWZjYUp6WFg4MGd0?=
 =?utf-8?B?Q3RLb1hWSjhQbHMyRVhRZUVKRlhZVEVJSHhRWWxNeXNBeHhVLzlWeUZ2U09a?=
 =?utf-8?B?OXhaRXRnVVdiY1pXODJaLzNjUHJQc3RGdTJTdzgzdlM4eXhrc2czdE15SFVM?=
 =?utf-8?B?WXBlNE9QMjlnbnlveWdpK21pODA0SU9KMjVldzRaUHhtYkJYOHdEZXhtNUhM?=
 =?utf-8?B?SnhTUE80L2xTK3FRaHFRbnZSWnF2aFJBMWtwZXdhdVNEOHdVVUpmSjNzYm1X?=
 =?utf-8?B?UFJ6V3gvZWZBMVdKNmMvU2lPU3hGZmVFQndnZzhBUjlzNkpDQmF0Mi9sdFU3?=
 =?utf-8?B?eDA1dEtmc1JCcUdlcUYvZ1NTZ1c3VHNYV05obVFNVUVoeFQ3WStZV1kvRXFV?=
 =?utf-8?B?aFNFc0tYSWE2bVltMHNaSmFIQkRDY0RZRkpSc3hFL2ZZMnYwbUFZSjJYdGRU?=
 =?utf-8?B?bGYzVHVvTy9GN1gwMWpEV01KRVBXUWhyNklnVUNBMWpHM0hwNzJOVVVZNS9w?=
 =?utf-8?B?WW9QVGFsR3NacVpGNVVtdHFMLy9XL1VoS09ENGQzRmE2ZUhZOUpYazlXZXZB?=
 =?utf-8?B?WVNKUDlVVEtvbWcrb2tyVkl6YWc1ZWx2Ymd1cVc0OVczb3NTbVJQWkhSUVBr?=
 =?utf-8?B?OGhVM20xUU9VdDc2ajhuOGllY3hzTC9DYkdvV0owZGJQcHZpQzNneVdWRUQ4?=
 =?utf-8?B?Y0hjOHBoYlVad1V1Yit0WUNDQzZuSE1JcUtIM1BHZHZUbTBOb1BtSGExSnIr?=
 =?utf-8?B?Q2djaG1nS3pJdnZKc0lOU3IzMHdML3VOM3NvSXdGV0hiZUllbVAyYllYWWNW?=
 =?utf-8?B?RjNlM2xLM3VLaENpMTJmMThLN3NXNnhpbGo2NldvMlltQlRidE9Sb0E4NERD?=
 =?utf-8?B?aVhLSHZNS0IvbW96Q295VEMrTzlDcGppV1k3YlpxdDFSREpCem5mQTlQSEdR?=
 =?utf-8?B?a0REQStqVjhTQ2xDdHk5Y2ZhVnhZZ0VieGpubFhvakw5cFBsNGk3U29xMm9U?=
 =?utf-8?B?U1dweE1oYWJ1OUNKVDZMd0VXdmtIdE9zSVNXNm5GM1QwTmlmMFVtOW4yWk9v?=
 =?utf-8?B?Y2JEVi91T3VPdEwxSHFWWEVycnVXcUNkbmFydlQwdHZiRCsxd1lnOHF4d2FT?=
 =?utf-8?B?aVJLVnBHRXRQY2Z3YkxjUkRCWFBBQzEveG13M0s0Y0xuRXd4a0ZCVGYvcDRS?=
 =?utf-8?B?U3NPRUc0ekp0NmRZQThLdlBHaDRHRDloVXg4TzUyK29SNEhHajY3WEpoNVEy?=
 =?utf-8?B?anY4TzVza0p5RUxxbmRCSnJjUVMxT1E5ckU4bVdlTm51M1R1NmZvdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12232d74-bea2-4a3c-65e3-08df3a1da123
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 02:45:04.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8UtF/hadDRLut4mrPwudk4BekAc10GLUEnwSXssnGZwU28tiN6YdePA0I1f6gCkF6yBL/pWxohTp77YpdXbug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6882

Hi Frank,

Thanks for the review.

On 03/11/2026 06:10, Frank Li wrote:
> [ EXTERNAL EMAIL ]
> 
> On Mon, Nov 02, 2026 at 07:05:39PM +0800, Junyi Zhao wrote:
>> Amlogic a9 SoCs integrate the Silvaco I3C IP, and their peripheral
>> clocks vary from the vanilla implementation:
>>
>>    - The EE-domain controller (amlogic,a9-i3c) takes two clocks,
>>      "pclk" and "fast_clk", and the fast clock rate must be
>>      programmed before the controller can be used.
>>
>>    - The AO-domain controller (amlogic,a9-ao-i3c) exposes only "pclk":
>>      its bus clock is generated by an internal divider located in the
>>      controller's own register space.
>>
>> Add a vendor_init callback to handle this clock setup.
>> Add a vendor_quirks field to describe AO-specific behavior.
>>
>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>> ---
>>   drivers/i3c/master/svc-i3c-master.c | 214 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 209 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
>> index e700392f0..98aa6eb0f 100644
>> --- a/drivers/i3c/master/svc-i3c-master.c
>> +++ b/drivers/i3c/master/svc-i3c-master.c
>> @@ -9,6 +9,7 @@
>>
>>   #include <linux/bitfield.h>
>>   #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>>   #include <linux/completion.h>
>>   #include <linux/errno.h>
>>   #include <linux/i3c/master.h>
>> @@ -166,6 +167,21 @@
>>    */
>>   #define SVC_I3C_QUIRK_DAA_CORRUPT    BIT(2)
>>
>> +/* Amlogic specific registers */
>> +#define AML_AO_I3C_FCLK_DIV_CTRL             0x304
>> +#define AML_AO_I3C_FCLK_DIV_EN_SHIFT         8
>> +#define AML_AO_I3C_FCLK_DIV_SHIFT            0
>> +#define AML_AO_I3C_FCLK_DIV_WIDTH            8
>> +#define AML_AO_I3C_FCLK_EN_SHIFT             9
>> +
>> +/*
>> + * AML_I3C_QUIRK_AO:
>> + * AO is the Always-On domain on Amlogic SoCs (remains powered in suspend).
>> + * Its clock is generated by an internal divider located in the I3C
>> + * controller own register space.
>> + */
>> +#define AML_I3C_QUIRK_AO     BIT(0)
>> +
> 
> There are not much quick now, just put after SVC_I3C_QUIRK_DAA_CORRUPT
> 
> #define AML_I3C_QUIRK_AO     BIT(3)
> 
> use a unified quirk define.

will do.

> 
>>   struct svc_i3c_cmd {
>>        u8 addr;
>>        union {
>> @@ -195,10 +211,6 @@ struct svc_i3c_regs_save {
>>        u32 mdynaddr;
>>   };
>>
>> -struct svc_i3c_drvdata {
>> -     u32 quirks;
>> -};
>> -
>>   /**
>>    * struct svc_i3c_master - Silvaco I3C Master structure
>>    * @base: I3C master controller
>> @@ -257,6 +269,12 @@ struct svc_i3c_master {
>>        u32 mctrl_config;
>>   };
>>
>> +struct svc_i3c_drvdata {
>> +     u32 quirks;
>> +     u32 vendor_quirks;
> 
> Needn't this, direct use quirks

will do.

>> +     int (*vendor_init)(struct svc_i3c_master *master);
>> +};
>> +
> 
> why need move this struct

because callback need param struct svc_i3c_master *master， and if not， 
compile error. undefined.

> 
>>   /**
>>    * struct svc_i3c_i2c_dev_data - Device specific data
>>    * @index: Index in the master tables corresponding to this device
>> @@ -274,6 +292,11 @@ static inline bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
>>        return (master->drvdata->quirks & quirk);
>>   }
>>
>> +static inline bool vendor_has_quirk(struct svc_i3c_master *master, u32 quirk)
>> +{
>> +     return (master->drvdata->vendor_quirks & quirk);
>> +}
>> +
> 
> Needn't this one

will delete it.

>>   static inline bool svc_has_daa_corrupt(struct svc_i3c_master *master)
>>   {
>>        return ((master->drvdata->quirks & SVC_I3C_QUIRK_DAA_CORRUPT) &&
>> @@ -2011,6 +2034,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>>        if (!master->drvdata)
>>                return -EINVAL;
>>
>> +     master->dev = dev;
>>        master->regs = devm_platform_ioremap_resource(pdev, 0);
>>        if (IS_ERR(master->regs))
>>                return PTR_ERR(master->regs);
>> @@ -2019,6 +2043,12 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>>        if (master->num_clks < 0)
>>                return dev_err_probe(dev, -EINVAL, "can't get I3C clocks\n");
>>
>> +     if (master->drvdata->vendor_init) {
>> +             ret = master->drvdata->vendor_init(master);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>>        for (i = 0; i < master->num_clks; i++) {
>>                if (!strcmp(master->clks[i].id, "fast_clk"))
>>                        break;
>> @@ -2036,7 +2066,6 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>>        if (master->irq < 0)
>>                return master->irq;
>>
>> -     master->dev = dev;
>>        ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
>>        if (ret)
>>                return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
>> @@ -2163,9 +2192,184 @@ static const struct svc_i3c_drvdata npcm845_drvdata = {
>>
>>   static const struct svc_i3c_drvdata svc_default_drvdata = {};
>>
>> +/*
>> + * Container for the tail clocks of the AO domain variant. The clock HW
>> + * structures are registered with the clock framework and must stay alive
>> + * for the whole driver lifetime, so they are kept along with the shared
>> + * lock used by their gate/divider operations.
>> + */
>> +struct aml_i3c_ao_clk {
>> +     struct clk_gate div_en;
>> +     struct clk_divider div;
>> +     struct clk_gate gate;
>> +     spinlock_t lock;
>> +};
>> +
>> +/*
>> + * aml_ao_i3c_tail_clocks - register the internal divider chain that
>> + * produces the AO variant's fast_clk, and append it to the clk bulk
>> + * array as "fast_clk".  @parent must be "pclk", the only clock the AO
>> + * variant exposes (see silvaco,i3c-master.yaml).
>> + */
> 
> use kernel doc format.

  will change.

>> +static int aml_ao_i3c_tail_clocks(struct svc_i3c_master *master, struct clk *parent)
>> +{
>> +     struct device *dev = master->dev;
>> +     struct aml_i3c_ao_clk *ao;
>> +     struct clk_init_data init = {};
>> +     char name[64];
>> +     int ret;
>> +     struct clk_bulk_data *new_clks;
>> +     struct clk *fclk;
> 
> keep revise Chemistry order
> 
will change order：
	struct aml_i3c_ao_clk *ao;
	struct clk *fclk;
	struct clk_bulk_data *new_clks;
	struct device *dev = master->dev;
	struct clk_init_data init = {};
	char name[64];
	int ret;

> Frank
> 
>> +
>> +     ao = devm_kzalloc(dev, sizeof(*ao), GFP_KERNEL);
>> +     if (!ao)
>> +             return -ENOMEM;
>> +
>> +     spin_lock_init(&ao->lock);
>> +
>> +     snprintf(name, sizeof(name), "%s#div_en", dev_name(dev));
>> +     init.name = name;
>> +     init.ops = &clk_gate_ops;
>> +     init.flags = CLK_IGNORE_UNUSED;
>> +     init.parent_data = &(struct clk_parent_data) {
>> +             .index = -1,
>> +             .hw = __clk_get_hw(parent),
>> +     };
>> +     init.num_parents = 1;
>> +
>> +     ao->div_en.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
>> +     ao->div_en.bit_idx = AML_AO_I3C_FCLK_DIV_EN_SHIFT;
>> +     ao->div_en.hw.init = &init;
>> +     ao->div_en.lock = &ao->lock;
>> +
>> +     ret = devm_clk_hw_register(dev, &ao->div_en.hw);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "failed to register %s\n", name);
>> +
>> +     snprintf(name, sizeof(name), "%s#div", dev_name(dev));
>> +     init.name = name;
>> +     init.ops = &clk_divider_ops;
>> +     init.flags = 0;
>> +     init.parent_data = &(struct clk_parent_data) {
>> +             .index = -1,
>> +             .hw = &ao->div_en.hw,
>> +     };
>> +     init.num_parents = 1;
>> +
>> +     ao->div.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
>> +     ao->div.shift = AML_AO_I3C_FCLK_DIV_SHIFT;
>> +     ao->div.width = AML_AO_I3C_FCLK_DIV_WIDTH;
>> +     ao->div.hw.init = &init;
>> +     ao->div.lock = &ao->lock;
>> +
>> +     ret = devm_clk_hw_register(dev, &ao->div.hw);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "failed to register %s\n", name);
>> +
>> +     snprintf(name, sizeof(name), "%s#gate", dev_name(dev));
>> +     init.name = name;
>> +     init.ops = &clk_gate_ops;
>> +     init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
>> +     init.parent_data = &(struct clk_parent_data) {
>> +             .index = -1,
>> +             .hw = &ao->div.hw,
>> +     };
>> +     init.num_parents = 1;
>> +
>> +     ao->gate.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
>> +     ao->gate.bit_idx = AML_AO_I3C_FCLK_EN_SHIFT;
>> +     ao->gate.hw.init = &init;
>> +     ao->gate.lock = &ao->lock;
>> +
>> +     ret = devm_clk_hw_register(dev, &ao->gate.hw);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "failed to register %s\n", name);
>> +
>> +     fclk = devm_clk_hw_get_clk(dev, &ao->gate.hw, NULL);
>> +     if (IS_ERR(fclk))
>> +             return dev_err_probe(dev, PTR_ERR(fclk),
>> +                                  "tail i3c fast clock failed\n");
>> +
>> +     new_clks = devm_kcalloc(dev,
>> +                             master->num_clks + 1,
>> +                             sizeof(*new_clks),
>> +                             GFP_KERNEL);
>> +     memcpy(new_clks, master->clks,
>> +                     master->num_clks * sizeof(*master->clks));
>> +     new_clks[master->num_clks].id = "fast_clk";
>> +     new_clks[master->num_clks].clk = fclk;
>> +     master->clks = new_clks;
>> +     master->num_clks++;
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_i3c_init(struct svc_i3c_master *master)
>> +{
>> +     struct device *dev = master->dev;
>> +     long fin_freq;
>> +     int ret, i;
>> +     struct clk *fclk;
>> +
>> +     if (vendor_has_quirk(master, AML_I3C_QUIRK_AO)) {
>> +             /*
>> +              * clk_bulk_get_all() preserves the DT order, and the
>> +              * binding restricts the AO variant to exactly one clock,
>> +              * which is always "pclk".  So clks[0] is the input of the
>> +              * internal divider chain.
>> +              */
>> +             ret = aml_ao_i3c_tail_clocks(master, master->clks[0].clk);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     for (i = 0; i < master->num_clks; i++) {
>> +             if (!strcmp(master->clks[i].id, "fast_clk"))
>> +                     break;
>> +     }
>> +
>> +     if (i == master->num_clks)
>> +             return dev_err_probe(dev, -EINVAL,
>> +                                  "can't get I3C fast clock\n");
>> +
>> +     fclk = master->clks[i].clk;
>> +     if (IS_ERR(fclk))
>> +             return PTR_ERR(fclk);
>> +
>> +     fin_freq = clk_round_rate(fclk, 25000000);
>> +     if (fin_freq <= 0) {
>> +             dev_err(dev, "invalid fast_clk\n");
>> +             return fin_freq ? fin_freq : -EINVAL;
>> +     }
>> +
>> +     ret = clk_set_rate(fclk, fin_freq);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret,
>> +                                  "setting fast_clk rate failed\n");
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct svc_i3c_drvdata aml_a9_drvdata = {
>> +     .quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
>> +               SVC_I3C_QUIRK_FALSE_SLVSTART |
>> +               SVC_I3C_QUIRK_DAA_CORRUPT,
>> +     .vendor_init = aml_i3c_init,
>> +};
>> +
>> +static const struct svc_i3c_drvdata aml_a9_ao_drvdata = {
>> +     .quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
>> +               SVC_I3C_QUIRK_FALSE_SLVSTART |
>> +               SVC_I3C_QUIRK_DAA_CORRUPT,
>> +     .vendor_quirks = AML_I3C_QUIRK_AO,
>> +     .vendor_init = aml_i3c_init,
>> +};
>> +
>>   static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
>>        { .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
>>        { .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
>> +     { .compatible = "amlogic,a9-i3c", .data = &aml_a9_drvdata },
>> +     { .compatible = "amlogic,a9-ao-i3c", .data = &aml_a9_ao_drvdata },
>>        { /* sentinel */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
>>
>> --
>> 2.42.0
>>

