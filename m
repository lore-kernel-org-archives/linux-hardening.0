Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010058.outbound.protection.outlook.com [52.101.228.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45C17FAC2
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548189; cv=fail; b=tbrKkGpA3OwGYwhIjh0PQqfrN7AyNNnUcJbhXJIGyIeZ2hGPCl9BFQCrSiixsCsLJUz+ytkF1rXb5Li0QVhnUPbIu78wOLP6m/oHnibv7v88/rJUGVfOhc70QkHktgUcDy8muIoX2v30lKSDK4vZD6mAHmW+hla8souNp9HyjMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548189; c=relaxed/simple;
	bh=NpcC1wRJWrkhJFdooMwU4RIPaotdjA71BWCUY10p4iQ=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Umh3Ng7UqE+wC2k/jY+IdPKS4TecQpLaNaTkM1vp325lBn7oRpOI+6ltoLapi8k8P1B1lUvDsvCGFKRL2s+qxNbXWqTFuRBv6TnxM7b90DWMpZK8Nj/OQC3HEF9474FIyjLMJrXsr3k7JFi73Ab9ARsKzR5mW5bUeW/urQln5bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=QCv8Z579; arc=fail smtp.client-ip=52.101.228.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="QCv8Z579"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4wICUK66xZyIHi065wUF9M3sjwH7dZXPr5we/FgNi4uY/kyxh0OjIFeI1UvADszE+OMXYMiUFvn4HSMv1O9IiUpCM56mN0YzJxzlFv8iLVVjJznWP0oViT9Lopu/5in7qn/oNNKDFXTO0DC7vFtl5sLFUmVmw6n83CjdgEs1J0LU0HGv8jrZ1lieB3o3oGkqlJiMzEryrezwTYSfXsuSNnLq/m/ZeANSNjTUs28NHvXxrm6/BhUQX6pLes0nt71tao7cKFbzdxhnchhzl/gv47h3GG+3mzgwMRxy5fCS04onO9eUCVJGMxNIr9paQHEnjixv1j5FR9nmdXhjI/+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UizzLYPVKcLTKJHzoo7BkgY4TihUSpI5KvE9Lxqnyqk=;
 b=q6+zPqcrlJX6z7zczqpgM7hD3Rr7BSY/Sd7gSnPLiTWhfJZhI/Dc2gZQqFxQ4dl4lCtTJzd/lSYdWCtjks5NE91Hxx9DxFtlJ1+CGkALtuPBSPW8I8wvSdeYuKp1yG5Ce3/52e1tfaAZV+0QerQMSnwSyKwvnzsoB+Z6udkam+m3XiTAAjTILxnhz7cGsGP/QsKWwlO8f6+xPSUFzx3aqMaj2u7K6D1aSuuMVjajykMLIj0VyHn5db6y1N+AObPLqUeKivVk2AgAdzbbUcy6QwOnL9EPqBUEiKgNJZzHfZUijC53U+6xaYQIR60It4Z+Zsgm4lkdiH8uSqZa4ktWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UizzLYPVKcLTKJHzoo7BkgY4TihUSpI5KvE9Lxqnyqk=;
 b=QCv8Z579p9Sf9pYFDxDDJQ5IjVovGfmqqDRWgS3Zvtpv+uY9y9e8W4+N6cJ+w10Xw+zagnp7DIf0Otz220VP28m4w0TuZ78HeLjJudzmFl2adZSAp7yqXdoN/EB1rFZNNNROHGj6l5dWzBGMs7rW0Brg2iZmL6VzRh4FBCRo4Tc=
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
Message-ID: <87tt8h6zew.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>, Kees Cook
	<kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 03/10] lib/string_choices: Add str_in_out() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:35:51 +0000
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12800:EE_
X-MS-Office365-Filtering-Correlation-Id: 25acf863-b0b2-49b1-b125-08dd56276ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nio2djCnEfKidvrET6w1p/GSB+6wQH4dt/hNWU7XivWeXRqgJaa6DLRDVhHI?=
 =?us-ascii?Q?JKT5FARjzezH0ZuOS2EK+Jbr9b8PRxfO3+iQpDKbVFsnPnOhssiwb3DysTpo?=
 =?us-ascii?Q?SbNtTFwKu0iKNSfRYTNghpjHbt3MigoPwNyYh4u6czGoFx76TxFj2mT7+618?=
 =?us-ascii?Q?1oa5uSivabEH4JK0r9WLNmD1erO6+P+zxZPflpT6QPMMdvxdD9u/0CI7BdI6?=
 =?us-ascii?Q?4wkOrsagcfUcB5B7pZ0YMASlfMhIRh7RPsm0ggvQafRfmcTEBWYG7YxlS3vE?=
 =?us-ascii?Q?KoCM+RH8UAGuYF/AFv89ebyKbdP7hHctk4Dbhnq9mHwU136cKrcqUvEJWxVm?=
 =?us-ascii?Q?gZiIA0SK5pJPyteusmcdJgVAN583CSnm/ZFLJjNpm4t4nQVKBbyNiDTW1Amd?=
 =?us-ascii?Q?Q6I8K+QAFJCVrVRZWjiNmuZGFn0uYUXJVfRhdCgbQ5wuMc+ymWCFJgn8n3xS?=
 =?us-ascii?Q?VaH6Y0ZHG7zo8bLTQf5nfVZz7/1NGce1W+FhsOMqxVq5Tu/G8fooMwwjrOY9?=
 =?us-ascii?Q?32xGrGXVUHsu6PvfR04sDJy7YK5Bj10vRvSQ03EzML2m7tZSptm0COkXl9Qt?=
 =?us-ascii?Q?I9iVbC4+dIUvIheqBe67/Oh6H46qL7ujkPrPYu4t15GpLXRnNOJnYJOXrQku?=
 =?us-ascii?Q?z0YKNxDonq2QrICpNO8kBAw/+caWdA2fgsVzibVfQqO4ex9YNAe4tRTp1ly3?=
 =?us-ascii?Q?/hYjrtzUdMnxI5u7LbbJqFijo0Agp5TYMxR+EnQpZbgfbhKYljkhl4xmm3if?=
 =?us-ascii?Q?dk5+DunIywjwqkHaTee7G1kpl/mtBKIN2Yv9cPxgamgtAJty6LTJfFPP8Usr?=
 =?us-ascii?Q?/O34pqxEYEFhubDWFWLK+GsaCyHTT8c8WwQO4kRGy4mrNmc6S/0zzsFeaFE/?=
 =?us-ascii?Q?6Y7I+sLHbYNOUrbqExBMuJnRyYbnJgGDlhNVuNjDUK17elKm10A9cBwvF+C1?=
 =?us-ascii?Q?GmnbsxIwWw59mmM3jBJJMJxzFw9BM70kaKjkbh3gNWtASyRwT+lHQndqL/lL?=
 =?us-ascii?Q?JS0Tihx06VJLL083N+4/VbTYXGjamGrmLiNN/T7D5z6fRJRxfBKllQbhOgMJ?=
 =?us-ascii?Q?eElA92BhMw8LkJ21SHdTmCnEEYNV+6u/mGG1NYkkYrszMRI/TAD5AAuK9KRI?=
 =?us-ascii?Q?PSu74eK6zoz/DuccUy5NRATmGUhyHLCwSkLEN5jnrCOyrG6lhXoE0bQeYMor?=
 =?us-ascii?Q?XlyxmbWkq1QPM+5lWfbeDvHoBRgstUjj8qSt4EXNYXS6HtVxksrH9zriYXoG?=
 =?us-ascii?Q?i6vmQrz8KN6tK59LsUtPelbayV6Z5xGM2sVIzb5WIxzCNoXehjrBtzmX0+Jj?=
 =?us-ascii?Q?9AIc8Npf/CqNQXMeikozdRTKmFCERnS/pVr8j3f1nHob2jtV7MRlcZR4Xva+?=
 =?us-ascii?Q?vsmWF6shF7sb1+rw7XgHyXKeSK04W7lXWZj8JsTt5rH/Uu9H50TelcdN2aby?=
 =?us-ascii?Q?oQjbdkAY30cOEFBD1WrreBtYWK9Uhp/y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+FcyYXzuGbsiclzVLV9FfKcmbKqQrmUOtkKVtcRxNpVpzg/kWI+45ajSiNAb?=
 =?us-ascii?Q?9FXEJOdRZGp122X2QP2PhPn05KbKhmpnNO7GA9elr2CfIxgQBFY5kA8uSz2F?=
 =?us-ascii?Q?o529Q5HrUDqC4F/upPT+J+cxgKNMfhB/MXLW2fmNzESAJjPfVWT+bB2olMEs?=
 =?us-ascii?Q?K/+0QOMEuG8tpV842oUR82FDaRAAthrAaj+runXJ0jMhgonlvpzK1aGoreDF?=
 =?us-ascii?Q?myFgEMa6xcgnFGeI8w4Gwf7kHmc7rzoVVdOVkvYnndlaNM3b8CrATpv+yV9z?=
 =?us-ascii?Q?da3FW+BAwt7qA2VOCrHW8744HopHV5B1YExBzDmT9NM3C5XSPkROuFCbb1aK?=
 =?us-ascii?Q?iv9340Y9z+MjFk+Dl31zIWMQbubaFjXVJtnJKaRySCPGgVkpviotXibwbZLD?=
 =?us-ascii?Q?jLWsUK38ZlXxPUvTJSXb68KWfAXmluBUl6/isNsOxtaCaLPBSgwf2qLk6z5J?=
 =?us-ascii?Q?NQZSLnQUQTzy1o5WRuU+hC5UeyuTgeExM1VNe69Yu0jUVcEtAQPbuhh/224B?=
 =?us-ascii?Q?aWjMDTWHTEvPxVaLI+wQ6Vln94BSWw5WPFvIWFmJmxaoiS0twhXcFkJTHCDv?=
 =?us-ascii?Q?pksUhE0Q+4zcCnhxcdJBmL4As+9y/2vwwe6SBzIFD95mKkoKW3PwYoab2mKO?=
 =?us-ascii?Q?RM+2+oNzGl4zzKJMmvaW0ULfCM7+cgJynU3eL3gCB7wbzPsloqKoCKhUxcqa?=
 =?us-ascii?Q?t+gSzadINoFL3a1DpCCz9FqsV4sPFbardAnmqxYvU5rfy3lxvoxsXvTpGKCx?=
 =?us-ascii?Q?VX8Xzzf8mgU3M9Y+cXGutDev7WOaIAENo2x4GddxVV/lJuUeUpfENiSmLBZW?=
 =?us-ascii?Q?VG365zrCsUoxL6k3PCCel6rS/tXDhIRz3I4u6jMmkWUjERBMDyA88POQAzmt?=
 =?us-ascii?Q?aXhVBbtbwCMeBCe4ETN5CSwURMwHV1q8imt2moMS23b48spukKfbFk+ifwlt?=
 =?us-ascii?Q?hT9qhX97yg2isKfEi8Hzgeg2LJ2tp+SK9SjhfqfetNmWaqqvl/TLfUqEq494?=
 =?us-ascii?Q?ondrbukF2rit+9A0Bm9v9GNjg9+R4R2wLN4U7RB9CZ7quW9y99hix1OBOpdd?=
 =?us-ascii?Q?lBv/TVnnZ8ZjgzfS5ISgb2R15sZQP52AnyMW+3cMlR+XhkgRIdSBD4LlnYaZ?=
 =?us-ascii?Q?ihnM5BjYvDvUbJVMTHeDLYMWPa2nJgLr9zRqYFpgsL8TC2BD4ZP2qCxZ5arE?=
 =?us-ascii?Q?l8f7ir9uMqfI+jqM2AX/K8SvUH2n7qwC68g6MUenFDdhQZTfyu66m7zAIMc0?=
 =?us-ascii?Q?9LCYBFZjGNw+UWroELClm/b/SIFssNPmcitHtfBR3EhJfi3cH0PHD/pMOKIu?=
 =?us-ascii?Q?o/Sj2zFnpDZTYQCU4Hkuvjy81986zNV2LfaMOVzVbrYxqPrc2Hz9EpN7WxVm?=
 =?us-ascii?Q?QcpR/h2i1f9YPSQ11KbCl8IjK7kIFFJP7S/G00MvKnrCG1O6HFkF0rf6HJtb?=
 =?us-ascii?Q?2OJn2XPYGopdXwb7kPwy9QXDV/DlNgXJfeAIu6M6gu3jZakhrwzQAHUE7FUM?=
 =?us-ascii?Q?FNh5dD8SxF/gnaheZva1oYxNtJL+QlJDy7KNwAwa3RUyDVQ5Ur9kubFJKccv?=
 =?us-ascii?Q?gdMDWILWjEetsCrCWfhGr2YfC91W62ZTIzlMOKf/qslw8+u4BxnNoOtoVzsX?=
 =?us-ascii?Q?XWZFo4u7edFjnLlxcKp2gbM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25acf863-b0b2-49b1-b125-08dd56276ed7
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:35:52.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYlDFxpuHiRqDZvpDvqwGrRzvYXL89eDAkDd7kxzfDyOpleJagXuyZGKg0aARyX808iZR/WX8zGPA1FxdJNtuPFImzjaWnuC6DUakTqOFG6sxsS+CQW/kKGzdycVyrfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12800

Add str_in_out() helper to return "in" or "out" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 2a6c8df585ea..96b54874dc3a 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -83,6 +83,12 @@ static inline const char *str_tx_rx(bool v)
 }
 #define str_rx_tx(v)		str_tx_rx(!(v))
 
+static inline const char *str_in_out(bool v)
+{
+	return v ? "in" : "out";
+}
+#define str_out_in(v)		str_in_out(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

