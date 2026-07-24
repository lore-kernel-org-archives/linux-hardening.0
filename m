Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA693424D73;
	Fri, 24 Jul 2026 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895687; cv=fail; b=JHDufuRiD6CTe5pm4ksFPXcK7p/7DVNd+1AM/uOGAZ6La2KWm3+tUPdqmZzTiT5RMlA9RvgvI0LOW+AuHYMRSlTvzaBzrxlCA/1PPqB3Ug4mzKymLiuysz2pAcl7zhhn9JbEGNADK249rzaPCFUhV2cxXlaEPcBwPL0XZrqVN4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895687; c=relaxed/simple;
	bh=BbiabetB/ychqbg14YoDie95/MIaRUORLSDaPypa7uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFlDeexS4DurcdTiQQ3XamjyirtLrSwa3uhL9Pklqe2noJSz2nb3N6Jtv4AVWsbvlV4oQA1cAwxtTZo0+eYPE3R35jAw3L7wAXRqL60eKHvN6WwDUQ6fK+ytGixGj0CEOVphTwhpdQ9ICENNXymVQXDBdXelj1fxr2H0tVKzqik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aq4tjA4l; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aq4tjA4l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdFZK32m/Q0aVYGVMQYzXNeYb/LVOcNV+L6pJEb/2g/UMeUYv+G4nLhw+xcZO9Y0ajccksQ2yBgkRDAXamlboe5T7LXFr1mhnpbdW92EIEf3PxQDdInl77B3Sn3Hx4jxAxrMU4DUuKwVbK8dUgNdKF7j2ZUNeORFPmzHltJfrifVsjON4TfQliKFpDk5Td0pzq+So9HVC9wANOZrrYVF67J2dGjLbQpMdTKIqe06HCL6d5bHYLYxif7pUYmmo7XEx3fNhlovhlUVAHyAZCtLLpKJiK2Zk65TYbfXbVKjbERcA1MPzwlHQyZDbsgWLWti99T/5pBsnI9OUJbYJCqaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlmgzACLb1WQPGjnfDt8yY7eilPJOYKy+NC+QsvwCVc=;
 b=OqqM3qyH0m+qZyI+3F6jWOduE4kflhFlrP4RRvyHaUB2JqkoRfjXOMjU/WgrQysL8hiH0lBlBWicS4y27KNKqDW6vDR5Afnjyt9156rJPRECJg4ChZytPZt04Zx83vn6qTRHJtFBlRVOmD6jKMMIaJ2kkFh6K0SoqXSH/B6mLtWTTYRGWUVTJ6cr1VNn2SdyX29cSc8eRFbSxSHQE5Xk81HM5636WsByh0zmZgSkRWrq67WmCkU31BeZXeuMSLWGV6zeiYVrAsIO6tK4iK8ntFIahSl7lLHwFTwLH4pChKMC2vcDkMBBtDbiqTuWiRBcETOejCwZ1SZ7lJTQ/nF3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlmgzACLb1WQPGjnfDt8yY7eilPJOYKy+NC+QsvwCVc=;
 b=Aq4tjA4lsCiPdiDbwwKSh/0NRN8VnGH6o7Uuhw+l9wr/P9GtStHgmWjpXTEVDLHdZB/wOHIM8seWRHRwKrxFlp9/1vm7v+Opwh60pD83R6ezDYT9BXfzjcHM3uF90puhU0Z/bL5XPkDjvgujLZ9D5Y4dZaIn+pYaxbYgWu9jMTeMIZZe3znN1doelgw8dBDgWjkgX9JY0FZ0tMhqKwkEb1560RJtISmQp8jU2l+UWuZ6JzGj5oN7z8ZVGB6La5dSVlB2AbdD1bVjesxkVdtmvzapuDn65ayOl2sgZyoRh75vGNRW3OGZXhm3T/rauGvjdTImQ7/xQZOw15WJmFr8cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 12:21:17 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 12:21:16 +0000
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
Subject: [PATCH v2 RESEND 2/4] ACPI: APEI: GHES: Add NVIDIA Vera decoder
Date: Fri, 24 Jul 2026 20:20:52 +0800
Message-ID: <20260724122054.36162-3-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260724122054.36162-1-kaihengf@nvidia.com>
References: <20260724122054.36162-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:297::13) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8603c0-6a12-49db-6aac-08dee97e0e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4tzZFCv2xWFLzse6qFFTXRSbSHzlkIhoKm0XRdpCD654lOFwhG083Ciu4Ya3ULzCxVxM7vM2k5pmHGODOUQby3tkOgk+RE+JJxadYa5iEwE6OVvls7omxRkNFCmGgkRroQR9rMTAMlmM69Q0pbx0/tRGAm3BNxjXVvQ2nUu3O8BmPsvbiGfELc5ItxGc61lfP9PU4NJ6yoor1AOVcAMimjMMnLDcSBSektVvg8Mrw62n6HaXtZrcdQGTriEtJ7iKFRd3/6o0BBTGr5cESwX+1nduvcpQkQ0d7EPg3h3z8QjfFvYa1cgNRm2Mb3wY0kH5g/7ZHpymlWvHT6B4OW0BPJ+dgAMwFFxXAko/fGLKx24BNO68fgv8e+1ssBOWExF+Erch20wJiSDMurn98P2rmHbW29RAk/WI4nJH5o7p1eaEg/NbGd+j+dIp4DM8reuV92kYbfMzvOtBwVjQj9EEW906oX8arTQfCBCFILvY1kR5MZ/iH1fKYHuqMC0cTUzGhXT69nqyuVZc9t8OtiCVpF2LW3mL+hy9cDkPGJ0CjYj4FQSFKlKR+QUVK7JDHEWaT5sKiLqpAGUVP5cXo41j5SVX8PHQ9cR3LuK0fWQTlGg+e+32ppX0HK2qX2cFUNIr45fOnOZJPvQb0km96Z5b7I4NJPgpwnfD63Jlu6kacL4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eGakGwpcqbSZNWAcAZ27il7Uc6dm4ComniMY47feGeJlYcjrxhaBL9/W/u4n?=
 =?us-ascii?Q?FG8wkDzEEqTtgSPt1aZnjUp6yE3Vu1UgD1CRmb5vsGeJbIPnlbmOs98jwc4k?=
 =?us-ascii?Q?misW7vFyZUtIegi2HgXKsoERSuC7YzRs3hAmjp7IRglXCkZ6nO7Cy7DyYxCd?=
 =?us-ascii?Q?wn0vrX/9+/0FKgxwSCVGMJ4Hn9QqJ6y27DQcte78ubP0QaoEclqtSo8vIa5D?=
 =?us-ascii?Q?ooDbVua8XojFPnz6AapSEvzHmWCAO6M92dAxLxXsq6aC69a+XxbDETSiULFt?=
 =?us-ascii?Q?uNYVfyKAtJFp636b1aRl3o3u6X+reEcxW50tN7+TJU3sy2ca8qnuYt8w7vib?=
 =?us-ascii?Q?vOEI6j4fliGfUBrcmlUeZOSaAxLy02tWSB4A79Hzb4MxdkovGWmAU4aFOS8t?=
 =?us-ascii?Q?PwVSuQKhWGVjuF7WvO6KXRQD3cvRaCgMNZqH6o+bD/NcbeEQLPkKNV3xsFcm?=
 =?us-ascii?Q?EYvpdhKe1qWt0AA+F/DXce5ZCpwsor42GCYziHniPEJ5d3h3BVrnJ4fnDBY+?=
 =?us-ascii?Q?CpIQa0O87AzMTgbR7OnPpJUfc4zd9JoNhfUW3kgWqZ8oub+Srwqfnq2ZP/3b?=
 =?us-ascii?Q?jEQOrxpW4EBx1j1/nZwiOMTBmjcUGgO8z7IIkwE78aVAcwRcR7Wu3iCNo5YI?=
 =?us-ascii?Q?H3bGButqmz2E2hvMlKB0wa4tCBNcex3KgMtqqz6eHhFOBgAmxvaRnEGvGW9R?=
 =?us-ascii?Q?pKivy0hSp06cbeh1jt2AZn8IyZJJA2W8l1UalFnDBiFj4MutbPEMo3szs/hN?=
 =?us-ascii?Q?FIWsc8/nfWTYXCvAUVimrOwiIQUdTAqrtp2U3MobNC0vx02HKswKucxXu6cU?=
 =?us-ascii?Q?fJz1WSFUp2f0gGyf1/++C88R74cway24OG51rbKrOmYV/c/M1ySF8o+Oj62F?=
 =?us-ascii?Q?dNkYrFUsVJSAL0vYWfe/G5sV3f1xzR8DSq0QWZcxlnw12ttHSfchmn2xCaod?=
 =?us-ascii?Q?oI/lVuu+c9GzFqmZ4rhg89Nyu9FJ0OJ7WXWPpySwK69ubXdWTaNgNGkfgD0M?=
 =?us-ascii?Q?6KWZMRQuEtKYjFNPCvbu4WxoQEZQ2UfQcP1ztdnzpLtamZvoVDqlsxcLyzah?=
 =?us-ascii?Q?EAlsgtwHPW5PY52nQuCnn6uvX1hljHgQEwz10y98zpb4RqWsSa/Tm9uYGgp3?=
 =?us-ascii?Q?1KdMeOEvupiQj/gefz2XpTqnqUqXlk9cC6JgZoFvNzEE4rcEEdVajHyJICJ3?=
 =?us-ascii?Q?hsgt9gmYu48hVviN2CrLCgSyyXIYbbydvYRoSed/qtGuYQ3/b+x5Eum1BhV9?=
 =?us-ascii?Q?LoBsrBXb6/xCinnO+UwcM2IKeQYNfrDhnPpse0nHdaFArq1FPeCGnoZGzrvh?=
 =?us-ascii?Q?Du+0EOAyRSEmxefEtwX/UuE7gRuq6No1SF5CsSHHp7kLMYAH6wGMJ5aRzj9/?=
 =?us-ascii?Q?Y1ztEvT2zNB44pPsirDY+zRKR0y0iGOPJJHKzXM3aqaX0FpwfejL7KvUCgIt?=
 =?us-ascii?Q?TdPsDMibqMVucJrEX/8+OmAtq4GhqCB/DwyG4XiPPd8KjBV/a0LmrQxlfw6A?=
 =?us-ascii?Q?7UGObDBitKLZzf+7VDiewNlr4Lv+OFEBrpQ9+7QqzCIEc1TX9adwnzYgEral?=
 =?us-ascii?Q?HI1arVx/o6uSCxCvD2LkmtMPte270yO/m/3lTtiR3vuUEP/Zyq3ExRiVZL2F?=
 =?us-ascii?Q?g2+zasu2gNNBNgA/U+92bNgYi4K+wgJpM4rnaHHaCiOQsqMLSTDgKPuF6LWd?=
 =?us-ascii?Q?eJtLtwyUXKNaL6fqbYRtvTwS2f3CIBvC45pks6GqymK+JRdIb90b8Fr1ZF7W?=
 =?us-ascii?Q?6GOYeiW60Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8603c0-6a12-49db-6aac-08dee97e0e7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:21:16.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73PnO19LE7TY1oVxb7g0+NNswGCN7MbtUSDLlR9MGQdRteh/IxHvrf5grzrQxws579pnctW9ErQNPPdTy/oYkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032

Vera is NVIDIA's next-generation server SoC. Its CPER section uses a
different GUID and a different binary layout from Grace, so it needs
its own decoder. Without this, firmware-reported hardware errors on
Vera platforms are received but not decoded.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 drivers/acpi/apei/ghes-nvidia.c | 368 ++++++++++++++++++++++++++++++--
 drivers/acpi/apei/ghes-nvidia.h |  29 ++-
 2 files changed, 382 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
index af445152def0..c74c155dd2ba 100644
--- a/drivers/acpi/apei/ghes-nvidia.c
+++ b/drivers/acpi/apei/ghes-nvidia.c
@@ -7,18 +7,27 @@
 
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/uuid.h>
+#include <kunit/visibility.h>
 #include <acpi/ghes.h>
 
-#include <kunit/visibility.h>
 #include "ghes-nvidia.h"
 
+#define NVIDIA_GHES_VERA_VERSION	1
+
 static const guid_t nvidia_grace_sec_guid =
 	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
 		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
 
+static const guid_t nvidia_vera_sec_guid =
+	GUID_INIT(0x9068e568, 0x6ca0, 0x11f0,
+		  0xae, 0xaf, 0x15, 0x93, 0x43, 0x59, 0x1e, 0xac);
+
 struct cper_sec_nvidia {
 	char	signature[16];
 	__le16	error_type;
@@ -31,11 +40,51 @@ struct cper_sec_nvidia {
 	struct nvidia_ghes_grace_reg regs[] __counted_by(number_regs);
 };
 
+struct cper_sec_nvidia_vera_event {
+	u8	version;
+	u8	event_context_count;
+	u8	source_device_type;
+	u8	reserved;
+	__le16	event_type;
+	__le16	event_sub_type;
+	__le64	event_link_id;
+	char	source_module_signature[16];
+} __packed;
+
+struct cper_sec_nvidia_vera_cpu_info {
+	__le16	info_version;
+	u8	info_size;
+	u8	socket_number;
+	__le32	architecture;
+	u8	chip_serial_number[16];
+	__le64	instance_base;
+} __packed;
+
+struct cper_sec_nvidia_vera_context {
+	__le32	context_size;
+	__le16	context_version;
+	__le16	reserved;
+	__le16	data_format_type;
+	__le16	data_format_version;
+	__le32	data_size;
+} __packed;
+
 struct nvidia_ghes_private {
 	struct notifier_block	nb;
 	struct device		*dev;
 };
 
+VISIBLE_IF_KUNIT
+enum nvidia_ghes_format nvidia_ghes_format_from_guid(const guid_t *guid)
+{
+	if (guid_equal(guid, &nvidia_grace_sec_guid))
+		return NVIDIA_GHES_FORMAT_GRACE;
+	if (guid_equal(guid, &nvidia_vera_sec_guid))
+		return NVIDIA_GHES_FORMAT_VERA;
+	return NVIDIA_GHES_FORMAT_UNKNOWN;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_format_from_guid);
+
 VISIBLE_IF_KUNIT
 int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
 			     size_t len,
@@ -81,7 +130,7 @@ EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_grace);
 
 VISIBLE_IF_KUNIT
 int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
-				      unsigned int index, u64 *addr, u64 *val)
+			       unsigned int index, u64 *addr, u64 *val)
 {
 	const struct nvidia_ghes_grace_reg *regs;
 
@@ -98,6 +147,220 @@ int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
 }
 EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_grace_reg_pair);
 
+static int nvidia_ghes_vera_validate_context_data(u16 data_format_type,
+						  u32 data_size)
+{
+	switch (data_format_type) {
+	case 0:
+		return 0;
+	case 1:
+		return data_size % 16 ? -EINVAL : 0;
+	case 2:
+	case 3:
+		return data_size % 8 ? -EINVAL : 0;
+	case 4:
+		return data_size % 4 ? -EINVAL : 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_decode_vera(struct device *dev, const void *buf,
+			    size_t len,
+			    struct nvidia_ghes_decoded *decoded)
+{
+	const struct cper_sec_nvidia_vera_event *event = buf;
+	const struct cper_sec_nvidia_vera_cpu_info *cpu_info;
+	const struct cper_sec_nvidia_vera_context *context;
+	const u8 *bytes = buf;
+	size_t data_end_advance;
+	size_t advance;
+	size_t offset;
+	int ret;
+
+	if (!buf || !decoded)
+		return -EINVAL;
+	if (len < sizeof(*event)) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera event header truncated (%zu < %zu)\n",
+					    len, sizeof(*event));
+		return -ENODATA;
+	}
+	if (event->version != NVIDIA_GHES_VERA_VERSION)
+		return -EOPNOTSUPP;
+	if (event->source_device_type != 0)
+		return -EOPNOTSUPP;
+
+	offset = sizeof(*event);
+	if (len - offset < sizeof(*cpu_info)) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera CPU info truncated (%zu < %zu)\n",
+					    len - offset, sizeof(*cpu_info));
+		return -ENODATA;
+	}
+
+	cpu_info = (const void *)(bytes + offset);
+	if (cpu_info->info_size < sizeof(*cpu_info)) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera CPU info size %u smaller than header %zu\n",
+					    cpu_info->info_size, sizeof(*cpu_info));
+		return -EINVAL;
+	}
+	if (len - offset < cpu_info->info_size) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera CPU info extends past section (%u > %zu)\n",
+					    cpu_info->info_size, len - offset);
+		return -ENODATA;
+	}
+
+	offset += cpu_info->info_size;
+	if (event->event_context_count > NVIDIA_GHES_MAX_CONTEXTS) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera context count %u exceeds maximum %u\n",
+					    event->event_context_count,
+					    NVIDIA_GHES_MAX_CONTEXTS);
+		return -E2BIG;
+	}
+
+	memset(decoded, 0, sizeof(*decoded));
+	decoded->format = NVIDIA_GHES_FORMAT_VERA;
+	memcpy(decoded->signature, event->source_module_signature,
+	       sizeof(event->source_module_signature));
+	decoded->signature[sizeof(event->source_module_signature)] = '\0';
+	decoded->event_context_count = event->event_context_count;
+	decoded->source_device_type = event->source_device_type;
+	decoded->event_type = get_unaligned_le16(&event->event_type);
+	decoded->event_sub_type = get_unaligned_le16(&event->event_sub_type);
+	decoded->event_link_id = get_unaligned_le64(&event->event_link_id);
+	decoded->socket = cpu_info->socket_number;
+	decoded->architecture = get_unaligned_le32(&cpu_info->architecture);
+	memcpy(decoded->chip_serial_number, cpu_info->chip_serial_number,
+	       sizeof(cpu_info->chip_serial_number));
+	decoded->instance_base = get_unaligned_le64(&cpu_info->instance_base);
+
+	for (int i = 0; i < event->event_context_count; i++) {
+		struct nvidia_ghes_vera_context *decoded_context = &decoded->contexts[i];
+		u32 context_size;
+		u32 data_size;
+		u16 data_format_type;
+
+		if (len - offset < sizeof(*context)) {
+			if (dev)
+				dev_err_ratelimited(dev, "Vera context[%d] header truncated (%zu < %zu)\n",
+						    i, len - offset, sizeof(*context));
+			return -ENODATA;
+		}
+
+		context = (const void *)(bytes + offset);
+		context_size = get_unaligned_le32(&context->context_size);
+		data_format_type = get_unaligned_le16(&context->data_format_type);
+		data_size = get_unaligned_le32(&context->data_size);
+
+		if (context_size < sizeof(*context)) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] size %u smaller than header %zu\n",
+						    i, context_size, sizeof(*context));
+			return -EINVAL;
+		}
+		if (data_format_type > 4) {
+			if (dev)
+				dev_dbg(dev,
+					"Vera context[%d] unsupported data format %u\n",
+					i, data_format_type);
+			return -EOPNOTSUPP;
+		}
+		if (check_add_overflow((size_t)data_size, sizeof(*context),
+				       &data_end_advance)) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] data_size %u overflows section accounting\n",
+						    i, data_size);
+			return -EOVERFLOW;
+		}
+
+		if (data_end_advance > len - offset) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] data extends past section (%zu > %zu)\n",
+						    i, data_end_advance, len - offset);
+			return -ENODATA;
+		}
+
+		/*
+		 * Some Vera payloads use only the header size here and
+		 * place the format-specific payload immediately after it.
+		 */
+		if (context_size == sizeof(*context))
+			advance = data_end_advance;
+		else if (data_size <= context_size - sizeof(*context))
+			advance = context_size;
+		else {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] data_size %u exceeds context_size %u\n",
+						    i, data_size, context_size);
+			return -EINVAL;
+		}
+
+		if (advance > len - offset) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] advance %zu extends past section (%zu)\n",
+						    i, advance, len - offset);
+			return -ENODATA;
+		}
+
+		ret = nvidia_ghes_vera_validate_context_data(data_format_type, data_size);
+		if (ret) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] format %u rejected data_size %u (ret=%d)\n",
+						    i, data_format_type, data_size, ret);
+			return ret;
+		}
+
+		decoded_context->context_size = context_size;
+		decoded_context->context_version =
+			get_unaligned_le16(&context->context_version);
+		decoded_context->data_format_type = data_format_type;
+		decoded_context->data_format_version =
+			get_unaligned_le16(&context->data_format_version);
+		decoded_context->data_size = data_size;
+		decoded_context->data = bytes + offset + sizeof(*context);
+		offset += advance;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_vera);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_entry_count(const struct nvidia_ghes_vera_context *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+	if (ctx->data_size > INT_MAX)
+		return -EOVERFLOW;
+
+	switch (ctx->data_format_type) {
+	case 0:
+		return 0;
+	case 1:
+		return ctx->data_size / 16;
+	case 2:
+		return ctx->data_size / 8;
+	case 3:
+		return ctx->data_size / 8;
+	case 4:
+		return ctx->data_size / 4;
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_context_entry_count);
+
 static void nvidia_ghes_print_grace(struct device *dev,
 				    const struct nvidia_ghes_decoded *decoded,
 				    bool fatal)
@@ -111,7 +374,8 @@ static void nvidia_ghes_print_grace(struct device *dev,
 	dev_printk(level, dev, "severity: %u\n", decoded->severity);
 	dev_printk(level, dev, "socket: %u\n", decoded->socket);
 	dev_printk(level, dev, "number_regs: %u\n", decoded->number_regs);
-	dev_printk(level, dev, "instance_base: 0x%016llx\n", decoded->instance_base);
+	dev_printk(level, dev, "instance_base: 0x%016llx\n",
+		   decoded->instance_base);
 
 	for (int i = 0; i < decoded->number_regs; i++) {
 		if (nvidia_ghes_grace_reg_pair(decoded, i, &addr, &val))
@@ -121,12 +385,52 @@ static void nvidia_ghes_print_grace(struct device *dev,
 	}
 }
 
+static void nvidia_ghes_print_vera(struct device *dev,
+				   const struct nvidia_ghes_decoded *decoded,
+				   bool fatal, unsigned long ghes_severity)
+{
+	const char *level = fatal ? KERN_ERR : KERN_INFO;
+
+	dev_printk(level, dev, "signature: %s\n", decoded->signature);
+	dev_printk(level, dev, "event_type: %u\n", decoded->event_type);
+	dev_printk(level, dev, "event_sub_type: %u\n", decoded->event_sub_type);
+	dev_printk(level, dev, "ghes_severity: %lu\n", ghes_severity);
+	dev_printk(level, dev, "event_link_id: 0x%016llx\n",
+		   decoded->event_link_id);
+	dev_printk(level, dev, "socket: %u\n", decoded->socket);
+	dev_printk(level, dev, "architecture: 0x%x\n", decoded->architecture);
+	dev_printk(level, dev, "chip_serial_number: %*phN\n",
+		   (int)sizeof(decoded->chip_serial_number),
+		   decoded->chip_serial_number);
+	dev_printk(level, dev, "instance_base: 0x%016llx\n", decoded->instance_base);
+	dev_printk(level, dev, "event_context_count: %u\n", decoded->event_context_count);
+
+	for (int i = 0; i < decoded->event_context_count; i++) {
+		const struct nvidia_ghes_vera_context *ctx = &decoded->contexts[i];
+		int entries = nvidia_ghes_vera_context_entry_count(ctx);
+
+		dev_printk(level, dev,
+			   "context[%d]: version=%u format=%u format_version=%u context_size=%u data_size=%u\n",
+			   i, ctx->context_version, ctx->data_format_type,
+			   ctx->data_format_version, ctx->context_size, ctx->data_size);
+		if (ctx->data_format_type == 0 && ctx->data_size > 0) {
+			int prefix_len = ctx->data_size > 16 ? 16 : ctx->data_size;
+
+			dev_printk(level, dev, "context[%d]_opaque_prefix: %*phN\n",
+				   i, prefix_len, ctx->data);
+		} else if (entries >= 0) {
+			dev_printk(level, dev, "context[%d]_entries: %d\n", i, entries);
+		}
+	}
+}
+
 static int nvidia_ghes_notify(struct notifier_block *nb,
 			      unsigned long event, void *data)
 {
 	struct acpi_hest_generic_data *gdata = data;
-	struct nvidia_ghes_decoded decoded;
+	struct nvidia_ghes_decoded *decoded;
 	struct nvidia_ghes_private *priv;
+	enum nvidia_ghes_format format;
 	const void *payload;
 	guid_t sec_guid;
 	u32 len;
@@ -134,26 +438,64 @@ static int nvidia_ghes_notify(struct notifier_block *nb,
 	bool fatal;
 
 	import_guid(&sec_guid, gdata->section_type);
-	if (!guid_equal(&sec_guid, &nvidia_grace_sec_guid))
+	format = nvidia_ghes_format_from_guid(&sec_guid);
+	if (format == NVIDIA_GHES_FORMAT_UNKNOWN)
 		return NOTIFY_DONE;
 
 	priv = container_of(nb, struct nvidia_ghes_private, nb);
 	len = acpi_hest_get_error_length(gdata);
+
 	payload = acpi_hest_get_payload(gdata);
 	fatal = event >= GHES_SEV_RECOVERABLE;
+	decoded = kzalloc_obj(*decoded);
+	if (!decoded) {
+		dev_err_ratelimited(priv->dev,
+				    "Failed to allocate NVIDIA CPER decode buffer\n");
+		return NOTIFY_OK;
+	}
+
+	switch (format) {
+	case NVIDIA_GHES_FORMAT_GRACE:
+		ret = nvidia_ghes_decode_grace(priv->dev, payload, len, decoded);
+		break;
+	case NVIDIA_GHES_FORMAT_VERA:
+		ret = nvidia_ghes_decode_vera(priv->dev, payload, len, decoded);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
 
-	ret = nvidia_ghes_decode_grace(priv->dev, payload, len, &decoded);
 	if (ret) {
-		dev_err(priv->dev,
-			"Malformed NVIDIA CPER section, error_data_length: %u, ret: %d\n",
-			len, ret);
-		return NOTIFY_OK;
+		if (ret == -EOPNOTSUPP && format == NVIDIA_GHES_FORMAT_VERA)
+			dev_info(priv->dev,
+				 "Unsupported NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
+				 len, ret);
+		else if (format == NVIDIA_GHES_FORMAT_GRACE)
+			dev_err(priv->dev,
+				"Malformed NVIDIA Grace CPER section, error_data_length: %u, ret: %d\n",
+				len, ret);
+		else
+			dev_err(priv->dev,
+				"Malformed NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
+				len, ret);
+		goto out;
 	}
 
-	dev_printk(fatal ? KERN_ERR : KERN_INFO, priv->dev,
-		   "NVIDIA CPER section, error_data_length: %u\n", len);
-	nvidia_ghes_print_grace(priv->dev, &decoded, fatal);
+	if (format == NVIDIA_GHES_FORMAT_GRACE)
+		dev_printk(fatal ? KERN_ERR : KERN_INFO, priv->dev,
+			   "NVIDIA Grace CPER section, error_data_length: %u\n", len);
+	else
+		dev_printk(fatal ? KERN_ERR : KERN_INFO, priv->dev,
+			   "NVIDIA Vera CPER section, error_data_length: %u\n", len);
+
+	if (format == NVIDIA_GHES_FORMAT_VERA)
+		nvidia_ghes_print_vera(priv->dev, decoded, fatal, event);
+	else
+		nvidia_ghes_print_grace(priv->dev, decoded, fatal);
 
+out:
+	kfree(decoded);
 	return NOTIFY_OK;
 }
 
diff --git a/drivers/acpi/apei/ghes-nvidia.h b/drivers/acpi/apei/ghes-nvidia.h
index f0592fa41abf..7fff088e1dc1 100644
--- a/drivers/acpi/apei/ghes-nvidia.h
+++ b/drivers/acpi/apei/ghes-nvidia.h
@@ -3,36 +3,61 @@
 #define GHES_NVIDIA_H
 
 #include <linux/types.h>
+#include <linux/uuid.h>
 #include <kunit/visibility.h>
 
-struct device;
-
 enum nvidia_ghes_format {
 	NVIDIA_GHES_FORMAT_UNKNOWN,
 	NVIDIA_GHES_FORMAT_GRACE,
+	NVIDIA_GHES_FORMAT_VERA,
 };
 
+#define NVIDIA_GHES_MAX_CONTEXTS 16
+
 struct nvidia_ghes_grace_reg {
 	__le64 addr;
 	__le64 val;
 };
 
+struct nvidia_ghes_vera_context {
+	u32 context_size;
+	u16 context_version;
+	u16 data_format_type;
+	u16 data_format_version;
+	u32 data_size;
+	const u8 *data;
+};
+
 struct nvidia_ghes_decoded {
 	enum nvidia_ghes_format format;
 	char signature[17];
 	u16 error_type;
 	u16 error_instance;
+	u16 event_type;
+	u16 event_sub_type;
 	u8 severity;
 	u8 socket;
 	u8 number_regs;
+	u8 source_device_type;
+	u8 event_context_count;
+	u32 architecture;
+	u64 event_link_id;
 	u64 instance_base;
+	u8 chip_serial_number[16];
 	const struct nvidia_ghes_grace_reg *grace_regs;
+	struct nvidia_ghes_vera_context contexts[NVIDIA_GHES_MAX_CONTEXTS];
 };
 
+VISIBLE_IF_KUNIT enum nvidia_ghes_format nvidia_ghes_format_from_guid(const guid_t *guid);
 VISIBLE_IF_KUNIT int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
 					      size_t len,
 					      struct nvidia_ghes_decoded *decoded);
 VISIBLE_IF_KUNIT int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
 						unsigned int index, u64 *addr, u64 *val);
+VISIBLE_IF_KUNIT int nvidia_ghes_decode_vera(struct device *dev, const void *buf,
+					     size_t len,
+					     struct nvidia_ghes_decoded *decoded);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_entry_count(const struct nvidia_ghes_vera_context *ctx);
 
 #endif
-- 
2.50.1 (Apple Git-155)

