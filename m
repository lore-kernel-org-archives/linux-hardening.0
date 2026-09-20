Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF42222C5;
	Sun, 20 Sep 2026 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789914802; cv=fail; b=gy0mASvxFDgK5pWHFADrjihOl5g/bUTPR0XuNv5dH9GaBuqn5HPJP9JBun1YQloPrhgVBfJZb1LmVOJ+HfUiIFAH5O2xfNOQeCvy/ThMQmCFZI0oCBhhHaBgcVhvJj6EEVJg+5WJA80rzwEZAb09rSXDv1yGKZ4K39dJjfNpu78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789914802; c=relaxed/simple;
	bh=H/vZ5Yn8cjW5nbmfIjkAY+aWi4lkaeTF8CzuWScgraQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=do2lSpe7Qez3vlByXdR9IgtVJ2ywPz5HNclqca8y/hv00K0o/XSyXyxP6YM1f5+ET+Sqtzba6OxgTxbYeacjs42YPPQ4FS4p5t+BllJEUlVJr9+2G0byzCiiraEqtXJaual7QDtLmpoHcN2kesIVzbYzIXhleHpFVAPeGWCKgpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD0gArynY53yYhgArEsIHnCnX0X98eSwJqgQ1Q5jP76P2z+Ee+eXbXrD7pItJWpBH6zWgigrhN85aPOnMoZeWWRKVH62i37ga2WEC4snNe5L7r9TKBty5jsP880BIp7l4D5cYBMnjA2DAjcu2ORv7IppZkYbiElTLl/2zqwsLcvvuUKZXR4gV+a0Qblwi6885u9MDCDRyaqYVbd/r5qUqqm8kNWcvFuDubCmf1bduLIZubZxNQ9kXu26oNvOeSOF0XtVULYRY6HIRURt2p4EqNL+W0QfLexIjGudBD4dz/JeNkUjllzjWx/ED05i8To/T1lAj+IYkywg8QMYqcvEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TauP9r/3dV/iEXdXQaRnjl+opS9TW5uDLkak42TjL9k=;
 b=fI4DafrZRvg+aagoSB01HODC6Y1BYO0sn1bR8letM0jgljjV8eblPch2hc4DE5Ur9k7U2b3ZOg3yr7T29KKgbN49JmQpjGSC6QDCOqVs6brdaepM/p/pomoe7Zt27IkjNxG4YpFQCs9Y0OeeuBs6372//0NBXjzjUqqpKmzeF+wqXMTgee/pqD2ODKSY1D1HjttGNQcFFQkUD2f4hJhB24J8P02UriHBmDGaH70VxixfbHQXbyS9OONPaoS7HEYiSSMhiT3X/Z7guwKRgi6FYROT1P/mbZUAXgtlF6/O/MBDqi00o8B+RBNn1P8HhlWJIiT2iEC1GmqXSrFPba9fHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 12:01:08 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:08 +0000
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
Subject: [PATCH v4 17/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset generator
Date: Sun, 20 Sep 2026 05:00:39 -0700
Message-Id: <20260920120044.194901-18-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8d2f2eb4-5f34-47b1-5507-08df170edb54
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|23010399003|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	zWnXqDan2UjZ4cuCGIdXLIg0IvvOw17JwG5MPHVYkg3n7mMbouuMkQGCZmbaB834pTrmOOhyksQqZh+JmhHtwjOB8c+aamuKscYWdcpHv7vz7thTvcl9vvepwgD0PaoDeoZdxveSpvVxxodbDxaT87t91Vp0KcnaUpPdBM3fwnwE/++aKd4JFBpTR3hr65Q0dpFiyZyrQWbwLbdU8Tg4U5cgSGqA+/8Sa+fFJPKR+wEa86vx2zk2UMn3vwBMFdAOeJafCdn7cDGWoIbk7dUhkvRgy4utBuJK6Ud3Sdo/vy+IRmkYWJXFgtnik00B682/4G5m6BAjlO3jOOEAB5Zz1bgouPaFKdJyxzPAm/O0q2z5CvyyEsF0J3ZMy+EZFsOZxcBvgX28NUgFFU1C8N8C0JBiC+7es5UqgWBarPolN+i6RYPFtA8BZdCQHtin7hq2G05Hvx1jbzpnDNXDTpSKzgAU4Q7yGITC31gr+IZmj5g2W4qG6g6YTQZLNmcnxPqQm3DnA0kM9hq9kP50AdHxn+7/7GIjBaXWT90ozsZ89uRlZHa5D/ekbvwIQaX/WfyNFBVVqvg5XQwtNa6MaVUJkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?47xJi+iYOUQruAXS1nMqK74xP92HhAvUxBEYXyyX7d75dezWiUEhBCB+f776?=
 =?us-ascii?Q?qspwaoyPYrfqsh2pmczWwhwYtKbg06yX0tCCYbOa3+PCZdWWREpJ0GJeo953?=
 =?us-ascii?Q?Ov41/56eOee7bHi2NyLH4tliVJ2Gts8JoCoDTDVkQPXmk89f96Xl0VAviwXF?=
 =?us-ascii?Q?Qm9HcDWzyq5eCdoGAV1GzKMmWJdaRiDRYJ5JXnxvX2W1UYQnVuawMdogW6XQ?=
 =?us-ascii?Q?OPmi5Nvi6iH3Jcoc6PGxuC1Cpi3cLytDhAY5vt/nH/gpjaOPGeWhJgQFKrGX?=
 =?us-ascii?Q?3oLz8UuasdzRTMqNsW54U0uq8aGKs9LMbsCWL8vVIubBrjnaMg1RQPiguJmM?=
 =?us-ascii?Q?E1yOJk6kFL6d+heN0ljp4ZcD0gOP+G3jyHA2IYDedJiBphEDtYQTKst931uT?=
 =?us-ascii?Q?PW31MVBM2K8xjYGULd8WBn1fVHECprHTFBEQw8rCDS0OZHiwFJvld9kOLTWO?=
 =?us-ascii?Q?NZ/RLq34U3biHEkN7bvi7QSp3VZEMr8X+tVbFlL2p2x7uDbdK+s/n57RK1+s?=
 =?us-ascii?Q?BI+dnaD+2Kvz/Hza/9kwv3gse5c9aocLE2p8kQQSeAsIm1P8vMLHdTQvvndz?=
 =?us-ascii?Q?kBsZr0YxfdKRSu3l8EQRJJP24CfngpDvNH7XbyRvM/UTtCweQgnmGJnKAB5P?=
 =?us-ascii?Q?TdcULKHPt8q7UcXVxxv9drG7Y04iSkEXImmu8jKEo85keNv8Sxlfsjn47jcq?=
 =?us-ascii?Q?9lNAJPRzZU18rDgcrNLWDJxYTxh5Ca09BW4e2qIsDN1VadfhYR4sH9tzG9Gh?=
 =?us-ascii?Q?B5sSBz0i6nPZnZI1DeLd93SSZD1LMhHoOlcrD4xr7A40RCyiIvFlBnaniUSA?=
 =?us-ascii?Q?xhz4odTRtiH1ehCgJ+oLTjnAEXdXtcgnlPmqLCEaFvj65OH5yZ4aWwCjcw2B?=
 =?us-ascii?Q?wsHe8vnQJZO6z4UyZ5NioEeejj4xAvzS9B98uj/pEgcyIMi879HwkyT2Ghtb?=
 =?us-ascii?Q?edlFXfrhglH8689OQsPfVBQdWCcEEWPnzlJ1j2EsfDWy1sgoVL6eda1J4JRU?=
 =?us-ascii?Q?iq6mPjvrUw2QejGS1mPrHMUqG6IQg+zn1M6IV8fyW6gO5SqKX1yAvjwBaIyP?=
 =?us-ascii?Q?NFpHlb0LxhORCEnL8U/3SyyGZK14khneQz1aH4gES0B+Ll6pKUPIdq/wROkn?=
 =?us-ascii?Q?3HPwgZVa/VqWcASC2B9fm738BHepy86rczFO4ixwS24Brik/Vir8t0fkzmqI?=
 =?us-ascii?Q?ORfCvmHQDImOFSz7L8UXomLujg67Zn0Rr6OdNtFR3Jd4A9QsXR3qTUrTq4C/?=
 =?us-ascii?Q?C8W+xt+Heq2aw2KsWFBHEKrp2JwnUgG9L/+PNVNM8G8QWq23Nc/SHpT5Js6m?=
 =?us-ascii?Q?wRPHBHHsLaEtBT9029QGvio2XBQAXX24Qgnqj5mxy/STdCIHChZFLfkm8y1m?=
 =?us-ascii?Q?bZ9U7eosX0OauWiUi/8B3XO5llS+CbC7pCv1+vb3kurCtm66F5h57sPRfDGk?=
 =?us-ascii?Q?D/tMHJH4SMXBudUNhVVAU1XQrq98aIWiYs1j6kkjRA5jXhc8Hc2BCemnxrnh?=
 =?us-ascii?Q?SRHkdOdqdT+seRPsqo09oq6GtkPJuZQBHakj+DdRSBb69aY0EKW/3kybBBOk?=
 =?us-ascii?Q?RJgw+/iJXyNYdYMyyTimfO3VNWNxcVSLOJywnMfU68RedIdmBGF2W4URJY68?=
 =?us-ascii?Q?RP032QHozzVf2eJQ4IOTQh1G1o6cvwo+c67d04BX1cw/KWzvJD7IjZxVTF+9?=
 =?us-ascii?Q?RDF82M2pL3dnqXnC1ZNysGu3zYR+23NktMYf9ftuhd9Kubs60MUCEji4Yu2n?=
 =?us-ascii?Q?6wfjTtwDVtJduD9kIEBw6I+5cx9aw48yXqcc2MHLa9VGL4Y25Hfs?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f2eb4-5f34-47b1-5507-08df170edb54
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:08.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DO225lSgv01M3QPwUkOeBnubLiafmRRYbUtvqYNqP4HjISbmjoFzCFeR0Gw+OVsKNK32E1cCak73Ge2xdgvbRWeLhPNpRX5f1zeXqQ/EvXZQf8JiD3sJHCMz7Qdvwot3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

Add bindings for the Peripheral-2 clock and reset generator (PER2CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
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

