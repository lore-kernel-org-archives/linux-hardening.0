Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98323233141;
	Mon, 17 Mar 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207310; cv=fail; b=MjYnHxSu615MiDNHZKdmjOO9PIWXW1gkGNvb43r/cDsZZjOfHNn0Y3QVoLDSLarko5PVAj7xui81Wu/Fb4cFnIdQgOo9gHJDBbDeXiVrgq+H2+3HdwwgFUud0QHbNXypnjWvpyeAY51iSjeR19U58uVurSAVqEC5eQrDllNqkVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207310; c=relaxed/simple;
	bh=WQRYQsQLhW1oYQsvVcWZwE5IEMpgf+ek0O/IvVBW5dY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L7aBLAka5doEXi2LIPq/B06vFris+oyuv6+jDpD38tNN3ciAF+B6bBJTNGfCXRQRcmfsIBTdYfFMU6NsCCX2cmyBnEVliGaWdrKACuIq9l9KbZ7CkwuetqEqoDMUE5p5Bb1/rLuG3xS/tEV650e/JFovplB+jLF5tBpdM8P8cgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkPAmfcY; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkPAmfcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742207308; x=1773743308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WQRYQsQLhW1oYQsvVcWZwE5IEMpgf+ek0O/IvVBW5dY=;
  b=JkPAmfcYxG7A9WvkUde6O+/k7r0iMezg8CzlZ6POG6IiI7bYhgWScKZn
   8rp27L0VHMhDOiizwhCZPdKWF5pLmYE6IRfueJVZFBVNzrLLWdtukZk1l
   R4jwn5xj9ixohu5jhWBrK0eFeTxtBp3c55+1lsWwr5HK3A+/EbK3tQsOb
   pO1wvtBEh05SixojwEKY4Ay32OCR58+KJVG42wvIaTr6YHAtpzJ7qnGSY
   JvxYnEMdD6wy4OYwjUd2UF9EYQyEHEWXY/EIcTG9HwUwHrzRFRXIBYNSe
   G8LHKIP6zeO4SfNnyxRIYCgomGcmC1q5ZWWuOEs1nVUZPJ8nZrE+6lQyK
   A==;
X-CSE-ConnectionGUID: YKfkQteVTrm7bcNmKWuEkg==
X-CSE-MsgGUID: 709byMc2Sv6nL5wykCwOqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="42539927"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="42539927"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 03:28:26 -0700
X-CSE-ConnectionGUID: 3N1J1oGfRduIYp79HgtjPg==
X-CSE-MsgGUID: 89tbVWk7T0+Rltw52F0oAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="159054693"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 03:28:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Mar 2025 03:28:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 03:28:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 03:28:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxx6iP2h5HQylVLbmd+oexadVNZ8qZKjPHIAPy2OLxWjGyq8WYyZrPUz+RTRpHVhiS+8hFD5hFyV/AlaiWBds6xx1RCqXt2aVoYTz/UgIxIGw31sc1R+rQJbwvTdSYQyAmHlZrO6mnUSF3cAIUrQww4NNPLCoAXXAuNbEfbmn6EvUqDsoq8VihdDp9Pang6zwm7q7LPEb1BPm4+Zn/AJIWmF+KelsOvpCNlueRLZt0KHmzG3FNcebd3XRIL64JxLeHYPhZI45LEM0WOQH3y+4di8Nv64qrAJ3l47ww/T/vlRf05Bu0tM519F1IokdSARwGdROC+tdnKgDhDTQ/wkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iInvpaa9aeZnwZffi68gCCniuQtOwMx/Qy6xHhJpX9o=;
 b=pvxrEQxlX+8OhjOJnFJ/6so3kwsE1345dq+i/Ace/qVUa5JXkenXOFZqgyWnszUs/113u6Dyjktag9T48IrOp1YoxbLzBbUZcOoXXNtZJHJmh7pgy8yQkBvd/pbkqXt2rfaUFy7zEiLtjZeG997FjLVEisteXFyid+fZHGan9LBk4NGCX/Lm16Iu146EEFivA56qKKCfmDiGnl1McO9jTl4H9NLijzb/mawSHAZUdlw4h1JxK/U8QLppXm87eh3aPb7kD0wkE9+s2wZ2MOYHxqyvD6cEcTmNTdBJ2TbeF7S0F0UaQ2sWEIQynmzdFxlac7J60b6gIxYX+4hrzmGmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 10:28:22 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 10:28:22 +0000
Message-ID: <89f83133-eace-4bec-804a-198dee9ae14c@intel.com>
Date: Mon, 17 Mar 2025 11:28:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ASoC: Intel: avs: move devm_kzalloc(..., size * n,
 ...) to devm_kcalloc
To: Ethan Carter Edwards <ethan@ethancedwards.com>
CC: <gustavoars@kernel.org>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>, "Liam
 Girdwood" <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20250314-sound-avs-kcalloc-v1-0-985f2734c020@ethancedwards.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20250314-sound-avs-kcalloc-v1-0-985f2734c020@ethancedwards.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0071.eurprd02.prod.outlook.com
 (2603:10a6:802:14::42) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|MW5PR11MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: b2917cfb-82d7-4297-2486-08dd653e7141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0MySkY1M3N2MUxMbmN6dy90QUxaRHpoYTJGT2t5anZOOU14dGJCS3dzZTFw?=
 =?utf-8?B?eHNQbXlGM3FWbHZEUnM3VDdIUDF3YzdzaUlmT3ZweFJuNzRaWTBadU0zbE16?=
 =?utf-8?B?MGN4NlgvRzQyT0ZNM3V3aC9ZWlJhcmJRQUNja1FCWENTZlFFa3BYSFZzUGFi?=
 =?utf-8?B?L2tNNEpibXFRc0llZldjMFk5TDI5VVpOUTFqRUI0VituamRRdmtkc25mVFEz?=
 =?utf-8?B?bGQ3a2VtRjl6dnpjNndVdDU2dmxQbk9LY0xjM01Zb2E2bEpqWU13RGlsUDNt?=
 =?utf-8?B?Q3V3eEJ6NFRNSHdJVTdya0txOFlYUGhBcFhvRlZOM0JBSXc2V3pPU3RhV1lk?=
 =?utf-8?B?M2dZODVDblY4bStoSWs4YmxuakJmRTNsOWhGRzhHSS9nbHdNbDRUMGZHTHMr?=
 =?utf-8?B?WEVrUXJJTG8xZnJJTzFYMWNNREU0V3M0Y2pSakdxK0lNbDRmeUxib2ZxaGpW?=
 =?utf-8?B?L3hhK3hOcTBJQ2p3SGh4ZXNRenAyRWxIaXhMVFRIcElZYlBjakRjdU8yWDg0?=
 =?utf-8?B?eVMwSnhJaGRiRmlHNkVGVWtTSnljRHFCRkdiT0gzZTMwRWp3MmxseW92N0Jn?=
 =?utf-8?B?MUpQMUFYeVplbDMzYWREV0ZsVWtIblVteVMrVlUxMGxBeC93Sy80WWZ1cFFo?=
 =?utf-8?B?NWp1TzBVSlUrR0VEYlJpc2h3U1Y5OWlWdFVoMXUzVWpBWmxYQXlYZUlQN05M?=
 =?utf-8?B?aHB5VEd0OXdpdjQ1TDMvdUxzTlNPWUNCdzZybWVWY0lIMEh1OGZuOFE5NmFJ?=
 =?utf-8?B?bjBtbmlldGl6eEZIaTdSMDRaZUZMdkJRV1hBMU1kTHdKMkRFNkNFaDBCREkz?=
 =?utf-8?B?T2JrZzlMSmpFbjFaMVoyRWxqMnVBSS9XTVhyamRiU2xacHhCbWRQcGJIMkds?=
 =?utf-8?B?d2ZnZThLVTV3ZjhFejc0WjgxNW96b3pPTTJKMEtycE13cVhsT3N1YW54TUxs?=
 =?utf-8?B?RC90ZHRpaDBWUWxLb1JoUGVMMlhyMERWeXJMVy9PUDdhZXliNGs5SlNaT0Rn?=
 =?utf-8?B?eEJtZGZyMlk5dTltY2NUTXB0enQ4SnJYUjRNbXdvRFVrL3lRWUxwUHhLY0Nq?=
 =?utf-8?B?RzBSQkNJSGg5ZDh3ck1MUDJBM2dDUEltZ3lPTUlIVk5YM29UcmUraGljREZC?=
 =?utf-8?B?MkVadjFVQTRYQ1VIbjlvN1R4cVJ2N0FtTFllU0NWWnd2OFExY0dxeUdrNE5l?=
 =?utf-8?B?UVloS1NEc0R3R2I2cUoydWQwRU1mNVBsczIxSlZCRE9KdXo4TC9nQysxakNK?=
 =?utf-8?B?RjM5dHBMNHB1MGhrZXRaYWpaN0VhNTllbjB1V21sa0RZYUN3UnJISWZyeXB1?=
 =?utf-8?B?cmZjdFNIZlpqZVY5S1hxaVdOdG1jTmJvMkE1clJsdk9mR0pUR2NyU0J5b3d2?=
 =?utf-8?B?MVVueXpNV3YzYlJFL0VOTFRrYjA0NGZoTzRmcFJqOTJjNlZoVXhRcVhTQjhG?=
 =?utf-8?B?d3FlYk1aR05tTzBCSm9CeHJjYklhSk1QN2s5WTVTK0RHenhzR1MzZVpRVFNK?=
 =?utf-8?B?aHNSVjVURnBzY3g4VWRVVHFPYzl4WmUvUDlXbjh2eWd6WWpHY3NZeEJoS29p?=
 =?utf-8?B?VTJqUVBpOXZpaEVpQnZyQ1hoUXIvOGZvSmNuTWd3bkNFdjhURnZUbWR0bjF3?=
 =?utf-8?B?amd3TGFnYjJCZ3BYcWR5bXM4cG4wNmN0RlpJYWhROXJJZ3poM3J3RVJLdUhp?=
 =?utf-8?B?TWtKbFh3U0dxVWE3anR3UW9SMzFvYnlSQTY1a0YxeWhIem1LVjc2Uk5XTkU1?=
 =?utf-8?B?VTc3b285UTBPRUMrMUVsVjA3eDhkMVdrVndNblNZcTJubStRRGhacERIY3BU?=
 =?utf-8?B?VlBXaTh4VzFRd3F6aHZyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2NObnhBQ2VyaWppekx0eEV3S3Nya3NOSVI4YWd5c3JyMG9CVHVRMTliczdj?=
 =?utf-8?B?ai80U0M1TWhMSldKeTNLZmlGMUdzMDQzNy9HeVZiaS9hZmFqSVRtaHhUQXVU?=
 =?utf-8?B?RldOUnZUY0hNK0l3VzFreXZ0Vnh6bTZPcVA3QmNRV3NCcGp0QW5jTGsvS29t?=
 =?utf-8?B?NHJCQXNmbDhBRjAweDl5ZURIazlWZUNGQWFXV2ZkOXNUTFB1Y3pPM1M3RVNh?=
 =?utf-8?B?RVhGS296cnFHTzMvWlBsY2hyalBncERBK2JrbitTckRzcmpqazdVbVJIYTRM?=
 =?utf-8?B?aUc2YWtCK1NUUnRib2I4b0o5NlVmVFMzNmRIVXNDU0NUWHVLVmdOVHZ3RUpZ?=
 =?utf-8?B?K012OUVqL1g5M051cSttUVRGME5YcXJtQmdKdUdvWnJLcHFCOXA3ZUc4RlJB?=
 =?utf-8?B?MGk1Qm5nN2FmK0JJWVQ0VFJsZ2Y4RFpWK0R6V293VVNXVEE0c0U5bEdua0NH?=
 =?utf-8?B?djlraWpxU3h0QXNwSGd3bzRHdEtJb1FxRkdmaFRmd3k4VThOZWZMTFBNS0dH?=
 =?utf-8?B?L3JnZjg1UTJOWkpDVE9wMS9mQXYwRWFsRjFYayt4cjJxa2oxUllHN0dWSS9Q?=
 =?utf-8?B?ZXpFVk5xYjJwQnNnVEk4OGhrUFBTdjJaekJVK1R3bUNmUVRvSkszZzBpZXNE?=
 =?utf-8?B?RTYwRFdqV3VuWFdiYlg2RzkvVWsxTHo5OVhLTk83SVZoUVFWeERkcXFSM0NR?=
 =?utf-8?B?NDBHUU1QSVYzaWZTc2cyVU5wNE5FbjNpbGZGbmV4WG42ODRGM0ZtVWxnbWVX?=
 =?utf-8?B?UStoSUlyRmo5K3FMSE5IUloxTW10NDZOVFJIVENIMXV4czhSMGVZNzZxVVJw?=
 =?utf-8?B?OVVWWldmOUIwT21CbzlrWXFwaVpVc01HTjJlRTBURjBMNVNOMUpLS01RVm1l?=
 =?utf-8?B?aFQvYm1uQ0xQWVgzZjR1SnBxVGNLVlFZUmtQT3NOZVJIOWFSTFQvZkdhSzBw?=
 =?utf-8?B?eUNxYmREMXlURjFsbmhxU0p2R1dvOGoxRDlaOXg3dTZaMW5YME5IdG5tUVlI?=
 =?utf-8?B?MUp0NGROOXRyTDRSbjEwa2MxUUVtRStQYVl4NkVrU21UejVSSDVabkZ3NDRC?=
 =?utf-8?B?ZzhCakZjSS9NUUZoTERyR0xNVzhZL3JzMUFkWks1NFczVkh4bXFobHlPUXp1?=
 =?utf-8?B?dlVwTTRwckJCb3ZtUGQwdmJEZjI0bkszdTNvL0JibGtCbnhneXNUMkpzWVlI?=
 =?utf-8?B?elovcFVpUkF5YWFXVG1CTERvSkY3TmRIemtJbWVQNzlUZFQ0OXBKejJyMTRL?=
 =?utf-8?B?UnltZlhScnJxQk0rYThyVE1pTlYraDljdkdTMFBmZ2J0ZWVBeFNmL2VaUUlY?=
 =?utf-8?B?QTBBaStabXhmZkNmc2toNFkrOFFuNjEwNlRyYUx4eldCeldpNTd3K0FGYndv?=
 =?utf-8?B?ZHBCeVNieEdDQlNlamZPWnNwdWt5QzlkbkZXSFZLTXlkMEtCWTAzR09rWDJW?=
 =?utf-8?B?cHJnOWpPaDBNRTBoU3IvOGNGM0JGSVRMUGkzT29FUEo3M1NoL0VlbnlIQVJF?=
 =?utf-8?B?cHYvSTVFa25NUnpkc1h2YXRKN1VLbXhTVXQ4UTFVdURXcFAzcWk1a3pxWFgy?=
 =?utf-8?B?TksxRSt0U0dmTHNzMnJ2UXhGUjZHY1lhWWxrZGVVWjhjczg3ZG1Ma3U4UThZ?=
 =?utf-8?B?bnByQnpKU3RpKzBtSERYNi80N0pwcmJhVWsvT0dtR3JTUFNYQWpyNnB0VnJo?=
 =?utf-8?B?YWdZQVpzR3M0dnQ4a3ZJM2RLOGd2aElxS01zeVdFQzBRYkd6N3VJa3lsaTZo?=
 =?utf-8?B?RWRqMjZhY25vcENoVEJLdXdXeGJuSCtVbWhtL21IcER3OXRhTDdmNkpjdlNR?=
 =?utf-8?B?QVA4SGdpZTZKL1RmQ09GT08reTY5dHliYWtLMjdLVkRXMzRRakpBN2pVekZC?=
 =?utf-8?B?UzExOWdBZERvK01xenNUTnRvMzQxekRRdU5IUU5DdWZZL0tZL3ZDbWg4YlNt?=
 =?utf-8?B?NTFZR1lEcmVjZ0lCVTBwV1VlOUQzK0xyS3d2VjR5TS9NK2NPNWJHckJueWU0?=
 =?utf-8?B?cGRpWHVWeEdUNlNyaG5HcUx6a1FJbEhqZDRSaGR3Qnc2eEdvdmh6dUwxUGlv?=
 =?utf-8?B?bDY4ckxjQkp3WmRzc0FlL3NKMXpnWU9EWmZ1VWwybVdtYzVYMWJlTEdFQVFI?=
 =?utf-8?B?UDdrOFE3Y1J6ZW0xQzNnNXlCZDNUb2hXZlp2NTZYRnFCM2xUYkw2WmxFZ3c5?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2917cfb-82d7-4297-2486-08dd653e7141
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 10:28:22.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5dw95UqIJigCQr8lhVoyl0ZfneRTMdz5xWA17C1X2uDxfhgDrD0de9HInrXMB2QkyW0U7272iQB4ScaXgDMUDVmVnnA/RDjK4AUq4GfmTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com

On 2025-03-14 3:38 PM, Ethan Carter Edwards wrote:
> Open coded arithmetic in allocator arguments is discouraged. Helper
> functions like kcalloc or, in this case, devm_kcalloc are preferred. Not
> only for readability purposes but safety purposes.
> 
> The changes move `devm_kzalloc(dev, sizeof(var) * n, GFP_KERNEL)` to
> the helper function `devm_kcalloc(dev, n, sizeof(var), GFP_KERNEL)`.
> 
> Here is a series of four patches within the Intel/avs drivers that make
> these changes. They are all compile tested only but should have no
> effect on runtime behaviour.
>      
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> Link: https://github.com/KSPP/linux/issues/162
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>

Hi Ethan,

Thank you for suggestions.  The code looks good, I'd work a bit on the 
presentation though.  For the avs/boards, please keep the title cohesive 
i.e.: do not drop 'avs' scope:

	ASoC: Intel: avs: ssm4567: (the title here)

Do that for all the avs/boards/ patches.

Now, in regard to the title wording - please do reduce the number of 
special characters when possible.  It makes it harder for kernel 
developers to grep for things.  At the same time, being cohesive e.g.: 
'()' when mentioning functions makes it easier to differentiate 
functions from types.  What I'd suggest is:

	ASoC: Intel: avs: ssm4567: Replace devm_kzalloc() with devm_kcalloc()

Plainly states _what_ is being done. Your commit messages plainly answer 
_why_ do the changes so no update needed there : )

--
Nitpick:

Signing off cover letters is redundant.
Also, I'd suggest to leave 'Link:' tag for the lore.kernel.org links and 
operate on references instead, e.g.:

	Open coded arithmetic in allocator arguments is discouraged [1].
	(...)

	[1]: 
https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments


Kind regards,
Czarek

> ---
> Ethan Carter Edwards (4):
>        ASoC: Intel: avs: move devm_kzalloc(..., size * n, ...) to devm_kcalloc
>        ASoC: Intel: ssm4567: move devm_kzalloc(..., size * n, ...) to devm_kcalloc
>        ASoC: Intel: max98373: move devm_kzalloc(..., size * n, ...) to devm_kcalloc
>        ASoC: Intel: max98927: move devm_kzalloc(..., size * n, ...) to devm_kcalloc
> 
>   sound/soc/intel/avs/boards/max98373.c | 2 +-
>   sound/soc/intel/avs/boards/max98927.c | 2 +-
>   sound/soc/intel/avs/boards/ssm4567.c  | 2 +-
>   sound/soc/intel/avs/pcm.c             | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: da920b7df701770e006928053672147075587fb2
> change-id: 20250314-sound-avs-kcalloc-91cedbc47074
> 
> Best regards,

