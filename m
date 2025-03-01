Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6D1ADC9B;
	Sat,  1 Mar 2025 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740848743; cv=fail; b=tLrLiNImfCgyI4/zoBWiZHbyeL1AvIuW7JKTda9BoohpFmF5ZJFDB09ukOoDHbvnNbsgQI5Gqfy9qu9LIy6NdweE/kGuXg3fmg7EmheGlSTYGwfS46AQh4YrYn3AIFyJloUS1E2w5oBxXoVJuHTTle3vOJ3+nbbSkAarNtTscPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740848743; c=relaxed/simple;
	bh=DnB5zRhATEXNx7Xe8v/JF755/pv2kchP1ha/1j/kOCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WFlxfw2fX6OZZzMcPgV4qOiOnZDk70KXlX04fVvuiPOcsGSlbog/QzNhZ97j6tTeKagpWiagNg8kPFvQAkQIhMnq2iF0bjrrvGg7WU3AnYHeCTNjzjLyh9eFoV89gQ7vyr5KNOg1jEpLnbTE3r7DniYsT0SZEhZ1MrUS4qEwCZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fNIkCqGy; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fNIkCqGy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeUvIXrR4phHnGv3yx7nbGm2BagSOvN30wF6zK2WtEHYt+vrfE6M3QZTNwwcKPyDANUdQKFvDX/MZwXYW5lW/r+NxKPUGIGEDUwNfGBjlhCfRFLvX6cTG0ZiVuycWqOdyXj1l6O8Ta9FdEVeetKofPwl5lIgtlPKExgfg9vL9FXHl1oUiw4dBFXJ5YFnepLAvnAuEuc66rZ8+R06godrY81zN4zGUCNkBNRPiiXouYXR1C5AWTYzwIPSUa5CWBZxQRa1KrVbHOZVqatmsALaL9YeB5CmBy+h9mjyLCVeLBDYT2AhzQWGvXAwDWhQog0lajPijI2nGzl9UC1dyZZLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUx59qNvUxE7pPynMFDCC3s1dmSGA6MjVmm0sIm7lMg=;
 b=DJcv/EmTQSXNiZ/Ij+cnTUBEywOGEl8hANpYeSWomd8gO2fOCLy4dx6HC9peN3rYYmp4B8GOa5gjRC3nfu2EiOo3e76qF6qCcj7ftEO4QFeuwejIezmM/11IjWPVV4+eusLYDVIGfIdxNFvqgq7jjGl7RoLRXlaemwGxFxXikOc2tyg0WYjzMwxDw/R+1boVFj/Mm1gPrwN6ZgehYY66qhOSD5V/xujm2Z2giYrjnXcYwhFp+vLfi5SuMzbGK5+W5HJprI77FSLX4cGvfJ6gcFLGKSpPV0nQUpSoiTGVzxGrlqS4R/U8Nih9pBLWvzMRPlfSqhM2QkmREiV1Ao4X1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUx59qNvUxE7pPynMFDCC3s1dmSGA6MjVmm0sIm7lMg=;
 b=fNIkCqGytNSJMWKItffCRSgCfnvezBIJSszMt442Zb94B2TjhhLL7NdmEgL/OGXB7zwXst0ECXpbu7uO9F3eycqy/YO/+viSodzyYTofER7w1dY64rUiJTSr4p5r2LlLSQJF5me2DOZjhhc+u2RIrlZwvXkak1umyxbzFGKiQ51N6bST7CRkBaFqXAbQy9n5dV0wCMzCNLFq1GV2RG7C9cGI0bgg7k84wkQN+R3h3y+7FFznDQ2e6BmM6LFRsYahdiOX2ZQ8dx/5eKVL0rGoJ2TV5tweXueB7nLBHtLwr2wdmuMvsu0sqpEDR0nJ7EGwvmJzj+EgmIRDq90rnzp5Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 17:05:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.025; Sat, 1 Mar 2025
 17:05:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: fix uninitialized scalar variable
Date: Sat, 01 Mar 2025 12:05:36 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <B024C29C-96D4-4F92-B2EF-F01CB06B27DF@nvidia.com>
In-Reply-To: <20250301-entry_order_uninit-v1-1-3543b4e3fb28@ethancedwards.com>
References: <20250301-entry_order_uninit-v1-1-3543b4e3fb28@ethancedwards.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:408:e6::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec76541-f080-4362-f9ff-08dd58e34a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2890/TKBaVRwVMBw2rj6vhCkDjYjH9B9gu7d53q8LBdI69n8I+7FF4R0UFv6?=
 =?us-ascii?Q?UScup3dMyOzXMEst9uN5q1oS+Z48BncVPFTvCqndIISt8FOZ2zr//+kHvB2E?=
 =?us-ascii?Q?j9iGQ9UlWvX2+FDVMARL9Y1qlbLchbFC4oCDVBmLbRci3UQ3FbCm3AAIolz3?=
 =?us-ascii?Q?V3/paDfc3YHbtAnpqq6ZiJ6ncQouFnpg3v6rlziD8vaGdmIKUS9uoqjZ/hKs?=
 =?us-ascii?Q?3jM+lWel5Lgqn+2JGhKHKpsOY+iszHz/QWyp332aQq8PXF+QqavL+T6FaQR2?=
 =?us-ascii?Q?Gu/hJMIhhSXy5dIBTSYEDY3wrsuOwSMMGiN+9Ljs85kLemratj8CdXj/wb1Z?=
 =?us-ascii?Q?sF4+BNBEy/4K6uuZExji1fE+vh/Vleq/m1fT7PAM7lkjZroKyBCyhV6XZmG8?=
 =?us-ascii?Q?CPaC6vi+dROQtUz61N7e5h26paAJ5NZhpmj20pLtYZsga+TUSieV1E9gR7Ry?=
 =?us-ascii?Q?E/z5DraasasIgvXqb1ky/4tgxR95ayIdDcb6Utglb6hHVPFEnJZ/Jnqz0oJU?=
 =?us-ascii?Q?WKqsHW9tjkKyGoDZ/MZPVNhk1JycBmn60vPvEFimvFHH7l9/2Bv+9Mqvh/BR?=
 =?us-ascii?Q?Ox5tQ+ZiDfcSKtNP+Mr4FnNuEwluy/yT7tCdfVApaXWcl5S1S4kdeDnBCoNM?=
 =?us-ascii?Q?1bqH6uQ/zILrv7vf26gmN1YJ3C6ui5iN9Yh8T9cAYSU6hiNfhq+nJYviYVpq?=
 =?us-ascii?Q?3T7y5FHSgrKkcc53K+nqzZcW+A//cBzif4vAzCSLCpkdTo06hJRXo5h8nAGR?=
 =?us-ascii?Q?Xxldyeiy4bpzE71gW1kOVsCkoc7/COnA+VUnv0b3efcO+orTWgQHQR3JbR4U?=
 =?us-ascii?Q?DlIRdEvb9JhNzY3dw522jBiizS5wmiop6V8L7OfnwMRwbqb2HmHTMEOzx3NQ?=
 =?us-ascii?Q?5ljeA8fXvbbvc9lMelz3nUchijV1zqR2A2V115W6tezZhj1xv6YftfCO93p3?=
 =?us-ascii?Q?gQvII3CxfDMEaVgQ+W3xZa+t5U5mpSCLLYb5i2DQuU5FBI/wJDXGVhwU3Zo2?=
 =?us-ascii?Q?svY49oyEgs8675gTUQJzjhFvhXv5peDQyEL01IZLr0ij6O9o350IM2Z2gBun?=
 =?us-ascii?Q?2vkwsL0LCvE8gXiwQrk86uiCXWaWLgCl25qNpIlFGvJy7CWUbYz1QVVWlcfl?=
 =?us-ascii?Q?LEQyPUuLIu81ytxQ8Vxd4QotiH9Hp3yGNaKXhIdQtYhI8Ns59XQ2q3Px0aec?=
 =?us-ascii?Q?KO1k0GTi8olGGrFqHUq5F8sO2PGlRqgOvBGYx12sGj7uuRZvMQ3AFGtlFdxS?=
 =?us-ascii?Q?nnKap+jc68DeCxQ+nWnv0PwiLAtlTfL/f2QDK57pFvmYRn74Uq2IuRLOgNvv?=
 =?us-ascii?Q?7XWlg5IFyUg5jAbtBwCrMNVUyQNEXHdBGJcINDqoMz8q9YsqzPtQkVPclt9J?=
 =?us-ascii?Q?mzj9Jt+aBPIQELmr0xarq+1Dx5TN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNRExXB+/dpvGBQp70utnP8Z/kyfrLqFakvwQR7cmw/kxnysKeqi94XcwpnE?=
 =?us-ascii?Q?dlPbax6/ww4HMT2eiMOQgwfk8xeQT89Zxb+1eLpztTjDzl6SEmVgFoBosLt5?=
 =?us-ascii?Q?c6vtayM+jz5O6B0CteMgyHa4kzmGX2gqNgBDY9t6cZp66bavW2Scj3PnP+EL?=
 =?us-ascii?Q?bFdmsxJs0LNnY0xdWsZTumsIi4eixYUbakNHKbI5AHbh2VkBvfGsH0YmtMmr?=
 =?us-ascii?Q?dCs//rYN/V2n+MYcb9dS6HuXgPnufgVnffEhLRhf+JfS6YfH9pfHs1uPI5MU?=
 =?us-ascii?Q?ywTBDE6w543lsZgQRumlFEbrxcnkZ36elizRyxpxlZuycF4qq+NzYtzJQ0B/?=
 =?us-ascii?Q?ulk4F2j8iNa2lRGZgsV0GL1JHfgYbDOZx5glOb+LnvwG3OsPXw+p38QlmgbD?=
 =?us-ascii?Q?hA3Kh6FDkT09naP6WNnUURnnMsNpzsAKcgFp6/B7KeX4fqTXfWlqUYHlDupc?=
 =?us-ascii?Q?a+UwH75TPsit1gJ/gD81yNDbtM5W6I8BtEYFOkZb83UQMPRhGMNLW8ATo3rQ?=
 =?us-ascii?Q?Z+vQ+19ddUqNKwhR8aMb0navjinjJryFf9eCsnKdq2WwxjYu1cGLxP8wxe8D?=
 =?us-ascii?Q?59XRDJuuf4UnZu3+gvef2kwngh+7HVQs3vF4TzmRuSKxiRYR2w5Z63aSa70/?=
 =?us-ascii?Q?yNxXDxCIxvz8KMhFBby5ymKFiCTT/qsXRJZiLoU1l2yVAeO+QmULtEON+JTm?=
 =?us-ascii?Q?jLX4r9QBpSjDR1OPzMONVQbudiOaUq34hyFSXX4XRYbGpquv9j+ZixH0fAe4?=
 =?us-ascii?Q?TpPiu7LaECq7kNNTLzeJpVO8arTiD/jMWw8BjSFpiLm6H+g5w8+9kLy9sjWI?=
 =?us-ascii?Q?810MH80hmbAwSDF0r9OkJt7WaOtr3k7PwiBDRs4eEkYXKmcqsPR8m2ziWK1p?=
 =?us-ascii?Q?vi/atpbkVty+FGouFYbvT6fSP1xAaMOHFa73vYCj7HBwS+Ww5kfgBr3M8MHw?=
 =?us-ascii?Q?60bHZQ+1UgD4bAP0x1p4M4EhrywP2/EYklVV5VbfCAmpqtKIy3jUxR4diAbN?=
 =?us-ascii?Q?+4BL8Ls5o/pYaDUEdLeSUdisNPt51lYZT6UffqWDs1EZLdjeLRDBXEoJhh6K?=
 =?us-ascii?Q?0ahQkiJUovdJkee2NsakbXyqcnQ5dE1Pnzbv93WBw9zdJfDD1r26+UuaKP5Z?=
 =?us-ascii?Q?Lq+XbE9U/XmSIf+9lVhD+xqSjSmL+QoY03E1iLne6e2P3BU96VUYzJ4f3Gt6?=
 =?us-ascii?Q?C1h5fFDP67kxhZ3BfqQlYOXl4OCjYxccaH082oOPZN1iKiFNw6VrM8mK+OlE?=
 =?us-ascii?Q?Vmz90dLgN34JXGKmpqMSw0JdWgmeBZVehxSBzPk2fIwMRNeGNVG53Kk7u6Qy?=
 =?us-ascii?Q?Ymc4xwwtYO1fA4pspS3goX9xE3glL9PJiUFrZNAtotZwty3q0HV4Clspaq19?=
 =?us-ascii?Q?upL3D/8ziz2X/7Y84ELnBUoijcDc1/sDiROMPNMwiVl8Ieqi8jLnW8Afz5Ko?=
 =?us-ascii?Q?HdA07WO95mucXotcNOBnXBcL93I3nL0deVHqOskDe9PpTYnfMRsxvzo/UNI1?=
 =?us-ascii?Q?6WoHbwqGve7m6bav6t4XbuNH4seZ3J7o9EPPaaSoIF5hCBIUiKGwcrsaLflo?=
 =?us-ascii?Q?OI5c1g+mWdOYj9yzf5s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec76541-f080-4362-f9ff-08dd58e34a37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 17:05:38.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ol1oFMttlZ2y2mSau1S9Cj2n8dGPH8MJo2Mj0kFbyUb6An+wffE6DYEOumCReePC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715

On 1 Mar 2025, at 11:57, Ethan Carter Edwards wrote:

> int entry_order has the possibility of being uninitialized when
> returning. Initializing it to zero at declaration appeases coverity and=

> reduces risk of returning nonsense.

How come?

After entry_order is declared, for (;;) begins. The first branch
is "if (!xa_is_value(old) || swp_to_radix_entry(swap) !=3D old)", in
the then case, xas_set_err(&xas, -EEXIST), which makes
"if (!xas_nomem(&xas, gfp))" at the end of the for loop to break.
Then "if (xas_error(&xas))" will return -EEXIST. If the first then branch=

is not taken, entry_order is assigned to xas_get_order(&xas).

Which code path would make entry_order uninitialized?

Thanks.

>
> Closes: https://scan7.scan.coverity.com/#/project-view/53698/11354?sele=
ctedIssue=3D1637878
> Fixes: 6dbc440b79b6 ("mm/shmem: use xas_try_split() in shmem_split_larg=
e_entry()")
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  mm/shmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d19d33e98320d5e0ccbc86616bb3ea30d29f0cc1..3718c71aba9304dd3ca8df1=
37a19e0564b8aadb2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2153,7 +2153,8 @@ static int shmem_split_large_entry(struct inode *=
inode, pgoff_t index,
>  {
>  	struct address_space *mapping =3D inode->i_mapping;
>  	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
> -	int split_order =3D 0, entry_order;
> +	int split_order =3D 0;
> +	int entry_order =3D 0;
>  	int i;
>
>  	/* Convert user data gfp flags to xarray node gfp flags */
>
> ---
> base-commit: c0eb65494e59d9834af7cbad983629e9017b25a1
> change-id: 20250301-entry_order_uninit-129251b1ac9f
>
> Best regards,
> -- =

> Ethan Carter Edwards <ethan@ethancedwards.com>

--
Best Regards,
Yan, Zi
