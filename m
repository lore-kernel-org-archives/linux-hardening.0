Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B854432F5;
	Sun, 20 Sep 2026 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789906634; cv=fail; b=atFvsRbWqw3d6GsV3muJjQJgcmw8F2LIwvExS5JzF1S0Qw1Dx8xh+TjaaOQY2DbE5HrELYaYdm0dpdzoRTdBKgZvdPuv3vZfH30eIWsZM6u9UIOxlD5s/RuTxhZhY4c4sBLchJr+x2vDpzrGZUp+rJc9RplB+0xPkKKnK0RLCBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789906634; c=relaxed/simple;
	bh=H+p/JbTjbjDREtlsknQDJ4bEVNk2bEysgL6l7gCNOVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jim+dHmAlJoeu+6J/lV4VYActVXRakL5HVuhBhzsu7hj6o2hEGvwbgR4/EgGeyXBFC/GVAp2KE3mgWUhCnbXbEXvdYqqNd/gcDPfSakj0xye71eUGk3/fk4vjTJmHzvrArtT8xzy233fG81BdtZLPNfTtRbVIx5ZfJTRQnWO5fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB9K8Po2vS0kZ5wTGAFy1gnT3HrIM0Nknkebyor7vmS9+ep4IOLJHCPcTuLc2Gh713InwyNBBRF4JzO5amFXGF4PNI6DwwsYDvzgZSxV6J+SfKBQ9LdvAgvDXAxfzyzJQwLclhPqgmLtSyq4FNXHAVaeTwmocDDEjEcHOI5W9lP1i1y7uAuo5vU5rzsp5NGQQ7DaulmRXm/rc4zF5I52iKMo4913HNCNVttJDeLOuKWZAu9L8wURsiVTPG4xezBEd6R8tNnV1IRqcEHMFjBVuW2OnzBwQHYkM1vPl2QARlx5RKj/4cC3OeIzavhgwb5lKMjJ+/i+Lzsvyw7uzTm34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGRCnPe5SrhWgJUFcql3Y1OHApggMchPr9en3umJqv0=;
 b=c9BstLzVHPbzlB4Xlv0jHTjB4b6VWD1u8TkxHxHSQeEGlORL0gEt+7vADKgVGPU7/1GWSzoww4wjc0w65JFPDUqMGuP/bQctYSgl03RTGmQazV2oCivKYxxKfG+MGAz3bzi/fZgZtT24Ksb4vl9LBrxtBHaicpKZTyat+lD2MRtPG0ZUeJiYDPeeIePWaZs5eF+Mnuz5dTAuZVUTX6Ux7X58SF+0ZSEAtUm8RX8LtYygmVBKd7w7pcLenb7V9sdWbtwDB7pxeDqJgessClqReud+EUBG2sRxIz0DbHPgEWnzhN4awYqE0HQ6MGom6dZ3EtAjKSP4Kze8+UgnHQnf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 12:01:10 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:10 +0000
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
Subject: [PATCH v4 19/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset generator
Date: Sun, 20 Sep 2026 05:00:41 -0700
Message-Id: <20260920120044.194901-20-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1040:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ae26de-4bf5-4266-2ce1-08df170edc84
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|23010399003|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	2Dc6nE4cE/XdLd5Xt+d/eUi6o2HzjNZt9hvj3nQW4JNROWQ+ejtLr0FYvYIlwCL8BPvPmuGHe3/13zyn1jqa7jm10LBHqzrAy+4+OevIGC7Y8UGPlPB0Sud2R3ZngbloYuoI6nEndFewE+Db7lE3FoojUaSe16b6FT5HVMobBG+hEIxU2L3e88HimVlsdAzo9FHQvLR2ixL+HLUao7rGdhWCd2+ERo+lfUjlIS88StoK+I5glaC1i5ZJ6Oq/ZGggc7iWnu6v/AGnNSN/YiQJWaCfa6rpb/U/zpK7aT4VUlyq0LTPXM9ZqlbCRpeeCckIcOCHGlhu9A//dCnJ1jmX4+2pBKrveZcA32T5tz8jxCb+0rth64dLptY/pkT8EGZmTgtE96bF0lsFLtmg41wzDToWstyD/YMG4zrL4mHQALadQ/1U31oi6zP+znKaOOfSpZiM1r+1hfFnwRbbCRecw0y/MWrLdNAco3yEni12Jbl99OkqrVjWY1agV1gQaCV81wpZ89MyPIv6dMbnyXbncGgHSdSqN99Fa3sLnkzwpwHLpMHYpfpY6LTnW5ZSCGixiTXulOsdBDEfijRv+hL0nw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Md9zI/NPWr2n/TaV4RhRq9yacaqVJJrtLUg/U+Ma2baUXvJimII//BSOMKOm?=
 =?us-ascii?Q?XpXf07i7R7FzAC9ODUriE5NEFshniqAAEj6a8QcB7QOtZGKbcwSTnwPK2EZL?=
 =?us-ascii?Q?ZnVGfmkFKbmStjmTdN5++DxmjpAF0I7RgKLfXLt1TpkFd6EbHoXKm/uYgBn3?=
 =?us-ascii?Q?CRqqep9e2pI2B7QRN43tOkWBejl86zL//7GRJYnOQOgFdBk1zvR1xEDAdaY9?=
 =?us-ascii?Q?pMJwQHeeMwYozUfuR9KmAEg0JYaPm2KZlDqbkPs5ORggAlodwF73ch4IvTsC?=
 =?us-ascii?Q?G7v8wpcr104ZOBjBoxBT/QnMlOCIxnVTGxbh7E2g/y1GzN1uI3Oxd3r9yZu3?=
 =?us-ascii?Q?EOgNjpH63uJZpLU+exOtK4SdmIBESs6P6vzmYbN4Egy0wyEC8sG48kUv1yBs?=
 =?us-ascii?Q?Pl0jFi8BnrgTSUUT8txpknpqGi+fm4SqDGo5BzBde4CU1u4NGuFFP/8HuGmN?=
 =?us-ascii?Q?pFIGyig4IbWQEi90oGjQ5+04BxvhHdK57r4eieh6qt/REnfXX+yMfMpue3wP?=
 =?us-ascii?Q?tQ4j0uFIeZiRktgqopAyaUvSq5cdANV7yzLvhTit83Ajyairn6DCeGU/rXtF?=
 =?us-ascii?Q?sC5BTq4H/Wr+zPeeS1AHdnrt9zUXpx/Pzrg9LNHRSxNanhqZzvGcIt15UZQB?=
 =?us-ascii?Q?8tdpd9PyRGL2NLBNLffU13cxeFWX4KqlawpQBnzPgi6GfWmyB8RNJHzNuLBn?=
 =?us-ascii?Q?mt839HoBqkbZUOKEAQCW+wCufzNxav1tfRycKjstJXrbvb6J9OGeZIaVQ9PV?=
 =?us-ascii?Q?+EzYhwA6CNlBHnU3juhOUSXFlO+dumVNcqmfkeH3UrXG2SD7EtOZ6Z5+LmGU?=
 =?us-ascii?Q?HE7iDnZ5Fb1Z6UIbVcwAMQeuvT/c98o/KuWz6JwlYtJveO5s/YxEaHeyv1Uq?=
 =?us-ascii?Q?yQS9d8q+ZVcfBS7xPxpaLIXwApyZ9r+BBUto2CIisyEL9nHoItZRPWgX9oXT?=
 =?us-ascii?Q?m5/QL7nlk32kYCq3BjlmqPYxCPLg5X+syVB0htncFVoxKJvWNSnZyvhTjY6b?=
 =?us-ascii?Q?vNtcnjmhQT5q4BQnY/7jhXdGloqkPpZQiT4V138ks1oV+Q4ihP1VqW8jCi5Z?=
 =?us-ascii?Q?p3XgslfBMCJNO8f74KfrVfY/LCGQ3teiJwyB9Y6IXQVXEiqXjLppHiWkEHG6?=
 =?us-ascii?Q?5AKRhgFl7HU6aFxCvKwHlzznzwSc7l+wMfrm+38s9zw8E1OPSCE44XtzqDXj?=
 =?us-ascii?Q?6OQFgLcozqAnmXuFDdgd89bqouAlBgDF48garRYfMmnf14qhDJ9dBSqm/2zh?=
 =?us-ascii?Q?RVhQ/0vfa5p2RO4briLgPcr9IgARxoh9Ff6S8wj3DsoZPllWHqILnA7ubJwJ?=
 =?us-ascii?Q?JC3uHIwxZYNnmVtjY2jOQsycmUu4ELCQXr6YxGSOBI2JWlt0bDVsLSUJ5Bi6?=
 =?us-ascii?Q?vCvsW+HUJ88cv7MitRObqOFFZK1l4yJsU1Zb+iw/exB9wbQik+8So7SvzrVG?=
 =?us-ascii?Q?Y42zPbrzJr2vsDftXpR4Wr/L5r9WWjusOzX1b8pWc+E7ukhUFuQlpG7S2QeY?=
 =?us-ascii?Q?YOhlo94DfrIDcJE2neDFJtrGDJ8Ql92YvpFDU3Tj12RmX/KKufeJNDNbIxD9?=
 =?us-ascii?Q?oj9x9QlzGCTsN0SV/uaou3/3njPUngG25UhGCx870xl3u3dDOOYvRdM06cM/?=
 =?us-ascii?Q?WRrklIuMuA+B4ro+U1uFHA3qVRS1k4ONFMafbNd5MEZH51zBWycEtLsowwW+?=
 =?us-ascii?Q?fgMqjY8PCfBlosybbSowBuFqRSb4NpFIyjX8bVkHVII6Vt1nLjznomGH87li?=
 =?us-ascii?Q?NK0ghnaBGHXjz3CDV0/AyfneME0IOMbbDqxJrRlPsk9HduqdshsF?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ae26de-4bf5-4266-2ce1-08df170edc84
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:10.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dq2H4nUACr0phXhr3CVdXCTK2q34hyStZRgODwtsh20iiyCN3pqGYXkCdOE0SDOAdSAxoi4O99wNc+wZrYOSk1VRtxluGL4PDUP7Wd7VoedQ5oADT0oYKxFClHeuO7BY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

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

