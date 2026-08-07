Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47942FCCA;
	Fri,  7 Aug 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102189; cv=fail; b=hW7/aXRForAh87EGRgXt8F2P/PZU8MlYlKSEBp0KW7P1shecQyeBM4nc62J31P0ep7GPY+Nf1YfDYosG4ebYiol6dhiyb8JkbZ+GQzb+hPtFCegJQ1UR5Vw0RFngT6APXGMZ06Xge1lVFXsIEcmILjWV+FOnLZar+dUS8jLIBO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102189; c=relaxed/simple;
	bh=kp+5N8WDHHnhIC9ZE7D3GdPnN33OneXvXKIzPjZel0I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tlLt1Ypp9mLpratU8hZYG8mQt6fvMD6UKAhD9abUMkezIRLXKCLGpphyttcO4uTkS/UWpFR5LXHb9Q1/0YiOKh4leYHd0rGQw4buvGsUBM3q2DfZZT/HQfUuiG61Aq7qnpdtsEqRc74b4vnokAIzfVPTZUB7V+SMwPEJEga9S/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXhc18AMdEzWpFmUJ0s0PZeLaAkj3qE9SIjhIzQ5t7X2DIB0JIzo8oge+BsCSkGSKqbuAvVy32vJYoa81ipNgaX3vgUT5sHiABmA70zDymab3UEnSna2uG+LTiv73XveHqCrF0ZpzSYr5m1GpJ7gGyp3PrY7TwtTe+FEMmMJMDfsJBYU9m/ADbQDXdIlk9cucA41xZD9F4rNVqcZdDlVjIDaEJdruY0IVe2Ev9U0DGLv2sG14QImM61ZGr/iJBd2AVCn2cisll1ykCXArSvBArplK+ktHeVAR+aonA/Lxuql0nDzRHqRzwpjLVUEDkOGoeNdrftHNQgmVPX+FxT7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTuMUOcopC48Mbt54yY6GaQuKB5E/PYSsSp/9/uqHJs=;
 b=KzoFFtpeHcNSy4KqEHmx1A79Q3TOSDrAGEAEkxNzHWRORj+zAwEiTAMVR1I52UDX0gjcALUB3b1lrnAiU3Jhd95p9jHvqM1JynBAPXl25gHHhkjok7tlh+pxFWwWvy8EceTNTgposojPpQ8F/TbOc89/F/vu5wlUsaQuWIkv+YW7e/QQHvD2sAUkTkjFizgtPTZFE9Zx+EqJ5q7izE3hNDRMc8fzbBLqlxaPcYU+IonKgxmiBbdcFjOaw/AX3XmNWlp1OV0XQRZJayM5vr7nQjOtbIRkZDyJUZUEWuKpVo7QIn/fAU3BUBynHby65JuZ+Cx3PHCNZAonMuTht7mu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1252.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:32 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:32 +0000
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
Subject: [PATCH v3 00/22] Add basic clocks and resets for JHB100 SoC
Date: Fri,  7 Aug 2026 04:29:01 -0700
Message-Id: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: dbb5ba94-43c1-43e2-a1bc-08def477266a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|52116014|6133799003|10067099003|56012099006|921020|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	R3GG/5u7nBN38++vkolNu2JS+ctnDsGHF8PnbQ9N1VIMRQiWNwccBjd5geAx967yeGnnhf53MJPASEfc8JsKBVcR15Bmt0w1cEUp3hXXe/kqD4oSPmUd6i/jBKiLSPIF3xz44ojQpwtoaSaZizw2tRhiPuUWszjPTWohz1iXf8hftOYqlwvlIC4/yqGjXdlOhGEUEjjn1HNGSjjHHRJG2M0v084JbZhauJ5oLgYBjgAIKwmrAVRtIhDxuBu/9rlNKpSy2eJmhESSANY5wNHUjPq3hVNMyx/Asz24EDJglT4+bzGxqJdpt+T3j9qSYCKTlwIhr+MSWmzkGrE4b+eAk13sQKQU10mmbc4JBVAD0Q+XHW1W8wwLuAcW4wAqDqjLpGbqutQNKnP6ndO2h4qZQN9Tvgv+RMroUR+sCURYUq7dpfx6Pm85I9QH4k4Uu86vZVZidJM7yjnvglZv4hQq0iy28n0f8OM76TiyTB6w1bU7dwUoqaog6WvztDdmU2rsHa9VMkQxAYgmSMTXj5S+mxKbBoWzTd+pkfdwh7Mmz5/QpsDiZ+R1yxT8nU8zOO15rZdmLitNvAcs/FRLr7MGVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(52116014)(6133799003)(10067099003)(56012099006)(921020)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hYtuARdlKxlV9glezHfNmMY+ke8YW+/i7jrFVzqJtkdX345o3MptYt8ByO1N?=
 =?us-ascii?Q?CGV2uc7k3xGj8uHteUQDADqx4sNvD60byXWW6Esd/mD3WQKe9UMwt8uaSyEm?=
 =?us-ascii?Q?oJZ1gN561XQXTKAgJnXPleMBvuhHdIzNLWhd1v2tEanhKnQ0L9T8Iuofaytx?=
 =?us-ascii?Q?+SZBno+E9iv7NQzIxTDLqixiDcEq5/K0sOEhiQd+kz/x82fZm2GYmRQGJ1Kd?=
 =?us-ascii?Q?x0YTxDFveOh9/rXAVs2ASn9OK48jkHSYegBPXszzNAGnebZztPkkfHom5wx5?=
 =?us-ascii?Q?o8/WjJweJTB5cYo/sVI9YrVPf5FXGYp7jZFLBNqguam+ADB63bEv2qS8igMS?=
 =?us-ascii?Q?OwUo8zQOnjr9/b+mhvnkobuJdh17/KprFiyViLW2PDlnWChCBcqo9ZMQqj5Y?=
 =?us-ascii?Q?GBrKOveb7d7m0n4tSzOKoZkMpZyAvWIfDL9uc+6pAJ4xgd9oHuyLhYVSGqUg?=
 =?us-ascii?Q?4NJU0B7poRr75QA11SkyT+wytAjexAMDJnFfxQTzMcu3tXzAl99mTRDM8DK+?=
 =?us-ascii?Q?1XopSBu38yfijwnkdNYIaI+3SCTpieatt8CeCYbBmd1nl07rd9kl6nCj3nmT?=
 =?us-ascii?Q?KriAnEUXIIPGhhWBvRkgqHTmgfBjQGCKflBefPhGqRs8WyIMR2qOjnR5Thr7?=
 =?us-ascii?Q?YTSZulEF+3ul3dxH6O+f8H//jCkj7AX+zPWco74PbQIuzZft7DYxa0/mPe8j?=
 =?us-ascii?Q?5HJOdUMijzFR1tdcVe764GQrfTInQX+97doTJXZIBNhdg18QI4v9a983JYIM?=
 =?us-ascii?Q?aRlOEOJT2yZ9dUojhdG1UyZYr5/ah1Ke4I5Tz+jH8qdZ164iKOcLoROEXMEC?=
 =?us-ascii?Q?Tp8raw3QS7dovI+zw+pkwsa+2r4DAS3ZzndEj7Jc9CpkXu7+wJfVbdLTDMTG?=
 =?us-ascii?Q?AVeTesexW1Bi7hDxJUrOe8W2NGMJbQeFFhttOrPDQIg8flsg54uUVcS/GlG3?=
 =?us-ascii?Q?KPAL7IX54k6r3uNuenNCozk4d9onHgrxY5pFBosApxZyFUhc0wErxgXb6TXU?=
 =?us-ascii?Q?8/vtB9aMveFOoTW4wdxOggjFPX4mv9374tfkBWbdlpHxCJUJYlV/hbCRhf78?=
 =?us-ascii?Q?QIiIL6yJG5rytll4rYdiH4pwci7yoq8IDbzBVmp/Rft1lJeLs6PZc2bwgL7M?=
 =?us-ascii?Q?zm/ofYXtOvDl+xuh01Gb8nX1hgy4/vQ1v2Usza/bFPy4TwQNJ7SRxkfyADHk?=
 =?us-ascii?Q?o0jGmpAKOkhp2IZQvydPAt+apqP+u5WYcK5R0goGoAuaHZYlsvlCoOlAes7C?=
 =?us-ascii?Q?wiKq7LYjzUa8TFSw7a3AmZY3Fm4s3WZm2dOO2+tuT9/C7FJ6LOir2C9TxpZH?=
 =?us-ascii?Q?TXYbSA3xkmCB+qGnFwGHKPknw05z/uvo0dJuh8dZZor4H7KMSihEgTTEXcGL?=
 =?us-ascii?Q?/c4iWixRGGkLgn9ZrRiMcIEwYxcdsan18XPWezB2ao7/haopta8BhirR10wO?=
 =?us-ascii?Q?F9aBoQ8v0F5xD9froGqBek2JZSXMqPN9MyXPbNtgUMTEH52lLHZxewh5LrIe?=
 =?us-ascii?Q?KQ6ua7A32KRkQzCRkGyy2/hG9ElLuFsVnPvz2ZKfC59KeVlKctWbfYLbGjIQ?=
 =?us-ascii?Q?C2AwX6RQSNIQGgef/UVRKiHyNH+1Z9OGD5CkDiGg9hTG/z8INsVyLkelfx1/?=
 =?us-ascii?Q?RtT6RZx1HTs79VmsvTbQ04VNwDCUeGbBeIj14e9E5mtO/sL9udCNXdTGLEes?=
 =?us-ascii?Q?t1eef9dltBzebc8PajQ+yPf9T39RIq2pxErEQtMTAA6EX9K4WTjuRqAznLEh?=
 =?us-ascii?Q?flHs1NidgUNuJc0YAyO4uaydBOKZE0HiavWoYfnRi/jdD8M14m+2?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb5ba94-43c1-43e2-a1bc-08def477266a
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:31.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdzexNlwNklZzSc264hM7N3cnkXrTSWJbvvLhDLvgcx6zkJpAuCMMd0LPPGfHANUWQ+vPZXKfcdjqC8z35e1qLTgXP/UzWHBwSNb4IUxwrNkP/fEUgOuZx20bad5EJge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1252

The JHB100 SoC includes CRG (Clock and Reset Generator) for multiple
subsystems:

The JHB100 SoC is divided into multiple subsystems, and basically
each subsystem includes a CRG(Clock and Reset Generator):
 - sys0crg/sys1crg/sys2crg/
 - per0crg/per1crg/per2crg/per3crg/
 - voutcrg
 - vcecrg
 - gpu0crg/gpu1crg
 - cpucrg
 - usbcrg
 - host0crg/host1crg
 - pcierpcrg
 - husb0crg/husb1crg
 - husbcmncrg
 - husbd0crg/husbd1crg
 - npucrg

In the current series, we will only add the following CRG:
 - sys0crg/sys1crg/sys2crg/
 - per0crg/per1crg/per2crg/per3crg/

The remaining CRG will be implemented in future series.

This series depends on the series:
https://lore.kernel.org/all/20260806122553.182449-1-changhuang.liang@starfivetech.com/
and it has been tested on the StarFive JHB100 EVB-1.

changes since v2:

PATCH 5/7/9/11/13/15/17/19:
- Fix file name errors:
  <dt-bindings/reset/starfive-jhb100-crg.h> ==> <dt-bindings/reset/starfive,jhb100-crg.h>

PATCH 6:
- Execute kfree (rdev) on the path where auxiliary_device_init() returns an error;
- Check the return value of devm_pm_runtime_enable().
- Replace struct jhb100_crg_domain_info with struct starfive_crg_domain_info
  for common files.
- Restructure index validation in `starfive_clk_get`, add sparse
  hole check to return `-ENOENT` for unregistered clock entries.

PATCH 6/8/10/12/14/16/18/20:
- Repalce module_platform_driver() with builtin_platform_driver()
- Add missing static qualifier.

patch 21:
- Mark struct starfive_reset_info as const.
- Mark struct starfive_reset_map as const.
- Fix typo: discontigous ==> discontiguous
- Fix typo: JHB110 ==> JHB100
- For discontiguous type of reset controller, use ARRAY_SIZE()
  to calculate the number of resets.
- Add STARFIVE_RESET_ID_INVALID for handling invalid ID cases.

v2: https://lore.kernel.org/all/20260508053632.818548-1-changhuang.liang@starfivetech.com/
v1: https://lore.kernel.org/all/20260402105523.447523-1-changhuang.liang@starfivetech.com/

Changhuang Liang (18):
  dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset
    generator
  clk: starfive: Add JHB100 System-0 clock generator driver
  dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset
    generator
  clk: starfive: Add JHB100 System-1 clock generator driver
  dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset
    generator
  clk: starfive: Add JHB100 System-2 clock generator driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset
    generator
  clk: starfive: Introduce inverter and divider
  clk: starfive: Expand the storage of clock parent index
  clk: starfive: Add StarFive JHB100 Peripheral-0 clock driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset
    generator
  clk: starfive: Add StarFive JHB100 Peripheral-1 clock driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset
    generator
  clk: starfive: Add StarFive JHB100 Peripheral-2 clock driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset
    generator
  clk: starfive: Add StarFive JHB100 Peripheral-3 clock driver
  reset: starfive: Add StarFive JHB100 reset driver
  riscv: dts: starfive: jhb100: Add clocks and resets nodes

Sia Jee Heng (4):
  reset: starfive: Rename file name "jh71x0" to "common"
  reset: starfive: Convert the word "jh71x0" to "starfive"
  clk: starfive: Rename file name "jh71x0" to "common"
  clk: starfive: Convert the word "jh71x0" to "starfive"

 .../clock/starfive,jhb100-per0crg.yaml        |  70 ++
 .../clock/starfive,jhb100-per1crg.yaml        |  70 ++
 .../clock/starfive,jhb100-per2crg.yaml        |  76 +++
 .../clock/starfive,jhb100-per3crg.yaml        |  76 +++
 .../clock/starfive,jhb100-sys0crg.yaml        |  63 ++
 .../clock/starfive,jhb100-sys1crg.yaml        |  71 +++
 .../clock/starfive,jhb100-sys2crg.yaml        |  64 ++
 MAINTAINERS                                   |  13 +
 arch/riscv/boot/dts/starfive/jhb100.dtsi      | 198 +++++-
 drivers/clk/starfive/Kconfig                  |  85 ++-
 drivers/clk/starfive/Makefile                 |  10 +-
 drivers/clk/starfive/clk-starfive-common.c    | 487 ++++++++++++++
 drivers/clk/starfive/clk-starfive-common.h    | 147 +++++
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 127 ++--
 drivers/clk/starfive/clk-starfive-jh7100.c    | 503 +++++++--------
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  62 +-
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  72 +--
 .../clk/starfive/clk-starfive-jh7110-stg.c    |  94 +--
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 525 +++++++--------
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  74 +--
 drivers/clk/starfive/clk-starfive-jh7110.h    |   4 +-
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 339 ----------
 drivers/clk/starfive/clk-starfive-jh71x0.h    | 127 ----
 .../clk/starfive/clk-starfive-jhb100-per0.c   | 599 ++++++++++++++++++
 .../clk/starfive/clk-starfive-jhb100-per1.c   | 149 +++++
 .../clk/starfive/clk-starfive-jhb100-per2.c   | 174 +++++
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 132 ++++
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 150 +++++
 .../clk/starfive/clk-starfive-jhb100-sys1.c   | 105 +++
 .../clk/starfive/clk-starfive-jhb100-sys2.c   | 129 ++++
 drivers/reset/starfive/Kconfig                |  15 +-
 drivers/reset/starfive/Makefile               |   3 +-
 .../reset/starfive/reset-starfive-common.c    | 211 ++++++
 .../reset/starfive/reset-starfive-common.h    |  33 +
 .../reset/starfive/reset-starfive-jh7100.c    |   4 +-
 .../reset/starfive/reset-starfive-jh7110.c    |   8 +-
 .../reset/starfive/reset-starfive-jh71x0.c    | 134 ----
 .../reset/starfive/reset-starfive-jh71x0.h    |  14 -
 .../reset/starfive/reset-starfive-jhb100.c    | 302 +++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 542 ++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 186 ++++++
 ...rfive-jh71x0.h => reset-starfive-common.h} |  10 +-
 42 files changed, 4895 insertions(+), 1362 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-common.c
 create mode 100644 drivers/clk/starfive/clk-starfive-common.h
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per1.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per2.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per3.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys1.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c
 create mode 100644 drivers/reset/starfive/reset-starfive-common.c
 create mode 100644 drivers/reset/starfive/reset-starfive-common.h
 delete mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
 delete mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h
 rename include/soc/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (50%)

--
2.25.1
