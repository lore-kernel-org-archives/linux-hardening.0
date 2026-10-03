Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79B36C0C8;
	Sat,  3 Oct 2026 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052893; cv=fail; b=T7ZbO4tKsA5Ajr3DyB8olGxbfQ5/vHYxyv9WWG9CUD1tRl6+3y2vIPVjLA4QPyuXI17tpU5qFgmXIRLiVItWGxRZo8kZcv/NutTzuobToNvFwMySrIVvymC1mZNqtJu7iax8GS8njVYt5LkbpOt+e2IFVAjiDxFdIkuX2QmtiR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052893; c=relaxed/simple;
	bh=Wm1/32twPwYRSffWfmwyFIqI9SkCNvwgf6s7Akdcxrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TYRfa0j3GcQECgwA7MOldxM4bFfUXkUcED8miyqohWjI/rZVA+u8vo+Dzav5NKuUl31koEj2qZIYjpXXjR0Kjb3muejfcmrKAMqELeHrpUGkCbdOeFWMonMCf0kYogV71RqmVU6WTekO4CB/DxCQX1B504dI+L5rHaPF3wrdnvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IX6mqdrj/Avm5xF45Km67kErD1fHAnmW/zPIz/3IM8fKfNa/Yt6qSg+6+4qGUY0evjoCV4sg3XKxTPk0533g6YpzxMAe/ga1gSLYvePlNWxoJsf9VIdIi5vNGlCphL/83uLL8tC+CO9gBE+HtRefHJhqSuqCEXm6NkhI5mhSvFYNQrbYj0U6nPkAMTP8afY8Y/LrP3cAt4R2LRHN2qr5aQSoJ/fkdMZ/EXjGWQf3KbsKfT9Vp4MAImSqK34TQ+DpvFQw1r9AQLBj+czXnyg9DdOwijID1LfEyYGIBcZjatFFAuKgB8QgHq9Nx/3nhlV6cQygtMWJUaW7aha+koxa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm1/32twPwYRSffWfmwyFIqI9SkCNvwgf6s7Akdcxrc=;
 b=DL7IZfAcuShj/H0135FBdY7lU/D2y4UdabkY2Kl1jayvftP8jLopwnM6gKL9ITQMyBH+cRsVTWrYFZ/J8T4CQor4xQomRRvN8swZf36Qrd0fTY0a3dPolysMHyAIhVcsD3JnINwlZuzrp/6wrsBkiIHFnZ6y/3E7W7x6oi8cLcqAynR4J4OGSEahE3rADchaggIolUWbercPKDfXfEv/rCVmYTIPCxLm/t0LTc8oh2Vu5gigSYGmunT17jIJ723etcCU6VI95omCvG2mAIGNBS4Hy/ICKDOYZJelpU7nuAKYKqQdWnfwNoREVI4LM2cbo6jvHhUqE992Q2RPH0S9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1316.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 15:08:05 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0472.016; Sat, 3 Oct 2026 15:08:05 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Brian Masney <bmasney@redhat.com>
CC: Michael Turquette <mturquette@baylibre.com>, Jerome Brunet
	<jbrunet+clk@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Emil Renner
 Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>, "Gustavo A . R .
 Silva" <gustavoars@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 10/23] clk: starfive: Add JHB100 System-2 clock
 generator driver
Thread-Topic: [PATCH v5 10/23] clk: starfive: Add JHB100 System-2 clock
 generator driver
Thread-Index: AQHdUNlXLmh95bym/0m9TiTYdcb04bbqnEuAgAFT/aA=
Date: Sat, 3 Oct 2026 15:08:05 +0000
Message-ID:
 <ZQ4PR01MB1202D613F74D237DB1303984F2882@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-11-changhuang.liang@starfivetech.com>
 <179096707365.821688.712584426844385414.b4-review@b4>
In-Reply-To: <179096707365.821688.712584426844385414.b4-review@b4>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1316:EE_
x-ms-office365-filtering-correlation-id: c92c8dec-a213-4930-7a15-08df2160209b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 fbD0gSRyYWaMTmnKLPJVxUADJESIbf3JuSw/D1dSab9BIh5i0ECwtrpZLSojALw67yxJ+omp7eYTl6epC65dxyIO8kAtW5sCBMhJe6D+NHXCHfwfGR3XClO4rAwsMSQfzYnwuse2dAqr99dXgF9PFrKr1qLq4TBBhDMZaZSHg3k/wiz0PGMou7Uy/GET0syMe39vnrEIj9M0z2jxcny1SHrCfArQ5bswuoBJVEtmJT23e0BydgKTIBOhBhWMkWImV9VlbXxYz/QrW2M1ugF/lJKdjSf1CZWXtdGt9V1vcHyYfnH2MFEE6ObKdSzpJ9Gv3+03biGKFYn//dGXUXpjPJYaO6ya1GtwOok6a2vOmm41WzIljTxZ4zOj66pnOCgRPgIV8UmM75jSYaTE9xr0NWib0zyAkFXEu1yN+Qzvt3WhmZpt7ZfUugKuwgPMi9hfE2d61rIxY3XJo4mVpMkxUCYuDNtQM2JiGZWJCbUmAaa9L6oONG2TXltcpqdqa4B640PrP67sm5SYI379k5vMaaOeowSDENASelC46YUTeYOUbVwP2jP2NQbkWkui2YkO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGRMTDBHa01vbmI1NG9YalBUR2hWVUVKS1FYQkZ2dDdEek9sVm4rUHgrZUo0?=
 =?utf-8?B?TWZIUTZSdkU2VlVLKy83azFGa1Q5dEhRMCtiajNGNUpJMjF1VnVEVkZQZ1Yx?=
 =?utf-8?B?eHh0WEY5YVNpU04xU0RMeEFHeFQ0b2QvRTlZVkQrRGRaMVRJMDduUzBwd3F3?=
 =?utf-8?B?ZHB6djlacEtGcTRWWUd5Uit1RlBvS1dFQWZBaXZRYk1jL1AvYmZZNnVWbU1L?=
 =?utf-8?B?V0s5YUNzTHMzR1RVd2EvQWxPMmRzMFFIZUlXaThIdWlod29zNW5IdXhTQnNT?=
 =?utf-8?B?dWZMYVpJUVkxdXIvOXA3bjFOUDVmeUJCNzRmRi9lMkQvMTZKWFhlNEFxOUxv?=
 =?utf-8?B?Uk53OUVQZDF1UTJ2NEdYNVc4ZnZtQWtUS2x4TXV5MnkzS29VSE4wL2FhdDlw?=
 =?utf-8?B?MkszTXpWZWkxU2FRczNGMkdHaUtLdWFLZVYwT1RxTGY0MHM0WXpNYlJKRVJP?=
 =?utf-8?B?cUJlblNERXV3bUppQzVuTEsrVUVPTWNoNVJPNWdaeW1NT0FrZklkZ0ZCQWxr?=
 =?utf-8?B?aEdkd3FkbzJHUFlBT1plWE9UczBwZW9JdHMxcE1abzBteHdZZ1REYnN0NjNW?=
 =?utf-8?B?VTlYNlZ2azlyVit5aUFNQTVVVTlaT3gxSHhFWUNZZDZ1QllTYmF6eEdSdTh0?=
 =?utf-8?B?MW1kUkJkRzBjVjBReXo2WW1TR3FLQ283T244U01neDdoNG5aVWxBdlhIVVBu?=
 =?utf-8?B?MkJFVlU3RXlRRFgwMVZHNjNPMXFxTmVxYkRycm9HTG9YMkQzbmoxMkFYM1lK?=
 =?utf-8?B?OG1TSnJ6ME0zRk50R25sNVlEM1hubVhoZ1l2eE9HMDh2dW5ueTVwZUtjc2N0?=
 =?utf-8?B?ODArZWV1RHpoV3U2M0t4QVo1UE1BcWorWmFmU1NWcWxYZE5ITWJaL1RMQmxC?=
 =?utf-8?B?WnBpNTR3QVlRcWF5dkxmdzVjME1hR2lIOGZ2WTZoVk5ib0hGN3FySGdFZ01G?=
 =?utf-8?B?bmFhNGxpNm1uc0xWWHYwU1N5QU8rZnQwVldJeXV1d1cwZFlNditWUi9RT1Jr?=
 =?utf-8?B?SWdGbTA5WjdCWVhST2ZHMzNVV3hHZnpJOFo0QnV0bEZjZjVURjhWZXJDeUVX?=
 =?utf-8?B?dDVSM1NGdm1FcUFEZ1VIRi9kTTBidlVwYmhPQUMrNk40NnNpUXJpYy8yT2Z2?=
 =?utf-8?B?MzRrQ2h2RmQ0M1FwQWVvVDgxN2wvUlBjTkNMODdoQkxPVWRUODE3c1lQYzNT?=
 =?utf-8?B?Q05rSWZ0VUtCN3JKQUpkcTNwWVNFOXVQbkN6Uk81cVpVUWNRVHdxRnFhMmxQ?=
 =?utf-8?B?WSt5dlJSNXZaZUhLM3E5cHFpSnNwejVhR2ZTaHB2YjhFVEljYUpCOGdveTZH?=
 =?utf-8?B?aDhXR0VzY0FiM1hoMzNNdUUxbEkwazZGdUxXS0ZIV2Q3QUdLa1FLS0xCdFJU?=
 =?utf-8?B?b213Z3NuclpnVDN2bytYODlYUUVSQzFSbkxrSFhPeFFvVkNWVjRIOGFmSWht?=
 =?utf-8?B?aXhXWEtmSUNmRWowZ1krWWVpc0xrNzYvWVZuQkZwTWRQdkpEaHhNYWRVQW9Z?=
 =?utf-8?B?dzVoYnBNTThQUmZLV2dDdnpGUlRsOGFPVmQ1YkFYdUhzeXFkSjdLWld1TmJs?=
 =?utf-8?B?eWdVU2hvcTF4WlVGRk9iV0RhRHU5MzRzQ09YNXlsbldPc3ZUdFdXa2hyTFhw?=
 =?utf-8?B?eXRhMFM1bmY5Qjg2MVhUb3pRNlZMWWMxMEY1azlXSGNNa0crbzlmQ0NzSGw2?=
 =?utf-8?B?QStLUU1aVTh5bW85Tnl0ampIc1l6cVhmZTgwa25GeEdTM2Q4aTVZTkxHZjRm?=
 =?utf-8?B?SGZRdWNOeGxhNDIrNk51MzVtalJmVXozVCtxU2pHYmRTZ21QZXliaGYzN2lD?=
 =?utf-8?B?VElWdmYxT2t2dkxTZHR3UUJPRkhsdzU1ZXpYR0RTbnRFWERWVDY0ZTF3aEEy?=
 =?utf-8?B?TXEwYjgrZlpoRS9pU04wSTFBR1F5aEJpQ3VpRUFHOXdkcDlXZ0dHNFlMTS9B?=
 =?utf-8?B?Uis2M0tnVjB5VVdIdGZ1Z1ZhTU9PTlFjL0RhN1N4amM4dDlXVkVqYjlmRTlD?=
 =?utf-8?B?Rlk0NXQ4UjFOcHlVMU0yRGFmOEgwZHFZRGFiMWtDWHZCeFpsaVFzVW4zai9D?=
 =?utf-8?B?bVRsM3pyaUJINWs2YjRBSUhSaE1MV3MwR01LWEE3ZEZPcFRlRlNuWVZ2VzVK?=
 =?utf-8?B?Wk40YnlzdnEyWUpjQXdLakJFNUV2NzdzS29BOUtSaWFPdVdMcDZrR3VRNTk3?=
 =?utf-8?B?OXVaNmllajkxUzdpQ01keDVFTVpTbFdQM3VINGRmdVVpWUZKY28xbnRjdjJX?=
 =?utf-8?B?V3U2ZHEzS3NKcFJwMTBPbCs1ZE5MNGNzYlorZVd0bi90R3o2Slk2MThSUFEy?=
 =?utf-8?B?YmlKd254em5ycUp1bjhTQVJKbXBBMW8zdHRLeDAzMmNHK2JLUm43UlZtY1dH?=
 =?utf-8?Q?CPXKGc3iRtmqAJxk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c92c8dec-a213-4930-7a15-08df2160209b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2026 15:08:05.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylZw/GEcyh4n8AL88swop9bXLHp7k5NRP0T7O4A4PJKW4uJrFzjbkGgBEBN1jh53qxzBlIk/PYjljHJwSb6JHOl4wbbRV5yY9BEoScFN8z2Du9vjJWOm31Xd3w8tuJ1G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1316

SGksIEJyYWluDQoNCj4gSGkgQ2hhbmdodWFuZywNCj4gDQo+ID4gQWRkIHN1cHBvcnQgZm9yIEpI
QjEwMCBTeXN0ZW0tMiBjbG9jayBnZW5lcmF0b3IgKFNZUzJDUkcpLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQ2hhbmdodWFuZyBMaWFuZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2gu
Y29tPg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3N0YXJmaXZlL0tjb25maWcN
Cj4gPiBiL2RyaXZlcnMvY2xrL3N0YXJmaXZlL0tjb25maWcgaW5kZXggMTFkYThiY2M0MDQ2Li5j
ZmFhYzkzNGE4ZTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvc3RhcmZpdmUvS2NvbmZp
Zw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL3N0YXJmaXZlL0tjb25maWcNCj4gPiBAQCAtOTIsMyAr
OTIsMTMgQEAgY29uZmlnIENMS19TVEFSRklWRV9KSEIxMDBfU1lTMQ0KPiA+ICAJaGVscA0KPiA+
ICAJICBTYXkgeWVzIGhlcmUgdG8gc3VwcG9ydCB0aGUgc3lzdGVtLTEgY2xvY2sgY29udHJvbGxl
ciBvbiB0aGUNCj4gPiAgCSAgU3RhckZpdmUgSkhCMTAwIFNvQy4NCj4gPiArDQo+ID4gK2NvbmZp
ZyBDTEtfU1RBUkZJVkVfSkhCMTAwX1NZUzINCj4gPiArCWJvb2wgIlN0YXJGaXZlIEpIQjEwMCBz
eXN0ZW0tMiBjbG9jayBzdXBwb3J0Ig0KPiA+ICsJZGVwZW5kcyBvbiBBUkNIX1NUQVJGSVZFIHx8
IENPTVBJTEVfVEVTVA0KPiA+ICsJc2VsZWN0IENMS19TVEFSRklWRV9KSDcxWDANCj4gPiArCXNl
bGVjdCBSRVNFVF9TVEFSRklWRV9KSEIxMDAgaWYgUkVTRVRfQ09OVFJPTExFUg0KPiA+ICsJZGVm
YXVsdCBBUkNIX1NUQVJGSVZFDQo+ID4gKwloZWxwDQo+ID4gKwkgIFNheSB5ZXMgaGVyZSB0byBz
dXBwb3J0IHRoZSBzeXN0ZW0tMiBjbG9jayBjb250cm9sbGVyIG9uIHRoZQ0KPiA+ICsJICBTdGFy
Rml2ZSBKSEIxMDAgU29DLg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9zdGFyZml2ZS9N
YWtlZmlsZQ0KPiA+IGIvZHJpdmVycy9jbGsvc3RhcmZpdmUvTWFrZWZpbGUgaW5kZXggMDA2MTU1
MGUwZjdlLi4yOWNkZWYyMDU3NWUNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9z
dGFyZml2ZS9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL3N0YXJmaXZlL01ha2VmaWxl
DQo+ID4gQEAgLTEzLDMgKzEzLDQgQEAgb2JqLSQoQ09ORklHX0NMS19TVEFSRklWRV9KSDcxMTBf
Vk9VVCkJKz0NCj4gY2xrLXN0YXJmaXZlLWpoNzExMC12b3V0Lm8NCj4gPg0KPiA+ICBvYmotJChD
T05GSUdfQ0xLX1NUQVJGSVZFX0pIQjEwMF9TWVMwKQkJKz0NCj4gY2xrLXN0YXJmaXZlLWpoYjEw
MC1zeXMwLm8NCj4gPiAgb2JqLSQoQ09ORklHX0NMS19TVEFSRklWRV9KSEIxMDBfU1lTMSkJCSs9
DQo+IGNsay1zdGFyZml2ZS1qaGIxMDAtc3lzMS5vDQo+ID4gK29iai0kKENPTkZJR19DTEtfU1RB
UkZJVkVfSkhCMTAwX1NZUzIpCQkrPQ0KPiBjbGstc3RhcmZpdmUtamhiMTAwLXN5czIubw0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9zdGFyZml2ZS9jbGstc3RhcmZpdmUtamhiMTAwLXN5
czIuYw0KPiA+IGIvZHJpdmVycy9jbGsvc3RhcmZpdmUvY2xrLXN0YXJmaXZlLWpoYjEwMC1zeXMy
LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYTJj
N2U4ZWJhOWI2DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL3N0YXJm
aXZlL2Nsay1zdGFyZml2ZS1qaGIxMDAtc3lzMi5jDQo+ID4gQEAgLTAsMCArMSwxMjkgQEANCj4g
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICog
U3RhckZpdmUgSkhCMTAwIFN5c3RlbS0yIENsb2NrIERyaXZlcg0KPiA+ICsgKg0KPiA+ICsgKiBD
b3B5cmlnaHQgKEMpIDIwMjQgU3RhckZpdmUgVGVjaG5vbG9neSBDby4sIEx0ZC4NCj4gPiArICoN
Cj4gPiArICogQXV0aG9yOiBDaGFuZ2h1YW5nIExpYW5nIDxjaGFuZ2h1YW5nLmxpYW5nQHN0YXJm
aXZldGVjaC5jb20+DQo+ID4gKyAqDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoYjEwMC1jcmcuaD4NCj4gPiArI2luY2x1ZGUgPGxp
bnV4L2luaXQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+
ICsNCj4gPiArI2luY2x1ZGUgImNsay1zdGFyZml2ZS1qaDcxeDAuaCINCj4gPiArDQo+ID4gKyNk
ZWZpbmUgSkhCMTAwX1NZUzJDTEtfTlVNX0NMS1MNCj4gCShKSEIxMDBfU1lTMkNMS19NQUlOX0lD
R19FTl9KVEFHMSArIDEpDQo+ID4gKw0KPiA+ICsvKiBleHRlcm5hbCBjbG9ja3MgKi8NCj4gPiAr
I2RlZmluZSBKSEIxMDBfU1lTMkNMS19PU0MNCj4gCShKSEIxMDBfU1lTMkNMS19OVU1fQ0xLUyAr
IDApDQo+ID4gKyNkZWZpbmUgSkhCMTAwX1NZUzJDTEtfUExMMQ0KPiAJKEpIQjEwMF9TWVMyQ0xL
X05VTV9DTEtTICsgMSkNCj4gPiArI2RlZmluZSBKSEIxMDBfU1lTMkNMS19HUFUwX05DTk9DX0lO
SVQNCj4gCShKSEIxMDBfU1lTMkNMS19OVU1fQ0xLUyArIDIpDQo+ID4gKyNkZWZpbmUgSkhCMTAw
X1NZUzJDTEtfR1BVMV9OQ05PQ19JTklUDQo+IAkoSkhCMTAwX1NZUzJDTEtfTlVNX0NMS1MgKyAz
KQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBqaGIxMDBfc3lzMl9leHRf
Y2xrW10gPSB7DQo+ID4gKwkib3NjIiwNCj4gPiArCSJwbGwxIiwNCj4gPiArCSJncHUwX25jbm9j
X2luaXQiLA0KPiA+ICsJImdwdTFfbmNub2NfaW5pdCIsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IGpoNzF4MF9jbGtfZGF0YSBqaGIxMDBfc3lzMmNyZ19jbGtfZGF0
YVtdID0gew0KPiA+ICsJLyoganRhZyBtc3QqLw0KPiA+ICsJSkg3MVgwX19ESVYoSkhCMTAwX1NZ
UzJDTEtfSlRBR00wX0hDTEssICJqdGFnbTBfaGNsayIsIDYsDQo+ID4gKwkJICAgIEpIQjEwMF9T
WVMyQ0xLX1BMTDEpLA0KPiA+ICsJSkg3MVgwX19ESVYoSkhCMTAwX1NZUzJDTEtfSlRBR00xX0hD
TEssICJqdGFnbTFfaGNsayIsIDYsDQo+ID4gKwkJICAgIEpIQjEwMF9TWVMyQ0xLX1BMTDEpLA0K
PiA+ICsJSkg3MVgwX19ESVYoSkhCMTAwX1NZUzJDTEtfSlRBR00wX0FUUEcsICJqdGFnbTBfQVRQ
RyIsIDEyLA0KPiA+ICsJCSAgICBKSEIxMDBfU1lTMkNMS19QTEwxKSwNCj4gPiArCUpINzFYMF9f
RElWKEpIQjEwMF9TWVMyQ0xLX0pUQUdNMV9BVFBHLCAianRhZ20xX0FUUEciLCAxMiwNCj4gPiAr
CQkgICAgSkhCMTAwX1NZUzJDTEtfUExMMSksDQo+IA0KPiBUaGUgQVRQRyBwb3J0aW9uIG9mIHRo
ZSBjbG9jayBuYW1lIGlzIHVwcGVyY2FzZS4gQ2FuIHRoaXMgYmUgbG93ZXJjYXNlIGZvcg0KPiBj
b25zaXN0ZW5jeT8NCg0KWWVzLCBpdCBzaG91bGQgYmUgbG93ZXJjYXNlIGhlcmUuIFRoYW5rcyBm
b3IgcG9pbnRpbmcgdGhhdCBvdXQuDQoNCkJlc3QgUmVnYXJkcywNCkNoYW5naHVhbmcNCg0K
