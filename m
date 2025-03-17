Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F711A00ED;
	Mon, 17 Mar 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204659; cv=fail; b=do9L1CCI1cv7Vg4oC3M44iVwf9EKrGrc45/e1+1uesQdxePIu2g8jt9BIGxoKOmFC6wu3/IcXyEBKM48duggF3PC58PV/9p4WjVJ1VIS6XEuufgwSuPBdEwon001DyOS1/8ueXzZSGKmTY58hXqjXSR0c4urOwTMXRpNgzondOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204659; c=relaxed/simple;
	bh=r04hmNhJ3fG9IxEC+seTB8MgOJyPJ67Oxlsaj+KCmts=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uPQV6LN88GMIcKu8Fr1tKUQjVd72g3FL0pPKwunxsJHAyntYikGPddx1Z1Zxq/MvPA5rng2eVNla7KRJkZPSWiOOSC8cSS40FRhgB8TS4H/YpouTd8xb99RD71Y+nwaL7YVyvE5PzVLoLNlolkWfeD5y94lgrcK7Dy7ifhD/VX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTZyQ2zV; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTZyQ2zV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742204657; x=1773740657;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r04hmNhJ3fG9IxEC+seTB8MgOJyPJ67Oxlsaj+KCmts=;
  b=KTZyQ2zV/PUW5LcSNNEDRPfGmECuDmi7mh3K2Osa6enueuqL/mhGejn9
   J7NlMJ84OH8fhhs0xaR3K4N5N1l2ZqYwCKg3ssmamqKzDgJHbpP7pnK1Q
   5Eg9RT69u7p6l5pH15KdXeEncd8RCyeTrl6E4H9lJ4q5OUJikJfsnBIZe
   EXV7p80bET4pGZq32f1EVvuxKzOmwXs+M7O8m/64s57VUy8s54t7LdcjL
   8CwXjcS924B7zYvNoxbBDQlxK7sVWhMQ6lYwPbh981HImB/m0IFt1k4+G
   jvROR6i+bl61RKt6BbGFZTjvGIs1RCiHelfj3N7r9GrP9AYMzz3cRH4yQ
   w==;
X-CSE-ConnectionGUID: Zkas7L0AT1m6djX4Hof+YQ==
X-CSE-MsgGUID: D4+ZsdLIRnCgq1Z4vLWL7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43200006"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43200006"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:44:16 -0700
X-CSE-ConnectionGUID: bvX8WtMCTzCVQ5yzqKEdNw==
X-CSE-MsgGUID: oq3/OUWiSUOAbTA/4gBfQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="126086224"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:44:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 02:44:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 02:44:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 02:44:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfPimYR+gsBvRAtAGRQj2gzoA10VrUm1S9wwlkbT3CaX/JcKCF72yKoipOQCDD3IENAGDJgZZTp1/g3obwR+IgvjllSGkOpkQBXrT9kUISj+Lw43XNA5esizst79tw7pbX8LOpohVQ6Wu7hk/UkiDS0dqiAPlnojEI92jH6W3ibrG80cLNYmBGA0LqW3LwaZgYtE5XYzVAxGWX4v7eLANhQft1/GKBz+cNPAuiC2rVCf62W4oI5uv5y9bsgmKPPXykkqIhgTc84BFqGi+Y9R+U9ZqblXgPFwlRIZDrbhQv005kh/K4RVkwqgKW71aLZ4//2VC5m3r+aDzsnmHFeUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bS8iTv980FYwLHrxGbtm3n1V8CqRErYHmDLcc5bH7o=;
 b=En4/S0kjpTqriiDLOStSuTt74++dsZJpjxyNJxOpSgHTVslcXjLYw2GZCmta7Sr3nRzFrcRaENdIuwQjSMWa5bEwDoHSxaWJJ7pOVloSiENLForDxfiL5RSGDeC0ARuoREJ0UPzCtPtrwSXcf2yrRDAjeALzRyAlfJePaj4KEKkPRpYF0Kv8GLlYA9NgEwylN7EwaB5/sDldEETywwF5V5F5O9hrLLw7zHs4ni3BojBnEuZ/Ry6JxKaUDiZ+/kq72FHNnJXiyb34APgvTR87Lig0RBOQ1SlIUYbID0mjmTL+58m5SpkbN92k1a8S3ORq2Xz7YMQq151nXUcTEY0VlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:43:47 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:43:47 +0000
Message-ID: <44a00ad4-b05d-4fb8-87f2-fccbaa068872@intel.com>
Date: Mon, 17 Mar 2025 10:43:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] compiler_types: Introduce __flex_counter() and
 family
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <kees@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>, Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Marco Elver <elver@google.com>,
	<linux-hardening@vger.kernel.org>, Christoph Lameter <cl@linux.com>, "Pekka
 Enberg" <penberg@kernel.org>, David Rientjes <rientjes@google.com>, "Joonsoo
 Kim" <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo
	<42.hyeyoo@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Jann Horn <jannh@google.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao
	<laoar.shao@gmail.com>, Tony Ambardar <tony.ambardar@gmail.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-1-kees@kernel.org>
 <eb6e6198-dc42-4a63-8d0d-35f3061ff388@intel.com>
Content-Language: en-US
In-Reply-To: <eb6e6198-dc42-4a63-8d0d-35f3061ff388@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0044.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::33) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH2PR11MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: d998fcd7-a801-45fb-528b-08dd65383737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1BVWGdaSWFwSXhpQjlDRllEVVdWMzdSUEUzZW83ODRoNWtBQitIRWNCd2VU?=
 =?utf-8?B?WEQ1VldUT0xVdEtEWjJibXkzYjdISWxyT01GN24wNW1KYVp6Z0xnSVJmbGRi?=
 =?utf-8?B?MExmZEpEUVh1YjY0RVQ2bUthV2s5OWtpM0xJWVN4K2psTkkzZDZZVy9OTUYx?=
 =?utf-8?B?aHAzdll4Nm0wWDJ4eGdKd1A4OFh5ZytlOTZGUmJkcGRVblJ6ZUhUUVpjK2Z6?=
 =?utf-8?B?U2JIR3BTRGxOOHFITE1CRENjdkpNc3diQk0xNFI5L3J1UW00Z0Z4cXZDS0tr?=
 =?utf-8?B?M280U1VCNWhxYVZ5N0hlbERtdnBKUmVpT3N0VGJBQXRvODh4aElWTjBlcXdw?=
 =?utf-8?B?M0Yzc1JSbGtXYXpoOHpJd09HQitqT1NJQmJMdjNEZUs1TmJmdmxKTTREUzNZ?=
 =?utf-8?B?TEpKcytwWlU2aUdMWjU1SkxVTVAzcnBxQVpHRGpneWZuS1AvRlp2L0hRUW9N?=
 =?utf-8?B?STRmT1lZbG5Ea3luUE1uNnZKQW1EY3NVQjcvNWphc2VrbnFzVVdZK2MrOXpx?=
 =?utf-8?B?SnVQUkVnS01yNFU1eHcrRmxKVEJ1M3IvSmhRb0xVazRNY0FEYjJ5TDhMYVRB?=
 =?utf-8?B?M2gxcm92QzU5cGxCbS9RblE1cjBkejljSUtPTVc0ZTZMRm5ubzR2ZDZBSnZZ?=
 =?utf-8?B?SVJFTEg3RXhMUm9HNmdOQzg3QmZZWi9pSWxuUDNOczlIRnRDaEpIUWtxT0I5?=
 =?utf-8?B?dUtTeEdLZmVsTWtEY2pBbS9WMktqdXpKNkl4SDZHREo4Mi8zSzZMamUzcll6?=
 =?utf-8?B?K1NLRll4cDF1bjA3VVgweWEybjExbFRpWVhuQldFWlI4Zmpsczg4eVlXNlRF?=
 =?utf-8?B?SHJTb1UzbldjUVdHeHhqcWo2Y2RKQnhGVUZMd1MyRlVMZzZRV0hBSlhOTkF5?=
 =?utf-8?B?Qzd3cUVka1VBNmZTTkZIM1lWZEFmRzRyYzk1RmFqQjE5SGtxVVlJUWh1N3dS?=
 =?utf-8?B?clhjZ1FPcXpmZFJTZWg3U2k1MUJ1Q3hhckoxY3Q3K3l0ZnE2RmgyUFMrYmVC?=
 =?utf-8?B?TmR1R2xTaCtKM2MyTUFta01GazNPcnZSdk15eWphQTEwbGFaNmZ0QmkrOHVK?=
 =?utf-8?B?Y2tnMnhUNjdFZ0loMXpJdWx2OWRzVC9oOWEveEloM29NeXk1em50V1RzbDJO?=
 =?utf-8?B?T3dQL01OUkNJeS9Ua1hoTVlHaGt3WjNyWmVUeHBHdHhUUmF5WmVnLzhYOGhZ?=
 =?utf-8?B?Z1VmWHRLNi9ERXYxbWw1d1NaQU16WDgxT0cwWjU1Z2QzeExDTHp6SHRXYkdz?=
 =?utf-8?B?M2hmRzFXZWQrZm1RVkgrRFFlZFlQckVDOU9hbTQ4T3djV2hBTzc4cGZ0S2J0?=
 =?utf-8?B?cVFmTmJZbU1QS2swaXc3VDJhczMycENhVGtySjJCN0F0ZFNHOHBpMS94ZTQ2?=
 =?utf-8?B?NXROd3lUVzJjYThRdzBEZzA3UndGcndyaG5vMEtIQ2c5MW5oaUs3bFRUempE?=
 =?utf-8?B?K3BkamZxUzQ4RlVCWUtGZnNxTzNzMmVWOGMxaStjWFBXOTZWVUR0dmN2VThk?=
 =?utf-8?B?ZHVhUU1Xc0dCeGtNYVVvOWp4S3NKRVNvamtzWGFKU2pTSFlZdTZhRHE2RkhN?=
 =?utf-8?B?MHk1SUhxR1BISWtkVmY4VWFtLzNKakRWT291OGxvdHppM3I2SktSbWZDRFRV?=
 =?utf-8?B?RU1TMWNSU2RvbFRqcmJ3MmRFNEtGcVAvQ0RpWmNiUEhNcnpoNWt5SU1LSnc5?=
 =?utf-8?B?M2xmdi82Y3IyRXhsS1hhL1E0Q3YvY0pISi9LR3dpMCtUTjZZTEdtQ3ZDTU4x?=
 =?utf-8?B?UTlpZElpMkIzZGtCdlZXeXNpNXdRaWlYSG1WcTFwSTFQUGY2ZDR1eUo5SktZ?=
 =?utf-8?B?QVJMekR0Z3ZsNkFnUjJVZ0pmZWtVK25XcjBVWkRqNkNIWnFMcnU1aHh1SnJh?=
 =?utf-8?Q?PbFlVFMOt6ndH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkpSS1lxU2pWSXoyYVJ1YjVMaVBibk42czNvdktQQkQ5UlVud1I4M01DVmEz?=
 =?utf-8?B?S1FaZmRXYUhIQ01NMittQmV5VDFJMUVEZE5xOEp5c0NKb0U3c1BKOFErQ2NR?=
 =?utf-8?B?Rmo4YndxRTRxNFRZYUIzRVZ3NEk3Z0haWXJDdzV3aWxIK2xicWszUWlwSVRL?=
 =?utf-8?B?am9VUzNnRFo0MlI3aDM0eFhnZWd0Nit1b3NFdkRGdXhPTXpuOGxTV1FqTjcr?=
 =?utf-8?B?Z0pIdjk2RGkrMDM2ajRwMHgrWGNNc1JaMm1XaEdVK05sM3ZjcDBEQkM4Ry9w?=
 =?utf-8?B?dkFVVFlRTDNLUlV2aWRJRWJIa2lMVkxHSVBOaU0xbUcrTEV4RFFQMHFscWlU?=
 =?utf-8?B?WTJqYS9VQjBnZkdRRHhZVXp0MjRPZ1IzMk1UZVBBNzk1K29ueFozYy9VeXBk?=
 =?utf-8?B?TVFIaDBtK0hXa0NQaU04SmxocHVIdnMwSkh1bW1oUSt6Nm42R0ZVREptVzZQ?=
 =?utf-8?B?RnFERGU4OUhKdGp5NHNzV1gzUUZQeWFKZS95VmwwNVpaL2lxSU1RVys5YTJW?=
 =?utf-8?B?RUN6U3o1SjllZklGNUxxSHhlN2lNMnpqbWZ4M0dQMUR5RHVUOWN3OE5JS2ND?=
 =?utf-8?B?WkNwNHVYNHZrcG90YytIbitvV20yTW0vM0ViR2IyamhTMUUyNUhLbG80UTFj?=
 =?utf-8?B?akZjTlZnMEsxMWR3YVFZSnl4Tm1sOVVWMzBTdEE1MGFzcitENGRnbGhkZ0xm?=
 =?utf-8?B?U0pObnpWMnIvV0JIKzVMOWVkVVg5U0M3cGpNcTI4Q0VWeTJlaEp6Qnp6N0J6?=
 =?utf-8?B?djZjTDIzZHE4Tjl4dlpnaU00R1kvbk9SWmwxaThDSWQ2S0pRY1laT0xzeE82?=
 =?utf-8?B?NzlKTlJRQ2U2UDN3d1ZtL3RpV3lKZ1FXMXBOZWhEL2pzM3ROaG1URVdzM2c4?=
 =?utf-8?B?bW5WcWlXQ25oOEp3VUVlVFRZRm5yaEd2S3pWRzZ2N1ZiN0ViUXlMQW1SaTFE?=
 =?utf-8?B?OFNMcUwxQnhPUlhoMFQ3dGlsVTc3NmZBNjhSTUZKN1g5K1BiOE04dGkvR25n?=
 =?utf-8?B?VTMxNXFJUTNzcWp6SjU4RVR4eWI0T2ZnZ3Y0UFovbFNNYlJmeko1VmFLQ0wx?=
 =?utf-8?B?YWZWY0VNT1Y2d1BPczJRZGQ4OUREdzRPT2lEMmVROFNiOU9qMzg0VzNkalBU?=
 =?utf-8?B?Yzk2OWZPeWlnUlMxMlQ4SEt3eG16Y2hPaFdWR1FLOVBaRjRiemFkRHlPV1hi?=
 =?utf-8?B?d3ZSZ0pDM3piTm9UOGlOVEJ1RFBHM0JIR2Y4MEZaTWZ3bjFQMEdZTHcwWnVT?=
 =?utf-8?B?eUtoY2hQZ3M4ZnBzWlg5d3BYWFliSFlaTzFGMXVKcUZlNGg5UXdzZ1pGZzVj?=
 =?utf-8?B?VjlJNmQvMGdoc0JnSFRyUWc2bGdOT1VDUGx5Z3pRU3dFYnZ5Yk9FSXJGY3JF?=
 =?utf-8?B?b2hXc1BSOGJ2MFpodi94eEhtZ1pXaHk2R3ZNeUl0K0doa2wrZkV2KzQ2Q2JB?=
 =?utf-8?B?YlFkdFp2Uk5TV0hCU0RLRnZDbEFHWDl6ZDRkK0pla09RZjc3RjUrZ0xSYnVl?=
 =?utf-8?B?RE5HTXlLdThVcUhtdmZLUWNmZnlKZHphRy82NzlEVmg3aXBMbitIU2VsRW81?=
 =?utf-8?B?STQxSzU4bU0vaTY2S2krbUE0b0hDZmRVSmxRcHNHNmhMWXEreDh4MGl5TWdW?=
 =?utf-8?B?NXZWZnIrelRhTnJjbnIvcEw4b1NsTGFhd1JtSkRQOFlLYU5XaVV4VzdvTGpj?=
 =?utf-8?B?bFB4dXQ2aGZLZGUwWWJpUnJZa3F3aU9XNFNDb3U0dUQ2dFRmd1dvRGFsVTRD?=
 =?utf-8?B?d3ZkRHFVc0l1bzZJZHpvT3VSdmNxTXRGMnlTWWFobmJndk9zV1FnNDQ1ZVVT?=
 =?utf-8?B?aUtiV3l1d1lvdzNrNzQ5Z1ZTanIweTQ1V0ZaeDJVcnZha2NaZzN4Uk5zcUNr?=
 =?utf-8?B?ekdaZXl6cGhNVXZrOVdXWUpLa282UWtSeDlnRkYvTU85bEdCWGtkUDJYcUx1?=
 =?utf-8?B?cVBocDRVN1VwV3ByLyttYmtJMWVsMWxOQlhKbUpGR1pmemY5SFA2TmdLSGNS?=
 =?utf-8?B?d2J3RmlaclV4b2JCSXBadzEzcFBHN0c4YUZ3UE1ZK1VEMVByZkc2OHlZWFBa?=
 =?utf-8?B?MFN1MFhLM2RLSjFDNHN4QmZKdm1LYTBhYXVvYTdjUGtBTGJUM1grbG1SWkFO?=
 =?utf-8?B?cWxFUWhQaFQ3ZUNYeFA1cDcyRmZWQTNJeFJUekNoR0VuQTRpanVVdzR5U2pK?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d998fcd7-a801-45fb-528b-08dd65383737
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:43:47.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3CwnATE0k+Uzo5LlLe9bTSMJg3v3cb42Yl0b+fgq2rnlWASqQViXOBK46hmG6tWm4w27KV3VO7P3XY26WSz0CJPxTMaitRL8hghIzVns4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
X-OriginatorOrg: intel.com

On 3/17/25 10:26, Przemek Kitszel wrote:
> On 3/15/25 04:15, Kees Cook wrote:
>> Introduce __flex_counter() which wraps __builtin_counted_by_ref(),
>> as newly introduced by GCC[1] and Clang[2]. Use of __flex_counter()
>> allows access to the counter member of a struct's flexible array member
>> when it has been annotated with __counted_by().
>>
>> Introduce typeof_flex_counter(), can_set_flex_counter(), and
>> set_flex_counter() to provide the needed _Generic() wrappers to get sane
>> results out of __flex_counter().
>>
>> For example, with:
>>
>>     struct foo {
>>         int counter;
>>         short array[] __counted_by(counter);
>>     } *p;
>>
>> __flex_counter(p->array) will resolve to: &p->counter
>>
>> typeof_flex_counter(p->array) will resolve to "int". (If p->array was not
>> annotated, it would resolve to "size_t".)
>>
>> can_set_flex_counter(p->array, COUNT) is the same as:
>>
>>     COUNT <= type_max(p->counter) && COUNT >= type_min(p->counter)
>>
>> (If p->array was not annotated it would return true since everything
>> fits in size_t.)
>>
>> set_flex_counter(p->array, COUNT) is the same as:
>>
>>     p->counter = COUNT;
>>
>> (It is a no-op if p->array is not annotated with __counted_by().)
>>
>> Signed-off-by: Kees Cook <kees@kernel.org>
> 
> I agree that there is no suitable fallback handy, but I see counter
> as integral part of the struct (in contrast to being merely annotation),
> IOW, without set_flex_counter() doing the assignment, someone will
> reference it later anyway, without any warning when kzalloc()'d
> 
> So, maybe BUILD_BUG() instead of no-op?

I get that so far this is only used as an internal helper (in the next
patch), so for me it would be also fine to just add __ prefix: 
__set_flex_counter(), at least until the following is true:
  "manual initialization of the flexible array counter is still
required (at some point) after allocation as not all compiler versions
support the __counted_by annotation yet"

> 
>> +#define set_flex_counter(FAM, COUNT)                \
>> +({                                \
>> +    *_Generic(__flex_counter(FAM),                \
>> +          void *:  &(size_t){ 0 },            \
>> +          default: __flex_counter(FAM)) = (COUNT);    \
>> +})
>> +
>>   #endif /* __LINUX_OVERFLOW_H */
> 

