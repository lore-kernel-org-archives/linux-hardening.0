Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711E474266;
	Fri,  7 Aug 2026 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102276; cv=fail; b=o43Vi+dt07tO+Jk2X66ljvtFWJibThtwswbzqK7yzkSSTCcPXmXDxh7UZDYqCPxFmH/puF8mFGdsY21lBspyN9MwGS4mSsTS7tR+idcIq6Z+rK1XyR7NCb/J4Xy9MdCpLRT87Hd+yFu5ypiA3wHp3EHfy4XYH8e86+oZ/UBso9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102276; c=relaxed/simple;
	bh=4c2tguKbN72+Kui35+0qgYScuBnV8S1QImjxFyUsELo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPE6fZlCos0q9wXpxVwglSsYDGJdkTnPtPtfGFrC6lBZG8uF/il8gTyzKd3/86IDBxR00mAz4Ct9xY/vDmx4KqTuxvPMk6AB6mZNxvHhW9/+uF1j6kcoUN6Owvonorrai1SihsEsp5O9+EcwLCrfyjzUMPpXH2tNouw5PqBYyJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A17tzQ2P7M0XU2RsVVb+BDrhCeUw7VLTa7mreQPlSvVyqyNU1n9IzIYX5XQXKtjbpHH4kqybWWBKwjIhhdXrAijbrh6JWXjz3Ihcb8wneUQyKUbC5SjIcNsB/SzQzjsn1rJP79jyadYFEe/RlqeVbbQHQeVKSvpZzrHN0LtEMBkrFX0gzjrGr1f/wdWCF2fXQP4shLXAz4/c3zF5B5ocYarnj8KTenS5oDE29tYKz57ZjWUPMwruJkrTPvl6io1c21SatDf2LegoxqRUQa4JyVwhx96vNkx7QadIQEYa8GuPTFMjMFHVRID4s14NzqEGZrFE23jSxSC3k3OLsroqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3Ddowv8uBqIH7UJ0zjPT1sATUe53KR2IPjXJujLF3M=;
 b=SjNkkSXXt9BmoH17knNvFCWniwuOc7uqOaouFx6PAHf+Yud3s8IQe0MKdvVU9HWsKWF9z/machQLrPZm8wk1g7fuDnAEx2CZAtjeC1Ye1aoVicyqTkkVeVP61fIEWyFZFHByVEMF9rt5W8dgMfQ8hIedPWNYzgZOQ6Xqd9vRIAnOOvIBpb4cjAtSSf3Lkc8GMo6DZOrfoEsvOJWFr8GsHc0nY8Zs+NVGbf+MQtQCuo9fa8LE7iMxlPuNWSgxHK4cpELu6hB6Jxf2ALgBlvypI0+0SEDR9tyJ+P/pt+SZWDRNKyOutc1eafQnFsqocyQcVs9xLzc4BI2e5tDjpWeNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:30:01 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:30:01 +0000
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
Subject: [PATCH v3 18/22] clk: starfive: Add StarFive JHB100 Peripheral-2 clock driver
Date: Fri,  7 Aug 2026 04:29:19 -0700
Message-Id: <20260807112923.191627-19-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: affdaebd-f2bb-4b80-672f-08def47737fb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q2z1WSGuJFo1LV07CCvS8xY2XcL5HAt7EjOpaMjeZrYoyyEIp9bvsKseJd4vtPUGBTMf/bidPj5jq/TWm/0k3Fq/Da33ZjliNy3enXUzRcPU+Ee4jFem6MUsgy2VQs3nfOxVlxKgb62U+oG+GNBPq3q2ku8imRuKV3Zb+cfduw8MlFFPmu4l5Pi4c3JdoR7Q1y6YkNyuZYYCPz4bJEdUe8UqqKtoCNQsLNbTYEBa1beSfxeFFJOhDpghFsTh06X2XFaVsJ0SOpxfvklUeR8GqhLez8X4YW1pmbVIh4kCsTesjOBE+T/tk+5p54unUakqB+4DHjo4le9n8cwaRCkdLgEVFcNRwybrOpV1jA9jdnCBiphzOUF6EgNMyB7QNWMAn6x/k8ggwyZy6vWKMwFwXmGxXfTF0F9foJCGTw5nu+JU5mubJg1YyF5O7z4/WsYxA9icGT63Jx1w+Omt8IKnBPIBQquceHrFiOPqnP2MeAIaOhiJzHHIUf58qQSYRNzG/0KpNUYEu0k+6+4qY1j6ERBmSmGVeBBS7sNKHl3LXpVR9lNfaqm4CcOXbYh50tAVNLsFdkyiz6pJcxZmNm3iGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Idw0FEH+VYiOU1fb+EsvIKTdaKlP7ORhPZ1cJMaY9cDNa7tdKkNlA1P8AOg?=
 =?us-ascii?Q?UmTK0PkwENS3LmEN/ErSi/WPeWiEBFuaBwNzpX+6VxNoZliVpqWdGAoTEZSS?=
 =?us-ascii?Q?ruhVVlCd5mnx5rZiresdHrMYWlVzn0gc8DOngJrumarI5lxG+lUnA4Y7T3wI?=
 =?us-ascii?Q?4UNJ9RGFs8KI6ommdPVj7oZyN0yuHIhpvSDhBg61J9YdjjKMZNAnnrj1pyEA?=
 =?us-ascii?Q?I+bt5Mf32qwDIuELhJ3Swh5TA5qIQtPmu2AQhPjyskeS4CZr9K3dVGcfzcCp?=
 =?us-ascii?Q?IIr73iHcyFxdUvx15BHB7LEf7OdpuRQ6ZZCHXw8NkXeSLpFG6B30ma+z09KK?=
 =?us-ascii?Q?r3lIXDqm/PynoHF+sRjg7Rz1iY4xkoqITTZh7mAZmAEnf81zp36tXhHmCdTD?=
 =?us-ascii?Q?DuotKkv0n/ipostvDuG3oU3mOAYO5eKVWrSoraZyXzrqMi8VaT/PnMZGkQRc?=
 =?us-ascii?Q?jUFXC2kevqMlliAEdcUT/NNrPyIQCBLDVGpchFAozd4RHEVKXILQ9jCCX2MY?=
 =?us-ascii?Q?kP70JVgOpWRlZSVy6ruPw7jrS0Isn0AGnQmTpbTmfcr1yNyAGioK+67BBn+v?=
 =?us-ascii?Q?/p85ALV2fof2Bt1AIAgEYh9jcakgwtUOmZ+BdR5DPs8s1GRNcR9/awl/UZX0?=
 =?us-ascii?Q?Opkc8652djMsJU2AbDmGwMzuf93vGHQxyXYQU+AMv3D4TzMQbl31Hk00rnBC?=
 =?us-ascii?Q?C2pJVnNhNDYr9PVAGFHXXhKe4DPQPkOVHDGNVEYQv9GOW8HPze8QldtDZCKO?=
 =?us-ascii?Q?0/pLw1jZ1U7SnnzRXWK42QRXNcBqbevfSTY7Wqm9vM4btgJJ0mofZecKWEMs?=
 =?us-ascii?Q?utB+jJm578fMcmMis00YHKFnzUK4+brhrP+Zt5USAtIC8ptB+fN6Terj6QtR?=
 =?us-ascii?Q?oQZ9yAuC94Oh6nMDRmJPTkIZbgScY+FLYFU5ZR6lXKVLgeSksddK8JEnxFaQ?=
 =?us-ascii?Q?E3VMc7Fd3qPD0nTqpKT8Y7vTTcieYEiQti2dYxbMhQASuY0mu2zXH1YVeuig?=
 =?us-ascii?Q?SeBg1AFVfOyrZHmq4TohMNnMFTWEP3dvSypUi8N9x5XGK80gqRg2ZHnsSWyR?=
 =?us-ascii?Q?zlYJtLVkT3EwYi5HL/H16tOdGGXYHPRV6KPv3l6/Sv8KDo13amMaHoThX7nr?=
 =?us-ascii?Q?5uxSUAOiNlCKmTilOigQxNG9Xfxj1DHadxKDZVS8wS/pWY49c4JdsraFXk+a?=
 =?us-ascii?Q?ZqN6tSIXpGPrpcSl5P9mSh/3FDXZVvQ8AYLb5c9QcnVI014monucwb2JZn2z?=
 =?us-ascii?Q?rxFGp0sskj9TNZUyXsVcUMSzFFLG9aeAWfedOHNg6iQ7tiRaYJ3pei4BPvmD?=
 =?us-ascii?Q?lnJorjxOVo1hC7GjA2775HuwC3qDoGFhKi/E4tDHc6DIkcRgwryij+G5W9KC?=
 =?us-ascii?Q?gNWffXhEb0iWfdjPM/mh3ZV2XavoPVnpUPikUpfe3+OrWI3W/mQMmJII8QSy?=
 =?us-ascii?Q?FeB/t1HMiq+VXd2l1LoxMq3oTsfsrW0FktUo/2a/duXwxHzuArmkOR4gC1ss?=
 =?us-ascii?Q?Ppb07R46nf+0AqrzfDchG2eTHXes6L2E7ttNlP9jfI8EM4k1Da4i5D4bgBZF?=
 =?us-ascii?Q?CvrPZx8FiWfOofwPjQPJvE3CNoMpfeekk8XNBgI2LlERX7iNedbbH/Izby36?=
 =?us-ascii?Q?EI9lI6FHwPIBmackiGuAwEPxrzejNk+bEfX5D0b5xY0w5qLseHLJggoxzpCB?=
 =?us-ascii?Q?BMmiIoGVagvhFdJ6tbUsOuUJN3Wq61OcyYa9fHsHe542VUmCq5Nul0JnysTd?=
 =?us-ascii?Q?qKCzPiE5ykJjSLCgW1cJ7aib9A+wqap1Owu0X9MeVF14V8FlafsZ?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affdaebd-f2bb-4b80-672f-08def47737fb
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:30:01.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrnKgspBjvX0BJv59vywosTDfrtHgVBsm9rkNMND/sb5Ma9T0OVUr2oWW60dWrwwL+SyGzIVptmnqM/HA96O0txa6wOCUwMh0H1lz0mGsDVlY0QUksU7H4RgCR/QDJ7l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

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

