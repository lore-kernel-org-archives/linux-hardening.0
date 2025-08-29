Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15889341AAD;
	Fri, 29 Aug 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487643; cv=fail; b=sC3wp5RPMRa0WrnqS5iPQOsL1C3n39ihNTwEberKoExnbb7NJctyDeFDq0KpUixRSxLu1OH07bEOewy2075moZzpyFDl9xxc0DxD/03GLQwarltYDezAa4mp4ruINnyBkBx2V++l5xMbqhVbzcEzz2GjRqka++BnFvqVKNObBmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487643; c=relaxed/simple;
	bh=2yrdT/yDWR7U23KYFhfiY1jRUnqywV5wf1iaqYguaOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgQDr89LZ9KayCi+anZ6Z1lDA7FHYDF/ysT1bmO/C17ZvP3txc1JRbg7vl4kU5ByKgIjE8zfncA+adG8B6YpJTEe5Mf3RCBJdw0HM1C9lEwsAghvQdWTn/wfPFFAWRDkreArkLXsL0t/fpHJOm20ve21JA81C1hjF00bOsCVSfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O8bKucO2; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O8bKucO2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKQbnaaOYHYb3F3PF/QHEJO+jjOtxnI5T6K7fh5zZO0/trN7ZDHiV+AgYtf94YgeuVG09Gq4YiFnl1Eg01owkXP8hLlYI214euziaW70az916TyBBSlcvFK7QbkYVom5sfWPDTkk5QNp/qMconcL4YAcMUX+NY0GJUyWBxFAasiSIwHNXhE5Q1GROfy0+LIlVEB1WEAVpArSRZvOn/zPSBZUUX9SLWCdU2TYaCe+r5oiI0unjkLk8vCs7PdEUaKOSJ5d3lHW2oZWXFZ3jKkGHFckxkES7YIG37ReYYBcndtP146OOeoR6TpaYMoqpXy+KJCTp8rfyauxAXxs6MW+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv269HcYx7Mk1AtcODWIbXBseYcCk3G2ZmBUXhL/SKw=;
 b=YFxUeQ8+mpFdmtOL3GOdJ1V71rO2DZaPD8DDynkcCTvD9s13cfuViD/kBE2oAWdvIx+noDZE5IvDoHaG9GKjyzCtmnCTzYT+NKAtMJk0KPepWx7VjQ+qeK6jCfrcSoTW0v6g2mSHQGzPgR+XaY49j1q/1PNQHomtBCtiELHAW8QdBGp4KoC4WoxjJvmSTMhyr7sQWLheknHwy2k/L1uwbloO8Ce4EpPoF+l1Op2+KCFw6nh2SY+bXH+4VNecWWPrxKtBp3iey9R0uzuSkD66OHhE34HhS3DMt7sgnu7CB2pJPPXUh/Qfs/89pQ4LB+Ks5yaP3BewEVPLjspgeyCE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv269HcYx7Mk1AtcODWIbXBseYcCk3G2ZmBUXhL/SKw=;
 b=O8bKucO2w11jRz4LG+cDDAQzoR3gPpL4mi4ONpGg4uUT0dhTelvAQbQCt+jwdCZtLYJeNQQ2FddDMjNBfjCIReAWvvEglVLfyQ4m2HWfqzzG55zByCohct6NGLQProX28B6rYM/8FPUM2s5CDPKXICOsFfoKvLWjHzHZQ7stE1Y=
Received: from BL1PR13CA0335.namprd13.prod.outlook.com (2603:10b6:208:2c6::10)
 by IA1PR12MB9532.namprd12.prod.outlook.com (2603:10b6:208:595::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 29 Aug
 2025 17:13:54 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::89) by BL1PR13CA0335.outlook.office365.com
 (2603:10b6:208:2c6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.5 via Frontend Transport; Fri,
 29 Aug 2025 17:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 29 Aug 2025 17:13:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 12:13:52 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 29 Aug 2025 12:13:48 -0500
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
Subject: [PATCH V2 2/2] i3c: master: Add AMD I3C bus controller driver
Date: Fri, 29 Aug 2025 22:43:27 +0530
Message-ID: <20250829171327.2590730-3-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|IA1PR12MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c8e44d-5182-4eb2-21b4-08dde71f6ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cFPRiA4aTWaGN55HP4rKFjCJZRmdvX7ZsbwO1znxeaqs5Gf/eGeNXO4pJHnt?=
 =?us-ascii?Q?lxcAPePCtUuVvxCNX3+YNNsStxEBGMhfAVe8UnJY0Mm//P21p5d74vC/tpJm?=
 =?us-ascii?Q?HdkDhTMGuI1gGQI7EG0EMQHwMBN6hpG/8/XoC5tqVjU0xH/xzoEH9G7zRAl1?=
 =?us-ascii?Q?UxC7+FFGJJ90GX4tvQDpFQw5N58Pq2oEIkMx18T7ydxQ7PTIPMNeXcBgRgmh?=
 =?us-ascii?Q?NyHqteTEJH73pTcHj19YajkoZSel5h9wG12QDsfnKmVAOwWX1SFsQ3y89m4p?=
 =?us-ascii?Q?j7G99d8MDpEawtmX7pG76JYlPH4699c4zf2lI4TNGrDwCdpqHzHRrIAiAPdP?=
 =?us-ascii?Q?S0PB3P5g2oq3dBY1alQ6rLWZwMz7MCwb0XcSxOnx8QvmoNUPBkrA9kY+nEof?=
 =?us-ascii?Q?1RgUqWKnLTdYRG5uxn5v66uOn/1SL1dkuNAcH3VGbCRbTFRhz9CP/CHHRDhx?=
 =?us-ascii?Q?OflrfhJKZ25SusPuQqPlfCUbt8zmJl9bOvp5MtO2WJUiLGR1N7ZLdWRppNp8?=
 =?us-ascii?Q?3s+SeYRbgDB31EUEktfJys/x21uvex6g3EgMQRSADZwNzuP2+CA8jlI/kcJU?=
 =?us-ascii?Q?/UkgXt2tK5i9ozK3yNs6NwfNkp7Pa21FwdgXmYLnxS2nuazuAEB3BUgHMkeP?=
 =?us-ascii?Q?s/I67hXbR76oebj5j6fAMiqrsvx4DM0zHwDAcvabmlDEWOq4K/qvHx3g+Ydn?=
 =?us-ascii?Q?cU+vGhq0oEozcfR5GgLfK1ssNYVZOOltHQJQ8fgBdx3hcQTs6lAei7/hLj0N?=
 =?us-ascii?Q?abRliZIEFppyiFHz3SVJRcYIc8egyhoYDRci8fhXLIM4zbuNxTQqrwgAPMjT?=
 =?us-ascii?Q?t0VaqU1WZDxfwEgEEGBfjAKVWPB4m28qaXJrdDvfq9Q763qFfA5gq4pPbJel?=
 =?us-ascii?Q?lj2YksUhjbwjDwkjAzsVBxBEkdYVxhi2qJ0eAizGdsXMEZzYBj8EJGh78RDw?=
 =?us-ascii?Q?0mVEVEw0RwR3WfpDdu0PU0I6U7MjFN48nwxkK7lD0+jtPISK07f3QU0vnDWd?=
 =?us-ascii?Q?BwBE3sjPkpnH+k7k3d69lEVRD+brsq3ZKxrEeGT7I0zdGs90DBw/yZBmqQXP?=
 =?us-ascii?Q?GxOnc8r0MrfPoJBh5NZdv2yhqqi+ba3bECHYvjtFWOidwuCXxromZJNi+AOw?=
 =?us-ascii?Q?UshL8dE7Ra3SPfokU0DOafLAwER8Rq2X01jR/073QZ/lAlR21JYfQjM18aHN?=
 =?us-ascii?Q?F07eqxrTD4q7MlsQbxtR2kcVENH0qa9dVJWgB1Hh9xP1qdV88GFvIoV0qCtP?=
 =?us-ascii?Q?SFvEZnOUhFKbuIm04Z6quVMXr7cDIOt7bPqj7N8fA0PeS5trB5pMRHNnIl+H?=
 =?us-ascii?Q?EgiO/PO8maptm2zf9hUz0+zbq5anPAWna/YrEDzsxNExEAXYe0e943t9/aeW?=
 =?us-ascii?Q?4eTJEq5/5imfnIIs82b7M4LkmWk52j9zr6hL12rSLgcMaxnZn03CFtCwHYMs?=
 =?us-ascii?Q?8Ex9F0kLINo8v0+TWh01xY9zHIT2CIAfvXdnT1XVoEqxniK6VVXUkSVmqtFV?=
 =?us-ascii?Q?8nef2aEbyPZgo08/EZJWMS9G5hdpU/rpcSufN28yVSr5NURyOIL2qqRDqw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:13:54.4848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c8e44d-5182-4eb2-21b4-08dde71f6ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9532

Add an I3C master driver and maintainers fragment for the AMD I3C bus
controller.

The driver currently supports the I3C bus operating in SDR i3c mode,
with features including Dynamic Address Assignment, private data transfers,
and CCC transfers in both broadcast and direct modes. It also supports
operation in I2C mode.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Updated commit description.
Added mixed mode support with clock configuration.
Converted smaller functions into inline functions.
Used FIELD_GET() in xi3c_get_response().
Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
Used parity8() for address parity calculation.
Added guards for locks.
Dropped num_targets and updated xi3c_master_do_daa().
Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
Dropped PM runtime support.
Updated xi3c_master_read() and xi3c_master_write() with
xi3c_is_resp_available() check.
Created separate functions: xi3c_master_init() and xi3c_master_reinit().
Used xi3c_master_init() in bus initialization and xi3c_master_reinit()
in error paths.
Added DAA structure to xi3c_master structure.
---
 MAINTAINERS                         |    7 +
 drivers/i3c/master/Kconfig          |   16 +
 drivers/i3c/master/Makefile         |    1 +
 drivers/i3c/master/amd-i3c-master.c | 1009 +++++++++++++++++++++++++++
 4 files changed, 1033 insertions(+)
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
index 000000000000..f74febe4d17d
--- /dev/null
+++ b/drivers/i3c/master/amd-i3c-master.c
@@ -0,0 +1,1009 @@
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
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#define XI3C_VERSION_OFFSET			0x00	/* Version Register */
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
+#define XI3C_SCL_HIGH_TIME_OFFSET		0x38	/* I3C SCL HIGH Register */
+#define XI3C_SCL_LOW_TIME_OFFSET		0x3C	/* I3C SCL LOW  Register */
+#define XI3C_SDA_HOLD_TIME_OFFSET		0x40	/* I3C SDA HOLD Register */
+#define XI3C_TSU_START_OFFSET			0x48	/* I3C START SETUP Register  */
+#define XI3C_THD_START_OFFSET			0x4C	/* I3C START HOLD Register */
+#define XI3C_TSU_STOP_OFFSET			0x50	/* I3C STOP Setup Register  */
+#define XI3C_OD_SCL_HIGH_TIME_OFFSET		0x54	/* I3C OD SCL HIGH Register */
+#define XI3C_OD_SCL_LOW_TIME_OFFSET		0x58	/* I3C OD SCL LOW  Register */
+#define XI3C_PID0_OFFSET			0x6C	/* LSB 4 bytes of the PID */
+#define XI3C_PID1_BCR_DCR			0x70	/* MSB 2 bytes of the PID, BCR and DCR */
+
+#define XI3C_CR_EN_MASK				BIT(0)	/* Core Enable */
+#define XI3C_CR_RESUME_MASK			BIT(2)	/* Core Resume */
+#define XI3C_SR_RESP_NOT_EMPTY_MASK		BIT(4)	/* Resp Fifo not empty status mask */
+
+#define XI3C_BCR_MASK				GENMASK(23, 16)
+#define XI3C_DCR_MASK				GENMASK(31, 24)
+#define XI3C_PID_MASK				GENMASK(63, 16)
+#define XI3C_SCL_HIGH_TIME_MASK			GENMASK(17, 0)
+#define XI3C_SCL_LOW_TIME_MASK			GENMASK(17, 0)
+#define XI3C_SDA_HOLD_TIME_MASK			GENMASK(17, 0)
+#define XI3C_TSU_START_MASK			GENMASK(17, 0)
+#define XI3C_THD_START_MASK			GENMASK(17, 0)
+#define XI3C_TSU_STOP_MASK			GENMASK(17, 0)
+#define XI3C_REV_NUM_MASK			GENMASK(15, 8)
+#define XI3C_PID1_MASK				GENMASK(15, 0)
+#define XI3C_WR_FIFO_LEVEL_MASK			GENMASK(15, 0)
+#define XI3C_CMD_LEN_MASK			GENMASK(11, 0)
+#define XI3C_RESP_CODE_MASK			GENMASK(8, 5)
+#define XI3C_ADDR_MASK				GENMASK(6, 0)
+#define XI3C_CMD_TYPE_MASK			GENMASK(3, 0)
+#define XI3C_CMD_TID_MASK			GENMASK(3, 0)
+#define XI3C_FIFOS_RST_MASK			GENMASK(4, 1)
+
+#define XI3C_OD_TLOW_NS				500000
+#define XI3C_OD_THIGH_NS			41000
+#define XI3C_I2C_TCASMIN_NS			600000
+#define XI3C_TCASMIN_NS				260000
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
+
+/* timeout waiting for the controller finish transfers */
+#define XI3C_XFER_TIMEOUT			(msecs_to_jiffies(10000))
+#define XI3C_XFER_TIMEOUT_MS			10000
+
+#define xi3c_getrevisionnumber(master)						\
+	((u8)(FIELD_GET(XI3C_REV_NUM_MASK,					\
+			readl((master)->membase + XI3C_VERSION_OFFSET))))
+
+#define xi3c_wrfifolevel(master)						\
+	((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_OFFSET) &		\
+	       XI3C_WR_FIFO_LEVEL_MASK))
+
+#define xi3c_rdfifolevel(master)						\
+	((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_1_OFFSET) &	\
+	       XI3C_WR_FIFO_LEVEL_MASK))
+
+#define xi3c_is_resp_available(master)						\
+	((u8)(FIELD_GET(XI3C_SR_RESP_NOT_EMPTY_MASK,				\
+			readl((master)->membase + XI3C_SR_OFFSET))))
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
+ * @daa.addrs: Slave addresses array
+ * @daa.index: Slave device index
+ */
+struct xi3c_master {
+	struct i3c_master_controller base;
+	struct device *dev;
+	struct {
+		struct list_head list;
+		struct xi3c_xfer *cur;
+		/* Queue lock */
+		spinlock_t lock;
+	} xferqueue;
+	void __iomem *membase;
+	struct clk *pclk;
+	/* Transfer lock */
+	struct mutex lock;
+	struct {
+		u8 addrs[XI3C_MAX_DEVS];
+		u8 index;
+	} daa;
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
+	u32 resp_reg, response_data;
+	int ret;
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
+	return FIELD_GET(XI3C_RESP_CODE_MASK, response_data);
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
+	u32 data;
+	u16 len;
+
+	/* Read from Rx FIFO */
+	data = ioread32be(master->membase + XI3C_RD_FIFO_OFFSET);
+
+	/* Data extraction to rx buffer */
+	len = cmd->rx_len;
+	if (len > 0) {
+		len = (len >= XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
+		memcpy((u8 *)cmd->rx_buf, &data, len);
+		cmd->rx_buf = (u8 *)cmd->rx_buf + len;
+		cmd->rx_len -= len;
+	}
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
+		master->daa.index++;
+		cmd->is_daa = false;
+	}
+
+	transfer_cmd |= (u32)(len & XI3C_CMD_LEN_MASK) << 16;
+	writel(transfer_cmd, master->membase + XI3C_CMD_FIFO_OFFSET);
+}
+
+static inline void xi3c_master_enable(struct xi3c_master *master)
+{
+	writel(readl(master->membase + XI3C_CR_OFFSET) | XI3C_CR_EN_MASK,
+	       master->membase + XI3C_CR_OFFSET);
+}
+
+static inline void xi3c_master_disable(struct xi3c_master *master)
+{
+	writel(readl(master->membase + XI3C_CR_OFFSET) & (~XI3C_CR_EN_MASK),
+	       master->membase + XI3C_CR_OFFSET);
+}
+
+static inline void xi3c_master_resume(struct xi3c_master *master)
+{
+	writel(readl(master->membase + XI3C_CR_OFFSET) | XI3C_CR_RESUME_MASK,
+	       master->membase + XI3C_CR_OFFSET);
+}
+
+static void xi3c_master_reset_fifos(struct xi3c_master *master)
+{
+	u32 data;
+
+	/* Reset fifos */
+	data = readl(master->membase + XI3C_RESET_OFFSET);
+	data |= XI3C_FIFOS_RST_MASK;
+	writel(data, master->membase + XI3C_RESET_OFFSET);
+	udelay(10);
+	data &= ~XI3C_FIFOS_RST_MASK;
+	writel(data, master->membase + XI3C_RESET_OFFSET);
+	udelay(10);
+}
+
+static inline void xi3c_master_init(struct xi3c_master *master)
+{
+	/* Reset fifos */
+	xi3c_master_reset_fifos(master);
+
+	/* Enable controller */
+	xi3c_master_enable(master);
+}
+
+static inline void xi3c_master_reinit(struct xi3c_master *master)
+{
+	/* Reset fifos */
+	xi3c_master_reset_fifos(master);
+
+	/* Resume controller */
+	xi3c_master_resume(master);
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
+static inline void xi3c_master_free_xfer(struct xi3c_xfer *xfer)
+{
+	kfree(xfer);
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
+	while (cmd->rx_len > 0 && !xi3c_is_resp_available(master)) {
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
+
+	/* Read remaining data */
+	rx_data_available = xi3c_rdfifolevel(master);
+	for (data_index = 0;
+	     data_index < rx_data_available && cmd->rx_len > 0;
+	     data_index++)
+		xi3c_master_rd_from_rx_fifo(master, cmd);
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
+	while (cmd->tx_len > 0 && !xi3c_is_resp_available(master)) {
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
+	ret = xi3c_get_response(master);
+	if (ret)
+		goto err_xfer_out;
+
+	return 0;
+
+err_xfer_out:
+	xi3c_master_reinit(master);
+	return ret;
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
+	guard(spinlock_irqsave)(&master->xferqueue.lock);
+	xi3c_master_dequeue_xfer_locked(master, xfer);
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
+static inline void xi3c_master_enqueue_xfer(struct xi3c_master *master,
+					    struct xi3c_xfer *xfer)
+{
+	init_completion(&xfer->comp);
+	guard(spinlock_irqsave)(&master->xferqueue.lock);
+	if (master->xferqueue.cur) {
+		list_add_tail(&xfer->node, &master->xferqueue.list);
+	} else {
+		master->xferqueue.cur = xfer;
+		xi3c_master_start_xfer_locked(master);
+	}
+}
+
+static inline int xi3c_master_common_xfer(struct xi3c_master *master,
+					  struct xi3c_xfer *xfer)
+{
+	int ret, timeout;
+
+	guard(mutex)(&master->lock);
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
+	return ret;
+}
+
+static int xi3c_master_do_daa(struct i3c_master_controller *m)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct xi3c_cmd *daa_cmd;
+	struct xi3c_xfer *xfer;
+	u8 pid_bufs[XI3C_MAX_DEVS][8];
+	u8 data, last_addr = 0;
+	int addr, ret, i;
+	u8 *pid_buf;
+
+	u64 *pid_bcr_dcr __free(kfree) = kcalloc(XI3C_MAX_DEVS, sizeof(u64),
+						 GFP_KERNEL);
+	if (!pid_bcr_dcr)
+		return -ENOMEM;
+
+	xfer = xi3c_master_alloc_xfer(master, 1);
+	if (!xfer) {
+		ret = -ENOMEM;
+		goto err_daa_mem;
+	}
+
+	for (i = 0; i < XI3C_MAX_DEVS; i++) {
+		addr = i3c_master_get_free_addr(m, last_addr + 1);
+		if (addr < 0) {
+			ret = -ENOSPC;
+			goto err_daa;
+		}
+		master->daa.addrs[i] = (u8)addr;
+		last_addr = (u8)addr;
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
+	ret = xi3c_master_common_xfer(master, xfer);
+	/* DAA always finishes with CE2_ERROR or NACK_RESP */
+	if (ret && ret != I3C_ERROR_M2) {
+		goto err_daa;
+	} else {
+		if (ret && ret == I3C_ERROR_M2) {
+			ret = 0;
+			goto err_daa;
+		}
+	}
+
+	master->daa.index = 0;
+
+	while (true) {
+		struct xi3c_cmd *cmd = &xfer->cmds[0];
+
+		pid_buf = pid_bufs[master->daa.index];
+		addr = (master->daa.addrs[master->daa.index] << 1) |
+		       (!parity8(master->daa.addrs[master->daa.index]));
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
+		cmd->continued = true;
+
+		ret = xi3c_master_common_xfer(master, xfer);
+
+		/* DAA always finishes with CE2_ERROR or NACK_RESP */
+		if (ret && ret != I3C_ERROR_M2) {
+			goto err_daa;
+		} else {
+			if (ret && ret == I3C_ERROR_M2) {
+				xi3c_master_resume(master);
+				master->daa.index--;
+				ret = 0;
+				break;
+			}
+		}
+	}
+
+	xi3c_master_free_xfer(xfer);
+
+	for (i = 0; i < master->daa.index; i++) {
+		ret = i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
+		if (ret)
+			goto err_daa_mem;
+
+		pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
+					   get_unaligned_be64(pid_bufs[i]));
+		dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, pid_bcr_dcr[i]);
+	}
+
+	return 0;
+
+err_daa:
+	xi3c_master_free_xfer(xfer);
+err_daa_mem:
+	xi3c_master_reinit(master);
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
+
+	xfer = xi3c_master_alloc_xfer(master, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	u8 *buf __free(kfree) = kmalloc(xfer_len, GFP_KERNEL);
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
+	xi3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int xi3c_master_send_direct_ccc_cmd(struct xi3c_master *master,
+					   struct i3c_ccc_cmd *ccc)
+{
+	struct xi3c_xfer *xfer;
+	struct xi3c_cmd *cmd;
+	int ret;
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
+	ret = xi3c_master_common_xfer(master, xfer);
+	xi3c_master_free_xfer(xfer);
+	return ret;
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
+	int i, ret;
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
+	ret = xi3c_master_common_xfer(master, xfer);
+	xi3c_master_free_xfer(xfer);
+	return ret;
+}
+
+static int xi3c_master_i2c_xfers(struct i2c_dev_desc *dev,
+				 struct i2c_msg *xfers,
+				 int nxfers)
+{
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct xi3c_xfer *xfer;
+	int i, ret;
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
+	ret = xi3c_master_common_xfer(master, xfer);
+	xi3c_master_free_xfer(xfer);
+	return ret;
+}
+
+static int xi3c_clk_cfg(struct xi3c_master *master, unsigned long sclhz, u8 mode)
+{
+	unsigned long core_rate, core_periodns;
+	u32 thigh, tlow, thold, odthigh, odtlow, tcasmin, tsustart, tsustop, thdstart;
+
+	core_rate = clk_get_rate(master->pclk);
+	if (!core_rate)
+		return -EINVAL;
+
+	core_periodns = DIV_ROUND_UP(1000000000, core_rate);
+
+	thigh = DIV_ROUND_UP(core_rate, sclhz) >> 1;
+	tlow = thigh;
+
+	/* Hold time : 40% of tlow time */
+	thold = (tlow * 4) / 10;
+
+	/*
+	 * For initial IP (revision number == 0), minimum data hold time is 5.
+	 * For updated IP (revision number > 0), minimum data hold time is 6.
+	 * Updated IP supports achieving high data rate with low reference
+	 * frequency.
+	 */
+	if (xi3c_getrevisionnumber(master) == 0)
+		thold = (thold < 5) ? 5 : thold;
+	else
+		thold = (thold < 6) ? 6 : thold;
+
+	writel((thigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
+	       master->membase + XI3C_SCL_HIGH_TIME_OFFSET);
+	writel((tlow - 2) & XI3C_SCL_LOW_TIME_MASK,
+	       master->membase + XI3C_SCL_LOW_TIME_OFFSET);
+	writel((thold - 2) & XI3C_SDA_HOLD_TIME_MASK,
+	       master->membase + XI3C_SDA_HOLD_TIME_OFFSET);
+
+	if (!mode) {
+		/* I2C */
+		writel((thigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
+		       master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
+		writel((tlow - 2) & XI3C_SCL_LOW_TIME_MASK,
+		       master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
+
+		tcasmin = DIV_ROUND_UP(XI3C_I2C_TCASMIN_NS, core_periodns);
+	} else {
+		/* I3C */
+		odtlow = DIV_ROUND_UP(XI3C_OD_TLOW_NS, core_periodns);
+		odthigh = DIV_ROUND_UP(XI3C_OD_THIGH_NS, core_periodns);
+
+		odtlow = (tlow < odtlow) ? odtlow : tlow;
+		odthigh = (thigh > odthigh) ? odthigh : thigh;
+
+		writel((odthigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
+		       master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
+		writel((odtlow - 2) & XI3C_SCL_LOW_TIME_MASK,
+		       master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
+
+		tcasmin = DIV_ROUND_UP(XI3C_TCASMIN_NS, core_periodns);
+	}
+
+	thdstart = (thigh > tcasmin) ? thigh : tcasmin;
+	tsustart = (tlow > tcasmin) ? tlow : tcasmin;
+	tsustop = (tlow > tcasmin) ? tlow : tcasmin;
+
+	writel((tsustart - 2) & XI3C_TSU_START_MASK,
+	       master->membase + XI3C_TSU_START_OFFSET);
+	writel((thdstart - 2) & XI3C_THD_START_MASK,
+	       master->membase + XI3C_THD_START_OFFSET);
+	writel((tsustop - 2) & XI3C_TSU_STOP_MASK,
+	       master->membase + XI3C_TSU_STOP_OFFSET);
+
+	return 0;
+}
+
+static int xi3c_master_bus_init(struct i3c_master_controller *m)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct i3c_bus *bus = i3c_master_get_bus(m);
+	struct i3c_device_info info = { };
+	unsigned long sclhz;
+	u64 pid1_bcr_dcr;
+	u8 mode;
+	int ret;
+
+	switch (bus->mode) {
+	case I3C_BUS_MODE_MIXED_FAST:
+	case I3C_BUS_MODE_MIXED_LIMITED:
+		mode = XI3C_I2C_MODE;
+		sclhz = bus->scl_rate.i2c;
+		break;
+	case I3C_BUS_MODE_PURE:
+		mode = XI3C_SDR_MODE;
+		sclhz = bus->scl_rate.i3c;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = xi3c_clk_cfg(master, sclhz, mode);
+	if (ret)
+		return ret;
+
+	/* Get an address for the master. */
+	ret = i3c_master_get_free_addr(m, 0);
+	if (ret < 0)
+		return ret;
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
+		return ret;
+
+	xi3c_master_init(master);
+
+	return ret;
+}
+
+static void xi3c_master_bus_cleanup(struct i3c_master_controller *m)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+
+	xi3c_master_disable(master);
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
+
+	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return -ENOMEM;
+
+	master->membase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(master->membase))
+		return PTR_ERR(master->membase);
+
+	master->pclk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(master->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(master->pclk),
+				     "Failed to get and enable clock\n");
+
+	master->dev = &pdev->dev;
+
+	mutex_init(&master->lock);
+	spin_lock_init(&master->xferqueue.lock);
+	INIT_LIST_HEAD(&master->xferqueue.list);
+
+	platform_set_drvdata(pdev, master);
+
+	return i3c_master_register(&master->base, &pdev->dev,
+				   &xi3c_master_ops, false);
+}
+
+static void xi3c_master_remove(struct platform_device *pdev)
+{
+	struct xi3c_master *master = platform_get_drvdata(pdev);
+
+	i3c_master_unregister(&master->base);
+}
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
+	},
+};
+module_platform_driver(xi3c_master_driver);
+
+MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
+MODULE_DESCRIPTION("AXI I3C master driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

