Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72C4D9F6A;
	Wed, 30 Sep 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772254; cv=fail; b=RdRCtAX0GS7FmCttpDesHxtBqqNGPJr+ZfseCcLOhsOw9DtsspT+9w2pdFajP4HqChUDeL7/MB12lqZLwPJqK4fSdDx+lcfzUnjRUG94IhtATfEzr3fRExijH11+kGGc2LWkKD9YlgqGP58utB7Jy4dHeNIz0diFt1ByAcIxY7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772254; c=relaxed/simple;
	bh=FnpZyhSTNizv3ijuv7V+JgxkjxqZFcBOsGz1ZiyAB5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SYWKitfZLEeA7EGSVr1FsLvbMvCuzkuHadwtJMKbTeEJ29HOsjwHRSEPO1+Lu4WmIqmPCeaWCZxXgsS+bWbRygJidPej24/8SanMZyo+AfnF+kEZRGUHMQgakwgBWq5EKWLinlG2AtPv8ySX0HuUMa5WFOJo2vHav8KCbghPQSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e73PX3Gaweyd36AuanabEffpzOByWx4Ww5M7JweZR/qFqWfj5KEzUk3AejMfXFQlV06IwDBD/gl+vzB73uiyhBT/elXAgxP/99e7reG4EsB+hGEe+u6t7ePYf2JES7ye21LTxkZ5Nl09iZ/kA9tY0zx9kQCwCMlLIxeYR/Em4BvfOybi2loV7G/TLxLM+W+RZm3GnBTCO4jnYgU15Zmzz4RwL1C6FGQn9eb/senwHOEHZYA1ur8UJFRAGF8TyyNe17qAd8gZK1ymtRbIvNqexU198J2Px3exWdD9wwC+yHPeJnhuoDSVAGNKOqp5llHgm7jqsD8h3SQH9jK41Zs6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2SF8hRB7UjebffFXAUK3NwhATvW1FuPGyicBJ/Xbh0=;
 b=OeXrVxc14xsQoV9a1Qv/jeauj9DJpKHSsQEmrMso10L9h/YyISefuR+2cDotxe1YQ6PH7HQHoP1p31jXUaBJ8abtnmJOqfCeCIl8p174wfR70BiJCf4PxQK7h4fR1ow0gA00n6hVqI6xO5uV6Ab83mQoeaI6kQSNxRGH4LeZZ+pQk9CaJkte+53f9frKcIBxgGTxpzCbgJRif7Bb8/BLmp05wne8ZlRwTuIWg6uU5c3+h1QLxoherEXKYBPCDctGwc1wa24oxXjEnClah70DBcJhVdkCKDwpICWeidmqq59xpdzfFUU1v1EuT0BrIK7aGEgR43fEAyZQR1oH6ltc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:48 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:48 +0000
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
Subject: [PATCH v5 09/23] dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset generator
Date: Wed, 30 Sep 2026 05:43:03 -0700
Message-Id: <20260930124317.5648-10-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4e569f3b-0f14-447b-babe-08df1ef0793d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	6PsordUC6YwtV1vxSMHFnmNIIjC70VsR2txozO+UG00rPlgVGtNNJyGXjssL/zwWsJysqJOKmqg3uPGcWtx12swxiBHYuE/cpum/71lreu0mQYsuQE3RxcFWMkN4wYJ5sQwrApWRBKubWqzbBxVeLE71HxnUjLuaip8xmK4PBbwnVzbVNLzkrMLsGn/xxAOktGUsSXa+NUcIjPN4ohOK1aEUEFjygs2KRXrPRXiSyLiHCjqEP6/7IUikpm2zhrexGTv9z/bvs9AOKo/GzAuqL8GQfUqwPquoau9+8d+vM5GxKB6tDVKNskUEZvVAj8AY+Wc+lHk3IFHTyCuOIqa+51BHmhgbLW5F1cWVfigGkwKfXqEvtLaKqBPXuxH0HULF6I8aLFIs3mpCFp2Cfp1SOAQ9zymFEbvG3aaL2J9QukbgD67V6Bd/tRYKuieVYtV5c7K0MvNWe0zvEO4FKZn11+CUHBopCh6N1J/gy/s/nr74VFQ/9hoTaVw5dWJPHt5vTSn6pK1hTWNK24Vsvzp5h7gQd/j/bnbext5HFyC/sxzHMVckMXDmlbx+T2WjH4d/DYg5OxCQmHB/cxt1s2HiuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?90uQUnI73oIb7rqox6yVMy+Lv7qajT7/lqj0FI2H0/cT+QuM18WtyjEHVa78?=
 =?us-ascii?Q?oyuHHfHS/xkXdYxnb697QQ7PaoLA0PkJFYmWBfo76bvcfHcL1lJLWhBXYm/U?=
 =?us-ascii?Q?EiKRi4E+FD6VeMPGW6M23KYPfe4IHEF16Ie0NJkU5F+gGOT4yquVFr5X+R/w?=
 =?us-ascii?Q?uny2Iv0ZPy0KXircwmQBVJ7Kh/dJmEX3QB5DoGyataG/7SAxeflWxoK+v1Wv?=
 =?us-ascii?Q?97N8REbZyw7bnS7XDw+05bJ7L2CYnt7l6zB8aaIv6XgiZmm4j3hVSti5XNTU?=
 =?us-ascii?Q?X0Ys7cIB6VWJTYkBKLyF5WnJZxkRVzmwRdOaW/qIQrTKRZm6GDuaafqTQRXF?=
 =?us-ascii?Q?W/noiqV2DYryBnBMJkYVw9PSuNPrYbmNtn7qvJa4qj3kDc4Y6S//b9R+ZGCh?=
 =?us-ascii?Q?NkcpUPpRPX165eYTI+0bf5dYDntQEnwaJplGIMHQsllygYMsDU+F1O1HmqHy?=
 =?us-ascii?Q?UT5t7G3LlLOI5XMB0hUQCBt6croATLjvDqQGtG9fun7huHbhb25Pfig5IsYX?=
 =?us-ascii?Q?qdDNgk8F/6h/PFS6rZ7EO+TF1wlef5yCxLB+0+1SVzXtjHFz9hoa5NWMVVCz?=
 =?us-ascii?Q?bfStQUd1djXZHlr75fCarOc/Vj9Q2YkJl55svoeXKoF/G1+gtswxTCVYl73L?=
 =?us-ascii?Q?pweDPTmno31r693M5+ZafwjsZ/5vbuhmwq4IH+yppCvHbcXFybDo6CFraw+J?=
 =?us-ascii?Q?dQXZi6MksqbQkJ0TAYlFj9jYz5ZvuFhbnzaKRRNCZNPpGP3Eycg1L/l5YBE+?=
 =?us-ascii?Q?bRkueCBoqCU6U6xWnBDCRQNauZDZNp9IdEB8OdmRwh562n+GZgBAC657wE7r?=
 =?us-ascii?Q?qRln/ER4Y65B1FaZO7Po3JCwxXj8mWg20280aB6mXbPGrQq3qdW8XCX3c4qi?=
 =?us-ascii?Q?P33cRoUC+1YLRAgMlKR2GGAHXdVlBIH6ZGqAohLxf1GgKw7o5MUVZc+0ihPV?=
 =?us-ascii?Q?f/oh0zG+Cl1iDWrwMU/ifGSftorV6ufnsq/wBTHUVB8PUFVAbGXmecxSEV1P?=
 =?us-ascii?Q?1SDd/ZvR7NYdOdXJIo2ywhWrdWtdBn1pxAvFKJHefsp7OsNl3ezQw+zIXiSy?=
 =?us-ascii?Q?XBPDfY7ooRhWqwcfyoGECCvDK0Og9LlFtcJGC4FkV8lPn3AbM8+Q8wz2QAI5?=
 =?us-ascii?Q?QtlJNQpELFai4ZZsyfgC+Z2H0Vh+ySUteXGU9nuATyscTrgo47gO8ImFAd9Q?=
 =?us-ascii?Q?4+GlF/6SJoj/hg2UF/6NzkoeUIitJDztLs+M6XPTV7P7Z31o6+Z6z9iA7AK6?=
 =?us-ascii?Q?NBnreJjRljpQcVJmJTlTUCXvJP3JKyZc+yvEeH/zeWPnzl8vsQLywJI/jN+A?=
 =?us-ascii?Q?YYbe9GHLkqUeSZwUPZOuIm2kDpqOHXgqKf8Aw97fkAS+nDm03VfzmuGB8dTN?=
 =?us-ascii?Q?sO8BriN7D47SBrOzvcUMHX0a27vZs7/Mf7gibDLPfTIuzZB0lMtdhM72+qwC?=
 =?us-ascii?Q?mo7puh8uFjvpkCtB3RbeXgcJtwuMq3f9zgjYBXo8ICBQkSjSaPKoFcEFXxAb?=
 =?us-ascii?Q?IQMJyyE37ezkCBPAEHsA9wz0ief04O+KJ7xlw8VlSQZg7ZivicLyD3fUlcIR?=
 =?us-ascii?Q?Lmcw6kLpEnAjcQKQAwZKRXlV+pyVWeq272I010ceUkmpTwaWtKXhmXoAtyCt?=
 =?us-ascii?Q?eET/rudvTp3GZtCyxUY06hlyaz+NDZvkLVdNypO/MceDErMu3i2V9VsaCows?=
 =?us-ascii?Q?jfFBgD2s3LTi0778nZPhmzXe3/KooAWBFCDkxdplT+heJUZZ7n2pSYG/fZu9?=
 =?us-ascii?Q?h561IMwJ/XZFsnMmoe/IOKsug8hycyh5bFzfoH1e1RtpGxcB8w2f?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e569f3b-0f14-447b-babe-08df1ef0793d
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:48.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmHwajQIDD7j7t7+fJDyOiKlo5Xqm+V8nGfV+rCullr0ehlQq2pHH58OBFyjVWuQd3v5NPknJqd39J0QqZfvJJzG9qyANNH8HyeOkPJM6NMOz++kmhNQQry5qCvyLqJp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

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

