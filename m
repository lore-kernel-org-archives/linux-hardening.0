Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731124A078;
	Fri, 12 Jun 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266488; cv=fail; b=emo9sfUtEoyDHY5qSh49/Pr3UDOZwfrVDXqKeny7IyT8fNWvFRw3ifHo9Y/gcF3b6GlYzeE2TK82sQX/dnfkvqy9A9ZZuZqJSeUFmw3Vf1bEBRBcGKEwPK42Hrsg/JWkDIoMJmJ5TvQXHwzal4en/623892MeDkv3fUpLBoDSjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266488; c=relaxed/simple;
	bh=ZFN03wnaRYX2E8qu/m/dJwFBH6R+VSNe8+uN1AERmcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VyggUIA1GQnsxExBPbBt3km7CRovcca2TtJQkAY36sqb9XgxtUZG6B9d76Jph23RgNwA1TnpJhmVBVIIJIpCsHh0MLl7c+JcQGdNaigkIvDZAN9N5ob0etg0CZD8POFJ4LNvI7m6djpw6SJHbEsuZonw3hLu8IngHJjTSxNTEtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S45ylUkI; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S45ylUkI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJNTUIWu8VdNRb8fnord8Nw3ae5e/mE1g5cKL9anf4AhDd8FVzPbdluzx+aBkd5nR0Jj/BTyHPt7asAt6oPGzSfXehfIZ7EB6KPfuHzi/xJG4dxOAeW5md6XxPE2beGB7ThC8KZmqNWMjssfcKOTEVG9DCHUWKV7R/mWIAgOnozsp8Oqft/XTOkpQEu8AmjX/JV6HJ8+kWFy8ML1rosViweWmyB5PH0UhlQyVLe9N8RvzDzDgymU4xf8/uz13uKBZ1h0YIzTBVsQjqMM1pis9f3LaWeZuSNX6L7q+GuAFfkr7VHTkmeCVkMuyn/UpwVR2N8Yb93pFv3zBBxDlROOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIJwCbhUgKf3p7EQJ9ZJJAqm7uePkCLpCNagwMXAg+o=;
 b=ufg/f0v32AziOJgeY50jjWf2g4MItq90EwwQbONyVT+6AxM5JPlhTqQttbdOwNH0eNMSt38yYFIO0pnQbxo1C303nydQF35gky+ynEx/iGoER0n7RZsX0UpEJ62omEIV1pwPfU5erAeCOe0JP4mngz0gYpcCU5hWZd9iCZfWG82boCR4TVooujlsJzuzw2brySLJAZy6VTTt2iSrbwoQtRNxYDwgubEvIbj355Awc69VsDkFQ0MI9NHRb13QUdFKgIzlTNlzslDXhK8NthkMSR4ldvPjtcBLBiFIfcUB2O86dcph8iFZU+4nB1fJBLXQaB7hidawkZLviRxFhE0feA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIJwCbhUgKf3p7EQJ9ZJJAqm7uePkCLpCNagwMXAg+o=;
 b=S45ylUkI3yclBxwnT+LZC3dkoCiyEAwCJlqtoZLAIRnYQOrshP2kEVjrrlnIBNs2Usn/JGxNrTUyWD0u+6lnDdaegoIfc5ZlXNHhf8+9kyAs87JsPFGvqOlCcw66TpiecIiIjjEV8PqcAwnZaX0L8ond2Fv5LGHWDCxbfBARGF7fpw9lr2X7FBZjiBefdjIKtSgRseP9QgxLBWxkhiKcZFAR8EM4mYfyjsljaYybCZHTalGIR8MGnsPCG3ru8TlY78AikqITgfySDlXZ0KACMzvwmz6HxQ5KQZsK6Z+0RyNLsnISB0Vlx/SCRuylOQ1G+HEada0tjAr/AoB2pTHWGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 12:14:42 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 12:14:42 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org,
	shuah@kernel.org,
	kees@kernel.org
Cc: csoto@nvidia.com,
	mochs@nvidia.com,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v1 1/4] ACPI: APEI: GHES: Refactor Grace decoder helpers
Date: Fri, 12 Jun 2026 20:09:06 +0800
Message-ID: <20260612120929.28965-2-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612120929.28965-1-kaihengf@nvidia.com>
References: <20260612120929.28965-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0009.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::19) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 89137978-5b10-491e-9d54-08dec87c2f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	63U8EutSVRZi4/3cYhgrjRj6wAOGsBjj4NxGeWUrl8j10EBYQ0IijKQejiTTtRJAS4+xanrvp3ZHzcnwd0fSctLCzP3Wijdp2G07qtfLJad8Oz9Sr9Muk4m/rVB/A/O1gE0FHVGmDi7KprPV/k8cIo8iSQAPE/QN1M/J+rGHE+4F9/MXbboAUgIYsi4IuLguu056rgxzLJT+CGHl44JJx7QMZP3dEEfk1m0gMXT4cFO/Vx7T18deH4okjoJj1xG9HXdXJOzIJKkVQybI36LkWVR77NGu21sjNfUHVL+3QGKPuStwH1aGiaWqNe/7Laamo4bbcqJe1VO+bWScIhtpZCMXKFrWFWCrGOL11xDOZruh83wumxXpzn6G5lWP3qQgXA6dd7nb2tXX3qjZtypuqrfNnSBIEGWY3stHBCGCOLORgNqhumzL3ANkHT1TRlPnRq8N3TBV2kyL/PEzghCt50QG3ShjXr06MgoPKRn0rlG/5ON3MMeK+4yIThCNVT8b3krwlBR2Ck7uAhIFRxF4FsxzeMEU5+Kg8MVCaGG2IgNbmiZ7fWefBPgO6h3I01cTd81pBl5h7N2MiVsjJriYsZrgeoLEeDbjo5z4/EsXItrC7wWXBp/8akN64D1mBegiDwXsb6+96HaMiXHsKdAZMCe44+ABuXBavE7lOR1NVGZ2vbB69Tzyaa7cYbSuuPmG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9xwWvA3CauSVoSmRDPgdrVE/6cQ+4ik2UOw8CmniWnsaVxHdh+WvbYu0aUu?=
 =?us-ascii?Q?iOCanHNx3s+Vz13Rk/Hpvr//bn5IgTu3fCL79AZWlK/GdEaRDoXgmskCZerR?=
 =?us-ascii?Q?MxaPMEPGCAZUqgT+gYPXE6qYgDCcvS7t6jIzOHlCobhEpHIFux3ojodkMWqp?=
 =?us-ascii?Q?emdsv8aeNG250aosAPNJzGDbT9Q2GZkXWI/AO0WZsl3f0ef66DDuXhxoMyjz?=
 =?us-ascii?Q?Bh1sL0G2OE9BzZsuHsGU1AWnyXRhXr2/2rVwY3/7j5uINIPPmWDIMZHpBdxh?=
 =?us-ascii?Q?NQLcGov7Py2a1HjtCfV3gf71ayJ07ELbbs49FyOSB3Z7yzfFZHr53RTvI5DQ?=
 =?us-ascii?Q?ytE9RR5ILNNSVuhChO9zNoYhfrf9beD2UwL8Pk1h8dnqVNy7TjKFq4oBhdCS?=
 =?us-ascii?Q?jSEsufKVPn6W+ap83LXyvETxVzaNuFHx3L9pXezun92tyZv7U50yRUouPj/8?=
 =?us-ascii?Q?pL4u+smtr/UZccLRASZy9n8AF9x2KwoFkiVde9VRWYugfSAE7tpiJmR18LRq?=
 =?us-ascii?Q?D8/PLYSkuNSRc6zh2TUd+N+LDCC5fU9V6gaFlu99qcwwlCcj11d/X/T7RqNL?=
 =?us-ascii?Q?YHlBry8rQraFbTAIgf4cdLiPKipY9e7kEizteXsCxiT1IUzYj3EMdsbpGcb3?=
 =?us-ascii?Q?1csGYJDHh4ntNIe5Kw7NujSkMfD5HDllZZb6JsiGn7ZPjib2k8wJUsNDkY5+?=
 =?us-ascii?Q?1NRANDvlguqJyROVboWOos1N0MXaD+SjGjLtFwvTjVHLEeecHLSkTptGmaoy?=
 =?us-ascii?Q?1sAlfz9Gflpc61evXvVK0LnB1fzw6ybRh9zhP4L5HVanzdw3iOBWJqcCGU7t?=
 =?us-ascii?Q?HI9cZ46JiEtn1qwwNF6INJv1hLPi1+lZe5xsi2Nr0Qo0mqyZP6u/GffYoSUS?=
 =?us-ascii?Q?Lc0/KfBAuYKV5qumcGHfuXPpQ99bhlB2Eq+ieLhGcnOzYsF1pFEyvmgvcvHh?=
 =?us-ascii?Q?NZV8YD9/oTlJu7FwtEyKni3WLMhQYGc+daCS14Hz+G4BZmjclya9S8OBLTJI?=
 =?us-ascii?Q?M+SprysFbmmEQ9SBE2FKgDB3olnpsC/V48m04zAwnFAVxM77MEcRNlSyKZ38?=
 =?us-ascii?Q?lmSnCJmArIQ9gITtrtvwvObe3wIhVSa5y3jih4xJOXSmbS9Z8OFPfRnYGKRj?=
 =?us-ascii?Q?Tny74wXiInjNNWdMJ/5rcn3oAxJ5o4BO8EhK7Rdrzdoc9LsaDeeGBUAtPj3c?=
 =?us-ascii?Q?2QRgRKMJzhH17FOVRb5ZXkxj7Gmh3psT7Owr1ed/xIrn/Ebs4Pa5tT255zYp?=
 =?us-ascii?Q?IymVzuLJQiO5y31trEb6UxVauIzUCL7cynEFajEGZQGurbWyvCT6gXniLFCr?=
 =?us-ascii?Q?6BqeqN/bnNrK3VaYf3eIU8yjbdPp6/klOkbCV5kNP96QtKerAWO3ujOiUf5e?=
 =?us-ascii?Q?IsEW1Vuuse39o5PthnRruOUUgugkqeyDTtfkcB/mlwGyCsgXMVEjCslkAZO/?=
 =?us-ascii?Q?5WIZOLbiRTKaxay7tTlxL2ZC3liNPiGruA0pfP7wo+TJ+VotEtD8AJ+sj34b?=
 =?us-ascii?Q?NYzqrfIzRerLaXilrGznGrYflO5P+bFW0AsqTwowxU3XjY1z0LEgSVnGMMQi?=
 =?us-ascii?Q?BKQ6A/DC5mzRycvQxWGLPT25EvcUByytXil4KHNz58zX+GRt/ZNgsgDKJ6Q9?=
 =?us-ascii?Q?c8ylQNYXR2/HEN77e3q4N1UnHjPxbzCk7t02L2HTHV4EZPqfRqsngnlTLw5A?=
 =?us-ascii?Q?YlRhUEqZufVUVb4Jnaj8Xd8eZ78OdcOjDXg7YfjKtqEk11WU5zOMRaBz0ww0?=
 =?us-ascii?Q?fG2YEb+1FA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89137978-5b10-491e-9d54-08dec87c2f0b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:14:42.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hsYgknIw7Rntn8ajrLi/vb4PONyqvOQQNjl+kHuQ4L5UAgCXwnrylX+4h1ynC+Xp+veZSPmDE1h+ZgYCvkEFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459

Split the Grace CPER processing into a separate decode step and a
print step so the parser can be exercised by KUnit without a live
ACPI device. Introduce ghes-nvidia.h to hold shared types that the
Vera decoder added in the next commit will also reference.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
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

