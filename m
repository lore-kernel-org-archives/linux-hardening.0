Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554004749FA;
	Fri,  7 Aug 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102278; cv=fail; b=qRtauBbWau3F33ecbDhryLEUoYkZKwCvzR6F6KfBjVqd4Gi31/xV/Uzz+yBMuTHOTDdX47pEWc9S6CiMl+QC+Sn29NkY2gDfFVH7LFtPsl6P3WOcGqLDE/KeCx6e7HjWj3hciaetSUhhgzbr3Z/YSXbtx2uU+K7duy/8IMhBt/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102278; c=relaxed/simple;
	bh=bxlWOLORDDxsKvR/DyUHSxt4w+mJKpOG98LSypLVRG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8Ok2IIsHfZtgFNgw5ea/mkl9wzx4QE2JgJUztq6EgEJmEY5UZMqndk/+AwT0xywzuDca5pPcPHqwnK5HmjXfx7BOWHngC15fR8oLh/xWmFqLNyRXAaagByIUfXRA6zMCtRrj1qxe+HUsZdWh8aSM3CWG3bABReM3t3NYQD0IL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/wYYMP3C/IaJtEYjs8GKS1rG+obEuqFvwiNE7myoXfHCM11rE6BuMQKEZR+QNpO/oEych4fwq+MsbDnf/AVL2/Kj4zSY3iQikiEhquH1/YLeCJhC1Oz3vvsDVisn/oOJXlB1Xitz/ltIT/sCDUkxkSZPQqGsa6m70PdfppSA2yl8/WE1iTSTi7VzwSLxMqeTSxdJPEAeeCrgFP4jFqjdgHEgnAHUcljBxFPJqmY8SHwK8yRgb8wd+cEUxliFUVtmajE7Mz4tIlGvz7/YFYXdAD8+8JejyS6b5K9y/eUolq9VEVSnSAVpgX9Bo93Xe1qeYpDzH/Le+4hf0TOCSzRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0CzYBA3QgfDvvCQcanJHJvhSJcxcKzxL5wugzcnozM=;
 b=ZfcYSk9pir7xYs+DUUH+MQ7JtwgRehRSvKL3Mvrd6R5FGXis1le6LRM5rOT2UqygXlbAnvYtvmaYoWRG/+yBGwSFYUWh2+ZG4/6fOYfmuaD2C5hoT9eKFoUCK36W0cM0pX3HbuVyAixZyntbUGKO+Gi6Pkb2IHJc0yd+k8lfJ88xsmp/gxtAiukk2XS+vda+V8ZCNkU67rLxjE1W7lBCT4ihdlUb56C7ztQdUcIjzKw0LR5mjdmnHKTdaZWEB8vr8Q9W0uoHapdCUT3V3KB3ovKJKUMnvPkq1DJZOTcktMZk3fd2ZpVB3zIv1iC5vogLawOm9Ql7AV4b56e5Y6ev0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:30:04 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:30:04 +0000
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
Subject: [PATCH v3 20/22] clk: starfive: Add StarFive JHB100 Peripheral-3 clock driver
Date: Fri,  7 Aug 2026 04:29:21 -0700
Message-Id: <20260807112923.191627-21-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7c49877-035a-47fb-6772-08def47739e2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ty3DmRFW0yPVI014HBS94sri/BdEtfExsjVybc9bdY0dTsWwml0IKs0Psw8wqjJPxCVNe0WsFayiEn7xwO+/qfYBYnUibGOP1k/DbJATMnAcpEo6/pTz4skKDyf0PZ7kPnI/n1cz4BuSFKeBeVSSSn9dQh38tmIjFvVBSWcDw2rrkyrDPwJjKvG5mqycDtG05erJN26NZ+uT790vOhRwAlmjF0xD8ESVpyLKFjt149t+Sx6F0bHC40FBbCixgUY1zGKwPgYCscuQpc284xwi4vmscuWmiVXGVBMmPD+43Q1ncUSibxove6ZWyhqwGJiPQ9kY4qVP20JdLYni3DUz8KV0aSdhta73ixZcxrjAICmIsWnFXCWPxMIwiSE/xODxpn4QiFJJfSUUeFn36cuL2ge3EEshekNW3hUVkvzD1gd4ktXOj+RzL4NUVDFhVnixZCP1YU/wv1eb81DbF1vXeotB9NQVPmYHem0uGhHGNPeQURMcDpDuaPsZReSSrJbCpEykFzA+t2lJP6SJwfuh2sqrSPMPDc5aN2yq/gfrJ/+3jxCPWvdhv6DvJDHbOTyGHJFAD9P+GtpnUo2zyPWuWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kt2LB/op5lqryz/JDa3UCq72zSxZo8tAc3xba5spkj9e1AmFEeo0tkj5nFMZ?=
 =?us-ascii?Q?f55yu4AC7xz06GmSLyymTJKCv9v/jCdpy1dQEiKUL+6QKw58AIfBj6v4iWFg?=
 =?us-ascii?Q?Aeh6ry7S2mwAuyi7Cr7/Sn7yjH1oishAK5jonlLU+B3IkFsFzZjEPwzElN2b?=
 =?us-ascii?Q?R1W1jls1R+8xbJOx7iFdarBKKSzYtjt/OHH668iGKyH4WmEzfcog5EVDSw3/?=
 =?us-ascii?Q?J9I40WL41P8NW4vk93m3tI4NvVGDiTeYxWT34NxBmeZYrY4ucwbuUuJYLBYJ?=
 =?us-ascii?Q?ZgwCPagvj8UAEDMM63hhQJahyaNzIi2N6DFuKF4DdNNvUZgMBPi81kVMmxEI?=
 =?us-ascii?Q?3+I3Eo8dfdQUSjIaeUhFrMc3SRjqNzTbRdK4lUWAUOIqCAvLKvzPOSou3aT0?=
 =?us-ascii?Q?ZGWLsSqOjq6G8QTifVHmqmnvqPig4Icy4VbkEw8mR0gxLOxi4kd4vxLj/BEF?=
 =?us-ascii?Q?/o1vOjr/bGwTBSUBlj92p+hp84YVOOGgbeVz0gB1kyJvhhFilESoC/HYHLTa?=
 =?us-ascii?Q?jaACvMG0UA7lFlgKObMsWGRbln+Qd5eplT+FFGZLoIRsHD6G9sp2mOu86Qlc?=
 =?us-ascii?Q?k7RpsUK6fwhqN7xlul+krFkwvUj4uF4ADr4AZSz/3EohC2jHE8+Va8oyS/Bq?=
 =?us-ascii?Q?eeQ3xqS9Ju6oT/gAmFX9HgNI2blG+zt0gAibNh3XeqMeodMnKZ9IJDNyJt37?=
 =?us-ascii?Q?pJe7oYa1bO9NQ3mqWzlVCJw+SnR8qBCnjGWkwr+VhsGXVA5osLA8WE9S8VuZ?=
 =?us-ascii?Q?ZfFwovbQqhYS9tqro7lkupOgAc/QcRvxxXuuox9qqaQTLAhWH1V0/mQUB1N/?=
 =?us-ascii?Q?G+rbodCCQzFigjvjmEe9dygWolionRq7KypVZ/S9PbsUMqcHwHSD6xujUJ33?=
 =?us-ascii?Q?5tZxQJFKlM80ukwco5kS/9OVfyOKusBNyyFHYesp7xwKYHIiosIhcX7GqM8h?=
 =?us-ascii?Q?QrJnSfqat2TxvJB7BFAXkp+p6Lwd95PzELQjyWrQBqf9VxDcd/RrxGvt6dSw?=
 =?us-ascii?Q?9PtpIwojwuqmdpSnUEad1LvlIHs9KwFIsipBE/Hi+57Q2DoCfmI5bb7oPw0c?=
 =?us-ascii?Q?MDzocp3bJjuJlaJBAPj8i4cSYXU3yiS2GUAKRuveOh8aOzGBt2M4abPqVyjt?=
 =?us-ascii?Q?EpfMVZYeI6Gw5YU5cGaWjA15mBk5SlPAbSY5F0LSauslHEi2BpSM1GuZJnAF?=
 =?us-ascii?Q?5ZL7q0jSUGMrhTqSRktwc77nWaqR1iBcF/OQFWShLTCIGr2SKtqDvzErGxna?=
 =?us-ascii?Q?1aNAUHftD7Ec08rUpyfh+n4JGlT++LKXNB4guWZpnSNTnAJBQCLMAoftBjwE?=
 =?us-ascii?Q?q1Q0Q1ZNU1RvrCCH9FCW2oISIPDdzLrX6mI2AS6M0k42/bDcJgtxexVLgd1N?=
 =?us-ascii?Q?QfiOSJ6fXD1q5CLC9edAUoKlktFtkxI93t6q+B8q6FlF7DeIgPa1UJaRfhiO?=
 =?us-ascii?Q?+0qfejWImtwCj/Ng1pWakjN2aa/0GxSia7gSEPJ+AFaWMtEoBknzlpNX+g47?=
 =?us-ascii?Q?puZPgC99IbYpqGAwuy6i+5ujppxkOTQ9dHAz3PWOSXkSg5+G78ZuXZuwAWig?=
 =?us-ascii?Q?dZ8S8915oU1XJwr8F/jI/CZFtAuxQB93KfJFzVtMtPc0P6bEiAyV6QhlX5lT?=
 =?us-ascii?Q?EWAx+jZPS69RRzYQPVSq0oTPKgO9uLPiGx0aDyQnXcdjh9ESycMP/qYldCGn?=
 =?us-ascii?Q?c65oQp/wOJzp4Q31/hoB4ysjr6NX7QmchXxquWnx23yPct14iT8F4V6QcInW?=
 =?us-ascii?Q?qoo/ACG7JQO0ZbI1xCfh2PArktYNC9u3H+NI6PDm7U/kbLV3WK3u?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c49877-035a-47fb-6772-08def47739e2
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:30:04.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uneCTlzYmooI3FHGIZwkR+cegBYrWz232xT7WE69yrlV4HSUE9CwN8V3mXoJSqeM56qS590IM45J5heYmzXY70I84L2DTnFT2vaoOQM5o2lrTQr/vGt240gTzChwHpEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

Add driver for the StarFive JHB100 Peripheral-3 clock controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  11 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 132 ++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per3.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 89dadff766fc..852464949334 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -106,6 +106,17 @@ config CLK_STARFIVE_JHB100_PER2
 	  Say yes here to support the peripheral-2 clock controller
 	  on the StarFive JHB100 SoC.
 
+config CLK_STARFIVE_JHB100_PER3
+	bool "StarFive JHB100 peripheral-3 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
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
index 044e1942ccfa..f00690f0cdad 100644
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
index 000000000000..6703201604fb
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
+#include "clk-starfive-common.h"
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
+static const struct starfive_clk_data jhb100_per3crg_clk_data[] = {
+	STARFIVE__DIV(JHB100_PER3CLK_300, "per3_300", 256,
+		      JHB100_PER3CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER3CLK_200, "per3_200", 256,
+		      JHB100_PER3CLK_NCNOC_INIT),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_PTP_REF, "gmac1_ptp_ref", 2,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC1_TX_125_MUX, "gmac1_tx_125_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC1_SGMII_TX,
+		      JHB100_PER3CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_TX, "gmac1_tx", 50,
+		      JHB100_PER3CLK_GMAC1_TX_125_MUX),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC1_RX_125_MUX, "gmac1_rx_125_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC1_SGMII_RX,
+		      JHB100_PER3CLK_CFG_125),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC1_RX, "gmac1_rx", 50,
+		      JHB100_PER3CLK_GMAC1_RX_125_MUX),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_PTP_REF, "gmac0_ptp_ref", 2,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_RMII_PLL, "gmac0_rmii_pll", 2,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE__MUX(JHB100_PER3CLK_GMAC0_RMII_MUX, "gmac0_rmii_mux", 0, 2,
+		      JHB100_PER3CLK_GMAC0_RMII_PLL,
+		      JHB100_PER3CLK_GMAC0_RMII_RCLKI),
+	STARFIVE__DIV(JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2, "gmac0_rmii_mux_div2", 20,
+		      JHB100_PER3CLK_GMAC0_RMII_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_TX_I, "ether0_rmii_clk_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_RX_I, "ether0_rmii_clk_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_PTP_REF_I, "ether0_rmii_clk_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_PTP_REF),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_RMII_I, "ether0_rmii_clk_rmii_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_CLK_CSR_I, "ether0_rmii_clk_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_RMII_ACLK_I, "ether0_rmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_300),
+	STARFIVE_GATE(JHB100_PER3CLK_GMAC0_RMII_RCLKO, "gmac0_rmii_rclko",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC0_RMII_PLL),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_I, "ether0_sgmii_clk_tx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_TX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_I, "ether0_sgmii_clk_rx_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_RX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_125_I, "ether0_sgmii_clk_tx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_TX_125_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_125_I, "ether0_sgmii_clk_rx_125_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_RX_125_MUX),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_PTP_REF_I, "ether0_sgmii_clk_ptp_ref_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_GMAC1_PTP_REF),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_REF_25_I, "ether0_sgmii_clk_ref_25_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_OSC),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_CLK_CSR_I, "ether0_sgmii_clk_csr_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_ACLK_I, "ether0_sgmii_aclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_300),
+	STARFIVE_GATE(JHB100_PER3CLK_ETHER0_SGMII_PHY_PCLK_I, "ether0_sgmii_phy_pclk_i",
+		      CLK_IGNORE_UNUSED, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_SENSORS_PERIPH3, "main_icg_en_sensors_periph3", 0,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI0, "main_icg_en_peci0", 0,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_PECI1, "main_icg_en_peci1", 0,
+		      JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC0, "main_icg_en_gmac0",
+		      CLK_IS_CRITICAL, JHB100_PER3CLK_NCNOC_TARG),
+	STARFIVE_GATE(JHB100_PER3CLK_MAIN_ICG_EN_GMAC1, "main_icg_en_gmac1",
+		      CLK_IS_CRITICAL, JHB100_PER3CLK_NCNOC_TARG),
+};
+
+static const struct starfive_crg_domain_info jhb100_per3crg_info = {
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
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-per3",
+		.of_match_table = jhb100_per3crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_per3crg_driver);
-- 
2.25.1

