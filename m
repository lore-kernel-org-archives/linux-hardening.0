Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEBFA59;
	Sun, 20 Sep 2026 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905812; cv=fail; b=OMtqlyhN6VenpIsREusnQ7oDQIf2VIy1hAyUT3PmxSOBPTrzeeU3Vo5PCRt7KwSxPewXNJmlLmOq6OIFWyBmtSfETwfYb5FSOhngejwR12Eq4QMCPVzmX8iUSUqWmWUjrbCBdeg+yaO3BGU1ozg9+WY/xwfr7dYEi/vUzMrZMsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905812; c=relaxed/simple;
	bh=FnpZyhSTNizv3ijuv7V+JgxkjxqZFcBOsGz1ZiyAB5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+7WbwxVz5oR07o2MpHFo5VqgOwzaNPw/b8zSn8kQexltEKYUYCKdIAN5Mk2ud0EN++LAROrnoZtzkCBQL4V1ZffIJsrs6dRlp2uQsHlsC3KrHx1eVKR9ypVIx0Osal60TNpCi9JKHDHYyPod2lGYXQH0i6CCD2MAQTRLjJu00k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnhyqUm7DQT7C9sk6g5JdgkrkUI5C4bPL+GHk8DHPiIInoncWvzb7NUkBRsxuYX1scVC2ts4WaMVj0q9QLPh+NHVIvA9rPKpMP7Ev9RbrftbosPES1oJDXLZGJ0x85gJEyZD1Lix1sfbiIP7y9A54RDcwA+zBtCEYGOnWdbygzCQ0fJUCNo0y7D8R6/+vV+Nbyg0llZ5IlJ0Uwg4Ffrqu465ozQ52YyMSaQKKzLvG6Cz1HYzU/Ozl9L+0zy6H517BzbVYKMh7dWln1s3YbQ0ZIuEQ6E8lkvHs7EpOEdr4hl9GYni1C0Ppk2r++WELbCCp0fHjqFJnI5uDEAALgPEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2SF8hRB7UjebffFXAUK3NwhATvW1FuPGyicBJ/Xbh0=;
 b=NUZLY1y+oLAebHwqO1CN3HsLAeIhsc4vZXOjGmlpkTZAduU0gP4YfCEc/M1xJKOSDQtp9JFK33AjpbH0B20QRqmZJ15Y3S4lb2mIkgBnCZuWIO5exuhBS12oS/gAS4E04xjyxJQq6KW8uqAONN9Rgb0+SjMGGr6Zmk8wT2oFGtiIcQaA9j0vofB0Xf5gnwSmpmsb/4MJIbEcqtI+h2UV1B7MvgR0/lukaZbfj58TX3BN2L7pZiLxkWhI7SK15yroeqxuJRlJGzSnYdJGzZHn3lfWazUch9ZiBQqfOA+dYoTZjd7tHjQ9m3o+yieh3ynt0bJpjzmBWyjtxgLu22EcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:01:00 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:00 +0000
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
Subject: [PATCH v4 09/22] dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset generator
Date: Sun, 20 Sep 2026 05:00:31 -0700
Message-Id: <20260920120044.194901-10-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 635d0575-6373-4acd-6eb4-08df170ed693
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GQKAflrGXOtLitQGdPdIxMlbC6Y/fOhGw1ONTY0PwL6xoPv7Ahxfp84C3+bAVRLchMpA7sxJoIFXdXQfOrhMlPAohGYcGaHQ5UrbMUFM0YHcLb/efIx6/q98TKdQd01l2imGHmRsYACsrpApWa8POWe1/A+jsUw2V/GHsHLcIe2TjTtf5nZMVbVMzQ82tMXBQhBzfXc6tc1/lPFv7tYZnmIf8XeA+eqHkQzxDZ9INMfUXbLZ69/YMmR5ricwEKX4nUlzLDpZRxyswyw8ylp94lA5giIkN5TiNYiRuiPJ43Y5zx1YhtYM2gVxCOvmpcN+5+VCHyldzs54mxTw5eFv1QTsE9cNiHed9RNsNwrRdvQEUofi0Al0Ni6kZQQK+46oKJB1ahs1EJVaquIULCw0TqWmQqIsDTxKUUd5DHHvMlGb7eDi5ZBY6eYyAA+kIiY4xBfWAPQ35WFwWhm3414sGtHTDOj7igD1kr5iX3aBLHWB8pc4zcFJ69qARPo2IydtHH/P26Sqk8xXFZoM7BWaP6XfEJPkuSs2fupvBUIU+eyc+uE9qsbpJO/7AP0BhYvHb8IhQfZWDbotkOguOTasFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sig60Q5weyhGS5ZrHT78tXlb7i9KULQVk8ARe0VYiif4d2IINYaFrP944wLB?=
 =?us-ascii?Q?rIANbbyXd5UzaWYVQ2/guvkadBAnHNTaAUoSEJfnXkAn4PYY/nlMjXD6ffuK?=
 =?us-ascii?Q?KiOaf3twqVvu3X48igf4PN1mJZv2djiCbXKExesNiLya68zwuyZ4XLXgKV2p?=
 =?us-ascii?Q?m1BzdURVazfZGX24MUQLQcFW3Nn7gCS3Y+lfOBnodHtLmOjCr0eTuLBFNIKZ?=
 =?us-ascii?Q?mijelf9TS4nswwbJhg/URl7xbiylztm/wCJhA9eg3wMgx0kScXLqaduS+ydc?=
 =?us-ascii?Q?C79VtjZT4CZYd5orwfVwfX/N9+Cd/Jd25KnsO/UjmHnzhYbrctNhcQKTf4kL?=
 =?us-ascii?Q?Dqleamrzpbzp4ZYx+UxPDmeUEm36uppKy5pRniYUJM7LVWKHgWNf+GqIaS/H?=
 =?us-ascii?Q?IqAgCll8XSJHbfYNOCbVK0h2AB6DAqQilpCjjp37zHPGguiHrL+JCypqzKso?=
 =?us-ascii?Q?lt5ralqyd3Cz2yp0pZRt3Yraz96+UMhEJ4QoJcJZJ7tk+IsEjdKpNkkGnw22?=
 =?us-ascii?Q?AUW1U9Haj2j6SMbpBm5/1INkCceFwYO77XbiULK0sahKWHh0SNahqz7Y/zH5?=
 =?us-ascii?Q?jpOesQ9jTvjx/pjjbpBrnbgyWJGY98qkTFmLR/m7duZ/11SuNk5u6usEzHme?=
 =?us-ascii?Q?wopu5eRnbKZjrb0mmGGyUrb9gesaUWFatg8mOELFwx6XCtVfqC3lQ6MNkq0g?=
 =?us-ascii?Q?iFJjN5b6zVmSLMggFjLkg0YEM7YCUC5zGLC67OCP74YURgQemO8erHaYpOUe?=
 =?us-ascii?Q?41i4OjBuZvBr8PdgJ6HHZf5v9y9EjaGylZOdBJBnKqgFeOaYwAN525bllkqM?=
 =?us-ascii?Q?eScYO1K9ZhKuYs7SnVYnEq9c60BXljt1zll4FTHQxjM3RdY/okF++uyOLy6D?=
 =?us-ascii?Q?/ePl+VnlnbbfRzFSXjtUQ0/y8QVSPe94u/mMEl7X0JCWoo2L38yzDWiR3sTq?=
 =?us-ascii?Q?c8CbAsHntCATor9cmMBYcAhcQ1zA2RirV080v6cTeYlY6ohNZXaiE+vDup3W?=
 =?us-ascii?Q?Y//GKnY4ifaWhAL80R6owGFlXYEzyS/3Xsh4SnB9Qt28amLVRkBG5QaM8M8x?=
 =?us-ascii?Q?ex6K7zSyp+2zbEmZG4gwAOeXBR3Zo2/PZAb1phUnCJ1wjxTYuiwyhw9hvmvM?=
 =?us-ascii?Q?sPIOmWFu1tdXrtu9qN8pLunkyKUeWPv6IHnXtBMm77IgjnqjvCa4jT+W1LBl?=
 =?us-ascii?Q?4G4CkNCOXTYbY7boRFNomdLhedUrWPY1xKOXGbX7fWs7owCJ+vEUvBIxPLOt?=
 =?us-ascii?Q?80lu72DkIuZ5lEVEG00Di3aGiTLKCvvJTBK/uVO4+6m88ut9QudyfKIr3VxR?=
 =?us-ascii?Q?Qdatfan9HmvDAa/pXoDwiBFysTMIMfR/aBWdUVRt/RlwCTc9W8xSLG4upWze?=
 =?us-ascii?Q?i3nx1ePpkvCZWYB68rqv2u6m25mHUaaPqlZnU1GxWkcG9Kd/E/xSoMALms1Q?=
 =?us-ascii?Q?2HGBHQ2D4Mkex235MxMqMbV58TjC6iPR1dobytj2pizmnPNyRhZqqCTFakYi?=
 =?us-ascii?Q?lEypXG87LYr2f3qsouA2pw0H+Nv641H2Q+fJK2Yz+HmUJ81DY50tRidD4dt2?=
 =?us-ascii?Q?d/XWLhAm9a0p0uEwp81K+yzC2CDv35BgN2wyQ771aZvnUQU/fiRDc4AnhV9T?=
 =?us-ascii?Q?TSW9WEZknqEnFkx00ggd0MtdID3S+I3r5qxFIRyKa+E4F19JWV6dMOEKkvOU?=
 =?us-ascii?Q?o8UrppfmHL89d7Xe+Kzog/UzzJN17LcLUO4FqK/wAFgxv74aZSYxHb9H08ZM?=
 =?us-ascii?Q?QEc4yjJ9Lw2xGeS3LaQIb5uM0N3DBwdR0n+NXNWAgHRt+Hi8fTGh?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635d0575-6373-4acd-6eb4-08df170ed693
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:00.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsNO2ChQjSeYBmYQLRjm9ZHvHhZDSJXf6L6pWx9mFHGVzrXBkUYzDCu8VpX8j8UsDtAn9KR3niI+97RV093P4aGSAg2nHSjdsxNjaFJEF62vf1CqvtlFJB7RQk4bK/7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

Add bindings for the System-2 clocks and reset generator (SYS2CRG) on
JHB100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../clock/starfive,jhb100-sys2crg.yaml        | 64 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 33 ++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 25 ++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
new file mode 100644
index 000000000000..a63809c72e2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-sys2crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 System-2 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-sys2crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (25 MHz)
+      - description: PLL1
+      - description: GPU0 Non Coherent NOC Initiator
+      - description: GPU1 Non Coherent NOC Initiator
+
+  clock-names:
+    items:
+      - const: osc
+      - const: pll1
+      - const: gpu0_ncnoc_init
+      - const: gpu1_ncnoc_init
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
+    clock-controller@13008000 {
+      compatible = "starfive,jhb100-sys2crg";
+      reg = <0x13008000 0x4000>;
+      clocks = <&osc>, <&pll1>, <&sys0crg 73>,
+               <&sys0crg 74>;
+      clock-names = "osc", "pll1", "gpu0_ncnoc_init",
+                    "gpu1_ncnoc_init";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index d7904b32bd51..d19618e2a846 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -73,4 +73,37 @@
 #define JHB100_SYS1CLK_BMCPER3_NCNOC_TARG		18
 #define JHB100_SYS1CLK_BMCPER3_CFG_125			19
 
+/* SYS2CRG clocks */
+#define JHB100_SYS2CLK_JTAGM0_HCLK			3
+#define JHB100_SYS2CLK_JTAGM1_HCLK			4
+#define JHB100_SYS2CLK_JTAGM0_ATPG			5
+#define JHB100_SYS2CLK_JTAGM1_ATPG			6
+#define JHB100_SYS2CLK_JTAGM0_ATPG_TCLOCK		7
+#define JHB100_SYS2CLK_JTAGM1_ATPG_TCLOCK		8
+#define JHB100_SYS2CLK_JTAG0_MST_WRAP_HCLK		9
+#define JHB100_SYS2CLK_JTAG0_MST_WRAP_CLK_JTAG		10
+#define JHB100_SYS2CLK_JTAG0_MST_WRAP_APB_PCLK		11
+#define JHB100_SYS2CLK_JTAG0_MST_WRAP_ATPG_TCLOCK	12
+#define JHB100_SYS2CLK_JTAG1_MST_WRAP_HCLK		13
+#define JHB100_SYS2CLK_JTAG1_MST_WRAP_CLK_JTAG		14
+#define JHB100_SYS2CLK_JTAG1_MST_WRAP_APB_PCLK		15
+#define JHB100_SYS2CLK_JTAG1_MST_WRAP_ATPG_TCLOCK	16
+#define JHB100_SYS2CLK_HOSTUSB_NCNOC_TARG		17
+#define JHB100_SYS2CLK_HOSTUSBCMN_CFG_500		18
+#define JHB100_SYS2CLK_BMCPER1_NCNOC_TARG		19
+#define JHB100_SYS2CLK_BMCPER1_CFG_250			20
+#define JHB100_SYS2CLK_BMCPER1_CFG_143_DFT		21
+#define JHB100_SYS2CLK_BMCPER1_CFG_143			22
+#define JHB100_SYS2CLK_BMCPER0_NCNOC_TARG		23
+#define JHB100_SYS2CLK_GPU0_NCNOC_TARG			24
+#define JHB100_SYS2CLK_GPU0_BUS_CLK			25
+#define JHB100_SYS2CLK_GPU0_APB_CLK			26
+#define JHB100_SYS2CLK_GPU0_OSC_CLK			27
+#define JHB100_SYS2CLK_GPU1_NCNOC_TARG			28
+#define JHB100_SYS2CLK_GPU1_BUS_CLK			29
+#define JHB100_SYS2CLK_GPU1_APB_CLK			30
+#define JHB100_SYS2CLK_GPU1_OSC_CLK			31
+#define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG0		32
+#define JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1		33
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index da1b51621172..fbc55f95e76c 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -36,4 +36,29 @@
 #define JHB100_SYS1RST_BMCPERIPH3_RSTN_CRG				7
 #define JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS				8
 
+/* SYS2CRG resets */
+#define JHB100_SYS2RST_JTAG0_MST_WRAP_HRESETN				0
+#define JHB100_SYS2RST_JTAG0_MST_WRAP_APB_PRESETN			1
+#define JHB100_SYS2RST_JTAG1_MST_WRAP_HRESETN				2
+#define JHB100_SYS2RST_JTAG1_MST_WRAP_APB_PRESETN			3
+#define JHB100_SYS2RST_HUSBCMN_HOSTCMN_RSTN_BUS_NCNOC_INIT		4
+#define JHB100_SYS2RST_HUSBCMN_RSTN_HOSTCMN_CRG				5
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_BMC_TARG		6
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_HOST_TARG	7
+#define JHB100_SYS2RST_HUSBCMN_RSTN_BMC_CRG				8
+#define JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB0_CRG			9
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_BMC_TARG		10
+#define JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_HOST_TARG	11
+#define JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB1_CRG			12
+#define JHB100_SYS2RST_BMCPERIPH1_RSTN_CRG				13
+#define JHB100_SYS2RST_BMCPERIPH1_RSTN_BUS				14
+#define JHB100_SYS2RST_BMCPERIPH0_RSTN_CRG				15
+#define JHB100_SYS2RST_BMCPERIPH0_RSTN_BUS				16
+#define JHB100_SYS2RST_GPU0_RSTN_CRG					17
+#define JHB100_SYS2RST_GPU0_RSTN_BUS					18
+#define JHB100_SYS2RST_GPU0_HOST_PCIE_RST_N				19
+#define JHB100_SYS2RST_GPU1_RSTN_CRG					20
+#define JHB100_SYS2RST_GPU1_RSTN_BUS					21
+#define JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N				22
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1

