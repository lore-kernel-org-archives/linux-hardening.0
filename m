Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B03207;
	Tue, 25 Feb 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464198; cv=fail; b=ugNCVPyuMDj5PSdy5fmn9Z9VbAqy3B48OBVjiU2/krxsyEGUjHPIjkwV9m9YwBo7vt0D7cdFls2yK0s6IJPS6098wwnr6/NRbGr/CvYuz1KeD7wd7YpQQt3NpOqr529chmX9uUsrJWvFplNoVNYmM3A5S56fS3hqFJZDdKxCJfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464198; c=relaxed/simple;
	bh=Mz/lPSIlrbX0w0Dvef3zAgHTWuIvAzlHSErt9RYpG2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vvq5o1pJZ5hSkfIgqEH9J3gkIB5vb/VYTrCU0+hDCi1ReWOWGjc7wkICEOYsbu+LLaVEa1m0LCYnYtnbeVzYjRBQNc6BAUw1iDJzWQRXLyalQLqo/m14niVLGqcV99pMdsu9lbG0w+cCG+IggRrseNtcxYyFPq3Zhd+Gpl6ok3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i9fCS9Ug; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cwt62wpr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9fCS9Ug";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cwt62wpr"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BeON002687;
	Tue, 25 Feb 2025 06:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=x6/RSJd5BKw0xW6mQj
	GeNxLjXXBIOw+CwzJhcx0wa2M=; b=i9fCS9UgSim/ki4IGkmgkGQTBECFs3PI/4
	/FbqmfTfa5f08V3s+rr+x2tgXK1BVQ9IXq2Yp/U6YOSChY7b1upecz6T1evT2Y9B
	VPhInDYEMSAa/4v6uJ1cKq42HsRqQqGv8sOKIJyw0U29TEKWEGJAiSd+z9WHf6TP
	5mBeorXHIR1CgxejtCvTCYrxOI/Sp6ESEB/JiJtUbgAqAEqwM/lFEdz7O5XSlone
	2Iembt0EarEzXiVRMcgEUUlcQA5jMbDKAIo3H0VoC1NcnEap12o1Y1zxpCEY/heq
	nmHuIatdU7NfCWdr6OqT3V/cp+afcAG+2ws1uNdmMk7j1IHkfNKA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9c77g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:15:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P5mq3a025516;
	Tue, 25 Feb 2025 06:15:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51f8f4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:15:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdxiKCeeGVRN0nHG2NxggydnrGDVCE4i2VaBTQZj06T2s2jfmFp8ZkgPbZWHIMUgtU4FR8cMCG+0tagZqy4zXqOBp4iEnTmGIVBV9iFZyaY3efltsX3EO9yFeK0hhUIQlVa0cLjqBR+mgNk6Fk4EScvzs7XC6B0NdWKqslqndUwtfNaYo6t5IyIhQgdr0kHEGWEU/7jskmlCdziRPKjErAhx72c5W83rVK9tElUS83Q8QW2LQuPkqBvyx4fl0/qc4ec0ok+MRET0tMWPsw1YGP1VxkqDNt/tXWXw8m43ah0QRzESRKg/seTnA0gl2klRbqfzxA5VxHQu7M4IZByYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6/RSJd5BKw0xW6mQjGeNxLjXXBIOw+CwzJhcx0wa2M=;
 b=i+cMSrrVc66VRby+UK25ppBwJX8SyaUa4mBdP4ZOI8GvVIHsCS1qlnJQBgzRiVffmavDwR18GU+F/YM7UiV7YlQbYDM20ne0FyqSiImD43apy/NgZ00V2A6uCj00RKQK5dtxSy+A7WHuWTG0GDTJrTz5jj3whzUR9VZ/LHjQO9yGfVf1y4RBVoJ9ENKkjMQTZG9vTKVo/Ecz6Jf5bYQwnAkb9Wj0Ouqz+2DBXBYtGmjO6dVVlmenqZNlJ/xeW8dzKaKmEAGL0I+bsMZS4/r+bB8YdefkiNH70ZffBZTGGqs1L+r4ZHquIZU+o8CretYJH9M1yMFiXTuRGNW40ONAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6/RSJd5BKw0xW6mQjGeNxLjXXBIOw+CwzJhcx0wa2M=;
 b=cwt62wprA7wjxmwwR/YxPTCNVkmYFcCMhDQ/wDlM8/sfbNBEMCX7NM2kSWa3qxcGBfKo1NeUzHCxmHINi2YHCks2aQKLQYWkuQ0TIBUvUY4COVT+3G4ArYnGO9ta4eoGDNKywQkQ1TK9CrGgL55OrX+4KG5/7lwObRx8s8KXUNo=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MW6PR10MB7686.namprd10.prod.outlook.com (2603:10b6:303:24a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:15:44 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:15:42 +0000
Date: Tue, 25 Feb 2025 06:15:40 +0000
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
        mike.rapoport@gmail.com, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v7 2/7] selftests: x86: test_mremap_vdso: skip if vdso is
 msealed
Message-ID: <f300404f-91a9-40ae-8fcc-2e855b43ac76@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-3-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-3-jeffxu@google.com>
X-ClientProxiedBy: LO4P265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::17) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MW6PR10MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d946deb-7d08-43f6-7166-08dd5563d520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tgpf38h1VSnTV2uLgUvRPht8dW99BKV0EwWCVCtJ/PCAcCoM0L17cjxAvucL?=
 =?us-ascii?Q?y8n/8qeeHTD5OZXrbxcF2ILhEDEDA7+3XIU9Gn0HbgJ2M0tKBNYSWm45tjBg?=
 =?us-ascii?Q?VEg4vQpu9LKgAgdfJFlm3jfoCl5t9tuAL3qETjQOLnFu8wx4sbsL6Afa80rj?=
 =?us-ascii?Q?4WCqqXrGNLXfgebrER8OEKsP46QUSYrtOoW4XCGlmr8M+vej3TGnCigAa/1s?=
 =?us-ascii?Q?1r0Bxoc/StXvHC/k6YkVg11YPDLHq+5XiOYMselQpjpL71RUFyr6fzo1D0p4?=
 =?us-ascii?Q?IHXvUFGVsAV6Vxx6/SApascrBtDVV7TZY91URcY7ASBFT+A379YRiBIDMfrQ?=
 =?us-ascii?Q?vdhQC1/8ltqMRGuWOwtDpQAyKFyfc7CSn5CnL+538/cnMoyujyDjY/F/xvLZ?=
 =?us-ascii?Q?0ND/DqQpgzBGl2oBN2EjWTJ0AiuZer97REXMJc5Ino4Z3PWbBLyBRpkBAHdy?=
 =?us-ascii?Q?ffICUB6DnAF5CYpo4xmbwjshrQwtQECi7S3erPK7vpfX2s8lCH4iekS372Y7?=
 =?us-ascii?Q?9cU87hxfTUxzZH6D6bOK+TMmpFK+j196ogvbUByC5LUypMR7EDjm26vud8LK?=
 =?us-ascii?Q?jPZIrhrxPFGus6UbBpcKPkptWiHpavuGy1jKHw7it41QG9zSywqlXDAO2OX/?=
 =?us-ascii?Q?Pw9b6W6GwLbErbTkc0rXvr8u6gBtA8ewgzINkODVv/W1g81Fh1a267Vf1of3?=
 =?us-ascii?Q?TWOQxc0pSsenz4WW3qOyRTA2ZLyV8msva6jAQywFDvDN14Wfr2heqn8uivUx?=
 =?us-ascii?Q?+LUVNv/n0G8m25gDwvvttAdvTsb2o2g6Me15xx8rc4sx+1KLfUupr1Mz04Oo?=
 =?us-ascii?Q?FyfBYyKmTzzO3WVDtlHinqPWdX5vO5U9eoHHORq7p8F5/iRDwIQS26TezZ/C?=
 =?us-ascii?Q?ZVMUngbESiGupfvxZyPZ7om3q1DNGC9jW40cDOvabOReYf+eBiYoOBI4YwNw?=
 =?us-ascii?Q?JktOdSRI5AlU6SOo1k6bXjEI+W/G5pXb45vVT6nnuWHF3tJQQsdPWLNxI/YO?=
 =?us-ascii?Q?3F+J3oM6d6xsaV85Tq5hqcArkLX6fifDL6b+l/9Oe80i9jvpmAa1ejgRn8hE?=
 =?us-ascii?Q?l5xXnzZML+/G6aSM48rkvzatLAWKm4ccCBo4CYG/IZYYPcykjysyVMnmnQFD?=
 =?us-ascii?Q?jlwNmO4ZBgGiA8ty5J5NV7rAMhCi0Cu3b36KZSF2MtBDYFK/E4qrdDyQO6x7?=
 =?us-ascii?Q?FLxQE5xK8VQhi9NaupLdbcaYZURsF7zbZgwrKrIcF2A7APdedY9sc/V4ZrWZ?=
 =?us-ascii?Q?x32wzBLySJ17Ef/5XDYiVCH97mM05q0EfWDl1MSlih6Gp4x/z+V9Q5CmOuow?=
 =?us-ascii?Q?do34FtZpRtD/qurK1jQU9H+pfH3dfEtPmG7EUT5x9p0B7VRrQBjAxgiZl/XV?=
 =?us-ascii?Q?3dw5Zgw7K2uo9pFA9GpXAW14r0vO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzcXp49QSz71LNbbYAZtOFfvyYxdAj8XYyrNlhn1SH6hgT0zPPoSQjVGmT/E?=
 =?us-ascii?Q?mkEuDwwnuB6HibWtzOYklPA3dQ4Pa/zTtXbswZ//g0fu5Ej33ixavbI4OToY?=
 =?us-ascii?Q?sOlv4/9E/SAgqKPm+EZfk3r8k2Sm//AGuOIWfPxm7hhjAwIW1Umx3hpZFrAo?=
 =?us-ascii?Q?sVBj18vHPA8t21c5MQhbDltYd2iaBaZvezkkfX3tuAlkrwM6XN2QhY9tOcv/?=
 =?us-ascii?Q?a5bZnietZQcGeUMlf3egOv7zQlF3wI+r5pBxB8lOHySNf/YmgEpsbdoFI5e+?=
 =?us-ascii?Q?GIVewEJYs56scYTBMdrJqBbjOSNgOQp4sGlEeEa2wauH4XuK8fH8AKANp3lf?=
 =?us-ascii?Q?wt/kWQ7ROythSYyqKJq5+/9rQHOorlCrKA344v2giMxOqqY26Saw4dwrSnfS?=
 =?us-ascii?Q?pGg/oolfKBt0omEVs7tXvwHYv4nWERuq13Y0p4RtTR/FmmnyLxfvPTYx216C?=
 =?us-ascii?Q?zTAgnHffQWD7sjAmAqm/IKNT0dG2EBxl2LgLjJ9mJXOSu27ovsJ3ZjmYFU/H?=
 =?us-ascii?Q?7plo/B4fG+LbsI1c+ONtmQzhbEUsZ2mTmzOAK5rmHqXAHKGjYljTOK6cuib7?=
 =?us-ascii?Q?5gTQz1zKLC37HoIq2G+4IgXBXyyEzFRYvn1uABQbn513Q3zr0bye7cqDMlDU?=
 =?us-ascii?Q?5PaUVIeZP8mhRzFLZWlGhgJLCccC6bWnR2OhsnCSZtewUjehExLV2YQm8RlU?=
 =?us-ascii?Q?g9cMImaWizT79NczATYxskkWNcXYTpgQshkzZby5b/sl2ksif2A5RAHzpGrT?=
 =?us-ascii?Q?UCeF9X8JK9gz7Wd43Sop4NZIQOiSqIfdIkuhN1ce4vH4+QMNtkpDpDLV1RoK?=
 =?us-ascii?Q?jOx7345n7jHxHYO0wEwE/x/DJwVC0Tx7N/B4SzjhD9mnXOb9KgfD9R00VElS?=
 =?us-ascii?Q?K5s9aEHHjeI1k3rG5kvtgo+deFCwhbIE3vpnGuM1DlHc0ieyvgZeIaIEp7hX?=
 =?us-ascii?Q?5/0+E9vhpLcShu4xgaAYFbObXC/i0dMa0SB9cLYAruSSCa+zVqCFLRPM+da0?=
 =?us-ascii?Q?4UdL+gh8gfmTPZ71eK6iHILq9SNgGKQS2L2QdKQNbVwTVvPCU2zTKAP+3/LO?=
 =?us-ascii?Q?Sq5PDUHJmxab01eJjkUHeNQurOSX1NBzbWyjx9Aj0S4bRNX8uCnSZpOw56G0?=
 =?us-ascii?Q?Xd/uHBQ5ALUTZ1dPf47mEvzOYrhaPQVzxTzdmJT8robI/xO9704NR6fHhdNU?=
 =?us-ascii?Q?YLGcBOANsKKE78Q/2FFRZvEO6hgGDlNIkg6Qu4qIGkSBs1BUGnPxWYja927n?=
 =?us-ascii?Q?vmEmPP/t6ZyD1puEukkhUHBDOkeE5d8rZqcc68I463mXp0iCVoU6UhSSSEwo?=
 =?us-ascii?Q?wjxBFGYtlEbIyNlmErLyy8tFMWtm2A7T+tJigvBKlzgaO0xfCJkFB0WLL6kW?=
 =?us-ascii?Q?y9E2yRVbhaEVQBwLYJDOkjUkH2AnZN3sUfOfVw3zxdxv/DtVVPQZZmBtUQsp?=
 =?us-ascii?Q?AAV//faXH781kokMYeWrc++WUqzvjiRBHDkVCIT1lfEuZKuGdhlHykG2eOjF?=
 =?us-ascii?Q?8Mu1Lx6tJa6wA7htxxdigfVq4fq71ewcHt6Gf8heJFi/pcVxEAvkSzJ6N7fi?=
 =?us-ascii?Q?Y372RLLjeEMqgEHcej70Briqh5uokMzANqZZAL0PRYnCRSD9dVFrUDMyHNjo?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o4HtI4ZgdfyA9bscqlUJMyXUzg6wf54aOsakVP+9Meb+tB77E+Zg5jwQkLcn8Yyr16iSKN+gP40KAW9cKEi3P9UUrG3Q5BYCHV2Iwv48gDown09PsNen6OATf/igdGzF3O8LVKccs1ioTX2UiT7f9f6QLVwB15kYCDWKZhnBVkdqJSuLJZ8mQemOitJn8zSz4pBJz4lN+/4X3EIotlZvSjp86QAtkjppuIlPqAzdFcDtyP8RNwmguheRROuposXT4HlKSW5niWsc33QhHVl1Dgh+WBpf+BqvdxD0ZwsRVvFZIhrv4b9v04nTgTPmjOboVexTN4Ona7qxhmpfyirjgaDkdrtVxiN3yV/bTckfBwsl/GeDP753rVhTH/Z4bTGZdVgp6O6MEjO8nEu+5oeBst+D28CzoZBeEYGhoYF0sHwRPB1ZijOJ2cZEYSPzLze3td/DRjFSCWGIEkWW8D7G772+d0QuA8ySn6Oxz1Guj9aNODZoxWC2rQVe6eL/0YDQDbxPQyk/LtBIXG45LE7PRn8vn6Qjfa6RWTYjrWF3J2FVFmJ6qjLelIVHw/e3DrGPbbc/RF0S1JFR2dD1/4DauRb6RAPoZed88qz8nQXsg4w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d946deb-7d08-43f6-7166-08dd5563d520
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:15:42.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjQv4lhvFcx8iu+49e1mBlndpjTEjoqhG8JSW3QJD/kG3sHarkmmU1cjA/hWM4mmY/z0q69zmGdltgYraUCuzcfFLd63nqb2eVM1hrw/yKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250039
X-Proofpoint-GUID: BFz1dhSoDKFebKr-2OFWMdEj9UiwyTWh
X-Proofpoint-ORIG-GUID: BFz1dhSoDKFebKr-2OFWMdEj9UiwyTWh

On Mon, Feb 24, 2025 at 10:52:41PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Add code to detect if the vdso is memory sealed, skip the test
> if it is.

I feel this is a little succinct of a commit message, but I guess it gets to the
heart of what you're doing here.

Fundamentally I mean it makes sense, but I'm concerned that x86 has a test
-expliictly checking- whether mremap() of VDSO is possible - are there cases
where x86 might want to do this internal to the kernel?

I guess not since this is essentially a userland self test and probably
asserting you can do this in the way rr, etc. do.

>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reviewed-by: Kees Cook <kees@kernel.org>

Anyway, this aside, this looks fine, aside from nit below, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
> index d53959e03593..94bee6e0c813 100644
> --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> @@ -14,6 +14,7 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <string.h>
> +#include <stdbool.h>
>
>  #include <sys/mman.h>
>  #include <sys/auxv.h>
> @@ -55,13 +56,55 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
>
>  }
>
> +#define VDSO_NAME "[vdso]"
> +#define VMFLAGS "VmFlags:"
> +#define MSEAL_FLAGS "sl"
> +#define MAX_LINE_LEN 512
> +
> +bool vdso_sealed(FILE *maps)

Should be static?

> +{
> +	char line[MAX_LINE_LEN];
> +	bool has_vdso = false;
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (strstr(line, VDSO_NAME))
> +			has_vdso = true;
> +
> +		if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> +			if (strstr(line, MSEAL_FLAGS))
> +				return true;
> +
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  int main(int argc, char **argv, char **envp)
>  {
>  	pid_t child;
> +	FILE *maps;
>
>  	ksft_print_header();
>  	ksft_set_plan(1);
>
> +	maps = fopen("/proc/self/smaps", "r");
> +	if (!maps) {
> +		ksft_test_result_skip(
> +			"Could not open /proc/self/smaps, errno=%d\n",
> +			 errno);
> +
> +		return 0;
> +	}
> +
> +	if (vdso_sealed(maps)) {
> +		ksft_test_result_skip("vdso is sealed\n");
> +		return 0;
> +	}
> +
> +	fclose(maps);
> +
>  	child = fork();
>  	if (child == -1)
>  		ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
> --
> 2.48.1.658.g4767266eb4-goog
>
