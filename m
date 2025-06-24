Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6D28BA92;
	Tue, 24 Jun 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763103; cv=fail; b=GN9il7Q81viHE5YiqS6iaDf1x5GnHyoaW8V/CiKTOK0JAQn346lCOMcYzYY2SDjRk1FhOfnEzTACKIDCT/WJ0JsrDvXKcbeMm6JYqBJ3d8DeHNoDMbXt+Z6vt4w83ibyBXaW2m77q9GUB8bnSxGcBlYAvnmg6/Gf9MVWl1Y+P4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763103; c=relaxed/simple;
	bh=fYTbAl3lU/Tb4ePFAZDIFwcOPyINcrrwb10z4s9aC1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUaREBqnrR+elir8UHmVnkD7pLmc40FCjbziGLAWIcfu31rL2Gt4W498Iki+tw6ggkkJgM3C7jat5xEFWsxe7ZHbjXz+muA5/K4UxL+mIhmzSusv/YzHfXtMwErHe9JbXomGe09tX5+CSRApKLuTICBKVabvqYV22trBKC6PoHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=AFtVsLGU; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="AFtVsLGU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7HtKO15vCY+P52y7T/qWmoBxAKYPiT6x6PF4Vijsx16fi10Ws3O+7ZchFRVqf8mrSXWRwIxuG3dDDhFh0iM8nZNLbKLH86Z6ox6pKKxzntweEQkYG2mZM7ozYUo70ZI+IEmqTaKh3XxXJs745JNMPXCsVcFb+yMb1zKoPpTQzxGAa17WEiQddP0FzeXkKtpqwhC32YpNaz9zzoxCMX6EZmXonjf00bf3Whaa1nbPBm0uby22x88DXfcWEYh/ixNWedAVNXsCAZSqBRyMrycUexkrY0mU0cncbpQtWE1h2u/mENvTBF7bkF5Kota1YHYf9XVDeQ1VOKkd2cUPY+4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJf7388UrXdcCAuMQ86R+ByW5qSWKdg8dnSH/P4EbKI=;
 b=T36+PRZRWiP3htvUl2hFf9EY0cocaLdJdVVbmdJAV2w9X5EcofGM4xO14rC7IQXpHe47spr4nchKeWMqHUV4V1f+8XAnqDz7GIFLu3kLX8cZYyVIUSLKVxXSUvI3JIyByh698T2vY/gRjJc/1hjBcQR4eu4fmLJIiHcoBn55/z7SaTWA02UULSX+EncfGTsiLtQqHA1WFuoKIXpdXvUz+nzQ0Q9hIbs7EEsMeb5Wj2tI94CN7Opc8GVdM3ZcxtEUZkWFIvUc++SzSmNRUanRh7+CriEY4Tkz70nI8naOmNchJ5DsGBEKlqzNnj4bAf+7WZ3PGO3ubBcXfoZAhvgoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJf7388UrXdcCAuMQ86R+ByW5qSWKdg8dnSH/P4EbKI=;
 b=AFtVsLGUEOwHO0lTRU30QZO6qQ3wCIJMQy9gZnQh6vbKx8aVacjcd3dOINAa29YEC8pUq2wNqqoKtVIZOa3i+GwNKbQui1IAEQAo3K52UluXZeE6yQ1cYWwsbGvBoc4b4XHBzsiI6BEPLcSCRlHT25XpTpPkD0TdUZf5Bd0ZN/vTZhK/Tk4uJp1iOKyJbCyWBGCIruvlJvzjjVRxGM5zRwL5jyya171tF4AwnCv5HJrjPbV52Bikg4S4ls8lc4j2gVFLGAV3F4Bz6lWX5iB/4x7qMlkVTHbCumKVXv4cAL7yTFCCoZRB/fme0GV/1JP44V+yj3bMqLReI/DGUUg98g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com (2603:10a6:803:66::33)
 by GV1PR03MB10728.eurprd03.prod.outlook.com (2603:10a6:150:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 11:04:54 +0000
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265]) by VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265%5]) with mapi id 15.20.8857.016; Tue, 24 Jun 2025
 11:04:54 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wojciech Dubowik <wojciech.dubowik@mt.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Markus Niebel <Markus.Niebel@tq-group.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Michael Walle <mwalle@kernel.org>,
	Heiko Schocher <hs@denx.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Tim Harvey <tharvey@gateworks.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Andre Przywara <andre.przywara@arm.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Kever Yang <kever.yang@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Tobias Graemer <Tobias.Graemer@mt.com>
Subject: [PATCH v3 3/4] arm64: dts: freescale: Add Mettler-Toledo Snowflake V2 support
Date: Tue, 24 Jun 2025 13:04:01 +0200
Message-ID: <20250624110408.128283-4-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250624110408.128283-1-Wojciech.Dubowik@mt.com>
References: <20250624110408.128283-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::23) To VI1PR03MB3856.eurprd03.prod.outlook.com
 (2603:10a6:803:66::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB3856:EE_|GV1PR03MB10728:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e04ad9-0cd5-4caf-627b-08ddb30ef2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v284ZQTXpAbOxn0H6uV8us8lYTdn1SPRCWjzTOb1hQFQiuY1lCCrQIFWufSG?=
 =?us-ascii?Q?x6adCIulpk2YlU9E62MprDGhmBopPKwi8sgobz9SHaGQrsgbVtLQ1s+uBOQy?=
 =?us-ascii?Q?jX+noc3qN0uhLhekwtfLK9JjrMGS5Jgo8CKDel9H+35D/VT7l8xqTd/QCCsv?=
 =?us-ascii?Q?ui9uEtmU2oy6xTNfu4G/mr6oSmAQbKUNMuXkaXgKfh733PnwCAUzB00GKVZl?=
 =?us-ascii?Q?GXh9cfH7sbyLodHoejH3/4Jj+rWfUtyUUeUWSOh+3MLkamlW34Rxbvu6F7NI?=
 =?us-ascii?Q?IulxMgQ8iLVji0uPB8XM9og1W82COAvd5jlcVNV/hlRDQ1qj7YgoK59x6fL0?=
 =?us-ascii?Q?c884SkphqmJrolPoIAeLISU+uj6PaB9e7nzGYID0fCwMsFF9oadVhMjus6hs?=
 =?us-ascii?Q?TkwzbURSz27BMMSxIOaWSyc3nN7Fm368kyBpneP1LHjUQvNl30TSiw6lkrrt?=
 =?us-ascii?Q?0Uro6lMXQANEMV1TfiwlGyfv8D1qDI+TTMb8cpmmtu8Ls2YGL/ssByeZklpG?=
 =?us-ascii?Q?WiKnHPhRyNAzdVbFRhDjY6yWvZ3RBKUUNa7y3qtHWT3vfPwRXOT84gYFnPiw?=
 =?us-ascii?Q?vN4mWWNoWqsEOl8aETPVA+KSm/0GJVf5koaTeBjT2MWy9xEK3Fql0894pHr+?=
 =?us-ascii?Q?R4lQ8W/MluwcxPWdF7pgw2T4Gk3WjdGNHXoll1BJEu/GqtF+8/nPyRMOo/Nc?=
 =?us-ascii?Q?55z/9j0Syerg0ZBc4WXuN9TIblG92sJu+aAdXaXr0FSf69af2COqipNKDFH/?=
 =?us-ascii?Q?DgZUFAtghyqS3fg16FpStYQ5RrOgHnFcd3s0cnvlY/I232tOS4fjTFVe2++4?=
 =?us-ascii?Q?iCgySblkW+gM0gl/Lr1RUrcY8urrHID/611UERTRwQ5A+ymlVUgHU57+gJaM?=
 =?us-ascii?Q?yEVy0bv8iU6ZtfGkcETMDdvpI7tVVId2tme0/PrQFZMXsmRBf82fbuPY2NcF?=
 =?us-ascii?Q?7ocXClVELr8BV6K4UWG+i7+TbbvAvHpJMZjL8p97ZVbkGis7Jzk20N1NVKpF?=
 =?us-ascii?Q?cSkBvP/1jrTPUy/ylpqtUJvfl7r8/fbF1DF9OYBYoNDikqB1zNBUx071tDEX?=
 =?us-ascii?Q?xbhpZHuUv48K6CaF7nIX/xQl+L38tR/N5YuiMFSlLePrA5JQYZumACq032sF?=
 =?us-ascii?Q?NqbUtmou2Lg7VId00wResUTpHMsxnojn3y9bci815NnVCimcMbV0KK/i17EG?=
 =?us-ascii?Q?Fry6u/6HnaQwkiuwFWD+J0yIhrJtUxt41ZY6n4mHvO1jsThFGtVOLY3SH3M4?=
 =?us-ascii?Q?XBMVWi6c/GZp5dVDy4Kt3nQ9aTn5EKC2wRFSdPutLlKBgZiCVmn0yBSdwJRy?=
 =?us-ascii?Q?c0LNUWHIHmfeDVoN5DsNhZ2a6ruUykXxQ6q7swAkNUq02vSYZQQy+bpkr04t?=
 =?us-ascii?Q?KdlP/IvPeUU2tUOuFpRAmVyiHJntRMajL+chAOKmQdTGxvI1W9pm4WnB8Kwo?=
 =?us-ascii?Q?m6/G9459vR6J32/i0m+8aPC+Mjl6A1BW5dyKbimn6nBYiUa0PBAGmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OX8iQi9yhtRZY0npJivsLG98eueo6y/cKvtFTNMnDi6zhW2iAtO6CIFflBol?=
 =?us-ascii?Q?FOgPfG/GfN3k5i12yMVevrhZxbGm3gixYnjci9V00mWKEkKzimTKY1WyBcxG?=
 =?us-ascii?Q?GgI2/8Jn+BPGqrBCddlcd7Wnsma6ro2CUlBjTKz37SvY913TQHMLtpOnfgZs?=
 =?us-ascii?Q?Ne9Y52UEM4Jx9kusCMlNCoLidWVzsDqp+Xm/t/Q3sKRXsmgBb39Y/aALt1mp?=
 =?us-ascii?Q?LtuTiSpObNOUFzFjU+/kEtIkayjxNZjc6d2irfZy/hucr26ZrB++Sd6UJner?=
 =?us-ascii?Q?WbEdmtkW97P2fLKZy0GF6xLDcgmrBDn7jtDMe8hdEpjtyqk38ZwHMFua2gkg?=
 =?us-ascii?Q?QlCH4Mt08RBo8f6fYW1hFsKpzlYyvbAxK4bR9ALqLv+xrDBzu6AywdKoBTPa?=
 =?us-ascii?Q?V7zp9JONrbzpnWLHBmHJorAkjqySuVg+llw5NsA9IduP6Do0Wmt7Ohduol31?=
 =?us-ascii?Q?9mzG5KCk51XyttUeMpwfsso4RgSDkKGVgAO929k9u/MikT5upADtHNmMzCA6?=
 =?us-ascii?Q?sgAJFh7tv/NxJueF/OCBWYLiBJVWPqxCINaiw9Zxo50pPZl0e23C8riFirLC?=
 =?us-ascii?Q?OQKvoj0f2AFtKoxnBcJEx5E279MLjpbv0lpOqSbRXXfBIQK8cRBoJ+0Xl0WL?=
 =?us-ascii?Q?r5Lw7DfLM/9pkONmbsmHzC+GSdTNZuibMyMboCUl/NxF/FhxSyTVejnies76?=
 =?us-ascii?Q?Yf25V6ogws8TlJ95hBFtR1rF6io48YxCvULakvQ+VkTvj1EXbXnFldvZx8zo?=
 =?us-ascii?Q?zBOof64AqhWdONP9jLGFOIi6R5pq0Q0N6ebk32UaRGkNhTBWlQTegP+kK730?=
 =?us-ascii?Q?4ETdZPSitzisP1xses3KLYqQyGBZC1/UjSNoRh/8Q3L7pWo/h73aYREJKpny?=
 =?us-ascii?Q?7Twz3wsvlumD+KWjov55k1xOvqcK+qZ9PB+VDkyHwvCHNHu8EyN3RTfFbWR/?=
 =?us-ascii?Q?kYi1G0jQe1uhiRZa3lIv6R6eusr4fD7PXQjqAvtFhowvrYsBzUNexa34kczW?=
 =?us-ascii?Q?EF908ksaCqKZUNibuqbVygOjAva7dssdSfoqmLS37vdA7UJRQv31oRO8EkXv?=
 =?us-ascii?Q?N2QxK7wAt8EUZZ4Tm1LeT9ECUWFxEeag2WI0BrR+MDzB37xSUnJy9vHTHphH?=
 =?us-ascii?Q?5jOLeC3dbZ0dxetiSmKQtDXkfkZMZIz/0rEIFttL5/WGMhFJr4Bf0OP4j5W3?=
 =?us-ascii?Q?BGbTsJnltxHnJMMzyBu/B7VMixoP/VxIuQ1RE0M1bog65mRmJzm0uwtvcF4G?=
 =?us-ascii?Q?bMxjwLcIJjaYc0veg6c6LoLOCIDYzDFa2gslimCZFqJp/cd9rEJYhtLtcvUy?=
 =?us-ascii?Q?jRTNp+0Dyl7WK2i47A1tuL37xPQB93aTN3Zvcwm1jUthYajAZ72jYhVa9xDw?=
 =?us-ascii?Q?L40T4SfArH7mYyyXtnB5GzMyppxpD8YbJvFx2tn6FUT/nvwDlUdRJHQrJLmV?=
 =?us-ascii?Q?+lATjv+HGlKbC8vg/0BNUBZWk8HvDVSkKBO5N1MTPgJdXJy2nIvIQFMoiN9s?=
 =?us-ascii?Q?p0cuiQ2qIQt0LKXac6FkSBFpEoQOquXkaFNy/ehHsauaujfcwBZg6quSxy5/?=
 =?us-ascii?Q?6sdQdQg7TQFJRKHCrMvNudIOY/xvKzEg3aI8uw3c?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e04ad9-0cd5-4caf-627b-08ddb30ef2ba
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:04:54.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57Xc8PbspJypeD0PRSaOKACmdIlzODDsGy9YT7GoweUN9q1dkQZWT44Da2MyxFExlsu7o7+i8d0F8pB3sjlQKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10728

Add initial support for Mettler-Toledo Snowflake V2 terminal.
The board is using Kontron SL i.MX 8M Mini SoM with 1GB RAM.

Supported board features:
* 7" Display with touchscreen
* RS-232
* I2S Audio
* SD-card/eMMC
* USB

Signed-off-by: Tobias Graemer <Tobias.Graemer@mt.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-mt-snowflake-v2.dts  | 482 ++++++++++++++++++
 2 files changed, 483 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0b473a23d120..86f2f1580696 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -128,6 +128,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-iot-gateway.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-innocomm-wb15-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl-osm-s.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-mt-snowflake-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-mx8menlo.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phg.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts b/arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts
new file mode 100644
index 000000000000..2bebf528ec37
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Mettler-Toledo GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mm-kontron-sl.dtsi"
+
+/ {
+	model = "Mettler Toledo i.MX8MM Snowflake V2";
+	compatible = "mt,imx8mm-snowflake-v2", "kontron,imx8mm-sl",
+		     "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	aliases {
+		ethernet1 = &usbnet;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000 0>;
+		power-supply = <&reg_5v>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <100>;
+		status = "okay";
+	};
+
+	panel {
+		compatible = "edt,etml0700y5dha";
+		backlight = <&backlight>;
+		power-supply = <&reg_vdd_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
+	};
+
+	max98357a: audio-codec {
+		compatible = "maxim,max98357a";
+		sdmode-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+		status = "okay";
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_sn65dsi83_1v8: regulator-sn65dsi83-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "SN65DSI83_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	sound-max98357a {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "max98357a-audio";
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,widgets =
+			"Speaker", "Speakers";
+		simple-audio-card,routing =
+			"Speakers", "Speaker";
+		status = "okay";
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&max98357a>;
+			clocks = <&clk IMX8MM_CLK_SAI1_ROOT>;
+		};
+	};
+};
+
+&sai1 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clk IMX8MM_CLK_SAI1>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&i2c1 {
+	bootph-all;
+	status = "okay";
+};
+
+&i2c2 {
+	bootph-all;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	eeprom: eeprom@54 {
+		compatible = "atmel,24c08";
+		reg = <0x54>;
+		pagesize = <16>;
+	};
+
+	touchscreen: touchscreen@41 {
+		compatible = "ilitek,ili251x";
+		reg = <0x41>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio3 16 GPIO_ACTIVE_LOW>;
+	};
+
+	lvds: lvds@2c {
+		compatible = "ti,sn65dsi83";
+		reg = <0x2c>;
+		vcc-supply = <&reg_sn65dsi83_1v8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sn65dsi83>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in: endpoint {
+					remote-endpoint = <&mipi_dsi_out>;
+					data-lanes = <1 2>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+					data-lanes = <4 3 2 1>;
+				};
+			};
+		};
+	};
+
+	usbc-cc-controller@61 {
+		compatible = "ti,tusb320";
+		reg = <0x61>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_controller>;
+		interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&mipi_dsi {
+	status = "okay";
+	vddio-supply = <&reg_sn65dsi83_1v8>;
+	assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>,
+			  <&clk IMX8MM_VIDEO_PLL1_OUT>,
+			  <&clk IMX8MM_CLK_DSI_PHY_REF>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
+			  <&clk IMX8MM_VIDEO_PLL1_BYPASS>,
+			  <&clk IMX8MM_CLK_24M>;
+	assigned-clock-rates = <266000000>, <594000000>, <12000000>;
+	samsung,pll-clock-frequency = <12000000>;
+	samsung,burst-clock-frequency = <891000000>;
+	samsung,esc-clock-frequency = <54000000>;
+};
+
+&mipi_dsi_out {
+	remote-endpoint = <&bridge_in>;
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&gpu_2d {
+	status = "okay";
+};
+
+&gpu_3d {
+	status = "okay";
+};
+
+&ecspi1 {
+	status = "disabled";
+};
+
+&gpio1 {
+	bootph-pre-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	bootph-pre-ram;
+	status_led_controller_oe: status-led-controller-hog {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_HIGH>;
+		output-low;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hog_status_led_controller>;
+	};
+};
+
+&pca9450 {
+	bootph-pre-ram;
+	regulators {
+		bootph-pre-ram;
+	};
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_hog>;
+	pinctrl-names = "default";
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19 /* \SOM_RTC_INT */
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x184 /* SOM_DIS_ID0 */
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x184 /* SOM_DIS_ID1 */
+			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x184 /* SOM_DIS_ID2 */
+			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* SOM_PCB_ID0 */
+			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26		0x19 /* SOM_PCB_ID1 */
+			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* SOM_PCBA_ID0 */
+			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19 /* SOM_PCBA_ID1 */
+			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x19 /* \SOM_STATLED_RES */
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19 /* \SOM_HUB_RES */
+			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21		0x19 /* \SOM_SUPPLY_EN */
+			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x1c4 /* \SOM_COM_RES */
+			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x184 /* SOM_DBG_GPIO0 */
+			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x184 /* SOM_DBG_GPIO1 */
+			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x184 /* SOM_DBG_GPIO2 */
+			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1			0x184 /* SOM_DBG_GPIO3 */
+			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x184 /* SOM_AUDIO_SD */
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT		0x6
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x6
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT			0x6
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXFS_SAI1_TX_SYNC		0xd6
+			MX8MM_IOMUXC_SAI1_TXC_SAI1_TX_BCLK		0xd6
+			MX8MM_IOMUXC_SAI1_TXD0_SAI1_TX_DATA0		0xd6
+		>;
+	};
+
+	pinctrl_sn65dsi83: sn65dsi83grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x19 /* \SOM_DSI_INT */
+		>;
+	};
+
+	pinctrl_hog_status_led_controller: statusledcontrollergrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4			0x19
+		>;
+	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19 /* \SOM_TOUCH_RES */
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19 /* \SOM_TOUCH_INT */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
+		>;
+	};
+
+	pinctrl_usbc_controller: usbccontrollergrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* \SOM_USBC_INT */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
+		>;
+	};
+};
+
+&pinctrl_ecspi1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_i2c1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_pmic {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart3 {
+	bootph-all;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_wdog {
+	bootph-pre-ram;
+};
+
+&pwm1 {
+	pinctrl-0 = <&pinctrl_pwm1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-0 = <&pinctrl_pwm2>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&reg_nvcc_sd {
+	regulator-always-on;
+	regulator-boot-on;
+	regulator-min-microvolt = <3300000>;
+};
+
+&uart1 {
+	bootph-all;
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	bootph-all;
+};
+
+&usbotg1 {
+	bootph-pre-ram;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbotg2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+
+	usb@1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbnet: ethernet@1 {
+			compatible = "usb424,9500";
+			reg = <1>;
+			mac-address = [ 00 00 00 00 00 00 ];
+		};
+	};
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	vmmc-supply = <&reg_vdd_3v3>;
+	status = "okay";
+};
+
+&wdog1 {
+	bootph-pre-ram;
+};
-- 
2.47.2

