Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2112.outbound.protection.partner.outlook.cn [139.219.17.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784B41837A;
	Fri,  7 Aug 2026 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103221; cv=fail; b=uw7WOJuRlhY+AcCenn/pQ5H++yhwPxvQcg5EGzBENRvQbHn8eyWElRGl1mrzYYzOiujRqc5/BQnPANofqk+L0yP6VPABeU7vHcI/rdwfa0dujhuXy0YOtv/44U2P0jQ5kGQwMcqmH/b0qxp7fCvCwlUXsSIhMVm7euFm9ghqh4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103221; c=relaxed/simple;
	bh=rQ5Sq5Is/mzbEmQXis/a2oli2zE8PaEaO0VhyRr0QeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYzX+Fx9mv5Rf4vwxuK8zsHaNBZHMZOv898EADvPto8soS65kYLSP9p0vRpRPW6eHhTYE4y/UEh7ibCMwJfGhWcchzpY7riJ5blCZ8vkLEtu/apffFMxQt6Z/vjxM+cm0FKn+ZdC8axZiP8ekTiL71YqSPTswEm9NONnUyCWMN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPxApRzDyl/2NGxLIzi9efyVlR0Z8PMyNmNTeHcH56NB/olE2OC7DLL79z3ogJpziBSDf91A7/lkcDfLw9wdMD4+z9mWlDSiLyqe0y1qG2fJJCRKAmhAwFKaUkzgS4xrwUX/xjej9A8hb4gk3afzXoyH9QEL/r9fVJ1PhN0rmlxsGBUPSQuVaVmCijKoevDv4M9IzX7anvywMmwux713Q6Zd6gIOdabxE61r9WYMEvxNsGytrgSu9eSKQZDPlhu6P91/wOT2Ko06a3MvTlA3dd3ytegQcjrqTGgXwmFF/qTJJxSkMZgTb8LDmbVzwEa2Rzb/804WIHU7dRTEWCVX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9T0J9WhskpZHjY/7iPIX7WGPYv4AGoFCgPNp3THz2U=;
 b=Y6LHh5PVkKV4x1v7PDz+Ao7UVRK1M+vgbhvN3kP/Wy4nKZYnyaVKhHo+S0ohF2xRtKht2lmgrCnwXil2EaBV/pOuRd2QXh5cJ0/+OpTfskiz+6bzeghhOsr2+qlQHpgIsEQBvcsbtp3SD43PAUkpLlz+M0/ISmTBTEJx1H6uHRtCKqbyT/I1LrUfDWjPUfsS2TsWl0olnL4oMtM2kKhRiooW56szhMONkn4EeLgmCoM3HMqElznb30uhavDRf371LV5XBrbgat+BTg2CbLkuvcbb4bI/elD8P+5n0P1+Qr1Nijp08ZeL6YYEAI2hb+UF75dNaf+F2e6iCO8H7WUfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:43 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:43 +0000
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
Subject: [PATCH v3 07/22] dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset generator
Date: Fri,  7 Aug 2026 04:29:08 -0700
Message-Id: <20260807112923.191627-8-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9af7e185-bf52-49b6-f6c1-08def4772d6c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	x7HVlCpysKqPHq9TgdylB9w4FWEaC6cxCUNIrNUzXSD0SrQqMnz0FhV/W83J9W4Xf8B/NKZ9QBOGnCYgznoXIqLOqfSktoZzbGDIUZCw9y3ATEDE0mSbjRqBOsVOJnKNZswnuMD+UucIEknd0Xg4CK9s1vEVZN4ok56ldsSIWUZyYXzXGjj+0+p1MYFInh09QlO+S+pQA7jbsKiRFKl8ew9DQhgiIWx3Rom85Wb/g8KYtBGiAEkF0ExDy6pInagLAKtAS7eV61RIw81DusZC+HC8nr4WTALa98j90Qzt9u4i8yDIT95XiYYzPHinDAB9FqwCrnQ2Whj68E8hh3eVwMOXKd5EDSbXBqmuAUa5n+erZMiHvVNoWo1PqRX6WIMGkfA55rPw5W7zuhhSSkxfmofgTn1yBlPdzN6vP5NiIzC7vBkwgvKyvyZqaIuUtIQUSqpZCdoojd1XIOTH2HlCS25xKbXOm+m8BHgnjEH25RRBoRmXCjt8sEEVotDRe33BCii86/z9NMFYwanMFu8bZMuQYXsK/D7nOZu3MBUCceunOs2P3QWhe0N6ul59wpzXFQ7WC3USyszywrjdtAuryg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EN1q8BJy6SjD9mZVY7A5Ot4BDb8oKilqcNFpl1thaN7V5C0aikRXvQIZwrbj?=
 =?us-ascii?Q?rwrCFPcpOuLREleySP2SIKJvTOkiF48URgHV3HfcfW+T5a8QSUVtzzCRrGbl?=
 =?us-ascii?Q?FKR1R7Ie7IiMyT8x5VhBPXvyWYOIR2erA5rWDIgKojwCKxsgsle0PophRiRw?=
 =?us-ascii?Q?X+fhfJlN32BdWrmSxJD9sc+D3/78F8CKXZBQrEnbGioJl/g0p6qs7cS9Wwow?=
 =?us-ascii?Q?uTxL5BEbeiEUquA6fdyPxBJHTL80QBFLg5EFGGOw1gDe23qs1EVxI4Wurxa7?=
 =?us-ascii?Q?2BIaoWz6tXf3yhK/TDsPtqJ0md8IIDPk3At9WySSBUOgLjd4j3kzbW/gy0L3?=
 =?us-ascii?Q?1BAYIjnC2WCWs0sedfqombwt2oO4Rmr1tizfcN11nQbhp8ppmEbGBfeIilxA?=
 =?us-ascii?Q?Zd1RUCU/o2bZKLnAB3wVIR5rOPHo/OwLD2cWVmpLbibesEfrjeFnafKm/BxJ?=
 =?us-ascii?Q?604OulnEM56ZsX9CiFm8t51p/DMJKjEpNdAG8QWsLUhYQ6IIW4+NS7mYcau5?=
 =?us-ascii?Q?M+A52flyuySqVUVS1Eso0LBzg91icmWkf3OBuUTFEniYEjscPYbOs+FPSqvJ?=
 =?us-ascii?Q?CXO6EOoG5jkXTj1Ujy/uYg5F8LwKYCyE/AAoBy8mAclqeou5P1fxzuO3jkRl?=
 =?us-ascii?Q?02cIzSGHQdfYMipDF7agnnYP3FeXifaFGl/HqapKulM5lh0bnDfwXxINT632?=
 =?us-ascii?Q?EN0vhX7vGD/c24Oie9ooPKOAkwDjTdgqFb3n2TCjHUluPOEiEVXCi7ZPpTCe?=
 =?us-ascii?Q?qhxvWclqi2nzFCFc66tHRC0RMdJ9T5TUnKNzIL9IV4u6x8l1Csdrt2WRHL7Y?=
 =?us-ascii?Q?EbguFdAzO5qp26PbtsZurJckfScpCEz1B/LOhK2HlBkePk5etjwv7n7Hnft7?=
 =?us-ascii?Q?gO5FZOn4ecoLN+pIUYEIjs+/F9vrqV4GRV2aKFtpKkVsi6cm1Appgdp7dGtk?=
 =?us-ascii?Q?atdpmF60nWRUjZ5TFCilJxCylf9izVxObuvrPBbe3GbwoSc+mIT+4x4YTTkJ?=
 =?us-ascii?Q?7voDnlr5XoTm9MjBXBRYzq/gMGblxK8zWqBKmvZF2840JqSrY7LKokrCh1zJ?=
 =?us-ascii?Q?M0ydbbrVv3FJ2A4Ku7VO6nVkRKaJirTjlt39HXkximbZFObVnKyXjL1cxcyT?=
 =?us-ascii?Q?BBp+Zc4hs0/62n6OfkSxRvBZdSviKKX7cBv1fNmDK8SDCFjWSKAVtjh4QjfM?=
 =?us-ascii?Q?Lm6lPB8yC+xF0gh9YO/5l8hm8FEeVMf8Z6kely2CoUOOUe1VqTqNSu1XAAHx?=
 =?us-ascii?Q?LRC9QHYAfv4pWQr7pA0/TjMtVm9pjOEuzTt7LQJjDr37+6vy1/oEf0JwXIJ0?=
 =?us-ascii?Q?hcfnodBg0OZzAmc5FA439g9r0TW1A2gvUAi8G/87STNYi1cQppylGX4AZOcz?=
 =?us-ascii?Q?0YxEqV6gm+8hrOKGV7i4Sqgodyc3ytnhuaR4GkvVN3Cwi4IeaQt+omkNKPec?=
 =?us-ascii?Q?Q/RNdPRHzhO5F4NuTY+crqVEpyInlPSiJ114OsMpZaWSfUDAxGIAnkVnRGdX?=
 =?us-ascii?Q?8q/NCJ14ZbqfzqXJ7BHYFaEl8cqmJBPHugg4nXrvjKfWw0r571z8zD+wT+5d?=
 =?us-ascii?Q?klXTaikGShoErVkyF0F8eLo+4/Alwt3nZGDmN0syp4oZFMmItnqECe/Ptnm0?=
 =?us-ascii?Q?B4xHrxppd4Lgm3v+Sbk5gGHXNM/25+Z/aM+1cmIm3Im0XmsBmn7e6cUTIv2V?=
 =?us-ascii?Q?LrVVeWAQfpnCHoFnZdhIGzXbmmpF69eQ/mmxQtFR2q/MeAxXyI8iiJFruDB6?=
 =?us-ascii?Q?xsH2TPIJWpWBYUqyaLGgO0LJx+Ar5nC1xhL8fB4UJgndwPxN8Y9C?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af7e185-bf52-49b6-f6c1-08def4772d6c
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:43.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYdSN5gHFUh36eNTE2fg0Rx8rRW4M4gR0DYfS+kQhlHKiut4gC9FEHxJUMGhMuDVEO6bypxaHbP/bM/JyOWTby/pNQiCBPAfTkP3GGEFhjJ6AvmF4NrL9rlKZDehecS/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

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

