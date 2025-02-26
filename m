Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1669617FAC2
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548186; cv=fail; b=gkRCzbTU3DQObn60LNvl+IDfQqxK9mBMquZydhU1KDTozMmKifnqmsSs9AKAQE2WKQQVllIDLteJE1ZQ8IrVaXGdyBPOLbMKT1g84pwkkTJuDGFyLC5O2K74HdJSSmfkS0BoRJgV5t5Sj8l47UgPFkmJESibR73CcALVVs4k2f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548186; c=relaxed/simple;
	bh=eHtXr7lFNFpmME2NY0aXdTnJmiVvUeYO2FOTfOgGiEc=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=cqvMixumwo4dj4zJXem4rYXaEXcoGMSqw8DaNuGB4bolcJshJr5UvIb8ncIsyCVNmDXqNwhgab3N7xRHPn70hvDxMskT3ZjcXzHBj+Drf+IWcFKlxMribaCHEedWbVpDdJxM38jcZXrY+SnXVMRDecOyfaeyNlXW0SKGZfzX4ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LOYy3o2m; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LOYy3o2m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzXhbDJ53HV67d9K+OiaQxl+zCRRIqyFw33F9TBdbUQryxeiypmLUclEEEAYvwGglAn7QujBLWSjj7NzjUNOMWudoPCmAoUXWFVOJC5FJZuh8G25lS5MEfxTuav12Wgra4Msvv7/wtI8ZueayOzQoFKvDG78p9AaaEco5Ysip9veu+g38RnmGkKLhMltokNI/IDpwr4xMZ1LBlj0elNlJoRqCLGKCCZhQVcf9SkipaxI30lXZY+L+lUHzXF/57K60HKXTwx8rCpA1MEtRC8fCneeBkqReekjiKg5TqYfpraz5QtBTo8ENRsq+90uo6s3NmL354t+IPHiM2RNAFtp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TidHehJt82/3JFO6ERI8wCnSSIZNfjMusUaqZnRoQBI=;
 b=mtIeIp0w65+4HYdTe4LsM348Ga/W4yNdakjQHQ4rduoQO0M1ncbuClGJhQh1EFcqmCIcIZ/ejJbnAJ+kgc+2NkNop2Y7ZfVUhMzMPp0FFw54uoQx5aXjfeOBxs+N++cm+HSHfbljvsqvMYMLzlxMBBfE9W5yngNXFrMPfmt2G05FkqC8ChFFwtStj1/yCSVFwpYce1U4acZnjnXyK+PwHLAWdjnmv9RHfLBlUhk9sz29Fs7Ua/gKm5xcLETKwpNZ32zQMFBSltcm1amYHkuqg05ZDvjE0tEu8ROQb3mr84cMfab58tqLA0JKeq+x0cNZBo5vDp/O0Okj+o7PKYMh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TidHehJt82/3JFO6ERI8wCnSSIZNfjMusUaqZnRoQBI=;
 b=LOYy3o2m/lGAElj1FwT+dkV7ZW/uFeJhmaK5sZAWicMK8/4Yn3SvmNevdO6rKcfId/DNDHUWF01brFiYtmldVvHl8WmyY8itbRQUs48/buQWOKvcsrz9MstwWHKaxyOUDvlHW3lxksihnq2g44E+UWbLoFvJzGab/SrZG7TISic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12800.jpnprd01.prod.outlook.com
 (2603:1096:604:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 05:36:22 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:36:22 +0000
Message-ID: <87seo16zem.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 04/10] lib/string_choices: Add str_input_output() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:36:01 +0000
X-ClientProxiedBy: TYCP286CA0263.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::11) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12800:EE_
X-MS-Office365-Filtering-Correlation-Id: 923d7b7f-776f-49ad-61f6-08dd562774c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nwV649h5eGlSJMWO1AugzlKap8KjxhQ+MHVk1V60Qoa9hzLJy9iAVf4mS1YD?=
 =?us-ascii?Q?Tx6yxj4AB+A3rS1YVctZKPngRElGuvXdvi3DfaFZKNSTrdOSJe6HksjEj+dU?=
 =?us-ascii?Q?1udUgh3lnWBTb+i/ME7sjmy6uvJ7G4aBy76TVlEh4VrUNl9gji4FfCxGgrDB?=
 =?us-ascii?Q?O67bpCOjz1WlRmqfe/lCh1NXxdUCjtirbr6V3jMtIMEWqATzVmMR2EgnJqD9?=
 =?us-ascii?Q?LEXwm6r5Xh69trIGwFeOSNXZMXJU03WIsfwLwVvJP6K/fW/FeopayrighcdJ?=
 =?us-ascii?Q?UkTBG3Z7GpMEKGqLyXXWSYXYKeVZd8DUxqTD/uz3CaejX7+gRYEJe7oDcmiU?=
 =?us-ascii?Q?6WtGvJ140hETXrLIG1q3A+ZlN6SHFwSC0UiN0zUF/5HxyDqQ4JQWl0TYWxIW?=
 =?us-ascii?Q?RqzagyF4fnsOOR9lcrUudjYgd8ztLKxjts2Fql11wrsubVaEMIaMtod5evub?=
 =?us-ascii?Q?oqMBcC8/b4ogjNfZxJ1ng9wp7YOhnVXqqVAKC8GTZxEtl6mHGD2XKw3FJamg?=
 =?us-ascii?Q?uGqCFVKhCNnnmNLofEkjM+ArxymOAYaWhwvnjCVRwLwnOOluJM7rwAf2959h?=
 =?us-ascii?Q?Ju5Fi7M7fJbbmJp6s28FbBgp5OVUOght/tlfGT111y6Gq60PpkvW/GwpMc2j?=
 =?us-ascii?Q?ajl0+a42qA0mCmLIbiZwJga8H9YPoluuFdBUGFW5grQuyHwxWBmgQQL/03ke?=
 =?us-ascii?Q?8+r6OTnbGx0LOHk5ALZsJ6zU1u2iAnXOfG/WoTQkJGPfWS/LqcnNGYq8jzlJ?=
 =?us-ascii?Q?eFVec6TzlOIkqJn4p1EH/xOgWaadLoOQEOvYtS/FiD5b3dRGo9F40VrwgULb?=
 =?us-ascii?Q?+SbCt8zrs4pD0555sRjMPAMKsdr6G1qKJoTCR7b/5Hdd4v68mw7I27t1Uuzj?=
 =?us-ascii?Q?x/V2AxyeKfhl8x1/9+QCq6iAjUa+mRZV8urJ41Ke+ggmEmVlQP2kPpt8cFc8?=
 =?us-ascii?Q?j1QDpVKHw/D3FRtzAbvuuaIPvLU8AMlYKAh3m2JMM9Gsg7swxdJUvT+Y3CZy?=
 =?us-ascii?Q?DJCx/tPAF5jE7SCkEagTbcqVOfak+E+9zO0XWgfProXONdFWncLKWWdZt/BH?=
 =?us-ascii?Q?AKj3zyI5edfvYyfCO6cvSOxoK8OGaIcu3mhzH5xqIYuJZAIyWbuOhuSAcype?=
 =?us-ascii?Q?iIl8Vj3R0F3nCi5MYIRd6A8owO5q+qBBbxAWiqur9f1Hob6f21/7SJqnVCmn?=
 =?us-ascii?Q?3tA20n+mzc0x9tOf7QJ/8s3vTBa1s6qIKeFI5lIOCJUXW1Ji/9fp9LA2BGii?=
 =?us-ascii?Q?EthdnHEpeeKrLdsn1FewowHvt4/3vjaFSvKACPk0B5wOPT5CWH82RFAcgqE1?=
 =?us-ascii?Q?ms/x8HU918jOcFdwK69EmZBqq2DWeJMn+AKQxy6WO5UBsIjKe+b6IYdw4r1R?=
 =?us-ascii?Q?bRbcee4OYmxCJooGo53g9Q2WxlQ3xrEsU8o+h14JDcfQoBTTka9jYTAl0ON7?=
 =?us-ascii?Q?yBq3ZFnHFQKIgJVLY4xcO6ZmzvS7HIsz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aj7vcwpTsWtA3bSI3Bv/fF56qteS2c1G0KHERRiNuWFIgP3cxcvoYxrvoyw9?=
 =?us-ascii?Q?/J6U0iDwbSC8+Z9RwN8dzHHjFvW8bOwciqVHLJMr0hZHaFqkJE2/Qjemd+h8?=
 =?us-ascii?Q?Ymxbe4uet8riCGzLJA/hobYS35aaANNgg9brCHcVI0VGi4rdP7zxB2ctaD87?=
 =?us-ascii?Q?WaD4yXdj/jBQaWIjjAds0BBEqtljfNiikLhm6Etbl5YchhX9zBcjpaL0YNDs?=
 =?us-ascii?Q?xApYOnRefJWECfIl9YwOhHjlO4uYt59Y17LQc0eiSamv58GFeKVQCKeEjUsq?=
 =?us-ascii?Q?Vy4aH3Qck8Qy1+mxloRQFAshBkdgS8IGRPNa2bJFtLRsr1phXvXtzCD5xgZy?=
 =?us-ascii?Q?t6MARWMmCsYdhKFpjOAit7+HfIdCU0pH0t1EA1iao8VyD/9SQxd9RGJP7Iv9?=
 =?us-ascii?Q?9bdQSvghLUMCWKUCJ9p/iznSY394+1KbvK78hi/F8yK8Dba1zPVEXH2TXl+N?=
 =?us-ascii?Q?VCe4gc0ryEnfP61UMEA3eiUnZibraXTrdeVuAMu5fpvVWiurhxKhDViJ1g1w?=
 =?us-ascii?Q?njpf9kIXI+5PVVol7pqujWCON4cNl2FTdZc7doSsnkEraSZQLi2Qp+IdCMkg?=
 =?us-ascii?Q?SsX2ofz/jfKoTFipDsVPWzcOAc3ga24e9oHYvS7QP/dLjpgUXcTBM53bqm0N?=
 =?us-ascii?Q?KXewaOBTv2k9lfg1uyNOOpVnm3qKMYE93S96W7nQP1Ovvn1FOlWdd5iafGBJ?=
 =?us-ascii?Q?23Or3PYZhTaQRYGGBzy7J3bF+VAPosNZynpzcvlepz7yndbteZmHd9uNcNR3?=
 =?us-ascii?Q?WrJADbynhcfGx9iFAYBLKOlxw4XhUYZb6RXOj42lp/5tWAOJRcGQwY4LyVPh?=
 =?us-ascii?Q?+RdBOWlnGeTLOcL8iKqSA7Cff6ZEQST+s33SIpXuVyKX57PHYIC0zaqQ1xmm?=
 =?us-ascii?Q?PUMY2RYQLiG/+WuXG7V8yr212QiEKPGRIL3vw2LysUChWrbsU5KmP44woKV7?=
 =?us-ascii?Q?g6GGV9xDPhRAy/YO3UG3rXEZIZ0/f9fQN8DqCmfsnSb2POz4JXKs6xrAaxSx?=
 =?us-ascii?Q?S+ChuU16Dy8lmvxdKqsN0CnOT3m/BpamI4gxu8X7nyxlmKipRhzXmwoV5u+0?=
 =?us-ascii?Q?Vz0MTD125hkOpgCDmEfUXbfI1yhjGxRIvdyOc4IVcqQW5A6PwpX7hvzQPdb+?=
 =?us-ascii?Q?e4/PJ7B6HKetDB547SrBx31OxoL2Nos0d6Ry789Dm/cLe5VY/8hG5lenaxX/?=
 =?us-ascii?Q?b/UbCeR/XPll3+EWfPRqQ4mMXqAIcamnxyLkMbYlH4bA6uH82hSdk4IVf7gn?=
 =?us-ascii?Q?ax7OoepjXO9m2iJg1Fg/FlFIU5PE12zPbUqQOF0YexqKpVSiNromQzaeUP8g?=
 =?us-ascii?Q?RzV82lGujevo+fuPjwJ/zS0w/IM2K1mF1WOM92TecrI7gu6ks1wsJI9fjrEX?=
 =?us-ascii?Q?sQMhJ2kWa+mAUa2osdNFJkI1MiCLKHr+JwrG7EEDXwXRIr0i3ZAf6C6ZFfbl?=
 =?us-ascii?Q?9NrcwlzL3wOWS0DLyidhKT7vSJqz9/QKRPsPaRo4hJAYryHnTb4PsrvJvTHM?=
 =?us-ascii?Q?3nv7lClYlNbqUWCG2jCU17PRSfL+ZpmbZ+ja0XEpPoztWQJmPmp3QhYj4gKY?=
 =?us-ascii?Q?jeH/rehaWnR4lOhmtdJOZxgjaDOThIxjZCvaJA75/M/RkfF+pGfYbaA5tm/S?=
 =?us-ascii?Q?6YIAdk8+CvpzixwWQWhj2rQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923d7b7f-776f-49ad-61f6-08dd562774c6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:36:02.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9QiooNvbWc8TPK72rfBW3S9cZoRe0CVgnefzKa5YSJZL9dZ5ackAz+Q87MXyaupsbJ/DScI+5QsPKtxQv2vezwa+fRzdIHB2qNIQ35zMwzVpQTNfdvJfuQKf3MeCQBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12800

Add str_input_output() helper to return "input" or "output" string
literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 96b54874dc3a..cc7c771f4e84 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -89,6 +89,12 @@ static inline const char *str_in_out(bool v)
 }
 #define str_out_in(v)		str_in_out(!(v))
 
+static inline const char *str_input_output(bool v)
+{
+	return v ? "input" : "output";
+}
+#define str_output_input(v)	str_input_output(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

