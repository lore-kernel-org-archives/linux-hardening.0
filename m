Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED485314A61;
	Tue, 26 Aug 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223278; cv=fail; b=HutBzF7LPwR9DmKU9H26aPiBnbdVXiIh/oFbu6GS1ctv0JQd/mPL8Yzz5knnBg1j5G2EpighLJG3VRygtX1Dw1W3OlzJ17+zr5GQehP7C0SNwD9POV7f/APV8/i6Rh7xabEGNUVn8ZK6Fk7Qc5Ya/bB1OKU4AB2FQ1S8oaJt2bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223278; c=relaxed/simple;
	bh=ROX28ktdg8jQSJRmG/V3nsIbx7SY/DVZmGUYad6jJSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nSavRswUTsw1lU7GRMEhidLz4VhO2fC/bYDzpt3kB9HDuw7KgnS8YOZ9SrT0KueyWLfQqWdN49ndobt2Uijb9WEoonCJ7E9v7MqKIOfOW/B2Sf9yzApOzXs8EBRw2KXvw1tlJvD4gwt+r/bABdlX1SG4AU0yNCVmuz+8ITyPEg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LDfPLwy/; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LDfPLwy/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lb1XHeMrh+cxbkwvjbCajGjH7+20svDiDjjEt5UGJnYHV6WuQhtajKR/ic/dMftaS6t8ZrYG2Aa/Fg5AWyBiVNhU41SZ01UNbK2Xz+trDdSXqYpQ9UbnqZbXqonEJCr9vEhsGln8d3mwDH56r4E6njApSsZ+azyJBRz6dZUirltG4bXzyLYa/Peitysrm3jfGYuo03R8ejUPLt+1Cx28njfyDnW14bPLMqPGDYWQWGQ0Qipj4edJizYMcDOGlI6aQ/aROKjSkX2rrUR008P0Z4e/3aJRQe6vO2ZM8v+w4jOo18qIQHzujyxkXOF32ieOBg7DzNAcXPB13gdCN9xhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFdizu9I15YcmgIX/1ZsTILL4noquikNKfhNbPaRdVU=;
 b=TVWxt+3RzWex0/YJabMUuIpp29m3QlSHE72Xmk9yU5kf6d+na6TWbltZdebbKI/j/bi9FyMfGIRzwzpJ2D9JP2WXPXBTiUgn478aY3HBnbEZkLOLuP/dSaFXVrFmBx1CTfAl2VxGxQITZ6Ei8/gUh02/L6RJvO9gHbn2+bXQnl3DIzQrAugEqdNf7g+Rm+fPMkys2ha2g2Xv7rKAydPH1g0BejHk3O0aVaWk30EU8vsXgyZOSoAIdmknVAXBe948kGZucKVDMpqmIxJg5rDg4T2bNNAEvQ+PclQlKFJeJJWHz4BCHq+XEPGerzwRTGLwh5rXN73aWmHavJ+uxEqQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFdizu9I15YcmgIX/1ZsTILL4noquikNKfhNbPaRdVU=;
 b=LDfPLwy/9/guV1dhPr01gE9CtUbRBt3B+fC909nvjTJN1cqBDN2j8W9nK6K8TKT36znJ9E2oMcYqppnAI9ZqLVuIS1l8MAceYyVGvp6HOI3ikfZtqqS0Dp2/V1W2/S5mygp3uSZq9MZTGNMw/p0CcThQjStePA0D1ZITdFAI0Rkynir7K4YhcA317ce1oEvuXYftNGEzw3AdjsQSCT9hfmlbt1jTYgA3F0uav24qktE9oAbbX6h06I4HW7XPR56EbnhwG7uYFbWttmAhZ2s91YE14e0N9LUZB1nMMN7p6PjX16H7ayGl1dW763sj3U9Epcr0ynWVMWVCOE/MI7vACA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB11524.eurprd04.prod.outlook.com (2603:10a6:150:288::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Tue, 26 Aug
 2025 15:47:50 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Tue, 26 Aug 2025
 15:47:50 +0000
Date: Tue, 26 Aug 2025 11:47:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, gastmaier@gmail.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <aK3XIUpVZYmHGiUz@lizhi-Precision-Tower-5810>
References: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
 <20250818-adi-i3c-master-v7-1-f7207902669d@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818-adi-i3c-master-v7-1-f7207902669d@analog.com>
X-ClientProxiedBy: AM0PR10CA0112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::29) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB11524:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d2af3f-9c3f-4389-af51-08dde4b7e9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0s5MTIwWkZ2WDlkR29nRVFPL3hhL0h5anVVRmNvWUlHZUkrZXcxTzFJMERJ?=
 =?utf-8?B?SzRnZnNpRXloWlozb1BCcjRHT04yWVRRakgvSmdSRXk1Q3Z1WS8ySW5uc0pp?=
 =?utf-8?B?bkViL05mT2wrQ2pSMGkvU3AvZXlmTlpRWndlVW1NbkR4bUYwUGtvYVZGeHpq?=
 =?utf-8?B?dWQwNlF4VmxYY3MxOWhPNmliekovYVpqTTl3eUpWU1Y2NFdvcGlxSWNpdG9Z?=
 =?utf-8?B?dzRIajJDV01MRWtEdmo2QXB0YXFhYy9aTGdIMnE0ZVBERzVaUEdGazY1Rzdl?=
 =?utf-8?B?V2cwU1VsQU1xSHNDN2VnbDFvZWN4SEZzT1NxZXIrbCt2cFpQeXBWUVRTVHVp?=
 =?utf-8?B?M0MyaTJ5c0xLZGdYelRpZ0hNckJiSEFLYlBkZmtiQmRtNTFUdnZzNi9JelVM?=
 =?utf-8?B?U3NkUHVSTWxFRTd0amlJUkMwaTBTcUNQTG5WUzFPU0FtV3U5Z0ZWUnZNd0lq?=
 =?utf-8?B?SzNKcy9xb25MMWxycVk5V2Uzc211dVBpKzRpOUJDdHhOVDdzeEI0eE9kRTNG?=
 =?utf-8?B?TlRMNWR5NHJOM1FhMk1Yak1IV24vMWwwYXNUUmo1V1o2WVlYU3JTaHplMDQz?=
 =?utf-8?B?cWUrR05qUklzUlYvQnlSN2dFSndJZmlMN1NDS2U3SFFPc2pKQlpOZVZpeFpH?=
 =?utf-8?B?b1NPb1QwMFZvSVpHRC9tUVE3YWtCelhtWnh2bmlEWHQ1S2RybDA2Zm1CZmlI?=
 =?utf-8?B?OGd6dlArUUhDQTdRdUwyNE5wamc5Z1FCVzEyU21MUWpQRFZGWVUrb3NCOXNS?=
 =?utf-8?B?cEk5TSszOGZxNFEzbDN0UWNjNFphMGZvd3ZwNzFFVGE3OFdMRUFmenJwOWo0?=
 =?utf-8?B?U293NDU1ZXFvTS9WMSt0MkRHOWNrZkZaOERGN3NsZ2tibi84Q01FSXdJOTFU?=
 =?utf-8?B?dktlSFdvZ2xXSzVwcFJ3S3lTRFFRZEFQVnl3S2UvOE1TTDNyVzFoeE5mdGhX?=
 =?utf-8?B?VmdYbUFqMk1YYU54UUFxRVFWWjdHUi9FWGtiSk9sdkFGcHdFN2RXYkpLS3Qz?=
 =?utf-8?B?anRvQXR6OXAyRzZHbjcrMElMUG5wYWpYeGhBOFhOOUlyV0FObXJZY1NXeWRz?=
 =?utf-8?B?RmxMaUh0TFBRc21GYW0vOWs4N2NVWG1zT2t3ZlNmNDVuc21XN2dIZHl3S3ZE?=
 =?utf-8?B?SHl0dmF1Q2dhb1BvTWxISnhhMTlENlE3aGdBL2k0Vm9DQzVuRFUwOTg1Zm5t?=
 =?utf-8?B?VFJrZGNNaG5mTmlJZ1B2MWprVjVETlhuVmtVRk53b25yUWREQWVEZzNxOVBI?=
 =?utf-8?B?cG1qSk5ab1RVbGlIV1FEZmNibVlvVUZWWWoxQlRTdlJBc3gxcEVaZVVubFVR?=
 =?utf-8?B?T3cwRWN5VmQ5UHllTVk1UjR5NlhDYkJSQUFGMGl3bXRkTTRGSWdiaERaaW1O?=
 =?utf-8?B?RlhJOVQxWXN4cENuamFWSk5neVVwVlF3bVFCVWdCRG51VWRHaHVES2ZCQUp3?=
 =?utf-8?B?THM3Ti96ZGtTY2xVcE1Hb1BBQmxlb2lHUDk5bUszcm5YUTI3R2tOaGFneVZH?=
 =?utf-8?B?NGxvZlQyMDVBOTdyRmNmK1VrUFlKa1lJdS9aK0JKMnBZSmVPVTRUdWM1citl?=
 =?utf-8?B?cGdJWE83WUkzOTUzQWJMOFlUMTJvblp0cW1kL2R2Znpja0VrNkJBYW1DV0xr?=
 =?utf-8?B?VDR3YlRFdnFtNTVKaWxEOU5iKzB5SEM5UTFzNzRMbVZrdDVaN04wUGxTS3JW?=
 =?utf-8?B?OXVyNVl5Z1YzWVZ3WnQrUkpNVk9ZU1VZVlg0Y0RqOEJZMmRTenpRT3lnLzN0?=
 =?utf-8?B?ZXpZTmNHMzBkVEYrZmtBYWxMY3RVUHVnN0xzLzMwVVJYRGxNU0IvSWlLdUNK?=
 =?utf-8?B?MEpLUTJQa3BBNEIyMkkrWm9INk9RbVExTmJkNjVmQ0d1MUVzYmJ4S2VrMFQ0?=
 =?utf-8?B?OTM3WEdsazBrbjBwQlliWW1nemhQcUhXbzN0RjhMKzMrN08ySmgwNVZvbEpk?=
 =?utf-8?B?UlBydko5bUpNMDVJam90RXZHQ2JJOUYveU5kQXJ4S1YxSzlMMG1SQTVLWlM5?=
 =?utf-8?B?MFlkSTFMdmNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXBQRFJwMWlHMStDMU9QRHhFOFdFVy90U3ZlWkViMldKNjVzU1MwR0JHQmlm?=
 =?utf-8?B?dDZRZ2pGSG1FY1M3WSt2bEpobWNmK0toa3hKSkVIY0ZldjBmSnNSWWRTSUp1?=
 =?utf-8?B?MmFmWEVyVDRmV1pDNmQ1NnpmaE51Q1ZYZFFaam14dlBLclRJeThPU0dPTU5l?=
 =?utf-8?B?NW50d3I5dGJyUkUrdW5ld0RiUm9sS2VFY0JsV3B4UG1tempjR25HbllyRk1G?=
 =?utf-8?B?S29xTitrYlc5UmVDT0VMYTAvdGxRZjBUdUJYSG5Nbk5xRmtienZ1L3ltbHox?=
 =?utf-8?B?bnBaSDhuTXNuOEdxR3JvRXdkb3ZRbDhxUlBON3ZDWE96cWhPRUNPMXZ3aEk0?=
 =?utf-8?B?d1RwK3RBdG1wTHZaQU9CUm9xMU1yUldJSm9tN3ltbGlwdUhoeWVWUW1VYXZh?=
 =?utf-8?B?czM0U0pXUVRTLzdEVjNwSWNMTEpUWUJRNE0rQS9yeFlLRzA2dGkvZVp5ME5s?=
 =?utf-8?B?QUUweDNhSEd3WldTZU9JQ0YrbHBPeVVSTEJnRUx3SjR0dWFrakdpUThSVzlu?=
 =?utf-8?B?R0QvRStNeFRjeERHNGVYMWp6RENjVldoVm0ybHE4UHhKRy9yTHRsVGhDOVpQ?=
 =?utf-8?B?ZFZoTzVGL3ZXN1JJdVgwR3VESHkrYWdWSjRqMnNlL3VWQTc0NTBPN2VXcGpm?=
 =?utf-8?B?QUg5MG5EMWkvQWxycnkxNFRudHJnbjNFZHZjUlFJTytDQ1gzVTNCU0VyQ0VL?=
 =?utf-8?B?aVpJaHNUMXFOb3ByN2dqbFRTdGFpaktjZ29UY0QyQmx2WVBaaVorLzdOZzRi?=
 =?utf-8?B?NCtqR1p1Y3g5WGtGaXlVOGwyMnZmQ3hkQ0sxcXhGWS9SeENDUU1saWxSak9H?=
 =?utf-8?B?c3pLQXlBSXk3Uk5MYzVscFU4cHh3cjBHQ1pFRkdZMDRmbkN5TG8yMEhJQVN3?=
 =?utf-8?B?d0IrQjNRREVSTy9TeHRGYzhvVWpLNElQVC8wWnZlRklDNVJyYkE0OXhjRGg1?=
 =?utf-8?B?UHpMSDdvSy91VjEvbnFpNml4Uk5vVHhBMUh6c2NYbVNwT01vZnA1NVlCMy9i?=
 =?utf-8?B?YXgxQ2lHeVBnQmpXa3BiMitEaFQ2YmtSd0t6NHBEYS9kUDYybnFLaDJjamFl?=
 =?utf-8?B?ZFdkLzZXUVVCaWxPNCtrZ2w3eDh0c2JXaEJqcDE1cnFBUHZqMkM1c2dNRjNS?=
 =?utf-8?B?NWlRc1FRT1luQzZWUnJzRjErNnBXU0d4ZTNoeFZSdS9CQWxWVTV5UEI3dXk1?=
 =?utf-8?B?Mmt6cmJDdEJyUE5Td05GWGZWejM4ZEh2Ly9zMFIyQ05WQWtYb2JpNVRLeFA0?=
 =?utf-8?B?L0hjamg4Z2FnYWNkNkZHY1BPWW8yaWsrYXpMZ0J1WnhwOUY5WnRuZVJ0MTV3?=
 =?utf-8?B?NEpBdXpJQ1BhTHlmY1dtMmUvZFJqUGJJRzFwSzA4NDVZZGo2SEhQQnVCais5?=
 =?utf-8?B?amRTZmxrMHRNUVJyZEVKTVZrU0FTeXlvOHFVZ09vS256MDA1ZXZhTEEzbXdq?=
 =?utf-8?B?WEhxRlEvVWRVRjYybEJWdENPcUpQa1B6ZCs2Y3ZjNHg1ZjdzTXNSMk94eDFq?=
 =?utf-8?B?RnZ3SVlmK2FHclJQWlQ2OWxXSTE0ZFgxYjE5blFFcFpyY2J0eFQyNkQ5MDB1?=
 =?utf-8?B?MkVlOERlNW54enFtdjlUeEJHZnI2L2tEQ1l4ZXV1QVpQUXVyaFU3amRqNVJT?=
 =?utf-8?B?V3VvTGtCR1RmL0lMSzVVc0w4UTJXaHU3OWZ5Q0JiZlVrTXo1Yms1VXRrYzVN?=
 =?utf-8?B?QzRiMlczR05KTUFEbmRERTBpTTc0THNNRlhITUNJZE9ZblZCQjJWMUUvS0V2?=
 =?utf-8?B?SHVqc0M4L1pOVkN4VVBpcGlaNHlrUG5qcktkVXdZMHhIRmRQRUpKT2szaE1Q?=
 =?utf-8?B?blhlK2Z0cVBURXNBRGpIUVdNaFJjUEpja1FPeVpyRFIxS3BEY1FxWGFjR1k1?=
 =?utf-8?B?K1dmWGxuOGtmVXJqdlhWRjdiZWZjWk9oS1Q3QlRZb0tNbXRLNDlFQmdUVWRG?=
 =?utf-8?B?cm56NEhtc1lvR2tqeTEyZmFxTU5hZVB3OGw5YklkUFJFMzRNbU1uV2VveTdk?=
 =?utf-8?B?cVVaOVkvdG9PdG9SMWZXZnM5dkVpY280MEhwNjZKSlpmdzJqcEFCTXhhQVZi?=
 =?utf-8?B?ODBMWWE1RUF3SUd1b0ZPTk9NNGxNeTBiZmZhTnNWd3lDN2JDM2tjbkgrczc5?=
 =?utf-8?Q?JgyU8NY1Lnsyzybme3xTmSmPM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d2af3f-9c3f-4389-af51-08dde4b7e9a3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:47:50.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5lvDLsqetSdmSQUm7U6Jx52KE4S594Y20YNoJ3FVbkY2uiMtIuEDvztjfvrihYlvnDU8cNQ0BvA+q+1t5nGgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11524

On Mon, Aug 18, 2025 at 01:51:13PM +0200, Jorge Marques wrote:
> Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
> core that implements the MIPI I3C Basic controller specification.
> The IP Core is versioned following Semantic Versioning 2.0.0 and
> ADI's open-source HDL guidelines for devicetree bindings and drivers.
>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/i3c/adi,i3c-master.yaml    | 72 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 77 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..fda240f9ee0c73bcbea97f775d6e081fe0c089d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
...
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: The AXI interconnect clock, drives the register map.
> +      - description: |

Needn't | here.

Frank
> +          The secondary clock, drives the internal logic asynchronously to the
> +          register map. The presence of this entry states that the IP Core was
> +          synthesized with a second clock input, and the absence of this entry
> +          indicates a topology where a single clock input drives all the
> +          internal logic.
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: axi
> +      - const: i3c
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +allOf:
> +  - $ref: i3c.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i3c@44a00000 {
> +        compatible = "adi,i3c-master-v1";
> +        reg = <0x44a00000 0x1000>;
> +        interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc 15>, <&clkc 15>;
> +        clock-names = "axi", "i3c";
> +        #address-cells = <3>;
> +        #size-cells = <0>;
> +
> +        /* I3C and I2C devices */
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35ed8498ab1e9b92b4bce5db9bb64004d80e4b1a..faa50535b514037ddf97309874ec64aac2013cb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11452,6 +11452,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
>  F:	drivers/i3c/master/ast2600-i3c-master.c
>
> +I3C DRIVER FOR ANALOG DEVICES I3C CONTROLLER IP
> +M:	Jorge Marques <jorge.marques@analog.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> +
>  I3C DRIVER FOR CADENCE I3C MASTER IP
>  M:	Przemysław Gaj <pgaj@cadence.com>
>  S:	Maintained
>
> --
> 2.49.0
>
