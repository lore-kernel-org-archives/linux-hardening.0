Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E73603C1;
	Fri, 13 Mar 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440454; cv=fail; b=G6e6a1Rnzh7kJWdYNoBfUJLIyIeqHrHv78bqEjvVkczjpUJwJNF3ygjCs0rDN/2hFAWWFOqJdvLBpy/nI/HoLAbgTFqyQhvrZfKEPPaUlRvOmwKLNjJiHJfdORASkCXHki9evGF6eVSX5tet0JFyPfeM4tcLYeXzyeWiparxarE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440454; c=relaxed/simple;
	bh=uasqaz79mMwDV8JCQmFlP1Wt/BKsaS0anEgUy1eraQY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XPVAaT/Dqv3KRseJl/HY1sb4gi1xKePpH0AZYgWZzbdLY4iXYAp0Zjec373+kBL+CQr9dGFyVc6Q+HStML2NIMAHREAnxnV7w1lj47H0KmHrrGX2JX6VhSNdsWUCfI1PPMOlnPeIrf2d3N7UjnjKR+p+eXB8mAqYICmOyzzEVsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdirZPNG; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdirZPNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773440453; x=1804976453;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uasqaz79mMwDV8JCQmFlP1Wt/BKsaS0anEgUy1eraQY=;
  b=MdirZPNGSFI26I5ynBBrb37MrDffQqgPPGk7W117SPgyUVOetR79+oVk
   t7W9ee1kfJNPHlzklSNsDteOwLJf8PIriDQNrNV91t1Ix+M0yjqhnNHzp
   tQXUQV36VWjoCQ6m0zcbnLCKt2Phyf/01zGW9xLD7Qcfp9fbNKlDGRenY
   7eP7kF1ZhgUHKLMC/g0zx6gJRngXnz2qh1E2wp9AQ3WeNkM46jTBlV76t
   WR9zfun4njmrzb3wgTxLr+GBJ1YP7jfsOO8fcyR6NJg4nE44xJkpJhw04
   /AZqUGVhtxBAeCQlEKDO3eMre1lkfJxfJ97q159pHF2E6+kslKusISuWp
   g==;
X-CSE-ConnectionGUID: k+MhG0ZMToyHHjYN39DLzA==
X-CSE-MsgGUID: hShNZIqRSWytLQGPzYMOyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74669466"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74669466"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:20:53 -0700
X-CSE-ConnectionGUID: ePUFEXoUSU2jlU8mW5RqGA==
X-CSE-MsgGUID: YCEkpfM7QLO8iwzDtX+hbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="220548910"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:20:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 15:20:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 15:20:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 15:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgnSpz34HS3QMkkb8k8fLfDnaJvveSiqAgrkoygtIkwI0xlRRCgwUx6FoGfgPqqWMQuBkN4QZyXW+WRVaf2jNSJ3MK7MpMLjqFiE/YUWLBIaHucJZSIEM9kIIHy3WUkiC7EiGGxaiqaDThEHqvev7xEV5wBqHKP1PC1e5mZMWDrs0E8gCGVo5XL1b0tLqpZfDvYAbzy9uIh0aJ+Ad33MCco1gmm3dVZULAImc1peVuR2sCK/hi7LBgG+Yx4XgPMyBYmtyGsl7b0gk7/qtoKxuqE5ffT2sIi20/o5jZfQIxglAooTlFhtcOlXQlV81yAsA89u1pcXkZBCCxa8IcsmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rzFxKXGeGTyykRg/Edke6qDZAQmv7RamvsWoxunN70=;
 b=WD50QIyFgyFdRzbN8ndYa2wDNmZHobDrbCu/v0ikGhJARcZE5i53qqCu5OjmuHhb4EGXFam45Moo1jH8XIZy/CxIlUGlYZcZQlY/KIhnxSDH8udtd9u/ITdIrLzaIcGzYA/1BWEV2A8UmAWIT2pQoYPRCPjOFweBnIzeQJZjuKb9yN0uwY9P47FMy09i4Zq1GOwp1FIwKbCNcXk8U2kZD8w6Qu2y66H34YeTjeOajJ68UJRSW4XduiJmgAkblIK/jCpxWvU/uGpa54ZI3GU/5SAt7mIRfdbgXzC3XH4nNVWpOeak/Stj4NF2yYoihSZZud/0sHTjJ4Rpovzx0P2OjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.8; Fri, 13 Mar 2026 22:20:46 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1%7]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 22:20:45 +0000
Date: Fri, 13 Mar 2026 15:20:43 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <linux-edac@vger.kernel.org>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Borislav
 Petkov" <bp@alien8.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:KERNEL HARDENING (not covered by other
 areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] EDAC/sb: Use kzalloc_flex()
Message-ID: <abSNuzwOw7pVSIJ5@agluck-desk3>
References: <20260313215637.6371-1-rosenp@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260313215637.6371-1-rosenp@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0121.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::6) To DS7PR11MB6077.namprd11.prod.outlook.com
 (2603:10b6:8:87::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6077:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: f4405355-8efd-474c-2c47-08de814ec54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5CuIYhPRX5Asu/yFO37tCVLsRG8TI/NAoW/fzUJ4/ICt/O98NEoBmlsWS89PfPimAWAZaVKQT+8CD2ux+JgYuU3r0Z5bO5Zl5GikCm9kaEsUPBbtazxK/DOM2FqrZ86LUQhLiQkYBdlILXY9XpcEYc6sWaZrrYSBeQhDrmUWplIfEkkvzsz0m4RoYl328mxj2evXxBrWE2cV7t++cN5aA+wC82yFT8+88onJ85rPeKWyKh4qu4m+CnkOR2uGRSIjMm0Ajc0sSDMmaIUIqK2cxO0ZZMWwJ2/DRg7S2u5Ofmos8ly/43QoYxdwdTnUOnvSqCjHpym5pTeBjVxVQ+L4EG1ZsS+sdwdMbHl6A6/vW7YyLDP+2OC1//3o1WJaNetxEz/hd6rLywvWV6oLrbfKZ+6WgGWMK1ydWHPe0s7vdZuSXYLKQLOyQ0BoYpNJC7QYoTkgiFH5/b6GjwiH4Pt8kIshwhYCPpX7XzHJYq4WUdHxL0/6RTPWlzGFUwD2hB2mh7d6VpgfOtxmb0c5nTrI5XtCHOW97rm6HiAsAJGpdQrx1BtVw/PI3ZCYHJPVwZIjzZzeY7f2L+od0tpNJyOsOZ9cxFC/dRHsyxV5O/GpX8nEdBa8C2Xc5dQa2B7xmweKN/mZZ3SR3/R6uc2xhpy/UJ+bsZ2FHzVJrj1ugUmfUfoWd0hwTAzBKweRff6jtIROJxufORNYwQ7prwKSN1qZP9G27J+K1F5io7PMC49XqiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?goN0nukWVegC20H5swK0EBk1DPguW1GL9enJsxXzeW58652V/kZ4XfB71mNN?=
 =?us-ascii?Q?BRvC/7brxiJlp9wy1w9ilFE8WuDSZYmsz58p5gdIBI6scr5G6YkRXE36rmLM?=
 =?us-ascii?Q?LfSvvQy3QzwSSrKyXeR3f+AGdsQf12CcwdAYb5JMd9+PpPvkkC7IOdrPO/x0?=
 =?us-ascii?Q?Y3KHvPJ2+Gc5JOKjvoGulXYTNdzdMfSt6LaZDpA7xSTbp4hjTTIzVM5FqoXR?=
 =?us-ascii?Q?t8vdqNW8GWd/YBuV7r2hpKQ5gwBhLjUjOXCIDpCKYeTCMxB3U6sKiNkbMnyg?=
 =?us-ascii?Q?X/jpJM/5BzfNN6Vhqw4eGNL/ZyTL2mAf1KwbhEQKoWJy0aIYBd/bpLi80fRR?=
 =?us-ascii?Q?u6TYxtznXAXctZFVbDh3J0vwOLviF/16+f/fpYbo7SCpuez+4Yql6oyd4xnO?=
 =?us-ascii?Q?UZ4S+gMQVRabXvYnBrLwf9ckBsOJF2nvqiQQfW+vzn3o9uv4hyoqM878v63W?=
 =?us-ascii?Q?GpXDCCckaGeTGcWlsDhJRMk8advhcQo+lBL8kC+ZY34PKMSG41zO1Eclcg5a?=
 =?us-ascii?Q?5StUJgXU422o1FzraYAflgGGxv4e2YVSjpLo61cygQH0MuLYVXigK3X+Wqge?=
 =?us-ascii?Q?eHtO2iZRpMIowG0JVwfWnwveRQqYAU1eVw9znOpOt4TK9GHJn0kn9SDh8eiz?=
 =?us-ascii?Q?se3QGMQDNRC/BkmBUDh49Hsuvbboa7IutoqNqLwMohaHIPEUs95sMHJg3u+b?=
 =?us-ascii?Q?8e/NHBLNYJmB7/16rxoynFa4Hdw0MRjK5FNgrE9dfHdrljsujxOwbAzj0oGA?=
 =?us-ascii?Q?WplU3RgVNUsz7Df/ApguOJchIYCGQ/u0407HPGYolFVDCTEXxfzrNJhpEh5w?=
 =?us-ascii?Q?88jbJZNgFHDriDpI9dMhWpI0rHOVJi2xzv7i+j9CEdERpDpxvH6MrZJB2lO9?=
 =?us-ascii?Q?jdG4z2glWlbQmQFZCBcvt9Quw3ipwPkRxlONypKxwe6Q02x15Vi6L3MSBwdG?=
 =?us-ascii?Q?M50KxsNoNkTO+cgtwy2PXXSrx9q0pLJaMxLP8K4G/rTmOwviSa4FDnTDmVoS?=
 =?us-ascii?Q?kUYPvEpJWZIfR8mhTJ/t/Rni0EA3Seeclal7EXlmHF1dTT87b2OjDeG4jyib?=
 =?us-ascii?Q?MO8pCqgVH1SeH6NuYFRMb9Hg+Gqngm4uYOFuMP0tXCRA3kz1UCbbDuMFhiad?=
 =?us-ascii?Q?ViCurNrV7fT8tKjarXrLyqeUSAPHXG7ggjmOeVxJmXm6OpQIDglU8LGuAgVM?=
 =?us-ascii?Q?rdJv4hsCamW8+5CXkz1cgsGNlDxespM1ln/g1p+G2nBkhwUyMGYhrG/B46rU?=
 =?us-ascii?Q?9KiSeEPn0PuiORFrj+R7X9feFXKE8y2tjfuwareIyM7dBraXv9K9I89qsi04?=
 =?us-ascii?Q?OT5yzBvPEB/0WuGYdVq4AygQs+E+QMT4a2ASyGLECm4+a+kooPGS0yKL21K3?=
 =?us-ascii?Q?ZpVP/Byasi7s/n1h6GTD16pdLoI1SHv3i05Z24EOjwSb8LwuxraVqSmmpE9F?=
 =?us-ascii?Q?7MZGmSX0TjMDznlLdSZKGzAZQQaZo52LzzQTskUPNzjdXfcYIwVR+1d4D1zw?=
 =?us-ascii?Q?SUA0FWOf5Vp1n+ENEBIca4hnFSwl+hyuIxLJa0y/UFyLx9WMX0ezOFcRAWI0?=
 =?us-ascii?Q?68HiePUgQSr6yjjpa00f/6oBOiCM2fLrF48uRsR97w1uIKIpJ9A0vsRMZxJU?=
 =?us-ascii?Q?IHTN4t5/UfLvPWYtP5UKmBmZBUwoySYlS6bCBuui4wUJPPXoIifg2LBzeoCM?=
 =?us-ascii?Q?LnU9Nysxqry/ZIZ+3WEAd3SHuEnX+7qga2xzz/aTcnCUbQBodsuElWeLB5xa?=
 =?us-ascii?Q?Adq6hYn9wQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: YgwE1zB3MrNwni+CPV9zQRtGAjfcC6qyi3C5YsuVwky8/ZLHB6/XJzMyEfvR3IPKhkvFR9BwjwKTy0+EMdpAtZSZg0/nXBfQnS7OBUVcZKemt2B3b/jDYxhiKf4FjxDhpHdlFi13nKY8OyOxQAS3cuF9u17eah1VzBMO2GXgFKweiHIMBePkDRng+IAea+r6+v25hAut/by6OTUueb1af92sb8fH4L9cd230VPy12N/5xdLaFaLPlGMuiAay7k/9UmKCKMgUgBwnkerYc5KsjnHiTb8i8TPiAc1Lut50WZey5GIEh3eO0q6PYZ7vGZknWK9eTyqiCcoHmhOgFslekQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4405355-8efd-474c-2c47-08de814ec54b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 22:20:45.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksCvDwF4x6bfBi6Oym9KuPSwUSoXuTwn6IXENogq3UNGMKe4T18UsilvH6ja0dssIDrYXrxD9KQslXwNWv51LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com

On Fri, Mar 13, 2026 at 02:56:37PM -0700, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Merged into RAS tree. Will go to Linus in 7.1 merge window.

Thanks

-Tony
