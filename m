Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91814E0B75;
	Wed, 30 Sep 2026 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772288; cv=fail; b=HcGeaDRgTYxn3UAIz0ScZk31EWWdjmAj/ai6PQy+naYbgBTG6CmYuyTLSlKLw4Um0KKacyUnnFInHcsK7vPpS80oBFLzly3SyWkSKmkXIkDnGtcuNeHB8He6gpv5rnfL0G4dx9UYrwXEU2SnWoh5cvOTSGSiS6tzp6GiX3CgR8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772288; c=relaxed/simple;
	bh=glC2+b+4x9thu8Nc5Hxde35OZgbopIW30zBFS8t8Iys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HU4aF5VKC4ds5dJ5ZqOjMQAWCCURJyPKrkTub8McF6bqPTIsCmsBIVTr9Xnf3J5IvR7RbD4xnYNzEim0vLKUFKqG+aaQWDR99intfAhk5afopWP+v0coBJUBj56kwM7lPITXCyEMCy5vWGeOsOo4kKLDbsfBH1Lz/4Vt6WHL//M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VntimUjuVNGM6u1d2BENTjhPu0sBBs06Du5gxKUARmhdEWSDT5BRKo7iqB9jq53OIi252sVUnyjEovOaek97yQVVjFwp4S0DWpjjIVBHBee/Nye469GMxnILnl4eVpDEVF+P+JLEmIkrFEQHZG0IC/4isbIoP1Forx8axZbu8KkDL2BlfwOSR4AbjQN3pzKajFPDKiMLxqGTJ3HVCrc8cVCguGYWCLgg6A46YHTeeDbvyMqg9luidSQA4g4N31c+ISMhyvsrBaugq4yA2JrGhBzoOt1zOPMw7pstukDvh4cT/cKolycAIMnelzORSMlgbDSMwVoNrSoIscQhyzH7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewsn1Ki7JwvJiIFotzOb+ybUEwtsyeT9zp0GwVVg9fY=;
 b=TYonDxks/2Xb3dC3QyKMrB6i2mbZHFuZUyljGLOGRDFNkuQAhhLOzPJk2rx1Mh5BM13ueW86U9Vd/IvqNK/Vv4/RkNCCkBHqN9RHVHIihRKNb0R4bJ/2OkuZAMzVwI2TUMhkVcHJLQ0DZYRzxk6YGxSsDlam5FRYO/9RUNjJre2qK7L3XfxuEcw1j+5AlJ/S8aCphKBVVpCqMQrN7VPnoVsau8lvGnb/sJuv6U73unR/jRnY4tErl9gAa7m5DZua3ZwMUQmKNsSVA4at82F2cP8kCn0+NCp2JcpF1/z3k789X6BLdZlzeuHKR3dW9MgIgVwfQifcVinfciHDd55tDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:44:10 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:44:10 +0000
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
Subject: [PATCH v5 22/23] reset: starfive: Add StarFive JHB100 reset driver
Date: Wed, 30 Sep 2026 05:43:16 -0700
Message-Id: <20260930124317.5648-23-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f46b572e-84cf-41bd-b80e-08df1ef08669
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	mDb1uk8//2P0GJxpxJEbL4eiun+ZPw3x+Tx4pU8BUwYuWITcQZY1riBRllpTSsKrCqShj3uv/R1MDXmzXvlPZB+bm0MyjNm+yRZiwMHwkxqvWJiVwy3ij/e53sNazHSTz73yW2fTGfB9xdOBQnktFfN1s+yyx7u1yGmqycZnuoTVQqfXJdhtBfBXvfyAyIhA8zsJNzb0pqLXTDH8ykkzKrQ8bc1+/dyHoxbBpZusAVbkp9a1k5thn66x4JBhEn9C1Uvi/XG+fh8VqpvaCDetmze0EGheGrhKIFyOMPfzBZ8kBsWrXp/pmKdY53aQJMZE73dcRXZthUcgVa7tvBznnuYHun4bl8X0pPNJm3ezwY+ZnSfh5L0H3JJlncKmHthEFYoMEfk3G2K03VxUrR0nIoy6nIVcwzlE92w0L15jk0y1S/Svib9dJHzloUux9EaT4AlDFcTXKNj3rl4y+0pdmlQDGGJ97VA0JyRKvBWsFFDUYpB4n/2Z7/pqUX7WN5EC5KrvUSJ68Hwugu5QNQZZJ0a/R3iWbQKPtrxeiyN9MwgM0L7jr2U2OTXKYFx7hx5rHmUPa1BcEgzQIUuVrr9rnA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SH6bIvuoReaouxFFuc5mIWKMzFbKEGFmtLp77bpGp/kZ38ty8FR9GjkS2v6h?=
 =?us-ascii?Q?p1C5o+TVZM2me47TWp73nXe/YBX1EQX8YXYa1KMP9uVE+pTnexq3/9l50+rp?=
 =?us-ascii?Q?ZBnuzbyYlqcXqc41jtCfwuFMDzCZXiIrgdaURsIjZjJnMBOL3cHAgyHRWUhe?=
 =?us-ascii?Q?cJesdvmL3CXUgVk6ipTJ0PKoA2gEKhktskjg567oEvanG0sG5mmBhutcDVMt?=
 =?us-ascii?Q?di/mCozvYz67aHh4IsbNUfpuTfs9AvdlmYCPubAdmKmfscbYn1PTZy5v7En9?=
 =?us-ascii?Q?cLLM7qLbArhHqrzGJdbE2yTsM8veOOqtBGsqlmAMeIWMXKI4sjwF914mKZDo?=
 =?us-ascii?Q?WQZCnAp5U6hBTRWHdoYN2oTOiK9b3at4UuMznKrZtzBsQhqca+hTxIG3m2ZN?=
 =?us-ascii?Q?28f55Fk7mFzflPzkM/99kxRcN44oq5c4332wMnnBs75EJ14WqNIa+P7e+3E9?=
 =?us-ascii?Q?WhGGLubqdzCU8PiEr9J8uOWU6XrXX6bhNLzTS/vjYM3MviiG1GpaioIEja0n?=
 =?us-ascii?Q?4pIhF6iJ5D0gUXAc3+XF9hWDACu/+yB7fCoh9xTbv/+yZCQaIO3S0E+837VS?=
 =?us-ascii?Q?QvFPQmZYk7aGVnmHX7CqS6ULqDVxPfHmm/OQKbkkdJgNK729YX7E0VfdSQSx?=
 =?us-ascii?Q?gN+MDAzKiYXr7pqBPGrSNSPc8TlDiI3SBphVrDlNMaOo773txmD+SZ5azSZl?=
 =?us-ascii?Q?1JAqT0XNoLXQgE7vpV7WtE0p3bAHL0UzHrNS/yGz0yaGM0N39XxdIwbxQzZM?=
 =?us-ascii?Q?7zVkMLvcGN/ZFibkE5xlygrHMDwfk0T+S/nuwQ0GlDUbhi6jrwB9vGX+79W6?=
 =?us-ascii?Q?L5qDFu+WjB0uhXipJ7ehg3l3XJ5mBqMpEBnGt9GJRBYyw3mTGRs9yg8bEA8/?=
 =?us-ascii?Q?RfDyUAaQSQZhf1CG8whqQ93eCG3drrmEUNi8e4H3rurdy7YvavwhFKUhK0uc?=
 =?us-ascii?Q?OcKjdZF4ik6VBYcsMJB+8sJ/5PZK5kj4A3eJp6Gg+5Q9ImDQZRJqtVPFMRSX?=
 =?us-ascii?Q?sK954s1z1OciPYDopam9K8w8yok1cEz64R0k2YgcHLu9qYAfF8LXloCUdT1o?=
 =?us-ascii?Q?ikopqFYgjJLexHJF+bXR9lzGZ+/oCCFmsSpPibKRSEL5XC7OS+g2EuWwN+ia?=
 =?us-ascii?Q?Apapv31PAcW2QpXZf5pdgHygskNZOHxTNyiuSdLp6CCs8gF7SgzBpWnpceWK?=
 =?us-ascii?Q?Yn0cccP/l0CSZ4rmMW5+XRyahaWoHtWSLvCekaG0YjJxTZcAHvIM9JeZl9hk?=
 =?us-ascii?Q?P0xVBl7iuJBADjGyI7nHilSIve3xb6yqW80qrtTdl2qvNEAAvRDCTXEt+cb1?=
 =?us-ascii?Q?o+XLaM255W3Po5rn2YzIppnnpvosndZW3pJVthFPBdd1+WUxNrk6sWAS8WWE?=
 =?us-ascii?Q?nBcHcOfca3Jj/32meYO6G4KFeQEDloq4xzKjzRbf1M6aEfPROgteHVgaAHJz?=
 =?us-ascii?Q?RBMvMcA023NMCNUFaVK+J6qATEOPRwTG36uZhRXu6CrMwV4Vk9PKVQtMRKCc?=
 =?us-ascii?Q?RkNrtPwu/n1QP6R0N0BmXgV37J1V8IN5cJXJ7VGeq5ClgH8CHKKnQQ8By404?=
 =?us-ascii?Q?Gfbr8gq65IW4Awz7bhdwbvTHKZKnYAhgUB+ym/p+Und6lyhPiKen8MehPXcl?=
 =?us-ascii?Q?c4us8Py20oFu2eY4GLY/IOGE+w0kI1V3GuVWG83rF47B1mMTC42PQ0S/CNRo?=
 =?us-ascii?Q?gpHjrzi0nLFD1czuca53MWp9Kd2qjzhGu0k8E35JP6TjXdAmUpTyYX85QvWs?=
 =?us-ascii?Q?TfXt0etuEvZmrcchql6t6EcNgX+7v9Kb6J9u4n++fHUiExPyIb2O?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46b572e-84cf-41bd-b80e-08df1ef08669
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:44:10.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtUcLI3lwmuvA/5xKhanlPisSTz845Ll7MSIbbAiqtkgu3j0BDoaJK3XohMtUhEgK5+1E1oSJPJKeErunjHW8r5Wc3CaX9zF15/hBUt+2qKTlPZghrwvwsTCB8cB3KOG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Add auxiliary reset driver to support StarFive JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                                   |   6 +
 drivers/reset/starfive/Kconfig                |   9 +
 drivers/reset/starfive/Makefile               |   1 +
 .../reset/starfive/reset-starfive-jhb100.c    | 302 ++++++++++++++++++
 4 files changed, 318 insertions(+)
 create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d22078bcf488..60ced2810e0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26236,6 +26236,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/starfive,jhb100-intc.yaml
 F:	drivers/irqchip/irq-starfive-jhb100-intc.c
 
+STARFIVE JHB100 RESET CONTROLLER DRIVERS
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Supported
+F:	drivers/reset/starfive/reset-starfive-jhb1*
+F:	include/dt-bindings/reset/starfive,jhb1*.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index d832339f61bc..84baefbaee14 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -19,3 +19,12 @@ config RESET_STARFIVE_JH7110
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7110 SoC.
+
+config RESET_STARFIVE_JHB100
+	bool "StarFive JHB100 Reset Driver"
+	depends on CLK_STARFIVE_JH71X0 || COMPILE_TEST
+	select AUXILIARY_BUS
+	select RESET_STARFIVE_JH71X0
+	default ARCH_STARFIVE
+	help
+	  This enables the reset controller driver for the StarFive JHB100 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
index 7a44b66fb9d5..d781103355d3 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_RESET_STARFIVE_JH71X0)		+= reset-starfive-jh71x0.o
 
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_STARFIVE_JH7110)		+= reset-starfive-jh7110.o
+obj-$(CONFIG_RESET_STARFIVE_JHB100)		+= reset-starfive-jhb100.o
diff --git a/drivers/reset/starfive/reset-starfive-jhb100.c b/drivers/reset/starfive/reset-starfive-jhb100.c
new file mode 100644
index 000000000000..87a93149609a
--- /dev/null
+++ b/drivers/reset/starfive/reset-starfive-jhb100.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reset driver for the StarFive JHB100 SoC
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ */
+
+#include <dt-bindings/reset/starfive,jhb100-crg.h>
+#include <linux/auxiliary_bus.h>
+#include <soc/starfive/reset-starfive-jh71x0.h>
+
+#include "reset-starfive-jh71x0.h"
+
+#define NUM_RESETS(x)		((x) + 1)
+
+static const struct jh71x0_reset_map jhb100_sys0_map[] = {
+	{ JHB100_SYS0RST_RESOURCE_ARB,					0 },
+	{ JHB100_SYS0RST_SYS0_IOMUX_PRESETN,				3 },
+	{ JHB100_SYS0RST_SYS0H_IOMUX_PRESETN,				4 },
+	{ JHB100_SYS0RST_RST_ADAPTOR_TIMEOUT_RSTN,			5 },
+	{ JHB100_SYS0RST_BMCPCIERP_RSTN_BUS,				14 },
+	{ JHB100_SYS0RST_BMCPCIERP_RSTN_CRG,				15 },
+	{ JHB100_SYS0RST_HOSTSS0_RSTN_BUS_ESPI,				16 },
+	{ JHB100_SYS0RST_HOSTSS0_RSTN_BUS_PCIE,				17 },
+	{ JHB100_SYS0RST_HOSTSS0_RSTN_CRG,				18 },
+	{ JHB100_SYS0RST_BMCPERIPH2_RSTN_CRG,				19 },
+	{ JHB100_SYS0RST_BMCPERIPH2_RSTN_BUS,				20 },
+	{ JHB100_SYS0RST_VCE_RSTN_CRG,					21 },
+	{ JHB100_SYS0RST_VCE_RSTN_BUS,					22 },
+	{ JHB100_SYS0RST_BMCUSB_RSTN_BUS,				23 },
+	{ JHB100_SYS0RST_BMCUSB_RSTN_CRG,				24 },
+};
+
+static const struct jh71x0_reset_info jhb100_sys0_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_sys0_map),
+	.assert_offset = 0x12c,
+	.status_offset = 0x130,
+	.discontiguous = true,
+	.map = jhb100_sys0_map,
+};
+
+static const struct jh71x0_reset_map jhb100_sys1_map[] = {
+	{ JHB100_SYS1RST_SYS1_IOMUX_PRESETN,				1 },
+	{ JHB100_SYS1RST_MAIN_RSTN_CHIPTOP_SENSOR,			5 },
+	{ JHB100_SYS1RST_VOUT_RSTN_HOST0,				8 },
+	{ JHB100_SYS1RST_VOUT_RSTN_HOST1,				9 },
+	{ JHB100_SYS1RST_HOSTSS1_RSTN_BUS_ESPI,				10 },
+	{ JHB100_SYS1RST_HOSTSS1_RSTN_BUS_PCIE,				11 },
+	{ JHB100_SYS1RST_HOSTSS1_RSTN_CRG,				12 },
+	{ JHB100_SYS1RST_BMCPERIPH3_RSTN_CRG,				13 },
+	{ JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS,				14 },
+};
+
+static const struct jh71x0_reset_info jhb100_sys1_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_sys1_map),
+	.assert_offset = 0x54,
+	.status_offset = 0x58,
+	.discontiguous = true,
+	.map = jhb100_sys1_map,
+};
+
+static const struct jh71x0_reset_map jhb100_sys2_map[] = {
+	{ JHB100_SYS2RST_JTAG0_MST_WRAP_HRESETN,			2 },
+	{ JHB100_SYS2RST_JTAG0_MST_WRAP_APB_PRESETN,			3 },
+	{ JHB100_SYS2RST_JTAG1_MST_WRAP_HRESETN,			4 },
+	{ JHB100_SYS2RST_JTAG1_MST_WRAP_APB_PRESETN,			5 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTCMN_RSTN_BUS_NCNOC_INIT,		8 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_HOSTCMN_CRG,			9 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_BMC_TARG,	10 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_HOST_TARG,	11 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_BMC_CRG,				12 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB0_CRG,			13 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_BMC_TARG,	14 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_HOST_TARG,	15 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB1_CRG,			16 },
+	{ JHB100_SYS2RST_BMCPERIPH1_RSTN_CRG,				17 },
+	{ JHB100_SYS2RST_BMCPERIPH1_RSTN_BUS,				18 },
+	{ JHB100_SYS2RST_BMCPERIPH0_RSTN_CRG,				19 },
+	{ JHB100_SYS2RST_BMCPERIPH0_RSTN_BUS,				20 },
+	{ JHB100_SYS2RST_GPU0_RSTN_CRG,					21 },
+	{ JHB100_SYS2RST_GPU0_RSTN_BUS,					22 },
+	{ JHB100_SYS2RST_GPU0_HOST_PCIE_RST_N,				23 },
+	{ JHB100_SYS2RST_GPU1_RSTN_CRG,					24 },
+	{ JHB100_SYS2RST_GPU1_RSTN_BUS,					25 },
+	{ JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N,				26 },
+};
+static const struct jh71x0_reset_info jhb100_sys2_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_sys2_map),
+	.assert_offset = 0x88,
+	.status_offset = 0x8c,
+	.discontiguous = true,
+	.map = jhb100_sys2_map,
+};
+
+static const struct jh71x0_reset_map jhb100_per0_map[] = {
+	{ JHB100_PER0RST_MAIN_RSTN_UART4,				1 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART5,				2 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART6,				3 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART7,				4 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART8,				5 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART9,				6 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART10,				7 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART11,				8 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART12,				9 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART13,				10 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART14,				11 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C0,				12 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C1,				13 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C2,				14 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C3,				15 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C4,				16 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C5,				17 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C6,				18 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C7,				19 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C8,				20 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C9,				21 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C10,				22 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C11,				23 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C12,				24 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C13,				25 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C14,				26 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C15,				27 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C0,				28 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C1,				29 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C2,				30 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C3,				31 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C4,				32 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C5,				33 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C6,				34 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C7,				35 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C8,				36 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C9,				37 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C10,				38 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C11,				39 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C12,				40 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C13,				41 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C14,				42 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C15,				43 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT0,				44 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT1,				45 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT2,				46 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT3,				47 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT4,				48 },
+	{ JHB100_PER0RST_MAIN_RSTN_DUALTIMER0,				49 },
+	{ JHB100_PER0RST_MAIN_RSTN_DUALTIMER1,				50 },
+	{ JHB100_PER0RST_MAIN_RSTN_DUALTIMER2,				51 },
+	{ JHB100_PER0RST_MAIN_RSTN_TRNG,				52 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC0,				53 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC1,				54 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC2,				55 },
+	{ JHB100_PER0RST_MAIN_RSTN_LTPI0,				56 },
+	{ JHB100_PER0RST_MAIN_RSTN_LTPI1,				57 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL4,				58 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL5,				59 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL6,				60 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL7,				61 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL8,				62 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL9,				63 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL10,				64 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL11,				65 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL12,				66 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL13,				67 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL14,				68 },
+	{ JHB100_PER0RST_MAIN_RSTN_LDO0,				69 },
+	{ JHB100_PER0RST_MAIN_RSTN_LDO1,				70 },
+	{ JHB100_PER0RST_MAIN_RSTN_PERIPH0_SENSORS,			71 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC0_SENSORS,			72 },
+	{ JHB100_PER0RST_SYSCON_PRESETN,				73 },
+	{ JHB100_PER0RST_GPIO_IOMUX_PRESETN,				74 },
+	{ JHB100_PER0RST_UART_MUX_REG_WRAP,				75 },
+};
+
+static const struct jh71x0_reset_info jhb100_per0_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_per0_map),
+	.assert_offset = 0x554,
+	.status_offset = 0x560,
+	.discontiguous = true,
+	.map = jhb100_per0_map,
+};
+
+static const struct jh71x0_reset_map jhb100_per1_map[] = {
+	{ JHB100_PER1RST_IOMUX_PRESETN,					0 },
+	{ JHB100_PER1RST_SYSCON_PRESETN,				1 },
+	{ JHB100_PER1RST_MAIN_RSTN_SFC0,				2 },
+	{ JHB100_PER1RST_MAIN_RSTN_SFC1,				3 },
+	{ JHB100_PER1RST_MAIN_RSTN_SFC2,				4 },
+	{ JHB100_PER1RST_MAIN_RSTN_SPI0,				5 },
+	{ JHB100_PER1RST_MAIN_RSTN_PERIPH1_SENSORS,			6 },
+	{ JHB100_PER1RST_MAIN_RSTN_SGPIO0,				7 },
+	{ JHB100_PER1RST_MAIN_RSTN_SGPIO1,				8 },
+	{ JHB100_PER1RST_MAIN_RSTN_EMMC0,				9 },
+	{ JHB100_PER1RST_MAIN_RSTN_UFS,					11 },
+	{ JHB100_PER1RST_MAIN_RSTN_UFS_PHY,				12 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SFC0,				13 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SFC1,				14 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SFC2,				15 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SPI0,				16 },
+	{ JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS,				17 },
+};
+
+static const struct jh71x0_reset_info jhb100_per1_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_per1_map),
+	.assert_offset = 0x134,
+	.status_offset = 0x138,
+	.discontiguous = true,
+	.map = jhb100_per1_map,
+};
+
+static const struct jh71x0_reset_map jhb100_per2_map[] = {
+	{ JHB100_PER2RST_IOMUX_PRESETN,					0 },
+	{ JHB100_PER2RST_POK_IOMUX_PRESETN,				1 },
+	{ JHB100_PER2RST_SYSREG_RSTN,					2 },
+	{ JHB100_PER2RST_MAIN_RSTN_CAN0,				3 },
+	{ JHB100_PER2RST_MAIN_RSTN_CAN1,				4 },
+	{ JHB100_PER2RST_FAN_TACH_PRESETN,				5 },
+	{ JHB100_PER2RST_MAIN_RSTN_GMAC2,				7 },
+	{ JHB100_PER2RST_MAIN_RSTN_GMAC3,				8 },
+	{ JHB100_PER2RST_MAIN_RSTN_DMAC_8CH,				9 },
+	{ JHB100_PER2RST_MAIN_RSTN_RTC,					10 },
+	{ JHB100_PER2RST_ADC0_PRESETN,					11 },
+	{ JHB100_PER2RST_ADC0_IOMUX_PRESETN,				12 },
+	{ JHB100_PER2RST_ADC1_PRESETN,					13 },
+	{ JHB100_PER2RST_ADC1_IOMUX_PRESETN,				14 },
+	{ JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS,			15 },
+};
+
+static const struct jh71x0_reset_info jhb100_per2_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_per2_map),
+	.assert_offset = 0x11c,
+	.status_offset = 0x120,
+	.discontiguous = true,
+	.map = jhb100_per2_map,
+};
+
+static const struct jh71x0_reset_info jhb100_per3_info = {
+	.nr_resets = NUM_RESETS(JHB100_PER3RST_IOMUX_PRESETN),
+	.assert_offset = 0x98,
+	.status_offset = 0x9c,
+	.discontiguous = false,
+};
+
+static int jhb100_reset_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	const struct jh71x0_reset_info *info =
+		(const struct jh71x0_reset_info *)(id->driver_data);
+	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	void __iomem *base = rdev->base;
+
+	if (!info || !base)
+		return -ENODEV;
+
+	return reset_starfive_jh71x0_register_with_info(&adev->dev, adev->dev.parent->of_node,
+							base + info->assert_offset,
+							base + info->status_offset,
+							NULL, info, NULL);
+}
+
+static const struct auxiliary_device_id jhb100_reset_ids[] = {
+	{
+		.name = "clk_starfive_jh71x0.jhb100-r-sys0",
+		.driver_data = (kernel_ulong_t)&jhb100_sys0_info,
+	},
+	{
+		.name = "clk_starfive_jh71x0.jhb100-r-sys1",
+		.driver_data = (kernel_ulong_t)&jhb100_sys1_info,
+	},
+	{
+		.name = "clk_starfive_jh71x0.jhb100-r-sys2",
+		.driver_data = (kernel_ulong_t)&jhb100_sys2_info,
+	},
+	{
+		.name = "clk_starfive_jh71x0.jhb100-r-per0",
+		.driver_data = (kernel_ulong_t)&jhb100_per0_info,
+	},
+	{
+		.name = "clk_starfive_jh71x0.jhb100-r-per1",
+		.driver_data = (kernel_ulong_t)&jhb100_per1_info,
+	},
+	{
+		.name = "clk_starfive_jh71x0.jhb100-r-per2",
+		.driver_data = (kernel_ulong_t)&jhb100_per2_info,
+	},
+	{
+		.name = "clk_starfive_jh71x0.jhb100-r-per3",
+		.driver_data = (kernel_ulong_t)&jhb100_per3_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, jhb100_reset_ids);
+
+static struct auxiliary_driver jhb100_reset_driver = {
+	.probe		= jhb100_reset_probe,
+	.id_table	= jhb100_reset_ids,
+};
+module_auxiliary_driver(jhb100_reset_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 reset driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

