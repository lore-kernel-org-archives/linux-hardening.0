Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6CB440641;
	Sun, 20 Sep 2026 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789906686; cv=fail; b=Mx57t8d6gj+xCF37gZ6dLipdoB8cKCRii6lqsHBhN5VPxGeyqXwk/ALzZAsPtdFY+WM7z+31p0e+OUM6IAkyBbzNZUnJbqwBWkJmEqyOjDlKeWhyTam/nvmtIOdu9x3DcqXjPxNOFni8E8ojKyF8EIvf3d6gKznEZDhZKcNvqhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789906686; c=relaxed/simple;
	bh=plSE5abZ/49zbOYcoprNoj+7ogW3xrjqvK7AgzSILXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mPGAluTktZtEeUeD3Z1qNOGDdhjSHEoIDmYpEgNru2/vy6qJBq2+5d17A1R0bgxiO0iOBUNUlyD5leDuhHKpkvndpLHrq8Z8DriZu/bBul7q6MOYG0RRdTMddxYbOJDtBxY35D9g9e5SDp7QYzYCEhMkOiZ17t1PUCiuL96rWM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUCLM+Z8iffOzIBz5IN9pXROpXO5d18KB99TqGnO/QZZK7RRjlb4yOtEPG0fvVa1MwMeowdvGjtsAjR0JY+2jj52L2cVyvI96dw2KTPlaEV/eSipg5F/hq+GynASIrsufZg/AE+zbnCQWigxf2JiLNp7R5N91E2pXH3row9rlSqMFz58L3C112yBJ+dpbuVuqWbCYiesSlqfq44JEfH5IIdg7ducXiMhx1V5H5f+AkCypTRWhpxxfFnN4FumXCXE45C4/RlhD3QGIRnfY3r6e0nXhnhdZBq4mij9bjvB0tlqjAFxITE2DI0b0cbbyrin945sPBEz+NfWl8GsGGB2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43tX8xlN4ln6jA6AqCWImBv00xjVAiSXHe0yjCmIQxk=;
 b=HMhq5JW8D1y96BzK0fsmbSb1R86xx2mVVmrjetPcraElrNlhcblfubX8l/AxsYK0EEROdJRgbUy/ekwYUOYi/HG5d1t1pKnf5YLIAzOr8o1JF9f8xWmX9fAFa/hhAkED1xvPwfbEIGsLEVPkxmtubJ54Rvnbh6D3TBTZwOXDfvrPDdi3EjcpLlG6mwyNe4Li3Uack8QD7XIBV8dZjLwNoT/aKyForSsHjX5vkflt9PrqtI6uDguEEPjVUX3WS4gXdl/q9TQRq2VVMDlgXNvJ7nqb3sSuFO/915qlWxYDobPsA6owOtS1AENLoXGANWSSu/R/golN2nPstU5cBYQCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:00:56 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:00:56 +0000
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
Subject: [PATCH v4 05/22] dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset generator
Date: Sun, 20 Sep 2026 05:00:27 -0700
Message-Id: <20260920120044.194901-6-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f22f3f4-0762-4f01-a39d-08df170ed439
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	oOr0QtLH7K0utQAfVF3NWmbxKd7wXk0axYulLx9U/E+DSzsDFEop/62n+nJBYJhvJiPGfhJ4YIlqjPXvYY9kwNUtra6vhRfqQjhb52g5TYgNlnyGpCUITHm9LakqH++2znaQS4EfNCPCEMKvTOewNYrOLz2JtiHdG1TASL3CT8IvjI8WktOqeI6RGwl3VzpWJCxz/YAwJurNnvBkdV5vAq1Xxl7LvRZXBuAGlr8zbgK6dRq/0epBvI6rb7A8H4THJ8ujlLMhF/VC4p0oBpLeeUepcTFFynGGUf5v3FlzH+sqqDGhNRYG9CqzSAUtHv6iSBP5UtpRz6hvheUD+etuagwexCzHJj90DRe3RehoW7cejG7B+qfwO12FDx/PhEIwsq+7ysdShQHcaDBcODJkDWn11Dy8EYhndLiBzdLKXVKEKJLWLcm3QHc5zG8IAOD5RL38gYCFxgTmph43QSiiUHXX79a9wEPNPirlYV36Q0R0nTbPOA6KG6yIfcT1DBS2GB7rVPPozOEDCOSFgpbWo4Mv5Kor61Vu88IDi4GnQUcKvF6/c7fUoFYi9X0EyVNmWfk/J4rDuqqjRL2kItIQyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kDhhTNSQlsbdQi+wOwD0bofu87/ftOy48t6nKu0f7V1FX5iReC/QwF8czSf8?=
 =?us-ascii?Q?OXn5f2T7xDH36B3el81sf6n0khwtaRcuI0BO5rYMyfIj5PnLJho+Olmp4w3Q?=
 =?us-ascii?Q?f8KCf7w5cCAMygGQF9tO5OzQxlEtzfRkbRRm+ERu5uHfXWA5di9xPNiAYzQX?=
 =?us-ascii?Q?qH+eU2E/wi/yU5i8gUqiYKV0sh9wYDlvVG+H4D03zX4dCnVFIbx9E63QGLCM?=
 =?us-ascii?Q?f/sOPFmCQUxRO9Tr+Cf50b5GGD5O0GwxCIehwrIvEVri/R3NI12EuqTkBL5O?=
 =?us-ascii?Q?LbqS6arZVlsn4RMWcgJMIip3UvwNrWBT5W6T9bvkTeRhiN2StCeVmlV7JdbK?=
 =?us-ascii?Q?cikvF76z9DIvMT1k+kcAn+cjgU+WKqEEV2JFbx9obEuvuLh/xnY+nkcSh8Hx?=
 =?us-ascii?Q?Um+N41qTNIafFb+wOnCc23BTKGWT+RnOWjL7//Cg0XVMm5/Ib1EOuWatE98l?=
 =?us-ascii?Q?1qHZX4NRqb3dx7Jn85gx4lCkBscWrwL6zXPGm0EGTnBlXY12xE1ajUqU9ejl?=
 =?us-ascii?Q?ChrqrcKo7lOCGUpKW0tv7YAJTSfIjHg4lp71prqL6RLiM7dRehr++HLWytwb?=
 =?us-ascii?Q?rEnlfpnC6QskQhve2w+V/l8TaspKQJmMX3wdWlPQjgX0ci02r2kvmQnInD/9?=
 =?us-ascii?Q?45b3lw9EW+LJm6eU8/HPf38b76jTy6pd7g8M4Qo74O48rG6/poW+Pw0NI8ZX?=
 =?us-ascii?Q?6ehr08xpIk8NNfuebUcmxUVur+6NSpbWZqCR/Hmag8sWsTONpLD+gc0wG9uS?=
 =?us-ascii?Q?8w45V+EodICfj9eO8IWdRlQufiZF1OE+K6ig9aVDu1U+Tu0KAGnXtMbBue+P?=
 =?us-ascii?Q?BJFaZTT/nxm6b504jExPk/AatsOOGchXuKOmDQ7QR43v8zuWgbh+WXq8zA8C?=
 =?us-ascii?Q?9Y/SN7pknr1AVlbGoMw441JP1o/aSn5el3XvPfrBko1/Bh8/GUF3zr1FgMMm?=
 =?us-ascii?Q?pyHRkwIq30Xp0JeW18JjvrDeYdiyXmo+fYCnhjseAjSi2w6utvHYxhr65Zuw?=
 =?us-ascii?Q?PcuhaILkGFY8KWKXELCUW+YviuJRJwKgojbmFaiIM5cpvzMsCWHGzBzkF2q1?=
 =?us-ascii?Q?GSbChJkymEPgj07pEZBQrG0PGjxDbQ6zyJV9TMvxuxTDzzfpqTsir3Ij8BF7?=
 =?us-ascii?Q?oHp4N4GjD30grg3WTvmZcsK0wO8Oa74dipYoHktSBnEwTBixrvRqXHOIVI9U?=
 =?us-ascii?Q?yCcKKT9GatP0aNBDVRCOY3ubH/71LvkMu0yj15k9m8yamTSNwBSlPr1BTHpA?=
 =?us-ascii?Q?H/53KdIH3Nv00KCakgIBVORQQeI0o+c6VRo9jSZeG+8OZuy1jMP9a01YlUh0?=
 =?us-ascii?Q?0Za3PylJLLz/TQmWfbgDJsfKlVbQdCC89Hb5zFTzryI09Aig3PEttamY/NBx?=
 =?us-ascii?Q?3DBW+qkbXdZm3Kq7t1QXmC+hrkVm1zHjUKyhY0BLdDZ05hMbK463zKRG3lqM?=
 =?us-ascii?Q?iIsTJi9WT9w9ue7Ah+amPWrtwpCMrZXZay8gXWFYaqDRJoQdUkeQznoGwo1P?=
 =?us-ascii?Q?a+r8S3+PKQf2Cmv04ZbGqDJpxtr+2Btnyfww7huHDkgXPbBpSBJ2e7/VJaGX?=
 =?us-ascii?Q?yCO6PJrGmq0OflH5ciPP351DQ4Vq7Zh4GlQNjrM3VLw9sPST6SY8MB5qXH/M?=
 =?us-ascii?Q?cXAyDUyog9ag6Nr6emtBJ1sl5Q6ebW2etCXCwuWv2wjB2iBhXEAhQNK5aMxe?=
 =?us-ascii?Q?L1h0Cxim/T6fJHor7+ojFLKRwX4pzEbiuGh+UCeq3N7WU6oatQBREsKJDVLb?=
 =?us-ascii?Q?YWGA+OjAC3kv75nKA7uqQ8tqrNZGqvauF35hC1pB+tEpQUL8aq1d?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f22f3f4-0762-4f01-a39d-08df170ed439
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:00:56.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93ZD2HTWNX/QYh3iwpJVQIthTMe1Bv/6kT3d8/Xrku02w/EOqgjsfjOm85eWFDkrubwhhn5ZVSqcm5BWHsyLf/LEEjLcGUb9uE0WbxGKfg9xdofgfP0ARndAgWDHZkVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

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

