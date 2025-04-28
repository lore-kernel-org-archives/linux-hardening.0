Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66F39ACC;
	Mon, 28 Apr 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837055; cv=fail; b=q94oCQ/lKEpso1R/fkfG5F6WuE9OznEPbRKYo+eqWOTCkFA3z9h21My4s83XPX+lKzlRcqWxEyRz3FWnmDuwy6jKqeNZ8N1ll+HAjT6353l3ZSaU51x+DemWyNLPIMXVTvl8MHzvs10IVNnP6QTzb8tvnBrH9KA+jdPLB/rdYcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837055; c=relaxed/simple;
	bh=NQYTEDcuYGeQfT1N12S2VfNcDyM+DWQ4p2kJfjl4wVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mywlDbSuAPTlzTsj228suMD6J6BC0FK7ef0wHWuhN0Arzfg1hXJqlXLTrRGhPC9Z8Ok1dahSSip1X4JPM+qxRk1i8fuBWw+NX/7pAXzi90w+vuc9U8zyZe9W7GU7QQQFOVWfQFb+xdALxZ0Z93YIVh3LoHhdNFmItUUZWbL7D/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRnRFiX6; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRnRFiX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745837054; x=1777373054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NQYTEDcuYGeQfT1N12S2VfNcDyM+DWQ4p2kJfjl4wVQ=;
  b=cRnRFiX6JX0HkTyeCarWRbmhmwqcxAgBh6Vb9eNUJbPO+fhOqSznE/rw
   ZhDCRSx4IiKExvvEOU5jOL4L75SofoIVH0+jxcu/PixOebGxYhYUpbeki
   /wBpTHHYK183LHdThgjLKYpVWg2kaa6fhLDI0SilFqAC7qSOQX17BAGb8
   v4p7JT/CGFDbIM+vWEYyNsuiT2aiPedoEDCyfD5PoASLjZY27JpaRTW76
   5qsGlyHRiS9OsSfrFwe3gNnMVRNaS03DsFHjkYiwRqRYIXbeXCD/+3egz
   IKEoxUDkNuVOHS4govheKf3RprCI9Ng2T+X3VLWTJO0ViYFsCW53arRN2
   A==;
X-CSE-ConnectionGUID: +1yRCXsqR5yKmsUCUREq5A==
X-CSE-MsgGUID: zZ3An1e/RZinvaf1hQznug==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47552325"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="47552325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 03:44:14 -0700
X-CSE-ConnectionGUID: WCQoIm0YRuGxL172fCBPug==
X-CSE-MsgGUID: AUd2epkgTTaIdHrAuT/A5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="137537817"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 03:44:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 03:44:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 03:44:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 03:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hxtc0Hz2oj/B61TMLYf5ndvSRP745EBCrxcbtKL6KaIwhZo8w1IYqlmILYlSZHzFqbW0o/ebkgup4+MosPtw+486kI57IOdbrHenZbk+ohxVYVh4ykaWpwnoVEROBEv7x2D9soasb3jd4Wn4F+Ubux8VYgAqrv6+o5uPHv6Wz0d7ei7p3XSfuYSoybkOC87YVIO4N8BQGlN0BG1y6gqJmZk2xiBfTPYXFU5KsXGC5dWiFwmiMe+gyMskKjb8/gvmrNkF6jfOoNESsW65GTFgaRtmrSEdpc0CTl4In9xqweVHhcgdtVzzBn/byWAzb1UrrRe/BgJJh4wR6hqe1Kkn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQYTEDcuYGeQfT1N12S2VfNcDyM+DWQ4p2kJfjl4wVQ=;
 b=yK5CwH0ozZ4yjbDdJ+vGsTBYAp8c1SKAd/sNCX6OnEtuN2KpU4o4mzy+F6wuz16M8Qxi81QH+70Jjd2YHbOuOb2/PqOLKxh4Au19xXpp1hpb8TDB8qvMvD1WlMBxJKOm8VANwL/ydqgjSiXkkKiK2+hyXPe5WY/GWzS+GZrLSsW+SWOlhPn3ZStonlXjFtQTV+vlnqhQWkEVtRBs+i2HcRHqtzUk6estEn7j33LN9eGI7yxImek9iQ+RBMMg/5SxCZh7YAMOzqG8B77K/EXa5tMDh213fSRE+kf7uQbUO4BJ3Fmhvv+yx4G106Bj81vh3dIWO6s+TZYCfyvsEPx6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DS0PR11MB6327.namprd11.prod.outlook.com (2603:10b6:8:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 10:43:29 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:43:29 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Kees Cook <kees@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] mei: Cast the cb->ext_hdr allocation type
Thread-Topic: [PATCH] mei: Cast the cb->ext_hdr allocation type
Thread-Index: AQHbtnML8ZVRS+EGCEGMp9DGH8ViyrO45rKg
Date: Mon, 28 Apr 2025 10:43:29 +0000
Message-ID: <CY5PR11MB6366D67DDBB99F7A6824D968ED812@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20250426061815.work.435-kees@kernel.org>
In-Reply-To: <20250426061815.work.435-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DS0PR11MB6327:EE_
x-ms-office365-filtering-correlation-id: 9d3b8ed3-7b10-4a78-f0b3-08dd864183bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aUcrMVFWVFFXc2dPR2JrdHZWdEZ4QmNLMXVGblNZZmRIdWxOcTNvM1hRUFZp?=
 =?utf-8?B?YXBJZHFiTGRIT2VHY2t1MU5HTVlOWWdHSkFwV1VVTkVWSDBuQmx5bjRtUklF?=
 =?utf-8?B?WkJhR2ZPRlB4cVR3MkxpUmRRUDZuYU1xdWgrcmVWS20yVXRjRFR4YmZOUDFs?=
 =?utf-8?B?WG56Z0NySmNGcDc4bUZ2N1NqRXhKVGlCMklCYUtZMENYRXMwQkNNNWs5bXV1?=
 =?utf-8?B?YXBNeHcrV1RQaUFZM3BaYWowMmZwOUp3QXM5VGhSZzlOOWpBQ0p6Y2U5U1Rh?=
 =?utf-8?B?QWd0bmV3dFBPVHJ0ZFBLMkp0STRSVnNETkZIb0dhWFcwUDlObVJaL0pQcHdL?=
 =?utf-8?B?dFBuNlZWRVFmU0s5MDIvU2VyUngyQlU3OHgyY1QzRGlVZ0VvWWx0NnpHbWEr?=
 =?utf-8?B?OGdaR3BZWE9za1ljWmF0VVdrZ0pNeWZqeldWTzNUS3Bsb3M0WDNJMDlGZVd6?=
 =?utf-8?B?LzhjNm5QVzFTMmZ4eE1qM2NHaU1Rb2g1ZDVENDZwdmpuR2RPeGNRdWJZM3FR?=
 =?utf-8?B?OFo0MUc2K1dZUmJ3TlBaMFMrYXh3azJGdWNCaFdCeUpHR3lYMUgzK2JXQzRo?=
 =?utf-8?B?VEIrMGp6RlU5UkZ4Q3JsMEE5VW5JWUE1YTFkdFRSR2dXRWl3cXIxa2JrZk0z?=
 =?utf-8?B?b0JvdzBiZE9CdVN2K21ubFNMeDM5dVVuUGwvT3luVnU5WnMvbnBSNXZlcU5k?=
 =?utf-8?B?c29QVnFXZ2Yvei9SaXVlM1N3V05LUDR1U09LNTdNbmlPNHZuTXRUcmV0U3Vu?=
 =?utf-8?B?TzR6NlIxQitKWmR4RTNtYVVHbnl1THRWY1lyM0o5M0V2UkVvQjhLc3haYWpZ?=
 =?utf-8?B?YTNUSExLZE93dVNSYTFyUnl1NlloQXZtUzBnSzVuRWhDWjdNN3FleVAvUi9x?=
 =?utf-8?B?V1Bmb0Z5YWg5RFR5bStkZG15R2oxc3Z3eFoyMTNMRVIyc20xKzJ1MDg3eklB?=
 =?utf-8?B?aFd2cThpb1YzZDNLbTU1R2lKandKWGF0Qkt0YWxqK29SeFNMQWMwM1I3Y3NO?=
 =?utf-8?B?LzJ4MGVGR1pUb1IyT3B0bkFsSnU4ODY2S0VqT0VpMWg5ZjZqV3VDMFFOTUNV?=
 =?utf-8?B?MllBeWdnKzlnaysyMnFaanFNbVdCbFhEdzk5eWNUeVVIT1owaG9jVy83VXJo?=
 =?utf-8?B?SW9mRFdqZk5acUFiY0JKZnBxRE82RjBna2VhVkR5V2dZTTBjMkp1SFFFSWt1?=
 =?utf-8?B?NzJTQkREZWxYeld4eDIrNC8zcE5xV1JyOXdabGVwcW9mWFBwMVM0cGVudUVY?=
 =?utf-8?B?MU05dVhDa0RIV0Rtb2g2QnJPRWdtUkp3M05FVmhYeEZaTWtyVEU0cUJtRFh6?=
 =?utf-8?B?SWZtWVlkK1hRUjRqanJGa21xNU90cE9oeHFIK0ZGOUJpeXFsYU4wcmtNVW9O?=
 =?utf-8?B?NVdOU1dEUXhmT0c3a1FNUGI4WmcvVjI5aDdEejl2bDFnUGhJNmJ5OStoV2xa?=
 =?utf-8?B?WDFVREFFUW1wMGFnSW5mMzRYcDBxL3dhbFFMd2Z6UGlVWmU4WGhzenlDNEwy?=
 =?utf-8?B?UVA0ZGVhRDNMc0NKTE5ORVBCRkp0aSswYkJvN0Z1RTN4cVo5OEZobkl6ZjFL?=
 =?utf-8?B?bmluWEcxTGRFNDdSWUJhL2hidlJWeTB4TTJ6YmZFZjNCWnVzT3JIdjZpOFU1?=
 =?utf-8?B?Q1JFK3hVNU5mZ1VnajlWSjJaZU80L0JpTlJ3OXlWZmhKelRzNENZdkJlWk1s?=
 =?utf-8?B?K1VaUWRwWTE4S2ptOU1wQVNudnFTRGpaZVNRWFVoT2NoVS9EZGxQZ3lTd1Q1?=
 =?utf-8?B?MVR5YkhPemFLOVRiQmdzcHNYdzVOaEowOHlnTFl2Z0JUb2d6MTB3aWJVbVdk?=
 =?utf-8?B?b21tVFRwY0FiOGtoTllxbkpMdGlKcFZSdm1DZmxKbTBCODJLYVdsY092alBO?=
 =?utf-8?B?N3dTY05VWWZtaTZMeS9mYnlFcjNZNjU1WUloUlhNUE5ITGRTUmNxS3JqNDUr?=
 =?utf-8?B?b082ZkpuL2xTeVYzTUJKZzlTZGpSWkNPaGpPNVNUMUtJNlZlRmJURm9CY3Zr?=
 =?utf-8?B?K25KUzlxaXRBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEpBQWswRllUTkh5akg5M3FGTnBsOXN1U01Wby9uV0RsRjhZNk5lVy81UjBm?=
 =?utf-8?B?eW16ODFPaFRlaktxMHQ1NjNaL3R2bkJMZW9ScjlUZ014L0tuUUY3RHRCNC85?=
 =?utf-8?B?bUl5MDZ4UXpTa0MrdDRjTXZBRlM4QVJaWVk5OEo5NVJ0bzlvVUR4cXBXMTNG?=
 =?utf-8?B?SWFLMERiQ2FjeXZMcHZqTjJLMWJwaUhTYnR0aTVORENkTU5aNkZ0dUpnL3B4?=
 =?utf-8?B?WEFiaU9lamZTZkkwb2M5S0wwZExiVS9QYlQ4NkZEZmc1NVVBOFNmRHFOQlNt?=
 =?utf-8?B?Tk8rTktOYXFMMzZkZzBOVTFNR2VOTFFpRktNRUoya0haMTJyWU5wZHBya3cx?=
 =?utf-8?B?Z21TVGR0eFpsUmVybG1xOXV4QjhnUGtiNkx6OU4wUnFGdE9TTWxIZW9UQ2lK?=
 =?utf-8?B?OGdKZnB4TEE4RUVLSm44dGNNZGFDWEJNSXU3NWVrNmIzc09JenV0ZzN2R3Jl?=
 =?utf-8?B?VU9qSXpFOEF2bWMwbzdVbDROV0pYT2pWRCtNUEtpVDZrWCtScWdJVE1rTUtD?=
 =?utf-8?B?eE9zeDNNSE9wN2JSMmU4T3l2eWxVRCt0T3Y5c3NMY3JMSEF0U2kzeng1aUlH?=
 =?utf-8?B?aExWUFJFV1NmY0ZQNURBYUdSU1VybDgxTFlRcWtOZE9hSTFsbGljN2NtSUly?=
 =?utf-8?B?MCtqSFplZmVrODRMOW1pT2lVMXhYc25IT3R2U0tKdkRMcFdYdnc0dTkraDRJ?=
 =?utf-8?B?NEJGS0NMUjhHY0swUzlHait1cWFxWnRhQlBDTG41K3FYbGVGZmFGc3U3dnRz?=
 =?utf-8?B?dUlublJWcnRGaXJrNjRxSG5FNVRLaGE2Vm1zbW9MMGtpZ1Jta0pDQjk4SFQ5?=
 =?utf-8?B?dDFyN2QveDN6b29mSXpGSDFpTGJISE0xYnJ2Zzk1dUdJaVgvbVQ2NElteDdV?=
 =?utf-8?B?VEZzaFkrbmgxZ1g1Qk55Q2F1a3RJVk9MUllibU1PbUtkSkFjNkN4dlJGUDlx?=
 =?utf-8?B?UitvekZwaTJRMndTU2tRL09GMXBYa05FbExlT2JYZ0xaUVM1Vng3bnc4d09O?=
 =?utf-8?B?VDV6NGcyTGk5TEtMeVNlQU1VT2JyaVhTRmFScDBwTU9MaW92MlhzQmVvaVlU?=
 =?utf-8?B?R25CbWpiQ0N3U2wzNHVDRXZkL2xnejlPNmpaaGpmMEpJdktkdVh6TzBhSDBl?=
 =?utf-8?B?NlV2bTV4dURMK2RPc1pQS0NOc1J0b0ZKKy9FTS8vaWdrSm55cDJ5SmNqcXNi?=
 =?utf-8?B?WXROUU9XKzBEMXVEbCs0QkN5ZkgxUks2d054NkxwWXBtWkNoLzlCekhiTldZ?=
 =?utf-8?B?cXdYRnAwUG50VmFkY0c5V21ha2g0NEd0ZVJWQkdjWmxiaU9zb2I3SjdGT05q?=
 =?utf-8?B?dSt0VzI4RnlEUWx6VHpUdDBETEwyWlNxTHVhVXBMTFpMbjBjdEdsYUxFTmFq?=
 =?utf-8?B?RmpCbVg2N0hJVExhM2tPWnpLOTZneVA3YndaVjh4NHUrRmhETy9ST2xzZVpG?=
 =?utf-8?B?MWVsd28ybTFReWliVHhVMFNkNlg5eTZ1b1BaT0xOWElNNTc4U1ZlMlhRcU4x?=
 =?utf-8?B?eXVnd2pCdzVJbGkvT2gyenA3RlptQzNLSjhUZHlaV1BabHA2WFRha0gwWVVp?=
 =?utf-8?B?dzF1cnV6WWl2czdUWWQxQ2h0a0kzdFR2WlVUbjlieGROUnowb1I2VGUrUXZF?=
 =?utf-8?B?cXdOWE9zSXNHbW15VUg2NkdGOEFuUVdOdm1IWkhwZTZSR2JWa0piRnVrNVdT?=
 =?utf-8?B?MzlwV3BPWVhnVGMyODIxakwxWXJsbGQyU0R3QWNyTnBRdzBYelBvTS9OSFgr?=
 =?utf-8?B?SU5ydHVTNnZDNXFIRFlCM3lDRnlMTTFNN2lLSi92OVdKT0pNYjhkVXhqT3VH?=
 =?utf-8?B?Zmk2ZUI3M2xtMmEzVDVlODBRazk3b0pNUnQvSnZOU3VuSXZLbU5WWW9Rb3Qv?=
 =?utf-8?B?SU9uRHVkZWdRWHNzYXBJVC9JZllMR3NqOG5MZmZvMVhJNXo2Q3NLZC9yaGVu?=
 =?utf-8?B?eHhrMjRCYmVMWXphdlVKRm5FZlZLMmV6VlIyRnA0K3E0TlN5VE9XbFAxSlQz?=
 =?utf-8?B?aEZwL0pIL3Vva0VQakVpSmxOYUJDN1JRSEpsTjZGZGJ3ZEdhT0tkbXZsWEMz?=
 =?utf-8?B?eVFBZU1UM0xXOWFiZnloaHZoMVgzemMrRnF3UW4wR1JJbTV5WklodVM1L05t?=
 =?utf-8?Q?mMrREx/ZS1z5HT4s6WK4d1Lkb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3b8ed3-7b10-4a78-f0b3-08dd864183bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 10:43:29.6950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpe6skVwgs+tJIUnSf+jqSD0+a90ytH9Pw/6hfQrjI366tvi51ifr7eQxiA77NJUhaqxaFHUa2agAgQv3ZpKI+qVphbuXeWaFGqjfdK/NiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6327
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0hdIG1laTogQ2FzdCB0aGUgY2ItPmV4dF9oZHIgYWxsb2NhdGlvbiB0
eXBlDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBmb3IgbWFraW5nIHRoZSBrbWFsbG9jIGZhbWlseSBv
ZiBhbGxvY2F0b3JzIHR5cGUgYXdhcmUsDQo+IHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhl
IHJldHVybmVkIHR5cGUgZnJvbSB0aGUgYWxsb2NhdGlvbiBtYXRjaGVzDQo+IHRoZSB0eXBlIG9m
IHRoZSB2YXJpYWJsZSBiZWluZyBhc3NpZ25lZC4gKEJlZm9yZSwgdGhlIGFsbG9jYXRvciB3b3Vs
ZA0KPiBhbHdheXMgcmV0dXJuICJ2b2lkICoiLCB3aGljaCBjYW4gYmUgaW1wbGljaXRseSBjYXN0
IHRvIGFueSBwb2ludGVyIHR5cGUuKQ0KPiANCj4gVGhlIGFzc2lnbmVkIHR5cGUgaXMgInN0cnVj
dCBtZWlfZXh0X2hkciAqIiwgYnV0IHRoZSByZXR1cm5lZCB0eXBlIHdpbGwNCj4gYmUgInN0cnVj
dCBtZWlfZXh0X2hkcl9nc2NfZjJoICoiLCB3aGljaCBpcyBhIGxhcmdlciBhbGxvY2F0aW9uIHNp
emUuDQo+IFRoaXMgaXMgYnkgZGVzaWduIGFzIHN0cnVjdCBtZWlfZXh0X2hkcl9nc2NfZjJoIGNv
bnRhaW5zIHN0cnVjdA0KPiBtZWlfZXh0X2hkciBhcyBpdHMgZmlyc3QgbWVtYmVyLiBDYXN0IHRo
ZSBhbGxvY2F0aW9uIHRvIHRoZSBtYXRjaCB0aGUNCj4gYXNzaWdubWVudC4NCj4gDQoNCkFja2Vk
LWJ5OiBBbGV4YW5kZXIgVXN5c2tpbiA8YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPg0KDQo+
IFNpZ25lZC1vZmYtYnk6IEtlZXMgQ29vayA8a2Vlc0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gQ2M6
IEFsZXhhbmRlciBVc3lza2luIDxhbGV4YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+DQo+IENjOiBB
cm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL21pc2MvbWVpL2lu
dGVycnVwdC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL21laS9pbnRlcnJ1cHQu
YyBiL2RyaXZlcnMvbWlzYy9tZWkvaW50ZXJydXB0LmMNCj4gaW5kZXggYjA5Yjc5ZmVkYWJhLi5j
NDg0ZjQxNmZhZTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaW50ZXJydXB0LmMN
Cj4gKysrIGIvZHJpdmVycy9taXNjL21laS9pbnRlcnJ1cHQuYw0KPiBAQCAtMTMzLDcgKzEzMyw3
IEBAIHN0YXRpYyBpbnQgbWVpX2NsX2lycV9yZWFkX21zZyhzdHJ1Y3QgbWVpX2NsICpjbCwNCj4g
IAkJCQlicmVhazsNCj4gIAkJCWNhc2UgTUVJX0VYVF9IRFJfR1NDOg0KPiAgCQkJCWdzY19mMmgg
PSAoc3RydWN0IG1laV9leHRfaGRyX2dzY19mMmggKilleHQ7DQo+IC0JCQkJY2ItPmV4dF9oZHIg
PSBremFsbG9jKHNpemVvZigqZ3NjX2YyaCksDQo+IEdGUF9LRVJORUwpOw0KPiArCQkJCWNiLT5l
eHRfaGRyID0gKHN0cnVjdCBtZWlfZXh0X2hkcg0KPiAqKWt6YWxsb2Moc2l6ZW9mKCpnc2NfZjJo
KSwgR0ZQX0tFUk5FTCk7DQo+ICAJCQkJaWYgKCFjYi0+ZXh0X2hkcikgew0KPiAgCQkJCQljYi0+
c3RhdHVzID0gLUVOT01FTTsNCj4gIAkJCQkJZ290byBkaXNjYXJkOw0KPiAtLQ0KPiAyLjM0LjEN
Cg0K
