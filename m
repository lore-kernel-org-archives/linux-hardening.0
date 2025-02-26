Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010058.outbound.protection.outlook.com [52.101.228.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872D25D55A
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548192; cv=fail; b=Wz1wS8CsuSAirt/kYdxX/Huq1syseUI5lbSNJxkFFDyj6Lrk9749G+siKx56bHL1dV9uxcWFeVXGC08Z/kJwsYUpT6pyhyARUB6bpdTJ1yVFd0K1T5YSG9v7cPNyF4/P7mylC+TDQjFpYMJliWmOo649xhktTrynj29f3/ZAOSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548192; c=relaxed/simple;
	bh=oowD9iNpWsI/yqaVGvyt8JTQP8/BmwcUkAqcQICtz/Y=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KiXRSYxRuu8i18ikErEBmf6NKfubE8rcigC3V/Err4CezUsvgcuiOZWRWWzwTZH1duVpIw/xRjuK1wxGvud9dw2NjVwoIvoJIieSL6TDO7tuV5Z+CzBW5CzeU/ENPvqIhM3GMWbcN40fZIdwTu40+9CIst9piqfJXfV1YrZIQYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Yy8nbvS+; arc=fail smtp.client-ip=52.101.228.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Yy8nbvS+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbYY/G8IQlXGKc6TKo4rtt6RW/mWvYgCmxOg/rRXWm99i3olfaylAnBOnd+7pMF56FS9wI8+TDF05YV1IH7hUWsjdWYctuOS9CssoisFe5V2k8fEc+ToCGsD16UKI2AoM+8Lf/mxbvaH93NrouFz4Q5dPNGJu00A21ag+RdUqdIobQzmhYMbWkxXzL4qoB/Veu+5G3vyMyegF6nI9Sjzc7vN9W+IFbHd5B9aR32W8PsDb2pTHAUV9vyqC9E68RQaJ1squ4qNTcVPs7c15tguLds+u1P3II+vsrljraoZ7Xre4CMH/qCZBQgd86zwrEQC7vUxuGJa5vz218//ouS+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9sgA8TYYOlUt7suDkDrmwuZTF+NpaHkZBliS1pAKRE=;
 b=EJNmf/nYmFXda2gkqkIVn2zyRfjRyQ9EEglphubJyKi/TIUiLNQkIsZXYKbm/rs9ndDPp2DCUYMyH41PGJlJVptJPOTnjSH4j/oCTtDFEA4xNlXyXOCUCvD0S4agFE+c6DmwO/dWvNKZ6Kqh2qwSmHmJUHebdzE/pGZm/qiMRvlDCssahNuNwb0e7sa4sn0KSh9nIwGQFQbKC9lvTyRPAMGpeytPpKKzksdq5oEWijeUPcp0Lr9p4LIADzXzjBYrc9kcnMLNMJNtm38vjXNnQRxXtXHO1cZPCtWdy6teVtitAZHfDBIDFpKYQkE6LKUo7dGL0cBAC7PfTGW/tYDosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9sgA8TYYOlUt7suDkDrmwuZTF+NpaHkZBliS1pAKRE=;
 b=Yy8nbvS+QsnhSJoBpdvfNDDr+9LeWa1UrNyYWi0+jmEVTx3N6q0gz/A72vaEt7br7UFsTkJcBpiVO3rP1zeVMA22ZyzUd7TyKcZ32GFTzamYbQwFLwtmkvSzNR2SPKCLRsQ3ALJscyoLa0IN3apEstKmEUeBaM61SeXZcWjAhxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12800.jpnprd01.prod.outlook.com
 (2603:1096:604:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 05:36:25 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:36:25 +0000
Message-ID: <87ldtt6zdy.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 09/10] lib/string_choices: Add str_kernel_user() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:36:25 +0000
X-ClientProxiedBy: TY2PR0101CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::26) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12800:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aca1bcb-ec29-4293-3d33-08dd562782c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AEtRPhXaK3jsA0RPf7OOo3e0A7mVj6ILirp41B7m/s7bI/ZPMI6NLUS5bdp8?=
 =?us-ascii?Q?sTTVnjdcs/gtMRWUCZ5fRVGh/QmepPJKPmUoqZUBDEGHfhLZq1YsBrhulGj/?=
 =?us-ascii?Q?T3B5/XYb/0f1w0k+0i+7Nez5ik+JSBOMSgwdTBNB0rGjjBwUDZdeXt6Sjelr?=
 =?us-ascii?Q?4FYtd/rXYHOa25p6z7JUHOmEW+I7Xfk2R5z0jpqLv1n8mETPzbaojK/+whKk?=
 =?us-ascii?Q?1tH+iGA3jOdFNAbPHvsi9O5UyJq1f6Cuplm7F7xjrBvXWeE/F08ooW7En2Kw?=
 =?us-ascii?Q?yOD9r0fyJjvjhZTI7B4T2G1j8RuL2yMdcpAZCAI6ixTxQzzyxYXI0a2exwil?=
 =?us-ascii?Q?1188eq6EqiDwXOT7utGHkSwPG8tGplYadw94rZ3+/hR01HhT+lHiCwF1T50h?=
 =?us-ascii?Q?M5QryP8cEV7/85W/j+P/SzosTKHHCSHR6X/tkM1RLHnKgR/+y2AQfVml0vZR?=
 =?us-ascii?Q?TxsKfuygXac3luz4l094DhLqMCf5JCPDhp+/MOpSV5sc3DlhWMijahtl6H9n?=
 =?us-ascii?Q?ady6IuDZooi+0o8za3pUrKtvMyjB7oJb2O8UsjJwy2sGNBO3eTdmpyEe+tEd?=
 =?us-ascii?Q?nOIM8UpORxmVd1JqV/C28jMOjnWkuoZszV7T/Bye3BgT7tJA7GnMSZ4y3a68?=
 =?us-ascii?Q?b5BGkZ7lyCuX8I67HcBIKCJI20PscR31NLdt4iRjXqOPB4xFi9YxsB8Jr46B?=
 =?us-ascii?Q?Z6+sbxmmwLrFhLXZl7YPieBEjlVQFpPha349WCu4yV/Jk1TCguf0OpkUgQth?=
 =?us-ascii?Q?aTO8FGIjuij5ylRraCgtG6reGuUepAQ4qonp6aqfiv1UeBv4DVWzTOiljOjV?=
 =?us-ascii?Q?lxoO/jJA0NYdIx0YRqxD5Shl0T5ovhaJZDI6lE7sjBOzj0izxCPGx3LiVrNF?=
 =?us-ascii?Q?/Mu41L3T2KSYv539TSsnkZckc57HzFqpX8bpkE5Y1RD+cHShnc1xVTtRxe0h?=
 =?us-ascii?Q?u5rNmRXS77vCU1nx6+02bLNeC4HJbeE4zVgDwj9f/P64mMvTlagY902tYRYr?=
 =?us-ascii?Q?lRnrYlZR1m25/8aJz5kJb+qL3OAwk1EkQu6uLUEo7r4CmYUQO6vPDNLRmTBn?=
 =?us-ascii?Q?gL6ji7YNzpxd/HcfTqqUIvGt3/GVTRZwWE1IpAK4LHo3Yf/sIlYPGSw+5PYl?=
 =?us-ascii?Q?oeUIK57MozKDWyMFtR68MMQcfhWN7oKfjedSoEYhULbaKg5dV5aGM06oahQy?=
 =?us-ascii?Q?aVdc5dfyBRFs1jz/6EK9nT8GWPmxlLweqg2TON2iLOC+AIjjphoHcV9y6Zx0?=
 =?us-ascii?Q?IdAyX2U+j9xy9qw6XBz69DCkWHaxcnz2rI6gG9RjwEby0wQQsDkarP4uHZCy?=
 =?us-ascii?Q?cbNOFKw7LMIQdd5Cdrj/vmGM+yJ8OBZ7s98JqOq4808tMaIgOqzFN5xpwZfv?=
 =?us-ascii?Q?9KEa7nliSGjE+U9yU1n3JXncGr7GcQa+86HJGxzsXYmibil+JIBRLFgcQCWo?=
 =?us-ascii?Q?IKnam67d2DNSJol7L+ecziNW9w7Nw8Dv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EMsOlV/p4niqV2DgOp2ZIOsBOhDEc1vo+yLBWtc3O1AQYTD9OP38DefYqP70?=
 =?us-ascii?Q?o8z4KDrt0tIgxC3riH+xEaotg/muBbxSQGg9u00UrakMrqKr0+m9lGuUWSJh?=
 =?us-ascii?Q?XeNPEjsLSfhP45ybGmQw3PIi9a9FBPfT0na12ymD78jCchqcJOoi96J/ltGQ?=
 =?us-ascii?Q?D7MzLz8ghiqYzqWYR0qi3GPkxB7DZhRRzVRrUJTJvuF+TGn9Vvpk+ZYAJ0M0?=
 =?us-ascii?Q?rNgtCFAT8OmyCxTQuHEBxjUkoKG+9wJ01WShb2Gkp6ykqbtYAGdZw3yHQksp?=
 =?us-ascii?Q?MY11rmacC44bfXz1g7Pm4JKwr9hghTZp/SuGyomLGnnoO9jq57pI62BMYg98?=
 =?us-ascii?Q?ZSOK1Rh29VUdrRrL51ZgmUzp0nOQEjfI68dI5paCpnWNDN0BCg/EDtGSmuAC?=
 =?us-ascii?Q?TCNfmc52Av1VuBZv2jqYJC4wPKYtW9A4gkybdQUXePAkWx+WT1HUUmq5GC3n?=
 =?us-ascii?Q?z9WbQYu4zj19F+AbbOCHuVr2WDJJ5sfOAb09iFD74A04nUIa+muhbURg9Je0?=
 =?us-ascii?Q?Tc2HiNt6+d5fddt6pyv4EPipzibDY9IaxQcLuyPc+Ztj73U2XVUHI37sUC98?=
 =?us-ascii?Q?Pwtl3hOb6BgUGQ08JnhXlGjJlweJGIXYwkJDpCd3CTuE++yU2rwIItu+Dh8F?=
 =?us-ascii?Q?sOwE17xhXr7E4dVKIHY59taynBonJ7M8jeDIL/gZHmsqNtiGBFc8fwgvDzcz?=
 =?us-ascii?Q?OqvFHItUo1nzsvf6OwwQ7W9xLCBBpiFpxFhOEMsecEr15P50o7U0kNB7jsdC?=
 =?us-ascii?Q?PAoKRymrPgcL6chi85692EVti1BU7RE9duoc/VZObcM7rYrrqFuqIkoTR/mH?=
 =?us-ascii?Q?0atF/r/2O6fs1w3CNmsoTv5Bh21wOoe1i7AFvSCDJIENhDoWL85wOAm0OBJH?=
 =?us-ascii?Q?gzXUxlrA65xItvHjd86iGMf91RAAQidnYtv51SqiaDr/WRKE4hxOuOro3RjM?=
 =?us-ascii?Q?Y2SiQ3nrCfjA6ZphfOxNgpgX7+7H+QymSx9kZpLK0taatGbkgKEEJsBDf71a?=
 =?us-ascii?Q?zIwRerm2ZGz79z8Du3XaRvua5b4AxqDNZB+5JrRcTTEGUynenFGg2NfE0q+M?=
 =?us-ascii?Q?GbY3k/gpn/aJfZWBUOU+TZ5G3nRrLVMgXSVcSiucKdJhTurEBkI7MU1WWBsX?=
 =?us-ascii?Q?RYdCXACmD1QtoNJ7SYHB6uaMWJXFC+cWHvwAKRgx+7SKga5IijvrzbizouOG?=
 =?us-ascii?Q?cjBhaynbnpt99erBKMZPMHFxhQ6N/pJCRx7bduNNWwV5M+rV8SOhXmHzjO4I?=
 =?us-ascii?Q?wHfpon7qOO4Pj/qH+JQCuAKsl7/j8sN3tK/Boq437NRxtVra/IMAkzEYikXu?=
 =?us-ascii?Q?Y9NW6n0d+DU8VBJfd98zwNkItBC0HYlVSApTZfUfa7EHV7XKRP++MasVpfCO?=
 =?us-ascii?Q?s+IFgE16pMCZOqCo/VeeX/Ukavz/+qKUYfokRx5HUncybAnbrDXA1Kl+wv+b?=
 =?us-ascii?Q?rw2S9Zl4lQUMLbiiNRZWDx7lpQyDx2Sw6gTTexe6BjO5cWEBz4bTnqtoisT6?=
 =?us-ascii?Q?eMGU3wNegoe4EBf/in8+uGf8LBBSiyUn332DOnJDh0uvJquZSVfJrJKyhqZj?=
 =?us-ascii?Q?gfD4zlGUW6TgaauNnVnLIWN/MTohxj/+Q7F/PujbSFUzdMDQXZPNDijLu45Q?=
 =?us-ascii?Q?jzaY9nxiF01pYXA2CgpAfOc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aca1bcb-ec29-4293-3d33-08dd562782c6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:36:25.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHkKHcaleppKhaxcUbn/GdOitO+X3I27X44C5GuGycF4Z3LL67XhlgBu52JhCZqKn6dOJJz66NDd9zmpsA50EnrAUu9fEjveL6URV6uIEwbe1vZa0xeCYyIHHzqoTLR2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12800

Add str_kernel_user() helper to return "kernel" or "user" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 1965d3a5976b..82c5927d50a9 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -119,6 +119,12 @@ static inline const char *str_level_edge(bool v)
 }
 #define str_edge_level(v)	str_level_edge(!(v))
 
+static inline const char *str_kernel_user(bool v)
+{
+	return v ? "kernel" : "user";
+}
+#define str_user_kernel(v)	str_kernel_user(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

