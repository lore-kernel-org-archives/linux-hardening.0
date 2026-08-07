Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CE4749D5;
	Fri,  7 Aug 2026 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102278; cv=fail; b=bCnm7oeUPEE0O6NAhQAF0maG9xRm39EjiHpTIQP5EuZbJD8XhZ20l/wlKnuS0xGDhf+Zc8oyQt7Z55lAtqQbvtBSAfg21lGxOKeZXD46f9qI4id6WV6s1WMe+ucL2uhFZSAAtw+mb3rEUaTC4pROqJ5M0KH8F+hE/I03Mtoq990=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102278; c=relaxed/simple;
	bh=H+p/JbTjbjDREtlsknQDJ4bEVNk2bEysgL6l7gCNOVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l16FK4C7VHDXueznfSmihp6b8xiFoGiOLujweBYtKG3RrlYCucBOAIBnKLiFoNW8HePQBw+vhku7OaMRUrDsVDMyCzDmmHxwfCKmtBxFmF2N4BbpsuenRLy9QPtVPiS7PUKE1KZt8Np6hxVAb0jZAvcF90Oop3YgAV/jOzUvycc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeYtnM78nx3UtEOvtkX369p96Wjv0RlUHnLJhJX+Av7OsbWDW7x8AjThYAAQevhVLM9aYTK/+ZqJFEb7eMEg623s1Ix0Tp2nRpVkpEyBYc4JsIwsCYuxbroZOI1KXQvApLHVQbN1eE8ApGTG0JXsDA88oT/HEBl8nofa2PTi9J546QQhVqLKtmWjbKFab3st52cJEHZsBK6Q/V7lw2XwnLA4nomUO+VkEMXMqiiAv6caA96Z8UybQfnZq+QppaHRjuOgNSSbg5u0aQWX25m61vwCThFsUSOUBdx/fAUZlUf24j5+thH2IdJK/SnKB2Rijt1IpYfZ7Ddr10LWpVzFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGRCnPe5SrhWgJUFcql3Y1OHApggMchPr9en3umJqv0=;
 b=l17/iNbRuyv1uIa7zWA2zfbsGmLinhWcsdw+2rkpCph9ajk9vZaOQyl3D2hm0Aa6shwVyI+pEOU+NG31dyYz4x2CTNSMw3F8+AFiilvtgsUskvrbfgpYc/QQhgKhgnWZBBL5ley8xjjzXix4EVIO4h00Mp5w6pfbQ11x1furGLXh6QblJ9hkYgLXZPSXdA0YlPlRRXgY1581VZglkkd00hYhWg6GjLcCrSgD6XJ3Yv5ZS3MDHKg57EsZDE8JqOJD6jfBLAx2UIRPAui/AZII44vDW+/51fhML1cBWiMPlpVPkIa9tv3ddaaAcH9AudiDHPMPZmw38gvgF/eboAbGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:30:02 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:30:02 +0000
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
Subject: [PATCH v3 19/22] dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset generator
Date: Fri,  7 Aug 2026 04:29:20 -0700
Message-Id: <20260807112923.191627-20-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc5d8b9a-8d8d-4934-7ebd-08def47738ee
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	Pbjpw2vd0yfsXrFe4SoLMeDwluEz/+HyCC6+blQqd9Sr4Y6ToGzA8hPj0Yt5h0yG0mXauQfh022XhXXI4m67VbMiW+C9nsT4MoW5X6b1dwr4HoMmFzawxnfljv4X0mtMen1LB7GnBbi+UUeRSkOwNk7CAi/11sZ7NguT4AGv7H2HK8fG6eT6cJ43KIXeJKnXAokHxvPtggkTt2TFZGHJYwAmCbE4Z01qaxF2LBZL9ZEVa5lkTUYhQJOLfiXpH8i6gjiytAxouTDJ2vvp6/XQDr1tZt1Gl7ooxOhakRJU+/phH49IsFedwWxyzYiq8acLSlOebG7PyL2VGI7wHRhyjRH1Uhy9akyfWlaEWO8PqByD9iyum3iVasJHHPWesP/sqxr6ULYU2b18LqrhxKGssBQiavDIbtrerXWrrsbDISqb6JffxRLxTopTb25D4jkiB8sO+wXmmVjA8aoRG0zfybwxulwfdmDhn66wxXClcbmKALEvoBT+xMlY/XPt0EZOGh+3JUQXAkbYNq6yWjdl91yaSd14ulSdm16XgOF2RDmCl2pzK8XgHnI9PrjFKV4GOgoXSfpB5K0heocZkdidSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0lhEclk9gH8kSfWjC3IpBhp+2qubV+F5xTTUgDB37zvG2s+T8Ho3kgAUNsYk?=
 =?us-ascii?Q?GUPpQCROv8XKDem7tCfx4fL75TH+iUzKsZbrLZDK/kWPD8c12hqbx4FQxZWx?=
 =?us-ascii?Q?d0mD8DckCNAaKlDw6MyrIwLINVGxxhFzpVNHrEODyxOsYL1T+vcsz/psmF9X?=
 =?us-ascii?Q?3LCVoZ13/NHZOwOQLdt47n9x1XwrhB7D2OLPad1Vy6bJthNf92huRi4NpvNv?=
 =?us-ascii?Q?alqz8OGFiqUHqZiR83CpI4ah+XA3cGmHnSyaYiJn0rHlRfeYc8OXa4AlRsDz?=
 =?us-ascii?Q?OArX/4xhE7ngv0C1/QJer43S+NhieK7fheRBS2zNHIShBf6Ilw2KUTch71tZ?=
 =?us-ascii?Q?CB5T4v8bYok2GnS3PM7Uv9Imnnkq/fwLJ7GqgaezoQ41AwEjMEmyK0vfJCrk?=
 =?us-ascii?Q?6zpDVivaATvYxQMdBjTInpg0ktB72L0XcL6JqUbUmUoNS+NbjkeoZkvvhxsf?=
 =?us-ascii?Q?KhZt6CLq4RJk5ehWnlBo3LKjQZCl4VweQgnVq6sKZrOEVFp2yEVs2vBhPIUv?=
 =?us-ascii?Q?Q1sXtkP1VlEPg7s0YRtDnMmsv7+N+17urOM+AzJa+wxNtTAcQxBsl6akXdth?=
 =?us-ascii?Q?oB9cagcQTH7cSuYK7NGMc8N3CBdhPtMU9sP4EystxjZPsTqIfG9Bd8TIFslZ?=
 =?us-ascii?Q?ZY5E9GV4b8F37BVTG1UqZ4b4dE0HopHrB2pSHkviARxwEoFEb1Du5BFnspBE?=
 =?us-ascii?Q?yKBxgF/Q+zZmJYttRiWZmjJJLte9KGosd5iwL5rlhpBjqSNZAqCORoOsCbF6?=
 =?us-ascii?Q?2utnYy4c4/7hyaqEclu2OZxBVXIyDZNMGRAWFkJl3Khc6ZuREAknA4f9qs+U?=
 =?us-ascii?Q?AWkVovFnw1ZoKrUlDLQ6HHKTlMLtmZhZqzH+6VumpOuRPuLcW+XDx8BNrjV6?=
 =?us-ascii?Q?P2UlAwPobUPKpqr1EqLDwUDzOXyZxfpSYcdUeD56aQFVK20u6FIgZggNsnoY?=
 =?us-ascii?Q?Zlp2IeeQcBWmpLnOTwQS84p1F9xPsZ4r9+y64ARtm7pQ7KgieDx5xgL5hLhB?=
 =?us-ascii?Q?5VZK+jB1V1eQCt/OtZKFRZGsHM8/sKUUv+Sqb5FpqvZoUJ675vJYy29tEJrV?=
 =?us-ascii?Q?767RWySuDlITwiCtrHTwP3rQvmWxZizl4r5fFqYsLpd9tcU5AE8ar4ilhWsr?=
 =?us-ascii?Q?bKBNSlfvDngRargZEmHCKQH0DpY4p23shdxfJ+240/eF68anXmenozB2YASD?=
 =?us-ascii?Q?Y5POguhxs89jp0aoGU7aCLB2rptPK0/jswkOfSMTa9LU5dRZvsaTQI5YtQPi?=
 =?us-ascii?Q?Fih/aVIVRVuOGeslhXeCAIym1Kc1GgOw61MNGWomfQq3y2JBSgOz21w0ZXJW?=
 =?us-ascii?Q?9x4Vr5KnKg+6GC0x3RrKQWOiPSm+hr9Ln4Ox6H9EpSCgt/QV789UCQQvbo8x?=
 =?us-ascii?Q?+XAXE7S75cz6Z+VrHOB8TgMEtkObnmh8YTGKnhLKZFZk1B1yP4VdqxbussVY?=
 =?us-ascii?Q?V3fbwy30v0rvLN1HzTw7Fo4v4j+x5aZXxy000HgYIobAO895vdpuhU9RNlkZ?=
 =?us-ascii?Q?XzwYrTM+wInigZ59HlmChcvsmlIwSfWAmdaTydFSloHrZu0EmjXMhB14GDrz?=
 =?us-ascii?Q?dpWNpH8JTyag2CMFhKSxULLeyDsX+pbk7pcPr4ZeSsext//I86S9x+4vIzvh?=
 =?us-ascii?Q?zks35DaFAn5SJ3tetbmTzQEYuf6HG2NC2UBDmlkzY/6rVbR2Y4Z+3UAHEO2o?=
 =?us-ascii?Q?qo+rTKkt+BUfg/+tNbbpu+bK+603rxm/9yFl2eWmGc+zLHQs6xn2y3zLZDNG?=
 =?us-ascii?Q?LVTn5w/KupUoF7R7rw/X05ZsPL51x7f1P4u5V9AFS6N4OO+E52MK?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5d8b9a-8d8d-4934-7ebd-08def47738ee
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:30:02.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YusATD7Xu87iTGDywIZAtiyp99QWipJqrzjYADkRlxusceyyx9ZdG5RMnmbU0iIUxYfH/4sD3wKbVpycsLmUW0uaH7HA3WXBGRAbCVuwqeWhQsD6cfhJuGy9Mw37C3Ov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

Add bindings for the Peripheral-3 clock and reset generator (PER3CRG)
on the JHB100 RISC-V SoC by StarFive Ltd.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../clock/starfive,jhb100-per3crg.yaml        | 76 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 35 +++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   |  9 +++
 3 files changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
new file mode 100644
index 000000000000..2c3b9f4146b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jhb100-per3crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 Peripheral-3 Clock and Reset Generator
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jhb100-per3crg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Non Coherent NOC Initiator
+      - description: Non Coherent NOC Target
+      - description: Configure 125MHz
+      - description: GMAC0 RMII Reference clock
+      - description: GMAC1 SGMII TX
+      - description: GMAC1 SGMII RX
+      - description: Main Oscillator (25 MHz)
+
+  clock-names:
+    items:
+      - const: ncnoc_init
+      - const: ncnoc_targ
+      - const: cfg_125
+      - const: gmac0_rmii_rclki
+      - const: gmac1_sgmii_tx
+      - const: gmac1_sgmii_rx
+      - const: osc
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
+    clock-controller@11c40000 {
+      compatible = "starfive,jhb100-per3crg";
+      reg = <0x11c40000 0x1000>;
+      clocks = <&sys0crg 65>,
+               <&sys1crg 18>,
+               <&sys1crg 19>,
+               <&per3_gmac0_rmii_rclki>,
+               <&per3_gmac1_sgmii_tx>,
+               <&per3_gmac1_sgmii_rx>,
+               <&osc>;
+      clock-names = "ncnoc_init", "ncnoc_targ", "cfg_125",
+                    "gmac0_rmii_rclki", "gmac1_sgmii_tx",
+                    "gmac1_sgmii_rx", "osc";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jhb100-crg.h b/include/dt-bindings/clock/starfive,jhb100-crg.h
index 2b2e148ce5ce..bdf7d628b381 100644
--- a/include/dt-bindings/clock/starfive,jhb100-crg.h
+++ b/include/dt-bindings/clock/starfive,jhb100-crg.h
@@ -504,4 +504,39 @@
 #define JHB100_PER2CLK_MAIN_ICG_EN_GMAC2		69
 #define JHB100_PER2CLK_MAIN_ICG_EN_GMAC3		70
 
+/* PER3CRG clocks */
+#define JHB100_PER3CLK_300				0
+#define JHB100_PER3CLK_200				1
+#define JHB100_PER3CLK_GMAC1_PTP_REF			2
+#define JHB100_PER3CLK_GMAC1_TX_125_MUX			3
+#define JHB100_PER3CLK_GMAC1_TX				4
+#define JHB100_PER3CLK_GMAC1_RX_125_MUX			5
+#define JHB100_PER3CLK_GMAC1_RX				6
+#define JHB100_PER3CLK_GMAC0_PTP_REF			7
+#define JHB100_PER3CLK_GMAC0_RMII_PLL			8
+#define JHB100_PER3CLK_GMAC0_RMII_MUX			9
+#define JHB100_PER3CLK_GMAC0_RMII_MUX_DIV2		10
+
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_TX_I		17
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_RX_I		18
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_PTP_REF_I	19
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_RMII_I		20
+#define JHB100_PER3CLK_ETHER0_RMII_CLK_CSR_I		21
+#define JHB100_PER3CLK_ETHER0_RMII_ACLK_I		22
+#define JHB100_PER3CLK_GMAC0_RMII_RCLKO			23
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_I		24
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_I		25
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_TX_125_I	26
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_RX_125_I	27
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_PTP_REF_I	28
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_REF_25_I	29
+#define JHB100_PER3CLK_ETHER0_SGMII_CLK_CSR_I		30
+#define JHB100_PER3CLK_ETHER0_SGMII_ACLK_I		31
+#define JHB100_PER3CLK_ETHER0_SGMII_PHY_PCLK_I		32
+#define JHB100_PER3CLK_MAIN_ICG_EN_SENSORS_PERIPH3	33
+#define JHB100_PER3CLK_MAIN_ICG_EN_PECI0		34
+#define JHB100_PER3CLK_MAIN_ICG_EN_PECI1		35
+#define JHB100_PER3CLK_MAIN_ICG_EN_GMAC0		36
+#define JHB100_PER3CLK_MAIN_ICG_EN_GMAC1		37
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JHB100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jhb100-crg.h b/include/dt-bindings/reset/starfive,jhb100-crg.h
index 0965f3798397..872a4dd25beb 100644
--- a/include/dt-bindings/reset/starfive,jhb100-crg.h
+++ b/include/dt-bindings/reset/starfive,jhb100-crg.h
@@ -174,4 +174,13 @@
 #define JHB100_PER2RST_ADC1_IOMUX_PRESETN				13
 #define JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS			14
 
+/* PER3CRG resets */
+#define JHB100_PER3RST_SYSREG_RSTN					0
+#define JHB100_PER3RST_MAIN_RSTN_GMAC0					1
+#define JHB100_PER3RST_MAIN_RSTN_GMAC1					2
+#define JHB100_PER3RST_MAIN_RSTN_PECI0					3
+#define JHB100_PER3RST_MAIN_RSTN_PECI1					4
+#define JHB100_PER3RST_MAIN_RSTN_PERIPH3_SENSORS			5
+#define JHB100_PER3RST_IOMUX_PRESETN					6
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JHB100_CRG_H__ */
-- 
2.25.1

