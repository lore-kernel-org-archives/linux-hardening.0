Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928542C518;
	Sun, 20 Sep 2026 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905686; cv=fail; b=uF/lijNO1KwmPbxv7oj629ERJulCNafc0tBUODvOVIfvijGe/Hd3lLmhMobur7XE7zG9XXP/1GmZJNsMeuirqXQ1VPwZVPMDjiC/jGixJswEU/88QsRnMJ2kSQbD3zSu2/rPpbsoA4VZrev55JJxarrlXuUrPjvpSjwYLe9kios=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905686; c=relaxed/simple;
	bh=4c2tguKbN72+Kui35+0qgYScuBnV8S1QImjxFyUsELo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l2/ZsFTQx9ePBw5qqSZrN9scKX8QMDpUdkIaYjUtYsWgoiyrQ9246REkaqCr24LK/q5ifNisMFzjhPZb3xfM5JawV+5JAVrCLgjsqKMZO5GByORTIGA8FFz+SYk3X2Oz7OlNCskPGUlvujMLMzdN9mSJ8gr+EnUru4u9dywfNkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEcDf6BWrZoVnQDCnaO18zfQOfcv30vZbsq03WtZuAgOsBvVhg5piRidxzQXZkDdikkaySv9r7XJCX4Np9PfkpcoFV/Auqe/woOUXdr0XaNaAjJeYzWIVocWkIThizk5btMcggUSh1jX9mbAXDKlTPVwVPzwzZlyggJgavPT1O67fUwBRHeGcSIbcqfgqA3hZC2alU7LZ+BxPLJziXUXSPOl9ACqkbkLsZCMYgw/Y56MXOsx+PrHKXv6hHLKLPKi9vs0J+emJlpVhcNgDhBf0nl1fdw5XDJt3bF2ZsJzGR1GcrMdX4TLcwgIQ6cGN4j8hAQtuS66AC9nI6YibkYt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3Ddowv8uBqIH7UJ0zjPT1sATUe53KR2IPjXJujLF3M=;
 b=Vbl7lOp6FumyFZMwineSa0Sm1KTUQnfheG0rSSMJsBYPTltZSEEMkupO8ljWW3DnMDtwaFKxWmil2H1SF8P8F5bEluoxzH7I1OAODA56fx1ok5r9DNDW+uvDS6qzRFY1zp8my6oCUcx3+D7wR5VUxaAFnLVf5JQClnHGhxvTHT6ZnIv8D+AInCeWdr6ABjwfAO9VDhBzcSq4sKSoCTzQZT4hVMRbUrigC0WosK8noCGSDjUgh2op+2d4FLo/tT5/o4EJyejZ22OSTvEv7m8WoDdM6Q4RowNHLy24nrAodpbPX+i4lTXCoqBh5BWLX5F2bY+8rsH8aEmP4VELB/dIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 12:01:09 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:09 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: [PATCH v4 18/22] clk: starfive: Add StarFive JHB100 Peripheral-2 clock driver
Date: Sun, 20 Sep 2026 05:00:40 -0700
Message-Id: <20260920120044.194901-19-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
References: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::34) To NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1040:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f41698a-21df-4cc3-761d-08df170edbf1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|23010399003|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	86iORe3EMjN6Qxfn5zwkTpkZmffGPnH+FMOk5KB6M6pYi/UaU6aWsOdrJDiiRpaj8t4eYOiDnSNGTkm6I89YBu/BU5cIACXl9j6Vhzk0FxJkqVFr+59eKF6Fqb4V2UeAzmV8hRqmOkH6wp9olMrPnBXBM9FaUOlrwCx93dSO6KU4reHMbFJYQGHl6Bbdn2eau1dHfID1EvGDLIJiZSNO8UnY96N/MgKqH6TtxvhgEk4lInadYV0z2i4THmJLwueAYuwngR91VfzlQUrsJn4dtHJFsZs6EhnVPPvJAOy/Q+i92cM0EIFVoW4la3+LOK3c95HVpFJToK4jZDE7nscrAUxnxgY1iTQkrPUrKkxkqKv1vN3Nyw2QTHPbYPsn5BAOcgA5R3HL56IZrUcdSG8K7s6CSnL2d7xuDpH4j86eQtCVUS1V7nhqXh4jJhAslvyV5W7Et/LaN0zadUNSLLsPoqV5/F5kWldty0bbsop4Bkv0+ozSKoDxfwONh7+DB7H+NN27XIeMNmgMUBjZt6zizwC6LAbDGLQwimRrTmpefbwBvGXGDvECln3qVualGD+vhdyVdRF4+WZ2a73jtmNdYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?30anrHwiq3KEVlcbbwdB0UFNob2vkvaClnlTyepfuqSuBlhpfytf36OdlqDs?=
 =?us-ascii?Q?i96IJX66DM6f7HYG0gHfGw/Wduldq3jTrc8Kfb+5r4/7DM519tWnHB7gZ4U/?=
 =?us-ascii?Q?aCof12uEwB7DwWqt9V1fT8zFj6+zKsMp8XkNZpoKSxpcrQYK82zqQPd0I/nR?=
 =?us-ascii?Q?mDvtG+lrmxtjrmDzjo1Ksz9/+RvrHR8FQCRSpFlIYx3X4TaGCSWhLSm+1CCj?=
 =?us-ascii?Q?dPYfR6vaoemtqkeFS61HOtF3FyF4YN7vzDJZmJHRdquNj0CSMAdcIH0z5Kdr?=
 =?us-ascii?Q?ldZ5tOs4np8KY2SkybTWb3E/mdBjtipmDDkIN+ItYmOy7m1w8NWXEwkZoRWk?=
 =?us-ascii?Q?YzkTzflZ710BGM9GbUK+jaDXnT03Mcx68NsCYYTI8LotAk1PphTIrNquIow1?=
 =?us-ascii?Q?Q5cB/1gL4l3sM7I+6QVJuujX5rBB/FQ6GHrmiZ58dWzAx6tGHMrpM2IzuJkT?=
 =?us-ascii?Q?jhpzXEPrIzwjvh59v83y3RfSH8ze8Y6Vzqle8II4YrXZ7CX8DhM077xVuyTL?=
 =?us-ascii?Q?kxm8hNHt1iMdav9pyyIz2RsQwoZXGR5hUBU2pu5VFhRt8Q8mNWXaKUwFJ7Gl?=
 =?us-ascii?Q?GOOBiqkWh6F3aIkvPGkg5j+pw/AD+EiJGHe6/zaMOaCFx7zSsoSjfxqdoiEn?=
 =?us-ascii?Q?b5PCggQUZc5vITb/9RtoD9qTMmnhO3hnc7WdH++jaAkyyj3KxYkSeDVCkesA?=
 =?us-ascii?Q?o566hHtNAHp7QcwDn5SJJEGy0r0HM5qYu47d2nq90HzFgaRfyBHg2enj4kFu?=
 =?us-ascii?Q?XQa7IBrTgmRDX2J87W8dFHMIS2RgNzD2FjjHDRdUqBvsH3M8NlcNYb38AsHa?=
 =?us-ascii?Q?AM3yyXwLr0AYNGtF/C/wG0+vqjiSvqmRVRIjGTgMjJgViJepFI4f55NonML7?=
 =?us-ascii?Q?7Ed0mu9WTrdw6rroC1eStC/EuAK10V4wWGhDBwGlYUeNqx7jS5k7W4qx007j?=
 =?us-ascii?Q?7WTEWq3GczCAJul6tR54yLAiDEJ98sSbhdFObNY5eWBO214BtbLSiXHL+UrQ?=
 =?us-ascii?Q?DpqCaVcfiCuvxoj3D5oVp0T9NPOmm5JWWrPCMumm/v7caeaa9RF0sQEi6p6Z?=
 =?us-ascii?Q?0/k1yq1qmHzugI8M1fT5kWHGLrY4AscIEtgyO9uab7vTPp5smHfRrzT42Q1H?=
 =?us-ascii?Q?jQrLpMx5dJnbFqw7y5sJ9b4dCwXhuG/xmw+JC/ykV7tRLmJMKw+gaOyNrc6J?=
 =?us-ascii?Q?2iNWtw2gSCefq17pRda+EPvJWz9mAtv+tmICh85zZlxuJ1Mtp9GCpiXN7sgP?=
 =?us-ascii?Q?BpSDX5UJqjCae/tlb8o3uxS3eMLtaWPfcK/KblWxHohYZaUJJut3uUH+aCiz?=
 =?us-ascii?Q?gw2kXInYjH7/vmf6ctyTTSy5J9xuqJukIUhWrFUqQh0r6M89QGaL+sSqOa6j?=
 =?us-ascii?Q?42Zcg4Q07V0ycHs9RebX86KSDkvwvoDIbUU9DCZUCvqUb//mi0k/lUP9rkYo?=
 =?us-ascii?Q?9MdheoK5m/Z16+rGf7gndd+DPuQX/oAnzgOcLHdWu7hmbBv8kOMI1iW3mSZJ?=
 =?us-ascii?Q?ChnOOOydHtsjLJFeq4ZlHpitaJfNEl/cbGWQW2uxb09cSDiN+uH26PMRBjE7?=
 =?us-ascii?Q?j4M3oHi0SdukMc1rpn/QpxJFm0M6z4E47+j3qAlxyt+BBtCZ+M78OikVOQ8O?=
 =?us-ascii?Q?idTOlQRYU9/UewLIUwEkvIw3k3SGbCyfedePlsiMJHMaNeuIpA6HEPKTmv81?=
 =?us-ascii?Q?G/kJM+G37gWtHXfakyvc3EfFhxvDGugkYaJna9dHkL+EAKO2N7RRVwuwk2fT?=
 =?us-ascii?Q?O3/udme4O9zF7Pmq4xLB7VFgfXg+z1zXvyGqJJqOEJVLrSFhxlMi?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f41698a-21df-4cc3-761d-08df170edbf1
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:09.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wT4KdXjtSeAU496WQ3hSvIBSpQvla6xgw0zLL7TgbvMfs5qKSwjdiX5cpDaf8z86h2ACJQhloaiXdswXcN1dhs/BR9vRtHOmaimALn6mKmHPjyqThsKCfHM6EEt17sKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

Add driver for the StarFive JHB100 Peripheral-2 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  11 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per2.c   | 174 ++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per2.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 8a427e958659..89dadff766fc 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -95,6 +95,17 @@ config CLK_STARFIVE_JHB100_PER1
 	  Say yes here to support the peripheral-1 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER2
+	bool "StarFive JHB100 peripheral-2 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
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
index 51511086a727..044e1942ccfa 100644
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
index 000000000000..eed5d8d404d2
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
+#include "clk-starfive-common.h"
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
+static const struct starfive_clk_data jhb100_per2crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER2CLK_300, "per2_300", 2,
+		      JHB100_PER2CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER2CLK_100, "per2_100", 4,
+		      JHB100_PER2CLK_CFG_400),
+	STARFIVE__DIV(JHB100_PER2CLK_50, "per2_50", 2,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC2_RMII_50, "gmac2_rmii_50", 2,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN0_CORE_DIV, "can0_core_div", 20,
+		      JHB100_PER2CLK_CFG_400),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN1_CORE_DIV, "can1_core_div", 20,
+		      JHB100_PER2CLK_CFG_400),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN0_TIMER, "can0_timer", 100,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_CAN1_TIMER, "can1_timer", 100,
+		      JHB100_PER2CLK_100),
+	STARFIVE__DIV(JHB100_PER2CLK_RTC_CORE_DIV, "rtc_core_div", 763,
+		      JHB100_PER2CLK_OSC),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_RMII_MUX_DLY, "gmac2_rmii_mux_dly", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_REF,
+		      JHB100_PER2CLK_GMAC2_RMII_50),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC2_RMII_DIV, "gmac2_rmii_div", 20,
+		      JHB100_PER2CLK_GMAC2_RMII_MUX_DLY),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_RGMII_125_MUX, "gmac2_rgmii_125_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RGMII_RX,
+		      JHB100_PER2CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC2_RGMII_DIV, "gmac2_rgmii_div", 50,
+		      JHB100_PER2CLK_CFG_125),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_TX_MUX, "gmac2_tx_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_DIV,
+		      JHB100_PER2CLK_GMAC2_RGMII_DIV),
+	STARFIVE__INV(JHB100_PER2CLK_GMAC2_TX_180_BUF, "gmac2_tx_180_buf",
+		      JHB100_PER2CLK_GMAC2_TX_MUX),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_RX_MUX_DLY, "gmac2_rx_mux_dly", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_DIV,
+		      JHB100_PER2CLK_GMAC2_RGMII_125_MUX),
+	STARFIVE__INV(JHB100_PER2CLK_GMAC2_RX_180_BUF, "gmac2_rx_180_buf",
+		      JHB100_PER2CLK_GMAC2_RX_MUX_DLY),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY, "gmac2_txck_mux_dly", 0, 2,
+		      JHB100_PER2CLK_GMAC2_RMII_50,
+		      JHB100_PER2CLK_GMAC2_TX_MUX),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC3_TX_125_MUX, "gmac3_tx_125_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC3_SGMII_TX,
+		      JHB100_PER2CLK_CFG_125),
+	STARFIVE__MUX(JHB100_PER2CLK_GMAC3_RX_125_MUX, "gmac3_rx_125_mux", 0, 2,
+		      JHB100_PER2CLK_GMAC3_SGMII_RX,
+		      JHB100_PER2CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC3_TX_DIV, "gmac3_tx_div", 50,
+		      JHB100_PER2CLK_GMAC3_TX_125_MUX),
+	STARFIVE__DIV(JHB100_PER2CLK_GMAC3_RX_DIV, "gmac3_rx_div", 50,
+		      JHB100_PER2CLK_GMAC3_RX_125_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_SENSORS_PERIPH2, "sensors_periph2", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_FAN_TACH_PCLK, "fan_tach_pclk", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_I, "ether0_rmiiandrgmii_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_TX_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_I, "ether0_rmiiandrgmii_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RX_MUX_DLY),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_180_I, "ether0_rmiiandrgmii_tx_180_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_TX_180_BUF),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_180_I, "ether0_rmiiandrgmii_rx_180_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RX_180_BUF),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_PTP_REF_I, "ether0_rmiiandrgmii_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_50),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RMII_I, "ether0_rmiiandrgmii_rmii_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC2_RMII_MUX_DLY),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_CSR_I, "ether0_rmiiandrgmii_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER0_RMIIANDRGMII_ACLK_I, "ether0_rmiiandrgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_300),
+	STARFIVE_GATE(JHB100_PER2CLK_RMIIANDRGMII_IOMUX_GMAC2_TXCK, "rmiiandrgmii_iomux_gmac2_txck",
+		      CLK_IS_CRITICAL, JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_TX_I, "ether1_sgmii_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_TX_DIV),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_RX_I, "ether1_sgmii_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_RX_DIV),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_TX_125_I, "ether1_sgmii_tx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_TX_125_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_RX_125_I, "ether1_sgmii_rx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_GMAC3_RX_125_MUX),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_PTP_REF_I, "ether1_sgmii_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_50),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_CSR_I, "ether1_sgmii_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_ACLK_I, "ether1_sgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_300),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_PHY_PCLK_I, "ether1_sgmii_phy_pclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_ETHER1_SGMII_REF_25_I, "ether1_sgmii_ref_25_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER2CLK_OSC),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_CAN0, "main_icg_en_can0", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_CAN1, "main_icg_en_can1", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_DMAC_8CH, "main_icg_en_dmac_8ch", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_RTC_SCAN, "main_icg_en_rtc_scan", CLK_IS_CRITICAL,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_ADC0, "main_icg_en_adc0", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_ADC1, "main_icg_en_adc1", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_GMAC2, "main_icg_en_gmac2", 0,
+		      JHB100_PER2CLK_100),
+	STARFIVE_GATE(JHB100_PER2CLK_MAIN_ICG_EN_GMAC3, "main_icg_en_gmac3", 0,
+		      JHB100_PER2CLK_100),
+};
+
+static const struct starfive_crg_domain_info jhb100_per2crg_info = {
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
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per2",
+		.of_match_table = jhb100_per2crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_per2crg_driver);
-- 
2.25.1

