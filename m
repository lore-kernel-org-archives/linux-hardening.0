Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0D470440;
	Fri,  7 Aug 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102264; cv=fail; b=Gj1GcpzmHyJu2hLcH3phB+I32XyHHv32A2wpe+n58HBxvuiQFKRwBude571lw2TtqbgSDSrmG5N/6KcQPyuqGlqcr4+XCET0ENn6JDC/LfIbgLculcEytZy6mOMPppPmn3VELvA1bvSGrO4/pN/PWLAeblNYPKfn3iwoESffoUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102264; c=relaxed/simple;
	bh=6+o7TwQiIFRuVbGTK9Ba1E4zsS3IrrHm9i6QmJ3xwe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0q/4AHc+UbdYtbctOf3ubGiJyzmqsVDBox2ZjB6cTuNf6Bjauz6aH98e27MUL12x/HfUCOy4k15yAttjbN3YL8cIsgW8EtXjWpb16aerDv6hpsNn+vCv8DS/LyAIKEBqahhY4WRu2/CCrF2ZdmVNIsq/1dmRVWAPmmKA1N+krg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BokQlqeRI+C5cJikl2uBefVpDI6gax6dqKzfgf7LwTOzOCi0NL5xc5OWeCJfmmyUIKtCkNlSZuaS4dVseMqiJ2yo4+OaCOvH9amUNLPyQ5yw4q6p7wI1eA38ry5RxtjToubg2p086dwFlqmitl1TSefiF84tlv3hMEIRZNjScPxPBr0v0DIWmmZlx5Ac+xO1UMto/oGY5Q9/Jaulrtc7kYtsQTmN3cqqBkRe+M+0YENhCYT+Zh4ODjSdpMGuDCCd/HOkb6B4/jwWwuCoZFuZoblQ/VAuVpFigu8tbAbetThl+EGYSFP+qMPDE1HX1R5/Plou1O+aF1uoe/MEPCbGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mWEb69sGYFvNJtFChA2cPQwCzm33d4EzlXlgcek3rA=;
 b=IoT2LSzopThVEgXWOlOHW0E2z06/zdADAcxLTQCePH5XQTfxclSDpUkn/ueH/Pk60IqmmmrxG18t3sA5olLZoofPdVpWcvWPHGpgmvnZTsxKKiz+eqZaq7CmB4RwMjEJnFHW0cjH5Me0x1ZtUzkIxvnksSPzDt8jL2b6Dq2U6HKRSGHcnnbgrbA6Kmm+cLx5tqpEWajglhmh2mu9Lrjqju1jdDpi/1/iAeZDJ73vvbDcUugO5zP+y5UpR8S/M7F1ju76TptMnVcujTr6jGut0LkG8MuGL8MemF1gDONmx7kJUYd1rV6vciI5kBFmBf+2uhtRlFXkxIWA2zR3/t5aDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:48 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:48 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
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
Subject: [PATCH v3 10/22] clk: starfive: Add JHB100 System-2 clock generator driver
Date: Fri,  7 Aug 2026 04:29:11 -0700
Message-Id: <20260807112923.191627-11-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
References: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::19) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1315:EE_
X-MS-Office365-Filtering-Correlation-Id: faa90b82-b734-4d8e-4a44-08def4773051
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4h1+jnW2rcvX0g9xsZpWMRx8JrAMVG0iK1ImQZw9Qaf3Smhf4ZwuCU/GvR9jA4x/UQeYhp/Msxg7523RELkdvNyEs1j2suwwpD/TC0ACAx+6Tmsf1xNstKgLRn7LX4BUg2/CcTirbN1Q/pv+hIoF+VbTWNXS+aUJAs2T0K1ImMtbfrtdfFJaOCNg2sKxpI/tociaXcyOKe/gOXC+yY/gthisU8uuXaxt1D1OLx+I3dzslrSGpsn5v74gy/ah1U9coCYolZHwBE6qPFuQY+EjODkprNVbRvOxakTJ5oXCiklVAX698Gesb667lq7Z0rT1DpRgGkiev/KL/oNqen7F2agHmXPvE8mEHFoFPHP70T5Zzbb8mIFMU7w2gImgR8Lv8YRqzztHyEGY+5AdUzyA5ksnyrS7oQSwTJi9GyqSdztPvwKPu+ijtv0tpvhHg1wJ91qExaha4MHEwy8x5IBZudb6JUWU2qHg9d9TxAgBhaYo9oMsrwCbWK/G0c49PbIK0RIkEaXFv05KCyyyqDr9xhHRrtF/t3Anf9TACi2c6rt/jgNmb2ax4UoW/EAeXRR1XfTEyUDXSwblTGLW4U54rw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lpdr9jAH8+yDlDPQgT/QzkM6aor4hGLoX1enUqd4PufmQ5PYkpofM/tc22S4?=
 =?us-ascii?Q?yV/cuHxd67AJg+w6oX7uHILAPby9tlo5zKm8hRFC+XPsyNtPXCCjWsELQfIS?=
 =?us-ascii?Q?CUgl6tdBcGBrpZGzQHB+VMTEZ8SFUOeHq/qppEMfMrT9QemfPMxQ9No4OYJN?=
 =?us-ascii?Q?LrsWXU8NPGG64pUztKwFok0+75Th/0Gnme1d8255738t3D5yt0MtayFH54NS?=
 =?us-ascii?Q?zzixWmD5Wpm5HP31gBbD3jvPMWWaw9LFAh320TLMPMs9ALD5o+fpX7WUbYSG?=
 =?us-ascii?Q?WGBCWmvpWSp4x8QI6emFyePJky2ZlTnOVasRX27b9NSakuOkh/tg0E/7u0Cc?=
 =?us-ascii?Q?tut1NV+TeduX1leFch8LFzZt/EZ7zznAJOlQ4dibI79MW1VO6N37itHhdMdX?=
 =?us-ascii?Q?qL5APxIxKv5VCcXVoCHGDk6/wgLjL3NlJCLAbAZsHrY/9ctGO7dzXjCjZF6C?=
 =?us-ascii?Q?QqV83I8kwrPCb3oeL++zZuF9QmZ/KZL2W9r0cqN33Af1usNBXhEv3CCPj9Xe?=
 =?us-ascii?Q?2o5umTrrSi8+OJN689rhNilyCt2wxl1w1DdQbbZ+BF7Mpu2g1qZ69eL4NBAN?=
 =?us-ascii?Q?Jh/K7viEp2P8Vhlw2bi3cF8sO3gYMWDJUMohUmD8eyfYOtOm5DawZa15+M2X?=
 =?us-ascii?Q?FGmIIvOXa0y7c59CCfZRm0RSVVBd7SFwpMDm/w584eEq2Vf2Cytn8MEP+S9e?=
 =?us-ascii?Q?zEk9BCsjVQVM/uTcoCKdxH2XuHAyh/EXdhVgriWka9NpMYU0zmNCzp2DeA8T?=
 =?us-ascii?Q?oa6S3IABKLbf8F3u6EvJaUlx2e8ZJMF6WlSgsMgTN468x0Kt8aJbEyKzcV3w?=
 =?us-ascii?Q?CxcVWDauDc38vys6s4locF20Yk83IV+5ZLme8FzpO6nYuWA1OiZalsKpCOM5?=
 =?us-ascii?Q?MTXzzuuZJ27EsX9pEAv5vhlt5w+RoPWji15SKzvWUgIZ+54UVdE0g4wAr3I0?=
 =?us-ascii?Q?DpUMS2qOnM5SfK4mQdEN5mb5U4uAsppA+K0Rvgx3+sEkrb6dU2Co06sPz4WW?=
 =?us-ascii?Q?6yoerQ5TP8hwA7WQq0snVMV0X1Ng+ajFNNutR6w9hD6lQn+2IkBsnPIr6pSe?=
 =?us-ascii?Q?Bw+EqETR+E3Wsza5YRaQItCCfIa9CWloMHjPDQwRMnnj+lH1wmteBPZJR0zD?=
 =?us-ascii?Q?C6zSx1uyNG3W0nRtQ4T1ZJB4wo7QIM1OXleCER8gYpXvkjCB72ZHNbDJjDaM?=
 =?us-ascii?Q?EyJwlyp6qYSuPMitStCflhywcV2MAyqhHQFCJsypJjeQuLKxAz8mZaDqjAL0?=
 =?us-ascii?Q?NzufSey8KBFyZYO+21eywga9ykjyv7/4i693UvdngmN1UqMHj80m2IwUpFBg?=
 =?us-ascii?Q?bTXGfxtgJhv/V9wt5hWMendhN/FBByZ2wGP/LdbV4xCa2WB3ASx6ZpIuuOtJ?=
 =?us-ascii?Q?YYcinheNYc6o/X1GzXImCIt2OMAJFYy/CYMWDi9dYAzkgKYahOQtWG5joRG3?=
 =?us-ascii?Q?XtdTCDT5VDT6VTqD6xDPBQYhIXfWqXsKaFeSF+pKpTsmvJIgp2gmQ7tHKIkN?=
 =?us-ascii?Q?Nspy6u+FdAmisZM+jMtrYAc32DgeAZS76bccGsf+/dRqKmUHkcd0OzB3oeN6?=
 =?us-ascii?Q?v3eqp8poJhRR0JEgaSDm6RPACK/UeEaMAbTdOg9t4cq3sTD5t+8sI8dyOzZJ?=
 =?us-ascii?Q?qIjrpXp3D28kFFtlpfGU0zyvNcamsCPvjvBeF/WPRdworEO73zHVEaI2UPBy?=
 =?us-ascii?Q?5yg5HkgVD1/m2wXp6vhFKgHFQHdCVJQUIgDcW4m2qvr1kLfwh0WRf8xyQgTO?=
 =?us-ascii?Q?SAjbhx+zaq8dATojxatxPNB6SABTNOgVn/sJ4eiYMJds+RBOKeD9?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa90b82-b734-4d8e-4a44-08def4773051
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:48.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4Wr/ODbJREgC9LEtVTWj7W+rSBusDFu/Kekc7gr2d1GZy4ovSKvXgnpmbe4P6wFmdhvaXhxLiEmTntr9oQ+UsMkXepJEOd1VWGFgm46D8k+y1hYasQcvOzIE7EDbBnU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

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

