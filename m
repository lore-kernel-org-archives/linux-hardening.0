Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEE43E9CB;
	Sun, 20 Sep 2026 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789906712; cv=fail; b=HqPXJkrY3Pv48PfwFI4SkEq+1sfq8zlW9BiyLtWVlXcBrfuUeBGtRZjwYLm5yKOyPPgFb9omKnevOc8GEWRO/ykDF6MKcG9aKgIlNxvobE2kteRjYkoIIp+l2uviUtaNegYcbIPMeb6RzfZ4lhJ2rYGjQE5cO6PKKzglABEc+Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789906712; c=relaxed/simple;
	bh=rQ5Sq5Is/mzbEmQXis/a2oli2zE8PaEaO0VhyRr0QeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=diIegrQzZEp/p9XKhvVu9CW16sNXpFDjr0oSnMilEmv4JzdEoKtSINRArONPDncFNX9RasOAq9xy2Xx4PRy/P7suH779aMVB8padf4vtIa2fISbBq17ArBNCumRr1AlaXeOb+cUtlBcOv2HYvbytj0rv//fJGXgqRu37dcICKzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/HugHAuU0+Yoo3evk2+4OyqTv/5xkVfTHvoGcHpKbQgWXOxlGdfpW9lRHGfK1iKXzf+FT67bbmh17tYQqWNkDnj/AdF3jRkcPahVlUnk49F4P91P29nNXYJF84ov3tT2hpzOZ8xeNi4ne8BdQPjg5f5s5a79/41tOszjUp9HkiuYld/S2U0n8P9+a+J7cFpMMrOT9J4BQ5bPtDnzkUSZq8/JCsZg4gkVlXo3oCgirGRMA9Laaovrzr286ufsLageNxR9o/u7kTrXXr4562jJnzuqoRkM2SPp1KsSKbG8RRryKCvD12zn9wdlBxlqKc4H7IWATlDy2Hx+FvC4HiusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9T0J9WhskpZHjY/7iPIX7WGPYv4AGoFCgPNp3THz2U=;
 b=eNouSN/NIhXmGRKQDFUM+DiILzf90jJJXPtoxC/xDihl/RuRkxEUTNEeVIA+KrspdJdV7/mnXY2CBuif6e8v1rFXC9ib82HLrTx+Si6UhIZnrm36+LJDlKbccf4Rg2Sqq0UNVhUF9yO+b0ZvXHqIRJVrCZbijAMZ8iHEzUxD3lKgESWugk9SqRz3VxCmfcC2lGdZDxst4rPIFFvoisyUcqFXnHiZAE4UMjbfBogdp00bxzaBv47Th7sJoHcUY2T/TNbyvSviSRhojhsvVgfoE1ViCjIYECryEY73Cm3fmmYIs+7mnwa0ez/cmFzUEd3IVPhdxg0G5UWIWgmHUyVhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:00:59 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:00:58 +0000
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
Subject: [PATCH v4 07/22] dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset generator
Date: Sun, 20 Sep 2026 05:00:29 -0700
Message-Id: <20260920120044.194901-8-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: be17f079-01d5-4276-c784-08df170ed56c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	wc5lJF2Y6atA7c9UFGR6wi4uHVIplrqMZR8E5r6VkFlQlsJWfHGD3PhwD2nIxIRa7Rs6T7aFjF+gCPcKUFaC4js4w0fXYGVMOpPEfApz8FZrFeBI6QaU++Dm8gxJgqOMZNLHFJtXljW2qBF0o4+1MqFBbuiHkcCXzVio0NmE5YJsiAxowXG/uY/eUUgRbtKmuo+YUOg6kRD3+AZsjKDRQJrjeGyDcdRMbdeQKnFgAcD6BbMwuY7l0P6h7PrMGJe1fV7d88uzNgNe6W6t2lzKf5bbWjU0hDHg2lBJEJ1Oh419/Vxo+OeB4Cjg/kjRj4agInUhxQxcrtHQ9012SfbAI2YrlnXcSErY0kcBN//koJQVn7IgMext9ax2qSBeiRxVEbrEkHBlXxZvILN4Fz9fj09wYfPzcY7R/eLLztdiiogRju8JsA4sJwxEhmNQKUQIFgihWQgjpgE+6J7HK/CsF/Vje1h5VH0tRsYazrdLA3uK1ksXKWvrVZFtDH6TDOzPbFT1a1sFJZBcnaynXWXsBaYrBI76lQ2KGC5WTG0OsP8Rrr9QFGB7XGqtpyOI4kItVYq9FCMlzXuOP/ND/ipWBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9o/aT4AKObzYmYvaaLlZKEli3gji2isqQ8cMjLcNz2IbBEeXnbQExzUO0MHc?=
 =?us-ascii?Q?o5yP+5eLDCfGSHb3TsY5sdp6uNhvNsLHdME34easi0iWi+HCXr791J0Ts5kF?=
 =?us-ascii?Q?k9tWPNZWsSdDItb7LqEKA2tKu6JqRmPwNmzEe6SGlvGE9wTB21JXZ3fBmjl4?=
 =?us-ascii?Q?d512iIK1GjDf1x0SEhEArgbymqGSrY5MgdayAelNoHIy6+USGgPl9Qtjm9yd?=
 =?us-ascii?Q?ZvMak7LPe52nCGP+RZYrqw/IrhYjFfzwVfcx9Su//487WafoxJcoov66+MEL?=
 =?us-ascii?Q?hnR0o8tjhxj7QIMaQ4Xd5RiC8eQ+bc5C6xLoQ4EkZL+YNCYQMjXyEUtQo03j?=
 =?us-ascii?Q?Hn+DG/7M5nyoGXWOeOJ+t/+CBzBgzNYxmhG/7mxZPrns2Mn27MF7IBcKh4Kc?=
 =?us-ascii?Q?mubp71THCasYsmoJsmk4nlM8gzRbDqkT408vImUDNNrbANR07VGFfnawqSDZ?=
 =?us-ascii?Q?PBwM3iJXPC/qWIsJ9TGGt94C/Kd4iNkf+kxZUWyelt9JFtBq6zcdgD5qoddV?=
 =?us-ascii?Q?JId+XqfyP1ag8nU1qtdkw//McOSdgKDoF+OhZbdQ0/aJEfvEMP0M4D2l0Rm9?=
 =?us-ascii?Q?xTuZ76wERVBDvWt7tE2Ipc0Gzt+tjmrmgjrgvlc4xhPg7WTI9M+uhbGjULBR?=
 =?us-ascii?Q?FzENlXNBYodSewtGjdqlMGEE5A36EoxlRn4PuB7A0338sJbYCfcpOnus+IPA?=
 =?us-ascii?Q?mE6YW/RbsoiTB9p4SjXLuNjIojZvC8sUEObrhJynUK1Pq90pdctrLjKHTjsl?=
 =?us-ascii?Q?y00kdiu0mra4/vZ/sQK07oVfx9xOkBF8LUUU/kHeL0FhLBlwin/hTWUPup+c?=
 =?us-ascii?Q?9vajFVGEZaNtiYBGfRtnBNV3k7Tf7vQ44m5CMDj8ngDxGNohspKJkP/xp3Ep?=
 =?us-ascii?Q?LdALNbIa5LFLIgdxF6tomXv8pfrsRYJR3O6p8GyhOxSrayanmzA2414kXMa4?=
 =?us-ascii?Q?TQJ7+BO6Knv6AZQLMpVcUI6kBaeumBmpTy8QLqknmUbEEbaNk8gefuOaJio2?=
 =?us-ascii?Q?gxUaB/WZwMA6IPcNUvApJ/njifMkYjhlJs1YnQB6XWM0LipDL3lWDgwNhUwl?=
 =?us-ascii?Q?bx2Hk44o7K3RUBzO5S8qsn6vG9YDgf7AcU/VIh/1qyfIVCE37sdjzqQhiXIJ?=
 =?us-ascii?Q?V449NZjbXQNfu75ahCxMm4OnpHnlRw9J6mmO/HWdazb1GnmviFh50zZ5QELX?=
 =?us-ascii?Q?3/lmdglY6EjWMM389I8hmkBIZvYe2kzri9snv5MJ9VfhZKx2rKR5YJ/FWKxa?=
 =?us-ascii?Q?qkoH2whCaleqqPnhD3bk/+5wMqYDl5PD0Bh/rhIHCVDQpZGNMO+jZy5zhNMl?=
 =?us-ascii?Q?TL7JRZON+TVzDx6SWCIxwgfjfxFSDj39Khnfrm4vTEO8vNoLIoONgQeo/+/j?=
 =?us-ascii?Q?MZypzdMdKlwhuXK6P28JEv0Nu1ios7Zj1TuEnSCfc1Rrnu34GweXjlKv/omF?=
 =?us-ascii?Q?fqGn1Aj7lPrLckFVewHLfgKnm26LnOklLwN8XkKWdWdZRs/LNfeOrJN1C4un?=
 =?us-ascii?Q?cMACxi2eZfuuaL3R/CuE+5YXsatxoNfPZBs3RiUPX5eho9LcHjBPqNe/ge8U?=
 =?us-ascii?Q?GGE7vIhANJv0wtWD3a5CPbydr72f+bHLzwqFRH4uj8KHRDipj/eIktv6+NDv?=
 =?us-ascii?Q?zEIfvFsU/idoMf2RJvcqayOaBzwudfNFcVJtAWJvu7V2pwPortKKugHQPHaF?=
 =?us-ascii?Q?/XGezckGanOYbbBqUUba45KrFZhu8fvrNs2mVoMl01XC3zBPTYwtEw9m6c3S?=
 =?us-ascii?Q?3TSs52crSQMXWImtV6fBXRYw6f+DuotKVnNhu0634NywAXZog7hd?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be17f079-01d5-4276-c784-08df170ed56c
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:00:58.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVTmf9GS5QIdDAhjQlCyGih7mm4oqK2pkDeevZkpDhi8my5O5stRZYGqeaTjX6GIJGnoGPRpNnG9dhONb8NGJd2P9QucqjfabkJa4WOh8707WB1khRFgENksTLvrVnLF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

Add bindings for the System-1 clocks and reset generator (SYS1CRG) on
JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../clock/starfive,jhb100-sys1crg.yaml        | 71 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 20 ++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 11 +++
 3 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
new file mode 100644
index 000000000000..70cbfa38c100
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-sys1crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 System-1 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-sys1crg
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
+      - description: PLL4
+      - description: PLL5
+      - description: NPU Non Coherent NOC Initiator
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll0
+      - const: pll1
+      - const: pll2
+      - const: pll4
+      - const: pll5
+      - const: npu_ncnoc_init
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
+    clock-controller@13004000 {
+      compatible = "starfive,jhb100-sys1crg";
+      reg = <0x13004000 0x4000>;
+      clocks = <&osc>, <&pll0>, <&pll1>,
+               <&syspll 0>, <&syspll 2>,
+               <&syspll 3>, <&sys0crg 61>;
+      clock-names = "osc", "pll0", "pll1", "pll2",
+                    "pll4", "pll5", "npu_ncnoc_init";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 24ef2663f05a..d7904b32bd51 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -53,4 +53,24 @@
 #define JHB100_SYS0CLK_GPU0_NCNOC_INIT			73
 #define JHB100_SYS0CLK_GPU1_NCNOC_INIT			74
 
+/* SYS1CRG clocks */
+#define JHB100_SYS1CLK_APB_MAIN_SYS1			0
+#define JHB100_SYS1CLK_APB_SENSOR_ICG_BUF		1
+
+#define JHB100_SYS1CLK_GPIO_ESPI1_EXT			5
+
+#define JHB100_SYS1CLK_HOSTSS1_NCNOC_CFG		7
+#define JHB100_SYS1CLK_HOSTSS1_PHY_SCAN_1000_ICG_BUF	8
+#define JHB100_SYS1CLK_NPU_NCNOC_CFG			9
+#define JHB100_SYS1CLK_NPU_CORE_DIV			10
+#define JHB100_SYS1CLK_DOM_NPU_CORE_CLK			11
+#define JHB100_SYS1CLK_DOM_NPU_BUS_CLK			12
+#define JHB100_SYS1CLK_DOM_NPU_INIT_CLK			13
+#define JHB100_SYS1CLK_DOM_NPU_OSC_CLK			14
+#define JHB100_SYS1CLK_VOUT_NCNOC_TARG			15
+#define JHB100_SYS1CLK_VOUT_PIX0			16
+#define JHB100_SYS1CLK_VOUT_PIX1			17
+#define JHB100_SYS1CLK_BMCPER3_NCNOC_TARG		18
+#define JHB100_SYS1CLK_BMCPER3_CFG_125			19
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index 5c7b00afda73..da1b51621172 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -25,4 +25,15 @@
 #define JHB100_SYS0RST_BMCUSB_RSTN_BUS					13
 #define JHB100_SYS0RST_BMCUSB_RSTN_CRG					14
 
+/* SYS1CRG resets */
+#define JHB100_SYS1RST_SYS1_IOMUX_PRESETN				0
+#define JHB100_SYS1RST_MAIN_RSTN_CHIPTOP_SENSOR				1
+#define JHB100_SYS1RST_VOUT_RSTN_HOST0					2
+#define JHB100_SYS1RST_VOUT_RSTN_HOST1					3
+#define JHB100_SYS1RST_HOSTSS1_RSTN_BUS_ESPI				4
+#define JHB100_SYS1RST_HOSTSS1_RSTN_BUS_PCIE				5
+#define JHB100_SYS1RST_HOSTSS1_RSTN_CRG					6
+#define JHB100_SYS1RST_BMCPERIPH3_RSTN_CRG				7
+#define JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS				8
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1

