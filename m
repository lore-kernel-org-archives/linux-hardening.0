Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D173B19C6;
	Wed, 30 Sep 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772286; cv=fail; b=q/baeDG7iQZGv0JeCmD3+b9k7TWImI3MOfyZopGYZFLm2w6anIujxWC0zmXXjmovvIF2DzMIo1ycZC7UEUdQcQSmxcYBWYzq/VDantMGwKHDVAlAjRTRJx3Ba3cCtRsxxo6fdirEfj647xFIG8hnTMcRdA51Qu4PfoP9kqt6Yig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772286; c=relaxed/simple;
	bh=QcQSu1mnIlZPrk8Uu3Faz42x2fNYbGzMEj5orf157BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XhbgnBKfJUU9UPOwg1cWebOKtlVoLRhx+ajWTIMd+O83MVit7z3SS+HnHnmqcvrWkeHousKjcQuqhl2UFGMRlE7IzF2YA7p2/2l9FLS6BWB6wc8hNW/MY/gOX3XW0CoEdTo+CTnUv7YvTXMD+lFFDZPSU73nqUeoErFCQ2/f2ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEalNHyD1P5uKAWe3Nli+oJ5b0a5CdZgciE9fWAr1XZlpwW2EBBRmV0okvKAgaRcr/UGQ8LXbYGljXGBuVpU+OqJVJfqebGog9j5lhdS81XhFnDK2zdE+5MO3MUFdggVwqz/Ch3D3W+evrk89RyDFzvREg53cKEIlObCBhHtm+BEoXcNph0vaYFTB9gHpDo8OFKQNWvjR9Q05HfDiSwlEouXwc76D3YsMsbd83qZiYHoo4Q8EH+nn3wSmfuzIyyMIoyEHjhOwpZoY+PfPYesx3p/DKRV2S6PGHJ3eeF79gmgCQ2ZwWDeMD/WnREV4qdtmx8PbZNcZWKWLcZSk+klIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xun51H6Hs8wkodTe3PnaKo+c8L/r4MLjDymQAigNhBk=;
 b=b1zDoWhTy6ZZ3kpnuyvcH5yCqpwzdxLQjr3Azc6oUneuhc8gannqOhlf9px1vwYX6rGE16E70P/HXdNntfoeIJLoQmG4TUGuaRiIFlrThc7SZJZycoA/ZNZH0fIrD/27g+jcDAdxVYvV3a80AvWsL1XV+rJNqkUOHzviNXKxrel6cn81o3nrGo68McWwgO/YEhhaFk2+QZhjTTGUgMBd2UMsVKLTnBfzv3eVXgtxr5mHIuglMVpUeOYShR8KC2g5eZiziwro/s7eACr6UwFH4aVPxCHzJ0FpDDubVVwIYgu/vicP5/Np8x8MIFWJubWvX4saeOij0xNSsrHIDZ2IwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:44:09 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:44:09 +0000
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
Subject: [PATCH v5 21/23] reset: starfive: jh71x0: Support discontiguous reset IDs
Date: Wed, 30 Sep 2026 05:43:15 -0700
Message-Id: <20260930124317.5648-22-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: ee694669-bbd1-43de-0652-08df1ef08568
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	El4vGb6t5F8KFnGSs59i5R9HhRmn/8i9LwRPKXo7q2/uN3gRAmAVpIJuZPig3AhTqBE6BKGfyWdnn0RN3AXD68U48lI32YyvpUrWtSu9B4xtXjyb6ket7Fdql8aoRmBqm+owz7X2IQQABNSigNpgJfvE8s35MT9urRedf4XSuaO1ChvZwyJB0VUw4trcF/nOgPi0N4y1yg9JrDIB+hdEjf7mnTRsO3nfbyDvvQVK/u6LtBxPsOZnKuCk2wUKKLNSz0C0mST+P74PaIY5aur1GxiblJeLokLwh8BMIzzvuAtrjtw0gFJqNDA4EOjD0LHW0B7iMjgx7eDoytbKx0Fr5RHmEJHnnA8mOPWifwbXDop9ppkeDK0RR3On9Ibn4oroNWJWMOL1JP0boLrucVO9Q6nIa0leJ36PHSJQlZZM5aXyBItblSrYgVm5xeyRySScrTlW0J8eTwDIjCZ0Cf2xR6OpturqDFN0fdFISOvTJlxAyYKfdZpEr2y8rtX9CfY1Zbf3nXpijhGIgBLbtImwn3v42Jc7Jhsp7ZAcwlGDy/zHIzcljTIR9u4tjjdJxxq5L16jRUTmR8MfVK+3cxAiUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(6133799003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?My8itaiQKvUevp5b8BB6LPlkxJ3TlW+ZD28pa5NudZev6mEFQJnW9uzzYDms?=
 =?us-ascii?Q?/VS8q/Tsh7ngDp+wZy8Yl/oYN4YjrqkSJn5AhLZmyc90WkiWtDSStDLEaXjt?=
 =?us-ascii?Q?WI7vwiw2xvpKKdvQxpFkm0JDLE2wNNm8VXRH7t4g1JeBoV/BAHoDTmk98F3i?=
 =?us-ascii?Q?6QHgDy79rh7rKKsUkrsvI2idsotlHpA/hqGOyqDY89Fnsmt6zh/spp5fg7ui?=
 =?us-ascii?Q?Oy47asyZmC/L2r2QP6Io3B53fVS5PU53WaHHy09gqBsZakbnB9SzVDYmXUsa?=
 =?us-ascii?Q?B2Df/VbI7LrQso9xkWeJQO52H85BOhNK+x1Q540rXyOHEll71oHuxvsHGnV+?=
 =?us-ascii?Q?LcTs0e0EFJW1bYkVoiB9A57scL3xJkCgocWLxGJzWUjBlb+3DsbNVm+ZDxIf?=
 =?us-ascii?Q?JKl7cEC07EET8phaiH/Z0njTE2KZXaTgD755fM1+FmC7ppNWekwgIy0DwK2t?=
 =?us-ascii?Q?YzEUTuo0GT3eCPvNHs73HZYwnR9PqYz8JlfUpUEf7sK9wl5SUrqbho98nqPu?=
 =?us-ascii?Q?MGWLuHz6neJXrqX3UGDO1zUI3xnZJYiTVpfOUwkfc2t9n4C/YKxFCI3Be5Yl?=
 =?us-ascii?Q?zQ9MLq2z8fAt3UgfXym2wnHJKfk1guQEcX2zAFORcjct8qO4xlegAEcFjkjO?=
 =?us-ascii?Q?6XtWe94D6jksDKrGRnAEXtJwskDVx2x5+IvgqToXKgEAdUpCXYDN8cVSCwV+?=
 =?us-ascii?Q?7ndPBa/hVRB7eB4ds8Chi1laQzulCJOzuW9yaZXF/K7HTHoeW285inNBcWky?=
 =?us-ascii?Q?c3LRDrOYsLyG0Bl8xfm87diSHP26exSV+zvT7O1CBnOkMe811H3JUFo+F9A4?=
 =?us-ascii?Q?JcXwiEthoCGNhDD6OfQk8coq3gFeSni2riCXHw39XuP1+GQTeyHWduY2KDaN?=
 =?us-ascii?Q?phT+fWcFdjeBt+Vu1PwynhIsD2wmiJcvD5nxZCsF+H5JmUFMDuw5Zi/9sTVP?=
 =?us-ascii?Q?5J9PlOksLn3YXgmwxWPw57JOpmQbZdNWK3vJW+VnMRiHtfxdCY0ostmbEvPl?=
 =?us-ascii?Q?4QXuxYY2essky9w0r4QaD39oc2B4KJjS+FrkocdXy7bgsK4jiamBwqTMx0jt?=
 =?us-ascii?Q?qsNm9vtcDyjnxl9jjPkeHNzmWC6scBgf7OlpxQqh5nIJmECG94qsfac8gG4Z?=
 =?us-ascii?Q?lOepWp9YM30tk35cljwDaxWOseFDj6gmHbwnPdRTTn3kY72Mq/Nkx6bNG5E4?=
 =?us-ascii?Q?Wl/ZccWj4R30Ka1CSadTYcqYzx0NOnknPir0qtdExN285yHlwXeaHdQVHcW1?=
 =?us-ascii?Q?LuiUIWMpZHEcN349yyAIi8WV1GxnhYTqX2MEiCiAI4UP91TQYdfGnC0yw4rr?=
 =?us-ascii?Q?wRs6r1hT9xaWJ4EQcMq6PtqLNdq9h2azWED1jFC87rG5btqyXl7YcWC5Kwjb?=
 =?us-ascii?Q?3XxrXaS9gMWXQ+Ztx3wQ63o4IZ6kZxDmNLegovGo2UYoxpIS+DxzEhvUW1+e?=
 =?us-ascii?Q?mR46kuyAnFpHCrq4gwQfipnkkg8XeKL7Rf0q/hrAPV/bMirVD1sELRo+AkHM?=
 =?us-ascii?Q?n0Qj8VEDkr4Meqdxp1ZT00OgzscTxCzVCFQj6EOX4U+Pk7CoTloBNrBY8J0L?=
 =?us-ascii?Q?M6tVs0V9wa3knot0oJWbNjZfZO0Ot7yJ16BBi/pmFVEKD4ObXFWHjDggtUez?=
 =?us-ascii?Q?nGFWHLaawEOkHRRCrFSsD8qwETMREXEP3zzuxqoetDjXbvKWfIPb8itBkaw/?=
 =?us-ascii?Q?SC4kuF6EpsbfbTtfACKJ0Myi8odPEiP5lLXxwNcQPVOQpT24IYbHI0+BnAq3?=
 =?us-ascii?Q?GVO9PihWQZFToL3Flj9/Dn6toxM/MrXtrsHu3tniRyS/S40NKPbW?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee694669-bbd1-43de-0652-08df1ef08568
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:44:09.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6gQFg23Rjhw68++zBPucBGQjIFiXqlsB2daUJAVaB4OOK1fIiWtPw4H3nDwVW1sc2b+/aMA1bMlj9bLJtf2cIjOG7G3hXWWO/mH+Ap/QMsGpdBp07qOlNrquDkde3lI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

The reset IDs exposed to consumers of the StarFive JHB100 reset
controllers do not map one-to-one to the hardware reset bits.

Add struct jh71x0_reset_info, which describes the number of resets, the
assert/status register offsets and, for discontiguous controllers, a
table mapping reset IDs to hardware bits. Add
reset_starfive_jh71x0_register_with_info() to register such a
controller, and translate the reset ID in the update and status
callbacks when a map is provided.

Existing users of reset_starfive_jh71x0_register() are unaffected.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../reset/starfive/reset-starfive-jh71x0.c    | 99 ++++++++++++++++---
 .../reset/starfive/reset-starfive-jh71x0.h    | 19 ++++
 2 files changed, 107 insertions(+), 11 deletions(-)

diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/reset/starfive/reset-starfive-jh71x0.c
index 29ce3486752f..fd1c755a0017 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.c
+++ b/drivers/reset/starfive/reset-starfive-jh71x0.c
@@ -14,6 +14,8 @@
 
 #include "reset-starfive-jh71x0.h"
 
+#define JH71X0_RESET_ID_INVALID	ULONG_MAX
+
 struct jh71x0_reset {
 	struct reset_controller_dev rcdev;
 	/* protect registers against concurrent read-modify-write */
@@ -21,6 +23,11 @@ struct jh71x0_reset {
 	void __iomem *assert;
 	void __iomem *status;
 	const u32 *asserted;
+
+	/* Only exists in reset controllers that use the
+	 * reset_starfive_jh71x0_register_with_info helper.
+	 */
+	const struct jh71x0_reset_info *info;
 };
 
 static inline struct jh71x0_reset *
@@ -29,19 +36,40 @@ jh71x0_reset_from(struct reset_controller_dev *rcdev)
 	return container_of(rcdev, struct jh71x0_reset, rcdev);
 }
 
+static unsigned long
+jh71x0_reset_id_to_hw_id(const struct jh71x0_reset_map *map, unsigned int nr_resets,
+			 unsigned long reset_id)
+{
+	for (u32 i = 0; i < nr_resets; i++) {
+		if (map[i].reset_id == reset_id)
+			return map[i].hw_id;
+	}
+
+	return JH71X0_RESET_ID_INVALID;
+}
+
 static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
 			       unsigned long id, bool assert)
 {
 	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
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
+		id = jh71x0_reset_id_to_hw_id(data->info->map, data->info->nr_resets, id);
+		if (id == JH71X0_RESET_ID_INVALID)
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
 
@@ -89,10 +117,20 @@ static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
 	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
-	unsigned long offset = id / 32;
-	u32 mask = BIT(id % 32);
-	void __iomem *reg_status = data->status + offset * sizeof(u32);
-	u32 value = readl(reg_status);
+	void __iomem *reg_status;
+	unsigned long offset;
+	u32 mask, value;
+
+	if (data->info && data->info->discontiguous) {
+		id = jh71x0_reset_id_to_hw_id(data->info->map, data->info->nr_resets, id);
+		if (id == JH71X0_RESET_ID_INVALID)
+			return -EINVAL;
+	}
+
+	offset = id / 32;
+	mask = BIT(id % 32);
+	reg_status = data->status + offset * sizeof(u32);
+	value = readl(reg_status);
 
 	if (!data->asserted)
 		return !(value & mask);
@@ -132,3 +170,42 @@ int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_no
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
 EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register);
+
+int reset_starfive_jh71x0_register_with_info(struct device *dev, struct device_node *of_node,
+					     void __iomem *assert, void __iomem *status,
+					     const u32 *asserted,
+					     const struct jh71x0_reset_info *info,
+					     struct module *owner)
+{
+	struct jh71x0_reset *data;
+	int ret;
+
+	if (info->discontiguous && (!info->map || !info->nr_resets))
+		return dev_err_probe(dev, -EINVAL,
+				     "discontiguous controller without a valid ID map\n");
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->rcdev.ops = &jh71x0_reset_ops;
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
+	ret = devm_reset_controller_register(dev, &data->rcdev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register reset controller\n");
+
+	dev_info(dev, "Registered %u resets\n", data->rcdev.nr_resets);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register_with_info);
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-jh71x0.h
index db7d39a87f87..36f198139602 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.h
+++ b/drivers/reset/starfive/reset-starfive-jh71x0.h
@@ -6,9 +6,28 @@
 #ifndef __RESET_STARFIVE_JH71X0_H
 #define __RESET_STARFIVE_JH71X0_H
 
+struct jh71x0_reset_map {
+	unsigned long reset_id;
+	unsigned long hw_id;
+};
+
+struct jh71x0_reset_info {
+	unsigned int nr_resets;
+	unsigned int assert_offset;
+	unsigned int status_offset;
+	bool discontiguous;
+	const struct jh71x0_reset_map *map;
+};
+
 int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
 				   void __iomem *assert, void __iomem *status,
 				   const u32 *asserted, unsigned int nr_resets,
 				   struct module *owner);
 
+int reset_starfive_jh71x0_register_with_info(struct device *dev, struct device_node *of_node,
+					     void __iomem *assert, void __iomem *status,
+					     const u32 *asserted,
+					     const struct jh71x0_reset_info *info,
+					     struct module *owner);
+
 #endif /* __RESET_STARFIVE_JH71X0_H */
-- 
2.25.1

