Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22436AB50;
	Wed, 18 Mar 2026 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820079; cv=fail; b=OqJFcweKib5+/ltly8VSQD07tzWQvgPWlprswreHec3DmrSFpnqJQdkz5FpB1wYdl/vvN70e9ldZ9jwBBYLCn0D00MwsPZGXwwQFvItgVQ2VSdGgqaraOXmDEZxmfThpRqv4uztHhhce3dGJjgG9gkC7kV6n/pytxa1uS54ybJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820079; c=relaxed/simple;
	bh=pHosy1FhOlj43Xdiz8309AE163bDXsfMBHh6IO1QNyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CEwLDjgmmUNqjk3sNz2h1pszLRa7AIYxwbNzj26Du/8gOaGVxz9GBJbWzIa3Vqd2AX6NqEY6xpU2SM3s6uvZ7qTJ0OXPrBipj7lpAcsl4OQMgpkuP1xe6LI1TspGO4X8zFUELFaVQ1HdulTVlhNW9Z7NcmF0p3zvrtwrtLVAFYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avPD3FNk; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avPD3FNk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773820078; x=1805356078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pHosy1FhOlj43Xdiz8309AE163bDXsfMBHh6IO1QNyI=;
  b=avPD3FNkHq09cI4zAHiAR9k6CeM8naUr5veSN9VnLmRwCcg/WYS6QbsF
   y7d40aGfbmC23o1Qr6LX3xjerGWq0Kn3uyrtiOP8Ch5vWRTCQ2iBfJVIR
   i/HeidW1V9sxqKkVamD+GiDuikMpSyXL13pNMX/rBNn3fC0vh5TbgUiQB
   G5j3azGW9mPq3EfNSqVwVeQf2YNqO59neBMrFCWJkD5ikl0KXdnNuudRf
   tCevX1cbnaw+z+d4pGEFzZvMYLLKrvsrujlQB4shK6AQj3spwbVxVOjIR
   uTj7aPN28SWuuLOSZRN/EJ1huY9q9E1yMYrG6feCq6oLKlqAyUT6NehZT
   A==;
X-CSE-ConnectionGUID: fX+qV8rPRduXzmSsSawZSA==
X-CSE-MsgGUID: AQVtgH33SBuQvYwkiWaadA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85945566"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85945566"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:47:58 -0700
X-CSE-ConnectionGUID: y/jong3pT+G1e7XnKp3q6A==
X-CSE-MsgGUID: JKtNMBxaRHKrrt2kboAetQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226677410"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:47:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:47:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:47:56 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYMm5fkHH6WF2kF7jXNk10emyZFvNvgZ2cehu7DiMZ/leLbTewQwZN0yInQQrHBDENDi9RsFSrIYCpQVbZi8f88F5PcUUXKX0rni5aMg7cgvEPzVJBzaLdKcZBE3Hspib87+fZa0LcsGgbDjqgJv/7IwV+VKGQzH5HW8DWgaDtKEVz9qXp4F6j3SJAy2GFec1D7q+6LYOXp5aWnQmxq9SmleTJ1Wd6mneVpsTJiK1Fg4caC6u9HxKVcF018urwF8UHakjLKghHeFPWW3O8FChXxFx1iOWKVv6PyEtpAurxY8pIDnbV0KKQlNxcncIb8LKqACdaQFlsqXpHNyEjTo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHosy1FhOlj43Xdiz8309AE163bDXsfMBHh6IO1QNyI=;
 b=lPnuA6L/8ql9OLj9dxsto5ip15PgBYt/NF0rb4tnjeeP7g/TZlTzUZ2Y2GPFlgK/aO3L+7aOWH7BsrBakMv/It1tE/WwEn/W4hUXehBk1il2G7l81nyej7oPEHNqGZjASHoGYwS8z04YHW7mbRMCpwy8j/aVMoudKFgmsY0LYcgY9eFh8i+TvtQp2SyFCFuKKc7sSvgcC3XTapjJ33Kmy48okRwrHlPlgyGAqp4TDq2P6sKujtiWVU3/iKL+q4kcSWuQBasuxupO4tR25hXp+dMvZIU862JO7O0s47SoMKoB332dAjDWDxR9q/yePpjeUhm+C0+chxXhD6/ivOIIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6191.namprd11.prod.outlook.com (2603:10b6:8:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:47:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 07:47:53 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: RE: [PATCH v3 03/22] docs: kdoc: don't add broken comments inside
 prototypes
Thread-Topic: [PATCH v3 03/22] docs: kdoc: don't add broken comments inside
 prototypes
Thread-Index: AQHctjlIj/R0RaOkhEe9jA1DKF+cALWz6otA
Date: Wed, 18 Mar 2026 07:47:53 +0000
Message-ID: <IA3PR11MB8986002DA5CE8551A20E1BEAE54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
 <12ac4a97e2bd5a19d6537122c10098690c38d2c7.1773770483.git.mchehab+huawei@kernel.org>
In-Reply-To: <12ac4a97e2bd5a19d6537122c10098690c38d2c7.1773770483.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6191:EE_
x-ms-office365-filtering-correlation-id: ec2e9e43-f866-4c6b-bf15-08de84c2a99b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 6WqmDXWMChvxHI4+Tu01e98htwXg+tRFkGFr0MsK05zn6Y8NRza1f7P8ITSKJNK+2iZr3xDzRf9b4bxUP1GSV7uC5KwrJ+2QUk7nFvHyoQGv/CPu5gUtnB1LzBpJgUprGxTa3kaWdtb0p+WZfKg4afaLsN6VsKXGp/ws96t18v2fuNnXWqoxtdsYm/HatWiceR3usrdnFcDOyz9pLEqo27XQaarGHBmKPsu36xGln5FGTQwr8NeGu35AtAbg279PczW4b1YzHhKb1a08tg3/eqD0suXwWT+bd23y+CFE70CizR+iC+fcm+BjxPIdx1gbO71sgpixFCrmRcsdy1x8NdbUlAw0J8DHTR+nSYGzfljI49zwhpTcqEhWOnSHCIlRnEgdGCRlO29wHJIc4Vh0QALHf6eNfJHHXwa6uhKVWwmXlFCQ8MPVFJAYCdr7kwFEO7kYBWIDYc2xUTbT1qLKvDf/r9XYcc6Y9kDH0bWkjJtUORALY2kgScdykvJK3Lq/l0CF/6L6bNbqNERpwImVBdKte5Fl6TsgNPKfLkm0kJ1CP6D5R7jB3z0qrB/gX8fwV2Hg0khTo6jR73IHe1dOPSfPk6a3jGB1rJnZNzFGfJCKXpHouZvcASyorRt/vJQRT2SIFvqTPqNWkb2hJvzyLPDoARoHUxQWXUpKLLpeWVaucUDzYtiifii3Xv6KO3oHfuRBvbQHd4aQ22BJgStKBwNgildo79aUyWXberHP54zZbDOYCQX6iaG3BA1+z4+6KaSOs4revvs7AOc/8FLUIPIc1wDOWxHtyM0tImYUgjY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVlMOCtGdW03QWtVU0VxSlh4QkRkbGJQME0zUUhLd05yemFQOCt2U2Z0R0Nx?=
 =?utf-8?B?OVg0ZjRmdU1nZlQyZWRlR0ZxTzVyWTNpam9ySllnSk1CTi9pc2lsU2FMbHBJ?=
 =?utf-8?B?VFljYzdlcDFOY1U5dkErSVJEdUJNUEVWWkJULzdIeHNIdzdpdjgvWFVhd21s?=
 =?utf-8?B?WmFUbVdJcjNCSzczeVEzZHl0UlUyak1ES3dzN1NzOVBMVThwWkNNT0RMdTNr?=
 =?utf-8?B?VEErbFR5dm9vQzc0dkF4L1BDazJ0d21UQ2dRTTd0M09NaTNraUdNejFWUUdS?=
 =?utf-8?B?ZCs2QlIySi9jNkhqMUM0aUdSNHltdEp2eVBwYWJHSWh3NXJzNmVpUHVoRUFM?=
 =?utf-8?B?M1VUMlIxZzNBUWdtSFhxRldJN3FlUlBRT0hIa1Y0Z0FGT3dqVm5BVGY1ZFph?=
 =?utf-8?B?Rjc0dkdZZTlXd0FoeU1Rc01pdDJTQzFpZXB0alUzWFZHWDlDM0dSMCs5MCtl?=
 =?utf-8?B?NnVlOTdxbjVqYzZ0bERLbkxwV0UwdTFlTDFGUEQ1KzBuaXhlaEl4dVBmY21M?=
 =?utf-8?B?VDFWNzAzcjFXNldzbThVZEFjdVNvZHVaT3RESEVYbXhWcVg5dEJjZmpZT2Va?=
 =?utf-8?B?cXhIZnY0S1h3WCtvN3lFdGtDelpGd0hLZGdqOVV5NUZYUnF5VUN1ZUs2azg3?=
 =?utf-8?B?WW52R2ttL3luTVJSV3Y5UEVWQVMxdHc5VWdtWXZDWUVCZzArRWxwZldtVU4w?=
 =?utf-8?B?R0VYYVo4dFJJM2ZNR2ZmSFhhRDdjSFYrVWxVNkUrTHpCcjR2ZHRGOFRJdmUy?=
 =?utf-8?B?L0pLMEI1UmpXNXEzeHA0bmYvaG0yY2tOcHBORnR0dkxJUmp5TlRCOUtGMnBU?=
 =?utf-8?B?UkpCWFlwMDNSNU5uVnB6eWlxY1U0cmRNRXErdmRQRzRNUFZDLy9lcno1REdI?=
 =?utf-8?B?VmNpY3NsOXQxQjJRUFhxSUtUaVlLVWgyT1dKUUNVemdGWktRTmNNREM2dWlN?=
 =?utf-8?B?ZjFOK2lHa3Jnc2N2U1JnNmR2dURrR3NGMEUyRmxMYWZGaW9pTTZUbUovSkJw?=
 =?utf-8?B?WWxnV2xNSEtkZHZyYXFSUDBYbUZZNzhlVldRRG1LZXNNUFV2Smd2amQwSm1N?=
 =?utf-8?B?RkNPQjF0eWtJY1BFa3g5T3FwZkZGSGRnaG5xRUd0M0F3VElsWVhCTjgvTm51?=
 =?utf-8?B?dkJPS29PZ1Vab0UrR2tiTTZ4T0g3RERQNy9FVG4ybENVSTlQWGpNcWc1TG1s?=
 =?utf-8?B?SWxVQ3haL0lvdUFlaUpQRmJTcTVuZ3V6R0F0WUtKcTVRaDlLSWtnNy9CMUM2?=
 =?utf-8?B?a2lnR3hzRzdnMFRIaFJmeENWazRQV0FRZlh1UU4rZmF4VU1oRmRtZHQ5di9U?=
 =?utf-8?B?VjlxU0d0ZEd1bk1kR05YSE5ORjViR2p0RWd4UW0rRWlNNlhsRjVCS1VlWXgw?=
 =?utf-8?B?M1MxRFMrb3BrSi9seTVacWZqMjlVR0tvN2tZMWc1NlJpclFlakdGakFleFlj?=
 =?utf-8?B?d1JRL1VNTGRDY0JvdWp2bnFRUm5FRnlXTVkyRWl4Q050VUYrRHBmZjc5bTNZ?=
 =?utf-8?B?U2VqMkFGMlpZZVNFUmt2OXc3WG9DWmxIZnAzWVJaMWFNRzZjS0xNNml2aHp5?=
 =?utf-8?B?ZEJqaG1STXpMQzBRaWtZWE5lZVZMYjQ3NEIxQmFXTlc5RWhXVFo2NUpMUllQ?=
 =?utf-8?B?RU1VRjM3RzlQYkFaa2czL2JlTW92WFZDcXpRQWVjSnJEamxldXB0d2JFVlVa?=
 =?utf-8?B?NjR0ZnRDNTg1bml0b2wxcUt0NldLUlpFWGRoaXBacW5nU0l0QjdmQ2VraHVV?=
 =?utf-8?B?cVJlUk5DTUswUTV3Q3pRQTNEV0RwaVNLWFF3c09JNUE1bDFRd1BROEFoU3BV?=
 =?utf-8?B?S1pTRDNGTmJjSjVPMUpPTTVOYzFLcWhMaGF2RjBjQURPc0NGT1NKcDRaUWJM?=
 =?utf-8?B?Vk1YRit2ZXovdks1ZlArbGNwajdqRmFST0RCQlpGL0tHZDU0NkJTeEN4TEpY?=
 =?utf-8?B?Wlp4Mmd1Z1Blc2JHK1h0VEVWdUNMN1FFTi9sK2VjWnkvcExva2pXcHJ2VXBh?=
 =?utf-8?B?bmhObmpWYnMvaDFxYlR3eWhscmppMitrdlJQSEdLUWJKcnlQRFFXd1lTUmhN?=
 =?utf-8?B?N0lsZ0NnSldwVHZ4NHNUMXhDb2p2RUdySENiYm81MmNwcCtUSWVTSmd1c2Rw?=
 =?utf-8?B?cWZwMllIWGFwUmJFQmtSSmk2TVhNcjViakZqdnE5Q0FFNllvMkhKZWNzWkxB?=
 =?utf-8?B?U1pSZ1ZxTzYrUXpnYnUyUG1TVUs0eCtBSlkrOVUxUzZLMWJKdU9JeW4xRFI2?=
 =?utf-8?B?cWE1NENMTzBDMWhWNW9KN1h4VytOc0tHeHd0dEdiL2dGZStERVMyOEpDQVI0?=
 =?utf-8?B?T2QxU3ZWaTcyaGxKMWdiWXRsWHJCTy9SQWwrZGlSdXhTTUpBNFN1cUd3WENx?=
 =?utf-8?Q?FSHAfPtVhcnA+44Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eB0DW+ctaRJke1e7pc2k2L/MUMhQeHMDebhzpWo3JPaBir6VA7vGoeeuB+qTKHGER4M5gF1yvY7nscUjxQzuI3JK8jsEFP34Md3ggD8BFUy2So3GEp4mEuzngStp0DNv+orIfmBIKBBEiL2rpmYPRv3y5FAfFugyzdRsDAakumdpgmwgZWyae9kSWFXGTnaiXZwjLWiuGSWCL4/N7sv6yYy9vkEME3b7ksEmtZbBaJqBY+7vcjkwWBLmlyP7GZ3D3t6fBQzqL8OdDj1zadRDL/Q4UwDSsLy0K3pCuNOV4rPIwSGuAvkGJVlX6TWtfMNBOaxPWabLQpy2jBnZ8kZw7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2e9e43-f866-4c6b-bf15-08de84c2a99b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:47:53.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYP/KYeMQA7Y1JiJS08A3QylzYHgrHdgO0V+HZJE/IKwH3F4BBZ+jiAmqui1HeHIBs0TBVh3b9Z5SMjm8pC11hH/IMdawZK0CrjS060W1HM=
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
YmplY3Q6IFtQQVRDSCB2MyAwMy8yMl0gZG9jczoga2RvYzogZG9uJ3QgYWRkIGJyb2tlbiBjb21t
ZW50cyBpbnNpZGUNCj4gcHJvdG90eXBlcw0KPiANCj4gUGFyc2luZyBhIGZpbGUgbGlrZSBkcml2
ZXJzL3Njc2kvaXNjaS9ob3N0LmgsIHdoaWNoIGNvbnRhaW5zIGJyb2tlbg0KPiBrZXJuZWwtZG9j
IG1hcmt1cHMgbWFrZXMgaXQgY3JlYXRlIGEgcHJvdG90eXBlIHRoYXQgY29udGFpbnMgdW5tYXRj
aGVkDQo+IGVuZCBjb21tZW50cy4NCj4gDQo+IFRoYXQgY2F1c2VzLCBmb3IgaW5zdGFuY2UsIHN0
cnVjdCBzY2lfcG93ZXJfY29udHJvbCB0byBiZSBzaG93biB0aGlzDQo+IHRoaXMgcHJvdG90eXBl
Og0KPiANCj4gICAgIHN0cnVjdCBzY2lfcG93ZXJfY29udHJvbCB7DQo+ICAgICAgICAgKiBpdCBp
cyBub3QuICovIGJvb2wgdGltZXJfc3RhcnRlZDsNCj4gICAgICAgICAqLyBzdHJ1Y3Qgc2NpX3Rp
bWVyIHRpbWVyOw0KPiAgICAgICAgICogcmVxdWVzdGVycyBmaWVsZC4gKi8gdTggcGh5c193YWl0
aW5nOw0KPiAgICAgICAgICovIHU4IHBoeXNfZ3JhbnRlZF9wb3dlcjsNCj4gICAgICAgICAqIG1h
cHBlZCBpbnRvIHJlcXVlc3RlcnMgdmlhIHN0cnVjdCBzY2lfcGh5LnBoeV9pbmRleCAqLw0KPiBz
dHJ1Y3QgaXNjaV9waHkgKnJlcXVlc3RlcnNbU0NJX01BWF9QSFlTXTsNCj4gICAgIH07DQo+IA0K
PiBhcyBjb21tZW50cyB3b24ndCBzdGFydCB3aXRoICIvKiIgYW55bW9yZS4NCj4gDQo+IEZpeCB0
aGUgbG9naWMgdG8gZGV0ZWN0IHN1Y2ggY2FzZXMsIGFuZCBrZWVwIGFkZGluZyB0aGUgY29tbWVu
dHMNCj4gaW5zaWRlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF1cm8gQ2FydmFsaG8gQ2hl
aGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPg0KPiBNZXNzYWdlLUlEOg0KPiA8MThlNTc3
ZGJiZDUzOGRjYzIyOTQ1ZmYxMzlmZTM2MzgzNDRlMTRmMC4xNzczMDc0MTY2LmdpdC5tY2hlaGFi
K2h1YXdlDQo+IGlAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICB0b29scy9saWIvcHl0aG9uL2tkb2Mv
a2RvY19wYXJzZXIucHkgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3BhcnNl
ci5weQ0KPiBiL3Rvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3BhcnNlci5weQ0KPiBpbmRleCBl
ZGY3MGJhMTM5YTUuLjA4NjU3OWQwMGI1YyAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbGliL3B5dGhv
bi9rZG9jL2tkb2NfcGFyc2VyLnB5DQo+ICsrKyBiL3Rvb2xzL2xpYi9weXRob24va2RvYy9rZG9j
X3BhcnNlci5weQ0KPiBAQCAtMTM1NSw2ICsxMzU1LDEyIEBAIGNsYXNzIEtlcm5lbERvYzoNCj4g
ICAgICAgICAgZWxpZiBkb2NfY29udGVudC5zZWFyY2gobGluZSk6DQo+ICAgICAgICAgICAgICBz
ZWxmLmVtaXRfbXNnKGxuLCBmIkluY29ycmVjdCB1c2Ugb2Yga2VybmVsLWRvYyBmb3JtYXQ6DQo+
IHtsaW5lfSIpDQo+ICAgICAgICAgICAgICBzZWxmLnN0YXRlID0gc3RhdGUuUFJPVE8NCj4gKw0K
PiArICAgICAgICAgICAgIw0KPiArICAgICAgICAgICAgIyBEb24ndCBsZXQgaXQgYWRkIHBhcnRp
YWwgY29tbWVudHMgYXQgdGhlIGNvZGUsIGFzDQo+IGJyZWFrcyB0aGUNCj4gKyAgICAgICAgICAg
ICMgbG9naWMgbWVhbnQgdG8gcmVtb3ZlIGNvbW1lbnRzIGZyb20gcHJvdG90eXBlcy4NCj4gKyAg
ICAgICAgICAgICMNCj4gKyAgICAgICAgICAgIHNlbGYucHJvY2Vzc19wcm90b190eXBlKGxuLCAi
LyoqXG4iICsgbGluZSkNCj4gICAgICAgICAgIyBlbHNlIC4uLiA/Pw0KPiANCj4gICAgICBkZWYg
cHJvY2Vzc19pbmxpbmVfdGV4dChzZWxmLCBsbiwgbGluZSk6DQo+IC0tDQo+IDIuNTIuMA0KDQpS
ZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+DQo=
