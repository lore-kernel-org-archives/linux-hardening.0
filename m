Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C947012F;
	Fri,  7 Aug 2026 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102226; cv=fail; b=Jdib10Wmc7k/Z83JeKr4xAzvbakag5Wd07RGl8jRl1+EcXQKaxBTIC5Y8evTPdjmIlAkpwwR7tBgNVoXJer99lzJdFxWs9Gron+xBWMezqFMqm/uennJesAjKzeS29ZnjjrR8QwVwImJT1dMb+nYytemUpbUjJu1WLYa2YcclFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102226; c=relaxed/simple;
	bh=Q89W3KrB4E/HFc4Oz16EAc5Qwk2MkeDAI+IHTJiE4Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRVFMCO2TXjlfe6/1YEPGAcSofEi3oA1/SsaSRo1cdOYwOBXj1fcFUDcvvwMmgaG0RIsMhIqldd+MqyyBjoMmxCrq2xIoIduJ/AL+kiy+ylokoEpSgkztDCuyQ807A2HqT5ZPZQ/NFxe+1ORglqc4ukHmuYjaFmWv/Vaz8ERqVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwwXoMC7TuMWm/URmhM+ykKtPsd0KRj7xoZMALmwITfyFNT95Rfvx7VZ/UBCsHF4o/tn8sI1Y8Tl9hOEC5TFbWsH6IiuJOhOL48VfSTlrfHqAHz4xgaR5It3vaBx9vcPlmCbbWkiI4JjbT0oMjwZ6TR2w4q/vN98nCxpDDJok0Q7ls2ZVFOipJkj7hsdBisiMwpYN1Q4cTcV5k5+MsfG2smKj3iFq+bNVutpWkXmD0XXQ7Q6xR8dssBrH1s1H98y0Tag/woybSS1vdEsemjOUtOrD2fbMRHcXRv52Xn/s4Fsz0bP+QsrBwILBE/cv0DwVtHYwmNlyqSvagFWwVfh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QekrJvFzbRGlSrJPqTxk6rC9KdJkrVtXD0+PSHtlGgU=;
 b=WruGA4BFEEGC2zk3zgekEwq0SooSP4tU6VkldgN9Ftd5vjlRSzY29kzULLI4ILTafXDIBCd++ah+VF5OmdIC/JCX6HXpxNg4Agk0PXtqf62ote90nwaPp5v8NyuO2XTXctWHiFKfcEk6VlS4k67Rxo3p8CFmpSJEMQpD1e8BRHdJUEmMyJ/t/lgp82YIGGiO+1RveoeTTAxYHSDmeO/BQL/RzcjIKMmjm+gleS/lPEv7yxErc7nTVCLuMlZJuVx1UkLBCDpj47Q1ZtQH66eXNROUd/1+fULrchZ4lKv/aT9JYkrs1rwyIiI391srcJKh+CP9IJ/G582zBTUY2MQV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1251.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:30:07 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:30:07 +0000
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
Subject: [PATCH v3 22/22] riscv: dts: starfive: jhb100: Add clocks and resets nodes
Date: Fri,  7 Aug 2026 04:29:23 -0700
Message-Id: <20260807112923.191627-23-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1251:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa5b358-aa72-44d0-d795-08def4773bc9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|52116014|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	aqL48kAOn8+9rD1dTStxFbfeqYEH1SEFrGXu5xPJ1jOKANSSsyUL8rAWwxKhdYS5zecT95rym/HfQtVfroMYfzdOAzfJt0B+fHAa8CEHH73Y4G1wyYB8AOSh6kjuOsq3mTCct97Gu2okf2Zl7bIWcjUv2f0QqU35n2mw5UTMAT2JAhJWST/86AEEogXGkBkMV+E3cp8Sa0JxImP+8KqJXvDP1CnKwrAvzc2msIyZvTM3t+WE4+sN0xQflKZOVOn340cR/8TOE78vVFh1Uy+TACT2utegb/w+G3hkRqyVs1OfOgB3Bnd9CbkMbgqC7K7K4zvhjig3ILOv7ffMdGo0+pSpu4Xh3MOnM/jOXoTm2Dxa/eWrO828xz0BAv9pWmamODzjJnsfWiUlcCaWQZGB7IxlWIDofuTEfEgO5EvmJXTuekOYFqZ/r4Ec6uLWRAX9fIkbEQKsLTc1moXg7GdraBG4OibxD77KUWaCP0I3jW15AjWRcUfdnZK2TzTTUdUoH1C+stvq6ZWTua2tZ7RrJAkNdQDn3s6HG5IXCcTNE6eImmHx5T9IwUA2JKzs+/vCmB8VWG+RABWu96SltjDgvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(52116014)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h0fVJAPyHL3IK7WlN/f4DDrQzfsGDeIyoL0zs8kaEc24pVTsU6b5hA3Hvj/z?=
 =?us-ascii?Q?F0Nl0XErPHZ/x6I9Tf8D23JbursXKdKKMVClSMhu3MdFz69KJ+5O2ebinT0C?=
 =?us-ascii?Q?5ib/ULSOm4C1aqTm7JGZtZtBNGmhmUG4OFpaIp6MGWe+px5Qw/m/vfrSeCj1?=
 =?us-ascii?Q?tP3TmcsyQ/juUHdktrcD4Yr4OdMmanCgMw0pMabeD84wh+ZU8qu/fh6QbmU8?=
 =?us-ascii?Q?VHt9LkRSfreanK8uQalNInH/t2En7OU6wh8+NetR/JzFnIljeEXcfg7Zj4qo?=
 =?us-ascii?Q?l9JOkduZTuOKnMWg95dmwXw5DIJ8LtdwLm2JYJtUglKshrMPesDvMPIU0S+p?=
 =?us-ascii?Q?fxRRS6TytNUM5OkwN2jpmUfWUokSCnL9s7WR7AmZVp4Q1HaONCgCtXThEaO4?=
 =?us-ascii?Q?3xLoSkNI8t4RyJtwr/PpANUKteZppwpDIwN19zgeYU9UnZg0Z+ZFMiqVLyqd?=
 =?us-ascii?Q?RXbvM/euJcg27q87GoFeHJ2W7Sggs7HDO5HUcKRL3kFKkgBqQ8PGi3srXcM9?=
 =?us-ascii?Q?piXdycjw3/gThYgjpznC6T+/E6FdUiIGUCrjolIK8q4R6SpCewYQBFwas2/Z?=
 =?us-ascii?Q?PI+XpNIX7LNzIN47gDipohElbkeQOMI5UYF9wtEVVVJCwwVonzjfSudJ9VDB?=
 =?us-ascii?Q?KlmW8fIEx3RXE6GYv2zeRb9t88lWm29hHCLWigzFbNha5r2CZ/gX5O18KJIY?=
 =?us-ascii?Q?AKHZBYtCati5fPBMyJvYQJ6lHzjgygste6UhfLeDoEZXwTn41v1fWy+FVZ+w?=
 =?us-ascii?Q?0ZcYFWvIt7N3tTMPqYRTp+ZekQvb7WGkJEs5puSGAlAJ4s8ROCJlH+aLOohu?=
 =?us-ascii?Q?IYlElKhokiuKGwohx4NFE3DEbZPeNtL4NbZO/AcI/uM4yV0UIOJBJuLb9kBo?=
 =?us-ascii?Q?VrzgX6SuD1ksE2mBE2M8Q+a8sr6POlzq/v1Zv2Bvos2MN7Juk0i8mTkZHXM7?=
 =?us-ascii?Q?9TCMiU2S28GCBC4PGQkB77n4EGxuJMmgbv3sGR+eWmZ+gAeU94w71GILbjJo?=
 =?us-ascii?Q?iY/NhdlnDg/35FN+uPF/Zbo5ro++FxYWO9yFCtrnv9ZFq+qOA3eCITSRUBY5?=
 =?us-ascii?Q?IW3OpXQYE0ZOZofhV6BxS1x9Hpl8qZO/mCcw2pLuoczB5eqZBuB6veiiuEg2?=
 =?us-ascii?Q?MjKIu2ssxqpbNIt7A6QkHqFfY2nm6+WcEOEo9F8HCuJnyrZeDDtHvnhgRI88?=
 =?us-ascii?Q?uB9t+bYaOllViE6+ynsTrTvlI6Ji23Md2wBROYloO5OUkJMxx8RzYr3m3sU7?=
 =?us-ascii?Q?UpuzGGFSE9hSYqRfVuSI4vy5xn1v/VX99srWlefnNTXAZjDF73XABvfu+khC?=
 =?us-ascii?Q?q+gCN2fU0iedhH2jzzWCDTr3zcH4hGDg5tuBdv12vC4H8U2mm+8uo02XvQs7?=
 =?us-ascii?Q?dtLicwFINF34+92TZZ4U+aMMHf7Nfb6UsbcMe9/RqIn4xaITXPhqRwRNbjIK?=
 =?us-ascii?Q?Ugkyhykt4DmzPikz+ey6SwWwttysLmwi/5YOQa9//w4mJ0ug7THBe5aKcN8k?=
 =?us-ascii?Q?JicyUXJ5/KxFTG1d2zcZrFW/rUfImB+kEw4Pi5HJGM13kf4/GjSO0dpBgfew?=
 =?us-ascii?Q?1k0sCcC7VJas78zvtBFQJf/zG1r5Q+UC24PCb8Pg40y6ksSKwZZzloEwCUhR?=
 =?us-ascii?Q?B/hM9OmGgDimgAEfIPWtN7RhpPwiHRb0ZodgPp9Afu0C8nFMlWq7v5VdofL9?=
 =?us-ascii?Q?Fl07djPJIwAF+IqilW5oi6vaCJSFOWmWzmQ0OLai+UPbzmfNv80s/mPCx9E5?=
 =?us-ascii?Q?f3TRHGehhI/D4rNddexG9og6XGQoNqf2bd8gKXaKfWU1BFrtpema?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa5b358-aa72-44d0-d795-08def4773bc9
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:30:07.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZWwHYQYbPhyLqKj6OrAwaeqiLe1l9SjGRU3HoDriLX1Jrq1gL9jnCmOodcfudeUB3pMCjCpw4H6FloHIw4k8B8uNlVsdhfDSRuD/wdrvf3aNeQA15BNFfeN6bV22GcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1251

Add clocks and resets nodes for JHB100 RISC-V BMC SoC. They contain
sys0crg/sys1crg/sys2crg/per0crg/per1crg/per2crg/per3crg.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jhb100.dtsi | 198 ++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jhb100.dtsi b/arch/riscv/boot/dts/starfive/jhb100.dtsi
index 14ab83ed4482..6b2863fd3fd3 100644
--- a/arch/riscv/boot/dts/starfive/jhb100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jhb100.dtsi
@@ -4,6 +4,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <dt-bindings/reset/starfive,jhb100-crg.h>
 
 / {
 	compatible = "starfive,jhb100";
@@ -262,12 +264,96 @@ pmu {
 			<0x00 0x22 0xFFFFFFFF 0xFFFFFF22 0x00007FF8>;	/* Event ID 34 */
 	};
 
-	clk_uart: clock-uart {
-		compatible = "fixed-clock"; /* Initial clock handler for UART */
+	osc: clock-osc {
+		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
+	pll0: clock-pll0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2400000000>;
+	};
+
+	pll1: clock-pll1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000000>;
+	};
+
+	pll2: clock-pll2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <903168000>;
+	};
+
+	pll4: clock-pll4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100700000>;
+	};
+
+	pll5: clock-pll5 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100700000>;
+	};
+
+	pll6: clock-pll6 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2400000000>;
+	};
+
+	pll7: clock-pll7 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1950000000>;
+	};
+
+	per2_gmac2_rgmii_rx: clock-per2-gmac2-rgmii-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per2_gmac2_rmii_ref: clock-per2-gmac2-rmii-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	per2_gmac3_sgmii_tx: clock-per2-gmac3-sgmii-tx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per2_gmac3_sgmii_rx: clock-per2-gmac3-sgmii-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per3_gmac0_rmii_rclki: clock-per3-gmac0-rmii-rclki {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	per3_gmac1_sgmii_tx: clock-per3-gmac1-sgmii-tx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	per3_gmac1_sgmii_rx: clock-per3-gmac1-sgmii-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -310,8 +396,10 @@ bus_nioc: bus {
 			uart6: serial@11982000 {
 				compatible = "starfive,jhb100-uart", "snps,dw-apb-uart";
 				reg = <0x0 0x11982000 0x0 0x400>;
-				clocks = <&clk_uart>, <&clk_uart>;
+				clocks = <&per0crg JHB100_PER0CLK_SCLK_UART6>,
+					 <&per0crg JHB100_PER0CLK_APB_UART6>;
 				clock-names = "baudclk", "apb_pclk";
+				resets = <&per0crg JHB100_PER0RST_MAIN_RSTN_UART6>;
 				interrupt-parent = <&intc>;
 				interrupts = <26>;
 				reg-io-width = <4>;
@@ -319,6 +407,110 @@ uart6: serial@11982000 {
 				status = "disabled";
 			};
 
+			per0crg: clock-controller@11a08000 {
+				compatible = "starfive,jhb100-per0crg";
+				reg = <0x0 0x11a08000 0x0 0x1000>;
+				clocks = <&osc>, <&pll6>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER0_CFG_400>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER0_CFG_800>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER0_NCNOC_INIT>,
+					 <&sys2crg JHB100_SYS2CLK_BMCPER0_NCNOC_TARG>;
+				clock-names = "osc", "pll6", "cfg_400",
+					      "cfg_800", "ncnoc_init",
+					      "ncnoc_targ";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			per1crg: clock-controller@11b40000 {
+				compatible = "starfive,jhb100-per1crg";
+				reg = <0x0 0x11b40000 0x0 0x1000>;
+				clocks = <&pll7>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER1_NCNOC_INIT>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER1_CFG_800>,
+					 <&sys2crg JHB100_SYS2CLK_BMCPER1_NCNOC_TARG>,
+					 <&sys2crg JHB100_SYS2CLK_BMCPER1_CFG_143>;
+				clock-names = "pll7", "ncnoc_init",
+					      "cfg_800", "ncnoc_targ",
+					      "cfg_143";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			per2crg: clock-controller@11bc0000 {
+				compatible = "starfive,jhb100-per2crg";
+				reg = <0x0 0x11bc0000 0x0 0x1000>;
+				clocks = <&sys0crg JHB100_SYS0CLK_BMCPER2_NCNOC_INIT>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER2_CFG_400>,
+					 <&sys0crg JHB100_SYS0CLK_BMCPER2_CFG_125>,
+					 <&per2_gmac2_rgmii_rx>,
+					 <&per2_gmac2_rmii_ref>,
+					 <&per2_gmac3_sgmii_tx>,
+					 <&per2_gmac3_sgmii_rx>,
+					 <&osc>;
+				clock-names = "ncnoc_init", "cfg_400", "cfg_125",
+					      "gmac2_rgmii_rx",
+					      "gmac2_rmii_ref",
+					      "gmac3_sgmii_tx",
+					      "gmac3_sgmii_rx",
+					      "osc";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			per3crg: clock-controller@11c40000 {
+				compatible = "starfive,jhb100-per3crg";
+				reg = <0x0 0x11c40000 0x0 0x1000>;
+				clocks = <&sys0crg JHB100_SYS0CLK_BMCPER3_NCNOC_INIT>,
+					 <&sys1crg JHB100_SYS1CLK_BMCPER3_NCNOC_TARG>,
+					 <&sys1crg JHB100_SYS1CLK_BMCPER3_CFG_125>,
+					 <&per3_gmac0_rmii_rclki>,
+					 <&per3_gmac1_sgmii_tx>,
+					 <&per3_gmac1_sgmii_rx>,
+					 <&osc>;
+				clock-names = "ncnoc_init", "ncnoc_targ", "cfg_125",
+					      "gmac0_rmii_rclki",
+					      "gmac1_sgmii_tx",
+					      "gmac1_sgmii_rx",
+					      "osc";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			sys0crg: clock-controller@13000000 {
+				compatible = "starfive,jhb100-sys0crg";
+				reg = <0x0 0x13000000 0x0 0x4000>;
+				clocks = <&osc>, <&pll0>, <&pll1>,
+					 <&pll2>;
+				clock-names = "osc", "pll0", "pll1", "pll2";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			sys1crg: clock-controller@13004000 {
+				compatible = "starfive,jhb100-sys1crg";
+				reg = <0x0 0x13004000 0x0 0x4000>;
+				clocks = <&osc>, <&pll0>, <&pll1>,
+					 <&pll2>, <&pll4>, <&pll5>,
+					 <&sys0crg JHB100_SYS0CLK_NPU_NCNOC_INIT>;
+				clock-names = "osc", "pll0", "pll1", "pll2",
+					      "pll4", "pll5", "npu_ncnoc_init";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			sys2crg: clock-controller@13008000 {
+				compatible = "starfive,jhb100-sys2crg";
+				reg = <0x0 0x13008000 0x0 0x4000>;
+				clocks = <&osc>, <&pll1>,
+					 <&sys0crg JHB100_SYS0CLK_GPU0_NCNOC_INIT>,
+					 <&sys0crg JHB100_SYS0CLK_GPU1_NCNOC_INIT>;
+				clock-names = "osc", "pll1", "gpu0_ncnoc_init",
+					      "gpu1_ncnoc_init";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
 			intc: interrupt-controller@13220000 {
 				compatible = "starfive,jhb100-intc";
 				reg = <0x0 0x13220000 0x0 0x80>;
-- 
2.25.1

