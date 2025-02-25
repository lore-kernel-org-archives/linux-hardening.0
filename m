Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F4C254875;
	Tue, 25 Feb 2025 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464491; cv=fail; b=YxIysEWUJUzNee6VTk+v//xsjFG/YzYTgMuE3WrSs9vGeWpQeNcbkMm4xuOBihak97G4Ox0dYIpJeM/hKI6Eb1peIBBSdWe0FkM7piN3uMs3eD53SokvDWsEUp/Gqb5YhfOoHy2SR+rFizY6rbrRR4nB9fAy/I6sYpnBatHb8zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464491; c=relaxed/simple;
	bh=T71FcOl1bAitgTk9uC7Wa30wwmtwigrwxGHCcmn/Y5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LRW1ipDWWwWKgSfXwO3KziGsktBcwcQB2cib6roVkkqW0FY/Z+VPd1rDyxyxq0N9RDpu61M7GaFnBSVR9O4DzvV0teCqEKWvTYB5gYXtkgyMB/BY3PQLfMHIypIt0+jHNpdkBuFKfZEZ4ASRLtDlJGOHtp9toBltAf+jLpNtgyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LGcCE8Bb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nzoSCnGa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LGcCE8Bb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nzoSCnGa"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BcEw019284;
	Tue, 25 Feb 2025 06:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/3Rc6yoDRTspo541zV
	IcmmynOHEmJsyTBpyTiMR0wKU=; b=LGcCE8BbC4a9yhNymbH7QHVVOvdanfA+Jk
	qIGK94w/4XRprYwSVEgZ3K84JqzVSCuRsuQKMz9cYeIa9JGdFohng2mfzMDZ0K69
	H8sw/xkuCto89oDeQTBykwZD6Fnykg2zPvvi0Kq5NNuqn9ZLSi7zYTQulVMgoBtJ
	/jgHt7EGwfxU7yMRepyMRUo5guTj/pcsCrtI0oaumMi2lazsCD+L2iQ/uMpRN9VP
	JWsUbw9ULFK5c8Qr5L0j8Qd/zf3+KNDujAV9jCJZE1ChJYMAL/TTA9qmHPOczMP4
	qiIAkhGjH0NgefcwvRzboS38Ml58Dpsuf3GUAZyqpfDPZF3K+npA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bm92q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:20:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P5nfBL024381;
	Tue, 25 Feb 2025 06:20:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y518r2wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:20:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vff69gW8lxonhhTlyrBo+CiknC5xQGPLiYiHK8csvsfYNIkCtajPWqWflmJDSgF5B1FwNUFJO1MLBEHfO7mFHZdr/fIK5EDxi2fmcpVvlooiAzq9685hZVNKzDIhaUl4lLZI44EM6TygxGP5pGGzsChHL4bwimZoL5D2LWvhDd/v0hD8M6rW3UrCGLi15+V2QVl/tnt+s7f9anj4tbSamoYz7bOvRT2JTw80wFg9dozf9MnTxlV8lNgxveJZ4nSPkSGerruS4v8pX6M8c82o7kkF4D8m3iwQ5dm2RiAUp1UXwJrK7F/UPfLMcZOMmWN5TiifHcu4lc5x+jqX8ASWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3Rc6yoDRTspo541zVIcmmynOHEmJsyTBpyTiMR0wKU=;
 b=HM5W+d0lIpXW60Hhhln9b+IAH6zyPtgxqXnZ5Fz+RxO5tK0dFVaXzp1s8l6S+sKigUMioLwbew+PWTdTGIU3rxZlZHRWZowuDuZzxqr8SeCA2pPcdsMJyiPH2jT9H+ZP8bvZxi4rEWO4hvWEL2pan9QQo+L2w/3qvhjNPwwx8rUH5X+hea/Vi/2xFhH5YF+9/Iv/QU+8qyNJrdft8JA/UvSrwLkjCpy+1KtkBxNTN0qNqwHCJEwzaYNORHJzOFN/AfyVSk5C5jrrYM/vA54vbaiRjud3AIk91DkrsyJSD72bTJBYI2zn7T1qt/8qNAXSAj7fgVJGhjQR/jbrSNSFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3Rc6yoDRTspo541zVIcmmynOHEmJsyTBpyTiMR0wKU=;
 b=nzoSCnGal9m8Tst9Hx0SfDlyrUDsX/+IWuEE0S0BUmEPYzgJmjFTKIEBNLPK2Wnvzb3RnKTXvz3odCuJ++gkHOJyarc9WFXp30QxOWQRtjlJDVo9fdahFyxX2r+iLkTV2FD8SvQjdIEnrIzlWwnBHniiiqoUAPhvOzn8wzTxQoc=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MW6PR10MB7686.namprd10.prod.outlook.com (2603:10b6:303:24a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:20:37 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:20:37 +0000
Date: Tue, 25 Feb 2025 06:20:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v7 4/7] mseal, system mappings: enable arm64
Message-ID: <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-5-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-5-jeffxu@google.com>
X-ClientProxiedBy: LO2P265CA0180.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::24) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MW6PR10MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bc6253-063f-465b-4d2c-08dd556484ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oVxqSlOEMMymKAjg9Gs2EBE+YXuqC6nyWvX4A9tfICzIhKrKYJDUqQJi4PBF?=
 =?us-ascii?Q?Gg5iFORQyXUvyJr8YLRa3adZdKpL9RVxXw7Q962le4kx4yvLHn0pFDhhTpvl?=
 =?us-ascii?Q?2yYRvjx/X9znXzFhHEcTCCrQ0Ju6ZOMx4HqC9BgCz3zhy3iE5vw5GC/sNlYx?=
 =?us-ascii?Q?VbYeP/VLyrGrTHWsZa9fr5ZN30IUinaqIOjnSBUU1YUgNI4m4blQ3MTbQAr5?=
 =?us-ascii?Q?jLolQV9afUwPlF7etnZtI0mKkrDORcQWwGAf4Xjf2pI/Htvi+m1BDGGOi+kV?=
 =?us-ascii?Q?AMmrcL4NU+heLF/w8ZX6ld9z2OAW6d/StHJ3ktw8lN+qiBSUotRFZ/WrwspM?=
 =?us-ascii?Q?XB1Ll/IQaxZCPpFqwO5C8lRvQr7lafwx1vhhCfUM80x9ri4cr+CpZMZoQxxJ?=
 =?us-ascii?Q?5Y9cNjtJo0jKg2aBYRJcOABr48owtvGlF6IEgb1tlnQP9Ap8wBoFC5aYtcML?=
 =?us-ascii?Q?PO5zobZ/Ceg9GzzGvDM/YoP2WcSiS5X7QnLwVH4zJB5TPI5D3Et0F9k4fU41?=
 =?us-ascii?Q?BulUsND+lHwDAurbfJWLnRlXNJjpKMcVAo2OZijkKjSJQYN/eT5WCH9Al7z3?=
 =?us-ascii?Q?NdTrQplVtSHaAzpx8RBsRZEkSxEi5Ahx7NJdlTlYgez7hLfWcd2YBWjhqbHt?=
 =?us-ascii?Q?jWo2BOkqvnd/HK4CqE2v1cGPBv1hp1ySGhnuW3k44R6YqIkUiSVT+lPD7yZP?=
 =?us-ascii?Q?mmjL9vO8sog1CQCmJlU0An1jiPVK5RQmD4QxyJH5cPhOSTeskxReYdJBIz2D?=
 =?us-ascii?Q?jpSOPpxiPwE6ubG7HfY4ooW9xbKJsB/QUwtlYYgXZl/8TF2oZSFHs6cBcx5u?=
 =?us-ascii?Q?i9yc22z/aLcIBn5oefaRRUNqpM7gvdamdcJD0Mfnz/M0wp/JPHY64+KlfLNA?=
 =?us-ascii?Q?FjXGKkKdR3d5rx69oX4kQW0tMEO9QLI/U153xk2AWKJfbQAZZwnoelRj7uJK?=
 =?us-ascii?Q?evXsL8GDlGqx6m1DI7U+pUaTHKUopfJoniSRcysvBbNN0N5VSf4BYl2J5TWC?=
 =?us-ascii?Q?6jNATnNE9EiJBJ8h5A/nq57RdDu2coE9V251tT7uHF89+3kgLGFD8YvRFu8A?=
 =?us-ascii?Q?7UBeC9PfGZALb8U4aoWH9/oby5twaNnrXYU3zfyJ4Hwi4HdqLTVsZ2MpEdGG?=
 =?us-ascii?Q?qneCdiz0OSEVx8qnozQ/+05dFEKuUBL5Sam7daiGhvPU32GwbiC/uyWm9FyC?=
 =?us-ascii?Q?Gec1CGUrYENTTaw6CrZEMkMljWmpSvGsI+9t6XUW6KRGEyGjyA4BRvxNvC6d?=
 =?us-ascii?Q?NRdqGn3dydkbUk10z0eJAxqTtmtOdb1hHYSJ5p52SSdDH0D8keybljPRv32Y?=
 =?us-ascii?Q?a8jBRZ5OIrx0MgwNF4A0ZO39QLZHBzxznbxdYBBs9+2kGWhYFwONecq9ufHE?=
 =?us-ascii?Q?mS77IT3sdb/1djFvY2nOSK6C3ZLD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8MRPdGE6d3jeeLJbOfkc+02+FgMOnCyw9+SUxCkMQm5sGU/G4vXzfmrEgbq4?=
 =?us-ascii?Q?ibVKGPQTMVtfp03N/DoaXSNT4F9JvPp1i9A9CjZbZ3JYIjJLwtkNtf4++F+e?=
 =?us-ascii?Q?42xJ+o5bFQxyRspEU7NzeHFAfX1wfjB/9fuXVLvpe+0Vvk3dYo4UsExYDz/N?=
 =?us-ascii?Q?e3Iqegtgp5ljruJ1K4buTzz4f/4jqrjAAD/zYrVwtt/EvANuK7itjFFWiTWT?=
 =?us-ascii?Q?4eGBI5ZmISE563+E8izo5NG0VkyQjN50QHYpJaAGKFvgpXmsET+6aEJkFBIY?=
 =?us-ascii?Q?oHE9hu9wd2EpQESD8nL3L5AdNGc3nVX9+in5ajxRWAs/1CvjV/F6x6am42i1?=
 =?us-ascii?Q?/xusMn1Ctab1UNy2DU/IC1sbcRTmU+Mu83S/n7j0zorgHCiUCwPTqyYWC4S/?=
 =?us-ascii?Q?p1dLXMeCXyqyntF1cSuAFBL4uGsGYVBqdvyJpkwMOlbMzyM9LVzBd/C00173?=
 =?us-ascii?Q?ISin18Wk8xJxbCPUdc0iiy+3nW6ll1cbxhiVueCUqhm1fM8vhwMiSOAhKkT0?=
 =?us-ascii?Q?rHXzk1xLKL2Bg0iAkCtGHT057oN62VK7/LxJ1AcKZMPUEQFcHFyryNDT2swb?=
 =?us-ascii?Q?CRJiuOXR3sedjnclfd13mcIKUKRNAQ24cqTGLJ+kcewQ8HsSxPuwkeQA3mSf?=
 =?us-ascii?Q?W3veujcbOxcvomEhVKfA9X1pyAl2PpTUY2FINPHMolxIX0HWFuafHwibU0mz?=
 =?us-ascii?Q?LPqcA5qCT4aZAsYLLnu73MdCjR2TI3uYG/C0GdAcVakIKU5E7AM5+YtMBLL2?=
 =?us-ascii?Q?yrWKUlpTJDZAo29DG+oDFnlW3yj3MoSUqgtVNiHC4NScmxq7D9Uqy67xcGoJ?=
 =?us-ascii?Q?FLkbv4YN19TrVI6LAxUkwoZXgKNy96N/l7LuZ9TNfuW8GSGiUS5vKywUGpN6?=
 =?us-ascii?Q?qJ3sIOjzpdWHftGf+jn2UYPK0rKaZDwPfYFdqq65WJd7tnN7oVaTNUoQvQ9A?=
 =?us-ascii?Q?uqT6nqLjWGSNv6e5q+CX24gknEG+xi8eX/iJ8TSBvXZ5zgvAcqunPDfAPPRC?=
 =?us-ascii?Q?MYmj6uFno4nbMEBWnPYnA/s0fU3JrSLmfTItObKEn3l+WU3KEpmvINRl2FSq?=
 =?us-ascii?Q?lKYHiMPuoKAlHY+jUDA/gPkYD/ERU35YJgKxqYQPhwRiHaGWlV7ZJpqqYTRv?=
 =?us-ascii?Q?dgkQhYVus1d+3aecfEa5frXvyAv9O3pJ+q9ivkNbeaVzTQ+GT2tf024Iyl76?=
 =?us-ascii?Q?p7ZDh2WKob+ORXL74u9bFVLYT1eNyDLJfZJ7sY3hikZwcGdcnMqJhoQen+ux?=
 =?us-ascii?Q?pS4t5Qou+kN+92mZbxzZmyl5aPHkIhja4a3hr9t96ZwJYGas4H08xGyckOpP?=
 =?us-ascii?Q?SQYt3UJdNZrrII3BcBbqTiM6c0HQM2lnRbvKYp81WYLBa5attstzeBTwsG2o?=
 =?us-ascii?Q?tDeZ07ySbw+wFvsUW6aoVT0iU/fhouL0Y+u/g8TjPWVbEUXufilL4kMcYz2p?=
 =?us-ascii?Q?xg3QT8WYxmlSgiblvMqdPE7jx1vDmax6H1ubt89cYdByfh9ni3MuRpdkAONG?=
 =?us-ascii?Q?MqzG1fkddm6tb0uMntOfrQWJkdPdJoUZoe2Ag4w4+aLT0BXjpcI9XDT0Eqik?=
 =?us-ascii?Q?cln06H145qgrS9EwsqJRkxZRWuGMXZkuTtSsRZFSCbM0VxWZKHyO8rWbNjON?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wfnY4zz6oe4+0eY6LhmFl4mGTNsy70B7mTb0Sy3GR6tDUS941UdZ/8+PkFTmDuOiSRJYBdKaiA+T22dHz+r3fKdpjySyx3NKWBPOEUJHqu3CQbqPU1FbbZ4EPCM4Cl0V6gxvNEyTizflMkhVcN5muvRDr8r3cYuvOrLvEDl9j0zu1M/qlbHPOlJE49SfpNziLQ6d83QatE2ZX0HQq/X0+MZYmYPJXLCPsVMGwpWqvq5Yha0okeCPWAhiacqpUJVDGY5pGP5Ll3MVWaxoZv/5IwGJ5oYHCIVoo9YXWxNyyIhj0b2f+JCIW3lLIE2Cq0IewkaIQOqBoNPUPcqNLvinfICQ+02AttBDPU/d+f08yfFRtK51G2OtXzZ+5HC2ZHE/nP/9mbWZuUyUtuOr0hIJVgZKX8oW1ljynivJeyirhhD+/YF4lCoNKF+rf6oByanJ3QU7GixEbaeZ1qOUq9K8Ft208F3FfyMy2bmAjx58nCzzL7TmN45/bIM9CyoVmt3kOEGsMIpklwFLbJ4UfzW1KMrHt8JrZ8v7JPaxRvfztNUFoXPnW5B+ThQPplrgcXsVlpG+GELdSD1897skc36dOXRmlxki+fLmNVlBIG4xafg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bc6253-063f-465b-4d2c-08dd556484ca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:20:37.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nyNdbBl62vzVsVopANyyPsLaIUNuBPiYmE0/ulqrNkMChNlAZ9no+Y/ZPTYXha9xsftTXnqQyvo2wAWY50CT+woR44YoBqNyjkCwat1j/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250040
X-Proofpoint-ORIG-GUID: t__Y7tkwkojYzy-cTUucYa3K-nYHb5a3
X-Proofpoint-GUID: t__Y7tkwkojYzy-cTUucYa3K-nYHb5a3

On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> the vdso, vvar, and compat-mode vectors and sigpage mappings.
>
> Production release testing passes on Android and Chrome OS.

This is pretty limited (yes yes I know android is massive etc. but we must
account for all the weird and wonderful arm64 devices out there in context of
upstream :)

Have you looking through all arm64-code relating to vdso, vvar, compat-mode
vectors, sigpage mapping and ensured nothing kernel-side relies upon relocation?
Some arches actually seem to want to do this. Pretty sure PPC does... so a bit
nervous of that.

At any rate some comment about having checked/confirmed this would be good, arm
concerns me a lot more than x86 on this front.

Thanks however for doing extensive testing android/chrome side! This is of
course, very important for sheer volume (and probably worldwide % of deployed
arm64 devices...)

Just need to dot our i's and cross our t's...

>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  arch/arm64/Kconfig       |  1 +
>  arch/arm64/kernel/vdso.c | 22 +++++++++++++++-------
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fcdd0ed3eca8..39202aa9a5af 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -38,6 +38,7 @@ config ARM64
>  	select ARCH_HAS_KEEPINITRD
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_MEM_ENCRYPT
> +	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index e8ed8e5b713b..12e6ab396018 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -183,6 +183,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
>  {
>  	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
>  	unsigned long gp_flags = 0;
> +	unsigned long vm_flags;
>  	void *ret;
>
>  	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
> @@ -197,8 +198,10 @@ static int __setup_additional_pages(enum vdso_abi abi,
>  		goto up_fail;
>  	}
>
> +	vm_flags = VM_READ|VM_MAYREAD|VM_PFNMAP;
> +	vm_flags |= VM_SEALED_SYSMAP;
>  	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
> -				       VM_READ|VM_MAYREAD|VM_PFNMAP,
> +				       vm_flags,
>  				       &vvar_map);
>  	if (IS_ERR(ret))
>  		goto up_fail;
> @@ -208,9 +211,10 @@ static int __setup_additional_pages(enum vdso_abi abi,
>
>  	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
>  	mm->context.vdso = (void *)vdso_base;
> +	vm_flags = VM_READ|VM_EXEC|gp_flags|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> +	vm_flags |= VM_SEALED_SYSMAP;
>  	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
> -				       VM_READ|VM_EXEC|gp_flags|
> -				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +				       vm_flags,
>  				       vdso_info[abi].cm);
>  	if (IS_ERR(ret))
>  		goto up_fail;
> @@ -326,6 +330,7 @@ arch_initcall(aarch32_alloc_vdso_pages);
>  static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
>  {
>  	void *ret;
> +	unsigned long vm_flags;
>
>  	if (!IS_ENABLED(CONFIG_KUSER_HELPERS))
>  		return 0;
> @@ -334,9 +339,10 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
>  	 * Avoid VM_MAYWRITE for compatibility with arch/arm/, where it's
>  	 * not safe to CoW the page containing the CPU exception vectors.
>  	 */
> +	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC;
> +	vm_flags |= VM_SEALED_SYSMAP;
>  	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
> -				       VM_READ | VM_EXEC |
> -				       VM_MAYREAD | VM_MAYEXEC,
> +				       vm_flags,
>  				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
>
>  	return PTR_ERR_OR_ZERO(ret);
> @@ -345,6 +351,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
>  static int aarch32_sigreturn_setup(struct mm_struct *mm)
>  {
>  	unsigned long addr;
> +	unsigned long vm_flags;
>  	void *ret;
>
>  	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
> @@ -357,9 +364,10 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
>  	 * VM_MAYWRITE is required to allow gdb to Copy-on-Write and
>  	 * set breakpoints.
>  	 */
> +	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> +	vm_flags |= VM_SEALED_SYSMAP;
>  	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
> -				       VM_READ | VM_EXEC | VM_MAYREAD |
> -				       VM_MAYWRITE | VM_MAYEXEC,
> +				       vm_flags,
>  				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
>  	if (IS_ERR(ret))
>  		goto out;
> --
> 2.48.1.658.g4767266eb4-goog
>

Patch looks fine for purposes of what you're trying to achieve though, just
need to have some calming reassurances about arch :)

Thanks!
