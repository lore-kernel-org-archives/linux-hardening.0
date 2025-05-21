Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48217C21B;
	Wed, 21 May 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838754; cv=fail; b=i7jaJbS7nCn5VP7/RvvSVbeZv7TukOh7EactO8LnCVRk5MkEDExuA9jKyOrcEB2bIUrXSNzO7hvHotMmJx525X+zRfuQj+YdtJ5eEopBcBA4KEarqGqrqxfVj1gd1c9zMCIZ0NznmOq+CBDJpAdWnQszNwEfzV+RU4npcQ/awmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838754; c=relaxed/simple;
	bh=gUYiaHDIZMVrmzRjR/M0BTdygxOUGWhvrmmdMh4Fzh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HpAW1v/PHm2otAMAnlKrghcueBayRL0DuCSBwFwY+10mcdJvQLMP9nU8w3Aq6OY59L+GLLT0HicvXSx+9ZTrgBzFsYKrIC0J+sDtNps09tjmLMjmXOPXkSGHpZ83VSsavEHXDiIvZ5rvagwI5N+fhccsRP7nx6qf7lts6NEUtdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZWagHBkv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tfNfNjUj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZWagHBkv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tfNfNjUj"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LEd86L005310;
	Wed, 21 May 2025 14:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gUYiaHDIZMVrmzRjR/
	M0BTdygxOUGWhvrmmdMh4Fzh0=; b=ZWagHBkvkKc++5ADsLzc9hR5xzfaZhV/2m
	rDhTuavogyMWUrTzRoDh3zgjQVtIjTHLCidACZFJVWrCwo9z+Is1E2oMdXFNq32o
	bknSOBW5C+KXDU7hIy7qvAqCpjgREtPtm49tII8YlSkQ6viG2nt9TT3ZHQmX8TCL
	wbgsgplT5j7vbrfWiis/BBF7N4hLlNOkWV2I7Urq2WgljFArdv7iTGEKuS4QLGpC
	OsERKqIZL19cLkinaGF7Igy0vpi46NXaRabO+VJtyNBZEWwZUREnISdpFLMoeJa/
	EgpgHapwMTz0IZfPGW86p47scZdGrJ3jyANU1O28MRsAlx/iVFNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sghfg2hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 14:45:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDodDi020313;
	Wed, 21 May 2025 14:45:35 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwetxxkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 14:45:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzQBcmHK1u/uSDdBh7biUyDyW25SzswdYenrqLcGXscmWUgw04AWFgKVnJOaddy7G5OWhp3MyAksUds+yV1LiuWdnKPy8oSw1nPdDM5O0gJY30a8YIvCez4ukfcQC5XHuXvf6OZajhCO3idD0ZLJksIBNVIiOPdpNYCXRcud6I0xG7LuGUzi/3w2xT94DVqoSsRFYZUEn7RRvzDKGqPLv0TyBXpq0wPq3YE501WMxjI7zVps/YhJ7JvQ7IlLY7X8p7W+sH9853h1brNGgfYkxYRYIuQkt5B82xRkclevNmBigwHxpB+Z+P/eK1jiCVpnqbfq0pxFhuEO9NhQLkn72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUYiaHDIZMVrmzRjR/M0BTdygxOUGWhvrmmdMh4Fzh0=;
 b=X3GwLoEBsTsB9qSUlAS/G78FAkk/ljYFuR9L5FYyHGOakEEnXlW+EH2EbOydHtzrLL7afi+HKnSRVmyJmnOYdiKYcOrLIaC/zfMs+AfBA+i5cgjRQB82Jp86EGjuEgi0KHDZcnN8txEwpKtCiGS4yOCqZ8H3HvnmRj2vK+IFGRtgPYXUYm99Akrchtf0IrmMPqriFsWy0Yxr7CMmDNM+ObJ5Ap3uFqd5Y7IzZraU77dIKQT2LqqKnpG38Gr4f9ee2qZSSvnq13qjpAXTdBAMURu3AYUDIr4BJgE82M8AIvCPyekC4uBTfJkvTGW57jKKgDKt7RaufpXNs3F1q513GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUYiaHDIZMVrmzRjR/M0BTdygxOUGWhvrmmdMh4Fzh0=;
 b=tfNfNjUjPC7uIBMxsqt/i0nAsjwkB71tR+j3hJGPUbhVGUjB85xkRjGV6Q4DH3EwvALxYjwPaVsaBLx/a1nSGFPkpkSrFLQKRhrmZNBfuaS8ZnIJIzzGBG+QxvQXM9TdyoT7Gwr3nxP3Qieh3v0rkkFvSeiSAKR9J75lehQCg7c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5709.namprd10.prod.outlook.com (2603:10b6:806:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 14:45:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 14:45:33 +0000
Date: Wed, 21 May 2025 15:45:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, jeffxu@chromium.org,
        jszhang@kernel.org, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        kees@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv: enable mseal sysmap for RV64
Message-ID: <5d5bb33c-f3ef-4934-a1f9-5d1a13c0c3f4@lucifer.local>
References: <5e7f2acd-2eef-4e69-9c11-ba8d1ec0bbc5@lucifer.local>
 <mhng-db41d38d-d3ec-4515-99f9-7368c82d46ca@palmer-ri-x1c9a>
 <26e04390-058f-4174-ad6f-3f0afd803fb1@lucifer.local>
 <3be862ef-f8b7-40d6-a3b1-5e8161801ba1@ghiti.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be862ef-f8b7-40d6-a3b1-5e8161801ba1@ghiti.fr>
X-ClientProxiedBy: LO4P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: c2dd533d-b50d-439b-267f-08dd98762408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WMdqVcFYgSvldamzjyTxEdy7fVvrCb0SDyU1PPejHclsejPi2W/4aRuPQnaf?=
 =?us-ascii?Q?zSFwjWn+/6W+7D6BKYccMxrzUmULjO0aLw0Yj28/CD2jux5SQfd2CV4jaTnG?=
 =?us-ascii?Q?r5ULSEUonYM4aPLWBu3Wem98INuhNOXJ2Lhh07Xng1HdfimUhgZs5UaLg/Dc?=
 =?us-ascii?Q?Pr+6uZQWbxjEc9DcbLsbVxlP4ZVDkm6/l+clpp6qizjlpw2+AuxNo0kjWVcP?=
 =?us-ascii?Q?47rfz/hXGvD0swF/jG9q+0zYdssf6oRC38w0lgR6IbF5dsawBNh1/IjVym5H?=
 =?us-ascii?Q?bN6G05B6iBVYlg2y32eOFenWYXN3QconLB8Ik132l5D/AzgIgO4I5vZq3b0k?=
 =?us-ascii?Q?7jEY/dZmB4GiWqAbqCZvVmqzrJ1XZDTLQtvO2dyLFnLGYGs3t3NtIn62UIP7?=
 =?us-ascii?Q?N75rRRuXP+kSMmOOkhz9vjgxzCi+ZCXf4TXlwWTaueNpW05Xuglo3IJ7m8bo?=
 =?us-ascii?Q?4bekBRaeeDq7ZAhFOlpmJKOnIftI8nFTz+bTNxYxCoRVkRggya4M2kn09jZm?=
 =?us-ascii?Q?2EjRrPkcC2KsZi9sYLSigAaYxgTcpeDryJHa//BNXlVABSrJwcNM9qWWDE0M?=
 =?us-ascii?Q?wCsctccSx07KsGGlRNxC3SGSX0l/shcFaXBfOpgcqDpPHOTI0ZD79sL4c9sL?=
 =?us-ascii?Q?LMnYdmcZvfCN86HNhCga1MjJ4tJ8c6mFwGXJwgfM7pj781HZBykn7DP+q3GC?=
 =?us-ascii?Q?ibjk9gkmM6JJIGx5x9x2XfwDfdUW0+wkmCDQFM6Z3GopGpDLUGddmNQg4uj2?=
 =?us-ascii?Q?q/tT2zzG6q0eJZiCY5GOPQwlWSZzMMZlCb+HgeYbOeiMXXcbYpACvxSrGn/5?=
 =?us-ascii?Q?jBVuGtciynFROgxh36TSqhnfuVenL8X038ieJ2NW6KlYqyBJl/l8Bf01SuIV?=
 =?us-ascii?Q?tc6zO5OiRXT47E+So8XBEeH7uL4od5p9eVq/BkvGs7VDPiTn0rB5yJzxhSUu?=
 =?us-ascii?Q?4gLDh5f2JaPUCIpFDyGRsNPjx+yHgsbDRDLOolYFwNwaupb5236DVQx40X/B?=
 =?us-ascii?Q?VT/7cXtJfMVlHtANz5S0Svpl+NMLA8tvqFp8Ekb0MkSfebdkGfNAZJYvHK5W?=
 =?us-ascii?Q?5tGRUsMMvukv/pvgze96SrDK02ffIBuu32rhkjHt6G+Zc17hk8gvj01BPqmb?=
 =?us-ascii?Q?VSjLtcbASLNrOh+iCCts5qAu5MUdGbAv2+988+SA8RxOJ6oXd42GVDvYh/Zc?=
 =?us-ascii?Q?hjqXOg/EiLu5D0mHZYcocv4qbfRxOb6Ooyh/rNvVYAwV+k8tpnFBDi3K9kfd?=
 =?us-ascii?Q?OQXGQWxIsD60T7BCdunJ/vI5xf52uKJxfpqxBv8Qucx8Bhqplnt6Antictp4?=
 =?us-ascii?Q?8VniLrIoFCc9NvUE3pjt5NrJ2H4usOa7LuMiFOoBD78KkW4FwGecxdlwrULE?=
 =?us-ascii?Q?4Z3AO75lgkQgJRugCk3+XwSfkTRpXY40mjcljJQyalub3xEKqKCyNCALG4FK?=
 =?us-ascii?Q?Hu+LJu179XE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pC/dLZwdPi+lH0W6wB6TkuuEQOjjnm+bviNpLWtKitC4yclSWxp7XcU+4Y6s?=
 =?us-ascii?Q?OPzko41EBl4u1SnR2AtJSnywcmT3R10ZkpSsBL3UWr6nIdUNLeBV7tEBeBvI?=
 =?us-ascii?Q?W8xdENeNO/0PHiWybTmx+SOTDRjE0oGFuwdFCjMMzdCFCTmasOGPppkaVOqF?=
 =?us-ascii?Q?i6d97faAwQWNHOcYRVIgYB5AEDfNvlMxt8oUoRGM/98C+EvdoQlaK8dZcFPg?=
 =?us-ascii?Q?lsdxocELiOE+Z9klB0hxgv0mWQfXff9Ept7Y0y505kaWY0g/17gmZJ71H2wi?=
 =?us-ascii?Q?yjdMgNDqFm+FeaEy1EeUTvl8SBk7enmZmycFnOWznNpF4ZWIuflPYBgrWQJ1?=
 =?us-ascii?Q?UN2uq1Crzql0dMMr5FvjzSTqUgJiJT7liHgKj3anJlO0txXWrLiCJcMRV6B2?=
 =?us-ascii?Q?R5HlMM4coMXkVrk6Op9DTV+BFeWj56kwBw0CBoFy1hRRXwet2NO+eDYBhAud?=
 =?us-ascii?Q?UPD67113oLey1F6u6WCNhsjvbq8mn9dXUH7x/yXX/4k+h675OpLePXkVoCwc?=
 =?us-ascii?Q?C/AOL+K/aWg8aSFOel/Y0ibYrAb5pnyOFYRV9kIzue2YsIZUrz9JqDHxW/3v?=
 =?us-ascii?Q?8NhVJMaIqghHPfY5IMCErt8GtG6XQuF62nB3fJfy/s7PImCPg7t5uAnvtY2I?=
 =?us-ascii?Q?gRFvQtj1qs07h3BzXPvfMQoa5Yts2Glu47QAFhBE6dN2GTDHu/y3r35lyozg?=
 =?us-ascii?Q?pPaKqBB09W+OrYtc/LKoSKbAd/ji8EM3Kix0vx2hyiIgoXonbolKvumwbzu0?=
 =?us-ascii?Q?VuNujwyjOv9uH88BYGqmCNxxoaqF+N096lD05v8BofMSBQspW8iJD0jtaJLn?=
 =?us-ascii?Q?V5tS4HPz7nzSBz8nT5wg8TJLu4b2bt3tQIy52CXXTx16m8+HcTaKhkqfd27A?=
 =?us-ascii?Q?gzUv9lzPYq61lOSA1Nsj7/Qo5XJFwepmyDEVqfL9Pf5GJqh9Dy0mG065qNQQ?=
 =?us-ascii?Q?4oqRZREVbF7WDdgFRSf4/+eBxY3Wqx3Ayg9wkjebEoxOK5hQrxMnj193GNZj?=
 =?us-ascii?Q?lP3dc4WVe4wlxoFXrv6bzeWSy5FVKxOQoinbgItxsRl+KrA/YcsKCfbdSKww?=
 =?us-ascii?Q?QowTW8yUIaGJeTGK6DQN6tYezFAAdUelDZQ/eP4PYyvhnfduYrXtdWZzIsdu?=
 =?us-ascii?Q?Y9JilHchHHTbl0okL1Hx2bChrTwdNZLpffPVy8Hrc5ibnAtxHJ0Z15447+2d?=
 =?us-ascii?Q?Qgv09LesZshsBnix/Z00VdosGtpYyoP3lYhnhmLfx8QFx9sEjLLELQanBkA2?=
 =?us-ascii?Q?YAxmg/ytX/SGm3XlchYVBfbK6KFEA2NEy/b3HRCSkD7N/WTrCnpNO1otDZsh?=
 =?us-ascii?Q?mUdT+sjrPFoQnMk3MzZVwtt/mKfNp8ouY9YBWqrr/oRlhoAftWnRwNCibLEQ?=
 =?us-ascii?Q?vGdUurHOktUvY3x0WnxNuGkPWpPaX6mgOS/OYGKO6pK3sapSHEgr4oALif6c?=
 =?us-ascii?Q?53qcBSSMr1REWtnqchJewn10VPY39O4kQPHJpCFITghbX2vFPJZ0PyejAE+T?=
 =?us-ascii?Q?yGVGeT2wDwsVSp6u4Y+i3Lt1Q7XKCbC9qqt49MkDDW3BMJBlP6ZScPPLsFL6?=
 =?us-ascii?Q?YVzuqpZJC0XqW+jkZgfuGT/zUCyZ0JzXtAWMDmTd4ce0jIuy6Tqh6J81if18?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PAwHv6bqiaMnKdm386rmp7Rou3tHYVHoDQtdJhruRN5/Maz5g1uoFSu88YnAQPK1JWgqiLHojxl+gKk8fQuoKWY1aazWPq4JMuQPuryf+89m68atXr8DsGohTNjzohXL7W6uH5YjkgT74dOqJcbdILUtWNHNpAKen42DybOp5CbL5yvT9hm43emFp52jp4BrohdIOoAB8mghdwMyyL3Du5baVHZgLttKxBp4Fkoifr567Z9MiXchYbp66Eu5EfIiZgzQl+j/FFEiv45AQbmkrLLd+M0qbsGIHpm0rqhXz8fV5KaHxY0JMNp6cN9q0vas00E4KIHcjAnsjhQD/YcCDUw7fFQuEGfdOYxfyMBf+NG3b2fLC+iTFhATDKI1lEHK0bHdTEQL5m9fFflw3JBB+W5C5kUuCTVeQIXhuit9eWmYfGI2OjRENrm4g1ErJmv7a1OEOzjVMSyC3TeAO6UkmrdmO2vZlWbJ6xRUdfsYGeLS339dkwKHc66uICwS3hXQWSK86QDp3lBVeVJCU323z0l5IKy/FwvHCCV2TVULoPCm0cbdKqn6C2AIDPx0FhPhlcMrXvKe7u6wKWaSg3UFURY2kDNq1HMEVSm9dGzo8f0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dd533d-b50d-439b-267f-08dd98762408
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:45:33.5327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXbBUUgKwU1wi774h3x5wZeowffS8UyKqLRw1Bf7zOLZpPxJMg8P5t5gAISmJ1HHGl6FJEvClTLG+H3WM2vO55N1WevXncqyJ7zm3JIxeuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210143
X-Authority-Analysis: v=2.4 cv=Gr9C+l1C c=1 sm=1 tr=0 ts=682de711 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=h0uksLzaAAAA:8 a=AWH21F3PQesLF0D8PA0A:9 a=CjuIK1q_8ugA:10 a=MSi_79tMYmZZG2gvAgS0:22 cc=ntf awl=host:13207
X-Proofpoint-GUID: cj46WKMEzfDS9pwWDm1jxp1nAX_1r0qm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE0MyBTYWx0ZWRfX2JVtyHSlyEi2 mxp4t1RPgYZzzpXMzvXXtKB5DdmBBZPCsRR4TfY90u29kS0GCT3y73dlZCDM3cK+kQYqncAZGAw Q9y5clF3U5wkhXibkVRWk8USNtUvSwuPsT0dQUv3RTZfTNGAJ52JNc3gMkiiOODWbiNfNfTBFrH
 rrfFjF/8/OZwImODEaidqnGkhA2cGQDJgM9IClVT6alPMEWlarYdX3EGVj2k2yjUNzm9wdnSRR2 d1UPRNbaqTn7DN0K/rQQWWizQasGJH293N7aX9wNu2wkf18cNENRJyPmZfsZZYprrA46YE7yyna D+gFB1Km4WNkiDxoBm/gMQzpQN1U2Uml4/coKRRyaOwpGJQsnR7xPvEQVTaJsA780BXWQqvVZhD
 944/2UjAq2NPuNtNUX1uKl247VmTHEhq4LuH6tIGikBUz4hyGkZwzVY7or7sIHh4XA4CalKy
X-Proofpoint-ORIG-GUID: cj46WKMEzfDS9pwWDm1jxp1nAX_1r0qm

On Wed, May 21, 2025 at 04:42:56PM +0200, Alexandre Ghiti wrote:
> Hi Lorenzo,
>
> On 5/8/25 20:08, Lorenzo Stoakes wrote:
[snip]
> > I'd ideally like to hear from somebody who's checked this on a risc v
> > system with CONFIG_MSEAL_SYSTEM_MAPPINGS enabled just to be doubly sure.
>
>
> So I double checked and tested this so I'll merge it for 6.16 and:
>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks,
>
> Alex

Great thanks! I think we're good to go then.

And apologies for the outbreak of grumpiness there ;) hopefully (somewhat)
understandable :>)

[snip]

Cheers, Lorenzo
