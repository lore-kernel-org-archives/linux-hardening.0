Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767037D11C;
	Fri, 24 Jul 2026 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895671; cv=fail; b=NesyHmq8boJnwEpBAfyZV0CDvFejwOxKDMD4oMOK+fL+IF0OGGQHRcj3Vi7dXkm9rC91xYR2hVsXkX5dHhcDIemBgSvWIHsnru/1XfX18fAjUqOV8aQXDEeJTE1/7t8qxrLECp7jud0DHqx+zWlOWzdXZKTEKHTEr/QMGwhUhkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895671; c=relaxed/simple;
	bh=7SCOcROPC47x27c321P/jzELbQE82+1GLqXpixFDi6c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bv5XJRbX9oJvF71gcGDEiImQMdIhykrUBLNKz5rv0uvTwIoT9TE94R2nfkkJ6uMAL/8MT0+tXUPnsX7W7EdSov+mLY0rs6Mc7TFjDa/7N3mVLr2k5mLm3faPWk6Vx4g4C4ejtkU6I0OQlZwLTWEakML07H5McqoBn2jOqixqcrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C1fDZ7/l; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C1fDZ7/l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/qEIww9rBO5wSt+e8bWHvZyaURKYNg0NaHNMTTcIKoe7crfbQXCBjpEeyH1P4nQxsAQxX9vA+SWP0+MgfaAmVgGCumHLC3W1Zm55cI1z8CwCdU2f492mG2HsY9EzZVFett3eGSQxVgK9WODBQUd4ZZwQ9ibqi62ZfZbIQqcb9MClYpWYdSdxrzEF+kHiS4MNu2EPaSxoxMXKYgitsC/+/3QX9NH0+q+g2BwQkNEGamIyvUQ0WPe1na5/Fnk7jns6vtc9ivv7aG4gAA3ffs3DyG3VRzMMTuCRte4bmyPTVvlyynt0GEJnGJ9JmC0WFfXoHtchifMSsvYd6GeU6rdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qFjOW59QsRdd4uKat6dlqTNSb0rc35YXM0B/s1vU0c=;
 b=Y3iwO1Nv0MAj1SnAaCgQZwliFSyoNIpfJjedA5iRbCdckJ/nnloowJFm2RNH7HSZfHmTqT0by/l7ru7jXVXU2sIsACwkgnkcxCbZ9tnntVPjY6Uq1nFwAWJW2gS8cnKYg0P9OZOs9I3CnYKrTz/WXK8V7GbFWXOsj7+/SmYUbdZCF1VpqOtqaoG1oIwZNP8ViSacBZItLrieGMNbwgiEIM0D3+/bjprnFhAucEs0RkrCp0CCH5s+qbp1fkJAUz4Qdwm1juUJZx26Ok1yWfCtBWLK9hVgbwWTfSkjQtCuN0uV3sljS5RvGb8HpKl5jiByUO37Tb+BgjclFWLVQK8AQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qFjOW59QsRdd4uKat6dlqTNSb0rc35YXM0B/s1vU0c=;
 b=C1fDZ7/lf2VJY89LtFm7yuxuqMvqrh2Cm4fUyud+TnxWvOGIWT51H78ubwbXbb5kP8pvBHJG1qKbNjj6tZJ7i7BZ3q/k/NMIAW/xXERTacIFIU+KJ/crXKRi7SpVDjkMCVHrswx8jJ2Fg+DwWQPvaABt8QdgGzGwaqgbueyWuWkYMQai2m2PvrRw0Rd3Zno2heWgPYHtJ+4g02Nw69KV2PNQGCtt8776tQi289ehx0UqXoN5OA1tJeuo7BtPNSEqP1BpTTgYpckA54E1q87bQQKOtf4BPY4ORx5FjuWjgAeZ5BJr6uk+JNGjuCGc2CnzwO4I255i96oRsbgeKh0MTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 12:21:03 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 12:21:02 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org,
	shuah@kernel.org,
	kees@kernel.org
Cc: julianbraha@gmail.com,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	csoto@nvidia.com,
	mochs@nvidia.com,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: [PATCH v2 RESEND 0/4] ACPI: APEI: GHES: Add NVIDIA Vera CPER decoder and tests
Date: Fri, 24 Jul 2026 20:20:50 +0800
Message-ID: <20260724122054.36162-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:4:297::6) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 242bb7a7-e328-448b-5389-08dee97e05d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	F6/BA1rAafNCZE/Jj+gHFgwPNoEUfX0YWYFbSmEKrbRt3rthvpnD473LJ3hSfP1o1lSoDtTk3SDb41DriAW7BMScAbhqW6yh9HY1gFMnNFo6KI5AjTqJWacNZm5Bzq0wziiCIgEbNehhaB3jG+b+EDEFNCR7N7VgWZv6BorrbOap6FrCDEyLlRmiDv3Lk3x+Rk059h8J3pkn66FbU82jmR3sVyHYrYJLr3IbLkGBo688yIMZ8FovJyhWXUNKOvvGOoodN7HIA59iz4arlZhVUf/eb9t1Rt0VNe9c/Cctcrplh8962cWzIgBJpX7tOHS2iCSBJ1oatAGWejEtZMYu8B8MmTwMNeB1nFw0e35YcLTyIgg7Gh0dYKJxY8+ZiiFlBy9nnipX3WntuhiOII9bcVrZGsUWSAsBBu2z4cUn3wUNEchmbIrWJHSaG5ERsnJa0Hnzbg3C8b4LddHMfDwIauHw1UuOfplAMrJmlJJMev7Z0mdAhcgiT6ifn6uRrF5JcmotfUZ2jeFxYIe0Cj2l44HzHLj2SMj6g+IV55Wew3MCd5ktQK8AC6bEo46as6+QClDFUHIkxOPS9/0S71Jcq1gLy4OizXk/k6zUOhBT3zMMRrqkic5RxrEYcjm+BaO/v8Qw2U85xsd1R0Z2T0Oz7+N+uD7EZciVUuZMkb8X8fw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G7tXeLc4bYOpTf9GDiySmnkeyR9XnbGIWwxY+CuDJXLcyPXV4nnZ+a5n6esc?=
 =?us-ascii?Q?r22VQwPA7jEMy/fpsdKAGi85pToZfmtmRXw/n9gcg7028ulRIYvNMqbsI6Rz?=
 =?us-ascii?Q?NIY9YXcU4h4aqwxovCbHXoQXE3BvFEyB6Hxp3tM/3F3qvKUx3L3rdRcNcVit?=
 =?us-ascii?Q?cYyz62s8wLahpWnJHp8/i5iLpLSquieSyLFqIffdHmNNFhqiA5t+lxBJEvlc?=
 =?us-ascii?Q?zs9dZdBPgzzuMHD9krwJFkaeqqwpYv7U4YmOcjsoAKpudqEwZNvJAUm2sSx6?=
 =?us-ascii?Q?5qx4pAKg6gyY3v0htCfabObbjlS2/FJVjPnXgmS+3AY4U2JfLcf0hnZPyva0?=
 =?us-ascii?Q?9TQ1JlQKHz0SUXiqke1jhLphUe017TSLHtiAmt4H8BHXt0pZvhyqCk/BI0//?=
 =?us-ascii?Q?op53rbrQpxLiamVesMTNqP9MaQhLTPJg2ehciwnFz9OSgpxsXlhzBas/41Qh?=
 =?us-ascii?Q?9lCVCJHVDVQpBei1VXsEMj5a8c/wjKibuHDRZQxcIhuxo6VnW1bDaDUgqdgP?=
 =?us-ascii?Q?zjryZrm/GOYbc86wNEqEkNm4hq5FrE4KlOsS+9sZwk7PJOa7DFIpoEPNQb5A?=
 =?us-ascii?Q?PQacGQSPnRXEpfU41fiDa71zpRveiaJEaiUF7rWiPmjavTxF7+t2xh54Z+cS?=
 =?us-ascii?Q?vn0CVJt8wTRCP+vDsQT/S03zx/po8056NnAXV7UqemzSrS1pMmLTFESGnURm?=
 =?us-ascii?Q?hdxu+/4/KILs1LowxaCsgg6WEKRM2XXkzmJMpmV0mwNNEMyvLan6DhiIMW4h?=
 =?us-ascii?Q?5bPJp4JnBz7M0H/asUZas7+sKaU0CF3/OH40DhrZ347N99jf3S/qgRqzjzPg?=
 =?us-ascii?Q?nmQCnQQMKcfdr3QIhy61TTaR3Ur5TXUhtNyGQNBhjDs5R4skiu7WtfTwP15G?=
 =?us-ascii?Q?gUvv5ieYP/08c7fN2mHzTmsC5B56iJ9YHcXrTffyZhGb0rBxr5TbFrzgJkuB?=
 =?us-ascii?Q?H4QaLaadXhk/IiVbmiNrkD7mh+HApkl7phrXxBZ8cvUmCErKO4Bj6mjEGEJz?=
 =?us-ascii?Q?pJfMElLWmsL66L3mJAfqfDDo0xkgGfUIr/fiZFXmf1vXfYr4SbipN3w8kItp?=
 =?us-ascii?Q?63158UBZLIk2+OuLX/1dM9Rx2nrNpnMbuARjGnSP0ML810LFH5c8ySYRaaYp?=
 =?us-ascii?Q?PLUsv1MyUrnLWMcnDKuiBPC92IoObVcL5+B7RuaT7iGe4YO0OS1JISmAQZsI?=
 =?us-ascii?Q?7UVgy/30BMF+O+qp2QBcAFFgGEzJ01brA9qEIVWaGgJ+xIMyA1DGXUdmemvI?=
 =?us-ascii?Q?VxQxvJMuHEfA5FaLHld67sZrRy26Q4lllfp47fwpHh098fhwMHyougErWeuh?=
 =?us-ascii?Q?uJ82FSdK/NXlIdOLOzC3iKyHvwh3muBYd7qlm28prGNDD3jcVwHkZMUaoCMD?=
 =?us-ascii?Q?YAEkiFkNM2w7WAfQQJu1fQYRu8aJO7tsc4jjk7vG2KzNJahbBqAhjiO30zQE?=
 =?us-ascii?Q?nVwXYY551caaPQ7GmQYl1tbSpzfp9u7P50dzcvWSvZ95KLIJ3YfOID3KJlyr?=
 =?us-ascii?Q?67CBBYiaEgJndFZYufgJ0TQZezPPea/qtL5kc4JpXqPd6tg1mV3bZMlbS4k7?=
 =?us-ascii?Q?EY7e1JUXi60r7gIoWh2izhOgcF4mOcRt5euMY2bm61zxi0ZOWf5dUXl4/53S?=
 =?us-ascii?Q?C9C0Uds3nk7UASuuaFhkl1raaUHm9Flog2TYDpQ/lCandnEaONK/aFpggjwb?=
 =?us-ascii?Q?ot+TmMWhAo984H6z/PvDlCXrSWZGH1osSHX5LNXbV/pxcJXUormbUGUm3rXC?=
 =?us-ascii?Q?MH/bEEt1mQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242bb7a7-e328-448b-5389-08dee97e05d3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:21:01.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egV6SF9TLp3GGm2WpeQzatfqjqxowJvlNZel3ejdOlCsdJfKjDK/tWdrB2ISXL2fqjF1PGZfbPqeZKbVhp5Ebg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032

Vera is NVIDIA's next-generation server SoC. It reports hardware
errors via ACPI GHES using a CPER section format distinct from the
existing Grace section. Without this series, firmware-reported errors
on Vera platforms are received but not decoded.

Patch 1 refactors the Grace decoder to separate parsing from logging,
preparing it for testability and for sharing types with the new Vera
decoder.

Patches 2-4 add the Vera decoder, KUnit coverage for both decoders,
and an EINJ-based kselftest for end-to-end validation on real hardware.

Kai-Heng Feng (4):
  ACPI: APEI: GHES: Refactor Grace decoder helpers
  ACPI: APEI: GHES: Add NVIDIA Vera decoder
  ACPI: APEI: GHES: Add Grace and Vera KUnit coverage
  selftests: firmware: Add NVIDIA GHES EINJ selftest

 drivers/acpi/apei/Kconfig                     |  17 +-
 drivers/acpi/apei/Makefile                    |   1 +
 drivers/acpi/apei/ghes-nvidia-test-fixtures.h | 233 ++++++
 drivers/acpi/apei/ghes-nvidia-test.c          | 704 ++++++++++++++++++
 drivers/acpi/apei/ghes-nvidia.c               | 480 ++++++++++--
 drivers/acpi/apei/ghes-nvidia.h               |  63 ++
 tools/testing/selftests/firmware/Makefile     |   4 +-
 tools/testing/selftests/firmware/config       |   5 +
 tools/testing/selftests/firmware/einj_lib.sh  | 189 +++++
 .../selftests/firmware/ghes_nvidia_einj.sh    | 144 ++++
 .../firmware/ghes_nvidia_einj_profiles.sh     |  46 ++
 11 files changed, 1838 insertions(+), 48 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test-fixtures.h
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test.c
 create mode 100644 drivers/acpi/apei/ghes-nvidia.h
 create mode 100644 tools/testing/selftests/firmware/einj_lib.sh
 create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj.sh
 create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj_profiles.sh

-- 
2.50.1 (Apple Git-155)

