Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1FB4D9908;
	Wed, 30 Sep 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773106; cv=fail; b=et5u/hbMZDur1A1DjaJHCy2kkD/O3/fJ1VhTfcCt/9X/0j0MDkSaNigIuNBHXNmuo3e9rpQn7sNrVidL5i4otUykITUa0Jmp5uYitbG+3LFbpOJniRFNH8yWDmZjhC0Eqpq1oN9ELyA9xKD57fhWKnVJAh+hK4Pkg3wnN/QaKlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773106; c=relaxed/simple;
	bh=+O2TQLsiSOsSg8m6okzSHR41QEZ4NrFl7FzeIPtSfsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nj0zynu8au1Pv9tZDfEKUCdYyRq2gQSz1VQncIbDPOHpFqxoFX87Kb60IVhcx3kI/ZLGfJLNKpLORSCJbb8aHD0R/ZKWcdxqLIYWaxVR+XXOJV3QA0eKMX7FTSfNwgipPgzriwSEt7J8zq/RGuNzaVPjj0pTik7KIVbsB9zcf7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGK+MnBtOWCKMgRPgr8YjYKEEQnMpuqdrd87hH2vPkZsZb/5s6rfNkMswzIF4JHh/BD5zMxHLGC/uGPYrGiq3aPdvlXKUnndkzHjowV32hlUzAEKl0gVTGSBGobXna4ijkaEDeEegCSMdIIgsWHjAlJ4tQzTA3vjrs4cHtcogtR7lOm/DY3mf2R32kOYIgE4TtXtkNuCxhJnU+hxu9FG2OntIo9GBNYajocezyU9jrdsncyiOWQ2QYJ0cmegAVMjSKgB+NqCX3VWdjdX1YDSTeMWeT7/UeWPET7vGYgWPukK71YghAU0LOhZ6WvYNGqi41hgL3NFR2koE6++w9wqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZwYDJo83ezLnhukv47Yo6blagdUcZSjD55kh8HYC4Y=;
 b=cq2ueQDAkdpatIxMhYk5kRyDgJka5ahuz0o/D1YJMX/XLYipVE0O0qi6WOSUjXNgLIXA8ie5PBD/OR46xZK4lWakGXATab5cfscHxkpeDwfL+q2mRmNMq2PElU7J5MKPlzyanUzpHlcfPNZmob6aKu65UNsCApmq3uOyDHh63L8oVaaz8bUGBR/oR7W5pwunWfGPNN/2AyGbiL7wTNwFaguDlDAmqNhP+SEl7ia2iMXw9GAnS29rkZ/vohqStt2fR1o4OJpsSKu/BWBA3nvXVBZV7vfH6YyNPsjHoIAK0E2Bta1gnpBqrzlT3BsXyQLL5ruY7CNVDFCen3tHG+yfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:50 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:50 +0000
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
Subject: [PATCH v5 10/23] clk: starfive: Add JHB100 System-2 clock generator driver
Date: Wed, 30 Sep 2026 05:43:04 -0700
Message-Id: <20260930124317.5648-11-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3dd74554-51c6-44ff-e212-08df1ef07a5b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	pyME4yh+kzPMU9jRPPLIKOmrVgQxZPxco2aakivj5nhaKZKPsnqNcCEEqPoUPtkZxAVzj2PH3sO9C5bvLtwqSYdsehVFkKbMTrbORBtvCS9UlTbOkYI9rDiz7/B76/qD6ENYuzUAqNTTVWAbZrvLTNr3XKxeLWnvvhQ1g/XtuNJSpAl++oqSym7IW03Z5GD+AnQsPiUANmo7mjWgnE3vysBXUhpFqCoU7c0TiqZuph88v/fu2MnEntAhjJhBnb2bSlMu+u2w6NgEdQjdXO3qCqYBuYVtHqhZ7Jn2x5Q8C8U71suowCB7Wg1pKgej7HYMbHudUMuLICDR8a3j2kzVFGeCfE0Y3qkRwiLwDx3paKiKZaIgEJN1MAbDfpCc9yK1tdSGdJBST9/gKW72Maa762zVv6P1fc9rv1J7/f8bKnrz4Ay3+3Fm7+OdmWJQEmw/bdzQ+JaYL+rgXHOkOpdJy3MypLfWd13ugKzsP32rVC1O77gR8g3SGmlAc3ccj1XEsmgidYqUOP8WocdPBfE63WOg6hmRQnCdf3pwyTtu3T0iawfkIpOP98s+Nmq1eLd/pGw41mTNlH2L9tsRNbRzuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MsRIOsw62Qa1Js7rA2/YFKSfmJ2StYcA/wS4P6UYXWLkqSW/jIeBUUMwrDYl?=
 =?us-ascii?Q?T24JXcstVUtyyJWbLeVjSv1Cf1bt6HxmdypdY54S6lXJ1VgB5Q7ccSfg7eGn?=
 =?us-ascii?Q?4z1ex2k4msMRY2rahtFUWfDpFCuutj6X/pRZkl/eC38Y674e82HfV/iBK3AE?=
 =?us-ascii?Q?kyhFmEH+/tvYjvg6QxBIel1VdzdziP17kXhXp7egIH4k7gR5AvgUkJ8mxiJV?=
 =?us-ascii?Q?41QCFUGSrR/HGCC8twIz/fClCjNMeWt/GLu/CJlwrdHxLOQlj2E8t07j6UdK?=
 =?us-ascii?Q?fMyccCjN7dm1cKWVSxCvrJ1xxq7mhnU5H2rJ75kPzD+TSz2HtDxd8IizZAhQ?=
 =?us-ascii?Q?WNcVyoEXzYv9m+1SMoSrSkdx0k+gWrQ3WGVaDuBtJBWGAvYrAjJiCXdeYI4D?=
 =?us-ascii?Q?d72InFM+gmXHeieYBmJnEmEDx6dnaHgSNxptSp7sWP86g1xQIhkr8mnBgDdt?=
 =?us-ascii?Q?N6JDBonPWKfa74FmAgu1sm+cjALJ4bvJEtESmTmemxFzBqWmAk0jayzVm7ln?=
 =?us-ascii?Q?zrlH4rziTuDwtW6bgOklYrY19NPGMS6m5AiA4PjvMJ18CjmeyqgQi8VZqmQu?=
 =?us-ascii?Q?1+m2coRDfEwelGieKdaSaiYFmyhRqyDK/XES6tdQDGaBE9zpe8AgZufAkerv?=
 =?us-ascii?Q?95Tz9Bzr2EFYJWIH2nMiS/Ws+8aYxhDuLV6Ca5DsF98+W7PjTflPrNIZOXdk?=
 =?us-ascii?Q?CCL/rX3Ay6SXbmN5TDDpDU4VH0WxysWMJNpxCSvsj4FAxZXgB8rzOgv2W8ni?=
 =?us-ascii?Q?jGMS6gnniZbGrXDqDVLII+wLSmBbBepqy0qNr3CCR42zazNFIUZQOsJbpxdh?=
 =?us-ascii?Q?rkTt02i1nVF3I3Jq9JwOfAv02/AOOOaUgvQVHdpu9Ff2quyjjy+db1yBnRD/?=
 =?us-ascii?Q?FfyeZ/ft3pq+kAMw5yt6Q3BX/7UzkktsdJntWQOybEA+8SAgPk6x0x39uPJ5?=
 =?us-ascii?Q?OVe+UOnvLNOTbUWQjzcq6qvnJX/R4VPvnHF6orEe0dgHt9OzB6stwgvOcX4P?=
 =?us-ascii?Q?vYtTPOZjE9oMaQGNUjbSYeHWnrlQY7LHbggfbMgxOBspyEymlnJRbws9r0SK?=
 =?us-ascii?Q?rRSzP3Mfi8+lNPP9r0OF8N5IWR7XT5Lz/QTKhjEHhLtjTBqzwfRIHZIg1cM6?=
 =?us-ascii?Q?yoxyXNbUkemTLq29k50wXnMJYC6RepqpvU3oJNcKmYcxZGatjLgDEYkYw50c?=
 =?us-ascii?Q?pVPWM81XNj3b9YdUEYkGbKnhUNuItEXDtU9r37q8/YsK61J2dVoTkUGZuSGh?=
 =?us-ascii?Q?lX44zmS4LHFURcW5X2+GcmklmbI8vnQusCRVWGGIki/XwO6Dg9I5/URHLeBr?=
 =?us-ascii?Q?ZhkX7Un7a2eyE1bdusySr9wFSZ50K0VOAu/VJBcaajJayxJ2Q5iUycPoFnFO?=
 =?us-ascii?Q?lTkRjEpU3O8vDH80iOvnfi/8JJ1CDhn9VH9vcCGSOWtIHrw9hVJS5r0mepWs?=
 =?us-ascii?Q?qDQNuaS6QfvrRBl6PDmlzioCr/NPNFL88LzIWCFWlWQCndX82cyh5zjHFzIc?=
 =?us-ascii?Q?KVqpy8I2AT4Y26MjjjJdYGSfpFZ73l/t37tYyy0cZSJX5qwu74NsrEZH4UpJ?=
 =?us-ascii?Q?0IE5Kw9XCgTNhQG9bxQq7nctmM5V35raeC0XQETy7BISYtcJIUE+t/puwbTe?=
 =?us-ascii?Q?ulX7QjcsRQO+EA2WLY/R2aM+SlwN7ibHONUfInMWnDgbsEhyHMY8wjY39NuC?=
 =?us-ascii?Q?XEonOPQaKPY2JyMJ4gVx4790fVIaE2Pd9kiG/5Yp6/6Mkb+oBsEhJnYEYC/z?=
 =?us-ascii?Q?v+x8mH6FfZE9XvkRPXiAf+5RoEt0RXboOLHrp8BdYM+Z5a3I6GTP?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd74554-51c6-44ff-e212-08df1ef07a5b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:50.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeaQd4mf2ATLHCS+4OQjXcw0c560/ozI2sxQvV/tTUcehvQpcvsIspLOGZdjyZfEUL+NSqdTrQ4WRMmSGmDk0YKJgf4OzLbwdFBN0gcm+ymRQVGxIyWgBIXUXx6PrbMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Add support for JHB100 System-2 clock generator (SYS2CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  10 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-sys2.c   | 129 ++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 11da8bcc4046..cfaac934a8e0 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -92,3 +92,13 @@ config CLK_STARFIVE_JHB100_SYS1
 	help
 	  Say yes here to support the system-1 clock controller on the
 	  StarFive JHB100 SoC.
+
+config CLK_STARFIVE_JHB100_SYS2
+	bool "StarFive JHB100 system-2 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select CLK_STARFIVE_JH71X0
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-2 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 0061550e0f7e..29cdef20575e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys2.c b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
new file mode 100644
index 000000000000..a2c7e8eba9b6
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
+#include "clk-starfive-jh71x0.h"
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
+static const struct jh71x0_clk_data jhb100_sys2crg_clk_data[] = {
+	/* jtag mst*/
+	JH71X0__DIV(JHB100_SYS2CLK_JTAGM0_HCLK, "jtagm0_hclk", 6,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS2CLK_JTAGM1_HCLK, "jtagm1_hclk", 6,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS2CLK_JTAGM0_ATPG, "jtagm0_ATPG", 12,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS2CLK_JTAGM1_ATPG, "jtagm1_ATPG", 12,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS2CLK_JTAGM0_ATPG_TCLOCK, "jtagm0_atpg_tclock", 2,
+		    JHB100_SYS2CLK_JTAGM0_ATPG),
+	JH71X0__DIV(JHB100_SYS2CLK_JTAGM1_ATPG_TCLOCK, "jtagm1_atpg_tclock", 2,
+		    JHB100_SYS2CLK_JTAGM1_ATPG),
+	JH71X0_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_HCLK, "jtag0_mst_wrap_hclk",
+		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_HCLK),
+	JH71X0_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_CLK_JTAG, "jtag0_mst_wrap_clk_jtag",
+		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_HCLK),
+	JH71X0_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_APB_PCLK, "jtag0_mst_wrap_apb_pclk",
+		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_ATPG),
+	JH71X0_GATE(JHB100_SYS2CLK_JTAG0_MST_WRAP_ATPG_TCLOCK, "jtag0_mst_wrap_atpg_tclock",
+		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM0_ATPG),
+	JH71X0_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_HCLK, "jtag1_mst_wrap_hclk",
+		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_HCLK),
+	JH71X0_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_CLK_JTAG, "jtag1_mst_wrap_clk_jtag",
+		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_HCLK),
+	JH71X0_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_APB_PCLK, "jtag1_mst_wrap_apb_pclk",
+		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_ATPG),
+	JH71X0_GATE(JHB100_SYS2CLK_JTAG1_MST_WRAP_ATPG_TCLOCK, "jtag1_mst_wrap_atpg_tclock",
+		    CLK_IGNORE_UNUSED, JHB100_SYS2CLK_JTAGM1_ATPG),
+	/* hostusbcmn */
+	JH71X0__DIV(JHB100_SYS2CLK_HOSTUSB_NCNOC_TARG, "hostusb_ncnoc_targ", 12,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS2CLK_HOSTUSBCMN_CFG_500, "hostusbcmn_cfg_500", 4,
+		    JHB100_SYS2CLK_PLL1),
+	/* bmcperiph1 */
+	JH71X0__DIV(JHB100_SYS2CLK_BMCPER1_NCNOC_TARG, "bmcper1_ncnoc_targ", 6,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS2CLK_BMCPER1_CFG_250, "bmcper1_cfg_250", 5,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS2CLK_BMCPER1_CFG_143_DFT, "bmcper1_cfg_143_dft", 8,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0_GATE(JHB100_SYS2CLK_BMCPER1_CFG_143, "bmcper1_cfg_143", CLK_IS_CRITICAL,
+		    JHB100_SYS2CLK_BMCPER1_CFG_143_DFT),
+	/* bmcperiph0 */
+	JH71X0__DIV(JHB100_SYS2CLK_BMCPER0_NCNOC_TARG, "bmcper0_ncnoc_targ", 6,
+		    JHB100_SYS2CLK_PLL1),
+	/* gpu0 */
+	JH71X0__DIV(JHB100_SYS2CLK_GPU0_NCNOC_TARG, "gpu0_ncnoc_targ", 12,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0_GATE(JHB100_SYS2CLK_GPU0_BUS_CLK, "gpu0_bus_clk", CLK_IS_CRITICAL,
+		    JHB100_SYS2CLK_GPU0_NCNOC_INIT),
+	JH71X0_GATE(JHB100_SYS2CLK_GPU0_APB_CLK, "gpu0_apb_clk", CLK_IS_CRITICAL,
+		    JHB100_SYS2CLK_GPU0_NCNOC_TARG),
+	JH71X0_GATE(JHB100_SYS2CLK_GPU0_OSC_CLK, "gpu0_osc_clk", CLK_IS_CRITICAL,
+		    JHB100_SYS2CLK_OSC),
+	/* gpu1 */
+	JH71X0__DIV(JHB100_SYS2CLK_GPU1_NCNOC_TARG, "gpu1_ncnoc_targ", 12,
+		    JHB100_SYS2CLK_PLL1),
+	JH71X0_GATE(JHB100_SYS2CLK_GPU1_BUS_CLK, "gpu1_bus_clk", CLK_IS_CRITICAL,
+		    JHB100_SYS2CLK_GPU1_NCNOC_INIT),
+	JH71X0_GATE(JHB100_SYS2CLK_GPU1_APB_CLK, "gpu1_apb_clk", CLK_IS_CRITICAL,
+		    JHB100_SYS2CLK_GPU1_NCNOC_TARG),
+	JH71X0_GATE(JHB100_SYS2CLK_GPU1_OSC_CLK, "gpu1_osc_clk", CLK_IS_CRITICAL,
+		    JHB100_SYS2CLK_OSC),
+	/* main icg */
+	JH71X0_GATE(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG0, "main_icg_en_jtag0", 0,
+		    JHB100_SYS2CLK_JTAGM0_HCLK),
+	JH71X0_GATE(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1, "main_icg_en_jtag1", 0,
+		    JHB100_SYS2CLK_JTAGM1_HCLK),
+};
+
+static const struct jh71x0_crg_domain_info jhb100_sys2crg_info = {
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
+	.probe = jh71x0_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-sys2",
+		.of_match_table = jhb100_sys2crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_sys2crg_driver);
-- 
2.25.1

