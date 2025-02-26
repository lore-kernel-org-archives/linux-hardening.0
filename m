Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83D424EF7C
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548190; cv=fail; b=ZUcICO+qc1HUCsJ9AbB/M9NhocODwMZIx64I2EBPYys9cOuSppl7+3uXWtI3BufT7dCGsDcnZqFF5SpoqFVASsb3JLAWqnY37b2LmiuFPuOvG6Q2MPQxtvbfJ465jcfS0se+aCTgMXtrsewJKpB59aqNfh4INigdrtZn9m9VqUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548190; c=relaxed/simple;
	bh=PGJo3b04Nk5jrw8L+a1s1xitnubBQ/e7XXkqHSi2CWg=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=crp+fjpjp6f7i4XhGnehELW778mKzi76n3UImMcu6DJtapwXjLb0nJLNeGHvzqQ5DZ1D0apg6nRXhg2DZZGRL2VdAljeZkmLGGmpGFe1EYv91vEMhtOjsTi8ZzGbA2iUqZkl3zGSA48Glg/XwMJfCMff+BWhBoJTK+552yZq7gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=X4+jwbUU; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="X4+jwbUU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey8DyebjKM8sEdnQto0YU7nzB6EUaucDkeR/nTcJ8btNVD4zDm87h9R63Prt0x5ocyFezR4UKmW/xIdCYlcIeZbYXHhLELMxlklV86AjnGstTI5nBQr6E7lWStTaGY7X1gNbmj+c5R56Ms70YZvCK/Aec+QugFX35MIky12qgh/0brO+8dcJ1Ljbz3zEW/XUvgEj63hfAJBHy3SDM/Td7v1mRbOMZq85Q0Yah5JXtfDjOnQTf4n/zzCzCd7CAsS5ya27elQBv5mZROevIHKJvB8Cb6Ovma3ia22xplKBE38fsycur8D2bE1RYGwphCwzl98V7STn6MT1wU83w5iA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg67JsU1j5vcSQuNc4jURiP7YFq5Cc2S6N4X6xgIzQM=;
 b=G/JIDkb5kGxGJZ39wjE68WqhO8HkRsnT6HfcqCvm/aoPeoBX31sYACUo0IMruKSz9fc3t3f0MUJY2OjSGhrXKM5SnM85smYmeFUFUeEmiccE0rnjDy7HHEBbhFp2FwpEad6z8GGGFtxO42u4GIONN0Ln3E0nP376gBDzwcyk2fyVhTMcz+PrTPJkeq1akPQr5VGmmWTS6SS9KSeh/W1R9j3sIoeP8KpGi1FBSpvj+TZ5G9Y6jrdaPEzV52qIaWZXt7+hMFIQWYKGQbhBwTekqMVM9C952Dn/IKsEFUDcMjuspL6MXEpcvTtJjsmoUMielpVNuPpKhT8JETKcDJ8/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg67JsU1j5vcSQuNc4jURiP7YFq5Cc2S6N4X6xgIzQM=;
 b=X4+jwbUUliF0Jo9eS5+Djgp5I3gE2R3pVr+pdafVkCnIGEr7gQGxBlIxnC0Y+tohYwzyktPLvks6LwV7FfTEooswWOf7de9Ue+f94r/uEsOEchs1Mw38i3uCAp9KZkVpyPoSSwtwx4QJFVacFEJnlb5lzXJFJ3mJCaWo7lwERRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12800.jpnprd01.prod.outlook.com
 (2603:1096:604:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 05:36:23 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:36:23 +0000
Message-ID: <87plj56zec.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 06/10] lib/string_choices: Add str_pass_fail() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:36:11 +0000
X-ClientProxiedBy: TYAPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:404:28::32) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12800:EE_
X-MS-Office365-Filtering-Correlation-Id: 0551e533-2552-4c62-6ab8-08dd56277a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Bu52WWHrs04+cE9sTpM5yAb4opZ3QWSs7yPdSwjxcZPtqNW8Taj7JsWqWQ3?=
 =?us-ascii?Q?KrjcTDYWlSUUsLJ76Lhi7CPc60GFoXL32YFgz9xbC6xVcLyiA+u4El0+wgeb?=
 =?us-ascii?Q?VPLicq6xcnbd+BXiG4WztoGZLT17pmrOtQts80iupifWOICGnMxjI/pqsJbL?=
 =?us-ascii?Q?G6ljUawAtvo2XfHLFOPjUY9jPYxtrFlhIFJh8FW4wGOw/3Mn3V07sUHJ0vqS?=
 =?us-ascii?Q?3y+KQrhTKA+ViveoRcx9xJr/++KK1mUZMLZCB4x4gTn4Cq5eXHxj45/Qr3w7?=
 =?us-ascii?Q?ybYlSdJP4YQORJFnvzH5GfBlB4I7BTofTtdTww7jE5L+DX0DHXoKLEriL3/7?=
 =?us-ascii?Q?AFajR++i001bGlL/r6cSDWAq2EWlVhaHK5fu7xGkghBg1uzx7tVd/Gjx2kFe?=
 =?us-ascii?Q?VyMmW39Wyk/FPwbLaUcV6/Cjgtt2qdUpca67dEmPW8tjj6nxiMlwy0QzaEgQ?=
 =?us-ascii?Q?t0Daa4XRtmVYwuurMaNwp57FwXrCHb+Wca1H1L3tqLvU6BdWK+iPgIr/7hmV?=
 =?us-ascii?Q?McrnWB2ImH/JU5LguiYf1UUmTid1mI4Ues29c89q7dUjLFTmsY1Y3O6fn1Bk?=
 =?us-ascii?Q?1WmCVY59lPMoDWpRk+05P/LmNBJ/SaK+j8s16t8rS48L7jSiW6/0lY8x27MG?=
 =?us-ascii?Q?UWELSfphKB1PGfWTf4AFSM9A9BXCX8mMthqxa2Tx/OrZgcgCh2c6tiV1L7R1?=
 =?us-ascii?Q?L/XOrLZcawLp7r4F3uJZWVsylyQSw02Aah7paQeHfjVnBBUmUfBmkYwcw+u9?=
 =?us-ascii?Q?s4FVYji9np4erd/svNh7QNA4iOv8p3yBsPW5c293HZdO5hWzUs9Q/uFHLIt+?=
 =?us-ascii?Q?vsEljUvB306kHJIjR29/CxhXUPbqNdAO4mcquCkRl+AJNEDOpqEyRfE1sftG?=
 =?us-ascii?Q?PtQr2+0akE1q62XR8ITQS4JF9AKxNXW/6z537kyrFbzuglmRJW/BtjeIeCEe?=
 =?us-ascii?Q?ew7q/a9OTjW2lZMQGu2KVHPCAFUsuA9vN2PI9JJpk5xGr0graiDGNBr9OL7K?=
 =?us-ascii?Q?C9zQovRIzO4ezBPYk7Qw5k0ZkuGdLQ3ckrbHaJ0EPnt4fgDrXAotFDo/ISPU?=
 =?us-ascii?Q?Wq8EfNDZEOooTRosxF7coAoAgIf6ImcYlAIpm6zN3qi+GsXJSJ5tNKwleh3J?=
 =?us-ascii?Q?NAEdbqLE17tZyGWE89j9+ACUkIzMikowzcflEsOvxsuDSAw2CT7xrIQBul0o?=
 =?us-ascii?Q?DS0iZBF7mNTHgRN+hYOO4Hmbz+NSCWiVDZ/4EVxq5BrYoe1GWFRG7wC5Wexn?=
 =?us-ascii?Q?zvTx0ihRopcViXQE936i/hk2QBWFDEzQ5IaXDcTXVlfpAgW8juNmOYmE3M7v?=
 =?us-ascii?Q?sRGIm/JHSsLDXUh1m+30UsOHYPp6d/iFccWZaJ/vhSLu6N0rNMgwMLbTbMSx?=
 =?us-ascii?Q?0hgVKa2T/6Z0v8CzVzIbUrO5kOAG5Hz1ukZr28UCP/v0hvR2xqk301oJXxgv?=
 =?us-ascii?Q?OoDL51UMNKaBBVhKqGKUBVHkpehMGL9E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q29NmWDdA9A/NYNFrlrgWJ6r4f9cxaV9RQ+vUhlaaQ+QOyuISAPC3SBDAuga?=
 =?us-ascii?Q?yGlzHCZ7tK5zkVAM2CjmzSWz1sY6MBUmarGJJvnvrIz0mOwbar/RbSOEVC4E?=
 =?us-ascii?Q?K8wnCq+USxQblkVSO7BqGXdro3veXydR1wwTWdTIgdAgiGRIGzhft/SuBXYZ?=
 =?us-ascii?Q?/GSGnEGyV10x9UZT/YIAd521+vcXJu9LcsNTFph4z5Tr+pL1Ab7EMuINoFBq?=
 =?us-ascii?Q?jA7SwI2/yUR47tYpQY/EDw6BbYzbXAdqF+5HScmnzy+KPvPHMH3fiZo6WmmN?=
 =?us-ascii?Q?9yu6bWNNYioEzReSaeTFTOYmKnyijSDdZ94Xe2WP5ww29DUibS/i1UQfXk6p?=
 =?us-ascii?Q?YYTJMyTApj0MpGjq2UYlcOPWQZb8NWFEaOFfTL38Vw5QYoIMRdFReZkT45yh?=
 =?us-ascii?Q?BwCDB9IYY0qfsSx71TlCzy41fvezT18yZHhgDF936yMzmeLHyc4Elfb1g4C1?=
 =?us-ascii?Q?OmSDY7oT5mvKJ7BOyC0knUAgmMelAylP/4USXhpmafL178TonbCpEptK8lC9?=
 =?us-ascii?Q?sZVJDK4HYMhr2NuuV3h0jhvGeu5wwWTjU4rgz9AVvfMBtlsAouMixbsw53zj?=
 =?us-ascii?Q?OtuOmMaTunLYQSrl3mk3t6dyFuYLMxJmXT7bg2EA7D8NQFsNeihp1KFPqyjg?=
 =?us-ascii?Q?lHxdBNAIjp70b/O/Z9h0qx2ZUe0u4CJfE8Z2EibUidntsMyLkfx57Hjm5HQm?=
 =?us-ascii?Q?ul/GFko/MAWXfwXSnKeL5UJxliNcDL+as/cJseZh42362cjuvu/BFPpgt1mg?=
 =?us-ascii?Q?6Fo4fwIzTABJNZMy0xhoWFWWbQFE1epnGTXMwNvIK895s/grIEvS2T4CObcy?=
 =?us-ascii?Q?7tnYt98KqUtRdKNwoP7fyNDsNPIbGzKoq8ZKfMlfPEbG8YFALUAba5WKV6NW?=
 =?us-ascii?Q?G1YXFSR6RQ3/nq5Sw0HvlcHb6o2BCXymXdRLy+zrNrg0nSBMH3sQubOVRO1a?=
 =?us-ascii?Q?dnbvLs4AHMUaNIoAyZURwEPJVmdtVjYUiE5w2As7ojF6AuCS5i3Xny90hDkd?=
 =?us-ascii?Q?uMIz2PAilAtWlIf+f051QI/44+HXIbyyaQ2j2/utIGTVWvfBWrieoorN4m2T?=
 =?us-ascii?Q?yWtI0/7F0bY6KrqnxELpEbWII2wAssWXkjR4hHXAby9KoPOU5Z4BsW0xSpAG?=
 =?us-ascii?Q?7ZQmcRD68LUeydp9t8pYTaVQ9QQHVMI3rU+/u+YjhMSjsKWPz/ZMfheb5RhG?=
 =?us-ascii?Q?aLJPtiCb3PpZbdBHsYpjoK5+5OtIY6SQ0wW01YLC2XeSmwnySQRUw+RFAKba?=
 =?us-ascii?Q?Vr67XDtiOwVjGxtan/68JlBkshnZx3c57Omv+YiTB1sfEMwpLLlLZs888MIN?=
 =?us-ascii?Q?SjE5aSbVwo4A36Wqbvvg/72+HX24n2ulZ//oWTDHeHbC0U2BkfLpenkbKEmt?=
 =?us-ascii?Q?sAVdGa7WP/SUGOCpwI7h8OZCVjLrrwqM43X4cw/A3mWrD7aJZijXQ2AeBoqL?=
 =?us-ascii?Q?/AuF2hT2swMN9PDsimi9q0H8UhKCEX1LQirLuNP6jedEa+IVD2QRxP7DBw/z?=
 =?us-ascii?Q?Oq9ihhz/Vuub9QyYripozH0Z1vMBtW5QQHIdrfR9hpU440eNwmXV1dBW64vM?=
 =?us-ascii?Q?AwkqQTNfu36i+0WNHM0mtY7US2FUkIUS1drA4xbfspbNDTRJULB9FUFBAQzD?=
 =?us-ascii?Q?+uEgvnyFfgZRSWWF3ow9lRE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0551e533-2552-4c62-6ab8-08dd56277a6b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:36:11.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdJxm4V43MbhdovjLek59H81KVi7aJMHYP2Taxy6UZLJJS6Sol08RJasXCE33YWSznbWBF2HCJyU2Urxl5Bo5ryrz+wG1XMCLenV99XkQA6eea8AFKmf9S4sYGys64A7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12800

Add str_pass_fail() helper to return "pass" or "fail" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 615ddbde4743..d52ced93e21e 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -101,6 +101,12 @@ static inline const char *str_input_output(bool v)
 }
 #define str_output_input(v)	str_input_output(!(v))
 
+static inline const char *str_pass_fail(bool v)
+{
+	return v ? "pass" : "fail";
+}
+#define str_fail_pass(v)	str_pass_fail(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

