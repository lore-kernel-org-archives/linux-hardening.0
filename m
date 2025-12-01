Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B83043CA;
	Mon,  1 Dec 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586170; cv=fail; b=c2E/4rCbG3TnFUYkvZ1RJlyMoyqNAsTZxSNG45d7fda1qDrX0ofAFgpTTq/ztfTXuuV4tunpEqmzNrEYpNNQ4vaV2U26GngtPxNJ/8IMSmyWyHLxCz3KofIDNyBzW/D0zp8vagq+JkZlmOH9nREvWMurhhoD1VPi/aLIF/TPMlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586170; c=relaxed/simple;
	bh=O4zIiG04wZ+qBAVYBucdkLUWSDXkQYe9jrnpyLkkQU8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UeIo6gr9V5iqhWa/XpUYm4Sgkk1OIqldXu6Unq7y+2pukLfbKx7w5U0G6j9hHG3TVwUecKawHe43xNO+YCwoUC8FxXi1z2+VUTi42+AS2C6BWQhs07mPa5uhCGULT6B7bgn2sIv9yJvaq8QMgo5rYU5effpcc4hKLBEMKOeB9nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZq9l1Sk; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZq9l1Sk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764586169; x=1796122169;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O4zIiG04wZ+qBAVYBucdkLUWSDXkQYe9jrnpyLkkQU8=;
  b=cZq9l1SkKp0nfWmo5DP85HjZXWWuJP0nDyAm7Hua3ADjSyTsIg/ZfWBf
   vZ+aRz0fsoluZ0GF+BuBWK3FIs32zqsUKeqJTuE59qjYqe/JGDK7Pd//1
   MDG7HqSgCiqlK0RPfZwlDxxOO5XJsDjRIwCIzfAcqooJgx9OIPoL2DwST
   IEl3BiJCAkE75iPrGFvsWm8gfu7aB/w0usDK/A3bpw4FyCv0p/a6nnX3T
   I0qM/QjDn4wOc3wwV3Q2ZKYAPZ6qPRF8duOKoNQCSfbyqKx34ewhxvmUx
   U/Qlt5TfRaM712mHVPdUeIaVZv5O/IDfygGZNX/vJOmDmFftxXiEkhnhD
   w==;
X-CSE-ConnectionGUID: /6JCyspET/GTjvyz1/tZ6Q==
X-CSE-MsgGUID: s0+RFsxcRfGiJVhl1OVdcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="66551896"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="66551896"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 02:49:28 -0800
X-CSE-ConnectionGUID: 6U2pwlLUQ2yqlelxv9XyXA==
X-CSE-MsgGUID: vL5PD8JQSQOmfpYku3njwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="198393858"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 02:49:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 02:49:26 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 02:49:26 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 02:49:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIpU0HLBs4kXYzP9REiVuOQJ9+WtUMEuJdT5iatfKd2qAU9EARKCIq/NKI83TuP980YJvlzYSE7Pse52Uw5ac/w7L6wKRHJgKAkDnSFW2MC62Md1oDB/9J4xvlalHSR4a3wC7LteyJ5zkGQBRpbBHgzxp8n8KYJ4CYKzqYdgWd/0XlgVfTvL99Uya3DPut/lxHtLNVzJQBW0JUTPNDvZt4H11spi/7JU4GcIXQ+vtVElK1wohxXlclfJDPSxm2/PYwJtAd3ozEGAdSDfFfn3tnlaxtWIAL6dilg4bMCUfgQniZJNJFX2B/wolseiylFVA/wdW1PPrEvzOOBtgO42LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbvoIrHhKiL206j7xoOlnhNUxb0nXmKBVz6WK6NKg3E=;
 b=MycUnOYM8a51ZkIswWSrBZvb6Gt2J3Cr6WqOCG30ZhqKPWmdBGolvTo+qG03WbY5GRpZf+9TWjfjUgLII9QhpQS/qFD5+PUFzKfpFSwTBDLxZQ4wHNmTc1jOBCi5LDfu0X7z0tEiciR8uipifzGCyJ9dHvbDxl/1KbkuUYoP7iuo0t5ETC7TFMlmBZE3I8JVzDWG19oKXtVH9E0RMTeMobenz3cookM4TY7swXsR/28m9UlRCM/+2m+z9KMPSmbTo2t+KJ648XPx11HSO2dgQhU5KVRT2ZnMkh8V6Sqh39L3Lasr1Yy4xbh/j6jxu5/3B2IgUKXosB90Ku3CDkJe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:49:24 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 10:49:24 +0000
Message-ID: <fafb77fa-0615-4404-b976-be1a5496a96f@intel.com>
Date: Mon, 1 Dec 2025 11:49:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
To: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook
	<kees@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, "Pekka
 Enberg" <penberg@kernel.org>, David Rientjes <rientjes@google.com>, "Joonsoo
 Kim" <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo
	<42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann
 Horn <jannh@google.com>, Marco Elver <elver@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
	<linux-mm@kvack.org>, Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda
	<ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Vegard Nossum
	<vegard.nossum@oracle.com>, Harry Yoo <harry.yoo@oracle.com>, "Nathan
 Chancellor" <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Nick
 Desaulniers" <nick.desaulniers+lkml@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao
	<laoar.shao@gmail.com>, Tony Ambardar <tony.ambardar@gmail.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20251122014258.do.018-kees@kernel.org>
 <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook>
 <CAHk-=wikqnc16e7yUTJuqnc5f4rL+y_-JpRzCLRu9WPnt3nmiQ@mail.gmail.com>
 <202511241612.6CF90E9@keescook>
 <CAHk-=wh7jG7vUqY2JjkJmjxOYzXR+iUARN6W908pCVfmyprSvg@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wh7jG7vUqY2JjkJmjxOYzXR+iUARN6W908pCVfmyprSvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA0PR11MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: a5622a0d-c97b-403c-825d-08de30c74ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em5TN1pxZVpzcVlnelJVeEFPSFdncVc3NzJ5NEM5dkNxYng0d2JDejIvdHFD?=
 =?utf-8?B?OTZGb2F5cWV3NkpHdDJrN2NmUDh5RGpFQUhDM2ViMHY4Rk9COVkxQm1WYkFo?=
 =?utf-8?B?OEY4RG41Uk9QMDlwYkYyangyaHJBaEg1bXF6Y0tCaWdCTXhxV3kvUTlhS3Yy?=
 =?utf-8?B?SEhDYy9NZkpZREdqbm1VVVRRR0ZEZXhTTXhGN2dBZEYzaVl1Sk4wTU1oMGRy?=
 =?utf-8?B?b2cyaWJINDFaTW1Gdzc3S1dZeHlUa3dRZU9QRUJQTHAxM0ZwQy9EZUpzbVpW?=
 =?utf-8?B?VVhZczdnTWpPeGVJdnA1MnEzd1dXYUQwRjc0WHBoS3czT3ZpYkMwSG5HdEk0?=
 =?utf-8?B?SC9NNmJQRU5FRXFrS1B4Yy9aNUVWVGZKRFViY1B2Ry9BRk1FZlZRTXE4bDE3?=
 =?utf-8?B?TXNqR1dBc085MTM4bUNvdWRPc1JyQ1AyakxoTXd0NDFQb1g5bVN5NjdvSjQ4?=
 =?utf-8?B?alZTQldXYlB6L1ZEU2FKMXJXb2lER0dTaXBCb3NpbmVJbTBnQ25BcmlXWStM?=
 =?utf-8?B?d1Nib2F6cDJWajhUTnFNRXRSaDZqN0d3cEdua1BPOU1jYkV1TWc2ZHYyU0NE?=
 =?utf-8?B?cW9lekJCY3N6VGx1aGNGZmJtYzh3b0lZRERHdGZsS2JxVTVjM2VmMnlkU256?=
 =?utf-8?B?OFlwdm1lNnRzN0NHaU9UdENqOWlGc092Mlc5RUJPTG5haGRBZ2VYbHk1K3dy?=
 =?utf-8?B?TFV3ZGtZUGwrNmV4VDRiZTE5bDZKM0NTT3d5V2ZqWVRRblRpS3lWT005emRT?=
 =?utf-8?B?eExSTmlXbzdneURaL1pZYjlPUFYxdlJnQzJnUE04ZFVUTzFQUVhiYmlXNTB6?=
 =?utf-8?B?eVNORkJWZ0lQaUIyMjlXVVdJQzBwRGRMb2J6VFZ2bkdJa011THRkb04wdXJm?=
 =?utf-8?B?MXpVVzNQcjJKTk5GN0kwUXhVS1NvTjQzaUVHdHo4SW5INEl1OXZnamk4YlAr?=
 =?utf-8?B?dW83RzY4TFptTi9BOVRSdTA1ZmhyV1VWZU9oTE9wWDJoclppU3lyZWRjbGEw?=
 =?utf-8?B?WWJBY3REQ2pXYUxKOFJJa1JVOGdDODRPNjZTNTc3ZGpQMytrUUNSNmJIL2dV?=
 =?utf-8?B?clh6K2YzTWg1azhyTjMydDluaWM2MjlZMmw4dk1CV3RGVC9NRE9CZ3dHcWla?=
 =?utf-8?B?akI3a05KbGNjOEI4WTVBS1pnOTRTRXREb21kSWJtZmNka2k0SHJ2ZElnako0?=
 =?utf-8?B?MUJZb3ZRZlBQRWtSNUlaSE84bkNibVhmVTlveEJPL0Z1dFhDSlhWVkw5MnQy?=
 =?utf-8?B?S1E0TW5QSzhRTEduSDM0c0x3MXNtWkdSL0gzc2ZFdXdzaVVrMGg2MCtjbSs5?=
 =?utf-8?B?SmFUOU1GclVLM1h6cWoxTGlyUktrZnhvY1F5RmRZZnRNUmw5R0N5c2I1Tk8r?=
 =?utf-8?B?bUtwMzc5Y3JiTlRjY0VHTC9YWnRHZk91NnpnczhIeUM2dElJNU5tM1ZZa3c0?=
 =?utf-8?B?bllZSTNqOGQ1Zm5kV2xydk1GSnhYSDdRRGE5aWNQT09qS0dBNklXaS83cXJw?=
 =?utf-8?B?YnBkUlF0Ny96S3QwdzFuYVVzZEpoWFB6Qkp5K2gwL1VjenlmMlRVc0xnYk9F?=
 =?utf-8?B?L21oM3V1VkVlQW51d2ZINkl3K1dwaTVYYzlHNzJXcGVCYXFrbE1ldEc2SU9E?=
 =?utf-8?B?SFg2UzhvQjBZYTMweWJiQ1F0UjdwdWtBTWhjVGxlZkNVOXFpU2VFSFZ5MnRr?=
 =?utf-8?B?MUpoOGhFY20xbFdlc3ZKb0paZ2UrYVVvekswWTRjdjRpRktSeUIvYm9HZTBG?=
 =?utf-8?B?MEs0NElac29kWkFJeFZmVFlTM1FXSEp4NFhybWswRFByRFlINFVNdi9XR3Z1?=
 =?utf-8?B?djFoRDNDa3NKNnpibWNtbHlXVW9CZkJPM1pqSDZsNzhqVjM5MGdSbXJaeUZT?=
 =?utf-8?B?c2lJTFRtRTREMmVJWFlJOCsxcjN6N0JFVGdhNXZpMEtuV2kvSkhrSS9JYU9Y?=
 =?utf-8?Q?olww/aiFs0+golO+8XmP/IaLDjTiXwL+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXV0Z2hzWXRwVGtZSkdsUmZrZXgzUGFnSTgvQzJBTWFKVHZRWFo2NXhRVC9B?=
 =?utf-8?B?Yk9iR2k5c0owSnZXcHp3R24yNlhVdmVjdkpTS1J4ZUF2QnJPeGxxdGhXSmNK?=
 =?utf-8?B?dmR6Z3ZIZjlYVXYyY282VTZaUnJvRGxKbW9YT3NUMnNMV3hSd01IblQxT0Zj?=
 =?utf-8?B?bkZsbmFJbXlZVVlQVGN1VTl6M2NiUzUzYUxIR1huVThzRnd5ZGZJTEgrb0FD?=
 =?utf-8?B?WFdwT1RxSlhxUzMyRkxSQk96eW1JSldvZ0VPS1NRa2RRdEkrY25qcVRMR1FU?=
 =?utf-8?B?Z1RxejlOZ0JJWFcrVVBLSXk5Ty9yVHg0eEI5Vlo5dFJodm1QcE9XQmNjME5T?=
 =?utf-8?B?aThROGpEL3Bhc0dnVVpTWkJJTGhvN3g2UjJodGVaZW9GOGhzZU1nbFc4NmdJ?=
 =?utf-8?B?Zkg0TjVvYnNncmlpaFRaTkF0b0ZTdDZPa2twL2RmNktXWVovN3ZGZkF4UTBW?=
 =?utf-8?B?eFAxR1dEci85WHB0bWp4UHFLckE1UkdRbmo4SnpuSm5SeTdyRjQraHlUUjk2?=
 =?utf-8?B?d252ZDdYMWxEYngwVXcxZ2l4UjRJeVROcE10QlNyaW13RGp2aDE0Y2NBa2xI?=
 =?utf-8?B?RjRWbnBlYWdpamc2QzY0MTBZK3JEY3QxMUVvcGxWdGplcUFuMVloL0hOSVV6?=
 =?utf-8?B?YVphNFdDN0s0bG9WWlUxTVpuckRoMlJlUHhJUnY3ZWRGSEg3ZVNWV3djakFp?=
 =?utf-8?B?NE1sVldoUEsyQjdvWTU1N0NTeEhOMTBUNmpXdHhOSWpTZUdzbWJ5T3N4bUFt?=
 =?utf-8?B?elZVeXFDR3Q1c2FjZVZReVg3WEJrK0prWW1ycjFtYlRtRmVqVGpWc0pUNEdw?=
 =?utf-8?B?Nkx3MWVVUC9MMGZuNGtiRVhFSi9sY092RjFFSHhNRTBhUnFDdm92Mk5ySjRW?=
 =?utf-8?B?YVIwcC9ERzkzWnAvRWJESVQrbE9QWWdKQUZUM2t1djdkd0ZmbFJoRTJTOXBM?=
 =?utf-8?B?RmR5L0lsN0lpbkY2MUlZaWJiS1diOFVoYkxNaVBCZTZtT0ZRS2U5ZDdmUkoy?=
 =?utf-8?B?MHBsb3NwMEZjc0xzYjB1ZnBXU2dGUXR0d3JoMEtGN2V6TGZhaFZhUThuOHJ5?=
 =?utf-8?B?NjhPRnN6UFVXUCtHQzFUeVlvUXBsdGs4WFFTT0dZZUQwc29yNVFZckxDV3Ix?=
 =?utf-8?B?YVRCYlFxTVRnbVpCNFBYSUsveko4Y1IxOWFiYmNBSHhvWWNNYUhqK05PTnNI?=
 =?utf-8?B?YlJucU5hdzhQTWhVMDl4WStZM0paa3lmVGo3RHloUXU0ZnFkS3ZlNjduVkZi?=
 =?utf-8?B?d2J2VkRFVjQyMHVtaXRsdWNiZndENWJYZTMzMk1sRWVjY1FKY1dhblNrRm9v?=
 =?utf-8?B?UXpmMzZWOFZXZGZzZnEzTkFmczM2YWR5M2I1UERkeU1pM0Z3dS9MYm0vUWJF?=
 =?utf-8?B?UUFZYnZDWk95d3BCYVRWVVdkMk9YUkkxT29jdXgzdlhyZUhwSEVkckp3TUtG?=
 =?utf-8?B?Tmh6YVFlWEIwZ2ZPYWNCT1VRY3l0cnMxcEdteEMyejZhUlZsWDZXQTRnNEta?=
 =?utf-8?B?UlAxa2U0a3ZoUkhacmFVb2ZMNW5Cb3ducGVuRzhNbEY1SmN1czFnRVpualVj?=
 =?utf-8?B?SE9XZ0VCV3BGOWdvWEpOanVQVWl4TGVqbk83MWYrTEVnWTNWaSswa0N0QVBZ?=
 =?utf-8?B?TVVIVlc5WGdZcEpwbkRiK293Y1dCc28wRHNtQVJ0OFVaMitjVVcwdTVBM2l1?=
 =?utf-8?B?Nm9vekZQNmtKTndjaVprV3hod1Z2MVVIK2wwQk9vUFNnV3BLSmhYZmcwMkJm?=
 =?utf-8?B?NDV1WHJxRlNLL1d4Y1V0SjU2L3ZyWFRGMTdzL3FEdEZISmlLTjhXcnhKYXFy?=
 =?utf-8?B?WkpNYWJ4cDJrN1d0dS9acTFhUGNVSm9FeFk4dm9ScHBXWFBJM1QycFkyVWZH?=
 =?utf-8?B?KzBwa2RwVGVBNEtqYlJUN1drVTZBZXVuK3dZVG96VDRQYUdUVTkxd3JjcXNE?=
 =?utf-8?B?MU9KMEdXVlk4eWkxQjVneGJSdzcyYmUzNGVySGE1MXREdGtKVlFPN2RhZVRh?=
 =?utf-8?B?dHBKckpoanp1MUk4RmhnOS9xQkdjek1kSXZwd0FSRE5lTElDb2JnYnFiNHVp?=
 =?utf-8?B?K1RGakhOM1o3Q3E0U3JmMnBIRmdzd1c5N29Fd1BLSW15R1NJblh1TVB0WEMw?=
 =?utf-8?B?NitZYzV2eEhGNnJ5M1BkZTEzbUxaUHZ0Ty9YSDJNelZOZlJmVkZ3OWovK3Bi?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5622a0d-c97b-403c-825d-08de30c74ae1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:49:24.7897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bj67siP4BnDz3XN1ge4i31kUMltDsEFfTFNnvyZbLRiyaTby7qAQUb/4CSdEFh8/7+YFgq3uvjiTHxmfhf6c/aHYEOGG2GzVbGbg9cnRqms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
X-OriginatorOrg: intel.com

> Doing
> 
>          size = struct_size(ptr, flex_member, count);
>          ptr = kmalloc(size, gfp);
> 
> is basically two fairly straightforward things and easy to understand.
> You can *scan* that code, and each piece is simple enough that it
> makes intuitive sense.
> 
> No, 'struct_size()' isn't exactly a very intuitive thing, but written
> that way it's also not very surprising or complicated to parse at a
> glance.
> 
> In contrast,
> 
>          ptr = kmalloc_flex_sz(*ptr, flex_member, count, gfp, &size);
> 
> does *not* make intuitive sense, I believe. Now you have five
> different arguments, and it's actually somewhat hard to parse, and
> there are odd semantics.
> 
> In contrast, the simple versions that take
> 
>          ptr = kmalloc(sizeof(*ptr), gfp);
> 
> and turn it into
> 
>          ptr = kmalloc_obj(*ptr, gfp);
> 
> actually become *simpler* to read and understand.
> 
> Yes, there are some other advantages to the combined version (ie that
> whole thing where 'kmalloc_obj()' now returns a proper _type_ - type
> safety is always good, and avoiding void pointers is a real thing),
> but I do think that the major advantage is "simpler to read".
> 
> Because in the end, simple code that does what you intuitively expect
> it to do, is good code, and hopefully less buggy.
> 
>               Linus

what about below interface:
	ptr = kmalloc_flex(*ptr, member, count, gfp);
	size = kmalloc_flex_get_size(ptr);

so, users that don't care about size would not need to read or store it

but those that need the size (likely to pass the whole struct via some
generic interface) will simply ask for it

note that there are some caveats, like user could add something like
	ptr->count++;
to destroy naive implementation for kmalloc_flex_get_size() above,
but we don't need to make knee shooting any less painful

another note, there is ksize(), and if we would like to waste some more
for actual size asked (as opposed to allocated), there could be a proper
function (instead of the macro that will work only when user not messing
with conventions) for kmalloc_flex_get_size()

