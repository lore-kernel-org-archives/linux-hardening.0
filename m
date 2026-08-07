Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE532B13E;
	Fri,  7 Aug 2026 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102262; cv=fail; b=h+jjLgW20e87DiI66tRP6dUP8omWF1xqC3bQ82oPqW9zgfv5r7eEmPcr9Ldhs8CWxAVjj3d/vawcM4lzvelqeEhbfPbBcLrKhNxCMf0hzXRRBglVwDyz+M+hZ5lGEPdwlEADO+Z6PKFyElligLsY+A01NkktwT2yLYpEg3XwLvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102262; c=relaxed/simple;
	bh=oHIM1Vsyq6rJmlf/O6dqg4yyz4y2eRtkcLnY0sn8SnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HdKCw1meE1cfKlrbIN0hw7WE8rn6Bu45uBfqKP0Uj4iOV+fTAnuTLRiS9hVTyIeGfuJEeqfxqJKl2BhcnMlk6OL8kBstAihEz7nS0Rx/Cd0EwfXvNi2Ij4Xqy5vXtEIr7sCTZQEjMI5z2WN2CDib4vreR0RKqH/l3s5Cow0R5SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEiDwARbEGPAgWl/LQk+/CCnroJhl9pTtiIpBNWe4Sf/058Rd3xUcVTIW9LNSjUUnmQyjSu2n8bYmNOJzMpCawnFu7INvqE6dFEYW/lQjQgsX5PUsEVwvnfZXS+jzb+2v513ar8b/r1UyIooVGO0XD43JC4xqnqlp9/WcK78B91BiRWOpIVv1SM9NGa9mGuomGhYhFd4kTqPHuTnrvEJwmic/TfazR798d8Zxvilq1SX/Mpz34SGqxhobWonJAiU9qFKXYnb3n6sMgk06l+dnG7modw1TBOa/NAfAEWLRvUsWaef6mpYexBA+O4DBL0ayCsMhDtVAehUG/D2YTOtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLp2UuMpIvckFv35N07aWi2jI8KkUy0mZM7krSOqBI8=;
 b=XROKFGbR8291uNhwXnnbTSpOvsy0x5xjYUfxpxIFislUqr2Kq0JIj4kFazqsABrgVq+2wh95ovKLb71XT3JZKz3mQnyWWgjB+l8Be7HH3NskjA+3uBiuE68X6bz55Af3dJzI1lnlleO+gd1fyjM2yotQksR1Xumit4trJU65syvRXXqNj5kFHwv7UocERBMSMyeRt20XjsSV2LZVN0fbhDKytvEkeXTNI2CzGjeFBlS/e/sBODAH9af2JGpaJ26UWDG9Cb2a680dAZpU8L/8VySSzKkWUp3wLvL4WvCVy6390GW8EJByOIp5QQedAVQJcxwLx/L3/wx3JyaQEwUh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:45 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:45 +0000
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
Subject: [PATCH v3 08/22] clk: starfive: Add JHB100 System-1 clock generator driver
Date: Fri,  7 Aug 2026 04:29:09 -0700
Message-Id: <20260807112923.191627-9-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0076809-647f-4de4-1210-08def4772e67
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MFIzKiMC2BQwnsV4pG2OR9RMs6fkHRNyX5IL5AjMVRyGMKjWsOYFmDwnWhIW8s/QTyUpYxtqTvQZSoRes8qz0hYSdgbvN9W8qNM8AQDMiNWG0HIKW3Gcdsdb8hJjErNpps4X01q8ua1Q2KNrZ14300uchbOcWegCE2JwuObLgtOZJETDEf4bNj+q8JrpqZBQKuuYdyEN5/t0mH/yP0++mVGHiMyOL/3JKVVua6Pvu674Mr1H5Cw3zSTTI23szItJ5yVhGIHJnRJjbdLmtG59CvuYcE0H8ZXrsTPICbI9l81XAgfZpWROm1pDOZswT82UCyv1jnrIKiwO/lljW4emNCaDIPsCHjbuxE8Inbs/FmogIV3F+kua51gqYFWslVDz5f6OihnRzBTq0URKQxZIYhqKxwnN/nf3r0FC/mOm/H1y7Q32fLzPrIsZp1SWOeDbRSC5CJt9fqYTry7DuEPa4RoVZYpljYwWx4x0WO5mIER1ISPky11qcpUY1u3iTtEEUpuEhQzPPjYFIrN0s4JXYjs9+4YHoXxwGCYqo7rQZg+QkVu2im5suD5XI2ZT3763VaRoXyt8vTt/ljZ8/K0HYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kzx6ZjYtmPBlOJ/SLZ+uopFH3HVdbCe3Z2gIv3uyadGUH5S01VbfYenkhYDT?=
 =?us-ascii?Q?q70oGwNGTlapEstY1pX6wJ7/FZIfEMrvBRVTGU1lq9KIp0aVVhFWKAwr6ahW?=
 =?us-ascii?Q?EiolVycu19sDMxFgR23ffNzx1F9sIlE/2+LdscVVC7/0OZQ3+N7GnI2aTvba?=
 =?us-ascii?Q?/Per/g2BAz1fok6QkKCq28fLKNn9iaWfiSRtNsuJGrMZX6RC/5gBOiBuU5RI?=
 =?us-ascii?Q?UZSF1BeSGtGztm7JhV+H9INahH4gyzJbYbhmei9MsQ7E9fb7l2SLA1WTbBxc?=
 =?us-ascii?Q?f7rdKwQ5PlqU89RpUdSKGdBd16imzQ3aq2rDaj/EuEB7I+4FgzMRS6KHGnOG?=
 =?us-ascii?Q?rja7PeR6GqZQE1PzQhtz3EK0zyN9URd4+fAbFkR0fLffNHSJseLBbuQsK9cj?=
 =?us-ascii?Q?fmbTgdP9mbMQJw02OQpKUNqpTS3oPeU5yOqnJL8VZ2TvwTuLz+Ja4MwZqq5l?=
 =?us-ascii?Q?HZhWJySYZd1JrX0171NSIb4oQMb0SJOiGkOdQoT8fGV+dSsYsscMXGqogOT1?=
 =?us-ascii?Q?9jx4/+A7dsJW5LU73fY/wa6WEgnHZ5nwBSUwA4Fl5foQEI9T2DZ2D4quswLM?=
 =?us-ascii?Q?tmw+dKWviSGZ4wvDo75C0q4cDy4SvwRPTyqrmYFGiTZ7Ed4FIVqCSUkVY+4u?=
 =?us-ascii?Q?f+45ZvNCESE7Pt/VwcbJF3qFHBPMzoRQqRRQ+fyBGUFsOuMfpK1sbBwxKn9c?=
 =?us-ascii?Q?DSTKz5+1rWSo3fnHyrsU8SfVGEFRoOkynca+Xls56hr4p1ogLkQX0UUYDFb0?=
 =?us-ascii?Q?1YpOpL5LINndoVlf26tFnJWm/NJjDYxgiZFFZoKRze/L+XuuxHldicdVJ5oa?=
 =?us-ascii?Q?F5/3GsqN+eTICaMnm9r3k79LMDEOue6OKSKYIYSa0qhzJJ4YQxREszGMrfcz?=
 =?us-ascii?Q?CBkINUZ2AUfHmvA1vhCFoUJrw5wYYiWWenxhKrn4QJz8xXNzYzCQscMZrQrv?=
 =?us-ascii?Q?mYNDDdbVKL4v3REMotNsRJeiRv6uxaamV/U1nWSnbXqQZIT5IJT/pXARyzeZ?=
 =?us-ascii?Q?yDTwLL9Eet17pnOixq0ENEPQdTNE6zmnMF3sxJ5tvnZqXXozzeqA35vy0qEq?=
 =?us-ascii?Q?t2GGfJMYJSwjcQRlioX4ev6kVImSdm99K+NXHKPXWphfTqxftVa0vroBt6KM?=
 =?us-ascii?Q?FCqkAP1ehF/iMjnjaEy+/s6F8A+jcN9FWuEXZVt1VQTvhu9l2aa2NyygoGZV?=
 =?us-ascii?Q?sErbMVNIG2Rn9Lx2DY1b7v0P06JLBVCPSuYi73apDEkMzarIzlvP+30eBUei?=
 =?us-ascii?Q?/G7fSVuDpQkrqxr7zyMMqIPWq+8xh7nYffbyBPSydKa68GIh7N3Uje8Xb/Qw?=
 =?us-ascii?Q?j1BzNJzCFyjtSir8/ij/En6uhJdRulbfr/gVHAm9/SeByf/LVt142v8IDhc9?=
 =?us-ascii?Q?b3HCrqh0OAkKvhfEQBDVJAcpUwpyP6pvXQArSVDvTEqITv65R7ir4oUF7wps?=
 =?us-ascii?Q?Cg8ewOm4V3gWalv+BwBqfwVCqQUzBEudNwLWi6jcWB0WElONaOsXAfd29UPw?=
 =?us-ascii?Q?PgL2y2ans7NPX0gMtnQQbyyRo87GhHYleo4wjEw3mTXVBykUzmvevXkIR4n6?=
 =?us-ascii?Q?lKzvrm1mTODAZ5+Jnoudl4aB2mCDvC5zz/z7ffE88/WHUwFnN3HCw3lw/oLU?=
 =?us-ascii?Q?HF6k2mjFWKVQuq/GXcrNvHQ+RjtYlmNM7boqPycUa0ZPtC1+Zgsy9f5LejbE?=
 =?us-ascii?Q?xoJHOm+kXGOY7bwTQhwH9SM6g0sI8dsj20e+yBHi6uLJLrhDWOB/IGr1Wybc?=
 =?us-ascii?Q?4bxVQLWlFYrqqWFUOkASxbIOrYljsrKy2wDVWlufQyKZTjBAbjHe?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0076809-647f-4de4-1210-08def4772e67
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:45.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E0z7vFZRSb2U4/7eFhv4itpK9QkhUov2HuzfX5Mt3z5VIYQPvrzUXROhgpWfx81o9oBWuComU9pg8gtGLBcwxYXFkNIJsvPLNsEOyrs5vBG+EmlGVmDVcwtCfsXppu4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

Add support for JHB100 System-1 clock generator (SYS1CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  11 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-sys1.c   | 105 ++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys1.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 7926e02ccd7d..798af23b9bcc 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -83,3 +83,14 @@ config CLK_STARFIVE_JHB100_SYS0
 	help
 	  Say yes here to support the system-0 clock controller on the
 	  StarFive JHB100 SoC.
+
+config CLK_STARFIVE_JHB100_SYS1
+	bool "StarFive JHB100 system-1 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-1 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 2c5e66d1d44e..b3571e2f0555 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys1.c b/drivers/clk/starfive/clk-starfive-jhb100-sys1.c
new file mode 100644
index 000000000000..d181bdd79253
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
+#include "clk-starfive-common.h"
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
+static const struct starfive_clk_data jhb100_sys1crg_clk_data[] = {
+	/* root */
+	STARFIVE__DIV(JHB100_SYS1CLK_APB_MAIN_SYS1, "apb_main_sys1", 12,
+		      JHB100_SYS1CLK_PLL1),
+	/* sensor */
+	STARFIVE_GATE(JHB100_SYS1CLK_APB_SENSOR_ICG_BUF, "apb_sensor_icg_buf",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_APB_MAIN_SYS1),
+	/* hostss1 */
+	STARFIVE__DIV(JHB100_SYS1CLK_GPIO_ESPI1_EXT, "gpio_espi1_ext", 14,
+		      JHB100_SYS1CLK_PLL2),
+	STARFIVE__DIV(JHB100_SYS1CLK_HOSTSS1_NCNOC_CFG, "hostss1_ncnoc_cfg", 12,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE_GATE(JHB100_SYS1CLK_HOSTSS1_PHY_SCAN_1000_ICG_BUF,
+		      "hostss1_phy_scan_1000_icg_buf", CLK_IS_CRITICAL,
+		      JHB100_SYS1CLK_PLL1),
+	/* npu */
+	STARFIVE__DIV(JHB100_SYS1CLK_NPU_NCNOC_CFG, "npu_ncnoc_cfg", 6,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS1CLK_NPU_CORE_DIV, "npu_core_div", 10,
+		      JHB100_SYS1CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_CORE_CLK, "dom_npu_core_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_CORE_DIV),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_BUS_CLK, "dom_npu_bus_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_NCNOC_INIT),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_INIT_CLK, "dom_npu_init_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_NPU_NCNOC_CFG),
+	STARFIVE_GATE(JHB100_SYS1CLK_DOM_NPU_OSC_CLK, "dom_npu_osc_clk",
+		      CLK_IS_CRITICAL, JHB100_SYS1CLK_OSC),
+	/* vout */
+	STARFIVE__DIV(JHB100_SYS1CLK_VOUT_NCNOC_TARG, "vout_ncnoc_targ", 12,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS1CLK_VOUT_PIX0, "vout_pix0", 4,
+		      JHB100_SYS1CLK_PLL4),
+	STARFIVE__DIV(JHB100_SYS1CLK_VOUT_PIX1, "vout_pix1", 4,
+		      JHB100_SYS1CLK_PLL5),
+	/* bmcperiph3 */
+	STARFIVE__DIV(JHB100_SYS1CLK_BMCPER3_NCNOC_TARG, "bmcper3_ncnoc_targ", 12,
+		      JHB100_SYS1CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS1CLK_BMCPER3_CFG_125, "bmcper3_cfg_125", 10,
+		      JHB100_SYS1CLK_PLL1),
+};
+
+static const struct starfive_crg_domain_info jhb100_sys1crg_info = {
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
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-sys1",
+		.of_match_table = jhb100_sys1crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_sys1crg_driver);
-- 
2.25.1

