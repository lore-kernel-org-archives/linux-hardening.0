Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA919F489;
	Thu,  9 Jan 2025 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736405929; cv=fail; b=SYVucfSLHMT/B5oBCsgv5vOTduDgfV5SOScm7gquCusfGZ/6KdUdR55G7I5soZTiFqUWWbQGdXk0Dc+yqceBTNA+duDqFFie7NJVRjL+TIdi6n6Z+Vhy7hdrM+Jf/8wwYeOdjOiqNCR3ypfYYbDuBMZ7l2ElYAHVrRs9eS1cCRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736405929; c=relaxed/simple;
	bh=RYnMNPeMJWx+tR58kzsSwBRD6HJdiEbUgaWQSmHsz8Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=rwgVRKKTUEJTPcLXseDiqppRPRqGhuCuPIR/BLpB1dOhgw+s6FuNPv454qzOmE5DBRLFLQAVBahdecMHQ60Up2vaeuPzce43Eft4eCd+avKH8vuYAealfVqsRyWYt2Op+SFw5HpYi8ba64OpxWCDRo1U27atFMbGVM+c1bNd2po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOHoUteO; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOHoUteO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736405926; x=1767941926;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=RYnMNPeMJWx+tR58kzsSwBRD6HJdiEbUgaWQSmHsz8Y=;
  b=bOHoUteOjOtZbiF8jLnvGDQenU186nSs9qQQBw752B8OcHlemZvCUnsT
   iQFoxzYWzSLBB9mFd4VUnBrcyEw8nVmOiGEJRYj0JGdb0dwBb9woxfH7b
   wuANukuhwMHZppr79KHJ85KgjYXy8qbwbGLjR2UH89Z2HUvy9BsiU+NJE
   weKaOs0IH7S5kc8sXiKXNKcmqA1Rc/SO5ynCXTXN6C4ennRphzvzW8mC0
   xU9FiApKKqpycTMj4Bj0PjsKzCQkF8LHPe2e9x+zJkuOYnR0+I4raFUgn
   1s8KMQvlRLacv/amQ4bizFGr/VY/X6GQm8l8pWyYOzwohjO36CTFHQHyz
   Q==;
X-CSE-ConnectionGUID: X8DDZEvlTu+IN/+QTTwG4Q==
X-CSE-MsgGUID: xvf1THkCSOuPI3vX93+99g==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36537388"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="36537388"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 22:58:45 -0800
X-CSE-ConnectionGUID: GA/ncn4TTeGFEq2NMEDl1A==
X-CSE-MsgGUID: GS1k5incQ9ywdag43kOGhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="108210789"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 22:58:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 22:58:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 22:58:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 22:58:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCObD8/Fv4kT//fNyHPahgaSOtlo3uhEgEsN5MQ6y8iAhap90K5X4/vYP7B20aXLcEVvdc+rAluTU84aC0ovRQGFqEr0YBFUX8KICEnNmJU8JNtnMI/XqTenzVZZasWxPYYB4Vj40v5rEbLPgLXu22d85JmLePqx2ltT1ZbX8DfrpXZV2QeUZ60U83IpM+VbBzd2EOJwJdFAnL6CbFj54+r9V9dMDRlL9iOCCVKDtc91f3lkdJVBq7eRKmfduRLH9gWAtW69b77K90ZGvJCgDND6ke8A54+H3xX6rwq+R9KeGOUiwJiJYNg2AqjMu+VolaT61uPSm0CLY9ZsVkEULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTWvkOAHZek2CUAgqw7DwU5iLn1Rab0wGPD9sm+oVs0=;
 b=teVPkEtwu4wFQNpOEjHTdj9aCiUNYNLmMeDnfEM2wlObFS8JjScxFDM9D6tyi5VC9p/XjY2lzSB/adGhkx2JbERbGOgUoH+VSP1FvCsueJsAJn/3RtoG7YCbxVr0iQagxfJtyzy2BywFo8vH5eTfSA5w5G+kKy/Bfeh+DXSqaWobzscvmg8wJxqV+/FGNB9V/JqIutKkgyhs4HhTdQHDFpQnO2nc53wfmipKE/tdJpzU+kaobMM2/YcQl9NcF9+U1mJ6fUuaadp0r3ZfLpwRpNQrdGAC27ARxsHUp11j406b77ftCKP2N0UXsLIpsuzlkVp44oWthdGtoXtCfmawEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8324.namprd11.prod.outlook.com (2603:10b6:a03:538::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Thu, 9 Jan
 2025 06:58:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 06:58:08 +0000
Date: Thu, 9 Jan 2025 14:57:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kees Cook <kees@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Nilay Shroff
	<nilay@linux.ibm.com>, Yury Norov <yury.norov@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-hardening@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fortify]  239d87327d:  vm-scalability.throughput
 17.3% improvement
Message-ID: <202501091405.a1fcb1ed-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b631a6b-ffcb-4098-eb06-08dd307af948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?HEO5RKRu7/2Zd9xbsZdiEebkIStQuXyLvlC4W8xdnh6u9k50CI+cfKqRtX?=
 =?iso-8859-1?Q?jRLlCWYxNlnqcBSgntni7cZZzhlEhfGzlP6Y4s8P14fHf+bBiQzjU4nbIk?=
 =?iso-8859-1?Q?C5smQVGJ0Swv28xz9Jbu7LNCBmgUHDdzBH+xF8LlSTsebcllMd/gELzGDs?=
 =?iso-8859-1?Q?4JiBse9WCSssbmMavtcxs+fdCTgr+74fyS7unZMGqP51tN6Rm1wGO0P+LS?=
 =?iso-8859-1?Q?cIs1SatrPa4eNi6+5rgibO0445UnHfVXZtacVH4AntjYaJpJbuyE9jZn00?=
 =?iso-8859-1?Q?W8zshSUzpDvN4o5nZICkl/Y5HlQihDkweihRtGfTUK7n0BV/EBJI5Frqi9?=
 =?iso-8859-1?Q?EX8aERJmNkn10eYAZJv/lEkzyk6/cHe9xQqTaHuZi7jQSE93ElW5pxfimv?=
 =?iso-8859-1?Q?VXJ2+saQplREyaY9tDDrh2A81kfEdYXD+zV8ebtGqIsMiSk4BmL+0l1L3k?=
 =?iso-8859-1?Q?TdlN9ZuOVpqfZLpoZM8CTfYOsFFdET6C2nl7SEr490Ws78GIW0e6u1uV42?=
 =?iso-8859-1?Q?89ICggiacMEyYWcFrZ9ewOhh6waDrzlvXiTHx1JgFviMuNnImqLVJ498WQ?=
 =?iso-8859-1?Q?xt9vurCU7v15yfsYKEuJwspb3CzHcYVrK34D7cXzs+rX+jk7Xf/j6vzJFP?=
 =?iso-8859-1?Q?vFMbEcD+vu2zogayzyWzj4hvkbU2YOD3SurtIUqQ8X7Y7xFtJU5KHFKYQt?=
 =?iso-8859-1?Q?b+kFYUlWsrDRPK2lEgVZlK1HZ2dPP2UOTaCgWkAz3Cr9KnMG6PJ2gmJfQL?=
 =?iso-8859-1?Q?ZXU6BHjf1BZWwDylb1vZ9EtV2L9Nro8XSyOM4EFDbdnxQcaWnhHQT3L7j4?=
 =?iso-8859-1?Q?9hpl/wYrriQ3KXbkxfrJg3icQGDQc0mk7bbvGgOtDW3+/s+m6LwZ85M58s?=
 =?iso-8859-1?Q?D8WLcg//P+AikdX0S4KJkhkwaX0VMy0tjfAWzy8BfLqn1gDaTO5u+rquGO?=
 =?iso-8859-1?Q?Bj88RS0AJfcdPOkYx1wtvc9Qa6Oy3dMJJB9HQVPfnK94DRmuTZOYK30aX8?=
 =?iso-8859-1?Q?N3t3T6mmdE21QfTnPrInfRHzuCtjbqjpbcxAhCnW7yw2SbQCTw0DL729GU?=
 =?iso-8859-1?Q?WM6NAEdLCRLLi9QLZjnueMgr7D4yL0OowI+DzP5g3CWZNMQtMa/U3A4U8A?=
 =?iso-8859-1?Q?amZ1PKI235fXyWd0FdARgJDRQoERJFqDW+n2to31WnDiIbPgTLlPppV4Wi?=
 =?iso-8859-1?Q?OzBXaR+bLabiZp27SC087Z39x7onM9zg6pB0NANdOmCZjFN+tFzL+UjnlX?=
 =?iso-8859-1?Q?S+P7+6U9BuxWeRHArqpOpoOGzcrc9rKHt7emWaXg/rwUB5ORL9YUJ3/kC5?=
 =?iso-8859-1?Q?I4sZDW4u2msw6M9OMvTfcZm4uyd/i/eVOLlfg4vtDYDDbuKdMZL+bsEIjR?=
 =?iso-8859-1?Q?Z5R4h0cCLZTLhhWfssxy4wXwden/akiQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EIUj0mh2XnX8dVhMLzbUfNq0rEAhc74JvbasDRcIQvqfrseTubJBfZE5su?=
 =?iso-8859-1?Q?dfmEQyzct73kGnHM4lHzdDV55tfAAWvCWNP2FZf5nVP9UO3v/Fpe1u4S9s?=
 =?iso-8859-1?Q?4f6kQhTgDjwVa8fO1KkBjLHp6bxmOHxOE/67peZzxMy6etmc3Q5GFJW0XO?=
 =?iso-8859-1?Q?p0lb7hOMZcuYYyw0E7ReidyN8xLa+kyfSqW8u/FwCeY7zu7hcKWUr/mvx6?=
 =?iso-8859-1?Q?PKhRqS3+tda126Ab6Dj3LaM+F+9CipOBKNc8aJFowGpkmYmQ+5OQpoeSGe?=
 =?iso-8859-1?Q?3GQOxMCzl2iZFdzCjZq1JD44zRDMy7zxa/ttqca4OHHwzZP5WlxiclqqCG?=
 =?iso-8859-1?Q?TQy5v4xA1Oel7sh8Ri3VefUIS1m5ru7Mo9mA4QNZ2jHiTueeNy9o+AAMho?=
 =?iso-8859-1?Q?5IPIaOfpx83RvXLsBV762bI3QMieu4T3vuLzRVIx3g4Ju1YkIGlryzaUzS?=
 =?iso-8859-1?Q?JljkbSTT2uciPreNcC9+gnGjn2vtHuBY3eexxux5HPTDt8of3u/AdJd1Vc?=
 =?iso-8859-1?Q?hq1VSJXnikE/nhoxT6fmplIodEI/VekJmPoYjTxMO1f2fpJ00TP46l7La8?=
 =?iso-8859-1?Q?VxToONiEO38os4DQqdUvX0W7YPDbnOBWzF/VH8WbQj1l5u2+BVbqXOaixR?=
 =?iso-8859-1?Q?oqc7s7XXJIJ3CNKPwz6JJOrFfDGUchWpoKYj2Hc/G8v1LRCWomZtlPxMCV?=
 =?iso-8859-1?Q?YX/CRhy/RTQCqgrE1m0/A+XA/Jz/9I2PNsNux9KlnO9CL3enaq0pnu3IN5?=
 =?iso-8859-1?Q?1eNi90ReM96+fOlmI0ZhnkmqrHp0VxMzwbBed8b4zARo2WrfpzMyLStvPx?=
 =?iso-8859-1?Q?njJFRaus0iOBbSDLLUhByyvOejYbxqiQKU3KCAbr1hxtEzUMKRKtKk6YJX?=
 =?iso-8859-1?Q?HDt7+eDzTgdoorenOLGXz1qSWQSp98B+essfoqOU845Btdhy3M4sDT14ly?=
 =?iso-8859-1?Q?mOQMW3dMa3K78Ow/CY+vvlrinrBNnbpp1trDKYJiQVUGsl1Ut0/vpgZclO?=
 =?iso-8859-1?Q?TvUSQCueT2/CglZ/ZsJT+FYCL3R7ayBJN7U5PSEGVGOPmtmAb4rIvwNajQ?=
 =?iso-8859-1?Q?KzkZG4KUwflP88iuvCPFRq46lUUCF33AdNWORlCk3ef3kZ6gT4uuGih5hh?=
 =?iso-8859-1?Q?98AmhW0nkdr/wUckP7gY2w9H+8f4V6Bb31NiXhHM00GF8JUeD273I4Mmf0?=
 =?iso-8859-1?Q?O4dod8pSwgrF1s1C2JqYqU3MbxN43GOCm9r+Q902sV3RIAOzSnRYydYDWy?=
 =?iso-8859-1?Q?UhZyoLKJqG99gpkaN5BrnHrT20ENTkkMOYuJtDRtkTcBRDT/r/sz4x9V92?=
 =?iso-8859-1?Q?ke07KFP5iJAm1oobCk7DCJohs5EdT6DK3VmgYacOuuDMdk+QZK/5uvYRvN?=
 =?iso-8859-1?Q?ze7S1FnawptwDSzo/L6kj1M+S8wOrRyRjkXOZU/Ep/zOGvNg7akX813aE7?=
 =?iso-8859-1?Q?Z0UCR0HGwofgbecR/hH+bf7sVFcfWbSwsceSgn/J8B4h5NK09Ytz2l2n4m?=
 =?iso-8859-1?Q?MAGINYM9U5x7ORjiy0Ks6QT6ML/eluPPXooBHGR+xrcrWGsSDNARG8KKpo?=
 =?iso-8859-1?Q?9sR+VE4R0E0z3NB1o+IYtPThRtCWmYBTUS8cAFCvlA6E16HT/R15XK2lSy?=
 =?iso-8859-1?Q?mFblVChWO+W1G+TkNUzOmr1H787xz3054h3neTo47pA8/8jd/tAqsa1w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b631a6b-ffcb-4098-eb06-08dd307af948
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 06:58:08.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +X+pFE36ptXC7xSFMzFirbKzDG5jg5f6lnIKxP5cR2uc4TEKSYJgZFSKOhvQXwIqOL6By+dG1cCZtgB+8sS7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8324
X-OriginatorOrg: intel.com




Hello,

kernel test robot noticed a 17.3% improvement of vm-scalability.throughput on:


commit: 239d87327dcd361b0098038995f8908f3296864f ("fortify: Hide run-time copy size from value range tracking")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: vm-scalability
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	runtime: 300s
	size: 256G
	test: msync
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250109/202501091405.a1fcb1ed-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/300s/256G/lkp-cpl-4sp2/msync/vm-scalability

commit: 
  f06e108a3d ("Compiler Attributes: disable __counted_by for clang < 19.1.3")
  239d87327d ("fortify: Hide run-time copy size from value range tracking")

f06e108a3dc53c0f 239d87327dcd361b0098038995f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    654.00 ± 13%     +62.7%       1063 ± 41%  perf-c2c.HITM.local
     74.03 ± 49%    +113.3%     157.89 ± 40%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     74.03 ± 49%    +113.3%     157.89 ± 40%  sched_debug.cfs_rq:/.removed.util_avg.max
   9843704 ± 12%     -31.4%    6748836 ± 24%  numa-meminfo.node0.Active(file)
     81609 ± 13%     -18.3%      66698 ± 10%  numa-meminfo.node1.Writeback
   3197765 ± 12%     +34.7%    4307440 ± 12%  numa-meminfo.node3.MemFree
      0.07 ±  2%      +0.0        0.07 ±  2%  mpstat.cpu.all.irq%
      0.05 ±  2%      +0.0        0.06        mpstat.cpu.all.soft%
      2.17 ±  3%      +0.4        2.58 ±  3%  mpstat.cpu.all.sys%
      0.42 ±  3%      +0.1        0.49 ±  2%  mpstat.cpu.all.usr%
   2462818           +24.2%    3060034        vmstat.io.bo
      8.76 ±  2%     +14.7%      10.06 ±  3%  vmstat.procs.r
     12294           +13.6%      13967 ±  4%  vmstat.system.cs
     40339 ±  2%      +6.8%      43096 ±  4%  vmstat.system.in
   6203763 ± 14%     +67.5%   10389382 ± 23%  numa-numastat.node0.local_node
   6274485 ± 14%     +66.8%   10464891 ± 23%  numa-numastat.node0.numa_hit
   6773452 ± 13%     -59.5%    2743979 ± 68%  numa-numastat.node0.numa_miss
   6842787 ± 12%     -58.8%    2819949 ± 66%  numa-numastat.node0.other_node
   7434683 ± 19%     +36.7%   10159657 ± 26%  numa-numastat.node1.local_node
   7522237 ± 19%     +36.4%   10257654 ± 26%  numa-numastat.node1.numa_hit
     16256 ±  2%     +26.1%      20495        vm-scalability.median
      5.43 ±  6%      -2.5        2.92 ± 26%  vm-scalability.median_stddev%
      9.99 ± 10%      -3.0        6.95 ±  9%  vm-scalability.stddev%
   5678018 ±  3%     +17.3%    6661631 ±  2%  vm-scalability.throughput
 1.573e+09           +25.0%  1.966e+09        vm-scalability.time.file_system_outputs
     16615 ±  3%     +27.0%      21107        vm-scalability.time.involuntary_context_switches
 2.099e+08           +25.0%  2.624e+08        vm-scalability.time.minor_page_faults
    561.00           +21.8%     683.33 ±  3%  vm-scalability.time.percent_of_cpu_this_job_got
      1358 ±  3%     +23.6%       1679 ±  3%  vm-scalability.time.system_time
    418.15 ±  2%     +19.1%     497.88        vm-scalability.time.user_time
   1135302           +11.7%    1268430        vm-scalability.time.voluntary_context_switches
 8.846e+08           +25.0%  1.106e+09        vm-scalability.workload
   2478521 ± 12%     -33.1%    1658879 ± 24%  numa-vmstat.node0.nr_active_file
  45774950 ±  9%     +28.8%   58943198 ±  5%  numa-vmstat.node0.nr_dirtied
  45774950 ±  9%     +28.8%   58943198 ±  5%  numa-vmstat.node0.nr_written
   2476252 ± 12%     -33.1%    1657048 ± 24%  numa-vmstat.node0.nr_zone_active_file
   6274222 ± 14%     +66.8%   10464563 ± 23%  numa-vmstat.node0.numa_hit
   6203500 ± 14%     +67.5%   10389054 ± 23%  numa-vmstat.node0.numa_local
   6773452 ± 13%     -59.5%    2743979 ± 68%  numa-vmstat.node0.numa_miss
   6842787 ± 12%     -58.8%    2819949 ± 66%  numa-vmstat.node0.numa_other
  49693812 ±  8%     +20.0%   59611215 ±  8%  numa-vmstat.node1.nr_dirtied
  49693812 ±  8%     +20.0%   59611215 ±  8%  numa-vmstat.node1.nr_written
   7521777 ± 19%     +36.4%   10257607 ± 26%  numa-vmstat.node1.numa_hit
   7434223 ± 19%     +36.7%   10159609 ± 26%  numa-vmstat.node1.numa_local
   2660800 ±  8%     +22.1%    3250098 ±  5%  numa-vmstat.node1.workingset_activate_file
   3153899 ±  8%     +19.5%    3769627 ±  5%  numa-vmstat.node1.workingset_refault_file
   2660800 ±  8%     +22.1%    3250098 ±  5%  numa-vmstat.node1.workingset_restore_file
  53368316 ±  9%     +20.2%   64130806 ±  8%  numa-vmstat.node2.nr_dirtied
  53368316 ±  9%     +20.2%   64130806 ±  8%  numa-vmstat.node2.nr_written
      7683 ±  8%     -20.2%       6129 ±  4%  numa-vmstat.node2.workingset_nodes
  47788357 ± 10%     +32.1%   63105437 ± 10%  numa-vmstat.node3.nr_dirtied
    803731 ± 13%     +34.0%    1076708 ± 12%  numa-vmstat.node3.nr_free_pages
  47788357 ± 10%     +32.1%   63105437 ± 10%  numa-vmstat.node3.nr_written
     30030 ± 15%     +75.3%      52638 ± 23%  proc-vmstat.allocstall_movable
     27837 ± 13%     +58.8%      44214 ± 22%  proc-vmstat.compact_fail
     45835 ± 10%     +88.6%      86440 ± 23%  proc-vmstat.compact_stall
     17998 ± 21%    +134.6%      42225 ± 25%  proc-vmstat.compact_success
  22633426            +1.2%   22911084        proc-vmstat.nr_active_anon
  11444651           -10.8%   10211517 ±  6%  proc-vmstat.nr_active_file
 1.966e+08           +25.0%  2.458e+08        proc-vmstat.nr_dirtied
   3658433            -2.6%    3563342        proc-vmstat.nr_dirty
   9170138           +12.1%   10276853 ±  6%  proc-vmstat.nr_inactive_file
  22567898            +1.2%   22846647        proc-vmstat.nr_shmem
 1.966e+08           +25.0%  2.458e+08        proc-vmstat.nr_written
  22633454            +1.2%   22911113        proc-vmstat.nr_zone_active_anon
  11444767           -10.8%   10211682 ±  6%  proc-vmstat.nr_zone_active_file
   9170083           +12.1%   10276805 ±  6%  proc-vmstat.nr_zone_inactive_file
   3740131            -2.7%    3639414        proc-vmstat.nr_zone_write_pending
  22011951 ± 15%     +33.7%   29430963 ± 10%  proc-vmstat.pgactivate
      2824           +16.2%       3280 ± 22%  proc-vmstat.pgalloc_dma
 2.856e+08           +19.6%  3.416e+08 ±  3%  proc-vmstat.pgalloc_normal
 2.112e+08           +24.9%  2.637e+08        proc-vmstat.pgfault
 2.886e+08           +19.3%  3.444e+08 ±  3%  proc-vmstat.pgfree
      6020 ±  9%     +88.5%      11348 ± 44%  proc-vmstat.pgmajfault
 7.865e+08           +25.0%  9.832e+08        proc-vmstat.pgpgout
    124025           +16.5%     144503        proc-vmstat.pgreuse
   3641011 ± 15%     +48.1%    5392566 ± 14%  proc-vmstat.pgsteal_direct
      2499           +26.9%       3171        proc-vmstat.unevictable_pgs_culled
     29425            -4.0%      28243        proc-vmstat.workingset_nodes
      9.93            +6.5%      10.58        perf-stat.i.MPKI
  4.61e+09           +25.7%  5.793e+09        perf-stat.i.branch-instructions
      0.32 ±  3%      -0.0        0.29        perf-stat.i.branch-miss-rate%
  12693622           +13.8%   14449439        perf-stat.i.branch-misses
     83.47            +2.3       85.75        perf-stat.i.cache-miss-rate%
 1.591e+08           +39.5%  2.221e+08        perf-stat.i.cache-misses
 1.891e+08           +36.6%  2.584e+08        perf-stat.i.cache-references
     12325           +13.6%      13999 ±  4%  perf-stat.i.context-switches
      1.28           -11.7%       1.13 ±  2%  perf-stat.i.cpi
 2.864e+10           +18.9%  3.405e+10 ±  2%  perf-stat.i.cpu-cycles
    343.31            +5.4%     361.81        perf-stat.i.cpu-migrations
    141.92           -15.8%     119.51        perf-stat.i.cycles-between-cache-misses
 1.792e+10           +29.5%   2.32e+10        perf-stat.i.instructions
      1.01           +13.0%       1.14        perf-stat.i.ipc
      5.54           +24.5%       6.90        perf-stat.i.metric.K/sec
    624456           +24.6%     778107        perf-stat.i.minor-faults
    624469           +24.6%     778135        perf-stat.i.page-faults
      8.90            +7.8%       9.59        perf-stat.overall.MPKI
      0.28            -0.0        0.25        perf-stat.overall.branch-miss-rate%
     84.14            +1.8       85.91        perf-stat.overall.cache-miss-rate%
      1.62            -8.3%       1.49 ±  2%  perf-stat.overall.cpi
    182.46           -14.9%     155.29 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.62            +9.0%       0.67 ±  2%  perf-stat.overall.ipc
      6475            +3.7%       6715        perf-stat.overall.path-length
 4.639e+09           +25.0%    5.8e+09        perf-stat.ps.branch-instructions
  12777070           +13.1%   14448212        perf-stat.ps.branch-misses
 1.605e+08           +38.8%  2.229e+08        perf-stat.ps.cache-misses
 1.908e+08           +36.0%  2.594e+08        perf-stat.ps.cache-references
     12289           +13.6%      13955 ±  4%  perf-stat.ps.context-switches
 2.929e+10           +18.2%  3.461e+10 ±  2%  perf-stat.ps.cpu-cycles
    344.20            +5.3%     362.39        perf-stat.ps.cpu-migrations
 1.805e+10           +28.8%  2.324e+10        perf-stat.ps.instructions
    626335           +24.0%     776865        perf-stat.ps.minor-faults
    626348           +24.0%     776893        perf-stat.ps.page-faults
 5.728e+12           +29.6%  7.425e+12        perf-stat.total.instructions
     34.75 ±  2%     -17.3       17.48 ± 87%  perf-profile.calltrace.cycles-pp.read_pages.page_cache_ra_order.filemap_fault.__do_fault.do_read_fault
     34.74 ±  2%     -16.4       18.29 ± 79%  perf-profile.calltrace.cycles-pp.iomap_readahead.read_pages.page_cache_ra_order.filemap_fault.__do_fault
     34.68 ±  2%     -16.4       18.25 ± 79%  perf-profile.calltrace.cycles-pp.iomap_readpage_iter.iomap_readahead.read_pages.page_cache_ra_order.filemap_fault
     34.48 ±  2%     -16.4       18.07 ± 80%  perf-profile.calltrace.cycles-pp.zero_user_segments.iomap_readpage_iter.iomap_readahead.read_pages.page_cache_ra_order
     34.28 ±  2%     -16.3       17.97 ± 80%  perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.iomap_readpage_iter.iomap_readahead.read_pages
      7.38 ±  7%      +1.8        9.17 ± 13%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
      0.00            +6.5        6.54 ± 66%  perf-profile.calltrace.cycles-pp.memcpy_orig.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.do_iter_readv_writev
     34.90 ±  2%     -16.5       18.41 ± 79%  perf-profile.children.cycles-pp.read_pages
     34.89 ±  2%     -16.5       18.41 ± 79%  perf-profile.children.cycles-pp.iomap_readahead
     34.83 ±  2%     -16.5       18.36 ± 79%  perf-profile.children.cycles-pp.iomap_readpage_iter
     34.62 ±  2%     -16.4       18.18 ± 80%  perf-profile.children.cycles-pp.zero_user_segments
     34.57 ±  2%     -16.4       18.15 ± 80%  perf-profile.children.cycles-pp.memset_orig
      0.33 ±  7%      -0.2        0.16 ± 87%  perf-profile.children.cycles-pp.prep_compound_page
      0.24 ± 18%      -0.1        0.10 ± 83%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.25 ±  8%      -0.1        0.19 ± 16%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.08 ± 13%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.08 ±  5%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.___perf_sw_event
      0.03 ±123%      +0.1        0.10 ± 33%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.03 ±123%      +0.1        0.10 ± 33%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.02 ±123%      +0.1        0.10 ± 45%  perf-profile.children.cycles-pp.up_write
      0.07 ± 22%      +0.1        0.19 ± 56%  perf-profile.children.cycles-pp.free_tail_page_prepare
      0.20 ± 19%      +0.4        0.58 ± 61%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.20 ± 18%      +0.4        0.61 ± 61%  perf-profile.children.cycles-pp.shmem_write_begin
      0.24 ± 20%      +0.5        0.73 ± 60%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.07 ± 12%      +0.6        0.62 ± 63%  perf-profile.children.cycles-pp.folio_unlock
      0.29 ± 18%      +0.6        0.85 ± 60%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.04 ± 83%      +0.6        0.64 ± 65%  perf-profile.children.cycles-pp.shmem_write_end
      0.33 ± 27%      +0.8        1.12 ± 65%  perf-profile.children.cycles-pp.page_vma_mkclean_one
      0.33 ± 27%      +0.8        1.12 ± 64%  perf-profile.children.cycles-pp.page_mkclean_one
      0.53 ±  2%      +0.8        1.33 ± 57%  perf-profile.children.cycles-pp.rmap_walk_file
      0.35 ± 28%      +0.8        1.18 ± 65%  perf-profile.children.cycles-pp.folio_mkclean
      0.00            +6.6        6.58 ± 66%  perf-profile.children.cycles-pp.memcpy_orig
     34.07 ±  2%     -16.2       17.90 ± 80%  perf-profile.self.cycles-pp.memset_orig
      2.63 ± 19%      -2.6        0.05 ±101%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.25 ±  3%      -0.1        0.12 ± 83%  perf-profile.self.cycles-pp.folio_alloc_noprof
      0.19 ± 14%      -0.1        0.08 ± 80%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.25 ±  9%      -0.1        0.18 ± 17%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.06 ±  7%      +0.0        0.09 ± 17%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.00            +0.1        0.08 ± 29%  perf-profile.self.cycles-pp.__cond_resched
      1.94 ±  8%      +0.5        2.47 ± 16%  perf-profile.self.cycles-pp.do_access
      0.07 ± 12%      +0.5        0.62 ± 64%  perf-profile.self.cycles-pp.folio_unlock
      0.00            +6.5        6.50 ± 66%  perf-profile.self.cycles-pp.memcpy_orig
      0.00 ±200%    +483.3%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.page_cache_ra_order
      0.02 ± 51%    +269.3%       0.06 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.01 ±121%    +788.9%       0.09 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.00 ±200%    +566.7%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one
      0.01 ± 17%    +174.5%       0.02 ± 76%  perf-sched.sch_delay.avg.ms.__cond_resched.writeback_get_folio.writeback_iter.iomap_writepages.xfs_vm_writepages
      0.01           +20.0%       0.01        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 17%     -69.3%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ±  9%   +1197.6%       0.09 ±128%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.04 ± 25%     -40.3%       0.02 ± 30%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.01 ±  6%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.08 ± 68%    +450.4%       0.45 ± 22%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.15 ± 34%     +78.2%       0.26 ± 22%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__do_sys_msync
      0.01 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xfs_file_fsync.__do_sys_msync.do_syscall_64
      0.00 ±200%    +636.1%       0.01 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.page_cache_ra_order
      6.00 ± 95%    +186.8%      17.22 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ±162%    +320.5%       0.13 ± 48%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.00 ±200%    +876.2%       0.01 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one
      0.01 ± 52%    +221.1%       0.02 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.xfs_write_fault.do_page_mkwrite.do_shared_fault.do_pte_missing
      0.12 ±153%     -92.3%       0.01 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.35 ±155%    +263.8%       1.28 ± 44%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      2.22 ± 44%     -50.9%       1.09 ± 23%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.32 ± 25%     -65.3%       0.11 ± 12%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.01 ± 10%    +105.6%       0.01 ± 61%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 62%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.01 ± 35%    +140.7%       0.03 ± 25%  perf-sched.sch_delay.max.ms.schedule_timeout.kswapd_try_to_sleep.kswapd.kthread
      5.35 ± 13%    +120.5%      11.80 ± 30%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 27%    +105.6%       0.01 ± 29%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.04 ±144%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__do_sys_msync
      0.02 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xlog_wait_on_iclog.xfs_file_fsync.__do_sys_msync.do_syscall_64
     34409 ±  4%     +31.4%      45208 ± 19%  perf-sched.total_wait_and_delay.count.ms
      1.05 ± 66%     -97.2%       0.03 ± 59%  perf-sched.wait_and_delay.avg.ms.__cond_resched.loop_process_work.process_one_work.worker_thread.kthread
    533.92 ±140%     -97.3%      14.58 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
     13.99 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      4.37 ± 61%     -80.6%       0.85 ± 49%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     26.95 ± 25%     -40.1%      16.14 ± 44%  perf-sched.wait_and_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    128.59 ± 17%    +229.1%     423.13 ± 16%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     40.40 ±  6%      +8.7%      43.93        perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
     70.57 ±130%    +604.7%     497.32 ± 31%  perf-sched.wait_and_delay.avg.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
    328.60 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     10179 ± 15%     -97.7%     237.17 ± 45%  perf-sched.wait_and_delay.count.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      4488            +9.4%       4911        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    214.60 ± 24%     -70.4%      63.50 ±  8%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2937 ± 65%    +699.5%      23480        perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    803.09 ± 73%     -99.6%       3.53 ±183%  perf-sched.wait_and_delay.max.ms.__cond_resched.loop_process_work.process_one_work.worker_thread.kthread
    533.92 ±140%     -97.3%      14.58 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
    462.45 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     49.56 ± 39%     -57.7%      20.98 ± 47%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    110.68 ± 24%     -65.4%      38.31 ± 44%  perf-sched.wait_and_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     49.88 ±  7%    +167.8%     133.58 ± 54%  perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    261.23 ±122%    +620.9%       1883 ± 41%  perf-sched.wait_and_delay.max.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
     16.91 ±122%    +139.9%      40.56 ± 31%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.xfs_ilock_for_iomap.xfs_buffered_write_iomap_begin.iomap_iter
     14.02 ± 65%     -94.3%       0.80 ±200%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.do_iter_readv_writev.vfs_iter_write
      1.04 ± 67%     -98.2%       0.02 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.loop_process_work.process_one_work.worker_thread.kthread
     17.79 ±200%   +1124.8%     217.93 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one
     27.14 ± 32%     -38.6%      16.67 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.writeback_get_folio.writeback_iter.iomap_writepages.xfs_vm_writepages
    531.34 ±141%     -94.0%      31.76 ±108%  perf-sched.wait_time.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
     23.22 ± 49%     -78.0%       5.10 ±107%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     13.99 ± 14%     +72.1%      24.08 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.40           +15.0%       0.46 ±  4%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.36 ± 62%     -72.2%       1.21 ± 39%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     26.94 ± 25%     -28.1%      19.37 ±  3%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      4.12 ±  2%     -25.7%       3.06 ± 13%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    128.58 ± 17%    +229.0%     423.04 ± 16%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     14.18 ± 30%     -71.0%       4.12 ± 57%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
     16.09 ± 62%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
     40.15 ±  7%      +9.3%      43.90        perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
     53.98 ± 17%    +554.9%     353.50 ± 25%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±127%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__do_sys_msync
     36.56 ± 50%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xfs_file_fsync.__do_sys_msync.do_syscall_64
     79.98 ±107%    +521.8%     497.31 ± 31%  perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
     35.31 ± 50%     +40.6%      49.65 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_noprof.ifs_alloc.isra.0
     16.91 ±122%    +185.9%      48.33 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.down_write.xfs_ilock_for_iomap.xfs_buffered_write_iomap_begin.iomap_iter
    560.10 ± 61%     -94.7%      29.57 ±221%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.do_iter_readv_writev.vfs_iter_write
    803.06 ± 73%     -99.8%       1.82 ±176%  perf-sched.wait_time.max.ms.__cond_resched.loop_process_work.process_one_work.worker_thread.kthread
     35.27 ± 38%     -56.9%      15.19 ± 62%  perf-sched.wait_time.max.ms.__cond_resched.rmap_walk_file.folio_mkclean.folio_clear_dirty_for_io.writeback_get_folio
     17.79 ±200%   +1874.3%     351.31 ± 41%  perf-sched.wait_time.max.ms.__cond_resched.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one
     53.77 ± 20%     -45.7%      29.19 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.writeback_get_folio.writeback_iter.iomap_writepages.xfs_vm_writepages
    531.34 ±141%     -93.9%      32.25 ±107%  perf-sched.wait_time.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
     36.60 ± 50%     +51.7%      55.51 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.xfs_write_fault.do_page_mkwrite.do_shared_fault.do_pte_missing
     27.41           +19.5%      32.74 ±  5%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.56 ± 39%     -49.0%      25.26 ± 12%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    110.67 ± 24%     -59.0%      45.33 ±  2%  perf-sched.wait_time.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     39.78 ± 33%    +428.9%     210.38 ±167%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      2.53 ±  3%      +9.8%       2.78 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     41.46 ± 63%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
     49.87 ±  7%    +167.8%     133.58 ± 54%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      5.77 ±175%    -100.0%       0.00        perf-sched.wait_time.max.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__do_sys_msync
     92.08 ± 21%    -100.0%       0.00        perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xfs_file_fsync.__do_sys_msync.do_syscall_64
    290.66 ±102%    +547.9%       1883 ± 41%  perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

