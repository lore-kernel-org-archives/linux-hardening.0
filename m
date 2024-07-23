Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4DB14B082;
	Tue, 23 Jul 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724714; cv=fail; b=LUXM3gvFe5KzMVJx4CSJUKHouBz0R1IHENMQCtx3DGc4j1CcQ5gXtiyQ7PgQgvNM90BDqszwInJNKUxroAFEv53W4OhXlZZwTJ2oLX2jAuAJsI4qHBuM6m20Dx0Ke6nAdjHM7cmRFiacL01wgMmY7IyI/4wP1E32xDMWfBDuw7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724714; c=relaxed/simple;
	bh=DdruFl1Etu/ucWScA7XfIp5ygmWldQ022I5PTC2UFeI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dHtnqdP7IVyvMq5FBGBCtCmb9qTZiQ5P2Sg//c8BK2fISkGPjESf6OLd5XOFPR/92RWk25dVNy/8l45+0uxdjggTym6oKCi3Z31OObrAWEtxq/dFIK2SaoW/yLdgekrqEWBSDy9/aGjZpPvFxyQTAMtUYbXFIiNIkoM8pnNgg1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwDvaWR4; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwDvaWR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721724712; x=1753260712;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DdruFl1Etu/ucWScA7XfIp5ygmWldQ022I5PTC2UFeI=;
  b=iwDvaWR4D4br21phs82N58TeiylGpMA4Wr8iaQcJrXzZgBgjh5I71ipE
   zQufqmxrcUqgNZcg6IJZL9N3LkfTFmA9jVn4zVLN1tpidZ7tWbT2UHTSB
   i3jF4zKGBlRWkI/985HI0tcd8SvSvg6zcD+1V4/dqYoANeJ4XNotsMzwV
   OiiSfsUWvnoRbCeSfh1kEDt94kNRKZib+rMS9JfJvebkXgCPbXBJK3iUf
   WEPAR1HVV6elHUZ7rD08TNYOXai7zZHDbUq8+lWyBXGC2qQed++CVo5aj
   JrB1RbMgglE0jSGRQr1ANw1vw3ADPbtp4C5t/UXUzrqWK3xbQrOXs8hzu
   g==;
X-CSE-ConnectionGUID: ohFXL5k9TISejkMGIcvyMA==
X-CSE-MsgGUID: ng+g+2iTQu6uYm+OD8Jjbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19465528"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19465528"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 01:51:51 -0700
X-CSE-ConnectionGUID: n9wGwvHJTPuY1R+gTdiZDA==
X-CSE-MsgGUID: C/Kb7beaSS2ItyKr+eKduQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="89633501"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 01:51:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 01:51:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 01:51:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 01:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyZYHmTD6HazHc2PAd+lQmIAFELmsUcQ69voVjK4qh7qer5c/yjmsepTrgJG7VgakC1dmDwPnlh0A2C6JGTNOd8p2dIXcoLPZi9DKzXgGGlXWcl7oEBYFAC+qgGLKjPSAxJpPDPU/jASkQiKOGCUOXxdX+XYCGciSlngLEnBBzchZjZ6FjYQl7CfRTigi51maK0m6IvhvBrBX8o9XE8iGqQYNDmHv2Jy9eYEWV8SVNz+RF7C6Yp5FyuWc/TLZLQ9L/3V8rsl+W3a/vcVjKawY9LW0gFmsWXLT7SL5fC9tCqnL744FqUZ5eo7n2Lj5scJml5ZV9PO52hlsr5YTSX0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH11bkpTZwmHtnNLROa57q6DsRGZBJA9WTgJaAdWiG4=;
 b=S5cyh47bWWg/IXw12mOK25CEXJKOSzDjjPcjbyHpeL0Dh+dk9dsn5flHF9mouMJ+NDBV7ijMl1YZOucs5obUVTG8RxVXXHxGY9qnvsbhzh8klnr8SGtifpQUvYkM/65djytOZmxhMy3/fRlgq747RUncpJYF3GanKHjYjHiYVNWKyYX5xjidNZzr95RNClLVCGBYIGeKF+4hVYLSPh6nnk2X5VqNR19/t+cyskd/roBQwfMz4SzLA7Zgwmbgq+uQrwWvJ+izluyG5H/w3SGUR4EIfBwcxr4GiiWi5I5dteGLDDMMydd534W074CMXIf7SOPvw4ooNuJtlLCZ5BB9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7685.namprd11.prod.outlook.com (2603:10b6:930:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 23 Jul
 2024 08:51:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 08:51:47 +0000
Date: Tue, 23 Jul 2024 16:51:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Erhard Furtner
	<erhard_f@mailbox.org>, Nico Pache <npache@redhat.com>, Marco Elver
	<elver@google.com>, Alexander Potapenko <glider@google.com>, Andrey Ryabinin
	<ryabinin.a.a@gmail.com>, Daniel Axtens <dja@axtens.net>, Dmitry Vyukov
	<dvyukov@google.com>, <linux-hardening@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [kasan, fortify]  2e577732e8:
 BUG:KASAN:global-out-of-bounds_in_usb_copy_descriptors
Message-ID: <202407231547.389c0ad2-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0239.apcprd06.prod.outlook.com
 (2603:1096:4:ac::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e90a16b-f2e9-4a9e-6ad9-08dcaaf4afa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fekqIDyjQEY6f4YjnPDMmoY0Vn4PvybrrHKdh1epmrD7oJBb01vingzU2UTR?=
 =?us-ascii?Q?SzAJiG7TCWYHYPTQ7v8xy/d9eIhAsm89hyuLpCcp8Mn36BfLpnAiINZ9EB+L?=
 =?us-ascii?Q?wzXgQwjE33ZOoCgvFCsjBHcTgoliizCrWSqhJe5r2fiZLXd2a/6EfsKbbehE?=
 =?us-ascii?Q?NCtN2obuKoFEShRqf58Tf13rcf8Niq/Sqr2j1GN3T/rxtJqLwVyRc7e4G9UI?=
 =?us-ascii?Q?DmKZR1L+Naw0MEG1e/7HfxsRpbNYioD/rXGX6tWG5baObV6U9TtEBnIFfJYx?=
 =?us-ascii?Q?GupFWd+EZbUrrJHmIZ6bjrLYuhqooVNab4KwFQjkH/2KCLeOxOYzvfXLQOvR?=
 =?us-ascii?Q?VGhhQ0nA2lEklZEKgqzLb1ZQ5dorjfJuTOYLHTvnfWAnHUZQQ91pNj0yyQZP?=
 =?us-ascii?Q?rOoqowb4Nvi1ZtzCKH7+8Sr9f9z4FNjglwspAARWKieR7LLyM3Ciy44aFnfV?=
 =?us-ascii?Q?A+9g+Bs5T//fWytP0zAekvucrqatfqb+wO1LhIMfQIgLB2GSyDeoZya2Mwn8?=
 =?us-ascii?Q?g9s/nG4nQ4mwuk1zUB16YaYXZEAjs0oNa/gFFO+Q7O8mZjEia28C6hWOLeXb?=
 =?us-ascii?Q?6nZ1xdxAiOLUo7iV+GZiGS9mrX6Wu6u+cB0/0PWe2R044lvM/k9o0c6cUBT9?=
 =?us-ascii?Q?Sb+9b/Ef3n/YY5kX3jfqGFhs17YJ/kGDD45AVNGc8ebgMLFzKtrlpgc8JRCw?=
 =?us-ascii?Q?JvlSa3Pso7En9ZxF5KJS996g9RcAbu5wGlSEeNdTwolj8Be60HOtSEADvBIV?=
 =?us-ascii?Q?AwayHCa+zwPVAz5c/TNxF+6DO4+nBnM0wjEeDxjklIIAY98Fo19oP/4KzKXr?=
 =?us-ascii?Q?/pnGn/VIi8sRajFYfZYVUQBG+/S3n6a25IcLsEs+P0FjMI0V3o34wtZe2Yrw?=
 =?us-ascii?Q?tI7+5TMn4JbTuWFNVmzczsOT+ZDwn5lk8d0sew6vIG9m5Ir3yZSbMcvgZbNz?=
 =?us-ascii?Q?EZI6+RMz2j/jZvBqYDiIyWOsPQIvEvOCpHwyOsEP10VtWgUvEsn3pl4IWh7O?=
 =?us-ascii?Q?+mzzTdKG06ABWaEDGii6cBShT2Hw8EaglYWg4XywvZ3CUE+h5869riBqgi8j?=
 =?us-ascii?Q?JrMujKFoPoduOAtNFDSChGGUNUJQgcovjF0nGeMwZ061y/fKUd5KNOjslVya?=
 =?us-ascii?Q?2r7BJrgOjeATy2xq4lGJefrTeFvgctIRVG8wNX36v7SWtAYYYxHUqqdOghMD?=
 =?us-ascii?Q?bc6E46QfnNDj1soC24vyzOoAraoH/juUfuL3AAhkDpwe9FQlx69lOrPaVXU1?=
 =?us-ascii?Q?C5P9Um7nsv/9ZhkhHd6jmqVAdZuvzcyUoY2MklGz/xFgaNZtudODaoAVFkAb?=
 =?us-ascii?Q?nC9cYxmKWcWwQcHAxoOVXxnu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bAa4n+rldH6POIwGqJs+nOk1Edmime7y9OyR/0EdBM+WY1acKgPmEkwQITOk?=
 =?us-ascii?Q?2CctymlSImIGne8MHq0tzIDvgPoc0ynDVXWPkJ/fBdjD0EMLG3frLJThij5t?=
 =?us-ascii?Q?ltjycyaIEILTS0I/s3JIbQAwmdAK5ywArsRyPIZ2uAxnCU0fATh8MDlMkO3R?=
 =?us-ascii?Q?9DH2kCye2eNCGMcqssAOmFEupvU87IS1gIk84K7s5ANo1zY0y0JbNzTTvRjP?=
 =?us-ascii?Q?cPWfPhG9NxJUmHNc5BB/c+BEfWc2DrKN4++7hvbSZtH1JylG6yh6NYPH9NEk?=
 =?us-ascii?Q?M+33SBrbZI6Tb2gWs+alIKbypu3YeNeAE3awHEvUokeq6AsNGxEsOTy60wER?=
 =?us-ascii?Q?1sLo8nOEtovKG/UANqibEN2Ob0NoVE+uXwkvXKEVRPKAC0Jk0dpG05pS4OGw?=
 =?us-ascii?Q?JzJO/rcaPGY3N1EHjB0IGcp+kDtHL9pHq+ve5incDj1u2ietd3pvJWTiaKDv?=
 =?us-ascii?Q?izPOQ9xlFekVlQo2ljPP/+zlTHYcqdN3APlYQspGLgjSRGhiIDVL3oXzZu24?=
 =?us-ascii?Q?+W0G8KDwD6Ehx7eJoGizie35pMP5S+zc1ZFGzGTct3MBE7ohR4bl0OXyr5jy?=
 =?us-ascii?Q?pQnUkn+GHlgkjVB+tLc8ZCE4LYmVIvyR/lami69xAzce1wLtdycB0/shlq4v?=
 =?us-ascii?Q?NWidSXGxxQ6x/IjPODj2zTWTmbZ1vs9iSwxlnFqDpriki6LKhTYGw27UmwF8?=
 =?us-ascii?Q?xEa47HvdUCfKC/Yt5IOAzpRBqy9ubK7MsYy4V5H1LILFDeLYzfvLU9abK35j?=
 =?us-ascii?Q?Tyw22GnKFOZ/P1O9vb80u14x0RVKV2aNMqmAUVQppX4HgwBL3x2ZT/C9wMwA?=
 =?us-ascii?Q?GM8LJrRcmmJg/DSj8W2qcKk1dqMCz6zuOG545r2EB0Px6gihkzmBLoK2ldje?=
 =?us-ascii?Q?UDEbvdhfFB8TNOtYadQzV9hIBd9FI2vV20H8fjNAxLOwc/HeZ734LXO2yCfq?=
 =?us-ascii?Q?TzkpcjqJCC+FT9QDnjtKO6AjZv+hTsNe5AC3XwUn4IdIijqybzUS+8CCZr3O?=
 =?us-ascii?Q?4m044PfTCko9KIvS7zQlMv7vTgQnb55dBk+fAoYWe9dwckkRHX9z9TdwQS1J?=
 =?us-ascii?Q?m5B2Vs0KqZNtTmQFb8GuPiswN9UPNe2Qut0P8JbLYfimVM1xJGOKiTy8JeUe?=
 =?us-ascii?Q?jNIvjTQIug5Xiy52iWXllWwg1vsqLdJcgaSyNoh5b/jjlUJZu7pTDTES56wB?=
 =?us-ascii?Q?VvcqQ+0S/LgtP1BXg+h9e0zGJTnWUWv2/2RfzNSVGVvtkzoRVP67z/IekIEe?=
 =?us-ascii?Q?Aq4UW3mq9GtOsKgOwbvou8mhRprD1TO/xG4EQ3HVTrTTzESuUlJOqEyA5DuM?=
 =?us-ascii?Q?GxAK4qjCGd4ND7vrXsHGOupnfEedxpHlqhCyrjfpAr98HrH1jOUBpMg8z1ir?=
 =?us-ascii?Q?tBo2lqBIIJAe0iPsdCkq2kE05A3QjvHRzGNkwWiOfUVBCGeSWEGLjChZZTRt?=
 =?us-ascii?Q?RULsit3c8H9kVqSlN476OibQ8xaERpwY1cqyZyRpEww9pwwZ6f2tq8vji0hn?=
 =?us-ascii?Q?nT2Mmcc8FqAr+Z1mxJVgV0iJvR02gJRIxAmn3oSbxZoaUvuQJXz8om5z4w4c?=
 =?us-ascii?Q?Sl4d3+nco2jak92yiQ6am0+WnYwozXn235UoNmxlFtVgcumAtJamSgf1AH94?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e90a16b-f2e9-4a9e-6ad9-08dcaaf4afa6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:51:47.6894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ01gqRKtgdr0xMw8HOdwn1o3Tn627VTq6R2xR3gSvDDmDd5mbfnDgZl3HBjV7xDnk8cgDlz9ZkyWyxRZTnhww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7685
X-OriginatorOrg: intel.com



Hello,

we noticed this is a fix commit, however, we don't have enough knowledge to
determine if new KASAN issue is expected actually after this fix.
so we just made this report FYI what we observed in our tests.


kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in_usb_copy_descriptors" on:

commit: 2e577732e8d28b9183df701fb90cb7943aa4ed16 ("kasan, fortify: properly rename memintrinsics")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      2c9b3512402ed192d1f43f4531fb5da947e72bd0]
[test failed on linux-next/master 41c196e567fb1ea97f68a2ffb7faab451cd90854]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------+------------+------------+
|                                                                    | a38568a0b4 | 2e577732e8 |
+--------------------------------------------------------------------+------------+------------+
| BUG:KASAN:global-out-of-bounds_in_usb_copy_descriptors             | 0          | 33         |
+--------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407231547.389c0ad2-oliver.sang@intel.com



[   25.773129][    T1] usbcore: registered new device driver usbip-host
[   25.774597][    T1] ==================================================================
[   25.775287][    T1] BUG: KASAN: global-out-of-bounds in usb_copy_descriptors+0x15f/0x370
[   25.776048][    T1] Read of size 192 at addr ffffffff90c3e4c0 by task swapper/0/1
[   25.776678][    T1] 
[   25.776874][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-11955-g2e577732e8d2 #1 fc5a69228220b3bda6c63ecfbdf264b31ed62f1e
[   25.777833][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   25.777833][    T1] Call Trace:
[   25.777833][    T1]  <TASK>
[   25.777833][    T1]  dump_stack_lvl+0x62/0x90
[   25.777833][    T1]  print_address_description+0x55/0x370
[   25.777833][    T1]  ? usb_copy_descriptors+0x15f/0x370
[   25.777833][    T1]  print_report+0xb9/0x2b0
[   25.777833][    T1]  ? __virt_addr_valid+0x213/0x3e0
[   25.777833][    T1]  ? kasan_addr_to_slab+0x1d/0x60
[   25.777833][    T1]  ? usb_copy_descriptors+0x15f/0x370
[   25.777833][    T1]  kasan_report+0xa1/0xe0
[   25.777833][    T1]  ? usb_copy_descriptors+0x15f/0x370
[   25.777833][    T1]  kasan_check_range+0x101/0x1b0
[   25.777833][    T1]  __asan_memcpy+0x1f/0x60
[   25.777833][    T1]  usb_copy_descriptors+0x15f/0x370
[   25.777833][    T1]  usb_assign_descriptors+0xad/0x410
[   25.777833][    T1]  f_audio_bind+0xe25/0x24f0
[   25.785907][    T1]  usb_add_function+0x192/0x4e0
[   25.785907][    T1]  audio_do_config+0xf9/0x160
[   25.785907][    T1]  ? __pfx_audio_do_config+0x10/0x10
[   25.785907][    T1]  usb_add_config+0x38/0x460
[   25.785907][    T1]  audio_bind+0x315/0x540
[   25.785907][    T1]  ? composite_dev_prepare+0x22e/0x410
[   25.785907][    T1]  composite_bind+0x1a9/0x750
[   25.785907][    T1]  gadget_bind_driver+0x211/0xae0
[   25.785907][    T1]  really_probe+0x1c8/0x6a0
[   25.785907][    T1]  __driver_probe_device+0x24c/0x310
[   25.785907][    T1]  driver_probe_device+0x4e/0x210
[   25.785907][    T1]  __device_attach_driver+0x161/0x320
[   25.793935][    T1]  ? __pfx___device_attach_driver+0x10/0x10
[   25.793935][    T1]  bus_for_each_drv+0x114/0x1a0
[   25.793935][    T1]  ? __pfx_bus_for_each_drv+0x10/0x10
[   25.793935][    T1]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[   25.793935][    T1]  __device_attach+0x199/0x380
[   25.793935][    T1]  ? __pfx___device_attach+0x10/0x10
[   25.793935][    T1]  ? bus_to_subsys+0xd7/0x110
[   25.793935][    T1]  ? do_raw_spin_unlock+0x54/0x1f0
[   25.793935][    T1]  bus_probe_device+0x12f/0x180
[   25.793935][    T1]  device_add+0x98f/0x1010
[   25.793935][    T1]  ? __pfx_device_add+0x10/0x10
[   25.793935][    T1]  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
[   25.793935][    T1]  usb_add_gadget+0x4b4/0x720
[   25.793935][    T1]  usb_add_gadget_udc+0x160/0x1e0
[   25.793935][    T1]  vudc_probe+0x15d/0x230
[   25.793935][    T1]  platform_probe+0x9e/0x140
[   25.793935][    T1]  really_probe+0x1c8/0x6a0
[   25.801841][    T1]  __driver_probe_device+0x24c/0x310
[   25.801841][    T1]  ? acpi_driver_match_device+0xac/0x100
[   25.801841][    T1]  driver_probe_device+0x4e/0x210
[   25.801841][    T1]  __device_attach_driver+0x161/0x320
[   25.801841][    T1]  ? __pfx___device_attach_driver+0x10/0x10
[   25.801841][    T1]  bus_for_each_drv+0x114/0x1a0
[   25.801841][    T1]  ? __pfx_bus_for_each_drv+0x10/0x10
[   25.801841][    T1]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[   25.801841][    T1]  __device_attach+0x199/0x380
[   25.801841][    T1]  ? __pfx___device_attach+0x10/0x10
[   25.801841][    T1]  ? bus_to_subsys+0xd7/0x110
[   25.801841][    T1]  ? do_raw_spin_unlock+0x54/0x1f0
[   25.801841][    T1]  bus_probe_device+0x12f/0x180
[   25.801841][    T1]  device_add+0x98f/0x1010
[   25.801841][    T1]  ? __pfx_device_add+0x10/0x10
[   25.801841][    T1]  ? __raw_spin_lock_init+0x3b/0x110
[   25.801841][    T1]  platform_device_add+0x376/0x5b0
[   25.809850][    T1]  ? platform_device_alloc+0xc9/0x260
[   25.809850][    T1]  vudc_init+0x7d/0x370
[   25.809850][    T1]  ? __pfx_vudc_init+0x10/0x10
[   25.809850][    T1]  do_one_initcall+0xdf/0x460
[   25.809850][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   25.809850][    T1]  ? __kmalloc_noprof+0x219/0x430
[   25.809850][    T1]  ? do_initcalls+0x2e/0x3d0
[   25.809850][    T1]  do_initcalls+0x1b6/0x3d0
[   25.809850][    T1]  kernel_init_freeable+0x230/0x3c0
[   25.809850][    T1]  ? __pfx_kernel_init+0x10/0x10
[   25.809850][    T1]  kernel_init+0x1b/0x1e0
[   25.809850][    T1]  ? _raw_spin_unlock_irq+0x24/0x40
[   25.809850][    T1]  ret_from_fork+0x30/0x70
[   25.809850][    T1]  ? __pfx_kernel_init+0x10/0x10
[   25.809850][    T1]  ret_from_fork_asm+0x1a/0x30
[   25.809850][    T1]  </TASK>
[   25.809850][    T1] 
[   25.809850][    T1] The buggy address belongs to the variable:
[   25.809850][    T1]  ac_header_desc+0x0/0x40
[   25.809850][    T1] 
[   25.817848][    T1] The buggy address belongs to the physical page:
[   25.817848][    T1] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10c3e
[   25.817848][    T1] flags: 0x100000000002000(reserved|node=0|zone=1)
[   25.817848][    T1] raw: 0100000000002000 ffffea0000430f88 ffffea0000430f88 0000000000000000
[   25.817848][    T1] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   25.817848][    T1] page dumped because: kasan: bad access detected
[   25.817848][    T1] page_owner info is not present (never set?)
[   25.817848][    T1] 
[   25.817848][    T1] Memory state around the buggy address:
[   25.817848][    T1]  ffffffff90c3e380: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
[   25.817848][    T1]  ffffffff90c3e400: 00 00 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
[   25.817848][    T1] >ffffffff90c3e480: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
[   25.817848][    T1]                                               ^
[   25.825831][    T1]  ffffffff90c3e500: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
[   25.825831][    T1]  ffffffff90c3e580: 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
[   25.825831][    T1] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240723/202407231547.389c0ad2-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

