Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31E4D9562;
	Wed, 30 Sep 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772282; cv=fail; b=gGOG+1uMH1EGxK6X6n+f9pkUNBoNdXefnNuTbR4Z25Xz40Gyd0sVoLs1ddnu0AySf5gjGT1ofvEiDKEOGsrJeBuQC+FUDZCEPHNVbuh3Bt5mUkQVEZoiCl4YM4hoJ3K5XnQsauovvIOCGsehSndMihCT4ILGdm3OZfwMNqYkdbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772282; c=relaxed/simple;
	bh=H+p/JbTjbjDREtlsknQDJ4bEVNk2bEysgL6l7gCNOVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbzFPkSEBs8n3kURdbn6AQoxM26vN8Qh9PrH2cYVcYxSwbZ8XAi3AqK4Lfrhc/BZHGC4M6Gk/oqW4uDoH9QoJ9QnnVpMcpfyNh1nDAIvHfcgUGlhZLYxZVKbJxuO2pqwoAErikiP7bwzRsmBG1xhaMI838KvK7pCjAr9MpkCS5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji7wxRa6ILug1iMHDzf9Frt11uQyCYIXlXi3dUQK7gJf+hwtDZa4/XtNbqTDnN9gCGO2XCvqefUf7m1IdsLNEbGM88900gZmQ7+/or9JF2q15I6EicX4CFKpRK4s+L/ZG8EbyA34wP77rB8hscMe/wc5W2smA452ca4RBYcvyPN+vHnqzxhpnktouv3OJVjUkAOzUy+S9CQgeMuBS2Zp+/szxGIoml6qkeyiFOoThcTN6BPiNsPoBP9PdRn6D6NgkV0Co05bK4GQmixmlVUZBcU36/xKgim9VhIhXP5nc3Ff9GtClX7hm76V/FL12iXS2nGZlKNrFHQLXVAJmQlqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGRCnPe5SrhWgJUFcql3Y1OHApggMchPr9en3umJqv0=;
 b=BBpKogcfhmWsFY2x0LlkpsMxRuhBbfgPkfB6HnpAwuPY4zdJDVA2kwb/DIakXHALbrM7ME6FKbDYaq+cg3WL3Yl2p8o4COBReTe4oF1FFN6UGiYvMhCp3nQoy13GTEOl1YeAEEXwA1RH0x2O7QSM5y5isGqoeh1ezP3rUCCl7P07NV3n5WPAP2tCu5/grPXLDvRd+UlZh+cD+2F42ENiBSp+IXujoxRakWs1M6cA7zbDeW7V4/iJoRtJG5jYgRt+/X88GpwnEJKz30zsghsSZ3UEBP06z9vbMRZiQtop6LQRrV9iHZrJUxZKfxnKoA5LjqVIoRhNXFTM2IWNgVJ/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:44:05 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:44:05 +0000
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
Subject: [PATCH v5 19/23] dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset generator
Date: Wed, 30 Sep 2026 05:43:13 -0700
Message-Id: <20260930124317.5648-20-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab93d72f-3b64-44c4-cf39-08df1ef0836a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	RExp4ueo5Hlkfr3lLPMzXfSv9qhO2/cFKjFnr43x/Ileu2SFQ+LVluUtmCmIuqSg4PT0fiN4a/19VMdSgky9XyiH4GIx9voVfX8PxosY++YAEzxzH7FdcV2DkWhGw6wj8kEi6vleg0klsVmS59azJrc/z94x+RCJoIaqffMKyCwJXPXCexL06rZizSYVmXzSV3kKdgEk7dAhbOYneC6JcuSaLlUtT3PqTTMd1/6SAsn7TLJcm66OpPrcOruYePP77yrQYnXBPdrfG7t6qPK9m2oxG14seunsvphd/b17xL7th4bPb5MoY210uGDXmqtrwG0QAoUMhODrHiYWUONP/mCCo4TW4YqcMhS3Mr4YUmFQz/mu+/cFSKLjxSnTBGZfyLGVTWbJ+vAMBhMuBdUqi1PzH1zz29vA2MGgSUtnNBf+s5D2fp542wWs0cxfUifQK6eeNHWKH8hxjgZH6+Vl6SENwF/+9T4rAINi09WEkAIiVuBs72mD9c7ReC/KeTyAbhbNxRj2vZP5bmKykcRhTOEt2YtPSBIsbQhOalGDA7/rJiYkbA+XCpT2wevErzm9oXbminnHJbYU4lma2S8KQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWoWdclnZuzD9MVnQPqc0LEe+ALklJMXJmXPpoSDOIq3bVZlcrGPoHAyS34U?=
 =?us-ascii?Q?HW7jZxq7HIOSRKkraJ/ITehYn1g3QrpXuqhG2iY505rjLbF6aAzOVxFu3Zro?=
 =?us-ascii?Q?IZRm9uJp8+etMPS22ZTUf68FdJsXJNdpwbPWb5Gn2KomzNaG2u61SXVQtwZp?=
 =?us-ascii?Q?uHDGoPdfjqB3Oy5wV77jSe9n6Q8GL+OuluD5oxN0xkbriXezzHQzXjHRsxKQ?=
 =?us-ascii?Q?D9bf7pSVe7DQSpO7MgVF4gP/aZftHdMUChpzdlyNditugH0PA8tGrbLDNbmc?=
 =?us-ascii?Q?V2joFiQKRsv9fOwOglT6MAE/2U9M8ToAJXzIvpIb1toLEpIh9uGedTVouwbf?=
 =?us-ascii?Q?xEMPuxyin99to57UAYoGjBySVdx7piMJLGxW7OoEp73E8Xec/nRtT05l7LPq?=
 =?us-ascii?Q?/f/ZM5oftoLDlCh4cUdxUwBXLFsOoUBZAsONspv+yRlz6DAQKGMHIvL6snN0?=
 =?us-ascii?Q?ZmRdKBz8tLQpLnSpMCnl0ckZRVazDITcaUy5uwZiIlBtaaBl6nkoPK4/nBG9?=
 =?us-ascii?Q?bevg9FaFqmpRcXnU4dG7gASxYx4AHSAPY+EzH5g1qM7BHyUOkjmxNKhKO4HV?=
 =?us-ascii?Q?KpQ1qrB790HfBpyLFrh0sU8QS30LZzv1/lmjSuFHvHYZ+1lpTpxlvqRscgiW?=
 =?us-ascii?Q?W2ty3t9bmiIL0niGrwEqzqwXElmtfw9yPwm0sNtgIaK2NG25LD+lT8JTCTla?=
 =?us-ascii?Q?MsbxVzgY+1/YvT9e+GKGfn2HVcHGNZjK2yWT3S3V2RlAMX6AWDQvFmRz/d+M?=
 =?us-ascii?Q?JomMIYsfoZqGlTNPiIHH8TCKLj6pmxMOFH6o6fUINdTg0Lv3P4/EyXNIvPzI?=
 =?us-ascii?Q?mj9APOuc+j+MNn56s1jiRXmm7jwnVuTsMPfjofb5AALFbORkB4+lODPeAF2w?=
 =?us-ascii?Q?A/Z+QTlCdRFgOgXJDgAMU873JNd2hOGvsd+lnSvkbPvnMBS+nIttqGl7v7U0?=
 =?us-ascii?Q?QCLDIOkxWDINdLFN7aTj+MFnuC+qRdg0i036ShWq7huX/RaGJoGYxbYsxfy8?=
 =?us-ascii?Q?FDIlDCC5GbnMfsIB0sZnXNQJOrdV87yHKkpZh4IWf+TXLaL0uI41G3qOydgP?=
 =?us-ascii?Q?yVCkuOvvNs3UOlis7FC/q1o+35M70AMckuwKrgBCxZVoUsoUYXW5Z5NxFrT0?=
 =?us-ascii?Q?rmXEQHL2UA3jLIfIEuQHrOEgN8dqd2eVDOYyrUOPDOTerOikuBtrg1l74i/M?=
 =?us-ascii?Q?9lAcMRLNGmGspLok8F4KvxKOVLORpf+CncYpZw3isTR88ZCkV1KD79WBvIRc?=
 =?us-ascii?Q?UVis1+lBx/nplONamJYYKfWR9RojBg9Mq3gQR/MBtBDlyJWkU2jQipgVAdbp?=
 =?us-ascii?Q?e0EcdDvMBXr36AgVl0pNxAxF6GPzpPCC/gNzNWTsb3lF95Awt74tmM0bfe75?=
 =?us-ascii?Q?3vtiBpUfajPABPZfwRJo92PwMEvPYCLF0d3bjUX1WNv6wWPP71pbARetivuO?=
 =?us-ascii?Q?ITdzQp/bCUXA2DbvB4G+oZfrokuk8l/cMV99MfWc3TX5JGW32eAGUxkdgZmp?=
 =?us-ascii?Q?Sv4lOEBQOJ3RIP3BSW7y+euNr7gn0HIitBIQQFFU7XHp0M/Zfq0Rlyfl1IOL?=
 =?us-ascii?Q?ulUvL8V9VisNWOdlz0HMoSXMeKNekf+Y4TTwvxa9Fb6XKXgqUywvXrWeMEsi?=
 =?us-ascii?Q?cF5z8ZGX77zNiQmGrF39g9X9dfI3vmIhzLOdNeFz22u920AX87ifPpkB83p3?=
 =?us-ascii?Q?og4kKlY/SPpvi7oSjKltRoysKH+hFCGbeUo36peHWfpF3NVIUoeUQ2miWTTI?=
 =?us-ascii?Q?6hLWszwFTdwzsWIUOLOzlaVFT26vBcC8jIotH8ufsJ7EIoUlKrWJ?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab93d72f-3b64-44c4-cf39-08df1ef0836a
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:44:05.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEB8slGhkDLCJZ03O/yPTXtYsd3Kj/X2tkc+zOi0ueIeYScNfZyfbVPDyHP/m4keh5aw27V8hrv9Ycv5Vld3ED64K38R9bqn0mzVdT3KZ6mP2nOkm2Z0DwiLcHpWl8kE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Add bindings for the Peripheral-3 clock and reset generator (PER3CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../clock/starfive,jhb100-per3crg.yaml        | 76 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 35 +++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   |  9 +++
 3 files changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
new file mode 100644
index 000000000000..2c3b9f4146b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per3crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-3 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per3crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Non Coherent NOC Initiator
+      - description: Non Coherent NOC Target
+      - description: Configure 125MHz
+      - description: GMAC0 RMII Reference clock
+      - description: GMAC1 SGMII TX
+      - description: GMAC1 SGMII RX
+      - description: Main Oscillator (25 MHz)
+
+  clock-names:
+    items:
+      - const: ncnoc_init
+      - const: ncnoc_targ
+      - const: cfg_125
+      - const: gmac0_rmii_rclki
+      - const: gmac1_sgmii_tx
+      - const: gmac1_sgmii_rx
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
+    clock-controller@11c40000 {
+      compatible = "starfive,jhb100-per3crg";
+      reg = <0x11c40000 0x1000>;
+      clocks = <&sys0crg 65>,
+               <&sys1crg 18>,
+               <&sys1crg 19>,
+               <&per3_gmac0_rmii_rclki>,
+               <&per3_gmac1_sgmii_tx>,
+               <&per3_gmac1_sgmii_rx>,
+               <&osc>;
+      clock-names = "ncnoc_init", "ncnoc_targ", "cfg_125",
+                    "gmac0_rmii_rclki", "gmac1_sgmii_tx",
+                    "gmac1_sgmii_rx", "osc";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 2b2e148ce5ce..bdf7d628b381 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -504,4 +504,39 @@
 #define JHB100_PER2CLK_MAIN_ICG_EN_GMAC2		69
 #define JHB100_PER2CLK_MAIN_ICG_EN_GMAC3		70
 
+/* PER3CRG clocks */
+#define JHB100_PER3CLK_300				0
+#define JHB100_PER3CLK_200				1
+#define JHB100_PER3CLK_GMAC1_PTP_REF			2
+#define JHB100_PER3CLK_GMAC1_TX_125_MUX			3
+#define JHB100_PER3CLK_GMAC1_TX				4
+#define JHB100_PER3CLK_GMAC1_RX_125_MUX			5
+#define JHB100_PER3CLK_GMAC1_RX				6
+#define JHB100_PER3CLK_GMAC0_PTP_REF			7
+#define JHB100_PER3CLK_GMAC0_RMII_PLL			8
+#define JHB100_PER3CLK_GMAC0_RMII_MUX			9
+#define JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2		10
+
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_TX_I		17
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_RX_I		18
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_PTP_REF_I	19
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_RMII_I		20
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_CSR_I		21
+#define JHB100_PER3CLK_ETHER0_RMII_ACLK_I		22
+#define JHB100_PER3CLK_GMAC0_RMII_RCLKO			23
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_I		24
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_I		25
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_125_I	26
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_125_I	27
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_PTP_REF_I	28
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_REF_25_I	29
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_CSR_I		30
+#define JHB100_PER3CLK_ETHER0_SGMII_ACLK_I		31
+#define JHB100_PER3CLK_ETHER0_SGMII_PHY_PCLK_I		32
+#define JHB100_PER3CLK_MAIN_ICG_EN_SENSORS_PERIPH3	33
+#define JHB100_PER3CLK_MAIN_ICG_EN_PECI0		34
+#define JHB100_PER3CLK_MAIN_ICG_EN_PECI1		35
+#define JHB100_PER3CLK_MAIN_ICG_EN_GMAC0		36
+#define JHB100_PER3CLK_MAIN_ICG_EN_GMAC1		37
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index 0965f3798397..872a4dd25beb 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -174,4 +174,13 @@
 #define JHB100_PER2RST_ADC1_IOMUX_PRESETN				13
 #define JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS			14
 
+/* PER3CRG resets */
+#define JHB100_PER3RST_SYSREG_RSTN					0
+#define JHB100_PER3RST_MAIN_RSTN_GMAC0					1
+#define JHB100_PER3RST_MAIN_RSTN_GMAC1					2
+#define JHB100_PER3RST_MAIN_RSTN_PECI0					3
+#define JHB100_PER3RST_MAIN_RSTN_PECI1					4
+#define JHB100_PER3RST_MAIN_RSTN_PERIPH3_SENSORS			5
+#define JHB100_PER3RST_IOMUX_PRESETN					6
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1

