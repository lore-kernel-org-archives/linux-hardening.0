Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58853F9FB;
	Mon,  8 Sep 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330508; cv=fail; b=rQcHu/esSXa06fYhflHIucJAa86vXfFM/926th9xFHEf4qn4npVlLoDoRniFBJcpNLuo/iQ6nPKGrjIf0tt8u/Ju1FmwLyyin6O4It5HvALJlDxeY+UIWJfeqKuLhBzYOsU00gloPmMkM6vLVN+qeqqqaPrUao+bnTjRGTVMFTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330508; c=relaxed/simple;
	bh=oEVIQfOX68W+7EctfbiwoXLllYU+iF4hr1kM1+tKq1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhoBw2rS10t+GcRZpYLjsvtRbO8PXQt+uq+1OCiRbDMXe2EgLqrTU8Zjaaz6eQbWL7G3E5EPOsjq7OfWTFL2nRLP8fJ8pMl4RVoDRu6oz3r9mOj+Iqe7CDVKL8moOtw0LQC0eSv/VYkFjH5j+idRSs8WrQn70oVacvgRBAPGraQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I+6es2s3; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I+6es2s3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjrPX5QKkFLn9qio2Z5zEkvlf7o/xovICkXj0pgUpWYm15phk2gRsGInVdcniv5cHezos9Ztb10oaB7cQufqUFmUcy+SxBNEENrt3nUGACztBFj5p/FN3JOxYzTkVnDJyxNqkJyQU98aykf4nGJ+vy3IuTnSf1RCNn2jIGK27wCIHTiykXCDEkaViERfgx5vrrJGXAcg+k/FJNW7hcTJ4Pk/jYzhTPjpKH+8lRywb+ynYp0F0961+MX5exZv9LXzuUDzI31MKrV5cnls28pi7vRGvSTDTGb7OmuqUvrxp8FkmeREY0AwS47okcUMYmB4DAcazVYTxJYA1+VESnO5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7sUF7S1fT/R7KQKG6WfD4DkDw6UEwhhKi6LaRhuH74=;
 b=knIyNJGsPcBsSNrdY1kRbbhc4S1GMFhv5GeG0KUcnTFlZcQTOXebubLtZuwXB6fYnMICsH1RxIo537BpLLi2K5OkFu+vfPx9MP/DH5wnZzcfK9Wzv9xsFlVw3R+sJe4aDHlCodJvqPVFMygtynjU5wMxsufqWZDe6JOwyT3jnpQFaH75SPLoUM3P1CXEOPSVdDmC4NyiZrGHm2Mnqfovqk+TsxqlCXaxyhZg07X0VL4RicrDjbpGwL3JhrNozLQeMc7thUjxLs61oXG9B8+100ydxOTNEonWXugWOvscJdHrkCH9J3hcw9aJazH1b3aTC7RWzSgUXdke4+8f2KZ23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7sUF7S1fT/R7KQKG6WfD4DkDw6UEwhhKi6LaRhuH74=;
 b=I+6es2s39W1NIrDpoN/kir3YcDm0/m8QG+SxSwvt/oqhjz+6em+yWW6ojb3sBxPw7l8NtNRPso+YPBBNRDakhxCbDLKBoGL26hQPkyqat8fU9qo2HxPE3pHtCYokOiw7Hl0DIj5p9O8t4cqLS2KEe05usHzrQJM2qBy27TBqQ5o=
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:21:44 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::82) by DS7PR06CA0004.outlook.office365.com
 (2603:10b6:8:2a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:21:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:21:38 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:21:37 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 04:21:30 -0700
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
Subject: [PATCH V5 1/2] dt-bindings: i3c: Add AMD I3C master controller support
Date: Mon, 8 Sep 2025 16:51:16 +0530
Message-ID: <20250908112117.205270-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908112117.205270-1-manikanta.guntupalli@amd.com>
References: <20250908112117.205270-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f743bb-292a-49d7-84d8-08ddeec9e433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LXd2ZBpw/WkOc9QoxFEpJX6Cb16t16WrrPGKLOk++WuwVZSOwQQXyM2Autpg?=
 =?us-ascii?Q?edtbTXXUozNKfk5d6ZQRy0/gXAIY0CzWaRS+0ifG1BUUrX1JNQYP2RrT79X+?=
 =?us-ascii?Q?iARddglbkyyZWJnI6EwjqCU9WdcLmMoZeFsZGLP0lWWL3FN19HGHfqn1vaXr?=
 =?us-ascii?Q?Wd3xXVt6z8Li3RTl1IgR9XanXQ8g+9oSOOAl234b/qamW1C2g3ejV1gxi08A?=
 =?us-ascii?Q?ODUn3wIs9gHpHgLMzXm2i4Pxz+6TVe8o2iTc2TeCeeOH2w4EZKvPbrP0tEte?=
 =?us-ascii?Q?1gQDJNR9pDQpeo+1XVpvOAO4J8yY2TGA7PLqx2Wj905riGQu1+R4syrQ56+k?=
 =?us-ascii?Q?H/cDQUgmhbmoZ0LM6jfxdEarlmqE0vNmJsiWT362O5L24R4YI9luGdMVvKyD?=
 =?us-ascii?Q?dR2Iku619Re17/3G4r6thEtpizIIm1bPBLV2udw79nN9Xa+bpjh1MEAyrb8I?=
 =?us-ascii?Q?cgrCrBlmS0YwF3xCcuXX0uxVVPNBKSwMACVmBrztRj9DQqpN3V/BqzGb+XSx?=
 =?us-ascii?Q?BABE8xd05u5eg0LdZMxxJvMSQSbLYNk0IAK9EkB9kBamZqlxiJpaf6tVMF5F?=
 =?us-ascii?Q?DP7eZzJTzZK62Di0QV9bOfBz2lWihqTg6DeS6bAU6f/8b5iQOzZ5WNsxe0/5?=
 =?us-ascii?Q?ggdKhqbP8j8UmR4hOXPS9XSXgdz69/XzzIiBLaXS+kC9PvEDZ5PufJ6yE2Hj?=
 =?us-ascii?Q?c0wcvFbToja8tiz8lG5jYVhfQIQXvsXDa+2sXlqkoMDHs424chVFMe35tFtw?=
 =?us-ascii?Q?5ObClZRdIRurDJOH0siWuEOudAjyvC6gdVzk0Ot/lFwp4WQ3OclWTY/OPTTv?=
 =?us-ascii?Q?zBuz3WRGS6WRyQsQuHnCt3HHgnXkPBfXJ3LRsgA80VWfAIc9CzepTLTDu/2c?=
 =?us-ascii?Q?n83lYxyNH19hqSltx/Z8rr0qTymPjXUuO2mxmYRvNtNKlWZYGI4ahN8HjNu4?=
 =?us-ascii?Q?2vxxoGGiQfZU5BUoZUouKhNC/OxqA9qt1gwxu6Ln8UpbEEmjBRhLKWOIdtKV?=
 =?us-ascii?Q?gmjOAv70fr5dOjxiXCwEFQot8embP58L3XrdN/I14mTGmpqGWbSjITb9T4dt?=
 =?us-ascii?Q?ycbLyklXv6CJsTMROYmSHd4s2cj4R85s3ff3tpnFATmPH6S2k9piqT/aA5dQ?=
 =?us-ascii?Q?8BlhII8zL0ZL7zI8ke0d4ndrR1XROmh0poSutyEszTcE3FW1WnA98pBI7huI?=
 =?us-ascii?Q?/u2UfgyAmV6WM4v5lTbYdZQCXYSi/Pcs08Jc0hzmllRD8TYQMa8q8t9cNmlN?=
 =?us-ascii?Q?1LQAcMoAgwzKG1YeazVdJhl8tLstpc6bh+L2ltp78FO7m2tmak7aiy9PBB2W?=
 =?us-ascii?Q?UXHwt4pB3r4On6/omtfHqTrTLutZFQSNKymud+lz13ULpMIBrihcyk7Q8b6a?=
 =?us-ascii?Q?2Az30t42xY7+99nb5dmyHljkCcQSoFbs3JWAlofOuzIxnajFnLVRpmGvO7+E?=
 =?us-ascii?Q?l1ekIZA1dLYl748P46JED2BH0yN1t+xg/gpU8KM99ND2NCtzATjlSBMmd2Zd?=
 =?us-ascii?Q?JZ8mxZKan5GcFlg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:21:44.0021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f743bb-292a-49d7-84d8-08ddeec9e433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429

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

Changes for V4:
Added h/w documentation details.

Changes for V5:
Renamed the xlnx,axi-i3c.yaml file into xlnx,axi-i3c-1.0.yaml.
---
 .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml

diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
new file mode 100644
index 000000000000..1daeb20205ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
@@ -0,0 +1,55 @@
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
+  For more details, please see https://docs.amd.com/r/en-US/pg439-axi-i3c
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

