Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A63142CAF5;
	Fri,  7 Aug 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102270; cv=fail; b=Gr3Los0Pl46hejAThOw9fBZaMGSBgDWU9cKVfeaNzeMAoxWmoaoN3i0hseTZ0ET9R/kQgAH7S0PrkZZBy13fhef4wxhTxOCATY513cRKlpvjeIF1wc047U8au02BZicNXljla0ncrfpnTywaxIl5QwrroA2Ztr5FOGP6274BJGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102270; c=relaxed/simple;
	bh=kx+/yRi1skGoUKdq2tamuo5tICRMS2pFE4LuJmaeUos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8WxCW7gEepP4waSQwlW8aX23QL7qx3CZha4ONtqKg6ybj0IBi4D5PKYPu91zAqhESU2OPcjdz7DFIst6mP1417uiiok1tgZwCSuccuG8w056GPAanX/qVg5ZWJLODvVjGGCU+lEXXeYVUN+DEDGlg3IoMeLC9z1gMyMapZk4fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQYram3W0iA+TS3AitoQZ2VfGcionBVq2i/7kvTiVhpmkRsOfz6WYp+8TKe0zkIPJ7bODBzCnUMC2dcKXtbdFQ9eBgzlpmfvQU5zjkpIgCYw8XlQ2ppqULmEiUOnSFoD/wf8rqCbVRZCgRfn4Lnwf8AuJU8DTTEInLgk6vAHVaBHMU2ivJYIVV03N25+ayI6XFKIcEUH2I+3pEoW4QvBDgEcOzAIvscfxuP8o+izLs1VqXYA5PIKAsjn4y6L8NjYTZKtlqO++639umDXT0vH9bmRQqWbQ5e+X4gH8Wdoe1cM1pwklRJ239N5eWS/yk3/4N/S2hyjOMMtRLLJVK8Bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkGP3+GVo9AOWdSKY8aBZ/0h8Q/E/xBcXYIiscj+7h8=;
 b=I3kTDwOq9yzkxvVRjqMDAkak/+QqiVYQ5+931mBQJ7TJWt0y0vkOvKeyJsiLkySexsKpuv9Dvdlc+y97jgY2ROlZnTr8FlSBSzYYvWuNN5ObMQvKhVSSA30Dmho76CKtHPyyb+n3tam3lxNK6jlzm0gE+PR1Cp8hdMyTElTjJ9ZmPJzlpq1hurCc9hd7yoP3RHp7beuDcj0EgJV64H+H579fDwinw6N1YREMKrEF1wZnVS2jtFYoHdojikitADRd0FTtoHv37el+pp8aqaiiEg8Dz479JXq3OeIQCQGDB8ZH815WzIxMuUhlzMVjILL2Fg9Z1aqJ5V2L+OFDZENl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:56 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:56 +0000
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
Subject: [PATCH v3 15/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset generator
Date: Fri,  7 Aug 2026 04:29:16 -0700
Message-Id: <20260807112923.191627-16-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 76221a40-509d-4ea3-4185-08def477351d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	vsB+zv67GZUJKO1lT1gL0AK/WbpmkqOvKosDPh/vnRIIAuAwqlszMUqMJ2k7J3NIlWDZ7uMTaqwioSwNz0peA9WprcdSL5xx3rSI55XyUkrBGGjf2BI5JRh5gdTWv21AsN2kK3ufQ9zBp4J1TLJi4BzqJC2/eyzdidlx2hortcdqjyNu4wkt9QJNLbCDSD5M+SlU27s8JKmI/gracF5zhw9inw+DfnEe4MtxbiYJrdEelq2c2r88ZUnEoCk9w1QbGK0GfEC/lZ8HwcpRlm3//yM6R2MnTHeTw6bt31H7NpISbCEcKizaH5mrUdb7CG2hxSrV5nCjVDpowESOgCekT2Kqw65TqnkmUU5lNXukp8dZB7ReI5MQjAss2x0yRz7YBTVAcR4IqX75GjMGL6e7KKRjKR7CNVC3DQNXWfq35A1kYWDr9G+0HhEN670bLPSTuo+oCc8pL4QxucTWtsQin0QMY/R2NojznNMzlff5nPsYkQ70toRoyMWn3bcS6haxRkWDHSrso7wyuEqIdHfIqX8fePLVgS10VYahRy2gR9CuMrjR829/H3LJnNekaBlhydT1qJiBlHb7/7CdFlqA2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t5ybj5gEkHIX11COXiqfHmJ6WPE8WAbQpcYMZ/m1CDgpR5O87jgffnFlGyqy?=
 =?us-ascii?Q?wDs90opZoCxKlunquERKT7qTnHyK3lBcCTdN8A3yYbdOIj64JTHNbrtntffQ?=
 =?us-ascii?Q?UREjKAa2EgSi3NBZBhDrjQO4fHbHJi9WWzBmG20w76OQ5iNG2Lw5SphaEJrF?=
 =?us-ascii?Q?pkjt4GIkwk7v96+L9h+0dx78JWG8G7D+lR3GayhRchUJ0R6QAgb6DhQJUFAU?=
 =?us-ascii?Q?9u0LpPFYrPRlA7Fn0n4KQqh17brqXnnxld/QDKVgHqBJxZuI26XgIetCr/dQ?=
 =?us-ascii?Q?16/p1JJ9ouNpLUg60vY5Dm1f5H1wl7jAhw10q37hJE/wpTG5ntlS5kZWDNLg?=
 =?us-ascii?Q?a3O9fJRegpGfC1+HCtnemI/YVez/eYiJRmm+xlbL8EdymwPOVqeQgxxju4VJ?=
 =?us-ascii?Q?TQIBlGjrba5FqkC11Z/N+/bIrNXZuhp78yMDFXH+H7GUCPOyMdewHiKbs8Mc?=
 =?us-ascii?Q?FDNxYISy3cXO33vz+yx1Kixv8/7eAuibt4pxAzlDS66MyWS2UcOHaGNUv/cg?=
 =?us-ascii?Q?KXB0mVVNjB5NzBTahRcdvYTHRPpb8Z9Hxo9l3M62cjg+gPoyGbxuQ+GuzcR8?=
 =?us-ascii?Q?P9xXS7gyksCnyuDvc/R5lHmS++vEHK4l55CxjHFq5FqwN8HO9VFC/sPJc6M8?=
 =?us-ascii?Q?uZ/ugfVZ3kvgeU9pMgp6wIKgTESrAqm+9DfX4SnVBYPdiwdR3Zz4SMiyXWSw?=
 =?us-ascii?Q?/9wbale7I088ENSC8SWUaaDcE8O5FTB/1tTwusPKysQo+ur4dD89EtJL199y?=
 =?us-ascii?Q?MjHRFhEU3OS99X3SQTxcQ99JGS7eA6CyLhhO0NmaPsYd+MaUbRPfejah4/mg?=
 =?us-ascii?Q?QkNgCzBItXxlBZOfc/v+8ZkYy/StbCg566XXN1GDSZ+EcH6SBOYs4z/5utp7?=
 =?us-ascii?Q?qz9Tbp2AT36fxcVpcAdCfwTESA+Abx0rk0VoRKX0UQXf3tezusqE/oaGu/hQ?=
 =?us-ascii?Q?wU5HKJz666zBN0/E+gwYEL7dZ3dmDYLjZ64cxL6379gCA6tIIe3S47k37oBU?=
 =?us-ascii?Q?InNc5nx5hNzxm9e7ghuSo9J7TK4v8dBw7eQXhHm0YEG98m1HN83AkxyK6sNf?=
 =?us-ascii?Q?Xrgkqn/hQyHZmW4pqqQSrP7WL+ZPmRUTn0izNUotpN4BK9OKk/F10lN8PFjR?=
 =?us-ascii?Q?1uisw1QfRhsZXhdVF2RuvsQGVQzQIGsTAlkhrBiCtM0mucFhq62SWkJ1Z9Mh?=
 =?us-ascii?Q?mFFiBG0Gg5/LW2/d3AD0tCM65WItslyGR+LrVRj0AbxvBO6ubxiHE3hbcLrk?=
 =?us-ascii?Q?kMkke9v9jlcKBsQDk5zO5kSiImywyvohOVdEDd1ybFWwV+112PTmfxEu0LWK?=
 =?us-ascii?Q?s7qZRh+oYfdCtfYGJgvdDt9M9pO7l1P7ZR67ZSTjIN7mCbdDOmN5AFYRAPnq?=
 =?us-ascii?Q?pnL+CDg+hQXWa/msCWW+jg8Ky7pR3/ts2iwLBN50HAmdkGVkGDuEwnwRu1BR?=
 =?us-ascii?Q?IgqpewkyT0zXLfRTRK4FLsAejUBhRpsjTWmJ2xIs+OtcgRRUD+UuCtwwNebK?=
 =?us-ascii?Q?JCla7F4ckog2R9ewN3zA9dg8glTw0iT5SVIXxQFpau08b2KiiYWFleQZ6ArL?=
 =?us-ascii?Q?i5kBMDWiCdgt7aFOEFUQNAjqd2+fRa9n8e71yQSvq9O5KrPq5hxiQ3RcpSQl?=
 =?us-ascii?Q?jbO2UOArsXvyAcm3xzoHdOpypwcKE28Io0xc6kuNF8VELyWIbZCnB3zWpZVp?=
 =?us-ascii?Q?odpcfcxqn2r4apDeM6pw0eLIhCpEBgu1Yr+vRscLWu53gwbQGogYUAxB80jg?=
 =?us-ascii?Q?SxLLqhE85qxIT+j/KTQKdva9OK9bnKhlmq7T89pLAgCcZyXqhGdD?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76221a40-509d-4ea3-4185-08def477351d
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:56.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHZYjtivQy2xyTUT5cj/QFsXr1L+KzoiyHPn0bK6MSH2Jv0S0aHsoxoJ7DMV7+89mu2R9GkERjIIJ+LZ+mN69nFulMXsvCNW8xTmj/yyWf3u9RDGx7S3Vjf6ydBahO2O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

Add bindings for the Peripheral-1 clock and reset generator (PER1CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../clock/starfive,jhb100-per1crg.yaml        | 70 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 60 ++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 19 +++++
 3 files changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
new file mode 100644
index 000000000000..c72a355ceb34
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per1crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-1 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per1crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PLL7
+      - description: Non Coherent NOC Initiator
+      - description: Configure 800MHz
+      - description: Non Coherent NOC Target
+      - description: Configure 143MHz
+
+  clock-names:
+    items:
+      - const: pll7
+      - const: ncnoc_init
+      - const: cfg_800
+      - const: ncnoc_targ
+      - const: cfg_143
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
+    clock-controller@11b40000 {
+      compatible = "starfive,jhb100-per1crg";
+      reg = <0x11b40000 0x1000>;
+      clocks = <&pll7>,
+               <&sys0crg 68>,
+               <&sys0crg 69>,
+               <&sys2crg 19>,
+               <&sys2crg 22>;
+      clock-names = "pll7", "ncnoc_init",
+                    "cfg_800", "ncnoc_targ",
+                    "cfg_143";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index add2cd093dbd..7f508574177c 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -387,4 +387,64 @@
 #define JHB100_PER0CLK_MAIN_ICG_EN_SENSORS_DMAC		339
 #define JHB100_PER0CLK_MAIN_ICG_EN_TRNG			340
 
+/* PER1CRG clocks */
+#define JHB100_PER1CLK_100				0
+#define JHB100_PER1CLK_1				1
+#define JHB100_PER1CLK_200_DIVN0			2
+#define JHB100_PER1CLK_200_DIVN1			3
+#define JHB100_PER1CLK_200_DIVN2			4
+#define JHB100_PER1CLK_200_DIVN3			5
+#define JHB100_PER1CLK_200_CCLK_DIV			6
+
+#define JHB100_PER1CLK_SGPIO0_PCLK			15
+#define JHB100_PER1CLK_SGPIO0_DCLK			16
+#define JHB100_PER1CLK_SGPIO1_PCLK			17
+#define JHB100_PER1CLK_SGPIO1_DCLK			18
+
+#define JHB100_PER1CLK_EMMC0_BCLK			22
+
+#define JHB100_PER1CLK_EMMC0_CCLK			25
+
+#define JHB100_PER1CLK_DMAC1_1CH_CORE			29
+
+#define JHB100_PER1CLK_DMAC1_1CH_ACLK			31
+
+#define JHB100_PER1CLK_DMAC2_1CH_CORE			33
+
+#define JHB100_PER1CLK_DMAC2_1CH_ACLK			35
+
+#define JHB100_PER1CLK_DMAC3_1CH_CORE			37
+
+#define JHB100_PER1CLK_DMAC3_1CH_ACLK			39
+
+#define JHB100_PER1CLK_DMAC0_2CH_CORE			41
+
+#define JHB100_PER1CLK_DMAC0_2CH_ACLK			43
+
+#define JHB100_PER1CLK_UFS_REF				45
+#define JHB100_PER1CLK_UFS_300				46
+#define JHB100_PER1CLK_UFS_150				47
+#define JHB100_PER1CLK_UFS_400				48
+#define JHB100_PER1CLK_UFS_75				49
+#define JHB100_PER1CLK_UFS_37_5				50
+#define JHB100_PER1CLK_UFS_7_5				51
+#define JHB100_PER1CLK_UFS_1_875			52
+#define JHB100_PER1CLK_UFS_7_143			53
+#define JHB100_PER1CLK_UFS_3_5715			54
+
+#define JHB100_PER1CLK_MAIN_ICG_EN_SFC0			63
+#define JHB100_PER1CLK_MAIN_ICG_EN_SFC1			64
+#define JHB100_PER1CLK_MAIN_ICG_EN_SFC2			65
+#define JHB100_PER1CLK_MAIN_ICG_EN_SPI0			66
+#define JHB100_PER1CLK_MAIN_ICG_EN_SGPIO0		67
+#define JHB100_PER1CLK_MAIN_ICG_EN_SGPIO1		68
+#define JHB100_PER1CLK_MAIN_ICG_EN_SENSORS_PERIPH1	69
+#define JHB100_PER1CLK_MAIN_ICG_EN_EMMC0		70
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC0		71
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC1		72
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SFC2		73
+#define JHB100_PER1CLK_MAIN_ICG_EN_DMAC_SPI0		74
+#define JHB100_PER1CLK_MAIN_ICG_EN_RAS			75
+#define JHB100_PER1CLK_MAIN_ICG_EN_UFS			76
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index ccfb7616e1a7..cf933a1befbb 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -138,4 +138,23 @@
 #define JHB100_PER0RST_GPIO_IOMUX_PRESETN				73
 #define JHB100_PER0RST_UART_MUX_REG_WRAP				74
 
+/* PER1CRG resets */
+#define JHB100_PER1RST_IOMUX_PRESETN					0
+#define JHB100_PER1RST_SYSCON_PRESETN					1
+#define JHB100_PER1RST_MAIN_RSTN_SFC0					2
+#define JHB100_PER1RST_MAIN_RSTN_SFC1					3
+#define JHB100_PER1RST_MAIN_RSTN_SFC2					4
+#define JHB100_PER1RST_MAIN_RSTN_SPI0					5
+#define JHB100_PER1RST_MAIN_RSTN_PERIPH1_SENSORS			6
+#define JHB100_PER1RST_MAIN_RSTN_SGPIO0					7
+#define JHB100_PER1RST_MAIN_RSTN_SGPIO1					8
+#define JHB100_PER1RST_MAIN_RSTN_EMMC0					9
+#define JHB100_PER1RST_MAIN_RSTN_UFS					10
+#define JHB100_PER1RST_MAIN_RSTN_UFS_PHY				11
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SFC0				12
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SFC1				13
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SFC2				14
+#define JHB100_PER1RST_MAIN_RSTN_DMAC_SPI0				15
+#define JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS				16
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1

