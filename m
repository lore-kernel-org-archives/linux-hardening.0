Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8971EB3D
	for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663006; cv=fail; b=jJz46ZEPfX1Ww5nb002LHfqTSpY2+2L8lB6g3x9VsetADlFkDXNyguvGDa+e11OBnxCSSDSYlFIOUiwUOyrK1KyiiMfmVpk3JVLJRx93iDTAlrIAkOgREKv8kunG26uPsVwKA35cJejcuXGf79uckdn+yooZdyiFXSyClPe/eAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663006; c=relaxed/simple;
	bh=NfAvTKyWj5jrgxMDKlTA6A/KtmPXAldm8DzvsHHhwuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oi7hwzwwkfZy7l7Hw/n/nQa+CExn4XJy/8AeRWFleduOMpzIiTPZ6ptRw7qNwCNnFEbVHoFI0wdy75rsWJ75CZb657lNpkL9C+cC93EYRMmDcLsINz6DnZd3cGJ/BzXEb7TplwaFBSyV+Pd4sYSVSjqRptmjzKacxtseaNMjae4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diDUvDkE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diDUvDkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741663005; x=1773199005;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NfAvTKyWj5jrgxMDKlTA6A/KtmPXAldm8DzvsHHhwuI=;
  b=diDUvDkEl8efgOV9zZXhEPPqyig4YJCFfiFS9hdORXfNL22FanmUK5ic
   1aZvaK6jId73hWggSKMuaUp9dF8gHGvrkJjcIxnIqwHMbBbYNXaNuNUGx
   zqOIBJyiuofkj0PkYqqDp8hNatGxKyFMYRHYxv/cUl+ZNXdi1PGH2dbje
   VDIPTGwJ2Z0PjsrTyl3l7gSVfNwVdg6ocwBX3li6K64HJOaJAziA5wxoA
   VHFapgvpgPTjLe3R6/37EySpSF2yvGdPRxeDzhXuOaAs7FRu0uo+RYTiB
   io2IGdsB6dVSuv5efWh2ExbpOZVO4g87GiJL8oKZPIsi2lXapSNQeOgrt
   Q==;
X-CSE-ConnectionGUID: K6xwV2pxQIWtkZkBwQ/Vpg==
X-CSE-MsgGUID: NYf50ZnhQHmzgo47qDxWbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41930282"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="41930282"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 20:16:44 -0700
X-CSE-ConnectionGUID: grfd1tcmT0uKwqh1LLxkrQ==
X-CSE-MsgGUID: Q0/NpIS2RN26OL0mkUl93Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="119914484"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 20:16:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 20:16:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Mar 2025 20:16:43 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 20:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAhu5TBPyRq6HqlNyrQBzNSA8Be8Zzryh35ktApBxs6wOhWodK4lUAGD+Z11cAHf8AgaNAcJqM6sfoqQnlmMaGIU0Z+vPNTrk+i23em5k1R00D2UGYvc8t0oBCpKK8AxpO38zKB+aaOjhmCF1hD08h5a1Ef8fhUKUVKGPgozp/KHfIPSX/xO2L4mY+1AozjQOug+yYV9OhzTofH0JXH1ubU6Fu85Y8i5StOLgjrcKpckaPLQpI3lbKN3yqC0sKOdngVqOuSzkLHrzXOhgafjiF58TZMMbSMv7mPpL5AwMVj6Ua9v5V52Tn7eVASol0aVHNSF46R/6LAlTZVWUPOSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8hUuwT7UJNOa2Ls0BIFQXJgdlGDAVLn5dcHzH7X1Vw=;
 b=Y+Shi/BDcnCAd3BTMDj3kq9NGwUnfweXpCDChUick1OIzLDOgOo84nn9M2+lBVZyGCncTm9r/0hSt5gIjH3WLr9qz9oTokbxAg2NNS1plu2CDqvXZXtqMRSrZAuG8QnXlP+i9xqvmq6sISd62kN7P3ymOHsDFz8BjbZJllU7HcBhwBdnNnvaUTZHOcuyg/W72Na4Z3IjrhefOqJJ7DL4lHt7P6V5l5NCoyj+P894HpLxUcLEs/68p6B5589H8uDbcIrLTYxd9uYTMGV4z8I4ULQvUyUZ4OaWlveg1C/aDdvf3rc0Ax++BcYhxCMzljl5BzAKWLGY1UGJqKmKrgQ2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by IA0PR11MB7380.namprd11.prod.outlook.com (2603:10b6:208:430::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:16:40 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:16:40 +0000
Date: Tue, 11 Mar 2025 11:16:32 +0800
From: Philip Li <philip.li@intel.com>
To: Kees Cook <kees@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 1/3] ubsan/overflow: Rework integer overflow sanitizer
 option to turn on everything
Message-ID: <Z8+rEBNjtfwrH2Nh@rli9-mobl>
References: <20250307041914.937329-1-kees@kernel.org>
 <202503101035.rpwDzqYD-lkp@intel.com>
 <202503101111.74738A99@keescook>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202503101111.74738A99@keescook>
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|IA0PR11MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c66e6e6-d0c1-4df4-974b-08dd604b2434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kytR7qsbasmNfUusRYFFqQNRCG75ol4/PU5fxOIWtS4cdMdSzJbiIcyPa+D5?=
 =?us-ascii?Q?9deizxy1KuuB5mopSQR1T5BjIOJ75V+dxS7waPPr/gKEFSlxBfqOjnDyvOaR?=
 =?us-ascii?Q?wEPG4U00cisobP7ZbT3RvAntMynaobJkMoJ6jBV5tzA+p8Adtx1pWMkwfiWS?=
 =?us-ascii?Q?NjFasWPrj1tJHVyJFNRmX6XsmHzcxRAsGu0aE4g238SGaovPwvPyQu3M9s9N?=
 =?us-ascii?Q?7MBw2i94JOYPqUOuTMuLrgfFX3qsZ3ynYVsoIXQ8w/8Em89Xc+dntW2cUO3W?=
 =?us-ascii?Q?e+PdS6fBxTx77Em3vU3NyZ0Chy8gisRE2aqWZ+vwHXT+QNENJzJ5ziktZj98?=
 =?us-ascii?Q?VrCFNmjxSVobjtv5vmYJ0EgjDXVRbWlvz5TTSwhOAK7VMY6SUIrpRDBCd58Q?=
 =?us-ascii?Q?aQeonqINRTmYUhVTfobm+MQJNpJ0+CsgFY/6+EhoUxuQKW4JeZV7/8InqL7F?=
 =?us-ascii?Q?gzSaG/5n1XN7OeSz5DB18uvwCc6+VpVorOH+24pjrMh/ZuslNsKGder+JU/A?=
 =?us-ascii?Q?eLRfH62x/1zsPDnB3QE22ZRgFXQXblDxm0pYiUY/4gRN7qSZpTTYGenBfqWT?=
 =?us-ascii?Q?m8ZDOEoHk5hEOR6jVOJzWbbeHbq0xtyyUlZnkUzWUSC1WGKInMAUVeNWa/xp?=
 =?us-ascii?Q?bz3IxuvJSNszSnHEmRvpZzYIAfvYCpHW6quqJyHCOGDChepf2/W8WVlyoazE?=
 =?us-ascii?Q?/JvBhjEkIeSMLN51nEh8rg0xIhKry9SOrqHjyglq+JaWcxqRL2SjbJDJBLf1?=
 =?us-ascii?Q?xWYGZeJ5aJ/fFrtgY/xGv6rnITFErwfZTYOdBpMnR3g2Vg/S9VCwU5O7a0Bm?=
 =?us-ascii?Q?FP4bGObppKb3Eluep/us4R/cCN4qO3kntcmuNKDzRhuyRTNlZlpO4eEsSkAU?=
 =?us-ascii?Q?ttzSb1fyftrYw6jzIc+xl2sAszLKMfNXqgFJYDoMBXabztWZsKePfx4y7vj2?=
 =?us-ascii?Q?OXkHb55ICXFWSC6cVgcDTCp3RsP8nvctY4jX6a82JHECwyLdAjbk1tkz6wYy?=
 =?us-ascii?Q?cPRFH7jYR1Tjr50ze6ZjWexocxHgficHx7uRw+tiFUG7XdX1RcttqlZctlHu?=
 =?us-ascii?Q?Jsea5460PEbIMdcdKSl6WOrOSsuZTP5XqagcskJnQZVSZlH3NkpNfwA6vQnP?=
 =?us-ascii?Q?ShZ8lURzeGiTQCwy/8f4dBgdk0VoRsMFwRZLVOD0iplfVJlajbPCDrIhWJRF?=
 =?us-ascii?Q?mx3OJ4cp+bxLykFpWUOmqtdIJwoaPGGdwHXCS+m1a9xIjXagcsttrsgn8uI2?=
 =?us-ascii?Q?SZ/fmUpB5mMuUnDl6ZvYYUA7KewV0zYz4l0EreU3pw81fpHmhWLSizQgkXOn?=
 =?us-ascii?Q?BJFIYyh0y/MXWyhFqXdwj4UxmZkCfV1XkFSRmfRsq2Eq9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?77CIRLC0sbh+y07jOzpkcVeaso+HsQ75NkL9DLIBjoP2WDMkn1xjj7j/BRIg?=
 =?us-ascii?Q?sleSWO9kGDHAhHtvutLti7IeBwXrEtnTf5M5BC4nitUgejWZNQQuk3gTyUFQ?=
 =?us-ascii?Q?rm1aVosFnOvidORlea4mC6Hw9QKH5eThSqvNitAFoXK1pl7JdgToFAo9l7OM?=
 =?us-ascii?Q?k1bPmlej0opjZTeE9ZQnR3Z+6cR7IK8q1NDpH1VmGKQ0IHf90tJOjkF3pX0B?=
 =?us-ascii?Q?GR0vtVehnm1nhJxArS+p69mk8M621Em92tOtbBimaXdDyRmZ4rocxujdaNDW?=
 =?us-ascii?Q?BZ4lU5JxwQr8RwPjW3fvvLE2oI3VJfj0EZkBp0xjku7Sk8Uh8QWk6tlMMECv?=
 =?us-ascii?Q?LpnPpOL5r/Ayd+VOffqeX0blev83lFS0FYhWzq8gE044s6ingvt4OipQXO4i?=
 =?us-ascii?Q?haN8GxakhJOEg9zmBwwEc12F6+ESMFn4CWtOTnGdLU2DRC0XZjSQ99IeL8Xf?=
 =?us-ascii?Q?mORS3R353ayArYRV+9L7oeNylk2rB30h5rk5EpYE8DRbJDJW80+eafdWPaH3?=
 =?us-ascii?Q?q4ob2nuKxTi0tChX850D6UZuG+hDuMaagynDnpPUXOTF/CxjcrtV5irSJQNQ?=
 =?us-ascii?Q?XmgprV86t1CJQILkq/dZLmXGFU1uPZifbUecmY9QU5dCzuPRB1iI+XUefGeQ?=
 =?us-ascii?Q?MCF2FE+PH2BCSEf3y7UePBFfhGYx+9FG40WLuvYvlrYKiuMUHkyu0fwPLCho?=
 =?us-ascii?Q?7UHOhBQgS+1O8b8vdLeMieBKd146AW78STa5BRQ6Cad2oQ5vXZebPBXMF84m?=
 =?us-ascii?Q?AUbaAzqVv/Z8a84HUnm+ezTzI4+TgRw6MeC85H9rgOB7wrkvKHtHlSLIXijN?=
 =?us-ascii?Q?YN8zP77lxHEelAl3vZCoh5qOCzU7OJvhmICfCioqVn4eVmKDKem9FVAuESI6?=
 =?us-ascii?Q?phFrjwyuFx/FcQ3KiNJtorURonxo+1YFNvP0K9t1N6vOfxqEBhqpr29P0nwi?=
 =?us-ascii?Q?dIf8C/628DOJ0noXm/fkiKqSGPQ0wQkITGmp/ru+dh8/cJk4vqAcd9y1vA3s?=
 =?us-ascii?Q?QHIeRCPBRuw7BEHlu9ri3q9dVx99aQTFplrlWSG9QL3UZsSbUhAik8tlLzoa?=
 =?us-ascii?Q?whDX2cUVlEAh/tU4HT9oUlQUtcWb0cFdedtELbx2K3YQnjyaPuLTSeWvFxc4?=
 =?us-ascii?Q?F57TPrNQAtfz1AckQdmZNGZMnVHBf58vsRL6nWKHz3+VVFVhjZhXtPaPgrWN?=
 =?us-ascii?Q?zLgGkTTHjWp6z90v4KH5sZrwqwkOFWLmupG0C/45iW2rJQQ61cxKjyofduP9?=
 =?us-ascii?Q?5aKt79xp5uS5tSJ6azyp44nea9e1wh9PArjrBTeXwM2oPx85Dra7nbQJC5B9?=
 =?us-ascii?Q?eppJdu9iD2MAJk/CM/TJ196K6GQskUj2NYD62nE745gu+A3FFr+3YnbmO/lt?=
 =?us-ascii?Q?TBPYOz/y3dPGL9iyAXyd6L7Q03B1w4X4mju3bnM+YsOvP/wwVslU7k9Aem30?=
 =?us-ascii?Q?EwOk8+xWAQrE6uKPmCDvHYgltPnaZI9nDbL7LTZWMvZJfJRwv0UCWALLpoQ8?=
 =?us-ascii?Q?lBKVpRIJFIWwZZXQjFmeNd8KmO3+FTwbf0AcVGbe7GR0KMe9W4HV5R2btVDm?=
 =?us-ascii?Q?+/z6c1Es1MepGv05SfXywsxOtOKCApWUzLx5juOx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c66e6e6-d0c1-4df4-974b-08dd604b2434
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 03:16:40.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aexz8ZMbtBKMsQTv8SfUUL7N+ZSLepubIK32i2yFDMJTI5skpvo2+1TpwA4/zxls+1PnUYn3WZLuMaFj+L16og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7380
X-OriginatorOrg: intel.com

On Mon, Mar 10, 2025 at 11:12:07AM -0700, Kees Cook wrote:
> On Mon, Mar 10, 2025 at 10:54:12AM +0800, kernel test robot wrote:
> > Hi Kees,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on kees/for-next/hardening]
> > [also build test WARNING on masahiroy-kbuild/for-next masahiroy-kbuild/fixes kees/for-next/pstore linus/master v6.14-rc6 next-20250307]
> > [cannot apply to kees/for-next/kspp]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/ubsan-overflow-Rework-integer-overflow-sanitizer-option-to-turn-on-everything/20250307-122130
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> > patch link:    https://lore.kernel.org/r/20250307041914.937329-1-kees%40kernel.org
> > patch subject: [PATCH 1/3] ubsan/overflow: Rework integer overflow sanitizer option to turn on everything
> > config: s390-randconfig-r112-20250310 (https://download.01.org/0day-ci/archive/20250310/202503101035.rpwDzqYD-lkp@intel.com/config)
> > compiler: s390-linux-gcc (GCC) 14.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20250310/202503101035.rpwDzqYD-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503101035.rpwDzqYD-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> > >> lib/test_ubsan.c:62:16: sparse: sparse: cast truncates bits from constant value (7fffffffffffffff becomes ffffffff)
> >    lib/test_ubsan.c:72:18: sparse: sparse: shift count is negative (-1)
> 
> Can we exclude certain source files from sparse? This whole file is
> basically an endless series of intentionally bad operations. :)

Thanks Kees, got it, I will update the bot to handle this to exclude
this file firstly from sparse.

> 
> -Kees
> 
> > 
> > vim +62 lib/test_ubsan.c
> > 
> >     55	
> >     56	static void test_ubsan_truncate_signed(void)
> >     57	{
> >     58		volatile long val = LONG_MAX;
> >     59		volatile int val2 = 0;
> >     60	
> >     61		UBSAN_TEST(CONFIG_UBSAN_INTEGER_WRAP);
> >   > 62		val2 = val;
> >     63	}
> >     64	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> -- 
> Kees Cook
> 
