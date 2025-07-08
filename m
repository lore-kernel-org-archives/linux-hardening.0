Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6CA14AA9
	for <linux-hardening@vger.kernel.org>; Tue,  8 Jul 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979684; cv=fail; b=LewQlN/kCf+npamtb62oAces69WjKFJvU8+g7rslvqfjATsoBZk+XPDX/MsxsKBxP/GLF7Gn8IqEtFQaIghLKr250efu6vI4EluqdmTGN43bqgW95Ob8fv5nyJvePRYkAI7oteFwQUXfLrbfeoqt2qgqK09yKzTxHeOYIsQaofo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979684; c=relaxed/simple;
	bh=E/v9K5NngfOFkoEPu0OV4GLJpguon2YImvktMuFVbUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FWmxVr8UO5G1rJ9IMKhwYZ54Rh0iEg3n3qTe69pApPrSs7czoGMZrJXFr/nyploCWjUZxhZYwjX/vRJIQPQUFUfw8blQCuxEypPHbletP48dWvLd7/PrM0+YXbbQcE82lJjel4KjNzo/2MwuNvm6voqXc7AoiNE1Kp95PxgTV6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TttV9l7/; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TttV9l7/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/Mk5rLSSKitvJJa50snnXOG7knQaKyG3Qy3s/Zr0C/0xfCDMYzfcXBvFCcTwU9lpiIC49rkqK3EsGkTLGsaObS8tzDNtoiJKPHPuirnuct+11AcWXWI28Thy5Jk6jLsFzRtTROCqTr5kdhhbu2VsBUC/ytZ+HhdY6m18ph76uU4aEPIGLuWNwO64NM64OAmjCivs90w6NHJ6eJyjFEjgEwa4rcml1FCVASK0a4c9+QJrBqA+hGxLrQa3GtcsUQWjhzRJzqVcn2LIhqT4cs8nYkgcUTjcLpkF7qir11qYeFRMKQSTDOSB0UXheEpR+eim8YiOeZRZhZ9eOi2sjTpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFFIJopX/Ahf/9K05QqdkkYPs2eDLRq/iVRwCC+142s=;
 b=ptgFvvu1vpNo6W51Bw2FxOUg6G7i/qlABlVsfXvpq18XGyU38ezoxHuX9ZHdwGl12Ei8wkC5QCYAuP4/zumD+O+GS2AuOB+Is3QAsDuKsS4OcmSc2uMumBt56+5PsTzcNJbN6cCr8SabSynRk1mzK28HZFoR419djSCiRjxwTHrwXpy+fgTQFiuB7ZlykCPMF7cerpWTo5fyEoywO0kM8mSegoxTTDR7QDjWL+KZckSVE7MuE9KwcnJ//YFFPo5DhnjGw75ILAYcAw9NKxh/tVXrqR4XmL7vanRhnjCrVL2UEzDRk5cNJz/pXjlZWdz0DymrlATj4cLdS9eDi52vXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFFIJopX/Ahf/9K05QqdkkYPs2eDLRq/iVRwCC+142s=;
 b=TttV9l7/wBUPf6Wkpo3hmJxZj7W4mBrTb0DgqC08oByXN5q+9ciCErP38K3/9V5bvqcxOM73KZw7PWAf4GWPDh6Y0VjaPjS0JXyqL+gONPlL9TIqXp7JRg7YLpScSgqUjd1xiFaSEJzQdgxoK6eqrEWcdgSDcxvu5XNluHV9G6+EcWa+Yw4wCA0PEnG0vFk3C/jS7h53wg6JgW/jiHxpK7CcoJWsoQHJfhGKAO96Ov0ypzl129U0PzRsxwjlN5IXqrwu/HgT8t/Q91OxbrBaFo/7wayRalJZQc5jP0zTCyfJBagz9H3+mfyX8cFCaKsNLCfBBG/AbtV073/k0rTfzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 13:01:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:01:16 +0000
Date: Tue, 8 Jul 2025 10:01:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: kees@kernel.org, linux-hardening@vger.kernel.org, gustavoars@kernel.org,
	leon@kernel.org, sleybo@amazon.com, matua@amazon.com
Subject: Re: [PATCH][next] overflow: Add safe add/sub and compare helpers
Message-ID: <20250708130114.GX1410929@nvidia.com>
References: <20250707201155.16874-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707201155.16874-1-mrgolin@amazon.com>
X-ClientProxiedBy: BN9PR03CA0854.namprd03.prod.outlook.com
 (2603:10b6:408:13d::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 919b189f-7fc5-42df-a690-08ddbe1f8647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tzXaTRKbWtRy+p+E5ezTssNmyv/uRZawPCSQAjaa71Sbm4rg+R6xMuZGWbXh?=
 =?us-ascii?Q?RnW92bk87ncm8wWsX6HuLWyGeTichoE+mKFxqzTk5dcl5920VtBLU8GLdG76?=
 =?us-ascii?Q?hEWcwWg86NOmiCuSJNLeybU4ubN7/Y2WhHz/c6ntH+1gaoywM2IgoZLsfa4B?=
 =?us-ascii?Q?PmTy96yNRm8xw8QDMHPecppj+tWXepzbNhn0j/chtu/OwO06BN1WMj5bAxqp?=
 =?us-ascii?Q?gcYK1kFvlozH/JtcURSR4h/ITnbjNUcCGuYd2w27W0LLT7swgUMvTrQ+Axov?=
 =?us-ascii?Q?iJRiyVFsoJH83MuMbIiNLjKSTH6HJ0v9SkGSzqfsL2mr1C93ADTAAI3KFj38?=
 =?us-ascii?Q?SQPDiyZteNk5jFWMwlTupDEfWFuCmH4YDzRMWJKulRh55O2BD56qckVbMqbb?=
 =?us-ascii?Q?3WhzhUbY4gEG7ZBgomLOcTxW3VTj5rP9yPXvzBjaTWFcRzetTdljP5VXUYTv?=
 =?us-ascii?Q?jDrECshQZ+OQ2CzI7h6pdwIzNDGGsTX0Yg+OUnOJcDcCzern39M8Vy4X9Znu?=
 =?us-ascii?Q?V9M2uV2nT6hZpgbWZ/o7hFwegYMGFuxEmE8dq3jw7NVJts/pZGBgQB31bc/t?=
 =?us-ascii?Q?ZksqvlAM6Qek7rYJkmHHPTdYbr9gwox/d47aVjZNi/mFJIVvM/tROca8VUUA?=
 =?us-ascii?Q?AxaVHws131SrfATN2SLx6ILbSENV7nXVGT7l+1W7srKBvqbwfeyaS20X3LmW?=
 =?us-ascii?Q?S/SwlGi9Kz7Av1iBDKK8JNwszPr0M/sFgOi+dNmdR0mJzf3UVxjlu00/P6Vv?=
 =?us-ascii?Q?gBacMqfGs8dQxrzc3rl10qdrtCfxRrMUiXxt98DbgPtdZzdpQqfV5CpmZNFt?=
 =?us-ascii?Q?ZCX1ySJb1f1dCrCKeOQdFU8cfBD0WMB6Z/89n6SWmmcLixjtrrNKwb5CgOwG?=
 =?us-ascii?Q?LlqBX2LBxes/T/AjTpA4v5KAwTvkIEImA++tvN2Dlcimpfu6WHp644tMRvCq?=
 =?us-ascii?Q?KjwiXCcNfXm9QM/UMlHrPXTQn9j20fDlwXZc0lhmm5nnNkiNMc0svLqD2BM+?=
 =?us-ascii?Q?f2DhLZoq4k51XV+Hp0i6cHR/lZqeSnXNCto4t5nrqW7DJyW8p9dZL74wHQeR?=
 =?us-ascii?Q?7WF0akqzciWkKRdQeByILzPvdsO+23DnhFsVR9ca1WAYIvi5Eb/bJWlgGLQr?=
 =?us-ascii?Q?+zQF8jKIAv5wYYfTkNTOZR8/vdT258P5FuoIb6QfrS1NORwt544GaHjUJuqn?=
 =?us-ascii?Q?JTfV+AJmu8HMIfJ2LXf4M1B14oDQtHVlUC7KnCFM2OJ+mn9EHsDD8IDbHJhP?=
 =?us-ascii?Q?6sOnac6hj1vusqH1DVQ+KcYMTzXLpWWYFNuZqHlO3F6J9zbiw5jz/NkjemRu?=
 =?us-ascii?Q?TYtIJTFjOtsoXJQtskrqG5e6oEbTm0CFjfvKdHre8YLwAdokAbc+KgfiVRJN?=
 =?us-ascii?Q?tduMoYLizZMQ4dAQ89d+phJhjXSJIjpNoT0+EjjbputyDVTQJAs9eLKrR2AP?=
 =?us-ascii?Q?DxqYO1o8KN4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9uRnbhbiZHX+qiGVcgjtsUQdMNjTSGNIxfbWhYwNKxH4/iunz0xF4tiZ8eU?=
 =?us-ascii?Q?8dzy96If67V+SGaxeNgnPRKDvpeS/uCcoSj5QU65GoypdveB6hRb543KHZCO?=
 =?us-ascii?Q?/PGieIqws25HpiduVGg1xw+OyAu3BUhOq6WKNS10W8QIZbkVIgc8Rw1iV2Az?=
 =?us-ascii?Q?7llipXtrxmVBLrEfxqc/aIRwK+Co/iotC7uPxtHS6X3TVRra9tHBwZkHUBLx?=
 =?us-ascii?Q?SrmmDnqt1bbBUW+SeRKKc1a3YbRJeapjpNIcyd3KKEVD++NbvIYSzBrqs+Hj?=
 =?us-ascii?Q?MiRv+RTT27YnZYxzvIkUaBIDIukjZ52W8OmkYt81Rlqcuqc4f53SAcltXxUA?=
 =?us-ascii?Q?ButJvIUamhgB1vILmKj2DYtS1k6Asldq+gBoLtJbW83sRTjOTVDQYPPhHBao?=
 =?us-ascii?Q?UzZkmps65NBi33a0Q5l7+TsVWLRkysrjXE6Xc3y+jk3LoP3zhRopCOS8qe18?=
 =?us-ascii?Q?jX7PTZZvp0TQRl6EJUdrCF35REBvyJ4JMe/aSblY5BV++ozQK/NuIDEpGj21?=
 =?us-ascii?Q?EgFbgAPeRY0+LEmONP06YWM7rouZ0N8QkstY9aDMx+c2pwwFH1l7rgo0/KdN?=
 =?us-ascii?Q?JvhFPJ2RBz9Yj0lmJB3f8sDjXfRIIgk2zuqGrLi1u17/v+OfTXbNZMj9GBQX?=
 =?us-ascii?Q?YosoU/F1/ZNbzwwvbz41RSeqEHuJGj25QHpm4CWvIABY+xYIcdb0iBXvltFT?=
 =?us-ascii?Q?cdNT6FxmLdIZ1fd971Gevnxg/Xzin8th57w43JED0woTWmWIqmF+vXZ3Nr7z?=
 =?us-ascii?Q?nDrMiamcoNtK81I1QH2mNh/WM3RVOrZSkLhOFuv+eYQkwa1tvRNH3jXngus0?=
 =?us-ascii?Q?J9rzKeBzCPRywSlO0QDnQOSQEiYvrCjYTKW5ulD4XdApl4wPnyZAAL66qppN?=
 =?us-ascii?Q?7XmsFpRjhCFplV4lugeym8lqm4LUJ0tVXbMMO0h/+SmIAti8JdU5AKfYARB5?=
 =?us-ascii?Q?719Dg6kUPxodH4U8B2tVxhyGHuBeNZpdNrxsilsz7sw/hlhlmHC1qLTchUXz?=
 =?us-ascii?Q?ixNFG8lAjGiPCdHBpuYJvh2NUOe14RWnKiWpArKFKgeiOt0M3pLdeC1OhRXG?=
 =?us-ascii?Q?3QT/y9M4x5EC2hluqZR+2a1+qWbazBdvG4jGT0lZXa1Tx9GYjiLQ7Pw02M89?=
 =?us-ascii?Q?jqQIjWmcxbdueH5qBQOR25sPeCuUWyftBfXLezM8PjYByJjSMl8vLmPlUPHi?=
 =?us-ascii?Q?YWvTRZRX98CUYmxDvd5NJbSi8owF3PhOfhQnnKw45CpvIEqNTnsVOUijRIIc?=
 =?us-ascii?Q?iJ6BhldqqnIb7QrVXYvDUsD8muymo+kRh6MAJYz/JGFopjsAM5cvC0ome3Ws?=
 =?us-ascii?Q?cMqcqPCOA0dgQ1Aj6keahNnWU1mML6JGHqEakjYbxzQS0f1fzh1GzykP278M?=
 =?us-ascii?Q?SmIHoo7wFdJkMKW953gX5jJc6vyZ1lcJr+0WE/oDrzWnkv2DF84xIjoRzhE3?=
 =?us-ascii?Q?yNlILhYXO7CvugExWRhkzWQ18A8kDbLzeY1HY9StjhicwOf+9q4/83u4Xn+o?=
 =?us-ascii?Q?SrTFrf/G6lXnkG6qZ9br7YuF+kpaVHtzbbpSU2/C1KKuUVNQB1E+WAnEgrjT?=
 =?us-ascii?Q?62O76m3O/WETHhf2VUY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919b189f-7fc5-42df-a690-08ddbe1f8647
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:01:16.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9hJHFHBXFnbpQMwIvXfJmUnLHnNtadm1c5s8VfzmC/cekfWHaB3F2D/9ynece01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969

On Mon, Jul 07, 2025 at 08:11:55PM +0000, Michael Margolin wrote:
> Following a discussion on changes in RDMA subsystem [1], there is a use
> for helpers that allow overflow safe comparison between the result of a
> sum or a diff between two variables and some third operand. The classic
> use case is checking that end address is in range, given start address
> and length, but there are probably others. Add helpers that perform
> mathematically correct comparison regardles of the types being used.
> 
> [1] https://lore.kernel.org/all/20250213144219.GB3754072@nvidia.com/
> 
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  include/linux/overflow.h   |  34 ++++++++
>  lib/tests/overflow_kunit.c | 171 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 205 insertions(+)

You should make this a series and add at least one user..

Jason
