Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15643E06B;
	Fri,  7 Aug 2026 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102222; cv=fail; b=IsI4oc9wiq9MqaHNFSzYcSgMUbOZHAo+cnJzf82UxQqqqHXPxZyu9wXjVYv8OOw+3Xad5xHD7NxyGXt5sCkULXY+UnRV/j3OCbplhs3Ozk4CO3Y0gzdEoAu+MvhYaqBNiffQZSEcP0byvXEdsKl3V3J237rNSSPiG7mDA7AZyI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102222; c=relaxed/simple;
	bh=9BN6lX08JipSeYJPrY5YeM6W9FLAMIJMm5f56jpGb8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kX9H7ND9lJsriZ4RIBZZzgGi0pSF7oONDWhW8ReEcCD7580XiAi0JeMWRmFHXkFXFTuRUrGJ6mbMelKXQPvpGM4zzdlNfUazpWHvyYQPuM+rY25oQCcP/ucwg0yL1vssJBRPSQ96WkGHlB6odPFNpncOlLpWbxpqvZ0g3LlYK8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVwJ39deL3lBFLba+ejxMI3YsDw+fMYH77WU3hCIYk9A77QGEsd/RrSr2M87fM0Cd8hdgz+/yV9me9kDCJmz8Huj74Q2Tku7wjLZGAO5wKFSiY6QJkZgkBVZmgD8uwHXvlNoEVKgOodHfyu0EE1qeonevcON2VPs2GrhIs/xgjA/965o1g2kQ8Z5x5XB2BRQ4+x1hx7VYCIsxK4mc+PbTc+k9rHhzOiZdW4Z1dWRuIKV2zfUBgoWwsU6QI0b3grvfn3gkUYYOcNhEaxBAKzkdni4bT2DUXoknpYDS9rV1fvUD7sija+L+Wp9/qLR2HlWDWRZBYM4k/AaYF8HfPvv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR8pOeupDxcAXxxRzOG20WYMyMqyGW5q4w3ERpXKFT4=;
 b=iOaBscs0VCJ2TTAopkl7jn+uIabhCiiJwFRwjmSw7b4bEWlXUbb67Nj7Axeu1K72TYfTuQgOqJqL62ZqGUMOYGDp1vSnjrC7e7SwDzLT1S5wvVGMQOyx0YE/HZY5b1F4srRlRwLpEoImWyL47+rbXlOdU8cCjz9Iu5vps7oqI0rFxrpgiRMvrhKTLro+bNjPoqtHHKSQT0TyAUhycnVxMCPAIYoq9jiRtptIi232a3QdcteA549KrvTG2BWYuIOuGSGPWoCJhzvtURkGDejnjldmrmSbkEowZJjjQSjkGPkd6EFMEHoMhl6IeGatoUNTYrgVFJmZEsiv+7dIpm41mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1251.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:30:06 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:30:06 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
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
Subject: [PATCH v3 21/22] reset: starfive: Add StarFive JHB100 reset driver
Date: Fri,  7 Aug 2026 04:29:22 -0700
Message-Id: <20260807112923.191627-22-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
References: <20260807112923.191627-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::19) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1251:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a8662f-0732-4269-69b5-08def4773ad4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|52116014|10067099003|56012099006|921020|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	N+Mzfxc6wigcdtFsMYC6Hkds9khrqyeUTxxr3LToN63DsK5IMlcCqGhIM9ItpjaNsESVTqO0S6dJTMgbbsU+LH0GcyapihCHkOCWQYw0QcbGQ3v/sDKIBCY+NIA7++nMKVCwmzqrBO236p1CQC/ABvfzLeOiDbBWOH5cJc35l9fTSPAtqgWN5Wtkxwk/AAzn7zCzaF9jQDGsMZPTgXE5GPO9WYDnSDdn91Uh1r7ozALBU3Ni3rum+n6Xe6sY10gktUSKFq4lG5wFh0XyBlpA0PL/0wZs8o8+YKAVi50SqbLSG1LSc2GV3ogDkuDmcyrBrXtIxgEpW0lk2tQW5L4rPkuCNkyJ/eudCYJV2D4XTnvJ3TA9El0dswZW0FVM1iQq3Of0xZn7kKRkHrIoc25kJc4EOkqc+7NJB7ww47oIIjon0dM/kvWOUaCNqVIprWVJPL9sNPTjNEzB4TKA/7ACZ4iyjNp+Oz8HBKLrkG4xTAQ7x076txtSt1+QSj0vqS/ein1TdDsFa7qYrKb+lUmR7uu6t3XM9LCLpIVy0LpDUk+iA+MwlSpQ2g4UJmzT8yYemjx3vLzLhKob6JElEp0tzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(52116014)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvSvOEvrRLEisxzChPI3b3DiIPUPF/ONMdJz1AbR6PDDZCY5q6VnUHY7Ebok?=
 =?us-ascii?Q?Ue5iDU24hFpXVS+QSJRI93hacILl1TENJknRE9sRzkEfZJV7Ef0rLD3bOMKu?=
 =?us-ascii?Q?BIJU2jwU1LkiZuV5UDt6StKfUBeK/wP6SpsJCj+3wXAvigAZZWTCpHVoynuP?=
 =?us-ascii?Q?t0elfWHKWPsaXqUIb/pvRtN3EWj4k3iZVhCQAwW43DQbqS3DyG4Qa1hPapWJ?=
 =?us-ascii?Q?zzD+XScLBdi2o989jqElcE1rOF7GVdy3tnBIkKU1SPiz/igzb74rrsAnw38E?=
 =?us-ascii?Q?n0IaRLcioXDxJQXm84fEt//Ce32JuQsWko/PG0LQE/8XsKuKTD5dp+rQMKaL?=
 =?us-ascii?Q?vaVp7i6KALb4XsmIv2gGxv9rH9ctHTBTBd2q0enNg7oI/WZikjiN0Az7PDOK?=
 =?us-ascii?Q?91lkaMXnnRsHUz0bX65yXfjmtpLwc2xuIQFgeDTaen1vYK7KA+h8LzaF17hF?=
 =?us-ascii?Q?h/vlsKjqdBBByD9+LLOsCwzIeavsq6tv/uRZP0WaeU17IzgskwA1l2uP2otE?=
 =?us-ascii?Q?4+gkCTcPn/+eG2betJrZnkPqDKsee5vbijKbgYxSZut1200tqzN6sH8F/MpT?=
 =?us-ascii?Q?EYuvOBiWhCmbSjCaDtrQcsQj7pDRgUhfVyweH985wZQYtOdJxsx/+MbAIy+k?=
 =?us-ascii?Q?nJY12HnGFtrPXKsDIKgu9LqG36v7k0CTRLIFpA2gxCBa2K6Bp57DtPorVsMQ?=
 =?us-ascii?Q?0RETcGwYNEupn3IuVUc1RWPoBQYWi8k1H3rIhlZecn43f3WsurYxpsQgyLHq?=
 =?us-ascii?Q?LjnR/Us37Q14iIsX2+t4Yy/kOVMG63NkFKO4+LiwjXevVftRkQE52+F9TK/u?=
 =?us-ascii?Q?OaOJEJbfEWsl3lOcoyisw5sWW18o5vGEd37MP0R8YZeTUS/ny9qYv0CQ25QE?=
 =?us-ascii?Q?S/XqoAmlBG6ZQUwMlorajaGKyEN8CaF8YTb/8TIkn07n/tayWClaQyj3Brge?=
 =?us-ascii?Q?eNTLpeL8Smwy8olYc2DYMqQEVZ8FHVeTF8/zItKkaoo+te9+wYMTf/5Av1Ao?=
 =?us-ascii?Q?40ByLLlsNM3exUXYFe9f9/Xa+nkY4f/xjOqW1qv6TH8lztp9gT30YnOQlY8H?=
 =?us-ascii?Q?YLcvOUUx8khqPwfF5SJYdHAoV5PUhRYjqNyzjudqtRqfDpyaict97iXNXKck?=
 =?us-ascii?Q?OkxQyj1UnuBATwitHIchG94t0CDXibHb1xbd8oo/84FhPOuVNfy9iumfVlZS?=
 =?us-ascii?Q?WRvs7l12O2PFEpOqHSWG2UY9EeZl93QVrRRFm99qtwJHLEF60cuHxvp/GPmh?=
 =?us-ascii?Q?Hy9InchiL/cKG+RggW0LJmKrUrvhbT4iuAwhL7tIHnfumzFL7OAOWL/CCAfs?=
 =?us-ascii?Q?qqNHUlrKv05umBB/Lci/JzBs/TLm+oG+i0UebcnW5DO7C5jomldOAOkGgT49?=
 =?us-ascii?Q?vaZng+e9MapWCTiaPPOnxGXdnthyZH3uelef64WlK8ICHQ/ycYKzNjM+afW2?=
 =?us-ascii?Q?FuXItOx8h7XLAfFFsjQpIKe23m3WfyrbT1Yh69gH1DNOoVf0RHcvIbPZ5y2j?=
 =?us-ascii?Q?aa7CLg9e1bAL8zqOjN4B0T2ZwA1WksFEqNKLrxCKukWGp8SXS0nfsQTCoTqj?=
 =?us-ascii?Q?XPZNOWAt3hYOyIcsNn2YX1A8Yc69xBDnQFqPGb06P9/oHgoCSSC/f3TlSRBc?=
 =?us-ascii?Q?JqotUFyzAs5lc8s8xCeeOFhjKN93HOE2fwkAzCr37AmdSJyxvF+QwdW/PJHC?=
 =?us-ascii?Q?NsiAN3anSqIj2wQTofPnV6uNnQenU9BmCSEPHJ/pD6V6/ePQjahtyYDyInBc?=
 =?us-ascii?Q?j1zBSNx7WqxTShwqrRzZEXqlbmur8CuEGWOWKj0GnEu7/I0y2PX8?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a8662f-0732-4269-69b5-08def4773ad4
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:30:05.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGfkvIZ6jOh2Zo7xKTNAhiihT4uZQyRpAK/mlVqVFgxk3qB+bdkzHvMuES8cbJLM19aMGs63QdzBK2W9RBqYaqG+pFRuh8lPmTT/yIN70BjmMz5skUGM90W51WYZXcmg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1251

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
index c48b56d0ab94..709600e80951 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26088,6 +26088,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/starfive,jhb100-intc.yaml
 F:	drivers/irqchip/irq-starfive-jhb100-intc.c
 
+STARFIVE JHB100 RESET CONTROLLER DRIVERS
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Maintained
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

