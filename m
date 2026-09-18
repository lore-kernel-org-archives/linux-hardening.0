Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45882499F07;
	Fri, 18 Sep 2026 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718420; cv=fail; b=qwWIhouAaQavCWB3nS9U069TamauCg45g5LF3q17o8BcKsSR0yi8DAppLMGxY75ZaUuw+sSSrKbRvN0MIA04ZLBj0VcRCherMPhRUNpDxeNSUTea+l+JjL5JWf829NYnFv2VT/0GNKRMSZH6Ni1wcQdOzy27frJ3sR+4ILMEyH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718420; c=relaxed/simple;
	bh=f7j/m6YxgUUGLqxryUVkEdTzg++SiJlWamR7UGNsQoo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u7WHXG/YO6UDq3nPWajmHbdBlkpy5LCw6rIWVkqSlxkVSWq+XPC1HUVGlaqM4XWFjTDvE6Bll2126DVjqN4xAJHlduCJ2Q/Ohq7+eCjXvH8WzuFQw14yh+wQzfxOCtSlXB5rUUYVNESvpnDDDFZrCqTKpU8IBVYRhK6Vo3wGNOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUgsPgVA; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUgsPgVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789718417; x=1821254417;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f7j/m6YxgUUGLqxryUVkEdTzg++SiJlWamR7UGNsQoo=;
  b=FUgsPgVA0bCpdtqgzDq9lUAhXqv+KGKjKHNboTz9ovAs7rC8FCQDuao+
   Qo+rCH8x1/s1mxnsEuvYE6GQFuiFTSyD6M2TakhQkXfXL0maJadR5emi0
   WqCNgMQKW1NBkWZbu3g1L7DSo8J8lvqiI7GQ1cyKkGm7FE9Z9lfuHx1vJ
   1AEPXBMU+hOa8Xt8jp74TGLp1u3n/pt9J3FwP+WyhDNZZAj2UWQzRXd3x
   bgFjX21+cKzrjSQbhGnesOLrbqQL9SJZNHvlI82lCjBGR2pUOnMuBXvqd
   SzjDPFIoEuGILrZ/SrkHJUHREej07cwjkq93oqSs4+hN+Wxjp0l1hO8H3
   Q==;
X-CSE-ConnectionGUID: 861mcAsBSei1TD19HYfTww==
X-CSE-MsgGUID: M6lPU7I1Qa6+ltSAU+ZXvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101554398"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101554398"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 01:00:16 -0700
X-CSE-ConnectionGUID: W4+/GpAHR3mfGVcDJkE9Ug==
X-CSE-MsgGUID: dXKXh3P0RA228IYR5SHTXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="299373237"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 01:00:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 01:00:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 01:00:16 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 01:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1sx2vfthDeTxHJ8waBSIhGUnCIhBls7PNk20WHKuzr9cOWHOLs0udI4VEj3E9QxQtEOeqNlmMsiJqznw2WVxuBDpTiSnCyUUOBweDI+G+P9lKrqFp2J3Py+tRWOiTbgAkTCm55FxOlCt4ve6lF3wX2aBHyroWEEfNXH1wx40QMaEtdeqCT0xk8D0spAT0uVriueYAzqkEXsrg/I9QCGnjpUJwBrwvZag8ejq8a/UNSLk3ekWC1vgEHxEtVwEKugWuIzSPPZ6B7GoZ8pbydwZ7xmebxH09fBqlV9nQvXVOTLKbrTSfanyb+b+I8vakGjuOCt+lleMSQFijEqbZ011w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af0RswwoKa/qCGkdix3WK9jlQ2XSyUYhMjR1JKS+xbY=;
 b=uPBE6O7xIHZB2mCpM1j7r+9HUaGHwX0GBtaoJR7cGX4KKE1Dh4MYEhfX/72ddltMRQITM9p+u1zfYi7Q6y7iJzQuFJ3sKPiKI+WlmlXM2PNCUhOLtQbIYUuPtg0G9Ga9D0RhEYNMa+PrjzVcpz9EP4eVEp2hLPhMkf6OnrnR8+YNvs4i7+JIVnMCb7+Pjes+KbIr+TN4ZRkEL/TiQGVPGCJQbOsr2wUTlzNT4JRsYWVU+0h1t0H0oTETOYNpc8X+2BT7EKP4sED2j6SUUlOhTpa0BEzNlQzzHCf8N1A/dAyLp+X0/peVtmcqguAeY5/rJ/wPKWrMnan9xD7k4MlfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by PHXPR11MB9663.namprd11.prod.outlook.com (2603:10b6:510:3cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:00:11 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 08:00:11 +0000
Message-ID: <b6409b6e-0a82-485a-b45f-0b291fc55a3a@intel.com>
Date: Fri, 18 Sep 2026 10:00:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: wm8958: Add const to enum texts allocation
 types
To: Kees Cook <kees@kernel.org>
CC: Kees Cook <kees+treewide@kernel.org>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Richard
 Fitzgerald" <rf@opensource.cirrus.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, bui duc phuc <phucduc.bui@gmail.com>, "Al
 Viro" <viro@zeniv.linux.org.uk>, <patches@opensource.cirrus.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
References: <20260917211102.i.029-kees@kernel.org>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260917211102.i.029-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0083.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::7) To PH7PR11MB6006.namprd11.prod.outlook.com
 (2603:10b6:510:1e1::13)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|PHXPR11MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 209e2ecf-5934-4534-f624-08df155add4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 52fwRAqmt6YpSAkYtAZnbj0rKtaciS+zr0R7pOdvarnhb4SbI/6jaTV5+8boaveB4iMuEqofDnuUynI8u2seDaBRu2TPB7eeAH6o87lHywUfv7LNVn2JxVN2ZIzh6u8prGZ8ineaf4tZ8SjAgRUwr3EBFsf1+9E4pA8GYj48zUQnIMvKEE+7VqmWUq28cWLWROIHhJLhThqZwrOWJ9NhiKRlTyAXQj80C7xJ/Ff9KBxVEz+UyzFYsAeOuXCbP+TIwlSTAzvXud7M8JWn4kj2OqgbByG0Lf4dJf/+xUP6Hpme3Plqij9txxoNXfFN6WMteD4UGSLwncvzV8eFQ7L25hD6oAt4XVpk+hMxN1MnGWpfRq7ZbTzDbIk7qH747ILdMg/4r19uE8LjGCrVwU1xx2qZv+uqxakCb2UOgson2o4jwizkwu3G4aUxGw28BftpbmzYiqKAZZXdiltK6mJCCBQ76RSAiSXvpYWcmUjx1BUky2SF2BUuHOhubncejHGPp41Afr2hjVrCDQKor+NPeqkgSk64ZcXiJFDZxXN9uA5a1Pjw9gVC5dc1YRmQSPuqq5Bb69RuvshFWgRAcOXnyEvT4hHOLuEpNiQBFMpLJD+KJ13RSYRDOW9LSgRw3q8YEDrEDfEysIZwigsla1BWoaQhOHeAp+BPgUb2GEaEvqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2dZakF6WnhVN21scDZVb1VORU9YMldvaHg4S1VraEdmTkhRNDdrazluNHdU?=
 =?utf-8?B?eTFhUGx1Q1o5QnJITEtwdHM5aCtDS3JGTWMvNGFqc28rRWNUU3pQL1VvOGQ3?=
 =?utf-8?B?K3AvbjJrN2xzcjZ0bzZDL3NEcmJZNlhsc0xaZ0VYWXVveXNaR1E3K2YxSEJV?=
 =?utf-8?B?QVZ0SnB2cjFVTUFtNDkzMURYN3ZpVGFoOHBWU3FPWmw5cEYwZGxib1Y2Q0dr?=
 =?utf-8?B?ckRVWFJVakMrQ0J4S0hiRE9WV0gyelZBZ3RCazVrUFE3bGFyWkRDZGtYcnFL?=
 =?utf-8?B?TkFJK3VINVNZaGpBWFRjSmMwUkFCVzFPUGNlNzlSWjhyL09sTW9BbS9lTzB5?=
 =?utf-8?B?VmZWSkpaVjRWSTRRQnJSNnp2NkVaMzBhUmZWQVQxNy9tQXJkQ0ZlRkNVQWZt?=
 =?utf-8?B?aEhsSkhIMDdZTmJxcGxTVmg5UnE3R1grV1pDWERUUFE4T0hmcmVENHZyeHUz?=
 =?utf-8?B?VlliMERqbWlmV3ltWnlHR3J1N2FMeWxjSUJNd1N0S2Fjc1JxTEZYLzdhU1F4?=
 =?utf-8?B?ejlYdzJDNTJrd2pDVVJveVdXTFQzZTBENFpSU3hJdkY0a3V1dWxoVWpObUpU?=
 =?utf-8?B?QlZFUEVDNCs2L3R4ZExZSHFLbmRnUVh2VjdXYUlzbC9QeFd6SHIzQ2xGQWVj?=
 =?utf-8?B?eW52bzVtTXExL0E1dmt6NEFobWQwZ3VMRm5WQUlTdTRqTk5IZjRLT3dCL0RX?=
 =?utf-8?B?Vm52N1dudUdVYWszSXVvdFEzVk1JSjZKa3lRQ1lmWER2aG5jaUFGbWc5OHFi?=
 =?utf-8?B?bzBKcGw5QngrM0dsMi9HSStHL0RjVVo0NkZ0UlFIS1BSRG4wK29zNVJyVDI3?=
 =?utf-8?B?YzNwZDU0akYvNlFZa0hrNFlpd3JkWXRpSVBCWVZUNjQ0VnVuM0lSSkxNaXor?=
 =?utf-8?B?OUtwMk1jRDM3WmlkV0luaEJpbkpCUVozK01DRnRFdGF5UzAxWXljc2p4QS9B?=
 =?utf-8?B?TnFsMGlTcHRQTkRidmhFU0c4UG0yNTA5dlF0aG5YVGZFWWFDTUdTbzVJbzlh?=
 =?utf-8?B?SUR1NzBUak13REo0YUY4V1dWcmptUVFqUnh3bG1kdkNraE00LzZKN1luQUJU?=
 =?utf-8?B?N3hORTg4S3FsdUE5U1FNb1FJYzRUNzZxWjdJNHB3bzMrRXNYVlAvWU5tOTdj?=
 =?utf-8?B?NGtPYWdKdTQrNWxmZlBuTzJQaG8vdktrc0JXaG9IUHZsWktxY3haa1BLSVA5?=
 =?utf-8?B?OUtITW1GTVJ2NHZySVgyNXNmVXluZlBiUGF5eFE2TDdhWHUvUFBnak44SzI2?=
 =?utf-8?B?VXFveHoyV1owemhBRHJMY2xXUXFGR2h5RXFFSE9yajB0RWlBSmRNQzUvUEdv?=
 =?utf-8?B?blZueHpmVzE1NC9mMkgvL0E2SDFnMGhEdW9GaGt5dlFCNkVDOGdKV1hqa09N?=
 =?utf-8?B?TDEyZzVGbUJXMUUrNkdyV1hRdklqV05TL2s5dFIvWmZVVmdURnJweVEvRGhL?=
 =?utf-8?B?RjdmMUhSUWpoYkxUdFdHWGRQS3o0WU9WM2JIZjFpWWNXcEYwRVJnMmozbytz?=
 =?utf-8?B?K1p5TDJzcVVzdnhzWHo0QXJkVUdTRm1HTDFDdkNqK2cxaE96QkFPcWF0YkVt?=
 =?utf-8?B?dDY0WHVONzFlU1JGR1ZYdWltSU9XMEY0Ylh1MkRqYkFBUnZxVExQZWRmU0dD?=
 =?utf-8?B?elh2cWJMSWtqZEk5SjNRcDR2dWE1RTNrWjl3NjFraDRpL2ZZVTRUSmRBVkl1?=
 =?utf-8?B?dHpjQWJiamZQMVllbjdUS3QzNHdFWVlGSlBnMGJIZXp2RjBTNGVpYUdYZVF6?=
 =?utf-8?B?WDdMVFVVbWhjcDgyNE9YdGlLaUlQMnVtaFdyNTdvZ2dSd3RkZUJmenBXWUxm?=
 =?utf-8?B?RS9MOCs0L0pqQkdGK2IwQnNvMEVtRHA5UjJOenVldkJxNWNzMmJ4T0JFUEFy?=
 =?utf-8?B?Und1M0VudFVnUlRoaFhET2VpRWdpdi95NTNnQ1haS0tqNUQrcTZRNzJLSExr?=
 =?utf-8?B?dno5ZUlEZGhZc2d5bG1XOFdCVTV3bEl4a0pSeWIzcDV3Zm9hTkNzcnpxSkVk?=
 =?utf-8?B?YytaZmNCZ0FHanAwT3dKN0QxaytIZHJSWmRXYTd3R2RhTlhHNnl3TFFZaFhk?=
 =?utf-8?B?L2hCdVZieGROUVp1Y2xWeVZDOFY1clgzY3FzbTk2M1NKUFZSeklnRVNJL2ho?=
 =?utf-8?B?L0RqWHRIaXdQYXlBa08wOG0xcWlIeEpYOW1nb1J5b1BkaFJ4c21CcThJQUQx?=
 =?utf-8?B?K3RmZWpUYTdaWHVGd1RiQVFDWTNWWUJVVFZGZklUelhWdmxCbDhjZ2lhUFRS?=
 =?utf-8?B?NUl6RDlNQXR2SCtDNnJmVlBvcGJ2KzhORm5sUWYxR1Nsc1crTUp1dEJTVHZ6?=
 =?utf-8?B?SlV2TGoyUmJYNURqL2Zpcm1EaFVWelg5NEhNU09QUEg5MnF5dkpLdVUva1V6?=
 =?utf-8?Q?6eqUcoTdD/ba8DJg=3D?=
X-Exchange-RoutingPolicyChecked: UAzUPyQmi2/gOxrpefyAigPgG8P8PE/FSmVDxxdO1Emm3OIfeB7xrEQBRc+pP3IwFRZiji1mUwzdU1mYTYQ1h3K3cAO9xEpSzMDNiEQdqppSVT/dipYyKTR6rYV1JD2QcWEF0YAvW+mraF+TSAlqiZ6MsseZWWYcISe8rw6rfiwNhNsGTdT8Ic2x4mxvyX4yqaC5HjqerpFzxJVnx+TbxApa6GWcTz+hGNTgufkkEsDWnBkO4GJIemVWqPj6bdmvaj+NJMvTL9DUFW/Y5obPe8Di6mJ2gSqQQXzY/ENmZvpLAYCQ3ksp1v/Eyr6mZ2/i/PBduL2kuUXCkTCb+2Ohsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 209e2ecf-5934-4534-f624-08df155add4e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:00:11.6452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYpjtNbwtdf3tgEE++bsgIuOaLd64tcSDvc3rdEMfTk9vKm++oTrQ63ibPS1rE+KVNin+r5pDFxLmSL5H7X7HeIutelho0TbSm9CvlHBWN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9663
X-OriginatorOrg: intel.com

On 9/17/2026 11:11 PM, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> The assigned types of mbc_texts, vss_texts, vss_hpf_texts, and
> enh_eq_texts are "const char **", but the converted allocation types
> would be "char **", which is the same type without the const qualifier.
> As there is no general way to safely add const qualifiers, take the
> sizes from the assignment targets instead. No change in allocation size
> results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> sound/soc/codecs/wm8958-dsp2.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: bui duc phuc <phucduc.bui@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: <patches@opensource.cirrus.com>
> Cc: <linux-sound@vger.kernel.org>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
