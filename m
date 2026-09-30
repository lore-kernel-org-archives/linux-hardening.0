Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA42E8B67;
	Wed, 30 Sep 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772266; cv=fail; b=R02Y0ILc8n5BEp0YCXaQh01G+6/IWES6vWXp3fUcu/WBEKk2jSQjQf0WyagHM9As71Os5XgtDjWgJS+F14mfA0PC33f6ysqFbbmRRTvXL+jy+q7v7qaFlocZtncy0ceaqFPquhDJOfhQ1PzNn1ujJuGpkD4jHUdN/u9UmmriYDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772266; c=relaxed/simple;
	bh=O30g9EXs83HvVSUgsPaImyhgiwq/3JLASF4F9gNTrXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIswTGCxKlerDauUX52qd1JQ64jfHGHJgSxok6h3MUfWCzx8hdYVkIXthGvj77XF2/RkzUeQQWWDd2SRB3gertrUBsrdJttiMYejcQWGikxRVvOtM+p6l+JP491YIL2ziflorkv6GLHRwn/d8EbNlW1Jtie85zthoYtO2dd/y9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACM0Mic7+C0h/Id9J2+wrow74WByB/KR5u44upceNMxuIDYKTceTG5pf5ALavZqhiQFJMXZRPYuygaadqwxtL6nGIsWuTpZ+By/iTv8yUeRPSDENOT2aeJ0BHPDmrddj8D/F9P3utRZwQpD9uxOFY6GDQUmHXckYJhI7J3DjRHRdd6lto7JA0/AdwZA6n+zFQDTolhHFMzFdw5zxYT+IOxljlByYRnMjPtPl1q+ladr4DsWHPJ5Jb3+q1H2///eLmE+7GiU32tvSKgAz2DBIJR4RBp2I4x1ImcCTxJ3i6zhS15GNsjJKvqL+taubRach2l7nut0ieZXtqxDw0aVIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT8sGgmAxjWyOHFhwfpOyLDggZGvaqPgoQPC0AK8NXE=;
 b=bp6iz/0IlNACwIiapmow9y/uHcCPSS1kSHRc1HaNOdrXqD9LrosNmkqrsez7CYyH+l1yuqVtzwF61Dc7WaGOSLHPZv4+oDGNXXOR41aauq70yKVYhrsvr3Yb7DBuTZO8ICLK5arGJb1Ym8BvZlUK9c3q4vexzW71cuSLXuSYRXqi9h+DXBeqi+bcxG44RcrsNOn5sRA2zUvtWP70VpBYskSJ18k7doFWbn8ruJSaFg4/nEIFD57RoXhUSrjCbDhEdZgLqeKUO5bIUnaMjYmEwfsUleFbLM32LG7gwrJWy2fMvejSAK+ffEuM21omQnPFh0JFd2dzq/xL5di+NBT5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:54 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:53 +0000
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
Subject: [PATCH v5 12/23] clk: starfive: Introduce idiv ops for inverted divider clocks
Date: Wed, 30 Sep 2026 05:43:06 -0700
Message-Id: <20260930124317.5648-13-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c253b27b-704c-4c81-ba6a-08df1ef07c5c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|10067099003|56012099006|921020|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	PS8zpOMnn63dFDHu59jqWQBpBqiDErpVwrGrIVRzPGDWq3BEo1hubhsxZuJOyDWVBlx5xR+EE+/WwkyQc5NNT/8el+gGdyGpGSbrxhpxLTCHUo91NmYvpHKW1I9C6dw72HuN9YiFuBeVRw9BiBq87wAYL86sdiKG/2eXDl4nlF1vyk8dBwyqSM/I6W2kySpWBBlXgAAzbW743U6a3HcTxCsnYPZIy+1SPpftyohICubCL4L6d217jDsnic7wLezX+qHZ4yC21+1nOw/+i4IVoAHiUjjcxtbNo5KzCnsq2CkIEMleOGxCJyPxjdkaJZkxqFtzH8QWle81FNN4UJCkduwDW02U4JYSqgKia2tMe76ApyQj0xiWCh4z9N2HR3V0CU93ItvoZMdu9x1XSqR/DR/EYp3O5Qgc1fUCJ4Z7i1LAk62D48YhBG9FqhdIcA4o+75A0qWRXIkYXN8Vp3ihrzo/4+lCjYVRdD6cARubxE0vlrX89MutvMOPHskJ+E/PbfL/uciO/bZ/w1X5vzc6rOlRPyOH4zxbwJiG5UgFc0DMqypIPccyh1HKXCaSDpw7QHJ7BWuOGOOKX2Mw6c8v2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(921020)(6133799003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P2Khjehq1nip5FFQUqYxnQ9UPv9v70VcSw0U96j9BbWGXfd9Lx97o6W5Gv9W?=
 =?us-ascii?Q?gDoQAQYKWbRhmMcMDn6vdaNHruKS4TOABuclDP/l248Apda0PGrJl3Ostcxz?=
 =?us-ascii?Q?8uOyUD7Kfir6HrvMpwNK2QoIUKsweP2VDg0TIxBlPt4IejoKAM6ao8iCFugN?=
 =?us-ascii?Q?rTyTBBl02qbd/xZ8Lo046Czh18XvSV0oxkjz4Hm8WsMwDFjnovjrHEudylVe?=
 =?us-ascii?Q?2l0y/YaDmxavJ3z7JyIfMtjeMQCUD5zmg2VhgGEPAEmrCjgpdVYz8E2u7ZaG?=
 =?us-ascii?Q?sFCFL3r14kQFh17X/tH4Ba0gtDT88GeHnBVV4pmg5y3SwUypYFA2GgZWj/1v?=
 =?us-ascii?Q?xuSn7HvnUO5RFapXKWqyte/IZTEiuf8M/KiOwD7F/kjz6pahbXHnhxe8g9CS?=
 =?us-ascii?Q?pQGViMuhGUY/xhONSiU/WqSpNKPpZAyjvkU9t6zwbYUoqx77bC1c7ZpNSdL7?=
 =?us-ascii?Q?Zh6y/xPfm5zwYdEIH2ShmpUSDsE1b6+7d7FszlaOfHkZV8sO5wgpfvrNOXt0?=
 =?us-ascii?Q?CB5zz9Nno6glFJbI8AWfkVCJ8JROB8paDwCD33ZJdMbV0MlYxnWqP2uxnij0?=
 =?us-ascii?Q?ybZqjCmDML1RXaN/4U5uK7EnLV6w2AyFwl8inhJktObFgxhBoVEIb7Gn3i3x?=
 =?us-ascii?Q?HpoJWvbm2zHZuK6/62YabHRiEpIUcYIbIbxlI6diwk36NcsEH8yAa2iwW/q8?=
 =?us-ascii?Q?h+Zm6K0Q1cqz9iidc1zgvs71gCfj357PeNn1/iMcfh/jrgwckuh3fv++OzGB?=
 =?us-ascii?Q?BssvyJ351QeHCmj58EWOCOlI1f05NhMOse90Ii25lyft440TRRxM9aUb1b5Q?=
 =?us-ascii?Q?LILtVmcYP6wK1KQiqepDzhj57KCu+IsCw9CZliAnlopEASbjt5kd2LZXhTgM?=
 =?us-ascii?Q?eEt4bhW2wVB+WxjM9NwtLzOxCK3MD5lVnRTnW+FZcGL5DOHU7gH+Tb2AWfZ4?=
 =?us-ascii?Q?/T9rttreZXqVe/5siOHK2TuY4N9rGi3lrOjJtJnlNhknxOHLu1M6tcCHCDP4?=
 =?us-ascii?Q?JHJRXdG31dQPQYNx77IllH/Ujw/Cj14cz8kS97uFrfYGmk+ZDfHP14paQ/Zt?=
 =?us-ascii?Q?1J8bZR8aZGB4w1Haj1ivWEwnHa6sxAnSl/DACIDfxJGrKEGFSL3RGvKVC3P/?=
 =?us-ascii?Q?tOeoSfYBmfkmlT80uZ1FP/em3k4aH6dymX2r3WRH/RZE2ua9njGG5dJZSvpw?=
 =?us-ascii?Q?AOqC6zxAjx5K5hWgLBAnV3ORRBjQ1yCJ5Q/LPn3mqnZ4Lk1e6jky0FGY9mfv?=
 =?us-ascii?Q?cP+HP9+2DHRnAlC94oSh2zaIyaG2EzEcP3+PvtQjIZNKbH1DR4eih9gSAxQV?=
 =?us-ascii?Q?5xXUi2Xss4dNjf9iK25MFtD8uVOLP76AbuKh/8JekuMMb/kvl2nkYyQr7lSI?=
 =?us-ascii?Q?LABhfKJ5ZpO3fXtjQkUT0M9Y64gtnjblh8ImVfgtmhWnD29pxK3A8Kj+zQQq?=
 =?us-ascii?Q?DKzPXk+4Mv8eYPrqJn3N8LrFfYKSdWLR3NNbE8HFKFElQ/7l7MYqziTFONXD?=
 =?us-ascii?Q?AYio5UCJR+JW2OvxhAVjC5so2+5YyYht/4hCyj06J1owGRpd9Nd8dhj3ZxVn?=
 =?us-ascii?Q?NzoZ44xxuuwtIWAfbKSzWyzOIOT/uU7t8Hp0cdmw2iLk0GG+CWP87Am5Kt85?=
 =?us-ascii?Q?f7OQYdIWnQjZyuLs6eh7J51BEQCo7AzxfvdnZJdluJRzrLqrAW6qOrpBaf0F?=
 =?us-ascii?Q?+sEUjhPI7+wVAUC3TYUqE8SeXoeHwe92CS1ARtf9Q7BYEtMuOGcel/8vAMna?=
 =?us-ascii?Q?9UFUjP9mLuChQZY68Md36pas/Vz8fLFdH7yvDdske/2/XJRWJOZx?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c253b27b-704c-4c81-ba6a-08df1ef07c5c
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:53.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lmx+eAI8PRi8No0OWFr/jOLt6KigQTPBROwPpHJbX+I2hwk5ELY7aNjnKPj2grbWsu6AKpM5UjpVQPt8o6pYR6dO5Yc05crLwQ0PlKoedJKf29a6i7BG4y3044ae4PDT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

Some StarFive clocks only advertise the divider and invert capabilities
(via JH71X0_CLK_INVERT, without ENABLE). Add the JH71X0_IDIV() macro
to declare such clocks, and jh71x0_clk_idiv_ops, which combines the
divider rate operations with get_phase/set_phase.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-jh71x0.c | 12 ++++++++++++
 drivers/clk/starfive/clk-starfive-jh71x0.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
index bb7706ede1a6..1f98f1f8f0a5 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.c
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
@@ -302,6 +302,15 @@ static const struct clk_ops jh71x0_clk_inv_ops = {
 	.debug_init = jh71x0_clk_debug_init,
 };
 
+static const struct clk_ops jh71x0_clk_idiv_ops = {
+	.get_phase = jh71x0_clk_get_phase,
+	.set_phase = jh71x0_clk_set_phase,
+	.recalc_rate = jh71x0_clk_recalc_rate,
+	.determine_rate = jh71x0_clk_determine_rate,
+	.set_rate = jh71x0_clk_set_rate,
+	.debug_init = jh71x0_clk_debug_init,
+};
+
 const struct clk_ops *starfive_jh71x0_clk_ops(u32 max)
 {
 	if (max & JH71X0_CLK_DIV_MASK) {
@@ -312,6 +321,9 @@ const struct clk_ops *starfive_jh71x0_clk_ops(u32 max)
 		}
 		if (max & JH71X0_CLK_ENABLE)
 			return &jh71x0_clk_gdiv_ops;
+		else if (max & JH71X0_CLK_INVERT)
+			return &jh71x0_clk_idiv_ops;
+
 		if (max == JH71X0_CLK_FRAC_MAX)
 			return &jh71x0_clk_fdiv_ops;
 		return &jh71x0_clk_div_ops;
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
index 2a1f0fb4cbb1..4cb3c2ef9525 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
@@ -104,6 +104,14 @@ struct jh71x0_clk_data {
 	.parents = { [0] = _parent },						\
 }
 
+#define JH71X0_IDIV(_idx, _name, _flags, _max, _parent)			\
+[_idx] = {									\
+	.name = _name,								\
+	.flags = _flags,							\
+	.max = JH71X0_CLK_INVERT | (_max),					\
+	.parents = { [0] = _parent },						\
+}
+
 struct jh71x0_clk {
 	struct clk_hw hw;
 	unsigned int idx;
-- 
2.25.1

