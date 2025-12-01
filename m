Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000672F851;
	Mon,  1 Dec 2025 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764573742; cv=fail; b=QeBKZUfc93Z2Wspdd3oGjiggu67iBl3iJsU6kiuvNayfqp2PJjVx4RTwxQvWgZO/VIpbmTZhlt7dnvSUMqZzxGHTDzFjBO6Gqzq4IbbdvMHkRsolN0yS0sDZ4QrYByaU19mZG3NzBA+bX08Ji0aIcof6K10RaGqipAlcwGCyYSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764573742; c=relaxed/simple;
	bh=97q5SkO6APgpjekZVf2D7Sc6lB13EOIOTI28jr083Ts=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KdY55f1P7cm+2dlUl1WX1HDP1EBvPHxYpf/Z8jwocYMv0fZM5aUa8ZYjwpRv85BxM3gbXzMovoCmmi9SWbIVk9AxWz+8Xn5p0DJ47g+v6kZcuJGU9noxht9bH64ybZC67MSgwfuDOXbJLuh47cm47dWYycfTvjbdm1F5y9ZazN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ow2HG4tG; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ow2HG4tG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764573740; x=1796109740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=97q5SkO6APgpjekZVf2D7Sc6lB13EOIOTI28jr083Ts=;
  b=Ow2HG4tGX6r4dRNW5zTnsHeRTT6W9MS/5kkEBG5Q9zXZyI3EA6BkDzQ8
   hXKZd92KJjfk8LTnU6Huc84Lp35sFLJewp72+Xx1s0oq90H+fT6e6RWOs
   G3ymZhO+OBF5n6PiCWHUWo2DDIkT3wdPGv0xQ7NvR/PGVjLX7HXzqKm+E
   YBOub/H2gifOIoUbXdv9YdB2sBl4g2WIIFETbGTsuNHmC6qYm+oQXJcKq
   2H9WUSyReRTFxft9rzH4C6DXO508Z2Zmc79UvEzBzRZA0/XDeyhN4eE6X
   YOCxbqZnJTfgr9s0UZxwrah/YfyNTCno4CuJZ50z1H0l9hytaHe3LiPPH
   g==;
X-CSE-ConnectionGUID: s0+WNBGlTfq+Uf0GSALt3w==
X-CSE-MsgGUID: MGNSuUM8QDucQjXpCTo+PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="84108860"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="84108860"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:22:08 -0800
X-CSE-ConnectionGUID: KliZMRQjRtm2nouVATOKVw==
X-CSE-MsgGUID: xOWphXjbQUOT+ml4smNFYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="193816630"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:22:03 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 23:22:02 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 30 Nov 2025 23:22:02 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 23:22:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvUL/ZC4HaQaoCztOvHjNw3OivSBJNhM2wSHYSlegPwqH6Okm/9jMBbn7gO1+m6nBvEnGl3yC3LQMJKt6Pwr7S3SgU48ZjhEJ8YUq7xCbPn1wZIEAqYB0H6EQRTBxvDDi9lBTRc7KA0BiD9kBsaeB9h0xDc74nf3e/BHEMZsJEeyWi2GgmqgF1CwED0SSeDEh6ac0Eb/0Q4kV8H/Rs7UjKWZL19X/iys9SUb48E3hkhZpVBcNqgexf3+LiKRaFhRDHMm8eD/E2irnElV3TUMOWIGFDCkk1SDY7GNs4VM9rbQfjM086wB0lUtLsMSrK6d0ZUFTtHAHYMxNnTh40MywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LDqy7ApxSwC1WuuoebXrCRLf8CYhjryKpG6cD7qoLU=;
 b=dnBd1WoFLKz5WPWBpZrEy/gQ7925QXhq6eiPqfBHbXDeVBNmoUytegX7wUlzRDk7hC7/nl+c1+D4uJY2MF3+FHJaGja7nyldYdn5WeIPTTO+WshKJdsNy8wmdlOAU31GVT38MuD+qP6++VtI9br6B1T1u2c4WQZXDIQeoTZ2LnRq+A9VLnZ5VzYcw462QLazvzPq4JCSOcp+XI5wtVp4CrdLboPYzlS7LXvpjb2xbMxETaXalaNBPRJsN5Heksbo6n6RCB2SJIo2pBMVsscXgKyel5JMa9s9rrg44RYsa9t+En3oL0l0Mxo3KiEOtA1w3LO6uXbECwPOewbVCdbf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 07:21:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 07:21:59 +0000
Date: Mon, 1 Dec 2025 15:21:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [ardb:lockless-random] [randomize_kstack]  05894b44c1:
 KASAN:probably_user-memory-access_in_range[#-#]
Message-ID: <202512011452.55f7fa0a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KUZPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:d10:32::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 275974b0-1669-47ef-fb80-08de30aa50ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OTUyUr2dZs+LDAI4tEw98UY1csoCetmHg/glc0TqHCI6gOKPA5wtgRVNfNJx?=
 =?us-ascii?Q?ciH00GcbFngSiL76fEIa6PWZm0F2fMIsiZhhEZ3r4MMUD+Z1Y0IkrMQU9ngI?=
 =?us-ascii?Q?pn0oiAFeg6DUrHMOCpDc8WLhvIjfJEIo/JdcrRA6VLWdU4rIELwS4B3AJHnW?=
 =?us-ascii?Q?zy58AZ4WnCJLWu6UZ+YDAtP2LqHVhdnWpoaDkuKKI73Xy4QFXj98XtNI+98w?=
 =?us-ascii?Q?iOhSkUPFxP5HvGMK5JGqEEEClpaF/Pl49TGd8oaHkD5xrBbxOH2vbpZrnSEL?=
 =?us-ascii?Q?YNXKvd1TdmC+bClnOc6TnVRP1NoFXK1EOEWl/6yLOtPGV5jWfb6qpM2OKtTN?=
 =?us-ascii?Q?keMJcL9GDfnPeAlpfF7bGetUmnuQ+Y+4wOwz4nta4T6Aj25juZKrLlTWchLM?=
 =?us-ascii?Q?6YnfZFLMFssY+2K2h/0B8IlzOnzV0EaACUPNTBddRU79LsF4jlwe2BPpXkWp?=
 =?us-ascii?Q?TPlKLbNSz7a4Sj6anZ8xJ5Cdzt3jonzX/tEn9OaFSuH8J6gupV0lG7tQJDQ/?=
 =?us-ascii?Q?GsxBwJQWUlrJJnAhApG25LxpM9YuqAplFpJ/vavr6bCRSyg00q+Jr9in75Kn?=
 =?us-ascii?Q?cDDVJF14QDvxvQenCdxSyI0Qr7PKnSLT43sBenGMRuHTiuv+dkqAt1BXqAlZ?=
 =?us-ascii?Q?lY1glEBE0nYBQryNVHp9uWBHNGZ6IGF7q98GKg8jqNzZerHhWKrqUKcVDZex?=
 =?us-ascii?Q?Lln0Mf+Aq2Nu7+/n+oWmQXuznX7+YCsZp7S8xxYI/cACd5OMdwbv5jdHMnhD?=
 =?us-ascii?Q?qNCMsScye+ovb/zb96T23mrSN9T1IlHSNnwTIcc6D24RIy/isFaEO2P1jjzA?=
 =?us-ascii?Q?te+uo4GFOqnwWGhkiP5nBgvQsWEohxMpKzTrDaxsg3qC9+zqT60FA4ZeXm1u?=
 =?us-ascii?Q?yEo8LBOwC3RU4V6zu/fz7U8EwUWrXnPkJzpwIISrACPqUSNVZ5njnMDCajf0?=
 =?us-ascii?Q?W0EfQCtv+mzfzOYSX/rBXKMMZYcDkBRnwLVpZCIkwVkT6j4O4l11m/mkWerd?=
 =?us-ascii?Q?FzfWxPmaQAeSlRuqD8ELLE9eR00SXtjatjoH+bRHXxJgs2aBNgrtnWIwBu9u?=
 =?us-ascii?Q?Z+N1DgLl8JiXqWIaAv5iqv2fH59GO87yORKM5YnRCha5L1GWqYnPx/yCGisp?=
 =?us-ascii?Q?62ps5IDENBcO58j/LbZsVD16LrjbgpXMNLAr+quj//+Hztx12o3Ny14VVP4C?=
 =?us-ascii?Q?jNCMGmd2vib7CstKDI2M7DHXWfsnmM0f7dNNIeG1Fb64Nh1yMn/pJt+DvBBd?=
 =?us-ascii?Q?v+M1l5UAtqJqNx8LKBom5cTPt9P5w2NlPsSSJq6Sbi5qr/rgssjNOXpUqCz9?=
 =?us-ascii?Q?ZEfvaJqMoV0CckU71NV1F+n4dddXmM7utUU0Bczo56dgszVNF/g0ozviF2YU?=
 =?us-ascii?Q?nW9F6Vn18EXuFFkDbkWXcdVM1j5rpEfaBM5kxXpu6EO7z/CFmNE0T5G4riQm?=
 =?us-ascii?Q?jp1Q+MBMl/j3tLoQUeg/V3iZXAifmzacZC2/oj4nnjrUivrmJdLtKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jnBV5soK1EJVoGmloUcNVm4abJPrH4KswiO4jvKAimwG90AOHguEIgJ+8tv+?=
 =?us-ascii?Q?fOtjQRIC52I8hdKr7mRFWiiXhe2thNd6zdZfwbMdMKUfFyr6lyt/d++8zKC/?=
 =?us-ascii?Q?nNaCcmQxhvf62TGF41d723C8bzNlOSHF5DIibEab5aJPUTFbwaQniTpv0Tvu?=
 =?us-ascii?Q?oVDh879V/e8sNFDJyNw80KYk06sovRXsxrGTgkwr7L8lQmO/OZOIRCnb4xnI?=
 =?us-ascii?Q?me86LvTvEmoRvpg6c8BHTkTp0g56RKFl8sR5aDWRtY/q8Ci96KJ4YZjxIWje?=
 =?us-ascii?Q?WAi9LyWWSV5Rg0k48JaItdYssGpert+DI3gNVvW49WFF2ovT3R9BBYORIAig?=
 =?us-ascii?Q?AXdo2m525ojuAMnR8ZUWp+fYhaeKlbpY6kJTsrk8C+QAcXfCC/3vC2MqNfxp?=
 =?us-ascii?Q?vPWGwMW8DdzS2xF2gOMwUKgrV78P/YqXiIljWFioM8bgF3qto7oiP2curbHr?=
 =?us-ascii?Q?laQRNCIl/6z5lm3QhsGwgenX7JY5q2Q7PKgajP5HHJ9Lcmhl5meF89veEnRc?=
 =?us-ascii?Q?48Z7DxaIQSKfCvP2WxTmjEwAsoTMn0LrBWXnhSyKo5QVyv5eiKSNsZlHbTXy?=
 =?us-ascii?Q?6fcnAqnMAmuvyUET2AYK2smsI1dHFfn+F6tzOm5h2EtcZdHGf8IrbAowxkXm?=
 =?us-ascii?Q?IT7H4+/5Kt7eF0c2N8n9jssBUk9ywkSBlmiVpBpqULoUjt/xMaikG96quLL/?=
 =?us-ascii?Q?kpfmYrxHCLKF4l98aDHF3M5FLXE4uxtIxGye2gt9OVAkJv7DuZU5COrx45dI?=
 =?us-ascii?Q?AnuBG/tuU6vW3xqEpVblqeIiAZGlzhkfCrH2KFee0AUbiAsR1xApqYu8Mw1d?=
 =?us-ascii?Q?56FHgepkJceEy1XpSyWtHMTLuW57FWWA5qNCBcKIqONNC4tdL789ZOMFGYzj?=
 =?us-ascii?Q?oTH/CK7hFCZHDsVSEjBC3aPwXCGgzgu1wvcgDDU3ZoeOjQc6U8Jic6C97Jtz?=
 =?us-ascii?Q?q0Y5j/T053yRy5cmLoB9I2utfKTa2i2YUmLvhyF3DbgqXVsMJYZC79na+4sd?=
 =?us-ascii?Q?4l5uKR6q7bvlzamFRuzC/Llem/41rkUiAD/J+YQjyIyUL8Yma2J1M7Jjqs/z?=
 =?us-ascii?Q?c9WBWVacWLCvCaOjDgUMdetAhcHeOtXozA2LcnSHK25P1/ZrVdsC63n/8Ry9?=
 =?us-ascii?Q?PHrJYE6GdSsYTqGFcQYrUBwrMiabvNRnUcj3LyyM86q263LFdHCfI4wBkeVA?=
 =?us-ascii?Q?nkcHzY3a8L2ivA+VHKed5I0PYFjVS3ipYwQ3eyLDUuWMhfCsoyNp4/t7B2wh?=
 =?us-ascii?Q?EYx99LHWCyjPSthz2DINtYQRDMEhyOzRx4nh2n5+HFthdkTSbixRgdbn0TTe?=
 =?us-ascii?Q?VCp3FLeScE3JedAjRBfxjdNNhRK/WsMFJBUBul3oSmLKH7uSRZiAWGTr8QKs?=
 =?us-ascii?Q?i7WFI6VLoKtUt8SNZWucL3yzXVw0DKb29fa/+zk744vk+csTzodjAP88Gvjw?=
 =?us-ascii?Q?pilR+SMMEfNgChx3vafi5+wfmmqiB5tcUJYRAcpdA5dIvkQUvclkHPArU53j?=
 =?us-ascii?Q?fWCGLQ4apxWPI6vLqal6Bc+3X0FyFtBPb/Li0H+BrD03i+Nssh8J/SAEF1Kp?=
 =?us-ascii?Q?t/FcuECBhONo+TRY8GZw7vRSA3FdVU74Xt8MXqyyau4ArmmRHDTHfaCHSmli?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 275974b0-1669-47ef-fb80-08de30aa50ad
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 07:21:59.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8dBRZp/+KHfAToKP3b4kah9wClSs5J/d/Js75MBHeB+jcMMuifN/+C3LfH9IerBtlDFJF3TalR1aq4rzxMtGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-OriginatorOrg: intel.com



Hello,


as we understand, commit 05894b44c1 is not the root cause of the issue, but due
to its change, the issues stats are changed: from below (1) for parent, changes
to (2) for 05894b44c1.

we also see a random behavior that stats (3) changed to (4) but still randomly
keep the original stats (3) in one instance.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/sleep:
  vm-snb/boot/debian-11.1-i386-20220923.cgz/x86_64-randconfig-075-20251128/gcc-14/1

7492bfcc5b0908ca 05894b44c19c9050c63946f12c5
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6         -100%            :6     dmesg.KASAN:maybe_wild-memory-access_in_range[#-#]    <---- (1)
           :6          100%           6:6     dmesg.KASAN:probably_user-memory-access_in_range[#-#]   <---- (2)
          6:6            0%           6:6     dmesg.Kernel_panic-not_syncing:Fatal_exception
          6:6            0%           6:6     dmesg.Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]KASAN
          6:6          -83%           1:6     dmesg.RIP:get_random_u32    <----- (3)
           :6           83%           5:6     dmesg.RIP:get_random_u8     <----- (4)
          6:6            0%           6:6     dmesg.UBSAN:array-index-out-of-bounds_in_drivers/char/random.c


we make out this report just FYI what issues we saw in our tests which seems be
related with relavant code with this change.


kernel test robot noticed "KASAN:probably_user-memory-access_in_range[#-#]" on:

commit: 05894b44c19c9050c63946f12c5755389c79c80b ("randomize_kstack: Use get_random_u8() at entry for entropy")
https://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git lockless-random

in testcase: boot

config: x86_64-randconfig-075-20251128
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512011452.55f7fa0a-lkp@intel.com


[  614.795260][    T1] ------------[ cut here ]------------
[  614.796338][    T1] UBSAN: array-index-out-of-bounds in drivers/char/random.c:571:1
[  614.798170][    T1] index 4294967294 is out of range for type 'u8 [96]'
[  614.803553][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc7-00006-g05894b44c19c #1 PREEMPT
[  614.805622][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  614.807866][    T1] Call Trace:
[  614.808654][    T1]  <TASK>
[  614.809372][    T1]  dump_stack_lvl (lib/dump_stack.c:122)
[  614.810372][    T1]  dump_stack (lib/dump_stack.c:130)
[  614.811235][    T1]  ubsan_epilogue (lib/ubsan.c:234 (discriminator 1))
[  614.812173][    T1]  __ubsan_handle_out_of_bounds (lib/ubsan.c:456)
[  614.813355][    T1]  get_random_u8 (drivers/char/random.c:571 (discriminator 1))
[  614.814307][    T1]  ? get_random_bytes (drivers/char/random.c:571)
[  614.815364][    T1]  ? trace_hardirqs_off (include/trace/events/preemptirq.h:40 (discriminator 5) include/trace/events/preemptirq.h:40 (discriminator 5))
[  614.816587][    T1]  do_int80_emulation (arch/x86/entry/syscall_32.c:148 (discriminator 1))
[  614.817763][    T1]  asm_int80_emulation (arch/x86/include/asm/idtentry.h:621)
[  614.822855][    T1] RIP: 0023:0xf7f16092
[  614.823753][    T1] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[  614.826848][    T1] RSP: 002b:00000000ffb0486c EFLAGS: 00200246
[  614.827740][    T1] RAX: 0000000000000006 RBX: 000000000000000c RCX: 00000000ffb0494c
[  614.828916][    T1] RDX: 0000000000000010 RSI: 0000000000000000 RDI: 00000000f72786cc
[  614.830100][    T1] RBP: 000000000000000b R08: 0000000000000000 R09: 0000000000000000
[  614.831290][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  614.832390][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  614.833524][    T1]  </TASK>
[  614.834029][    T1] ---[ end trace ]---
[  614.838773][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc0010eb0463: 0000 [#1] KASAN
[  614.840947][    T1] KASAN: probably user-memory-access in range [0x0000000087582318-0x000000008758231f]
[  614.846839][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc7-00006-g05894b44c19c #1 PREEMPT
[  614.848810][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  614.850837][    T1] RIP: 0010:get_random_u8 (drivers/char/random.c:571 (discriminator 1))
[  614.851939][    T1] Code: fb 60 72 0f 48 89 de 48 c7 c7 c0 16 58 87 e8 e0 60 c2 ff 48 8d bb 20 23 58 87 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <8a> 04 02 48 89 fa 83 e2 07 38 d0 7f 09 84 c0 74 05 e8 b3 c6 ea fe
All code
========
   0:	fb                   	sti
   1:	60                   	(bad)
   2:	72 0f                	jb     0x13
   4:	48 89 de             	mov    %rbx,%rsi
   7:	48 c7 c7 c0 16 58 87 	mov    $0xffffffff875816c0,%rdi
   e:	e8 e0 60 c2 ff       	call   0xffffffffffc260f3
  13:	48 8d bb 20 23 58 87 	lea    -0x78a7dce0(%rbx),%rdi
  1a:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  1f:	48 89 fa             	mov    %rdi,%rdx
  22:	48 c1 e0 2a          	shl    $0x2a,%rax
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	8a 04 02             	mov    (%rdx,%rax,1),%al		<-- trapping instruction
  2d:	48 89 fa             	mov    %rdi,%rdx
  30:	83 e2 07             	and    $0x7,%edx
  33:	38 d0                	cmp    %dl,%al
  35:	7f 09                	jg     0x40
  37:	84 c0                	test   %al,%al
  39:	74 05                	je     0x40
  3b:	e8 b3 c6 ea fe       	call   0xfffffffffeeac6f3

Code starting with the faulting instruction
===========================================
   0:	8a 04 02             	mov    (%rdx,%rax,1),%al
   3:	48 89 fa             	mov    %rdi,%rdx
   6:	83 e2 07             	and    $0x7,%edx
   9:	38 d0                	cmp    %dl,%al
   b:	7f 09                	jg     0x16
   d:	84 c0                	test   %al,%al
   f:	74 05                	je     0x16
  11:	e8 b3 c6 ea fe       	call   0xfffffffffeeac6c9


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251201/202512011452.55f7fa0a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

