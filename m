Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BED42E40C;
	Sun, 20 Sep 2026 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905699; cv=fail; b=Anpfs6BXOnnX0MdnKQlCPy4/gO1qxGajihOi8Dg4Va5AJyJX//+gLE1ls5GGFKkyGiy6AX8qxkua2VRx3JVibutmH7ZNcyicrBkvsYgigIRCJpbgrINm0uP86j2Pk+cof50h35lGMqtlEORPTsTVvBGbZYURPksvmpUsFJUjV04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905699; c=relaxed/simple;
	bh=bxlWOLORDDxsKvR/DyUHSxt4w+mJKpOG98LSypLVRG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPOmR6QHpsF+hXXV1Cg3wzbnft9kFDpiEB/Zk5XF1vQM2EXGkSJfR6c3L4lx18rM9ImDuQl8V8MFN9FEabzCqH9za5TRdmDbZGY8cIiWgp4C5pZAvHQmLTbVx0Qqkzxi9RmAOTLcOHJCGmKdcJ3DMSJHkEqYMZOpV2olU8hGzI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm59d+jI7qqJJXwa5DoqMPl8P71wk88/krX2rHu9SAbHCuClE0TqWzPvtW4LnBmW8eA0F4BLSTCxJMRQpDp4BBmuF9BQJwztosULIk38CBkZ1mupI/i/ilqvATFmUlMa7yiSlh4YOvpGyFVGLSr6+73R3wu2LiS8ArPo79kvuCepNfxocPxfpATEcqRK58zSZgH//ylzmR5qL4/fzwP1oZjc+KCB3ty7kbfAHL7IZGRWdaQI9JLD6as8XKa8uY7lRGK58IvvIzEGopkHtbvV0qoDrvd723DD5zt8vaTrclAKbpuKM9nnTQ7pt42TuaVOcs+eNn+QgvHOI4BYZkw58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0CzYBA3QgfDvvCQcanJHJvhSJcxcKzxL5wugzcnozM=;
 b=SP2sR7AYHz0Pto0GeqAWxSuJ3XeZYA5rxtvwDRVR8VSC4Bx+zQ7q6D+lCCSXgufKhnrkY8Vpy+2ipKPoa2IFzGngjd8pjn1/y1625e868BKqhJXZyQKhE+2T3boOnWKMQ8mjmWsxNBPxgQsqaaxz/+H5tjCSOY3IYzdGx0gfvYMylwDwOZOe8qiBDA6Ez0fSEwLNyyOKs5NG70I8x+3y690A3zuVxaAVkUsQ1HFrndx268Yux6dH9OGC++m6PQSV524JXPBEMtpdscXxis20/nBbyE1BNNoE57SUsvUqx0HrVovuzCrqRi3BSfORmZOmKiifCCTTrL49t23VSRLsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 12:01:11 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:11 +0000
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
Subject: [PATCH v4 20/22] clk: starfive: Add StarFive JHB100 Peripheral-3 clock driver
Date: Sun, 20 Sep 2026 05:00:42 -0700
Message-Id: <20260920120044.194901-21-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0dc2ab9a-b44b-4758-6fae-08df170edd14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|23010399003|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	K/47/zxP7k6HidHnhrY59C2hzC3yAXhaJpxGQ7goRuGf91p4VNBjCR5B5kovWNX2hec9FxUnFoLY7sUOJWqwSkpCeqEfw4NsC0aSk/uaTwBRM5rdvRpV5sXkcYsw1XAz3FAiZTzue2p5nEKKDUobYAJO2RLGmy+rAFWy5HNN9TjI3x5kkm7VLtKrY66VAjmW7Gv+mbF/s//zXVf5S5VtBen5Sys74v+lZHL725nvNq1jPFPJqP8Rl6ZLMM1iR1pRb4qs7rb+jT4czJqc9MCQlxmbojGep+K+pqWBs/hnnhNtPc2zbqMjQEv4UjnP1fVeBAiDfAhoYog7vee3ytwBEH76Qs+WVzW481uiE38nr9LkrPmf8RTyzpGNkxnkuDT3U6UcpOGWgVPSYSwdMGDiFSLsKUbFvvunx8pr9AeakF8p+apcPoxFyE9/oj2U78SwuYwRSTuIs2YPRnqsb6A8af3+hnBUUMrf9zuYF36ipyxL0jLmxeL8o+X5ycEL+S/n9VB3EuSGbJmf7MgU7ZgWlmejq/7KEvTLdDlIeeRtnCW2B+jgLPvtMdRXyXAQbSSO8unBlC9fC8dLv2o9sz8liA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hg+P06vsPlGxhqsNDL8zLrBDQDyXyg1McIo+tB0SN35L/PAYd29RWbzYmx41?=
 =?us-ascii?Q?kIA9o3dmHuxad7WU6kSTB6cmDDFP2waDghKHVkGN4zjEP3cHzRXrsFAR4xJ+?=
 =?us-ascii?Q?yS5YTzjVfVcrJoKSKqrUG+CCv6Vf74EWYHuj/gE7GJ8/qKU7tBcKr3ZpcOts?=
 =?us-ascii?Q?MknQZxd7eXmFQKRCuNFtwbxJNAo0h6cVqN1UApSSBf/Vf4QkCHE7OiA6qqE2?=
 =?us-ascii?Q?lU6NHXWhAKPRPsaUTqV2AQCxDO9dsjeSnnjJetjAInxVNmv3BP7KSPg0+gH4?=
 =?us-ascii?Q?FlATRIEuStMJE7u0hDf503OVTHQgcIMoaze0xuqmL3UhgK3+nd3VRzvfJWfU?=
 =?us-ascii?Q?VsuRWh5ndWnQM+LOBbqtFLCnbyuCbYpadZV9rRmE/XyBJta2KK5OUlcMHIOT?=
 =?us-ascii?Q?EY3c2/OJo3nJjYkduPuS3cOId56VsNciw3d9cfwn/+87phJ+GFFjBhNHds28?=
 =?us-ascii?Q?SfNvPbCxppO9KPgX8JkKkhDUzfXoW5nWLWZJvuQzz/D3neJkbK2vc7MEBjPc?=
 =?us-ascii?Q?JQdoJFRHA77ZQSTCIhhq9d4NPR1ZYyDbR0z+vpNaMB7W1g+RpudLcw1Fegzd?=
 =?us-ascii?Q?9M3aB4vF2vfbDA6pj5HSJJuJA/7J2VB9z7Hh7gHIAdAhvDJ3y0tWtgfU1JqB?=
 =?us-ascii?Q?hgcIZ6lOL+mWXrcljnwhzO/Rq1PkNzYMsD5W9o1/EmMMM8PMFjyElYYNJxOU?=
 =?us-ascii?Q?sT58r57E6GkSJGio3TD5Z9kB0eJzoc8JZV+q/73k1zoY4HxqJ5tVYMLjVU08?=
 =?us-ascii?Q?JLgsTTLExntC/LccQbUJ99UcEGxKJg9h6n5DnfPxfzO8rkiJphUCuj8+jubx?=
 =?us-ascii?Q?YeGeQzl8a4FQhBIjFskFR4MF07IuuNtzMCmYZBAStlaj9sP4U9Wts4oS/kiQ?=
 =?us-ascii?Q?wpjH85qKDjxjzVxhkjxDyVgZ8PnKRENaJeU9Sf6HKfekQ/YlxICYA6OemSEs?=
 =?us-ascii?Q?xZn4bLCaoUkOFV6F0MSamuSnQ9uZCsP4oKNLD81wh2CDbjVJ45gTIqzG5Jor?=
 =?us-ascii?Q?paD4Hk9iHUEJRzjfdXe1zIF11O/uFVuCGHUBgjCkzZc+a1nOolELCpvvpdzP?=
 =?us-ascii?Q?vn5IwNSQXQ1lSzwIno3n924VYkR6GNvmMpmCUMNAG1ATD+tgDw43tGtpY8dk?=
 =?us-ascii?Q?f1TKukohM9DwkqFGjyxN+ppwbkbiSwVuNplnmgpRGPnocgstanO7jBDFqht7?=
 =?us-ascii?Q?cMoFA0vqlF5BXBLX/rks0ZZaqITqB7tAU/f2JZLdG2U10QkbalaQHv6GBlmd?=
 =?us-ascii?Q?bfY7RoTgTbFk+VFrWV2vR2MXQzBHz035AZj1hiU8Awyyt9tAONI3VKbwNDWL?=
 =?us-ascii?Q?JbYCN1B6u2eywubNYBkJqJX+uiQslhpv0YzUsmBShjhfDk8Qf0cLUiRVxZ98?=
 =?us-ascii?Q?1fSsaBxG9jtYjbkW4S/12ksRsB/kohvJur6yIyxng4lx/Mq4dpRgc5NySOE3?=
 =?us-ascii?Q?eG8O07HK+xmmENJSKJ+vDYjsPXGbUOOpMqoy5HP16FxUhd/4eh1c6/CfaKY2?=
 =?us-ascii?Q?F+FP7n3sM6UZokaQMNvarRy2muKZEYmE9Am26hgYUs0TTb4GrfDVKF3rLIX7?=
 =?us-ascii?Q?7yfifaNqmW0GRuNEOE5ds0pneQqPYEtyElwenTYCPzOIeYL844srp0ckEnna?=
 =?us-ascii?Q?gER5MBfNuuaSNcvTDvQACinQw0Ubndchu6Whem90gqdwqYxgm3yIFB3L93FL?=
 =?us-ascii?Q?vCCME3iWnhis7GMo40K4pgpfz/iRlY8IyhLgirH4ZDFXq5ZQD3b4J7RRXO2x?=
 =?us-ascii?Q?m7L7SSEUVd/zHOKeYPNV0hw/1frNaiK4AzkmsUyf5OZLb2pztFmv?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc2ab9a-b44b-4758-6fae-08df170edd14
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:11.6640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxKRlhYzAF/qk7bwpNcN2i4qMR2WAd/BlZUPQMKA1WsJE0PDOjyM2U/9h9oAqS2k58CATpc3lMTsc2reuPIN+SY312nkuoyLsNdyfI6FwksizCBtUqbmQex/HJRDYZxN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

Add driver for the StarFive JHB100 Peripheral-3 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  11 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 132 ++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per3.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 89dadff766fc..852464949334 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -106,6 +106,17 @@ config CLK_STARFIVE_JHB100_PER2
 	  Say yes here to support the peripheral-2 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER3
+	bool "StarFive JHB100 peripheral-3 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the peripheral-3 clock controller
+	  on the StarFive JHB100 SoC.
+
 config CLK_STARFIVE_JHB100_SYS0
 	bool "StarFive JHB100 system-0 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 044e1942ccfa..f00690f0cdad 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER0)		+= clk-starfive-jhb100-per0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER1)		+= clk-starfive-jhb100-per1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_PER2)		+= clk-starfive-jhb100-per2.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_PER3)		+= clk-starfive-jhb100-per3.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-per3.c b/drivers/clk/starfive/clk-starfive-jhb100-per3.c
new file mode 100644
index 000000000000..6703201604fb
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-per3.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 Peripheral-3 Clock Driver
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
+#define JHB100_PER3CLK_NUM_CLKS			(JHB100_PER3CLK_MAIN_ICG_EN_GMAC1 + 1)
+
+/* external clocks */
+#define JHB100_PER3CLK_NCNOC_INIT		(JHB100_PER3CLK_NUM_CLKS + 0)
+#define JHB100_PER3CLK_NCNOC_TARG		(JHB100_PER3CLK_NUM_CLKS + 1)
+#define JHB100_PER3CLK_CFG_125			(JHB100_PER3CLK_NUM_CLKS + 2)
+#define JHB100_PER3CLK_GMAC0_RMII_RCLKI		(JHB100_PER3CLK_NUM_CLKS + 3)
+#define JHB100_PER3CLK_GMAC1_SGMII_TX		(JHB100_PER3CLK_NUM_CLKS + 4)
+#define JHB100_PER3CLK_GMAC1_SGMII_RX		(JHB100_PER3CLK_NUM_CLKS + 5)
+#define JHB100_PER3CLK_OSC			(JHB100_PER3CLK_NUM_CLKS + 6)
+
+static const char * const jhb100_per3_ext_clk[] = {
+	"ncnoc_init",
+	"ncnoc_targ",
+	"cfg_125",
+	"gmac0_rmii_rclki",
+	"gmac1_sgmii_tx",
+	"gmac1_sgmii_rx",
+	"osc",
+};
+
+static const struct starfive_clk_data jhb100_per3crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER3CLK_300, "per3_300", 256,
+		      JHB100_PER3CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER3CLK_200, "per3_200", 256,
+		      JHB100_PER3CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_PTP_REF, "gmac1_ptp_ref", 2,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC1_TX_125_MUX, "gmac1_tx_125_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC1_SGMII_TX,
+		      JHB100_PER3CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_TX, "gmac1_tx", 50,
+		      JHB100_PER3CLK_GMAC1_TX_125_MUX),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC1_RX_125_MUX, "gmac1_rx_125_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC1_SGMII_RX,
+		      JHB100_PER3CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_RX, "gmac1_rx", 50,
+		      JHB100_PER3CLK_GMAC1_RX_125_MUX),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_PTP_REF, "gmac0_ptp_ref", 2,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_RMII_PLL, "gmac0_rmii_pll", 2,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC0_RMII_MUX, "gmac0_rmii_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC0_RMII_PLL,
+		      JHB100_PER3CLK_GMAC0_RMII_RCLKI),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2, "gmac0_rmii_mux_div2", 20,
+		      JHB100_PER3CLK_GMAC0_RMII_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_TX_I, "ether0_rmii_clk_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_RX_I, "ether0_rmii_clk_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_PTP_REF_I, "ether0_rmii_clk_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_PTP_REF),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_RMII_I, "ether0_rmii_clk_rmii_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_CSR_I, "ether0_rmii_clk_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_ACLK_I, "ether0_rmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_300),
+	STARFIVE_GATE(JHB100_PER3CLK_GMAC0_RMII_RCLKO, "gmac0_rmii_rclko",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_PLL),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_I, "ether0_sgmii_clk_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_TX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_I, "ether0_sgmii_clk_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_RX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_125_I, "ether0_sgmii_clk_tx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_TX_125_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_125_I, "ether0_sgmii_clk_rx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_RX_125_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_PTP_REF_I, "ether0_sgmii_clk_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_PTP_REF),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_REF_25_I, "ether0_sgmii_clk_ref_25_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_OSC),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_CSR_I, "ether0_sgmii_clk_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_ACLK_I, "ether0_sgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_300),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_PHY_PCLK_I, "ether0_sgmii_phy_pclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_SENSORS_PERIPH3, "main_icg_en_sensors_periph3", 0,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI0, "main_icg_en_peci0", 0,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI1, "main_icg_en_peci1", 0,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC0, "main_icg_en_gmac0",
+		      CLK_IS_CRITICAL, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC1, "main_icg_en_gmac1",
+		      CLK_IS_CRITICAL, JHB100_PER3CLK_NCNOC_TARG),
+};
+
+static const struct starfive_crg_domain_info jhb100_per3crg_info = {
+	.clk_data	= jhb100_per3crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_per3crg_clk_data),
+	.ext_clk	= jhb100_per3_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_per3_ext_clk),
+	.rst_name	= "jhb100-r-per3",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_per3crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-per3crg",
+		.data = &jhb100_per3crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_per3crg_driver = {
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per3",
+		.of_match_table = jhb100_per3crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_per3crg_driver);
-- 
2.25.1

