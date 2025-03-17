Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78921D004;
	Mon, 17 Mar 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203648; cv=fail; b=jh6m+YDcjLmeoiG8ykYd0eL1cUZv4Mt48TWtarJ9XcMGtcazst9Am8VYIXCWX2Qx2/g+UVMZx+OyvMYM+clJkkSBAX1IcSs5DaP4kN9qxCSFo7R07kT9tpm4QR9+IdcRESYbCmVeEUsYnESnYktrT8nibfM/PB8kYIHbPUZsW/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203648; c=relaxed/simple;
	bh=S8Xrob3KmqgQYOGmGrDefDEEovEWIPEJZu8xpK+dkSo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ABxEhn6bzdpsvZjxVJb0MPWzS1OM9oXQwsnIg8GLJSc52lx37W2AXKBuVc/xIaVdxYydrRjVlIHA1DyvMWd9LdRVI4Bp+/103FFDE7+mGrQn0zD+OxAwR/ipSRrKI1DNXM0n6E0txZ5bF+gzBtMKptq/TyzCkgC+9FxJPNaK09o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJEXWxF7; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJEXWxF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742203646; x=1773739646;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S8Xrob3KmqgQYOGmGrDefDEEovEWIPEJZu8xpK+dkSo=;
  b=dJEXWxF7swIOPPy+e/itolltZNP9SdPogfQ+OHlNVSGgBW4eym/a+xgH
   jNZSap498paH4blkJ3MLv08OlHLurZQvJalNCgV3tKhr417Nxq3fQVLcK
   Dmvjd+2h5SvYvgno9ziIKGyaLbCXmJfV2dMH0+UJOWxoks/mZh5vnFZPi
   egiCYY2YceIJdstxBAiBFrKCMo4DYrG4uV6D7aNGkoSnAs8UAyEScuhbA
   vRb2ovjZrIj7R3Hw5eZApQEKqlHvY5ZIn7KxyfpMSYZiI4P9cvThTymiD
   5CaUQ3RxLsIcW0ZCUBon4v4hCaz/gzrzR1lDNeS/m6exYjY9+r2Mlh0do
   w==;
X-CSE-ConnectionGUID: QFhHKxdxTzqMm6O9EL/pAQ==
X-CSE-MsgGUID: zOcb361PSG66jVZoBJIL4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="53951919"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="53951919"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:27:25 -0700
X-CSE-ConnectionGUID: OaW6TQ/qQFyTIf8HndCsSA==
X-CSE-MsgGUID: DJ4A6a5lSsO2lgeiFsIKIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122629780"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:27:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 02:27:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 02:27:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 02:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PG8G/EpbEOALKY0zHzY2XdcFfOsZrWZRiiPn1Ch/VgvQMubVmy2hT3o3DSmgZp2IhS9oe/5p80XVtxdF7ra/yXT+BCTZ1Buqwv2nO+ntfEXRcnzCkzKRx+fWfz5NlZiTlVL5KSwy2wTRClGoUiL4Ed3ZEpg6FCGDY/wJJ8zVP4fdiNg4IxXYsSiGsirBCU+H6fqbJqRXok6rQlwQkougVhgbTLA3W3EtIUmeAUGZjQ3I7khdmZyLlTeNwDVEjUVMbQVCULEaGK7g4WOF0ipOzHiNLLg/YkPi9irqZD1JmSv8bDzn1j2LaS9MOibiYS/JKLiPZaAhe1lw3/ecUMrrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo7UY/3EdpFaMNRbzXQyP8x3Ce1nioF20qzk5qTsBoc=;
 b=lMb7g6AKB4vUdPo4EbIzn6rQo0vup0qaXUXRZ2SuLK8YrUhzsf7xD9Es7Volc8iY+NB7E/8T0Cl8Uo1/8zD4ApX/bBxz+/bds7bdHeJbILDvJJO2zZgxpM61jbicavENFz8ORnu+Z5oq9xNWI4eUaRVOWgDrYr6sX/X5xLqBIZ9pIlJVhO4iCJKtRbLmH7MS2UVomeER9++5nLmSSfmIVNMxYKVYVOQSSjGqizs8dnuYB50sFFmbZo/kg1rlS8uZ6k5RuC4LBGiNyjbbdHCctOAWC7slQRXkbWr/qYSCOC1BwpacjprZt2o9yqFPHNJRPU1H29mLKyH1krF5eNyWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:26:40 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:26:40 +0000
Message-ID: <eb6e6198-dc42-4a63-8d0d-35f3061ff388@intel.com>
Date: Mon, 17 Mar 2025 10:26:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] compiler_types: Introduce __flex_counter() and
 family
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
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250315031550.473587-1-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::35) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW6PR11MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f43a113-5f0c-4b6c-5d3c-08dd6535d324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUdiVXhXQTcwV3VnQ0VpaGpESzl1a0NuNFQ0UGFWMW80YUJldXVGYkxXelJW?=
 =?utf-8?B?Ump5ejFjZ3BZR2dEdVNwRnBnUzRJaXB3dksxWGVsQWg3UitsbkpzWVA4aDdv?=
 =?utf-8?B?ZnJKdE1TTHo1OHpDcVovSDVBTzBpRjBUaFVTM1VFTjNwQUxZTG5veG1wT2xq?=
 =?utf-8?B?WnBVWUF0YzR0QmdzN1NWZXFTK0N6V0FTR0VTbHQxWHQrdWxzVnNwejJaZkc5?=
 =?utf-8?B?dzZtOHJzRDF6SVJWUitXWjE5Y1RXeTFucU92NEE0WkEvYThwRWFQT3R1a3lX?=
 =?utf-8?B?Z1ViZW0zdHBsYUFiVTB2T21mYnc2NUZiV0IzYy9oYUJaL3JLRWgvWWdMRlBL?=
 =?utf-8?B?emJzUUFEOFVDUWJyTVhCNytYSXhES3JFcWlDaDhidFBOeDRLUVltN2tVemQ0?=
 =?utf-8?B?Y0VuVlF5bmxiMjdkZmluYVZBV3lDc3J4dDBqdFFYMjNkSFVKK3J0ZWNXOGxE?=
 =?utf-8?B?UnhHYlZhb1NPZ1lZT3RmWnFLTmF4M1BrK1ZPejN2UFJSSDJndG5MVmR6dVZH?=
 =?utf-8?B?M0hBOUVEazVoSG5yMklOSmw3YnpmS0ZUUk56RlhNZlFYM3NiQXJDZkdTY1o0?=
 =?utf-8?B?M2I5K1VWSzNMc3J6NTRLbWZVYzJ3VzkybnBKRUhQc1o4akpPVUtEam85Y0pw?=
 =?utf-8?B?dzArM1VCbW55ZS9FcVdLVzYvWXlsanN0cWoyc25wMlg0a2RXYlBIZDVsWVdE?=
 =?utf-8?B?RzlXZ2ptZ0l1dGlQTlNibzV2bzBoWGNmeTliUGFEWU9jRHF2Mm5jdi9oSlBa?=
 =?utf-8?B?VytmbGNDYzU2WksvaWMrVWdySmxRSjVvQ2tONS9ldmhyNTcrc2pRL1gyU2Vk?=
 =?utf-8?B?N2M5MzNjb0lXTXZrV3pPMW5FVkN2YlRkZWI5WHl1bHZlVHZFVnBCcG10N3NY?=
 =?utf-8?B?RGFIMklKNXhNdm1xZVJiekRwazJqT2xVbmtsSkZqelNHeDh1U0h4VXVOT1hu?=
 =?utf-8?B?N0tud2pYWVJ6eTV4clRHTDFYbHd5VzQ0emdzeXNyV1Z0VFc1T2tyWUNIZk1w?=
 =?utf-8?B?Ty9RNXprSlV1WWhtWXhIdmRpR3ZZTHY0WmNjZ0x3RExNbTlySnZkckdPWWRY?=
 =?utf-8?B?bEVyV0oyYWNTdlFiWkZjTDh2YmpUNUIraWVYeGJIb0JTU04wa01XQlpJN2Zw?=
 =?utf-8?B?UFhUbmZtWUZ4S2lwUUg5VWZvY3RIZjJ6M0VmNlJuOEJQdElZMzBxcGVZSmpD?=
 =?utf-8?B?VkZISEN4d3R0NW1IQ0k4RHlYMGY5dXg1c3FNdXJSYXRYOUFNeXZMRUw1VEdn?=
 =?utf-8?B?ODFMcEUyenlVdXJHYTloVFhZdkF3dkFBYkkvcFdOV29UNHlUR2JYbjhSSnNY?=
 =?utf-8?B?QVVUN0tTaTcxTzVjc3JSRUo3Sm5sTXZJbjh2cEpPUklKZWVPQWFYMzJ1NWtL?=
 =?utf-8?B?OGczL2NFNHJYSXhwdGU4dktaOURaNFpGWWJkUll1SUc3YjJLazhBNXdVNDlW?=
 =?utf-8?B?U1YrUTdYcHMvWm1KR3lwWU0rY3Z0ZENMZGlVa0NMMmRlVS9Cd3UzRnNGazZ6?=
 =?utf-8?B?THc4amgvSjErc0pNemlYUFlVd1ZYYWFhUlJnYlU3SWMrNjVIempJTkdQRnVW?=
 =?utf-8?B?TTdKQXgyOVZIaFpHSTJ2a0MxMTdSNTZCQy83dXd4NG82UzR2WW5pQlRYTnZi?=
 =?utf-8?B?OXF1MG5PL2FtT1hPWGNrYS9uSEIzVUNZanJxZG12azJjdGIxcCs0NWV5MSs3?=
 =?utf-8?B?SllsVWZIY1BjMHloWktCdW83aW9RaFNKbUJCUW9YQVBBSWVzY3BPdXNkbmRS?=
 =?utf-8?B?R0t2QU9kMWhicHc0VjRCWC9jTk1HaHlNNjNwOTV5ODZ1bE1VbkwrZ3hQdUZN?=
 =?utf-8?B?OUlsQm9WeXB1QVRPU3RkS0dHQWh2WDJPWHdZRC9HQ1oxUEFCQitZMm11ZWxo?=
 =?utf-8?Q?bfoEVpAfeSoW9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXM0TU5vbXJzWW8zaFRVSk1PbUgxSDI0M2c1T0RqQUN0cmVSUTdHeE5OU3JH?=
 =?utf-8?B?MENrakNRaXN6aWpFU3FXaEVBb2NqWW9XVVJweUg4Q2ozVFkydDcwaWZHb2NL?=
 =?utf-8?B?cCsrREpoQkRLbTE1aFpURHRZUFJwbXRoTVIxWDNnN2ZUMjllMkRMdTBGS3NF?=
 =?utf-8?B?eXozNWRBc2Fpc2c4ZzlveXZnR2ZwaUFTZW82QzRCTmIxenh3djBMZ3d2bm0w?=
 =?utf-8?B?MU5aeVhaNStwZXMyZHBXdU16ZFNOdnRabW14MTBZYjJuczArcW9KS0U0dHVw?=
 =?utf-8?B?M2Mwak0zN0lCY2JISjJ0NTdEZGxRTHBPdGVld2tsUlA1dWQxSGhnWjBCRjFC?=
 =?utf-8?B?akJZVHh3aGllS3I5U1MwT1JsS0Qwa3NoeWIwNENMZ3prUDRzS0poOVplOUlW?=
 =?utf-8?B?QnZpd3pXdmg5bXhKaE9wcjNtSE1HUkV5ZWhZNTJPREJTSFpCS0Q3VlpnU0Rv?=
 =?utf-8?B?bFYwQ3pNL2xLT1ZkVDRhMU9FYnVEdldzZEI1L0FsV1FaOTIxRUE0NW04dTJI?=
 =?utf-8?B?QWE0VHdPU2VncitRRW9CV3FrU2ticTh3ZjdwM1pPZ2lSUFptQWRGcUo3ajU5?=
 =?utf-8?B?MHdCTDA4TXdnUWdZVk4wM2xpZ012U3FpT3phQnA4L2JaKzFPSGFOVmdSZG1l?=
 =?utf-8?B?YUdzTkxZZGNyd1JnbnFDSzZDZFdRdy9hQ0lvV1VQSlExcXNrQ3labjFqdmJ1?=
 =?utf-8?B?NWF6eDZzcWNuU1M2cE55alBBWjB6c2JVMmpITGJ3SzlDTkZMSHJabFoyMFMy?=
 =?utf-8?B?ME9CL0MwNFMzTCt2eGZyU3NxdlV0eDhXZzVuZHNFbStzOWIwWll3LzlndmFS?=
 =?utf-8?B?ZEQwRG0ybUtsai9qNkZBUDlTRVQ2bWN6czlSbENiY2p5b1A4SUo0WkJKZDZM?=
 =?utf-8?B?aXI5ckpTbGpLZnhOWDFXNXFnYVpIQmZscjZOTVVYQ1NwcTd2WDBhdUdJbjU2?=
 =?utf-8?B?VjllT1NJNWVjL2dYaVVpSnQyTE5IczFNemJSSXhmOXVPWTJSZkFkQVZ0a3Q3?=
 =?utf-8?B?bDljcXVvdGIwZ29vWm9UT0tvZzdjWUo1UnJlbGgwdGszQzNtblBSQncwdGhH?=
 =?utf-8?B?dlRNRDFRbW1mTjFOVC9zRERtWFJmamtBQjQwWmFkSTlIMDRhNzlXVUlJdEFB?=
 =?utf-8?B?d1gvTXErNlRja0xOcVBraDl1M2pnclg4cjFrakVZK3l0RnZjMXp1b29KNzhK?=
 =?utf-8?B?MmRvMUJFdk1OVTd0OUVzMkJTUjBnbTNiaEgzOE1PT2xES0lHcnhVRkdUcElh?=
 =?utf-8?B?TEVIMU1tOWlaR3loWWxCMEk1MExOUWd5b3ljZGllQ3Q3VjZzSEFYam5vU1Zo?=
 =?utf-8?B?Y0w5WnJTcVpzUks1MnBuaUgwb0hPNXJEMklQUzdhUTZ5Zkl3cWhmVjFGT3Ny?=
 =?utf-8?B?SGJkRlpxWU5QdFJDVnR2ajJwQTdRYTh1MGZ0NjdMTkliNGNhWVdEa2dFOTRp?=
 =?utf-8?B?QjhpTDFOZlJENGFXQ2dUdEoycEFTelF2VTdtUGFMaUhtelZZcnVEbWNaZFhn?=
 =?utf-8?B?dzRJcVppZkRyYWdpVzhqR3lOZGpPU2hFN3RIVEJIMU9FdWRiY1JrcHE4WVgw?=
 =?utf-8?B?MTBLVTd1NDhucmloMVFvdFNuZDM2N0RSbkxmbDJFNGQ5MGd6SHRZNkgrRGdl?=
 =?utf-8?B?cDJTTXY3K25HemxKNnFRU3ZOQ1hKNzdWZ0xvZ1YxdU1PcDFaMC9rV28zQ0hE?=
 =?utf-8?B?UW1xSlhNeFZuYTY4SXgxY1RXYnhLbFAzemgvN214NFQydHNVUHBZMVRYd3Qy?=
 =?utf-8?B?WGltRzJoYnRuelYzOEJ6eDFnOWZrbTFrbThVbHNJVTBTU1VzOWpOb0lQQ1dm?=
 =?utf-8?B?ZlZtSDJIR0NGbmQwRGhKdjZidU9KZE5HeE40UTREL1NJL1ZpdlVueGlQTXl4?=
 =?utf-8?B?NC8vMFJ4eC8zUTZMcjRPcUtzMTJRWGJSS0FoYUZXUFRaT0hUYXFjOTl3Zmpu?=
 =?utf-8?B?SXo1QVp1N1VSdXNzZExDL3dneEs4V1JVcmlHUTQ5UG1LUWlMZkdRQlNIUFB3?=
 =?utf-8?B?QVBVUHkrSXozeFlYdWhNQ1RsSEJGVzhIRS9OWThYSGxobjVJeTVhZG1pMm81?=
 =?utf-8?B?YWZZNCtpVUtRNHp5NllkNHAyZXJ3OGRqdk53L0w1c0lEN1NuWGdSdXVTNlB2?=
 =?utf-8?B?RjEreXRCbUlWSUdwd29uSmVJVjF3NW5nNU5LdXgwZ2hML3F4bWh0ajhwckNR?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f43a113-5f0c-4b6c-5d3c-08dd6535d324
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:26:40.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsXpxBgY1lnbH0G8l9jUcMr3Poo/iDxTYM2afy/kKHT7AciHW72P9+oLoV/d7GRpUzzhMAvSGzwK4BiTjsL/l41PGtpXHhZfDiOtotC8+2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-OriginatorOrg: intel.com

On 3/15/25 04:15, Kees Cook wrote:
> Introduce __flex_counter() which wraps __builtin_counted_by_ref(),
> as newly introduced by GCC[1] and Clang[2]. Use of __flex_counter()
> allows access to the counter member of a struct's flexible array member
> when it has been annotated with __counted_by().
> 
> Introduce typeof_flex_counter(), can_set_flex_counter(), and
> set_flex_counter() to provide the needed _Generic() wrappers to get sane
> results out of __flex_counter().
> 
> For example, with:
> 
> 	struct foo {
> 		int counter;
> 		short array[] __counted_by(counter);
> 	} *p;
> 
> __flex_counter(p->array) will resolve to: &p->counter
> 
> typeof_flex_counter(p->array) will resolve to "int". (If p->array was not
> annotated, it would resolve to "size_t".)
> 
> can_set_flex_counter(p->array, COUNT) is the same as:
> 
> 	COUNT <= type_max(p->counter) && COUNT >= type_min(p->counter)
> 
> (If p->array was not annotated it would return true since everything
> fits in size_t.)
> 
> set_flex_counter(p->array, COUNT) is the same as:
> 
> 	p->counter = COUNT;
> 
> (It is a no-op if p->array is not annotated with __counted_by().)
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

I agree that there is no suitable fallback handy, but I see counter
as integral part of the struct (in contrast to being merely annotation),
IOW, without set_flex_counter() doing the assignment, someone will
reference it later anyway, without any warning when kzalloc()'d

So, maybe BUILD_BUG() instead of no-op?

> +#define set_flex_counter(FAM, COUNT)				\
> +({								\
> +	*_Generic(__flex_counter(FAM),				\
> +		  void *:  &(size_t){ 0 },			\
> +		  default: __flex_counter(FAM)) = (COUNT);	\
> +})
> +
>   #endif /* __LINUX_OVERFLOW_H */

