Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010052.outbound.protection.outlook.com [52.101.229.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF11553AB
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054403; cv=fail; b=qXuHvj5dZFHKKl3nZJTWP2Vnckh+DEOl54vrgPvJgkCUnwaTfm3v/oYZj2Fmk0Yfa4QTOaop6dakZ3M+GeWUzg3Ou/2EyJcp0J0zWHIigBsbnzytLgZqqCyXCAIxEry5mTC3p7SqVfjsotyknv50Ie/jdiDqIQOnJCVI1Dbq1OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054403; c=relaxed/simple;
	bh=NpcC1wRJWrkhJFdooMwU4RIPaotdjA71BWCUY10p4iQ=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ghTdDHfWLb4YG+XEQyjSYExoc6jXa6rhT9gJc1c+oEeZnNsx8NhHm910w09oe9+pKwIF8aTOV0wSs18hvff2+/z6m9YR+v+zysp3NZohFoCmyDAk2wkfRbI/BS5VldZ9XNqQpwbQ0c8YmK7iAHuVBGt/dg2/NoLUMHYCbsaqMSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=IrvIEObP; arc=fail smtp.client-ip=52.101.229.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="IrvIEObP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiE/i0AWsb58jTm+lf7goLDwK9keI84ux663Wx4nKpAvxsTqhcOdN73CeZhf+Dr735N1hnmXtlA+W2HF/lBzjJ+muhr3AsPmiHhzVDQ2v201iby4GzuCDwrmdK2W9uaJGQSJ6KdInsLYxxFYAk02g99dJ0OjzrQV/ixqtYbtFGqmGQ86gox3X+PaRaWieohjzy/sI+emeFjCIsErXlGo6pwYC++9lCiKr0ivc+EKxh5JOtISdBBsZl6ucwXnVMoR72l5cLojLvbbOSguWjjsQfS7zuDDHOfqsamgOzafiG4sCWyv/VUymxiv5sCIOsCzersYt8IxGheHmhsi1Us7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UizzLYPVKcLTKJHzoo7BkgY4TihUSpI5KvE9Lxqnyqk=;
 b=mbspFBvsh1GE5tkcbBUexW4du/Ei9osI/0PwDsMa/K2RrFia8UDH0t2QaceADTS37pbgUrO1/qrCaqFsnBMIn5WLvdLTcoFKmlJcuSn5GyCfRKoXKjg08QqpvzJF0gZLzxFTp85J89xymFbEMl9/OHd+IybqpuDlHwjueH/tvjnqZa1a0aXqCqZBp60F73x74o2Gm+QaNfD7Pru/786ADsipogGHCtyrUwdACnuW0bta4UYOuV6bKWE5WfXerq0IVGC3D9nnPPFosXKOb4Ur5GcrRoVxkEKOo6CbBa6h041bYyyATt3LSx03Nvuzn3fO5qlhXRl+7BqFLgpHk4v+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UizzLYPVKcLTKJHzoo7BkgY4TihUSpI5KvE9Lxqnyqk=;
 b=IrvIEObPoWE3UPy91DlpfNDAJNYf0uQ7H/1L5YwW9SfbybioUHQtqre/TQwwPR8nhUOyvnSVd4lUv8eqmhSL1WLgHWvgjzotCpX0hedRD66WZdu37qmZVs6p0Ja58nHPfSymSGa1V4IlvhXv5RvKG2wZlaeyzkyLpgGbRZWYJ+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:13:19 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:13:19 +0000
Message-ID: <87r03dpmps.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 03/10] lib/string_choices: Add str_in_out() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:13:19 +0000
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 96720ef1-cc12-446e-af29-08dd5ac221bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lm7Un0lPPU0plPw6KKE64AUQd1GCvibGF/vqIkxbWWNmNkqECEyWfJsPIxam?=
 =?us-ascii?Q?njq0cqmhY4K1Jz//eGMH00oK/5T8SHLSGBL9iOBjphRItDKJWZ4v+Bn/N1P6?=
 =?us-ascii?Q?gD6gUJybWBmcEXmpkpDdo0Bmhas/6GVrtFZMIFcu8b1ly3gKv/+VB8OM+35P?=
 =?us-ascii?Q?SIbzEk8DsI8YtV+Nnr0gyz3plkg2lw3FhpGRW6usTi4MPb50RJM/c+9aRxRe?=
 =?us-ascii?Q?SzIc7NGPHmBwBcNg0osZa8GLoPTi7zUHhURpn6A/YWnkLh5SIJDgkJePqpxg?=
 =?us-ascii?Q?/YSCLeQLcWsdNBGzmz6L/gTJWLp9ow7GC4Y0uF8E0oj4hPJnCBTfETqwhm2K?=
 =?us-ascii?Q?Q9YkZv/mRRd8vSRX7Oo0RoPQFBNhTpYr8Wxn34NOaBpjTZabhhyvT8Z+W9mE?=
 =?us-ascii?Q?MnniodDyXPgfgwHkYVvwQNMNI99URv7Z15Y9AjMSYUSCG6H0j2SD1F6Gc2Vz?=
 =?us-ascii?Q?YyP+NeDMSUbSiJbSFk68Rhd8PiHbjgsauyae7bz0y8WNIQTqTwVI+e/mLfKj?=
 =?us-ascii?Q?XLXwGPWd5iteJwwh+1y6CO8XYd7HPzZb56CXQEOlybJnU6yFMtkDESIClJ+o?=
 =?us-ascii?Q?Als6b8dYr4xmdrIsCPD33L7QDh6DazvkIXysbKUqx5nm+2QQuhMCpkT4GcAw?=
 =?us-ascii?Q?/NQK/C/AJDp92zjMPsFJRb2RAHdPRhc9vkDPIfTuhfENnvbQV5rDkqGiRJ9n?=
 =?us-ascii?Q?eKAv5OjkcZh9pxbsHmDb+rgEXeUISok1a+RgtMHdajgEhpWBOJ2m7bYDMXuf?=
 =?us-ascii?Q?/aARAfD2VuoH1sDic2sP+bfCzvta6EagzH8cgKg2XfaZm9j5dHB63fuagiMf?=
 =?us-ascii?Q?b800gu8ZS+7zzIXhsx/uHXSAd17so2HwIBWl5F0mkgV7dnTVS7iHyHAdAc37?=
 =?us-ascii?Q?qUGZBSXByeXQqx9x0QNdXhR8EAcCh4uyx05bot64IkwZuWyuKttFGy4a5R1Y?=
 =?us-ascii?Q?TuJJFBPBm1xtB86lz93UOu+LtCWo6R7Ul7xa2N5+YdrGV72EEo9bJRPGtXMl?=
 =?us-ascii?Q?ZZisAUcnZBIFFv7dc5JPKwwQ9GDPtDfhBIYzdY+2Vv7NOlQt4WpOl8+dc3aR?=
 =?us-ascii?Q?VSE9Db8ZKDslSw4TFiPK/NxTIPHB9SA7LA3wx/3T+F4uSj/gSP0HF0YA1WkY?=
 =?us-ascii?Q?cF1AvqIK48a1fpwUv1y0bnV8Myoz/UxoWFSnZthIsPSIdZtARoJfAe+oxPEd?=
 =?us-ascii?Q?zRyNSADXlQqRa5zSgI0dSrhsALM2mqCn9zHfCODgjSrH4cg4li7/pKxdrCSH?=
 =?us-ascii?Q?ANZZRTJyIzhMGxkGAkL6UZL8FfqqAq9xNqtOpcqI+BiZpsftVUhtaT26eEsk?=
 =?us-ascii?Q?A4E64SDSPfA0l7s/b9CwjTjSzOZzq0WOOCpN724/11hsmvopeu1R7+JxNO0z?=
 =?us-ascii?Q?vBxhfZSdk1gMjhylFigLvF8OisjlBe+te4JXQwbtrIM7v+BdkRghjkp/XPAf?=
 =?us-ascii?Q?G4F6+3qfxum83lK2+Vb5R1yBBPbApixu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7X1mhpuK8mheqhAdYA9h1FIQRN8MB/G99TKU/H62w9MoLAB6VsbY+gBNRSL?=
 =?us-ascii?Q?QhjYYZhDqjoCXVRJCJNaWciW5WJF9KfVu9MnPFIJfHSy8ljGzT0YUPlJAwTf?=
 =?us-ascii?Q?LNJqS8/81ZfcNGT/6srs5kWR96Tl/ZG3/6PU/oWpa34B6DtFwGRLVl+lQgWI?=
 =?us-ascii?Q?OWTPH1pGtFFlcS0PL80VsGa0cd0C6qMYlpQU9l6lVhdydmqISbC9KLnlbmzC?=
 =?us-ascii?Q?k7oLcJTFSIt5p11ptvptuMjvzXz9vw0HmJg4c1UOnC8pXQRTYTkBVA9+nbyJ?=
 =?us-ascii?Q?EfBHegtdlyTDQQ/caRb8Em/wjKyuo/RGmfl9MN2stVm67YHUStJ6IwDH6h/E?=
 =?us-ascii?Q?X9owh/a1M0iWDz8B1HkUuZeLHbOhrHLPlapfrxmvJQo0B7PQyE55Jy27A51F?=
 =?us-ascii?Q?+Sux6rVW29qUbuQgJBSzeVwc6TC8ZeugC2I4UAuNNsiMkv3PLJKpXF5FyMfs?=
 =?us-ascii?Q?/5NIvV2OM6kKlA9tUuYf0gVGr9a0D0J8GWEm3JWAFAwHL0N1F3dgXCWdE8e0?=
 =?us-ascii?Q?Z7WCXZddKKqoR7Mzv0abyryWz8oG6MfVslHtkNDm9vLz9yOmoCnuHE3mHn+V?=
 =?us-ascii?Q?8RgjiqLppigZw1OvMX16TYdOAQTa1p3Fn/l4DHrX9blCflrdmVqGAwPT9duT?=
 =?us-ascii?Q?2Rf6R0l6OShGuNfpJzOARKeoLcMq8QNkxWxVdaGFMNlYItkN0gsBdzn1Uluz?=
 =?us-ascii?Q?HP1LEMT2djaFik7oJ+cGcMIYv4xFTsd68fc38p/hif/s648olkM4jHN5NJib?=
 =?us-ascii?Q?hXfIIVgbDMfUUV5GWgrWHmGCPMqfdtpMobalz8c7Gq2bbN0RxK7tRjVmvcca?=
 =?us-ascii?Q?eYjhRSjb2xA+Q3rBeodvFCVc33wsI0ZPlpcp8k7qeY/kt1xXvZkH95alxEb8?=
 =?us-ascii?Q?Ovhqf6Svm2iZwe1i4J+gYlCsDvqYxkcM0IA+eIVWDK66XG8e1tbnDq8Gk6/O?=
 =?us-ascii?Q?xm2/Ye8SJEXrb39jmIKtxrKnEQRspOFeGRKlndVeTBtK69VeDLSrQFpZGt7J?=
 =?us-ascii?Q?I+kI+MwUYeGP6tcG+TJ99kr9jrw6EKgdLDtTaCEGQzmzHJW5Nd+08Nco4K0w?=
 =?us-ascii?Q?xsehYF0ThFkD/ZKt5ULXWOvJu723RLyM0mK6oZgJ2iX6+Bvdcw9NrFxeFjw0?=
 =?us-ascii?Q?XKXJCx52gzYpuoY5Uuxh4ORT23iPm6ffvydVK3dHc2gbKCXvYvVbEyRuCCdt?=
 =?us-ascii?Q?c8Ih5pDV9oZe+H+9M4u8MgzqDszA7dEKmb2hd20RqK/pD1PpfpeWSdkgVCFt?=
 =?us-ascii?Q?bNQg39YsyDTmo1g1ZYU2thysbDNRKLvQ9Ki36N/WsfpOCzd6mTH3BWZXj2Yf?=
 =?us-ascii?Q?QIx6caI+BFDzgxAxbYGujYNIv+DYC64v+NmxUkIa814QYDh4Klxzgso36qwy?=
 =?us-ascii?Q?TfOVICcX6+oJhNDkh1js7HSroidkI541xzr9Eg9hZm1s0RLM/UX/evaANR2r?=
 =?us-ascii?Q?GxprmSbLTXwrRQt51TsMsJ62gtv3C4DEO5cMaTDqWIwGmqUsteRG+xxeD/f8?=
 =?us-ascii?Q?63cpQmebqP6lHzG2R5+nvq/h0fbT5/sqbpfmCXCsYztjhHvJfYw5QajNlqja?=
 =?us-ascii?Q?RC8Thwf7/QOuhIVBBcUSYQHeHpSke2plh8lBMBt1XINvcEsmW31ru3XQF2IT?=
 =?us-ascii?Q?t9H7eBBQRchxV0M2IpK49r0=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96720ef1-cc12-446e-af29-08dd5ac221bc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:13:19.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBszSo4aVdweWTdCw5aBCMn0oZe2I8ahUb9BKKqm1affSL1h3I5EOiAYbWA0uyym5JFicxtGIIBIRIT4IplZQZKrSK7XJVdOlsGyCidXWwnvqzu8RXNM2VJ9iaFaEGNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

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

