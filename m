Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9E156886
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054449; cv=fail; b=cq56Z1N3P3EtbViKGpmHnqyMNGdRVlpGkL7eOUx0geAEFqHCm6z1Fw/090lCbYsN8a3L9GF7lqIMMLMWQEBZ36/f0e4rQQel40xzvO3yV9GLV6yjKy7un09c1ORrtx8B1UzbDQdsQNh2YcaxSGgHN5/QupDS6Bn2/j1nNH297j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054449; c=relaxed/simple;
	bh=EesT7WLpW/dS8hG3K0Mmmldp/hPnrUGnFusQZDh7eRs=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=AqZjpQJOHD7LJzLBxJpX1JLMSjxcX8am5LkF/tmbeAqjBdv5ulIIIXZ1OWPfkhhiBQ8wa16m7AS8I/D9BwwALiAAoPQd/x/pYFztkP8ZZIghF6GmRQOxUj1sD0bSY2aIh211Ij8LdnB+SmLC3IWLw2kUQHQEZWoIaRVx/rnz/QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=km68M1LC; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="km68M1LC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsdDPZZPzlHtkJKLPuEIwTOdj8aXF77Zdf8iTYj/DGIf67FYOod9wTg0YK+W1dqeuj461E5sizGdylzUOWv8oCxcRFsEjXxaOrnxHwheIgKSDv2utjzOdsMV+hK3+lE/3C+BCub8AA9ltc1Gu4DO8Z9OnSD3ChL8b1RWawr0QYDSStCHOZiX5GoTtk1KG1esDfckyBndTKqpKKz4r+snhP7xFffOO2sUfAXZ//R1IjDdoBTpNIojO65K0X4AmIs0imTPgddX4mcoSIvjG1MWV5RhErvmf3sWky/W4jKvgMgUqx/R7ExelsFNOWq2aIXmISuhpjGmnDshWwHVkJJMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvlDMHIhByruSXy9GJa6HUDz/XVwIH9tPXQyJuEVjx0=;
 b=faj8AHYEQUYe9hI4Q9USBk1vTYZPEH3cw4GlKR0Kjg8ImiuwAZTGyc2a601bFJ/cKkuuY0q1WxqDwA8nJs0luScy3l00gL0dB9skp1fe1wp2fGZcHO2/wpagqR2RCH2oTx+ZSyZ5fDQDpgAgLSAAxrpJKsjWOdIUgwHdx8tDsxm/IgqMVmeBXtlJdvF05Bg4heE7eNiIkY8Wk1CggPz9P/mQ2gg7gclXGbJMEIZ+Sx+SliRw0h3B6kiRJESby3MZkRweMtAu/fne3VkpfezEHMkNte/AVoQL8kdAis80Ku/y84gqR6/NqlUnEhYvuigemiKzTTZJYT+DuUI2Qnx+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvlDMHIhByruSXy9GJa6HUDz/XVwIH9tPXQyJuEVjx0=;
 b=km68M1LCnsHS+Mt4HvWw4thZQ32nD2je3f3RcHEaryhgR3oh2NuqwI55GvLKXQ6zJ1hPdmNfUnavrHItiwb0orv3K60smDHAQHScbfnBwNgImdwyq0I2SiXIXw5OjISwaNJrgZ/zwZcPAc45Une5eSfaAzpFxOlOVcRxQh4zdTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:14:04 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:14:04 +0000
Message-ID: <87h649pmoj.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 10/10] lib/string_choices: Add str_attach_detach() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:14:04 +0000
X-ClientProxiedBy: TYWP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::19) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 02193025-484c-457f-be1b-08dd5ac23cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X4NaMKLE6qzcaGj6ebMny7vEp5b6s50k7DIWFDyOjw64gs2GlR08QrRfHvyI?=
 =?us-ascii?Q?QizPijSm9dOLfYoabBfTQBAEE44lfL/cTt8URoxLbTXEh9o8UYaVVZBMu8A9?=
 =?us-ascii?Q?HCexrTwdkjG2aPwuZlxX4Z5TTsrbeRKEk82NLEgSxEU0QiT9+xdZroiHMuZh?=
 =?us-ascii?Q?jYRoC+AyoHg/SVjyOsc+5PCgnsgIHSMP9Z+sYZ5MzuckcVujoJYkGHwmQcSV?=
 =?us-ascii?Q?J+3PVJKYIfyy5CqHYAVlmZE62itT29BwRnc9spGQya9ooz1PEc+dZvG9ridj?=
 =?us-ascii?Q?oDmxafxZGyPcmtO+wKAr5icSAzYDSEtVuYrkcpQxLgXWSMV3LwDMwBFgGOyC?=
 =?us-ascii?Q?VKLwm1HQ5ELhVzwsXj/Fzs0BEmlJZP0k6QQl5QMnClIboGe0860kQy0HOofC?=
 =?us-ascii?Q?pPfiRffYhqT9IMM4Ezke9YtOk8A2tjdClxM1KesjGWvs3uyZdXdR9FzvvTDB?=
 =?us-ascii?Q?KUZwkUrTlzKhTzaohlse4AioD4ZEGiVkAVLkd8PdzY5qCm/E4XubgblQNDJC?=
 =?us-ascii?Q?/HPg8/QdTpywQTa1cXBDuG41/ID2AXJD7gDhvhHiJfrIDlru4E3OW8cqQ+z+?=
 =?us-ascii?Q?nNjNaiMSvhD56JtFnJCYhy9vVMxalcK5lWDxEm8HsmPaHWvwGm3m+dycOSag?=
 =?us-ascii?Q?Nezsqap/mwwH+bMG2uobSdOKp226KefEiqsZJo1VvWX0p1nhz96VYoW77UM7?=
 =?us-ascii?Q?Is2BFuVvdxZBT1icfhyxrDQYLI11y0xHnX/8D+fTGO+fzvGTcCx7opHRz/iM?=
 =?us-ascii?Q?PvCjScihEIux7UKOPZKBXjvXI9ZwQ51zJPX9R+0mLCKmAngaIwdnkKexKWJj?=
 =?us-ascii?Q?roao8+yAufdPe6SsT9lOnqJNbXbzuKBxrk4fpC0iF1y8p6oazmSbXS6KB7os?=
 =?us-ascii?Q?tYAt+PBI8XDkpvjha1IQf6J00wPeT9bU9gHMHZErqqBWkpsEmHB9K7/HLTl9?=
 =?us-ascii?Q?5ZRpnjsTJUhof7udciVNS0eTxEMQVFhAXKkCFbj6U5gv7qpYRUbEsMcRUDEl?=
 =?us-ascii?Q?puEpMQlG7zNg/fky2QLGfNoWEvE4xzRy3/DJijD9XV+nd5l0KwJ4wdKeDjiT?=
 =?us-ascii?Q?Oqj1V27g9pV6wbZ0m0dzBQ6hW+NR7FIL+70xNqDubXV/v1j44W6sdBqADC+m?=
 =?us-ascii?Q?gWpEnhYBYTvA15zAaVHeFaq4StB9mqaysPCRrc/EWH4wjvdH8SXMxSpLuCZf?=
 =?us-ascii?Q?44cZ+FZXqUApKz+cFdodFq6K/m2Q1Ibhy2U1mN/xFF/DzhsCjS1c5mIAfgFw?=
 =?us-ascii?Q?q4uxzaBK3iz+rmYgLPK8ctbDPVxP1Gbj0pP/+312TWHEi9y33JjQ/D0yIoAB?=
 =?us-ascii?Q?BHHJvyD94Ze8drRBnZIYMbn4y2a9uIacUt3Es+bzOTNyU/WLDe+f1u5jXlB0?=
 =?us-ascii?Q?uCqDW+J2RnLBpqkfb19e0I2n4yDTuLSIW/bNdlQ1AyCYVfmIW/AeI3y2rgoJ?=
 =?us-ascii?Q?tFVF5Tk2oEswb5h60G64Il6+oOwsLRlR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgUXG6scz1iKUqtPNgcOnas6EHEuJED4XbgSaRD7ryF1NbC/yuvdUb2A7L/P?=
 =?us-ascii?Q?uPMqkQh0YuzGo9lI7tNivNvFU97tff4e8tWfEdoxBWf9Lpi+NFXzNo6u0HJe?=
 =?us-ascii?Q?DlR5sRqEBbCHvnuKFDXHWuxog2Pro4Rrgx3A0CxU/U7LIMn0MzMSIbbOP90M?=
 =?us-ascii?Q?5x+GIf0U/LL/6+2Vdw/5+J7RKEQ8TPRJxnCBPpdG42eg5BBoPX7USsYkK7eC?=
 =?us-ascii?Q?xGkf04+ENa5urZUbfu7ZLGhEDHXZKOPHM2F/lAA8U7Ja/y+t2X1IWnBuYWmN?=
 =?us-ascii?Q?+olM3Se6FCzoWNm8fgxCbW/6XTmIHyrFR7ccbFQzU61dG5jJn/JKmX41iHWi?=
 =?us-ascii?Q?9A9wbnn88BxYoXifViWwlhOyPDqwq8g91Kq8sGeySm01zR+J+JlZ4VOWfIZA?=
 =?us-ascii?Q?SRnwGypqdTw+MUvNvREhcw0d0+YSIeuvkA26KLNV28IZzS9VjVxMI0LGJ/L3?=
 =?us-ascii?Q?0a5mY5F4H+6fEz9KENTKZfClcX8PxwbCwcTf0oMfYbDdEYHWennnOhxzNKjX?=
 =?us-ascii?Q?rsA3nFvgheE5nxdYF8HtYX4t7LJoLOOkobZo5SdZsHsC6j7OYjtaa02ODKMM?=
 =?us-ascii?Q?xHHDyEvDwahVn1hda/6edxQpZ5RbMMDAIQ+uyCfgOAkEymwyY1uW/pew1wp1?=
 =?us-ascii?Q?NIDqYP7h+ylTl6juUV+G3FzMv59mIDCtT72he1j3ugsrpb5bdS14if53FOcu?=
 =?us-ascii?Q?SXwFTMfOfSYOfJ8r1lUKHnNsNTRYOGyKXnPSE57RbYOaYbq03eQ/Fy76DHyM?=
 =?us-ascii?Q?IimJ9KhStdKiCtr23ZTUNVJGO0EqOVa7romP/tTQIFzA5UDjshOPUTojmWNf?=
 =?us-ascii?Q?qxb9fq/3Y7RCAh2BHkPwQlOF+a1EHeogLF9z/uskDPzL5+svTtg3YmSFYxx2?=
 =?us-ascii?Q?sUmzep6Zri+Z/b6omD/uSpA6qL2YA78R+GLVEmBC3umm5Epbzm7jCfTHwnh3?=
 =?us-ascii?Q?jWgEkh/G0ACpNkaVKcELjDtSW1xlExZVc9y82+PV+QnfKhQJo9HP/JHvQjgd?=
 =?us-ascii?Q?65lVvdIdUAcR9eCaYrCezZNfvb3joglvvwFGutVcN9txRNKCce9WjSpFK275?=
 =?us-ascii?Q?fpykCoSsbHF9gUIEoOogYzC8eDOVCBXSRXCiXGOj7vx4E/u5iTU4sVRSFT+S?=
 =?us-ascii?Q?u38lsszNKXQN1jQuFxn5sgaJCt+7X5qI5rbdJ+K1Qw2vE8WibrC9Jhw8PdV+?=
 =?us-ascii?Q?BzBFWJ09yaZLllzfpSsuDQndX6hS0a9sIpAhllLd2oE0pnyw8mm0RU6m8ylE?=
 =?us-ascii?Q?PjkYNBN1DI4Ebn64XcVsEr7bKAa1iBTsJSNZSmaH4VFtciOa10Mqd70Y1TGc?=
 =?us-ascii?Q?MRS3BEGY8YRazCfYeeKe+nfTTw02N+91RjjIzPg4sVgysXlI1FU21exBooPK?=
 =?us-ascii?Q?taJs/jmLIZvdptx4J9cVEGCAtjcSEe0PMMrAEMRxGir8K/ZKUcnqtTmxj8zH?=
 =?us-ascii?Q?DKc7QNdDaEpqTqrsXCQcfRxGc5fnE0e/sUd3nRvoDjidnPV33VwoWFUZAB8w?=
 =?us-ascii?Q?wM2z5PEQM9mCoEAWT9Ewjff/99RRl7CD8N0cc7Q13Ku5LV1YtME2GnKe7WNa?=
 =?us-ascii?Q?mBM/JGY5pvPGeqlxd0poEbHpaAXhcGPWOzReD+dwTlss0HE6enNdp2aJptbW?=
 =?us-ascii?Q?LMAsuJYFndNSBxphS+nzj8Y=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02193025-484c-457f-be1b-08dd5ac23cc6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:14:04.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uirr7sTdl3Em5JlNggwSNp7IaKx5DKtMq5UkyBp46pIebbpu14u+nUHBRH52AJKBpbZVU2o/pQk1qos5EGRvlVswbXUrF9BoWiLLS12wRwZfnMYJmYPgKOy0O3YgdeBt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

Add str_attach_detach() helper to return "attach" or "detach" string
literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 82c5927d50a9..12b26cb5ca6f 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -125,6 +125,13 @@ static inline const char *str_kernel_user(bool v)
 }
 #define str_user_kernel(v)	str_kernel_user(!(v))
 
+static inline const char *str_attach_detach(bool v)
+{
+	return v ? "attach" : "detach";
+}
+#define str_attach_detach(v)	str_attach_detach(!(v))
+
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

