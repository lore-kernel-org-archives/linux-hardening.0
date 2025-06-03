Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5626290;
	Tue,  3 Jun 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958947; cv=fail; b=ZJJ7eNjIetTP9z5NbSlC0TNP49vAw9/gLgNnGNsZy36SIyoFVxGP5YE3FjkbX4zghkum+cgZQZJIidxXsSVykrjjXZBvy8SCAfovReIXBGXC3IRE9UyJ2PkWeQdRRWPjyNSrxwm/U+6cy4SsucomiEgKyMC/NfDU0tejKK3A/ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958947; c=relaxed/simple;
	bh=0bU8g0iut+tEZRrG8N2DKvg/kB8j7FBYON2u9+mmwEA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YP9gHGgUOXXMNyxMfdfkUhILRY5kkss/xdS68W6rQX6sj3N0D60aKiBeyPNpDDOUr2jjIinI0+iFzXtUu7Qv9wg9CHEec02RhpPJA6raOuHQVCL0ATbq2XnyK7NVGOm9mG0HtNqvJL7kuUiRG5Y0MiV8FEECtsv5mkj4VLKj6pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+wmCbwg; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+wmCbwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748958946; x=1780494946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0bU8g0iut+tEZRrG8N2DKvg/kB8j7FBYON2u9+mmwEA=;
  b=X+wmCbwgnWn+aBLNmW6h3iot/rF+pflwtnBsqhGloA4NQuQUPhxjErOY
   e03o9KQeyMuD9fWKdZu5fN67was1fgzFfsofMLr/zgy5N+LRqLzfZYcjp
   199lvaUOjLU13UgRkfzbcZvTnvf6Oe63JqzEOrHUR2wo/5fcXsR9k4ce9
   PhYyYNIeT80scoSdf1xk7mnG8+HqTq2Xyk7RN36sTBjHkGAX0LKmC3Jrv
   gK69m8ox51ckJwM/dCweItOElbKX1uziBWPZ8N9V6hVARUAr9E2jsTAa4
   vkdDzAo92dUTM87rgCdXbOZOl10i75PLZT8WkfFJ3E1TYJF/XicK1A8BL
   Q==;
X-CSE-ConnectionGUID: bQ+VURkzQLmpvHWoE3LV1A==
X-CSE-MsgGUID: XhWUWUn4RgWl7u8mT0DBXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61619576"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="61619576"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 06:55:45 -0700
X-CSE-ConnectionGUID: NfqwKRwYQwCC2EhKOu2lOA==
X-CSE-MsgGUID: fhopZPGvSVyKKifxY5y4/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="182040669"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 06:55:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 06:55:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 06:55:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.60)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 06:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY+XC3/Z+RO8A4UVSAHXzOpQYmfXIB1VM6xIwo6xn2KgC4+SIbEU1h7MmWS826sNm0eQt37cYusH5gXspz39YPw8c4oO70ohXGAHZ2+mqYItxgTcaQwI5fjminPbWbAaZrSPni2E0k0aAjfs4SjMyHTpEFL72PcOiFgRFfqDP+kH2hQywBbLB4cS+J/qZw3yaz0SjDAsSF3jTgbRBuE9MnzJqUgA5js+l+yY/+OK5UTs/6xno0xMOrms3lZSI7ECeHJibZgXiV+d9p0KyI2krXlV6tnqBAawWUcp9QA5AjDUDnmxFqdZdSFtruFSI4yF7vVz+QN310KNOSZD96fZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4A+61XFSIQiQwpume8rPOKZZF9pc7SNCmUAweAbyLI=;
 b=UAjTOpE2t6OE7egWZJQJLblvnLZyrDJjnhJWGYgCv+b5JC8aMu4qQJh8Y9mQ3nLf6GeA4OCWVU2o/s8ituz6n8U9Tsg1C2V+1PoL1Ef0owrggGXLmKP3Pi4hhE9yYq8UFf+BYeftFze5C+tzJsQvvbx0Y8VAMdpJX1j3teYg7rwZSuczJTUhdayCVN6ClOTlnO3OWyH3zBf7W3gRSqOpscTEBR+Wimb4T2rK+WfXxTEAqDjy67cphxW0G93XZR3Wsmlsa4bOD0lMz1vwBlWE3BP5cJIMsKcwNKN22Lv/496uLlJMnN1JaCH0jX4IsgUfhVGTPFaFb25h/9X+VAWMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 3 Jun
 2025 13:55:39 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 13:55:39 +0000
Message-ID: <92dc9f5b-cef8-47ff-ba75-a099fa9c6718@intel.com>
Date: Tue, 3 Jun 2025 15:55:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] overflow: Introduce __DEFINE_FLEX for having no
 initializer
To: Kees Cook <kees@kernel.org>
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250530191312.work.661-kees@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250530191312.work.661-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::27) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a7f897-7759-4804-4484-08dda2a652a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDVsUEtwV0xJYzNnanp5eEYrMnRtcjZQNTdmOVJLREI5L3pxUEViRzltcUla?=
 =?utf-8?B?Q0J6d0FTMXUrblFNbi8zeTdYMjc1VHhOdkpua2Vmdnhwb1pib0Vud3FpMFJC?=
 =?utf-8?B?SERlRUxnSDFYZERZcG9rOHZMZEJpNUxBRFdPczF3SkdWTlBxeHpjUVdDZGtT?=
 =?utf-8?B?T1JQdm1RR0psMUJYNEFLTHQ2ejFzS1dKeW13ck5oODcySXJ6SzdNWG9OSzRP?=
 =?utf-8?B?b2FobG5uNkVsYlllUHJuSGFRcWs0eWJ1Wk9ISmlleU9McUZqVk1hdG00OE00?=
 =?utf-8?B?amx4YzY4VVVGa1Ezd1VDb1BtN1VDc25EQThwcjhtY2EyM0ttNnU5dkkwTk5l?=
 =?utf-8?B?RG1vcnA0WVhmaVAyVDMraDkyYndPTXVzV2lUQjZvVGdnc0VZR2w5UDVoS3Jx?=
 =?utf-8?B?TWEwOUF6UXpldUlkcmltZlhkc0JCbjdCT05ORU1TelhTd05oMlpoVVROZHk0?=
 =?utf-8?B?aFVTcXYweUExMnVTNDRXRk1TTVJxYTVRUmt5UElNVkFtWnBDVnZBSnM2OHN6?=
 =?utf-8?B?NzR6ODN5Nm10anh1Z0Y2NUNIS0t2eDBDejB4a3FsZUREOUFEZmtOQzcwandw?=
 =?utf-8?B?ZThRYmtpb0FLTnhKeVNrY2podHFIdS9YaFBNSjV3cFBCU0tEa1VDRXYxL2d4?=
 =?utf-8?B?S0R3YW1wQjVMR0V0S0xTTVp5emh4MkVseUxzbktnaFNqeWxIYVlieFJRZEdv?=
 =?utf-8?B?NzZEUDhHV0wwQXBzeTJEUExteHl2SHQwNjdrK0JTSVArOUtWVThTWWdrRExP?=
 =?utf-8?B?SW5NeE81Z0dMMDh3aXl4a0tMVE8reVBZRHllTG1QRVA0clZZMGJwdEVHSkM5?=
 =?utf-8?B?OTF1ejByeTdXeEVmOVdUbU9mNi9VWG9tRUJocUJmZTlkMmVXZkRleGYzeVpv?=
 =?utf-8?B?bzQxdnFGWmFPNVlZekZjQ1RJUmtnVG9kVkI5dHJhMDFoMHRxTkUrT3hIdVhI?=
 =?utf-8?B?OE10WDJaMnorQ3lvL0NHTE96SDkzbHhpVnkzaVZqWUt6ZkdwelNDSUZacmNS?=
 =?utf-8?B?N29PYktZbXkvU25uN0hHM016RGhRbi9xY09vMWZJSHBkWTdqUmV3SzVFWnZI?=
 =?utf-8?B?UTErcEZ5bzFpNTNYMHFDa1FoSEsxQUkzUUk0cmhTRTFzeUVIWDdmd3lReDEw?=
 =?utf-8?B?TE8ycm9oVHdhaVozbW0xN3VIVEp5TnVTeGN5NGJEcHZxOS9VSGFMVzJpTVlt?=
 =?utf-8?B?di9lanplaXNPWkZzN3RtY1dEdTBkZTJyakduenVkN2ZKeXdoc1lvS056TUcz?=
 =?utf-8?B?eHNEUVJKQkE0WWhORjNkUWhQWlJtSDdjbXV1UjVuc2xGcSt6YStKRTFqRDdO?=
 =?utf-8?B?NTlmS0ZzNlJLY2tVMzVKRzJ3T21ra3VicGd2dVZUR3cvUXhINWlhN3VNVHFD?=
 =?utf-8?B?eG1BVzBQcTZzYktlSXg0OVVGd0YxOHU2WG9vRDFHTG5QaFE4bzBKN3c3YUdv?=
 =?utf-8?B?YnFHaWgxaWpablNSNTdtNVRRa0JNSTdNbXVKSVZteDZQMXkvSlA2bnNHYzdM?=
 =?utf-8?B?UmtsYjN3a0U2b3NkaCtwUkE2Y1NjYTFJRHBlWVhtNVJMQXZNOXEvb2dvOUxW?=
 =?utf-8?B?YkJ1UTNJaFNjcGk1YUdsTGQ1ZjNwWDR1c1cyZmxMT2JQc2czTGJxSUJVUU01?=
 =?utf-8?B?RkpYWVZHaW50NlNhUmZuaWN0b2orTmx4R1NHWGFZTU5rc1dMN1M5emp6VXZS?=
 =?utf-8?B?aHpwZGJQYzF6bnduWldjcXFqMHBYQjVyRTZaZmpRTXpOT0crWUthOGJ1azA4?=
 =?utf-8?B?WkdTd3Fpc0tBNnVDVjJiTCtRY2hzOG5LUjIwV1ExU3k3ZmJlNVduaHpjdERN?=
 =?utf-8?B?SEhzR3c2RTI2aGt0V3dNRmNxQUJ5aEpkM21zM3huL29Ib3ViY3k3djcxQkFk?=
 =?utf-8?Q?VI4prRUn5k5QW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0x3YlNQMWp3L2ZpMVkyTy8rdmNqRmFNOUxPOXFFODYvclRKYldtS25SZzhN?=
 =?utf-8?B?cGI4by9xVCsxektTb09Zb2hYUnNMT0hXNHJnMUhKR1BTTitOeWszSVhIQzF3?=
 =?utf-8?B?NlppNkJoWGtpTy9yb1BEclYwaTJZRnJnSVBXSFpLZG1PK044djRIbEc0SitW?=
 =?utf-8?B?VG13Ym9UZ3dRM0FYUmlFdGw5KzQrMVoxYVFNMmhhSzBhR2ZqYThwV1Zwdm8z?=
 =?utf-8?B?T05DWWxYczNsTnpJakw4SU11SE1malE3b2JvZmZGeUtEMXhrcERRRW9RUmJU?=
 =?utf-8?B?RldIT3NEUGxvd0ZDVjRTL1k1T2o0aG1XR2FDclJ0Y1NtSkU4bXE0QW9HWS9N?=
 =?utf-8?B?VGlhQStyK3VNSVJEb3ZxRDROdVNoUndnTjYyaGVhc0dqdk1TMXY5TU5ISXVC?=
 =?utf-8?B?SVhUaEJORXJDNExIQXZnR0VaVWs2V3R5ZEFmNmNuQWlVNlh4amJBelZLZ1Vm?=
 =?utf-8?B?MlBzeE14SXUvdEY0NDBrWDJyYVdXTEsrU0lVbHU2aHc1cGwvbkZxL2lidENI?=
 =?utf-8?B?cVVqMTVJQjBXZXpqNktYOExkcnBydllOWCtMTmpTTm5DVkR5RlovTUo3dys0?=
 =?utf-8?B?bUlYTk1ncmpxaFc5Q01zYWVyK1V0NG1CYzllN3lwdWNOMFdkTTA4QklxcXBY?=
 =?utf-8?B?R3c0MDNlWXJleFMwL3FRTU40S3YyTU05d1I1REMwTU1HV2tmNzQ5NkJxd2dx?=
 =?utf-8?B?RHliL3JJMzlwVWpwUGJWNEdGaGVxYkxjaENldzYvWFlOL1MvVVp0Sk9uNFph?=
 =?utf-8?B?cDhnMDlZSkNOYTZMTkpMMVp4alJKZjRZRTllQWVuNk5GM2Rsby9JOTNiOVox?=
 =?utf-8?B?VENTekpPcmZtK21FUDZiNkJmNHc2K0t6ZE9hOGJjQ2FOQnlUSnhXNnZoTG1s?=
 =?utf-8?B?R0NpL21lL2RUSDhNNXhyKzd3dEk3VWdEcVoxUG8zajUzcisrVnV3ZWVXRTNv?=
 =?utf-8?B?UTVDenZJR2VVYkI3c1pHb2FYTHl2akFzRkVzamhDOXd3eklJMjB4WXBDWTBj?=
 =?utf-8?B?VTRWT0xSekoxOUpsVGpXeWNQWStaYVZuWVNINjVvZGtkL0NjdE4rR0JYWk9K?=
 =?utf-8?B?WFViM2wrQVNJU0JORDRFeXRZbHBpQklNYy9kNGlIRzBOTzFaRmw1QUJzQ1hR?=
 =?utf-8?B?bW5yRzRCbTdHcGcwbnh3aTV6NGh0V2EzeHZ1dXduekRUZG80QU52d0pyTEZs?=
 =?utf-8?B?RTY3SjRsQVBnTnUrbFpST3RuYWwvTUxSOFpKR3E4MEVMNGF1VTd3ejMyL1Ni?=
 =?utf-8?B?c1dBQVM5Q0JGQ2tmMFB1L3krUDlWbFpLTFdXdTRpODhuVW4rUzVFTzdFZTNN?=
 =?utf-8?B?NzJCMFhhYm9pWWo2TERwV29FY3BjR2R0ZFQxWVJjbTRWc1VrQjNTem5oenUr?=
 =?utf-8?B?QkxnZnJIampPMlBmeFJ1MjEwTjNtNC9xeExSNHJWbTNUWkZiSzlrbmNTY05K?=
 =?utf-8?B?NGRpejJPVnY2dVdRTCs4U2t5ZGFCdmZ2SUJEU2s2dDlnSTAxOG1kK2VyVjFG?=
 =?utf-8?B?N2VIQ0ZEalpGZEJ1SzVaY2UwOXd6MFNMeUxmWEtQbi9YbUFRMlRmYmd4Rjdl?=
 =?utf-8?B?ZVpEVFZYK1JrM1FYZUZkUFhqMTNRbGhlZ3VIM3ZqcUdBNWlDMXk1UUxlMVlz?=
 =?utf-8?B?cGJCTjlPYzRMQ0l1WDhKeWxrYmF1TzEvNks3VU85MnFoa3VRRFJWTEVQdi9Y?=
 =?utf-8?B?QjFBditxWE5DdU1XT0dudmNHS0lsb21tOEMrQyszcTgrR1dXNzhYWGlOSWFG?=
 =?utf-8?B?dC9mSUpYRkhKVzVwRUlWZUtoUHllR0Z0a1RPQjVOSlNhbG1BZE54Q2NQRGtk?=
 =?utf-8?B?NTVPWUhlbElDYzV0bWVYVlRlR29iNk1WKzNFK0xTdlhsUHE0RG1walppV1FS?=
 =?utf-8?B?U1pTYS9DdmJaMHczWmFjRFovaUg3UE9QTlUycXNnTUZ6d2xndWdmSzdGWGJY?=
 =?utf-8?B?S3lmNG02V2FnMytVY3FBbWthZlA0M0ExK0c0ajVGSEVubUhrTUtpeGVPMW85?=
 =?utf-8?B?eTZ2bFVyL0dkaVBiSUg3T2VvdFlZdSs1YzRkU2pVL3E0QnNXZk1yRHE4U3Rt?=
 =?utf-8?B?TlhsRUFUMVNIRGVIYTd5R3ZRblVsMUN4aE5jWlN1ZitweUVuL1NKVG9ZbnZS?=
 =?utf-8?B?U0ZGZVdlNWhYS042aEsxajVnTEcxcHlDUzVBUitwUDJZWmUyeVFaajgwcis3?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a7f897-7759-4804-4484-08dda2a652a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 13:55:39.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFAyjgPh1tHP9z/sEzmb8SHt95oA/UkROyvAc1bmiDIaelDb6ytdSCMSur2koyNJAfVZ2z/XPV0kpc2KpDvaGjvO1jyrPIQTcz+ng3oLHBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

From: Kees Cook <kees@kernel.org>
Date: Fri, 30 May 2025 12:13:16 -0700

> While not yet in the tree, there is a proposed patch[1] that was
> depending on the prior behavior of _DEFINE_FLEX, which did not have an
> explicit initializer. Provide this via __DEFINE_FLEX now, which can also
> have attributes applied (e.g. __uninitialized).
> 
> Examples of the resulting initializer behaviors can be seen here:
> https://godbolt.org/z/P7Go8Tr33
> 
> Link: https://lore.kernel.org/netdev/20250520205920.2134829-9-anthony.l.nguyen@intel.com [1]
> Fixes: 47e36ed78406 ("overflow: Fix direct struct member initialization in _DEFINE_FLEX()")
> Signed-off-by: Kees Cook <kees@kernel.org>

Looks great to me, thanks!

Also, double thanks for this hint about using __uninitialized to
mitigate perf hits with automatic stack initialization -- will
definitely help :)

Olek
