Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010049.outbound.protection.outlook.com [52.101.229.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4F16DED2
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054424; cv=fail; b=OrfTSvzHjQbuC0vdTIO1TuxaBt6yArdS8GRvY62EzyYsWh6UL/OcdOcBBru3gVdjthUJmHT+7zhWCBsX+oBbwWNRrKegoRvQKa4ax1qZLUXh+uaqDr0BmkSK3QdbEskSU2/KlvVpxq+m/cuUgDFFwxvUDUt9tGC1IaulDdL6H1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054424; c=relaxed/simple;
	bh=PGJo3b04Nk5jrw8L+a1s1xitnubBQ/e7XXkqHSi2CWg=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=noeMxeVGWS4TE6Y5byIF5jKS10z/nuicIBEXMzYhCHh7MBdj8DYE3qWP751NK+LVwRXGL5iEoNNpMGoZWkkT0OPhqwE3SLZFqnHzygo4oZ+hAo8CZtUK/JplSDmBKvkNQBGRjnOG4V3fmfOgTTM+K5dIfmi+c2uXVcJMQUyFH4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=eP0o4Kye; arc=fail smtp.client-ip=52.101.229.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="eP0o4Kye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZABZJWPZsAuOzMS6Woq1MKBXam3MJPXuGDGIWQikTX+LHFKgJKnE+ySE2Sba1HDBxhmNVtcxeYKjwoJe0oPc89lfeZEjUkCQkizamhL4wHLX9+57d6mMki6Nh3JZk1ykjNQX9WxwTCvFlUh+t2xpkFRtMGMQZi1DKHN7JfV0z2LMBsXngDVG1O0Bb3cSyv/uzKgcO0fYJKCr4TCVgtXa5Qp6ATmpJd7mayN8KBOdHPmNIDMcZaAPbN3wQap5jR5Nxx1QiMb8aY5C28EQzOmIPzsyL9CXMVYwZ/5X7tedaiOWrLlxfN6ws4FDMxQ1hPujxlWWeeS9dXFKMvNH+i8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg67JsU1j5vcSQuNc4jURiP7YFq5Cc2S6N4X6xgIzQM=;
 b=VnUMK+/CygpVKvyq0w+WFrByW4w/dHy48yGG4EUxxwsoSCaJQRdMwBVW1CxYb5ThcSL36nyc7lffGKZY6OsPpeTKC/3d5PPthhFUXs8HPbW8U0uUHJtdeW+WaOao6r2WcmC2TGxoZUctOnKNxYlYUe3je5O3XP8u/teP6OEVztj8R0RUqKtEV54334RibeVZ7cNfTePGUPKCvGQX4dTjlFGRdYxepPE76sVywSCXAsXSXFfzJQjU6ZY30vjMPCQVveK/2Pv9SzeJIWOtcEgSJFmdr+XS0c0gQ6KUVvE1liobBvOzUnt+dJB3gCBgXpGPsl48GxUe9gkuVtOovCK2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg67JsU1j5vcSQuNc4jURiP7YFq5Cc2S6N4X6xgIzQM=;
 b=eP0o4Kyecc/ZE1l1wPzwaCk2qCzcIaR61aNItcYuaOLc8/KzY0AQHnfvdTZ4FgxySkSM1NPDJBHuQNd8tXoYn1X11lkbBszGVGK56YoXA/xUYVmTMKz3Rht0/HDvqJHFiC9Jidb5AEefF3xMG5xBHKU/8a49/gvPX2iKWKZ1d5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:13:40 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:13:40 +0000
Message-ID: <87mse1pmp7.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 06/10] lib/string_choices: Add str_pass_fail() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:13:40 +0000
X-ClientProxiedBy: TYCP286CA0186.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::14) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1b5160-7ba3-4b1b-d768-08dd5ac22e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwXRHQa5U90tTKQxbgYA9TvFmTj3asFLBp6nFey0t+4d8mqo/q6315PgjfBY?=
 =?us-ascii?Q?CFKboPEFThQOPpBWmQNgsYEEKV8WEi8/e3eR8r0HBGYGI+sJd9vZz9o7Ro7M?=
 =?us-ascii?Q?pNCx3sk3aVDA62MxEvieV/ShGVAuMZlBmLCdZry7Q2ZyShOFtGtJHOYGL3jQ?=
 =?us-ascii?Q?R5rjhP3Xz11zK4RsIkXcxeYkVIGrWqNUsFTTuLY3lFQ35A1SfbViiolQSTfo?=
 =?us-ascii?Q?ilH9shZORswFPwAmV8YotxCm03u0k3+lPRjc/Lbw2cw6lMuMzGLAehwLVDaQ?=
 =?us-ascii?Q?eIXfVZwthtL+D+J2Sz6X4pcMVSYzJm48FBkFSq92weI+D+raezMDvVB4DpuC?=
 =?us-ascii?Q?CtRxKmwsBsP2STJRW+FEODY5397JLsGovF3gQCYQuPCMJhE0ak7LmP4jdE5z?=
 =?us-ascii?Q?rx1jcZ6h/DyQigQGxx7/HBGai72cmFIFcS5sC35HEmCfspswcmHcpyrMv7ql?=
 =?us-ascii?Q?Fnh6FvKFU0zUD7PUjSwf0PUS8Ep25JYa35nvq139i6dAN7QVNpIovDaOkOBg?=
 =?us-ascii?Q?642Sbz3f/Jpdtw1QufNVe7rer43hANtVlFGvk3qmvfumwpHa6jg0WK8QnwGx?=
 =?us-ascii?Q?AD8+2mbBh+spuSc8sNWcwT822jYq3GcRQ54HY0tlN/v6NKFGpFKah/3Ds00x?=
 =?us-ascii?Q?Ho3aTmUZBPh1/7qnhPKexdMamrPbA2286wlYnFcGMYq0k0WmN5T/HjjLpjHP?=
 =?us-ascii?Q?OSBe3mSW/f/p6EsMTQXOYwNbV+14oaEP/24/OTSGX5vC/UK6G7H2O6ciw6P9?=
 =?us-ascii?Q?BR8cXzc3lnL7c2MciXUzdq5ALEzklEuQeOABGI0oPeE+c3waJuwXPT5yurhF?=
 =?us-ascii?Q?Ab4DDY/QGAk5p8Irmur5NvajMOgNJgcO1WIx70ql27NYx2FH80orNTpH8vQB?=
 =?us-ascii?Q?NkrWcDL9gw2YU761O6YArjAXEMbjnYwObgxPaPYAPSThjeh+rCTK0zxp8sdy?=
 =?us-ascii?Q?d8VbckN9NpWW95jJCikf9Zz5epCYBJfjPcA/uzTbNUonXkHl1SWWPkuzucSY?=
 =?us-ascii?Q?A+XpOOjMAHj8FjrOlRcSf3hukDefcLkBz0E5OIL7G0qVJ0kGUjovkdxhpUIK?=
 =?us-ascii?Q?I38+vj9OTcAoZz89iFwITDRjhCDPYbeLlf3BEvdSNC3JqYHZw1jMzQV/LegI?=
 =?us-ascii?Q?FqZEn0R8zpfOtpVdch10vmzHq2WrCOwa+H2z4gtTbCWIaQlS9jFBTVrqBTUe?=
 =?us-ascii?Q?jzq2npiso/Qa0996NWhM23Rv8JKNi36/+xMFyH4WX50BtM3cgV2OKiqE/1fe?=
 =?us-ascii?Q?EjgYfbFrRThx9kbnf6xMSUHO+6xk641bwrvtqeJUrz0WFPo13OxoZgCZvrM6?=
 =?us-ascii?Q?3oiAxHsaYRUNE5aoMDJObGul/etn/7gOC3q5O6sGAeVRMzxyfMIDr1XQg65a?=
 =?us-ascii?Q?CizkUkpDYIjiTAdzEVwSe/2rmoCMMBD54x2TrmGOZdXuH811V+7Qy43xUkYn?=
 =?us-ascii?Q?02xC2wjhLK/qnub5MM9v+ZpWlsduNHcc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MC1XP4wgwCvNNG6xsWto6KPf9+g8RMauS6LmCFNbcGfqv3YhTOO/DCb8ccp6?=
 =?us-ascii?Q?In8NvWB7Mshp3tX7g1HnY2Bi/aPBlzFNMZAn2MeiOyhpSuRTahocncRIrPi9?=
 =?us-ascii?Q?6EtPjckekQpoIGV28HYPdpNvQ4KCNHTGzEZu8zzrpt0ljvom3N179X5QfAvn?=
 =?us-ascii?Q?oXyLnEcoCzejXAJDszEErzJ2kGs/DlRgSNCC/O9Qj/eEK1JVr57oqEsMH4US?=
 =?us-ascii?Q?pDTntP1NHs28GldqPtO/mFBNos13NNnugEBcr6cAecKPMOa0d1bVNdAfb35A?=
 =?us-ascii?Q?yjJWjXg8poR4tLjyVPkzxoqlGRUDOHk6GjYGiS+e2vmA2Cyi3r5YhcOf8X6e?=
 =?us-ascii?Q?LPZhuJCCoEft7jlxfq6IVM8/8hzFXUbnuTKfVlGiQ1sEl4B1LiMf/hmzoFnO?=
 =?us-ascii?Q?1NeMHjalmegzqTBQ2f7TuFeKP2yg4XseuH7O6FqR5tsiZBMhDa/xDGCMtjKs?=
 =?us-ascii?Q?CMCp/smfFS/hrFpglmWI8EHV4qCP0TGYuDGWxYbiPNCgfvTfNoymnAy2HZDB?=
 =?us-ascii?Q?/qyeV8GoLXN8bIbUv1JBvH6An/OCIGnj6HsBv+zPe/3Jj64rHhwklNi1vQE8?=
 =?us-ascii?Q?3yRTDZk9ao3xHQOQ1jv85YQb3Y80vvY9a6kFrEGmKuo37Plh0Oz0oGPiWY3Q?=
 =?us-ascii?Q?/3dLpwEB6nk0Ypo4QAbWvoq8EJ5ifzwIbDQJlV5JvlGdSojdOg0wfHoufGZt?=
 =?us-ascii?Q?FbJlIY+RfD5pYnX8+Z9jZ5O3Bp5VMRCANblvPwT/Xb1jz8IAjGFX0PzzmeWJ?=
 =?us-ascii?Q?fRT4qTh2zOc9NvZ6V/cQruALrqHhbb9DOHY9QuVbCWXBSARJjYx6J0SJfLkn?=
 =?us-ascii?Q?3dTKqk+HtvMC7Wsb0u/E+/Xno9LAYLAlbSZaUGN9Y9VNsXct9QBFU0RySp+U?=
 =?us-ascii?Q?Yxj7TuLqu3iBJWrgaOSjFEDfLaRIzCe5oEoXCpS+r1lcXqqkY/Rziw8ynr0N?=
 =?us-ascii?Q?u/AauHITwGPym69BbwsmwIQFkzGfGIHj5uCQ7MOcvrKOhRZDjvX3CEZScZ7r?=
 =?us-ascii?Q?0xpPa/2ljcRYoTvhbo5tspv7SUfQSsc6cvGtdv2loauBMuIKja9B/dXfambz?=
 =?us-ascii?Q?GK1nCYI2y3HxTDnnsYKMbxl+FZd5679RKVAFIUfsKG/jn0XVaeA6ZD/JdRny?=
 =?us-ascii?Q?f4yTeWMmQ9BeatveLzPdE7Xv/7P6HUVft5Kn+Tzfg1j50nhahJFv3z2O6+mt?=
 =?us-ascii?Q?7dtFJmrbxQQUQuJoLA4KbtQCLwhG5l1U4nEyP0apH7RHFDE4mRGz6RqoFwbw?=
 =?us-ascii?Q?LmDgamgDybCTCxzIW8XFZ5Xt98utanvVsXqufMO61P6/IV+eX2YLLVTDDph/?=
 =?us-ascii?Q?0aBv3miWVMVzyBKZZCflt85i5RwUX2YbArGKXt9sQQoDGIu5e7TYOKbEqT50?=
 =?us-ascii?Q?/cMQsKrGH45aO5Td1WU3zYD30ur7uzUa2eybplW/nSpD7ihtFDZY/ENMT+kd?=
 =?us-ascii?Q?2qxjA5DF9z3AivemzMu3rfTTN4H75Mww8ztxaeUNbODgLRsHkkYEVuA71hHp?=
 =?us-ascii?Q?fiOqIYUTMEchHm6kjPGDRRCtiKG1oz3yP1I5xJS2mWnxf8iYZFRe43V7kOaY?=
 =?us-ascii?Q?SbViuhRaWJ4chHurUSZyjgrRR24tAJwX2nv+kGsk7wHqmbITeDFejHXMAEXj?=
 =?us-ascii?Q?/NyPFg3qtVeEQ5tzzvCFX90=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1b5160-7ba3-4b1b-d768-08dd5ac22e70
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:13:40.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6lunHKypLQm4k5fPBIq3VfxuJPJL/IrqiQVjy36L85iqOEwfm/g0fJnpZr0z2gBd5Vdvi5tTHWxKfi0b+jcebD1WpW0xfE1bqtfATuDKsttUm0DcRvvG+eS6KhUBC6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

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

