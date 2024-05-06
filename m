Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2048.outbound.protection.outlook.com [40.92.91.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590881F19A;
	Mon,  6 May 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017350; cv=fail; b=i6slxBocSekjmOJma4hxn8hCM2qL/JEWqlLA4b4qjHSqeUDI13TOZ0kWRrf8tONNWcJVFyAFG6jH1Ojo3+luPDNz1bkEuTel3GEdYmou4ntyzswIYKJb+nx1kI9cHhG7ZDpRg0d5rDV37/R1XQ3reFC4vq+yRD05IyNytCKAo6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017350; c=relaxed/simple;
	bh=SsAsQrJ9zkPdmmuHBskf5+R8rggwTnSxYueAKCgvZ7U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qeVgFmb5o1xjRg+S0H4Hl1sMSsutohzTNynZFBumXPQkz0AqyIiL1oAtsaud21zRs53JHBknfOj5cjU14tnOEhDWSSfvLW3IX5T2YWP6PCtexIBThUoDnjBCbHDKigkWvT7s+NpuHjHAgfs1kY6cRFO4jdCDllfku7eNjeGkVYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CpmoSoRS; arc=fail smtp.client-ip=40.92.91.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CpmoSoRS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3wPluyzHFuaXwsi7jh07fuiz3cJUF/6fdaoYB897C6Vh+IqcdDI0cD8Ex7oaK1UvqbLaVkRHyATwQgFM5M96Jq9YLwxLRUbvaOOLnSOUIeQBdzuiy2nH8AX1+/ttw1lfQxBgMEUPxCLXFoN3va/ndecAy0IeVIGY5aj6m8p2taE0g1o8iUZSbXwEgc7+nsAcVjFZ20pcQHQItx2k9n/nSX9Bibn6gwzdoK6GDxF9p/XlpwIirf8lfqMg8mRbR0PhCxvwIu9yWHfevMTioQXHGIGNK4E5+nu0jR3sODRb/YJt74utL2WnwWZyIzG6iZRVr10vbMQ+IYMgVlzvPuTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KWrRjXiVt5XzbZqlD7yGKKcqqQ5rJdPZaCeSJAZIrU=;
 b=hMAesqfJNoR8YzBOKzjHLBnePmbRdYVOtuERKF6samxdXUKKQp5P9AFxF5ZmCWUVw9F2dPIK34GLDnrBAHyIrHtGF20ygrUF06tGqAQP1Ewn3M1aklzZP8rEnhLJl7TTEN68wJev5TsAf3Nj7qUa8poKjSA+L0mg2XEnkaDTZ8VHHCJngVOE2/M7sf71o/ac9vxznP6lIzZrTl50H5yT6o6CNaS5qLS2o+BODT64e4ok4DLRTMsJCAdYsnvmhHt7/4bRS4EBEGHAlylJHNEKrG2H2WHmX5S8asAEnCSjJF6u+4eU+YEYio/eeUk6QpsXoAa/gbE3ZyqGgEisNmZdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KWrRjXiVt5XzbZqlD7yGKKcqqQ5rJdPZaCeSJAZIrU=;
 b=CpmoSoRSNZABZ3S2hZ69eOQcfoVDVlIfMWjH+NArTB/GUWfXVXkvMMRDDk6rcdih5Y3stVu0O7P10wAiHKsXDlQMnv2rc7sLZbyI9o4O3GJaIq0amql2iNyO52Ze+NlJENMW1GNBX3K+Bs/WqaDnEYMHNznnnSG5nX/jcu/or18O1pjpR4VemfYj6PURGqBJyHOFDp/0v5PaXziDDp04NUbyFETEyERCuPdDmsBpLsmv3ohdVRJiNbmuRhHT5ik6LtHJT0t6NrTvtTQ+Qa+8hJt2a6McVHEbEnS4rghoBcYQ8K2ZZINVzRUHJYzJqVBDGQwKlhNEOpI06WEcxytz7A==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PRAPR02MB7956.eurprd02.prod.outlook.com (2603:10a6:102:295::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 17:42:25 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 17:42:25 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Kees Cook <keescook@chromium.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Erick Archer <erick.archer@outlook.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be}
Date: Mon,  6 May 2024 19:42:08 +0200
Message-ID:
 <AS8PR02MB7237CD9ECBF7907AD8B1CC938B1C2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [mQEvb7RwLZlChtEWhhFyAseK8Jn+tZME]
X-ClientProxiedBy: MA3P292CA0005.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::18) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240506174208.4734-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PRAPR02MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 44478b9a-fbfc-41ef-cbfb-08dc6df3e430
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	UfWAEC05wQAEYeAhV7hGLvJy+dv4ys6XSZBp3e5M1V4SArHgvrzctwieGu9yImWXsRJBbNLX/HS+CsTlsQ3XiB2T6ms77Va5LjOQAl0ycdGfi5uFi9HVyhdTlT92U3wATD1gWKj4AKXv781O44cbZzONOeD0z6qcgeOvi2dhE+hvnHHBsaCs1SijyCb5Ertc4PKIHSccLi92+y8OPe4Dkp2S5xUcVKBmgsI4fjs5xLZdeFkwpKxmd3LKjaYd3dDZJAvEuEzWCjYZChiMejOPvjCB3ap1YHw3GAW2/l5ZYXxJzUD/jI5nsFtRV336XNBJmowgPhdJn4aZi9vTl90EQdDsXQyTd+jjs6xvfUBSVcIj843h59J6sUXzrY4F4nJz8lWkE2JsL8Ju6/9bpfJ2K4F0OMyIlw4PAEz03Pl9IMvqCyQnT4PRNitZ3BI9C71zgR/gnEyT/f1CFe1Ywk8b2o6gz31ewp7GAfN5/TTw0LAVA9JkDvuR0wBQBf6OHFdME7CJzgbPBwL0S4tGd+0v/6gr0gy+LOX2wzcOToRYw0rCyxshtW86j5hsvxuiWdYKjQIx2JEvJ78GFxZDg/OA5yXLlaZXrs2b1lJ3SfBCTGdg3Ln1MCJILV7h0E3COLXN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MsNpNejIUIMVnNTuPH9/S+c6lRXxnbiNqaTO6C/h1fI/4kW1TgwIm2e5mgAQ?=
 =?us-ascii?Q?Soca1v9xnuoZpNxZyzeRwAsRm6ldC0kaX+OnlY88wHLo3nn4azLkmY2etrMY?=
 =?us-ascii?Q?ZblJufHQNIjDiQzyP94lXbY1MmxfHfDput3U/SO8jK4wI2e831e4dA99CfpN?=
 =?us-ascii?Q?L61D2tMfV50qKQK2J4B6OA0+UqVeqLKRJBFyftECalU2Ns9dpk1glLr3WKi3?=
 =?us-ascii?Q?QNkXVA8ge/vLukHazxghsTUqU0hN4wfIIBlqRMuo8EKAxJFM9Z6EQJr3My4t?=
 =?us-ascii?Q?9FV5N7O7aDrXs4YieTmegdnQsqhOwQFsYgXTqHlQrjn8sRtAs+fXaTdy2YKH?=
 =?us-ascii?Q?eprtmzQ0P7TQ4TZW1S7zbeGTZc64P+bqYQMKn9W47YLcsP29v0Vfn0dPMXn4?=
 =?us-ascii?Q?u4ePAF/jSULyxaZwQU3ZPrSfQMkd46B7SreXhn5tURiBLFqRSSbsZg2vYdTF?=
 =?us-ascii?Q?oI8/gUiM406xQ3/GwlH3H1m3zC6p6Ua8rA/hFd4DEkRNF5WLLgY485ttuth5?=
 =?us-ascii?Q?TZX6mU7Nqh6M6dBvPzj2zbT8VqCpzUU9Gy65wJIdFns8Y8V8SBj+YKcQ8Q/5?=
 =?us-ascii?Q?WBVRx87eqL+sOxOYUjXLu9Yw7BCpOILh+uaR0SfgvX4qbTKf1HYsa8Zj6P6d?=
 =?us-ascii?Q?O6BH5UEtdoZshtJVabgY/seTw0cN0j638uTEyIExOlgUU7tD0UYWpLwMu8L3?=
 =?us-ascii?Q?q/domtVNNoJ8X1cLuUGFNV4gBEiFrOWm9VLjsFyx2F/pb6LDE/Qxsjk64cjK?=
 =?us-ascii?Q?ngdu02q99vZ4yviEn9O1WtKWR7Rdu44mxNixCJUeagiwXJfRrG9MKizeyujy?=
 =?us-ascii?Q?R9YQzM/J9ruAj8BgGtnfkXL0yw2qPQ059TFjEaAgXWfBLeKKoJxBsrqdHzY2?=
 =?us-ascii?Q?ZRhxs8onJQXnhgAp5tgpVf6peouZI51opLmof8plVlsYQ6o2P7ugUPAMMFiS?=
 =?us-ascii?Q?1Wgl8+BGa6MHJcDijpT4sLiiXXbg5PmUACuMRo/i0Kp1Mi3Ah2uP6PfBbl1l?=
 =?us-ascii?Q?TKatNX//WkM9+TZbKW9kISYeWYOQ89iGEj7EXRlDnKbZYgSrRDm/tRldNywD?=
 =?us-ascii?Q?EIzM0YVOgHRyjxMHKohugHkI1252o4/t6q7e/jjMxgEZSwiDluli0GGCK+dh?=
 =?us-ascii?Q?Flx9NLxnJgcHcLZS1r4MUsxR5fLbykkpTmz+eeFsmuJH3+2ibMosjWa55g3r?=
 =?us-ascii?Q?9kwOME2oSuWUWBUl25wlVAHt1MjwhMLAlec+RLJlgWOyNNrSxqHDtt0TszP5?=
 =?us-ascii?Q?esu1m7FaI+79NN+izPZT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44478b9a-fbfc-41ef-cbfb-08dc6df3e430
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:42:25.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR02MB7956

Provide UAPI macros for UAPI structs that will gain annotations for
__counted_by_{le, be} attributes.

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 include/uapi/linux/stddef.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 2ec6f35cda32..58154117d9b0 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -55,4 +55,12 @@
 #define __counted_by(m)
 #endif
 
+#ifndef __counted_by_le
+#define __counted_by_le(m)
+#endif
+
+#ifndef __counted_by_be
+#define __counted_by_be(m)
+#endif
+
 #endif /* _UAPI_LINUX_STDDEF_H */
-- 
2.25.1

