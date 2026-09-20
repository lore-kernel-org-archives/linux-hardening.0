Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174E438470;
	Sun, 20 Sep 2026 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789906627; cv=fail; b=XQGRyXUuKzS5ciHEl6KFuQZXQog3077lsjLsuU/JFYnDR399Sq6VWVypZAhTCr6wZs/PjiWHwxCEyCoGLjp96Jgoo5tIIHbIZwOd9VT4aqaWosR5Y3uqwSTHi2I/t9cLV4O5dCQwDB+chHQWyewIXrBmqgKjyGo1N4qb9I0rZz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789906627; c=relaxed/simple;
	bh=l09ro+/+6u+MJW8+EYHOhZ6CmlEH1xAM+jR/NJ7S+VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1urjkHNcYFfLff57ijEreihBTY9NZeXEA7Mm0jYEXJsmTrEM26Z7LbmwFXRPWoCA2KelgOaUZ5rEGNcbQAYAwLMhOvewDM3F63Igy5dBLAdp9Qu5JeJL0DTmYjVdmqfogwv9gVqr2N9w9Rz5CtW0OiLs2L2nxC4X4MdUSwoncU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0169BJoO6naYsmR+1u4AG2NiEbSyPtVKXgskVWDVZ51+RETEfw7T8Txg/PPYn2wD6CffUC3aub5Lq8kan5o/tEBmXfUAMue+Q4DeVvRTuA9AThsvJOWP0+KfCP2CqyUakBfpUwyv9Wg8TsRbGwcOIIRuF+jTUXK6hLGM88TqPDKs+QaGXd8JLOczAz2LpVqfiXQyBHel53tFLPZXCbTNanIOPlPgxXKLHhH21J5GbPJWD4qfZEqOuqWeKjKQGVDSheFpnipBPiBxSkuDkCk3tnX2M/hLJuQmCnAwoUn9xQqnPSIOAjSg4N8ec4xnCTD4G/pgnlHujYVqRpo9e0hHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COk+zQgAKbai03rhMcSIYzRTspGbv4N3xOu8PjXrC+M=;
 b=g9HvnfpxythPd+xht1WuwaeCmMxIDoHJWW+tzU4xOaxDRh2etkkUZum7qudC0SUps9XW9dUUvyY29Hyat3f4pacR2LE6Lfcm10Kqspf6EPfDZ2SGEgCFXEZf3nkD8HgTZrki69q8hPZxy8SDsNAvlUX026LzZ1aEbKqj9kyCOjcDyVdduHL7s6nL9SLl89UnWAQEqCdo7HWQENQshdhaVhSTMRsvc0PfgTBsc6JoA+WZtH1pMQ4fLPnrFNrAsHpfyWX4dpyakZM+qv2khQMdtkhoksxLCf/QgvSZu7An2lEwYgDeueEmMKXnHD5X1+liYSMQzfQpuv/VHl55enWUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:00:53 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:00:53 +0000
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
Subject: [PATCH v4 02/22] reset: starfive: Convert the word "jh71x0" to "starfive"
Date: Sun, 20 Sep 2026 05:00:24 -0700
Message-Id: <20260920120044.194901-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41dc1b2c-9233-4a35-d1fa-08df170ed257
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ML3TsVDqRY/21T167VFMSFTLST1ZN/L2T0toDzHyL8cKMyx7ZNUyNzTeEcWdkuWtP7RGfs9hY5j9RC37hCregbjaOvKA9frQzj4O6V8VqqK+SWfDYIvDIeC0JQ0PkTepsgWyZVmfyb9ZHIgni9G/G626X8qlIz2C8oI2dnforCXg8YAhECeqj7t6PLzZINUAM7DLlW6Ydkhhx8pZ4Po/Osf2iULT4CtYSkXUJxH8I7BbeJ5SxqeQ8f3WPTCs2bkvs/gk6cvAdU4uJbutXaHJrbGFx+XagzH5M2UZ2+575jQnT9Et43ZX8KSkYwC0PMFZBXL7vJTmNkbxRz7oLQVsPca+sBlpNguCdUPuGKOmYa/bS96ckZzhSKTpoc9aXBnWOnoemP2BnVDFzxT/dA4rTKSvJDhYGRcs0U/cJs7bEgKj+M4UT34hLGaLTx4FfVrCsfDwZ3Q8NUFyLXlUpveAdm/jGnkbwI8POD61a+PTb2EA7hMn8mWqq8isuJ7JNnGb5YV+yEvugzqWvJiLm602Lb/SGepIzqMkv9mHG4YkGMxmqy8PUnouq12bCcCP2vRL1ckJpbezTyI/H56e/PtVZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U5PekmdO93uuxznjaWvTNej4ul6DRI0obDCSLP+qXRy3N8lJ+N8XnBHh3ZpV?=
 =?us-ascii?Q?Q634BmJpxgfz+HWvMAbX0vLbAt0cB3DTUJyFD+5n8abfywXP1MYZki8akz9i?=
 =?us-ascii?Q?Q19VFUnplYN27gTfcEIc7DXwV1pPBxCcTfOgiNel6WoLwOmRBjfdi+Mt/CH9?=
 =?us-ascii?Q?wRp475Xm5tk3LtL+hq8cXb+szWI0YWcIH8P0kDctWw4TzAwW1kN4SwTQwsk7?=
 =?us-ascii?Q?iJ1KCzH93ZMvEbVgjcVn9hcvvV3etkCetS+KE80ErPqfB05a4uHyH6kOea5j?=
 =?us-ascii?Q?MtjBBWaDeDAqqzS4KtrLG4FwddtOs18IwV3YAnL0Pu++/+2koj8ZNodG1ZuZ?=
 =?us-ascii?Q?9Mn+Dm+kag/5U6fzO/oKF4Yu0qqOG+wyyU+HUI6ZFKxa6CKNyxCrEsuz3fca?=
 =?us-ascii?Q?2CtLfZl6pNgWUDDcs1ZkGUk6/wIbzMHUASDe0o8oknUdKmhz+7wQ+wEB04lA?=
 =?us-ascii?Q?a3clHK9mDy5mbO2eIUl6QFvhChtulqNb8MLaXkFG+GlCZ/KK4C+ykNZ6Wrkh?=
 =?us-ascii?Q?p7heWV5a4tHJ6asBOhq+aqvnpfIT7kj/dg9D2nF7I0pUK7YP1QQFqNBQDHSA?=
 =?us-ascii?Q?qERh+OzfmDJkYUbUr1kg73DLBV1r6z2QANSWMHjJRyaiv0/lvWnR4otmoA7Z?=
 =?us-ascii?Q?33RP1GKrpBgSe0QjLmw91M3dT9EP6P/U94kvOqs+I8e6cvbpFYTSle3TL4Tt?=
 =?us-ascii?Q?QT6C+WcTgZMUIS/GFRIoGaUQ0OC4Y7XapXJdA+IFJr/cWxgur1lf/VZVbT3k?=
 =?us-ascii?Q?Zq+K4Npfw8dgnwQAu6W0Y4UUSK4/XJXl8hOubnF9xFnIRDZNvCSQIzSVj61W?=
 =?us-ascii?Q?e1UGXHS+Kip3quUcrqXB61QxsuxM2fb4zUjgzKQ9MCG1/g9db9/T1eygb7Y0?=
 =?us-ascii?Q?6nra5czC1/HXZ/OU7yvG8g883EYQBgE289z1YMZm3iD6j4Wn7rOXvtcVXNbf?=
 =?us-ascii?Q?2d2Nw8nG0yWcPFZKTON8Ccf0CobCx42c/IZBV3jHONNlYGT7cDoccC37mT4q?=
 =?us-ascii?Q?zNiU9caYmJo3fZbT0DlVzrWv6kMIdq3DlcVi0Sg3gkeRQ2Mde8pHb3qwM5r6?=
 =?us-ascii?Q?bGgfav9XoXfzyG/IvJtP6PkhgG7fmv4avWy+O6qi2Ak/ndVUx9SjftkqhxFu?=
 =?us-ascii?Q?wyulzYwkLTB874cwoSqNEzZsv7P2ZXsO+OkDn3PpHaZ0kzfpGevPncqYztqG?=
 =?us-ascii?Q?okOP1XgGp4TtMlQYTosZK0wtW0CuburCt5CS9NaHnWYsepULAjjv9ThubQ+w?=
 =?us-ascii?Q?bdVKlDOnjMjnXGYXX8QXEt/vGjS91EAJ2lsPG4B4l6kgmuhBZrt+H/nTrn/O?=
 =?us-ascii?Q?xgvucbmEDyqPgB9CBosk/5t6KHKzo498maGCDePbFtxp5lemud+0l3ZgTR9i?=
 =?us-ascii?Q?7G8GythkQ+EUK2biFZK5UtBy8SJVt/Kz7D0R6e2Aelv8+YLMBoNsH/E+dJVw?=
 =?us-ascii?Q?iisuxWL9ICDFbJwUfnk+M4TojOcZXXKMOCas3xDnMTeuiDFzLCdwWeaw99Vk?=
 =?us-ascii?Q?N1pRI45ED9wT1nxnV75TVbkkXjwbRib/dsmD9yiHPMlKEmTD1/vLDL16rGcT?=
 =?us-ascii?Q?3TWlSRbQvjUkyD1c7SIyoAulumUJfp0aCJ3dzJmNUp4Ls5xkAEeBgXwjhg6F?=
 =?us-ascii?Q?k7uTy2ODDlI3PTOqUQeRnZP4q3U3vzFyscgTEOqOShuMm4eV6hF2iRjqplJI?=
 =?us-ascii?Q?cpX1DHxWIXWajNspSSJ03yzEyYkjleE+vbmQ4dF+uqgrEuvtM6RUGC3ZrbAr?=
 =?us-ascii?Q?k3U7eZw0sY7QNUznSMFnGzphzLe317VSQMQk3QK/bboYVB14Eetk?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dc1b2c-9233-4a35-d1fa-08df170ed257
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:00:53.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxDMM+jI4llRaICMO6niX5kkoAF+E129CBwXUZ5SjGyE9j7kpsBmHpRpDxI+hST3v9w5KnovqnRsQF0HJGS0JG7dpWZyg9DAYWfr9ly0tgCHkV7Y510A0bpUHwgm1E+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Function names that consist of the 'jh71x0' naming convention are
renamed to use the 'starfive' wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  4 +-
 .../reset/starfive/reset-starfive-common.c    | 64 +++++++++----------
 .../reset/starfive/reset-starfive-common.h    |  8 +--
 .../reset/starfive/reset-starfive-jh7100.c    |  2 +-
 .../reset/starfive/reset-starfive-jh7110.c    |  4 +-
 include/soc/starfive/reset-starfive-common.h  |  6 +-
 6 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index edf4c45e6ff0..17fd061ee196 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -334,7 +334,7 @@ static void jh7110_reset_unregister_adev(void *_adev)
 static void jh7110_reset_adev_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 
 	kfree(rdev);
 }
@@ -343,7 +343,7 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 				     const char *adev_name,
 				     u32 adev_id)
 {
-	struct jh71x0_reset_adev *rdev;
+	struct starfive_reset_adev *rdev;
 	struct auxiliary_device *adev;
 	int ret;
 
diff --git a/drivers/reset/starfive/reset-starfive-common.c b/drivers/reset/starfive/reset-starfive-common.c
index d615c4a68cc0..772bdf6763d1 100644
--- a/drivers/reset/starfive/reset-starfive-common.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -14,7 +14,7 @@
 
 #include "reset-starfive-common.h"
 
-struct jh71x0_reset {
+struct starfive_reset {
 	struct reset_controller_dev rcdev;
 	/* protect registers against concurrent read-modify-write */
 	spinlock_t lock;
@@ -23,16 +23,16 @@ struct jh71x0_reset {
 	const u32 *asserted;
 };
 
-static inline struct jh71x0_reset *
-jh71x0_reset_from(struct reset_controller_dev *rcdev)
+static inline struct starfive_reset *
+starfive_reset_from(struct reset_controller_dev *rcdev)
 {
-	return container_of(rcdev, struct jh71x0_reset, rcdev);
+	return container_of(rcdev, struct starfive_reset, rcdev);
 }
 
-static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
-			       unsigned long id, bool assert)
+static int starfive_reset_update(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_assert = data->assert + offset * sizeof(u32);
@@ -61,34 +61,34 @@ static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
-static int jh71x0_reset_assert(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, true);
+	return starfive_reset_update(rcdev, id, true);
 }
 
-static int jh71x0_reset_deassert(struct reset_controller_dev *rcdev,
-				 unsigned long id)
+static int starfive_reset_deassert(struct reset_controller_dev *rcdev,
+				   unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, false);
+	return starfive_reset_update(rcdev, id, false);
 }
 
-static int jh71x0_reset_reset(struct reset_controller_dev *rcdev,
-			      unsigned long id)
+static int starfive_reset_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
 {
 	int ret;
 
-	ret = jh71x0_reset_assert(rcdev, id);
+	ret = starfive_reset_assert(rcdev, id);
 	if (ret)
 		return ret;
 
-	return jh71x0_reset_deassert(rcdev, id);
+	return starfive_reset_deassert(rcdev, id);
 }
 
-static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_status(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_status = data->status + offset * sizeof(u32);
@@ -100,25 +100,25 @@ static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
 	return !((value ^ data->asserted[offset]) & mask);
 }
 
-static const struct reset_control_ops jh71x0_reset_ops = {
-	.assert		= jh71x0_reset_assert,
-	.deassert	= jh71x0_reset_deassert,
-	.reset		= jh71x0_reset_reset,
-	.status		= jh71x0_reset_status,
+static const struct reset_control_ops starfive_reset_ops = {
+	.assert		= starfive_reset_assert,
+	.deassert	= starfive_reset_deassert,
+	.reset		= starfive_reset_reset,
+	.status		= starfive_reset_status,
 };
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner)
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner)
 {
-	struct jh71x0_reset *data;
+	struct starfive_reset *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->rcdev.ops = &jh71x0_reset_ops;
+	data->rcdev.ops = &starfive_reset_ops;
 	data->rcdev.owner = owner;
 	data->rcdev.nr_resets = nr_resets;
 	data->rcdev.dev = dev;
@@ -131,4 +131,4 @@ int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_no
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
-EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register);
+EXPORT_SYMBOL_GPL(reset_starfive_register);
diff --git a/drivers/reset/starfive/reset-starfive-common.h b/drivers/reset/starfive/reset-starfive-common.h
index 266acc4b2caf..83461b22ee55 100644
--- a/drivers/reset/starfive/reset-starfive-common.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -6,9 +6,9 @@
 #ifndef __RESET_STARFIVE_COMMON_H
 #define __RESET_STARFIVE_COMMON_H
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner);
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner);
 
 #endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index 2952719fa31a..f904ef8a258b 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -50,7 +50,7 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	return reset_starfive_jh71x0_register(&pdev->dev, pdev->dev.of_node,
+	return reset_starfive_register(&pdev->dev, pdev->dev.of_node,
 					      base + JH7100_RESET_ASSERT0,
 					      base + JH7100_RESET_STATUS0,
 					      jh7100_reset_asserted,
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 87dba01491ae..c4dd21761e53 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -53,13 +53,13 @@ static int jh7110_reset_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
 	struct jh7110_reset_info *info = (struct jh7110_reset_info *)(id->driver_data);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 	void __iomem *base = rdev->base;
 
 	if (!info || !base)
 		return -ENODEV;
 
-	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
+	return reset_starfive_register(&adev->dev, adev->dev.parent->of_node,
 					      base + info->assert_offset,
 					      base + info->status_offset,
 					      NULL,
diff --git a/include/soc/starfive/reset-starfive-common.h b/include/soc/starfive/reset-starfive-common.h
index 56d8f413cf18..16df46a074bc 100644
--- a/include/soc/starfive/reset-starfive-common.h
+++ b/include/soc/starfive/reset-starfive-common.h
@@ -6,12 +6,12 @@
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
 
-struct jh71x0_reset_adev {
+struct starfive_reset_adev {
 	void __iomem *base;
 	struct auxiliary_device adev;
 };
 
-#define to_jh71x0_reset_adev(_adev) \
-	container_of((_adev), struct jh71x0_reset_adev, adev)
+#define to_starfive_reset_adev(_adev) \
+	container_of((_adev), struct starfive_reset_adev, adev)
 
 #endif
-- 
2.25.1

