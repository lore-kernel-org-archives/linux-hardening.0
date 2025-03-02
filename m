Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010056.outbound.protection.outlook.com [52.101.228.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB661A270
	for <linux-hardening@vger.kernel.org>; Sun,  2 Mar 2025 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740957417; cv=fail; b=PKsYINCP+WoWvpMdeuVrLFCcV8LUmtXJRTzkPW/8Zxp0oPcNia1iJMs1Iq2TGv+hnKuC9pHGNX04lB1yD7C4Wy/RihhcqcxadtYK/j9f/ehCAlFdmUg3R+RPpYr96M6Wj0g9f8M0/oybRkZGKyp5LCrfwSryxVtwrvCXGFGLFqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740957417; c=relaxed/simple;
	bh=27yfmurN87wIIsRdQC1nXhBAN38xieixWafWKLpEb38=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=rGqkqZ/nI0K9rbU6lgVri9cpwajruUf9ZT1MvdaLHVFd/LfqjfTkFLKSxbznordSrV7i0znsX0HyEGVDtrdGRU35EOd0rZmZF0RDpSfhLaSfRebqWj9di0Owi98zUxfw5//a9hOOo/DTr1iB5tcHLCb3DWES7O/sNucb3aTl4lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=feoeOUXp; arc=fail smtp.client-ip=52.101.228.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="feoeOUXp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsSF5Z6EzPJ3xMMlBfAtp3K4TRiJgF6kQkLnMDuwGPAfMzH/1rHY0kcOXICpehTc3KjVMVmHrqepid/rqS6vgIBzF+FgHQE21MPurLpqV901XitySbxw8yNOh2nu7iqUHfywlImdugzUCN1+j9B7AdZ+Kk7jcw0119GbAE3OJSrNIavhrocbYeS8MCV2g0ZS/wMvyoHK/lL/l6dqN9l+v1yN/r021vDrKnyLP2slq2kdnuhxzGp1n4CE7C49tItXrspVTVMxxCFsevbKJCdkmar37NjX4I83x90XrnrV4805z7mPY9n0kbW7jnyxfLG/Wjd0iLUa7BFZfsNUxBwS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk/l5zCEK3p+7DAXmNfxSA8ytBbbSnRZ055NgT40SS0=;
 b=r/Q4OQpi/xYqzqB+4EfxVlgJ2ofp8BNayIFvcrkzI5UleaAzCA1tywKCeIaHqLPuB9krIT8EPfQUk3BlBu3D9ZYTGLODuH6MIg3KOggWt2V9N/C1AauRo99BTuzEQJDo2U+RGMTqtsY6Aj+UwtnjwpgylxOKuYcvZXvoXWu6+2FEutqdR8yYnKjEqTdr3sgNiHSsOMesvmhFxirIZTdeC1UHlxWkutqVAJIgda8BtRL2IQdsVUhT0dsmsmjipca6H89Us3yrwPNYE4gnyfqdTkejvx9TxZcNyzUwW2cXTOdQaOoPQ2F8GKndmrYDxMY+on9FaPiVzsUfy1Tw0Oz+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk/l5zCEK3p+7DAXmNfxSA8ytBbbSnRZ055NgT40SS0=;
 b=feoeOUXpzcAgGin1LTu1UbYSm91sSDXVXk0iSfu3+zzENpJXHEsmPrm5NTvzeC3+AO5kT96uVoU/p4H9fviHHJOwbd4JOGTRzHE3kNm8CXs/OUew3Zx6CzPM4ubzGJsCUSoBj/G5CQhKV6/eYUJxay3UifDWA1MU/LqRLATedEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB6118.jpnprd01.prod.outlook.com
 (2603:1096:604:d6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Sun, 2 Mar
 2025 23:16:51 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 23:16:48 +0000
Message-ID: <87o6yjyqeb.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/10] lib/string_choices: Add new helpers
In-Reply-To: <202502281143.149423E53@keescook>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
	<202502281143.149423E53@keescook>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Sun, 2 Mar 2025 23:16:48 +0000
X-ClientProxiedBy: TYCP286CA0211.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::14) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6ccffe-acad-433c-6e2b-08dd59e04ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rm1Jn23jDEXHU8qE70ZN7PncizMVqGyXNvbIQM/JBBBpcdPx9D2vh+vrSN1l?=
 =?us-ascii?Q?GsgmQq6U02nXDyS76S+/ziue3xUNFhitONX3Qw7TDFaYp5wc0Cd9yFhWA+8w?=
 =?us-ascii?Q?DPbrklhg1nSXTIgS7RJ9t4kLoZjP/pkxzyG3UcMpCYd3KkTa2dft8d/kgOPC?=
 =?us-ascii?Q?LG0Iz6q+tFRiWhjRv4HkbHCd1UvWaXFLU8Rs3XOEelzZLCHHgvHcY3RQxE22?=
 =?us-ascii?Q?wzv9b8pYT4dy5qsuSeIthPgKWbkQH+4exbw4rmvkSfwU0KaXuCBSMg9sLiZC?=
 =?us-ascii?Q?z3joUmqMVKf50aaMI9ZOxY3aK44Uk9C4tr7ILbHSZWyGM+qW55u3KgI0XX+2?=
 =?us-ascii?Q?UiINC/e5I4c/MvVfC3XsvZcxx483Q/WTo82vPACmxZSXGShrMHbg1AjCAzXw?=
 =?us-ascii?Q?+hDD0TE5OPHwaLdzNEEZNWZudMvDOH3GqJXHnY8/1rIwTkMVcEknF3Ck2kDp?=
 =?us-ascii?Q?5uPH4AYyz2ctK/Bn/45IxZgYV6iObzRfVYRyHEAjuYpP9YUHO4q19hwvWEFX?=
 =?us-ascii?Q?E6C6aoelBHBCex26nJMf5NLTJlyRUCMOZ6iixVi6qD/Jx0A77Zd9m6FhRGd4?=
 =?us-ascii?Q?PA3XMlee/irQzS0IRKwgPE1UDN4PIb+JWueDy07/Cdkin4oha4cleh/hWAqV?=
 =?us-ascii?Q?t2RFWnezHWkqSLPN2Q0TZ9U0pyy2QutN+F/JmJXbNCTdhiVicLftKsBB1Sxk?=
 =?us-ascii?Q?hpUq5ruazbzXOcHUzUl3ZVf7mxWp5sVPuf6nnYJcIvvURxrT8qhGXLRjUVyT?=
 =?us-ascii?Q?zn9eZTGF+7r/sqy4aOiX7dwhj/h7jIzJaypERbf90fwLE4/PH/UQMfENeo9Y?=
 =?us-ascii?Q?b+CKruW8nGjdnikpf+/5IEPw2yrinVvyCSeTcz/tLsNsVB8R0OTMp6Z2j8oB?=
 =?us-ascii?Q?yclbaO16JPCiv/zS/CAqJDnUez+lqBqm4IYBTNP8BAMSPoFtHGqpeonKO1p+?=
 =?us-ascii?Q?V9IQ0ZUWko9jLv4q33OGbbABVCtv/2Bz3/y1H2Yg3giUB4XLLvazQRVJMHnp?=
 =?us-ascii?Q?UVAHbEqCnMxlAHfx+Mi2MAZ2914XOnm11/VAOV1jUM6vHxukYO0AsZ8i//2q?=
 =?us-ascii?Q?ylFjJNEIrEE4jhYh+g0F383NzEx7AIUFne1Lha5/Lq+Xi9/xUxNoW39TLY1S?=
 =?us-ascii?Q?Lc0GEuzBWVSUfIwIckBk63zQHrInv/3NYMHjgxKfD6TF6Vn6lpA5admBs2Wt?=
 =?us-ascii?Q?1HDk7RsKOjPAH+H7Wm+cH0OupxGkll5dcogAbU5QFr0TTHU3yRmo8xL8+QUc?=
 =?us-ascii?Q?VfczTbRvID8/nWmjknsZ9p3co1vkpsm+Z6hbIVf/3NIHuO+GsPv9xZfpkl59?=
 =?us-ascii?Q?cZKpZY1KnB+1kf7CMZJYa2H6ekZeBVDMMvq6ssjApofpW+HN1apPRgOiBf7k?=
 =?us-ascii?Q?Zl3b/DNaT6QNNRYQgSwdqLGnFpEkbyt/xUQjBBqCQ0H8TSgB+DNOst3lWRkF?=
 =?us-ascii?Q?ghqc6miAvtqvaKEVJUz+QcsOWP7HcNHS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I1epa9MUgFBj9cXDDAB/SgnnXyn/GjSJE0ObRDhGCgokirT26z9hCrZyy4lI?=
 =?us-ascii?Q?PnteM1DD4wDjcHG18Za6fY1Yi9xW6NMJJrNXaB2wEilsPgkW6Ds5jFcr9iBr?=
 =?us-ascii?Q?KIw7nMDSoHpzqz8dRkRfhmQEma8/d7h/jHOIBNmG9CnkPs6gk8LqETtX1c6U?=
 =?us-ascii?Q?+nzJwTlrDux0M1grxjSUkp72PjYMjp3OlKOQqQpWi/TlP/JjV/hhX/ufsvrx?=
 =?us-ascii?Q?KRVa6P8VYKpTyMnOYCHdFz1NrIM6vIftnah7wvkD0W9wN509qm9da2XunUE/?=
 =?us-ascii?Q?pjusMq/LRSL5GBdhRa3BLxtFef5iBzhwwty0uKbG+blXsnS5zON9vI9uw031?=
 =?us-ascii?Q?LekBogaJ7wQkGmJAOGQhcP2vTe+d+h62Oj3eAvUcajCa8Zx+CnkZ1V6balho?=
 =?us-ascii?Q?Rph1jPTx3pCXSfeenp5AKqtANs4LF3DBCcnC/gtyG6n+/GnSbF2by493LP+u?=
 =?us-ascii?Q?vJrjGIBz3m+u6GgJ8x/VfX8gYCbJusO7YPNUWfOBFkTuClmQTuN0io7dsRIC?=
 =?us-ascii?Q?5P9wl6r/vlCihccqN/0BpqxkiLOJzNGETnQDgtsyA9WveYOIC1VMn8Txr/jg?=
 =?us-ascii?Q?snglERdl4fbeYfvUpPLgsWexLlGQt82cEZfub7wfmSS6WgaytZ6uWhIZ7GKz?=
 =?us-ascii?Q?8tB5TdYSUtEDVHKV+4JDG5D4X8L6rxuXZGxuqGrZLhzUv82ulIkKznGgnFCN?=
 =?us-ascii?Q?wUI8XFOYysc3Jz4jTMWhYlhhMpEoVhLuVz2g2XIDwMNkhTmkZJ/+Pcj+7aJ+?=
 =?us-ascii?Q?h6UgaUtNzJqOp0WU1JtXbAV8k9jlSgxM4WE1wcqFV/aQbSrc0fLlFTj0Opt9?=
 =?us-ascii?Q?/LD4pS7iyHK9aKOyd0rgytcwxm0+Zu2e52pZaaO6u2omEaVhhME8zewN8srw?=
 =?us-ascii?Q?bH5vHRdpfZimQT8sWoTexhAx4PyxuygLn3/Jc097Yv9yomvUtXo/p60sJ0et?=
 =?us-ascii?Q?lyYn4x3ZSvJey7QGfkb1i0K9CL48FbXJ/VVqXpE/3OzRYTMU6RW+LQHH1Nvv?=
 =?us-ascii?Q?6VDmeu0SHs6hJxp9aMiEP9vOakyWxUnIXfGWkq4EHeFbtV+YR5O/7o1UJE/U?=
 =?us-ascii?Q?3rfU8A243oQksz+QSmgBl6uD2kTbZlefrWIffXn7JZ4GFjvEJFiVgcn/Fg2m?=
 =?us-ascii?Q?HfBlQ986xc/EUGYX9sOGafI/mpiLnOP3VpbZHd8OHYq3cw8+E8nldy0A1JXg?=
 =?us-ascii?Q?E6jTqYUz7ZoZPFTNv/EQyrnoxRv4JGMeQAnpHXm72tLPDibIS0itSS6NLcb8?=
 =?us-ascii?Q?ypP2kntNz+O0ymC1Yv7xYqFnIXq+jiq3DXmlGRHyxEklEHEkSumsymP+ZPm7?=
 =?us-ascii?Q?sjoERM8IhQ6hBoovGfOl1Mc1gSl86XCcrdjQWZxLcscw9ACXO7MbamZw+Rvv?=
 =?us-ascii?Q?1R7qZNC6M/a5I7U74s7N/ECmfyxb/a3RQ18Li/Uy6YY/8pghvTWueFMvAy13?=
 =?us-ascii?Q?8iveKtVvMBPsL8OW5FUDE6xLqtPnahIZdYGXw9mFzChEpr86+umXZFsCTczB?=
 =?us-ascii?Q?GAXqeNeeOpN6e4S/8k1Ng4htPkWLBgV4qdAwdwcWADZelcpdb5JqPTPHRv2k?=
 =?us-ascii?Q?EAioS7RZQX/1HLEBRinayMxwopDUIjwuMd5MZ2zzPRGnMS1XLkQw9xY2hN9V?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6ccffe-acad-433c-6e2b-08dd59e04ea9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 23:16:48.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr/9+aQGSY06RIxB/Asz+GWDQSFGU2Fy61027ZljkKWouWxh4bt2BCyDtiKADyJn3Iwf5CKKmP4m4c5Hy7nVEeCyuydiFDwvxRUvhOc7cfOocfrwXIYbU80/47jO5PYZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6118


Hi Kees

Thank you for your feedback

> > I would like to use string_choices helper to cleanup the code, but it missing
> > some of well used string pair in kernel. This patch-set adds it.
> 
> Do you have some Coccinelle scripts or other patches that show the use
> of these helpers? We tend to avoid adding new helpers to the kernel
> unless there are active uses of them.

I have a lot of patches which uses new helper functions.
Because it has dependency (add new helper 1st, use it in 2nd), and
different maintainers (helper patch maintainers vs each driver/framwork
maintainers), I have posted new helper patch-set 1st (= this patch-set).
After that, I will post 2nd patch-set which uses new helper, like
new helper patch for v6.15, each driver/framework patch for v6.16, etc.

Because there are a lot of patches which uses new helpers, is it OK to
indicates some of them (as sample patch) ?

# It is still under compile-test on each architecture

Thank you for your help !!

Best regards
---
Kuninori Morimoto
