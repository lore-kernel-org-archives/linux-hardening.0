Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5284F8BB;
	Wed, 10 Jul 2024 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586547; cv=fail; b=UrvqeBLoQQINSOP7U6Fk1JnP2aMBhGNTN/lxmO2Ikr/Suez5w6lThRhePQ7Vd2owwNcjJcEr9EnzFjwByC0kL7gqEPGG3VRwoVkolwaRLaSRfB8LQimX2SOVRYM1I3FKfn3/B3LuVqMA5/nqeygQCFa8VrH3m62zFeEmGa0n6Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586547; c=relaxed/simple;
	bh=y/0IlfgbzHXCbVRo3F2XERCcdinhBMiVAavnZ15b0T0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XkL44spW4gq1f83NFIexiL0pSp3zdaseB72AdVlyqY5aebDJuK0DKPj3L4VoJsnWVI+7KDlS+NJY8oXTe2i8+jz0fQ5Elo/3z0W/eENugvRQj44pug1J3gWHZOTpbPwWx+Ks8kgYB/xe2MIpuSJxqtixEfZTJ3BlCebWIy9uJdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhbaY6cg; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhbaY6cg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720586546; x=1752122546;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y/0IlfgbzHXCbVRo3F2XERCcdinhBMiVAavnZ15b0T0=;
  b=LhbaY6cgATTSxxgYu9V4Hx+6h8GTwJtq0lh/G6g+JFrqsoepjpjk05cU
   eov6FNBJuqOjav6sKFOo/UMKhPyX9fGIzDK9lHbB/vNjzI7tXgN3711eK
   R5FA1qHNlvHffo9H6hplLFvXwBEcLI661t7/5G6jtfcGTcqzt9EWGOB1u
   etqpsYWRyoUT2hgJr6sfLfrKWsx6Ly3YdimZECcoSYFhc7DxjK0jnBHbO
   i5IEaNVV5bx4/MKl69j/aAY1YyNfzeHQqQlwUNTOiFXdSUBEHUb0iHqhF
   0Diirw1XH0BtADVmZnceTW2vMy1kn5zaG4DBp1W22n01V76+Ne2cZAJA1
   Q==;
X-CSE-ConnectionGUID: ewuvYAXnTJmqhgmsB8nY9g==
X-CSE-MsgGUID: qsr4CHWyRLWMuFy5zKbBJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18090857"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="18090857"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 21:42:25 -0700
X-CSE-ConnectionGUID: WPKohTYSRwOr3VlBuDgH7A==
X-CSE-MsgGUID: P6kuRL17SfuoFc8YqefIeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48077037"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 21:42:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 21:42:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 21:42:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 21:42:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 21:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRsN2U5+ebiNSzHYgrzz5ZstvCZ+XIgyP56gdTfNfxbUqPjdF8kN7yKA8So9PeICuDjBdsrAk23LvU87pUOew0y77oO77/rdInR61Mx1HCC1Ijy6qAwTxs0DJmpATOZIsCHftDW8IPPpsYYeAbL54KA/cmEEuMzfoliN1GR3pRIzwOkVtlZNaAjRf6V4/6aMOlI5+JaD5BxxSfcO+A0qD98pK17csCOV2umC05gdOPRGwphGw9/YqXKtdfnIy1oUiVIay/egPRVV/8tTKhe8msX3W4BCgX6ezeLGX2dbDl2fAMrXZVWpR0uTzFEd0y6FJOh4G7iO06uhR/j/k8VYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS3OZ/3otAwfn8CBFgmS50pfyoEX9wU9Nb9ohiD/K4g=;
 b=Ve2idBnWRLZdyf0kdqCTHEoplkK4hEU2agWacZYy7CHfJc9UHMSpa39HLvT6LqK6oy4tkQRAvKdU3iZJLkZkf/4We1wdOs0cZ7Spsw98McWv5DkGQf7AIi0zRJ4Jr/7sYInXLeP9IalwbjQ/JPmBjboQo+8DDUsT/D2/YXR7jCHDjR8D0/e+AVJZqHcpSHUr1hspsJSe2aglHWeTwLPDjnwk+7sP2+tl+a7HGvJWYDNG0ZyMBtbRSHGXWu8uRuFk940E9FKfnuxZ+8OPCKwURghKADNHkS1ECYjC7ElAq/UXu3MfUpmFB+q616N+HU924rT0NZ/OtyJ/6jL2wKL1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 04:42:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 04:42:16 +0000
Message-ID: <8327eb93-b378-4b98-9994-06640edf7e68@intel.com>
Date: Wed, 10 Jul 2024 06:42:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 0/4] slab: Allow for type introspection during
 allocation
To: Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>
CC: "Christoph Lameter (Ampere)" <cl@gentwo.org>, Vlastimil Babka
	<vbabka@suse.cz>, Jann Horn <jannh@google.com>, Tony Luck
	<tony.luck@intel.com>, Nick Desaulniers <ndesaulniers@google.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Hao Luo
	<haoluo@google.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Guilherme G. Piccoli"
	<gpiccoli@igalia.com>, Mark Rutland <mark.rutland@arm.com>, Jakub Kicinski
	<kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Tony Ambardar <tony.ambardar@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-hardening@vger.kernel.org>
References: <20240708190924.work.846-kees@kernel.org>
 <a1fd42b5-50b7-1360-4fd0-8f590dc08e02@gentwo.org>
 <202407091327.AEF6C020D@keescook>
 <CANpmjNP2BEYV5Yp80yS6+x90YFpdAUyYSR5mxoj9q7JZQWy3UA@mail.gmail.com>
 <202407091626.055933E3@keescook>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <202407091626.055933E3@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0043.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::32) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 186a205d-0619-4676-a761-08dca09aac80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlBGMFczdHhsWWZKbExBbVJQNWk4aTVnT2dWR3lGcEVoeWhDVmJnY2c1TjVa?=
 =?utf-8?B?T09ieiszclB0VFdqMUZuaUd6cUFpYUwxU1NnM2t0YUIzYVRIS1R1U08veWEx?=
 =?utf-8?B?RndlKzM0TzRsRFNTOEVUQVh0TjcrNk5EbXFLTEhmbU43ck16R2JjVTZBTk1N?=
 =?utf-8?B?SHpRYlZEZlJMQ3dSeUpJUzhlQ0JQY0NuVVlZb2NmY2J6VnltdHVwNUNLWDJ3?=
 =?utf-8?B?VmRNeGxFa0NMM0IrMWdPeTZxT08xYzQ0WFdZQlBvcXFPTzZyRWdsbkZZYVVZ?=
 =?utf-8?B?dkVUbWlxTklCNWQ5T205RVlZRlRndDhwRTlYTTNyazFTK2haTE45SkxwcjMx?=
 =?utf-8?B?OFlGbk0zelRJS0YxN1VqbUowdFVVQmd5RFlWeWM0N09zV3J4RVFxcUFpcUxt?=
 =?utf-8?B?NG1kNG1tQnZDQ3M2eW1LWTY1OGFDSDVvZENBeFdMNE9pTFBYc2U4RjZNSSt6?=
 =?utf-8?B?WnM1ZFBqckZFN0xHWDV2aVZQUlZWTzY4VVlSaThwMjV1aStEY0grMEZQdjVC?=
 =?utf-8?B?NnpVNTR1VEZkS3hseVBvU0hkd0gxd1NWM2cxK296dE9Mb1N1cXJodWpzSjJY?=
 =?utf-8?B?dTA1ek9mRG8vZm1EL1hZMUh6aTRBZTI2ZklCdHJ2TDN3Z3dib04rMWtxdXRV?=
 =?utf-8?B?UkdncE1PNjF5Z3puMFQwam5BcjQ5ejdxaU1PQVNXWUhmcXFCbzhyaUJtbGVm?=
 =?utf-8?B?OTlWR1lEQUdHdUJvekJnYS9Nd1lKN080c1p0cys3RXlPMTUxMzhycW80VHlO?=
 =?utf-8?B?V1hCNVhvYStsR1dDdlZCaTlwRWFpdFhnc3ZnVkwxYzhXTXBHM3dLRFhUTEs3?=
 =?utf-8?B?bS9hSFJEZmhUMFd1RHpCTGJBTmV0aldzcm45dkc3N1gya28wN1RVU0FqejdQ?=
 =?utf-8?B?Zmx0aWhCaHBNRjJrQzZOdGVsbVowckhWUFhoNzNuNTZVU04rMHZYSkZrVFUr?=
 =?utf-8?B?RkltbUdIYWI4SHFzbWVITHJLeWZwd2tmcnY2c3VJNkhuL2tIKzUvTVRtYXJt?=
 =?utf-8?B?VWphV3ZxRTJaYWpoMXFjY3VRemdSSlplOHJWUzlyam1DZTlPV2JRR2V6SWJ4?=
 =?utf-8?B?UjUxUDBiRmU1cFdQMlExN1A2ZmNudERNMitoSHg4OWpqZVZCNXlUdWtWa1Ra?=
 =?utf-8?B?L1B6SmhrMkQwaFV2cXpqUVhETm1GNElnZkIrZGZ5b2lFWU1MQ2ZFMGtDb1hT?=
 =?utf-8?B?bURaZEpweE9HYlZDRVBXUnRsYzNVUXdUMlJJZFIrWm5rQ3RzZ2lPL01HZlli?=
 =?utf-8?B?Uk96TkJnUm1oa2puTzYxK0s5SWJ0OG1FRGVpS3ZKSDAxRWFBSDZiTm9tQW1N?=
 =?utf-8?B?RVN4dTVvOS84cDE1RE1Sa3JDTDd3RW52MHArU2t6L1dRVjRyL2k2YnZlR0pN?=
 =?utf-8?B?WWNXQkVQR1crZU9yc1laWGxBbnhUOE9jWU1Db1o3dnRHbWhxVXhLM2k4Z2ZW?=
 =?utf-8?B?TjNwb0NsQmNhczZoaUpzUWRhbGpOdnNZM1ZGK3djd245andIOXlzcW80QXln?=
 =?utf-8?B?ZDRTRmNONzdNeUwwaWhySzZTVzBCMjA1amorZGRMek5wMkRoY0JnWDZKZGw0?=
 =?utf-8?B?MC9POFJwd1lRcEs4QlpwVDBDalNvc0x5UHR4cHlJbUVmdllzZXpibzJKYnJm?=
 =?utf-8?B?dXk3KzhSV0FCNXZtRUNwaEVFNEVPVndOWklKSFJDTmdJMzhvd2JkR0tUdWhH?=
 =?utf-8?B?TC9FT1k0SXFnSU5IZHBRaVJYLzFCd3Fxc3h5Uk12WFBqVWY3Ly9BWlIyZFRi?=
 =?utf-8?B?LzJuWDdxV2JXSVdpV1VmOHdvQjNyUVdYV3ZUU2hFd2c1MnUyb25mY1hqbjNM?=
 =?utf-8?B?R2JHTGQwZnAwZFl5eklPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdNcFdXM3RORUNrVnBtZGR0c1dmMTJyVFUveTVUd3NJSTNmb1RjR3pHY1pE?=
 =?utf-8?B?TmQ0TCsxT1QwNWlmQkZqS0hMZnVvaDNJSVNJcFR3TVZRZndYb0w1b0NRNWxZ?=
 =?utf-8?B?enE3MDJpUzlCWFZzaElweDRBT3BnM25oQURBZGh6QmFZMTlaVEM4TkpJK2N6?=
 =?utf-8?B?U2lnOWRwK0Npa2RMQ1ppZ0Q0ZlNGTGo3VzdqNTRJdm56Rkc1OHpkOGlXZ0ds?=
 =?utf-8?B?YlBMVmc3THFkL2pwUXhXV0g4bG1LanIvWU9sTmNQait1US96c1huaUprS1JR?=
 =?utf-8?B?SCtxb3dPeVUvSHZGSUc0RTk0OG1OQnFHeGRnUlJHZGloZmdlSjJyVXJIajVy?=
 =?utf-8?B?R1QvVDZGV2NoNWF2bnlRZ21odzA1OWgrenhaZmNhTEFIOEtsV0thK0k1Tkc5?=
 =?utf-8?B?aG1oTEIxZVBORFhXZm1yQnZKWVlxN2Q0eDEzcGdWdFU3UlhxMlNPRFBxM2Vv?=
 =?utf-8?B?Mk5aZzA0SEN3ejBaaTB4bDhRd2xOQVY4OGRWVUdRQ1ZsRmxYRkI4U0dhenVR?=
 =?utf-8?B?Z1U0MGlMZzhDczZ2bzB1N3QvVUo2QVJ6T2xzL2d1ZHNYWkxXY09GWGFnQm4v?=
 =?utf-8?B?MmkyWU90WlZ1VUVPVDAwRXNSSUhzblB3ME92OTZrV3p1NFAzMjlDMkNJaEg2?=
 =?utf-8?B?eUhxMFZvU0pwVk9idE1vMWNNbU5KNDVOelZUb1VCcUFrdFpZblNSNHVPdUlJ?=
 =?utf-8?B?MzdzdUp2ZFE4SHp5YzJvWkNYWDhudDA0eDMwMlFYOWZ0aTdBWGRSUkN1YUYv?=
 =?utf-8?B?ZEZPZk1nQUU2WWlyRklUT3ZlUWFJSTVRTXE2UFZXN2tBUDdZS2U3QlE2a3pO?=
 =?utf-8?B?RG4zY0I1Y2hoRFZDUFM2TWlaL3BHMFRPZXFOdjdndm1QczZlZlVtWTNzcXRV?=
 =?utf-8?B?M1BqeFpmeEsxSndCbCtQRFlyb2FURDRtRGhBQ3pTVGVzWmR6T3FGdUdDRCtt?=
 =?utf-8?B?bzlCcVJyTUtIUjZkUkE1bTVpNDY4ZFdkdXRmeGl1T1lzc3pRT0I5R05FaVJ4?=
 =?utf-8?B?b1RVbkl6U2taMGpXWHpta3UrVWZIcVIxcHNRR2w3K0p1aGtzeUNvWTFQT1lW?=
 =?utf-8?B?L2N2b093OFFmR2lGNGFHd0YrYXgyVGlVbnBnT1Q3QmFUOGRPSHEwSFJKVnZY?=
 =?utf-8?B?K3Vud2pCKzRlcEtqNzM5c2Y5MUF4cGRCWm04dXBRd00vSERUemJTbzNIaXpI?=
 =?utf-8?B?dm83b1R0VnFDM3pDRWl5N0xxMVNaTEtqb2VDbUlGQWJodFZWUHJzSVFjMkp1?=
 =?utf-8?B?Y3BWcjlnNWpmUlM3YVcwaHl0YjA4S3Q3RFVqSHYwVzdZVnlCcEMvU21KUWND?=
 =?utf-8?B?VjZaVk0yM2x2Z1VFMVVDMkpreHdzUmo2c2k1bTQ3bS9PRDRyTFdDWnpXbWQy?=
 =?utf-8?B?eWpCNHJ1QmJCUlIrcEl2a0RUaWRhVUpMQVNjU3pvUm5oTEt3b1lWSlc0K1hD?=
 =?utf-8?B?ZUxZSGM1d0w4ZEV0aER6UWdGZHdLKzVKZDkydCt3N0dqT2N5VjY2enhTUEIy?=
 =?utf-8?B?ZkRQb3RndVlaWVF3VTU1NnZMTkZpZUZCd3ZVZ1g1MmxBdFhZdFVGZy96MWZl?=
 =?utf-8?B?STZLT2ZyLzZBbm1oNlpLVWRyL3B3eTZkZlRMT3M5eDlxN3ZkUzVPSzlCUlBx?=
 =?utf-8?B?dU1FVThlVjdzN2phODZLUFh2SndkSWJMdHRRNDNaUElxM281S0dPQW5kZlRI?=
 =?utf-8?B?bDdUOEtGbTFQZHcwWE1xZlNUV0Z3UW9CV1NBOWV5dU5NYUlBY05zTVcrTHRz?=
 =?utf-8?B?SVlQU2ZMdGs3Q25LQWRUd3VHTWdFd21CTE1saWVraVQxV2JXMzFFZEgwNTBL?=
 =?utf-8?B?YXpnRnNsZ2k3THYzNWp0V0VZdHhzRlNLOXJnWk9iMXRLaWFkTHJ5aC9WNE02?=
 =?utf-8?B?UlpiT05ySkVGMXphOGpTNmF6NFUzc3YzWXViQlp5aU1lM1pISFdKOGhXR21i?=
 =?utf-8?B?ZVdYZkcwQjFmMk1GTUxPVG5kNThpQ0Z2K0c0Z3dBWEdEOEVPMlFjeW5Ncm9N?=
 =?utf-8?B?YXEyazIzV1BVRy9wUUthdlcyL0pjN2pXendSRjRQUllCSFh1dlFzNlBzZnlF?=
 =?utf-8?B?Rlk0d3hRZWI0YUxVWlJJd3NMTEJxWWFmeWhCZDZoTjVGeHRKanNnYVNCUTU5?=
 =?utf-8?B?TkpEc3lUamFrUW1ZcVhISGFNL1JzOEtDSHBIOGlCV3NKblZZYjhqTU80b1RC?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 186a205d-0619-4676-a761-08dca09aac80
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 04:42:16.0199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCPErN0jidf1IW1WQjneJQk7IAwdVWH3w0JFSZEoLClKe4b20jvuh5Rk0EGC4uH6M7dDZVCBtYi30mfobGIBgOhEkXxHsh5BTpj0BFHuJlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com

On 7/10/24 01:28, Kees Cook wrote:
> On Tue, Jul 09, 2024 at 11:02:55PM +0200, Marco Elver wrote:
>> On Tue, 9 Jul 2024 at 22:28, Kees Cook <kees@kernel.org> wrote:
>>>
>>> On Tue, Jul 09, 2024 at 10:26:32AM -0700, Christoph Lameter (Ampere) wrote:
>>>> On Mon, 8 Jul 2024, Kees Cook wrote:
>>>>
>>>>>
>>>>>             obj = kmalloc(obj, gfp);
>>>>
>>>> Could we avoid repeating "obj" in this pattern?
>>>>
>>>> F.e.
>>>>
>>>>        KMALLOC(obj, gfp);
>>>
>>> This appears to be the common feedback, which is good! :) And we can
>>> still have it return "obj" as well, so it could still be used in
>>> "return" statements, etc. I will work up a new RFC...
>>
>> More macros like this only obfuscate the code further. The name would
>> become something that makes it really clear there's an assignment.
>>
>>    assign_kmalloc(obj, gfp)
>>
>> There may be better options. Also ALLCAPS could be avoided here, as we
>> have done with other language-like features (vs. pure constants).
> 
> So, in looking a code patterns, it seems what we really want more than
> returning the object that was allocated is actually returning the size
> of the allocation size requested. i.e.:
> 
> 	info->size = struct_size(ptr, flex_member, count);
> 	info->obj = kmalloc(info->size, gfp);
> 
> would become:
> 
> 	info->size = kmalloc(info->obj, flex_member, count, gfp);
> 
> -Kees
> 

that will work out also for the (IMO) most common case of checking if
the allocation succeeded:
	if (!kmalloc(my_foo, flex_part, count, gfp))
		return -ENOMEM;
