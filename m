Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D83C5546;
	Tue, 16 Jun 2026 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581492; cv=fail; b=qiCua/bROr7AX8ylWuyBYCJj17nyP4HMYYTRY3tjjsZHsMgHbJf9KQzMu5fP/5sHtEO5QI/gG4IzQZLnCbF90znh6Hg9G32AqXpT047VF1793RJMfCn5j1QGze6WKVYfoarZHd91CXI/SEDIUU2qPx6OcrLK7UVvx3Au9fSaJ5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581492; c=relaxed/simple;
	bh=1dE0WyaoxV/thZhmub+CkdPWDQkQVk6WOQwZO1xLOao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sfTHiWS08KFdk711oUPq2+yA8xs7EA+8GZq/z75gUhlvJCgqbLH8GXqHJKok+717zVDDX6MlbAnJYE8s8lWks+etF2BFxKLrS3mzGfyan/6eu30RMQTL2910EYNWw2rP4HNJTWflPMzTs1GS+M8vxR2vFGjHdsYW5PuXEA1KYfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FoyyED/8; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FoyyED/8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hbud/SSlLkDpcNx+jwvCgWz7uN6BL824v7s8SFiS+jTpjCQSFfGQ2Ddpd1TaQHfSvCezxsHE9x5fQRxMSNMXq3xKBaZeyzmuBdbxwcOR7Gq7afLv/xKWtC2h7HYwfvj7xmehdRvlhMgOVVbfwwTTScXM3UAHM1yWEFyuqQtlqpBSuqbBb8BLqSZeqDW+4aNFeMr5uRbxF9394Mg3KEsS6EUoPM8Cz+4YjuFPRN6bWa5yO8nximEftRYt4TMltvwrEzvXKw4dIoIZDTlq/eLItv+73Yemdeo9TQjJsADwmOkvfIYq7Vnwv9bj2XK8fvBik4EsQxvyIdYbDLzjhZvyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9FuS6qNMJYzp3roTJTAGfubJsOLWiXZczcDQsUgi0Y=;
 b=TfUsILw2lZ9NnJLFIwV2HPk4c2Bj4dZ6vozsDwhde9yVUcaolUiHCmf82nXFozPQ7A/u2PgtsniabXgY8thtnr7sP/4CptU4/0w9E6cAo2GjH/ZsBiw61bWeZgmV3k4fhgAnSZUwG+HGdd8LgDoDdcEoEybuDPCDK4Js/QYAofbVoCuVcl6va7ntQCpg1f0HKAu7D6RFPS9T+GRzUoDeg3muhOG4ldKiZIDbvUmK7ZINz2NM7WgM+ICsduNQ6BM2pD7BL2G7OPqiFr2n3I6J/EzNTXsHVZnBrOM4iw25dZBpcVEvP1Xy2GCilC7EnU91PUZZg3EJ611qe0sI7GW0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9FuS6qNMJYzp3roTJTAGfubJsOLWiXZczcDQsUgi0Y=;
 b=FoyyED/8dEjfBDcLWmVJm9gorrT+tBzLVXp82Fd5k7tEhsfQmGdfGjiDJdfU4zZMxFNy5+dLFKkgr66fWhYS5rLH6JuEWIM8tJoldj6SApbUpyYDRl+9IybdzNxcFr9W819vtjBgWewtaA2nf/f8HW33ccQsIe/8zNy4FoKjFMAPs6c/+Am6wk85HVa8qnWJZ9G09vRRh7QAugmH7G7xPDOmsE7LaqYlI+uGEeFmXLpa9TgSl4UijCGNrLW6I3+3a4y3OVmRvfwMgIbkeDmBHIg9DMYyhZA+oCWq7kmaocOLYX9wqC+Z30IfcXjgAGD51AY521nsXcbWcLCDpccuRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 03:44:38 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 03:44:38 +0000
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
Subject: [PATCH v2 3/4] ACPI: APEI: GHES: Add Grace and Vera KUnit coverage
Date: Tue, 16 Jun 2026 11:44:09 +0800
Message-ID: <20260616034410.70675-4-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616034410.70675-1-kaihengf@nvidia.com>
References: <20260616034410.70675-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2f1028-a620-46fe-9529-08decb59975d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	d8I4IiI9TSH7a+y3ct92G5M6+oNMZFHRH0ykRq2v5SMJyF+N8jjMfnTiYmsmjswnu2Y2fEQKF9l4r9pwNKXSsSLTrMsOZ8A0/U37/8lYrRq3Lm+V38aOEvv07Kk0MLbEDmEcR/iyfWUSJlyjVhA86U8wjq52GK0x73o21cRhfu7CBZqoCSJ7+Kb/8ylaHAbHWkQF+gijDKH5j5MqEmzhXhAvvwbOljJaAXm5iQjKb8WNyBWV6x6DTkBplz51RG2c1nRNGxoOjoZDDXWeJe9oJNoOkiDw/tXR1dAMM5OLmbiJXWGxN9D0wx2kXdiBfSTK7dzdgeL5gOpTiDDPIw7ebbffIII2AuBD3N/EovmAbKMXzJVFFZnXyxjt+TaQAlQ3EhsJU1+mLNTQ9TQFMwV0hqdl64yfg2uy3sWOELV96A5YUlveuX9YsMVs5fxOsSOVD3n9k6GibKAG223+156kyTa8O/JFZ7gkL7i33URlEYsTzyt7CMv87MRZCilsX2Htuo1Vedl5cTqBS2Aze+y5hP/24JF8QCC3ydbcyw0xDriUYlbuUtibac3efmfjW4HYJMzisVa3J3rnP22ysU5fadNpjROUJnhteIxA2o64PwNxd7rcPcMwiGO29B6+P8vgTJbzv93RFx91awrw5Y9NcmFQ8tIG4/biDZj68s8yETHEUHVhDvvGXJZZ1jfFjFh4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GG7OXQQBwv/6J7Wvso6tbsXPYj5xyO61v1q4zgOVdH3Qas5g9zsVt+TgtoWv?=
 =?us-ascii?Q?W2cykkFF4bWGTgcsDb0lYMJPiWuGSutsQtkbpFhQ66ZsTy2ltHrrJWTMndEn?=
 =?us-ascii?Q?ZJ/ufWqcOiEFE9Xodv20yOC8U/mbfTMo5Hyb4rVDQNktMx9FYc5C9cI7z1q0?=
 =?us-ascii?Q?b8v6u5KqR2toQ88Ir8OXchesBO8/eSoAsW+O2bS6cBQXijI8abGD13B5irmO?=
 =?us-ascii?Q?xp6TxEicjD7e9RZ5PyB5iWced5zqyf6y1IDsdmF1nTpaBQ+Gc0N+kiIJYSWL?=
 =?us-ascii?Q?+G1RRmy648x3+ExdSEASDAI7+YnpF/QagetLyY4l+BJlLu7eEYeuurzY4qhd?=
 =?us-ascii?Q?Q4cBx1DDn9pzWtnz67sEf+m/gP7sRGaIjYqIizbyEYlx7Ba6pekam0dy1vF+?=
 =?us-ascii?Q?4kOlR7B6sXDT/xOHJXVxWcpqEHGwRBjbtlJV1wwwSivLgIfF3BZAruy4/or5?=
 =?us-ascii?Q?4UwTV+Wk2w8rDLxPbnkpXBj7Bh7OF9GgVQpqGnkcsKlc4dcV87AQdNzzHzVE?=
 =?us-ascii?Q?q0PpOq/3p66JgXRBwp4DueCA86+3ION+LKsLjzqbglePYDEtgzXM5yK7YTSc?=
 =?us-ascii?Q?dVOoku5N76pT2IWJPSIzZU8fzqv0Ig259+NJm5/n6wBaTYpx1u9L+GdGqc3+?=
 =?us-ascii?Q?2qgacWnAkSxICuT9+bTd3zJM/6KAC+BaV7Ji887CNze2JerJdBzL3nYU72kt?=
 =?us-ascii?Q?Ssm2DlLQDFL/40hDMsZCScU0sZUCDO0vq46kkeZwAEaNkoLFpclBVo/Sk/GP?=
 =?us-ascii?Q?ImWsjSUcK0eSAsWB0YzTjpB7obB2N4nQgvlAZ3x7ImUnyzNjm+yMfDxxWQve?=
 =?us-ascii?Q?+2JpZnk+LXu2RBSzo+9Rmt4qPnTIaVFC2iNI0N4QWUo0AHQtreU2WEH3+aHM?=
 =?us-ascii?Q?Vb+bUGyUTKZ3qYrPgrkU8q5DnBiKv9BigWUdH5owyW4wdeeqKHmjeu4I7iIz?=
 =?us-ascii?Q?sdJNJmnby4zSfEWIC9YLRZfBIatgnQYkLBXcgmYTuGEZLjGdPABY9Vb710Hr?=
 =?us-ascii?Q?hsOUXYvmyjAnFrHi6PTZ27a6UA4sOjppYSbf1qPebSPewyauj7OGwP9zxnz9?=
 =?us-ascii?Q?O7B38QaAWD4XjmoG1KWsvo5fHP2EX5NfUEtBhkwLSevDdC2eQ+JnfX5DWLXH?=
 =?us-ascii?Q?dmA5j1Po9dMErZs7v6oeFhBNui19BNa0cxiIcVFlORBPpmyOo25ygaBmE/7F?=
 =?us-ascii?Q?+1tnaJN2f/QlNSKbgxoCmY2BN7raRyqt42VbH6yZ/oc8+yADZeJtdHoZ4pEo?=
 =?us-ascii?Q?r3oKXTNiONv4wqQZp8VDZhdj7v7gmPdM2slrR0IrBXRfu9Eh4+vIv3gprOe8?=
 =?us-ascii?Q?6j8za+qZ+76A+/dtg0gXJdbqfOyfKeqKYOw4iSBH6G5Z2uujdGh6BnQY6nYv?=
 =?us-ascii?Q?zz67RTfR5eT7EM2Ta2u2bDQcASdGgrgd/8hxBRxc+joO2BefmUWdoFnAPJaX?=
 =?us-ascii?Q?x2hz/ov1d52MT8YJTmFYBRgJm/1r/n5Ww35nzxsFGAKElf7RWjF/RvXsabDg?=
 =?us-ascii?Q?MQEgTmcSKRTa+t3bHPoqNXsSPfiDZ+zEo6jcSwu/MiWdBAy8YQQlNL+OHq+X?=
 =?us-ascii?Q?HTjP6QSxyJh5obnSeBR58qlnkeG1a1lZEuU4/U29oGVFeNsIdmaKchHtQVrd?=
 =?us-ascii?Q?0+ZdElNd6vt+mKW8vz9fvOchiW11VpU5ZRyU6OyqXSbQuvhsPWsQ8f9LP2l4?=
 =?us-ascii?Q?ow1vJzyxv+Q6V7De+cCs6TqEWXVi6UN9Mxe+cq1qrfVbElBsRXhngTGE+bpx?=
 =?us-ascii?Q?uGX/2IO3iA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2f1028-a620-46fe-9529-08decb59975d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 03:44:38.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZI4q/ZM6yY0ygG3ST1f/HEnvboEdqs4/NOVkFjpoCqzpO+AIc8s3Qt6vHe1adhX/AFbrf16FTIKt2fAR7y10Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063

Verify the Grace and Vera decoders against real binary records
captured from firmware before deploying to production hardware.
Tests cover both the happy path and the rejection of malformed
inputs across all constraint categories.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v2:
 - Add !KUNIT_ALL_TESTS for tristate.

 drivers/acpi/apei/Kconfig                     |  17 +-
 drivers/acpi/apei/Makefile                    |   1 +
 drivers/acpi/apei/ghes-nvidia-test-fixtures.h | 233 ++++++
 drivers/acpi/apei/ghes-nvidia-test.c          | 704 ++++++++++++++++++
 4 files changed, 953 insertions(+), 2 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test-fixtures.h
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test.c

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 428458c623f0..22d88425f36c 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -80,14 +80,27 @@ config ACPI_APEI_GHES_NVIDIA
 	help
 	  Support for decoding NVIDIA-specific CPER sections delivered via
 	  the APEI GHES vendor record notifier chain. Registers a handler
-	  for the NVIDIA section GUID and logs error signatures, severity,
-	  socket, and diagnostic register address-value pairs.
+	  for the NVIDIA Grace and Vera section GUIDs and logs the decoded
+	  NVIDIA error records.
 
 	  Enable on NVIDIA server platforms (e.g. DGX, HGX) that expose
 	  ACPI device NVDA2012 in their firmware tables.
 
 	  If unsure, say N.
 
+config ACPI_APEI_GHES_NVIDIA_KUNIT_TEST
+	tristate "NVIDIA GHES vendor record handler KUnit tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT && ACPI_APEI_GHES_NVIDIA
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for NVIDIA GHES vendor CPER parser helpers.
+	  They cover Grace helper decoding, Vera payload parsing, and
+	  section routing.
+	  They are enabled only for KUnit test builds.
+	  They are not intended for production firmware paths.
+
+	  If unsure, say N.
+
 config ACPI_APEI_ERST_DEBUG
 	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
 	depends on ACPI_APEI
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 66588d6be56f..210a57242044 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -11,5 +11,6 @@ einj-y				:= einj-core.o
 einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
 obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
 obj-$(CONFIG_ACPI_APEI_GHES_NVIDIA) += ghes-nvidia.o
+obj-$(CONFIG_ACPI_APEI_GHES_NVIDIA_KUNIT_TEST) += ghes-nvidia-test.o
 
 apei-y := apei-base.o hest.o erst.o bert.o
diff --git a/drivers/acpi/apei/ghes-nvidia-test-fixtures.h b/drivers/acpi/apei/ghes-nvidia-test-fixtures.h
new file mode 100644
index 000000000000..705c879c785e
--- /dev/null
+++ b/drivers/acpi/apei/ghes-nvidia-test-fixtures.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef GHES_NVIDIA_TEST_FIXTURES_H
+#define GHES_NVIDIA_TEST_FIXTURES_H
+
+#include <linux/types.h>
+
+/*
+ * Source: cper-tools/test_data/vera_msft.json
+ * cper-tools commit: bf18f75406422e73e11b8b1ff80e3c9d9cfb032a
+ * Boundary: CPER.Oem.Nvidia.Unknown.Data.
+ * Each payload equals the Vera GUID section body located in DiagnosticData.
+ */
+
+/* Redfish Id 10, signature L1 RESET, real sample. */
+/* Vera section index 0, offset 200, length 80. */
+/* sha256 fc11639e506eb8d79e7ff16a0556463ac4b1304bface935c0cd13efc0b3e317f. */
+static const u8 vera_l1_reset_id10[] = {
+	0x01, 0x01, 0x00, 0x00, 0x01, 0x00, 0x27, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x4c, 0x31, 0x20, 0x52, 0x45, 0x53, 0x45, 0x54,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00,
+	0x07, 0x41, 0x01, 0x00, 0xc0, 0x01, 0xfe, 0x06, 0x00, 0x00, 0x00, 0x00,
+	0x81, 0xc1, 0x18, 0x78, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00,
+	0x15, 0xfe, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+/* Redfish Id 40, signature CRASHDUMP-ID, real sample. */
+/* Vera section index 0, offset 200, length 304. */
+/* sha256 3ba93201740e6bd868b48ec40c3d52b235c1ebc59528fc81974079c21bf2a6a2. */
+static const u8 vera_crashdump_id_id40[] = {
+	0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x43, 0x52, 0x41, 0x53, 0x48, 0x44, 0x55, 0x4d,
+	0x50, 0x2d, 0x49, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00,
+	0x07, 0x41, 0x01, 0x00, 0xc0, 0x01, 0xfe, 0x06, 0x00, 0x00, 0x00, 0x00,
+	0x81, 0xc1, 0x18, 0x78, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x83, 0x72, 0x65, 0x6c, 0x5f, 0x37, 0x33, 0x2e, 0x37,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84, 0x64, 0x69, 0x72, 0x74,
+	0x79, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85,
+	0x44, 0x24, 0x4e, 0x9e, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x10, 0x00,
+	0x14, 0xfe, 0x00, 0x00, 0x07, 0x41, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x04, 0x07, 0x03, 0x03, 0x14, 0xfe, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x20, 0x00, 0x15, 0xfe, 0x00, 0x00,
+	0x9d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x0a, 0x04, 0x00,
+	0x14, 0xfe, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x14, 0x0a, 0x04, 0x00, 0x14, 0xfe, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x18, 0x0a, 0x04, 0x00, 0x14, 0xfe, 0x00, 0x00,
+	0x40, 0x60, 0x30, 0x06, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x0a, 0x04, 0x00,
+	0x14, 0xfe, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x20, 0x0a, 0x04, 0x00, 0x14, 0xfe, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x24, 0x0a, 0x04, 0x00, 0x14, 0xfe, 0x00, 0x00,
+	0xfc, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x28, 0x0a, 0x04, 0x00,
+	0x14, 0xfe, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x2c, 0x0a, 0x04, 0x00, 0x14, 0xfe, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+/* Redfish Id 41, signature CRASHDUMP-S1, real sample. */
+/* Vera section index 0, offset 200, length 2008. */
+/* sha256 54db30564d3324240f088a1533c113407f1d81bcd652ef0d27d958c490aee5ce. */
+static const u8 vera_crashdump_s1_id41[] = {
+	0x01, 0x01, 0x00, 0x00, 0x00, 0x10, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x43, 0x52, 0x41, 0x53, 0x48, 0x44, 0x55, 0x4d,
+	0x50, 0x2d, 0x53, 0x31, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00,
+	0x07, 0x41, 0x01, 0x00, 0xc0, 0x01, 0xfe, 0x06, 0x00, 0x00, 0x00, 0x00,
+	0x81, 0xc1, 0x18, 0x78, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0x07, 0x00, 0x00, 0x53, 0x56, 0x7f, 0xa1,
+	0xd1, 0xd7, 0x7f, 0xe5, 0xaa, 0x34, 0xde, 0x7d, 0xe9, 0x3e, 0xc4, 0xd4,
+	0x92, 0xe8, 0x10, 0xa1, 0x4c, 0xfc, 0xf9, 0x2e, 0x02, 0x87, 0xc5, 0x6e,
+	0x44, 0xfb, 0xb5, 0x59, 0xac, 0xfa, 0xa8, 0x15, 0x75, 0x46, 0x2d, 0x67,
+	0x84, 0xe0, 0x78, 0x14, 0xe4, 0x18, 0x8e, 0x30, 0x46, 0xff, 0xbe, 0x5e,
+	0x15, 0x3e, 0x61, 0xf4, 0xcc, 0x3d, 0x2e, 0xdf, 0x1b, 0xf9, 0x1f, 0x1c,
+	0xa3, 0xf8, 0x35, 0x34, 0xe1, 0x4c, 0xb7, 0xd0, 0xcc, 0xda, 0xf1, 0xbc,
+	0x02, 0x8d, 0xc2, 0x6b, 0x5d, 0x56, 0xd4, 0x48, 0x89, 0x7f, 0xb2, 0x64,
+	0xda, 0xa0, 0xf4, 0xed, 0xef, 0xf7, 0x5f, 0x29, 0x38, 0x51, 0x59, 0x35,
+	0x1f, 0x52, 0x63, 0xa8, 0x45, 0x02, 0x7a, 0x24, 0xf6, 0x26, 0x83, 0x29,
+	0x65, 0x01, 0x77, 0x0e, 0xb2, 0x5e, 0xac, 0xf2, 0xd4, 0xc0, 0x09, 0x94,
+	0x5c, 0x4d, 0x55, 0xaf, 0xcf, 0xb7, 0x8c, 0xad, 0x47, 0xcf, 0x02, 0x2c,
+	0x8c, 0x0f, 0x28, 0xf1, 0x4c, 0x15, 0x66, 0xb0, 0xb4, 0x7d, 0xd1, 0xf6,
+	0x90, 0xc8, 0x5e, 0x64, 0x16, 0x9f, 0x5f, 0x3f, 0x50, 0xc9, 0x62, 0x91,
+	0x87, 0xd8, 0xd7, 0xe9, 0x9f, 0x7b, 0xcd, 0xc9, 0xfe, 0xa1, 0xd3, 0xf2,
+	0xc2, 0x95, 0xc7, 0x37, 0x34, 0x6c, 0xc4, 0xc0, 0x53, 0x56, 0x01, 0x2c,
+	0x96, 0x63, 0xdb, 0x2c, 0xea, 0x09, 0xa0, 0xaa, 0xe5, 0xe2, 0x48, 0x18,
+	0x3c, 0x68, 0xf9, 0xa0, 0x7f, 0x98, 0x5a, 0xe3, 0xe8, 0x8e, 0x83, 0x71,
+	0x51, 0x79, 0xc3, 0x14, 0xf1, 0xf4, 0xac, 0xd5, 0xd9, 0x8c, 0xab, 0x33,
+	0x4e, 0x9f, 0xc2, 0xb7, 0xed, 0x6f, 0x78, 0x81, 0x77, 0x34, 0xb8, 0xea,
+	0xb0, 0x71, 0xa1, 0x4d, 0x08, 0x40, 0xad, 0x4c, 0x95, 0x6a, 0x21, 0x96,
+	0x07, 0x12, 0x62, 0xed, 0x42, 0xa9, 0xe4, 0xa8, 0x88, 0xc7, 0x81, 0xff,
+	0x88, 0x07, 0x00, 0x00, 0x55, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x83, 0xbc, 0x15, 0xd9, 0x0b, 0x6b, 0x3b, 0x3b, 0xff, 0x77, 0xb2, 0x7c,
+	0x0c, 0xdd, 0xfb, 0x00, 0x7e, 0x0a, 0x88, 0x47, 0x8a, 0xf2, 0xf8, 0xc5,
+	0x07, 0x51, 0x0e, 0xd7, 0xcb, 0x78, 0xea, 0x89, 0x37, 0x2a, 0x44, 0x0d,
+	0x74, 0x4f, 0x9e, 0x6d, 0x2c, 0xf9, 0x53, 0xed, 0x38, 0x34, 0xca, 0x38,
+	0x7d, 0x96, 0xfe, 0x9a, 0x9b, 0x23, 0x3b, 0x17, 0x17, 0x69, 0xe6, 0x6c,
+	0x0e, 0xe6, 0x71, 0xf5, 0x59, 0xf6, 0xc4, 0x82, 0xd6, 0x83, 0xb1, 0x76,
+	0x41, 0x22, 0x53, 0x72, 0x9f, 0x85, 0x0d, 0xdc, 0x67, 0x22, 0x35, 0xd3,
+	0xe3, 0xaf, 0x10, 0x50, 0xc8, 0xe1, 0xb0, 0xea, 0xc9, 0x1a, 0x3e, 0x02,
+	0x36, 0xea, 0x94, 0xb1, 0x27, 0xfc, 0xc9, 0x61, 0xcb, 0x6f, 0xb0, 0x50,
+	0xe1, 0x85, 0x1c, 0x2d, 0x5f, 0xb5, 0x63, 0x38, 0x69, 0x02, 0xb3, 0x7d,
+	0xb3, 0xb5, 0xe0, 0xfe, 0x5a, 0xf1, 0x0d, 0x83, 0xd9, 0x51, 0xcc, 0xa2,
+	0xb5, 0x41, 0x3b, 0xd1, 0xf5, 0x58, 0xe8, 0x54, 0x49, 0x78, 0xc1, 0x8b,
+	0x70, 0xf1, 0x94, 0x45, 0x18, 0x4b, 0x19, 0x58, 0xe6, 0x0a, 0x08, 0x27,
+	0xe7, 0x95, 0xd6, 0x82, 0xb7, 0x8c, 0xae, 0xae, 0x58, 0x33, 0xc2, 0x02,
+	0xf8, 0xfb, 0x8a, 0x73, 0xe4, 0x0b, 0x75, 0x9b, 0x00, 0x76, 0x14, 0x31,
+	0x5e, 0xf5, 0xf0, 0x8b, 0xb7, 0x6b, 0xaf, 0xdd, 0x8b, 0x52, 0xc9, 0x79,
+	0xe7, 0xd3, 0x17, 0x90, 0xa4, 0xb0, 0xa0, 0x97, 0xcf, 0xba, 0x37, 0x1d,
+	0xe0, 0xbf, 0x31, 0xff, 0xe9, 0x3a, 0x50, 0x5b, 0xf8, 0x94, 0xd0, 0x33,
+	0xf9, 0x2d, 0x2e, 0x54, 0xfa, 0x11, 0x63, 0x06, 0xf2, 0x32, 0xb9, 0x7b,
+	0xd9, 0xc6, 0x12, 0x60, 0xa6, 0x16, 0xac, 0xc8, 0x02, 0xf7, 0xd6, 0xd5,
+	0xb6, 0x2e, 0xf0, 0xb3, 0x05, 0x39, 0x47, 0xd4, 0xa9, 0xed, 0x1a, 0xca,
+	0x4c, 0x4f, 0x83, 0x2d, 0xcc, 0x5c, 0xa7, 0x02, 0x01, 0x84, 0xc9, 0x07,
+	0xa5, 0x6a, 0xf7, 0xbe, 0x3d, 0xc2, 0x09, 0xe8, 0xc8, 0xf8, 0x4b, 0x71,
+	0xa8, 0x79, 0x6c, 0x68, 0xda, 0x35, 0xe1, 0xd2, 0x9d, 0xa6, 0xb3, 0x70,
+	0xf6, 0xcb, 0x66, 0x41, 0xde, 0x86, 0x11, 0x2a, 0xd0, 0xa1, 0x84, 0x99,
+	0x5b, 0xdf, 0x74, 0x26, 0x18, 0xba, 0x6f, 0x3e, 0x46, 0xef, 0xe7, 0xd2,
+	0xfd, 0xe5, 0xa8, 0xba, 0xff, 0xe4, 0xe0, 0x50, 0x9f, 0x23, 0xe5, 0x03,
+	0x81, 0xc2, 0xab, 0x74, 0xd8, 0xc4, 0xe9, 0xd5, 0xf6, 0x7f, 0x86, 0x6b,
+	0x06, 0xfc, 0x62, 0x0f, 0xeb, 0xa3, 0xc4, 0xa0, 0xad, 0x70, 0xad, 0x9b,
+	0xdf, 0xd1, 0x75, 0x28, 0xdc, 0xf2, 0x24, 0x87, 0x6e, 0x85, 0x67, 0xfb,
+	0xbb, 0x38, 0x86, 0xd8, 0x77, 0x15, 0x35, 0x41, 0x53, 0x69, 0x71, 0xd9,
+	0x33, 0x00, 0x2c, 0x56, 0x45, 0xfd, 0xfc, 0xea, 0xf9, 0x8f, 0xd7, 0x04,
+	0x6a, 0x8d, 0xf5, 0x4b, 0xd1, 0x5a, 0x66, 0x7e, 0xe0, 0xeb, 0x06, 0x80,
+	0xc2, 0x14, 0x00, 0x49, 0x1c, 0x62, 0x54, 0xdb, 0x4b, 0x80, 0xc1, 0xa1,
+	0xe3, 0x36, 0xc0, 0x58, 0x0f, 0x6c, 0x65, 0xfc, 0xc8, 0x4d, 0x85, 0xa5,
+	0x5e, 0xb2, 0xbd, 0x5e, 0x2d, 0x47, 0x14, 0x77, 0x32, 0x7e, 0x39, 0x0b,
+	0xba, 0xcd, 0x30, 0x4b, 0x8e, 0x3b, 0x6d, 0x66, 0x59, 0x73, 0x16, 0x0b,
+	0x23, 0x99, 0xb5, 0x09, 0xb7, 0x8f, 0xb2, 0x96, 0x1f, 0x74, 0x08, 0x36,
+	0x1f, 0xcd, 0x46, 0x90, 0x1b, 0xe9, 0xfe, 0xe1, 0xcb, 0x7e, 0x06, 0x98,
+	0x74, 0x47, 0x2f, 0x57, 0x0b, 0x72, 0xea, 0x0d, 0x25, 0xed, 0x92, 0x70,
+	0x0d, 0x00, 0x5f, 0x48, 0xe3, 0xff, 0x3f, 0x39, 0xfc, 0xa9, 0x66, 0xa9,
+	0x95, 0x33, 0xcd, 0x8b, 0x22, 0x11, 0xd9, 0xff, 0x7e, 0x5c, 0x9d, 0x80,
+	0xc5, 0xed, 0x99, 0x78, 0x5c, 0x33, 0xdd, 0x0e, 0xca, 0x6a, 0xe2, 0xb6,
+	0x3a, 0x66, 0xbd, 0x1d, 0x60, 0x96, 0x28, 0x20, 0xbd, 0x8c, 0xf4, 0x6c,
+	0xcb, 0xc3, 0x9b, 0x19, 0x78, 0xd7, 0x57, 0xa3, 0xc3, 0x12, 0x95, 0x11,
+	0x3d, 0xab, 0x44, 0x0d, 0x78, 0xbb, 0x2e, 0x0b, 0x4e, 0x0c, 0x94, 0x75,
+	0xe7, 0x8f, 0x5c, 0xad, 0xe4, 0x2f, 0x9c, 0x26, 0x00, 0x01, 0x71, 0xe1,
+	0x36, 0xcf, 0xb1, 0x00, 0x8f, 0xf7, 0x86, 0x79, 0x2e, 0x79, 0x9e, 0xd5,
+	0x8b, 0x53, 0x0d, 0x28, 0x6c, 0xb9, 0xa2, 0xdf, 0x04, 0xe3, 0x78, 0x6d,
+	0xcb, 0xb7, 0xf9, 0xea, 0x20, 0x4a, 0x5d, 0x92, 0x64, 0x88, 0x7d, 0xc4,
+	0x5a, 0x21, 0x86, 0x12, 0x46, 0x49, 0x6d, 0xbc, 0x03, 0xd5, 0xeb, 0xf6,
+	0xe3, 0x38, 0x4a, 0xaa, 0xce, 0x45, 0x91, 0x6a, 0xc0, 0x59, 0x1b, 0x6c,
+	0x98, 0xb2, 0xe0, 0x29, 0x91, 0x01, 0xb5, 0x44, 0x48, 0xa6, 0xd3, 0x78,
+	0x5a, 0xe1, 0xe4, 0x8c, 0xd9, 0x33, 0xa0, 0xd5, 0xe1, 0x83, 0xd6, 0x5a,
+	0xe3, 0x5f, 0xe6, 0xf8, 0xfd, 0x21, 0x12, 0xff, 0x9e, 0x71, 0x70, 0x7f,
+	0x17, 0xe2, 0x41, 0xf2, 0xb1, 0x4a, 0x84, 0x6b, 0x88, 0xb6, 0xb9, 0xed,
+	0xdb, 0x0b, 0x84, 0x6f, 0x07, 0x94, 0xc7, 0x8e, 0xcc, 0xc2, 0xb2, 0x49,
+	0x3d, 0xf8, 0x70, 0x1a, 0x9b, 0x4d, 0x13, 0x0c, 0xe7, 0xeb, 0x75, 0x5d,
+	0xfb, 0x10, 0x16, 0xf9, 0xf1, 0xac, 0x4b, 0xe3, 0x65, 0x5f, 0xaa, 0xbb,
+	0x31, 0xac, 0x4d, 0x74, 0x11, 0x62, 0x64, 0xd1, 0x90, 0x6e, 0x45, 0xaf,
+	0x2d, 0xb2, 0xa5, 0xfa, 0x57, 0x67, 0xaa, 0x4c, 0x3f, 0x81, 0x72, 0x93,
+	0x8a, 0xfb, 0xeb, 0x19, 0x9d, 0x9a, 0x10, 0x8d, 0xce, 0xb8, 0xe9, 0x3f,
+	0x97, 0x3e, 0xb2, 0x2d, 0x3e, 0xaf, 0x19, 0x39, 0xb0, 0xea, 0x33, 0x09,
+	0x25, 0xbc, 0x6f, 0x88, 0x25, 0x75, 0x11, 0x2b, 0xd9, 0x42, 0x8d, 0x48,
+	0x8e, 0xe7, 0x51, 0x4e, 0xd4, 0xee, 0xd4, 0xf1, 0xe1, 0x94, 0xfb, 0xbd,
+	0x01, 0x87, 0xa5, 0xd6, 0x94, 0x36, 0x6f, 0x37, 0xcd, 0x70, 0x49, 0xfd,
+	0x6a, 0x94, 0xb0, 0xc8, 0xe5, 0xb9, 0xdb, 0x83, 0x72, 0xa0, 0xd8, 0x5e,
+	0x00, 0x3e, 0x3d, 0x56, 0xc9, 0xae, 0xf6, 0xe7, 0xb1, 0xba, 0xdd, 0x6d,
+	0x59, 0x2a, 0x6a, 0x50, 0x66, 0xfd, 0xf1, 0x1f, 0x18, 0xe4, 0xf9, 0x59,
+	0x16, 0xf1, 0x25, 0x42, 0x7c, 0xab, 0xc5, 0xea, 0x64, 0x31, 0xf7, 0xcf,
+	0xdd, 0x56, 0xc4, 0xbd, 0xb5, 0xe6, 0xb4, 0xda, 0x41, 0xb7, 0xfa, 0x05,
+	0x06, 0x57, 0x51, 0xd8, 0xc4, 0xf7, 0x3c, 0xc8, 0x54, 0x55, 0x5c, 0x2c,
+	0xd2, 0x17, 0xec, 0x27, 0xd3, 0xbf, 0xf3, 0xc8, 0xba, 0xbf, 0x75, 0xcf,
+	0x1f, 0x78, 0x42, 0x1a, 0x4f, 0xb0, 0xcb, 0xd7, 0x84, 0xc6, 0xbd, 0x40,
+	0x07, 0xbf, 0x47, 0xe9, 0x17, 0x2f, 0xad, 0xec, 0x64, 0x8b, 0xca, 0x7c,
+	0x49, 0x4c, 0xda, 0xf9, 0x5f, 0x28, 0x1d, 0x2d, 0xc3, 0x8d, 0x15, 0xa6,
+	0x0f, 0x95, 0x76, 0x99, 0xb5, 0x76, 0x68, 0x97, 0x91, 0x93, 0xca, 0x9d,
+	0x61, 0x50, 0xa7, 0xa7, 0xf7, 0xce, 0xd5, 0x14, 0xe5, 0xb2, 0x50, 0x50,
+	0x21, 0x73, 0x00, 0x21, 0x4f, 0x12, 0x79, 0x7f, 0x68, 0x27, 0x52, 0xf2,
+	0x2c, 0x9d, 0x2d, 0x4f, 0x66, 0x3e, 0xf1, 0xb5, 0x68, 0x77, 0xc9, 0xd5,
+	0x16, 0x01, 0xb2, 0x6d, 0x46, 0x7c, 0xce, 0x8d, 0x67, 0x77, 0x27, 0xdd,
+	0x4b, 0x16, 0xd7, 0x7b, 0x16, 0xfd, 0x6b, 0x18, 0x36, 0xeb, 0xa5, 0xd6,
+	0xd1, 0x21, 0xdb, 0x27, 0x01, 0x9a, 0x22, 0xa1, 0xbf, 0x45, 0xda, 0xf7,
+	0xe4, 0x07, 0x26, 0x0c, 0x84, 0xe1, 0x81, 0x1c, 0xf9, 0x38, 0x4a, 0x26,
+	0xb3, 0xe3, 0x90, 0x13, 0x5e, 0xb7, 0xd5, 0xaf, 0xcb, 0x7d, 0xc1, 0xf7,
+	0x23, 0x2d, 0x96, 0xc8, 0xe7, 0x3e, 0x21, 0x2c, 0xee, 0xa8, 0xd7, 0x83,
+	0xf1, 0xd7, 0xf0, 0xce, 0xca, 0x80, 0xb5, 0xbd, 0x89, 0x10, 0x71, 0x38,
+	0x8c, 0xa2, 0xa1, 0x07, 0x93, 0xa9, 0xd9, 0x4d, 0xa5, 0x9b, 0x66, 0x68,
+	0x06, 0x65, 0x8d, 0x26, 0xff, 0xcb, 0xf2, 0xf5, 0x09, 0x7c, 0xf1, 0x7f,
+	0x55, 0x3f, 0x61, 0x78, 0xb8, 0x27, 0x77, 0xb8, 0x30, 0x91, 0x10, 0x3f,
+	0x57, 0xec, 0xfd, 0x82, 0xd2, 0xd3, 0x8a, 0x27, 0xa5, 0x26, 0x87, 0x01,
+	0x8a, 0x20, 0x9a, 0x5d, 0xe9, 0x88, 0xa7, 0x70, 0xb0, 0x06, 0x04, 0xe8,
+	0xa0, 0x15, 0x2c, 0x0b, 0xe5, 0xea, 0x79, 0x57, 0xad, 0x8c, 0xe2, 0x98,
+	0xcd, 0xbf, 0x74, 0x1c, 0xb6, 0x06, 0xc6, 0x17, 0x12, 0x2b, 0xa4, 0xa6,
+	0xfe, 0xe7, 0x94, 0xf9, 0xb6, 0x95, 0xf0, 0xfc, 0xe5, 0x57, 0xfe, 0xf9,
+	0x1d, 0xd4, 0x29, 0xc0, 0x06, 0xf9, 0x5f, 0x14, 0x73, 0x14, 0x1d, 0x42,
+	0x1f, 0x70, 0xa0, 0xd5, 0x3d, 0x0d, 0xbe, 0xfb, 0xb3, 0xe0, 0xae, 0x35,
+	0x34, 0x40, 0xa9, 0xca, 0x5d, 0x6f, 0x4f, 0x3a, 0x3b, 0x9e, 0xe2, 0xed,
+	0x85, 0xa9, 0x53, 0xb9, 0xb2, 0x43, 0x5e, 0x95, 0x7a, 0x30, 0x63, 0x2a,
+	0x84, 0x40, 0x1b, 0x86, 0x2d, 0x74, 0xf6, 0xf3, 0x3b, 0x40, 0x5b, 0x16,
+	0x51, 0xa1, 0xaa, 0x70, 0xed, 0xb3, 0x96, 0x66, 0x9b, 0x6b, 0x57, 0x4d,
+	0x0d, 0x8b, 0x2a, 0x9b, 0x27, 0xb6, 0x04, 0xa5, 0x19, 0xb2, 0x17, 0xad,
+	0x6f, 0x6f, 0xef, 0x8c, 0xae, 0x87, 0x58, 0xc9, 0xbd, 0x51, 0xf9, 0x6b,
+	0x7d, 0x5c, 0xd1, 0x42, 0x10, 0xa1, 0x5c, 0x66, 0x13, 0xaa, 0xe0, 0xfc,
+	0x91, 0x95, 0x63, 0x0a, 0x0b, 0x3d, 0x5c, 0xd1, 0x64, 0xda, 0xaf, 0x7b,
+	0x1b, 0x0a, 0x09, 0x9f, 0xf8, 0xd9, 0x43, 0x7b, 0x7d, 0xe1, 0x34, 0x68,
+	0x6a, 0xb2, 0x3a, 0x16, 0x99, 0x2f, 0x29, 0x5f, 0xa3, 0xe6, 0x03, 0x74,
+	0x42, 0x49, 0x6a, 0x33, 0x15, 0x93, 0x5e, 0xa5, 0xab, 0x13, 0x77, 0x3a,
+	0x1a, 0x78, 0x6d, 0xe5, 0x06, 0x1f, 0xa4, 0x6f, 0xdc, 0xa8, 0xc8, 0x93,
+	0x9f, 0x4d, 0x99, 0xba, 0xb1, 0x6d, 0x8d, 0x1d, 0xc0, 0x6b, 0xff, 0x16,
+	0x7d, 0xb3, 0xfc, 0xe0, 0xd7, 0xd4, 0xb2, 0x69, 0x32, 0x38, 0x64, 0xef,
+	0x04, 0xba, 0x7b, 0xa5, 0x5e, 0xc6, 0x1f, 0x1d, 0xd0, 0xf8, 0x6b, 0xd8,
+	0x35, 0xb9, 0x9e, 0x2f, 0x62, 0x36, 0xf5, 0x88, 0x41, 0x90, 0x1f, 0xc7,
+	0xc3, 0x96, 0x1b, 0x4f, 0xc4, 0x87, 0x0c, 0xea, 0xdb, 0x8f, 0xea, 0x6a,
+	0xe9, 0xdc, 0x30, 0xc4, 0x6c, 0x23, 0x9b, 0xac, 0x8b, 0xf6, 0xa6, 0xbf,
+	0xc0, 0xd6, 0x00, 0xf6, 0x92, 0x3f, 0xd3, 0x83, 0xfe, 0x74, 0x7c, 0x19,
+	0x74, 0xfb, 0xe7, 0x72, 0x81, 0x17, 0x32, 0x32, 0xb8, 0x4b, 0x5d, 0x70,
+	0x67, 0x14, 0xe1, 0xee,
+};
+
+#endif
diff --git a/drivers/acpi/apei/ghes-nvidia-test.c b/drivers/acpi/apei/ghes-nvidia-test.c
new file mode 100644
index 000000000000..5c84da82f898
--- /dev/null
+++ b/drivers/acpi/apei/ghes-nvidia-test.c
@@ -0,0 +1,704 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+#include <linux/uuid.h>
+
+#include "ghes-nvidia.h"
+#include "ghes-nvidia-test-fixtures.h"
+
+static const u8 grace_valid_two_regs[] = {
+	'N', 'V', 'D', 'A', '-', 'G', 'R', 'A',
+	'C', 'E', 0, 0, 0, 0, 0, 0,
+	0x34, 0x12, 0x78, 0x56, 0x02, 0x03, 0x02, 0x00,
+	0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x11, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const u8 grace_valid_zero_regs[] = {
+	'N', 'V', 'D', 'A', '-', 'G', 'R', 'A',
+	'C', 'E', 0, 0, 0, 0, 0, 0,
+	0x01, 0x00, 0x02, 0x00, 0x00, 0x01, 0x00, 0x00,
+	0xef, 0xbe, 0xad, 0xde, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const u8 grace_valid_full_signature[] = {
+	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
+	'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
+	0x01, 0x00, 0x02, 0x00, 0x00, 0x01, 0x00, 0x00,
+	0xef, 0xbe, 0xad, 0xde, 0x00, 0x00, 0x00, 0x00,
+};
+
+static void nvidia_ghes_grace_decodes_registers(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u64 addr, val;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_decode_grace(NULL, grace_valid_two_regs,
+						 sizeof(grace_valid_two_regs),
+						 &decoded));
+	KUNIT_EXPECT_EQ(test, NVIDIA_GHES_FORMAT_GRACE, decoded.format);
+	KUNIT_EXPECT_STREQ(test, "NVDA-GRACE", decoded.signature);
+	KUNIT_EXPECT_EQ(test, 0x1234, decoded.error_type);
+	KUNIT_EXPECT_EQ(test, 0x5678, decoded.error_instance);
+	KUNIT_EXPECT_EQ(test, 2, decoded.severity);
+	KUNIT_EXPECT_EQ(test, 3, decoded.socket);
+	KUNIT_EXPECT_EQ(test, 2, decoded.number_regs);
+	KUNIT_EXPECT_EQ(test, 0x0102030405060708ULL, decoded.instance_base);
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_grace_reg_pair(&decoded, 0, &addr, &val));
+	KUNIT_EXPECT_EQ(test, 0x1000ULL, addr);
+	KUNIT_EXPECT_EQ(test, 0x1111ULL, val);
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_grace_reg_pair(&decoded, 1, &addr, &val));
+	KUNIT_EXPECT_EQ(test, 0x2000ULL, addr);
+	KUNIT_EXPECT_EQ(test, 0x2222ULL, val);
+}
+
+static void nvidia_ghes_grace_accepts_zero_registers(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_decode_grace(NULL, grace_valid_zero_regs,
+						 sizeof(grace_valid_zero_regs),
+						 &decoded));
+	KUNIT_EXPECT_EQ(test, NVIDIA_GHES_FORMAT_GRACE, decoded.format);
+	KUNIT_EXPECT_EQ(test, 0, decoded.number_regs);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, decoded.grace_regs);
+}
+
+static void nvidia_ghes_grace_copies_non_nul_signature(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_decode_grace(NULL, grace_valid_full_signature,
+						 sizeof(grace_valid_full_signature),
+						 &decoded));
+	KUNIT_EXPECT_STREQ(test, "ABCDEFGHIJKLMNOP", decoded.signature);
+	KUNIT_EXPECT_EQ(test, '\0', decoded.signature[16]);
+}
+
+static void nvidia_ghes_grace_rejects_truncated_header(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+
+	KUNIT_EXPECT_EQ(test, -ENODATA,
+			nvidia_ghes_decode_grace(NULL, grace_valid_two_regs,
+						 sizeof(grace_valid_zero_regs) - 1,
+						 &decoded));
+}
+
+static void nvidia_ghes_grace_rejects_truncated_registers(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+
+	KUNIT_EXPECT_EQ(test, -ENODATA,
+			nvidia_ghes_decode_grace(NULL, grace_valid_two_regs,
+						 sizeof(grace_valid_two_regs) - 1,
+						 &decoded));
+}
+
+static const u8 vera_chip_serial[] = {
+	0xc0, 0x01, 0xfe, 0x06, 0x00, 0x00, 0x00, 0x00,
+	0x81, 0xc1, 0x18, 0x78, 0x01, 0x00, 0x00, 0x00,
+};
+
+#define VERA_EVENT_HDR_SIZE	32
+#define VERA_CPU_INFO_SIZE	32
+#define VERA_CONTEXT_HDR_SIZE	16
+#define VERA_FIRST_CONTEXT_OFFSET	(VERA_EVENT_HDR_SIZE + VERA_CPU_INFO_SIZE)
+
+static u8 *nvidia_ghes_kunit_memdup(struct kunit *test, const u8 *src, size_t len)
+{
+	u8 *buf;
+
+	buf = kunit_kmalloc(test, len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	memcpy(buf, src, len);
+
+	return buf;
+}
+
+static u8 *vera_make_synthetic(struct kunit *test, u8 version, u8 info_size,
+			       u16 format, const u8 *data, u32 data_size,
+			       size_t *len)
+{
+	u8 *buf;
+	size_t context_offset;
+
+	KUNIT_ASSERT_TRUE(test, info_size >= VERA_CPU_INFO_SIZE);
+
+	context_offset = VERA_EVENT_HDR_SIZE + info_size;
+	*len = context_offset + VERA_CONTEXT_HDR_SIZE + data_size;
+	buf = kunit_kzalloc(test, *len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+
+	buf[0] = version;
+	buf[1] = 1;
+	buf[2] = 0;
+	put_unaligned_le16(0x22, &buf[4]);
+	memcpy(&buf[16], "SYNTH", 5);
+	put_unaligned_le16(0, &buf[32]);
+	buf[34] = info_size;
+	buf[35] = 0;
+	put_unaligned_le32(0x14107, &buf[36]);
+	memcpy(&buf[40], vera_chip_serial, sizeof(vera_chip_serial));
+	put_unaligned_le64(0, &buf[56]);
+	put_unaligned_le32(VERA_CONTEXT_HDR_SIZE, &buf[context_offset]);
+	put_unaligned_le16(0, &buf[context_offset + 4]);
+	put_unaligned_le16(format, &buf[context_offset + 8]);
+	put_unaligned_le16(0, &buf[context_offset + 10]);
+	put_unaligned_le32(data_size, &buf[context_offset + 12]);
+	memcpy(&buf[context_offset + VERA_CONTEXT_HDR_SIZE], data, data_size);
+
+	return buf;
+}
+
+static u8 *vera_make_synthetic_default(struct kunit *test, u16 format,
+				       const u8 *data, u32 data_size, size_t *len)
+{
+	return vera_make_synthetic(test, 1, VERA_CPU_INFO_SIZE, format, data,
+				   data_size, len);
+}
+
+static int nvidia_ghes_vera_context_u64_pair(const struct nvidia_ghes_vera_context *ctx,
+					     unsigned int index, u64 *addr, u64 *val)
+{
+	int count;
+
+	if (!ctx || !addr || !val || ctx->data_format_type != 1)
+		return -EINVAL;
+
+	count = nvidia_ghes_vera_context_entry_count(ctx);
+	if (count < 0)
+		return count;
+	if (index >= count)
+		return -ERANGE;
+
+	*addr = get_unaligned_le64(ctx->data + index * 16);
+	*val = get_unaligned_le64(ctx->data + index * 16 + 8);
+
+	return 0;
+}
+
+static int nvidia_ghes_vera_context_u32_pair(const struct nvidia_ghes_vera_context *ctx,
+					     unsigned int index, u32 *addr, u32 *val)
+{
+	int count;
+
+	if (!ctx || !addr || !val || ctx->data_format_type != 2)
+		return -EINVAL;
+
+	count = nvidia_ghes_vera_context_entry_count(ctx);
+	if (count < 0)
+		return count;
+	if (index >= count)
+		return -ERANGE;
+
+	*addr = get_unaligned_le32(ctx->data + index * 8);
+	*val = get_unaligned_le32(ctx->data + index * 8 + 4);
+
+	return 0;
+}
+
+static int nvidia_ghes_vera_context_u64_value(const struct nvidia_ghes_vera_context *ctx,
+					      unsigned int index, u64 *val)
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
+
+static int nvidia_ghes_vera_context_u32_value(const struct nvidia_ghes_vera_context *ctx,
+					      unsigned int index, u32 *val)
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
+
+static void nvidia_ghes_vera_decodes_l1_reset(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, vera_l1_reset_id10,
+						sizeof(vera_l1_reset_id10),
+						&decoded));
+	KUNIT_EXPECT_EQ(test, NVIDIA_GHES_FORMAT_VERA, decoded.format);
+	KUNIT_EXPECT_STREQ(test, "L1 RESET", decoded.signature);
+	KUNIT_EXPECT_EQ(test, 1, decoded.event_context_count);
+	KUNIT_EXPECT_EQ(test, 1, decoded.event_type);
+	KUNIT_EXPECT_EQ(test, 39, decoded.event_sub_type);
+	KUNIT_EXPECT_EQ(test, 0, decoded.source_device_type);
+	KUNIT_EXPECT_EQ(test, 0, decoded.socket);
+	KUNIT_EXPECT_EQ(test, 0x14107U, decoded.architecture);
+	KUNIT_EXPECT_MEMEQ(test, decoded.chip_serial_number, vera_chip_serial,
+			   sizeof(vera_chip_serial));
+	KUNIT_EXPECT_EQ(test, 0xfe1500200000ULL, decoded.instance_base);
+	KUNIT_EXPECT_EQ(test, 16U, decoded.contexts[0].context_size);
+	KUNIT_EXPECT_EQ(test, 1, decoded.contexts[0].data_format_type);
+	KUNIT_EXPECT_EQ(test, 0U, decoded.contexts[0].data_size);
+}
+
+static void nvidia_ghes_vera_decodes_crashdump_id(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u64 addr, val;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, vera_crashdump_id_id40,
+						sizeof(vera_crashdump_id_id40),
+						&decoded));
+	KUNIT_EXPECT_STREQ(test, "CRASHDUMP-ID", decoded.signature);
+	KUNIT_EXPECT_MEMEQ(test, decoded.chip_serial_number, vera_chip_serial,
+			   sizeof(vera_chip_serial));
+	KUNIT_EXPECT_EQ(test, 240U, decoded.contexts[0].context_size);
+	KUNIT_EXPECT_EQ(test, 1, decoded.contexts[0].data_format_type);
+	KUNIT_EXPECT_EQ(test, 224U, decoded.contexts[0].data_size);
+	KUNIT_EXPECT_EQ(test, 14, nvidia_ghes_vera_context_entry_count(&decoded.contexts[0]));
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_context_u64_pair(&decoded.contexts[0], 0,
+							  &addr, &val));
+	KUNIT_EXPECT_EQ(test, 0x8300000000000000ULL, addr);
+	KUNIT_EXPECT_EQ(test, 0x372e33375f6c6572ULL, val);
+}
+
+static void nvidia_ghes_vera_decodes_crashdump_s1_opaque_context(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u64 val;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, vera_crashdump_s1_id41,
+						sizeof(vera_crashdump_s1_id41),
+						&decoded));
+	KUNIT_EXPECT_STREQ(test, "CRASHDUMP-S1", decoded.signature);
+	KUNIT_EXPECT_EQ(test, 4096, decoded.event_type);
+	KUNIT_EXPECT_EQ(test, 2304, decoded.event_sub_type);
+	KUNIT_EXPECT_MEMEQ(test, decoded.chip_serial_number, vera_chip_serial,
+			   sizeof(vera_chip_serial));
+	KUNIT_EXPECT_EQ(test, 16U, decoded.contexts[0].context_size);
+	KUNIT_EXPECT_EQ(test, 0, decoded.contexts[0].data_format_type);
+	KUNIT_EXPECT_EQ(test, 1928U, decoded.contexts[0].data_size);
+	KUNIT_EXPECT_NOT_NULL(test, decoded.contexts[0].data);
+	KUNIT_EXPECT_EQ(test, 0x53, decoded.contexts[0].data[0]);
+	KUNIT_EXPECT_EQ(test, 0x56, decoded.contexts[0].data[1]);
+	KUNIT_EXPECT_EQ(test, 0x7f, decoded.contexts[0].data[2]);
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_vera_context_u64_value(&decoded.contexts[0], 0, &val));
+}
+
+static void nvidia_ghes_vera_decodes_format2_u32_pairs(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x78, 0x56, 0x34, 0x12, 0xf0, 0xde, 0xbc, 0x9a,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+	u32 addr, val;
+
+	buf = vera_make_synthetic_default(test, 2, data, sizeof(data), &len);
+	KUNIT_EXPECT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 1, nvidia_ghes_vera_context_entry_count(&decoded.contexts[0]));
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_context_u32_pair(&decoded.contexts[0], 0,
+							  &addr, &val));
+	KUNIT_EXPECT_EQ(test, 0x12345678U, addr);
+	KUNIT_EXPECT_EQ(test, 0x9abcdef0U, val);
+}
+
+static void nvidia_ghes_vera_decodes_format3_u64_values(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+	u64 val;
+
+	buf = vera_make_synthetic_default(test, 3, data, sizeof(data), &len);
+	KUNIT_EXPECT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 1, nvidia_ghes_vera_context_entry_count(&decoded.contexts[0]));
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_context_u64_value(&decoded.contexts[0], 0, &val));
+	KUNIT_EXPECT_EQ(test, 0x0102030405060708ULL, val);
+}
+
+static void nvidia_ghes_vera_decodes_format4_u32_values(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x78, 0x56, 0x34, 0x12,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+	u32 val;
+
+	buf = vera_make_synthetic_default(test, 4, data, sizeof(data), &len);
+	KUNIT_EXPECT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 1, nvidia_ghes_vera_context_entry_count(&decoded.contexts[0]));
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_context_u32_value(&decoded.contexts[0], 0, &val));
+	KUNIT_EXPECT_EQ(test, 0x12345678U, val);
+}
+
+static void nvidia_ghes_vera_rejects_truncated_event_header(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+
+	KUNIT_EXPECT_EQ(test, -ENODATA,
+			nvidia_ghes_decode_vera(NULL, vera_l1_reset_id10,
+						VERA_EVENT_HDR_SIZE - 1,
+						&decoded));
+}
+
+static void nvidia_ghes_vera_rejects_truncated_cpu_info(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+
+	KUNIT_EXPECT_EQ(test, -ENODATA,
+			nvidia_ghes_decode_vera(NULL, vera_l1_reset_id10,
+						VERA_FIRST_CONTEXT_OFFSET - 1,
+						&decoded));
+}
+
+static void nvidia_ghes_vera_rejects_truncated_context_header(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+
+	KUNIT_EXPECT_EQ(test, -ENODATA,
+			nvidia_ghes_decode_vera(NULL, vera_l1_reset_id10,
+						VERA_FIRST_CONTEXT_OFFSET +
+						VERA_CONTEXT_HDR_SIZE - 1,
+						&decoded));
+}
+
+static void nvidia_ghes_vera_rejects_too_many_contexts(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_l1_reset_id10, sizeof(vera_l1_reset_id10));
+	buf[1] = NVIDIA_GHES_MAX_CONTEXTS + 1;
+
+	KUNIT_EXPECT_EQ(test, -E2BIG,
+			nvidia_ghes_decode_vera(NULL, buf, sizeof(vera_l1_reset_id10), &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_bad_info_size(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_l1_reset_id10, sizeof(vera_l1_reset_id10));
+	buf[34] = 31;
+
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_decode_vera(NULL, buf, sizeof(vera_l1_reset_id10), &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_unsupported_version(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_l1_reset_id10, sizeof(vera_l1_reset_id10));
+	buf[0] = 2;
+
+	KUNIT_EXPECT_EQ(test, -EOPNOTSUPP,
+			nvidia_ghes_decode_vera(NULL, buf, sizeof(vera_l1_reset_id10), &decoded));
+}
+
+static void nvidia_ghes_vera_accepts_extended_cpu_info(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+	u64 val;
+
+	buf = vera_make_synthetic(test, 1, VERA_CPU_INFO_SIZE + 4, 3,
+				  data, sizeof(data), &len);
+	KUNIT_EXPECT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, VERA_CONTEXT_HDR_SIZE, decoded.contexts[0].context_size);
+	KUNIT_EXPECT_EQ(test, 3, decoded.contexts[0].data_format_type);
+	KUNIT_EXPECT_EQ(test, 8U, decoded.contexts[0].data_size);
+	KUNIT_EXPECT_EQ(test, 1, nvidia_ghes_vera_context_entry_count(&decoded.contexts[0]));
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_context_u64_value(&decoded.contexts[0], 0, &val));
+	KUNIT_EXPECT_EQ(test, 0x0102030405060708ULL, val);
+}
+
+static void nvidia_ghes_vera_rejects_short_context_size(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_l1_reset_id10, sizeof(vera_l1_reset_id10));
+	put_unaligned_le32(15, &buf[VERA_FIRST_CONTEXT_OFFSET]);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_decode_vera(NULL, buf, sizeof(vera_l1_reset_id10), &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_ambiguous_context_size(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+
+	buf = vera_make_synthetic_default(test, 3, data, sizeof(data), &len);
+	put_unaligned_le32(20, &buf[VERA_FIRST_CONTEXT_OFFSET]);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_data_beyond_section(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+
+	buf = vera_make_synthetic_default(test, 3, data, sizeof(data), &len);
+	put_unaligned_le32(16, &buf[VERA_FIRST_CONTEXT_OFFSET + 12]);
+
+	KUNIT_EXPECT_EQ(test, -ENODATA, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_mis_sized_format1(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_crashdump_id_id40,
+				       sizeof(vera_crashdump_id_id40));
+	put_unaligned_le32(15, &buf[VERA_FIRST_CONTEXT_OFFSET + 12]);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_decode_vera(NULL, buf, sizeof(vera_crashdump_id_id40), &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_mis_sized_format2(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x78, 0x56, 0x34, 0x12, 0xf0, 0xde, 0xbc,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+
+	buf = vera_make_synthetic_default(test, 2, data, sizeof(data), &len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_mis_sized_format3(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+
+	buf = vera_make_synthetic_default(test, 3, data, sizeof(data), &len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_mis_sized_format4(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x78, 0x56, 0x34,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+
+	buf = vera_make_synthetic_default(test, 4, data, sizeof(data), &len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_unsupported_source_device(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_l1_reset_id10, sizeof(vera_l1_reset_id10));
+	buf[2] = 1;
+
+	KUNIT_EXPECT_EQ(test, -EOPNOTSUPP,
+			nvidia_ghes_decode_vera(NULL, buf, sizeof(vera_l1_reset_id10), &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_unsupported_data_format(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_l1_reset_id10, sizeof(vera_l1_reset_id10));
+	put_unaligned_le16(5, &buf[VERA_FIRST_CONTEXT_OFFSET + 8]);
+
+	KUNIT_EXPECT_EQ(test, -EOPNOTSUPP,
+			nvidia_ghes_decode_vera(NULL, buf, sizeof(vera_l1_reset_id10), &decoded));
+}
+
+static void nvidia_ghes_vera_copies_non_nul_signature(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_l1_reset_id10, sizeof(vera_l1_reset_id10));
+	memcpy(&buf[16], "ABCDEFGHIJKLMNOP", 16);
+
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, buf, sizeof(vera_l1_reset_id10), &decoded));
+	KUNIT_EXPECT_STREQ(test, "ABCDEFGHIJKLMNOP", decoded.signature);
+	KUNIT_EXPECT_EQ(test, '\0', decoded.signature[16]);
+}
+
+static void nvidia_ghes_guid_routes_grace(struct kunit *test)
+{
+	const guid_t guid = GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
+				      0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
+
+	KUNIT_EXPECT_EQ(test, NVIDIA_GHES_FORMAT_GRACE,
+			nvidia_ghes_format_from_guid(&guid));
+}
+
+static void nvidia_ghes_guid_routes_vera(struct kunit *test)
+{
+	const guid_t guid = GUID_INIT(0x9068e568, 0x6ca0, 0x11f0,
+				      0xae, 0xaf, 0x15, 0x93, 0x43, 0x59, 0x1e, 0xac);
+
+	KUNIT_EXPECT_EQ(test, NVIDIA_GHES_FORMAT_VERA,
+			nvidia_ghes_format_from_guid(&guid));
+}
+
+static void nvidia_ghes_guid_rejects_unknown(struct kunit *test)
+{
+	const guid_t guid = GUID_INIT(0x00000000, 0x0000, 0x0000,
+				      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+
+	KUNIT_EXPECT_EQ(test, NVIDIA_GHES_FORMAT_UNKNOWN,
+			nvidia_ghes_format_from_guid(&guid));
+}
+
+static void nvidia_ghes_grace_reg_pair_rejects_null_decoded(struct kunit *test)
+{
+	u64 addr, val;
+
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_grace_reg_pair(NULL, 0, &addr, &val));
+}
+
+static void nvidia_ghes_grace_reg_pair_rejects_wrong_format(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {
+		.format = NVIDIA_GHES_FORMAT_VERA,
+	};
+	u64 addr, val;
+
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_grace_reg_pair(&decoded, 0, &addr, &val));
+}
+
+static void nvidia_ghes_grace_reg_pair_rejects_out_of_range(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {
+		.format = NVIDIA_GHES_FORMAT_GRACE,
+		.number_regs = 0,
+	};
+	u64 addr, val;
+
+	KUNIT_EXPECT_EQ(test, -ERANGE,
+			nvidia_ghes_grace_reg_pair(&decoded, 0, &addr, &val));
+}
+
+static struct kunit_case nvidia_ghes_test_cases[] = {
+	KUNIT_CASE(nvidia_ghes_grace_decodes_registers),
+	KUNIT_CASE(nvidia_ghes_grace_accepts_zero_registers),
+	KUNIT_CASE(nvidia_ghes_grace_copies_non_nul_signature),
+	KUNIT_CASE(nvidia_ghes_grace_rejects_truncated_header),
+	KUNIT_CASE(nvidia_ghes_grace_rejects_truncated_registers),
+	KUNIT_CASE(nvidia_ghes_grace_reg_pair_rejects_null_decoded),
+	KUNIT_CASE(nvidia_ghes_grace_reg_pair_rejects_wrong_format),
+	KUNIT_CASE(nvidia_ghes_grace_reg_pair_rejects_out_of_range),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_l1_reset),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_crashdump_id),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_crashdump_s1_opaque_context),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_format2_u32_pairs),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_format3_u64_values),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_format4_u32_values),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_truncated_event_header),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_truncated_cpu_info),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_truncated_context_header),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_too_many_contexts),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_bad_info_size),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_unsupported_version),
+	KUNIT_CASE(nvidia_ghes_vera_accepts_extended_cpu_info),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_short_context_size),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_ambiguous_context_size),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_data_beyond_section),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_mis_sized_format1),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_mis_sized_format2),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_mis_sized_format3),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_mis_sized_format4),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_unsupported_source_device),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_unsupported_data_format),
+	KUNIT_CASE(nvidia_ghes_vera_copies_non_nul_signature),
+	KUNIT_CASE(nvidia_ghes_guid_routes_grace),
+	KUNIT_CASE(nvidia_ghes_guid_routes_vera),
+	KUNIT_CASE(nvidia_ghes_guid_rejects_unknown),
+	{}
+};
+
+static struct kunit_suite nvidia_ghes_test_suite = {
+	.name = "ghes-nvidia",
+	.test_cases = nvidia_ghes_test_cases,
+};
+
+kunit_test_suite(nvidia_ghes_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_DESCRIPTION("KUnit tests for NVIDIA GHES CPER parser helpers");
+MODULE_LICENSE("GPL");
-- 
2.50.1 (Apple Git-155)

