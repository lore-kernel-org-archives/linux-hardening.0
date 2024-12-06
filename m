Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBAECF;
	Fri,  6 Dec 2024 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733459166; cv=fail; b=Tcq/C3sFef3+MUn13aaPcBMjGd2BmB5sRLpKVNS6esmJyaj/7rqil5dyXd/LPJzpDJgDmdki7e63fLpCD65Vjn+l17Ozu6GwrhpZOACJZ+MKqaqPuWRxzlCsVolEvWX338AsNH4PJwOEgJqFFE1CoxUUO6a02j2FjRzCx3qDKGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733459166; c=relaxed/simple;
	bh=m+GWoJ1vDSqQgnkwbWFHAyAcogxPLHzmICSTd7DzX3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJuDPIXLpUyo1JrFi7koY9a522pU+WyT84muXXePZict0Y6+GQ6C5AoIdOYkW1zRsb58jMhvp5Lx3WBSS25seWxLLBL9hsWGOy/YBmz1pFWmfGCJ4hUCB/w1eyMUqfUFYPVQnoTFiGnD5961CBM8g6Q/Cw6I/81hSbvbst9cavE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HxT/WR6e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CdTWwfCE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HxT/WR6e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CdTWwfCE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5LNWBx022841;
	Fri, 6 Dec 2024 04:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Qm5ivSG4mC1OSlzJNX
	WfTEB/bum7z5x6/3zGWx8Y2iM=; b=HxT/WR6eZZ0j8zmpVrVu8xpGAnMfH4K1Pp
	90k7Pvinv1QM5mfogQse5iaJ2Bal2wftJPtBZiK4O47q8MPBIo9xHeuhTm26N13l
	b3i73c5u9H0A65HZ01qrYbP0a0VCMG5wVo0xy0iAUTE4bO7kP1TiDmuz6IyQLfzd
	H+evkJh371VS25NJO2Y+eznPy6HwvdNtVIp5EJai5OW4iCbU2eM7kTVIxsuw5A8D
	f2CVjuENEjvxbPrzTO7Kl/W+HtaZ3Jf4YtcWVpCdH3I99TCwc4ECCAvcQFmdgNbD
	qD9jjt+zh3lTyTJzvLcArTJwzfQips3F489Dk5OIy36ELEs4b0DA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4ccgtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 04:25:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B64KXjJ020103;
	Fri, 6 Dec 2024 04:25:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjgejq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 04:25:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+7lKh6if9sO1GzUAGWtkaYqUtsZgGaROJjW+MPCmBsv6Qlsd4gnzBdz+p+tes7NTz5jTgl1UO4mfq+eQ1n508+eJ9UU58JDuIfLvaaJ/wPVnTxpZiU+fMtuEWo6LQnY5Gbnr2CpEScoD5LHoS/7BjeMQe+/X/iUuy0yXPpH1Yy88O6oZktppmH2ZKoObG7OZrQsIrOp0kNw1DCh46eVkJJU37DwbCxkql2UCkWdyJJGXMMLCADcwpWi1CudkB8mmeSm+yd6MgstVIJxsW3PDOgJ3PepXybWv6GFnOE8NOBRwi+jSxLmC2hWuS2PJoyag9fIcsFc26F1AG1mWQsljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm5ivSG4mC1OSlzJNXWfTEB/bum7z5x6/3zGWx8Y2iM=;
 b=QkLKHQGRFmaUtsf0BBPKCXrtWQ2MAyiZ8hzMPMKaJgFkhi270aXEXn3V/WXf28apFh5yt/ddYAK0dTIrACML+jLStSiy7nONmQMxmcO4O7ZsDxuDgwDRKqOK4n8tAFbaeLo/Yty12r64gYWvmA8SzMDVrnYvnsDlLxC9Cj1kbvZcGQJzgZObJOEzdveIMu7rk+pAu6et9ehG5uPtdGbaox/q7UqALa6D6QhpykP9O/9UXOgAtP1NW2mm9w91l1RFm3vxGanUvWcTma2dUlqKCLXyU4jGKJ3En870Z3SuXSrshDbvcjQkl27NjK9/ArPPyzOyA+JjDAX1iz0uKq0xPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm5ivSG4mC1OSlzJNXWfTEB/bum7z5x6/3zGWx8Y2iM=;
 b=CdTWwfCE+RDUZi2j0yBbRw6IuAY3c9VUc1iBRypFA2ZyojqEOPa17ozmYrsyrMn63BU0ZYYA1LioVI1F0FcfPOMyDt9acDSkbS2QFNeM69zMX6AW8rH5v/gK+5j5d9xvyKC9he5RbVuvMPRHlEnp3xr0YF5qzdXzu3wQouuEl0A=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Fri, 6 Dec
 2024 04:25:46 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 04:25:46 +0000
Date: Thu, 5 Dec 2024 23:25:43 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org,
        pedro.falcato@gmail.com, rdunlap@infradead.org
Subject: Re: [PATCH v1] mseal: move can_do_mseal to mseal.c
Message-ID: <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org
References: <20241206013934.2782793-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206013934.2782793-1-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 14500c5d-7ce0-4266-fc08-08dd15ae0e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TlzgFst6xOIXO62uzLvepGFMYw/JciBU4q5qeKd4ubIXuFsMM3bnzp/ftHCG?=
 =?us-ascii?Q?UF/WltS+Y1xLQj7BozQJcuouSUw+J4rqkY+pyqjC/3bJxLqvvbHEMJazeDxZ?=
 =?us-ascii?Q?op3CSu1A0/o30HsAnTcYMCW9EkworeTgKmvdx5YJkiCToHyvUUZOQ+E+OfQy?=
 =?us-ascii?Q?4zRL+VD9Zc/Ep4LlXz7O95x3sqpo/H74QDudCCfYEDmuO5PdHdooolMq4jT2?=
 =?us-ascii?Q?1HwUyB29Yvixv2owpr7kbl+5Swv045dHPW15T2Wx+A7GW2zb0p85AGla7I1z?=
 =?us-ascii?Q?JHmr3sybrPEAEdnkFDHq3LdEIpRG7ZU3MCmRgLryoJDam758TNzJ/p2rHFoc?=
 =?us-ascii?Q?1/c7a+NBXbwV1Rtvu6ZprFqXDb3ecJcMXhHCLZvOTlnUJXB1bsBnJKGfk9pc?=
 =?us-ascii?Q?0xQn6zxr/kCXOgH0Iq7UWL1TZAnGWKwKQIIiTaLRs2ULCNiIHCJVxT8Bpc1R?=
 =?us-ascii?Q?GKcZUs9BCw+rxY1BUux9wiKI8pIMJIUpiG7pnjoR4X9DLa0SZ0/G1isI0CGI?=
 =?us-ascii?Q?NQ137yfWas5HuVTCs63Sp3UvaQJ3geGiRgprDGnmZ0eR2MTtGXoGNIq1iGfx?=
 =?us-ascii?Q?eH36sVOYf64unVKg9Jgh1uHvv1cLwokiolo7CNCGypJyY8YJ5cRAmBLl2ex2?=
 =?us-ascii?Q?NRSXHQJ/P504PUyrvPrCcGaaIYKWCJsbDAY2lKqHO/LbH9cOokYVd9gx2bZ2?=
 =?us-ascii?Q?rsZioO1AbRSDVq8j0ZqVIHbQ9Mp7wlPDoBZ+YrkCyajczOJYSwMQrvsPJ9GM?=
 =?us-ascii?Q?m22OQ/Q6337KXGkwx2EOsLWcmaqpyADBprZ25t6Hjlq09+X50A5NGGVauUKD?=
 =?us-ascii?Q?/2GL/s7yOUwatXrFVmhGpNhMPiovpJcW6ME+r209lVk8m4b2df5brVtI7x5p?=
 =?us-ascii?Q?i5crKOPTGQa/O1b3ylVHYkjPPrL1aYht1jfmbfntswipifvFY8G/JZMbBxP3?=
 =?us-ascii?Q?4t5XueFVBjSY3jllEChNIDMe6P2nm1XPKmT/JF+g3nuLj5jbjSRJAm7MPRgv?=
 =?us-ascii?Q?vls7eGdMSkhFZCrUV22YQip0BqzGYOgCmyvoWM90dt5YGjA9iqWOkMTbQGXP?=
 =?us-ascii?Q?8ZVn/ZCXKoLHh0VHJsxtbkRSa8a4nhjD2C6uwLtoLPb9EE4sImctk634O3Ro?=
 =?us-ascii?Q?qjh2M+7+4dMkPag4Ava6eRcM+asZQ0ZuXeMkRRu/J7MIMWhB58RHr78bw8bu?=
 =?us-ascii?Q?gEbrorbAAQPp9UejYgVK5DnFUrLuip2p+Y0bAS2QvTFEu2uCpyGqKZUfsMsG?=
 =?us-ascii?Q?SjTHM18YiVrKOuG5G+Gruws9eXFyPrApdmcXAM/X78Wz+bK1FHdzhf/iad9n?=
 =?us-ascii?Q?NLnf/p0hgtLf3coJV4p9XiGvoeL2BwMRjCKLEx9c+2x6ww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kqSNLQlRm7NbT2cZsc62h/IdHHfHOKC32SuOloP1X5LIyM4GBh8trttRRQkJ?=
 =?us-ascii?Q?5kepZGnfRkr2nUZ/u6dlW/8IAJdvXmN3E5yAfshKFqPg1dAxeIUW+E6YPeMo?=
 =?us-ascii?Q?FPDV+mhTUXmzsfXRHPkhLOXptvCwFUrCHkAK5YX2/qxAw6Yuwu4qkMsSAZDC?=
 =?us-ascii?Q?pCCZAXSanjCM06RlaKsR6AqGHbo2uwrDLwTi3m2FriZz40GNgFFsK6ZoOdxa?=
 =?us-ascii?Q?vWZOgGkTusm8xyEkJuy5RTkCvN/DzFLAadGq1a4NhkaWSy21VgLmw2JpV8LV?=
 =?us-ascii?Q?vnqN+IY3mxr/efMAcmZfS2mT1NqkHXaZV1EWxCxKWQJ9vROV7XZ3SjTEzTke?=
 =?us-ascii?Q?BrBO2Kare5jYqgEAmcjY4KkhGwAXB2cy5lJ2IVXB2qc+GIMo03uzbZAxwHlR?=
 =?us-ascii?Q?euz2eKgAZ/tnBOpWZODumUNxNWOsVe290V0aqg7sR9G+5Z8ubRUDW/CR5W/M?=
 =?us-ascii?Q?roShTCRKkBKfq4B1bd6PyIsUWN9llOfePNBczkwZ2M3TPnbirJxLB6C/jpFQ?=
 =?us-ascii?Q?jNKUTTvB8VjQ1IclmoRdFQGD1HEL+/C/32SQKqiFxFD9IrOl46p7EQW0l2V3?=
 =?us-ascii?Q?B2F3xbeCXk9884Xh1LUpAVd2eQ3oAsm1AGjGfr03o3aVcH5vQob0ugkBvX5S?=
 =?us-ascii?Q?PA0ahgpG7HZBRbAky921YzIO7DjPSuTqPSavzATWwPyVQ9i8iBTIiSdIr1eZ?=
 =?us-ascii?Q?Miy3dbC3NDoCDWWABVMO7Y3adjoY5Hh3n+itX/ddUVQJDU3+DFsfGjfzibbJ?=
 =?us-ascii?Q?f5dqgHyKEXu03JgxPILCapl+KRFx7adUbSKsOCGY2VICRDBn3Q9BifiTuOhH?=
 =?us-ascii?Q?x2uPal6KCOrCV+JXgOS8a8W/cbvrlWcxR1e0BAiCDprJ+p+qlor1oI4ve6Nz?=
 =?us-ascii?Q?RR+BmJJeRRML0sb7PEqSTAblfjD8bv4PbMh/4zwoUy83zMK+CcFB8JRoyPM8?=
 =?us-ascii?Q?TjuSwLV6SyuQ/xgWaTSeFI85f7VzTl+l0YkT9ipYwT2T/95AjdfTo2FYLkpL?=
 =?us-ascii?Q?bFfBaWouX0jZK8mBYHEflHMn8Dl1tAWot73FBu5jHFPH+ywsAvju7V+a9Lcz?=
 =?us-ascii?Q?RE0D3rfM0X1Q6sbaTVe8xZpv3SQY+J/NGcUJVrOjXQaIBGHlaoQsSfZQe7b7?=
 =?us-ascii?Q?QIktTm0Z5S7lNOSHisKf8i98HVrA8twsKQsIPh2i/CqHjaJiBIOp3y2CpC5q?=
 =?us-ascii?Q?fFXNTuo0mIedi2GgbDx9ucErp5frn4mMtLPT2/kNi99OetxR8hIxNtmBB/Tu?=
 =?us-ascii?Q?ICi0QMqCRt5YiDpdJxFlb2HdVnkKeousCa9FSslNXpV+iImb4HNy+BcLDIu6?=
 =?us-ascii?Q?ZVqKwl8CE4Rjgq2J8U7BxxbOngdiRaasmrZeQjb57PBhs6jKpvlPHsmGWJF1?=
 =?us-ascii?Q?mP0X/d5/yYugu6BoXRT7X1m8IpOd4GpfXYrcU+EuSn5csAy/A2mPorTCSlyh?=
 =?us-ascii?Q?CbyhMVLFQGCWn5+dhL0UoLAMQNxjYbyy06wa+1zySY+57S0NqdPP+VekN7Go?=
 =?us-ascii?Q?UY0XUl0YBXDEvpsUV5JIypRbsZOoqKHf4rRKvqHL3DsSGqUfIW5RP9oPiuES?=
 =?us-ascii?Q?aEy7tyi7dnQAOE2ePuRkstgMCucFHp9MDjDoqjjz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0N1Ldv8bmXdX1ezU9MJI41KfPBQ0R0rtfvCyWDAEDD/eGlPm4J0URcdU8phZx8adfMolDvPtxeFB2j5Qn5wTDYqjurmfm9u05hpeesFAfKrCj4qmwk68BrYTcbaNZkyG/4aoW7AMH4IQly/Yyu/cZmOcniNVuxVynFwzkxtUkvQH3BJJfuSSmePLv+g1TwVMpQJGrHbNn1JTyo1jfVlvFE8Dgc+DWt7QTh9/t9Aq6p7kWb+uiTT+0K9DQcvrrsp8PqJXks8w0nEcZspIjji4UhBaOsDbLw0VmHR+otKT/Zbmq5IpTGUHB85eEcSwSBFETNvV9djF3CJDCkCJtduzbUzPEB+iM26fKBTNv6sbaT4+t8SJxcga5y0eLHXlK6vBgrc30SgVFCTFHbSKbrp9XjBq1gE0UNZh1/1vKGAL2Mz80r1qbLOODhHEvTorCjo0wi/z6ImMoK6A3N/Jh3W3q8p4fTllFc6TE+f8I8YYrWS+YfWboH4yfQnz0KMli+9gpxIMPQyMDa+VvdHP7Gag6aNPdCziqoogtVJaNRTr4X6/GwE9+GJLEzIMExB+HNoN1tPo0SW/G/yfvIYcCA6USQgPvxjQfPLPoaZW9a5IGYk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14500c5d-7ce0-4266-fc08-08dd15ae0e2d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 04:25:46.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4HBqAc7TsVnThKO1RRGlbnPDrt7mpqTHYpmvJv+otpQKqOxVEq9E+pRJdhD1+K8A0GStDNIkbvBo6RNX8A6lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_02,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060029
X-Proofpoint-ORIG-GUID: YKiIoJzTz7z8wFm8hCrxQ61w8XoxcUqs
X-Proofpoint-GUID: YKiIoJzTz7z8wFm8hCrxQ61w8XoxcUqs

* jeffxu@chromium.org <jeffxu@chromium.org> [241205 20:39]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> No code logic change.
> 
> can_do_mseal is called exclusively by mseal.c,
> and mseal.c is compiled only when CONFIG_64BIT flag is
> set in makefile. Therefore, it is unnecessary to have
> 32 bit stub function in the header file.

There is no reason to keep this function at all; it is used in one
place, and that place uses three lines of code as well.

In fact, having it separate from the comment about flags being reserved
makes the function very puzzling.

> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  mm/internal.h | 16 ----------------
>  mm/mseal.c    |  8 ++++++++
>  2 files changed, 8 insertions(+), 16 deletions(-)
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
> index 81d6e980e8a9..e167220a0bf0 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -158,6 +158,14 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +static inline int can_do_mseal(unsigned long flags)
> +{
> +	if (flags)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /*
>   * mseal(2) seals the VM's meta data from
>   * selected syscalls.
> -- 
> 2.47.0.338.g60cca15819-goog
> 
