Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D942E405;
	Sun, 20 Sep 2026 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905703; cv=fail; b=RCRhFxTCME5WaY+xpHivNWlSoymXb4nj1EnvGxPm0fzUneLOjFUhL1TN83RhLTN4gkv+jYFgxjiZHnr5hYYdI7LYijHv0Vx+ubvGnC3gBX34aFdTTFzd4GTioqBnZoOavqpsnDC3TK0n1/kqL23a7SNfJ8UvK4AeqxmvrUbakFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905703; c=relaxed/simple;
	bh=Q89W3KrB4E/HFc4Oz16EAc5Qwk2MkeDAI+IHTJiE4Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpLjUoJR1+0UatvYdJF/ksGpBrwfbk5/1NUSSBjBfdF8djGPN9tbQMrKTXDNr2zhd1VTw26EjAPzXrekRNt5SR1V2u/yAc9HrlElBJf3UwneGgYK1DhtFh/tlsG5eDZV4CdMAIwjvTmjSuAGisWxWDmdFMecp7EHiSCi0lMBogs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIkz5Ae7vltyp0Wzo92OHlLctTJWM7sggLSj/aUbsPrjYHcHpfBrqknHp9dHboyxm+92s7JJ6feN2GM17VKnGmIX6x5qZuFC7WrYoPIF2C/fmMXx8G0FYgpCVcQUa4/wFS9lgdHbT7xe9JSMfRDBl+V7AUMwq++CPOn1XbGY+n6VS2LZS4B6fYitrVnSNaYFQzO36DO/6Pu886m9dyqBpriUa2PiBx4ywPHBipl4boiiiQdqefnVNWsWN+Guj60MrH3zvLF1rJ9CLc/ckKkRalk8sOf92+PQVX+v7Gdoa5vLI5gus59XeLSbifU0ByNbqcSoS98zk4VCkTPVBu3VMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QekrJvFzbRGlSrJPqTxk6rC9KdJkrVtXD0+PSHtlGgU=;
 b=ir6LViSRHb7fvzk94DqqLSS9vQwiKTokfAZiJdNA3esgbHryk9mqLOpfH1uW/KrQtr3IyKrJLydjAKkHkbdlz31NpREsDnRszknrMeaoY48o6Xkx/8GSDasgOeET2lCH78YsGIrfan6ZiOzP86lCNM06oWDDGXBNyPGH70xIhwcpxzMP9aMOHAeKmYqbm03jCBZ3OioyXdMRnnpMFrVLThrypZY1wQQGOynQtBI5tdPoxWyv9bQ9lgKS8u/RPu/55Syxdxnvc1jTSu68P+eo8pvBmnjeTzQunLTgv9Xe8RTyHzr1XrCO4mUFF+IGHS4Z6Zgp0+uTUYuNsT3AFVkSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 12:01:13 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:13 +0000
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
Subject: [PATCH v4 22/22] riscv: dts: starfive: jhb100: Add clocks and resets nodes
Date: Sun, 20 Sep 2026 05:00:44 -0700
Message-Id: <20260920120044.194901-23-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 88869d5c-2fbd-4f78-8c94-08df170ede48
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|23010399003|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Jm7pgXWBW2NAft1y4Lz4Z+lJ4/dELpaa8yu0Ra1Bl2O2zsC9imPeZr9wp64Vljo77MP7N49fN6bDdR7YsLmgafT9Oc98xlzRSPTY7Pw3JxvLzaxbBrF5BHlfhyHX/Xm6Biugo+mbsMEKYl7B/9nJkMRilIAo8sFHH8k3T0DUxtC7JLpjApJgaW2IKmz5dKHl8jpzeRuZeeTOlBSmuaay6j3DFLWVTdMhKdDcR3YGtv+AsHFlahcq7RKS2TzLphXhjkY9CrMlKDvfXPKdo8N7LjVqVZ07pc4Fwaid82vX3uCEegxYMWs4Bi/P2DnSSvHiGBcdrB3MOL5EP5LaNOB7V0NLp9aKWw+jW73jwXjulvQ+3vcY5mYbh3tfx9RYZp8m9oqtwDgDdK2rWCa/NpqrZ4ZeD8VsAI4WH+ZmJaq+KZ5dFuuGnoB4mSYrOtcWxxhm+NQo1ZACd3JeTGEp6Sgc388a9iHg/YCZA/NaFD6+qkAnxb7WV4vzjCXAKg3udZ7R1LPI6poHT98/t7cj9fs9qqeW1OuqMnxAo8GQ+JiBg0195be3NKOLrqsYCo291xMVhvVbrENz+FtBpWpNopyx1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JWTKBi0o06MlVRH6X7m3VserOgA/Aqa4ytCEQz0rMlP0uDqiZ0ZMfUz20mEp?=
 =?us-ascii?Q?ehPR7dyxx5NwH+8m6Hbg9oJXIyucK75Ezi0azkZIs+RvGcBYSn76WaMaKkFM?=
 =?us-ascii?Q?hp/kumlzRKU82ozxvFmiqKl0HTuwsAjKGR2oXmpw2rZemlafAJxn3rgy5QKV?=
 =?us-ascii?Q?PCOxB4WVXkKBXM5xWC8XEftFGhpHcQ+VWIgXu5+giygcvo9RWgPqMfHGP73Y?=
 =?us-ascii?Q?HjE1mVeFnloHKf8XOpJxRgaKsrmvFRvfSJksMqkwx4XEzO8/TCUf31xjdcnv?=
 =?us-ascii?Q?xBKsHr7/sNNpQsjUlMm1pD02+r0JIBcHhZmEroU7q4Omf0+bNlK7EQHnis+R?=
 =?us-ascii?Q?KNSRXcSGuRp6WBgW7HJZQhS8q79W4mnXXc43y0pPNqwfVM7OYShMJPZyubx9?=
 =?us-ascii?Q?tUsvHqlPdf3MMfWDCkjdCnK4JZtVp3Wrgb152MR5kdMfovL4WR3UwVKZtV1U?=
 =?us-ascii?Q?B+2phf34Tdz8WLhDa7VSDLc2myyV5gcozNNfh7Fy16mxABPJH+15C6aobobk?=
 =?us-ascii?Q?PGKte3eI8+Ckh2WHYICHqfYzXvDPWUlSnQmfxJYltFXjFPGXKL+xim8ZICnS?=
 =?us-ascii?Q?ZnVVEmdjMAeYYpWcunhPu41IgRcRLYkqz6ntFTgjGfDjSfiOv+E5gAx3gEk0?=
 =?us-ascii?Q?N60NwcmUAPqpHoxkDll9tlM9rNaYbhFX8MOEcEnttyNgFsLwkmLWhQghkTM0?=
 =?us-ascii?Q?jl4MBRO5M0/j3C3CBA2oggL6yZJNaMPqdxMmYgiz5Kp0FbTwxxhcYaJVqllo?=
 =?us-ascii?Q?yzi4IooHXnE+dpImeJPSzYMReS6yGl7PliWwPOMWqp0CmMJYUuoRF2YBCvBr?=
 =?us-ascii?Q?SgKLFv6Aps/pcJY5VZHEmsU9RdxwYcA3aVBgifBrSLHlEppek51UUu8dwrGL?=
 =?us-ascii?Q?LkoD6YJISqtjs1QmN8tb8oLVtozF9xPFRSo5e3l6+25Rxua6nzMbp9ZSRIV1?=
 =?us-ascii?Q?UxgkmMceJCQ3thH9KWfjAzrN9okERMRKiIN/NboPWbC6p/6CQSWKmzOXvfED?=
 =?us-ascii?Q?N1McZNrs4/NBXQYB2s8rxF+i4UlpS8MhM1G+gDxV2Mg8jCWdQKImIbS4QNQ1?=
 =?us-ascii?Q?rQEBYbkESyqZnlpe8XI933Un262tUo5ltgAfz+MKNDrkWJrAaxH0F5cQZZgg?=
 =?us-ascii?Q?YOjSZiX2Hbvz6/FO8mwpkSZXwPZyx1f92wKz1z6GmDEVIY5m14IAIdsfAG5e?=
 =?us-ascii?Q?bjOAHVbr2553dEnnrFSmZKUTFIpUc9quhLTEeUJyYAA/S75IDeZszQDpIah+?=
 =?us-ascii?Q?QcA+0HfZ5iVd577RJlARUYsDUYWY1wg53UVQCqtnHJcfRPuH3LFZZMSD9BT+?=
 =?us-ascii?Q?SpW/XXGPNRmBF8GQL66mcurpYlyhs1qkJ9AQqduNRNkK9jxGHwRnlYwQNfQV?=
 =?us-ascii?Q?mI25Z4YPeG7aWntD3mgRtA/flukA22VHg79tPZSUx8ubaNwZAirPCz9/81J2?=
 =?us-ascii?Q?ziLxttWdaq6+meJQnEW2oVu5gmPbQWgNkg65JRhpO0K91mmP7Hped7A5nEtv?=
 =?us-ascii?Q?4nJ4f3Eh7HvT2yD3/MqhUkxTWq5Qpv+k6pEdniO72XiY+2wmgRWyleoChrPo?=
 =?us-ascii?Q?7aRqGiqn9/BUUB5py/MsZQjP5PIRC9k4dAxKbJ4Ay5S6D4Z6XDKuWiXFImmQ?=
 =?us-ascii?Q?dMCVZLE9oj6s3q1werNFYEZA8L1mO8RPzoLLSyEFWiMEUySmkoYbmV2P3rZ+?=
 =?us-ascii?Q?pB+9YcCHThglJS3VK18zmbclHi29giWs50ohf885Vouegj8tj4fSv+QPxOuh?=
 =?us-ascii?Q?iAQvHUsKbKwWoglLCGRE3tcsGqeTqLg/HuIUzXaPtXARxULytAwn?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88869d5c-2fbd-4f78-8c94-08df170ede48
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:13.6909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVcTaUMQlL672esdYeNCG97PrC0WohJteAYVs9AftfHhHkjxxt/BTfxBk3fV/k74mzOZ0tjMD3YEun0JwqRJZNcxuMsWvEM9QQ5z+VvU0mImnK0yxknhbXNU7QL0Tte4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

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

