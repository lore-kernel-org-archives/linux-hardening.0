Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170D8F5E;
	Tue, 25 Feb 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473130; cv=fail; b=JCE2hbcdARd+GjIH9AyYBhbHMfWiEuHWccu/ARjZgDU0nd9vC0AL3/JiwP176TR0/A1pSt+hAnaLK67frxhwm3TGrkN1EWGRzG+PwjdapGkM49EbWPw+j1+R0qRoK1YRbtQTXkcIDqI3KEPBmhvgtk9Y8zm1amUFAI/6CFjt1To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473130; c=relaxed/simple;
	bh=IvrNMQnzeGt0cf+nBTiWYYj7gPY+NhRT87VXg5iGLBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ip07Y6crc4425P6ZxM5ilxaMshx5h60sM1tmbjALjNShBGHS3jPsBmJXX5lKZdW9lJeWSLjjEzsvuzs1B1XRPxEsYbJh4Z8FRIr7w/VdmOcsfTWyyiquNzs5mkEWSWENgCluSzHEzXt5KuhkhpR0KeykJoj55RbEr1v4pq52HaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKB7CaPo; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKB7CaPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740473128; x=1772009128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=IvrNMQnzeGt0cf+nBTiWYYj7gPY+NhRT87VXg5iGLBQ=;
  b=jKB7CaPoa7gdUf1wzAw3xswgyWf0iVyTOLJtBSC65rfrQB787kgqfyBd
   oSMoe/KMt7rCI18ckLxpLe36gTTja6vKM5uPfYz/Fhs6W6Hr3KitQttAB
   4IzwNZ6Hkg9Hx1o8ZY9P6RKxjcVdQy33li4Fg6zgIFCB2K4tWRmydjUwj
   yMr6gVpdBlhrt4AdTSFTVIItMqpa6ESorRp7OttTJcdsmERCQc4rhw9k9
   H4eVtEgT8Bwwe7MSwg2EfzIDPyna+sIi31aQmI90JjztzANKPdJ8SN8KM
   u1r0lz12/uEhQe2HkisOKYzcOE8u/M0InIOrwP4EfCwN5d5W5Dt0cud2+
   w==;
X-CSE-ConnectionGUID: waBkPJjnQiqciBi7cZM9QQ==
X-CSE-MsgGUID: HkEj6ouUTDuACkVtoKlmNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52691902"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52691902"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:45:27 -0800
X-CSE-ConnectionGUID: P5U8RmcpQcShrS2K2BbBaw==
X-CSE-MsgGUID: 6KoTpHrMRgKJ3KAvmEW0lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121422852"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 00:45:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 00:45:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 00:45:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 00:45:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r58FRR1QmbA16yoezN22m0BW0EtFqUdKW8cJKUAb2119GcSeHUXJN9FDY0BOPU6unc1sgluf9OR4TiRFUzy7Vw22//bZqJpF/QJE2RCj7GrRXSqihxiixw8smkyY5v7apI4olL/u7HqOi//UuUW7LJEo99KL0A28DFjqMMOBzyHBbhhQGcclvW7bsujEXxqAc8zRWGpfisgm/1ewJB+G2X8Fdlu2RRmdQo/QdlcThN8eNIcWk20lkKfHtIanDVroJHbSh+c0eCwVyWE0a2/wi2Vu4zUWuX5MRdl0rFpc6ld3Ui/gYGArRhkdgqPmHw8c63OB+vO6VMCeAL09EVlvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTyEnl6fC7tOFoU3Pm8qQvMu+7UxAyRQRRrPsGw+Iyg=;
 b=ucrcPPDMGuRKVbeoTYpRh2mObmK1YLzr7fD4xYttKULFKT8i31Kfo7cUB9Su9YvIj47kBnwT4C27UAcA/zEgqvhgbaEz1nbpE82N4DL5KiA4+67/zicC1cV4R94Asy6WJuRQaB2MR7KkNzYE7kakTgWrkLQJ7d26VUaC95xESqWtM1sExM9YyNZk7vbzDnvGPjor/E+0jX2XTIy9KeT2soBB8gvWFM+drBKcbYb+cK7JFR8ArFZfaoLb69de5UIJZ6b3igllRc2xF8yJXGH+WcVqDIETGiPEWOoTHkPRUwW0r8Vs1BEiNNXfrqlcoNIaOhxdvW9PicM40EDGmzmXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by CH3PR11MB7347.namprd11.prod.outlook.com (2603:10b6:610:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Tue, 25 Feb
 2025 08:45:21 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%6]) with mapi id 15.20.8466.015; Tue, 25 Feb 2025
 08:45:21 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "jeffxu@chromium.org" <jeffxu@chromium.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>
CC: "Jason@zx2c4.com" <Jason@zx2c4.com>, "adobriyan@gmail.com"
	<adobriyan@gmail.com>, "deller@gmx.de" <deller@gmx.de>, "gerg@kernel.org"
	<gerg@kernel.org>, "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"davem@davemloft.net" <davem@davemloft.net>, "avagin@gmail.com"
	<avagin@gmail.com>, "mhocko@suse.com" <mhocko@suse.com>, "enh@google.com"
	<enh@google.com>, "thomas.weissschuh@linutronix.de"
	<thomas.weissschuh@linutronix.de>, "hch@lst.de" <hch@lst.de>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "adhemerval.zanella@linaro.org"
	<adhemerval.zanella@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"jannh@google.com" <jannh@google.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "sroettger@google.com" <sroettger@google.com>,
	"ardb@google.com" <ardb@google.com>, "jorgelo@chromium.org"
	<jorgelo@chromium.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "oleg@redhat.com"
	<oleg@redhat.com>, "willy@infradead.org" <willy@infradead.org>,
	"keescook@chromium.org" <keescook@chromium.org>, "peterx@redhat.com"
	<peterx@redhat.com>, "mike.rapoport@gmail.com" <mike.rapoport@gmail.com>,
	"mingo@kernel.org" <mingo@kernel.org>, "rientjes@google.com"
	<rientjes@google.com>, "groeck@chromium.org" <groeck@chromium.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "aleksandr.mikhalitsyn@canonical.com"
	<aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
Thread-Topic: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
Thread-Index: AQHbhw7e6GQ3vkFOGEGjKNRZzyOU87NXjQuAgAAoCYA=
Date: Tue, 25 Feb 2025 08:45:21 +0000
Message-ID: <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
	 <20250224225246.3712295-6-jeffxu@google.com>
	 <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local>
In-Reply-To: <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|CH3PR11MB7347:EE_
x-ms-office365-filtering-correlation-id: 85c53939-51f2-43a1-247c-08dd5578bd4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N0hvRUVYTm91K3pwSHcvVjN6eVRrelNHMFlEOTRaVVZQL1VIQ3M3SE8renFT?=
 =?utf-8?B?M1RzRVI2MUpiYkptaVdEcXZxZmdnWVI5SUU3OFRRZTl0SHVjRWdtRnM2S0l1?=
 =?utf-8?B?R3BLTkF2THNRa1Q2cXVJWVVWSXdRU3lhUVNRNkVGZlhDVm1CclZ6elVVUHo0?=
 =?utf-8?B?RUZtL3poT0tYWmpobTNwZ0l3RVRBeG9uWkdabm9iSnhuRmtOU3hnbjh5WmVL?=
 =?utf-8?B?VGhpNlNoUlBnYjFIcjJrcU5xWWZIWk9lVDllUGdSaU1nbVhEa2ppSm9UYmcz?=
 =?utf-8?B?SEdaTVE4S2dpZ0lwWk5LOWFSenpDYTdSdmh0NDE1SnQ5N0F2dU1QaExIUlRh?=
 =?utf-8?B?a0pLdi9WOExlcDZNNUYvdzFZREwwVC80aExNaEQzT01Fbm5VamdaVFFWTnZz?=
 =?utf-8?B?bnNQVG5BVUJQMitYSGprbmlvZW9MQWdFblI1Z1hyR0laTy9TbVZpaTZMS05l?=
 =?utf-8?B?c0RIb25YRS82VmdhOTdyOVROQmMzVnErSkFKVFRCL0NGcnhmVC9zaVQvMWNw?=
 =?utf-8?B?YVlRRzU5ZTRsb2g5UW1VREZINnpjVHlhb2tDVko4MVBkSWVDYUFHSE8zOFpP?=
 =?utf-8?B?OCtUczVpRkgzWklHb09kR2FRY2RTQnpFcGppeUV3QXVZL0pnV3NQRXdYUWhF?=
 =?utf-8?B?dGtHUm9XVmpCWnVzbE41K0FsR3hIc1ZnWXpZRFU0a1B3MGNTdityMXlrYVJ4?=
 =?utf-8?B?a1k4UkE3TzNyRWFkR1hHeU1YeURiSStsK2c2ZnhmcFFiL3BNYUZVbEdwcXow?=
 =?utf-8?B?T2w1ZXJFS1A3cG9QUmpZOUdWRG1EaHo0OURrdzVOSFFWSHhmU21kN3JmZVV1?=
 =?utf-8?B?cUh3MG5FeE50U1o3OG1ldXpCZVBEeHBlbG5qYy96WEx1V25NWjYzNHh4aEJm?=
 =?utf-8?B?ZENFelJvSVcwWGFPTnNrVHRUT3hzKzEzaTNOcWQ1MG5Nd0t2RjVpRk96bUtr?=
 =?utf-8?B?YzA3RnBPMTdwK04ySkIwK3FvdFFCcUJnalVkTDRIQ0MyaW1QVVlKZ0U5NXVm?=
 =?utf-8?B?elF2TmkrVEY2MGNzenozTXVjNEhiS05jU3E4RldZekJ0cE1Ua3NnN2lyZDN0?=
 =?utf-8?B?TXdrVnBveXlGZFFXNjRMVVlMeWpJcFpRdUZTTUZLNzVld1FFQjJjbnFIY0xM?=
 =?utf-8?B?eG8vUUk5K2ZJNzZWT3hjRlczdUFjcE9URjlGTE1TSWUxYjJoWUxBTHZodi9p?=
 =?utf-8?B?SHFDTnpxdUdBczJwOXloOVV2MFlrRmJ3dzF5QlhzS3ZhcmZiaU5GZ3pYd1Na?=
 =?utf-8?B?ejh6RkVaTXNDU0FzQ2FoVStQL2VUZXB4SWk5c0RQdGdrS1ljb2VJeWpISDBy?=
 =?utf-8?B?SE45cGpMQ2I2VGtNeTYwc1hRR3g3NWVHZmJVV1N4eVF0cWQvKzd2NmhRbXJs?=
 =?utf-8?B?SUNUOUlXcmxycGFmeExlbExwVWIwbXhMQ0tDd0pvdTc2Qmh6WU1OQXgyTEEz?=
 =?utf-8?B?SGVTZk5WamdTQmErUDFaVDRLcTh5TFBJckpQcUNxc092WFZ4bVFiM2NqUTVN?=
 =?utf-8?B?RXlPREZjZ0VjeG85aG1SVnBzeHA5NURiRWNONkx1b1lHdXBOVCt4RjdVT2tL?=
 =?utf-8?B?WnA0NzFXZW5ZWVlPZHZuc3hZK1IyWmNYYjBvYWJjWEtzTklwR2Z5NnE1S0Fl?=
 =?utf-8?B?VHg0cTJjMG9lYUFSR3hpUlBMK0RnVFJ1SkNvVndTMlliMHlqK2p0N2IwWmpx?=
 =?utf-8?B?ZGNPZW0wcnJxL3dqeXdDRkFVcFN3ZGJPNlhiR2ZvSGFhQnBoc2R1d1lXRkVt?=
 =?utf-8?B?Mjl0UW5JTkdCUUs1UWM3RXNPcFN3V2ErcCtqM2F5VzIzRnc4UE8yaU9OWmFa?=
 =?utf-8?B?Q0krMnFscDhBTnlrRldxYkxXK1IrL3JPUTBTQ0JSaGRaOHNPVWw3bm9ObWM1?=
 =?utf-8?B?NW92QWZBWTZUVTZVSmc3SzU5cVVMS25zMUg4bDZhc3hZek9pMWZydDF6eUJC?=
 =?utf-8?Q?QqI9xFwY+IkohXqkFHOgM6Wf/4sjHiwL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjJUdThTcFNvVkNzTG1JbCtLOEF3STRTYTlQVVdwMlJxS0pkTHJHMVUwN1hh?=
 =?utf-8?B?S3hGVFlnZ0VkbnVNUWdtckMrZ01Wd2RLaDBrRzk3aURyblVoNHVGVmJaa0FX?=
 =?utf-8?B?bE43YUFubVF3UHlVL3J4V3RoaG5GU0NoSklseG5mMzhtNlEyUmk0MDk1N0dW?=
 =?utf-8?B?UGlhdDNNelZmVFV5RnZ1bGJaOVRmdk4zNVVEcW92emZrTWJqTVBSYUdLL2Vi?=
 =?utf-8?B?MWtKNjlYZTFMY2ZVRllIdFVmNVRXa1hDQ0FiVmxtdXozZjJXcUZrQ0dYbjIy?=
 =?utf-8?B?TmhsckpZM2VwZ3YzVmVoNFBEcEkwc1BTZEZEcXdKemNTdFRocVN2ZUpUSkVW?=
 =?utf-8?B?MHhLZURyT3p6cHBKRmNLSVoyMWZoNzZXY3BOQzhMTkRVR2h5RGE3dkVLUFlU?=
 =?utf-8?B?eURtTHBKQnpLTDQwU29TTHJiZGY2ZkVqMnR0NDFmRktrSHdtMDArOGxueVgz?=
 =?utf-8?B?cHZsdFliamYwNDJjeXd0K3NNVnB6VXZYc05sRTFlQys1OElSZ1pRZ0pZTFps?=
 =?utf-8?B?Z2NwZFRvZ2RlSm1IZEtHajlqWXY3VG5mMlUwZDVKekFpOHR6YUIxMlV2Q1p1?=
 =?utf-8?B?N1I1MFZyaUZVVlQvczBwbmlRRFJOU3RMZjNaM2VMakxzdHlQdU50b01FQTUw?=
 =?utf-8?B?bkZCR0hsMklaWjV5Nklndm1rWlZBdXpYdWxkaC9wQkJiTE9ZZHJnTDI4bVVm?=
 =?utf-8?B?ZGdqUHEyak4wSS9PMzdXN3ZkUTVNRW1pMWFzSkxNai85OURXTDB5dGd0NzlI?=
 =?utf-8?B?cGhmMmEyYzBLcG1SKzU4U01RMEtJRHdPNWlKKzYvODB0bXp0OGZpRHBNTUdN?=
 =?utf-8?B?RnhYSjB6MlROV3ladGN0WVpCZ1puU2ZnN2NCVThVYmwrWGl5VUo2ZXhTdVJm?=
 =?utf-8?B?RktTUzAzWlZCbFZsNnNITzF5UHFwdXVvRjRzbk8wMHo3cWRaV0tXb2hiVjE1?=
 =?utf-8?B?SmQ3VjVsa3dKdzNFVzJRNUVHSGRxYjM5d0s1dWxiK1dKUUdIYkt6T281TEQ1?=
 =?utf-8?B?TTNwYVdvYW9aZjJWbFA1YTI5c29FcUZSaU53bjFmMlhJR2tqTmZQYm43Y3pj?=
 =?utf-8?B?K2pjdWhUekJzc1ZkeTR3S2x6NjM3R0ZTWEVqZzZLbGZTdmxJRTUrRUdiSXZK?=
 =?utf-8?B?ckw2cGliQ08yTjFucWVXd0ZMOXp6L0dTL1dSQTFSaVNQSVh2cnYxOG1Tazk3?=
 =?utf-8?B?Z003YS8rZHAzZnNuSndaYndvWlNUZ0RFY2g4Uk1nNVZycytqVGhzbGZ0TG8y?=
 =?utf-8?B?RHBaUkxZOFZFMGNLRi9PMmpzV1Y1cDBlbStYandXQkU5VmMrRGM3dEpYOXhy?=
 =?utf-8?B?Qkg4OHNlanFVTGRxNHJmLzBnOFloeThKL3ptWWFyRm5tSW1iWk0wMVlTcVh1?=
 =?utf-8?B?V2FlYnJWMDlIVzRaZ1p1RnRaa3ViTG1ZVkVsUXdpTlFpcVBMWjMvM0hDNnFm?=
 =?utf-8?B?dks0ZlpIeDZPeFBrOVlxeS9TNk0wSi9DYVM0M2ZQNkt3K3VlTTdQbjBWT1pH?=
 =?utf-8?B?MGJTWlZ2SFhPazl4Vkg4dExkb01Sdzh6OURHOVZibEorUkV6a2hnbm1xeFll?=
 =?utf-8?B?TVNEekRKNmxXZElYTE1rOWVVbit4Z01MWEVXRUxJMTRIaEd6VDRQOURZYVFW?=
 =?utf-8?B?WU1ab1R3WHE4V0FIc09wL1JacjdJcGwxS0hrVFN1R09kd1JtQkpUanZ2N1Uw?=
 =?utf-8?B?SjNqOEdpZjdXcElFTnV2Y3R5MzRZVG5CVFdMZkl3ZHhHYkdPZlRYVVlNcnlz?=
 =?utf-8?B?WXkzcFY2T3J3aWgxSlVub2Erb21qWW1ISlVOeW9iR0h1WWd4NmM2aUhra09N?=
 =?utf-8?B?dXYzNnJEMUUvZTh5S2hpdEwyNUQ0dFpGYUhjc001MHlZa0dsTGtuR3VQUFI1?=
 =?utf-8?B?U3F2Y2hYNi9vVDN6VW5kK2pTSmZFSnA1QjkvWEc2Ri9iN0pwMWQvR3lxa0pU?=
 =?utf-8?B?Nkh2QlR5Vk81K3JqRXJyMjJWbEFFN0hRTHpCb2lvMzlidExPWk1pcUJ4WDhq?=
 =?utf-8?B?VVBFTFF0UDRxRTRncVlZQm1JUzJLVDIvZEZoTzJZN0JXbnlZTlFtcGdVaE5X?=
 =?utf-8?B?V2RlYytaMExQdUJTK2l4ejgxZkE4VklIWnB5dEgraXJubmdDclZBNnNWby9I?=
 =?utf-8?B?UVZMYWRrM3BXejB5Si81dk5idElpODhtR3lFL1RTclkvYy9ma0tOejcxVVpr?=
 =?utf-8?B?WCtJUGtKVnJJdVBZM0FvdnBYRzR1WmNmY0JTZTRZNG5FQlFwRFpRVjdnb21M?=
 =?utf-8?B?M0RRTXpFa3Jwc1E1NWZpblptS3RRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BFB2BA47CA92B45B61BDDE9A8CFF05D@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c53939-51f2-43a1-247c-08dd5578bd4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 08:45:21.6377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJgs7ZKyxS1p3hbSK6oRrfhIRjAqmsSOkm6WgnEo6xx9AdMrCRYKCxwWpusC/ZdEj+CNuFUFJXCPWKQcG7buxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7347
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGksDQoNCk9uIFR1ZSwgMjAyNS0wMi0yNSBhdCAwNjoyMiArMDAwMCwgTG9yZW56byBTdG9ha2Vz
IHdyb3RlOg0KPiBPbiBNb24sIEZlYiAyNCwgMjAyNSBhdCAxMDo1Mjo0NFBNICswMDAwLCBqZWZm
eHVAY2hyb21pdW0ub3JnwqB3cm90ZToNCj4gPiBGcm9tOiBKZWZmIFh1IDxqZWZmeHVAY2hyb21p
dW0ub3JnPg0KPiA+IA0KPiA+IFByb3ZpZGUgc3VwcG9ydCBmb3IgQ09ORklHX01TRUFMX1NZU1RF
TV9NQVBQSU5HUyBvbiBVTUwsIGNvdmVyaW5nDQo+ID4gdGhlIHZkc28uDQo+ID4gDQo+ID4gVGVz
dGluZyBwYXNzZXMgb24gVU1MLg0KPiANCj4gTWF5YmUgZXhwYW5kIG9uIHRoaXMgYnkgc3RhdGlu
ZyB0aGF0IGl0IGhhcyBiZWVuIGNvbmZpcm1lZCBieSBCZW5qYW1pbiAoSQ0KPiBfYmVsaWV2ZV8p
IHRoYXQgVU1MIGhhcyBubyBuZWVkIGZvciBwcm9ibGVtYXRpYyByZWxvY2F0aW9uIHNvIHRoaXMg
aXMga25vd24gdG8NCj4gYmUgZ29vZC4NCg0KSSBtYXkgd2VsbCBiZSBtaXNyZWFkaW5nIHRoaXMg
bWVzc2FnZSwgYnV0IHRoaXMgc291bmRzIHRvIG1lIHRoYXQgdGhpcw0KaXMgYSBtaXNpbnRlcnBy
ZXRhdGlvbi4gU28sIGp1c3QgdG8gY2xhcmlmeSBpbiBjYXNlIHRoYXQgaXMgbmVlZGVkLg0KDQpD
T05GSUdfTVNFQUxfU1lTVEVNX01BUFBJTkdTIGRvZXMgd29yayBmaW5lIGZvciB0aGUgVU1MIGtl
cm5lbC4NCkhvd2V2ZXIsIHRoZSBVTUwga2VybmVsIGlzIGEgbm9ybWFsIHVzZXJzcGFjZSBhcHBs
aWNhdGlvbiBpdHNlbGYgYW5kDQpmb3IgdGhpcyBhcHBsaWNhdGlvbiB0byBydW4sIHRoZSBob3N0
IGtlcm5lbCBtdXN0IGhhdmUgdGhlIGZlYXR1cmUNCmRpc2FibGVkLg0KDQpTbywgVU1MIHN1cHBv
cnRzIHRoZSBmZWF0dXJlLiBCdXQgaXQgc3RpbGwgKmNhbm5vdCogcnVuIG9uIGEgaG9zdA0KbWFj
aGluZSB0aGF0IGhhcyB0aGUgZmVhdHVyZSBlbmFibGVkLg0KDQpCZW5qYW1pbg0KDQo+IA0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEplZmYgWHUgPGplZmZ4dUBjaHJvbWl1bS5vcmc+DQo+ID4g
VGVzdGVkLWJ5OiBCZW5qYW1pbiBCZXJnIDxiZW5qYW1pbi5iZXJnQGludGVsLmNvbT4NCj4gDQo+
IEFueXdheSBJIGtub3cgVU1MIGhhcyBhdCBhbnkgcmF0ZSBiZWVuIGNvbmZpcm1lZCB0byBiZSBn
b29kIHRvIGdvICsNCj4gcGF0Y2ggbG9va3MNCj4gZmluZSwgc286DQo+IA0KPiBSZXZpZXdlZC1i
eTogTG9yZW56byBTdG9ha2VzIDxsb3JlbnpvLnN0b2FrZXNAb3JhY2xlLmNvbT4NCj4gDQo+ID4g
LS0tDQo+ID4gwqBhcmNoL3VtL0tjb25maWfCoMKgwqDCoMKgwqDCoCB8IDEgKw0KPiA+IMKgYXJj
aC94ODYvdW0vdmRzby92bWEuYyB8IDYgKysrKy0tDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC91bS9LY29uZmlnIGIvYXJjaC91bS9LY29uZmlnDQo+ID4gaW5kZXggMTgwNTFiMWNmY2UwLi5l
YjJkNDM5YTUzMzQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC91bS9LY29uZmlnDQo+ID4gKysrIGIv
YXJjaC91bS9LY29uZmlnDQo+ID4gQEAgLTEwLDYgKzEwLDcgQEAgY29uZmlnIFVNTA0KPiA+IMKg
CXNlbGVjdCBBUkNIX0hBU19GT1JUSUZZX1NPVVJDRQ0KPiA+IMKgCXNlbGVjdCBBUkNIX0hBU19H
Q09WX1BST0ZJTEVfQUxMDQo+ID4gwqAJc2VsZWN0IEFSQ0hfSEFTX0tDT1YNCj4gPiArCXNlbGVj
dCBBUkNIX0hBU19NU0VBTF9TWVNURU1fTUFQUElOR1MNCj4gPiDCoAlzZWxlY3QgQVJDSF9IQVNf
U1RSTkNQWV9GUk9NX1VTRVINCj4gPiDCoAlzZWxlY3QgQVJDSF9IQVNfU1RSTkxFTl9VU0VSDQo+
ID4gwqAJc2VsZWN0IEhBVkVfQVJDSF9BVURJVFNZU0NBTEwNCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvdW0vdmRzby92bWEuYyBiL2FyY2gveDg2L3VtL3Zkc28vdm1hLmMNCj4gPiBpbmRleCBm
MjM4ZjdiMzNjZGQuLmZkZmJhODU4ZmZjOSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni91bS92
ZHNvL3ZtYS5jDQo+ID4gKysrIGIvYXJjaC94ODYvdW0vdmRzby92bWEuYw0KPiA+IEBAIC01NCw2
ICs1NCw3IEBAIGludCBhcmNoX3NldHVwX2FkZGl0aW9uYWxfcGFnZXMoc3RydWN0DQo+ID4gbGlu
dXhfYmlucHJtICpicHJtLCBpbnQgdXNlc19pbnRlcnApDQo+ID4gwqB7DQo+ID4gwqAJc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWE7DQo+ID4gwqAJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJy
ZW50LT5tbTsNCj4gPiArCXVuc2lnbmVkIGxvbmcgdm1fZmxhZ3M7DQo+ID4gwqAJc3RhdGljIHN0
cnVjdCB2bV9zcGVjaWFsX21hcHBpbmcgdmRzb19tYXBwaW5nID0gew0KPiA+IMKgCQkubmFtZSA9
ICJbdmRzb10iLA0KPiA+IMKgCX07DQo+ID4gQEAgLTY1LDkgKzY2LDEwIEBAIGludCBhcmNoX3Nl
dHVwX2FkZGl0aW9uYWxfcGFnZXMoc3RydWN0DQo+ID4gbGludXhfYmlucHJtICpicHJtLCBpbnQg
dXNlc19pbnRlcnApDQo+ID4gwqAJCXJldHVybiAtRUlOVFI7DQo+ID4gDQo+ID4gwqAJdmRzb19t
YXBwaW5nLnBhZ2VzID0gdmRzb3A7DQo+ID4gKwl2bV9mbGFncyA9DQo+ID4gVk1fUkVBRHxWTV9F
WEVDfFZNX01BWVJFQUR8Vk1fTUFZV1JJVEV8Vk1fTUFZRVhFQzsNCj4gPiArCXZtX2ZsYWdzIHw9
IFZNX1NFQUxFRF9TWVNNQVA7DQo+ID4gwqAJdm1hID0gX2luc3RhbGxfc3BlY2lhbF9tYXBwaW5n
KG1tLCB1bV92ZHNvX2FkZHIsDQo+ID4gUEFHRV9TSVpFLA0KPiA+IC0JCVZNX1JFQUR8Vk1fRVhF
Q3wNCj4gPiAtCQlWTV9NQVlSRUFEfFZNX01BWVdSSVRFfFZNX01BWUVYRUMsDQo+ID4gKwkJdm1f
ZmxhZ3MsDQo+ID4gwqAJCSZ2ZHNvX21hcHBpbmcpOw0KPiA+IA0KPiA+IMKgCW1tYXBfd3JpdGVf
dW5sb2NrKG1tKTsNCj4gPiAtLQ0KPiA+IDIuNDguMS42NTguZzQ3NjcyNjZlYjQtZ29vZw0KPiA+
IA0KDQpJbnRlbCBEZXV0c2NobGFuZCBHbWJIDQpSZWdpc3RlcmVkIEFkZHJlc3M6IEFtIENhbXBl
b24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQ0KVGVsOiArNDkgODkgOTkgODg1My0wLCB3
d3cuaW50ZWwuZGUNCk1hbmFnaW5nIERpcmVjdG9yczogU2VhbiBGZW5uZWxseSwgSmVmZnJleSBT
Y2huZWlkZXJtYW4sIFRpZmZhbnkgRG9vbiBTaWx2YQ0KQ2hhaXJwZXJzb24gb2YgdGhlIFN1cGVy
dmlzb3J5IEJvYXJkOiBOaWNvbGUgTGF1DQpSZWdpc3RlcmVkIE9mZmljZTogTXVuaWNoDQpDb21t
ZXJjaWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIgMTg2OTI4Cg==

