Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED8291C19;
	Thu,  3 Jul 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541306; cv=fail; b=B55rn+llkyjjIHrKpowjeKVfu0lkUJrmH5+L6xIKSkBDbWXcy89osrt3xTsjEOOd/JW4rpCTYwaj5cgEU+M0Z4o/A9p+aUxchKJwTg75UphGnAWUuwJVMYr8aTYUJbeOsZVw4r2u8pmIlGOrBwhTDDs+WQEMHOFmXnc9Bh6EOxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541306; c=relaxed/simple;
	bh=rGh0nDl7t/3FOQAivRn/EprIQrQyZ2u6Q6mhQfOOhe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slSd+4WOaGbHdl8Vxk6WrBEGJz92puf210T8xVGKqH4QFpQl6rbyWsd8h6mNlKEOb2X5YjeRuPJZvrYjxbOrhw8DYr56P/8O500F3jjgLy5EFC38y8IVsabfYYlKE+fB0q36bwAzSmEOGWDLN/WOe/ijdwGuMvwJvUWeUrddytQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u8LR1vNE; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u8LR1vNE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJHlNL9o+91MZDm5baxIq5a5hbZnJiU1k7nV6MFt70OLE0GFt7auNTVYRzvg1fDsk27UiSU2UExOSiD7LPADZ+LXSc31WyMqSxNJlyOlsNah/nVgSQXmSLDROMU8LOdGBK5ldvMm8QCKHqGoR47xKw5sEcepEB7CjgGmU0R84yp293vbImnOaXEi1NtVTYRWCWXSnZm/NVnuX3MU59eg+KTPxVJm3Sv92EhVzaKUAmmzVvFIGjDqs+IQ7bIKAp47pHndBu/FALpik0p3ZiiRNQVb8VugwGx5etXYb9WqBqILApzg7ksoW4A5I2iaCz/5xsbPXfldZWY8GZ2dXS8Vfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWO5SaDHOcKXD2kqtrMhxBt33xknSLkePrto/3OqFHg=;
 b=p3PePv6kJGT13qH5fWXRDgvouHuYEcvu5FNEsvdghpuglai1Ii0TI/5uVXMO9ZX6AS262xfJ/zzTgtqdoiZIAEQl4NEoRSPZDk05UXpVMjZyY2TqWH8sgo29r0l1MPw9+Y8iQtbn54Urs9w5eaZcvtmq5rGd+rB9c5RfSlrSkIvIIepwdEoLFni9z6YgJb/zJ+S4HwGVhHk48nSoIQ42rVrGwbjarCWlUWEFmLboeXqQ3XJJCqcqWo/uhZASrVct88/mO7G22aCXGGNnK7w8CLr0RNQguxP1NVBanEun7ZoLxxeU/JtAKnj5ft/PRA+hhESvGFDp8mbkP5w/1hA9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWO5SaDHOcKXD2kqtrMhxBt33xknSLkePrto/3OqFHg=;
 b=u8LR1vNEURwtQ3YDxDTG0H5OqGtPVNVYaYf4/w8unWhfmDdsmNJlmkb2MYjgP977Z8b2+7KGih0lZyW67IlO2qKk/MwQqPZ3MLKSwFqOUIOkQAAPYwzRSxkwz5xer/0ipzFwm45gPuQFAejMTKAvzqNAECEGqdfOshAQfxAxBNQ=
Received: from MW4PR04CA0187.namprd04.prod.outlook.com (2603:10b6:303:86::12)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 11:14:56 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:303:86:cafe::28) by MW4PR04CA0187.outlook.office365.com
 (2603:10b6:303:86::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 11:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Thu, 3 Jul 2025 11:14:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 06:14:53 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Jul 2025 06:14:48 -0500
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
Subject: [PATCH 2/2] i3c: master: Add AMD I3C bus controller driver
Date: Thu, 3 Jul 2025 16:44:28 +0530
Message-ID: <20250703111428.2111484-3-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: c4aefd5a-8d62-4a1b-baf5-08ddba22d756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9U4mW0/znXeqTpadfKSwk4dfLsAcXFvi90jcTBtGsz8Jd4jZaQV5AD3PitJ?=
 =?us-ascii?Q?tiq9O14iC15bd5xo8sxXCF/geseaYZGMMXII7bx758s9bWugeczkop1mUS/O?=
 =?us-ascii?Q?dMowrpYpsU/MexB//neh54yhlUmh5hP4I8JGj7ZawrE7HiWF87TLWS+gPcFt?=
 =?us-ascii?Q?vU2eMOMV9UylOWnK5VdES/XQ00rnkomVZ4iJNCW9c9J5sE4UwR47ve7jKIIL?=
 =?us-ascii?Q?uoD8O9FGuKMbDU1BxXQw5f7uVXA0CKO88+Ute7+NFYnfc402boijaqN1/tvP?=
 =?us-ascii?Q?Mn4HLafbUJYDWf5pNVfLVx23h0Qf0H8ArkJp40shww13R7DwcAdpFUr9cDxi?=
 =?us-ascii?Q?OjACTl8ngFlFBtMHS9McL8o4cXOMW6JXendLBfQeEEWklaEzvJB4u8QCVuJN?=
 =?us-ascii?Q?cMCV5KH2jHG/OxSILoQ8Yy5ccUxKBUYglrI7/srpzEkVMY1f2ce+0JJ+zEbf?=
 =?us-ascii?Q?OWm7bGB+jcSmvKZw3VpV7WXI03ETZfo8lxTR5oYzwuxVTst7dhbv0c9jxCwR?=
 =?us-ascii?Q?jcjcdRodqaGTdM4zK/G3Hh44hvXdCqO6MJBPEMD5v8JqPZV2vpcBzjtEGt1h?=
 =?us-ascii?Q?MK8gU71Vx50ZSy93z6CxVHFyvNg993qpfB3KcTYxlZNe+KgvISqZ2KlhiO8D?=
 =?us-ascii?Q?jotC++9lYwggWpSfdR+HZP2dw2zJ0z2Y0qWhwSVuJCRyrq1RtlXTy1IEe9dd?=
 =?us-ascii?Q?CDvxeYn9wbsUyMVa/MSodi0fb+vk+v7kV6D6QoyM/aBrdk0/ee9Zf7lYp60d?=
 =?us-ascii?Q?LsjbVd53UaP3pfdecmdXcyax+rWf+30RcLnEYQlLDVrtUXHmaexGH26XVkBl?=
 =?us-ascii?Q?GQYr5vTvjcxLfuIbZaj24UomxSOpBbKTvW0P24sNhODj1GkiGdD2bQ6974XX?=
 =?us-ascii?Q?BciaRH9YYQooItwICaXWZo09PuxReZbhTN56cIiAcT4QW8C1+oo94hLwJgDG?=
 =?us-ascii?Q?3OgtlzDo8gKBcoDN/yTDrJ2oDI0fWMKfr8lshpXLdMMT1ZEcL8FWv7/B22j4?=
 =?us-ascii?Q?BC+urQWscc8xsitIFNn6em91klBl6PIx877ehz6wxv0pekZ14GvjKD4lOnQg?=
 =?us-ascii?Q?LUI06rUwVABR2ZiX3XqPGAUHritDcyvYSYbCFJDVUGR49zfc52b+ZGeOOz1q?=
 =?us-ascii?Q?RNqmhKMoFp+v01p/db/qgbLoAgz4kKhthnEMvdyDt4CxkMRrdPZg9yxf3pKv?=
 =?us-ascii?Q?9FA03jb3sWgJZ0d0ozUEry2F3MjYnFrfcsmWRmKI62jQNWBcKazHo67FPLXA?=
 =?us-ascii?Q?x8qLCsQpN65MFhlR3lZjVzYBJbPrboHXMe8R5KFuptEf1rnj8LYSFt/9qC4G?=
 =?us-ascii?Q?4i0+J0ZvSGV8Rn7zbZgMswsFmMKY3hpTkm2GkkXU8nCfgqwsDWTbs4z03H2k?=
 =?us-ascii?Q?kvFCB8Xnz4iV853nZAkaP3dvKzNelP5Wu1i1lBVyXO8EGsdUsAKg7XanfOOz?=
 =?us-ascii?Q?9/yIqjIEFNBbV32VRZTMqKLyotiIrTPYK3AvOV2bVBI6A+81QZfVxyXRbt5V?=
 =?us-ascii?Q?NapezQ2iETZrz8Q5eUbMIf/Lozynv0ZDQexOlZTqj/hfWVnwOVRApf3KLA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:14:55.9579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4aefd5a-8d62-4a1b-baf5-08ddba22d756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

Add an I3C master driver and maintainers fragment
for the AMD I3C bus controller.
The driver currently supports the I3C bus operating in
SDR pure i3c mode, with features including Dynamic Address
Assignment, private data transfers, and CCC transfers in both
broadcast and direct modes.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 MAINTAINERS                         |   7 +
 drivers/i3c/master/Kconfig          |  16 +
 drivers/i3c/master/Makefile         |   1 +
 drivers/i3c/master/amd-i3c-master.c | 945 ++++++++++++++++++++++++++++
 4 files changed, 969 insertions(+)
 create mode 100644 drivers/i3c/master/amd-i3c-master.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cb9e55021cb..28ee1554cb0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11416,6 +11416,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/i2c-stub.c
 
+I3C DRIVER FOR AMD AXI I3C MASTER
+M:	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
+R:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
+F:	drivers/i3c/master/amd-i3c-master.c
+
 I3C DRIVER FOR ASPEED AST2600
 M:	Jeremy Kerr <jk@codeconstruct.com.au>
 S:	Maintained
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index 77da199c7413..a77d288d2464 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -1,4 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config AMD_I3C_MASTER
+	tristate "AMD I3C Master driver"
+	depends on I3C
+	depends on HAS_IOMEM
+	help
+	  Support for AMD I3C Master Controller.
+
+	  This driver allows communication with I3C devices using the AMD
+	  I3C master, currently supporting Standard Data Rate (SDR) mode.
+	  Features include Dynamic Address Assignment, private transfers,
+	  and CCC transfers in both broadcast and direct modes.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called amd-i3c-master.
+
 config CDNS_I3C_MASTER
 	tristate "Cadence I3C master driver"
 	depends on I3C
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
index 3e97960160bc..c0167aa1f1b3 100644
--- a/drivers/i3c/master/Makefile
+++ b/drivers/i3c/master/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_AMD_I3C_MASTER)		+= amd-i3c-master.o
 obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
 obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
 obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
diff --git a/drivers/i3c/master/amd-i3c-master.c b/drivers/i3c/master/amd-i3c-master.c
new file mode 100644
index 000000000000..741aa854f925
--- /dev/null
+++ b/drivers/i3c/master/amd-i3c-master.c
@@ -0,0 +1,945 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I3C master driver for the AMD I3C controller.
+ *
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i3c/master.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#define XI3C_RESET_OFFSET			0x04	/* Soft Reset Register */
+#define XI3C_CR_OFFSET				0x08	/* Control Register */
+#define XI3C_ADDRESS_OFFSET			0x0C	/* Target Address Register */
+#define XI3C_SR_OFFSET				0x10	/* Status Register */
+#define XI3C_CMD_FIFO_OFFSET			0x20	/* I3C Command FIFO Register */
+#define XI3C_WR_FIFO_OFFSET			0x24	/* I3C Write Data FIFO Register */
+#define XI3C_RD_FIFO_OFFSET			0x28	/* I3C Read Data FIFO Register */
+#define XI3C_RESP_STATUS_FIFO_OFFSET		0x2C	/* I3C Response status FIFO Register */
+#define XI3C_FIFO_LVL_STATUS_OFFSET		0x30	/* I3C CMD & WR FIFO LVL Register */
+#define XI3C_FIFO_LVL_STATUS_1_OFFSET		0x34	/* I3C RESP & RD FIFO LVL Register */
+#define XI3C_PID0_OFFSET			0x6C	/* LSB 4 bytes of the PID */
+#define XI3C_PID1_BCR_DCR			0x70	/* MSB 2 bytes of the PID, BCR and DCR */
+
+#define XI3C_CR_EN_MASK				BIT(0)	/* Core Enable */
+#define XI3C_SR_RESP_NOT_EMPTY_MASK		BIT(4)	/* Resp Fifo not empty status */
+
+#define XI3C_RESP_CODE_SHIFT			5
+
+#define XI3C_BCR_MASK				GENMASK(23, 16)
+#define XI3C_DCR_MASK				GENMASK(31, 24)
+#define XI3C_PID_MASK				GENMASK(63, 16)
+#define XI3C_PID1_MASK				GENMASK(15, 0)
+#define XI3C_WR_FIFO_LEVEL_MASK			GENMASK(15, 0)
+#define XI3C_CMD_LEN_MASK			GENMASK(11, 0)
+#define XI3C_RESP_CODE_MASK			GENMASK(8, 5)
+#define XI3C_ADDR_MASK				GENMASK(6, 0)
+#define XI3C_CMD_TYPE_MASK			GENMASK(3, 0)
+#define XI3C_CMD_TID_MASK			GENMASK(3, 0)
+#define XI3C_FIFOS_RST_MASK			GENMASK(4, 1)
+
+#define XI3C_EVEN_PARITY_LUT			0x9669
+#define XI3C_MAXDATA_LENGTH			4095
+#define XI3C_MAX_DEVS				32
+#define XI3C_DAA_SLAVEINFO_READ_BYTECOUNT	8
+
+#define XI3C_I2C_MODE				0
+#define XI3C_I2C_TID				0
+#define XI3C_SDR_MODE				1
+#define XI3C_SDR_TID				1
+
+#define XI3C_WORD_LEN				4
+#define XI3C_PM_TIMEOUT_MS			1000
+
+/* timeout waiting for the controller finish transfers */
+#define XI3C_XFER_TIMEOUT			(msecs_to_jiffies(1000))
+#define XI3C_XFER_TIMEOUT_MS			1000
+
+#define xi3c_wrfifolevel(master)						\
+	((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_OFFSET) &		\
+	       XI3C_WR_FIFO_LEVEL_MASK))
+
+#define xi3c_rdfifolevel(master)						\
+	((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_1_OFFSET) &	\
+	       XI3C_WR_FIFO_LEVEL_MASK))
+
+struct xi3c_cmd {
+	void *tx_buf;
+	void *rx_buf;
+	u16 tx_len;
+	u16 rx_len;
+	u8 addr;
+	u8 type;
+	u8 tid;
+	bool rnw;
+	bool is_daa;
+	bool continued;
+};
+
+struct xi3c_xfer {
+	struct list_head node;
+	struct completion comp;
+	int ret;
+	unsigned int ncmds;
+	struct xi3c_cmd cmds[] __counted_by(ncmds);
+};
+
+/**
+ * struct xi3c_master - I3C Master structure
+ * @base: I3C master controller
+ * @dev: Pointer to device structure
+ * @xferqueue: Transfer queue structure
+ * @xferqueue.list: List member
+ * @xferqueue.cur: Current ongoing transfer
+ * @xferqueue.lock: Queue lock
+ * @membase: Memory base of the HW registers
+ * @pclk: Input clock
+ * @lock: Transfer lock
+ * @pid_bcr_dcr: Poniter to PID, BCR and DCR value
+ * @num_targets: Number of i3c target devices
+ * @addrs: Slave addresses array
+ */
+struct xi3c_master {
+	struct i3c_master_controller base;
+	struct device *dev;
+	struct {
+		struct list_head list;
+		struct xi3c_xfer *cur;
+		/* Queue lock */
+		struct mutex lock;
+	} xferqueue;
+	void __iomem *membase;
+	struct clk *pclk;
+	/* Transfer lock */
+	struct mutex lock;
+	u64 *pid_bcr_dcr;
+	u32 num_targets;
+	u8 addrs[] __counted_by(num_targets);
+};
+
+static inline struct xi3c_master *
+to_xi3c_master(struct i3c_master_controller *master)
+{
+	return container_of(master, struct xi3c_master, base);
+}
+
+static int xi3c_get_response(struct xi3c_master *master)
+{
+	int ret;
+	u32 resp_reg, response_data;
+
+	ret = readl_poll_timeout(master->membase + XI3C_SR_OFFSET,
+				 resp_reg,
+				 resp_reg & XI3C_SR_RESP_NOT_EMPTY_MASK,
+				 0, XI3C_XFER_TIMEOUT_MS);
+	if (ret) {
+		dev_err(master->dev, "AXI I3C response timeout\n");
+		return ret;
+	}
+
+	response_data = readl(master->membase + XI3C_RESP_STATUS_FIFO_OFFSET);
+
+	/* Return response code */
+	return (response_data & XI3C_RESP_CODE_MASK) >> XI3C_RESP_CODE_SHIFT;
+}
+
+static void xi3c_master_wr_to_tx_fifo(struct xi3c_master *master,
+				      struct xi3c_cmd *cmd)
+{
+	u8 *tx_buf = (u8 *)cmd->tx_buf;
+	u32 data = 0;
+	u16 len;
+
+	len = cmd->tx_len;
+	if (len > 0) {
+		len = (len >= XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
+		memcpy(&data, tx_buf, len);
+		tx_buf += len;
+		cmd->tx_len -= len;
+	}
+	cmd->tx_buf = tx_buf;
+
+	/* Write the 32-bit value to the Tx FIFO */
+	iowrite32be(data, master->membase + XI3C_WR_FIFO_OFFSET);
+}
+
+static void xi3c_master_rd_from_rx_fifo(struct xi3c_master *master,
+					struct xi3c_cmd *cmd)
+{
+	u8 *rx_buf = (u8 *)cmd->rx_buf;
+	u32 data;
+	u16 len;
+
+	/* Read from Rx FIFO */
+	data = ioread32be(master->membase + XI3C_RD_FIFO_OFFSET);
+
+	/* Data extraction to rx_buf */
+	len = cmd->rx_len;
+	if (len > 0) {
+		len = (len >= XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
+		memcpy(rx_buf, &data, len);
+		rx_buf += len;
+		cmd->rx_len -= len;
+	}
+	cmd->rx_buf = rx_buf;
+}
+
+static void xi3c_master_write_to_cmdfifo(struct xi3c_master *master,
+					 struct xi3c_cmd *cmd, u16 len)
+{
+	u32 transfer_cmd = 0;
+	u8 addr;
+
+	addr = ((cmd->addr & XI3C_ADDR_MASK) << 1) | (cmd->rnw & BIT(0));
+
+	transfer_cmd = cmd->type & XI3C_CMD_TYPE_MASK;
+	transfer_cmd |= (u32)(!cmd->continued) << 4;
+	transfer_cmd |= (u32)(addr) << 8;
+	transfer_cmd |= (u32)(cmd->tid & XI3C_CMD_TID_MASK) << 28;
+
+	/*
+	 * For dynamic addressing, an additional 1-byte length must be added
+	 * to the command FIFO to account for the address present in the TX FIFO
+	 */
+	if (cmd->is_daa) {
+		xi3c_master_wr_to_tx_fifo(master, cmd);
+
+		len++;
+		cmd->is_daa = false;
+	}
+
+	transfer_cmd |= (u32)(len & XI3C_CMD_LEN_MASK) << 16;
+	writel(transfer_cmd, master->membase + XI3C_CMD_FIFO_OFFSET);
+}
+
+static void xi3c_master_enable(struct xi3c_master *master)
+{
+	writel(readl(master->membase + XI3C_CR_OFFSET) | XI3C_CR_EN_MASK,
+	       master->membase + XI3C_CR_OFFSET);
+}
+
+static void xi3c_master_disable(struct xi3c_master *master)
+{
+	writel(readl(master->membase + XI3C_CR_OFFSET) & (~XI3C_CR_EN_MASK),
+	       master->membase + XI3C_CR_OFFSET);
+}
+
+static void xi3c_master_init(struct xi3c_master *master)
+{
+	u32 data;
+
+	/* Reset fifos */
+	data = readl(master->membase + XI3C_RESET_OFFSET);
+	data |= XI3C_FIFOS_RST_MASK;
+	writel(data, master->membase + XI3C_RESET_OFFSET);
+	usleep_range(1, 2);
+	data &= ~XI3C_FIFOS_RST_MASK;
+	writel(data, master->membase + XI3C_RESET_OFFSET);
+	usleep_range(1, 2);
+
+	/* Enable controller */
+	xi3c_master_enable(master);
+}
+
+static struct xi3c_xfer *
+xi3c_master_alloc_xfer(struct xi3c_master *master, unsigned int ncmds)
+{
+	struct xi3c_xfer *xfer;
+
+	xfer = kzalloc(struct_size(xfer, cmds, ncmds), GFP_KERNEL);
+	if (!xfer)
+		return NULL;
+
+	INIT_LIST_HEAD(&xfer->node);
+	xfer->ncmds = ncmds;
+	xfer->ret = -ETIMEDOUT;
+
+	return xfer;
+}
+
+static void xi3c_master_free_xfer(struct xi3c_xfer *xfer)
+{
+	kfree(xfer);
+}
+
+static u8 xi3c_even_parity(u8 p)
+{
+	p ^= p >> 4;
+	p &= 0xf;
+
+	return (XI3C_EVEN_PARITY_LUT >> p) & 1;
+}
+
+static int xi3c_master_read(struct xi3c_master *master, struct xi3c_cmd *cmd)
+{
+	unsigned long timeout;
+	u16 rx_data_available;
+	u16 data_index;
+
+	if (!cmd->rx_buf || cmd->rx_len > XI3C_MAXDATA_LENGTH)
+		return -EINVAL;
+
+	/* Fill command fifo */
+	xi3c_master_write_to_cmdfifo(master, cmd, cmd->rx_len);
+
+	timeout = jiffies + XI3C_XFER_TIMEOUT;
+	/* Read data from rx fifo */
+	while (cmd->rx_len > 0) {
+		if (time_after(jiffies, timeout)) {
+			dev_err(master->dev, "XI3C read timeout\n");
+			return -EIO;
+		}
+
+		rx_data_available = xi3c_rdfifolevel(master);
+		for (data_index = 0;
+		     data_index < rx_data_available && cmd->rx_len > 0;
+		     data_index++)
+			xi3c_master_rd_from_rx_fifo(master, cmd);
+	}
+	return 0;
+}
+
+static int xi3c_master_write(struct xi3c_master *master, struct xi3c_cmd *cmd)
+{
+	unsigned long timeout;
+	u16 wrfifo_space;
+	u16 space_index;
+	u16 len;
+
+	len = cmd->tx_len;
+	if (!cmd->tx_buf || cmd->tx_len > XI3C_MAXDATA_LENGTH)
+		return -EINVAL;
+
+	/* Fill Tx fifo */
+	wrfifo_space = xi3c_wrfifolevel(master);
+	for (space_index = 0; space_index < wrfifo_space && cmd->tx_len > 0;
+	     space_index++)
+		xi3c_master_wr_to_tx_fifo(master, cmd);
+
+	/* Write to command fifo */
+	xi3c_master_write_to_cmdfifo(master, cmd, len);
+
+	timeout = jiffies + XI3C_XFER_TIMEOUT;
+	/* Fill if any remaining data to tx fifo */
+	while (cmd->tx_len > 0) {
+		if (time_after(jiffies, timeout)) {
+			dev_err(master->dev, "XI3C write timeout\n");
+			return -EIO;
+		}
+
+		wrfifo_space = xi3c_wrfifolevel(master);
+		for (space_index = 0; space_index < wrfifo_space && cmd->tx_len > 0;
+		     space_index++)
+			xi3c_master_wr_to_tx_fifo(master, cmd);
+	}
+	return 0;
+}
+
+static int xi3c_master_xfer(struct xi3c_master *master, struct xi3c_cmd *cmd)
+{
+	int ret;
+
+	if (cmd->rnw)
+		ret = xi3c_master_read(master, cmd);
+	else
+		ret = xi3c_master_write(master, cmd);
+
+	if (ret < 0)
+		goto err_xfer_out;
+
+	if (xi3c_get_response(master))
+		goto err_xfer_out;
+
+	return 0;
+
+err_xfer_out:
+	xi3c_master_init(master);
+	return -EIO;
+}
+
+static void xi3c_master_dequeue_xfer_locked(struct xi3c_master *master,
+					    struct xi3c_xfer *xfer)
+{
+	if (master->xferqueue.cur == xfer)
+		master->xferqueue.cur = NULL;
+	else
+		list_del_init(&xfer->node);
+}
+
+static void xi3c_master_dequeue_xfer(struct xi3c_master *master,
+				     struct xi3c_xfer *xfer)
+{
+	mutex_lock(&master->xferqueue.lock);
+	xi3c_master_dequeue_xfer_locked(master, xfer);
+	mutex_unlock(&master->xferqueue.lock);
+}
+
+static void xi3c_master_start_xfer_locked(struct xi3c_master *master)
+{
+	struct xi3c_xfer *xfer = master->xferqueue.cur;
+	int ret = 0, i;
+
+	if (!xfer)
+		return;
+
+	for (i = 0; i < xfer->ncmds; i++) {
+		struct xi3c_cmd *cmd = &xfer->cmds[i];
+
+		ret = xi3c_master_xfer(master, cmd);
+		if (ret)
+			break;
+	}
+
+	xfer->ret = ret;
+	complete(&xfer->comp);
+
+	xfer = list_first_entry_or_null(&master->xferqueue.list,
+					struct xi3c_xfer,
+					node);
+	if (xfer)
+		list_del_init(&xfer->node);
+
+	master->xferqueue.cur = xfer;
+	xi3c_master_start_xfer_locked(master);
+}
+
+static void xi3c_master_enqueue_xfer(struct xi3c_master *master,
+				     struct xi3c_xfer *xfer)
+{
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return;
+	}
+
+	init_completion(&xfer->comp);
+	mutex_lock(&master->xferqueue.lock);
+	if (master->xferqueue.cur) {
+		list_add_tail(&xfer->node, &master->xferqueue.list);
+	} else {
+		master->xferqueue.cur = xfer;
+		xi3c_master_start_xfer_locked(master);
+	}
+	mutex_unlock(&master->xferqueue.lock);
+
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+}
+
+static inline int xi3c_master_common_xfer(struct xi3c_master *master,
+					  struct xi3c_xfer *xfer)
+{
+	int ret, timeout;
+
+	mutex_lock(&master->lock);
+	xi3c_master_enqueue_xfer(master, xfer);
+	timeout = wait_for_completion_timeout(&xfer->comp,
+					      msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS));
+	if (!timeout)
+		ret = -ETIMEDOUT;
+	else
+		ret = xfer->ret;
+
+	if (ret)
+		xi3c_master_dequeue_xfer(master, xfer);
+
+	mutex_unlock(&master->lock);
+	xi3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int xi3c_master_do_daa(struct i3c_master_controller *m)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct xi3c_cmd *daa_cmd;
+	struct xi3c_xfer *xfer;
+	u8 pid_bufs[XI3C_MAX_DEVS][8];
+	int addr, ret, i;
+	u8 data, last_addr = 0;
+	u8 *pid_buf;
+
+	if (master->num_targets == 0 || master->num_targets > XI3C_MAX_DEVS) {
+		dev_err(master->dev, "Invalid / No target devices connected\n");
+		return -EIO;
+	}
+
+	master->pid_bcr_dcr = kcalloc(master->num_targets, sizeof(u64), GFP_KERNEL);
+	if (!master->pid_bcr_dcr)
+		return -ENOMEM;
+
+	xfer = xi3c_master_alloc_xfer(master, master->num_targets + 1);
+	if (!xfer) {
+		ret = -ENOMEM;
+		goto err_daa_mem;
+	}
+
+	/* Fill ENTDAA CCC */
+	data = I3C_CCC_ENTDAA;
+	daa_cmd = &xfer->cmds[0];
+	daa_cmd->addr = I3C_BROADCAST_ADDR;
+	daa_cmd->rnw = 0;
+	daa_cmd->tx_buf = &data;
+	daa_cmd->tx_len = 1;
+	daa_cmd->type = XI3C_SDR_MODE;
+	daa_cmd->tid = XI3C_SDR_TID;
+	daa_cmd->continued = true;
+
+	for (i = 1; i < master->num_targets + 1; i++) {
+		struct xi3c_cmd *cmd = &xfer->cmds[i];
+
+		pid_buf = pid_bufs[i - 1];
+		addr = i3c_master_get_free_addr(m, last_addr + 1);
+		if (addr < 0) {
+			ret = -ENOSPC;
+			goto err_daa;
+		}
+
+		last_addr = (u8)addr;
+		master->addrs[i - 1] = (u8)addr;
+		addr = (addr << 1) | xi3c_even_parity((u8)addr);
+
+		cmd->tx_buf = (u8 *)&addr;
+		cmd->tx_len = 1;
+		cmd->addr = I3C_BROADCAST_ADDR;
+		cmd->rnw = 1;
+		cmd->rx_buf = pid_buf;
+		cmd->rx_len = XI3C_DAA_SLAVEINFO_READ_BYTECOUNT;
+		cmd->is_daa = true;
+		cmd->type = XI3C_SDR_MODE;
+		cmd->tid = XI3C_SDR_TID;
+		cmd->continued = i < master->num_targets;
+	}
+
+	ret = xi3c_master_common_xfer(master, xfer);
+	if (ret)
+		goto err_daa_mem;
+
+	for (i = 0; i < master->num_targets; i++) {
+		ret = i3c_master_add_i3c_dev_locked(m, master->addrs[i]);
+		if (ret)
+			goto err_daa_mem;
+
+		master->pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
+						   get_unaligned_be64(pid_bufs[i]));
+		dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, master->pid_bcr_dcr[i]);
+	}
+
+	kfree(master->pid_bcr_dcr);
+	return 0;
+
+err_daa:
+	xi3c_master_free_xfer(xfer);
+err_daa_mem:
+	kfree(master->pid_bcr_dcr);
+	xi3c_master_init(master);
+	return ret;
+}
+
+static bool
+xi3c_master_supports_ccc_cmd(struct i3c_master_controller *master,
+			     const struct i3c_ccc_cmd *cmd)
+{
+	if (cmd->ndests > 1)
+		return false;
+
+	switch (cmd->id) {
+	case I3C_CCC_ENEC(true):
+	case I3C_CCC_ENEC(false):
+	case I3C_CCC_DISEC(true):
+	case I3C_CCC_DISEC(false):
+	case I3C_CCC_ENTAS(0, true):
+	case I3C_CCC_ENTAS(0, false):
+	case I3C_CCC_RSTDAA(true):
+	case I3C_CCC_RSTDAA(false):
+	case I3C_CCC_ENTDAA:
+	case I3C_CCC_SETMWL(true):
+	case I3C_CCC_SETMWL(false):
+	case I3C_CCC_SETMRL(true):
+	case I3C_CCC_SETMRL(false):
+	case I3C_CCC_ENTHDR(0):
+	case I3C_CCC_SETDASA:
+	case I3C_CCC_SETNEWDA:
+	case I3C_CCC_GETMWL:
+	case I3C_CCC_GETMRL:
+	case I3C_CCC_GETPID:
+	case I3C_CCC_GETBCR:
+	case I3C_CCC_GETDCR:
+	case I3C_CCC_GETSTATUS:
+	case I3C_CCC_GETMXDS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int xi3c_master_send_bdcast_ccc_cmd(struct xi3c_master *master,
+					   struct i3c_ccc_cmd *ccc)
+{
+	u16 xfer_len = ccc->dests[0].payload.len + 1;
+	struct xi3c_xfer *xfer;
+	struct xi3c_cmd *cmd;
+	int ret;
+	u8 *buf;
+
+	xfer = xi3c_master_alloc_xfer(master, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	buf = kmalloc(xfer_len, GFP_KERNEL);
+	if (!buf) {
+		xi3c_master_free_xfer(xfer);
+		return -ENOMEM;
+	}
+
+	buf[0] = ccc->id;
+	memcpy(&buf[1], ccc->dests[0].payload.data, ccc->dests[0].payload.len);
+
+	cmd = &xfer->cmds[0];
+	cmd->addr = ccc->dests[0].addr;
+	cmd->rnw = ccc->rnw;
+	cmd->tx_buf = buf;
+	cmd->tx_len = xfer_len;
+	cmd->type = XI3C_SDR_MODE;
+	cmd->tid = XI3C_SDR_TID;
+	cmd->continued = false;
+
+	ret = xi3c_master_common_xfer(master, xfer);
+	kfree(buf);
+
+	return ret;
+}
+
+static int xi3c_master_send_direct_ccc_cmd(struct xi3c_master *master,
+					   struct i3c_ccc_cmd *ccc)
+{
+	struct xi3c_xfer *xfer;
+	struct xi3c_cmd *cmd;
+
+	xfer = xi3c_master_alloc_xfer(master, 2);
+	if (!xfer)
+		return -ENOMEM;
+
+	/* Broadcasted message */
+	cmd = &xfer->cmds[0];
+	cmd->addr = I3C_BROADCAST_ADDR;
+	cmd->rnw = 0;
+	cmd->tx_buf = &ccc->id;
+	cmd->tx_len = 1;
+	cmd->type = XI3C_SDR_MODE;
+	cmd->tid = XI3C_SDR_TID;
+	cmd->continued = true;
+
+	/* Directed message */
+	cmd = &xfer->cmds[1];
+	cmd->addr = ccc->dests[0].addr;
+	cmd->rnw = ccc->rnw;
+	if (cmd->rnw) {
+		cmd->rx_buf = ccc->dests[0].payload.data;
+		cmd->rx_len = ccc->dests[0].payload.len;
+	} else {
+		cmd->tx_buf = ccc->dests[0].payload.data;
+		cmd->tx_len = ccc->dests[0].payload.len;
+	}
+	cmd->type = XI3C_SDR_MODE;
+	cmd->tid = XI3C_SDR_TID;
+	cmd->continued = false;
+
+	return xi3c_master_common_xfer(master, xfer);
+}
+
+static int xi3c_master_send_ccc_cmd(struct i3c_master_controller *m,
+				    struct i3c_ccc_cmd *cmd)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+	bool broadcast = cmd->id < 0x80;
+
+	if (broadcast)
+		return xi3c_master_send_bdcast_ccc_cmd(master, cmd);
+
+	return xi3c_master_send_direct_ccc_cmd(master, cmd);
+}
+
+static int xi3c_master_priv_xfers(struct i3c_dev_desc *dev,
+				  struct i3c_priv_xfer *xfers,
+				  int nxfers)
+{
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct xi3c_xfer *xfer;
+	int i;
+
+	if (!nxfers)
+		return 0;
+
+	xfer = xi3c_master_alloc_xfer(master, nxfers);
+	if (!xfer)
+		return -ENOMEM;
+
+	for (i = 0; i < nxfers; i++) {
+		struct xi3c_cmd *cmd = &xfer->cmds[i];
+
+		cmd->addr = dev->info.dyn_addr;
+		cmd->rnw = xfers[i].rnw;
+
+		if (cmd->rnw) {
+			cmd->rx_buf = xfers[i].data.in;
+			cmd->rx_len = xfers[i].len;
+		} else {
+			cmd->tx_buf = (void *)xfers[i].data.out;
+			cmd->tx_len = xfers[i].len;
+		}
+
+		cmd->type = XI3C_SDR_MODE;
+		cmd->tid = XI3C_SDR_TID;
+		cmd->continued = (i + 1) < nxfers;
+	}
+
+	return xi3c_master_common_xfer(master, xfer);
+}
+
+static int xi3c_master_i2c_xfers(struct i2c_dev_desc *dev,
+				 struct i2c_msg *xfers,
+				 int nxfers)
+{
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct xi3c_xfer *xfer;
+	int i;
+
+	if (!nxfers)
+		return 0;
+
+	xfer = xi3c_master_alloc_xfer(master, nxfers);
+	if (!xfer)
+		return -ENOMEM;
+
+	for (i = 0; i < nxfers; i++) {
+		struct xi3c_cmd *cmd = &xfer->cmds[i];
+
+		cmd->addr = xfers[i].addr & XI3C_ADDR_MASK;
+		cmd->rnw = xfers[i].flags & I2C_M_RD;
+
+		if (cmd->rnw) {
+			cmd->rx_buf = xfers[i].buf;
+			cmd->rx_len = xfers[i].len;
+		} else {
+			cmd->tx_buf = (void *)xfers[i].buf;
+			cmd->tx_len = xfers[i].len;
+		}
+
+		cmd->type = XI3C_I2C_MODE;
+		cmd->tid = XI3C_I2C_TID;
+		cmd->continued = (i + 1) < nxfers;
+	}
+
+	return xi3c_master_common_xfer(master, xfer);
+}
+
+static int xi3c_master_bus_init(struct i3c_master_controller *m)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct i3c_bus *bus = i3c_master_get_bus(m);
+	struct i3c_device_info info = { };
+	u64 pid1_bcr_dcr;
+	int ret;
+
+	if (bus->mode != I3C_BUS_MODE_PURE)
+		ret = -EINVAL;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Get an address for the master. */
+	ret = i3c_master_get_free_addr(m, 0);
+	if (ret < 0)
+		goto rpm_out;
+
+	info.dyn_addr = (u8)ret;
+
+	/* Write the dynamic address value to the address register. */
+	writel(info.dyn_addr, master->membase + XI3C_ADDRESS_OFFSET);
+
+	/* Read PID, BCR and DCR values, and assign to i3c device info. */
+	pid1_bcr_dcr = readl(master->membase + XI3C_PID1_BCR_DCR);
+	info.pid = ((FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr) << 32) |
+		    readl(master->membase + XI3C_PID0_OFFSET));
+	info.bcr = (u8)FIELD_GET(XI3C_BCR_MASK, pid1_bcr_dcr);
+	info.dcr = (u8)FIELD_GET(XI3C_DCR_MASK, pid1_bcr_dcr);
+
+	ret = i3c_master_set_info(&master->base, &info);
+	if (ret)
+		goto rpm_out;
+
+	xi3c_master_init(master);
+
+rpm_out:
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+	return ret;
+}
+
+static void xi3c_master_bus_cleanup(struct i3c_master_controller *m)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return;
+	}
+
+	xi3c_master_disable(master);
+
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+}
+
+static const struct i3c_master_controller_ops xi3c_master_ops = {
+	.bus_init = xi3c_master_bus_init,
+	.bus_cleanup = xi3c_master_bus_cleanup,
+	.do_daa = xi3c_master_do_daa,
+	.supports_ccc_cmd = xi3c_master_supports_ccc_cmd,
+	.send_ccc_cmd = xi3c_master_send_ccc_cmd,
+	.priv_xfers = xi3c_master_priv_xfers,
+	.i2c_xfers = xi3c_master_i2c_xfers,
+};
+
+static int xi3c_master_probe(struct platform_device *pdev)
+{
+	struct xi3c_master *master;
+	int ret;
+
+	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return -ENOMEM;
+
+	master->membase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(master->membase))
+		return PTR_ERR(master->membase);
+
+	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,num-targets",
+				   &master->num_targets);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read xlnx,num-targets\n");
+		return ret;
+	}
+
+	master->pclk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(master->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(master->pclk),
+				     "Failed to get and enable clock\n");
+
+	master->dev = &pdev->dev;
+
+	mutex_init(&master->lock);
+	mutex_init(&master->xferqueue.lock);
+	INIT_LIST_HEAD(&master->xferqueue.list);
+
+	platform_set_drvdata(pdev, master);
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, XI3C_PM_TIMEOUT_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = i3c_master_register(&master->base, &pdev->dev,
+				  &xi3c_master_ops, false);
+	if (ret)
+		goto err_rpm_disable;
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
+	return 0;
+
+err_rpm_disable:
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+
+	return ret;
+}
+
+static void xi3c_master_remove(struct platform_device *pdev)
+{
+	struct xi3c_master *master = platform_get_drvdata(pdev);
+
+	i3c_master_unregister(&master->base);
+
+	pm_runtime_disable(master->dev);
+	pm_runtime_set_suspended(master->dev);
+	pm_runtime_dont_use_autosuspend(master->dev);
+}
+
+static int __maybe_unused xi3c_master_runtime_suspend(struct device *dev)
+{
+	struct xi3c_master *master = dev_get_drvdata(dev);
+
+	xi3c_master_disable(master);
+	clk_disable_unprepare(master->pclk);
+	return 0;
+}
+
+static int __maybe_unused xi3c_master_runtime_resume(struct device *dev)
+{
+	struct xi3c_master *master = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(master->pclk);
+	if (ret)
+		return ret;
+
+	xi3c_master_enable(master);
+	return 0;
+}
+
+static const struct dev_pm_ops xi3c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(xi3c_master_runtime_suspend, xi3c_master_runtime_resume,
+			   NULL)
+};
+
+static const struct of_device_id xi3c_master_of_ids[] = {
+	{ .compatible = "xlnx,axi-i3c-1.0" },
+	{ },
+};
+
+static struct platform_driver xi3c_master_driver = {
+	.probe = xi3c_master_probe,
+	.remove = xi3c_master_remove,
+	.driver = {
+		.name = "axi-i3c-master",
+		.of_match_table = xi3c_master_of_ids,
+		.pm = &xi3c_pm_ops,
+	},
+};
+module_platform_driver(xi3c_master_driver);
+
+MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
+MODULE_DESCRIPTION("AXI I3C master driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

