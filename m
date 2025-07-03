Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB31FBCAE;
	Thu,  3 Jul 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541295; cv=fail; b=lGa4KqWu5LK0Jeu323S7Fnm+zoXfotAZXwWjTRXMpP4fII2JXeBpD8DxFa4NTURAe+sOnDek9UU4t/4PGJp6BV6iflbJ17PGchePeBASrA+SaWICWbhE46QAfobytFX1vqfjscE21YQ6UJdKdb3iNOY20DVtVJloWJFOl5+V4g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541295; c=relaxed/simple;
	bh=tFhR7xaidX32d5RzlK6LOX0CZoaCVfZhMo8vkHJpcvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rk/w4JNwGGupoyd86GkQd+KgwdA9zy/X4PcAVnZJ1UhyGNxzjtkGXpq7Bo50cXGYAS1qiDUXwXYeU0SfynODuLiqtAVU9fjFaUaau27ooDEMQHRJlLFQPeriO7TLAB3A0pl38fAYbF1iPWYAOifJzwqbPg/7c7VQ0NQ5kHrPgM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cE5pTUCh; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cE5pTUCh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB+b9Bz4U5J24pgmzsSbbtZwRovodKE8aYilbi/DGML5eKOpSI/TQH9tb4r90gfKCAgvPSC8mu1K166wglxS3Qm0QRDdsk7NUMQadm7vFiXaVoPchMNN+xn02Xe0EI6auZxOvgU/VyQ+b0LRfW0/jJ1GSdk/S7FEEswEfGNNvfo0q7LzUzOjesQvRXRlsg76dAvF2X2qaKR9bvNw79xSrjVZePeUW2oaLOcA8HhZuD0WAYfYPS9j9G5FU3fxOtWlsBjZtbE/B/BIDx/peYrgTNnSuAZFq3OWesTgLszdnpQEbbn01VUA3dDtFDnMd3u5UB92exr7B6jb3H7l4XMSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG6mGqEh0zDgklZmukIEmNSmBgnMU3tAj4BGOSOcJJU=;
 b=roPXaOc/hldCx2YUngihV9SwB43fJi+yo0FSFGbwKc94YRlvU/zC7PxAawBQ9bB0qQipKXS47XYG0TL64YDean+vmhVE8mcSrkDCSnkJRcBdjLgGTdTPlyHZBq5A8VV23M3INvenOp+45t5t9KLsOScqWd6n0CgDb9bVHplYnWTYSGXqnNWCRwxb/rp7PdGjgB3vcmVQZviDViQXChwBnoWDxlQgJe71rFHcg2kIgx0X8f4oHHhF9SKkaAwHdcUOQXuSu1G2sgB2CQgHTEQuRcWfGCNobceQzBQFhcmFe7eQ4a+ODQnFHjPhZkeOXfhH7uHoGUeciqiCgj5lkra3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG6mGqEh0zDgklZmukIEmNSmBgnMU3tAj4BGOSOcJJU=;
 b=cE5pTUChygTDt9/3gefxUfHkgPMKBxiTLYpJj5B9WTFnL8tmlsugPsA/vH2SP/xLaul1Zo35BLRx4v9XAz6IOyrX7lMHnik6fYtYWa14KmWSklTWQzOiUKWRXKgA+2MZLFpNOrVzVb+Cthzn0jx07JoK/ckYi3WV/ifa79m3tuE=
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 11:14:50 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::f3) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Thu,
 3 Jul 2025 11:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 11:14:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 06:14:45 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Jul 2025 06:14:40 -0500
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
Subject: [PATCH 1/2] dt-bindings: i3c: Add binding for AMD I3C master controller
Date: Thu, 3 Jul 2025 16:44:27 +0530
Message-ID: <20250703111428.2111484-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703111428.2111484-1-manikanta.guntupalli@amd.com>
References: <20250703111428.2111484-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 96137d99-db84-413d-a873-08ddba22d391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fohsjOoZwVnEJ0G9On4Am2vBSsbMyBNo7JVxMSIJcP2VtU3ugfCzusiBiT5n?=
 =?us-ascii?Q?Je1cvjpz2TDT1J58F2cU5VMDItAat3WS1ksg9YnUeVHUAfkjKPTvf4csdEGV?=
 =?us-ascii?Q?HyE7KG0p6fAjWzdmEUyvnyTF/OZF6qG6BZgUE0bnpNHErAAKfcEkPvltkDJm?=
 =?us-ascii?Q?WtvC5sUHBM5kr1wOq85y7JsV81nNC064pOk8VBuiiU8KZd+UELVAoMCwR2yj?=
 =?us-ascii?Q?rO77fNo/Jy5CCApFD9AomAf83m6wlHweWIhQVmUO28LZnqr+Mvw6Qwoq3bmk?=
 =?us-ascii?Q?fHMShi2/Xyyb49UiiaRooQYeeN7U9GTUysf7CKR12SqoJ15JqOwwzPzqFzT1?=
 =?us-ascii?Q?rnZeTe+9BAhh1ZGBC1lvvFJ9WGP7+T09ukIpFr4V038mfeynhirwD0QGRBCz?=
 =?us-ascii?Q?7ewtU48uM8NGrcJe9FLXS7UghjwN3jajwAbPgGXkwKqC8wnvTt1hmLSkHsDk?=
 =?us-ascii?Q?HWfmgEN17ZiBwvEQH/631xWbY1Ht/eyyQS3+GxuQzrDXsIOwJyoX/wh1qE1P?=
 =?us-ascii?Q?fGJe4hztr2+KNpc9KiNQ1oAGauC/YPerCVQeOkOjupTn029ZnduM639lVl/A?=
 =?us-ascii?Q?Swov29HUars6FfeVQq52wLOeOgM/PATzoTG+wsMcEXdGXn5RffWUPxnfoxb4?=
 =?us-ascii?Q?KtsV3qpCauyykH8RHmLoxCgovOutwjs8qGlS8GJD2xc8sT6TYioP0xt8T5wO?=
 =?us-ascii?Q?2w0EKDKZ3hYsXyf9xslBlBDNKYQMrKx2J7q6UKztj2wAHv5GUmdBYnenkdRM?=
 =?us-ascii?Q?ZbwccPYfrUHmgRPVUpUaRFGnP/Lo//ncJkoo6cnx/FvCrU/lv7hsWXPklCiY?=
 =?us-ascii?Q?5iOS4H2yudQBToYacjlU6tDITzt1z2DpQRNw858wRwcFMOwermOjPNYbIH+c?=
 =?us-ascii?Q?2afA+UvONsJL7szEML8YUg0NSMAqD05QqDigHqq6/rms3zbUW3SHO+CeeJzG?=
 =?us-ascii?Q?B5O3oTxXtJLyWymti6RBfbkCsK7bCf8jmEtaZHkdUTXDbyigSTxGLFLxoj5d?=
 =?us-ascii?Q?fBxln2oo9beEHOGOPZDF116lJh9hRY3QEUjciPUoR3xKEpXPwDmt95SNRyaZ?=
 =?us-ascii?Q?1RokGx1lDxagIPj3uzTQJRuq9j++o18A6Ws+bOg5I2jvNzi8wcGiqZ70Q+VJ?=
 =?us-ascii?Q?O4e7sZSk9B1RDLsBjuc/LwWNDSa7XtoF5493EDYesTQeFcws8VeGrVW2FKQ6?=
 =?us-ascii?Q?hH3d9tHsn4STgKbgblMzqVWXkn/60MaX9JEAL2MLU6W/WA88VNqUsjLZyZ4l?=
 =?us-ascii?Q?wLLKSfI3rozI23GUQ8npcHOB84TB6HE57006utUl67ekHqbK+r11ubze/HuW?=
 =?us-ascii?Q?GlDi5FYcLSwrhPmXg6TTF2uTB1gWcWhOnNhEqe+h080wXXxS3u+w29ybSWgp?=
 =?us-ascii?Q?NPzRt0n6FYHemcGAQeNxlE3QEpV59eO4tiLitScVOHojY0gFmkiLotnQc1QF?=
 =?us-ascii?Q?OW3L75TLczFRpG6JoEN+dxntu06h2nS5tSFog2mP5qicNtGFGMonD5yVX21e?=
 =?us-ascii?Q?lFD+Ei4twuN9Lfc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:14:49.6275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96137d99-db84-413d-a873-08ddba22d391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

Add device tree binding documentation for the AMD I3C master controller.

The controller is represented by the compatible string "xlnx,axi-i3c-1.0".
The binding specifies required properties including register space, clock,
resets, interrupts and number of i3c target devices, and provides
an example usage.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml

diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
new file mode 100644
index 000000000000..d4ad3721096f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
@@ -0,0 +1,61 @@
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
+allOf:
+  - $ref: i3c.yaml#
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
+  xlnx,num-targets:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of i3c target devices connected on the bus.
+    minimum: 1
+    maximum: 32
+    default: 1
+
+required:
+  - reg
+  - clocks
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

