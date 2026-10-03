Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D8132B104;
	Sat,  3 Oct 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791039533; cv=fail; b=q+h9sDX6uaGl/wy0TJnQ9PA4zOJuTuCEEj0UIMEFkIJD2kPqd63DoM7b2mJ1Gy06soC+dDR5PpZ6+GQG2TdWmMAl0/FEiWJrv6RQ0BErdhJC31ZKk+SKQF/0+ffzvpXq/14q4hcceJFGBXeizIjRdFfAy8eekG4R6nKsiZqtRS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791039533; c=relaxed/simple;
	bh=ErF+nVJ1irFUe1VPtZf8+RRCtaco77YBpg2DjJ/+Sqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BsI27DriuSqTACGu7I6m868g6Lz4+nuYgk6sj+9HOswwZ3BW3cLBxu6cHTINKAEMU8jw/Mo7OKut9+/HEXSsPgMy/06IFmAVDvibzYuVdhX3wcJZh8ZwzZhXNbhzuyZRtgtsbOSDOA+ApViSPOgk+KAdsgVPFTvGbv2ONyfLdQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6YErTKQGCzlyjTM2+gtlKPiPoVXDd+/H/3tUE7+adoIRc76Yox/29wyucFRpIipG7BzTWJnXkf/RtnPJLHeAapXVK/tLUgVz6WqUmfbUDn/1XI61NpRqGVXVnWI+VnF+j1wRvEOzskXij4mK0EpH8TQy+pXZYFgjAU5CCz9QD4jIpzW2qxmypm7xgtD6/LQzPbtLwNsjVe58Cbrm/E5sodd+Ha9BvvC4Zmb7GPV2oIDL2Nsz9PNgn28zYMet9zdG6uCJyXzadTDXZxkP7nC7H2/dV/kJqoJszAu7umea66wxNsrwRqPKjpgNF1+uyJxE9IVaa/VYtc9oC0SVqHoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErF+nVJ1irFUe1VPtZf8+RRCtaco77YBpg2DjJ/+Sqg=;
 b=n3HtVwyy6I91peMDzc9Luu8cANCwOGsUWZ8jQQzlbQO534cx/M77UjhIhmprQxs9l6k2bcbDcuVdZhBIydiwCnJTXfScsFDAn+5ALkpbgxvM/kEcfu1hJm83ovLdBY/MCq24OZu6q4d6Mf6j0rn6mk3hlof7TgcEbt2JkYR5CA9CEEsmqI8pKHwo5J342RYoSwvOEXSAFfxl/yB3/KRpStX4mKOhS7APPDncr1jSt6Xq27fA++FQfXPPsw5MzaLxS7yydNkuBxvjQLI0EnDscdVeC0fv+IAygydZtZ6cyAK47leEpS8yWSbzGbyd547vfANLftS1ieOywArq5tzJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1316.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 14:58:37 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0472.016; Sat, 3 Oct 2026 14:58:37 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Brian Masney <bmasney@redhat.com>, Michael Turquette
	<mturquette@baylibre.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, Kees Cook
	<kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 04/23] clk: starfive: jh71x0: Add generic CRG probe
 helper
Thread-Topic: [PATCH v5 04/23] clk: starfive: jh71x0: Add generic CRG probe
 helper
Thread-Index: AQHdUNlRawWh2JdtEUKeuK+GUwNiv7bqnEuAgAFRVqA=
Date: Sat, 3 Oct 2026 14:58:36 +0000
Message-ID:
 <ZQ4PR01MB1202D07FB728EF122C00C359F2882@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-5-changhuang.liang@starfivetech.com>
 <179096707363.821688.2728247121300145722.b4-review@b4>
In-Reply-To: <179096707363.821688.2728247121300145722.b4-review@b4>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1316:EE_
x-ms-office365-filtering-correlation-id: 815e6547-766a-43be-6080-08df215ecd7d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info:
 7ZLwuUv8RseMugt4pGjjbQ5Bne4S8Ryia/D5HCWuU3U44pnwKSzgHAH//pJUp3rNyvsp3gtqnmlRTHzmZmLUFkk5c6co3KUGM95yUX9i0U/BwbBaONHAi4i4uDJ+AOY54H7YUjQgSl2WsS2Bd69t+I2y+FCAvukQPB4LW4a3g+V1fpiFqA9ZSHxgjWs4mjjjnYtStTHPm5w4y2OXwO4fz9W013lSZXGkSHs9C31B7Xo0CCLbU/n5RCcBnphitH4kf8CfyScBRt3QbHvdpgMQtv6FkiYKLpSoGoFqNglO2kjDDjr+GlCgj0hDEOv8HPBzJjT+7VDDqr844SThRyrhQnJQvkxCu+6luzoCpbePagPjMCUQ+3PPpnGPX7lY9+4pwv6i9PWTNS7vqCMrrjftSZEFW6iihGdIBkoLuzeu6s3i1ctthFvaP/md9i9Be/0esQLHyg3y7ZwOl+kXzUlpsIY9vvY9BkHTF+OLFYMtdNwqEDCFKD6KQbt3l1T94gJwTE+6eSIA8BlbPPrDr5BkTvRZI5vTvklpffBZ5X8DZ0+lHTL/0l9kOnljMcsBzJvYYi+jHDyWt6D7NPhJyK2gMA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHdha1NROVpBcml0c0I1dVdvNG5YdGRrR3NyN1Y4TnpmamlLUkM3U2YvL1RJ?=
 =?utf-8?B?dmtSRWEyc3hqczJQbFN4VDROamhpNzlvZHQ2WHhLdEN5b252ZmhXbXhLY0tu?=
 =?utf-8?B?V0RKMXA1TlJFTGFKaVRSbjR6VmpQY0ZmR2N5RzVsMG9ZMEFTQzJtUjZLMWM1?=
 =?utf-8?B?YTQ5Ni9Rci9mT1R2UklCVDlpUVJuTEUrYXZxLzVDQzE3VFhHZ2o2Nno1VzhQ?=
 =?utf-8?B?OFJ2dU4xTGFhMmxJY3FIWnVCUC9NajRlUDhaUEJFdUNnNTdPSy9QT2xDUWFW?=
 =?utf-8?B?OXNYRWJ5MEJrZ0ZTRzNEVWtyM3ZQOTJkN1ZsQ1AyMWxLRnJ0aENTMTd4V1RY?=
 =?utf-8?B?UFFlV0Q4MU44clR0RHVrc2Y3dmRMT0VYYnNxbmF4dzVob3pVeG5hcjJJWGxY?=
 =?utf-8?B?QXRhbGpLcEhBSEVNRXJlclJuNUxLQmVpdTRUMURQT0kwOTJsWWppa2FGZFBP?=
 =?utf-8?B?S2VPZDY0R09yL0dkZWZKb25sNUdrVXBOV3YyWVo0ZDFRNWFCNXhGL0F6ZUZr?=
 =?utf-8?B?cy9LZGwxc05rZ2JqdGJIeWhvUEwzSCthWW5FZHBKRkN5cTF2QkFSTDNFS09P?=
 =?utf-8?B?OFlmZW1zRkRaVVYvUGlWMEp1b1ZjaTRKUFk3RnJWb2xSMDFoa2lWZDZBcnNY?=
 =?utf-8?B?cGNVYkEvV1RSU3VNZklZR2xqZjd0OE1OQ29nQVpSWndpc29SRUorUE5FUlRh?=
 =?utf-8?B?d2hmZnY2UGZad2Flak1vWEM0dDRqVTliSEUwajRVOGFRY0tUTDVZMk9LRHVE?=
 =?utf-8?B?c0ZBbit3YnZVellPdWF2elc2UU1NdTZMMUJHaWxiZExyR0tlQzA2QkZkY3Rv?=
 =?utf-8?B?NmxOeG5JYlR6aFNNeWVlWm5LM25vRzU0N0pjaGlyMmdLVDdlS1loVWlOQ0cz?=
 =?utf-8?B?emR6TUl2VnVoRFVFclh3N0JjdVJ0SFV4ZkZYSFBOWC96Y0JCQ25ObDhjZlBs?=
 =?utf-8?B?VFgzUDc4TitzbS8yY29GWWMyVi93cUtXQXgrdDJHRENCM2piYS9VcGRsNWJO?=
 =?utf-8?B?NmV2bkRGWEswd0RmaDN3bmc0WkZYWFFNdlhjUzFWbjVuemRwSkI0MWd1TWhm?=
 =?utf-8?B?Ny9DamJOaGwvdzZnSWd1bjgxYm11TjBTbmtOUXh2Ty9FSkVIS1gvajUrQTM2?=
 =?utf-8?B?TXFnZWoxT2pJdkVrR09mM01NV1R5cVNQS2VEQkljOGxMQ2FGSlRwcnQzRGtO?=
 =?utf-8?B?Q2VwTFlNREM0NWRlaXEzSko0UnVLSVNBbmJSQ1dZa1MwK3hmUFplOFl1eU5w?=
 =?utf-8?B?L2RYMVhkd2RhY2U4T3JHWlRvRFdSUkFVK2JtZ0l2cmtid3l2ZFBWaWZOci9I?=
 =?utf-8?B?YlBNQ3dhL1lHdWl2MUx6OStsTEtzMmNMVVUrcDdzejdxL08yeXprK1lSSitZ?=
 =?utf-8?B?c000N2tjcFNzODBUY2NBNndZSmFpNzE1U2VFUkFpTmpNbWVHZk50NFFTTU5R?=
 =?utf-8?B?NHNEOHBMVlZaeTIvQTlOeFdIaFdBck1PNDQxSWxvV1lvRHZKZTIzbURBRzAx?=
 =?utf-8?B?VVNhSnk0ZkVLYWpub1c0ZFUzcVJ4ZkZhcWMyTFlJaS9OcGVwc3dkWFY1aFlU?=
 =?utf-8?B?cnl6TlBYbFJjZ3BSdGdyclZ3Q0dQaWNWaDdvVFk1WTk4c1ZDd2VuTE5PRldS?=
 =?utf-8?B?NU1PRW5BNHh0a0FVRldKQlBXS3BXUSsyNlZRTFF6QVhYMkFlbGxGUVVUNmk1?=
 =?utf-8?B?TUFjbCsvbEoyVDR0YmtIdGlWUWM1Yk1OYVVPaVYwOGlob0NWU2ZyTGQ1T1dy?=
 =?utf-8?B?eldmODB1YUVML1NxbUFIaWkxRk8zWkRiYzFPODR6T1F5eDYrRCs4QllJbTVz?=
 =?utf-8?B?b3FXQ3FBTk1vbkkrWWZTMW55RHl0aE9QbWFYc0FhVzk2Qk92dGM5dzdNMXlZ?=
 =?utf-8?B?UVNTVStqMjMxRll4N3ppOHpGS0FJdjFrN1BkNjYvaE1ZRSs0ZlAwWWF2M3dr?=
 =?utf-8?B?RDRvNS9wdFc0eEFDS0lZWVhqdzVPK1YwbUR4SGdjRW5CV3N6amNyRzJkNDkx?=
 =?utf-8?B?RExSN1p6THlBZXE4YkJZeElPMmZ6OUZNMWMxckkvblFQZytlYjNrdERYTkVz?=
 =?utf-8?B?UktkMk50N0NaQzZUVkxOYXBJTE5oRHowV01KTDRjTGllR3R6eTE4SVpzL21U?=
 =?utf-8?B?SlZWWkF0ZkxHajlqbGx5U1ptRWM2UGJiMVJYbm5vcjk2NXBTeG56enk3QmU3?=
 =?utf-8?B?cXpUaHlGenk0VVNvQjhzcWxyeEpVZWt5R0EyZFNZeWhPeXpaMFBjY2ViVjlj?=
 =?utf-8?B?RlpVYXFwWityc1MyaHhkZWIwZW5rbit3ak9COUR3VTdsbTQwSzk1d1J4bncr?=
 =?utf-8?B?a1EybC9uWFVBZ0tPbjVUTmxUOTYzY3hZaDJQbDJDRkxyc0x4U3ZBb1lpYXVv?=
 =?utf-8?Q?1wvAxFioyZHZ2YW0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 815e6547-766a-43be-6080-08df215ecd7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2026 14:58:36.7322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBRRK0xXReywNX1G1W04iB8mil09OgbMRQEvV5tyA/zd7QE0iVb9wqTW66HBhBNj1Qm6u3+gG9OdyXIBwFSh3rGWt49CvLQXXI26EB8fqtIlIt+kzyml2M0rZClCG6hy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1316

SGksIEJyYWluDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiBIaSBDaGFuZ2h1YW5nLA0K
PiANCj4gPiBUaGUgU3RhckZpdmUgSkhCMTAwIFNvQyBoYXMgc2V2ZXJhbCBjbG9jayBhbmQgcmVz
ZXQgZ2VuZXJhdG9ycyAoQ1JHcykNCj4gPiB3aGljaCBzaGFyZSB0aGUgc2FtZSBwcm9iZSBmbG93
OiBtYXAgdGhlIHJlZ2lzdGVycywgcmVnaXN0ZXIgYWxsIHRoZQ0KPiA+IGNsb2NrcyBkZXNjcmli
ZWQgYnkgYSB0YWJsZSwgYWRkIHRoZSBjbG9jayBwcm92aWRlciBhbmQgcmVnaXN0ZXIgdGhlDQo+
ID4gYXV4aWxpYXJ5IHJlc2V0IGRldmljZS4NCj4gPg0KPiA+IEFkZCBqaDcxeDBfY3JnX3Byb2Jl
KCkgdG9nZXRoZXIgd2l0aCBzdHJ1Y3Qgamg3MXgwX2NyZ19kb21haW5faW5mbyBzbw0KPiA+IHRo
YXQgZWFjaCBDUkcgZHJpdmVyIG9ubHkgbmVlZHMgdG8gcHJvdmlkZSBpdHMgY2xvY2sgdGFibGUs
IGV4dGVybmFsDQo+ID4gY2xvY2sgbmFtZXMgYW5kIHJlc2V0IGF1eGlsaWFyeSBkZXZpY2UgbmFt
ZS4gVGhlIHJlc2V0IGF1eGlsaWFyeQ0KPiA+IGRldmljZSBpcyByZWdpc3RlcmVkIHdpdGggamg3
MXgwX3Jlc2V0X2NvbnRyb2xsZXJfcmVnaXN0ZXIoKS4NCj4gPg0KPiA+IFRoZSBjbG9jayBpbmRl
eCBzcGFjZSBvZiB0aGVzZSBDUkdzIGlzIHNwYXJzZSwgc28gYWxzbyBtYWtlDQo+ID4gamg3MXgw
X2Nsa19nZXQoKSByZWplY3QgaW5kZXhlcyB0aGF0IHdlcmUgbmV2ZXIgcmVnaXN0ZXJlZCB3aGVu
IHRoZQ0KPiA+IGRvbWFpbiBpbmZvIGlzIGF2YWlsYWJsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IENoYW5naHVhbmcgTGlhbmcgPGNoYW5naHVhbmcubGlhbmdAc3RhcmZpdmV0ZWNoLmNvbT4N
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9zdGFyZml2ZS9jbGstc3RhcmZpdmUt
amg3MXgwLmMNCj4gPiBiL2RyaXZlcnMvY2xrL3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1qaDcxeDAu
Yw0KPiA+IGluZGV4IDJjYzcxZjQ5ZGRlZS4uYmI3NzA2ZWRlMWE2IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvY2xrL3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1qaDcxeDAuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvY2xrL3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1qaDcxeDAuYw0KPiA+IEBAIC0xMCw2ICsx
MCw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+ID4gICNpbmNsdWRlIDxs
aW51eC9kZXZpY2UuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9wbV9ydW50aW1lLmg+DQo+IA0KPiBBZGQgI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5
Lmg+IGZvciBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoKQ0KPiANCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4NCj4gPiAgI2luY2x1ZGUgPHNvYy9zdGFyZml2ZS9yZXNldC1zdGFyZml2ZS1qaDcx
eDAuaD4NCj4gPg0KPiA+IEBAIC0zMzQsMTAgKzMzNSwxNCBAQCBzdHJ1Y3QgY2xrX2h3ICpqaDcx
eDBfY2xrX2dldChzdHJ1Y3QNCj4gb2ZfcGhhbmRsZV9hcmdzICpjbGtzcGVjLCB2b2lkICpkYXRh
KQ0KPiA+ICAJc3RydWN0IGpoNzF4MF9jbGtfcHJpdiAqcHJpdiA9IGRhdGE7DQo+ID4gIAl1bnNp
Z25lZCBpbnQgaWR4ID0gY2xrc3BlYy0+YXJnc1swXTsNCj4gPg0KPiA+IC0JaWYgKGlkeCA8IHBy
aXYtPm51bV9yZWcpDQo+ID4gLQkJcmV0dXJuICZwcml2LT5yZWdbaWR4XS5odzsNCj4gPiArCWlm
IChpZHggPj0gcHJpdi0+bnVtX3JlZykNCj4gPiArCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsN
Cj4gPg0KPiA+IC0JcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4gKwkvKiBJbmRleCBzcGFj
ZSBpcyBzcGFyc2U6IHJlamVjdCBob2xlcyB0aGF0IHdlcmUgbmV2ZXIgcmVnaXN0ZXJlZC4gKi8N
Cj4gPiArCWlmIChwcml2LT5pbmZvICYmICFwcml2LT5pbmZvLT5jbGtfZGF0YVtpZHhdLm5hbWUp
DQo+ID4gKwkJcmV0dXJuIEVSUl9QVFIoLUVOT0VOVCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuICZw
cml2LT5yZWdbaWR4XS5odzsNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChqaDcxeDBf
Y2xrX2dldCk7DQo+ID4NCj4gPiBAQCAtMzkxLDMgKzM5Niw4NyBAQCBpbnQgamg3MXgwX3Jlc2V0
X2NvbnRyb2xsZXJfcmVnaXN0ZXIoc3RydWN0DQo+IGpoNzF4MF9jbGtfcHJpdiAqcHJpdiwNCj4g
PiAgCQkJCQlqaDcxeDBfcmVzZXRfdW5yZWdpc3Rlcl9hZGV2LCBhZGV2KTsgIH0NCj4gPiBFWFBP
UlRfU1lNQk9MX0dQTChqaDcxeDBfcmVzZXRfY29udHJvbGxlcl9yZWdpc3Rlcik7DQo+ID4gKw0K
PiA+ICtpbnQgamg3MXgwX2NyZ19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7
DQo+ID4gKwljb25zdCBzdHJ1Y3Qgamg3MXgwX2NyZ19kb21haW5faW5mbyAqaW5mbzsNCj4gPiAr
CXN0cnVjdCBqaDcxeDBfY2xrX3ByaXYgKnByaXY7DQo+ID4gKwl1bnNpZ25lZCBpbnQgaWR4Ow0K
PiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlpbmZvID0gZGV2aWNlX2dldF9tYXRjaF9kYXRh
KCZwZGV2LT5kZXYpOw0KPiA+ICsJaWYgKCFpbmZvKQ0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0K
PiA+ICsNCj4gPiArCXByaXYgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc3RydWN0X3NpemUo
cHJpdiwgcmVnLCBpbmZvLT5udW1fY2xrKSwNCj4gPiArCQkJICAgIEdGUF9LRVJORUwpOw0KPiA+
ICsJaWYgKCFwcml2KQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArCXNwaW5f
bG9ja19pbml0KCZwcml2LT5ybXdfbG9jayk7DQo+ID4gKwlwcml2LT5pbmZvID0gaW5mbzsNCj4g
PiArCXByaXYtPm51bV9yZWcgPSBpbmZvLT5udW1fY2xrOw0KPiA+ICsJcHJpdi0+ZGV2ID0gJnBk
ZXYtPmRldjsNCj4gPiArCXByaXYtPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2UocGRldiwgMCk7DQo+ID4gKwlpZiAoSVNfRVJSKHByaXYtPmJhc2UpKQ0KPiA+ICsJCXJldHVy
biBQVFJfRVJSKHByaXYtPmJhc2UpOw0KPiA+ICsNCj4gPiArCWlmIChpbmZvLT5wb3dlcl9kb21h
aW4pIHsNCj4gPiArCQlyZXQgPSBkZXZtX3BtX3J1bnRpbWVfZW5hYmxlKHByaXYtPmRldik7DQo+
ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUocHJpdi0+ZGV2LCBy
ZXQsDQo+ID4gKwkJCQkJICAgICAiZmFpbGVkIHRvIGVuYWJsZSBydW50aW1lIFBNXG4iKTsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlmb3IgKGlkeCA9IDA7IGlkeCA8IGluZm8tPm51bV9jbGs7IGlk
eCsrKSB7DQo+ID4gKwkJdTMyIG1heCA9IGluZm8tPmNsa19kYXRhW2lkeF0ubWF4Ow0KPiA+ICsJ
CXN0cnVjdCBjbGtfcGFyZW50X2RhdGEgcGFyZW50c1s0XSA9IHt9Ow0KPiA+ICsJCXN0cnVjdCBj
bGtfaW5pdF9kYXRhIGluaXQgPSB7DQo+ID4gKwkJCS5uYW1lID0gaW5mby0+Y2xrX2RhdGFbaWR4
XS5uYW1lLA0KPiA+ICsJCQkub3BzID0gc3RhcmZpdmVfamg3MXgwX2Nsa19vcHMobWF4KSwNCj4g
PiArCQkJLnBhcmVudF9kYXRhID0gcGFyZW50cywNCj4gPiArCQkJLm51bV9wYXJlbnRzID0NCj4g
PiArCQkJCSgobWF4ICYgSkg3MVgwX0NMS19NVVhfTUFTSykgPj4NCj4gSkg3MVgwX0NMS19NVVhf
U0hJRlQpICsgMSwNCj4gPiArCQkJLmZsYWdzID0gaW5mby0+Y2xrX2RhdGFbaWR4XS5mbGFncywN
Cj4gPiArCQl9Ow0KPiA+ICsJCXN0cnVjdCBqaDcxeDBfY2xrICpjbGsgPSAmcHJpdi0+cmVnW2lk
eF07DQo+ID4gKwkJdW5zaWduZWQgaW50IGk7DQo+ID4gKw0KPiA+ICsJCWlmICghaW5pdC5uYW1l
KQ0KPiA+ICsJCQljb250aW51ZTsNCj4gPiArDQo+ID4gKwkJaWYgKGluaXQubnVtX3BhcmVudHMg
PiBBUlJBWV9TSVpFKHBhcmVudHMpKQ0KPiA+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShwcml2
LT5kZXYsIC1FSU5WQUwsDQo+ID4gKwkJCQkJICAgICAiY2xvY2sgJXM6IHRvbyBtYW55IHBhcmVu
dHMgKCV1ID4gJXp1KVxuIiwNCj4gPiArCQkJCQkgICAgIGluaXQubmFtZSwgaW5pdC5udW1fcGFy
ZW50cywNCj4gQVJSQVlfU0laRShwYXJlbnRzKSk7DQo+ID4gKw0KPiA+ICsJCWZvciAoaSA9IDA7
IGkgPCBpbml0Lm51bV9wYXJlbnRzOyBpKyspIHsNCj4gPiArCQkJdW5zaWduZWQgaW50IHBpZHgg
PSBpbmZvLT5jbGtfZGF0YVtpZHhdLnBhcmVudHNbaV07DQo+ID4gKw0KPiA+ICsJCQlpZiAocGlk
eCA8IGluZm8tPm51bV9jbGspIHsNCj4gPiArCQkJCXBhcmVudHNbaV0uaHcgPSAmcHJpdi0+cmVn
W3BpZHhdLmh3Ow0KPiA+ICsJCQl9IGVsc2Ugew0KPiA+ICsJCQkJaWYgKHBpZHggLSBpbmZvLT5u
dW1fY2xrID49IGluZm8tPm51bV9leHRfY2xrKQ0KPiA+ICsJCQkJCXJldHVybiAtRUlOVkFMOw0K
PiANCj4gV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgYWRkaW5nIGEgZGV2X2Vycl9wcm9iZSgpIGhl
cmUgYXMgd2VsbCB0byBtYWtlIGl0DQo+IGVhc2llciB0byB0cm91Ymxlc2hvb3QgYW55IGZhaWx1
cmVzIGhlcmU/DQoNCk9LLCBJJ2xsIGFkZCBpdC4NCg0KQmVzdCBSZWdhcmRzLA0KQ2hhbmdodWFu
Zw0KDQo=
