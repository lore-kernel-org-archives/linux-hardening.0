Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DAB4349B0;
	Sun, 20 Sep 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905814; cv=fail; b=ROWEXigpu/Kt8OT6FqhCM1TNdiwdNEfRPYSwFyqFePckVLLbGsMVK/MNrMJIfSnkZMQAEwVcKYzbLx2YavndFQ0GX1p+sr/ZKWMKCKrNv1ufYyuoSEvdaYfW1rEibJLFjct2dTbnbsjGTeXoLCdu1PxtCv+5K7r97/kF6a0Cz2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905814; c=relaxed/simple;
	bh=6+o7TwQiIFRuVbGTK9Ba1E4zsS3IrrHm9i6QmJ3xwe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QD4IcVzY46/eJ9Xa647qMYTNZkrMo4h5bDuWKXW339QF6gmceIQv/WrjDwgNZnp6S1xD4CexST3K1nwdhj2QG4ua63OW9joN+Cy8gvtXieZ2+NH6rW1hspPyxKIcbCYRVvbdcjK9mGtd1ALBKEXafz4k8vjs1vMsVoPwLeiY1qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoHNcrcQWnveiMWpSa8/PX6uUQ0UbKrq6BH7cyiy42hQVO4P5BqKKyTKFZWk0fz0mSXkzuFEFAVu6vGazVAtJFmjvsWQXNNj/Bcu4k+Zmmpl45DI1almmtml1Qpo2XpVkrP0D3xYYW3I1hYWSrPor8eaTdCjWTdC3nyjEp1dRTWx01d7b/NEnPN94Ndf0SFdsPeu600Sq8grUCp9ciL1nieLyBIcdeCwRch956s6K5cxgYZ5sbEl99m3yd/KVZhM0074ScysT8xWvEoyAuvuN5vQSimP8VJZVlt17waopnZqsPE+fBz4Y9SVzll9ln1P+upe6ig9sWZUX/5Cfd72uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mWEb69sGYFvNJtFChA2cPQwCzm33d4EzlXlgcek3rA=;
 b=APydrQ4tJV4zbvE9nEbX+wY8TQOTpelyCzLF/MCKmWxjg5t5VBbpU6nfvrLSR+gWa7SHN880ayq3gkuJ/xeVuNpLWuxLT+hKL22AgLbH3ANmc7nuxKR92Juwwjkepr5xqau20BSFbmftTU8eZL/InIqS5hGMvO/d3DOkgyvc6XDLMbHMIMy2nY29yIZweJTqGltxbWQXppH1xt+NFVz0hWKFe3EVUb8zbxq9ScPfWu7eaJ2YDOI4QctTGY1i7MkFnpw5kFpFbupWGIVh6jgESx44InQcB5TMWVngJduHU58w+LFZ/bnYhqRqRsKcV5+u41/ALeiRb8ccR1HYzZRiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:01:01 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:01 +0000
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
Subject: [PATCH v4 10/22] clk: starfive: Add JHB100 System-2 clock generator driver
Date: Sun, 20 Sep 2026 05:00:32 -0700
Message-Id: <20260920120044.194901-11-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1070:EE_
X-MS-Office365-Filtering-Correlation-Id: 325cb1dc-f02e-4650-fd93-08df170ed729
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	P0RqiO3sMkfIUnHnY6OLW+Rqif+QLXX4qdQ1h8nWPqTNDOap8bHLq0wXtMCWhC2csLl8hIAFzeLTTayknn6OG/7kopvc1BiNTU93+MOnLrfA3TdH2axyA4ZzWIyBx8R5eeghZiv5WO0JiVvtQgV/E4pknXYgo3CMINiph4kdJkha2e/rqtqtAFr8kw9IKcuSNH+lFf+jTPRlBAK49TT+4ExrMoMLw5YWmMFzEIw1a2ea32gwe0v04XTA/ZwodIA7alVZgoQ83lhQuKinzf7SPxxO28c7O6TPUFOrBkjxPksn2Z8EoFpxKGNI8aqClmo8d9SlTQlVBkUWbU6wzSptso24c5uU+yBes/pgRnsF7Xvg+jcAlgr9/+XbpNu7TYj//XwKfxOL+I2iup3RKaynOb+l9fu8xU99DlR5YMpVUye75l3NE+XnFl3Nr+gY9BchNbp9sueVOUSoBxWNLAFPytKKheE7YuX6pYZsttoUFssIHNw8QTgJDKwqHR228TsbaumN8qfvC45QMtud+kv8KHVkra3KTsxL3N3HboN9UcJ6o2lpFEfWwO85oq54uPcAW8p1nwTsVM8yXRRxuWSQrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ANRrjyMYWhs94q57CvXVjAka+cH4jjUbZDE7u0NNhxIGo3QCGeCJ1NIYHME?=
 =?us-ascii?Q?B/jazAN/pThC5vddgozvNxJq3XoZi9HWfQpQuxh7MCYusacyogW45ATWlflM?=
 =?us-ascii?Q?jepMER0l2c4y/BWSFqCuDGHdxLzx3oMYEvEyCYg6KGdIrdeNE2HJeoyi69N5?=
 =?us-ascii?Q?1EnDdSYdZZEAfoxp9XCoqDDVhN/RhjeD0rKrJopu7iknTi5uAvTPgDq8+yTU?=
 =?us-ascii?Q?bZFCbIpdh10eAZ8zbo6fJ3s4OiU/1dh50rHYgopmCU4F4L4GnjQUuOYd2Hh5?=
 =?us-ascii?Q?vwDWTxhSogGp0ZcQGzm7YvpO9Iy86nsHf2wMKv1xidwhjnQBA8rm7YeBrQxo?=
 =?us-ascii?Q?i3ZpRDKYJIUahjokygtLHUP+P+jbudhnNtslQM0yjvmXKoCzzayDyfJk50mA?=
 =?us-ascii?Q?URgjrel61/PkUmkyZe9c/N0DuBSUXQBj1nP7mItRJu05sYmWs95iLzBYe5Oy?=
 =?us-ascii?Q?ImzHSAoBkrCQqcdy4TfpZJlYRdS3i8Whb3HqZQR7SUTMPGllxwZYie/PvCWQ?=
 =?us-ascii?Q?tlcokXTH3GJgSROC0sQ8befxoE+Y+grdTu0mC5fV4ubUI2h6cp44m/vXGoOg?=
 =?us-ascii?Q?mgBt3pIkg1oKjQSr1qcU5e8aYhzxgL2kyO36v+uQrC7oNhMhUQYUv0RIwPSa?=
 =?us-ascii?Q?AgBF+aDoPxIpLzf4/7JZPrVAWjYXPtzevGRuUqeaepgfvI3keO6GOcygGBIQ?=
 =?us-ascii?Q?VYVN/6vQiONHxLzA0Cz6y/1c971cW65qZL7Dr0JTViWHDpGusecE8hf+kMJ8?=
 =?us-ascii?Q?0itX9lDeBsASgp/H56BbwvRD5/NhTkorE9JW3Qe5d0oAkHcuFpGTvEYJ+WH3?=
 =?us-ascii?Q?9drAGQaJ6KGTeP01MRbEeo1peM3XG9dj1jR07MZwLhTju0eJU4O32DgBcVAo?=
 =?us-ascii?Q?PzzJDMX74KOSO75G9FhEIM96nNuRlVkqfP7mnVPlCtb6MMUoWZFhTG3gUU5I?=
 =?us-ascii?Q?Sma87U/cnIIybUXwLDS/NDQ3Koi71Vv52s37QLDqZoIxwEjp77kABF1bH4ol?=
 =?us-ascii?Q?tvLJc5AyVTeLYr4hOBRleyzwAus6mXN1ntCunT2yBXcy6XfGXjXtq5TuWglH?=
 =?us-ascii?Q?R7Zs39f0ik5fksXIB/DGKRCUTdxY/SFBeT+p6YyEElVHEB7nZZBcnaVnX00B?=
 =?us-ascii?Q?L3ciyBQYm45JLquL4lgG4b7j18P9P171OOP82easHJ8O4rZQVeyGSuQsunVV?=
 =?us-ascii?Q?0Zar3OOP4IoCaNBHY8eFCShwH08j6m3+Ohk79FUC/uw7zgqf/ASeaeiNmGK9?=
 =?us-ascii?Q?9evkYz++8XNCmbMCvl3Ayj8M/je84NB4rk34dJqi00pYBp33xRhNpR14ug8y?=
 =?us-ascii?Q?UDf8FM5r+M6cw0TCwAUweeMzAkJeWlmWqelPmy3IUVgX50rCsiXnQfL08Szq?=
 =?us-ascii?Q?AKF6UtWW9Rk9x0DOQYt1vqIihokPiXzzlBSZ3127ZUtl10SOZYgi9jE5DFII?=
 =?us-ascii?Q?1/UYLX4NVwRLmu6GOIRLjKvVS4FzorMRjkGNeuvwq/01vn4zFH67wJe6vC3A?=
 =?us-ascii?Q?2IR0nqsRr9FI2lSIo3I9wvb8qRbbQDOjQouN44r8+Mjdr59tGqyhXtx2hx3z?=
 =?us-ascii?Q?gSr6nDJ1LfsuWt7KjLVieBzAenhOsCAzeqq7zgR0IyruuocS2+pCBd+mXzDK?=
 =?us-ascii?Q?g/xi9bBRAOqGa/iBlnkR+rtxGg04S8nHrsdhygKAKdhtl440vWKwfTxJaV0e?=
 =?us-ascii?Q?6Xz2fQjaWODuCGmwVkDL5D2MhN9Xl1yVKq+IMLqbD6+8+S0brJ+JG8kty+dm?=
 =?us-ascii?Q?2ieQnbeEgvm3NEp/p9P8Av2unGsKFcuZsIQt7kShcp7MYytdbBr/?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325cb1dc-f02e-4650-fd93-08df170ed729
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:01.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U80TSTJDrwYn5zIz+mIiuQF/6sXw+iAKgwmXQOEMTH0/bcFzLm3S8clePd16tXvcUCxAzti7F5LkqATMgckFOLWMlUlkpX6xr20DhlS5HRm7GRrCz+ZVrJ6kMlXN3Em3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

Add support for JHB100 System-2 clock generator (SYS2CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  11 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-sys2.c   | 129 ++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 798af23b9bcc..e5b9fcb58207 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -94,3 +94,14 @@ config CLK_STARFIVE_JHB100_SYS1
 	help
 	  Say yes here to support the system-1 clock controller on the
 	  StarFive JHB100 SoC.
+
+config CLK_STARFIVE_JHB100_SYS2
+	bool "StarFive JHB100 system-2 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-2 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index b3571e2f0555..90b6390296bd 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys2.c b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
new file mode 100644
index 000000000000..0abee9f9bb87
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 System-2 Clock Driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include "clk-starfive-common.h"
+
+#define JHB100_SYS2CLK_NUM_CLKS			(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1 + 1)
+
+/* external clocks */
+#define JHB100_SYS2CLK_OSC			(JHB100_SYS2CLK_NUM_CLKS + 0)
+#define JHB100_SYS2CLK_PLL1			(JHB100_SYS2CLK_NUM_CLKS + 1)
+#define JHB100_SYS2CLK_GPU0_NCNOC_INIT		(JHB100_SYS2CLK_NUM_CLKS + 2)
+#define JHB100_SYS2CLK_GPU1_NCNOC_INIT		(JHB100_SYS2CLK_NUM_CLKS + 3)
+
+static const char * const jhb100_sys2_ext_clk[] = {
+	"osc",
+	"pll1",
+	"gpu0_ncnoc_init",
+	"gpu1_ncnoc_init",
+};
+
+static const struct starfive_clk_data jhb100_sys2crg_clk_data[] = {
+	/* jtag mst*/
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM0_HCLK, "jtagm0_hclk", 6,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM1_HCLK, "jtagm1_hclk", 6,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM0_ATPG, "jtagm0_ATPG", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM1_ATPG, "jtagm1_ATPG", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM0_ATPG_TCLOCK, "jtagm0_atpg_tclock", 2,
+		      JHB100_SYS2CLK_JTAGM0_ATPG),
+	STARFIVE__DIV(JHB100_SYS2CLK_JTAGM1_ATPG_TCLOCK, "jtagm1_atpg_tclock", 2,
+		      JHB100_SYS2CLK_JTAGM1_ATPG),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_HCLK, "jtag0_mst_wrap_hclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_CLK_JTAG, "jtag0_mst_wrap_clk_jtag",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_APB_PCLK, "jtag0_mst_wrap_apb_pclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_ATPG),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_ATPG_TCLOCK, "jtag0_mst_wrap_atpg_tclock",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_ATPG),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_HCLK, "jtag1_mst_wrap_hclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_CLK_JTAG, "jtag1_mst_wrap_clk_jtag",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_APB_PCLK, "jtag1_mst_wrap_apb_pclk",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_ATPG),
+	STARFIVE_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_ATPG_TCLOCK, "jtag1_mst_wrap_atpg_tclock",
+		      CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_ATPG),
+	/* hostusbcmn */
+	STARFIVE__DIV(JHB100_SYS2CLK_HOSTUSB_NCNOC_TARG, "hostusb_ncnoc_targ", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_HOSTUSBCMN_CFG_500, "hostusbcmn_cfg_500", 4,
+		      JHB100_SYS2CLK_PLL1),
+	/* bmcperiph1 */
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER1_NCNOC_TARG, "bmcper1_ncnoc_targ", 6,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER1_CFG_250, "bmcper1_cfg_250", 5,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER1_CFG_143_DFT, "bmcper1_cfg_143_dft", 8,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS2CLK_BMCPER1_CFG_143, "bmcper1_cfg_143", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_BMCPER1_CFG_143_DFT),
+	/* bmcperiph0 */
+	STARFIVE__DIV(JHB100_SYS2CLK_BMCPER0_NCNOC_TARG, "bmcper0_ncnoc_targ", 6,
+		      JHB100_SYS2CLK_PLL1),
+	/* gpu0 */
+	STARFIVE__DIV(JHB100_SYS2CLK_GPU0_NCNOC_TARG, "gpu0_ncnoc_targ", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU0_BUS_CLK, "gpu0_bus_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU0_NCNOC_INIT),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU0_APB_CLK, "gpu0_apb_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU0_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU0_OSC_CLK, "gpu0_osc_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_OSC),
+	/* gpu1 */
+	STARFIVE__DIV(JHB100_SYS2CLK_GPU1_NCNOC_TARG, "gpu1_ncnoc_targ", 12,
+		      JHB100_SYS2CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU1_BUS_CLK, "gpu1_bus_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU1_NCNOC_INIT),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU1_APB_CLK, "gpu1_apb_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_GPU1_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_SYS2CLK_GPU1_OSC_CLK, "gpu1_osc_clk", CLK_IS_CRITICAL,
+		      JHB100_SYS2CLK_OSC),
+	/* main icg */
+	STARFIVE_GATE(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG0, "main_icg_en_jtag0", 0,
+		      JHB100_SYS2CLK_JTAGM0_HCLK),
+	STARFIVE_GATE(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1, "main_icg_en_jtag1", 0,
+		      JHB100_SYS2CLK_JTAGM1_HCLK),
+};
+
+static const struct starfive_crg_domain_info jhb100_sys2crg_info = {
+	.clk_data	= jhb100_sys2crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_sys2crg_clk_data),
+	.ext_clk	= jhb100_sys2_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_sys2_ext_clk),
+	.rst_name	= "jhb100-r-sys2",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_sys2crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-sys2crg",
+		.data = &jhb100_sys2crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_sys2crg_driver = {
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-sys2",
+		.of_match_table = jhb100_sys2crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_sys2crg_driver);
-- 
2.25.1

