Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FE27F4F5;
	Wed, 30 Sep 2026 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772247; cv=fail; b=odvlUccL5giXfqwj3K/Ve8RIa0d5nsR8Wg1Bu6h5kWXwGfc5WkCzCqTRMBEGdNLqS5OdZZQsm28e1VE2GacwDAmPOdUe2TPLu4HOvDLXSt768SoxyoZg7na5STy2xWfARYy/HnNXzk2nAtRXfkq1A0uB9uP2OKnvJ9159NEoMf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772247; c=relaxed/simple;
	bh=plSE5abZ/49zbOYcoprNoj+7ogW3xrjqvK7AgzSILXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFmq1J9MYTuzQgYOsymJbaWvjwkoDuzFs1o/NYcrNW51ozSZFHzV3qolBIU0o1uIgt0yUZP2kG70V4HcTWJOzihFnlI5SwyWCLfDC2UgYnlZDO/jVSNlkwpw/Ej3aPBe89/y13ZIQL6huQaS+kw5ykEENx3uzWVBI/kjrCYGWbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K12jBsT6jzvh7vbNZp6dwUgK0CEIeChjxYIJb7JaW9fNgNSWM0w7cpmb0SRPW9T4PBG5YzL452/psuURCwqbeSnsYFvgRhlrKVRdjW4WWUCT/WLEbV7eRxaDZd04mttFiQ2L3EwJYeMNfJiauYtbhOS3qY/a2LQbH7DTD6mliaI6Gb1KtVpI/rGBHxJkD+UWFKOdEWcHAXc3BKNy+QYsc4byeluLitCtuq2D80bYFk0egtyvajOAlzMNN9SVH3S2QZoM2Xrb5N8uNS0/YlCCEzbBGpowZEe30GpZp8LlRQ93837FxPxbP4E54l12ibPTN3i1YyutYwKFisfhg+Aq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43tX8xlN4ln6jA6AqCWImBv00xjVAiSXHe0yjCmIQxk=;
 b=Tb5fi/uLBDiZ6WmPXlgnMDdok+wnNYnmbsSBEbJXxJdzbQvhYUpOO1cjUVXvs4RzXpoXUNRG+TdpU5uvFrKGe7ykeQMCNAZ0AcSSmgN0TUMo8gLw+EcLqqn9+XJYcfAGMPCdeTGIMpxQ+YNrwLfyFQPWWHKn/D7+X8/5x+jDl3RyDqAYqFj5gykXHAvFQ35X0bTa1+aCDlTXoszgrvBnrohrRXJz8teryNWaLehrs0xOIGyWIidVFW4wbJYAB1yWM7C7DAYgZSdiL14VC9Iong+fPUyweGyakBvkgXWpFVO3awO8DGrbBe0jFLjhohSQbqEXlyaTnFZEZ2mnyokIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1297.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:41 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:41 +0000
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
Subject: [PATCH v5 05/23] dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset generator
Date: Wed, 30 Sep 2026 05:42:59 -0700
Message-Id: <20260930124317.5648-6-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 918afe2c-9e20-4fc4-323a-08df1ef07536
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|52116014|10067099003|56012099006|3023799007|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	uP3UUAc2FstQP7pT60Mqkj78BfY6tD5YCELMkxPK1DI30D+QzB6YRGCOkCfA2pmzhvIRN8hlrjWJwSDloRcLBWd1abk8l+XYyC3mVvgmsX6vUupDaoXu2k1l5DMdKrvCAKdrABRWXdUnh9SNu2RBfrU9yTWNbez4o9ezqY7227fg6D+0qePjwP+UgintEXPLCQ/q1ar4SyMGkJB6gEXo0cuDnwOZB9IkvrrqL+/7a2Q65khituvILjOaV0qOxMj1HX1vZhlNv333cx1+9Z7aQyrxDO4hKwhu6rziKVCvCfK8klgV83ydBXhg8dbBVfQhrLH2YXZbFPhM/SJPZ2mMGh1yV3a88cth+lgFHvd4BjROSb8RuRw7TBa2ArDj02x3ZX4XdnHVQuM6y9uRkC4FKFEV8Jf2wpADgXmwUyPEahAAowDlzybPYjVJF/jLhLxup1aENZ7CzMkAJdgyH1DtuWQ+hwkJI2lk2zvoSuJQfTbO1oj12d13QrpPz5jbjGVsIzM2nqi7A+7xDGERc4UXnIIy+oPsoPotcEqu20SymYDGS27mK87Fq9O2HGHRKfAYiJmUBBJaf733+ZYGJAQbqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pBXnlPg/KlNIHck5JH4Nk3n6fRl8IPo46r6sCm80jFPhB58YwqbsCKDPmrOs?=
 =?us-ascii?Q?dE+NnYUJnQtgauAwcP8/5wrQRfQ3iJ7/F82vrdR7XLj1AQcFsR3JgAsHqcO0?=
 =?us-ascii?Q?KYV+7LYR5nz4QlT8SHD/zM2sffav38JYeP+LhL+GQUdy9FgE+4Ij5PkmyD9X?=
 =?us-ascii?Q?IIRtsEyvdDv4JZceOLtGMER9BagSS2RIa/BBFdv3UPclgrc/jmmtWG4c6cRu?=
 =?us-ascii?Q?UjmOOTNvO3uQWETwBVwfJYxqvCDfQ/mJWYTrlb9DOKI6ZV4zZgXIEGh156rj?=
 =?us-ascii?Q?vlynrs6FKcUHoBNRMUEWN2PyYBzLyKK+GbdFVGUAyxSQ3qSUM0sdkieHnSC0?=
 =?us-ascii?Q?s6d5rKpNowJvUvwmuDLqgfDF1APtcmTWKnoDnQ4kVBrOi5IrznekjhtuM2m8?=
 =?us-ascii?Q?c/4OIbFjLfwUVsruGKVOxlxGREAgyGq5XQ8TMJufViiFey5A06L0BLRjvnCB?=
 =?us-ascii?Q?2tSM9YklF96yY4/JUdjz1XZoDbjkVJh2WbQ4/hDoiOhdPzBv/aK9xjuHXt0B?=
 =?us-ascii?Q?lFN+DAHqAfTVtqMsrQl124qNGKblONKyhyHRBbnrc5x51bjwNOGlnNdN/xio?=
 =?us-ascii?Q?8T6DaXq2UDR+RBDXsTIODjG9dRnX0Z+TW26E7osP55+1N8urxBzbYhakrBQJ?=
 =?us-ascii?Q?NcuLemHHKHLC4uaJeDkxEZnx+mKC5ZBKKU2oCSTsPx/qvQKMXWEeY85g+0HB?=
 =?us-ascii?Q?62Miap6GoO9puf/sGTbn/SxTvyDwgvcz/trpiSyAXUr90b7spkt1qE8b9qB4?=
 =?us-ascii?Q?POuTz445aGhCefUXgcXB+fs0tBQkWoL6myuDQWXiqAJg4RlGhLD10BLQwbBZ?=
 =?us-ascii?Q?aS4S1BwAKsL1CNhmcPkXioVHs/0dIos1kFLCbWk4HdsTVjfYlEo7g45SSzjY?=
 =?us-ascii?Q?OzUWLWwEid5zu2TS42TsALsrIeD2OAxQ+YwNBHKAMrQ587aYawTjQnMRi46A?=
 =?us-ascii?Q?qd7c4xBXbX3bptGelXDkYpuoeWH6IvscfWtWUkARIyuBje7e8zCysYjGy2VU?=
 =?us-ascii?Q?Bw97FzxiQq8ouqIgcKCeQuG9K7RJpUg6L0lznDT0jB3z1GGowsscygGp3SFI?=
 =?us-ascii?Q?/33ZGc7vkb/mA9Vk31lbXaqooxZ6mIJ+FLpOZdCofbPMTp4RkLgfmU2CXMH9?=
 =?us-ascii?Q?9bOx5MQjcrNjLmhChLDgqCuUgVoeKl/goiuiSR4e4DF2C6zZ872iFm/igGfC?=
 =?us-ascii?Q?iH/UgKqV216SsTUNa0+g4TTCCJt1lVway9Ehu4xSyopJ2Tl/XVsw2azTz0MM?=
 =?us-ascii?Q?PTL1ztC+RibmyGmQn0aRUmTdwnSnqCtjmfzz6qnxnkFN8MGxzmY5YfT3J02j?=
 =?us-ascii?Q?MJrlXSCk4jnryZrkBa52DTEt/QxaDZ0zLAodfeMRk/W4E7jMc/pjj1k3JtSF?=
 =?us-ascii?Q?aISloDWjQO918mKcaudBM911ImecNrvhkCFRgeFqOIb/5OehyLfG/bUym+EC?=
 =?us-ascii?Q?X26xDfA+Nbqth+/A64e5MjDZGrwQx/5aS552mZOKGRKapFx/Pj8rhp2wWIYl?=
 =?us-ascii?Q?UVUhMX5JWiQE6NMPK78muYk74HqWxNS7TAWc0jI8zDUaLYlqRu4qbuneiYNT?=
 =?us-ascii?Q?JBf8v6cDXXOrz2BcmgXuXVuhRKjUwjprw8t4BylaO9dIghA7Cul2mIgnI/M6?=
 =?us-ascii?Q?y0PAjCrP0py1Bwd8cYtcV9dsik7iK4KA/bxNoyY7JAKF9E3998b0DPmLy/Dg?=
 =?us-ascii?Q?c3M6n1zL1g4/d6hkn1BYHTyoLKmErLc9JL+qUHuLkdOLpsM4Vhffkl5UB16N?=
 =?us-ascii?Q?N6PFFmoKt/FxvP6kss3TnNco5koSvoIC05XNBw99mxa1OkXaHePT?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918afe2c-9e20-4fc4-323a-08df1ef07536
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:41.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sv2abKfLhhRSYnyMYfOG8UkA9Bznc8vFGhcSjgyELqfBvXJjkvCD9Zf07yfMPyQGh65Aj7Ai3hVGMvEAo1G/J7tkPBQzJDsO1V+Xv/D63k97eZWWnGy5ETMlv+dNhw6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1297

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

