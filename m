Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900424734F3;
	Fri,  7 Aug 2026 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102273; cv=fail; b=sCRhhyNYT8+qMHistY7IyFoX7Sx/caC7ug1E8kcT0LBJm/9+m3gl3p9t6icYSkj7sQEXce45/WWw3ufkg90BxOfUTeFkv+MoFlPR04IuM7aZ1AbT3fqVyVLbCCAOu6frXKxXWeNA4TM0c++jvSGBBErIfCyrkbnBmp4dgLzTqr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102273; c=relaxed/simple;
	bh=hanDe1c2c3BlHoUIFkWE9cTxqCb7cZy4BwQfyAd92pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MT70Hph1eyJ4S51qvqXHU0W9n+Nyq9pHQ6epudCEyzcjzxUbfjRcdrjaoZOZBtZKnMOf00qQEyJpVQgKDPAyQFaUGkiFNnqEBHjMoLAPOAQfaVqXSm7iY6sFie1Ndmzagl25vk6oVEftCPd0qdph2D6SgbA4Mv0Fi261Xql3Otk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhrWUfo5puOvU4wKA45FSSvCHFRtC7ifKMzUICfcvSHoFBwk1kHlKYXKZbx9QY2uX5PGWSdxIFqja6CiFyAD6Yl/HIAg3a/1lvohrzrfkRBojHOAC2TJM0zMxsXuXCXUvf3/lrptFyH6SUAahGmGJUEYYrAO/kCvvkVz58jEztbaI67QgfcICd8ofMkOZZBL94km/UNme6sOJCGYMQm+DWShTHFtCHAEwVbbfIaDXEF0YF76zghrOYt2ExK6L6zHwWZvaP+N0RJ60pN0ll9fbNhY0iuBak+ZYvSB5spB+frKeB2Asv6d3lciMfc+hkabtsIZNsRHH1qL3zYcTF5NuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3VI916n/13B114yV9jTzrZtVJU35fBJa2+1usjnR8Q=;
 b=hc5PPPrr+rEwv6Oxp9sF76qMIVvE++qeTIZf7x1Zh8N3bTDZFhJ3nqzdK2tlMBlXRiLeQhW0LiHF6V1VdKPun4sW5y8QNDPeIduACZUImvWbESc7rzydC7IUMe/150Qf2Jfg47PSwcxVRFb3RhAm41Y/1EIw5zDu8iJ/GyX/UTsrmm4+3bMpmmpx4eqAVGUWE1N0pywn5IY9Dio67lRRyC3oxF+Otbouztdg/j2dR1RZbWpYyrI9JoeFvYVwGn3sH4BJH49OVwyJXTnw+LGd1yl8KmZu2Hn1mOKag4eN+BAAHKzrmUGAwnkdDrG+G5tezXS786hWh/kvZkoUVFd/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:58 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:58 +0000
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
Subject: [PATCH v3 16/22] clk: starfive: Add StarFive JHB100 Peripheral-1 clock driver
Date: Fri,  7 Aug 2026 04:29:17 -0700
Message-Id: <20260807112923.191627-17-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20c4e920-3b6a-481a-19da-08def4773611
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l7mJfK8IuiwnomBggHpU99aGooi8tjdBhAFhKnV622TAM+s1XsjMrvKdM7QmVb6yzLugj80H2bt7rTxYmBqWfegIdIQwWTurRCEALkbPhfQUwv+cCR5YOjBijLBZJ9BKjEOh4et4IXvP7YU4ipzl4dRjHJ09yI3YhdvFpduuRzDpuus6T8YvpebZ52Xlm5GXc86nnwjuP+0UodtummmbnVdcBjTOVJoB6WZGfdw6lEexwMLBnV8BQljjE/ZNBkV6GDxP/rv1TDxpsYRwYxPIuKD3/DrufleoPyBJUYfQCHlHFrK5o7w1jqdBda/hEwrpUzmEcZx83jULtGq/z5l30E1fl2fOfvTLZLu2e5nN5Phl5NDM+wjIigNtbARYV3awqm+GfDO6ph8ZlgwgnvGukBiXgeeFuNNYb+Nrra4t9pf6BDBkqZ+FtutsgPzqxIuZtjSDnxF5QpsMZJE99NJU5heS7YZo0y8VBUP5LTQFGH0TRvQiGplvMgiTnRz1ZabDNWZ9WFmtf+sQRrxpgvLRAP6OYGcsbidqlmoP9hQ6ziA9vLlkFHX+htHxWGZ6BZNC0FAikXLbUHUzQdC1cUmCTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+h1M41u+Y9HwljM9HWSqha6kpX78IN2bz9iwdF946tzm/ZYmUbP9Pa++fHD?=
 =?us-ascii?Q?mEtzgnMg+uNg+Uka8UuAbmvxEqERpk7Vq2ONwRCl0UUK4oOEIy2jVQsu9gCj?=
 =?us-ascii?Q?s8mLXPv2J1RT31lPT0P0tt/8y0xy83Zx2QrTJwztWVlFcdu15OzKmYxQHkBL?=
 =?us-ascii?Q?a2JvP7ItC3VGXj0GNe90m9vFGh4Cd9u6+Di4DW6Nb4vAaETFgajWFgr/8pyz?=
 =?us-ascii?Q?dDFFXSKQKB4HVEzQtMhVaFCv7aBigBmPsvBFpYsXMQr/L7BmgxyUsi5UGYuh?=
 =?us-ascii?Q?hqtVKoOBERd3Ppep1fONie7d6zMAq4+c/Kj7yqVDlAr7ych8NsSkAfSOz+/o?=
 =?us-ascii?Q?gW+MKF2TKowlqzPC+9djy3yr5urMyp0voOKBRYcGebDT3k48PkajGIp+pHvE?=
 =?us-ascii?Q?Dx9dkMoxnAC+ghQ3d3xsiVB4kHebN+A6WY0yo7mE+hrVP/9UrPXODtf+vOZt?=
 =?us-ascii?Q?MHNG93ztkKI9YIochkfouGpw4k5RjLrLTRQe/W9qYGcy0iE0AFvozvpXoECF?=
 =?us-ascii?Q?fUOr2KdjBFSOfXyPyTQ/XaWc4AIw/c/v99+FBFtrn2l2xFau/LS2bKSQqRCC?=
 =?us-ascii?Q?M1ZxcHXSit9aSQ4np+v4i44p3cSjMyfC1NeVemsH3YrmWTMElV2xF1tp9B3Q?=
 =?us-ascii?Q?wFKXYAx/k66uVlqJ4nNtly37shlaK9CXbiKTIs1ypPJA514xcsKKkN64Ez/9?=
 =?us-ascii?Q?5hA2lxmWSmTV+//Fjz6hMZNebTpd5ncxXncranCvp5xIasw+Y65Z+tKaY3a3?=
 =?us-ascii?Q?5eTAE38MLYkKQIzU5Yo/qugzPXe45yTVCnVU2zKJSwsPvDF4vPxtHJBP8B0y?=
 =?us-ascii?Q?xE2Zmf2vXI/YsIp1c2L/FhM0z3YFhjl6kt5EGaZIm5++TsJzOCa5gELHVQyJ?=
 =?us-ascii?Q?DGcejHyh/BOSSfo1wtYQ1duSLtnRf87EMAKfsDvsKeUQTUUUfNJjqbl071GN?=
 =?us-ascii?Q?hrNLK+7ePmCYxxQcKrHBVuW0vFVE2/0x5I7FhDpDx/3TCKRc8zRNJ6BoTuqX?=
 =?us-ascii?Q?+F8z10W07KobNU4AeDysPetC6bilLwRKcdMxjIsB+DtKSiz6BLyE4X2DbR+C?=
 =?us-ascii?Q?toCHYLAbmU2plpd5pz4M0ZdeBHv9NwaSsNf1vkNKuou1GooeaW+qQ6WTyiS1?=
 =?us-ascii?Q?pkOJ404CI0az1WP+4s9KxS+llNZZ0u4qP78mZ2fS2YAByH3ebk35nvMghGfJ?=
 =?us-ascii?Q?MVYxU2WK7oO08TriRLEG3+wi8sG5xJTAMrKsMxvsSL33+7QOA66lHagAO7GR?=
 =?us-ascii?Q?0sVQhUnKf6dWZj8FeDd+aV2VSc9l0qB6udguUDNFpTp1NmBXaClELrPA7Yba?=
 =?us-ascii?Q?iYPvUlpQjUOYIOxt+UQcStiyeDEBxKhJVa2OxUBc3J8IDaGSJAAeZG4E6RaY?=
 =?us-ascii?Q?4eGe3uEkeMDL5t5oqU8Ftz34quGrOQFaZ1sOf9DxmHYqu7FB5F28JKvlbqmK?=
 =?us-ascii?Q?hRF8NalFLQcDLCABJ2+ofwuCX7JeTkC6FVF4b2ZViUCUWJUf3Tee8tt7zLI7?=
 =?us-ascii?Q?JTRBmbNA1FQPcte388F5mLBZVx57qo4P1Z1yjKmNcuEQ5oJMbLnOBuX50TAt?=
 =?us-ascii?Q?w7Dd6BwG/h0v0C1EJf8/6yvXY10Q2Csj0zHq+NY4YU14sLawvkLvTQGZDQvP?=
 =?us-ascii?Q?yIVbWZHjYBagD2NzbMDF40Zk8vv+4Zmve26Z3DXjHTQF8UdT9QP9U7cZZ8iZ?=
 =?us-ascii?Q?V1KVCDj7XTkPordR/qb3YRhBL4bDdjeUcQef+mSSXdX2h7l0/a65x/zqt7D0?=
 =?us-ascii?Q?Tzl9SSoTLQmTAkF7mOGczeJcI/lE2MK9CHsnYUGBktIALJ8T7gsQ?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c4e920-3b6a-481a-19da-08def4773611
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:57.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHrRj5rPdwSA0BqX6cjZVmBO1C//syKGMbX39ucyWvS2gHlxpMdwHNJSN8CNdXOwfttsz2reOkJXyYatzkmJy3IuTAZRD+MBLzUGoje1wY2WaQPwvG7BveFGbL8szXQl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

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

