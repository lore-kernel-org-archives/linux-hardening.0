Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79A42E423;
	Sun, 20 Sep 2026 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905804; cv=fail; b=tBuuAsUW/vRY1Qzm9d0XlIS1wfG/565FIB9c/hWzFAosTxEA7JZND2/uxjabx/y4zQ8YVO8WCg8nfU+IyegJlJN/MZ85m+nqkNnxaRPRE1xyfOwmtmKO761RlgVamBcmLo2oV6SJJds2v0PITIpwkE4oTupNGw+CW4Byefi+9wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905804; c=relaxed/simple;
	bh=k3sEEHFIs7UXXowJYy6KPR+mar6DCNUNzVPaBLT7B4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cki3fk1k5PFLgvWmMv4ZHimgIqyP53+cmLDfzq5z+aRna1Jm2aXHF/77zdNit4iCjXeg10aNuI48IExp3jIDrCDfsAvgIM4743j5V6gcvNb2GfsrySER0faz6eGnzJuKHtFAP4jLrRofzI+YXJql2/IF/cM/u4QOvBq1sHIY50U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjDGd81E8AlpG5t4TPoXeTmiK6aYKh7d+Jq4YPEIwFeaP6Zt2U0rLvlYT8EFDVlumFq3g3h0eFRJXhIqcUJJJyMxbvpOb5aMXgj9VkJSChRVAcWMX4MuBXsyNIi88WqhJkNgFXs4ZXB0dJksJRC8AKGHl2zMfIm5ybY1qWfSTvsYrcj1GxECnJN/jRLMC3aT4jr3TLi8jz1M49VlxwNL0jKPzxPmCSYzCi2svkhij3khJBWgDXxRjmIZa3rL8umFpL3iCuPmgrbC0H4TJC0yJGD9FBDekkvVSfq7SDnjpw+PwyL5ZBNkUcuJXxvtL/qhUI7f0w1JC9mCqPbSVIRw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDQoGnW7X9F6IPLudk87vUa9yGEyKxfVzOXW7y5jXF4=;
 b=DQU5nlX45BuSX2hQSrncgOeYIYw/iY4MFyIlzxSXfKcPALGgxd5YvUVGmX/uf88Yiw9XPDd7dtwXUzp9ie7ZPLxF0T/FyaAjzd6t2H4B6/AKu57IzMamkPS5jGC65bVEDfBsav4or2FRfmAZv5HORXWtNblvhX12A8Q3MpVtRHHP/iuWy+tBFpgYBzhHO7+Erc1tfloQ/CEe7zPC9uhq2PijQ+gND8/SVyBnrd2S48OjFw/BwpaM3wMmGJrIkUhWwoeJJY68UBxx5s3uAsArhXr22QEzzHfqxioAPMDzbikapNQWolynHwEKMkhzSA+oDoGFVajyp1Nx9IpLGYbwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:01:04 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0428.014; Sun, 20 Sep 2026 12:01:04 +0000
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
Subject: [PATCH v4 13/22] clk: starfive: Expand the storage of clock parent index
Date: Sun, 20 Sep 2026 05:00:35 -0700
Message-Id: <20260920120044.194901-14-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 19c8e4f4-7bd4-43c2-5788-08df170ed8dc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|921020|38350700014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	DDwtSqahQ4IuVqcyVy1659Kze7XrNRh5gD14Zd3dglN4s4iWl/wTnlSmvQ9yOMMl1viHb7VAxB+eSs4tcuMo7cG8uspPfkk60Rx7n6KF28lbijhwN3aWS6Mh2jMlCmJMjq/CgbVCy8ZX5W+Wza0Z6NhBGI6Wg9ZZLeMZ7JLvm1eh6lSmMmIS76o64n4S3fRI2S6bXfpWZsLNAuROCSndSAttMj4UbvE0iTLX0/aJpiUMVcH3TmCBzMD4yBTqLogFzw11cjIEb1Wsb+3faW0l68nZVQFtRar4jDsusBwmvh1IGn372N7WVyHy2TI1eU5ejFX8RSYjP6TU9ACaprRhUALEtvuC1oqKFFV3WmdVp2KTpCnCZg4A1GOBbAYtgmP2VgmryR+jju030bTQTrN8tFFvhCZJPktyL5Q46XpOO+putUJoz3nU+9vCm/wUbTM7ZKfA4rVO+WPecEEobQQkYx6hZSZTP9Mj+Z1wsRThRvHG37xZY4qU3uWHiDufx5RTkeMyDR5gkGr65ICDd2N9lNiZnX7N1wPUd0KPoQ60SX8ZfXgaWUll6k8vhC/nKN7UlqgSlnyGC0HRTTglYW/2ug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izNOTNGDLP8Kxjo9ZdhM7G832Lz0ZezLhk5YltGEF1jFk4l4vOuizCRW8nqN?=
 =?us-ascii?Q?jJkH8WIw7lgNq1S42tX7iCRH/ypVdUBM0xFSUWLHhjxZS9PMckakAYikQM+g?=
 =?us-ascii?Q?SP9gnPRKjRTrIoR+15k+Q7n9HOjUvLhXXXU8QAnTy+/NJM5is2typ+RK7Xa3?=
 =?us-ascii?Q?LHPL4KdKMub2uoEp/p8yPv7mNQCep/MrncwPmTmLolCHZAvrbFZ/BUCwQRaD?=
 =?us-ascii?Q?XBqd9UGyv/MP2hmrBHyoqDgU7VwiM8TSILzAbz+FhsMg1F68EUpYrJTYo+m/?=
 =?us-ascii?Q?u2Z7b0wF9DsyjDrMUTjetHjXJ70j5jrdricY0Ao3/cZrAqL3w74cDjsD+sap?=
 =?us-ascii?Q?8z0ww7/d8r7XywpY5B44mNjUQOY6/ro3AKFlqGnrYp3pOYbJ8iXfCRHge2zI?=
 =?us-ascii?Q?VPsQ8T4jbpQS42ifl1d7eM6g9QjY9X/s9wiskLiHAR5xOjOSGp9QBVBKpvlL?=
 =?us-ascii?Q?U1RYxT+nBEJA3TVnaLvI2bAbO3iReUNb1jDrWmO6b3d6rzz2j0pEvSPHMaZ1?=
 =?us-ascii?Q?WDFYbZmvXEb6nYE1EHUhEXQYmCcGlITisGAVU5Gm6wSaPQhUFvHOf4Ansowt?=
 =?us-ascii?Q?ulgYy5MGHO/0BLscIk3ttkNPqbhIY47KM0xMtkxNk48svzPhqFa5f+hG4bBy?=
 =?us-ascii?Q?Ig/E80WuYbIQl0MgZ6qgRl2L6BUhQTvarSl+RjVpkTDyiU74Nx9qPTUG3sV6?=
 =?us-ascii?Q?rW2Fswf6ULf5OYWpXlxdQiGEqUz/kc+tQV9LkvVmMePTRdbaDOSxXlt94Nuc?=
 =?us-ascii?Q?O0klLM47xjIhDmjIEGD0rQGeyOIysdtWiRea1JG/rZo34HSvGACMvz7fCYU/?=
 =?us-ascii?Q?3dueikVVjM78oVXIaED7utU0pRMJ3XM/ur//LG3IvGHc4en1p6Qe+XJ/eTo0?=
 =?us-ascii?Q?Bzk3ZiBvew/eE5fEPKwpnx3jMZ2hJhH7Av/DxQFVglvLv6P7xpqiraZUwksO?=
 =?us-ascii?Q?x7BjoL4S8sobfYLXqEfxqfnctk3Matf4Y34NWcg9aeB8onw/lbHzGiNWpD9S?=
 =?us-ascii?Q?YRfIa0Sg5w7bEsraTlT5Q6tK887pvSyF6YHek0l51dFT8OSqTXrnzEbydH15?=
 =?us-ascii?Q?dKCNHNGMBpEo/BVJ7ET40WCUTnsEtzE5ZaVdvushs+1bPfcoJcB2fdXAIiSH?=
 =?us-ascii?Q?2/frbbWzuQFr4+MvgJ1msJ/HvWLPMvsZRwD9mUsw894VuTTpYQsWooGQ3RiH?=
 =?us-ascii?Q?6tSNcoknnXfkm3rwKMu02UiMlvoFfgaAqPQkBQHtuK5Wa/z4xNBY361ZqLRq?=
 =?us-ascii?Q?lyT8A2AzApKQLpBKfnVTn7+vex8t8XLVqqsYP638VrWZn4wQ2RB3Yh8PP3EA?=
 =?us-ascii?Q?+Ki5KR9j0VPeIHbdP/mFILmrBMULdgERYXFx84tPRPo5IFa/sESa6V7sp2ni?=
 =?us-ascii?Q?JiJVPlS2c9POIChhURZH5blpHCNR6CIJmEIGulauk/sLySJXS8G2KLniUREj?=
 =?us-ascii?Q?0JMFub2TUzP8AANuhUi4OK0WNaDCtJKnDrBZv7YDtjqFqdVM9X0YFV9u3/Tf?=
 =?us-ascii?Q?Wr4rV2UV5cJ9963ci08xO8uwt1kpk5N7fKfXzvs6ek3hOI9fJTmiIHrJmRos?=
 =?us-ascii?Q?f8HgGzfbHkzvwMO22BWm/teu0kTndxNfENv57ZlbQhH6s7NEnEqfUySHqo8O?=
 =?us-ascii?Q?BPy5+WkLjsfMygC6xYuIW2+tcwX2MyfpGaTEhfE1c2zXYukRCTgLCmeyK9GN?=
 =?us-ascii?Q?KkgpiBW/DE6YqQLa0PuL3jGsJa7kuHLy+66BCMpDO1123esNK5PPLqEXVqPG?=
 =?us-ascii?Q?LgHutOD7MKpNabjqWmQnTN9Nbyp/RE/js2FQItFnIQ519I4X/isp?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c8e4f4-7bd4-43c2-5788-08df170ed8dc
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:01:04.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfkPV16NWHYqSrIX6R2dcK8mKPI5xV86WrWirDZqlF8pDhiz3SYJuaGyXKac0ZH8TClW9fnv52SG8qaUxuS1dSRzYPwX6eJUa9f8I+oY2XmbUD7m32SHuxMZ/0wtyS8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

Expand the storage of clock parent index for per0 domain, which parent
index over 255. So change u8 to u16.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index fd9d13735896..f80bd51b391d 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -27,7 +27,7 @@ struct starfive_clk_data {
 	const char *name;
 	unsigned long flags;
 	u32 max;
-	u8 parents[4];
+	u16 parents[4];
 };
 
 #define STARFIVE_GATE(_idx, _name, _flags, _parent)				\
-- 
2.25.1

