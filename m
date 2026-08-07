Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DA432E60;
	Fri,  7 Aug 2026 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102194; cv=fail; b=LHxlI4L1OuOZR7lxZ3x9CkRZREKBTuEA5jKW1sDZhXVvvuHyzVEGckJpudGaBgSywbROcw+1db24QKU74H0dpEf2x4K3/+ndmd+X3gY2RI4AlKnfMwFG3WTnJccsQubAr+sMTzsL8eFm9KISArhkHra1sk8ELGEG+5NRuyhDI8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102194; c=relaxed/simple;
	bh=HAdC4sqd2M31oD2ndXXbzcTwiQUXeYXQuAWjDuvnrVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPM+QSNwaLgmxwAoNZeEW8PPsbk5339przhbakj3GBoV6/q/hV73uhlfe+btxrvFqBTGwYRD2AcdiFKZXu4TFzbO1Vx/INmnLSuuJsr8IdEfuHxwbedWFLdqeLEyXvy8lem5ZNX2AoqSk66Tkyqm2hArOc05TPJ5/PbrhuniNmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OveMxPSGjtL3hov0Gm3Ilohog+wOqBrqXNZFFzsN891gaDKTd4C2ROmiGAAuwm8MOcM4PF+U4kOzFUL05c/H0q4269COdkklwYucao0lisqSmBjSD9rTQ8xtsZ9tn2BuIghNj4pFn8hDByYcaR84dNOgi6qyZkENfYMxGqAbgnfyy4v4tLza1b8xq4pPftUFmvmqXcRJntZl9eDlFaNw9/gFHDxXyavjtWtcIXFTCQqmHAkOpK0dHLQp1CX6zgQz4pMPi4+Le0jGbaB/CAnbcb4VmRk2wj3v0js65raX7g8HXhlWo2+fmh5JHxkcbjO8Y5A5F8rytohc0YREzc4lUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz8lYeT6ST+sGokZUZT2h8CdABtJak8I/Lr1wsc6SjQ=;
 b=Tz7OdHnWvEe3pTwwiy+LtIBj2c0oyc1Z0L7GGINQhGNUKw8AA4pLsgcVQL62b/w5aTqvAVJhyXx8RMfIlSKpwvx9BD/dQ70snm9jPMde+p4ZJKzDwJYhxZvZRJvN8SIaRQXQnlYsmlICAHzi4mgN7HhorK2J7CuUY/QEqF5J5N38dsLVOgYLRmDixvUjwGXOCwXKUFWZaH35jZx0Zy2Fx1HcTBfgAk1pFsfobOpiYh0wRsfXr8rzpQz9DGz/6n5kC4LwKvV+C2fZvfgc55uMRMs/Jo8i3IDuKNKDO7ve1pFyKX495p0WNvYm8juziirVqdqiQX3Lk76scMKGiRSYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1252.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:33 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:33 +0000
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
Subject: [PATCH v3 01/22] reset: starfive: Rename file name "jh71x0" to "common"
Date: Fri,  7 Aug 2026 04:29:02 -0700
Message-Id: <20260807112923.191627-2-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1252:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e22eb9-beed-4544-f49c-08def4772774
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|52116014|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	8V6uM8AliMUHL6ui7y11jy87V5A9XPr77MsP6Yg4CtKPODythzIXqS5MUDPt2f5qQB16UcaTnsCNNN5gPzTRl97Hgmy5FMLERC44PZ+n3QZOWs5iVZWjYcJQHX2EyuCogXeVI9s4Ni6ZoLuCUTBgnoH1HlH3KcD6svqBfJOFY6/g1UEaQe2lPMx8gHBpzkdbCZ7om0DQ9pwYIWdKwGpnnrNMWS/uozoMKmVxxU+HCguwgqXLWfCd/EjOPGfMqFB6i5rcQbK3O7F1wQUzG33H6o6Bc9hmXSwVFKQrxn2kAaMWj0QVstXRHhZ6SusePxZyZElCPpu9TFF0uG0uvVAErjbkoxffZYxhU1oVmVxnO3CYR7UnK0lt5ZoomHm7DPhhrGdW8R2DvZGPFHQoWPcGdtNmAw50JC/V0f++eZeYlHQKS8hHTAZIMHVCM+jaPIxsfoJYuWSQAODU3GzheFpDL/nffWS7zq4+bX91K5l3Q0lI0IJSEBtunENvGtcaPMcj6lBg2zV83h/kijjVI4BIzTcoPF6wt3Sklp5laASWOkeWuEMaRbTpvtxiWfoLnw6W4DWlDWDEZb1qGwm5Kq774w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(52116014)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KuiD1Gq9lbDKZgjznpn8nCMhIbw/aYIX5TJx3rHW3XOR1exwevX+xI5Z7IJW?=
 =?us-ascii?Q?zQHxYnYsZOF8DTmUJGQOm9DjR45pyROXqca+VpgzipLJfGqSlWYlV3d4l2Lu?=
 =?us-ascii?Q?fCMaBgP/ibguXhPt/6QuXDs/u2EIwFyEBtKiZof1H2z9xSSZOYB8G5Pia62m?=
 =?us-ascii?Q?Kl8lZf5zFbpI6RyPVgDKrzmYJqOpYweBkHY+IpY6Cmt3pba0SV18TYdKoLbt?=
 =?us-ascii?Q?FoKrSwVhjeFgF2N/60G/1x+IUSVV+izvDcVZrx1dnFpsTX8/eYpMsygp0SSN?=
 =?us-ascii?Q?2A2Ggzhr006qyEaJYQwQhZ5XQM8SoCyXiqsqEJEhPXvMCWIxzBTEOqlcUjAu?=
 =?us-ascii?Q?8pJk/fmSwOcW/pAp86QMhljd4c3N6sI1xIWaeWA3P8O92kyeqVA7iTx0/OHY?=
 =?us-ascii?Q?fLNsWpOegCEGJDi8h3VRTdaiWew+sM22E4GT3Dcx9+0co7FToTNWb6QVH5pw?=
 =?us-ascii?Q?ffrxg8BmCvAevoEDrV4IBdGcKWd1GhCscJo68p06hwC4+1nvMB3iTJkWRWVX?=
 =?us-ascii?Q?lsZDTbujh0s/TziIjfYtq6Rn0K3gaNEoYQ2u55t2I6SP8UbPuaRXHPZfc9VJ?=
 =?us-ascii?Q?gNanIa3G58IY7X4Lcp0zD0jQricJHODQe7B9WjPlWYZzKHl7NciwXDlOQZwK?=
 =?us-ascii?Q?4A4PNfMYaiLN3ihX/7zVg0bx9fFgE5doPJ8bHSxPzT3SirMA+hE47ZEOorVm?=
 =?us-ascii?Q?XDhe4ZLRHyhTW+DvoWQ7+SNQUbxxZmkk9x9+/hXFgrn1Xn/DO2mTU93WDIGa?=
 =?us-ascii?Q?KHHMgoOX8nWzphZDbWBn4uqdTlYvTxswUFpYiuMdJqDZbLoWFzmVCQhn4wks?=
 =?us-ascii?Q?q2CAUZ81T29GMjAGpC9YjRR0OdUGS2MHFsfkWac5gtfVZhldkDl3/qxbqNu0?=
 =?us-ascii?Q?JTfwOncoOLS3IcKkIJfyk5uh60ax8G8bLMBy6swqWvTeagMuCDJYVQeIboRn?=
 =?us-ascii?Q?3sDbY7Le8bOn9g1f8XBzeRtOQCE9PvEIvZAFSTd4xj5VFsTz4SXuenndek5f?=
 =?us-ascii?Q?ogK3VPE8L9CMI6GnUpq+qrjVRGZiXgAMt0/pE3+ZhuxifobXsSI4d1Z94vXw?=
 =?us-ascii?Q?B883hSC0x7+fy/WHFvNg/Nw/zL1mZlMhalhfBqdTUvxpsT7ZcybEIG3BTFcn?=
 =?us-ascii?Q?O2jA829pYNg7Y5BC5sePOfQWHbKgwzSqCs8VKf0BjHTBjU4EJfoJElY6EsC1?=
 =?us-ascii?Q?wgRCgxFPuKPcN+WakfOp8FQA6GDTB2N4AhQP+kusf6tx3pY2hXnCgT6GqaHt?=
 =?us-ascii?Q?T6QmcJIWObDTXB9loEWAnqVVimoZscXBJRf/N19HI75fOnHhQzkafroXM3tM?=
 =?us-ascii?Q?S+uhUKn6dOLBF3huczOTVnYO0voXvVEwSB+Aa/D/cp5VoPSfRkaVRXK7KqP/?=
 =?us-ascii?Q?GDl+etClNaeSgEabWaHvq3+5DLoOwRsdM15NbDJ8uWOxBsyVN2DalqVWPNN8?=
 =?us-ascii?Q?1z2qnfhcbkEXNGGWFewGQLqJn9cWfNG47fwUQym71xhLUggN0tEqOpRpz/RD?=
 =?us-ascii?Q?BPLFBqN46P6zLrWkkYbnHiZeJbSvTjNEIPUhSo3zIx6Fp4Ggqk3YX8Gl6fb8?=
 =?us-ascii?Q?80LPk6n6HfEzXrh96/xaMOOWDaUsEbvkju/lg/P6NcCzALu91ie4RGQWm0i1?=
 =?us-ascii?Q?sEbdlj7cv9OBFL7kMTt8XOYofXQsYIfV5wJCdHlQ2mUGHyDNwi5TFREtkWuM?=
 =?us-ascii?Q?ZBpmtJU90KWWwUdCjZJEh7KGHv5X2xLnJJKB47iussA52UdgyPokWhDKKyHT?=
 =?us-ascii?Q?mNzhCy4hWa3M0krCKILSJj7fRWIp3cCdns5Qb/34mKJDwut55djk?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e22eb9-beed-4544-f49c-08def4772774
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:33.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMJgUNsJ0KX8vADv6cKevnul+R/w3gwIAit8p0fah/JEbxJZE2NzqzTsw7jDGsNQzYHoUI574xoKidFQA0WTFznTUCticWizQTtLGBVN8xkPFg8rSDR5NewFUdMiK5Ru
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1252

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
 drivers/clk/starfive/clk-starfive-jh7110-sys.c              | 2 +-
 drivers/reset/starfive/Kconfig                              | 6 +++---
 drivers/reset/starfive/Makefile                             | 2 +-
 .../{reset-starfive-jh71x0.c => reset-starfive-common.c}    | 4 ++--
 .../{reset-starfive-jh71x0.h => reset-starfive-common.h}    | 6 +++---
 drivers/reset/starfive/reset-starfive-jh7100.c              | 2 +-
 drivers/reset/starfive/reset-starfive-jh7110.c              | 4 ++--
 .../{reset-starfive-jh71x0.h => reset-starfive-common.h}    | 4 ++--
 8 files changed, 15 insertions(+), 15 deletions(-)
 rename drivers/reset/starfive/{reset-starfive-jh71x0.c => reset-starfive-common.c} (97%)
 rename drivers/reset/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (75%)
 rename include/soc/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (81%)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 03c17cd2032f..edf4c45e6ff0 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <soc/starfive/reset-starfive-jh71x0.h>
+#include <soc/starfive/reset-starfive-common.h>
 
 #include <dt-bindings/clock/starfive,jh7110-crg.h>
 
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index d832339f61bc..29fbcf1a7d83 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config RESET_STARFIVE_JH71X0
+config RESET_STARFIVE_COMMON
 	bool
 
 config RESET_STARFIVE_JH7100
 	bool "StarFive JH7100 Reset Driver"
 	depends on ARCH_STARFIVE || COMPILE_TEST
-	select RESET_STARFIVE_JH71X0
+	select RESET_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7100 SoC.
@@ -15,7 +15,7 @@ config RESET_STARFIVE_JH7110
 	bool "StarFive JH7110 Reset Driver"
 	depends on CLK_STARFIVE_JH7110_SYS
 	select AUXILIARY_BUS
-	select RESET_STARFIVE_JH71X0
+	select RESET_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7110 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
index 7a44b66fb9d5..582e4c160bd4 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RESET_STARFIVE_JH71X0)		+= reset-starfive-jh71x0.o
+obj-$(CONFIG_RESET_STARFIVE_COMMON)		+= reset-starfive-common.o
 
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_STARFIVE_JH7110)		+= reset-starfive-jh7110.o
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/reset/starfive/reset-starfive-common.c
similarity index 97%
rename from drivers/reset/starfive/reset-starfive-jh71x0.c
rename to drivers/reset/starfive/reset-starfive-common.c
index 29ce3486752f..d615c4a68cc0 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Reset driver for the StarFive JH71X0 SoCs
+ * Reset driver for the StarFive SoCs
  *
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
@@ -12,7 +12,7 @@
 #include <linux/reset-controller.h>
 #include <linux/spinlock.h>
 
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
 
 struct jh71x0_reset {
 	struct reset_controller_dev rcdev;
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-common.h
similarity index 75%
rename from drivers/reset/starfive/reset-starfive-jh71x0.h
rename to drivers/reset/starfive/reset-starfive-common.h
index db7d39a87f87..266acc4b2caf 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -3,12 +3,12 @@
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
 
-#ifndef __RESET_STARFIVE_JH71X0_H
-#define __RESET_STARFIVE_JH71X0_H
+#ifndef __RESET_STARFIVE_COMMON_H
+#define __RESET_STARFIVE_COMMON_H
 
 int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
 				   void __iomem *assert, void __iomem *status,
 				   const u32 *asserted, unsigned int nr_resets,
 				   struct module *owner);
 
-#endif /* __RESET_STARFIVE_JH71X0_H */
+#endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index b178dc7d958e..2952719fa31a 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -7,7 +7,7 @@
 
 #include <linux/platform_device.h>
 
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
 
 #include <dt-bindings/reset/starfive-jh7100.h>
 
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 29a43f0f2ad6..87dba01491ae 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -7,9 +7,9 @@
 
 #include <linux/auxiliary_bus.h>
 
-#include <soc/starfive/reset-starfive-jh71x0.h>
+#include <soc/starfive/reset-starfive-common.h>
 
-#include "reset-starfive-jh71x0.h"
+#include "reset-starfive-common.h"
 
 #include <dt-bindings/reset/starfive,jh7110-crg.h>
 
diff --git a/include/soc/starfive/reset-starfive-jh71x0.h b/include/soc/starfive/reset-starfive-common.h
similarity index 81%
rename from include/soc/starfive/reset-starfive-jh71x0.h
rename to include/soc/starfive/reset-starfive-common.h
index 47b486ececc5..56d8f413cf18 100644
--- a/include/soc/starfive/reset-starfive-jh71x0.h
+++ b/include/soc/starfive/reset-starfive-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SOC_STARFIVE_RESET_JH71X0_H
-#define __SOC_STARFIVE_RESET_JH71X0_H
+#ifndef __SOC_STARFIVE_RESET_COMMON_H
+#define __SOC_STARFIVE_RESET_COMMON_H
 
 #include <linux/auxiliary_bus.h>
 #include <linux/compiler_types.h>
-- 
2.25.1

