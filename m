Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE27366806;
	Tue,  4 Aug 2026 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846209; cv=fail; b=orHk52Saa4DNIADGWcysGbwQhPZj2qQAG65vUqMgpnUMt0a9z3KihNX7rzrV6JLyYepNr/cd1u6LkVgIX9dFRoDMRlKwmvlEz5qa3gGlnYkqXMGqXlwkWnDwZJmfmdIi/0dTxtU+6wNeSeKdiO8IC3b9YNVlr+aAtttTmyIkJL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846209; c=relaxed/simple;
	bh=E6w5WEWa5TXaefje5WJ2VW+Oe8MdQGoEK2CfWBZPJPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UzuTc+hU8QsTCrSa5r1nqaoQxYAirwQEnwExL+0OsnAtpU0mI053K//EzAcXzlJn0PLM/WuDFOher4q9AXAV4FS2B70E6CzXFspAwNus43kcp1Aay27lJbfPFWcOvK1raqqBvVZuerxVGfgBS0B+YoubHjDQlbEYOu7sErV0H6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kJNm2fBR; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kJNm2fBR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibhg/x7hew5QeGFqDg900LTfq3z0k/5Wd2WagUJfu29fJmLlrgwSJlcXUQXdMV5xLR9uWIq95XHYxTh+8ufCOeAk7LG1RIq/gD+sCovf3gIAxTlPm9gXIbglAdzs+20wuMZdZJSDpdBR4/ZHjnU8NG3cUJcrMjcInNnPpFfUce2+KPqLH47uQyqGMmeqZ0p80TkoJlM7stqjYNke8RuBfiuFuOsVEDbH38AZeuKFYj/bdI6FNCm29rUEHm/nrxQYv/QSKBGByh3LmI4pV/NpqB3M+LyX2ydbR3es+gfB9rpvmSQ3OoN3gPRWjQTSfDtuLA4vfTl8dfgUKr7XmzNaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Bi4oSZfidSdSkDvCYIVUmpZX34WiNuZLQSr1iRNLEM=;
 b=CoRlFhqz1udM+T1uwQQ/Hqg60xhOF6/uYuBogcpkOeDMTpRtLcdcv94ElpnuWFRtBTdDOgytztr+y+uYFR8u2nP4EtAVc8A+9mOX1JV+Ftu6++oUmwzvY7cwBrf+e4pi9XnEV19aegAFGdNpUlcNFGp/AihXAVwIyIoGhwcykrsU4WBsaec4B324/JqAHSoR0yxRoCDoqZjNUpDK8iQNzl4qi+cO+BpU1F/5bIuguF5Dq4BNNX42BJKrlFiySc8P+B8zGGGCft8D2awDSVxNd/kMor8lhV+tS7Ea+sUJm1kyMNnq/WM2GCqnu5c14t9bScFAtgUxumDszmbuaMDSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bi4oSZfidSdSkDvCYIVUmpZX34WiNuZLQSr1iRNLEM=;
 b=kJNm2fBRlPVtjee8ZUEip/axOfwegtgJBnnJFp82CHcfCF3vzlJVXpgrvKRB8q0CkBvifh/Wp+XzgLRmkBhiQhuvVdzdi/QaVXEGm4DJ5Xq1SLPgPYiovpYsWlGJrUsEFaPEOfIB8j6VSFhtGdWCNp98A31yc2jPTpbb0BUvfdVCd1c/qk3hvB/G8JuLttSED4auJ4jMpkxGlqwsoJxFjkbmKjLKTJEG4yzPx00Yipu7Et5t7XlmpQUrcxqHG/HkGgsbLertOP0ZuZRHEeKstTqUDAxZO6U7VseIg5gPGQ5Sgxeaoj87nIpSTpbdCmHG+xtpqTzlZUNsiwV662prFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by CHAPR12MB999224.namprd12.prod.outlook.com (2603:10b6:610:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 12:23:23 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 12:23:23 +0000
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
Subject: [PATCH v3 0/3] ACPI: APEI: GHES: Add NVIDIA Vera CPER decoding
Date: Tue,  4 Aug 2026 20:23:14 +0800
Message-ID: <20260804122318.88193-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260724122054.36162-1-kaihengf@nvidia.com>
References: <20260724122054.36162-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|CHAPR12MB999224:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d13908c-63f7-420c-1e67-08def2232d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	sz5nJX/hj+CQRgkRsvqx68GO1HO1UF24xhAixGsLqDNZL5rVZgkrC6XBHsXX2BXrDq1pmPn9zeB4M2Nl6J2Hs2L0HAD33DbLvmsw0V595gV2mPtOepQZ5eyjOi+FoUvTu2HuwoymW4NazEG2G6PD6Yjb1lnoh+QthGwUgBEfHCU8dDIR5aqjdKvjHja69Cv2P3JV2tYRwqs7uJWqfUvD/OkiujoN6TZSDqJjqrpa6QLCo7Z6DfW9Oe1ZJpLvdD62QGbpUeCWr2SSdjr+A1r8Xs+4Qj0uE7OQ2IqQOakNa8a46iFsg8dlUbbyLo15djH28/SfHr8c+KYp73dxSU9fShzo4Xz2sfhilM3eXcIY+Tx2nFckZXY+PlmWDH+GJ3MhaccXFJuzG5yn56HzR/a5H5v23VffkOSvtXQi7cl2WmhyO4LvGxT5FwIXX0JL7upVKpdMkWhvlV6cHnYr1LE6qlmSHXVYvjXlK8vvWlugWYneUn/wMAo2rc56A58bCuxZRryKuxenzwFPnCT+53iNp9CpqB1vPBHcJpiIS97LH4f5dFiSNs6sB2XN5JkmQqYceQpA+p3xbFnGD/eyoGsONdBJ5lrxjxkjw2C79MgHB9Z2zArseeuW7rgF236zlrv7CmP81GDYYvgEcS282+G31DZD1byBOa0kcIECioBFJiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lPCDvPTNHDwAx4F3YRA8Vu65xplCaYSQcwkiFixiKx6p9fPACiGyhKDvdx4C?=
 =?us-ascii?Q?JcRdJqRdX4vqY+atWKX/uM1u3C4ich+ir7aaRSwAMcigL5zNyyDkZFGvAU+d?=
 =?us-ascii?Q?qcS6n+utiw7CDEb+gPkZmNNcR8H7TRydVOwS1R1wI13tyR3vwkNAdZ0z+hX7?=
 =?us-ascii?Q?C3ki9veekWIM8xmcU+49/D/dp7Dybc5WjZPC7A3qPR/nC0bZkIb5l+SLdotS?=
 =?us-ascii?Q?8nDoZ1t/uQrCwWK0fxIfxQhEC83ggb07Wlkerm9pdXxKBONLaPMtsKoflj1w?=
 =?us-ascii?Q?t7+M/KZFrbrIFzPvFRpbrom2DOMK/ljbNsGhkXHL0X2yBqjhzERtXtAEJaCJ?=
 =?us-ascii?Q?11NhsnLLKTVxfFg3hFPB3275WPZs//xHCGTyJsyRSccETZFGLs9Vop83bfUE?=
 =?us-ascii?Q?r0rXNMomA4rtAmbJ3GoTvf7N4WLbYpxiUEw9uc08ODv11/Zk5N9d9xY3nQ2D?=
 =?us-ascii?Q?Bf32jPhgCuo85MxnsV4AGlRVdeovmyrNXKIsF8/S9dEuYBInzkuz8AidNz0J?=
 =?us-ascii?Q?Rh20YVcsAvGqcqDsFClmC2xTk68yTa6fPoBEWCsLfOR+T8ICbqUdWeHetNDL?=
 =?us-ascii?Q?Pbv8qLPTaX7KspkhuHBGZ2r9+3Cus0wfxBk8TOQZrGzYQ6+BF/RD42x1rUSo?=
 =?us-ascii?Q?nFRQAX5Qr6/FMaQp15l38umQa1FVOw4bHEKzleP73tCfyBV2YmK8Vc9VFv2M?=
 =?us-ascii?Q?aSe33qNe+d8m1X/99FdWR94Lcay/sncgxhqCzNKOGPT4yl+y3upGI+eOUvOu?=
 =?us-ascii?Q?g02FCqO/hibq6BTQmLJF/85noB5bY3fYwqcNbX7dAkjUntKmfwbfgkkSH0s4?=
 =?us-ascii?Q?9BgMPDKJMBMHmEKsP5mBWmwzfwLcLLYB82XnVpt/mI0uSDLt7MivAXEs8Di7?=
 =?us-ascii?Q?bsb4oKXsGz69HUjqVmmAikAG+zgM9vvh7ZahfetKFo/rqgg1CQIc1YirIYmy?=
 =?us-ascii?Q?kEwwQZMhSS0i5rBo8F4mVlj3aX/4UBCVbsjOcOujRz6FixM36iN6QITOj9wC?=
 =?us-ascii?Q?6DFb+uicxCqeT3HTPuTgExRNPKZIqBXoZPgRqAEbfUp5f+9tEetY8DsuYEXP?=
 =?us-ascii?Q?fkiLHDb064zSdD1PiLqeCRlfjcAGb/8fFvQ9kJ6HehMilvmh2V4pYQM9jDOi?=
 =?us-ascii?Q?fdM3lT5Cr7vZEHWoEWTlaSfFtvzYAmkyp8siZ6aN4R7j2FJRyGYiGgG9huu8?=
 =?us-ascii?Q?1ZS+WtjvLNcOXFZ8WC/UmZhFIdKBLUR/prFNhuVyhfVrPi6j4eVmrCl9A/Ri?=
 =?us-ascii?Q?7M6BDYy99S48xrA5SbTBgHJ9kIt6YA+oWGcZgL9+nYP8NDUxFds4asTsDQSn?=
 =?us-ascii?Q?8PnqRKKFT3xDf7lUnChjerViXmZs4SiW2Y15ib7viUMq+zFQgDf4q8P1L93O?=
 =?us-ascii?Q?sAGyY+NnhM4K9oaGQ8HvBP2/UyNRqQAs/b/SYIZMDXmB5a1hjs2Xb8TyiwRZ?=
 =?us-ascii?Q?uu8ZvhCBn+BOSc2g5/1W7kxUbPIVbmPrDIRjpJdxfG3FSDvMHCTvn/jFnkLu?=
 =?us-ascii?Q?Kz5SIvh+c+O68pS+LsVoeVuqu/lipTDWVvWzfOoIbLCRbmTkYIxoCbVlWw1q?=
 =?us-ascii?Q?o8zSMIP8+V8NwY2snl4VvcHsMySvKm/kjaJQY+8UUadTwy97nhlFwX0+frVs?=
 =?us-ascii?Q?UnaTMKU9Kuy3MUFMxMo5R1HLfDPnXFrg2+ZDeqoh5nDSCNioRQ+Nvb74REi4?=
 =?us-ascii?Q?lCcH26S4jPhzoWcexH7D32Oav4NQvJeMmqH7Q7bnkfZLo0E9xLxIhq9ntUMg?=
 =?us-ascii?Q?mWPiKuBsHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d13908c-63f7-420c-1e67-08def2232d58
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:23:23.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrhPn5P/XlxpKA32q/q5Bldv9bf/WDs8eGN/xD7Ga06GdhoQF5P+boPq/EwhNf/2+uTpoKzTM7ur/Usi3mXLrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999224

The NVIDIA GHES driver currently decodes the vendor CPER section used by
Grace systems. Vera uses a different section GUID and event layout.

Refactor the Grace path into testable decode and print helpers, add the Vera
event decoder, and cover both formats with KUnit. The Vera parser follows
the extensible CPU information and event-context wire contracts: it accepts
new minor versions and extended information headers, validates every one of
the wire format's 0 to 255 contexts without allocation, and retains a valid
prefix when a later context is malformed.

Printing walks the validated raw context span a second time. It limits
verbose output to 16 contexts and 32 key/value entries per section while
still validating the complete record. Existing one-context output remains
unchanged.

The companion ras-tools series adds a fail-closed NVIDIA EINJ validator for
the non-fatal Grace CMET-INFO and Vera CMET-NULL samples.

Changes since v2:
 - Move EINJ tooling out of the kernel series and into ras-tools.
 - Follow the Vera CtxSize padding and alignment contract while retaining
   the legacy opaque-context encoding.
 - Accept compatible CPU information extensions and validate the complete
   8-bit context count with an allocation-free cursor.
 - Bound verbose context and entry output independently, while reporting
   omitted contexts and entries.
 - Add wire-layout assertions, partial-context handling, severity-aware
   diagnostics, and 52 Grace/Vera KUnit cases.

Verification:
 - x86_64 KUnit: 52/52 passed.
 - ARM64 KASAN+UBSAN KUnit under QEMU/HVF: 52/52 passed.
 - ARM64 GCC and Clang, built-in and module configurations, W=1: passed.
 - ARM64 GCC full Image link: passed.
 - ARM64 sparse C=2 with __CHECK_ENDIAN__: passed (one unrelated existing
   arm64 vDSO declaration warning).
 - Strict source checkpatch and git diff --check: passed.
 - The raw live sections were decoded independently by libcper at commit
   b83878a4aca9: Vera as an 80-byte CPU CMET-NULL event with one empty
   type-1 context, and Grace as a 544-byte CMET-INFO section with 32
   registers.
 - Vera live EINJ: a real 80-byte CMET-NULL CPER from GHES source 8193,
   event type/subtype 0, one 16-byte context, and zero entries (not the
   firmware-rejection record seen with the old selector).
 - Grace live EINJ: a real 544-byte CMET-INFO CPER from GHES source 896,
   severity 3, with all 32 register addresses decoded in order.
 - Both live runs reached the runner's PASS gate with empty tool stderr,
   captured the raw tracepoint record, and restored every EINJ control
   byte-for-byte.

Kai-Heng Feng (3):
  ACPI: APEI: GHES: Refactor Grace decoder helpers
  ACPI: APEI: GHES: Add NVIDIA Vera decoder
  ACPI: APEI: GHES: Add Grace and Vera KUnit coverage

 MAINTAINERS                                   |    2 +-
 drivers/acpi/apei/Kconfig                     |   24 +-
 drivers/acpi/apei/Makefile                    |    1 +
 drivers/acpi/apei/ghes-nvidia-test-fixtures.h |  233 +++
 drivers/acpi/apei/ghes-nvidia-test.c          | 1274 +++++++++++++++++
 drivers/acpi/apei/ghes-nvidia.c               |  767 +++++++++-
 drivers/acpi/apei/ghes-nvidia.h               |  109 ++
 7 files changed, 2364 insertions(+), 46 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test-fixtures.h
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test.c
 create mode 100644 drivers/acpi/apei/ghes-nvidia.h


base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
-- 
2.50.1 (Apple Git-155)
