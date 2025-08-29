Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938972222C4;
	Fri, 29 Aug 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487626; cv=fail; b=XWrmwhG5s6/yuxf0lOArr16sd55hN4Dzg/24r9KfKMVgR6POXJ3bK9mB3Ekd0udBGsXIuw5B8548yz6iOV8ZSgTQ7tPXjlAYTsqqXHCofDRQnorLvKmqczgpm9xMfGogGoCPB1D7g+PR/yhgh/kLFLK2ofKj3M3mGllp7VAso2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487626; c=relaxed/simple;
	bh=LtMY2e1VsKnAb7vUPZzrVgyullT2Nv0MrD6u4I3OdKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PxBrXjZiHlRqWJU8aXNIrPCfnPPz7blWzUTwrdKGHbVjKLkpf92s2xLJRgdnBeO7tMhFFKs5hTiEHXhmp5v74+8v5RuaQUXTu3XPLQXVfRyx0NuBB9b07IPYtRNrJ2D+SngLHCKmxf5PIvZ3qPcguH++VCOdd8giCAx9oV1v4AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rF04W5Nd; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rF04W5Nd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mn4+VICcevJnc5Tfpf04KNJ7XZnnTqnUrkQ77xNWo0c3gGiMOazjOpd3+MOpcTRqh2LXPh725TFeHPcNZTaRUTH91xkLPLpGqlDBJl6hQNMd6BAMAGe4hhTGj9DidsQeMJEAzLgRA4co1tMLArsu741cdpgU6CHo2TKSbTEMamL1a+1vscQvb50kMIAGlQsJNx35Q8HAf0FS/Vx82x/jj+JuOM3QOD9MNZ8EWOIXCJO6Rfr3zHjGFWfEqysY7+JvtcUIndB4Lo3TzRb5TkLpZKbG88JcnHgrZIAdHyReXWTdkvdhZ5n8ZBQrafL95oNQgqEw2ZoMsu27UUDhsSpn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHxuEj4xYWn2jrkVsn9rumgrwp7h6BVwiymR2F4Y97I=;
 b=ZW9/nFtwWv8Ay2Xm4EzJl0D7AxsBs1VW/4U4kjBi/TFDtYW1ojLXBKmTbORPw0zSm/CLQVB/rIsoQrGl7YSENr9FccXTFNjXK0/MTmIiK0hbTon1uCeMxDcI5bg0RCyMypAmd+zgCL3ukQwa1Ni1lpcJvOTuUN89SJzwcZvlSHvpmdz7MkoJqwxyX7CLy2gIjhCEJPcxhVL4v5w8VwelNGhHqJLC2ANuCGiDCxCyNzYq2fywwsh5RRAMnYLHG4wH3zJOT2rpevLifYLhaevUfifCyuEBs4iE4JaUgReD0CF89/nKSLsiI+zK7dvX4kS1qvs1Z1H8D3EeRec8WiUgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHxuEj4xYWn2jrkVsn9rumgrwp7h6BVwiymR2F4Y97I=;
 b=rF04W5NdPzikFaVCu22+meu/gaLHJnTRapLwx5wOJkeXEdBtd+3sxUdoQc81sok3yLm+bpwHxBOV/Ixhsi7DK29xBE7G6ypY+R61PwYJMOJhYjfo9+LKiG0Do/6cKJhESiO58sFdbVGbV6BejYAni0HIH4vJYjgVm2sGJHMvNBM=
Received: from MN2PR11CA0018.namprd11.prod.outlook.com (2603:10b6:208:23b::23)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 17:13:38 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:23b:cafe::2e) by MN2PR11CA0018.outlook.office365.com
 (2603:10b6:208:23b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 17:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Fri, 29 Aug 2025 17:13:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 12:13:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 29 Aug
 2025 10:13:36 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 29 Aug 2025 12:13:32 -0500
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
Subject: [PATCH V2 0/2] Add AMD I3C master controller driver and bindings
Date: Fri, 29 Aug 2025 22:43:25 +0530
Message-ID: <20250829171327.2590730-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: e89576e2-3790-47fd-9fed-08dde71f6500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZpMwEsKHzLQj3YKXXoe6mXmxzwe6ViiIgMNC9EbAIPf9HYN36wVWsCNAgkSM?=
 =?us-ascii?Q?UqxaDipENepuKmvqeK8N99Nvoq+KfBuH1fgOW/MykQtW2DJszC1ggDiu/FyF?=
 =?us-ascii?Q?Og5yrylTiRKi3NtXTAqT7vCnk4zrDlCw5S3Evl58SFhaGaIYI+yWQ8sIgyly?=
 =?us-ascii?Q?Emb5u5nZPVUmmJDMvBPckCd0BGitXhMsLuViGC0LwqpYhpDqD8kaSXEml+td?=
 =?us-ascii?Q?/jd22RerPOign7W+zTxWUz0jSFUucG/FlqMDbivLVQtlIVF14yBFlza0mTzt?=
 =?us-ascii?Q?oxjX2DD7nwBb9Bxr+8Ckg1PhxF3ziOXfoqtT83xkmn1xQCICucZniW+UtGU4?=
 =?us-ascii?Q?aIJqgR/p7/esxU00R1jKNVOzirhxAPzV1VD4yjwi7JzQppkjRm8tk8gx9Vwa?=
 =?us-ascii?Q?LLs0wjkd1aHtcKnQsscEax92K5xvI+lRzGyC6gqfoE75ax62GLMTI5WLbyjk?=
 =?us-ascii?Q?BqWUePmKgMnLijtXhFhJ9A4SsB2Vb4uMGmWOXWAY4y7Vv+mMIlMabkKHJuPq?=
 =?us-ascii?Q?Qzw9Z2JK1myAEUHeflSvyXqBabOW0tuZnU6brbPvOLedvqdu0UJVp8uRTQum?=
 =?us-ascii?Q?PLk/zjMGd4nOnSs1fg+klGQfyso5L1d+b7LdzzRomJDndlRE/J51ektjSAzl?=
 =?us-ascii?Q?A8UkolIRfj3pvDlMrrTmmzB+qF1TA+e9tvhGA+GBP1STJMnvQy96s30L3VJe?=
 =?us-ascii?Q?h24ncAoYMisbSkwkwUxW6NpTl9ev1lNk07XXbmbUJBoZVAWaFDzFdFMEIUuL?=
 =?us-ascii?Q?cQ0qvAeWFtVIzhuTMrxlkua6XPu4YyxXUC8PLuR3KUD98YGCvTrgy12i12nv?=
 =?us-ascii?Q?3svUABIe+E2UM4tZRxfGcYhMGWaVv/D+Ym6K4Raqq0YPJzawKRN+C/IVyPyq?=
 =?us-ascii?Q?QEjN2aQMH09qh2BX3dllJd3biQ7rcz4lTs0h1zbYJ0H3x3aFCpe6wqmJovbI?=
 =?us-ascii?Q?bNCspJUR+IzhMhIJxEvibGdcMZlb5vCXz7/S9sbiqhW1oY9saYVx0EZHecsE?=
 =?us-ascii?Q?HSs3t8Bz031f2tAhqmpi2rEQAoIeFtThwPaPhm0kyHVUWqGhW0gS38SaEQyR?=
 =?us-ascii?Q?AzdOsDUI8Pr3axbdr9RmipCvFXDFwM6zatEiIWPmanHLfg0dCLbCuzne5FmL?=
 =?us-ascii?Q?g+KI7m3bkJuy09c0ZjHbXTVcbGvvGJjibrC+4Za8YEHKPynvOJCoDxhCcB/L?=
 =?us-ascii?Q?BS5Bgx2SsCGsiTU65QxmjgCr6jLFNf3gzsyW1oxpM3TG64lvo1pSfDHfYmiT?=
 =?us-ascii?Q?Ijt4dY5el+3Ymm/RBYRgNwrYBlX3T5w/etCjRB652GCgXk5WMRiM/o11oNHi?=
 =?us-ascii?Q?tDYTKseTnqaaO9aHZAMFBhpDdcJHrxKV+FsUJC7s4Qw4yVoOii1qmFo7BxUH?=
 =?us-ascii?Q?LnyDC5Jae89Q6jEUVV7DNX6fGePyAwiWMXMeQDSJMri0XQEUF6lGB+3v+eUB?=
 =?us-ascii?Q?070DHsCveg4owzC97vYE6Etu5Hw7TZp+Qm2nhQKqh5vbPygeRSEVIhG1A7KM?=
 =?us-ascii?Q?HAXMOn7WZd897tjJgbIjiI4LzN1a2yRB3i3YRLrWNGatDFz+cjos8+d7PA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:13:38.0580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89576e2-3790-47fd-9fed-08dde71f6500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427

This patch series introduces support for the AMD I3C master controller,
including the device tree binding and driver implementation.

Changes for V2:
Updated commit subject and description.
Moved allOf to after required.
Removed xlnx,num-targets property.
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

Manikanta Guntupalli (2):
  dt-bindings: i3c: Add AMD I3C master controller support
  i3c: master: Add AMD I3C bus controller driver

 .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml |   53 +
 MAINTAINERS                                   |    7 +
 drivers/i3c/master/Kconfig                    |   16 +
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/amd-i3c-master.c           | 1009 +++++++++++++++++
 5 files changed, 1086 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
 create mode 100644 drivers/i3c/master/amd-i3c-master.c

-- 
2.34.1

