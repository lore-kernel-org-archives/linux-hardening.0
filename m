Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7623473C97;
	Fri,  7 Aug 2026 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102275; cv=fail; b=YzfAiha2pGeVgd/2qu2/V8PUqlB/j6sm/d6DNWjjwFHPsx1sBljL29lY6s85Dw9sd/GllMS99wNESyzu8yoH7xGUY0SgHtaVBWnmHqPEcFUMCkyR4bW055loumAzvDjBzIq7ThyyWSvulgOY06d3W2UbWxd9d81UCoKpF2qbqzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102275; c=relaxed/simple;
	bh=H/vZ5Yn8cjW5nbmfIjkAY+aWi4lkaeTF8CzuWScgraQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UV2Wtr0uWM2a0qedTSv88UA4ACpRddj6sMbE+0DzyvOcZMIH1lSm8cjAsHIfGYL1flVEkUIKx+6siOEIAf9exXPHrWCB3g/qZ3K+3lUP0fI8BsKDYuH4Rel0pF4nbLDmSHT61iEEEhg2uqPIUn23rZiAEWBtRcREQu3iBcPVkbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOmftqXEgJreaHQQZ5B8RdB2E1ySkqatzvssCnxdFqWpAh7gnF+wNGu++z1NvP6sXC0EzJE+24WFme1sYXHVGDpQ+b3Ym3WvQiNbiAI1LVYfBliKj/T5VEfO+Txzfi62vWTT4X7v2ZsWkv1sG8xM6YhR4SOn/DdRg5YM7RFnjp+Z2+Txs4zs+gXXHO3s6m+D+9BmZ0t0r3HDlr85+fzLjUm9Seg8ePSDL7AkbO+IOnm6ftLwH//NWSQrLNE7WckT7OQRfxd0f415NZa57AsEo9MBlHb1Zs6ZkHTD1rMKraM5cM4nq5DqWTXZfH/M3Lf8c15UKbNP82rJLYOKfdJKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TauP9r/3dV/iEXdXQaRnjl+opS9TW5uDLkak42TjL9k=;
 b=njbzFkZtLvj/J5LlibJwm73d//q1SgFwW7WiHtBO2CR+mqLstonw2NK2uzq7AGrIQQIBaLha13lGtIOFd3DiWvcFZ25dRENe68WCndhKHpzHj6pkHR10IHS20/ocscgtr9T7g6gbC0tXzRKCCeR87YRLdNj0/YvobydvqNE6B00H0mCeuI+KZk/wDY06EnOAtvRJyIcnwuNa3lW5EWGzCNJzHmAJoV8JjG+zDWUZxBkkMM3pkLEWpW50ONw94PMScPY0eeh4AGxbiSU1k2OED8Z6zeXRKYuEkFzm72Mxobp5cmRToCRMytAxJ0huktAmCC236Z1G3VeugIm9tTQBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:59 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:59 +0000
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
Subject: [PATCH v3 17/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset generator
Date: Fri,  7 Aug 2026 04:29:18 -0700
Message-Id: <20260807112923.191627-18-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 150061e5-b559-4833-5e22-08def4773701
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	JPD51rtKaAKIVgxKvzMvW9uqqrnZjRz5xjCJsdqN65XyJbWLGcEMsABkAuMncfHVVdNTQpewEY666+tRMdUPbHrj/QycZvAMEPYg6EZebsXdRfd5qVUU9wGDSSb7jetrxd/JVql4nJFc53M4TT/VCxWQ9A9+ikGB9VZjhSQat/IyiATOXhb7U+pRjyscmSmPRpgk+wvoPdXP9xZaFvyAIhfROXBGxthNJhnCRxxp13Ckn3gNZ4Z+dgj2uQAUCy9uTpYeKaEq/DcOgVqsipWpvqPBP5eaDw97zp4+X4x4YNkr3xkGjIvJP2zPjogc0P3WnX+Y5Zvl6kW8hIofozORMyYi6V9tpwct+KkgMUkUYg1sSv8HFkBZWbhSSfYh/mURdMOHaDLHF3rT12amjjcxD6Eht/luLCEpOcd7Njgq5aXGOOEmHOp0oai1G0XL+S9ypCqsbh41kQzXHX69StHTLaGW8C2FZJeIBMuZsny3E4zHWmJB+p/d4TO9JNo24Z44UdJChYRotyu3krM1RkO0j3I0ZAEWkzjYzhTe4c2ctxnjLFkS/sWWIZqXy89CNERRNgLpCH5wOO2OItmgubPGSQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FECQAF4vi+xn2ZykqQf7+Kkeyx4vn3tB/tkNz2qa+GGQLHk/LQFOt+RAtyoj?=
 =?us-ascii?Q?8hus9voJ1/lsx2zdgM+/rsC/3g+sPCtpEHmGvqQ+fFnr89cZgdO65vrk2G4Q?=
 =?us-ascii?Q?+vybTcJCGaFTqcz2UPRsYlaUfR+R0dE6oxdCcqxBD/h2ySofuFz8ZZioXsCV?=
 =?us-ascii?Q?L40z5Wq5QdOcF4V7OaLOduSAbQs09K8SswP/ln99575kWsrpf/VKlg4JOXbU?=
 =?us-ascii?Q?owJQm+EBHwdJ3uSuKiKSZ/HnVwseFOmGMWa1m+Uoo19KappNQK9hPBZ33BY3?=
 =?us-ascii?Q?CrJMeV0zgCg3l3NKamhcOX+Xs0jeIb/nmIZwlmpBEvODhnMUjRMwu/h6LbNv?=
 =?us-ascii?Q?z1QaAZnEIJ0tn1xw6E6LuVe7KWziKeLNeQ44mwOalaKpXmI07vMww8GL61uQ?=
 =?us-ascii?Q?0QRrUKJDQpWj+IdZ9kQE02wgjS39ZaEcJavaLRjeYD4aBZ9QukM9AwCxIYym?=
 =?us-ascii?Q?rTR+S0QV4dvxsL1Nz9sSKjsXCBzbIySFeAnjwP/fBiUneKGs75/I2lTgS9iV?=
 =?us-ascii?Q?F6lh1tSzElOAGSc2wl4dl1MVYexGW5bTmxPS0rwRNv3hR+WQf5LMoI2tMkl8?=
 =?us-ascii?Q?HMfE3fnmqum2FIbGXq1o/LCdv6Dahz2mmYg4YEFQQgSA7ndg0veLJMoh2cmo?=
 =?us-ascii?Q?UOH4jxj/hXadCGjTmUVw8TeqUoQLqNT/l3nZuikd9CVml0lis//7KUcXifWg?=
 =?us-ascii?Q?9eZ30ghlWdE224dtrvS7xaFUM3ps+N8IhcvtKjo1XLaLO1Lg744bpo1haIdh?=
 =?us-ascii?Q?070VZDDIDU1R9iBFYGJiaYtF2IlswFH5sEkgznfSRPIxmozzJ07Zzhhhkk9R?=
 =?us-ascii?Q?4DzvL/JGAKoVRBjL8Vx7KA3UP71Jmr/spo06TszeSqW4LDlGBCXK3uskQD1y?=
 =?us-ascii?Q?uAJFsZD6maEVYfUX/j9KuGyEuTdFAxXXvC9lpVkMOoWmz2TfR/HG0Yqh7FN5?=
 =?us-ascii?Q?lDKvwbCxZ2T6PG+ZT0ZIyMqnm8pPNb2Yr2TB3O0aadgiUudbzb3AMSeWobpq?=
 =?us-ascii?Q?IKkHGAb9wcFOmaut7Ihqpeye/I8U7QMczZ16nuSKM305kGk5SxHH0Cz8kZMs?=
 =?us-ascii?Q?YD9jPJTji2ioI9SyLgLojB1O1VkVkR5/t0sFYhj7T68yZNITBe4VAzUZMLMy?=
 =?us-ascii?Q?fxq1LAP4Qrw9g8FUC1mYLcySTbeZV2FREvp7pxAf706LlYnYrkNMZrHUH9e5?=
 =?us-ascii?Q?gugD7lfnzMXgOkoPAL7nFHicIDHTQuPBjDdgVdyWgKKV5DvaBOBCQ7korrY1?=
 =?us-ascii?Q?ra3WYKQOkPdkvFez7QNiCUf1SUcAAtQYn1qUexYE0MfwcXwXzFD9wNgSLh5X?=
 =?us-ascii?Q?ELKOwBPXkRrpnwBpA+YdcEkAbtrQsq3ZPsDxNuBCCaYaWDeKkCUI+aTkEBSj?=
 =?us-ascii?Q?3Qu4MRkZ7IA0H5B8rt19DrbPW7C+Puh+vu5kZWDfUeW2JORodl2CKegQ2UKo?=
 =?us-ascii?Q?Gsj5Mna91UhMHp1XjQRZnBb9aNIUPwWjk6U3gh4W7x1xJd+kOxRlFJzZvM2l?=
 =?us-ascii?Q?qvvmqcEPH4wMgkJhePMjrQ5iq4Wu49VMXMPb/1PG/2fuyNUMCf6zWQbPTfek?=
 =?us-ascii?Q?xvGeW14IJ4t9bZomEE0iH0edRncfZqgkz+eu1vdvwty7FdAdYTCoS42UxWAy?=
 =?us-ascii?Q?6jRUuQalIg/lo4C8vpKMQ0936J24P+MOwJwjgljoSqro0t6AbE834RCHg6gj?=
 =?us-ascii?Q?zHA6JJT0sXjKpF639SdDzcyiIoj+eP9gxziauPnLF4Hm8ZHKfZJ9TdmukOxa?=
 =?us-ascii?Q?Sm2bpzmtEpnZutFMK7MAek9Dht9PO1uVJK/+DLzELTz56+ah54HE?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150061e5-b559-4833-5e22-08def4773701
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:59.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6NpIyDA5HnQ7fL8oeTEfK7v5ZGz/sVScDT8b8hDGI6WsGSu3+dQ2/1uuPpewauSPdlsUeYTtRpyiWaZG5GjEOUf42wRVVQYgJUGxljmnyR6c5Zb09Ea1XTZ0PQ0jpNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

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

