Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCE199236;
	Thu,  6 Jun 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693211; cv=fail; b=QgJ1ydIrTjoLvpMDkU32LnRBsmuZhzJkAMCF9poR5nb/AHRN59vPlGMEjZ33cmEBJzWeMrkHsZ7wGbptEoJgPips2FBSakmt9kAnYXVq3KT1d8Mwel8DPmH/HBt/cK/HhX65L2NStzT69pu/TdIU57gjS3PeH21Hxf6BJ8afbiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693211; c=relaxed/simple;
	bh=bjJ9sYjsj7G2/TT4SL9l0Fl8AMMoqsRXzoS/BUlIiu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TGlPZ3S3X/yJ+Hy/3oTyZX5Kbn+81K4br1LJOLJwfbSiH/pucHbazAaPeZ/obmhOEhJ5ozWrfQgcRJwM6xlgRlDGaERgC6AmP/jtVqO7IXpfcAJ3Lli6vAwO67gT3IICxVlf1lEHdQ053OcePKz8HGe+iJ+EBm7PrZPxprsHCfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mp6ZeJay; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mp6ZeJay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717693210; x=1749229210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bjJ9sYjsj7G2/TT4SL9l0Fl8AMMoqsRXzoS/BUlIiu4=;
  b=Mp6ZeJaya1SwrwcXHCRpGhAms1ZN76jlM3O2Cu+pqKgrw7DP6yqZQ9OK
   yY/nfG72k/hELcOOV9gsrWUmFtrGZAYnSgv+Z69xKVHMM0Rq7ubgNcw+b
   PDUBeFQqZcYLyx21dQv4tfXLDMErP86ouHENc+opN53917YIrZnDgPCJF
   +la9WB6zyciOsbBdCk8JMwGCo9K9u05RHjC9dZ1JCq2fnlqjzCeGaAOZy
   WqY8gxclAAtYAim0KYTxi5b/AJr6CUnBrQEbdWvy9jJrNcbk6+nsCYI1Q
   aDAJmf/iE+B9Xl0l+wuldd9jQczSSU5BwsSZqgl9rz0Or1787pXgemw00
   Q==;
X-CSE-ConnectionGUID: mD/aAYtPSMaZCxVh4062EA==
X-CSE-MsgGUID: lpaYphoDSoqfA2BMBLPuQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18228925"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="18228925"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 10:00:09 -0700
X-CSE-ConnectionGUID: SDSuGIt0Q2meOz4SQgG8lA==
X-CSE-MsgGUID: Jvw0/Pq0RZKE/Q43q4e6OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="68824232"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 10:00:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 10:00:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 10:00:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 10:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/I28VdqIqr8q5snPgeRext4bh26008oONGd+0AstmRjMmiGge7lFJbqGuDgOh7ppgPK58/5/FCH9XRi1ITQTkVM9KjeKUFTmQcXp3Wq1PvzUCzLkjB4Kbt4Q8AMDiW1QsS6UUSVMcWatjHt9asSIRb0FDV4TnXQOOkaq2TO7yEFnbVTvTgKclMSdkcjIT07ZJ2A//TInMlX93v3Fk3Rc2GOHfAIozTLwtPadmUALonecHriDLIpQ+7mvXJ2bffHm1y/RsjL3HWs9SeMrUHBALlHpI88RgNYVxDhd8v19K6lhezxwaCbNgc/oLo7az4KtMg+LxKariRmlw5SjU8/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjJ9sYjsj7G2/TT4SL9l0Fl8AMMoqsRXzoS/BUlIiu4=;
 b=B9wtIm00eaIcVucrFBTBI3U7S12y9BlMygr1j6/D0/IVQo49EXB3lnXZMpYGJJ9do4yz3P8y09qNBDDZjyQSrPi9flWGs2DWboguje8OmsBDXRYEXgbOzm/5BCRVs6BBJIsPYsIXKRtqPFo5oW1dNzI88RUqK3MaX8Z4O7bzp+FkwoakWsdcTB/it0ZD0vkWOT2ewf2lz3HFbKPD+q0AB/dbOLhhiVuypOXUo2K6rvhlmN5NBTiW5X0fjA6R8Hae3KlSY7MVstco+h9kHbMvcoJSRy1HC4suJqY8zDhv+NA6N1miU3WwtnTBznaC1uz+Djws43fmiQrlTz3piXiMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4895.namprd11.prod.outlook.com (2603:10b6:a03:2de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 17:00:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7633.018; Thu, 6 Jun 2024
 17:00:05 +0000
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
Thread-Index: AQHasMnDpgSqt6YvJEilDwQwXTRTp7Gssl0AgACEYoCAABNcgIAAi+WAgArqMgCAADXRgIAACX6AgAAXRICAAAg8AIAAPwnggAEb6QCAAImKwA==
Date: Thu, 6 Jun 2024 17:00:05 +0000
Message-ID: <SJ1PR11MB60833D3AEB9E79EDD60AB3CFFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
 <87le3t9i8c.ffs@tglx> <0aff3f62-a8a5-4358-ae3f-2ded339aface@zhaoxin.com>
 <20240605093609.GCZmAxidNIBP5bkDcX@fat_crate.local>
 <e4f307dd-3264-45f6-82eb-0102f7fb99d7@zhaoxin.com>
 <20240605113323.GFZmBNA7ec2s191_2w@fat_crate.local>
 <46741fad-425c-4ed2-97be-3f2679da63eb@zhaoxin.com>
 <SJ1PR11MB60833ACD1E6C946F72C58736FCF92@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d4079e9f-07cf-4893-9fc5-5d319b592aa5@zhaoxin.com>
In-Reply-To: <d4079e9f-07cf-4893-9fc5-5d319b592aa5@zhaoxin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4895:EE_
x-ms-office365-filtering-correlation-id: 060c0741-3e4b-48df-c4c3-08dc864a1d2f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?K0RVYStkRXp3LzVxbVU4OGhhbnBDNmZTQWFFTFJiMXZZM0tUWXIvOWlFSEpO?=
 =?utf-8?B?d3M2RnIycVNIMmVNQTY4MW5sNGk4UFdJOGE5VXg0S2pIbHNRbXBzc3ZSSVRD?=
 =?utf-8?B?TDlHV25ZSGlPT3lITTFkNHF3S3pQWS9uRnZxZXo0azQrbXArVnl3c3RCaXpl?=
 =?utf-8?B?VVBLQkFvbEdmUmFRUFdvQjJOelQ4YlpDRE13QWtwcmVjRVhEMnJhb0ZRTXhv?=
 =?utf-8?B?ZjgxVXZESXAyeHdtQkkzZGE1VkJNTDRVNm9EaHR0eUVrSlhZSWpOWllESHA1?=
 =?utf-8?B?L25wS2loMXI3bCtwVGVMSHJtMm1VZWNaUXEyS0FqVGtZUWk3Ly80UXlFd0Ri?=
 =?utf-8?B?T0cvem40WGxPL3JhVGpSRVA3aThBYlNZV2tHY2ZrQ3BLUFpRQ0RuZnRVSFF0?=
 =?utf-8?B?dGJqNURrRjNMakpHZk5GYUF0SUZMNmNlV2VlRDBWVmJEVEVpdm5ZOEV4NHFq?=
 =?utf-8?B?VDNBUVpWaDNzMGpuUmIzc3ZlRFFHRWlFa1ptRzdFek03dDQ2WSt2VXBQNkM2?=
 =?utf-8?B?VkN3VFAvckF2cFBXRjZTMElnWGZoczhkblhhUHFEaHpTQ2VXaXlaakRJRnZE?=
 =?utf-8?B?WnNYcXlMQ3gyTmxBZ1ZWc2dFOURVWFJlQkFtRGlvMmVINUFXclNUM1ErR3J4?=
 =?utf-8?B?NzhydXcxWllrS1IwZmJtalgwWU1ML1JBb1ZJdnlXRk1idi9BSnZYNHFzWUpX?=
 =?utf-8?B?MTljVDJscVhvVjdyVFJuS2NjRFNNMVRVNjdNd0lxdXZtekVtUEtyamNkdXRR?=
 =?utf-8?B?emhKd1pEWVUra1daWFFxOVhiUVZGY0hjQVUwYmpSVXg5YUhEUzNFajNRakty?=
 =?utf-8?B?TGh0cllZOGJEU3I1NkNaRHVFRzJYYytHZE01Wm95UURZNzV5OURDd25tUHdB?=
 =?utf-8?B?UzVRK05uZnBUeGFIZm94SWVhUndKMXJwNVV0QzVxMzhNQmZlOU5VbDJhaTVJ?=
 =?utf-8?B?WG91YnpvcnpSd3BmVDJYMzhmeG9PVjJRWUFkTnR0UlQzbE1BOExRYUxjeTFv?=
 =?utf-8?B?U3FibVVxazBnVVQ0bmxZNXA0bmZMa3dhSWtTNGVxZVRrcWcwY04vUHVaSTZP?=
 =?utf-8?B?SEN3Yjh2c1A0ZmZTNVR2U1dWbDYrbm1ETW03SzVRQ05VYWJNa0Q5b29XaDJR?=
 =?utf-8?B?V3dxanFCcUdOaDBEcXJOekZpMlZzbG1Mblp3dHkzbzA1ejk5WG5lTUl1cVQ3?=
 =?utf-8?B?RlVFYUNTb3RqU1VrWnhBdnk0ODM1WDJ4UEVTcW1IYUErcFBqOWtrWmlrU3oy?=
 =?utf-8?B?L3FPbWgwYTZKTDUwVVh1QjUrWnFhUFR3M2ZhYXA5dE5KRWFJM1loeWRVZ0tO?=
 =?utf-8?B?aE9YaWMyc21CUHdOdVlkV3hrUFRYVHVZMU9TWHJTRm10TExIT3BSRDZIK3BN?=
 =?utf-8?B?TmNzRHVta2IxV3B1YnBwclQzSFpyaVhibE1TRE95RjVzVWVKMXE2dGRHME9w?=
 =?utf-8?B?aC82V2NxZm5OZGVwWnJhV1FHYklmdjRYUDBuL09UYVorcjB4czZLOU1xSlBh?=
 =?utf-8?B?MXJOQlp5V2dlR3NPZ2wwalI5Q3JweVhKbFlBeGxuMzFOaGRPQUVVMk9Va3BU?=
 =?utf-8?B?RnZwQzBtb29DeHZjUG1NME1md1Vydk95QmhLSUU3d2NhMlhoM0N5dGFPU2Rs?=
 =?utf-8?B?akVpZ25aLy82UTFmOGdwVnl3K2NRYlNnTlN6eEhRL1Z6TVFQc1NDQTFvajNu?=
 =?utf-8?B?RVNhWHA1UXRFTU5jenlBVktiV3U0NEpnck5waDFRTWVRK1NUaFlxbk44dG4y?=
 =?utf-8?B?NUlNbDA5QTV2SDlXY0I5d21qZjRxd000L3FRZGdMWGlBQWhIbVExazJqQnJU?=
 =?utf-8?Q?AAZnsatf4/ttNI4DDO6SL/TxaLWC8NlqaDHCs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzBpcDhLTXJzUzF5eUI0Wm9UelNvalZ2aHY5eTZjd3lHeWhveXFwL2V0NER0?=
 =?utf-8?B?U1YvdzN6WUhheWZwOGNCVnZCRmNFek41aWpHQWN1WmdCYjZuendjMjFlYjVV?=
 =?utf-8?B?NjhnZnErZ01vN3NZZ0tLR0ZEMzFFcGt5dys1WHRIbGxIRTdqcHloOXpoa21h?=
 =?utf-8?B?V3VVOGcveVVsV0J5bVIzTkJ4dGd4a29iWHdTRlFoRXllTWJ4NmJqWUVZL1g4?=
 =?utf-8?B?WTdKQVR5OXMxRjl6Ukh6UzErYTB1N2pkWWt4NzlISzJBaHRHSEJIL05PR1ps?=
 =?utf-8?B?Q0wvUlRlQnVSTStiWXlUaVZFN2VqRSttWEFrUGZkTGxlcGRnUWJ0dUY1ZitM?=
 =?utf-8?B?UjhrNXFLMTROS1JhVEVGRGZJeUlyZjR0bGxVdDZwRW5reGM4alhXTThhMVJB?=
 =?utf-8?B?cWVUV1ZicWs5YjFXNjNINEcvaHNXeUVLL1JzQ1gzOVBraDlva1BJVjRMWHc1?=
 =?utf-8?B?SUs2aXU0WXprRWl1MWYxMGpFVFQ1NzdJbzVpMTBhd0J3aDRDYks5bzcwVUxS?=
 =?utf-8?B?RnkvNlJGcUUwV0FtMnN6eUc1N3g1Wjc3cFJzMko5b0JvODNPbmVBdTMvN0Rx?=
 =?utf-8?B?UU1OZkhURmlSTnp0UDFHVEFEaXZaOUxHNGZGU0lXUGVxQmRvbVhjZEkzUEM3?=
 =?utf-8?B?VGxtWHpYMFpxd1RzME9FUUpGWVh0aDd0eGhCdWV6c1YwVXk0dWJGd0FUb3dF?=
 =?utf-8?B?bkFmblhzRnhKSmRHcUIybjFDWDZiWGZOUk1QK2UzeEpOWE9FaEFkTy81WDUz?=
 =?utf-8?B?SGJXMURWM0svU1hEUUdMQlZ0RzdFVzZBSm5JUlhUb1lwWG9CZ1Nvc2xzOEVW?=
 =?utf-8?B?Z1llSnl1cWpPaFU0QjVkUU8wdFl5V2kyT1FuWmZTZTVTZ05wVGJYWXJ5ekdC?=
 =?utf-8?B?dlFibzFiUGtuUGNsdlFNTTdxR2FrVWJaMUFpa2hJeGpEd0tFYlhwa2F6RlZM?=
 =?utf-8?B?T1BXUHl6ZWQyd2ZvMU4xRENoNkV6T0VoUUFPWXRLdzBCWUgzMHpyTWhvdHRv?=
 =?utf-8?B?eGg2UEY0Z2srdGVKMWFLdStUVkNWR3c4eU4xQXVZOXlNTE1DbVJTa3JYbGtj?=
 =?utf-8?B?UUJUMWlqbDgyZTNNUFBkNVlOYlo5Ulk2WHBacWFzdVN2SDFQbXdvLzU2Tlps?=
 =?utf-8?B?UXcvWkFEQVZudjZaUUhvYmxYaUJPd3czMEFHckVodGNnWXFmd1ZQWG82Ujln?=
 =?utf-8?B?WG1xL3N2MklDTjdVZTJ4WHl0SHZuV0tkTzZkc3MyQjdtWEl3T1ZRYmtHZHJ5?=
 =?utf-8?B?dWxBWm1GWG9GTmpnbEhHRk5GRHFiZ1F3RGtldXZsb2oxSjdOUW12OWZ0N1Yw?=
 =?utf-8?B?djV0R1VtOFh3K09WMFdpODZqdXlkNmRSRVVvNVZLQW5RZGRBNGh1NXJYVHJP?=
 =?utf-8?B?eTRZT1YwQ1BmRmZxaENBaG1WRDRSZFcvUGhOSDFleGY4VjVPV29iTjJpK0FV?=
 =?utf-8?B?YXJ5K0dLVUMzREIxRmpFOHFBOWQyTUxML0lTZU5YZlg5RU12T1dGTnE5eXVq?=
 =?utf-8?B?N3VtcnBuWlU3NVJOeVpNRENBZVJzSFZiTm43b2g5b1VYSEF6NTNXa204L3JM?=
 =?utf-8?B?VGswWFcxK1haNE5BL1UyeFJIYWFWV2tKanhJZlFZODRISFMyczhhMjNDMGMy?=
 =?utf-8?B?S0xPWStDbWFvOVo1dEJEQURneEN0Nkk1MDhGdjNMcGdUZnJtWTJBYU50VkNW?=
 =?utf-8?B?ZmkwcmxHYW1xMWFLd3A0a045eGpSS0lTN2pqRDhNNENTSloxZEFJQzM0ZWh0?=
 =?utf-8?B?V01LYVpXeDNaN0ZFaTIwMnBIQWh0Nmo2NVdqSVVPMHlIZjZpT05UcC9samlz?=
 =?utf-8?B?aGlubVlkNHBmS0xjVDZmV1daS1dWbDJRNjlsTVFMMkdwVHVDbUxqUGpwZkt4?=
 =?utf-8?B?V2N6ejNrTDlmZWJKRnNZcFFoN2gxWkhrZmJZUlZHL2hNZDZIOWk4YnBCVWox?=
 =?utf-8?B?U0F3ZDdBbzJFRDNyL0YwM2F4NElZUGtTNW1nNmZUNkp6NWRKS2hvNTdxYzZ0?=
 =?utf-8?B?VWd5emE1VWJuZnBiNHUyL000OHY2WlZiN1VGMlUxZG1aRGFDRFBXZUJkb2dv?=
 =?utf-8?B?bjU3aVA2QjhHN2IzZFZQTThCdmZSMVozak56Z2N2MDhPdXpSVW1uazRnaEl4?=
 =?utf-8?Q?zkccZnRIDBxxyDSBCXuyiHxG/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 060c0741-3e4b-48df-c4c3-08dc864a1d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 17:00:05.4955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mI0woAI6PXxnxw80iMvJBFbWF0ppSwQxJ9gL32yqO9UFcuEwMbRoCfX8LQk9ijNfGgz0fO3bwsVzG03m88cUQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4895
X-OriginatorOrg: intel.com

Pj4gSWNlbGFrZSBhbmQgbmV3ZXIgdXNlIENNQ0kgd2l0aCBhIFVDTkEgc2lnbmF0dXJlLg0KPj4g
DQo+DQo+IEkgaGF2ZSBhIHF1ZXN0aW9uLCBkb2VzIEludGVsIHVzZSAjTUMgdG8gcmVwb3J0IFVD
TkEgZXJyb3JzPw0KDQpOby4gVGhleSBhcmUgcmVwb3J0ZWQgd2l0aCBDTUNJWzFdIChhc3N1bWlu
ZyBpdCBpcyBlbmFibGVkIGJ5IElBMzJfTUNpX0NUTDIgYml0IDMwKS4NCg0KLVRvbnkNCg0KWzFd
IFVzYWdlIGV2b2x2ZWQgYW5kIG5hbWluZyBkaWQgbm90IGtlZXAgdXAuIEFuICJVbmNvcnJlY3Rl
ZCIgZXJyb3IgaXMgYmVpbmcgc2lnbmFsZWQNCnVzaW5nICJDb3JyZWN0ZWQgTWFjaGluZSBDaGVj
ayBJbnRlcnJ1cHQiLg0K
