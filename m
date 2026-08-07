Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FFE471CE7;
	Fri,  7 Aug 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102267; cv=fail; b=Xo82rc4uRsUEK0c/QnxuYNGdZvlDEi0OQs5+20FLPgZElz64Iq2zNeoygm6YYeTSz1Q1et2odLMgU8+SXLvNKlSEANl+I79fdNc/+cU3jOOWzL2V1mvkLTeROYbgDpRd7/A3g6Enpw9kit8QO+UIjipy7TxFSBxspA7pMvK9tns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102267; c=relaxed/simple;
	bh=RkZv9gxLKvhijrUjutuw/7sxrPWQJne7DE21NePKZbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3CSiFwaMlPUDiQt4CIzCDVjASB55yftF7BmdnAMmYr8LTO9dnFt7qMcYLPqSYgvKUNh7D0BZsxb3xQLB9l1vyuelKrP9mP2RXR7FFayPv9tD2Y3JTR5+8qQ9oRlS+VNbGARd0Ihcnj3R4ZcMe/PEhChRefPntRHVRtTkbraC4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K67NsRgp7tr3+8hp97I4GPYpERitTCzwPHN6e1P3FraZTLVNlJhIBM8jP0PoJycM7icKordjBMF84GsliYe3iwN+DjT7DZ2Nb7sJLasW05qlk4uJnnJODaXaWnuivl2ZO50cPV+bFvzcuYSdvKneLtOju1i/vm9gH79L7HdLO06gGg2q5xCpaiPNWbNxX2DVkf1mlKrom2Dd/k+FGQJmnZ8qRxuyDo3exu16bScMTnod/YQolXdTJ4JOrX+RS/zKhqKF0kG7u3pDu52Kucf1iyBwITWWK89UkcCbCNvlPFjY7nzs/fL+MHA5H7q6Tm1v2mcPr1m+sD+8nfk56RinfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MPFYihWFS/sItDsyLBsAXZ0TNHpIA0HhEGZpIuQ/QI=;
 b=ithUUCD/xkNmciMPJGB4wKp6PkFqpb57cMUriaki06yLDhLU9o0yWDef7N1EoKEgGsbXleiIjGj7eJ6Ww5dtknGtgIHt58R0iXC/zP2wmuQCe8+DZl2wMD43WCTgMnGN2cdA87H8mxqPXL8IqBSIjOmKMAq8w0/VW/81khx7RA8NIO4MfBtIC2jM+iR9K6+bwlSYIfQ8WDDZXEw4uN213bXSLA6UVKXzXqZD/likPTMKP89XHZuhIAsGpnJKij4Hkqr2O17R7hX1zT70b1aNKJloXjE+DUhnKRh4pjeKpSsPGRT2SgqmC6mlg4LrJL1uWD91gPazab+ccOWBQCR1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:50 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:50 +0000
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
Subject: [PATCH v3 11/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset generator
Date: Fri,  7 Aug 2026 04:29:12 -0700
Message-Id: <20260807112923.191627-12-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: a4dcb822-46ef-44a7-fcf6-08def4773141
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jp37zGq9OxlbqaWELQxdW3cAmdAL1Jt7hPYDbDhui8YJ+lkEe+hNp7W+KZvJe0QdihvGPxiSy8Akgxa2mIrb2EmYuJQHXRBSAGparGB48TsKxrsfpGDJ3QDGUcR3hlyNfVnAoZDaDObQKfo1dEdWhga8LUc2u1iKRqoNTD1hvLAuRuRw4MDbZTVaKa9KFiX7W3PHXvZjbLsVRCGI4WeGzS+MVTc79vAQxUDQgNDD6IPEa6RB0Vu65yJCRxKVnSwScGkw0vpEF8srlY0MTmDpuSDAujck2Gls7XrDunvA41QPMoDPClOYu8XyfUipOoU/ZcoZmCm/Z7c4bdaSseVzfJR8vV2sf+bBvxnWya+ZEWSKe5/gW4scIZgYUyWnSSX/bnscE0cI21WXgvwXDxuF6DAlFyExzWnFiVpRS4ikahxJ2uSFZX1W9pgwd1/sVC4/6V7QO9klCNWeQtRfcnUY8EMyiX/BN12TLqQRwS+vFea2JCWVuWYMFr/Eb3pEMDTfK78/C1/byQSOQ5ZU7P7QLU1oPoNTzWoRzur96j9uxIuOILW4UK6uUZQLcRkrXVPXppP24V/lFXTd89F175vPWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZiE/XgPjk+WJMePjIPOOtYHaJ3gbDQ3QAf85yZhyX8PPx8HMaavAo8ANSKMM?=
 =?us-ascii?Q?hmiOoQ1zc6YF5yDDJDc3ZgWjwttHHSz7XfDmVnqbowOS5/swus38oPB44CLH?=
 =?us-ascii?Q?+1TT0OU7QWrwNmq9LecQU5Gvj65Z/VG6UkuKb46QPkfcOtzMKRYf/nFatMK8?=
 =?us-ascii?Q?xWEr6lkp9oCrPLFnFrKpZC4gO4buojn5JoFNkJFT/f19bRLP553PXrHznncL?=
 =?us-ascii?Q?NTcPnrwi5FUKJ2wE7szvF8O2oRjwEAytMxg5BYHc9BkMRp5vOjUW/7jUUf01?=
 =?us-ascii?Q?75021T/m+AWrD9c84RwI6o10m+Wt1txEKJzfGK65l+DJqZ7fmg2kyQddU/77?=
 =?us-ascii?Q?n7l7aOaURJVsyw2FPfbWJdbdwuRjviWD5gI+uoPzBUZBwwzwOPCBtEZyaTs2?=
 =?us-ascii?Q?qMBefBv8KaTySbKXHiv0r793NLVVhz6ojhidg1dvJa60rGEOBmGYsAdCgNRA?=
 =?us-ascii?Q?oOSshJBa6x8pcaavpLd3Eol2w3QpmWRare1HRkQO7DIYxm3NqwVDNqt6pDh9?=
 =?us-ascii?Q?UjGmE8/4YoW3ETIq8p3AbbJqNSDcGrOJKdHoQ3dOcrnvLzTG6F6PmvEcsrSR?=
 =?us-ascii?Q?07Y87114c/6rw/DGCrDEHEVhdiYddozRs3rNdeT4sNkOeSbZ2h14FOaYAef9?=
 =?us-ascii?Q?UrxN7CpJ+SllbaQUMdlK2b47p867JIB+6f2+xCgzQ0bHe2r3QJcZjDzuYR8Z?=
 =?us-ascii?Q?iOFV4bdaSftvt4SMEiqXN9bQJRK31YhRYmoGcEFdXWwsevZ3sW7zVevun6gk?=
 =?us-ascii?Q?ebb/KZu61o8e8Sx9HCXCyDyu8G4aDKASCDwDH0dvJjWbVbWvO1hlCJMJAFhe?=
 =?us-ascii?Q?9ME7+156pSuJEurCr7Aj6Sb7szygt78v5NDFZkHAv9LUmSEo7QSI/m8UYkmB?=
 =?us-ascii?Q?sZXtEaZthwOUIBSUF9YXVfaWn7D+lXw0ZauO+XSED6c3YrBvzJE7dxhTHM0B?=
 =?us-ascii?Q?TOIRkps78msIwCAhKY1kUBdkOGM9FVJi/HA3RbXVPekn8WLGIM/1ahl/Wav+?=
 =?us-ascii?Q?GE+nXToZyl5JLSSWv3Hy120zexH8m/oSCxXkmLnQ4OPvhNCsWX1M10vRei5k?=
 =?us-ascii?Q?hc5gFDtBPPB/qDyN+cyUa/kD96VUxUZcSHNoRZZn/fn9d+sRsmcxswR7EihE?=
 =?us-ascii?Q?qRyK+jOZqNdosX7nPyDXXhQuH49ydQ2iGaElgnBFp1KLFmfqQVUURTW/Sozh?=
 =?us-ascii?Q?8idOe+I1VlvTnoTT+M0YNZd3AEcj9bSSxzQN8vIbRshKkX5B0rpR33JiuV75?=
 =?us-ascii?Q?3I3GcmWQuAfhFIpIkawQ4P/9gxVLwOZiv/pfYrb+1GLt/TJGBY+H3eBgqAxG?=
 =?us-ascii?Q?o5tbCRvbRlG0c9L6j6/n07tXgpO+rdeOE3bjP/uCjoEHSkOSyhmEQgR67f2B?=
 =?us-ascii?Q?vKWbbkv11BwxV7Ks6x+lcXtD9St64T8htq4ZVMTMqmkLx7z8w8WrSXf/QMB5?=
 =?us-ascii?Q?c5TBLTqnq6vyOJRf/UkIyqbqAMjlw1Kso9Q3GZh7U5LlJYEOOwaTXlGcU2bs?=
 =?us-ascii?Q?ABa0UfmumdI2/A5FRW9TaGlQSccCJu0CbZ8x7RuE7um1AoxUxtT3XwYWm5Qa?=
 =?us-ascii?Q?U3i0CVik045N+5qP1JvVrTg6FTF9TqDBZwZUbJf/13F5hT79cJEKEjyLRG6D?=
 =?us-ascii?Q?kJlZ9hPoIlRaF0AX+s+1Dm2lZruLqlQ0sGmYadO7e5ukCzJ7fkzqFD5KoXfj?=
 =?us-ascii?Q?ohqtxtgEc+xKN2BxEtg44fpNKZQBvADC5c3xIXrkQp69i82FrKmznbRFlQWP?=
 =?us-ascii?Q?JH1n2gHyJ0yxrVyd6ZVUG3aiyRBBAPsWzrZSJQQpiEb0MAzC5RTC?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dcb822-46ef-44a7-fcf6-08def4773141
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:49.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1rU2/r8bhJgTkeEjwYkCsaexGfsj9uXZsWjM2IBAsSfzHkVgHikfzKO28r1ApKTEhW90eAUrOncQDmuSE6DaaY0eY7BlNusK4arloSsHRwGztTxrQefzQEAVcZxVOxH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

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

