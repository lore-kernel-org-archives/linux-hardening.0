Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794425799;
	b=4o1lpRek/SBBeDwDp5NyZ4tFJGvMNayBHFC9GFuU34m0W0bpmpe2g7+ZCKFIQ7Aszzev
	 sErixxxDUXkrm3i7Qt6zjxe2r0DfjcObTEkeQZAy4dKCgOnvof2uaibykvEolkenVzbDy
	 Q2g4h9gKXyRO61Deiq+ZdxXqgvSOfMS5qkOtPaqJKpZNBx3FCV2sHoNanSh/wPOetyJ0E
	 J7Qf0lCnppbH4s35YqjTfPX/FI6qL8ePDPgBIBf5WcUR+sE+3aTC6UdN31oHDsWGT29jh
	 HDssZz2YqH1fqGZGmSHLxnP1tHWRVBzKjxiyoiclf4BGTrDFcgbB5lKbmI9SYyaAduQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425799;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=O2zSSZ3LgsR48s6DHy7cAhbbY3qEiRADsKkGUtubBNI=;
	b=sfVJpAPuwJSwKpLhK6D4VCwRpWOtPRd4s+3MZ6jczKca4PXipDZS33FzVjPaw+0mvBfE
	 9Dtx+tSkz6wAhs5semqpdBH2PcJPs1sfrN06J/I84eZyBipKQiXSKJzmPSgMGkkmKTW1F
	 3ya6rtPtOSbIgTqPLGNYubXy5gbPBk6nVe7emM2Ptsb5Qq1bxtMeEe/hJQ9XmJ1tWkz9P
	 4o6IHjpHpgwuq9NFuRddo1l169G/tUpWalA2O0OMoo+EXG2YEv1qxEV53wVTRW5JTGJGm
	 Rw2QEqe4XzW2QEpQpBV2T8Irc6M4r92GXClPXPH6HElLQ2VghvYsPrhTnpoIXrJd+zQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uz93G+e9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.14
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AB606A326;
	Wed, 11 Nov 2026 19:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A35AB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uz93G+e9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmSjV2YDJNxssXp+0FKmAZqYIr70jwJa/+of+P/uOKjKkACz01EVDzBKjektHkSV9iIBvTesEf3217fWFrj2QKiuABtGF42B17fhnoV2VYAYoiWsWVdvegxibPv+/wQ3HkvAT+8bulG4BQPtVzYwEUJapXprRLH9LrnEbfQyWG0NnFUHihv4IbjCtiEpAfaneNGKhV7YyipTfFeNOzwlcPII/4AW2FADiC0R1Q8fvwCLg8VRgFcx/vJkZCw2YDWGgUXU7oE6oRr+qjkQ4wU6437b/nBHdZ/sBUZgUc9RX/l8pIiMrBPktA1r4ut/vSDELKoJs+zNNC5qB+VcEUcxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2zSSZ3LgsR48s6DHy7cAhbbY3qEiRADsKkGUtubBNI=;
 b=bUTIPgcP0KPkLnYu+KKrNe7ydEXXFMPFftlErqfwsa0zfsHMwhdR9jtQviHMRe50EfBvgYxlV+GHvFiMI7Pt0LtfvTwZOR+wqd6s5o4iNMJqQl5jUPcakxwpPFfGxc791GszDrBzr0vimI+LKJ0wo7vNSgQb5l1FemunNKJqrVCq+pOt6Gqa2U5kNUhxvrZsJ22gBDvxJ14fkRxvE7tOb6L3TcQImHKJnDrR7VONW7VYhkdQMyZPJC7V4zuAR2/2g02Qr+4RV7c1l/j81J0zevIp8wzgEtw2z6I+YYE8Da71iHyfT+0xXbe67m2D67c/NlBjqSWE+MXJzsC6w49ITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2zSSZ3LgsR48s6DHy7cAhbbY3qEiRADsKkGUtubBNI=;
 b=uz93G+e9xIZaOBwa9BLar81fEJUqofNP3073L75pNP33IPfRyIlBvfB0gWxWJVeVBRZKJ5UtwNGLBGTfB3eAM5LH6zM9klohNRwUKhCJrmKO3PtSsjHFbA42oJGQdaizBESLjJ7YcbnD9D4qu8h19XlfLu0HxtZNt+loUo41tGxTrczXNFIumyfGYvcu27uaLhkh3re96roR/PhkQBuY9DgwuPgA6y4afJWC+GjJpJOzsVD6YwdBjqttxt91o7noNtptbMn5UWYjQa2D4MpqJxEvUXOONBWySmXlTIxGBRSayYgxAzNPxoH1KiZBWdbjcUaTbrXRki5DZJe0B6hhzg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA1PR04MB11081.eurprd04.prod.outlook.com (2603:10a6:102:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 19:36:34 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 19:36:33 +0000
Date: Wed, 11 Nov 2026 14:36:24 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
	linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com,
	Kelvin.Zhang@amlogic.com
Subject: Re: [PATCH v3 1/2] i3c: master: svc: Add amlogic a9 support
Message-ID: <avTDuCD1ipp81dwJ@lizhi-Precision-Tower-5810>
References: <20261106-a9_i3c-v3-0-804b69b9095b@amlogic.com>
 <20261106-a9_i3c-v3-1-804b69b9095b@amlogic.com>
 <au4LN40LQAHsPYZ4@lizhi-Precision-Tower-5810>
 <57c4941a-b944-4b32-83b2-4f37e3a840f1@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57c4941a-b944-4b32-83b2-4f37e3a840f1@amlogic.com>
X-ClientProxiedBy: DS7P220CA0117.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25f::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA1PR04MB11081:EE_
X-MS-Office365-Filtering-Correlation-Id: 434b3052-aa87-4de0-1961-08df402b176b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|19092799006|261028144727099003|10067099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261021135927099003|261021123027099003|261022115727099003|261021133027099003|261026121527099003|261026135527099003|261021121427099003|261021130227099003|261022075727099003|261026140227099003|261022113327099003|261026130827099003|261102123227099003|261009223027099003|261009221227099003|261009221727099003|261009223327099003|261009220027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	yUFq3tTPkp67Ba3IG7/InhrriJGRxJtwS6qfud5xRcg+ZdqeMcyQm0kaMIw3rbPQSdpDEZnMe4gbp5F56Fs8Y1pIEGfPjil1Rbqh/zPgtzox7kxy3UILJV7R3Rra++hfSzC0S3ILyblE40uV3HJHppYaGnW3ehm571pFYag285z+5TCzyMVjfWHIraG79RWp7Po7+gBZ01GfUw+UP/CU0j2118aZ5rBj0RMYhqudk62l+QC4/G/D4sicfMHFICrZ3OhSpNLTUd28V3OUDC8Ay47bCOjxzccekOyAkL+IKbceSo90tbncXPZLbnFd/R8AYAEZP/yuPd7osgsr7PXqvwHvyAdSnKMIZCWNwaCt4ZuS0JP55gONbvxU8D+6X5FD1xRtF9JWSz4Isk/dSR5aG73ScO6fzQq3MO7U3/wvG4EUvGD6crsTBykjgjhc8AwFzTcPiDpULzhD41k4jqUxrBNnRnMiBqpigbo6yiOtx5MgQNj4+eXMAyRY4FWii47ILXQTuY/NyjdXJ8VCUMFt2QR6kSnSbKgnqkO/C9rIWPUe4H1RPvrYnSQrHEqYlDuk5eaaKj0zyDtyTiwjCNiKRUzT5WRlsROrF9lSNwNxtmdxyJyLUaEq/GxefsQ45ln15Zuf6Qi5yZDaHUBwnvtPQy2O8GwpAR1y2hD7AHTqoxY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(19092799006)(261028144727099003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021135927099003)(261021123027099003)(261022115727099003)(261021133027099003)(261026121527099003)(261026135527099003)(261021121427099003)(261021130227099003)(261022075727099003)(261026140227099003)(261022113327099003)(261026130827099003)(261102123227099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(261009220027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZGT2RNZWVEMlFPMGxKZ0ZlODJnWFYrK1dGdU5EdUw5SEJjNFNPUTVhSVNU?=
 =?utf-8?B?TGx2NHltWU9Md3BGY2dYUmlDNEUvRE9XWUpoaS9OaThacFlPcVhoY2FsSHJ5?=
 =?utf-8?B?VUhrdzNDWW52YllKNncxR0dVZ2hWTzVheE1hZ2RCdWNiVHdseDBSR0xrMnNR?=
 =?utf-8?B?ZnM0SktKWlVsMXlvcllQcGs0RUdQa0hJb3ZuZUM1YXNrY2hVM0lObDRnbXc3?=
 =?utf-8?B?TmpTM1V1bUJ3QmFPZ1d6MmVWb2wxV0NjNDdtR1I2d1hadkJnemR1aVZmT2RO?=
 =?utf-8?B?eVhYR0MwK0VFUTUxbnVTTW5BRGd4T2hsdWVzTkFyeUdFdHM2ekFWWWtMTExL?=
 =?utf-8?B?ekRSQWlPODZUNytha1VpRVV2RTJ0cXA3WEVTNmYyeUtFVlhsODNQWUY2b3Zi?=
 =?utf-8?B?ZTJsbjFJSzdWU1BpTUtwWXZpY3pUenJ1OC8rK2N0Q0JhdGdVd3hSdmdETENP?=
 =?utf-8?B?OHQyVHgyUWFzQlBLVGlFU2lyUmRLcmoyaTJaSUdDTnBFQTIwc0g2VCtJMmFJ?=
 =?utf-8?B?TzIvSjB0UmtialQwVXhseXhsNnBSY3VNcUxYODNSQ0hsUVY2azhzTk5zSDBh?=
 =?utf-8?B?RGxCL1hSZTNTZ2sxb1kvRFcxdFlHWjBzMUZOY0N4SnRFZC9SZFNqZDRwTndE?=
 =?utf-8?B?TFFpa1pqNi9acDZBYVRlZk8zcm5oeURYNGhZRHptVHhNRy9ldjJkYWtUVUpS?=
 =?utf-8?B?cG9qWFVrM1lwb20xZGdyRnl1elFqNVUybzFqdmpYRHZRUGhCV21kVkRIOUlz?=
 =?utf-8?B?YnliZVhkRFdieTNPcG5JeGpQVldVSUFEY2RlSWJsd0Jqd0gyeTJsRktpb3ha?=
 =?utf-8?B?N1RRMlBrRWZpMHprWFZ1RW90TVBQSXVpUE0rT1VKUE9XM3dSSSs1YzZFeUdw?=
 =?utf-8?B?c1FUOHNIMEFOYTlnUk5FNlVMOFV1a2FwbithYjNMUWdNeVVid1lEOXlGZGdV?=
 =?utf-8?B?cGhobTFyaW5Yci9WQnBEMXRTWTdUZVUxVis1bmltOS9iY0M1anRPZ2Vza01i?=
 =?utf-8?B?TTRxeitTSTE1VURDVGpNZEVzeW9jMWYrbWhqUlVYVFgvVmYzeTZXdUF4K0dP?=
 =?utf-8?B?cFkva2JHVEtGcEVNWkE4Yll0TUVRd05ueEtoWndGOVQwN1JWSHBONDlvdlZS?=
 =?utf-8?B?K0dZS2JFSzZtR01KN1J0RkllYTAvWDZraC80cklWekp5ZG1URmYydEJOSHRI?=
 =?utf-8?B?WStNNnVLUkRaQ0RiWE5tR3lQNlZ2cjFlSnYrTE1pY0xnVElOU1J5Qk9xT3F1?=
 =?utf-8?B?UDZoNFZ1NllxY2UyVld5WTdBTm9VSGlVT0cvMHBLS1BRQmpHVkhWS25vemt1?=
 =?utf-8?B?SXJjeWpzSmdmaldkYkZyd1VRUHVQa1NhR1A5Z1l1cmIxQmIyQUowUFVFaTRF?=
 =?utf-8?B?L1R0YVhNRkJ2aDRrbHUwdkMxdVFKVlNZeGtWRm1XQ2ZFWHpDY096ZDFaaDZy?=
 =?utf-8?B?VUZoaDRoYUI3YUZlM3BDVjdycjFYRzg2YXZDb2h6cmFsWGNscW5ldzRWQ0la?=
 =?utf-8?B?UXhPWlBVOUFSK1d2Z3I2dWtJaDBpVEJGUVQwdjc3aTRlVU05enhiSzRQNW44?=
 =?utf-8?B?b1VaYSttMkR3cm1EOVZMc2tPVjd6QnFhamtlMmN5M3NYTmdJTDkvUlJKSlEy?=
 =?utf-8?B?TUpDZ2ZoeUwydkJBaXNHTnFPNzlaNDl3aklJYzk1QjhjS0xSVUNvemRNdXFn?=
 =?utf-8?B?UGRGcngxN1JDL2haSnVhdmJwRkptR203QjdOUEhybW16K0FEbHlTVWN2cHRS?=
 =?utf-8?B?ZGFIN0wwZUhIUFBycWJ0S0NYMnVnaUpOWUhGSG1XRkRRT1JBR3RUbFRTWEVG?=
 =?utf-8?B?VXV3M0RhaUMydmljTWVjTlA2b1Y3VkU3WVFmSTc4aUF1dGloOUVmZG9VZVNh?=
 =?utf-8?B?NVJhYkNRUWRxT1F3bDllWWR5OGZFZkVjTzhGZGtBak1IMXd1d0tQVjVwckpV?=
 =?utf-8?B?SkpWWkwxTEx4THpJMktGT2NwQnFZRnpQRFhLNkRPbEpUMDF2azlkV2x4OFMz?=
 =?utf-8?B?czVENnp6Z2lkWHhsclQybjJ0Vmhrem5JZnhMcEloTXZHUlpzOWZpSTNQczRJ?=
 =?utf-8?B?NWpDZWcrS1JMUEEvWWdpYnVTL0NpQXZzTFNleW1YYU9zK0xnSDNLU01Bc21q?=
 =?utf-8?B?NjlNSVhJWG9URWFJK0ZFR1FMNkNUN0RqQSt6dkFiREZzVEN6RGdtVE00QnB4?=
 =?utf-8?B?aVRoWnBQT3l4bWQxOVRmMXVxQkNiSk1nb2J4NWtNdzhVcDhnbjYreS8xNnJX?=
 =?utf-8?B?TitONTgwaFI0SW1qem9VTDJQRlBGdUREdGhtem50Yi8zNTlzcmRVV21RMW9o?=
 =?utf-8?B?QXlOa1VJb3hTak5wNGx2aXpQV0RjWEZmWDMwc01rK25sRFVaTkJGLzNCNkY4?=
 =?utf-8?Q?JRs9ChlvjjfJh5VIf4dvrTEf7AVe6Hqxez17j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434b3052-aa87-4de0-1961-08df402b176b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 19:36:33.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV9/cLZGegaCFA0N+/AadtUtvVxbcDzDRJ+2GmWW41Fa8SMlxJymFLYANXL6F1AcXiZnCiStDa3VYeIISVo0R2SJpz6W6E+nU99VQAwACE5Qb0OvOBRXJYGUYdxS4E37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11081

On Tue, Nov 10, 2026 at 01:23:23PM +0800, Junyi Zhao wrote:
>
> Hi frank，
> 	thks for your review.
> On 07/11/2026 01:15, Frank Li wrote:
> > [ EXTERNAL EMAIL ]
> >
> > On Fri, Nov 06, 2026 at 03:13:08PM +0800, Junyi Zhao wrote:
> > > Amlogic a9 SoCs integrate the Silvaco I3C IP, and their peripheral
> > > clocks vary from the vanilla implementation:
> > >
> > >    - The EE-domain controller (amlogic,a9-i3c) takes two clocks,
> > >      "pclk" and "fast_clk", and the fast clock rate must be programmed
> > >      before the controller can be used.
> > >
> > >    - The AO-domain controller (amlogic,a9-ao-i3c) exposes only "pclk":
> > >      its bus clock is generated by an internal divider located in the
> > >      controller's own register space.
> > >
> > > Both variants need setup that the generic driver does not perform:
> > > the fast clock rate must be rounded and set at probe time, and on the
> > > AO variant the internal divider must be registered with the clock
> > > framework so that "fast_clk" even exists. The divider registers sit
> > > in the controller's own register space, so they can only be accessed
> > > while pclk is running.
> > >
> > > Add a vendor_init callback, invoked from the probe with the clocks
> > > enabled, to handle this. On the AO variant it registers the internal
> > > divider chain (div_en -> div -> gate) with the common clock framework
> > > and appends the resulting clock to the clk bulk array as "fast_clk";
> > > for both variants it then rounds and sets the fast clock rate
> > > (target 25 MHz). As vendor_init now runs after
> > > clk_bulk_prepare_enable(), the probe error paths that follow disable
> > > the clocks on failure.
> > >
> > > Extend the quirks bitmask with an Amlogic-specific bit
> > > (AML_I3C_QUIRK_AO) marking the AO variant's internal-divider
> > > behaviour. Since the driver now registers clocks through the common
> > > clock framework, SVC_I3C_MASTER also depends on COMMON_CLK.
> > >
> > > Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> > > ---
> > >   drivers/i3c/master/Kconfig          |   1 +
> > >   drivers/i3c/master/svc-i3c-master.c | 274 ++++++++++++++++++++++++++++++++++--
> > >   2 files changed, 263 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> > > index da96d2aaa..ac7d246c2 100644
> > > --- a/drivers/i3c/master/Kconfig
> > > +++ b/drivers/i3c/master/Kconfig
> > > @@ -47,6 +47,7 @@ config AST2600_I3C_MASTER
> > >
> > >   config SVC_I3C_MASTER
> > >        tristate "Silvaco I3C Dual-Role Master driver"
> > > +     depends on COMMON_CLK
> > >        depends on HAS_IOMEM
> > >        depends on !(ALPHA || PARISC)
> > >        help
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > > index e700392f0..aef56286e 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -9,6 +9,7 @@
> > >
> > >   #include <linux/bitfield.h>
> > >   #include <linux/clk.h>
> > > +#include <linux/clk-provider.h>
> > >   #include <linux/completion.h>
> > >   #include <linux/errno.h>
> > >   #include <linux/i3c/master.h>
> > > @@ -166,6 +167,31 @@
> > >    */
> > >   #define SVC_I3C_QUIRK_DAA_CORRUPT    BIT(2)
> > >
> > > +/*
> > > + * AML_I3C_QUIRK_AO:
> > > + * AO is the Always-On domain on Amlogic SoCs (remains powered in suspend).
> > > + * Its clock is generated by an internal divider located in the I3C
> > > + * controller's own register space.
> > > + */
> > > +#define AML_I3C_QUIRK_AO     BIT(3)
> > > +
> > > +/*
> > > + * Quirks shared by all the Amlogic A9 I3C instances.
> > > + */
> > > +#define AML_A9_I3C_QUIRKS    (SVC_I3C_QUIRK_FIFO_EMPTY | \
> > > +                              SVC_I3C_QUIRK_FALSE_SLVSTART | \
> > > +                              SVC_I3C_QUIRK_DAA_CORRUPT)
> > > +
> > > +/* Amlogic specific registers */
> > > +#define AML_AO_I3C_FCLK_DIV_CTRL             0x304
> >
> > Do you have other registers after 0x304? Is it possible create indivial
> > clock driver for it, reg space is such as 0x300..0x400.
> >
> > I3C use 0..0x300
> >
> > So needn't distinguish w/o AO.
> >
>
> e.g. I3C_AO_DEBUG_MODIFY at 0x308.

Does it use in I3C driver?

>
> 0x300-0x400 is not a clean clock block.
>
> Its registers are only accessible while the controller's pclk is
> running,

You can set pclk as parent clock, so access's parent clock should be
already enabled.

Frank

> so its state is tightly coupled to the controller's own
> power/clock state.
>
>
> > Frank
> >
> > > +#define AML_AO_I3C_FCLK_DIV_EN_SHIFT         8
> > > +#define AML_AO_I3C_FCLK_DIV_SHIFT            0
> > > +#define AML_AO_I3C_FCLK_DIV_WIDTH            8
> > > +#define AML_AO_I3C_FCLK_EN_SHIFT             9
> > > +
> > > +/* Target fast clock rate of the Amlogic A9 I3C controllers, in Hz */
> > > +#define AML_I3C_FAST_CLK_RATE                25000000
> > > +
> > >   struct svc_i3c_cmd {
> > >        u8 addr;
> > >        union {
> > > @@ -195,8 +221,11 @@ struct svc_i3c_regs_save {
> > >        u32 mdynaddr;
> > >   };
> > >
> > > +struct svc_i3c_master;
> > > +
> > >   struct svc_i3c_drvdata {
> > >        u32 quirks;
> > > +     int (*vendor_init)(struct svc_i3c_master *master);
> > >   };
> > >
> > >   /**
> > > @@ -2011,6 +2040,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
> > >        if (!master->drvdata)
> > >                return -EINVAL;
> > >
> > > +     master->dev = dev;
> > >        master->regs = devm_platform_ioremap_resource(pdev, 0);
> > >        if (IS_ERR(master->regs))
> > >                return PTR_ERR(master->regs);
> > > @@ -2019,27 +2049,43 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
> > >        if (master->num_clks < 0)
> > >                return dev_err_probe(dev, -EINVAL, "can't get I3C clocks\n");
> > >
> > > +     ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
> > > +
> > > +     /*
> > > +      * Vendor specific setup may register additional clocks (e.g. the
> > > +      * internal divider chain of the AO variant) and program clock rates,
> > > +      * so it must run with the clocks enabled.
> > > +      */
> > > +     if (master->drvdata->vendor_init) {
> > > +             ret = master->drvdata->vendor_init(master);
> > > +             if (ret)
> > > +                     goto err_disable_clks;
> > > +     }
> > > +
> > >        for (i = 0; i < master->num_clks; i++) {
> > >                if (!strcmp(master->clks[i].id, "fast_clk"))
> > >                        break;
> > >        }
> > >
> > > -     if (i == master->num_clks)
> > > -             return dev_err_probe(dev, -EINVAL,
> > > -                                  "can't get I3C peripheral clock\n");
> > > +     if (i == master->num_clks) {
> > > +             ret = dev_err_probe(dev, -EINVAL,
> > > +                                 "can't get I3C peripheral clock\n");
> > > +             goto err_disable_clks;
> > > +     }
> > >
> > >        master->fclk = master->clks[i].clk;
> > > -     if (IS_ERR(master->fclk))
> > > -             return PTR_ERR(master->fclk);
> > > +     if (IS_ERR(master->fclk)) {
> > > +             ret = PTR_ERR(master->fclk);
> > > +             goto err_disable_clks;
> > > +     }
> > >
> > >        master->irq = platform_get_irq(pdev, 0);
> > > -     if (master->irq < 0)
> > > -             return master->irq;
> > > -
> > > -     master->dev = dev;
> > > -     ret = clk_bulk_prepare_enable(master->num_clks, master->clks);
> > > -     if (ret)
> > > -             return dev_err_probe(dev, ret, "can't enable I3C clocks\n");
> > > +     if (master->irq < 0) {
> > > +             ret = master->irq;
> > > +             goto err_disable_clks;
> > > +     }
> > >
> > >        mutex_init(&master->lock);
> > >
> > > @@ -2163,9 +2209,213 @@ static const struct svc_i3c_drvdata npcm845_drvdata = {
> > >
> > >   static const struct svc_i3c_drvdata svc_default_drvdata = {};
> > >
> > > +/**
> > > + * struct aml_i3c_ao_clk - container for the AO variant's internal fast clock
> > > + * @div_en: enables the internal divider
> > > + * @div: bus clock divider
> > > + * @gate: output gate of the generated fast clock
> > > + * @lock: spinlock shared by the gate and divider register operations
> > > + *
> > > + * The clock HW structures are registered with the clock framework and must
> > > + * stay alive for the whole driver lifetime, so they are kept along with the
> > > + * shared lock used by their gate/divider operations.
> > > + */
> > > +struct aml_i3c_ao_clk {
> > > +     struct clk_gate div_en;
> > > +     struct clk_divider div;
> > > +     struct clk_gate gate;
> > > +     spinlock_t lock;
> > > +};
> > > +
> > > +/**
> > > + * aml_ao_i3c_tail_clocks - register the AO variant's internal fast clock
> > > + * @master: I3C master controller
> > > + * @parent: parent clock of the internal divider chain; must be "pclk", the
> > > + *          only clock the AO variant exposes (see silvaco,i3c-master.yaml)
> > > + *
> > > + * Register the internal divider chain that produces the AO variant's
> > > + * fast_clk and append it to the clk bulk array as "fast_clk". The caller
> > > + * must run with the clocks enabled since the divider registers are
> > > + * accessed during registration. The appended clock is prepared and
> > > + * enabled here as well, because clk_bulk_prepare_enable() already ran
> > > + * in the probe with the original clock list.
> > > + *
> > > + * Return: 0 on success, or a negative error code.
> > > + */
> > > +static int aml_ao_i3c_tail_clocks(struct svc_i3c_master *master, struct clk *parent)
> > > +{
> > > +     struct device *dev = master->dev;
> > > +     struct clk_bulk_data *new_clks;
> > > +     struct clk_init_data init = {};
> > > +     struct aml_i3c_ao_clk *ao;
> > > +     struct clk *fclk;
> > > +     char name[64];
> > > +     int ret;
> > > +
> > > +     ao = devm_kzalloc(dev, sizeof(*ao), GFP_KERNEL);
> > > +     if (!ao)
> > > +             return -ENOMEM;
> > > +
> > > +     spin_lock_init(&ao->lock);
> > > +
> > > +     snprintf(name, sizeof(name), "%s#div_en", dev_name(dev));
> > > +     init.name = name;
> > > +     init.ops = &clk_gate_ops;
> > > +     init.flags = CLK_IGNORE_UNUSED;
> > > +     init.parent_data = &(struct clk_parent_data) {
> > > +             .index = -1,
> > > +             .hw = __clk_get_hw(parent),
> > > +     };
> > > +     init.num_parents = 1;
> > > +
> > > +     ao->div_en.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
> > > +     ao->div_en.bit_idx = AML_AO_I3C_FCLK_DIV_EN_SHIFT;
> > > +     ao->div_en.hw.init = &init;
> > > +     ao->div_en.lock = &ao->lock;
> > > +
> > > +     ret = devm_clk_hw_register(dev, &ao->div_en.hw);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "failed to register %s\n", name);
> > > +
> > > +     snprintf(name, sizeof(name), "%s#div", dev_name(dev));
> > > +     init.name = name;
> > > +     init.ops = &clk_divider_ops;
> > > +     init.flags = 0;
> > > +     init.parent_data = &(struct clk_parent_data) {
> > > +             .index = -1,
> > > +             .hw = &ao->div_en.hw,
> > > +     };
> > > +     init.num_parents = 1;
> > > +
> > > +     ao->div.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
> > > +     ao->div.shift = AML_AO_I3C_FCLK_DIV_SHIFT;
> > > +     ao->div.width = AML_AO_I3C_FCLK_DIV_WIDTH;
> > > +     ao->div.hw.init = &init;
> > > +     ao->div.lock = &ao->lock;
> > > +
> > > +     ret = devm_clk_hw_register(dev, &ao->div.hw);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "failed to register %s\n", name);
> > > +
> > > +     snprintf(name, sizeof(name), "%s#gate", dev_name(dev));
> > > +     init.name = name;
> > > +     init.ops = &clk_gate_ops;
> > > +     init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
> > > +     init.parent_data = &(struct clk_parent_data) {
> > > +             .index = -1,
> > > +             .hw = &ao->div.hw,
> > > +     };
> > > +     init.num_parents = 1;
> > > +
> > > +     ao->gate.reg = master->regs + AML_AO_I3C_FCLK_DIV_CTRL;
> > > +     ao->gate.bit_idx = AML_AO_I3C_FCLK_EN_SHIFT;
> > > +     ao->gate.hw.init = &init;
> > > +     ao->gate.lock = &ao->lock;
> > > +
> > > +     ret = devm_clk_hw_register(dev, &ao->gate.hw);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "failed to register %s\n", name);
> > > +
> > > +     fclk = devm_clk_hw_get_clk(dev, &ao->gate.hw, NULL);
> > > +     if (IS_ERR(fclk))
> > > +             return dev_err_probe(dev, PTR_ERR(fclk),
> > > +                                  "tail i3c fast clock failed\n");
> > > +
> > > +     new_clks = devm_kcalloc(dev, master->num_clks + 1, sizeof(*new_clks),
> > > +                             GFP_KERNEL);
> > > +     if (!new_clks)
> > > +             return -ENOMEM;
> > > +
> > > +     memcpy(new_clks, master->clks,
> > > +            master->num_clks * sizeof(*master->clks));
> > > +     new_clks[master->num_clks].id = "fast_clk";
> > > +     new_clks[master->num_clks].clk = fclk;
> > > +     master->clks = new_clks;
> > > +     master->num_clks++;
> > > +
> > > +     /*
> > > +      * Keep the clk bulk state balanced for the following
> > > +      * clk_bulk_disable_unprepare() calls (error paths and runtime PM).
> > > +      */
> > > +     ret = clk_prepare_enable(fclk);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "can't enable fast_clk\n");
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +/**
> > > + * aml_i3c_init - Amlogic A9 specific init, called with the clocks enabled
> > > + * @master: I3C master controller
> > > + *
> > > + * Register the AO variant's internal divider chain and round/set the fast
> > > + * clock rate for both variants.
> > > + *
> > > + * Return: 0 on success, or a negative error code.
> > > + */
> > > +static int aml_i3c_init(struct svc_i3c_master *master)
> > > +{
> > > +     struct device *dev = master->dev;
> > > +     struct clk *fclk;
> > > +     long fin_freq;
> > > +     int ret, i;
> > > +
> > > +     if (svc_has_quirk(master, AML_I3C_QUIRK_AO)) {
> > > +             /*
> > > +              * clk_bulk_get_all() preserves the DT order, and the
> > > +              * binding restricts the AO variant to exactly one clock,
> > > +              * which is always "pclk".  So clks[0] is the input of the
> > > +              * internal divider chain.
> > > +              */
> > > +             if (strcmp(master->clks[0].id, "pclk"))
> > > +                     return dev_err_probe(dev, -EINVAL,
> > > +                                          "invalid AO input clock\n");
> > > +
> > > +             ret = aml_ao_i3c_tail_clocks(master, master->clks[0].clk);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     for (i = 0; i < master->num_clks; i++) {
> > > +             if (!strcmp(master->clks[i].id, "fast_clk"))
> > > +                     break;
> > > +     }
> > > +
> > > +     if (i == master->num_clks)
> > > +             return dev_err_probe(dev, -EINVAL,
> > > +                                  "can't get I3C fast clock\n");
> > > +
> > > +     fclk = master->clks[i].clk;
> > > +     if (IS_ERR(fclk))
> > > +             return PTR_ERR(fclk);
> > > +
> > > +     fin_freq = clk_round_rate(fclk, AML_I3C_FAST_CLK_RATE);
> > > +     if (fin_freq <= 0)
> > > +             return dev_err_probe(dev, fin_freq ? fin_freq : -EINVAL,
> > > +                                  "invalid fast_clk\n");
> > > +
> > > +     ret = clk_set_rate(fclk, fin_freq);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "setting fast_clk rate failed\n");
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct svc_i3c_drvdata aml_a9_drvdata = {
> > > +     .quirks = AML_A9_I3C_QUIRKS,
> > > +     .vendor_init = aml_i3c_init,
> > > +};
> > > +
> > > +static const struct svc_i3c_drvdata aml_a9_ao_drvdata = {
> > > +     .quirks = AML_A9_I3C_QUIRKS | AML_I3C_QUIRK_AO,
> > > +     .vendor_init = aml_i3c_init,
> > > +};
> > > +
> > >   static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
> > >        { .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
> > >        { .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
> > > +     { .compatible = "amlogic,a9-i3c", .data = &aml_a9_drvdata },
> > > +     { .compatible = "amlogic,a9-ao-i3c", .data = &aml_a9_ao_drvdata },
> > >        { /* sentinel */ },
> > >   };
> > >   MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
> > >
> > > --
> > > 2.42.0
> > >
>
