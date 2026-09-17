Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2094.outbound.protection.partner.outlook.cn [139.219.17.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C433CE80;
	Thu, 17 Sep 2026 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615780; cv=fail; b=nvQ08T7kXgSCjj9Smq0B0QVqbMB9OIC6MqhhmcFE6QhHoOgzQvxSqQvncQfbl3+8mWzRVld5M3+hzjNWqRX39V0L/BmY/ScUPWfTPP9nMMVQgCtnLTPVjVz7DKooYtvAHdjPMiusfWtu78RTEQ3bga1vBns+UF4p76TP+HoyeXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615780; c=relaxed/simple;
	bh=UjjAUIC2sujlyjkQaA4IN8pXo+5xYWtaXsGWVbdtOt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oLba9cf9Xd8c0qoQkWNWinuOCoy32HQuRc9QIDgoBLLfLuVsknIyP/ezSvzj1fSGim0j7jEnXW51dSDn7i3D9ShbhQtfoG73T9bYnltk+lNSxVv2cW8VA8YJrsJdE+/2lSA4ILaQCI3D7DpXhUn0z4X499HJlP/QSz/bvO9Rn9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBGK246pu4t26mH+i3ni7SW5tLwAEVBcjhmx584Ap+7+alCx8SUpWljCFq0VbhrJW5V0/eMdLBp5rpxefDXXMzbKpYTD8BuvfiS+W6+sp2j2P+flBzB8KQevtP2+501GsdyL7gQ/IhtCXgJ8NOCK3LHy4PVek/rxWtbXriFEj65pGNgf/mjin0xIaWh5e15t+U0r6JimMQ9cjNzhoRIAxtiH+zhJn1POQ4Ur11GqjkpQLjldQ9Cw6s//ZtBQr+QswzMQdPezgv9KqArw49BlZreGFuHjoJ2YMSDdB3wAW7o8YBfUpigq0ZKF1EPXS5Zv+GcfgEJd1jf/9TEWLLaWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhUE2wBAdpCxDowA8LMGsJCj+6KXO8laPHfX+WgM5R8=;
 b=hjUrXjgbs2HlBcyvXxPOGfHa+pI82ub9eOeKcJ+nmpypHN2AMaxF/xCnqfSDVd6buQmJmqg5bCuiJxYwpyZ3Wf8nOvmPVfY9tz2Qjje9zEfEv3jcHp5NdWgSIHuQHXJ47/StGA0hGUOgaALC+ZlCpba09gbITDYao3SVJkd6rm4naAHD6BeVf011JSRTJHKh1wiFDfdublyoTEawmUefJyuq/D4rwq0+XeK/aFr2OnmCxgzeawpwzLYkRo4vQH7qCguSAtfkEMZG0YnHwFjkTEpDSnXhdgIr4FSw8RAcPXtf2pTIRfy531cJOwbR36gDqTBKbdNlfoX6ED65/Lh7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 03:29:25 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0428.009; Thu, 17 Sep 2026 03:29:24 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Michael Turquette
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
Subject: RE: [PATCH v3 12/22] clk: starfive: Introduce inverter and divider
Thread-Topic: [PATCH v3 12/22] clk: starfive: Introduce inverter and divider
Thread-Index: AQHdJmAQzGtl/CzpbE2DV2ErMGmNbbbSW3sA
Date: Thu, 17 Sep 2026 03:29:24 +0000
Message-ID:
 <NT0PR01MB1102A3B324F14495B35AF310E6B82@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
References: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
 <20260807112923.191627-13-changhuang.liang@starfivetech.com>
In-Reply-To: <20260807112923.191627-13-changhuang.liang@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1102:EE_|NT0PR01MB1006:EE_
x-ms-office365-filtering-correlation-id: 4f3f89da-9bb0-41d0-64de-08df146bdf37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|7416014|1800799024|10067099003|18002099003|22082099003|56012099006|4143699003|921020|38070700021;
x-microsoft-antispam-message-info:
 Fk6je+0tf9zQos4M6eGkOAII7feXXUPM+l9qqS3p181nOWWG0SkvxKNbr6S4hFyyAQjJYxmJNse/NvMj+PsgIuktKAeIRvCmoEriE7OXX6Dd/EZBCVrnaCkzbvuFgu3UnljDG7u7DLYCfaI8/0uU33Pp4a67nYyJFWwIZuyh75nrtlPXSqrwRoPAIPiCt9SyvEvYxodNoog4+JAOzknZBush0QYmFI4rMgMlVE1aq1+63M+mzKfKZulepicNulNZcUs9HssKQHSBy8jjLgkQ8n8MyGKnlJLxUbVM+b2QnXgdJ0Kq985AadqrM3xE6Yxd3bQPywq2PfP9OwOQVP8IYB58zTYYFVFbzM9MSVOlSK7Qo7hhuHkfzB21Nt/T/+llB9mOnPOfymkveaOlXAHY2V2r1mdqTQ8PD9i1f5IzwB3OFzI71Ep3O5WfPN+C/adoheZKan5iML5xJThaf3M+6F2h2Gll7B+2GoFk09Seqerq5sWzErrKOAXn5+V26xnqD+XJn40pkgMvAXtecvcpz2CcjmlM5g6XMM+jNv914CY27wBtCuz/cPEAmUsg5xCscEwSi/VnaSRHOHBm5qv1Ig==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vkPAM0xeLiullzfi2EScRkTpTuIV+Fd6lFdUS8PztcH8/bmhSn3xER9ypGuO?=
 =?us-ascii?Q?+aPlzDvkohuVhaRctQ2T7bAEJ90p4t/7jj+OW7zeNrVIND9UGFPfS/diaWQO?=
 =?us-ascii?Q?+qQVOdcBpg7GQeNnbh3x9tGVvdF8UXUCocTI44DZl1RNV+kMdofWjtCOW/Ig?=
 =?us-ascii?Q?I5jC4xiYAHRIffguEyazz5SKdeTW2qBlfGVipEdefwhzMJKqyqJIi/BJFBXB?=
 =?us-ascii?Q?bT4r+klB1PBYKRXpQb18R52FViUd9nnPJpC2+JVlEhBEhUzzPywaMmGqYq/p?=
 =?us-ascii?Q?xuQeSvAQFZns2IwOQCW+Qoa3vEvCMnwPaAtfTgEO0aSyMMeORvO9o332Q0en?=
 =?us-ascii?Q?K/fg6pvuCdPPdaukTTnsrgwwMcylZowyBX9OBmXX94FLOXCkLk5bAZAK1c2b?=
 =?us-ascii?Q?cQaaCVN195mu2rlEgNAZNMkoWk0bl8oJ4F3phx4zfCxKWwWnNqekH8ELN59P?=
 =?us-ascii?Q?PP6dPu3lbe3WckPyK9yGRDxoBTdrgqN+v5xdtcPSZ9WEwMUyy1Kjsw0oiH1A?=
 =?us-ascii?Q?RUXZ7TMUPZJCJ/0FQ7IApHAVmOCz/F8Ayg5Cjs/gLqS8ln3uTxM/7DzI3qwW?=
 =?us-ascii?Q?JR0X2p2OP7u3RnCwT8Lv/SM8o6UUpN2PJCiCTLon+Had+jKccYYrep1dbGbx?=
 =?us-ascii?Q?JlfdM3RIgoOLPW9dtdoRW0EmLKLyWBG003LUcFeAtD2Fm/SvaYVZB+9qrooX?=
 =?us-ascii?Q?6SJNJW1DjS1lb0EKdsghtRPSbeMinZsUgovjJPoB05OThTTqhYkbLvrp7W2G?=
 =?us-ascii?Q?KlBREsa3yeznHB5UdpsL7EMHEqbxJFtY8pMq+0zwAyqj/io3rwmi4kfC/rAO?=
 =?us-ascii?Q?Wg9TN8PSNVurZaRSURRyeHMvTn9IogU8ijZD0AM2XDASbtlNnegbg05ulmiP?=
 =?us-ascii?Q?2eGYVU6xf2lvZFdxrwaFT62AG85LXzEqx7sEqBFnI/Z3zT+Eycqbf549cAHf?=
 =?us-ascii?Q?CUAdWwHDw2GNpnCfnD0vTm4qm4wGBK1/CiJbhe8iwLxkGlyzjSj07+qaXUKm?=
 =?us-ascii?Q?fiCLKgJCQoH+qDlo8DaurF4drMJj390niG7+QlSVHRBzbX0SNbVHogwP3YAp?=
 =?us-ascii?Q?Q8x6eVCmj5J0TCqjyzoM98ppUBdNZsXtr8eto/y0M3rRrNC0Y5iUCAOIl2Ip?=
 =?us-ascii?Q?6nHJ7/sseH78GzvGw8vTENj09j6EHusY7pDPMk47CAARAcl7GJa5dt69FljK?=
 =?us-ascii?Q?RCBre+KsMHcUPw9jlBMTwtSss3whe+a6ivMLSOzOHJALv8pBJja/nWjObBgB?=
 =?us-ascii?Q?IOXI+fd/8L73odTT4UMTKDTKtGeQQvcrccylcTb85nlnhYedUnrXACYGrgw4?=
 =?us-ascii?Q?0KhS645FYEepP7NsyH/aUahTfn+mdY6mmqa+rM1HMMAVtSwOwbJ26d1tTE4x?=
 =?us-ascii?Q?p4k4yBfX903eQj3MiEOOcsp7zSrl2nTDjuE+duRjpHm2i3JcxFIbKFTVJqfv?=
 =?us-ascii?Q?tjIQtNGN6r6AXjz4ZuR6vQoPU/JdI+m3A0w4LnNuj8HwJVOyt3bB0eShPYY3?=
 =?us-ascii?Q?XgUm65KwPXhjfeP+jz5OIU01LVWeudP1qcKA5Mcfmn5JcrpojJibbC5PKVwN?=
 =?us-ascii?Q?lvk4tDoSnHFjmb0W8PlcyGhk/MkactZ5X392DdIQG2D1Ca3T2Gn12l2twTqW?=
 =?us-ascii?Q?/LhX0FdJ3mTSAnn4nYv1QaE6ZXAnfT5xXEPmF4fin3IkCJIR7KsrgxE8iYWl?=
 =?us-ascii?Q?GJw3jyCp6zYaDB8ZOUgsv8+wNLk53J0mgcozKD8TP4f5pstLv0DJcGlt8JGc?=
 =?us-ascii?Q?GlIsQz2YZw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3f89da-9bb0-41d0-64de-08df146bdf37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 03:29:24.8431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xs1CyE2SHmycldhrIHQu4h1RzxzDj8EsC+EXd3lbP+ErQh+VtUXOu9s+cnhJO5luijqYuBabq0/TrjGpdZG4WdPQV3MyPHeWqnZvxzDLVM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1006

> On 26.08.07 19:29, Changhuang Liang wrote:=20
> Introduce inverter and divider for starfive clocks.

Maybe you mean an inverted divider? Not inverter and divider

Best regards,
Hal

>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/clk/starfive/clk-starfive-common.c | 12 ++++++++++++
> drivers/clk/starfive/clk-starfive-common.h |  8 ++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/clk/starfive/clk-starfive-common.c
> b/drivers/clk/starfive/clk-starfive-common.c
> index 1b5e56af4138..58ab93d9748b 100644
> --- a/drivers/clk/starfive/clk-starfive-common.c
> +++ b/drivers/clk/starfive/clk-starfive-common.c
> @@ -300,6 +300,15 @@ static const struct clk_ops starfive_clk_inv_ops =3D=
 {
>  	.debug_init =3D starfive_clk_debug_init,  };
>=20
> +static const struct clk_ops starfive_clk_idiv_ops =3D {
> +	.get_phase =3D starfive_clk_get_phase,
> +	.set_phase =3D starfive_clk_set_phase,
> +	.recalc_rate =3D starfive_clk_recalc_rate,
> +	.determine_rate =3D starfive_clk_determine_rate,
> +	.set_rate =3D starfive_clk_set_rate,
> +	.debug_init =3D starfive_clk_debug_init, };
> +
>  const struct clk_ops *starfive_clk_ops(u32 max)  {
>  	if (max & STARFIVE_CLK_DIV_MASK) {
> @@ -310,6 +319,9 @@ const struct clk_ops *starfive_clk_ops(u32 max)
>  		}
>  		if (max & STARFIVE_CLK_ENABLE)
>  			return &starfive_clk_gdiv_ops;
> +		else if (max & STARFIVE_CLK_INVERT)
> +			return &starfive_clk_idiv_ops;
> +
>  		if (max =3D=3D STARFIVE_CLK_FRAC_MAX)
>  			return &starfive_clk_fdiv_ops;
>  		return &starfive_clk_div_ops;
> diff --git a/drivers/clk/starfive/clk-starfive-common.h
> b/drivers/clk/starfive/clk-starfive-common.h
> index 4cd4357f8366..fd9d13735896 100644
> --- a/drivers/clk/starfive/clk-starfive-common.h
> +++ b/drivers/clk/starfive/clk-starfive-common.h
> @@ -104,6 +104,14 @@ struct starfive_clk_data {
>  	.parents =3D { [0] =3D _parent },						\
>  }
>=20
> +#define STARFIVE_IDIV(_idx, _name, _flags, _max, _parent)			\
> +[_idx] =3D {									\
> +	.name =3D _name,								\
> +	.flags =3D _flags,							\
> +	.max =3D STARFIVE_CLK_INVERT | (_max),					\
> +	.parents =3D { [0] =3D _parent },						\
> +}
> +
>  struct starfive_clk {
>  	struct clk_hw hw;
>  	unsigned int idx;
> --
> 2.25.1

