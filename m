Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2071.outbound.protection.outlook.com [40.92.59.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B7EDF;
	Sun,  2 Jun 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318184; cv=fail; b=jfBG4wsV+1+MiYfWpx1zcP43ZWGFwuQtIcgwPpHEpONY0PrjbVRnkkAL6cSF2dfqqTisSW+D4LMQMQdDr+KAl3gzzp7N6SpNurk2aNDCWdnMnLcMW3hCagi2SqyQ2bjyHPeTQ24viTKr7tR/IWjNtZjNnDcDGfymOU93c2g/utk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318184; c=relaxed/simple;
	bh=EkIoV++EQWX7fEp78z3MrjPSOEdT624XXeMwM7ceS4o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DjYgQauyt75KsV/dcAcQwPDLmtlclrdEVZOjURl2XFIihs8RGAER0UJvsXeiLK6lChV1skQUAScv4BCF0pkVuQc14vF9mYjAakEbdpOcOC5tikujBlcCr+0vhxx4EjJiqVjXo3Wz8PA62Zr3m5iFhBhHe8jvIVwuLkHepqDXDL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NgrKfNNV; arc=fail smtp.client-ip=40.92.59.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NgrKfNNV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkJv2WECHmqaMnJCMj7E8tVUFfms4jrlBtWhGJi37gjo78eODobfxAAsMSzg7oYZStz/yydV0WdELQ/RezOX981sBoLT/H6QEgT/yer7Dt6HedIBwKLpinzckc03WDeYBQZ0lHKFFpJSjR9hJ9zn97y8EXe3LFfdyp3L7VObjqtJcTyBBy4n3C3x2kP1iZjlfmIZbe4dPUHvo3szPloYD8NHLplnf2RSTzRoGKmBDK4JGG83hNadp875y+2Zytb6PTS8ju32wFVX786EqjKjMPIbfbErfAa9Vin0kldqubsOq8W0j6W7z28p1A0lNNYDAEJATHfmplOFoBPLnXAsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1gxQ6B9G5dB6VNhssLzO+t6YF52mD6BLE+PnrsnPuo=;
 b=EIjo543mjyu1RVTcPzE+Q9xoqnpkYLHzYf5upZgqtThcuz/yP3D9vW0wKm2hLlrPU7fTOLEAzo0ExoLdHZoGHjqUgeRm67CTJf6JWjU9jwCT2+AE3KKVqAAxixCBR3yrW3H3Kx2cGsSjZXfPccWLvZHQAPBeeKOsA2ICXDwhdKY9PUpIdY65cMu92vbDbqppvjbHU9XX8znqMboPKh7FZ0EOcinK5XaKEaCXVEpgX5J2Oo+8NaEdq12+PlD4s4uke52w9u1c0VTSSYdk5T87fCWAhzhNpuF5/GIXvTL1SMzEh+4eJXCmMiXQjBuivJY2jAk/VL7f3xZnA3DszN1g/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1gxQ6B9G5dB6VNhssLzO+t6YF52mD6BLE+PnrsnPuo=;
 b=NgrKfNNViB/1wwhu8yzUbTta2g9ZY56BTHaeZIw3W7epvATk8vX9xeSLKwhsIeV/ymMyw8DMAKYrOyjFpyRQx4ooT5DgeRpB9CQGBslN/fdtr9DJdy9FceJINxnIqdEfnxnxgq2xp3jmHhz7wCjBg0OtEd/Q/qwvrLzEKbxUEMYjKjYRd/A6oghWoUgjL4lVVtiuMpAwBMvGkJiW0wFgnyH5hMR2gVVxKRxzatjCMSi2u+8zRj7DbP4ONES/KBxl3hwik0NDex+z772gSb8vbI6jeqGHFrGfq/N92teZDXbkop9cgjelw1p/fX5EDrrZs1pHbDInji5wIj4scWKZXg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DU0PR02MB9489.eurprd02.prod.outlook.com (2603:10a6:10:41c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Sun, 2 Jun
 2024 08:49:40 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 08:49:40 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] auxdisplay: Use sizeof(*pointer) instead of sizeof(type)
Date: Sun,  2 Jun 2024 10:49:22 +0200
Message-ID:
 <AS8PR02MB7237B94B9A9F4580E79BAC0C8BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7g66bUeIVkWr6PGRlLCdgbl2XnXSHupC]
X-ClientProxiedBy: MA4P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::17) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240602084922.10098-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DU0PR02MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ea7598-a06c-4b47-0b6c-08dc82e0f067
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	+V7reUz8b9jUSP1VUOjdJrUS+RM411Fb2Am/uAld5Py0wce7BG/Py7m4Wu//uFdDP6MVf+3GEfi8u91zLBq5XZ1G6+bwNgiTUFL2im8l7+Cczr3+mSs/36KlliFv00I8qqQn6qlnok14eYBrO8tqLdu7bGt77pKaO+KqVw6d36HXIe34KGRtvuKLGFmbqaCjF2hPmHWhIuERwYYXIbGdz674iVgeFb0v6Ez3usN4EhjC/n5EPR+Zv88DE219Lp4D7NM5NIOWKgn5AH4QX/p7PQC4ln8Of6fWjO6RfbcF0q8v0tbRzph5LPRxQqIwtS19IXffT3xiR5ybldHgCFReg+h4ZXFutyPrVMtdolofTgA6MpxeZ3uuTqlTLVcmoscKMUADs3LWMD2iDTQIklJ0/6PM17gc1GIV3GNWZYwgFYxUNRtRAbHx0lBOKHIjfz3cs+MwYx9gaGhcOvPKsorQzIvStG9mQbKYB40wBRC6oZhTBDQrxmLXNpjkFvkvJXHm95YFWaBH7SZOT8eca/pPXKJCxkYTmAGRRShW1gbljcJ36z0ywHhBjT9yaLQu5ZN7xzZl5jd89ekErNvJnk5WIAGxJ2XuhgiQb69zsLwaEBnyW9NEyMe17HaFT1er1Tuk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKNH+ohOpxDrxyfu8U6weq6s/lUHZ1QNkuaBLacdtWMlaG1dnsgppnewTSyq?=
 =?us-ascii?Q?OrjyLbW4RVFWnGW1D+kVI12rxksQyg7gVef1IYZtGlwztx5DquKfYUjvhQtC?=
 =?us-ascii?Q?Z1kZTsRxU9M9vBnOMPhRoe5166xDYekDUzLhngZERxgJfqN0zk4kTEmunuS5?=
 =?us-ascii?Q?5DjpkUJIAWHrQhZnB2CqgOUAm1EoqvuEmUtjmIK3ygG8/SI1p8UqocdSATVG?=
 =?us-ascii?Q?72trgr8uvlulYYYwYCRCk8WvFfXInZm1qpfCYOCe/ZiNiWFrO+PS5h5gObWD?=
 =?us-ascii?Q?X6BC4bPpR5V2axTIl49lSSL0xwYydeoEfTtei/uleabBM0aT+Ed5opgAixmX?=
 =?us-ascii?Q?+1WxUEUf9zDpjv393YnqIYUu3//mR1pSAOB5WfqQDMM31aZMbbugz9q+2242?=
 =?us-ascii?Q?3eGsRSXQE2+4x2jK5G/n1cSHKR3BPypdoslAVOFPaqXz0L2vbyAUJXgdZpZi?=
 =?us-ascii?Q?lmCowgZy2VQ78+GL3EjeoWpPA9RtNKxiBj4Mni03V/xaVhNAB8cjBqu++IDj?=
 =?us-ascii?Q?9QIXgtqdXQKY3UpapPbuwctbTprruVxX8BAFcvU3+Vf5tvzF0V6PN/3ixmQd?=
 =?us-ascii?Q?yk4bRmDOQ1iHf4W8u6cZxCa0P8ZjOfLDnO0ZRv2xZJT5F/18nbUePgEHtlGM?=
 =?us-ascii?Q?4OUzY/0RbnT0OjiYScLlu4ljkgxVi0QAOYFthjzkwT3nxZH42mQQLgV3TXiU?=
 =?us-ascii?Q?qw6T8ETcIeOaRP33QhYnwhUWSJmSh7Ezh/6mGzyYDzMQvVU9aPfSTU7jSk5p?=
 =?us-ascii?Q?pNasmLjNqvSHD1co1XksiUl/bcQblhN/a0K+zDjhwqAI9rKfXaAsbLpozxDj?=
 =?us-ascii?Q?8a6rP4ppVvg09uRjmYswfuWv4l/39fr622C4Zw7oxyAN7ZNLwZvG+KP0rroo?=
 =?us-ascii?Q?elBO90FXKbK/+0y+BW1vDbIcY3hBX8/61BUwlPRc9NV/hFYPGrdPbRCWkO8F?=
 =?us-ascii?Q?m57ARDLisQjgiBvWcTjjbFYBBekJvaFREybrN0cVmQ/7Wi4YdaaRhLdNysdL?=
 =?us-ascii?Q?aYNEBRAZneLA3wB8YuL+kUHCxngsci6ttBTymiU6N3bqfGpRlNMaibRZXwTh?=
 =?us-ascii?Q?/7qqd8CPKcJbHLXmbj2xT+KW/P/yYee9tJziHhK0TKt3mMzwHhzOrol4UieB?=
 =?us-ascii?Q?kbJeXopqKLKKwyVjIleKURQG4XRE3eulP5utwqw8CwHBUCmwyxwt7TKoaow5?=
 =?us-ascii?Q?N7kSi56+mSc9oLEOCpbFtilQo2TA8GvDGdhqr54hm9FzhpJqxzqrCJ67rUOb?=
 =?us-ascii?Q?JRPayCJ3YFG9XfR92Dl4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ea7598-a06c-4b47-0b6c-08dc82e0f067
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 08:49:39.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9489

It is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not
change the former (unlike the latter). This patch has no effect
on runtime behavior.

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/auxdisplay/arm-charlcd.c | 2 +-
 drivers/auxdisplay/hd44780.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/arm-charlcd.c b/drivers/auxdisplay/arm-charlcd.c
index 0b1c99cca733..a7eae99a48f7 100644
--- a/drivers/auxdisplay/arm-charlcd.c
+++ b/drivers/auxdisplay/arm-charlcd.c
@@ -270,7 +270,7 @@ static int __init charlcd_probe(struct platform_device *pdev)
 	struct charlcd *lcd;
 	struct resource *res;
 
-	lcd = kzalloc(sizeof(struct charlcd), GFP_KERNEL);
+	lcd = kzalloc(sizeof(*lcd), GFP_KERNEL);
 	if (!lcd)
 		return -ENOMEM;
 
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 7ac0b1b1d548..025dc6855cb2 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -230,7 +230,7 @@ static int hd44780_probe(struct platform_device *pdev)
 	if (!lcd)
 		goto fail1;
 
-	hd = kzalloc(sizeof(struct hd44780), GFP_KERNEL);
+	hd = kzalloc(sizeof(*hd), GFP_KERNEL);
 	if (!hd)
 		goto fail2;
 
-- 
2.25.1

