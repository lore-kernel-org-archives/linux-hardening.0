Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394782EB10;
	Thu, 13 Mar 2025 05:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843332; cv=fail; b=TVe+UR2i35QnwAckAriSuUpxf3jvJUP4gzvY65y07YY6PMorPiIrrJ9a3M1d4+8dl/xK+eeX/RUysmWpLXg3eHlpX8P3r/w0DO4k15tkClM9Gdd5F12zWS91uEH+9pHdbX2wyhA/NyTbuAuku0/KbnuZ8NmN+QHBeh0rqlyjlnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843332; c=relaxed/simple;
	bh=j0u+1yCYBWwe62BF2cQEqzvzVj6wbzRV++VINfM1KRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cx7WkBbTcd2Wq9WGgTHlS7Z3p3Uc0afJvVH85LeYJ/CbQvPF93ymFTfrhwG94hxC135YzQ0UppN6bviJkxkeEQClOjYJereZ0RBjw8hWxuW/lma39BBap6GwdWtVwRykk9jizoR727GuqF3tyR5mB+uInMFQr4n8QaFn3JhPgTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KDxk/t9O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bQdnS9Be; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KDxk/t9O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bQdnS9Be"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3tmaj008218;
	Thu, 13 Mar 2025 05:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NduSdfZO9lNw/BGeBa
	dbARDw9dNSvL2Xz0TjOPu6UWc=; b=KDxk/t9Oxiy5qUpKxPKyxzICwlRpURHCrk
	ZSGNyRJ22YaFkVJ5JRckkjnwb2pAY96NSV68hzoehwfVjty5fJfmxaNLKqHB7hYt
	7fvBMC3f/9uWgbThMxzlbBq+vtDGhKDroL/+v4H93SxO34VxJohZutxCn2uW0cGr
	i3914BHOFeGV9ouaCQ5KzzuBlvlBRoulf7HHBcoOK3ctsDaxY/Am/Gyq7FEhok1N
	qlU+Beb44GM/s/HJWgIaYMoA61ND5REIhX5/b16IsVYub6K3b6juHXwOb5vivsRv
	kwcJyg6GY6/quW2y1SODRlI4ObXuUVI3c0Kaik2asOLueol4rHrA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dufes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 05:21:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D51lA9002204;
	Thu, 13 Mar 2025 05:21:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn87q8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 05:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REYggXEUxurPSFyAJ1y7IusaZc/depuEzzKwIofgwUNmD1SEmiiVsItIX0AZUrGbz6tkNS8vcJ26IBgrZqUY+2aDxo++EyGUUohr51psCl1fFFMiq0Yw5YYrBiiBzsSpcOPMV0tarWD90TKrCqZGTg5dW5b8J4Yto7xXgA7/zTgcwQDzfon+Gpe3OjX6tOQMbG784cUQQCNzYCS3sSebhMblb4S+xeS1gjHEraFj+9r/PqMXsvnYfjchP2TiJGkxrhT2eUYG69iGqQ1h4Oi9d8q/0mDvE2/AAN31d+VVAN59IyWPuLjHnt28h6i2EF+8lfBnDkUdmEMOoqUUluzNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NduSdfZO9lNw/BGeBadbARDw9dNSvL2Xz0TjOPu6UWc=;
 b=Z8Ou0lC0srQjVFOgVVDyhj7RB4R3DZ51IBO4rJaZCHpnD/8roFbfotBKo01LK5iG10Jsf5gn3idcvjn0km7qH/JFHpyfPBdF4Xwb2kBooPE4cTH4+PNTATx5QHuqWLVBc3cnNUHm391JKaNHJUp2Re7BnYW58HZaJ5uDwbdNEY/CueuaKrK8UZdQ8WyYhGloz1leI0hKo8/1Mm+N3TukNuYx+R9qRsk0FR+X7XQDG2Z9lsh1ObbafY8qN+a7anK+Gkk2J/to1XzjwwuN/Cfka1j6wzB/kWOWsQRnwGee/JEF+t0zCHRGM7TwHAkmOh76FhlfKjDkd3r6Lv+sOxaOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NduSdfZO9lNw/BGeBadbARDw9dNSvL2Xz0TjOPu6UWc=;
 b=bQdnS9BetPWOhsEv5D3e81sEohKMCKh5pJG9tfpRDvY085A9lpSJcCFUuSROhT8wLLFyj+fwhznOaoT8nZxXoD5g8jI0ex08Ok/v9YP1LbkMS3um9kre7gLqfin3EYMyRmmE5hDloiv1cZ82EixGynfxJnN5jEr+glmgtGy+Osw=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB5561.namprd10.prod.outlook.com (2603:10b6:510:f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 05:21:47 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 13 Mar 2025
 05:21:47 +0000
Date: Thu, 13 Mar 2025 05:21:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        kees@kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, svens@linux.ibm.com,
        thomas.weissschuh@linutronix.de
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
Message-ID: <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
References: <20250313000623.3192896-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313000623.3192896-1-jeffxu@google.com>
X-ClientProxiedBy: LO2P265CA0328.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::28) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: ad77f4c0-692e-42b9-0663-08dd61eef3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4vPtNBRK+HhVU41hrcmg+fRE4eNcIBjUgaLZQelDFT1vnoOsvqc9I4ND73xU?=
 =?us-ascii?Q?9iwKKL6eqtIdAtHYXE0cwOnZLeAclhpr2d0KoF0zjQT+UsTG1PYNqbvnfoa+?=
 =?us-ascii?Q?olGfqatOf2kgGu6bC4Nds9fJcyWDZjr9bjmLbJ/XV/lABaaBuoeHHUbfq9C5?=
 =?us-ascii?Q?YF+yvnn4KG+mg7VAtuJAuvUVazPGMUKG64x8MOjAD3xxgtsqUhlu3FhfYR0n?=
 =?us-ascii?Q?j2CxTJpPRMxs3MJFdk1YUiYo0ltBVWs0TZ0/VzQbeEc+aC2alCzTskck4lIT?=
 =?us-ascii?Q?01pU6iwFvqv7daO9tkFlpuS++/neWeJv3YJtRQluZ1KDWlukDNsPS14YcQw3?=
 =?us-ascii?Q?GTbwqhaw/N06cAtI9zHDLMRolyfy67BRtPVe4v0VK3qHSZaxaifPXkxu27GI?=
 =?us-ascii?Q?dShiahnzYdUTKMDMX/AqOYMlonUj44eHnXyGSFfR0rfiXulhu1vJJdkHMp0E?=
 =?us-ascii?Q?b5kP1dkNrBGIysp+59WKNie8Plge/8/4C7wgPi7iuxvnpYEkCrteYMW2iPrx?=
 =?us-ascii?Q?RaeF5proixnhqKiNUiXTzArucSTMdl/fBJ2ULD1yiARh2fCbEBu8PiJpbqiF?=
 =?us-ascii?Q?qcrHo86WI53LEebKnirF1q211SHK/g9xedWssMetoXnTA6JKiNsdfakKMdEe?=
 =?us-ascii?Q?dJocyl07fVWjBuX367KbJMzRcjs+M5crVsLWqJhcBI5Y4I8S5CriyF2TvdQU?=
 =?us-ascii?Q?rgaWwali5er+sCitVLVkOTjJ/+7DNhGYycQ3Z4A8vRudHGPFaHF2WCs1wE3p?=
 =?us-ascii?Q?2cW1MHq8iz2RqPdueX26KB0yrzS5u6cLeb4HGMif/cA1DJQWDkgGAqGAcJUL?=
 =?us-ascii?Q?pHReNCGWhLWM6xOIbVrXNCnpmGN1JURPlI1Z6sYK3/sPmo/i5Xt3KfRHK3fS?=
 =?us-ascii?Q?y7LYb/E/kHwlZ8KL4khhlRu1Q7H4xDprH9y+MhZivQWDRecYTPyJ/zCMMHlU?=
 =?us-ascii?Q?oQaTbdbOpuBxfB7rD3we4gk/d8Mz8pXDpWiKF/dX/V9dSa7Qs/bmU95z/gbl?=
 =?us-ascii?Q?lSc8AiN43sdDU2FeJ1eCQpMOGHzvjsb1s8cbdxzs9u9G7jbzSuh/g/Gbrkd/?=
 =?us-ascii?Q?F8QI+cCVbgbn1IcgujpBUuisJtPIfWZGiNXd0vktzdIcI/vUFx6FAHg76mkf?=
 =?us-ascii?Q?AS/7DrViS2WlL9QH861xwskHRvNY9IdBHytmPQJ4K0DhJyBQPbiaK4GKg91C?=
 =?us-ascii?Q?j82PMqs9SpiGijyH6B0tlLmJXss+L3nY+ZQc52Gmem4+YZppnqGZzNVHE/4j?=
 =?us-ascii?Q?DIgqAwtzkxGQcO0YGSPR7rUofmyctTpPp/dYxgdHw0kRRX1K5ZmYGgTtJkX2?=
 =?us-ascii?Q?h+KJH9klnVMoNTOqMrckhf3znnpRqCiTBmHPJm1qN1Jo+yj95tZ347SdnzGz?=
 =?us-ascii?Q?8Xq6SCAq2Mm8wXHGX96ai8c0ll3n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SnZTEQvUBQIp7We8ZzeuSbPId7Ibggh/mDQpjvYWfp3hbCHICrdz/zWs6MJV?=
 =?us-ascii?Q?7aLRTSXbntt3rnPuUiaRxqLj6J7Cn/ko+ANqdBpRfzrXaj43PObFCy45ZTwC?=
 =?us-ascii?Q?ozbivY3Qsay0dp+LLzmfKUTBXRG8DmOP23qWkgustkhgQMZPwkoEMDyIoLl7?=
 =?us-ascii?Q?KmDJ53bswyGgkiVO0AwfcXBO0KWWbovgSI0PRN0zhywxOD57RESXAcHPP4be?=
 =?us-ascii?Q?rwqfpUzx4ImEDdk8YSgxDojKlQVWZDdaiuxDWkbdRWguM3zoP+JZC3OaASgg?=
 =?us-ascii?Q?GLkhoBCxCzssiMPrbPz0CohQCoejnqvVSsmetxeV+Um79ll8quQvb6OhS2pn?=
 =?us-ascii?Q?KRHViOgX4PlAx8wvxhh2LVW+SAZVPcKuVNPX5rK7rXy6pZWSyHrdPaBkZvee?=
 =?us-ascii?Q?cxS97x9N9zV3rKTxEvBajOPcjqYwwqLR5SyzHurvv8nlhTJOD56IF3qXCaPJ?=
 =?us-ascii?Q?PCr9NualPoF/hXZ52hE3fThaP6gGYQ/+0fE6mFUS0n4JSSOG2aU6gB5dXpez?=
 =?us-ascii?Q?AWVdSN9WsTa4eieF6fPcx2QKyN+KDBH7LgMCYW0j1+BSEFuJY/KjgQKpnmk8?=
 =?us-ascii?Q?MejQA6WzGlfndvo4NwrIVzlHzB5wJQSm69lX2tCpNGEPkvkh75r1a08qt9zM?=
 =?us-ascii?Q?5Y/8S+Tqd/jWGFU8gGtclFX3VYwpus3VPj5MmQBsXLMqEkKqG2r07XP/riAm?=
 =?us-ascii?Q?++/9AyuaHNuwiNaNozx1DsujGZqVX0KdTifTHrqZIjMIgWTYIxa1OppJWzLa?=
 =?us-ascii?Q?NA0jOzSNNhLXr2oOv/7As864PgrLlHdYegm6WN2JIisAeOomTTAlOGvq5iDh?=
 =?us-ascii?Q?L68EGssr83yjj2Rp+Uev3JrNI3dKgQgsFhTsq+7b4VrvAj/4Oxet+08VkHcY?=
 =?us-ascii?Q?Qf3am+Ix19xcxLOwMcghNbTQB1CwR5prR5A4KA8qghFiObm3FnpXID46Ztfb?=
 =?us-ascii?Q?MTJZaM5J2cl5TcfjNSrt38FMOnVKjYzaQkRt7HUlAyfO4nO/PQg+ZjXbq/U4?=
 =?us-ascii?Q?86bZjUVrM4HikZos5yvUxWKxT44iz2ra2gfgr72FFSRGlWxjczYie+2w0TEx?=
 =?us-ascii?Q?DrNII2RIhMrcabEyQkYcYHrXFZaDohGfvfWMHhGsNa7O/w/None3zmK1E0YJ?=
 =?us-ascii?Q?u8/SQ4cdYo6+s9lMZ6u0+mbOYtHU23xZU23kM1tnETdqk8VSjxsDlEPvxGw+?=
 =?us-ascii?Q?SV9L+GXZGYM5QCfBchBGHri6gtS2QRINgaAq6Jq1TgMGc7XmepjENaDSB9eg?=
 =?us-ascii?Q?x3PusS5VIPlMTlG5E71oUd+s+Z1He2hthI/dSvRJkgSizPICs53GgZoPO4aI?=
 =?us-ascii?Q?PdCnsTkviU7Len416PleWutXShwfRde7RC03xwXg/NkHgj6TIfzXyDm6UFaT?=
 =?us-ascii?Q?snEIdhYAkVqlltXN7v4FVjkTmDszlZndF3dgppaQDmujbxWUBgsbUMDyJt/P?=
 =?us-ascii?Q?wYm5IItq+sTyBlUkyqVZyldCiL2aDVXMHlVp/shnqPkNcrFxzZg+dVBipwC5?=
 =?us-ascii?Q?TUkqejFwLEEnpblTQ70B3GHweRw3kaZC3fV1ETvld3ZVJ81nsa6efA7pCX0T?=
 =?us-ascii?Q?/io8nLALlp2gyIKkUaSuLC8ocLT3yPshHl1ABmt6FOyi14l9xLr3F3l1SY9Z?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0ki+dpTCTlmyEKtE36sT+yNHE5e3nkiqF9xUKiXlBO5OhGIKrjRanS78BTq7z9mJUAhDFWF81/Y/kmURZQGpOySpvj92GuBxvCySPDSZlluXWHUUtOTsZmyuJasnyMqU7cu+tJLc/M8X4WgiZbOWy428wufox+VVw5s4wsAPN7if77HhwpZvsuNIQzStjvokpf2w8xHAMVaEXQXzOUXdvZn45C+i5sI65yx1FhesAt3iV93fFRcIe9/4WNa6k7WnVNbYc5+J8zSPrwd6SgcgOvlaLyZwlLhnToQbz97nQhcucEvNq+MZ1BeEfVf8En5UDGD1dDh5LTXf4QmJHapWlnTuOLjfF4frD44LXXwFIm6UHwFdPbYrfRknaXek2Ycat1TBs3X0PqXDg1TDMv6PU1MadReisThlRf1dQFka4pKHhAe+kJqbNT9RNjMO3p5eiXzOZzSfh91scayMdCTi+rw+M+wBrnflwRE6nBSRINDxOe23TWupu1A3GFomDUKqoGVk8h5FCAiyevEk8W3NVg3t3RmCP4Lv7iJngnuSLXDgqBKzZez85Vl1bsJhgGifUo8Xk1ZTYkTyUcmXMReRIDUDq/HPN6mIqXctbtdD3dQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad77f4c0-692e-42b9-0663-08dd61eef3b3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 05:21:47.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOHKw2xpEOoNO43Bt/IaHmKCMZqnOFhKDO5pcvo2LUU3q/r3pxNzzAAnczNp5ERBOWhlPxD2cIE361Np8cX2ZCmbI8liz2U8NhFCfhKtaCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130040
X-Proofpoint-ORIG-GUID: XnmE22L7Bdd_2l_NUv5IjekZbQbe9lAN
X-Proofpoint-GUID: XnmE22L7Bdd_2l_NUv5IjekZbQbe9lAN

On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Add Documentation/features/core/mseal_sys_mappings/arch-support.txt
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/features/core/mseal_sys_mappings/arch-support.txt
>
> diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> new file mode 100644
> index 000000000000..8db637254de9
> --- /dev/null
> +++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> @@ -0,0 +1,30 @@
> +#
> +# Feature name:          mseal-system-mappings
> +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +#         description:   arch supports mseal system mappings
> +#
> +    -----------------------
> +    |         arch |status|
> +    -----------------------
> +    |       alpha: | TODO |
> +    |         arc: | TODO |
> +    |         arm: |  N/A |
> +    |       arm64: |  ok  |
> +    |        csky: | TODO |
> +    |     hexagon: | TODO |
> +    |   loongarch: | TODO |
> +    |        m68k: | TODO |
> +    |  microblaze: | TODO |
> +    |        mips: | TODO |
> +    |       nios2: | TODO |
> +    |    openrisc: | TODO |
> +    |      parisc: | TODO |
> +    |     powerpc: | TODO |
> +    |       riscv: | TODO |
> +    |        s390: |  ok  |
> +    |          sh: | TODO |
> +    |       sparc: | TODO |
> +    |          um: | TODO |
> +    |         x86: |  ok  |
> +    |      xtensa: | TODO |
> +    -----------------------
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>

I mean fine, but why not in the existing mseal documentation file where you
already document system mappings?

Plus I feel this need expansion a bit 'N/A' is because of being non-64 bit
right?

Actually this will change soon btw, based on Matthew's idea I plan to drop the
32-bit vma flags limit.

Anyway yeah, let's move that over there please.
