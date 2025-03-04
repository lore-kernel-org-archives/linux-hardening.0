Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBE73176
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054582; cv=fail; b=G0kWJn2Zflzij9jalxiJfF2ilh9x2JidhaQz93YpZ1U/gVSzFdJs/fbj6GvsOeoECTnCos5B42Q8g1ZfZaM2e1vI1/Cttne5/jwF/7nSMIGyuU8a5SgRq0rEFWGFg9n9UBH5zu4jS1mLntll9FB18U0MZBYq7/LTOK2QCZDJrOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054582; c=relaxed/simple;
	bh=26F9NvC06V7BEdEeA2I+OdyVGnSaE6Q2qNwBdfYBK0Y=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UxlXWfAN5WQEDEXmcwmbdpc/CHGyqOor+GiVj/gFahRYXs59NrCXrlL789E5VX4ezvW27rlPbeeBDMQo5Mfspf5GJUdsudl/Dv/V08KouymMjOtptKbTlHed6KyPv/5iOKUJTAKWeDZp18PspbyohEm86074JCAp4wXzu0B8BBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=pEJihdgD; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="pEJihdgD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGQn+U73D50373Vo/LdCcQCn8JLq99pZnG336RbvGvV4nIspNCKFuemrp5dZEYxwP0CB589eRtfI/YgeJ7NAIEo3pW/3P9SHjHtxm7VlhYbnpF1kGewXk8hTiDYVbXEq8oqV8tk4ExzhpB+fME11//kGsJQF2CZxaqHNRaEyW0IxczNhciqosJcvNpo6cEwzhL6LoQL6j+q04gng6Ym10FtRk3UT35XhS/aWxP1jC23wz/d0eKVyQruuNF9te7dMZBDpC1IAavz24ooC8tOtjdUJNAtw8uwVA6QCYNrAu2PKBDCgVhF2mIPqjVZcHUwfGi6mTvq9KMFKLVniTtJ35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH/OP3eH6x2BvyjGHAAm++dbqulaWuhh0aMzsIAlzNc=;
 b=EGmk2aCrcb7uWWOXgrTu0ZKPOw2bX7mqdbxm5uhRwBGohJLgTv4eLjBcK+e6Fol0FgUM4oOa//fI0WMc/IVFKOKprf431GfQhbF+Sah3FE7U4LFV99Ol7Ng3qgBK4AahMXie8potFHcC0eo2uHC0Q4cP3pnhCBXeexHSvXRJmxmSbLlWp1JxKjUypqj2OAfNOQWZBYkusQ1uRTRMUbM1aQQQJJShofaf5K0iCyML71FZMAOTs/CCrfbljK9c8vfenz3meZspqzxtvbE8bO1r1lpksQyJknXMyUoGdgYtHRRBjYMtrjOzhnPs8+WUNc74Tewjo5drfJstpeXe8nKUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH/OP3eH6x2BvyjGHAAm++dbqulaWuhh0aMzsIAlzNc=;
 b=pEJihdgD0JCzGMU86fqPSQ7Af01TeSvR6CJcjCEkZ3jD2ji+aVtqRrySw3Wv2nR9Q4kcNQONP09sVO6oZ+6i+t1l2GdsjaoH7CPPwXySQvZoD0bDAmPxkaSqTLRKYEkUvkrncZDtJ8ithQRR1QK7Ici6fmHB3+XgxpMbBYvPoN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB8061.jpnprd01.prod.outlook.com
 (2603:1096:400:11e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:16:17 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:16:17 +0000
Message-ID: <8734ftpmku.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] microblaze: kernel: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:16:17 +0000
X-ClientProxiedBy: TYCP286CA0327.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e24129-eea2-4d10-a6ee-08dd5ac28bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cPbkmT2ciYFhekVfaYYpqr7KMwdpLvi0Oa+GYGz0HkFaC+8IIZUDpQoBw9RL?=
 =?us-ascii?Q?Z8F6UeUAXy+HsAe/GCNJvXAcyigbBtarQciUwmjxEHOvPID2z0tcPz56o0w9?=
 =?us-ascii?Q?BJjB6GKzPgYq2QBLHOxhJf/IAmJmgPhmMM0Xd32fyZeo7Bs61ekYnU3sz4gM?=
 =?us-ascii?Q?PZtzJgza2Tjx4U9RW1DHsY/u0h7dg8rRsOiaHnKzQ2i0GanShJicyg4jcGqf?=
 =?us-ascii?Q?ganrT5SUqkbe40F2u3iZ7q03yEzgBH2+4EvqOSR709lD2No7GWjgNJ7VjKdK?=
 =?us-ascii?Q?R9SPDf/cCWv61ZOUhMMjB6Wd2mBqM8ItWx7b4uUwMCnfoL+FNs5f8/flGU1m?=
 =?us-ascii?Q?7WFNVDiHyEpB3mbmbWIXISvc8xPBo9EWLRowRZdy6UER68Gy93P9/nbHdgMK?=
 =?us-ascii?Q?nE2ijxOsjRWCDiKXqeWu90YeNdNWa6a96yl01BKhQ53SQ6vDMfQAQQEwq2b9?=
 =?us-ascii?Q?bSOWy40pJNzzH4UNWggQHoiGQC/TfedPEb2d5jc1UVoUL30zZfm5hNsyW+bQ?=
 =?us-ascii?Q?O0IqCbUn1VQ/sLtJPniSoGNxB8tbvKwmm/i1soGIbapgfZP4xTZKaD/AUXCl?=
 =?us-ascii?Q?hfpBEG75xdvFAzAuGM/eO6gq7i2JCgYTpUjRqduJziO21gNy5Vnggs0oBV8U?=
 =?us-ascii?Q?/DiYyPED96houYLRZXEjt5cDAiqU3AQpBSgOGggWEb7/E6+lUMqzf9lh6uDe?=
 =?us-ascii?Q?0ESj0w5Kbprp+n0wyUcNSG+Yv+TuYu1f7EIZnDfZ2kS4yTh6uh1tTrpJMqZb?=
 =?us-ascii?Q?KsWGHbXw5jWs92fbvwFVZmkF37zf8qrF8fdEhmLWM6gadMS/WI88cK7Hd5d7?=
 =?us-ascii?Q?CWVYSyHo+a+GBYNxCE0gWUhtzFKxmEK5J6H2Fmc+HQnbZiU0C750Dwt2S/+k?=
 =?us-ascii?Q?GCkdMTeNqW0cYeht0pWbal6gKXb+Irj0HVuuBMVi5uSipNanWqGYdWzT4oSR?=
 =?us-ascii?Q?Dh68H36uGwbHVns9o8NJ9YGl+C8MPXUVzBSkMxVLeqXwyLXtYudneZU8ulCt?=
 =?us-ascii?Q?O8ti43/Yyjg33IyUrzrkaA/7vxjfVwIOtOCToKUB+IUgNuCe02K16nvAEfbX?=
 =?us-ascii?Q?KAycxOY5vprxn6MEZLx469au1n0jWeijbuFW4UJVX6KajX3sSqEhyNtoeRI3?=
 =?us-ascii?Q?pZM0++NUoJ6bvkhQwu+tKyCMs4AhUfE6JooTMfqyow+BGTP/NRLSgTbXzhuw?=
 =?us-ascii?Q?iuW50WkMRxIFE1xdryCS6Ff2hwjCzWmlrnSxiPlmds3SCHOm9uNRC3Kus+xM?=
 =?us-ascii?Q?urXrQRO8/PtFLI+WfmTllcmi3OnJH8LvlQvTeuIwvEQs4pJhTyP2JGCa/DJK?=
 =?us-ascii?Q?scI9d3/IXMf1jOboBrcr8C1LtmVThjedenkT23gPKTJB4vnhFnw5P2mll1Ki?=
 =?us-ascii?Q?emombAy/VSbEcmnzdUxxFZILaUBRPLVLL3o7BmLoB9nYwa78lsVtAwF/f8om?=
 =?us-ascii?Q?ogznWCMaX2PhY6TqoJa5Wochk2MdtAZq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axTup/edO8Alel/tjK9ocjRtERMSdy3PiApQ5bLRPW8tBmtvskwO7X1auny5?=
 =?us-ascii?Q?n5kS97z7r+TqNVVuxwCt0Em28/NtiTUy7PrMBtKXOs3qmDxM8ZiWtUrJ4Jxr?=
 =?us-ascii?Q?HPuhJDFfUXv4ea4SsdB1fl7bzJkKXEBnDs4XJB+3uEtwqLv9vxolKpnYPnaL?=
 =?us-ascii?Q?xSGtlfWa9PzWoPpKW4PimWZtcwHtQRmP/3X9XPYIfw4/KP4MjDPeVHQOKXmi?=
 =?us-ascii?Q?1cXjy+d93fUaQHUjvdpd4AG7S9ylyvxGKIdQ+zoM69CxGZgJQSOiDYcMDeRH?=
 =?us-ascii?Q?Ra9NsIdljFVnDLapmL6lW3E3nAZpPFzFtw+K/u+jWprI7zFdgvEMfQ+aFXW6?=
 =?us-ascii?Q?Vxt9Gnh48V/Yu4eGnh3byhM74BkZY8y371H5SE1vwLxPz6npK5mKdHedeJad?=
 =?us-ascii?Q?v/147FVRmu0UP+TyHJFvPjX/OmUZhHkMXhwhC9H6D9nyDgrkvn8EDBJKNuKs?=
 =?us-ascii?Q?RZbgWzGZAsjLDyj0Kogepvh7DPOr3yqwyyBjuPBnYvNVo5Vo8MVrs4MBbP9k?=
 =?us-ascii?Q?mD4QTNuRRQbUdIQ/d5/2X2S7j0/wWIIuItEvMRC9x+aClaA4SzANQqW+2+sK?=
 =?us-ascii?Q?+KFnAu8olnO6PV460QZQh1pXsvZEME34abWqu3tju36MUd5LvU3o3mnfD+2K?=
 =?us-ascii?Q?axMVDJWSm//cZ+q1URUXXwNdKTOsBGi1uigPKjsSG/MfFsMaAB8vaHtwm3Dj?=
 =?us-ascii?Q?s75zNwTvyJxMdptU6eGb3hNWRKRJP/23YzfruP5IHLLjwYLgj4TtKcR/j9Ac?=
 =?us-ascii?Q?A27bjzjGrrkyikc6dtEMPmXjC1xFG9n8VHR2ND0gsSf/jbT/iQviKEszeb1D?=
 =?us-ascii?Q?FLNLWTRClhmEDDvC4zC/cqjGCYDkf/Y9GPlZ6GQuS3kTcUXOFVVAM71PVknN?=
 =?us-ascii?Q?pLhU8OL100QxNFS53E9apOBpqz7Grec7xHGbxacaByTOfR2HBODEDHRWb7wx?=
 =?us-ascii?Q?bNRqgEEapTTwtqBz3JvehdXuUfwTlRodeIBSeh4TaBOeWPkpQA1mmnpqifDe?=
 =?us-ascii?Q?xaTLD1d2+Q+pf4SC5e0JZnN6lItdQrUkaUpDfb7z85KUqe798J6rQqlve3hA?=
 =?us-ascii?Q?fenETI+5tYvvQohy706NLlBZVr0DJ4+PX6JNkyNo5cTe53XDp2Ut98RsgMxX?=
 =?us-ascii?Q?cMP9xz5pwHwCwT70P0Y0608As3l1GFpixOBxMryy++Z2/lyJg7eeLeJQh+lP?=
 =?us-ascii?Q?l225S0ULsENLlL0Be2t5DJGnTgNWNmDFHCcTaNm/eMIUZBMK7WSYM/GAvn42?=
 =?us-ascii?Q?tydwOP7E7SamcQiKLbVNaut/5nTSOBEmqRt7+bYxSyiB3qQF1DPqxOlReo16?=
 =?us-ascii?Q?uTnbPHmLpcUvkhxxj9jWpc/7HnFnSWzeSh5KH23EDwvll5mfdeFaVfDMIbZu?=
 =?us-ascii?Q?DMHNH+Inh8P3V6WsGbdNC0RRUu7Z9+6mhfLC3F3aKlYRngIDTlIGTYjmqRy/?=
 =?us-ascii?Q?hQXF9reRNW1SXKNoySpguE+FGyFqc62d9gkAdbI/jGx1MoWg3/qWuJCPIB9i?=
 =?us-ascii?Q?9BY4+vLMPnzIWYLt8SMplt6+JEgsXDgnHzIrNHtzGT4ECLqUDb/F1YSANwHW?=
 =?us-ascii?Q?x+bZAYhddtNTkxNUSKKI5Doe7cueGWPAokMhw74w5PSuYIyTCMhI9hg4XhJ5?=
 =?us-ascii?Q?7QrPSI/KRak4mYQmM8my1e0=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e24129-eea2-4d10-a6ee-08dd5ac28bff
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:16:17.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9a6mdUpgWxLQ8CYXPBn+ZzDtSVb0gDREVS0L0kj2PklYOXZHmZeoqHa8non3hfX4EnK5OSn8w6HRjXBhXlKJi1lHEqvfveJbZ4QE5uNwfw15KNuJ1ujtlT3k+RKd0qOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/microblaze/kernel/exceptions.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/kernel/exceptions.c b/arch/microblaze/kernel/exceptions.c
index fd153d5fab98..d287a324bdee 100644
--- a/arch/microblaze/kernel/exceptions.c
+++ b/arch/microblaze/kernel/exceptions.c
@@ -73,7 +73,7 @@ asmlinkage void full_exception(struct pt_regs *regs, unsigned int type,
 
 #if 0
 	pr_warn("Exception %02x in %s mode, FSR=%08x PC=%08x ESR=%08x\n",
-			type, user_mode(regs) ? "user" : "kernel", fsr,
+			type, str_user_kernel(user_mode(regs)), fsr,
 			(unsigned int) regs->pc, (unsigned int) regs->esr);
 #endif
 
@@ -138,7 +138,7 @@ asmlinkage void full_exception(struct pt_regs *regs, unsigned int type,
 	/* FIXME what to do in unexpected exception */
 		pr_warn("Unexpected exception %02x PC=%08x in %s mode\n",
 			type, (unsigned int) addr,
-			kernel_mode(regs) ? "kernel" : "user");
+			str_kernel_user(kernel_mode(regs)));
 	}
 	return;
 }
-- 
2.43.0

