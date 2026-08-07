Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0547252A;
	Fri,  7 Aug 2026 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102281; cv=fail; b=uS1Vt/kCLanIxwzgCh3vY2chp3rDPvVVqWwXFT3pDBAg/gs1XdHz/fcEb7KVzVVtjpSGdlj77VbIqdwUn5tcxQVcvUijvaY35fsazX222l32mjc8SOnbbmWwz0581JPdYitdr2L6YRokpfcSApSArNi8zXrO3hoEBola7lRjh6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102281; c=relaxed/simple;
	bh=FnpZyhSTNizv3ijuv7V+JgxkjxqZFcBOsGz1ZiyAB5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUjC4SttQDVu1m+i7FnTtFpeJCm8Y0GU2YdkQx0iBY8vALLwlvqRU6L24g83sgDWQ9gWBdi+cXBaArDV/Fr7g+9bOx44k2B3/0l3IPRd0HWe5SCFZhGDCR3k6nBAH/VSxpEPBhlA5dXAYQzQEr0kIRgKqLY4j43D0a/cXLcKEAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntqkS0ku5o+TmnEZfdb0BE3Gh3oYSp6evuuq6h7DDLM1Fl7jzf3njIa1x2thMx8TYi9OYv4Nx36iYcT8BK0WDWFYG4cGDN+1Shtm9vi3bmrAH2fItX9eGb1h+TkHSDI6p49LxRX0f7ssckK4kSvi+CSz6Lzy+izqIqTCN0AC76hrFMUge9XVy+vQXtSSaT4JP52Zp3CW4pYBrGndgTHo+y78sJaBAyYdEJBRw+RfMjQK6ykbrABW3biLYwG5tM+G0u01AhCpc8s0IXgnPeTNkkXYgND+vCW+BXFkTKPaHR73Gqsytc2DJsLMD1BFD7mGBs+Kp4+Z1ekikXRxyehtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2SF8hRB7UjebffFXAUK3NwhATvW1FuPGyicBJ/Xbh0=;
 b=UoO785PoA0IOpGsgPYXHxqJhhYrFJuBQ9HCHUwcJ9htdEM45JZMmVbNANJz8cH5ChsZlelSMZ+znXjjAvGSTqsrIfeGc59KYSaikmfxH61X9fC4BciIHVA9LSoIOiczCcxoj5hCiPtER7iYoTbSHppHNYSjzX2zvNzqQsUzTmisMgDpXsfFSHG2EMpL8FpEv0y2Uo1RH7CV7lWa996vIH+bxFOyLQyVaFXNmBZc5mnN20e6OwCyN9pl9YHl9BKnE09XKE6qx2HBjW27X0l6qBM//gWcK6DkvzZyhv5q8Eei1L3aP6/cr4VHRt9LKsAwCTRkKWWR5/yxfOMrU2nDUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:46 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:46 +0000
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
Subject: [PATCH v3 09/22] dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset generator
Date: Fri,  7 Aug 2026 04:29:10 -0700
Message-Id: <20260807112923.191627-10-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 450db3c0-5f27-481f-6c05-08def4772f5b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q/mrFL4L98Hwu8a0Ttic47ZABXItFXQal4TlLKrHN1z8fQLIt+Uj93fSVIGjxxIs44q0tJDJs/Hr+j5yfcpo4t22BKRY54lJvXTxj+FeyATt1BEPi4pQe6cgLvct9e2DSWKZA48+0EdBBtFRnkiE1C/oNd8r7JKOqdAzw5cfn8k6YGdlpGblcBiFNADJTvTYtIYB1VIeLNmwxS2yP9bS7f4qAbqBgZETulQ8b2nMxTtu1M9wAbXeutm0/30K4xk1nxl2peTPo12dN1mxb2s3+jAK704f6zDP0OMelHu/XTdK1EaXLCE3eXN0f4XXOlu2NvHVOvH5JIknWGgFOiMgKnH8+B1+EhmjAlTQ572IkEz5zRpb6oYxE8/LxAQ0oyNM3OSDRKBwvW7euWLh0um3wNJhp3DJhcIvMqjmvil06u/Q84O8A2ERvRVOZ9e6HqE0ynLEvDCcg5vs9CejS/Hb46Fz33fVGfjC/04w1hbVYNOD1Cni7hVOsJCUNlTt8tXpDKRi3BR4l1eebjhcf+pWd2FokjelABHqPGiPfEMTxgmc7v4qswMwgx5gj+vJGRzAbJGgjf9AubKKs6AuUJo0QQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OBjx2k9UE2TphLWGnLK6rYZYmhdfNQBAGQtf27zvon/WgfIxxCP3ODsrXc2G?=
 =?us-ascii?Q?+bHMMStxBi+yGwuhGfWXt/0/KSroJ2+ntsoPJEDoO+DpmcWsfjKk9l0kTX4N?=
 =?us-ascii?Q?2NbyzYKoS0L9xET/dh3Wzg+f9NtsNPReHSBqWKN3ycbkW7FxS4JKLRtoAWjw?=
 =?us-ascii?Q?KPHM+DCJ+ZtXbTI3DJdfiBqsixomDGaLB6lWnx4KM7RIY4S2QIf5S7iO60Qi?=
 =?us-ascii?Q?dtRxspPF2/hd/C2NVIT1JDR360XkNWT13QGm5QycPniij3jjdf+CiS6jQnLT?=
 =?us-ascii?Q?jTek0cJu9iytqKvtbS/9hjUOwd77eK2qRgjaeu9a0iJcgF3QgnylpBIACMpn?=
 =?us-ascii?Q?ZuaIqDzcn0AUu6XoLlzvm2fsCB+2DIQLQVnO62h3VHSjGTmDpsz9B8/KVJwJ?=
 =?us-ascii?Q?IQrMaf2B2F1ZtcKjrKqXt0WddTn+YKlizZCGIdhq+yBk48q3F3aabC736C0X?=
 =?us-ascii?Q?koX7DWOYUmnbeaB7FArDgMUDh4Bt/5GjaAtHslX0Aj8NR98yM6gmwnd0DxQv?=
 =?us-ascii?Q?pC9T48i9VF7+Z0frVDiLeR+CE5EyjmjiEyp601gKcLquNKWq7oY6BeJx+Hio?=
 =?us-ascii?Q?GJXAm2xktl4OEzPNLDIICMBU6TLtWSWZvozKJ3bjbez2ELbdeHI0Q+3sRmwt?=
 =?us-ascii?Q?WGimBiqplOka5Wn3bsdtbm/vJ9ymhRmpj3b6OMKIQzWf+gKlVn/nMsHYaz+Z?=
 =?us-ascii?Q?ETSTAKD9C6YipxjHnfYlreRg/s15Kmx4X/rlHUCllCP3bUysHZv/ts+vN4qp?=
 =?us-ascii?Q?LWNs3uKSJJRBN7NqJJrmiFeMADwiW9yilMkjkbBhyJ3r/0/uekxloYpt48E8?=
 =?us-ascii?Q?lV5lZhZnnKZ9+se09XaK+eiKjOTQz0NgAipORw1Sg7T+Ybsk1poRopAUlO13?=
 =?us-ascii?Q?xG2HdiNRG2XrUYTCjGO0hR3SJ9xXLifKotvqWsrxHU+Fu4bxpa3pz5n/NMOy?=
 =?us-ascii?Q?U2YI9cq5JmsIjHWDsFrbso3hv25UYERulexNhArDV5TZoD78ITB4DOk//2BN?=
 =?us-ascii?Q?jv3TOgco8h8ROxIUT5ziJpN1rzupMrO45Q2YxAgDkF21zQ7UdKKescrB9RA7?=
 =?us-ascii?Q?z24xcThKll22Qlf337ZGNVmF6padL1p21ylcOXjPbpKhJop6ZrAEVcJWH4CF?=
 =?us-ascii?Q?CTmzyDcNiDZnUSHjhw6Fad9tR3gKwoXlil/osV4y2mfjv36cU4bCtMwFag7O?=
 =?us-ascii?Q?HeC37YnYjNibE0WBVQrJgM7XCOcJH2eBVE9xkxT6PN9hT1n7YbkGAK6CgB1d?=
 =?us-ascii?Q?AmBhcBnLDjr4W/UwR+krXFi9QfabwxxYMs55T+KzPTJ354Kjxge77Jt80EGg?=
 =?us-ascii?Q?27GHESfh013Qs37sekN8rsfCN9zMuk2spH/3AFK0D13GfZ9UmWPKdCvFttCO?=
 =?us-ascii?Q?eU+c1n5hKYDQx4WhpY+Zk3c2xwkR/U1IKQErW9LQoZvb9Lylfz0vYHAwifRs?=
 =?us-ascii?Q?lqjKvdzcwmqhOw8ijx2C0xJ1qna9L9lrSmSZBUa97k6yz3i1+WSbZZJd0e8y?=
 =?us-ascii?Q?G12naECzS+jGnGHie+T7nwH2zaFOnLstC2wzfl8S9yYLIWa+eXXj5eE/i7sU?=
 =?us-ascii?Q?n7tC23ZmZX9jcpwHEe6fxKHIDpfkSuBJtZ1P+9nISPe8EjbYxLEsBgbdJf+k?=
 =?us-ascii?Q?ZRJ/9CCgCLUnuuL4YL3WZLRnU8H2bdyZby1KytW1/3Kl0x5ayA5HubbjD9Qf?=
 =?us-ascii?Q?yXDFpJcjjXLv4aUa+oSE4GO96jFTDZ9bHDbPrpvK+CCuUcSadBOkuyo5KBqy?=
 =?us-ascii?Q?PiDfPqH6CWOd6g3rwp7G7QfB4+51OfMj3Nw51thE43Jmpax9LKqq?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450db3c0-5f27-481f-6c05-08def4772f5b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:46.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTF4tUFK5Fu8yJAHM3LAmtOB+bTUng0rhoz9x5SNPRsRv/r7L8XJAR3gkQIAV/1luMilK4V87+is+SdXM/7loP42UZI6ipqYnFdEXozVdj9JTtwB5LLSW7N17E6cYs8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

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

