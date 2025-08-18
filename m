Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2DC24887E;
	Mon, 18 Aug 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536474; cv=fail; b=i3R0d2u/j88imL/dIcexbVGlNVC+GCQ7tJWn2mLvmlVbHkYSwIpv5ox9W5JQUzuplVjxK9JBf38Q3g4vdsz8J7DYf27Y1XNx3bmewyJis7yxAdcH6/sGFTPMVFveozG8xyFzEzw1Hd4OHY1XcYFJhYpLY5ZTHrtlvtKuwAyLuCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536474; c=relaxed/simple;
	bh=U5sqA4mTZfuyOW6DmWUKM0vm/qCL2LRUxwWQjJ5O6EU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PRl+YxO9oQf5/AEdaRPsqV7WzdIyAnoFvCDuefoR/oWWO9psufVU0S3NOiIX+B1Ji2oA1PsB3PM0A1JCQi++I2Mmerm74Kz8ufgEx2nKXZEnaYoUevQd2M+1dQ4+NlGaNtSs0L6H21FjUCgTWetoNveWXw9fMalCLpR2yO5OH6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nge3ixdF; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nge3ixdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755536473; x=1787072473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U5sqA4mTZfuyOW6DmWUKM0vm/qCL2LRUxwWQjJ5O6EU=;
  b=Nge3ixdFqLUavyaCnZ+tOMaD1KqtelHv0q23g4Qnde9SS7ZikwI7DngX
   MgQuUiQd1lI0aWQ9ETx7SAdStMuGhs6WuFC/EgPMOEKRWuDX4G/pYOJmF
   u6MaWvTmdnEKdNF7nefUzcE6HrW4l8YEyWNhkJCKY2yaL1v5PlwpmWX30
   IAwKx49SZ2R8K3qmSGRPnpoZfkq73soTv+QZu8enLkr8wSOqgD4/EtNf7
   qTjoZ60cjL45/iOCw/YcTOCsq9sk9DFmVT2dlUoHQs05PWdIrX4Uve27U
   y3LSeCXV/zzCoZYqFrKtxQ4M7QS04h+svBnAdHPu5luTumPmP4h/1jqBS
   w==;
X-CSE-ConnectionGUID: SzZpuCooTuOxEHugNLu1NQ==
X-CSE-MsgGUID: 1TsnJ1XmS2OIaC6zqePF6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="69141453"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="69141453"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:01:12 -0700
X-CSE-ConnectionGUID: 3+dDJ0LYQPuPF6jpb+Y1Sw==
X-CSE-MsgGUID: 2hgi7Bm7TLOeAxjdJiKbKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168429946"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:01:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 10:01:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 10:01:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.89)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 10:01:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5PP1EAFAV1UqsREP4sgw4AwL97S3/HhvjDYZqZTPlwEp/zMGBSVIe3cCulaxtkdS+k2Xgf1QXAHIffwRbGgBvmmThRl9ZX/KXh8p7hAhcPX88EXNrfVUrki3dBhTbM3qjUGbG8etCnaNWIHRc6n47cVmwbm/BYKFLkQU2ie6/TBqYam8ShYZmv8VR0rAWpoxgj13rtjKc5PvCe4Rn55wl+NwHp7mOeUFaQAz568OqwhfTC5HBUSsyz7oW3v64GflZyi35xa83/tDR3MniD7Eig+L/U+IEerDVHHDcDF7/uPNls/4zFEWhPXrLna+G4LfzdTT96RkG8zXdpvxezAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5sqA4mTZfuyOW6DmWUKM0vm/qCL2LRUxwWQjJ5O6EU=;
 b=mr356DoVbxd8Z7TWKHmWqWQ5BgFeUV9HWVPZ77Bcah1YpABzbDLEkDnAEwbNhj+ecwCHGwTuDbGlnvMd4qBKaXyeOCf+ToiOpZnvVezoKAFTv/EUD56K3VzorINo7/ZSKsfukIelC8DItwzkjltJPHfAsP0KBU49qY9yka/tLzYeQvKP6K1igo/+o9mcSu7Viz1Cq1m5bC+DmHYnSJkR3JMa8gOqjjg5yzJBtMfnoekprqCGl4pezhHH6vWBevxaU6hdOR58npDPm1+HQZd2Gax+/YbGnR/U2jIu6OTp3sAlZK19vEsW+IuNHprTEaw6fPNpeb7k+WOzbPgcJVK2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 17:01:07 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 17:01:07 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "maz@kernel.org" <maz@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "mbland@motorola.com"
	<mbland@motorola.com>, "willy@infradead.org" <willy@infradead.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "rppt@kernel.org" <rppt@kernel.org>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pierre.langlois@arm.com"
	<pierre.langlois@arm.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "jeffxu@chromium.org" <jeffxu@chromium.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "kees@kernel.org"
	<kees@kernel.org>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "jannh@google.com"
	<jannh@google.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "will@kernel.org" <will@kernel.org>,
	"qperret@google.com" <qperret@google.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC PATCH v5 13/18] mm: Map page tables with privileged pkey
Thread-Topic: [RFC PATCH v5 13/18] mm: Map page tables with privileged pkey
Thread-Index: AQHcDcKD2qDmRtHYakOguSflBSorNLRj6kEAgAStSgCAABBPAA==
Date: Mon, 18 Aug 2025 17:01:07 +0000
Message-ID: <c8196481fdd338e9d066376b6e9bf1dfcd6ea462.camel@intel.com>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
	 <20250815085512.2182322-14-kevin.brodsky@arm.com>
	 <616011cf17f1654ac3ad8757f0f33425b3af1ddd.camel@intel.com>
	 <b6579c2a-2262-4279-81a5-8235092bea13@arm.com>
In-Reply-To: <b6579c2a-2262-4279-81a5-8235092bea13@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6956:EE_
x-ms-office365-filtering-correlation-id: 931e3cd1-1ca8-4dc9-9bdb-08ddde78d326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UUhmMUU4RTNpYkZOTVJ5QUpYVFdqTHg2dklDdVNEdjloY3FvTDcySlhuaHor?=
 =?utf-8?B?VlhQVEF6V2RFS0xaVVFMUWt5aGRjRVVvOEptVTlxQUV1dDdQWjBONTVFOHZE?=
 =?utf-8?B?VXUrdnhMaitTaFpZSzdLNnNYYzlyV1FrWGpsdmpoenlPUkREUWlJUElCMytz?=
 =?utf-8?B?UlNhL0ZQSkltYnBvUHJGVTZaYVNhdm9tUkxZb05ZTTF0L3E1NGMyVlNkaTNW?=
 =?utf-8?B?U3F2U0tXZUdLYlluRmxYQWhtbXdGRG9qVEhId0VMNTFZZFNrYVZUMEFJcE1B?=
 =?utf-8?B?aTIzdi9tNGFnYzluZHFuRThHZStxY3BmM1BRSnRBSnBnZDExMk0wYlEySStl?=
 =?utf-8?B?N0k0UmtkY0NRemRvWDB0TnYwODVHc2hNSmFWYUkxSzV4UHFxbk1NcGFObW5h?=
 =?utf-8?B?ZkNuNnNuLzVpUGxUa2REWm02WWZMbk5VMm5UaUtrTHhzY0tuWU55MnMwNUVU?=
 =?utf-8?B?RkJXRDFDRE9BTDl0RHRmVjQ0Rkh4c3BzRW1PcE05NURiQ0VINlhFRGxyWDV3?=
 =?utf-8?B?SDZ5alFFbzJvZW0wdUg5NnNTVWFQY25HcldLbzUwSE1reUZobTkvVU5odzc4?=
 =?utf-8?B?MzhDS01HOWpwRk56cHJlbnFvZGZiTFcwUkU3VEFxMFlReTNTamhBSFgyZjZL?=
 =?utf-8?B?ZWZWRWdwZWlEUEh1VElDU1JoaW9mbDhTQjNxWFI5Y1JraEYrbnZURzN6NlYr?=
 =?utf-8?B?Myt2YUJCUTU3YmZVbXp4T05kazQ0Q1NDYUZubGhjVjByOVh3VGtBdGZ6U0pj?=
 =?utf-8?B?VUFjL043YjlzamRYU3EzWVcxZkloU0hkTkxTS0xIZDVsRWg3eG9kajIxNit3?=
 =?utf-8?B?eUxNcG9GQ1VKU0pBZ1lENmk4UkRVdjAvVUVSOVo3UDE2YnBMQm1zOFZpcXhT?=
 =?utf-8?B?QVZGR2wxejNYcnh1MnNEWmtGQ3dIbEFnMTdFYURsWDJYNkg0aCtmcHlUUU1J?=
 =?utf-8?B?WnEyMFRXcW1PY25KcHpObUZudmhSVFBmNWp1RlVJUzNjbW1aVHpUY3pPTDdh?=
 =?utf-8?B?Wmc3ZWxOcHNsMVpWV1BRS0pNSXZEVVlqeHdGZnYzZHZiM2pyZVJkeEczekt6?=
 =?utf-8?B?NWw0ME81czl4dm1jejcrbDlXZ1JnaldxYnpZY0NMYTFjOTB5OXI5OVJOakhI?=
 =?utf-8?B?QVZCQU9FdFFDMk9IcWtXYThFN3pQM2NpS2hxT0IzaDZPWkk5MkdSNTZuZ01Q?=
 =?utf-8?B?MEc2SWk4Y1JTRVJQalRBamtqMTUvakZpZVA5SW1FazlDdDFKdkhFS0RCZ1p1?=
 =?utf-8?B?NStlTC84eWFPc2pjaTJRejZWbHNiczdCeEV0UHhkMmgweFhwcFhMZ3Z2MVFy?=
 =?utf-8?B?NlBJUFJjSForS2NpcVdMenpIRkFjWmt3TXo5UnFlNmJ0dmFKWWtDSFdjdGRW?=
 =?utf-8?B?QjJDMGVXZHhIY2lDRlNvY2FqS28yZDh6N0ZiVjZOdWlPelVvdTdJZXBxZjlB?=
 =?utf-8?B?MWRZa09HaVk0Vzl0QXFQd01JRU8yVGpmT04xd0xHbjM3K0dTcDg2dlFqTUgr?=
 =?utf-8?B?TC9EcURyUkU5QTR1bGwxT2M3T1dUK2F1cWVFS1V0dzUrVmNMUUZPdDYyb0Fn?=
 =?utf-8?B?Uk9vcFIxRndJYno5SFIwa1VBcGlnenhGeVM0NjVncUJzUlF0SUgzN2VHUE9s?=
 =?utf-8?B?NE1XMSs3czFuYnlLc29GaUYwTmVZV0dUVm1EenFoVUlLUFphUTVrdmVoUDBx?=
 =?utf-8?B?OERjOEtvSjU1UjBjNk5aU0U1bkpWM21lbkVkei9ZMEpHSCs2VWQxVkJ5M2Ny?=
 =?utf-8?B?dDBhNHh0RUc1N2RkdnA0cE5Vc0Znc2Rxdjgya1IvTzZxTXkrTUkvNE9WQXlY?=
 =?utf-8?B?eUhNTkYwOTBjM2JFOXJrSkpUZXpvTSsrcHpOdDREck9zODR5bzdzaVhZclRC?=
 =?utf-8?B?ejU0M29XYjhqRVRSUmVDczMwSGpqYVdreUxuYkFJazZMd3pBMUM4WklqU1FD?=
 =?utf-8?B?N2N3b3BEemVSRmgyVHIrUnBHVFZDOUw0U09URHpkQUY5dmI0ZTUzTkg5dkhL?=
 =?utf-8?B?aUdUNzlKejZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEw4TUJPMzVMQ0VBRkJ1N1QvTnVtR1Foc3RUL3ArOU8vMm5tSHNOS0pOR1J1?=
 =?utf-8?B?bXRwY0poakUxL043TEd6TXJOTVorYzA0NDA3OURsdXVtOEFiMVVNa1NWb3VS?=
 =?utf-8?B?c2RMSVhDUDBGMUpPTEwzMktDbko5eFdvUFBzYnBSRmR2NzdTUTc0c3VrcFd2?=
 =?utf-8?B?YzU4cU1ZZll6Y3cvaHc0Tk9qQzh3WFZaaXpkRjF1L284NmU4TG5qSzlqd0Rt?=
 =?utf-8?B?OVdvU3FZaU5XTVdlVERuYjVlcWFZUWlsSXVYalBKZU5Qb3J0Uy9UcFQ2K1hF?=
 =?utf-8?B?M0xhSVNzSDErVWVjcUUvMG81QmpvcElRYXdzNm92RVVFM3ZzdTBFbDF2eE51?=
 =?utf-8?B?ZXQ2TEFpdUVpU1p5T3E1Wm5kRjZWdGo3ekljUWRNYWkvdEZjVnl4L3JhOFBF?=
 =?utf-8?B?REZKaHdwaDlGVy9zMSs3djBIRmtTV21DV0o3TVMyTHdJT01Mb0ZMOCtKUkpq?=
 =?utf-8?B?bzMrYk5rYVhVQ0U0K2p6dzlGNytOL0syeEVNTkxUMjFuKzd5YkowbkU5eTlR?=
 =?utf-8?B?NXhiV0Q0OWw0am9YUndTUWExUVVSdDVMWHJaclNiMmpGVXdSc0l5VlYyWHdW?=
 =?utf-8?B?ekVhek9ySkg3YU5QMlVnbzRMUnFsMktzL3V0eStCQ3B5K1J0WFN0dW13eU9q?=
 =?utf-8?B?b25zYkpnTGVKNUtkSjBaVXU4ZEVqN01xY3VMYlFaY0EyRlE5ZHluV0FMZnhu?=
 =?utf-8?B?VDJ2NFNvV0pZSGtiemVHYzNMOGJkQllWTVhBbndGc0tZT2JnS0J6SlczMVpi?=
 =?utf-8?B?OTR1SlJkamFwY2orNE1wemo3SUhiRlpFRTdJY0VCSTg0MWd1L0plRGV2NnZw?=
 =?utf-8?B?ZFJIOVY1TlcvaTNaLzhLMEZJQTV2UUZzOThEa2wzRzcwNVB1UVJsN0w1c002?=
 =?utf-8?B?Vlp0T0VtQ0dCaDhsZVppdzdIV3NLdzlQTCtuc1F0d2JiaHQwTGpuNkpnME5i?=
 =?utf-8?B?UFRNQzc3SzNvVWcrUnltQ3B2TWJsVzFESmxnVCsrUU1NeGtBUjdwSnJzcFFW?=
 =?utf-8?B?SUJkaGJxc2ZSenBCSXFDbmw5YzhCbFVUeWg1UldsMHJIajgzeWMzaGJRbVM5?=
 =?utf-8?B?UFhBRGZMaU8vL0tPWExiM1h6ZUluVWtWMmgrVU43Zk9NRnU4OWgrRkorSTdB?=
 =?utf-8?B?MGp2U2d5MXZKSjc5M0s4M3o1RVVrMy8wMEZ1ekt5Z0s5Ym5Wemk0VFFxUjk4?=
 =?utf-8?B?T3lkbzhtejlIMUFjdDZiZFkxUEIxdmZVY0dsWTFSY3dTTUZQbzBCUlNpVEho?=
 =?utf-8?B?TmhtK1lXd0FOdDFYTVo3VmRMMEJQR2pBK2hWYTRSYkJ2clg1dmRKejBuWWpL?=
 =?utf-8?B?RzV0dmtvQXoxNzF2VzhkR2JvcGZhUUt0NXJEWGxOeFB2aUJRclJzV0V6Ynly?=
 =?utf-8?B?alpsb2VMRHdSSGhhbzhJM3ZtUk5DNWJSRTFCNHdGd2x3VVRoQzNEVFJuejBi?=
 =?utf-8?B?aitLVmwyc1I5ZmJOdmtEMk5BZHlQQW1ISm02eUttU1VqcTBMYW9MUW44R2xr?=
 =?utf-8?B?RDQyRktOQ0M4SFphcnFHUUkzdngvVGtVUnM4S3UrcS9aQkZxdWRodWJ5ZTN0?=
 =?utf-8?B?bXdSZjZZV3pIcExyR1ZjejU0a0wyMXN0cEtLY0tqQXFCdVJqcFlVbWN4RjZM?=
 =?utf-8?B?UVVjK2xrZElpZEh1ckZtUmNsL3FkUTNna1BkUG12OG5Kc2g0ZkJWaCtBVUpv?=
 =?utf-8?B?S0RzMlV2OWVzSWNlcy9aMHFia1lLcWErbitvTkFncXlTTGNkalFlbkZ6MEtG?=
 =?utf-8?B?TUNVVks5MCtMb1B2VVlsZ1hadXFEODNMQ0g0eHlUSHRmY3Jqdjd3ZG5JU0Y1?=
 =?utf-8?B?NEUrV1plSytEZWN2Q05pcmdEVEhXZTNhZlB0UVEwMlhFNGtqcjRMWEZ5UmlK?=
 =?utf-8?B?KytHMHRUTndONzIvWlBZUjVHQ09tT0ROMWJnWWlNTFZrZ2pmelZQcFpVdm9U?=
 =?utf-8?B?SGdySDFONFVqWXN1ZWJ5d2JVZTBNZytMd3RQMHJ2OE9CbHdmOWQvek5ITnBi?=
 =?utf-8?B?OCtOY21mSFo2NS9GbHR0KzBVSlNzSFVxZFRCL2prNXlxVkxMU0RKbGxPR2M4?=
 =?utf-8?B?d0R3V3FpUUJtakNFZ2E4TnhkeFZ2OTBpNjB6OWVSL01ZaTRXMEtyWmFJOVpm?=
 =?utf-8?B?aXZMdGptcjlwbngxV0ZEeXJIeFkzVHA1cWhwQ3k5MzVxMWxvUW9IdkVnYkxS?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12DC006406660D4499BD12CCC0D6C78B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931e3cd1-1ca8-4dc9-9bdb-08ddde78d326
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 17:01:07.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H50TrkBOwx/jmq4Fa+qjl/S3j9CXLQ9ulF79wg6OkMSI+JQ4xhWRAmoX0scTg8+CPw35LBlVSW1HKSLr8OA9jtCoVagauzfS0cuXFcVjZgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA4LTE4IGF0IDE4OjAyICswMjAwLCBLZXZpbiBCcm9kc2t5IHdyb3RlOg0K
PiBUaGUgYmVuY2htYXJraW5nIHJlc3VsdHMgKHNlZSBjb3ZlciBsZXR0ZXIpIGRvbid0IHNlZW0g
dG8gcG9pbnQgdG8gYQ0KPiBtYWpvciBwZXJmb3JtYW5jZSBoaXQgZnJvbSBzZXR0aW5nIHRoZSBw
a2V5IG9uIGFybTY0ICh3b3J0aCBub3RpbmcgdGhhdA0KPiB0aGUgbGluZWFyIG1hcHBpbmcgaXMg
UFRFLW1hcHBlZCBvbiBhcm02NCB0b2RheSBzbyBubyBzcGxpdHRpbmcgc2hvdWxkDQo+IG9jY3Vy
IHdoZW4gc2V0dGluZyB0aGUgcGtleSkuIFRoZSBvdmVyaGVhZCBtYXkgd2VsbCBiZSBzdWJzdGFu
dGlhbGx5DQo+IGhpZ2hlciBvbiB4ODYuDQoNCkl0J3Mgc3VycHJpc2luZyB0byBtZS4gVGhlIGJh
dGNoaW5nIHNlZW1zIHRvIGJlIGFib3V0IHN3aXRjaGluZyB0aGUgcGtleSwgbm90DQp0aGUgY29u
dmVyc2lvbiBvZiB0aGUgZGlyZWN0IG1hcC4gQW5kIHdpdGggYmF0Y2hpbmcgeW91IG1lYXN1cmVk
IGEgZm9yaw0KYmVuY2htYXJrIGFjdHVhbGx5IHNwZWQgdXAgYSB0aW55IGJpdC4gU2hvdWxkbid0
IGl0IGludm9sdmUgYSBwaWxlIG9mIHBhZ2UgdGFibGUNCmFsbG9jYXRpb25zIGFuZCBzbyBleHRy
YSBkaXJlY3QgbWFwIHdvcms/DQoNCkkgZG9uJ3Qga25vdyBpZiBpdCdzIHBvc3NpYmxlIHRoZSBt
b2NrIGltcGxlbWVudGF0aW9uIHNraXBwZWQgc29tZSBzZXRfbWVtb3J5KCkNCndvcmsgc29tZWhv
dz8NCg0KPiANCj4gSSBhZ3JlZSB0aGlzIGlzIHdvcnRoIGxvb2tpbmcgaW50bywgdGhvdWdoLiBJ
IHdpbGwgY2hlY2sgdGhlIG92ZXJoZWFkDQo+IGFkZGVkIGJ5IHNldF9tZW1vcnlfcGtleSgpIHNw
ZWNpZmljYWxseSAoaWdub3JpbmcgcGtleSByZWdpc3Rlcg0KPiBzd2l0Y2hlcyksIGFuZCBtYXli
ZSB0cnkgdG8gYWxsb2NhdGUgcGFnZSB0YWJsZXMgd2l0aCBhIGRlZGljYXRlZA0KPiBrbWVtX2Nh
Y2hlIGluc3RlYWQsIHJldXNpbmcgdGhpcyBwYXRjaCBbMV0gZnJvbSBteSBvdGhlciBrcGtleXMg
c2VyaWVzLg0KPiBBIGttZW1fY2FjaGUgd29uJ3QgYmUgYXMgb3B0aW1hbCBhcyBhIGRlZGljYXRl
ZCBhbGxvY2F0b3IsIGJ1dCBiYXRjaGluZw0KPiB0aGUgcGFnZSBmcmVlaW5nIG1heSBhbHJlYWR5
IGltcHJvdmUgdGhpbmdzIHN1YnN0YW50aWFsbHkuDQoNCkkgYWN0dWFsbHkgbmV2ZXIgZ290IHRv
IHRoZSBiZW5jaG1hcmsgb24gcmVhbCBIVyBzdGFnZSBlaXRoZXIsIGJ1dCBJJ2QgYmUNCnN1cnBy
aXNlZCBpZiB0aGlzIGFwcHJvYWNoIHdvdWxkIGhhdmUgYWNjZXB0YWJsZSBwZXJmb3JtYW5jZSBm
b3IgeDg2LiBUaGVyZSBhcmUNCnNvIG1hbnkgb3B0aW1pemF0aW9ucyBhcm91bmQgbWluaW1pemlu
ZyBUTEIgZmx1c2hlcyBpbiBMaW51eC4gRHVubm8uIE1heWJlIG15DQphcm0ga25vd2xlZGdlIGlz
IHRvbyBsYWNraW5nLg0K
