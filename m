Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2018.outbound.protection.outlook.com [40.92.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C019007D;
	Thu, 19 Sep 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730725; cv=fail; b=ufF0vwbFRKkmEDKUzG1wg9EsXRAeTctg7vIhM5KaNgRnv01swB2keeO3bW2T2ZUe9ifL0RX5WNW7GMCaDZ/UGaoFXou0E33Jhg/4DT9ol3R1VvswN4axvj5qLzr1ev27QOuZ1YeYCa3VRgIeduXsA7PF5zh74ZbKobp9trjrJaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730725; c=relaxed/simple;
	bh=5z8qoiJUDx3nYvbcqC0js6pLvehY0j44P43mmz6FboY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YKG9ISJqNNnqPAt+LpgsVlEaH/ToCX8npk192DM5ezRue/YBlr8Lhu9ZdsSYGNDAMmxO3T9AtnJf794BTvmXV2HvdYAcg6kDXqyO7FIyvwWY12VLVjLbXUG17tMzcVi/37/jYCWxtP0E94uNgtVG05ugKSaMFxpsL36dxqrsV9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Zl/5uAAA; arc=fail smtp.client-ip=40.92.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Zl/5uAAA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKQnm9XVsWzHRbcsJ+qYIbPXF2hUI9J2W+/kHPqilzN61GXn635iZ/85uroyr9pRVdLJuMe12IrVauesqrv0DET0ilyawFM4nRQt7qbvd2q7peRaH5livdtUTZssbtGfoq4u+/lVbdzvk64JMuA6Z1WZxwvv1xzgMlkaQ4aQKf0ZyBG/qK9lKJOVh5R4KdQQppSQ1CFGlZZVn9og62lrU8dtM5f+4LPF5As8g2mlwJsEw8D1qAKvfxSfgf4iIWVN5UN1WCSwtHWGAePe4+Oj8ICfOB6W0dZq7coXsGVsq8+BQkuI8XEP0Vn1fWD7NKf0MIMfmyyo+ri1t6RY6+/3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrPxIQFw6nPoJmJoeCqIsvKPgrXN/N7h1Hho2Ai/hEs=;
 b=wyHnhgxtnurnCJdzPGVaSfgwqY4GcsgCEPEI7+F330DSrpSFgb9vY0LANDFzTTur34h+BJGUXfdfimeZiFAz8YRwJgsRhr6G3p3FThp7ZFR912rUGRcuYBFB6PRc4N3wFiqg5hiYJd/BmX3Mf7CsbjuA4pg9CJK6NCu0qV4ymZXU9aQmlKkmZrBmAUC54J/95kAkroIjQEJvR5zlYPD0SVN3cSwqVmEt05TGrfZLK4I9TvQ1b2u7dCBqO+v8ejWb5Pu+eFBYiAt+ZRI6NUqNV8EjWRLove3VJY98ByQK+Q+U2kLCihU7aIfGAExosBuaIivKQsYiaUqbUlzMFuEI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrPxIQFw6nPoJmJoeCqIsvKPgrXN/N7h1Hho2Ai/hEs=;
 b=Zl/5uAAAaYkFJWPBlDjQw40yDnw87Z3qasI8g2XkMg3ZAT+ZBkt0ZLKY5q9B6QIo35tPZhyNB9IZrhPpzfRPC8t3myuYkeSb1U8lzJNpzGNKcady+Dg56pG1ZLhLU6jqlmeJa8R6FQNqROpQUEjO5590H/O9xYHONi2Fkaj2SrKj0J7JLoolzD4no+VGQxmkmZKEO3lRpe3JBIz4H69B5Z4rv/ESAuhxt/ezMCYOvy09/p8jNUySuW+8hbakQW6ZsANnjdkKLgTpGfNaRUNK8k/KvTDFVGoOYKJjbApxoImtZ20HkACeLdinqCEIq0IfEGJ9Y02Ou/S8BKZyrErt0Q==
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com (2603:1096:400:47a::10)
 by TYZPR04MB7668.apcprd04.prod.outlook.com (2603:1096:405:46::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Thu, 19 Sep
 2024 07:25:19 +0000
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::2555:b04e:a2d8:8b6e]) by TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::2555:b04e:a2d8:8b6e%6]) with mapi id 15.20.7918.020; Thu, 19 Sep 2024
 07:25:18 +0000
From: Enlin Mu <enlin.mu@outlook.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com,
	linux-kernel@vger.kernel.org,
	enlin.mu@unisoc.com,
	enlinmu@gmail.com
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-sprd: Select driver on ARM and ARM64
Date: Thu, 19 Sep 2024 08:25:04 +0100
Message-ID:
 <TYSPR04MB70840448562705C21BA8DCCF8A632@TYSPR04MB7084.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [d6wwALj1AgqDPSeeO3VdVLBri3/ltBBbO5zS9TPq96YujNEEivF/IjfXV1AxEx0T]
X-ClientProxiedBy: TYAPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::16) To TYSPR04MB7084.apcprd04.prod.outlook.com
 (2603:1096:400:47a::10)
X-Microsoft-Original-Message-ID: <20240919072504.3599-1-enlin.mu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR04MB7084:EE_|TYZPR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9585407d-7d4e-4773-7b90-08dcd87c36a5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|5072599009|8060799006|15080799006|7092599003|5062599005|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	HzZ+gZqbk+2gg1HeRKm2vyf8VY5kPgkJEQttM9qKZjR4f0mMfwJbPoZmJR2DjrQQwNG81Aomcpwn3vFVp7EQXFetqKoCzJTxF2oYibGpRYA/X3an9zMqxxB1bn+A46NTZ794Mq3oeN27rffsluZjWOR7rlmhT3JbrYQXtn63AN1pl3QUlXmN5WRJOt1JpmH235r4BZkkRvtgK0ldCdlS4tfhNiDPMd2hBcqdqtHQnR12HbqkaiHkNlt6z/rUf7i0NlvYVbYNLskKiQJSxd8Kcfdd4aVukCt1LwBPaMA/ae5NAiT7Z9Dk6K0gBSekmbR32K0u/LF3EADOusNtVpllx+Ybl+y+7fy3pKrH7NL4MZALOVyg9+Sk5loDMGD0rOTIKm7Nt3zK+UQg+s7X+xUvUM77yN4zBMqXF3i+sCu9IWAprN4ozLpslcM4uNQJgg0la4ntS6GV0jNVRNGg7II0BN6FLATnxZ9WtsDDNHBdW6diLSei53KRZBsiQ9XJCRsC/r80RU8NU3dXiTMvrbfWxZdRmUiJBXX5kCsN8wM8oNbDWZpO9rybC82vqeSO4J6KgFLLPr1RMLgBXYmRPzV06igmb5Xe6h4/6ZIjEFtbfm3ZX3gi3Phb5WcORWrvG2v2BpgB5VunNMX4jEOOGXWY6sLIuotnwOSKyZuM5T7ELD92Q5i11b7XGERW7lbaPqlks5Uy5Y9bvYYtr4m96fJZP+rKD92uyHJgK/y5PhTG/xdmPRgGDhZwNn01NzJhNJFVs+R27kqANZSTzhsP1HUTmg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?76MNgh4aIORlkcpim175TxbvFgmMijj0XcMxGBcg7JkIvHuFAMhDVyQEzaWi?=
 =?us-ascii?Q?Xzb6OKxnGkFUk23ZkS6wr+4BYg9Nod4OmlzLcYGwbuoPUktEv/sDMKMJcfdl?=
 =?us-ascii?Q?0OUD1IJXEMTDhlhk+mhoqjdFQXSOYatyk0L609PkDY7GPLwtlEiI0pN84hqD?=
 =?us-ascii?Q?M3RN9/ep//MApKfxNIX/G56J77BMEZip86u3eFf6SCWP0QGIlKtCo/44aYTK?=
 =?us-ascii?Q?HNtvcn1PASB8Y6hKr9fBIAMmaD2Da/Nhv/5nZ9oatUk1NoyS6K5pbFqVI9uf?=
 =?us-ascii?Q?gRRiOqpJ5RNOaiWn8i+GO5mcG6xq9TtlybP03cWSP1FqmgadC01cpDeGVZ+o?=
 =?us-ascii?Q?89CuTD8sJYcbs+UITzbuQfW2LL469H0k0ibOxMCoxJmkr3kUZqgB8Z/73yhn?=
 =?us-ascii?Q?drsEWRzbxNRWna60gB/EzesSJ/z/98vBoVgxe4adtEuXN0ZnF4qhOdwaC3TX?=
 =?us-ascii?Q?BqBs18Hqma8cbXkBtAwh0nT2tmdPIjdbhsf+2g0pyKdoN7leEupbf/iWZWDP?=
 =?us-ascii?Q?TLpZ4hUrZEgufsUkwZlPUvUIOlgJ1Bi9AtoL+h5bSJl8oUVpxYEFoiXt7cfC?=
 =?us-ascii?Q?nO9uW918vjr3eCinJSjay8btbi22OfGSrRrKpSu5dV3UthjFe9fzeIGqf3Qh?=
 =?us-ascii?Q?lFZqK20pdinFteXzoy+iq4ed7ljmIzayOLo2zl7wU8cSj1O9lyhvP1vHzu5t?=
 =?us-ascii?Q?DMn2x227fozp0jmZm3yPVmyjXDXfUphyRFXlfW77ZeR2Ui2xEuqsz2wnVsjA?=
 =?us-ascii?Q?+s3wsy+9TFAxrwfsFnd5jshp86aseHwPrPbIKfFw6Xp0yX+wxgU+UTcp8GX0?=
 =?us-ascii?Q?NWPX72ysXzDgdv2GOsDnBqwUE2NkROXuwz5y0dLg54zcXo3yHLCDnIXlgEHW?=
 =?us-ascii?Q?0FcsowGOOgP9y/s5D5LhqnMDeoiYRf7TFdeLZ8GpwMwnKLsUwqZnI33/lI/E?=
 =?us-ascii?Q?XeKm+ta82+4y1tOSC4XX8P5Th1BRXW+E8ZEh3z34bvJNqc5FGd4GETtlA68O?=
 =?us-ascii?Q?DnL7o1kaeVosSluWiVNcoAZeWLubBt+PtH5dEHfNC68AvGioKyw9UHHkuoBZ?=
 =?us-ascii?Q?9S9oe11j+QimMyo6tFU8+ADEuaTRt0nLc1Zb+V8SNdykmFYbrYt0q+zQLQqm?=
 =?us-ascii?Q?I9WM8htz5unCnpY4dGg8uX9JYbXSnlLmbAVqYGt+5aukZXogOjvbKurSeosw?=
 =?us-ascii?Q?NwvQz2yH71wNgdzUZq/PBoZqLeSnXLMEftpEt4E/nDZl3fjOnoathIOnq0VH?=
 =?us-ascii?Q?Vai3e9CKAcztf/htOyiNB16L+yx1j94gMXNM7TcGq89e9IiiSbkKMLUbhxgN?=
 =?us-ascii?Q?bjppm99hSQatkm8dQ7ir0hbx9wgNqW3kw0a7HibefjWfBw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9585407d-7d4e-4773-7b90-08dcd87c36a5
X-MS-Exchange-CrossTenant-AuthSource: TYSPR04MB7084.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 07:25:18.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7668

From: Enlin Mu <enlin.mu@unisoc.com>

sprd timer is currently available on ARM and ARM64 based devices.
Thus select it for ARM and ARM64

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 drivers/clocksource/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 95dd4660b5b6..296c5f664583 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -494,8 +494,8 @@ config MTK_CPUX_TIMER
 config SPRD_TIMER
 	bool "Spreadtrum timer driver" if EXPERT
 	depends on HAS_IOMEM
-	depends on (ARCH_SPRD || COMPILE_TEST)
-	default ARCH_SPRD
+	depends on (ARM || ARM64 || COMPILE_TEST)
+	default y
 	select TIMER_OF
 	help
 	  Enables support for the Spreadtrum timer driver.
-- 
2.39.2

