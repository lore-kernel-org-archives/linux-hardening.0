Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106B244E8C;
	Mon, 24 Feb 2025 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428848; cv=fail; b=iHULcvF0Lg70YljyNxusxX5hnDnY9HHQ0WMT+n6O38vTNfdKr0UkSIJOuOiCasoANc5Z8gslF4PRDC0TFcaLNLFE9ByHPbTQkQmnpjDWlEzi4zDHPlScC2EVNbhPmZ3iywTjj+OjLRoF3exA+uquJOasfnL6bCH5aDF77+TLrIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428848; c=relaxed/simple;
	bh=ImaQWVtrBHhggtLKCpUVHFgrByf3/IYC3fPXSNllc1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rNjWXgOtN2u1LowSKUtcpFUSanKfsPOpSEP3XM2NQ2OT/8TZOKp+QkhQwAdsj++OMgjluEPcfCuHawx8Sz7hRyHJmY/gwygOQ/E6rZzqdihiRXkCN1GsPYC5Rid3SDTeqKRtmtut7wU/fWAIznouZjrErNgzYkVPElr8upzD/74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g8PPWp4M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eQ9nfHnY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g8PPWp4M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eQ9nfHnY"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJXhLl023373;
	Mon, 24 Feb 2025 20:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qrSo6ECKDhlnt8KznZ
	QN/w2oC/cI/QPFnL1rug+kuqI=; b=g8PPWp4MhxJzkkyh/4lpTnnXv5HXwZa74T
	ayrAIXd6pgkQqUevR7PkX3q3G2UDrF1zTjRY9Mt50qT774+l5g1wOTZbSWGD/K8G
	lLzhEO/eAj0M34VGx6al9rFrpnHmFIAgN++WoBMBDXJmOv6avVzG9J3bYP4wG2zt
	0Lzv97RvaK35dhYVilZwJCoZ7RH25nB2KyHOGQMXh+31DNL1S5cWIKQnn6/PKyMR
	XDJvj71bRGeYBtcJHs12aXqmRiHTtDwqeATiXJj2Quhhuq68WnsFs+eCMLOO8vTA
	50mPA4yUTVP7sfIjIiQcuZKN7nZF+3iGzy0n3XU2iFf0IVZruukA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5603j6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 20:26:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OK5n2C010488;
	Mon, 24 Feb 2025 20:26:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517y1ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 20:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC6bFUk3mcy4lSUHKjMfscTXxjpwi0iWpct30/x2oTh9KAXCNws+XhYT/EOfMTqrBCgWymac/aUIuUooWWkRVdqTY+WzHiGJG3At5S9/IMKo18ceAE3x8XNKvcwlwmM+vPPWGcPb7usHOp+k1zo9OmCdC3XlKvkPZvHQAEq77ins5i62zPRULymO/RtiByykdjaJ+zAhC8J0yDbmQNSwtvbf17PUv2w47IgkwucDGwzlqMNWHDZjqBbsWoqvd9Lm/w8P5UYJAB9NofOPi3PdO3uV/AncePH1cxJljGUMt9AS9fhdJP0fy+kP9lXVNs7lwNmHzr7579w7YN2fpQoEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrSo6ECKDhlnt8KznZQN/w2oC/cI/QPFnL1rug+kuqI=;
 b=V/DP7gg8HIJv0qr1vK0Ucefl2owuqNNcYyMCKfb316ZifDEETiZDM1i+s0WA6NJvb+shhyApfv1tnD2h6QV0cv7OIcMzQ1X89loWu9HSHWsfJfONB9s8Z/ztFjzkDM8Yag2tbH6ie7OM6c5vJKFuOIx49SmBPRe3XPsaQwgjnsYgoI5Jc/OnEgEnJwvJvpgy7AgZLGMDOH8zO7Tprzz8xD/IO1kFAEYUgac8DR5HQaWl7MYrwgIlzFn/SCWCiBKd7cr+7gNoEQAxbISvd+C9UcyDfQ1rAiDYjUC1fHNenfIdcAuxpSBrh0SDJ0oqbARFrCliuX7/S2dafwsWkFNzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrSo6ECKDhlnt8KznZQN/w2oC/cI/QPFnL1rug+kuqI=;
 b=eQ9nfHnY5WDTItlW2qYiNYT1fSLaxHmoGqweAlX8l9CzgCYqxERmM/Tn4aPVSqtvZXSaIaGeZLuK9vdDSo+PeeBafY21VGFZKc3/RVg5BRTb6X+Y3eIwWv5kj4bdJ3a7HxcI5iqBoqPI/wy8SeukRo/5rX99DachsGfE6jBkZDM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 20:26:38 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:26:38 +0000
Date: Mon, 24 Feb 2025 15:26:32 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
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
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
Message-ID: <rzhfepcwdwiq6khrepv7x7gpgynek4p54fhx4enqgyw7nubegc@uydhglfx67gp>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-8-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224174513.3600914-8-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: f72c3541-632f-4187-cbf8-08dd55118a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWYn6uX0XOgLb9PycezDbgqJDFrrZEZO7HJOKlLwFD3W173w1upnQ5FjiUYB?=
 =?us-ascii?Q?a+qRLQL2TWPYYbVtopF0Tp0bUnF1noGShCzYWrW/FMUrYyDc4Zake5X3AuV7?=
 =?us-ascii?Q?KFqJexU6u2F8m2Wl6+VHad4C4VbUQ0wk6Ex2hn3i/z6mB3JwFmZ80ozFa8Kt?=
 =?us-ascii?Q?pBSzqUjAX5JidBCNgoQugspDNwTz/mO3BnKCWW+0P0OCEvP9W3uw5CjWJk8t?=
 =?us-ascii?Q?4FTi/OjnwEsyS1zUfYfev3Ezx/FMF8utM40lB3JdxEL/s1P6skhAN2L6JDFA?=
 =?us-ascii?Q?nzoBXGtamZpgxldNCSrpqTiC3NyXNH5ZHa5BDd1OD7zdHPPx2yRCcmIu0j3g?=
 =?us-ascii?Q?oFensU20iCJVDw3HEzuCXX+qLxGbwtXiPa3yMF32ccrZ7QYpY2mJtyNiTosR?=
 =?us-ascii?Q?M4szbmb+U+W4bFd3HJ4YNM5LKaK1pko/c7kbwGYWP98aXv/e8dIUalsFVb+m?=
 =?us-ascii?Q?pkyMHf4Ikq9ljofKeTXeWlo6HxkPJ5OENIYeaJ5Ferw+nQNr/oPfeiMUMpML?=
 =?us-ascii?Q?QMrz5MRYCL1lHqf+/5omh7B4W4Xs3P2uKjkRgw2e120Ty5atWKzdPR2U7leJ?=
 =?us-ascii?Q?dgGdDSi5hCQZhAiV18E9TDJYKRBu/kJ2MH3BfhUDx/wnzO2exGxwDgvk/bBq?=
 =?us-ascii?Q?KUFXC9f4PA0vQiXHiZ9KkWHA2FDdvws4unhb5sO6ioe5yZHpgmyvU1nbyCpd?=
 =?us-ascii?Q?yhX20zRsJ62AcUC3W/8tO4dbfSm370qN8u0FxdoR+nL6IM4sW3Dn8AJdKuY7?=
 =?us-ascii?Q?GK4GAxJ2S3zOEfJioqYqPov7tvmxMgPWOEqIf5ksbNiIf7YVr0VRYzaKMXu6?=
 =?us-ascii?Q?Dk3bvjqY+8h20qcgHv5DkCK+1iKMwo4OTAfxztzaKcbK+AxspgA6btKcnab+?=
 =?us-ascii?Q?B1czKcM/X7013lPozSnOieBhtI6ET8QVotUqJamtMb6F1rfnzZSD8MdgU4jv?=
 =?us-ascii?Q?lRol1vzHIwRS74Ix5c0i6iUa/Gtizg26d8SEIGHAiee5GumCdpFeaSWjb9Ft?=
 =?us-ascii?Q?cdSsQ89mDetS8zUWc+L48gJoR0RRJ2DCj3V1YvDBe+M+HFRYp2MgmpJzatA9?=
 =?us-ascii?Q?8LtpgdljYurkWjc236mZQct9nLBRnlf8UOrfKSBqfv4CUGK5ZXfF+CIjtcIO?=
 =?us-ascii?Q?ZwiBUjYVGzS5xX3ZarfGSwXzX3puPPK7gJ9/YkkOZtjkGZWpc0eX76HlLJ5x?=
 =?us-ascii?Q?Num7JlqVDYD2sI1jrjAwvQKD97jQE3iQvHGVrqvYwDVnEtGaXLUycVLjk/hL?=
 =?us-ascii?Q?W2G4rkrmDjbXfH9BRwSXy3cEDgz7TYm/CkU+lx4n8hF13MbOIO5/D9rj7qmf?=
 =?us-ascii?Q?6OF49XrvYCVk7kk6IKnPcp3/JMU2YlCu1dkufw2HzF56/pwuYCbmQa1kvvtj?=
 =?us-ascii?Q?7F7x+gXenKc5jK7Mzn7PVr3Et2Hh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2Iu7es1M4UrcQ6PMWG2jG0YQ0RhTiJqBj+gbXf1D4JgmOIh+tVoNBY6g7QQ?=
 =?us-ascii?Q?L1AHneYV/H319AQqOkoDr56V+q4TyE8Jb9TTE5Nz5e3DX+RHb9/KIMxcB9hV?=
 =?us-ascii?Q?+MeSkm/7foQOCkUxj3f56xos6yTUibNy28Q7/HjyB4Ew0RFknpynM5NVVAYB?=
 =?us-ascii?Q?35Y6JwvjMxtWCgjVDBo16OSjE4AoRAxuzVDEoujvS62YpK6c6bJ1lhyMk7FQ?=
 =?us-ascii?Q?wmgxwWuNW1myUBx9i4yNhpGH6+Q0ybHp7Pxm7MvjG4zOR/N6733EGs5B5Jci?=
 =?us-ascii?Q?Ij5cYu+rG1SLnD2deER3VtwTSDy3kBlS5qs80yN/LTMKravEbmdQQ6j6Sbbn?=
 =?us-ascii?Q?Rg6zbHr23BsZofmb4QrwWzBhi6bF9NbQBs6Liz5jBT7P66gnou6pDCbPAIcI?=
 =?us-ascii?Q?S9tKzp5VS3FS5cZR0rdXQMCipeoKwaPmX4Wt1GjUu2NlhR7gy8ELGsXAJwHg?=
 =?us-ascii?Q?ec837zqHMbo7bSeMKS0GD6tzCTLwxYVH6UmFVbtx+5uOXQfchTnQhugh1DIp?=
 =?us-ascii?Q?c+DB0n6e+aI/wbXQ6M2380unDfjKZbrdFRoc3WopofMJwGvNY2esvnoAfG0/?=
 =?us-ascii?Q?KK5lgyrXUbN5LYG0jjIulDtPb+V7IVsKNg/+Slt+KEVeWj33qV/fw6TLxEW2?=
 =?us-ascii?Q?z39+arWN1R3INO4qIOWZTP2YJ0Ce885hLWmAoY4E9VnbSu/DeobIPbuG/eNB?=
 =?us-ascii?Q?6mX22RbfcegUXKR4rG0LduZ1SPk/LF5HUeFoxT6yygpvfPlf74A/rj0NL9T4?=
 =?us-ascii?Q?Ux6jPUeCeVXnpXgzw+7Bev14h8wxnQ6YwPMW+tBEUdDjfofRpLAgQ0IjBBQM?=
 =?us-ascii?Q?oOd3dBfGpz2iLagb08zg+M3H/LX5Isdn+P+V0q3h2MDMe14PYUjfOdxoCjnT?=
 =?us-ascii?Q?MLn4LWBpJbwMTqStCR4occ63GCr7ikSM3hTGaiX5HtX2a5hz9+QDvK5HIA7R?=
 =?us-ascii?Q?/1M+bgVChgXBVtV7V16ueAYXl2AEkxO3l6lD6HSXUPLXr9+9zRHouHEsn4YB?=
 =?us-ascii?Q?b1h6AWCJGKjNrmv7MHHnkQqujs2tiER+DyFULU2RiL0vJJKlYMLQgzeaiyG3?=
 =?us-ascii?Q?8yPk45vOgJ4em7Xxhqi0zDN5XkGUiavHoIJVfw1gXbLXP6HbtJ0IjRR1b164?=
 =?us-ascii?Q?MXEcb7TpRz+QCM1VD7uPMmPKEgoJISz/0NKQ+HlAolEIgedaXp9zMeVj9fOy?=
 =?us-ascii?Q?0+47jjYBe/W1thoHF2XFOW1dqbqFBUs59Qhpo4x3N1/BphBDvYvZBxuxiaPH?=
 =?us-ascii?Q?XYqfWLQsFHg+pFH3jnZ37lIziSA2kgxj1PN3g9tt6XrSe0CnHnQ1V93Ujuch?=
 =?us-ascii?Q?yCg/SGE1ljU5lMx7LgEMZ2DCVbN3YY4IBPqeDYuraNrQ9A0HASdr9AgUoIcy?=
 =?us-ascii?Q?RPDBUEIWMPFx7vaVDm+b9pDRAfZqURBFu99kUyDMbfiM/FQJfqaKzMJ1LOVg?=
 =?us-ascii?Q?ZN2lvWuUlWz9/m49a18qyuC0zYj0zStOLo7wci4EFoi+9zh7Z6Bi3IbgK8ja?=
 =?us-ascii?Q?rulVmfoqgBMa5c4c7vho3wI2K4khhTHW2JFMduppYQtbmdpxotoHPBOjwKIH?=
 =?us-ascii?Q?q52Jf9nQrO3Wjifu/WldaqP7HrKlPY2FQVFp/m63T3sQ26CeeH6YLvwmk6I6?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aOw1UIQ0ybwSLy/tK9K9G8Xe40xEPL/TnKyhvEdUHkg8eeexRmy1lMfI30ygJGLFA02zWMMwNwJiS1ZyZE4Jw+iWLeavf9FpdE9ErTEwgwOPOIioHsRau1Qj/ohaFOwU0C8l8UKroMeu7loBqtNylQ4iG4Aes9kJwtDTJUfcJburoeBmHkZcKpplQVsjQOzzT/Crq3hZDWD5J0Gb3M1oCUuhCdu4clI6o9Suw/KQ/qdEEiOp8IygTtX2NIUhrGdQ7kLaTQMsn6hK1WGRU+7FLU5JSjzeH1Y4n0ayHwlCirK26WhmQhKS7w4Pfsot/FVZr91I7/hJnAsGls7z0mQPGigevNBMGb5KZ2FNi1nzRRfyV4FhNTMgHGDdFvSurRN4kkS4baV4esUcPJ5xNuIBTz7tjT57N/tXrOCZu74VFCC9jEaMJrboQ4hYc5XjSPcqWkPTrqPkYTvyb9kym5K4pLqp0jGclE9ynykNXfQZt6Jfn4Mahs3oKrYjTG6nleF/ajTrG5awS2cvRNumpQWtYWM+h8CbrXjdUANjEzmTXFA/V2/pHIEv4MHfTPYrJyiSxPi786ZgBVXip4vREJ0POkNIycZPLJPBjkSTKcQz5fQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72c3541-632f-4187-cbf8-08dd55118a95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:26:38.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykoz01NaawCefXJ/4ptHsBUVxDFKlYdXNj0nWobei6XsWcOh49tdaRoZTkWBUXu/zSTHU5pA3PWi4x1L+hw60A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240129
X-Proofpoint-GUID: 1fqHUBI1SMQtWRnmZ80HgXIDNX-GbMBX
X-Proofpoint-ORIG-GUID: 1fqHUBI1SMQtWRnmZ80HgXIDNX-GbMBX

* jeffxu@chromium.org <jeffxu@chromium.org> [250224 12:45]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Update memory sealing documentation to include details about system
> mappings.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  Documentation/userspace-api/mseal.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> index 41102f74c5e2..10147281bf2d 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -130,6 +130,13 @@ Use cases
>  
>  - Chrome browser: protect some security sensitive data structures.

Did you mean to drop this line?

>  
> +- System mappings:
> +  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
> +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
> +  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr are
> +  known to relocate or unmap system mapping, therefore this config can't be
> +  enabled universally.
> +
>  When not to use mseal
>  =====================
>  Applications can apply sealing to any virtual memory region from userspace,
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 
