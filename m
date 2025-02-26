Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010023.outbound.protection.outlook.com [52.101.228.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A421ABA4
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548130; cv=fail; b=rOiMga7ZNnAOWmzD+W/lqqfy5s2ZGZQW9MJnFO2yk8PG7gH9pUzBWzPwgFvyDVnx8K/wQWuW8yOUwmis7uiIFmi5HjemtBM4v+mnRAgnAjClAs84WrJ4VwynYiiaU67rAID6CSV1f3th6UQxzQcJHwHinFk4YlPs/qttQsB1Fnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548130; c=relaxed/simple;
	bh=q/A4q42dfiY2URQ/b0A+ZYbdX1QG2FaeWJdBjjGe+Tg=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=uKBbY+Ns4k7lWuWfmgjMIRqlaHmDXrwecKBTHOXz9czboBOZK+o9496nsu34OQd1fo66gwR2/qJ5/rO9goM5TyxuOnA8GPDh1JQCj48Eiz3d5x6kz2m+XKTrd0LTx+nyX1pxYU8hEKuVE74AE1FNhYTQgaU72+9F0yJYXyNMp5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=D8aQqvgm; arc=fail smtp.client-ip=52.101.228.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="D8aQqvgm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fpl4/84976ZbKgbhvUk8fYZa8mynFa9voupN0YnShVtmqlron/iwbQ+PP0YwNzd7C4Twvd+eG2M3HE0XInNbHb1GQMq4J5Kka7wxYaDGUUX4+3btF8mR7JW7hV5NkwN3pvjn836Q+bfQ30MUcHdCqWo3V5cDs/pWYY0qTRrH/WJR7AU9I8wIG8w8audF2UT9AGVDoVjx8L6oTkE/L8Gzs4uo6VKiaY3acpr4e3PantXNqstsey/jYvgKqvaibVZsgjSOAKukHZdXPiBASj184F6Uso3b+i+JHrgmhTijUX2xED1gepoMv6zhswI4PFI1xZ7KLS41IlTrfT7/mLboNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNivsdy9VsF8FxqubzjVSYSM6/R30W6tx4YwLj1e/Gk=;
 b=HUnNNkGg/nXZuH8IbcYfA2oqW1+ir7jTcw2F7bQyG/BA8tXRKm8usRnTMrGlYf728xftRFX3SoNyJ1kEJuP3PxleiCoTgZsx2CyZT7+knNlsC3cQcySKtnZYC8x7/UT2mcI7K+eaeN0+zFQXZ+AVy8th4hSJ8HoLymk5fnxy/bcKfxPg8a2ul0tgHqsJuYbq5JaI7Aod/ZO98hWYzrymTkXIAvbU3r8Ca1uav80RRvqCkS1zK8DXVjhErss6B7Rn3C8AGNsQTu8i6pDCvy8Gc6w+wQU7hUsA7MQMuAPIwghB8ebmFl0KH0Y1ZVDveX+B0uM49T+Uwc42bVavcOVDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNivsdy9VsF8FxqubzjVSYSM6/R30W6tx4YwLj1e/Gk=;
 b=D8aQqvgmv5Ore4DqIPE7TWArf5cVRWsP6owzjtAxH0J1zN7eGmiHD0h0FAEE+HcZLx1xnng9vkD5+0rlOTdY45Z2WeYzW3ug4lCG0pokQ5bfPySwZsU02vZrz1F/Z/aeqPSw8Zf91ksGR1DTNF+sdwxBbF7SkdaqPNHUakhG6sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY1PR01MB10688.jpnprd01.prod.outlook.com
 (2603:1096:400:327::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 05:35:26 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:35:26 +0000
Message-ID: <87wmdd6zfm.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>, Kees Cook
	<kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 02/10] lib/string_choices: Add str_enabling_disabling() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:35:25 +0000
X-ClientProxiedBy: TYCP286CA0145.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY1PR01MB10688:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ad93c3-4bcc-4831-04ba-08dd56275f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zBtceHa3XzDDJ/oU9rM0ueT7yccTF6ZQij+6DXO9EE8ODAHkwpk1ETyw0USI?=
 =?us-ascii?Q?J4q6SMtEtjhmppe8zTHeSafe3IiSaGDUV8FRq3GvmJQLFIZk4UfFadtD+ILE?=
 =?us-ascii?Q?WWkeXNxJqSPQa1loO38WPQXEAZQCLtL4piqyp15rMwjV6Oa2IN1rQwmoDNgh?=
 =?us-ascii?Q?pfRqzPOTmxs0JKRrCyq14mrBPYBL+YETPnfKO25/7MeP1ZYsDpOHn8i6Y8Xk?=
 =?us-ascii?Q?JU1OMkdwro5gKFvI8/8Kn9TNu4h6j7xploSeqBUoSXqd1l1abL/+bJHPpHN9?=
 =?us-ascii?Q?4QzJqMMZY8T6f9Z52XgV5ehVntTeJIg+zHFET9zViCBBdSFr6udr2rUA7zjF?=
 =?us-ascii?Q?/bbqw5UU4Vn4KC5R3A9I/uJfq5W/zidZXyFgUKKrSQ/TuLNHoIXlTA/2uNfl?=
 =?us-ascii?Q?qvLRWD7L8KmvT8gHSSslWOcSJNa6zLiZMNsvCxDyTJTeF1/VN0XaA0pbDEsN?=
 =?us-ascii?Q?UhUc9H6R8MhEilvQnd12IG5cWs3F1w+1D/3pfhCxp2ukqZK0DKXyry6rRFHN?=
 =?us-ascii?Q?JuAFDLcNj0zWsHlR15x2GC5PFYiNfYXrDa27OhVf+jkIdnO0sQ0Jjcjtohzh?=
 =?us-ascii?Q?ADuwOlfQ1HJg564mR04aIf0L1R4ANDfb0GF0tiLSNa7Fro95Qay3c9aCwD5x?=
 =?us-ascii?Q?2yOU9W3zTgt0g6BbMq/hEnqoXysp8Y2qm/9ty9EQxDgtE8aM5WbBVi0PJeju?=
 =?us-ascii?Q?pCLXpXWoGB7Exq+jcIba2zIuSJPmr09hpMWicxoiSBG/469jdA5HG/hry8xr?=
 =?us-ascii?Q?9xJlPjAyoED8/q1w5QClzPMPBJ+JlKa+Q/mVuFOsIIgKf6jOlOrUC5vROvVC?=
 =?us-ascii?Q?b38LB3b/LJxgjk1M/C4lO0zgkMKGXiDOqI3bbp3DVT/wJ9QbpqPA/1Pm9lzh?=
 =?us-ascii?Q?U7P3BcLAxrhxZ8ro3whQMATc7z7HLMt/ikPMdxGx/HhgTB+zH1YBdcyztnp5?=
 =?us-ascii?Q?DehcScQvjqvOSrEvGXOMYel7Tk3PUs/VqQ1VJ7YEg1ae6VV95jbvl8ruHal/?=
 =?us-ascii?Q?J1NQMf30XY6vKFS9Q2l4IVmbJcZ4XdfoAmYre9pLg1Of+SHdPHBLcqUuiFGp?=
 =?us-ascii?Q?rw6M/l33QnY/5SxDeimfoGl/eKbpUBIBPSmISQURCpvCaD1eIpbtEyb8seXA?=
 =?us-ascii?Q?Mvbqxz0LQ1MuyEJlbKqTYnA0NB1ob6AXXDOC/x7Jhu0zLxSV3fIGKSP2Ly5f?=
 =?us-ascii?Q?dPMaqZVPWPrKnW+VEH/kdipTBFevXUuo1xugUZ6B2aANpuA833/9putvdYgL?=
 =?us-ascii?Q?khE8rEtIC/ziZkYzV/c+lDDYxpcX23tia1XO7kW1VmkNpl3oC6UonU+LARus?=
 =?us-ascii?Q?JedeBtrteOp1AkN9yC3olcmpfU985hhtCOstXNRMZcRcAnayYaoKjjXW0cH7?=
 =?us-ascii?Q?J4WDntCbKTgYnUWn+aX1NkGZJJHHvHfLQyzPVhYbNP+uGzhby6WASw5ldP1M?=
 =?us-ascii?Q?q0mslKEi5ZYSA7i4HQ25zvVeUlmzEt3B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?13zl+ZM2pS+VmXYqlo5OxJwPmnodhZQWVzYe75mc4eJx+7i+mDTMkQuTC8w5?=
 =?us-ascii?Q?v8Pq3Esb/mChgMuOAQg94GqW4pPNr2gnR1PhLba/qCQ1INRhAI3Pf/e23L2j?=
 =?us-ascii?Q?SnlpoBq39clsxK5lGpcUJVmfD7gWy71mc0aMJFc04TVw719pkB2hKUms+uAV?=
 =?us-ascii?Q?CkiI4ep7u3u1R4VNdh/W42jys0rlsOxsTY4JIB28OOHLffIAKnvoOOc1MC5+?=
 =?us-ascii?Q?uaGFO/FAEd5g3tKIp4YjO8EPPFXkMTZZBdQmcOrzIj2AqB/rXMD9STYc0WC4?=
 =?us-ascii?Q?SI+GVyx9+mXGme3QEdB+0itRHd3FKWhaMOyV7v+ewFlgdevWB82ApM4uDw7E?=
 =?us-ascii?Q?5rhXc/Ng31g7qRLt4teqZTAwH8Jh6NJeFZf+L+vzRC2XsijFdOMMxeo9kaEf?=
 =?us-ascii?Q?H6a/4sUjOYpVpskwWUjT827xezLwav+c1WDgrFhh2U22oTiE8IuuGiprd/ly?=
 =?us-ascii?Q?3cqaQwjfOa377NdNJcjGz0A9nakbUdrmmdAVK+c1RIRYrNrJB927cFbmkGt7?=
 =?us-ascii?Q?PGkGEi1D/jKHS7n8T0Ripe+s03IHS0NQXcO3MeFoh7OvrITVkQFMcmcZLXYa?=
 =?us-ascii?Q?skaNtjt4FtQmGF3mbJ2SNBCUHFbtrOKdEfMZgk6kgRl4KVhx22ZPXAFvE4um?=
 =?us-ascii?Q?ZIF+5arOCZhOnTVKfikYA5rdyV2YFCx631GzaE5Met66eB5pr3hNbg2oIWIh?=
 =?us-ascii?Q?G/lIZ0s/NpMP4XbaNZtkC3rkXCyc0o1qRmbaeiYCmNFJmeef6YfFkxUGxESu?=
 =?us-ascii?Q?WgM7iZMRv+1hxoITt/UNjGuTI/JqXoxPBofM8eP7kiwRf3AmDjsZDNwF7d2V?=
 =?us-ascii?Q?+jH55TnROU6t4Rm14E+5K+fhekRZDImIL7vD/7KHAFBv5DziRXsmn62Yyie7?=
 =?us-ascii?Q?m3Pn+Q3k58pQKsG0mtD+yPPz9Hi2wAwoADPyKgejtkKhj5SCK0wfFMgkquox?=
 =?us-ascii?Q?YTcy9G7jPihdRPTMvFBSeX07z0boSkjRSV/uIYR26aoFLZ7wF3/uadh7Bb8a?=
 =?us-ascii?Q?KFjwICGIcqvG7GgI8FkBbmLXOFunR0/WyvdRL22HMtAskxkQUMNifOBLMqXC?=
 =?us-ascii?Q?zZyGqPeBJoonkdBuA31UoRBIEKwnWxBDtV++z0ECjBHra7YLlTSddbFUDOZf?=
 =?us-ascii?Q?H8zTBdHV0ncTrv0RfLY4p4AWHx1i8uZLI2IcpnZR+3yl9zNVDMp03+oxIcYv?=
 =?us-ascii?Q?ehA6SyOiHR7o4xB4xCTf07E1regZQYnjEST7CYOtBqVgDbrf8nJ406vtl+um?=
 =?us-ascii?Q?4V2nGHFO+YyuqhuN6+Hm0wusNk2HZHp6HQ+/Aemp4LTkCfTppRXbd/FdeA57?=
 =?us-ascii?Q?5c9+BGvgcz/Rek3TMGL16o/NGbwWgZ5odvNKnlPudbIAKFSQd6tH/29icWRs?=
 =?us-ascii?Q?sMyRXkGxj9GyCW/iUJwBUaHy/opDQoNwxOkE0VX9R7b3944+Eku7u+3kfsyY?=
 =?us-ascii?Q?zE10lmcjEvi/GVds502BacfNt1sSR3cRDBfdk3rrikm3fjuDb5vaf2dERNjz?=
 =?us-ascii?Q?rngCqT+xg6F167QX1dQh0Gpw7sVsZCE44hTsAqpXjJVMIlrBnHfedyPYlZ3v?=
 =?us-ascii?Q?N3Ib+lz13hWePsf6ATr0tvo6DnoxvcXQd1zDOLBlDcXYreM653lFFR9qn1hh?=
 =?us-ascii?Q?QRMHz4EfeUTqesx8J3ZGx3U=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ad93c3-4bcc-4831-04ba-08dd56275f44
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:35:26.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC9WAdUvNU/TF+sAJXidFteLd9drO1zogWyk/B4qubRz5MPrhnNDZ1i9PIxTWcWLGUPo43S3HGx560Ia/XcZC3AieZrfZYhYJr4U1PRFxXvp45AGEprVUYGXew/ioWJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10688

Add str_enabling_disabling() helper to return "enabling" or "disabling"
string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index fbbf1e657806..2a6c8df585ea 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -29,6 +29,12 @@ static inline const char *str_enabled_disabled(bool v)
 }
 #define str_disabled_enabled(v)		str_enabled_disabled(!(v))
 
+static inline const char *str_enabling_disabling(bool v)
+{
+	return v ? "enabling" : "disabling";
+}
+#define str_disabling_enabling(v)	str_enabling_disabling(!(v))
+
 static inline const char *str_hi_lo(bool v)
 {
 	return v ? "hi" : "lo";
-- 
2.43.0

