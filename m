Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35CE29D267;
	Fri, 13 Mar 2026 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370607; cv=fail; b=iSplD/4vyMfPydn8zEn6+wVyezmralTn2yDGKFpHT+XWpxj8BfCSpwPETKirfx3hmMIftP12pIjRxBAdQ4T4vYe5vgHBY4oGk03O72btBFtjp/xzrDnG2tfVymtM+6wozm+9lYEqRDgDz6eFOy01XN+uaabWpLSDPIyF74tpeYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370607; c=relaxed/simple;
	bh=UjUVin/XMitsKNTmMbanR4tQtyaWNZ4LsIjRsUMOjN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C0PnAHjOBRu3zH6+CjE8KghbOeHKHjgLxhYte9HZY3wGWO/k7R4HD8fo5SmTzUIk196JwyffU8i1DGvcOmezCIqIQeC9XrJRDbApQ76PpqQk7mmDIEXBHLoxL7NhmHrjYo1yHllqnmQGqhzz1XEUhN17GXJ9PAbakklcf9q/VP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6FE2ql2; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6FE2ql2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773370606; x=1804906606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UjUVin/XMitsKNTmMbanR4tQtyaWNZ4LsIjRsUMOjN4=;
  b=i6FE2ql2LjZRz3i+QE7YD3HQ2If3QFcIjs0f1PFQGIqH7GgQyCHnXGPv
   OVYwWzuthLRER/ym+MowJpH6sbAv9ZuKcsq+K/UwEeLyYz/MKbLwGz+QJ
   6fVzLimM2V2QOQw+vJJ5YDPgnROvjV1uHx+oG8PfjV4w/5pqWpr6oPgbb
   d0DvZduHoa440Aeb07gs1d2BT/+nO+5hxWKG1SDHwmIJpNxYdg9fz34W/
   zkWIdu5H+MdyVEl6kVd6kXX4jj4jjUYHAbKGf6vUnjCrYpBZ47K6suf4/
   sU5wpg3ZkaNbWC5Jtq127DuL2p05IuGif0u+M1bUh4Fa5BtMidPRlbtus
   w==;
X-CSE-ConnectionGUID: 8ghX/BuRS2avymIFpN/gyQ==
X-CSE-MsgGUID: ikNncrZuQZWM0KW/QQ2dWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="73662075"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="73662075"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 19:56:45 -0700
X-CSE-ConnectionGUID: /7E47JDgTbO6KM28tI4qVg==
X-CSE-MsgGUID: JYnjzZ+wQwCI5fDXqGA0mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="217493234"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 19:56:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 19:56:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 19:56:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 19:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZbi0z2wyMYWq8kCa5/MNy2qfzFANN96F3WuSGCKkIGxhNcIjRpS4gcbUBUrppIDVNMWblk0/Yk2yOmCgO+WNFnuS+PB+ErKCjqxushLTURv+VlvvjGSXitPi0kXyMHOi0DjPXsVOqNncitzRJPnmjjatSOvNre9DtmsocFesc7LOczR/xIsI6O/CgAIIvJcsLM8qnL8HlM3EX+ZquTxRI9PZnFGcnzhrf3ie2lF+n3fQlUxQCclijguUUMcZ+Lct+uP2Jb4T6O6Z1yYy1dHyRIHoIv8k9GmDmX/2XccqmDA7XxR8LyYqIpbpbPxhgbRGoBJG0RzwWlnFBL8DxEjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjUVin/XMitsKNTmMbanR4tQtyaWNZ4LsIjRsUMOjN4=;
 b=WDR+gn5jtDSrGTLT7Lo8PR2BlZZYrYPyOlLsgkZBE6P3Sk5MI6koCja4KZea4aFv64Rf401V/ik0LIyYLnLB+07V+8+0s2wJIqkbrHe29XsiLOzfQNK1MBdcUr9xpZbDelnf4AdIHWG8AH0dTWkLLucep4jOfbk3k4m0X6cchDeF6z5ujSYP500j0yju/qz63W7kl+WDUj2TBXq/mWTH1muJBpdcR+fRBZqwDpXdJBC36BJvkNL8/nU+74s3NGECWNRFPkUcCywhwbTLrNRj6TOvhLdLSDG3YeNtIps96QAsORW8D1GQtXccc6AVmnsXqfj9v9r3vEU2X0OJglj4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 02:56:42 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 02:56:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, Rosen Penev <rosenp@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, Borislav Petkov
	<bp@alien8.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:KERNEL HARDENING (not covered by other
 areas):Keyword:\\b__counted_by(_le|_be)?\\b"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] EDAC: sb_edac: use kzalloc_flex
Thread-Topic: [PATCH] EDAC: sb_edac: use kzalloc_flex
Thread-Index: AQHcsa6D4/38LH2sGkiaK5cIq1nXIbWp/RkAgAAG+4CAAR5rgIAAn/FQ
Date: Fri, 13 Mar 2026 02:56:41 +0000
Message-ID: <CY8PR11MB71343B4A3076F080E24F35798945A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20260311232545.18492-1-rosenp@gmail.com>
 <SJ1PR11MB6083C3A677F5C906222794A6FC47A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAKxU2N8zSkzJMp85hgRN453x8bcPDvN_3tXmp-sNfueZOAuHfw@mail.gmail.com>
 <SJ1PR11MB6083385736D708F551CEC85DFC44A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083385736D708F551CEC85DFC44A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH3PR11MB7914:EE_
x-ms-office365-filtering-correlation-id: a5209e91-0d4e-47d1-67cf-08de80ac279a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 69hJU325a2XcefpxnDsWLD/hUMmrhLBsJOHRpn44yi02u6ficJMc2EJ7EUldwbHqJgSAcQGicXjkjp4g27qOZqHZOiBp/WTu7mWeoIL/KcSmL5xToCyTxkb4d/x0JP8SNpSj+s4jVaASjuh0AKTDWM7SBlpw2+9QFMLBfxWzBlh58iook74OV9+B1RxV+9v2m5hCVaKrUkhBTIHekiFp8ayLp5eBMiV6dyrRtIQs8mDkQbRZNy9ZeOAhhZp2B50CNjCI5BJCFkhfUbsiudWrGfrB2RPT/3imHsZhHvnAaRVsyeXPYT8IR4ioskg7pLgypOR5yLKOvaTPDHjeV0yOsoUfZHeJhkwEUMjATtnLMZVYkttwAVESrr1KT7RGVGr5SLoncMX76rsF2UxRemDk+vx5dozFpSM0HTDDQcMN1uvw6MpnfWOck39wep66p1z5jbywK4Iq4kLYtG0Dhx2/GeVGNH8kXTTKjmdA3nMlZxGj+JTvnMre914WV2s7KhoRRa13F2XNkeQQIEQgHnucS6n3gpdMClZ58+4knICECcN/uWj6+PrirY0kZ+lw+fpBNI8qj0LoA5L6m7Hh2wP2Xd2wbpw5APMV6ZGjaSCzy6sQU5+6JSSwiX6bFx+HhxneUPWlV2b8Mmxf/7VueKI+BAErGkpijoLxTL51tMaX540XipQVnghI2o3MWidPsMZO38aH61Lg0rHbtVIQVT1x+agKPoF6xg/2fUNGE9QrcQhoibTZgQYYjkLmlgFmIl9h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXoydWZYMkRrUHorL2dZbHErbXIwOEZWZUMxaWJSckdSRlYzVVJMaUhXc2dZ?=
 =?utf-8?B?T1ROdmFIb1dwc0w5UDEvQytGdEZPMkJJbjlBOUFJdGEremgyTHdMajEwNHRU?=
 =?utf-8?B?a21STTFRaE9uSmY1Y01qWW9MVDhnS1BiZ2toMVN2ZjRiZTJtbDZET3U1eE5L?=
 =?utf-8?B?VUhYTG8yeTBVQ3lCdXl2SVJuNnY1ZWhkMGZZMUNMOHpxUjI0cWQvRk9BakQ3?=
 =?utf-8?B?Um1qRjR0anJhWm1qc01SQkhvNTU3VDUzdE5lYXlId3hBRmloZHRmVWJLOFY4?=
 =?utf-8?B?bUR6bGdmMmRQRzhMdUxnT2Znem1MMlh1eUpweXpZSHBWWEZPUGlIcWhmWmtB?=
 =?utf-8?B?ZVJPRWxVL2FEbFRNY3JERnNCbEdhK1NWc1JFTms4cURIOXVmaWsrMU44bHdD?=
 =?utf-8?B?eisrcEJNUU9QVWlpNjNFMW05RCt1cmhrcTllaHNFRXFnVWNiK0ZCSTI2RExI?=
 =?utf-8?B?M2tlZllicUsyZ0gzUG1qek9NeGNTRmhHUjA4RFlSai9sNlByMDhFZFRSYzhJ?=
 =?utf-8?B?NmV6T20rU2RaWFhKdk9lYlB5QVlwbEpMRnZKQjJpZ3AxY0htNnZBRVBPSTQx?=
 =?utf-8?B?N3orYSszSEtXT05DZ3ZMNVQvMTFubU45cFBtcFBOYlEwbG1GNGFVcytqLzRI?=
 =?utf-8?B?UVpxN0h6V3VjaVBJdlROeDltYjNuSmNHSCtvSVlaYUFjVGFOcXgxUHpZcmRZ?=
 =?utf-8?B?MUdXTHhpSnBUV29RNGhwM3dMbjU3N0VDN3hidnpabldaQVFFM3doYzJvaWlT?=
 =?utf-8?B?WVRleThDUm1MZ1ZqVy9rZnNyMUl2YVhkNHFVMm1FOTdSc1VNeWtDaVRZYTQ5?=
 =?utf-8?B?Zlc1YUxlbUxwMzFmajNTK3ZYNGIxTkd1ell3RVJBNHpQVTFkaFZpSTNkMnRs?=
 =?utf-8?B?ZUZidlE4MVBJZWYxelBhM0F3a2hwWW1tTzc4WFArWlQzMUI1aTlzbWdrYjdH?=
 =?utf-8?B?eWt6alpta01HMW81N29SWGJxRWhDVnhCRVFUdDhyaWJybXJ3N2FYR0F0NzJN?=
 =?utf-8?B?QkFtM3hQMzVabVdKbjVRVGxiUlg4dzJuOXF2akY4RUMwRjZzN0F1T1RSSWJj?=
 =?utf-8?B?Z0I5b1VSME1GVFFEcEdKTzhUWTc2WW9kVkpBQy8xNmQrMGxPZk85VUgzQ0dL?=
 =?utf-8?B?Q05XZVcwbXRuWVI1cDJ4Uzk1a3o0dmRVV2hZbG0rYnV4VU9oSnpPUzBCbFdz?=
 =?utf-8?B?eFRZemY4UGFwMDk4U1V0cTFqWFdjc28vMnNnUHBwaTczdVlIVURzdjhjVHdY?=
 =?utf-8?B?ZUpFdi8rZUtQcng5QzdZTFBURjArMCt5a2VlWXpsMm1XU0lxUGhaT25sVmNn?=
 =?utf-8?B?UWhvMkNqRzVaNkhrSi9YU1BVZVRqN25pSW40VDJKWUFSNmFnRDBTM3FNOS9x?=
 =?utf-8?B?d0JUZW1ES2ZBUjl2dDg1SmRlM3JBTHhOVDNRYzFYbDA2Qm54dU5VL0M2Tnht?=
 =?utf-8?B?aXRQUXk0OHgxakFQM0dVQzN5U3BQVlk0ZEFGdThHemtuTHhDN215dFh1Yysw?=
 =?utf-8?B?TTVXUytrZSt1WENyYktHalVFM3dGL1FjcXRVR0gwN0pGKy8zVzJQaG94Tlht?=
 =?utf-8?B?dENlNmxBeHc2MGdodG1MamtEbGJ6Wm9UU2FZd3JUV1RmL1JDVlRsZzhYV0Mz?=
 =?utf-8?B?RHo1TDFPbWUvNTloOExRa1k5YmMxSENITUU2TjVmMjk2S2wrSm9NbytuWkh2?=
 =?utf-8?B?emI0Q3psa0kvVG9JWTBGaVl3Yk9xQXF3NWRBUnpKRTduYmU4RWxaK3U3cFFI?=
 =?utf-8?B?VmF1M3RPb05tVFZ2UGFvU3N2VC9ReEpGendoeWl6L0hQUkdBYlZsOGlYc1BL?=
 =?utf-8?B?VjBqQ3huQTVUYVM2T29nVjVtSGVaTXU5b0J3KytjaXkyenZXclpaUkRhN3U3?=
 =?utf-8?B?SE9zRElqdFdmVXB2NlNSN3FZNlhGbEZDcTc2djk1RkF3Z244RHA3cmlPVHQ4?=
 =?utf-8?B?YWROS0w0dnNodUh6VjdFSGxueVVVMW9mQ1p0aGk1cVZOMEZoTHZIejZ2eE1B?=
 =?utf-8?B?UlBpTEJyTVFSR042TFRJVnQwSHM3MVlCY2JzeVF6UXhYZ2V3cEh3UjdGc05i?=
 =?utf-8?B?UGx0TlZzc1FOUDRaZnMyNDBOWUVUa1d6clRHbDJ0OU1kODlCVkVRampISVp2?=
 =?utf-8?B?aWhhZGJuUFBtNERYMDRVNHpPbUsya2xYUnc2YWRxY2I2NDA3VjNjN1JtNEpa?=
 =?utf-8?B?Q3p1ZVhYcnJhSDkrcnFzN3FNQ2VhWnBCUWppTkl6U3RNQzR5eEZnVHJMMWFV?=
 =?utf-8?B?czlza1hMN3FUemMwcHB6WHJHM0VIRjJXLytTZUFldHMrZnRkWnMzdXl2UGVp?=
 =?utf-8?B?MHRtMWZvM2txWmxJQjIwMmFiSUV0aGxVR29YbWN5d3pEN285OEJIUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rkqi+7N+mW3g0JuE9hna7hIR/vh1whYyHK8tXT7AkZEV7ARbGH4NeFOCHRkNoc6wHzVZB2NIMBjE2dw02B0VQlTmYjerTQfCvfPS3IBnTmxztSj4JnuLDGzwvDMe72MPNUa+m26FuvmPFCgmKAzp7db691myL3U4oHO8qYtwcf+AqlClNyQnMQ4arnI3oNM0BOq0oo8UTNy2P4jF/gqtcKp9OMtdpgHxjJTU29WYGN0XIY5T9+NUeYyBzhMwUXM2fMHV2M3m6WJjqlymrUxK0VGeu+dO83djMWoUldOdotpIRrrwEiT6qU2AefolOqps5QV97A2D4Ba8768ENOeRMA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5209e91-0d4e-47d1-67cf-08de80ac279a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 02:56:42.0063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Exgm8pQdUwiO3eNsiY/xR4WXR7xNp9GvbBchhHdZYIeICcLLkT762JVgJkNHwu/hAYcGM0SDSJmb8b4yyX14gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com

PiBGcm9tOiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBbLi4uXQ0KPiBTdWJq
ZWN0OiBSRTogW1BBVENIXSBFREFDOiBzYl9lZGFjOiB1c2Uga3phbGxvY19mbGV4DQo+IA0KPiA+
ID4gKyAgICAgICBzYnJpZGdlX2Rldi0+bl9kZXZzID0gdGFibGUtPm5fZGV2c19wZXJfaW1jOw0K
PiA+ID4NCj4gPiA+IERvIHlvdSBuZWVkIHRoaXM/IEkgdGhvdWdodCB0aGF0IGt6YWxsb2NfZmxl
eCgpIGZpbGxlZCBpbiB0aGUgX19jb3VudGVkX2J5DQo+IGZpZWxkIG9mIHRoZSBzdHJ1Y3R1cmUg
Zm9yIHlvdS4NCj4gPiBremFsbG9jX2ZsZXggaXMganVzdCBhIG1hY3JvIG92ZXIga3phbGxvYyhz
dHJ1Y3Rfc2l6ZSgpKS4gSXQgZG9lcyBub3QNCj4gPiBkbyBhdXRvbWF0aWMgX19jb3VudGVkX2J5
LCB3aGljaCBtYWtlcyBubyBzZW5zZS4NCj4gDQo+IEl0IGlzIGEgZmFuY3kgbWFjcm8uIEJ1dCBt
YXkgYmUgY29tcGxpZXIgdmVyc2lvbiBkZXBlbmRlbnQgd2hldGhlciB0aGUNCj4gY291bnQgaXMg
ZmlsbGVkIGluLg0KDQpZZXMsICIgX19idWlsdGluX2NvdW50ZWRfYnlfcmVmIiBuZWVkcyBnY2Mg
Pj0gMTUuIFNlZSBjb21tZW50cyBbMV0uDQpNeSBnY2MgaXMgdjEzLjMgb24gVWJ1bnR1IDI0LjA0
LCBhbmQgSSB2ZXJpZmllZCB0aGF0ICJzYnJpZGdlX2Rldi0+bl9kZXZzIiB3YXMgTk9UIGZpbGxl
ZCBpbiBhdXRvbWF0aWNhbGx5IFsyXS4NCg0KRm9yIHNhZmV0eSwgd2Ugc3RpbGwgbmVlZCB0byBm
aWxsIGluIHRoZSBjb3VudCBmaWVsZCBleHBsaWNpdGx5LiANCg0KWzFdIGh0dHBzOi8vd2ViLmdp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
dHJlZS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmgjbjU1MA0KDQpbMl0gLS0tIGEvZHJp
dmVycy9lZGFjL3NiX2VkYWMuYw0KKysrIGIvZHJpdmVycy9lZGFjL3NiX2VkYWMuYw0KQEAgLTc3
OCw3ICs3NzgsOCBAQCBzdGF0aWMgc3RydWN0IHNicmlkZ2VfZGV2ICphbGxvY19zYnJpZGdlX2Rl
dihpbnQgc2VnLCB1OCBidXMsIGVudW0gZG9tYWluIGRvbSwNCiAgICAgICAgc2JyaWRnZV9kZXYt
PnNlZyA9IHNlZzsNCiAgICAgICAgc2JyaWRnZV9kZXYtPmJ1cyA9IGJ1czsNCiAgICAgICAgc2Jy
aWRnZV9kZXYtPmRvbSA9IGRvbTsNCi0gICAgICAgc2JyaWRnZV9kZXYtPm5fZGV2cyA9IHRhYmxl
LT5uX2RldnNfcGVyX2ltYzsNCisgICAgICAgLy9zYnJpZGdlX2Rldi0+bl9kZXZzID0gdGFibGUt
Pm5fZGV2c19wZXJfaW1jOw0KKyAgICAgICBwcl9pbmZvKCJzYnJpZGdlX2Rldi0+bl9kZXZzID0g
JWQsIHRhYmxlLT5uX2RldnNfcGVyX2ltYyA9ICVkXG4iLCBzYnJpZGdlX2Rldi0+bl9kZXZzLCB0
YWJsZS0+bl9kZXZzX3Blcl9pbWMpOw0KDQpUZXN0aW5nIHJlc3VsdCBsb2c6DQoNClsgMTY0MC4w
NzI0NjBdIEVEQUMgREVCVUc6IHNicmlkZ2VfaW5pdDoNClsgMTY0MC4wNzI0NzRdIEVEQUMgc2Jy
aWRnZTogU2Vla2luZyBmb3I6IFBDSSBJRCA4MDg2OjNjYTANClsgMTY0MC4wNzI1MDVdIHNicmlk
Z2VfZGV2LT5uX2RldnMgPSAwLCB0YWJsZS0+bl9kZXZzX3Blcl9pbWMgPSAxMSAgICAgPC0tLS0t
LS0tLS0tLS0tLS0tLQ0KWyAxNjQwLjA3MjUxMV0gRURBQyBERUJVRzogc2JyaWRnZV9nZXRfb25l
ZGV2aWNlOiBEZXRlY3RlZCA4MDg2OjNjYTANClsgMTY0MC4wNzI1MTVdIEVEQUMgc2JyaWRnZTog
U2Vla2luZyBmb3I6IFBDSSBJRCA4MDg2OjNjYTANClsgMTY0MC4wNzI1MzBdIHNicmlkZ2VfZGV2
LT5uX2RldnMgPSAwLCB0YWJsZS0+bl9kZXZzX3Blcl9pbWMgPSAxMSAgICAgPC0tLS0tLS0tLS0t
LS0tLS0tLQ0KLi4uDQpGYWlsZWQgdG8gbG9hZCB0aGUgc2JfZWRhYyBkcml2ZXIuDQoNCg0KDQo=
