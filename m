Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432481DB951;
	Thu, 16 Jan 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041744; cv=fail; b=mc+BdieiS5D1CNIMc1yZlW3KJucPRwxj6EszLMbvCLNJhq5pq7pQuOuvAIGkMtCMBLUiq7MgqDyB9UrK8xlCpualK7QvdHbGr7uR2AVQb135abbQhJSTsAARyYWXRPyGT52/al7GXy11taFxH0z3rPjI07mt6QRtiAXJV6eLq+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041744; c=relaxed/simple;
	bh=bOTX4rDjHsCR9y7hE/O4Qt6uWzV6B75Su0ZeoFnkyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ha1kLtZ31ntTIym6+Xw9c+ZFmguYZwaWbt0Q7LflsodtN/WkxT50Hna+6NHj0tRMyfrRWLhT4RL3A0NdLh3mCuGYJ1HzTzFsoB4djeT5JkfBn1q4wflnR3ewnW1jUiJRtd0cNNrDidr37d7MMSGmOeIwrXs/7U5vQuMkEKuvIio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQJ1lX5I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J+JN4j4A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQJ1lX5I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J+JN4j4A"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEugV6002020;
	Thu, 16 Jan 2025 15:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=DrQceB2klilKn0eZMA
	j89/641bwf9JaVBwPfVxrnN34=; b=AQJ1lX5IUhtpVk1uhflVYeFSQy+wNxIEQh
	UdGETa0adpWIS+NuWOKBioKaPHfjO7pDUxqS/LCKr7EIp9XtGmrcjuzSNK/+qBnm
	NAw9VEw/GTAKbIbbDXfM2vky4ygRyVB5bw7oY7n+v/S89b2PolLXqE6NCBlO7s/F
	UYvG7HngwX3qQM14hJGG2YnWx9O9SKTyuvclCQbqih2zzEWFt+UsnRrUOX7N4Hbl
	1f+1OpscGVPfYTi/cexA6RFtPPvowlytd4ZXZO1gZUHEDsk6GfbRiEwRLQNb8aqm
	d8aTvU1P8tW92R8v3ZA39cxlh+WHiRcMRSmPwkPMOqWNV9K1A1OA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446912u5xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:34:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEfdjm035098;
	Thu, 16 Jan 2025 15:34:47 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3axhgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcWFOUQmcroP8BSc3XGcBRsBsY43gk+cEcQX4TJK8s4n4FCdDGC1lXd5JRHxB1Jj0Gp6IqypA4LIjY19/7LbVD5mY6u8b+f1UNEGPXOJ6a/RBqgR+sE9pjvLdE9ksP1VmU/w4NTctBBD022likMs+7Dl/tmkQ7KZNzAwWVrp47yRxdHAEnASzRdrKNY8QhTvTiN257QSZQZIIs7j95iORIrCXPFeTwTNqjgsxNPJm9+L/dSssJfg4iIB2HRkaT1Ors8oHg0KtzAEBKKqwFIXD6WYgeP9Cj7SdLEZvf3Wvs4nCO+TZSH4q9EMFM6DAmylXzKGHcVngmhrXy5hWTqwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrQceB2klilKn0eZMAj89/641bwf9JaVBwPfVxrnN34=;
 b=Y1pcLEJhOUnKAKNsQMjqndHm2xziDaLZ9V9Y8hy63Vlot0j2RU0aWSdIHJL2Pz08a+p5lF5RZ4PktqBaYaZ5xLMySslM7psmI4CKE91aUcDWR9EUU6Sqhx3lxkEYnhuLcjg1BbBCO2Ge3kCplqtCwaYK+yRg39DQzip+AGzrZYhxpo5BYWcOw+IOpmAugOnBfkgVuJv0sWzV+FEDA/M/wDoAja+CQwM1FYh+lNnlX7WZ60VeMRkjOHnc2Z8jeikvsZzMdu7sUYZAWbFnwTz5mU2pwkH3ufQV1+fHraxXiEWjwUdfTvF35T3RCQdCxb0t66Db/wIlHpNXzKlRqQ4wwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrQceB2klilKn0eZMAj89/641bwf9JaVBwPfVxrnN34=;
 b=J+JN4j4ACnlLEDiA9+mX54OQ1Y7dm5xq7wLnyrjJPc4HkA+NMJQom2THmAyjjiSFg6wecMXyj5tHLJvDEUfolK7rgp2DAqW5dA0uv6X6lt/kc4pMP6kk/QH8pjEn08FBncSBwc1WoCVVHDHUU1ZopDaVXuHAwZk4rEedeF73IpI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5582.namprd10.prod.outlook.com (2603:10b6:a03:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 15:34:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 15:34:44 +0000
Date: Thu, 16 Jan 2025 15:34:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>,
        Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <84c6a105-4486-4bae-bbd3-787a4566c143@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <202501151538.3E757401@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501151538.3E757401@keescook>
X-ClientProxiedBy: LO2P265CA0363.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: d06624e0-768f-4f9e-ff02-08dd36434ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oMzwL9UEhQ2iWkNz7N9TYKBoMixvbUwSL/bUd9VdgdKmIUAOXE82/8Oj69vG?=
 =?us-ascii?Q?nhgO4w+zF6JzGnlVnZKFo4gtTm615hJDctPBhGrYOfUC2glSxvb4sMiu4vW2?=
 =?us-ascii?Q?8rkzvOkA/RmvKaNc3Cr0psTjbl8/aUAnUXcJgWM7J82e+QhvnzxjP4fcEcC7?=
 =?us-ascii?Q?NYv2EYjNrt4hWaaLXDrS8MoUS5X8YVf8QPRwP4hBV09AL256ovnvnaKzRoJi?=
 =?us-ascii?Q?QRd4XbeL62bVMjZGI86WvodTVjpRn9cOyEI3Z0FSOLe0CaHGqJTH2YB6m3rv?=
 =?us-ascii?Q?eAILbev2aNKo8OfcJvlCxI8zYcpw03PPvxetbdDbI7Sz70Ny91bcdXD8vWDF?=
 =?us-ascii?Q?Q5/hBFNDLd5FfpUmEoA9XqeUwT/2EZeHtoxE+MPnUIqMoGp8iP4D92QZeOLC?=
 =?us-ascii?Q?qXamH4VbvR5Uw9ECT7EslOX0OwBfFQCeHC6fPXuW2QM6Ku1W3bPFOVcjJxT1?=
 =?us-ascii?Q?fmfUw9BZbjUNNMA3EssLlY6hKYM2yoP9WGhJ8VIpQYMBQPouPUhdmxFqTvig?=
 =?us-ascii?Q?iyotHF0nmKlQM+rx2EGpD3KruayTS4/qrdp5oJOxAfoaBMKHd2DRaS2PU+Yf?=
 =?us-ascii?Q?up7AzIO0vN8BIglGJAwoH6xexkK4JbQfTgHyAV+Ywes67rKzVRsyf1dE9GSx?=
 =?us-ascii?Q?+tvYE49YJ2tvLvrcR1Nl0UmaDo8S1wfEbdMo38a+MmaYgZd+NNHMSBmFuqC8?=
 =?us-ascii?Q?P1zrrGvhBk++J5Vxx3JTc3ET+grjpLGtECgiGCTNGw3cwXTIQQF6A+ydZPzH?=
 =?us-ascii?Q?5QpbSDPvk789bPSDgo/DFJTJmcHHWrWhni8GnB0dpNQqHD5opvNmjqMdg+at?=
 =?us-ascii?Q?nzuEXxjM6skUU7fPK2mxhZ27eJOUzsnk5Yn5226kYOXa1x1JVOMvApgpkKSQ?=
 =?us-ascii?Q?UcRc0F3Aml9KbncYk9Fmh6AjMb5hlEqcTUj94l7JIMrsonXTYys8CQ4nTWL2?=
 =?us-ascii?Q?j1PO8wfNmO/NZ/l6QAkytGRdX4XVYKTge0N22Rn4TMU1W5PVjCMr8+5CjOAM?=
 =?us-ascii?Q?xtvO+gTTAls4b7OKvfFosH3Zgf2vGI7uvFWB2XyxT4w/KVK7xm50zkvCXsd9?=
 =?us-ascii?Q?Kwxxxmy5CLRMM/9bJ5rYtOxgrm97LUxY/1EMb+PpARTb3Zi1D4BFguOxzQ2q?=
 =?us-ascii?Q?si4QILhDNoGRAioy78SkOsXGgOMsgeoMhYVf0bOtp7s4TdeWjEMKnOyhzZ/s?=
 =?us-ascii?Q?qFED0k5CpNYKFuZQll9pYh172e1mrxwAZnKTYBHCAyx+r2wyjIbuzRVjszy1?=
 =?us-ascii?Q?n2x3/x8Ru+rS8/sxX1gNkLAjpQueSnk6IO/hxXUYlv8n78yPuYwOSmRCbP3c?=
 =?us-ascii?Q?ulQmg6aJa72IFE7pHAYiOTmWPXQqm374vg8yXTeMFzzA0BqlUdRFj0O7ZFoU?=
 =?us-ascii?Q?eyplNC94mdReqXfbqZhrFeUXHnMt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOW/QEjBKKYb2lTbyaNCJAilFWnnwulyNr3vLo+CkF4wCwgDzibTJmbU8LwA?=
 =?us-ascii?Q?x/J8+y6tQU5dFYD+Oeq1uTgp558QaknHahqDEMQOOZ9mR7TGB5raBF8RkddS?=
 =?us-ascii?Q?Jq6Yo/CJ8SspWIFbqZAfqZYmhzcxLxc9wfBzvfnclVBP+Tj4hlRNF1EfEnzH?=
 =?us-ascii?Q?flswCLcYUmS3aYppb56IqBs2qibb9v9YUQeYUd6kwnjQb5mx0QdeHwCtB3D+?=
 =?us-ascii?Q?BPnbTr25QMs63kEVjDFAg1ZBpLkz+tuM3yY6AVgSbtnkWIfPlL9Uy5sLnIU2?=
 =?us-ascii?Q?UkdEnSD/G+C9DWp9bv276gKNrlDqnZ994Sf3LkJiZxdO7JYqBwT/DLKNwEhz?=
 =?us-ascii?Q?JX5VyacKC619btfeeRsR8v2/y0i9B+VdtjNR+NYmOLTiP6G5S9dEld64woHG?=
 =?us-ascii?Q?/amWDn9JAhMVXRUpqe08fKrGHlusL6kbSlPH9wJPAmPrthSQznQSJRzKIKiM?=
 =?us-ascii?Q?aWtdceicocgdObocW2br7Bj1csWAZjvjYDGEJGHBG9xCvwv2FiQqcsjQZyl3?=
 =?us-ascii?Q?NUjjVzi8JcrIeDwGZNmdMkRXNrSOJS0MRKtkhA+kf7eQ7eKwIaXbERjDlrUv?=
 =?us-ascii?Q?RVcxUqftDrGJwLevYDjhXYhPgFzeMEQImt22RUTkLZI75XAVDhib2gVE+X62?=
 =?us-ascii?Q?s9i/wHVnCPi1a6e3CNJYPVsXA2VxO7Ftyb3cCtjMqSLbDmy67Rx/spbZgXR8?=
 =?us-ascii?Q?q350H5fgR0OOSu+2imwlynIK0848Dc5J9MsgxZCbpJP822pM+WzEoCWTF/+d?=
 =?us-ascii?Q?cHy0Gl7HZXi9+kBut1FATkNtZtqf0u9FGgEgHMoj83RGrCrvpLJwm/651kTM?=
 =?us-ascii?Q?SbmgZfjvEgLU7QJK0EKWPiKi+EYxcu1yO2mtOWGMYeUTKiR4fqcY0jDuSi08?=
 =?us-ascii?Q?BdVLhyX+PjMpffvXph+kZfkZfgyPzu1o4R4aIqlYeAE2hSQReAZNb6IYDzUc?=
 =?us-ascii?Q?ZzGx2qA9hEm5RkMMRysOgcDDEUYPFGyf85H0H/NGjp0+fUmEKLM5IF2iyW5x?=
 =?us-ascii?Q?NXY+fBbbw+ogeCuaSmGz62snlOnXPPEC+b1MJPWSjqDw4V93iy9U23AmT50b?=
 =?us-ascii?Q?7vTzdf81JHkRaYKWHPiQiCVADh+zzsFS0kg0aPB/ei1GhHHNjXZk7VVFHYAy?=
 =?us-ascii?Q?oe2a42Tt6/CU49T3VkGFhivTjFJxHBGehyUvyQNyVItwo6J4puAE9v3kod7f?=
 =?us-ascii?Q?qSjkGMI2vvNvroD/MmZlEJNVgVJtdMWp9ImJf/ngXHeHhFdrrMs9oRjAH9Zd?=
 =?us-ascii?Q?iFmVwcRs1JXlLnd67ggxFT1i+jvdN2xIzRA95WOJbUz9F/5Em7Vr7+JsuW7R?=
 =?us-ascii?Q?R9Y8xYqZ0RqhRoKvanMoqHB3e1DsCnWgD9cPL1a9yU/QlvxoxAuaRWMv06UH?=
 =?us-ascii?Q?FgdDXWm0bQiUJYvjCX2Nlb8CGCNULBgcc56MWHgpHcMXIx3x+YL3TV//u7F0?=
 =?us-ascii?Q?bb3l7wTHN7D5bJZhcRoxn8Jx2deIU8KyZcW/XsZA6355h7kiNZaHxSTgeAkn?=
 =?us-ascii?Q?zLeTMUdRFmIrcN7iDLAM/AOXhB03lIzuVRo4HAeBmsgxlcGTFQDIgkYUKpxw?=
 =?us-ascii?Q?s51bvlHL58/TjfyNrxKTZoY+9Gwf/zFeTw+7pkG2UIvTzXayr9iTwf1sdEoD?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nY0EfL5mrja4ClnlEveQfyYy+nG9bw7UhR55jpZ9u5H0tQehyxYDWMq+2Sf1QUudPIawgrhynHGaVHascJV64mcHGm71i3Jt7cEQCrnyml/zdOKCkbmXVv4G+PB8b08MIet9ReopetnbxWGbeVBoH9GcLqDdfb52Eu2a2fswsKKCmqTEhRk8ukPhR0hbJ+xbhl89OKEHAiF5oZd2zwr0NN09G66iGyMEi0suliFYInnweVHjpt21wqNluy+MldCUdpUUIjZ5iLbAVT5XV8iAGNkKZED2EpL2lizqIRtgJ+yNXtoNdOkikwjFCXQU9SEKM9AurD4zBUjDxhS5EtfIXadBnabTosxNIU1tCA3uwkLSAIusuEZyn6Z3JrMwhdnGH9fC6DDTWmD3FSHdWPgFhn9u5wst1uyu/++r/Yc58gikIg37TeCgkWIZdbbdXAgp5xBngxncBUezok1DktR2ZUsFDqXNoXa9B0rc5hnPQbq74sxGmzaHsq3Rxd8dZGnuOWuCtzbpkPx0g6JEJVidvyPrx02DApbxPI+/9/CgzQZd5bhsjU7xcw7O1iu4993Mhn+SXq155qOBja/Ru7OKsnFXvXxYQuLnUpdUYrjS22Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06624e0-768f-4f9e-ff02-08dd36434ce5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:34:44.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWj1yXlxIncWWj9EBOAFU40JKPf31kU2v+X6ga5T1ajYYaMHOpBS+QNZbwf2GcRnlvXIgHeClgl5KwM+s4z3GhyLDvo2cn0o6IX2rHHiWys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160117
X-Proofpoint-ORIG-GUID: q44rB7AI92Zls5he0nyu1OuLbaDwb_tT
X-Proofpoint-GUID: q44rB7AI92Zls5he0nyu1OuLbaDwb_tT

Kees,

I reply inline below but the TL;DR is - I'm fine with an incremental
approach, my requirements for arch support are sensible and doable and I'll
_give a R-b tag_ if such a version is submitted. :)

This isn't a discreet means of me trying to reject the whole idea, if I
felt that way I'd just say!

I actually firmly want to _help_ mseal features land in the kernel.

Cheers, Lorenzo

On Wed, Jan 15, 2025 at 03:52:23PM -0800, Kees Cook wrote:
> On Wed, Jan 15, 2025 at 07:46:00PM +0000, Lorenzo Stoakes wrote:
> > You are now suggesting disabling the !CRIU requirement. Which violates my
> > _requirements_ (not optional features).
>
> Why not make this simply incremental? The feature isn't intended to work
> with CRIU. Why don't we get the feature in first, with a !CRUI depends?
> This lets the users of this feature actually use it.

Sure, I'm ok with this.

The analysis at the end of the series suggested the consensus was otherwise,
which is why I highlighted this.

>
> > You seem to be saying you're pushing an internal feature on upstream and
> > only care about internal use cases, this is not how upstream works, as
> > Matthew alludes to.
>
> Internal? No. Chrome OS and Android. Linux runs more Android devices
> than everything else in the world combined -- this is not some random
> experiment.

This is unfair, I'm not claiming otherwise, and I would suggest you look
into other work I've done which has directly benefitted android if you
believe I'm not aware of how widespread a user it is (you're welcome ;) I
also own and very much enjoy my Pixel Pro 9 Fold 2...

I'm saying we can't _only_ consider this. This is upstream kernel, we must
consider all architectures and use cases.

This seems a reasonable position to me.

>
> I really don't like the feature creep nature of the system mapping
> sealing reviews. There's nothing special here -- we have plenty of
> features that conflict with other features. And we have a long history
> in the kernel of landing the core changes with lots of conflict depends
> that we then resolve as we move forward.

There's been no feature creep. I explicitly said very early on what the
problem was and what needed to be done to fix it.

Then a bunch of discussion happened and an analysis was presented that
seemed to neglect this.

I also don't agree we have a long history of landing changes that quietly
break things in the kernel.

As I said in the mail you are responding to - my concern is that a kernel
user will enable this feature, not realising that it breaks X, Y or Z, and
there's no easy or clear way for them to know.

This was originally addressed with config flags, but then boot options were
provided which completely overrode this.

My concern is there is a disconnect between a kernel user seeing a security
feature - and them knowing or realising that it is broken, for instance, if
you try to use CRIU.

Then suddenly what seems a reasonable feature to enable is suddenly a
landmine for somebody to step on to break their system.

Again, I have no objection to a version of this series which explicitly
disallows known-broken scenarios.

>
> Why not just make system map sealing conflict with CRIU? Who is asking
> to use both at the same time?

Again, the analysis Jeff presented appeared to rule out doing this. Hence
my objection.

If we explicitly disallow this (with no boot override) I'm fine with it!

Sorry if I wasn't clear about that.

>
> > I have told you that my requirements are:
> >
> > 1. You cannot allow a user to set config or boot options to have a
> >    broken kernel configuration.
>
> What do you define as a "broken kernel configuration"?

One which results in a kernel which cannot function correctly in some
fundamental respect. For instance, breaking userspace for certain programs
when a feature which might non-obviously do so.

>
> > 2. You must provide evidence that the arches you claim work with this,
> >    actually do.
>
> What evidence would you find sufficient? I'm concerned this is turning
> into a rock fetching quest.

That no code relies on the VDSO being non-sealed in supported raches, you
can do this by pointing out the code that interacts with the VDSO in these
arches in all instances does not encounter a problem when this is so.

I _believe_ this is a reasonable request, and sort of a fundamental thing
you'd want for a change like this for such a weird beast as the VDSO.

>
> -Kees
>
> --
> Kees Cook

Cheers, Lorenzo
