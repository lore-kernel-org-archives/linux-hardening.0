Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564644C6C;
	Fri, 23 Aug 2024 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387291; cv=fail; b=NdQkn+3GDzNBZPQQqq8u2B5Lo9NyhYunazO6TeWUHhcT3Rsgsai5tpEwwF5p7G3QHU1flneUiNpe7RoKsCxBW7R3JSCO6TpoebbCfoOGp408+liIYIJDnEV7a9lN+XqdvFkzpdrshLf2qdCijv6C0q4BceUPXT3d+BgwsebugAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387291; c=relaxed/simple;
	bh=B+IiMUT6Sd6yoWKVda19if18KgWyWM7JHfHO8gxjzDk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W3tnWS0XakTkAX1fG7BDIzHAXNqRIrZmRZvVXJa7yMY76LEVtEyJMR0BLGMNNYktwcOCvxdhuXN4SWhVQU9TYRVukSIGt4icwfJf6Ocg71oZE7GUb99ojtH+4JVsO8FjW8xB97fEcZofIFmhMAKL0iVF5yg2kCbGYjnuxmna86o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XT8RXzla; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XT8RXzla"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724387290; x=1755923290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B+IiMUT6Sd6yoWKVda19if18KgWyWM7JHfHO8gxjzDk=;
  b=XT8RXzlaEkhU2ddV+6MWL47C/rDw40EV6ukLVw6YvsW6MSNL4aVQqwba
   mhMjvuWr1ioR3FF8Y5rt7iBWCSyGL1j29a6hYBFXBu8+Z9wdVF77Ekybd
   EXrpLsnymUPNP8/hWGo+2Gc+VDCMicpFnQePUTkzN+Bsfmlh75QLO5eRN
   8hAxohmdT7iSWAwebpFBH7fo2gzmwQPA4gJk1aBXxjAuLPcux4pzOOrOk
   xXfGuiFTc1sNbdrVg+yxDgfR2aWA6OviCpasle/Nkyx1kKas7i6vslyky
   9L2Sqi/SOfwE5Yf/G/ofzQHR17sUNKGBqI9LEptMPHJU1oaaph3WOuyGA
   A==;
X-CSE-ConnectionGUID: /u+vN41oQZeLEMFPrwAWgA==
X-CSE-MsgGUID: KYcVlGxqS/i5NeQgefW7Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22964785"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="22964785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 21:28:09 -0700
X-CSE-ConnectionGUID: pVwcFTSvSRiBvDF3pYwSmA==
X-CSE-MsgGUID: YpSY1FkgTb6clzY1c8OhpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="66504764"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 21:28:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 21:28:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 21:28:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 21:28:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 21:28:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+wwS1SIVD0c9eDDTUhh3CeQ+pakXwjcpauglsLoboclQ5sTIT6t0Hdk/ICkTZa/TVdMarT9pS4+5ypk//Y3JRe7h+aX2jm/VJSNUhCDUH4OP9P8gtxh+tSDYIofCu+Q0l6Y0sMzUsQN/tPzKBoB02ejBPJTLDhFlJwJN1VpgBsnLTcxgu25EFj3VhJEChdxjG1i+uolKP3y+eXK+0Ng/ABv40XuHaEjV3Gd/l35vQc9mbuXTTjwcKagNmg8c/L9w+dhYgB1AkpVlNQ/7SlQnXBr3UM/DZ8ptjF2Xyvlif+9JUqpUOglYpF+Y6TAtMq9mRPGl8+60p6VqcCte0Girw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX115o0kOqQLidFppF6Uji35LtYve1B0Nm++OqJyUxQ=;
 b=bNr11BkAgTQMz2dbXS4wxvhwY1dTncQM/WwPGry4ibepQ/ZaM4C4XHO+i43lKnIMn7aJqjhCBvmqpQfG0QCIb9WAJLSupP5GXfT+7Wb3A73acm0vkZppctnudgdL3UvGIA0vjycRUwmP/8sdrCKvEkUwVLRRDT+6+ome/sMQ5cQDwbLTLihWdLDFIe4EdxDaMoRaMOoX/WmMKSNWCNdMeJFJKz/xDQOEBzK3ozccrZWCmjuqEP2xnDlx9KyAW9s8HOHkWDI3z9q3etTDj6tOvr97r7mG9D4WOm5nDGXv3d9IougIWLgs/GWal1fALlUNEcJem5SfrDA3lKw517O6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by IA0PR11MB7882.namprd11.prod.outlook.com (2603:10b6:208:40f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 04:28:06 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 04:28:06 +0000
Message-ID: <eae36648-6f9f-486d-b352-c92a315431a1@intel.com>
Date: Fri, 23 Aug 2024 06:27:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] slab: Introduce kmalloc_obj() and family
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
CC: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew
 Morton <akpm@linux-foundation.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A .
 R . Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, Jann Horn <jannh@google.com>, Marco Elver
	<elver@google.com>, <linux-mm@kvack.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<linux-hardening@vger.kernel.org>
References: <20240822231324.make.666-kees@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240822231324.make.666-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::19) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|IA0PR11MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d8c1cd-d02a-4b43-ed03-08dcc32bfc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnNpTy9Ga0Z3RER1cVRrZFEzQklGWU92RjBoRFJBYzBVL09ONTVXTE5RRXFz?=
 =?utf-8?B?R0gyZlBNb2FMSFRrWmFRSzEycGppQnc0bFRPRWVvREFtekhlaFR4b2paS2Nq?=
 =?utf-8?B?ajRsL1hTS2E2VEU2U1plS3Vtb2IwZStJbTVmd1Rla0k0UXc3a1ZFU25pTzds?=
 =?utf-8?B?WCtqV2pZcjFTZndNZ3FPQ2xjNHpjVEhLR2dTU1JPNEEycWNiU28wYWJ4Vk8z?=
 =?utf-8?B?MEduRmNDREtBSHZJZWx2M2JUTzJMaFRDMnhtaURNQUtHZVF3aDlhVERSOG13?=
 =?utf-8?B?KzBTSXZBSWRQaWpLc0krME5uZ2VSQXlxK1o3MENRQkVpZi85em8xTkJ1WVRr?=
 =?utf-8?B?UlhGWm5YK1F1SndCZnZYNzJpSHptdWFBWGwyL3V1c1YycmxpRkhjRjBuQWtS?=
 =?utf-8?B?K3ZEc2ZVZEpJR3FTa0R5S0s3M1hlVVRjZTZjeWhsNElVNlBrUlhpdWt5NFJS?=
 =?utf-8?B?L1VOMEtSRkFPcGNFcTE5S0UrZC9Mekl5Qnc0N2xOQWJQdFZhRU9NeHdmbUJm?=
 =?utf-8?B?NnZTMEtsazY1VWNKeTUyNThpSWxwTEFFL1Rxd0dhOVcyV2hDenVQc05VdG9Q?=
 =?utf-8?B?L1p3UWR3NGxmU2dJbTJiUVp1SUNnN0ltTTlSS3FWR3BQTW8vSFVCVmRQNHZx?=
 =?utf-8?B?SE44bUFTUThOR3F5V0k5ZFc2RVAwTTBWTTJEVzFldWordFRTM1JlWkZ6d2ph?=
 =?utf-8?B?bXV6OG1UTEI3N1VkcW1sVzg1WUJpMDdmek9jeEIrN1pscTZGWkthVTJtaUIr?=
 =?utf-8?B?TS9ReC82bkJ1eS9DZld3WDhkNDlSWlBKSG9wTnZCQ3hhblNIRE9QSHplUzAr?=
 =?utf-8?B?dWFEckxuOTRSVndkTHNQalJrNkJ0RHFPRHB1WEl5U1lyWm5YTC93K243bmhr?=
 =?utf-8?B?T1FkRkczOHlwckRicUpTRWx0MFBSdGtnNVZGQTJhSFNEV0hVNzl2OXdhQkFk?=
 =?utf-8?B?cGVBV1dXSW9SaVc1STZNYkZHUGhiMU5LWVdrQzVyOVR6S2JDRDB3ZE1TdGJB?=
 =?utf-8?B?MDhFR0t1RXdsdlBwNG8yTEpQbUpzV3ZmZG1ZNm9vaGxFbzZqYm43cW5qc0ZL?=
 =?utf-8?B?QTNLKzM3cis0TnVMZHJXVW1xNHNGTEZ6K0dzakNLQ2JyelB5aUJBK0ZhbmMx?=
 =?utf-8?B?Q1h1cDZlVXJWalNUblZwNytJZ21zOU9SL3JPTXhINlNQOGRobXlJNytORHJ0?=
 =?utf-8?B?UUI4ZW9sbXBwcFN1TjJtS3ZMbFlOVVVxZzJuS0R6UmtqV0NrNkxERHN5aHB1?=
 =?utf-8?B?YktxWWNuNVQwYzl2K1lBK3NHdTk3NkhZRzN3eGVYUVplNUhBcjNPSG52SjZx?=
 =?utf-8?B?a043VmpGeC9UeG1xTVNIdk5UU05jblVkaHd6Nit5K3ZuT3JyemVRMVVVQVBQ?=
 =?utf-8?B?U0F0cElxQUIwd3FVNmJkalZxTXA5VEIwTFZWeENNSGZSckFySEpsM2dxSERn?=
 =?utf-8?B?SUd6UWZ6bVFtUmZkWVI0MlpwWFBFSExaelhFbUlRK2tybmNUeDhoZ2VDbWdK?=
 =?utf-8?B?UU44OEp0TWh1VHRkMTdlRVF4R1JQSWh4dzg1ZjlXUlQvL3gyc3ltT1V1aTlY?=
 =?utf-8?B?R09kMzlpRk1PZzBSOEVNemJ4WVVBZlJ4enBqajdtRHZPWGFkSlVVTmFKaGVC?=
 =?utf-8?B?ZnpZeSs0SWhJN0hWV1V2Wm5rdEVTci9FRkNXWGgxS01xd1RrQm94YkVDSmor?=
 =?utf-8?B?bFg0U0c3ZVZQODJZNjhtdytrdDNaNDVuOHIveWRzV2pHR2YzOFdWWTJGcVVh?=
 =?utf-8?B?RXhYWnJCeGFqSkVva2ZyL25VdkxUbExXVExjNU85bjdNYTdkMVlSRU5QWHhG?=
 =?utf-8?B?MWc0MUhaM1ZNTlh5OUxzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk52blg2SlVOUGMyVHBtWitSVkdTR2hiOUwwdE0wL3p2U2FCMVFlQUF0cUJ3?=
 =?utf-8?B?MEFROXBzZkpUWk5hbmFramlLd0ZVZjJYUlVCZW1xTHZ4U2N4NFpLNWxka0pn?=
 =?utf-8?B?MEZsdWxWcFlvQXUvWDlJY1BHY0p2V293c3IxSFRHU1BSVzR1UE9IZEpjNWps?=
 =?utf-8?B?TEZRZHBZRXFtNzhQYXBPK2loZDRhbjlhZVZKTm05cnI4N0Y0d0FKdHNHZVc2?=
 =?utf-8?B?VE0xbWhadFY4R3RvaVc0c1lQQ1RwUjJ0WjBoME1kM1JqTnd3N1EzUXVyY1g5?=
 =?utf-8?B?NGtpa01XVEdJeTgvZnRKTTdTRmxrLytTQWtJYTF0L0RSMzlmOEtIblFsL1kv?=
 =?utf-8?B?MzBVb3pPbGJRYmNlRUFGaVFDUHZCNXhYQVUwVVBiNS9CU0VxWnN5dUs4TXJN?=
 =?utf-8?B?a0o1MTcxcHRCM1ZQRVBsRWt0ZExVeWJNQmtRMVZGM2JySGpiZXllUmtaakNX?=
 =?utf-8?B?T085eXRYUVhPZUNJMlkrSHVQUHJPYVBPUndXOFkzbC9TSDh4RllKekE1b3Yy?=
 =?utf-8?B?b0krL0sxK2RRMWxLVU1jbEdCcnBTUGx5RVpiRDVwczdBdFk0aGJKMGs0SnZn?=
 =?utf-8?B?eVpMMGZVWUMrSTN6czFQQW1sK2t6YWdPT08yWTZIbGs1Slo5aGVJeUVacU9M?=
 =?utf-8?B?ak9aVFh5M2xxTjl6TXN6aVRvRFIyVnFHSThqL2x0VDhmTld5amd2S0puSkZq?=
 =?utf-8?B?N21CZ2IrZkt5NjZ6cWhKTGxxeDRTUmt1ODAxUDVwL0xMaWQrVFA0SGJRRnZV?=
 =?utf-8?B?WVNKN1VSa0VzeUpLOTcyQlhmL3ErcE5YSzZWVGtsUC9QOHdaL0dteE1LQWRF?=
 =?utf-8?B?dGVGdVlIdndLVWJYUCtFU2NXQzQxSVY5VDZtRDNiUjg0eDE4dnJqRHEzaXpB?=
 =?utf-8?B?U2IrSEVBL0RhS1F1QVVhYktMRW11cS8wNmR6UUhEdVYvWEM4amlFbW9qcGV4?=
 =?utf-8?B?alltOWZJY1Y4V25aM0hQcjNTTU83RFlYM3AwbnEzK0QxZUVuQlNXNGpLcFMz?=
 =?utf-8?B?SHJibkdBODdJUm9TYlpqSWpRSDBVd1VMUVFzclp0NDM5VGg0bUt3RGFUV1Z5?=
 =?utf-8?B?d2ZJOVZ3T0dyQnFTNjFrQVZ6czZzcmk1Ri9yV1A1cS94Um9kZzdVMVcrYWor?=
 =?utf-8?B?MSsrdmE3YXJBM2I4emNybVdCZ0pucEtmT1IzNFpsLzhyV05hQnZMSTZVQjJk?=
 =?utf-8?B?U2FNU1o0N0tSV3FaTkpGMktDdnBhOURoNWNxVU5nSFlHV1Eza3hFM3I3K0Jl?=
 =?utf-8?B?RjQ1VGliamF3dE9WdEdiTjQ5ZUhiV3lLejVXdE40VlZRKy9ZOURoWm96U2NT?=
 =?utf-8?B?eWZRUXVodUtLb3RqL2h6aGVNenNIdDVSUnZ3dTdNMGh0VEtiSWl2TDhPdFpv?=
 =?utf-8?B?VTZOd1lDNXQ5bFM4WCtETXNBY0RJZjNrZVg5TXJqaFo2RFZxby9yRmNud2tx?=
 =?utf-8?B?Y1pjeDRBdVVvbWFsMjdDazYrbENBTE5WOXUycWh2VjUvN3NWZkUvNFlWeDRK?=
 =?utf-8?B?NlI4eVpkb1U3YUVQMFZQL1pHOG1aQ2NBRWJmZTdOR3Y3QTFNKy9kWVFzdEdo?=
 =?utf-8?B?TDBZYkxoZmo5UjVHc0FLbktUZE56L3dLRTI4RENkMEhBcCtMRXNGVXljbE9B?=
 =?utf-8?B?czlQOHVMcEZSTEZXQjBPVmhDQjFaZEpFRVUrOExUbDYxNzE3TjRJbm9XNURq?=
 =?utf-8?B?VDEyMHNnU3g5d2gwdkxLaWcwTjcwVEtPVTFFUzd3ZUJvZXd1dE9wcDlEMzBX?=
 =?utf-8?B?NU1rbWYzNStab0dTalk1NFZXaTkxejVIaUtRMlJBSUMvNUtOTVVoQkFHVlNx?=
 =?utf-8?B?WkhMeHZraTB1a0tjek1scmVLd1RHaTU4OGFPWUVFUHNWR05Ub1BreXI0ODhq?=
 =?utf-8?B?N21ObWttbklLM20rcGU5YldLdnNxVjFIZE1WU3BuTkdMWkN2UWlyd2h3dnYr?=
 =?utf-8?B?dzdpcFB6R1VnU292Uy9pY0Z4bkJoejZPNzR1bzZRSVZEWjRkOWhBWjVNc3px?=
 =?utf-8?B?UDk4c2NBSC9ldWQ1cmJmL1YvRFljOEJCWXJ3ZmZkYlNtK2xTMDBmMHhoVnNx?=
 =?utf-8?B?NHI3VEF5TEcybUhKd2dMZ2pyU3g2cmlCTXhMdTMzYWhhK1hSdVhNMkdCUFlS?=
 =?utf-8?B?MXkvbEhHVDY5MDN4ZGFhWHowZDhlUXJTUW53TG5hZHZ3OVVXOTYxOVo1Q3NO?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d8c1cd-d02a-4b43-ed03-08dcc32bfc0d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 04:28:06.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVI9vUwUMCUau1zoOfaxLeImpxVSun+KA8z4Lwl7gOjjhfUOvufi6BDraDexvqQIzYOzz+KpJ3TkGQCAHon0tK/CbBolyYa4m1LZtUPPYrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7882
X-OriginatorOrg: intel.com

On 8/23/24 01:13, Kees Cook wrote:

> (...) For cases where the total size of the allocation is needed,
> the kmalloc_obj_sz(), kmalloc_objs_sz(), and kmalloc_flex_sz() family
> of macros can be used. For example:
> 
> 	info->size = struct_size(ptr, flex_member, count);
> 	ptr = kmalloc(info->size, gfp);
> 
> becomes:
> 
> 	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);
> 
> Internal introspection of allocated type now becomes possible, allowing
> for future alignment-aware choices and hardening work. For example,
> adding __alignof(*ptr) as an argument to the internal allocators so that
> appropriate/efficient alignment choices can be made, or being able to
> correctly choose per-allocation offset randomization within a bucket
> that does not break alignment requirements.
> 
> Introduces __flex_count() for when __builtin_get_counted_by() is added
> by GCC[1] and Clang[2]. The internal use of __flex_count() allows for
> automatically setting the counter member of a struct's flexible array
> member when it has been annotated with __counted_by(), avoiding any
> missed early size initializations while __counted_by() annotations are
> added to the kernel. Additionally, this also checks for "too large"
> allocations based on the type size of the counter variable. For example:
> 
> 	if (count > type_max(ptr->flex_count))
> 		fail...;
> 	info->size = struct_size(ptr, flex_member, count);
> 	ptr = kmalloc(info->size, gfp);
> 	ptr->flex_count = count;
> 
> becomes (i.e. unchanged from earlier example):
> 
> 	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);

As there could be no __builtin_get_counted_by() available, caller still
needs to fill the counted-by variable, right? So it is possible to just
pass the in the struct pointer to fill? (last argument "&f->cnt" of the
snippet below):

struct foo {
	int cnt;
	struct bar[] __counted_by(cnt);
};

//...
	struct foo *f;

	kmalloc_flex_sz(f, cnt, 42, gfp, &f->cnt);
