Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2117.outbound.protection.partner.outlook.cn [139.219.146.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1B42E421;
	Sun, 20 Sep 2026 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905746; cv=fail; b=ZLVdVyseDQ7Cy/1IeEk31Zdp+hXdzwf5lGK3aZPoMfmjN1p+HkKQvBI8RzWgcMpy8kcxVNz6eGx5a+DLDs53Ipmmdkn7iCcD28OdBxYlhr3Fdxwgkz81XKsjAN9FHATKkCuz9TFPU7lvk1EJ6MWj0FbrZ64qaUBFE6t5GvJ1fQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905746; c=relaxed/simple;
	bh=RMn+QetrdXovTHv5EgBr47Dx2tOo56hKUWnLIjbEZFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eG2dRACEp3Fxs1L4o7oIR8bF7eXNYBplc+5ty66nXhCiL1GBJBtYM9MMpJ+mqbYQw1qer5WEHXxsbNXBrWDzZJ1xGcFTbJltwLDb2pspIHyhHTxtVYveWXM4MGvkZWY8BKttZO7d1gEx++5Lvv07DJm1IR07Q2yPO7HxfL54CDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbfO7ZlQql73yqvxLT3Aq84ty6+K45I0XZVeh6EIv7iKhRxwdQli9vC2572TAEGnAEI4czp8t703jdvSwdXnKf0/jkd20BRPkcQZiH50l0qjoM0YccF9Cc+RiCl14iPQ5sHE9tZHQ8pOrQ2DiSri9VgLSDzQAdEyei1ev/XbMWhCXQmLb70JlSUe7jg1yZWZLz+Ua7baDkP2E5JqsgruWe8qhy9T6+ADAnPJZJmLEymp8WZ4rj86AYDfEHARIsfK8JQ6O36xPNERSOXL4QTYO8e2Gw6SIPHdUY/HbbGOEXvQ0pH1s25Eds3TJmWElu1O7vJypUHZQ8r1Si5hMwgMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmZ0WXEo3cuCZ3daAVTKJSwmLSzKCiLtVl5WzOII5TM=;
 b=g0kc518kqaFO/xvljyUsZ2tWC2KKOl04WaiT3NZOvoC7DifglOmSVEMkN1cncn+D0+GxisthA30IwCTdSMFExC8baj6IJ7x9Wc9cR9WhUcuk1Dyk6o+oXQa8NnCq/OdRAQRm9S87YTJ1cebUqjdE0XgSVZengO4El66XcZ0XKMuqzUNSj4PbikyBrwev3Frfs2F8lMR40Px+2ULvL4ev+H0nD1uwDyGCZnkh4DdLEx4QV2ta4NWiPFHgd1QWRJ/DFdq7spF8oIGIWmnxEn6z9zsaRzxzFz3Vh+pPtaE5XOEx3LfW1dPq5or4WtW4KMOjRss6/V21hvW26+odz38dzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:00:54 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:00:54 +0000
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
Subject: [PATCH v4 03/22] clk: starfive: Rename file name "jh71x0" to "common"
Date: Sun, 20 Sep 2026 05:00:25 -0700
Message-Id: <20260920120044.194901-4-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1070:EE_
X-MS-Office365-Filtering-Correlation-Id: 168f62e8-8fda-4036-3565-08df170ed2f0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	s6R/tPUJpLdBiGaZdsm+E9//c9hjJEco/2K/O0HcHkit0UFWDkJdGIXwv1oliVxEnrmaf3FPAEdWIwE2bB6+QqRyDjq2OoLCvvk3nSoYB4zmCdTST2VJ+PhjIPJWFfqEWv2RfViITvVZSY/R7sabNmYXFu47qzMF/b/IrF0KV8xE6FQZoxxI02MYICEufDEzzf4gcdv7qzlbwxD+AotmLoJfh87TVFWpuA7UUYRo0c0OFja2aK6YKU78JRRBOct+wGtcqXFf9KefTMb3mTS3qAaCi/Stoawcjus/7zdRptOii1Rfx0hoqYEyhP6PXCkJk4jmAVMe3cgPO6mHA4yhiiruEgxY3uuXYu9TdwU6CSLEUOVE8nugsAGGf6pxqqSxDih5HkNzyCR1leQnBcJVZo9z5HbukulC63n6LhzHFn4dpjsceD1WkH7hpJe99xiIT3v5djxbueHu0lZ6auhMOwwQGqRDuwmzUoEj7TIqxBWlr0lJ9yGjsPu9ePO3vYpgCI7xHUiFhmfcLkRwv/QUpUDL6KABFN7HnEMzbmvX9QLqkcBrmq+ryQ+jgSN4el/o+ZUEQoOKCVQo/QZcBO27sA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rqhMolz11d4jb3e078udphd9l3+F85Q96J09jDKuZA5Xdk2buSTTfwN/56np?=
 =?us-ascii?Q?fn0LpzRiw/8FcuJ9eHC6gPBqPBx5FUduXmkXGwg6542IQT7cMV50MP6Sk/oS?=
 =?us-ascii?Q?b8ogcs81gfsYLirTsD7gnmUkSDDN1/gNrbTYGq3oONt+W79mTdvN7Q/NdNCf?=
 =?us-ascii?Q?y6O2lrbmcgddExj2yqwWyJ562P4WepEdnS/A50cG4mkEivbpxPmQmCrzVckO?=
 =?us-ascii?Q?C/9uLawMRioG7bM823jlLQQ5aKrflZrh4makGZGagkY2MgbptNObjwLmSEg9?=
 =?us-ascii?Q?e2vFPjcs9TDwB7OVJi3VNnIger98zKILt689JBF+L0TSmtpdC6zKwuOK80nv?=
 =?us-ascii?Q?Hparab3L0+Oxmp4M6AjRAhpLsVBok+H3yG/xSFvr8hgBOpRykG5y9zo1uHcu?=
 =?us-ascii?Q?Ej09vhT2nCtwiBHqftIAxjh/LRfWZCOD+ue7TIF/uYNZz7Po8mUQPMhVqG7t?=
 =?us-ascii?Q?CVAknrpo/v6XhkvbRtbOKfs4/UJvif0OjSjXWTm+tnoZlKUqaNt33Npl73u4?=
 =?us-ascii?Q?+64D91Ix7ys1YxIM1bv8GNqtcQeP0Y3NDYNIqYzLszZsxPwR3He7m3pUrR97?=
 =?us-ascii?Q?OK/FKmvcOpBZ6lN86nWxUsRtWHo5RiBMspcWYEwin65CR9pgW+XEns0mQTx6?=
 =?us-ascii?Q?SknlP+ATflPQ8Rs9kJyvu3eGvbNKe6wTs5BX6vjqLOow3ve7uIK0c7lCKpLS?=
 =?us-ascii?Q?9SnpimgzVSln2OW9CSqnBTAzw6otSaZxhn9UFvXmdycsNOYl1f7uGn6tlwmt?=
 =?us-ascii?Q?kKya9krnZ/XGjfJHdJH4mHBGv+kBL/lD9lWrSe/mwHUZzVRkRnghDmpAwAxG?=
 =?us-ascii?Q?khxtumjscSbZaJXEGXeH6Svnk+oy2hPeDMYaRCr8RFOO1g+x7ACg+1OiUDT+?=
 =?us-ascii?Q?QcN5eAjuyhc0S6jq8erHHKdY3dWt9KD89Rlq42C78zRWvnof8HYtYYIMjsy/?=
 =?us-ascii?Q?8+KXerp6mx1XEPfepMZxfCSwE3ZInLcRwVor7Evh4v87NH1pkF06Gzqpc3NZ?=
 =?us-ascii?Q?aBqe9BCAAWpRPcqA2dghxcYBucNsl/NLICaIhc5Cs6ymZMaNLaKK3rh7sgvb?=
 =?us-ascii?Q?KOlfhy9ty67K9V1Vi8AsytdoTR7YMEcR+EpN8vATQ2r55jMd6BDfzcPwzP5R?=
 =?us-ascii?Q?rd+A4qaiDn4hulfObNUIlMFp+Q/JYkQ5YpTGpSkOaTfH8T7Nu4EIGFmcPwTH?=
 =?us-ascii?Q?2UBlibdsZ97dlEEMD4WYZzVUqq7TZ8B4XtZpH3sDI6l3pcka1YSwhYJSOlHG?=
 =?us-ascii?Q?kr886agV+PcW26yYgU5a9lJVwjt8WDMSMYSXUFMLBuStz0I44nncTxsxcsd+?=
 =?us-ascii?Q?cCX05+v+I1w4zrHC5S4JPRVXiR9weeOwjlISI+mU9hLlR7QI3ytKMn1VhV9U?=
 =?us-ascii?Q?cCeBi0smZX14kbvCJmy4ABfeynqqEJqbofHYhcv4SUWzPD/6mvz9LEryIuKy?=
 =?us-ascii?Q?7Cq8B/uPNqfXCvAaZ9xgDdIJWBO3jIh7lgGQbt1Y6WUJDBXW1HE2F17fSnQK?=
 =?us-ascii?Q?ZeyI6Yw7/BbCKsQ6p/JhnMDdb6yGsiAm2Zu1p8DbdMBVwrNa0xLISpIJHyLP?=
 =?us-ascii?Q?rrF7HUbRxTFK93F42eZb/a6AQwGBr/84Qe+JF5Xml+LAt1W4A7gyGKGKBWCQ?=
 =?us-ascii?Q?ARUhHP5sqJovNYcq5ZB3VGJ/TOfSUTVJmeGJ/xajAlWQFQwrOMy2zEUEspX5?=
 =?us-ascii?Q?8U0/fyAF+KsDFHynYBV9Zx7STYt0WYizvVildbhr3Jc9FcmYzMv8xUC4s+95?=
 =?us-ascii?Q?g7JP3V0AW2WTyKKHqJg/iaWsgGHraduJvoOxhNX2kyhF8wBqFCEY?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168f62e8-8fda-4036-3565-08df170ed2f0
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:00:54.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQMBY8b+ZnqmtuKZTmB8PFLx5NXcsTMVsmV3hhaznsK/usF7pAqF4MpRfYapL6T/y8/x9SA9K1lMmT+OdIjNd0XXUcJd+GgLdVwOZ5VvtfSmVR7ONAq+UuBAzNreBQ+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

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

