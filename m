Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC51FBCAE;
	Thu,  3 Jul 2025 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541286; cv=fail; b=hGeZRPABGyjHLdQ9srelkTmaQTo05FcxqY2AB/oSN35j7ssv6KltAfQLitEyJG24RSDeCbXsyCBIHhctdXQAH5yEY5S/B4MyZaOHOSrvr5LiW0mQ4NiLPUIEBhZ/x3s5wN4Jyq0oLU6EVgwMdORfP8cyfJ67kD0lMQomV/30awo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541286; c=relaxed/simple;
	bh=Yc/n0m3tgHTt6IwGcnY2+xhnXi1GVoEfvOFg+2TeVJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZq+V6T7KoU3R+yvzaJCFa7Uwbc4kfWSD8ljcw+Gg/9qKorsaAOLax2Ea2frRCY2gV/lBejS4zx7VwTZnmILDVPq0D/eXKxFgUYAyxXjhZLvqOZHeJShfpsArn3uQPa4gY2a0QH319JYkTiuwvGbXLigsC/EXc4CBJ8ei+KOGmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WSZW5BQN; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WSZW5BQN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ki6MaJfMfbLX7umHU+k9cWo8zVr+0sK1msV0xlbADFeZRmyCEQ4HJvOToX9oTICxix4tC9pNTr2ykckmkM/K2RmLSAGfvvVJM2tJIwc9AXJYeZMaXL5oJZpd3CNv6ouxqmReTPklZSmSKPXW+1BVjNX4s3cKoITMbLHa1h0h56STIRlTv7x2sO9vXzFbAcs9WfREDtkitBrg+Uku9AuV3FZsAq1gd8mTDf4ugas2RJ5Tjqp58YA/aEqz7uthtyJe2ssyboO8tJbmP/Rfmh1CpDFHTs1EmrNi3gNMB1h3VR2f0GQ6O1kiZX9oeakpEgtdDlYbvlueImWbkMMHuUDOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht2mb+8fauk9pDaQ5LmWohg5Cot9yFTujtwoaCJC83I=;
 b=PtNulOcF4SXkFNWo1Zr7yhv2sBWJODoQ9GeeEiGrhzXYxT9ntC5dTWwxb6peaSd4w0fpV9uo98JI5DdfyjDZ9C6Ucw8w3vjGMtm8t/aKaTjxUf75i5jKaq31CifzVF1qmgT1VhjfdE8vsgSxW1/vokWEm2/GpYFtCIG7pNLfzf5Kbtgq2I0Vh/iICJARYJhMDmdPpDPGstVCJB7ucQzpczxrN5g5NytdwKDEW3AzC/KMKVkVkk/KwQAZXJpRz3APB8lwzPMhLU30A34e2BhEwENVwQPDdYZKyaJyTwsklWIOExbdnIH5Mn63C0csLUu3ARGoWi+nKw7upIAuuKj4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht2mb+8fauk9pDaQ5LmWohg5Cot9yFTujtwoaCJC83I=;
 b=WSZW5BQNMSqax1XzMIfIhLv7IS3eij6ULFBA9nZ2TwJROHnzXLr64dXe0huJHIOxlfayWPKryXo4x25eiR21/Gv8yAZTfFOolHRr9vh1EZ/BZ71FQcXvqUdTDD/qiR+/qQ7Y9m5wwQMpRwqKTGSScq693vMY6eYVcZjjHBFtPOo=
Received: from BYAPR11CA0080.namprd11.prod.outlook.com (2603:10b6:a03:f4::21)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 11:14:40 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:f4:cafe::e7) by BYAPR11CA0080.outlook.office365.com
 (2603:10b6:a03:f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 11:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Thu, 3 Jul 2025 11:14:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 06:14:37 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Jul 2025 06:14:33 -0500
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
Subject: [PATCH 0/2] Add AMD I3C master controller driver and bindings
Date: Thu, 3 Jul 2025 16:44:26 +0530
Message-ID: <20250703111428.2111484-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1e8086-a7a5-4b17-b136-08ddba22cdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rCrLulbsqHaZMCFIx/Lwp63tfZr0zUS3m4+Qxjwy2onrWYToRgqg4Od8zGt8?=
 =?us-ascii?Q?JTe1lnL2J1ekCfzA2awAG1raQ9s6HyYo/+JrQLFXGXIu/Zz7gMYKXO/vQY5d?=
 =?us-ascii?Q?4P46PkGvk6qvnjLn3JXOSgNRFF5lNchFGVS4Xp05Q7JeKdkoJGM7tgPCsncs?=
 =?us-ascii?Q?ylv5YfcReAe1p2FWaDdXZOBATQS9SvvIUlsS4UyyTNaeDV15T9+HRlpKdJBQ?=
 =?us-ascii?Q?CB1gOQ6PdeVTacn/569Bbs0aKCl090H+N34RMo8i2GJh/BUL3U8nvZALh/h/?=
 =?us-ascii?Q?wLR7iDFPMkWiDOUbBe7aFAn1gF3bwjCXT8blGVdTT5R3V8GYxF3hSTGSzRny?=
 =?us-ascii?Q?7o+7NWu+WF/9oW8lEg6LsaNF/awaG9RnB+nayqYRbCsgwNezeLs6ffE9vgBn?=
 =?us-ascii?Q?i3GXhRyakLomyLpuwl6WtwseB6dVphqr20tbydPC4GGTQDuZbYlEIIaZQjeN?=
 =?us-ascii?Q?YcFrd3bzXzy7NI/6oFAex9IqrwQwGzHxb83bV7ur/BuH/LI30q8inJCruDyz?=
 =?us-ascii?Q?bNoI+Tqlo7SpTPOEbOTvR8e3KZZhtipDlkQ36UGCbx5DgtLhJdwS+T1L3OcV?=
 =?us-ascii?Q?HOoxMT+bTYC2UrNN/JTWkIfjrZtCA8ix0OiBuPmu0K8NtpObmkcF02FnoWBF?=
 =?us-ascii?Q?YQhMoN7W1UOfHw9Yr+frzPzr849MGqtUis2kJB0zLhgthU4lg63d5bnzVvE+?=
 =?us-ascii?Q?PKedf1v2CtSMQfgGz/5X4bpEj+f+00oSTyzJjWVLUvt1TEaFAMOMtBofjgPs?=
 =?us-ascii?Q?OztJNePwdsQ3P4caKQSsavmJSljuMYSs4OlP0NgYfzPME8zBYLwZm4yAnEy6?=
 =?us-ascii?Q?zdWHYoBOCq3wC/v+ytELeUj4g5muswR77CdcnshHq8pQbhA4oQJ2pGjln3yC?=
 =?us-ascii?Q?S1Cjn6gC8l2oK2ml4RBzD3ELTXHZMGr3KsX8+il70dtsE8D+mSdZNut4MIhJ?=
 =?us-ascii?Q?OiQGG/z2JAyoJMEbxdppv0sNX3fPQ3A6iM0hjRHa5WXAaZczfLqO+G6Tvo+J?=
 =?us-ascii?Q?BBL9tiazgpV3WrrHdgXYRDo5D9+jZ4Py2KC/eaq2BsyXdcq3YCdjroQ+qGyI?=
 =?us-ascii?Q?hpeCNR6WihjJyWXGPMFQEytkH0O46a/+JH20oizYusiPIQqDeCxW2PGCW2ug?=
 =?us-ascii?Q?ouQ4CDYY2RDrp6d2OoZVsMvArORND8yjs3b0lDbXiTf97b0skHwAYZj1zFDh?=
 =?us-ascii?Q?ULQpr1OCNaVPFGDIzZO/aROLhnD8VQmVLyXDrtC88WbnGWPBC82ZigKzr87G?=
 =?us-ascii?Q?KpOG2Gc3FPsH/2Dxj9v1y5NrQs6+yttotJlFOx5/0mTFDc6KSTgmO2USIfoU?=
 =?us-ascii?Q?e19+1fJbZw0RdZ1xC8Me8jIB3cVRzk8tgJUgRVY2bOCBHxWaNPPBAzyl7+tW?=
 =?us-ascii?Q?dU0H18kRkFvn8Tv7ZvqfuJoJ5QNsJpS+Hac92c8l37SyjYUklmQHfwzu2py1?=
 =?us-ascii?Q?mPmcl16KGPLOpT/6LNC+usMLMKla0b5F+KlhJnKwsZnDLNQoSlrVwNoOqLmG?=
 =?us-ascii?Q?f+7RBVYC3tFj1cRs6yqGmuSk7s77niDDjbWQ/2BOTV88wmxkDiZDalXvaQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:14:39.9727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1e8086-a7a5-4b17-b136-08ddba22cdcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

This patch series introduces support for the AMD I3C master controller,
including the device tree binding and driver implementation.

Manikanta Guntupalli (2):
  dt-bindings: i3c: Add binding for AMD I3C master controller
  i3c: master: Add AMD I3C bus controller driver

 .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml |  61 ++
 MAINTAINERS                                   |   7 +
 drivers/i3c/master/Kconfig                    |  16 +
 drivers/i3c/master/Makefile                   |   1 +
 drivers/i3c/master/amd-i3c-master.c           | 945 ++++++++++++++++++
 5 files changed, 1030 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
 create mode 100644 drivers/i3c/master/amd-i3c-master.c

-- 
2.34.1

