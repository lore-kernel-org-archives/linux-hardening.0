Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F542BC5F;
	Fri, 24 Jul 2026 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895702; cv=fail; b=tsACFhWEFDoe1JaYWBV2E9Lo/sjaU5TJx3vl2t0M9m82yvi9MZ2BKJBLfUkKL+328Emu6BOnqnsviS0sLLQyHLmC5jYQCAeEZ2sCAwQ4ErjYT8w2qRGvWrU0yWy+CjsgQ4Gm/eCvWoHbwpAKZOk+1Bc+ZFPd5FBK7DiheKjiYjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895702; c=relaxed/simple;
	bh=MBPdsRpd7quP/ogkU5skJ7OU3KxxhWLM0T/bwTbkXE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLHhsj1mlbIDiIE+NwpxaLfVZ4PzCoqJEOsDMUoEd5RwkfbEp53jVL2QmI4W0be1vB8O629vt8UmSRYKErv1JealbG4RNmfmpRvtxrmbgLWPJcDtvfShSKdWulSySQkle5DJ1qctRspn9HtZav36sNWMpYoN6sHJY5md2l1Imks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CHoKkFeY; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CHoKkFeY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3w4xa51/CaHs9gde2JI52JPNTyXWgXj54NvhMTDynIokp9edzhg6pflTSUjmcuFg97U3W6O855a4qfKdzuWTrY2G0qdGnlmHrExTLfOrcXlxDa6FmtQBQo+lJAlJBDcgXouXxVzg9ud4w5D8C625Urau1yfJVcl9ALN8o2aZHfl01QmgG0SeFhkkg6wu8YxQTeSA+mTiWXSpUdjvRHUkYN28EXf2SAQcwRhTcGqwLpCMBg28IZVtO/b+xvoDKgFNRxaepNSu/KmneplAN5jlsJ9Pf70P8sPIq3R6OtZV8IXZHyYeVLU/Jz/zeaXNG4s0HjHBLCERzIoygkYuFOUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIZpqKBtRJM0qmD5mh81mIrj71QURR3aNlbY0c+c2Eo=;
 b=sOC65OUg9vB8hNlJbkDMflFaTNZDc83QvFNcBtMExgD0rRp5k50vfe7eIKckYOcqo9V6OgVMYKmQDO1Wehxtf+KWJzLtGB5qdVfKPEkL2IqZwpMLp7HJ9mXyyEheSCueRzDAYfTYmvX478hFhHPqW8r34LE/AN7Q4jkhhzy0CqvcokOmHwtgWFbBsEGWNzP/nRGmZzbJzdbuhJqQE0VnjM4wfRrO/sz7n4IP37J+EA1ELVaCvNb3LxwT2mI/vyznO1wn5rbDkcfWkGfhupd8onK6eufxCobRHlGMhLeJnOsqiFzfA+AcghdNpCzNPm52zQrT7Z0TXCdLKHtdaWL97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIZpqKBtRJM0qmD5mh81mIrj71QURR3aNlbY0c+c2Eo=;
 b=CHoKkFeY/n45wgazop4nzEECftnlsmW5VoBDhEn9FubwLL6j/p6PA5BGKQwsWyiWTvHrRxSDXgZwht9L/6lEZgJmuEXxC7TjDtME635WRvtbIQy6fGQUT6tlt7fzVqv7CfxswAcvd6xHktYExLmZPOBWA7EswdIehpTSekZGTeH/RoUBgO6u+tfkQW/mSs1zUF22eooT4Y/bpGahMpE+DV92nhq1ncvnvOUAbnZLhu3kslWB1FrQvN7jbE0ZWWcIioxUVVNxSn6bqPv5SuWX2ywSTRvy4qn9XIGPFuyMbkKFJdzZVZIqtdZ66sR9tQe4Kkmf8U2MJogvF+96R1LyGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 12:21:29 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 12:21:29 +0000
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
Subject: [PATCH v2 RESEND 4/4] selftests: firmware: Add NVIDIA GHES EINJ selftest
Date: Fri, 24 Jul 2026 20:20:54 +0800
Message-ID: <20260724122054.36162-5-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260724122054.36162-1-kaihengf@nvidia.com>
References: <20260724122054.36162-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::11) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa5687b-931e-4c06-ccd5-08dee97e15f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|3023799007|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4deR+dnkCYDSLc9UU2bmRG7t8extqIRsrpnN8jfSve9fCAhBaewgvMEyOVJl2TaGxoQ3RAEBLNoCq0UkjyeDdkaMGz7WC36s89t9bi5OMTF7t++PGzswP6UoWZfGsRP7xZV2OZob91Zz24t3YWvQaXxYyXcHaezQfPoPK2pJl5W/xAw9thCKp+JxWh2ygBg/Hgw8rc/6K7htYk7waU8fq1I+rCBl9stYwPNhojS5p1hsFpMv4tdlS3RcxMApj+r9SHYQqQos8uvtEIKvBv0Mwh/YlHfumlta/vNi/Oqq6V4zhtWFW8410TQK+SHjz88ETHBAIfEatL7RhqHYMD4oZKY16b7ZAJdIaW/u2xeEzOhuM5mX2ztrJh2nj787PEK9aSDZXlY4yDABHFPPpnUQIumRAIFtMzsNA2ZmN5qHry+prTad0x4qiD3YxTATR3crJG3Vu/Ff62MrHEz5+sTRoC3rym8u4zTTahaosGJ6vrop7dxxDdg55UxrYdjBA2LzqBsQBzdE900CfnS/e++a5iqYAFG5iKhP39oOMvHcWOD6x+CdYNTqJJ2o4OMHnVF4Nh0LJHq4B7exX6959w40e5zxRc52SkRKvpdMg9/vrDkcig7Mxu+d5zKOrn3ff4WfaLwmBCe2wEfuxHggv23jqXfppNglIFhwfPFRtNPSJjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(3023799007)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ONfWTRpSwrJLwflt6pIUyaClZSNLsssnrR1P9tSKQ31uQfmp0mnxGhDU8ig?=
 =?us-ascii?Q?hKw+0O6sRIwCtcIT+5kG3ejP1R13WkP6dDDEq11HyLvqFhzRZX3kUYB8YWeZ?=
 =?us-ascii?Q?GKs7r2fbYpNdjnPI9+/cjR1CIlmIG0lSNefSuN183l96plEzmcbOK9OCyzGK?=
 =?us-ascii?Q?PFpUlAk1IbLP7CMdGNHWUUA+Q19ygx10lisML/g2tf+K7qq9PHGzqM4CguS0?=
 =?us-ascii?Q?sPzuGXAOoC9t0HiR1gUw7Ov1JGLIiDn6MLfdQeJaCPEtHuf45nQDlGW6tZfc?=
 =?us-ascii?Q?h+MoPxQo/G8dr5eovXsHBDNvbzi2Fvj5bRppktAqR4WzZpuowWzp/ChXaAGj?=
 =?us-ascii?Q?6o3VH89xe7ZYb41iW3hpEgiZ1iQSULIKRL5CZHegywySgF4OvHSxYZXr5HB2?=
 =?us-ascii?Q?av5VA4hr6S/SiTGVTFoUxsaBbjtZM7ZHChv0iO09Wgda/KIZXEq6ADXZanbw?=
 =?us-ascii?Q?QgslhD5OySOzKi0d9ThNFE+zkGWIOsVtvD2+In3cdS3U2mROwVUX7eZRpPNH?=
 =?us-ascii?Q?fPTyFQgcdog6IH2f/OME4oRuTbnfxfZxe8rauZ7fAFBWD0nbNPnDrRHCLJWx?=
 =?us-ascii?Q?n031gU1PddBNeh/VNsepv+btleJm7eUSg3EooeOOir9CuoZ6vaFBsakxORxr?=
 =?us-ascii?Q?6XzBukra+zEld7wxlI7LAeIvLa4Ei52ZuAUTpZXWM44I1Ss8U64ICINCCEI3?=
 =?us-ascii?Q?YBn4A1GlV7XXp4ZD88ZobnPJmoG5xH6RT92VZzgg/aZZEzowQJjd31B1PU/E?=
 =?us-ascii?Q?mmkL93LABSO4sEZSd0eN4XGBFD+F3NLiwJBqyib+fplaUeoBbln0zNYFklY9?=
 =?us-ascii?Q?/HnYWdWE9e6WG/fyLRzwnBwc0UxuyAKLQ3u3Ly/8G7J/v1Nb2EnDo353QBZu?=
 =?us-ascii?Q?PjIN6bIxoyJ+YYVcW2oYGBy+edBxjhiRJSA/fH1ecuZwaui6F1DLP+kL3jCZ?=
 =?us-ascii?Q?BpKlljYgrWqrnVd3raOqIiASddgUc12yEikG2OCCRgaiEWD57FhGRfUtsfj9?=
 =?us-ascii?Q?qBMOtQ1Jm3o4h64NqOAvn4KwKYrQDTbiuCGqETtIxclC3uDONbYN/S1I/+LI?=
 =?us-ascii?Q?Z2bgnhQvfd6jBgGWeurxUbNutZTZoMyg53Qmpba91rv5JzyjgYMZsuGEz2oR?=
 =?us-ascii?Q?2amrxDoNfBnmNy9x+l8pvRmMMse71olFDEZ5+SXTaJNZD0cWbe67i+TOrDvH?=
 =?us-ascii?Q?6pjasvXtiBUNHqpOSyArjLV7J8o+NBMW05JvonP8JwVRxk4IB7aMB0mgNNn3?=
 =?us-ascii?Q?5gX2uTMjl3sGLsRuYq9ywTOjovAQqnVGwnnhXbtYenjcJSbYS5uqgjMBNihu?=
 =?us-ascii?Q?gF1uN7nrAGKV65zHubzegUioweaRo5JvkICNP2tvzjzgj70SxdwdyZHWofmF?=
 =?us-ascii?Q?RnC1WtXewbeP88PQbwwJNTp7aryRmCf5EoP873RwdF1HQCdU22XodKjf5jPJ?=
 =?us-ascii?Q?qUQi4IU0gLSNt07WimCk74y2oeyqzWv9fS4CXiENKnTZ59A2PHt60RxTYScv?=
 =?us-ascii?Q?t4/VFJ5xETZdp4Jivt/Yin7z2larHzF/bv3v7ek0rg+ApDCRcC1WvVASZ21i?=
 =?us-ascii?Q?nT3ezZb/xrCyo+HDqSyx44+5Pp0PKfniv2EuOd8Fk7fmnSa5tWpw7ZChPBlJ?=
 =?us-ascii?Q?f/Ih6btNWQ1h6/vTXjb274opl/Pd2juJzfZZASsmDy7H7wdDy0M9eHdBJXNw?=
 =?us-ascii?Q?z+f9OUAJWdpA5Q0p0h09PoXZ9G5/reMfLryQ9aXZE3aUTrfHOVsLVpz8SzqY?=
 =?us-ascii?Q?FGNv7GGxEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa5687b-931e-4c06-ccd5-08dee97e15f4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:21:28.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djXM2OkWEnUl3tqZ4rO/W8u+/CvJBpt5CUUIxS7ahg7DUahbxMIkDfYif3y2xikBt0VZ310bGGWIaEpNdOcO5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032

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

