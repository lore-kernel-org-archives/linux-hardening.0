Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9742E40A;
	Sun, 20 Sep 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905689; cv=fail; b=LeMfGfhRnSufxB6ieA7MmPdBDxfyY2ZsyrFSQR7iCdEwdMwFFNd9BVflkkq8NXMyUZVPAvdBmridvMb/dJIdLVL6B2mYlu0Qqs1L++jaC+JkbVUEdnnwz/YJrbkX6f3UdRRgw5YBfwDZOLm7qSVo5C+kAFEmTV1rk4hEWCwZiNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905689; c=relaxed/simple;
	bh=R6UYSEvrAiCYPF3KG9e5/pMbg6cKMiRNwyaFw+wUqvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aysa/bp3+FdynMJ9TGq++zT5Kf7t2k5GoocXDSl3IOv8I4uvmyNNjv0eU8cJ1aLwjwnSq2UFhmKlJAoHkS0LjIcNEscs3fHT9d4wS9PxJ8ahnGNezGBeZQWFBIg96avnQph47Bmc/51UKFVP16UAXOKA37HIjpxQvzaYPc45PWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/uuQFynBYF+OUAHuIzlpqv3QgxOnDKfUf92ujZyIzrp9XyTY2qKPU7KL3AgcpcS6zNRXE4UQIrnbIqcb15l/DCvFxcEVTVaT9PIqmfrgWCtHJH1h4B94RHYW5QxRsKTgAQ8CBKrtahLubmgt+3kby+7WNv3zeh91VllKLhUUJrVN2PNoxAEmlb/32AEmnU1N7yBBxsIQd4dHLfTYilqc7wnxXMcmltOdYoGIR4fKU7nTxeyjXkLE2BSmMEOtntaLvpzM+DhOW7QTR6hrSivFV5DUEiMJYh65JIQToDCl3+Nq6OL/9tSgxAS2VS8HU0bRhJ+n0a8Q8pMaMAzAsGCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJfrgb32yhCxUNc/I/q0OxnFBZjs1VOkVIZfOhJ9gVk=;
 b=iZIVren//jwSnEPgOWO/YAhBxc25A+draWuIGjoqKdbbT2pSsgAcnKPDs/KxdoEvKcN+/Cf+ewWi5WycRKhSCDHI33fRVmTUY2Q5N+KukVFHnLjmYzU9TltlgA325ueucxHoQTrNfcfUbQZ0nfydnxFDrQsS5FSdK84OAp2LxJiKLd+dy5ZShrTtMh4+clsuAhSYLkwgMlNX5X7V/ygcu3bNpvLBDRfqWJQPCTx38jhAMWzWK4iVDqvytdjmql7Lfqaij0UkMkDuJKfzbCYM3qBF4b0wniNvgf6tgSSa7z0skECn46mrUgFLERaosufL1Rkvkz5GZqhL72jP2tvtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 12:01:12 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:12 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v4 21/22] reset: starfive: Add StarFive JHB100 reset driver
Date: Sun, 20 Sep 2026 05:00:43 -0700
Message-Id: <20260920120044.194901-22-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
References: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::34) To NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3eb2e7-8596-4308-899f-08df170edda9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|23010399003|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	UPppNh/Oc1sM1z4MyJLH3iV7D1GyjGu/SG3bTtfSfOvZiMAVpbfXCX5SC0FspQjf75kybf2uFophZNDpZF28lMI9S9bfGnt0ZHDPsLBmMpVHVNiejpyoLd4dQQImhQKqNUORwHR/OgFCeQLgam5toPAB0I4f0murbFUcNXDGWh+K/4IKfLTzqDzQVTph/9o+pGsBf0E5VABUl+Q8cCB+FlCKD2y2759zNKG/9AqlywMIktyP3pyIdkOLFARe9lJqq4QJNvxzuTMvx5uiheQbeikkDO1Ypai9cAzragKGnrvtqvTY9+jC3ouuH80y3mqMELBclSDnxAMQtd6nC3M6jlvRZZMraVdkLMXbwpBdaCZoG/aioY5JkymkCve3HWVuW86JHUMVkbaPxsJv1rzEawxqimqNsJy1W6Y37oo+1NiJx/TWVspjZJzXY+6X+353qAAVbJ0PBL1Vdb/coJ4p1zhy5FZ2BYg4B2bice/tjkFd82PVAXAuMpl00kHekJEOTyevHmMfrko9+uJjWxTuh5FwiC3SrjSR9V1aj3ihWDUK/Wz6WR3cWun4WjLfCPh6e+yk1abE/QgCBFUsXg8hcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1VG1cDu586mkekUeIJZFHJVKBu3yN6MbJHmWOpstdI5PbLkYx3nxF0Ctmdz1?=
 =?us-ascii?Q?mVTipNRuho9XPKHZ3kqP0CVoTzAFRrYVg/mfVYnkj/wruco2TkjPGYcIIj6w?=
 =?us-ascii?Q?EdKGJGhRvh9b8UxF8ZWbPqsE0NUk+X6jmQk0iqXUVhRqs1PTeJ/+tqWYroj4?=
 =?us-ascii?Q?u8E3koMnUAhb/plAIlle+NUWOO+kN1i203qz+FEnE6+NDV1+K7885yl7W9Kg?=
 =?us-ascii?Q?637nrvCeomVFUnBu1Oa4uFcAYvGvlCcAWToE1NuMFq2W7qvVxSp5ZccKqb9D?=
 =?us-ascii?Q?e2bTpRKH3I4xoVMCOab2udioxiIs0GMWG14e3KmjfO2yyfXQRZAnhji/8qMk?=
 =?us-ascii?Q?BmJ1jz4t+FhGeKlkUI/QIbYILy1P6jLwkIav96qyuXgd06+SEd1Wm276Kp65?=
 =?us-ascii?Q?YRjygCbvnVrLeD9FwNS+cGalfskgNX5VDhvvqrS+Yzb2nAQ4OkQ3u1MLFM3B?=
 =?us-ascii?Q?i8VSUEJbxbtO4p7SFL70W/BZ1FvtK+IOwnU4CZUbHP0Jrhv2/tS00PSnQ5dO?=
 =?us-ascii?Q?NlZgi6riIgprOqaILj2oGLO8BgF8ONp5ogpLBfFXstDK8+ehQQTrtdbMbH6K?=
 =?us-ascii?Q?OLU3jUVSwo/6rqGyEfUqffsBe5aX+FVASSKImc6LxCTKXvq1StrJP6hzNCQM?=
 =?us-ascii?Q?2FcSXd0vEqg8e1sXaKt24K+47d4lLcc8o0mHkdKT26BXV1aOozrkLvCuv8s3?=
 =?us-ascii?Q?4L/lxzuG0fcvouwjsZJnTN99T40u32aJiIjbPBJeUCFMRCJue9mMOlc1IPXT?=
 =?us-ascii?Q?gXdn4ofwP9kDpb2qgb0MR8E6LdBEVTAiCxERpdEAUkHTRf8vfzv4knPXCSyR?=
 =?us-ascii?Q?pLx39Rs0xj0LvV+nqpAbJUgpf4AYKVwRldpMxVh77TQnGCbIqmhwAiF2Pp/a?=
 =?us-ascii?Q?04KqopYmz1el9UhhRjLiLjDtzxKg1VVPVuXkjOZRczrHQXvZRb2OijVF+cr+?=
 =?us-ascii?Q?WA8+QsAxHTe2a3J+zXD9ReUaH9OttW/Dp64IhO5GxScPBMeu1z59XFmIvJ63?=
 =?us-ascii?Q?GQ91Js7Rm5fH0zTnz4mfEkF1yd1RMzX0xYA5kU4+7xzdugwX7sybJd9Hb/Yi?=
 =?us-ascii?Q?cl3Vhi0CYZ9wYeha5R1GpX7FCdS8+JqpN3ppyhA8o3aTqm3USFHlnLGfN5v/?=
 =?us-ascii?Q?dIyEFhqulrdoUPmxpQXTZqJwY8BxWqhVxfM783rao1wWfBE2ShI4gSgtsDrY?=
 =?us-ascii?Q?R33dfepfIUq5OiIiGqmSM1+nKOtj+4hrco9QvONo4FkCadWyLFTpRKGbTfyC?=
 =?us-ascii?Q?DP8pN4CltPrM0WFy4/NYyztA4nhZ/oZkOelFu0WuE5f++8fkboEkQmgrWyeR?=
 =?us-ascii?Q?MKOrBSf5msIar+gNc4pFVIF2m+VJ1Sr3wY/X6iUyp11aNuiUV2/dWEDGaAvy?=
 =?us-ascii?Q?64+3E9NcwcCVcQ2TjMHMVQB6EhShYSrsUz6EabnWosspgGY3vSWqNodXIwoC?=
 =?us-ascii?Q?AHTAnSnDJJTgbHli2rzzoGQDWpsNZl5ezWdYM2yUkMPSaXGIdZMvspvMALD0?=
 =?us-ascii?Q?Lo8tde0nZIxrfn8ziRzovUCphjXsLpc018Ft0auRXNeWEv35NVRA/0Mf+C0o?=
 =?us-ascii?Q?VDvNDv+eSQLFgxE5lxuRTwTw/KM7+Uo7m6TidS5BEUSXLDFnrXbqutD0wMJ2?=
 =?us-ascii?Q?NmxrAOAk49FYi8sE8Xcg50kZLZtnCvGjoX7bN49TKEAZwwtj14JGytXooPr2?=
 =?us-ascii?Q?7lkhMGyWTF7D4nmQAlmAlMHGqGoHgZ3pipCN20SnM5su6AAHaC3Cc5nF2paM?=
 =?us-ascii?Q?3DD3KgfJtcNZipCe0emF45Z5nvV1kTspV5Hdev7mjfSlxe+jSxNl?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3eb2e7-8596-4308-899f-08df170edda9
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:12.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6DvN0Dfwf8UufEzqRgHnC1jlVng5idjUPDytUT2IZGdTpGk/GSva+GZlIJsMtL3H3sTbUxHQWhM+84lLQ2bQ8JFHd+s8ZQyT+90Ta3+a8228LC9R7ankLJTCFtslrGl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

Add auxiliary reset driver to support StarFive JHB100 SoC.
The StarFive JHB100 SoC has discontiguous reset IDs. A new function
reset_starfive_register_with_info() is introduced to support both
contiguous and discontiguous hardware designs.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                                   |   6 +
 drivers/reset/starfive/Kconfig                |   9 +
 drivers/reset/starfive/Makefile               |   1 +
 .../reset/starfive/reset-starfive-common.c    |  99 +++++-
 .../reset/starfive/reset-starfive-common.h    |  19 ++
 .../reset/starfive/reset-starfive-jhb100.c    | 302 ++++++++++++++++++
 6 files changed, 425 insertions(+), 11 deletions(-)
 create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ba842cc5eb2..24c9bf8ac138 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26088,6 +26088,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/starfive,jhb100-intc.yaml
 F:	drivers/irqchip/irq-starfive-jhb100-intc.c
 
+STARFIVE JHB100 RESET CONTROLLER DRIVERS
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Supported
+F:	drivers/reset/starfive/reset-starfive-jhb1*
+F:	include/dt-bindings/reset/starfive,jhb1*.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index 29fbcf1a7d83..ce00495be6ad 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -19,3 +19,12 @@ config RESET_STARFIVE_JH7110
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7110 SoC.
+
+config RESET_STARFIVE_JHB100
+	bool "StarFive JHB100 Reset Driver"
+	depends on CLK_STARFIVE_COMMON || COMPILE_TEST
+	select AUXILIARY_BUS
+	select RESET_STARFIVE_COMMON
+	default ARCH_STARFIVE
+	help
+	  This enables the reset controller driver for the StarFive JHB100 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
index 582e4c160bd4..217002302a9f 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_RESET_STARFIVE_COMMON)		+= reset-starfive-common.o
 
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_STARFIVE_JH7110)		+= reset-starfive-jh7110.o
+obj-$(CONFIG_RESET_STARFIVE_JHB100)		+= reset-starfive-jhb100.o
diff --git a/drivers/reset/starfive/reset-starfive-common.c b/drivers/reset/starfive/reset-starfive-common.c
index 772bdf6763d1..86dbb33bb216 100644
--- a/drivers/reset/starfive/reset-starfive-common.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -14,6 +14,8 @@
 
 #include "reset-starfive-common.h"
 
+#define STARFIVE_RESET_ID_INVALID	ULONG_MAX
+
 struct starfive_reset {
 	struct reset_controller_dev rcdev;
 	/* protect registers against concurrent read-modify-write */
@@ -21,6 +23,11 @@ struct starfive_reset {
 	void __iomem *assert;
 	void __iomem *status;
 	const u32 *asserted;
+
+	/* Only exists in reset controllers that use the
+	 * reset_starfive_register_with_info helper.
+	 */
+	const struct starfive_reset_info *info;
 };
 
 static inline struct starfive_reset *
@@ -29,19 +36,40 @@ starfive_reset_from(struct reset_controller_dev *rcdev)
 	return container_of(rcdev, struct starfive_reset, rcdev);
 }
 
+static unsigned long
+starfive_reset_id_to_hw_id(const struct starfive_reset_map *map, unsigned int nr_resets,
+			   unsigned long reset_id)
+{
+	for (u32 i = 0; i < nr_resets; i++) {
+		if (map[i].reset_id == reset_id)
+			return map[i].hw_id;
+	}
+
+	return STARFIVE_RESET_ID_INVALID;
+}
+
 static int starfive_reset_update(struct reset_controller_dev *rcdev,
 				 unsigned long id, bool assert)
 {
 	struct starfive_reset *data = starfive_reset_from(rcdev);
-	unsigned long offset = id / 32;
-	u32 mask = BIT(id % 32);
-	void __iomem *reg_assert = data->assert + offset * sizeof(u32);
-	void __iomem *reg_status = data->status + offset * sizeof(u32);
-	u32 done = data->asserted ? data->asserted[offset] & mask : 0;
-	u32 value;
-	unsigned long flags;
+	unsigned long offset, flags;
+	void __iomem *reg_assert;
+	void __iomem *reg_status;
+	u32 mask, done, value;
 	int ret;
 
+	if (data->info && data->info->discontiguous) {
+		id = starfive_reset_id_to_hw_id(data->info->map, data->info->nr_resets, id);
+		if (id == STARFIVE_RESET_ID_INVALID)
+			return -EINVAL;
+	}
+
+	offset = id / 32;
+	mask = BIT(id % 32);
+	reg_assert = data->assert + offset * sizeof(u32);
+	reg_status = data->status + offset * sizeof(u32);
+	done = data->asserted ? data->asserted[offset] & mask : 0;
+
 	if (!assert)
 		done ^= mask;
 
@@ -89,10 +117,20 @@ static int starfive_reset_status(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
 	struct starfive_reset *data = starfive_reset_from(rcdev);
-	unsigned long offset = id / 32;
-	u32 mask = BIT(id % 32);
-	void __iomem *reg_status = data->status + offset * sizeof(u32);
-	u32 value = readl(reg_status);
+	void __iomem *reg_status;
+	unsigned long offset;
+	u32 mask, value;
+
+	if (data->info && data->info->discontiguous) {
+		id = starfive_reset_id_to_hw_id(data->info->map, data->info->nr_resets, id);
+		if (id == STARFIVE_RESET_ID_INVALID)
+			return -EINVAL;
+	}
+
+	offset = id / 32;
+	mask = BIT(id % 32);
+	reg_status = data->status + offset * sizeof(u32);
+	value = readl(reg_status);
 
 	if (!data->asserted)
 		return !(value & mask);
@@ -132,3 +170,42 @@ int reset_starfive_register(struct device *dev, struct device_node *of_node,
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
 EXPORT_SYMBOL_GPL(reset_starfive_register);
+
+int reset_starfive_register_with_info(struct device *dev, struct device_node *of_node,
+				      void __iomem *assert, void __iomem *status,
+				      const u32 *asserted,
+				      const struct starfive_reset_info *info,
+				      struct module *owner)
+{
+	struct starfive_reset *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->rcdev.ops = &starfive_reset_ops;
+	data->rcdev.owner = owner;
+	data->rcdev.nr_resets = info->nr_resets;
+	data->rcdev.dev = dev;
+	data->rcdev.of_node = of_node;
+
+	spin_lock_init(&data->lock);
+	data->assert = assert;
+	data->status = status;
+	data->asserted = asserted;
+	data->info = info;
+
+	if (info->discontiguous && (!info->map || !info->nr_resets))
+		return dev_err_probe(dev, -EINVAL,
+				     "discontiguous controller without a valid ID map\n");
+
+	ret = devm_reset_controller_register(dev, &data->rcdev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register reset controller");
+
+	dev_info(dev, "Registered %u resets", data->rcdev.nr_resets);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_starfive_register_with_info);
diff --git a/drivers/reset/starfive/reset-starfive-common.h b/drivers/reset/starfive/reset-starfive-common.h
index 83461b22ee55..0d4e634de58e 100644
--- a/drivers/reset/starfive/reset-starfive-common.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -6,9 +6,28 @@
 #ifndef __RESET_STARFIVE_COMMON_H
 #define __RESET_STARFIVE_COMMON_H
 
+struct starfive_reset_map {
+	unsigned long reset_id;
+	unsigned long hw_id;
+};
+
+struct starfive_reset_info {
+	unsigned int nr_resets;
+	unsigned int assert_offset;
+	unsigned int status_offset;
+	bool discontiguous;
+	const struct starfive_reset_map *map;
+};
+
 int reset_starfive_register(struct device *dev, struct device_node *of_node,
 			    void __iomem *assert, void __iomem *status,
 			    const u32 *asserted, unsigned int nr_resets,
 			    struct module *owner);
 
+int reset_starfive_register_with_info(struct device *dev, struct device_node *of_node,
+				      void __iomem *assert, void __iomem *status,
+				      const u32 *asserted,
+				      const struct starfive_reset_info *info,
+				      struct module *owner);
+
 #endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jhb100.c b/drivers/reset/starfive/reset-starfive-jhb100.c
new file mode 100644
index 000000000000..ed8acd34fde2
--- /dev/null
+++ b/drivers/reset/starfive/reset-starfive-jhb100.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reset driver for the StarFive JHB100 SoC
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ */
+
+#include <dt-bindings/reset/starfive,jhb100-crg.h>
+#include <linux/auxiliary_bus.h>
+#include <soc/starfive/reset-starfive-common.h>
+
+#include "reset-starfive-common.h"
+
+#define NUM_RESETS(x)		((x) + 1)
+
+static const struct starfive_reset_map jhb100_sys0_map[] = {
+	{ JHB100_SYS0RST_RESOURCE_ARB,					0 },
+	{ JHB100_SYS0RST_SYS0_IOMUX_PRESETN,				3 },
+	{ JHB100_SYS0RST_SYS0H_IOMUX_PRESETN,				4 },
+	{ JHB100_SYS0RST_RST_ADAPTOR_TIMEOUT_RSTN,			5 },
+	{ JHB100_SYS0RST_BMCPCIERP_RSTN_BUS,				14 },
+	{ JHB100_SYS0RST_BMCPCIERP_RSTN_CRG,				15 },
+	{ JHB100_SYS0RST_HOSTSS0_RSTN_BUS_ESPI,				16 },
+	{ JHB100_SYS0RST_HOSTSS0_RSTN_BUS_PCIE,				17 },
+	{ JHB100_SYS0RST_HOSTSS0_RSTN_CRG,				18 },
+	{ JHB100_SYS0RST_BMCPERIPH2_RSTN_CRG,				19 },
+	{ JHB100_SYS0RST_BMCPERIPH2_RSTN_BUS,				20 },
+	{ JHB100_SYS0RST_VCE_RSTN_CRG,					21 },
+	{ JHB100_SYS0RST_VCE_RSTN_BUS,					22 },
+	{ JHB100_SYS0RST_BMCUSB_RSTN_BUS,				23 },
+	{ JHB100_SYS0RST_BMCUSB_RSTN_CRG,				24 },
+};
+
+static const struct starfive_reset_info jhb100_sys0_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_sys0_map),
+	.assert_offset = 0x12c,
+	.status_offset = 0x130,
+	.discontiguous = true,
+	.map = jhb100_sys0_map,
+};
+
+static const struct starfive_reset_map jhb100_sys1_map[] = {
+	{ JHB100_SYS1RST_SYS1_IOMUX_PRESETN,				1 },
+	{ JHB100_SYS1RST_MAIN_RSTN_CHIPTOP_SENSOR,			5 },
+	{ JHB100_SYS1RST_VOUT_RSTN_HOST0,				8 },
+	{ JHB100_SYS1RST_VOUT_RSTN_HOST1,				9 },
+	{ JHB100_SYS1RST_HOSTSS1_RSTN_BUS_ESPI,				10 },
+	{ JHB100_SYS1RST_HOSTSS1_RSTN_BUS_PCIE,				11 },
+	{ JHB100_SYS1RST_HOSTSS1_RSTN_CRG,				12 },
+	{ JHB100_SYS1RST_BMCPERIPH3_RSTN_CRG,				13 },
+	{ JHB100_SYS1RST_BMCPERIPH3_RSTN_BUS,				14 },
+};
+
+static const struct starfive_reset_info jhb100_sys1_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_sys1_map),
+	.assert_offset = 0x54,
+	.status_offset = 0x58,
+	.discontiguous = true,
+	.map = jhb100_sys1_map,
+};
+
+static const struct starfive_reset_map jhb100_sys2_map[] = {
+	{ JHB100_SYS2RST_JTAG0_MST_WRAP_HRESETN,			2 },
+	{ JHB100_SYS2RST_JTAG0_MST_WRAP_APB_PRESETN,			3 },
+	{ JHB100_SYS2RST_JTAG1_MST_WRAP_HRESETN,			4 },
+	{ JHB100_SYS2RST_JTAG1_MST_WRAP_APB_PRESETN,			5 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTCMN_RSTN_BUS_NCNOC_INIT,		8 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_HOSTCMN_CRG,			9 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_BMC_TARG,	10 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB0_RSTN_BUS_NCNOC_HOST_TARG,	11 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_BMC_CRG,				12 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB0_CRG,			13 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_BMC_TARG,	14 },
+	{ JHB100_SYS2RST_HUSBCMN_HOSTUSB1_RSTN_BUS_NCNOC_HOST_TARG,	15 },
+	{ JHB100_SYS2RST_HUSBCMN_RSTN_HOSTUSB1_CRG,			16 },
+	{ JHB100_SYS2RST_BMCPERIPH1_RSTN_CRG,				17 },
+	{ JHB100_SYS2RST_BMCPERIPH1_RSTN_BUS,				18 },
+	{ JHB100_SYS2RST_BMCPERIPH0_RSTN_CRG,				19 },
+	{ JHB100_SYS2RST_BMCPERIPH0_RSTN_BUS,				20 },
+	{ JHB100_SYS2RST_GPU0_RSTN_CRG,					21 },
+	{ JHB100_SYS2RST_GPU0_RSTN_BUS,					22 },
+	{ JHB100_SYS2RST_GPU0_HOST_PCIE_RST_N,				23 },
+	{ JHB100_SYS2RST_GPU1_RSTN_CRG,					24 },
+	{ JHB100_SYS2RST_GPU1_RSTN_BUS,					25 },
+	{ JHB100_SYS2RST_GPU1_HOST_PCIE_RST_N,				26 },
+};
+static const struct starfive_reset_info jhb100_sys2_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_sys2_map),
+	.assert_offset = 0x88,
+	.status_offset = 0x8c,
+	.discontiguous = true,
+	.map = jhb100_sys2_map,
+};
+
+static const struct starfive_reset_map jhb100_per0_map[] = {
+	{ JHB100_PER0RST_MAIN_RSTN_UART4,			1 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART5,			2 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART6,			3 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART7,			4 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART8,			5 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART9,			6 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART10,			7 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART11,			8 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART12,			9 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART13,			10 },
+	{ JHB100_PER0RST_MAIN_RSTN_UART14,			11 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C0,			12 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C1,			13 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C2,			14 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C3,			15 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C4,			16 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C5,			17 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C6,			18 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C7,			19 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C8,			20 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C9,			21 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C10,			22 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C11,			23 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C12,			24 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C13,			25 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C14,			26 },
+	{ JHB100_PER0RST_MAIN_RSTN_I2C15,			27 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C0,			28 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C1,			29 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C2,			30 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C3,			31 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C4,			32 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C5,			33 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C6,			34 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C7,			35 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C8,			36 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C9,			37 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C10,			38 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C11,			39 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C12,			40 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C13,			41 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C14,			42 },
+	{ JHB100_PER0RST_MAIN_RSTN_I3C15,			43 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT0,			44 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT1,			45 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT2,			46 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT3,			47 },
+	{ JHB100_PER0RST_MAIN_RSTN_WDT4,			48 },
+	{ JHB100_PER0RST_MAIN_RSTN_DUALTIMER0,			49 },
+	{ JHB100_PER0RST_MAIN_RSTN_DUALTIMER1,			50 },
+	{ JHB100_PER0RST_MAIN_RSTN_DUALTIMER2,			51 },
+	{ JHB100_PER0RST_MAIN_RSTN_TRNG,			52 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC0,			53 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC1,			54 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC2,			55 },
+	{ JHB100_PER0RST_MAIN_RSTN_LTPI0,			56 },
+	{ JHB100_PER0RST_MAIN_RSTN_LTPI1,			57 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL4,			58 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL5,			59 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL6,			60 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL7,			61 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL8,			62 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL9,			63 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL10,			64 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL11,			65 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL12,			66 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL13,			67 },
+	{ JHB100_PER0RST_MAIN_RSTN_SOL14,			68 },
+	{ JHB100_PER0RST_MAIN_RSTN_LDO0,			69 },
+	{ JHB100_PER0RST_MAIN_RSTN_LDO1,			70 },
+	{ JHB100_PER0RST_MAIN_RSTN_PERIPH0_SENSORS,		71 },
+	{ JHB100_PER0RST_MAIN_RSTN_DMAC0_SENSORS,		72 },
+	{ JHB100_PER0RST_SYSCON_PRESETN,			73 },
+	{ JHB100_PER0RST_GPIO_IOMUX_PRESETN,			74 },
+	{ JHB100_PER0RST_UART_MUX_REG_WRAP,			75 },
+};
+
+static const struct starfive_reset_info jhb100_per0_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_per0_map),
+	.assert_offset = 0x554,
+	.status_offset = 0x560,
+	.discontiguous = true,
+	.map = jhb100_per0_map,
+};
+
+static const struct starfive_reset_map jhb100_per1_map[] = {
+	{ JHB100_PER1RST_IOMUX_PRESETN,					0 },
+	{ JHB100_PER1RST_SYSCON_PRESETN,				1 },
+	{ JHB100_PER1RST_MAIN_RSTN_SFC0,				2 },
+	{ JHB100_PER1RST_MAIN_RSTN_SFC1,				3 },
+	{ JHB100_PER1RST_MAIN_RSTN_SFC2,				4 },
+	{ JHB100_PER1RST_MAIN_RSTN_SPI0,				5 },
+	{ JHB100_PER1RST_MAIN_RSTN_PERIPH1_SENSORS,			6 },
+	{ JHB100_PER1RST_MAIN_RSTN_SGPIO0,				7 },
+	{ JHB100_PER1RST_MAIN_RSTN_SGPIO1,				8 },
+	{ JHB100_PER1RST_MAIN_RSTN_EMMC0,				9 },
+	{ JHB100_PER1RST_MAIN_RSTN_UFS,					11 },
+	{ JHB100_PER1RST_MAIN_RSTN_UFS_PHY,				12 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SFC0,				13 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SFC1,				14 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SFC2,				15 },
+	{ JHB100_PER1RST_MAIN_RSTN_DMAC_SPI0,				16 },
+	{ JHB100_PER1RST_MAIN_RSTN_PERIPH1_RAS,				17 },
+};
+
+static const struct starfive_reset_info jhb100_per1_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_per1_map),
+	.assert_offset = 0x134,
+	.status_offset = 0x138,
+	.discontiguous = true,
+	.map = jhb100_per1_map,
+};
+
+static const struct starfive_reset_map jhb100_per2_map[] = {
+	{ JHB100_PER2RST_IOMUX_PRESETN,					0 },
+	{ JHB100_PER2RST_POK_IOMUX_PRESETN,				1 },
+	{ JHB100_PER2RST_SYSREG_RSTN,					2 },
+	{ JHB100_PER2RST_MAIN_RSTN_CAN0,				3 },
+	{ JHB100_PER2RST_MAIN_RSTN_CAN1,				4 },
+	{ JHB100_PER2RST_FAN_TACH_PRESETN,				5 },
+	{ JHB100_PER2RST_MAIN_RSTN_GMAC2,				7 },
+	{ JHB100_PER2RST_MAIN_RSTN_GMAC3,				8 },
+	{ JHB100_PER2RST_MAIN_RSTN_DMAC_8CH,				9 },
+	{ JHB100_PER2RST_MAIN_RSTN_RTC,					10 },
+	{ JHB100_PER2RST_ADC0_PRESETN,					11 },
+	{ JHB100_PER2RST_ADC0_IOMUX_PRESETN,				12 },
+	{ JHB100_PER2RST_ADC1_PRESETN,					13 },
+	{ JHB100_PER2RST_ADC1_IOMUX_PRESETN,				14 },
+	{ JHB100_PER2RST_MAIN_RSTN_PERIPH2_SENSORS,			15 },
+};
+
+static const struct starfive_reset_info jhb100_per2_info = {
+	.nr_resets = ARRAY_SIZE(jhb100_per2_map),
+	.assert_offset = 0x11c,
+	.status_offset = 0x120,
+	.discontiguous = true,
+	.map = jhb100_per2_map,
+};
+
+static const struct starfive_reset_info jhb100_per3_info = {
+	.nr_resets = NUM_RESETS(JHB100_PER3RST_IOMUX_PRESETN),
+	.assert_offset = 0x98,
+	.status_offset = 0x9c,
+	.discontiguous = false,
+};
+
+static int jhb100_reset_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	const struct starfive_reset_info *info =
+		(const struct starfive_reset_info *)(id->driver_data);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
+	void __iomem *base = rdev->base;
+
+	if (!info || !base)
+		return -ENODEV;
+
+	return reset_starfive_register_with_info(&adev->dev, adev->dev.parent->of_node,
+						 base + info->assert_offset,
+						 base + info->status_offset,
+						 NULL, info, NULL);
+}
+
+static const struct auxiliary_device_id jhb100_reset_ids[] = {
+	{
+		.name = "clk_starfive_common.jhb100-r-sys0",
+		.driver_data = (kernel_ulong_t)&jhb100_sys0_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-sys1",
+		.driver_data = (kernel_ulong_t)&jhb100_sys1_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-sys2",
+		.driver_data = (kernel_ulong_t)&jhb100_sys2_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-per0",
+		.driver_data = (kernel_ulong_t)&jhb100_per0_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-per1",
+		.driver_data = (kernel_ulong_t)&jhb100_per1_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-per2",
+		.driver_data = (kernel_ulong_t)&jhb100_per2_info,
+	},
+	{
+		.name = "clk_starfive_common.jhb100-r-per3",
+		.driver_data = (kernel_ulong_t)&jhb100_per3_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, jhb100_reset_ids);
+
+static struct auxiliary_driver jhb100_reset_driver = {
+	.probe		= jhb100_reset_probe,
+	.id_table	= jhb100_reset_ids,
+};
+module_auxiliary_driver(jhb100_reset_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 reset driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

