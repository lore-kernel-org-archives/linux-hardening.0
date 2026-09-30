Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303194848AB;
	Wed, 30 Sep 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772244; cv=fail; b=nKuB+V+BGSGVvLUrL52weFjfdj1LFqA8k85A48NhHumA9c0MsBpj+t2Nt8V/RocjUwSES3Y3rqYjh2wGkQzDIXbHBF4Voucxhs8ZuaaxlbcTf9lByRpJk6nKtw0UWqyuZxU5TaepSS9P3Uhkp6/xTbUmKK9F7Az4TrGWtDmjzbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772244; c=relaxed/simple;
	bh=rQ5Sq5Is/mzbEmQXis/a2oli2zE8PaEaO0VhyRr0QeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VVgaeszzW4twqLRDhGJlAkk2fTFlcSuk/xtk+FW+kw/deh5CKat1AFkGUQdeqaILu1lqgocgHNODXbUXFL8aYFKkHmiS1KTvgD+4uSwo4xgf1seahwLKOa3Ijl8MSFjJc91r5nrKkL98n6X7pOgZwadIwswuBi22GYXAkD9l94o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLG5ElVZsnSfslulzQ2rzvMkhpOeTbcguPWIgR1jNs3Zd8H5Wm2ZDSNRj/gRk4W1iRrs+Ns9YzhVKTk0jRBHOZf3sHaF0K9YYVK1Q+oGNrIckYc/4VIfRMpB7TN2KKp18uXlfk3PDeKTv6RNQV0bUbqgiUcNW0LKXjQrI0I3mXYww58II3xgAlbxcYkNb66YbkTo0dmdHN3vJtWsHa/wwUIwvurB6b1IOPfohF4fGzRQ3Y6tPFIDW420sm/hJMje8pr5NyZ05XAdkYN8WelIFp4qv12rL5wKIwpTQpPSvIAKciSRuZnkCk6WMFZZp0hY9yfBVeXj99rmq2GTOXiUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9T0J9WhskpZHjY/7iPIX7WGPYv4AGoFCgPNp3THz2U=;
 b=oZCQSgzQ0QdFzQqExSlcWr32gSNRN1YJo7HtGAedaMfEFWJTbfHWtdyUCAGKyKXgzrRKC70zS5bI8LcavVI33Xn5Ya5tdeUu8xANHNARNrFcHUBmij54UGe40TjuQEo7RrXc83aSr4RZC9zoJXbhkexZ7syJo2QaZhs7NhFwbwpZQEKZVPysp6DEN9LWtzLKQHKVAgkCUakQSNjgFy56sUb4hvz07RuE5QLFgXsKK6N8LtHbdK2Oj4/ckmiOzUofshMmwsQBs4a1fnHLcbyUOJgI7DHFsmnVWOh0Jk0RzEeT4uxvdj+bK46+h+qdn/VwaCp3et7nN3UP2B7F7XfZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:45 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:45 +0000
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
Subject: [PATCH v5 07/23] dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset generator
Date: Wed, 30 Sep 2026 05:43:01 -0700
Message-Id: <20260930124317.5648-8-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79916c87-b9e8-4c69-60d9-08df1ef0773f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	+7k+xLK+0+geV8/sCydRHRKX5tfB/TwG3Bm4X6+Slk6WOE9pmEjEvsVaO3ucsQNx9QTPDPTEANL79O+wouUAW68w0jbF236EcZGnT8v2mncDRuGmp8onk41g7iEZ0SylvI5hGcJjpEShO4OrT67wxwJj/guqZA3skmRujma3szXieIH/rQDkpUS8W6qkKua7+lDWHemkP4Fyz/8cADwo1+RI5pAnO84Ws02C4d7i9q2+XTXuNwG7BCuomkZrwoODbAptoo4XtQ6kJ3aagF/QxZwZG486BSzjz2wloWVr4u3VNNEUsGIHSKBCaxbqXnmlqpPmCDQ+3DRn71NKjOj0h7OlRAFnj3lt7475dtmmBxjlWIH+HAsKhWVxmC2rutobu//zSHEQqQxEO2mUDD8HxmiI9WMfHQPlj31d9C3Y6fwmIt8eLQmB39SILAGS7Gzz7U3VxWIDBmJiPlJ5prCEqqOMyJw+espRjovaawao/qnJ4czEF9o+1eJuYZYiYFDG/y9gYAElFPcemAJKrk2MyN19NmLgftP/ctLTnh3F/Se5aQQmRVYZ9ZsYssOL3CuJsht6m0Ku/GuwjbLgLlZSYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SJefs9IM7JtH7kOXaon4X+TQEsAjDeR0VpsgJV8/2RMJco4Zj2YyT7XATALu?=
 =?us-ascii?Q?ScVob8pqd66ALelrxJd6QX1dCtLutwXNjZRCL2NFBryUbn6gxl3Cm0DIlSc3?=
 =?us-ascii?Q?Jv7L+TfrLdB/rYgTlnsO3Rn3tnDfe2CPrWzbnLNxVIfDAcqm0JkZJv7lu5dm?=
 =?us-ascii?Q?M0Rdq9ZfozrYSDBCP2RCwjNf2lZjkM+4T7uYbx9mSpzE8qhJ4ZFo62FbvOPu?=
 =?us-ascii?Q?3AoEoPc+lf5VbSBm+4T6PLHLGyqJCI0piiB1Uue/H5/kkaIP8pS13DX05URw?=
 =?us-ascii?Q?S6zmRtVUbYW4TLChhbH41+MT+FuFUQqZmCkGSEZta0EOeSy38sm5iVj1nZae?=
 =?us-ascii?Q?W0/1GgpXWaRp4EiJC46u12RlfqPb7dzenxEuvMhHFKw5wCCxm194qUx2FQy/?=
 =?us-ascii?Q?/UQVqcg04y9G7ieYEJgFto+lo47xIN+sAFJyh6ifn7zfhfVgoYl50ZubKslu?=
 =?us-ascii?Q?lPHgsKvfNjIZA/yoTm46EhLn0nJ0+1RWEWmkR0poEhf/VmRQ3Q0zyw+NB1Vq?=
 =?us-ascii?Q?+1BbbX9S489oEIPrp+EZI6oXg25vAQMzad+v/ZQx9+ZQqkNhgxcDKH/Suth8?=
 =?us-ascii?Q?gbAF33clLUbPzDFSBP/yHmTQTe8yykrHCmtvsbVQY8HWG0zIxPPhvaRBd5Rt?=
 =?us-ascii?Q?XmEbJt5BMhUyXOnNM65PdTYV9OPC49JAMVzTnQYl8DtNBqDJhe/NWdEKRwm9?=
 =?us-ascii?Q?lREo/zvwoLs2JkHS+y6BAVE+CN76hb+gzsvnSUzl3nN/+q8492IeAvC8BRD8?=
 =?us-ascii?Q?p6JeWuNoQX2qEIZNHV1RoDyP90rk0QRSvWMJhm2arVMlZfr7I/xRoEFoenwk?=
 =?us-ascii?Q?6SeNp5lspynoIwcx8skAiz12I635d2TVXT152c8ZsccyT/A+dAlTolFfrbYb?=
 =?us-ascii?Q?QbPHrA/7menSqgNpOYUQCVmc4XDZ6k5p7YkIzba6nIvgXph/usffBlYvt55+?=
 =?us-ascii?Q?nVinf6K5+XnySy5uQXarsyrkVkExidkJriZ2u+H4DrUFdJxUQeF+EFBDl9DB?=
 =?us-ascii?Q?fkMVu9lvzuFEY5Otv8nG2eQK5enQLZX2KGSB4Y4OhzRfOalT0zzeHGHJj/dC?=
 =?us-ascii?Q?ztFf55GpwEaKvxAWSS/83npWu7sRYwR0o8aDPpfpuVkD0+/fJd+OIZupbeSN?=
 =?us-ascii?Q?XMpIhm4XDxns9XcdVe2S3TpORyYeM0dw/QKwNeGPecXVz3kCOQo3KFQDu1XG?=
 =?us-ascii?Q?lqxW98KLiBPOG/U7Wx3C4rH9nfuF/pDjXOgQi1gykLSXrKq8aLWEINh0ZEcJ?=
 =?us-ascii?Q?jME13TEjeZwUzFtAxMtZvBqsZhaI1nPMtBUPS4B4UELQvNGzC7XpPRLHDqC+?=
 =?us-ascii?Q?f7n592Vdh81F8zGBKSAw4u+6Z34lk0A1n+j1mWvWheUpFJoWDL+s6gr3owOi?=
 =?us-ascii?Q?nfiknNL/57FjRBPz6trQ/XVBOsMPQirhHHw4XxoGSEeLQQaE6fWhVH8yiHO3?=
 =?us-ascii?Q?ozdvq1buNz8kWv9dH+SNXr/Puu1gWF9vfCu9zJDyS3Hn/TKEz45Qvbd8cb3v?=
 =?us-ascii?Q?0b77fcP4Qf9es/uCz5oG9k/+U/g61unJyy2O/N+0gbLjFB4T4InRgJlTGGT4?=
 =?us-ascii?Q?sKvK/rcmyxbC0++g+Dhr4Xv0SOzVuIocZSvFDG6QwywWVKkjPYj6LUqUSaJn?=
 =?us-ascii?Q?TXvcJhEMGVk5yKbD2IC2iu2k7FqWSWx5imisd0fwId7bQEuxZt8N43QvUt/L?=
 =?us-ascii?Q?9dsaZJ5vVUYOoZiRJ4o9PPNgWduUUZnzuGmQ42ZKD4T17XdV2T/9wTnogJRK?=
 =?us-ascii?Q?pnes51msuC04HkMUeP+ucaj/OqMM8JP7bacuQYFkbUISz3saUxJk?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79916c87-b9e8-4c69-60d9-08df1ef0773f
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:45.3059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQgQ5VhMxqkBDlADBpaTeFixr4uKUj1pr9hmY72oN11I9/7th85x76tTXQcPHd+lEM1fKiLvRsPFoZjIv2GlV5UqKW1tczHj5h9mVfhCl8ZAbJdC93rScG1tDOhVSQF1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

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

