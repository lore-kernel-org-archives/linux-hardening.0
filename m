Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AE366806;
	Tue,  4 Aug 2026 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846216; cv=fail; b=g1Bsf185wQF5Spq+RptE5r5A65td25d2vje40ornJmZwBG9mWLpPlEJvTmgPcmAAdloa3ceMPLOQW3WACk7+5pEbQU5l8A8Zgs0mRHyCnQNIk/zTBdIFS3vLo6Yz8Ijz/kmHUfHY12PZwMZ73eDVExUt00QxIEsuDXK2E4oNwYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846216; c=relaxed/simple;
	bh=U8fZDixyviD51hP10KzfLKm5xgbj9oaJ1cUC2txPejs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UydP7PfzXDKeYb/o5J++pn9awO1lr1MalRPHc8glxoNqh6+rJP45OJpFFyIgUEMN2SjxtPV0A8CpD7uwDNj1dE8FxGn1dKaRf1y07WVezQQRv4z8oilV/s9kJU6HIs3Kz7RkPHM3MKpPby1IJ5eogjqAeBxbfET/iXQWXjj51Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ujElkACz; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ujElkACz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4HpoHIQ3YvQl9y7qu1hR133oqJ9+Xu9LLVcAfoE9Mb3osFtP3MOgEGAfiETpxNzDQ6LQQ2JfNRuKcij473oweG+39cgBRIJ3uA7A4oKRuPYjGGTK4Loe5vE6TPqJG2utp0CMkakTIpCLuuJPV5MRsq3ZtaY+gg2aRUKznElu/JugKfL25nTlSP69+02Uv7gnZwLuLuuu9OjWQDBIU2iZVlpDvtd2meJ1fhzuRt/Y1U14X6rSNb91S6YCr3s1aSUIrzdLETyb1opqXyVERh0cQkms28vqSgZtPsl4a4T1eSf6jPxZQa94HC1z7vEZqiB6CZ8pS27wU2ca92Xbzjrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nyICTtL93RkV9M4OoT41qytmNBEHBpTB3u8ONnCSWg=;
 b=GwxJRKoRG8JZv2+u9Hf7JzXlkfaBL/nkAVqCMjLVbqTPW2PBGo0qp37iGeSy9iUzCHg1u4qyizs/7NLMzSFNobyrPMwQqrUdkIkbqZIb9GTNbbXHJABFDMzp2I5T4ThoLqNi/zQECJbCeRNKDY6Wvk8cvycE5e5V7xnoGfRDkrbDmc4qdVyW18pGJheySunmc/p2zIunhdAb4i5gPfwXYwCw+NY8clnLvjoSn9lyPWyuXr97C2xRa+jrpagqO7eOxHI8EQDKkv4WiMWp80HBWicgw8GL200mT/iD1zF9LIIOKDudHd2lRe5G7a+uSjQRbk1Ps/TP/t4syZADXmW5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nyICTtL93RkV9M4OoT41qytmNBEHBpTB3u8ONnCSWg=;
 b=ujElkACzheSTo2JHbwYtl4Ldc9YvGU5mu0kRKjFKObLp8JAopIClfXefjJ9aT6SN4peVu2Zj6JeEPZyEecUBCY70nMHA8NjYsbA8keeuH/7QKFfAFbzUet00EEXWcHehn1dDfjE+Ay6w9dGc97yb8HbZZ5AZaWAnMo1T7wRqFQ6sR0yLs3zSrAKJfiNwD8G0qXLA7yZKQJ5MOvvlxzRN66vFIUsQmNMxmh1UabV/oz80o/IHN5Q0NtGb73akLjMkTw+5AqgoBarSaRVZcTta+XEjv6sdMKQ4Wp8Jbnv3i1/7DRJxskMWmLa4Po38C5/qNJeDg0YD+DCidi2EtCawSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by CHAPR12MB999224.namprd12.prod.outlook.com (2603:10b6:610:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 12:23:29 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 12:23:29 +0000
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
Subject: [PATCH v3 1/3] ACPI: APEI: GHES: Refactor Grace decoder helpers
Date: Tue,  4 Aug 2026 20:23:15 +0800
Message-ID: <20260804122318.88193-2-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804122318.88193-1-kaihengf@nvidia.com>
References: <20260724122054.36162-1-kaihengf@nvidia.com>
 <20260804122318.88193-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|CHAPR12MB999224:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7a17a5-6bdd-47aa-6d4d-08def22330aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	5VubVUaV6zmQAGd5R3CwxSh1FW4EDnnLv0CS9YiOk/066Kpn78dUFpNZiIfFQRnPGs0MGQDEDbq5WMArl0w0Q8MHTJUaiKGhmwRMIvkfehbL7YI808HnmPHxKdYM9MrlkDSUOZUNAP4yo80jp9gT5VOQQGx2tMku42buz5lTzQR+YWtsjkEDEnhkSHMbxioVbKMaMFeS+rH1KVJ4xwgPScqmVqYCOfPAO8lpna9ILAsZGK+4Mz/kY9EZSiqUeo3W9Ym/QcGqsYvaZm2GZQfbnR6ETx1tw61kM/RdG+51FVDzjkF6xA3WsE8f/HQ240tM6K514jdkac+J/p5466wSBN5iVmXx+vsg1wcSdFt+zxM1WEtRxHKu2zemyA9O8c2kW5Pg7/boEt5j9B0+zA9PE8D0nwoK67mPRfLtJ/cmjo/BLuOBZiZCW6BlTTnSVOMJnimlHrjGESa8XThorm8jwDAJgL3tBFlh6i/bdna2wB205/3JVOXVvUq9Y0r0TyUVF0uR3g2JRZru6hO/NBGfHJHBEDKWTHTJmdAtOm6TiUReZIh7dfl5GWiDn16yxMHHXt1CeP4xtSC6FdQjMMn1g/2ZeUD3doLq80GQefZPBDBghd7fDwMJT6EaOKKJlWRzv0q60Wip78Y2ccTM951tIFGqS8FCdHjIje51zpc0Lfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hanOIb9BcxsEtFCGXppuBV+D+ZBHqW4axxWIVOBEPY9GXYRD54ST5HYf9IEy?=
 =?us-ascii?Q?QG70vrbommXwAdzxFzC/kL/Dbja4gdzcyrzBVjY3lCdcVitfA8IOxmeL4Amj?=
 =?us-ascii?Q?Qx6A+L2lq6adjTPju64NXgY9hYZduBSe5hpCTSp75bDx8UfTTXBIYTUBmAUF?=
 =?us-ascii?Q?9bXZ4btZnGaRUG9prUZGfBhrdoHemtNTYo7+2/BBv9TGjnSFH52KoD0NbWoT?=
 =?us-ascii?Q?TWrQlb32BGHbD2B+fIzrh1cwy3tpjKlS3wVVFwBGaYhL8hx15j3NagSLbT01?=
 =?us-ascii?Q?vDmbkgh6/1r9MKdwv50Qn9EzRlk978VU0CSGG8rAiqUpHlyc9F2kDMY89BAk?=
 =?us-ascii?Q?0C2ZMbNVq9EzDNxDIIIPqQo/7G790vdqcyMmsq60gvrX91DH+lRR7hF5d3g8?=
 =?us-ascii?Q?z003SkVHB7tp3wi6mpA8PQK85eNc5qvEDiII6j+6fK3+yVEt1vKKi2EUVTDV?=
 =?us-ascii?Q?Ep58tVKfH7hdR37rVWrXjIFgyjnvHIeachj7/MTZ6c/owrpOmcY7CZsV2CvO?=
 =?us-ascii?Q?nOCfORnUh/u5uNXou0hfp/jyLwCPd174ZnozBUedXccaR51TmapgMf8Tcmu3?=
 =?us-ascii?Q?D4X67QbHfMmr1EjRx8mZ4wUUUaYY0q7PYZ58bW76q7cqcmfn+KkXpU9elhyj?=
 =?us-ascii?Q?ZARqVjuzgLTBe02oGa9ivS7xokSqAxjIy9YHVJwtp/4jlyWpqwNbd2CrVBmQ?=
 =?us-ascii?Q?UdZioRpTq/L+Z1H6wuHYh8BtiA9baqUi0q0PV8s8o8g7O89C1VVJAwUns0Y3?=
 =?us-ascii?Q?zlxEJnqGEw6P5UVKr4HBNlJ8Rj8hVIGLPO8rmhF1hR/+PPhBnkXy/qc8SvQy?=
 =?us-ascii?Q?4vnZ+UevzPqHPFxy0fgObeRJWuyy5KTONu5m/e/G1KjNNCJ8HR0SIjb01CRa?=
 =?us-ascii?Q?/Wx4nacTt09vUs3s22bkKRY9am9Lv1VF5qG39y3v1cITJxrsF7xv+XonWXWm?=
 =?us-ascii?Q?2Jh0xQuy1pDmZykf8Tv7DHokMbSkLCGQTi2pmY756zzDoB9vhNvkEQpZHMEo?=
 =?us-ascii?Q?KpsK7UB+zix9HdES1SxNpI+d97PfoHWezQ5IPHYXTVxGdEchvv16PPfx76XJ?=
 =?us-ascii?Q?/6sSB4c9ZjiWMcr2RLVNpDz0uAsh78QVtwZ74ybwauVvabJpGCsIecCgqhO/?=
 =?us-ascii?Q?8EDDJ0qzdAxIo5IcU3shMSjwDL2UnoNS9QyjnvBMc3cTKj5nxTMZdxvCgVmx?=
 =?us-ascii?Q?McI34XyOsN7FTKrSXKUd7DfRCLzn+3f/TlPirFSUm+PsFTvk0xyTOUgUxfQL?=
 =?us-ascii?Q?TVOZ0FfHcsD8MHWlc+acciofudlGwsHDljcs6ermUNK1qGuBWeNVrDM/MHFG?=
 =?us-ascii?Q?WmhW39UTNc+lUAl9edX3w/OBUyZt/o9B29++RrXlA156GAbR6p7MaOhjc91z?=
 =?us-ascii?Q?ksFfeNJg+eyep7UOKN7L7NlfrhB1D2BhUMH722D0lLabajPSg9ZTeQ5Vh84I?=
 =?us-ascii?Q?Nb8zNolKuFevgIlJ2d5K2ymBqP4aKxq7OUCv1/kuLdmhLff5VQLEL/+lTXh3?=
 =?us-ascii?Q?sYk4kqq2XJ8vUHyfOoIzrcsQ3Sa64S+9hnkx1tV4gxkObIywbxTMOERMUeMm?=
 =?us-ascii?Q?5XpBYj7gWJbfHakrCC2ITkN1BFMedPw5UN1bYY+xnaPolNGOSpxD1TgiG/9u?=
 =?us-ascii?Q?IVjKKAldSwoNO54cMOZQSMSCvmq9s0Nrdkp2Kf8j4QGCtMRfA3z8qtuDyHxJ?=
 =?us-ascii?Q?88dQYwvOvmJgG3zJWxiykjP4kwkvImP50UXhKzLyuHj3wyAtorKdsWPqzv4I?=
 =?us-ascii?Q?rxrTF30e/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7a17a5-6bdd-47aa-6d4d-08def22330aa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:23:28.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KplJAjAZHZ4Wv4a6ZFKssVjZEb98S48I2oYNmLK3X5HuzK81bZcrFTlft7zTqKiaV4sY0FW5auqIYFIQjlHFrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999224

Split the Grace CPER processing into a separate decode step and a
print step so the parser can be exercised by KUnit without a live
ACPI device. Introduce ghes-nvidia.h to hold shared types that the
Vera decoder added in the next commit will also reference.

Parse the Grace wire payload with __packed structs and
get_unaligned_le*() for multi-byte fields, matching the Vera
decoder style. Reject nvidia_ghes_grace_reg_pair() calls with a
non-zero register count and a NULL grace_regs pointer, and
rate-limit Grace decoder diagnostics.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v3:
 - Use __packed + get_unaligned_le*() for Grace multi-byte fields,
   including register pairs (Shuai Xue).
 - Keep __counted_by / struct_size; reject NULL grace_regs when
   number_regs != 0; document the helper contract.
 - Rate-limit Grace decoder and notify error messages.
v2:
 - No change.
---
 MAINTAINERS                     |   2 +-
 drivers/acpi/apei/ghes-nvidia.c | 160 ++++++++++++++++++++++----------
 drivers/acpi/apei/ghes-nvidia.h |  50 ++++++++++
 3 files changed, 160 insertions(+), 52 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes-nvidia.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7307..aa9c2ae58ac5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19348,7 +19348,7 @@ NVIDIA GHES VENDOR CPER RECORD HANDLER
 M:	Kai-Heng Feng <kaihengf@nvidia.com>
 L:	linux-acpi@vger.kernel.org
 S:	Maintained
-F:	drivers/acpi/apei/ghes-nvidia.c
+F:	drivers/acpi/apei/ghes-nvidia*
 
 NVIDIA VRS RTC DRIVER
 M:	Shubhi Garg <shgarg@nvidia.com>
diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
index 597275d81de8..e7cc912344fd 100644
--- a/drivers/acpi/apei/ghes-nvidia.c
+++ b/drivers/acpi/apei/ghes-nvidia.c
@@ -9,13 +9,18 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/uuid.h>
 #include <acpi/ghes.h>
 
-static const guid_t nvidia_sec_guid =
+#include <kunit/visibility.h>
+#include "ghes-nvidia.h"
+
+static const guid_t nvidia_grace_sec_guid =
 	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
 		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
 
+/* Grace CPER section wire layout (header without flexible register array). */
 struct cper_sec_nvidia {
 	char	signature[16];
 	__le16	error_type;
@@ -25,84 +30,137 @@ struct cper_sec_nvidia {
 	u8	number_regs;
 	u8	reserved;
 	__le64	instance_base;
-	struct {
-		__le64	addr;
-		__le64	val;
-	} regs[] __counted_by(number_regs);
-};
+	struct nvidia_ghes_grace_reg regs[] __counted_by(number_regs);
+} __packed;
+
+static_assert(sizeof(struct cper_sec_nvidia) == 32);
 
 struct nvidia_ghes_private {
 	struct notifier_block	nb;
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
+	u8 number_regs;
+
+	if (!buf || !decoded)
+		return -EINVAL;
+	if (len < sizeof(*nvidia_err)) {
+		if (dev)
+			dev_err_ratelimited(dev, "Section too small (%zu < %zu)\n",
+					    len, sizeof(*nvidia_err));
+		return -ENODATA;
+	}
 
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
-	min_size = struct_size(nvidia_err, regs, nvidia_err->number_regs);
-	if (error_data_length < min_size) {
-		dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
-			nvidia_err->number_regs, error_data_length, min_size);
-		return;
+	number_regs = nvidia_err->number_regs;
+	min_size = struct_size(nvidia_err, regs, number_regs);
+	if (len < min_size) {
+		if (dev)
+			dev_err_ratelimited(dev,
+					    "Invalid number_regs %u (section size %zu, need %zu)\n",
+					    number_regs, len, min_size);
+		return -ENODATA;
 	}
 
-	for (int i = 0; i < nvidia_err->number_regs; i++)
+	memset(decoded, 0, sizeof(*decoded));
+	decoded->format = NVIDIA_GHES_FORMAT_GRACE;
+	memcpy(decoded->signature, nvidia_err->signature, sizeof(nvidia_err->signature));
+	decoded->signature[sizeof(nvidia_err->signature)] = '\0';
+	decoded->error_type = get_unaligned_le16(&nvidia_err->error_type);
+	decoded->error_instance = get_unaligned_le16(&nvidia_err->error_instance);
+	decoded->severity = nvidia_err->severity;
+	decoded->socket = nvidia_err->socket;
+	decoded->number_regs = number_regs;
+	decoded->instance_base = get_unaligned_le64(&nvidia_err->instance_base);
+	if (number_regs)
+		decoded->grace_regs = nvidia_err->regs;
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_grace);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
+			       unsigned int index, u64 *addr, u64 *val)
+{
+	const struct nvidia_ghes_grace_reg *regs;
+
+	if (!decoded || decoded->format != NVIDIA_GHES_FORMAT_GRACE || !addr || !val)
+		return -EINVAL;
+	if (decoded->number_regs && !decoded->grace_regs)
+		return -EINVAL;
+	if (index >= decoded->number_regs)
+		return -ERANGE;
+
+	regs = decoded->grace_regs;
+	*addr = get_unaligned_le64(&regs[index].addr);
+	*val = get_unaligned_le64(&regs[index].val);
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
+	struct nvidia_ghes_decoded decoded = {};
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
+		dev_err_ratelimited(priv->dev,
+				    "Malformed NVIDIA CPER section, error_data_length: %u, ret: %d\n",
+				    len, ret);
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
index 000000000000..965abe3d5c49
--- /dev/null
+++ b/drivers/acpi/apei/ghes-nvidia.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef GHES_NVIDIA_H
+#define GHES_NVIDIA_H
+
+#include <linux/build_bug.h>
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
+} __packed;
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
+/**
+ * nvidia_ghes_grace_reg_pair() - Read one Grace register address/value pair
+ * @decoded: Decoded Grace section; format must be NVIDIA_GHES_FORMAT_GRACE
+ * @index: Register index in [0, number_regs)
+ * @addr: Output register address
+ * @val: Output register value
+ *
+ * When number_regs is non-zero, decoded->grace_regs must be non-NULL.
+ * Returns -EINVAL for bad arguments / missing grace_regs, -ERANGE for
+ * index >= number_regs, and 0 on success.
+ */
+VISIBLE_IF_KUNIT int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
+					      size_t len,
+					      struct nvidia_ghes_decoded *decoded);
+VISIBLE_IF_KUNIT int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
+						unsigned int index, u64 *addr, u64 *val);
+
+#endif
-- 
2.50.1 (Apple Git-155)

