Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6328469B;
	Wed, 10 Sep 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503841; cv=fail; b=Fi/S1Z6kSt8t2FEXkbJK57ZfWVaylSOp0yVY1dDjGJrrx/BOz2JNvvDNVARgso4SkiyMqTFk1hn0paYTmAbABYTs+63r9BQwmDPCDZIkyBIuI4NlOQ5lR/VGsnbtxbQxicARQ6KUSKRDliqu2B35jhPZdpu/WcRR1QG03uh0CcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503841; c=relaxed/simple;
	bh=eVGJgjjm+Ubj2rAcaqNduaNGWpk4zbWHgQqkaTl6J10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmwnT9iq5rid2rkf3gfa4FqrJrI6qACyNrjJr2ERIy3kkS1RSSjLIz9UBjxepBqXpIUkiDdDZp3+nYa1lRYGDQoHOHQiReOPoeYoykxBKScUJcXXgfZ0K/T5AQftzgkRZoNx4/IjfRL/m40ESbblUODryq+3kU/EjbgN8ZPw6xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ut51YwuP; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ut51YwuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJtaA/sM4gxhufqOX+aLXJkFDSwmBk1f6SkAWEaTH4Afs56jbO7fbnmKocqY4xmE/8V3UZZV/JaCJHsA08vdoneIr8OQXHZ0mh5cBTWpVknyD69gSq6dDnW/9ucz9ItShMOB37qtWkW+0Lp/oJUT+3Hkn1gW2XES5FrKYGThjC+lNaB5plwe2jIopClKY9hHbnGnQDa+qt/7s12EtQ4AHqHcI0mnU3K3O0ZAX+CBHlg/jh/cdFgnBQWGn2toeqLztS9c/IHmbT1/sQ+cezv4l+FUPHi1D+g2eZaaQkZnWVTWaooanK8RQVu5RWfPfXa+ADf9Ab5LCIFX6NygcNs3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AYIxsFZKNOYp1oT1OR2cbsRad2Yl9etKwp79q7SJ3c=;
 b=UUfSNzBYKqkCkBOa6gQRW7Cte2qYMoKfZ1L9/FcJr7K0xPQ8pcbU3xG0ahQjEz3VWMZkLL9uQWupI3yW8+Ia1m0ZFq/DfdvxY5kZ2Z55g7GqCEufMCEV4YWbPd5yXEo2iV86ZlNrClFG9XjuPUELgq5287GP1IGtO7U9ZiDiiPwpx7ho5LECDvAnmkKMT8FropndOfYh2DLuSb/bLzgO80GAdfPhzYpKLI0YoRL5hUAK2zhuqY1ObGOoxpx4QZFXAq/0rp9xe1YtBrvCbuBzAQLEgeMazivCOORJJW1yc4h/huVAz8JN5490TEJ8HpeXGbd/cbfk4DD2hr5PosBpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AYIxsFZKNOYp1oT1OR2cbsRad2Yl9etKwp79q7SJ3c=;
 b=Ut51YwuPWYw/cOkUo0i07kPrIHhusJ0dabBZsTs6fhx91z+XqurXsW+JZBwn4ejazjNqDn3NWOVJbK2nlA7+DAypOfHxkOOilngcMkV7220uhVk5zQZxU3mXvhoKxskKTJFHKnnzl/emyX9Z4p7boy66GEKEI2OHAmn23VrjgHo=
Received: from MN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:52f::26)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:30:35 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::b0) by MN0PR03CA0006.outlook.office365.com
 (2603:10b6:208:52f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 11:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:30:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:30:21 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 04:30:15 -0700
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
Subject: [PATCH V6 1/2] dt-bindings: i3c: Add AMD I3C master controller support
Date: Wed, 10 Sep 2025 16:59:53 +0530
Message-ID: <20250910112954.553353-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
References: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: a189542c-adf0-47cf-77d8-08ddf05d71c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KA5iYByUJ92D3LoQxs+Q/7IYuFHDmGbsXuE8rZzvh0iZEvxC82TbnQQA5IH1?=
 =?us-ascii?Q?5/IASVjr7O0MyKZXTJxrzsjt81lLQH1C7b7TBp2Dod5kxehVcF1x7XiP3KpC?=
 =?us-ascii?Q?MXD/022smmSE5dJkDj60brHqHWQk63RKLhMApYds83URLJTamId0s/i5q9I8?=
 =?us-ascii?Q?NnNU3zjOgWZUStcA5dxdJHnMXVaXroKWCAukZ58NH/zgtKEbd4P+fvCHmuoj?=
 =?us-ascii?Q?zTCt2YTERZayYAlBre4SFSWDBFQ/m8FdEYRA7EmW4raa6A70MfzfqZMzE2xS?=
 =?us-ascii?Q?TNjYuP0c4NyLUbTPo3nmwNXOY3loNAyUUksj4zkUInNWSet//7D/8Zwhydwo?=
 =?us-ascii?Q?WvfGXXpX8jb0PGMwBrYySbmEtxzL8ihs2smcPxDeNivJcJCAZVuhjt3mE0oH?=
 =?us-ascii?Q?jnagvArjHsP8JNgXH+kT78X8MyYo5P2w57VXKi8eGx8OH7I2NoQR9sZG1De3?=
 =?us-ascii?Q?wVRL25pMmRhU1TPd1P+7l7sWrTZ665LTFcZjhIftP9Nn/Bcg/vIZcmjoTD8l?=
 =?us-ascii?Q?IlrXK+BzkW1YHRCVe79kplN07+N2QRWHbuO7kPgwW9g3MjmgMUCFmKNmHPkX?=
 =?us-ascii?Q?YWSsotUx5u2DJF+0i4iSK1bqGM4Bolw93Pv5zIsIWIvDEzPlhwRDG2YyRbMm?=
 =?us-ascii?Q?IQB/QVgF0CAqGEfKl4ymGU1nwnwqumWNLqzbKBDwAexToPhJ5R8YhDLYKlRY?=
 =?us-ascii?Q?JXYDfhtFOOWvmGzKKTCnTkZF/wB9MVEI2iMAzNAOTZrQrvagPRnmX+DbSaPS?=
 =?us-ascii?Q?7J1PTNdRv0Dbm3CXBSyJqP71lp8a1qwgeO3Wqhwa41/8HLHp4rVFsRZjLr/p?=
 =?us-ascii?Q?ggpleywyq79B75og2Y8mmcr10ZzBaKVNdMsxdpMam0iKeQ6A+ZYBe/jxlJBI?=
 =?us-ascii?Q?PrFt0dbV564ObuMDd8Zg0sDTMagEE7qkeGTSXlJTM9lEcGdnVTQ+jZ4goEO4?=
 =?us-ascii?Q?pP0Nkngq5BUAuhFwQJnzcTz4dO9tgnvHHchgOfIz0aIe5YNxIf3gQ/Qlbs5P?=
 =?us-ascii?Q?MdF4iN4ffndTuLVGAKlUOa0ZKgJr2bXXeQy97kImZJjGRYryKVFt+5xa9ZDA?=
 =?us-ascii?Q?7Ggeic9AKlfnc8njSrw5kPXm++yJ/jC+7BYG4xId54rgaXa9oYGci+ZOo/gt?=
 =?us-ascii?Q?Feaa6+QKScQV3WFPjrhLAifclbEryZ6Y43Jpq3iRt3/6DZpG2S9Ik6Z62TES?=
 =?us-ascii?Q?nqqcwMDoPOuSzSaDg0Ff3WhhCU+Usa8gV9YIuINSKwu/RAYjeQHIIv/Ezv6u?=
 =?us-ascii?Q?W20CT1uzSQWMWkYHaT0YzFAHP23UJt09kB0g30G3E0iXsGIb2zcJ86KihTnX?=
 =?us-ascii?Q?8nmaOmqv1Pcub+z33lCZZV5aAAS4PMgJg19xPuPlGOmBWAHOJ3wuaZtqCeEq?=
 =?us-ascii?Q?fyyPMLkozKGGCbnDsc+mXJzMTQsfofjWwfhmcxUZ9dwmO5X/Uhd4o6bZKcBN?=
 =?us-ascii?Q?g8m06ipg+xbmnpYTL8CIF2jET6LUndhKhqbmcFbNg5frDNa7mEzHqCQ1O7pN?=
 =?us-ascii?Q?QUPrE6hiRfDiw4M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:30:28.7124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a189542c-adf0-47cf-77d8-08ddf05d71c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

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

Changes for V6:
Corrected the file name for $id in yaml to fix the dtschema warning.
---
 .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml

diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
new file mode 100644
index 000000000000..17c63807dbcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c-1.0.yaml#
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

