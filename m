Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE12571B6;
	Mon, 24 Feb 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424331; cv=fail; b=gO0B+W9qgDcXpjdYrFMKmDLozbpkWSk3KVK20mwOy/f9x6+So15+mMzM6eQlwgxFM9lUEHzRTEGNPBSsoTwgnDJC+TjqTcCDLOGbvcJ4dzgsK5iJ8QtMIDw5Q5FLdAk4MLCjcc/p1CBavqlmDl65HiMvQm+hg32AXowfTim6NDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424331; c=relaxed/simple;
	bh=afdXkKgyJbEd+h5+6mHsOLkynmWh6Y+kgbAwim9VbhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iyUvVXfUd8r4jJqqz7F6F6WdK7L27Id20hHqLqQwlFqd9YqNdlHDZrBEhhtML/q6az2+vy8MqOM579auj4ALf8ek/4WWBgnEcyEkVLgg2XLIkVHoi6KxrPTWc5z/eulKPuDCn0nk+7CSDrWDmOiXB/Isl2I1M950524B34JGjzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XVNBGFFh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y1qulg1k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XVNBGFFh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y1qulg1k"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OIfcsl023362;
	Mon, 24 Feb 2025 19:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ccDZtEXNhELnVTFhqP
	awVZNjbcgTRDEpCcj57ifZjXA=; b=XVNBGFFhDU2YOjqpU3HolbGDvKj32+QA2I
	nZmHhu7cZ9PnDjHTNJsaAO91r6XXqViKRvuX16lj73AeqfM+kI81IBxo+HlYdLMV
	GBeQ0VKQ5ZukqQ3Iw9J0wAMlBnXqa5RzvSrVmwfj7Q2CwM2Vga16+bH8xbI7MAhV
	7xVVVRf5Masubp9SxhJr/TA3O8vvnB/TQLqzQAN/64oWwEkWiRKJkkGFLOZUi1Oi
	hxHTH41oOLZe/Oj9GYisguoBhDd9g0pFGLTxXnk7wF5724R2EtSsQTZc2BUqDTPT
	yNxmOGSS4gJbQ6HAcnS2kbM60BWQGbhs1k4BycoPJYvs91s9AKIA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2bdvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:11:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJ7QwR025221;
	Mon, 24 Feb 2025 19:11:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51emvdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I46oIRuWo+g/sBQ5d83Q6Bq1l/S9e53LoBMbSLuB+gJdn9e8daGZ3FDjmuCephNdmbNRLRaMJGrLjJAE3ovifjwuf5sg64HJyU//3WveDA/YanC/BQhcmbuNQOrRQTJAKZLmALDThCvrkTKf3hN0ggUK3uswBhRn1zaBCK9uaGEp10EfRFH/gaDUCUxxZoXV9WPHrtX6EZb2USwtMjpljnx5UnG/ijvnJd000W9Vl00EkFv+ws34d8snJ1Zv3Tm4dFTK217s8Ly8UikyNc0fZRdQ7U33YPiPRWVKpoW75G0HZVlAMKf/jp2TZmJRwdfLiWGHRctQIyOMioXwl6f6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccDZtEXNhELnVTFhqPawVZNjbcgTRDEpCcj57ifZjXA=;
 b=c3iYvcf9+0hPBgsOqmn05lJJqCtaGEr6uLe0HWgR7pDj0SfiHp+ZWd0Esblckk350df8876MwoDwLrZIxowCoxdaBWuusxxcSS01UfPg9AK6ZCHnKKyzrE6kxkpJXrWiNWV5kz2BpVDQeHKm/B0CkJZWbTU0OSoAgjU8nuw4/u1PcVlhFjo+exYpWmiahNkkU507f77zoI2aGrNH5uC0H1dYng/P/83KahwOt8y31Qcj5kD7baGbhxmHRcBAwKKynIgpJATJsnA5HS6AFFfWwEm+w/TsDyDrZYFK1kJi7uxUQw0q3cwECrfUeufDZl8pAHewEOGDhvn7uRJpdSt4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccDZtEXNhELnVTFhqPawVZNjbcgTRDEpCcj57ifZjXA=;
 b=Y1qulg1k0EJ7BwwodkExKWIYpIchJJXifOi8w5HXk9YmmDs8hdJEUP1iB7TJO0mG5HDfHLHZJJ5otZY/Ji5WPMrg70Rxl3axL97UL+HUt+esMOjG2TgB7UpfIHJCEAv81EHtvZVLQ9buE2XwRHSyRmAgQ0CPLkmUOfqeqPjI1No=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB5035.namprd10.prod.outlook.com (2603:10b6:610:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 19:11:05 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:11:04 +0000
Date: Mon, 24 Feb 2025 14:10:58 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Jeff Xu <jeffxu@chromium.org>,
        akpm@linux-foundation.org, jannh@google.com,
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
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <lvzy3x2tv4uskn7dmatdqwqhhs4xv4vumk5f46thunndxqro6q@egremlepcgo7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	jorgelo@chromium.org, sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, johannes@sipsolutions.net, 
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
 <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com>
 <202502241053.1FF33D5B0@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502241053.1FF33D5B0@keescook>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0089.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f06db6-124b-4716-f29b-08dd5506fc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LVCs+VIeQbBS4+lVGaW5AL3Ep4/EPrxkqlUFYOPp5S4RQsb2QjqeHCrICOqm?=
 =?us-ascii?Q?gfQv6Ugu3cw6W02vv8UZm7axc8aYwnOMIVpnW/PX0G51SxP1oiKrBMUg7EEf?=
 =?us-ascii?Q?fExREB89TllXwYMTNZpz5Z5SDy3WHjJfATdk9g9FCGJIPxCrsX+qjl5k25VN?=
 =?us-ascii?Q?w6w9pVrzRO6ku/itUrG+xVCNiB7+ekj5hHxVXsVVSHCLmJ3KBcVnchPJJvU0?=
 =?us-ascii?Q?LDMMCZsmKwQesfNkII4jaLOj1Qo31Hj32u69s6M1xwmGfGit6c2ECnQBYEwX?=
 =?us-ascii?Q?eoKL/vHUw9fDwFDtbOXH4O5XWEDrQOmr+w01L0HM6Mhl2zR4zocP+ZCrwBJt?=
 =?us-ascii?Q?bMxPaRmArpPvnUXRn0TDAfTMkgMBiKh9XcDlMZbu+mlQJ8uiDwUhdsBxpNoU?=
 =?us-ascii?Q?BhcZ5GzqGN1OPNPk8tujxjNBaHGtPrA8122Q6OhlzFGp/FFogh42OiTzZfCt?=
 =?us-ascii?Q?1McVdD/Muj5eaiq7DeW81GRPcfMXcMtAN7tdOsXAV+QjBGeScH4oNPvm30LY?=
 =?us-ascii?Q?c0NPWMwUYqGco6ajKsHu9o681mvz2OXSmu3yCm+lyuJ32elQOZdkKBqRbsCJ?=
 =?us-ascii?Q?GmZq89cg2mSwiyX1sOwKwsDC+HZKl12leVCt+mFUJCrfbi4BdBpgHhoxpRHu?=
 =?us-ascii?Q?QTawKu0UJg6tJ8Z+KWdY5Jps8VsSNCodJTgUWx5P0RuzQjpCgk/mLA1TnpUZ?=
 =?us-ascii?Q?M7CyE05UiZTiKEVwwSJ+VEajYYgWTPMxOvnkEkgODl32/cOC0z1aIIb75ma/?=
 =?us-ascii?Q?VLx5CfzNlwjgoprHBMh32RelBcMeMphi2KbKGbkSGilAElfAvpqvVgJfkQkc?=
 =?us-ascii?Q?0vqDqVfx7TvySKRP/QZ9MG+qDYhrTIipj0URT3r3LdZ9R7xj1YmJXVq2tprd?=
 =?us-ascii?Q?p7SAtr/eoBOOVCx69R2tXUCphEcXj/1zARzjgwGAIHEdvoFq9vhdsWA1LBoa?=
 =?us-ascii?Q?9WQv+MzgQOl6LLv6T9PmUzQOFN+ufF7ejewcyqMI1D/DvADwJ452lbwi6e2m?=
 =?us-ascii?Q?+gCWvJNmgnvo4XazIcbR9BxhykUcd62zXwfuM3UEiurR8d+Tv+D2HooBFwUS?=
 =?us-ascii?Q?kZ81fBKvu5KdLatzqZKFZMu/lnI5fax7VyW86lVCxABCE86ondFvrk1MDREK?=
 =?us-ascii?Q?oksn/Fb9/0RSV4TPDfSs13//dfwa/yx1m9C4wQmmGKMI9qqdTAo90GyCY6+y?=
 =?us-ascii?Q?tJ+WLDntoyQ0i3VFOp/rdGMXM9UizVSjkT493F7SBHj2gX2HtWeTa8PXr+yX?=
 =?us-ascii?Q?8pP+PiGT1IcLItCXfM8zuQxYURDV0tX9tBcreK45y6TY3K5jZovYeIvqoSFO?=
 =?us-ascii?Q?Oz9DJZQaW77ZhmMoTfwJbfCRG5HWrkVY/9A0xQwGRkrSriq17H2h1DPK6gp8?=
 =?us-ascii?Q?6wFZvWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h6cMOAy+fd6gmPnHOROrQZ68qZ9hTq5fBTgZvqoWuNRCrixQUOixN5/dRZ+3?=
 =?us-ascii?Q?nsELntH/TAb09+n5rlBl94PZ1KcgXRSq7e4mey595nfWavGHCd1sxJviMYMW?=
 =?us-ascii?Q?BtLMONtr35lZMAzkkcEWCdp/kym/egwpyeV4Jgb3vX+pM+3ox4ubv5WyObkq?=
 =?us-ascii?Q?PRA4ulNhInBdLCXHkLKhjxsbSc5JwUxNUIAnh8gUhkyRKBZH79zZZMx5bw8W?=
 =?us-ascii?Q?LsGqATXPMB1BXhwkyTWvyiFL12o347dTvN3ibYH+ccE28ADgKoWG/URuye95?=
 =?us-ascii?Q?t1AP1BkCbW1go2xejR7TjkUa1sr0+79f/mDhdMBDlqS+Ilpn7HzwZBCtIh4A?=
 =?us-ascii?Q?r4WPVSkpWewYX+ll9xT2QteBO+vOF5BYlPxMBryq0pfvz4eQboWDTdwNq878?=
 =?us-ascii?Q?zO5me66iELp62lG6F4tm75GZcwHL2cL/+Fo2jcemAB+4Hi7Oly2rgBfd2QGb?=
 =?us-ascii?Q?5roHBFq3X5XWlnMe8gUJRRL4psV3zDxe5Bddhon7n7e+xQXeWVILcGNDQpkZ?=
 =?us-ascii?Q?qaN4sUXb4RNvmozdLKPl6ritlE4xTYyJmBsYsdcxSq8IuatZGy3b0cGknPZY?=
 =?us-ascii?Q?7u0ZhtNA0Ig/FhPfYcisRJUgcWox3u9O9ocyH61aUAOQOJj1EMtwCWReBmCi?=
 =?us-ascii?Q?yKRsGc4+L3bynG2hNl7a7CXaUmajFF0TTBOwuf4UJiLoYBgp2rIQXhGy4rvk?=
 =?us-ascii?Q?1R8RsVBySavYCvMlJi/3WRYTYdQTwi3zUmXZ/5lKl1L4MkhqzvjWahFOAbPH?=
 =?us-ascii?Q?j/1sLSkRIdIGY6gAlidSba7CDskxQ+CGf7BY+/G8hArdnlQq9rgExc1aaZHX?=
 =?us-ascii?Q?3n3ULHTuPlUFbX5Z+8PBSiYUFXMdMB3lysc1axj+KyHUZdOhJpJ6c1tZYS+4?=
 =?us-ascii?Q?j12qQVDLO7Zg4VNR0+X/iRCUGw2wVunM60cL4e4tSrYu1V7uGbaB8R/pho0/?=
 =?us-ascii?Q?0qTbq7MXy97zhB+FENmU9LW3qoQJynVV8+trvsn47iIcNsHYuZvjqI8XD0LR?=
 =?us-ascii?Q?agdNnX5n5MHoPPVFDJA+MLiK+bxoh7bXwuOIa7osS0TgnqHPpYFWDk7fdX1V?=
 =?us-ascii?Q?Nvkd10BMkRnxWF+YalKVPvPxUVRbXbFxeRrsITofuxEd7jFFOJVP1Rhz/Bqa?=
 =?us-ascii?Q?wa4ZYsEN9/gDXZS2AxteeyMAF7hmtiRJRrDDQEnOzhU2cVv+OnCxO536V3nw?=
 =?us-ascii?Q?hXIYGhXjPxWp37Vbxy9xkaqcDTm4D2IEOdfY/7yglHyYVzmpEb1Tlxn4m9k3?=
 =?us-ascii?Q?Fvk4qxxr4lE/0CzOVvAXlX6uzPeB3fwzyKlTkzsT8HCPXTyhazbx04GW9S14?=
 =?us-ascii?Q?nu2Sufm4WzKENjXT5MS7IK/KMb3MMnSVBmXfCZAUj4SfYv2wHvdFx1xNdmuA?=
 =?us-ascii?Q?rXGDRC8HqabS39iY2IrR1Z+tpBelTVyQIsPkTADbgTC2gdXy0ht1Ppl1NQQE?=
 =?us-ascii?Q?Fg/gTM+YboOBy8v/w0kjxX5Zl5I+DnHWNGNjIuXhGjvUPBbe+35TSehFehWY?=
 =?us-ascii?Q?d1y4SxzzlpwM85ELD+7CTdVrU2uWvD4uLNSuttvjhXI0Vm16w9jkOKQbaesB?=
 =?us-ascii?Q?MCjxL9CP7vb/q4P6yKqkKgSCUPrwSx8CsC4rrv/S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8KhQJl1j5U9h53lgv+NCxa5ed7PkE1IC9g9KPQaAtE/2+q2+fDAmTCSXmv17VFFHTWmRO9mU0Yg/+AP/vb1KKkRNUCPm6Ar1Wm8ylIlyszQrUtdUeDaawzHzDWB1JEZeM3J1QoLCcJHAdcLIrhK6z+FkupyWsuwSQRb2Z+ECexQyCesJCG6Pph48IrF/PwwC5g1vvCZ6QMX7UZs279EYjvLQ0VEyS+GPhluaFjWUjbpUxSTF9MJ7ELiwnaaPSuXNb10nBDJ5XlVrINkRs2odWcbMiZWwqUO9Dle88qt1OPDO94GiRA6HYK0cR3jaxxHUx11nei9XcvUv5cq6c8Ye0KDCmqF5QTXMUwOfbBd3aGqbsPrDDua6elQXaEEbHoNOmXilRWCoaisgYWTUFo6wudm5xup3QV2t0ihgb2uFsuI/qglqkNcB+1ooR75gpoek1Cz9/IuW7qfktgHXCNbG5A7VVcdPWx/R1LCKH3iqngpeoGv5KwI/SinWC2h2Uczts/n85Uh97D6HM6RCRFXcIbGFqWrSWDM6PS5itbNAV7BRcb8SS9SSV0RmMuOPl4TgJHx/OHzIGGbzwPwXXekW324RUDjKWqUEMoc4YMKD+H0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f06db6-124b-4716-f29b-08dd5506fc4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:11:04.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBCChvj9jmGrRVPcykIbPDZv76+wM+yZVjfwJ5u2C0rtiJ8D0arVHAaZGf7Z9a+td6xRtP+JR0Etq5pvK5K61Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502240124
X-Proofpoint-ORIG-GUID: XlYk5LVyX2d9gXmmNPwns6p7rClnBhOP
X-Proofpoint-GUID: XlYk5LVyX2d9gXmmNPwns6p7rClnBhOP

* Kees Cook <kees@kernel.org> [250224 13:55]:
> On Mon, Feb 24, 2025 at 10:52:13AM -0800, Dave Hansen wrote:
> > On 2/24/25 10:44, Jeff Xu wrote:
> > > For example:
> > > Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu.c,
> > > 
> > > #ifdef CONFIG_64BIT
> > > [ilog2(VM_SEALED)] = "sl",
> > > #endif
> > > 
> > > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the problem
> > > in case that  "#ifdef CONFIG_64BIT" line is missing.
> > > 
> > > Please note, this has been like this since the first version of
> > > mseal() RFC patch, and I prefer to keep it this way.
> > 
> > That logic is reasonable. But it's different from the _vast_ majority of
> > other flags.
> > 
> > So what justifies VM_SEALED being so different? It's leading to pretty
> > objectively ugly code in this series.
> 
> Note that VM_SEALED is the "is this VMA sealed?" bit itself. The define
> for "should we perform system mapping sealing?" is intentionally separate
> here, so that it can be Kconfig and per-arch toggled, etc.
> 

Considering Dave is the second person that did not find the huge commit
message helpful, can we please limit the commit message to be about the
actual code and not the entire series?

I thought we said that it was worth while making this change in v5?

Thanks,
Liam
