Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201147E0FF;
	Tue, 11 Mar 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703432; cv=fail; b=D/PY1L3kclEBgTIjkE12EC3WcCVVOWz8FWauAhAbBcEFaMtBdnvL8BTu5fR6sAWQAamoXodIGmVMcwVyfg3rQViNVLYOoX3nA3VZLf2XdymZ+04/zWyH8YBRXupmCiMBM34T251KzhfGwsO9SyDTfCa57R953tBI0Iif70W13vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703432; c=relaxed/simple;
	bh=qFkhbUIP5vfsIHtnKwwa8kNl5EGe/Z1hBfSfwGKH0Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zy4QHAU3ptyTZcoDwhzmIBbTTs3Qeu+oDQs5oD6Iv9OGZC1KXx/PduFoi0paL9y8dta0hjXxFL1iJ+VN8c9QC1rbQMFrlEPFA5EqPOLls/bbr+Ov+21EA+dis2pcr312+5BKiB7bbfUBsycYejYnLWFL+RWTlTM92Qau1+FdnkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o1sw965T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DGeUzfFd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o1sw965T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DGeUzfFd"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMxrl006330;
	Tue, 11 Mar 2025 14:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qFkhbUIP5vfsIHtnKw
	wa8kNl5EGe/Z1hBfSfwGKH0Vg=; b=o1sw965TdWMhoC6oc5Wcsr1/s+o0C8FO/7
	s01NEncUfhQCqQLB42CqHawn0vRzeDF5jVIuKx1ztuISFeTuvF2byxxqYjYFtOWd
	ZiR6d+IwvikEvUlE44ZakF92ahX06GQDCrWpoCa3djQXwuJYtxzrshvTiukm95km
	x2uVLs96mRs4jNISgzML7CcofWsJQmAiriO04+HsqLVrKkPNmqomcKsrtGLUC0jm
	k1oz/GGH1s2pQAS0fUiMhRc15XQeqlfiLRrPLrq4KFv8YAOqedfxiWP5BLcAWxD4
	talJl9qQqDlOJamsRNJcVLai6rP5MtT573g2rXRZgLbQqEkvUgwQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9mwsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:30:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDLFDg021423;
	Tue, 11 Mar 2025 14:30:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbfn3b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:30:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FppQ7DEmpHGp2Z78LZ9NVoY0OLNAwPDjoQigymDcIDR9fwsSNHOBkLE7fqpSycUEYW9/HrjZzTTjaD8NqK0woViA4w6ApfMubp3+KN2VWcNQESOOYxaPIj2xqoGeW3rIg8WerKyEgfCtpdIgeir0Hm/K6RsnSM982HdR3qPrzZqd+yXnSosX2sl6ACH4ZsEptOiJLgx6Y/B8tShzCsjy0gt2nSJ3LHn4fxQJLH6HCIZp9feyMrvGasjwZA971Ceex4ie1w8Wx0trWqyMdxJecFyr3GPZntNT/Gm0jbsKrrhLktEvG0Pur1jZG2EzMy9k0pPCTUer9QsJqqvjXivL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFkhbUIP5vfsIHtnKwwa8kNl5EGe/Z1hBfSfwGKH0Vg=;
 b=GEeMWfMKvkuPSugdBGNuhLXASI2jmiHk7wzP9MuwJYcLtZ0j+i2qejTSy6ZpZSa1suJNpTPxqa4QEpOGANX99ZXBLV7suZpAs8H+lPntU7egwNUYOqAhMT28eZYlJiAj/FmwrjIAineyAktBE87mGJ39U2FLSL4+NdvxlAn2d2eephIQHLn0WlTJ6EFSLO0Tjk3DhgJFYEKkn8a6KelDV33rycrdqsKU0+pbM4bDOXUleDguP8B2G1+Jjc88seH6DjllTHmkJhHGuuUXxjaku+YhkHpBbGDiaqNpaG0yuddiTbpjn4MgrdaLSvytBqk0n8gPn7qn8Hn5aQwhVblQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFkhbUIP5vfsIHtnKwwa8kNl5EGe/Z1hBfSfwGKH0Vg=;
 b=DGeUzfFdfIlN9ZvVNOBonyC/+MjeaXoodDgga8dfMhx7OMBh3nQCMLqar8ZHqTSR7r7HH0RCP+gMNY66ntL/zBW+S2WPBQEvvOH79v2XHOyFZsTQGIeAveNvhenstk1leRrEQ+m16ddCTbfVz0tEL+m947UNcRuzDu07D1aitaE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by BN0PR10MB4981.namprd10.prod.outlook.com (2603:10b6:408:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:30:13 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 14:30:13 +0000
Date: Tue, 11 Mar 2025 14:30:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <kees@kernel.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH mm-unstable 0/2] mseal system mappings fix + s390
 enablement
Message-ID: <24152d85-12e3-45ea-8d6e-c492dd4b94db@lucifer.local>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <a326735d-ca3e-4aee-9f98-4e742dfc15f5@lucifer.local>
 <20250311133736.12846D42-hca@linux.ibm.com>
 <b8cf08ef-0125-466f-89d2-d499cbdcd3aa@lucifer.local>
 <20250311140630.12846Eef-hca@linux.ibm.com>
 <6f106b28-7d5e-468f-8a94-e94357a950ee@lucifer.local>
 <20250311142114.12846Fd5-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311142114.12846Fd5-hca@linux.ibm.com>
X-ClientProxiedBy: LO4P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::18) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|BN0PR10MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a238ea-74bd-4b24-8693-08dd60a93c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DD6puFP1wtVNNw+PbiD3zN/RhbvmODly27IY+vIV+rx4Vo3T1fCU54t8CMi7?=
 =?us-ascii?Q?rPYig+fxZNmeNkAV1B7YUh8gyn9Go1LxU9YYJQJ6BTEgt0sjxgpi6QouW3xE?=
 =?us-ascii?Q?d/RnaGV3N4WvzvmiPqMGniTOqR7z71hkzKKP8BtwhGKsRAHRCc2Z4rv8uCSf?=
 =?us-ascii?Q?vXvOrg8SldWABkPblnh4+anCojBWIYXKnW7MgWLdyfEYrPsamglj93aohbkl?=
 =?us-ascii?Q?M1S4WhJxx2FrYoiswWjFJ6ANROI+m/hyphJh2/UUW0b6nFPbpFlOUWtTi2gN?=
 =?us-ascii?Q?ieLg4EKpJ6clx8zaKe6VjUusKCR4zrs4XtZqwqrbkvP0u9rvS6V4dksrrI3v?=
 =?us-ascii?Q?pT69B9rA+tZLtT70L+xxRWDuw1DPFjHkUtA8gJLQnwIvEaVoYGjjKi3JC4dw?=
 =?us-ascii?Q?nStcrN9H41BdBnhK6LTMiPoE6W6QfuG0NCoOeU/sA1BNuneAy6FRf3OxcQwy?=
 =?us-ascii?Q?iKaT80URRdPRGsAhoj4e2AbwtUg+THuPQkO14CDP1QfJSRAJn8cv4mBYdoGv?=
 =?us-ascii?Q?ctOQ8PcjOvxFqMg3SQBhs8wnAGzi2PSJRBOEtyjmTX/o/NzSKZL4QWF+L5g8?=
 =?us-ascii?Q?o68612dusdiSo/FXmPTj9GGOmwtV/SfWOD8kWo1LqGq3Zhg0ZmqNy5J8n4oP?=
 =?us-ascii?Q?BIrvUR9/xV+dDr8JISQUyVP8sAwFTh25ryFqZkwlO/MUrPyzjYeVBVBgunwU?=
 =?us-ascii?Q?aYDG/2lmsq6v/mvQZK2iT5jnov3HWWvgvrijmD4o9ZAfGKnSSQLKmr36MOkB?=
 =?us-ascii?Q?3RXh0gGVbb1l0P/Gjfmp1X7kL6UCl9/6tAxQk76zn63unvSDtUDxWkFW2LVw?=
 =?us-ascii?Q?ZaQo9/zuRAm70uFLzhOZwB6xYnu5h/BUD6xvQHwA/C2tPXfKaH4Lfi19Nfxd?=
 =?us-ascii?Q?x5qeHGPmok9nWoEs0dlLKOkHG2aSLZ/4cyQiolOnriT3z4KnoxagNPWDias4?=
 =?us-ascii?Q?Ld9qsIqipruw+xEqpy1b0v4YF3+ePmYr0ZBLoGf0WlAV8HmyCgxa9yC0nM9f?=
 =?us-ascii?Q?s/Rh78VB9HmfOGDpJtDX57EHo3rN9u6jLAIR9P0HyGpLe7Z4Jq3IDPoZeb/n?=
 =?us-ascii?Q?yVfXQ2aLDMQxKraKTDKPfd/hmGf8MMJVo6RmMS+CAXtdCJ1pIO2ZtdU6+pmg?=
 =?us-ascii?Q?mCxty5UiGz2WsI9vvdrD7Z8S9v26onrXhidawTe/UdUDRKBQxXUH9q4jypID?=
 =?us-ascii?Q?sez3jOGxbPsnHM1lEeAqpsbnjWUIbJY/dEQHuWYs4+qg5xyDzwOmofOPzLK2?=
 =?us-ascii?Q?eyf+bRz0RP1AWTRyzxbX89V38eK8J/2hC5S57Msg0+tbUOgx52i+HSPFPS5B?=
 =?us-ascii?Q?YYE/xQ7AkV00H+QHedr7AhY1Kgv19o+WhjndqpQD+nh8+ppfMMMqLn5tUk3Y?=
 =?us-ascii?Q?9JZ+Gc0bZfXdPTIsLqMBHEzLEfhz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GUGPSlM2PaJz5OPsw8m4kT5x5omPGC+nCB+nZyinY7uhFdwSsdEaErg5EZiO?=
 =?us-ascii?Q?daKU/+3NkV7Gzqa8XsdEp9HXF0kOjNuuOO6UEfjqPxDJn3TM1X9CkGxPFSb9?=
 =?us-ascii?Q?W7RhiJzxj0GCVCUtqnDU9jRrJy5Re5sQN4cz3IMDZF1dhfb0Znqhg32m4iQ8?=
 =?us-ascii?Q?18v+puDjUOz8n5RT26MVEVsqR15KjkrhVn5NEp6NkijajhDJNpsiiC2+Gndf?=
 =?us-ascii?Q?sA463AhLzAElhaX9IRLEEes+4zOlz4ubqyoc7X2QGdx5er68QAGQ3sU5ZtTg?=
 =?us-ascii?Q?hI9tWda52t+YYPzsRv0TrN74b09B03jjEVndGPwvu7iNxOt6T2G7hL1QIagk?=
 =?us-ascii?Q?aeIRd8JzdJMfDqRMCSFsPjcDPYS+0L1bBGEnEs70rw4GuZ6UxnrI3JplMqdW?=
 =?us-ascii?Q?35nGenYdZvZZOC1Smh4UEWkgLfcEbEvJ0Z9+kopj8bz2qc1JNcOjmzv43Efv?=
 =?us-ascii?Q?M7WtiVN0qdiQmLO6aVgAWueF5DHWgQTngAycXzksXZIB5JZM1BmLFgafvTl4?=
 =?us-ascii?Q?XAZOUnFETHvoTOreQqxX3+TpmKNnH+zyIpw+wcklWllzVaLyrYLA8mV++tBK?=
 =?us-ascii?Q?XWNYZj/h6v3Jp1Jj14YVNNlPNMt9PvRvnderMPRX09VyIyHEipf+tmvZXnss?=
 =?us-ascii?Q?pTzh0REpO7wXPQSDSdhY+bwckiScwmdi3LiOkvDZJA8bCFHzhxlgG79/acdw?=
 =?us-ascii?Q?cmUv8J6LV20unCZSbpBrFpNBal1vKp2i8PMHvzXiKNYtJjQXj6gRHC+lbn5J?=
 =?us-ascii?Q?cYXKwd3Ls6RMUPN0n5Zb22Z06LaaAnMr2qF4JoJY7wFbtogQ+43hNqlPRedS?=
 =?us-ascii?Q?FTKiqobwc8UBGKQUh/EHCwtjDY/ApLSAMhjfgoh/sleDjzF4raTOBkRxLVyy?=
 =?us-ascii?Q?hlCm0FDd1Rf5/VLI6UOQNlC2YdPn1cRivO05g4KQr0gPFKcJHa6NFNPiTPBx?=
 =?us-ascii?Q?zakAqYKB27/y2KTI4BGFkMrOm9FO/WN+YAST5QkSIKazecjX+F/Ko9yE7IOD?=
 =?us-ascii?Q?o4NQV6KRhs3rMhyxQP4im/v4bI+zQAjmewqakVbA7Gt8RVjj1A93GE20+RUV?=
 =?us-ascii?Q?CcSSs/GfA75i1qptm9mOoJyZcdBKXWs2RMiA1imjTer4dpnVsIWfz5OXTIQW?=
 =?us-ascii?Q?/qDVTkFXk6iDlC9bqJh2Di+RXvHipyoasi1EUyFm9EiCRn0s7V3G+7tzh81o?=
 =?us-ascii?Q?2sFBTrMSiTgh/7L5HHvUUO7ebhvQ6yzK7UvE8O70ttkKd5i8ZFnvPGupTeiU?=
 =?us-ascii?Q?sKLTV4eIiKXLHET8VdYNWHWrSxaawhcONxkAwAsMCTc5LBHgoz4ywNZw9F86?=
 =?us-ascii?Q?VcpGlgAhJmUdfpjBroQOfhevk/zIHmsr1qR8psjx26HJ4GUxrLo1G5uzyVjC?=
 =?us-ascii?Q?MR0sfgZuJn+JPXD6zrPJljLQXqfkGgTm0xjtp1hgun5BlZnUiFREZxx/yJzX?=
 =?us-ascii?Q?3B+RaM8KuPaL57+EmD7dyJQXmvXHQprBV/S/D1ClyiaAg9tUaArHYG+GqQ+s?=
 =?us-ascii?Q?+zyraM6immHW7kT8c0mp1q0xhkzlhQr+ReC4VXdDvEDXO8ZEywu5OE1qT8Ta?=
 =?us-ascii?Q?liYldCQZ31DvLqADFH2+tszIH3J/eh6LJ8myUDCClTtDdAuerQeYoMlVLvvd?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0okRpyCpbEBOu331latZjSd3G2hiOhgFdjvm6r8Dj2fYVgnDGsVVvDWWsJIpz1k80+huJ85bAvvfV0HGjY4InMBB0JmIij6CcLi3bCvxrxL+48QPn1rrkTrd4+ZEeecQgxcZ8mjBuNoGSh3AxS18Ez3s77zIKx5+pcguyOytDba0mXKx3afEHTHcxGCeUEkCklrGEl5oEomB9NmW9njVyuahnCB+XcnBD8a5j9bfl+8vNinYM45NX/IugnB//J3HOCosQNuCu65s/V+GmFq4bML+G89W0Iy5z3pgDPZ+/gsaPpZCV5M4cbfMFFvrR8Gms3muUNTq33XXLDoGpFxvkvFQYFrFdp+AN5SwsXQpDSvuqJltvi99PNePO9kkxYwz9PHAVOkYPZ/f6nlUBuGmI6yowgFYchCpqYf6h/Em/S1oyG8jtOkljZj1iwAhReu5HWttLo0RIreyzQ7YoOGxDBareF0dP+YVbUps3+x11cDXFCTbiEht0jrdzGkVNy7TvmSH7o85f2TZwsG25XvFis+1Cumykq5KTKco6cL0o5HRPj+33Ff4drmO/nAZbOYaALVf85g6aiBSiF+oeXs3dtdHoY50wA60AZEyUfrhaYE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a238ea-74bd-4b24-8693-08dd60a93c3e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:30:13.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auTck9BojI2I2/GdgytF+hv2oj3Id+eHmFJ5UXV2WSnOaL+sbQU7FJ/GS9cOdSBjEwbG+nPQ/2cn89qoPSyavx+EHM+ePGbixxqegSesrEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=881 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110092
X-Proofpoint-GUID: VmzaUOh3JBunnyyDfzkcJMIyLOHd9QMB
X-Proofpoint-ORIG-GUID: VmzaUOh3JBunnyyDfzkcJMIyLOHd9QMB

On Tue, Mar 11, 2025 at 03:21:14PM +0100, Heiko Carstens wrote:
> On Tue, Mar 11, 2025 at 02:09:30PM +0000, Lorenzo Stoakes wrote:
> > > When it comes to unmapping vdso: this would break user space since
> > > commit df29a7440c4b ("s390/signal: switch to using vdso for sigreturn
> > > and syscall restart") - there haven't been any reports.
> >
> > OK that seems to implicitly suggest that you're fine with sealing then?
> >
> > I had a quick glance and it seemed fine for s390. I mean it's _weird_ to remap
> > any of this stuff so it'd be the odd one out that does it (ppc _seems_ to in
> > _some_ circumstances need it, for instance).
> >
> > So I think we're good? :)
>
> Yes, for s390 we are good.

Awesome :) series otherwise looks good.
