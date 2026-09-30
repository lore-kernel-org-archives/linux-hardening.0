Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F94E0B75;
	Wed, 30 Sep 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772257; cv=fail; b=EKMFIWTnWmmGfAMexggkqifhZbRFrSso1ndlPqcPkdhJpByVmPVUBi8b0F3VZmYfGcajysAJETzOhi11uJnzFC57rUxLfcydkjFzR1tsfJgrjtIs20PihGatZ1VUgV2mleqwe0xN5mdTbpzyKclTV28JNgntnKkbkxB3ZIZrWIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772257; c=relaxed/simple;
	bh=tNFJPOS9WDbJc989nByiD5Dm5yPtWCvY65kywVK7u+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hh3PNreT4YAPPmm+W1dft0nHv6DCdHSZ5OXqwxIRoXGjNx/fu4YEvz+X5UeQCQC1RfPE2qKl3LLrbxi+rgdjQFG6WdGEieo5P8faa6BJmd5tip/ITi49xtANfFl7h1wIMmbMrRoXt2JlR1fW7zY4DzYcaXeZ/jzfB7exBnCqmGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt0HlgWy1UWVckNOc0fskAHPgZ33qDwzktxaeoArmWYETL0ElSGVUOSN7YcABH7A2xdyQum2zurnfaOeSu+lNR7XxVlvYAz9nImGf2sYWSxUFcZ5Jb/EQWEV/sv2vzsbBLk9Ni3o1qPHDVDjapLC5Ocd5mQtZViG7kqDd/8/2MfbDS6VKytGvHgmx2GSjaW4H9oBDhpwLvV+SrZ3l8Skw66rAV5ZLNbkiAKR2Ze+F/nfyC7s6r0yQGZdI/kH8z9Nt4gIccFu2wSepWQ+5St2pAEatg6yrfbGMsI2WeUzdpYlqZtH+bksR3EdmI+RUi7d5/Ecxyns9B6XstwYClT6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1+WVtVBqxIl1b4TrR/x98ze+iBEyINhsGL/wj1d4jQ=;
 b=MrTpT1aO0V6Fq18ari/dJGQx2g2caF5mOBk4akjxfiPUDGpB+Uidbm1IEhxVblcnGhZ63TG75WGhvsS7i6LtvyWSNzkb/zq4y9xkEZT4vy/4ahjv2KhIS3Wprp8UqCTheBO5XFTNeUjg3u2mZQfmqtxEZAgrfcsUjg8sJBYrIKLAeZdhKTv0cVeouLS0xMzpQ1yupuLBTV4M4Ys4VME65AzWiU5e0ZZL4eFw0bxjj5O2eDyyKMFgPD2OVM9nUT38sI+0H7QTMHkdswBqGbLWXw3XrRWDmRwXGMUMvpekr4Kw3iL29zYQkjO/WJGnONMR9jyO1kI6l0cIOr0/03JM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1297.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:43 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:43 +0000
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
Subject: [PATCH v5 06/23] clk: starfive: Add JHB100 System-0 clock generator driver
Date: Wed, 30 Sep 2026 05:43:00 -0700
Message-Id: <20260930124317.5648-7-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1297:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8a1905-281b-4826-7ac4-08df1ef07635
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|52116014|10067099003|56012099006|3023799007|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	htsRrLBNc+QismKiHawrqYaUW7wr5XAaN4iy34KzGQ0WuHWspNdUwQoj/qo68zOc8vUBEAq2v9ubR63TWALBZSFKWJY6gTk6fd8/ceXHQBkvgEAErwVDxPoVFi/ysQlOcpHypdVdvb7EEdohV0Iz7JpUpoK2Jw1OMTZsObscy0TQJ9U4eQ65x4EjIc8Nc46Xo/Tz76ZYJZyMBa/DjP6rk7oz09/fe8WBjHwpnJL2AK5WCRYDYTeALUAJGvZkf+Ks76fbr7LG09RldZa5atmVwp4FnxBD1UBA2K6fwJb3gdEAo750za7f05GE6a6n+xsXWYpa64hFGfzyhv5nCaTuMk3GMYKJT5MOdMZDLMmTVDwTm6w9jbSaQxBIaYF+jxHXa2Iqy+xKy0M0wbwqV4oevfHSrIMLm6oOQveufjLEOtYArWnTu8twuuULzRCdLutFsJu/0zIGHfWwcnqkXRDDKvp9h+2Rnv/hdOjst5i1RQN2Ly7EMKtwTv8JwM3zRSfZlFhxSKn2VgDVQrcxJc19fhfbdeCe9j88PqR8+vtSS2LHPxUQO026iVr0CMwtxksK0zvaE+abRIaI7yZ1GoXs8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yhTlugv82/vfBr+tuCSXTt6knKzblJBTaDTl/RbddTx+FJ8o/mNfF0Dj0guo?=
 =?us-ascii?Q?aOGWmnJfoeXwXGxX67Psvdy+MKVAkPAOSrcmTt/ZDCy/27Qe7eYxNkxcM7eF?=
 =?us-ascii?Q?Z9wL9uHFlYTUBmN5LT0g/ynN1iJL6vnMTIhLgPNVP4vnwEA0kOjx2R4JySMu?=
 =?us-ascii?Q?JzkyWgiXXs5hauz3qWZCLWdYSTDyHqSkVCCER4XzLneuhm8VjipfDIaWycGF?=
 =?us-ascii?Q?TKYwbz2iehjj22SR/5GYH/vOYwkWFJ9dsj7gQeFzTmjZesuRbSTk+4mLu4Jt?=
 =?us-ascii?Q?yfARSso2cEBMXg6ihK80CFKvK8h894mN/ppFS/4Ten+2Kh6/k+kcIeHry6DO?=
 =?us-ascii?Q?FjDU3M0tNQQ0VBn9RwIMmnEwoO2UQhZTrxgul0rOI5yn9Uc/Tj30x2DsfRvM?=
 =?us-ascii?Q?RsaH4D47JidzlVJ7JWZislfT6oVLKj450nj8P57OoiX6G6+piSrxt21Ci2rD?=
 =?us-ascii?Q?sNKXr9KHAjSHvrHQ1JrkLz5PajuOxCT8aoqb+G7S7MNJJHEErG66g+em432j?=
 =?us-ascii?Q?7CCKrWejkQAYyvBkrBNhZDWIZYBALr45FeYbYVEDRPwIZpqoSfBQANclk2h+?=
 =?us-ascii?Q?frEX/Wk8eX26Th0zLb7dEo5qp5Pz3i2rS/nAY0lOhIjQSuYH1NENSwL9VHvl?=
 =?us-ascii?Q?AQwLMq6s3D8XuIv1GAxh0nL9rXeK89oFVwOmW4TbLgFtdL9gBLntcdS2Xd41?=
 =?us-ascii?Q?bMUfKsE6115yy6k93j+Hl7r2OndMTr89+sG4xZCZ+nTNbLmP2PiaDkCbv+AN?=
 =?us-ascii?Q?Kn8fflaMHkXgVQo0tWdD//Oz1wlDC2RJhaBbi4IWVyuzaMGMezNWN9MPmpa/?=
 =?us-ascii?Q?32HWvio696jp7Kkp+VNq7/R05dFK73NQ+rwudSck48JYjo6XelsS7Mj6DXDg?=
 =?us-ascii?Q?X9AteTF51AQlPdNmaMFZHehGH3XSSBX4h7wjmpDYxJKOXafHZhFm7hT0iq+y?=
 =?us-ascii?Q?NxsZDEtiiqRLiCB9TBMeWPqRad04UBeXUztthZ94ctRLZVG0HZTFoBP0ebBa?=
 =?us-ascii?Q?qKbABoSxVdeqxMTFRoknIUotnsCxPq/82YBH/7P3lcQmFZA3iejx6egTi80p?=
 =?us-ascii?Q?Wr1c4b13f+8APtK1sXa7XyhDxEJ0MVGSn4XS5wKL+b8+32mIOXJ3lfogB+4+?=
 =?us-ascii?Q?THA5OIvX0EXc7SmMZjV6NSlvhWaG6GRrsXZkYdDYX2vAzg2F5SKh4aV5xIkF?=
 =?us-ascii?Q?7fCnS/EQ/wSKLdCsCMCnNPkWX6GI12+TlRrIf9OlAu01N3dSjNc/Zmgnsu3H?=
 =?us-ascii?Q?QqaahfYlJRO2wHAUMNTL8HTrGOnveJDd7pAQM5g/AKYaZocrTrlQgvxIE821?=
 =?us-ascii?Q?EwFmcsD8Ksse2VaSx3Py8/GyLFrPbNlzwjfD8Ob0MnszfyeB5Li2sIU04oTH?=
 =?us-ascii?Q?x4SNv3cDS5aaQ1wA2TCyVYhGRlPvgs6vJ034CeOHVxe4Byn8ptae/F1XfUf8?=
 =?us-ascii?Q?lF8jAG6SHAUzPYNbhy95oXVhHr/jPjAjMvMJ/zk8Cg1N4WEivJJW5fFXFRCc?=
 =?us-ascii?Q?TqG92SLdwmSAHkmV5AjmT3r9gE9IhoABeCVVyG3C185X+A2aNduNnRXyAB5z?=
 =?us-ascii?Q?PTKu1r86TxHiRswER2j47usj/FuT9Ne8PKogGr2lvakHXMHYdgREfdDSgSsr?=
 =?us-ascii?Q?7zaYyUjCsHSKMptfQMv1AomQ6CZd+yK/a07YJoLy49Gi0RciuYa0pQ0ir/aU?=
 =?us-ascii?Q?cVps3BQhr+tUu1I7vlNIR8IBiay+ie6oz37KfmltGJEecLxtxgCnOonDIvVu?=
 =?us-ascii?Q?XCVTvXRXb7aWmfepuuIa61pPIdOPBGEkSbfnSSXsr9yxMhyPqu/2?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8a1905-281b-4826-7ac4-08df1ef07635
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:43.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvdchssQk/ltOWykvv8XC6YJzIlDyQLBCR9eu/zsJYX2VYlb9lZAF3vsmGxgfEgQUCTE9uyIublJn6IGIbPfs8vNhLRo2gkN7xbXv+S9oV6JFInEZLcn0U6ysjna4LJE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1297

Add support for JHB100 System-0 clock generator (SYS0CRG).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                                   |   7 +
 drivers/clk/starfive/Kconfig                  |  10 ++
 drivers/clk/starfive/Makefile                 |   2 +
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 150 ++++++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c9f542965ec5..d22078bcf488 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26217,6 +26217,13 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JHB100 CLOCK DRIVERS
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/clock/starfive,jhb1*.yaml
+F:	drivers/clk/starfive/clk-starfive-jhb1*
+F:	include/dt-bindings/clock/starfive,jhb1*.h
+
 STARFIVE JHB100 DEVICETREES
 M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 L:	linux-riscv@lists.infradead.org
diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 51716655554f..cd5b7754403e 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -72,3 +72,13 @@ config CLK_STARFIVE_JH7110_VOUT
 	help
 	  Say yes here to support the Video-Output clock controller
 	  on the StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JHB100_SYS0
+	bool "StarFive JHB100 system-0 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select CLK_STARFIVE_JH71X0
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-0 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 199ac0f37a2f..d2ba83d7d02c 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
+
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys0.c b/drivers/clk/starfive/clk-starfive-jhb100-sys0.c
new file mode 100644
index 000000000000..498afb787311
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys0.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 System-0 Clock Driver
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
+#define JHB100_SYS0CLK_NUM_CLKS			(JHB100_SYS0CLK_GPU1_NCNOC_INIT + 1)
+
+/* external clocks */
+#define JHB100_SYS0CLK_OSC			(JHB100_SYS0CLK_NUM_CLKS + 0)
+#define JHB100_SYS0CLK_PLL0			(JHB100_SYS0CLK_NUM_CLKS + 1)
+#define JHB100_SYS0CLK_PLL1			(JHB100_SYS0CLK_NUM_CLKS + 2)
+#define JHB100_SYS0CLK_PLL2			(JHB100_SYS0CLK_NUM_CLKS + 3)
+
+static const char * const jhb100_sys0_ext_clk[] = {
+	"osc",
+	"pll0",
+	"pll1",
+	"pll2",
+};
+
+static const struct jh71x0_clk_data jhb100_sys0crg_clk_data[] = {
+	/* bmcpcierp */
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN, "bmcpcierp_ncnoc_main", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG, "bmcpcierp_ncnoc_cfg", 12,
+		    JHB100_SYS0CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS0CLK_PCIE_REF_CML, "pcie_ref_cml", 24,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_DATA_INIT, "bmcpcierp_ncnoc_data_init",
+		    CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN),
+	JH71X0_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG_INIT, "bmcpcierp_ncnoc_cfg_init",
+		    CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG),
+	JH71X0_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_TARG, "bmcpcierp_ncnoc_targ",
+		    CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN),
+	JH71X0_GATE(JHB100_SYS0CLK_BMCPCIERP_PCU, "bmcpcierp_pcu",
+		    CLK_IS_CRITICAL, JHB100_SYS0CLK_OSC),
+	/* hostss0 */
+	JH71X0__DIV(JHB100_SYS0CLK_HOSTSS0_NCNOC_CFG, "hostss0_ncnoc_cfg", 12,
+		    JHB100_SYS0CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS0CLK_HOSTSS0_NCNOC_DATA, "hostss0_ncnoc_data", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_HOSTSS0_PHY_SCAN_400, "hostss0_phy_scan_400", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_GPIO_ESPI0_EXT, "gpio_espi0_ext", 14,
+		    JHB100_SYS0CLK_PLL2),
+	/* bmcusb */
+	JH71X0__DIV(JHB100_SYS0CLK_BMCUSB_NCNOC_INIT, "bmcusb_ncnoc_init", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_BMCUSB_NCNOC_TARG, "bmcusb_ncnoc_targ", 6,
+		    JHB100_SYS0CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS0CLK_BMCUSB_SCANCLK, "bmcusb_scanclk", 5,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0_GATE(JHB100_SYS0CLK_BMCUSB_480M_SCANCLK, "bmcusb_480m_scanclk",
+		    CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCUSB_SCANCLK),
+	/* vce */
+	JH71X0__DIV(JHB100_SYS0CLK_VCE_NCNOC_INIT, "vce_ncnoc_init", 10,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_VCE_NCNOC_TARG, "vce_ncnoc_targ", 12,
+		    JHB100_SYS0CLK_PLL1),
+	/* bmcperiph2 */
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER2_NCNOC_INIT, "bmcper2_ncnoc_init", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER2_NCNOC_TARG, "bmcper2_ncnoc_targ", 12,
+		    JHB100_SYS0CLK_PLL1),
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER2_CFG_400, "bmcper2_cfg_400", 8,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER2_CFG_125, "bmcper2_cfg_125", 10,
+		    JHB100_SYS0CLK_PLL1),
+	/* hostss1 */
+	JH71X0__DIV(JHB100_SYS0CLK_HOSTSS1_NCNOC_DATA, "hostss1_ncnoc_data", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400, "hostss1_phy_scan_400", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0_GATE(JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400_ICG_BUF,
+		    "hostss1_phy_scan_400_icg_buf", CLK_IS_CRITICAL,
+		    JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400),
+	/* npu */
+	JH71X0__DIV(JHB100_SYS0CLK_NPU_NCNOC_INIT, "npu_ncnoc_init", 6,
+		    JHB100_SYS0CLK_PLL0),
+	/* vout */
+	JH71X0__DIV(JHB100_SYS0CLK_VOUT_NCNOC_INIT, "vout_ncnoc_init", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_VOUT_AUX, "vout_aux", 150,
+		    JHB100_SYS0CLK_PLL0),
+	/* bmcperiph3 */
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER3_NCNOC_INIT, "bmcper3_ncnoc_init", 6,
+		    JHB100_SYS0CLK_PLL0),
+	/* hostusb */
+	JH71X0__DIV(JHB100_SYS0CLK_HOSTUSB_NCNOC_INIT, "hostusb_ncnoc_init", 6,
+		    JHB100_SYS0CLK_PLL0),
+	/* hostusbcmn */
+	JH71X0__DIV(JHB100_SYS0CLK_HOSTUSBCMN_CFG_480, "hostusbcmn_cfg_480", 5,
+		    JHB100_SYS0CLK_PLL0),
+	/* bmcperiph1 */
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER1_NCNOC_INIT, "bmcper1_ncnoc_init", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER1_CFG_800, "bmcper1_cfg_800", 4,
+		    JHB100_SYS0CLK_PLL0),
+	/* bmcperiph0 */
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER0_NCNOC_INIT, "bmcper0_ncnoc_init", 6,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER0_CFG_400, "bmcper0_cfg_400", 8,
+		    JHB100_SYS0CLK_PLL0),
+	JH71X0__DIV(JHB100_SYS0CLK_BMCPER0_CFG_800, "bmcper0_cfg_800", 8,
+		    JHB100_SYS0CLK_PLL0),
+	/* gpu0 */
+	JH71X0__DIV(JHB100_SYS0CLK_GPU0_NCNOC_INIT, "gpu0_ncnoc_init", 10,
+		    JHB100_SYS0CLK_PLL0),
+	/* gpu1 */
+	JH71X0__DIV(JHB100_SYS0CLK_GPU1_NCNOC_INIT, "gpu1_ncnoc_init", 10,
+		    JHB100_SYS0CLK_PLL0),
+};
+
+static const struct jh71x0_crg_domain_info jhb100_sys0crg_info = {
+	.clk_data	= jhb100_sys0crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_sys0crg_clk_data),
+	.ext_clk	= jhb100_sys0_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_sys0_ext_clk),
+	.rst_name	= "jhb100-r-sys0",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_sys0crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-sys0crg",
+		.data = &jhb100_sys0crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_sys0crg_driver = {
+	.probe = jh71x0_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-sys0",
+		.of_match_table = jhb100_sys0crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_sys0crg_driver);
-- 
2.25.1

