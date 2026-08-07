Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4F434E42;
	Fri,  7 Aug 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102267; cv=fail; b=FombSjV3Ugpmk+R6DDIvlsiS+gkheP8WTtRfkZYS9yBaKdNXf+ti9pPBZ/herubrMmKvktShvAcWAU6MmH4pF5pRvI8njhJAuRxC8I6ISEtn4nDAGTCwD0iDiNrcyT4C8FrMmDCZ/OFJYdcljfZbRwUmibXtrnPkk1y4JmU3RSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102267; c=relaxed/simple;
	bh=plSE5abZ/49zbOYcoprNoj+7ogW3xrjqvK7AgzSILXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0LGxEw5Gk8ni83KvlfyDnxYH54HMq/c1YkZobm64dgn+3FY/I2mbnzq9f28vHzCe9TEouvzdZaTAPxOYQa7yEtRMzKle4ffTWOHYAysksrJNMMP9HG98YmNpMaHGKCeE+ugehYzgQ0Te94+NUYhsF0YZgmXmPejttjLGhENeQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivqrZVOZAT2HUQrXPNWfIaWsj4yxpP3ZCHjBbsrZyLLqN0TUR2sN4TcmjNCTxswE+MIqq1iVfqyMcmarPuPMdj+1IVgVBhCgryNiOsC9Q/suuuFOO7+pna0sU985QEJLqNGPpWQGjSNvDgw9MQmfpbjkw323PniWb42ND3JIHsSDk3vIN2Ii4hpGbBhGRo3GfPKV0IHgQEjxOV0wqud7eI/z8WrbNyWc/mlBci1guxW78jLz6PPQ0AulXVVs/qSBPJlmuQKbF1Od1vi8HbUm8ORasyONCRkTkf5NwcvzPU9xZAHEGEIgqCCoDOQuWV1DJkoBJpjZ3ViGCCVJxV2JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43tX8xlN4ln6jA6AqCWImBv00xjVAiSXHe0yjCmIQxk=;
 b=IdTQxX9zT+FOvGW5WWVw9Y+gDfl+I1O/8WkSFSShmIljH8MpLKpl/93guCBzisETiaw9nhKoA+vCxSLRxm2/bLiFFRe3q8ArK4gvLTJsVBZwk2M1khxXAe2boC6qmUJtsG9Vk24Q5ni/fiXKyVH08YuMn7d6ObXm/rrwufHffVFpq5zEULje+/r4Kn0j4pDzsrcsDi5NLX9SDlBKRUG0EgeSMfqhtYPXVNZWPp8KvsEKSZt2cTeBW8Wk026t5jj4AgxO/THyvbNckKqPa6Qtccqc01xjt94nk4bRy2LE40ZsypSq9EMOZKyCgNhzc0dmkzowGLAtmnCjzFlM9NwuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:40 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:40 +0000
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
Subject: [PATCH v3 05/22] dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset generator
Date: Fri,  7 Aug 2026 04:29:06 -0700
Message-Id: <20260807112923.191627-6-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec01f2d4-1927-4f62-fc10-08def4772b65
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	XrA4+QJBOZH4DUqAFK5X1Pu/8IiG+TpIevg2UBY7ZCaID6dMfDT+wJF9sRE4SNlY43b+qfGHnps40C91QAbp64A13nYD/4q3qgcdX3/QT8naYFGgcvg3dGWQnycjAPlUBQQo+vxI++I/IJJX0kYNOZZ/l6n1XfGsSKC3vePTyH8H/iNn6A9Tm3cZ04uk1EHOM2X/mntm/C5JbsJohpnFvL6qyNOJ5Hucp0QR12UxH6j41sViuL9S/CMbUOCyXYD4LttvZlgD4q1ncoTTZuVcslmV7P1TViLgOCfWZD1J3mkz+G1VP9F4VRrBSKeiLoYD4bkiUOOcalP/Xbx2OPCZJaD5Kk05TpF1ytwOkZP16fTWvnkJygszylySenhFTSulEFEMy5oTFEY9j0i8NrIMams7bnbdLgjaqDli7NGmzd3/IijcByoz7z7Tj0UZ3dCv43deywiHM6AG460GJnKjQMq33w6J9rxQe2mr8BYhT86Qr7z9clVc/0Drfe6th+KWD8yS8LQLvPpPmhrvAvA8EU57JbsmDAUyjBd7lFsXVSCXrEJXdIK52uZcbl3LKUNKcv4mySG/rvyQHDy0FUmBwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XVAvh4wYQuTCXNECyteDU8hlRzkoFtn+4dVRLz7hRrcPd9RkUmZ0oPnJdxgD?=
 =?us-ascii?Q?ALzcxM844gz3ujedaTtWkrUV2/hLT9vraRecE/myUXfAl06ydBW1/c7yO362?=
 =?us-ascii?Q?N7Xw/hQid1UGBiYm7GZqisOYdF/qW6YtdYmnk8ABcC3W1Kr87BX0F0A99/M9?=
 =?us-ascii?Q?xc/I4HibpIjj94lGLsItFugz7QI5GPUXIHG7GK2mo8639x9bBL/m/SVcSVVf?=
 =?us-ascii?Q?9cWuKArL6MSYVQawzpqHYyzB3uUzEVeVTKfLlNRzUo8Sw+IVg3O0JUVSss3P?=
 =?us-ascii?Q?tGiBGXdbZ0MfxEArJaafkWdzpF8Ti5JEeriae84RkIqVirZrv/e/Z6Jw2/mN?=
 =?us-ascii?Q?ZM6IFIjNGveUL8yeohzrM6RlPECz+OdU6CEdJ8TYcTfFBY5+s3aZ7eTu8ZCj?=
 =?us-ascii?Q?usvfRabBSMXQ/6RPcKUmqKpYIyWhzZQHDjRHQ+V0Y5Jhy3jDyKouJgIu1tYK?=
 =?us-ascii?Q?wf3HmLTEgNUXAQjEsmoMhD+l8I2DzhMTlNAA/tO7SIMhBxs0T5ekkUIF9STI?=
 =?us-ascii?Q?UunUIvHhughdMdKvDQ8J4om8XDV5rV1pT0l5y6Z++SqI8vikGOTJX93zzM89?=
 =?us-ascii?Q?EIHa56gPbjb2V+yFBCXOSUYn2LDbSno2BpgjCCS/85f7DZRw1nyG3XtvMPEZ?=
 =?us-ascii?Q?EZ7wk2wAyzmbQnuRqFIyKJ75/j6U6c4z4O8gvpSs9yfgwBrJtLXUOyBVTcZD?=
 =?us-ascii?Q?WqngDOHy76TeA42BJgDDC5peQFO5Hf7P53d2Vu69cN61YBZEpXOlmqbc08fG?=
 =?us-ascii?Q?LVtbecXMS3oat2Rh85r3poj5DUlT62MGXLbYImlK8Tf5W15I+FeKkvTvQFJf?=
 =?us-ascii?Q?KNR1ZZPdjQvIhekfRM/x+NlevoAKSVhEAgDQX8XknUR/niiMfS7DdWDpGe5k?=
 =?us-ascii?Q?p6nwWvw7bUxmcmOq6yv9qLsgJgiZ1DWBoFZxVN6XDrobKC38JUwGVwMYCl2U?=
 =?us-ascii?Q?tKUuGLahmcD4po3o5Pd0SamDu1pT62rdeWvEeG/EohtxPwR9t3viRyVHrIDe?=
 =?us-ascii?Q?TmvsoWidjf9G9OGHERWTJHc65R5cp5FV8GWhzb8uq4zkt2suzKwGBkZi9ohS?=
 =?us-ascii?Q?Vuyo/7p5XUFgRIQ0Mse7jpSYm2ejTPjEmQEyPlsdrp7JmlDUfUs1tbz0QFpU?=
 =?us-ascii?Q?brkz+3igZfN0lqPucZNfUYqsUaMW4xhSWLPS1zgyDeYhIpPQib1jv+SQ8/6Q?=
 =?us-ascii?Q?jblfXkxNkfrvvua8WfapV6mtUgd3MjbOK01qBybC8K9X8A4fEMGSNKxgBdcI?=
 =?us-ascii?Q?m1pcY1H/NKtk6CDWlyf54KHB0wQLH7Flu/QFj9O39NcHN2yOpC0tshfvpDwp?=
 =?us-ascii?Q?3vIokKzQlS0rRiLGxAZEmB7bGVvU5owlZ/922o1tRlt44gIRF2MbBVGKMvG6?=
 =?us-ascii?Q?9g6yOAU9gHGXM1zoAPRrQtfiLiLAp0Wu6WCThs14lW8nelsP/HXSIV0HIK5A?=
 =?us-ascii?Q?IC7Fx84sSo0Semr7K0djaaHBE5QDNrjz9PvvOCBEIrjfuloADmluXlfF98Ix?=
 =?us-ascii?Q?r3tb9lUnNpMrwJ5Xiy19TDb6zrWgJUELAm/m+xFd1xu0K3oazBcl7MQ4p/Ku?=
 =?us-ascii?Q?3rRA4yJrzmxT3PEgc3dyk5t7XB7FfXDofShE+7qM5gWIGPSepOEg86zBi6Su?=
 =?us-ascii?Q?ad/C/97hCqJiGumv9u8w0b7o16/P//0EkXZEPRxag6YPhpvksy1HctSFLNP8?=
 =?us-ascii?Q?G1+rF70jsD9/AbBdJLoOyyBdPnkoM5Tz4kkz2lP8ueu6isz8xPPacghQNjJ8?=
 =?us-ascii?Q?mdRvbXYiqACfN+WXmV6p5FE+Vdt9BDIJl0LxiJ8EsjFE3Yrj9Yly?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec01f2d4-1927-4f62-fc10-08def4772b65
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:40.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLaPSXV9b/ZHq39NAaTWwQvqldOmrRPwtAZUf4E1kxOo1Af4BQrLEEE2EUMBxZtYxi3cPtAtO1D1EMIW+2QxRZjBEenHB8Rmp+gggXuHXBOCiI7gkZH0UVIdPKGfwKM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

Add bindings for the System-0 clocks and reset generator (SYS0CRG) on
JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../clock/starfive,jhb100-sys0crg.yaml        | 63 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 56 +++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 28 +++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
new file mode 100644
index 000000000000..cf1b0175b158
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-sys0crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 System-0 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-sys0crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (25 MHz)
+      - description: PLL0
+      - description: PLL1
+      - description: PLL2
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll0
+      - const: pll1
+      - const: pll2
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jhb100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jhb100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@13000000 {
+      compatible = "starfive,jhb100-sys0crg";
+      reg = <0x13000000 0x4000>;
+      clocks = <&osc>, <&pll0>, <&pll1>,
+               <&syspll 0>;
+      clock-names = "osc", "pll0", "pll1", "pll2";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
new file mode 100644
index 000000000000..24ef2663f05a
--- /dev/null
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__
+
+/* SYS0CRG clocks */
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN		17
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG		18
+
+#define JHB100_SYS0CLK_PCIE_REF_CML			20
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_DATA_INIT	21
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG_INIT		22
+#define JHB100_SYS0CLK_BMCPCIERP_NCNOC_TARG		23
+
+#define JHB100_SYS0CLK_BMCPCIERP_PCU			26
+#define JHB100_SYS0CLK_HOSTSS0_NCNOC_CFG		27
+#define JHB100_SYS0CLK_HOSTSS0_NCNOC_DATA		28
+#define JHB100_SYS0CLK_HOSTSS0_PHY_SCAN_400		29
+#define JHB100_SYS0CLK_GPIO_ESPI0_EXT			30
+
+#define JHB100_SYS0CLK_BMCUSB_NCNOC_INIT		34
+#define JHB100_SYS0CLK_BMCUSB_NCNOC_TARG		35
+#define JHB100_SYS0CLK_BMCUSB_SCANCLK			36
+#define JHB100_SYS0CLK_BMCUSB_480M_SCANCLK		37
+
+#define JHB100_SYS0CLK_VCE_NCNOC_INIT			50
+#define JHB100_SYS0CLK_VCE_NCNOC_TARG			51
+#define JHB100_SYS0CLK_BMCPER2_NCNOC_INIT		52
+#define JHB100_SYS0CLK_BMCPER2_NCNOC_TARG		53
+#define JHB100_SYS0CLK_BMCPER2_CFG_400			54
+#define JHB100_SYS0CLK_BMCPER2_CFG_125			55
+
+#define JHB100_SYS0CLK_HOSTSS1_NCNOC_DATA		58
+#define JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400		59
+#define JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400_ICG_BUF	60
+#define JHB100_SYS0CLK_NPU_NCNOC_INIT			61
+#define JHB100_SYS0CLK_VOUT_NCNOC_INIT			62
+#define JHB100_SYS0CLK_VOUT_AUX				63
+
+#define JHB100_SYS0CLK_BMCPER3_NCNOC_INIT		65
+#define JHB100_SYS0CLK_HOSTUSB_NCNOC_INIT		66
+#define JHB100_SYS0CLK_HOSTUSBCMN_CFG_480		67
+#define JHB100_SYS0CLK_BMCPER1_NCNOC_INIT		68
+#define JHB100_SYS0CLK_BMCPER1_CFG_800			69
+#define JHB100_SYS0CLK_BMCPER0_NCNOC_INIT		70
+#define JHB100_SYS0CLK_BMCPER0_CFG_400			71
+#define JHB100_SYS0CLK_BMCPER0_CFG_800			72
+#define JHB100_SYS0CLK_GPU0_NCNOC_INIT			73
+#define JHB100_SYS0CLK_GPU1_NCNOC_INIT			74
+
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
new file mode 100644
index 000000000000..5c7b00afda73
--- /dev/null
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
+#define __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__
+
+/* SYS0CRG resets */
+#define JHB100_SYS0RST_RESOURCE_ARB					0
+#define JHB100_SYS0RST_SYS0_IOMUX_PRESETN				1
+#define JHB100_SYS0RST_SYS0H_IOMUX_PRESETN				2
+#define JHB100_SYS0RST_RST_ADAPTOR_TIMEOUT_RSTN				3
+#define JHB100_SYS0RST_BMCPCIERP_RSTN_BUS				4
+#define JHB100_SYS0RST_BMCPCIERP_RSTN_CRG				5
+#define JHB100_SYS0RST_HOSTSS0_RSTN_BUS_ESPI				6
+#define JHB100_SYS0RST_HOSTSS0_RSTN_BUS_PCIE				7
+#define JHB100_SYS0RST_HOSTSS0_RSTN_CRG					8
+#define JHB100_SYS0RST_BMCPERIPH2_RSTN_CRG				9
+#define JHB100_SYS0RST_BMCPERIPH2_RSTN_BUS				10
+#define JHB100_SYS0RST_VCE_RSTN_CRG					11
+#define JHB100_SYS0RST_VCE_RSTN_BUS					12
+#define JHB100_SYS0RST_BMCUSB_RSTN_BUS					13
+#define JHB100_SYS0RST_BMCUSB_RSTN_CRG					14
+
+#endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1

