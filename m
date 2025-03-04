Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010010.outbound.protection.outlook.com [52.101.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810413B58B
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054430; cv=fail; b=PM4/XSyICTBdM+nsyc+c7rrQkpY+hQBNpvTcBkf+5JIX9U9an8V4RcSM77UUH/9VWF7p+/17+CsEbdCW/RJiZ8X+f1/hSQxh2Gel0e+NrHSkc3cuPiE+ey7Au3OjLSdIqd8F9boLETDIrBWmvYwQM8amX6A2vWwbiTnrG309Ews=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054430; c=relaxed/simple;
	bh=95biLjit+ctlUjhzA3cVpg198I30vQIDXSKjQKLqOEs=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=WJLNEf5J/C1McL1I1vdzlV08JIJ6MG+ITbx+xMuqQLdARxonRXNwTek5OeJRejmKUfuas61q23M0QzKd6gs9giGY+YhdlrvvGhBFXYFmJ+maogXt5HKF6EJKpiTZHux/K1sG4FegLDDYk3aJKmbJFVc1zGu+dv/U/ozBjmjaN70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=b+Qpxlg7; arc=fail smtp.client-ip=52.101.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="b+Qpxlg7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jx0EEpi2eMQgHeTO5LYLM6tmBAL3IgtofHgx7nPNtiPUDdGkr0gHYs6eIsHRPWGXMPCwd/ddWDwZ2N/8vvV2P9bDH+nAe43miT/9MZlCFrylm3VImgLDKdyppyHOjyUtp9M8P1l6cgYGYov3EgL7yyS1LTTpmRWRt7HHg2MlBjNgDVvmQWYjbZBfdb7TkIb69pU1aENtxSlh4cogR1KINYPpShg7Xc4PqsKMQgqQCHZMCFty/6MFLwC0BeL2DrUOMXwdmtDkkxJB3jAdwkW5Er1Pq+EdptfumJUbWOpILHQBb14VryIPPNHMmvuKvMVpGvcS4JfbYcMcKdQLxhlQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFWslQev2NvqM5L8u2b3MBJ875l+L13aLP3T+R8anPM=;
 b=ZumIowNCCYHiP5dg4AMExp43a5gODwiPKfi78g4zCum/I08kCGLvOm39MWJjzqR9lKZi6zhdQIjQzUf3fCZiBqAUR4uNaDblunGdOdZVXYO/9o5OHOfMCKffKf9ys5FcwIWviNHHlrPXV7EEL2ra010BsL/zqn+CG5akUJ2dtR3r21kwTFTefrYMW5TPCRwlo05yXuPiC+o+ybs/GMOkpj6dJGqzCIj4o95xDSmBtIxwTl3MYrw5mlfhHD6L6HULESIrmcRJnCrFHm2CrnMy3ep+FSJArmrBIwPfUjZRps8pbMIeP42DaSSLf2D8yWAzxsQHc9LXXJIS0/mmUrXaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFWslQev2NvqM5L8u2b3MBJ875l+L13aLP3T+R8anPM=;
 b=b+Qpxlg7NHccuPA6t0J7oF1F4J323BJ8KMxrEnowmGNXcLjYcpFCUTC4TOHcElfndjqnvdASav7dPUQwx06CRFjPJoe/n3ZkF6qoUvXeGuknvDpwl8mYna5/zFSoxLLB01+B4hGoeLqwYqILX4USH7YWEdBOiOwwgZN55R761Gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:13:47 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:13:47 +0000
Message-ID: <87ldtlpmp1.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 07/10] lib/string_choices: Add str_to_from() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:13:46 +0000
X-ClientProxiedBy: TYCPR01CA0192.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 89869d11-ed93-4b54-d3e7-08dd5ac23231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?55FE3CkwL/f0BR3wncZnlG32/YPkMizsZ0ce+i3eZ4eUvugMy7x1I/Uu4+ii?=
 =?us-ascii?Q?3j6nwkSXvKPImBqTEqp6STKQUH3l8k60bHmTAH8//c6Zn5ioUOD1Wk/nI5T+?=
 =?us-ascii?Q?/e+vp4sShiIEgS1tMnlkcR6B/tMVWwdXa/Nhie9b+lmh52NulZ0uZQ8DSuzL?=
 =?us-ascii?Q?s++h2syX1EDJUbPTsSZllqGfvzryw7VCJ6XPJQH0WwQRUgc0XHChneUQeo5N?=
 =?us-ascii?Q?c5sheixW2vzIkUwksWZKoq8uZS5vo4kmjyMOwrueeolZxFuuxjQWJAJQW5kH?=
 =?us-ascii?Q?cS+U217fDGkhsZHU0Nfe3ISdYWPDl9E60sM2um4T/vD9rO3SOFMxyiyWlSNi?=
 =?us-ascii?Q?0dO1+4EZc4T8fnDlByYYmIxesAIhYEtZFWG7zwGBO6LDIoKkzTpsxUQMyO0R?=
 =?us-ascii?Q?sm4ZVNXOBU5rtAbQTiSpHp5Kfa/+fcZFgDbqxsXE6IDELESW+lh4bpS5XtVt?=
 =?us-ascii?Q?K68HYGG2ytAgIbpjk6ZLru9jbFKkY7KAw6iFv8hFM1cEPwmWayyOfWgo8OLr?=
 =?us-ascii?Q?H5zhXXEOYcVe9bOvigE1yXEDZlFxVA60sxMgJ8RK0wPheldnRv4Vqba/4JMh?=
 =?us-ascii?Q?MAPX/nc/3EC8WCjsNs60MJluA3uRB8JEf+lkqPfn+tZrZxuBj0AZjq2ddd9P?=
 =?us-ascii?Q?d+uLxjIsWMtvxuu0H4/m9lCelSzRP8Smx/dOJPenXxkg4YVc+GXUjSt5niJD?=
 =?us-ascii?Q?4T2dCc34UymHyKhZUceAnLQcTOZYtV6PFiJk2xhAoUw6fno1aZO2qwx9HkkG?=
 =?us-ascii?Q?pt7foxaC1kMXGdK891DkaVmaI4iyqcyJEDLYAEvpPTxoobO+qUCxTqdwVLXH?=
 =?us-ascii?Q?778osp+QIkSt4Rm2vUUnTw7xukzMz/oDCyjsTYdb6xWAhdqA+yZbH3KCh9mR?=
 =?us-ascii?Q?rwMfauSegMks7GEtv04AhpsDXD5L8q9w08LO6YFhdzmdOa/3WoLhBxKnXfyq?=
 =?us-ascii?Q?l3cQnqeXJl05zaGk/5QoDsrzQJkw+wu7eAolEDMi3at8a4LP1Zket5XsZMSe?=
 =?us-ascii?Q?0Tn2Fn0/pSV+yaOfrJrKVWY8SzAN94f/c1pX7KLx+lWbtIwCqs3UuEng599R?=
 =?us-ascii?Q?D1JWQVGqS4FlKd7/Pz+Mr5/g26ZtuMYyNSPZYRDUw4b7rFWQX3c1ZRIN6fBH?=
 =?us-ascii?Q?XQ4JXFHWRFPd8fAnUbMYMjc8iSwdBVU5RKhcQI2Gtz1NFh1xZNMseNpD8okJ?=
 =?us-ascii?Q?tQf/AltHl+Ben87xWB97PH+knJs9YqqizDGzYk+3h5LgEPWgV4w2UI7KykXd?=
 =?us-ascii?Q?yPMopQqsyrIWg63ZnzBXtbQcYW1T/wc0f1LSCV0LqOm3EpAb1TA7aWtSx8t9?=
 =?us-ascii?Q?p8haBBEf3dFIxY7ykaIGVVllh1tIEbn14tkAEG+r8NLNynov3JjW3xqCM1dx?=
 =?us-ascii?Q?Tc6gQNJyzC8VWpCfBBuaG21xn2BGNBNKyqcRwNJU/ZC5i7/gE/hxr7KHY3QM?=
 =?us-ascii?Q?alWPu7zlAqMc8seB0ULoANqQoXx1aCqi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgi4hy/SLhYyvjxmn+GSjHrivV8P++y9ettWcjJx9rLGFpRhhe2q9kmUg8O5?=
 =?us-ascii?Q?Titpme51jGgnYsamJRq16t73cHCIJkZ+fss6qibOXp59He6ojeMgo9XJi+Hi?=
 =?us-ascii?Q?DqMl32jmh0Q33s0Ssgu/flrsGyiKF/2bqLfIM0VF9ueHbTZvPptgmIkZ/ObH?=
 =?us-ascii?Q?yy5g0U+xsUYZoxsTXeQnVIMZOdo0PzHJBjA3Y8Og2/XQafNOb3bDGVOdFOso?=
 =?us-ascii?Q?tzx1Eq3S9xKcKDtFFPG9LUSwiUS8eQ5DUNVvumWPhITJevG9pP77tBHIEr2Z?=
 =?us-ascii?Q?4R5FwO3uNnFjdy0YzlHuwAQ6gjQ1u91lWmceCVutAUABhG69x1wFttbXPP6m?=
 =?us-ascii?Q?UGxHpjlYdcpnekQpJdBsJGxlP1MTI9oo9X7I2yF592H6E7GJ9zPneaRBbSXa?=
 =?us-ascii?Q?Ux5NA49cv0QsOM2hh5of5s+WxaQHlivqfRlySOSlBIli4Df/e68hlAiJEJNh?=
 =?us-ascii?Q?mbNaU06exvO0lpezb+Q9Ov+++9o6EsKn/Od6eLwyfLfKwz3tyyxLHA/8CHaY?=
 =?us-ascii?Q?4n0p9U826gdFHYugdYPpNLwtlh5P5LrZzoCb/hdeAI4gV6VPYtYekcwP7xTw?=
 =?us-ascii?Q?hEtCNCXGBAzDPkIpt84RZ7hYwQTCB177wybgBSCroClzO72yFKahWjrZOkdQ?=
 =?us-ascii?Q?zXtKhRfQpjrHgFlgyvFFXG7Tnbj0bhY8B0QpiceGMF5pb5HVSYNGAWw3Z6iF?=
 =?us-ascii?Q?+NlDhUONg6GFPsa69ORSrkDmKma8zdm7+yPh5OdqPveKfC3ULrQQZ04rQoDw?=
 =?us-ascii?Q?Pg6PHHFKqVhSmtA5dT4BUap4TESWjiRgRUQYLUy8cZHI4mYLq8S7c/Ah+HPr?=
 =?us-ascii?Q?d8Z0KVkJ1uZrH8zegnz/Zimh3ShuNvhR9FW7xwvBMcQqML1lxAkz4qFxes3n?=
 =?us-ascii?Q?H2uE6a+pPo1ZepkHWsa6309G9838JadLvpKXwHz/mN1NrAtNFiNL0Gvsxkr4?=
 =?us-ascii?Q?c4qXT+M08ozrWUZM77M9dikiScjbvejDFLd7pshCAcQDMMMLs/OXuXTeKiKt?=
 =?us-ascii?Q?2fRpKfp6q7sZT9UCqcgJn4j+SVOws/+Px7Zr7aLbcDp7Gejz3N0iPXuex5GF?=
 =?us-ascii?Q?Bt9sgIjVqKxJXNLO9OFvLxkOA9PEDSQyHIP82A+TTE6IgkEj0C+tMS2wjukA?=
 =?us-ascii?Q?Oc75o2s2fw2ouJu7HXwLrn/Ji4wvpZ2vTea85/4M8ZB2lpk5wgllPg3yzZ8V?=
 =?us-ascii?Q?eVNxWuh5i40aBoZJzf85hRmkXgbgccG2BEyKBpF6ACl8fBwu+lytLc6OIxB7?=
 =?us-ascii?Q?DH/5qa75E1/rX7R32O4F46Y1k4dKwHwXNhMw9qTmkxty8GeEpvauT9jtlK2B?=
 =?us-ascii?Q?6+XgPXoVLMjaSMVnUMR7ESA8efct07yqrb7IZ+mtHpMYqTRZkuUXsrV2Pfba?=
 =?us-ascii?Q?vSiVmMlyrVUrfvlsJfQf67f4OnCdNjjdOlXvNoKbzPn9vAloLS9Os3TiUXSJ?=
 =?us-ascii?Q?9Ak9/GZxxsPg8wRM/k/CyfriwemCguJZ1asWYzBPkR0prHqwMOCczcqmtUR1?=
 =?us-ascii?Q?nr/vhl1Bya855DbjDedGnOUuwVzYJ7lKcEqG5KxKmcbaIXxE0LYNdFeCG4+Z?=
 =?us-ascii?Q?WQOvjDA8z5yjg0XJrmfxUB6oDdPaiKa1VpQf5QINGzdC86moFea+0ifrbsMi?=
 =?us-ascii?Q?cIgoFFQru5ltkeGobUTElWU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89869d11-ed93-4b54-d3e7-08dd5ac23231
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:13:46.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlQa4AOomBB1sXlb4NzRSy0gFWFIHP3deiCVvZgqxRlavMinu2QyETidTvKnqrIBPGcHzpjHZQ/6kV+tuHKVM8iHJvRgKkO7Z0wvOrcSmd6nLmybAkocDu9ohacLizPZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

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

