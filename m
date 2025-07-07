Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FD81720;
	Mon,  7 Jul 2025 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896136; cv=fail; b=YM6HWyxqVs4KAydZ0TqlPtcl5qjSz2N1teEcDNKkuxFb/5WjyFMg0BgwKzSCUHYrKL4QF09DxOj56bpwabk5qBztTa6BW5ON/VznqybClUxD0qtUcvhFvFWUrxom3dlYEv2a+QV5wAbOiRoWbHm6+uqEU9F3tf8QxGIGD5LvTSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896136; c=relaxed/simple;
	bh=yor2LYWXI/jNvZPK4+s0+58K5N4qOR2iDuWV0MI0pfE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p99G9Wx71T1DrUa0FH4CYOafAwkrXVK+MxwBbBEQCzUAZg0mrF4RV2fBk1y2QjwWyxBdH5er8iHIa9qqMNOR54P4vzzkFANn1VFWJlrXHsx0i3+UZXzv55l0e+dd6FO+AG97pP8mqU6+ranjfgsYVUXtAliA3dT1saIukwM8XMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3AcNjj1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3AcNjj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751896134; x=1783432134;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yor2LYWXI/jNvZPK4+s0+58K5N4qOR2iDuWV0MI0pfE=;
  b=n3AcNjj1/vT0YMnr71CE07ffSbretU0drLZcK/D6zDKPVSPKfH6IgSv/
   J5Zg539BH0ThyQ1EtldsKzYgutIJYvuNmczbuQlTTR95fv9JnQpUuQiEx
   faIx30qx9Pf0xco/hx8Uo44QdhdsOwa3+bveF7BCw8apqL61sHspJtzZL
   eYPGz9X2Mg34iUTgLmTvwewTWeByapVMZDJtBypLMWQDmBsTLI9GozlKQ
   VxHu7F25eTYBQ+GlTtA1x7fsda0rkrcAS+cUSiSJKjfm/DVtqeZlOVKRE
   hHKGkqOs9mYw4WQ+h+mCIs4UyawPQ2UK7igDxOwXko9BqjMqa781y/89D
   Q==;
X-CSE-ConnectionGUID: aYEuMnoORie4wdr4bFTejQ==
X-CSE-MsgGUID: rfn3IQc/R5SET3fVkbremA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57785800"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="57785800"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 06:47:22 -0700
X-CSE-ConnectionGUID: iA1BzhXnRuqFKD6eL8V3hA==
X-CSE-MsgGUID: UyhxehemTZOYyZ34i1RKuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="159262163"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 06:47:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 06:47:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 06:47:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 06:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXJy9l7mXTLBNQhcJUoVsvKZKGAV8NEN9BfkxzGSsOUeLJOneECKp6w4Y6QYO7cRJXh/bAeQD4r7HnG/ts6gJW37qYXcLQFw9AwY9GMW747XAw4TMDZMmTLwCXrRyYknE0bOtK0ulHvH5othERFOMGoA5Xrh338bfEVwa3QXdeCaNDLGvT1peArb6VhOsgeoWloZvyS0w25cyOhQrRyfw3MjWzP7umQSAFGPtI5kruLyEM0ZcUu6q7/47UYehK4w8DY02M6KLe2i/qgCWJF2e1ioSqaHF97MTA5UFU2dkWph7bChXBb25lMSw/GkU2ZgsFHnVNdbmnjxX5UY4dL79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7UNoqDl3bFOIt/P8l/iYGEtAsZccOR/lmTN9VjuAsA=;
 b=kK7+8TjhTgT+HjAMBEc8la8uZK7k/T1ndbE8ks8JhdBTcDp8P1Z5yTB19gsoF1fa9FEvN+z5siF3roOMvcCZ9BNHwbc+LOIgc1E1CBfDemQqX18AQNJfB0hxPU0VF/183tMLEuT1X6XtZ4IgpjpGt7wsH74mvs6XiOhkQyFFI+Au50knfCmjMBRduCUD0jCQlIYcJDZ2u9E2LOJ8bBu6MtEBTR1fy23BaccdMNnD+/DLI47YO+fqBz4uBbM6Hh6eH/FUTAxootbgPfkK04jOhOjB+DcTwJbyFzAboQSMNLTuCsdIXoAt3xbu1O8ImHuvsNpUSocOzK2cbSBReJleXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 13:46:51 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 13:46:51 +0000
Message-ID: <f79a0c40-3dfc-475e-bc1c-d87b665a751f@intel.com>
Date: Mon, 7 Jul 2025 15:45:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][V2] fortify: add branch hints on unlikely fortify_panic
 paths
To: Colin Ian King <colin.i.king@gmail.com>
CC: Kees Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250707132340.1768807-1-colin.i.king@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250707132340.1768807-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0072.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f12963-b12e-4e93-3ad9-08ddbd5cb9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzRGcENWRUVUNXFQYjJIa3NjV0lpTDR3djJXMkEzUndSWDJCOUo0elExckhJ?=
 =?utf-8?B?RWVyK3NBc3FHbEYwNENyRlFUVTFFbk1aSmxlV0VtVk91Z1BJWGpaRi9Ua2xm?=
 =?utf-8?B?VEhNMmhjLzRIK3pJbjRKZ1Q0R3RkU2I0OUpaeXhXVFVFUEpWWmZ0aWVPcEtl?=
 =?utf-8?B?TmVpOU5lN1Z6VGJmUnRURDFFYXBVQllybmIyNGdONUVBdVFVT2pnOTRlSlZ3?=
 =?utf-8?B?N1diM3FrdXZSNERYa0M3Q0k5Y2U1OTNRTjQ5WGhFTlpCZ0U2UC9Ed0dPRXhu?=
 =?utf-8?B?MEZlRGpqOWl6b01ZNDFVcjJKSE51aHNPdlRhVTZuWWdrMmppSStCVXNOai9Y?=
 =?utf-8?B?QnN3MTJoNGY3N29tdUdsZlNaYTZ3c09GRTVycHdTRjBMZ1U3RUNxV0dyNlN2?=
 =?utf-8?B?bHZJcW4zYWVxK1Z3Q0JJemtSWm1TQVg3MTNMSkt5MTcrSEhGdndzM2lpYjZ3?=
 =?utf-8?B?NzBQcENHQ2UrS1ZCdklDU3dQanQ5MERqR1VSZUpsaTAwdWh2T1BQT2cram5Z?=
 =?utf-8?B?UnlvakIyY3BqdVFLSlRtazUzN2wrTmkydGJZUTNuUmcwVWZCM0d5T3RYUjdo?=
 =?utf-8?B?TEdRUzBVUkc5NEhVMm0wQTNnTUJBWENjVUxkbG9LOEIrNk1zT2M1SndsSUxK?=
 =?utf-8?B?RlpTZTQwNml4SlJnMkhiRmlHZ3BPV0g1bTJ4RENLYUovM2o5M1dKZkNJbjAv?=
 =?utf-8?B?QnFrNU8rbmk5L1hkbDVJZGZCL2R0TVA2TUZ1SGtVbzJudEhCazEzOXUxMU9E?=
 =?utf-8?B?Q0J1dlZnT3Q3Rko2OS9zTnljbFFab3Z6LzJ3QTZOMVZ5c1UyZ3E4alRCaExX?=
 =?utf-8?B?Mll6bWdubFh1L2pKTjkxM0ZwR3VsK1RtSDltQlhHM0R6QlhsYndCcVMvRFhE?=
 =?utf-8?B?YXAwS1JIM1dWS2RYYkhwT1pocXBMd2pRU0ZuUXVDWmxRRkxvL1hac2RteTgy?=
 =?utf-8?B?ZjRab0UveElGSEJoTkhYTE5yU2paQUNxMHNmNUFHL3UvVUh5SmJrQ1d0ckFI?=
 =?utf-8?B?ayt3Zis3ME5IMnVXMGdZV0YvSGFTQy9wR1B4N2RGejV3WHQ3RWFnN0dSQUVZ?=
 =?utf-8?B?MUl4L2xVS0dXMW1SQU9XMmVMWGdydnNvNE9oMGRGODFuMnJITFlDekxVeTBn?=
 =?utf-8?B?dGc2Q1JUNEE3c2RjSHRMd1VRbm90c25USlB5UmVVNFQwaEJTZXRXdTNPQ2ZU?=
 =?utf-8?B?cmhRSEpEeEI0ZDEzL1E3cnpSdCtHc2t2Q3ZDd1pCR2l4cStBY0FBbmt4R1oy?=
 =?utf-8?B?YklLUWt6eVFUc01sdHJ0bDA5MzZUQVFGd0FlZ21iYytvUFhBaUZ6bW5MVUZG?=
 =?utf-8?B?Z0JTV0R2QTV6dVc5MjRERDV6cDZyRWdlOVFvOWxOTWhTa3lJYjYzZitxcVkv?=
 =?utf-8?B?RVA0NktieUFzVEEwVmU4MXFnVjBQOElDbFhXK1FBWExtd2EvU3U2NkdQMlU5?=
 =?utf-8?B?UnBhUldPeGhIYXFneUEzVm9CSzIya3N0T0NDZFJ4aGdVTG5tclRQektuSm1k?=
 =?utf-8?B?VUdBaUNDYk1DS3M3dkx0OHVSL3B4eGt4bnFHb0RJcFFranB6aEhFMjhEbElZ?=
 =?utf-8?B?QW9uWTE5MHNQdGQ4SGRQcEZnWHNSdU5GOHdySUJwbmRCb1E4WU9DVTdzVnBm?=
 =?utf-8?B?YXptVE96NTNJZmU0d1hnL21xcmNrUGFvS1VVTXY1TXFlRFNWeWM4cTVJSnVJ?=
 =?utf-8?B?QjJ1MThESUtzSVV5YVFUTFk4dFh3U0I1ZnY0WFFLRFpaM1V0dmYzb1FNd0NT?=
 =?utf-8?B?bWNhN0FpbUc3dEN2V0VtRUwrbnBuQUNEell4YnBwWGhPZ1JGRjlJSXdITkw3?=
 =?utf-8?B?NkE3RlNUWlNTTUR3RnBkaHVRUnl6MkdQOTY1TW95c012S2k1NkJTOEFSbTkv?=
 =?utf-8?B?ZzlrdTFtbWovUGpSYWJDcHlWekpnT0M4MGNyZHR0cld4VGxkelVScXpRS0F5?=
 =?utf-8?Q?1BzV1q5j+bI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJmRmM1SUR0SVY2VmZINU5jSm9SUVpvNFEyMU5LRVRPSFNvT0JuZzJaMnZl?=
 =?utf-8?B?RE5IbzhnMEN4YldodkJDY3EvWjdxMzR5TlJEMFYrdkNQMjI2dWVZZ2J4L2RL?=
 =?utf-8?B?OGFrb1RyRDlCdVMvUjNnWVJHcC8veE5FMmpaVlBRZi9CMkh4Z0kyOVVxZHF0?=
 =?utf-8?B?aWRqczJ1aUk2elhaZmNtQXdvOVpaaVM2RS9hZFFJYm9ldFUzV2hhMHl4ZUhu?=
 =?utf-8?B?blMvWDVLU3NiK3ltK0tLOVRLSTRXN0N1UEdNNTN2UjFLTE5ZMlM1TmtINU9l?=
 =?utf-8?B?Q0x0R3FGTExrNnNaRXBFYjRDMVVaNGNyRUg4WnRYZTJxYzEwREM0dHRzcHJO?=
 =?utf-8?B?cUl6by8zaWhtK3lmN0I5TE1YQmo2NDlwRG42SGlBVHZrVmRXTVpVZTY4ZTNU?=
 =?utf-8?B?WDU5bDhpeWZ6N1YxL1gyOTVuT2Z0cjExYncwQjJrWnZyOXpLaitYck5yc0xW?=
 =?utf-8?B?ejlKYmxZaW02VExzZUM1VWJSRlZOTFB1aVQ3Q1Bxckp1TGRrSFhGMUx6U0ZD?=
 =?utf-8?B?My9Wck03eGFPclNOUFRvNTI5aXFmcTNYZFFvSllwMUNmaW1aQ3drRWFqd08x?=
 =?utf-8?B?ZTI1Qk1vYzlQeWlqZ0J4dExxa3l3MG9EZU5aaEJ3SytZMkFyMy94SHd4ZGRv?=
 =?utf-8?B?OFBNVm5SS0lGNHJoRStJWlNpT1JrbENMUmV4cXZUbXB2SkZVQzJWTFU4UVhE?=
 =?utf-8?B?OXdvTXliOExzY0pYOE4vR2cvdnZ6Q1YvdEF5ZkNxMHNLWXQ5Qjdhb25LTXhK?=
 =?utf-8?B?Y1Z1eHo4SlVYbnY4YVhkR1pBcndzNWVodEt1TkFFbStZRk9uY0x0WERSL3JP?=
 =?utf-8?B?MVJ5eHVLWHJ3N0xWSktWRWFNSDlhOXVVb1ZSOUttYUk3YTB0STlWUXVYNlpP?=
 =?utf-8?B?anJocEdZNUdubkJ3dmFVd1l1UEZXOHpUSjUxQ0lJKzdDQ2V2T1NPZGRxU21T?=
 =?utf-8?B?eWphd1owN0thYVhUazV0bzN3SllPZm9kcmFWcFdnRm1ReHlTd2U5UDZEdnBH?=
 =?utf-8?B?Q1lyMDhPY1ByaWNZOU5CbWtyUXRZUytLalo1R0h0K3o5T0FnNzdsTjhHNmdi?=
 =?utf-8?B?YnVjRE5HMzZ0Y3FISUVRQWgrUlJZR2dhcDJrcWRNckJOaStKWC9yQTdtTmJj?=
 =?utf-8?B?cnB5Zk52UVZ6T0JzY3dzNHA0YXVMRHRYSWNDNjNEVTBTV0JnSU16VWhLQzlh?=
 =?utf-8?B?dCtPelUxZjhwTGlrdlNmRE40RnNZUEV3ZjZiMTVmV1diNGwxL1YybXc0clRJ?=
 =?utf-8?B?T1JuSE5TMXpJV2JTL0JUUTdoUjh5T3h3Y0VKWCtaV082akVtZ3FsQkgzWktF?=
 =?utf-8?B?ZFl3WmF3OEN3dEFZZTY2MDN2WTFlRUZhZVp0bHlkMTdSL2E4bVNiOGpHdzFX?=
 =?utf-8?B?KytFbG1VY3FzTmxzMmxucVUwWW42Z3lGQjJHZGhKUkNBUWVtZUN6bzhGVnAv?=
 =?utf-8?B?K1kzaWF6THpBUEw0cWZIZXQvUXBvcHZkNEdVZlB1bjBtbThDUDRucGdjWklV?=
 =?utf-8?B?cGkxZlZqVnpGNXB6d3RRQS9BN0FyRFZFKzQxUEE2Z3p4bWpRVTdmNnVKS3hD?=
 =?utf-8?B?UStlOHdlWm9scFdOUmtTbGd1NnFEcU5acHJmY3UzTTNGZDdUZE1pYmJTSUlM?=
 =?utf-8?B?Yy9RR1dLTm5QcWczY0VaOEZqOHhoYzBIZzZPWVlhKzEvSFRFVzFjSjErS3RZ?=
 =?utf-8?B?UmJZWmdlYUYxa05SSHR4aEN1ZTVBM1M0eHFFMDRrZnYrMEd1VlFGSzBkaDFB?=
 =?utf-8?B?bmpDSGdYU2c0TjBxbzZxbzFDbElHYzVkdFNGSktDc3pNdGNQbnIrby9oYk0z?=
 =?utf-8?B?aS9JN2ppMktZcCtldFlQSUYvWWtlV1M1ckdrOEZvc3NEMWUzaUhBdDlqK3RH?=
 =?utf-8?B?dUxrZjRHeE4zTHR6Y2R5bUxMelhYU2QwRERmNWFUMVZRbDhqMVlyMWJPRFZ3?=
 =?utf-8?B?eHEvYllxSUZiUWhsSU9GLzBsY05EZ2Y5QWpmZ0hhOGpRQXlRQlJnZlN4L0tC?=
 =?utf-8?B?WitBVnhxcU9ucXc0Rldmck5OMkxHaFpuUGJTZGtXK0lEaGNKZ0orc0IzYlla?=
 =?utf-8?B?Zk5QS0hrN3YvWU9pUEMyNm9uNyt5U2NGU2hReHdjcGMvVXI1SWxEUk1NWjRN?=
 =?utf-8?B?cVpNcUY3T2pBL1pLb21ydFpMd3hmUFlFQXF4bDcwWXI3THI2TlRrM0pPNisw?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f12963-b12e-4e93-3ad9-08ddbd5cb9fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 13:46:51.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1XUDKiNie3D9yXi9/gk543Km8O3Q6NJIXY4gh0duR0ZbRDcyAiI2KrLcN+VHPW5ic14kkP8AzvGLbzYWV6HdI2GGSIM2wBKsEI++2QleYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7408
X-OriginatorOrg: intel.com

From: Colin Ian King <colin.i.king@gmail.com>
Date: Mon,  7 Jul 2025 14:23:40 +0100

> Analysis with gcov while running the stress-ng urandom stressor
> shows that there are a couple of fortify panic paths that are highly
> unlikely to be executed for well-behaving code. Adding appropriate
> branch hints improves the stress-ng urandom stressor my a small
> but statistically measureable amount. Ran 100 x 1 minute tests and
> measured the stressor bogo-op rates on a Debian based Intel(R)
> Core(TM) Ultra 9 285K with a 6.15 kernel with turbo disabled to
> reduce jitter.
> 
> Results based on a Geometic Mean of 100 tests:
> 
> Without patch: 50512.95 bogo-ops/sec
> With patch:    50819.58 bogo-ops/sec
> 
> %Std.Deviation of ~0.18%, so low jitter in results, improvement of ~0.6%
> 
> Branch hints can only be enabled if CONFIG_TRACE_BRANCH_PROFILING due
> to a static variable being declared in __branch_check__ when using
> trace branch profiling in the unlikely macro causing build issues.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V2: add fortify_unlikely macro wrapper for CONFIG_TRACE_BRANCH_PROFILING
>     build config.
> ---
>  include/linux/fortify-string.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index e4ce1cae03bf..c740114bcbf8 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -10,6 +10,12 @@
>  #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
>  #define __RENAME(x) __asm__(#x)
>  
> +#if defined(CONFIG_TRACE_BRANCH_PROFILING)
> +#define fortify_unlikely(x)		(x)
> +#else
> +#define fortify_unlikely(x)		unlikely(x)
> +#endif
> +
>  #define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
>  #define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
>  #define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
> @@ -593,9 +599,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,

Why only memcpy()?

>  	 * (The SIZE_MAX test is to optimize away checks where the buffer
>  	 * lengths are unknown.)
>  	 */
> -	if (p_size != SIZE_MAX && p_size < size)
> +	if (fortify_unlikely(p_size != SIZE_MAX && p_size < size))
>  		fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
> -	else if (q_size != SIZE_MAX && q_size < size)
> +	else if (fortify_unlikely(q_size != SIZE_MAX && q_size < size))
>  		fortify_panic(func, FORTIFY_READ, p_size, size, true);
>  
>  	/*

Thanks,
Olek
