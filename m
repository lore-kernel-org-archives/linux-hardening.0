Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1A19D88D;
	Wed,  5 Jun 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602673; cv=fail; b=V0LExwzIOVnHF96WNsoxTS9Jzl2BvEfWwK545198iwC9ZUgEYzolPPlWvkPRHJ7aFXVUpOwjWiPRzwvRCc4+7QC0Zswpv6L4n7bYBHnWgr5IJ1IzZm5k+S7KaZRV5hP28uE7nDuFsG40Ss0FJMVhH7JdWs5+PZzQRBNqth1B5ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602673; c=relaxed/simple;
	bh=tw16iOUOPsr6bLEqwUV+gpVt3MK7rADKdYN/d38ujE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/1i+x4icfwvq5KjopfZ88L5TlUGANurHRy+M0ZMdSrWCMW6q4zfEqkgOTLeaeb6E+Ggc8JMdkukrwngDGd+YgHsu3jH/A0Ev8YbWT26psocPrOMbvVqXmsd0IcBd8TEhT1BZBeFVt4lTy9JLiq+2DrumfhCNtLMn19tr5C+4+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bT/8Z7i+; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bT/8Z7i+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717602671; x=1749138671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tw16iOUOPsr6bLEqwUV+gpVt3MK7rADKdYN/d38ujE0=;
  b=bT/8Z7i+xbQq+M14W5KjStjz85+Hap/68hDIlYmEWoA7bgKd/RqUf/Bm
   k3NCesDxJeZtwFEFgAokJSa0ocvWVCIDscEEZggMF4OVOOAx4vmZFFP98
   juc0BfiVmvp7ww492OLTv42gd9ZDb78hiz4XjjkJsvXFuHNXGD2jf00V3
   h/RNmdFG2Sjncma67x0MyVHTCSVyRWBsmXklemRGBkDD+5YzYBaMBq9Gs
   7SW22wzg0UqSm15U7Us+3cOX5Nx0J6pWWPO7y7j+3wpPcgVmOzEEMQQRW
   pG7BLTILZxNgK+L8CoPzxQLRWFoPFxbqQ+WOK+ebDImUrk72M1KE4juxp
   Q==;
X-CSE-ConnectionGUID: gBl5jDLKSaO/nIv4q1kjOQ==
X-CSE-MsgGUID: XDjhjhVDQ3+dGP4/NCjJFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14027760"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14027760"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:51:10 -0700
X-CSE-ConnectionGUID: dfD/OXu+SyGvAN4tnb12uQ==
X-CSE-MsgGUID: 3PDfdySXSLmRlYEam6eKUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37699473"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 08:51:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 08:51:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 08:51:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 08:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMiI4WVwTcPT2toupl9ruUhHGfQpIR61FgXnu9iw/NUCkX18z+nnidmdJjmKh+A6Xi6vfCWxeSqUi+Ayp+d6PjKe20EXs44TN6DRDprCgZbotWoI7F3zclYDNXHi6OqYavVFuAcNxqY5g80l8KeZh7IFLk828eyLsOMJ429hUIvcD4G+60aknV8xXbkT3AJo+dTGTqwD8Vp0MtP9hp4pwqUL9DjBCZKyGOg0ZAhMOCVAmqxPHqmBFhIpL4ZJ0eJyGtvoUEEu5qfQI/Vz7BwB2uaZEB4RwulnUbcXSfePYKAC6diSUeAAJTEQsU/L1ftSd7Up/oFqm1QDpKpMZaiyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw16iOUOPsr6bLEqwUV+gpVt3MK7rADKdYN/d38ujE0=;
 b=WTIpemXedcM+LzowYpBbXNVqhxKnyQOM4qYUIZcgtq9WErOQNR/I4cW2MHIhY07kGs36UMXFcJ/hMybSGBEo9dIkB8WIw0ZQly2Lmchzc5BWb7ZGaf1dGkNgVUDhrAzhdJ58BqpE/ru3cd2NojgLUe87agU0vR84GpGeNTdq6B5jPeAWPHgt6Jk46w2VcPc52sI+99F4jRmPIQlgbX2jIdrfjaVNyha+1vUTy69Phm0QXt4bFPtqSEuRhtYhCJwDTqJlav2hscixAIlRYY026kfy8sBfYRljP2LAKzy7Rrc+pHEeWW8p7MCgfuwHBTD1H7pS7UUnPJhL+Nm2Y6yUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6871.namprd11.prod.outlook.com (2603:10b6:806:2b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 5 Jun
 2024 15:51:07 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 15:51:07 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds
	<torvalds@linux-foundation.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
	"mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "yaolu@kylinos.cn" <yaolu@kylinos.cn>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "justinstitt@google.com"
	<justinstitt@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "CobeChen@zhaoxin.com"
	<CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>,
	"LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>
Subject: RE: [PATCH] x86/hpet: Read HPET directly if panic in progress
Thread-Topic: [PATCH] x86/hpet: Read HPET directly if panic in progress
Thread-Index: AQHasMnDpgSqt6YvJEilDwQwXTRTp7Gssl0AgACEYoCAABNcgIAAi+WAgArqMgCAADXRgIAACX6AgAAXRICAAAg8AIAAPwng
Date: Wed, 5 Jun 2024 15:51:07 +0000
Message-ID: <SJ1PR11MB60833ACD1E6C946F72C58736FCF92@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
 <87le3t9i8c.ffs@tglx> <0aff3f62-a8a5-4358-ae3f-2ded339aface@zhaoxin.com>
 <20240605093609.GCZmAxidNIBP5bkDcX@fat_crate.local>
 <e4f307dd-3264-45f6-82eb-0102f7fb99d7@zhaoxin.com>
 <20240605113323.GFZmBNA7ec2s191_2w@fat_crate.local>
 <46741fad-425c-4ed2-97be-3f2679da63eb@zhaoxin.com>
In-Reply-To: <46741fad-425c-4ed2-97be-3f2679da63eb@zhaoxin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6871:EE_
x-ms-office365-filtering-correlation-id: 193ecc01-2923-4145-7df9-08dc85775013
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?d3pJd0lGV0Q0SERSeEFjdTRPRW9rczVoR09KOTNmcGc1WEdRMnZXWDJSSnRa?=
 =?utf-8?B?MXlKWWNLQ1oyNlhNQmFXNEpEbUF0a0N5c24xQTI4Q1lhRElUa0oycWpoRXNG?=
 =?utf-8?B?dlYvbjE1S1NsZWtsTlhRMWkyWHZ3NmgxMWxkOVp5ZG52QjRFbEczczNTa3J0?=
 =?utf-8?B?UkpJakdBV282bkNxOW10R3ZXMlF3SFNJUlBnVHd5TjRXV0Z5Z1Q0eCs1NkI2?=
 =?utf-8?B?VTl1djQzaTFiLzNyS1R6VTdGVy9wdEtnRGNzYW40L3JNN1hEdU5YQkVqa3pK?=
 =?utf-8?B?RDRkMHJTWEVYd0pLNkMrSVZCTGVnUEJ5YVNOeFh2WnA0SVJHSkRJai9wLzY0?=
 =?utf-8?B?UjlzeWVsWlkyckZsZUk0VmlGV2pIRmlwQ3kzaEZGelgwZXBMRlNGOWF5cHlX?=
 =?utf-8?B?SkZaRVM1TUdrWFA2K0JwWllndHBxRGpzTFRGTkxWM1YwYWIwS0E5YW9nbXRz?=
 =?utf-8?B?QVRTaGlPOGVXUEkzeXEvWjRQeWlKN1FwUXVxZ3pyZHphNVFNeVd5Y2pTUjND?=
 =?utf-8?B?SDhUYzdzNGM0VG1FYm4rQjJIV2daWjNUUUF3UmZ5YUdzZlFhVkZOdWNjcXRB?=
 =?utf-8?B?UVUvNWtuQVV5UUhNN2pnREw3ZTJvZ0wwb2pKaTZvTGN5OXNTTW1CWXg4WlFS?=
 =?utf-8?B?RzNyZGQ2QlVkWmdhbWFRRUZOclNtRjBkWXhSdG5tbDNNcVpTaEg1L0Jydkhq?=
 =?utf-8?B?V3FnOTcwMDlTLy8rN3J0cFloSE14ZG9tOVltN3N6VW9jSWIwZ2wzcW5ZVDJ5?=
 =?utf-8?B?c2dTc0xEZVgxYzRNV1c3TFZMekd2cks1OXd0NmhZYjk4VVU3QW9lcHVRVnVG?=
 =?utf-8?B?L3ZoWTFjdUlpTVFRdldHeDVwV2hyWk1RS3YrRERYcThCc3hyVnk1YzJwN2FL?=
 =?utf-8?B?czJCWWJtajh5VkxKZ1FhTEpEeE53VVlKM2FaYXI3U0F1NHRaUzJjZDFvYWZ5?=
 =?utf-8?B?K2lFSDhSbVk2ZEQrZ3M1ZjlOK1daNlVkeVBBNmlNQ2RHYlVpZTl4eDZaTnRq?=
 =?utf-8?B?QlhzbmYzaWhHckxSNElhYm11anEwcDY5T0NSbENsSkt1UzVieWdRcmo0c1Bn?=
 =?utf-8?B?b1R4OVhNWDFsc1lNSEhYM2lnR2hlck9jdUkxeC9adUFCa0FyUjJCRjE5SGRo?=
 =?utf-8?B?eWtQN051Tm5HVkhOR0NWaGhlNE1XMXFlc1Q0cVJpY3NPbVVndmhMRytCTmpu?=
 =?utf-8?B?cFhoeTUzU21DWEYrQ243MjVrb0FIQjlhOStQa29sb1dUSERvTlUzYjhjbU14?=
 =?utf-8?B?SmNkUlpseFZSd0dpaFptcENVL1BtWXl4azcwU3hJVVNuMzJ4OE5UWW5YSnZG?=
 =?utf-8?B?ZXpqRUwxbGtrV1B4UUhFTURSWk9ZYkIwZzQ1REhJb2lJaEd3T0c5d1NIT1BK?=
 =?utf-8?B?dzF0amNCaHB2MEdVcm9hK1pOOElvMVQwVDBORUtSYlBCMlZrOFFpeWdIVi9l?=
 =?utf-8?B?NG8yMDZtTmcwOHFCNUdOSmV1cWpmcU5acEQzb2Nja3ZyT1hxNXFxQVJzTnVx?=
 =?utf-8?B?Qklxek1SR3BTVVlrYytFY3NTbVZyVDVheGNSMzJFLzJqbkJiWmg4SlN4ZnJk?=
 =?utf-8?B?SGxNUmdWRXRIQUJLVWVROHU0MlZRZ1RtT3ppem5zVi9TeTczMWFLM29BUm1x?=
 =?utf-8?B?d0ZJZWdLcDI2NmJNWkpyQzZUMldDdE5PbEtESmpJUnhYM0RjVExCTXZ6RC8r?=
 =?utf-8?B?dURUVG9waXlMYWdmUkwrZDI4MEJEM0dDYXBjL1ZhNU90SWdwdzFWMzlZSU9x?=
 =?utf-8?B?ckZCL2IvVy9pOTc4SDFsWmE1SDNVMEM4eDUzY3MrQU5xVEFtckdaejIwaFR3?=
 =?utf-8?B?NWRSc3JQK3YxTmRiRFBrQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0FyU3VlMXVGMFRvaTBMK2RSOHhxNHJsRGhWWGU1UGloWHBFYjN3cy9PN0Yz?=
 =?utf-8?B?bFBzSUdTaGpUbUZGRWI2RHdTOHhsY0xaMXhlcWFhbXY4c1owRU1URGYwNS9z?=
 =?utf-8?B?MVlXY3lIaVBCWFNXM1RCY2o0Vmovc1VPVkwxUDYvd3RwTklUbkJUdm5xYXZk?=
 =?utf-8?B?bGF6UW5NSzYwUDU1N1BqWXFpTkw5eU5QSXlLOHg5VklFdFhrWGhlT21VbTdm?=
 =?utf-8?B?aE1rOHlMNk8zSzVHaHpETVRqQ3M2Vmp6WDVoenhNUldsbWFwK3N2UFVacm1s?=
 =?utf-8?B?c0hSOVFtRTdSd2hLRSsreXpTcEdHYnFEeHdiUEFhTXpqcUd5NVNiYzhvbFpF?=
 =?utf-8?B?WFdHYTNnSGRTWG5JU3FOMzlaNzUyaE5yMEUwNkIrNERCT3FHNFV2Rlk4M2h5?=
 =?utf-8?B?bUtsOE12ejU0OEh1Vm9Valp2bTE2ZzROYVFRMFJNYnBpeUVHK3ZySWJjTFJi?=
 =?utf-8?B?eDJKd1Bwd3U0RXNwQm9HVXU1ek9ISWM2bGtHUEtXZUs3SmtjT0pSUXVsaVpL?=
 =?utf-8?B?S0xZU2J3dEQvUmgzV2JmK285VWV6UTNnYVB6WTFzS3NuVUUxSWZscDdhYnpa?=
 =?utf-8?B?TEZITHpoK05MMTZiV21selhheW9RRFF4RGtqYW9CL0JpWGJtdmczYmp5MGFG?=
 =?utf-8?B?SytqSWFOc0lDaHlBQnRPNGgxVVRMb2lSU29nSmhjeEY2b2JqT1F5elpDRTdJ?=
 =?utf-8?B?ZUVwRisxMGpMbHJCdFBsUmFDWUpsa1VOU1hNQ0UyMCt0WU9mcHZHUHliMlc3?=
 =?utf-8?B?ZjdNeEY1Z1NKZzN0cXNmbDJ2M0JibDlVM0VmcEJINktnZ1h3TXNBSzgwOXZP?=
 =?utf-8?B?UlJqVXd2djVKWnB3RW8wR2RxcThHL01OcWYvWGw5RFhhV2lEdHh1OFBmcXVx?=
 =?utf-8?B?VDBpMHNCa24wck1HZlA5VFhGWjdXUUJZK0U3NVhIQ25qVGcvVVJNT2JkeXNZ?=
 =?utf-8?B?TUlWdEliL0hrcURyMnJtaVZsZGpUL3NLeXFwUGYwTlZ0VWNGZ3V4cGQ3b0h2?=
 =?utf-8?B?dDcwV0xCTjFFekQzajI1Z0VjL1hjM0VKZlpyNXBlS2xqL1FJWDlOMHFTUUU0?=
 =?utf-8?B?bEovTHNRdEtzNFkrSlNhZmFUV1JYeDhJWFlBUm5tMHRPZTZzd2E3RFg5cDZN?=
 =?utf-8?B?aUNlcHNNY2tSNjdMN05NVDBlcDk0K2xPZ3UzbGtGSFVJODFCWmJMY0REVm5I?=
 =?utf-8?B?TlRhRlRLaEo5ZytBSUJvc0luL0FMcHNLMmNXRXdHaHV0N0xhYmdtNWMwNzB5?=
 =?utf-8?B?TGNmMTQxcW9aK2tsaW8xVEsxZ3p5b1UwbmY4RDRhdFI4dzFPQTVOdEE4aVR5?=
 =?utf-8?B?WVB5NjN2SjdHUlpZbXI4ZTJRODlDMVVDOWpYdVI0N3VkZjZ4SFFjNEROSkR3?=
 =?utf-8?B?K2ZERk9od1o0a3BsU1VJSGZQYXdpeVhsVnVnczZvSlFRWFR6MkMzZjF2NStt?=
 =?utf-8?B?OHIvZHUwZ2N1Wnc0RjBOMktIazdYZXpTbnd2OVpoVkYyK2lxbzhhSk9PS3Fq?=
 =?utf-8?B?Q3NUdmtTVlQyZGRlUGpPMlFsenAvVHV5aXhxdDVhcnhKbDNweUhOai84bHV2?=
 =?utf-8?B?RXd3OFpTWVA5TGQ5eWMxZU1MWklpN2RITzlhMjdVUm1vUERPWW1LUmR1Ny9N?=
 =?utf-8?B?UERFdjJLNysrRVVSb2htVGJBSWdSYmFtV056eUlHYlR2MWZMUElwTnRGbzFF?=
 =?utf-8?B?ckhSUFNjanAvcWI1Q1l0SzFxelVyWFdUeGhOWU1pZHRyZU9lS3RqbEtLbmJU?=
 =?utf-8?B?VSt2dDV3c1A5S29jc2RNRktWSEZFcGFQYVR4UFR1VjhTQ1ByTmZKSTBnT0Jn?=
 =?utf-8?B?RXZ4ZEJMY2hGYXFpNXluZGdNUDl0ZU04aGdkbWROUktkWWVBY1JibkE5KzR5?=
 =?utf-8?B?U21tVUU0c0tGVmt0ZGMvSmdFbDBmSGh6ZGZEWjZaL1ZLNXp2TW1HSVhqQmE3?=
 =?utf-8?B?a2dEc2kyRnhnWlVRRVc1K2xsK0w2aUNMcTN4bGhGazV6VXk4S0lGMzc3a0Jk?=
 =?utf-8?B?RHhxQk9xbUNaTnUzMEdxYXc1STJZTFBkUGtCeTBMVEN2Mlh3dkxiM04yaXZV?=
 =?utf-8?B?T0IwZ2xFdTFHWE1nK0VrY29LcFlvWHhPRnZuK0h0OGJnMXNGR3JXY01EUGpO?=
 =?utf-8?Q?xR7l6WoBsMoeKFCUtbzFWpB/Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193ecc01-2923-4145-7df9-08dc85775013
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 15:51:07.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijJh6P8Y9ptS/+fy7crvvmfq2HQkYNgEJ7vbq8iQZR4A8kweZaMolTTrCeaTTiEshV7LBfKiF7JlcadoNSobZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6871
X-OriginatorOrg: intel.com

PiA+IFdoaWNoIHR5cGVzIGV4YWN0bHkgZG8geW91IG1lYW4gd2hlbiB5b3UncmUgbG9va2luZyBh
dCB0aGUgc2V2ZXJpdGllc1tdDQo+ID4gYXJyYXkgaW4gc2V2ZXJpdHkuYz8NCj4gPg0KPiA+IEFu
ZCB3aGF0IHNjZW5hcmlvIGFyZSB5b3UgdGFsa2luZyBhYm91dD8NCj4gPg0KPiA+IFRvIGdldCBh
biAjTUMgZXhjZXB0aW9uIGFuZCBkZXRlY3Qgb25seSBVQ05BL1NSQU8gZXJyb3JzPyBDYW4gdGhh
dCBldmVuDQo+ID4gaGFwcGVuIG9uIGFueSBoYXJkd2FyZT8NCj4gPg0KPg0KPiBZZXMsIEkgbWVh
biBhbiAjTUMgZXhjZXB0aW9uIGhhcHBlbmVkIGFuZCBkZXRlY3Qgb25seSBsaWtlIFNSQU8gZXJy
b3JzDQo+IGxpa2UgYmVsb3c6DQo+DQo+ICAgICAgICAgIE1DRVNFVigNCj4gICAgICAgICAgICAg
ICAgICBBTywgIkFjdGlvbiBvcHRpb25hbDogbWVtb3J5IHNjcnViYmluZyBlcnJvciIsDQo+ICAg
ICAgICAgICAgICAgICAgU0VSLCBNQVNLKE1DSV9VQ19BUnxNQ0FDT0RfU0NSVUJNU0ssDQo+IE1D
SV9TVEFUVVNfVUN8TUNBQ09EX1NDUlVCKQ0KPiAgICAgICAgICAgICAgICAgICksDQo+ICAgICAg
ICAgIE1DRVNFVigNCj4gICAgICAgICAgICAgICAgICBBTywgIkFjdGlvbiBvcHRpb25hbDogbGFz
dCBsZXZlbCBjYWNoZSB3cml0ZWJhY2sgZXJyb3IiLA0KPiAgICAgICAgICAgICAgICAgIFNFUiwg
TUFTSyhNQ0lfVUNfQVJ8TUNBQ09ELCBNQ0lfU1RBVFVTX1VDfE1DQUNPRF9MM1dCKQ0KPiAgICAg
ICAgICAgICAgICAgICksDQo+DQo+IEkgdGhpbmsgdGhlc2UgZXJyb3JzIGFyZSBhY3R1YWxseSBl
bmNvdW50ZXJlZCBvbiBzb21lIHBsYXRmb3JtcyB0aGF0DQo+IHN1cHBvcnQgdGhlc2UgdHlwZSBv
ZiBlcnJvcnMgcmVwb3J0IHRvIHRoZSAjTUMuDQoNCkludGVsIHNlcnZlcnMgZnJvbSBOZWhhbGVt
IHRocm91Z2ggQ2FzY2FkZSBMYWtlIHJlcG9ydGVkIG1lbW9yeSBjb250cm9sbGVyDQpwYXRyb2wg
c2NydWIgdW5jb3JyZWN0ZWQgZXJyb3Igd2l0aCAjTUMgYW5kIFNSQU8gc2lnbmF0dXJlLg0KDQpJ
Y2VsYWtlIGFuZCBuZXdlciB1c2UgQ01DSSB3aXRoIGEgVUNOQSBzaWduYXR1cmUuDQoNCi1Ub255
DQo=
