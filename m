Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E313BE62D;
	Thu, 12 Mar 2026 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335361; cv=fail; b=Q72/wzg//z5vFXbxTz6CeH8LN/5DOFyPH36GtzFiRev1D6koDlL8qy87bP36cs8VYFhLQFKqyET/EECNyHE8DmPr36JCeWIGrG30tQLmhmmw8x8ITcCpRuZi6rll1zCxm1y6IYt42qU87iY9aVCYfJYTq1PVhTimjtiCJvzR3kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335361; c=relaxed/simple;
	bh=Ib2UahqiLw7YnUIeWjtpTk6JrZ0iRc/w2Fk8kFm/Ozs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S4XckgpwStyX42u2j49HKvDVcSZcFF9TOAYCF/xELu49yb+WzdwdcQPUgzepr6yASL2PZ+FM2PgMUqTRY/4GRbCFbNfjYb8gQlhk0eiyqKNddLBUPPN3UnOx3UfVVVG1EwbaAZt6nNit9Log8ftV5KaUzXEDbeMT9utjYJOdk08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLeJ7Q9w; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLeJ7Q9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773335357; x=1804871357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ib2UahqiLw7YnUIeWjtpTk6JrZ0iRc/w2Fk8kFm/Ozs=;
  b=HLeJ7Q9wbaB8BUoUsqEh8OA6q6BCjFuxVkUkwiNLuS8EqfksqinJL9Wj
   o4Qb+4z9vocjULO3e2ZBhFp8HWej8ww/y+cVpLdpFcxElS7FXRfZPdY/0
   Q4n+SMQtF8Jzw4Zk1LIRuL/ZiGysN6EAg/I7JSAGXt3X6o+6wJPN18jas
   XOuphRMA7OppNrU18XutYGaMBDHwv+JhHGd8WK6Zvsfyf89wuortQoi9W
   jlrNolxNn8z/oCWhY2MedbwsI1q50PV8eNSW2Qm2qAXKnHbx43ACbN6pa
   +XUmsd8MJS5AwBAoMC9DTGfdSicV9JW53rtW2f3jpswWKtyLQuc+A7FzT
   g==;
X-CSE-ConnectionGUID: zsDYmN/fTia3Bp2g7TkmvA==
X-CSE-MsgGUID: EHO3/Lw4TUeCtQ35P5zpLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85139423"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85139423"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 10:09:16 -0700
X-CSE-ConnectionGUID: itlge8oVRkOp/KKcGxvF2Q==
X-CSE-MsgGUID: cTxqp6q+RlqZd6KmXRnefw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220145202"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 10:09:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 10:09:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 10:09:14 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 10:09:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVjCl6ZRMaziEWfmypMNTlMOnqSZyJ1rkw4DWPMYBs+d+Ozvk79AqIf/DyhgUhjj8xOcYdyfS8tA9NjMqn5dL106H7Iaipo3gapzofmDvx7hxkHYw2tiUky0dZgOgoB7f3cw6B+K1w6kkPRYNplCwv+MbUWCpUk5+oCU7JLNn+77EoUxzlkb/Ip/irFIY9uutmHEUOgfhZ0KWdXnZYDn0zz8VBd65zcqHZZs8HpZda6TgjM4Zc9rHLaJboUoloGNcE331/sNRB+tTdcsN1oCsHmmZLmW1E2Sl4bHrz+dMymUCmW2cbUrqq8lU3P5Gt1mqHjHfUVQzfUniMieu36yCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib2UahqiLw7YnUIeWjtpTk6JrZ0iRc/w2Fk8kFm/Ozs=;
 b=jgScti91b2b9kWz0SCgRaZB5MRx1H4d5jwZ99EzN9rjjAN+SU1vB+gXrQ5jXfP8ksVMolrzgHv2YhTmiFR4USya2nELF4tlqftgZxIBsA3HY+I6Yn4NeMZUQFC2kUs4RLlt5+39j5+Zo8JHUgSKUiCb8Rabpp0RqorFxqujOBhoaXaZlP4Vg6pNIwtpDGZA/7ZtZ7uZh7j5jXKJxKjmRgPhQVnYcf+6v9Md0n1V0NuM+5/fji5bxB90l5hIFibfpzEDnh/RLOjXJy7qMaU79iJ0aQ8B8EqIR6u4oXmVX8T+3yrS1fyC0keg0JBFARTZph6L2wLyKCHX9jTx4tPDnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 17:09:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%7]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 17:09:05 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Rosen Penev <rosenp@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\\b__counted_by(_le|_be)?\\b"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] EDAC: sb_edac: use kzalloc_flex
Thread-Topic: [PATCH] EDAC: sb_edac: use kzalloc_flex
Thread-Index: AQHcsa6EDbol0LPj5UmLtUYdMu7Mh7Wp/LJggAAHYoCAAR1QsA==
Date: Thu, 12 Mar 2026 17:09:05 +0000
Message-ID: <SJ1PR11MB6083385736D708F551CEC85DFC44A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260311232545.18492-1-rosenp@gmail.com>
 <SJ1PR11MB6083C3A677F5C906222794A6FC47A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAKxU2N8zSkzJMp85hgRN453x8bcPDvN_3tXmp-sNfueZOAuHfw@mail.gmail.com>
In-Reply-To: <CAKxU2N8zSkzJMp85hgRN453x8bcPDvN_3tXmp-sNfueZOAuHfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB7303:EE_
x-ms-office365-filtering-correlation-id: 25470c55-2ec0-4476-505d-08de805a10d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: YlWhifBtqt9KZ8z8o4bXsIiLTntZvH2KjJvtWutGRwbHK35AoC4bQOTMwdhiV34tB5XhrlKEIPrUMW73TkhOgSLmMhe6Ufl84EDGSMut6WY2Bun3+5kmEAa8oGrQLmXxa8Wf0V+ZX61bB4lI/XHK87m6hBum202TcDZ4IDD2PWBw2rLGDAZOXYe4zh586jy3N+wU1Oa5JNvlx95h3xeyLcF6JWeYw6E0S2/vottiJrX1s76hfW94SoTezA3N7mASMhF5WAmR4lscE98neQCjdrubBAbBOaHOJv5VrgmiXc+v8T1PKNNTjXs5ofIAnGlYagZ2lqhmvTaWOK0AhCkyLXiri9i+n7A6DmybnkHkorqm7OmQR9Ba5bQc0LOui0z/I4OJTNoDY/V88xopWBBGzKhYceDLl0pxu4LRU8dv5u/8AoGSN9uMyreMXQ5FbWIjIw1pmtBhGFacJ2NUf5/0pU9nrz3nNLP3eTtC3Dkp7Y7pKu3S2KPGLf8NuaVq4r3ggxSJKcBmZ/M3r4kaVPSTcOp25TiKS3th6BbE9qIzNT6EF/f/yosvNT39uT3H6978fOY2xrCjcXF+fOdoYlFYa00XyAwJBtLojZST7VhO2QK1MItT6XwH0MKLX9mQ6xOiIJ4ggCq8R9OGbjyj+y1fSce3MLspDJ1TPq5ZowaEVcgnHu7A3DmM0FqN2tzQcjkclSEweAUw/+R61vAUsfYTnz1ZNvKM4n8TgPZcxKQMJCaPwrO3h6WteM/h26ntFcGDpQEiFuv3wre7wjXK5ZFFQ+Q3i36Y3buTekCvWnfCtWw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0FKSUZCQWJyLzR6RUoxYVhielRaWVpLNmFWakorYm9yNWU1ZFJac29nV1du?=
 =?utf-8?B?TnZJNmRhMHEwcWt2UU9UL293V0Yvb3JXa1BnZ3JjWWhTWG1xYjNjWWc3cHds?=
 =?utf-8?B?R3A2Tkk5c2tjWE9RQ1c1U0YvZTFUWUhMU243NUg2clVHZjBBZ2NXdTRPMTIr?=
 =?utf-8?B?TUFkR2VleFhSMUYzdVR3YkJVS052MW1EbnYwa3R4SFNnQThrYzZSQUNBd1RN?=
 =?utf-8?B?ckI1eFZVUnNBWGs2M1hsL21EZVZDUCtoRzdpSk1OSFAyTVBoVWtzNFN5RHkw?=
 =?utf-8?B?dStOR25mN0VidTlIZmRrZ1I0Q3dJUlVzbG40a001enl0UVFNZFEzd25IcDhJ?=
 =?utf-8?B?b202WkNRelFFcURHVUlLSVJqYWtqc0lUQ1lyZWtuSUUxcnIycVV4elN2M3dk?=
 =?utf-8?B?cFdZOFZIZlNvOFl4U09ONk9xVXpoQ3FCbXBBL0dMcFRydThEcGFWa21hdkxM?=
 =?utf-8?B?Z01PQlhPQTl0VGhYdzhQVEp3WFlLd2lZeCs1bE5JOHF3dzRsR3hkeHk5TFhs?=
 =?utf-8?B?TlVtV1lxbjlGNXJNU3hDRVZiM0lCQUs3WmErNG9Nejd5dXNPZ2RwR0xyM0o0?=
 =?utf-8?B?SGtvcmF0cm5RNENHanVta0wxYkcwWi9RQ052Rkc5aXl0U1JmY2c3eFN5bFlI?=
 =?utf-8?B?RUhaR2xYVml0Ni8vQUFTQ0tBUTFIcmdIUXdqSzRQQmNJRXBBYmlocmwvTjlQ?=
 =?utf-8?B?b2cycDlBMUpvY2tUZjMvQXhnenFPTkFxVnlpbDhVdWJkUElLWWlHbmNlR2Ir?=
 =?utf-8?B?WUFBVGpKTk5SQlFiTktsWXRVb0NZWW9NeXRZazVHbk11dFhLOE12WWtTOW9H?=
 =?utf-8?B?eVVzQW53eHpEVHNCS3dmYXN3djkrNnI0Qm02eGxJYlIrRVJXUkliUm5wak9w?=
 =?utf-8?B?dGhuR2E4LzVoU0JUK1JqT3FMV3RzamM3cnQ1QS9HUjljTjV5UVFBYUxTN2M2?=
 =?utf-8?B?QWsrbkNxbWJVN1IybmJqSEhjaEdvMHNxVFlXZzFwUWxuL2w4bWhhcEJicXdN?=
 =?utf-8?B?b01XejcyTFlUQjBtamRxVHIxaDhOSW9oSGJkbTlIVURrT1A1MXoyNWhqWXlP?=
 =?utf-8?B?VW1MLzNaSVgvdDFURnVYSS9HeG9mcm05VTNKOXNNTnIyMFRlcm5MdXdzTlBa?=
 =?utf-8?B?YTlIUjJKeFFINlpiTTM1TXQwMzJNNjN3U0tiSHFIcExKSkhiMXl1bUdQSnZ0?=
 =?utf-8?B?aWRHcm90Qlh0UXRiZm5YbEFQb1JqSVdkY0ZMVmhBSnpaU3NlSzhWZnhlWWF2?=
 =?utf-8?B?YVhBemg5TzhRNHY1aXRJVUpTOE0rVDlvQ09jb01neDRwUnhnUEdUUDVNanQr?=
 =?utf-8?B?dmplTXJiTnA3Y2VwcWRsbU1LV25JUjFaOExuOVpJZkZCcnMrcURwbGdOdjlm?=
 =?utf-8?B?eDA4OVFMT1BzdHVQeW80OVFYeDk4bWJ5ek4wVURuNzBoTklhMEpoQmlVQytQ?=
 =?utf-8?B?UWNPUFNKWTNRdWVIK1dBS29IK2JUYTdnemxjVjdIV0hGUTB0cGpmWnhVN1h4?=
 =?utf-8?B?TmFReWZhKzBTT2cvcjVRSlFZNFIyT1RHZk43c2wvYUdQT0MvcGdhQ2dJMGgx?=
 =?utf-8?B?bWUvVVhmMHhZMnJzVkRQam05VVlKekRXVWlvTzl4Q011NlZxYXVPd3FBbnE3?=
 =?utf-8?B?OExnTi9CMk0zNWFKOThOZlhncXU0ZUd6VE82MWpZbEY4NmJaTTQ3OEJaYVZr?=
 =?utf-8?B?VUNaUVl4ejl5cW9jdmsrZ1JXa1hndEFlVzBkaktlQmErdUw4d1Q1ZzlOakRx?=
 =?utf-8?B?VkhUZ0F0VzN0RFNhZU1meW5HMWIxN2wwZ3RWcG54T1ZBU1dCbUxrM0l5dHRZ?=
 =?utf-8?B?cXJVK1pjbDh4SmFkN29KRElzU1BkdEY1Y212TlNFMDhEWW5hUWw1cXpCNDU2?=
 =?utf-8?B?RlhHQ0I4S3QvREFYY3lxKy9qYi9NZTlOWTRLbm5tWnIvb2pia2hjQ3UrQzU3?=
 =?utf-8?B?bHk5MDZrcHpPK3ptclpyaHhPTGZlSWh0M0diUElnWWRNK2h4ZUx1WGJ6QU1R?=
 =?utf-8?B?RzMyUjNaN1cxeTlROVFtelFlY1ZHYzJaNVZnQXJVVkU1U0s0emI2VlpXbHJr?=
 =?utf-8?B?azFrc1AyYnlHQnpxWTBHQnUvQmp5REtvVzhTRHZpeFRYeG5WMC9tQVZiWUxn?=
 =?utf-8?B?UzBZSWJRdGJpR1FFMWtrYVFhV0lpeFpVbmdzcm1DM3hlM2NmQ0xON1hKQTFh?=
 =?utf-8?B?aXpGVUUrQnZkNDFDYWwvNDU1Ry9pQlp0SWFTaExvOXE5OXlzaDhEeWRBdjY1?=
 =?utf-8?B?d2I0M2NTVGpTUFVYTkZCM2JyNi9nMUU4ZnROWU9sd1FrditQQXp6dTRKRmZn?=
 =?utf-8?Q?cm4j97P38nkvFvdVys?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TD/V3ePLy8rDk1MzZBMb+OY/RVPBsUqjJAxW+euVinG2G+lG10ZoEvVIqXtuLenOCxQ/JVkwuiOURvU73dyTr+L9oAm/uGGgG8POzemPit1fal9Zs2UB9uelCiK4cr0u4B/Jr6d5hUig4ZTDykm6iP9LZu4Iw4p6/u/nquYvtSo5w6Uv9Fn+BZIPy8m9TeJFJfxTWBFlvs2SNj9lrXkQ7UVs7enSzJ3Ro/+HK7jAj08kq3D3MtjoM7NJ8y3uVIAmSXkYmbca3arg33OEi1Ay5lf2oyp+LrP4vqPsPPqoro1HTyUe2PfgKmV8ti78tGXdckg/uS1tX8CN+od9A4G+qw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25470c55-2ec0-4476-505d-08de805a10d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 17:09:05.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MT2WLyrWeNIeVuNe2r2Z7K8qyKEyk6P4Zz6hf5oWP0l/uE+46HDl3nCjg/hoY/pEuQtfV0PfjIsKAvQZXmcLLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com

PiA+ICsgICAgICAgc2JyaWRnZV9kZXYtPm5fZGV2cyA9IHRhYmxlLT5uX2RldnNfcGVyX2ltYzsN
Cj4gPg0KPiA+IERvIHlvdSBuZWVkIHRoaXM/IEkgdGhvdWdodCB0aGF0IGt6YWxsb2NfZmxleCgp
IGZpbGxlZCBpbiB0aGUgX19jb3VudGVkX2J5IGZpZWxkIG9mIHRoZSBzdHJ1Y3R1cmUgZm9yIHlv
dS4NCj4ga3phbGxvY19mbGV4IGlzIGp1c3QgYSBtYWNybyBvdmVyIGt6YWxsb2Moc3RydWN0X3Np
emUoKSkuIEl0IGRvZXMgbm90DQo+IGRvIGF1dG9tYXRpYyBfX2NvdW50ZWRfYnksIHdoaWNoIG1h
a2VzIG5vIHNlbnNlLg0KDQpJdCBpcyBhIGZhbmN5IG1hY3JvLiBCdXQgbWF5IGJlIGNvbXBsaWVy
IHZlcnNpb24gZGVwZW5kZW50IHdoZXRoZXIgdGhlIGNvdW50IGlzIGZpbGxlZCBpbi4NCg0KU2Vl
IGluY2x1ZGUvbGludXgvc2xhYi5oIHdoZXJlIGt6YWxsb2NfZmxleCgpIHVzZXMgX19hbGxvY19m
bGV4KCkgd2hpY2ggbG9va3MgbGlrZSB0aGlzOg0KDQoNCiNkZWZpbmUgX19hbGxvY19mbGV4KEtN
QUxMT0MsIEdGUCwgVFlQRSwgRkFNLCBDT1VOVCkgICAgICAgICAgICAgICAgICAgIFwNCih7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCiAgICAgICAgY29uc3Qgc2l6ZV90IF9fY291bnQgPSAoQ09VTlQpOyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgY29uc3Qgc2l6ZV90IF9fb2Jq
X3NpemUgPSBzdHJ1Y3Rfc2l6ZV90KFRZUEUsIEZBTSwgX19jb3VudCk7ICAgIFwNCiAgICAgICAg
VFlQRSAqX19vYmpfcHRyID0gS01BTExPQyhfX29ial9zaXplLCBHRlApOyAgICAgICAgICAgICAg
ICAgICAgIFwNCiAgICAgICAgaWYgKF9fb2JqX3B0cikgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICBfX3NldF9mbGV4X2Nv
dW50ZXIoX19vYmpfcHRyLT5GQU0sIF9fY291bnQpOyAgICAgICAgICAgIFwNCiAgICAgICAgX19v
YmpfcHRyOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCn0pDQoNCg0KU2VlIHRoZSBfX3NldF9mbGV4X2NvdW50ZXIoKSAuLi4gbG9va3MgbGlr
ZSBpdCBpcyB0cnlpbmcgdG8gc2V0IHRoZSBjb3VudGVkX2J5IGZpZWxkLg0KDQotVG9ueQ0KDQoN
Cg==
