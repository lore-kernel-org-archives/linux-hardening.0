Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792561107;
	b=gYfrBAfTJSQZMSMB4zgg+iLMD0VQ9E87yZFCS1iEzH8NgRY9PYZsXH4zNda8FXEuOStk
	 EW0YCjb7jNTobjN6nfvNVRjFLr+AguuATE7TMQATCPsxR90wyfTI6FIilfyNi5LT3CONz
	 Fdb+UeVcI+ytNua7mTlBMAO+bClshDWRyjFyts1LmZb9ZDcvQNsi08GslA5AMQSArKbQy
	 ANzgQ+NQKF03SNKM01oGQH94lRlUqZaqtJgmbe4bMtgqfEuvGmZcSPWHq1OZdccpmXv3o
	 DLcTwVWZ6mXSXabd6jkVbdGVGy2YH1U4SZfjs2rlzgOJXezIE/x38QTRB1I1vN6K12g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561107;
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
	bh=MymJw9QoWMZZA+j6WtmDCThK3sz3nG6td7SvMcxZL5g=;
	b=nAnZhozgCmG7gsr5HLF20V7egJLfaaiOA5n6FyzcHQpxeHoY39vkLi/Uq20xS3hQ9DUF
	 IT1Bn+eQZqkC0Tulfm6baRS8cHrrNBFeo0ZvJTxe4mR/dtng7JObjq474FzsdAVPMmb0i
	 5XhqTRWNLE6228tTuQpCTvwk4P4mFXwZc+vRwNMqggYZ2oThkngy2I4KsGSWUyBq2wxA9
	 DleEX5i5Y27E4fiRW4x9GEx0D/ms7SD0G2FFli9FxtC/Py5lEeXENffeoGganV1ShDNZa
	 f5sJnJif5t2i7pCkBUEqcrDacyTobzMSMbWG1Vu2YPdaFoe+uzEp76EtOE8g7ZtUIyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=LFjaIFRt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.80
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023080.outbound.protection.outlook.com [52.101.127.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F3606A319;
	Wed, 21 Oct 2026 05:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 630F3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=LFjaIFRt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLeE86qR/9R1pXwNIgduxR3ZSNm+dvHTlg+o/ZJiKyzVsJHFFkk3wql2zGeCelyP2wwYEiTS/Mltlf8iga/+Dr6exTYX8J04/AsNDu5fE8vuxEPBXB2wTB4nR4FviRmiid97ZVFORlbLiFet7/3NSIjEmTrjv1+b+8E2+GvpZcmSC2yahV48O5AaHw3aNPnKvbdIENY35+8QHNzNQMUQQ9apY8j2ZYH5PdqkxtE3ohoYoeBQ9ed5q1WzSbdbPrR7+0f+gsbfJvKQ0Af9r4sLvbhrZoVt/dVzdioB7K5p9h2Ab4EmVUuJ805l1m93pZR0UdUxcVTzFbTCabsYmYO1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MymJw9QoWMZZA+j6WtmDCThK3sz3nG6td7SvMcxZL5g=;
 b=HjsdCfjI4Xsi4rFh47IJVseIYwaMcdHGrZSmpGKzKjNnCHztkKiOjsn2haRpTeaxaNa9FmL4IvhALMqRWAyyx6NlP+zuFUKqRFtpqVfUlXACUPqWuN3NU2j2/dXV4krFrnsJGKuEIpXemlNOL+wpbTseYKdwtzE/AwTykriIB+ryWpoWu8iQlRqe+Svet9IsmaDfJ9XyuLL8MRZr9JWBKWFYunJG1Wjxq73bGbIyL8TG9FKpgUAqDyZXJD+e/sw9GoVmT5kxcqbHSEPbypG4kMHdA4pPMyW93gjqieTAnLilXO6ViHW+lmxh0GrNKZFst68lKH3fhNzKb06IdHzs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MymJw9QoWMZZA+j6WtmDCThK3sz3nG6td7SvMcxZL5g=;
 b=LFjaIFRtUitcPMZruw4i0SwIXND7+tt7R4VIy+CBy/UOJeBhyVWBPTotO9CNb9Ja2Pk2vh9Ql3m13A2Piou0ydgSojlfdowXZCDpj2b/47msi3Sl03VGMTFezQzpHCXC3BIr7B8xxc/4XPiwy7WoZa1N/idpOhdjiNWkVVSHJtcO9mKr+DECvuNVsEf8zRDXmve9UvsJDBJMeqf2Ex9hbxO9J+vMRjwiWzVuafdIkc6cCYQQEGOMZyJw87vDWHtp9lOSiupihuOL+4lMIDkdqpmHM+qEISqp5fyu8ie8gZ+cjgU43BkyEjwvldEgTVEVrOKTbvY/9I+s1EOjJHMS9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by TY2PPF5170D564C.apcprd03.prod.outlook.com (2603:1096:408::9d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:38:22 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 05:38:22 +0000
Message-ID: <d17dcb30-93bc-4b68-8969-11530946d33d@amlogic.com>
Date: Wed, 21 Oct 2026 13:38:18 +0800
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
 <c84d861a-2e28-45b0-80c8-e533864d5e6c@kernel.org>
From: Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <c84d861a-2e28-45b0-80c8-e533864d5e6c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0090.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::13) To TYZPR03MB5743.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|TY2PPF5170D564C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0c91d9-a43e-4237-588e-08df2f3584ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|921020|3023799007;
X-Microsoft-Antispam-Message-Info:
	l46UqoGE6FL+ps0ZenQ+iDW874M2sxb7uCPDrWIhNq/n1iqoaudXi0YLzf/TRhyuZ7GMGi+yzqFQheRKsDMDNZ4flIMiawDYd2wPHJF58oYjRd9AkOjQEnonUgSQqiAFSGVsBSleArKPWxBKah6F0QWOADPJg2xczsJ6hclbz+EX+p0iWsYpaGsc1Oov/zWfoqt2mmoYRkFUZnKa7F5gF2y9RvcWREEv+WgVw0W2poDQy3pSF7+yoNypMvKgzdnLt9MMCDwStXmILmfH7xHegRe4Culokn7x9NRb+klhjrrPAKvX4vT/bOWMP8tdH9SI5x9+dm+2jk8YzVhLP3Zz25BSj4R3YTJDOZpfCQioQBRp5LjbKHPBpHp1yN5W/JIkZeaOMZWUFxy3ZbZxQiczjyYxrZZh4SuBgk4EZbxKKkBb5YCl2d2LljhYPxDo1EVurZl3GEiJkNJ6zaBJzmbHRkkxlpamrEFWYeGyfCcTm+GLkQ496jp9ZS5DgCQqeNzMTxds2axKD3vUiHlCKpVlKPdq6/Z7Etgfh1U39rlnO0QRXSPJqyP0pxeXIX+jGco2lG9/mVyo1CCXSH0K77ms8sRjdhV31qCFDrs5tchEJJQ8cwFK7K5FggToyHvD91fHf1JpUCB/Jz8Oomo7GTrw3drqILxVNwsSodtCli2KnVYDeUINTig6NS1T8OFWz3ypjuMghKBWFUDN2qKKYnMEHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(921020)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk5FeEt4bEM0b3pHLzNtNXh3MDk2UUVDZ24xNElVeFdFZ1MyV29VWXgxbUd6?=
 =?utf-8?B?bDk1OHZOWjRFRys3emlLQjdLZ0tXUUk1NVRVc0tEbysrTlNXMmcwczlqTFNP?=
 =?utf-8?B?WWRrQXVDVk1QS3YvdzJiUDFmdVRIeWNiWnlWR2VuVjAwZkhKRkc0OXFjR09r?=
 =?utf-8?B?WGNTdGhpT2dqdDZUSkZib1pCQmRXSWF5TW5oZldjQ0NuZWM5aHBYZ1g1aWtp?=
 =?utf-8?B?OS9ENEc1a1NMSERkeWlvZmFrTnpJNkNxUDVsaERzTm1vRlZ2TzFVQjlGcVNi?=
 =?utf-8?B?ZDJ2anRGWlJyTUtPa3ROelNhOG93dlowRzJiNVprc1FhNGJFWFBvbUJGZll4?=
 =?utf-8?B?a1REYS9BY0JlRWtRVE45dUZhVlh5TG1WNWt1d2NvNWRaeWwyQU5sK09OZk93?=
 =?utf-8?B?VmpQdEVIK0FPZ0lRa3VWRE9XRGhmdjhDRCs2Qkg3aElMemN5bWh2RmkwdTdO?=
 =?utf-8?B?YllLM1BZZGJ0MG5mWm44Q0JlMnR3VVhoT1dUTHlBRHorMGJ4ZHJnL2RWbUpn?=
 =?utf-8?B?ejZBd0Z6Z2tEZ3VGM2hQc0JpQnkwUFJQUVBLL3FEL2FrMGZsK0J0M1dCaStZ?=
 =?utf-8?B?WHdUcTFGaWNmenNiT2VheDlHaEsxdUR2eThRSnFlQjQ3bTB6bnd0STlvYkdB?=
 =?utf-8?B?b0JLZk9wbEJ2N2gvb090VmZuZ09iazBLNWczZTZGUm1BU2s4R0s0Z0dFMWFL?=
 =?utf-8?B?R2VMOUJZVUEvMlhtRVBORlJId1FNSHdmMDRMbEU3UGtUQmFCQWF3elVQQTBr?=
 =?utf-8?B?Uk5YYmlacWtVbW1nc2lXUXhkUlBKeVBmS0lGOUhxYU1OUC84YkhNc2l4c1cr?=
 =?utf-8?B?Wk9DdjZFcnB4NmljenRqWnhzeEE4d3BBb2tjQkFSc08vY0l1RXdtUHdma0tL?=
 =?utf-8?B?aFBZZmY1M3E1UFdMNHorNkkySGNMNVZnc2h3WlNRU1RPMHhDb3NleFRJdE9w?=
 =?utf-8?B?YmttNlkwek81TzA1aWV2R1FOdWh3cTNYUU5hbGp5cnhGT2VLNW1DWFNqem1w?=
 =?utf-8?B?ZXVVWVJHOXhITHFHRDUwWXFLeEw2VnVZL1VIK2RabU5VdE9JNCtySHNEM09z?=
 =?utf-8?B?M2dxV244NTVnc1FFS0RzSGc0Q1M5d2lnOGRzT2ljWm5VWWtWa1RXeUU3RHh2?=
 =?utf-8?B?M3htMXRyaHZRL29iL01qREE1cDhPYXJ0alZFNEIwZzdPai81bFp2ODZQY2Y0?=
 =?utf-8?B?OGU5NnFBWitpUm9IMXMzM1FubTVwa1pQTE5OQnJwK05MNk9RTGNDNURNL2pq?=
 =?utf-8?B?QkhoMm9qTzVUTmNrWHl3RTRoMXVqREtyUiswR04zdDRhUm9HK0JlR3ZQL3V5?=
 =?utf-8?B?ZW56SFRERTZFYnE4ZVFVY1V2UDJqNG9JdVZXTzEwb2IwalhiMjBvRS8zRnAz?=
 =?utf-8?B?Wnc1VkpTS0tIblRiQUVhZlZvcUlqbTk5R0Y3b25lMzNZZjJCekoyelRSOTZZ?=
 =?utf-8?B?Vzd3RW5MWkY1dGpMa3Jtdm1QelZKalRiOHNmdndNaHFOKzk2czVkRHN4S2Vr?=
 =?utf-8?B?ZDhWemRTNldYYjFvQ1RUdFJOUXNzOG1GcVJmN0lEc1o2VVF6QVlQZjY4ZVRk?=
 =?utf-8?B?WG5SbEMzK1B6cEF5bkVGcG9uZTJtVTFjOS95QUZRSGdZeE11TGxrb25hRHdl?=
 =?utf-8?B?VVdLbG55QkZBeGJ0djNXWFd2YUZacXZQaitXZGZyc3BtTHBTUllnRkJrZUo4?=
 =?utf-8?B?YjkxazA2TTBqZzNhN0pXSGZteEtLaUxIdDR4bXdZNEtjT0JGbFlZay9QZkg1?=
 =?utf-8?B?c1lqaHptTWxkS2pJaUs5MkM2aVA4TWNIK3VzZG1FeFhjSUlqQjdiemQzTTRX?=
 =?utf-8?B?N0p1V09wUll1a2ZaNTNzWDhOSFZyZ2EzckIwaUVsbEdmVXdrRDhmOXpna1Bv?=
 =?utf-8?B?ZTNRMXlsU0JZNWtzUDN3QnBrWjVmdm9MQzFsZE50VHhHT3pmUmNlMFVSU29Z?=
 =?utf-8?B?YmtWQWZqNy9FdFREbTRXRTZma244NGZhbGQzNXBuSFFKbFI2dFpVNEY2UCtz?=
 =?utf-8?B?TTNVSHVJWC8wT3lGR24ySzVsZXZCWWlGa0diZDF3d1o0NmRRalNBOGhTdGp0?=
 =?utf-8?B?NW9KT1pkRERDa2dYbi9GVlVXTDFpZ3luRGtiVXE2M3A0bmM1WWtUVzBXV3BD?=
 =?utf-8?B?c3hiMzhHcXpzUUg0WUdISTNqb3NiSFB5eldScDgvVGI2Q05scGhGWXlpa2lT?=
 =?utf-8?B?eThBRUcvaWtSdnVydWJMeVNqRjQ0WENvQy9pOW9Vb2VXN2grUWpEbi90SVd0?=
 =?utf-8?B?bDlqUFVjZXBCOFBmWk10WDNXTEUzQ3k2NDhDVHBrZ0ZZb3cyNFRFWElDRkxn?=
 =?utf-8?B?VW1aanU1ZFBGSG84OHdWTU41YTUzQnVSTGU3R3B0VEFvSzQrenJVdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0c91d9-a43e-4237-588e-08df2f3584ad
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:38:22.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36SeQWBJzzfURaSVc5fWf2ZbhklYcbyqsGNeyoO9lQkWILUr6K4CBFg1vuQ4GgJ7tKcY0D9gHVzZhCW9juxvgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF5170D564C

Hi Krzysztof，
	thanks for your review.

On 2026/10/19 14:00, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 19/10/2026 07:34, Junyi Zhao via B4 Relay wrote:
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - amlogic,i3c-a9
>> +      - amlogic,i3c-ao-a9
> 
> What is ao?

AO is the Always-On domain on Amlogic SoCs (remains powered in suspend).
I've documented it in the binding description.

> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 2
> 
> Names go here

will do.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
> 
> This goes before example

will do.

> 
>> +
>> +if:
> 
> And this in allOf, see example schema or other bindings.

will do.

> 
>> +  properties:
>> +    compatible:
>> +      const: amlogic,i3c-a9
>> +then:
>> +  properties:
>> +    clocks:
>> +      items:
>> +        - description: APB peripheral clock
>> +        - description: I3C fast clock
>> +    clock-names:
>> +      items:
>> +        - const: pclk
>> +        - const: fast_clk
> 
> That's just fast
> 
> minItems: 1

Will renam to "fast" and updated the driver/DTS accordingly,
and will add minItems: 1

> 
>> +else:
>> +  properties:
>> +    clocks:
>> +      maxItems: 1
>> +    clock-names:
>> +      items:
>> +        - const: fast_clk
> 
> maxItems: 1

will add maxItems: 1

> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
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
>> +    };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    i3c@22000 {
> 
> Drop, one example is enough.

will delete one.

> 
>> +        compatible = "amlogic,i3c-ao-a9";
>> +        reg = <0x22000 0x10000>;
>> +        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +        #address-cells = <3>;
>> +        #size-cells = <0>;
>> +        clocks = <&clkc 17>;
>> +        clock-names = "fast_clk";
>> +        status = "disabled";
>> +    };
>> +...
>>
> 
> 
> Best regards,
> Krzysztof

