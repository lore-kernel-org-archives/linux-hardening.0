Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E742A8F;
	Wed, 26 Feb 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588372; cv=fail; b=UYK1UPqakzmmuorkOSMhrAwhRQQYc+fdqwSNzbE40Xldry1I8JElYzspsexp5x6Q+JveJsLqnCr1epNUGGsnj7+4ksSMPQ896Qd8CUqEIZIFbNORnIuePI3AfYF0CXPA2hiWX1Rt9KovZKWt1zE8ix+aITiNUDz4yACTZda/+D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588372; c=relaxed/simple;
	bh=ZOg4o+lsh2LNc9QoawaPo0iXCpXMtB81Oi3cwmKEYCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GPhSXoTKY6rYpQbfz6BOnn1V7aArfhChgr0nOlG8GBknqW+FEHZ7GNrTset7GtE7qId9RheSVS/YrCEMo1Kxe8zM7PttI+zYa5BYou/FWsCA7soBC0Pda/R3CFzMSa0edPaQjK25udodCAn2Hbwrhi0hfcUy6AcVCs4dCbCxenY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K3KrmyN2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HCXYzRUF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K3KrmyN2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HCXYzRUF"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtaRH005809;
	Wed, 26 Feb 2025 16:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=eBTbULwIzRy/LWh98z
	9dciuMHnpTcm3DhZN2zdd8jT8=; b=K3KrmyN2FhlXDq+TnpxdUcC+vGXoTX0Dju
	taAXaCOnNhK5TAJQ0PUFz2N1vg7yBpkeKfqfHv2/fYny7RiIAcqw2B43idpjZxAc
	Bl77KwZnlsba2ir+smoxcy4Omr6zupm7tChx03eJkXqUYsllACZMVgP+y0LQTKLf
	LMaRgnYq/i9juZ2lCVllFTZ3zzdfW5hxj9uXox29ZrvBYH6MI8J9XgXMsLRMgAKs
	9aw7xBmS3R9MtYe66ZLa6P1CcA6gH4bOVVipJaIvvxmro92yOBNmGDom371TLAqd
	sGwnUpsQALzhn//1B7z/W04qPYtGcQmhlSLq4dg808bHYB8INU8w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf1ht7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 16:45:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFQBPk002792;
	Wed, 26 Feb 2025 16:45:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51b5e66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 16:45:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNpe8Js612qd9CoHEWSYEAKq/G2jh+5F58TxnU3402stKu4CSdaYFVzmqo4dxcRyQtKyr3Ckd91dAkSdzjE+YFI5uUjeUR3uwMW613pxHEH4cQhmDKKxKQEfSDt522ov72M1XzOc9Sk0ydPiDleC/RM2uwgeMGPEUb0vbcorGYRIgm9K2QOL54kgltNq4fMWnEGulHrBtc6WSZLSj7iz8Sd821vjl+JvQuqnHRtRmi4jRwfmVkK/JySigjEbzCcXBV/9SWnEwbF9hsyawDdFUB9vntvaDnM0LtZKI5kJ0PeeKKJ7/soU1w38uLhRkMKWffN902F2K6R3c/Zg1v4e4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBTbULwIzRy/LWh98z9dciuMHnpTcm3DhZN2zdd8jT8=;
 b=H8kZP8B7B3667A+A65kezV0l90R+sLAA8k0YtnblyLnEGmR06gS4g48mwwf/fmjaD31m5eYvONSa6e+CRSaB7EFiOndLE1KUZyEI2xgw6IZuJEQOKXiuCKv4G8VD9gF72zURIEr22IXLhzAD2NAwkK2du0YhTNOjNv5HxIQ1jwwhxUqcBk67ytM1f8UTnagXbcdSmO1oOmUnv8qwwAKeGRmg8XVjPhYG4MokLt32scXXYA8eWZ8WU6Fyfblj6ppx4LInKmIViVDnK1++n5e7se+ZsZcV8+hrfL1KTFsixEO/pheQqq1eWuHfNQx73is+vZnKNemVa4fa7G8lAp5pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBTbULwIzRy/LWh98z9dciuMHnpTcm3DhZN2zdd8jT8=;
 b=HCXYzRUFSJmvOCGpGLbgd/7WlNkFKF+UjgC9mCTUZZ2THyiZhq9ba2cmVTRbG3mAX5/Mkwtw84GFeXom/tEPCgJ1W1fIJ0rA10062a+l0CqoyQZ70YZV7qAezooNWzznle0Jchv8ww8KNJ50Ao75DmMHYOHdGtcF/bWKMSYSD6s=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 16:45:12 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 16:45:12 +0000
Date: Wed, 26 Feb 2025 16:45:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
        jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
        avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
        adobriyan@gmail.com, johannes@sipsolutions.net,
        pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
        anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Message-ID: <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226162604.GA17833@redhat.com>
X-ClientProxiedBy: LO4P265CA0299.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::17) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM6PR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d996182-954f-4407-4ae5-08dd5684f03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fESCXditeUYufMSEYBWmhw5avztBHi9U3XLDmA0+DmIY8qDdagjj1GLE7c88?=
 =?us-ascii?Q?jEIskRG/T7GW8pK3n10yFupXyYs92QSU2+FuT0RAaVrsNRW8/M/P6qyNoAl8?=
 =?us-ascii?Q?pSqCgxIAZCnPBf+v07C+hKjyE7TkBlZDgbMHzUcejLtSpAoSrFXvzDF4k04n?=
 =?us-ascii?Q?0nLEeQMMoULJCD6pSonSOPwtdbCQXOq/d8X/Yrx4FPq+80IV4DUSj9ojSWQQ?=
 =?us-ascii?Q?3NvwDddRATXrgWBQnHL/xXUD8kBX1WSNlMmQB0mkw9jbEbFQ1g18GgNlv1Cn?=
 =?us-ascii?Q?AzdjqWGrV0lM0E285NMjgomIIH9J9B1rl8hxlBC+WFNER746mwbECTZeLRGZ?=
 =?us-ascii?Q?C9BEVwjM3EIZzlQ5qOKDSvewf4YaPtU+FY0jbFCTq2ThKa+sNPap2dYLdjJn?=
 =?us-ascii?Q?jNKdpqcukhaXmNVBBpe7rn7JizdQYE2bVa9fCk6P73pvoklleORSS8Kr2btX?=
 =?us-ascii?Q?7123W+maLKx+9k6hcywd5q1mdo16JznYpPyzV+pgyJhmqKCbLHfYXLUlFDzN?=
 =?us-ascii?Q?m1SE3EinrCexnRwkCX2O4ZG0Uy/AAW8ObMOk2t+7XBOTc0gcC8cPg3DIdXZc?=
 =?us-ascii?Q?gxZGXEqhQuP16wv2BQ1vRAvMt3/9IKm/GmN5I2+sAGKE4/yK2A8qsoZ4t9a7?=
 =?us-ascii?Q?UraWDoZVq5gNtrTXLGceXAryalk3Zi31qey4xrPFWEjec+bSgcG6zHuJgPXL?=
 =?us-ascii?Q?D3lE68ZmT0wsweyDPs6cXwSiS63QtviwFWXpCa12zx2BKa0EXeOxlHWYTAJN?=
 =?us-ascii?Q?cKWvt34y/7Zwr2b8M/qeY+WNIQFGeiP0+E5Y85HVf3wO1py5wxhG6A3tkVxT?=
 =?us-ascii?Q?HQZU+CN5yFzDo1IjT6L9QariaONgl/ygD5NXiVkgKf9XDMkqMwdl0ss5mB3/?=
 =?us-ascii?Q?cc/f8DLAu3Z/etyg33CxykvKvULiDC5KR0e78ZnaL+2Tb0rTwgka11xfg1yk?=
 =?us-ascii?Q?i/5Y7clE2gwTYnvN2rboHkxB/K95QxabcGbRqBGxmccoJfo3vEVwfGbnb/CW?=
 =?us-ascii?Q?SCY1BwRv2hxZiIVfP03mwA59r0XOulLNoP0dBZeodGZQARlvc+7ghxpkrgd6?=
 =?us-ascii?Q?CGSLP2rqrxqREaEHBfJ0JBy4IYYejXfYnasgUiyzM3XxY5G1uBQX5piXDiMX?=
 =?us-ascii?Q?G+TC/wpuUa+apPeMmTbuVVEzjoQm7/kj4IIt/5yxo441cxB1KKAxPSRDhjDU?=
 =?us-ascii?Q?JXmPbuH2hyIikUeBcDOfq0GBmddsbVXlOi8JFPggZBvVRqD2bIPcPkOc4isc?=
 =?us-ascii?Q?ArjmpSXeFpos2WXmwMfK6jwUn/T5pM1kCnKUHOV3Hj8bK+hV4251YAVMPTX+?=
 =?us-ascii?Q?/rYqLP192AtSwqSS0Zp39W3SJ2dTYyke7OkiuwT8Q8jUzfA6/+HLimX5MaIg?=
 =?us-ascii?Q?MtzkebIm8wY81D+SkbkDyf0VEe6L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?apZZzvHQuO3JKm/ePoU9n550YZo+am9bxCtTYvZqE5hkAmXQVFCYYheeVn5B?=
 =?us-ascii?Q?57l1QDv/8Tb1vxvXEd+jOFXYrdBL5Nfv4v830cmx8hynQNa9VcYTIYm8hQIO?=
 =?us-ascii?Q?BNPXFHtF0r1TfOUN/Zk1+ipm0cOS00pFHucIrTvOLMFHW4mdAhHYP/g0zdYv?=
 =?us-ascii?Q?FeZhMdW8N065ujC4gH67q4qf47bKyrC2qRMm2sVVekKfXyLgUiMxgefgh2N7?=
 =?us-ascii?Q?BIbhtdYkjrjBQkSUPlawpuWulF6goOQJeejK+6e0n6d3OGDOF5Nepw8Mu4MZ?=
 =?us-ascii?Q?TYPabnnboI3lSq5sbec0KG5P6yDw4V6amLB9otLT7/k2x7SJ+kAsC5lxkltx?=
 =?us-ascii?Q?AbHX0r/8hd9OvlfZ/PJIUEVlvBnKsNkedSLMe1XshKim/NRR8HLNgwwLZNcL?=
 =?us-ascii?Q?2WMAnVyqa2DrJW/3ks2UdACoI1iNBlPrCH7yQ0RQa9fYHm7OnKQhW8RHCbEw?=
 =?us-ascii?Q?RtJbPkdltrUKiVPg2AIje7zymutnwjlwEX8HvWjKb/2UhIOhZ+ugqgoZmVpe?=
 =?us-ascii?Q?llT+8LGILJPXZFx+XDFCXFN0HnKOJXFJpV1odV4scDRGzAT25Q3oV6Yh1ZoG?=
 =?us-ascii?Q?RimCYYEB5xwXAmB1Hm22r7Uze4yF6g3pqTTytp8X13mbQ2vd3DbRBmokYMus?=
 =?us-ascii?Q?CtEpcQKDzmiay12TV3gdNei4ziJ1fUKbZFg/d43UlNRjAK18OjEoxsefGF1/?=
 =?us-ascii?Q?9s8790vRiqAFdJKNlb4iKRljxmYS6lokrKx4hj1BcWG+Q/3I8OFuhYpJCFQq?=
 =?us-ascii?Q?o8JrCNRdI/+eQTzGXZk9JOww8/jfmtGwxtnjf1sGk4r18N3Ni/iYK6R0r3Xe?=
 =?us-ascii?Q?KEqGbY+NhykokvUX3utVSX6HKr74CEgj7P+f89yeS36vPo9DmLWPsbfYqXGe?=
 =?us-ascii?Q?q4XNgVsSfRNT+JAqZPElzubCx84GiRxV98Jx12YVD3J6IUA8NosBl6eA5bXo?=
 =?us-ascii?Q?akUTpWijoATAYG8BjKUoLfKi0IReiNLW3t4an5EXlF3E++U7bvpZbVxlvzWh?=
 =?us-ascii?Q?A/4DUfC93n24LJag17cGTe2linb2HGjcRYgGfYorHDSbtLi7glP/0DwTyWsJ?=
 =?us-ascii?Q?9twyUace+ulraIWw0NyDLIwWb1jK1+qrejcEmpxy0wete4h98TV6prgFbe97?=
 =?us-ascii?Q?OJL212WhSq22c0e3bcyW6umjThd3juS6Nbf2PVFqlAqv/EtRcXBUDkR2mcUZ?=
 =?us-ascii?Q?lzNoROdqhwETLVhE+KCGBeAXiL6nXX0NjB+onb5EYvRLBmioE9hflfLKsZYN?=
 =?us-ascii?Q?/8hiwcW1Ux57rhern0L3fvQxI8RYFbNAyzcp53kBK/Rmb4qOACGZ+qhda9F/?=
 =?us-ascii?Q?/JqRpvRHMPjmwOvrAutRwdQ6AR0uEh3jpJrgxGYfryYmQ37avw73RA7KS6gs?=
 =?us-ascii?Q?vg8C+n8q/0DyVm1k5QLVXWuuZadbfD+ijOzQJ7EM9PhGIN+X/jNidiFn5PFS?=
 =?us-ascii?Q?udpFGXdv4So7wTSuEpfScUKGNoYB1eJGaAMSmzl1hBZgfeCwD8vj7jW2fAWD?=
 =?us-ascii?Q?tOtFb8vt5Uybana3NNJ0p9Y+BqybZGRPv+X/y++zevxVVvhTrEkvUqlyBGf9?=
 =?us-ascii?Q?EdAMf/4cNiPd7kK1NtmvSFJ23cPEII9c7Bj7OjSKjFxUIWj7xVYwBkmH75+Y?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lc+oXQqqM4fngtVU3QRvdSM7+Ibk4oqsZT7QURXvrW0VImNsESYfZxqY7jWGqcjCNsIgrCrm3ZYh9ni25Le4QW0SKj4e17HgE7tpFgregexZLAQwHZx3oDx2ohA094Nt6QMWyvyC0SWZjGTL+rCJceCLYeUoF5WQlJPelHxP8dBXM+cpDOgc1Q3ry9idIaXufx39yZuF3vQ5G9N3JAEyB6GU3fUP76r1PvdHfD3OuOIVfSpIC2AKr6BAXTAO7Xv28DbwnYxq45/DmFxqayhVVTzOBzL4qAqtKfj+VEHM3Ck6hny1nzb1lu6oLK9S8wl3/WztEECKCtE8RASEa3F59aiwxgr3iYE2pf1hLKNSCNj4neNEkS70NkavBNUr8FSQHYaUQkBI3ZWWPoF+t/czFCXBY6AUTFjHBlb7bhsyDz5KbHO5d41E+BK8sMJDJtNrBBofXqi15n0fDpiAP50cSbzgPHhOe3698bn6cfj9+5jXpalMaNwfuU1cFssctIj2FLtWs3Yqw5bQ24P4Fnz1Hc/3j2X/5t923rNdujuZ4aEcgIc02O1RTP3XAksBRk54g3TfKIk1CHVz6z0YDikyAwlZsQnZtUgQzN/C5uqdHKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d996182-954f-4407-4ae5-08dd5684f03a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:45:12.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ULdhl67XUAtH/AXvMdEpd6Zm9Miq3Klrk7JNTpSQdJooPZfb3JcrD7D1oYmE5sYG8qfpMdJEOfcfaO4vByVDCAIB3hrVNWx19NAkKdZffc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260132
X-Proofpoint-ORIG-GUID: 0p-m6m6FN4YkI8czgpGsY4GpAW495s7O
X-Proofpoint-GUID: 0p-m6m6FN4YkI8czgpGsY4GpAW495s7O

On Wed, Feb 26, 2025 at 05:26:04PM +0100, Oleg Nesterov wrote:
> On 02/24, jeffxu@chromium.org wrote:
> >
> > Unlike other system mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime. It could be sealed from creation.
>
> Agreed, VM_SEALED should be always for the "[uprobes]" vma, regardless
> of config options.

If you think this ought to be the case generally, then perhaps we should
drop this patch from the commit and just do this separately as a
permanent-on thing, if you are sure this is fine + want it?

An aside - we _definitely_ cannot allow this -system mapping stuff- to be
enabled without a config option, this is emphatic, for the reason that it
breaks userspace and is only known-good on some arches.

A config flag that checks arch gives a big warning saying 'hey this breaks
userspace' means users use it knowing this to be the case.
>
>
> ACK,
>
> but can't we do
>
> 	#ifdef CONFIG_64BIT
> 	/* VM is sealed, in vm_flags */
> 	#define VM_SEALED	_BITUL(63)
> +	#else
> +	#define VM_SEALED	0
> 	#endif

This has been raised a few times. Jeff objects to this (for reasons I don't
agree with, honestly) but it's been implemented in this way from the start
(in order to catch the case of 32-bit systems trying to use mseal but it
not happening).

Anyway I agree, but I'm not going to push this at least in this series.

>
> and then simply
>
> 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED,
>
> ?

Nah you'd have to do:


> 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO
#ifdef CONFIG_64BIT
				VM_SEALED
#endif
				,

Or something similar :)

Beautiful no?

>
> But I am fine either way, feel free to ignore.
>
> Oleg.
>

Ideally We should hear what the security use case is here. I mean I'm less
bothered with it behind a flag, but it seems odd that an attacker would
break out of a sandbox into a process currently being debugged... seems
unlikely.

I'm not sure under what other circumstances this would be a problem. Jeff,
Kees?

Anyway as I said before, I don't overly object to this as-is, as long as
you are ok with it Oleg and can absolutely confirm this will never break
anything, you don't need to remap, unmap (until process teardown), adjust
the VMA in any way etc.?

A quick glance at uprobe code suggests it's fine.
