Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1223469E9;
	Fri,  5 Sep 2025 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072293; cv=fail; b=fGKvD4xkWx90s73kcpaDK/w+1AqeZzG+CYVZgPo7U47OpYp0oy8fhtV57PzluBEakQRDTEa+8l+59n759w4b9XWABW9aELMhmZ8frw1W118CK0pcYSqF2dLw6wXOhpiN/io6x7+w7wObIQBDV5OlkIB0zRLmm9D5XDOng1e07Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072293; c=relaxed/simple;
	bh=NIHH8GtPZEOqxjMuL1rjkuDJZRe14Pcz8mFma//aFFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MItrHFKRBJCBGq9RqZqIvqRg66TmimTSGh52ozdBmEYrI+irwgEHZXMppjRHU8VGus11ICqUnNp48QiLPIgqklNbMU1JKKJX5QhpUnjNCm/tq5ZhmgrFAIFD+u2RxL6yF25MuVey4COCK5a/0Rav63xCUfRSuUC3JcfnN2EodXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdOZAaeE; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdOZAaeE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMto6vX1lai+gNcpA95+HTnwEdA2ItJtcYRp5jtS7iFy6n7BKpixcP6Gk6fuB2Jzor4gPxCI9oGFs7zZ1pDdRxGvc1zffwGAOF+L9phIXqyCc1RVRIMMjZkoBb7F2Z+G4ZvWfamyPPLcpUh+w8kHvO+LzYKs9CQl5J38ZjeoIF6Pi1iEfzA07DYjmJBfeyJ4tcVId2Hl/rSeaZnB7MI4F5+dddUcnNJOuFCqiK6aa28R81cY+BhPRKyKeUlTnMZ2RfZJcX1zH7fUnZ2Atx+V3Dd1VUtQ5HfpeHs+keTM6sVRxa/uYObVZJKhvkNpNgRQPCgcp+SlkKJcX0+V+37ZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqVvu4uuZEY4dxreFsMChgZgYXwn5LJkyVysPwcwQOc=;
 b=oYrAeFkENH6XWr2q5DPHtPXpCheIxrk7hJdWqOzuDMRJnCXQmvzmtechzC37hYfVfCtXo4FuSQ2JkvqsT67t33Sasuz5BN4fDKRMu7p4abSRVE5O/WCK6jpwCvPoh2KZp+qQ+N+A48vh5U3Jo6CFd+7rJCv1yU4d+R00f4o6C++DzrNGGhCKecPI0a44lWiM3h60A8HMNpwLI/+p1NyZBd0BPS3UCUlOK7va98GbT0a/6fxxmEyl9JawcSVOnbU3Auz0AaJHHkXymCqhmqkQtNtYQaM1F/G/7SkIMxoKLI32ANal8c1BadRG2Y9/LMYnuyRgTucGF5Zt7VGsA0zdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqVvu4uuZEY4dxreFsMChgZgYXwn5LJkyVysPwcwQOc=;
 b=LdOZAaeEKeQ1exkpG1He1J4MJCYEzoTP7BozCAJ4GoSCljKajagMzZUFHcNBjmDBt2QxSX8TkVlsx+OtbH7GbzpBbeFOTUv6d7kp/UurQES8NJdZmJQz9o2z76V+LEjZDWOP9pggbWuMlbKEELNBb73FG9uA23ZqJewYE9xhByQ=
Received: from BYAPR07CA0089.namprd07.prod.outlook.com (2603:10b6:a03:12b::30)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 11:38:06 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::bc) by BYAPR07CA0089.outlook.office365.com
 (2603:10b6:a03:12b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 11:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 11:38:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 06:37:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 06:37:54 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 06:37:49 -0500
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
Subject: [PATCH V4 1/2] dt-bindings: i3c: Add AMD I3C master controller support
Date: Fri, 5 Sep 2025 17:07:39 +0530
Message-ID: <20250905113740.3841181-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905113740.3841181-1-manikanta.guntupalli@amd.com>
References: <20250905113740.3841181-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2af7a7-1ef1-4470-359c-08ddec70ae40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/xhTnF7MjoqDXzwwntNAyLie+vNvQq8cwoKnwU1Ks53Q0lDLWXTKSlvBueLR?=
 =?us-ascii?Q?RnfgmP7mAFTOQ5uB/t3Klh04AbRWevG26KtUM+ictXuGNFaNkSKGqksBhUHU?=
 =?us-ascii?Q?Ev+2s2AyrVuIB1hFVXWvNdG9qbiGsP91oNMyXHOfm5i7S6sLhH/TNQtYAK6J?=
 =?us-ascii?Q?svxuorOgNp3z9O/0iU4uKszfhUaRKvtdvHguLnhIMHRAQk+EwQRFGctHZLK2?=
 =?us-ascii?Q?Dydz5xzaJS+/lroabAjIjAIl4EoOGH9zbkGlYAUb721fii3aZSeJdZdYZnts?=
 =?us-ascii?Q?oaY2WTN7aFvJn9Uwc3FPq2Jmy+bLPyASgfu2BBXFkj2nylnie1tGfgr4xuA+?=
 =?us-ascii?Q?kg6e6RkHT8QX99syZX2BRMRudGekCBh1K7a1EMs2F470eWXd6NTb8fKVKwi0?=
 =?us-ascii?Q?7hQviUwGrJVqvuFWSG1yPQukYAbCmAkSuhORiM2KhPw0JV+QZj+98IEguRUO?=
 =?us-ascii?Q?9pNaswDbW/EpzYcmH8aqgUbgQcJRit2jWJ2VnrCo30UCFBRU3446ohgHeNjp?=
 =?us-ascii?Q?9Sb4vJtnKAr/Tz8sKwYGB402b7Oro2raqPYFbxYJrRqaWdl6ZpA/cyioVfVS?=
 =?us-ascii?Q?mhejkHQ3bXgAdwRUALGsluorqKP2vYzhgZzXNFIozeu+ANRyzE+9A0KIguAH?=
 =?us-ascii?Q?9o83y/qJipFAaswRKnVEjv0Y2KSkFOsbWWh/w3lgeVNi/aPjjca3PqoUZzM0?=
 =?us-ascii?Q?gbLGwC309Q/p7dMvnj+n7JL8NmVzcuevF1rWKq/JWL+oYkAu63+mCNRwwzCc?=
 =?us-ascii?Q?Von/AYL9lGJqkTuRmAogy5qiUK6QKLSXnGugr1gvS2ZxzakaKy60EwAnEXp5?=
 =?us-ascii?Q?Uzg3Oi7vvSuU7xAFhWvg1lLRL/VBL2h6nQDILNTAnHuwZAcIPaind6/RsS+h?=
 =?us-ascii?Q?opdS2urYMXh+mvDspGz4ftH5uZ3gqfJxCr9Oq7W9OgeWstY+o60B86JMw/d5?=
 =?us-ascii?Q?JxXf4Y/RyxcdNN6WL/DBBC6EmDpBMNudoYg0rp4TbvO15EjoO/ZUDbs1jGzC?=
 =?us-ascii?Q?iuZRic3I6YMcX4s4MBjvZrlITT2lc8Ex/fOp17TGrK0EVjW6u/26Rdt9/Wk1?=
 =?us-ascii?Q?njb+BvD1RJVUqbxW+M9aZS3+nPESEFtEdJ1714H09uwvPjIqRU0x0k2KhIlX?=
 =?us-ascii?Q?5wUoTBEIsW/OKo/dmxnKXEh2q5QprPSI/YAOev12phTP43NB9S/27qqi/7R2?=
 =?us-ascii?Q?rl/Q9Y/XON8HYkOzl3c9mPGsrraZn9zuYINctiFZYmaUluSUSIzAgOi5daZY?=
 =?us-ascii?Q?b9Gvgc8DIh9rCAsM+3WkwvIILSaL/jBgvDnfbIy54WCOkzNiS9P7gQn+XcZD?=
 =?us-ascii?Q?A7DYPzwcZ3YAnxoskMJdlWoJj3IO9AW0qnV6c2Bg2eL7pDB/mZvD2H7N/3X2?=
 =?us-ascii?Q?lmHNmHtYSE63yewk9G8MDKub0gFTkfB1CivDRUAr0CeFbHBSCwQvv4/1ZZgc?=
 =?us-ascii?Q?iit1DwYenUx+36KxaWBM7JkjHavgxiwh5geCjJ78VPDbIViTTpxebcSDEcJu?=
 =?us-ascii?Q?8h1sqCKlKRNTM4E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 11:38:05.9069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2af7a7-1ef1-4470-359c-08ddec70ae40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

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
---
 .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml

diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
new file mode 100644
index 000000000000..1daeb20205ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
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

