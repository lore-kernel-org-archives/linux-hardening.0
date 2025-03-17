Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAFEBE;
	Mon, 17 Mar 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214646; cv=fail; b=BNFvXNonqO7SxPv0Nxe+fa/6w2iUD89YZ0LOfOvg4ABq0aanCxNbo16OgsjpPI5y2BIwTZD0ihW9JPGDDrg+uz4+y6b/yLyfaaurDOykY8rY5eOKhVmKFiPONpt1uxOHj4RF+Q33tWYIdGb8b+3DpJp0uMeMjkruX38VBC/7n1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214646; c=relaxed/simple;
	bh=S77iVcc74T6reXZKmT5PyhyG6lQpzycJ3bb+OrCYBb8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ojFha8OA3X7rg0kx4XL+Gsc6M9qNB3ezH6YnSZ0vf1C0XI91vN6GN+Gvet/gA8iG9+P1/F1jp2MSHwa9B1k8sCvNeQdOSSxF/RC+LUmtYzXM1wdqNbnuRJMTSy4j4Ib5XlsbPvvuKhumDZkS5os86D5HtBPi8d9Dej662CUR5EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfHpQA19; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfHpQA19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742214645; x=1773750645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S77iVcc74T6reXZKmT5PyhyG6lQpzycJ3bb+OrCYBb8=;
  b=FfHpQA19htD+jccF52Voi858JLEu2ckyC68Oj4wKofqu+14E+5lrVX2Z
   r1COex8kaKf/Y7Ra98E17kAqW2PvTlLPM+xUY08XOJHos7e1Qp3CnWcpF
   sZSbrTeSaeOzm8rqLXjicwwArdc0mE6sGucXrpoVlZv47xdUN/0qafhxD
   uTpQRLHXtj3BoDrb0BtczXeqH3ToYWEowSjmpab0HYfzAUSTi/vWgl0uJ
   U2VWuZ44Q8lqtoe1IEb+Friula3ujf8Y9Oymm+HKv7EACLd0pekRLbaTY
   k3f1rwyYheaRkuITM4Z3LRhvwTV6hqGiQsxXYI3+sZVMXD+jLSPHTE0fZ
   w==;
X-CSE-ConnectionGUID: Axcm9t0zQjelga39pvaK5Q==
X-CSE-MsgGUID: fMQmT30ZTPOSPOHXBLpD4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="30890264"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="30890264"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 05:30:44 -0700
X-CSE-ConnectionGUID: vR2PkBV7RXCwyjrT1Js4Iw==
X-CSE-MsgGUID: Au4V+rx2TIOG4OWfy4qNqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="159076817"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 05:30:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 05:30:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 05:30:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 05:30:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqUto/aSlLJ3HOJYzXTF1yulmCMgfAAFpX+MHsKt0/WSz511Y+VWZfFoPDxkj691s9Nzjs4jd6M6fVH33fiQKtapM1v5A+ZNVbk0wfYc/iH0lkbfu35H8u+djL8i/+BTc03EZF1xDnxXM2G5Qw3Jej4m8UUJ1Z8Q309ytfqzMPXlXTRMNysMf84mWFQ+4OcG5xR0UwrOn8HoKksttNl1v8X2oiyroOZSybViHt8OJoVJl7L6Jzai25WFuUeVH7DFjRv6CEfAqpCNgnA28K8YkCeBdBh4WxwLLap2dE7uowXq7cxDt4Vrwj+jU+DudCc16rpDiQXJLonTBKX0cqbEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMzbsJPvf3/FZywNO40LkUlBWntaERtvATwM9k5NHeQ=;
 b=hiAsSa4D7UNfW+pJsPmNwMGWokPcr90mbOkISYJ0AxTetdPROXNjLVLLuYhO6bEsyh7tK9H6rsgeESLe9OGijO+1NmT2UQBrEpxzioK+z1Kb7RL3f1ap55apUs/v7WELDjNilB1wnZ1xKSom0bJpHThmY9YzZjlrQDnd2zvf8wAelHxyk9EqHcRW6clAVDGDBY0Hj7Shsee//NhlO/cBgSXuctpRejOGoarkVTSrjF2GKUYueVc170EJFKgPuhh/vFI7j0rs6OWYQ3NiwpF3zZYNYKYrv3jKAQl7PqJOPWLLNCXNCa0+RnfRF2QMKZfIvV9XXv2fjDZrykaT+CRmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:30:39 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 12:30:38 +0000
Message-ID: <a2d96364-7e7d-44fa-b5c9-3cfd81f3d0e6@intel.com>
Date: Mon, 17 Mar 2025 13:30:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ASoC: Intel: avs: Replace devm_kzalloc() with
 devm_kcalloc()
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
References: <20250317-sound-avs-kcalloc-v2-0-20e2a132b18f@ethancedwards.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20250317-sound-avs-kcalloc-v2-0-20e2a132b18f@ethancedwards.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0207.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::28) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|PH0PR11MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 02db8eae-f76c-4343-c3f4-08dd654f8639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmIrd3FTUUwrZUxSQldNd1NkekxESmI1bndDaEp2WDRxYkJPb1JVQ1FOTVpo?=
 =?utf-8?B?alpmbStLQXpObmhOT2hlanR0NE9RSWFaWmNxSE5sSUNjS1RocGdmWDJyVG5N?=
 =?utf-8?B?Z2N2bVlpWUpIenE1R0p3NmNIVFNzZXd4UnZQeFUvblAyUHpVSUFRZmhRZkJ6?=
 =?utf-8?B?V2lsR0NJcXEwQURXUUplVWdyRllvTGZDYXV1b09Vazc4VWRrUHAxbERRQzZD?=
 =?utf-8?B?a0hUd0dlYUR1eTZyUEM0bitkcExSMUlxQnFobytVM0o4MmltcEdmaTYyS0Z3?=
 =?utf-8?B?emc0anVCNjZaVjZTY2VVK05DZjRJVlYrODdGcmNva3RTcWgyaHVnd1Nldkpm?=
 =?utf-8?B?V3orMkdyMnN3YWh0T0JPa0hpMkducklIVHdIajBHdW4rNTVmb2Fqakw3TzBp?=
 =?utf-8?B?VjNZNG1rTDhaaDVPMm9XZUdMdWhsMWxsdTF3d1RtL2duRlpEaGZKVGo5WXo1?=
 =?utf-8?B?UEpvd1VkR0hWNFFYU3c2NUNpMEhUWTV2cU5uTjlVZStBNTVnRGQwYm0zUUNk?=
 =?utf-8?B?UlZkSjR5cjBFMXV3cHRMbFcxdDBKTFhDRTFpUXNrV1lpOU1sYXlJbTNzbnpN?=
 =?utf-8?B?RTRJa3pEREJhbHBNYVh3SlY2Y1BFS3ZZSUVYSDBQYXRVMHJpVG4yUnhQRHhk?=
 =?utf-8?B?TFY2T0ppeFdwc0E1RGNWNHUxaWw3MkVaUFlkaHFtSW95Ri90UjVST3Judm9s?=
 =?utf-8?B?Z0c5bHdmMzYyanRkY29NeHNUL3hIUGUwYUlOMnR4U1dmVWx4bXpHaElTOFRB?=
 =?utf-8?B?RFhjbEQ4L0h5UlBQR29NYzFTYXo4MVFPS3hMeXZVVXI1ZytwYkFtcGdseEZh?=
 =?utf-8?B?cUoyaWVVaVA0MUF1a2N5RWxOVU9nK2kyNXBlNUxpQ3JWelU5bTR1T3MybWlQ?=
 =?utf-8?B?R3RnUTBJRkZJRzViU2VyQ2p4V3lMWE14bjJGSkt5ZnM3YTVnM1dCUlpZTjdo?=
 =?utf-8?B?OVdFR2p2VUE4L3krTjNDYzNZKzNFNGh5bXVvZUdqdEZnTEs0T1B3QzluMWhN?=
 =?utf-8?B?Wkd4TTBSK09FNURSbTF6THFteG9TVE9Ed2pEMkNEWjA1ZjlEUUpJMU1wTmc4?=
 =?utf-8?B?dDY2QTIxZk13Y3RvWHpwbDNlTzl3MW1Zb0VmZTBtK1BRUDRXZXV0MkZjbnIr?=
 =?utf-8?B?d254VHBja0w3a01JR09NQ3k4SzQyYnpucWkxTXdBNWNkazJEdWk3aW85RUxr?=
 =?utf-8?B?eWxkUmczNFU4czRIb2F2Qmhpc1ZFTjI2QzZGMjhpS0RTd2VCa3NndDloc1Jr?=
 =?utf-8?B?ZFFic1dPa3ovbkZIRkFlMy9rYldwSFoxNHc5dUQzSDhWQm8zd2hkM0ZsTnBa?=
 =?utf-8?B?eHlCVmJsZnorV3ZzSXloUXNzTEhaci90eXd6eHNLeU1ZQ0FGUitZMVhiSlZU?=
 =?utf-8?B?clRxR0d3RzlGQ2I5ODJnNVJWa0Z6ekg1cnZrcEhPeEVuV1hsSmNCTk9Ta25n?=
 =?utf-8?B?K2dwa3h4ZFl4MkdMTzc4NGtWOXBHL0hSK1J0TWhxNTZiVXNHSlhjYUZ5bkRn?=
 =?utf-8?B?ZmpKQjVoSWhFYVYrRGR2Q250Q2ZjZk9UbnNUdUFZUmV3Si94K1kwV1RmOWx0?=
 =?utf-8?B?alJvQ1lZMmRDRU1JTUJjcjRTZWEvZUxaejlLL0p4UzBxSEZQbDNKWkpGUGNE?=
 =?utf-8?B?eGpjNzhIM1lMaHE3V1dDZm9qa3dHWDZGT1pCWlNBN29lRzkxaE1RRHIvSWN1?=
 =?utf-8?B?TGV1UGxaeE9KZWVyMnNWaEhQenVKSVBvQkNJd0JveTVsR3NDeGdWWjRWUjZE?=
 =?utf-8?B?ZDdlY2xSOTBJbFlsd2VWUEMxdzdrUUZUcFJZcG03K0pzNmdPWjMvMU9uY3Q2?=
 =?utf-8?B?T3FMMDM2VTljVjBkMVd6QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0h3N0FuOXM0U2dwSUNoQWJwNVlHalpyVXdaVXl3bGVOUXp1MXE3WSt5Ykhu?=
 =?utf-8?B?WlJuaGhUeXBRWFZBSGdHVTJ0TjdZMUVGeHVrWHNyRElYemhrTzVQK01weGFO?=
 =?utf-8?B?Y2FWMXkvZmNBZzRoQnQzKzNHMXFYbnNTRmc5RFREM1lsaDlXcWYyY1VvcXB0?=
 =?utf-8?B?ZENNTEFCclRmbmlnc2NoeVBhWXdvVkZtZ3pDQWFoa1hVTTlueEt6MWNESzVi?=
 =?utf-8?B?M2NRNmdtZkczYURCNHc4SWFNU2hSWjRUcEcwajlWSHV6ak5mVVVQMCs4UStp?=
 =?utf-8?B?UTlUb2l1WXJITGtCSHhMdmxNblMwcGUwZ2V3UFlWOHMvQ05qMUJoRXRNNUJn?=
 =?utf-8?B?OGc2d08weWttT2tNdWRMR0RZRGN6aVJSc295NVRVVDVIRkE1cG16ZXZuMjFx?=
 =?utf-8?B?T2Y3N3RoODQ3ajZWMURBaERKazgzQmFGbk4zVm1qQTJXcTE3K0s5ZDdkdldh?=
 =?utf-8?B?bUFBa1diLzJweDQwMW5oNks0dzBFUzlBTk83VWVWRmVFbytlMGdJOGx5OUor?=
 =?utf-8?B?eTZaZXlycW9zVmo0Y0dTRHpBRjc4NU9wWitoUVFkRnF5WEhtVVhVcDFGQU5J?=
 =?utf-8?B?V0htbWg1dVVNdmpTMnRKN2REZkdUY1JYeGdzbWF0cjFEUE5WaWtFMmlhOTh6?=
 =?utf-8?B?ZnlpZms0VjlqNEFOa2JhNFJRc083SnExMi8wK1U5TnM5Ky9ycE1nZEo2d0o4?=
 =?utf-8?B?RUpLcTF6M21ZYXFVS0tGU0FubXFndno1bkF4R1dNeThqRzN5WkRpdEhwOVBv?=
 =?utf-8?B?TFdieURkdmVOL3FUbHNmTnY0VGlJQk0zd3QvSlBqNEgrTm1GM2UxSkh2QUJz?=
 =?utf-8?B?S3VIZHRLSjZKVjVyMVptdTdqNGwzM3J2M3I2U3hMSXB3aWJHUnhCaEFPejFT?=
 =?utf-8?B?QnZXeG9SSFUrUnpOVWZSZ0JNdUhaRFpBNGNlbUZhSDdsZGdmOTVHK3F6eURo?=
 =?utf-8?B?ck80T3l6ZTZROFZZN25WaEhMNEN6M2FEeitHN2NXMUd5dFJLV0VIMlJUM1pP?=
 =?utf-8?B?Q0xxUUNmaXJUelBlMEpUbnp5WlFhYXp4Q0haMTQwS2tLc05QZm5hQk52VHZm?=
 =?utf-8?B?WWlJLzAySmJTRHo3RUMyb2JYelpwanlYc2pFT012Qk5mVko0dlMyV0ZRU3Fj?=
 =?utf-8?B?L3lHRnd1bm81S0FCU2lxOHgyOFpuamMyRkJ5M3pkLzJ6RitKOHBtazRWTCto?=
 =?utf-8?B?WXJBeEFNdzZZZlZoUmN4bWhnTGZZdzY5aFBCWHpGZlhNbXpCQ0FDVlBXYmtk?=
 =?utf-8?B?ZlFUTVd0M0Z4azM1cjJhaW83NnpKbDkwTTc3Q2M1TGYyTzBnSllYOUtoWFl2?=
 =?utf-8?B?SDd2bWhlNGpIMmhhNDlsa2htQi9wOE1TN01EMHJNcGs4N0xZb2RVQ2p5NmZh?=
 =?utf-8?B?Mm9CQ2x1MU5pdy90L1M0TTRXb01KeU5FdXZiTmhCRE13NGR6UzBJbkFkYXVp?=
 =?utf-8?B?RHdFczZKYkx3UTZ0T1J1VHRiTzhIak1iUHNsR29FUFB4WE0xTkNYQ3pLRWtv?=
 =?utf-8?B?TWdtLy9GNGtDTjU4UDl4YmF3eXpSRms2dGlyZUl2N3hsZis1K0NvWDMzS2pY?=
 =?utf-8?B?RjJCNW5uWTdzYUE4RWtiNDZhbGNZWUlBNmUvRUQ3Wnd6ZXhmTlM5WjRrczhv?=
 =?utf-8?B?bitxQ3ZvdjgwMmhpcHBrUFYvc2FTZk56cnZaNE9lY1h2d0VrRThyK3Y0MStI?=
 =?utf-8?B?dUJGM0FLd2RzOStrZU9zZzZiOTFkV0hZQWRPbitXM1ZIQ204ZDdmeEZxTUFJ?=
 =?utf-8?B?WHVnZ2ZZbkNSVEtqc3BVemVESVhnY2dHSXRrWm1sQnpobDg0Nkh5V0VpWHhP?=
 =?utf-8?B?eTZnS0ZYRHhtcDE5aXhMdzYzalhJc00yMy93ZFVQQ2lkZTd0bzFBN01BcjVZ?=
 =?utf-8?B?eHU1eUFUSzVhQVVPcVRWeThTeVF4azh4SVNmazM5ODZnMnE5WUljV1JGWFNw?=
 =?utf-8?B?aXBSMzhUeitPSGg1SnR6MG9xM2RiYmlCMTQrV3lUZW03RmQ2djBpYUs3ZWRE?=
 =?utf-8?B?em1HZlBYTkF3bkNQYWFuSUNFMVhTZWR0VnBJTkZNQUZkRGdmODQzSlc0bmo3?=
 =?utf-8?B?SjhOb3h2UjB1RFRzV1J4a01iOWh3Mnh6L0d5UjN4MUREZnpLWEdLMVl0dGpP?=
 =?utf-8?B?VyszV2ZRdVZyR3BQbFNHU3JvV2xHUFRvQ2dNWnhQUmt6MGw4elBPbGc0SlZC?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02db8eae-f76c-4343-c3f4-08dd654f8639
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:30:38.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CzQ75AR5BCT9UHxmGOWOUHPhyjXwN3ybF1ofxHtnAb//b+tvNdMb6Wwhi6GDUCHmzQu201wHZ4zd3KLhbm6YxJeIWlI0CsQCIno65D5bKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com

On 2025-03-17 1:21 PM, Ethan Carter Edwards wrote:
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

Thank you for addressing the review comments.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

> ---
> Changes in v2:
> - change subjects to include avs
> - change commit message to Replace devm_kzalloc() with devm_kcalloc
> - Change from Link: to [1]:
> - Link to v1: https://lore.kernel.org/r/20250314-sound-avs-kcalloc-v1-0-985f2734c020@ethancedwards.com
> 
> ---
> Ethan Carter Edwards (4):
>        ASoC: Intel: avs: Replace devm_kzalloc() with devm_kcalloc()
>        ASoC: Intel: avs: ssm4567: Replace devm_kzalloc() with devm_kcalloc()
>        ASoC: Intel: avs: max98373: Replace devm_kzalloc() with devm_kcalloc()
>        ASoC: Intel: avs: max98927: Replace devm_kzalloc() with devm_kcalloc()
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

