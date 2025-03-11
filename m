Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581D25BAAE;
	Tue, 11 Mar 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703845; cv=fail; b=rQJt/T40FHBvNQ06ccgRTwurBAl/14vHDsv33rfQzMggpV52S8i/JjUUXR0MZ9gwU4/HJv+h2e2dI8r1/97nC2Lr3NDi4f8KH14hGZNBE9oKly39eQCGnGN2tB34fC37AIPt4PIOWYjyX8fA7wzCgwVPC0c3BhhrVeopPW1Ha8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703845; c=relaxed/simple;
	bh=U2htqKLZhelrg9IxQfBsxOBDjJ1SsCDdFCe5MMcqa5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cpW2aFJSzG7HZcrqz959uKyvIcR8tv9J5NPcY0eTd6hwDzb2L3XxoogJ0+QFWX6zFhFSC8to3qS45Enkbv4ODehymK2ApzXQnXGKDYGWY0oC9nCwSUUZ+CzwzbJ8L4L9CAndKKM1yx8U8GYQjF+zKXDybGmRi+n3bOkvE2TfWXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IvgRt6ED; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AZ01JpBV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IvgRt6ED";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AZ01JpBV"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDN1Xd021152;
	Tue, 11 Mar 2025 14:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=mMBPFxsoORgFtOeFPp
	TN6a7AnVrqQGAhUKyAt6ZBI5c=; b=IvgRt6ED1kGFqdXgwMDYDEEMCOgMD8lGv7
	lwQUABXnjssf0HIuONNLB8mEPIiXC4phdMcR8LfkgMrk8yvDwiq5saTGO+1fbn/K
	qp0BPIbvPjYq2uwCPGStkvG8sGd3TAz8a94icsXwEJHr7sKjF9eoEvNe7TlnTKcT
	Rh+O9u2+8xugd/Y2CWMAX3ErlIhSSqbhkzE6gNHLS/akfODRUkOIpDszdRMur+A2
	SFc8phO5SY7ceNA3EgGQ9QpZ2/Lu8tGraCYFjMelQa977/wlFzA3lTwduuTCIyUD
	0UEzNR2y+6uNan7UN8E1Kcu9O9ixFcmFPTVI16ur2W7fNlOiLQfw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cp350cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:37:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEFV0q030901;
	Tue, 11 Mar 2025 14:37:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcnfc3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:37:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4lNfkxxM97/oLcieZ9Kow8CSGP3M0LujSw5jC4BOK552PdYIPhSvUWhMq5dZo0pWvcDbh0mfBAi2i4/zIL2uIch0m5uzwqwzg4r+GpQNyTOQw7EMnERR4pAGMin9MuVsOJWfifs4UL1swMVRgAs4SttEwoO8M9gOyV8D4rz0yrJ/VMUgcV9B8KHg56hDRQiANyqKDHgr1NbGvpwost0ybpC/s2amW9lnPIHuDAWpfPLdUwqBXgUnZLPkjKQKI75M4RgZbw7FJg0cXnVQg5KdS9ayqpv8TRINJIcYMIwh39h+/GXDPbSRQq6NmHW2o2OV/tPsLRmW4mLO2SBlVhH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMBPFxsoORgFtOeFPpTN6a7AnVrqQGAhUKyAt6ZBI5c=;
 b=IiJKCpmFVsm0XnXCSgFjeaA4+ydjH7gqKovBshEWA+u5ltXJGlY3y5GwlgDJEJt+iQKodE4pIpAVlnTtk/0eRMRYonwqqxmZCBN653BFoNKDwjtQAYEf9h4ukT60RtHeQjs30bp55V5rAaSKcGk29xaK+q2VNvVAWX+fMsRu9hdbc8gky7CPRFY6YeSkY5McCTEoJGUb4qgETTl3MCEIN8vhOKarQS488gH3uPgm4Iqhm3e1M8dZFFgOyDYZnbwKIQrEN6orSQ9LdCODckEOMkXz8AWUJyjvmg+rW/xvDGDGONuD8wZIqayHBAOo++VVm2PxezSXL9slfo9339zTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMBPFxsoORgFtOeFPpTN6a7AnVrqQGAhUKyAt6ZBI5c=;
 b=AZ01JpBVerqBdd18wA7kQ9wtwf1Hy9rTuPhKgZsiK0yz3JmBo/a0lkWboySgK77TgxzsRxi/caWmxO23G+tTJj7kbb6qlvk+zRrfnLnnjS9hl6N/Rs6WhLhrAenSbFU3277gZ8WScx/2h7U3DLbEa1G57zvhpQUMYTVykJYNGFs=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by BY5PR10MB4162.namprd10.prod.outlook.com (2603:10b6:a03:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:37:09 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 14:37:09 +0000
Date: Tue, 11 Mar 2025 14:37:07 +0000
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
Subject: Re: [PATCH mm-unstable 2/2] mseal sysmap: enable s390
Message-ID: <fd60672f-fa74-4180-8b10-d02f97886ff1@lucifer.local>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <20250311123326.2686682-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311123326.2686682-3-hca@linux.ibm.com>
X-ClientProxiedBy: LO4P123CA0348.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|BY5PR10MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: af3e66a2-c546-43db-382d-08dd60aa3458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/Ey9dn5j6UQgoKPLtOd0IrWM1OlHc/Dl1kI22mBYFc2sjBgxBxfEOC1jvl7?=
 =?us-ascii?Q?I2JAuAd1RWg7LssVCcI2emV9+rdD0Pmkpa5OZodmZ3yYImj+RuLI8SeLwThN?=
 =?us-ascii?Q?8QDAihDcSA0i+aBrX8k0PmQzD7UA0sPIp8Zs0D7lSzS6a9D/g+hC3NUD3RZ1?=
 =?us-ascii?Q?urUaLLXfLXUlqI8BdrBhZ0DWM3TauMYpzmqvvQaWpvSF7Bu4ylndSaUl104A?=
 =?us-ascii?Q?Ci9yryVpz/qScPBtM/BaTunlnR7AedOe9NreNHPaxrBGJH9gtprdI4QpLLoi?=
 =?us-ascii?Q?LucVQSQOSLN3M/vaR1In+MxYmCjo+GAGPlfoEaG09mp827ZKO1c5cMGshgj6?=
 =?us-ascii?Q?LNr2iBehATyAXaWb/en/u0MRh8mhqzVZnWlGIUGLQKAAxRpDjv8Ftny/FV9F?=
 =?us-ascii?Q?BRMvDUczfVmemWg9DhmtJHY4sDcvyc7zog68ZFFjUCtsObpm1xWudv7Acmts?=
 =?us-ascii?Q?2Vdk7e+gzj2ejSQvU1AkIA+QgU3rdy1r9AK0wVLk3k5wvSmjFZ59VmS6LQCB?=
 =?us-ascii?Q?C1g4FEk9AlkQJemeLSsc0P7kcOO+xzgy0FK5F4nWi7ibJuvJ2Jezw4KrGVzu?=
 =?us-ascii?Q?JIr3dZDinUZT1LBUqPggBFE0Ml+JkbAU1DoWj6cy80ovrpdkvMunY/ykgh2v?=
 =?us-ascii?Q?AXifsW2RXoNL4JLYyB4XpktPcSkSqmCxr+KyrNlH3sNG1JwpWgf/iiWT0P7T?=
 =?us-ascii?Q?D9Dh6v0DKjlZAoPuzNTwA2ROY4143l0yfHa4BMqmXiS3wIztJ4uXr7PbNIU+?=
 =?us-ascii?Q?uG43xYXlJ1nRQzMuMmuH74GgYlrqmt2/V70YZ47Z2bjl/Q+zt78escgtVP+R?=
 =?us-ascii?Q?wRHBChYuRIFLxFneuVy4mYgKc7lH0IumJs95eBXzHAOctuCevvN9KZycxfni?=
 =?us-ascii?Q?w8vShlpcGMkmmtu5Te6RndDXHhVbrjuhEtMJY49Qihd1rzvRZV2NnrsuCUib?=
 =?us-ascii?Q?vpNzazO9wj4sPc4WClnn6o8uiVku6SX9SX9FHZy/nEpqy4VTAtA/Jc/PA5oG?=
 =?us-ascii?Q?PEseJUW0FCYeyFIuGs7IvlXhBLRkt62DVyqRbRd5ahFyVJ+mo7HyiosSnHb1?=
 =?us-ascii?Q?LxID6dB/WNOicwxTEhhxonDZsdBmeoKi7GmrQDz1vKOGjo7xmz7kcqKU9lrg?=
 =?us-ascii?Q?dSD/Fyhw3aTEQPA6RG6h447zcMDqHg7LyVB0Limxhy/DNcKMG4D3/aM1l+Fh?=
 =?us-ascii?Q?Yg7mhB5JzBCjOQF+vStbpOTUdjclXnuLYD6ZMFDZgIltXOeDNWTcyNpvEFLp?=
 =?us-ascii?Q?iDs7YgZpw3BbGIgCqd4GplwA3cOeRrLgBtDXv68D50FdCDPHRZm/LbW834AB?=
 =?us-ascii?Q?zoharsjHAViAhpT+xWQBiT9OD7pWJjo9EcngH7ROQEHYLaQqo3HwZ1gRBaea?=
 =?us-ascii?Q?wSkSgVtsLN05Kta/jXu68btr2T6M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q/NXzusQ04h5G+/tbDnpxdoUI8n9o66/jkRTM+3JoVYQ4g05AmczHHdTvq7h?=
 =?us-ascii?Q?AhRm3hvYSyk22E7Zw7LrV86AnIkuF4lWFyO5Kj9eoXsHU3Nepb4n69JGxKg+?=
 =?us-ascii?Q?lnaKBeoMPqwo3W+OXYM3UB6JcVdDMZtaeBlt0UiFaZBHi73ioeQNF0GL1Jqo?=
 =?us-ascii?Q?jX+PoXuOGe+A8eH3KThH/S0vjRsJo1bMDGHL77kIsE3QkS//Xx1ga5QHGXb1?=
 =?us-ascii?Q?LF/hMF40ybHQeZKFQ512LXuYDPww8sH3F912VN1gJ738rPQ+J7iTEI0gwLI9?=
 =?us-ascii?Q?RRR04GaTs9NsgyJoCUkIpkwX2Iryai8sDU7Z9EOlXxCSIqtxipaes27ASkHe?=
 =?us-ascii?Q?A7yEWo5Ec9DMetTvgojCYbmsLccuVyG/M3pFMKqhi2f8wEUVUlX9Ma60ryv8?=
 =?us-ascii?Q?w7VRal0k8X4HxHzmQZbvd2g8Ed+ygiUYuLeYy7qOksWyKphCpHwo0Ml54Yki?=
 =?us-ascii?Q?S9ROqH6PgVJZmz15iw5uYAQmxnxe1aCr7H+evMonIhYkYs7TU9Z6dSCjSqJs?=
 =?us-ascii?Q?Z7uXGV9jgEbQqiL4rcaueh9D9jx+Iqx4yhcgl5fjOvkMXBlsUeHTP0n4RvGj?=
 =?us-ascii?Q?9YGzVaGE3flQkHt8TQkO6hvBwFtD+0MSZBX6rYhxSwCaJLD0U3CU1XKsIaNk?=
 =?us-ascii?Q?8+qDnk/Ml/B0tsokNlbO6yO4gNdKzy4yJ1jBnu24UZ+yZ1hk7vV6FNmn7m0V?=
 =?us-ascii?Q?+f2/yJsvfzPg8bG8ROx6yMFQsVl33uRkvWE9HbkwGPRkpNvDAWU/nZ5jC1yb?=
 =?us-ascii?Q?YS4hDsRyeUELYwLFN4Nqazct52qjPZpKd6egxgjHZig23t/eqiR3N43U9w6F?=
 =?us-ascii?Q?CfOFvk5ndHdAhAsBwaVftk0hRQCNZfwoMLIrsJNaLjvXBZ858Iul05ivMlXn?=
 =?us-ascii?Q?LDTPL7WqlXOdFgE4eO2Si7djxtTf7JBF9/rsTTubzAzI0BPrHYI4BVqQBGFp?=
 =?us-ascii?Q?TGCXA/bR7S/6+QmBcw3G0jey0+kp7JdKOUEzSJpaQje4eUpuW09yJYKeb9rO?=
 =?us-ascii?Q?u5+69dzkUYUhZarK133yKgHjTwnbhsU+y4dXlSMB1+AX4yxqc9XuJbJDJN3r?=
 =?us-ascii?Q?SjfxPLlrAup4ajdrQCeHEkA4yS5137JWrXwlY3Wu5DEDujdKX0kMBIfwOJt3?=
 =?us-ascii?Q?ZOJwT0tTiuBKfqecqKCwmEBzBg+V7+tIR9hsZTcI5eDjnYtgejEkbTwVPGv7?=
 =?us-ascii?Q?zmZV3eY6tXxrtI772S57eTlO8O+LtIgXTLUCcG7ES5QobeHoRfFpGl4tkGRv?=
 =?us-ascii?Q?umDjPW+k6oHkslVHaCmi3VR3cOQmzi/v7rsrUGgWKvU/jgd8FpMX64rtMp1K?=
 =?us-ascii?Q?8XuI8nMXVw/a1RgfOCnT5sA7f/kSIomk/BxlZdRG8s0l1P+642TcI3zCqEdI?=
 =?us-ascii?Q?eKivelt9Mvl9Hd2HFT0DPPlEtLGlU9RtrSkLxg6Yg3lwu5bUutMdu23u/XVL?=
 =?us-ascii?Q?T3mX8DravFSwqlCzNSR230DAeYJHCZif/ItRL2iiZt88rkCNaEdKny8drsxD?=
 =?us-ascii?Q?RlYablAc+srWSCB0WviESM2cF4qapLhQgBK2zM2BrXd3eXueSaTdIWU2qz75?=
 =?us-ascii?Q?4d7eBQizl1COAIOEPPgKzcFvEvm/IyjX6uktBQZ72t+6mhRinpEZuu1EyoXC?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	su8ZO+/2JYOGSjb21EjP7xRoREC3H256lyIRz694aOaVmGgk7iYDLSUf/ZTiSkEFhGIyyrcge2s3NWOVtuz2aOTZfranwOQbaJRWNacd6hBLD36QxF4C2QtWsHLTOrSSz7mq6EiGfzWmYt4McvtZ+yWZpg8UDBxCJ4IBvksVYLkPxJaVUUtK5SbUfnHlX60yh9IiZuG51EFsp26+py8i+mryOhlcud+vPbSVUbmR53x0TlNiuHVS4KaRp0IHzCpNfodyuPCroxQeFVGIxN1eAMsN2Rd/4tmCuYUinTn1MxxUtqi2RGzVOhvcmxY7GhL7jcslBpgDGKWLSlAliICWPYcZWCBk2Z8Gkk5zZuJPzCIooEMZ2V9jSNSaw4vyDZOhg63joeRuD7S2+nWItrTCU4NEcFgKGgq9jPMcpmnpmd9hojb7LxZIhw6bkMYkFyt2g+X4xy/jlcNHYBOGWRbyX9c/g/R8L5Hhg+X5+gXfhmgDHOzUtlVG0ACPyZhRPm9Bmf3jWl82wc4Pb5UilOrj8c/aXhdEPFLV8sGssiNJkfyndbn4vJA+KkAKpLYuILlyvvou9h0CoWDRQisEQeaqF0NR5/fWZWh1onBx6bmfoSk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3e66a2-c546-43db-382d-08dd60aa3458
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:37:09.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuaRsZhNTIZxJfLzZ7epqaaET5DZ5q8dmx00DAwVyU5ACNBbOp2i0tHvDN4o+sPbMXChwg3qspgrHfWtC5Xz9L7hIkKMoElk5MD6c9yjY1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110092
X-Proofpoint-GUID: QABJ2gkUYtJS0Y59FlRfG3cr19ErFkje
X-Proofpoint-ORIG-GUID: QABJ2gkUYtJS0Y59FlRfG3cr19ErFkje

On Tue, Mar 11, 2025 at 01:33:26PM +0100, Heiko Carstens wrote:
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on s390, covering the
> vdso.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/s390/Kconfig       | 1 +
>  arch/s390/kernel/vdso.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 608a965e2344..93b880992596 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -141,6 +141,7 @@ config S390
>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  	select ARCH_SUPPORTS_HUGETLBFS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
> +	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS

As discussed in 0/2, s390 does not rely on remapping system mappings in any
kind of bizarre way so this is all good.

>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
>  	select ARCH_USE_BUILTIN_BSWAP
> diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
> index 70c8f9ad13cd..430feb1a5013 100644
> --- a/arch/s390/kernel/vdso.c
> +++ b/arch/s390/kernel/vdso.c
> @@ -80,7 +80,7 @@ static int map_vdso(unsigned long addr, unsigned long vdso_mapping_len)
>  	vdso_text_start = vvar_start + VDSO_NR_PAGES * PAGE_SIZE;
>  	/* VM_MAYWRITE for COW so gdb can set breakpoints */
>  	vma = _install_special_mapping(mm, vdso_text_start, vdso_text_len,
> -				       VM_READ|VM_EXEC|
> +				       VM_READ|VM_EXEC|VM_SEALED_SYSMAP|
>  				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>  				       vdso_mapping);
>  	if (IS_ERR(vma)) {
> --
> 2.45.2
>
