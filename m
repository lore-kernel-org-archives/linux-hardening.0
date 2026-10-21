Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792551392;
	b=dMEwF1NNd1ddmf96EuZ88qjOpH3Eps05EvfnzjHV9s64m4tQr7LnXxyCJa6+Jsmz9vib
	 f21A2oFytjR6KMskSlar46U4OYsVlvKjxhz0sRulazHSuCw5Ep/REGklWKSTEVRAjXhLG
	 eiA7PyNCeS+E0UeUOr9e6ZLRLENBRaSGCY5zI3l4OcABdb3i0SmB7yazKmvcHnDo2U1Nn
	 p1dlGlwZSoMGXds/IjbR+olborZ9LrxPLsLB+uTdP7TCC5ZtbK3wIe7t2/vYFGAAGupog
	 CpWKPoSnWY/64XAS0rWNmHTGVxby2lT5OimZ608Rp3gi9nwgDDq4c17OFKa6f/4ZqiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551392;
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
	bh=HANTeur/Ki+zmOxvulIzVJ7OAanFmdA9rRDzL3y9yCg=;
	b=kFr/PtuG2BKVIL9+MZtigKhfQU5wHIW19g/V5b788a9+u9rfevcW69ianHDWBkBMkJnX
	 iihHqGegBxsObISGMcYtbs7gTb0+LB+UZcjR4taMxsLRo7wWaNJr35ehb+mz9z/5cZwPB
	 6BILa8jTtGijyH3mm3VdoFXa3Di0Lz61wH4g4kuAh+mL9uGJBt64wNIXQu96C3fRoKd7r
	 GD6yiV77DySHH0BkzaxMvi4rT7HVGMXcZBOZO0hRSGCrrSyN+doTNxKGf1UsmHpsb0FNZ
	 EbPC31tXZVgvE+IpBDyj/NrKAfO915x+n6S17n/YuaZJ3Fj9ab7Za2b+k0VBdoAzRMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=ebzg3HP7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.75
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022075.outbound.protection.outlook.com [52.101.126.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8E606A31E;
	Wed, 21 Oct 2026 02:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23E8E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=ebzg3HP7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVxSkQ2oNETEwkIoKYsQTqmZbwApzY7qKjYSaqNzkELi3wT3o4Htog9bdI1m9Ra+7LcMwD6PFhRZy26B8ZaLZZU998c5qW6V6DqNSH58KlZqrL4xKfQvZ1L/KZAOW11BJ6DF3K1D6sOW5QiLMBXK7xYOWrQJ0RBvnbwhMLp5RqpRNL/XYCevtXVfsPi0eqaK19d9sZG5WEjr8oL/u8+QKv+1ivJTfBQIF6IZqXpJyjz3J8SWH5wJZp9p9PAAKRk26TGrJ8ntdsKL52Tkn2cJlfM5btRHRuAmtbn2SYv6jnrDkOi0in8n6LUKKC1tKC4Vpn5BpBSxJTtezzfFlLKYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HANTeur/Ki+zmOxvulIzVJ7OAanFmdA9rRDzL3y9yCg=;
 b=qBVHEvqOsk8wCMstcDXD98sOF57IOI7ntgBUIU+tcDCdYZVbplFgV/goxj3+x4kSjsoNlmqD8gIcoW9xK2KBsiRuERGNIoudzw4lIBv9pd2gi63KlDasN9AYybZghic7GHNMIasFSlWsz74aJTXOyt22lAv/BIhd4Dy7W6pUEUom+3gSlzJsjVzPFEix6jMOTMJQhm8hBfyxRaQJHYZ9cNyIFWKOGGM9mrs44kYxeNJu37Q9DhshekXYz0BaCXiu0AF0unr1AxSGDnNJ8m5k/og2PlfDAiiUCxQgtOyGRQXFOqt0ZNkhlihh7EtZ7zdEnspyNn8rf6Pf7roTtyskRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HANTeur/Ki+zmOxvulIzVJ7OAanFmdA9rRDzL3y9yCg=;
 b=ebzg3HP7ntZ2dFAw34eAMy4oevFQTQ/zm5pp4KssibVWd2OcIm04v3DIcC6ODPOyfN1Ucfp7uaJHRuQWihvGqb++okmx4WzhtSIgaT4RFCBmtOJYEDdRqs6LdK6vjNNX1hNTsd4JfyNZdeucxeesH/gxy70olkIh8vCGq7Npjrf/6a4WBkKnaqI09V/SciUGOLOmb9YuAyRP5X7hbl1a1/i/lzI6C6o0c8yDag2E5UyKJ/Hlu+/X02jOhbXd+WekDUFEEb/m1CE/4Zz6/6y8Z26pdQiyGNl0Z7+xJmKQtZWBIZUz/yQjU6wAkC8JVk7PoxswoD5fIL8sq2NMvLULYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by KUZPR03MB9662.apcprd03.prod.outlook.com (2603:1096:d10:64::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:56:27 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:56:27 +0000
Message-ID: <887f0b2d-3a05-418b-bda5-0b01abbcb409@amlogic.com>
Date: Wed, 21 Oct 2026 10:56:19 +0800
User-Agent: Mozilla Thunderbird
From: Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH 1/3] i3c: master: Rework SVC I3C to support vendor glue
 layers
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
 Kelvin.Zhang@amlogic.com, junyi.zhao@amlogic.com
References: <20261019-a9_i3c-v1-0-329d819d621f@amlogic.com>
 <20261019-a9_i3c-v1-1-329d819d621f@amlogic.com> <atZ-YyEmG-KvUZAF@SMW015318>
Content-Language: en-GB
In-Reply-To: <atZ-YyEmG-KvUZAF@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0071.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::13) To TYZPR03MB5743.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|KUZPR03MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b499cdf-fc6c-4e6b-8ac7-08df2f1ee65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/B6ug7NleIRCrF3GGt7hV461Jp0gaUHdJvrIZXRDNWyON4quIXTfkcitVG7AqzyWqBq0FGIbSBkttNOWD1FzlK1okNXtkzhrdtGMjYy7PNEey1FJ1Uh0MJkFHIDl45odcUpwPnlz6+Rt+s7uk7jBJs7OxEsep31J+FYVChWjnYxVHVk7CaCelHzEWwdoQ3YDsqAguKTFXeHNwF6sEOfuSDa0bv18v/NHkLuMvTCJzRarc5N3zWQTn+H/Xy94sN4T4ZwcWPa6WJsb6Ys7QlZxZklh4uucV7voJWOKsEqpxFMncig14BgjnbEj2q76eHnYYH+dQKqhI1H8JX0a+8ZE08l9hJRMzETU0xJX7O/EmbzokpKAxQY+zaknC2voO36HVzGo9gvCH5XAiqzxCtyXKdvyZlSCUO9gBRS0xDx/JKFdVishfWdTAUjq/QbUHPN4/yxywyffrjZrozbr+TKa5xfui0L5zVlazKmI7dUur/ZKCjUFeM5mk54GNah4VH1lP0vawBdarfGxYFruouf2I2gwoz4te66Ko2buAWQQJqtCtInuA614n18IxBOipzBBD5AOqrl+7+hlXklotYBTadcTqE3pkO3LU3RC8IE5GX6E1QHRRUYol9ztAk5B4ygPGiBQ+VtIvvWTeN6MFjprz1n+T/FgvoWZbPVH0OFo/jQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3JYQVlKeHJhZDVnSEhxT3h4djV5cDgvdkh6NVJhalN3eXJocXRhNGN2RlpX?=
 =?utf-8?B?cVZlb1RSeGFXVTZzWFdCUm5XamtvWmxiajJRMkdVQ3lzblR5aGFheklQVDFs?=
 =?utf-8?B?Uk5DcmtRaWdjeHloekh1Uml4YzE1bzIya3hsSUFDaGRuVWVGalRTaHBHdzVI?=
 =?utf-8?B?MWx3S1R0ZTA4aThIeVVJakR1VjFvdi9WK2xFY0JhWVk4SXZyWGFxVmpPYkM1?=
 =?utf-8?B?MUxxSUhndmtEQVp5aEpXcVMzT1diVW5UL1JZcnVOTGtJZk5sOHBnUnYwUU5v?=
 =?utf-8?B?ZEFwRXliWkFtSVBnUVZVc1JyZ3UxS1FIYUptNDlzTGhUczBJajZYQmNVKzRF?=
 =?utf-8?B?bExUR3V6NXc1S3Z1Y1k0WkJzV0ErM1RHeVI0bUZVWTZBYnBnUXEzdzJRVkZk?=
 =?utf-8?B?U1RjWGFienBYK3FTRFdMMFZOclU5ZjZydmFWRExEKzlmQnZzTW9La1h3RHpZ?=
 =?utf-8?B?am83NDdITU5naGVGYURtSmhJNUdJMDVmWEJZcU1WV2l0T1htMlBBVU1lSGZS?=
 =?utf-8?B?cGlCQ25GbENGVkh1QU5vQTA4QWREVmNEVnBhUEhweXZFejEzTlJzVW5zbTk5?=
 =?utf-8?B?THRPKzk3VEhZV1JsOXhSWkFxY3BtWWIrQ2lXYXR5Mkp1S2greGpHaE9XdGNN?=
 =?utf-8?B?YVppeUJWYWNDZG5uZnJUdWt1d2R6RDJuRG9LdWFab2h1cFRZR3diYjUrVUQ3?=
 =?utf-8?B?WmgrbjFrUEVxYjBYcXpTdjhBWXNGNkM2K0Zob2ZvbmZQQVJxWmIvMFpHMWZY?=
 =?utf-8?B?TDBnM01aTXFITjJSMUJac3dla3lrMHc2RWExQUVkVE1xNUg4WlZBaTlJZTNl?=
 =?utf-8?B?eXZzaTRzVFBqekJCaGJGVHNzZFJ6ZE1DdU0vb2pjYjAvM2tsQW42aDZXMTJY?=
 =?utf-8?B?bmQ5UHcvRkp3MFBJRHpWd0trUDJNV01rdVRsU2UwcjVuKzRzMG55dE5PSUNn?=
 =?utf-8?B?TXhmbWJ5czgvQThZVk9nVml1QTkvQVBXdmVGRnRMWGdseWY4YmhJVG5XdGxR?=
 =?utf-8?B?SnFMelNoQTlneFpIUjNobGJxOVkwZzUzbTBpVFk3cFNNU3loVjI1VUtYVDRP?=
 =?utf-8?B?VGxuQXlDUjNGa0l0bXVrRnM5TDIxYzNZNWdWbUtxWUdaT3pqaVB6VWp6WTk0?=
 =?utf-8?B?dXNXN0pYcWttd2JzbHg4QXhQck0wVnF2TjlKMXJySU85dHdSZzNRUWgzMnR4?=
 =?utf-8?B?MlBkNldMM3M0S1A0RkNTUmVma2dLRjBOUzA3cFZ3THlzMVd0VDhlM0N1YmVQ?=
 =?utf-8?B?S2lZUFU0Y2poVVF5MXVVaEkvRm9COGZtRE8xWXBZWExlTnhLSUl3SU1kd2hm?=
 =?utf-8?B?ZWx6aFlzNkEvc01MbEk1cWJOYktNakhmZXF3b1o4QXJTR0E3MG5qS0syZ3BU?=
 =?utf-8?B?c2sxQkZ0bmgyTytDV1NXVG1PbVYrbDJFNURwZ1dqMUVNc0FObHd2SU1sVjkx?=
 =?utf-8?B?OHJOcWdPOEkxOUhkZ3BneWVyQVBtbHNQVHB4RjJzUkNHZGVPOFd3RkkzaUdV?=
 =?utf-8?B?ZjNNU25odThBOGNkejAwS0pxTWF2ZWFlV3ZBcWJWM3JhTGFSRmZKRmkrU3dT?=
 =?utf-8?B?ZzU3VHd4RG5ObGlldXgzQW8xc0JUZUNNNmhwRU92b2lZdVlHVXYwVDc0bTFk?=
 =?utf-8?B?S0xSQTJnQldyRWZSdWF5b2RDN05pL3pnZUhsMzNUTUxPaCtjclV4TFVqTTl3?=
 =?utf-8?B?SW5kSjQyUXRYaWpKcm9nM1F0NzdtMVZHTENRa2I5NWphWkQwOWx4LzBPYnAr?=
 =?utf-8?B?N1lZSlBpT3dDc0NaV3NzaVMvdVlqWWk4UkN4NTc2Z1ZERFY0WmxJMTRXV0dS?=
 =?utf-8?B?TmRMQ1B4ZFh3TjJEbVBja2ZCcjVHQzlxTk9ibDRLb2wyMndVQ2QrckE5a1JX?=
 =?utf-8?B?ejhOT1JxdXcvY0xqTWFBMVFLWEtadEZ6L0xNc29lYnpyYWZuRzVMSnNraTNC?=
 =?utf-8?B?cVlZTmxVQUxucTJRWDRHVTl3ZGcvYUVVK0xzaGpTVkRZSFlnaDIvbWJ4OVBi?=
 =?utf-8?B?VkgrYmFteFIxK1hWTWFtdVZBdWFFbS9BRjdIZ3pNYU5yTVZQQXVsOUVOSEM3?=
 =?utf-8?B?ZEFWRVBBUVlwK1poQWJpVHlaYUNyMU45SDJxRllxWGZMdDRGS1p5dmZZWFdt?=
 =?utf-8?B?VGxZM2JYa1VySUwydXpKVnVlbjl0MlNUUUI4UTFyOE5QOFE5UWhPWXp1NmFo?=
 =?utf-8?B?N3VaMzQvUnhZVmg2NnFPTzdmcDV2WnQ4QjZRaHZwRElyRXdQWFl2UXBHbXdY?=
 =?utf-8?B?SVFaNlc3cVNYME9IU3FrbWszcGRDNWVTNS9iRnJvZ2NLOWxxWHU5M1NjN3Va?=
 =?utf-8?B?OGxCVElaVjUrZEpGcWsrbGsxUHFHOGxEOXVNckZwRFJURjdGWGEzQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b499cdf-fc6c-4e6b-8ac7-08df2f1ee65d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:56:27.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JBY6hJjKL7gaY0iYT+JYYjylyL7oDxjgMUFcnCJcvAt+xgqFDObTvEgWwo7krDLNhSgfYaugq3BDQXSuF5xjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9662

Hi Frank,

Thanks for looking at this.

Amlogic A9 used the same SVC I3C IP engine, but the integration of it
differs in the resources *around* the controller, which cannot be
expressed as another quirks entry:

- On the "ao" instance the bus clock is generated by an internal
   divider (I3C_AO_FCLK_DIV_CTRL @0x304) programmed directly by the
   driver; there is no CCF clock to clk_set_rate() on, while the
   common probe assumes the fclk is a plain enable-able clock.

- Amlogic added register blocks outside the Silvaco map: a
   DMA bridge and a bus monitor (0x200..0x22c).
   Enabling the DMA bridge later will need hooks in the common
   transfer path.

Adding A9 support to svc-i3c-master.c directly, would make these
becomes if-branches in probe()/PM/transfer paths of the shared
driver, and the next vendor repeats that. With the glue layer,
i3c-main.c keeps today's logic unchanged: i3c-silvaco.c is the
current probe code moved as-is (rename with 79% similarity), so
blame/history is preserved.

If the file move is the main concern, I can keep
svc-i3c-master.c where it is and only export the alloc/probe/remove/PM/
interface for glue drivers -- the essential part for me is keeping
the resource handling out of the common code paths.

Also, per Neil's suggestion I'll try modeling the AO divider as a
CCF clock in v2, which should drop one hook.

Thanks,
Junyi


On 2026/10/20 4:32, Frank Li wrote:
> [ EXTERNAL EMAIL ]
> 
> On Mon, Oct 19, 2026 at 01:34:26PM +0800, Junyi Zhao via B4 Relay wrote:
>> [You don't often get email from devnull+junyi.zhao.amlogic.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> From: Junyi Zhao <junyi.zhao@amlogic.com>
>>
>> The SVC I3C controller IP can be integrated into SoCs from different
>> vendors. Peripheral resources associated with the controller, such as
>> clocks, may vary between vendor implementations.
>>
>> Rework the driver to separate common functionality from
>> vendor-specific extensions. The common logic is shared across all
>> implementations, while platform-dependent operations are provided
>> through vendor-specific hooks.
>>
>> Also add a corresponding MAINTAINERS entry for the SILVACO I3C
>> controller.
>>
>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>> ---
> 
> No big difference. Needn't rework svc-i3c-master.c, you can add amlogic at
> svc-i3c-master.c directly.
> 
> Frank
