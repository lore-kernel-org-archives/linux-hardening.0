Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E34DAFA4;
	Wed, 30 Sep 2026 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772233; cv=fail; b=dARZiE2EOBuNeyx6mkUTmhhUkCFnBCgqzSkZmRyqdS8466RMsJXsYfOSydJBNdQWG2SVgpynL2KpOd4T163X8Slt/2waltwed6y0H5QPUQLXrYWnEgw031UaUxtWMCi9hd5Ne9aPzkZHTysC5f4tZMBfvPZQhkbuoVDD+E2lgus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772233; c=relaxed/simple;
	bh=wjMsCJVW98TN4PBUv6MiH3veqXqkOcyObH8bVCHFZqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJqjFpevE2dtB1WryjfqoR7Y30/b432+NC0dLdXQVqBb7VGjfrLhTJX5sojORwXRfaz0aBCH8cUDwpR+MsKJHUMZSMe2a8wg4zdvXMj53fuMJVvd8gEApQ0nAdtCX/BtFqlVqIH0dVtVobCVtIISGDiknfsBTScc8KGgFqKTg50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCZYRr53hZOy5RIENjE+zKvcgD1PbDm6EmzgwnKYnNUg0EQEiSKCJgV8PLIiWHxbsw1OqgYnw3MDgGDhFOnY0RDRD/caHQDu5MKaQiO3yGOhgqBAjE/0nQ5mv4M4lfwsHjC2m0ZB4okai+H3sViunIylg5NgsXCxvB0wKLKRrmFE0cjzD9JyNufg9DfmzqdwMrMNJE4Bn/q4uQIWX0m3hWFMwJ1OJHqdA12+YWjt6u1PLZQFeYptYwc8UAfHp27S+v7+Wt5+ByBbif7x36sfzbUTreaRwNGvHq89bUcR6vc6J45QJD3cyuBTgs2l+JOgrykcKrDidD3xpFB9xwRfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxN378Fl91XwyIRxcPY3l9M7RWfQNVX8cDr5JYi4Mp8=;
 b=WRBYLEi5n/LEOHS/fbNwssVzc8ifAdsQ1eF2sdRGg4s8Gi5Ft7TmAv9trQw1cePfHl7epNqt7mvzj18l9hp61mAa8S2Po67eSbRYUmkBi4diWS7IfAOx9XbktK0WTs/2B8xT6KBCwrt47hL5pzKEU55KfEHGDh5eTXsp7bkk9Lh2c5aHAcZFXbffLGMbj8+/pwL9104XPkQml05hnBwinQBkSchY0lze/dtgI3UP97LnfRZMWHYoXU9h6u3VWrIOii09LGgbnJh1bUFKTQYwObrqCKDhJv04YreTTcrihN5zlxw+ARstHS4xNb7P0o+ii5CR1IvLXjhrcpeVpzQAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1297.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:35 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:35 +0000
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
Subject: [PATCH v5 02/23] clk: starfive: JH71x0: Move reset controller registration to jh71x0 common code
Date: Wed, 30 Sep 2026 05:42:56 -0700
Message-Id: <20260930124317.5648-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67f02ef9-288a-4bfc-b36c-08df1ef07131
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|52116014|10067099003|56012099006|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	yX3as+jQ8FT+gIEaL39UqfmqvM3AlZrmodSJ4/Kj9ei5TVFsfZkkgJZo60YPpSDrAtRVtV0Jouxcjqt73A4mTxRlxrX/oqRUGAPxNPJUkGaClu+DdYNS/FlwGwtnp4nES+xk2QMj9C3jdnYPSjzVI1vQ6eTF4qsbmlFWNQp3l1Ta2u9DSbwkQI7/50nyo6CpRKvFYG8OSkdbr1Y0vd+hdOjKo8eSQl05LFUptLEqip/5s2QmopGbX9OIISxSjq27h46CzP1ZFspR5QsMeqhPbYes3588pVu5r/sd0BhgwVl8ynZy3C/0eaozgtW70HRBGnSLQ6tUCo9FeOV0X1wJDl/N+r0QMvBcgo46hydYdf///oSyOBmqlwU4IFpooiCJrFrlZyKLFcpiEM1npoABx4KYwYv/icgHhq5Qm8enIgMe04kNU2UuhOcfpCGMw54vHWYif/LZbKlUCxrAsWmUHAIwsPdn+0Y/lzJfyTCPLFLZngVu+QImdS1tDnrNkVG7Rj1kk7gLUjwYdBHxQubzBuFfHqNXbMXs/pHPh1IPYz41QPgQSIh47kqSHJPQdvFSt1O0L+qWsIZXEgv7g9Zt2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TudHOum1j4r4HddqVLUNxgw3caDcznYCJa0jIKQ5pIeYPMKWxQWxSz0Lnaxx?=
 =?us-ascii?Q?5y/FYIKUwAs8w0xq2Ka+jG78sfNvnbRlrTRU2OMLH9AhEOHVM8yUPxi1Cx/v?=
 =?us-ascii?Q?b+IJ7SMEWZfvFPwuEFYdRVhC7WW5JCJ3aYtG1SWdj7Mw7NzhuJymt9+OcwJW?=
 =?us-ascii?Q?L9DQKqMT/IvjJUYGRSbyHuGV6BH84Y7x83/hI/c4BveGwv5nxLnV8M/0GChd?=
 =?us-ascii?Q?TuXWsb0KmTHqjt/lhulEWZcrHicvEttX80xRqE87yLbjswnRW1dKCl6WgxMZ?=
 =?us-ascii?Q?v+yxXr92P7aMK1OtkxaJrB1HDCghrR/inMq7qoyBAuOX3c4ydumj+F4Cz2mj?=
 =?us-ascii?Q?tnEjUEH5rRRV28BdV5sEfTihpywzj2FPFwuA+eRcjvzanQ0ZhMESB+7i1xWX?=
 =?us-ascii?Q?O3KM4kbADUexxJN47MLEFh9KT3lQgaUQdmD1mTaEJ35iK59ytKbwWY9QFTux?=
 =?us-ascii?Q?vOwvDuvNVc/oF3C7sYYFm/kiQ0ALxjwXMclGh633kJNohrotLoRTj/XjgdMx?=
 =?us-ascii?Q?lGBBkRUurqklqr0uoFaaOZQic2J+LTQ2Od9GMAeqnWPlnxiZtWBWkdGgn7uk?=
 =?us-ascii?Q?beuWS7VYmpR01UbLX336htGBaIOlzU0JDmuvzyMbYjFpTVVE9TcojJdNPqdr?=
 =?us-ascii?Q?sGNqHkI2HmALBuGVtFJCDnGeCXCYdXHI/RSe8W4Tro8w0C09DnJJrY50nQzk?=
 =?us-ascii?Q?09yYAxWGdiVihq2KjRAO20ZKRIQ7hkgcsYa21bvqFpR1ULwJar4QsR6t/Z6E?=
 =?us-ascii?Q?wl7peKQkOByxykvbeg/htqmJ92Zs4a6S2mS0DUkMYY1eEnPEwPaik+5PiNEG?=
 =?us-ascii?Q?IeMrn0ZFK5A75+ajKRiHqqjSGjr8aS/PJxzbrDxY/hiwPBx5kp1FEnliEkL7?=
 =?us-ascii?Q?xAGsntRBeOgaT8C5GukLz16sN0Cc9LIddr1zudbYfssyPW4QSqndnNTORLpu?=
 =?us-ascii?Q?5ozdEsLiRsK5lXAwQTqJoChm6S0U6b0CfcesFtnAJRNsVIO4hrAgBpL1f+ZI?=
 =?us-ascii?Q?EJun0N4wnftnscYJh0PhMTfv5FtGLeK5TrSpHgZn/y6WpBrlbgaYKsU26F+T?=
 =?us-ascii?Q?N57SlV47EcSscQvRaopNhTxZCPqHMvqHOhyFn82SBGP69hjQMn9j4uOByfZM?=
 =?us-ascii?Q?unSrNNVVGUJNjWwWdeuxrTWegZMhOgb69VMVftXlz/6FnJQaMMkQ/jplWjk9?=
 =?us-ascii?Q?EB4XePupl6UnaY8x319N2HlhfCoXkHcdI/1rdh19+hJNVrBKwykEM2k2vmx5?=
 =?us-ascii?Q?N1y8cd7t0S/o+U04i6EH8Ey2t4cSyTpIjxB1uP3aV91n+BN4AL5TJM+uR/r/?=
 =?us-ascii?Q?Xa6JfzwqO+iiZmZX7HQpiYCgFCnsB5RbltN66ROATXr5Mjb/XiDN9A7bywr0?=
 =?us-ascii?Q?RzWbkdSDZTHiPqwAsig4wqqm2W3sHDJAQdFqT91HIZsa3+3ZrDzBStqYmMKT?=
 =?us-ascii?Q?hGM4UOGm4I4l+ObYWQ90iAp1IWzqB8afWXgal/QUUOXsBNWqmwatttdSsatU?=
 =?us-ascii?Q?1k5YiKyjAyPW/3yc1MsF9UHPypWt1yI/0216Zb4pgLbIirDdJg6EtxOBB1FY?=
 =?us-ascii?Q?V92qNNV8OX+1/KRV96pQRwgxnF+tblWqJTzH+rpJnU2FAijEeLX8CYh4I4FN?=
 =?us-ascii?Q?VqmyUOzPD/E5HBFWNJRE0ax9p1SDXjt+LHTplPL3FAqjL81LtnmbkO8erixe?=
 =?us-ascii?Q?90ocfL3oiKcY4Q1fU49mtdrnK2z6rrZCHPuAHA10oGjDo4ntuuZZmt5KnUZl?=
 =?us-ascii?Q?N62cYuZso5BMuYwdv3Xh7/XmRGen+2Y2OQhlAKZXLNBYytJaJV1a?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f02ef9-288a-4bfc-b36c-08df1ef07131
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:35.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmWBDlcbN/cINXuLsZ5LCt6WH0TbCA1DWiuk4ALdWMrDcOIemKhmL81jtphJK4xSPzL9+VxgIivWZBhM//z7Hux3koG4WCrOwpCFcchiLCClhmhSRDzRd88d1G+H3ik+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1297

jh7110_reset_controller_register() is only tied to the JH7110 system
clock driver by its location. Its logic is generic: allocate a
struct jh71x0_reset_adev, point it at the CRG register base and add it
as an auxiliary device for the reset driver to bind to.

Move it to clk-starfive-jh71x0.c as jh71x0_reset_controller_register()
so that the clock drivers of other StarFive SoCs can reuse it, and make
CLK_STARFIVE_JH71X0 select AUXILIARY_BUS accordingly.

The auxiliary device ID is dropped: every CRG already uses a distinct
auxiliary device name, so the ID is not needed to keep the device names
unique, and it is always 0 now.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  2 +-
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  2 +-
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  2 +-
 .../clk/starfive/clk-starfive-jh7110-stg.c    |  2 +-
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 59 +------------------
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  2 +-
 drivers/clk/starfive/clk-starfive-jh7110.h    |  4 --
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 54 +++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 +
 9 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index bd29358ffeec..51716655554f 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -2,6 +2,7 @@
 
 config CLK_STARFIVE_JH71X0
 	bool
+	select AUXILIARY_BUS
 
 config CLK_STARFIVE_JH7100
 	bool "StarFive JH7100 clock support"
@@ -32,7 +33,6 @@ config CLK_STARFIVE_JH7110_PLL
 config CLK_STARFIVE_JH7110_SYS
 	bool "StarFive JH7110 system clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
-	select AUXILIARY_BUS
 	select CLK_STARFIVE_JH71X0
 	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
 	select CLK_STARFIVE_JH7110_PLL
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
index 6f67587f4335..66f1c56a7169 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-aon.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
@@ -121,7 +121,7 @@ static int jh7110_aoncrg_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return jh7110_reset_controller_register(priv, "rst-aon", 1);
+	return jh71x0_reset_controller_register(priv, "rst-aon");
 }
 
 static const struct of_device_id jh7110_aoncrg_match[] = {
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
index c02c8b29a123..f8222d3c81ee 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-isp.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
@@ -180,7 +180,7 @@ static int jh7110_ispcrg_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_exit;
 
-	ret = jh7110_reset_controller_register(priv, "rst-isp", 3);
+	ret = jh71x0_reset_controller_register(priv, "rst-isp");
 	if (ret)
 		goto err_exit;
 
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-stg.c b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
index 2a5ad0e07d1d..5ae63e18aa4f 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-stg.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
@@ -139,7 +139,7 @@ static int jh7110_stgcrg_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return jh7110_reset_controller_register(priv, "rst-stg", 2);
+	return jh71x0_reset_controller_register(priv, "rst-stg");
 }
 
 static const struct of_device_id jh7110_stgcrg_match[] = {
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 1d460a03f936..6c5e9c54dfcd 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -6,15 +6,11 @@
  * Copyright (C) 2022 StarFive Technology Co., Ltd.
  */
 
-#include <linux/auxiliary_bus.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
-
-#include <soc/starfive/reset-starfive-jh71x0.h>
 
 #include <dt-bindings/clock/starfive,jh7110-crg.h>
 
@@ -323,59 +319,6 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 		    JH7110_SYSCLK_OSC),
 };
 
-static void jh7110_reset_unregister_adev(void *_adev)
-{
-	struct auxiliary_device *adev = _adev;
-
-	auxiliary_device_delete(adev);
-	auxiliary_device_uninit(adev);
-}
-
-static void jh7110_reset_adev_release(struct device *dev)
-{
-	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
-
-	kfree(rdev);
-}
-
-int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
-				     const char *adev_name,
-				     u32 adev_id)
-{
-	struct jh71x0_reset_adev *rdev;
-	struct auxiliary_device *adev;
-	int ret;
-
-	rdev = kzalloc_obj(*rdev);
-	if (!rdev)
-		return -ENOMEM;
-
-	rdev->base = priv->base;
-
-	adev = &rdev->adev;
-	adev->name = adev_name;
-	adev->dev.parent = priv->dev;
-	adev->dev.release = jh7110_reset_adev_release;
-	adev->id = adev_id;
-
-	ret = auxiliary_device_init(adev);
-	if (ret) {
-		kfree(rdev);
-		return ret;
-	}
-
-	ret = auxiliary_device_add(adev);
-	if (ret) {
-		auxiliary_device_uninit(adev);
-		return ret;
-	}
-
-	return devm_add_action_or_reset(priv->dev,
-					jh7110_reset_unregister_adev, adev);
-}
-EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
-
 /*
  * This clock notifier is called when the rate of PLL0 clock is to be changed.
  * The cpu_root clock should save the current parent clock and switch its parent
@@ -525,7 +468,7 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return jh7110_reset_controller_register(priv, "rst-sys", 0);
+	return jh71x0_reset_controller_register(priv, "rst-sys");
 }
 
 static const struct of_device_id jh7110_syscrg_match[] = {
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
index aeba42cd3c44..14e5b8286671 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -189,7 +189,7 @@ static int jh7110_voutcrg_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_exit;
 
-	ret = jh7110_reset_controller_register(priv, "rst-vo", 4);
+	ret = jh71x0_reset_controller_register(priv, "rst-vo");
 	if (ret)
 		goto err_exit;
 
diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h b/drivers/clk/starfive/clk-starfive-jh7110.h
index 0659adae4d76..55374ee24d4d 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110.h
+++ b/drivers/clk/starfive/clk-starfive-jh7110.h
@@ -10,8 +10,4 @@ struct jh7110_top_sysclk {
 	int top_clks_num;
 };
 
-int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
-				     const char *adev_name,
-				     u32 adev_id);
-
 #endif
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
index 80e9157347eb..2cc71f49ddee 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.c
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
@@ -5,10 +5,13 @@
  * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/slab.h>
+#include <soc/starfive/reset-starfive-jh71x0.h>
 
 #include "clk-starfive-jh71x0.h"
 
@@ -337,3 +340,54 @@ struct clk_hw *jh71x0_clk_get(struct of_phandle_args *clkspec, void *data)
 	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(jh71x0_clk_get);
+
+static void jh71x0_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void jh71x0_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+
+	kfree(rdev);
+}
+
+int jh71x0_reset_controller_register(struct jh71x0_clk_priv *priv,
+				     const char *adev_name)
+{
+	struct jh71x0_reset_adev *rdev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev = kzalloc_obj(*rdev);
+	if (!rdev)
+		return -ENOMEM;
+
+	rdev->base = priv->base;
+
+	adev = &rdev->adev;
+	adev->name = adev_name;
+	adev->dev.parent = priv->dev;
+	adev->dev.release = jh71x0_reset_adev_release;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(rdev);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(priv->dev,
+					jh71x0_reset_unregister_adev, adev);
+}
+EXPORT_SYMBOL_GPL(jh71x0_reset_controller_register);
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
index 9d5dec1d5cd1..322a05157faf 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
@@ -123,5 +123,7 @@ struct jh71x0_clk_priv {
 
 const struct clk_ops *starfive_jh71x0_clk_ops(u32 max);
 struct clk_hw *jh71x0_clk_get(struct of_phandle_args *clkspec, void *data);
+int jh71x0_reset_controller_register(struct jh71x0_clk_priv *priv,
+				     const char *adev_name);
 
 #endif
-- 
2.25.1

