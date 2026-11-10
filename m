Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794288215;
	b=qWuPwtEKTrl5Tq0IkK6/d0DC7y8DLaeeGk889rLW+xAqpnhKBjxrj0YOLnJopSA9TquJ
	 LttihNSV3LVLBD7XgF6i1DKbyXhxNVFymUBNEka2B3LzkZRyw6BJgnGL0T0GLAwHwiF75
	 F2wzwyAQW4lhJUXvhbXbnhEl30P9sLyTgFjWTuRDUZrzlxzQ9a1+V1tlgfX3nEmZouyku
	 1RmpL/zwMJ5ouD+UrCV2HquiF8yIf4ftucXqFqu4Ojm0Ws68j8EpwGm3lmZirYMJQumQB
	 91AmqabEQa5kM5T0sB+srX1CjvQEBTPLsAo6caIVJQ1Rkp6XxH8/hyxg/ZU7SAAG7sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288215;
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
	bh=lmg2q/8fMM45c60ta76sqUovKUSwrsqzi6WOZ64SDXk=;
	b=Ey5OkqsnE2TvLRBJRtFgu+qJ1bALdg6+gu7FXrMoQFgGxSTbk3kQNUuhv/ZolNAiW7fn
	 gdFSJLfejqX4ClRbU+0HJFtVFoBmNVEnuZCf7H+zg7SeHiJetNK0cRfCp0d0aS3JQBdEo
	 2y4KwfU6Uu85C49P8ccs0LodrPI/RS7V0xel5JNvYydTdDxdCNoPPrpHQkb7T+suU4q1u
	 pGXRF7UiZwB6t1WbGBLAnXLs6Rfr0v5FBKhE75FVyz3eUTMy0JUjT9YtALe5BUp/IikX0
	 9K1aDVDbmWlM0Fd+9sn7IQ1RL5IHcUeG8cHeDknet7OyLpVdTamPDs9jbHglx7hNdug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=HHOXYz57;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.72
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023072.outbound.protection.outlook.com [40.107.44.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B3606A31C;
	Tue, 10 Nov 2026 05:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A06B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=HHOXYz57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZngd7SFdALF5blf+eSBjpQH3LaMIvqUxayS1HsPu95HPsMC2Dy9zsRiaITU4p/XKUTxmKmlzsNRZMp+76oddV2yIRbNg3kpnVHsuQX+lrrr31h/9QGCzT8/3IxbAeZSAvQvzmeCjpOvH5VVAbbek18z6eMvqEgS4cnaEY9nv06ToKXQzf9e9zo97o9TbTpAgy63WUITJSpzUeQ+GcvdpZVp3eugl6bvfHuD7g5fu8tGeStTa1cIV8ijyra06ifQlo+FGa+VRVmOAWjFouQbRH2IIlFz6/PyLFr8/7BPaveuG93oZbpXVRvZ29YNsF+MF6u3CoYQZFsiSkew9SrL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmg2q/8fMM45c60ta76sqUovKUSwrsqzi6WOZ64SDXk=;
 b=AMXP6K7fqArv8ylhPo7ni+gYHUjPIu0Xj6g9GB3GBcEBOmD8fYbjA0cpUQfMsDZBj324Dq9VNrEYXajugPCqxCO2qqc/HRSVJIUMCPm3tJeOIAdsFIlsGw7IXYbauIhhj/8Z3jA2GRBUEknDMJfQbKSC+9Mo85cy6UQtwBbUQ0dLor/3gcIJ6sELcM9YjwaiM0NEEos6feS9aGHvVeReaKbqTzBOwrMrYgT8ZaNwsLRc2Kb4z+Ecv/lRkDWMsizB4wxh5kSAOtxaipXjDFwH3V5vZNkAqFKaUc8tpBA8aijMlF49hCfXLDndfi8fg2O3XBE+7miRP4Sod9LnGNpEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmg2q/8fMM45c60ta76sqUovKUSwrsqzi6WOZ64SDXk=;
 b=HHOXYz57Ner/a2DQ3jqvueTgXqWtQ30SU5vsVORFGBVAEInO0PorXJ6VK8Hoj1xkDGUf1HV2z/jzBqXT02bkk/PPCWKaFqlDHj1/gCxxGpEwLzRUZS9FjTcHuL2WU0YqUhgbIhxnwsAfsCguYahSripYgAEMFuieV4x6Raq4x0vfRoH45Kg6IgnxjPV1pWw+h6BTwluIBfUXSeerJby5oDyU/mkLw4Gft9C43+805Vn9f1B5DdDA/hcqvo+EFWnOxct8K3rDWaq1hLg6hW1WOv93/+TpPps1fDwoD+jpmOi8sVm3WjUuyHSK5K7DDlMWgIkzSQYQ/6Oag81YNbsLJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by TYNPR03MB10331.apcprd03.prod.outlook.com (2603:1096:405:3c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 05:23:30 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 05:23:30 +0000
Message-ID: <57c4941a-b944-4b32-83b2-4f37e3a840f1@amlogic.com>
Date: Tue, 10 Nov 2026 13:23:23 +0800
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
Content-Language: en-GB
From: Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <au4LN40LQAHsPYZ4@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|TYNPR03MB10331:EE_
X-MS-Office365-Filtering-Correlation-Id: b94184ea-3623-461f-bad2-08df3eeac18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|261009223327099003|11063799006|4143699003|5023799004|261021123027099003|56012099006|261021135927099003|261026140227099003|261026121527099003|261021121427099003|261021130227099003|261022113327099003|261021133027099003|261022115727099003|261022075727099003|261022105027099003|261009220027099003|261009223027099003|261009221727099003|261026135527099003|261009221227099003|261026130827099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	HobjwqsW1pdIKbXNqGAPZcqqA2smhbP3Ecy4b3qfigmXoAyQ1Rba4X0OS8zJMpFVt063b4HKKkw9PtfgVinI9VhPyjq37WqRvCJQwMYrAyEBK1x+KvBXy95yiTN91jQluUdhQq/ZY9063/D0JU7ux7ESDakIQXo0AWo9k5fkDDt/ENihqqRrqC7+Q392+F7AVG388Vp4V098iX5YNkAzf1rNI8/EAELwfcXr+zRd046nN6XaxGzuAN/oXWsFUTKGr8vkedY68kqP60rFi/qtCd5Kwej+Ogaib8twedeYSu39Xf8Hik2Gsz4DHaKy9D8lUX8IUnhye3zgtfRK525gFoQSpiu5PwjCDQy/8rdBZ7alaLamJLRGDkJ4avnUjXu0yMUsG4f7sptmKBJnMkp+3kVbvXGRCcEg3rBeUhRbAeq4L4m4+4+kYIsVs6MtyQdUT9u5zhODcLDJRbPVJwApWhfUA64znZ9lFTGa0bo+sB80aA7t3T5vPTwTSbOrWM6CzdSMD7YvBg9910LeLXgtYEqLBRSexecHiaYUYLloGI9BHZPMwurouFiWVkSOtonJNgIeq8h+dTqZiy6uKNX+zZkY4MjaFl4aUMZlfXM78pOj28Sb3soL3q7ohDUa0nHzyLSzIzQPnCZAfBBr7sR8QmE6lyvktsekpjE4DcR5/6E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(261009223327099003)(11063799006)(4143699003)(5023799004)(261021123027099003)(56012099006)(261021135927099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021130227099003)(261022113327099003)(261021133027099003)(261022115727099003)(261022075727099003)(261022105027099003)(261009220027099003)(261009223027099003)(261009221727099003)(261026135527099003)(261009221227099003)(261026130827099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGp5eklWL2Q5R0NIOXorQ3lYMXovemtXTENjaitoSGZuWjMvcmpxWHhZYitp?=
 =?utf-8?B?SW53NkoxaGc4MU13YmVlLzM2SWg1NGFySVJRQWtyaUliZjJ3R3NRQzMxZ2Jx?=
 =?utf-8?B?aHRJUmhXQ0xhZG10ZURodENkaDkzcnlpbkxWbW9pblI3anVuRWY0TkgzVm1W?=
 =?utf-8?B?ekczdEdIckg2OFhsUTJPajJpSk5DY0pjSzFMNzNQQTg5ckJIUVlDWVlKaldx?=
 =?utf-8?B?TW1SY3JyeEhQc3JkaXVETGkwOVJ6L1p2TjFvR2huZWZhNXRyTEx2OUxkQjFU?=
 =?utf-8?B?MThWSWZ6MXV4Wlg3YnRoZllwRzY5Q2RVS281T0xHWmtpbGVEUnNwcis5NEY4?=
 =?utf-8?B?UUplSTFTQkpvdzJwMUR5V25CeVJqb3pkQXdSUldFbUNVa2dpRUdIcmtqWEJh?=
 =?utf-8?B?UWJHUTA5SmFnTTNpQzFZTW5hNnlVWHcvaXAyUG5ydGdnNExDb0FEUG9qRGh6?=
 =?utf-8?B?ejdrUS83WlB6cGpuNDAveE1MMEdZSzVzR2kyMVh0c3U4cVJ6SlhabHJYMi9i?=
 =?utf-8?B?dDBKR3I2ZmFWb3NmQTZSc3BmcmZLNlRqS1lVNWYyblRpMnlqQzFUUFpMREZH?=
 =?utf-8?B?OHNKU0lodS91Y0p1eTlKSk9yRTZHVHBEaFhURUJpMVVwaVRBSTVnTGtUeUN2?=
 =?utf-8?B?c3RIK28xZStmZVJDaU9QT0liK2ZEaytUNklPOGI5V1YzWVdTMTJORktqRlln?=
 =?utf-8?B?ckFjOU9yeEhNUlJHY25KTDlrSmFTQXNpOVcrVVFFd0RzTWZ0OVpQdllRK05z?=
 =?utf-8?B?TW9rS2tQUDZ3NmNhTWZFSnMxUTMyWVU0V1B0eHRhZnFrS0ZxNkJmc3NEbllp?=
 =?utf-8?B?aFRnUHl5bnlMcy93OFhLZERtbTM5cU9WTzh3UlZEUG82aFRtTkFMQUl2ZXRp?=
 =?utf-8?B?aFd2WEpPdms1ZWdvM1ZxR0pwT1BuTXV6ek9KclBmdzhZbmVDekxpYzFQcWF6?=
 =?utf-8?B?UERxSXRvZDRUcXV3L0g4aFBuZjR4N0RDM3NGYlZUc0NDNU1VV0tCRUh2RlBQ?=
 =?utf-8?B?QTYvYzVjcklZZ1JyOEZaWldGbU41aURjQ2gzZXFWVlR3SHkzY1VrekVVVVZk?=
 =?utf-8?B?WTRidVgrUVBERm9Ibkp6QTJXTmU4d2daYjM4c1VsdXVETmp4bDhOTXJTVjZQ?=
 =?utf-8?B?V3ZyRFo0bG5ESUFlSzRpMlh5NzlVSThlS05iZ2JCK1E3Y0lNaUhJNDA2QTNY?=
 =?utf-8?B?dTFtYzJ0dHBpSFh3K0p4ZWdkeUlGaFA3eDVyNGt1eG0xMk40RWdQa3Z2K0dZ?=
 =?utf-8?B?bWJkK0Z5Njc0TDBrZkkyVnB2TG5vUmcxMy96eTI1T0ZnaHhEaFArMkhXcHc4?=
 =?utf-8?B?bXRKK3pHSkU0YTJReHF1aEhDTWlsRUNhbkxsODlSOC9yZHBIOFlVTmNyeXRw?=
 =?utf-8?B?VlZEeWFDdXhNWVM0TVpBMzkxQ2M1S1poQjh4SHZtNWZkWFErb2VNN1ZPbFlk?=
 =?utf-8?B?ZFdzdllWZ0IzMStySzBWblJ1YURPckFjMTdaZDc1Y2F3Yjh1cVpxV1RpT0t4?=
 =?utf-8?B?MUJ3dlppeGt0Z0NJcnRwNHNmSDVEeEp2WTIzZGFML1ZQNE00TTcwSFI1am10?=
 =?utf-8?B?M05jajQ1WGhXc0EwaUJ2Q1V6eUdTUmZYdjFOeGRxZWR6TkF4WmRhQk1JbGdv?=
 =?utf-8?B?bzhSTU5Nb1paNGJYd3FrbFJDd245bXlxUVVsWHJ6TDdvWlV2Q1ptS2dJRjZH?=
 =?utf-8?B?Vm1qY05uRmNOcTg5OWlZbHVqV0JteVh5aGk5dEVMTGk2Szk0MWJXVUZwdXlE?=
 =?utf-8?B?UzRmRnR2T1JrTHJFNTlzcE1sR1JxbVhSUk1LU3pDTjF3MHJmQ0tRTVM4VEhu?=
 =?utf-8?B?NEtpcElpSWI5M0orbFg0bkpMWDYwU2RjVm1vaW1HME1tVExVSGwyVURNcVJ0?=
 =?utf-8?B?Zm9acDVyYXNKVzM2cXBHeGprdG91dTRlZWc4dDdPVjVpeE11UEhtamdrd2tK?=
 =?utf-8?B?WWRzZ1NhTytWY3NONHVLRzRMVzFIUTNlZ0tWbldGV0FMdkdMU1NvTDdyeXAr?=
 =?utf-8?B?VHEzNDFZeDFTWElPaDM1TXBTd2txWFhBWTFSN2IrVnlOalFRRnp4eXk2SUZi?=
 =?utf-8?B?eGxPbExLcjhLR1RjODRaRmpaNElwdDdINllJZTRvd2tETUM4SUtiNXJLbEkz?=
 =?utf-8?B?MGttVDdmRkJsNHFhbXhzeFBtTFhheWRXUDcxWHgvU1BtQWlwdEtwUmtXeXBv?=
 =?utf-8?B?elZRTFduaWNvM0oybWtjODMrTUkrMllkNktVNFplcmROanBZTXZBM0R4d3F5?=
 =?utf-8?B?WnBXRzJJVU9zTVlHTktzMWw2dXdCdW9UWnRMVUdWUWtvWkZKenc0SHhLTHhL?=
 =?utf-8?B?dHJMUDF0T1hDMFJaSjdONWRoeThDU2NKOWdrZ2pSdXNjYkU5K0xYQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94184ea-3623-461f-bad2-08df3eeac18a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:23:30.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4UU4ra0u8CeektN2y9PJzCjgKOIKiapdnKc25VbYMjegA6aOkWs6xvBumMb/L7cUeT57zVtt+wiGlQvgO3Vmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR03MB10331


Hi frank，
	thks for your review.
On 07/11/2026 01:15, Frank Li wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri, Nov 06, 2026 at 03:13:08PM +0800, Junyi Zhao wrote:
>> Amlogic a9 SoCs integrate the Silvaco I3C IP, and their peripheral
>> clocks vary from the vanilla implementation:
>>
>>    - The EE-domain controller (amlogic,a9-i3c) takes two clocks,
>>      "pclk" and "fast_clk", and the fast clock rate must be programmed
>>      before the controller can be used.
>>
>>    - The AO-domain controller (amlogic,a9-ao-i3c) exposes only "pclk":
>>      its bus clock is generated by an internal divider located in the
>>      controller's own register space.
>>
>> Both variants need setup that the generic driver does not perform:
>> the fast clock rate must be rounded and set at probe time, and on the
>> AO variant the internal divider must be registered with the clock
>> framework so that "fast_clk" even exists. The divider registers sit
>> in the controller's own register space, so they can only be accessed
>> while pclk is running.
>>
>> Add a vendor_init callback, invoked from the probe with the clocks
>> enabled, to handle this. On the AO variant it registers the internal
>> divider chain (div_en -> div -> gate) with the common clock framework
>> and appends the resulting clock to the clk bulk array as "fast_clk";
>> for both variants it then rounds and sets the fast clock rate
>> (target 25 MHz). As vendor_init now runs after
>> clk_bulk_prepare_enable(), the probe error paths that follow disable
>> the clocks on failure.
>>
>> Extend the quirks bitmask with an Amlogic-specific bit
>> (AML_I3C_QUIRK_AO) marking the AO variant's internal-divider
>> behaviour. Since the driver now registers clocks through the common
>> clock framework, SVC_I3C_MASTER also depends on COMMON_CLK.
>>
>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>> ---
>>   drivers/i3c/master/Kconfig          |   1 +
>>   drivers/i3c/master/svc-i3c-master.c | 274 ++++++++++++++++++++++++++++++++++--
>>   2 files changed, 263 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
>> index da96d2aaa..ac7d246c2 100644
>> --- a/drivers/i3c/master/Kconfig
>> +++ b/drivers/i3c/master/Kconfig
>> @@ -47,6 +47,7 @@ config AST2600_I3C_MASTER
>>
>>   config SVC_I3C_MASTER
>>        tristate "Silvaco I3C Dual-Role Master driver"
>> +     depends on COMMON_CLK
>>        depends on HAS_IOMEM
>>        depends on !(ALPHA || PARISC)
>>        help
>> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
>> index e700392f0..aef56286e 100644
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
>> @@ -166,6 +167,31 @@
>>    */
>>   #define SVC_I3C_QUIRK_DAA_CORRUPT    BIT(2)
>>
>> +/*
>> + * AML_I3C_QUIRK_AO:
>> + * AO is the Always-On domain on Amlogic SoCs (remains powered in suspend).
>> + * Its clock is generated by an internal divider located in the I3C
>> + * controller's own register space.
>> + */
>> +#define AML_I3C_QUIRK_AO     BIT(3)
>> +
>> +/*
>> + * Quirks shared by all the Amlogic A9 I3C instances.
>> + */
>> +#define AML_A9_I3C_QUIRKS    (SVC_I3C_QUIRK_FIFO_EMPTY | \
>> +                              SVC_I3C_QUIRK_FALSE_SLVSTART | \
>> +                              SVC_I3C_QUIRK_DAA_CORRUPT)
>> +
>> +/* Amlogic specific registers */
>> +#define AML_AO_I3C_FCLK_DIV_CTRL             0x304
> 
> Do you have other registers after 0x304? Is it possible create indivial
> clock driver for it, reg space is such as 0x300..0x400.
> 
> I3C use 0..0x300
> 
> So needn't distinguish w/o AO.
> 

e.g. I3C_AO_DEBUG_MODIFY at 0x308.

0x300-0x400 is not a clean clock block.

Its registers are only accessible while the controller's pclk is
running, so its state is tightly coupled to the controller's own
power/clock state.


> Frank
> 
>> +#define AML_AO_I3C_FCLK_DIV_EN_SHIFT         8
>> +#define AML_AO_I3C_FCLK_DIV_SHIFT            0
>> +#define AML_AO_I3C_FCLK_DIV_WIDTH            8
>> +#define AML_AO_I3C_FCLK_EN_SHIFT             9
>> +
>> +/* Target fast clock rate of the Amlogic A9 I3C controllers, in Hz */
>> +#define AML_I3C_FAST_CLK_RATE                25000000
>> +
>>   struct svc_i3c_cmd {
>>        u8 addr;
>>        union {
>> @@ -195,8 +221,11 @@ struct svc_i3c_regs_save {
>>        u32 mdynaddr;
>>   };
>>
>> +struct svc_i3c_master;
>> +
>>   struct svc_i3c_drvdata {
>>        u32 quirks;
>> +     int (*vendor_init)(struct svc_i3c_master *master);
>>   };
>>
>>   /**
>> @@ -2011,6 +2040,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>>        if (!master->drvdata)
>>                return -EINVAL;
>>
>> +     master->dev = dev;
>>        master->regs = devm_platform_ioremap_resource(pdev, 0);
>>        if (IS_ERR(master->regs))
>>                return PTR_ERR(master->regs);
>> @@ -2019,27 +2049,43 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>>        if (master->num_clks < 0)
>>                return dev_err_probe(dev, -EINVAL, "can't get I3C clocks\n");
>>
>> +     ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
>> +
>> +     /*
>> +      * Vendor specific setup may register additional clocks (e.g. the
>> +      * internal divider chain of the AO variant) and program clock rates,
>> +      * so it must run with the clocks enabled.
>> +      */
>> +     if (master->drvdata->vendor_init) {
>> +             ret = master->drvdata->vendor_init(master);
>> +             if (ret)
>> +                     goto err_disable_clks;
>> +     }
>> +
>>        for (i = 0; i < master->num_clks; i++) {
>>                if (!strcmp(master->clks[i].id, "fast_clk"))
>>                        break;
>>        }
>>
>> -     if (i == master->num_clks)
>> -             return dev_err_probe(dev, -EINVAL,
>> -                                  "can't get I3C peripheral clock\n");
>> +     if (i == master->num_clks) {
>> +             ret = dev_err_probe(dev, -EINVAL,
>> +                                 "can't get I3C peripheral clock\n");
>> +             goto err_disable_clks;
>> +     }
>>
>>        master->fclk = master->clks[i].clk;
>> -     if (IS_ERR(master->fclk))
>> -             return PTR_ERR(master->fclk);
>> +     if (IS_ERR(master->fclk)) {
>> +             ret = PTR_ERR(master->fclk);
>> +             goto err_disable_clks;
>> +     }
>>
>>        master->irq = platform_get_irq(pdev, 0);
>> -     if (master->irq < 0)
>> -             return master->irq;
>> -
>> -     master->dev = dev;
>> -     ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
>> -     if (ret)
>> -             return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
>> +     if (master->irq < 0) {
>> +             ret = master->irq;
>> +             goto err_disable_clks;
>> +     }
>>
>>        mutex_init(&master->lock);
>>
>> @@ -2163,9 +2209,213 @@ static const struct svc_i3c_drvdata npcm845_drvdata = {
>>
>>   static const struct svc_i3c_drvdata svc_default_drvdata = {};
>>
>> +/**
>> + * struct aml_i3c_ao_clk - container for the AO variant's internal fast clock
>> + * @div_en: enables the internal divider
>> + * @div: bus clock divider
>> + * @gate: output gate of the generated fast clock
>> + * @lock: spinlock shared by the gate and divider register operations
>> + *
>> + * The clock HW structures are registered with the clock framework and must
>> + * stay alive for the whole driver lifetime, so they are kept along with the
>> + * shared lock used by their gate/divider operations.
>> + */
>> +struct aml_i3c_ao_clk {
>> +     struct clk_gate div_en;
>> +     struct clk_divider div;
>> +     struct clk_gate gate;
>> +     spinlock_t lock;
>> +};
>> +
>> +/**
>> + * aml_ao_i3c_tail_clocks - register the AO variant's internal fast clock
>> + * @master: I3C master controller
>> + * @parent: parent clock of the internal divider chain; must be "pclk", the
>> + *          only clock the AO variant exposes (see silvaco,i3c-master.yaml)
>> + *
>> + * Register the internal divider chain that produces the AO variant's
>> + * fast_clk and append it to the clk bulk array as "fast_clk". The caller
>> + * must run with the clocks enabled since the divider registers are
>> + * accessed during registration. The appended clock is prepared and
>> + * enabled here as well, because clk_bulk_prepare_enable() already ran
>> + * in the probe with the original clock list.
>> + *
>> + * Return: 0 on success, or a negative error code.
>> + */
>> +static int aml_ao_i3c_tail_clocks(struct svc_i3c_master *master, struct clk *parent)
>> +{
>> +     struct device *dev = master->dev;
>> +     struct clk_bulk_data *new_clks;
>> +     struct clk_init_data init = {};
>> +     struct aml_i3c_ao_clk *ao;
>> +     struct clk *fclk;
>> +     char name[64];
>> +     int ret;
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
>> +     new_clks = devm_kcalloc(dev, master->num_clks + 1, sizeof(*new_clks),
>> +                             GFP_KERNEL);
>> +     if (!new_clks)
>> +             return -ENOMEM;
>> +
>> +     memcpy(new_clks, master->clks,
>> +            master->num_clks * sizeof(*master->clks));
>> +     new_clks[master->num_clks].id = "fast_clk";
>> +     new_clks[master->num_clks].clk = fclk;
>> +     master->clks = new_clks;
>> +     master->num_clks++;
>> +
>> +     /*
>> +      * Keep the clk bulk state balanced for the following
>> +      * clk_bulk_disable_unprepare() calls (error paths and runtime PM).
>> +      */
>> +     ret = clk_prepare_enable(fclk);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "can't enable fast_clk\n");
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * aml_i3c_init - Amlogic A9 specific init, called with the clocks enabled
>> + * @master: I3C master controller
>> + *
>> + * Register the AO variant's internal divider chain and round/set the fast
>> + * clock rate for both variants.
>> + *
>> + * Return: 0 on success, or a negative error code.
>> + */
>> +static int aml_i3c_init(struct svc_i3c_master *master)
>> +{
>> +     struct device *dev = master->dev;
>> +     struct clk *fclk;
>> +     long fin_freq;
>> +     int ret, i;
>> +
>> +     if (svc_has_quirk(master, AML_I3C_QUIRK_AO)) {
>> +             /*
>> +              * clk_bulk_get_all() preserves the DT order, and the
>> +              * binding restricts the AO variant to exactly one clock,
>> +              * which is always "pclk".  So clks[0] is the input of the
>> +              * internal divider chain.
>> +              */
>> +             if (strcmp(master->clks[0].id, "pclk"))
>> +                     return dev_err_probe(dev, -EINVAL,
>> +                                          "invalid AO input clock\n");
>> +
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
>> +     fin_freq = clk_round_rate(fclk, AML_I3C_FAST_CLK_RATE);
>> +     if (fin_freq <= 0)
>> +             return dev_err_probe(dev, fin_freq ? fin_freq : -EINVAL,
>> +                                  "invalid fast_clk\n");
>> +
>> +     ret = clk_set_rate(fclk, fin_freq);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "setting fast_clk rate failed\n");
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct svc_i3c_drvdata aml_a9_drvdata = {
>> +     .quirks = AML_A9_I3C_QUIRKS,
>> +     .vendor_init = aml_i3c_init,
>> +};
>> +
>> +static const struct svc_i3c_drvdata aml_a9_ao_drvdata = {
>> +     .quirks = AML_A9_I3C_QUIRKS | AML_I3C_QUIRK_AO,
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

