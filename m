Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64847257854;
	Wed, 18 Mar 2026 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819872; cv=fail; b=K7T52/baZrkjJobB+IxWMSN9yKzQorGyDD1GjbB4rXIK+tLtYVt/cd25JW6yUSN1QVKb+lPmDlNjH4BcLUaa1zm+Ci1aLtxpBGGG27Twt+Z2n0K2WUQPKLoyld9aKfPQYpvKJ3ORistO8hj02w5vG1o30p8TPvvQKGBnWp08950=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819872; c=relaxed/simple;
	bh=YAp1tfYcaBv3LNHHoFi6hi7dGybssg3kBd30AAF53b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0rBJGLymzCerTvL5lhIV1fOoYqq4BZ1ZLoY48AeXXBGDsdNQPVZJwBN7AJa9+rcsgEz8Bs0pVOesOKCnJLO8hSfAsToomJDUp2HGvDz3CaC90BTx7pdbmrV4JW2yW1YSYRIdFia4uxegbilUTOH8/KlchnVlUTmWPQPDdFJ9Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aloZuqx2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aloZuqx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773819871; x=1805355871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YAp1tfYcaBv3LNHHoFi6hi7dGybssg3kBd30AAF53b4=;
  b=aloZuqx2EraVv/o1HawPqEeRswno59k1U6ycgjjHp4ioO91w4JkNRn+x
   ilkKvHz3ziCpFYdfsUpr+6UTyn3KpTMOx9DWuP7B/YVaRi0MpqrGWqHJR
   lbsJnks3D0P3yxUXnSeXQsFMwyeKWT6PCckYA1vO4PIi9JSZDvS9SuzcU
   IdKHztaxyw9PpoauihcIErkyetPfXK7IytucB0j4c63RJz2sxk2bXUhj5
   Dzx03gcnBWcABFPXiGKdqzMOxTG6PQ+vopRScc5gNx2BZmuCMLQbMFE1B
   dwHe4mYp3F/Bq8jDYU5ImFedFJYMmoClTNzLWJ2tO3/mvli1gqPVMj0Yp
   Q==;
X-CSE-ConnectionGUID: 1V1GdU/oRtK+UqqnVNVx1w==
X-CSE-MsgGUID: tjl1Wr2RQvesOIJHtDShvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85945103"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85945103"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:44:30 -0700
X-CSE-ConnectionGUID: zUc5A4BwSxuni1ivovXLIQ==
X-CSE-MsgGUID: zcswzUq7T1mpkHyLOlPeig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226676189"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:44:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:44:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:44:28 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:44:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2UNM4sZwCocD1aoiK/mQLIkJNZbo50ytqkw5asxLWJ+TLbAcwCn2iuXh6JN8YBfGxCMYgqpO4RpPJxhE/1/ONJUzdspNIR3U8tjp/GgZ1W6RCh5aaol9ey/EhVtcCsHO/yt/l1xSE8P9FXMm6IZy4hodNvnK0goHzkSxxwLDqpYM9/wLnu/4xFAToGV7xE3M7DmF7/YHNMyLTA9R4w4exDhvragPQpDtTTnyEexaPDRl36TidqCezUTBmPUzl1pqZyV7vxv48Uq08RsOlmnupekNccuMdfHqZF2P8lgJClom75p7Hgebb10rAV2hbg30Y99R3ZwEdppFQ9E2fZ2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAp1tfYcaBv3LNHHoFi6hi7dGybssg3kBd30AAF53b4=;
 b=FSL2pDtHes36vg+7khjWVckCKwrRkOlCR0Y0Dn/z+wDWN4+bXasmomFMCFVPcubJkMjZlTBD5O7ZG7RGRPtCHQKLvVzxDiY3T9yCluHV0e4zDzIClPMs5woD+kktxN1Oeh4ZYyE4N4v1Lq0V2VLG789T7OVBVpa0EnQsEQUJUQSVAgzEKxoVeelPsZMDQTxCCAFRh64rV34X/5tNjUM4+II9wnSC9LhUE0LMnny9htAda+Lq1v1s9UBLPMJtUECmkpwoA9AuJE0GlQsEGNF1YxdCH3ggaQdiTHPUSsus5D+wwhB7UPh3l0R4cTrwiIWtCAVYTL+tH5yjct8hgathqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB8685.namprd11.prod.outlook.com (2603:10b6:8:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:44:22 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 07:44:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: RE: [PATCH v3 17/22] docs: xforms_lists: better evaluate struct_group
 macros
Thread-Topic: [PATCH v3 17/22] docs: xforms_lists: better evaluate
 struct_group macros
Thread-Index: AQHctjlHBIzi1UOUiU+TN8FTrOBlG7Wz6VZw
Date: Wed, 18 Mar 2026 07:44:21 +0000
Message-ID: <IA3PR11MB898606A923BDCC4AE70B6E67E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
 <24bf2c036b08814d9b4aabc27542fd3b2ff54424.1773770483.git.mchehab+huawei@kernel.org>
In-Reply-To: <24bf2c036b08814d9b4aabc27542fd3b2ff54424.1773770483.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB8685:EE_
x-ms-office365-filtering-correlation-id: 7884a190-2675-4fe7-a6df-08de84c22b6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: UmvPjYUQ1oMitwv/RXzV/oxWpMcAFNCi09LCdeZlzjblryhtTKRXuCQQlZXxwNXNfSWRHHHJmyByGbPCNDPr1bU/HsJg055F0vpYZB8uRhO0CfRnFJsXeV481TY/+vhJ9Fzb0Q0HMWHQd47gZSgEX+CuxZLwG+znIV3zNnv6ky16pTmK9/pCZdPACsVcJlI8MMyhepy1qbBymBQxMY50MJw4qGulLCvO3kcjPnYfEb3ZkmQxMMQEMs/BaAYs5gDw3b7fry5T1mWqZKgSXwlMThImSfx7A7Na/yo60TK5mHUYkq/TH8bifKUsdiuDxr1nXdISxNaa9YZ/NzigHEJThzMCy93NCUchabyRrDT0V73OLxPnN+JiKFm8fej0M4soKKXxFHHHc/CVHrMmgkg9fYEcBdUDPKuyPmyM6xlDncn8jLBsRwksm7SwowGbaY3/ooLMHcWSNlW/ZDjrVKas93jU3miXHUHK74wcuSsV+du/9MbDJkmgoguNaEGj1i5EK3PytSb+oDNr0GPx7VuMf+Imww71S5VVN9FftQwZKNEg7nYrkJtyT/3h8mGdZkIkN6H5ASPJlWbGrYlEsa86OTXHvvr7ebLLWvqw9sISvK4vql4w8d8ExDg13CFBOM0X36ctXY83bRemksBWOr9qI/pipOcJdgTw9AB91kjSz6xOr0YPcgHSOQThXTUN/6hsvlJuxyClS1bJx/pDIv28UhGvVeh5QngZ5rSbbPMrLjuUW/TJrTLLhUee5bzSaPs0lhVBqHXbGKCW9+lXHW38k+S0BamdHjfHwhT0VJdeGhA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXFuVTU3WXdEYjJEWjhwNFF3SnRORjZYQzNVaVR2WW9pU2RsSVlMRU85S21G?=
 =?utf-8?B?cjNNbkJYVXJhMFRFK1JTZnd5QlNPNS9DeFJUSCtodDU1Tnk1UG9pOHBOVTBM?=
 =?utf-8?B?UlcwNzE1OTR5bHdLWXFBVjkxcEEwWDFwRldWcmI1ZEdONmVEL0dobEpGSmNQ?=
 =?utf-8?B?S3ZMNkYzekRHSlZxL3h4VUhWNEE4MGRuazgxUzlFY3dzRWJRUlpHOEZQTEs1?=
 =?utf-8?B?U0dJVXVpRHpLZ1hYVW9RMEtMQ0VKaERTdWtnTkt5OVg3ekhzbSs2cEhSNEs4?=
 =?utf-8?B?S1Mydk8yN1I3OWJ2bzJhS1h6aTBtTjVxdDhNT3NnazY0dU5uSUFGa3F5YVNr?=
 =?utf-8?B?NFljMmtPeFRMaXB4Wko3cnJHY2pCTXplWW9nalBzK0Uvc0E3YzNscmZUaGVQ?=
 =?utf-8?B?UGdkNFJCRTA2dHZkQjZJUlo0VHVvRVhBQ2ZoL3NTNmJ5STlkbkpwZHcyK0tP?=
 =?utf-8?B?YnlZQUlZbXpQaGRnWlFTWWJwbTRxT3ZRblpXRTVsMGFtYkc3YTE0d2FwZ1RL?=
 =?utf-8?B?ZGpibHZid1BVenQyZHBSSWdxcXhYdlZEaFpkZkRhbElTUTc1Vk5ZS1Y4T1V0?=
 =?utf-8?B?RXhicTloTk1WRk9IcHdBUjRXa1gzWmw4a01RVjVHMjhWUmc0SUdldVVHdklF?=
 =?utf-8?B?TEZTMUl5ODJKWHZmNitYNk9PeERyckRaQTUvaDVFTUpXL3V2NndIVFYwdEpK?=
 =?utf-8?B?aFF1OHA4S1NZODNGbjNTckNVVmUzQURwdi83ODJ2cmNMNUh2UW4zZWJ3NXNq?=
 =?utf-8?B?NW1kT1g0QVZCV3lBWmZGTlNSQU5jT1Y4V2VlelZYWk11dFY5SUUrQnhkYXhL?=
 =?utf-8?B?elJNRU5hNWNHdUNMVTVMYTl0Z0VIU1pCSzFISlhrQ1BremVIYnVxY0U3eXJT?=
 =?utf-8?B?bjVzQ21ZTTg0dDlkeGZLcGIvVlBvemsrY1ZoRnVSb0dVaTFob1ZtblpiRkta?=
 =?utf-8?B?Y2dsNmxDVWJTVUdlSFAvZmFzcGVRa2FxSXhFY0d5bUZjMGpSVGRvZzVBaGdm?=
 =?utf-8?B?ZDVqeitsK21RRUg4TkFGN01kZmsyT1puRFY3Vk9pNzlVckpWZEtQdDFQN3hH?=
 =?utf-8?B?dVMzQmQ3dHI0QURMZnFnaFZRWThVZ3NqVkkwdUZGaUxVTXN5UVRWa1R6K3k5?=
 =?utf-8?B?Y0QwVXZoQXNGcXJ1Q2gxRWo1UFZMMzA3MTlCdU9OUWRCYVpya0Q0YURNUFVL?=
 =?utf-8?B?eFlHUGhVREZUbHFXbWd1aVYzRXdnVEtOUGpIbWNlSW0xNVg5eVFhWFZQanRM?=
 =?utf-8?B?VkEzMWNJem9vTTRTMlNHSnQwVXRWNTk3eGI2WTJFbm41Rng1dXhFa0g4QjVF?=
 =?utf-8?B?N0lVaEtKUjIrT1dEaGtraVJqbC93bGU3U01iMGdWSE81QVlzYTB0VllQMGU4?=
 =?utf-8?B?YWpDTGI4R2VVMS9GZUtkcll6Ly9HV1c1Rkg3V2JLQ1AvT2VtTC8rUVNwZFYw?=
 =?utf-8?B?OU95TWVsTnlBT2NCMnllV0Rndy9pOUp5NGcvQUUzZXp0RWV3cDdqaExVWVlC?=
 =?utf-8?B?RXkxLzdlN2IvNXVmNkdGb3dsY2l0ZHh2enBmeE1VWk1DTEtsaFpKbDQ0YVJN?=
 =?utf-8?B?NkJnTmE4a2o5aDAyaElCQzZJT2J0SmlySXRiZ0s3VjR1enZ0QzNKcjNvdFVB?=
 =?utf-8?B?QWFLZmJyS2RjdWlUbHp2TVArSGtiZTcxc2U5aEc0SG5McFNrNTM4NW9wcGpM?=
 =?utf-8?B?VW03c1JPUVpnSlRFajJMczZKaHFreEcyZlNHbERxaDNmV0pOeUY4Y0I1OTdw?=
 =?utf-8?B?NmdoY1BLSFBqQ2hQVnU0NTZrT2x4RkxrSVU3VU9laTBuK1dHS3lVcHdEdjlS?=
 =?utf-8?B?YnMxRWlCaUZZMXFiQnQzbUhJRnVUM3RLbUJkc0pIeVZjNnJPcDVUSysvVVli?=
 =?utf-8?B?aVVHUGFOTW43OC9PM1AvVGt2SXI1ZU1kQkVMWUhwSERZT3luTEJKak1ScTRC?=
 =?utf-8?B?c0hrN2k5Y0Fzdm15ZUt1aHJnNU9tc1RmUThYTDhPRmo5b1BpNDZDSzloZ2VP?=
 =?utf-8?B?Zmd4bWVnZDlJNFV1RDk0ZnUzQTU1alVVRVdrZnNFazNhZmdMQjhnWFQ1SnNL?=
 =?utf-8?B?NUhhRURxSXlQQ1NxUVVUVGV4OUV2K1V4alRtR2lkMkxZWkZYeDYvM3ExSW8v?=
 =?utf-8?B?ZUFFR0RpNU9qSlc2SUJpOGVoMTAzeTZtbExveTl5VERjM2lSUjhqWnpBT2xj?=
 =?utf-8?B?dHRuVUcvV2VoM1hqNWE0MERIT1YrLzJWdDVkdUxJcDRwZXJkMTZ4VFFzdDB0?=
 =?utf-8?B?N2xnWmpqZ2VReG1TeEE4WkUvSkRueGlmUTl5R3JnWUZRRmp0ckpVM3lrb2N4?=
 =?utf-8?B?dEpoL1kyNkFMbjhvWEFvNFdMMU5Jc0d6WG1wanFMK3lWOXZZanpUVk44ZU5Y?=
 =?utf-8?Q?kEi1Xc1PFucz54qg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r81FbwGpyDNbjlyRgE0Y9ekt7ExGkJvDUzOdnWNJnRNEAkAXpj4L8sCIw1iL3zjWzCLZmA3Z1wMOvVPp3WUs1lhKFBC/JlnxDz7QFFEfAV63tqjo40Fo3TNEc5dgnTC4z1cmd/erD8RBmaffCQYx64EtmbTuHJfQ1qie5KedIUJ/5VT0Tjk5WCKSqC0mwOYotFZVX7FZByp+RDopb4rxq1+uUSShBRJDo1mGzyErhhj5KhU3pEJc+66JbsmStYFnPvz4t4GgWAw2YaPaczaugLgrtNmQrqU4d9lrIw1qFt1H+h6qRhSWSSuCzpmpQQ1GOYNSPQVVIyd6zSIwCFomeA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7884a190-2675-4fe7-a6df-08de84c22b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:44:22.0144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/zTCcX650JWVb0ha8JRhtZVixjVVejTXFSjP/GZlGzAlI5iVGbw+7CqXyDFZGuZWbCSIe83v1kp/G+zfwaLqu6sVuIGtkeWpyeg/jlDCVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8685
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJj
aCAxNywgMjAyNiA3OjEwIFBNDQo+IFRvOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0
PjsgTGludXggRG9jIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+
DQo+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+
OyBsaW51eC0NCj4gaGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgTG9rdGlvbm92LA0KPiBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZA
aW50ZWwuY29tPjsgUmFuZHkgRHVubGFwDQo+IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFN1
YmplY3Q6IFtQQVRDSCB2MyAxNy8yMl0gZG9jczogeGZvcm1zX2xpc3RzOiBiZXR0ZXIgZXZhbHVh
dGUNCj4gc3RydWN0X2dyb3VwIG1hY3Jvcw0KPiANCj4gVGhlIHByZXZpb3VzIGFwcHJvYWNoIHdl
cmUgdG8gdW53aW5kIG5lc3RlZCBzdHJ1Y3RzL3VuaW9ucy4NCj4gDQo+IE5vdyB0aGF0IHdlIGhh
dmUgYSBsb2dpYyB0aGF0IGNhbiBoYW5kbGUgaXQgd2VsbCwgdXNlIGl0IHRvIGVuc3VyZQ0KPiB0
aGF0IHN0cnVjdF9ncm91cCBtYWNyb3Mgd2lsbCBwcm9wZXJseSByZWZsZWN0IHRoZSBhY3R1YWwg
c3RydWN0Lg0KPiANCj4gTm90ZSB0aGF0IHRoZSByZXBsYWNlbWVuZCBsb2dpYyBzdGlsbCBzaW1w
bGlmaWVzIHRoZSBjb2RlIGEgbGl0dGxlDQpyZXBsYWNlbWVuZCAtPiByZXBsYWNlbWVudA0KDQpP
dGhlcndpc2UsIGZpbmUNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2Fu
ZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg0KPiBiaXQsIGFzIHRoZSBiYXNpYyBidWlsZCBibG9j
ayBmb3Igc3RydWN0IGdyb3VwIGlzOg0KPiANCj4gCXVuaW9uIHsgXA0KPiAJCXN0cnVjdCB7IE1F
TUJFUlMgfSBBVFRSUzsgXA0KPiAJCXN0cnVjdCBfX3N0cnVjdF9ncm91cF90YWcoVEFHKSB7IE1F
TUJFUlMgfSBBVFRSUyBOQU1FOyBcDQo+IAl9IEFUVFJTDQo+IA0KPiBUaGVyZToNCj4gDQo+IC0g
QVRUUlMgaXMgbWVhbnQgdG8gYWRkIGV4dHJhIG1hY3JvIGF0dHJpYnV0ZXMgbGlrZSBfX3BhY2tl
ZA0KPiAgIHdoaWNoIHdlIGFscmVhZHkgZGlzY2FyZCwgYXMgdGhleSBhcmVuJ3QgcmVsZXZhbnQg
dG8NCj4gICBkb2N1bWVudCBzdHJ1Y3QgbWVtYmVyczsNCj4gDQo+IC0gVEFHIGlzIHVzZWQgb25s
eSB3aGVuIGJ1aWx0IHdpdGggX19jcGx1c3BsdXMuDQo+IA0KPiBTbywgaW5zdGVhZCwgY29udmVy
dCB0aGVtIGludG8ganVzdDoNCj4gDQo+ICAgICBzdHJ1Y3QgeyBNRU1CRVJTIH07DQo+IA0KPiBQ
bGVhc2Ugbm90aWNlIHRoYXQgaGVyZSwgd2UncmUgdXNpbmcgdGhlIGdyZWVkeSB2ZXJzaW9uIG9m
IHRoZQ0KPiBiYWNrcmVmcywgYXMgTUVNQkVSUyBpcyBhY3R1YWxseSBNRU1CRVJTLi4uIG9uIGFs
bCBzdWNoIG1hY3Jvcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdXJvIENhcnZhbGhvIENoZWhh
YiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICB0b29scy9saWIvcHl0aG9u
L2tkb2MveGZvcm1zX2xpc3RzLnB5IHwgMTQgKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3Rvb2xzL2xpYi9weXRob24va2RvYy94Zm9ybXNfbGlzdHMucHkNCj4gYi90b29scy9saWIvcHl0
aG9uL2tkb2MveGZvcm1zX2xpc3RzLnB5DQo+IGluZGV4IDk4NjMyYzUwYTE0Ni4uMjA1NjU3Mjg1
MmZkIDEwMDY0NA0KPiAtLS0gYS90b29scy9saWIvcHl0aG9uL2tkb2MveGZvcm1zX2xpc3RzLnB5
DQo+ICsrKyBiL3Rvb2xzL2xpYi9weXRob24va2RvYy94Zm9ybXNfbGlzdHMucHkNCj4gQEAgLTYx
LDEwICs2MSwxNiBAQCBjbGFzcyBDVHJhbnNmb3JtczoNCj4gICAgICAgICAgKENNYXRjaChyIl9f
YWNxdWlyZXNfc2hhcmVkIiksICIiKSwNCj4gICAgICAgICAgKENNYXRjaChyIl9fcmVsZWFzZXNf
c2hhcmVkIiksICIiKSwNCj4gDQo+IC0gICAgICAgIChDTWF0Y2goJ3N0cnVjdF9ncm91cCcpLCBy
J1wyJyksDQo+IC0gICAgICAgIChDTWF0Y2goJ3N0cnVjdF9ncm91cF9hdHRyJyksIHInXDMnKSwN
Cj4gLSAgICAgICAgKENNYXRjaCgnc3RydWN0X2dyb3VwX3RhZ2dlZCcpLCByJ3N0cnVjdCBcMSBc
MjsgXDMnKSwNCj4gLSAgICAgICAgKENNYXRjaCgnX19zdHJ1Y3RfZ3JvdXAnKSwgcidcNCcpLA0K
PiArICAgICAgICAjDQo+ICsgICAgICAgICMgTWFjcm8gX19zdHJ1Y3RfZ3JvdXAoKSBjcmVhdGVz
IGFuIHVuaW9uIHdpdGggYW4gYW5vbnltb3VzDQo+ICsgICAgICAgICMgYW5kIGEgbm9uLWFub255
bW91cyBzdHJ1Y3QsIGRlcGVuZGluZyBvbiB0aGUgcGFyYW1ldGVycy4gV2UNCj4gb25seQ0KPiAr
ICAgICAgICAjIG5lZWQgb25lIG9mIHRob3NlIGF0IGtlcm5lbC1kb2MsIGFzIHdlIHdvbid0IGJl
IGRvY3VtZW50aW5nDQo+IHRoZSBzYW1lDQo+ICsgICAgICAgICMgbWVtYmVycyB0d2ljZS4NCj4g
KyAgICAgICAgIw0KPiArICAgICAgICAoQ01hdGNoKCdzdHJ1Y3RfZ3JvdXAnKSwgcidzdHJ1Y3Qg
eyBcMisgfTsnKSwNCj4gKyAgICAgICAgKENNYXRjaCgnc3RydWN0X2dyb3VwX2F0dHInKSwgcidz
dHJ1Y3QgeyBcMysgfTsnKSwNCj4gKyAgICAgICAgKENNYXRjaCgnc3RydWN0X2dyb3VwX3RhZ2dl
ZCcpLCByJ3N0cnVjdCB7IFwzKyB9OycpLA0KPiArICAgICAgICAoQ01hdGNoKCdfX3N0cnVjdF9n
cm91cCcpLCByJ3N0cnVjdCB7IFw0KyB9OycpLA0KPiANCj4gICAgICBdDQo+IA0KPiAtLQ0KPiAy
LjUyLjANCg0K
