Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C926980F;
	Wed,  3 Sep 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893563; cv=fail; b=bg7cNugn+ZeTOZk/lOcUDDyNVQQBp/YHF8uX2UPox52OjJOxew+7a+CjyGH1G+xufDvsQKWMu2u+Lhn15os/qahDrMtd2y3Iv0yHo3KtPd0mOMxrbn1cH/NR9hY2lSD/Fjo6nOppl60DTpcM2fMrNLA0pJrl8I1XZEQnWXly30k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893563; c=relaxed/simple;
	bh=YAdEtdKqxtB+s6Wpsy8lmc3eX4GdRGVx+LlIjeoFPVY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jqxQIFUBtq7z/BP+qeRaTgPpKwL6qnQin4WHstQ7s8WHjgdG/HSJ3pDBhsCYy8/UetsUSYQIIZjZOQjSq77mep6K5HbniszEpcWqOPIaRywxOScXhwVJvVFtXxjmSS6u5SRP+20kpwOydAvQx98LPqzLe1ozKVZaX/GliID/q8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M7wLVcni; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M7wLVcni"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UH1HP33klCoBSde0W46Dkgw32htrhogL6Yi7b8E5zbxy7yCtyW5SZI6hqpZMxVWO8m5a7RQWLLaUdMqpGvLEpc9La8f+/mVyguDufL7NJmFTU4OWe0kzk86DGQUmwDHxFekkakzYgBKT7fCAqlS00j5FYvJeWiViXXqWVXBJTw2IDz/yAkjKrVkmp1vxBfEPVTMUUnvUjC3REfdJ5bb+kWEjgk0UDyZAhRquarBj1DP2D7cxF5gp+wuaVnvnt62jiFB/oKvfD4NohylhGlx/9iR1vGTe8fSzYfXmS/iwfQdK/v4/3h1FVERoeBL7LrJRDzV24klvplPNW6gyxIHXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4c4GfvRNtl3xZGpuoYR8qG7bGMKrPB1Lht36EvORiY=;
 b=pkYI5IwH87+988T9my9srzDCXUM7DmPo6HUSqaB+AAVAq+mx5c6smi8kyEFUc2hpt+bC+iRkCOUpBC02ziVyb9qhi7FsMab8XBoFqKNN+FTJFD5ZFQrqTLW01u1S3lmnhBds2aJJypEgIrw2/BJWIXBp/0eB9REyfxUNz8JVMl2y3wAYWf0kBPg5MTZeRJ1t69Wpho5UQU1F9Z0inRp8onBP+ivneqwK8u7S+IYmWNRAeJWrEZPNJpjNsOEPKvwMceLI5vA/CyZVzdZwP/8WLbGuTfBPUmAMKspjtffOfyctaPZrTjWj8X4jXgOBNyShvQ1TJl9GEkYgjlbi+kU4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4c4GfvRNtl3xZGpuoYR8qG7bGMKrPB1Lht36EvORiY=;
 b=M7wLVcniml+Rqopo66tBHlO50HY4/edB9y5g1YCRDOGpKa+6njdcvw9xdER2K9UMLvrhzItn0gNrMCp+yF5ohY3+3SSLVanMMf+fupOHVuGaLvLSPM6YE30e5VQoDbjbUeH7GRAy1wSYvkuemJx4D2mAcjkLPHPFN+MX7/dEno4=
Received: from MW4PR04CA0389.namprd04.prod.outlook.com (2603:10b6:303:81::34)
 by BN7PPFDE2ACDA69.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:59:18 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::dd) by MW4PR04CA0389.outlook.office365.com
 (2603:10b6:303:81::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 09:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 3 Sep 2025 09:59:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 04:59:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 02:59:16 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Sep 2025 04:59:11 -0500
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
Subject: [PATCH V3 0/2] Add AMD I3C master controller driver and bindings
Date: Wed, 3 Sep 2025 15:29:04 +0530
Message-ID: <20250903095906.3260804-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|BN7PPFDE2ACDA69:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4a2a1c-a098-4ac9-712e-08ddead08bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MEWKjkCybrHnLod8GUZDVJv3mtNHWwilm66hseG/0x4AU57GR2wMfjR3DuN5?=
 =?us-ascii?Q?E5qcnNs6s6ahAx2b6oHqlephefD0qigV5NTIj3IalBsxnfOBp7TvXwntS4A5?=
 =?us-ascii?Q?O5S1QdLExPgPioxnZplXMIOba5ftGypqlAU/mOsMa+yuecoWhkOIppv2Lw4z?=
 =?us-ascii?Q?XdG9oloxHJOx/7xg/GJA0NqOb5OEa/hPlK116WYF276xvi3X/vcAiMZW92UR?=
 =?us-ascii?Q?75YSAipiXsz9twq2jPElMTJMVm3thUmYici4hQB5o1DnaNDXLzyKr/t3fJfP?=
 =?us-ascii?Q?avAVl9G++yrinbK0AyO9qYU16ZTpSQmSKZ2MiW0uKLkjVwX8fcYdZ4pa94RE?=
 =?us-ascii?Q?4nzEYcWIm6KmSOLNhQBr5yFwd+fPXt1b+zpzMyKU83tqRu3EXNEyHBYPyffN?=
 =?us-ascii?Q?KQrvtTjFcpXsohjEO60zOauEZ51pS4O8bQ71fhS9Ke5KjUcJhH4d2haxpfZ9?=
 =?us-ascii?Q?oaAQgMh/sADYkglyPnwGLQpfTZal9agp6pNyZHzOf08WbqHuWgBx1fxoOlWq?=
 =?us-ascii?Q?vjyKjtXhALqb3cViJsKd9AedAG+0R2KUyxSwBuXDfDkIfzoPs2aDrmHaJ9Wy?=
 =?us-ascii?Q?maOchcGrD9zdN5MNpQZiQCU0/afwNMSkoGtAd+3tQrMiBKZzWI+/26XO9QbR?=
 =?us-ascii?Q?pDFg/45ZI4vUfaVV8ANSuF3ityzK2zokjGh6MRph3SylKFOwOgtEddvEM9zN?=
 =?us-ascii?Q?oX2BM9+Lcs7GaOALhR1Zxle3s2GbXdMq8xH67iS6CyJ9LK4c4sD+Spc6oSws?=
 =?us-ascii?Q?5KweMWcIEOp1BA/em3/L0Cm/3aZTLcY92DZH7IMn56jLPpBdyAzUSdss2KMg?=
 =?us-ascii?Q?/QSmoxTq8foB+L/Qv3VUujS9yMKWglFmmW27MwynlpU2mCqZYT/48KjjfNCP?=
 =?us-ascii?Q?NyhmyYmwGCJq8/EF7iGeS5Y9/5t+4xFWV/ecdVafF4joWLfwzAk49yI2cfvz?=
 =?us-ascii?Q?bUQOfF4B9WYwZDZEnfAHeGr5Y0T1CNl+VzytBNNMpNwCr0D56+gpj/mYUDzf?=
 =?us-ascii?Q?IFxjOCW0dosDZDdEEnUYCBjCRHXPLL3jkoPiXOFEKZwaQCivCdGTthzLzbLP?=
 =?us-ascii?Q?1CF8kn8UNOj8ccjxPl2wvugYtXL2FRxkAf0nmrJwUXMv4XG7jLMMa41PaxfK?=
 =?us-ascii?Q?2L5BsRGGNeExCF9ZUpN9156IVCptXCdya87gFhot9s1Hl1HyiXoHXDqPjXpc?=
 =?us-ascii?Q?3FOoeD/BW6oYmQCOjnpU8jzbxOnDJSDVWEPWwbC0JHUPdyr25ku39n/6BwP+?=
 =?us-ascii?Q?xZAnm7LUndkdjeUm3ZA7N71Rs2H5GAWZaRJ9WLFrzzwS1oGiQHumYXVXG8mX?=
 =?us-ascii?Q?ensx32ZLUdtk5yufksu396o479eLFeCgQhV7GnYTUSSW7r/OE7hWtKP0ribP?=
 =?us-ascii?Q?KqvOiZJ3aDIQ70VHIvFyAYZarWZBQzrPCD/D+KlgD01duwE+apf56fXijrPA?=
 =?us-ascii?Q?SK2nVOpmQLmW86lKipq/I4cukcmYgRYory4tM2+dQ406/eHCiypR5MhKRcvt?=
 =?us-ascii?Q?NF2601OeM/ruAZEUMS+ZN1dOWhbt8XRNvY3E4e7geVCxkP2Q/t5siG9i1A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:59:17.7605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4a2a1c-a098-4ac9-712e-08ddead08bf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFDE2ACDA69

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

Changes for V3:
Updated commit description.
Corrected the order of properties and removed resets property.
Added compatible to required list.
Added interrupts to example.
Resolved merge conflicts.

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

