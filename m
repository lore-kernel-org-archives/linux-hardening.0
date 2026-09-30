Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A034FC326;
	Wed, 30 Sep 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773160; cv=fail; b=uDHtvwUwuK2QM0u6O4nbiEtJDsuEx65fqskCMLHFx8GxSyVI6HYai4M0xTrayBtOC4XOOjeMklpis/37xP7PCyuhrnCg3/vjXCLiw2fue8XsWzecswLXT9DKMk8LGhTvoRjep/L1mgmLCCDWSHtoiR904c1pAIWDuhBkVWX0yfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773160; c=relaxed/simple;
	bh=kx+/yRi1skGoUKdq2tamuo5tICRMS2pFE4LuJmaeUos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9g7FqT1SfgtmFmxe/wTQdomypcC5fufbMoYrRO83N9fq7EKgTjoVvlMmr7gvySPdQkpTMBAZt/RUWfA/0N+/0vRafvGrRo5pI7QdKDrC9Js0Et7j/bJc0DVqHJExhvFbEZf8XYpP+jYE1zk58417N/wt5w/ncJneGPxOF6cQyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5nnv1bKKneHMgcUap7oNwGieoEHemChXt7WCfD7BgDtnZ5iZbbrpkHV5nl9ahTrqjU3n9MLua87DHjyI+gXDADh5c7k7Du7E6JZ/nfBf5ipAelDh+v+RWv65C9ZPR2I1YMXfbZXLdJxRV0jrGnVNLM3cAQsaapA2whNJXxTuHHf+cOwWZhTAor9wivwC5mrRs5rbKD4ufW8VJfovLYzOgBaPI8CV3myAytvCylWDSAOO7g0BSf90N08gfrPbUkAJZjUkLkDDS4b+QN4amjuk1DqcgpYkwq7NqJY6xw8CmWG+qP7kU/MFd3tWqTVsUJ756aMoov1qM+g9HDNdXUlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkGP3+GVo9AOWdSKY8aBZ/0h8Q/E/xBcXYIiscj+7h8=;
 b=ecvBiz2g14hSKr5R/TnQ/W0cJ3UJpRZQlI5bvO48qaQb5ZNWphE8iU50Dx7Jj8Hh0SaQGKJgNhc0Phc9BD5z+cUiauMuPvd7pcHdbGkTA6VnfFNQ9/ekozWB2Wt8wTLlLKHrQ11M7za0YseAu/zMV5rfwDMvw2uZ+rFW84bgou5Y+WD0HVC2eq3ifjK+NZs7yrlPSKYN7HRliD1o/C2mIerkGw4yWEoliLG5zWPiHfhTT07GZEsmFxAdxStUoDLkLM3DxXgo1f1od5XSa8MeSvIGVANtuPNBFltkOLIg+G83wgbmvaUdEktpsWPPbuBrwFxEbiIW1wMZt1A4Kpop6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:59 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:59 +0000
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
Subject: [PATCH v5 15/23] dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset generator
Date: Wed, 30 Sep 2026 05:43:09 -0700
Message-Id: <20260930124317.5648-16-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 89f79ba6-6c06-4bd3-96ac-08df1ef07f67
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	7D31QCMQSVYRR3ae/a6fiqRSwbdJQrmKU1XNI6amdM4jPUfg1/NCnMf6MJvSYX44ka0MBYNS2QHHQ68ogizF9m+Bxt91Fv/Ssuroi7FJRimoQFz+oqRlyUsbqk6WrWYlXMrLelYxoulKsbd6BgruLK8GYC/w83KiJl9v2umZmjAea8KdniZPX/wgH3OgxKSqvMD1AzFm4PSV3yCy3g0jXtXL3AW4db4kH9cb+v089vT1sJuXJXeydX6Xt/4KORbD+vSzWNX6CJoDqkd+NSlQCZVkUQDTroqoOp3zJfTISo8J+ty5MaLvaKg1jgne2YXC80REVgt6x4572NXSUraln/3yY/LvR75glSb8Y4Lc23QG+/HyAo/sNpobCAdQcenYB1MjDNbVD8XJobsRyGGqHd4YO7OxfVKNF7CotUTDptdVmNlL2OHQ+WbuJIFWl2NjMKBLf59NcAyR8e9LrgGrN4JS5M+lVC4tmpBqQQInbJToAMMHvg95G9SGhf0lxRZeKDPWpdMqTDJA6IBk7Yy8qG6gzfL976LtzIiUnaMVDyFn+0MNxU4DyGNCB2EOX61nqRZ3nSCqKB0fPGnbR/m+3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6JpGVB9nl8bjPOmOmUCnBvBkIDlq5+sc3I9VWttIfFp2P46xgc5iAoZ5Fn1E?=
 =?us-ascii?Q?lkCsj8KJNN/wEuCGpzZ736m7CH9kWWjuz1JmHV3D9Yv7l8mmNvhWoIYBCPhQ?=
 =?us-ascii?Q?xgvQ05MwW+t6S3aNbvfbwXfeN7utsIcf1rAnujLODCJOVApt9BVqOLHa7/jm?=
 =?us-ascii?Q?8yG5gwjklRtYz1bitltCwY5qgI5xxva1vEKXKs877cc0l/KiP2ASKc6fJf+O?=
 =?us-ascii?Q?vp/c4lhA4dQn1iyhEWEsUA1pt24V0tckdLE+IIT8KvKjzT+HYo5kZTo0W1iN?=
 =?us-ascii?Q?VxUd9Ks80wZFrha5SmsnRBukhD0zf10n40lTnGESTgIC+eDrJUnogUAiTvTd?=
 =?us-ascii?Q?YZWziNMTa5vasrHsADssKeOZtjlJ9VDEddn+FOxjilVhf84qUM6jFDmOV11u?=
 =?us-ascii?Q?/LnhMEpERqIIf8/U0io8uH1QTQLJNWsVDYV8dtrCTEMzEA4yUbooFZ/fOj2+?=
 =?us-ascii?Q?otDwx0FA1N4CKS1Hw/UTKYYUSNkqtG2C9eAVddHXHNqjPZx6aUg1fMi6Rnk7?=
 =?us-ascii?Q?fpqFnkZAH4Hfvi7QSaNVB+MlgywiL+iDPZGagbM1SNtA7Y+NW8Go7wI6Sq/R?=
 =?us-ascii?Q?YFiK6Cfa1to6AKB9Wc7eO9y4ngekleMmgwucE/jnjgcr9BhWhbfm2dEdlqgA?=
 =?us-ascii?Q?dI7V3Aua/3JQGuRomgPHQt1155LiVvEGUgYStOUf0ur4x2SmFS0jO2RtSu1j?=
 =?us-ascii?Q?oseKCcol+mFspkj6OvbJ+FSbDfr+BtOYLJU38mvrvYXR8R6DdmybJtbAMq5a?=
 =?us-ascii?Q?P2+OFm3N7qOwprrTjNdx2YlgRWIIbvSRyvsJiFo2YiiZorWLIKjNC0qOxR5K?=
 =?us-ascii?Q?0JT61f16vduh+P8WF6uaVoHKLXjcVNAAtaeaqFMoFnLybSUVapV2XBcX8xxJ?=
 =?us-ascii?Q?L6QmK636VFtPx0UYSBMkYnALkaoRM0FzjgUnNnfnrPh2ofjj1h5ByhnLhodg?=
 =?us-ascii?Q?c0wquAuXeujY7kbe6MsdGjbLOJJXnwvvnzAy3m86ueiWqg/uV+Xro4ApDbMZ?=
 =?us-ascii?Q?rHNdXgFWMmkNH9wot8rC5sGclwdWCmNeyliKoJb881faC6diRcNlBPyCPmoo?=
 =?us-ascii?Q?4jDSiBRjM534pNby4+1ntl+sHzihbqK/GE6HlswjaYr9C0Gi5UTC1fC9g16i?=
 =?us-ascii?Q?dpVc85h5nDikWv1YBXXmWX6JRoohCqHe0W+db7gF/PntqEAm67mKBOaLvt1z?=
 =?us-ascii?Q?6mQu2DG0yq//lPOAuGc/BTyRnQKrqorR6UDD8PnrcXnb6y1idVy9zmE+6XTq?=
 =?us-ascii?Q?3EakSgQAtTBokXvL/kEIvSScvmRWfCX5h0u8mbWSrtUmS4s9iBX/+0ZneCNt?=
 =?us-ascii?Q?4mEuK8VTZ5XOQPwcZr6HnGQeJ15gyWLMut9mHRg7kcxDE75zSqK6/NB0+9ip?=
 =?us-ascii?Q?jodGzTGUiPxTllIVkV5wSybsc+wCJ9StBIGUzzqXGECFS5YdKPmH7Frbth2b?=
 =?us-ascii?Q?sf/VjxNyKBoZ7b/QqLSuhvkcZVYCeDGJFPqBYtWf16/BVtwHSn6PgHIW3Lld?=
 =?us-ascii?Q?c41xfir6LMgcZ764uUR+Bu4UFETXn3gYqiBrIp9BY/UUJnvehgAjYqiWuaQB?=
 =?us-ascii?Q?L3Y9If4I/KhrV/dmZNfG/Z3bGDqc6B8+NNcfcoMkQGmftByYu/Wal7DevojF?=
 =?us-ascii?Q?qlWZ8MKRp9+GV3MFpajoJcyRN6TlUIxmMQKGjfSMpFjuukzBgUsNXEXGhIyq?=
 =?us-ascii?Q?1L2AP76MI0Y1nwFMYybGsQzvVO8Au85aT0TXdFGGcMsUx59Zmmw0QGJuwye5?=
 =?us-ascii?Q?aXe6GP2WAE+hE+c7BoVzGJbQy5z1FMfxPLZw3tbtkqRYCSH36Pwf?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f79ba6-6c06-4bd3-96ac-08df1ef07f67
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:58.9806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFMADdtoxUh/DKOFdrgUY5XSNfz5Pu5CoxgDbaTY7BoGaqqqyxfwnuYHH9fokOxZ7PUDuc8hVcC44Qp5vEZYZSlQWP9zsT25hVPDYTbFrOKKjPk6pxY/y165WaMPrV8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

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

