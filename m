Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CA3815E1;
	Sun, 20 Sep 2026 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905682; cv=fail; b=AxVwSKTO6rSFX3qdZ+1Ku+daNGQKVLBdpDqQbZxehd4CU8AyxZ7PfdeW1jxhXzEeRyucRN00NjsfL8q//y1tMUFNuimZiK0PGagfe8qWVR1IXt1sSlyy8YhfVu1geAYWf+B/mfn4szV42NQ7hZMq28jwm4ycQcLjHT4hZWZSpN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905682; c=relaxed/simple;
	bh=hanDe1c2c3BlHoUIFkWE9cTxqCb7cZy4BwQfyAd92pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VT/sR/9kl6hHEfAET85rDNZZseZ6vdsFP5vzZLijX8riT34gsimAXp8DVjZ75fbbhDDVmIhybZhhC6tiHXXtoPoTm7n83nP8auN+O14dTAU5DvlNKeKSwmHO/mCCrJFDq6+ldptAqZ1xAAd4GHoe69leFDUqZ+bIuxCuB0WlHVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIsr6uoqjB3xnnhLpGvh2ZSDwjMniy3BtMNfEy0uYYNGsu3FgAypR6WKhCiRSQfi3MN/CQtQX3V1vm+yuWgdjipng3fcH6CXOZ59Y4R3q1bxkvpjRRY9YM8HwiPoOypQQVIy0c7sQs24SGwaCe3jqEm+n7hH5T1jSnCrQPPaSa6G8kosbYHPUqbYG+GJKZVhnvbApQ9zCsz12f9IS0NncOa0EAq593sVNcysaZE0vvA7EP7QOKxV+NwnRDo6wg80d2Pw4Ti1/NVQ5BZEpRgzK9kUnUbV5VW2kLr1/yWQgqWoxcFUhq1hyfm6dO+EB9jIvVJcP2jjLJr84SGDfjRAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3VI916n/13B114yV9jTzrZtVJU35fBJa2+1usjnR8Q=;
 b=KwI4DnldsdDMtIhquwal6rZx2y0nlyWHz5n5S3Vs2x4/2gKcWj7Fzf3i4auk/yqvtbih+6Ht9OOoBCatmibXK85E7ky7dA+XP/RRIQSEd5gShUQN4WLVQAfLK1rKAJzOal2DTM6WbFB3iSjH6gC6yr+CaM04A4XsIBeWNIf/DDjAyjEAGeza2fUVOJ0QM5TEgLHCaxcP/Nqjq6ppkQCcotZLfikxMydE9o0bUEt42iB3z9/ymNdYvTqn0ypfTaPNRFK3Utn2+iQkGJ1KgtGxiGRQFYie95gCQQtFqMW6hJSC4JePBGXiDR3FPFh0v4JEqIM/QFnWmq93ir/Wy5hrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 12:01:07 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:07 +0000
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
Subject: [PATCH v4 16/22] clk: starfive: Add StarFive JHB100 Peripheral-1 clock driver
Date: Sun, 20 Sep 2026 05:00:38 -0700
Message-Id: <20260920120044.194901-17-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 70b418ee-166a-4372-b281-08df170edac0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|23010399003|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	VTASDN/BtW1z5fOYeadbK2qBp0o8ff+gw1hMawoJXUfKBQo0V6JiGMjiE+n8SrKQ0PyL+uf+pq/He/A76ssf19a5Pa8tQ/MxHcqHXF/qOqXtbB//byG+6BsqpHZ7q5jlqdihu+hQdLG+qPL4Ch0/KbGXIgpt3kc86Xww6NQ9LShQ5Fx/JNZORiXsJ+WK98cMTM7SJwcfwOhCRdTm00gBHAwHANMx2MxlMCyKjO0ZOBxSZFg907VI+/DBWuXZEHmMj/DhAXl3U8JOTEfTV4fK/iKIYywBgVj/cWEpzGOKg3hxBlJswV64fNLJTsrnAZYBuEpPvBjowKcgOVRgU2QsABOdGhKbPdMNEGxjve2C+4NNsnhK9R9Tlc5Q2ccHozvs12fZxaY6/Z74P9/VoKBi3UhiG6ll9u0kaoahN1mrAjFIbiVrlS3gZurTLnb8ugXP8nD77cFMXtWmSLvyR9xVg0s6tvk76evrTd/+L4feloWbpqIWQIgOIKKzs+y/UaLQd5kjLp4mHM6RfRZSiYvK6RMyl7ziO8jubw94Blp+R9vWi2cwnifO2pdo9meamwXtB/6MW6BeWNfqVE3MSFFayA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y7/1Szv48p3Je9xx3kvtWEI6xX3QkjjQ+UK6DlzL8QV14+3hxanuLJ8XsMGN?=
 =?us-ascii?Q?z8fX0p0wTp3FFbCcqaLPM+C9uS/6iR48wB9kGCeSVQjINcryuib3pn8p/mFc?=
 =?us-ascii?Q?SphiWgwofM07rsmwhB9WyVzLduLwqSlQAqbCkr9XNzOfEuWHAm/YdFXQiWEQ?=
 =?us-ascii?Q?za/pgNp/N01bVhOutkZxIvUdJH9/e6bc56+27HD4/J81Ro9GwqA5ocLUe+YG?=
 =?us-ascii?Q?x/XzB0UPFA1EDLv8Fxx0FfrmVhFmTE+HrpsJs7T+WWGTQscooN1Tj49mQlur?=
 =?us-ascii?Q?HTKUUkOKZaAGzbP7nzI1qdVTDvM34y14kcUhiZ1I6PTHWaUX72xRix8DsPDz?=
 =?us-ascii?Q?Kpuvx0z/X8YJUQrGhuT35ziu9VKSjuPa54DxGvt/GgWaJxkfArwf3Shf6TXR?=
 =?us-ascii?Q?EKptJDWWTbJXgbVcqtVhXEzM5hkaqDh64MtkLRw7xQKXVDgADtnYKNxZts1D?=
 =?us-ascii?Q?W+epyXxIoInWRJUf3QU29wUcfBpD0jWk/Mowhk+ArHQ95aJPNa2Q0GfMgp9S?=
 =?us-ascii?Q?X+1bl0ThVOX3qlZCxInQjkaOOOij86GJP+QjwFKIHn9H6cB5AVVVMc8Tyc3Z?=
 =?us-ascii?Q?/Mw51gOv+dOn2hjcqnh8p4tv3O4PO0TQZCUMvyXW6ZsWy7SmFqr+GxPsB1V+?=
 =?us-ascii?Q?B2MssXYgC9Y3AyptymP0uW/pIOfBc58iKtYTszYl3/ld0tsZifGhM3Q95ZrB?=
 =?us-ascii?Q?/ROZwDZfa9OIvMuWwJWStzC22EYZaROCpVQfUOe6ubBGrAOZynKRXMTf6djm?=
 =?us-ascii?Q?sDE58yFSfPRR/J7RKTY5Tb4RCyQPhfP5GO/EBQ94vDSmweFRpnvCdmsQHypn?=
 =?us-ascii?Q?stGMluKSGdBpBdt94IQex7R1EJTKYaut6pXfmNvcstYsn9HcYSQuNvX7DQEr?=
 =?us-ascii?Q?9exkWC5Sm2/LouHD0AGppUd0dTMXrSNl0G1mENVuExKwy77XcmNuMZOipQlW?=
 =?us-ascii?Q?KBYvJuz1Oa8ja0Rs9MyjGsTxhMJOfIicw/GcnXPPGqgtqKrANLsER245MyYp?=
 =?us-ascii?Q?9YVLR3CV/hqVOQF7yglTDfpqYTjluw7ga3+8Y6jseuFPc55oqfYnzynAU13y?=
 =?us-ascii?Q?D5vn/mCkl1Rjns1sM6RvXDbIO2k877KOY27dK/x/OCfeejyYE0zLd3j5+8b9?=
 =?us-ascii?Q?ZQMtOmXxMiGeNtWnE0ixCOd2T2U6HanQcq1mYJjsy/n3acAev5WdYnorf+2A?=
 =?us-ascii?Q?JrQkdGtHCJeOTq51NpVjaAeFiB5fo6Y/P+whlCeH/PCgrnSCGypptWsQg/e+?=
 =?us-ascii?Q?duf5BysQ7gW22CWMaa226pzBc5qSzYpP61mQgZxXjK9akdSOYKat4AAUpgtG?=
 =?us-ascii?Q?jVWArPc2bGXX1M7yPWSeBqoPgC4JpNdcImyahR3uZTuJYZ/NxjxzRQHU7JZI?=
 =?us-ascii?Q?kaYlNDC4qb21ptztRVRf7B+fcPyQKgJDL4Ml68dw8aw5u4BO0lZSge+4GgdE?=
 =?us-ascii?Q?/xwvZCEZgkt/gzESsHDqcGiLnx5W9y+ffJHpibvI1ZsrPkUWyNtv1dTZz+Pm?=
 =?us-ascii?Q?i9NiD4dakNHFpY6HEtUqmSKsIJHQQpQNCeNGBCoySwY24EnBpabWG+e6Apkw?=
 =?us-ascii?Q?yhWqSUOyeH3zehNb3ubQXaEyEnPzuhaY90lxbNWg9zWAxP42v9Gd5zW7pAt1?=
 =?us-ascii?Q?YcSjJDrMk+sVR5oIcXbiLNZ7Gz47QcvLVjllmQZ3SVu8Jpgq2z3wZiXluCqs?=
 =?us-ascii?Q?VKvhgMxO5vZ150w2Lf+l3/DLXKDpsM4kvo+KFHj8hgPCmilB4ZtdSTMTAFbh?=
 =?us-ascii?Q?tFeLA8QNbYmp/4Xo4sH24ZBBqKLvuSBNFjVC0kaqpGx3fl5Nyu26?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b418ee-166a-4372-b281-08df170edac0
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:07.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQwO1WsDaOEd2h7fhB7jbBJs3wYaXZBgU+bt1x0O8GbLw6V+6PjV9hNGFsO57VwcvTyy9LWX/sKn1bhCEY4OJdQ30+1BTIaetZWtnaWPsAYkGBtIxflrsPZfUJrf+U8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

Add driver for the StarFive JHB100 Peripheral-1 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  11 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per1.c   | 149 ++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per1.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 8fff853f0c44..8a427e958659 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -84,6 +84,17 @@ config CLK_STARFIVE_JHB100_PER0
 	  Say yes here to support the peripheral-0 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER1
+	bool "StarFive JHB100 peripheral-1 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
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
index 2f605d0fd6da..51511086a727 100644
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
index 000000000000..656b17e538d6
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
+#include "clk-starfive-common.h"
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
+static const struct starfive_clk_data jhb100_per1crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER1CLK_100, "per1_100", 8, JHB100_PER1CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER1CLK_1, "per1_1", 100, JHB100_PER1CLK_100),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN0, "200_divn0", 256,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN1, "200_divn1", 256,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN2, "200_divn2", 256,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_DIVN3, "200_divn3", 256,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_200_CCLK_DIV, "200_cclk_div", 2046,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO0_PCLK, "sgpio0_pclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO0_DCLK, "sgpio0_dclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO1_PCLK, "sgpio1_pclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_SGPIO1_DCLK, "sgpio1_dclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_EMMC0_BCLK, "emmc0_bclk", CLK_IGNORE_UNUSED,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_EMMC0_CCLK, "emmc0_cclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC1_1CH_CORE, "dmac1_1ch_core", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC1_1CH_ACLK, "dmac1_1ch_aclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC2_1CH_CORE, "dmac2_1ch_core", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC2_1CH_ACLK, "dmac2_1ch_aclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC3_1CH_CORE, "dmac3_1ch_core", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC3_1CH_ACLK, "dmac3_1ch_aclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC0_2CH_CORE, "dmac0_2ch_core", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_DMAC0_2CH_ACLK, "dmac0_2ch_aclk", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_REF, "ufs_ref", 75,
+		      JHB100_PER1CLK_PLL7),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_300, "ufs_300", 2,
+		      JHB100_PER1CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_150, "ufs_150", 12,
+		      JHB100_PER1CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_400, "ufs_400", 2,
+		      JHB100_PER1CLK_CFG_800),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_75, "ufs_75", 2,
+		      JHB100_PER1CLK_UFS_150),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_37_5, "ufs_37_5", 2,
+		      JHB100_PER1CLK_UFS_75),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_7_5, "ufs_7_5", 10,
+		      JHB100_PER1CLK_UFS_75),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_1_875, "ufs_1_875", 4,
+		      JHB100_PER1CLK_UFS_7_5),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_7_143, "ufs_7_143", 20,
+		      JHB100_PER1CLK_CFG_143),
+	STARFIVE__DIV(JHB100_PER1CLK_UFS_3_5715, "ufs_3_5715", 2,
+		      JHB100_PER1CLK_UFS_7_143),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC0, "main_icg_en_sfc0", CLK_IS_CRITICAL,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC1, "main_icg_en_sfc1", CLK_IS_CRITICAL,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SFC2, "main_icg_en_sfc2", CLK_IS_CRITICAL,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SPI0, "main_icg_en_spi0", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_EMMC0, "main_icg_en_emmc0", 0,
+		      JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SGPIO0, "main_icg_en_sgpio0", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SGPIO1, "main_icg_en_sgpio1", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_SENSORS_PERIPH1, "main_icg_en_sensors_periph1", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC0, "main_icg_en_dmac_sfc0",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC1, "main_icg_en_dmac_sfc1",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC2, "main_icg_en_dmac_sfc2",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SPI0, "main_icg_en_dmac_spi0",
+		      CLK_IS_CRITICAL, JHB100_PER1CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_RAS, "main_icg_en_ras", 0,
+		      JHB100_PER1CLK_100),
+	STARFIVE_GATE(JHB100_PER1CLK_MAIN_ICG_EN_UFS, "main_icg_en_ufs", 0,
+		      JHB100_PER1CLK_100),
+};
+
+static const struct starfive_crg_domain_info jhb100_per1crg_info = {
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
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per1",
+		.of_match_table = jhb100_per1crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_per1crg_driver);
-- 
2.25.1

