Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333717;
	b=iZPN2cgxXmdDCb9lrx+/8KaRiyliI8u6ts8H9zMNwTID13nsv/0FtBtzEmloshRxiBjU
	 PchJQsWDH6zja3pLM7Un7Y4gd2TGaTm9rYREtn7C15lD1rYVEsbGUzzm97Vp/9yjDDYY8
	 Z2+lGDr3q1ZiKi7h1WsPt/gKAy6bBwglqHtZrs34dS1u1BWojqJmhiRH4i86LjeAf5iRy
	 5LsKpw2L3GXgHFqwhfLgtqQXULVK1R6GvjNVJlGgd6tYa/XBlixybJY76DkpiD5iz3N60
	 R7InJYCnJxneaAWbwwLixOoICaTSdgDGQPtj+PfoZ+X1P3+J4EPNua4Jblspfd36v+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333717;
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
	bh=fElF9+T/nB4BJq+4k9x/GUDF3NmqQ481IC8N+Jnh4RA=;
	b=c8PJHwhjs+M95OakbZDx7NsYthg7pekI/kbE+2lvjgJZmi36FShy3fa95ShmgD+SM+lw
	 3am39qyVRpVbKriV1ts70h1X/kJtsMP3vgBPaCNodNiVblhpazgecTILPmToRZP0pwUcV
	 hcXFwYIR8iSkpIaKNlYF67lHxUM74YhbGKdLR71grf63YTXd+9uyKLvOlI58Dujmx55yI
	 jIMH+uMlQf0+WWXpq1ZPPjDew+ABhmFn1Ai+Q63Imbw/49VMFSEiN/uVJCPkTOR00veIl
	 cT9xYOxMqTJed0/J3COYTH5ZK1FY7mogaXt6nG6tIH6AZ2SgSjYLYCNvx5JERVizAIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WocMDh+D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.13
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122F60A2601;
	Tue, 10 Nov 2026 18:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A122F60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WocMDh+D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDSiZgoE4jnnk8XXQ97zacZYTv+YmWd3fKut8F4McbHSBs7kp5XEUDbirw8J3aj0JtCQUaITaMAYf/ZkKBgdP+ELAcFdIAVIWze2T2wT5XoW9HW30rx/DZlQmtchFMJhfm/AFd4OFuopGERx30YvNDgz0Ei/i5mTJZj7NRwB90Fwu2H/s/i7dfTaBdZtvfh1EXVaYIThulzwWsCVQMPDfZSAEqwuSQ/e2NwEZlsgvDyQdSymlk/MGwIFVQuu4S4OX5pW2r5b0h2Jpc2FY6gXxlUfoRJAPrEpebdbcE3PeGCkVINB6jn4dbuZ2PHNPL3ys+s/ccKMO2ZQMuzuFId68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fElF9+T/nB4BJq+4k9x/GUDF3NmqQ481IC8N+Jnh4RA=;
 b=lRCw4AYpL/BV17CoD+ZmBuwivGWMjr/Y+CqDojyM+FFxMYEnBJ4SF1gnFAJ273kjZRhcBNB1cCND3gB8uRCzgo5c7iKg9sQLEvFyl5P2b7uePHwaqC2jZB8K6HtLlPeaCfezBoq7kcc3BnxglmMyBmx5r/Br5CQ7itoh8xVWZK34Ey823oRgqN1cvUAJMfYVsp5CAMZANAEHXJ7b5ZnVCPCSI+X1V0Mpyb+llyUHc5IZIrDLNvboOXhuVVeuw4WPg6hk3bC49GbQtarvh2bzAbLiBg+XX2VBGJwyiaWVv0JRBO2Udatg2t1XJcoVVdy7Hyb3xopET3CTStdq/XFRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fElF9+T/nB4BJq+4k9x/GUDF3NmqQ481IC8N+Jnh4RA=;
 b=WocMDh+DKvGV2ScE+zIwvc5ZfcI3pNhBhJdjI+QyDQ0JaVXCHUQFPk/kikcLjK/bc3ogKGLtRWvLcXFstjkfrQbBb2NR2uvOSwHCEOA9ENXvaXhB697z4B8cv7kgAYgOZjZfHis+JEZgSsI0xX1LwK+YOeH7KHT+pomlNO9GMnqvqKGYfsngiRyZE5vf64rqgO2gCSQJBdoaFPGzs7CYxIxEM77tgm2EnNELxd6UB9xr9BHHYQYOX5AhN4vnxl4EZyPDrVjh9HEVMCoRQ5JYhUb78NUqf0u9diKZ7RbdCQ0EtCgkJPTgV5vrHGV4Y/LaP/JZPkbjRVeTRSo8ACp+/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 18:01:37 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:01:36 +0000
Date: Tue, 10 Nov 2026 13:01:35 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	jorge.lopez2@hp.com, hansg@kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	platform-driver-x86@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v1 1/1] string: Export strnchrnul()
Message-ID: <avNb_7QmpPkxa8xq@yury>
References: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:32b::13) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b20ce5-6b2c-4026-4ab2-08df3f54a9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|261026121527099003|11063799006|56012099006|261021121427099003|261009223027099003|261022075727099003|261102123227099003|261102130727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	JCRojQbe95j11M7K1N20mMMaTaYRoXlv+kMV8HbUv9wMgwoPBLxoe2hj91Hm1vWg3BzYhxfr68U94dAKRH6LVQD1wK0ag9E/WM4vVOzqYCdrWd0lLNPeHQjYq+OpxIf9f5T3MkIjSZ+6INdt5AFjhVuta54hLnH4D2L/qdyF/DMa08I3/M61yGqKCUXaidD0qia+PwX9NK7X8R219zVpMTN/x9skJyHe7gd/SoGF5q7BMQksY86TCZFOm0T3VEOS8l3BRiz5A1BH9H+1Qe/IaR9Esjp+qFowyYyAllfZ0M+wM7aPrD8f8/zxirg1k1PB4w2cwcXIv8pig1CRNRBh7jTPdr3/+yEUPlqQXmJ3koe2eb2cJ0BYFQjtIzZEn8rnm3mapSmdI5oSy6NnjvczYdodl8F0F3ZuVYQlH3rN28gtb5iM+AXnZd0v+bAZuxVWD5L5VAiFPVBq/DXWu8rGCDYKZ8t/bq95wx9TcXbVNvr82zUiEigHr53Tk+0pLan7ofrt7iEmHkFkaR07szyFdVtFtpcYo+jAyqj9SucWExhe4HAerf8e8dRA+XKcK04Qrtv3Dx005Wkizkfc+GU+aUrdKFfwvqctFV4uTd1tmLHmXR6NRbnkadxOQo7xq8EDF5YnkuhIExGIq4r8uqfUO2q67mdz/d8DGkHrRPhY4Lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(261026121527099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(261102130727099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?40xUmc7AWpP26Z4l3D1VAWuZe9sTkjUHkk/E3puU9IfOFbObZkIdcZpH/8am?=
 =?us-ascii?Q?w6GdcJhosiPGakvNADqeJoMvIQNs1oVShR271IZNOceJI4YCxM3GVowUQ8b6?=
 =?us-ascii?Q?7tXSOfbP09RyqVRsF0HXwa5ICjvPUMs0zjEYSlkcRqGAkJL9KyR+O0whYddL?=
 =?us-ascii?Q?I6qV7qlBfdb0syJxKzn+UDhU9XvhdchDCqDQQWYFWqDdlsJ8Vxq689t0597g?=
 =?us-ascii?Q?0h9ZlRo7lBdgpM60Mjc1ZNyGLSTNO6J5lkHhZutOWozA5rooyC4eKkYs5u+6?=
 =?us-ascii?Q?WGTu1S+pUMaI5ie+18s1joFG4P8MWwNobn8QUf3nAbFXZo9VyxG7NdP7Ga94?=
 =?us-ascii?Q?C1kg/e34oAjISUFRPVyHllg7/JdwfUnLNMcCKtRXbcrrP6OSDgBzT+UgLN0k?=
 =?us-ascii?Q?1RdYfbQBHF922L/Zh73qzFEsHSQQaQfeM3I9HBgcXCZoh3qdrNcWBFqN/8aH?=
 =?us-ascii?Q?3iBXcki2rTJqsxlsSjXxxAgjjMg1lVnOnP3RLxRzEVy5BJ4GzstJA8xi5hvD?=
 =?us-ascii?Q?odniV9hh4k7qqfnsYuUx8sUkAbN5To/PJA269QI9pPbkJL/mvikIUsNRWz8q?=
 =?us-ascii?Q?yUHxdLlhCRNZs5A5oYkFTlxHI/gUqljxBBJq6n1Z8m8BmZQq5igS6eghIGIw?=
 =?us-ascii?Q?IRu5lhCwKFOxJOPYGDwb7XtbWZQk9J/ZJJIOLvbsNJrom09+p665eeK/QRac?=
 =?us-ascii?Q?/t+hqhRmYhrP2CozrqOXlXpMH4/zrgjx+CU4wclxr97NSQaqUHVH6F9ZstO4?=
 =?us-ascii?Q?CuCx6+bhLWMaVp8g6GcfzK56hy0+PJi+UuVCVAckOGfbodBmi4H1njAAuxLP?=
 =?us-ascii?Q?7YYxy5ndhrd50aLveTqFJlvLCQJ/+3YMiQCPyCHoyw/s8Y4Di/RMHWjijMhx?=
 =?us-ascii?Q?QWnUIhPnHdxYrkSIF/Use7/O1E5Uxc7IcWD5S0mF2UeMZTS/LbQXJhaDv64j?=
 =?us-ascii?Q?1H6hcAuEZSjfUOgqlyITXGnR9WNUgCpwIYek6UYHL30NGYcUMLutmQ9F6DTt?=
 =?us-ascii?Q?mKZ3dxkWh6xNf2QmUpqnVnlf80lHVGrQC20Ch+BDAc+Wqw9fLyIRBr/hlein?=
 =?us-ascii?Q?1kbtUnH9Z/5ydh/4epLp1/4uFCY4sUZsjjL4bOCY3r0TNaga8pZ78vqYdguR?=
 =?us-ascii?Q?7IGIbcj4wSPi/K45RP3egixEjKBOV0kcSxWse1pJtghb1Q2FwHLKpTSRkv8X?=
 =?us-ascii?Q?fHP4XofvYEzpFQBJspiF0C7TA7RCxe8mvwZsJSqB3VUw228bAbeGV4rFZBvD?=
 =?us-ascii?Q?gz6qpacroeFad+Cx20zXz48QVMUlUfjVVL3JcmkS/IyLrJFA/s/aK0causH5?=
 =?us-ascii?Q?b90tcsdedfUDhnSe8J3jBp7xr3Gm7Opid7imY31tSDHdbIUg1X9cgc9HT+CO?=
 =?us-ascii?Q?sz+iFMwrl1k34oMzcx53zYDC8S/yjh3hw6KTsR1Ts4q96il9EVqRgPSTCyX8?=
 =?us-ascii?Q?Cyxn9vJihBmqiY3g/NIisJK1LSP8abtBdzJF4GJ7JILx28dqqyozkC1M2To+?=
 =?us-ascii?Q?u8ipb3MPKQIgxW+hiTctyUSfhYI3WLrKLZqabptYVsxkgDNPziAryovg4B36?=
 =?us-ascii?Q?7TGpofl2Wrvh9qbFfOOm4gnjxi8JYLOK0C5YdnJk35aQFB/7f02vwmpZZ+bp?=
 =?us-ascii?Q?6NzUVcA8fHD/PWtFERvw81Y+8VuH/Pm9YMKZeOydfy22esVECW+Dq90+BaUb?=
 =?us-ascii?Q?mZe+ZSucX/bouYrCwpSK7f1JJX/B+fVXfYOEQRNGy/eA5So1FjfnZI4o6juA?=
 =?us-ascii?Q?49bO1PIjufOuWX6kE2pJrwN7njIhgmOXioUmeIn7x6CEq7zR9M9/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b20ce5-6b2c-4026-4ab2-08df3f54a9af
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:01:36.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EF5j/G+OI+v3fpCvWDhd4GOv2t05BMpza6L++VwnXi7yMJB5uZGdKmTOfuIiXpoGIIVFwM3/Rw6bYrs1njvePQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454

On Tue, Nov 10, 2026 at 05:41:50PM +0100, Andy Shevchenko wrote:
> Export strnchrnul() for users that may be compiled as modules.
> 
> Reported-by: Armin Wolf <W_Armin@gmx.de>
> Closes: https://lore.kernel.org/r/1969fb5a-38ef-4b4b-9d2f-cb9a4348b968@gmx.de
> Fixes: 0bee0cece2a6 ("lib/string: add strnchrnul()")

Not sure that exporting a symbol is actually a fix. It rather looks
like a normal development. Also, I'd like to have this patch attached
to the PDx86 or whatever series that uses it.

Their implementation may change, so this would become the exported
symbols space bloat.

Thanks,
Yury

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Assumed to go via PDx86 where the first (wow!) module user wants to use it.
> 
>  lib/string.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/string.c b/lib/string.c
> index a3778d5aab4a..cc8982a93afc 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -352,6 +352,7 @@ char *strnchrnul(const char *s, size_t count, int c)
>  		s++;
>  	return (char *)s;
>  }
> +EXPORT_SYMBOL(strnchrnul);
>  
>  #ifndef __HAVE_ARCH_STRRCHR
>  /**
> -- 
> 2.50.1
> 
