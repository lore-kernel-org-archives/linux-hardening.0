Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFCE2652B2;
	Thu, 17 Sep 2026 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624159; cv=fail; b=rRiMXxNQe7dRlFj4JDcujS5e2U1a45G/I3Fdx/pmgxr4Y/Ybsacyowc7rp5yFXTU8rVs3HK5WLZ4KGHWcfK5pJG3OxQlJogpgm9iWdruhB4Gldel0JHfID1lReVUUm8h6fFhxuSicGgpUobhttbHqXegS+LkM5OLZk+O9K+928Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624159; c=relaxed/simple;
	bh=NtxyLXQARf+x/yd9iXwQ8HfaVEXwhQhNHREwAfOQTcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZ72cFWrGHnqxLPW03N7jBpcA4tCcxXPoY6f8zm6uiZ6bcBDvOGa8DOig6dzGphOkpxUu/jKVPeXl04PhGPUFJvYQPE+uMYfKbGZnvUIjmo2qFPi3lPr9BynFLmq5e5AXLkufOVtuhQIB+SfO9bpbYVNYZqyhbNgGPWVkcHCiX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbFfpFIlskgE1iBiJh4ep3+E1byBW2oH1pSlVnF/vbhizL9Iobq1n4asuhFtnIQZAKwO1T0O/c3YYkrphBrgO850SDni6PkQprtKdhqR4sJqk1pWc+5okJ88ewxURhGiraZZVOLw4GZbOzSihYNZTmEOdMc5qohFpNiCPqMATi++Ui67lfrzc/40GbK5Qrllt3svuxgJP8FPSdV40JClEGK+VzcLYgFPYDNOxU1HiSPhfuIWFHkUmbOUF7VXu+o2s8Xe8oAGCP+c3YCnOgci3yogQ7FBIBpe/NMs98HFtCs9QYbe86z5sy9jzZYvD1XEHIlY4pEyHVWNJmo45NsodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ochUMtHqBGkG0CbURIK5GLurAtjJrKZU8gnEdanMn3E=;
 b=gpfCcQiz2htmcJgvwT2XMlmsTThpRnGnO+Et7Oub2F/A+83JHlJJXOHJZzlUOaRkTfw/IlhiT9WXy8ne9CUImSsjCcQTnJTvDB5AsUnPGWn8kxnLmLTOPitXowJOtIcYUk6LBiQO7AlmiIB+if6suSb6AuoxyoobnWOD4Ir1K/siNuw2/tfI05e7ggTjd3+D+Ui+m9Zdc+lGcZinPCOzNzydRKW+rrtNuX6IGw+8dvrzdTx2LYu9eBHkN4FLH/eNe7zwUCq7bqL7CpTJ7rfLVPdr9RxqkNfAmy/1BPNzZ5m/vMiRCXk16vtqzPzzPYpMSTWRqjeHzd+Dfzq5TB9yRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 05:49:03 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0428.009; Thu, 17 Sep 2026 05:49:03 +0000
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
Subject: RE: [PATCH v3 13/22] clk: starfive: Expand the storage of clock
 parent index
Thread-Topic: [PATCH v3 13/22] clk: starfive: Expand the storage of clock
 parent index
Thread-Index: AQHdJmARC5U5bYDm0EiYYowQaOBBp7bSgr2g
Date: Thu, 17 Sep 2026 05:49:03 +0000
Message-ID:
 <NT0PR01MB11020A74DD7395B6E8C8DBFBE6B82@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
References: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
 <20260807112923.191627-14-changhuang.liang@starfivetech.com>
In-Reply-To: <20260807112923.191627-14-changhuang.liang@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1102:EE_|NT0PR01MB1024:EE_
x-ms-office365-filtering-correlation-id: 4b74b102-d229-4159-72b1-08df147f6140
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|23010399003|1800799024|376014|38070700021|921020|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 tDOm9vF5Gjy/fJ1SB1srm3Rk/Sfz5iCEutnI0wto11TQ725LdIJ+r6LyfQ9KA/fqN2GNQzLoWh7p0/iTBNqZIot0TUOWSrcQLsSO7+aLYY15YduhNTxcwo/oe8u8k0qoIhDZAMMICXI+niSXo9+gjGe7FANIJN7KvxCFN6lbCEJCY0liTuZjlYeadgOuyha1smudFYKHXcPnW7VKRDfC4jMfDCYNp2nhhfQcbdImgKne0I6x0MLff2Osq0zpuWxgcNJCPf8oG7GXLuWG/A8Mz08jSnNN68eCg4aB7T+DQj5uP/V/WEMm7bDNvxxLPKCIFRQEVEj7jnzZx6XncU4xglAzAtkUM1XTTwynxWfwuEBRALDZA39F1CLD+D84L89Ui6iJKr3F5kZqYIRqkUVj2OO0jhwx76IK7i9brruKNWvfWiFQuH9vkSTAqgFDr/OFM/OFwgP5QBTR+J3Iv8duhy8YB4z6LkmPA1xD3yCcR8xnmVQvG/9ylHrRQhYINsXmny/+pmqZ4jVAtkEzQZxlRoaSj7P2IjIfUzoUNYBBVxmIXaXn+Yigp/8Gz69BcdoPrEvWcZNvA0OC+ZWra2n0rg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(1800799024)(376014)(38070700021)(921020)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bxv9XK6Yz9UHMhZFzB2va09+FepkC6DpIf6Afn2cLquKm/ak8YAgtLr1Qv2V?=
 =?us-ascii?Q?m+yJRsgDdUFwXIPsmOUkgxZWsp9ox78aRcbg0Tf900pNlN7jkrrpwvWPKckl?=
 =?us-ascii?Q?Md2YLIQJWWr421K7LiI2Phxcq2V03tJyeHqnVRzG3fVQiOPxVoEFpfw5qsIg?=
 =?us-ascii?Q?Z/PzSKIuMVLL5N6JIVhvhXTKy1xEO1V+fANoK/XbfIgnV2wxcc4yaGNr98Bo?=
 =?us-ascii?Q?tTPNaRYxzXJ39JLL+H3DaUuHVDP3bah7DtouDSt2/Z4jfBuAwJ/2LSAtcP1U?=
 =?us-ascii?Q?71AGAIYX50ZKmQdfJ17fng6k9CgUeNuaobm8A6Q2/KBX+AYFFiFEsTazIK7R?=
 =?us-ascii?Q?MAmezXrqwH2ojgzrV7i7tvVpNy5sAtFv3ouFQvqLMFCUbDLxmW+y5v5uY6x+?=
 =?us-ascii?Q?rfKscOAipt+aUpzQKlZq2r+1X9ZRCdeAJgfgwho2PMrbnr8bMoj1y+70PiJN?=
 =?us-ascii?Q?IxeNmgBriIZWVq85W+/0YmkkiW+BXyf4jy8CvSPAgfqoJPypZk2ennnRsT2B?=
 =?us-ascii?Q?+is/WcZoUfltHmSiO6APeIyp/jYvDy0MwvWPaFdW0laQwxiykwpBswQKGdE5?=
 =?us-ascii?Q?/BV/NBb3I+gTmVrtiJXBsIkBRwqihoOiDQSq6/mCGztuilB3X/YmQMaM5KUh?=
 =?us-ascii?Q?IhFHrkZsu6oX2JE5NHQiqVrneFimAooPmSS2LqEpEl1z+YcBauf7SPfgOp02?=
 =?us-ascii?Q?ONCTlFwlpYuC18NrDF55NB+an3x4NEzJ3A2idO5fugyyVVpA3TPzZs3LWmzK?=
 =?us-ascii?Q?cnXNk1LVtODJcue++VMT4DOOpljB3lgck5YQPgXO4MLch47r2GE9KAi306LW?=
 =?us-ascii?Q?DBRKuq/4b86SHLN3DsFjAAjvcwrY9/aI5AvFu8eUe2duGU08//ZpwMkvpAkJ?=
 =?us-ascii?Q?Xxp0XtlybceP0E1I2DvyWvQRM6fTLNp8ifCBDQ4AEZ1I+HkBJYd++PPXFgRo?=
 =?us-ascii?Q?JrXaVeKyAo5abdmawuArB2otPBURPm54k5aWc4PQwKhgTb/ORXqsZuLPDLyx?=
 =?us-ascii?Q?G5+tj1X7n2oqaOeDwHLA5T14LbxpZ2dJpQwA225dAAOeqn0TZprk0Oad5E7+?=
 =?us-ascii?Q?fe2fIgPpd5mSsmjRYEJDVdcnhBsYRPq1BuhkDRiyZGuTXxDal7CeRtowSpK5?=
 =?us-ascii?Q?upEVqp1g4WZ9ot43ZR2O0y/XMwGOvUv1gvVfNpEoWlgNSbt5ARw075nPyTmd?=
 =?us-ascii?Q?TK3KgzMlU5Ad7fqjYnBwP/GSXQgo1X15QSNc1puewC6wlbSTNr3A237UzpBC?=
 =?us-ascii?Q?OLHbHC5Sr7n6WXVgb1MVRY9NqVQ+RH61I18Pek4joAwp6j9npoxFXLeLuXN9?=
 =?us-ascii?Q?kWacWcc7PiNpVP22KYychQHIMUGUnSa/1Nc+WScM1b6GaS6zHCBmf6Qv8021?=
 =?us-ascii?Q?VVGZj/KnyZJln8kxB5ChHtY9dq0YYkYsrqqOX3LqOKkE2XZZ+VqAMwogNs60?=
 =?us-ascii?Q?3D7prpmjYiPjfk0QnYKh8ZrJQKVfp2ITh4wBXqyySr0Cm2zAxFXyjaYU44qo?=
 =?us-ascii?Q?hqvtFwaA+b9U0we9MOBuXlBZgJwj6C4XK8SGcnfl0KEWuDn6PgSQ/eu9hErA?=
 =?us-ascii?Q?0XC14TyGwGizIfIsxg966XbJwTvBPDdu/BIoJ3GKb4PgJQrLdjYC2GvCfYEt?=
 =?us-ascii?Q?k3iWE80A3qIVeRUpLa9J0h0+lKXuF18XZnO2UbGNn+DHfhdd4I5uG5ZD2wVz?=
 =?us-ascii?Q?L5UETXbTAlqd69++inuRCnW2qI50gsYeTMIizlV3QTw7lRQBXt1oAgjMbI3h?=
 =?us-ascii?Q?j0jlZ6vbNQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b74b102-d229-4159-72b1-08df147f6140
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 05:49:03.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9Q1ARG2gPhWC2l0bxO19XsIU6oynw3lNc2dI6VSTFuBU8XhZnhPVWOFLFFGKeaJVMkCZSHV4IFBE+v9Ic81KMa01INiBmMgpx8oDVmtH84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1024

> On 26.08.07 19:29, Changhuang Liang wrote:
> Expand the storage of clock parent index for per0 domain, which parent in=
dex
> over 255. So change u8 to u16.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/clk/starfive/clk-starfive-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/starfive/clk-starfive-common.h
> b/drivers/clk/starfive/clk-starfive-common.h
> index fd9d13735896..f80bd51b391d 100644
> --- a/drivers/clk/starfive/clk-starfive-common.h
> +++ b/drivers/clk/starfive/clk-starfive-common.h
> @@ -27,7 +27,7 @@ struct starfive_clk_data {
>  	const char *name;
>  	unsigned long flags;
>  	u32 max;
> -	u8 parents[4];
> +	u16 parents[4];
>  };
>=20
>  #define STARFIVE_GATE(_idx, _name, _flags, _parent)				\

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal
