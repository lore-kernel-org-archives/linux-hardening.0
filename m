Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A463E0C77;
	Sun, 20 Sep 2026 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789906696; cv=fail; b=SVxszTp8X8fn7MteglfK7EPiNyQ/t0in0IMTs35v2BndmFPV77B6U3oSbaMjvJZYwdZywpCc02pSk0OdV+hBAfWq19cxWQwqPPOo8qENnQZKyYBE5RxlrsSftbXxDehh7q+dHSgBmSj59SsnFc2tDjbk584wLJrRiCBuL12Y/+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789906696; c=relaxed/simple;
	bh=f2EhFHrBDaTYA4ioTZ+XW4lzrXRUNEI5U5WM/50XJWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovrgN7vpiZmXjhKpcHyhSDdA2E7xGWRJlvreSLrMCyF8tnVuFZixd+RX6GBKJIy4LpeP+upzt5Kw70Gb7L2bGOEHJvekh3a8paLhYRxrU9xw8bkP4FWSub5HtRloDRaXHIBfoCVzSbThBlLgU/MREa8Ocwq9GDn/czqkdPoZcL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cux6BtwsTIYA0Om9VqFFehkPZulmRFc3iUg1Gp9BVfS5Adr5CzCUI5GnN90YoHQfaIBBasQNj75v9ciR6fTR5LcjfYICSsF05jQIXvSaUiEs31QLRT/mTT68mwTo6CClRrMZ6bQJsG+8v+muaxZeJEQVLAT+f0iriXFTICDJ5Dace4Srap/kwFtF5cRtfkItEbQ7Xp0XSB+diWZzKY7hfAxOZ81DVikM9eugQtpz/lZuLeMG0L4NwiCsa8wslU/fobh1LNLO6Kk8dUYDm25OZq1aH2SM7v/G+rw9x4jTkG4eltL5hBYHbx49ZnmfTrfur7swX17WqUFgHIg8ate2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifYykmmO74eWDJQt8MyyLiVFjLkS4JMs8N85CVtpNPs=;
 b=ED57/SblQYph0B1LVTJxfTVqXz8Y9t8SRuiFaHw/GmsMBJ6DzQ34I4GJsbhtMsayqW7eWMAZ1QXoAUwF7nLu16eMxa3oCUXHlvzqdGvBp820NgWpmnS5ODlDlxXrBTO0YRHGcWJnd44oA4SU2YK5dVSX6/w5poss9a2URf5+YWgPCYxKXRmmMeS1m6lbVqrcC7JclWf8TzilohIzxwlp1Vb9RExLzak95EcYPQ/K9l/ZqF+pfFNepXfVRF8qNPzJUjDxV1WCPxjESH1P2AlI/iHdEx6xUvyCCxcfHYwTv7Zr/wBQmPGcAN9EqqaDawssCp5a6nSJwrFRN0X85J0tsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:00:57 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:00:57 +0000
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
Subject: [PATCH v4 06/22] clk: starfive: Add JHB100 System-0 clock generator driver
Date: Sun, 20 Sep 2026 05:00:28 -0700
Message-Id: <20260920120044.194901-7-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1070:EE_
X-MS-Office365-Filtering-Correlation-Id: c780dd6e-dff4-4f29-738f-08df170ed4ce
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	85P4cLsh+IZn7aZig6mpx4eWehhUSJWn5F0sMefahSWhufJdsss2lwDcEZDodqeE8iKlmk51rYX9e/dtVNF/YcKLZuUmijSkoDzROnYvdvB0c4jKMi79NGZoU+t8ZO2+eIFqM4sZraIAb6A0uEr3VExTD0pdwmQl3chVtBhJzXjKiWj+C15vxALpEfPlgvkb6EcAG+CBiWtMBgDVOLkyuRV+Oq2mLwLOmjaadxoiYNOZquwG03+9iNkLk68Y9cJZmc+mryvhsFIn8ls824NVrWWRkEqSvNXN9/tZwxqXO7MZf7jABtQEis/kN5UckPzS/cf7t1biogCvQF1+dvv1BZeAD/ew1tkQrJW52jk+1dLsRNDK6ISdpCqUdCJ7SkfeK129If34ugGbpQVOknV2Am3uB4HExf6XVKoKgoheY8D4wdWzH+M9d2DUX3sXZCcBMLmTKcsRfstEGJFRa8SAZNGyVwqVEfRKxKI0Iw7U1XgU0zJHTb41I48uMu5FHsAVcUxCdWa5nvoFpqwyyurp2Iuyzw3GWNIJpLOBxDA5wUGptjuqQnTUxs51u8agtk3gAvX+Vin9Y6W+QMuZmcZQng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TkoQDnXhFrtJrk+LZU96LozyQSrmbxzG7pO4aO+PitOsWuKKjj4RLLt2i737?=
 =?us-ascii?Q?5lg6RVriwfVIZeSibrPWCoRMpVQU62BB1WXx6y16hq8DvD53/NsbFEv/S0/F?=
 =?us-ascii?Q?R10Iz2NrOlc2rdDMWUQSV6QCaWmrea4Sywih2kXPdfrvQOkV4nlIDEq04oDF?=
 =?us-ascii?Q?Xu5b7RrBwWIvID2/WSMLA0xkNrNA3RTzHNF4qWGH/hIScATi+B1mlBnBRve2?=
 =?us-ascii?Q?eHB4pOl+32vw6QNNmG2d8B07mqWdAMqpwt7M2kvXKuKfnn+hegc7G7DsUubm?=
 =?us-ascii?Q?xdu90GjXExSHqwq0E3dzNFEvRdbQ/NGAXWZwtkVR8FQxs9enQ/LaS6VqhF2+?=
 =?us-ascii?Q?bPwGWqUbQa+DCbmxkM2yYa+zdroIS+Mlp38g9fZKHH9ITpHenUoLZ2Ss7H7d?=
 =?us-ascii?Q?xL6t2tEGJ9BB6tzKrfyYuISjkyoZqGzt4akPV8D1PxkWEoAWOlckSQ1R2qI1?=
 =?us-ascii?Q?Lbgx8D+cmop4txZMPxpLrd0kEmjIkMI391I9TCSIcc+G08FtQQQjVI5leVMR?=
 =?us-ascii?Q?xFMNIaaUCvCiy9AZvC1QEtus4kmb4l+M9KGvzUBclIlaORnCR1sGNw+NjPcp?=
 =?us-ascii?Q?QjGxkxIZssx4uuFo8O037giUPBD/t30K/vJV5vG3hfZnvZeFM2JMv0YPbLfm?=
 =?us-ascii?Q?wnycgOnpyaU9TsTAOcAH2cjogn9XkDawAUL3prydVP05ShOuiSuxEXsEQj3+?=
 =?us-ascii?Q?XfMLCxT+yViqhcsBv/+LAQHpW+6afu6agcKg1gFpmuIOKMHaL3ZJNZylJmh1?=
 =?us-ascii?Q?dDKmVktlL6MPglTt4isULKu/CaMH/VxCz/04q616nMLCBM37SqmALD/a61fC?=
 =?us-ascii?Q?aYsNoNl/qcL3LuMNLh1SrmcjR8nm0wSbnSWDaJQ+HZSBMf1ccfEBmkOEIGNs?=
 =?us-ascii?Q?uzmAGJRE/NC2udkXDXs+x9J+H5i5Q0vMdLoQnnZptq64o8EK+fBXYPWkBxI3?=
 =?us-ascii?Q?RuOCVryHxYOfUqoH+Y6RwzzGtJkKLUiT49WbULXPH65dQx1DFTD1wXLKeZwh?=
 =?us-ascii?Q?Ths5wxB3WB4pWyzeL5oZVAo9mulWltO58oHXqS7wjqMo/862pae4rY/pyFOe?=
 =?us-ascii?Q?U+zpoGbIRj3G32Y1qcanAnbBoAtUDwOcO9uCGs1IJtXDcGv8iNo7FUZ75oiU?=
 =?us-ascii?Q?m39O0aKKcgP4obvNT52yI55UqsDPsZu8212loo9TD5/557Rs+EQ+QdXAPnwl?=
 =?us-ascii?Q?EkxDZI7DQsA9QcfPUahAx319IuWBoaJrSdg1rRGxnNDnsgtd8j//zEyFxg5K?=
 =?us-ascii?Q?a7huO50BvFd8C75pC6SEzjXfLfbSdibHTww3jc5srq+ZucNfJJLJs9eBU1EN?=
 =?us-ascii?Q?Gwy+ut7pRm5VvtzGNJ3Dh8HYVjdid26A7EqT/wd8lfbpIuAyu04izalvVLMj?=
 =?us-ascii?Q?6Qgxu0KVkiTfL5h947jyAvjmf3IuszWd5CTslFqg6XJsZCJJTFX85kaw2Jy3?=
 =?us-ascii?Q?UJ02Vuh5BfIzZwXDV/NAQgJ37ZkTF2C8TBvzXjYQ7l0v5nnJpg90DUfW7YMt?=
 =?us-ascii?Q?kIkjTlxir4NOhLOEHhPvOKC0NZbJeD646YHuVfQQIciK0ExgvRqYhO4vU1pW?=
 =?us-ascii?Q?o/N2prBi+b/q7qX0zzEGSBMi5GrZ7LNsXKd4r1SclpCGs+Mt2du5IONmCBVV?=
 =?us-ascii?Q?2B5jk4ZP3LD+i9TmKgVANdQx68VNf8ErHAYzIfq6v3KbIrFN3iHwK9U2QmWo?=
 =?us-ascii?Q?5Mc2ddMGjVNrBA/gfAmrcdfHkm1sHa3PMq9isn0rgBmGtnQ8dOMBlpn6lcbA?=
 =?us-ascii?Q?V/EcGHl4UD8+10MkcVrb58W5C2A/Qft140aPJc82wJVH4qI3Qxt0?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c780dd6e-dff4-4f29-738f-08df170ed4ce
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:00:57.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zB8gsNoRBbWJ3IuIDwqIvmgG1wA+Iu10Hk9GfPrXrjx6a/XDKGNpkaJmPl7NRR2lAAldrbmZLyB+IOqo877gHVsn4LdNwkElAyulh9mKt+wkOS4Rr9OvpZl5q7sCek4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

Add support for JHB100 System-0 clock generator (SYS0CRG).

The StarFive JHB100 SoC has multiple CRGs with similar probe flows, so
a generic starfive_crg_probe() function is introduced to facilitate the
registration process of other CRGs in the future.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                                   |   7 +
 drivers/clk/starfive/Kconfig                  |  11 ++
 drivers/clk/starfive/Makefile                 |   2 +
 drivers/clk/starfive/clk-starfive-common.c    | 147 ++++++++++++++++-
 drivers/clk/starfive/clk-starfive-common.h    |  12 ++
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 150 ++++++++++++++++++
 6 files changed, 326 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ce97de46e610..8ba842cc5eb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26069,6 +26069,13 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JHB100 CLOCK DRIVERS
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/clock/starfive,jhb1*.yaml
+F:	drivers/clk/starfive/clk-starfive-jhb1*
+F:	include/dt-bindings/clock/starfive,jhb1*.h
+
 STARFIVE JHB100 DEVICETREES
 M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 L:	linux-riscv@lists.infradead.org
diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index ff8eace36e64..7926e02ccd7d 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -72,3 +72,14 @@ config CLK_STARFIVE_JH7110_VOUT
 	help
 	  Say yes here to support the Video-Output clock controller
 	  on the StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JHB100_SYS0
+	bool "StarFive JHB100 system-0 clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
+	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the system-0 clock controller on the
+	  StarFive JHB100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 012f7ee83f8e..2c5e66d1d44e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
+
+obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
diff --git a/drivers/clk/starfive/clk-starfive-common.c b/drivers/clk/starfive/clk-starfive-common.c
index 9c0eb7a50d1e..9678616d293d 100644
--- a/drivers/clk/starfive/clk-starfive-common.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -9,6 +9,8 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <soc/starfive/reset-starfive-common.h>
 
 #include "clk-starfive-common.h"
 
@@ -331,9 +333,148 @@ struct clk_hw *starfive_clk_get(struct of_phandle_args *clkspec, void *data)
 	struct starfive_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
 
-	if (idx < priv->num_reg)
-		return &priv->reg[idx].hw;
+	if (idx >= priv->num_reg)
+		return ERR_PTR(-EINVAL);
 
-	return ERR_PTR(-EINVAL);
+	/* Index space is sparse: reject holes that were never registered. */
+	if (priv->info && !priv->info->clk_data[idx].name)
+		return ERR_PTR(-ENOENT);
+
+	return &priv->reg[idx].hw;
 }
 EXPORT_SYMBOL_GPL(starfive_clk_get);
+
+static void starfive_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void starfive_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
+
+	kfree(rdev);
+}
+
+static int starfive_reset_controller_register(struct starfive_clk_priv *priv,
+					      const char *adev_name,
+					      u32 adev_id)
+{
+	struct starfive_reset_adev *rdev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev = kzalloc_obj(*rdev);
+	if (!rdev)
+		return -ENOMEM;
+
+	rdev->base = priv->base;
+
+	adev = &rdev->adev;
+	adev->name = adev_name;
+	adev->dev.parent = priv->dev;
+	adev->dev.release = starfive_reset_adev_release;
+	adev->id = adev_id;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(rdev);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(priv->dev,
+					starfive_reset_unregister_adev, adev);
+}
+
+int starfive_crg_probe(struct platform_device *pdev)
+{
+	const struct starfive_crg_domain_info *info;
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	info = device_get_match_data(&pdev->dev);
+	if (!info)
+		return -ENODEV;
+
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, info->num_clk),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->info = info;
+	priv->num_reg = info->num_clk;
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	if (info->power_domain) {
+		ret = devm_pm_runtime_enable(priv->dev);
+		if (ret)
+			return dev_err_probe(priv->dev, ret,
+					     "failed to enable runtime PM\n");
+	}
+
+	for (idx = 0; idx < info->num_clk; idx++) {
+		u32 max = info->clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = info->clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = info->clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		if (!init.name)
+			continue;
+
+		if (init.num_parents > ARRAY_SIZE(parents))
+			return dev_err_probe(priv->dev, -EINVAL,
+					     "clock %s: too many parents (%u > %zu)\n",
+					     init.name, init.num_parents, ARRAY_SIZE(parents));
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = info->clk_data[idx].parents[i];
+
+			if (pidx < info->num_clk) {
+				parents[i].hw = &priv->reg[pidx].hw;
+			} else {
+				if (pidx - info->num_clk >= info->num_ext_clk)
+					return -EINVAL;
+
+				parents[i].fw_name = info->ext_clk[pidx - info->num_clk];
+			}
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, starfive_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return starfive_reset_controller_register(priv, info->rst_name, 0);
+}
+EXPORT_SYMBOL_GPL(starfive_crg_probe);
diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index a03824e9e75f..4cd4357f8366 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -5,6 +5,7 @@
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 
 /* register fields */
@@ -109,6 +110,15 @@ struct starfive_clk {
 	unsigned int max_div;
 };
 
+struct starfive_crg_domain_info {
+	const struct starfive_clk_data *clk_data;
+	unsigned int num_clk;
+	const char * const *ext_clk;
+	unsigned int num_ext_clk;
+	const char *rst_name;
+	bool power_domain;
+};
+
 struct starfive_clk_priv {
 	/* protect clk enable and set rate/parent from happening at the same time */
 	spinlock_t rmw_lock;
@@ -116,6 +126,7 @@ struct starfive_clk_priv {
 	void __iomem *base;
 	struct clk *original_clk;
 	struct notifier_block pll_clk_nb;
+	const struct starfive_crg_domain_info *info;
 	struct clk_hw *pll[3];
 	unsigned int num_reg;
 	struct starfive_clk reg[] __counted_by(num_reg);
@@ -123,5 +134,6 @@ struct starfive_clk_priv {
 
 const struct clk_ops *starfive_clk_ops(u32 max);
 struct clk_hw *starfive_clk_get(struct of_phandle_args *clkspec, void *data);
+int starfive_crg_probe(struct platform_device *pdev);
 
 #endif
diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys0.c b/drivers/clk/starfive/clk-starfive-jhb100-sys0.c
new file mode 100644
index 000000000000..eb3cd33e2309
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jhb100-sys0.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JHB100 System-0 Clock Driver
+ *
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+
+#include <dt-bindings/clock/starfive,jhb100-crg.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include "clk-starfive-common.h"
+
+#define JHB100_SYS0CLK_NUM_CLKS			(JHB100_SYS0CLK_GPU1_NCNOC_INIT + 1)
+
+/* external clocks */
+#define JHB100_SYS0CLK_OSC			(JHB100_SYS0CLK_NUM_CLKS + 0)
+#define JHB100_SYS0CLK_PLL0			(JHB100_SYS0CLK_NUM_CLKS + 1)
+#define JHB100_SYS0CLK_PLL1			(JHB100_SYS0CLK_NUM_CLKS + 2)
+#define JHB100_SYS0CLK_PLL2			(JHB100_SYS0CLK_NUM_CLKS + 3)
+
+static const char * const jhb100_sys0_ext_clk[] = {
+	"osc",
+	"pll0",
+	"pll1",
+	"pll2",
+};
+
+static const struct starfive_clk_data jhb100_sys0crg_clk_data[] = {
+	/* bmcpcierp */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN, "bmcpcierp_ncnoc_main", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG, "bmcpcierp_ncnoc_cfg", 12,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_PCIE_REF_CML, "pcie_ref_cml", 24,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_DATA_INIT, "bmcpcierp_ncnoc_data_init",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG_INIT, "bmcpcierp_ncnoc_cfg_init",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_NCNOC_CFG),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_NCNOC_TARG, "bmcpcierp_ncnoc_targ",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCPCIERP_NCNOC_MAIN),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCPCIERP_PCU, "bmcpcierp_pcu",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_OSC),
+	/* hostss0 */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS0_NCNOC_CFG, "hostss0_ncnoc_cfg", 12,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS0_NCNOC_DATA, "hostss0_ncnoc_data", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS0_PHY_SCAN_400, "hostss0_phy_scan_400", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_GPIO_ESPI0_EXT, "gpio_espi0_ext", 14,
+		      JHB100_SYS0CLK_PLL2),
+	/* bmcusb */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCUSB_NCNOC_INIT, "bmcusb_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCUSB_NCNOC_TARG, "bmcusb_ncnoc_targ", 6,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCUSB_SCANCLK, "bmcusb_scanclk", 5,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS0CLK_BMCUSB_480M_SCANCLK, "bmcusb_480m_scanclk",
+		      CLK_IS_CRITICAL, JHB100_SYS0CLK_BMCUSB_SCANCLK),
+	/* vce */
+	STARFIVE__DIV(JHB100_SYS0CLK_VCE_NCNOC_INIT, "vce_ncnoc_init", 10,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_VCE_NCNOC_TARG, "vce_ncnoc_targ", 12,
+		      JHB100_SYS0CLK_PLL1),
+	/* bmcperiph2 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_NCNOC_INIT, "bmcper2_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_NCNOC_TARG, "bmcper2_ncnoc_targ", 12,
+		      JHB100_SYS0CLK_PLL1),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_CFG_400, "bmcper2_cfg_400", 8,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER2_CFG_125, "bmcper2_cfg_125", 10,
+		      JHB100_SYS0CLK_PLL1),
+	/* hostss1 */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS1_NCNOC_DATA, "hostss1_ncnoc_data", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400, "hostss1_phy_scan_400", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE_GATE(JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400_ICG_BUF,
+		      "hostss1_phy_scan_400_icg_buf", CLK_IS_CRITICAL,
+		      JHB100_SYS0CLK_HOSTSS1_PHY_SCAN_400),
+	/* npu */
+	STARFIVE__DIV(JHB100_SYS0CLK_NPU_NCNOC_INIT, "npu_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	/* vout */
+	STARFIVE__DIV(JHB100_SYS0CLK_VOUT_NCNOC_INIT, "vout_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_VOUT_AUX, "vout_aux", 150,
+		      JHB100_SYS0CLK_PLL0),
+	/* bmcperiph3 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER3_NCNOC_INIT, "bmcper3_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	/* hostusb */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTUSB_NCNOC_INIT, "hostusb_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	/* hostusbcmn */
+	STARFIVE__DIV(JHB100_SYS0CLK_HOSTUSBCMN_CFG_480, "hostusbcmn_cfg_480", 5,
+		      JHB100_SYS0CLK_PLL0),
+	/* bmcperiph1 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER1_NCNOC_INIT, "bmcper1_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER1_CFG_800, "bmcper1_cfg_800", 4,
+		      JHB100_SYS0CLK_PLL0),
+	/* bmcperiph0 */
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER0_NCNOC_INIT, "bmcper0_ncnoc_init", 6,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER0_CFG_400, "bmcper0_cfg_400", 8,
+		      JHB100_SYS0CLK_PLL0),
+	STARFIVE__DIV(JHB100_SYS0CLK_BMCPER0_CFG_800, "bmcper0_cfg_800", 8,
+		      JHB100_SYS0CLK_PLL0),
+	/* gpu0 */
+	STARFIVE__DIV(JHB100_SYS0CLK_GPU0_NCNOC_INIT, "gpu0_ncnoc_init", 10,
+		      JHB100_SYS0CLK_PLL0),
+	/* gpu1 */
+	STARFIVE__DIV(JHB100_SYS0CLK_GPU1_NCNOC_INIT, "gpu1_ncnoc_init", 10,
+		      JHB100_SYS0CLK_PLL0),
+};
+
+static const struct starfive_crg_domain_info jhb100_sys0crg_info = {
+	.clk_data	= jhb100_sys0crg_clk_data,
+	.num_clk	= ARRAY_SIZE(jhb100_sys0crg_clk_data),
+	.ext_clk	= jhb100_sys0_ext_clk,
+	.num_ext_clk	= ARRAY_SIZE(jhb100_sys0_ext_clk),
+	.rst_name	= "jhb100-r-sys0",
+	.power_domain	= false,
+};
+
+static const struct of_device_id jhb100_sys0crg_match[] = {
+	{
+		.compatible = "starfive,jhb100-sys0crg",
+		.data = &jhb100_sys0crg_info,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jhb100_sys0crg_driver = {
+	.probe = starfive_crg_probe,
+	.driver = {
+		.name = "clk-starfive-jhb100-sys0",
+		.of_match_table = jhb100_sys0crg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(jhb100_sys0crg_driver);
-- 
2.25.1

