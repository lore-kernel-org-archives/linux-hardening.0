Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011055.outbound.protection.outlook.com [40.107.74.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8614A60F
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054413; cv=fail; b=f7syRzc9LRakVDn314C3+vI1k9VopjktKVfHc5Df6GPZOn86gFO4rkMbmtm2jb1HLTwq+b645oOjNdJ7FqemR9NTvWCMea5O9L79heF+xVlwE0tvWSTrrxlXxfAXuOiqCfJa6+WblJgG3vpkQ/LTbU8wAYw5zG7MxVmcYJDkDSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054413; c=relaxed/simple;
	bh=eHtXr7lFNFpmME2NY0aXdTnJmiVvUeYO2FOTfOgGiEc=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ah1wCraTftQiJ/xbEgJ0NRyZI0JvDibWeZca5YD19X8J6C+oRftWtGi6VKJv89RMCa3II4A/XZcm+Fjv6FDiVDFny8ARYCKPdNinAIFiF3jtEYPdINTsfs618DGgKo69iw80zjdwxFkVFHggyPbIuUxrJMHzkQAiwKoiBWGSrX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nL5CozuK; arc=fail smtp.client-ip=40.107.74.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nL5CozuK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAQi/1zB+aHD7FEpGyN5pMyLqzJS99VdpooHbqnoqZ1KS8EbMOi42TZgfhB9kc4uC/NGo+HfvAZpQtFZlU42Tb5UOwCo/wRIRXVGGbd2cBu+e/Z1UrW5gTek2hZ+HJGFQKLHYPKMio6iSSKVgsmmw1VMR4dCNp6EvRcMCqGdcSWZ3oLzHOvBRXKKE+VfViITbDMhFt5ShoCJQcGnDA9I+RCOXtm5cYcZVbc8UTqJ7PCz8DVuFJuwFTYyaqRBsB4ZKOr3E/Fl9VU5Y3sMLs9AsoajIUf2BfM8cLxASyhP1y9UsN13RM6NBUNclgD1hRJ7QhUE1gNHpCtPaLqc/Sgetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TidHehJt82/3JFO6ERI8wCnSSIZNfjMusUaqZnRoQBI=;
 b=IXVGKrZ4VrN9mnp5Lr9v/LQ9RInoWZ38dtqu765H6K32YPC/Imr1xYzFghZc+LArqkRNHOTmnvynXINRt8sXAl77Nmh0V7lyNOvIL07f61gJrOanSlr11WAjvTv1nK2pgbGYna8zhZZLPtkWbpKQfnEdHy1jjy4Xl0uGcXlR5eeQNnlI/wH8T2SyBmFMxl5AZ/FVavHWBSlnfxk7UueA/GgynqQlPxRGnsVS/UtbSeqGUGU+dbslLnk1BQCxYPxeGm/wwUb6k5OwcVFFY3bB/wvBBqQm2jhEKH2MULvnQsqI41IwJ4Qa1ppwlC83lBkZNIGKYnGUOOTUBeQ+bnmX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TidHehJt82/3JFO6ERI8wCnSSIZNfjMusUaqZnRoQBI=;
 b=nL5CozuK3SNAL5XrXNece1PboBqkH2LEnZezzLFNrco5ajRfumgdetN/HYiLKxnI/xgPT1qZ07jGVQEP1JbbD8kbkSZImNuyayU++NBBoRL6XxVt6PvVtenIL+K1KU0LPkAQNE+SvLCscLU70qKnCBuFMNtKXTtSYe/uwnK4cqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:13:29 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:13:29 +0000
Message-ID: <87plixpmpi.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 04/10] lib/string_choices: Add str_input_output() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:13:29 +0000
X-ClientProxiedBy: TYCP286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::10) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 887e9138-fa23-4003-08da-08dd5ac227cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ck0hFNLEiR4FmpSIzkSCUNxIHTX0ngoFlZugWAceM3aE1b30DYKOrLz65NLp?=
 =?us-ascii?Q?FR05q4uuReS5f2wS+ULajif68TJVxn5GP7ND9NnkgJkkp4Ou853jolZMxZtU?=
 =?us-ascii?Q?AUw/8vKOOfH/lnfs3ei8zcM9M8QMfcMO0wnzZZMSddRVgxmBiad+dIRSSYIm?=
 =?us-ascii?Q?XqqLXoLxhIvpVmFRClD3Hk7cF5F7NYsBmy6dxkPj4f/bwjkLMiHlxFnCwnRX?=
 =?us-ascii?Q?jUiG7NK/Jf2P62YQZw1gZxZQ3/hDxbxQGn7evdY9QWp4vwpaGJi666VV9qkp?=
 =?us-ascii?Q?E7LH5lmsm+5ZHg0EznUzJv8goZTAJhDz80s41QPCGHDIm2zILkEK1NkP/qBq?=
 =?us-ascii?Q?H4wFpDFqZd7/Gq21j0vb2lrc2JPNykAA8V5WwStExybvJ8IRQnJhbQLApCTk?=
 =?us-ascii?Q?OQ3Tqa/6SJSWVKO0ZUsm2eDH7/ny/pKzFiaLLQwZLRHzm1Sc+Qew01PQe1Bm?=
 =?us-ascii?Q?b/FqmCKwgM4lRttaqcHqE5nsRtC59Qa2SWMl7utnVpfxP4Of2t8yuz8fbKkF?=
 =?us-ascii?Q?OhudrhJ9DSAxYz6pUS8+MPsC5AzYSWrPL2RdBcTxkufkvoqlZtKDAxgq24Fn?=
 =?us-ascii?Q?T3zjl65DcDQhu3jd1Myd8tGtL+nglCx1eqwBB6SA/yClJN1LAZE7j1v4seGu?=
 =?us-ascii?Q?Vp7iWxsuxTa6dWP2RSA5HRJGK0vvK/Oqc7wSjDWcOcfpHN6hx08+lHgsLs5i?=
 =?us-ascii?Q?yZdrLcxBOX2gGKxAXbmFBMRHDNzVvGRwuN6QA7yQgSiBht7jMYuwgRGRzXxm?=
 =?us-ascii?Q?XpDa89hY3QUuEW6AijznlDKEeHdaUEtRffn9G5oKTh6NFXEfDZlo5OGtoYyh?=
 =?us-ascii?Q?T/QCPXFPrph2xDJzlWojaC6fm7EpXqtVpD9/FVTi57eza00DbZLhKsjw3D/5?=
 =?us-ascii?Q?HAFEugfGGVpRyFrdt6EpNHGmk5uepjUb0aWRlBVHvfX3ZAw2+qnst9M2GmLO?=
 =?us-ascii?Q?PsavwW+MsI5+twAhl/GxSWT0ggQKVMXKd8LKyxDv6LH9kZ+4hC0vYPv2IOtD?=
 =?us-ascii?Q?l/Q8cS/P+OTG2vWsutwX3ZyBuIjs1xRseEiKYAiENtg3+NWUW7zO+qaB0DVk?=
 =?us-ascii?Q?Es31UNY37fEPOhCO4fkkFVtWmBXORPIGyclBy7OFGt/1NQFVsXDgBx2HWJ9l?=
 =?us-ascii?Q?MG4MF0ZQ5agi2boXdLRC1NaAiiPTcfHqssDPmqH/uAHYge9nuXhUmEdSMC8J?=
 =?us-ascii?Q?67RTdHTzW28FvoiIPB1Q5UtZ3wK7IA1PVrvvFG4Q3Hfuc2qHxbS/f+luN6sC?=
 =?us-ascii?Q?3V4hVsSiH3qIrK+M5+9CzhgNID1JJ2uIsFvMgYqCL2/0t4EJe2SDxGmRTiqi?=
 =?us-ascii?Q?xK0gxkmzJ99J++5BZg3gNurj0P4stgATH8s5GuqvR33tVSco5ZF5BgXm2C1Z?=
 =?us-ascii?Q?tpjVd3T4d2r4i0zczMhT1O1c8U69uSjzqbLUkFGF3rXhlsVUGNQCshWibx/1?=
 =?us-ascii?Q?c/T07Kofe1SzZEsdEog+9pCaKCi1KHNN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/LUzI9fAC+2Dage121tjfkBko61HTv0miPW9PY2x8f23bC1lr5Njv2uId+o?=
 =?us-ascii?Q?4XY/T2E3vySmM+kfls083lNwKqIqn8Mgvb5KyVWuC98mO++oTMkoV00F6CBj?=
 =?us-ascii?Q?9DLLiozDOdt0sWsSCy/MlIifpkmBvet3zCq9twZoZqawIiHVlSfTL50E7jep?=
 =?us-ascii?Q?XqZrb5n01xwY2HYiq+BpqFFvW/xtq4BE+dPdOtBjMXdFGphXsUefMc3qshxt?=
 =?us-ascii?Q?PDa32+68HoCDeEJUsyHyplbSCgrMZSTAI4C6ratn2MLyDgDN1V2dgSrzzBJn?=
 =?us-ascii?Q?SgDOSelY0s94zMOm0DOywBxpXzQHp6UuhCsskHJUtLsSysvXo9YlX1f1m7YS?=
 =?us-ascii?Q?FRQgjPuFeiSE0HQaGRIovXi65lgocL6eCHlD8C2ghZs8r4WKkRc/sDtBR0P3?=
 =?us-ascii?Q?L0FRHUFJQCM7dcHg6UoNmRfDWYR3dsUq1xj15UVe1QWVle9qvVQFYMl7d3Ic?=
 =?us-ascii?Q?KgTB0vLJuUIOYo8Q9A+WbnuiUnPlMM0LBlvtXnFywB5uZdzux/KBlOD0+Xcy?=
 =?us-ascii?Q?M1ovG1DxRLFfg6tgOavg3Z0oak8DFpviJp0We+rNvHTUawzqkjTS/LfYLxcg?=
 =?us-ascii?Q?vK0lWBK75iUnhfis8bIcA3H0DutI9BKbt2WG8QmkZ+8t1C3qUEs6fQpeTllZ?=
 =?us-ascii?Q?LNOCMXvH2rkwc2GWPMnAHV35ipOkA/CesSynCUStmSonss2ZJSpQ+ItTbJa8?=
 =?us-ascii?Q?HOwPbHIH4HTCmCK704PUs4jatcOhGHI1WTgkhQPYe6ORnfWeQS3uDDcJ8Kb0?=
 =?us-ascii?Q?OszKW6dcgUdn2KuRbeyZaseBupgGjMCKXIa+gSVL56g5ttn3H0ckAOE8+pyc?=
 =?us-ascii?Q?PWtkphaeTOlzt3ak1coK6XI5IwgMggtDWuJXtPj/jZBt5VkDC449p+XZFOau?=
 =?us-ascii?Q?BN1Q7LvYpwCxqVG5tugf8IKoGaZM9jjd7eApXTdnt2NGAPuP+6THHl5cOKy3?=
 =?us-ascii?Q?Rn8NS8POXJd1+mOgJvCzql9Lc+lxosjqss7a7xMH4jWL45mb33qDNO2OWt9G?=
 =?us-ascii?Q?/BPM60a+L/lMjVjgUohSq6PdWT4p0cLshEv96I35G5KL/DuFQyow9WKGkBo6?=
 =?us-ascii?Q?oAz8ySirByr9goGWj6XoeOFUDMch2MOxVDQ/Lf0kpRIgDh7QbNHtLYeHT1yc?=
 =?us-ascii?Q?G3qHJbWKTUYJjyRwHeA2IggrjGaYo0xdba3wnSCAD+Vo+nDSlzwwnWN0rE+p?=
 =?us-ascii?Q?bhMwntWT9pm6VWY+cnhkDLg8/tYsmEbOEPeI0Jnxnc0GPw1YTPbsKVBsmf5S?=
 =?us-ascii?Q?AqswzvvykwsDeE0JpSCYmGVLc5jILCzNk3Zn+uC1XwPfGy+PG804skaSV7LP?=
 =?us-ascii?Q?a1aRkokNtfGqQofeGFWZelWR8Mxn0hNGVvcaARzg2J9Cj09cMLoQ5airL0XR?=
 =?us-ascii?Q?hwNBS3GIQ0xv5LeEBsSPa9Rc//FbVqkCyIpjLFT10U4uiiBc5kHnRBKcBUpy?=
 =?us-ascii?Q?1QpBKy9Q9K3Q1XS4np/COTUgKATZTHY2Hk6pZJdPWwVMli2l8xfznrkzzvVi?=
 =?us-ascii?Q?P2d34uTOS7seiPhljkl2vmF/0lt5sOqO9EcozgI5bWeoA7UlbKVe8t/jnvK5?=
 =?us-ascii?Q?vJKD0BG8ol3xZBFSND+l+tVn7afYEit2FxKV71+Z+m2tWpv7HiukFSMe/pay?=
 =?us-ascii?Q?1zdLUEpZxNNr5gDrPWB1kgo=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887e9138-fa23-4003-08da-08dd5ac227cc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:13:29.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzBi54Guu/16GgMCQOnfIdjqchJ9XqrBXXJPSkKz4KYCVzhDS3oxfx8R36gakqFX1ac2Xuh+QImmOxizUCvdtpqdqEaarj3vpXGcyzz6DYr6dXE/WLV0lMkX8A2XQPiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

Add str_input_output() helper to return "input" or "output" string
literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 96b54874dc3a..cc7c771f4e84 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -89,6 +89,12 @@ static inline const char *str_in_out(bool v)
 }
 #define str_out_in(v)		str_in_out(!(v))
 
+static inline const char *str_input_output(bool v)
+{
+	return v ? "input" : "output";
+}
+#define str_output_input(v)	str_input_output(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

