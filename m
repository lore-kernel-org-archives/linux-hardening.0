Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96F43231D;
	Sun, 20 Sep 2026 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905810; cv=fail; b=SplArLePKQlS9Cn38n2epcC83EvZjlLvIkVxh+9PC0b1ywuaU3unlDiwNjhFmIdUrTHjg/hhBn5DqRGK0bTAnGBR/mACDmjgUOcnKSujKf+BNgCu92L+PtFDbqdyAxQIuazzMNDVO2BhF2mJLHo660aPtq+pnu9gBL1YXasfofI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905810; c=relaxed/simple;
	bh=kx+/yRi1skGoUKdq2tamuo5tICRMS2pFE4LuJmaeUos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XhoaMsvsXRFAYtLDG7IjBez7et59XNosD0hCfSeCDVgSxvqDvDt39fgRkTv+t+No6+R+EY7aVad7CGHwGl2+6DjlGQARbuEzCNKzpl7wQqgnXbfIep+L7prfZHqcqnVO6OmtV6aaOybm+KSWABGSqoEToLGJuTtNvVJAYJZpfhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SANX61Cx4Qj1VxnBf6wjHCG58GnFXhr/FrRGWZrI6wS9x2nq8h7fWEFUrpjYOCfDjRZPx0Ii+TQEjCR1nNOycFeOZ1rWA8s1yq25RB/6xL0hqnRiSEXW+wxAnYyBQBEFC5luxJNdePSq+Qwm9LRPTz9K6b7GpJqe8Uzy18YhnCzggHGuOuwTVfzZ5CXX82bqd2Tl0zlo73vHw/e3Dd0okIJsTZ2WNEKW7pgbtKsjfaisQKV174r0/imQSR4WOLzZ3194NhhRbAPr+4PnKmdkN7DXVpyugAtoWTk7b/7AF/SdxO3XuFnDA8HmAsASvJHCmHnrMsH+mGjMSBhP9YLzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkGP3+GVo9AOWdSKY8aBZ/0h8Q/E/xBcXYIiscj+7h8=;
 b=PLiwEHkwDxFuWjY4l1uK9PMDBAEJ7N/ot4ML550PXh1xviQgDNJnWPLdF2wK1mST+oNIqgjB1NUx0e+HDfuPk2aEibjk9CGeLhGm62lcAyivSrUl3fXuWAVQZyt83zaGjtjnFesiJb/K0ugX3Ac5oEZipQeknIyqXYoh1bC3AJuofjKKznaqnI4bAkETsB0yqG2JsNbERespMdGrGdHZpDTILmBpVe6nyJxZO0dDku6iwsaByXt7PXx7y6DhKGNRJd3qXmda32NEPtvjtPMqgBbo0XrfhZiVTjXICUEyhdaXlKu8+84SIfjxbgaMH7P4OprNDkglGIcyWiW7v91s/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:01:06 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:06 +0000
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
Subject: [PATCH v4 15/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset generator
Date: Sun, 20 Sep 2026 05:00:37 -0700
Message-Id: <20260920120044.194901-16-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1070:EE_
X-MS-Office365-Filtering-Correlation-Id: 37af689e-30b0-4d9e-76a1-08df170eda33
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fanIma73YpUMwZgJtxBYOVzgvUm4eBTTR0AfAG5SRNl4rw/PxphJC2fG5Xgzvx/cudIRT+ZaNAaM6fKxx1w92TzdWjsCrp1LZT5HQrMUkwQMApIjvVFX1zNpaab2cdaAPV5j6TKwIdeHFUR9flhUEg5SnH7VSfwCHBwi0qaZASrpklOQOoVgvH0kPW1X3gFGK5JwSOefyP7IzTNF39RKgvNyNiWkYzzWA8/RH83Gex84am9Xhxrs+Yy4kDij/vx274GIqBOok+8RYv0IX5D/DRanoKqyg5VfN73hVPM6ZCc9wKbF2ALNTcChJusL2wDXtv1/RZ5XmmFBHEuN8hYwzaCfWTtGCs3Vxm1QnCEqHLFl4Tn3xGV6kWP2V7eUQV85/ejKzG5Jn9UVNJCqYTjL0gt+epFHqU7V6mEIVW5zGvphvZ4mohnvWaLE2X36rYAC9uwDRk80YUb1+HZhLH8EwCjGgAIfj2wRN6QE76l01wlhDFC6KeL2CndAb/N5hNjNZK4VIWOzEyx8hDSKXaDPsxkb0E1kE1s3Vt+kxp/rxH5kVjKAGE/GdwTBZxY0XZqYxGkI5k9CNaDBL1BFWOxJgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pw6GLA1UJM2/D/F7bbEhD+Ag2P8LsQwL+n7AHNBmbcDI7Bl8SX+cbu6MC9kd?=
 =?us-ascii?Q?H3ZjpfG57YoztiUt86/1A/SPtzRYFb9QFSormBU23AwkoL/Z5s0tOGPnB2nG?=
 =?us-ascii?Q?Z+s9AXdf5E7ICCeDR34Xo2ZfSPrTKMdCmnntbzy4ngZNIdiePO+rXhBsP0g2?=
 =?us-ascii?Q?PRx5JOU3S5vsPE/wnoSyMDBWesIz0ZYzK1M2fnWf8QvfEGyyzjul6ay6vxT8?=
 =?us-ascii?Q?k5n0fXYg9BKuPAidHocoDxYQ3dvfz4f4wkxLt0BzkEiIzMnJpZ6mbBRGlXpq?=
 =?us-ascii?Q?tkrW9XXMQIVSLfc8dOqo4cqiEs5fB5m+WeMtO2zfUomcezQ3FdTYDSsFAjT9?=
 =?us-ascii?Q?XXwxWKd+ts1OCqyU7nrvwJoOWAnN0jSSWQrls9sWgq/dgJrpoMP05M1/WiI5?=
 =?us-ascii?Q?6KpvPYI1b7yDrOdcwc5DY3EW/KPlDSaDQ2GoVo1crVm3Bhv5CaCM7WbjBCKP?=
 =?us-ascii?Q?6ojXVjpXG00EVHh5Rg27spHC0q95zXy229qA/980/GqZBB4LRNhnnA5LNdvQ?=
 =?us-ascii?Q?Y6h43osh6Dlq+nkvt6ZxGYjdEq20TuWRaO3uJTRudrfBnh263AXFEUPL64pF?=
 =?us-ascii?Q?BhdOOuU0y1rSoW42A8T4FuCtkscagnyJjrshO9VVWYxzM9c66cCqm7O8bSsp?=
 =?us-ascii?Q?IzYpjlq2UnF8RE7vRHSooxqu9rnvOt/Y8CVUVxbOjw1odnm7BfdBG9sZeRDp?=
 =?us-ascii?Q?EZ9glUWrEMltQwBuP7lPsN3vXo2/DKY2dMKbGskOqgThAMPqJusBnsmFbnOO?=
 =?us-ascii?Q?iNPV7tys7MTdiilHuomSUSeCYWCuL/otBcCwfEtly/tnex02nvYMcsKPPOSn?=
 =?us-ascii?Q?OgomD2qqi4K+1MVJempovQIwr6/u4xdg5vWpMdeBF1kzZGBVAAaNXlKcgq9P?=
 =?us-ascii?Q?RdUrq9ZMYpzO030b4eFkmCqbdnz2TnRKU/wtrez3w7jSGMeSIlMmuk4DjDxv?=
 =?us-ascii?Q?QMXmP0MH/PTSj6wHD1PuQVxqDACixvuLWbOx0MbiU2zEKC9dYyF4b84YE5PS?=
 =?us-ascii?Q?6aPZiUT/5Cow9FxYHxiuM3eAfxTBPPobKBXeOX8HayasdcVCL2J/UrdyrhMJ?=
 =?us-ascii?Q?2Ry8BejE0T2knsJHxV4eIFsu1p1sVzjTTA3obZCmuJIlAz7/h3UzcAU3i3Wp?=
 =?us-ascii?Q?wvEn8DQSe9mRwSf8cWKvfdTVMPT+eK2/8O0xI4uFziwNeZenBiZ3PthIrS01?=
 =?us-ascii?Q?Ke8wx3RPYk9uTIczPVf7Vd2iXLR3VKXW2jrd4SKZ1zOPPKMGphRpSBPhTJnh?=
 =?us-ascii?Q?ozAHc/4E1JeQfgip9mwf7T3CCU5RRUSOgBuppQNCU1DlljqQCtl+Sp4e82cl?=
 =?us-ascii?Q?TNyUy9cGBMpsFD1cYUtbPBOkBBh2tZYGSXyKGmYoAvXvF9kz3e4Q3rbAznIF?=
 =?us-ascii?Q?g4EStIJK1I//zlrEqMNg7dGeUSAtQldU/3SMZ+Gtld1vShszN6F8JjCbqpn0?=
 =?us-ascii?Q?F44H4F3pntgtbRMW8/DL+O//FMyuFaXcuKF8JuOb7L9+dXnu7HqkQr+PwY44?=
 =?us-ascii?Q?htXQNrcmVoT0ptBhi9M8HYRXNAAcFW0zCDc5dGWF3l/SnXn/XLjudXFMDlbL?=
 =?us-ascii?Q?+tjAi/4iszbr+hMm9dWwHCz4CM/xoD/z/AddgHgwMP2832YVgpyIoYMQOZCn?=
 =?us-ascii?Q?BWoXKOQ14fdpWmltugJkZr0+ubqMusUeEChNemIKQll1hVom/7LrhgeSsKze?=
 =?us-ascii?Q?/ZiyqY2EXj7gti9sV/7pWTZlZvU9a3G4G1jAYwZaqu82VKmX573bc0ZlNbb2?=
 =?us-ascii?Q?GFUZuMcKPN/5EIWoder/0kWFgKFDhoe+wOIB7Dfgzr3Bt+lsBzg5?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37af689e-30b0-4d9e-76a1-08df170eda33
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:06.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MT3EIrCebsuUCUpMladN+12Akvf5dfKsCi0v37rG3K8Dv+GO/YwXQ31vxzRz0F7THAyrfpPRd+IV2SVfM0Bm96C6Bahjl/TzeR/1FdcjUJU2sQnIMAb+Z2ri7g0iyiN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

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

