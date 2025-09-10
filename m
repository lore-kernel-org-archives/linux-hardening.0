Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6ED30B512;
	Wed, 10 Sep 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503846; cv=fail; b=iJ09AAk7gCovqykAp35N2ddmEDNuYi+CqVk26xyWW/UjflsFwKMv7FUTckvyJ0pkU/0ZWD9Pa36HNs3zc8Q5wmjGrwq2LuWTazb6s1J+u+E+7MGkHT3N+qu5Yz2/EE2WydNbv0Wp0UhXUguLx6cDd5/yjcHNnwX5KTR5wCxhwJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503846; c=relaxed/simple;
	bh=2g4jmrbtAFOsczkTHOdU3Bv/Nyzpu5W9jGNtT70HgrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYhI5UmcIpCQWq+hvgNDNqLba9J4BJFrjJBYPHJ8qB9RRLyC/fPW1CB3uU+9woOl05gxVGtKnT6ThK3RadXHJxBqbTJxd3tdVnzPjRBNRjebGzNNbIAGm1cJmrDCToYmqpkzYZRJhAf2Fh68PVKTZEguKlDt6Ii5Smft/WNopTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d47Yy1hr; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d47Yy1hr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jugp/+iswOsle0Siirm6sT/7Iloe+vEv70LNHCvuWitnpj1FLtIfuD98LDOHKM5A9/IMgtkHCdio2flBSEo381wuccPjW/koksDa9BtFeLmjpnUOzC29UgghJJWrFminAD1tpAvSzNYs32AAlJcbP+BzscNyVIbMNFVfr2FIv7fDjFz5/nobjrtUawdMBVRnPTtxthT92EC0nYzfLyqDC+Cvxq+nugk6f+PwhhXchdtvshKzVygvW2wfpujfA/xnBaAX5PHIBDW4zI/VKh+71OvAIkNxKZYSXqNYks5pNhkefOHsGErel0DjP0i70QLQW5evRlrePVsoUC3gUa0BsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzJNH6c+LoIPvZUcEXqgavekjLtXwwi2D3yzeuTB0B4=;
 b=niSVWAfHbX2tDhzi+IiQXQIy3bdddqkVr/nPhh5NfTeLtZfA/t9WuDr7U/mLWNjzUsx7WUUd6Z/rgwDqYhauzq4jIxe27eh/mkR7fSewPmSSyk5Xb2E9t9BXIpIFE2XXs6DI8r2rb+6aekJtfdqR5lnmGRlEktHVNNVTyLuC1wEAgs14dUnvurCLi9mEL0V97pReqn+GoJkCkKEtNoGZFAUrf6s5dBZroz31fi/M+lSOHXEtUVTnrapzHapmvPcSeCOWc4kp/4Y7vmihPY+c6iN4i9Dit+DGob/GkCzva/aYLsW20E1d91uvdteg9A5wTVgMNLJz5u8En+jxpCz5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzJNH6c+LoIPvZUcEXqgavekjLtXwwi2D3yzeuTB0B4=;
 b=d47Yy1hrVp2apSQoFNNdSLD24vT+ZrDg9Dxp4eB6nR1C1+BgxOKnMkfi+kV8onDFA9kyuRoZSpaDsHa21seZkwIJ1nzysAP8FxT4UgxzP7gaflL9LRsrEvm+HmQDZgryJA4Q9iMNSNhhzrWbv9SEDsiJs3n9Rq7TNeDLTFzd0x4=
Received: from BYAPR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:40::42)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:30:40 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::ef) by BYAPR04CA0029.outlook.office365.com
 (2603:10b6:a03:40::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 11:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:30:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 10 Sep
 2025 04:30:34 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 06:30:32 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 04:30:26 -0700
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
Subject: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller driver
Date: Wed, 10 Sep 2025 16:59:54 +0530
Message-ID: <20250910112954.553353-3-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: c08a4358-f353-475b-330b-08ddf05d7882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dgb+VJvo3DzDnyPJiUBAijbQo8nTT6jTQldllw+PPo5YN9YGL+Dkml1m0LxQ?=
 =?us-ascii?Q?mQ5T/3zW6150lFGMjtDrns8FNvKs+SKXpE3kLqvVpMVZ2IMx8217Z5eKeSjj?=
 =?us-ascii?Q?2MmagZXqT8BhtwCEdFjGLtLqzxkMXeQ7LDVFhtjadaxWyqXK2rpZyWoHf2+J?=
 =?us-ascii?Q?dJ4U8P+nJpcJYItTvue/fLt+tcXQOtkkUsgzohRTTRQLVLUEnDZnLgUDtk8J?=
 =?us-ascii?Q?fOCgwmKJZ1L+jA5uMZ49h9HA5cdgEbMi9kblkIeUhvHI3NQElTc9Lx3bJM14?=
 =?us-ascii?Q?1KIpVVFi4borwhTmlWyHW36HubhHW9FVTMRa5A18vLpg21r22Fkyh8FqygJd?=
 =?us-ascii?Q?U7jBHdhGyC99rHZlpUp8dv3fmgkAMlBBmOpSwNXGSv43aB7p8TfL/5ENao7Y?=
 =?us-ascii?Q?MaxbGUOkDy1bpCNuWpBNKViZdR9bCzDecOGMpor7s+oEszSSdUmCwC8/8IO6?=
 =?us-ascii?Q?BCh/7g6HHLRQ3OAP4nbVEWTNi07HBR7d7emW0Dh/u2ZIh/Z6mDoxUTg617xw?=
 =?us-ascii?Q?B8Nz0JhtRi8kIe+9eyJqVwLKQPj79CepG6pn3sJA9AK2f2fieDHOlkXkrIZp?=
 =?us-ascii?Q?qWnleoK/TkWhsA0BtltrM+3qzxhmvp/XO3lbK/89YqB2cYNLYyvdFvWE4ydJ?=
 =?us-ascii?Q?vRud1PpMw8YyvRGCW7E+ktCl9BIhsnoX+COtkYm9i9kyt1BWuhl+D8u5qAdX?=
 =?us-ascii?Q?UBozpgDD5DxWNZm3rEj2eUHZ+CHG0Czt1U2GZVs59qWmNYLc5XJOJDNhRIJy?=
 =?us-ascii?Q?UlL+WBZKTMriReTFEs3l+Od7agCMALqRQuaCoUhhuEZRwL/FXQASzejbHGrN?=
 =?us-ascii?Q?OEcpXs7Fg8OWTcxwrwMl/WDH9m1GJc6f0i9Mvwa2jvL4a3X+vPSvdxsQ6sfd?=
 =?us-ascii?Q?zHLN0x/9cBJFwAbd9OfK1CX+mjEFszi/vwuAvah4WGuWsiynjlidwhusbwhg?=
 =?us-ascii?Q?uWVVjdnMuAg857Uzbi852zhNLerPlZBy7hCW7GfADeNpmJoDS/nnfkLVjS2n?=
 =?us-ascii?Q?Ky05RimwePLyn9Ne6RORvQjvekBsRT51GDURGdLcmsYnhNbm0qw8B7Ng2N05?=
 =?us-ascii?Q?E5MIQ21bfnSfBQfXXsa/fBYTpckhgaImUwIwmoMT7MqHbkkpOSo0Zvy1j3qF?=
 =?us-ascii?Q?SpfKldvGG/R5F+cUc6zu+s0ekUdIEIQMHWtjiZ/l3Jgnhj6M58KMXg0nGVAt?=
 =?us-ascii?Q?BZPf9a/QysnSUGP6Jn2lu33gUgVmOHh7Z6vRtvS1Bn98oyWBqgK8wwxm9f2y?=
 =?us-ascii?Q?prh1YPJMTtbLQfkLzmIe3JLEFzCyBfYFwDnRrV30ESudZpIafZiqPrCuaeOJ?=
 =?us-ascii?Q?jNwSgcAalRuOnTnIRcIqh/SO6CgqtHZL5A1+6tbYDJoSXuoeAtc3wfpW5Ndu?=
 =?us-ascii?Q?5f7kr7z6g5+shQS7uFSfHMSESOkNQoq04XrSp5zfxnWQf4Il+YQYEdurlsL6?=
 =?us-ascii?Q?Oxy29GGGbKFNtaLvdTh66NkNc01suSDAaLlbUDoc2TPhoA9FWPMxDXmCn6VQ?=
 =?us-ascii?Q?2jCfibwC3bt9CDsGubE3YJWsRMqKTzTX16Sf9BrnYSAJucHatqRUvRsRxA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:30:40.0247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08a4358-f353-475b-330b-08ddf05d7882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

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

Changes for V3:
Resolved merge conflicts.

Changes for V4:
Updated timeout macros.
Removed type casting for xi3c_is_resp_available() macro.
Used ioread32() and iowrite32() instead of readl() and writel()
to keep consistency.
Read XI3C_RESET_OFFSET reg before udelay().
Removed xi3c_master_free_xfer() and directly used kfree().
Skipped checking return value of i3c_master_add_i3c_dev_locked().
Used devm_mutex_init() instead of mutex_init().

Changes for V5:
Used GENMASK_ULL for PID mask as it's 64bit mask.

Changes for V6:
Removed typecast for xi3c_getrevisionnumber(), xi3c_wrfifolevel(),
and xi3c_rdfifolevel().
Replaced dynamic allocation with a static variable for pid_bcr_dcr.
Fixed sparse warning in do_daa by typecasting the address parity value
to u8.
Fixed sparse warning in xi3c_master_bus_init by typecasting the pid value
to u64 in info.pid calculation.
---
 MAINTAINERS                         |    7 +
 drivers/i3c/master/Kconfig          |   16 +
 drivers/i3c/master/Makefile         |    1 +
 drivers/i3c/master/amd-i3c-master.c | 1009 +++++++++++++++++++++++++++
 4 files changed, 1033 insertions(+)
 create mode 100644 drivers/i3c/master/amd-i3c-master.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1af81124bba3..ff603ce5e78d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11693,6 +11693,13 @@ L:	linux-i2c@vger.kernel.org
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
index 13df2944f2ec..4b884a678893 100644
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
 	depends on HAS_IOMEM
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
index aac74f3e3851..109bd48cb159 100644
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
index 000000000000..cd9d85a0be80
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
+#include <linux/bitfield.h>
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
+#define XI3C_PID_MASK				GENMASK_ULL(63, 16)
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
+#define XI3C_XFER_TIMEOUT_MS			10000
+#define XI3C_XFER_TIMEOUT			(msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))
+
+#define xi3c_getrevisionnumber(master)						\
+	(FIELD_GET(XI3C_REV_NUM_MASK,						\
+		   ioread32((master)->membase + XI3C_VERSION_OFFSET)))
+
+#define xi3c_wrfifolevel(master)						\
+	(ioread32((master)->membase + XI3C_FIFO_LVL_STATUS_OFFSET) &		\
+	 XI3C_WR_FIFO_LEVEL_MASK)
+
+#define xi3c_rdfifolevel(master)						\
+	(ioread32((master)->membase + XI3C_FIFO_LVL_STATUS_1_OFFSET) &		\
+	 XI3C_WR_FIFO_LEVEL_MASK)
+
+#define xi3c_is_resp_available(master)						\
+	(FIELD_GET(XI3C_SR_RESP_NOT_EMPTY_MASK,					\
+		   ioread32((master)->membase + XI3C_SR_OFFSET)))
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
+ * @daa: daa structure
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
+	response_data = ioread32(master->membase + XI3C_RESP_STATUS_FIFO_OFFSET);
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
+	iowrite32(transfer_cmd, master->membase + XI3C_CMD_FIFO_OFFSET);
+}
+
+static inline void xi3c_master_enable(struct xi3c_master *master)
+{
+	iowrite32(ioread32(master->membase + XI3C_CR_OFFSET) | XI3C_CR_EN_MASK,
+		  master->membase + XI3C_CR_OFFSET);
+}
+
+static inline void xi3c_master_disable(struct xi3c_master *master)
+{
+	iowrite32(ioread32(master->membase + XI3C_CR_OFFSET) & (~XI3C_CR_EN_MASK),
+		  master->membase + XI3C_CR_OFFSET);
+}
+
+static inline void xi3c_master_resume(struct xi3c_master *master)
+{
+	iowrite32(ioread32(master->membase + XI3C_CR_OFFSET) |
+		  XI3C_CR_RESUME_MASK, master->membase + XI3C_CR_OFFSET);
+}
+
+static void xi3c_master_reset_fifos(struct xi3c_master *master)
+{
+	u32 data;
+
+	/* Reset fifos */
+	data = ioread32(master->membase + XI3C_RESET_OFFSET);
+	data |= XI3C_FIFOS_RST_MASK;
+	iowrite32(data, master->membase + XI3C_RESET_OFFSET);
+	ioread32(master->membase + XI3C_RESET_OFFSET);
+	udelay(10);
+	data &= ~XI3C_FIFOS_RST_MASK;
+	iowrite32(data, master->membase + XI3C_RESET_OFFSET);
+	ioread32(master->membase + XI3C_RESET_OFFSET);
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
+
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
+
+	guard(spinlock_irqsave)(&master->xferqueue.lock);
+
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
+
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
+		       (u8)(!parity8(master->daa.addrs[master->daa.index]));
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
+	kfree(xfer);
+
+	for (i = 0; i < master->daa.index; i++) {
+		i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
+
+		u64 data = FIELD_GET(XI3C_PID_MASK, get_unaligned_be64(pid_bufs[i]));
+
+		dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, data);
+	}
+
+	return 0;
+
+err_daa:
+	kfree(xfer);
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
+		kfree(xfer);
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
+	kfree(xfer);
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
+	kfree(xfer);
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
+	kfree(xfer);
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
+	kfree(xfer);
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
+	iowrite32((thigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
+		  master->membase + XI3C_SCL_HIGH_TIME_OFFSET);
+	iowrite32((tlow - 2) & XI3C_SCL_LOW_TIME_MASK,
+		  master->membase + XI3C_SCL_LOW_TIME_OFFSET);
+	iowrite32((thold - 2) & XI3C_SDA_HOLD_TIME_MASK,
+		  master->membase + XI3C_SDA_HOLD_TIME_OFFSET);
+
+	if (!mode) {
+		/* I2C */
+		iowrite32((thigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
+			  master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
+		iowrite32((tlow - 2) & XI3C_SCL_LOW_TIME_MASK,
+			  master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
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
+		iowrite32((odthigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
+			  master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
+		iowrite32((odtlow - 2) & XI3C_SCL_LOW_TIME_MASK,
+			  master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
+
+		tcasmin = DIV_ROUND_UP(XI3C_TCASMIN_NS, core_periodns);
+	}
+
+	thdstart = (thigh > tcasmin) ? thigh : tcasmin;
+	tsustart = (tlow > tcasmin) ? tlow : tcasmin;
+	tsustop = (tlow > tcasmin) ? tlow : tcasmin;
+
+	iowrite32((tsustart - 2) & XI3C_TSU_START_MASK,
+		  master->membase + XI3C_TSU_START_OFFSET);
+	iowrite32((thdstart - 2) & XI3C_THD_START_MASK,
+		  master->membase + XI3C_THD_START_OFFSET);
+	iowrite32((tsustop - 2) & XI3C_TSU_STOP_MASK,
+		  master->membase + XI3C_TSU_STOP_OFFSET);
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
+	iowrite32(info.dyn_addr, master->membase + XI3C_ADDRESS_OFFSET);
+
+	/* Read PID, BCR and DCR values, and assign to i3c device info. */
+	pid1_bcr_dcr = ioread32(master->membase + XI3C_PID1_BCR_DCR);
+	info.pid = (((u64)(FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr)) << 32) |
+		    ioread32(master->membase + XI3C_PID0_OFFSET));
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
+	master->pclk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(master->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(master->pclk),
+				     "Failed to get and enable clock\n");
+
+	master->dev = &pdev->dev;
+
+	ret = devm_mutex_init(master->dev, &master->lock);
+	if (ret)
+		return ret;
+
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

