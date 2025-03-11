Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF01D88A4;
	Tue, 11 Mar 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702203; cv=fail; b=mQGr2mJUy/2OHjYSxWA8t47kf/wrLc6XzQepvEmm6XQbQVd8yTg6VPi7vdTeFzTSTLKv1LsC3jA3D5xy3a7nP7YLNuORlE7hglKEIMu6ue/ehls53EIQ8FYgOV98rELCQF877LWnnTIBTTDvhGCJHr6tSgGYVONCoMHBmMLA9uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702203; c=relaxed/simple;
	bh=LLJKXDrcdZaLW3Z7iNFzQsVmEvR5Iw5DBLQW7AlBke0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=thveWxxX7A3o68kZ5dcpklyRuW93lIcL4Hqh7+xtcUJzVUl0pQQeCv5R47uygDYrotvNheHhdc0vL2HGbXuR2HSFI0AAYXsu4llPj5/FY+1FFl/anZ15jLTziPOr5sH/YgqcQTx1nB/31n83qG6rXJ5tKN2xOQAyUxRHSgluVFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I1gupE/V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mat5yslL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1gupE/V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mat5yslL"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMwFb006227;
	Tue, 11 Mar 2025 14:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=LLJKXDrcdZaLW3Z7iN
	FzQsVmEvR5Iw5DBLQW7AlBke0=; b=I1gupE/VpbTCcBAQhylB7Jfxj8+30DhqYk
	NpwGNjAUbyM5VkU6nzXpdHmGS3oBvLOAEmz81a2oLcmYFXUOENpcALWRnoQqvTTQ
	fCgu5LMCtWcCCWx4L5GF+WkNExTGjCrUB9ve2GOBbMw2l0MOvDGkHDgY2VbvfU8d
	T1KR83P+va5bpXG+ZpyvdMtrbbJqHyEv/82LRAUVR3l+A30BlPGCyhQZVHzv1EaX
	On4Rm1WFp+Ta9157bf/xWBVgvxSRW8976EtlqqD7gEtqayMYLRZ6AQKM0Mk3Lze7
	EGO2ydZoMYigEdV24kWIove7lekjkLJDulzLY8EYsC7TrKsPa+yQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9mv6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:09:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDooLM026394;
	Tue, 11 Mar 2025 14:09:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb92dmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bi6Z3rEgBO9eigdPoPU1G5YVjlWm6EDP1Ra2PjmS80mGdWuprbfnGaZccqMqgnODpD/A7l7UbQZBosrpI4ATmiqw2ETIrxdmrW0uFtO1wfAShVq+B11y/hC5z8KqkbEPvKRc9XESiNB0LC/FfwDjWHahOWuXv4fHNeyxRMvllaoUGDPg9v4yejFLC/L8YdyWUMr4II1C779GSSC/ca6xzpty/+wye3b3jBRlh08iAtEY5OgUNY9IOGG7UJfk9vnemcNI2JOhJR1X3gPB/Dq9VcleUmHikw7sOwLG3IQzFOR1LtClZ69LpR1bDi+Z57OxjxSy0YeYkphhUp/vAgtx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLJKXDrcdZaLW3Z7iNFzQsVmEvR5Iw5DBLQW7AlBke0=;
 b=juKiBIa76Pio7sI7hI6ph79DAYNkkqHeh93wQ4cc6bogc+DGV5+COM2gHvCKe6eng6kQNAOVHqc2EIR6hw+zKascviLJdLsvdrpDvMb9u8x5hGIzXfsKDzo2qB0d6dhXBvYURvLALbuqlxxNgE3KGPK0UxYbUCZeEHil5jgpqaRU49wlK4uOywygO03QuEBAa4Yy8t4aC7eNCxvCpbxPotpL5k5ldGYRvrPjLBH8CL9I48VxKaVXAYLDWWiotYHNg5tjvHr5H6YOs1THiGAuX2qaF3i+0Lm2vh5ke+d2y+/Wax3Tzes/gaL6tUVQXacPLduSnCEcJhY7W8ayjd+yVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLJKXDrcdZaLW3Z7iNFzQsVmEvR5Iw5DBLQW7AlBke0=;
 b=mat5yslLIj4nKxijuQEOFBll3lXhCseg3A5VVLcKuIU+RrLvD76SrIImlzOCJI8iuY4fe3JWqUwyaiTsB4IEOeyj6iAl6h1q0rlE4AOewhnE71Bxrd4/52gsOm2RtygYDv30IEwe8CuXRv6B3Pp/BomCyEc92fvWE9Hp4n+S76g=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS4PPF92DC283F3.namprd10.prod.outlook.com (2603:10b6:f:fc00::d32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:09:33 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 14:09:33 +0000
Date: Tue, 11 Mar 2025 14:09:30 +0000
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
Message-ID: <6f106b28-7d5e-468f-8a94-e94357a950ee@lucifer.local>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <a326735d-ca3e-4aee-9f98-4e742dfc15f5@lucifer.local>
 <20250311133736.12846D42-hca@linux.ibm.com>
 <b8cf08ef-0125-466f-89d2-d499cbdcd3aa@lucifer.local>
 <20250311140630.12846Eef-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311140630.12846Eef-hca@linux.ibm.com>
X-ClientProxiedBy: LO4P302CA0025.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS4PPF92DC283F3:EE_
X-MS-Office365-Filtering-Correlation-Id: d4851ff0-ca76-4584-53f4-08dd60a6591a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qWk6pFP2nL5U7q80p4wKco1KVOuBzWmepi5pd3dhzYSUK+01Cy4QhzIeeBVU?=
 =?us-ascii?Q?V9OvkWGo6YkfyEO0FQqFNqjfNkpEBtnL93wJQgjXJGOmJkUwdixjqqeDjqHw?=
 =?us-ascii?Q?1iYApKzSR4NChxKM8GxVnXK6aMuCITsjFb2legtPcNpQzn1oEUIhL6DWXQCn?=
 =?us-ascii?Q?mt2AmmBJVRjQ3zHWCkEtztFLvMIxQmod8DrrmdhEExGrvSj/XuDLUcjMf/6s?=
 =?us-ascii?Q?q4KQ03fesUvL6QHlV590QOZc9sxUmFqJYVIdy7ZJWHasigP/pR1ZePSnqvh6?=
 =?us-ascii?Q?RPrvQRnqWjqul07By5C8MUmWgdgVG/ji4pSS6W29Dj8RbgqYYix9I+bgYY67?=
 =?us-ascii?Q?YEDPQhcS5hSAkLK6gA3mmC9BWZ1qg3NKOJ99rowV9R4ASJzAQQJp92Jt8S7Y?=
 =?us-ascii?Q?wlYR9HR91yk9X1/dbD1O5AWO23THCEL1PiEnCYLPZLUYDKVhfDLyglMKM8T6?=
 =?us-ascii?Q?EEMss+j1whYzfsA1BWoZg2BUlBIoHue9IsXrvoB/Zf+84eq/lhYaCir181Cc?=
 =?us-ascii?Q?4coDeijYv9mQ52cXmPI+RVapQlfzIA8qWHDVjjj7dIPBpEsTg9YEw5GV6ED0?=
 =?us-ascii?Q?vqtrQAy94oIysB7A3EN/00Y4s9DM35KF2dYEFHm0TxBI74LvxdRxLFsstP9B?=
 =?us-ascii?Q?eDwApmte0XdwdDHNrantFCdg8IE9rwxkNTbYoK0fbQ/yUcl1VaxyxnwKz6QC?=
 =?us-ascii?Q?G5XCK6gaIXIs/V85cPbA0FIhxMGwd27/pCKEdxwu22IamM7LiCVRYx4t6oa/?=
 =?us-ascii?Q?s8v3WLCpunR/TAgCdSG5LMCXAFjx5goCCNdnQnEZTpsudPo2RZx7fHKD6I0p?=
 =?us-ascii?Q?pnQ7MzCS/Pb78adVkzPmVnlJUlbVjLMQ0yAwvge4tBlSC+bkzMaaQsCJs8cm?=
 =?us-ascii?Q?Qff3K4NOQ4cE2Z+WcxPbHJAq/UqX+62hb8jsjlom3XfjkfpUr02j++U9mPUr?=
 =?us-ascii?Q?lLAu4EDPf4W4jsQBpPQu6D1jtZc6qsc2jVBq2lFy1afSTmpDHY9X/qgEUaAh?=
 =?us-ascii?Q?CaxhO5B3KQB2lkB6BJOe6MrgGfh9oQSd7BwKOxQazzhXN5QY8ehTfTcxkAsV?=
 =?us-ascii?Q?tE5skn8Z8ODQO2aTr556Tsk8NbRQF+9gWWM2i/uFCzfR9quItG5p9dTuSroW?=
 =?us-ascii?Q?7BkqdblWtJhi02KzLx6YiBTVyU1XCP7C2joAlo5NNpHY6rVvs0XeJh+RWsu0?=
 =?us-ascii?Q?dICD8GRThpCrbsgcBW5mTz7FxL7LzByTcbDiSpKM7c2rJCT0TU4tIOcJwPPC?=
 =?us-ascii?Q?Q5z62k1LXQVDn/K5JWzUS/GvwfPFM6C+RRG9iD4QBjOPpGI2VLIiqIXsOrrI?=
 =?us-ascii?Q?wHBUPz3LUI+gOHunvW+T+ijzQarvy44w7B52MpP9/G/kZCaaxtNCWxb4c8WD?=
 =?us-ascii?Q?ZzoahngE9/yJKQLNNnxm0QKwcVoF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uqEoED9+jDVYqe125klyv9EU/knPjvl9DmZu4caUR04gkmpPJ9H17eKaTmf5?=
 =?us-ascii?Q?DWHhOFGZvGLKGo2PiU/GzwCM2zSOSpr7XXHJzf9L6GsxcDcsokQjDkO0E+gk?=
 =?us-ascii?Q?3x7EFVkZt3XSx7/iz9sfeLmPWWpVJ7/zpYLqbRwkOjEoNqftzc9Uv8YHdq+i?=
 =?us-ascii?Q?EXd2skwlv0FcpIxoz6CIPaqvZh944BNqj3qwfRBCuDUaFNX/Oy/lBam+CBJ5?=
 =?us-ascii?Q?fTHATCElJx+MEuDINVMerP/8OWvkUx/wINbXtN/KWF7gfmvetw56S9DMnnNW?=
 =?us-ascii?Q?/sOyDd0Pk2va9osAh3wt6dn916ZgR5GXgx+pylDYLnUJS+M/Owfb1fNh9IgF?=
 =?us-ascii?Q?TKgXFRHGCKMB0+NJuAwce6HZhHpddIGfDoKSU7PaT9Z6e1WfZ6Rwxq0OPgCf?=
 =?us-ascii?Q?nX0fvmxJJN6ccU3b0qknScODOzgfBJzDIssPRonLP/YZiHCYF+u6vey/za1O?=
 =?us-ascii?Q?zEfl0mhwm3bXiCGWOoBrWl1LdW8xE4f8DFPrkWRvEvi3HM9Y/s+NC4+AtyOR?=
 =?us-ascii?Q?xAkX3zQ6RF48SwTcocfwcw2nk5PqtTnR1ZDH1WhG/lIU5ak8mG4R3t8RxuRn?=
 =?us-ascii?Q?nY8Sow+sk3dhkwg/jwLSdSkLC2iHwulsMFajkUHeCccELZeYnL4hhgHwZdpC?=
 =?us-ascii?Q?rn8ZAmrka+re5ycs5NHa+gysD/1kPsea/K/ZVQ+Kexv4SCbopHHevb1i55no?=
 =?us-ascii?Q?P94tqLQPJEqDY0wLfZzyF5tz8UdChyZwKaqevhpkKonMuPKhTco6z5xpklPE?=
 =?us-ascii?Q?jTfBaSDdhYIdQFd3UeNEbGhXhfkBTqGTqvDw3woTrjIB2Gk2qoy6FUZ27Nji?=
 =?us-ascii?Q?q7veV8pUh9RHvXCu39pc1I2txS5JlHxWZl6cwLyyBzPBm5k+Ohc+dr86CbzC?=
 =?us-ascii?Q?UPpCPVfqCNtJlgiFoA1A3yqcFk24QOe9SYXMuQiw9mH4Lji4LEFe/50cRv44?=
 =?us-ascii?Q?6piFrTuSDO7rv2rU3BXgW40yvy27/iZWVAayr7og9yhuTNxifjmQx+Zi0JJB?=
 =?us-ascii?Q?JUq/DKYA1TyK4hcVa6Ho8FbrQNnFXVgL9mKXj6oQudPp81d7rob9Aagwq4Dh?=
 =?us-ascii?Q?e6KFACxm0CEImiY8Ykc6AeU1sBPtAX1I2lGM/b3/VOhNuqAXymdMiNZzddgc?=
 =?us-ascii?Q?puq6YlMbMP6rFOIVT8eBGuk22WJr+dUQVzIEdGq0yMgnZOLrvVOHz5OWjVnr?=
 =?us-ascii?Q?t8AkUkvXGa42iszF0EVvguPrE251YmKLvpWCIQCZFDpOxvJ/nHqE+l0xgDh7?=
 =?us-ascii?Q?7Ni/PbZFdblGedXPkA55oFtQZ6PELAx56rFlY2T+Q+W1tpAOO+CRTpsjM4Ve?=
 =?us-ascii?Q?r3Pahwz77fWGAw8/5d79Zfs11wKj5ZRn3DF8f1KV0fTwU9D5fWx1oPH5BY/s?=
 =?us-ascii?Q?aZZpn3dE2pUiy+0ePuAlypljUKeY9g1O/E9VbR6mtbSnU2AmrVCqzaMJ9lmA?=
 =?us-ascii?Q?tjOALLWSNN4Gvr90mp5qTkXQvub5+qnvcp9dEUrxUdY15+ESA/GPa6MSUKXa?=
 =?us-ascii?Q?+UkmN9254xsEm+HxBqBP7h/VxFmvEuyA/qe7/48XWVbthfBI4JQq2RtcLagk?=
 =?us-ascii?Q?vE7mugYZ4Hg8fZJadrvKo8kuOZZygAGSHNn61ybwHarasrWjWabdzZ+a0A9/?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bkGVuh2gU/sLaqJZYjQpMkG312eeE0cd6mxmU37mvws/u56rvt8ftlcRPo9107dQIIM2fhzUhXLMx3WR6j1Mc2S0jRCpGIsF+46P0AMYpJ0LrPXvm2Yk7wdJ+Z19HaPfVXzlln3HiM/Kh47lU+6XfEWsthWdxTHbHUUPr0VBAX8OJPJJQ/fa9L/mJQX0s5r8fBe8f7iAmFctMeIDmI3Y+40FrZshtRz0Fy2qnhI350AvGyNV7TYMgTIR1Hr1gvsUCqPdNTekGGZazcUAXRCninVbr+PClhctcfyoj0tJmoncQQhtTa87uoCsfBKoWN6frYDk5z8HUMYtrMZUrJFRrcEblsw9ActxaeGhI5xT0OrdPwb/19TcPdoCT6Ga9GdQQbcf9IYBecM+TVOolqlNp8L/MQ6Vt/IsnwDBM1Yg9YoAJiCB/k3jGlqebwGJcwJkdHW6zywQrTPR8DDqR8VuuO1Jd1u1EKsHR+U1t5znGoh8YxZfL7u4wnHBbdOAmYxBuSDgOyHYhKRsUhzOaiJGpOAlt6Mgo0UZNB3CunJ3rD0rE+TNvO6vkNsHDWHQduM7IDND3BCM/PZ3tBa3+CDN5u+tW7erXEa6kNfybyJgWaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4851ff0-ca76-4584-53f4-08dd60a6591a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:09:33.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD/yZeZAiyzugxv97eZA+7BhkQdVakprbxK3unr6zxvpEe7KUiVjwlH82ZbsJUqK4Mllzzdcc/Y/54AxZhZLvC0pmASqFub5U2XDzOiOr38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF92DC283F3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110090
X-Proofpoint-GUID: WLwKwAVAkSZBN2AVPYkLoq5s1d-pFdUx
X-Proofpoint-ORIG-GUID: WLwKwAVAkSZBN2AVPYkLoq5s1d-pFdUx

On Tue, Mar 11, 2025 at 03:06:30PM +0100, Heiko Carstens wrote:
> On Tue, Mar 11, 2025 at 01:42:01PM +0000, Lorenzo Stoakes wrote:
> > > Just like for arm64, and x86_64 the s390 part is just adding the new
> > > vm flag to the _install_mappings() call in vdso code. Otherwise there
> > > is nothing to be considered.
> >
> > No, they are not just adding a flag, they are enabling the sealing of
> > system mappings, if a user chooses to make use of it, which already breaks
> > a number of useland applications that rely on remapping these.
> >
> > if the architecture code ever needs to unmap/remap these, then this breaks
> > your architecture.
> >
> > I think it would be sensible to clearly indicate that enabling this feature
> > does not break the s390 architecture and you've confirmed that by checking
> > the code and ensuring that nowhere does it rely upon doing this.
> >
> > Likely that's the case, but I'd suggest you ought to make sure...
> >
> > x86-64 and arm64 were checked for this and confirmed to not ever need this.
> >
> > This is why we're restricting by architecture.
>
> Ok, I was assuming more that whoever enables that config option knows
> what he or she is doing. However as far as I know there is no s390
> user space which relies on remapping vdso mappings.

Yeah, we allow for the 'user knows what they're doing' stuff when it comes to
_userland_, but we obviously don't want to ship a known-broken kernel :)

>
> When it comes to unmapping vdso: this would break user space since
> commit df29a7440c4b ("s390/signal: switch to using vdso for sigreturn
> and syscall restart") - there haven't been any reports.

OK that seems to implicitly suggest that you're fine with sealing then?

I had a quick glance and it seemed fine for s390. I mean it's _weird_ to remap
any of this stuff so it'd be the odd one out that does it (ppc _seems_ to in
_some_ circumstances need it, for instance).

So I think we're good? :)
