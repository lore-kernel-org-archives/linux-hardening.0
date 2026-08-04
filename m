Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922B38757C;
	Tue,  4 Aug 2026 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846223; cv=fail; b=hiM1/vzE5U8B5PejfYoWkTDEElTR8afNQGGg5Wz5M3lp4gL4L0ttqjNYNWR0udhsN2GHQpFtpdUvZiSuo2QWouHTgg0vslAKR6b3k+a51pOgd1S9F1V4nPhzXqJtQABKLdd0wDy9+AU3XoIHunoaiEPiY4eYqDG6e06Xp627d9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846223; c=relaxed/simple;
	bh=G+ilNlcBrWK9+6PlOLmz1KeelxY7iTvv/hS1rHgAS6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avNvILskO62+2D+Sp6zZ0OVTDgDJ/oikAojgNvmgKxTw2nWCMy8c8lqVRF+42n3w51kMB/zgDz/Yf6tgyqHYvYXkon0aeTb7Td2pTyR9HXWyaR/BLJj+R+ntcj6+xx8Yv5U7o7SFyrsPBWrwFupDRIZb465fTVPcKBJ+hgarIYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h6+xyTGP; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h6+xyTGP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwCbf6+971GG8W3ikGJPOL+z7NVvwdsbh62OTaLiz/0Oih9wppjQRuey4NmGlYlgx5Hh2PUibV/Rvlhuihi28gUyt1bUGCPkiFXl+WF93C8kKqcW48RPKXBCI2Wp7SNVnOwuZej6/jv8z+vToCt+dehXgX+XyYkmxR7WvZi+1dv+cM6As5qns/AtNoJ/nobDP/pmHeo4rX77NoMEz3PHqXKcq2gvrBSbTYlqT57PomTRzCtvZDrBmq4vajEbcdhd1woHpubCFvREPko7Vc6FZ+3VzrrWqvr9IHVV4TFmqUxabgeEXkciUewx7Yt6aAMS/87fMm8nbJhiUZ/BoWiuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZWUPHLZDvT4JqPeOaSA7oCbItcE1ksbb4lkblWBfXQ=;
 b=JxwGUAgsTsKebE8U1MNdrmbPpHEzXnpWOM5SJ+AP/6QgB9ae1eFsgoUNkWQsnzB6io2Y+nVs+uPSthnog+x5REqPnGBhPLEPKeDBL2I79n79XII6O1WjLUJ2L0WcB5ph19+QfkAN62eKY2ckOkSLpYQkkuJ0NMWheM96Agrr2OxvOrYPzbIe93/I8bbnxwrKk1sTHzrfyzH23yn5Q6WT/pPjB/8XcUC72sgVTGUOLpdXGVWwqrOie+l+cREpqRpNU3VeHRs314T0gcLC8MsiVXBY2fWvFOOe5ExVjRGN+NQ0H6hIgUfZ/YaACzfu9N7th+JLVXGlaqeYOgDfPrRyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZWUPHLZDvT4JqPeOaSA7oCbItcE1ksbb4lkblWBfXQ=;
 b=h6+xyTGPMpE1SGT4uVqi3Gud1J43CbSwOrCgIW/+PNNp3bbJcl6UWimTiBbFbmQqZgq+VhBa8eaI1+0An7i3n4jY43jltVtfLNM2TOhu1wxQ84LsazQdkD3oaMMCgJfosalayQMn7dKaN5UQlTDcE9HfP7otzMNACFxXq8+FaPpH63yXKYcNfS6H8AB/2e7v6QGPZWgggdNS5muKrlOCWjPuUwBCZ92Z03Vqugc7t3qULtETFLpDZAMfZ9kzjcmZlyNmhQ1RpWuJpS2MEkhp8UMwGNh1lflBPNi50wICdnE8uTzGvr9j1jcp8opcZ5CiLRt60ET6HEQ9WYbxrq2mMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by CHAPR12MB999224.namprd12.prod.outlook.com (2603:10b6:610:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 12:23:34 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 12:23:34 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org,
	linux-acpi@vger.kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	lenb@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: [PATCH v3 2/3] ACPI: APEI: GHES: Add NVIDIA Vera decoder
Date: Tue,  4 Aug 2026 20:23:16 +0800
Message-ID: <20260804122318.88193-3-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804122318.88193-1-kaihengf@nvidia.com>
References: <20260724122054.36162-1-kaihengf@nvidia.com>
 <20260804122318.88193-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|CHAPR12MB999224:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8ad878-46fb-4bc0-0364-08def22333cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0aFD/RjzwjP8MdojrQDOu6YCegIjGDQaAG8DVOmhRQRcauDI43cBs05O5hdY5sspqYgA0hjNgiWP9Ydq/ZUfTEuSPC3le9OuStomFlEPQE6j/cuoWXgDc63mH7aczJk3+VkDGFP68xypEN33/E7UyVMyWNTTRPgm9+ztpl3Se3G3G7CpSm2LdUaeDVg0ttfQkzM2KEtNvk8PTNCiAR1eB1gzrHT0S+Zrf3ORN2nsSYGhSNg+StrdUNNuUn04S6jKvH84GZEtHe3XLbxDn0VQ+7rH43UYpmoUlbrnMevi+F2IniXjR4gPQ1ScPEm04I2FpDxyuGChpOr73LrlDNW9dr5cnNo5gzEjt2JGu7VYBCjcO5izZDqd7+o5qPXpHMbSKqJK5a5cDVer69PwhR6D83Md+ttmUPzca3cRukLBuDkftvnz9KMTqQTVK1Xt5LgWd0V4DfrDtChZbLefFis14Fn8RMcnFAJ4IXOP0LYJZBWOhUnw0px8ZNpWhREzQLef2K0n6kgylOJkSdZKDmoX6AZTW6y5fIE+3zAP+Z2DeBsIMOUkW45faXjJJOiqmpP76u7kdfYIyNssf4nFCLh7lOvpDn+Ly19zr73dULbI5ocvLUI1QpXtYjmD379py/ddKmFeBrZDUVdP9Jxx0IR5LyJ0TttzlWeDfg3Gkb97lzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6qnwJ80N27x+iOOnFMJDq5+TTC216QDhM6gEQR3mzn/0hDSI8GuhrngFm4a5?=
 =?us-ascii?Q?GFu1qTrSCucfCbaiOQKcXQkWeZjWphaEVEhm2qtuplD0dx1zS8UfQq4TeL74?=
 =?us-ascii?Q?Y+16tJRc3Jrmd9/2jerJtvNK8EgOipQg3GskqPVX0TlsRLKSKJJnpToVBeoP?=
 =?us-ascii?Q?hAx0/o6BaqS+m9mlLjQTxkGkqWCiBjZZVwD4N1tejYt9ek1KW10pi3M/vQYc?=
 =?us-ascii?Q?NnTl+S7KMV7gBXYPTZpvIAFkH/T5dLU4q71Jj8ftKdAeJuE3jqnKxXFxbKzZ?=
 =?us-ascii?Q?q1YlyRDoayG6lJ0oRaPSlMR0hso8FYObtBIB7GXSBz5F+iD8S4eJ/Ob7FI1y?=
 =?us-ascii?Q?NtDZcnFPq5S8MTr86vUxl4HuGPUsCTmXF/VpPg1J+R0p9jR9u/T0hwuwixo9?=
 =?us-ascii?Q?X5naWMJ+GeTZHJkuprGS3C4fAO0vku6riNWABBaGDtp/KCYb9GvuTYloGeOY?=
 =?us-ascii?Q?hyuqwSit9BDTPCp/Z9W+lp3iv4jHYqlQRpHyvJ5Msxnc1LopuxgUp6rVZtgS?=
 =?us-ascii?Q?YT4YrVZVzslN2H02VIKPAa9O0fUMEM0HBEUIK5BTKyARDtvMxaZB0JxrOn3T?=
 =?us-ascii?Q?gLZiugT0BQO9NNes7uBe7qx2A9eBfzPkIalJSjknqpXhdiKVDHR0jSg8UKom?=
 =?us-ascii?Q?DH6zydwNA6noMynVr7SAr3vehJqboP9R/GJbCAYproMco6ddgkntH13VDaX8?=
 =?us-ascii?Q?fyrEyHg4RFUHm7eDN0u5zC/+EGgj+B1JZcbaz/USCD3m5mnsJ2M7em+qRx/O?=
 =?us-ascii?Q?Ih/ZWGAbOa9h0uIJiNno+88J3Sja2EEMKtLNXaq5SKqe9dlmgcx3flO3pfmw?=
 =?us-ascii?Q?ViOyUYMsU0ntQ6/bR4z9SJDiTmrBBUPvKDgqcB5lwcvD+POrMVWVbYM8/M3W?=
 =?us-ascii?Q?iaeOh42cNj8OC/YEmV7am7Cm/tWgdQ4K/irfWRjd4ZkqCuje8aFmXl4tCQV9?=
 =?us-ascii?Q?dOw6RNX5pB8tkhTJc8fHtDWPM1FcnFAy3grEY8tx/5+J7ODOCgVyLOwGcZ16?=
 =?us-ascii?Q?UT6dOLpnXOeftYK8zhEH1p8exjMA8rQVV4PNS4xqavu7ACmg+ASyRSA+zbl2?=
 =?us-ascii?Q?SviDUsn2xgqcDKPwtH0aAUsXP0RZphvSIrdaEN8PGxrraBqF8MgbO8typ500?=
 =?us-ascii?Q?56fx3Le2oQULDmKr6ZxIuPbjpMHXKpt42Ar/wt4G4LY+YWrMWS3JA5yYyxew?=
 =?us-ascii?Q?dvnXjR5g6cR5tVZzXET2IBOCJOznq1Xw6OPVjwOQSFnubDzmopKoBmvr762I?=
 =?us-ascii?Q?REnkzaXNJSuIGx2KZe5Uhp0cD6GwoAtvxPB3FfvXASIsQLh1BQpkP+BipVMy?=
 =?us-ascii?Q?fBICz/pXf07ZXxrlo2EDGQPAzKh3/k26QjGQ3C2rIa+hmwq2nOVpJXMbkyA3?=
 =?us-ascii?Q?1Y1ycWsAqKI5j7+1iw6eD8PusI2UoU3db63dQuDwSS2ZpVSGUhxVCGRdGKjb?=
 =?us-ascii?Q?RnKW/tdJfOpFEMzjh1f/F66rlJAdbgAh1B5xGj4dM7SylI8F/QaDoNNP1gm+?=
 =?us-ascii?Q?HivcUEChcXoEE4x74W4ZoSmKVQN5agKDW09rPMUydfSfpywoLZINE4axuLzT?=
 =?us-ascii?Q?VuByKdI1Jcr7zlPFp1FIQa3hb2u5ufECTwKi5ai6R5HQfLhyKxpM800PSDeb?=
 =?us-ascii?Q?h5SAEjVhqKLJyUJ5j0sHldFC3JxfxK9waoDC2Pi5g8b9LLvQkWCG40bEIzMQ?=
 =?us-ascii?Q?czGf5Ft2TvPiSDNNbwBia/2t7hhJxg2RvG0A7bOUFLkK5MwVoWNDtYxmNc/P?=
 =?us-ascii?Q?YwUOqBe1HQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8ad878-46fb-4bc0-0364-08def22333cc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:23:34.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDT9zthb5cI0cqXTz2L1WAxDWXxzZk+KCWH6nQGSGroETl4FvERKZsoZ4qEWWrHmG/wc4KcF8eygzgAj57NISg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999224

Vera is the next-generation NVIDIA server SoC. Its CPER section uses a
different GUID and binary layout from Grace, so firmware-reported hardware
errors need a dedicated decoder.

Follow the NVIDIA event-section CtxSize contract. Require CtxSize to be
16-byte aligned, validate that each context covers its header and data, and
advance by CtxSize so alignment padding is skipped. Preserve the legacy
format-0 header-only CtxSize used by existing opaque firmware records.

Assert all three Vera wire-header sizes and keep the decoded object on the
stack. Print at most 32 key/value entries across the entire section, report
omitted entries, and retain successfully decoded contexts when a later
context is malformed.

Keep detailed fatal decode errors unratelimited while rate-limiting those
diagnostics for non-fatal records.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

---

v3:
 - Validate and traverse CtxSize according to the firmware contract and
   libcper implementation; accept aligned padding.
 - Preserve the legacy format-0 header-only CtxSize encoding.
 - Add wire-layout assertions and use Vera key/value terminology.
 - Bound entry output to 32 entries per section and report omissions.
 - Print partial Vera contexts when decode fails mid-section.
 - Keep fatal diagnostics unratelimited and non-fatal diagnostics
   ratelimited.
---
 drivers/acpi/apei/Kconfig       |   4 +-
 drivers/acpi/apei/ghes-nvidia.c | 665 +++++++++++++++++++++++++++++++-
 drivers/acpi/apei/ghes-nvidia.h |  69 +++-
 3 files changed, 710 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 428458c623f0..2dcea74c1677 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -80,8 +80,8 @@ config ACPI_APEI_GHES_NVIDIA
 	help
 	  Support for decoding NVIDIA-specific CPER sections delivered via
 	  the APEI GHES vendor record notifier chain. Registers a handler
-	  for the NVIDIA section GUID and logs error signatures, severity,
-	  socket, and diagnostic register address-value pairs.
+	  for the NVIDIA Grace and Vera section GUIDs and logs decoded
+	  metadata and per-context key/value entries (bounded).
 
 	  Enable on NVIDIA server platforms (e.g. DGX, HGX) that expose
 	  ACPI device NVDA2012 in their firmware tables.
diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
index e7cc912344fd..adf298dc722b 100644
--- a/drivers/acpi/apei/ghes-nvidia.c
+++ b/drivers/acpi/apei/ghes-nvidia.c
@@ -6,20 +6,54 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/align.h>
+#include <linux/limits.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 #include <linux/uuid.h>
+#include <kunit/visibility.h>
 #include <acpi/ghes.h>
 
-#include <kunit/visibility.h>
 #include "ghes-nvidia.h"
 
+#define NVIDIA_GHES_VERA_VERSION	1
+#define NVIDIA_GHES_VERA_CPU_INFO_MAJOR	0
+/* Cap section-wide entry log lines so a large dump cannot flood the console. */
+#define NVIDIA_GHES_MAX_PRINT_ENTRIES	32
+#define NVIDIA_GHES_MAX_PRINT_CONTEXTS	16
+
+static __printf(3, 4) void nvidia_ghes_decode_err(struct device *dev,
+						 bool fatal, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (!dev)
+		return;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (fatal)
+		dev_err(dev, "%pV", &vaf);
+	else
+		dev_err_ratelimited(dev, "%pV", &vaf);
+
+	va_end(args);
+}
+
 static const guid_t nvidia_grace_sec_guid =
 	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
 		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
 
+static const guid_t nvidia_vera_sec_guid =
+	GUID_INIT(0x9068e568, 0x6ca0, 0x11f0,
+		  0xae, 0xaf, 0x15, 0x93, 0x43, 0x59, 0x1e, 0xac);
+
 /* Grace CPER section wire layout (header without flexible register array). */
 struct cper_sec_nvidia {
 	char	signature[16];
@@ -35,15 +69,61 @@ struct cper_sec_nvidia {
 
 static_assert(sizeof(struct cper_sec_nvidia) == 32);
 
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
+static_assert(sizeof(struct cper_sec_nvidia_vera_event) == 32);
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
+static_assert(sizeof(struct cper_sec_nvidia_vera_cpu_info) == 32);
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
+static_assert(sizeof(struct cper_sec_nvidia_vera_context) == 16);
+
 struct nvidia_ghes_private {
 	struct notifier_block	nb;
 	struct device		*dev;
 };
 
 VISIBLE_IF_KUNIT
-int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
-			     size_t len,
-			     struct nvidia_ghes_decoded *decoded)
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
+static int __nvidia_ghes_decode_grace(struct device *dev, const void *buf,
+				      size_t len,
+				      struct nvidia_ghes_decoded *decoded,
+				      bool fatal)
 {
 	const struct cper_sec_nvidia *nvidia_err = buf;
 	size_t min_size;
@@ -52,19 +132,18 @@ int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
 	if (!buf || !decoded)
 		return -EINVAL;
 	if (len < sizeof(*nvidia_err)) {
-		if (dev)
-			dev_err_ratelimited(dev, "Section too small (%zu < %zu)\n",
-					    len, sizeof(*nvidia_err));
+		nvidia_ghes_decode_err(dev, fatal,
+				       "Section too small (%zu < %zu)\n",
+				       len, sizeof(*nvidia_err));
 		return -ENODATA;
 	}
 
 	number_regs = nvidia_err->number_regs;
 	min_size = struct_size(nvidia_err, regs, number_regs);
 	if (len < min_size) {
-		if (dev)
-			dev_err_ratelimited(dev,
-					    "Invalid number_regs %u (section size %zu, need %zu)\n",
-					    number_regs, len, min_size);
+		nvidia_ghes_decode_err(dev, fatal,
+				       "Invalid number_regs %u (section size %zu, need %zu)\n",
+				       number_regs, len, min_size);
 		return -ENODATA;
 	}
 
@@ -83,6 +162,14 @@ int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
 
 	return 0;
 }
+
+VISIBLE_IF_KUNIT
+__maybe_unused int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
+					    size_t len,
+					    struct nvidia_ghes_decoded *decoded)
+{
+	return __nvidia_ghes_decode_grace(dev, buf, len, decoded, false);
+}
 EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_grace);
 
 VISIBLE_IF_KUNIT
@@ -106,6 +193,361 @@ int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
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
+static void
+__nvidia_ghes_vera_cursor_init(const struct nvidia_ghes_decoded *decoded,
+			       struct nvidia_ghes_vera_cursor *cursor, u8 count)
+{
+	*cursor = (struct nvidia_ghes_vera_cursor) {
+		.pos = decoded->vera_contexts,
+		.remaining = decoded->vera_contexts_len,
+		.contexts_left = count,
+	};
+}
+
+VISIBLE_IF_KUNIT
+void nvidia_ghes_vera_cursor_init(const struct nvidia_ghes_decoded *decoded,
+				  struct nvidia_ghes_vera_cursor *cursor)
+{
+	if (!cursor)
+		return;
+
+	memset(cursor, 0, sizeof(*cursor));
+	if (!decoded || decoded->format != NVIDIA_GHES_FORMAT_VERA)
+		return;
+
+	__nvidia_ghes_vera_cursor_init(decoded, cursor,
+				       decoded->valid_context_count);
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_cursor_init);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_cursor_next(struct nvidia_ghes_vera_cursor *cursor,
+				 struct nvidia_ghes_vera_context *ctx)
+{
+	const struct cper_sec_nvidia_vera_context *wire;
+	size_t data_end_advance;
+	size_t advance;
+	u32 context_size;
+	u32 data_size;
+	u16 data_format_type;
+	int ret;
+
+	if (!cursor || !ctx)
+		return -EINVAL;
+	if (!cursor->contexts_left)
+		return 0;
+	if (!cursor->pos || cursor->remaining < sizeof(*wire))
+		return -ENODATA;
+
+	wire = (const void *)cursor->pos;
+	context_size = get_unaligned_le32(&wire->context_size);
+	data_format_type = get_unaligned_le16(&wire->data_format_type);
+	data_size = get_unaligned_le32(&wire->data_size);
+
+	if (context_size < sizeof(*wire) || !IS_ALIGNED(context_size, 16))
+		return -EINVAL;
+
+	ret = nvidia_ghes_vera_validate_context_data(data_format_type, data_size);
+	if (ret)
+		return ret;
+	if (check_add_overflow((size_t)data_size, sizeof(*wire),
+			       &data_end_advance))
+		return -EOVERFLOW;
+	if (data_end_advance > cursor->remaining)
+		return -ENODATA;
+
+	/*
+	 * CtxSize covers the header, data, and alignment padding. Older opaque
+	 * records used a header-only CtxSize, so advance over their data directly.
+	 */
+	if (data_format_type == 0 && context_size == sizeof(*wire)) {
+		advance = data_end_advance;
+	} else {
+		if (data_end_advance > context_size)
+			return -EINVAL;
+		if (context_size > cursor->remaining)
+			return -ENODATA;
+		advance = context_size;
+	}
+
+	*ctx = (struct nvidia_ghes_vera_context) {
+		.context_size = context_size,
+		.context_version = get_unaligned_le16(&wire->context_version),
+		.data_format_type = data_format_type,
+		.data_format_version = get_unaligned_le16(&wire->data_format_version),
+		.data_size = data_size,
+		.data = cursor->pos + sizeof(*wire),
+	};
+	cursor->pos += advance;
+	cursor->remaining -= advance;
+	cursor->contexts_left--;
+
+	return 1;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_cursor_next);
+
+static int __nvidia_ghes_decode_vera(struct device *dev, const void *buf,
+				     size_t len,
+				     struct nvidia_ghes_decoded *decoded,
+				     bool fatal)
+{
+	const struct cper_sec_nvidia_vera_event *event = buf;
+	const struct cper_sec_nvidia_vera_cpu_info *cpu_info;
+	struct nvidia_ghes_vera_cursor cursor;
+	struct nvidia_ghes_vera_context context;
+	const u8 *bytes = buf;
+	size_t offset;
+	u16 info_version;
+	int ret;
+
+	if (!buf || !decoded)
+		return -EINVAL;
+	if (len < sizeof(*event)) {
+		nvidia_ghes_decode_err(dev, fatal,
+				       "Vera event header truncated (%zu < %zu)\n",
+				       len, sizeof(*event));
+		return -ENODATA;
+	}
+	if (event->version != NVIDIA_GHES_VERA_VERSION)
+		return -EOPNOTSUPP;
+	if (event->source_device_type != 0)
+		return -EOPNOTSUPP;
+
+	offset = sizeof(*event);
+	if (len - offset < sizeof(*cpu_info)) {
+		nvidia_ghes_decode_err(dev, fatal,
+				       "Vera CPU info truncated (%zu < %zu)\n",
+				       len - offset, sizeof(*cpu_info));
+		return -ENODATA;
+	}
+
+	cpu_info = (const void *)(bytes + offset);
+	info_version = get_unaligned_le16(&cpu_info->info_version);
+	if ((info_version >> 8) != NVIDIA_GHES_VERA_CPU_INFO_MAJOR)
+		return -EOPNOTSUPP;
+	if (cpu_info->info_size < sizeof(*cpu_info)) {
+		nvidia_ghes_decode_err(dev, fatal,
+				       "Vera CPU info size %u smaller than header %zu\n",
+				       cpu_info->info_size, sizeof(*cpu_info));
+		return -EINVAL;
+	}
+	if (len - offset < cpu_info->info_size) {
+		nvidia_ghes_decode_err(dev, fatal,
+				       "Vera CPU info extends past section (%u > %zu)\n",
+				       cpu_info->info_size, len - offset);
+		return -ENODATA;
+	}
+
+	offset += cpu_info->info_size;
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
+	decoded->vera_contexts = bytes + offset;
+	decoded->vera_contexts_len = len - offset;
+	__nvidia_ghes_vera_cursor_init(decoded, &cursor,
+				       event->event_context_count);
+	while ((ret = nvidia_ghes_vera_cursor_next(&cursor, &context)) > 0)
+		decoded->valid_context_count++;
+	if (ret < 0) {
+		nvidia_ghes_decode_err(dev, fatal,
+				       "Vera context[%u] is malformed (ret=%d)\n",
+				       decoded->valid_context_count, ret);
+		return ret;
+	}
+
+	if (cursor.remaining && dev)
+		dev_dbg(dev,
+			"Vera section has %zu trailing byte(s) after %u context(s)\n",
+			cursor.remaining, decoded->valid_context_count);
+
+	return 0;
+}
+
+VISIBLE_IF_KUNIT
+__maybe_unused int nvidia_ghes_decode_vera(struct device *dev, const void *buf,
+					   size_t len,
+					   struct nvidia_ghes_decoded *decoded)
+{
+	return __nvidia_ghes_decode_vera(dev, buf, len, decoded, false);
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_vera);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_entry_count(const struct nvidia_ghes_vera_context *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+	if (ctx->data_size && !ctx->data)
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
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_u64_pair(const struct nvidia_ghes_vera_context *ctx,
+				      unsigned int index, u64 *key, u64 *val)
+{
+	int count;
+
+	if (!ctx || !key || !val || ctx->data_format_type != 1)
+		return -EINVAL;
+
+	count = nvidia_ghes_vera_context_entry_count(ctx);
+	if (count < 0)
+		return count;
+	if (index >= count)
+		return -ERANGE;
+
+	*key = get_unaligned_le64(ctx->data + index * 16);
+	*val = get_unaligned_le64(ctx->data + index * 16 + 8);
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_context_u64_pair);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_u32_pair(const struct nvidia_ghes_vera_context *ctx,
+				      unsigned int index, u32 *key, u32 *val)
+{
+	int count;
+
+	if (!ctx || !key || !val || ctx->data_format_type != 2)
+		return -EINVAL;
+
+	count = nvidia_ghes_vera_context_entry_count(ctx);
+	if (count < 0)
+		return count;
+	if (index >= count)
+		return -ERANGE;
+
+	*key = get_unaligned_le32(ctx->data + index * 8);
+	*val = get_unaligned_le32(ctx->data + index * 8 + 4);
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_context_u32_pair);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_u64_value(const struct nvidia_ghes_vera_context *ctx,
+				       unsigned int index, u64 *val)
+{
+	int count;
+
+	if (!ctx || !val || ctx->data_format_type != 3)
+		return -EINVAL;
+
+	count = nvidia_ghes_vera_context_entry_count(ctx);
+	if (count < 0)
+		return count;
+	if (index >= count)
+		return -ERANGE;
+
+	*val = get_unaligned_le64(ctx->data + index * 8);
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_context_u64_value);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_u32_value(const struct nvidia_ghes_vera_context *ctx,
+				       unsigned int index, u32 *val)
+{
+	int count;
+
+	if (!ctx || !val || ctx->data_format_type != 4)
+		return -EINVAL;
+
+	count = nvidia_ghes_vera_context_entry_count(ctx);
+	if (count < 0)
+		return count;
+	if (index >= count)
+		return -ERANGE;
+
+	*val = get_unaligned_le32(ctx->data + index * 4);
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_context_u32_value);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_print_count(const struct nvidia_ghes_vera_context *ctx,
+					 unsigned int *remaining)
+{
+	int entries;
+	int count;
+
+	if (!remaining)
+		return -EINVAL;
+
+	entries = nvidia_ghes_vera_context_entry_count(ctx);
+	if (entries < 0)
+		return entries;
+
+	count = min_t(unsigned int, entries, *remaining);
+	*remaining -= count;
+
+	return count;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_context_print_count);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_print_context_count(const struct nvidia_ghes_decoded *decoded)
+{
+	if (!decoded || decoded->format != NVIDIA_GHES_FORMAT_VERA)
+		return -EINVAL;
+
+	return min_t(unsigned int, decoded->valid_context_count,
+		     NVIDIA_GHES_MAX_PRINT_CONTEXTS);
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_print_context_count);
+
 static void nvidia_ghes_print_grace(struct device *dev,
 				    const struct nvidia_ghes_decoded *decoded,
 				    bool fatal)
@@ -113,13 +555,16 @@ static void nvidia_ghes_print_grace(struct device *dev,
 	const char *level = fatal ? KERN_ERR : KERN_INFO;
 	u64 addr, val;
 
-	dev_printk(level, dev, "signature: %s\n", decoded->signature);
+	dev_printk(level, dev, "signature: %*pE\n",
+		   (int)strnlen(decoded->signature, sizeof(decoded->signature)),
+		   decoded->signature);
 	dev_printk(level, dev, "error_type: %u\n", decoded->error_type);
 	dev_printk(level, dev, "error_instance: %u\n", decoded->error_instance);
 	dev_printk(level, dev, "severity: %u\n", decoded->severity);
 	dev_printk(level, dev, "socket: %u\n", decoded->socket);
 	dev_printk(level, dev, "number_regs: %u\n", decoded->number_regs);
-	dev_printk(level, dev, "instance_base: 0x%016llx\n", decoded->instance_base);
+	dev_printk(level, dev, "instance_base: 0x%016llx\n",
+		   decoded->instance_base);
 
 	for (int i = 0; i < decoded->number_regs; i++) {
 		if (nvidia_ghes_grace_reg_pair(decoded, i, &addr, &val))
@@ -129,12 +574,157 @@ static void nvidia_ghes_print_grace(struct device *dev,
 	}
 }
 
+static void nvidia_ghes_print_vera(struct device *dev,
+				   const struct nvidia_ghes_decoded *decoded,
+				   bool fatal, unsigned long ghes_severity)
+{
+	struct nvidia_ghes_vera_cursor cursor;
+	struct nvidia_ghes_vera_context context;
+	const char *level = fatal ? KERN_ERR : KERN_INFO;
+	unsigned int remaining = NVIDIA_GHES_MAX_PRINT_ENTRIES;
+	unsigned int print_contexts;
+
+	dev_printk(level, dev, "signature: %*pE\n",
+		   (int)strnlen(decoded->signature, sizeof(decoded->signature)),
+		   decoded->signature);
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
+	if (decoded->valid_context_count != decoded->event_context_count)
+		dev_printk(level, dev, "valid_context_count: %u\n",
+			   decoded->valid_context_count);
+
+	print_contexts = nvidia_ghes_vera_print_context_count(decoded);
+	nvidia_ghes_vera_cursor_init(decoded, &cursor);
+	for (int i = 0; i < print_contexts; i++) {
+		const struct nvidia_ghes_vera_context *ctx = &context;
+		int entries;
+		int print_n;
+
+		if (nvidia_ghes_vera_cursor_next(&cursor, &context) != 1)
+			break;
+		entries = nvidia_ghes_vera_context_entry_count(ctx);
+		dev_printk(level, dev,
+			   "context[%d]: version=%u format=%u format_version=%u context_size=%u data_size=%u\n",
+			   i, ctx->context_version, ctx->data_format_type,
+			   ctx->data_format_version, ctx->context_size, ctx->data_size);
+		if (ctx->data_format_type == 0 && ctx->data_size > 0) {
+			int prefix_len = ctx->data_size > 16 ? 16 : ctx->data_size;
+
+			dev_printk(level, dev, "context[%d]_opaque_prefix: %*phN\n",
+				   i, prefix_len, ctx->data);
+			continue;
+		}
+		if (entries < 0)
+			continue;
+
+		dev_printk(level, dev, "context[%d]_entries: %d\n", i, entries);
+		print_n = nvidia_ghes_vera_context_print_count(ctx, &remaining);
+		if (print_n < 0)
+			continue;
+		for (int j = 0; j < print_n; j++) {
+			u64 key64, val64;
+			u32 key32, val32;
+
+			switch (ctx->data_format_type) {
+			case 1:
+				if (nvidia_ghes_vera_context_u64_pair(ctx, j, &key64, &val64))
+					break;
+				dev_printk(level, dev,
+					   "context[%d]_entry[%d]: key=0x%016llx value=0x%016llx\n",
+					   i, j, key64, val64);
+				break;
+			case 2:
+				if (nvidia_ghes_vera_context_u32_pair(ctx, j, &key32, &val32))
+					break;
+				dev_printk(level, dev,
+					   "context[%d]_entry[%d]: key=0x%08x value=0x%08x\n",
+					   i, j, key32, val32);
+				break;
+			case 3:
+				if (nvidia_ghes_vera_context_u64_value(ctx, j, &val64))
+					break;
+				dev_printk(level, dev,
+					   "context[%d]_entry[%d]: value=0x%016llx\n",
+					   i, j, val64);
+				break;
+			case 4:
+				if (nvidia_ghes_vera_context_u32_value(ctx, j, &val32))
+					break;
+				dev_printk(level, dev,
+					   "context[%d]_entry[%d]: value=0x%08x\n",
+					   i, j, val32);
+				break;
+			default:
+				break;
+			}
+		}
+		if (entries > print_n)
+			dev_printk(level, dev,
+				   "context[%d]_entries_omitted: %d\n",
+				   i, entries - print_n);
+	}
+	if (decoded->valid_context_count > print_contexts)
+		dev_printk(level, dev, "contexts_omitted: %u\n",
+			   decoded->valid_context_count - print_contexts);
+}
+
+static void nvidia_ghes_log_decode_failure(struct device *dev,
+					   enum nvidia_ghes_format format,
+					   bool fatal, u32 len, int ret)
+{
+	const char *level = fatal ? KERN_ERR : KERN_INFO;
+
+	if (ret == -EOPNOTSUPP && format == NVIDIA_GHES_FORMAT_VERA) {
+		if (fatal)
+			dev_printk(level, dev,
+				   "Unsupported NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
+				   len, ret);
+		else
+			dev_info_ratelimited(dev,
+					     "Unsupported NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
+					     len, ret);
+		return;
+	}
+
+	if (format == NVIDIA_GHES_FORMAT_GRACE) {
+		if (fatal)
+			dev_printk(level, dev,
+				   "Malformed NVIDIA Grace CPER section, error_data_length: %u, ret: %d\n",
+				   len, ret);
+		else
+			dev_err_ratelimited(dev,
+					    "Malformed NVIDIA Grace CPER section, error_data_length: %u, ret: %d\n",
+					    len, ret);
+		return;
+	}
+
+	if (fatal)
+		dev_printk(level, dev,
+			   "Malformed NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
+			   len, ret);
+	else
+		dev_err_ratelimited(dev,
+				    "Malformed NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
+				    len, ret);
+}
+
 static int nvidia_ghes_notify(struct notifier_block *nb,
 			      unsigned long event, void *data)
 {
 	struct acpi_hest_generic_data *gdata = data;
 	struct nvidia_ghes_decoded decoded = {};
 	struct nvidia_ghes_private *priv;
+	enum nvidia_ghes_format format;
 	const void *payload;
 	guid_t sec_guid;
 	u32 len;
@@ -142,25 +732,58 @@ static int nvidia_ghes_notify(struct notifier_block *nb,
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
 
-	ret = nvidia_ghes_decode_grace(priv->dev, payload, len, &decoded);
+	switch (format) {
+	case NVIDIA_GHES_FORMAT_GRACE:
+		ret = __nvidia_ghes_decode_grace(priv->dev, payload, len,
+						 &decoded, fatal);
+		break;
+	case NVIDIA_GHES_FORMAT_VERA:
+		ret = __nvidia_ghes_decode_vera(priv->dev, payload, len,
+						&decoded, fatal);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
 	if (ret) {
-		dev_err_ratelimited(priv->dev,
-				    "Malformed NVIDIA CPER section, error_data_length: %u, ret: %d\n",
-				    len, ret);
+		nvidia_ghes_log_decode_failure(priv->dev, format, fatal, len, ret);
+		/*
+		 * Print any contexts successfully decoded before the failure.
+		 * Raw section bytes remain available via log_non_standard_event().
+		 */
+		if (format == NVIDIA_GHES_FORMAT_VERA &&
+		    decoded.format == NVIDIA_GHES_FORMAT_VERA &&
+		    decoded.valid_context_count > 0) {
+			dev_printk(fatal ? KERN_ERR : KERN_INFO, priv->dev,
+				   "NVIDIA Vera CPER section (partial), error_data_length: %u\n",
+				   len);
+			nvidia_ghes_print_vera(priv->dev, &decoded, fatal, event);
+		}
 		return NOTIFY_OK;
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
+		nvidia_ghes_print_vera(priv->dev, &decoded, fatal, event);
+	else
+		nvidia_ghes_print_grace(priv->dev, &decoded, fatal);
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/acpi/apei/ghes-nvidia.h b/drivers/acpi/apei/ghes-nvidia.h
index 965abe3d5c49..b5f0312499fc 100644
--- a/drivers/acpi/apei/ghes-nvidia.h
+++ b/drivers/acpi/apei/ghes-nvidia.h
@@ -4,13 +4,13 @@
 
 #include <linux/build_bug.h>
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
 
 struct nvidia_ghes_grace_reg {
@@ -18,18 +18,52 @@ struct nvidia_ghes_grace_reg {
 	__le64 val;
 } __packed;
 
+struct nvidia_ghes_vera_context {
+	u32 context_size;
+	u16 context_version;
+	u16 data_format_type;
+	u16 data_format_version;
+	u32 data_size;
+	const u8 *data;
+};
+
+struct nvidia_ghes_vera_cursor {
+	const u8 *pos;
+	size_t remaining;
+	u8 contexts_left;
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
+	u8 valid_context_count;
+	u32 architecture;
+	u64 event_link_id;
 	u64 instance_base;
+	u8 chip_serial_number[16];
 	const struct nvidia_ghes_grace_reg *grace_regs;
+	const u8 *vera_contexts;
+	size_t vera_contexts_len;
 };
 
+/* Bound the notifier stack frame. */
+static_assert(sizeof(struct nvidia_ghes_decoded) <= 128);
+
+struct device;
+
+VISIBLE_IF_KUNIT enum nvidia_ghes_format nvidia_ghes_format_from_guid(const guid_t *guid);
+VISIBLE_IF_KUNIT int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
+					      size_t len,
+					      struct nvidia_ghes_decoded *decoded);
 /**
  * nvidia_ghes_grace_reg_pair() - Read one Grace register address/value pair
  * @decoded: Decoded Grace section; format must be NVIDIA_GHES_FORMAT_GRACE
@@ -41,10 +75,35 @@ struct nvidia_ghes_decoded {
  * Returns -EINVAL for bad arguments / missing grace_regs, -ERANGE for
  * index >= number_regs, and 0 on success.
  */
-VISIBLE_IF_KUNIT int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
-					      size_t len,
-					      struct nvidia_ghes_decoded *decoded);
 VISIBLE_IF_KUNIT int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
 						unsigned int index, u64 *addr, u64 *val);
+VISIBLE_IF_KUNIT int nvidia_ghes_decode_vera(struct device *dev, const void *buf,
+					     size_t len,
+					     struct nvidia_ghes_decoded *decoded);
+VISIBLE_IF_KUNIT
+void nvidia_ghes_vera_cursor_init(const struct nvidia_ghes_decoded *decoded,
+				  struct nvidia_ghes_vera_cursor *cursor);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_cursor_next(struct nvidia_ghes_vera_cursor *cursor,
+				 struct nvidia_ghes_vera_context *ctx);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_print_context_count(const struct nvidia_ghes_decoded *decoded);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_entry_count(const struct nvidia_ghes_vera_context *ctx);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_u64_pair(const struct nvidia_ghes_vera_context *ctx,
+				      unsigned int index, u64 *key, u64 *val);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_u32_pair(const struct nvidia_ghes_vera_context *ctx,
+				      unsigned int index, u32 *key, u32 *val);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_u64_value(const struct nvidia_ghes_vera_context *ctx,
+				       unsigned int index, u64 *val);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_u32_value(const struct nvidia_ghes_vera_context *ctx,
+				       unsigned int index, u32 *val);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_print_count(const struct nvidia_ghes_vera_context *ctx,
+					 unsigned int *remaining);
 
 #endif
-- 
2.50.1 (Apple Git-155)

