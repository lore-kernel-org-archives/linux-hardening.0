Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7D4F55A7;
	Wed, 30 Sep 2026 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772294; cv=fail; b=MA+F6DPc+2unNqi9Zsox4ZNew8xuT7kjM7yoR8rdU0z27xPSJn7ABR90DyWZ8m01vIzHhPLg4CrVmP6JmvSVGz3XrMook4zl293tDnCQ061xlyXZ3S0xcSzaDS5tv6z1cVCfclYMHbi7s0GtSF8WsrzW6ieXX861cK1a/V/rHWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772294; c=relaxed/simple;
	bh=gm+uSvQc2JZURhqfZePtZg5o6JH6XFKzwy1+v/wRIbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpJLn+Dv20TSln/OxzAXwDdV96BEDnBUP1gkktidPpOtLJM5Eebqo4bhhzPEA+ed02REDqKQASSGI6v4yF+k8CW4Fm2JRqqab4NBn9ZKO5M5RcZYjtCqCnHZt69YgbNb+MmRtcJcFGQ5oS6Zqzc3LttWdUfZ+IY8hECMaZnWezw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUAKzxqLt+OWV2i5DigLxPrLUmUBgE5FkfMi3vbfn/o9o/k16o0Jl1F1UPUA/UrbGSp1W7z/FZMtOd8+Fs5V2pJlU7R/9m5y6Eo4xS5mObnd7G1ywO7JpXoiMF7w5pWj80fSbtc84wF6Wge98WvB83+wAS7dhToAa1yE0MUA1r4747PtuI8pRRzm+meTZ1EqNYjWGtmJOb7XSRP+Vp0lsbEbiUa1f/nchx0ycfHABIFQCOjtcDwybkLYuvrWik6mLYk43MsAzagGqXIg5N05DtGAwfGKFruwzQxylEgQ8vU2EJxqVFXlUcrRw0ix1S5xNXLKq2ypAlJXqdAfsjZXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gXh6TQVZj1d6R8oflV8kGcvtIhIWc62EgOGjISmOhE=;
 b=HN/B1d1IG2+04ImVLyxL+X+k5iDkk6BXKbg4zerFuZN0DmzG+mFpV0+fbsHUIbfwh6XbZUc1+1WTGenmFEhWY9thjYk4uoSoFiJ/8RxTpdyJNN1Js5YPLJcQkJsxeJ22sKn5gkAjmbSmT7GK0QC/epg8C4pKGt4KRL78lxfCGRIsHSYeoIVehNl16T6m9aZQDbSZDLHSc4hSbH9+PTgRssuU4D+fpTx0KOSkega6BvuzE2G2b2COcqSuGcLk9ciW3uVQ7Qpi0+M52mnXKe6bE2CgaWjuMdsXkY/5JX1TrZ1uSvbHJzjWxd8Wc5c7E475ZCeGTlV/OoAC8iWDPImnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:44:02 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:44:02 +0000
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
Subject: [PATCH v5 17/23] dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset generator
Date: Wed, 30 Sep 2026 05:43:11 -0700
Message-Id: <20260930124317.5648-18-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f27ee5e-21a7-4530-c68e-08df1ef08168
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	wDIVhMDnoJ2mAn2hAxf2YGKGHSic2cvxEpqks2AHFwGj3oPzE1aW/kWyKtaeonaeh3tqzLRb3+4q2E3islS9VyBBz6qW/KjjZRVeVedOyHwHrKrbzSddptSTQ+S3mKCj6KKjzTs2ariWf4D+ivmMl5BdM6i1K9mmAqmdHzNSDqO2ZBNXdqnMQoHEDMKpQ44+GAuPJoCKAWPD04yKVvsVkJxkW5WnbrZHxIwPHh6tY3pQg3VEuv3octNq7Yyiq4+eFZshGuRQoZCEuHRgRsgMfpZ/GJ4yoN8qceVxhBrXQ5za9ImkKV9Vwj4BrxX2e0McT1L+yvQyvuuM5svdP/7E8xClxAmRyKUq0H2FJmX7+g8umo5O5Wh/au8J4qPY9PGpIvAkN/D3yd3aLKUirkiz92u0XCZSjy7sxdATxWzWDvx7ZFTaruDdyJUp/ow/t31eiHux85kJ1j8JBZqHLr+T5StLZdtrFvTSNWFHN4RYtyuXbDcEPwfCqLNzSXlbgLppGeMh1r8q9ZNkF2g8Typ3Et87VlnLpyg7QSkh4D0ZWk8aaC97xkC7uJjIZmEVl6Vu+uuoQzVemw+kLJMte64KyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k55zmnn6a+SLDGmnnT87T7fBUKLF0NEzgeXxbX2C6WAVi5DmZ2TpsycG2fbx?=
 =?us-ascii?Q?Rko4RTcQkiKFiG/XLB1HzVSyJuNxOa6zFxI8TwTmt3KilX1xGJ8GQpoAUplk?=
 =?us-ascii?Q?1joT01nkxPV8m/QcxAwBqHgJ7vo/4YhjruNGtvbEjT2r/lB20stb79DQMvun?=
 =?us-ascii?Q?y+6htvXT5OnVK/Mh+yWRXptAAAgd91tBINveCV5ErUKV/v0MfcSTjLJhGpVE?=
 =?us-ascii?Q?ju5UDsYQ7hMtgZ3DemoVSWYUwRtWOg3AAN/jaZThCx/k2gOO2es2y/FvTDvH?=
 =?us-ascii?Q?WOLwuDa755OLs03Dd5IJu3//qyLW9UZ+3W4Z0QyUHsMpGvtbEJdHGuOtZoM7?=
 =?us-ascii?Q?PMf1dkQxK5myGYhHSLNI1S6PPteVp94gCnbzFX56z2JzYaSQe1ty/zQfOM2P?=
 =?us-ascii?Q?SekjZcI8P+HPvxKDJvxaI/Uc03Jrvfv7ecuxOppPLfllMdIU7Zt14Pc0JRsO?=
 =?us-ascii?Q?LQu5OatYyCaglDACnE2jLnD+NA4NaECNht4CHxOU+/+B42YbTtnbN1LvH12G?=
 =?us-ascii?Q?iuVVdcP6lYgHzZSTJtySEGDWF7sAJo6eIjYRR0vVhSQPOn7RRJKflIFyPjja?=
 =?us-ascii?Q?3TATVPV6HA/PKTcmpyxtXI9tqp5i75LSwtRoKPpL0DBonsWRx/DdXCLoYgwi?=
 =?us-ascii?Q?dtSFyt8I+jDJIaRSMsoLYk5Wnyf1ZPND+c/18T65oo03gbzRbkb3uwW3Ot6p?=
 =?us-ascii?Q?GUQHnCFKaiToL6KPrzKjzFe6Bi2ek4H6KePLhq2gkOlrplYO+cbo8IKsLg/F?=
 =?us-ascii?Q?Z0PkXN4F8euENA8rfwPK7ROoOUJyhhMKHjwbK64DCudfM2nLvyFCI70rkugx?=
 =?us-ascii?Q?TghsUEwiX29F1Rr1a+f5Frse8UTiuQsBKmH5ky0ANOQihaNf22MV+aG0pzQd?=
 =?us-ascii?Q?kFWTHkXWcy7uPUMz3EbRi/PLtxNNy/0h4VjrzRmEdk5LzemnNdklVc5Xpy1W?=
 =?us-ascii?Q?WDcvyoy5zwPHp9t7Rs1rbfZLwXYX6pGF+3Gjs3TKfIv5y2bAfT1QAxr5hlyp?=
 =?us-ascii?Q?S2FT4H8GGIXyKq9PRDxdkDGIh5HWE55tOCB4vvMurbW4+M7GvUd/JUEbrwky?=
 =?us-ascii?Q?bjigA2I3cFJnICyNZo+L2NxApmwHRzW4rWXVyQE/EQwy33WLKD3R+CGlGqCd?=
 =?us-ascii?Q?aNa6B+vxPbmd014Yjx5NZ5RaSTj8m8fdLWMkWRrlkoG2p2S2aI4gHae4Svci?=
 =?us-ascii?Q?EVr8IjHwmWVz9llj8bEETMhKQ1q3GHbqB0lLm7/3SG3yullf+hZSwFzW+OdD?=
 =?us-ascii?Q?NvID19+d3Nh529cLVfLnPXo2mACAcqYuzEGJTMoIDCyPgxOjH0l/6/YDTSbv?=
 =?us-ascii?Q?bMBGbhhlMX4g0imga+QERoAw230cPSQbEXq1FEnbt0cjz0tUHxptT1kffo/G?=
 =?us-ascii?Q?4e3MpUBnQV22zJARHhXLqO6e7uFcCpxzTf+3Fz/MJb5rDu+T2ylxUkcspoGT?=
 =?us-ascii?Q?FENZW2TmuyzLb/kgRNZOBMx8AmCmjYZFsOFwyzDOphgLZ+uHVxC+6QpIjpiw?=
 =?us-ascii?Q?JOl43tAS8faccx81Wejgyhsy9HSz0pMxqBLA0qwQgj2af5UmH3MytJhrf8yq?=
 =?us-ascii?Q?+ycJNz+J+ZdrsubA6TofPVsUoEfFdvst3UmH6J5d8WC0xjp3FCleB1Bpohcp?=
 =?us-ascii?Q?x7BMD/hOF9Nn0s1DX/ifUZYwbIkfwMHicZRiHSY/RGrCrA4gScscQtqlY2Bz?=
 =?us-ascii?Q?4ivrPXdC22Ol2f5WIQ6cqaBTbZLz+Rhu6Uri2hfWONKB0WQ/5qP1mB3K0c88?=
 =?us-ascii?Q?VSjuM+tfgy36XZS0eqg/K28tyuNc8EF6IxLbXHeD9lXxBnIu2FAf?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f27ee5e-21a7-4530-c68e-08df1ef08168
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:44:02.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWt5dueOD+qEJHStiVCF3Yn8FcgP7bXDVH3pC6CUiatR1l0Lmz7XyBGLlMOVBKGhs/RwLleMdi9o3VCotfYVJy3gY93Fsx2DaZL+cASk//joHyACT21ZGdwVA5/r+Y/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Add bindings for the Peripheral-2 clock and reset generator (PER2CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../clock/starfive,jhb100-per2crg.yaml        | 76 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 57 ++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 17 +++++
 3 files changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
new file mode 100644
index 000000000000..175654645221
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per2crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-2 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per2crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Non Coherent NOC Initiator
+      - description: Configure 400MHz
+      - description: Configure 125MHz
+      - description: GMAC2 RGMII RX
+      - description: GMAC2 RMII Reference
+      - description: GMAC3 SGMII TX
+      - description: GMAC3 SGMII RX
+      - description: Main Oscillator (25 MHz)
+
+  clock-names:
+    items:
+      - const: ncnoc_init
+      - const: cfg_400
+      - const: cfg_125
+      - const: gmac2_rgmii_rx
+      - const: gmac2_rmii_ref
+      - const: gmac3_sgmii_tx
+      - const: gmac3_sgmii_rx
+      - const: osc
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
+    clock-controller@11bc0000 {
+      compatible = "starfive,jhb100-per2crg";
+      reg = <0x11bc0000 0x1000>;
+      clocks = <&sys0crg 52>, <&sys0crg 54>, <&sys0crg 55>,
+               <&per2_gmac2_rgmii_rx>, <&per2_gmac2_rmii_ref>,
+               <&per2_gmac3_sgmii_tx>, <&per2_gmac3_sgmii_rx>,
+               <&osc>;
+      clock-names = "ncnoc_init", "cfg_400", "cfg_125",
+                    "gmac2_rgmii_rx", "gmac2_rmii_ref",
+                    "gmac3_sgmii_tx", "gmac3_sgmii_rx",
+                    "osc";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 7f508574177c..2b2e148ce5ce 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -447,4 +447,61 @@
 #define JHB100_PER1CLK_MAIN_ICG_EN_RAS			75
 #define JHB100_PER1CLK_MAIN_ICG_EN_UFS			76
 
+/* PER2CRG clocks */
+#define JHB100_PER2CLK_300				0
+#define JHB100_PER2CLK_100				1
+#define JHB100_PER2CLK_50				2
+#define JHB100_PER2CLK_GMAC2_RMII_50			3
+#define JHB100_PER2CLK_CAN0_CORE_DIV			4
+#define JHB100_PER2CLK_CAN1_CORE_DIV			5
+#define JHB100_PER2CLK_CAN0_TIMER			6
+#define JHB100_PER2CLK_CAN1_TIMER			7
+
+#define JHB100_PER2CLK_RTC_CORE_DIV			11
+#define JHB100_PER2CLK_GMAC2_RMII_MUX_DLY		12
+#define JHB100_PER2CLK_GMAC2_RMII_DIV			13
+
+#define JHB100_PER2CLK_GMAC2_RGMII_125_MUX		15
+#define JHB100_PER2CLK_GMAC2_RGMII_DIV			16
+#define JHB100_PER2CLK_GMAC2_TX_MUX			17
+#define JHB100_PER2CLK_GMAC2_TX_180_BUF			18
+#define JHB100_PER2CLK_GMAC2_RX_MUX_DLY			19
+#define JHB100_PER2CLK_GMAC2_RX_180_BUF			20
+#define JHB100_PER2CLK_GMAC2_TXCK_MUX_DLY		21
+#define JHB100_PER2CLK_GMAC3_TX_125_MUX			22
+#define JHB100_PER2CLK_GMAC3_RX_125_MUX			23
+#define JHB100_PER2CLK_GMAC3_TX_DIV			24
+#define JHB100_PER2CLK_GMAC3_RX_DIV			25
+#define JHB100_PER2CLK_SENSORS_PERIPH2			26
+
+#define JHB100_PER2CLK_FAN_TACH_PCLK			33
+
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_I		44
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_I		45
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_TX_180_I	46
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RX_180_I	47
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_PTP_REF_I	48
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_RMII_I	49
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_CSR_I	50
+#define JHB100_PER2CLK_ETHER0_RMIIANDRGMII_ACLK_I	51
+#define JHB100_PER2CLK_RMIIANDRGMII_IOMUX_GMAC2_TXCK	52
+#define JHB100_PER2CLK_ETHER1_SGMII_TX_I		53
+#define JHB100_PER2CLK_ETHER1_SGMII_RX_I		54
+#define JHB100_PER2CLK_ETHER1_SGMII_TX_125_I		55
+#define JHB100_PER2CLK_ETHER1_SGMII_RX_125_I		56
+#define JHB100_PER2CLK_ETHER1_SGMII_PTP_REF_I		57
+#define JHB100_PER2CLK_ETHER1_SGMII_CSR_I		58
+#define JHB100_PER2CLK_ETHER1_SGMII_ACLK_I		59
+#define JHB100_PER2CLK_ETHER1_SGMII_PHY_PCLK_I		60
+#define JHB100_PER2CLK_ETHER1_SGMII_REF_25_I		61
+#define JHB100_PER2CLK_MAIN_ICG_EN_CAN0			62
+#define JHB100_PER2CLK_MAIN_ICG_EN_CAN1			63
+
+#define JHB100_PER2CLK_MAIN_ICG_EN_DMAC_8CH		65
+#define JHB100_PER2CLK_MAIN_ICG_EN_RTC_SCAN		66
+#define JHB100_PER2CLK_MAIN_ICG_EN_ADC0			67
+#define JHB100_PER2CLK_MAIN_ICG_EN_ADC1			68
+#define JHB100_PER2CLK_MAIN_ICG_EN_GMAC2		69
+#define JHB100_PER2CLK_MAIN_ICG_EN_GMAC3		70
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index cf933a1befbb..0965f3798397 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -157,4 +157,21 @@
 #define JHB100_PER1RST_MAIN_RSTN_DMAC_SPI0				15
 #define JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS				16
 
+/* PER2CRG resets */
+#define JHB100_PER2RST_IOMUX_PRESETN					0
+#define JHB100_PER2RST_POK_IOMUX_PRESETN				1
+#define JHB100_PER2RST_SYSREG_RSTN					2
+#define JHB100_PER2RST_MAIN_RSTN_CAN0					3
+#define JHB100_PER2RST_MAIN_RSTN_CAN1					4
+#define JHB100_PER2RST_FAN_TACH_PRESETN					5
+#define JHB100_PER2RST_MAIN_RSTN_GMAC2					6
+#define JHB100_PER2RST_MAIN_RSTN_GMAC3					7
+#define JHB100_PER2RST_MAIN_RSTN_DMAC_8CH				8
+#define JHB100_PER2RST_MAIN_RSTN_RTC					9
+#define JHB100_PER2RST_ADC0_PRESETN					10
+#define JHB100_PER2RST_ADC0_IOMUX_PRESETN				11
+#define JHB100_PER2RST_ADC1_PRESETN					12
+#define JHB100_PER2RST_ADC1_IOMUX_PRESETN				13
+#define JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS			14
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1

