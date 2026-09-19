Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2118.outbound.protection.partner.outlook.cn [139.219.146.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682E2B9BA;
	Sat, 19 Sep 2026 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811962; cv=fail; b=cAkG0uwDE7NcyT500pRkXPyEC2g45+mz0uDYyjDclWWp9S0nqCUFCvbTmGxfqP65Z1UnV55r8MtTHES8E4pfmcPiCPP38JQPdny5fdqk6kXPTlgIVYILXajGE9QOj+SJDtOhnebvPsWAbWjKMleRd2EWgz9jJqFUwRe454QI9uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811962; c=relaxed/simple;
	bh=j0hlyjYyIjgjL+Yq7LBxc3oEJgXP7gKUREc9W/QYoMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aqqtRs7VstjpEBTKX3AjemGd78IOBu2od27K5jrGs9zJOT+kCBL2pua9V7Qm9pl5DYc6Tq+73ec08kqyUJDr0FpZpvxcQg40ir225QNWLj9Mc3tkuXSOcFN49JJUWovJFDIf7JjaiG9BN9bAidiBJlGOg2dRt0s8j3fUaxxtRaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWUANzW1vBjxuVTNXEADX09OCMTu6CG3qFSkQ9C+ii6nM/O1Ks7subBYcEM5/r4qlBlts0lIi87Go0Fe8vC6WXRTEhBKix7wUB1mwuyj4rWUqL4HQSsEyYACK8avorgljHCFPzDplcnfKlKQajcvM2sfXWgmmLTRS4uZpHVVCfXjEF7dG+JbwLEITNJFl+LyhG4MTFlWu4U7FIkZGA8bmQKgyUdsixZscyZuDfG1hjVgoXPyPJVU1FqQZ0Y+pRFK4RMkSPoGNvfMnpLgNs9UATmu9ZWuUf/4tklfvuZD61IG6H9Eo250fNXaqGnYxjtspPh84T0qKHkyXo2eoukhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ada0BsBMLhTWoyMyz6qAFbKAeXcqhDS5cNiPl5e7V+M=;
 b=U57Fbl+WQ/3l6Z4pszZByfylliiJ6XVPLjIqzH4scpOG/3t7j/kkCVHuNmHJa3FxECzX/7JkjPnnxs79G1kGVOmD9iFuUBGAD/5D17peCAvYGE/8BogSzRoqa3qu1OHCYhOKE7MmcLC4C5AtHsrM0eSVfOP34dBl+CSTtU9JIdHh52RaLLAjU42aiqqBZYMrRtWxXnZb+Cf3u0aMetwXg8+AlGqy1uAzrE/bsmUCat4P3JIIwRgmhcO6eZuEyASJIlZ1wYtbEhhwsYUmIKa1j+irxhArr29Rxa/Nd0FYfeBpghCZ5L9I5T2aQeH7iPKie1KeWY14DP3ELBItSrYskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1283.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 09:59:06 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0428.014; Sat, 19 Sep 2026 09:59:06 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Hal Feng <hal.feng@starfivetech.com>, Michael Turquette
	<mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing
	<kernel@esmil.dk>, Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva"
	<gustavoars@kernel.org>, Richard Cochran <richardcochran@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 21/22] reset: starfive: Add StarFive JHB100 reset
 driver
Thread-Topic: [PATCH v3 21/22] reset: starfive: Add StarFive JHB100 reset
 driver
Thread-Index: AQHdJmAYveuIyf3zqU2+QbYV4aA7jrbSlDuAgANaB9A=
Date: Sat, 19 Sep 2026 09:59:06 +0000
Message-ID:
 <ZQ4PR01MB1202963BF92C33795AAA0A08F2862@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
 <20260807112923.191627-22-changhuang.liang@starfivetech.com>
 <NT0PR01MB110298B34F8DFB2791A129FCE6B82@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
In-Reply-To:
 <NT0PR01MB110298B34F8DFB2791A129FCE6B82@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1283:EE_
x-ms-office365-filtering-correlation-id: 526d7e8c-2431-42a7-4617-08df1634a498
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|38070700021|921020|10067099003|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 g5dgt/ICs7X4cqMlEtHOPaz+kg3QyD4tggzvoicnI0b8k5hIOgoDJpNd19lTqxBNkEoUyaEhsBby7c3R+H7g+W4/9QQ4pS1itwXZ8m39WEHmHXWYHyim3qnBrGufkVWF6R5ROCGA+kC5hqkP3D4nYsmduYZXVj3zHCZnRYhQrdOhPoNOqZyyYjcVgMyrnS6fACa4iYeAo9B2J70NR7U0e9TkXy4PR99wLvtQdTBW1FwYFthvcwfF3YIEzG4FqVWx5uwXr/wNijkHXwZKTXXMW0PO7BpaBHGgwJsfWdSCWq+oUS7qIb9nID90dP01KuGX1/8ETIExSGOSUo6wkGgAPjn9FOdxuhWmNoxmv1uG7J415Ookq6XAP1tbI4F0uxfLoQfgGuFkhNYMLiLR8PRAV2wsiuxnPxPSBmqoWQZJrys4rgNVP2VTgEVVix0LSlNtpsVpWJIAC9iul9oblQK2vc1zf9BL42OolNWhwdQpmZoEGVTyvMehpWuCCgd0QZNTOFCaOIOYsHSeXzVgX9U8huRu56iGidHQDZVc5ATglb08yivPpOEkvTHHfr/kUrPee4tj/t3FDaNeHxa5ArJRHQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(38070700021)(921020)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4+ew0yvHYQktnB/OZ+mKn75wedFWZbNmIEV5KBFfeebVnDQBgXXMUvsyj2EY?=
 =?us-ascii?Q?rD/k8Gzf3OYYLysxjRtaby0RC6/XgBF1ls8DnPERdgKR3HJAu2bKOKlx/wzf?=
 =?us-ascii?Q?mCvjK+ByttQ6QvsqSa+ntgFdYVrRcQHNnnOzizseWnuwUuW0uOJyHT9wRMrU?=
 =?us-ascii?Q?bz6HN/QLrK82HukSynSK6+FS1wt2Z6RW9Q46feCD0T7GsCto1KkHF9ASXHZn?=
 =?us-ascii?Q?6/xSnyFXUT6BUvQKVHRpTGLfkN5QPENYbvweKl3CIYmjR7QMaWBnonwMAcL+?=
 =?us-ascii?Q?AFvWoQrqCVBCRH78Cic0zAwt4Q7EvxJVnwS48pnT6Cy6f13gVlVOHToUtLoT?=
 =?us-ascii?Q?pFyr7UXYwXLWplaYjfRMtGrndj4P/G8WhZiTyb1stK0X5IG8u0/Lt+VcocOB?=
 =?us-ascii?Q?tysvKKB47KLSxqtY32Rrok54JRXRgSY8f2e/lpwYfuhDLdg8fupwUW1wOAx6?=
 =?us-ascii?Q?Fv0EQZDB5IrEKopMEk34EIdvmw/eOaU28ssqKT70TvYdW/phbHr49pnvAr1N?=
 =?us-ascii?Q?wwsTMcH8C8K/S5QoeCv+wb1CqGJUBDB3DJ4Sq8EC26w+HOJe09I7a4+iRXLw?=
 =?us-ascii?Q?FGXruoDcA+FNnIK0rNbejTsv7+ZHArzOR6gboSrPFajKRqUTshSPbmcluduE?=
 =?us-ascii?Q?C3Ib5gXMlNWyqHN/yrSZxgQCx1fjrmzveONekurdQ3p3J9b3Vz6zkJMoPKjZ?=
 =?us-ascii?Q?8jkcw65XapJ15nr20bXSp5lwF2Iosv9gn66a7xodGtDpJlmn41Z1jVyRH0XN?=
 =?us-ascii?Q?bGmEDWgR8jdPMZwsSZX3pFKpd5EY/i62NETOSg9VOvhaRXwHW4l7poeXoOHF?=
 =?us-ascii?Q?jDFsIpyitNzrpwBTUAwTx4CDDMPYtgqoSLr4NondyoMFNcAjDg2/NTKkE0JY?=
 =?us-ascii?Q?3RR91PQJYW7fmSFcD9le3mfxftd+VuzmsQiQNm55bfzwwe3kNic2LxxYfIwk?=
 =?us-ascii?Q?6MImHq1SANezQUD/GX0YnhmhSEzb44tUghVfbhTQWwdO1boFkDYGcumX7pqr?=
 =?us-ascii?Q?riJZY1Xx0ODYGOEOHjy0zBfPDtbkJgCbonmenNsE0dZwQ8d0pY43Yj3l+oMu?=
 =?us-ascii?Q?GdlukG31VKGLYG/PZjdxq0q4xu8rLv1QzlY7HXD6yb4jnS+JLT1M3wQKbxuU?=
 =?us-ascii?Q?iRBmKbm6j2A4dwz4a1FEVXJytlvuUAAKw0vj5miCQHL7L1O82vrQi0QIJ130?=
 =?us-ascii?Q?AbPlAW0jfxFVWv1pViWpxlJ+OPTYvZH2M14VM7BLFE85+9Lv62IfU5cgPkzY?=
 =?us-ascii?Q?6F/Cc/TINIoCdz9DrKvFJDXFls6gz9VOo2jDyT7l5A72fqsgXpfhMep5Ab9d?=
 =?us-ascii?Q?QNEqZYnLbpXp/CDADovCLffpqB62Xow2sxnWkKswlRk7/3cd/c7BdhHjjzaA?=
 =?us-ascii?Q?bcvaWmD9FCD4iOpdgPdeVzXJ6LB7zH7HDhFPPLFlFpQn3ktPjNj8Bvc4TCv5?=
 =?us-ascii?Q?PS0g+Z8LDElLsh+JQ1DBtErEuny7pc6Aa9u7RsrK/OZTfLzj0eQ2drwMgTbr?=
 =?us-ascii?Q?tAg19uP5d/UDSXvNluEH+/t0VWY2j2+1oe0ZgjFUbKGf5OMBEz2BKCogrjOb?=
 =?us-ascii?Q?886yy1pfQ7hUCbB8eGyT+z0zMlxe+LRQoVokjtMMnARBJlXkK1+Q/1H2IpLk?=
 =?us-ascii?Q?7AEP0leJI8LmbE/yVUXSlHehgbEm+gEHxlMqAWB20ON11K8bGSNvze4ET3Xu?=
 =?us-ascii?Q?qsa3LJ11vHUVGq8pXMtGUnt3qwYmDDwBG9LimdKwCbspKBTWBMVyypTege1t?=
 =?us-ascii?Q?lGnwwyGlFFzjFm28OfLqdBOc5tTW9sk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 526d7e8c-2431-42a7-4617-08df1634a498
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2026 09:59:06.4905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ixbkMPCzc8yesmbdFEL8rQTVeVedwX6691mWVpIw/piHz5wVv9zPqhxS5S9jLuyEP6MtAGnsX72hNtWg2oeZJv/IrXkH9Zh0rZEl6tlvFtGR+7RlU+S0LWWRHMPuK0x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1283

Hi, Hal

> > On 26.08.07 19:29, Changhuang Liang wrote:
> > Add auxiliary reset driver to support StarFive JHB100 SoC.
> > The StarFive JHB100 SoC has discontiguous reset IDs. A new function
> > reset_starfive_register_with_info() is introduced to support both
> > contiguous and discontiguous hardware designs.
> >
> > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > ---
> >  MAINTAINERS                                   |   6 +
> >  drivers/reset/starfive/Kconfig                |   9 +
> >  drivers/reset/starfive/Makefile               |   1 +
> >  .../reset/starfive/reset-starfive-common.c    |  99 +++++-
> >  .../reset/starfive/reset-starfive-common.h    |  19 ++
> >  .../reset/starfive/reset-starfive-jhb100.c    | 302
> ++++++++++++++++++
> >  6 files changed, 425 insertions(+), 11 deletions(-)  create mode
> > 100644 drivers/reset/starfive/reset-starfive-jhb100.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > c48b56d0ab94..709600e80951 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26088,6 +26088,12 @@ S:	Supported
> >  F:
> >
> > Documentation/devicetree/bindings/interrupt-controller/starfive,jhb100
> > -intc.yaml
> >  F:	drivers/irqchip/irq-starfive-jhb100-intc.c
> >
> > +STARFIVE JHB100 RESET CONTROLLER DRIVERS
> > +M:	Changhuang Liang <changhuang.liang@starfivetech.com>
> > +S:	Maintained
>=20
> 'Supported' is better.
>=20
> > +F:	drivers/reset/starfive/reset-starfive-jhb1*
> > +F:	include/dt-bindings/reset/starfive,jhb1*.h
> > +
> >  STATIC BRANCH/CALL
> >  M:	Peter Zijlstra <peterz@infradead.org>
> >  M:	Josh Poimboeuf <jpoimboe@kernel.org>
> > diff --git a/drivers/reset/starfive/Kconfig
> > b/drivers/reset/starfive/Kconfig index 29fbcf1a7d83..ce00495be6ad
> > 100644
> > --- a/drivers/reset/starfive/Kconfig
> > +++ b/drivers/reset/starfive/Kconfig
> > @@ -19,3 +19,12 @@ config RESET_STARFIVE_JH7110
> >  	default ARCH_STARFIVE
> >  	help
> >  	  This enables the reset controller driver for the StarFive JH7110 So=
C.
> > +
> > +config RESET_STARFIVE_JHB100
> > +	bool "StarFive JHB100 Reset Driver"
> > +	depends on CLK_STARFIVE_COMMON || COMPILE_TEST
> > +	select AUXILIARY_BUS
> > +	select RESET_STARFIVE_COMMON
> > +	default ARCH_STARFIVE
> > +	help
> > +	  This enables the reset controller driver for the StarFive JHB100 So=
C.
> > diff --git a/drivers/reset/starfive/Makefile
> > b/drivers/reset/starfive/Makefile index 582e4c160bd4..217002302a9f
> > 100644
> > --- a/drivers/reset/starfive/Makefile
> > +++ b/drivers/reset/starfive/Makefile
> > @@ -3,3 +3,4 @@ obj-$(CONFIG_RESET_STARFIVE_COMMON)		+=3D
> > reset-starfive-common.o
> >
> >  obj-$(CONFIG_RESET_STARFIVE_JH7100)		+=3D
> reset-starfive-jh7100.o
> >  obj-$(CONFIG_RESET_STARFIVE_JH7110)		+=3D
> reset-starfive-jh7110.o
> > +obj-$(CONFIG_RESET_STARFIVE_JHB100)		+=3D
> reset-starfive-jhb100.o
> > diff --git a/drivers/reset/starfive/reset-starfive-common.c
> > b/drivers/reset/starfive/reset-starfive-common.c
> > index 772bdf6763d1..86dbb33bb216 100644
> > --- a/drivers/reset/starfive/reset-starfive-common.c
> > +++ b/drivers/reset/starfive/reset-starfive-common.c
> > @@ -14,6 +14,8 @@
> >
> >  #include "reset-starfive-common.h"
> >
> > +#define STARFIVE_RESET_ID_INVALID	ULONG_MAX
> > +
> >  struct starfive_reset {
> >  	struct reset_controller_dev rcdev;
> >  	/* protect registers against concurrent read-modify-write */ @@
> > -21,6
> > +23,11 @@ struct starfive_reset {
> >  	void __iomem *assert;
> >  	void __iomem *status;
> >  	const u32 *asserted;
> > +
> > +	/* Only exists in reset controllers that use the
> > +	 * reset_starfive_register_with_info helper.
> > +	 */
> > +	const struct starfive_reset_info *info;
> >  };
> >
> >  static inline struct starfive_reset * @@ -29,19 +36,40 @@
> > starfive_reset_from(struct reset_controller_dev
> > *rcdev)
> >  	return container_of(rcdev, struct starfive_reset, rcdev);  }
> >
> > +static unsigned long
> > +starfive_reset_id_to_hw_id(const struct starfive_reset_map *map,
> > +unsigned
> > int nr_resets,
> > +			   unsigned long reset_id)
> > +{
> > +	for (u32 i =3D 0; i < nr_resets; i++) {
> > +		if (map[i].reset_id =3D=3D reset_id)
> > +			return map[i].hw_id;
> > +	}
> > +
> > +	return STARFIVE_RESET_ID_INVALID;
> > +}
> > +
> >  static int starfive_reset_update(struct reset_controller_dev *rcdev,
> >  				 unsigned long id, bool assert)
> >  {
> >  	struct starfive_reset *data =3D starfive_reset_from(rcdev);
> > -	unsigned long offset =3D id / 32;
> > -	u32 mask =3D BIT(id % 32);
> > -	void __iomem *reg_assert =3D data->assert + offset * sizeof(u32);
> > -	void __iomem *reg_status =3D data->status + offset * sizeof(u32);
> > -	u32 done =3D data->asserted ? data->asserted[offset] & mask : 0;
> > -	u32 value;
> > -	unsigned long flags;
> > +	unsigned long offset, flags;
> > +	void __iomem *reg_assert;
> > +	void __iomem *reg_status;
> > +	u32 mask, done, value;
> >  	int ret;
> >
> > +	if (data->info && data->info->discontiguous) {
> > +		id =3D starfive_reset_id_to_hw_id(data->info->map,
> > data->info->nr_resets, id);
> > +		if (id =3D=3D STARFIVE_RESET_ID_INVALID)
> > +			return -EINVAL;
> > +	}
> > +
> > +	offset =3D id / 32;
> > +	mask =3D BIT(id % 32);
> > +	reg_assert =3D data->assert + offset * sizeof(u32);
> > +	reg_status =3D data->status + offset * sizeof(u32);
> > +	done =3D data->asserted ? data->asserted[offset] & mask : 0;
> > +
> >  	if (!assert)
> >  		done ^=3D mask;
> >
> > @@ -89,10 +117,20 @@ static int starfive_reset_status(struct
> > reset_controller_dev *rcdev,
> >  				 unsigned long id)
> >  {
> >  	struct starfive_reset *data =3D starfive_reset_from(rcdev);
> > -	unsigned long offset =3D id / 32;
> > -	u32 mask =3D BIT(id % 32);
> > -	void __iomem *reg_status =3D data->status + offset * sizeof(u32);
> > -	u32 value =3D readl(reg_status);
> > +	void __iomem *reg_status;
> > +	unsigned long offset;
> > +	u32 mask, value;
> > +
> > +	if (data->info && data->info->discontiguous) {
> > +		id =3D starfive_reset_id_to_hw_id(data->info->map,
> > data->info->nr_resets, id);
> > +		if (id =3D=3D STARFIVE_RESET_ID_INVALID)
> > +			return -EINVAL;
> > +	}
> > +
> > +	offset =3D id / 32;
> > +	mask =3D BIT(id % 32);
> > +	reg_status =3D data->status + offset * sizeof(u32);
> > +	value =3D readl(reg_status);
> >
> >  	if (!data->asserted)
> >  		return !(value & mask);
> > @@ -132,3 +170,42 @@ int reset_starfive_register(struct device *dev,
> > struct device_node *of_node,
> >  	return devm_reset_controller_register(dev, &data->rcdev);  }
> > EXPORT_SYMBOL_GPL(reset_starfive_register);
> > +
> > +int reset_starfive_register_with_info(struct device *dev, struct
> > +device_node
>=20
> Also, you add reset_starfive_register_with_info() but a very similar
> reset_starfive_register() still remains. I think we can merge them.

The current series is quite large. To reduce the review burden of the curre=
nt series,
I plan to release a separate series later for JH7110 to reduce these simila=
r interfaces.

Best Regards,
Changhuang
