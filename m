Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011059.outbound.protection.outlook.com [40.107.74.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB813B58B
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054435; cv=fail; b=fYZtLXs7H4vrVqJOEwbBxlf8EJKnUAQkvFF1x68PCfVuhB/9qcFfaZ60+FOviO2qsEqOqZN3Ly7IdkSPZLEwF6jgZ4hz4YylmLlM5w3brFDR8x8tGhIrvQyeJEmMYV+Lv8Vda/26iAx+cGUS7TegDkG13Gwjpkkcr2BT0P0XT2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054435; c=relaxed/simple;
	bh=db+xrlxM8o8tMb12tYIv4bqw8kCI1tDlODy2NNKYtJ0=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=W17jFOtWGky0a/c9iwHE/wzAJ7mfwzldB9gcQT/WsOMlyIkKm1pGBs966rdDtNQVqNlveQMGP1VRBoVGoJPfdjb8FfkaLqrM2XEso4gzRTM5Q+1s6wuvREGIvoPfGKLVskhI4enBvTMF7qwNeWibsyTdRRbiyVYha0O5sDG9gq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Tr0n5zbW; arc=fail smtp.client-ip=40.107.74.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Tr0n5zbW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfgKlEtorlOltMo88eMCO9c+DbeXqvYBS/IEyyGLNb1dR2MqX2UM21Xh33W2brJ/w+I0vBaHEFe9BeYz7XVLE7c/x3gX0wNTYHnwtye5sbRjxsJReJtL0bj+bYmyxWh+nXeKzOyGtiSJV0i1UoKw8xvHQo7MDkK1J4zzytCo7ZNEA96iEJHfPa7gIrQ5mr+Y7u0UflP1PoN71B/7ahduXucj3Sbxy6lmT3rgbjXmvcEhnirnvPFFQPdsCuo+J3Mm09BNPTHq8IBbf9OxdtffBHpHiW/hDz0/Adzf4t31GG06ImH8ypWtt9arONRm1ZW3y2FxjnLHI1WqIFYIHa7Z4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thgO2IDWH16GCdzE8kiQgSaVCwVDfs6NOtfFq0Zocuo=;
 b=aAa0OpDXZDqZANvS5Lr0hvid/Kxn3YkTnlwBf/Ew6bOyfwEf+7sIsKF8PuKh9ChCyheQ4JYWQ7AYoIdMzT6ZmhqPX0m+/PKc6M2iIy3vJjWEREjYw42MqXwLYbRvopWUAcTX3uPtvhfxsJOfe+HWkDz9GV0LgkvYGOV/4XsUm9Lvg4m8cch3wq7eQRtGMNMDhR6TQ+9CldWetY+SISs3I3X3AkvWw/F+hd/F8ArojCaQwOS2n8bOeckGchV2OqNp5zPfAd9ZDSpeCvJNNofmg5oo9TIc9VtpxYtj8C0+fDrBiBnQBs8bltapbPubNZYm2CcZ8d5VXIV6xWegtu02ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thgO2IDWH16GCdzE8kiQgSaVCwVDfs6NOtfFq0Zocuo=;
 b=Tr0n5zbWVl8WbhG93bL47dAaZLTlHIdCD5zcGhamC+7sktlBvLCBlmwd5ICg8Wh3djmvaV2/9EGW63CvEmqulgUrwPvGwbyn+o80oQSixqggZlpznQ3/9ymQEVOTIfEyoNhcabxF9x3UPrq672GstaCQPAsIJJlrKqmCgb/qeIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:13:52 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:13:52 +0000
Message-ID: <87jz95pmow.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 08/10] lib/string_choices: Add str_level_edge() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:13:51 +0000
X-ClientProxiedBy: TYAPR01CA0130.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::22) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: d054d205-79b3-4115-5452-08dd5ac23536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LVFeEbLkyMqbdVSQQU0P0Vdi8clq8OhNT2oSz2hPx3B3Gx7OHH6gWa32bz6i?=
 =?us-ascii?Q?7U9o5UR3cljD+G7qbGY0uSxmbM1mFFh2l5LBv50h5dWn7bfEedqUTzRw4HVe?=
 =?us-ascii?Q?uEPyrPGKt+Yxvhn8Up3aqBKOoILp8HcOazSqzwql0m6WoURQKKQJYXRVDwGx?=
 =?us-ascii?Q?HlewUejWAS0yfi+W48+eN2r6kZxk9kS3VctVl1Z2Oyf6Pl+/PHnDZnoTy8V/?=
 =?us-ascii?Q?RbdRZo+eOarp2Cpi88HQANh2wWINrJ/5zndPfrODU8+kaVQvZ1NPGLYVi5IU?=
 =?us-ascii?Q?xs+UaklakU0h4vG7tQSVdOPBnldX838IuqMqv7pUHv5RK4SVzoQRxJTmim/y?=
 =?us-ascii?Q?oJn2Q/1BfNguhNGG6ZdgRuY51S8jtZyqReML/s//Jq7CJln/37Cwmu7xHjJl?=
 =?us-ascii?Q?C61tGe9O64fozutHw0eBsxlTA6/c5DAfNdk1jyj+WnuIM9/y2/+886qNP7Ct?=
 =?us-ascii?Q?rXm7dIleU8eF2K8XOWFIm3KYuw+Z4acQfZxk6oJ+Vv/2I1LV1/uYK/t7+B+4?=
 =?us-ascii?Q?hsQ0Q9nRcxPyaYXvvzXXE/GMp8A9ipfLI7XmML0F71u6rZlAxJ2QyE2cvX+r?=
 =?us-ascii?Q?0Vd5o953jPlx+4z6K81LLRRdwJS8i/f6zQskPE6AU9MKs6+IslOZnJUOW2Yt?=
 =?us-ascii?Q?fjssb8aYCVxiFQNbu6j4Ji9yrn2/Mo+nx6InQb2ZLQ6s4RVdHPtEHHFxB6Ac?=
 =?us-ascii?Q?3MMdH+aTGFU9oX40KfNDfLPbeR/StKYjKpILfNcmy30zEa414H7B1/7XV7sD?=
 =?us-ascii?Q?fT7cucXsZ4zAWkBBArbCVoTJDhHvhL8ewo1p5/H5cUCtTsiXwOxS4DJLfebR?=
 =?us-ascii?Q?q1HnnplhGtMhgf+N4DMUk9HjgCZ8oqFJ7nL8dPrmXP+bjPSDCM3m00GoOer6?=
 =?us-ascii?Q?BoMT6gStNZ0LSugHJo+nOSqLCj1hHsx+XzSXyWTM19x9kycGRMiUhxqda06Y?=
 =?us-ascii?Q?Mm9mzzOj8HPhxVeNeP5KvhRJIW+lOsf9muDX/JVQDbGbgyo7aSNchXepFnsa?=
 =?us-ascii?Q?c3JZEn0Zt6DoydAUN2hcbPSIS9wY/Iq8SNh704Y/8GvDOCpCClF7NbVfGsFB?=
 =?us-ascii?Q?/PEDCT3wEcmMfWE20/88oW6umnoymwYQg3GaCPHKTwX47Vyt+bVGrmwyYnJ+?=
 =?us-ascii?Q?jqiCCTpmaAdmHIvlJaJXVnI44QTqHhkc6qkoroS4uwvDNCXR38Qs+NDaRFmu?=
 =?us-ascii?Q?+CWTqjU3ST9Hhdzo1JVdTECNlqvaHkhiy/0SF+r7ann1sqyT0u8gyI0pfp20?=
 =?us-ascii?Q?hpxX108kQWUOcNLH2nUQTUdXvVPEa/bJHJaaMuKBCqmCUxwt0tkYdijXUfVf?=
 =?us-ascii?Q?V5/vuzXriKy2x2Yk1Qe/elSiLPJOjOyFjt7+YjH9BfkRCe+wbJGMrr0yXcRt?=
 =?us-ascii?Q?5EjzYo+2lbUpJmeNc5gCDcbL8va4/tNnVq1mexSkUNVP+3yhk+BMHJ1g1KUO?=
 =?us-ascii?Q?90SHmS4WAkd2Av0Sgi2/teB6GyjTRszY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khXhPKuJx4mSc+ST6U+8rNn+GgWGxrIH28n7W8kZerFOIamtddhsBtWwDa14?=
 =?us-ascii?Q?mnDBtR1K3a4CZGk8xV0/1HY9Ot4WWhrUo3nzMgFL8fdE8NYYev8TcstzKm0x?=
 =?us-ascii?Q?tzDSaW6hesdP4Ul5g3A2t39XZS/3ek+rw2fjsP236VkXZDhgjA9xGat0OohB?=
 =?us-ascii?Q?VmkOR/Ehy7rms+Xuo3Lxn9uOzwaVrKtY+up9E7jK2Xklgqj2Wzowsovez/UK?=
 =?us-ascii?Q?JpRMucZUgd+G36CLS/t9r04aB5YVXgh9JOtZcj84NHrXYF0V3gwVZDRl8G1R?=
 =?us-ascii?Q?EurbJWkYQN09sj2BrGbvCIiMytNsMBbD35tAabB3HgwJRUS3s+WOcAofeGFF?=
 =?us-ascii?Q?UQBaX4Wre3vN2vxO4zlFX7MzZimyJct4KuETfuGxZsKldCr/jv4hbZoV47xt?=
 =?us-ascii?Q?CYEzXDjQ48nguiCev9LUHTcX68EmzM6etvcSr/dio/ZK2+ZckAvn/rr01LOi?=
 =?us-ascii?Q?WrKdmpWRIhA7VFRwTzgHRsqdR6ae0/XQI9RNNOjMQQvrK2LOFYI2tFgiwkZb?=
 =?us-ascii?Q?HAATO8/RsY/IvAw/jj0eAWrwnj9CBgRzQz4c6qhGDp2zOcPWb6QFU9UtJL+s?=
 =?us-ascii?Q?/NNfGwF7UOfgtcHInlurvcom/d1HVWBEURSFtv/FaFCHObriRft53zr6AB9Y?=
 =?us-ascii?Q?apecdo1DxXXcqmaNRfiRKuHGgZS/dTuJTh9CK5QgVLGsUTBbXNER29bozyY5?=
 =?us-ascii?Q?4t9Pl3f+VTnpB68XeO8Maph64fhmg+l/KC4QoYrdA6EFptXVYyWkTjyaZS7+?=
 =?us-ascii?Q?EqSsk3MYDrv1XFIInhGtIySbdGF8QwJDT1hv7YL0Npd5v+1C7k7w+eLnEsY/?=
 =?us-ascii?Q?mjGv49HLh2EORFEd1ZUbz0/pLB4y8tm5m1Zmp3D5WC5KnNKHSAmvOAQ6j6/G?=
 =?us-ascii?Q?9xQZLfjFiejp9VMuElwK8DFLqRdjZD3q7vJfnmGwHIyfv5jd87r2xzMK0IYg?=
 =?us-ascii?Q?9m6P3RH1vTd7AUsZIqilq8SJ/tvwbde0A82VzjOaq0bOlvexAGa8fr2QnOua?=
 =?us-ascii?Q?Hht3s6JKbsLM5PUvGVr0Kt6BkfLDuOEqBc4ppiZ/8yfCC7PZFHBEJ81fqXN6?=
 =?us-ascii?Q?BSoLx1zviVlO9y/HJ2HNHFOeWjRH4/AvKE34Qb+hxoJImQHh8o+ktsPP2jc7?=
 =?us-ascii?Q?bkqmlHWMpOIldfzzofEZ81fq1+3eUj1HXqmjYjmIg3MVSyOVugvg12+Ah6sl?=
 =?us-ascii?Q?ScwMCKUHfovaacKQOjc4FGBo/5yGPi8JA4QQu2VAceurH6LPCbruGxZlEEDm?=
 =?us-ascii?Q?iVIM0DYW0i7LtJkf1LvqvknYJ8hN4+Bwm3lEuuHDB70RW8bqVyavrKK9SuAs?=
 =?us-ascii?Q?U4mFDeLy2kHO9njjjhuSsSOKXoIsrKOFjkYKcovNGRUcbsN4JamzkoIz3eAN?=
 =?us-ascii?Q?dacElkxzUotAaTPJtCTvhPyQdXwx5X0GtbzE7/sDZYhyv12h/h7ZpJn2gAKB?=
 =?us-ascii?Q?2T1eAEjLG3UZFqqm24k5Us2KMPTa/QS/JYOliuUBOktiGNMDeR+6XRTLjy4l?=
 =?us-ascii?Q?HHaiNmXnETNpCuEYOPVOLYFwgDef6ZNrjA65l7FtgzGY1WVEtSTM/Ct4DUOD?=
 =?us-ascii?Q?kgUANudIeq+8dlUx5Bse/EFIB3Bf/Wd29XYh/3rHnnG9MRrXCZe9sIjyKk5J?=
 =?us-ascii?Q?kB1lBuPjD2bWi/XQANIi7bo=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d054d205-79b3-4115-5452-08dd5ac23536
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:13:52.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp2gLIYhLY4lErYk/TvDdv+8XF/DYx9x+oWaL6zFrYdilzgquJnKtHulaZg4HMQHbMff3VEVYh42XAeg3kGGj+FpjxrX5gsLkfpSa+bW3bO38efrKqNpnKLLROT/7tzI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

Add str_level_edge() helper to return "level" or "edge" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index e07a9a5e403e..1965d3a5976b 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -113,6 +113,12 @@ static inline const char *str_to_from(bool v)
 }
 #define str_from_to(v)		str_to_from(!(v))
 
+static inline const char *str_level_edge(bool v)
+{
+	return v ? "level" : "edge";
+}
+#define str_edge_level(v)	str_level_edge(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

