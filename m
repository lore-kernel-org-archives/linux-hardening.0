Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA74F3ED6;
	Wed, 30 Sep 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772291; cv=fail; b=OhXAnKSjqOI6Zl4+7NCp7UK86nNHOto1anAhZzHmKfjguJZBxsXNcbpD5ERSrfAHfSM27CpQo56BKMlMYCaokRvUljcyqHR087U16DvyXLp2ZtHWA9S2XonbUBIj5pKflXucUzbbfSt5Mu9mDDm7onznWfxP3hjaAEc3zgdNzxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772291; c=relaxed/simple;
	bh=eLrF1AC3prtzFWGW7ynOKtJ4rogvSNW2Y6adXqsDhlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7rT4BtJ+df5GseFjtZ9LuYJFqwnIBd5682MR+nlLexmqhPUi3FGqkqCDG0m00LnDE45MtiMJf3w3i6EHkhISRcTHs4PgweCyrz9twvDW9HRLTPvMyy1A+WXIO/yWguGnue5MZt8FRN0pOqkr6VQJK/hk74QHNTPzbFh7kuGJzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw8NDogKuiY1j5m0J6mYgeGn/rkHpnYkYFzuvg16ScRWmYofxUmNxuB7rVl+RsfCDw7LX6FapyEthQJZR1qd3jeMz1siYgtAs+tf+4p8kucCpHyl4nzYNyFIuOsv4giKiHOWsc/k1QcN7C8mBlZU4qrt/MWqhiY3DQTjXBaJH934o41YeVpMgx5tD5qut9KepidIvwuWy2+3I3OiyvuBwF+nlD1IwCWnNI+IDtzETLFxQIFG3ZUwT6GkXfimriuiP5HlJVZimN3Emwj39a42idWn1mOZYahncMhC2VrFRfWs50Jpz8hZ1PYygo1JBXPCDTXs8RLM35tzb8gKDdv7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bnf0P0blirZxZSghik6KL1CvfwVf4Zeo0Ta50Nhsvbs=;
 b=SkyrPppePel4fmCRKovRr1E5dbIUscWC/2jhFyLJmM7FjMm3mYWNBFo5xsoSID1GY9njzrqromfILe0nNF2GEB8/ZdXAY1HfRcrIfX444t+TMifK28jGqChp/cDoyDfZMTXnrL4a3iy3B5h/VvSlbfacVl1uBfoOcnFGjfwkxLrH9IVT2QvKEKZrD6XBOfc+L3gaCrlhBy0MW7mwEy/CG6LcGjyVi0W4DGQV7dbU23cuZM44BFwC9rZCWtZ4nX+CzteuKGkp9sa4F8mvGo8nXvfAIARD6SdNvLqo33+PeEp0yyiBnJb33wpqeXy/m0vzoD0BzHHbJuLtc5RG1CVF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:44:00 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:44:00 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v5 16/23] clk: starfive: Add StarFive JHB100 Peripheral-1 clock driver
Date: Wed, 30 Sep 2026 05:43:10 -0700
Message-Id: <20260930124317.5648-17-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::18) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: 08df105b-bb18-4d62-f432-08df1ef08068
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	PZwO2X9s/RXuoHTbx+E0yiPo2OWRDFIHKP4Xb7iscozpvs9+F9lCS8FT28bWw4ODmwV14gNd14hhtTgXUPooDZ+Y/G3NG/nPwXheE+LLSeESG+4MoFdx0WMeIiLw3VpZ5JsAUWv3Ujp6JDJqVKx8+e8sXdUgjnQQ8f+gJ1Kthv4q853MqAuUOc5zl1FYNp9Sb1CKAjMat8RWmgwtAIE8ljmIl747lgcegZLL2Hjhn8ATRMsavLpSGxlx5WRUE72RSnlMrkaqVjgQnYvGW7+cUcBiC9Gz/1BOSi5uMm71D3Ya6xo+jCxHEGfQ0UrUt9IHfPVZeNq4yr+kbsabaNMCoLK19rOymXACu3Ga/rgS9Op1oZX65NTulywsdj3e0v1lu9qrZaXKFtWYld80V3Wn7fyImzxr/kRbMfLN8v4d2iM0LG1VRdFJK2GjYiy/t/n8bvBAV359aQmDVu4pCaxiXBdjpsTEdkZ9MWCaM4gdS3HSw+kN8nJizn8fblf6aeT589rny9Q7wcl9TdXq72/a3fkx/F9ZruZJXLq8czt9F3C3qeSN90pmQmALuYL+7CCpLa1qu69cRVgC0One1wgNgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gxNf8kpsFtEg4GL/219w5EliMQCJeiHdLADSPGPF+4kmAHs6E/Dbb+Ww2C0q?=
 =?us-ascii?Q?RdyKAUriPepasfXPvLx5B8En4rtAZqqynwi+FOqJsD2GwFY3PfG6/Pk36DAB?=
 =?us-ascii?Q?sU3vMNeo7aQ+UodDdQQwY6uakvV86hSk4ojYyfzRg0Gh1dkrdDjApe7UemiF?=
 =?us-ascii?Q?hzIa9De1uQE+M6mndCjbOjzLItrBVUs5SQdpVinXqWyEQVmZvugVo2b/OuE8?=
 =?us-ascii?Q?0fUa+C9WOXVhcCJPgcIzWFf2Qm6w7O7dm1mWFPdNKUaay/rtQMQTfyB3ggB0?=
 =?us-ascii?Q?Jz3cdcj/rW4TcfGNnt42cTbD6X1mYw1JlOsnsSPYLSYqxJnxCscYfXM+m85t?=
 =?us-ascii?Q?v04mbw0FhdEn5VK8CivzSQicIfoBlBqM68raQtprY/FK4Ck6ASZmiW8lyNeG?=
 =?us-ascii?Q?2jgujbQeNeJs59U6W194R642ze/wv74BUDZ1bxo69NoFBJbxVZnsCdg9p94+?=
 =?us-ascii?Q?U10sNHVsqRkX9l97C8H2iG62V066IwvT8UVjHRl9I+exRHexylfCDI5AAddZ?=
 =?us-ascii?Q?nTZe13XZZ2fwL2QlxDuYVacURjQgXMJEvtXFBnFh0WT/XEZvjir1aXfNpz40?=
 =?us-ascii?Q?abMb9oBjEg/7hO7sLZHdFIrWqv9c8vIod5Bn50aRqkS/CGeqBawKtOMgDhFd?=
 =?us-ascii?Q?qj60HznSpD8yBCxLmAFABHUXdANQM4Syh/uGh9+wRPq1XBGuVtXJCiYju9YU?=
 =?us-ascii?Q?oaFgzrdynd92G4+UiFhD7u/7QISSl26aVBgjcbjymBBquc/8e8odVxnAJoxW?=
 =?us-ascii?Q?ReIrEDEQvyChzPSYVnu/pKMPLD7/nlv4ctYYFUZ1afASaXFGehjozNZmslrY?=
 =?us-ascii?Q?UHObgzK4b+szA5CGJtk7BBKQ2kWD8hQCcpYpNRW59QNnHubkyxbf1ZXNILou?=
 =?us-ascii?Q?msA02a3UB1d8J2a3GK56bFJJZICrHUy7x8RGlnka5gVQAXHnBXF1U/T58EiH?=
 =?us-ascii?Q?+b48sj9MyCmcPsLO76Qz+496CazUoQ3z082a/zKjOLRvwgyDjlU8+8jpV8yM?=
 =?us-ascii?Q?ot79XX+GAuKUcQt70ItkmiCSoPkbL9FmH/nVrUiFLcSmMvR+awUVkVTq0brc?=
 =?us-ascii?Q?L6dip9/mvbOvZRtBLeWLa9bgysPJwB2dY7rh0J9rWJJhSDNz7wELbdUYakg3?=
 =?us-ascii?Q?TWppOmuoCyNRAFsp/FBCrza+3I71hp1E44Ey97gwedbta7sdA+etIz8MlKb6?=
 =?us-ascii?Q?nry62xlHH/NXxNfavMxpKCnAMPZm0dHNMnqOAAIEXnJOECFlzqV9vi17BsL7?=
 =?us-ascii?Q?IQjNkig1GbGsti/JXo56uJOgWIgRQ8zg4CmMcJVXNBZd+fo4x8X1AlYvnT+2?=
 =?us-ascii?Q?/wd/IQdutTSIBytjkLKtT18rDGE5LzTBCUrQb3318Tg0vlMllgga/2mGfj54?=
 =?us-ascii?Q?HkhhLek1Lhinxqo1FrcpG3L8R2ckLNh1wdzzUMoiLrO+jHK9Aha97RY0BtxQ?=
 =?us-ascii?Q?3nouL+B2nH/uHxIGlR3UcLPftZIprUR9/SAcACkPIbz2bc3IYx09EHD2q9aO?=
 =?us-ascii?Q?RBWsFsAZhYd3xo4RlvU1Rd4rzKkb7ZIWreaHQCsOqOtn+EyKLcmUOcteDlcu?=
 =?us-ascii?Q?+dXE1SvNiLMmAym6uOjqi79FTyx4vCfwGIpZ4Snsqa05XeN088Ouu9uq4Gou?=
 =?us-ascii?Q?+79+mq5sLjorXXJdvfwbgItJt+xK73NqrQUkMmBa1vwgNODN+Gl+jwUJ0LIj?=
 =?us-ascii?Q?ejPVYmqBtI2Hnl+VebmPeoqIBG+wyhzERiXoXpQl7/DMBo6Ob552bUQQje3k?=
 =?us-ascii?Q?h0I7JN//LLOI8ACn0Z30B5knsPI3hpg6GcIwE0ViDi+AEMVRg8T7?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08df105b-bb18-4d62-f432-08df1ef08068
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:44:00.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA6OHd0UDjarnHVCDGXzlp2ZmSRQiVgsOSzT22I0ZZOqNzDN5XifZ16uIaJWCqH1AAEqFF5mQTgF+u34CUxpTtIy+KjsBq+XvVj/TYKBd3qv2rM/R/mArmY8QJBAKqAw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Add driver for the StarFive JHB100 Peripheral-1 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  10 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per1.c   | 149 ++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per1.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index b2a05bbb450f..62727ce3aef3 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -83,6 +83,16 @@ config CLK_STARFIVE_JHB100_PER0
 	  Say yes here to support the peripheral-0 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER1
+	bool "StarFive JHB100 peripheral-1 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select CLK_STARFIVE_JH71X0
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the peripheral-1 clock controller
+	  on the StarFive JHB100 SoC.
+
 config CLK_STARFIVE_JHB100_SYS0
 	bool "StarFive JHB100 system-0 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 352717886295..279e0cdfc99b 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER0)		+= clk-starfive-jhb100-per0.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_PER1)		+= clk-starfive-jhb100-per1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-per1.c b/drivers/clk/starfive/clk-starfive-jhb100-per1.c
new file mode 100644
index 000000000000..82a7255da729
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-per1.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 Peripheral-1 Clock Driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <linux/platform_device.h>
+
+#include "clk-starfive-jh71x0.h"
+
+#define JHB100_PER1CLK_NUM_CLKS			(JHB100_PER1CLK_MAIN_ICG_EN_UFS + 1)
+
+/* external clocks */
+#define JHB100_PER1CLK_PLL7			(JHB100_PER1CLK_NUM_CLKS + 0)
+#define JHB100_PER1CLK_NCNOC_INIT		(JHB100_PER1CLK_NUM_CLKS + 1)
+#define JHB100_PER1CLK_CFG_800			(JHB100_PER1CLK_NUM_CLKS + 2)
+#define JHB100_PER1CLK_NCNOC_TARG		(JHB100_PER1CLK_NUM_CLKS + 3)
+#define JHB100_PER1CLK_CFG_143			(JHB100_PER1CLK_NUM_CLKS + 4)
+
+static const char * const jhb100_per1_ext_clk[] = {
+	"pll7",
+	"ncnoc_init",
+	"cfg_800",
+	"ncnoc_targ",
+	"cfg_143",
+};
+
+static const struct jh71x0_clk_data jhb100_per1crg_clk_data[] = {
+	JH71X0__DIV(JHB100_PER1CLK_100, "per1_100", 8, JHB100_PER1CLK_NCNOC_INIT),
+	JH71X0__DIV(JHB100_PER1CLK_1, "per1_1", 100, JHB100_PER1CLK_100),
+	JH71X0__DIV(JHB100_PER1CLK_200_DIVN0, "200_divn0", 256,
+		    JHB100_PER1CLK_CFG_800),
+	JH71X0__DIV(JHB100_PER1CLK_200_DIVN1, "200_divn1", 256,
+		    JHB100_PER1CLK_CFG_800),
+	JH71X0__DIV(JHB100_PER1CLK_200_DIVN2, "200_divn2", 256,
+		    JHB100_PER1CLK_CFG_800),
+	JH71X0__DIV(JHB100_PER1CLK_200_DIVN3, "200_divn3", 256,
+		    JHB100_PER1CLK_CFG_800),
+	JH71X0__DIV(JHB100_PER1CLK_200_CCLK_DIV, "200_cclk_div", 2046,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_SGPIO0_PCLK, "sgpio0_pclk", CLK_IGNORE_UNUSED,
+		    JHB100_PER1CLK_100),
+	JH71X0_GATE(JHB100_PER1CLK_SGPIO0_DCLK, "sgpio0_dclk", CLK_IGNORE_UNUSED,
+		    JHB100_PER1CLK_100),
+	JH71X0_GATE(JHB100_PER1CLK_SGPIO1_PCLK, "sgpio1_pclk", CLK_IGNORE_UNUSED,
+		    JHB100_PER1CLK_100),
+	JH71X0_GATE(JHB100_PER1CLK_SGPIO1_DCLK, "sgpio1_dclk", CLK_IGNORE_UNUSED,
+		    JHB100_PER1CLK_100),
+	JH71X0_GATE(JHB100_PER1CLK_EMMC0_BCLK, "emmc0_bclk", CLK_IGNORE_UNUSED,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_EMMC0_CCLK, "emmc0_cclk", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_DMAC1_1CH_CORE, "dmac1_1ch_core", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_DMAC1_1CH_ACLK, "dmac1_1ch_aclk", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_DMAC2_1CH_CORE, "dmac2_1ch_core", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_DMAC2_1CH_ACLK, "dmac2_1ch_aclk", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_DMAC3_1CH_CORE, "dmac3_1ch_core", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_DMAC3_1CH_ACLK, "dmac3_1ch_aclk", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_DMAC0_2CH_CORE, "dmac0_2ch_core", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_DMAC0_2CH_ACLK, "dmac0_2ch_aclk", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_REF, "ufs_ref", 75,
+		    JHB100_PER1CLK_PLL7),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_300, "ufs_300", 2,
+		    JHB100_PER1CLK_NCNOC_INIT),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_150, "ufs_150", 12,
+		    JHB100_PER1CLK_NCNOC_INIT),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_400, "ufs_400", 2,
+		    JHB100_PER1CLK_CFG_800),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_75, "ufs_75", 2,
+		    JHB100_PER1CLK_UFS_150),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_37_5, "ufs_37_5", 2,
+		    JHB100_PER1CLK_UFS_75),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_7_5, "ufs_7_5", 10,
+		    JHB100_PER1CLK_UFS_75),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_1_875, "ufs_1_875", 4,
+		    JHB100_PER1CLK_UFS_7_5),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_7_143, "ufs_7_143", 20,
+		    JHB100_PER1CLK_CFG_143),
+	JH71X0__DIV(JHB100_PER1CLK_UFS_3_5715, "ufs_3_5715", 2,
+		    JHB100_PER1CLK_UFS_7_143),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC0, "main_icg_en_sfc0", CLK_IS_CRITICAL,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC1, "main_icg_en_sfc1", CLK_IS_CRITICAL,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC2, "main_icg_en_sfc2", CLK_IS_CRITICAL,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SPI0, "main_icg_en_spi0", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_EMMC0, "main_icg_en_emmc0", 0,
+		    JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SGPIO0, "main_icg_en_sgpio0", 0,
+		    JHB100_PER1CLK_100),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SGPIO1, "main_icg_en_sgpio1", 0,
+		    JHB100_PER1CLK_100),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SENSORS_PERIPH1, "main_icg_en_sensors_periph1", 0,
+		    JHB100_PER1CLK_100),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC0, "main_icg_en_dmac_sfc0",
+		    CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC1, "main_icg_en_dmac_sfc1",
+		    CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC2, "main_icg_en_dmac_sfc2",
+		    CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SPI0, "main_icg_en_dmac_spi0",
+		    CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_RAS, "main_icg_en_ras", 0,
+		    JHB100_PER1CLK_100),
+	JH71X0_GATE(JHB100_PER1CLK_MAIN_ICG_EN_UFS, "main_icg_en_ufs", 0,
+		    JHB100_PER1CLK_100),
+};
+
+static const struct jh71x0_crg_domain_info jhb100_per1crg_info = {
+	.clk_data	= jhb100_per1crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_per1crg_clk_data),
+	.ext_clk	= jhb100_per1_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_per1_ext_clk),
+	.rst_name	= "jhb100-r-per1",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_per1crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-per1crg",
+		.data = &jhb100_per1crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_per1crg_driver = {
+	.probe = jh71x0_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per1",
+		.of_match_table = jhb100_per1crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_per1crg_driver);
-- 
2.25.1

