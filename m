Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A603C4B81;
	Tue, 16 Jun 2026 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581482; cv=fail; b=UJgAN2yQJ8edGOIfqrNnSUsppo/bookFh2I6Y5ccZMgI8qeGdTQdEf0H+XFeZ7dNFazcjunlMLrAwJaDZd4j4/Bpudx3kL70xpcvel79sSV82so/djlVNtuM3g6fL2Cx8eNz/wUKWR+21raGUQZH6Il2rWerii8/EqmaOgCv6WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581482; c=relaxed/simple;
	bh=Hu7/Ofu67+mML09MKFcOGK+Y99b00Tq1zcqVA5P0SN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G33idYHd4NBq3IIXsBqQEeUdByja6bJi9mWhKY1/uzm645UihKTewkv15lygMksPh6XJmiJBEFOCrVW6j1RHY1MS2pJfU1AuWkxJnT9kNETJwvI5Gc46+O0f1Ttguq4tS3nPU492A2ANTsmjoqIfHf0Mb96jQQF6G9MOFJphHOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBuxIEbt; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBuxIEbt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7Ch0T9HIyrwEY0pzTOOG9QNs4eihBlNPTv5xciPD8rivVQGqWqA3fORv+TgRgTK/VRX6DNz1NrTc+71wEju3w+4hhY0IpqR38llQSGj20fHftvkTtnC97XL6TS06r+p83yiNCqZjEkuyIxSlnV4TZMP/4DO4nKZ2MPJrNc0XJgaqOyG5eY1/71ij7U2HPSLkuzsud1YqDHN3E4m9h+qLdJo/DcHrqFp6wW2wfIsvdMGBUSCI6rSK2QhpBJnEmj1AMgK4SYqDsE4pjNgZQp6PGZ1hr7s/R9KJwcao7lhM0Nie748g9mf7HhNqC3FjERBpCu9LFHJie9HPbR6EvulmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmN1SJuu7M0BDiG/14Lv4pxsBGz8yWvwOm3r1/ul9sc=;
 b=IUJJkNf+l3up3O/qvS4bw7C9gljv0zN+VT0jX0pJbrBVAEo8MZRnxpciZbCxc6Uu3aXr8q6R9B84GsDxiRF5NmgkgYizaF2d/jg1rI/OghMROwwjwzXVZFeprBCCFA8sLuuyAgZMcXlhN89sOFkpKvdeA8gMnh7GUPJA/257ZLzBBzvgIJRYZdRGtWEoGYabUbomUIAblnBWryH+QD0iFja4Ts9hdDTSS0XA8DDulFGCQnNRH80iTkKfsgTkBJ8b3ru+yeFQ8QL3XyTf2dMGwpyD4vvb+R+5Iy8zkcClghgESVjPHjtrlYJHeVQsHOJZdn9ZfW7N2/JoM362d7Ejdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmN1SJuu7M0BDiG/14Lv4pxsBGz8yWvwOm3r1/ul9sc=;
 b=hBuxIEbtC3jGfSqYbrxBBPDpR5g4sT/jEZnC6x8fhzcbDNVn2cDw9In46N9Ysd9b6U5dRjpgPSOwCdLjbovlCfRUdmjeUSpsrKcI20Z/z310zxCiH/wbAhgP5rIhx26IKggQprYvCZO+oW7mstG1Jq2TYuAVHVxtxyeT/gzoFeWG/o80HoMBahBb8/2BxDaPDyR4i7ww1z9gFFSpef7E6QzpLXo/ELllyI6h2ceqdPQ/ieUo0sjLDx7ShzHpZ/mRGULbJ+sDadOwCXAoRjet0y8iODjkWhG0TuwL2xaI+Ytlx7iEG0PCt4jSU2AgO0r+4wVsT8tsD+Gks9j6D57SYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 03:44:34 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 03:44:34 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org,
	shuah@kernel.org,
	kees@kernel.org
Cc: julianbraha@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	csoto@nvidia.com,
	mochs@nvidia.com,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: [PATCH v2 2/4] ACPI: APEI: GHES: Add NVIDIA Vera decoder
Date: Tue, 16 Jun 2026 11:44:08 +0800
Message-ID: <20260616034410.70675-3-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616034410.70675-1-kaihengf@nvidia.com>
References: <20260616034410.70675-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd777c4-fb3e-4a9f-330c-08decb59948b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pqMb9FyTYbQZYmQVS1/E/b+NP4z4ijFXG/BsILgSyXsqoDXZp5UDjZcXKQXZx3abT/fx8w6/loEbKQP0eWiBEU8huQ6SMACODbrwhflHf4ldkodUX8VdnfTCjuZ+o3Sfg2BTi7vYDBe2AAQrdyQxkuJVZF88ZPrXNhV4Tb9Km6bXjBNh6bYF2LAblz2kHz54WsWYmw/h9jUTvRNbRFvBuXoX7md5WNyy5rI3I4vGHLd9l22Y719wOiAygdk3n6l3E7Ma2PLgMX6BRDZaeq7eR/52lZChJ7up/GLMYatgvYUvKLflpbdZbXe5b2DLv7YnfXBRM+tkJolLhkmQk2jx6OeEVF3CrXj+ftTtU4jU3oPgFfema89CDI19jNkceHAdbXE/RfspODGFB/jqz6YWM4GoHNuB8huYwzf2tkV37gWzsUB4cT60tm59Va+8bw8mHDpfUo5dojor2NkclwfjRYK4Lk8RWD6/3TYNY5C0IdOjgpDFPeQvQY4pIIpXropBmhhkVoRyaQ72Jb5noBerhI+nP7ve1gjRqOZaitv9LydihOp98osg/kSBZev9VMiOfCqEoXAakPe3v7OSOlEb9/lN8aR3ao5QB8mjhHp/Y7cFDcqu2UdubVqOt9djPqA7driK1mNBinIhMmejw7zQREkI35bHuEzfCgFFJVd0hY/PcGGH/9wj5hMCmrBUEVru
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8oym5T2npLcGQti17aK3z7e0phR7iCcchz35qhlhhd111Fc29Z7fqwWzpGft?=
 =?us-ascii?Q?SZ6OPgkCzKM9btEYYa07a0kTltZTob5UMpNVsSGuy1SwwElDaPWjymn6QwD7?=
 =?us-ascii?Q?NpcyH8e+/ehs0OygWBvQylqp4HBQ/gtCz3Z/FwRwHoSJgTVhqflHQRae5SMg?=
 =?us-ascii?Q?mlVWBDYoLO3B8tEDxvnEsEVmsFQbfKjd3xWi2cSe3W8/K47sF5StbcQTh7F/?=
 =?us-ascii?Q?kQ39N/ZbPFyUxX/zhDGHtcLsOMw/PmPJgecYhtJE6MvB1YDY6nmhYl4tCWWj?=
 =?us-ascii?Q?ksqvfOBfgJFmD4xolUv/YSda6hc62A0BpXrhvt2xDPbwYwaunxuAOJ/GEx4o?=
 =?us-ascii?Q?/qsSvCRPVzaVziY8ETVlidUl6an7M9DnCNEQqHWBGYRz8dgZzoQLPOReiWZ/?=
 =?us-ascii?Q?DHiif74qs+0LMOyxxKXzmcPJGV2V922XWYuNO+qUfZieBiNtKWS7EWElN8Rp?=
 =?us-ascii?Q?ztztn6eFYvkDS/4HMmc9Z7F6tIFdM+Frqq6OsdoIYUSx8Tn6aKv3Zu2lF8gZ?=
 =?us-ascii?Q?MPCuwgp41qkULwgOCMQYAzPpqjZ8Ybw+EVThj+u0DSNeuj4LJoYklRT6NECB?=
 =?us-ascii?Q?7hgQmw+E978sinT4nBlbTTQQllFw8na4gUVCxdBUDU+kzyfuqySh8sRGcQ+H?=
 =?us-ascii?Q?/lRWvJa6BvJDpEbOoHGk5SHkFI9q3u87EjVVdnihdtSqUh0nCrqoSfnhZU3s?=
 =?us-ascii?Q?FwWPbdWLTNg3Yz7wnPP1o5u9MQuBU8b1Ro1kcynqqKzHEHQ2LQnm70K2fMpJ?=
 =?us-ascii?Q?zi+UzU1wni710fBYMYXWIR76/H4Vlftbtcgqs4xoiMwQOkYrlexB8bf2FWf5?=
 =?us-ascii?Q?Ma3Nm859aTasBrl/TL7I3lz8EZEt8zUN/qitEJnb7AfAYzbx+nykJzbnUajU?=
 =?us-ascii?Q?KoU+j27nEBkJm1VBJ6DBO63Y04yZ724C5yHagVgjGxuSbRMA8Jzh+v7TZpxJ?=
 =?us-ascii?Q?nQGyQM6K4bylnA500YhO15GaiQArs+51vt534o9bFAXUQe49qh9s3E49lTov?=
 =?us-ascii?Q?K75Kp5QYE0E97k4teLTXZlkHQTSlp9kK+mngwVIi/8Xlgct+5otF/LV4ILDO?=
 =?us-ascii?Q?242x1YXKoreuF0esNmbyN1wQizjHqjwyZvfnj9Yy0e0PK542zlMQ7gQ9fDjP?=
 =?us-ascii?Q?PHd6rFhp8jGxuun8Cxz2XmhTYnzMqYOMXyH2601SFnOLUrJgi76SVbWDkYWN?=
 =?us-ascii?Q?LpMAN2/OuRYz/AdQlvganf8U00Qr08SdHWvMuR7cpUeGEQA3IQseU3L1dhG3?=
 =?us-ascii?Q?j4WxHaMEArCrQKl3bRAVihkVEb/Pn01h3q+82HL7KcHWLCNp66FxpLsqTitN?=
 =?us-ascii?Q?LMLZ5xvI5Vt77wJxx4VU3TiDdbNNiLKNisWBFkukAKNGtGcpGOeymuAjBNol?=
 =?us-ascii?Q?SgYqrRNiKuEr3syuCGcUrcg0LKuNyJaZL6ercuBqUWFlFmc0rFuWsaNZ8lo9?=
 =?us-ascii?Q?dKB2S+EVYlnS5kxr9IIfUX+8ND7SKkCQBac+zPntQ1iH9hPQE8e10nFpPhdD?=
 =?us-ascii?Q?8yF0bF01BJWWUOha/TvbLPN/1bgRZgyezghBJMMi8J3tmxFFIYnVgeK5j+lf?=
 =?us-ascii?Q?Mb+x4RMheN73tVNM/o5CcCGk4KB+X2uDymfOCb4smSHALoMLFDfmMacSQOq7?=
 =?us-ascii?Q?yqKNt2TGJEP+GInvdtgCQFgn1wnA12Dz/n2DAwBHem/nAj47ZCkTf6de9k/8?=
 =?us-ascii?Q?+vAf8ARWKbj140k23pxuQT0brlbqxrmXz9/nTw8o/Ehu2DlhLAhRwJksBFkt?=
 =?us-ascii?Q?+NDRLr5Z1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd777c4-fb3e-4a9f-330c-08decb59948b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 03:44:33.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxrQJCaPm9hRa6j6pFX/5G5QQ4ENGzk2wMWmq/sh8xgOMEweo5DlXtHR48ZbVpRHpZB0hpfP6eM7v3m7O6oVlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063

Vera is NVIDIA's next-generation server SoC. Its CPER section uses a
different GUID and a different binary layout from Grace, so it needs
its own decoder. Without this, firmware-reported hardware errors on
Vera platforms are received but not decoded.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v2:
 - No change.

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

