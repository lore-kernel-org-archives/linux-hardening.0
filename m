Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829E13DB92;
	Tue,  9 Jul 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508290; cv=fail; b=g3RxJb8k4VQJP+eL2czgIZebeRK9WRxvLWAqVOeOsniKFAiLLkwfEluNncm7zcS59t7gXE1R5ydMHkD/S1+w3DJXboSbZJVUNNt4Q8M0YUbl2CJfnzem8ovjlIx3Jg7BARjoh2ul8rFyyvZ22QJgUz0+va7OvLf5a0hTLDQzgkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508290; c=relaxed/simple;
	bh=VPxVzAL24dMX3syyAqYU+oKr2s7UnjA3zuU33rAdpA0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p2jNlnNXOyaBDoOk63qnTTeKiugBaGavEIhiH0uz146D8GwKSVs9gBXIAZpDVwOJd3mYZ453UppdjmeVAdl9ApQtn3HaBbqInlPtWnOVlodJP5L2elFXr6t94tB4ygH2LA6PrzU9aoFSkif3GfMmZwx+BPzAgZqH3oqz1hcsSck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTfq+9i3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTfq+9i3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720508289; x=1752044289;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VPxVzAL24dMX3syyAqYU+oKr2s7UnjA3zuU33rAdpA0=;
  b=UTfq+9i3geLbtxVienKCSOkrkw4S0hMbkhqs+lZ/qvZsje+4Fi+fR8dL
   ecAySJ7ep1scLKDIQbArsaV/76kjw5M9AYdZW1dBnOELpCcetkhiDi1sQ
   QVJTZ0gLoY62T00LqgSd3lbki1lrgWCujrKf2UX28RR07Wl4EHYdNAmOT
   XOaIerZZa67KAE/c+BeDqTxc+d3Jp0zx8zl69PajvCT1OF9FEpNJpKkyE
   Tp2ycZdQO9I96c2drGmbEIRytAEsoEvmux4fDv2ZATd+0QsvQgOXpOrtQ
   E5OvX4bxK2dKr0W2kY5f50/UfDrd4GpUJyfFn70KRs01MoU3N96CNfL+F
   Q==;
X-CSE-ConnectionGUID: d/Crz6ncQLuavurs6bkZdA==
X-CSE-MsgGUID: Rg0h5I2zQXGrCdcvHjbpbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17694312"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17694312"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 23:58:08 -0700
X-CSE-ConnectionGUID: nHnXh9Z0RHuD/OVfnnHCZA==
X-CSE-MsgGUID: RnpuK8gDQhq3PbnF6S2B+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="85299654"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 23:58:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:58:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:58:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 23:58:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 23:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYFq1c46zXDSFrAUQy94bTfb0m+W+dn5uJgr+jEoEHLnngaDwdO11z1pR6itWZWumvci6Livl3+Enq/Af+CVSjRdniYaJCGLeRF65dJaYC5iTu2dkz7UgFhYc+tKNP0eg6wHaQlpdsa21Cfb8hjnfVVp29LhFsL6+oA2D3MNsRPvwGonLnqh2sIxL0LMU4heIh9vLpA+pG73IKLLdo6wI/Oy9hEzycBfFDRfsCwe/pLhaLYEZ9GaWAdhPWglr99obBw2w2iS0kbBiGoRyC4ZcYB8onenOi4MOopkQ434dvvzvrPIe6uoBEpVP5DHKWD7LcjziXZsO3c0EBHjY38Iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMhaAlasTlFU9o78jv5j0Bdow7vQ+dT8HzaBXcCiJlQ=;
 b=E0CkiFJs+1agFfmxLk3KqcfNOSRe0fg82lpOrWrX8CFZ7s6AART1AynxcW8X07zwBNrEF+H8cPic4bL2OD48P3jLxn55xQ8FLeQHpTEkVvlFs+GBxnTS3VOW9WtwruM3WZylMmMYwD/A97qLafELmLR+5UcW4TbbFjrHqlKr6AFrM9X4DlMdoNDj56vsnEnt50Wfq1sZXh8kVzhzhAloQEvbHXoXL6pEROltmFx558+aIR0B5LtH5YwjjXVYOPS1KIwFCMpos5F5jHduX8nQhqDBUbJeNd+08n+YtE8lpu4Q4A1VPSznOU1TUzaM7AK9TDhZPxhfxgqlFdGaif+Dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 06:58:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:58:04 +0000
Message-ID: <fc080824-37ff-4b69-ad4a-e76b458218d6@intel.com>
Date: Tue, 9 Jul 2024 08:57:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 2/4] slab: Detect negative size values and saturate
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
CC: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew
 Morton <akpm@linux-foundation.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	<linux-mm@kvack.org>, Jann Horn <jannh@google.com>, Tony Luck
	<tony.luck@intel.com>, Nick Desaulniers <ndesaulniers@google.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, Marco Elver <elver@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Hao Luo <haoluo@google.com>, "Guilherme G. Piccoli"
	<gpiccoli@igalia.com>, Mark Rutland <mark.rutland@arm.com>, Jakub Kicinski
	<kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Tony Ambardar <tony.ambardar@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20240708190924.work.846-kees@kernel.org>
 <20240708191840.335463-2-kees@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240708191840.335463-2-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:803:14::26) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CO1PR11MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: fb332852-a8c9-440d-f4ab-08dc9fe47afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akxvQmhGTXhOYXdaOW9qTHN5MERpT2NqbEhyMkVIMCt1TVVqeTk1b0RYNy81?=
 =?utf-8?B?VEdiM1ZYV0hHSFk4M004Y0dySmpzaXJjb1NMT3hTWko1UmhoV1Z3bTFUaXhG?=
 =?utf-8?B?by96UUJCeHFvdzRzN0oza2dva2VGaDhhOUc2YXVIOGcvNkg0R3VhSjJxYkRB?=
 =?utf-8?B?c1cyaVc0SEhlU3FLSEV5OVBuM0Zxd3hub200Mmw1a2JGb0h0ZFFYNkZlVzJa?=
 =?utf-8?B?NW1IbmttNlBmWnJqZXc0c2RtRDlkbVoxTkh5RXluTnFVWkRoZUFWSlpCdENO?=
 =?utf-8?B?RXlsNFl4cjQyb3BSMzlPZjVlTjU4ZE01Zi9mRmQrcEkwb0F4T0VPM3R5V1Fz?=
 =?utf-8?B?enR6S2Rsa3hiMDgzR2crSTNzVmxMSnEwdEJUR0FHeVlOVFFEL3F6c3Y1QmhT?=
 =?utf-8?B?STBRRjBLMWdLNDlhUnlaa1VTQ2R5MnZGY0xRRXdaQnIzb1Y1Z0RWekEzSFJk?=
 =?utf-8?B?ZEVGZ2pQOCsvMXpGWFlPZ2dVd0RyUkxzTVVRemd0Qzhicm9mRFZQVngxNjJM?=
 =?utf-8?B?Z2p4K05IbGdkUDZZaDB3RXEvUFpvekxwdzZJRTZpcTJ0Z3U2Q3Ywc1ZadkVs?=
 =?utf-8?B?Tys2VnVVMFczdmFJTVJYZGxlai9mcHUrTVoyVXY2QkZrL1NIWWtjMzNnYmg2?=
 =?utf-8?B?ajh3WDZMNngzcWh5ajBuaFlOWnloTnByRmkzRlU2N3R4bmc4WDVHZFo4MWli?=
 =?utf-8?B?T3ltVWFDTmJ6d0NTeFBZdjYyWm1ibTloUC82Ty9zTEE5UHFhdDUrVmZhWUdV?=
 =?utf-8?B?UCtIa2E0UHFlK1B2VHF1S09nQ3IxZ3ZBSU1ta2hLYnNlbU1henlCSE56a2J4?=
 =?utf-8?B?N0E5Zi8vZktTWE1tTzNydmw5MlUyQ3ZBcU5qSU5SdjNWVEFTVCsxb2laaUk0?=
 =?utf-8?B?WDZzeEdHL2lVbWpGaGtoWWFaQXlxdlo5bUNQWEhKQ0drSWRxUWQ2SmZBSDBw?=
 =?utf-8?B?K1JOTWxqMXgzV2dFZURhVHh5b01zSnVkU2ZCejlmbzVla3N5VkIyem1ZdVJZ?=
 =?utf-8?B?VG5td1gvWEhGMFhZNUFkMEZpRWZFQ0ROanZFRlV4QmVPdjZqNEJlNFJHYzd6?=
 =?utf-8?B?enh4VFhaNEU4UzJyeGllTjh3MjJ6bnZTUXVWc0dDYU1YZWJtWWs4aVFnaXgz?=
 =?utf-8?B?cGh1NHl0U1dMdXM1NGtRU0cvSTJGYlJXOUxMNWhHRVFjRVBsMFZWWG9UNTNt?=
 =?utf-8?B?RHQwdXFXQXRuSnJOc0xpa3hRNnFCSUNCYWpXK3M3MUxQNXNuRFBpU3FYS1hZ?=
 =?utf-8?B?R2VoMVc4aXJmRFdVU3ZTQ2ltKzJkc25rZXBFQmRtOUFieGF6TzhuUDhXNlZV?=
 =?utf-8?B?TmRjQ2lJWWlRdFNValhTK3JwMHpXNG4vUjEwc3hObitMU3FydTdtYi8yY2Q4?=
 =?utf-8?B?WWF1U0tjZ3pWa0l3SmUzbklTVGxmS1ZSUDdTbnZuVzZ0KzUvT1lTNXlpZW0v?=
 =?utf-8?B?dlhCZngwUEkvSGNudXdHbzNsY2UvZWZhSkNBQkkzTnVDUjZSSU12UmhCUjFl?=
 =?utf-8?B?N2daVzI1V1RnQkh4eldzbWhmSGo2NEVmb29yMmU4c0k0SXVRRjJzdWpuOG9J?=
 =?utf-8?B?YnJKQllZTEM3eTdweWQyME1LYjhtcVpYRXhMSTZNVEJrVHFwZUFJeUJKdk9F?=
 =?utf-8?B?a3N3MUVodEZiSGRId1RyTzJEc0FOek05aXJiK0tjNVVKNGVXVVMxMW5QQS96?=
 =?utf-8?B?T0gzN0s1TVBFeWVCalJFZzRZRStnUzZkRjJHK3Y0TGFURENQMm55RDk1WUJ2?=
 =?utf-8?B?ZmNWOXU4b2tWeXlySEZqRmFnNlRTb1BGeG82ZmtWMzdFc2RUWnE1cVlsWG92?=
 =?utf-8?B?T21uNW5VRGRIOVFxaDUrUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NURhMFBuNUpHa3dHZXREN0xMYUo1VVA4Yy9vaFZUZWphSWZlRWkwRUpHM1I5?=
 =?utf-8?B?M1lpL1llc0REZGdUT0F3Q3FINC9CWWVaMHZOeFlBU2lkQ0taaExEelNpWW1a?=
 =?utf-8?B?am5JOENiaS9RMzNvSjR3WWVsaTdraDZzQmVHbkJvd05uZEREb1M5dFV2b1BO?=
 =?utf-8?B?NVo5U2huNUdxUGh4c2ZOMFZqcDYrUnlaRWxRcTVwQkducUJKZXgxcS9mV0hB?=
 =?utf-8?B?Q29rU282cDBiYURyWTVnYk5Da0FBYjN0Q291bHRTU0lqNmZKblhOM214ajdo?=
 =?utf-8?B?UEhlZlgxb09tVFRCWHhRMXAxeFl5bUZDcUJuSDdFUXM2U1c3OEFkVFo3NzIr?=
 =?utf-8?B?NytLaExXWmZZODZZbXh2TklLaEJNRUZRSkl3RWE5YXdwQ3FxYUZ4TjFjY2tC?=
 =?utf-8?B?ZzlldnB4dmV2cmVjYWZSQ2RVMjF4M1Nsd0szOUFiN1YvaVNlTjN4U28zYU5T?=
 =?utf-8?B?UXlVb1dQa2xQamJoVUxobGp0THg2NHVxQWxyV25ZRUJyU25tdlFVZHBycmdo?=
 =?utf-8?B?eWVSOEIzWGkzcVJhN0FJamJ2dDM3bkVZWXR1WW15Q2FXb0xPbVRMV1BQeTQv?=
 =?utf-8?B?amZmblpkeHYxQmVVZFlSalhTYzFhRzljUGh5U0RJY3lCR2hmdlFvWnFXSDNY?=
 =?utf-8?B?djJxS0RwbmRDcFd5UmJpeXRaUG5ieHdNOXR3OVhTT3hMU0xUL2VkSklhWHpF?=
 =?utf-8?B?YzBXUDQxaGkrWTFmdWppeXBaa1BRYUJvVndaM2NQRUorQ1BXTFc4d3o1d2xs?=
 =?utf-8?B?bXZ0Z2trZWN3bHpZb2ZLV1FtUW1uWXl0NUpGQ0YxSC82UmVrSU92NFZ2VHBa?=
 =?utf-8?B?YVc5bG1zbENadkg3MXg3aEJoSXJoeE5IdTZSeTB4amQxeVZqNmdqU1QyR1J1?=
 =?utf-8?B?aG5WZnBDR0RsM2FGYnVOSjFqS1FPWEQwNnk2clhwMHd5RlFTMHpGcTNWVGhJ?=
 =?utf-8?B?NU8rL0ltU3h5Q0JSTlN6QzZHNVAzbW5FaStYREdWT0kyN3VVWnFScjErNFdH?=
 =?utf-8?B?WXlYQ1dWT0hzL051Zlg1bzk4Y2w0d3R5N3JNSmg2K2ZoMEtZdERMQXVxU08w?=
 =?utf-8?B?bmJqbEZndFhXZldoVW1uUjBzOEt4ZDcxRllqUEtsYjhUcmYwSnBkcld5TGU3?=
 =?utf-8?B?MkNtOEZDekp6cUZOdVN3RE9qTzhiN1E3VWJ3ZW1QaDhNMjZVOEtNOGxZNEw2?=
 =?utf-8?B?bUUvaU4reSswUE9SUGRnS2R2NFNNVzV6cG5xbGxEUnRZMzVaR282QmY5QzhH?=
 =?utf-8?B?enJyVHFwNVU2VTBVSU4vYnNVSnU2bTRkaC9SY0NZUXdUanlRY1RrVWpabVJO?=
 =?utf-8?B?MUVtVFpSTm02MmVrWDNsREVhenVMdUlpdVRCdGgveGQ5dEpvR3R2Z21RWG90?=
 =?utf-8?B?RStIbldQRkJDRWNUT0R1d2pOcXlsK1RudXA5ZmpMYTBoTEtSS3N4blJNNkJM?=
 =?utf-8?B?QWpDN2gyVkF0S3FiNmJINVNzVmdZRXZGYU9uVys0U1NVWm0rSytnbk92bWhy?=
 =?utf-8?B?LzhwNWZCcTBoQVpVZVRLRUxQSDZXN1BwSmFMTFN6R1VwSTljYzhmN0l3UFVn?=
 =?utf-8?B?WEJVZHM1K2dPd3VVQzh2NzRjMzRZMWtuT1RSM1FBVExsMkZUK1JhcHdneEdN?=
 =?utf-8?B?Sk5SRVRVWXBwckFMZU0wTWFHbUVUZ255YngvVlV3NDc3OVQ4ZkJtek5Ob1Rh?=
 =?utf-8?B?VFdYRXJFNktMRXZ5REJrYlZFNTRXR01KOUVUVmZFWllWbTVybXBSVS85Z29B?=
 =?utf-8?B?TlM4VmlzKzVaS3JocHhGVGxmREU2LzdPWW5jZHR5UUU5MnFHZTFVd3lHNXVW?=
 =?utf-8?B?SHlRTmI1UERnejJlNStzaklES2gveUNSNFh4ODRjOU81NmY4SGsxb0Mwd2h1?=
 =?utf-8?B?TnJzMXVIOC9kbHZUQTNsWjFRZ2VZZEZjQUlHdDZ6QTllemc1NUZMWGlKWWF4?=
 =?utf-8?B?ckJIZjNmazN0OEIrWEJVWW1sZURzVjY3RE9la2d0SGFlby9ucVM1WWV4THFi?=
 =?utf-8?B?aW9PTG5qb1I5SHJNNnhIZld6SHhFT3V4NUt2blVrL1Z5Vm4zRUVqQVFnL081?=
 =?utf-8?B?S25uRU9oU0Y3elRkbzlFcVd1dDEwSTN2akg2Qkx2M0NiWmJFbEVnNlM0T3dX?=
 =?utf-8?B?VU9DcGJiTFBNOU9VQlg0by81TnN6K3VZdUJXTE9zT0xBY2g0UXJwSXMzMDM5?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb332852-a8c9-440d-f4ab-08dc9fe47afc
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:58:04.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMgYSWQZdx3xCsn8lCQ7xJczKzawDD+EKGrmkSYvnMdgRZzD+O0E7UA//MoKjCbThE7ykLGaet1fszEa1IbIvhsSxGSQqWwv8duaQ4dr0FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com

On 7/8/24 21:18, Kees Cook wrote:
> The allocator will already reject giant sizes seen from negative size
> arguments, so this commit mainly services as an example for initial
> type-based filtering. The size argument is checked for negative values
> in signed arguments, saturating any if found instead of passing them on.
> 
> For example, now the size is checked:
> 
> Before:
> 				/* %rdi unchecked */
>   1eb:   be c0 0c 00 00          mov    $0xcc0,%esi
>   1f0:   e8 00 00 00 00          call   1f5 <do_SLAB_NEGATIVE+0x15>
>                          1f1: R_X86_64_PLT32 __kmalloc_noprof-0x4
> 
> After:
>   6d0:   48 63 c7                movslq %edi,%rax
>   6d3:   85 ff                   test   %edi,%edi
>   6d5:   be c0 0c 00 00          mov    $0xcc0,%esi
>   6da:   48 c7 c2 ff ff ff ff    mov    $0xffffffffffffffff,%rdx
>   6e1:   48 0f 49 d0             cmovns %rax,%rdx
>   6e5:   48 89 d7                mov    %rdx,%rdi
>   6e8:   e8 00 00 00 00          call   6ed <do_SLAB_NEGATIVE+0x1d>
>                          6e9: R_X86_64_PLT32     __kmalloc_noprof-0x4
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> ---
>   include/linux/slab.h | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d99afce36098..7353756cbec6 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -684,7 +684,24 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
>   	}
>   	return __kmalloc_noprof(size, flags);
>   }
> -#define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
> +#define kmalloc_sized(...)			alloc_hooks(kmalloc_noprof(__VA_ARGS__))
> +
> +#define __size_force_positive(x)				\
> +	({							\
> +		typeof(__force_integral_expr(x)) __forced_val =	\
> +			__force_integral_expr(x);		\
> +		__forced_val < 0 ? SIZE_MAX : __forced_val;	\
> +	})
> +
> +#define kmalloc(p, gfp)		_Generic((p),    \
> +	unsigned char:  kmalloc_sized(__force_integral_expr(p), gfp), \
> +	unsigned short: kmalloc_sized(__force_integral_expr(p), gfp), \
> +	unsigned int:   kmalloc_sized(__force_integral_expr(p), gfp), \
> +	unsigned long:  kmalloc_sized(__force_integral_expr(p), gfp), \
> +	signed char:    kmalloc_sized(__size_force_positive(p), gfp), \
> +	signed short:   kmalloc_sized(__size_force_positive(p), gfp), \
> +	signed int:     kmalloc_sized(__size_force_positive(p), gfp), \
> +	signed long:    kmalloc_sized(__size_force_positive(p), gfp))

I like this idea and series very much, thank you!

What about bool?
What about long long?
(by this commit one will get a rather easy to parse compile error, but
the next one will obscure it a bit)

Consider the following correct (albeit somewhat weird) code:
	/* header */
	char *state;

	/* .c impl, init part */
	bool needs_state = some_expr();
	state = kmalloc(needs_state, GFP_KERNEL);

	/* .c, other part */
	if (ZERO_OR_NULL_PTR(state))
		return _EARLY;
	*state = state_machine_action(*state);

>   
>   #define kmem_buckets_alloc(_b, _size, _flags)	\
>   	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))

