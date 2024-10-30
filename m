Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011D1C460A
	for <linux-hardening@vger.kernel.org>; Wed, 30 Oct 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730314599; cv=fail; b=ucWN6b51v9sb5yZEVX3JOR56pOcU1utVzsxvwR/gGWOf4g7isM1OyN9T6YMAFCrDk65DR6ZvUFzxdv3wB0mWuXwXf+/U/GtQLNe8GoHzfF/9HtsS04Ega1AcfQAGqUhBsNQGx+K1wwEMM7ewKf9ZIgao+8aZgjx+rHWwwuZnmUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730314599; c=relaxed/simple;
	bh=QTia4nk3sF6mB+WF+orwThF/8tYkzZOg6Tpgo7m1LoQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UeufsSC/a809OXAuD3nGbdjdMmleC4wENIXNOYHkF2KzGaBt+/8WqSV1mPxQIOfG2YhUWqemV7bAxXNnWIR4KWLDHazfbdfcx9a9EJG+tfcydIzKtwvBgu7LNRKh6VkDy6+7Z01xtnOF1/0SJ55NIeaalUa7kht8Gjv+uyvVzBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVJK/mog; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVJK/mog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730314597; x=1761850597;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QTia4nk3sF6mB+WF+orwThF/8tYkzZOg6Tpgo7m1LoQ=;
  b=RVJK/mogPhjwoYrFjkxJWZL3npEugov1CPghwwtn69SFIclWLPSIKt1J
   MUAUTAlOzi+/q+MmvhfYGtDQkDyrLFLztQ4QizFEmGUg5aRH5g5laL7L3
   FUlNAv85fnO8H5m1BvBIHVIa2SHXU+8MdefOlCSeUgRkWIUZHmLK7ffWA
   4h0Ku4846EqsbdiK6By/awNnAnE/a2yaI5pp1s1xRj7yqGxPGphtdyvRm
   DQuGyAYu3jHQaLGIXOPwwdYVmZYcl5HBHRUmxnEVELlHwe7tu71vva/Oe
   Ihvz6MVBXHw23cedxsZx0iYJEFNxep7avtIVwNctwGxjUa3PR7QtMzrAd
   Q==;
X-CSE-ConnectionGUID: /ijnWxqeS4usL33kEZPyfA==
X-CSE-MsgGUID: kSI0dSjqSe+bfCNKIPMwhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41135721"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41135721"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 11:56:36 -0700
X-CSE-ConnectionGUID: B/gn4AWhSv+d3DgNDXRkHA==
X-CSE-MsgGUID: vJH/ISowRj2t0gUmfeNb3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82321309"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 11:56:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 11:56:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 11:56:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 11:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhwsdPir2wf57Tksq16kt+sJ+AcABhjqSYu1Gbmh9K64N/tATKfnpYd4lZDOagKEkLry/KsfQ6eRHuOECe0TnorohCVvnWoZQHg7NnfLm/OMiifbduuPNzzFLRh5my5rSs5/K7yL1b70WsqOTW2hY+AKHVPPfXcxIH3lDzUFAKhH2tQbHpDUFI6jV6WxizySs1Rfoh1Ncz9918vygLgQwYJLer4gPF/OpdzKWZV8vUp6afgPskiCngN/eyICLu2leK5wCDkKs6iVcCeIkccH4bQV/muWz+D1M9MSeMpPFninuJfIQGVRhzyAlztDYxDRhrHS5docMOWO4gW9DIcN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OATvord7dSvi6KT9ExpFbP4I98bEvhy2gZdAF/tHcRg=;
 b=rdB0jF9cN1559trvuzA4wreXdri1ssYcPgXWNEoc0WA1OxHexW0F4UJiQAlEwwoKgi5Xg1rNWwOQlWzCPIwa5u2Py/sYa88PVW5n0MgXGBM+gPARbx+hkb/oW9aSlAVssJSKNgn088pplqos678tyqB8HAUhneWNATcajRqsXd65v7OsgVwhjrcTueZvBsXZh/0MtAfRgtAFFEj67TiQjwHecu17xIamOXc/jdAJjTrk+ReDZP60mAjJ4jjgZoDzVAAm7GIVTr2OQ1Yw5u1a9phV8s1lbAXSHYdx4IbvxJK2on6kQ0ih45dm9Us+yvMIavQimirPuuuYRtdTfcD/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7835.namprd11.prod.outlook.com (2603:10b6:8:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 18:56:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 18:56:31 +0000
Date: Wed, 30 Oct 2024 13:56:27 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Nathan Chancellor <nathan@kernel.org>, Ira Weiny <ira.weiny@intel.com>
CC: "Jiang, Dave" <dave.jiang@intel.com>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, Navneet Singh <navneet.singh@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [weiny2:dcd-v4-2024-10-29 9/28] drivers/cxl/cxlmem.h:755:35:
 error: use of undeclared identifier 'regions_retunred'
Message-ID: <6722815b25329_5077a2947e@iweiny-mobl.notmuch>
References: <202410302001.MMV7mxpl-lkp@intel.com>
 <672247c28d533_3ab9829427@iweiny-mobl.notmuch>
 <20241030162522.GA2228266@thelio-3990X>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241030162522.GA2228266@thelio-3990X>
X-ClientProxiedBy: MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdc7da9-bbef-4053-262a-08dcf9149148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dE9RJ1uSARBTB3IYj2Q7uyf7v3H7NM9DnxNXN970zG23OG5W6xfQZbaRzvIX?=
 =?us-ascii?Q?RCtu04eHQoFgdRyfAdVJ5P8n0hG3/GNpsNSifLJ+dIJIy6ho+YfrhHvum8AJ?=
 =?us-ascii?Q?kVbe0R3pWusrrG6Dt+zwAjueacUzOKicllB8+ZyzNI7O+Q0h7Zbt9Ktnsqmi?=
 =?us-ascii?Q?/oDhqoVpvhqHZMrMMpOrJFPF521kphT9jZToIbjFHhuRRU0dTRDEWz9/4N9S?=
 =?us-ascii?Q?ljGkbc3k+qD+ix9Rpbbff+1mmfkDW9dKvXaL3UebH8YEq1pzgRGusT8VqMur?=
 =?us-ascii?Q?0jeZ/noxgogQUwOFeZta6sh2WHFPzUza4FPM5GxeJMOAeDbLPqRAA34f0myN?=
 =?us-ascii?Q?b6lxydeurf8AdUOyubha8ukRLmG/gaMqqff543EWE2TdjkLZNM+kxsoocp7S?=
 =?us-ascii?Q?LJ/sjPb4cyGE+/6iatsDnicOVkfpDN8KCx41EasmuKAjnheDEcZpbWPHdspg?=
 =?us-ascii?Q?E/pqZtzPlGByagFlwxEN3x4PgUFwVVioU+ioeQqxuVA2AczmMZpEzFEDAYpS?=
 =?us-ascii?Q?9hEkcduKpppi/msh2D16/pOqtnA5Tr/cscm43oZQkFM14KU8sqQhFjLK6zWY?=
 =?us-ascii?Q?wSortB3bM2eiueDsUh4v6+lsbkXF8dsgVZQEYOFMVM63KKZUIvvDnPUA1XqP?=
 =?us-ascii?Q?sDuNPC/aXZcGuwIWaVTL56rsVrlT7InGVi7UhsYE/FYBzKpPpTCZB3cWvsLi?=
 =?us-ascii?Q?rLKxcFumUVLdM2xA0S/n/duXH/SVFp8mdvrIfVTnRbUgJPhxTXYvQLn1tN51?=
 =?us-ascii?Q?yqhXwmQVhQk53vYr4ZSaRQUlB2oUvd9S/84qG9NHkbGgT6/Z98jwrEPOPtd1?=
 =?us-ascii?Q?hxPDFMexlfSw+UtvdT4ZFEQ6RtROe2/Kxa6XuYd9Rx8bCh25qYjY/fYGPYsa?=
 =?us-ascii?Q?XKrTAPUDWw5MCtioe7U3qp5YegMWEPFU2rUt9A+Ee207YWjmCtknv8bQhjFx?=
 =?us-ascii?Q?irNYv8DbVglOLiz4qkqxIF0v0zozaA0IhHbGw6R7Q+Sc1fUf5dnIIMqycszW?=
 =?us-ascii?Q?bhRhcX4tWMiGtsPjFO+TvwmA9xvUeWf0OGTM4NEYEttOyTbUUj41xPMOGKCL?=
 =?us-ascii?Q?b1jnnZyWsa7HaCtaKzNrce1dAhVjLTzaV3X00g73RTwDmN8cgUUcPhU6GKfO?=
 =?us-ascii?Q?u32tgmHbTz3kS02O2qX+8InGRieH0SxTNfaOfCcqQRtew1V3sCBSyEH4dTuQ?=
 =?us-ascii?Q?fwvqNKVJdpxLogmhk1p1NvwevC/kxm4tS+K9J+cunEc2ngBdXi7gDugSr8Qw?=
 =?us-ascii?Q?36qZZfrKvZCjTnli4y7pFZgR1j0py2iSdcuDMN5AJs1Hq5eOrWaVfJsk8jng?=
 =?us-ascii?Q?dSsj9q9AeAaDc1ImiAJjmSPN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HzownmTDta15DGGqdzrJOHyU2J+lr5I1INNMUv6e5DrKyNCpDlN9XAi32aN+?=
 =?us-ascii?Q?rWbnjJi1UJfHdAt54L1aeJzOmW2YDmo2rE+1d7shuFpmUZ8805x7mRxF7cCS?=
 =?us-ascii?Q?RxF8DineTfkBoZwRmtmarmMtmxFLec9wyZHs6Z796gkwne54ptx4RKC7oWr0?=
 =?us-ascii?Q?mkfROUicywVly3YAOeuvlYDCx4qN2L4N2BQm0oFyvtjHmpCni+aUXyEflQrI?=
 =?us-ascii?Q?fY9Z0X3EUXEksxYvrhpFcrQvHrmzj2/VmpAu5un7KIWfEhavxY6vj8nTwe9g?=
 =?us-ascii?Q?fZ9KhUBYMBdn0cLU/gdLCgo4+sqJm1qWl82BL6fk9DGFbrh+FF9lIQU2AHRI?=
 =?us-ascii?Q?qE8IiiVgE2PEY5PGCJ0a+nKWr46J3Kvpea/0gKoeV1wJp5D3cF9oOlvbKBeS?=
 =?us-ascii?Q?mFl2NgiEqOcPkrIV0oxS+F67dg7Qbq/moR+f6HZY5P33lV4Mk7JT1L2bYxzE?=
 =?us-ascii?Q?tM9HoEy0E1eBTes3Ij/6Z5HGGDjGU6lDnH6e2LYSvg97BkX5oeEJTkh0T1cD?=
 =?us-ascii?Q?PTARB0Vr97paJqNijY6tnZm/n32cIMX8wsN2EkbZ/wdlbH5JDi0OlBofT6y8?=
 =?us-ascii?Q?AbCBv8C1GZAbOS9n1sJdyy42DPBYKouVrp+22fTdl4S6LI/FvtFzcbBe+T8w?=
 =?us-ascii?Q?0hMXDj+fL/y1nBaZ+1mH3DWyWMm5WodQjRxCM9+taEFgWwYQDL3663aDbel6?=
 =?us-ascii?Q?xMi69LNmfFmtkabQmtIh6I+mM8xN7XeB3ti7demfSCFsh5Ifit7zLqcUIYc1?=
 =?us-ascii?Q?zlNUcuysYhSgCzi7o8H2GEQ9mKySCKgX0PzYyv1SuGbI9kN36r+35e2IYKaS?=
 =?us-ascii?Q?XzYhmJ+5JkPe6hfUID5TN+4pzYuBFLThpLMxPjLdF/N9+iO8ornBGQS1JFFU?=
 =?us-ascii?Q?oq7gRewYNtjwGsUR7GAXL5q2HngHaspx6tX10zGk9UVsZx1MlgdJV3n8K5NF?=
 =?us-ascii?Q?VZFCAzuOkeUVRcFjaTybl61dWVhCjVc0pLZ9cxfpvAcSzghUYiAkD7/izNyl?=
 =?us-ascii?Q?dHoVuXUcdDq3FwWq7YFXojx2K+m5nneO6q3BYrROVKApvf8MX2CXYJEcJDqe?=
 =?us-ascii?Q?2ZYp6MFEu4IV2r7eK8fQuOyNw2iZTVrU1NlIg62OVrUmg86w+U+nc/MsNZ/2?=
 =?us-ascii?Q?OKbXu+BiTTb4zjfnSYfgSxMSwI+6+qKqWgOrwdkBfIvzc2YSpseA9Vnn42uu?=
 =?us-ascii?Q?DpZBkTNB4JkDladYPQ6lyKBQ0NhRzZ++NuW+su7TQ4yklivh0Zb9U3DpmcNK?=
 =?us-ascii?Q?/4GeWtkYWEFK9PqSDtBBcB3nhzchEY6W36R00GKC/1jO0G9fzBBa3kp1zpNj?=
 =?us-ascii?Q?I0jY6f5HwijRuI91AqAugYNO7+4/S2mM/fTUOEu7L3GvMxU/8MhgKiI426A0?=
 =?us-ascii?Q?ePPmQZizda/Cf3IKiySnd4qXkfCAxGREl5t0olYKZOFWRZqSqBFId5gBvW1s?=
 =?us-ascii?Q?5JPYCPcTMcCfZFaduA0nOz1Lul1X0Ye2NqSKBZO34APlAucNsv+H3MRdYJyX?=
 =?us-ascii?Q?3XNHeBjHUZF2w4oc0W+fwbxip9TqRQWOhz4/8Qad22WwtGLhIuijk4Gf1X1L?=
 =?us-ascii?Q?s24az9Xj/xXATll4kqz5yPte6DfX5AYqHG8NaPfE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdc7da9-bbef-4053-262a-08dcf9149148
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 18:56:31.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpMW00Bw/JBoVZKVrBqKYz0QvkvkS5UnuSE6utoE7RO6P9YefWp8r/ic/VRFw9xMnodpKGS8ruE/IrwtSILfZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7835
X-OriginatorOrg: intel.com

Nathan Chancellor wrote:
> On Wed, Oct 30, 2024 at 09:50:42AM -0500, Ira Weiny wrote:
> > [snip]
> > 
> > > >> drivers/cxl/cxlmem.h:755:35: error: use of undeclared identifier 'regions_retunred'
> > >      755 |         } __packed region[] __counted_by(regions_retunred);
> > >          |                                          ^
> > >    16 warnings and 1 error generated.
> > > 
> > > 
> > > vim +/regions_retunred +755 drivers/cxl/cxlmem.h
> > > 
> > >    740	
> > >    741	/* See CXL 3.1 Table 8-164 get dynamic capacity config Output Payload */
> > >    742	struct cxl_mbox_get_dc_config_out {
> > >    743		u8 avail_region_count;
> > >    744		u8 regions_returned;
> > >    745		u8 rsvd[6];
> > >    746		/* See CXL 3.1 Table 8-165 */
> > >    747		struct cxl_dc_region_config {
> > >    748			__le64 region_base;
> > >    749			__le64 region_decode_length;
> > >    750			__le64 region_length;
> > >    751			__le64 region_block_size;
> > >    752			__le32 region_dsmad_handle;
> > >    753			u8 flags;
> > >    754			u8 rsvd[3];
> > >  > 755		} __packed region[] __counted_by(regions_retunred);
> > 
> > I'm not sure why my config/compiler did not catch this typo.  I'm looking
> > into it.
> 
> You are likely not using a compiler that supports __counted_by, which is
> currently clang 18 (although soon to be 19.1.3 [1]) and GCC 15 (tip of
> tree), in which case, the macro just evaluates to nothing, so there is
> no validation of the value to the macro. It would be nice if there could
> be but nothing immediately comes to mind because of where this macro is
> being placed.

Yes Thanks!  That was it.  I did not realize counted_by was that new.[2]

Ira

[2] https://lore.kernel.org/all/67225eb59d0ac_483142946d@iweiny-mobl.notmuch/

> 
> [1]: https://lore.kernel.org/20241029140036.577804-2-kernel@jfarr.cc/
> 
> Cheers,
> Nathan


