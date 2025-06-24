Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C532868BD;
	Tue, 24 Jun 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763097; cv=fail; b=idmcMKQNOvUMiiU8vKyg8mmV4aYzJhScuYLtSFTNw1wo8ss3RGvnKExyuD4Gb+GYsOQFrufW+JNIDG42YA9fWCZfrXd5rCq1nssE6K1CBqUG7Guf8SKuV1dAcbGNR8B/slvpwp8BjxcgTrQDmWH4eTripgLUf0Ol+OCcGbh0o/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763097; c=relaxed/simple;
	bh=lMMv1gEUZTqbp7KjQ3ffYb0PWpOdbOMMuV+FgzDmGrg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=icZMboPD33JrK7kRqRiXSeXlQQeiaPItkgn0oMMNtoIfcbIKSvi0zoz/XtJxvc/GLemgx2LVzpuUeLKzAF/4KDBJF7RR077fuDymwL+Yo9jEpj56N/lPtHHYWHy3yqELv5EpHmToulV9RRe+1sGAOoqZt+WGz+yn2FlP6TZySZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=Iz8QDTYs; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="Iz8QDTYs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnEjAyr194NcFl/WFAwH5W5RN6IH4apOTCPxF8cKSf/vnx/Da3J3vhKiJ28ztSW/QziEFaJKMF0DaGAG6JkI1FwVQ7jVTX6toJummJZVs9cNHHLHjugbFFglj5qSVPlD0b0SMjYT32NZb3KFWDXeaTbRg0S+Zlh3f1vMYypMRzBEVCZYB9wknkguENECkJTzQxfzVwu149EhFQObWZjS+ZJw06+cj6a+jrSEJYtWjHX8jArdNExuNBsZKjyOo/OMfIjG7O2hRNgKJjSxWlgYN53vghVQoIiu2qbfG7LqdI4lFyWjh9+AYz5H8bQXcTwA90gzYrUL4BmaiMag607Dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoT5YNGQ/JkzWfCB+CF+raKTLgx3XFq6uog751OCn5A=;
 b=aN2tD3B3kAh0MrlWpkwjyB70x17IE+bmmNNI2zsshrQVviPhO828dKYnRTolTMS0BxBCsjUylYmFd0AcomtuuC0dmsDaetCWRf7mnShOfMkdrdTSYMhqBNxc15tX3zu0JBAcc7pCL42iAZER93c+jI8kGt4FzEORTEQ8KUDgWfHL6lYZuv0MY8FXKPEQHAuCGvsmfWlfY7RdB+HwCvqA3TA7Bgn6ZRS/BDXsgFBZy15bZ44raSUbiZnmF+hUZyYezfCMvAdPGt4hSdqFSRWorgJI/4T7UqOJia2Jc723H1q6ja7yptD36faBndGw/myDOE0YOF4FIe4241dwvgQOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoT5YNGQ/JkzWfCB+CF+raKTLgx3XFq6uog751OCn5A=;
 b=Iz8QDTYscc4Nyhx/mBD87TIIfngbnzCfx7Ar+MjR37UDhTeNSHBj2AXys+AjWjue88pHM3rikfHziq911hcEIZjoKa57fjuZJrwnEToyb+yI62dKGYdkAPNtswb583tiWPftB/QPrmkif8uoqpYsz5lOacIB4rnIQe5G+GMMx2pXi3y9PPNN6SJc0+fc4HAz7m0cjVt8CMClrxmuwgxD4KNWW0qkscqkh2Jz8rkkL8u5ZVN3gkItfJEOX/gIcJ7HVVlSKXsl1+t1QrKMkdbfZ3442t/tMAwkq0P+ND7/zKmZ4xNEcg/bY0tVWcWHAMUKqFdcpMxAfPlJ77QrzpC6Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com (2603:10a6:803:66::33)
 by GV1PR03MB10728.eurprd03.prod.outlook.com (2603:10a6:150:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 11:04:52 +0000
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265]) by VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265%5]) with mapi id 15.20.8857.016; Tue, 24 Jun 2025
 11:04:51 +0000
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
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/4] Support i.MX8MM Mettler Toledo Snowflake board
Date: Tue, 24 Jun 2025 13:03:58 +0200
Message-ID: <20250624110408.128283-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::13) To VI1PR03MB3856.eurprd03.prod.outlook.com
 (2603:10a6:803:66::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB3856:EE_|GV1PR03MB10728:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb69cc5-87b2-4d8c-e8bd-08ddb30ef149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5CW1v8+VL6AvEjA5a56rTZTmtrmf7bx6DpHYMcR6qffMEzIbXTBJWDiKqzZm?=
 =?us-ascii?Q?GSMIWw4ymvX7T2tIHuEB0TW1ajaY/QH3aoqT7R/lkTwEqU1s54XNX+IRxzTV?=
 =?us-ascii?Q?bUt0n+lzg0SAvxAt27uIDgenS0GNK973nZmJZCfWK80asugP6k7DInU6r2HI?=
 =?us-ascii?Q?PzQmDDUvLHvXZf9LlBQdhD+C5KylPoLbYXTIvC3R525PIhU/nFmcnUHPC1IP?=
 =?us-ascii?Q?mvpesZF+KRmPLXxeQ+bKdRQ32FDtQYP2/Do8HIXvxaHf6AKw2Bk1fTsgbWwE?=
 =?us-ascii?Q?T1H0pEDuFY3t9wb0tWGx9Jkk9IOc2lt8H+MP5kncTD2pdUZCT6m5FPvxeL41?=
 =?us-ascii?Q?qTGClZbM6FvxqkNDUU52cej5fn9tzreSlQ3evAdl7M2u3H9hX00bo9Kgw7gG?=
 =?us-ascii?Q?KUzHHxcpsi8VKHu99aJsOUnSTvX2jpy88QEiCZuY4IUgylqkCZ9AAK1d3ruk?=
 =?us-ascii?Q?S2D8c/f8xfnD2Ckc6yTIL0hwCi53L96hzswdjN9EKK7F/rfI6HTxjUxpkU40?=
 =?us-ascii?Q?oa434rWOPI9SL12uf/Ztr4GfZlmMs3uGj/fg/I2jvrK51gZuMQyr2TEMIMYl?=
 =?us-ascii?Q?4QGWMG0/kgwBp8d9i57Se/VuyULno/v6JlJchOooXlrIlCo4sWvUckCzpXe+?=
 =?us-ascii?Q?ooGKw8pRQCXnJ7ubhZAPxPMVoq0HHZaX5kQeIdOK159p88adkgRvQExIG0EO?=
 =?us-ascii?Q?F6wj16elnsyqc/SnaBjfrD3RRdy9MSz3wCacuTgjaAce/CNQUcJ9u1A7N5d0?=
 =?us-ascii?Q?AT9Y3LjMbtr9sPT4KNKZajLJHW4Xs7+UJg9c4l1idIW0cJRkrg0tPsO36zUw?=
 =?us-ascii?Q?d5zwMI7RvYykXWYjMVgw3rAfWamN95OA3loWAUkUpl/qBA6OXM82wujIx4d2?=
 =?us-ascii?Q?3WspFXAfJhcDrQrPp88KLzdQZ8iQwBvY7BQuC6URfS7xUSGM/DHPs7EaUv5c?=
 =?us-ascii?Q?ViS/LqTLyqHoVJO5ktzLneT1i12oSCfHgdni/4kPGXdCq0PAZjLXxSiVv/fz?=
 =?us-ascii?Q?ml97MyFjHa5U9sureCM0wpqzaRubzolNxAulngI1rYrPX7BTmRwHyHdkxhCh?=
 =?us-ascii?Q?55enBwMtRNshj5mj0KHkx/RAjSftMUN91+38YgaW4F9/jNAwNCaoCZkooW5Y?=
 =?us-ascii?Q?Z64f0bPV8YIeEKmGhcgdg+nNHW7DChfs5CFnIIXh2KR6HU3bRL9DYrDgCXzm?=
 =?us-ascii?Q?0dSXCVozc9/qN7IcchQo+WzdEZotThAPFdtUnVl37sUWr6mwpTIs3TckUAyY?=
 =?us-ascii?Q?kFErjbiYho2mcuKLmxyHNPnrAZ2bBdJTtb42KhbEWm9NVEDFaBnz79JTDvuh?=
 =?us-ascii?Q?+USbmEl4S2NqaSCJs2yBkY0epePZqQwpdwW2a0cOpAd/OlJ+XKV/GUFjaeao?=
 =?us-ascii?Q?x4M5CzzOnG1fKHxyoJzVokeDl9rL48i1d/O4eJlzfaExHIJ03RSDwWlU0Iaw?=
 =?us-ascii?Q?qL6WOTBeq7cO3fcvYeJxnUXjFYZZbVedSzoUAKCvBtJiilM8lMQ+vA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5sPArDe0Rs5z5zeeNGi5ynGvR2++HHm3k4YZoSgr/rWxjIiZMZ/3ePUFs3p4?=
 =?us-ascii?Q?THzH+BTVmIo/v00mXdZB4dKJkBHFlwDj8HXIeLC5eR7O+RG7cJuTW0UjA8Mx?=
 =?us-ascii?Q?JjHV94/Qn4i//bPTKy9kRN+D27cr96OXgMF7QtMMRTG2kHsOmZEzOoX9T78h?=
 =?us-ascii?Q?Q6vXmYdLPMOpJY6Zg3UWFEvxir3aXp9tQpaoDuPn7bLbo4bEG7OBn3x6fM81?=
 =?us-ascii?Q?txQsNsvDDPBFTwysRewfZhuJ/35Bja6qgWqko2rXp1iWhPlB/IPd+ykBDivg?=
 =?us-ascii?Q?hL4EzM+Hucmp2UkoCuYbKYfKzecMGCwIxM9mHAxN9KROdz357i23toi7ek0z?=
 =?us-ascii?Q?SJshQDBJZQem6pu9erTMliAN+ua4ALsOQp/LwnPHyLjJRF7iDWuBAR+4zQf3?=
 =?us-ascii?Q?++h8zQiZjkorWTGFmBgwdPzlIS+C6YNLE80kFf1oNUF+PoAQy8z2a0KWpUvB?=
 =?us-ascii?Q?0uXv0nwgk8mZqj9aGtmG2LcfGJfwWflYehzq15I602FGujzn3LM0k+/uIZey?=
 =?us-ascii?Q?cvrH/+0bBwTHzLdx6BcfuTiX8ElsJ0ro9JGSo4RxbOr61PXIc0HadTl2ad2t?=
 =?us-ascii?Q?1U0Cx2/C43LWFREnXak1Wizg232OsEyAJj92sBT+ISxlOuufDHum0MAydx9P?=
 =?us-ascii?Q?bGU3w/ST7CjBtZ4dgrb07cbTxFEidFES8howsWUs2mKLnB1p4Hjt4FghvdiN?=
 =?us-ascii?Q?p/C5zWzvUcSyvBLQxwXsXk1JuSkP1xz2jhyV7CXFesT6/9YlIZqaGVFXwgDE?=
 =?us-ascii?Q?QtjvwEsTiFy8Lhh7rn2x1KsFv7uAil+QYzIZxDQTdd2iFfKcVBDlPPbYsE0r?=
 =?us-ascii?Q?L6vdxkytM7++6F0Msz72n8Hr33eSFG6BMkqQOdGgbvQvqDqhqjF+Mf1ChWCz?=
 =?us-ascii?Q?OYijFvrLMdBKN/6rlT6G95u7g7weEYVgAnpssWjZx0oz0FmNYXzTnMtmhTJX?=
 =?us-ascii?Q?mw9V84Qmj1nspl/GWsJp4witwVEY7nuG95FzhxukRyP7abfCQsmz4W5BX3BC?=
 =?us-ascii?Q?KFjThQSyKdnmHckw4eIbEKA1kL7kBbKvKAmQ6qu57wkylVxvy1I7vQ+Zm+3Y?=
 =?us-ascii?Q?Wvl6dCoeBQc/gmfHPBaYpggY/5GR/Xs6h4dVnSrfi4hwo4eQv3XLnIyCb003?=
 =?us-ascii?Q?GWkrnsxzVoHfTERzU7LvCTi/fuqziULZxyWnSbUv+JDWMM315LSM2woLmP1B?=
 =?us-ascii?Q?ckxRge08+LO1GP8oNtel8qZ3gtk0Mp37W5tlN1JxV+8Iood76FflE6hioQl7?=
 =?us-ascii?Q?vjfhtlHeWCda03cjI0nhTwwk87h0Kb5P8SvjfTEmLAUtmmgn+du7IaMnVDYb?=
 =?us-ascii?Q?QGipnv19J9pOeCknroARewU3ujVsUUbY4Df0P7Htn8U/kO6NQSaiYELe2kCB?=
 =?us-ascii?Q?pqBNXWdioHxriOLwW/7VSlrdhDcCR1lQ7t1psjf28Tj+XYKaYxVyOZC7SMd8?=
 =?us-ascii?Q?qgi8scotTuTgLjC5zT410nW8K+clO7ZFN+N1Fn5cfT4BsmlLSRVMOPb4ml0q?=
 =?us-ascii?Q?RMaLFd+sR3PAhRNU/BOEf9IdQzU8v4PaGsItmYVlIdY7jQbb6Z8vNQLrNK6Z?=
 =?us-ascii?Q?OkEi+3CBnxgXb+mayFZczP7IX36oQN0MjQWEwiGP?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb69cc5-87b2-4d8c-e8bd-08ddb30ef149
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:04:51.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq5dEPTJXJdIA+QKUrWcQO5EEP5j/Oh/NDbOR+824Z14/6poasR9fQ4gV3z7MzfVcHCIGvAlfTd7p8bGUWnRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10728

Add initial support for Mettler-Toledo Snowflake V2 terminal.
The board is using Kontron SL i.MX 8M Mini SoM with 1GB RAM.
   
Supported board features:
* 7" Display with touchscreen
* RS-232
* I2S Audio
* SD-card/eMMC
* USB

Changes in v3:
- cleanup labels
- remove unneeded status entry

Changes in v2:
- In imx8mm-mt-snowflake-v2:
  - Reformat with dt-format as suggested by Frank Li
- Separate patch for dt-bindings
- Add bindings for Mettler-Toledo vendor prefix
- Add me as a maintainer for MT device tree files

Wojciech Dubowik (4):
  dt-bindings: vendor-prefixes: Add Mettler-Toledo
  dt-bindings: arm: fsl: Add Mettler-Toledo Snowflake V2 board
  arm64: dts: freescale: Add Mettler-Toledo Snowflake V2 support
  MAINTAINERS: Add entry for METTLER TOLEDO BOARD SUPPORT

 .../devicetree/bindings/arm/fsl.yaml          |   6 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   5 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-mt-snowflake-v2.dts  | 482 ++++++++++++++++++
 5 files changed, 494 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts

-- 
2.47.2

