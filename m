Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010058.outbound.protection.outlook.com [52.101.228.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8E259499
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548191; cv=fail; b=jqEqSkQcDl6lFXjCoMZguyWmv9TWSljydlXHereIGhkvi7q1oiqyhODd9+jgsME2PkUqmsvTUXBb1ra3PklHZQ7uWP9fRyoAXLtIOCbbG5HLFfGB7G3cxuWm6v/d/8tIC5eClQEWD3ZXokBJIoCc5AQkUdB0jt9oE2wy7nxZxbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548191; c=relaxed/simple;
	bh=95biLjit+ctlUjhzA3cVpg198I30vQIDXSKjQKLqOEs=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ny4cqZBTIjnoSz7LJmEG/8/6rRkNd4+jd/0/YlFOXYm3XiVlsb2DH3EbQqb6Ypx+nkRCOG9S8sWgmD96Kjk3xw02hP6QLqVgKCCyJ4HoJGyRMwaWp126imIrrllKhe3Mg/CYwLTfE6kCMdd1ksrAyJxIbVFJ1zDuJzyccwonAws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=PcxQvGhQ; arc=fail smtp.client-ip=52.101.228.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PcxQvGhQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/luORATEBeQD3bjYzYuHoZXYq/52XZLfyiDnttz+4CjEOO30lz4iC8MHUhG3kgXvTKv/SlUTxySGBrXsic1992gDMYNdN0yxQrdNLeFMY5dIz/V0jgWkdrCuHOer6vBE4ws9qylY0zS5hLtSuyrudEbNt1M9AkY8DDzZvmyyeSjfajQOz5BcCGcNAPH4flTsnL08CqO78cZnTEgocc2HZHVJ+4vPWc2TJyBSwbCQ2n4uLb2bCUZdWhz2g5vzji/revYi4+DW7IPCFLyFKkdBlI72zD2Xr166u0EvY0qtDRCIG/q0R7x7llehJb852Rq6Yj6ptCQWNLFVOT2UJDWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFWslQev2NvqM5L8u2b3MBJ875l+L13aLP3T+R8anPM=;
 b=urQxmKscfPy7j+XedACgK8KJJ5ZsbL054/4wHwjRn7h/8Wa5wN3Q6qLEnJ9q4cB3PUJvzQm7nIyGPsIjg1Mj9l/YzTVhjvIAEgoni+qXUyaMBCkFvh79RxwPx5MlxU30M+yZjd1QPvkj3nb2Mr+yFC5Du9zXkk5xXCmL+Svvyfmi5z6F6rRK3piDd/vLUWSzhxfNum2dE/q41kPSN8z/gRqgu6YFQoaQQEpVeSwFKZHMykaWWtodE625rqVV9EGY/Z/emc081vp+fqHnhvf/XeLUPQM4hl2eNnM2wmr5ZdyXeddsnQzkwRKfczR75Lpxwsgf788KHfezcRjpN/2Zng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFWslQev2NvqM5L8u2b3MBJ875l+L13aLP3T+R8anPM=;
 b=PcxQvGhQp3fiP7bDnG0LElqkO88StVykTM357x3Wq7iDw6oan/zpLsS2W57cJhXvFqJdWFGRRsg6PoaUU4TFP3+XGaUq1+1HYs3Hag+ueWQX8PzbhNDDsHcLpOQoa96rtgKQbk4arpdRHVyDUoBC+6UAv5ZS+e6QDZ4Fho0Wbss=
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
Message-ID: <87o6yp6ze7.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 07/10] lib/string_choices: Add str_to_from() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:36:16 +0000
X-ClientProxiedBy: TY2PR06CA0026.apcprd06.prod.outlook.com
 (2603:1096:404:2e::14) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12800:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f0f804-fde9-48a9-ca27-08dd56277d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oC0e8JPkQdFdcVCniPngw1iT3qxNSmP5RtOAMDKUrplnfYWJqjHcQc53ljyf?=
 =?us-ascii?Q?fJQcImk+mhz4534vdi8cwqyyeGZJDfdU1d2sRdfbMkkaUSJQMPJ9xPU4nyd6?=
 =?us-ascii?Q?1Xwei/GdWojDBeYmZTR/hPGdUv2oH7WivglEcW5Q3XYyp1gAfpHbu7v8RBgE?=
 =?us-ascii?Q?SOUTy+VjgnGNOY+afEFRwT45IsBGuTUFa1sveGqZiRYnbql1733DXrRNtSl1?=
 =?us-ascii?Q?TXx6ZyX7O0DhkK24uE9I6sseUitMOk8OvgKAMuMKhLzcBpDTNm1ZOLp124vL?=
 =?us-ascii?Q?AgzI/eONgDY5yLu35QxYM79X7oEDh5TQm+lzd7+FHBvv0ndvnYkZpZvViVQd?=
 =?us-ascii?Q?CRFsFTuD1i9twacgf1qyyTP1goCmEQShOqjYNk7/R01heckKi9vYF4i6R8Ra?=
 =?us-ascii?Q?AneDZxZup1haRyph/R7SDePypoTUY9BdVD/CNqOfX6p4ab24kamlINJ38T/d?=
 =?us-ascii?Q?VPEtrDllUBHLO9/FS5hmHh8F04mq9yM0q2QuAfF8X7RwCaXJNPdbNRzUMvsa?=
 =?us-ascii?Q?Ta+FVFaSmdbfKerS0VDwU9KQzMid0Eb0jomSU1fxDQcXJZQRzg7Z6tGYiRNT?=
 =?us-ascii?Q?k4AGp915zf3PDvnqYVdSWD0vQJ2uJCIrpO+9dYo3uov2t0JJjD9Sn/lXHZ2B?=
 =?us-ascii?Q?ltFZck1cOVML+yJzzErZRJ6qXaocVI3Ys7SODrB81+iC5A61iUniFQ7Lde7+?=
 =?us-ascii?Q?Ab5hu4pbfmN0NK694V3bdw0rrta6X6IDlxN8Sbq1/poZ9EZ6yz0rSUJFHayQ?=
 =?us-ascii?Q?/51l1LTq3VjXL8wYQbuuYXxrnc6TPQRx1zKcFdmVmqBwGIZeYJYw8zBhy8OU?=
 =?us-ascii?Q?uzmglS68l3NY9xQB4NJiWbt6Dn5FKEVI5o3CZKOPeeIXXxkvK5rQpp7dBnHK?=
 =?us-ascii?Q?OHtecNXMLKKIkDMjB+rKBk7MTe0wIsiII6chPvM3JNYwVwvuUEte7NMgWgIQ?=
 =?us-ascii?Q?iMwiqTK0PAxDmcUdrXudI60uIBf+4hDUcDyyNpeo7dqY2sDDHFuGdY5TcoTT?=
 =?us-ascii?Q?WDtzJfP7UtrH0t+TLm45/FsVv7gjS8N4d928h+J54AG3AqDf1i0gG2js93f5?=
 =?us-ascii?Q?9gp3QE/6g59p8jVJlGUcN0AecO5VSwwzOTKEMLVuWU/CKZKfCFveDmy7mZP0?=
 =?us-ascii?Q?3Wsp2uxBrgIMwBM0ii7zxj7hyIWWclAAx6jJawURKjva6lzGJq+z2uAwSo2r?=
 =?us-ascii?Q?UCJGFhxku1XFkInyMcYKvh0JHJSUmcdzO/k1ISNt8nM/oFG3UGnsH+gHLiIg?=
 =?us-ascii?Q?NXD5UpegLBDRX7Q3QfHXPa/U0b6tC+n5mdQbvrzyOG0rDSGAWc5G4l8WOiRM?=
 =?us-ascii?Q?lPv2axr68MPrx6RBQfe37//VW3hcIBVdtU1codRltUswSLJ9uD09L5lXotmY?=
 =?us-ascii?Q?utuQrmy3OY8AiRPyA8PygWP3hIqZkkyjW3uUyfH7qmbEtdgumYegegvmec8p?=
 =?us-ascii?Q?0vww8Nm6sKv7k1iqlfhR1hnM6cll+Spz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+Lvo4d+GSqNXCu9jomGg1/Q4csYd115PUz8voLpTG8TlQwrf2R8qGzs/FtP?=
 =?us-ascii?Q?dJWDIwr5FVTV2CIY0cz/MA/5QUaz64l5zyFgWMFoz+itfLc3z3+e/wjZ+1Ps?=
 =?us-ascii?Q?iBUGWF/J2zMC/U1daOry0mlkfp+KsYq9dVcXLGYHw1DRDVHL7Mfggw702u+I?=
 =?us-ascii?Q?ANjh17yT0BTG78E2vb5ZhxbhB2bGTC2fDfErPM9E3GgHjuLMvb/UpJlxmra3?=
 =?us-ascii?Q?LXFvzEFGTY/gRofKMrLdFk4XU9bFH3A0xqxxtFHiPOeM6IehtkXQLWOQSgnN?=
 =?us-ascii?Q?JZ20phzdg9UstjIP+t+8qGSuH4fGM4dcmbWrdIY40Y54CKiqQknldXJ+T60H?=
 =?us-ascii?Q?36DOvfMfChZKCfRXum2eY6mENr/lihJq+ryuPE72z7ce7nXLu3xAWIb4kKDj?=
 =?us-ascii?Q?WKQPp3Ol+kM5v04RN03QGP9zecW531/PLr6zJf+xt0YItZIhbcF/mrEfjEVB?=
 =?us-ascii?Q?5j8rFphTaxLwaCcz4uROTwjzC46Nvbv2PngPxdXPgKiJupFJkrDBUPVsKC3y?=
 =?us-ascii?Q?pEUNBaPZHvBX41Vyo311FbvoWifJIFVZVr389uquoM+NBPjktDJo1YZTFxhQ?=
 =?us-ascii?Q?6heExtNJ0cxqASK4kfAkQKnckPrp9nTEmBIEsSJIRPVplVv+wAbktvC0GBog?=
 =?us-ascii?Q?IyO5CasXPi8VVTXUCVeSVEL664foKC0/XxhNRd4KWkJWlNEJf4x9HmUaG7Qx?=
 =?us-ascii?Q?PhxbMGrCRWrAsp3EMHsd62sVwJ0h3WBa/zCKIcusOYKZL6YQVyRkZipxq6M+?=
 =?us-ascii?Q?zu7Z6HpjEZWtpZZkK2yL43AjELbB0icVMME/6sj5VWhHlCzLEHVhae3J9XbJ?=
 =?us-ascii?Q?AaRwXFKX4A0VD7l4HpY0wykjzjDuCjTO34v9Bt1gsRD5XKZQcFMvemZvcs8R?=
 =?us-ascii?Q?3GR1ePUdY9Th6qIxWMPD7A7wKZFWJR50mn4jAsZsEyAL3E5lFZoAaKyWESyi?=
 =?us-ascii?Q?4nriF5lkvtUeIMkyxDHW6twWdfIFzBDQ/3rgeYgczNWEli5F56CttKGPu36e?=
 =?us-ascii?Q?MYGn2WUgjJ26MgaJZ6rV/Yi8AycWY4ddYR62CCoAjhvac2sBTBWfwhA4BVY9?=
 =?us-ascii?Q?NmChlWa9QPmjcUQRnzTyMyZQW8XE+MXgoeWwmkeVb3lTq53fsQMVIRY5L9Td?=
 =?us-ascii?Q?Ts2XlfTRp8L0+hnhon01UAKPOz41cTncUI/kyBdiw3bP8MY89ytdzPTpPhnK?=
 =?us-ascii?Q?54zFodRxS/OMzjnKIVIRudy2P0yB4O30ySnXFBU3/PRGSgeWH8nvrRdhSlB0?=
 =?us-ascii?Q?I7IP2PgCoCZW8T6FM6qn6joBlFqUxYcRH0uWK0vqli+IBEbas1joNnqRdCqj?=
 =?us-ascii?Q?oKHtHQpSMnhA7ixCzTPssEm+yRzW3vJ6+hRPQzlo2JW6Ft5mvYrnLzYRWpk4?=
 =?us-ascii?Q?3V+a3O39jSXeJvtyJJaH53toTw6w8aK627XwTb2r2wQcjH3vUa67q/1r0FIH?=
 =?us-ascii?Q?PRSxYRo8Sx4Jw12XK1mE+fk25Zh9Jw1P+gJ+t9QqRczQZl77U21WY72tXck+?=
 =?us-ascii?Q?THcmbDTeoTjY9A/j5A2qyCSGzYRE8bJ0r8uso6/5BcaafaCYLFxkiNm81QCU?=
 =?us-ascii?Q?HcxBm+V9Ux70VfOqjS5KJdqAbSnFcrvN48AULjttKnf/x2byXOyr8HKZGOyw?=
 =?us-ascii?Q?pcgtZRhdhBRNqdIO5GOH124=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f0f804-fde9-48a9-ca27-08dd56277d87
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:36:16.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gP9pH+BmkQh+iG4ASkzre3DDollBQR/M4FvFNoMAW5PDY8Agr+iOh6QXal3BItn70OGWo03eAJDQ1qlRzH8DWF7YeFXdkH/EfMWfZh739nSqqTeeIzr9+fBPWAesmOYy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12800

Add str_to_from() helper to return "to" or "from" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index d52ced93e21e..e07a9a5e403e 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -107,6 +107,12 @@ static inline const char *str_pass_fail(bool v)
 }
 #define str_fail_pass(v)	str_pass_fail(!(v))
 
+static inline const char *str_to_from(bool v)
+{
+	return v ? "to" : "from";
+}
+#define str_from_to(v)		str_to_from(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

