Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E21E0E15;
	Fri, 21 Mar 2025 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539696; cv=fail; b=ixU4V7Izaw32pXR0seBGNqXP3xaJHu5SL2L9MMl0C0GpseYMFiuPgLrArSLKx+Ha7mrsMIVG4QQ+cYh4AQuGArq+wPRscUcVJ7ljued7ht1tSY46vWkGVnnRM2VyAtkvrWAtecdV5XYF3g6sWMkCutsUSjzisQzmtyUMwGUTpUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539696; c=relaxed/simple;
	bh=UpD7tjd5/qfrrOF165WKZ0Qi+qP3YIgZTSgz+ECoOFY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hTYhg1ANcZ9D9cCBxAOD1fOxXqgQE642rrhXCl0ClBK1u9Uub0/pWGunHH98giiatQx86oroYMvqVowik33BthpNGBG0yU5dn392/CTtC2iKI3lAPFzVksT3CjymZQM1mBsfD8KBWWEfYbMsSSNA2GOuk388LxVHtVgIUHIpczw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7qVOkGO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7qVOkGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742539695; x=1774075695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UpD7tjd5/qfrrOF165WKZ0Qi+qP3YIgZTSgz+ECoOFY=;
  b=A7qVOkGOHGp6zU/vMuNNkHmF91LQKD6KD8fkzJmniP6y3WozJ5v++4uX
   vtH7C+Wypg715wuoHzvP6v7APL2vW5hYvmEu6rAru25jQFOXcMnnzHEbn
   M8KHnuLp71X5lDBMzKepe4bDbeqpkchpFtlA/tZkyoNBAEraQt+mks2RV
   ++WSVhb2TECINUuY64/EqNbqv0npSt5lgH3SpFSUXY/hg6luO+1e7s/tm
   J+A6XpoWpjgnBoIlyBmKVocXGGXB/sdZpqU8+80w/CrKaZXjW4Lfsa/Sq
   4AzW7ipWEdAYzagdRYwe2V3x4NayQ0VWHGlM3UvJDfvQ0KmuzERPoZR+S
   A==;
X-CSE-ConnectionGUID: F0LTuisOTQqVEk+rdLCvjg==
X-CSE-MsgGUID: AfiN7v+9R/qeg2S69WrvlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55180081"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="55180081"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 23:48:14 -0700
X-CSE-ConnectionGUID: qViRe2c5SKqrL4GL0T9sGw==
X-CSE-MsgGUID: K+JWBLrsRpyW8RCMRzrT4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123775988"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 23:48:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 23:48:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 23:48:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 23:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/5OXEkqDmB3rXWelSLrtqg9kvmW4oqFs+hf0N6uc67GgKYCG+tg5zDtkRtCFMClSUUH6PkLhqcZpPbhx09Vog+fu6xoX5gztN9L9U+AvI3itgEvYofvw2TpyvUXG6TBA3DXhrMixR/Mnpvi4F1V78gQ3Nziu5XBNpmCZe7U6tvA18h+cxMCR9wXNnhl8z6BM/Z+JjakTdmEwN01JErcveO+RqmbtvV4hkxfhvAW1+tzL8MU1Q29kEsVhKgKAZqGDGMF5b0K9YNx0vkLXB4BFgnBfSYT+85wGupr9yilP56vmRMxhei5YBX6ls7wU6/WxIIzCpyxrOAaZY3BiNfHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6soXBY3l193UmlWVlmpE/CJRjpyHoFvgpoQ4Ks27zec=;
 b=NyKRRiM+Oi5mmEacAQDpzAsytDENMGyrclSJzN26b0z5x14Ol2/SxZlyx2TQfLGNPdx4p2SlL/R5WS72jBwl6MQayGzRTyAWA5vG0kJ7/4JKDFLKLYr4I7v3fLU03+uGYC/vmdAPR1LTtoibbiCwlCkrjo3+Xk/ytIrxGVLz7WUga/mFy2yBjWNfApyHPDtMVAmT9Z5Bdu1UWe2QMkjuGMOcmMqfom49AvSgs9fkNeNxdhUKTVgocVEhaAorm09dygn1MjXAqsY3OwzpkZe8YxGw6Puptu3LSRs3U6abx1Es/r4FiH18qGbDmbdJ1ISy1MxMctrk3Mlv8e4wvCkdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 06:47:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 06:47:30 +0000
Date: Fri, 21 Mar 2025 14:47:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kees Cook <kees@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Nathan Chancellor
	<nathan@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [hardening]  d70da12453:
 WARNING:possible_circular_locking_dependency_detected_trinity-main_is_trying_to_acquire_lock:at:__perf_event_task_sched_out_but_task_is_already_holding_lock:at:raw_spin_rq_lock_nested
Message-ID: <202503201652.77970721-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0117.apcprd02.prod.outlook.com
 (2603:1096:4:92::33) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d18f146-2a87-4e41-91bd-08dd68444061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vnKHuGMZcC9eMEIXN1BDzhTYecsrEJY2CLTRyknMhjXiNWvTEvZJagxGUr8f?=
 =?us-ascii?Q?aMMmFYKavt7vmuz3TSdQZT2nYUnixg3ATrNjbuPxyxAFshzILqciZRnvEh8n?=
 =?us-ascii?Q?Oj5kgT1c3rRb6yopm8jGE23hNItoSi0xlKP8ATnw2owHskpA5YCrrsFSoKuo?=
 =?us-ascii?Q?myOv5/l7dlmFoAQHev5dVgyI26giYhmyKcpSp3cWUc6z3abVh28ttsrkFUJK?=
 =?us-ascii?Q?BOGbFsU4sQ0ek5cGvc8GydgU6blZLs9iOKD6rCJq/cp890/9DD6w4tIbenpi?=
 =?us-ascii?Q?LtC+tiWAvgdXRciVpVTOAAZ9+NcOi626GLiy0mwPaFxzTaBEJSjv+47h1H49?=
 =?us-ascii?Q?rOgmxWB9vBL2YrDzvcKry1xBDtVWFSOwz2gL5dJzMQETRFXyAATjKZWo4vHU?=
 =?us-ascii?Q?3Wk0uuRh9zxLNkzB4BHZUBsCMbFEwCjjgdu+XgNMqgv2bRZe3jmK5d7NY4bQ?=
 =?us-ascii?Q?XMzacKkc1o+kU8HExkmX8VFY2s/db1pKbvNv1AIFAn9Xu2avxwBriBricvDg?=
 =?us-ascii?Q?G27xo2JK8YXOg2XnNHTBVABKdz6MRB24KYW9uZCv9udOE0z3GXx0e9qVR7rO?=
 =?us-ascii?Q?IwGNy+Kfhvl1W52ki6dDO06So3Ep+qK83WS+f75CGBKQUni0dUzEh9Zq7GL3?=
 =?us-ascii?Q?P0oUV6rC38eHGcc0au2JOjbQexY69AecFjpth5/D333ZQ4gFWAk7+IfW5HVR?=
 =?us-ascii?Q?h+yUv43RlBGgs+bwD6RROTiAeJ1aZqTfC8KNBiicSUU1oSN4Sv1YTOajY1Wv?=
 =?us-ascii?Q?WvM5ZwQ7G7R7zcBlIpdpvB1NVU6cIPQVU2Ua1VOOzDqoU7SN9+Es8ntiu9SM?=
 =?us-ascii?Q?a4QvfeXUzHZRc+k/jJEGfKPN6s1vlWPWW+tWoeKdA93nwmllWdAPMzFT2a60?=
 =?us-ascii?Q?piRc5tuS8uJhJfdHQ4aHYsZy4epPSv+GZwXg2WsPZJdoxFArAZ1GfcPt/eeZ?=
 =?us-ascii?Q?5aq2SE+EMcK9c/1uUmLBIrFrWMIhI2B5PhFO3gwmYgAtqVGh42MoUBSfPvW8?=
 =?us-ascii?Q?4GgM3DoANkKAXGWTdx/Y7021bMPlxQz/Bx7iqbbUftX8vknrNwybIYkw/je9?=
 =?us-ascii?Q?MlW1iCvr9AKsmkX7xJW9NHzU6BwRDR0nrMDvUufEFBa92oOo2JhS96/EEN1V?=
 =?us-ascii?Q?fWm5XwfbS8ozPjdMiPVh7jL6eGuNm+KMeByW5vXgQJ/HFm8m1BE57t9JW5mi?=
 =?us-ascii?Q?ObTDG2C+iCws7l95Kv0VVBhYjqme6YEszYI5gcSi9bKvxxoKnJ5acMOp7l3z?=
 =?us-ascii?Q?4cM0i2zyPz8Xtvng6og1zBx532un4JsZ+p/g9YmZeTd1MEXtG6+nCY27ysQ9?=
 =?us-ascii?Q?hq4x0wp9wYJMy1MJUU4QmTrziebKx+Nvp1uziZ5dkuPxBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?abDVeXAi7r3k2rZlN3wPn1K4T+vROaJv6WOBwYz7yEk5vIX6gGlPTh5jhxxv?=
 =?us-ascii?Q?KfE0meCebbXBeCwBm/AcORazvoeMD8P7pnIjZm4RC4dOVckO0n2ToopvBhK8?=
 =?us-ascii?Q?5tDyCcPvJ2o2ayFywWehpWffS4duYwIp68NhfYgaTTDbaFvlWvTamkxuXNJt?=
 =?us-ascii?Q?OItNWtxbgtA80lhKkQjkJV9NW5EuLaC7do53U7/AKICDXIGh447YcMJt5234?=
 =?us-ascii?Q?HafG9GJA4ZOSe9MqqaXfNpaXyp2/NPmRQRjcLnpvD9DA5M0sMqIBorpmYNeT?=
 =?us-ascii?Q?56h0iH54aS6T0KuS8zyv1Z49QjMR2Jd7zuxjnEn3bvXmMHgmWDpat6LAvjSD?=
 =?us-ascii?Q?/NGoda9EF9XSr9dCquRlyKx5+qkq8djKgrZr8bnUXxhxzRs5OKovuCmFlLIX?=
 =?us-ascii?Q?0TBt0rpnDyhJRbkycAm/60+M5B7KLs/ThWMdFMdUT/uVYhxzDBl0wpMIvP4I?=
 =?us-ascii?Q?buLNGStBMslzFOZJJUO9hiPBoCQbVol+8VyMfENUZ0343WnI5G3HK0W5a3yb?=
 =?us-ascii?Q?hAyimd6FyOaNluOHcBplrzLc+xbQRDOxQ5AoS2Jzi9p4az4W9PbiuOpAzE+2?=
 =?us-ascii?Q?TSUad96raCgwJGY+R94n4bbIirFjNQDlz7I8KriJ3w7q0nSdC4k6lkYSbwDY?=
 =?us-ascii?Q?SPyR8/CwP4/uuvF5tiywy1pql1YbhBEZcUeU7mRXRVbgvwPs4n5y+n6ZK1Tm?=
 =?us-ascii?Q?ZhMzJmXcAQqDM4h8XEgcg0f2qoi8ldoqUy4Yu2duXIFYRJJTfq07lYBlQGSo?=
 =?us-ascii?Q?cAB/YST6Oo1EpjTwEB40ZYtuU8O4gDsnJ3pyAnI1f23TxPtVZ3BsBa5C7Kim?=
 =?us-ascii?Q?hRcYOgW0JxmE6/IBX0CARh1bqxZEpMkykDTnh+0ApDvZPoD6zVStb03EnX+4?=
 =?us-ascii?Q?aY7cLekequ3N4yyfO/pv8oa6oCDYPZhEdIwGS0+4oLzkVAYTZ3ddIHWVBiK3?=
 =?us-ascii?Q?FNJ7G2SYtO1cde1IAUum6uf32kq/xbBGKaGEqtpLKlrXHxmLNnNl0DSCXs4B?=
 =?us-ascii?Q?lqg5VFfkyIV7jkmpyuHcoG61sriufPOQ42DHlLXAIMUMMEO9f6unHVVhYmGO?=
 =?us-ascii?Q?g34z7zqiSW/QATp9ePn7LYOYe2dB44K+MsHrgglVQRS7U7eyucFyp01PfW4W?=
 =?us-ascii?Q?+kRwZTPdaO7khlrflFfeWPtFcjHJqiqIRYa21hQXcGUezSPqJQ7XQkZss1zY?=
 =?us-ascii?Q?EdTzX8EGksx/6+pVSKzgPjLTa87USAxoi083dXbnqAwLjhXAiLelgfFmI580?=
 =?us-ascii?Q?qG+I1FzUNTOGvs8YrvW2cTeA0mb8jaPP7y983ROnhiyIwIMqE2oZ3qDIn620?=
 =?us-ascii?Q?QahfTVC0yUp5Z9RQaXdRDg6GnmB7UIYliaxY6hlc21dPaANp5fLzVyM9H5rH?=
 =?us-ascii?Q?FYw5UDOr4XmhPT0I72sqoLGXrC6oKUiTn8W8HK5dR8rAfvLDUuBJ3zE/ePZ2?=
 =?us-ascii?Q?aFiBiJJQSciNjmVi8cTQVKGJ1sG1rikf40Vqnx7Bk6C6NZU94qMr/68NcM3m?=
 =?us-ascii?Q?Rqql+AkQN5pPu6aY048mGL/pxOu4jG64UpEujv8oS9rfl+qq98dh/H4sCqXX?=
 =?us-ascii?Q?pZs1+6mHtxltlCF3+x2W9sz0ks0cDWNru9HLFBpvRN58k2JP/qzl31tONLCI?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d18f146-2a87-4e41-91bd-08dd68444061
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 06:47:30.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pjptbkazaL+7VQbhLnTp3XeKwTk74YrsqDFHpxhefIuDETV8wMz5H00ocw/B+kj2BBV6Tw4/h/uJDW5eT6EWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com


hi, Kees Cook and all,

this is not a regression report as we normally do. we just use this report
FYI that a WARNING shows up in our tests. and it seems due to d70da12453,
there are some changes in WARNING detail stat:

16cb16e0d28501f6 d70da12453ac3797e0c54884305
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         20:20        -100%            :20    dmesg.WARNING:possible_circular_locking_dependency_detected_trinity-main_is_trying_to_acquire_lock:at:__perf_event_task_sched_out_but_task_is_already_holding_lock:at:__schedule
           :20         100%          20:20    dmesg.WARNING:possible_circular_locking_dependency_detected_trinity-main_is_trying_to_acquire_lock:at:__perf_event_task_sched_out_but_task_is_already_holding_lock:at:raw_spin_rq_lock_nested


we also noticed the config has below diff:

--- /pkg/linux/i386-randconfig-053-20250318/clang-20/16cb16e0d28501f6eef7071675f1ffbceea8dd0d/.config   2025-03-19 13:45:13.488528197 +0800
+++ /pkg/linux/i386-randconfig-053-20250318/clang-20/d70da12453ac3797e0c54884305ccc894e8c817b/.config   2025-03-19 13:56:30.211029259 +0800
@@ -4943,6 +4943,7 @@ CONFIG_ZERO_CALL_USED_REGS=y
 #
 # Bounds checking
 #
+CONFIG_FORTIFY_SOURCE=y
 CONFIG_HARDENED_USERCOPY=y
 CONFIG_HARDENED_USERCOPY_DEFAULT_ON=y
 # end of Bounds checking
@@ -5568,12 +5569,8 @@ CONFIG_TIMERLAT_TRACER=y
 # CONFIG_FTRACE_SYSCALLS is not set
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
-CONFIG_TRACE_BRANCH_PROFILING=y
-# CONFIG_BRANCH_PROFILE_NONE is not set
+CONFIG_BRANCH_PROFILE_NONE=y
 # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
-CONFIG_PROFILE_ALL_BRANCHES=y
-CONFIG_TRACING_BRANCHES=y
-CONFIG_BRANCH_TRACER=y
 # CONFIG_KPROBE_EVENTS is not set
 CONFIG_UPROBE_EVENTS=y
 CONFIG_BPF_EVENTS=y



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected_trinity-main_is_trying_to_acquire_lock:at:__perf_event_task_sched_out_but_task_is_already_holding_lock:at:raw_spin_rq_lock_nested" on:

commit: d70da12453ac3797e0c54884305ccc894e8c817b ("hardening: Enable i386 FORTIFY_SOURCE on Clang 16+")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master c4d4884b67802c41fd67399747165d65c770621a]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



config: i386-randconfig-053-20250318
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503201652.77970721-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250320/202503201652.77970721-lkp@intel.com


[   34.400683][ T3405] 
[   34.400794][ T3405] ======================================================
[   34.401106][ T3405] WARNING: possible circular locking dependency detected
[   34.401419][ T3405] 6.14.0-rc2-00025-gd70da12453ac #1 Tainted: G                T 
[   34.401763][ T3405] ------------------------------------------------------
[   34.402075][ T3405] trinity-main/3405 is trying to acquire lock:
[   34.402350][ T3405] ec0b2410 (&ctx->lock){....}-{2:2}, at: __perf_event_task_sched_out+0x2cf/0x3c0
[   34.402759][ T3405] 
[   34.402759][ T3405] but task is already holding lock:
[   34.403089][ T3405] 828de790 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x61/0xc0
[   34.403485][ T3405] 
[   34.403485][ T3405] which lock already depends on the new lock.
[   34.403485][ T3405] 
[   34.403951][ T3405] 
[   34.403951][ T3405] the existing dependency chain (in reverse order) is:
[   34.404350][ T3405] 
[   34.404350][ T3405] -> #6 (&rq->__lock){-.-.}-{2:2}:
[   34.404677][ T3405]        _raw_spin_lock_nested+0x2f/0x64
[   34.404930][ T3405]        raw_spin_rq_lock_nested+0x61/0xc0
[   34.405192][ T3405]        __task_rq_lock+0x32/0x80
[   34.405419][ T3405]        wake_up_new_task+0x2c/0xe0
[   34.405654][ T3405]        kernel_clone+0x143/0x230
[   34.405881][ T3405]        user_mode_thread+0xa7/0xc0
[   34.406116][ T3405]        rest_init+0x1a/0x168
[   34.406328][ T3405]        start_kernel+0x307/0x364
[   34.406556][ T3405]        i386_start_kernel+0xd3/0xf4
[   34.406794][ T3405]        startup_32_smp+0x151/0x154
[   34.407028][ T3405] 
[   34.407028][ T3405] -> #5 (&p->pi_lock){-.-.}-{2:2}:
[   34.407355][ T3405]        _raw_spin_lock_irqsave+0x44/0x7c
[   34.407614][ T3405]        try_to_wake_up+0x74/0x470
[   34.407844][ T3405]        wake_up_process+0xf/0x20
[   34.408071][ T3405]        create_worker+0x181/0x1d0
[   34.408301][ T3405]        workqueue_init+0xb8/0x1b4
[   34.408531][ T3405]        kernel_init_freeable+0x3b/0xb8
[   34.408780][ T3405]        kernel_init+0x12/0x11c
[   34.408998][ T3405]        ret_from_fork+0x2c/0x40
[   34.409223][ T3405]        ret_from_fork_asm+0x12/0x18
[   34.409461][ T3405]        restore_all_switch_stack+0x0/0xb5
[   34.409722][ T3405] 
[   34.409722][ T3405] -> #4 (&pool->lock){-.-.}-{2:2}:
[   34.410048][ T3405]        _raw_spin_lock+0x2a/0x5c
[   34.410273][ T3405]        __queue_work+0x1cf/0x470
[   34.410500][ T3405]        queue_work_on+0x7f/0xb0
[   34.410723][ T3405]        rpm_suspend+0x4ab/0x710
[   34.410946][ T3405]        rpm_idle+0x8d/0x310
[   34.411153][ T3405]        __pm_runtime_idle+0x5f/0xe0
[   34.411390][ T3405]        __device_attach+0xe5/0x140
[   34.411628][ T3405]        device_initial_probe+0xf/0x20
[   34.411875][ T3405]        bus_probe_device+0x78/0xd0
[   34.412110][ T3405]        device_add+0x20e/0x410
[   34.412331][ T3405]        serial_base_port_add+0x10d/0x130
[   34.412589][ T3405]        serial_core_register_port+0xc8/0x830
[   34.412863][ T3405]        serial_ctrl_register_port+0x8/0x10
[   34.413130][ T3405]        uart_add_one_port+0x8/0x10
[   34.413366][ T3405]        serial8250_register_8250_port+0x69f/0x8d0
[   34.413659][ T3405]        serial_pnp_probe+0x1dd/0x310
[   34.413902][ T3405]        pnp_device_probe+0xb7/0x100
[   34.414142][ T3405]        really_probe+0x174/0x3a0
[   34.414369][ T3405]        __driver_probe_device+0x78/0x170
[   34.414627][ T3405]        driver_probe_device+0x19/0xf0
[   34.414873][ T3405]        __driver_attach+0x8d/0x190
[   34.415108][ T3405]        bus_for_each_dev+0xcc/0xf0
[   34.415342][ T3405]        driver_attach+0x14/0x20
[   34.415566][ T3405]        bus_add_driver+0x140/0x270
[   34.415805][ T3405]        driver_register+0x50/0xd0
[   34.416036][ T3405]        pnp_register_driver+0x19/0x20
[   34.416282][ T3405]        serial8250_pnp_init+0xd/0x10
[   34.416525][ T3405]        serial8250_init+0x69/0xec
[   34.416757][ T3405]        do_one_initcall+0xb4/0x2d0
[   34.416993][ T3405]        do_initcall_level+0x75/0xac
[   34.417232][ T3405]        do_initcalls+0x49/0x9c
[   34.417452][ T3405]        do_basic_setup+0x12/0x14
[   34.417680][ T3405]        kernel_init_freeable+0x6d/0xb8
[   34.417930][ T3405]        kernel_init+0x12/0x11c
[   34.418150][ T3405]        ret_from_fork+0x2c/0x40
[   34.418375][ T3405]        ret_from_fork_asm+0x12/0x18
[   34.418614][ T3405]        restore_all_switch_stack+0x0/0xb5
[   34.418877][ T3405] 
[   34.418877][ T3405] -> #3 (&dev->power.lock){-...}-{3:3}:
[   34.419224][ T3405]        _raw_spin_lock_irqsave+0x44/0x7c
[   34.419480][ T3405]        __pm_runtime_resume+0x49/0x70
[   34.419731][ T3405]        __uart_start+0x54/0xd0
[   34.419953][ T3405]        uart_write+0xb5/0x270
[   34.420170][ T3405]        n_tty_write+0x311/0x480
[   34.420394][ T3405]        file_tty_write+0x16e/0x360
[   34.420628][ T3405]        redirected_tty_write+0x6a/0x90
[   34.420877][ T3405]        do_iter_readv_writev+0x104/0x140
[   34.421134][ T3405]        vfs_writev+0xba/0x240
[   34.421350][ T3405]        do_writev+0x5a/0xc0
[   34.421559][ T3405]        __ia32_sys_writev+0x12/0x20
[   34.421797][ T3405]        ia32_sys_call+0x1003/0x1100
[   34.422034][ T3405]        do_int80_syscall_32+0xa6/0xe0
[   34.422281][ T3405]        restore_all_switch_stack+0x0/0xb5
[   34.422543][ T3405] 
[   34.422543][ T3405] -> #2 (&port_lock_key){-.-.}-{3:3}:
[   34.422881][ T3405]        _raw_spin_lock_irqsave+0x44/0x7c
[   34.423137][ T3405]        serial8250_console_write+0x5b/0x5b0
[   34.423407][ T3405]        univ8250_console_write+0x23/0x50
[   34.423668][ T3405]        console_flush_all+0x212/0x3e0
[   34.423914][ T3405]        console_unlock+0x45/0xc0
[   34.424142][ T3405]        vprintk_emit+0x156/0x240
[   34.424369][ T3405]        vprintk_default+0x10/0x20
[   34.424601][ T3405]        vprintk+0xe/0x20
[   34.424797][ T3405]        _printk+0x14/0x1c
[   34.424999][ T3405]        register_console+0x2f2/0x370
[   34.425241][ T3405]        univ8250_console_init+0x1b/0x28
[   34.425494][ T3405]        console_init+0x65/0x104
[   34.425719][ T3405]        start_kernel+0x203/0x364
[   34.425946][ T3405]        i386_start_kernel+0xd3/0xf4
[   34.426184][ T3405]        startup_32_smp+0x151/0x154
[   34.426418][ T3405] 
[   34.426418][ T3405] -> #1 (console_owner){..-.}-{0:0}:
[   34.426753][ T3405]        console_lock_spinning_enable+0x44/0x50
[   34.427033][ T3405]        console_flush_all+0x1fb/0x3e0
[   34.427280][ T3405]        console_unlock+0x45/0xc0
[   34.427507][ T3405]        vprintk_emit+0x156/0x240
[   34.427737][ T3405]        vprintk_default+0x10/0x20
[   34.427969][ T3405]        vprintk+0xe/0x20
[   34.428165][ T3405]        _printk+0x14/0x1c
[   34.428366][ T3405]        ubsan_prologue+0x1e/0x70
[   34.428594][ T3405]        handle_overflow+0x57/0x1d0
[   34.428828][ T3405]        __ubsan_handle_sub_overflow+0x10/0x20
[   34.429105][ T3405]        visit_groups_merge+0x73a/0x740
[   34.429355][ T3405]        __pmu_ctx_sched_in+0x3a/0x50
[   34.429597][ T3405]        ctx_sched_in+0xf1/0x110
[   34.429821][ T3405]        ctx_resched+0xc6/0x1c0
[   34.430041][ T3405]        __perf_install_in_context+0x1c1/0x240
[   34.430318][ T3405]        remote_function+0x25/0x40
[   34.430549][ T3405]        smp_call_function_single+0x37/0x70
[   34.430816][ T3405]        perf_install_in_context+0x160/0x220
[   34.431086][ T3405]        __ia32_sys_perf_event_open+0x73a/0x860
[   34.431367][ T3405]        ia32_sys_call+0x739/0x1100
[   34.431603][ T3405]        do_int80_syscall_32+0xa6/0xe0
[   34.431849][ T3405]        restore_all_switch_stack+0x0/0xb5
[   34.432111][ T3405] 
[   34.432111][ T3405] -> #0 (&ctx->lock){....}-{2:2}:
[   34.432435][ T3405]        __lock_acquire+0x15de/0x2920
[   34.432677][ T3405]        lock_acquire+0x94/0x190
[   34.432901][ T3405]        _raw_spin_lock+0x2a/0x5c
[   34.433128][ T3405]        __perf_event_task_sched_out+0x2cf/0x3c0
[   34.433413][ T3405]        __schedule+0x61e/0x674
[   34.433633][ T3405]        preempt_schedule_irq+0xa8/0x110
[   34.433886][ T3405]        raw_irqentry_exit_cond_resched+0x34/0x40
[   34.434175][ T3405]        irqentry_exit+0x81/0x8c
[   34.434399][ T3405]        sysvec_apic_timer_interrupt+0x29/0x34
[   34.434676][ T3405]        handle_exception_return+0x0/0xc9
[   34.434933][ T3405]        smp_call_function_single+0x57/0x70
[   34.435199][ T3405]        perf_install_in_context+0x160/0x220
[   34.435469][ T3405]        __ia32_sys_perf_event_open+0x73a/0x860
[   34.435752][ T3405]        ia32_sys_call+0x739/0x1100
[   34.435986][ T3405]        do_int80_syscall_32+0xa6/0xe0
[   34.436232][ T3405]        restore_all_switch_stack+0x0/0xb5
[   34.436495][ T3405] 
[   34.436495][ T3405] other info that might help us debug this:
[   34.436495][ T3405] 
[   34.436949][ T3405] Chain exists of:
[   34.436949][ T3405]   &ctx->lock --> &p->pi_lock --> &rq->__lock
[   34.436949][ T3405] 
[   34.437477][ T3405]  Possible unsafe locking scenario:
[   34.437477][ T3405] 
[   34.437810][ T3405]        CPU0                    CPU1
[   34.438050][ T3405]        ----                    ----
[   34.438290][ T3405]   lock(&rq->__lock);
[   34.438475][ T3405]                                lock(&p->pi_lock);
[   34.438770][ T3405]                                lock(&rq->__lock);
[   34.439064][ T3405]   lock(&ctx->lock);
[   34.439245][ T3405] 
[   34.439245][ T3405]  *** DEADLOCK ***
[   34.439245][ T3405] 
[   34.439609][ T3405] 3 locks held by trinity-main/3405:
[   34.439847][ T3405]  #0: ee7cd0e0 (&sig->exec_update_lock){++++}-{4:4}, at: __ia32_sys_perf_event_open+0x355/0x860
[   34.440318][ T3405]  #1: ec0b2468 (&ctx->mutex){+.+.}-{4:4}, at: __ia32_sys_perf_event_open+0x3f3/0x860
[   34.440746][ T3405]  #2: 828de790 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x61/0xc0
[   34.441156][ T3405] 
[   34.441156][ T3405] stack backtrace:
[   34.441420][ T3405] CPU: 0 UID: 65534 PID: 3405 Comm: trinity-main Tainted: G                T  6.14.0-rc2-00025-gd70da12453ac #1
[   34.441945][ T3405] Tainted: [T]=RANDSTRUCT
[   34.442140][ T3405] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   34.442602][ T3405] Call Trace:
[   34.442753][ T3405]  __dump_stack+0x18/0x24
[   34.442950][ T3405]  dump_stack_lvl+0x32/0x74
[   34.443157][ T3405]  ? vprintk+0xe/0x20
[   34.443339][ T3405]  dump_stack+0xd/0x1c
[   34.443525][ T3405]  print_circular_bug+0x2c5/0x2d0
[   34.443756][ T3405]  check_noncircular+0xc7/0xf0
[   34.443974][ T3405]  ? local_clock_noinstr+0x17/0x140
[   34.444208][ T3405]  ? sched_clock_noinstr+0x8/0xc
[   34.444433][ T3405]  ? local_clock_noinstr+0x17/0x140
[   34.444668][ T3405]  __lock_acquire+0x15de/0x2920
[   34.444889][ T3405]  ? __lock_acquire+0x566/0x2920
[   34.445114][ T3405]  ? sched_clock_noinstr+0x8/0xc
[   34.445338][ T3405]  ? local_clock_noinstr+0x17/0x140
[   34.445573][ T3405]  ? __cgroup_account_cputime+0x17/0x40
[   34.445825][ T3405]  lock_acquire+0x94/0x190
[   34.446028][ T3405]  ? __perf_event_task_sched_out+0x2cf/0x3c0
[   34.446299][ T3405]  ? local_clock+0xe/0x30
[   34.446496][ T3405]  ? __perf_event_task_sched_out+0x2cf/0x3c0
[   34.446766][ T3405]  _raw_spin_lock+0x2a/0x5c
[   34.446972][ T3405]  ? __perf_event_task_sched_out+0x2cf/0x3c0
[   34.447242][ T3405]  __perf_event_task_sched_out+0x2cf/0x3c0
[   34.447505][ T3405]  ? set_next_task_fair+0x66/0x210
[   34.447738][ T3405]  ? pick_next_task_fair+0x69/0x80
[   34.447967][ T3405]  __schedule+0x61e/0x674
[   34.448165][ T3405]  ? raw_irqentry_exit_cond_resched+0x34/0x40
[   34.448439][ T3405]  ? raw_irqentry_exit_cond_resched+0x34/0x40
[   34.448714][ T3405]  preempt_schedule_irq+0xa8/0x110
[   34.448946][ T3405]  raw_irqentry_exit_cond_resched+0x34/0x40
[   34.449213][ T3405]  irqentry_exit+0x81/0x8c
[   34.449415][ T3405]  ? vmware_sched_clock+0xdc/0xdc
[   34.449644][ T3405]  sysvec_apic_timer_interrupt+0x29/0x34
[   34.449898][ T3405]  ? event_function+0x150/0x150
[   34.450119][ T3405]  handle_exception+0x132/0x132
[   34.450339][ T3405] EIP: smp_call_function_single+0x57/0x70
[   34.450596][ T3405] Code: ce e8 3d d8 02 00 89 f0 ff d3 e8 34 d7 02 00 9c 8f 45 ec f7 45 ec 00 02 00 00 75 17 31 c0 f7 c7 00 02 00 00 74 01 fb 83 c4 08 <5e> 5f 5b 5d 31 c9 31 d2 c3 e8 f3 eb af 00 eb e2 90 90 90 90 90 90
[   34.451460][ T3405] EAX: 00000000 EBX: 81204170 ECX: 00000000 EDX: 00000000
[   34.451779][ T3405] ESI: ee6b3e94 EDI: 00000246 EBP: ee6b3e84 ESP: ee6b3e78
[   34.452097][ T3405] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00000286
[   34.452438][ T3405]  ? event_function+0x150/0x150
[   34.452659][ T3405]  ? print_cfs_rq+0x6fb/0xd70
[   34.452874][ T3405]  ? vmware_sched_clock+0xdc/0xdc
[   34.453102][ T3405]  ? vmware_sched_clock+0xdc/0xdc
[   34.453331][ T3405]  ? smp_call_function_single+0x57/0x70
[   34.453581][ T3405]  perf_install_in_context+0x160/0x220
[   34.453828][ T3405]  ? add_event_to_ctx+0x4a0/0x4a0
[   34.454056][ T3405]  __ia32_sys_perf_event_open+0x73a/0x860
[   34.454317][ T3405]  ia32_sys_call+0x739/0x1100
[   34.454530][ T3405]  do_int80_syscall_32+0xa6/0xe0
[   34.454755][ T3405]  entry_INT80_32+0x124/0x124
[   34.454968][ T3405] EIP: 0x77f7d092
[   34.455134][ T3405] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
[   34.456000][ T3405] EAX: ffffffda EBX: 00fc2ed0 ECX: 00000d4d EDX: ffffffff
[   34.456317][ T3405] ESI: ffffffff EDI: 00000008 EBP: 77da8525 ESP: 7fe29698
[   34.456634][ T3405] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000206
[   34.733107][ T3405] UDPLite: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
[   34.854852][ T3405] UDPLite6: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

