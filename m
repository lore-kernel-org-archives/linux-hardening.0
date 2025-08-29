Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0EC341AA2;
	Fri, 29 Aug 2025 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487638; cv=fail; b=oOsPFPvwmrYzM1H+/ERO8wHVafZ3lMssbW8XFtitm/KajeAT+lRQ9qAs0NsVPVGWomh4kwWn2CVGznH94jbl1GkTcYVs5HULgtlU3JLjadG61mXLS+ksDSAVUhY0M7hnBW/bbEH9Pe3cNOWyXEBewf8zjdP8cBplzh1ISQbv/xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487638; c=relaxed/simple;
	bh=N0pF2Ty+1KOk7EMvc+ueL0AtbBH2UvfGToJM/1zkli8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pecnj6mVUCGYcgKShit7FSFs7H/VuVPPL6RTsbBO1J2Pj2RjzU8lBCWNhtDAmJAmh8BGr1jc//FBVncHzj3I3UshqHEaz/2URAK3hozf10hTrhWdki5ltIOg5aGmJIrOxEsK4a9cHua6ya1utQ0OBMI7Y1rXyQ9H4S2MGeRrvvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F7oS2Kie; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F7oS2Kie"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/3gAOaotpq0KHq5wS89b/cVOoV8HVoQHLd5pEn8kpOF1m+Efodd6hQ9j1QpLJJp91smHAQ+8clbP+wHHONPrdZWGNEzUCR4sUXFPRfSVbak1BhCYDYgVdPJhMd8eeaYWyAmwcMdse1NU0FVETwCtQV1d0TiHgNGdgst7xsIBFPu2Z0Obgfw22cFOXC+bgH9r7Oam8S/MN5zCHCeq19Y7qcND6wWush0k+GDK76GTGAEnJoDqdSCf9sYQ+iPM9Q//rMiQCF5JzGW+uazKKuemZ997vyK5CMsbffTuUURSU6NTDqd4qtSXWKg9t9N/FaPbfan21/2hT11v7TXZTd7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3rkXSn2XGdHdXUFnD5QKnzTKMHht/yQMskuDxfT7AQ=;
 b=PY0opqThKRQBdvCQTJmNMWDY7n2uOHFukKEypOguJYI5WVKblDOAGWR2Gdq4qSB8+OHwgEJm4huFQdtlGgjven6I4QPHRS7gi/sG7dHeQVJykgTCg3F0v02tZaS6jxBYcNqkzFulDACsEhxQhb9A2t4FYfswpMRn80OQ62d9oxnGG/cBD30HuQvOgivkVzn86AVEjqIIuQn2mOQEsvmWP1oTn4EkS71geRnInSyC8eKmkwN6dBLjjaEeiVAyMYC6O7kWUh0uSmKiZqR/jTIBVglvXdWInXsgyPmxUz0Qr4tqc4Hoq6NzcPbvEP+lAK3fywSc6YtlTeDjeGQxLUL2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3rkXSn2XGdHdXUFnD5QKnzTKMHht/yQMskuDxfT7AQ=;
 b=F7oS2Kiep/nQ/KWQ0QdE+aK0nJz14uLhmcTVTmB5YJyZf7Klga8sJGKOir64hw1dL3TXxcFjWCjBiTxEhfJtvhRg5lS77Z4SUwppcWbp6EdkA+CecAbR+/ApGWTKeMdYvV3p3to7AM5norVUl20UXCIFE6qQEBV5/c63i1lkqPM=
Received: from BL0PR02CA0095.namprd02.prod.outlook.com (2603:10b6:208:51::36)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 29 Aug
 2025 17:13:46 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:51:cafe::ac) by BL0PR02CA0095.outlook.office365.com
 (2603:10b6:208:51::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.25 via Frontend Transport; Fri,
 29 Aug 2025 17:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Fri, 29 Aug 2025 17:13:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 12:13:44 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 29 Aug 2025 12:13:40 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<jarkko.nikula@linux.intel.com>, <linux-i3c@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V2 1/2] dt-bindings: i3c: Add AMD I3C master controller support
Date: Fri, 29 Aug 2025 22:43:26 +0530
Message-ID: <20250829171327.2590730-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829171327.2590730-1-manikanta.guntupalli@amd.com>
References: <20250829171327.2590730-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: f1eb7f21-070d-40e9-3117-08dde71f6a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9oG5uT+pd8WZDwV0cnDd7kSDe0hLbpygb00H1iDnECaEkmOUwcte0AxmvwV?=
 =?us-ascii?Q?O/2QAn41NOFEJlnvxURn2hxrMgwASs701GSK8ktW2HwNJFgxxuYbKQ79yfZj?=
 =?us-ascii?Q?6LWstKToRJI6uIKrAd/FgFyvfGjCeMQ7nKQs5n7Ayz/VIMJ6QW2YKEOhR114?=
 =?us-ascii?Q?ot+akG4vxD4f717xh6eRJ38XR/fo3TJ4scOtT7FH7OIbEsJwKx5WVMS8zawZ?=
 =?us-ascii?Q?H8uqpPRCiM5aGoira3b/7OnCD/3DGOEGf2bdMgTiOgmaNr2JaWhfcTVIbZ6r?=
 =?us-ascii?Q?CVMX6bEVIErAmBFlEVezdFHC8TNESJ0q6ypfE44hm6V3dXA6e/Iz57lUquVE?=
 =?us-ascii?Q?tmuFkJYIaO64wa1xsvIUihtrm6J8mtT2dEP2+m884akLwSV2KUshUv5q+D43?=
 =?us-ascii?Q?Ug/FeFF+szMh32i9zpkMpKQh1C7vrwUQSvHZbnPKHu5jwlFMNJUxG9CUqJIi?=
 =?us-ascii?Q?xpKW0s0ZvltKP+8XxWMwc7FLItVPCyVMt7j/+4dPvi+kIoqzuWxAw7qcNNV0?=
 =?us-ascii?Q?Y/N9Cnq/Yi7KbG5TBlvZe3ZewWSYMQ4o9lMXkS4noqGyhR3rVkMPJWlHmMW7?=
 =?us-ascii?Q?/sNf4SjtsnxiRyjzWmUe31ZvwKv22vLHfdIL7pff71KAV7UcL3UN9BYhzuoQ?=
 =?us-ascii?Q?Feq0GwfgdnfR+9pVbu9DOzH9s+xU8ajKoVxTbGtETKJCMljUZAICMZckUfSu?=
 =?us-ascii?Q?g1KPifHq4z9lnLTJFvsZWaLgCzOGpR2SSg79QTFz/lwVS8xLTmX0GS+8IT0N?=
 =?us-ascii?Q?KqWc+GEG2iB500E4he+H7IFfszgIcutU0UBOOKosbFgQsD6Ct5dsEv8SV5eM?=
 =?us-ascii?Q?1Sbw6vaQM/we/Ed7dvEQ3TIDwrJn9uoWJZuQ4SIthzJPTwOvwclwLnl7YMMo?=
 =?us-ascii?Q?SzYSS3hp4Ecl+pqF6vJqSZXFLvBzF9+wlyypy0IcMSOIZJlLPod46AtRGo4s?=
 =?us-ascii?Q?a5RTMvXutLr73Z6adg+TJZyMMCDXuUTmbmpCOFo40WTSIWcwNMDQbGw8i129?=
 =?us-ascii?Q?HGriv1eNNaDM51hZt7lyUU7GsXuvhCg7D8QGskmfo/cXeYvKRlr2LTt+3fLK?=
 =?us-ascii?Q?bUx117fGd4hVVSF2OKeE3A1zcB6353P/zqanMcoWZ27KY42Fh6cj/whTYFTr?=
 =?us-ascii?Q?D7iI+9Jjzc+map1WpgzVIjavsUngNQBUrVLKmi0iqL70YUF9R6GRkKXI7U+7?=
 =?us-ascii?Q?lRYSCUBwPBde0KhkvTAXxe6EwBjrzZhJjSj817pz0Deu6L/Cg7acV6YQxq7B?=
 =?us-ascii?Q?CPth/id8GfbHZhr5YQO84m2R7YVmPwicoaH9TZJ07gD4lkzTqLuKR5b6Hrjj?=
 =?us-ascii?Q?BFgVfJPR6Qq2MTE+MSDBW5eiRlYGwba8NYIKrrcECs3eK0ICj2orkok8Y62N?=
 =?us-ascii?Q?B2syd5u5WSjw7jbweL9pk6Fc58JdDvXzVSy4YfloELIUUz/qwAiIGGOwrk03?=
 =?us-ascii?Q?7ipaMHL+GPTuPJBjp8Gc1Ctu1VsWr7pnPTnd6hcD+o1mgXRg/hlV83p4mvxM?=
 =?us-ascii?Q?SoCo+Qvjek5DNjg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:13:46.4506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1eb7f21-070d-40e9-3117-08dde71f6a01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

Add device tree binding documentation for the AMD I3C master controller.

The controller is represented by the compatible string "xlnx,axi-i3c-1.0".
The binding specifies required properties including register space, clock,
resets, interrupts, and provides an example usage.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Updated commit subject and description.
Moved allOf to after required.
Removed xlnx,num-targets property.
---
 .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml

diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
new file mode 100644
index 000000000000..48be3c53c1be
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD I3C master
+
+maintainers:
+  - Manikanta Guntupalli <manikanta.guntupalli@amd.com>
+
+description:
+  The AXI-I3C IP is an I3C Controller with an AXI4-Lite interface, compatible
+  with the MIPI I3C Specification v1.1.1. The design includes bidirectional I/O
+  buffers that implement open collector drivers for the SDA and SCL signals.
+  External pull-up resistors are required to properly hold the bus at a Logic-1
+  level when the drivers are released.
+
+properties:
+  compatible:
+    const: xlnx,axi-i3c-1.0
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - reg
+  - clocks
+
+allOf:
+  - $ref: i3c.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i3c@80000000 {
+        compatible = "xlnx,axi-i3c-1.0";
+        reg = <0x80000000 0x10000>;
+        clocks = <&zynqmp_clk 71>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+    };
+...
-- 
2.34.1

