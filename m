Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2014.outbound.protection.outlook.com [40.92.74.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC54E570;
	Tue,  7 May 2024 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103226; cv=fail; b=X9mKqyRXbLgOGL9FRYWHwWy3EmOzRrM8VT/rTnQbEVJeleUNv1v3YtFoVyAOK8cS0QAiR4sc+c3b2RNG6FU3as8UwHkV+lPpvPbnUeTdnPBaLRR4B6E1k/v5gDh7/uYTuzvfp5jJtjxcwq/Ha8KUtcJTune6FfZcJ5GYZf1qywQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103226; c=relaxed/simple;
	bh=iPJsb4PTmxDp3nQTa7DA0RPi/nzbtn7GtGuI9UQG0J4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VcgALb30yY7T2rSf19cLuvJ0RkgFXuv1ZIEoyP4Z3IyBY9btwIc1z9H9KAVyyAw/tSLLsEGPWpOWx4KUzuRVbZX1l8utMpxu8pqoi1GHexgff97WgMLODMjU4R8/GyPFoQYWxM8YAgt4dhwN0c9XmxPRp3odWDbTd0eZP5YHH7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pMXYxBx1; arc=fail smtp.client-ip=40.92.74.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pMXYxBx1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX0m+nshMT2b8OYNb6F8bBzNJBksJa5EGDfd9zT3iuGZPUul55gLqe9dLAK4l8sR6fOF3vCfcEjgC4AwWkTuquI+TEN/4B/mnNIcz+kwHJtF31JO73RinaJ8AqU04rilw/Htcud6047L0CwJ1S1iRDueR3nt+gmryZaZ9UgejOBSuP4FpuftpMLq2Upejwu39bseWnBCUT1P1K8c2pZ1PiVlCDHlZzxpyGw+HGscpKLTtfjtSX2cw7FIytF6kZ/ORsbAYb8oydPFPwhfRl5N9M1iNwKS4Pr0SONwA09QWUOj7TZH/PJ/eG3WZCrN/9WG4FOeOJ3eudAQkNzVyXYDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvIVXhbzJwbs+/eMVjaT41/hb9vSxlyPp7YEZrW/bc0=;
 b=YLQvjKNmwnk8VMuZ9qj/WBWaLxCL2eEUIwVf3WYIrWq/0t4Ktl29iLi9AAaB7T/LxmBTFhbW+ame1lFf1XKuTby5zNn7cVHCVlfwktmcV+8e5ciStum0XRLIIdHVxyanZFkmOR7P9EMPx2xSlDMLzKEFL5up6N2jY+kSdI8t+yrp25tQ4Vw4J/6lWr2kF64Pj/o1/NT0CzZh/rpl4yo/UChngzH2viSbgx5gxyuI2MxwkxxNMTEWm8pUxS70hly8NgUnfhuPG+G8P7SKUTpxqIugsrG4ExhW+y6hx1IJWeyNd7nh1sXamKrxZeswI9HPHMf15mo2gpC3/G3zAHP1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvIVXhbzJwbs+/eMVjaT41/hb9vSxlyPp7YEZrW/bc0=;
 b=pMXYxBx1E26XpSrfHquE6TuTxr6TWzu8m2A0kOty06KzHK1j2LZzNMCOZR+DwV3JkUG9OMKKAe2z8nwkAMQ9BiZnzVbRwoUfwHRKALI4YuEqkIz8VHInu5SzaihT5Rq74InOGLf19voIpKFn7l2HW4eypDHdeZEBbc5Gr621wMwtqUP6oXG/KUtyQmKe6BVuHHVO85BYCzOcraxtw8Eidb8P1pX2txLASQ03wVG3Bf6V6+X4GlQDQyWC3TnhW00Iji7Rj3xDN5nW7RbOC8iA7nzwj9IzILVvoOdUtJw99ONdRLx6iwnTkMlbZR7gIrTzntAEb7RpXav0kKeLF0yoFw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GV1PR02MB8356.eurprd02.prod.outlook.com (2603:10a6:150:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 17:33:41 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 17:33:41 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Kees Cook <keescook@chromium.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Erick Archer <erick.archer@outlook.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be}
Date: Tue,  7 May 2024 19:33:18 +0200
Message-ID:
 <AS8PR02MB72372E45071E8821C07236F78BE42@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7kGpDAFcCl+Cc6ycBCICDjWZT1ZuFQLx]
X-ClientProxiedBy: MA2P292CA0001.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::17) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240507173318.8817-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GV1PR02MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e67849-0667-4f71-b6c7-08dc6ebbd5dc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	XgQ6rhZXbr6KoOTUiOOAMqaQwrtn0D+6rCwPs33x6BMYiqQhOrW+5FGgnkXzO3a14YsoZUt3DEC9xpaY8CQTflg5RgCx+XpVWdWYzhDsZHmzJ1LusvsbMt9/qdyLRmjBAKEHarcOiMganJW4yarpZR9rNA5jr0H4nNwUmoMCPt1/GxQQE/AhmTjB6ey5mgdO7m5JISmwRngB4KwO/AYcSS1GcJHi71LSaCg1BSKbCqD83SjVf76Wi51+SALxhgfv7+gOUjWT6wR05tlHtaSRAgngKY8dC3nkoEQNnGRFyCXFVB482QBtTxdOtsJpGV0lgcfCx27urxdjvBVx/tWHGQIteOA+iZTlqOE8xXKgJMtZTPfvjmMgoe96fm/x5WltZ4AcbHUwJDiFeCqEyQsbcoC7dKTvAIgMmmdBUs1BMPlqpV1OfUGGX8hS1WFcaM4iD4Olzy0RF9NokwvemGCOjx0qiTnba62rsYTT8bWvFUMzcpUxnPOKr0//mTO3q31LohpvTePNGjMOXbQx9H8Wknn3W0uC6V749dO/0xeRNFzuWvEVGatouaNLMvX6f5vJ94FNoRfzqi3aLQ8q7dwMjgeIxsTh7n61JLTqZXKBe/5/OcKBN7IyBg9sABTXXVbIRLfBjvyRb/z0byIdCfNXbQIp8SBQSnm6IfuXPNOXdK/DYPq4efAuOpCwtja/D7Gx9OZz9ybkrXA7omQZOs2EEQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWnb+0twHxtYnUGPINYQKwvGeDVbIBIQ7woB36DWqDfX3q2chZRLPHFEmWjc?=
 =?us-ascii?Q?6DLVW0PZBGTwoxE43nuZT33nsVTSP18BZwVzofPS5UsEZpTlxl28CDB8aeVo?=
 =?us-ascii?Q?aQjiGGeBJkPdyFxwQP19KSNWtKCi2+g31Z7lsnVC0BUHpjXTKP5YiJ+kQBPr?=
 =?us-ascii?Q?R1bF6BBTcEbrO4Gv8PBl1GFeM8dB/5AEG3TaefbYHT+M0CWy58I7pCgA1paG?=
 =?us-ascii?Q?7clMIm4fT6a79kpFGevQ41hu4QRAXLkiAivERZExcSigyc+j+LBP+h5nO4qF?=
 =?us-ascii?Q?DAnik+VHyAyRbweWLgD5uGuroWef2QqN0UgL9AkTFPKAbfbgde1SMO4If4kr?=
 =?us-ascii?Q?K9scVvRYkB1TF4ORtt3JqS8yRIq+l7kxH/Aiq7XEdI+fiskOIERfXmQYH4wh?=
 =?us-ascii?Q?zWejgl5cFT/h6zqenB3FQ1UHIZxOdYco8MRF78XnwNoGwTkG/BYW9YhZE+dq?=
 =?us-ascii?Q?hAoEOUMf2V9upKER9kxG2o9x3ZJS9ajTB7jAYVKpT1ED0fVQ8pxgcyd5KUqA?=
 =?us-ascii?Q?82IjpoMZQWmCca8Q82A5FKFOXAuooHa/BxnmIdx4pv6TNF2v6EQjQwEx9fjH?=
 =?us-ascii?Q?2koQAKcoPaSAMEPDYInZjADUYkg26QqkNl614uKI4xUMArQD8ITXdcN7KrdG?=
 =?us-ascii?Q?0DRYJ/YvuRhfLx7OGbUKNQUjP6GnsL1276VvGqwaY/FaS5kdFZ/0D3mjwtUQ?=
 =?us-ascii?Q?IR9RveuEp+cnnaLK1Ty8rYEBFI7Zk8O8nX+bgtSAxXf8PPJbFJ5n/0cNX/PP?=
 =?us-ascii?Q?js6PQDDjjSRsS9hezoqkd+z1Z9lbw+cWWNvMXe+zhSxkLTxT4ZXjQKEoEpfs?=
 =?us-ascii?Q?wW2EIR7QhiQTBw1p7IldEZ3Sgt/RfFc0I+J8DiBwcGhH2QNO+5hIOkSxx+iS?=
 =?us-ascii?Q?v1o2EzhHptncvxppZkOqAJ9t+jtPL0EeXaUrGMPmzg3lpPhDSO3L86/tdcpa?=
 =?us-ascii?Q?4uOoA+Ve8YkMCSYdbt4UO6YuMAi/c9iX/mmfp+QoFE6RL4O8OS/1i7n2Vdlu?=
 =?us-ascii?Q?ylkFfBmzSWFwCeNWM2G4pd/rjoXUqQ1dO3NlcaOQOj+hbW+WRhBwK2T1Baii?=
 =?us-ascii?Q?FJ3fRKgZ8GL4ciiV/htEiHtTSm1ibAtyBf9ZolcmwJYXxLWf+IAIN5ZpzI4H?=
 =?us-ascii?Q?a0ftTWWS6I57JZjf4nyDLTegicj33tl8vmkXoMd0swxD0n353jAU7Eih+4UE?=
 =?us-ascii?Q?hgmdkZNu19YqGhRyjSefwHLXWPg9/i5zmQAA72v0jMDXVdiSHHTk5yd+WlV0?=
 =?us-ascii?Q?EoGgtxJK0FXJp6wEfZam?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e67849-0667-4f71-b6c7-08dc6ebbd5dc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 17:33:41.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8356

This commit can be considered an addition to commit ca7e324e8ad3
("compiler_types: add Endianness-dependent __counted_by_{le,be}") [1].

In the commit referenced above the __counted_by_{le,be}() attributes
were defined based on platform's endianness with the goal to that the
structures contain flexible arrays at the end, and the counter for,
can be annotated with these attributes.

So, this commit only provide UAPI macros for UAPI structs that will
gain annotations for __counted_by_{le, be} attributes. And it is the
previous step to be able to use these attributes in UAPI.

Link: https://lore.kernel.org/r/20240327142241.1745989-2-aleksander.lobakin@intel.com
Suggested-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Add the "Suggested_by:" tag.
- Update the commit message to better explain the goal (Miguel Ojeda).

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237CD9ECBF7907AD8B1CC938B1C2@AS8PR02MB7237.eurprd02.prod.outlook.com/

Hi everyone,

The goal of this commit is to be able to accept this another one [1].
And as Kees suggested in this mail [2] we need to land this patch before
the other because we will need __counted_by_be() in UAPI.

[1] https://lore.kernel.org/linux-hardening/AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/linux-hardening/202405060924.4001F77D@keescook/
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

