Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB184E2F33;
	Wed, 30 Sep 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772262; cv=fail; b=KPa6jS3M4NFzJgOMZnFP3aa1w+qsXChWCaxYu4BoR/9WW2GeAn1b4juWXzlqocjBHiSL6WU25njcrkbMc0626Xrk0UAstmn1wzHDx5Dl4ZBxzdir6+CBuO4Ow/CppPzeGMa3rGHVe9wezb12FrYRW/ZCVM38MM6MvnUyqYYyJos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772262; c=relaxed/simple;
	bh=RkZv9gxLKvhijrUjutuw/7sxrPWQJne7DE21NePKZbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E6GMljGDNPBv14FAPHEGpFsu/oXRH3X93LLrJq0EoMumbqAtCDjHRd9Me4oeIpZr7lknZk+5V/1et3IopaISfQHfsipKZWe/tbEcaYwdMpaRMSI7O/uDV7qedcPPaXYco47ghY6hB1/vnE7hDkridT+sxAmcD5Ukso6X4Pk1K98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjF2GS9bDnrc4gZkjg63XpYrZC6G1AwoX8PCqW9J7Cm3CKl7I21xHDbdT352KVAQ9U3pk8WNmo8YFMhfc81EZYqvjp7hzUFN6YZghxIpMr/G3+R6quogjQVYoR3AUpjkK1yBdWdl5r/DFraeOxpO0YkhIsta7EFiiRDLl03MWrXEU6qnr3M9e4j+Lc/kv9/gQ8wNMr+EZgqB2kN4vOUfEgZ5kiazdholH1cN6seZH2myTOmXASfvMFPLL2t+fxllj/6/IzhX15QpL3uSP4K+mvcIaRfURp2tVXOptZS022xOgHukvY+IoAsk28J2Sipc5uuAGSMfX0SpUp+DgqCUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MPFYihWFS/sItDsyLBsAXZ0TNHpIA0HhEGZpIuQ/QI=;
 b=QEvouTsWzQ9F7qCxRyrCPJoFGexiJ+Yj97jGn9neWRcAy0Zv1nw12qIdL2rVJDkMLVpL34P8JAqpNWHIPeFO1fqax1DGyCmEdZuujP4BlGnFmeJTuOaOd/o/g+gHNIvCDYWqW4qOza2/TXoogDlaCyDZvTB9lK6J9FrXX7U3KO/rE2zlscXR0Ph8A3OriQpqqpCCFAcCrEmfxvKbDvsN9dcfaRBChn1w71v3zDF3VZ/yg8JyOTIOkQcP1q18Lnew2tgPN9nxrSCWGl4/3peeU0O8UasGs7OEOLQ+2KuIM+emTYWdqSHZ6AsnFUPJWqxvBa3RbFXEj0A22KqaU1EfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:52 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:52 +0000
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
Subject: [PATCH v5 11/23] dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset generator
Date: Wed, 30 Sep 2026 05:43:05 -0700
Message-Id: <20260930124317.5648-12-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: acbcd6a5-27e9-42f7-b59b-08df1ef07b5c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	SnWYKYek0B8rIvCWYr7yCsIuBzTF3qf49GRemyxhQpFkBXtedg+PoRLmw5eiQeECj7Ie+M8MScNlfD486PUmWkv8B7oizPq7u/2dRyNO2hr773P/Gs5EGB7t/P8+bdgTPXY690z9E16D4a79VM4EwlJIeRTStBK1QmBnFv0/Rl8zzaad61RItkMbzaKKIsQPaQ9qNvhLjD0Kh6NtQNBzyWOWH5xTwVUfLvWUW/dhR89jtQOw5zB0S67/v4hS2GzAydrE11eC+TB/AoKhSz+H8v+XqzljWEP6cniOKqFrwNDeyVx2z8ZD6nPjX0dUbV5Cz7vL1C24EgifkEd3O0HZZk3CddmNKtl73XLA1zYbRRCJ69YxNz2pk3qwEyqGWVwyLfDLM/weQEbP77C08ZNBPwsN/H5wc+bt6NSTnUj0b0NA0mEKBr2EqyY1bLWmAwANBBRvTb0h6HKK0N3SUbtKIY3yQsElnBSlKQ0Nm4JmGZiLFD3V1vrhuqz9K1m3qm7m77nhv3NVLSC7Y4gfDq1JnmcjB0JyyNmOmvssj0KLDht6BCFevy0n2HrZbCUhFV/hyWbGsUGVzuR+VsIpXNJU+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3BczQyp+eTXH53GuOu8scvk9HZtBHbucvTpdMPxaLd41ASSbsPITWEsIgDS?=
 =?us-ascii?Q?Dl64OSN7BYkwkd74r+2FlHu/7G453cvvP6LQZ8hstW+wu3jJ6ghnvD6t7W4v?=
 =?us-ascii?Q?xdqE2TVlFjj1ak2IqkS/aSYOTREXIxLl6we70Tr+mVtmHOmEEHESP2OMsHQr?=
 =?us-ascii?Q?7D28vCTUe7bcYCpoCCms7nm/pefZyS1tf8biySZeg/HptesO7ja4L6s6VWaR?=
 =?us-ascii?Q?NOaSbjVbp/XwcJlE0YUXfcNwZqMt5xU6Kw24erVQYohCB3u5LqKS+aBsN7JW?=
 =?us-ascii?Q?QwefVov8THct2dLBkqTpr70xZrHMzsMimXXykUq9ujUbkVL3VHdX4NtQeTQb?=
 =?us-ascii?Q?IZYJN1Pft45ly4+l5iiFMFGfFZlgPn+vPE6plHOyuWWXAnTAChMofBuoNhlh?=
 =?us-ascii?Q?d2ugNIL2xZDcOEZdkQcuPt+HToUJQY2FPw1+fnhcPtnK2oFj8lqm3XZZeeY0?=
 =?us-ascii?Q?yTyg12G11KPn20w3q2W51K9QDhMHLBLVC0f+DaUMbPZiWNnXeeGp0mJkgam1?=
 =?us-ascii?Q?3D9Oan10u8y8akIqdiTlynf6J1b3jGmSQsIfnHf78u97SgKMLLVGMbjjUbKv?=
 =?us-ascii?Q?4YFoUPnCR0nUNNfbwJOIKY2k+z0ASREe0RGOM9gyGKhDqaRpdNM8llvihhJY?=
 =?us-ascii?Q?EpkMGPbiIZ/ADT4zn/Fm3yatQRCTs67Jv4Walm94dADRBY+QlXPz/MBrO7eC?=
 =?us-ascii?Q?vIrqO0DL7WJ7jK593amzulQkmctn5wJVCoOL7C/4vAH3S4Hqemq/Fp6yTNda?=
 =?us-ascii?Q?F4II8NeMmV7Rm5G3IoynprgBpsXVpJA2gRLjcjfDfj8kisNhvGACfCCeqaej?=
 =?us-ascii?Q?06sPsl/W3c6bbJEd3Dz9+d10abFOmhGAqAlmEFMJL4b3fWcrn5DtSZ/Bh6Z/?=
 =?us-ascii?Q?BKf+Y7YMBYz31iX7FFxDfI8fzmhup9Vky3X2MfcZ0BSR53uNEdKl9Ig0GxVO?=
 =?us-ascii?Q?MNUa3bxQ/XsxJiB6uNYyC9BCzLOWDMrWKDjes956rwtcdMurP4HgNe+M+yTO?=
 =?us-ascii?Q?6hANdZAkneSheiG2Evs10d8rURLKzGM8sNBk3tyc8qIoh8KwbYuEd2Y/3LYr?=
 =?us-ascii?Q?zuDkAfXz2xmCEp/EmKIUUpkc+5zELy7cWvFkozCIQzH5VNfbiNTYjpDmuxnE?=
 =?us-ascii?Q?dOCznaBVaHeppX3QBbX3U8yQ4wvIP6u0KEs/MJ6l5H3bnxSHBDBz1B1AX+ay?=
 =?us-ascii?Q?Ab5Gj6m1kp3ZWXI4Z4nMQixqYbFomKDuL0l6nYv4ZsdaoIR4rcMAuUut+aIq?=
 =?us-ascii?Q?m3XcnTGxdezej1b7slqsu+uPf6UP1MTfJgK7yRF/kDY58E6zqhXaH2hwrhTd?=
 =?us-ascii?Q?fOlzLLEXnT40sMOhiTFovq9363H/8LIArJc3XtvI9hNZ0Unus49vfQlKd53b?=
 =?us-ascii?Q?LsIpmvLfaBg7LSsVMwuCA1hZ+3JM40+DOTem/P/x4JJwO8OxsBKndDt5kNpv?=
 =?us-ascii?Q?0748pU31ll9Lh29k9qHz0s04ZLe5zsTNOm/sHbTOTscFJ5/efgyD2mAVU3Ui?=
 =?us-ascii?Q?FAKE66m63YpykKWGC11XzxX82RQT7cDwZoe9wU5KBRgi7cUkEvtSBbOljk1v?=
 =?us-ascii?Q?q1sUjSLTbSXbKPGcYjqKkziL6UqIVi3a/H9V0XhhE1sZmYt+YrOim4tvyBuo?=
 =?us-ascii?Q?XcR0IQ1v4eZ58PL643Wgr+dgCgG74w2GdX91d721MXegZlgPEeXgqnf4FsDu?=
 =?us-ascii?Q?ge1YGcPvF1MQnl/ZTZgvSBtp4/BEaV0N8PR1euUpAYudx8VVudAExrtMVOK6?=
 =?us-ascii?Q?6HwEB1fTkerRM1hfTlkW2kErb4adlH56fuhwVWAuIPNFVrOSim75?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbcd6a5-27e9-42f7-b59b-08df1ef07b5c
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:52.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqNm1zBlWTIk2Zc54VdlPX+hptd08ybN+VapouEPMowfJb4bm/EbqyIpdX5WMBiVCbJLmTxxe8HEc08td0iBnVzsyIhHsA8cPl0A4YyxGQ9xp0MRw0DlDxUXw+l8VE5l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

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

