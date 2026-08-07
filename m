Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0841D109;
	Fri,  7 Aug 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103098; cv=fail; b=Xs0gbwI/ZmGswysljd+QlJ17cFPw0puZ8KrGPxw9ofzj/+QB7R9/Hv26eUC4/u6QDIEAI5bBE+qWn7fP59IDrXNRU1/t88XSyFa/p5xZsj9GCjU6s38tO5joI0baWgCqlZBaVfsHrx0NpPXB3/Na2CrPmdaDWBObVaMnMfKdmaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103098; c=relaxed/simple;
	bh=RMn+QetrdXovTHv5EgBr47Dx2tOo56hKUWnLIjbEZFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xp11c8iYztAEdQaZJVheSKpje+TOqP1oPX0H/x51H5kCdvaTUijysnIDBqSuacXQaOj1zqs/jv9LBRV37SH9g2ZPh56cG/KfLeEFRR5KXcDEW1DggJvnEW3NfdIPB7AN++wS3MUq9fSioKbWNbWSFpQK1rcoX/ZkbakbUA3CJFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDAWfh/IK4DpMRPvvuy3M38PkPoHZ/zN5ufh8LeQ/aRfur9fexZzJVRjJT3frsYFHjLpB7HftkXTWSvCZN+7inQtcieGKnp8nTd0No61Ew5uc3NrmPnAxghB3I2LXz4toN1ohd2C1VECIpqIT8j/iblFNfTTz/4STYkJa5sqibil3Nc9rncb4CpKZmgQVK1eQX5jVYK1ME6ZpM8ck1FnSYoVsn0nVcYU0nSvldbmYy0d/StlzlrQJoLzGVAQoZzNF+v7nadrIPxHhJaMFCIa+4iqRL2utBdfZJz2qY2wUALASqOGX7L9AkpQkX1d8pwWukqBbx3WDmjzwNog0PBFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmZ0WXEo3cuCZ3daAVTKJSwmLSzKCiLtVl5WzOII5TM=;
 b=lub10uJD9OiVfGTbW0V2u5qr7tFNunQyTFcpVZwg47Tjd6OdJWYxeV5yrJ4x73FyIpaHov7nNkqnGrNjNAKdaS1+zv0lZc8DynJDiTZsVkH3XwImH+A1ve1yj1aWnLBazEuvafQsY7m7juZIcz1LxeByXHIWxBNfjPDtpwxi7KCMV4myjmQ3ZLPcMzmslN0xhtgSmV80bKzpyr0zRXBJzamu/oNEx94zcT4UXLq+TCquRl91+6SRbUddVhRKmcWg/4MLFnMirj1jbA+zr37s7RMjjpkRsD1nnMnEYBgZ27kPmaAf9+zpwu/qwmPtAB5uFtZB4LHg+nlWn13RBd4TVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:36 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:36 +0000
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
Subject: [PATCH v3 03/22] clk: starfive: Rename file name "jh71x0" to "common"
Date: Fri,  7 Aug 2026 04:29:04 -0700
Message-Id: <20260807112923.191627-4-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f5c5d87-78b1-4d33-1214-08def477295b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oPXNw67g53evoF3RBmgf+yFAAQ+1/HaHmgCQHJwEDitrxu4ybJMHCn4lGPsoPzc0hzm5ICJcuBFZPL1n6Ma4ZeZGC/LnBWB6+/6TsazJWy9lcooKGr9AfLmgyova5gDm2Kz0lB/9qyoB5ym1E9nKGN0Zmy1zvKC+DHVi3jsEFCxMk6zTuETGJz+dLPm2VzSyEq3F/qlV8MOIzs64kVOqchEB+Qtb5fL/dDL7Q9jV2QpfRPbfBDZAfxSo/w+kv9nWsLF6RLhuHfUJWn3Nf3rg3QexFZo6mY8LH+/8DMMBhDDcNR+zU9FrxDoed8pWVnKZ7HFKE507FkVE+NiNFxrMTXLrdGKbwm/OuIWbLnbJlazoPG6tF6apVZTGVt4J51KpnkZM+oX5Y5lVKchvKwN+g2NkfPHTI6MuIu6loLHVuhlwncWrw3Hzo9NRCMxYQCJJpjfluTVl1zoyS4I2nQMes91IE2UKCnp11UcI3NksvODNIrV10wZzNopiDSTWzG/TgBhdHqYkX5AYv4WN0sVZcfHCTKH8JtLYNLIQVjHlYXZGBYpjoQXCvQHDW0vuhTae/ftsDAzimafQI8LSP7i71g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ylXcWeEIroRgmVdnTSokqqQJeLYobRssAdzcMEO1qpDM4IvKOtM6ko9fRQ9?=
 =?us-ascii?Q?g8y4P5A3muaZWmf5Xv6ZBUGbLV2QaH5BO1f5VkY4GwfwiuFeFGMrtMGzMDqu?=
 =?us-ascii?Q?C6sHby81TOoDs+RujzDV76Z3QYsvavqUG/d2AYEYX0rSahTaVrygosIzg1Ms?=
 =?us-ascii?Q?c+Uw/1f41lYTmXKX9+Pw692VtYvJI0GM/vUkQL+/wve7x77v/K+Xn1vuQ3zh?=
 =?us-ascii?Q?hBwdxfrXfThlVeRjpHh1YsXnMcBEqClLKTqfrN77ioZN6+DDuwrsXKrIF5rv?=
 =?us-ascii?Q?E+tHYy9XN7eKehQwrNEAly4+R8WSAKIWfLbgKBH5ZS/JgjR50ozL82JHWYvZ?=
 =?us-ascii?Q?cnmZqMUYAKfD+GGwBCyT5nWFeptoywVU+YFeC0ems0N0e03sTEv22I4fXtP1?=
 =?us-ascii?Q?sFHtA008PsoA23M2zrNmM1+kxYqhBu5ugl/qvGeRHOp5x7+wSM/nvNqExxBR?=
 =?us-ascii?Q?oFZNL0BE0y7ZKlu++yws0tqXFF2x8r0nPIGgI+G7qs1g/Ok91Qxs0PItmnpz?=
 =?us-ascii?Q?YIztYDBssPQSxHw5A/FHloUgZAt96Hj2xgJCiouKTEa9JpjtJzQMZt6GR33d?=
 =?us-ascii?Q?VhlyS6A/XoUXru9Q4nHNpHARYSGCofCtaubwy9mL3CP7RHh2k2Fw5escxpBy?=
 =?us-ascii?Q?EZeQPAGU1NVsenibjpqiD96TAUO42UES4o85JrXdwOS94fWigHtB7VqiEdLt?=
 =?us-ascii?Q?gZLeN3JF9wWBlkSEPy+Q3TOH8wJXJkQJr5i0PrJJAOb5RJPtEpl/AZUaGoqZ?=
 =?us-ascii?Q?PR9eRWSgxApZTE+GEn6Wr6DVWL1/+UmlzBBpDuGIgPNQ4/kRf547FCQRO8ay?=
 =?us-ascii?Q?sZbdoPVZCid3kKtnwBJZMgZGXSCWtsFEx+yrcch2t3oq3NCH7xxiggKI7JJ/?=
 =?us-ascii?Q?Y0873Ylq6kB1YgXkwJ8gCHEvDURzN1nmJDQ4Q5bKxjKDriRhNwMP/3C3VWOm?=
 =?us-ascii?Q?Ec70WjxXQ5d2lKpYsgMGssNHZQYA2hKJfKSvbSrSfdUyuJ3rt5PZ+nomx3P4?=
 =?us-ascii?Q?P+9sa+UwkjLdhOKoyz1Xxb10cYAtdsvQh3pxn8LuCfYOgbgeMXwh8J8KYyPx?=
 =?us-ascii?Q?ugqjD2JTL/Cezy2W4jJk7ReZbqPQVPBbH0wCOjt7KT34kac98C9PbvD6y7Af?=
 =?us-ascii?Q?aGw1mVdENQjbrbYQXhPdZw0Vq9b0dCtHU3llHqYxAfA5fWP0rVCev/k10Kym?=
 =?us-ascii?Q?jUriBk3MUgnlOYP3LKaRX3HCIW8X3PRXCKKAB8eUyM/ZLAQvPyo+txSbjxC2?=
 =?us-ascii?Q?TgA2zZSfLWb3te9WzByK9oC87q5huzUcIj58C7DN4n8iCdrkPiEupeXfT/Dq?=
 =?us-ascii?Q?KfORF4NjnO7iUZZAvWEu9Rf9ZBVGrvCKn5iu7GeBFersA5v/AvnEA9c9R7kw?=
 =?us-ascii?Q?trMgov/6GcENA3b8sACje5sbYhYvsw56iur/+W800UR9V4n5EIBbnuWoJ8QQ?=
 =?us-ascii?Q?sDKhM/DKvhFyLfzPRtnyE0TpBhl6Gal8pur6uK8cpsRkyEierJfpWeBjiEQZ?=
 =?us-ascii?Q?B4F1FCQXgPQX6GmBy/bjq3OcDTf1Cs+V7E7p1nS+AS8MM7VJ5ADdLJgBOeCn?=
 =?us-ascii?Q?CZrjtYvP3GhTnJY8enfngEQMSrwvIn/lJf5hDbP/IQCslbnrGn/8W55e0u91?=
 =?us-ascii?Q?joN/zB3rlkZsw4MID/RPhjtQ8fa6vWEzM2N/DmHCxZU2kYa1qr/qZr1+o5t0?=
 =?us-ascii?Q?hnU1UkASXLSr0/tgevHBd+39Agog3qeC2+9jmTP1D/3gYzcuEvQrnepV+LlU?=
 =?us-ascii?Q?2zqJwkXP5D1hCSUTsoe3F7pte/RdOZ4AuaJLnSYUDvPzsAVcvm8U?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5c5d87-78b1-4d33-1214-08def477295b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:36.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/gvK8hHDJOH5Xr8e2k25+VNSzZbe8yN2CqZt2Lwpj9CM6FJsJQ3Zdz5SdTb0s6BC2H+gYlrwcIWDUNy1MCxJmXN7tCOYJXRtwoA5+D7TyGGtfTWZ2V4SuDcyM+8tYu9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

StarFive JHB100 shares a similar clock and reset design with JH7110.
To facilitate the reuse of the file and its functionalities, files
containing the "jh71x0" naming convention are renamed to use the
"common" wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                              | 8 ++++----
 drivers/clk/starfive/Makefile                             | 2 +-
 .../{clk-starfive-jh71x0.c => clk-starfive-common.c}      | 4 ++--
 .../{clk-starfive-jh71x0.h => clk-starfive-common.h}      | 4 ++--
 drivers/clk/starfive/clk-starfive-jh7100-audio.c          | 2 +-
 drivers/clk/starfive/clk-starfive-jh7100.c                | 2 +-
 drivers/clk/starfive/clk-starfive-jh7110.h                | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.c => clk-starfive-common.c} (99%)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.h => clk-starfive-common.h} (98%)

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index bd29358ffeec..ff8eace36e64 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config CLK_STARFIVE_JH71X0
+config CLK_STARFIVE_COMMON
 	bool
 
 config CLK_STARFIVE_JH7100
 	bool "StarFive JH7100 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the clock controller on the StarFive JH7100
@@ -15,7 +15,7 @@ config CLK_STARFIVE_JH7100
 config CLK_STARFIVE_JH7100_AUDIO
 	tristate "StarFive JH7100 audio clock support"
 	depends on CLK_STARFIVE_JH7100
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	default m if ARCH_STARFIVE
 	help
 	  Say Y or M here to support the audio clocks on the StarFive JH7100
@@ -33,7 +33,7 @@ config CLK_STARFIVE_JH7110_SYS
 	bool "StarFive JH7110 system clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
 	select AUXILIARY_BUS
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
 	select CLK_STARFIVE_JH7110_PLL
 	default ARCH_STARFIVE
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 199ac0f37a2f..012f7ee83f8e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+= clk-starfive-jh71x0.o
+obj-$(CONFIG_CLK_STARFIVE_COMMON)	+= clk-starfive-common.o
 
 obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-common.c
similarity index 99%
rename from drivers/clk/starfive/clk-starfive-jh71x0.c
rename to drivers/clk/starfive/clk-starfive-common.c
index 80e9157347eb..4aecb65e9fd7 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * StarFive JH71X0 Clock Generator Driver
+ * StarFive Clock Generator Driver
  *
  * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
  */
@@ -10,7 +10,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)
 {
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-common.h
similarity index 98%
rename from drivers/clk/starfive/clk-starfive-jh71x0.h
rename to drivers/clk/starfive/clk-starfive-common.h
index 9d5dec1d5cd1..f634c62c196a 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CLK_STARFIVE_JH71X0_H
-#define __CLK_STARFIVE_JH71X0_H
+#ifndef __CLK_STARFIVE_COMMON_H
+#define __CLK_STARFIVE_COMMON_H
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
index de1cf717e391..0e363b971e9d 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -14,7 +14,7 @@
 
 #include <dt-bindings/clock/starfive-jh7100-audio.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* external clocks */
 #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 761e46ed0ffd..ca81ccb5af94 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -14,7 +14,7 @@
 
 #include <dt-bindings/clock/starfive-jh7100.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* external clocks */
 #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h b/drivers/clk/starfive/clk-starfive-jh7110.h
index 0659adae4d76..6b1bdf860f00 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110.h
+++ b/drivers/clk/starfive/clk-starfive-jh7110.h
@@ -2,7 +2,7 @@
 #ifndef __CLK_STARFIVE_JH7110_H
 #define __CLK_STARFIVE_JH7110_H
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* top clocks of ISP/VOUT domain from JH7110 SYSCRG */
 struct jh7110_top_sysclk {
-- 
2.25.1

