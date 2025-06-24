Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D228D8FA;
	Tue, 24 Jun 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763105; cv=fail; b=IbBkzyjhnseGre8FWByYh42CVvbgCMf9vT+hIRb4MKsUrm6b9+4WU7ULzHKHu0UxAW4g5I4zyMMpbMz/PGEyT42KQT2jUomlotncqlTa+f0COURuSZ6WzALlaTVwAgwDqq11HljAFAR0P85cL0TKQP4dKl/PZGPv3d3dc7R7YAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763105; c=relaxed/simple;
	bh=/hw0Z73A6tAzj/8+8TqFYFyUJGvnZkxoHBQ8EtmXyBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GjW6BZfv4a6PqOmlGv158LjpDtPcejVspSjgmqfNVP33lLqycMrW6QOokltvinFurzInn3Qse3BlUNvkGpTDGjrREuLu1LCwLFcxfnUl9giIKt5H4uhY9hmbX0lLck1nr20iZxY7Ws1qTK/hXFmV7C4hkErC/zqf6SqtmnKfRGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=JzexgJkf; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="JzexgJkf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWQhdFK+EbKqVNwsnpX8RmkcsR8BWu7Hzg1+4DODJhHKxnsNqb1x8lcLSw87z3iLBIckY4EBD5SAz1AfZgLPOBbhfvroL/AQHrTYycMpyNBVI5u+o0JcYeAwt8LylKPGk+ErnwdAF/u4KGjyMCl6xkVucRJzw19ImRCctv0ri1FJIStAOOMiFpwmCibCPiIJt+JEDYmPkHKmR4Sg7UzpyZWy99AenkYD9eDVz6YiHuTY/Z0f+gTER8hMZdpWYXCopJnsTU4sS5uSSeO9aIt2NzfCoGF6KykyjOpJfRQxKJ3PTCHvaPHC3ea2TLQ9sRZCQ07sqJI2s0RLbHce7XutxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv4edHflx6yroY1WPxyeRixNHJivyK5HvXMOw3AVR7s=;
 b=hg0hqMQlBy8SE6byVJxnAUpniBUypPQTccnNQ/lOE9PKD+T1iNeMR7+RS0XdVRgml0+58ofSBjrOP1als5gYV9xk8aZVFUiXkvkauR2i+H6hgU3iRYXTEelLQ137a1vIYiZcI77qieL00dd819O2QaOvPq190BDWFkjb/6fdaQcUDOLH/wqxh5ksCGX/BsAQY55phRvnk5+vReRaCfNQ2UJN9VcDF6tZTL/Wnt5hwJSYynUD1EM0P+dP/5GtBAzOXlj4CYsUaYeMiw2YRe/Pi28QjpjHaNajhNlCyCRCvjXHBKMpM7lmCWpWrF7p/3bBAl30am5YzcGQRPNr6d6GRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv4edHflx6yroY1WPxyeRixNHJivyK5HvXMOw3AVR7s=;
 b=JzexgJkf1m/7JpZwemHtcbstM39d/IXnaeLmP1oOLoL9nz2qis7YQ+e70lrZSo2f1uXLU2Upk/FdEvFXwY9m2/GKEu6ksd1b9saIcfoiGxlLg0nnUxL/Q+sFrESSQwXImiQxGqAlNK/4pcSbIh8iqw7xU6Kd3PMQDFmwDqM6Uq1C8LJ346RRKfffPm+RyGmTniRXK1WFQ4QBn8QXBxnE94L5zB3OewPyy5rOZdd0eHmZ48kBdkMXypPL+lEUl1Ack468ON408gJtv/507QMlSH8QJIlwmidSkHb6ThJ1mnMLaEuj+F3ERQYKPiMZfkO9nakscaAGCX1cvh+L7USaZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com (2603:10a6:803:66::33)
 by GV1PR03MB10728.eurprd03.prod.outlook.com (2603:10a6:150:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 11:04:55 +0000
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265]) by VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265%5]) with mapi id 15.20.8857.016; Tue, 24 Jun 2025
 11:04:55 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wojciech Dubowik <wojciech.dubowik@mt.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Markus Niebel <Markus.Niebel@tq-group.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Michael Walle <mwalle@kernel.org>,
	Heiko Schocher <hs@denx.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Tim Harvey <tharvey@gateworks.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Andre Przywara <andre.przywara@arm.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Kever Yang <kever.yang@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 4/4] MAINTAINERS: Add entry for METTLER TOLEDO BOARD SUPPORT
Date: Tue, 24 Jun 2025 13:04:02 +0200
Message-ID: <20250624110408.128283-5-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250624110408.128283-1-Wojciech.Dubowik@mt.com>
References: <20250624110408.128283-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0199.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::21) To VI1PR03MB3856.eurprd03.prod.outlook.com
 (2603:10a6:803:66::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB3856:EE_|GV1PR03MB10728:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d39370-f871-4efe-2bd6-08ddb30ef353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+Zyab7EFt0fDOO4WRXBRSCqdCdpeF5efu95k7FNPdqQmN5JobLy9ACgtlIA?=
 =?us-ascii?Q?fqUl2VQNREwInp/L9hDtaBZN7bjrL4EhuGj5GfF1HKoDMoyA35fLkgpOIIF6?=
 =?us-ascii?Q?jGFmlcfR3blEtNNvWN1AtYg1cpkzf6okhzOA0xRuae0ejdvDq2HeMfpEYFPw?=
 =?us-ascii?Q?F/o05SWCIWiF6BF+gYw74CvEPCmO+aXbu01REeFaos1HNA2j+0zMRzDqVt7X?=
 =?us-ascii?Q?qHz/BqEQvbN4jOfMn/lx0s2C8fzF9Av6BbYX13C+GVAdftJLWKaKufUFFb2t?=
 =?us-ascii?Q?tT1jmbvq4GQXp3HnxvzGbEfWjna/tDoBPsr2QZxPeTjaUUjZ1V+E2lSOWWqV?=
 =?us-ascii?Q?In91jXGi5eFUYMo5C19WI/wEFKhLeLf8fCm16N2KJcLylnSxoa9yeOEGfdjF?=
 =?us-ascii?Q?Dzqj+ihvKiZgnS1RL73TYczX2Y+rPD9UfuKywFmI6FowG1mlMPLNVYVqLmwQ?=
 =?us-ascii?Q?CO14W1ltqwNpMwci9z9KiZqRPdKeQAEUeAGGhGUX9NJqoC4kgMTAvGTzsfGq?=
 =?us-ascii?Q?I0PUoXR0ur5JutSZ3p08muI79us34k7m6FZR6JnT6ZKLgl4NPOlPiB1fDn2+?=
 =?us-ascii?Q?Yw3zFAudhfefM+qd40aY3vyPnBEHub+NPxdbyFGSkLK67ToyVzOCcWgI9JWd?=
 =?us-ascii?Q?9Lm4DpCFkHvonVux/3hNjbI/VzGTvkkkZhcCD6pWj39qFa1giyoDX3FlP9+m?=
 =?us-ascii?Q?/aPJrNCG1xjjjDUK22fcS0XyGTuRGUISNgFPKTrzdiqap/DjZLts3kA5ufzU?=
 =?us-ascii?Q?euVMJ7UoAKGe9+CdBhLiKmeB0XJd/Apb/OKDip7hrNbGdVBk5j8AOrtXXD6C?=
 =?us-ascii?Q?Jih+m7kDqU107C268k0GSnaa30PZKMrR5H0gCA2V1Wtd73qRa1OywxzF/ioV?=
 =?us-ascii?Q?nKvt4pbLKWWReiK69d7s1cT1/m0Q2EQto0vQLpPfCUb1n1n5vxWKlQQYgDH3?=
 =?us-ascii?Q?uDOj99ltPpfhZTZUl+o9mO9iokjUh45205uDvQEeoKudn6elojG74I26fpGX?=
 =?us-ascii?Q?4OoYZnjl2iPnGx1SrSWjhIZ+8QEmjRxfrXb31HG0f1cocSAhWS9SeQpsjJte?=
 =?us-ascii?Q?IUU2drhiOUKbal/6VDBQ/UAi4/x8nDnEyCG/NGm4YB9sZDvBewZr46FNzXZf?=
 =?us-ascii?Q?XR+MFpjozM8uVu175p/SpDOGl79ASfqZJ9HJ29hJTl+ZJXPbdAhQq0DPI2va?=
 =?us-ascii?Q?uvmEUM6WuoLQqEyA3THUvzrK0srDvslR3Ayrgzs+T0FDZf8wHDZlJlX433k4?=
 =?us-ascii?Q?xgvcKeItMsBu+GfT6qdwBX7E+maHa2ht20IKdVnwLkoOXr+YkenNNDxiJlow?=
 =?us-ascii?Q?Sg1pfJk9N21K60wesUS227EtslnnOnaHbv283Ee0ieOjsqNFl/+lZNvrjvrX?=
 =?us-ascii?Q?Z5DK67dMIaBw9kwbgF92KQseJ3s9EplccR7iUkwTyzPmnJOUYzkXznmhmNBo?=
 =?us-ascii?Q?FOrolRPR3F36qvstGi5I38XXr5kTQBXHREGzywS6p/IOsPBRgvsYsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bD+abLfvAp/UUU8mzHOw0U8kfTgeAbn2rlSV/m/AfGBHTVisHPmLXg4hOnsI?=
 =?us-ascii?Q?IOuzu74YvO9Gxa/wPh1hi6H56Q+BhzUzDgGBZLPbUGZx0cXOK0UIIOTcGqIn?=
 =?us-ascii?Q?DuIbhu9UXvdsViTLhsJcfyJqNhV7i69c0ESlDCjrAbi0pjMLFE80g7qR5Roc?=
 =?us-ascii?Q?1Stne3C38CaJ1VOH8Hy7UEC9fi7Vd7HbpMlUY31BxcF9HuKYzO7H65eWKntX?=
 =?us-ascii?Q?u3uuiX501sYMI5Zg6chs1lWUFgH2/CLjaorwRqUIkwKDIF3un2+OrT7CAMFQ?=
 =?us-ascii?Q?+vfdktWFQuC8gTEJuHEzVcMXD1+qd/F/lOQjYEERTj/OnWldd20xq3Sh3h5f?=
 =?us-ascii?Q?Dgg+kLRbl8+iII5g5816MG873tPllLNAxqT0o3SLRIn+UbKkirwFY4/2phcF?=
 =?us-ascii?Q?HlBXo6TWKxyI65RjtWdvQbVF9/ewhDjxOblWWqBJhtw6t/zySMZC6HfW22Jj?=
 =?us-ascii?Q?YjMgSEqthoN3mHLpqFwgK1DfPElW5a6eQl3AtK5KDFS4iUvYvHKLpmfHhPDC?=
 =?us-ascii?Q?z2HoZQ5pqiqw7Pq4RX8ocrqeTy9tCu8p7AP3NJxcnxvb1D6BDPXyqpxO0fB2?=
 =?us-ascii?Q?wQ+UYqGm/xkLG2xdQAb7E0vfiIgKJuuqH2g/De1WjJf+af8QjFTSosx1PsBy?=
 =?us-ascii?Q?YDHmyGaKaNG3HfJcemCP8Q1tSUXluekiMmimvXfkFs736/VESzMIvobN7nRk?=
 =?us-ascii?Q?6aMZoIsGc+bTVzm5SrsJqB6D/aETfQe/g4LJqvOb3G+BivDo2Ai2V9HERzY+?=
 =?us-ascii?Q?QQfb/Jd85EULvc+FTXDHs6zQUwH6SiraYQ/RLeXOg7iWRp9jlNEao5naB6EC?=
 =?us-ascii?Q?OTXV2JzyeD4hFucmS1w8Tf2to7Wvjy4ZqPyBhLMZpSjF8DPQ9C6udhFWOPvH?=
 =?us-ascii?Q?mGuIsxJjxg93IsJD+D65cN6Qy8uCp7UlxeE1FYqw85zO4qF7RFpQKSxdiYuY?=
 =?us-ascii?Q?+rhLj/r6RSris6aTIEG9C4vgbq3aWoEUOFv+125hHk6/6uU6gm0KFhKvnXuA?=
 =?us-ascii?Q?7wvopRNasrPptG/6I+20CX0Cv+aY0j/k3jsh177xu+jRSVtQoUlOVWtdbyh3?=
 =?us-ascii?Q?pvHjhJ2guACOvY6JQQ/qzsW1yKKXoHj1j6+SMYTaNnTD7JoC483yvEvSdQpK?=
 =?us-ascii?Q?HeaVFKjDqq1AywCfwGlIbV9Y8UEvCcHpjq/L3X2yzgJnQaMTQvLE9rb6dfih?=
 =?us-ascii?Q?GUXP71n2i3L+eHk/aNdxQQrQ9C12iLEJxvCXeFvE3HkAx4wfg2cfy7Ylyjzq?=
 =?us-ascii?Q?dWy74qd+pzuerEKkTFzUS3icRkHAyb8yDU2hQOUa5DNFoHiKhpIfIpUE1wX0?=
 =?us-ascii?Q?Zqu8JXEjgnV4SejaiKy0v1m3tI6PAqY7tK2R+dORok9YRDU8iIuekSICBkh2?=
 =?us-ascii?Q?0arzlE0B9mAp6Ex09RtS87rBijb433oPgrIjGAuEjyDjchVx+l7eqSVKuFtc?=
 =?us-ascii?Q?bDhV9vHiiLhEKPwG+FfTkYEV/87V2e3VuDshaLVqNjsY1J71TpH4DPsPa1wB?=
 =?us-ascii?Q?ZHV23MP8qd61uMvmLCmx0RV9T/Su8PgqqSAFx7QKS+q6CPvMRQi9SBHYW8XW?=
 =?us-ascii?Q?f7eV00P89eMn2xFB/8pX5CS5TmvGvyg6c5Y4a/DP?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d39370-f871-4efe-2bd6-08ddb30ef353
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:04:55.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R4Akt8noFzq6VmiXMRi/P1X2aL8gZRcrza36NoFpIyMtJY5rBGp0omyBAVopED3Ql85p7JMaB0b5nKdmzKrcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10728

Add a new MAINTAINERS section for the METTLER TOLEDO BOARD
SUPPORT covering imx8mm-mt-* device tree files.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efb51ee92683..869fd05d3689 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16123,6 +16123,11 @@ S:	Maintained
 F:	arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
 F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.*
 
+METTLER TOLEDO BOARD SUPPORT
+M:	Wojciech Dubowik <wojciech.dubowik@mt.com>
+S:	Maintained
+F:	arch/arm64/boot/dts/freescale/imx8mm-mt-*
+
 MHI BUS
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	mhi@lists.linux.dev
-- 
2.47.2

