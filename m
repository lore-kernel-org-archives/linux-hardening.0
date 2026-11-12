Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794455177;
	b=ODsFZAHxUoajc3WAHBEGopi9EnME0WL4/iuiICY+F3w03rT8UHn5T8iCJGhygE6289TG
	 RrrvSpq6XdhHXkMAAoZtW+Z/rEjRXthuH5eM5wFfje4643WO8aT4HZjZ3qyqMn6Lo4bWP
	 UpPz+XS/Vja/rfHbHARToTLTrl1aTDUlzWZyzt1trQcOPeNb+uXpP6LJ3y3Z0UL1QJOvx
	 Ko5BypLjfImaUUi5EEp6B4gRtZKudYb+3G8eXTYkffGG/ItswTjVuvq7CkOv8b1Sz4krw
	 DF0h1FbtLqrkH82tuZqAfpl6r5odW8xHAeynK2DuEdNLZwMluqZNC5QmAy3nniSICGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455177;
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
	bh=40zi+jwh27K2NMWM2sVw7clibz9WSNKfkbOmTfxHjv0=;
	b=v9NtGFomwtFt5D9NCcdAzggbf1dz9Qb+4kpSpKVaeWgzf3FK/2912MLVryPZyWTpGP0J
	 bQicsJ/gL5utrISlmUqhmQacXfpwp5VEO+guB3JloYPvqeg8fCmsKHfld0KZlF2IY4XGv
	 RUKubfKmgdSpDvvwoHkW3xtvM0ZvNbLgQHqiT+DXDPuw/044SCnWonHfBaKKWI4clMCSj
	 8RuvDdRP3YubNuJ5xly5LNjreRcYqL4N3aDpBCUe+0tHWi77y5Lq0VB8NfUv+ACCxNQ3Z
	 o2c2FnJ4MQ3/Rlux3NuBTT/t+4bcysFEcDg+9AYfEdeFFH+z0SKhZPQKBCaL+rxlqzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=iCzXuLLm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.106
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022106.outbound.protection.outlook.com [40.107.75.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00857606A321;
	Thu, 12 Nov 2026 03:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00857606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=iCzXuLLm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaUvgbxhhW3aFg6F4PJfzAYYbjJ+RAogZVZjDearsl3WdeReP1oDD+yTDDzPa7hRSeXAh7R8sl8qEDvCq4DL4ep7tXsShCkzKaFsALi5OSeU58NCeYQsiz+Pm1dkL+qpQWF3CQJN/vxf+dFEvlVSl3MgtRsG7ZE7+F4SbzIXaIWMZf+Y5WxxqX1hVgNAjmAGGxQLr3qd37/5J1p+wZNJSUzMj702COV+JxR5AzZQoV9ueB2lfwc6DjpUuyGtrp/4+QAk1F91tMAYB26ZJgKGtnAvEWXWBnjff7gnr15tKag+oV96sRRc270iV59Km0h+qtHAMm+NwTjIneeX6xYk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40zi+jwh27K2NMWM2sVw7clibz9WSNKfkbOmTfxHjv0=;
 b=x85qhXehdu1hGGRu3fGaWZsW9iv8UKwZEzXEKSEIkVlz59Oq9sb6WIkuMwTE1MtjN5GahtJYMv+m5o3lWNj+OGOpDEgHfEe0Lw0xPdY7bxb1IlFo/uODmZS4ZtsgnOZVmKeMhzfRuKc3dePG3ker6e8Ye5PJcR42sWH5W62+JBGJI5EruAa6qJRZl7G6BjfCUPKN0HOzyIGRzFi5woLHlOG/yUoaQ84yVw63NTWkFNskzFxcNgSvMUgd74APbJrdhcCE82K1MQD66xmj3N4oiqpN0Z3YafvjURNzv53bOi/EtQmDVMDY+nmFxWC1DhxwM/HAwrY1G1fKxca0eQsu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40zi+jwh27K2NMWM2sVw7clibz9WSNKfkbOmTfxHjv0=;
 b=iCzXuLLmh/w7exqGHfP+Fo16ENePvhHxI4BqgFSnjFtPDFTQnIKictSmdrkxSAnQhdp3H+H8eXvw4YrG9M4rZl7G+4/8tnQNuvLURiFsbDDC9isLIrZfOS6XemP+bK0TJe0qJzupYrmwW9G5Se992raGp3//nd6GHxTmMZcSQwgpTyyBDyxu0Aa57jWB2c1JrQyHqdE0F2vjoxEz20SEHsRP+zHFw6VVRAX1lz1T59coLOBPHrBj43kASN3w/PHi/7qHJ54dV7NZ+fy7MMXrlTPQsswsixhdUSPtUMv2S5btQjEr3JeZZapmSHM4unGiEzytoSxC+VmxWow1nx+hOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by SEZPR03MB8813.apcprd03.prod.outlook.com (2603:1096:101:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 12 Nov
 2026 03:46:08 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 03:46:07 +0000
Message-ID: <d64b9a46-ae22-4b4b-88e9-bb1c4eb79aab@amlogic.com>
Date: Thu, 12 Nov 2026 11:46:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] i3c: master: svc: Add amlogic a9 support
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
References: <20261106-a9_i3c-v3-0-804b69b9095b@amlogic.com>
 <20261106-a9_i3c-v3-1-804b69b9095b@amlogic.com>
 <au4LN40LQAHsPYZ4@lizhi-Precision-Tower-5810>
 <57c4941a-b944-4b32-83b2-4f37e3a840f1@amlogic.com>
 <avTDuCD1ipp81dwJ@lizhi-Precision-Tower-5810>
Content-Language: en-GB
From: Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <avTDuCD1ipp81dwJ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::10) To TYZPR03MB5743.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|SEZPR03MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d9f959-9739-45b0-2a43-08df406f7b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|18002099003|6133799003|3023799007|10067099003|5023799004|4143699003|261021130227099003|11063799006|261009223027099003|261022075727099003|261021121427099003|261026140227099003|56012099006|261009221727099003|261021135927099003|261022105027099003|261021133027099003|261022113327099003|261009223327099003|261021123027099003|261022115727099003|261009220027099003|261026130827099003|261009221227099003|261028144727099003|261102123227099003|261026135527099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	mNTcPkS4/j2HOQgfwFMnOVFgetP7OpeAQVi5w0OqpWALQHUevABTx8IM59NjR+AcMp6Hy2awYfOtkfdgCVxU9K27j3oH3x0qK4/61TCew8k2ydwhUycH5rdXILcP+KkZyn8PkUQTV8UvIMFpwGYHR8Fnysi3/kG+qthR0bWFdedXKTmzIHzIoxzxFepG4yQO8yz1vWHus1qg1zZjBYoDTDPJiTWO78gSEqTVMOxJ+nbozvq4zDCo/Uz1kZAq6IDSOd2zdHkRO2fiCcAe+nsv2LovD5mfrBA8E4ISfKfCgQFAjDl+wxSlEXPOC8hn6eQok0/jqzRIBYk8DH3g01XyeIcvnmYJBzu8s/2ez6tsz5+ZaaQ5H+R+rRIOe4HRWQfFMc99enzxKLd3vjlbRnJ9DwJ3r7IJFg5PFM9qGE1abdxJoFyGMOi0e/uiDu3jAtfOYI2En/ZJPjR8XgqhpWmW2Pn7H2xuuqgGMPuWGIXjqT7MQrVRh0EzM/M5dulwaS1u/lEYgDnrf60hxmAlewUXKDwkXF08G2MqLxToIKpMP+EMeJ6vG9N6g3Nyk7tgXYqJEX1Xe8PtPtdv3/i7oJ0u21PSRf5ve+Bxc/EM74t+AFZgsTEiWDAMfj7feX78JXx+eOSO9CykcAuG4uR4GBwff9K8lq5Kmawr4hJ/91a0+qQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(5023799004)(4143699003)(261021130227099003)(11063799006)(261009223027099003)(261022075727099003)(261021121427099003)(261026140227099003)(56012099006)(261009221727099003)(261021135927099003)(261022105027099003)(261021133027099003)(261022113327099003)(261009223327099003)(261021123027099003)(261022115727099003)(261009220027099003)(261026130827099003)(261009221227099003)(261028144727099003)(261102123227099003)(261026135527099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzBLT3NKN0hleWQxbjVSOGVwcllaNnlQYXZ4R3F1azgwelVWRy9OWU4wTHpP?=
 =?utf-8?B?Z0dvZFlJTmlXOXdJRi94dWp1Q2VYeFBOem81Qy9kZjczRU94dFQ2RXp0V0dy?=
 =?utf-8?B?N0NvbFFFRW1OQWloZ1dtRlkzeXVyQzVGaG1oMEZSTXRad0IyYzY3dlZJZkVh?=
 =?utf-8?B?OUZta0Vib1NJOCt1UzdNNE0vVkFXc2ZhaUgwejRiQkE4SWZtOTZDQk9BQ0l4?=
 =?utf-8?B?cDRIWElvVkFIb2tzcFVqQlYwMjBKa0xSNVVOYlFpck1PVzdncDlENEtMVk9n?=
 =?utf-8?B?RVFwdFV6NVducnBHNTZGTUdFcW8zY0wvQ2FQdWdudU9kNEJERHdsem40aUsr?=
 =?utf-8?B?K2JsNGtBTVFmbE1GTnozejFHSXpUZStRcHZsTGhPaWNjZ0dwNlNMYlBnRzNM?=
 =?utf-8?B?T2dEM0RXd3ViYWNJUjVvQmcxOVBUdG9kV1BFZUMvMGxMTkVwdjFWenkxenpJ?=
 =?utf-8?B?V2lSazdUaHRGRCtUVW1HUlo5L3dyZHkwZ09rOXk4RFZWRGZBcmtRaHk5Rlow?=
 =?utf-8?B?ZmRZTmFWL3dJUlN3dmllYVdMTnQzck9saVN2b1RDRzZtWThWd2F1MURmSk9n?=
 =?utf-8?B?SDloeEc0QzRpSWFxV25kb3BnRXd1d3k3M0NYNlVXY3RLZmhqQzVaSXpHVE9z?=
 =?utf-8?B?a3RNNngxS0FwUm9oU1VSNnBoSi9LbVZ2Y0FsZFZWeGZYcXYxa0tUeFlVNUZv?=
 =?utf-8?B?cjlZWXZJWnkxZVpDVk02K3BVODdpdzk3bFdvd0FoNmFweGJKNHdGU0FFZ2F4?=
 =?utf-8?B?V0xWbHlFa0w3Qk5jS21xQkk2VFRHWVExWnN4VWxqUkp2Vk9BSGhtMEZvd1NZ?=
 =?utf-8?B?cnE5ejJxNEROSWRCSHhWa0lYeDNVdUZ3bVc3WWVlYisyVGtQTms0T3JMWTJU?=
 =?utf-8?B?dmdqZG1USXVjeWZ5a29ockpycmxCSEV3ZFMrY3RuaWtQbGV6aWJXbHlWL0lm?=
 =?utf-8?B?OVhYdm9BQUNzb3hkTHZtUlVKZG4vRzRuMlpucGdBWXhZeHVxQWJhSEdRdFVs?=
 =?utf-8?B?L0ZHNGd6YWNMRjE2SWtpRHBwS1lYbEpLbzZkaEhvdStnU0FSWjkxREpEZDhq?=
 =?utf-8?B?eWJOOUFSNlFZa3ZJejZkMDhVdHZ1RDZuSmQyc3FmMGxESmpOQWpNQ0FuRDBX?=
 =?utf-8?B?ZmpEb1ExNXFqY3ZQeUgzMmZMQVhBbHhMclJERFV2R3UvWCtTSmJvUzV6YTZw?=
 =?utf-8?B?aTZkV2hldDBMOG1Valo1S3lOZUdISzl5S1kzd1kzMXFtRkRJYXJKTXIvSXRt?=
 =?utf-8?B?YkJCSkJsZU5YdkxHN050MGhFcEVDWmx2NGJ1MFVqbkNYeUhTc2pNOXFKTTQw?=
 =?utf-8?B?bkk4cVF1MUtSelFSR1VJblBPNzZhVmJ0ZVBBWnp2Sll2enpsWGVQeDJHUm9G?=
 =?utf-8?B?U3RTa3V2QmZIVVByejNPM2JKT1FRUnFtY3Z2OWRDZTV5a3dQd0hnSFlKMkh1?=
 =?utf-8?B?MmU0TFlMWlBYS0YwMTFBS1ZBcEdyYjdtaTRzQmcrVnFUQzJNTTg4VUlST2lT?=
 =?utf-8?B?amY0TlpMVExHc3NnTHhhbTNOekVPU29HM3o5ZXduODUxdGE3NktYblZSQkpM?=
 =?utf-8?B?QXUxTDhYbHF2VElCaXFUZFg2cjZ6cDdPcmZ5amtOeE12d0RvTlR0RGFTL0hs?=
 =?utf-8?B?QWRxU3d2Ti8zdXdWRzdEelduRExYclVxMG54bzZNQytNWTZHK0lEVGM4a296?=
 =?utf-8?B?NjI1S0h2by9MZGkwTGdKVFVoc1hham1aT1grTEtSMExRR0ZTZC93SE1ML2tR?=
 =?utf-8?B?UmZsSmc5TjFtcGpNbFI2RGk5RUhocVN4RmF2bE80a3NudENTSStob1ZsZWRG?=
 =?utf-8?B?cFBoNFgrdjYxdWcvWDhCUXdvTVZ4djFxZlFLemlOZElNNFdma3VONHQ1MXZN?=
 =?utf-8?B?SHlOaFJLT2FFeGhZYnhXTGpiOFZoOFVURWVFaU9PUWRaRFAraVFRSmRwMWFI?=
 =?utf-8?B?N3pOUTRSY3IvWnA5L1hEQktZOFNQaDdlNzF1R0dlRTEyN2drMXlKaG5ldUMr?=
 =?utf-8?B?SXVTZ1kxbjdtN3JPckxPSEpuTzl5YzY3em5IRHQ1eGhFMFNVcGMwandHTTJ0?=
 =?utf-8?B?NSthTEgzWlREUnBZQ1pkamlmODl0cHJSMDVVM0tNb05zSThsZzFRYkY4Y3NL?=
 =?utf-8?B?RklmNms5ZkNsVW5YZTJyQkpCZmZlSzRQWVYyU05aM0FDWGhrbU9qMWFnZE0w?=
 =?utf-8?B?a2pXZmorQVVNbDQxZ1hkVFF4QXZmbytERktaOUdwQXNuMktnNnNiZm9Kcjl4?=
 =?utf-8?B?THVoRkovU1Y2NE5ZdEJKL2czSmw5WlRoSGZyaktNSDUyV3BQQ1pnOWdDNnVE?=
 =?utf-8?B?cHR0TDJHZHJGTjFzL1hsZE9GaEVNazdnVThpWWxud3JXd3JuS3pIQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d9f959-9739-45b0-2a43-08df406f7b5f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 03:46:07.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OV7zjFqx2FMZATB/9xivHyi3YF7tDO4S/7OZOjJK4P9+xTgx3z+3KKM1r9xqKwG0b1EmR13ScVcfh9O0v4CKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8813

Hi frank，
     Thanks for the review.

On 12/11/2026 03:36, Frank Li wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Nov 10, 2026 at 01:23:23PM +0800, Junyi Zhao wrote:
>>
>> Hi frank，
>>        thks for your review.
>> On 07/11/2026 01:15, Frank Li wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Fri, Nov 06, 2026 at 03:13:08PM +0800, Junyi Zhao wrote:
>>>> Amlogic a9 SoCs integrate the Silvaco I3C IP, and their peripheral
>>>> clocks vary from the vanilla implementation:
>>>>
>>>>     - The EE-domain controller (amlogic,a9-i3c) takes two clocks,
>>>>       "pclk" and "fast_clk", and the fast clock rate must be programmed
>>>>       before the controller can be used.
>>>>
>>>>     - The AO-domain controller (amlogic,a9-ao-i3c) exposes only "pclk":
>>>>       its bus clock is generated by an internal divider located in the
>>>>       controller's own register space.
>>>>
>>>> Both variants need setup that the generic driver does not perform:
>>>> the fast clock rate must be rounded and set at probe time, and on the
>>>> AO variant the internal divider must be registered with the clock
>>>> framework so that "fast_clk" even exists. The divider registers sit
>>>> in the controller's own register space, so they can only be accessed
>>>> while pclk is running.
>>>>
>>>> Add a vendor_init callback, invoked from the probe with the clocks
>>>> enabled, to handle this. On the AO variant it registers the internal
>>>> divider chain (div_en -> div -> gate) with the common clock framework
>>>> and appends the resulting clock to the clk bulk array as "fast_clk";
>>>> for both variants it then rounds and sets the fast clock rate
>>>> (target 25 MHz). As vendor_init now runs after
>>>> clk_bulk_prepare_enable(), the probe error paths that follow disable
>>>> the clocks on failure.
>>>>
>>>> Extend the quirks bitmask with an Amlogic-specific bit
>>>> (AML_I3C_QUIRK_AO) marking the AO variant's internal-divider
>>>> behaviour. Since the driver now registers clocks through the common
>>>> clock framework, SVC_I3C_MASTER also depends on COMMON_CLK.
>>>>
>>>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>>>> ---
>>>>    drivers/i3c/master/Kconfig          |   1 +
>>>>    drivers/i3c/master/svc-i3c-master.c | 274 ++++++++++++++++++++++++++++++++++--
>>>>    2 files changed, 263 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
>>>> index da96d2aaa..ac7d246c2 100644
>>>> --- a/drivers/i3c/master/Kconfig
>>>> +++ b/drivers/i3c/master/Kconfig
>>>> @@ -47,6 +47,7 @@ config AST2600_I3C_MASTER
>>>>
>>>>    config SVC_I3C_MASTER
>>>>         tristate "Silvaco I3C Dual-Role Master driver"
>>>> +     depends on COMMON_CLK
>>>>         depends on HAS_IOMEM
>>>>         depends on !(ALPHA || PARISC)
>>>>         help
>>>> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
>>>> index e700392f0..aef56286e 100644
>>>> --- a/drivers/i3c/master/svc-i3c-master.c
>>>> +++ b/drivers/i3c/master/svc-i3c-master.c
>>>> @@ -9,6 +9,7 @@
>>>>
>>>>    #include <linux/bitfield.h>
>>>>    #include <linux/clk.h>
>>>> +#include <linux/clk-provider.h>
>>>>    #include <linux/completion.h>
>>>>    #include <linux/errno.h>
>>>>    #include <linux/i3c/master.h>
>>>> @@ -166,6 +167,31 @@
>>>>     */
>>>>    #define SVC_I3C_QUIRK_DAA_CORRUPT    BIT(2)
>>>>
>>>> +/*
>>>> + * AML_I3C_QUIRK_AO:
>>>> + * AO is the Always-On domain on Amlogic SoCs (remains powered in suspend).
>>>> + * Its clock is generated by an internal divider located in the I3C
>>>> + * controller's own register space.
>>>> + */
>>>> +#define AML_I3C_QUIRK_AO     BIT(3)
>>>> +
>>>> +/*
>>>> + * Quirks shared by all the Amlogic A9 I3C instances.
>>>> + */
>>>> +#define AML_A9_I3C_QUIRKS    (SVC_I3C_QUIRK_FIFO_EMPTY | \
>>>> +                              SVC_I3C_QUIRK_FALSE_SLVSTART | \
>>>> +                              SVC_I3C_QUIRK_DAA_CORRUPT)
>>>> +
>>>> +/* Amlogic specific registers */
>>>> +#define AML_AO_I3C_FCLK_DIV_CTRL             0x304
>>>
>>> Do you have other registers after 0x304? Is it possible create indivial
>>> clock driver for it, reg space is such as 0x300..0x400.
>>>
>>> I3C use 0..0x300
>>>
>>> So needn't distinguish w/o AO.
>>>
>>
>> e.g. I3C_AO_DEBUG_MODIFY at 0x308.
> 
> Does it use in I3C driver?
> 

Not by the current driver code. I3C_AO_DEBUG_MODIFY (0x308) is a debug 
switch that bypasses the Amlogic-specific customizations integrated into 
this controller instance. It can revert the block to the vanilla Silvaco 
behaviour. That places it unambiguously in the I3C controller's own 
register file, not in a clock block， So the 0x300-0x400 tail is better 
described as the Amlogic integration registers of the I3C AO controller 
(divider +debug/bypass switch), not a dedicated clock region.

The debug/bypass switch in AO instance is exactly the kind of register a 
future may need to touch. I would rather not carve the controller's own 
integration registers away from the controller driver.

>>
>> 0x300-0x400 is not a clean clock block.
>>
>> Its registers are only accessible while the controller's pclk is
>> running,
> 
> You can set pclk as parent clock, so access's parent clock should be
> already enabled.
> 

Agreed - CLK_OPS_PARENT_ENABLE , I will set that flag on the internally 
registered clocks in v4 regardless (it also fixes the unclocked-MMIO 
issue the bot reported).

> Frank
> 
>> so its state is tightly coupled to the controller's own
>> power/clock state.
>>
>>
>>> Frank
>>>
>>>> +#define AML_AO_I3C_FCLK_DIV_EN_SHIFT         8
>>>> +#define AML_AO_I3C_FCLK_DIV_SHIFT            0
>>>> +#define AML_AO_I3C_FCLK_DIV_WIDTH            8
>>>> +#define AML_AO_I3C_FCLK_EN_SHIFT             9
>>>> +
>>>> +/* Target fast clock rate of the Amlogic A9 I3C controllers, in Hz */
>>>> +#define AML_I3C_FAST_CLK_RATE                25000000
>>>> +
>>>>    struct svc_i3c_cmd {
>>>>         u8 addr;
>>>>         union {
>>>> @@ -195,8 +221,11 @@ struct svc_i3c_regs_save {
>>>>         u32 mdynaddr;
>>>>    };
>>>>
>>>> +struct svc_i3c_master;
>>>> +
>>>>    struct svc_i3c_drvdata {
>>>>         u32 quirks;
>>>> +     int (*vendor_init)(struct svc_i3c_master *master);
>>>>    };
>>>>
>>>>    /**
>>>> @@ -2011,6 +2040,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>>>>         if (!master->drvdata)
>>>>                 return -EINVAL;
>>>>
>>>> +     master->dev = dev;
>>>>         master->regs = devm_platform_ioremap_resource(pdev, 0);
>>>>         if (IS_ERR(master->regs))
>>>>                 return PTR_ERR(master->regs);
>>>> @@ -2019,27 +2049,43 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>>>>         if (master->num_clks < 0)
>>>>                 return dev_err_probe(dev, -EINVAL, "can't get I3C clocks\n");
>>>>
>>>> +     ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
>>>> +     if (ret)
>>>> +             return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
>>>> +
>>>> +     /*
>>>> +      * Vendor specific setup may register additional clocks (e.g. the
>>>> +      * internal divider chain of the AO variant) and program clock rates,
>>>> +      * so it must run with the clocks enabled.
>>>> +      */
>>>> +     if (master->drvdata->vendor_init) {
>>>> +             ret = master->drvdata->vendor_init(master);
>>>> +             if (ret)
>>>> +                     goto err_disable_clks;
>>>> +     }
>>>> +
>>>>         for (i = 0; i < master->num_clks; i++) {
>>>>                 if (!strcmp(master->clks[i].id, "fast_clk"))
>>>>                         break;
>>>>         }
>>>>
>>>> -     if (i == master->num_clks)
>>>> -             return dev_err_probe(dev, -EINVAL,
>>>> -                                  "can't get I3C peripheral clock\n");
>>>> +     if (i == master->num_clks) {
>>>> +             ret = dev_err_probe(dev, -EINVAL,
>>>> +                                 "can't get I3C peripheral clock\n");
>>>> +             goto err_disable_clks;
>>>> +     }
>>>>
>>>>         master->fclk = master->clks[i].clk;
>>>> -     if (IS_ERR(master->fclk))
>>>> -             return PTR_ERR(master->fclk);
>>>> +     if (IS_ERR(master->fclk)) {
>>>> +             ret = PTR_ERR(master->fclk);
>>>> +             goto err_disable_clks;
>>>> +     }
>>>>
>>>>         master->irq = platform_get_irq(pdev, 0);
>>>> -     if (master->irq < 0)
>>>> -             return master->irq;
>>>> -
>>>> -     master->dev = dev;
>>>> -     ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
>>>> -     if (ret)
>>>> -             return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
>>>> +     if (master->irq < 0) {
>>>> +             ret = master->irq;
>>>> +             goto err_disable_clks;
>>>> +     }
>>>>
>>>>         mutex_init(&master->lock);
>>>>
>>>> @@ -2163,9 +2209,213 @@ static const struct svc_i3c_drvdata npcm845_drvdata = {
>>>>
>>>>    static const struct svc_i3c_drvdata svc_default_drvdata = {};
>>>>
>>>> +/**
>>>> + * struct aml_i3c_ao_clk - container for the AO variant's internal fast clock
>>>> + * @div_en: enables the internal divider
>>>> + * @div: bus clock divider
>>>> + * @gate: output gate of the generated fast clock
>>>> + * @lock: spinlock shared by the gate and divider register operations
>>>> + *
>>>> + * The clock HW structures are registered with the clock framework and must
>>>> + * stay alive for the whole driver lifetime, so they are kept along with the
>>>> + * shared lock used by their gate/divider operations.
>>>> + */
>>>> +struct aml_i3c_ao_clk {
>>>> +     struct clk_gate div_en;
>>>> +     struct clk_divider div;
>>>> +     struct clk_gate gate;
>>>> +     spinlock_t lock;
>>>> +};
>>>> +
>>>> +/**
>>>> + * aml_ao_i3c_tail_clocks - register the AO variant's internal fast clock
>>>> + * @master: I3C master controller
>>>> + * @parent: parent clock of the internal divider chain; must be "pclk", the
>>>> + *          only clock the AO variant exposes (see silvaco,i3c-master.yaml)
>>>> + *
>>>> + * Register the internal divider chain that produces the AO variant's
>>>> + * fast_clk and append it to the clk bulk array as "fast_clk". The caller
>>>> + * must run with the clocks enabled since the divider registers are
>>>> + * accessed during registration. The appended clock is prepared and
>>>> + * enabled here as well, because clk_bulk_prepare_enable() already ran
>>>> + * in the probe with the original clock list.
>>>> + *
>>>> + * Return: 0 on success, or a negative error code.
>>>> + */
>>>> +static int aml_ao_i3c_tail_clocks(struct svc_i3c_master *master, struct clk *parent)
>>>> +{
>>>> +     struct device *dev = master->dev;
>>>> +     struct clk_bulk_data *new_clks;
>>>> +     struct clk_init_data init = {};
>>>> +     struct aml_i3c_ao_clk *ao;
>>>> +     struct clk *fclk;
>>>> +     char name[64];
>>>> +     int ret;
>>>> +
>>>> +     ao = devm_kzalloc(dev, sizeof(*ao), GFP_KERNEL);
>>>> +     if (!ao)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     spin_lock_init(&ao->lock);
>>>> +
>>>> +     snprintf(name, sizeof(name), "%s#div_en", dev_name(dev));
>>>> +     init.name = name;
>>>> +     init.ops = &clk_gate_ops;
>>>> +     init.flags = CLK_IGNORE_UNUSED;
>>>> +     init.parent_data = &(struct clk_parent_data) {
>>>> +             .index = -1,
>>>> +             .hw = __clk_get_hw(parent),
>>>> +     };
>>>> +     init.num_parents = 1;
>>>> +
>>>> +     ao->div_en.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
>>>> +     ao->div_en.bit_idx = AML_AO_I3C_FCLK_DIV_EN_SHIFT;
>>>> +     ao->div_en.hw.init = &init;
>>>> +     ao->div_en.lock = &ao->lock;
>>>> +
>>>> +     ret = devm_clk_hw_register(dev, &ao->div_en.hw);
>>>> +     if (ret)
>>>> +             return dev_err_probe(dev, ret, "failed to register %s\n", name);
>>>> +
>>>> +     snprintf(name, sizeof(name), "%s#div", dev_name(dev));
>>>> +     init.name = name;
>>>> +     init.ops = &clk_divider_ops;
>>>> +     init.flags = 0;
>>>> +     init.parent_data = &(struct clk_parent_data) {
>>>> +             .index = -1,
>>>> +             .hw = &ao->div_en.hw,
>>>> +     };
>>>> +     init.num_parents = 1;
>>>> +
>>>> +     ao->div.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
>>>> +     ao->div.shift = AML_AO_I3C_FCLK_DIV_SHIFT;
>>>> +     ao->div.width = AML_AO_I3C_FCLK_DIV_WIDTH;
>>>> +     ao->div.hw.init = &init;
>>>> +     ao->div.lock = &ao->lock;
>>>> +
>>>> +     ret = devm_clk_hw_register(dev, &ao->div.hw);
>>>> +     if (ret)
>>>> +             return dev_err_probe(dev, ret, "failed to register %s\n", name);
>>>> +
>>>> +     snprintf(name, sizeof(name), "%s#gate", dev_name(dev));
>>>> +     init.name = name;
>>>> +     init.ops = &clk_gate_ops;
>>>> +     init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
>>>> +     init.parent_data = &(struct clk_parent_data) {
>>>> +             .index = -1,
>>>> +             .hw = &ao->div.hw,
>>>> +     };
>>>> +     init.num_parents = 1;
>>>> +
>>>> +     ao->gate.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
>>>> +     ao->gate.bit_idx = AML_AO_I3C_FCLK_EN_SHIFT;
>>>> +     ao->gate.hw.init = &init;
>>>> +     ao->gate.lock = &ao->lock;
>>>> +
>>>> +     ret = devm_clk_hw_register(dev, &ao->gate.hw);
>>>> +     if (ret)
>>>> +             return dev_err_probe(dev, ret, "failed to register %s\n", name);
>>>> +
>>>> +     fclk = devm_clk_hw_get_clk(dev, &ao->gate.hw, NULL);
>>>> +     if (IS_ERR(fclk))
>>>> +             return dev_err_probe(dev, PTR_ERR(fclk),
>>>> +                                  "tail i3c fast clock failed\n");
>>>> +
>>>> +     new_clks = devm_kcalloc(dev, master->num_clks + 1, sizeof(*new_clks),
>>>> +                             GFP_KERNEL);
>>>> +     if (!new_clks)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     memcpy(new_clks, master->clks,
>>>> +            master->num_clks * sizeof(*master->clks));
>>>> +     new_clks[master->num_clks].id = "fast_clk";
>>>> +     new_clks[master->num_clks].clk = fclk;
>>>> +     master->clks = new_clks;
>>>> +     master->num_clks++;
>>>> +
>>>> +     /*
>>>> +      * Keep the clk bulk state balanced for the following
>>>> +      * clk_bulk_disable_unprepare() calls (error paths and runtime PM).
>>>> +      */
>>>> +     ret = clk_prepare_enable(fclk);
>>>> +     if (ret)
>>>> +             return dev_err_probe(dev, ret, "can't enable fast_clk\n");
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * aml_i3c_init - Amlogic A9 specific init, called with the clocks enabled
>>>> + * @master: I3C master controller
>>>> + *
>>>> + * Register the AO variant's internal divider chain and round/set the fast
>>>> + * clock rate for both variants.
>>>> + *
>>>> + * Return: 0 on success, or a negative error code.
>>>> + */
>>>> +static int aml_i3c_init(struct svc_i3c_master *master)
>>>> +{
>>>> +     struct device *dev = master->dev;
>>>> +     struct clk *fclk;
>>>> +     long fin_freq;
>>>> +     int ret, i;
>>>> +
>>>> +     if (svc_has_quirk(master, AML_I3C_QUIRK_AO)) {
>>>> +             /*
>>>> +              * clk_bulk_get_all() preserves the DT order, and the
>>>> +              * binding restricts the AO variant to exactly one clock,
>>>> +              * which is always "pclk".  So clks[0] is the input of the
>>>> +              * internal divider chain.
>>>> +              */
>>>> +             if (strcmp(master->clks[0].id, "pclk"))
>>>> +                     return dev_err_probe(dev, -EINVAL,
>>>> +                                          "invalid AO input clock\n");
>>>> +
>>>> +             ret = aml_ao_i3c_tail_clocks(master, master->clks[0].clk);
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     for (i = 0; i < master->num_clks; i++) {
>>>> +             if (!strcmp(master->clks[i].id, "fast_clk"))
>>>> +                     break;
>>>> +     }
>>>> +
>>>> +     if (i == master->num_clks)
>>>> +             return dev_err_probe(dev, -EINVAL,
>>>> +                                  "can't get I3C fast clock\n");
>>>> +
>>>> +     fclk = master->clks[i].clk;
>>>> +     if (IS_ERR(fclk))
>>>> +             return PTR_ERR(fclk);
>>>> +
>>>> +     fin_freq = clk_round_rate(fclk, AML_I3C_FAST_CLK_RATE);
>>>> +     if (fin_freq <= 0)
>>>> +             return dev_err_probe(dev, fin_freq ? fin_freq : -EINVAL,
>>>> +                                  "invalid fast_clk\n");
>>>> +
>>>> +     ret = clk_set_rate(fclk, fin_freq);
>>>> +     if (ret)
>>>> +             return dev_err_probe(dev, ret, "setting fast_clk rate failed\n");
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static const struct svc_i3c_drvdata aml_a9_drvdata = {
>>>> +     .quirks = AML_A9_I3C_QUIRKS,
>>>> +     .vendor_init = aml_i3c_init,
>>>> +};
>>>> +
>>>> +static const struct svc_i3c_drvdata aml_a9_ao_drvdata = {
>>>> +     .quirks = AML_A9_I3C_QUIRKS | AML_I3C_QUIRK_AO,
>>>> +     .vendor_init = aml_i3c_init,
>>>> +};
>>>> +
>>>>    static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
>>>>         { .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
>>>>         { .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
>>>> +     { .compatible = "amlogic,a9-i3c", .data = &aml_a9_drvdata },
>>>> +     { .compatible = "amlogic,a9-ao-i3c", .data = &aml_a9_ao_drvdata },
>>>>         { /* sentinel */ },
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
>>>>
>>>> --
>>>> 2.42.0
>>>>
>>

