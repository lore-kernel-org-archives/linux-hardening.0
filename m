Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D337F726;
	Tue,  4 Aug 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846233; cv=fail; b=oiUmmF0hMgIu9B9v9Grt4V/Uno6wJtv63FlgixQgu4czHL45OqPHZtNOtFtFHmyuqYqN/I3qYb+OV/LBI5fpvtfqtZWZ7EQe8KsYyrzz6Blcrp5c0e9C29TIk3caxjGtLM4rA24F1hwQHEiCEefglnVS+13ATyUPZOdtcbFzcro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846233; c=relaxed/simple;
	bh=olfode7XqzqqNMC+F/ORsgC/36Uu0B5lyG64k+0Xmek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8Is34Upxp+7ZgHY4yRCQZ3sf45tosW4lo1i5Q7Wu4RJrcCH3r1PgPSPNxEHFPnpC06XEi2FgNmms8zPw/nNtVAWoCDOlZ9k4toSJ35Ogi9F+gZUVT1zj7qFDho4h4Mp+Nyrst3y9zF7TWHPI7ikkw2Zmn58/2y3CnsVnVl13gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ecDyStwW; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ecDyStwW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWfw4vcQ9FGe6iU7oWrAZiEEZnU+dBcektSr52ih/FGd68Kfbq1TGbcGXdnXF8NuwayGcf0iz37ljVXSme/k+xDJMtEM8lceqHWybZ5i3SkS2WSv6VDLvqsTXTaSCvNtSrIal6jtfuQ6sicpbCcWVHJittts2Byrcjjnnm29349dKnJ01ix6MddAEBdnIsUNzmjnMy8C5IlOT2y2VzswQxE6yuz4PEzd3Jv5G5h7b7H6GoU15r+EMcFerWRJHHnRDu//SCwc2OTmtMBH0c3pS+YTFsa1i9zEqzZF+q59JqOwGaUj8IRlEfKCQaIeHRfKav4e9u1IDvZktCd5G7lYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eIefEDiuQIPaH3SMKKiDYTcivOvo2QCzAJf1/5iDkg=;
 b=K+qYjBfTsZmAimjK/AvBd9lLGMpHypkG5TroRAmpw5ioaSZNxHd7OcBarwryVOfrr4igKG7lq3gA0bm4NSLeIAsReVJnjfKg6Pg8wY4/Z9cQI1E6aQqSZ6g//ATxvnYHNYooQbJKjT6HxaHoLLKL+hJq/CHCjaHDoSkoLGxU99/fxgmxHOQRJioxY/rKfZCTkZsuIvaGBdDfMjRA1aFFBscQtV+7dcP+KUy4dc3IcRS8PJIhZIOOg7AyuzBYMXNfNWrkEPLW/akYpkIGPYClZkzWfaEkUA+hwuFVGUGvCyRIMzSOCQ3OTMEnAOUkx2sPU6O2sIQrnxejGPP8sgtILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eIefEDiuQIPaH3SMKKiDYTcivOvo2QCzAJf1/5iDkg=;
 b=ecDyStwWRSAhZTFgHH+hICwOo5mq1TCxPP9Kt3aPz0vVDL+Cqkd+2zuPrK0+51wZUpQlpZJL2j4HNVOLKHPes3eHwwkJmAz9nX2ExFlGmfKat//TCEnWrFnVv8iBtAuNeJ4qBtokP5iv+HZIDRYRNrCy/Sk13pVeA1R0IkYq2ZKO5pig/szKD4tav/bWbLwIBsevdmlY4tqwRsN/Rzy74DI9+4os8N6upbqNpUB3o9G3GRHV84H7WYk6eNCmgOvU7L9JxijbPXldfpVdAI4vYRguKmKcVmAz/J0KIH85N9XgboWK8dZmyTOznYWgF00DiiHB8PJH6oqWxsXKzKJgfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by CHAPR12MB999224.namprd12.prod.outlook.com (2603:10b6:610:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 12:23:40 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 12:23:39 +0000
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
Subject: [PATCH v3 3/3] ACPI: APEI: GHES: Add Grace and Vera KUnit coverage
Date: Tue,  4 Aug 2026 20:23:17 +0800
Message-ID: <20260804122318.88193-4-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804122318.88193-1-kaihengf@nvidia.com>
References: <20260724122054.36162-1-kaihengf@nvidia.com>
 <20260804122318.88193-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::18) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|CHAPR12MB999224:EE_
X-MS-Office365-Filtering-Correlation-Id: 141e99c1-e50d-417e-b09d-08def22336d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003|3023799007|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	o1Va1Kk6+VJDDNZSxl9qLH2wfjRYXaoimFU07gfSllwaF7x2ge9mWuVfcr9KOuL03xowVYVq9pynwCb0InufRFuuvGunVTCNPhD3LvEpK5PUpjXmppTJdD7WO0cmQK5v5HqzgPgQuc8d6+zr3lCAjGC34l+SFTmbLBpDww8esk/Xqsi9wPWKDl1OZvJ9pKftc7loW6MUYDuc64sUkEVYg854lQWuK44dmG3QIR1AITgEUMofsz7WnlXQjxd0CtZuM3ll9H2gN/cThy50c6vRAeBKaMJceQYpOSwsDeV5YtrA7yiTcMo7HxSrldsQiQO9PgUuvfb9HkMEvuMmE6HDoDUcPe2P6mjsCSI6BvbRHKVokSrjASP+bWP5DQrcXFO+rGbTNAHOuosfUJgdnylvaImwdUSUzeBum5PKlfewcqpZaHXuywohAp7DryTlr+wzWXLwS9Rdz6I7gwJw632mcnzju/jbnKw0Rd/nl4ZFkGZ3WMFuL2S5/k2u0R2K8AxkHqVcA59Zb8A8fLo2KKGTlJ568JfwnxSu31BCB+MdAc6/P5V8ERNACOpuqP2lomr/KusaiPXjYDIpLEticJfOkacz8HY/VP1Mhv+cfhi1copcI5aDKNnUIbqtH45fuVoRg83WXPR6OYCInK7OxLL3JtFIlsJNUx3n2hUkIYEqWMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(3023799007)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s7OlX8rqVIWNGcdPc1+/Exnqf+DSNo/jFJ+ueEZwnHheK0VQnza9BWJChst8?=
 =?us-ascii?Q?rtbkdhsZ/9OtmkmO5IPJjQ+nOmqOUnf7GzwPMlhlleSPTRUX0hbCpl6vw+wH?=
 =?us-ascii?Q?4r6F0oLXWgAGtoImDOERY1l91+q/k3iO4vkOFxtMR/mB4SVWLTuw9QU5y2IT?=
 =?us-ascii?Q?1nwxEE8/PxwZbpJ7QkcCtQSn0r52zYSGHpAFk9PDAejGViMKjMXLX9GSxgsD?=
 =?us-ascii?Q?ODj5L5XxH/WXL02xYwKCupy3W9YIcsExK4D8kkvd3WZzPrEQ/xQZ/yUUFU+g?=
 =?us-ascii?Q?g7Hnk/CGRijiU3LXB7yPLzb7BUGSuK4It8aryqXRS2oLOfXczYDqbmaT+uBu?=
 =?us-ascii?Q?8Y3bu4ariVB2fqrO17LVwHDXjZGcwam4xV4i2eEu4GMQcJ7EF2u/Jmep827/?=
 =?us-ascii?Q?iwxQXDCYrAEg9j+0cLtagsiPGvp2zTcoFiTv2BWT9eWqzxxgl/hfykRyC2AR?=
 =?us-ascii?Q?KPJK1IalIZGek2O3a8YsYEcqH+r89sVopVP8+7mOsKMNgBtGBNUOhWp0iAyW?=
 =?us-ascii?Q?W5+5AshJaQ3ABYfv+kZym47cos9g4MutyQjCrBzpNPvAbFjprxAHxF5CVYvT?=
 =?us-ascii?Q?4P/QvXOzydoiW2T/1JvfJVS9eKDneJWcvy6/bMwGqjeVr3/lYsrY9UEBIGzq?=
 =?us-ascii?Q?8KP6aF7nx1QEQseUoS4bGN+GQWHs5IFa5HccaHS8w3nZW/SNXLN75TaUf+kH?=
 =?us-ascii?Q?ZWhneKJyF5rBmuKc3aa3D15UAYRAG2J5K4wizamjiKe2wD9reJXNAAwW6ffh?=
 =?us-ascii?Q?qfjnvwJVGaYs5eQlmX1Ja6igsNR+4SFSej6adaHuasyeqNKugx2w54ZR8LID?=
 =?us-ascii?Q?BJxA+9Nq614P34cZFNGpQHHUsNQ4opiGHHsJ0B8f6HiqvOKOZ0dXfTI2l3ge?=
 =?us-ascii?Q?mEdqs9hBbgh1X/rwxR6DxPyA781cWf//U3eOJaWvzFKULtULWKfhh5+B/Gc9?=
 =?us-ascii?Q?BMtJswBzhoVy0x7PEC95mVlOPXyqVStcvGUJ1aF6pGjZt25WMxcvnr4KlOo1?=
 =?us-ascii?Q?bmu/8bRiMD7wvABL7iT6PQv2+1s5u4qmaDv/n4NV47/LIsVGdDTjyJ0QVdTx?=
 =?us-ascii?Q?MkBQWNVo2enaPjLsIuUhZWFCZCZqrUF0jKHk5cEao/TlJbemaCZtZaEBQFJ9?=
 =?us-ascii?Q?IexIgJwOyYltpUGavpWh1sgDi+3hb5czH1NJUTxNkWUqVmd7xu1Jaaz2b3u2?=
 =?us-ascii?Q?ZH/jqjC65sgvyfUuw6Sr9B3ymu2LWiu0DJukz9A/sMHjnSztYtlVNDAk7DjG?=
 =?us-ascii?Q?FuAy86MZox/a8jvz8daNAK/bipC9UpycgjfLRLVr1kfIu5OR2wEaypUgM5bW?=
 =?us-ascii?Q?XDmy4IzRMdmb91O8PkyVZJy8eOSxTdv7ns0vzHTC4NQgV7cGoDzekncclUa1?=
 =?us-ascii?Q?x7XKdrIuq3h0vtRjln7Iga/hdVaOouaES6TZ/SdEE/eE4hmmo6RtEUnU2OIW?=
 =?us-ascii?Q?a5+z0GEQ3LOZAHZuBX/d9kgwxoGIuqbmN1Bab9OReiaDuD2qypY69Y3HmIot?=
 =?us-ascii?Q?c4E9V+sAJk8rPXRdnylOwMlhmOu8u8Fz+4BlcmvGfAiyDpV7iBOhdpJnc4JD?=
 =?us-ascii?Q?B8y/eQPBtaMktCX/V/eG6RYBXEfHF85iw8Fij0XDLEehsj2bhmRipGczQbjg?=
 =?us-ascii?Q?glk5dAmpOhYCVHGYZwI3DMgw4J3BZ8RacLR9Ci8HYLAP2bhunqd1EbfJKzyj?=
 =?us-ascii?Q?A0LA3j/15Yms11TBRYBP96LqU2XihQySfmcvKgocBpwQQP7UWV3VePbmuv2Z?=
 =?us-ascii?Q?xmRIfDGoyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141e99c1-e50d-417e-b09d-08def22336d8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:23:39.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqvCyIQeUTqb0uQtne4y0DAuGN7Dq2H1GFpMRAtdpEybE7sYlvIj5M3Qt28mlnkzf+MIIXUE+NUevrxD9f0XMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999224

Verify the Grace and Vera decoders against binary records captured from
firmware and synthetic records for contract boundaries. Cover successful
decoding, malformed inputs, unaligned Grace payloads, accessors, and GUID
routing.

Exercise Vera CtxSize alignment, padding traversal into the next context,
section bounds, retained contexts before a later failure, and the legacy
format-0 header-only encoding. Verify that the 32-entry print budget is
shared across the complete Vera section.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

---

v3:
 - Add unaligned Grace decode and grace_reg_pair coverage.
 - Cover aligned Vera padding, next-context traversal, bounds, retained
   contexts before failure, and the legacy opaque encoding.
 - Exercise driver-exported Vera accessors rather than test-only copies.
 - Reject accessor inputs with positive data size and no backing data.
 - Verify section-wide print-budget accounting.
 - Document the ACPI-capable kunit.py invocation.
 - Keep EINJ firmware validation in ras-tools.
---
 drivers/acpi/apei/Kconfig                     |   20 +
 drivers/acpi/apei/Makefile                    |    1 +
 drivers/acpi/apei/ghes-nvidia-test-fixtures.h |  233 +++
 drivers/acpi/apei/ghes-nvidia-test.c          | 1274 +++++++++++++++++
 4 files changed, 1528 insertions(+)
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test-fixtures.h
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test.c

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 2dcea74c1677..3374b4f0aa6e 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -88,6 +88,26 @@ config ACPI_APEI_GHES_NVIDIA
 
 	  If unsure, say N.
 
+config ACPI_APEI_GHES_NVIDIA_KUNIT_TEST
+	tristate "NVIDIA GHES vendor record handler KUnit tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT && ACPI_APEI_GHES_NVIDIA
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for NVIDIA GHES vendor CPER parser helpers.
+	  They cover Grace helper decoding, Vera context parsing/accessors,
+	  and GUID section routing.
+	  They are enabled only for KUnit test builds.
+	  They are not intended for production firmware paths.
+
+	  Run with an ACPI-capable architecture, e.g.:
+	  tools/testing/kunit/kunit.py run --arch=x86_64 \
+	    --kconfig_add CONFIG_ACPI=y --kconfig_add CONFIG_ACPI_APEI=y \
+	    --kconfig_add CONFIG_ACPI_APEI_GHES=y \
+	    --kconfig_add CONFIG_ACPI_APEI_GHES_NVIDIA=y \
+	    --kconfig_add CONFIG_ACPI_APEI_GHES_NVIDIA_KUNIT_TEST=y
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
index 000000000000..38eacdaafff9
--- /dev/null
+++ b/drivers/acpi/apei/ghes-nvidia-test.c
@@ -0,0 +1,1274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+#include <linux/align.h>
+#include <linux/errno.h>
+#include <linux/limits.h>
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
+	KUNIT_ASSERT_EQ(test, 0,
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
+static void nvidia_ghes_grace_decodes_unaligned_payload(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+	u64 addr, val;
+
+	buf = kunit_kzalloc(test, sizeof(grace_valid_two_regs) + 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	memcpy(buf + 1, grace_valid_two_regs, sizeof(grace_valid_two_regs));
+
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_decode_grace(NULL, buf + 1,
+						 sizeof(grace_valid_two_regs),
+						 &decoded));
+	KUNIT_EXPECT_EQ(test, 0x1234, decoded.error_type);
+	KUNIT_EXPECT_EQ(test, 0x0102030405060708ULL, decoded.instance_base);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_grace_reg_pair(&decoded, 0, &addr, &val));
+	KUNIT_EXPECT_EQ(test, 0x1000ULL, addr);
+	KUNIT_EXPECT_EQ(test, 0x1111ULL, val);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_grace_reg_pair(&decoded, 1, &addr, &val));
+	KUNIT_EXPECT_EQ(test, 0x2000ULL, addr);
+	KUNIT_EXPECT_EQ(test, 0x2222ULL, val);
+}
+
+static void nvidia_ghes_grace_accepts_zero_registers(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+
+	KUNIT_ASSERT_EQ(test, 0,
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
+	KUNIT_ASSERT_EQ(test, 0,
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
+struct vera_synth_context {
+	u32 context_size;
+	u16 context_version;
+	u16 format;
+	u16 data_format_version;
+	const u8 *data;
+	u32 data_size;
+};
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
+static u8 *vera_make_synthetic_contexts(struct kunit *test, u8 version, u8 info_size,
+					const struct vera_synth_context *contexts,
+					u8 count, size_t *len)
+{
+	u8 *buf;
+	size_t offset;
+	u8 i;
+
+	KUNIT_ASSERT_TRUE(test, info_size >= VERA_CPU_INFO_SIZE);
+	*len = VERA_EVENT_HDR_SIZE + info_size;
+	for (i = 0; i < count; i++) {
+		u32 context_size = contexts[i].context_size;
+		u32 payload;
+
+		KUNIT_ASSERT_TRUE(test, context_size >= VERA_CONTEXT_HDR_SIZE);
+		if (context_size == VERA_CONTEXT_HDR_SIZE)
+			payload = contexts[i].data_size;
+		else
+			payload = context_size - VERA_CONTEXT_HDR_SIZE;
+		*len += VERA_CONTEXT_HDR_SIZE + payload;
+	}
+
+	buf = kunit_kzalloc(test, *len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+
+	buf[0] = version;
+	buf[1] = count;
+	buf[2] = 0;
+	put_unaligned_le16(0x22, &buf[4]);
+	memcpy(&buf[16], "SYNTH", 5);
+	put_unaligned_le16(0, &buf[32]);
+	buf[34] = info_size;
+	buf[35] = 0;
+	put_unaligned_le32(0x14107, &buf[36]);
+	memcpy(&buf[40], vera_chip_serial, sizeof(vera_chip_serial));
+	put_unaligned_le64(0, &buf[56]);
+
+	offset = VERA_EVENT_HDR_SIZE + info_size;
+	for (i = 0; i < count; i++) {
+		u32 context_size = contexts[i].context_size;
+		u32 payload;
+
+		put_unaligned_le32(context_size, &buf[offset]);
+		put_unaligned_le16(contexts[i].context_version,
+				   &buf[offset + 4]);
+		put_unaligned_le16(contexts[i].format, &buf[offset + 8]);
+		put_unaligned_le16(contexts[i].data_format_version,
+				   &buf[offset + 10]);
+		put_unaligned_le32(contexts[i].data_size, &buf[offset + 12]);
+		if (contexts[i].data && contexts[i].data_size)
+			memcpy(&buf[offset + VERA_CONTEXT_HDR_SIZE],
+			       contexts[i].data, contexts[i].data_size);
+
+		if (context_size == VERA_CONTEXT_HDR_SIZE)
+			payload = contexts[i].data_size;
+		else
+			payload = context_size - VERA_CONTEXT_HDR_SIZE;
+		offset += VERA_CONTEXT_HDR_SIZE + payload;
+	}
+
+	return buf;
+}
+
+static u8 *vera_make_synthetic(struct kunit *test, u8 version, u8 info_size,
+			       u16 format, const u8 *data, u32 data_size,
+			       size_t *len)
+{
+	struct vera_synth_context ctx = {
+		.context_size = format == 0 ? VERA_CONTEXT_HDR_SIZE :
+			ALIGN(VERA_CONTEXT_HDR_SIZE + data_size, 16),
+		.format = format,
+		.data = data,
+		.data_size = data_size,
+	};
+
+	return vera_make_synthetic_contexts(test, version, info_size, &ctx, 1, len);
+}
+
+static u8 *vera_make_synthetic_default(struct kunit *test, u16 format,
+				       const u8 *data, u32 data_size, size_t *len)
+{
+	return vera_make_synthetic(test, 1, VERA_CPU_INFO_SIZE, format, data,
+				   data_size, len);
+}
+
+static int vera_context_at(const struct nvidia_ghes_decoded *decoded,
+			   unsigned int index,
+			   struct nvidia_ghes_vera_context *context)
+{
+	struct nvidia_ghes_vera_cursor cursor;
+	int ret;
+
+	nvidia_ghes_vera_cursor_init(decoded, &cursor);
+	for (unsigned int i = 0; i <= index; i++) {
+		ret = nvidia_ghes_vera_cursor_next(&cursor, context);
+		if (ret != 1)
+			return ret ?: -ERANGE;
+	}
+
+	return 0;
+}
+
+static void nvidia_ghes_vera_decodes_l1_reset(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context context;
+
+	KUNIT_ASSERT_EQ(test, 0,
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
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &context));
+	KUNIT_EXPECT_EQ(test, 16U, context.context_size);
+	KUNIT_EXPECT_EQ(test, 1, context.data_format_type);
+	KUNIT_EXPECT_EQ(test, 0U, context.data_size);
+}
+
+static void nvidia_ghes_vera_decodes_crashdump_id(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context context;
+	u64 key, val;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, vera_crashdump_id_id40,
+						sizeof(vera_crashdump_id_id40),
+						&decoded));
+	KUNIT_EXPECT_STREQ(test, "CRASHDUMP-ID", decoded.signature);
+	KUNIT_EXPECT_MEMEQ(test, decoded.chip_serial_number, vera_chip_serial,
+			   sizeof(vera_chip_serial));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &context));
+	KUNIT_EXPECT_EQ(test, 240U, context.context_size);
+	KUNIT_EXPECT_EQ(test, 1, context.data_format_type);
+	KUNIT_EXPECT_EQ(test, 224U, context.data_size);
+	KUNIT_ASSERT_EQ(test, 14, nvidia_ghes_vera_context_entry_count(&context));
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u64_pair(&context, 0, &key, &val));
+	KUNIT_EXPECT_EQ(test, 0x8300000000000000ULL, key);
+	KUNIT_EXPECT_EQ(test, 0x372e33375f6c6572ULL, val);
+}
+
+static void nvidia_ghes_vera_decodes_crashdump_s1_opaque_context(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context context;
+	u64 val;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, vera_crashdump_s1_id41,
+						sizeof(vera_crashdump_s1_id41),
+						&decoded));
+	KUNIT_EXPECT_STREQ(test, "CRASHDUMP-S1", decoded.signature);
+	KUNIT_EXPECT_EQ(test, 4096, decoded.event_type);
+	KUNIT_EXPECT_EQ(test, 2304, decoded.event_sub_type);
+	KUNIT_EXPECT_MEMEQ(test, decoded.chip_serial_number, vera_chip_serial,
+			   sizeof(vera_chip_serial));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &context));
+	KUNIT_EXPECT_EQ(test, 16U, context.context_size);
+	KUNIT_EXPECT_EQ(test, 0, context.data_format_type);
+	KUNIT_EXPECT_EQ(test, 1928U, context.data_size);
+	KUNIT_ASSERT_NOT_NULL(test, context.data);
+	KUNIT_EXPECT_EQ(test, 0x53, context.data[0]);
+	KUNIT_EXPECT_EQ(test, 0x56, context.data[1]);
+	KUNIT_EXPECT_EQ(test, 0x7f, context.data[2]);
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_vera_context_u64_value(&context, 0, &val));
+}
+
+static void nvidia_ghes_vera_decodes_multi_context_aligned(struct kunit *test)
+{
+	static const u8 first_data[] = {
+		0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+	};
+	static const u8 second_data[] = {
+		0xa0, 0xb0, 0xc0, 0xd0,
+	};
+	struct vera_synth_context contexts[] = {
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + 16,
+			.format = 3,
+			.data = first_data,
+			.data_size = sizeof(first_data),
+		},
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + 16,
+			.format = 4,
+			.data = second_data,
+			.data_size = sizeof(second_data),
+		},
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context parsed[2];
+	size_t len;
+	u8 *buf;
+	u64 val64;
+	u32 val32;
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE, contexts,
+					   ARRAY_SIZE(contexts), &len);
+	KUNIT_ASSERT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 2, decoded.event_context_count);
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &parsed[0]));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 1, &parsed[1]));
+	KUNIT_EXPECT_EQ(test, VERA_CONTEXT_HDR_SIZE + 16,
+			parsed[0].context_size);
+	KUNIT_EXPECT_EQ(test, 3, parsed[0].data_format_type);
+	KUNIT_EXPECT_EQ(test, sizeof(first_data), parsed[0].data_size);
+	KUNIT_ASSERT_NOT_NULL(test, parsed[0].data);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u64_value(&parsed[0], 0, &val64));
+	KUNIT_EXPECT_EQ(test, 0x8877665544332211ULL, val64);
+	KUNIT_EXPECT_EQ(test, VERA_CONTEXT_HDR_SIZE + 16,
+			parsed[1].context_size);
+	KUNIT_EXPECT_EQ(test, 4, parsed[1].data_format_type);
+	KUNIT_EXPECT_EQ(test, sizeof(second_data), parsed[1].data_size);
+	KUNIT_ASSERT_NOT_NULL(test, parsed[1].data);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u32_value(&parsed[1], 0, &val32));
+	KUNIT_EXPECT_EQ(test, 0xd0c0b0a0U, val32);
+}
+
+static void nvidia_ghes_vera_decodes_multi_context_covering_first(struct kunit *test)
+{
+	static const u8 first_data[] = {
+		0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+		0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x00,
+	};
+	static const u8 second_data[] = {
+		0xa0, 0xb0, 0xc0, 0xd0,
+	};
+	struct vera_synth_context contexts[] = {
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + sizeof(first_data),
+			.format = 1,
+			.data = first_data,
+			.data_size = sizeof(first_data),
+		},
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + 16,
+			.format = 4,
+			.data = second_data,
+			.data_size = sizeof(second_data),
+		},
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context parsed[2];
+	size_t len;
+	u8 *buf;
+	u64 key, val;
+	u32 val32;
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE, contexts,
+					   ARRAY_SIZE(contexts), &len);
+	KUNIT_ASSERT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 2, decoded.event_context_count);
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &parsed[0]));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 1, &parsed[1]));
+	KUNIT_EXPECT_EQ(test, VERA_CONTEXT_HDR_SIZE + sizeof(first_data),
+			parsed[0].context_size);
+	KUNIT_EXPECT_EQ(test, 1, parsed[0].data_format_type);
+	KUNIT_EXPECT_EQ(test, sizeof(first_data), parsed[0].data_size);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u64_pair(&parsed[0], 0, &key, &val));
+	KUNIT_EXPECT_EQ(test, 0x8877665544332211ULL, key);
+	KUNIT_EXPECT_EQ(test, 0x00ffeeddccbbaa99ULL, val);
+	KUNIT_EXPECT_EQ(test, VERA_CONTEXT_HDR_SIZE + 16,
+			parsed[1].context_size);
+	KUNIT_EXPECT_EQ(test, 4, parsed[1].data_format_type);
+	KUNIT_EXPECT_EQ(test, sizeof(second_data), parsed[1].data_size);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u32_value(&parsed[1], 0, &val32));
+	KUNIT_EXPECT_EQ(test, 0xd0c0b0a0U, val32);
+}
+
+static void nvidia_ghes_vera_decodes_format2_u32_pairs(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x78, 0x56, 0x34, 0x12, 0xf0, 0xde, 0xbc, 0x9a,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context context;
+	size_t len;
+	u8 *buf;
+	u32 key, val;
+
+	buf = vera_make_synthetic_default(test, 2, data, sizeof(data), &len);
+	KUNIT_ASSERT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &context));
+	KUNIT_ASSERT_EQ(test, 1, nvidia_ghes_vera_context_entry_count(&context));
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u32_pair(&context, 0, &key, &val));
+	KUNIT_EXPECT_EQ(test, 0x12345678U, key);
+	KUNIT_EXPECT_EQ(test, 0x9abcdef0U, val);
+}
+
+static void nvidia_ghes_vera_decodes_format3_u64_values(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context context;
+	size_t len;
+	u8 *buf;
+	u64 val;
+
+	buf = vera_make_synthetic_default(test, 3, data, sizeof(data), &len);
+	KUNIT_ASSERT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &context));
+	KUNIT_ASSERT_EQ(test, 1, nvidia_ghes_vera_context_entry_count(&context));
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u64_value(&context, 0, &val));
+	KUNIT_EXPECT_EQ(test, 0x0102030405060708ULL, val);
+}
+
+static void nvidia_ghes_vera_decodes_format4_u32_values(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x78, 0x56, 0x34, 0x12,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context context;
+	size_t len;
+	u8 *buf;
+	u32 val;
+
+	buf = vera_make_synthetic_default(test, 4, data, sizeof(data), &len);
+	KUNIT_ASSERT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &context));
+	KUNIT_ASSERT_EQ(test, 1, nvidia_ghes_vera_context_entry_count(&context));
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u32_value(&context, 0, &val));
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
+static void nvidia_ghes_vera_rejects_unsupported_info_major_version(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+	int ret;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_l1_reset_id10,
+				       sizeof(vera_l1_reset_id10));
+	put_unaligned_le16(0x0100, &buf[VERA_EVENT_HDR_SIZE]);
+
+	ret = nvidia_ghes_decode_vera(NULL, buf, sizeof(vera_l1_reset_id10),
+				      &decoded);
+	KUNIT_EXPECT_EQ(test, -EOPNOTSUPP, ret);
+}
+
+static void nvidia_ghes_vera_accepts_newer_info_minor_version(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {};
+	u8 *buf;
+
+	buf = nvidia_ghes_kunit_memdup(test, vera_l1_reset_id10,
+				       sizeof(vera_l1_reset_id10));
+	put_unaligned_le16(0x00ff, &buf[VERA_EVENT_HDR_SIZE]);
+
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, buf,
+						sizeof(vera_l1_reset_id10), &decoded));
+}
+
+static void nvidia_ghes_vera_accepts_extended_cpu_info(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context context;
+	size_t len;
+	u8 *buf;
+	u64 val;
+
+	buf = vera_make_synthetic(test, 1, VERA_CPU_INFO_SIZE + 4, 3,
+				  data, sizeof(data), &len);
+	KUNIT_ASSERT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &context));
+	KUNIT_EXPECT_EQ(test, VERA_CONTEXT_HDR_SIZE + 16,
+			context.context_size);
+	KUNIT_EXPECT_EQ(test, 3, context.data_format_type);
+	KUNIT_EXPECT_EQ(test, 8U, context.data_size);
+	KUNIT_EXPECT_EQ(test, 1, nvidia_ghes_vera_context_entry_count(&context));
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_context_u64_value(&context, 0, &val));
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
+static void nvidia_ghes_vera_rejects_data_size_exceeding_context_size(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+
+	buf = vera_make_synthetic_default(test, 3, data, sizeof(data), &len);
+	put_unaligned_le32(VERA_CONTEXT_HDR_SIZE,
+			   &buf[VERA_FIRST_CONTEXT_OFFSET]);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+}
+
+static void nvidia_ghes_vera_rejects_unaligned_context_size(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+
+	buf = vera_make_synthetic_default(test, 3, data, sizeof(data), &len);
+	put_unaligned_le32(VERA_CONTEXT_HDR_SIZE + sizeof(data),
+			   &buf[VERA_FIRST_CONTEXT_OFFSET]);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+}
+
+static void nvidia_ghes_vera_accepts_padded_context_size(struct kunit *test)
+{
+	static const u8 first_data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	static const u8 second_data[] = {
+		0x78, 0x56, 0x34, 0x12,
+	};
+	struct vera_synth_context contexts[] = {
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + 16,
+			.format = 3,
+			.data = first_data,
+			.data_size = sizeof(first_data),
+		},
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + 16,
+			.format = 4,
+			.data = second_data,
+			.data_size = sizeof(second_data),
+		},
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context parsed[2];
+	size_t len;
+	u8 *buf;
+	u32 val;
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE, contexts,
+					   ARRAY_SIZE(contexts), &len);
+	KUNIT_ASSERT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 2, decoded.event_context_count);
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &parsed[0]));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 1, &parsed[1]));
+	KUNIT_EXPECT_EQ(test, VERA_CONTEXT_HDR_SIZE + 16,
+			parsed[0].context_size);
+	KUNIT_EXPECT_EQ(test, sizeof(first_data), parsed[0].data_size);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u32_value(&parsed[1], 0, &val));
+	KUNIT_EXPECT_EQ(test, 0x12345678U, val);
+}
+
+static void nvidia_ghes_vera_rejects_context_beyond_section(struct kunit *test)
+{
+	static const u8 data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+
+	buf = vera_make_synthetic_default(test, 3, data, sizeof(data), &len);
+	KUNIT_EXPECT_EQ(test, -ENODATA,
+			nvidia_ghes_decode_vera(NULL, buf, len - 8, &decoded));
+}
+
+static void nvidia_ghes_vera_preserves_legacy_opaque_advance(struct kunit *test)
+{
+	static const u8 opaque_data[] = { 0xaa, 0xbb, 0xcc };
+	static const u8 value_data[] = { 0x78, 0x56, 0x34, 0x12 };
+	struct vera_synth_context contexts[] = {
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE,
+			.format = 0,
+			.data = opaque_data,
+			.data_size = sizeof(opaque_data),
+		},
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + 16,
+			.format = 4,
+			.data = value_data,
+			.data_size = sizeof(value_data),
+		},
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context parsed[2];
+	size_t len;
+	u8 *buf;
+	u32 val;
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE, contexts,
+					   ARRAY_SIZE(contexts), &len);
+	KUNIT_ASSERT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 2, decoded.event_context_count);
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &parsed[0]));
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 1, &parsed[1]));
+	KUNIT_EXPECT_EQ(test, sizeof(opaque_data), parsed[0].data_size);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u32_value(&parsed[1], 0, &val));
+	KUNIT_EXPECT_EQ(test, 0x12345678U, val);
+}
+
+static void nvidia_ghes_vera_retains_contexts_before_failure(struct kunit *test)
+{
+	static const u8 first_data[] = { 0x78, 0x56, 0x34, 0x12 };
+	static const u8 second_data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct vera_synth_context contexts[] = {
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + 16,
+			.format = 4,
+			.data = first_data,
+			.data_size = sizeof(first_data),
+		},
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + 16,
+			.format = 3,
+			.data = second_data,
+			.data_size = sizeof(second_data),
+		},
+	};
+	struct nvidia_ghes_decoded decoded = {};
+	struct nvidia_ghes_vera_context context;
+	size_t second_offset = VERA_FIRST_CONTEXT_OFFSET + contexts[0].context_size;
+	size_t len;
+	u8 *buf;
+	u32 val;
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE, contexts,
+					   ARRAY_SIZE(contexts), &len);
+	put_unaligned_le32(VERA_CONTEXT_HDR_SIZE + sizeof(second_data),
+			   &buf[second_offset]);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 2, decoded.event_context_count);
+	KUNIT_EXPECT_EQ(test, 1, decoded.valid_context_count);
+	KUNIT_ASSERT_EQ(test, 0, vera_context_at(&decoded, 0, &context));
+	KUNIT_EXPECT_EQ(test, sizeof(first_data), context.data_size);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_vera_context_u32_value(&context, 0, &val));
+	KUNIT_EXPECT_EQ(test, 0x12345678U, val);
+}
+
+static void nvidia_ghes_vera_accepts_all_wire_contexts(struct kunit *test)
+{
+	struct nvidia_ghes_vera_cursor cursor;
+	struct nvidia_ghes_vera_context context;
+	struct vera_synth_context *contexts;
+	struct nvidia_ghes_decoded decoded = {};
+	static const u8 empty;
+	size_t len;
+	u8 *buf;
+	int i;
+
+	contexts = kunit_kcalloc(test, U8_MAX, sizeof(*contexts), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, contexts);
+	for (i = 0; i < U8_MAX; i++) {
+		contexts[i].context_size = VERA_CONTEXT_HDR_SIZE;
+		contexts[i].format = 0;
+		contexts[i].data = &empty;
+		contexts[i].data_size = 0;
+	}
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE, contexts,
+					   U8_MAX, &len);
+	KUNIT_ASSERT_EQ(test, 0, nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, U8_MAX, decoded.event_context_count);
+	KUNIT_EXPECT_EQ(test, U8_MAX, decoded.valid_context_count);
+
+	nvidia_ghes_vera_cursor_init(&decoded, &cursor);
+	for (i = 0; i < U8_MAX; i++)
+		KUNIT_ASSERT_EQ(test, 1,
+				nvidia_ghes_vera_cursor_next(&cursor, &context));
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_cursor_next(&cursor, &context));
+	KUNIT_EXPECT_EQ(test, 16,
+			nvidia_ghes_vera_print_context_count(&decoded));
+}
+
+static void nvidia_ghes_vera_accepts_zero_contexts(struct kunit *test)
+{
+	struct nvidia_ghes_vera_cursor cursor;
+	struct nvidia_ghes_vera_context context;
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE, NULL, 0,
+					   &len);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 0, decoded.event_context_count);
+	KUNIT_EXPECT_EQ(test, 0, decoded.valid_context_count);
+	nvidia_ghes_vera_cursor_init(&decoded, &cursor);
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_cursor_next(&cursor, &context));
+}
+
+static void nvidia_ghes_vera_accepts_seventeen_contexts(struct kunit *test)
+{
+	struct nvidia_ghes_vera_cursor cursor;
+	struct nvidia_ghes_vera_context context;
+	struct vera_synth_context *contexts;
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *buf;
+	int i;
+
+	contexts = kunit_kcalloc(test, 17, sizeof(*contexts), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, contexts);
+	for (i = 0; i < 17; i++)
+		contexts[i].context_size = VERA_CONTEXT_HDR_SIZE;
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE, contexts,
+					   17, &len);
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 17, decoded.event_context_count);
+	KUNIT_EXPECT_EQ(test, 17, decoded.valid_context_count);
+	nvidia_ghes_vera_cursor_init(&decoded, &cursor);
+	for (i = 0; i < 17; i++)
+		KUNIT_ASSERT_EQ(test, 1,
+				nvidia_ghes_vera_cursor_next(&cursor, &context));
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_cursor_next(&cursor, &context));
+}
+
+static void nvidia_ghes_vera_accepts_schema_extensions_together(struct kunit *test)
+{
+	static const u8 first_data[] = {
+		0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+	};
+	struct vera_synth_context contexts[] = {
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE + 16,
+			.context_version = 2,
+			.format = 3,
+			.data_format_version = 3,
+			.data = first_data,
+			.data_size = sizeof(first_data),
+		},
+		{
+			.context_size = VERA_CONTEXT_HDR_SIZE,
+			.context_version = 4,
+			.format = 0,
+			.data_format_version = 5,
+		},
+	};
+	struct nvidia_ghes_vera_cursor cursor;
+	struct nvidia_ghes_vera_context context;
+	struct nvidia_ghes_decoded decoded = {};
+	size_t len;
+	u8 *section;
+	u8 *buf;
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE + 4,
+					   contexts, ARRAY_SIZE(contexts),
+					   &len);
+	put_unaligned_le16(0x00ff, &buf[VERA_EVENT_HDR_SIZE]);
+	section = kunit_kzalloc(test, len + 7, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, section);
+	memcpy(section, buf, len);
+
+	KUNIT_ASSERT_EQ(test, 0,
+			nvidia_ghes_decode_vera(NULL, section, len + 7, &decoded));
+	KUNIT_EXPECT_EQ(test, 2, decoded.event_context_count);
+	KUNIT_EXPECT_EQ(test, 2, decoded.valid_context_count);
+	nvidia_ghes_vera_cursor_init(&decoded, &cursor);
+	KUNIT_ASSERT_EQ(test, 1,
+			nvidia_ghes_vera_cursor_next(&cursor, &context));
+	KUNIT_EXPECT_EQ(test, 2, context.context_version);
+	KUNIT_EXPECT_EQ(test, 3, context.data_format_version);
+	KUNIT_ASSERT_EQ(test, 1,
+			nvidia_ghes_vera_cursor_next(&cursor, &context));
+	KUNIT_EXPECT_EQ(test, 4, context.context_version);
+	KUNIT_EXPECT_EQ(test, 5, context.data_format_version);
+	KUNIT_EXPECT_EQ(test, 7, cursor.remaining);
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_cursor_next(&cursor, &context));
+}
+
+static void nvidia_ghes_vera_retains_large_valid_prefix(struct kunit *test)
+{
+	struct nvidia_ghes_vera_cursor cursor;
+	struct nvidia_ghes_vera_context context;
+	struct vera_synth_context *contexts;
+	struct nvidia_ghes_decoded decoded = {};
+	static const u8 empty;
+	size_t bad_offset;
+	size_t len;
+	u8 *buf;
+	int i;
+
+	contexts = kunit_kcalloc(test, 18, sizeof(*contexts), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, contexts);
+	for (i = 0; i < 18; i++) {
+		contexts[i].context_size = VERA_CONTEXT_HDR_SIZE;
+		contexts[i].format = 0;
+		contexts[i].data = &empty;
+	}
+
+	buf = vera_make_synthetic_contexts(test, 1, VERA_CPU_INFO_SIZE, contexts,
+					   18, &len);
+	bad_offset = VERA_FIRST_CONTEXT_OFFSET + 17 * VERA_CONTEXT_HDR_SIZE;
+	put_unaligned_le32(VERA_CONTEXT_HDR_SIZE - 1, &buf[bad_offset]);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_decode_vera(NULL, buf, len, &decoded));
+	KUNIT_EXPECT_EQ(test, 18, decoded.event_context_count);
+	KUNIT_EXPECT_EQ(test, 17, decoded.valid_context_count);
+	KUNIT_EXPECT_EQ(test, 16,
+			nvidia_ghes_vera_print_context_count(&decoded));
+
+	nvidia_ghes_vera_cursor_init(&decoded, &cursor);
+	for (i = 0; i < 17; i++)
+		KUNIT_ASSERT_EQ(test, 1,
+				nvidia_ghes_vera_cursor_next(&cursor, &context));
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_cursor_next(&cursor, &context));
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
+	put_unaligned_le32(24, &buf[VERA_FIRST_CONTEXT_OFFSET + 12]);
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
+			nvidia_ghes_decode_vera(NULL, buf,
+						sizeof(vera_crashdump_id_id40),
+						&decoded));
+}
+
+static void nvidia_ghes_vera_print_budget_is_section_wide(struct kunit *test)
+{
+	static const u8 data;
+	struct nvidia_ghes_vera_context ctx = {
+		.data_format_type = 1,
+		.data_size = 24 * 16,
+		.data = &data,
+	};
+	unsigned int remaining = 32;
+
+	KUNIT_EXPECT_EQ(test, 24,
+			nvidia_ghes_vera_context_print_count(&ctx, &remaining));
+	KUNIT_EXPECT_EQ(test, 8U, remaining);
+	KUNIT_EXPECT_EQ(test, 8,
+			nvidia_ghes_vera_context_print_count(&ctx, &remaining));
+	KUNIT_EXPECT_EQ(test, 0U, remaining);
+	KUNIT_EXPECT_EQ(test, 0,
+			nvidia_ghes_vera_context_print_count(&ctx, &remaining));
+}
+
+static void nvidia_ghes_vera_print_budget_rejects_null_remaining(struct kunit *test)
+{
+	struct nvidia_ghes_vera_context ctx = {};
+
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_vera_context_print_count(&ctx, NULL));
+}
+
+static void nvidia_ghes_vera_accessors_reject_null_data(struct kunit *test)
+{
+	struct nvidia_ghes_vera_context ctx = {
+		.data_size = 16,
+	};
+	u64 key64, val64;
+	u32 key32, val32;
+
+	ctx.data_format_type = 1;
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_vera_context_u64_pair(&ctx, 0, &key64,
+							  &val64));
+	ctx.data_format_type = 2;
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_vera_context_u32_pair(&ctx, 0, &key32,
+							  &val32));
+	ctx.data_format_type = 3;
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_vera_context_u64_value(&ctx, 0, &val64));
+	ctx.data_format_type = 4;
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			nvidia_ghes_vera_context_u32_value(&ctx, 0, &val32));
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
+static void nvidia_ghes_grace_reg_pair_rejects_null_regs(struct kunit *test)
+{
+	struct nvidia_ghes_decoded decoded = {
+		.format = NVIDIA_GHES_FORMAT_GRACE,
+		.number_regs = 1,
+		.grace_regs = NULL,
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
+	KUNIT_CASE(nvidia_ghes_grace_decodes_unaligned_payload),
+	KUNIT_CASE(nvidia_ghes_grace_accepts_zero_registers),
+	KUNIT_CASE(nvidia_ghes_grace_copies_non_nul_signature),
+	KUNIT_CASE(nvidia_ghes_grace_rejects_truncated_header),
+	KUNIT_CASE(nvidia_ghes_grace_rejects_truncated_registers),
+	KUNIT_CASE(nvidia_ghes_grace_reg_pair_rejects_null_decoded),
+	KUNIT_CASE(nvidia_ghes_grace_reg_pair_rejects_wrong_format),
+	KUNIT_CASE(nvidia_ghes_grace_reg_pair_rejects_null_regs),
+	KUNIT_CASE(nvidia_ghes_grace_reg_pair_rejects_out_of_range),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_l1_reset),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_crashdump_id),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_crashdump_s1_opaque_context),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_multi_context_aligned),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_multi_context_covering_first),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_format2_u32_pairs),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_format3_u64_values),
+	KUNIT_CASE(nvidia_ghes_vera_decodes_format4_u32_values),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_truncated_event_header),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_truncated_cpu_info),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_truncated_context_header),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_bad_info_size),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_unsupported_version),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_unsupported_info_major_version),
+	KUNIT_CASE(nvidia_ghes_vera_accepts_newer_info_minor_version),
+	KUNIT_CASE(nvidia_ghes_vera_accepts_extended_cpu_info),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_short_context_size),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_data_size_exceeding_context_size),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_unaligned_context_size),
+	KUNIT_CASE(nvidia_ghes_vera_accepts_padded_context_size),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_context_beyond_section),
+	KUNIT_CASE(nvidia_ghes_vera_preserves_legacy_opaque_advance),
+	KUNIT_CASE(nvidia_ghes_vera_retains_contexts_before_failure),
+	KUNIT_CASE(nvidia_ghes_vera_accepts_all_wire_contexts),
+	KUNIT_CASE(nvidia_ghes_vera_accepts_zero_contexts),
+	KUNIT_CASE(nvidia_ghes_vera_accepts_seventeen_contexts),
+	KUNIT_CASE(nvidia_ghes_vera_accepts_schema_extensions_together),
+	KUNIT_CASE(nvidia_ghes_vera_retains_large_valid_prefix),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_data_beyond_section),
+	KUNIT_CASE(nvidia_ghes_vera_rejects_mis_sized_format1),
+	KUNIT_CASE(nvidia_ghes_vera_print_budget_is_section_wide),
+	KUNIT_CASE(nvidia_ghes_vera_print_budget_rejects_null_remaining),
+	KUNIT_CASE(nvidia_ghes_vera_accessors_reject_null_data),
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
+	.name = "acpi_apei_ghes_nvidia",
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

