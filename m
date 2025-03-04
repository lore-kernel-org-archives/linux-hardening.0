Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011018.outbound.protection.outlook.com [52.101.125.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58373176
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054549; cv=fail; b=JxFQONlwBf36jqlxwSLkhjPN+KKpQOGuA7Cc8sK2H4LrQEqnPoX4+RS7YVmrHpMemr43Hwb3gE36YHT7zpDQff3kL/lTITXrC+Dkuq4cqsbPGYOWTtrKZpyoaUe+yKhyG5G+S5ssACeVD+4QI6ujxkUU/ahhLEAZfCtUAtzX8/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054549; c=relaxed/simple;
	bh=G2mEHtBiIuZFt81cMH9EGSjfmTeizMmEoqaxp55XGsY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nvwbBU7S83fIqU0YCANsrQI3H72QpuQFCvpJFRVgFWTGtCweI4WLB4j/nBTQ8LITeLs0irAYYNnBFM/0rfZSbCfq5PyLPgs+nCJ/pzoSpNFkkTmcb3rNoaxZg+VOD1EMCQrqXhd1j2Hzpaeflx2K8n6nDZDRSEWTxi4qQg45a2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=flEpUfXh; arc=fail smtp.client-ip=52.101.125.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="flEpUfXh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOp9C0Z1Md5tmcGpSY97Os2kW69t18GVy0YKJACNX04y+UkFvBcFB14ljLaZy9VFz67keE3J+LQ9h0/0IsUPtvS6PGQq6kM9YPrc+OxLIhyDjVNX/TQqF6h+DNd80q9DTTiaGV2eDFgY4AV6PwmVToSAodGYiq60lCehk7YX1E7Z6sex1N717jCtEHCIb6e9yQXK2BQ2276GN94g2EeSDxn6XbKZpp1OxkWvFvg4eOE22tS9m6zISGHOdSZtVCuladPH/tb3sPHnO2eYHv+bhNl3QqhwyTW3DacBn3znXYK+2Og3fcBiVJsFlMw+tXcaR4+iWnm+xmjM5e12xZM4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnBtBnVjYgI0man896oJMHxcuWCsFsr1FECetkb81sI=;
 b=AJryNkAK6FLinS87vFZHdrEqhcSbkgOsi9HVmtaXoyyOv12160flaqiND0sLcb0e+8Rj0nWlWEsNWJVI5lRqqiBMi32sYf5vqfXlBVq0OAAzybeqN25gq60q6BodU/TKqz10VUhCHmOGlW/uMlUnpD2gyJc8ZaUx6sK7aJ/09AlKUj5VZnRo30GRXV5eHJi8qe6Sj15S5QX0Unh/2nhss/ztDtwnnhxGtGsGkFbRC0QsO/YX6winkOHBUPVQGAuEoFFZ6DPQ+mPZ46GDScWciajPxVYVCZjONFCQMEQoaxb3IhbKwyF3b+cfwtBHCC05enZaI1eM+dP40If2eSgZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnBtBnVjYgI0man896oJMHxcuWCsFsr1FECetkb81sI=;
 b=flEpUfXhWbk+rsJ9WbAnVVyKZl6UCMfOblAeA67s/+C6vD/fewMb7a8EScoWP1xAe20DILmREQpkTju+aKb6sHVOUmTmpS9gEkDBtxvYCTifEsS2uqJfPIXObLWul/eybcCpA4N83uIsNkDeSHWwMfzgW3GF3S23vlv+80+plOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB8061.jpnprd01.prod.outlook.com
 (2603:1096:400:11e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:15:46 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:15:46 +0000
Message-ID: <877c55pmlq.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] blutooth: btmrvl_main: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:15:46 +0000
X-ClientProxiedBy: TY2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:404:f6::30) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 972df329-f9d2-403d-df32-08dd5ac27952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tmhDZ07MLk5UyQwv0fN5FxXDgZkrOC8gEEz0KPYMceppzggRDvF5DaKKS4rq?=
 =?us-ascii?Q?ggnwVLBCMaHzfmOnfVuq6yBbUsh7xQ/TG3ehI1b3UrORA+8hm3jToaYbz3r/?=
 =?us-ascii?Q?L2fWaGF7JbQUMh1SgWIPo33s3C4GsZgcCDxdrgmKD3jhQYDNUXC4jU7L8wNG?=
 =?us-ascii?Q?f926WQJ+jSQbH/Y7Qb/HsgwOEJJwRYops6ceVSxWxgyerH/eViweeNu6QCCt?=
 =?us-ascii?Q?x58X4mPA5MVbJoXiZU2TzLzhteLtSzeTUTpeDeXOolL1R2SvK9qSeTDZ6Kqd?=
 =?us-ascii?Q?+kMzoI4P7+KAmkdeiqy7F524cKs2XVW9wV0Oat/k7JPNlBhTFkhmaoMUBVRD?=
 =?us-ascii?Q?vbzqzOgIUQuouXTI1mmY4wzNFtO/gL/tRvFbPV6EN0OaoxCDhLYjk+hOIURm?=
 =?us-ascii?Q?Bycuu9LGZX78Kj4Bn6ohfJsvcNOnVts9baiI+3vuCaru/gyauSs8aA+kydQU?=
 =?us-ascii?Q?jDRLbChdK4nGcHMZT844VJHnJ4kwgY6Fnw3/wGOXi97OJR9mbqb99uDIrcbN?=
 =?us-ascii?Q?jnlGy7X5jH7mGk0Vd+1chZ6pzZlS/4hr/TwDRaWmVfzzBGYQkJSIGVmXL3Jl?=
 =?us-ascii?Q?S+Lbk67QT+zvmsUYATV1WaIDw6M4Vzf2pUs31yVvSwHibZJ3GRlcHducPmTc?=
 =?us-ascii?Q?DKCZqZniVUdWBTtmcLhbceqAPVF9BVXcmLxbeICSlczB+8NZDy++RUNtFC+d?=
 =?us-ascii?Q?qwUxGfBRPTM/QR6t/ggMRjdJRX1iwaZIbO50nT+omA2tvfMeaZOeOHCDayDq?=
 =?us-ascii?Q?wZdH047UyQrE0XB6Z+W/ODuQZ7gkJiD8Hd3bZWa2FnigK/SZmBCoE//+98mj?=
 =?us-ascii?Q?O7ITQaCi3a03OiM755oQdIegjB5cn+RaLF6RkPuKuSoQe5v82TYgVmZP4dc1?=
 =?us-ascii?Q?PDeW4M0GBxWiq1JqaaU5mXDDJsXcrzXOSMM+4XXJZtRX+S4UYE4ra3JgeZ3y?=
 =?us-ascii?Q?ctAjJAgj0mgQnG+776GkwJWBusNgjMQz4xwZHmP3O/Ir604j5Y+Blo9z0/9O?=
 =?us-ascii?Q?T9M8xA9Nr0+yUluuK8JUKwqR9KAONmzQsRIlK97MI9aI6UxesNYpPVxvIsue?=
 =?us-ascii?Q?OgiO4RJB5ZlneHg3WbBuc2a7gXaPIiZQwpbdg1rn1SJUq5etKHozCwy303lx?=
 =?us-ascii?Q?fnd+U1CsgqfE55z5uu35X0BpwkQ/J3v5Hj5hkl5LEmmLv1nAMH1p7ZzydajV?=
 =?us-ascii?Q?f8A14a+TMyhlDuj9KqH839eB69+3hG5cPLom6Qkq9FXbG3Icw8Udr/KNhinb?=
 =?us-ascii?Q?mUgwFGzkvG6fe3DiVD1n/a/Jv8yPcXiFew6XkYXfV1Ow2iCImwWp0CXbw83O?=
 =?us-ascii?Q?SiFxH9g+gPtFJbI5NhKl/JicQPXA1IIgQUt9y02IPqiXN82YD6RzTgSRWt+b?=
 =?us-ascii?Q?ItEWMI12VVoaFku2CeemnY00XLKCZqeNy/UlBu++9Z11y/P7a6lgnQ/n8i9c?=
 =?us-ascii?Q?348/mXiUJbae4nXHVFsj+VaqK76wsxhj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JY0epjPb8ZFT+mTrCEaMXuqg/qiUWqm0k7KDjBS9IdR5j5skJ+pnrkPJUzsQ?=
 =?us-ascii?Q?CPLYT2VlrnmC1Wf8FL/BRhLr7AxXjxUHfvrVKmw4BeYkRO63SA8TlKRhQlqP?=
 =?us-ascii?Q?i0IM4O8TVkk9dlsR7wml7qeJZGwF1iI1JH1w46sn8E5vJFS4xB9XOUCFMKN7?=
 =?us-ascii?Q?iJ7mpHphO8xLTLlOLcAWFQkahrtct56ROrjR3jardBF+iOaYlgbYaAXz/bof?=
 =?us-ascii?Q?R5hUd8DMU0Yt0YaPtytW3LEKgRGcSNnj+6j6Nd7fjOv4GaSX3j5KKsVbi93I?=
 =?us-ascii?Q?hsiwqvt8CWnOSI7Qrl4wPi/7IL1gsEiDHxZ6y+Cv/6+JPkCyZCctSm1i/nt+?=
 =?us-ascii?Q?ZkIUunX2q6rDtE3jcmm7qvYwFDPAWKMMGorXv+nyRBGHfBfzjTDkq9s/zutI?=
 =?us-ascii?Q?hR0T8tamqAUhmOvgxEiCXzcD+qzVHz6t4dxSXlEhhYKvRMYk4WoHvv8KlPmK?=
 =?us-ascii?Q?lTPHIvYHWavYZHnleGggMI03eSMFK8/Jlexn/3HwFsDaALvQdxmLiByPbB0R?=
 =?us-ascii?Q?eHyt1ymbFgLDc8jn2uv24trBkuAOe0tdwB7KnXKdHAZr5sPX24V5k/bIuj0d?=
 =?us-ascii?Q?5mQBU5iVusEze1J4GDGbe0ts1cGM3+n/gdheqbKopGYla0MWUxFDyUpY7dCb?=
 =?us-ascii?Q?ywAl0N8ECr3R3X49+gf8aSP9AzoLUOdas7cefKybEka38Sb0MT3j3NxSfK0v?=
 =?us-ascii?Q?8/CSR4vr+QLN4EiDV26A6xh/OGx9AM+35oHuhQNOkzkJvv5Q12diA2M7/32J?=
 =?us-ascii?Q?T9OA35vmZ6Es+IaO0YEwWogbabjGKhp6vesvOTOLIASMvwMSUKI0A3A7Fis0?=
 =?us-ascii?Q?qCLMrbdz5qLGjVwg14IifO8A76mpPFrQsev5kWjL7uYvvtsL/Cxw+7QwfgmC?=
 =?us-ascii?Q?FWpmQtkVgZwfCQrOZs1ziOMUcrMfRRMfkMgRZ899F+3QFtNVqUeU9OxcMMYq?=
 =?us-ascii?Q?+6Xb8lJWJjgaGJ3Cy0QzSlmBjg8UzgFA0OTP1J44e0svHiSHky0OQwl4X11Z?=
 =?us-ascii?Q?Nr8MSfwTiW06zc4Je+Z4TOQhd5S72S2ASNh1xSjpaL9rGVWk8bBdnymPi2nb?=
 =?us-ascii?Q?qlfHqUEESXIbGITZ0awtIQ+iFh9P74Y9ebHQz5V2t+wPv5EEJyUQI2DBwRm6?=
 =?us-ascii?Q?Ce7bZ2OFGe88AKSIjMazdY3nCswO58T+Alh/fnKq3FbraaxoIeGknzXbfrS2?=
 =?us-ascii?Q?+H6afJuVKq0NKYaebME97ZQVw49exKz2dW7DDfY2SUvNVHMJEWvf9TMuWti9?=
 =?us-ascii?Q?GUGRITcj8aIoORWshoDQ/TjtJ7m+i+BU8ASsEVVGQhtkeIGF5bkXtsutTeS4?=
 =?us-ascii?Q?8qsbhALBIWKTRO9DEnry2RMB/7sXpJf1xETCQtUmjEkByKo5gcPSL/kReLWs?=
 =?us-ascii?Q?JqJSjYW7k4LP9M4kGBioO/PeTvBtLXT50bhu/jamK/kN0ThE5PRnB2BlJm34?=
 =?us-ascii?Q?csewtcyjRK8KRGY5d0InyEKuC2N996riB268h6lmfN1dHW3I5Y7bFDCvLJ/+?=
 =?us-ascii?Q?W0mIwMmEQUY5eDpvFP3dQVMucq4V8emogT2c8pCXphhhiVR7NsTeN2qnBtNc?=
 =?us-ascii?Q?o1AvTWJmQ9QwQcKefRT2yVXGGtuZ+REDSqC+47bE3XhDBv5cfC1XAM6WjSPl?=
 =?us-ascii?Q?Jn4sNrBMVfX2qu+FmfrCrz0=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972df329-f9d2-403d-df32-08dd5ac27952
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:15:46.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mmk8bPoGL21QktRiFjH0f+DFd/m0NpB5wKJHJISPA2+/3CN84/MkLLomqizfPSmiSyDsTTvxYmOXyXrNbdnJgkhR6X1ZJ1UUJU03vlJC+y2Cye5qaZjzBOQjJfVQ4GF+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/bluetooth/btmrvl_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index e26b07a9387d..5ec93749531d 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -118,14 +118,12 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 	case BT_EVENT_MODULE_CFG_REQ:
 		if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_BRINGUP_REQ) {
-			BT_DBG("EVENT:%s",
-				((event->data[2] == MODULE_BROUGHT_UP) ||
-				(event->data[2] == MODULE_ALREADY_UP)) ?
-				"Bring-up succeed" : "Bring-up failed");
+			BT_DBG("EVENT:Bring-up %sed",
+				str_pass_fail((event->data[2] == MODULE_BROUGHT_UP) ||
+					      (event->data[2] == MODULE_ALREADY_UP)));
 		} else if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_SHUTDOWN_REQ) {
-			BT_DBG("EVENT:%s", (event->data[2]) ?
-				"Shutdown failed" : "Shutdown succeed");
+			BT_DBG("EVENT:Shutdown %s", str_fail_pass(event->data[2]));
 		} else {
 			BT_DBG("BT_CMD_MODULE_CFG_REQ resp for APP");
 			ret = -EINVAL;
-- 
2.43.0

