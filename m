Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2128.outbound.protection.partner.outlook.cn [139.219.146.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84924756B6;
	Fri,  7 Aug 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102279; cv=fail; b=iuRWNfOoHvy9f6lXHls22BqAAYBMFCRtZaZ7xGX6o8o9pAMSs66uIBlxmd5zGMLO0PdgfahtOzvcWDOGPDVZe22NXGjBgaFNgtsuJGcH4IQG8XOCCkgD7MHjeqRgdkIl+IWLiMKypKf8R+EJNRhXFw3sIDCXQrYIvMqzdGE1auI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102279; c=relaxed/simple;
	bh=ENxHSfnp2iSiyM3iWMp7gkA0G4vX8D1VKcph3htpNpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nBO7mJJKXLvy6+u6pu7WchjT5/m7ztfOSxgvoE6imgpLU5pXx1gwQDIFIGwjx/AR6r4NE01xU31bKRtGApqSHAg/XJ3GFLIspSbDY9INLn/qYTwBOJ23TgVri8viFYgYHw1EmdxMxlDNsXwIB06+LHH/bZaWsVS+7yviQBBht0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irUz3REy19w6eb8yHlVzTuA+YZG697c2dooT9I9Cm2PW8jkXcEnyzZNI3iJLRq1mM5wjYPBuhuxF3Cg5k1h7RqLA7pjWB/jRZrj5h0UN8HVsJHkJ6QetYY9WtGbjAjCb5gkSRcTM4qwYJYw1TmOT0jh6D7IqKEIci2RpRAK/klrIiRqlAThRwQyoiCJXBNGLw/pUCimxrf7Qg2JXC0P7Y4cTkjaK90Lle8mcI8x1mGstn4t//sY5KuGVPW89ODxNbvIHnsTfLcsd+p6D+ZWLQ03HYM3uHDre0ITwHMsv7dlqpacS3LO7fEyTUrWTN/mBTHpckjraeCM5A0KBcIoSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm9Mjctz1llf+1VzDqmz4C2LunCIJFzGMPGGh5hV75k=;
 b=XEn+aRyEJ1KZulu/QXDAn+1VDlKG/vYZymTstSU1BUI+tCVtnQN2z8xc2zqjDD7ZJqgjd4YAgGMrnRtVuC+UnbCwzVk3+bCj9mdfzDuAwA/fwDuWBBfewR5qYMzfGjkxP7vsUHVaKJw5nUthk+IqwAyb92aqV2akddqqDU/AxgCw16W8GTghjmp2kA3RA0v/KpJR9gw7lcssAGpS0vXGmhgteCi7LwyzzRKrbQAt9+z2+wDuA6qYWtK3PzJ2nmAVGbyKC6yvwKbJuUKBPsk/FWW8duBiL1xWgUsXVOF9jpMISu3Jdjq+iG+6SaQUIOXhtJLLvF6FCq5yjp+vAqV4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1315.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:29:53 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0292.022; Fri, 7 Aug 2026 11:29:53 +0000
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
Subject: [PATCH v3 13/22] clk: starfive: Expand the storage of clock parent index
Date: Fri,  7 Aug 2026 04:29:14 -0700
Message-Id: <20260807112923.191627-14-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3db674ef-89ab-481a-1cce-08def477332f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|921020|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SOJQCxlKZygROePOv8Oz5iWpi41HN/6g/hzA2gnkL6MP609qKFUgrBVxohL9XLi+JoCMNQjtovM/t73dPSSLbx7llRIjxSnptixUBW20pwHaDbNCAXbXPUayTJ6SUJWqTFfb5GIT1uJgPhwSzx4bRWjB41Liu6YLJwX32nD5a/euu/BG8eq4N+M7SYJrwAbuwHhjFJ2jhWuR4b0S95ZV1xkBXOwZiB8BwV7PY17u9+dRedf0vuAjreUO6igHyJ6+YAA7mEO8HvVehhjv8PAW9kLfQvN/9CgPadRiFUAkTRd4Cm2lpCstEpsZq+HyUjNTtLv8BI5DBl5P1dWO+JXtzipX747cu6CmYC3bOpsWET39iicHb6CaRyejzarQVTHpZQEZ2ksPedGY+YsPrVYRmcwgHbmla+FU3b7rNqtxN1C1HtA0GRU15oTKDRzWlV+70r6az0S+lB1zc1fAPBGCJ7dVKrsSgVWZaBBeX5BdCFrJNO82FQAdG4uGfSHxDinkA11lGn2FXizKhPv19a1Sw6GhKofclYpvCBCNR5bAoKF+hVKZHN2/4HQ3mM65n3YmmUXrT62oEzHhznt7S5ayrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9YtS7ZT6bzQ7FHtI/ncxbdgha9si+B6lcKA/ShRyCrD+clrytW+flpEcgSYK?=
 =?us-ascii?Q?wj/11kggkXoJ+UQtHAjuOcMxln7RQ/zUgV/sN8g7l87MS9Xz1ju1G1btcG3F?=
 =?us-ascii?Q?QWvvta1RB7artTmj14WXn2YAxNehgvWThpMnFipCLvtOIORyZ2lnr9HdLOET?=
 =?us-ascii?Q?Lj5prpkRZWSI+uedJtLcC/CiFvLfRvvMX0l1PCwL0NvqHBF0B+Z+qMmikXTf?=
 =?us-ascii?Q?tCcAjC7Q640F5sDNnHjHwNZDfAoxQ38T/x2XhrwdoIGGKnm+58NVCFM+hNMT?=
 =?us-ascii?Q?kfZ1CcNXnRKQuOgflhlLLXSJ+5hHHW9OSJaGo9j5L3i54WfBCYgKNDbq5rPF?=
 =?us-ascii?Q?k4shHBZQQ/4X6Q32MDYJ5nvRXnxwAg08RuWPmtYxodOdIrLTQh3BxN95q2rh?=
 =?us-ascii?Q?IlLGUl078p6ofJa6F2exrlLcmw1FHNxA2Dz8Zk/t+BArAzjgOX9CZSHsnLph?=
 =?us-ascii?Q?yuFxIqzvrY/U0bcqHzIDhQW8UDW8ALIby+jQVZ5xzTsorNafH5TcGTK0/wmC?=
 =?us-ascii?Q?nlyK1eleCyv2iCZwli0PjGu5/6Zn0bldlP76x3gtt1DdwIiT4L4xJFZyEt4/?=
 =?us-ascii?Q?AXiMwacNVBtX275X3N+AV9583DFr6iRsUnXlj7MutyQYuu5DLx8WwIxeVB4u?=
 =?us-ascii?Q?1kCXEkHFB5cn8GdMyUd4oqU4s/nuPsOkot1AsEZUlnBwvokQ8U8kzlRM05KU?=
 =?us-ascii?Q?Nlw88foqDlfinugNvUV2gz1IOfHS5mqdWHBk9ZsyWLOPa3Bmp3zX5xV8wZPD?=
 =?us-ascii?Q?d/y4x6M0Vv/VB0P1Fa1ZQA4UBnDVleXYBljYak2xUsuXtswL3Q8p28JDOakq?=
 =?us-ascii?Q?MbaquMeeZ1vF+MEtOIQ/KdLG3TlCtVhdE2BdwW7RS1RilRVYw7l10gLthGjA?=
 =?us-ascii?Q?g3TbQgDR3wTS9iNeCWnQiIHpMjIV44caSEAVXLRvJjbeGKA37H8oilmzZX4g?=
 =?us-ascii?Q?NowsTXAfFOQ8UQsIGBLkHlUNihxpjJOF4lhmZzLoeuMmTW5iA3ZOTgZ23Np4?=
 =?us-ascii?Q?FvlIiOK3nju4oFC1NCJDfKYaxE/inkZPxrd5geBM7IOtxwRRF/ksdfAO9Y3D?=
 =?us-ascii?Q?7al9ZHhd1VQYo3G3LNikk1RkDueWTTzp5uWkz5eoI0CNbNec/DtddNT9d11V?=
 =?us-ascii?Q?ZL/Y29vyP5N9b83bffRlF0bySGfpXxS57pO8DwGYo2oEvcHeP4pTAQBBTI34?=
 =?us-ascii?Q?SiyUpzvbZyTEU3r+l4/J0EsXtal2iJawNGnNpbx4royS/cqnaVFhBY9rC8v6?=
 =?us-ascii?Q?Fq6O+JzaEAEt0SjJK5VvsmBqxc+2gMpIb2ofbdXJ9jSpYEiuj4A5l/Gkkj7z?=
 =?us-ascii?Q?xWIHjVfNgKHs6ifDLdrs1RnmOcYzmkvANxyveBOEbjw//b926HgipJ3XWdYb?=
 =?us-ascii?Q?C5Dg5LK9nJW7NlZKQHa4YT0gAuql86nyJCuWX8PI540aTJDDJUwErr5zqC4a?=
 =?us-ascii?Q?pObWCBMAW+lsKHY/o5UmA4QucF9vsd4ugMv5TTdQmv6+oZBSDzp7SaKBEC+n?=
 =?us-ascii?Q?oJdlumBWuMYOn3cJgG2bczwCS3E2jodwuqAB/l8yWadILPbbzQE5wgZpkPN8?=
 =?us-ascii?Q?plGOS2RNYw31BBP+S+qzPLaMCpifHQ7uFKv61VH/f48Jahu5l2vlby6HYKe4?=
 =?us-ascii?Q?7mGHvG5BnPiDgYim3Xucl/ZSs3+b4tt8H2dXp7aAFjWeXGTpCyWQTQ1cg4JB?=
 =?us-ascii?Q?RVc3Wd3xuuKqDQh/NXSfEGQIEO03NiQ1Y/8ZuQ5J/4Vcz0zvd/FRiCOx83iW?=
 =?us-ascii?Q?qnYF58puqXgiIZS2RJFRA+fRIL9jPO5Mqr/zSypjDqtBuE+XQR5k?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db674ef-89ab-481a-1cce-08def477332f
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:29:53.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFzfgJmg8rKjWsiJh3pSPDEVw6Mn0qi1Covw0wkI/G+i84rvmjNUcg/b4G8adDQYumHBi4CddOTb52CLUP493PQ97Iq/8Skd39andIRVUBV7KCD8kzw9jpRexKGLXjUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1315

Expand the storage of clock parent index for per0 domain, which parent
index over 255. So change u8 to u16.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
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

