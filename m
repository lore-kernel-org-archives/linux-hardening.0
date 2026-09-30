Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595454E4304;
	Wed, 30 Sep 2026 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772275; cv=fail; b=CPk/BQdP9Z+8aQaqzy5vO6IFSVQTd60B9jyHEGOwusP83yJrNXysxx2zxt6Q5a4214Td3NHlWXwH2Vz7WwFB7Tn1/1Ao2+B1bTxlnrsK77aBscx/Dmo8hjHZEy8lNXPtgtSv3M27BQKCxUiP3TUa2raPxuWv5kgNhzOedBtveT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772275; c=relaxed/simple;
	bh=UWFO2GCAlZchb8Em9J9WbPsUbQ8g60yKVgj6fGqeOvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZnmQNSBjDB3m5QIuUMAT4apyW0tt5x82rjdcjA14Z0xvCUDM3KtJ5mdOx+Mt/fmK7VqirHiG92MLL7WFV4nWCigSi6jvz4fuXgmbicm7mCIK0q5I74PVCP3RGAKjkruu0NR56xdfxa3of/YdjAwq1EMv4d/97skNHczTT2yls0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/W+YwpVpUoMGMeKb8y6u20ZCU4FpEXQ3u9BYmSjclUN7JPpIWBRu86lBBtJ8CwIW41Y/ldwJVeK/U1al5tGwFeivZpyEpVwuOo5mdFkm0g/6s3c1MBGGAWK86BVcVZjyhD7IcsYP1uR0wmqEaW/cA0cMzmoJ4Xdt+W5KijjsKnMNH5boSGKIn/djfrzeS/lfZsONTR9ZwjmSvwDLiwsPNMPeZcvOduHW5KI+c1sGdpXWCdNS14kmvc+abRiLCFtZfjutGl6tZWwCcVUuu4BU117NfMso2z3Mj41jpOBDQQ10tyZGJ6IMkbvGksrjB/oHkPT2OIF24AdlrcEW9fP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QamVc9ZbOqLc3VvSLxhr9F7a8MHCRcAP/AUwXsV6jy0=;
 b=mlgxnex5bKLJVJ3Qt7+dZytMMB7ibli+m0YNGZPlJyuOJMhMyj9Ldt3jzCSAIB2xxJOxqcrsiGD2dOxrD0C8BlvMHBcbPaFfSgIapRu/4e/1RxlzN5mfdBpvQ+VjC5FIQ67RqC7us6GKaYGnmbpdk7aUxkimXoQR3vVix+h4kdrfHBYvlnyA16cJ8pEbl6A1Ps+ytNXmAFuflPFyCase7aizdx+lUzg+DpzJ8A/dVBbEBbAZ3n8kaLpSFSQ/z2ro+6lP5rAE1fwxP2fyPZPvI+gXvg0Fb7EKvfZoeuTUcMoVL8/PuWrYb3cS32Bav5nNdpEOT7AAvVaV/qRoCxRXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:44:04 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:44:04 +0000
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
Subject: [PATCH v5 18/23] clk: starfive: Add StarFive JHB100 Peripheral-2 clock driver
Date: Wed, 30 Sep 2026 05:43:12 -0700
Message-Id: <20260930124317.5648-19-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b0b88075-df6c-423a-3411-08df1ef0826a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	6lTS+JowyRnvUWu8wAzAvhkmcTTiqwA2z8km1JJ2yPvl/yaYDxUdwd7yJCAj2pRtf+iYxglJUAV6ypbzSAl12C5nIKIgp+wv12iGnN3hj3ZmnfZf3pd4kJH/26bAoI6pJrEmofTph/BpF5dt7Cyn2Ma1xD4Kw0qCQL3Ezp5a2tsV+2KV1PONerUM++acqVSALcOv45gcXC5/wYQQ7eAn6yqy3xUUt4JXTXg4g20qL6o7UPHO7AuoCswsp7tztqDfkj00b7+U5ubiqF3QGkf4vvM7tuxvXdY8npH1zbqcBVEOn3Xhv5wIptPWIAlrEvLLON3ysZ6L7BLkkYj1QWA7ElXXJTJePW3crt+8JEKDoLuXiyLkuk9wkO4BF+c23zCEt3kkytDCSJQueE49vWUAYZ1AlM/nG1pYW9O8J/yvlUgXpW4Dp5RfIakzTAmYhFQOpKNnUCRpNaXiFMuP3qGneuHv0Egi8fWpGEMemiW/8zJ5na8AQG6OsXaTgkzPF1gTmlgUHj22RNNrGCjyY1rhJn7Lso/GhxtwAKWQ2AUrFm24IoNHBsKKzqnNTVCqWeQV4//l0G+dl5L4jTscRwLxwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+LspN3rNHSHLooQHQrHGdL4KxmRaURD+HprgopLl8K02Gd9Dh7HuGas+kE3q?=
 =?us-ascii?Q?1Xeq+j/H5JZr9eAHtbpf9WWt1QE5Z/yNN+qiJCcXtaXdOD1QO4179/+o85P2?=
 =?us-ascii?Q?cKscfgCpeJGRmGvL6xj45ztbivbOVG3RTByvxfB9rwwvrpvyDIp4NK6JEO9E?=
 =?us-ascii?Q?t658hSIrZLdqk/vKq6sNk2mR5oEWEbbMBcqggOyJGnaegPWhgjP91NgTUK4x?=
 =?us-ascii?Q?ssFqVBjfRNxGNh25KxLfprNl3i9oMTKaLcPK04G9OsVU8L/waHvOI0QysapO?=
 =?us-ascii?Q?S02RlDawq1mKnTj6yW6NeCdRm1J8yD+o93vNrSPtPqXau0Dh/W2ErF+VOx0x?=
 =?us-ascii?Q?CjX4rDO3jTc65RAQXzaAJ8em3L8ojD41gsCm14ZmqhHgABoOsHaxzVG5vTNc?=
 =?us-ascii?Q?EtKmuEqAuq0M7LdIKEJdjwwSvIp1aJyIVKWGp9ZmDpKlDNZIswC9LCB9piR5?=
 =?us-ascii?Q?x/2Dxym6tfYBz1MSjXzquLT47bGfFwUlrwa6if9SgkTBkFyAFgj5m6rYEtnn?=
 =?us-ascii?Q?LjTUBBfw1X2CBBkgt/wxmB6M+snHInkdGeTf7YJnmvytYSUw+uSlxiFRzEBv?=
 =?us-ascii?Q?EfzqUlZ5YdNFrOJFP+TvcKdZG33nuQIPtCyaUut2dTt1C4navxC6UZ4HPwEe?=
 =?us-ascii?Q?J6Hfp+zqkkJ2J2u7dhd5vi6LSb0SSAoJHHD5BCVzoZvvG0GOQQ5AvOR1ETKI?=
 =?us-ascii?Q?mneAkqFT/WTbFHFIgHlxM9J00ukm0/qZQ3nquyBBItgrrDABtIhQXx+VR+er?=
 =?us-ascii?Q?Xjqx08BkTy609QsNNIdKt0+61inyIjgOkZvnPdKRirPB3C67uZIgnnqDRNSx?=
 =?us-ascii?Q?LdO72vy017KpC4pcENbJGmokoB/5Aa7EHp4TArBaUGA49LDPNb2XOgK9LEjZ?=
 =?us-ascii?Q?hDa0FTGhBQUY23BhF9IvrmNSfamxybcFNJnj7BNlgywpQDbPevpRRaqxtmXs?=
 =?us-ascii?Q?SFw6I1rWpSlVI2IQZYkjuDrnFa9DePdrEGJ0ApWU2+okLYBMyq+qQ45nJhM0?=
 =?us-ascii?Q?hg0NX1VXJaChbUvz2LEEO+PRAvzlhxl50xtLKRPknfL+e4EzX7981lUYFOX2?=
 =?us-ascii?Q?VmdAu312UVeLnbzZlWE4rNmSrDj+GZboyanTb1BkOH3rYv1xtLNTu9y45BCx?=
 =?us-ascii?Q?MHAEYqWuKQFMp0yPOKYqZ6r5tkeSxh58ixCb7w3Igmw//5fVDD7uUymGa3ug?=
 =?us-ascii?Q?9Jk4jSL4mUGocC8rdNWG9dfS5VjrfMct8p8jc+YRXz5GAWLYHeKu5w9B3qS4?=
 =?us-ascii?Q?3sgj+DVM30bsXmh4uT+WgOAxPJid1VcG6RNfzz573TQ+SSNiwR7W/o7aV9yU?=
 =?us-ascii?Q?6QDBJw8/WhnC7bhIyhtUd7ktO1IiLkx9F4b++AB1U7aV8GDTclrNh6BfOOmE?=
 =?us-ascii?Q?9wMMg/GcF2dSeeaBlw2kHlNG5RulYNLu2mXpIhzHspvY+otxtdShcOOebDiN?=
 =?us-ascii?Q?J2GCYingajNjFQjabkwweniN9aLTaKsKCuN0J3hi2tDwrCLvqjDk0JTig3Xx?=
 =?us-ascii?Q?orcHQD0VsucAM1aTx4MOah5BjX1H+o5qCkYll9oJdefADMS9f9TpyR51B0r8?=
 =?us-ascii?Q?HGEqb8fRgN1tlCVwsrdGP60yOmAkAHlBQgVM8Ie8NsTOjRKQoX+zG4TiCIxZ?=
 =?us-ascii?Q?UXbyGWlgqipilYrGN3aM+qH7vDrI8vW3p3vhh/LHvz6lrguOdgPw7uFNV0Ab?=
 =?us-ascii?Q?hYiZ2Jegnu/K7Y95SodHCB9mq2iW4EVWw5KvILmEbfariDJ38fi4BsY2pYef?=
 =?us-ascii?Q?grEeIEwll5+fszlBCxsY2IWR+Mqu8Mf3+Du9KBhTTfasRdYoHTgG?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b88075-df6c-423a-3411-08df1ef0826a
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:44:04.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFqLAkqGNJCyIVSHBTCgGfXzTYdRMbiludGbbThWEnZG0L/WE9UkrQIX5cF94D9aUxn4ipAlK+PkYWd9Sw8ixS6+zLmO6q5JLQ4xJVrGBGYCN5a4IjnljrPo4jFbWac4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Add driver for the StarFive JHB100 Peripheral-2 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  10 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per2.c   | 174 ++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per2.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 62727ce3aef3..57a3838475e9 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -93,6 +93,16 @@ config CLK_STARFIVE_JHB100_PER1
 	  Say yes here to support the peripheral-1 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER2
+	bool "StarFive JHB100 peripheral-2 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select CLK_STARFIVE_JH71X0
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the peripheral-2 clock controller
+	  on the StarFive JHB100 SoC.
+
 config CLK_STARFIVE_JHB100_SYS0
 	bool "StarFive JHB100 system-0 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 279e0cdfc99b..ca9347d38023 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER0)		+= clk-starfive-jhb100-per0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER1)		+= clk-starfive-jhb100-per1.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_PER2)		+= clk-starfive-jhb100-per2.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-per2.c b/drivers/clk/starfive/clk-starfive-jhb100-per2.c
new file mode 100644
index 000000000000..7c4af95a3fc9
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-per2.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 Peripheral-2 Clock Driver
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
+#define JHB100_PER2CLK_NUM_CLKS			(JHB100_PER2CLK_MAIN_ICG_EN_GMAC3 + 1)
+
+/* external clocks */
+#define JHB100_PER2CLK_NCNOC_INIT		(JHB100_PER2CLK_NUM_CLKS + 0)
+#define JHB100_PER2CLK_CFG_400			(JHB100_PER2CLK_NUM_CLKS + 1)
+#define JHB100_PER2CLK_CFG_125			(JHB100_PER2CLK_NUM_CLKS + 2)
+#define JHB100_PER2CLK_GMAC2_RGMII_RX		(JHB100_PER2CLK_NUM_CLKS + 3)
+#define JHB100_PER2CLK_GMAC2_RMII_REF		(JHB100_PER2CLK_NUM_CLKS + 4)
+#define JHB100_PER2CLK_GMAC3_SGMII_TX		(JHB100_PER2CLK_NUM_CLKS + 5)
+#define JHB100_PER2CLK_GMAC3_SGMII_RX		(JHB100_PER2CLK_NUM_CLKS + 6)
+#define JHB100_PER2CLK_OSC			(JHB100_PER2CLK_NUM_CLKS + 7)
+
+static const char * const jhb100_per2_ext_clk[] = {
+	"ncnoc_init",
+	"cfg_400",
+	"cfg_125",
+	"gmac2_rgmii_rx",
+	"gmac2_rmii_ref",
+	"gmac3_sgmii_tx",
+	"gmac3_sgmii_rx",
+	"osc",
+};
+
+static const struct jh71x0_clk_data jhb100_per2crg_clk_data[] = {
+	JH71X0__DIV(JHB100_PER2CLK_300, "per2_300", 2,
+		    JHB100_PER2CLK_NCNOC_INIT),
+	JH71X0__DIV(JHB100_PER2CLK_100, "per2_100", 4,
+		    JHB100_PER2CLK_CFG_400),
+	JH71X0__DIV(JHB100_PER2CLK_50, "per2_50", 2,
+		    JHB100_PER2CLK_100),
+	JH71X0__DIV(JHB100_PER2CLK_GMAC2_RMII_50, "gmac2_rmii_50", 2,
+		    JHB100_PER2CLK_100),
+	JH71X0__DIV(JHB100_PER2CLK_CAN0_CORE_DIV, "can0_core_div", 20,
+		    JHB100_PER2CLK_CFG_400),
+	JH71X0__DIV(JHB100_PER2CLK_CAN1_CORE_DIV, "can1_core_div", 20,
+		    JHB100_PER2CLK_CFG_400),
+	JH71X0__DIV(JHB100_PER2CLK_CAN0_TIMER, "can0_timer", 100,
+		    JHB100_PER2CLK_100),
+	JH71X0__DIV(JHB100_PER2CLK_CAN1_TIMER, "can1_timer", 100,
+		    JHB100_PER2CLK_100),
+	JH71X0__DIV(JHB100_PER2CLK_RTC_CORE_DIV, "rtc_core_div", 763,
+		    JHB100_PER2CLK_OSC),
+	JH71X0__MUX(JHB100_PER2CLK_GMAC2_RMII_MUX_DLY, "gmac2_rmii_mux_dly", 0, 2,
+		    JHB100_PER2CLK_GMAC2_RMII_REF,
+		    JHB100_PER2CLK_GMAC2_RMII_50),
+	JH71X0__DIV(JHB100_PER2CLK_GMAC2_RMII_DIV, "gmac2_rmii_div", 20,
+		    JHB100_PER2CLK_GMAC2_RMII_MUX_DLY),
+	JH71X0__MUX(JHB100_PER2CLK_GMAC2_RGMII_125_MUX, "gmac2_rgmii_125_mux", 0, 2,
+		    JHB100_PER2CLK_GMAC2_RGMII_RX,
+		    JHB100_PER2CLK_CFG_125),
+	JH71X0__DIV(JHB100_PER2CLK_GMAC2_RGMII_DIV, "gmac2_rgmii_div", 50,
+		    JHB100_PER2CLK_CFG_125),
+	JH71X0__MUX(JHB100_PER2CLK_GMAC2_TX_MUX, "gmac2_tx_mux", 0, 2,
+		    JHB100_PER2CLK_GMAC2_RMII_DIV,
+		    JHB100_PER2CLK_GMAC2_RGMII_DIV),
+	JH71X0__INV(JHB100_PER2CLK_GMAC2_TX_180_BUF, "gmac2_tx_180_buf",
+		    JHB100_PER2CLK_GMAC2_TX_MUX),
+	JH71X0__MUX(JHB100_PER2CLK_GMAC2_RX_MUX_DLY, "gmac2_rx_mux_dly", 0, 2,
+		    JHB100_PER2CLK_GMAC2_RMII_DIV,
+		    JHB100_PER2CLK_GMAC2_RGMII_125_MUX),
+	JH71X0__INV(JHB100_PER2CLK_GMAC2_RX_180_BUF, "gmac2_rx_180_buf",
+		    JHB100_PER2CLK_GMAC2_RX_MUX_DLY),
+	JH71X0__MUX(JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY, "gmac2_txck_mux_dly", 0, 2,
+		    JHB100_PER2CLK_GMAC2_RMII_50,
+		    JHB100_PER2CLK_GMAC2_TX_MUX),
+	JH71X0__MUX(JHB100_PER2CLK_GMAC3_TX_125_MUX, "gmac3_tx_125_mux", 0, 2,
+		    JHB100_PER2CLK_GMAC3_SGMII_TX,
+		    JHB100_PER2CLK_CFG_125),
+	JH71X0__MUX(JHB100_PER2CLK_GMAC3_RX_125_MUX, "gmac3_rx_125_mux", 0, 2,
+		    JHB100_PER2CLK_GMAC3_SGMII_RX,
+		    JHB100_PER2CLK_CFG_125),
+	JH71X0__DIV(JHB100_PER2CLK_GMAC3_TX_DIV, "gmac3_tx_div", 50,
+		    JHB100_PER2CLK_GMAC3_TX_125_MUX),
+	JH71X0__DIV(JHB100_PER2CLK_GMAC3_RX_DIV, "gmac3_rx_div", 50,
+		    JHB100_PER2CLK_GMAC3_RX_125_MUX),
+	JH71X0_GATE(JHB100_PER2CLK_SENSORS_PERIPH2, "sensors_periph2", 0,
+		    JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_FAN_TACH_PCLK, "fan_tach_pclk", 0,
+		    JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_I, "ether0_rmiiandrgmii_tx_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_TX_MUX),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_I, "ether0_rmiiandrgmii_rx_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RX_MUX_DLY),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_180_I, "ether0_rmiiandrgmii_tx_180_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_TX_180_BUF),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_180_I, "ether0_rmiiandrgmii_rx_180_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RX_180_BUF),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_PTP_REF_I, "ether0_rmiiandrgmii_ptp_ref_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_50),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RMII_I, "ether0_rmiiandrgmii_rmii_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RMII_MUX_DLY),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_CSR_I, "ether0_rmiiandrgmii_csr_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_ACLK_I, "ether0_rmiiandrgmii_aclk_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_300),
+	JH71X0_GATE(JHB100_PER2CLK_RMIIANDRGMII_IOMUX_GMAC2_TXCK, "rmiiandrgmii_iomux_gmac2_txck",
+		    CLK_IS_CRITICAL, JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER1_SGMII_TX_I, "ether1_sgmii_tx_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_TX_DIV),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER1_SGMII_RX_I, "ether1_sgmii_rx_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_RX_DIV),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER1_SGMII_TX_125_I, "ether1_sgmii_tx_125_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_TX_125_MUX),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER1_SGMII_RX_125_I, "ether1_sgmii_rx_125_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_RX_125_MUX),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER1_SGMII_PTP_REF_I, "ether1_sgmii_ptp_ref_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_50),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER1_SGMII_CSR_I, "ether1_sgmii_csr_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER1_SGMII_ACLK_I, "ether1_sgmii_aclk_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_300),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER1_SGMII_PHY_PCLK_I, "ether1_sgmii_phy_pclk_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_ETHER1_SGMII_REF_25_I, "ether1_sgmii_ref_25_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER2CLK_OSC),
+	JH71X0_GATE(JHB100_PER2CLK_MAIN_ICG_EN_CAN0, "main_icg_en_can0", 0,
+		    JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_MAIN_ICG_EN_CAN1, "main_icg_en_can1", 0,
+		    JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_MAIN_ICG_EN_DMAC_8CH, "main_icg_en_dmac_8ch", 0,
+		    JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_MAIN_ICG_EN_RTC_SCAN, "main_icg_en_rtc_scan", CLK_IS_CRITICAL,
+		    JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_MAIN_ICG_EN_ADC0, "main_icg_en_adc0", 0,
+		    JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_MAIN_ICG_EN_ADC1, "main_icg_en_adc1", 0,
+		    JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_MAIN_ICG_EN_GMAC2, "main_icg_en_gmac2", 0,
+		    JHB100_PER2CLK_100),
+	JH71X0_GATE(JHB100_PER2CLK_MAIN_ICG_EN_GMAC3, "main_icg_en_gmac3", 0,
+		    JHB100_PER2CLK_100),
+};
+
+static const struct jh71x0_crg_domain_info jhb100_per2crg_info = {
+	.clk_data	= jhb100_per2crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_per2crg_clk_data),
+	.ext_clk	= jhb100_per2_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_per2_ext_clk),
+	.rst_name	= "jhb100-r-per2",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_per2crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-per2crg",
+		.data = &jhb100_per2crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_per2crg_driver = {
+	.probe = jh71x0_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per2",
+		.of_match_table = jhb100_per2crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_per2crg_driver);
-- 
2.25.1

