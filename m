Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD73C5542;
	Tue, 16 Jun 2026 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581494; cv=fail; b=d8qEHELD0Yekd04BQKT3vvxSsN9ltrKKvh/cEihRh2Z3WFv1bklqamtokx6vTwiyQTEOmVgyxYaW3S3c39Mru6xt9VwylTmPUjiexHpzys88MrmY9yZanCfCn/cxhW4sDc2v8l1MvOIwUuL1p47xaxGeK+xQ2Yw8w657zZQWiQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581494; c=relaxed/simple;
	bh=MBPdsRpd7quP/ogkU5skJ7OU3KxxhWLM0T/bwTbkXE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFG0I/Q3Vwu1NblJEjKRIV6blVtO9/yOGdprVtFDHROT34j1ydp20S+9fVfegpxLNDYMPMKFGOJkg8j4rkrNkjzot3pdc4gq80myyk2f0z7JVlIIshC8bOimzLRo0zfwG8BH0ttVGgslYG63GRgLxsz18NT7BShBS8eymH2cxaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NBZ24Ym4; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NBZ24Ym4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooAYDhBCwIsWNIkJrdJhRC/lcscsi2zQ4db3z+zDOckbJWHtoXfHC/y22gURiTLcFIA3f/9HwmHYjd7rzlhqFuQ3lW9bN8Ekhz1Bs7AYlNjqtdiFfW9vc93SeCw3LZTT5LjN71sH16KNM8ZcV4xQ62m5SsaeFuH1kFqLT29IoypuXsREPRwyrhxVRGDnYprw/pIIh4SVymlnHbGsCaqx50+VIKFqc3HAyWYGc9IQ5krZP8EJuulQHVDyvaC6oU9m81dTiCcy1CcWCtjRRUrQOUf7bC2mKpkcRxJr89MdxO83AzCIHRYCEsYpaZCdoUrSr/2Rx96iqtqoBuX2sfvX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIZpqKBtRJM0qmD5mh81mIrj71QURR3aNlbY0c+c2Eo=;
 b=Zk9oMpJKwqHYvQgZVasJI9Oyk7V5mZwhgx55WvBB30IuetPBVsbINFp0mYa4/Wt8uY0Ryrnm7JIwgY589J+YDv++7tcMkh3pney9lDan6S8xXkeBbItEfg1WmhBphCcF1DcVn4GEGBfm6+NJPiH6IA1vsMuxoTNCr+aqIFECBDEEyGVKkPvL97FMKSmFgVXBkp5Eh0gsLoCodnZfoUS1Q6KHYRJ6WF+9cqngVWVNhfbUAPW/Fxrx82pLsB2xboaZGZueGRhr5fW2ihNcCFSox0yIYIU59INsSVZi5qSTVMFsSsxP+quOYp++ge5nPH0Xbc8y4doN1+buaRVIT3+hEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIZpqKBtRJM0qmD5mh81mIrj71QURR3aNlbY0c+c2Eo=;
 b=NBZ24Ym4Pr/AM8RrEKArpRX96IIEVuOgYsnJiKns5pGW9pNQejRP6GqP27Jt5bxtfiwAJ9wSikLZ9hkDtKzXyCF6tr039RUVpdiGZWvTTOXEi3Z5RAYFs0guOpYAvcYridL/pmvzq/DfMXMP1G5zDr23Dt/KGs5Z6NSkVNf0AkM7p03mLml16uXX+QPtANMuB9WuiBsf3lCcpODT/HG44cKPTVxaZYtnNZg6SBJeB8dOvZGH/V2WPubIaiNO8r7MLX7qZLGE3m0lInXyaZYgqbpC6IJia9LCuS4jop+vGlArBVTEtqRQo8ZiKuTkx0nRDypdwO11znapzA1neCuAgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 03:44:44 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 03:44:44 +0000
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
Subject: [PATCH v2 4/4] selftests: firmware: Add NVIDIA GHES EINJ selftest
Date: Tue, 16 Jun 2026 11:44:10 +0800
Message-ID: <20260616034410.70675-5-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616034410.70675-1-kaihengf@nvidia.com>
References: <20260616034410.70675-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f05d84d-29b7-4453-6e47-08decb599adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	eUl636936pAHHd2ksFrCFlUbnAR5Cph8TvLAAYAUp5eiL/sI5S6TDAkskgetkA1QzydYW71/+UhSYvp1h1yfzovmxVQFrUz1NBF3fFgxsKW6dB6W2T+HWWJdqJwzOY65CfrYHE9lXhNKP5P1i7gm1+Es+/+f2ilNKEArBQnlAVELOae+ipBPUxTBCvW7KZbENh1Io0aiaU0ufcH2WmngCRlQADMtccUoU7VEEi1pRdiXcBw+qlG8uIAA2gC5zh4E/ny1RTLiYpH0kUyHeKU5z5kV9uPk2vvr//XPdU6dhQxF7emwQQwMaw2OLr+Wo2BX76vfrtjZYRtFmeEzUAf8avPFzXKqn87kkkx0FMs0s2KAafFaD4MIFdRTcgDQyzQ/f7ktaayTpfuyct6GPbqBAwIRoQm1FkIKy83A4RMWoIOuhpisVFD46uLRIlHq7qD8elPNGydo1h4kQW3MmlXY5twczAsc44urGO1P8wwjnbxMNdKH2Z03dxGIfit0gXfoqsOvvesgTYwG1teSFrdgnTum8d+HWlxcG63B/azbhUJMSu+P1MtWISUjWGScNObUwMFCX3GLl3JHIYVoKXj4xDy/2SE4+IAKarc8NZWEPYW0y3eHeqlEMu7b/cN7JnxySdE3HcQbFLTsl2PLYHIAUK5losDsiBV00HUoFjvur0Wv8K90LIhA06DFHAXBItny
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m8mCZ4WIb3VM5hP24DoQAhqS6UsGdfpmueuw3Qb2jA1LQXWXzA1PWd4fL+lm?=
 =?us-ascii?Q?kN0Dx87kjytmva7stXsIfqaM59SfepX3qnoAqk0LH2cW14mEi/HXjLKZaQO9?=
 =?us-ascii?Q?+YB2QhplizH8hwf9hUJS9PV7o4epIYXcJO8DX2bLSeu830fvCUkPVNf3KbYA?=
 =?us-ascii?Q?dqpi4+QE+5AwaBqQBD8I0xgdeCsA6/VaeYMuq0ejGaDoss3CjX5xlnJKPCBn?=
 =?us-ascii?Q?9OBHXrI7RSRy5ud2oBy70Puw0erZxhiApbfWxjFkKFSDZPErGzUeeUOZVfTv?=
 =?us-ascii?Q?IHCSfM2Lb6gr9HzKDqkOlIMhnWWMn4RpLA8V+B5Fuz2QTBIh+huyYRvooM+K?=
 =?us-ascii?Q?PGUNVuCVRO7Qg1OeTpl161jYKah3TVvd5hCC31j6OnLGWRb1t7HsW337CE9y?=
 =?us-ascii?Q?k0D5FGhaQQ4BCTULjRyTNdj79LjtKBQTDEB68zCa2P0CFcPIyaO0se4UbYvh?=
 =?us-ascii?Q?ttjbFOR9WGpz4cFJ5WCUFEZz3z7NJmkeJ4jLSDml6FKk/pTYqXespSSAJLW4?=
 =?us-ascii?Q?Vb0jf4+Ld4JAZbTk4X0wlLhykhzns50wVkcl0xU92cpjCqpZ1GcxHHbDhrx3?=
 =?us-ascii?Q?otnFL+Bev2LljfJm8BkGZV4wkcek/OUV3HA649YawIi4UpsHcXCUiKHRed8s?=
 =?us-ascii?Q?cv91sx4Vln8weWDaz7v0LvkqC9XrGDAGyT34ERgBURnWjF8XrbFreJfzLjOt?=
 =?us-ascii?Q?zKICq1iS56cgLZUBA0c/VeyM5JLXTGWSmKUEvbxudpgZ4Ocw3sLl/FZ1ynrI?=
 =?us-ascii?Q?PRLEzc7SM/ghjGa331Pkm0o8dWUU/Sm6iQxf6OG1IfSh3O0bdZMKJqvNAbiA?=
 =?us-ascii?Q?hR27Rkw+xQqETOzXnP8WDCCoKV+QkUEya6NA0HzFMvK7A/Mbv8STwsGxZLtL?=
 =?us-ascii?Q?D/yAEdne5cjoZosKEmHF4hzf0Gv37GYQK7NsnqLFj7nQYjmJqRUWCKq/5tMu?=
 =?us-ascii?Q?kbBV9MjfK1bHPPrBlj2ngA5Y1S99xgRbUWrXNS4S7R6ak5B1SUcgkpBsveV2?=
 =?us-ascii?Q?hk6n6dOfuQBDIVT1inWUD1wVzVpWnXLu7hYufboHKUlWgs6MdOSev2RYHjDu?=
 =?us-ascii?Q?euntb7LEUHM2IGgb6gEyw8zln0jPeVUezHIkUwPmyCK/nBIhhbGurFE0MbT+?=
 =?us-ascii?Q?YdJk4TyVbVFNO6/X/C4pv2RWKqWbe3sTuaz5dRn0ewobyrInm46tTG4tcTcG?=
 =?us-ascii?Q?13yQRHSXoowD61kdIqDnwCJ8azJ447d804n8hq+gIhLW6r/Xzfp3uQs9nK09?=
 =?us-ascii?Q?JXe7nyJZHtlFSztCvj/Kbx9NFysHG3ztqZl+RT6LJA3oJWrQkog8dhiNWqtN?=
 =?us-ascii?Q?hJQMHHIMLuvzPVTlKvzhdg3sHJLVj+tM+0VR/H+N6cAaWRdXEOVReSNs1Iql?=
 =?us-ascii?Q?rftKcC+bXBLyYpSqobexMxGjYtKGBrfcOIrI/yV6LSjk2Md9CPP+8J3O4rmy?=
 =?us-ascii?Q?hOCDwQ4CdlgM8HsvdFffW0Pd2QIIQnR2gnWF3fKQ+hrT0N/e8b/YtQlv8oXK?=
 =?us-ascii?Q?4v4ZtB7BvxY3VTSG2wgyKtJ3KE9fiutNvG2FJTLKKueLwKNuLnArE23pO03A?=
 =?us-ascii?Q?J/kgYX1qpGAEuJJHHTStzwHno72jPis+sMMy80PRmr6GBbc8S1GRVpBbkLAy?=
 =?us-ascii?Q?/FOUGATug2V+RdXYLEA1HniboomTFcBKX0QmCXlda4axeWMXVmHQ292dkjkc?=
 =?us-ascii?Q?UApqmLR88Rek/yBssYUbtvaNDNsGMBs47t/B7G5vrdb5aBZ+3l3W6F6wBefZ?=
 =?us-ascii?Q?o/vNy1/tqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f05d84d-29b7-4453-6e47-08decb599adb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 03:44:44.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXeYREzQFf2cLLHZ0XZZISVZ9Jvkkay1cxJy39KHraO8gRQQAG57filTLMb1oaMkj46iahRJNzcuUv1SQZqPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063

Exercise the full driver path on real Grace and Vera hardware using
ACPI EINJ to inject CPER sections and validate the kernel log output.
KUnit covers the parser in isolation; this test covers the path from
firmware notification through GUID dispatch to decoded output.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v2:
 - No change.

 tools/testing/selftests/firmware/Makefile     |   4 +-
 tools/testing/selftests/firmware/config       |   5 +
 tools/testing/selftests/firmware/einj_lib.sh  | 189 ++++++++++++++++++
 .../selftests/firmware/ghes_nvidia_einj.sh    | 144 +++++++++++++
 .../firmware/ghes_nvidia_einj_profiles.sh     |  46 +++++
 5 files changed, 386 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/firmware/einj_lib.sh
 create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj.sh
 create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj_profiles.sh

diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
index 7992969deaa2..b753dd123860 100644
--- a/tools/testing/selftests/firmware/Makefile
+++ b/tools/testing/selftests/firmware/Makefile
@@ -3,8 +3,8 @@
 CFLAGS = -Wall \
          -O2
 
-TEST_PROGS := fw_run_tests.sh
-TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_upload.sh fw_lib.sh
+TEST_PROGS := fw_run_tests.sh ghes_nvidia_einj.sh
+TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_upload.sh fw_lib.sh einj_lib.sh ghes_nvidia_einj_profiles.sh
 TEST_GEN_FILES := fw_namespace
 
 include ../lib.mk
diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
index 6e402519b117..1b68e638d0b7 100644
--- a/tools/testing/selftests/firmware/config
+++ b/tools/testing/selftests/firmware/config
@@ -4,3 +4,8 @@ CONFIG_FW_LOADER_USER_HELPER=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_FW_UPLOAD=y
+CONFIG_DEBUG_FS=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_EINJ=y
+CONFIG_ACPI_APEI_GHES_NVIDIA=y
diff --git a/tools/testing/selftests/firmware/einj_lib.sh b/tools/testing/selftests/firmware/einj_lib.sh
new file mode 100644
index 000000000000..ca569a9fe5b0
--- /dev/null
+++ b/tools/testing/selftests/firmware/einj_lib.sh
@@ -0,0 +1,189 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+EINJ_TABLE=/sys/firmware/acpi/tables/EINJ
+EINJ_DEBUGFS=/sys/kernel/debug/apei/einj
+NVIDIA_PLATFORM_GLOB=/sys/bus/platform/devices/NVDA2012:*
+NVIDIA_DRIVER_DIR=/sys/bus/platform/drivers/nvidia-ghes
+
+einj_skip()
+{
+	echo "$0: $1" >&2
+	exit $ksft_skip
+}
+
+einj_require_root()
+{
+	[ "$(id -u)" -eq 0 ] || einj_skip "must be run as root"
+}
+
+einj_require_debugfs()
+{
+	[ -d /sys/kernel/debug ] || einj_skip "debugfs is not mounted at /sys/kernel/debug"
+}
+
+einj_require_einj()
+{
+	[ -e "$EINJ_TABLE" ] || einj_skip "ACPI EINJ table is missing"
+	if [ ! -d "$EINJ_DEBUGFS" ]; then
+		modprobe einj 2>/dev/null || true
+	fi
+	[ -d "$EINJ_DEBUGFS" ] || einj_skip "EINJ debugfs directory is missing"
+}
+
+einj_require_vendor_einj()
+{
+	[ -e "$EINJ_DEBUGFS/vendor" ] || einj_skip "NVIDIA vendor EINJ metadata is missing"
+	[ -e "$EINJ_DEBUGFS/vendor_flags" ] || einj_skip "NVIDIA vendor EINJ flags are missing"
+}
+
+einj_require_available_error_type()
+{
+	local available
+
+	available=$(einj_read_trimmed_value available_error_type)
+	[ -n "$available" ] || einj_skip "available_error_type is missing"
+}
+
+einj_read_trimmed_value()
+{
+	local file=$1
+
+	einj_read_value "$file" | tr -d '\n'
+}
+
+einj_require_writable_value()
+{
+	local file=$1
+
+	[ -w "$EINJ_DEBUGFS/$file" ] || einj_skip "$file is not writable"
+}
+
+einj_require_writable_profile()
+{
+	local file
+
+	for file in error_type flags vendor_flags param1 param2 param3 param4 notrigger; do
+		einj_require_writable_value "$file"
+	done
+}
+
+einj_find_bound_nvidia_device()
+{
+	local dev
+
+	for dev in $NVIDIA_PLATFORM_GLOB; do
+		[ -e "$dev" ] || continue
+		if [ "$(readlink -f "$dev/driver" 2>/dev/null)" = "$NVIDIA_DRIVER_DIR" ]; then
+			echo "$dev"
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+einj_require_bound_nvidia_device()
+{
+	local dev
+
+	dev=$(einj_find_bound_nvidia_device) || einj_skip "no bound NVIDIA GHES device"
+	echo "$dev"
+}
+
+einj_read_value()
+{
+	local file=$1
+
+	cat "$EINJ_DEBUGFS/$file"
+}
+
+einj_write_value()
+{
+	local file=$1
+	local value=$2
+
+	printf '%s\n' "$value" > "$EINJ_DEBUGFS/$file"
+}
+
+einj_restore_value()
+{
+	local file=$1
+	local value=$2
+
+	# Some EINJ controls read back as an empty string when unset, but the
+	# debugfs write handler has no matching "clear" operation.
+	[ -n "$value" ] || return 0
+	einj_write_value "$file" "$value"
+}
+
+einj_save_state()
+{
+	EINJ_SAVED_ERROR_TYPE=$(einj_read_value error_type)
+	EINJ_SAVED_FLAGS=$(einj_read_value flags)
+	EINJ_SAVED_PARAM1=$(einj_read_value param1)
+	EINJ_SAVED_PARAM2=$(einj_read_value param2)
+	EINJ_SAVED_PARAM3=$(einj_read_value param3)
+	EINJ_SAVED_PARAM4=$(einj_read_value param4)
+	EINJ_SAVED_VENDOR_FLAGS=$(einj_read_value vendor_flags)
+	EINJ_SAVED_NOTRIGGER=$(einj_read_value notrigger)
+}
+
+einj_restore_state()
+{
+	[ -n "${EINJ_SAVED_ERROR_TYPE+x}" ] || return 0
+
+	einj_restore_value error_type "$EINJ_SAVED_ERROR_TYPE"
+	einj_restore_value flags "$EINJ_SAVED_FLAGS"
+	einj_restore_value param1 "$EINJ_SAVED_PARAM1"
+	einj_restore_value param2 "$EINJ_SAVED_PARAM2"
+	einj_restore_value param3 "$EINJ_SAVED_PARAM3"
+	einj_restore_value param4 "$EINJ_SAVED_PARAM4"
+	einj_restore_value vendor_flags "$EINJ_SAVED_VENDOR_FLAGS"
+	einj_restore_value notrigger "$EINJ_SAVED_NOTRIGGER"
+}
+
+einj_emit_kmsg_marker()
+{
+	local tag=$1
+	local marker
+
+	marker="ghes-nvidia-einj:${tag}:$$:${RANDOM}"
+	printf '%s\n' "$marker" > /dev/kmsg
+	printf '%s\n' "$marker"
+}
+
+einj_capture_dmesg_after_marker()
+{
+	local marker=$1
+
+	dmesg | awk -v marker="$marker" '
+		found { print }
+		index($0, marker) { found = 1 }
+	'
+}
+
+einj_wait_for_dmesg_after_marker_contains()
+{
+	local marker=$1
+	local needle=$2
+	local timeout=${3:-10}
+	local i
+	local slice
+
+	for i in $(seq 1 "$timeout"); do
+		slice=$(einj_capture_dmesg_after_marker "$marker")
+		if printf '%s\n' "$slice" | grep -Fq "$needle"; then
+			printf '%s\n' "$slice"
+			return 0
+		fi
+		sleep 1
+	done
+
+	return 1
+}
diff --git a/tools/testing/selftests/firmware/ghes_nvidia_einj.sh b/tools/testing/selftests/firmware/ghes_nvidia_einj.sh
new file mode 100755
index 000000000000..6fc4d3189235
--- /dev/null
+++ b/tools/testing/selftests/firmware/ghes_nvidia_einj.sh
@@ -0,0 +1,144 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+TEST_DIR=$(dirname "$0")
+source "$TEST_DIR/einj_lib.sh"
+source "$TEST_DIR/ghes_nvidia_einj_profiles.sh"
+
+einj_assert_nvidia_cper_output()
+{
+	local profile=$1
+	local output=$2
+
+	if printf '%s\n' "$output" | grep -Fq 'Malformed NVIDIA'; then
+		echo "$0: $profile produced malformed NVIDIA CPER output" >&2
+		printf '%s\n' "$output" >&2
+		return 1
+	fi
+
+	if printf '%s\n' "$output" | grep -Fq 'NVIDIA Grace CPER section'; then
+		if ! printf '%s\n' "$output" | grep -Fq 'signature:'; then
+			echo "$0: $profile Grace output missing signature line" >&2
+			printf '%s\n' "$output" >&2
+			return 1
+		fi
+		if ! printf '%s\n' "$output" | grep -Fq 'error_type:'; then
+			echo "$0: $profile Grace output missing error_type line" >&2
+			printf '%s\n' "$output" >&2
+			return 1
+		fi
+		if ! printf '%s\n' "$output" | grep -Fq 'number_regs:'; then
+			echo "$0: $profile Grace output missing number_regs line" >&2
+			printf '%s\n' "$output" >&2
+			return 1
+		fi
+		if ! printf '%s\n' "$output" | grep -Fq 'instance_base:'; then
+			echo "$0: $profile Grace output missing instance_base line" >&2
+			printf '%s\n' "$output" >&2
+			return 1
+		fi
+		return 0
+	fi
+
+	if printf '%s\n' "$output" | grep -Fq 'NVIDIA Vera CPER section'; then
+		if ! printf '%s\n' "$output" | grep -Fq 'signature:'; then
+			echo "$0: $profile Vera output missing signature line" >&2
+			printf '%s\n' "$output" >&2
+			return 1
+		fi
+		if ! printf '%s\n' "$output" | grep -Fq 'event_type:'; then
+			echo "$0: $profile Vera output missing event_type line" >&2
+			printf '%s\n' "$output" >&2
+			return 1
+		fi
+		if ! printf '%s\n' "$output" | grep -Fq 'event_sub_type:'; then
+			echo "$0: $profile Vera output missing event_sub_type line" >&2
+			printf '%s\n' "$output" >&2
+			return 1
+		fi
+		if ! printf '%s\n' "$output" | grep -Fq 'event_context_count:'; then
+			echo "$0: $profile Vera output missing event_context_count line" >&2
+			printf '%s\n' "$output" >&2
+			return 1
+		fi
+		return 0
+	fi
+
+	echo "$0: $profile did not emit a recognized NVIDIA CPER section" >&2
+	printf '%s\n' "$output" >&2
+	return 1
+}
+
+einj_run_profile()
+{
+	local profile=$1
+	local marker
+	local output
+
+	if ! einj_select_profile "$profile"; then
+		echo "$0: unknown safe NVIDIA EINJ profile: $profile" >&2
+		return 1
+	fi
+
+	einj_require_writable_profile
+
+	printf '%s: running safe sample %s\n' "$0" "$profile"
+	marker=$(einj_emit_kmsg_marker "$profile")
+
+	einj_write_value error_type "$EINJ_PROFILE_ERROR_TYPE"
+	einj_write_value flags 0
+	einj_write_value vendor_flags "$EINJ_PROFILE_VENDOR_FLAGS"
+	einj_write_value param1 "$EINJ_PROFILE_PARAM1"
+	einj_write_value param2 "$EINJ_PROFILE_PARAM2"
+	einj_write_value param3 "$EINJ_PROFILE_PARAM3"
+	einj_write_value param4 "$EINJ_PROFILE_PARAM4"
+	einj_write_value notrigger 0
+	einj_write_value error_inject 1
+
+	output=$(einj_wait_for_dmesg_after_marker_contains "$marker" "$EINJ_PROFILE_BANNER" 10) || {
+		printf '%s: %s not supported on this platform\n' "$0" "$profile"
+		return "$ksft_skip"
+	}
+
+	einj_assert_nvidia_cper_output "$profile" "$output"
+}
+
+einj_cleanup()
+{
+	local status=$1
+
+	if ! einj_restore_state; then
+		echo "$0: failed to restore EINJ state" >&2
+		[ "$status" -eq 0 ] && status=1
+	fi
+
+	exit "$status"
+}
+
+main()
+{
+	local profile
+	local passed=0
+
+	einj_require_root
+	einj_require_debugfs
+	einj_require_einj
+	einj_require_vendor_einj
+	einj_require_available_error_type
+	einj_save_state
+	trap 'einj_cleanup "$?"' EXIT
+
+	einj_require_bound_nvidia_device
+
+	for profile in $(einj_list_profiles); do
+		einj_run_profile "$profile" && passed=$((passed + 1)) || {
+			[ "$?" -eq "$ksft_skip" ] || exit 1
+		}
+	done
+
+	[ "$passed" -gt 0 ] || einj_skip "no NVIDIA EINJ profiles produced output"
+}
+
+main "$@"
diff --git a/tools/testing/selftests/firmware/ghes_nvidia_einj_profiles.sh b/tools/testing/selftests/firmware/ghes_nvidia_einj_profiles.sh
new file mode 100755
index 000000000000..b25461d2238c
--- /dev/null
+++ b/tools/testing/selftests/firmware/ghes_nvidia_einj_profiles.sh
@@ -0,0 +1,46 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# Run both architecture profiles on every platform; firmware silently ignores
+# selectors it does not support, so a timeout just means "not this platform".
+EINJ_PROFILE_NAMES="cmet_dump_status_grace cmet_dump_status_vera"
+
+einj_list_profiles()
+{
+	printf '%s\n' $EINJ_PROFILE_NAMES
+}
+
+einj_select_profile()
+{
+	local profile=$1
+
+	case "$profile" in
+	cmet_dump_status_grace)
+		# Grace CMET dump/status: informational sample, selector 3.
+		EINJ_PROFILE_ERROR_TYPE=0x80000010
+		EINJ_PROFILE_VENDOR_FLAGS=1
+		EINJ_PROFILE_PARAM1=3
+		EINJ_PROFILE_PARAM2=0
+		EINJ_PROFILE_PARAM3=0
+		EINJ_PROFILE_PARAM4=0
+		EINJ_PROFILE_BANNER='NVIDIA Grace CPER section'
+		;;
+	cmet_dump_status_vera)
+		# Vera CMET-NULL dump/status: informational sample, selector 0.
+		EINJ_PROFILE_ERROR_TYPE=0x80000010
+		EINJ_PROFILE_VENDOR_FLAGS=1
+		EINJ_PROFILE_PARAM1=0
+		EINJ_PROFILE_PARAM2=0
+		EINJ_PROFILE_PARAM3=0
+		EINJ_PROFILE_PARAM4=0
+		EINJ_PROFILE_BANNER='NVIDIA Vera CPER section'
+		;;
+	*)
+		return 1
+		;;
+	esac
+
+	return 0
+}
-- 
2.50.1 (Apple Git-155)

