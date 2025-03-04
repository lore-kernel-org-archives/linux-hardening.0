Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011011.outbound.protection.outlook.com [40.107.74.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1314A60F
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054418; cv=fail; b=VeT7pRTmQNk2S98zsreuT9b1+qimsweHiKBBptp4IwsddSvyrTaPvMiasOEVaQ+8HGQkoC4zUxr4F8Ty3/+zpGehjoa7GI9VDj/f2SgfMNAAgGGA0qCNpEo54DAiQhsfWfqZokAfR/aIwXitirGNW15nZK6WtKDZBHMcAxvj2u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054418; c=relaxed/simple;
	bh=iR+xzjsQ7SeWJ1GUAB7uFdcttJ+K9cS1XVx4Nqlqq7w=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=I/9kqx184srof/oeJFM7fZpzIl+ALeF/353EOUMsdQ3wXTcPic9/Ivb8DioKweLuKSHX+R9ucgahHE9dyLEZE8M8xDGb/mtoF5nW3pPMdJ5LKNti6FP5BNUz0ltzixEcfWw2nfYXFMjnyfe6FGAnQjiOZdW27BnghO3oHaXfce8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LXr2fQdR; arc=fail smtp.client-ip=40.107.74.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LXr2fQdR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWalh5dJYmXjGgrkuTqjMcbQWNJdDZ6lEGgOyM9G86ma08PODmdaWB6QGe1630xh/Ksj/WGfV0pPoKJNR3Q56f3B1FQqAcLejT2KMJHgD7iA3cQuMtlSxD+vYbol0ZDsfcok6BUersEUAe9LCnAvAGFX2tJ/c0DrBNpWmN0WifQMqp2FPMCZszjHTIpv+YnmszlaaH+R7daI+yj/cMgZ9KR0OBDsNfIUOZz6CB2qnNvfGBzI7Og2hCoF2n8QzLDWb+uvbHtwFHsdDMePZag3ecnwlBB5ozS2KhsNmzaeGpdsEzPDFU284cqZle9HeHTxacnXKrHbYDeJJVGm30jCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKaOxRiSgjdgJ+313jvQSegrAXM9wtCkkVVDM7hk3dU=;
 b=v9h77kZbbmrsEsJ8y2XM7BVF9VJ/MpykxelSW0IrghnpG9pK2ZAFH5RwSVbLvAOIiTBwWIyWhM56X4je0g2ObD3hST3IKmJzEQkhD4oNf2CTiwHc/wpPGCgA8Hmye5b8sOnyEAEBw0edlX2U43tQqYxpF0lM/ijCGJBUBiMrd5f7RRE7dD8bIdlrtkqifIgAb9DqZf4opsnTE+qd6B0AoAwiBGN/19PV/bOYlFHw+d9GGSgVyXbjO8HjfjZF9Ax66yA8E9iN5MmIGOMtFaXhxykKBVu216NRGj0w4BqCZ9Ykys7zoyWXRjYZQzRL1mb6SEqT76C3tyNbpM0T7xa1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKaOxRiSgjdgJ+313jvQSegrAXM9wtCkkVVDM7hk3dU=;
 b=LXr2fQdRccx20R7AgzI4xHN1oDLRsOS/oluRKpSzrFEdOYmUkLI6o1QvJOwGEh+jjRYc6aYHCtDtlPOEAu0HpAVuwvLNKVGoiFv5c7QbZmggPYxXSOAHKU/WbYVwm02l3Jgi3JWCZUR/cQELNM5UGvD59wmY9N6IVtcN+JQMygg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:13:35 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:13:35 +0000
Message-ID: <87o6yhpmpc.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 05/10] lib/string_choices: Add str_Y_N() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:13:35 +0000
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e7169c-3432-41c0-278f-08dd5ac22b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZrUU0/a5+1fRK67MXMgwnsr3ZKCDkVgThCI1i7DIlBBYGod06M6w2jJpcw+B?=
 =?us-ascii?Q?jt00/DOaaX18AuLNdGAj/YwHgfOoijAVIF9KvmoikEbcuvT+XcpKR+wb1kjs?=
 =?us-ascii?Q?bWkiWFgTNn5fCeaokrxXx/yhJGKAiTGWL+iCmSSRtmPtm0tW+eIOnQx4pdM2?=
 =?us-ascii?Q?1WXWQQfP0meIkSgxdSvSYJKnLiWNj+oNiYDqazGR2uTedA1tYNBCbX0cCmXL?=
 =?us-ascii?Q?sGVx3iuiGsjy7O1f9qANLa7+65tGF6WvL7J1Ay1wVn4KwSRx/2QWrmsXIkki?=
 =?us-ascii?Q?SbKREpER1kL+8dWoQfEgLubE1rVCIxvuU46SFTNqhMFjLFzGFCjzUcHHytns?=
 =?us-ascii?Q?+h5Gzjl5bVyQc4Elz4kowiN57GA79PQvCMgbeqtwOXkjyhGAXwcGcJYbChn7?=
 =?us-ascii?Q?tGipW74qWbOp5e6uF0vjEPuqdx+sqt0ja/272JqF5POW8F7vTLdnweYoBu2h?=
 =?us-ascii?Q?SfTuYjOvwDDIEhTvDT0jdnpUiZYc9bpPalhuk2K5k6rk2cVZ41G76hOchOra?=
 =?us-ascii?Q?q1o8zSkdm/cMlTd/hK3NkePsJt4pcUucbkZL5GcqN57uMjeqQU1TL26nwALR?=
 =?us-ascii?Q?JadAWX6pUfdBfZPKuSRYfRP/vioZHtE6JaIcuaTBpycwv7SRDme2Aq55dc9g?=
 =?us-ascii?Q?XEm5R/UPo11DIA0svS0hXtxRdJ7QRunGixOyHc9Pxrc80T10Kzqb8jfzlDC5?=
 =?us-ascii?Q?Bu7uWRiBcANEUHi9e3DeNKI03zWuwFzwsUzKl+AuB1wxYs3lbkj7xtuBT/C0?=
 =?us-ascii?Q?X36dnww1jd3J9spjzX+LHXPBknDTsxYOxJyXJYsaOO3JZ0EEpZf/2LcPQk3o?=
 =?us-ascii?Q?qjsX3KJw+BL04fyO4aV946DJ3GoycXQeUocrHFCxXnbHsXnZx4SBTcIf/xle?=
 =?us-ascii?Q?PuiWwcTA3/ghH6B0CLG8rNo7qrkbGn/SmCca7zEWqWWmsInG9s6Hl4XakLYD?=
 =?us-ascii?Q?BMxyNXUlfmoyzz2lCycUj+00LYLzmK1k9ciQU7D1EMTXVlSDrC4Yc7MtR1Rd?=
 =?us-ascii?Q?xbSdNAlz7Zwn0RlQHTAP3JqXl6WLlazPRow4TieP2B69nF6RsOiz7CBWx1ig?=
 =?us-ascii?Q?OYJK4DGtVyDn5zZjl2ka0JRD+7fEu3YXTLtVd87/F31WbXWHpGU6E4yG8Jmg?=
 =?us-ascii?Q?JQHM4UIutwpZr1jzLME9gwjJoRWtSwqgyNrWOscWi3VgD8WteETL60sBA6qZ?=
 =?us-ascii?Q?zEyTBVQx21NhwwZtogjC/Yhsdx7jLwB7yrtxxdreoDf2Upuf6He8bWwRialg?=
 =?us-ascii?Q?5IsIUNexsskzuDVEiQt2SOXWLT8MQIv3+90VFeuPwNu9spkU2BvheAOc2ZDH?=
 =?us-ascii?Q?F3gUtVCMwi/Ikctz735i0ayjZgrb911y4AiQh+RwvQm/Hu9gUJT83kbgs0Jo?=
 =?us-ascii?Q?1jgkRgIhnxiZexwDGE3KuQ4SqKMwA77lyKfO7llXfNB63Xi9FCEqGfn1qlbw?=
 =?us-ascii?Q?xATqukvD7Ox2gN6T7i0xXEZK3KfaTZX2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//Hb66gpwrm69kA/cVO4K2fV2nU/4x7dbbdhc2Oz+sbr9zr7058iWItn/ZVC?=
 =?us-ascii?Q?g+0b6/UXl1j9dz7A5yEd1b2PKqutMRZNklSeTd20rvto/5F/k7qy0ns4Y39g?=
 =?us-ascii?Q?peai/bMWAKBoabklDo8wV4AOSMkq3TaoKLmIsobJjWsUSomdnuVGW95+5DsJ?=
 =?us-ascii?Q?PBa/vEtjUE+S0TCn8QW38nICbbBb+AP+RB+N1zPjlX3ApZzVL9HgUJQOi0U2?=
 =?us-ascii?Q?BCC47YjnkjajCOcieNItgLcSw9kuL34FrtkMgqsaxRvN1N/a1JMF0oG0x4wi?=
 =?us-ascii?Q?+ENjs6Nn61u6EePSzhYeV+XbAHdyt6NdU4mIjabynSc/e1FUiUzUPrefEIjq?=
 =?us-ascii?Q?by4y4tWIeRxJbtVLlsSCoC7AcJb8+mksr+Xweqojq0GUHj8qjhFjsjyHSobp?=
 =?us-ascii?Q?r1EeQfrQYwd+2h/hDLTfuQ5JYxpV9Bz91hWmvpnKtfAtEdvz6e98+aubLxlA?=
 =?us-ascii?Q?YUBxbnBRIxZ6V6wgDOPueWJEpC59PUJp2wG/aGAPTCUyT3NV2M5th1GttaLH?=
 =?us-ascii?Q?d9+yePJY/7W+DeowDfM+gncWB2CdjxlS56Su5TbAZvQOTMjHhYR1PoDvJSyd?=
 =?us-ascii?Q?fTwgN05+PxB1ddMcRz+qDcF9yxShfVginNDMcsOmYyGBEdDSLdQfEA2Go/TQ?=
 =?us-ascii?Q?rRbxJPVNtfhbAwoNATLwcQGqJDxwKx7i/aeRZL78XPl/oDbtxfdcoOQ98rYz?=
 =?us-ascii?Q?vQ3XZfHh3yaHQZ8L11Zh8zRyvNUElW65DVcbtYD7zxTr4+rItALWRu6g4quX?=
 =?us-ascii?Q?Sy0rV1VVZRTizRM4BJupn2JhlbCnnLHPiy2lJcZgGA1loGDvkm8WkbFtBgOa?=
 =?us-ascii?Q?XPRVKuYCGf837UNTsjWOT7N60CSPqubwALePTtxx+3fiTll2zLj65z5dTxkr?=
 =?us-ascii?Q?ctu6DsX7qS/rnex3C0ModyseGsz3796QskGFqDE9ck6FhNRSl90I9qYXdjio?=
 =?us-ascii?Q?ocxc/yUiQYexPVC2pGKMIY51ODX3b0ItAmjWkSncqno6ZRH4Quwdi7WVEp2z?=
 =?us-ascii?Q?u6rxEypJTX1LeD/wBchMdgI50f8FmcX6McQffd0OFJqCEEJykUkr4FIljgKV?=
 =?us-ascii?Q?ii38ska5QAeIvYWqEo6lWtLUr5UFNpNjMZKyOD5xr/P8+EDXLVWejcO//lla?=
 =?us-ascii?Q?9f/qYXIuwAo9cM8NXaPr6ig0ipIm73Kxhdm7TcDAT+smXflazcVNiEgcwemx?=
 =?us-ascii?Q?zPiKCb5ztgvv7E+WA4wSXrwoySf2TIelFLZMP3Y583PSFnVWBZLOiu/yDqrC?=
 =?us-ascii?Q?ozKj8N0NZfTvfS6HKXIRVvlr0hLOTTd0enpm+23H3BRz0eH2JuHHcIqJSyVa?=
 =?us-ascii?Q?V1AXVqP5CNHxrE5jA3T2Oo4lP9uKOF9eiaLKlrE975lmCcJxIlrQEnMQ+38p?=
 =?us-ascii?Q?hJAqwrxbqGgT7LqzN1qATDZJvLE1Miw2sKdGHk3S7uJZTL9N9tbVLjAlcc+I?=
 =?us-ascii?Q?alkPWoPLjIUTneKgbEaxIGuvrTY/q4RFrd4cady/Y11+PZS0qSbB3nXw8g8c?=
 =?us-ascii?Q?Z5vZiORuzwrcba7zxq7SsyARYv1ET7jtJr3s7lX8mVgOJa28hXmOJLwijZk/?=
 =?us-ascii?Q?+hK/FDMWZLBUA/iaLQf+HfLRGzq1H787uO8Up5ECwhUaCJxxSHDG01b577t8?=
 =?us-ascii?Q?uOr0H86QEA0K1O2AgVJ9hk4=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e7169c-3432-41c0-278f-08dd5ac22b84
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:13:35.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgUZ7zLlEGyZYAwsK4O/0GK2e8VaweeKDbtvOobMEIfHkyt0oHR8l/FbqhfLHofFlPJKzNRDId4WfrnbooMPtmTOMUMkgvCR0RZmT8x+ckQsZJMnt9eoYFbtCusfNxMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

Add str_Y_N() helper to return "Y" or "N" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index cc7c771f4e84..615ddbde4743 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -65,6 +65,12 @@ static inline const char *str_yes_no(bool v)
 }
 #define str_no_yes(v)		str_yes_no(!(v))
 
+static inline const char *str_Y_N(bool v)
+{
+	return v ? "Y" : "N";
+}
+#define str_N_Y(v)		str_Y_N(!(v))
+
 static inline const char *str_up_down(bool v)
 {
 	return v ? "up" : "down";
-- 
2.43.0

