Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFE939B4BF;
	Sun, 20 Sep 2026 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905802; cv=fail; b=oISiZc8Nw0yMTEFnyx5hdkPFeJama0cQdGfSGvBrMr+TerIsTjR2AqkZ4ZBtA2GJT1ejQE1ryIeLtMM7Dv5TmEpqqm0L9zWSgzZbENOq6H7LKM2ucuCqlSvrDrbUTYXYr2Xfi2R4iO+GMbuRlUiXtsb67MUWkeO2wenI6BhDlDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905802; c=relaxed/simple;
	bh=RkZv9gxLKvhijrUjutuw/7sxrPWQJne7DE21NePKZbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ud2vMFfEH1JdABKpUW/fmOZRt7BA13ApPhpnHOV/DiqsSSoJKjpsK7nM8tS0cdSt33R4XKc0VvYYXuyJONk37JrF+76bIjyfToUYt7T0TZEWnlgNekCSJxhI7u+Ko8kMoXq8toZta1DfcpVEqxlUHYI606jWBXilnY2RNkALzJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIdBTBkVDqWYs+CVQaKsoL7g5Xs2+w58JYE4mgf/f09wUfr0iJld0XmEhtWNLhAqEPjuOId47sJHbemSuNDj1WtCn4VQfWxbdYPzdKmHQMapTqk4U65Ce4U0DS1VHEr5unkI2GwA6yHcFQm/UbK2+5/+bc/uvMqmIQEe2BDXZsM7/nC6u+VqvQPwzshTk+rutB9CV6HPUTyUrG1xgtdNvpons+wd6/apsbt9nlIA3/kUTdZqxO9kIl7vsctwI1PXOKy4pWOYguOtZv7XGjaSeZ3tcemjythM2mlM8veRmEcj8i/e+CyJGv9qFxFXDZaB58Kyjr2yDfGRFHvkXN13cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MPFYihWFS/sItDsyLBsAXZ0TNHpIA0HhEGZpIuQ/QI=;
 b=c5uNjSQC2Y6mQFsYipk6c9ZgioY+WzEWt+Wyh2GKw5QgkRsfAcnG8plYLy6LZDtHiVNTAzuvZfmJkjMs8qfm+Oq6GOxYP0Vh6wQTIAsP+4eTDzszXA18gsYs3t2ap8jBQwA4yEQtTM3ZKyn7ytRryLZUvdm2FJsjp6q7VgANz+shOrsZZeAKGUY29iDMTr9aBSiroV3aZZZ/Sk3eFH3hwI/mAtv9Pr2hPmo5PycmctHirkqnb2OSvITMYj1izwsKBFQaA9uL31RgEvsfmOWXsfEIpc1cmb+vRlIy/ZOrizRKoPRMTdMsQpvStUVSUKbgoG6fNCoIXZbbewObq8Oopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:01:02 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:02 +0000
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
Subject: [PATCH v4 11/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset generator
Date: Sun, 20 Sep 2026 05:00:33 -0700
Message-Id: <20260920120044.194901-12-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e944c36-759f-4d76-739a-08df170ed7bb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ci9fDjbj3HzdKaKBXF4XxDMXgn+iFH578P4jyJAsg8NQ8vFMXDvZxNv/45m20sFQlW5miHqS2CQyzKqL5yrFs5d7LkWPwBbNjfPjOqgcjvkb0ZPQl7Q9SwrFz0EsMHraEXekutx/IaKk/HAcs9X1OKbz9GUTTjZfxwAo84zQPOGetLZnfvJ0O/gtkcCelTH2RqKtagH5Tr40mGjaQebSheQOGvjWlJykjl3sJC38TqAdEUaE/kdPO2KidN0VSgnvSagZGJkou9ibwtniy/T6cmZCo+FtOhnuPSq+ehoBUN9zGN0dONNtJZnRvNbxik0wIDJuDoxnN7apG6D+6NfCKpnZdPsz0kd/rlm6y1XohyDn+duK3B5hXB+KPYDKbPAqKaIMKftnLRJp9Ssl4C/FgE2JO6p/x6FTMH1HPTZxJHWEDhJQAHT7Lg8uZ5DnBN+ZZeEqIsNRpDVdBxxV0ZTmqJyBXbHh+zk03zrnlw5tdsOUfYW+C1e9VBHEnqGaABQC/TFaIIWXYDf4FS626X5vDriMlNk5TgPX6nWwl8rQeq1IQy+PEJkF498oK1TXNwcgwsjnBz6mjSuO7hdS5sB4RQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQjR6ip9bnndj5T3I8AfwDHpTXDzpE54fn7jZn3aKYe6kOV4CWz6TjOpZf4r?=
 =?us-ascii?Q?5ri4MtJ+3BLIBFWuIv4wTYCQuRGg5QYvnPXX+7WAb3xQTIk5CigfU6hIReDi?=
 =?us-ascii?Q?a7tYuWz5BaP9HocCAjkao2gGICrWt1AhwxvAKhCa9FDjLAQZMVidn6rC/aro?=
 =?us-ascii?Q?raI2T4e0xiWrVUx0QajA5u9sLkb7CG+8GJ7roMdewDcpEejjpHWrlezWs8OW?=
 =?us-ascii?Q?aYyspxCO+tuM4Q0yK/3BEA8Ld2LCuwiqd5v5ICt0q42MZDdAg0zBfYndndH0?=
 =?us-ascii?Q?s4aFiqNSjQxlsQ/f5XSw7K0anWg9qwdMuS77YrBnIGyVkB45OlblF1he64pX?=
 =?us-ascii?Q?zhErngq8/epTAuyvJGh8msVyxkqP7oETkUCtOM+t71uebGIv4+Y4Eedw26Ny?=
 =?us-ascii?Q?0/U3xUnyaCdIndp40qqi/U71IsihT5jLrhAcqrYl5U7V5pTWrVLbAbqBEJ+7?=
 =?us-ascii?Q?jO125fq977pnsfKAa4jiB1ejOYHucbrtRcDNHDP1a0AptXom41hB33u/pGAy?=
 =?us-ascii?Q?h7zMLP1SQurlylmTvfV+WzAYfWsHoTUIZW9HUdGGgpVnr+mVmOgylfY22UmE?=
 =?us-ascii?Q?WMUXTc7s03GBA1R0Y0nleQBduxLLxvtD6SjaIa1PkR4j2/C3xbkzz2mGR6BU?=
 =?us-ascii?Q?zDR2KphUfauFWAaOR5tlN0QXG40H8274VL1wPY6Mv5SbbkQwKuWPBAsFnGCd?=
 =?us-ascii?Q?DJoy7063d+uQgcUm0fugJl58S42T6UnXmGPgVqbBpYI8aidZ5t2eXsAQPssX?=
 =?us-ascii?Q?ogGbGVoZ196HkziN4+AcoOQZdxpLZR6R5W4KcHIYsIzUV0Nog9Xck6rTWfTH?=
 =?us-ascii?Q?S2/nEiiHwSmrDMSWgjC1cAKM9Eke7B/oz95jNCgYVcKvwHiaxjI2oNhZitLS?=
 =?us-ascii?Q?9kcMWL+53wOEliOTKcR8Ygcq+LoZbQ3mTVCtw3GWGEmNIGmE1OQEsgb/wAG/?=
 =?us-ascii?Q?D78UcpF0AW4whNGfT0UjhTk8i4510LBukiFJB0vh66apx6qRtMDi0seQHreq?=
 =?us-ascii?Q?PsN1NahndVqFf5wYt76OmyaT+0JHBC3ammWt664bg5VdkpzC11djjovI5HJH?=
 =?us-ascii?Q?WREaehmowGuhirFFuU8hEUNwOHZhh/3OsmS7Mbe5jKetT06gPmA9D+3ITMML?=
 =?us-ascii?Q?mmFPjXkskOAgDjWxZquDqQPeFlNZ/oAJ15sW5gaqN+xayyG8fTS7yNtnjFCf?=
 =?us-ascii?Q?yjBH5BCuG6m1B3vKD323hKmHT5lmXgxlzUU54WJg6tyf0DZ+0x08pvjQSZ+P?=
 =?us-ascii?Q?qIqyUvH4ua9Zx96E/JipWRguWvvU9WC3KXEzNUwdizKM/rS5DEcgWFakTEPw?=
 =?us-ascii?Q?nm4+I5yIdgI2MUY5WGCfnhNpFjFSHilj3+SgE+vE15tll7TxMeejpiQ12ExV?=
 =?us-ascii?Q?3EW3hXI3wl+IfHo7mgqmcpZ9wwDLGyYhnYeJD52Gt/pEiyJ/Piff6W3GY8mj?=
 =?us-ascii?Q?towhDW8IxE7dbuX3k2Hf1jhrl+C7odaR/u68B/yP/QR0XY2zGJNoVeqARGsf?=
 =?us-ascii?Q?AjNNhF5SetdHApyeNvp8prT0MqEktyYksR3oS/9y3lJGfE2KZw99aPYXWVQE?=
 =?us-ascii?Q?rBphAiv3cEE7QajnY/LlrUMgfT0J7B2lGbJMh3PXdP8UtBOCC6eAY/Cqtn6M?=
 =?us-ascii?Q?90/+4rmMPhXkJdvZvrL8Y6IvcSLtdDrdhWtL71sh/nU6jlkT2U2/nPR3FNe8?=
 =?us-ascii?Q?cLUawpC7cDwN1IdzcqwLKdxRSSBxYO7UgF3QJJVyDLm/ObzN6gZVeS3ZeqGL?=
 =?us-ascii?Q?ssrrkR2Cm2yM7YUMcCe3I2PnHKpLmF6uI/73bGGe416IuXCCdfLn?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e944c36-759f-4d76-739a-08df170ed7bb
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:02.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0TELi8qH+gbBtauNqRgJJi4EgOkMiu4s5nt22z1sKRv4ihH3An70OGb2jOy9e4qqWKxb7AyQnUEgh0rYGlw+qvl6K7jwjBN9il5tYOMPFcoyGWXiqtmd7/j1Hed5nZh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

Add bindings for the Peripheral-0 clock and reset generator (PER0CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../clock/starfive,jhb100-per0crg.yaml        |  70 +++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 281 ++++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   |  77 +++++
 3 files changed, 428 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
new file mode 100644
index 000000000000..db43e03fd60c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per0crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-0 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per0crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (25 MHz)
+      - description: PLL6
+      - description: Configure 400MHz
+      - description: Configure 800MHZ
+      - description: Non Coherent NOC Initiator
+      - description: Non Coherent NOC Target
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll6
+      - const: cfg_400
+      - const: cfg_800
+      - const: ncnoc_init
+      - const: ncnoc_targ
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
+    clock-controller@11a08000 {
+      compatible = "starfive,jhb100-per0crg";
+      reg = <0x11a08000 0x1000>;
+      clocks = <&osc>, <&pll6>, <&sys0crg 71>,
+               <&sys0crg 72>, <&sys0crg 70>,
+               <&sys2crg 23>;
+      clock-names = "osc", "pll6", "cfg_400",
+                    "cfg_800", "ncnoc_init",
+                    "ncnoc_targ";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index d19618e2a846..add2cd093dbd 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -106,4 +106,285 @@
 #define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG0		32
 #define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1		33
 
+/* PER0CRG clocks */
+#define JHB100_PER0CLK_CDR_I3C0				0
+#define JHB100_PER0CLK_CDR_I3C1				1
+#define JHB100_PER0CLK_CDR_I3C2				2
+#define JHB100_PER0CLK_CDR_I3C3				3
+#define JHB100_PER0CLK_CDR_I3C4				4
+#define JHB100_PER0CLK_CDR_I3C5				5
+#define JHB100_PER0CLK_CDR_I3C6				6
+#define JHB100_PER0CLK_CDR_I3C7				7
+#define JHB100_PER0CLK_CDR_I3C8				8
+#define JHB100_PER0CLK_CDR_I3C9				9
+#define JHB100_PER0CLK_CDR_I3C10			10
+#define JHB100_PER0CLK_CDR_I3C11			11
+#define JHB100_PER0CLK_CDR_I3C12			12
+#define JHB100_PER0CLK_CDR_I3C13			13
+#define JHB100_PER0CLK_CDR_I3C14			14
+#define JHB100_PER0CLK_CDR_I3C15			15
+#define JHB100_PER0CLK_200				16
+#define JHB100_PER0CLK_600_DIV6				17
+#define JHB100_PER0CLK_600_DIV6_DIV5			18
+#define JHB100_PER0CLK_TIMER0_DUALTIMER0		19
+#define JHB100_PER0CLK_TIMER1_DUALTIMER0		20
+#define JHB100_PER0CLK_TIMER0_DUALTIMER1		21
+#define JHB100_PER0CLK_TIMER1_DUALTIMER1		22
+#define JHB100_PER0CLK_TIMER0_DUALTIMER2		23
+#define JHB100_PER0CLK_TIMER1_DUALTIMER2		24
+#define JHB100_PER0CLK_1200_PH0_LVDS0			25
+#define JHB100_PER0CLK_1200_PH0_LVDS1			26
+#define JHB100_PER0CLK_1200_CORE0			27
+#define JHB100_PER0CLK_1200_CORE1			28
+#define JHB100_PER0CLK_1200_SHIFT90_LVDS0		29
+#define JHB100_PER0CLK_1200_SHIFT90_LVDS1		30
+#define JHB100_PER0CLK_1200_DIV5_CORE0			31
+#define JHB100_PER0CLK_1200_DIV5_CORE1			32
+#define JHB100_PER0CLK_PH0_LTPI0			33
+
+#define JHB100_PER0CLK_PH0_LTPI1			35
+
+#define JHB100_PER0CLK_PH90_LTPI0			37
+
+#define JHB100_PER0CLK_PH90_LTPI1			39
+
+#define JHB100_PER0CLK_240_CORE_LTPI0			41
+
+#define JHB100_PER0CLK_240_CORE_LTPI1			43
+
+#define JHB100_PER0CLK_AXI_DMA_I2C_INIT			45
+#define JHB100_PER0CLK_AXI_DMA_I3C_INIT			46
+#define JHB100_PER0CLK_AXI_DMA_UART_INIT		47
+#define JHB100_PER0CLK_CORE_DMAC0			48
+#define JHB100_PER0CLK_CORE_DMAC1			49
+#define JHB100_PER0CLK_CORE_DMAC2			50
+
+#define JHB100_PER0CLK_HDR_TX_I3C0			78
+#define JHB100_PER0CLK_HDR_TX_I3C1			79
+#define JHB100_PER0CLK_HDR_TX_I3C2			80
+#define JHB100_PER0CLK_HDR_TX_I3C3			81
+#define JHB100_PER0CLK_HDR_TX_I3C4			82
+#define JHB100_PER0CLK_HDR_TX_I3C5			83
+#define JHB100_PER0CLK_HDR_TX_I3C6			84
+#define JHB100_PER0CLK_HDR_TX_I3C7			85
+#define JHB100_PER0CLK_HDR_TX_I3C8			86
+#define JHB100_PER0CLK_HDR_TX_I3C9			87
+#define JHB100_PER0CLK_HDR_TX_I3C10			88
+#define JHB100_PER0CLK_HDR_TX_I3C11			89
+#define JHB100_PER0CLK_HDR_TX_I3C12			90
+#define JHB100_PER0CLK_HDR_TX_I3C13			91
+#define JHB100_PER0CLK_HDR_TX_I3C14			92
+#define JHB100_PER0CLK_HDR_TX_I3C15			93
+#define JHB100_PER0CLK_CORE_I2C0			94
+#define JHB100_PER0CLK_CORE_I2C1			95
+#define JHB100_PER0CLK_CORE_I2C2			96
+#define JHB100_PER0CLK_CORE_I2C3			97
+#define JHB100_PER0CLK_CORE_I2C4			98
+#define JHB100_PER0CLK_CORE_I2C5			99
+#define JHB100_PER0CLK_CORE_I2C6			100
+#define JHB100_PER0CLK_CORE_I2C7			101
+#define JHB100_PER0CLK_CORE_I2C8			102
+#define JHB100_PER0CLK_CORE_I2C9			103
+#define JHB100_PER0CLK_CORE_I2C10			104
+#define JHB100_PER0CLK_CORE_I2C11			105
+#define JHB100_PER0CLK_CORE_I2C12			106
+#define JHB100_PER0CLK_CORE_I2C13			107
+#define JHB100_PER0CLK_CORE_I2C14			108
+#define JHB100_PER0CLK_CORE_I2C15			109
+
+#define JHB100_PER0CLK_WDOGCLK_WDT0			126
+#define JHB100_PER0CLK_WDOGCLK_WDT1			127
+#define JHB100_PER0CLK_WDOGCLK_WDT2			128
+#define JHB100_PER0CLK_WDOGCLK_WDT3			129
+#define JHB100_PER0CLK_WDOGCLK_WDT_EXTERNAL		130
+#define JHB100_PER0CLK_SCLK_UART4			131
+#define JHB100_PER0CLK_SCLK_UART5			132
+#define JHB100_PER0CLK_SCLK_UART6			133
+#define JHB100_PER0CLK_SCLK_UART7			134
+#define JHB100_PER0CLK_SCLK_UART8			135
+#define JHB100_PER0CLK_SCLK_UART9			136
+#define JHB100_PER0CLK_SCLK_UART10			137
+#define JHB100_PER0CLK_SCLK_UART11			138
+#define JHB100_PER0CLK_SCLK_UART12			139
+#define JHB100_PER0CLK_SCLK_UART13			140
+#define JHB100_PER0CLK_SCLK_UART14			141
+
+#define JHB100_PER0CLK_PCLK_DMA_UART_CFG		148
+#define JHB100_PER0CLK_PCLK_DMA_I2C_CFG			149
+#define JHB100_PER0CLK_PCLK_DMA_I3C_CFG			150
+#define JHB100_PER0CLK_PCLK_DUALTIMER0			151
+#define JHB100_PER0CLK_PCLK_DUALTIMER1			152
+#define JHB100_PER0CLK_PCLK_DUALTIMER2			153
+
+#define JHB100_PER0CLK_HCLK_TRNG			156
+#define JHB100_PER0CLK_APB_I2C0				157
+#define JHB100_PER0CLK_APB_I2C1				158
+#define JHB100_PER0CLK_APB_I2C2				159
+#define JHB100_PER0CLK_APB_I2C3				160
+#define JHB100_PER0CLK_APB_I2C4				161
+#define JHB100_PER0CLK_APB_I2C5				162
+#define JHB100_PER0CLK_APB_I2C6				163
+#define JHB100_PER0CLK_APB_I2C7				164
+#define JHB100_PER0CLK_APB_I2C8				165
+#define JHB100_PER0CLK_APB_I2C9				166
+#define JHB100_PER0CLK_APB_I2C10			167
+#define JHB100_PER0CLK_APB_I2C11			168
+#define JHB100_PER0CLK_APB_I2C12			169
+#define JHB100_PER0CLK_APB_I2C13			170
+#define JHB100_PER0CLK_APB_I2C14			171
+#define JHB100_PER0CLK_APB_I2C15			172
+#define JHB100_PER0CLK_APB_I2CF0			173
+#define JHB100_PER0CLK_APB_I2CF1			174
+#define JHB100_PER0CLK_APB_I2CF2			175
+#define JHB100_PER0CLK_APB_I2CF3			176
+#define JHB100_PER0CLK_APB_I2CF4			177
+#define JHB100_PER0CLK_APB_I2CF5			178
+#define JHB100_PER0CLK_APB_I2CF6			179
+#define JHB100_PER0CLK_APB_I2CF7			180
+#define JHB100_PER0CLK_APB_I2CF8			181
+#define JHB100_PER0CLK_APB_I2CF9			182
+#define JHB100_PER0CLK_APB_I2CF10			183
+#define JHB100_PER0CLK_APB_I2CF11			184
+#define JHB100_PER0CLK_APB_I2CF12			185
+#define JHB100_PER0CLK_APB_I2CF13			186
+#define JHB100_PER0CLK_APB_I2CF14			187
+#define JHB100_PER0CLK_APB_I2CF15			188
+#define JHB100_PER0CLK_APB_I3C0				189
+#define JHB100_PER0CLK_APB_I3C1				190
+#define JHB100_PER0CLK_APB_I3C2				191
+#define JHB100_PER0CLK_APB_I3C3				192
+#define JHB100_PER0CLK_APB_I3C4				193
+#define JHB100_PER0CLK_APB_I3C5				194
+#define JHB100_PER0CLK_APB_I3C6				195
+#define JHB100_PER0CLK_APB_I3C7				196
+#define JHB100_PER0CLK_APB_I3C8				197
+#define JHB100_PER0CLK_APB_I3C9				198
+#define JHB100_PER0CLK_APB_I3C10			199
+#define JHB100_PER0CLK_APB_I3C11			200
+#define JHB100_PER0CLK_APB_I3C12			201
+#define JHB100_PER0CLK_APB_I3C13			202
+#define JHB100_PER0CLK_APB_I3C14			203
+#define JHB100_PER0CLK_APB_I3C15			204
+#define JHB100_PER0CLK_APB_UART0			205
+#define JHB100_PER0CLK_APB_UART1			206
+#define JHB100_PER0CLK_APB_UART2			207
+#define JHB100_PER0CLK_APB_UART3			208
+#define JHB100_PER0CLK_APB_UART4			209
+#define JHB100_PER0CLK_APB_UART5			210
+#define JHB100_PER0CLK_APB_UART6			211
+#define JHB100_PER0CLK_APB_UART7			212
+#define JHB100_PER0CLK_APB_UART8			213
+#define JHB100_PER0CLK_APB_UART9			214
+#define JHB100_PER0CLK_APB_UART10			215
+#define JHB100_PER0CLK_APB_UART11			216
+#define JHB100_PER0CLK_APB_UART12			217
+#define JHB100_PER0CLK_APB_UART13			218
+#define JHB100_PER0CLK_APB_UART14			219
+#define JHB100_PER0CLK_DMA_I3C0				220
+#define JHB100_PER0CLK_DMA_I3C1				221
+#define JHB100_PER0CLK_DMA_I3C2				222
+#define JHB100_PER0CLK_DMA_I3C3				223
+#define JHB100_PER0CLK_DMA_I3C4				224
+#define JHB100_PER0CLK_DMA_I3C5				225
+#define JHB100_PER0CLK_DMA_I3C6				226
+#define JHB100_PER0CLK_DMA_I3C7				227
+#define JHB100_PER0CLK_DMA_I3C8				228
+#define JHB100_PER0CLK_DMA_I3C9				229
+#define JHB100_PER0CLK_DMA_I3C10			230
+#define JHB100_PER0CLK_DMA_I3C11			231
+#define JHB100_PER0CLK_DMA_I3C12			232
+#define JHB100_PER0CLK_DMA_I3C13			233
+#define JHB100_PER0CLK_DMA_I3C14			234
+#define JHB100_PER0CLK_DMA_I3C15			235
+#define JHB100_PER0CLK_CORE_I3C0			236
+#define JHB100_PER0CLK_CORE_I3C1			237
+#define JHB100_PER0CLK_CORE_I3C2			238
+#define JHB100_PER0CLK_CORE_I3C3			239
+#define JHB100_PER0CLK_CORE_I3C4			240
+#define JHB100_PER0CLK_CORE_I3C5			241
+#define JHB100_PER0CLK_CORE_I3C6			242
+#define JHB100_PER0CLK_CORE_I3C7			243
+#define JHB100_PER0CLK_CORE_I3C8			244
+#define JHB100_PER0CLK_CORE_I3C9			245
+#define JHB100_PER0CLK_CORE_I3C10			246
+#define JHB100_PER0CLK_CORE_I3C11			247
+#define JHB100_PER0CLK_CORE_I3C12			248
+#define JHB100_PER0CLK_CORE_I3C13			249
+#define JHB100_PER0CLK_CORE_I3C14			250
+#define JHB100_PER0CLK_CORE_I3C15			251
+#define JHB100_PER0CLK_DMAC_AXI_PERIPH0_HS_CLK_I2C	252
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C0			253
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C1			254
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C2			255
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C3			256
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C4			257
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C5			258
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C6			259
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C7			260
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C8			261
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C9			262
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C10		263
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C11		264
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C12		265
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C13		266
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C14		267
+#define JHB100_PER0CLK_MAIN_ICG_EN_I3C15		268
+#define JHB100_PER0CLK_MAIN_ICG_EN_DUALTIMER0		269
+#define JHB100_PER0CLK_MAIN_ICG_EN_DUALTIMER1		270
+#define JHB100_PER0CLK_MAIN_ICG_EN_DUALTIMER2		271
+#define JHB100_PER0CLK_MAIN_ICG_EN_LTPI0		272
+#define JHB100_PER0CLK_MAIN_ICG_EN_LTPI1		273
+#define JHB100_PER0CLK_MAIN_ICG_EN_DMAC_I2C		274
+#define JHB100_PER0CLK_MAIN_ICG_EN_DMAC_I3C		275
+#define JHB100_PER0CLK_MAIN_ICG_EN_DMAC_UART		276
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL4			277
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL5			278
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL6			279
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL7			280
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL8			281
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL9			282
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL10		283
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL11		284
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL12		285
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL13		286
+#define JHB100_PER0CLK_MAIN_ICG_EN_SOL14		287
+
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C0			304
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C1			305
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C2			306
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C3			307
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C4			308
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C5			309
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C6			310
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C7			311
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C8			312
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C9			313
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C10		314
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C11		315
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C12		316
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C13		317
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C14		318
+#define JHB100_PER0CLK_MAIN_ICG_EN_I2C15		319
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT0			320
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT1			321
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT2			322
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT3			323
+#define JHB100_PER0CLK_MAIN_ICG_EN_WDT_EXTERNAL		324
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART4		325
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART5		326
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART6		327
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART7		328
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART8		329
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART9		330
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART10		331
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART11		332
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART12		333
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART13		334
+#define JHB100_PER0CLK_MAIN_ICG_EN_UART14		335
+#define JHB100_PER0CLK_MAIN_ICG_EN_LDO0			336
+#define JHB100_PER0CLK_MAIN_ICG_EN_LDO1			337
+#define JHB100_PER0CLK_MAIN_ICG_EN_SENSORS_PERIPH0	338
+#define JHB100_PER0CLK_MAIN_ICG_EN_SENSORS_DMAC		339
+#define JHB100_PER0CLK_MAIN_ICG_EN_TRNG			340
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index fbc55f95e76c..ccfb7616e1a7 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -61,4 +61,81 @@
 #define JHB100_SYS2RST_GPU1_RSTN_BUS					21
 #define JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N				22
 
+/* PER0CRG resets */
+#define JHB100_PER0RST_MAIN_RSTN_UART4					0
+#define JHB100_PER0RST_MAIN_RSTN_UART5					1
+#define JHB100_PER0RST_MAIN_RSTN_UART6					2
+#define JHB100_PER0RST_MAIN_RSTN_UART7					3
+#define JHB100_PER0RST_MAIN_RSTN_UART8					4
+#define JHB100_PER0RST_MAIN_RSTN_UART9					5
+#define JHB100_PER0RST_MAIN_RSTN_UART10					6
+#define JHB100_PER0RST_MAIN_RSTN_UART11					7
+#define JHB100_PER0RST_MAIN_RSTN_UART12					8
+#define JHB100_PER0RST_MAIN_RSTN_UART13					9
+#define JHB100_PER0RST_MAIN_RSTN_UART14					10
+#define JHB100_PER0RST_MAIN_RSTN_I2C0					11
+#define JHB100_PER0RST_MAIN_RSTN_I2C1					12
+#define JHB100_PER0RST_MAIN_RSTN_I2C2					13
+#define JHB100_PER0RST_MAIN_RSTN_I2C3					14
+#define JHB100_PER0RST_MAIN_RSTN_I2C4					15
+#define JHB100_PER0RST_MAIN_RSTN_I2C5					16
+#define JHB100_PER0RST_MAIN_RSTN_I2C6					17
+#define JHB100_PER0RST_MAIN_RSTN_I2C7					18
+#define JHB100_PER0RST_MAIN_RSTN_I2C8					19
+#define JHB100_PER0RST_MAIN_RSTN_I2C9					20
+#define JHB100_PER0RST_MAIN_RSTN_I2C10					21
+#define JHB100_PER0RST_MAIN_RSTN_I2C11					22
+#define JHB100_PER0RST_MAIN_RSTN_I2C12					23
+#define JHB100_PER0RST_MAIN_RSTN_I2C13					24
+#define JHB100_PER0RST_MAIN_RSTN_I2C14					25
+#define JHB100_PER0RST_MAIN_RSTN_I2C15					26
+#define JHB100_PER0RST_MAIN_RSTN_I3C0					27
+#define JHB100_PER0RST_MAIN_RSTN_I3C1					28
+#define JHB100_PER0RST_MAIN_RSTN_I3C2					29
+#define JHB100_PER0RST_MAIN_RSTN_I3C3					30
+#define JHB100_PER0RST_MAIN_RSTN_I3C4					31
+#define JHB100_PER0RST_MAIN_RSTN_I3C5					32
+#define JHB100_PER0RST_MAIN_RSTN_I3C6					33
+#define JHB100_PER0RST_MAIN_RSTN_I3C7					34
+#define JHB100_PER0RST_MAIN_RSTN_I3C8					35
+#define JHB100_PER0RST_MAIN_RSTN_I3C9					36
+#define JHB100_PER0RST_MAIN_RSTN_I3C10					37
+#define JHB100_PER0RST_MAIN_RSTN_I3C11					38
+#define JHB100_PER0RST_MAIN_RSTN_I3C12					39
+#define JHB100_PER0RST_MAIN_RSTN_I3C13					40
+#define JHB100_PER0RST_MAIN_RSTN_I3C14					41
+#define JHB100_PER0RST_MAIN_RSTN_I3C15					42
+#define JHB100_PER0RST_MAIN_RSTN_WDT0					43
+#define JHB100_PER0RST_MAIN_RSTN_WDT1					44
+#define JHB100_PER0RST_MAIN_RSTN_WDT2					45
+#define JHB100_PER0RST_MAIN_RSTN_WDT3					46
+#define JHB100_PER0RST_MAIN_RSTN_WDT4					47
+#define JHB100_PER0RST_MAIN_RSTN_DUALTIMER0				48
+#define JHB100_PER0RST_MAIN_RSTN_DUALTIMER1				49
+#define JHB100_PER0RST_MAIN_RSTN_DUALTIMER2				50
+#define JHB100_PER0RST_MAIN_RSTN_TRNG					51
+#define JHB100_PER0RST_MAIN_RSTN_DMAC0					52
+#define JHB100_PER0RST_MAIN_RSTN_DMAC1					53
+#define JHB100_PER0RST_MAIN_RSTN_DMAC2					54
+#define JHB100_PER0RST_MAIN_RSTN_LTPI0					55
+#define JHB100_PER0RST_MAIN_RSTN_LTPI1					56
+#define JHB100_PER0RST_MAIN_RSTN_SOL4					57
+#define JHB100_PER0RST_MAIN_RSTN_SOL5					58
+#define JHB100_PER0RST_MAIN_RSTN_SOL6					59
+#define JHB100_PER0RST_MAIN_RSTN_SOL7					60
+#define JHB100_PER0RST_MAIN_RSTN_SOL8					61
+#define JHB100_PER0RST_MAIN_RSTN_SOL9					62
+#define JHB100_PER0RST_MAIN_RSTN_SOL10					63
+#define JHB100_PER0RST_MAIN_RSTN_SOL11					64
+#define JHB100_PER0RST_MAIN_RSTN_SOL12					65
+#define JHB100_PER0RST_MAIN_RSTN_SOL13					66
+#define JHB100_PER0RST_MAIN_RSTN_SOL14					67
+#define JHB100_PER0RST_MAIN_RSTN_LDO0					68
+#define JHB100_PER0RST_MAIN_RSTN_LDO1					69
+#define JHB100_PER0RST_MAIN_RSTN_PERIPH0_SENSORS			70
+#define JHB100_PER0RST_MAIN_RSTN_DMAC0_SENSORS				71
+#define JHB100_PER0RST_SYSCON_PRESETN					72
+#define JHB100_PER0RST_GPIO_IOMUX_PRESETN				73
+#define JHB100_PER0RST_UART_MUX_REG_WRAP				74
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1

