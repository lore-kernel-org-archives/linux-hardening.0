Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767C4DEC19;
	Wed, 30 Sep 2026 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772238; cv=fail; b=PqURXFZEBZDauc/QhBdN24QjG99fq13w738sIrB7PzwArTiTT1yea2PcF7/dt4BCA20gfwXlR0Fld/5LzdY30l1CIVAxmQ0mOBB4yk+ut9UyVbFSPW2JdBbWQPUCZHepsynBxwEpjedh7lNpBUda8g7CuztvxoxEB8q+PC67x60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772238; c=relaxed/simple;
	bh=f3ZdIKGR8v77aJXNMMkc7pJWMIW+dDtvHwWGVSWYRb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFItDFMzAlXh+vYPCkfKhvbUAdsoaBa/d8W2EsGWLzb9O3jzLYyM7sZr7a0Oy9N32EvSokI1PCLlbiKGH9/YJx+85QUDwxcQPB/ay52oTkaIdbxwYL5lR1JPmEKxp8/gSWGo/WYmS/GZ0PESz8Wltpoa+s6ByptJfoprKiUWVpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASdxo31apFqpXnBLrIqFk1wK9CvC3jkBaLx206uhbgVKciDpteqjG5aWGyra8loK40sGkZJUsdjAWURBxEZr6wpGZE2dP1XGQQ8Pzdk5iCcAUS+g62wJBfEtmUWj+kUTGKYeqh9vHb2f6dEzW+igaiD7E+g2W0dYhRuL2P8Ike5uokAAGvrP045+lzY9oGs+BCFbJRbGBrh+UxyRCluMUSSmfpIRXunCQGDUQOSvvDQttF5x5uTnOLlOOlmKfYrCflfh1erafhx5VtGSaTJx4gmNVpOtR4NnbD2fuTwNFhDFgQoEUx1yW9q3YjhDgN+/ki+9xW1cMzEJLIIdasytcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8UPzC0wBWko0R+sJ52KHfQv4U8N63CgPieLgP4gGa0=;
 b=JHLSd/u3QnS77lHGqascnnLX0jLP8dNdccPzQ7/OtgzPqJTshW3QZuKWCH7uJGG+CUjzhQtDFkdfRuXW+GEcTxxyGfZ3++2TAV4kB0jlV47PmpVBo4hPG4OoPrXSFp++FpAEPrEXJk960xhnozS7YDDHK3XLcIeV+SaBorv4TtZJKqu/J65qsPyyiIAIl0dVk4868uAWt/+7GBprtXKOWmYRH5Rx2vkcC4+nUp/7aNP6QjmbxsZY9qwzh2o60d69+zQn6/EBxyT7pGLBBxAK1wr/zUCIlbgRxPulK2dAbslPOlLZ9iwfDsYAZFVqggnh/vm9L4Pb+Yd8hSbZd2f0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1297.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:40 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:40 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
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
Subject: [PATCH v5 04/23] clk: starfive: jh71x0: Add generic CRG probe helper
Date: Wed, 30 Sep 2026 05:42:58 -0700
Message-Id: <20260930124317.5648-5-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::18) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1297:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c50b31a-03d9-465b-8f70-08df1ef07434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|52116014|10067099003|56012099006|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	GifY3pdYofFMPMOtaZljxhJpv5JcImuOWc+pYL8hWzdIAIqdv4+GdWNaL3VVGDr/tqZNQAaI34EMMqUiisKf5AnWMfRfktSpXc72gkJ0DEg01zdtkUnzxJvBZF5KfNHDl2SRoF5kDixUnsxEXHNL5IScrutPmqvyUhBtrm1WnYRHf33h+pzhl6D6I8mjohRa/XQhzls9yyXkvAvAC497c5mdgk1m/0wOqIJUp79wA6lvpn3pKVy/ujfWafhAIXGuTjp7CU+J8edbh1vUrXPmYvuv8b7Bo5Gxa63K7e8zj6gPryIRPxn35h8yAa0bpyV15gPXBBTLp0cEUBgrQZ37fEB4pLet+y3BvGEN8wgH+NiJHBK2DSYH33TLwgxfQS2mjs5sEnpniXst3oTNSa5wgQDQC3AAJ3BHNXzvL0rzybwYo4AP8NwRN8uMmSWIqI+AyZamJl1oaVlkoG1f67zocbLFtvKU3hitafh+CvRTLh6BLnHfmTA0OhyASKKGI6+bwSy5gTiq64TKHq1+Uta3i/Rf2LT/m0s/WbFDnPgJMfdVAyybeIen2qTFP+Z66vVKfGcOEPUFFkPf5ZKcRbKdnA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UMG2F7cU4CrG0FTMmMwGXCz4+TNxZoegBUocY7jdodc0it0it3AzpB6DktXs?=
 =?us-ascii?Q?AR2qSIB0zQoLTQJ55vRa7FZZlCdsdfkRrH1+pYGvezeKT84102LNzZdMyrQj?=
 =?us-ascii?Q?zrw6RcPkMQB8Us/65MdLzxyFqCXpVAiOihSj5f8XfMR9LoAsg5/pfF0H29FS?=
 =?us-ascii?Q?sf2jnnAQO8UDUaMXvCiENe1rplGG5GEAU823nyjfgx/roJvYfTHMf0uX8veS?=
 =?us-ascii?Q?njL2UxLPm/mWXvWTSORtQ79Q8VORW0r6egGw12Fck6Lo/YZH8GjR0OUvHHAB?=
 =?us-ascii?Q?Li3O/teNdZTGNVea+ucC+aQ5qaq6+lD/lYo+K3/phwElm4JUnqIphf4e3QZQ?=
 =?us-ascii?Q?MicsbMqWiTrl/OVqEsJYjWWucMdBUfqI4pZF77kIVmR94/vYBtQqyu9Kxc/d?=
 =?us-ascii?Q?kAVRA6yYZb3s04rz5Qcqh+DIJGcT9zCqRZG7LxMnlRXIJwtjf236FujNV2mx?=
 =?us-ascii?Q?35wU5Wcz7lpMdTMKbP5FWwGqnCubufO5P8qklmX7IjBs9SXvMyfmWVdo4414?=
 =?us-ascii?Q?O52vL4j2bE3qs/memxlcWnuhkdstYfJUzr2rSaA+FTon87ee/CTc687yF/fm?=
 =?us-ascii?Q?zLCX84E6AFEVVP9I6IbHoICgE89hO2hqkF+tfm7ibqGa2sXiMAG8iz/Dd5X/?=
 =?us-ascii?Q?DEHVRunKdEHt//ikA9wJ21P8WrRQeMU0l9mm8uLGdRRAushh3oCgmYxzJRKy?=
 =?us-ascii?Q?b9+8drxG5mCFOXYPzJ4YpOBpKHADydA9LvJ6sPkFwo913oXrOAddoQbGMaNy?=
 =?us-ascii?Q?5frHHhuALt4aPUTAhIAWvtp4lFgbKsKzLWA9881LAIyx7TdODuCfMbAWSSF0?=
 =?us-ascii?Q?OGwiuVRhrUZ/AAd7vTPV6CG/XJ6NyP1S5lc9dpLainjMc1cN6NH2cM527i4h?=
 =?us-ascii?Q?9ZbIREp/U6RfZZ3tnQyDLY6O0NFd1heOx4/hZvB6ljfzn+Q2M0HacTmvODZj?=
 =?us-ascii?Q?IxLjvZE/NAyS70hctIaAFT20W2xcZ7k2WQHAMHmi3ChbF+qheQ2ypvsNuSH5?=
 =?us-ascii?Q?ujg691ZlZ7FRBasdCskL6kiAqGcECgMi1l2+OyxdUIwbfr5KuyW7HQF25NoI?=
 =?us-ascii?Q?CsfIvfpBYb6iXmVFdXx47lSlR02tALQMLM1gwXSqlydLikZ4jE3YFA92qJq4?=
 =?us-ascii?Q?fcO2P7qPypud6ZNRm5l2PI22CUWXe8f2nv6lrd7oL2SVwVp7IBFO4ak5LBbo?=
 =?us-ascii?Q?zpUO+AdXUpBnNLmfqC6jnJW+GLhvI9G2lWQE8/swbfx05CmnQrufE/x8TaFw?=
 =?us-ascii?Q?4Z/rGppOAevVuMbgAk9nqijCoAegyN8YaXWUDpr8HYiYMv0ZKoNaQYeVRl3u?=
 =?us-ascii?Q?uYNrMrkl9KUPYijzUZrVzwGiRlfHaXnxWRn2bnR+fWn5mvxfP8fCVRICIM01?=
 =?us-ascii?Q?F8+BJWQY1ggv237N/K3eN/4YFPIRBCXQa8h2hW7bmD+PTefywfzIzWGEwSiG?=
 =?us-ascii?Q?tACklEluQ9Xmc9FIlR4zKQBurIDrwqAlTVPjIIN/XOyXbD2Xa5aUg5SY1VT7?=
 =?us-ascii?Q?ZTPOR6xIkiLMKVdKjQroV5KEfinJOTW4mkGFMJGYuspF9meWtxc9eCdPjkoz?=
 =?us-ascii?Q?kkw3LDiU6MFPNgJiH4SvRqEkie1IrfJ515h1KqEhT7tXMLwhTEEAtJCX023i?=
 =?us-ascii?Q?5bz/4Bwpn5w5eqg1AyVDicrPkV3No1lA5Nt+Cu2tbSyuLaxbntyVExg5gLMq?=
 =?us-ascii?Q?LggumXxcU43jUEapUgAbDrfYkA6Lo8zngTzChjNNm6DkHk7hhE3U2QQU+v4o?=
 =?us-ascii?Q?ZJSZLs8FPSXm5jX9UFqUskv6qipqIwxXiNCGCZuJ1FrzhLw8ZnV/?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c50b31a-03d9-465b-8f70-08df1ef07434
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:40.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb5x2FnqijwK79WNOebPbTvdFfsIAGhk/drXfMjl8ULfA2Y9vt///VIXpw5gNYMXZpBWCXexsa9pTF3dgDDU9zqCZBPTafANKXoeeQIrKHSz3PO9S8nomhKCnn1UPRGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1297

The StarFive JHB100 SoC has several clock and reset generators (CRGs)
which share the same probe flow: map the registers, register all the
clocks described by a table, add the clock provider and register the
auxiliary reset device.

Add jh71x0_crg_probe() together with struct jh71x0_crg_domain_info so
that each CRG driver only needs to provide its clock table, external
clock names and reset auxiliary device name. The reset auxiliary device
is registered with jh71x0_reset_controller_register().

The clock index space of these CRGs is sparse, so also make
jh71x0_clk_get() reject indexes that were never registered when the
domain info is available.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-jh71x0.c | 95 +++++++++++++++++++++-
 drivers/clk/starfive/clk-starfive-jh71x0.h | 12 +++
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
index 2cc71f49ddee..bb7706ede1a6 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.c
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
@@ -10,6 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <soc/starfive/reset-starfive-jh71x0.h>
 
@@ -334,10 +335,14 @@ struct clk_hw *jh71x0_clk_get(struct of_phandle_args *clkspec, void *data)
 	struct jh71x0_clk_priv *priv = data;
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
 EXPORT_SYMBOL_GPL(jh71x0_clk_get);
 
@@ -391,3 +396,87 @@ int jh71x0_reset_controller_register(struct jh71x0_clk_priv *priv,
 					jh71x0_reset_unregister_adev, adev);
 }
 EXPORT_SYMBOL_GPL(jh71x0_reset_controller_register);
+
+int jh71x0_crg_probe(struct platform_device *pdev)
+{
+	const struct jh71x0_crg_domain_info *info;
+	struct jh71x0_clk_priv *priv;
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
+			.ops = starfive_jh71x0_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+			.flags = info->clk_data[idx].flags,
+		};
+		struct jh71x0_clk *clk = &priv->reg[idx];
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
+		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return dev_err_probe(priv->dev, ret, "Failed to register clock %s\n",
+					     init.name);
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh71x0_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh71x0_reset_controller_register(priv, info->rst_name);
+}
+EXPORT_SYMBOL_GPL(jh71x0_crg_probe);
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
index 322a05157faf..2a1f0fb4cbb1 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
@@ -5,6 +5,7 @@
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 
 /* register fields */
@@ -109,6 +110,15 @@ struct jh71x0_clk {
 	unsigned int max_div;
 };
 
+struct jh71x0_crg_domain_info {
+	const struct jh71x0_clk_data *clk_data;
+	unsigned int num_clk;
+	const char * const *ext_clk;
+	unsigned int num_ext_clk;
+	const char *rst_name;
+	bool power_domain;
+};
+
 struct jh71x0_clk_priv {
 	/* protect clk enable and set rate/parent from happening at the same time */
 	spinlock_t rmw_lock;
@@ -116,6 +126,7 @@ struct jh71x0_clk_priv {
 	void __iomem *base;
 	struct clk *original_clk;
 	struct notifier_block pll_clk_nb;
+	const struct jh71x0_crg_domain_info *info;
 	struct clk_hw *pll[3];
 	unsigned int num_reg;
 	struct jh71x0_clk reg[] __counted_by(num_reg);
@@ -125,5 +136,6 @@ const struct clk_ops *starfive_jh71x0_clk_ops(u32 max);
 struct clk_hw *jh71x0_clk_get(struct of_phandle_args *clkspec, void *data);
 int jh71x0_reset_controller_register(struct jh71x0_clk_priv *priv,
 				     const char *adev_name);
+int jh71x0_crg_probe(struct platform_device *pdev);
 
 #endif
-- 
2.25.1

