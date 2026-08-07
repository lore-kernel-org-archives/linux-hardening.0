Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DDB476683;
	Fri,  7 Aug 2026 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102280; cv=fail; b=rQmsSZpfTP9fOucjttlc5QjpyDYefMGGlVQjN2YHKRLj/IM8WYcd/p4R+SBwH1MI98TDshXsPcWNDHGJDe0t63KOiz/Vma2Klr5bkwZ5pItXEKdMuPRLPOq+q/06UVI3eYELkSOMdaMPc7DcIbrA/TdI7ZGGSTxwPOwnvThiv04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102280; c=relaxed/simple;
	bh=i7Nym4jVnjlpbLSVIawoqKVzpCvCq5oQXD94hYnHwc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0sKn1+iNcquGuGAkHxWQuSA0Xwx37Xq5iIqa84/rBX21gON1m6UoNevIc+GuobIPtJtK4vl5uqcrvUdKiixTy6uPIDJsR5injvJFYHJH2YfLr+oyinRIt/mxFqTvFDHhr0wzlvODEYR333Mp3+3VNPnjH+46hM46njnhq+jEwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieUZtHWpFGADUEzO/w79iBiY3CghbPf7ZRiPX0zpmRqFv1ynvD/hfkz+VfAsjMhELxKXzpvKBM0c34mN4peeg2jr+anIyysadRPZKQtSuSYhX8d8UuWULDHvPkXCwWmK+PwqyYDlsvOwere3/z9n0vcSDQRoGJLPy9i9K10moBkeDF8kc7lTAQHZxXiGfmmjPLtGOFEbRci/7Jnoo+jk/jkHbl753oIY+MjU5YlD+TZlyrxlBEw9fYZQJN6im1ssv72JNbGJIPJTEv7oKTKrz7R9VyAcCjqpLmT+zGbMOAH7ga+hOY6Uw4shOtw5yeTDLxr5z5PrShRHhATGKNhYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/Nr/UWteIcIpybo96g/qHqf+w8v8gCiBVDohHToybU=;
 b=mOXaz7UIM0lAbgaDhYrLAlOfppVEHniiKYptTkPoOhNABoyYwBTdVE3TgXQlKcsVlyCdt9MYvBEOTuAPZKyrGuZc5g7Axueteard1puy3kUoRqmn7NUXPqRv5kF9IWeWouw1CH3h+yTnQgvsI9Au++vPSrF3oE8ZOynYgN6XIZnUSqoa67pG1x0/ZSJE4hEW5ilwETkdBGeGkMCq5FCJMudc/OoxDv7zKxjCAAezcg/fUQDjYiMQ1XChnfyFctywlhKwAXYqq0r1BGRsxw5rBycteMOsbtHiaWEN5xicEYtVFK7rcC11SOuuuvjpq0xlu+a7k8V9pTblO7k1ANZnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:51 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:51 +0000
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
Subject: [PATCH v3 12/22] clk: starfive: Introduce inverter and divider
Date: Fri,  7 Aug 2026 04:29:13 -0700
Message-Id: <20260807112923.191627-13-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: aad9e3a7-4be3-4d0f-21c0-08def4773239
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wm8KPY6bVjUoUucwKnHuKG5OiIBgQ9jZqQf2itMgUhsVLB8WbEArXKmpmf5Fhj/8l2MHbrHQ6fHAyOzQM7WeZ0LBxZMlBm7Adgg/Dt5cgZ2RTNjGUSFaQVs+xsMupIemeSM0TGtrzrAZqJgLZbv/r0Obf+IYJ+B/cgJGvghgSHRzOfymJbvOe1nU7DD2pHWByl7kBZ46rfi7RZPYg4NGgjcxAim81QbDP9czSCUsFFdbwNw1Ghh3inpF3uV5C8W1j06e55q84GMJlNP7mN0u5PNPDuOAzAZBPfR96ZLRsP9+7e/Kslpd9tj2SqjAISUapUOLgubQnH/9eFVrXGTa4+RhuKtufBMObFRqI1YqMiDdSB1zp0UsJ+Fzahr3hO9JOWtl93rlIbRZBIeQJaPs715ACL5IEqJS+qzxDZxMsweONXjSwpsOR124hbbqLjfqlHJ1NDKmWkEASNcd16pyiVOgL0glIiURYoYLVi81xxjfVsQskd19WqMoGAQvCeczkON0xfBaMb3bn7x6Eug2qMzpaiXeOPdXjTyxgvJkSv+cluL5nIHq0yEJsMB6dE2h9TyA1fFpmEzQhNEWJufV4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yASeN1uUqyrDd45DX7ydbwrdNRikPQMjJfdC4Z7V4SRwjA6DE6tgS2IAHHnO?=
 =?us-ascii?Q?DSd3216Rr8SbfVwtbtCgOj1Xhd8lDzfk4UqUPYVXRIfRr15jzvd+n84hW8yz?=
 =?us-ascii?Q?cK9oSFrGJfjj76Ym42KXCT7eT83kU60eLX3F3rrYJAYFxQNktwf7yr6fkwid?=
 =?us-ascii?Q?cVwVYX6hRlOgGLLj/JykZF3+2cE8sd2Fl2r4LJ2R0jDvfyyq/0kws+xJPemJ?=
 =?us-ascii?Q?FhkHqTvTazqV2U5zLArao87dJ+ytCVRBmRsrzYlxK12RfcpC+2v5953r0+x3?=
 =?us-ascii?Q?b/FBaIyy1D9PlWJpa+rbbewGcjCuy72S+DtXv6FtEg0/Lfc271kVum3Ise27?=
 =?us-ascii?Q?I859+KDyu3zvuHdphhwLkDYf53fqXYHKanitnjJ/kqO7R/3/twsl5eB50Uai?=
 =?us-ascii?Q?tWjNkeSrXaPiY6YELTisK0GJtabRrGTj96WfcCJdJwyP9j1dRQ+/q1cfy9x4?=
 =?us-ascii?Q?0kRyClEraljtqEAgyK2hmyYxQllFOsCrWrbdFZ2uzbSp0QFTSTrCD4rYg7H7?=
 =?us-ascii?Q?mNlJuLQspTTxbyLjBKh8n5ybHIJ+Rb7X+Z1S88x2XEfcY7LiycbNsyxu1Som?=
 =?us-ascii?Q?Nc40lFIlHLPJB6Zfz3RgmGy/6bo6w6a0pWvjSEshRrAEAmtiMUDjGqqQe/wE?=
 =?us-ascii?Q?SzhP9Iddke+yr/bMd13QY0F/6ZFd8vticybkVWrWSiiTOxAZ1YL3VJLfsvTF?=
 =?us-ascii?Q?uU87d7V29xtiLEKpS/V1ICPM7N3GlQ1UDxU1hd698SeGXhyfJJpNgTZsLQ29?=
 =?us-ascii?Q?NGBOMOK+Y71/ILHjKrvn77bwJPcwBH6CxvtU1ULndh+uydSlerQ2D1hm+vEt?=
 =?us-ascii?Q?w6OQdw4+f1dgycQreQqTz/oiq2OiRRpJ7wgbmj6zj4utNsV+VNGZ/lPCXET9?=
 =?us-ascii?Q?HPfUXOOlLFFgPs6EpvmCNd6QooRgwMjBRkeocGnlaasNrMNbPnC7Oqv0iTWU?=
 =?us-ascii?Q?an7/6Xs+w/MCGsfX+IEy6w8kMLxDEGqDCA+uFR/YuPUlk4txXOJi7C9+9asT?=
 =?us-ascii?Q?Le3Xwb2RrfYpF2or4kNrr19+V8gea9pg7mbpXUeM1TLgc/+ShlFWKJLsmCL2?=
 =?us-ascii?Q?olYRc++RBpqwHr07KYfK3FspW1+HfDnw/aMEOritBpfHBfvqIGja+onIOSJi?=
 =?us-ascii?Q?0vlBqaRPEjsfOHMSc58meOVSQbbQ93sCG5zXTX8Faigf4qtGvDsgggVpqlUe?=
 =?us-ascii?Q?f+0ZUdTFIHzAplObVXyfWGvr/MlUZbleCKimMQRUwbKcXL0xRR9Cld12MgmI?=
 =?us-ascii?Q?3girWsNic+Bc5AnSFr4rDFj2fyRwmaDa9bWli+dEXGBcZnpYNGzOXLhEhJxK?=
 =?us-ascii?Q?68I/JltZcgQpiaEadBAQYZyEdfpc4EWnAgm6Z1KkuJpKjQd7B54wxcdO5MYq?=
 =?us-ascii?Q?TFAH1VrQ7iVZi1HLESrK9DNlpX4knKiAcs1CBAHxMfQ0K5hE0g4XJhFh89tf?=
 =?us-ascii?Q?mng/pJnsUW1uc1gpXOzAnjyo4N29pu+EfAhdmcIXeead/+UqDmw2omd0FJm9?=
 =?us-ascii?Q?yp9D8xHJZHOdM4qR8A8Tw9Sl0a1X4n+EYVoM/YXYm4YSsJtBfybXGPYwBspk?=
 =?us-ascii?Q?+hqFe8sU4ncV+1NxR9GTjegdfR3msz0cfXaOoUF/hq9NE4fHqLKMQJwIekZw?=
 =?us-ascii?Q?p8oxKDeysH1bClQaJL3euD8s/k8xDnI8sz7Q2ZEbOC9o7Sb+pr9AUWIYGZJn?=
 =?us-ascii?Q?9IKnD8WYGo+0hZwYVTZhvqsCykySALZsvBjT2EtnciG8/7Q62Kfy94DWMRpZ?=
 =?us-ascii?Q?fQo9PWMh2RxvjzQlCOklvPQQ6dlmhRlv8wrsfQRA9fIQa4KoU232?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad9e3a7-4be3-4d0f-21c0-08def4773239
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:51.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnlnYitjvnhl8AkomuICEqgRU/suJzgBVgC2c8aiORJgLltIxH2+YvIRD7lBNZ6uxSeXz3ZthyqT9TcXutsiKlYKBnO0K/4EpPa9n2WNvkgTUP4gTXctfl+5sXSx/ttB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

Introduce inverter and divider for starfive clocks.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-common.c | 12 ++++++++++++
 drivers/clk/starfive/clk-starfive-common.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/starfive/clk-starfive-common.c b/drivers/clk/starfive/clk-starfive-common.c
index 1b5e56af4138..58ab93d9748b 100644
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

