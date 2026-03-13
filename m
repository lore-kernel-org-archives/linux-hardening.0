Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBA372699;
	Fri, 13 Mar 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440406; cv=fail; b=BybJtLVc/ihL/Brrx3DlHPqA72+qKKbZngbr/3eTznIxJ9UmAofvxw9wsa+J6DaAWFOLfqA+eFRJuJMgBd7UkLVE6IXj//H2joCQbqnSGWnrlus/2aJx4hWRtHZgagG/WVFOXSYZmu379PX2QMsJw0lkbORcE6/A02OHqSqCuuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440406; c=relaxed/simple;
	bh=UBVASD8Fs2LN6oKhqjenCNy99Y8yan8CMxt//tZhKfc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L2UetPscGrAYV23/yi5Tc9aQKzdjtOEoW07lCku96OCdKoWR+/C3jJYYDOBlUEny9iybgJJffSgxYZjGUOABUL11Wl7CdQD7MaEAox3GrMsKSg0MQOI6cOLJZEAvHR6dQsk98frGFoAVwooj3TeVOawLyS8VgGpqkls49a7jZa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gX8fZFLg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gX8fZFLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773440405; x=1804976405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UBVASD8Fs2LN6oKhqjenCNy99Y8yan8CMxt//tZhKfc=;
  b=gX8fZFLg6/v4JTK1mg6DnGmhfJ93q/vf7kBU2NcHF5ZuRQr+vO+Y+0RB
   KNBNI72XIsr4bgjiqV1Wh9XprCPg+MQliz5x0IwPz+7XpLP7cAswaUMzN
   8V2ae/BA5C+aVy1XMo7MtY0vGID26+a2lB0dD5r8N3/5PSVZril+2Sg6k
   dGXnqiPJAOfqLj9YXLbHr2GlYYx2k14sTJ4EMTQHAuW+3S1oYV2CnMasf
   oKpT8NvMso/jrXq8A3/e5fbsx550GJXkYufnI7eqx8rmM8T1lpsEl8ng3
   Bva10YhsgS1z7R7fHzScelMvRNB7CuW2vd3wuSF13NQB1bi9f+xSbRZ8h
   Q==;
X-CSE-ConnectionGUID: IGesu6+WQr6cpwm5bgD8tQ==
X-CSE-MsgGUID: sHjLv13KTAm2Q1WZdCGjXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74669432"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74669432"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:20:04 -0700
X-CSE-ConnectionGUID: z5BBC4a/TVOFq0JX6bca4A==
X-CSE-MsgGUID: Yh8f6N3iQ0S4EwcPhtNJZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="220548806"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:20:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 15:20:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 15:20:03 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 15:20:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvWuXvoiJBvKkduL8MJUHtLtyBCC4t2Yd2OPvVH/IjxWouVngrI1iFm5WHxF1Pjp60mBlflegLyU4pTC8/KVAt+sR/941rRW9o+R3XlvbBalhSJL+iAB3sEJx7+CeX0S4WLdWrl2C3zGte4AgBAOfq4tZoSy65IFmf3nyZeVKG7WYg6F85oA4o4/PCngkMobiOcCPuVKnk3Wt5Tv/OTCCqNa4877skWIxdcOscF1WwA5fnsuU9zQEFhvxYp6BkFyXDnQoHtGZpT8sp5MgepyijQNg3dKEvPue8s5EkWvUAFMtgHGH6ay/0JKBM5ugY6c/sXr664M7baYOQdHElvrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQml1P0LHKeZH6dtnTa3BcfzSkowtff5pA3KODSQ1Ms=;
 b=PMFLn43Llr6iV8al1ynGFuKPM58QbjTaRAISu91vck6ZaOK7rrPaXHl5zXePHcvOqmTUaxtGI2jBMdXdjjlnPVrafFI+va3t1pr9gMOBM9ADi3Q1JUdeniTSNwTXCvdWDrANZaO3Nz9zMHJ+1yidPbrI8Z2W3NLqrK/i6NFIq5u7RKnwcB552cf8n1KeFIYGv5tsfvWRVzATuEC1HpmPuBy16vf60NJCgWIOaN3CeC3a8BrzWlZhVI5XlnPi6ixf0NPje18UZ5xUKvMaKdQTr3bIoMra/h7AVDSpa5rxAd2M6OloIBYUuc7YGUivJnI9F3sBxO1PwtXyfq/18EPKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.8; Fri, 13 Mar 2026 22:20:00 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1%7]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 22:20:00 +0000
Date: Fri, 13 Mar 2026 15:19:57 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <linux-edac@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other
 areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] EDAC/i7core: Use kzalloc_flex()
Message-ID: <abSNjbp3L1L6Mtnz@agluck-desk3>
References: <20260313215900.6724-1-rosenp@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260313215900.6724-1-rosenp@gmail.com>
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To DS7PR11MB6077.namprd11.prod.outlook.com
 (2603:10b6:8:87::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6077:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: e17630ef-d64e-4a42-d2c2-08de814eaa52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|7053199007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: +RqUK++SmmiwVZmD56wQsWuhEum4l96y4FIEC/Sv8+cm7s7HZGlfjU65t4F9UuVikZrAD93mmgqLJIGtHXwKBZKU/M74mGz4czAsy0lA5AtfLLQRuegVOkTZC3w80c4BcR0wxru3lw2nBaE9HZWP5CZ811bK5aCtA7ZuJRLyy2aewhh7xKMVmt8vOPhQWsjygq+y9o6LoXBqsEsu6xrE0l1FXgWCafcsHk0j6DGsBkqlcSk4hzSvAwXSs+GyiHD4KyCaU5lhuwBBKNeMQBEv1oYYnmSyQ2yeTlX8UsV+zQs9PBG1L1lcnZFr2rzZKG2/SUeYUcVhjmFL92ZLzwHUaCyetiyaV9Dg1OYyertdTkuhn5hPjAwJ62iEcH/pBAZEBxOROcmWFww/oztO5tWajJMRUvyUDcGlkyrjsOk+KwcK6IJDwPn9lGDVJ9NHNAeO9xD2mXQ55vAtjM6b4+wgC4svuRxyYJzbFV9Mq74uXtJCgH6EDc0eeNdbuOtfiBSotkf3j9f+sgFrREoCdVcWCbzYILEwQDDkIiDcpnUo8hlkYrvqUCMQ9QiNHIF8aGOZNBPorOTY+YW4iL9K31m1bMesSK8W+pAvNltq/Oe2s2kJXZfmv6iUaEXxthKGyeXT96ViPaI0ueTzMakMDTJebDjsSctjBlGhnoinwG2dohtLrC/I6WQOGRO7nC5miKO6RKbCgSa5QRTXUluJWFH0UaFrJ6SWkGeCuGVw/yNAsbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+fWiT3+g0H10yK7UL9/zJ7zrHDeemBGQcTRmgR1JqnUy5jz1mMaG8UpZiT7?=
 =?us-ascii?Q?KQQ2dCYST/InifPmIEWfSYxYMIMsAjlRBI71b+HHonipIYIuMmEXnJiZJcpx?=
 =?us-ascii?Q?1AZjG+pIIB4R6gpRNj5fnCImpZfaDORIcL97jOzLVpJNQiSEycskt7VvPRuS?=
 =?us-ascii?Q?ceI0u2lUCiAxxlP6W0DUS25lVhaIGchvDlmghR8SC1ab5pK8jWSLYtbarW4E?=
 =?us-ascii?Q?nmr6Ic4/jWUZ2iKC30x0yGb6nlnIgIrJwhWsuwpSo3wzYbGhA9DYDevBTQvh?=
 =?us-ascii?Q?F4eXppDF5G7Xc+lrcL22VYVlRsP2bV7zh21gaTXKxL4c7RQ3jv5q6ulIowfZ?=
 =?us-ascii?Q?eQxzm9gZPMm/DHZTGxOqXMhzLolXnmhC9W02VbUajQG/c8dr7/HXxgRe/7uw?=
 =?us-ascii?Q?PvaiUYUZiSnoD2Co5BZDFnXEs580lmtND3bK8fJ4V+IXvu9qpQIj7l8nR6nX?=
 =?us-ascii?Q?BzwOeb9MF01GVNqf3tfFT3mfAVe9JFUhn/Hjf6URrCONTq/FXvGjMiWIhWJH?=
 =?us-ascii?Q?97ecZ6C48WtRtxSQ/CB4nn2Jst+KK/KX+qW+d/bhn6Fc0CdY+QZU/vuSvADt?=
 =?us-ascii?Q?CeAfRGDscBr/yIJMYef8XRmSyWEPPz7wIvFJscVHaNB9hwEIp+C867zldhwC?=
 =?us-ascii?Q?Sj641nkma7xsgvGUaaI2lZEpf9hNm3WWvdQLu4atXF7w/3ZItjqnxAWa5aSN?=
 =?us-ascii?Q?K1E9FwlTWkAG2ERhA7IOW2ss/AuhK62Lo6LwHZamYCpvqUOo90MYzelSnTdB?=
 =?us-ascii?Q?Fj4XKTo01vEWkFL/46o52WLN9dIoPnwZLedZYDJkUNdCHu+hTjfsB5od3v4v?=
 =?us-ascii?Q?TAEckBhRjZD15y9MOL2elCdeEy8nhMltbCwPOJHSEZMb0trRnJzPg1gAPmvl?=
 =?us-ascii?Q?SYN6ZHEA6xw8j/WHl6pm8oCveLvRsZ4hPsM1ASsa76avLikMhCdf9CeqM3HR?=
 =?us-ascii?Q?9d3Xp+wTWdcDbzzO5I5HJ34oll0QhbpqfKAOFhmwc6GWgAfjMNgYnmcmbEmF?=
 =?us-ascii?Q?f97pr/pWC9YNnW8UN7KFiuSG71S6/KU+IxEJIlm6O056lAR+Xzd6ocPqw54C?=
 =?us-ascii?Q?iS8+B8AflyJ2KGLlhXlIG8RHFOK2SOpZ04/nQBELSYbM3eyJ8rqRDhVoA5ov?=
 =?us-ascii?Q?Qy7XnC3XIqP0l3Uikx3071wVK+7gSJPFaX1HViscc03dEDI9e19ZTpq6pyyg?=
 =?us-ascii?Q?iPeNacB18B+yyrBgTbnvYyE1VMRY42f6q821IHR6JdY12DWyI5/egL0wkTNw?=
 =?us-ascii?Q?3tD4MNxk1pSOkSxevRT0sG+JiBitqUn6BHquUF9FcaA8ZkyrrcGinOIjmkS1?=
 =?us-ascii?Q?NYFw4jWzzirHilyELplmJ1jGJaNZMShBehOv91ligp9I0XhEwrfoBeVVvmjx?=
 =?us-ascii?Q?UmRB7E2Uq6K2owlWiN1hCeanku6tIJk6U1Y5VDHXArspHQijq4+HS99/O8B9?=
 =?us-ascii?Q?LIvL0mebtWreELVAUNYwu+n2QuWqnGGQC+fpFCgiVVqjLNewQIE4zq6+Rrgx?=
 =?us-ascii?Q?8PflQNKsx1CIRxlLN54sU3tJGPhTypdjy1QaNHM3PaxEgyoK+qq16NehYL1e?=
 =?us-ascii?Q?GR7yKHTKTrTruAW/N5k2MvtntuZACPQyv/WCYmXjhEnL+GggzftQT5U+w/2l?=
 =?us-ascii?Q?ykHaLys3zBItP2BukVK/cj9+XfSLsJb8lDzk3Hpkx/pYi6hF/sx/DI+ijIDu?=
 =?us-ascii?Q?ZwXlRkMgrKsYMApcNuI/9JY025R6fXdyuwH+LgQ0IotHZ7wLEhg7pdiVOeQY?=
 =?us-ascii?Q?yK3nHKdyIA=3D=3D?=
X-Exchange-RoutingPolicyChecked: JYzG6BdRt39Z+Oy+J9o5G3g5mCU9Cv6q93vWvjrERhJYFPakleu669htH92f6A/vERuk7pnEUy3fxhLoE9sD6mJHx68ffsSBrntWIzkUc684EGEIhnNCwDKGtLYFOgdjLLmFO41ekZYtbt/S1NUEokzTBnFuXmu6ApQlFv/l+JEHf6lKRonC0juydol7p/cZ3Gu8zd7oAGBUGwZ8bJSpHQmsu3nYT44llB24IeZpBb07Gm291U0uNGPQPiEuz9FKmjEJ8jw4gOpGfYUzd2CuisSviPWO8hNWs9vGKoMnL0Cc3G/Sd8jSYQy2bAqBXt1SfFutId0ZEAE+6BpCJl9gbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e17630ef-d64e-4a42-d2c2-08de814eaa52
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 22:19:59.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaaVdxcA1PVT2zT49WsuFiU1yptJuPwDA9Y/TKjhvkExvMOIQGydc3wLq+5O5jRHnWVsd4GslHbrdqVWSvGC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com

On Fri, Mar 13, 2026 at 02:59:00PM -0700, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment to right after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Merged into RAS tree. Will go to Linus in v7.1 merge window.

Thanks

-Tony
