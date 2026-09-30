Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926E4D8D97;
	Wed, 30 Sep 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772283; cv=fail; b=V+2gxYSo2mJyR9UmIMTwHDxSsGi2suUUYr7N3x+/KRMfgV/iXSvOkFFgMr5Qbg65zMxTVwtldRF+xY1BM+0DPjJtWXWoNM5fKgfMQPXtBZo6SlyRb7CJkwyP6NNJ/FBWkoKNKRExtm2s5eNZ0ARa8ifZK6u5GFE2viERI+pnGhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772283; c=relaxed/simple;
	bh=b3oeGxIbT89j5hvYVppCYSu94GQMIk2cvcGTCPioh3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gp8j72Omn7CikdW+dMvNsjNPJgqy6IqIfrBN5TSJn/n1jMjw+FmEJXlC4WYloeQZRzmtZ64gDixHKYUFxoXmkzTAnWO9wdhlpj9UNP1wSdkj4LFOYGehkaSupsH8uyeEHhUBHGMwkxAeh6D37YHM/ckLHSxIGgL2vYLUoZvnQjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbF+bK+R5DNl78+R5gTjS143XeEbaNI+utc3ROezvlG5R20Prgx6wmAK7AkfsST3rPPt/dYHO4pg0xjzdao2qFBM+3D/pid8wqs7ZDiPXax1wovKFnHGKIJUbON9ugQ2DWbcskmGvoXnKGPFSVQ8dwEfUhb71jnCBJIcq5ROs2SqMJ8A5jg3XTuzYb5ARz8GhlINCXQDdH41dWgEfVPqxUYLkRKc94jI0K5nAIJagMy8eCaAlJuiUnOaWiX7ZroZzZMcSNCkxg1nCrEw09g/t0Owgk25+TPruzpBFHFKIRlhN1d+LuX5BSRSaBYc4PaKEC2HLvvw9XLGcTVDiOCUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiAttJS6GNtEIyd9RK6W3NUhhlHDpfvrdCsku8qYQvI=;
 b=k8DYrwqPye/GWzLMtInjjQDC9jpg2p+k2cWRraTCz0lNC/qZUmPlqpbWRq8EJxJYaCD52ogFx4N9wVNVobD6kncAf+SMAvXlINnHmLRYbBSr7qfyJMbUZjpgNK/5V1LkXGyplUqPC2ATCDePJWJekn4cAxDPjhj7dTC6oY0mHpRDmiDPt6ZKXdpaQ4gJ5rWIWsDyTuPqBPdTck+8IETaCsToiUA0qG85pbSRhgdnvhOrZiw7tcKgk45TMu2747IOs67lZdcWGeFB1zXhiv9XLxo3+hvjHDa2I3acqrDNPS6W1pQGBEcYYm4dd6xYjT0L/IL2ajcgmJu1J4t8Qiqv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:44:07 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:44:07 +0000
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
Subject: [PATCH v5 20/23] clk: starfive: Add StarFive JHB100 Peripheral-3 clock driver
Date: Wed, 30 Sep 2026 05:43:14 -0700
Message-Id: <20260930124317.5648-21-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8c63bbd-0c45-4d5c-5ccb-08df1ef0846b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	lf6ixWmGJwxYs0hiu5PKhIGGv+jfy+0ql2UflDSReNq9rNGyxOx1FNNsiY29olCgm0Y2Wz+sGYT7aJcztSkZnDWkzOHdwJfOU0TUz/gfDfIdcb5XwiuejcDKAVuxjRpi0kuYhuIXLb+wZa1VuuZPCZb0xBmI9aRTV9xvtah4xPX7p/Vw0CbGlydYOpAEM3zovssWP0+Wfrpo7yNMmlaAk3JvcPiYPyteUCdUmGCfE8WOhVhaGloPcxWw2h7+eXX1dAMsdr+gqSLBcaI23+7/30N0ZiswpFM6M7ZGnACmG+SzrKYtnmNyp0AmGHTJuz7PKcqPX3GNO2JjgUzEnJHzgoEfAnE72KsarFXS6D0HGq2lssZiyt/t/z9noL4okljh1WahtPxIjuB80HbWJ2njz9mQlzkmXGqnl+0sfHbqiPNDCkdBDv63e9pUHFEwS4wHlao+VA5bkt3ug/rUy2/jZH4157qW1Vg00VkJXOSr17j7tVhzwoR0TvCDLPImPqsU4U9rKEnaXhbOEQKk9tQxHDdYO7M//pqEd1agsKRZbxLyeAIgRh6/bldUDofkDkT12siXnnpixQwUK+2RRsYRqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vE26TR++p+QBp0EpnzW0Lc6LQvvcwxaTqRwPSs8reEDUuj7VtmD2XoBuEYY7?=
 =?us-ascii?Q?dMnhmKSYRH1IeZ+PBzAmDeIJhjwFb7k2kaH0LnGWdDjHUHQcoy5tB5N9y14k?=
 =?us-ascii?Q?nNqyD7JGdcWF+ju2vF16Aj2IqJ44I1FUMZIb4yAnzjCgJQEMST2W87WzyEt4?=
 =?us-ascii?Q?2M7Be6R4yH8pKvb4+/dFywqVTD6B8KnG6gA0dnVokFkGu1nnHgCZp+U22reB?=
 =?us-ascii?Q?e62Ae/ULJhRgNy4Ysg+WtdrSvu8MR6CeqY8SAv2WtFnV/JpBwPKLvYMLaLKn?=
 =?us-ascii?Q?gyeENT+a+3lE04c6koRIgHTHb7WE/WVUtmtBvTGqDeqyDIZGv7j6+MauAzmu?=
 =?us-ascii?Q?3caN6hycZcBH6FmUdjVCdKWFXG022kOXyBb14h04WapnMGdm0x2ZKEJ7kBwi?=
 =?us-ascii?Q?VstPUMW51mHtjA1wiALHi3YsRSRiz5JMK8P8JpU3sKQUPbcfIw5DwovT8S8s?=
 =?us-ascii?Q?O22wM8xEBayzHVgDTNZ7SC+SSC3CigraZM7FeKf89DoUwUVYOb4EwljJZwx7?=
 =?us-ascii?Q?kYamZbUHQ4UAP3aoC9f+CAcKLe4WBUMF08nPugji17Rl8JriuK/KpJjlISKX?=
 =?us-ascii?Q?2NUe8KP9+lBROnRea3X/qyqtbJwPz8d88z7WXD6VoYxrP7ufqJyCEkDsT6n9?=
 =?us-ascii?Q?tTZaEnH4xfOka1wr/TpVP1XwV3qUuhmNxTnt9DLgCtbfkNMilCX8uE1u97rq?=
 =?us-ascii?Q?b3JcE//cOOIfO7GkROctUorduHuJ8ta41BRK+FAKH6W2CqDN44wiZ4y0AvgE?=
 =?us-ascii?Q?ZzO0nkN0yqgWmMCitCPc1BjLPV8uBXKmcsn25AZZJujXq1m4tbi4x8gGdI07?=
 =?us-ascii?Q?C2PyElrIWNogoAC8ioaBu4GowHUb635ct980TaeVmVxEymaP2sNRx5JFQSAO?=
 =?us-ascii?Q?o0T1zwSp286X7GpNQD4j1skI8M2F14WQz6/Tqt8IeSZdWYtaC5V7IBk6l0fq?=
 =?us-ascii?Q?xZhixdZNiuPwblPbTDd3Q45e9TPM8R2HraMYN7ses1yXFuvYiMxAdvbs5vcD?=
 =?us-ascii?Q?/QkdTSsdEbuoGK8T36mM4oPXIxLHFzZz4nUX0csYyIsv938osQc0urGudVPf?=
 =?us-ascii?Q?erKmTG1h9XQUdQ04Iu7T/fBeoMZPgPKuXyGkVc5BwhEmq6hXK6eKBKLHvHrj?=
 =?us-ascii?Q?QHAi8KAeDl82YM4ahiLxReNmxNyRb/fe/nCvPfFHGeSWOP6WaYUgROFSlMbE?=
 =?us-ascii?Q?mzUhqS0VC2JXjJfGUBtjCFOdYOJxZMsy7MoeC1b4inYXfZkXytCMtWnRlyhv?=
 =?us-ascii?Q?GMYS+VvUAfxTDm2a5mVGAdsDk0tkQoxtHSOdJ6ONW1W1TsPZdvZggsSE5Vbk?=
 =?us-ascii?Q?HPMJSkeZ0uOwSBRYWedatTkdYy4W0HGFMwaFSfLMga2nrwNVtWSYOX7ffruM?=
 =?us-ascii?Q?SJ+T71qB5vOWi4CiMxDpL6FvVmW9djnDYD0xV7yx1oUieLyUANeIryubKal8?=
 =?us-ascii?Q?XCofn72AozhYfzhAocygZ6Tl/Msr0uG6IaM/VGrGof+RHQldNWZc9qYUhMBF?=
 =?us-ascii?Q?8sGpNfttjdi7WV1y57o7SSnZPYFvLskWns1JfZTt8T+3SF075vsLKFHbfHG6?=
 =?us-ascii?Q?1l4u5Qs1hHVP26KHnDHZciPQdlziHei5q28URhnvkhSOwCexQsJ7vmA+tK+U?=
 =?us-ascii?Q?1zB9R9lFi4mGueJnZuCbue3Hw534HH3ArBrvXANzg0WxAgAnIuQYZArVE7c4?=
 =?us-ascii?Q?hcAkaTUUusBEK8W6OLjsVm7AWZyeJdoN2/omYUvSE+AbatNM4PUE9omruiS5?=
 =?us-ascii?Q?XcomH40CaMxa8akZF5LZlgPgoCPJzL34sNFa1MonUcJMm8IGW5F7?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c63bbd-0c45-4d5c-5ccb-08df1ef0846b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:44:07.3921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqckJoxybxRZFFwENC85wwP1WrtuJhWRE9Jr7hzCWgeg52HLP8Xnn8fd50HfYk8OOZbxo1kMZC4TWbM6Z2E/KJPzKmRp9Z43Q2nlGLPexT7pWT3dMPPMmVCSDjp901G/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Add driver for the StarFive JHB100 Peripheral-3 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  10 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 132 ++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per3.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 57a3838475e9..1c9dd5d47cb8 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -103,6 +103,16 @@ config CLK_STARFIVE_JHB100_PER2
 	  Say yes here to support the peripheral-2 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER3
+	bool "StarFive JHB100 peripheral-3 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select CLK_STARFIVE_JH71X0
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
index ca9347d38023..2c4554c2e70e 100644
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
index 000000000000..e5688c6efb50
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
+#include "clk-starfive-jh71x0.h"
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
+static const struct jh71x0_clk_data jhb100_per3crg_clk_data[] = {
+	JH71X0__DIV(JHB100_PER3CLK_300, "per3_300", 256,
+		    JHB100_PER3CLK_NCNOC_INIT),
+	JH71X0__DIV(JHB100_PER3CLK_200, "per3_200", 256,
+		    JHB100_PER3CLK_NCNOC_INIT),
+	JH71X0__DIV(JHB100_PER3CLK_GMAC1_PTP_REF, "gmac1_ptp_ref", 2,
+		    JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0__MUX(JHB100_PER3CLK_GMAC1_TX_125_MUX, "gmac1_tx_125_mux", 0, 2,
+		    JHB100_PER3CLK_GMAC1_SGMII_TX,
+		    JHB100_PER3CLK_CFG_125),
+	JH71X0__DIV(JHB100_PER3CLK_GMAC1_TX, "gmac1_tx", 50,
+		    JHB100_PER3CLK_GMAC1_TX_125_MUX),
+	JH71X0__MUX(JHB100_PER3CLK_GMAC1_RX_125_MUX, "gmac1_rx_125_mux", 0, 2,
+		    JHB100_PER3CLK_GMAC1_SGMII_RX,
+		    JHB100_PER3CLK_CFG_125),
+	JH71X0__DIV(JHB100_PER3CLK_GMAC1_RX, "gmac1_rx", 50,
+		    JHB100_PER3CLK_GMAC1_RX_125_MUX),
+	JH71X0__DIV(JHB100_PER3CLK_GMAC0_PTP_REF, "gmac0_ptp_ref", 2,
+		    JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0__DIV(JHB100_PER3CLK_GMAC0_RMII_PLL, "gmac0_rmii_pll", 2,
+		    JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0__MUX(JHB100_PER3CLK_GMAC0_RMII_MUX, "gmac0_rmii_mux", 0, 2,
+		    JHB100_PER3CLK_GMAC0_RMII_PLL,
+		    JHB100_PER3CLK_GMAC0_RMII_RCLKI),
+	JH71X0__DIV(JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2, "gmac0_rmii_mux_div2", 20,
+		    JHB100_PER3CLK_GMAC0_RMII_MUX),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_TX_I, "ether0_rmii_clk_tx_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_RX_I, "ether0_rmii_clk_rx_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_PTP_REF_I, "ether0_rmii_clk_ptp_ref_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_PTP_REF),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_RMII_I, "ether0_rmii_clk_rmii_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_CSR_I, "ether0_rmii_clk_csr_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_RMII_ACLK_I, "ether0_rmii_aclk_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_300),
+	JH71X0_GATE(JHB100_PER3CLK_GMAC0_RMII_RCLKO, "gmac0_rmii_rclko",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_PLL),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_I, "ether0_sgmii_clk_tx_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_TX),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_I, "ether0_sgmii_clk_rx_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_RX),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_125_I, "ether0_sgmii_clk_tx_125_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_TX_125_MUX),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_125_I, "ether0_sgmii_clk_rx_125_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_RX_125_MUX),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_PTP_REF_I, "ether0_sgmii_clk_ptp_ref_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_PTP_REF),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_REF_25_I, "ether0_sgmii_clk_ref_25_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_OSC),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_CSR_I, "ether0_sgmii_clk_csr_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_SGMII_ACLK_I, "ether0_sgmii_aclk_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_300),
+	JH71X0_GATE(JHB100_PER3CLK_ETHER0_SGMII_PHY_PCLK_I, "ether0_sgmii_phy_pclk_i",
+		    CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER3CLK_MAIN_ICG_EN_SENSORS_PERIPH3, "main_icg_en_sensors_periph3", 0,
+		    JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI0, "main_icg_en_peci0", 0,
+		    JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI1, "main_icg_en_peci1", 0,
+		    JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC0, "main_icg_en_gmac0",
+		    CLK_IS_CRITICAL, JHB100_PER3CLK_NCNOC_TARG),
+	JH71X0_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC1, "main_icg_en_gmac1",
+		    CLK_IS_CRITICAL, JHB100_PER3CLK_NCNOC_TARG),
+};
+
+static const struct jh71x0_crg_domain_info jhb100_per3crg_info = {
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
+	.probe = jh71x0_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per3",
+		.of_match_table = jhb100_per3crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_per3crg_driver);
-- 
2.25.1

