Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064481B3935;
	Wed,  3 Sep 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893578; cv=fail; b=tpkaGDlFHWWpqkmmBtaiZxJXEd4+oWM8IRRHXOnUFRXWCIqqbXOJ04KKP8+oK6ERKMFXs8D/mM/HH5Ztag6HHw+rBybS9YGkEccqjf6/xpxoOB8S4HPx+0uTPpgD9c0w3GbmtFYyJ/ypgd3Md3B/h5VJsStFbh8nq6oiPh/pdzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893578; c=relaxed/simple;
	bh=F0GIdNjrw1pszUYqQHZhwHgBvRp3BSFsL+1VFkTrHgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3liW3K68ywsfm9o2cBbuhYlgSajJIPL0IzcZIdGd4wfT6lB0r4ka3lA1i9XMDdZ2IVN7q3SO7BrKxxecDYe/OVsfDq64q/76vVYn+IkKExZ6K7qt8aASK+bvXz1Rf5F0kZg3H3/rrHy8nK3RS59MzeQBLPPL9TknMyA4j94fpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vGBQK0/y; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vGBQK0/y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttzFEQj87nLmlF3KRmw9tx+/uUdS2b+IFJuYkmPaM3nHRhqou/dQOPLIWCEugYXYAedgYdmK2nAZPNvCD1lhhxyfI202om+NRAZw6w5WIvehOeEIpOb98q8fV312HRehHe3lS3wE1eaXWUZZ01gPCQsk1ZkSQIe/HSNzDXSqAnTAVSpN9Pqmpgop1fCU4IMX3wQyvoNQsXYwazWgUbjS2ZYG5MLVHSgMdX0RC7JQvz4Yh568tynDjSszApcR1TV37ayFbZDWr9ykBP/ydBANIU5pN9caagkEZ+XS9mWLlIROLWacMoVG5KQhg2UH9fq+ylEGfddT+BZ6rxUojdR38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30/eO+iSluJxvBAfk+blz++Sd0iNX9DcTlPoC9MhYpc=;
 b=ghnvtnBdIepwB0MhqyRVWFdF2M6TUxW9AhotKE3LPtSou9RYV1/5fXh1nTBTkcQKBDbg/j9etyCp1MUIFH3meSafH8FZPkdnZbEc2jPa5wu0GKRsBOIUbLMmHs5ReYyJLt4X5RbrjxAEd2AA73A536avGLE60+SEnlR3to8stmIrnyh8z8ZU/0a1gpRs8AUbVjHk1lUa3gR+LRUpojJZZgpSFwWaKaAGlQB1hHaXXKkk/SfkaCKqu28TPd2iMBePVjeOmPGVhnqGGyl3BPAUUOsT2vsUqjCHXMlHXlpTF1SRDPlGzPMM2FxVZYWbuEWdDZAqfoL7E78dmw3a6Nm2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30/eO+iSluJxvBAfk+blz++Sd0iNX9DcTlPoC9MhYpc=;
 b=vGBQK0/yQ6K4v6V9JVftzJ2mSoxxQRB095IeEbJCsxBK8BjBwreks1tidsWV1pW9bv68aZfX2fdjAZAXNkjfI6Ek5TLEb6NHnrJMTsPkO6v+QgI84XfPm5rNYTElpKNySa2m8l+EbL9342fnyyjCyYW8l9QpcgAKHylG5vtvJ+o=
Received: from MW4PR04CA0376.namprd04.prod.outlook.com (2603:10b6:303:81::21)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:59:30 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::45) by MW4PR04CA0376.outlook.office365.com
 (2603:10b6:303:81::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 09:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 3 Sep 2025 09:59:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 04:59:25 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Sep 2025 04:59:21 -0500
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
Subject: [PATCH V3 1/2] dt-bindings: i3c: Add AMD I3C master controller support
Date: Wed, 3 Sep 2025 15:29:05 +0530
Message-ID: <20250903095906.3260804-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903095906.3260804-1-manikanta.guntupalli@amd.com>
References: <20250903095906.3260804-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4dcd4c-002a-43d9-22d2-08ddead092e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vgK9deEU/hCJgzUlRnUHE2rAt+4Rg781arfTr/TQNiNqBDCi4bbY5za2QZu/?=
 =?us-ascii?Q?73r23n2f7zmuD3bxOCVUeuLaQMc1GQAqrpJ2BhoDECKDfvoRxH/++r0/ysLZ?=
 =?us-ascii?Q?jB1ez2gveK5Tc3GhsemvDQ/FNGSkH18jSrEkie3ZKFB46yHfnb03LuhHSsrQ?=
 =?us-ascii?Q?fJuqLwOOE9N7ejgkwKQQJjDxlLJoq9kGFG4kC/VOPPNqzpVUZsYbMPUyqS+a?=
 =?us-ascii?Q?yHhViiB9fxStlfLK1gX+dnx3fzTlx70oNz//7WgPXxWbeYcgfYrsOpSw+1Bd?=
 =?us-ascii?Q?BBLkBSPo4f29C3lHGGtORiTO7stcLynRJP0nmTdeql7/XRZ+qcGfLzajIGip?=
 =?us-ascii?Q?Q7Kd67OPmpr/Z2JJtYxPzRagCvn7bvlac4fsWxVvhJyx+pKtooICmY9jsWTe?=
 =?us-ascii?Q?nTEq/FbnlPVYAl/qm+buV1T+9EMb99WX5JwUTZuszpUUf6TYWF7Fq5z6OUlA?=
 =?us-ascii?Q?k7W6L2vY3ac7QVsydcAIopxo0FpCdDTuDu9KtSqJ6iwrRx3sTofjzRJ/o8H2?=
 =?us-ascii?Q?UlpjIqVDycQRazxNCv7e8IQ6YEzKZ34MUugyLj+TNc5AyKSZAkPFSifjVLfS?=
 =?us-ascii?Q?cf6DJVBMHGlHqowD42Mj9rd7aex/VJG9L4m1bhUaWr4+uGEnxzz6fPTo+Ich?=
 =?us-ascii?Q?soS2uWNpHiBG/MUJy0TgpgTSxSBFLnjIRFFKjfd1n0MeKqTQ3Ffm/p0SNaOI?=
 =?us-ascii?Q?OZehGr3D5j9NT72m65zw2ACQ25eGalWOm4skDo54+R5tx4UNz6mO58oifU7x?=
 =?us-ascii?Q?dqaSRW4AX7zkSgu70cSHxOWrVbUvxiyTlXQDIZq/FSwAZiCDHOs2K4OpJEQY?=
 =?us-ascii?Q?1FXYiQEytn0RUi5YPex0l25kgAXKgwhDOwv1ViF8D7wVQIVYT7KQRRelXA8l?=
 =?us-ascii?Q?IMYycnuk28QcySybr0wHyU8/fMnSD4MbV7xeqJs+T9nmGyjpcXehG2ULg+DD?=
 =?us-ascii?Q?EZxQtpXiLkB0vPNZsFtbNfs7pBlH44pMtBK9/bPW3EkjeX5v91Z5rOkF7WN8?=
 =?us-ascii?Q?hWdPTmi9JiDwVJkFV8SGF1b2ZhPhFnCjCGeUJpe4aBU/0BAIWUD2nV2vt6UI?=
 =?us-ascii?Q?C56mIGPyRR2ubwL+iyW8sxaUnrtf6aaLtTPCJmzfk7e3nSLd0g8kJN8kuv/h?=
 =?us-ascii?Q?br/JjuKhYXboHc0uy3L6hXsIFwas5D7AJ1uZxIOu3lkvN5lBfuL8pFkuIdpb?=
 =?us-ascii?Q?lkst42QN+oQ0TLEC4CcMdOPn67L5cXsL89to0B1iOzDLlirafzxLunpxJvuE?=
 =?us-ascii?Q?92amfKwjvy1VqoRtYFovIp3J0rBo8C6y1VsKIthNuFMqMWli3S8Ez1hqyATc?=
 =?us-ascii?Q?SQagVZnEn7pdYda339UTPk1I99ZKNd/OzUkqycNHU8pDjsYWQ4h5V0Qe/VOm?=
 =?us-ascii?Q?om5Cm7evWbN/h9XsWIZJFqBgw5hiOqo71lSFBpfrzvVUtn1dMsTZMI0L5WNM?=
 =?us-ascii?Q?Vp/OOvf2ib4uuO9o63QAg7ibp/4yA5Y2sXEFnXpWnyuhFifChpjXDUzU4k/I?=
 =?us-ascii?Q?xNdWVqmoIbhjH9E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:59:29.3386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4dcd4c-002a-43d9-22d2-08ddead092e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636

Add device tree binding documentation for the AMD I3C master controller.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Updated commit subject and description.
Moved allOf to after required.
Removed xlnx,num-targets property.

Changes for V3:
Updated commit description.
Corrected the order of properties and removed resets property.
Added compatible to required list.
Added interrupts to example.
---
 .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml

diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
new file mode 100644
index 000000000000..32f73c31121e
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
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
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
+        interrupt-parent = <&imux>;
+        interrupts = <0 89 4>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+    };
+...
-- 
2.34.1

