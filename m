Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010068.outbound.protection.outlook.com [52.101.228.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1041155382
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054395; cv=fail; b=ouZQAilRjJuYcpUmCFycDbS/GiVd5adVMc+EqC+JYgrEHzvuVfv3yw5cj9fHExZB0JcAx26Y6qgvzmJbkuVCrhA6CHbNmkeeb8byuM6hQCr0+vJrI3OwRgKqL4qf0xjIGuJzrHMe7zzXzaY7W5wa2/ReltMtr+6nonjoBS47vZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054395; c=relaxed/simple;
	bh=q/A4q42dfiY2URQ/b0A+ZYbdX1QG2FaeWJdBjjGe+Tg=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ED2iOLronMgFZosJQVbsmQqKfhgmE8UYN6vmRfEHkT5EiUeGSmejhOP7cN8KKR6EDatCb5uF4BJUMBrfB6h+zXWNFnUk8XYHJgzNKaXfpXa1hNVZrajado9qL7l8mw4yqm3pVH/n6umXkZflcP0kGin+Mr3YAM9JzfB3ah6fgzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=p8DrrJA9; arc=fail smtp.client-ip=52.101.228.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="p8DrrJA9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzjyMykVZTIukpCqWgtygVReZOJHqzrnNIxekGglow4dXCAeFDO1KcHYj1Cg8fio6NZ39nao3UqBTYhdQc3D7dT9L7+iRIR+iV1oAikKiGhJtd0X/z4ipL+Rq/crKRyKcEYsF9nL8FyTspesm0dgHPQvYeR3z2+Q8hWpErYbD2pqlaEy8bbxCmePypst0TCPa30P65dtwvQj/15CVooTBOJpEBpd7HSaXAFyeX1wNu7JGXpxYkXU6QX5fjNZvYtfu0bmZvUOJE084si7+I13jfL9+QLYh5TB/uadf0NwQEC2oCJTJAJXTJedPKqQow0okjM7xqbNJnx+LGn5zkeemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNivsdy9VsF8FxqubzjVSYSM6/R30W6tx4YwLj1e/Gk=;
 b=T+3VlExmEGV/hJZ+vLo6ITMOqyvIq/RTtt9phIRMquu+J1Q4rJEf14CvO/seoZdgm2vqXK5VAXQTfLMIFw9SG/+risrMKerA5QOJ1+jjgwsEIhdnr7DQZ0eZrNqkRSEmANLZsUallKdV4NNEqZaAOK3kf0S1CfqyvluASpy4Dg1HbslLd+1AqB7ICAQ+keWYM/U53rL6k82VIygl2QxbNN8+8UsjmvX0H7zq/S1KMjZkMSAlt1vdv+Hmmp/C22cd1/M0BmNWPY8TG0PROvqclU3O02FY1fRI1zTv+eZTUtywjZnCxCwul75pciN35p5IF+iguMTHPyEHbrctQva7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNivsdy9VsF8FxqubzjVSYSM6/R30W6tx4YwLj1e/Gk=;
 b=p8DrrJA9ogk9ZjAsce1V+rmIvvumtt06cHS9DloRI5IDPKGIFr0TSrRUKZfAbN7FUltb562V3ADPwXB0Rsgr0kmsFbClhUwYaoGUTEQ0Eb7dm9ZMMUZUsllOnly04fob3LGtzJRpr916m0NpOTnDg8CG1YejZye0S6aVh7cy1vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:13:11 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:13:11 +0000
Message-ID: <87sentpmq0.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 02/10] lib/string_choices: Add str_enabling_disabling() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:13:11 +0000
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a72284-75df-4b9b-f960-08dd5ac21d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8vlbyL619vt6yXCMvzYVzYgpJ7BQRNQMx6xrG5wEiTvxZxabVoKOw3kTctL0?=
 =?us-ascii?Q?rV1R0Ufu730ZchyKqie5vCfT2cbIxIkFIlwev5at/F3C12cdudgTeiEwzled?=
 =?us-ascii?Q?kn4Hcu7XC6Sde8towWRMKQBzV8aYFQITZggJ7yL86Idy5xWbP5HO3o1lHGOd?=
 =?us-ascii?Q?49kCrcjXo+8kF0OQwIzYDqAlQ5Pvql0zpjRxnUL6cOfy9LcohT09CrOrKUra?=
 =?us-ascii?Q?q/olNYKRlXBowGtBRy5jus3jjZaDelW5dr9eRlfF83y/srsD65TSl7ZuzURh?=
 =?us-ascii?Q?0XasI/JG9oACXWi6Z6+AWvNtRa9uKWzk30sc54sFu/PS9fVk7VUWu/mh99Ku?=
 =?us-ascii?Q?AhMwnFxEcJ2Mm9KU1e9CHPfusWSlFjDxEUN+BDTWDaHcLBqrRU3nCey3hrP7?=
 =?us-ascii?Q?C/B3t9QFkJPH6jeSVWlUxpEXDj9dDyslG76YOWdJ8LUNPsFinsQMZ401BAfz?=
 =?us-ascii?Q?lUSv9vnPywmsQwdJTqHJgtI1ojMM5yBYhwQz1Fu+Cj2DogN5ujDCclEdieZo?=
 =?us-ascii?Q?+wuhqrdR/S5WMsXpH+z/B0tMHK++s4zBbRiKNfCYcxYoMFjvig+8ycGPzRn7?=
 =?us-ascii?Q?DVl1WqFp0DX/USfureeSa6YZsDwio7Tl6EPYpLpn/qxfGyVmhTbJO9Ab6ERV?=
 =?us-ascii?Q?xpDrQBIYjZc50Gom7NLmbIAhCL4cYcGD7CfTJO78O0giF/WVDdDl7pfczpdO?=
 =?us-ascii?Q?ilQi82bXp+/SCfcR2qwaqnhNUy+pnV/sLj1VKwUvlsjnhXYS0mNmLZajqlqQ?=
 =?us-ascii?Q?S9y30jyUZu4c+NtGg3NDgjiA9gbCaq4jMExzoPt+mUIP8ZMX9Q+EWvmg0tD3?=
 =?us-ascii?Q?nVgWMmarGg36HZt+b1QvmDKqTWKF/X+et4LwKvF0IH9vsrEzHoaVEFCKBGNB?=
 =?us-ascii?Q?4ceGnJYDdpRKl3ceVTE1bdGTzTFH+86hbGw8JOEFqpndRy7nG9gCmfNhefgX?=
 =?us-ascii?Q?hE7qd69U6BCFLHb9YGqYxZaCTA/RrdHlHntW7FFU3dubOFX4M7jobsRGs+t+?=
 =?us-ascii?Q?5H0riXibBhcm33QSobk8KJMZsnrT93zO3n+Wl7lFBIfv323nrepS2YTync4i?=
 =?us-ascii?Q?QRfqUxLC1ggohDd2AmUlTNhlGzj4wk/Z2dkXCtvBASLI0bWszcrnzVeFB0Sj?=
 =?us-ascii?Q?GiXEyBxA5SuN9UTMhlNAMnKMsQ8Nm2hlDIIIvW/5a7bfAaegRlFmq9KBRG06?=
 =?us-ascii?Q?sMHRuYDUf8gW/Qe3qULPNWKOZO1yfx7Xcbts4ekdXNucze1kKgbnxiH5HlvO?=
 =?us-ascii?Q?0XCnHSNuo+MI1RON6fdK+QvqixKyYX/OSLqPAzN4BZE98NRXNqXLhkgESRTY?=
 =?us-ascii?Q?KE5wUNwl0jB3qLMUkA0gCQcZ6zJu0sTwTyAvWu5+7uLkDlKkt13gvECeYL0t?=
 =?us-ascii?Q?lxnboYJCzSnRVI3iG2t0c5N0iItROi0M7tlzwK4o+EV9vFCfmDz9ZVesY4oJ?=
 =?us-ascii?Q?rwYf4lspDnHac3NKY2EccnPQ/cEDfT/I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p4HZ0NrSPJ35lOm7HlVQaNsLwpjosCXzg/dATX2Rl1xmd+Wf0+sRuV4ar8iX?=
 =?us-ascii?Q?ewPkQmrR6cJ32UeNdeXYRC9VkdnN41RqNuwVcXVy+IvMvQR9w5/6PLPdislb?=
 =?us-ascii?Q?DM2YlkrFTgH+bxtLnNbIh87Dso/4rXTnfAXmfgy7NTWGQk56iazkrZ/WTa97?=
 =?us-ascii?Q?1bDbtIVpjs6rKHWtN92xXsU7+oxsjh8fKlvVEbLFUsYS1mFT2wRUv9TZfMgT?=
 =?us-ascii?Q?ptKmsN3gc/Abeo6h0DvnTusHmGfMt2PWYmTj7K1cErL+Z3QVW7uQPGWDObsM?=
 =?us-ascii?Q?YJ+YYTbypN5oa+hCJ6uWVvtJ1OzunDdtKzzZglq0N/BwabM/nnOCyFIM86GB?=
 =?us-ascii?Q?ITu3SRAjF1r2rVkMSaMDC6eQ49qfCDAzgiIQAV+Di952hMCXXsaJ3exHAv+u?=
 =?us-ascii?Q?PviqMG26cxfkBQ+TnfCNTsCZxqE7vdD7HsbclGTVynKGVh8cGCDsz2omozoU?=
 =?us-ascii?Q?7OKoqGSJ7zgoZWxUS5tBrXhzkKRGtzUQRgMjnhuO6X3wuOJtkN2TNFJDDFDO?=
 =?us-ascii?Q?GJHd1A8BFmdfx/V9r1YGJPeI7q8USGtmBMsm3h0wPI5zIATwYhQ/ll4ppBUA?=
 =?us-ascii?Q?uR4loOb09SKH4dRjm46nqfGCYjs+sCBzS4pPtHFt6ZzEw59noI2XU8EsZzZu?=
 =?us-ascii?Q?cyZ0XEtkVOh9TqgV1HI7s/VFAfoEhLivn/gKm14AvX44fKfzVZtNTu/Cu7+7?=
 =?us-ascii?Q?VT8mhHOaOb1dJY8+DssLoC5rAP+LjEnvfatZYb1bpiwwwLRiO+r8q2OQyGTI?=
 =?us-ascii?Q?gdvVTUnN1Q9MltpQ8TgR9DxEya7g5nYpg/bbD8/yJllhQNCVK65Um8hu0k1o?=
 =?us-ascii?Q?7m1uU+IB42hFGsW/gCjbq4mQWUzh2NBDAu3Un/XEbx/ypUQSejS8zgGsFjLT?=
 =?us-ascii?Q?6mV2+PBr99a2OIkbk7ems+HsaEAQRmgYuOcOk2bcKuU37Yl6EB4BCfjgTat6?=
 =?us-ascii?Q?AF/6EFDS+kkPovvWtS0FUZdKBzaSf6WltUri7ZZN3XufiuOEhiZefOieKoYh?=
 =?us-ascii?Q?vVH+mAJZYQOYeyPmBHikyQ5h8pM2i+YL3RFmVPJQ0xhVhPXwM85yTHWAwbPp?=
 =?us-ascii?Q?iDXX5NT20Ssveeva1tPbfDfypKT9vPHwBr4mNIeXbEQrMwMf6iTRXTs8NVG2?=
 =?us-ascii?Q?CiH0PfUfYoDfyvHN5C02u3jwgKM1PKAXcVcTBi78ArpXn0ST0AJ7EtBcURAl?=
 =?us-ascii?Q?m7JQhZl0hIfc2KAMSSgETlEohhzQfCbu97tMpB+tZjF1nhTU9JksHllIMddU?=
 =?us-ascii?Q?zoTDhWxwU3YeaUE1T5fJvI2XqpRdfjVOoiIhwW22pgZI9nTk3PQKe7OoCRZC?=
 =?us-ascii?Q?h7dFIfCk1UzKn7q+7rNkYOamJMJjM6PjDvnrEI2yUF4WaijPiI7Ce2OXurSE?=
 =?us-ascii?Q?nHTEZ+XeAIX02197Q7ycfKp4tptfxn0AdNGyPJv3h1aZLRoAcIUYHX1ENWSe?=
 =?us-ascii?Q?bbT23l0KXS9JkyyrpT4VzJcjWybk4hal1xXlkno24yFQc8tZTl1/1Q5KyQG4?=
 =?us-ascii?Q?bebSoF2cvB6PJnlisQEdCvS9zlWIygOzW7vF6PyeJO4VmXMqhiHDIroBSnzO?=
 =?us-ascii?Q?p/i6kT82D/CqIK1oCm3GobppM2YP8Y0R7Ee0R/FOWxOdZYTdlNwTg0k9FDux?=
 =?us-ascii?Q?23VkzV/OwQKv/UvfLlSbcYc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a72284-75df-4b9b-f960-08dd5ac21d07
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:13:11.4862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+LfjYmHtkZ7UK9wk924cxm2A9aom+FNv/whfbGMVw6pkkUPMbsQLlw3L1I6CePdJyITb/9sTygSom7RSxL/uzLEVX/9QY/WiXNbOzNzR22QSlB7G0rJvOWsl66zjAti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

Add str_enabling_disabling() helper to return "enabling" or "disabling"
string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index fbbf1e657806..2a6c8df585ea 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -29,6 +29,12 @@ static inline const char *str_enabled_disabled(bool v)
 }
 #define str_disabled_enabled(v)		str_enabled_disabled(!(v))
 
+static inline const char *str_enabling_disabling(bool v)
+{
+	return v ? "enabling" : "disabling";
+}
+#define str_disabling_enabling(v)	str_enabling_disabling(!(v))
+
 static inline const char *str_hi_lo(bool v)
 {
 	return v ? "hi" : "lo";
-- 
2.43.0

