Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A884AF159;
	Mon, 28 Sep 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595782; cv=fail; b=ouDSXyIsiQnygixgSZfG+QEqEzEs6pLEajDf8YOKYe5HQfw6PpxayHxageTqp33vvUKnHtUv7+2+eoF/9Su5rUm0ksz5+jMgOlCYxhAcViNJ+j7LNEBe3BXyv9ReaSXAmhpmijL7cgJ0jU8N1gHMY6spkmbwQVv3besxQ00bCj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595782; c=relaxed/simple;
	bh=PqeXcfFbPLLu6gmQRuJcKOPS7u4OZn/DQ/f3NnWzpG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=USTuEoIbwXiZSn+feDDTua36Wkz8UFI2dtBKR/w/wmFzKhJ1CHzR2ikjgUZASfrIT9/LFdEwSl0yvlcdR9sd+qdhpbWMH94uO3/swp8Dkxx2FWw/JkcRLCzsSu/VmlpKxNwAU12QBc5HbNQiIW6odKKeGXXE1HpT4jXXtwFFnEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqgiuYDR6VJ6vNu7rw5hMRv7sVHaNdt5C/cl2Od510MXZ88vLQ3l11uWTrurBd+XunMwOHvAjsv4ARiNjBPXF+KrDGmsQMFDBB8r8ArK/tSwBXPmXCnPT7juqixuiVLQNdPcs7E9DBg50pOiZXTJuUZdb3cFtxWhfsdlI1Ka9I5nQrzOP3SyTKAnGvgYFd/pJGX7w7ZOEfNqloqC/gVzzfeRYLwvc1oGLAsy4EiwiXF5qL+Jm03zmiirN7lbYFyUzRc4DLlZHr7TOfiUQEiP8YGbXslBZu9LZ2j6VLSpeERKWVtPv0oK9slraSjkd6mVOF8EJk1VmnTxwXBNK6U4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTrxDBArZUTsBEewvE4tCsuzLPH7NoLEbaPdVbMkf4Y=;
 b=kPj+JuokuJ1wcaQ7oiteLKPBkFvJH5yIcqCVWF5RiaZeITS1AV90yk3LtJr3sIbjPwOBd4VyEy4J/TpN0Ngo0+rOTVyrSCPX4mE5pSeHRQl79H54A5VQPBJ2fLuBSievaNdZgHflArwKgkaxHEV7uipQDpjsEmoCHTF+uBSbP8kFF1jEmGfptg/HlZbiwOcg1JfwA+F00wsPc2i3A+ApTKrFqhhyhWUJG3avKVGe9DjR/L1scU6vA/GqHH0oNjOLZQGgsRuJtqKwSRERlIzzDchp6+t+gxyAwQZbskX2aZ0TU2jSy/neqFHQwOh8Uixf0ddx0EHK/D3C+n0OXqboWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1218.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:10:49 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.022; Mon, 28 Sep 2026 11:10:49 +0000
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
Thread-Index: AQHdSPew5FxIBMEJ4kOnpM+hu5x6v7bfcogAgARvjxA=
Date: Mon, 28 Sep 2026 11:10:49 +0000
Message-ID:
 <ZQ4PR01MB12022FD5940DAA1AC1279B8FF28D2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
 <20260920120044.194901-4-changhuang.liang@starfivetech.com>
 <1jqzih73ob.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jqzih73ob.fsf@starbuckisacylon.baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1218:EE_
x-ms-office365-filtering-correlation-id: b21e746a-e7bd-42e1-7b21-08df1d51271c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|921020|38070700021|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info:
 JQCM5EbUUtpn26juPOcSxK3biQDrpeCbaz9Xt+lnDQ1Isa1A+7ct2ggDn3tHhlwmKWryQgVtxUwNo0Xhj6d2HnIrwzURaxfr9klF16EzeoXkg6SWMxmX5Xbwod0+bh74QSq7OwP1lRH3dPYCS3vFkJSVDgJolbHhAnyp39R9Y3ZeC7FsvasWH0+FEK/N9Xb0iV7e7ehDG7Sp6049Ui0eruF1mJMVlI4SWYNAZoRYW2L3Hdc1Yppa7KI1zL4binQxY5NtADDeXMCPNY1hL1olE/jEGcOMVNZbSt0JpM4gP+DXVrxHpUWp77ctpzUWpwWU9wuIzadyWvsiLKp1EYv844qHtWxuvAfijUP3seNCb8YW5eF/VqSkWA93s2pmMK1WilLO6YqpW78mPiXk/Stvnk5SVMOXb+b83b49+0Vq5wJX5dzVQ3RzmxfchQSwjWswTp6Ko/xciGN2bcfsO5xHQx69d/k31fkYJOGZUGIavU6D2cD3LwWEaxter04b3zXL5efjeD9El0fqpv6JM45/k1sWZG1LLiiwDFFaOf4sNbx+XPBN7iJAeivrvc7YdyiVyqe+F/VIAdhVlyfqxbqhkQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(921020)(38070700021)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TgjOwH6H4JXwz5Jukj0X4iRDjcDMibYhMsOJoNohLdsHEd5Fcg4SVN/L7clD?=
 =?us-ascii?Q?/VwLsR+VyNRzcjjJ6+oPkeCSGkPbgwPpMQ10jOywzEWti+9Rx4I5ndnsFuqH?=
 =?us-ascii?Q?loG/AD6r1g6iagT4bg5M4Xs8gw9yLOyxToJ5h14sfv3R1kQ1346aiLdM5xTW?=
 =?us-ascii?Q?3EmeaknWVjlkqW9v8kMqTyHvk1Ir3RNVw7L+TWfjD55gKvtMys80hfYw/Kx1?=
 =?us-ascii?Q?l0KFSxQu0JQGML+mnNHhDiHh3uuTqTVckPDYDvAWs1BvwiT2JTig5DI8wF7/?=
 =?us-ascii?Q?FCvJ268ntSwybZTKThuoPohgwr+hjnjzYQPxH4GjZS1xPD7ckCx39M5MR6lJ?=
 =?us-ascii?Q?0Hyu15MYkhyOMNxVbNpv7Aa7q4lWUlGwr22cDW1fF3RY08o667X4PKLkjpEB?=
 =?us-ascii?Q?adJ2dJ5D+Onv6n9jwJT5U65Up78/UXxubWGPWR+9lpQBBZjap4XUGGR4HcZm?=
 =?us-ascii?Q?qBOgULKjrUN8rVlhKGVynHTolarM5B5ABIZAaui7ycrqQA3aNhH3iST1KOeJ?=
 =?us-ascii?Q?TJlD1urvrIm90WRQyXVJ1G54R5c/Rii6cKiGzvEOlsmLDdlpgl44HMZLx4xb?=
 =?us-ascii?Q?G5yYIEuYA2VXxMZvN3SYv+ZdtAuj2spL7Q7fVU9ogt4tzBuueRYovvuyyWFS?=
 =?us-ascii?Q?PFVrUdyYTmwU4K2aShTwstD3mdSkzsRiVB0vUgcWs5aPJ+mg0VNNQMdM5S2F?=
 =?us-ascii?Q?VcGQ6Fu1L698iVYIogW1PNK7bGMSpSSNc3fZK1MLe6fbraLNrMuwBv7X1yrJ?=
 =?us-ascii?Q?gUG6gzSqEMrlYdbfxlmP3qJFeT1T2krJSd0SrzNhc14BvEznacSXmTPR08ZV?=
 =?us-ascii?Q?gEuSSpvshC0AXlB09+/J11xTd9ddZ+5FFdvMQ/InffsLMlABMHtG9G4L/736?=
 =?us-ascii?Q?2XaxcJG2tNdJ7KDJ8iuf4f9Y3wE+Q1TjgHr01XdA5Ui8vucT/55Dc3WbhzWs?=
 =?us-ascii?Q?QmZCaq9rZKzAZkz6j7nLfEo2A+rr2tcJOh8tsU6NrViEl0vmRCdGpvXcuQnS?=
 =?us-ascii?Q?sh8rYA97yCp5ZA6XEouIZ83tS20FtnzkawWBBxuQ4gm9XbHnJxnRN1tQO3/J?=
 =?us-ascii?Q?XRK8Yzpe/ytBU4Yv6V8vUgM2oEb/lAShyzY0dsrEDQmESt6B068KolzlVe7N?=
 =?us-ascii?Q?bXSizqLz9vBIel9uUPQ3pUHfYu/lrW4xpuqIqmru7KFI1hCEER8JYbbJX2XS?=
 =?us-ascii?Q?aTRt268QQX5nQ+vtvOcTSNwe5nXf1x2ncoso8dX+LQOR+deFzJdW6N1SCYMk?=
 =?us-ascii?Q?BhpVSbFMryiiH7PN1fD6Rj5d+5zxXoDpLw2dTasEyUw1oEZF2H65r5zex6Su?=
 =?us-ascii?Q?7JcWq9WElPdrOdzqNO+mMf2bRL6N1S0gnbkHk3+A3FEnjviJDkZ52dplK4CS?=
 =?us-ascii?Q?4hIizxGQqmlw6T5HSjHyFfiIf6PzEGD9ybk0LF3o6C3f1PvnLH2XEt+4pJlm?=
 =?us-ascii?Q?FC1mWRMqA4GaCagytE/f+0u0Ky/FfcR9jX7it+d47vsZ7JtPQDsoAISc/6/y?=
 =?us-ascii?Q?kMKwE7mxzTfvnsEX00bcduq4o9BxI7k4Wa08wGw9OZBcu70ciTpQKIWnqUjT?=
 =?us-ascii?Q?YScQwNmEunqEdHXI7lCha99VU5esFwAJU9TExr5iZT80NuyWxnG8CGPDvjwS?=
 =?us-ascii?Q?dxwDZQNs0R9RO8UIrme8RxM0c++i5zzBiVhobmV0Hp8JCvXgQiGNsAI0Z+Fr?=
 =?us-ascii?Q?P1Zb1TbSMiZiWxEJZod1wiDV7iTcVSGLgHiC+S/Aqja5xpFgZvTflpA8NT3f?=
 =?us-ascii?Q?RjqLHxfnLW1cgMtN9UcWERHyub/xmN0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b21e746a-e7bd-42e1-7b21-08df1d51271c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 11:10:49.4851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMSazaKB2EgGH6TKnd+3cVVTTPv7CosJIZceAswkxETMEWrH+/L8jeeEn52qLGWTahO0MHjEUBNTvy9JRJVXO+h2k/x4xUDltLSmxIQcP/pDZdNO61eKCnkY8FT13Z9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1218

Hi, Jerome

Thanks for the review.

> On dim. 20 sept. 2026 at 05:00, Changhuang Liang
> <changhuang.liang@starfivetech.com> wrote:
>=20
> > From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> >
> > StarFive JHB100 shares a similar clock and reset design with JH7110.
> > To facilitate the reuse of the file and its functionalities, files
> > containing the "jh71x0" naming convention are renamed to use the
> > "common" wording.
>=20
> Is this really necessary ? Rename are generally not recommended.
> Do we really care if your new soc use something named after the older one=
 ?
>=20
> You are naming it common now but how long is it going to stay "common" ?
> If your next SoC does not use this anymore it won't be common for long ..=
.
>=20

Okay, I will drop the current PATCH 1/2/3/4 and directly reuse the current =
JH71x0-related interfaces.

> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > ---
> >  drivers/clk/starfive/Kconfig                              | 8
> ++++----
> >  drivers/clk/starfive/Makefile                             | 2 +-
> >  .../{clk-starfive-jh71x0.c =3D> clk-starfive-common.c}      | 4 ++--
> >  .../{clk-starfive-jh71x0.h =3D> clk-starfive-common.h}      | 4 ++--
> >  drivers/clk/starfive/clk-starfive-jh7100-audio.c          | 2 +-
> >  drivers/clk/starfive/clk-starfive-jh7100.c                | 2 +-
> >  drivers/clk/starfive/clk-starfive-jh7110.h                | 2 +-
> >  7 files changed, 12 insertions(+), 12 deletions(-)  rename
> > drivers/clk/starfive/{clk-starfive-jh71x0.c =3D> clk-starfive-common.c}
> > (99%)  rename drivers/clk/starfive/{clk-starfive-jh71x0.h =3D>
> > clk-starfive-common.h} (98%)
> >
> > diff --git a/drivers/clk/starfive/Kconfig
> > b/drivers/clk/starfive/Kconfig index bd29358ffeec..ff8eace36e64 100644
> > --- a/drivers/clk/starfive/Kconfig
> > +++ b/drivers/clk/starfive/Kconfig
> > @@ -1,12 +1,12 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -config CLK_STARFIVE_JH71X0
> > +config CLK_STARFIVE_COMMON
> >  	bool
> >
> >  config CLK_STARFIVE_JH7100
> >  	bool "StarFive JH7100 clock support"
> >  	depends on ARCH_STARFIVE || COMPILE_TEST
> > -	select CLK_STARFIVE_JH71X0
> > +	select CLK_STARFIVE_COMMON
> >  	default ARCH_STARFIVE
> >  	help
> >  	  Say yes here to support the clock controller on the StarFive
> > JH7100 @@ -15,7 +15,7 @@ config CLK_STARFIVE_JH7100  config
> > CLK_STARFIVE_JH7100_AUDIO
> >  	tristate "StarFive JH7100 audio clock support"
> >  	depends on CLK_STARFIVE_JH7100
> > -	select CLK_STARFIVE_JH71X0
> > +	select CLK_STARFIVE_COMMON
> >  	default m if ARCH_STARFIVE
> >  	help
> >  	  Say Y or M here to support the audio clocks on the StarFive JH7100
> > @@ -33,7 +33,7 @@ config CLK_STARFIVE_JH7110_SYS
> >  	bool "StarFive JH7110 system clock support"
> >  	depends on ARCH_STARFIVE || COMPILE_TEST
> >  	select AUXILIARY_BUS
> > -	select CLK_STARFIVE_JH71X0
> > +	select CLK_STARFIVE_COMMON
> >  	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
> >  	select CLK_STARFIVE_JH7110_PLL
> >  	default ARCH_STARFIVE
> > diff --git a/drivers/clk/starfive/Makefile
> > b/drivers/clk/starfive/Makefile index 199ac0f37a2f..012f7ee83f8e
> > 100644
> > --- a/drivers/clk/starfive/Makefile
> > +++ b/drivers/clk/starfive/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+=3D clk-starfive-jh71x0.o
> > +obj-$(CONFIG_CLK_STARFIVE_COMMON)	+=3D clk-starfive-common.o
> >
> >  obj-$(CONFIG_CLK_STARFIVE_JH7100)	+=3D clk-starfive-jh7100.o
> >  obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+=3D
> clk-starfive-jh7100-audio.o
> > diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c
> > b/drivers/clk/starfive/clk-starfive-common.c
> > similarity index 99%
> > rename from drivers/clk/starfive/clk-starfive-jh71x0.c
> > rename to drivers/clk/starfive/clk-starfive-common.c
> > index 80e9157347eb..4aecb65e9fd7 100644
> > --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
> > +++ b/drivers/clk/starfive/clk-starfive-common.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * StarFive JH71X0 Clock Generator Driver
> > + * StarFive Clock Generator Driver
> >   *
> >   * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
> >   */
> > @@ -10,7 +10,7 @@
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> >
> > -#include "clk-starfive-jh71x0.h"
> > +#include "clk-starfive-common.h"
> >
> >  static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)  { diff
> > --git a/drivers/clk/starfive/clk-starfive-jh71x0.h
> > b/drivers/clk/starfive/clk-starfive-common.h
> > similarity index 98%
> > rename from drivers/clk/starfive/clk-starfive-jh71x0.h
> > rename to drivers/clk/starfive/clk-starfive-common.h
> > index 9d5dec1d5cd1..f634c62c196a 100644
> > --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
> > +++ b/drivers/clk/starfive/clk-starfive-common.h
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */ -#ifndef
> > __CLK_STARFIVE_JH71X0_H -#define __CLK_STARFIVE_JH71X0_H
> > +#ifndef __CLK_STARFIVE_COMMON_H
> > +#define __CLK_STARFIVE_COMMON_H
> >
> >  #include <linux/bits.h>
> >  #include <linux/clk-provider.h>
> > diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> > b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> > index de1cf717e391..0e363b971e9d 100644
> > --- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> > +++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> > @@ -14,7 +14,7 @@
> >
> >  #include <dt-bindings/clock/starfive-jh7100-audio.h>
> >
> > -#include "clk-starfive-jh71x0.h"
> > +#include "clk-starfive-common.h"
> >
> >  /* external clocks */
> >  #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END
> + 0)
> > diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c
> > b/drivers/clk/starfive/clk-starfive-jh7100.c
> > index 761e46ed0ffd..ca81ccb5af94 100644
> > --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> > +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> > @@ -14,7 +14,7 @@
> >
> >  #include <dt-bindings/clock/starfive-jh7100.h>
> >
> > -#include "clk-starfive-jh71x0.h"
> > +#include "clk-starfive-common.h"
> >
> >  /* external clocks */
> >  #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
> > diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h
> > b/drivers/clk/starfive/clk-starfive-jh7110.h
> > index 0659adae4d76..6b1bdf860f00 100644
> > --- a/drivers/clk/starfive/clk-starfive-jh7110.h
> > +++ b/drivers/clk/starfive/clk-starfive-jh7110.h
> > @@ -2,7 +2,7 @@
> >  #ifndef __CLK_STARFIVE_JH7110_H
> >  #define __CLK_STARFIVE_JH7110_H
> >
> > -#include "clk-starfive-jh71x0.h"
> > +#include "clk-starfive-common.h"
> >
> >  /* top clocks of ISP/VOUT domain from JH7110 SYSCRG */  struct
> > jh7110_top_sysclk {
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20
> --

Best Regards
Changhuang
