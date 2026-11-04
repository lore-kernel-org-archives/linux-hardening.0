Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.159.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793762360;
	b=anWciSUlTK4yAiY0SsofX5H5+XrO9yfbgtoAD3e6QyUiaS+Mkxo0GLHsF5rxlK32BlIQ
	 tAiOnRsvYw7rDvDOiZydNXRIeoyLH3djrAAMiQXEN5X+zdca4Aob8OM2YpULlxxpyfuJa
	 30MHQ++H0KexQ27OGwm7oUdBG7NVHM2YcGALlkpmvkuGjcmER96XWLNuBC9kNPzNPZ5qo
	 wODotXXMW5pcDDsGSa/Vpb9Up1wxlpCo+1T7ZLQr1IbQ7fZluh1uH46Unqv9wH3Z5/OjN
	 ZuJpVlkOJvQ+dBGbAZrlDbHRUb/8ESKZonVxMjn2Qy6NmFbVj1nf+rA5FqGcjPbcxaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762360;
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
	bh=SXtrBbmGOYkPkFX0HZwSlk0aemHbz+sUGKOT2HS83rg=;
	b=AWOVaGSoDxN95vm5QGGRjoseozw3C/j50rMZiWzrv+G3w6tM70TlZttg68LRi94e/cFX
	 psH65aQChKXzZENzCwNPa7jryiSdR6eCrVH5qHoFr/mc2uZoSrWgLxR+ARB/ND7Wxn7td
	 qaVEgoGzEfnpf0J9eqxCGnkfYeRdbDhrBDsY8q90CgdzCn7P9sEzj4Xy5Y+khv7jGXcfC
	 m14G+iE1sKaYSBtsta9Lbli07u5lUZMHgsgvCSs8s27mSdPWkTU4jw+R86EW4uie0MBpt
	 rQXN6JXgS2TA9B9XK3+QMSVAQV8W6UtrGPCp1GQfbfU9xkVEzdie2xDzUU8aZQkCg0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GK+DpVSt;
	arc=fail smtp.remote-ip=40.107.159.30
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFD606A328;
	Wed,  4 Nov 2026 03:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9DFD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GK+DpVSt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+UOr9dE28RY6b9f2rIMVXBtu73U//gN51zaiVR8q/wiU/WSp1wpd5qHm6rR1KlBOCXO6c/LUFZiKT/gzxnpBokooKjSoS9ZN57q5Z0QYx8djQgqPzQA0s4Xa1Pz1vkElGJIWdOSPA/ZM+lordmrFk1AnBMopQq7v0BjLm6Cxs2huONN9iHcts1x+8Z6gjNSyLyVLq7gGNGZAKoUpaDWey5/i9hNimX8GH3HNyrf78NH4Z82jfgJ2BGOIyUR66vDf3lNAYJSaxTtTqB2DH14vAiRgu/WdL9ox4rd6H3yylwZKRyiT66EH34QML99ky+HR0a+eKcT//wBMXYYNKYXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXtrBbmGOYkPkFX0HZwSlk0aemHbz+sUGKOT2HS83rg=;
 b=tlrvXSmxn/QhZaCiEiPzeXIaH7Y/keU+shEU2GFhnbkT6cccB21Jc2vst4WFXZeLPE2JlmDvD2KjzI6FcXi6mjWq+s7RjiWt9VF3c1ulkYJyDz0V5FeCF0/gcMwyXpI4AzuppwFbGxVH2hswmMthB+P3vKb/eiqTB/gsYA5ejN4l6oucGZMIOyCZVDd5m6/xk50m+EVMxhTcbI+vtwT737RQvctOWs+OYm/Pbb/DwHiSNYV6XP6la//yOdlVO0kKx/lC6aKEiICbaHaVSX/alVNFJCXu2QIJo/1B8HaoxnWDfN6RSYEyRNMMGw2kG/PqjFTNOrtizCZWEMqiit0E3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXtrBbmGOYkPkFX0HZwSlk0aemHbz+sUGKOT2HS83rg=;
 b=GK+DpVStA+PsE0AFyVAAiXKQjNCZgabsD/dls6lKX56OxcyiMGf0TL+UjUL4K6cqLWNMKWxB+RgsCSyucZCjxciOopL9pbCd2/iJe/HEl4bX20HkTK6kFcyZrMvQO1YxkeID9sm20T7zzcMgNd9/egFrjKkuHpbR/Vf0k8MmPk3q5M+CVEV4t9sMBoxlvtLtp6EirtNxbd6GZ9iCMXmKxWAMXT5dqkGkGmNLDBF2zJ5hDBuW6B92z5ZO4fv1TaGV9L7pDTpOZ8ifDl6D0Sf3VBhHVgeVR7kKpkLS2VBMKU4DknPP1Sfm/xGD5LTCpt2hNyOAz8cgrC7lcYL0vi+Wog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8518.eurprd04.prod.outlook.com (2603:10a6:10:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 03:19:16 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 03:19:16 +0000
Date: Tue, 3 Nov 2026 21:19:04 -0600
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
Subject: Re: [PATCH v2 1/2] i3c: master: svc: Add amlogic a9 support
Message-ID: <auqkKAKRZZ0pA-R3@SMW015318>
References: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
 <20261102-a9_i3c-v2-1-0c474bfccffa@amlogic.com>
 <aukKRUYfEABgIruC@lizhi-Precision-Tower-5810>
 <2210c679-0577-49b9-b8c9-fffe1d88baed@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2210c679-0577-49b9-b8c9-fffe1d88baed@amlogic.com>
X-ClientProxiedBy: PH8P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d591225-4db7-40ef-edf1-08df3a226830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|19092799006|261102123227099003|4143699003|11063799006|261022105027099003|56012099006|261021121427099003|261026121527099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	K+MdkxuqIYTcmOlJEWCX86TSKwZPkum377kiklIJEN8hBK01ccwx04KPEJboaf5pXRDaSn0YWIoOfltxGtloomcAXEy0/Tim0Ji4NfOKUNzf+lab7QjLmnXk2VEr2qwXpE5cdBroBtJJq/l6z0BXNgEpUfBSXmfwA7e7r2iX+QsstQL939sK6Y5QFl9N35VVaJDXxTw2ZFn4ERW9kLXCxlz3P6yRKHlrHjzv0M84gda12EUpgTlbJ2QmuyKZtQZb0NkXS+MPPy1N9ZH40KDe++TJJH1RM7WAC6H4FNHwKB6SyKVkh9cpjmkHX/kxQ6ml11R9n2ZGdYiS13HGVL0ShQl9Ole5GdHnKY+GCPCwU7Oey0xyOQTSwj/s9zYKcVuKiDb3U9czvCiRSUkUTbEZeIiacbwL5bw9guAPDtt9LZztXeFnx5LKr1bnZ3pXHBu7NfKvfoIWMOXYfsepQqt2RHnEoqds52+MECXsnfkQqI5wb1h7R6Te6/09NdnysWhdHbHT6YIprzS7rD+FeLXEE4PSxUoBcVRaO852hC4YPTs2elBuuHVFu7zIUFkysNJK23xMGZ9GTjo2s/9DeMYut00rT3v//s4YXyuACB0tTI2j4WY6mRx+iqn3CNdr5Q5XcEsXlkgCAzgp2x+Ns3O51Z2KJuIUelTM72HRUqxSOzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(19092799006)(261102123227099003)(4143699003)(11063799006)(261022105027099003)(56012099006)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzhaWlhJQUVmY2VZeUdMUUlOcjdiQnRXU1YwMmpGSllhNjhGMDduYkxCWG12?=
 =?utf-8?B?RU4wTUZYRkh5aW5yQ2xwSjg5Z3Z5VlU5RXE5TlFKa0g5eVVOTE9QWjJ2ai82?=
 =?utf-8?B?R01Gdi9Ld1l0QUFWVEp2eGJ1VHAvZUxzdXkzUElWdE5vMVlTSHVHc21tanNJ?=
 =?utf-8?B?Mkd0dVVZNEp5NEltQWY4c3Z3YjZqTW9GQWVxeSsvN2ZsSk5veVFDTXZ5bzhO?=
 =?utf-8?B?NXU4K0dnR0pHYTZxdVh0cE5lWWp3QUdmaklUZWFNVThqeXp3YjFTYkNZZStl?=
 =?utf-8?B?YStEU0FHMThkMjhhY3o2dVEwZm84RHg2N1p2SWYzZmRRdkplb00vK3lrUWdF?=
 =?utf-8?B?dnlRRnp6MlQvMXdKOGNCblN1TFBtd3dGdnFKcDk0NHpXYk83NmpZVTFFMWE1?=
 =?utf-8?B?STZpWFYzNENtRDM4ejAzVCtCY2tYNHRHMEQ1eG81bFViZVJXeXBNTzZsWW1w?=
 =?utf-8?B?Z0w5dWlra3YwSFlkSmxxbTdiaUJmUC9TUEhpbzF6YlBaZ3BMaGdndi9LRTFZ?=
 =?utf-8?B?cmo3RjBuWnlJZkxuT2ZaaWhVUGhncE8zNm5mdnFrbTN4anQ5YVF1ZzBhMzlQ?=
 =?utf-8?B?YlNUSEt0VnAvWGU1eEEwSFN6TjJ0cXZYL3MvTnJMVU1Uam9FaVo5TzdNaDZi?=
 =?utf-8?B?THhlc3dqUE5mY29BWkRGMXVXeTlCTkFEcFNxYjZmSjEyaW1tbWk1Z2VZbnRv?=
 =?utf-8?B?OCtac3BRa2c5ZkNyRkUxaGV1Ky9pYVdtNk4yV090eWhiZ2dyTzR4MHV1NVNZ?=
 =?utf-8?B?VVFSbWxldXRiR3JmUjFERU5wbHg0aDdlNlJvWVYyUUhyZzFMdDNGNXRCN0VP?=
 =?utf-8?B?cHEydUh2TSttcnFGcU9JaURUNW9MRlFmYTM2M0kwdDRHQlorNUcrSExkRnJi?=
 =?utf-8?B?THQxbXZmTFkzMnJjR2JvcGllVmFZM2p6YkM3clZ3NkFST1c5NmwzajZkM1Vz?=
 =?utf-8?B?QTJtWVJUOFVCNjAwYWN5WVQrUGR5K0Urek4vUUtDdUJoWjhpVGgrV0c4VnJl?=
 =?utf-8?B?V21xc3M1TjJDcnF5UHl3aVl5UmVpc2c5Tkc2WUo3NGNickRFRmZCcm81VWtH?=
 =?utf-8?B?bjBJbWdYdmF0ejUrSUExVkpGNUR0ZXVmd2dhd0hzMU9kREd4a256Y2E3VUs4?=
 =?utf-8?B?cnBXOTBnamt5akQxTmxoMXIzV0ZvNlJvUEpkaXJieU9XT1JIOUxEVjZYUktv?=
 =?utf-8?B?REgyRmwrSHV6Y2hRNmdKN3IzMkd5UXdEblpEcU1aNEJXQk1pdVA0aldVYUNy?=
 =?utf-8?B?ZHRRU1gySDMzMmpRNUpLL2FWY29za25uc3Uza0RjK0hobnMrM2E0UkRoRzB4?=
 =?utf-8?B?V3M5elZ0U2xuTXBVdXNZY3FIdGN6N0phT3Y0Q3YwWGpBTnRQUHFaeitiQVBP?=
 =?utf-8?B?REFPbWFDVGJiei8ySFZSUGhRNEc3eDNFNllDU2JpSkFkcWpQb1pOMy91T0lu?=
 =?utf-8?B?cnBvbUlpN3cwNzdieHZMTlhpeWZ5NkFjVENUZzFWMHNwV2RvamJrVzJ0QzZp?=
 =?utf-8?B?MzhoOC9qeUxEckNEa1VzMFQ3ZG9GM1FLenVxbDUzQjYwVTlmWk5WNTZYazBQ?=
 =?utf-8?B?N1dibDNGVElRRGl6eHpCOUsvdktFZkVYL0Q0T25DSGNGUWQzUFdhYk13djdW?=
 =?utf-8?B?UEoxOEFoSituR2ZwRXF0ZkJyZmVEYlJvSlRWeDVpelZ6TXQ0WW8zUWxtV1FR?=
 =?utf-8?B?MVRxWHZEUlVJd1FnN1pwZE1Bam8zUm1OQkFiNEZ0ZWczNDNTVHBEbytRcFBp?=
 =?utf-8?B?VDBRdXFockVpNFUxRFp0eHFSNjJOOFJKTmNRSWJhRmhTc3Q1eVVEcTJGR1M2?=
 =?utf-8?B?TGJBak9NdEw5Qkx6c1J4eitzZHFYb1lvT0Y4aWtXcnBEd01YbGVnREdteWE5?=
 =?utf-8?B?SUVXZTJQQm9WNlI4RXVzZzNsZ0pleU1RaHAxdlJjVGthYnRCME1sa0IvQ243?=
 =?utf-8?B?ek9oemsvZS9JSzQxekwwSEdOcTBlMDEyMkVrMzA0b1VsZEdxNHUvR3duWFBv?=
 =?utf-8?B?ZC9yRDJTWkJ2clhEcHZDajM0d05NY0FuQlNLbU0yOUE2Y3kvM2JBZVJHTXJF?=
 =?utf-8?B?VDM4Vm1ac3h4VkdKb3ZKM1pJdGRnNUVxaUREOGpSUzJNYWRrMlluTXFsbm5E?=
 =?utf-8?B?UW0yM3NmcHdJakRPdXp4K0hBclVVODkzTER0OXptUGZ1Q0VQRVpmNmVIN3Nk?=
 =?utf-8?B?Vnh3YWN0eEpRQnM3aE1LZHEzaW1xTUF6RysxNUFVL0oyNHNDbDNMWHpwTHg3?=
 =?utf-8?B?NHlPc09jNEtnaE5hRnpleWo2OHRqaTk2T2ExOXNlZWpPcjBWcVlVZ3hCay84?=
 =?utf-8?B?aUZENXVGYWs3NlN3dWlhS0k0eWZ5RnFJVVVwU2dLZTZyb3ZEM2tYYngwV3lr?=
 =?utf-8?Q?oQalsozGHjycacRtDOuutLzLydHZt+2edvPES?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d591225-4db7-40ef-edf1-08df3a226830
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 03:19:16.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n8ET5vm9fPQyp3hcchvUN3YVSHwXHrJgU2HBZ5+cQ2CI2TA+ysg4QQDKyMk51yR247nRNM8hM6X5xva7u16VYK5lbSZWArWpaGnBPq4g49c3okdsMmHAH4XgRSS3VRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8518

On Wed, Nov 04, 2026 at 10:44:59AM +0800, Junyi Zhao wrote:
> Hi Frank,
>
> Thanks for the review.
>
> On 03/11/2026 06:10, Frank Li wrote:
> > [ EXTERNAL EMAIL ]
> >
> > On Mon, Nov 02, 2026 at 07:05:39PM +0800, Junyi Zhao wrote:
> > > Amlogic a9 SoCs integrate the Silvaco I3C IP, and their peripheral
> > > clocks vary from the vanilla implementation:
> > >
> > >    - The EE-domain controller (amlogic,a9-i3c) takes two clocks,
> > >      "pclk" and "fast_clk", and the fast clock rate must be
> > >      programmed before the controller can be used.
> > >
> > >    - The AO-domain controller (amlogic,a9-ao-i3c) exposes only "pclk":
> > >      its bus clock is generated by an internal divider located in the
> > >      controller's own register space.
> > >
> > > Add a vendor_init callback to handle this clock setup.
> > > Add a vendor_quirks field to describe AO-specific behavior.
> > >
> > > Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> > > ---
...
> > > +     int (*vendor_init)(struct svc_i3c_master *master);
> > > +};
> > > +
> >
> > why need move this struct
>
> because callback need param struct svc_i3c_master *master， and if not，
> compile error. undefined.

Most likely svc_i3c_master need save a point for drvdata in future.

You add forward declear before drvdata

struct svc_i3c_drvdata;

>
...
> > > +static int aml_ao_i3c_tail_clocks(struct svc_i3c_master *master, struct clk *parent)
> > > +{
> > > +     struct device *dev = master->dev;
> > > +     struct aml_i3c_ao_clk *ao;
> > > +     struct clk_init_data init = {};
> > > +     char name[64];
> > > +     int ret;
> > > +     struct clk_bulk_data *new_clks;
> > > +     struct clk *fclk;
> >
> > keep revise Chemistry order
> >
> will change order：
> 	struct aml_i3c_ao_clk *ao;
> 	struct clk *fclk;
> 	struct clk_bulk_data *new_clks;
> 	struct device *dev = master->dev;
> 	struct clk_init_data init = {};
> 	char name[64];
> 	int ret;


longest is first

struct device *dev = master->dev;
struct clk_bulk_data *new_clks;
struct clk_init_data init = {};
struct aml_i3c_ao_clk *ao;
struct clk *fclk;
char name[64];
int ret;


Frank
