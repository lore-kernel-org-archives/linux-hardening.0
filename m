Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010040.outbound.protection.outlook.com [52.101.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0DC2D1
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054389; cv=fail; b=HRCy2N3NtIBug5xIH8ieam+JNTkcSKEhEBAxKFr+T4npII/nBb8q1OO2Zhm1uaJ9Qneb1CLFdEs5F7yC4gNyNz+QUamjMNxO7iouA9T0yApQOty/SsVp2pxwEpVKPAQscW7ggI5WTZ5EnNzz9sNcS+A1cY+23siWAik43Bsns1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054389; c=relaxed/simple;
	bh=ovUqtYsrQv2CTVdOJRlFpqDAiX77psSGAgilgVcsFZw=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Q1s09/HiGa4X+Iwee3Ce3c6dUWC7CpdPOqsItwa8LpLwyArwxg2DfxGhDbdB+xYJke1+zYDVKpk60XoTZWpjDdF+wWli2f3Vjcy0OmwbMRDJrPypLGMKO91jwn9VeaNNIg3a/MVvXuZZZoPEU49AwnKldlASTxBhTaSbxqey/WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=UjQWomjF; arc=fail smtp.client-ip=52.101.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="UjQWomjF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdUSrwTgN36u+j/oYJUGvOL4N61Ix/QHWqDU8s6mCLktTJmPSB382tTggn+CWoninYo4CVwOaNVDC5OvIpBDEu/OoHQmch/1o9JnWHi/xnkxi9JBiz0X9gttGtUlda3FNIx7fRSJkB77wd3fqBkP0AGuaS99iq197pex6JHkpiYX6hgKIyCoZWiOR4qXRyN7YLDaktkSBMn5c1HunlzD9uYIaUo+BhKKZh62CNf9tNMJx4xqecAEvpkjgwL5H5Dofw32wJLMnW4F9OAbf3h1IOAWYPmjM/f7fNKfCkKUvX/uUi7vDlNNUdsErJ+icpFUPbfMMRYRSr9JbcS7d88RNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYi489JyylepSFNSXO3t6OWWRhr2SNtbjCP2WCQw6oI=;
 b=dppk1mI2Hi1jKjYwwIgJtUcjUK4ZfDbF4Y4P/BOo7GYl/f73JugLqzGKM5TSilPteYSIqzxtNY8693KOdCVDqBaqQ2NNyy8iuMNdrPEzQ0AlT0R5hEBLzxGEH9Y+nwIM4uwZM4arqc0zlLetba8cxOK5EN7FwMuiexpm2DuLHxRm8qzgLQHFV1nm0ZwE8t5/HMkVS+d7CTdiBkJKx/QciWG7/vIo2cFvt3MKooPeHQv1KbAs8ldgzjarKl5pgMVR6FKKFfT9qPbeNbjIyRpxtqkjylS6pa/RlVj2RrWms0B4CVuTFLa4etlq4/nrj17SM1RpZA0AYhf5m06vTjloOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYi489JyylepSFNSXO3t6OWWRhr2SNtbjCP2WCQw6oI=;
 b=UjQWomjFu9LAicmJIigBVz67mUZiMQLDEUBnPPUJBGFYPRTxKFltKxnDGG5gJe+BTkfhOKsXmfHWAnTVV0h1Y8FBLQVcWvOeNtGrVMg9JcxrQJcZ9gzqJWt4yvTj1cCBylFyEfVrLj0nUSKcwfL3/wInXKyZuoKHQI3KlumFvR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:13:06 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:13:06 +0000
Message-ID: <87tt89pmq6.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 01/10] lib/string_choices: Add str_tx_rx() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:13:05 +0000
X-ClientProxiedBy: TYCP301CA0038.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::13) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cd5b88-0d6a-475d-85fe-08dd5ac219c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IoyYaqzXswSw1jrwMWvUympr28ocWI9NPzGNEH8K6a5/YbF2nimZ02xfYvhA?=
 =?us-ascii?Q?whJpSs32kjlD4zUvBKvkyrOjXqYI0F2xpeiPkg7LwbP73MtA74rGXwxAU5zy?=
 =?us-ascii?Q?bHF+SZRAhiYbIL1tPLHhVK4n72K2AZkmA2+eKt2HzYcaZjNC0KPmHGU+YD1e?=
 =?us-ascii?Q?oyELGz4mD+WyQ21o2yk/2G3OctQnL4WLeNO4SESJR40wm0PQxSYwe+je8gU4?=
 =?us-ascii?Q?/7xpSFbTqXOY/o1pj5djqXx3X1yJ2mrd0sM8oJUgc8UXe0m59TSHG6c2r5eZ?=
 =?us-ascii?Q?NFGc/gwJHB43FOUFzs+2FaaFE77Tam1TjUBdFcyWlMGaeHaX3EZRQw5JFiyq?=
 =?us-ascii?Q?HtwdmsXzm95V123HjQu0xvvfYsB3vo8djYHkzuzqfdjW7gx22sISf28FCZI2?=
 =?us-ascii?Q?3hltwPqNzTErBG2fN01sithzUdYIJL68os86jZmrmay//h85Y2A1DN+XjAx5?=
 =?us-ascii?Q?Pb5Bs4xdHxRLhT644mhoeaEvyz+zA1TdoOdme8Kmq0i04T8cECEhO+0iHlf1?=
 =?us-ascii?Q?lY6goIVQ/ls/MpL+c9RHmdJEgrBIjxXLHD+oy3pGEHx6JxkBm844SFR1l8on?=
 =?us-ascii?Q?DzCT1paj6J0/OmBe6zZ/rh38gc5LVGlK9Oz7tjb6IDTYX7hE9juIAgYt973g?=
 =?us-ascii?Q?z8qYtLngoV7iLZrESqmb4nSfZLNj43QMCYLUiZKU6V7F/vqtcS3PhqzPoaqV?=
 =?us-ascii?Q?HItFkmXJAeBDhZe5x4iCLvHb1nwYnnJ4KZePrZnwlzTYZWckatPcMmWnypq9?=
 =?us-ascii?Q?qjiBJ7+FQ3pHxgo7FTnggHdWUtfvS0R85JvQCbyEdukKkY2CbkTwrfJhnULo?=
 =?us-ascii?Q?aC3XmBJrV22i58EkGXedVGjLAFQTrSYbPRz6WAhyPdumI9VEfhNnY72uI9Id?=
 =?us-ascii?Q?8HlkvOnfyyQVWXSpKO35iMvINLZ5vwakE8D6u4MpLMCNmCYUtfDeQKAF/bJZ?=
 =?us-ascii?Q?wo5Ak5rBdJUCfxwIwEd6QAos/IoyLRNhD56+xGzCwFgHGHmqpeoYoApaZQSo?=
 =?us-ascii?Q?F4KUVjMCXDOLs8NTKv+nInx88meATKiQsk5C4R/FLgZtF3ps+TgRha9aKC0Y?=
 =?us-ascii?Q?+LCHzW9WQIr/jxW57+AqgFGizOsdOLYvdMRrag4hW60LRx7+4O8c3689klYp?=
 =?us-ascii?Q?hQ68PATUdVOHM0aNbw2bJ4B6pXPnQwBLEAm2jiH8sQdC8YK7gFKTf66wjUiQ?=
 =?us-ascii?Q?ADbAEqi+Y3TCOKJF2uEk/at6kkiWwRw41L6XgZ12cnoRlPlsN0p7OV9hY35R?=
 =?us-ascii?Q?tcgR21cT7sYPhwv/tw+Japvd1AEOFCNi4f8x+tNV22gBg70OJcZVUdsBbtDV?=
 =?us-ascii?Q?9IC8WED7QAbcot/m3vJLWadLIwLHCP/vYFq+vGnNTTwRGmFH+fRilbVN94f2?=
 =?us-ascii?Q?n0kN9BImmuPmhPxmyYZMfirIRnnMJ3lv3OmdU79gY5fpsg6faN1/I/54tiwZ?=
 =?us-ascii?Q?rJrEk8sSe2HSF8jC3DzCJO2bNkPUDFe5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?59DrUEK4fN6Msj853rlJkKn9SmRZ5dik5EapkILAJ4JVp0BV+E8onAx2GDnF?=
 =?us-ascii?Q?du3aNVzWQQiDuhgiv2+baSow+1j2t2cXmKm6gA17kTPSwO1lCHWwpSntkubh?=
 =?us-ascii?Q?31DWbcvjUxITMJ7eerOY64azGNe3L+5P/6xghwMhGo8tH8D29JHS3acxGd6r?=
 =?us-ascii?Q?Bf2v/fHR3Drl0Xd2sbx2uefFC4yZ3ulrr9LCOC/25N9p+lHHrGhw05oJAJRV?=
 =?us-ascii?Q?/V5fPSUhPjRhDc74jUp1iejrbSm043h2fx/bjvgWa7ekLZbP6WUM9eAw7yDL?=
 =?us-ascii?Q?n3+uU2PlUxMayFNdBA/Mp6N4L9MJS/65S0MIbeGk/52bvvRkWBJgZh0WlVPL?=
 =?us-ascii?Q?2StgPuL0hP2M0pQHoLBA/Nz+XZ9Vxrd12pjhSpvvjlLb5Kv9CByabmeuA7S4?=
 =?us-ascii?Q?ImMI1oBsKcJ95YI68CEyGNE/DsAxGaNvz8Y1+jkm0J/lKdLf3iiq0EWvj4rt?=
 =?us-ascii?Q?/WMMbRqF3wTBCDvAVX5Z/si+WsGBENIg5amQWKT/Tp2GnUHdfnDIw+cRS/cK?=
 =?us-ascii?Q?Xdf1LPFY4sitrGP6A0sv2nhr8361cRTMQ9uKNf4wpYCowPImZ4WVW+jspLuk?=
 =?us-ascii?Q?e0MJ+xmjsm1Hh+MSp3hi9iOIvOU/xRbvylbNe9pIUR54XhPUx+yEGBpdb8Xx?=
 =?us-ascii?Q?Uq1GirWFebdZLbGpbuyl66wKhZCevHWZDDgQoXUcKEa9W/ykLLkfxeAdlibb?=
 =?us-ascii?Q?NElNCwTFNV2AZrQgBwNXZW14oA/XzYj7g2SPv0uog+QhvWBL9SXWBRiGwAUL?=
 =?us-ascii?Q?wSObO+w2yXtlnJj8k4jMHMuj1MZRkJAgoAhSMq1vb49eVK34J4SJp+Yd+zLm?=
 =?us-ascii?Q?uthdi7+DqelisYT3EaHfYn0w2EEgOtJUrc8mC3I1uM4NcIMrLPMvj7up3uI6?=
 =?us-ascii?Q?JBnDfU5+ZrAc+yxTBjR3qOHuzG1NT3tRHzeXEioxYvZ1QIJ5VCop18wKktdN?=
 =?us-ascii?Q?d+/aLSpXg9kaUbld9uwF5sw4MzCqidmvBp9B7P2udk8nDxToejwVVMZaq/F8?=
 =?us-ascii?Q?Ebqa7WVBYr8caE3kjFMsZHAomciT4nVIoPyr0qYFYMl0OAKqTYQOEtGPUCo/?=
 =?us-ascii?Q?LFKGfTQ3vdOoFHkJuCAirK/WhWxH0BZwzy+5C+DGkD4vC+W5w/cwIIWTwNoK?=
 =?us-ascii?Q?WOM/0XRqXvk9P+KrNWyvTwj/h5pBoE7LxDDXaHC5gc2yjxpUEeCAwuIGKOQ1?=
 =?us-ascii?Q?GoB5lPZf7CrS3lfIGz6qipQv3RrMZ2ajIRMQ4P8XRhIlyOHm7n5w8aIo3jQS?=
 =?us-ascii?Q?EbK6ESvETqgWdXPKAqPuHDOfAwfndiY5Plm7XSVgbF925y4JT14qfqvfGRJg?=
 =?us-ascii?Q?uOEolgwz5IcvE5y/1nOuldcROFJSp1P6brxaaC9/lcAOV63PDO0NUvrTTHAv?=
 =?us-ascii?Q?+S/vndsJzhS4DqUjYgTtMMu3sTOVa8v1L5Q1WsLTxDTMsw4M/w5zczZsHQqH?=
 =?us-ascii?Q?ho9R7/qDuzEYSs9o5ze+ognudSN95f7l7hmnSRPAspFwDg0ssG2Sl3RFd8yn?=
 =?us-ascii?Q?SmHNwgop2vR9460wUD8mFq50JUt96hHO4k3j9xm53GsXF8Qwac8ZkEMd0gsF?=
 =?us-ascii?Q?7+Cy6xuqZik87kTebnaJSBHPQOTZJjBzGuD3ji0dAxvYDD/PlIIf14wDQgGv?=
 =?us-ascii?Q?7omch2ZkTpQiNz0Q+wcJpcw=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cd5b88-0d6a-475d-85fe-08dd5ac219c8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:13:06.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5g+k4yIfpGVzgumf78Wv5a4Tiko7de6ARzOYRCPbnF3wdsNV2Ou6zed9Tp6OwjxPv9UmzsdKyjFl/YS1LPwcopDsbjORZ00A/yItInbyMTaFV5HdIz/R8ov+WDUIv5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

Add str_tx_rx() helper to return "tx" or "rx" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 120ca0f28e95..fbbf1e657806 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -71,6 +71,12 @@ static inline const char *str_true_false(bool v)
 }
 #define str_false_true(v)		str_true_false(!(v))
 
+static inline const char *str_tx_rx(bool v)
+{
+	return v ? "tx" : "rx";
+}
+#define str_rx_tx(v)		str_tx_rx(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

