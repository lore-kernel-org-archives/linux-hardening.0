Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2039.outbound.protection.outlook.com [40.92.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB577F30;
	Wed, 22 May 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=40.92.52.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365710; cv=none; b=KnOisfOjd5l0qr8RViyJygZxtLIJ+EJxoUuLdcQtH3rDTtzYuTOR0z8QlfMXluI5BKKPMEdeH7ogwBAt9iDUMEc3Edyhd/opZcpw1tkvxgZ11WK3JRG7lBgS17/pjxFZ0ROc9ydiOpXb7/4EWLH7yf++dqSwpQMCLfNzwoaqXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365710; c=relaxed/simple;
	bh=FhqiH57U//ku4XFNBhbNX+oYLwtaiGQ0ZWgejqkyszM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h9Hh+Zsdtkojk/AwzfqeV48ZwHz73cf030xiTM+H9ZE8b8IpOtX6UCzNMrYcFV1r9axLxBfEbl8UxrwRkzBuCeTdCGstoFM+0VPTpskylWQgenwJE9COAsK01vVzfqjupDitmOEr9w8GChfU0kLUWnpQwsmN7G9l8aeFVI840x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Frq2AQDX; arc=none smtp.client-ip=40.92.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Frq2AQDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sMpNaGmbnrCKpp5T3L9AVn+hR2exQuYUE6gG2ckYPA=;
 b=Frq2AQDXngolk6k3KbE6oKMNTC9hpP+k5qxCTwQII3CarMvXmMQFeFyKRMto3MUrvfsoPhUOWdovL+kXCccp63Q9uAEtOkQyTVbFeImjcZiGcnuPz1iU2YgMVpZJMJB7oFDhId/H9CqTAlewMNP0v9FPwzZCo6BnwHovRAvAZTkEMURA9imA4GSqSL52e4jZSPfoCq9wPdpPRcWN7GCQMWnp6wRRIU1ysQ5e7iHuVBVq1XQ5dXL5FMZZWh7uTJAUYby9Cn7g8Aw8j/G41xYt46bR2cRo3OUYKpnPBD5fG07K0CKPOGZ42ZtTsvP94X9OVc8xxiAFC4+eaJoUWfZP/g==
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com (2603:1096:400:47a::10)
 by SEZPR04MB8151.apcprd04.prod.outlook.com (2603:1096:101:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 08:15:04 +0000
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::f373:f76c:4cd6:c400]) by TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::f373:f76c:4cd6:c400%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 08:15:04 +0000
From: Enlin Mu <enlin.mu@outlook.com>
To: orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com,
	tglx@linutronix.de,
	enlin.mu@unisoc.com,
	enlinmu@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] clocksource/drivers/sprd: Enable register for timer counter from 32 bit to 64 bit
Date: Wed, 22 May 2024 09:14:50 +0100
Message-ID:
 <TYSPR04MB708410A11D944F4553DB55A08AEB2@TYSPR04MB7084.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:
 [QNkrvN80GqKKogE+wUyghWpkV2tfmQ1AKCHVxiIYVdvNv8Hfa1Db/efm/fOuOVSX5AUt1EDPVQo=]
X-ClientProxiedBy: TYCP301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::16) To TYSPR04MB7084.apcprd04.prod.outlook.com
 (2603:1096:400:47a::10)
X-Microsoft-Original-Message-ID: <20240522081450.33818-1-enlin.mu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR04MB7084:EE_|SEZPR04MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 635eecb2-6200-44ca-c1c7-08dc7a3748cd
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	HG7ZDkwst7npobfctQ36r2Fce78CGf3G1uYqv1zCE3q+ZRApPypFb2kKVPbpK11Zt0e6ruJo972KriNZKOXiqq+uUfqv1iUwEy3Lmp0bCmvLP2OS4j7JpekZG7Y7DaYy7zLPW4v5GcWmAK+3m9+C/bAfu4NkgwFe226Nqb3Uf79rVcqMkeIaaBonQNVqW4fqmTINKFZC/w6ea8Bcb87zm0d1f5hHUrH9TdZsYJiBvZXh5X27K2yhafhhUfkiq70Goq1SCPGxTnzgqYzO4q3PQuVxVoCDdJKykpwQpnWZ49oCkZV46chh/AQk/OL7yVAE++UR73e1oN/OuneHiurVP3sNDgzPKZP+3B1dWrn5wMe4q+r90GRnKSpRTmD+qooQaFgFICELS2XdekMtnDY7p6y7RJJ21Oc0qtno39/yhAW3TmI74t3YGb9wytm4gfmn6VIco1RPUMGv+TkrTtLwgyuuvG2k1ITInBGhAa6/G2Cg/Y2LOrzKvBsHux6RrYqEQgQm6TOQHqAQKcinpyAWGOHjtdu3OReJ5V+qH6l/oFLUmPif+DWWVLkJV/Uq4LkS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BtpXZvz82f0qAXDJHiZ8Y1KL+yzQRf2fC1RCvZGpFS7R5VNbajtiR+NRl9Ds?=
 =?us-ascii?Q?K3C3oAAIADjzydegB5UD49iUe1ycJSMGHUDMJv1U5/bkFoP4tZ4ZMY6Ql3+Q?=
 =?us-ascii?Q?oGRVTtF5oPkKWUIV4bc7OCalcMUg37a/sEWnLwWcqGfWmOE+LyPi+O2OnCy6?=
 =?us-ascii?Q?cSjYtlKTE7quJGpvHP3nI8/A8FRZVqJcQtRpPIkCEH/8z8BprIULEBfq6FhH?=
 =?us-ascii?Q?ebFo2vv8i1r7g3ELFSgJdqV8VkcgkVDwZm005T1yLmHLdb+eywW9j0uqOvP9?=
 =?us-ascii?Q?z+MYnsYIopWGbcNV8CiJu4mnGRs8EoKp4Zt7opxXE+JxNvgaqpyGlvfB3p88?=
 =?us-ascii?Q?V5EMgYJp7XnOA5tKJSDcYXDAaEWS2S19hvaVVnlKxa7vWzYT0om2uuIUGDuG?=
 =?us-ascii?Q?kNPd873WVmIqI8BXrIpFvsM7UXIn8W7EK9P9D+1cq54iRJV5jKNxQvYIaqIg?=
 =?us-ascii?Q?+TRWKAK0gV00maZ5ltr8HeVZQFVy3gKelw9xKhH8Vk8mU8Vot5tZiAkywbj8?=
 =?us-ascii?Q?z+JJOxtBGLrx/BHGVe6XfgfhZQtDMTaTVDlKjhbP2PXCmZfafAXAYZu4/AxP?=
 =?us-ascii?Q?dYohf0Ct+9ejMkKvheAWxrRaSvuUzFqzcu5I4WjDpgHywpZkzT6axkuefxgf?=
 =?us-ascii?Q?UulgKySLbfvTvkjbYCur4H5h714NL4SKjFKp+9QAh/NGy9ayi9gefG7+pcEB?=
 =?us-ascii?Q?6HWEMsbRWqt1umGwLI+axEidgNI9sg4YmOmRbOV0x8oKHJtTWz4Ad5+Y+VmR?=
 =?us-ascii?Q?CzCC3x8zp4eSWosi4Yk281wLU9Kt8l4+g/30zSz9FGcHSnc9tiBL+XjanRFL?=
 =?us-ascii?Q?fsiECPg+M6yu9E7kKk9/lWqk4QwMh9DBBV+1+v6nqJfrgeGCBRBBmMBqSo/U?=
 =?us-ascii?Q?bSin8fpnpknfoEhEezb3Wl3oAwIvBrX2A//FMWaBKwc5XI5EoRsPok/79LAG?=
 =?us-ascii?Q?48wFUcC9VOjhcS2Omd/1CZ0ezvjhKKEvdncm6bjL4xloc/9EmrsodEH+4kdo?=
 =?us-ascii?Q?fKwebL1Y3jm901yKXXkBvzf5FX/QLWbIkiSxiEc+kamL/lxkcKNcgWtedsDT?=
 =?us-ascii?Q?igUgO+9nKRi1ItWM8Wrpj4Ri2Lzm5c65lHTMAK+ZVEppgwANTJrc7Z0evPmG?=
 =?us-ascii?Q?H6F6jDYIJXIHlUyeHST6j2tihkpCGv6GKpgBKFIXfY0q53iB1ZfKB7ms5k11?=
 =?us-ascii?Q?GHVxXGL3Qee7I5bxwzXe+0D3CFFnX2yR8N87Dp6tOjSd0miunxpn4WXJzgoa?=
 =?us-ascii?Q?vZ5CSUh8+i1OCdziOBQUuByOKFVWmCQ8/VAF+cdRoYxnO/8CBhAL7wloHXFn?=
 =?us-ascii?Q?nRIGzxk/AIetH3NcGHDK7RhdfXypD1ubo1OPNX4HP+LfwA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635eecb2-6200-44ca-c1c7-08dc7a3748cd
X-MS-Exchange-CrossTenant-AuthSource: TYSPR04MB7084.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 08:15:04.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8151

From: Enlin Mu <enlin.mu@unisoc.com>

Using 32 bit for suspend compensation, the max compensation time is 36
hours(working clock is 32k).In some IOT devices, the suspend time may
be long, even exceeding 36 hours. Therefore, a 64 bit timer counter
is needed for counting.

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 drivers/clocksource/timer-sprd.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index 430cb99d8d79..936691e27f8b 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -30,6 +30,7 @@
 #define TIMER_VALUE_SHDW_HI	0x1c
 
 #define TIMER_VALUE_LO_MASK	GENMASK(31, 0)
+#define TIMER_VALUE_HI_MASK	GENMASK(31, 0)
 
 static void sprd_timer_enable(void __iomem *base, u32 flag)
 {
@@ -57,10 +58,11 @@ static void sprd_timer_disable(void __iomem *base)
 	writel_relaxed(val, base + TIMER_CTL);
 }
 
-static void sprd_timer_update_counter(void __iomem *base, unsigned long cycles)
+static void sprd_timer_update_counter(void __iomem *base, unsigned long cycles_lo,
+					unsigned long cycles_hi)
 {
-	writel_relaxed(cycles & TIMER_VALUE_LO_MASK, base + TIMER_LOAD_LO);
-	writel_relaxed(0, base + TIMER_LOAD_HI);
+	writel_relaxed(cycles_lo & TIMER_VALUE_LO_MASK, base + TIMER_LOAD_LO);
+	writel_relaxed(cycles_hi, base + TIMER_LOAD_HI);
 }
 
 static void sprd_timer_enable_interrupt(void __iomem *base)
@@ -82,7 +84,8 @@ static int sprd_timer_set_next_event(unsigned long cycles,
 	struct timer_of *to = to_timer_of(ce);
 
 	sprd_timer_disable(timer_of_base(to));
-	sprd_timer_update_counter(timer_of_base(to), cycles);
+	sprd_timer_update_counter(timer_of_base(to), cycles,
+				(u64)cycles >> 32);
 	sprd_timer_enable(timer_of_base(to), 0);
 
 	return 0;
@@ -93,7 +96,8 @@ static int sprd_timer_set_periodic(struct clock_event_device *ce)
 	struct timer_of *to = to_timer_of(ce);
 
 	sprd_timer_disable(timer_of_base(to));
-	sprd_timer_update_counter(timer_of_base(to), timer_of_period(to));
+	sprd_timer_update_counter(timer_of_base(to), timer_of_period(to),
+				(u64)timer_of_period(to) >> 32);
 	sprd_timer_enable(timer_of_base(to), TIMER_CTL_PERIOD_MODE);
 
 	return 0;
@@ -162,14 +166,21 @@ static struct timer_of suspend_to = {
 
 static u64 sprd_suspend_timer_read(struct clocksource *cs)
 {
-	return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
-				   TIMER_VALUE_SHDW_LO) & cs->mask;
+	u32 hi, lo;
+
+	lo = readl_relaxed(timer_of_base(&suspend_to) +
+				   TIMER_VALUE_SHDW_LO);
+	hi = readl_relaxed(timer_of_base(&suspend_to) +
+				   TIMER_VALUE_SHDW_HI);
+
+	return ~((u64)hi << 32 | lo);
 }
 
 static int sprd_suspend_timer_enable(struct clocksource *cs)
 {
 	sprd_timer_update_counter(timer_of_base(&suspend_to),
-				  TIMER_VALUE_LO_MASK);
+				  TIMER_VALUE_LO_MASK,
+				  TIMER_VALUE_HI_MASK);
 	sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
 
 	return 0;
@@ -186,7 +197,7 @@ static struct clocksource suspend_clocksource = {
 	.read	= sprd_suspend_timer_read,
 	.enable = sprd_suspend_timer_enable,
 	.disable = sprd_suspend_timer_disable,
-	.mask	= CLOCKSOURCE_MASK(32),
+	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
-- 
2.39.2

