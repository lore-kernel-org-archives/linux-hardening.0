Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4FD3C4572;
	Tue, 16 Jun 2026 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581477; cv=fail; b=L78ivxyUkdzQP/yvW7j5P6d/VxfBLbUC03bMfoTGbCOwxUzuqWH1TlqKuhenyn8bcpAcQVTN5Mx2ubfKKSrS9YOrqfEJLvsjeToC97nuxqJ8kN3R2V3AsrRGXri/2hwflhfGEVMOVodYBrGu3TdnLuS+Qma4/n5gpEVjsUeevYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581477; c=relaxed/simple;
	bh=fYziD2JCA71chJ8csAOhdFgevIk163Kz/4mktR4obh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tM64IIhm6YdgTJXrKXOpiqPDp15esr9dMv0wiInUZP9QO6SxfuhPOCaieXLBtQ0y8EqAbLBMeVFrgsp/RjjDlBiXHqJi8QsEAHdOCo6zm8lmCEzI08XECl88ruGqTiWJ2coP8LwEHjkmPJKVgurm1mzRIXvXTVLomEY/sEiyeyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EFU3TVyl; arc=fail smtp.client-ip=52.101.56.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EFU3TVyl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJxvoqz/x/HvdF6EK/bq0MkFc7fNwOUSzKWoJGcBPKDLiywpUr2OvMUdYmDXwi7utzWfQKdgp86pRURhFZeeL1OP39nOMatZaRqvlmibABDGY4ItNEKaUJej2HI6OAsmoWLXdzyt/Tc+owmOnzG3M9/Q+YfgXPiUSydUIdTeyz1r6jMJ5xjABhaIFNOGoDeiehgYFzNVo5vveK8SLWYbv0MpJAR4jTgArAzzTlcB0ahI4XAWatUq36UvSWh9FWMgXpYer9sL4ug8lIF+ijA+LxT1kTk9JhTTmgx5eEjdauTVxN2NsYOXWGlj7v6hcSgD+O36l1MLu0wfFiK9D7z96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcZbxPGcYXYz7Wi5eDAG1pb2JFEUFfarDZN6c+PbE+s=;
 b=l7DU409o6FWeOBC+BgRAYazu9LYssANTQGLsNfQ+7TmVWDqylA4gpVHGPidli+8XaD55tDmDvyacy2J/CxPW7zgYNowp2rxHbh/q27B4T/bC3bQp/eqE1e3sW2pjDk3Za1tNkAPwQILaqZ5dbCKyVAchv/vurKj86V/0kMLb2nRW6imTMhDs2J0L652bMDJO+he3ry7X5yrF+A53B/GhjZ7/Ry3/aHpWbsiqjplZxakW0BEZe9dUqA5N8mnVN+5voA07ku8rV6BZUjwdChidH/KRADP9vQBIcHkADmaAYRlbAgx58+GsGIK+MGIjChPokW4GsARy9PAWWBCvDoAu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcZbxPGcYXYz7Wi5eDAG1pb2JFEUFfarDZN6c+PbE+s=;
 b=EFU3TVyljpvAsoBoq2+Aa1thvOlo20arRZZYifjSBmoMYhpBN350E4WFjRJRxt68YHNG/XHmGaqQkOpDKIKpO7HTArvAAf/RCV+px07XtiZwviC3ddZ1SOU+O+02mK5ZVygBZZHPJgGGOfNlxururxj8xm4doQdKnFbIfaSMq2ZkBjkQQtDr3lJ3xX1tmX/0Lbs0PcEYUMkjjPQTtYbiB71lyjxOw7JesE1OvqXCcTrNOhzDaPZQM2iQ/SZh2JU3iYI9CVWngMXbiL950fuBD1Yhm8WW5EIjBczFeROdMPL/jFWh9s8NbJB7F1uvQjUrPpdbWaNqOVFO5Oia/gW3OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 03:44:28 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 03:44:28 +0000
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
Subject: [PATCH v2 1/4] ACPI: APEI: GHES: Refactor Grace decoder helpers
Date: Tue, 16 Jun 2026 11:44:07 +0800
Message-ID: <20260616034410.70675-2-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616034410.70675-1-kaihengf@nvidia.com>
References: <20260616034410.70675-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 687a47fd-00f6-4ba2-9f69-08decb599148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	iXg8GBP5V7uUdSe4vo6herlUEYDW5TxoJiW3UJ1/hGry3MIgxg5NgvGXHmsXjyDqyJwCl/2Ar1ql2cCJA2zLTNLkgxrjS2sePR+YGxFOlzNE7KrspMNk6dCFqesOMK71SABWJ8rn3Gpw4DxJ2qGDuxZq6mzsfDshYbj71CLe0qgsMQpkADMGN2cH2xgFmMhnX6bEscZhx9Q+uy/tUvTCGNyy8+SOHG7Ah3d3kAFTAr6pbISoUFzXgqSQT9qOEGYhwh9lOJKREK/oeuIIxsLZ7tPtdBLmM8DCSjGIerFEXKPpjxO2xhWtRiVih2hbjuzUbM5WOFbIlVsICUc7ynDLoZwuNLs5N3ZhuMPF17+GQqpK6VewLTi8Cf420lePQyCLoM3ZCEHrpGgeCq1Leljykal4UzOJkt8kdmlFPs8wAZt0tzFnEEXxJD4vso/9U7JxT4/a/RnOcguTCwpIcU688K1dZK2cU1wqeT05q9NY2jLYpKedniTUImnfTYnHC38nkea/810HrSaOPBg8fyjuRGTB2ADV2/HaE66Nz2+FNQo/0d/hUKnF1nJ+WkW0csN1pl7lTVf9srh2FlBZu8hxvuNvTv28kla2fxgdzFpXLUOWNGmxLVayqJ8X6j42uow60SFTCCxMEedvXjY1DXRz+2eKQEun5HDW+0INTkwcHdqvHeOdWItDNGa59BGTteAY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u5WIi2NGD18edWtqFDWYN+06Pp+GhlLhAfcUvWJr55J/wgCq6s6oMjeLyEBG?=
 =?us-ascii?Q?p8RuDWLB+hTfPJHd3IVBddLDFp5fXtNwGjuscRtooy5MxRi8RsGbXc4AgIe2?=
 =?us-ascii?Q?OVpJXzYUfywAOh5M5AYFdo9D89RAFPX60/HuY1m/0thzLVB3+X3W8Lt+Hp65?=
 =?us-ascii?Q?3yXGKCKdB3irjj2Y5DFVoMnvX8Twfnws1ekXmWOdeb0g9VRlJNhQiWahdDjd?=
 =?us-ascii?Q?j1uTtufBdq/zRBpm2tPozgclr/GMZzODSwu0GBb1XRQWnyMltEcPP+TfCM0l?=
 =?us-ascii?Q?TW/DZUStfx8rcqKFvpEug3ebVdC7qXZfF59HMjGqZlu3s6sN2CFjBOL8iIbg?=
 =?us-ascii?Q?0ma60MviYK17rPTg9Cubiz/D7vbtOxYj6XGD2UDR/GXCll1EvtXV44iQDi9o?=
 =?us-ascii?Q?ApVaDJzUqmcCDewEKysfTTmSMJNIDCa4jcccmEzTZvB00wMy7aE53MHFkUhV?=
 =?us-ascii?Q?Qzx1H66O2BzRTBlcdGCJks65Sl8jD8AQvdLq9eS3j21YUAysqNWW40NZtVLT?=
 =?us-ascii?Q?nS2Hb4a31QPzVC+UN5N7j/Bh+/LmuhP1S3A5cG3s52jVzRTXXexiWX/pg9on?=
 =?us-ascii?Q?z4Zcnef+hTiwCQxvtACE7rK+OjZc/hoU07EZGtL82/yGP5S96u3ueBgUek+p?=
 =?us-ascii?Q?yQNqHAEuaLy9AjcfMznqS45d8c6/lnHvMBHkVuBMVNYfukevI12rokiHcPKT?=
 =?us-ascii?Q?PUSSiErj4S0CAeGYJbHKx4F3hhSRf6sPIDQMs2qAHbX+O8SEzBcu90Tz55Wn?=
 =?us-ascii?Q?R0QR5iDBhLtsgK8A4l46mve40GVWQu3zqNt3JW8EaC/kUyCyxE+UZxwADVwm?=
 =?us-ascii?Q?1H+ey5fX5NmDPs4vxr2shvLGO+1o3hkC8n13kJPfmiLOLo/QR052GADgwBvE?=
 =?us-ascii?Q?FDz5uJ3ZAy8S4ppTkNllv9Me2Et4hgey99qGV+il2mVsHMYSvyp7jcGuGvQd?=
 =?us-ascii?Q?RAJOW2vbZjNxhu+jQRJfLhIoRLV4gcQQX9roi7mwEhTkvYuOuX+ZXLEAPVeM?=
 =?us-ascii?Q?YLXNzrTjAEpoaOT8VjxErk+V7Rd7S3LImb6aAgMOElXBq3KVTqeRRsyGVhWw?=
 =?us-ascii?Q?kTQvzBRzaqRB4GU6JoERBZbVOiIdsKx817zb83yV25fYy57LrsI7Eq+PMUfR?=
 =?us-ascii?Q?iDs7hThxkbEjq7Jukx0IyoFLqT2gcYRnW1827mjhzWSeLQstR3sjdC9SbEnp?=
 =?us-ascii?Q?L67xVtvK268MN0l/bTMoJa7gC+5BN0Y/tb5p98h6RG719EclRpiiuTBnhdg+?=
 =?us-ascii?Q?UcwgrFZNIl+Xa978uyp6MnDxvbv5JeOqqw9lPu0Z67AYbEfP/LKGN9wtB/1t?=
 =?us-ascii?Q?hoh18VnoBvbdxAmf3wZZZAATBS++qVn1q+k8cgffSmNhurnuUwDFpqnog+Fc?=
 =?us-ascii?Q?Y1Aw2eoAM/M6i7s+BFaEC+dZTTrrGvikV3J7hiAiHwNWNecNhySOD4VLXaLA?=
 =?us-ascii?Q?kU4wopOYHJMs26IJTbi46tjDjhVnUkh+4DTulKKbwjBsYMbfjVKPIsr8IPUU?=
 =?us-ascii?Q?DBPPej/OcM8Z6mPVibSgfAlDE8KVMh6uSAbuFWxqL1wifLg5iGcDid9Z72q2?=
 =?us-ascii?Q?yCYVtIIxYamJ8lKKHpDe2DVO8E8ee1PIYe4IrfkNJmK+ZaHTwdszU5RyDQDo?=
 =?us-ascii?Q?ubyXHCzMp082j8Y24Q151pIkp3uCPKuyms4sLAF9AE/Dlwu7vQWudImXQL64?=
 =?us-ascii?Q?DYcUgIz5r3+wIOG7r052gwwtLrGdBZe+9eXhN8+wrR98AsgVIDt8Xca2lQs4?=
 =?us-ascii?Q?MSSbq5KQyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687a47fd-00f6-4ba2-9f69-08decb599148
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 03:44:28.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ni4fZcO0+SlvfVaFCmZ60B87D9KoFsW8pFgE185v176x6FRRf8klLEOZRzlKoUVqelNq9oAI1ss7UH2WCCziuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063

Split the Grace CPER processing into a separate decode step and a
print step so the parser can be exercised by KUnit without a live
ACPI device. Introduce ghes-nvidia.h to hold shared types that the
Vera decoder added in the next commit will also reference.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v2:
 - No change.

 drivers/acpi/apei/ghes-nvidia.c | 148 +++++++++++++++++++++-----------
 drivers/acpi/apei/ghes-nvidia.h |  38 ++++++++
 2 files changed, 137 insertions(+), 49 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes-nvidia.h

diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
index 597275d81de8..af445152def0 100644
--- a/drivers/acpi/apei/ghes-nvidia.c
+++ b/drivers/acpi/apei/ghes-nvidia.c
@@ -12,7 +12,10 @@
 #include <linux/uuid.h>
 #include <acpi/ghes.h>
 
-static const guid_t nvidia_sec_guid =
+#include <kunit/visibility.h>
+#include "ghes-nvidia.h"
+
+static const guid_t nvidia_grace_sec_guid =
 	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
 		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
 
@@ -25,10 +28,7 @@ struct cper_sec_nvidia {
 	u8	number_regs;
 	u8	reserved;
 	__le64	instance_base;
-	struct {
-		__le64	addr;
-		__le64	val;
-	} regs[] __counted_by(number_regs);
+	struct nvidia_ghes_grace_reg regs[] __counted_by(number_regs);
 };
 
 struct nvidia_ghes_private {
@@ -36,73 +36,123 @@ struct nvidia_ghes_private {
 	struct device		*dev;
 };
 
-static void nvidia_ghes_print_error(struct device *dev,
-				    const struct cper_sec_nvidia *nvidia_err,
-				    size_t error_data_length, bool fatal)
+VISIBLE_IF_KUNIT
+int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
+			     size_t len,
+			     struct nvidia_ghes_decoded *decoded)
 {
-	const char *level = fatal ? KERN_ERR : KERN_INFO;
+	const struct cper_sec_nvidia *nvidia_err = buf;
 	size_t min_size;
 
-	dev_printk(level, dev, "signature: %.16s\n", nvidia_err->signature);
-	dev_printk(level, dev, "error_type: %u\n", le16_to_cpu(nvidia_err->error_type));
-	dev_printk(level, dev, "error_instance: %u\n", le16_to_cpu(nvidia_err->error_instance));
-	dev_printk(level, dev, "severity: %u\n", nvidia_err->severity);
-	dev_printk(level, dev, "socket: %u\n", nvidia_err->socket);
-	dev_printk(level, dev, "number_regs: %u\n", nvidia_err->number_regs);
-	dev_printk(level, dev, "instance_base: 0x%016llx\n",
-		   le64_to_cpu(nvidia_err->instance_base));
-
-	if (nvidia_err->number_regs == 0)
-		return;
-
-	/*
-	 * Validate that all registers fit within error_data_length.
-	 * Each register pair is two little-endian u64s.
-	 */
+	if (!buf || !decoded)
+		return -EINVAL;
+	if (len < sizeof(*nvidia_err)) {
+		if (dev)
+			dev_err(dev, "Section too small (%zu < %zu)\n",
+				len, sizeof(*nvidia_err));
+		return -ENODATA;
+	}
+
 	min_size = struct_size(nvidia_err, regs, nvidia_err->number_regs);
-	if (error_data_length < min_size) {
-		dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
-			nvidia_err->number_regs, error_data_length, min_size);
-		return;
+	if (len < min_size) {
+		if (dev)
+			dev_err(dev,
+				"Invalid number_regs %u (section size %zu, need %zu)\n",
+				nvidia_err->number_regs, len, min_size);
+		return -ENODATA;
 	}
 
-	for (int i = 0; i < nvidia_err->number_regs; i++)
+	memset(decoded, 0, sizeof(*decoded));
+	decoded->format = NVIDIA_GHES_FORMAT_GRACE;
+	memcpy(decoded->signature, nvidia_err->signature, sizeof(nvidia_err->signature));
+	decoded->signature[sizeof(nvidia_err->signature)] = '\0';
+	decoded->error_type = le16_to_cpu(nvidia_err->error_type);
+	decoded->error_instance = le16_to_cpu(nvidia_err->error_instance);
+	decoded->severity = nvidia_err->severity;
+	decoded->socket = nvidia_err->socket;
+	decoded->number_regs = nvidia_err->number_regs;
+	decoded->instance_base = le64_to_cpu(nvidia_err->instance_base);
+	if (nvidia_err->number_regs)
+		decoded->grace_regs = nvidia_err->regs;
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_grace);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
+				      unsigned int index, u64 *addr, u64 *val)
+{
+	const struct nvidia_ghes_grace_reg *regs;
+
+	if (!decoded || decoded->format != NVIDIA_GHES_FORMAT_GRACE || !addr || !val)
+		return -EINVAL;
+	if (index >= decoded->number_regs)
+		return -ERANGE;
+
+	regs = decoded->grace_regs;
+	*addr = le64_to_cpu(regs[index].addr);
+	*val = le64_to_cpu(regs[index].val);
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_grace_reg_pair);
+
+static void nvidia_ghes_print_grace(struct device *dev,
+				    const struct nvidia_ghes_decoded *decoded,
+				    bool fatal)
+{
+	const char *level = fatal ? KERN_ERR : KERN_INFO;
+	u64 addr, val;
+
+	dev_printk(level, dev, "signature: %s\n", decoded->signature);
+	dev_printk(level, dev, "error_type: %u\n", decoded->error_type);
+	dev_printk(level, dev, "error_instance: %u\n", decoded->error_instance);
+	dev_printk(level, dev, "severity: %u\n", decoded->severity);
+	dev_printk(level, dev, "socket: %u\n", decoded->socket);
+	dev_printk(level, dev, "number_regs: %u\n", decoded->number_regs);
+	dev_printk(level, dev, "instance_base: 0x%016llx\n", decoded->instance_base);
+
+	for (int i = 0; i < decoded->number_regs; i++) {
+		if (nvidia_ghes_grace_reg_pair(decoded, i, &addr, &val))
+			break;
 		dev_printk(level, dev, "register[%d]: address=0x%016llx value=0x%016llx\n",
-			   i, le64_to_cpu(nvidia_err->regs[i].addr),
-			   le64_to_cpu(nvidia_err->regs[i].val));
+			   i, addr, val);
+	}
 }
 
 static int nvidia_ghes_notify(struct notifier_block *nb,
 			      unsigned long event, void *data)
 {
 	struct acpi_hest_generic_data *gdata = data;
+	struct nvidia_ghes_decoded decoded;
 	struct nvidia_ghes_private *priv;
-	const struct cper_sec_nvidia *nvidia_err;
+	const void *payload;
 	guid_t sec_guid;
+	u32 len;
+	int ret;
+	bool fatal;
 
 	import_guid(&sec_guid, gdata->section_type);
-	if (!guid_equal(&sec_guid, &nvidia_sec_guid))
+	if (!guid_equal(&sec_guid, &nvidia_grace_sec_guid))
 		return NOTIFY_DONE;
 
 	priv = container_of(nb, struct nvidia_ghes_private, nb);
-
-	if (acpi_hest_get_error_length(gdata) < sizeof(*nvidia_err)) {
-		dev_err(priv->dev, "Section too small (%d < %zu)\n",
-			acpi_hest_get_error_length(gdata), sizeof(*nvidia_err));
+	len = acpi_hest_get_error_length(gdata);
+	payload = acpi_hest_get_payload(gdata);
+	fatal = event >= GHES_SEV_RECOVERABLE;
+
+	ret = nvidia_ghes_decode_grace(priv->dev, payload, len, &decoded);
+	if (ret) {
+		dev_err(priv->dev,
+			"Malformed NVIDIA CPER section, error_data_length: %u, ret: %d\n",
+			len, ret);
 		return NOTIFY_OK;
 	}
 
-	nvidia_err = acpi_hest_get_payload(gdata);
-
-	if (event >= GHES_SEV_RECOVERABLE)
-		dev_err(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
-			acpi_hest_get_error_length(gdata));
-	else
-		dev_info(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
-			 acpi_hest_get_error_length(gdata));
-
-	nvidia_ghes_print_error(priv->dev, nvidia_err, acpi_hest_get_error_length(gdata),
-				event >= GHES_SEV_RECOVERABLE);
+	dev_printk(fatal ? KERN_ERR : KERN_INFO, priv->dev,
+		   "NVIDIA CPER section, error_data_length: %u\n", len);
+	nvidia_ghes_print_grace(priv->dev, &decoded, fatal);
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/acpi/apei/ghes-nvidia.h b/drivers/acpi/apei/ghes-nvidia.h
new file mode 100644
index 000000000000..f0592fa41abf
--- /dev/null
+++ b/drivers/acpi/apei/ghes-nvidia.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef GHES_NVIDIA_H
+#define GHES_NVIDIA_H
+
+#include <linux/types.h>
+#include <kunit/visibility.h>
+
+struct device;
+
+enum nvidia_ghes_format {
+	NVIDIA_GHES_FORMAT_UNKNOWN,
+	NVIDIA_GHES_FORMAT_GRACE,
+};
+
+struct nvidia_ghes_grace_reg {
+	__le64 addr;
+	__le64 val;
+};
+
+struct nvidia_ghes_decoded {
+	enum nvidia_ghes_format format;
+	char signature[17];
+	u16 error_type;
+	u16 error_instance;
+	u8 severity;
+	u8 socket;
+	u8 number_regs;
+	u64 instance_base;
+	const struct nvidia_ghes_grace_reg *grace_regs;
+};
+
+VISIBLE_IF_KUNIT int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
+					      size_t len,
+					      struct nvidia_ghes_decoded *decoded);
+VISIBLE_IF_KUNIT int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
+						unsigned int index, u64 *addr, u64 *val);
+
+#endif
-- 
2.50.1 (Apple Git-155)

