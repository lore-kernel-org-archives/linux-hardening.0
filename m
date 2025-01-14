Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A322DC44;
	Tue, 14 Jan 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858050; cv=fail; b=H6+j0LV4s51T6pPM8dDf8ebv14gn4q5Z5Q5UeTLpZMwZBCj7exUpUmhWZ4nCA844rDr6jbA6B/vdqZP0HdwEgKJEymz2Jn9sjz+bw6cnlAjNKGjroTk64cO2Xs1ybmegFGguRdZCBG5nc4lY1vB3hRfDoDIZCeBJRWn2Yh3zfnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858050; c=relaxed/simple;
	bh=Bmws0VoAcrCRfM2pKetu9j1NonR9PsIcT4uK16XJ9Cs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kyeUowTceuXWnCr7G4XHLHvqq0iQ9w5Elxw7SZPodoZopxygo69/KwzFnUc5S/B4rIc3Mqwy5oiWTGYfzK6C/ZkRde+j1b8SHvkq97fe3lti6bwoiALVQW0eRa3YqpZBbpQNgUHkPwNOb61iEVAV+QUQ/swXHSTIgaGvk6Fh2n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7GktuLW; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7GktuLW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736858049; x=1768394049;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Bmws0VoAcrCRfM2pKetu9j1NonR9PsIcT4uK16XJ9Cs=;
  b=l7GktuLWENf4gKBVkF93ek7RcgIhS5fBzTIKK/WeqO097Y8tUI0K1WOr
   szhqmeJv7nyGZkBLERMzj/romV7irA84k7EwPxSTy7RVI4v3QFswsqxe/
   bq5ZA+xDWIsY7f4tgRMLIfseYpwBA4B0buE0qrSzX3dnE1wIsA+g4FpEx
   nlTPclGRvxvQt5B3PfgXE64y244xKtLSug/FpkZEt8JpME0ZLqHCm7c7X
   WvaWbm37tFKBj1SbLcPk7c+PUZWq/e4rBpa9eiqrHZz+LfHmeu4IzcDo8
   Rf31dFQuXzAhpL7345j0rcDDWWQLTa0jV6hv9k3dP4k0m+iyKTlTzy2zv
   g==;
X-CSE-ConnectionGUID: Sng3gHO7Q2GW2FytnmKWfw==
X-CSE-MsgGUID: NouG/ERGRx629Pdob0LMeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40828741"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="40828741"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 04:34:07 -0800
X-CSE-ConnectionGUID: oXVjgwIaQKyBgRLi+dCwHQ==
X-CSE-MsgGUID: 3D4Ank/4QnOy/aVRpPeSzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="109732426"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 04:34:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 04:34:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 04:34:06 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 04:34:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMG93dyGv047mcIZHG50QTPBFQAufo1q82gT0fvxMKOdNAxHev16TWL2KAXBThRPKqB6IExe3+1ZIyulgoIzPG9wUEslMcnH6qkyZmhCYQlSevJt2NBcVgIfua4Xz2k8cpFQNi33ENIwXTZ/tuvMqopNPU0FESffXAnH7/5iKVUZO6Y0oR5GvJ1qjTT/7lN1iQkNpMcBLYEgC/i0/HmMU8xADqhBFGK51lEEIqHcOQAEgFGLege5NeL/PZzhd3dwyG3VBBpsEIVrHYP0T/rmm1GiFnOnwTUdi50xtBA8ug74fO+tvYlIHUGrGdELrTpPmpyeAe64jSrN/rhGFWX81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlDhXucaNj0phHpRVuHXhts7CZly7NAMVQZMkIZt/kc=;
 b=IKsbCCfQpEExaJlkLVg9MyH45MPsKFg1zt/9jdMbah3HLG100OaQXUE7P5/m+kIIyC9Fcl5DXA+2TGDjvEOl1ovwtZiMqwUiErFsoxt0Xv/+W7xnph0wWljfauIWxlTtxpq/DSbumkXLnoBjkMZM2TnjCPxefCTYOVkGuAtReEFzmfQmObF+yo+VVbkW/LTT2dO2HM/83dLUybMb5l5BnugBttShB94gC5vjxzQ38TNkEC6AAV1L6yov3v+jfB0tkrmvufz26BDZYVKVpZFM/p6CSACWRcY3KFjVIeJx9RITSpm7BtPo34OSc4R3PIxzRZdElhXxMQvM+GJ4Rcw2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB7483.namprd11.prod.outlook.com (2603:10b6:8:147::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 12:33:59 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 12:33:59 +0000
Date: Tue, 14 Jan 2025 13:33:50 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: R Sundar <prosunofficial@gmail.com>
CC: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 linux-next 1/2] lib/string_choices: Rearrange
 functions in sorted order
Message-ID: <Z4ZZroWX80eQGMAT@lzaremba-mobl.ger.corp.intel.com>
References: <20241119021719.7659-1-prosunofficial@gmail.com>
 <20241119021719.7659-2-prosunofficial@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119021719.7659-2-prosunofficial@gmail.com>
X-ClientProxiedBy: VI1PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:803:14::36) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ee3edd-c0cd-4344-182e-08dd3497b822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OWNedgVRlN+Tomlj6IoXnwxZqaAXCc7U4PIASQf4eoI52eLdWhn0blXjvwot?=
 =?us-ascii?Q?2QO4lisa58OCFv+BLhIUccXPWF3cvePEtVfXl7V9DVUujFLORvM/uBb+aX8m?=
 =?us-ascii?Q?5PU/ZbcUnqx9v1BrXtkHTGJn+TThe2/ZnwDQwlKmtPoqVy+89/xdrGC/nanK?=
 =?us-ascii?Q?005MGXrmv9T3Nzuh2iyG2HFiS1A/dYHK2m58A0+ME6O54vd83FqsxADMU3y+?=
 =?us-ascii?Q?DofDl3w05/B04vvbx8BaBC+b67mDIrFrOnpSx+l9C2y8X00zBtSLlwyDoRmi?=
 =?us-ascii?Q?IOx5sXxDmBra+gJhWvmaVDw55fi5lj88Mgt20Kaw0GvnwcFQsWZZiX7l5+W+?=
 =?us-ascii?Q?pxV3y21OBnWgCeE6oXoeBQchO3/PAGWjeCgGjUsEfzkOkUt3LlIcpBB0kN5Q?=
 =?us-ascii?Q?2s++pTAoBE8prgbWLjsQOuLLAOUAFsDeayWfuXBb4FA1pepmk/egUAW2bbQV?=
 =?us-ascii?Q?a+ufu+3lchLReyEhWhWmUe7KZk4t1ZH4BJeDnHTS7mUceae2W7HEqJLDsB1J?=
 =?us-ascii?Q?XC9UNkFec27EfHzO8M7cO8GLQaIEXGaswNEYq51bMgOTq3czKsHWyTbhY+Za?=
 =?us-ascii?Q?2/pC24KU5Vicjn6UMa5vAaaUe2eNtJUjMAgbPJU4g8+YV9KLqclaFfbVIdvr?=
 =?us-ascii?Q?2JFsUNGzMTfcbHVsR1HHFPNJ/uICY/wxUrSkfNy0hWlv2En1HaxTbMcKOhV0?=
 =?us-ascii?Q?lnpQTq83HJzXSdSSFfZnJYhhZg40Pgu9C3v6CufohwYe+Ov9TLaCjpoD2nt+?=
 =?us-ascii?Q?Me0gKruaqjxbkGHLXjKikJcq9Tf+ke2XGwK+QYPaEVfjegc/RP9h1JA8p1fB?=
 =?us-ascii?Q?IDyv9+VJq3lVb54AK4oVq9mINxBc94rmiXyrjHj5Mby245gS0bSx4mWVuogI?=
 =?us-ascii?Q?H1tQ4bbOix8GNF6NxksvrVnC9TZW4zOSQIyh2MZzf/LY0Jb5wlhRjO/UYXmA?=
 =?us-ascii?Q?uGnMcz0cF3jDGFaCSE+OUr7DjhmJ02wf8+Rz94mv4ee+73+pmsz6N7Uu3/bx?=
 =?us-ascii?Q?fjQr5SOm+apEs7ic3GfcdsrUQKHuAyUnpgiwB8JHcLCwu6HNGkbisMvilV2l?=
 =?us-ascii?Q?Jugc/bdCn6FB6IrFlU86WThfscFfTaNr/wfNSUPyAkhzXy+woFJE0dYCYdyC?=
 =?us-ascii?Q?RCIL2DJ0+Gpl1/QbLgr6XqPOQvACS7/mm9CybCiousiK/e8QXlKZWBsxG1UD?=
 =?us-ascii?Q?Br3FwCKgzCxxR77gEuxxBTWWjuQlHkDAh2l5Ry+pYbfmUMz4BiGyn/dQxCfV?=
 =?us-ascii?Q?RgmIBvIoPifHlY/4Sb7ZVWW+tQgs1cCtRc3eE6z3+Mjty1NVcmyED5rOArJ0?=
 =?us-ascii?Q?k4umm+Fzm0mZTSzcSLffbV/iSMnnTJSCD84I1A0dq4fdxJNy8oLKX37KdAVa?=
 =?us-ascii?Q?J0yh1vs/QFer559T7ERlfuAyZoHV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWvBeI6X83LLIl2sxkic6jRrhitFXkhGf1UZ9+e54BcTHlxFA4w/lBOFrScn?=
 =?us-ascii?Q?EKhcV9+sevIw5hEroqoEkMid29C2d+7oz7fHKGxem83v3hSnuD164Ca477fi?=
 =?us-ascii?Q?22R592iTCboy1ejrr7l04TLz+y1Bf5h/RaL1NDpmhNfcucNLdpT7Jzd4oYee?=
 =?us-ascii?Q?lm0296TfAbjSSbz3+QDhzb8NCzzUKL6muwcy/ZBSMZbDypEVvslnPQI+bK12?=
 =?us-ascii?Q?9rG18fYPAOhdDZMLuhCHARkn1AgPcuRYF7oc5GdjbWH5A4Zs/Gq2Px39HkDg?=
 =?us-ascii?Q?7cbkJ/ick7Ya4D25kvF/2Lwop1HScam+TKtucmRWlO267REEhglW7QM2iOtr?=
 =?us-ascii?Q?OjYlghKNIOq84trBUe6XXR9ugmcFC/ebZtomtIXgDP5W0r+t9YGNf8LdMrTI?=
 =?us-ascii?Q?o1ct75UGrm2AMcM5DG0OmEI7fCHWmGta/o7WlDnTn88725SLzAwPYOmVY5nP?=
 =?us-ascii?Q?0DCBv5hjxfXA/KpF8KVNPqsj3QJPd6Y9aPW87N/uMGIXZwr6P5vhpKWE3lcQ?=
 =?us-ascii?Q?dWTyi0mcmm19Cf69j0cSS1ErV1K+GR/5gxtbKWdT6Wg+8Hggw8xv5BMT1ZPZ?=
 =?us-ascii?Q?j3ZGrdLCsNSiCz7LazvW4WBIpoaxeet6cKLKegx2yRXSZfrtdiyo6eUwKZFA?=
 =?us-ascii?Q?MDrNu/BNf0ZgZRBCrFk7e1uDZeblK1pcm0RK3ds55mk225vOS4Qp5Aqq1iX9?=
 =?us-ascii?Q?mQ8IWFUajusfUs6z0cAP4Ct07/UMUz/+MC54V5sLybHGc+rQOiJdLvwH+IRL?=
 =?us-ascii?Q?4JNoS/R+g94dSu+miL92JS2f+k8lj2ACe+os7VfZTcFoHOAWTQn6Ct8jO4Dy?=
 =?us-ascii?Q?MZjvS5HULdrXMfM2VDZTTNS1qp+lmPpMgoCig9q/yGAbzs8GjogqC6yw25b3?=
 =?us-ascii?Q?VwKNHOuZNRx2nhrJuB8aAw9QJ9O8vmGjX5zX8Cv+G31B2l1rq/OCVVDI240Z?=
 =?us-ascii?Q?dWwX7cYRpog2WM8Xaw3+JTKs0eqp/EVAdjiqD3oiuQLK2YHU8G0uZRfcwGcP?=
 =?us-ascii?Q?RFuf3YHbtlba0ztrbTmuEJLFFbMA0dUdB/q0EIxUdws0KqQsWPEMLqN4F3Kj?=
 =?us-ascii?Q?x3szZckzIc9tJZ9vQkafpevv6VBiGk0TntfkBHWX4JE9rxm6CD6HSFXM3X44?=
 =?us-ascii?Q?d/7D8eC47oNEX5uzK84gy4KWOTMEmVIM28jzYUVNJOrrUpZzLDjTamN/9mLD?=
 =?us-ascii?Q?YVFltiJVWwiPtvbYFDu8vG7waGeahpCBByFcdsPKemQbLM4SxuYycfqKkTZ6?=
 =?us-ascii?Q?vvoGfb1jpLUZnPeDXUAr1zJEX0hQDIkMBOzHRlPc29FK4kPNq9644dQPfBtl?=
 =?us-ascii?Q?8k5ggbS20wmMaf1r2oIg5w8P8cz7Bn3vKjutTvRtKBc56LzMBYEp3mBkxBY7?=
 =?us-ascii?Q?3D9ju2GWolg46Tw6jKVKQIFsU9ugK7AQeEbnMR0tWJn65G/i75gubX4aDH/M?=
 =?us-ascii?Q?K7neqwHiC+k/oXmFTx+1K7OB15XvxbfohdabWuARBriTrEWYmuzujVF/UP1G?=
 =?us-ascii?Q?PBmPWB08rYotuiDDse1GbkRUNIcn5dAUjKk160fLRjU1b81soMLrBnLN1U+v?=
 =?us-ascii?Q?jY0XaAz/ujg1FViDKP6+XeQGBlf0htfO1MIyCjHQIwFgrenSiOYNfkoRhc1g?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ee3edd-c0cd-4344-182e-08dd3497b822
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:33:59.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8RsM/BhPloAq/VXJeHrAmzPl/mTGU3I/97I1bGKQ9JW+h06z4scpWkWKx0z3IwcAa/PgjoJPs/LVrZ9yAfTSeYB4kNXv0lIxX1xhgyNUWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7483
X-OriginatorOrg: intel.com

On Tue, Nov 19, 2024 at 07:47:18AM +0530, R Sundar wrote:
> Rearrange misplaced functions in sorted order.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: R Sundar <prosunofficial@gmail.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

This is a much-needed patch.

R Sundar,
Can I pick it into my series in case it will not be accepted in the nearest 
future? (I do not promise this, but there is a chance)

> ---
>  include/linux/string_choices.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
> index 120ca0f28e95..f3ba4f52ff26 100644
> --- a/include/linux/string_choices.h
> +++ b/include/linux/string_choices.h
> @@ -41,23 +41,23 @@ static inline const char *str_high_low(bool v)
>  }
>  #define str_low_high(v)		str_high_low(!(v))
>  
> -static inline const char *str_read_write(bool v)
> -{
> -	return v ? "read" : "write";
> -}
> -#define str_write_read(v)		str_read_write(!(v))
> -
>  static inline const char *str_on_off(bool v)
>  {
>  	return v ? "on" : "off";
>  }
>  #define str_off_on(v)		str_on_off(!(v))
>  
> -static inline const char *str_yes_no(bool v)
> +static inline const char *str_read_write(bool v)
>  {
> -	return v ? "yes" : "no";
> +	return v ? "read" : "write";
>  }
> -#define str_no_yes(v)		str_yes_no(!(v))
> +#define str_write_read(v)		str_read_write(!(v))
> +
> +static inline const char *str_true_false(bool v)
> +{
> +	return v ? "true" : "false";
> +}
> +#define str_false_true(v)		str_true_false(!(v))
>  
>  static inline const char *str_up_down(bool v)
>  {
> @@ -65,11 +65,11 @@ static inline const char *str_up_down(bool v)
>  }
>  #define str_down_up(v)		str_up_down(!(v))
>  
> -static inline const char *str_true_false(bool v)
> +static inline const char *str_yes_no(bool v)
>  {
> -	return v ? "true" : "false";
> +	return v ? "yes" : "no";
>  }
> -#define str_false_true(v)		str_true_false(!(v))
> +#define str_no_yes(v)		str_yes_no(!(v))
>  
>  /**
>   * str_plural - Return the simple pluralization based on English counts
> -- 
> 2.34.1
> 
