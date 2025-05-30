Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4F1E515;
	Fri, 30 May 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617211; cv=fail; b=HyWaKoDb6flYPvXLtVLZRWrTYfp60syU35Xu6W7KfkUGQid3Q0y5O21mZBxnpPOJ0VLLcpZBYkH2Tfe96ynHTLH/Ndcw8nEBukh9+pnqxDR/QyWlfUCiBKZ/GiAysb1LbKfWPm8Cv26ftw90BxWhdksvM8xbSrzs+sWteS62eBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617211; c=relaxed/simple;
	bh=VAh+Kd48Tpm0YT93JUnRva+L7SdwWYD5YdnAw3uTUdU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuOT32e84brXxzSusXL4d9wa/+0xUyKUH8cHYGoxxdxcTPYRuXeaTHkwyAYcPGOP8JJvQg9MSIywhPhDFtqh0aEJbEzpB/EGgPkAOj898n7fWmxwi3fBJskVg5mX9K4+qR1jqi9VxivPwOZy9x6aNwmREj6MWpUIjZ8Jis0mBtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyUrhLPC; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyUrhLPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748617210; x=1780153210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VAh+Kd48Tpm0YT93JUnRva+L7SdwWYD5YdnAw3uTUdU=;
  b=hyUrhLPCx3syD7SDbp9MUWFOw4BQz0wzR2mqLf/SJAIWd12gbEhdqpfY
   OegHEoBe2yFeTeqmyfibkAe4TxklTUTDQGb/TV87yns8W1XDXaJnfYMPE
   rsKkcvszP78REHF2oSwQ5kDFWxltq45RoFiu5ugVHFfP5VBSst+ORKPND
   IszwI25aqU+Ew4YH231B/4v9a3TKOvtae4M8vij0rZ8XWNNs201gAY1oM
   hSiBgtp43b8kjdfjMrLYf39VCzxYUFmL4222rLxmed2yDcSjBdd5iCWqV
   gFT2IjtPvkAsJjI8aWAlVIVu4anMRKOV/HcUOpBu9RFx6ydSbWrytAGu5
   Q==;
X-CSE-ConnectionGUID: l5OGP6UHRYqgJQDsyA2WCg==
X-CSE-MsgGUID: m6Nf+6BkQiqR6k4lOz/Z8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="54377704"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="54377704"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 08:00:02 -0700
X-CSE-ConnectionGUID: X8zVCdR9SDe2QzTgWWjGiA==
X-CSE-MsgGUID: oBuaI9nRRvSVfEAwrxMXew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="148685255"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 07:59:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 07:59:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 07:59:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.62)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 07:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1xW7nU/HAwNQ751KzdgeT1/NrHe7ITQG3zOYMzPrpinsheCZDR48LWFQkMJ41xmtuqK7tk2/Vxr0k2X3PQbw1yRWYelFhoSWzTDYQPG9dNft+In4YZdNr5+n27XvKQXtDzvvaRfIjYcibvUq7dy+f4pydFETX4uyCmLSr6NFhVmVn3XwF9cAjzmXLZ3UM4msb0ICRwAPwIufwclfq84IJCeAR+R1UUthoTBxAwtes+hmx+72HXTJ+EkSE8Z/ysGqXDq4PWiR8AmlT9huS1KYmrWmiBSlZjQ3qlAzUD+vJiNM0UQALnKew31CZ0UmeNFx+0ixv3LkkVYqz5belbD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6HM1HLASBxD/+/vyWdcppDMiShydkYOEqLI5PcrxZc=;
 b=izY6VhtpLfvam/HZabr0vnNHIcscaGBdf5l7erXjYCuI3jFV6uzjCfjp/QirjSXbT4ELKs43QUO6QvMWX3F4yhTTDvW3UBKjz7+nGOexCefATOMF++97NaRwYVitI3tnMrdNQ9b3HLJS2mlO3TPmkNFz2FwyvTw4hUwg1HwZo4Zo6iFZENTYdj9/Zuoqe3fqMSFi6ZVjaE276RjYeXslxeuihk5JNL9jProEXgCkeDhYO9R9awkKr0uQQTKaJfc9i7Opcw0vdshQQhhF9hs7CcCZgETbTeYsnSaunGnG+Tj9j5+pwSdXhUXoaccqIkmwtqPLokN89jhiXNySXslnMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 30 May
 2025 14:59:40 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 14:59:40 +0000
Message-ID: <d4eed1e3-6fc0-4372-8ced-ae6a49f3c5c1@intel.com>
Date: Fri, 30 May 2025 16:59:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] overflow: Fix direct struct member
 initialization in _DEFINE_FLEX()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>
CC: <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aBQVeyKfLOkO9Yss@kspp>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <aBQVeyKfLOkO9Yss@kspp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN2PR11MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 33550a31-7b13-41ba-b269-08dd9f8a9a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFJKSXlYT095NDlIcCtGeWJ3TTU5NDBkL09HSUUwRXNab1N0VmVubWpmdjc2?=
 =?utf-8?B?UUpQTFlLNHNmcy9vRXBjWUJmL2paK3pDSExGZ1VpZDFraGJpRzh6akVuYlR5?=
 =?utf-8?B?Nk44TUo1ZG1KVkJLZWwvZVpwYnFDOEF2Q1lIU0FrVStiOUNKQ09NcXVsTExY?=
 =?utf-8?B?dWFaSVZkRTBoZ242ait3WlVWTll2L0dYTnZrbW9UemZJVU1naUprT0dyUVFx?=
 =?utf-8?B?aFBiYm5wTExYY2JJbFQrQm5Wa3JwcldrZWJja3lxL0lCS0haQmZ0WjM3MVJ2?=
 =?utf-8?B?N01rdXFFQlRYM0QvUHg1WitRMmxXQ1NkWWhFU003Z1Yxb0ZVMm5MOGs3SUIv?=
 =?utf-8?B?VTY4ZTFjK0VDMDZIWWVXS010RGZVMUhEbUFLcnQzNlMxVDhyYnlCMmUrdjEr?=
 =?utf-8?B?MndsZC9PVDVjbjBlbC9yL0twaTI4V2RIZGdMMVpNT3NxSEphVCtJNnpCMUZa?=
 =?utf-8?B?a2dEd0ZTR2hKb0Q4RTZ4QWlmQ2JPOWt3QlFUM0JmOGpkaXdzK3o5SURHTHFW?=
 =?utf-8?B?MDZQb3NNOUVneU9CYndtWlhuTlh0ZGwzWDlWM1ZodFU0Wm1aU3IwMnptK0hz?=
 =?utf-8?B?Vk4xUUdweEFFNWZnbzh0M0pKenZpUmRRUDdKbFEwSE81VmlCb2VGRC93M3hu?=
 =?utf-8?B?Qks0V1dVclRGdk9TWTZrclROcjRXeC93UkZWSlYwLzEwZnJhbTJXZ21mbGRB?=
 =?utf-8?B?YjVzWThtL2w5MDdyV2Y4Q3NlNkVmbVI5RWxzQ3VhUFY2Z2R1ZmI1UXBxdjNL?=
 =?utf-8?B?Z04ydjF3UHdlQlNndkpLSEx3aW9VbStNRUZ4blJpb2N0QlNIYjdBTXpkTWVh?=
 =?utf-8?B?VmR1U3ozYStMNCt3N0c2UWFPa3ppaTRPZVIrb21DN3M0OTYxS2h1eks1SFB5?=
 =?utf-8?B?eTMzUWhyNWVKTENRRkFmQ2tWMFNmK3JDUWlKS2xCaEwyTzdJOHVwWXdpY3lE?=
 =?utf-8?B?eG4xVElPTUYyNDZ4L1laUlNzcllhNk9QREtuUWNvZXI5YVdpcHlKenJ1OHlE?=
 =?utf-8?B?ajVOM3NXTTNUbmc0d3c5bHdKdnNmVzdLazBmVnBNRlBjSXEwQW00MFhROVdK?=
 =?utf-8?B?bEYwNjErTzR6bXRtRjlWQ0UxTnVTUXlGKzViN3RSbTBacGVSTHBmTVZiOTdM?=
 =?utf-8?B?Tk5xOXEzNkdHWkJkRnlQaFAxMjB5eFQvdXY2NENFQ0VqdlRQczl5b1RrbmZ6?=
 =?utf-8?B?V0c4Q3FQNGNJMkpOU3VUU1c5SHh6c3FQTW96cE1Qc29GZEpZbmxubHdoZ1dh?=
 =?utf-8?B?WFZGTTUzOFp5TGltYytoNmJEdE9lMnY1dmcwejB2SWtacnExUTBZekkyTEZz?=
 =?utf-8?B?cWdYcWllaUVHdFVBRHd4YXloNnp4UHVyOTdPaGtpZURvbXFMcS9YNjRxZml1?=
 =?utf-8?B?TWV5cW1TZmxST0pDYUpxQStOUi9JK2lDWHpWL2pjTDQwQ0YvNkhvMTdRLy9n?=
 =?utf-8?B?NG9PY2VIUWRkdlF0SXJRcmxLM0JRcjBEZXBVRG9HTnF6UHdUeXR0QmZ2NldZ?=
 =?utf-8?B?NGdZbUhtb3NqTFd4enRabFA5bjFsZ3g1QlcrSEFnL2ZHcnZUYlhieVNCQlJR?=
 =?utf-8?B?dHEyeDkwWjFjRGpXaUxhc0pyb1ovcUhjNGlzZVF2NUNrM3U1NWpDRHExdEJO?=
 =?utf-8?B?b0ZSbnlzanc5azV6SFExYm5uUXhxSHZHaTU1UDM3TFBUZ2cvMkFBa1k3T2V0?=
 =?utf-8?B?dVdJSzU4WHBqOENEVUJPQk5aZ3ZhNE83L0M0OVIycUJyNFgvdTh0amNzSUMv?=
 =?utf-8?B?OHBnTTQyanE5ZVplbDhKVXZJRWJhQWlVR0VXM1hpZHpyenFiaHFreXV4S01H?=
 =?utf-8?B?bExPd2Y0QWIzK1dJN2VUNlJmS3J0c1RoOFhOZjdyNW5mT1JOaTRnbDZvUlJh?=
 =?utf-8?B?WDFmYzVPT0I0QmxwT2NQYmJVWU11ZXNQWnRlZnFIaGk4YW1vbzlWZE9GS1B6?=
 =?utf-8?Q?m40/AnHkj0o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkF2ZWZxaDlWYTMvcnEzT04reVVQbnV1RGF1WU41RzhyM2ExQmdramVBV1gz?=
 =?utf-8?B?QXhzdHVNa0NtSkNRUy95OFhPT0hPYzNtQ1M1NG9rRjZQcFJKeWFoZDRSdEY2?=
 =?utf-8?B?anBGbFZmeHhsSll6eGlYWXQ4NHk0R0ZnUmYxdkhuQXJJQm1QelovaHFld2ps?=
 =?utf-8?B?V3JLSnlHU2R5cnFJNHRrekJWdDIwdzRETnRnUHQwMzNPK1VvOHkwL3A5MjdY?=
 =?utf-8?B?K053M0M2Z2ZSNjBZSVJZSFJycUdXckQxMXU2YzY5STl3SjZKOWVmeHRnMXdU?=
 =?utf-8?B?alV1U1VyMFBXK3cycWVFR0c5dEltbURoMWVhTlViYnJyMGNYam51KzlMb05p?=
 =?utf-8?B?WCtGMUdERmgxc1FUVndhcDZqZ1RhVysxY01DYXFMamhJUmJWVE4vQ0lwR29s?=
 =?utf-8?B?QmNRUVV5VEowNXgvV1E3akZvbHhYQ1puK3JYeXNFQnh0a3lUeXB3bGh6YXl2?=
 =?utf-8?B?d2JzaGRvaU15YUJzWk1rdWtaZXprWVlOUFErUFlQeVg4VkI4YndqaytJUmNl?=
 =?utf-8?B?Y2xNM2EwMUNNMXZOMFhIcm4yajkyYkN0Ky9mcWpUblUreFdmU0k5aldRNHFk?=
 =?utf-8?B?NFNPbG1nK3ZBRWZTM1ViaHJLS283M3VzS1EycWpwc0c2VVFXc1lrdlpSZWM3?=
 =?utf-8?B?blFTZzVtWUdJeTlFU0s5a2JDcVZKdDBGRVNEMGhUcnZYQWNSWXJMNlNNaFlx?=
 =?utf-8?B?TUYwbWV4WG5SQXZEZkd0enJLY0lsRWFOOVVBRURwa2RuWU9PMlB3eitTVXFt?=
 =?utf-8?B?VDc5bVhoSnZjaEozaFlHenVqSlZJRXA4SUpHNXdLei9LbXJoT05WMTV4dHBU?=
 =?utf-8?B?MGJMYmZrU2ttRFR5TlB4T0RBZHdaQXpSbkhJZFdWU2ZXa2tNMVhkVVpxaDQx?=
 =?utf-8?B?ZGoxMUhMU3I2T1ZkdVBpSlkwWUVHVWlLVXBUeGdWcmFpZWFJZENEMW5CaG4v?=
 =?utf-8?B?YmRlU3VtVVZDOGI2QURjSE55NUpPUUg0ZlFxZEdOS0ZtRkI5K3VLQU00MFJU?=
 =?utf-8?B?QkJPdE9EUlJjZFdqVW5vVlNhYlFnTlNxeDJ4aWxTL1UvTFl2dkJuQXE1WXJ1?=
 =?utf-8?B?eWYvVGVETk5DM2tvemY1Q2VaMFVaQm8xdFl4cmcyenU4MzhqVnA3ZjFJM0Ny?=
 =?utf-8?B?UlB6YmpycWN6dU1QdUppdTM5ZEFraHNGUmZXblMyMnhBUFFoQ2hocFMyaGYw?=
 =?utf-8?B?YTZnanBIbDQwSEREcWZVbGhUbWlPcldKNmxJdEczTHFoUFVhNWlZWXhXdUIy?=
 =?utf-8?B?TWU0MnMwZ3prT0FvWjVtc1dlekx1Z0ZMa1RtNE9RSFFhZ3pPMEp1OVVnS0RI?=
 =?utf-8?B?RXE4QWFuTk1CV0xYMDYyMGFtbkUrTkFRRG5DeHNPRXdvRFdhd09FVkhMY0ky?=
 =?utf-8?B?QXdDV1FMRHgvWnlEOWMyVjZLamNsWGNnY2EzaGxpQU9JRzB3Q2hYUlBWc0M4?=
 =?utf-8?B?eXRQNVJ4TTlSajYrdmMyZG9aNi84UlB6U3BGcDBaKzdnbFJLcFhVWldNOUZq?=
 =?utf-8?B?M3RSWUNxbTNsZzJiVEg4U0FvWWt0dm85K3FoV3JTNUsyQWxQNENzaUg3dEZn?=
 =?utf-8?B?QW54aTJoanM0N2RjKzdiQ1hPWlRSMnVxY2xPM1RZRjc0WGF5OEw2a0hrczlv?=
 =?utf-8?B?ME83eFBwd25rUU1zcjVnMkJEYmhnWm5VSmw2WnAzbVBoYnV0TjUvNVE2VDdi?=
 =?utf-8?B?YjVLdkRsUzNDZGM2YitFT3c2V1QzY2sydEcvWnFGdjNNOEdDc0ZMb3ZhbjYy?=
 =?utf-8?B?SGdlSHVkejZBWnVCMXVoRC9ubWw4ZFBLSkRVZ0FvbWowaUl3QjlDcnZuaTQv?=
 =?utf-8?B?MWpWL2hGZVVQRmFPZ1I3aU42SkdlWGJpN1pya21mdTE2anNVZkJmVGV1K0Mz?=
 =?utf-8?B?QXVJZVk0OU1Lc21XQlIzZ3lTdU14Y2M2azhkMzRsamhjR2xMclBkZTZKTDhy?=
 =?utf-8?B?NWxrOGgwTEtKc1g0cE0yZ3VJY1pKMm1wcGFxMUtYRlplanYvUmwzN3NXRlQ1?=
 =?utf-8?B?amVQa0UzMjJnK3d2T1ltaVJkblNRa1pWYkNSczlWSWpZWEVLaEtrd1NRVHF3?=
 =?utf-8?B?cUxxaENSOXlodHh0cUJsZmNWWFNackRjREczTFlIa2MyMGx2NVZxeXBhK1hI?=
 =?utf-8?B?OWowQ0VGOGxzZGJlczVFeWMvYzZXSVdrMEpEQXpWN0lLMFBMUk16ZTVIOVBG?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33550a31-7b13-41ba-b269-08dd9f8a9a4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 14:59:40.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OD7aAj23ZY4EGyqESMauRhH2X8AVGv9kZJgLLlc6JiMpgCU4Ty96FOh0wVgpOeCY90L+q/aMXR2Mnq1+1m7p0XYctVr0ghkcTFU39A39XYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com

From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Thu, 1 May 2025 18:44:43 -0600

Hey Gustavo, Kees,

> Currently, to statically initialize the struct members of the `type`
> object created by _DEFINE_FLEX(), the internal `obj` member must be
> explicitly referenced at the call site. See:
> 
> struct flex {
>         int a;
>         int b;
>         struct foo flex_array[];
> };
> 
> _DEFINE_FLEX(struct flex, instance, flex_array,
>                  FIXED_SIZE, = {
>                         .obj = {
>                                 .a = 0,
>                                 .b = 1,
>                         },
>                 });
> 
> This leaks _DEFINE_FLEX() internal implementation details and make
> the helper harder to use and read.
> 
> Fix this and allow for a more natural and intuitive C99 init-style:
> 
> _DEFINE_FLEX(struct flex, instance, flex_array,
>                  FIXED_SIZE, = {
>                         .a = 0,
>                         .b = 1,
>                 });
> 
> Note that before these changes, the `initializer` argument was optional,
> but now it's required.

Unfortunately this can hurt performance on my setup.
In XDP, we usually place &xdp_buff on the stack. It's 56 bytes. We
initialize it only during the packet processing, not in advance.

In libeth_xdp, see [1], I provide a small extension for this struct.
This extension is 64 byte, plus I added a definition (see
`__LIBETH_XDP_ONSTACK_BUFF()`) to be able to define a bigger one in case
a driver might need more fields there.
The same as with &xdp_buff, it shouldn't be initialized in advance, only
during the packet processing. Otherwise, it can really decrease
performance, you might've seen recent Mellanox report that even
CONFIG_INIT_STACK_ZERO provokes this.

What would be the best option to resolve this? This flex XDP buff on the
stack is fully safe, there are a couple checks that its size does not
exceed the maximum (defined by xdp_buff_xsk) etc. And we really need to
initialize it field-by-field in a loop on a per-packet basis -- we are
sure that there will be no garbage.

It's even worse that most drivers will most likely not want to add any
additional fields, i.e. this flex array at the end will be empty, IOW
they just want a plain libeth_xdp_buff, but I made a unified definition,
with which you can declare them on the stack both with and without
additional fields. So, even if the drivers doesn't want any additional
fields and the flex array is empty, the struct will be zero-initialized
and the same perf hit will apply.

> 
> Also, update "counter" member initialization in DEFINE_FLEX().
> 
> Fixes: 26dd68d293fd ("overflow: add DEFINE_FLEX() for on-stack allocs")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

[1]
https://lore.kernel.org/netdev/20250520205920.2134829-9-anthony.l.nguyen@intel.com

Thanks,
Olek
