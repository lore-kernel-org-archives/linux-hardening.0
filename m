Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D6421246;
	Fri, 24 Jul 2026 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895676; cv=fail; b=nm5jaJTJRiFYsvJunXHHIaJB4A0V6JP0CVaVIWHw6cKSDKmsqJ27gJHP0OZDw/9hwKyEWfB7eHXujxAi3KGBwhNz2JZy61XHaxTvLGHu3Bz2bu/Z+wJwy4s8Ls3PnIAhitgAhE/wfedXaXjiRlKOO8SnP3BPfYTyILtWYfbW1EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895676; c=relaxed/simple;
	bh=fYziD2JCA71chJ8csAOhdFgevIk163Kz/4mktR4obh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=neObJ2oni0ppRzMuU5smsg5zzDica8XgkquF3Z5YvpnVugCO61+YlCAJ3a58CNjDTHKYv4OmixzNUkB9oc604AtBnQiUxQv45PuU8LStba5fFHte0i7Jqs16XVy7Rw0CgbQ/lQ8HAT2ZF55QQB6Lcd1iIgL5sVpyMmKpV/UiJno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XAKAiPby; arc=fail smtp.client-ip=40.107.209.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XAKAiPby"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELV5eef6JffnECbA5pyLNbYQxlBafYqcDHmVZztv89CPYiXToWSbnV7TD2WEJmAXcg3mQjWhJtJZ7IHJ2EZd4F5hEncSQiYojvl9dgvhPZG19tMvnNkD1GU0I9r8q7zSo4Ga4StR7V9eukR0YX4XwT5YndigP1zH8mKrGFE1UMydCZ0z9nqZoW+AJBDfE60p9XoO6cVorcBqVYNWQMwsYPe6zAWTQs50qZZC/Mko6cpeAMULGy8PgvBo/i74fC591q48IHfmcz7T+8okjkZVqcDAafjpHC7A40m1YN0P0yS78AGwbpNmmiYImWCJLb4cN3LUw+EKcxATvob4gnWhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcZbxPGcYXYz7Wi5eDAG1pb2JFEUFfarDZN6c+PbE+s=;
 b=ISkWQRbxLYlOAZ59QI7X/Cu6ctqJx+b4IBY/rH2MjahEag4MBkJCeng8yXhnE8NcxDuuzhKgCi1P4m442IY8oCY3XJOkFdSzDusAbSsotE1zFjWxmtNfdQMk3oz11Q5XBKrTkmrhydPqIymD4Urkjy7GQMhLwmR4vj5iipn5e5Dr10np2KdYNBk6mtc9brVeB5YydcUuAAJ//Afdj7rWaPRAv6rWrmscY9Nk62a/l6S5bq/JgPCAEcmiwNbId+lobcfc+iM7EYbbJq18Z8jHWSTR7chsAaDiNIf9LoOLeHuQ1lIdENNSMgAlZsiscOvpzQJOgEm/pDckRGZl6PBxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcZbxPGcYXYz7Wi5eDAG1pb2JFEUFfarDZN6c+PbE+s=;
 b=XAKAiPbyS9xCdyYxlc6AWfNVRJF0AqFe3YT+NXzSZCIy7ElsWzdS62KyiGPQ5H/8Fw3zemokbsFFHe7INrYqMy1RUq0uex7x7LmZxIF2MuxK+xKR/x5JRx9k4t9sFVP6eExIXLSMoP3mDEco6r3nzxkypHStFafoCTUHjMlQ8vHQjeA0zni9RuYxsak5LLQhKRt+XKdJ91zg8hoXueVynl6GMXp2tWJvKGXL30ZL+TLf+auuaIboNxddhiqneXNZty/gtRc663NmoigiDT9vRkcWFFV0emQbVzPKyjJV2kevnr427hHgL82iTPnPlZQV4vah0nvDp0bPYM9WyKrx2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 12:21:09 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 12:21:09 +0000
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
Subject: [PATCH v2 RESEND 1/4] ACPI: APEI: GHES: Refactor Grace decoder helpers
Date: Fri, 24 Jul 2026 20:20:51 +0800
Message-ID: <20260724122054.36162-2-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260724122054.36162-1-kaihengf@nvidia.com>
References: <20260724122054.36162-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c1e265-bb5a-422a-4d86-08dee97e0a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sSAyu+k3IN62iRmQ0StrXXXTFAt8UsYw5cZdi1XFf9J0HzyWMFVTigG5sgrkvOLO+JuU05CHg1HAcC/BPPtuCwjudBFsSAnwXeKpEVvRqs/5b1oXJgotnd9KMhVzC0UOL5Odflu9Mt2t2/6Ify7vbgfKZCB6dt7ULWRLzqXw3eM7dwFaRNK4/zg/JuwPNTc2c35Uz6pn0Z7uSVGtOFH3jyGEZyJszo4I6sJWZkv379JSHazfUJRqDqDwyVwJ0zReBbUJGX4crJZ+/ddoipMoQfTe5BXs6cFpp3LRDus/xjtzcB74k+bihG6+Cdz1v0CJpnubTyXS4fYfnyT3okCn00pA4WQlZUC5ehqLKqra2u/mELtZxy2veJefxhRxsP7KQ2PTFw7Vh1Hw5x1oHNbwdVmqd6JiIel9ws/XqrdmilNBaUsnO4/wyTw5LsoZWZZLGlNlrBGrjK1PJXoktSTH357wEkQaWeGzzTsCkQ0Hfg+aWQPc0sNNZYlGJF4hblYZ8sjEGMHpiLvkZc8X+5mimRxrXwrgo7pYagrfXUhk5sp0f8WLGsYt61rT9Epx58WZFqr3S+elzdMyNHpzKprWVSShdcHfgZFmg5aHy2+uENV7b2ou4BTelZ/pHHdUYu2lFU42NTGmWFgz1qHYR3HJtGk809X4E/xgCWSx1+q5iQU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9mDjGkZndzIb6RDrfjVGKY+W1n7setH1PPxoGOrWKrTwVDnOsBrQ88Per3Hx?=
 =?us-ascii?Q?yeA8fLKCUV0wKmn/qmEHzL/azReiarsDejBC02AlqF9/Dfki4Bh+SDw8k9By?=
 =?us-ascii?Q?xuJsZX7K1d6Ef1gdlMkz46CR3NWbrhDeLUj0FT6YmN1AX1Pfc77WOOb4FUcv?=
 =?us-ascii?Q?cBCFzsK3vDQPg6nvddDoYCoiz6RxT1bFz8vKhx2ri763oPBJZf2lqtq1CMec?=
 =?us-ascii?Q?RbHGy+3G963UZIx/EJv00FTVmSzHnP/IEAcjj/84BLTM0WH3vYldyCtbasVY?=
 =?us-ascii?Q?KRDeB8ZJdSlkisJ7awlMch9YryueOi9YY5TKndGuTBoik3TJ795IuDeKr65Q?=
 =?us-ascii?Q?6/pB3oDM2//ZRFms0AMeU/WgJtXdr8lAsbaWAV7kjlS+dRLQWfldryn0/72Q?=
 =?us-ascii?Q?c9HofwY4kw1JcIcY7lTBnOc5BRv7pJZClq7JhTtOYwZJBykg+jBGLmRV3FJG?=
 =?us-ascii?Q?dMXdq+aQJ4vUExgpjsTxGB3l6tlJWO3R2yxanQsykclJZ1pJgEArRD50Z1IP?=
 =?us-ascii?Q?nMzz81bJoc9x3vjJ0NxxQZm7iCbGns1CmzJ2ffiyjGH4AeA48OVpHD8QojEe?=
 =?us-ascii?Q?p6GL7M4CA2DCwc83I+rO66oLubUYGi/5tdbdE9oMHGMAv6hDOUKfenlx5JsG?=
 =?us-ascii?Q?kIle92n57ZjqOi7ugNH+9fz6N3s1iTlntUFhftoJoGN3YnRxLcJHLLQ6CeW4?=
 =?us-ascii?Q?lY1t7FFTjNdngSHWxkXEpPtGOyELG+tMJyBjWKX4TIOMALnJdJKgnjdMCB5g?=
 =?us-ascii?Q?PagRzKoPJIl49QNHunutWeIAyZPoj7zrhsOoUUm9s2pwaJSa5VAzstosIAo8?=
 =?us-ascii?Q?EskejngfTIHv/MyTwu1Z+I2m/CMkldD0m9RF6YEhsghVM9UCxXuIeG/ljJgc?=
 =?us-ascii?Q?SA05pzwNfKJWhznG7RazkBaOLLSrSoJFsJRbz8T5wSAJb6KCQf51JAChOvRq?=
 =?us-ascii?Q?fB2whUBSKOdhuxJu351j6Fkirfrl96r/C2BifSQLusRcuQQ3ADPUJbeWJeib?=
 =?us-ascii?Q?luhcgzyF6JqnPDzRkied8eED8Z5m5KEpC3dE66mesMUC9O5Yf9PohGzDFbxt?=
 =?us-ascii?Q?EScGG1aqtz92sR9Sr3KGUg867lCKmSX2FZ1s6pUkk3AMYGykwdaTH1x0fUL7?=
 =?us-ascii?Q?UMO59zc6ee7ecO1EYZ6KPZvxZLFzkJr2a8XzaYHuMHGGV11Ht8vT6P7vmQHe?=
 =?us-ascii?Q?tkchrVgHeghSxhYO+kQWRraGGRCRjlX5HAUOgHl+0qh3l+usGRJSQ/t+Clri?=
 =?us-ascii?Q?fxeKyJf1EgLDvXW6uVxI3gw7hFnQhLzKaV7gZfyqCYFkxNSmOue8Ip7lxgKY?=
 =?us-ascii?Q?FWMJL67A6lCd2aVnex5H+tm1GxvubyAHG+5QzTUT60e3OcCKO6N2jQSKd6ZB?=
 =?us-ascii?Q?HAVViiX5HCYknBucsfQ5ETPrwEYj7/WeaGQanqqDTR5ckVNot6ga/PDiYqm2?=
 =?us-ascii?Q?acy7U/XL3ZTFtPAZeF/ORSGNx4xeZUF23WtsTKgx1H441lASf8v6kZM5Ra1N?=
 =?us-ascii?Q?2422Wm9Pvh2WD1lrxoMO0hL+OGqvRXIcOxNZqKW9nspJzQts1+qDZTFW9cIe?=
 =?us-ascii?Q?DeYg+e0T7Tig2OVRWu2dnzf9avXIiIwlK8j+coSRGN14zvxfshJYpRg+VBI9?=
 =?us-ascii?Q?X0JyBy9fkPiV7uXY/BIVTOLXNpemhYmr1/UyGvRGlKOW0wgF56L8Sc1tQfmB?=
 =?us-ascii?Q?A5XQoZr/rXJis9erxNuV11kRqitvqoLV7DcnOS8uw+F2oxiSnmXPh1YQtRnw?=
 =?us-ascii?Q?AoTevxMdgQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c1e265-bb5a-422a-4d86-08dee97e0a5d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:21:09.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAtfDfLl/NEHdemR5bWdsXphi2jSi22x61scr2evkmbts7cM/n/goZp8DMduoV6pQNbiYNn48miCzFP03L46gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032

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

