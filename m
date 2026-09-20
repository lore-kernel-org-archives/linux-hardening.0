Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5938438490;
	Sun, 20 Sep 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789906717; cv=fail; b=N3LBbzUxEQfnbpDkLnFcPpPfreN7yOIh4a5lLcBR+0iySSasfbrsK3qTWJ58ykylTIFDPwVu3DP6m84EPT+QVFfakO/OaQ9m5LAPzzyRoPS2Whi3cywpzFS3/7H3nSwh+c+gOZhKWaroVAClTjpPPE0cUvpLsvoMlHRhzsziSiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789906717; c=relaxed/simple;
	bh=kcgomHn9aswhhkKpQcItUw+Axf8Psr2r3V5flUQai+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RBkcTSXUFOgDi5H2kk7HCcNYswv4WF+WSaM9nWyUQ45fyVheHy7OLPrkypiPb2PRu1UO9yvGdHAspmHmg7xOPXvtn2AsjoMd785qpch0DO/uzKcbI/rg7539N4FYGZv7U0xDWfVK2bW8LD/FjxBApGm5qL/ik8Djk8r6gcAouac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=higYAscQNstWymkzPjfMz964SG7D3pbinLVMgBUP5KhQGpjetOzyvUQa+z4gDj4XdvjRhh6BUwAfkmk/LhlM0BmKjn5PYI5pAuiOiI4L1wEvVaDJ50iCZsoE/oSqkid6IMZQSpGl8HsfBSFPG/zjtTfVwtqD4xVwJ4E0NBu4HI0q3wrHzJ0PfBm+tIU35NGZ6tnBN+jH2roQMfJjXsdXxXhXSi5fRZBYiJuYYbPqCHO6XqnwSldtMV0lUn2Va2gH1P1TxC3V9bGAnd4BdEn66t3pM2rPVb1X+Wr/KxM42mp88NcSYq+Qkf+04qsdzqcWYCGPl1s5OPosmOufen30Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=430ZPZ/ZVmmeDsUJou6JbP3Zw1mIA/CIJdaNUYIcFAM=;
 b=Nk+CDnEgQFJnvYHInwgloL7/pO2yvhxWbZUJ6+/sxPflnreZvJv8AfVSXvy2HvHzqUkAK4kueBw1x/RouTij82UG/1LrsEbqqqYbs6iIoDumC0GWkECQdElaovwjj0Qvnv6hKkLJe+OjA6R45bQlcVGBinSBkmtrrckA+z6hPsXBxCc+SpmR7QDWsTZ/Yr2ZT9yK2727wjNjn2VLEJnja5D3uGVktZNlT9FWf/sy33oMWRiQF/hQmCgQmGU6c+SjhJuyC1JgLIBJ2wRswf/aidrHxrEKVVu9nFcEEyVBe7eg3zstWTeicGzCW0uX5nf2OHnP/Hoc6U3EOarmBbZcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:01:03 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:03 +0000
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
Subject: [PATCH v4 12/22] clk: starfive: Introduce idiv ops for inverted divider clocks
Date: Sun, 20 Sep 2026 05:00:34 -0700
Message-Id: <20260920120044.194901-13-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3256868-2e02-4e12-2e18-08df170ed84c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|6133799003|38350700014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	6joNCu1oDBrCgyYqOQnKJzNRYrarXGp6+KwLlKOQ+hi8ZlNBv6Lda7Hir0Y1noCHrqBvWYYDf95JnQjbExgUNmibXjBodRszhzZLivWwRENiNEI8EH/ri1eZt8yAqQXIXbC9/AaQq0+mtPqZNX4GTQ+ihSr6MefKw7OROj+TAwJ/iqYLrP0c4nLQdeKtf6tj5hurSqGTnwjcauJuNkyDCp67xYP0YKiNV/GbAo6o835jtRluDhQ46aLUNe+fMWbBUOT3KEUm+jDxQLmIvrKf374Tg9i4vBaCtUO3F7BeFORx1fMHn6dtcS2xuw9CrTv0dhIlkUZU0MtQm/M3Ollk1nog3DoegQjCMWku+QTaEdE1H0asX1jybG5DK4HZxucUApZTqgNG1OOP9Vix2DoX89oT6mO+CvM4aQEPeV9sa6OXEQMLKOBke5sX+5aNVELDn0sG92zVG73NO8LG541Wdl0YoUpwYCXvIutycW0KYDvvgls/3A8hCeoYDPMT8gJBpPpUBraQ+O/w+6xTOuEkuf7RA+6rtrwqeyulEMSJLQKXnpG7BcTZmXSwE3bbRd2X7N8tI+NkncksTaV1NQNzcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(6133799003)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sIB/JTTLFyIqZ8jbUP3T1IPWtlJewIoN03US8YdPBSk9RkXxIjPVznLoGI7?=
 =?us-ascii?Q?M4xGUWK1nz16GaoXt9VF+kQRm+KTbrfXk/n+wSQymOddpbdpQmC4F59xMHzX?=
 =?us-ascii?Q?U0l/nWZopGiQa5uxfVOoKrp51TV4E4jIOu0l1WM2h80hKCG8qJXrsI/c7DfZ?=
 =?us-ascii?Q?0pQn4eMHWXFpR7BPZl/l96Yhg6h1DRMda+LsTNLux80Tm7KtrFWjokc3Boku?=
 =?us-ascii?Q?Q+Zxwjt2u6jfgPsJPxFbV+V/0+x3fwHSyrsVOGJl88Qug/0oAiB7lOJaZ4bF?=
 =?us-ascii?Q?QhgLa8f+hVWNUl5pOVvQLF5+SFnt1x9LrgDRbd+Hmn+B/DNiKzSvTa7umoMv?=
 =?us-ascii?Q?Gl8LSxwG1kmglR0Q7imVoEV8j1Zq5znneXgPmPTzFmRNpqnF2KxcF7ysX+3P?=
 =?us-ascii?Q?Xj/AfW6DthtuRC2o8i5jwAbiEOC+yKgmFMq/IK4yR9JxS79g6UMpjLGSjqXS?=
 =?us-ascii?Q?Ywbp6D1Fr8pzCFd7x/50x/RzA7Iyya7kZHTmdt/IcgzG+eKDT0/DWkPvGCp3?=
 =?us-ascii?Q?At2/1sAdP4u8Zs/13MqWP3ZfQBLMtVRzgj6w0M1aWodRQby5FlReqhtjCRRU?=
 =?us-ascii?Q?Ir2R7IBmRHy8Ds+kZK+6S4P/gayz+Ma+dkjOz6E2HM3FGzZhILCqlwaBQ7hq?=
 =?us-ascii?Q?iczB+a+vW2RE5OOKaiAeVroKJONYanmu63KCjthSOxCgf5z4LnfAyA5Q+N2O?=
 =?us-ascii?Q?hq/sltAlVxeN1KwxDWKZOFnYMtzaoA9dYfF8EZG8C3y8fzzG6/Jx0/MdGUh6?=
 =?us-ascii?Q?Iei3dkTd/j+6CKucs8nbgJmW+QkP0fjOInvLfdDJY6h85pnJxlFiuk+XbI3F?=
 =?us-ascii?Q?2wWRm698eEgwLZKA6s3YhGcTs6ICIis/CJqJleHYY/bjgxIuc9yOVZFoAQ5u?=
 =?us-ascii?Q?MVLGsYDslg8irRh2ztk97PSyqiEb5EGbG5S4Pg3wWWGOYRJ6DgZvF/R7cuh4?=
 =?us-ascii?Q?e7HmNJh1RRUzBOB9ZYAxQ6C4HYERXvKYfkPd9wugAE9Ys5hDEnilZeQ4KrLf?=
 =?us-ascii?Q?NzGs3g0LWpl2tXGHmjesVxnXI32erW6RxYvUAld9z6dkRN1lUIovruK0nVHp?=
 =?us-ascii?Q?2gD2Pyb7aV+lLNizLH67iCC2H9Qo5G4ux/oJcNxdjW6FsfY3rKPKkcXXukIF?=
 =?us-ascii?Q?g/SBf4hHFp5ICwnRo4G3IPR4fNndWZnOLDjzXIY6aUEDWQqbaRbEilw1aF91?=
 =?us-ascii?Q?/4uvQeL4b8fAQt7y2YDqM0b3ywI519jRaDZsJncynSn3y30RKXr7p0tdHTDP?=
 =?us-ascii?Q?T9W2OVFic4SBsxuiyqhFdhflkNPUWdZqlhyJcCoz+ehaTb4hHb7dMCFHBNZw?=
 =?us-ascii?Q?61OFEVbIbIdCIjhI9h++Lg6BkjF1JzbR62TQYV5vRuCpUgR7THYpa3ThKVCn?=
 =?us-ascii?Q?bgbc2+PRV7aF5IP+5Sn7bkY97AglvFQ+1vrKhZk2atvyRwF5+QA7CKvQvSUa?=
 =?us-ascii?Q?kltyaVFqufRR/AI+JmD47HWUDFCg32v3epwNfTQv0pOc81pDSAhD1K0X6ryN?=
 =?us-ascii?Q?HpJDHx7zvFirAxVYU2mz51GGnafjA79LcyLGWh1fHXMjUcdz/d2+6kV/lvKz?=
 =?us-ascii?Q?RzL+XpA2tQFKYYEbJRVeFrUDsWx8TN6y6wo+8Iq8cvagdiXUiDgUnDnjZ2fq?=
 =?us-ascii?Q?7AzJeNns21m2O7SNn9UNVjBWiTXSfZMmosNux6bk4Sz9aISlLHOOQ/YpAPxb?=
 =?us-ascii?Q?71r8Oj1WDKRMU/VSZlZQCh4VpQV2eh39jcSbbmH5o7ocNQatZhrfcSZPyGsM?=
 =?us-ascii?Q?OnsxB2tCb574+R3eLz1bk4m9Q4OpTThPx03qnqaJbqvuz+f0TJgh?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3256868-2e02-4e12-2e18-08df170ed84c
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:03.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oxv1JQUeIMybLvNrUjxo6BjuXnAS/u46pfkN8fm24kY5EdbB3E2DGJwYI4BWEpuDb1sdl5P/kE1oVG++cDRJqhk6lujkjwV5j+XLidEGFBw8OGIC+f3NlsVRPmMTvu+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

Some StarFive clocks only advertise the divider and invert capabilities
(via STARFIVE_CLK_INVERT, without ENABLE). Add the STARFIVE_IDIV() macro
to declare such clocks, and starfive_clk_idiv_ops, which combines the
divider rate operations with get_phase/set_phase.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-common.c | 12 ++++++++++++
 drivers/clk/starfive/clk-starfive-common.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/starfive/clk-starfive-common.c b/drivers/clk/starfive/clk-starfive-common.c
index 9678616d293d..523e2f816036 100644
--- a/drivers/clk/starfive/clk-starfive-common.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -300,6 +300,15 @@ static const struct clk_ops starfive_clk_inv_ops = {
 	.debug_init = starfive_clk_debug_init,
 };
 
+static const struct clk_ops starfive_clk_idiv_ops = {
+	.get_phase = starfive_clk_get_phase,
+	.set_phase = starfive_clk_set_phase,
+	.recalc_rate = starfive_clk_recalc_rate,
+	.determine_rate = starfive_clk_determine_rate,
+	.set_rate = starfive_clk_set_rate,
+	.debug_init = starfive_clk_debug_init,
+};
+
 const struct clk_ops *starfive_clk_ops(u32 max)
 {
 	if (max & STARFIVE_CLK_DIV_MASK) {
@@ -310,6 +319,9 @@ const struct clk_ops *starfive_clk_ops(u32 max)
 		}
 		if (max & STARFIVE_CLK_ENABLE)
 			return &starfive_clk_gdiv_ops;
+		else if (max & STARFIVE_CLK_INVERT)
+			return &starfive_clk_idiv_ops;
+
 		if (max == STARFIVE_CLK_FRAC_MAX)
 			return &starfive_clk_fdiv_ops;
 		return &starfive_clk_div_ops;
diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index 4cd4357f8366..fd9d13735896 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -104,6 +104,14 @@ struct starfive_clk_data {
 	.parents = { [0] = _parent },						\
 }
 
+#define STARFIVE_IDIV(_idx, _name, _flags, _max, _parent)			\
+[_idx] = {									\
+	.name = _name,								\
+	.flags = _flags,							\
+	.max = STARFIVE_CLK_INVERT | (_max),					\
+	.parents = { [0] = _parent },						\
+}
+
 struct starfive_clk {
 	struct clk_hw hw;
 	unsigned int idx;
-- 
2.25.1

