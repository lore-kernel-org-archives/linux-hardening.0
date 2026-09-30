Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2090.outbound.protection.partner.outlook.cn [139.219.146.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC744E50A1;
	Wed, 30 Sep 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774184; cv=fail; b=ScKhs1qmE2nT8k8TjpZaZuKc2UzACdNEwefGuZ2GkcX7DqqzN0y7bcerK+kiTLf8YuFizsWsrxLabSJaUu2qveRya5PL7yu4oe6Zr2NNIJNJI+kGVuwrfe3kFmIqohWHeoDk+wSZzl91MEMxCs+SlYBskmt6GweHzppGvfBqNSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774184; c=relaxed/simple;
	bh=C6k3sJ8jb0lFA0XjIMeSm74qfWQB+xpQABSfq9l7SJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TjzIcIfFx1jinTgPplkRIEoDHGnJ067woSwBndnaruvhCB2VimVC09+ZFDuI0GP8MvxF9IE2X9tLUcNOjL2/N84H7lg9L+pwq9CuV6o5XEMx4m0HtE9a6DibFm4MGTKNrIjwG4ydNYTB2HosfjiXL238bBjwYxnS6FuZd+pWIdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFOJcejzJ47VH7CS/KJsvDQbuEacFh1GNWAoeVQ74nEjjEBE6+rM37WIro/vHtKge8k/n27Qqz366kp3pJ0KnWTviuHauH1oJaxkNox/wxxjfn5RVTsBKBfwi6C9/ycSYLU97L9z4HrBn35Y5UCBeFwfffYs2JXlJPEx4M1n/cjqMgu6US1xIHPUdGwC3+yr+aJf3oT00mIVZbHQuiVZpOF/ASF/bzYbkky8KuAC4FfbG4z+VifZCwLdeB/cpfhl2GcyF6P5xhQM7U8w/J7Uy97VpvOynlvqTTaY7VpP2INwelb/iB1xfYpR8FFkv350ob1k55GMuYbEbEiKci6hsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFQBehvpGkg6Ibwftzvq/hAGZuFGKCLctIg4/y1brHg=;
 b=SyDuUTXpaw39HBV2UuQYRZEt/7crTD3Am9oDxks0PaYVjU8meH06oImcD0J3PrVR9SZV88iHI/wmn/vh4AJAaAtMeWx/mE9LbMW9McmLH+SG098Tua8rmOS1UfBIuogDcGo2eomgUun9DnJm+Jbma/hRN+N6Veq5PlEZsrnDjx1XrCODRruORS8IpHcA0crqs4ywu/QC03VtcQyjdZFjtlHqwGkYToGIpZ2e/04Lib23T6tZxZOCqLzSyulbY++TQd327/QfyqCNKXz6EyD2i1rDuVE9j2FEH4jZiWRNERvHMRPpF8HW1KZXbQCT7LBpE2PeDPqzmr3z7ixcn7AQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1297.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:43:33 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 12:43:33 +0000
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
Subject: [PATCH v5 01/23] clk: starfive: jh7110-sys: Fix memory leak in reset controller register
Date: Wed, 30 Sep 2026 05:42:55 -0700
Message-Id: <20260930124317.5648-2-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ca92cfc-2e18-4301-f611-08df1ef07030
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|52116014|10067099003|56012099006|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	/WCwRoNKBgO7Ah8XjSqyqpsO932cGdfc/Rs+0xp4eMCSl8aQXBji32q8Ad+z3LLP2d8axc1agtPf95vUu+HeJFyVLrAuJxpFZyR/zThAz9ofE05PRTQt6pXwaHFzO2xLO6R12SRq6CMZxImhgLRxaex7E7V/YEqYiED1vT1Kaz5ULdiMsK2TbiTSOPQZiksBM2OLPMoLHpqnaZYtiDubTNLJmzuZTbJfQyfTx9/qUi+DlmwfJSgzJGMvjfG3Tz0TL/gKaOy6mi5UZzmm+k2n0aAJbKZJrjfhFT1K0rchjJrXcsEzEYBE3Xsiw2zGCECrJ0JUQRtOF32Wo9QeiQUIiF+nPQVMb7JmnSDrzPB5fw74MERDNxuv/3FtjBr+BgqnsSsuKsvDudkogty6zRtcUjDI0V9x9vc5i4rAkvFx5nUeMA3c3b5zGSGXImbh9wDQ9Ang2g1xKxy8SXAgExlMq5k8A4H23tJ6oqFq0Geue3zM9cWTQsP0RisxpXj9wvT0G5YSp6oNwn+kpLo7X8iupMeSOPDb+328wEsqIAiw64MRQLT0uvsQEQacq/m9iET6ukqE7UuEEETGwtD+htQCvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WbLYHWzopzew/RsefVGW7saaVQlGXAzKwbPdc+peGsvLJE0dM/8ilMrqL/Rd?=
 =?us-ascii?Q?yNVMRFWJwlddPaDSC1g/oHY9sbAzSXDExr4+Du+z2q7G5Ytd2aE3XP+lN8lv?=
 =?us-ascii?Q?9qlCf2geS/mCZgB3bbIabdpi2OH7ER8H8M/JSlXN9aFYY+2gTDj+jUbGi5Jv?=
 =?us-ascii?Q?eOdGLvuNoGRsqtxemRJkSD9pdZufZOQI8tD65cLFOJuuUTMEuREt/1SAh2UH?=
 =?us-ascii?Q?PYIUaONVJDeXKZbY5ItO7FQ6HYJzgDHHv/IPO4C7Rf+SJAwk0To+mSCbtdqG?=
 =?us-ascii?Q?IPb1iJf4/GovMPo1BRi/hKTIXUdFlFFCyGhzcksBeaAvUB7qt4AmoIhipY3W?=
 =?us-ascii?Q?Z1Crot5zVweOEwlXbAaRAuD1Ci8VFjWE6xDYMkefGMrAYFtLhKhl0xAmzgDB?=
 =?us-ascii?Q?jVvOO8BncIBBSo3x5VWi+DHUQO54XdfB40/QXe2Jd0YVp8dG+K5CmGcGsRag?=
 =?us-ascii?Q?1OCIaGgvQCoWIagsCoDJmeJWuYrtEB9AE6InUkmV3nTo37GVEgT5yHpDMKCF?=
 =?us-ascii?Q?RAl9S9HFtOIFhePomS0e7G6IzVab5TZ+fmiQt8Iq5PeiBPzW1QcN3rPNOHnL?=
 =?us-ascii?Q?EvCH6qRw7vzSiRQXBonsHHR8MLxEpS+G69Vb7aoRfDp7T1LHeplpyOWXh5jn?=
 =?us-ascii?Q?0/7wi7+kI/QIx0A+at3hw2eKccsmwfTqPzvnZuPV7g209B6GAYWFzjh1hJUa?=
 =?us-ascii?Q?2z5jzPXs2nMAIEu6qtxCFR8dfInsA9gh8HrrZGCPCMVenZJNZgUUWEHPBWtq?=
 =?us-ascii?Q?WKNfvEQlVW4N8fYd5ktOGpNY8MTncE3HQTpxdZyPozwTzn93uyLJr1/jXZhG?=
 =?us-ascii?Q?8+j6khw0grJnJ8VxNjIHswp4W2rsJFAJvzMXNIpgBYx8QgzvXZ9TkdNnXc3N?=
 =?us-ascii?Q?OqnTBn3PEGLcVG5FS6UXguBKGjAAOkFx+P2L9o2XtPBxa9K2UPnCWq6x1c8/?=
 =?us-ascii?Q?GMluR3OsAyuW8uJi+a44vMkCWUki2zaCwNnWwwWZEsOtX5v7LSinNlGIfMRf?=
 =?us-ascii?Q?c4UdDWZL4D2Kci47kPxR0xmouYPaCycLx337+RYwaZwvKdsCt9TjQFOzhJFP?=
 =?us-ascii?Q?IJBlWyT0g/bcNh1BLsIjACG1vtXPPgHQNpz6C8Lr3pieDQM89qEsyOwOxD0o?=
 =?us-ascii?Q?wk0rVzbFlbEWP1yUlSNtmqwQ97h1sujZ4clqa+eWeKmP8NUo5qHs/c/OigFn?=
 =?us-ascii?Q?2bkwk8zV1iaSZ2BUboaeDYm0It/0rDDCG0lwe0E5pZzL1WwzZ4ug7vyF/yC/?=
 =?us-ascii?Q?QHgVmGAqa1IYam16xxkSH3Ft5VwWQE/SzjKDbQX1gt7DgB10FhlVDfiOd21K?=
 =?us-ascii?Q?d21a7vHcPntcPq2Ku0je50ITg18tdylID6NIpivs43aoCkwmQsE77jqzvYX0?=
 =?us-ascii?Q?fvVCWsOpGD5VIxtfJm1o0/Th1PlGsCXLyUdHAeUowJGYre8Wkjb0N9/zPlnf?=
 =?us-ascii?Q?L/0py5TqrjqbO+GepqdNKHjS1uhx1qC+IkNWsFX5tQZ0dUbmDg1Gen3mH9/r?=
 =?us-ascii?Q?fOT+duQN3ZB2Ssxc5G7weaLXFlDl5VTIACt8bULsSJxDklBswhH2jgrGRe0v?=
 =?us-ascii?Q?x0XshBXUuWRK6meSzJt0M1Mt3vtdJ3TywzQYN1QO4JSI2qkVzkRjqQXdNVOT?=
 =?us-ascii?Q?PU1j7V85kL14NycjmNJ8pusiJVt3o2Lxci/UfU8rWjRbcO2vvy3fn18vm8+u?=
 =?us-ascii?Q?NYbjDROw0YQ++Lus76IGvER6OM5Hex3daUPBA4YfmCxx44k4RRFJyX4dSiyD?=
 =?us-ascii?Q?MXKvfo/fZd0CmJThdTe66Jt8E05ts1Ha83yCLUnHXkRAmtKCarVU?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca92cfc-2e18-4301-f611-08df1ef07030
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:43:33.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2hjYKD4wV5M6xLSkwDvLUTUlpROXigEfOnFL3fFXmiXU42Xg3vpMLtPo/NG0dbZNB5wzb9c/1drkkpMf8Qlp3gHGQtCvDWJihPFTxFfu12eOM3KNTUzzAlINu8wo/dB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1297

auxiliary_device_init() returns an error before device_initialize() is
called, so the release callback never runs on this path and the rdev
allocated in jh7110_reset_controller_register() is leaked.

Free rdev when auxiliary_device_init() fails.

Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-jh7110-sys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 847c0a39e5ab..1d460a03f936 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -360,8 +360,10 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 	adev->id = adev_id;
 
 	ret = auxiliary_device_init(adev);
-	if (ret)
+	if (ret) {
+		kfree(rdev);
 		return ret;
+	}
 
 	ret = auxiliary_device_add(adev);
 	if (ret) {
-- 
2.25.1

