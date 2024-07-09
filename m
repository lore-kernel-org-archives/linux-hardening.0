Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069BB12D1E0;
	Tue,  9 Jul 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508837; cv=fail; b=DAE/SiMMT8fOvCslKmdAlGLe3fTYfP66+jDVCN4xdvWoSCHlvZL0MiGJxeOIZGSTej1D7r0Q6EYqnWLgZQQzGFx53Kwj4vAzVo1UrShjmyMcES2OvtrLk0MNuTmIIs+yZ65GnphSUZs5ulcofEOa1gia9G98uMvffjq08Vohqao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508837; c=relaxed/simple;
	bh=6j2dAoL5twnC0Z+UhWkUF3/esKeEJd96kz6FKuNlLU8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/YidIn9VNppKU3tPOnFFknMqyHRKhBGhhsYKdM5CM85CYTj07k2uiNSkAc3qXyhmqEkQgkID7Mrdxd5iChfyrrEO+I0GYl85YkdAYLa+Q66EtRXn8FFYk9W5RE5pGgbVdAlCF0TTA7R/aVeaXvvwe492RDtauGSCHRMqa/NuYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8xQH+sH; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8xQH+sH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720508836; x=1752044836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6j2dAoL5twnC0Z+UhWkUF3/esKeEJd96kz6FKuNlLU8=;
  b=P8xQH+sHFTsjbdHjOM9a4lPlZu5Qduk1HGZkmznKqrmCId4KPWpNFeRh
   YutIN8ibal+AW20b8ar40CfHGx/OtdbO5zPYoTvG4pNSa0sCNIl454Rs/
   LCZ+gdz4XL0GWiw415R7T7HXzw1nHh2hpzJhGnWFK4Dl5/Zlg6OMhxOaN
   BjBe5Wz2XhmLp5Glf0KHAjwbwVR4dnjUEiUQth8Jxs1fTnwpxaSL1gc1D
   WOsmOXxc7GYmLCQwtoOIX3+itHwRz1NUMN0QdDeVpdN+GN7T2aEZeLO1E
   rznGhv5AyRdGo2xbsIkjpB6OIL0fT4h8lL5Z8TMQICe53VKDrqkGyDfEI
   g==;
X-CSE-ConnectionGUID: wivWOqUUTYyANBBSD1ZBcA==
X-CSE-MsgGUID: qDLIrUdSQ1yZBVq2X9lPZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17450241"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17450241"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 00:07:10 -0700
X-CSE-ConnectionGUID: 0mFuJes7RUWNulTqMnAuVg==
X-CSE-MsgGUID: Hm74VzYfQJi81i25pqhJPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="52360671"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 00:07:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:07:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 00:07:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 00:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBoc35tiIWsShJOHCdSVeMFvhag/fiYi0nGU1GpEvMJjxZkpy7/DNyZuSFhOCJtsNqcxXkPsjCKz5o7BUS0889sxT+fQ5/nfU3tJWk8BkPOjH+tH8B0+BTl01gffb5tpG8Plyh4M9jIUAtYSOBJyKQt58Zxa/tyoyLw1NGdMmczgF/49rZ5b8XzIveku94ogRTMbzfB5lGBOy1OC87idk5oEH9Fdc3RFMfS2rE49bcExmKgbi7Z2dEE/epMLFdbAirA/iHH/E//x2eQ1JZtwdXT9CiiIY5LCiKzA2mPJ07kfchgrqAdFcVwwFyCqjX26AbxgsRwTamPtWFUvFlVopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zywVbsfQ274EOyKCzQ4oVj2enE9WL/FBmQSzLrOmJ4=;
 b=knTj0Fb5B1zSZLxpyKsZ2Q4Ml06Csug1s4bZ4SfvJrCp8I4BXFsVDTl6kFg5ePDJh0r3PXLWTXvikbe9A3/QhbOqy8FRp+OLYq3/l6MQ+DCf/qIE5EqRjMAL1CuQ9Cidx0XghjZdhgEKVu3n4qYD9dVgMf1QU9WQIAGhGbo6cXYbaMosklhudo/WPQflW9b27Qq07HePFlWBVDCC/20iiLUrPibcIn8NymQXXJHh9/tcgTuindoaJOt7LdHWeXeQhLjfwjF+bB9yB4P+8q3bOUNJFzX6KgIhToPSMNgdym8oDQcxdSrMwhTUSQKbPMP2ro/JMIqTXIvk99B+rMjkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 07:07:07 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:07:06 +0000
Message-ID: <093108ea-f567-4210-9f2e-eb8e5039d1eb@intel.com>
Date: Tue, 9 Jul 2024 09:06:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 4/4] pstore: Replace classic kmalloc code pattern
 with typed argument
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
CC: Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
	<gpiccoli@igalia.com>, <linux-hardening@vger.kernel.org>, Jann Horn
	<jannh@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Marco Elver <elver@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Hao Luo <haoluo@google.com>, Christoph Lameter
	<cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	"Alexander Lobakin" <aleksander.lobakin@intel.com>, Tony Ambardar
	<tony.ambardar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240708190924.work.846-kees@kernel.org>
 <20240708191840.335463-4-kees@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240708191840.335463-4-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0151.eurprd07.prod.outlook.com
 (2603:10a6:802:16::38) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 59973173-aae4-4897-8b1f-08dc9fe5be2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aURwNWpSVlZZbjNEQk55eUZHOTYxdWVCdlp2eFV0by9naWlGVklXNGNGdzJH?=
 =?utf-8?B?ODRFR3dzYlo3NDhuazdqV004WlpmVzIwQWxmbTdaYk84dGp1QmVqMW1WaVV6?=
 =?utf-8?B?UThRcUo2SEhUUzVhMnhva2xaOS9wZTBRYUhYZ21meXQ2ZXk2dG5QTnVTUCtx?=
 =?utf-8?B?MG10QzhFSzZyb01NdXhqSTlITHhYQnVoR1UyODdDRHJzQ0Jqc1pvOUpFZGRS?=
 =?utf-8?B?NStVMVpsTmpCeUlOdHRvT05oUFZYL3JFdmhFY29xOHVlcko5ZTJDdXgrejZT?=
 =?utf-8?B?aXpIZEVLTEY5RmtmbW9TN0huSUJ4bTUySlNoa2lOcy85dzByK21TVDFiRFpn?=
 =?utf-8?B?NXlxMlJXbFRnVCtMRHp4VUdOYXQ2emE3dE85eVAwaHNCUnRJeVdYODhUbUF5?=
 =?utf-8?B?TWpNU283Q0tRUG84MUYvUmZiczBUY2IxWEZ5bGFhaTQ2a25yREUzVEdJV1lG?=
 =?utf-8?B?bnpTaFJpQ3htbDdlWkcwazVNSXYvLzRKUFFyT05tRFVmTmppaFk5SGJCSzFz?=
 =?utf-8?B?R3JBMnZtQW00eU85c1dDQmFBcG1QTVZNcmVLUFlPa3ZtZjZLZ2g4WXdiZndh?=
 =?utf-8?B?SDJyYjR4aUhaNWZ1MmJwTk00MThGTjRXVlRjaklUanRiK05WdGpiZnVJeGoy?=
 =?utf-8?B?czkvSWNaV3NkSmExMys1b1VsQUxIZWc1ZHNQWVczdEM4N1g3YTM4MWNtUzV5?=
 =?utf-8?B?eW45VlkrSWJTaWdEYmZFWUNQajUrTThDVGFPdEtnNFc1emJOaUxpblAyQzZ4?=
 =?utf-8?B?UGJNTnRabnZRSUJTUEh4MEQyZENNWTUwVjR2NGNXOXh4UFc2b29vV3pqRmZm?=
 =?utf-8?B?VGloVEpoeHJMZU1GaTBRdHdxNHYwaUxZbDVXVCs4WGZyUFpJbDk4M1N3VWph?=
 =?utf-8?B?NktscHZEVXdyOVl0cU01Qzd3U0czOXgrcE5GNTlFT3FoU3RidXVlM1FJMzVt?=
 =?utf-8?B?YmNMRzIrWDB0VlI3VEtSNU9aMlpKVGVmbDdPUXZPYnQ5WXUzQy93OWR1alpJ?=
 =?utf-8?B?NGRzaHBNUjhNM0FrZEpRNEdwQTYrU2N3aThjREk5SHZ4VzVUSWttRWhxQWRq?=
 =?utf-8?B?cXF4U091eVFkQnpWUHRORHpieTdUZEgxZ2w4RVBzL1JCTW9Rb3cxT1ZlNWVS?=
 =?utf-8?B?MUtzRmFTSk1JQVU0RHM0cHhocDdidFkrMmcxNmpiM3h2M1I1ZGM2NGJMT05M?=
 =?utf-8?B?VnFSSFBUM3B2ZUdaLzVoQm1LMkdFTjdhSGVLOFdEaEtLSWlaRXdWSFdDOFZD?=
 =?utf-8?B?di9KdEtiUmpteFJLWGNjRXp1SkpKVzVseW9qT1pjMUg1MHZtNk1rSFhZOE4v?=
 =?utf-8?B?czlTei9kQkVrMWdlR1FLV0lFZGdhK0RqOWZudGM3L21FaWRJZjZxcmcxbkFr?=
 =?utf-8?B?cFAzeThLdWpQZi9FK0EvUFFlcnlkM0xQbHFpcWdxL2F3ZXNTKzUvdml4c3h5?=
 =?utf-8?B?RmlxNnlNNytxUFFCcUFmS05VZXlhVjc4TWw2cFdBQk96c1hZT2Vva0M1VVls?=
 =?utf-8?B?MjgzTTJPSDFJUkl6cFZ5Q1FDUjI3ZFczdURRSmFxUjVYc0s0cUc4MGluakNn?=
 =?utf-8?B?aCt6ZnhwUzhCcVJaTXpEY1NtOS9yN0JGYy9reTF2M2s0WVF0UkN3aGFrUkYw?=
 =?utf-8?B?aHdJMTN5dkFCaHZ4T0VHbDR4Um10aUM5b1RMajFFUXh0UEFzam9aSm10ZWdI?=
 =?utf-8?B?NkU2TVZPckU2NDlPQmdEWEloMTNWbVRaUzQ1OUoyckJaZzUrL3hWdmtQMkNF?=
 =?utf-8?B?MUpjemhKN3Z2NC9DNWJYbWJSSXltWGsrRDhUb2VtenNQODVZQTVtZytqbW45?=
 =?utf-8?B?Zm9RSkl5V1lFSVZReWp5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2Qrd1pYOGowZXZ3Smc1dVZ6bFJpQSsrM1Bsd3JkeWR3NURqTW1hWjRaUUhW?=
 =?utf-8?B?ZDdzQ2VpK1htWktGcktjeGpvVEw3V3RDNTh6RExOcmdiQy9ubTNZZGJEU2NU?=
 =?utf-8?B?ZnZaMFFIZ1dMTHB5eWZObHBGSko2ZlZSQ2EwQWpTMnJUN1MwQk9vdVRZUVFp?=
 =?utf-8?B?YWV3SVZnbFJLVGd1UmVHNEFXM1JLN1BOY09ZNmkxWFJ2V2s4NUg1VlJIR050?=
 =?utf-8?B?L2lSeUZ0TmJoMkhMRUxFNDgxZ2xVSUhvL3UxKzhxeDdJa1VGSU93RmxQV2Nu?=
 =?utf-8?B?UXEwWUJRQml4OFJPR1ZmK2FnemZKR1RGODZzajRBeHR0dEdISDFFNkhmdUpi?=
 =?utf-8?B?SExKZG9WOGQzK3JMdUlYR0tPNEdValU4cFFRVnA3Y00vdFhtZi9QTjAxQnor?=
 =?utf-8?B?Wm9XVkJ4UFJ3dnc4N1pibjcxemJhNHh4dmJVOVZFOWNUTWM3TmRzbUEvWk1G?=
 =?utf-8?B?bnFTaGIxU2swSWVsUG15QkJRa1FpdE1kVjJ1ZlUvYnNrY09TM2FkcFArUTdO?=
 =?utf-8?B?cnRoK1pkbG1LQ2h6eHVvTXdiWjUzaWlRbTMwUVBuODlhMUdWcEloam1GNVFS?=
 =?utf-8?B?dkRmdGZ0eFFMRlVQN3NTZUVMdC8zZVBoNjBTV3p0NkhxSHVKNnVWcDl4L2U2?=
 =?utf-8?B?N1pLKzJRTXRLVWdUUUl0d09WUXAzSENaQ3FJejViRzNCOS9aNUM4Um9XRzlR?=
 =?utf-8?B?VVVXTnMwZ3cvL2p6V1FEMlA4VnJ5S0VEVkcrenlRcUY4RitTekgvSFBhR2FU?=
 =?utf-8?B?Unk5MTZuVmo2OTFhd0JVSFUxNXJMNXh6RHhDNVFvR1RxaXl0OXNjTkFCT0k3?=
 =?utf-8?B?MEZpVytKc294UGt3WFJZSzdHQm9pZjh2NDVHWGZWSHdCRG1NNGNkRWZXZFd0?=
 =?utf-8?B?bEpRUmNOb2ROTVlQUVFodzNJdnFURVhrUEdYVTl5QmdGTGV6Tjh6dVBuM0pB?=
 =?utf-8?B?aVZGak1iZ2s1dy9FcUFHcFFGV1hOQlRzdkpCdjNZcWZRMVVhUExVRGQzM29W?=
 =?utf-8?B?SDJMOHJyWnUvVGVVTVpOK2J0dno2SUV2OUdsemNBbTZOcW92cUdHUUFKREZT?=
 =?utf-8?B?OHlRaEhJZ1U2RXpZNllzbzB6MjBia3dCM3BsWllOK3AzYVJvTVg4a1p2bDBh?=
 =?utf-8?B?UmN3eHFhbzFCTXl4U3F5bU1tRnJWYWZlTW1zTVFFd0xhMkRmeWNMT0xDV002?=
 =?utf-8?B?UklyeER4bW12WUdUNURaN244WDJXN2xRdk9lNWRINnpTQk9Gd3dkM0xKdTgx?=
 =?utf-8?B?aURNUjQ0UlN6SzYwbE53TmtvUDM1d1RrUDJVdU1GQml4a1JYdlN5bkJwWDJn?=
 =?utf-8?B?Z1cvbFRhS0hINUswTzdQbmREQzRLT1NqMTArNVorczhpWDA1bHprbWR2RFBh?=
 =?utf-8?B?UGdsNklleUptb0J1alFMdk1sRjhpSUQyMXJsak0zZXI1OE9ra2JiVFgrc2dC?=
 =?utf-8?B?UXZ6OE44dGRiOWp1MEwzdzNBY1QvTDBZQ09iVWJPUXdnblV5WE1FOHgxVEVz?=
 =?utf-8?B?NEdzSmZoTWU0Mm9XVXdSeFMwT1RmWEcrR3hhZXBqTE5ZOXJWQjVaWHFNYklE?=
 =?utf-8?B?b1Z6b1VhRmw0TWNyVUp3YlV3VE1qaXM1ZjhKbWp5NkJJdUdTZDRRVlZ2djlC?=
 =?utf-8?B?emRDNWlPTGpUd1p3anJXQUMxMmVEY0NZcXN4Z3VHMS9HSElvT2EwUGIxa1Za?=
 =?utf-8?B?bWI5aFduektxWmROQmJnV1ZXY1NEQ2VGZktlamJNWmhRNlh4ZjM2OXRIdEo2?=
 =?utf-8?B?L1BzZFpGazBtcVBKZk9BczB2bkIvMkFKT0JYSmZ3L3dxeHV0QmJtN2VIajA4?=
 =?utf-8?B?VXVKQmpXTHhqWE9EOExieFdDTC9uUG5hMUZvcWxjUS9mbWxxYjJ6MHhJZTgw?=
 =?utf-8?B?TnZ2dy83bHdIeDJ6aExQWkkvb0kzL1JNbDNObDFNVk5MR0d6cjBYVlRSM2N1?=
 =?utf-8?B?blR5V3orWmV4NEdYelFWaTdmaVN5RGR6WWJXSGxybU41SE1Nc0JaZFBrSTNp?=
 =?utf-8?B?WHpZdHJ6dXpPd1pqS2lRNk1GUlNOQVBjN2lZVEJzUE9YTDRpeWdJOHhQWUpO?=
 =?utf-8?B?S3Zuak11T0ZvK3h1SHhzeW8rcWVud08veUE3djF2NFdCcEVWcEloMVJWMjNk?=
 =?utf-8?B?TEUzNndBK00rZWt1cmEyRFFONHRGYk1ucFpmSjRjMHljK1JXVm1jMmcxN1Y5?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59973173-aae4-4897-8b1f-08dc9fe5be2e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 07:07:06.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 045L8g00upxbYN/NavK/t6nAqb5lGnBwyDXgIW25261Q4fYk5nlp7XZPY1fzC09t4HnItWtQ87D0P+GgJCkyJzkc3Zyi3FLGK3tF1ycFM5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com

On 7/8/24 21:18, Kees Cook wrote:
> Using a short Coccinelle script, it is possible to replace the classic
> kmalloc code patterns with the typed information:
> 
> @alloc@
> type TYPE;
> TYPE *P;
> expression GFP;
> identifier ALLOC =~ "k[mz]alloc";
> @@
> 
> 	P = ALLOC(
> -		\(sizeof(*P)\|sizeof(TYPE)\), GFP)
> +		P, GFP)
> 
> Show this just for kmalloc/kzalloc usage in fs/pstore as an example.
> 
> Doing this for all allocator calls in the kernel touches much more:
> 
>   11941 files changed, 22459 insertions(+), 22345 deletions(-)
> 
> And obviously requires some more wrappers for kv*alloc, devm_*alloc,
> etc.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Cc: linux-hardening@vger.kernel.org
> ---
>   fs/pstore/blk.c      | 2 +-
>   fs/pstore/platform.c | 2 +-
>   fs/pstore/ram.c      | 3 +--
>   fs/pstore/ram_core.c | 2 +-
>   fs/pstore/zone.c     | 2 +-
>   5 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index de8cf5d75f34..7bb9cacb380f 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -297,7 +297,7 @@ static int __init __best_effort_init(void)
>   		return -EINVAL;
>   	}
>   
> -	best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
> +	best_effort_dev = kzalloc(best_effort_dev, GFP_KERNEL);
>   	if (!best_effort_dev)
>   		return -ENOMEM;
I expect raised eyebrows and typical vocalizations of amusement :D -
IOW: we should consider changing the name of the macro, although I like
it as is :)

other:
you repeat the pointer name twice, and code is magic anyway, so perhaps:
	kzalloc_me(best_effort_dev, GFP_KERNEL);
and another variant to cover declaration-with-init.
