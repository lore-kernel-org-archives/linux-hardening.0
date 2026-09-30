Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9804F96B5;
	Wed, 30 Sep 2026 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773152; cv=fail; b=U1FJR0FSAR55gSDV+YnIoDoEAepR0wCRaenIhUa5fEkSAMX0tBdug5KUo5OxfnLWNFwdJjujx7UHDkKIzBqbR40sI+cz8R3bPsArNgsmLU04F+CdVa338PLkNGS0xVUnTCs19YqsZDx60Lr95Ezxo4OfoUlKp+hELgy2g8Fdqys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773152; c=relaxed/simple;
	bh=rYn/cJW8tSQa+KDEpS6q50PbBSbiMvQlzb5b9ZvI6xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KS5GkIBXStkbxpbOa9hcIlN14M31LT8GQv2aN137hNAaQbi/u1IbB9XWhv4v+PJmcmOvA8ps3Ew90egioRGnqOaefZcDgYzEIKCNwJep942y221p9+hpUVYiGOfnU+JRsdVFY0c7A6r6wtF3KWQB7aPgjp35OnprR5uuVsB2dr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E39MdTcYNhXzNmdOT73gzy5x3IpSIx6XTASAY5wXt3SxjGvOYF6L+9uYXj5qKvBLkTtwedN8qkfc3JYzP5okfMFs/Cg1qDuU/yLHrzurIZ7jcd0l6m9W8Jp/QVLUJQdbHk4IE9wKa+1MbdM0+2EYUuGt7PvABK1Iaf1dn1MNZB3OlUPM+Z2aInKuwQ4pF7wyyDh8keUiv+J95PjVwyO81f/c2EBXeCt04mNNxEdvCxVwSzy7C3r/yA/g690FZDRZowDBKRd/YqrEwvu7dLx73etOu9XQyOWIXzUYTDvK4REJn6Df0656OU3iYdfF9dGEm3ws5yuJKFmxOfrV+5vl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVAP0A4DWZs118KMBj2Dklk+ZnHLTOCgEFOzqnbhilI=;
 b=RNJGcVT8toJqHIbDNpvJtj1QLZtM7TE3p0jFkOboqoXAGQ8J/VlelwnagfYbGO+BYt2+35pPMICcSfaqc1/bDCNeauHiskgJMX19wn9yZB2M07ZRkRdlkrXeDmUYRRBVv6IBIVvfPom1+JCT9aVYhdmg7lRLH8AHEUy1YD0s6IkL5wTgJtee4cGh3SJMGSocxs9xiYuT3OTKK4LVv4qfuwwKLxr/+TD3CrADr91DtI6uO2MdZWz0EIAElxq72MJYWF69aXkQ3oFRQk9exap+kxmHuJCX+tVJOr5zgwbb/tACz4Xp07ln/E/9Tn8UAheaWo0gUG+tYflSeE8zLyP+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:47 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:47 +0000
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
Subject: [PATCH v5 08/23] clk: starfive: Add JHB100 System-1 clock generator driver
Date: Wed, 30 Sep 2026 05:43:02 -0700
Message-Id: <20260930124317.5648-9-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef8052e7-27f0-4823-0d82-08df1ef0783f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	sYoN0LnuEd2EVmSn+dwDMGnYmhUR1FKCXaQ7MXujkidl4OV0LgORgxx0wPXoc7qfqpwl4Wvwhm+dfwfc+AkNQQPjcA6isHcAln8jj9j4jqGIcsB8YOxlskLi20SrhsNFOi+MDLloKlqRZ496emdoDMS5BJW5yoFLqS+YQ86Bmq11KFE9+Jga+7BQpAitSDACv262LkaThCeo5awfAgZhYg0k2K8K5DDXbDlHxkpWzlv6BBST5MjCa4L+PCByynPfw2GQwWm24SGZUP/qKsHX4wepbhLZD+p0VyFuTG3MZV72Sdez18u/7JCpZAZAWLOmFSI6iWQPdksTOJL5anX+GU5GeGPCUn3D5TdJccdtadVSVSDIH7kPY7PwXfmeCSITkg6v2FYBQDgj7jf6NYDzyYY6a4gX6SwmrnpAOCdpYSQH4GvFOxvXBqotJsXx4OB1CyWyagXvWFExc9KQ7o4hooji4ud+EZpRn2qsAo7IatzN38OFbRPZXOFfZrAImgHs3kCC+tngvw12eNz5QqxYNTu1398riFXC99kO2KLepGXQezhW9gTq5xApaSPkcNEHWrxM8qYsizmqj9S6RSfAtg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DmXAO9x1z9HpWlRjherOMgstvieIrlwvoSWhJ4jHtoUkRY991kY6n7Z++7Wp?=
 =?us-ascii?Q?zZwD0+l3u1gn16TCVt1//iIXNCIC8SZaw73XsdiLA+vWGmIISpk/PEgnyu1U?=
 =?us-ascii?Q?icinHRpdXWOUhDf8omv03vB+vuCAgZRKj+FOjcpRv/7H8E99+mlhu39T25ut?=
 =?us-ascii?Q?ogJEgBkSJ8jdHxdUChGM5ZsuMLRD1wAHGdXuK5ygDZ67Do7yFs6OlXBRtFnx?=
 =?us-ascii?Q?p8/f/SE1OL+hsvvJaATaIQ4AHzNBiwcGDRxuQxPhXIGEeJqVCvPAB5wR/tB4?=
 =?us-ascii?Q?IQPeoW/sYZD0QaYTDTJ/cSo5tX1x+8TOBFbxpHvruz95nTKCVp1qJ2PtBYL/?=
 =?us-ascii?Q?bMs1aPTjajF1XCH/FxqsQegFLDrYlxf4J1Fz7mFvqyev7aw1DnUGtUsVC+vp?=
 =?us-ascii?Q?QzjZtN7/Rpxwy0BCzjohvXYWXecjMP2Sr6pPymfKyHoU4dnnLVXJnAXrcT+k?=
 =?us-ascii?Q?DORsm73bUbPoa6hv6LK7LJkph1PNJfL23mtDMzTduTGz9KGz9NlBBxNGZa9b?=
 =?us-ascii?Q?CYMSf8zicUmfbwQ4o3GfsqVpCHLhjLJOvJdPpN8r7aTO0DKhMWIGXIcbKTV0?=
 =?us-ascii?Q?4UCFNCdioldwkd0JLFyOFy6O3voXvgRvzPjuOGt2qNK7nnkwH0QIYgy2eSfK?=
 =?us-ascii?Q?eK/9jAHcwpY46ZaeyUyqFMcuBwzjR388Hm63HDFXiXGmilTMOQuog67QG57M?=
 =?us-ascii?Q?w2cXwCyMEll0Hw2TllolUzqf8tW9Qy1pzbVtL2zKnahp5J154OPxTa1TWZP4?=
 =?us-ascii?Q?9pfasCUfZZ0pMwpMYVsrauwBPly3+/PD4wp/95efhWHuhbOFXfp/XOnGZQZT?=
 =?us-ascii?Q?Lud2XWzonbodA5PU+dLKgcAPhnMZg637lu766VFgH28EbxxmKwohCYNvksOX?=
 =?us-ascii?Q?yXK1HGS5omE3wcMYPTCdWwWl6Nm19msUUdXUdXIinMRGbaeJuX6BWgVVC5Ls?=
 =?us-ascii?Q?Y1OmR6TaGExKlpXgq0NTdx0q01FsgqNz/l/wioFIEjprQR9wq5LCR0wZzL9b?=
 =?us-ascii?Q?fgdbZJlXfuUQOF2jkAzlz2gVnOYsaiKQPe75UeB0com8J00le22HNUqLWPgN?=
 =?us-ascii?Q?T+5quAXzlvs8OUhC8SZAemN7BzhrSee1KmJvzXkZB3x1HKhQAbSsJa47VKBg?=
 =?us-ascii?Q?s2dU55iBhkgcJ7YmINxoT5TkVV9aTL6+EImOTF98fPDKVBZ9nqsMZGJxg+zq?=
 =?us-ascii?Q?wfKm8gZV3gLX3TKgAX+K4lKPP4QTxqMyYuIGAaO5XTfVVAVArW8ALVhCKjfB?=
 =?us-ascii?Q?oimHx8PX1WMHew0gp6WB9iHv7iTIktfGkH7zRM87bmNRuHv8KhoQzIOzKXEp?=
 =?us-ascii?Q?pm6meM+CRNepMJ5lftY6orrmG/U6UjIGQ18igwnYO5S1KFUbucc38HcH4JAc?=
 =?us-ascii?Q?mnPyJzrwOYvDdFr6aejnhV6iyJAEmcgCsTbR26O67tndkvf4O/FjdZG3FWbJ?=
 =?us-ascii?Q?tVMct8OmchYuqzHHGDuZ43uYyFNC766uDVayqtLE71op7hh/+rb5PBvCA2Ys?=
 =?us-ascii?Q?QP0S3E18IaN/UJf7yasAnV9poEGa/IKUU+Q3/WXjZSaMSqWrzjKel+NWUfRp?=
 =?us-ascii?Q?HUzflSFUXoTEDFAI/rWlVhyLNmgU38QTI1rfSB1kQgoyDvCCct0SPMnmvHtg?=
 =?us-ascii?Q?DaMqrVTSopPsFAHES+PdT+lw+qU3oQAl4LRfFgiaEDuPb8D0NCmQmpIt2unP?=
 =?us-ascii?Q?L5Hy9e6ySeiAaXzqcMGrwA+9AwlIBC+ATZfr9pksHEbOpEK8gGkrxnhiZEPG?=
 =?us-ascii?Q?jL/R5hketZ+f4gIHO6yr6UFGt0eAvI5Al1e+n10smFlFEodzd9Oe?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8052e7-27f0-4823-0d82-08df1ef0783f
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:46.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXW131k5aAzcRh4T6eY0sU4B5OjApOusmwhZsPXVDS+CJTxG26aT3sr11e0bB2mSFHocuQnrIYwO6zAi+ABUW90oFwO2Gv5O4R0wBSshae7jqYpH1KplZGfN77zxf8lJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Add support for JHB100 System-1 clock generator (SYS1CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  10 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-sys1.c   | 105 ++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys1.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index cd5b7754403e..11da8bcc4046 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -82,3 +82,13 @@ config CLK_STARFIVE_JHB100_SYS0
 	help
 	  Say yes here to support the system-0 clock controller on the
 	  StarFive JHB100 SoC.
+
+config CLK_STARFIVE_JHB100_SYS1
+	bool "StarFive JHB100 system-1 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select CLK_STARFIVE_JH71X0
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-1 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index d2ba83d7d02c..0061550e0f7e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys1.c b/drivers/clk/starfive/clk-starfive-jhb100-sys1.c
new file mode 100644
index 000000000000..92e9c66ca0ff
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys1.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 System-1 Clock Driver
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
+#include "clk-starfive-jh71x0.h"
+
+#define JHB100_SYS1CLK_NUM_CLKS			(JHB100_SYS1CLK_BMCPER3_CFG_125 + 1)
+
+/* external clocks */
+#define JHB100_SYS1CLK_OSC			(JHB100_SYS1CLK_NUM_CLKS + 0)
+#define JHB100_SYS1CLK_PLL0			(JHB100_SYS1CLK_NUM_CLKS + 1)
+#define JHB100_SYS1CLK_PLL1			(JHB100_SYS1CLK_NUM_CLKS + 2)
+#define JHB100_SYS1CLK_PLL2			(JHB100_SYS1CLK_NUM_CLKS + 3)
+#define JHB100_SYS1CLK_PLL4			(JHB100_SYS1CLK_NUM_CLKS + 4)
+#define JHB100_SYS1CLK_PLL5			(JHB100_SYS1CLK_NUM_CLKS + 5)
+#define JHB100_SYS1CLK_NPU_NCNOC_INIT		(JHB100_SYS1CLK_NUM_CLKS + 6)
+
+static const char * const jhb100_sys1_ext_clk[] = {
+	"osc",
+	"pll0",
+	"pll1",
+	"pll2",
+	"pll4",
+	"pll5",
+	"npu_ncnoc_init",
+};
+
+static const struct jh71x0_clk_data jhb100_sys1crg_clk_data[] = {
+	/* root */
+	JH71X0__DIV(JHB100_SYS1CLK_APB_MAIN_SYS1, "apb_main_sys1", 12,
+		    JHB100_SYS1CLK_PLL1),
+	/* sensor */
+	JH71X0_GATE(JHB100_SYS1CLK_APB_SENSOR_ICG_BUF, "apb_sensor_icg_buf",
+		    CLK_IS_CRITICAL, JHB100_SYS1CLK_APB_MAIN_SYS1),
+	/* hostss1 */
+	JH71X0__DIV(JHB100_SYS1CLK_GPIO_ESPI1_EXT, "gpio_espi1_ext", 14,
+		    JHB100_SYS1CLK_PLL2),
+	JH71X0__DIV(JHB100_SYS1CLK_HOSTSS1_NCNOC_CFG, "hostss1_ncnoc_cfg", 12,
+		    JHB100_SYS1CLK_PLL1),
+	JH71X0_GATE(JHB100_SYS1CLK_HOSTSS1_PHY_SCAN_1000_ICG_BUF,
+		    "hostss1_phy_scan_1000_icg_buf", CLK_IS_CRITICAL,
+		    JHB100_SYS1CLK_PLL1),
+	/* npu */
+	JH71X0__DIV(JHB100_SYS1CLK_NPU_NCNOC_CFG, "npu_ncnoc_cfg", 6,
+		    JHB100_SYS1CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS1CLK_NPU_CORE_DIV, "npu_core_div", 10,
+		    JHB100_SYS1CLK_PLL0),
+	JH71X0_GATE(JHB100_SYS1CLK_DOM_NPU_CORE_CLK, "dom_npu_core_clk",
+		    CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_CORE_DIV),
+	JH71X0_GATE(JHB100_SYS1CLK_DOM_NPU_BUS_CLK, "dom_npu_bus_clk",
+		    CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_NCNOC_INIT),
+	JH71X0_GATE(JHB100_SYS1CLK_DOM_NPU_INIT_CLK, "dom_npu_init_clk",
+		    CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_NCNOC_CFG),
+	JH71X0_GATE(JHB100_SYS1CLK_DOM_NPU_OSC_CLK, "dom_npu_osc_clk",
+		    CLK_IS_CRITICAL, JHB100_SYS1CLK_OSC),
+	/* vout */
+	JH71X0__DIV(JHB100_SYS1CLK_VOUT_NCNOC_TARG, "vout_ncnoc_targ", 12,
+		    JHB100_SYS1CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS1CLK_VOUT_PIX0, "vout_pix0", 4,
+		    JHB100_SYS1CLK_PLL4),
+	JH71X0__DIV(JHB100_SYS1CLK_VOUT_PIX1, "vout_pix1", 4,
+		    JHB100_SYS1CLK_PLL5),
+	/* bmcperiph3 */
+	JH71X0__DIV(JHB100_SYS1CLK_BMCPER3_NCNOC_TARG, "bmcper3_ncnoc_targ", 12,
+		    JHB100_SYS1CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS1CLK_BMCPER3_CFG_125, "bmcper3_cfg_125", 10,
+		    JHB100_SYS1CLK_PLL1),
+};
+
+static const struct jh71x0_crg_domain_info jhb100_sys1crg_info = {
+	.clk_data	= jhb100_sys1crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_sys1crg_clk_data),
+	.ext_clk	= jhb100_sys1_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_sys1_ext_clk),
+	.rst_name	= "jhb100-r-sys1",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_sys1crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-sys1crg",
+		.data = &jhb100_sys1crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_sys1crg_driver = {
+	.probe = jh71x0_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-sys1",
+		.of_match_table = jhb100_sys1crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_sys1crg_driver);
-- 
2.25.1

