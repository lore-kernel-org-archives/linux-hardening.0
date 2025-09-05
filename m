Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC993451DC;
	Fri,  5 Sep 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072277; cv=fail; b=m1kdos+QT3/L5vHepiOzWbdYied5fIDa8yBpx1XCk9OTb7d5Q3qf6V4e6Z+NJf7qkzfpcnMQrtqcogv7yWYDXm531I0zSogOnhohEkI4hkbLIBxMyKPbmsYwfVZTeGMvU2bP63fiw+9j5FUX/B8/vCG/tLaIieMb9HqNpfhJmRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072277; c=relaxed/simple;
	bh=AWyvjdVq6j3pI4jV7BSed+OWCNrxDf02f9Ua5tG31FE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=euKop7p/j2/ml3ub+P5mvBqKQCCBd+VavkJ9jlp0iR+sI4RjbIwDfOIddsqSlowv4LX5oK+Xwd9sA1qjMFuyzgSaDATfEv4+Wz9qZ/dfQMixO0KwRo6+18Nphp8asWXWvAZdVxTiSMOqI6CbkmK1+ZYtF1OIeFpt92YzcMsHpIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BTDRSI0u; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BTDRSI0u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLc0uLY6VkyOO+5pUu/NstCxF8B7cuelztyyBhh1jjCXQJVfmDqZQpBK7ku74fi8lJq+1sUPK/NG/JnBkSPMFY4e3E0kZYe3PotyH6t8uEyjbw/blWwV4N15CsTwcIjTIvm3fsrB2nBeUaqNCBTnat0BhaUm8UCfr3zn6AaaL+Fp8ofBKWAGWQahBEiHgQfwe/49oXz7xr4b9VIkg8j4clJZKEur56gcoiH8QkpCYlOKMqa851zvbYzVHeMEG2xkRP+GCKPFqdPm1twcM8Fc+EMseBfFap8TI36Rh7wcnFmEmmcKww85EJmhHX0Rw4AaZGgvcUXPQZyAtK1jp8qjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtrsQYJNDjvjXvf2aab4yVGNWtOtFHMex3s6H3hZMo8=;
 b=t5bL524/RUjJP0I/knYsWRhFW/RCKmTyEGW4bkY6zhntwsBDvqtkdd8uu/TkSYNy7cZqwERC5jzd7IxGQ8HX8Y+QpVzBSgwVG90QS2PNfXItu0Gu2GVgWdzCoXJT+BlHkZJvBpsShP2huKeSEH82j+zp6eVym2dQTwiKGtOaaScqkYSTrYAFHq3PisxDLynq4dDI2ZCOk6dVijTrSFxL9NEUBSvF6mnDCSZBANbZGvuI57Y822ROUdkrtndHdNMRQEcmjzGgP5OOIh6zfX0nbs5n1sfoorZTSUuE9OWcqbhMjlO5sjYAEgBxxAUqoPXcNa+thBn+M80M78htsRb3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtrsQYJNDjvjXvf2aab4yVGNWtOtFHMex3s6H3hZMo8=;
 b=BTDRSI0urreAoBxV5HvQ28rxTmGTUVSOKrL8dngkQzvNZreCN1FZffdjrVRwq1zR63NOMOQEuT7Y2sZL9WAFeNFVVyuYVP8YcbJokWbBQBn25MKk7Erhn58ameG2irc7VQgbZBrYRXiC/jR4mjWmmWPlVRJ+vHEMtYv0NUSrKfE=
Received: from BYAPR07CA0095.namprd07.prod.outlook.com (2603:10b6:a03:12b::36)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 11:37:52 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::45) by BYAPR07CA0095.outlook.office365.com
 (2603:10b6:a03:12b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Fri,
 5 Sep 2025 11:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 11:37:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 06:37:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 5 Sep
 2025 04:37:47 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 06:37:43 -0500
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
Subject: [PATCH V4 0/2] Add AMD I3C master controller driver and bindings
Date: Fri, 5 Sep 2025 17:07:38 +0530
Message-ID: <20250905113740.3841181-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d4a3b2-7393-436d-a85b-08ddec70a609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Q+D+U9Yxh0ZfelunpOVgJopohUCAXTWT2RrJEibgAf29mBEg1IbW2gRpxol?=
 =?us-ascii?Q?majzQa6B3akoqg1Y31904OhVzBY/RKTfAqjwnb0TosGilNP7GXGNvXtqXS1t?=
 =?us-ascii?Q?9NNIWn1uxWsfk1w1IVWFicmRjssjwHd8gLgiB0CpUUgiszd3vZKIS1V7u0cT?=
 =?us-ascii?Q?zIJoNn/tBwnSO6h7TttSnHMfTBt/lXiLp+ErSPHO42n++BnSIOonpS43jzR/?=
 =?us-ascii?Q?7xXPzRyU8zbQasbKLEVGhqCkaGdhkba56OVvRgS15Tav85Oi0LKUl212H2z4?=
 =?us-ascii?Q?IVTY6IoEbRq6zDpYcYXFTbQWxROvQYDF4XZtR4T9nrKwRvnNAg4QsN/0z93A?=
 =?us-ascii?Q?Qw9T9zHiu8hPswzWoI26dlpB0J+Vy8pbte+UQSgtpC3m8lTnvZEXgBPSAnkf?=
 =?us-ascii?Q?/iG6Iz14YAyGmzY/wPGd+1JtBmZiNU53XuEcmorIRESC3Nf8gBwBxCkqyAi2?=
 =?us-ascii?Q?a4XT58GHkQxcanCTNaIRGXjK2iwhoWzNPdUfz9FBgttgqv1n1CSNd5HgA65S?=
 =?us-ascii?Q?cJa783tQN4YoyWn7R22GzlxUaw+meIQRD+yh2NSHwOuEjET6SIIghMU8Duj2?=
 =?us-ascii?Q?10Wy8LZNHBssv4KWQFEw8FoqEkVZ9hV1JllPtLqHINjFTApdNoqWoWvv5Q9r?=
 =?us-ascii?Q?SttkA4/YaoFaILUjCRVx9f+tu+tHPzXlS8wR9fuML2LSA153naAj3THV0RMe?=
 =?us-ascii?Q?is75JYI6DsTLZco04bc0EK5Z1RibsEHJgxpkdXXR5VSWDnEV1VcgF4zyYFDn?=
 =?us-ascii?Q?IpO7HWKuOIM/opyRPuX9N4QHVV+cixyvX1NbGjvh7KHwcnrxbA2ylHmRhCgj?=
 =?us-ascii?Q?eJSz1zzkxRUaUtOUkQSXUejFNmDuAZ3fE8qNXWzTOPgCyUWJ5UEGmCA/w9Rs?=
 =?us-ascii?Q?XEBrnuxrrydY2+gB58dKUleG5GXPZZtYjH8gvLJwgpKXfvDknLgO8g8Ohfdr?=
 =?us-ascii?Q?89L1GR6xAo7K2Eo2HvSWl8qu+RgkLLmzvT4F9QBGfZQVt4csFJMJZja4MMjX?=
 =?us-ascii?Q?mDGTRgvR8tckT9pfxgoLabj5/EDl+gjYc/9pdHP9zJaarOGq421D0MdEeJvx?=
 =?us-ascii?Q?7/pk1b0XXBT8ynKHXj3AcbXhbuh5YBZI0c7MqaDDynkC7BjkLrni/BVY+Hq9?=
 =?us-ascii?Q?E3/okkJaSmZBe90bQAIj3/nfh+qVY4iQxliopUc7Z/l7qne4Pd7W1fFXLQwu?=
 =?us-ascii?Q?maSRprzDxjkq4LDbEgV7gt4Ir3PiYsdL5ZceMyU3LLVSE03vfQ4MAxjTMxYd?=
 =?us-ascii?Q?m91UttDVHPCDgUtUPCN3EVQtumY//bH7FgPbKc9uIIGz0MivRlDcjTYIqhDj?=
 =?us-ascii?Q?egEAGVMxvfpSAfxVM5erot1m0/5RO0lwXbmsUavhsZMf5+fXaYFX8e/gnncT?=
 =?us-ascii?Q?Xk5DbI1FuA6dThN8TeIMuFV1G+xu7Z8Q7pB1EfrqpY0YWKHnlkAQt0D82rLV?=
 =?us-ascii?Q?7QDT/4M0Y6YIzSmfFjQVuj+isgnx5KfI3FhIAsHsOBPKNoBJCjFv3wWm+6nF?=
 =?us-ascii?Q?cwOUI1Ze5c6rwlXBikhnh1pVwfutAfkC9hlNKQthmKrQx/TCpYUZkTnO1Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 11:37:52.1283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d4a3b2-7393-436d-a85b-08ddec70a609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359

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

Changes for V4:
Added h/w documentation details.
Updated timeout macros.
Removed type casting for xi3c_is_resp_available() macro.
Used ioread32() and iowrite32() instead of readl() and writel()
to keep consistency.
Read XI3C_RESET_OFFSET reg before udelay().
Removed xi3c_master_free_xfer() and directly used kfree().
Skipped checking return value of i3c_master_add_i3c_dev_locked().
Used devm_mutex_init() instead of mutex_init().

Manikanta Guntupalli (2):
  dt-bindings: i3c: Add AMD I3C master controller support
  i3c: master: Add AMD I3C bus controller driver

 .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml |   55 +
 MAINTAINERS                                   |    7 +
 drivers/i3c/master/Kconfig                    |   16 +
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/amd-i3c-master.c           | 1014 +++++++++++++++++
 5 files changed, 1093 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
 create mode 100644 drivers/i3c/master/amd-i3c-master.c

-- 
2.34.1

