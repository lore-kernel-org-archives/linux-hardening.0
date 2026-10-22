Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792669453;
	b=blU9OrOj/0diYHRxPRRDWW5ThlJOvp/JBXJyeccEhg8THW/NDjcHIaryhSdYMeZao8Ak
	 54MEM0YVDA6LecLUD1LZ2DztrbypEdJTLSv4Tm9U5Rf2zN+8F3YIyLxnrLCrB63ek11Va
	 +sfDqmwhqq6w1sW7GUW85T6oS/AnH5zDtmD+b/4o0bgG9YpQGWYiUiqQ/eSEwsYjztd0T
	 BuiY6anYSZsWAh7UuYfYABSSCY18TnY70ZI/fxVhlZfl/7/9clpAogfv3ZIvqf3wIDuOg
	 uadJuRlit5eyq/Ah+t39qeuLo2w9M2xXW+PePLWMyPECfWJtp2KUSmcbQPqNnpzDDQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669453;
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
	bh=uGIx2mYr1H8b/VUYu1u/ApjefmPuM8Lgrnb8EdFNicU=;
	b=2GHx27BXam4URleLDQTtAUKZ1UWO8AYftEVSxkEuBCb3R5b8k2B9RtMvO6KkdqinDP2V
	 MIyZUjU4m6cd8Wr0uJzBsM/rcHhT7bfyqBkiyf25KPdE/SSgAs9Yg31dylGbihYZp/t6j
	 PiVi7StQtYxQDdX/fqlZ6gBAkZbgoBkcIdZ9MSbJVwiw2Npx3jV1y28oJBPPMkNTMWp8w
	 E+0QwOo5yXgmJjMR056szwiVJ3gWOLIKW4TQDV530k/fgIbReLqb4wq2nKsPmvONwBp8T
	 2qJ5RSba5ZqTlufxUVGMpgul3Ua24gAUELI7yeBgMrxx/EK7lWugcCn2UXHfT23JtQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=ESMczTLF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.124
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023124.outbound.protection.outlook.com [52.101.127.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C76606A319;
	Thu, 22 Oct 2026 11:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19C76606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=ESMczTLF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leXb9mQ41wQTfImzSJfgoJ6jlT/z7Gt0jxK4uN4a1emQ2DuGmSM05W3bRr2VgwEUndZVaWGAwkSW+C5VzxwYFxI66YVIFaotNXLO+8DlmM2HUwAJeXMf+ZmQSnDA7tdynZx74c5lbdmTuOzyT86sk/9BZSYCbT8Ml254fFDJP+hCcOV9q5zsUxGhsk+9qJJjeR0g4JVDH6639CtPzfcEz6r09TP2fiLqd26UiAbL0eCT77guuNpNOWLVSuNUwWvegppOaIIBCKDcwAG4/2FqzDFY1ww813CPEgkpwYQLb9quhN3Ws+JS5EAMsttkripFXHRgfFBM+s003hsyK6fFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGIx2mYr1H8b/VUYu1u/ApjefmPuM8Lgrnb8EdFNicU=;
 b=VWya3e5ASXIb07T5c5Ws/lbFlqbOKkYrsGT1Vu7MHZkNM+lvwmjGDP1Tf6H4649Jl8ad532kQtMJ8cBiY8jB3P/05u1aSBgPsis5OCULE3okN+C/vcdMpR8EtbJP78wZSsCuRWJzE31dYCA4siDxvNEiAFb0wWUJ6FZYSB6TWNdCRGAjas+qMLXHTMSXxbKATcsnc10p2jZvpj71Jcg8+t87XnW1Ms8Xi2DkBBjYqzMW8Yi4Aq6O4NmssRyI3bFIpsXYlepOKDdRUJ3E6CjtPF7DegBGEdPEc7GGGm6yvnfHeXf+ukDUtIw8R0ZHr8bR3ZqfuzofSChxu2rtQ91NQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGIx2mYr1H8b/VUYu1u/ApjefmPuM8Lgrnb8EdFNicU=;
 b=ESMczTLFf36ctASmNazIVHo0JurFI6+teFaNGPHFzeThsWOgNI9TmMbKJw8qD75rorAepWUyOU7fhp6u/9mWgw7QAV72Qed3i9n2aNPu9MY9ySQ7cTVW29zFCx6Nsi3i/d8fSK359NASFq2BxYCrEN6HadclsVhDAZjoH/mwO4DwaRZ0ncQr/EFGq+FJn1+9nNobZgeuK2uTTZOqr4Xd6bmb+IUEVyty6hWhIISx3CQy6nw4QJm88CJPLkHFCEJvb4RxtyQlP3RJzQMF6U94P8ROffnRGsNMsVcY4+/fIbQ5NdqypiEkLJsuPZUZ2EwPovuTVJXCTG1Nominy5m1nQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by SEYPR03MB7968.apcprd03.prod.outlook.com (2603:1096:101:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:44:09 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::7f51:5771:90c4:8c40%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 11:44:09 +0000
Message-ID: <4da3cd55-0115-4817-a19d-18a69b7a7cc6@amlogic.com>
Date: Thu, 22 Oct 2026 19:44:03 +0800
User-Agent: Mozilla Thunderbird
From: Junyi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH 1/3] i3c: master: Rework SVC I3C to support vendor glue layers
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
References: <20261019-a9_i3c-v1-0-329d819d621f@amlogic.com>
 <20261019-a9_i3c-v1-1-329d819d621f@amlogic.com> <atZ-YyEmG-KvUZAF@SMW015318>
 <887f0b2d-3a05-418b-bda5-0b01abbcb409@amlogic.com>
 <atjOD0PwVGDeh2uL@lizhi-Precision-Tower-5810>
Content-Language: en-GB
In-Reply-To: <atjOD0PwVGDeh2uL@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To TYZPR03MB5743.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|SEYPR03MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 866d1f2f-de9f-48a4-f2d6-08df3031c8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|261021121427099003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|261021123027099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xscYFe5Vw9zyXLI4Y+XnLybhG71tO1NWPjaU4fJVcpZwwtGn7aBMEl+4/2s6qWkTRGsU+bGX9d5usagUeD9BmMnCv0Jf4OHUmPATY0DbDGzd4VKPlKahL/hrLkZkTaPkT5or3b89MsQyGSpSEvxosOAKU+wpyAMN33cqONF8BqF24JCfmyfMvlQdi7uQLaJ6u9dTZw50xQWBqZtn/he+5twJOLC8JNzCzIZ8mVymcI6dTd6dgFRjbVNfAwKnTubL81dcC6W8WC4XHdtrB8/cQ0j49lf+3g/6PSRbklf9wrCWosqE1uZduvDjvTzuNDG+MR/LXc5JQMWqagTQXLRd7UDSKPQ2m+hP+rQ/SShExPf/7R5Z681OsowlyHlHPwZz8PUX8ca5OHIRHUBYIeCNGo2Ge/AaFTIHczksmlwXxxMP7uILVOjpXn1xjoOfRFbHcrF/1SiT4GjWhf00OcowMkW55QngG4yZSv0zsKR7YpYqdEu7csNz94EWtncbtLHC2sdj4LDHRREBWgquAxfbWrgfZrmdDnC7HfFmCa98A70u8VLbtgDPaiJyqYMbbdXOsOx0UMLhRqC3iUKyVwSOjGhP7fFtUalG5kVoEfQjKUwZm5RezLWr7KxFjliZGdAxt4UoFUOvnn2rPPp+XtnROmf+18Lw3x9SvknpO7QbKnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(261021121427099003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021123027099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1M3Q1VlWXNJMkJhNFBxY2lIL0Z2R1Zrbk5Lb1doSE03NGZHSFF3MDg4RXVh?=
 =?utf-8?B?Mk5BRlFBL2pqd2R1cGJSY2tCSjJSeUYraFowQXcxSTBZWTJqUit0QlFMOWg1?=
 =?utf-8?B?aTdQdzgrZzdidzIyc0FCcjBIQUk5TlpvNWo5eEhwa1QwQmZGS3R6QUJRdTJK?=
 =?utf-8?B?dWNkSm4rZmg5d2luaTFRcHV0bC82aEw5UWE1VzZBSUpPSmZPWmQ0MzJEVjBn?=
 =?utf-8?B?MGkyRjVxQThhcXU1RGlxSnV0VUNVOXJRMFdUY3crSVllWkxOYUsrek52LytD?=
 =?utf-8?B?TU5NV3FUZDczdWZlSHFWeGZRbGhOZHN6ZUhldVZaY2pwUGtYM1BDOCtRQU14?=
 =?utf-8?B?a3RTMW1GOHFLQmIyVC9oeG1iN2UxL1g0TzFVb2ZJcDI4bksxbjZ6b2JhcWVT?=
 =?utf-8?B?bHVPQnNnK3A1UmtqbGZ6NCtjV2luMmRCN2hENUZzNGpLOGc5NkR2Y01yQmcv?=
 =?utf-8?B?NFU2UUNLRmpwTXE1Tm81SW9ndUFkSmJIMkMwQWFFV095M3U1RXZtOFhmSnhG?=
 =?utf-8?B?cG5OWnlsei9jRjN2VEwxcklqcWlnanMzOG9rWXRrajVtWlZBcW5xSEd1QUYx?=
 =?utf-8?B?QkdLWjVxajlPQlZZUzVBNmY3L1pPbVBHdEtvNllubnY4SkgzVlY1MGdnSGZ4?=
 =?utf-8?B?aFhUY3Vzbm9XbUlaK0hNTVI2YnRZclVva2UzT3daY21KenNtMnB3cGhMK1Er?=
 =?utf-8?B?MEZ2UW1PTHArSHJIQ0xSYlllTDFZZnIxK3JZT0l5T3E5ME5CTVhTT2QvWm43?=
 =?utf-8?B?M21USW9jU0hJQmZ6NmFDeE9vb1NHNzBZSHF6Nk1sTXdsMmNMZFR2WFVWZjhT?=
 =?utf-8?B?R3Q2K04reUNpMzZGYXVtYkllTGVZRGJqbnVnVk9ZYzQ1N0FCaHhsNUFkYzlp?=
 =?utf-8?B?TEw5bVRjS2lUSkt0cll3R1RZR2Z5NE1hVFFjSGdWVU5VZjZJbVViNHNDdXZk?=
 =?utf-8?B?NDhQYWtjQmFlWDJSTWovVWtwRDE1NnF1QmVZY2dZMHd3N0lxTjVBTlFNT1g4?=
 =?utf-8?B?MTZYYmRGb3NscnFvMFozRlRhWUV1ZWp4VDZVZDJkSExVLzFoRmxRQlVKSnRh?=
 =?utf-8?B?WmQxeUxOMG1YdkZ0R01sak5qSXBKNkxaM0RwdDRpck1pOGtYWWNMd2d4bGxV?=
 =?utf-8?B?dE4rZXJPckJwZk1RZWFyZkR2a0xlVHBJMzB3MDhtRERWZjJHa3pscGxqZFZj?=
 =?utf-8?B?Q0lOM3RkbDhwaWc4Y1RyZU1pWFBEUXN4MHRjTUVUQkJObWVqYnBKTTh1UTUx?=
 =?utf-8?B?UVIrMitEQllCZkVMNUZEY1cyMnUvMkk0OVR3ZHRyWnhpbzNCa1E3aFlzSXNu?=
 =?utf-8?B?UTU4RmlmSXhqSUVtZkJ1RGllRGlod0pKYVRBSHR5eFB4Mmpsall2ekpyQTRQ?=
 =?utf-8?B?WjhrbEJvaWtqb1Z0MzlkbGFyQjZUM3BzT3ZFZ01XUVlPT1o1RnRRK0JNZi9h?=
 =?utf-8?B?TEY4ZWVvaVNsSjcxVklvd1FnR1ZrU1RmWDZFOVJ0R3VQLzdZWDFlOTNtN1k4?=
 =?utf-8?B?MU5ROWlKdWFFNFVkM3IrYXFBK3lzYkUzblhCZzZ5SXpab3VTUWV2SHVXT0Qv?=
 =?utf-8?B?Z0ZqeHBCdEtuNit1RzRoSXdhdVR3YnRiL1lBekZBS0VUSnZOMVMwU3dSTTRT?=
 =?utf-8?B?RHIwMlA2VEZ5VHQ3dkFmSzlGRnBtbGwrTkNyai9vS2FBSXZ1YjUzM0E2cks5?=
 =?utf-8?B?TGxFQXdSSXZwTlJoY2xaQTI1TWZkZ1FHajU1K3E3VU4wY2JMb2xjUEhEdHR2?=
 =?utf-8?B?WjNRTjhLWjBudklzd0JjcHhSb2dYTWV3WGNSbG1hNlpLbXloS0hqOE1SR1dm?=
 =?utf-8?B?M0RCOG92a2pSSHQxR01uYzRoanZLTjc1aE9QeEZhc1pGM1FiRHlIaktFSjdv?=
 =?utf-8?B?eWJVbzZiMTdIb2VySWxiSFVaRDJpc2djaGxqN3NDWnNNWjhYWHhGV0pDM1FJ?=
 =?utf-8?B?K0JGZFE4bGlIeVZQRjVOUS9uRjJYMGtCS3VkN0hqR0lab0RlRFpEbERUaHUz?=
 =?utf-8?B?a2ZtSkI0dkVvam5jaFBtS2hoM2JRN3ZHSG44RmxWUGo0RERCTkt0cUpwUDlh?=
 =?utf-8?B?ZjViaktsQXoxOVZxNUpIVmNEak9ZQUxMK1M4aCtlU3ZuNjNYUkpHejhqM2kv?=
 =?utf-8?B?ZmdDYlNFL29kWjNocmx1eXcwUUZkK3VaKytPb01PUnZVM3RWeGRLbGZmdGNK?=
 =?utf-8?B?TVliYWVVaFVkMFFjcWRDMDAwQS9KL1lxSGt6Yi9PRzVaQ0tzVDVyd25VbVhx?=
 =?utf-8?B?NXQ3QnM0cnQyYmhabjEzY0FScVY5TWpJZHVmdUpHTkkyNHNjWkZJYWx5Z2M5?=
 =?utf-8?B?eDd4M2h0b1VaNGYxYldhNjV4QXlXZjdNNkZZZ24xTGlMNTRVSGI2Zz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866d1f2f-de9f-48a4-f2d6-08df3031c8ca
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:44:09.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umr+7D8HDT8iInYpkHMKhgwXiUWQUTzd51vHW+4eiomhd1+3BATaAYNi4rW43O13rZ/nnEibtqBOsG+CtyyZeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7968

Hi frank，
	thks for your details.

On 21/10/2026 22:37, Frank Li wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed, Oct 21, 2026 at 10:56:19AM +0800, Junyi Zhao wrote:
>> Hi Frank,
>>
>> Thanks for looking at this.
>>
>> Amlogic A9 used the same SVC I3C IP engine, but the integration of it
>> differs in the resources *around* the controller, which cannot be
>> expressed as another quirks entry:
>>
>> - On the "ao" instance the bus clock is generated by an internal
>>    divider (I3C_AO_FCLK_DIV_CTRL @0x304) programmed directly by the
>>    driver; there is no CCF clock to clk_set_rate() on, while the
>>    common probe assumes the fclk is a plain enable-able clock.
> 
> If it is in I3C memory region, you can do that by use callback. otherwise
> should go through clock framework.

The AO divider register is inside the I3C mem region, so I'll
handle it with a drvdata callback. I'll also evaluate Neil's suggestion
of modeling it as a CCF clock for v2; if that works out cleanly, the
callback goes away entirely.

> 
>>
>> - Amlogic added register blocks outside the Silvaco map: a
>>    DMA bridge and a bus monitor (0x200..0x22c).
> 
> Does DMA bridge only for I3C? It should be go through standard DMA engine.
> 
> what bus monitor use for.
> 
>>    Enabling the DMA bridge later will need hooks in the common
>>    transfer path.
> 
> We also need support DMA in future.

Yes, the bridge is dedicated to the I3C controller, and the data path
will go through the standard dmaengine framework: our SoC-internal DMA
controller has its own dmaengine driver, and the I3C driver only uses
the standard slave API .

"DMA bridge" is a small set of registers inside the I3C mem region,
  which adapt the I3C FIFOs to the SoC-internal DMA controller. 
Programming them is part of the I3C controller initialization, not part 
of the DMA engine configuration.

The bus monitor is a debug block, not necessary, i will drop it.

> 
>>
>> Adding A9 support to svc-i3c-master.c directly, would make these
>> becomes if-branches in probe()/PM/transfer paths of the shared
>> driver, and the next vendor repeats that.
> 
> You can use callback function in drvdata.
> 
>> With the glue layer,
>> i3c-main.c keeps today's logic unchanged: i3c-silvaco.c is the
>> current probe code moved as-is (rename with 79% similarity), so
>> blame/history is preserved.
>>
>> If the file move is the main concern, I can keep
>> svc-i3c-master.c where it is and only export the alloc/probe/remove/PM/
>> interface for glue drivers -- the essential part for me is keeping
>> the resource handling out of the common code paths.
> 
> Now, there are not much user yet. Rename or re-org only when it becomes
> complex enough.
> 

Okay， isee your point.
I'll keep svc-i3c-master.c as a single file and add optional callbacks 
to struct svc_i3c_drvdata instead of the split and rename.


> Frank
> 
>>
>> Also, per Neil's suggestion I'll try modeling the AO divider as a
>> CCF clock in v2, which should drop one hook.
>>
>> Thanks,
>> Junyi
>>
>>
>> On 2026/10/20 4:32, Frank Li wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Mon, Oct 19, 2026 at 01:34:26PM +0800, Junyi Zhao via B4 Relay wrote:
>>>> [You don't often get email from devnull+junyi.zhao.amlogic.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> From: Junyi Zhao <junyi.zhao@amlogic.com>
>>>>
>>>> The SVC I3C controller IP can be integrated into SoCs from different
>>>> vendors. Peripheral resources associated with the controller, such as
>>>> clocks, may vary between vendor implementations.
>>>>
>>>> Rework the driver to separate common functionality from
>>>> vendor-specific extensions. The common logic is shared across all
>>>> implementations, while platform-dependent operations are provided
>>>> through vendor-specific hooks.
>>>>
>>>> Also add a corresponding MAINTAINERS entry for the SILVACO I3C
>>>> controller.
>>>>
>>>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>>>> ---
>>>
>>> No big difference. Needn't rework svc-i3c-master.c, you can add amlogic at
>>> svc-i3c-master.c directly.
>>>
>>> Frank

