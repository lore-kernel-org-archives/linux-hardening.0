Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9D2DA760;
	Thu,  8 Jan 2026 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890410; cv=fail; b=kTKTwamDROI4BDe4w5iv2HIP4UkOHFr3hzaQ6K0qkV3m+aU6fB2NJ+F3VmX6P4i2YKMGQuqyxusEfrvM9FfB5haDU+BL7kK10+y7oKo4iJLi2+7nFCfEW7rhF6R4EYtpw2CQuKQfYPKj8bPQ9IWXw2hvtWUyU2bFl63AHx7djrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890410; c=relaxed/simple;
	bh=An9KLAm4KJigCV0HwnHkcw6pg9EY0i3fyRyL2fk0K/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lXQ+tA5R0MhfAcYAk3nft5IFP95gWgZcPX+0KEsPx9pJ33caaE3VtBzzwv1mX42XYA3ldJUduWQRv3J5u4VY4562CYHMQSIUAlW8y7jFiM4mML+FkDYBkG4d/j/KwA1bq4aq9NUYClO/0irvi7lTXcrrZp4SnGbQZRWTxoD7S1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLH16ilz; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLH16ilz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767890406; x=1799426406;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=An9KLAm4KJigCV0HwnHkcw6pg9EY0i3fyRyL2fk0K/A=;
  b=eLH16ilz2210w1myIcgRo4hpgQ65LX8inJR+CKqIBaSssqyfs6Hgrg5g
   F89HNVgjfm03a42P5NiHNiXlRXeFAW/OPE2ZsbEp7ZfyIFX8gr19I2EJ8
   8kPmUmlo6MqbmVYCfqYh95+T9F27/JUrEUQbw8t9teTM4rqhRQxwqS4SK
   NzRd3XKomxqUxp6qa17BPqZZbrGLTcPcHUy1mVjdKU+LiFT59tOdld5PT
   LhAdntKELu6o8oLBGdHu+tmuQO1PzgFEYyxkYwfwvH8V714Sjnpa5rZrr
   SNv5O6+5+hzGdrh+qKHmu/BezfSKa0btic93lNmOvcUq2RvNTzLzOJjAS
   g==;
X-CSE-ConnectionGUID: jLmmTl0mTxykiBE7pCCETQ==
X-CSE-MsgGUID: 1oSeZSfeQ5a37imQ2tyCBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69183671"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69183671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 08:39:01 -0800
X-CSE-ConnectionGUID: RrjsJbBJSHKqMFNrmkg6tg==
X-CSE-MsgGUID: 6XqIUNS0Tzyf7kK3qVyg/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="233949580"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 08:39:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 08:39:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 08:39:01 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 08:39:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xdx1I51jc8QnprrxbF9MyTX6aupUrZPlHCigMHWfxaErd7bpk/I9Zv2FGENB/vmRA4ofryYxxcbpkcNmDeOu9XIhHKFZvkWWyaWi8rAnVSEmcmdXa2zP9stSA/F0tsYeYVJ7xd6DxEFUAYJdY1/o4cW8iweLhDIqlczL76vjVyHQ1ctdcnr5zywOK16WECELaoEVb3NuvRosu0smeIzr754yWBe4s4ry8Bd35HslmgRqkEtvABYcaaU1xNkJKNEhtcKHicSDYMdsz468AsIftQ+IjntNBcclNB22D2Pfj3BZhT6ZqCtJ9uvzMI800WKuXoN3+amgzKWzA3ceF5nQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLI1ZGCfraQ6jOWqrf7yskxSlP/Yh7k46e5ArVx9Ms0=;
 b=orVlp4NgJYeXH4EdozbOD/O298hmaJobxFfyO0td+ZSXmW8XC/kOfKAdsfVAJeNU92PvXETUdKfTrEfmhz7Bg3QRxU4cT+Qvvdk5TvjegTAoFS5FHgKO9lD897FU6qmcOYew+ovFduTAeTpoynh7CFwgg7+ITGs9pIbNPo0yaGltigpzztzRKVI8rvdxu1aGbIG5Yw/sYQPD00zcBubEThXlt5ZPhYkZQL37O+et6v3+ZIMsWHEtuvCBOAZYYAA+BpZp53dE9xFEwybrYnwVlYHSxHNyvgOMnFlGFu5So5i/k1XcqBTK1g97m5ts8nPiTxkQXmVNyDNcC/aFXVtn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 16:38:58 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:38:58 +0000
Message-ID: <7e6b4e3d-3bc4-495b-90cf-618b010dcada@intel.com>
Date: Thu, 8 Jan 2026 17:35:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT PATCH 00/19] Link the relocatable x86 kernel as PIE
To: Ard Biesheuvel <ardb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Kees Cook <kees@kernel.org>, Uros Bizjak
	<ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
	<linux-hardening@vger.kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0211.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::24) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a66e8f1-76c4-4f45-4f7f-08de4ed46c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V25NTUxiVmI2MWF3VDc0bkdxWVlxSkJmMmZWOTBUanIzaHBJQTdYQ3hvVUMv?=
 =?utf-8?B?TjNCc0FWZjRsTGc4a0RLYlo5ZDZ6NzNFVFpQOGhOZCtzUm1WeTh4NGdIQ0Ju?=
 =?utf-8?B?REFzVWY3WTZMenZ0SUs3V25CTkUzb1NyRHYrbVNoK1RrTmszOE5HNnJYVmVI?=
 =?utf-8?B?RDBoeENFTy9mcnBkall1RlIwQkkrZFdnN2hXbFp3YmU3RWJ5a05uZmlxR2dF?=
 =?utf-8?B?NGtqM3BMY1RoZnJBc3A2Z0x4SXJ2eFdqVU8vNTFqejYwa0x4UHdWNllOYXhU?=
 =?utf-8?B?MXpxalZRaHlnNmZONEtrb2pudkxmWGpzTFlkRnJ4WjhnbUhEeE9MSHM2R2xi?=
 =?utf-8?B?MGpSb2hIQ0F0ZE9Feko4RWtqNXFkZ25Mci8vdDc1MWxndkw3Z2RUZ0wraytx?=
 =?utf-8?B?bnlPbjd0YUUreDJENWJad2hyTDRVUzR1V0t5WThaZUhTVC9xaUJCeU1Nd0J1?=
 =?utf-8?B?QVJoK0h3aXNTbTJEL2RuV1ZpcCtZY1BQUHN5NkU3cHRPZ3U4TGM3OU9xS0l1?=
 =?utf-8?B?V1Y1OHJTUDJuSkd6ZEZtZ2xtWkpldnR2YXVtMEp4bzc4Rm5XRloyWFlzKzNH?=
 =?utf-8?B?Vk8vaDYvNW1xSk13cG9VdlkybzN5bWNqT0gwYVZlNTVKMEsxZXI1dUZKeGlK?=
 =?utf-8?B?VTBza0tXeUtYNEFtS1NocGNIZEw2bUh2ODFubUxDekhrd0loMUloL0xzMDlI?=
 =?utf-8?B?WWlSWWhVZ0h6MXQ2S3BzeU96aVJ3NFFTQnM3aEVXdmZoaG10c3hZdFA3aGpB?=
 =?utf-8?B?eHFJVm5RNi84eVR4WWFjM2pQcUY0NG5lbXAvVXZ1N0xiRm03SlJGR09ZOE00?=
 =?utf-8?B?NnNuU3lvQmRmZlpWVFpRVW11UXVNRUxOUHplckJOZlc4bXRIaE9HMW50dEU3?=
 =?utf-8?B?a1JqUkVleU4wL0xVM3ZpWTJHK2V2QmZEemxyc0NlVGZOU1F1Rk9MUC9LN0FK?=
 =?utf-8?B?aHpMTmFUMWhzaU81VC9pa0FvOHZ1Z2RQbWRsS2lUcEMrdVZWSWQ2djVQcnpZ?=
 =?utf-8?B?ODhMSWFZRVRCRTdUSUFRajNIRjFOQk5jejRlZTVkUW05dEtjUXRxSFVoZHR1?=
 =?utf-8?B?cjNVcWF6QmdVSFk3U0RsMzlXejdabk9LM1VmMkVVYXNPZERkcVE5aURtMTcz?=
 =?utf-8?B?STAxSzlhL3pCaXYyUStYaGh6SUJRSjBXOFR2eFc4dzUxYmZWcVJDYWJLMHVi?=
 =?utf-8?B?TzB5b3ZzQ21uN3lUNTdSMCtVVDhHV1h1Z0ZlKzc2WjFqVk9vQ1J2OE5GRGdZ?=
 =?utf-8?B?UlQ0VUIvMS9qWTlQdTA3WCtzc0N2YkZuL2k1ZXFUUGtRcC9aNHJnL2MvbWE3?=
 =?utf-8?B?YkRHdWZkWVQrK1BibmRDVVRER2wyOXI0TjIyUTErSzE4R05TR1pGc3ozYXRM?=
 =?utf-8?B?WUV5R3NFbk8ySE1tZngyN0cwK05zWFU0c0d6dmswSVNpNENTRkUyc1QwM1Ra?=
 =?utf-8?B?NENSdTBjb1M0R1VnT1N5enE3d20zNFcxS2Q4SXBXUHMwNnFsVU1OOHhSWStB?=
 =?utf-8?B?T2FPY0VUWGVZVkpYTjlQNzdnOUx2Q3BCYlo2MVBhc1JsOGJZTytuUklQWmRy?=
 =?utf-8?B?enFQeXdUQVArb2dLbnJIRXFTMmxzay9Od0pDNC9CVzJqRXh3Z1ZCbzBWYXNj?=
 =?utf-8?B?U3dmV3hwM1ZxR0lxUStZUHNLSExZTnQ5V21DZDZDVStpaXBxVU93OGpPMmF3?=
 =?utf-8?B?WlYvWWU1dUgySnNuK2ZiRXp4dHBwc3cwS1JOdDd5d0grUGsxdER0TFZSelNw?=
 =?utf-8?B?UUh2aS9lLzZ4TDQyZXYrN3Uvb3N2RTF5RWJwM2l6eFI1eVBBcnIwQTJiODhJ?=
 =?utf-8?B?b051cFo3OFRIclFycEdkYkpXcUVLeDVURnlRRFQ2TktPcFMzMGhBTTJSbjBQ?=
 =?utf-8?B?MlJNNWtZRmxJelhRYjNDb1hlRlR0TXR3WnVhMGl5ZE8rakhuUEdVOTJ5aGNz?=
 =?utf-8?B?MEQ0V1RrNWN5bVByVW1mRGVsY3lxbkczNzRPdmdtQWtqTWMvMzI4OGpkWGZk?=
 =?utf-8?B?TDEvS3VJYVNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDhSNktYMytSZzFCOFljTldjRVM0M2RHUHd4UWliUGEvV1hrUE1Tb0I1TDlD?=
 =?utf-8?B?b3A5VENkZlpjbGxWM0o3L1ozcWpkZEJYMWszRkNBRmp6UzRBRkxUb1ArQWk4?=
 =?utf-8?B?ZmVzZE9WQUpOU0VqdnRvMHlkazl1eEVIbXcxcmpTQkNTSzE0UGlnWE4xTnNQ?=
 =?utf-8?B?TXdFMU13VWwvazlCOXU4bUN1YWQxWjR4NG11MXZNZXdmdVYrOUNSYUo0OGlF?=
 =?utf-8?B?SjdXdnRQWXpKQ2FWNWZ3cXlXd3ltOFc0YUpTYXYrWGFmaFNjblR6bUhvdjFX?=
 =?utf-8?B?VlBjUTBVNzN5cUlvaWpvNFIzcVFDMmtGaGZyc1ZZYVB4QVY3VFdzREx6KytH?=
 =?utf-8?B?NFRYTHh0aVJWTEc4TFNNdG5hTkMya0EvQm9WQW10WW9WVXVUd0pRNjJUaHhk?=
 =?utf-8?B?RjJLQStjQzJxQUlGMGlpcGdyL25rbzZlNGJYOVVxVS9qUHVhZWtLTm9URlNi?=
 =?utf-8?B?cGNvaW1vSzdTN2dsME9xbXNuLy9Xb2FodGFwQXczR01RamZWYkYxSFVEc3p0?=
 =?utf-8?B?ZERUOTYxaCtrNUpXaTVHOFlMVXZBbEpxZlFSdVJaKzB6cThCL3dITHNMNjRC?=
 =?utf-8?B?STRUVkplQkxBYXM0eHU5cXhYTk5vUVlOZmluYXN3WkJCQmNxOG11d0U4MGVB?=
 =?utf-8?B?WTdFYjFIZjU3b1pGNEFNTGZ6bGJLWmJQcFlmL1lqNXJYYTJ6WHFCVzU2TjVD?=
 =?utf-8?B?c0c2VXMwYkMraUdhVUVGd1pFSThpYXRvRTdTalNHRjFSVlh4dk1OalhST3pw?=
 =?utf-8?B?VHI5ZjVBOXN2ODRQMWVGUGZ4bmRjM1ZXc0grY1VWWWo0QTcwL00vUEJ6RjVU?=
 =?utf-8?B?UFVtRU94ak1hcGVjWlhWZzkyRURBclhOUTZESUx0TTZhaTVpV1JwR2tPRytR?=
 =?utf-8?B?NHF5M1RwR1RhZXVmZU95QVJxdU50Q0tDZG41RUR4cmhQZkEweHBuM1BGOTFB?=
 =?utf-8?B?K1ovemRYQnJOWnBqa0Jtb3pmd2loLzlpREZZRksyMUtWejdSTWgva1Bxaisz?=
 =?utf-8?B?WGVPMnBJdmZjT2U5ZXFYTmp3NVp3cDcrTXcxMFVXbzFWYjBSQlJ1Z0NVbHJG?=
 =?utf-8?B?YWV1NjMrUEluWmsyOWRLdk5NRGw0QjVlRDd6Zjh3aWh0RkNjaVpHNzIxNjhO?=
 =?utf-8?B?RVREZW9hYTVTcVAvZC9jQjc1UjNHU0tjMi9hTllRWUY5UndQSjVGbXpOdWtX?=
 =?utf-8?B?eW9teTFINFVqc0pZcXpraVlVQ1BtOUZQWTkwRVYzeW5obW15TEJhUFNqUi9O?=
 =?utf-8?B?UDdkT2NkeFpyQmtyVlhqU0czbWN6ZFltdUoySUhkVjJxUDNsTVpMeDR0T3dH?=
 =?utf-8?B?ZWJBZ1lNNUdrMTZaOG8xTVIweDR0eFVUOTJUaHo3dWlyb2t6OVNaZldvRkd3?=
 =?utf-8?B?RTMvbWpRMzdmYnNXcFR2UHRyUnQ2TmVITzBJaS9vVE5wWjg0RjlKYnA2WVBz?=
 =?utf-8?B?dCtWdkRRYWVMNG8rRXVMVGV3WitZeC95bE5wbmI3SmFOekhHajhPd3FCRHFj?=
 =?utf-8?B?cTBJUSszKzA5ZjA5clEyTjVRUVNwWUMzeFhXekxFR1ZFdkZURS9yc2ZzSkRM?=
 =?utf-8?B?aUwzVEtSL2FPSGd6ZU50bWRZTVQ1UjNUU2hjU2FWeGtNR3dYdGxkZmdQTHNy?=
 =?utf-8?B?NTVPek0rYmo2MnZSYVlhNmJKVjlRR0FsMDJFaVV3TjJIaVFudEhtS2xLWXRp?=
 =?utf-8?B?SXBkN0ZJdGxMWUI5YlpDZGdLbEdzSXFNcE9ielIzVnJudzFoSldSVnFHMSsv?=
 =?utf-8?B?SnZ6blBUdkJ3bG1LQWx5N1F2OStTOU5OcXZ2ZW8rblUxWUJib0ZmcXRtWVN0?=
 =?utf-8?B?Z0ZvbzZXWUxBWkZTWjdvUVk3bUV5aU01Yk5GM3hJTkFvaWZiT294QzRaREtQ?=
 =?utf-8?B?dUgvV2VSNG9GR0V4bWREdWh2Y0ErU21ORVlEb0VhazlkSVI2MDZwOWpVVTAz?=
 =?utf-8?B?TjQrOXVFbU5xNyszaTkvMXZCTzYzOERFYU5raGd3dVUzU1Z0ZWNHNkQ2di9R?=
 =?utf-8?B?OFVoN2VaajhxVDJlYndaWnVKQnJNYkQ4MTJhSmI0NVpQZ0ZkSjVHcy85TDVR?=
 =?utf-8?B?TW83ZnRFMVZnc1RqRCtjc2tjekRkSk10OWJheGtnT2JyS1VuYkUvODhObDJy?=
 =?utf-8?B?K3Fsc3pGcDJnWXVMYlo0UmlCc0oyRWpHczROTTBaaXpELzJTR1pWQUM5cVVD?=
 =?utf-8?B?RWd6NHFjT2JZdHBUZHhFYzlUZitNK2lQT0d3TGdyd2N4eFBvZ09XQ2pJN0Nm?=
 =?utf-8?B?b2lMQ2VPSGVUOERGT0VBSVpsZE5lVlZ0Y05QcWJHTWFVWXRnbTNwcktkNy9Q?=
 =?utf-8?B?Zzd0Und5UWhKY1BObllQT0EycE1kdFdaRGpTUmw1OUlyKzFETjNBcG5DQzR0?=
 =?utf-8?Q?IVpaqV9yjBQ7iPag=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a66e8f1-76c4-4f45-4f7f-08de4ed46c03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:38:58.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obLDZ3UNddkNNJAu9wssahAOVT0yf1ZOu4R3+XBee7j8bp7Wdm7NEGkvhZlAdGj6Ira+/Qr43zL/oJW/ixuJ1dg0Hbg3pRYZ3CAJjIwvYRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5096
X-OriginatorOrg: intel.com

From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu,  8 Jan 2026 09:25:27 +0000

> This series is a follow-up to a series I sent a bit more than a year
> ago, to switch to PIE linking of x86_64 vmlinux, which is a prerequisite
> for further hardening measures, such as fg-kaslr [1], as well as further
> harmonization of the boot protocols between architectures [2].
> 
> The main sticking point is the fact that PIE linking on x86_64 requires
> PIE codegen, and that was shot down before on the basis that
> a) GOTs in fully linked binaries are stupid
> b) the code size increase would be prohibitive
> c) the performance would suffer.
> 
> This series implements PIE codegen without permitting the use of GOT
> slots. The code size increase is between 0.2% (clang) and 0.5% (gcc),
> and I could not identify any performance regressions (using hackbench)
> on various different micro-architectures that I tried it on.
> (Suggestions for other benchmarks/test cases are welcome)
> 
> So now that we have some actual numbers, I would like to try and revisit
> this discussion, and get a conclusion on whether this is really a
> non-starter. Note that only the KASLR kernel would rely on this, and
> disabling CONFIG_RANDOMIZE_BASE will revert to the current situation
> (provided that patch #4 is applied)
> 
> Some minor asm tweaks are needed too (patches #9 - #17), but those all
> seem uncontroversial to me. 
> 
> The first 5 patches are general cleanup, and could be taken into
> consideration independently of the discussion around PIC codegen.
> 
> [1] There have been a few attempts at landing fine grained KASLR for
> x86, but the main problem is that it was tied to the x86 relocation
> format, which deviates from how fully linked relocatable ELF binaries
> are generally constructed (using PIE). Implementing fgkaslr in the ELF
> domain would make it suitable for other architectures too, as well as
> other use cases (bare metal or hosted) where no dynamic linking is
> performed (firmware, hypervisors). In order to implement this properly,
> i.e., with debugging support etc, it needs support from the tooling
> side. (Fine grained KASLR in combination with execute-only code mappings
> makes it extremely difficult for an attacker to subvert the control flow
> in the kernel in a way that can be meaningfully exploited).

In case anybody is interested...
The latest (to my knowledge) experiments with FG-KALSR was my side
project reviving Kristen's old series (and then rewriting it
completely): [0]

I haven't worked on it since then, as I work in an
XDP/netmem/whatever team, i.e. networking, not x86, and free time for
side projects shrunk severely since 2022.

Maybe someone would pick it up again some day, just like I picked up
Kristen's series back then...

[0] https://github.com/alobakin/linux/commits/fgkaslr

Thanks,
Olek
