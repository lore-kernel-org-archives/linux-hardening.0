Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795636393;
	b=C12RBtji90KDeEtz7R4XoWDoRhJsFXTfcvqw5MUGgtYGHVbWaA7urlsdNshLcoocxeUb
	 gLGD+uKtP71KxiVZGA6ueF6RWuOqba2JjRqhDC7ZEFuxDcEnRQhb38JcrSe0yaJpeKRvY
	 wMT7anxyq+bz2juiS211n6NLmArIxKWaZey3zGnVOJ+EmEgPdXaOZUqm1JjHw4DGR+In5
	 6M0KlPewrGBqUvjr8t5wzFKP+4MF8UfQ8GlqdepPgK2RfT0cdnnmMiP9aJeNYmk82MSkr
	 lgBSUA5+G6fm7694/DuuK42jw7vRHIDMt80fe1DEENRfA85SCceVy1NxsFLZfdWK7cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636393;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lYukfeY6cpsC+JSTj++fhLw+8HPibreSjdNEjaBumlw=;
	b=faSGiEiZBMFEJHSjsg1MFICMjGdPTeuI1geacGrFkc6FPeELTYUdrHaWicHLZ8G/B9lW
	 DKbHH+Sp67Mi8oWeVh/7qK5aJZbaGeq7IzVR0/NjSPFd3szbPIbQCfiYRoRzjoOeZeslx
	 Z4+FuQm0sQIWBgvzFjjqRWp1bAfLOqqO/2KEmtgE35qch47826INBZtCZg9Q3pjd2ZVHo
	 ncGpTjMId00C4UjJH7ReMisPBG00OGEd5WZwKOXwMCTpyttkrcSQB5OJ5z+9s3XtdXb0J
	 TSn9c0hHmfPkbWuZggoaE9rKqlFOpV4Wce2w37o/+2CVZTMOs/sl4cbUjBhAJhwWhnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yBnKhGJF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.49
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F1606A31E;
	Wed, 25 Nov 2026 19:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 597F1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yBnKhGJF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOZ5PJoA7SpfnA8T8vkYMWzlIi1easLlc+gyD8j/fnI/y/IxrLMJEzaXR0vZ51S8raHrjKii13E73gpFqwsovisdNVmtK7curGo6FJIciDpVHOc2I9RUYt0smyI8FOh85V2LgG1z5ztFlsDUx8Iz1Fp9STIPIGdDEpYEvfAUKhCRbFDh6/LcnseHSMybdemHdZ8fIAlpUzOpx+xYV/rt/TYaFzOeTRgmWIdgJk+s69Tmb6Fl2z71bsgsQRrkc02Z9Ve+1NFedUO5uA30pySR4Y84NZBHHDg5xwBKww+jGi9ADup+QFJmwyX79HOKsdqwhhZkKLzyEAJq0z9ncZUzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYukfeY6cpsC+JSTj++fhLw+8HPibreSjdNEjaBumlw=;
 b=kYnJkIzNHaAJn5WcWvC5Bmhnk8RNsWszyWSKjQOQ+6OqDznM1FN2fzO5HgwLjt8inD81FSi9GJiKrvfR+g/InBNq/K3AXdkxp3cNUHW+dNJfxFQrxDgjHl+XRfGHwJHbDi/J867IRi3eOfWXa8jPRktl4jnqvEkk5r5BG2Za5zmpkHEhw2hPA2uld6EZPOFQLm43EyCHNaYsUBMB+SqrNz/0671Xo6ppOPt+3w3WtswjYftiBgVhvpbeyTT3YRqhyUhgoOj6RrCrZ1USxKJLwJcYidbbrIslNRnHGHjHbo7lZktSJpgdmaeBunnXZajB6M67BF9Bkv9lK0Sg+HeHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYukfeY6cpsC+JSTj++fhLw+8HPibreSjdNEjaBumlw=;
 b=yBnKhGJFU05WW/UgOJHSCj4G4MO+C6ypueW216yjUJVH2CHxNJ7XeH5hoBSwQPZZPgszNB5QG+dZ4i1dSAlFP5kM6ASxRNo72UrwiwI3o/O3+YHTRbS50EpvtMdl0zqIG3OssE8mLhbU2UjglMQf033Rhm3CCniuj6nnbU6tHpM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by DS5PPF2FA070BDF.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::649) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 19:53:06 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 19:53:06 +0000
Date: Wed, 25 Nov 2026 14:53:01 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/ecs: simplify allocation for context
Message-ID: <20261125195301.GO2156781@yaz-khff2.amd.com>
References: <20261111021808.60779-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111021808.60779-1-rosenp@gmail.com>
X-ClientProxiedBy: BN0PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:408:e9::19) To EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: 316eb239-5029-4252-7ddc-08df4b2db8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|261028144727099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zW06Xh1VlA5uf1IbOjMWR4EkUo3viDDsKolSPSE1IjjsqVWELhgzdpewiWNY25nJtgFfiRSuINFwHgaK8sBlEbmGmclC7MBvi8EW27qtJDhqglaTAwywSnWwscpdF+ShiKR6XrpHsivysKhLHQvUMlOBRW1tu5qNCihrbsJDZ7FR+qD9MABA04Ox1onPATKGk28m/nJT4Jl0TBA8hXFZ4WA2gXXseHoTZxua9qfSM24vLVKWCtOWEhQ0NMeHsW0xsXVzApqi894p9Nfbr8J90zzI2Uv+/Pp9NfwkBsH8fMcKeIuyew8AYW/Q+zMlhaBjSfjpr0Ad5ZhfHJSOHKBeR18iGcAmon7UiV6EldLD94K2qLk12+P1gNmHQVebPg4phEInYEa3bijZmTmeSw6vZk/3dWJx/k2NvEOs48dVRU8cBxj1DYDRpwrD2VBrMBdFNvpp/aBcb4wQRwUyMhGRjfD8y+ac3xnmPFNSB+rGQf85UBFTR+RyYECdZsp7i2e1PIcEx7tJjfS8Km6Tdni/yESYOClLG/5XbV9L1iOTj9qa2btXAZ/ii0fSCPvVnKvgmuxu5ZUtyjdQIB13m2Oo/RsuWATjAKlw2GsfTKOfPCwnJZ6GpGVPthUjEdWWL+oij1TT7ejB6dwqVA8vDkDLuWKV7PvUUQViCkONjoKnkRo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rRMIVf0H5F8jFa/NmnreJLga/ePt+yusLyoiUDk8Zl/POM8eqdzYwCT6Y0zh?=
 =?us-ascii?Q?3vZ1jxq9lK3pjUsQzh8Vzm8A84C/7MwwA7VGl+bSpltrHB/EqOizhhCC0QRk?=
 =?us-ascii?Q?F7o6xDyoThI3IJ5JaO+S2TCwjEjNa9Yz4PmwdAUWyz5xvQ1IHECsOTjm9R81?=
 =?us-ascii?Q?AJ/+2ch801YrltucVPMqxnZmr4n1t9e5LhMDv3nxCo25MYg08L38oFktqXs6?=
 =?us-ascii?Q?87okMMD5Yg1f/RcrA2dngpuFlJJ5FORLJtTZxQCWuyYKDM6H/AxCnqjmxaYj?=
 =?us-ascii?Q?Yp/NzG3yTaOeyYNLFrwTtGhHzI8YEmghzREApnLf1M8dMfud7v7ceiiMhj7p?=
 =?us-ascii?Q?tSycLUJLsUACGd0Z3MiG6QHeYRQQWNTaCZ51dwLpumIbw1NfL48wP7tE4Dh0?=
 =?us-ascii?Q?9jpkZBGd5hXhNYDRyE0jJRPHn3868AmtwvgEznX+bjAh5x+E8AyYnuNkA6WN?=
 =?us-ascii?Q?WmTcex00l0m0rxqRo4x5FvwtVcgCDIPT3v2wchC3ioR8zUtrT0W2pbVB+MOX?=
 =?us-ascii?Q?pNTDJVj9dFxAGJHfoeV+tWi1i7S/RwPNIVlrwPf6u/qkG58ueZqON1V0tfTS?=
 =?us-ascii?Q?2ollJGHpaZ5sPRsQfSeu6a/YtqN7w7T4BkdYcsd4sLBJ/BpbrucFJMhAYkOI?=
 =?us-ascii?Q?0eXXPtJwzUPyOZh06Ujuuwc9E/bCt5MR0oo5yTdF4HVvwzdNf2/F7VmV8oRV?=
 =?us-ascii?Q?PLZsUWCIZEnGQqhHvFXmT0n6uofGZmu4RULyyQ77T5mK/Ly7wXZ05VwUaWKc?=
 =?us-ascii?Q?HlllcXkkdUNZ4n1oyHGjXSZHvxAzMmW4gr2bcVCkB1u/1WIj1HAY8vPiIjTZ?=
 =?us-ascii?Q?YkR0fqJDYy3w5mPiGO6Pl7YHUe8/GvRpy45p0EsyJHFze6HVZ2eOayEbhwgi?=
 =?us-ascii?Q?eK3siam7RDjBfBEnqg9Rm9TkyVhxF/VwZTPXgDJqRX5WH38akQQlYurDvm6g?=
 =?us-ascii?Q?wcq5H3MOixp5R6YfV2XVQHgUvBBHonPYEBwwgdAQd1M6v020hKTvI21yt8HA?=
 =?us-ascii?Q?0+wRvTXlA/5fVNSsBSv34DKYd1J2yVJiQd7dSK22W8zI7JXtMVIH3DMPzee1?=
 =?us-ascii?Q?akBZpwuhqVbUxTBeqwDlAUmdchHvXJZlkteb3ufVOnwg/Z6NMjsymVVED800?=
 =?us-ascii?Q?TENqswPuhtG+aaB0y7mR3/q45AdLO3inrCa+Xs5WB67GuVDPoHnUUfTOn6Mh?=
 =?us-ascii?Q?aGk+egAvylOESX3aLR9+ttvNpRX1D3dGu97j+mrleLWuypIa6f2Assq8uIJ8?=
 =?us-ascii?Q?muJIOQoCzCZOj1LKiT3p5xakwnKC8ObP2Ol8Tu20faW/Q6AejeRvMOaKsZYb?=
 =?us-ascii?Q?xFN1Urll00/pix7fDPxKicjgKV96nZOaY6ywwGHtvSGqWPZYGEau4lBTOQnc?=
 =?us-ascii?Q?dEkPE3ooHDmGaCjsERtAXOTTYFtimjoolZd8/ElyNIiBJd9xSYPmLEN3iNfF?=
 =?us-ascii?Q?9mtmWFQRqlpYYCEyPVajFXslrWfg777knbUZHvBXWAKnZ3ICC4vwFLoy7kcJ?=
 =?us-ascii?Q?BlRhN6RRP5JVbDyiIs1k+4zFr3fuH1oJrv9foQ17ftBR66LYRrJuPmnalS/w?=
 =?us-ascii?Q?rwaHj8j+52Oq7LaBfRhk9ydkTdhqdHdu32GxktGeJ5mHTyDQ1hyvuHe0l1n8?=
 =?us-ascii?Q?fY2pv2LN+a7kgVYBz5g9F4NE/DSiJSkjYIrElyhJmZKNeTggA07sY2KCgtUQ?=
 =?us-ascii?Q?O7cnouJZJnZOPGoTLP/jLWjYXzhCBrbKUInXYHzdhi5IpLW6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316eb239-5029-4252-7ddc-08df4b2db8f9
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 19:53:05.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODAp3KwhLo9P5sksieuw8AKc/R/qTxAgLylIRieOfq7m3ifa/CfpkZpKDtqVM9fwAFc4jlqcpv/B/0MJEk9IUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF

On Tue, Nov 10, 2026 at 06:18:08PM -0800, Rosen Penev wrote:
> Use a flexible array member to combine allocations
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
