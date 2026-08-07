Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2112.outbound.protection.partner.outlook.cn [139.219.17.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0834442395;
	Fri,  7 Aug 2026 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103236; cv=fail; b=qW6wfrwH6bL507OX34rQD77buMj/1RdJIQbKlbTeKiP+UrevPvY5OiGNJ1U4gvyJDd7Xr2I2uXCBAW86Iq8Zl0VK5dczU3OymYGBKP0HxZsRLNCtxxuYIF0QkXXcmCb4A/k1IvmDa0yX+NTwoJpO+8HJAhePPP7Gbqi8Q5nae84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103236; c=relaxed/simple;
	bh=kFrZG7ViF1Sj8iQPdmsRgshjHLGNRsrfNs33qV8ggoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sxs8+bI0GjZdQL2C2F5cLWbCR+jnRQp/+wJAJamShGwqwCJiX2A2QmRGTRLb8n/DczaDkwflEDoNnLd099PNRX7AWPCgS6GpLFDYnOS2Fd38ThrFi5H6J6oI4hH6YdFcZzJ+2aIsdcFq87dbjkitb1VKqywmlz/D/MA/8b7kCx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKGwMHUMCsD/VcWrekvvPfJ1U2nxfWTjev1i3kL5awPRqtQ0fzVbxg6kX5fx2zGhac4/jPJzsvHQirbfjvzv5kFcvCWWPV3IhqStAjxtWPws/Dg2bxA8/bAM5dJDtLJV6IhnmFBP/xe2VGoPlewil99kSOJ/YvbIGX6KACoPSyUMBbLlHL98i1I8oPKI7GHu4m/XD5W9ynAEyVDhXo05rST8Zj+UEsQJGyR5WasuCMDrjmkarrnKjZrbYHs0hjsAGi1Q1cvfzjY+vtERjoWYMeCillJAJI1lD+zJznxsaAL3hI7flI7j2Khb0bj4Plp20kXEOpYyBydu6gkR9CcPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFaEFG+psUSWbpgDOhF0110pwoxlvMDkjxsi68wVwNg=;
 b=VkAf+tvUm/2ArVOIIWNwPwRuv9luekZ17541lQi49P1L3QV2n5V+TsqVTCvvUCpih/vKYXNhHYi4/eFiQHlSfto8IomX1WmAT8F2WbCZKNnCdt3PPoDjKRmalOlqX2pgB0F8rngiCnQDRl9Wzotr0xRVsWh/mwdRMGIg9IW6GqCF3Ue81PXlOLmw5jThwnusSyu9D8WLJDxVNyCR7aCY5FEw0Lt8ejmfXZk794hcE66/LQO0QGXWFZIOC/lTZOTEkUDYQzJDQvm3dqKcB7J0bM1E60CKVlfxay3KlOiyBCPkNim6fLAyPQz9/HcwAKMwpP6sUew7LdJv8o3YYVZTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:42 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:42 +0000
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
Subject: [PATCH v3 06/22] clk: starfive: Add JHB100 System-0 clock generator driver
Date: Fri,  7 Aug 2026 04:29:07 -0700
Message-Id: <20260807112923.191627-7-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1315:EE_
X-MS-Office365-Filtering-Correlation-Id: 925277b2-c231-4ba9-c07d-08def4772c77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	eeQmp3t8CSthvHTl9tEfmTPc0Yp7zgDVrDirTSHAzRvSLIfomQEf7Yb0nH2Yf+5oCuMezbY0a+ib3dOlamYHYzHf/FXWnxXChElrGivWRYB72btKfAlc8GAOtP3Y5vf5Ee2wl/Ai7NDeKbQVmz5g8LvpoCyCQeOK7wu3Z+6guwu27hLSAaay7JXe81ytBXW3XFfpM1QaNOv644aTZgTtN6IM0Kp1fFa4vJL0PER1dc+lhtl2ZpfXQcgM4MSFsxcM1KF71yNs/5owpeZ7U6SqwjNm5ouKBuPs+fFt1M69BFxbgEuiDh71AVrwk/QpSVhUByDGVkQw3wr+G+QmCi30qjfe2xlt+pFsL0DUGcbFKRPjrSYkNc71XjmVCicsLRavUP4EzD+57oZL7UmdyTrSxNqR7j+/hbDHVDRwjPhOXgG10yUXT6hgJpmSOD4yf3ltKURPWc85kRpw02CY6WaEZUDcRQrWSQn1fbvjtwlkGgAne3nQxxJk1foQRRrGQQvOsMxH5GmwyfiovsOUEi2FBeatLcLTcXgYWRhw+nWD2P1MCblxkEnJtMUuYta3ke4aDN1LdgKAVRmK8UU3yrshWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yy0U/drfyA+gbNRnDedIITOdnGGNbYqXCKMDx8yMvPxqurxuDleaGgSR7aZu?=
 =?us-ascii?Q?4K+Lvda/GtgXbLhCLTnUPP+xDYaEtpmhcnxFKOHp2A6achnGZ+59HX52neMq?=
 =?us-ascii?Q?Ioe+Jpk3A7kquNAaxH3LgyfoGdiILo4j90dsv7ud+X/m0/LBdT7W9Od1Oyu5?=
 =?us-ascii?Q?0eK12QbH7u4kw+DlQEfRVdQvIEYjydP7OlbDi4O+GVns0sv1neTmwZjP3u2p?=
 =?us-ascii?Q?j9bQ2dVjkbmA99sJWKDqz1pbCpBd416LiKVovZuzGqzFdnL1dVj6WAk3CNxF?=
 =?us-ascii?Q?yHbTKgpyg7gHeM1+ttd0SsojjpHI1SFl4mqbwrhUmdbD9qFyexOH5ux0baQl?=
 =?us-ascii?Q?U+eqwGiZZHfQjUX9dbianxYUEPKrfc1Kl9tgxsoQor+hJJFCuy8HLcnqVTtf?=
 =?us-ascii?Q?MK5mICH9Obaj6EMAxkj7x5JlYPBDjBSw5p+Zl2uV/+SNUiGmQ8nA7kqIY49p?=
 =?us-ascii?Q?gQEiApn/qvFZsyJIDiJw7jEgJRPyg7cdNNX3X7axowjggFSeFcW7hr+6UJCY?=
 =?us-ascii?Q?utAKyE9JzlbY8BtzlLSPhFgC/hjdupALlnVsSC2LLAt7voJTuILVdythHceR?=
 =?us-ascii?Q?Oq1hAmKoR/AQv1BYvHLVShO0zOnjIBAZYvisPD2WSEamllwarmpVEOCG3nPP?=
 =?us-ascii?Q?V9H7PdAHvcsbQin0i86cAOtYuDIPAwHs/DzIFprWTTfOODMwbjZi2XmqEpKi?=
 =?us-ascii?Q?pDQf+ecbIRlNNPX4/lPRwHIkf4Os9q8hUvvJHCZ2MEWHYCcLIjmbMcoi8XXR?=
 =?us-ascii?Q?0xTJZ/Ew4zOm+1UB2Z5S1iGKcketo+hAS7D7mn55txUEJDqYIFPM+W2P8HAT?=
 =?us-ascii?Q?IWVtzTNVwrdDX/I3Iofvok63G1k9yd6JemOtOG6KIPgE2oJigyBt1kmOoL3W?=
 =?us-ascii?Q?vnFCJE1Mau4FFQAzS8oH9VFfEPZlHCHbvGEp898MXJq85ed6hxsCo5r/8IsF?=
 =?us-ascii?Q?fNppcUJ97FKhv/6zB56vLYgskWXOE7ifcVQFuHWc/Wj5/qwzw+koVDwUfBSz?=
 =?us-ascii?Q?nqcM6xL8vxjGJKqyvOTwZJw6rSFToqtuDEzQAVOCF2wVys0fiP4waM+en/WN?=
 =?us-ascii?Q?BKbVqFMvW217/1dI3AKo0JCdscH5iEFWNqr4wpHRAKIVJI1hAOmY5ALGMP3Z?=
 =?us-ascii?Q?1mmpDDEODgqowXUtgnP5jjTp4Bevu1blbW8+lbnMRegH+kx8ulrDzs+w9MWq?=
 =?us-ascii?Q?oIY1SJgW1OyhI+EHwK7Il8FbcmZFYXbgVC7Tt+eOK6ZxopcR54cwqn8GF88P?=
 =?us-ascii?Q?Rc/8Y+uA/zDScfl8BgdfQaX3git0t/W3aNEvWWiTdazWSpUDIZ6P4FhpjclM?=
 =?us-ascii?Q?pITmOW9O2AckPoI4RmWlWaMdzpy0QLAHX+exxbOKvtNGgsKcnb6yT50RMTCX?=
 =?us-ascii?Q?aBVRoDu/Vy/yfC0jfH2MaAwjZCSeSm9eOIEVsLiUhliq+Hh5X/KdEaiFjLpH?=
 =?us-ascii?Q?qZ1YHu36T5hLc66UlfC7/HE/JReD3J2AMIl8V8srfdrPGvqDSgcvWBTl9OTT?=
 =?us-ascii?Q?lUiBe1IRERrrqNloI7c5Sxfs0L9q9XFleCHMZhUmfChMNGMxRlBehCkZTOiv?=
 =?us-ascii?Q?2IUXC3SYy407X4aiMrGzXFu/DI4/vv7rcNMK4VCX3le9fUUZm6BUUu+BeDsk?=
 =?us-ascii?Q?RRZSOrd0iQo9rT5sx63IpxTY+lomfRxQd8OgIxmAwj4NMYaF2BJBCgtzZFnu?=
 =?us-ascii?Q?i9ayTR0am3anjC+tHknxI2MnIlQk7DTd9goS1dFXt4uzZBjbNI9/cG8RCnvb?=
 =?us-ascii?Q?vwpTz8+yAEu9xnKMgTxZgwFn3sUPojrh7YlzYV6mYEsfiaD/7hgJ?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925277b2-c231-4ba9-c07d-08def4772c77
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:41.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35VO8bKeIgtJW5te+TViSv29/kVtNxaRUxhTEgFll9pA8y9kVUqcxzlUoWDiHxc1LWH92o3JzM2qwRhnGCrRVtEbJtZgJGIXX7X88OLLTxMNqHuYrhiwS5riVWiuOLCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

Add support for JHB100 System-0 clock generator (SYS0CRG).

The StarFive JHB100 SoC has multiple CRGs with similar probe flows, so
a generic starfive_crg_probe() function is introduced to facilitate the
registration process of other CRGs in the future.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                                   |   7 +
 drivers/clk/starfive/Kconfig                  |  11 ++
 drivers/clk/starfive/Makefile                 |   2 +
 drivers/clk/starfive/clk-starfive-common.c    | 142 ++++++++++++++++-
 drivers/clk/starfive/clk-starfive-common.h    |  12 ++
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 150 ++++++++++++++++++
 6 files changed, 321 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ce97de46e610..c48b56d0ab94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26069,6 +26069,13 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JHB100 CLOCK DRIVERS
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Maintained
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
index 9c0eb7a50d1e..1b5e56af4138 100644
--- a/drivers/clk/starfive/clk-starfive-common.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -9,6 +9,8 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <soc/starfive/reset-starfive-common.h>
 
 #include "clk-starfive-common.h"
 
@@ -331,9 +333,143 @@ struct clk_hw *starfive_clk_get(struct of_phandle_args *clkspec, void *data)
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
+	info = of_device_get_match_data(&pdev->dev);
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

