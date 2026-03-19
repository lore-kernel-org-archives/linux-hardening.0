Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4C3C65EF;
	Thu, 19 Mar 2026 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918820; cv=fail; b=aPuJC+uxIx8sAjOLxXY0La1niit6VkKPE0D6Q42CYuMkrM1AlTngsZJ0Y4fOZFOwan3BoPDQct7Cjc7/1fiCqfiyr1T93lCnFoltxmDQGw4tyG48hVRPBUkOixk1GdoMQL5A28thaB6WQa0ZnPRuI7BLamR1e+hm80XE+zzTYJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918820; c=relaxed/simple;
	bh=wfHRGwzrXa5JK9yAdf960UjeDZwfYvVenkGotwOmw1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyDq7MVEn9n9WILc17ZlAkOes+fYrEUgUqcFU3wUzLwSqQIiuSuMHg4XWBlp5jbUACzSqxuveDc6Lzsw1QuoRj+u89nspzZ4TKTUDnGePuoKn2RnzdCzFN8cIDDD1PuerAaMCfmQXezXOujCAmcEgOflsr/v0ugnTmU8Uho9B9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PbhOq39e; arc=fail smtp.client-ip=40.107.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PbhOq39e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDA7rDXMMygLP5dwSie7jjn8hkCF64GS6ABLWvwml/XSNZEmaNAhztINCX5eDyWnt4lW/6lTN8XM1RTo1yy9nWzKKCVIjXDgrxo7HXPeLmvaQRRB3micuhpfP0csHeyyyQdsGGf9mQGRfP4U7EUqYcdw7Uo3yYJBr3hWKMw3W0Gi9Nmv2N6WsebRBmOFOoLkqZs3WIwK55qok5e4YNZtXTfbDTteUJbXYqadgTVnerK0KviXUMrpfGXiMW9DwOq1BnsAxCVmbLLab/9SyEhC08c9yIUNmyywtCHKlH+ppqGDeJgLyXMu7MnGgtrmdgJRLFfZ8Tt6JFO0/tYwbGUcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iBU8AXLGzpVL2ddEQRAO07s3Tw5ZAHj5Od5ZddSmZU=;
 b=Wnd8FYZ9oGokJQr+EZ/9MAVvqjCRSmQXovXbknPKFQiRT1pm+mnKTyhg/D4qaS9ZxN8abErks5HA9uuEvtWxpT+9/kJ/IFupHeLgOhzWphFGh4XVNwP8Lhcf9csL35tN8TdYc0eeZZs1mEMY2UdWoDyb5fWqfy8u1Ra9dAgjZ1BTXoIXJgEyMeflSt5KrWsqHVQG4hNVJBLjOQZnwTrvrv9tH4ktfkVaLBie7OHOOK1swq9buCQZTSEgkOWBCboZUO2iVswzYyjBjCvrBVeL45rEq/Pz/IQ8LLIkAeQck/qbl4YZwEolEoV9Q9kZUpYmTdQDAGgX+zLvoAhMsU6Avg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iBU8AXLGzpVL2ddEQRAO07s3Tw5ZAHj5Od5ZddSmZU=;
 b=PbhOq39eNTGjbXpcBAJBC3THDwCsz1WvQetN80qs8CtHgGEG9ksc0NC2rVbVhjmcrTN/NofLDNUJNTndEK51uZqcg7z5W8KmTUsmhC1gQYo3ZUzl0zuQBwaCiB6uX3l8HMpue0TtIPJAHdnzs3yhABs3cw3tj/cY1CvvU/ZUTKHqQkMxQtthjt8t4wpcIPjCW/xfodIMn+MEOR+b2N6vLeVEaQZA5e3HM+AjvFysA/UKSyalDVRjX7mZC66l89e1KXsKLXFrejkwAwM79wqgt6BvqYwJ+IncMHGFjI3k8LEvIj7z0Bdey+W3bu0V94VO4P89N0evTYbIKY0i6fhkCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 11:13:32 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9723.013; Thu, 19 Mar 2026
 11:13:32 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org
Cc: Kai-Heng Feng <kaihengf@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Will Deacon <will@kernel.org>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record handler
Date: Thu, 19 Mar 2026 19:13:09 +0800
Message-ID: <20260319111315.87624-3-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319111315.87624-1-kaihengf@nvidia.com>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0057.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::16) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: f580012e-cf27-4002-c3a9-08de85a88e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0ax3awwbtr13q9kWQxERLhMcVP1AX9ZTQdx+xahuxSqT45YH/YZZFV625Um4uBks4lypQr0a+4Z420oOXoyNhRdRae4KubzZMvd+ySZD2gEU4sMtDLh4VqJpRqek+PAue481FNuh4HrqhWDVRx5S8GyFr8HpIpTC1D1S2I8ShQfA473bXrct5gcT8/kK0F/XZwsDNlOd7q6ssmzvK1McN27eNBvHXvOlBLKQL/j5gvKrMu/YXs/yIFtqWZ7ZBJZqCTK7u4rjd9FUxX/1zwfIBsSEyp+Pcud3s2N5ZrIN6SHCv9uys4MU9UnSXkECBIfCcswPA9/1i9/Iyb5qrIUHGp/DBbEqfpfnf+A/ewkt4zyRecK6vwD6FsePXN9Zq4zmNDwxqmB4qJIY4sFZpt3x7bL34b6xV7RRV6NW3hQ24boJ+2Q6i1CZ0Zin0OZcXa/fiHmagJqcpXXNBt7dvQ7SI5cRobP54wc9LFn4KyYLAn2NDkBwWOaXA1o/H51D/A8ZNnJVwEuMxg26qxcsBa/W7XXVCd9s7MWy7BdaVhoj7aV+v+8QP5p+EgZoHUTPMTo3rvZpzhvwtaEJkudQxQxJJ+TUGRlLqAimV1zQQLIaPm0zRZbN423k0Aic1TFcqsYcm8Rku8IHhj0a0JYWTK6ImV9ZAtQYZPC6cepSuJlWlzrPdWT7lUeCiyh4ETgJ93qB7BDmwJ8RIBIukojFnCfuiuxL9FTEfhNItEut9fhjrVKFCTcFgFSx+b+kLkiVXVuG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E+DGdZ8Tb3b1CWtVO5HNy1yuyx0pEg9qeDcV5fkKPPbBcyFDX492na0QTkLG?=
 =?us-ascii?Q?TPAdfKfovHEBQMdKsZ7hxewHsD+8DSkxZ65/ggea9puT7jT9cB7zRMWGhTgA?=
 =?us-ascii?Q?XbA3zf5QC2ERWFl+Yqiwz81H4Bjaw7+EY7pA8i4JDdQyrEFql8ZCFzCIW7cF?=
 =?us-ascii?Q?uNlvgcnLbZ8KBMC1lEFgtKfoQndSlpvpDHZW/gNn3KalJjtzpuCaEOv2B27A?=
 =?us-ascii?Q?Dr7ljuZ7Em+Xu2a4dj3hh4d4pnm4LNu4p0HoGFhNVzVsEfIhTL/nIdm6L2os?=
 =?us-ascii?Q?mB4V9j5DjmYJ0V1+5OG5qROe6hZsAunnEjoXfb6cKPoMMZsloZfrIC4hl06v?=
 =?us-ascii?Q?qiln8x5IlPgriGtnSlkzLnaS4YemtutoUSw1lo4P2XynEwmjj+nZX/aJoZYv?=
 =?us-ascii?Q?BEokSBC2BeHr/86noI/Isvm6Cm/KKgbK77PcNm1/Nrv5hU3ZukO+3GZUJgDk?=
 =?us-ascii?Q?dZCmNAy7EmF5mOhFxOlJ8KIKlzTT8sGU7qnSrdJQ8D+TSIC4bPv758U07t64?=
 =?us-ascii?Q?OBTBWwtW5NbxOGqseF+gx2/08k3PCB4nH2InzWIkGF1OLirhGOfVnKKd6QxZ?=
 =?us-ascii?Q?FnbAX75+X9VMGlQaia3NaCiR9HQhYeDi2QR1np9UFb5u67r3n2OmHtb8Kons?=
 =?us-ascii?Q?wtw5bHhNULCnjemqG7TtInTpYTBWjGOSvicFz9IrdL+XFzSaOiIlAXBVzdPr?=
 =?us-ascii?Q?tvLt8o1Pu2J+oWxDDE+myZcRnsmNKxC0d1zNZQrZAIcm7+jDYfJFeWPVUiAA?=
 =?us-ascii?Q?6TTztcBgWCeg1YEeT0vROmKts2YTPnglwKQwBZ4qBlFmt2rg8ZJFqyfh8+fn?=
 =?us-ascii?Q?rIF3SlZ5GGSYTObiHMK9TAfzw/8MgvHwjpqr+Tff+D8AbjtPetdxy8H06eLG?=
 =?us-ascii?Q?EHf9WLuybJv3CvG/0oQ0l6i1KaHNxcgBlkDunemgudEzWGgrIEfd+uMRI62G?=
 =?us-ascii?Q?rGb212rVp7O6DA7aeFn8eJZFia1EN5qO7dFb5CFNMEHPglDmjwKKx6TboA5k?=
 =?us-ascii?Q?y9Rz331vr+gBz42eXuSrxAiwhZGDbl3BLVsXrp7bp7rmkKKNCz6KpRjI0dIv?=
 =?us-ascii?Q?020RyFmKWHRizV3g7iwTGwZolRwb2tQBJeJUHHkE+b0BktSV6LUop27IKfQO?=
 =?us-ascii?Q?0DlDlzXFdEL91/oRiRUs6d8Li/XuOI7F5T8DESS+qdlYaeSxqRVHc3OCl+8w?=
 =?us-ascii?Q?wWhHtG2wcmkRkXakGcpp4lT2dtKpXaNLkz5N6Sk9DEiG85vWVrWKBqk3KK1U?=
 =?us-ascii?Q?Gswpug+judWk2feVusZd940J4kgMrDC4Obq0tzRZaQPxdblyKicBb3hTlXnT?=
 =?us-ascii?Q?YuO9K/CETwWsBYTgXuE8tAJ6RlS4Kb4myPLacW7QD3Nc2FmBzRpHGir4Mp32?=
 =?us-ascii?Q?9kUy8iMcSDibRs/x5jJn3VngQ7jOTs1ZsjfKSTFHdDPOUCmXIeq+THadm5rP?=
 =?us-ascii?Q?x0aImsBmxEahv+dQKj3J5XxJJXY0v2GOhi0TnNr67uFRnFYrR7CANOtp9qFW?=
 =?us-ascii?Q?yYQf9km4dKAyQ0XhEo8zSC+zt+2uTKJEzyRcqgHIZJBEgtvnfYsHjqfiRApW?=
 =?us-ascii?Q?DW4vGikpcRS6OtgQyjMrG91RoCyVllBWRpS0lPuGGPBzYiAzvGHfPJxKRzy6?=
 =?us-ascii?Q?Rja06EaQOrwUe4fVQrkxItx3g+O4OVIKKl2sHUUcgnjqNPRIKK2ZdysGdXeE?=
 =?us-ascii?Q?srA4W5uaATAJN0+A69uaCCnYtsCuAyY4LwkE4FMyEvq1QlLwQAzuaw7Cq/0n?=
 =?us-ascii?Q?7Fk190uQiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f580012e-cf27-4002-c3a9-08de85a88e53
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 11:13:32.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/QoS0e+VTZSRrkZPj0QOEPAq58q9VP51Tsqi6G0C4QMvEkerbYZR4EZLRDVK1VadsICAGO9rA6PD34JGzVPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817

Add support for decoding NVIDIA-specific CPER sections delivered via
the APEI GHES vendor record notifier chain. NVIDIA hardware generates
vendor-specific CPER sections containing error signatures and diagnostic
register dumps. This implementation registers a notifier_block with the
GHES vendor record notifier and decodes these sections, printing error
details via dev_info().

The driver binds to ACPI device NVDA2012, present on NVIDIA server
platforms. The NVIDIA CPER section contains a fixed header with error
metadata (signature, error type, severity, socket) followed by
variable-length register address-value pairs for hardware diagnostics.

This work is based on libcper [0].

Example output:
nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
nvidia-ghes NVDA2012:00: signature: CMET-INFO
nvidia-ghes NVDA2012:00: error_type: 0
nvidia-ghes NVDA2012:00: error_instance: 0
nvidia-ghes NVDA2012:00: severity: 3
nvidia-ghes NVDA2012:00: socket: 0
nvidia-ghes NVDA2012:00: number_regs: 32
nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000

[0] https://github.com/openbmc/libcper/commit/683e055061ce
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v2:
  - Use right headers.
  - Use embedded struct and __counted_by.
  - Drop __packed.
  - Remove unecessary casts. 
  - Use * in sizeof().
  - Use devm_kmalloc() and struct assignment.
  - Use dev_err_probe and new devm helper.

 MAINTAINERS                     |   6 ++
 drivers/acpi/apei/Kconfig       |  14 +++
 drivers/acpi/apei/Makefile      |   1 +
 drivers/acpi/apei/nvidia-ghes.c | 146 ++++++++++++++++++++++++++++++++
 4 files changed, 167 insertions(+)
 create mode 100644 drivers/acpi/apei/nvidia-ghes.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d7241695df96..a9be03fbf1a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18908,6 +18908,12 @@ S:	Maintained
 F:	drivers/video/fbdev/nvidia/
 F:	drivers/video/fbdev/riva/
 
+NVIDIA GHES VENDOR CPER RECORD HANDLER
+M:	Kai-Heng Feng <kaihengf@nvidia.com>
+L:	linux-acpi@vger.kernel.org
+S:	Maintained
+F:	drivers/acpi/apei/nvidia-ghes.c
+
 NVIDIA VRS RTC DRIVER
 M:	Shubhi Garg <shgarg@nvidia.com>
 L:	linux-tegra@vger.kernel.org
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..7dc49f14f223 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -74,6 +74,20 @@ config ACPI_APEI_EINJ_CXL
 
 	  If unsure say 'n'
 
+config ACPI_APEI_NVIDIA_GHES
+	tristate "NVIDIA GHES vendor record handler"
+	depends on ACPI_APEI_GHES
+	help
+	  Support for decoding NVIDIA-specific CPER sections delivered via
+	  the APEI GHES vendor record notifier chain. Registers a handler
+	  for the NVIDIA section GUID and logs error signatures, severity,
+	  socket, and diagnostic register address-value pairs.
+
+	  Enable on NVIDIA server platforms (e.g. DGX, HGX) that expose
+	  ACPI device NVDA2012 in their firmware tables.
+
+	  If unsure, say N.
+
 config ACPI_APEI_ERST_DEBUG
 	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
 	depends on ACPI_APEI
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 1a0b85923cd4..4a883f67d698 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 einj-y				:= einj-core.o
 einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
 obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
+obj-$(CONFIG_ACPI_APEI_NVIDIA_GHES) += nvidia-ghes.o
 
 apei-y := apei-base.o hest.o erst.o bert.o
diff --git a/drivers/acpi/apei/nvidia-ghes.c b/drivers/acpi/apei/nvidia-ghes.c
new file mode 100644
index 000000000000..aa2e3a387b49
--- /dev/null
+++ b/drivers/acpi/apei/nvidia-ghes.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NVIDIA GHES vendor record handler
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include <acpi/ghes.h>
+
+static const guid_t nvidia_sec_guid =
+	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
+		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
+
+struct cper_sec_nvidia {
+	char	signature[16];
+	__le16	error_type;
+	__le16	error_instance;
+	u8	severity;
+	u8	socket;
+	u8	number_regs;
+	u8	reserved;
+	__le64	instance_base;
+	struct {
+		__le64	addr;
+		__le64	val;
+	} regs[] __counted_by(number_regs);
+};
+
+struct nvidia_ghes_private {
+	struct notifier_block	nb;
+	struct device		*dev;
+};
+
+static void nvidia_ghes_print_error(struct device *dev,
+				    const struct cper_sec_nvidia *nvidia_err,
+				    size_t error_data_length, bool fatal)
+{
+	const char *level = fatal ? KERN_ERR : KERN_INFO;
+	size_t min_size;
+	int i;
+
+	dev_printk(level, dev, "signature: %.16s\n", nvidia_err->signature);
+	dev_printk(level, dev, "error_type: %u\n", le16_to_cpu(nvidia_err->error_type));
+	dev_printk(level, dev, "error_instance: %u\n", le16_to_cpu(nvidia_err->error_instance));
+	dev_printk(level, dev, "severity: %u\n", nvidia_err->severity);
+	dev_printk(level, dev, "socket: %u\n", nvidia_err->socket);
+	dev_printk(level, dev, "number_regs: %u\n", nvidia_err->number_regs);
+	dev_printk(level, dev, "instance_base: 0x%016llx\n",
+		   le64_to_cpu(nvidia_err->instance_base));
+
+	if (nvidia_err->number_regs == 0)
+		return;
+
+	/*
+	 * Validate that all registers fit within error_data_length.
+	 * Each register pair is two little-endian u64s.
+	 */
+	min_size = struct_size(nvidia_err, regs, nvidia_err->number_regs);
+	if (error_data_length < min_size) {
+		dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
+			nvidia_err->number_regs, error_data_length, min_size);
+		return;
+	}
+
+	for (i = 0; i < nvidia_err->number_regs; i++)
+		dev_printk(level, dev, "register[%d]: address=0x%016llx value=0x%016llx\n",
+			   i, le64_to_cpu(nvidia_err->regs[i].addr),
+			   le64_to_cpu(nvidia_err->regs[i].val));
+}
+
+static int nvidia_ghes_notify(struct notifier_block *nb,
+			      unsigned long event, void *data)
+{
+	struct acpi_hest_generic_data *gdata = data;
+	struct nvidia_ghes_private *priv;
+	const struct cper_sec_nvidia *nvidia_err;
+	guid_t sec_guid;
+
+	import_guid(&sec_guid, gdata->section_type);
+	if (!guid_equal(&sec_guid, &nvidia_sec_guid))
+		return NOTIFY_DONE;
+
+	priv = container_of(nb, struct nvidia_ghes_private, nb);
+
+	if (acpi_hest_get_error_length(gdata) < sizeof(*nvidia_err)) {
+		dev_err(priv->dev, "Section too small (%d < %zu)\n",
+			acpi_hest_get_error_length(gdata), sizeof(*nvidia_err));
+		return NOTIFY_OK;
+	}
+
+	nvidia_err = acpi_hest_get_payload(gdata);
+
+	if (event >= GHES_SEV_RECOVERABLE)
+		dev_err(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
+			acpi_hest_get_error_length(gdata));
+	else
+		dev_info(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
+			 acpi_hest_get_error_length(gdata));
+
+	nvidia_ghes_print_error(priv->dev, nvidia_err, acpi_hest_get_error_length(gdata),
+				event >= GHES_SEV_RECOVERABLE);
+
+	return NOTIFY_OK;
+}
+
+static int nvidia_ghes_probe(struct platform_device *pdev)
+{
+	struct nvidia_ghes_private *priv;
+
+	priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	*priv = (struct nvidia_ghes_private) {
+		.nb.notifier_call = nvidia_ghes_notify,
+		.dev = &pdev->dev,
+	};
+
+	return dev_err_probe(&pdev->dev,
+			     devm_ghes_register_vendor_record_notifier(&pdev->dev, &priv->nb),
+			     "Failed to register NVIDIA GHES vendor record notifier\n");
+}
+
+static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
+	{ "NVDA2012" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);
+
+static struct platform_driver nvidia_ghes_driver = {
+	.driver = {
+		.name		= "nvidia-ghes",
+		.acpi_match_table = nvidia_ghes_acpi_match,
+	},
+	.probe	= nvidia_ghes_probe,
+};
+module_platform_driver(nvidia_ghes_driver);
+
+MODULE_AUTHOR("Kai-Heng Feng <kaihengf@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA GHES vendor CPER record handler");
+MODULE_LICENSE("GPL");
-- 
2.50.1 (Apple Git-155)

