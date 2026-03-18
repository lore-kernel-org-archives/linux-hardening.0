Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3C36AB50;
	Wed, 18 Mar 2026 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820111; cv=fail; b=Z6uRoU2WGzwNMnkvOUP6lks9xHwMTL7b+S7ZhwVeDjzYPx3ZagqA3H/JDyp918tp7vvNx5ENJdps9xmEg3Dm65N0YH998VuIc1uyXPQHWLrPTfXuyOk8iXg9G4TgkA2aQHBNy8/vhuKkbyoM/Gf1h8XJscWQVM+wL52dVc6fBvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820111; c=relaxed/simple;
	bh=dmVVRCDmjorppQYcfe832of82glQZmzsftIk8WfXbVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PjQXC7KcJ++cQt8DN2DtvFlKUJ5SQltOT5McotYmu4IvYH9niYki+oVqdph5Wzksn1e1NZAtns7T43y71FlkuMUoEhcl9PKm08pFfQOdKm9J4vTa/QdhAkjW178cB8feBMCEBBk5nP9BO8RH0Cqb6odF87SP6i74ndrJnT9M1+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bly7E2iV; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bly7E2iV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773820109; x=1805356109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dmVVRCDmjorppQYcfe832of82glQZmzsftIk8WfXbVw=;
  b=bly7E2iVkJ5F2VBYDkI8fezzRoTdgq3V8v5DevGrHXEUJxjfKttdfPOX
   vmkqNwwX9T1UFjBZ1OVub8FF0ckpvFv7MCYWpA/TFdUIoDo9yjXslNMye
   zcmOKvjlw8PX3YyhFQz8KJ3/mGAAygk/1aJJRs1eeKjFHhLyKJWDRWo5V
   JITPkeDxrPqFylZutaoFLD/Jh+78MU92HpCWxPyy0a1rWCx8R3g1nx5aZ
   omKwKF3sQbmS/3HLfKHpLXl6/HQioZUWlMaURoR3mPrME4r+j1IyfA0gE
   mTxfzcNFsS1Gz1adCDOmCEFAtG2xlwmwHkkj6c6L8PLi4ojc9YEcfczH7
   w==;
X-CSE-ConnectionGUID: x1onkyhVSe6elX+TJ8EJNg==
X-CSE-MsgGUID: 3UBPA/j+SFymzSTBwbUvjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92249838"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="92249838"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:48:28 -0700
X-CSE-ConnectionGUID: tUR9l6GpTNmwlKIcNeb96A==
X-CSE-MsgGUID: jrhb7PN3RwSx7U9YgH2Rdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222590210"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:48:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:48:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:48:28 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuCulRKH/ZETKIKRtzg430qT0SC0tKVWBjjVOMCBc1YPoEHEFRxz98eA+acSzVJ8spVrQE2abppLBqmGakqVQM2IopBirY0idxjXSD3r5PlEq3uMqt/cF4ld4RbarylD+S4rjN+bgjYFOS4waaZHGjt7dT25wpqrc/epcH33KIIGME5unIZj/JYuOL4c+D1cdeHMYXU6HQk/3wLRh5J9eWOMQKtvdY+9VSqadPYZQanWWtRHh5fL2OY4sad+Puo4SMrWpaVPP1iBTQQMKu+YA+fORfwdiIdaKFL96I5D4qR/O6R3tP2eXeOYuEPd8fsegqK1NoeaEtEymAlxVgYBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmVVRCDmjorppQYcfe832of82glQZmzsftIk8WfXbVw=;
 b=Atdk8Gpgsd6MY2Y/VvgnqkIdwxayO8iOc4j7Dab0Q/5xEoJx+F1IH6EqaNgwvXSZSxAmwzFaLcveIBTJ/uTBdRSUFhlgV0vX/VcBAJZgwVDIkEKJWgjS7/NXUAADBp5fjYuzfLLoi7iSq4RTNf8+edYiaHOZ5f0a8yIUj9VpU++iR7KBdXik04Lkjqo1uOAiMro3tJmNnwJXvNbA6j03maGe1CwnW1YDNkhtfwctCG/7YVZJp28AmOnsXfcjhokO5ba80BuWn2PwRasSfZATVrhjegrZ/5cGoDSnkAa8V43SxFAzTMXWshAA0f8RQXTSIYBqXPomxvQm7xGy58xoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6191.namprd11.prod.outlook.com (2603:10b6:8:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:48:23 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 07:48:23 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: RE: [PATCH v3 06/22] docs: kdoc: use tokenizer to handle comments on
 structs
Thread-Topic: [PATCH v3 06/22] docs: kdoc: use tokenizer to handle comments on
 structs
Thread-Index: AQHctjlJA4FsgycvSkq0pI1/6UTQEbWz6rWQ
Date: Wed, 18 Mar 2026 07:48:23 +0000
Message-ID: <IA3PR11MB8986FAD8B8AD9DDA939B4094E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
 <054763260f7b5459ad0738ed906d7c358d640692.1773770483.git.mchehab+huawei@kernel.org>
In-Reply-To: <054763260f7b5459ad0738ed906d7c358d640692.1773770483.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6191:EE_
x-ms-office365-filtering-correlation-id: da164883-6d14-4d69-3374-08de84c2bb45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: SKPJHzVcS0rZtEL0iNxw44jZYFVRHBKRcmNRlrP9nzsx14KBTIN2mHNBkZSunYbR4lDCPpOeqmQSx29He+dGGiVyFXk0NSjQ+Zb3b0fkGIGL5F2MQ5zijMOetT8jStrT4yDhZadojLPyI3/cidPkPehCGi0ArU0q6niVJ0lewe4TMW5ope0qdRWi9WZrxlsMtYS8PinSHcJ0i8iDd3MNyNRSPqGrWBCwotnGBqWaIWJpkdmQrkWyYhquLKtHqcXjB2AA4xB2gOVkjjZuxR0WuEZIV4WeWBNHfbVbd/nsX2GThmMwz3tuDab0DwSoFmS3mr17FCc8TxikACSbXYGzgOQzH2OabMDz50WD8+sFwMdv2uSsny4PqlfQs3SiQmdn96/4bj3w8QvnyrPhSQh5J3Z8V9WSagphSfFCm7NpDCU2N6S8CUrPjtpJLjhcH1B0wsTXsKvp7igwnHxDrwC3FZoVYKAGHSp3p0n65r6omSfMCniaj1a3IVFKBN0JafOnv/AFWig5gE28Po9PzqfXsSbZ56QOVx0ck0cd0hi25/phQ89CMm8PHqQiHG5ccvz7ii+uEchXssIhtbjNqTNeJiN93bDgUS0ylpzWuV1ahMJ+zFYZwUV/hIBJGHpaJGWMu6k0DtFHsyOyI1xSPDjBZF3z1xIVe6vlyuNFKfUD2vfOzxt6De4DzAps94zK5mfIz9gY0ZGTjjOy194GLEr3Xzn+XTUrlDW32objDPqAegR/t9oEaXn8UrUfyRVxTq5iiKfAOcMzh/YEnwSZYExZ7NzmOJOPl1y6NKEKkbjY9HQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3RmcVdidGIyTTRGR3NQVkVLdC83SkgzRDhIVDZONFhVMmFRQm84QkJLUmRZ?=
 =?utf-8?B?RE9aMC8zVnk0UXdzL2hoRFBlUk44K09jZStBWnA2SW8vUVMzSitoWDdidHEw?=
 =?utf-8?B?cTFKTG9aN3RxMUFZelduQlo2eU1Hb1JPWjhWekpmQStiMDNRQ1FBVWhjMlhH?=
 =?utf-8?B?SC9ZR0Z3MjFva2hJbExFMFd4Vmx4cHR0Snp0VSsvY1h4RHd0Z25Pd3FHbGtR?=
 =?utf-8?B?U2FLVERmb3c1Zjd3VzU2VFFWNmtEc1F5WmRodVBlQ3FCaVBibnVuRU9hZkdk?=
 =?utf-8?B?eURFbGFsUlMzaTBzMVFzR1hUcWpMZEVIeXo4YWdXdEpTTlhLT1BQa2dha09h?=
 =?utf-8?B?V2RIT3ZiMmNlZUZPRzJ3cEltejZXaHFwaXRJRFlCUzlpOEt5dFBsS0kxTEZY?=
 =?utf-8?B?M3dMYVQ0bGl2MGwrM2ZyTG9FZDIramhobmQvVllvYUdvQzFwZWR6UGhka2Vt?=
 =?utf-8?B?RlBTblh6bHlNWSs5REUrVHdCSTVxTGRoMHl1cUdFSU1YSnBaOWpwYUFacjVH?=
 =?utf-8?B?TG9YOUNSVFl6ZktUWFZKTnlhN2NjV0Jwb2k4TlVVL1ZuTXdOQXU2S2FSK2h6?=
 =?utf-8?B?dVVoZjRpY3pqL0dLaVJJMnVZV3lqSFc4K0c2RThCbG9uTUhQa0x6cENTRDhz?=
 =?utf-8?B?dUFVMnNsWnRtWW9MRFRuaVpYWkhXNkM2eXUyc1g3bGNzRFB0ZWdCUHA1ditV?=
 =?utf-8?B?VjNNNzc1VS9UNG9XaGtlNk9sSFlVSzBnZURrQ1VNUHAycnJYdll4d0toVnBY?=
 =?utf-8?B?cmVweE9ybnBVMm5rWW5ZcmJ3enFTb0dNQ3lEZDJva1duM05PRnd1ZU5ETzRN?=
 =?utf-8?B?bFZYdlZaclVPOWY4S0E2cjJCbVBnbitwNU91dytBak1WUmpJeGQvZ1RrR093?=
 =?utf-8?B?czFRQndRSGJRVENkS1NUOUNPVzVLYkZoUTdRYUdETzk5ZHdib0NCNUZQSkR6?=
 =?utf-8?B?QklzU1FsMW9BZlE5SmtHK2JDamNKczRXanRhbklaWStMYVd5aGdrUllEOVZW?=
 =?utf-8?B?cU5STlNxUTQyWTBSMmg5MExYdjhJNHZsRVNVSXNDK2xzVVpwQzZWdmJJdVQw?=
 =?utf-8?B?OTJ4VGcyaXJzYUhJUnF1NUdpV3hFN0xFUkZFQkhWR1FMeGxjNjhtWkhLTWJL?=
 =?utf-8?B?bzlVemhkUGsxT0FDWGIzVFl0ZEYzTUZUMEVKVy8ySkI3UStLeTMxZGQrMEI3?=
 =?utf-8?B?TFVpY1hyUlBqUzNzTTdEOVFpYWlyWkE1V3JhVU95Vkt2Y0pTSnRSMHBRcjZZ?=
 =?utf-8?B?WVhFZ2NXRXlVYWE2Uk5Sa2Znd0Foa2FOdWxKQ0pSZG53eVUwS2R4Z1FiRnNh?=
 =?utf-8?B?dy93bHlSNXIyWnlVeU1GVjlkdGo1eEltZ2g5VDNKUEFDK1AxWE1BNDd1anYz?=
 =?utf-8?B?OGpwZVlUckszeEVBWnhtbG82TTNENHVlUFlvbTJYZk9Ha0oxWXZQcUxUcjVQ?=
 =?utf-8?B?ZmdXdXRFSEkyM2tuaSt4WTFYRnB0cm84d0U4VS9MbVl5a3JlbDZFcHlQUWJq?=
 =?utf-8?B?ZnJMdXorQ2EwRDBSY2FIdG11akJKUm1tSnBDRHMwejFNcUVORUR4Wld0UHFi?=
 =?utf-8?B?V2xsRHczc3U4Q2h1djNmMW5ZYWxEeVk2TDJBL2FnYklWRC9oUmxXcWN5REdR?=
 =?utf-8?B?bjJWVUpwYkZRd2liUFdjaldvaTY0UzVYUTl3eEdaMzk0WjJaRjY3dFViSS85?=
 =?utf-8?B?T2FDQU95cytPNngrWmtXcE1kWnovaUo5R0FicWN6SjJQYUh5eTB4amhsRkFy?=
 =?utf-8?B?czhPQXFXZlZlWlNEeTdrcUc5THQ1MGw4RmFjK3VuSWdsd1UvczlvNlRDVWJ4?=
 =?utf-8?B?SDRGbFdzT095M0QzRitjaEVYeXJpREpVd0ZsaUhaelB6NEh0N2g2cTFqdnEz?=
 =?utf-8?B?VVpFSUc5MTZtVVNqQlhmbjZQakxNRkg1RURWTXgvZDZtV2ZZNTNxS0Ztb2Zo?=
 =?utf-8?B?N3djQW1OUTNBS0UzR0IxaTBNOXd5QTQyYm5BSHJNdlpta3FqMWpDSDdhbmhQ?=
 =?utf-8?B?cFhsN0V1ZkhqTGE0dHU0bFZjVnVjeXJPOGNIekNEZDVvK1VmYUhyOTVvQlB5?=
 =?utf-8?B?bVNEU1NnV2Ywc3JGQ0JTQlVDVk5wYWNhVTlLTGJuZzdPSE5veVpzSnAxdHFa?=
 =?utf-8?B?TXozQitDYWk3QnNkMHhIaUhzazdDR1Rob2lsdlA2ZGFNclhONFRoKzVMa1Fk?=
 =?utf-8?B?SERXUngvczQzYTNOdHhWbzRqMjRMTGdEaThMRmJiQVFUS1NzVHk0a3U2K1FP?=
 =?utf-8?B?b2VjVWRjRzdXOHVuVCtTUGQxbkQwQ2NWeXoyMGl1Z1pyL3huZXluelUxc0JI?=
 =?utf-8?B?NHBxU1NEZ3IzN2FCVlpmalVCMkl1OERzRlVTOUYwRzlPbGFFV3FnaDVEOXhs?=
 =?utf-8?Q?Ruh92V4n9Z7QbQ60=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h5/y010YC5dZeZLfKubUhOspP7BBs0W9snVo53SzehGWp1sIs0P0/CSUlR6cyjgb1J+sbFnSQ4eNrjZcZ4HZWEoaGo0EiXe7sWMaY2AxotV+1JsLxDtmnlYhYa3N2pFiv1uotbr5E36Y/uK0qzXwevQXi8q9OfStgrBFKtqFdc31UEmCNpIeykH3VWWH2Oapj0Gk3Jz9+7gDj8rvNhyETi0JvCSkdJGEgyqprFpEFp/4k4OjkeD41wJR8yoR7VhTgAdO20HpKfk7SqtzUS9pbnHWEerQO0P/zq9XBlbQ0mubAxaRzxisv++rN87JQeIym3FKSgy+i7GuQskeTKEVrw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da164883-6d14-4d69-3374-08de84c2bb45
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:48:23.3241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hU1UzuDWD8Fj23heMh+cCE41djOylDYxlx3B+e6JryD4eUlgfF7ssBra/EQfYyD160zwJRoO90AvX/4syqhhYLMTSYGgwEVZa/+9OyLVlq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6191
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJj
aCAxNywgMjAyNiA3OjA5IFBNDQo+IFRvOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0
PjsgTGludXggRG9jIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+
DQo+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+
OyBsaW51eC0NCj4gaGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgTG9rdGlvbm92LA0KPiBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZA
aW50ZWwuY29tPjsgUmFuZHkgRHVubGFwDQo+IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFN1
YmplY3Q6IFtQQVRDSCB2MyAwNi8yMl0gZG9jczoga2RvYzogdXNlIHRva2VuaXplciB0byBoYW5k
bGUgY29tbWVudHMNCj4gb24gc3RydWN0cw0KPiANCj4gQmV0dGVyIGhhbmRsZSBjb21tZW50cyBp
bnNpZGUgc3RydWN0cy4gQWZ0ZXIgdGhvc2UgY2hhbmdlcywgYWxsDQo+IHVuaXR0ZXN0cyBub3cg
cGFzczoNCj4gDQo+ICAgdGVzdF9wcml2YXRlOg0KPiAgICAgVGVzdFB1YmxpY1ByaXZhdGU6DQo+
ICAgICAgICAgdGVzdCBiYWxhbmNlZF9pbm5lcl9wcml2YXRlOg0KPiBPSw0KPiAgICAgICAgIHRl
c3QgYmFsYW5jZWRfbm9uX2dyZWRkeV9wcml2YXRlOg0KPiBPSw0KPiAgICAgICAgIHRlc3QgYmFs
YW5jZWRfcHJpdmF0ZToNCj4gT0sNCj4gICAgICAgICB0ZXN0IG5vIHByaXZhdGU6DQo+IE9LDQo+
ICAgICAgICAgdGVzdCB1bmJhbGFuY2VkX2lubmVyX3ByaXZhdGU6DQo+IE9LDQo+ICAgICAgICAg
dGVzdCB1bmJhbGFuY2VkX3ByaXZhdGU6DQo+IE9LDQo+ICAgICAgICAgdGVzdCB1bmJhbGFuY2Vk
X3N0cnVjdF9ncm91cF90YWdnZWRfd2l0aF9wcml2YXRlOg0KPiBPSw0KPiAgICAgICAgIHRlc3Qg
dW5iYWxhbmNlZF90d29fc3RydWN0X2dyb3VwX3RhZ2dlZF9maXJzdF93aXRoX3ByaXZhdGU6DQo+
IE9LDQo+ICAgICAgICAgdGVzdCB1bmJhbGFuY2VkX3dpdGhvdXRfZW5kX29mX2xpbmU6DQo+IE9L
DQo+IA0KPiAgIFJhbiA5IHRlc3RzDQo+IA0KPiBUaGlzIGFsc28gc29sdmVzIGEgYnVnIHdoZW4g
aGFuZGxpbmcgU1RSVUNUX0dST1VQKCkgd2l0aCBhIHByaXZhdGUNCj4gY29tbWVudCBvbiBpdDoN
Cj4gDQo+IAlAQCAtMzk3MTM0LDcgKzM5NzEzNCw3IEBAIGJhc2ljIFY0TDIgZGV2aWNlLWxldmVs
IHN1cHBvcnQuDQo+IAkgICAgICAgICAgICAgdW5zaWduZWQgaW50ICAgIG1heF9sZW47DQo+IAkg
ICAgICAgICAgICAgdW5zaWduZWQgaW50ICAgIG9mZnNldDsNCj4gCSAgICAgICAgICAgICBzdHJ1
Y3QgcGFnZV9wb29sX3BhcmFtc19zbG93ICBzbG93Ow0KPiAJLSAgICAgICAgICAgIFNUUlVDVF9H
Uk9VUCggc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldjsNCj4gCSsgICAgICAgICAgICBzdHJ1Y3Qg
bmV0X2RldmljZSAqbmV0ZGV2Ow0KPiAJICAgICAgICAgICAgIHVuc2lnbmVkIGludCBxdWV1ZV9p
ZHg7DQo+IAkgICAgICAgICAgICAgdW5zaWduZWQgaW50ICAgIGZsYWdzOw0KPiAJICAgICAgIH07
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVh
d2VpQGtlcm5lbC5vcmc+DQo+IE1lc3NhZ2UtSUQ6DQo+IDxmODNlZTllOGMzODQwN2VhYWI2YWQx
MGQ0Y2NmMTU1ZmIzNjY4M2NjLjE3NzMwNzQxNjYuZ2l0Lm1jaGVoYWIraHVhd2UNCj4gaUBrZXJu
ZWwub3JnPg0KPiAtLS0NCj4gIHRvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3BhcnNlci5weSB8
IDEzICsrKystLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tk
b2NfcGFyc2VyLnB5DQo+IGIvdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcGFyc2VyLnB5DQo+
IGluZGV4IDRiM2M1NTVlNmM4ZS4uNjJkODAzMGNmNTMyIDEwMDY0NA0KPiAtLS0gYS90b29scy9s
aWIvcHl0aG9uL2tkb2Mva2RvY19wYXJzZXIucHkNCj4gKysrIGIvdG9vbHMvbGliL3B5dGhvbi9r
ZG9jL2tkb2NfcGFyc2VyLnB5DQo+IEBAIC0xMyw2ICsxMyw3IEBAIGltcG9ydCBzeXMNCj4gIGlt
cG9ydCByZQ0KPiAgZnJvbSBwcHJpbnQgaW1wb3J0IHBmb3JtYXQNCj4gDQo+ICtmcm9tIGtkb2Mu
Y19sZXggaW1wb3J0IENUb2tlbml6ZXINCj4gIGZyb20ga2RvYy5rZG9jX3JlIGltcG9ydCBOZXN0
ZWRNYXRjaCwgS2VyblJlICBmcm9tIGtkb2Mua2RvY19pdGVtDQo+IGltcG9ydCBLZG9jSXRlbQ0K
PiANCj4gQEAgLTg0LDE1ICs4NSw5IEBAIGRlZiB0cmltX3ByaXZhdGVfbWVtYmVycyh0ZXh0KToN
Cj4gICAgICAiIiINCj4gICAgICBSZW1vdmUgYGBzdHJ1Y3RgYC9gYGVudW1gYCBtZW1iZXJzIHRo
YXQgaGF2ZSBiZWVuIG1hcmtlZA0KPiAicHJpdmF0ZSIuDQo+ICAgICAgIiIiDQo+IC0gICAgIyBG
aXJzdCBsb29rIGZvciBhICJwdWJsaWM6IiBibG9jayB0aGF0IGVuZHMgYSBwcml2YXRlIHJlZ2lv
biwNCj4gdGhlbg0KPiAtICAgICMgaGFuZGxlIHRoZSAicHJpdmF0ZSB1bnRpbCB0aGUgZW5kIiBj
YXNlLg0KPiAtICAgICMNCj4gLSAgICB0ZXh0ID0gS2VyblJlKHInL1wqXHMqcHJpdmF0ZTouKj8v
XCpccypwdWJsaWM6Lio/XCovJywNCj4gZmxhZ3M9cmUuUykuc3ViKCcnLCB0ZXh0KQ0KPiAtICAg
IHRleHQgPSBLZXJuUmUocicvXCpccypwcml2YXRlOi4qJywgZmxhZ3M9cmUuUykuc3ViKCcnLCB0
ZXh0KQ0KPiAtICAgICMNCj4gLSAgICAjIFdlIG5lZWRlZCB0aGUgY29tbWVudHMgdG8gZG8gdGhl
IGFib3ZlLCBidXQgbm93IHdlIGNhbiB0YWtlDQo+IHRoZW0gb3V0Lg0KPiAtICAgICMNCj4gLSAg
ICByZXR1cm4gS2VyblJlKHInXHMqL1wqLio/XCovXHMqJywgZmxhZ3M9cmUuUykuc3ViKCcnLA0K
PiB0ZXh0KS5zdHJpcCgpDQo+ICsNCj4gKyAgICB0b2tlbnMgPSBDVG9rZW5pemVyKHRleHQpDQo+
ICsgICAgcmV0dXJuIHN0cih0b2tlbnMpDQo+IA0KPiAgY2xhc3Mgc3RhdGU6DQo+ICAgICAgIiIi
DQo+IC0tDQo+IDIuNTIuMA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxl
a3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=
