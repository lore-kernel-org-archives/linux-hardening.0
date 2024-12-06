Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23761146A87;
	Fri,  6 Dec 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515036; cv=fail; b=sm8fm9BGtg9xBar3rvzfBDWAHoByIF5Z9PRFI0TRaSS7OxPswEnV+kBC0zHXnN8zoXR4fSaUlER3xgpVWgVVJaLkXVd8mvkhWCRtzE4ASgRzzY+pXEjt59h1zNwb9+MTYYthK5zm9BukfYdkIOglJkv8z3pM2aqzFj/2grRR6BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515036; c=relaxed/simple;
	bh=q7Yjl3QJaVyYqrkgRz41gre63HrCWlL0FVt2VYZtMQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jdYbIS8WRo7eQ9y+4vv/T75X1G2F620xk8/CtCTYW2KSjOUFIcjlp74Vh4Ejd0r8XVrfpzd+UM7j/l+UKRfMHaDAcgaIUKdpBnQPwbJwftV3hRJ/T/8bkoVkOzPImlIruTbBVUMVaTyLmQ99vAKnUi1yNOvs0g7fKmFgLI74ryk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SrkHaCmg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tzOxlxZx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SrkHaCmg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tzOxlxZx"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6JMic2008028;
	Fri, 6 Dec 2024 19:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pN+R5hFse0qBv2C5V0
	9WgLPzCVFN0ZlvjQ3tMFsAKAc=; b=SrkHaCmghknkE03LTgsi448jsQqBNPwdpm
	+p+vgIAbwKCZY9eL2XatfmoQQZqKtw9bwDDf7dhI8QvyW0cxG2024Rr5Vsa3ubMh
	ldWVB+pb1b+FDi7sts5BZTEXjGow/hc4H/mMerddOu6mI0H2fwuG0gvJf0k7KWT9
	7ilOmYiwhNXr4EOm+qjp6JGrQE2nycGsXTvmGoU/gRk0nQasd9h7Alsk9q8RcZvH
	z7L4GmyCGmU/JISMIpLhdVaW7OCvJSK+oqGl4XmTeIeidj/tyHMssF0RflODt0Kf
	bADCqCJNeNG+9seC1I5EbUDoZFQyL3XbTBhtQi0pfPsiu14dNapA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk963n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:57:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6IkWgV036922;
	Fri, 6 Dec 2024 19:57:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5d8amw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:57:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWoVyIeNwOsuFK+N6TiN/N5mAIuMRLAWHEe+wkNZGotS3+oEwJKGHj7KOHug5MWJkGpESXIIqJmnjzL13EdAqvwhoAFRYeGX4p5CVRoDZU+DaUKh6UhQcucqJcPBSbElftSzpC0061j+ZQVLnrgqUJCeLkMftV9EY6mfq6fr6zNYf00DeI+NGigYni2Q0bbFMLz7wuZ0Sr0/lnesMtdWC9pczTjPrH+DU9mUWRuBdIstJ3/u7pCTmAIEeZhTFTCvzPDOBVpiQdRuKls877a/OQAUke5yx3WGxg5Pm5930V9VRE6/Vj4lGJk+nM9v2osTsIuujWNoHlTAy6ed1mNNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN+R5hFse0qBv2C5V09WgLPzCVFN0ZlvjQ3tMFsAKAc=;
 b=nNUNPRjSaa03GxPwMFj/m2PgJP22HETO9BELu6wr8Lkae9HlZ8lJYgfZNs+pssXoQMUEZI69lrkGnQhBGlHkvBH6SmLGIFq8wY2RhuiB6m1tgun70zyoB4DuzzUWzYXq6tDq366swf5a0I/bP7MghXuyiE4zpt4flAtYb6iwgU6zDkkSekWjuXDkczRwKoqVmgdHRf2eTa7VdMAfV5TgwWl3nIDjN5mhAMo45Gyry7eFfumPd3sr2ATqr34J3TCC7eDab+2nYSMe4z2L0zK6gbuZVMY2keAqvX4xuG3azALZKaE41sbyBLSKNZ9InUf7+WwdHGEA77FR/WIyJ1ab9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN+R5hFse0qBv2C5V09WgLPzCVFN0ZlvjQ3tMFsAKAc=;
 b=tzOxlxZx1sOxB1iKAOI7UpGLopgUmjeTxbk3hf0A8Z45Y9VGFEDIlXnIymRfITeV0R/bETq+pyDzt+WfM1reipK/tBJx/m6W53Npi+d42hE0H72jmE0yYBphYxSrtHD/lX4qMv0RF5VYjDVGKU0ktZvvF3+bjFdTljuklB9PNXs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5997.namprd10.prod.outlook.com (2603:10b6:8:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 19:56:58 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 19:56:57 +0000
Date: Fri, 6 Dec 2024 19:56:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org,
        pedro.falcato@gmail.com, rdunlap@infradead.org
Subject: Re: [PATCH v2 1/1] mseal: remove can_do_mseal()
Message-ID: <607a69bb-9b6f-4d0e-83aa-1ec6903c34a5@lucifer.local>
References: <20241206194839.3030596-1-jeffxu@google.com>
 <20241206194839.3030596-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206194839.3030596-2-jeffxu@google.com>
X-ClientProxiedBy: LNXP265CA0078.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: ae36202c-fd99-4ca4-2b88-08dd16302410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jt8QfVtfcKKBEmA4nFNp6DMSDys7XutfREm4Yq8IO+c9FTlbcqB4jhUqFLPS?=
 =?us-ascii?Q?hQH7GzV4ksybxCTwPMjL/3dOS1nayU31UVB34eNR0lJyEyJ5sZfC3s/Mv8GD?=
 =?us-ascii?Q?gQ0nziiHp2Z/kP75YSJs0HUpT8L3gLH7r+3GimGRwwPa7GoNVm/ZfdE7ubjm?=
 =?us-ascii?Q?DS00u8cUS1rA00GobzZ5M9yXMx1hcMzVexjnOmZANnUGZFuoFAszxbqNHTD1?=
 =?us-ascii?Q?0o62/2Zz0kcjc3NoIlIuc+GLTrrvfgnizvRggqikkiX41ZCep7nDHiF7dvol?=
 =?us-ascii?Q?kmHDJdJLuqgrNoxVSEOg31kxIdFR6G1GkfaPAv5X43OJCf9TyzXTb4zA2+I+?=
 =?us-ascii?Q?38hbYBuK2WMxdmXcfBqYjXZZS85YTUuBIjscabrkP4y5gum7ShG9RkApIxF0?=
 =?us-ascii?Q?GG5o3t/Qo0hNkYj1ebnC27aqUo0zpeXa0PzLjEaGbGlTRAY5Jl7X9mOvBACi?=
 =?us-ascii?Q?8yAOq6Q6mNDU1+HcvFVApb60/Lzgm39NZmBKFfnIGnx+zQcxoSCWqAZXi5wt?=
 =?us-ascii?Q?l4ieL7QKogjBIOOP+Gor3Hw7c6mIY0e2z8j/gdKTVzEwzI7aHHt1KpShSsAa?=
 =?us-ascii?Q?e84fVx1GB3PRYPdK9uw95utkLJAMIYEw/52AwoqlTbEe02yOHGvjh1rj+ieT?=
 =?us-ascii?Q?hvmi2P0uhIQ/ZN2XNWjzyhNQ5HRHpZTlKvszS/IRLQd1t3q+B1lkq1HpLubL?=
 =?us-ascii?Q?1aW5sJLIsQuqYwS0KJ5hRo3gbdavyIS5LsaiBvxh0XgjwfJRCgifjxlul3Nv?=
 =?us-ascii?Q?d6WTaYTDFBfhRTgqMQAsezYX0rlGtgMEPsiRCZXRElE0qqWrbvgf8sS9EY8K?=
 =?us-ascii?Q?7E1GepYI7f7O9CEVl68Sthyo0q/1cMHivJxIwlcsxWWj11EEFnyaLSA8Stye?=
 =?us-ascii?Q?+E4qM/tuiLJr772BsMgA9B2ILMI+RzHrpt7EKKF+GaQkF87IkUD7OA7hTbXJ?=
 =?us-ascii?Q?eZuOd5v8hQu3TwVWTj1ho14npSDnay/3R2MbFy0SwaS4BHR3j1WBl+e/V1/a?=
 =?us-ascii?Q?t7xHbezRO5eYRgY7i9jHlcxSQ5rU01c00F6LWvQAWwnWQFwM3s4eOH+3GXfy?=
 =?us-ascii?Q?0P5B1QMRY7U0LANMuHIRcS79Pugs81zrgEvJ1taLiTN9YJvYnEw+Ok04e+mg?=
 =?us-ascii?Q?YY51fVgXKaBenQ2YtaWbTGexSlUkiXKomysdhYZ9CB15WRw0PQES/u27QWGp?=
 =?us-ascii?Q?0lMvzqBSns740mR9t5aOWP04V2283UV+KIzLCaB9TDUedZBqFVXZcZrD31vw?=
 =?us-ascii?Q?3oWct0SUumYe9Uc997RHxEqilIb6zwDqJvFH1CiyrwvnK/f9FOiFhdfipqLQ?=
 =?us-ascii?Q?VUiPJnl833CnwcMz+UZuMUkvDzIAfecGbzk1I0v2BwtXk/+W50HQTk/N6pMg?=
 =?us-ascii?Q?1OfKaVw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XjPGMQmSuCa7hNrFNhesnker1eBtTA2PrlQwRS4MwoM0QHZr2ALEFwcOz9BK?=
 =?us-ascii?Q?/9Bx3auFFXtG65e0tiN+6brFKpjFLPxm/LyP9ZsJWvBroM9RBIvJRdhLybEm?=
 =?us-ascii?Q?JMP28+LAgPBrn5ervSugdxO5JulTmT/gGbF+RDG2UqW+fom4tyu53b9fUD/0?=
 =?us-ascii?Q?7VQB4pP6iJCEG4Cx4ZlOAC20b2mSIYbX86X+Fnc+dtDFvmp/ilR8/kzUxQBy?=
 =?us-ascii?Q?sbl/s96L2/ousTgYwY3lIPU2enR0AXd4I+wZuSWmfmP/u7aXtWu9W88OvmPe?=
 =?us-ascii?Q?w4XETjomGM/0IA7WGXdJOEa4GKkCwz83lbA0E9zSzXp5TV0bWDstP5at/oEN?=
 =?us-ascii?Q?nJ86cOSHoCF4Kc1dqcoC8tyblDqigLz25F/srtDNj3KSdyxMB3CsgjYrGQ6V?=
 =?us-ascii?Q?HHI7Ls/Sx5U0DfrEgr48S+X9dQ1NrxAZHkUQrb9EzMi+TwiZaB9JrVOsdxeF?=
 =?us-ascii?Q?Gw6RUHs8lFgGSffWHiPTnGS7ZLB9m9QbqbuDqMDF1TnAYJydJljYknHFkEVZ?=
 =?us-ascii?Q?crh/x0gbLh5AqEQzODcoogUwgKRJ9DpkU2+ACQDGao0fxr3gTVuGMXFtGnjp?=
 =?us-ascii?Q?IZHHmaf5hXg1p3/8bgYf34TRLn+PZYiLtFMpwrX4dLV5cINYu1A9ORd6G8og?=
 =?us-ascii?Q?FfLJqDmrizAXH8Cngp/YAqzZMJJ2fAHNTV08TiypjKOPOdNegBx0l6fbKnHK?=
 =?us-ascii?Q?HCii9c+X0UUj4yU7uoTBDhyV+Ba0PUqDRIJXB5Zw3VitMI36aIQwcA7vGDIm?=
 =?us-ascii?Q?KvAezcc8eL76IdUhN4anNcsjGI/g+b0TVTRLK3AjRYXKSlEVW12vBd9L168m?=
 =?us-ascii?Q?Cbvsm/1oin6UWqpTCemU/BvfTdN9TLRlDCcOjWFwU/WyP8U2lXcoNwx4gqeL?=
 =?us-ascii?Q?CwUGPfLxq0owbJpvOPf//t6TW16Fu+J6LmLEUuq+28Fua8BenR6cmPnTlRlO?=
 =?us-ascii?Q?GiQXhI2pN5WG4nJq9dkQUo+oJ8vJuFAVL3mMJSzFpLub8hfqg95yuM9akObN?=
 =?us-ascii?Q?hh+quFD2xduI2+gujDrNkHTET8q259ZahIh/4Zlf+Fo0453dV7nvbs0slXEO?=
 =?us-ascii?Q?shDlPwHZF7LKwU5dZJwZZpGP+0SY92ADzFm/rfNrsprs6gcifpVer2AK4GH3?=
 =?us-ascii?Q?IK0DU+ooiVBvo6Bg2AbiFmPSOSUTS3tnT4AxlWIYm+cmrkUrFDh95xWG/Exn?=
 =?us-ascii?Q?+at/MGGa6/HGuhKT96BTAv32DeTNxpN+ClDTkbN1pbVvw0S0MA5P8V51cdbl?=
 =?us-ascii?Q?scu0VJkH3x8CYb5cHfNe31er5SUH2FM5kpPohi6ZN6ozKE01R809A5FK2NRx?=
 =?us-ascii?Q?GB4fmVRWd9w8u9Z9zqlpeQGygBQtTMn5a0rrW6H8yW3Q8Tph0RN5S+R0Q7ex?=
 =?us-ascii?Q?MLD8oq1kayd3yVUsjrG+n9pB0w7t6yetL1V8TpYuIBSwdAt1ZH5bVzGomzQw?=
 =?us-ascii?Q?Zk3Ph0B+WeSk+ou7dllfoISTtFddvt4v7KMHqweJ+Ywja3GiPMyp57a3jWGH?=
 =?us-ascii?Q?IXipb9mWlmtmI/5UXs2PavLMhHeCSFcRJTnx0WHJdPO6CFT5XyQGOhSpl7FG?=
 =?us-ascii?Q?a8lP+XhKyc3m/fx3BqEbj87QZrvcgMZ7b2YfhHB2pCU8FU+1SWzP/X+KuoP9?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4bf2+Oo0cbqf5qLXFSlw3RaQF7DFMRlydaCq/R8bep7tph8/yEEeHD0hTYqwx9oNTSYlXqcj7H/VQdB8PvSICyPmqoqcwxVWFG2jK55HnsJeTmLCzDueNeeFD96DdsU5For8VqDNZDmlCg1YzpsoqUQKTH3JpgNutemwP0GsXEsJ1SAUvvvcNJENZa9uDfsSE8coeV8sxZGUFh3SJ0n8BfERksWFoRy3UgRoUe1uxgIV87tV7J7twYmXgqMib1lVbE/6CM22DzkYjbPR3teL+6w4j1W93x16ercgCN8FyPBoLQeoRX4brtnPqm8LsJt9RvXF4glvhp0MpR43Tgcb4byLidRnyZI9p3DEkq4K9dqHcNGY3MlYZLnPMAdfLwo25KfewVpPTHuOInyfzzpcxdTmAgCo7tk6pMdSof36VBPyB9rySPQo3XvD1s8N2aqhU6prXe7SoOYiFRecwPoUY5tnCyykvH3d+HzDAxIqkNXCo+DYr0KAItpk5WcwSFZCq3nIldhaihMAaVVjLYQtTV2Q7/Ma5Q5Ek+UrqcrqX0+TrxBwsNqEbIgUhuTcuLVCf+IG/bFsmF6Zb7KJ5ImTMyA9rhwwre3J2jLYmr2p89o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae36202c-fd99-4ca4-2b88-08dd16302410
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 19:56:57.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IYVkw6giyQVbAgDzsnZNRnn+ys5nmV6YwwVGTPmKYjSu7W459sUD3VrahUeloRAjGxSZ5aMH8/eFbcsHElbP6Fu1fWr55lywXuP4TSsyFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_14,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060149
X-Proofpoint-ORIG-GUID: 9kQsCd1oWOKpxxSfl_9s53DFZMg3sIDz
X-Proofpoint-GUID: 9kQsCd1oWOKpxxSfl_9s53DFZMg3sIDz

On Fri, Dec 06, 2024 at 07:48:39PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> No code logic change.
>
> can_do_mseal() is called exclusively by mseal.c, and mseal.c is compiled
> only when CONFIG_64BIT flag is set in makefile.  Therefore, it is
> unnecessary to have 32 bit stub function in the header file, remove
> this function and merge the logic into do_mseal().
>
> Link: https://lkml.kernel.org/r/20241206013934.2782793-1-jeffxu@google.com
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

LGTM,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Pedro Falcato <pedro.falcato@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Not sure you should be submitting a S-o-b for Andrew :P I'm thinking this
is a copy/paste mistake.

> ---
>  mm/internal.h | 16 ----------------
>  mm/mseal.c    |  6 +++---
>  2 files changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 74dc1c48fa31..5e4ef5ce9c0a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
>  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>  			  int priority);
>
> -#ifdef CONFIG_64BIT
> -static inline int can_do_mseal(unsigned long flags)
> -{
> -	if (flags)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -#else
> -static inline int can_do_mseal(unsigned long flags)
> -{
> -	return -EPERM;
> -}
> -#endif
> -
>  #ifdef CONFIG_SHRINKER_DEBUG
>  static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
>  			struct shrinker *shrinker, const char *fmt, va_list ap)
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 81d6e980e8a9..c27197ac04e8 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -217,9 +217,9 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
>  	unsigned long end;
>  	struct mm_struct *mm = current->mm;
>
> -	ret = can_do_mseal(flags);
> -	if (ret)
> -		return ret;
> +	/* Verify flags not set. */
> +	if (flags)
> +		return -EINVAL;
>
>  	start = untagged_addr(start);
>  	if (!PAGE_ALIGNED(start))
> --
> 2.47.0.338.g60cca15819-goog
>
