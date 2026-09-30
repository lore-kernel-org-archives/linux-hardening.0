Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4A4F30E5;
	Wed, 30 Sep 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772290; cv=fail; b=I1Nem0Ip2hIQvWxFJ3yqHtJo3VZFV0Tk1DbkrzaIQg5D/jqaGPrSUDUSuSNtAU9WMokd+XJqQFLt3o/qlMTAukzs6e0z0rZ6MuKsC44vly+w9dbDbqPGCYSoYBIyvl8vn0kzQb16GiT15ykDSbtGoHMqN5wulYiMIEDXNcFLlYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772290; c=relaxed/simple;
	bh=Q89W3KrB4E/HFc4Oz16EAc5Qwk2MkeDAI+IHTJiE4Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pXGLgFnXj1mdyc1qccsgO7Sc0lVceYk181O6QleIaW4Sg7dJMxvo0aQ1VCrff/UOmmeY2a4Epdute8WlaA2FhIdF+DN81VrrCFeeQuPTtMJld42zC3oJdQ+xZV+VR2Qfbcm6iH525IzVXJldp3/uoN5aiENVvaFg5l/FkZtjmA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKRSPnowx8qnwSiWAPukHfiKzmMwDSRArfFnBwqAkYNux0/0YrE6P40DvyTfh8kspDWkjTyqQN8OLC48NDHH8cgPc6SNzrBWWa/LfaS+DKphI0/rxa24Qo/eUi6fBWINBOnGq8qMPqGXuKKdBXVsjonUFVE4s1iKebk5pMytCNQltPqvwnsrhr/T31eYDswgjUd7xvIOOh2HknV3ENn4TnnV2379splEEje45F+m5vRtmCIawLr8wjzIj6d9N6sPuaW77kQyEhovJa3ErcyE6dPlEqkE5hnMbXqVCyedArLFsbUHN1kNLQ5aPwpubTbfnFL+mHkZMSKQhHMq7+nseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QekrJvFzbRGlSrJPqTxk6rC9KdJkrVtXD0+PSHtlGgU=;
 b=nJlHivPoMfNPEsqgzEGcnqbOOto7JJSyp8fShXBlNunn3qx8OK0JYIE2vtUttCc2P5rLnI460ePh+d90nGC1L/+tGCKFotZLWvdBIuwVqdTEgZLWoCbyehkl5xwJv1DvaQ9mKwMCMqMA9rH/cPXrNURDZ1RPN/X08ZJmpPGGujW3IXI0gUjIIM4zs/lwE2qCLoMmIi0b7V1G0CI+AC9y5Cpfrgmsv4Aw/cuQfceW0vKJKl9RwtXFPCvxQG0+Il6UYNjV7t1k710dwzwy422R+/ZgvmJWDbjtPVScaDZnRTzD/S+NdWAayaf5aCNK6lgGRq9gNFX3XlQqHXjgaOp/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:44:12 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:44:12 +0000
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
Subject: [PATCH v5 23/23] riscv: dts: starfive: jhb100: Add clocks and resets nodes
Date: Wed, 30 Sep 2026 05:43:17 -0700
Message-Id: <20260930124317.5648-24-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67b2768e-947b-4b9c-5be5-08df1ef0876d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|260925022911599003|260925021911599003|260925021311599003|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	hUewW1ybeh31qz/v3VBWR7kNO73kwW7MONLtb2cnZjeqeA6+7ZECNWf7uGOG2I+Jt1N3kHcvArf1IrUvIXnebwfUWtVGxoFB02tEZKZxZGZetg2xsySVwA9guIO2qvUJ40dPH09M10KHGFl1JUZ/oiIucjJ/9SDC2NRL7sLfQaaquLQ8G3I5OLSg8NV8J9k240aQ1HWgEkdtw7HffMGkpiUTt8YJ7cyKJ/bzayS3c5ehJIK4JPSgbOqb5OpaECxjZTdw5bIZqU7soswZJYDeSRZe4yBZXWdX5iCbefddGNdsG+N2KXNBqhkGAMVRWR31jKU+r/2hj3lXfV3qlyT4kfMwI4fbiHksZLFBlD8cqoXi/YXJjhBzxMeuHIUNWzIWgXO3KSUvb1EodW5JicjelNP076U+FeTY6zv8K7H81O7HeG7h/gUOTHdt63FeE6IKc85iDuuKuwN5nvCJnQaLwaEwf3jtUh2v2+6UejAmDVXnWAfuxRRaXLj6kWnZHtcMF2b2hG27kvlfjrRB5ATB5CMAXyOzAufg6WyCLdzDmDhoZM5fSNJP1C3xEPIWDfZ7BLWY1sFMVzi/4F3556x6gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?opDUy4S7ohsdXV+Y5DMjmjxTv5ntKxWYreNZJxl+0lCgOB+5w56NF5O8/PvD?=
 =?us-ascii?Q?6UiQA5aoE7kaZWfvr/JH3YHl6p+VyUIuHGX7LjBos/21RNnx6YcYhy890FMS?=
 =?us-ascii?Q?TuLy6WYTQz/JK67LrE9lRDyYhkxxbES/gtZfyDhetW+o2m4lRWafUtt4HKQ6?=
 =?us-ascii?Q?Nwg4tVSH4zLeABpX0LgilXiEPl9MCthoyBoahUQQ/PhZn0819MK7k/U9rL9P?=
 =?us-ascii?Q?aTOhcLzyVgPO9/xHDeu/esvd0cpYCVfzhj9S/lkdDzWAbyz619w8A0NZ8q6F?=
 =?us-ascii?Q?SFsy9gsiAfl9GOvYNbFN0xqVg1AsWr6W12o2zTk2n/0eujiiKk3uMihKG+hR?=
 =?us-ascii?Q?9Ms8yaR29IHahfqsMdxq/fiZzF3TkaatDXVSzLhwEZvEI/bXmZVVQJyCZZBX?=
 =?us-ascii?Q?DIPYhNwy/8RJutJ4IyudAIXiJbjqZKD409XVqaRFVsM3FwPseuY749xCXwRD?=
 =?us-ascii?Q?QHsT4ThU3PIlQH+99auytiul6w8XIA/juuBVreaFXx2l1OV8nSVhRs36b662?=
 =?us-ascii?Q?K4A5fHEnwLkJy07UwgmMSg2/ajq3wiqgkuHOKLDnI0D2nptWeiNpxo3KrcbT?=
 =?us-ascii?Q?nazqQEjzJBzCi1s0BCAoP5nlB0SzEYRX9L/JCgs+AlqKN85GNVd6zmwpOjTa?=
 =?us-ascii?Q?ctnMmv5OGpRTHD3KLjKdU6kl4PXFaXx5ibxXJnLZWMDFLBy3fZEycITbXOkS?=
 =?us-ascii?Q?iTaEGNbmnIVK2Ar06VTdwkngsOV7vRAsUIO2DxW+YEfnz+3DCjq4WfQNkI+/?=
 =?us-ascii?Q?qWpzu62U97+fyUEIGYkU2xtuqSmHzolwOYJtgUZwfR48ej0U5xDfEspvVO1Z?=
 =?us-ascii?Q?Ur/viz5j5ltSJVocUlFeWHoNptg2/muiZvR4Z9p5mwOOW0QXIcvvwNcTx116?=
 =?us-ascii?Q?oBKHc44ayU0zFaFmxKK3DJdWU7NWRmFo3o4kKS8VqUX3VfhIQTeP7C94Ziph?=
 =?us-ascii?Q?zmtCSky7GMf75q//XqhTrrCP4oXS4M7Qck+2C6NfbLKQIFNWeiRXVJ2PBIt/?=
 =?us-ascii?Q?t7CkpqXE6wo5hT8ejs0P8S0zov58n3qlwS0UV84St1jgwIpIZY2WVDGZLr5P?=
 =?us-ascii?Q?CdQ2fI7Nr+zypmjF0s9sqQhmGwuw9CaI0GezLReqdMCkVUY42rnarJefXM0V?=
 =?us-ascii?Q?uDrwjtzH+gycXhaQFRdKtDijuWxWGRCoxDu99ufM+iYV9EM5rI9iLMIgw0Tz?=
 =?us-ascii?Q?ApVaxDw3e+UU1WkNLWQ6kdV3x0eDd1esd9k7BCLEYPiVjI2P8zyYQc0yhfJe?=
 =?us-ascii?Q?3nb6LtRVTmJ03hQLStEXJFp72h6+MNo0E7F6v9spkTgFu4SSLgtHYXPiTBRI?=
 =?us-ascii?Q?z12ZJeCyepuUz0pmxD3HwdevYIyiNoRqnvmry0SuovjXPjzrRNnl1qkGkQLx?=
 =?us-ascii?Q?nBMv0DDmBpp2zX8ULwZ+N+99rJA0nyvFcLEkDBTy/+FkjgaKFuVd9SdH/RS/?=
 =?us-ascii?Q?vK3aEsxjzly57qHDIXc3lxZz/mIU7xS818tQ0HZ+6NMfy3NIo0pF3MVxb1KE?=
 =?us-ascii?Q?ViyfI81RjigLnbhxrpYM1XPxPgJYGOUGG3lbTPn2gI9CnlxhppTl2LnJ8vcR?=
 =?us-ascii?Q?Tni5Ez2FYY8luFFg6AcG8skXYctCOI0RhwGmDZOCt4UXdFu2kMngq8i3Azd5?=
 =?us-ascii?Q?q9lIXHVoqj8MxiNroBIh6Re1ZUn0Xyx1UTi26+qJILbby4Daj6ayI7uPpF6x?=
 =?us-ascii?Q?Ye+knFrX6nL0OhMP2c9HYS0BFIorYaUjtu90is3bR/j9RLWVKudUUcaZyPv5?=
 =?us-ascii?Q?8+UAPgy4oRUYXoupIELHqDK1rs0OzpVHx64ZkuZbic0zoLqULuQg?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b2768e-947b-4b9c-5be5-08df1ef0876d
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:44:12.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hc69c1rHuSn3gRyV1Nn6KAmbcTKXjMJ+KztG0YSBXjzNEiIYbEGb5+UoqvlDGQmIB4hwcNqy46J2sSFCGiV5CWMcCMFpOlZbQ+8rxOyhxKg0ozhHwTgBg11/ioTX01Au
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

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

