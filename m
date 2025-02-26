Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E720C000
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548188; cv=fail; b=iXX5Jy0UQ6sZVHS6oQKdDdJNs9l16kH0V+f0SUsE8eo9bI7Ji8strPXE6ST5SHysZlm2cMq46zn41USuP/m+zVPEd69S51I/ekXGhTW5emBK5NI2L9ucDpg6rF9SFM/ray/AXsCeeprtmPWhdMasEMVYiuMWjRthpUxUF+WqAbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548188; c=relaxed/simple;
	bh=iR+xzjsQ7SeWJ1GUAB7uFdcttJ+K9cS1XVx4Nqlqq7w=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fZkPMdoVoYFtQtcaIXFmAAwXx7mtu96Qdz5F/IzpUuJTJ9/Pu06Nxe9eEay2gO0bKWvsRqQDinL7wv4gk/qrlnxTYKd0KoMUsaHorSFO6b2ydmvg8HxgzYmNZWss2aWahTHhJiECnOTpNKQa2+mOLm8bKSaNbx50ffddb0SyDl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=V8wXMu7f; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="V8wXMu7f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csUsFHuiQ5Y1RxteTFtpMNlD24DBFpsDaWV39HZRLyvH6k/Rpv2RT7qwQub6I7LjGLaPMdPPIArBevTis0jg1h0/+6ZKK9TLd+jrhmjb6vpmFH1jYAm8dzaEiVf4Nw32jyZRBcHjBbQk7+v1597VwIIsIYE14WKQkj1TTprQRf/VIn/wybfCLkK8R7u5eZDqgbEaTBW0D8TbY3+5O9uOfbQoDDeDoUMs7MlZ1ZV52TUbr/RmiUS2xDjqBfvoWJPddT8F18ZJAAwYkBWRbdCFGBN+8lWVBkrz5N4Cxa0/Iw4q8zYKqkOcPuB/+/RcmPPslIPCuw1gnNYVxJya2aNQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKaOxRiSgjdgJ+313jvQSegrAXM9wtCkkVVDM7hk3dU=;
 b=T84XtXAlTIxElnUuDG2EXRwtOX+6XxjzjEDsR/QY8+DucEpUumbW7xUNK/f3WPpXXNaVUiEz73nIu+ESnP1nnELUXpnxzL5X5a41v6Dtu1vE8iZCAr7VvQRsJxFQdcxyk3w/RUw5ViQg3mqlWzCPZs1YhrHZUsxIsBm1E0aXjTYbXixL6zWqQkcVmDh0/YBx9BDaqaBLqCfmdkipU0S+5Ny4e8VDox+H5XfxmWe9a0M3uYQgCjvzEOGEEmbpMqVVl760JKB8ZnFTFpss+mUo1A5ztDpTajJp6fyIfFje2YvXLu1gkPFhNQkX1L7jSWYvRv3tP2PzOjnTBZynbwAJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKaOxRiSgjdgJ+313jvQSegrAXM9wtCkkVVDM7hk3dU=;
 b=V8wXMu7fqs736heaN2oD1Xvwl4VTHWUnj0FAvI43Pn3KvxIIBnVZCptUjXfGMHfEq+h1luRu7zGQXmblzGH55MhBk+S4rmiZ62C3woBT5F+Xu5dnDPVuZDyzQuAyXiTg3d3PMKP27a2QMnHYzZ8ycewul9o81sjSuqWHwgxAa9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12800.jpnprd01.prod.outlook.com
 (2603:1096:604:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 05:36:22 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:36:22 +0000
Message-ID: <87r03l6zeh.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 05/10] lib/string_choices: Add str_Y_N() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:36:06 +0000
X-ClientProxiedBy: TYCP286CA0184.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::7) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12800:EE_
X-MS-Office365-Filtering-Correlation-Id: 7696e967-ba2d-4daa-6e2c-08dd562777c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXBc3KVtMFf2tTdujiC7lgjpapOOGLyV0NipOByFuIQC5q85JHSe6r6GT8Uw?=
 =?us-ascii?Q?PVbv5g+aZ2KG2/3cLhv2LZlQcYHdeFOW1gq/lE0ovfUySUv6WWw+S7CBakBZ?=
 =?us-ascii?Q?UeY0Ty3o1nSaMDnSaWYua6kg3jSfq6ytzHBKpWr+tACDEkg1cRe5vfSkkccZ?=
 =?us-ascii?Q?ODlF5bT+ntR62pZFtBsyqsy1SnSbDuI5RtTIGiQNcz+ZfljNTabfc8bg4tEd?=
 =?us-ascii?Q?tErlIDjgDVr4ou6uMHCKf+z3Fv68al0BjV6HoSJwb1n+68R03UQzTMFEFJzW?=
 =?us-ascii?Q?S/N3VAl5nRp6WucNeDumEKYWK9HijFaB2/D7PLA5F+fJTU0CdudiwNC8ZAre?=
 =?us-ascii?Q?ML6feA7v2+Ou1/F1J2wNgyCN+W3PcdNVs2hFI7FVSo0AbTQEKzWFdxYNGE2p?=
 =?us-ascii?Q?pQ5yOVQEc4GqubqBzR8KasM06lrRm+Ucwif7nw4MZpLyxrQFouE22G1W8pNk?=
 =?us-ascii?Q?3lDDv6NhuGleU0rulivjtlKQHidFCAejYbS1uLG8pHG2pUaXJq8seYC0mWBy?=
 =?us-ascii?Q?vm9fZBuV14cZYJ6lkeE2HbBEvQEJORYwoTT55RvyrkuZ8eh9+Z0e8QgPLs5w?=
 =?us-ascii?Q?+fWSASvjmsHhNVlDb13GBsD7oaBZ/QOoxPRQubjCk9x6C2HCkst4peaOCi1X?=
 =?us-ascii?Q?35ludndlzhPyJj7bJPF4Zmp2fy3FeJfju205GvNemD0EVTodufU15j/Q6x4c?=
 =?us-ascii?Q?Cs5Jq3mmx9fMX8kpzgID8kpOhsz3BQg34JW1Enn2SY/1NGa/t3MWlfyAPI1G?=
 =?us-ascii?Q?nOaInXhs7yjpmq/MQwXDF1wC44jPneZ1beZXTOKulqVfx+jba6qfFwXnuH7H?=
 =?us-ascii?Q?1DF10xYjI5m9h80TOf+KVeT/S1F6oO8lPyIGBF6EfW2Y3+Q4ftAjsqeKvwCu?=
 =?us-ascii?Q?gnsAWkEn1wDw3XKF/TZoaoUofeA6/riTfxyvYaCGq27WOUpT5eyCbbwjLgPE?=
 =?us-ascii?Q?Z4+AqWiO7JoAHX3M/e19VL8n/zDydPlPzrPveFytHmfFXk+ORU4T4OvWCgcU?=
 =?us-ascii?Q?JEKowfRSJn39hWa/0hEQlwzQPLmQ5K6BxtiA+uVj/iGtmHQRxBJwSSMj4TG9?=
 =?us-ascii?Q?q1Kq9SWOZICjoC5aOW8syzwYD68rFVkKaaEpAFVXQWYAGbvdUoa1E6V4Jy1N?=
 =?us-ascii?Q?JKHMXHZINroXezUwBXzxiO9s1ShOITnmmMtx+rN9m7ZrZt+XzkyBkN0Hpfg4?=
 =?us-ascii?Q?rKwNRNKKVofRTbMLCVQFX5136wxrJkLnhAT2SETW93VbNf97F6H2nsbijVGZ?=
 =?us-ascii?Q?wtIYRGww8NKFGkRsp7icdYthyiiILFB3JrBZDBguV3FUYnqIpSh4VUc8qIRA?=
 =?us-ascii?Q?yxDRSCZo8o/fB77ubc1UMkmQTyHV2mpouR0DSVFhlth2c8+atkBOJNbrGp3u?=
 =?us-ascii?Q?27rnXW/8y+oZwD+wIfq3CHiNhItBhF9iw4er97pn2YRKgyhkpi7Hw+fdfpjc?=
 =?us-ascii?Q?ASsuBA8zf0E13nBhnTGfz8uH2siQTGMM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?crRpqBpqhXdzKV1Mkv8y1gQFDZV/NSCe3oYmbqoT12x5zvPl4fzUeRPbYYBw?=
 =?us-ascii?Q?3fTYr3OZUrfJJvR+O8BECxjzqDsvsWjPvTu4KYnl/yIcFJuVij62nkBVeCUc?=
 =?us-ascii?Q?h4TCE/Wova59ba/QfwL9tHUrGg6Ilw8kBZmgUPCiNzC4vQDi3zd8OWVsuN5r?=
 =?us-ascii?Q?jkppsD8uWH8VCDl5iAY+1WzkTU1r1eKfIeriLzDWTvp9uL3FYVhchAmTZ6Q9?=
 =?us-ascii?Q?iU/0OrsoXWw93TJa9I7AOpNj0HaTYuJpqg98fYr5ADM2s9+nLxrKIWylgH2p?=
 =?us-ascii?Q?+xGjbrVNdVKL5IV5/4APcsgagVsiqeYQp0NoNcv/9Tca4+0v+vkRHYRqKfMo?=
 =?us-ascii?Q?0lHWyvAPwpU59ql6l32F8XAJzecHPeI49jL8aeeTEqR1DECwE4Xwr2BmvC5S?=
 =?us-ascii?Q?K6XdA/O4lJuHqT9axmKj4722fpDvFlXduT2JCug54k6S791RB6sJ9rdO6ziT?=
 =?us-ascii?Q?Hxf1pk3tkl8U03wqI6pVf8Cy6UusJRGymQeWE4JjE2s8SKxgaitWO+/pG/5x?=
 =?us-ascii?Q?oKvz3sYDvT1p3SOOplTuYEGm0DijPBGprnUhH+161+CpWDBZDGKT6HgTTc5R?=
 =?us-ascii?Q?NasBCfB01DaRmy2y5Si7b20VjUSnyCKAHWsbp1OEe+j0/W0rxdJ2V8OOosGc?=
 =?us-ascii?Q?I5nB3ANalxwspOz/XBhZJ6nsp9+RuND49an1et+jS+9OjhVfRlrxK+jfs2ei?=
 =?us-ascii?Q?iSWPQgniMoKnK2wZ9y//KGNF9/r0+rbIIwG2vGDka5LDHr8uvzs+yt8mQcCU?=
 =?us-ascii?Q?wwnB4gsaw2qnr5ncZ0ujdDthbwcviVu2HFoN9Py/lfkDa017SydHM0/6Y9Kf?=
 =?us-ascii?Q?ZiUwbZqFlPb0gG5YB+Tb4jsjhgF+XcKV1n9QxNuIDDVFz9gF3I68axrhig0r?=
 =?us-ascii?Q?o/ZfJ0aFz7CA+rZeudvVSfOAHaniQXQHgGMLKcprddFAFG+RHEzZrZMHHLQs?=
 =?us-ascii?Q?fkKMpFOX/d0iPZ9YzbCinmDx+CZjdBQX0UKloLb6Hh9qMxZoMAhzoqzDiQek?=
 =?us-ascii?Q?ojw93LC6MhB95uzcxaGeFFuBkDRNWQCCMorjDxcOuPHCBIUAe22zAy8AJGuc?=
 =?us-ascii?Q?c3PzZGZyg07u7BuctRC+eyq4cHX8Rlby4++YSJyHvGLYSYgCcGCg4eILkEVv?=
 =?us-ascii?Q?n8gbGNLzyTqduywCs7n+JXJvG3/Qu1Dhk7+9fUYQV8UY+8KQKjngUOoMZhmo?=
 =?us-ascii?Q?IkZz/WD+46/fSuGkq4z9FeeusWFBlv9FapAsHAZJh7lNY8gcGAWUWJIJ2qiP?=
 =?us-ascii?Q?AYplKg1wRj5ct+ae3OOyaFyQXtozPJAU1qx0Ot2mMg97L8svaVGI9O602UW6?=
 =?us-ascii?Q?5Kk5jgesNHmVxJ0Jv49U3P6EYHqgTnNe0/rO7jUv5yg1SVSekvOlocl5uniQ?=
 =?us-ascii?Q?0N0M8oUo2F1b2xpVBqvGApODkHuSbRSPXpKZQCGCpV42UcyBTY86PqkLsWxt?=
 =?us-ascii?Q?nGAVEJxxsU4du0tG3S7aTX6XP6KhkRlpThYicva0gfxrlPFxfFtuO2IU1TGa?=
 =?us-ascii?Q?jsyu6Emi2A6WP2DCUKC1wm2rrU936Hiw5M89IAXjjkn4x9bc0xqAh1QUIOjE?=
 =?us-ascii?Q?hLgjhpHPjCd/ZVKeA+dYc4RohitTtu7zKpXgCKvEzrnEvFkuNqYxEkuO4+pQ?=
 =?us-ascii?Q?vGvCXUs6JqbXDRFuM0TD4aI=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7696e967-ba2d-4daa-6e2c-08dd562777c1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:36:07.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAwj6W5dgJuj2WvkGhtlgvgA4fDooHsNuTp/xwqYoSS0vvWDPXbJ+U7HJFrtIO9Y0W1ssxhfN5oFhWi2sOcoiyYxuQqUSEJOrVYk74ezkSTcOjd3JDNwjAQXsbjRQ7ro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12800

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

