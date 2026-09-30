Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2090.outbound.protection.partner.outlook.cn [139.219.146.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502645D5FE;
	Wed, 30 Sep 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756895; cv=fail; b=Fj4gbwX72a3YiUhVfU2/1owUfpKt1vMaYAGSM4+O2Utj9YInjufN/WDkJ/MfcfkDLZGPlup8gm6jS2vtL8as4NUwZ53Euk9Ft24OArWXblGK1GxDRgELYeV1PgXeMkR64ZB0QJFIdet0hxfFbt6835pXcn+KmYXCVV4YcFyzXa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756895; c=relaxed/simple;
	bh=/qtUxTpZeBf1fIpkeUG3jp0Wm19P1AexI7jxJ5mVCMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NNsApoLsVZMLmUnAo8HlfaUW8R9huFtzzZDUXy3ZM0OswkEWM980r/EV3c42MRiV4R8c/UBQSG67/FZQwo/vK2l0nTZYrB/PuDlkDjQT8zYtc+/1wmOn+mcmx3cggpC5UKQIm0/6YG9bG6Yy8lb66jeitASNRWLLQMrY42AQH6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSMDGsiQRLvkv9xCd7D5oGgjBKoaxMy81zUxXoX1qLoygw9QjSCfPSobNQXol6bqMJL4fSKhGePD0K0lzWfmoRoAHbi26QsBdylL83wd1NkMRAc4o7z0n5cLC16hFAKmTHdo9GYANeABJhCaKRRaJMtPhpSrXDoo045SWxfU0v+cuA+NsXUQjuhiOp+4vMDHDHGR/OWNO8rP4gPkM9bO3qZ31vh/8cFGWeYHK4L1wy8MwQnj2E8Irk24TLmPoQCIQTB+D1reG+VxijiYF6Wi74IrUWMlZol0E/J2ZlRDSjdSLRm+AysdO0J4+CCkn/w/tn++PqQOUtmFrwNdg1BM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qtUxTpZeBf1fIpkeUG3jp0Wm19P1AexI7jxJ5mVCMk=;
 b=A9QIsKyUPrppQ9+zFA0AUbG6UDhIPBFDDMKFp/VbQ1Qpzj338qGb/noG2Np/BWxabUp9N7MwXabqIcr5A6n0KeRFxX1St5MX2dVVOSw92FyvkLc90uq4oQMUaLCxmOnbuo0Smy28qwdefIernTfg7lEfdLDlMaIJ768aF3ZgDF6MhpjNvfWJO7LpDtdnu3KDJo8fjhVQCXXDsMNBW1HQhSGnKsVM1CLzg2wvQo44DVGXTcb2BFm9+jF0EwcO5zfQNxqXwlKlCqJNw9IkA0kfpNSSpmF7dwl+dOhbBSlzSajlzd1yxxfywBH+3tglpVvLXdYA+6x9Skr2hSG4qbBykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1331.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 08:27:59 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 08:27:59 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Michael Turquette
	<mturquette@baylibre.com>, Brian Masney <bmasney@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel
	<p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Kees Cook
	<kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>
Subject: Re: [PATCH v4 03/22] clk: starfive: Rename file name "jh71x0" to
 "common"
Thread-Topic: [PATCH v4 03/22] clk: starfive: Rename file name "jh71x0" to
 "common"
Thread-Index: AQHdSPew5FxIBMEJ4kOnpM+hu5x6v7bfcogAgARvjxCAAvFdgIAABc8Q
Date: Wed, 30 Sep 2026 08:27:59 +0000
Message-ID:
 <ZQ4PR01MB12026522469590AF04BAB1ACF28B2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
 <20260920120044.194901-4-changhuang.liang@starfivetech.com>
 <1jqzih73ob.fsf@starbuckisacylon.baylibre.com>
 <ZQ4PR01MB12022FD5940DAA1AC1279B8FF28D2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
 <1jtsn72mds.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jtsn72mds.fsf@starbuckisacylon.baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1331:EE_
x-ms-office365-filtering-correlation-id: 49c02d1e-5925-43d3-7c81-08df1eccbc7b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|10067099003|56012099006|921020|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 WGDEY3LJNKj90KJ6294/RSj/FVaQfmaYoOc0t1siAzZ0LX2h4/1HlA27Yy0rNvaUShx4GGe7TWtBqOAcWmiCkpUAnchhyEoUacDqdZOLjXmITXmP4zDb2tQXPB/gGbgp0nu1APC43NS8C1vilK+TKrgPzTySItjX4TaCdiSp4HTuI9W0K1vRWmJTL/CHl6Bk+It9qSVjzHFaoNcD5/UD1fOaQrPkUnJzjUR0zSDh2gXAxQxNVUNUci7djA3RkIMxSEodIow8Rcue7vLouNnfiQj3VSfrtCzjuxp7pWtCwCqYgGb70AnrLgSylPn+BV7BjNegGxilJ17vXJcqpY6PEZOwUFEJ/Rc92tT0jI+NJg13+PMLD4MqfFWMT+HFzUBcFhbUTk3MulQR+Kekka6OxjesgKvJMERR8sPbP1onKlbPQgknDHOy3/AQ4GnBDpagB/uCTCRRxekcqtX3M1QXUktn2leA9enkFJm4hy5zu1AhxIQjmtlT9xmpXUzKYjB5sFNtdQJr8k+k9fRmpwUDo+H+6l8M8nmoZcjyvRdXG9MVCSXCJztZIsOiRnA2DuVLufNWcAqNrBp6xjtmoLwAeg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(10067099003)(56012099006)(921020)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8v9TTaOqdj84DaDw+hiAPNng2a9tk3GQZBJ+E2w899+Uz+HSOVRF0KaX5IG1?=
 =?us-ascii?Q?S3MyVYshi3NhNfgr5KqiJyfaCqO9Tmd9EcZGK/y+b/mkIFPgcEBmOHhYKNjf?=
 =?us-ascii?Q?f7zuw8tTNFUMv82XaRHiUBpHwektEQZKG49OFUJJaxA0/fSrPscl6k+o/0w1?=
 =?us-ascii?Q?TPSsaumHXR0RXwYd7drE4lt2Ylj1gFK9APWh2Hm7UlKt8JqHR4XxQdAHI9DQ?=
 =?us-ascii?Q?BDZmVCFdTHmNSNrqaFcsS+RB5v+4BD+eMXQheHY1iyx+y2Qqb6ib+Pj759TC?=
 =?us-ascii?Q?Z836acmRHzACZfPyMTBpfL+Uym3pfpPRnJJS5P9QtmXBaxiGtEVNu/9rq4le?=
 =?us-ascii?Q?8ISSxEA6DqPfF2306S+83HtbPmPtvb7rsudmHpwzqUT+XBX8NwYqPqUVFRlv?=
 =?us-ascii?Q?IjYpiwxoZJNTk8LZ0Ng6cvW1Vq5Z4OBYoyku1gJ4JQvpbjq5T6zNLBN92SII?=
 =?us-ascii?Q?Y62tjbJsrLEldutX1ImzH13dBwCcY6p4R5d/0+7lDhHHO6JNSAEG/PwAwRCV?=
 =?us-ascii?Q?G6JwZK/QSpVhTbZ7iU2VNf/cqD1XzNU75b+Ecgni/PeJzebdMB5e7jr9oO+Q?=
 =?us-ascii?Q?2l2pg0JTP7COeSVLXtr6jvt9U21+pR5PHWxjozEhaKGSt4PpiPDsYkbeEUxP?=
 =?us-ascii?Q?wAZxYkSgoaZrojcue/6I8VYEKT57+OKD62tTcI/kfpGyqLJSUiR2Oni2QGsM?=
 =?us-ascii?Q?LfQZ6B2ZGKWwRAPj7fNoW79qxD5QggyLJ/OUytvflmS0Ka2jHvyf4XodmXEo?=
 =?us-ascii?Q?z2KVlq5pH/7is8wb77E7sXfQV2sgjwBQOd+I8/eOwT2wfmNxyAjqVSr/7VeF?=
 =?us-ascii?Q?qc4DS8YDyFiD/sbYIdfVr7YhUb8i48L2eQF87yHk+tMVuP520GIUa1I/jk87?=
 =?us-ascii?Q?9Yoit+SNn5kIDw5BeQf+Pqwk8eh9Y/r0GCzvvijJFjTic1PQL1kLQdrDp8KW?=
 =?us-ascii?Q?Kd/O/7qFNQIUGFYHmpE0aMbVAW6w93SPsTJ8EJZEBV8Wcax7+7f6gm0CgaBL?=
 =?us-ascii?Q?fENFZdXdvw2P63JwaPTWw78MKdN4lxh4bnJF2AmCBIgopjeTPEeESevAcD5s?=
 =?us-ascii?Q?VQdGl1/OMzNG/ioL4LnJ7mx2IgXi0vI8cQ/CEKo+OP16ghumAPAmNoYQxvaD?=
 =?us-ascii?Q?F2yu9WFGvgA6jKWbiweTgTCtww4kfscWygdCmV4MQGFQOaN8FwzNshWNXzN1?=
 =?us-ascii?Q?y4hXZ/rVOFOZrBkdDskSkDL6Y6wBFwxi8xlMVBpOqZNKLlXJB1bkHrDwVm6n?=
 =?us-ascii?Q?IPhmYQe9pmgnbelx9RVgq1S2gTqTLNU6Zno5pLvBT+ERw5655YN16nZ65L3u?=
 =?us-ascii?Q?SrP5UvaMKQHbhJ5Hd56j755QpWiEElsVSXO/n1VngiKHDvoZqdxg9OODt/Wc?=
 =?us-ascii?Q?OM7lDUVxFz3t7RzN6AQFmIWCyLyy9OdvbZQiPQm/ymUT+1XSat/ugZHMn4nv?=
 =?us-ascii?Q?2DqPxiNdya4rjQN7lBrXBFPlLih8KJzuFBmZzs6duDBEZeWUonng176p400I?=
 =?us-ascii?Q?a0tBb4siBQjrb6HyplmBgEodXuJqq4wBmbIOApU48pRHDXQ48MMQtVX+EAAL?=
 =?us-ascii?Q?xtlZAEnq2pF0gEBGpDYr9RpEtL5dLQUevyi6z2xuwWYGXvcl+cKmFTzxLiQK?=
 =?us-ascii?Q?q1/giKuAQKbA2tjV/1nHduDSGBAc4bdJrNJrmNa76tyOVEZasFXdwTSbnXFq?=
 =?us-ascii?Q?fiUCHerh1OUluqtzqWTDqDoxAUCPeS+Z+i+y+ClVLLlrt/5lR4OtPB/4wFyN?=
 =?us-ascii?Q?MLiF3mHrkJ2eCQtqzziqZVfzJ5pf+Gg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c02d1e-5925-43d3-7c81-08df1eccbc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 08:27:59.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sb9tN59D5hGUQ+ZHGSvtQAarEITcs9Ym6/pD6Ybo+oHSiwAOhGR9PPupSshXXPSfrFd3kq0exhF6JKfQXvMlC2Djac5YPCzdYBnH+RdUNSnjdE32PL+rw1GwXc6b1ycn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1331

Hi, Jerome

> On lun. 28 sept. 2026 at 11:10, Changhuang Liang
> <changhuang.liang@starfivetech.com> wrote:
>=20
> > Hi, Jerome
> >
> > Thanks for the review.
> >
> >> On dim. 20 sept. 2026 at 05:00, Changhuang Liang
> >> <changhuang.liang@starfivetech.com> wrote:
> >>
> >> > From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> >> >
> >> > StarFive JHB100 shares a similar clock and reset design with JH7110.
> >> > To facilitate the reuse of the file and its functionalities, files
> >> > containing the "jh71x0" naming convention are renamed to use the
> >> > "common" wording.
> >>
> >> Is this really necessary ? Rename are generally not recommended.
> >> Do we really care if your new soc use something named after the older
> one ?
> >>
> >> You are naming it common now but how long is it going to stay "common"=
 ?
> >> If your next SoC does not use this anymore it won't be common for long=
 ...
> >>
> >
> > Okay, I will drop the current PATCH 1/2/3/4 and directly reuse the curr=
ent
> JH71x0-related interfaces.
> >
>=20
> Please make sure your series applies on clk-next next time around.
> This one failed to apply when it was sent.

Okay, I will send the next version based on clk-next.

Best Regards,

