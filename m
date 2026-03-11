Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E43377028;
	Wed, 11 Mar 2026 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272348; cv=fail; b=VP5a86SkX93funOjCysk986NSD1A+xAylpx0M6yVUmszGZtXQKv/47Lz2bjZgOFMskjrCr6FEYLH81tW2+5tp00GHWlQIAsKSBvcRhQvP0KzwjSRhLza3s5rvnVj+IfX5fPPT08Yj2V1WeqSQpTUCpKBAd5a8Vp1EzksbicGfKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272348; c=relaxed/simple;
	bh=s2Vj8Rm2DQpMGr9RBWhiUCWyqVkglnjtZ/YGBpLy3i0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LCje/QAv/b2kRcXbsN34wnWuMY7UIoOBF7rj6aPxYguTH4auk6NXJTdzpW0IdGTFVonzeVWcydZovxZweZTZPMEAGCQVLN0zxDVlH6XGibqBrCLEsvQdSat5HdjwFKAaGv1bh3HIx9RUm6qQoUnNmf5AdRsYHFIT6rJE60I6Ig0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STUHPTp1; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STUHPTp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773272346; x=1804808346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s2Vj8Rm2DQpMGr9RBWhiUCWyqVkglnjtZ/YGBpLy3i0=;
  b=STUHPTp1PW5925kvPTQxw3KJWQ2UvmCHkNBl4vqPR3Xz6VJvH/1yCTNp
   MlmZyysXBkEnGMAV+88JQx/+yq+iaz9bab7nyh8516pWcsn9Q8ajL5KzA
   ydQvRk4VWe1IicLHKPdpEUY18aGzHS1+s4+0tzE4l6RPE0yRfss2rkqxR
   GhpG5X7Xjvts1oebzhrNcxqs6d1OZXmnDuM0/smS3mnvFhGsg4RcXeZAh
   Bfxb4tAA9pHvrEvLk5oS6fw/JfAyb+DWAxcjmPHSCS5fZUF+VnZKjNJim
   bWNAM+ieQM6ggc3MqRZ+vELVLIWZ1n74LcFKxdYezZWbUKQBZGX5geoUt
   g==;
X-CSE-ConnectionGUID: 7usPyDBhQ5Cusp31OagqPQ==
X-CSE-MsgGUID: pAIeVxCwR8SyrqpsXqU56w==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="78208435"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="78208435"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 16:39:05 -0700
X-CSE-ConnectionGUID: k1dEkUCqT4C1K8AeVKqzMQ==
X-CSE-MsgGUID: k0S7kV/xR8a4Rad+yLW98g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="220811895"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 16:39:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 16:39:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 16:39:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 16:39:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEP3sZhd+PRSTynmpgdKmTvOVeIRbCeXiwk9frU//pBGK40jBjyTgjiyoaz+57K7cj9COlqaOyLprXgFrmpNc9NATV/lhQ73fvGEQjjrQTUTdjnsUt73209aU3fCYn1hmq+h7GOoDKqUjOEz7baXz7uOuYuGf7r6W2oozeSMwuGGR7GrULN7MXXrYUkV/2pwGN8RErwUGCUnq20JHzSca0MSsBkl78M6+K5tSnB4nNFeXK/Zl4+x/cdqp0vDSH1F3t6Q+6r8SYTzDByEYapN6VpQUivgrQsNhqtA7TbZW5rOGLCUTt90aZ+jxePzBZsrZZJe/nzdJUY+QgLnslXkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umOTQYthLbYbzWYmjLKRS7NrC9hJuFSxIvlIEVYobzk=;
 b=UneLaxdvJdpzYNijeK4T7SHO+9AAeYwJyRZAbEMuzvrUI6CWkXIgfUS8nBW7/b6n175Ht3+ah8wm09HyMqokPXnxM2sCm5d95Kido4IbpD0mh3HdfEU9I+P8iERuISKjg7a44auf65Cz6iE5gcMr6dLmbj6ubkMpvxmJuqkQSKPJyi0H3vOTMYCeZCwiCYCzIBOowiUX4tioqTrb97wNwEWGBMBaURjeGXTj+OwrCURrfIWct0Znn5QD5urxB9flczbYjJ8XEJKMv4L8Y4O8J9SDqzRVaj46FbDkGlaQMjaccDZ45o4mOPKmm8g7X5gpInXonIHCwI3fN0gRYP581A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 23:38:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%7]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 23:38:58 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Rosen Penev <rosenp@gmail.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, open
 list <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered
 by other areas):Keyword:\\b__counted_by(_le|_be)?\\b"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] EDAC: sb_edac: use kzalloc_flex
Thread-Topic: [PATCH] EDAC: sb_edac: use kzalloc_flex
Thread-Index: AQHcsa6EDbol0LPj5UmLtUYdMu7Mh7Wp/LJg
Date: Wed, 11 Mar 2026 23:38:58 +0000
Message-ID: <SJ1PR11MB6083C3A677F5C906222794A6FC47A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260311232545.18492-1-rosenp@gmail.com>
In-Reply-To: <20260311232545.18492-1-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5131:EE_
x-ms-office365-filtering-correlation-id: d74bf9a7-f321-4609-9553-08de7fc75e34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 0W6GqNkLSp/0VDI05M5rYOxmIngChV6KZWKbo5KBM4YX408Aw2bozEXqCL4VWpVxJTRqa7mZJfEo/Cash98vOjXXJu3QPotCKAxFJEyIbxj3hP+9HgUQOjpRp4Sl4Zp+Lr9W/WhIdRz8oC+fw7jWwqSiuCXdQGsKtZJNAP3AcO+ABokwSZe6W3xLLHTz03hKpdkt9hsT17j+RmRad+TyV4CAiXRD10d0cQxB5vUnTZgrDrjjIRTvJ276xqVSEZ8P7Rfa7rC6ad2uEwr7GaPUH7lDHRYFSUyGf71Pij7Jgpw6B3IRnhYSWFo4+aftRvFJmNHGsSKlameOsPXFpl52opJT3WiT+9Ra0ycUbPYAg0clVDuzClF3LvXtzsaW1wwr/OBMecbC+VJUNo2s/LKHYDj4o2kEZQsU4sq5s0kux8MhEobNWv+WITsZiWRsgFVdXI51Nh52OX9ya48BrzPW2zHeewGR1cSVq6IxuDRq10wuXtWFrvF/jCuKKswAwAi+I0ltrnqyQvFBg40Z1PfBcjCJqhFt2YfOdUgNKH5OmP0HmJlFo43RfefeQ1OzyLym1uARrKRhJCjsGfbXZMGcKZ6gWNfyZa/ImZBtd39gHqwCbxNOPAtEK6EdI/LGNfaMdMeJqdqIDE5GRDhWLJCBfa/UEBfUmu/pvgHCll0vtP31iVu2sLQ9qT306CAoo9LnzoG/IEPqIBPhKbVbH4TvW9RWUDxaPD87KTwfEHHF+I4eKBqV+f7jZ7gzzxZRx+orkQxLXLqFt/ovPTjPGccLOxugmFJqN5F2TVYPQL+8KQk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NuEVTYnSqxs6Lf1tQGv2c48BCr/4Wb7NMCjgKGfvYwGnzaxzyHDY4TBffvDt?=
 =?us-ascii?Q?B91WJwiGXCCBNWLgkRYGvdSaBcWkdx03KGhBSr1HW4aWRwEEOESSS7FIgeZd?=
 =?us-ascii?Q?0cLpX+BVH+YEIOheZqAvloxCJoc9ntW1yjHhWNJEGCECo5Lsm5/3A4tBs/Zr?=
 =?us-ascii?Q?ZKfLVWy/iXm7G6fKm2WG9cAqdSbl1rak5QKwEakdWlLK1YUUtL/UCWP7i3aw?=
 =?us-ascii?Q?tAt5WO01vc4u1zyqYUUK9vT6C7keAwsuotEu2yO/ID9boTdQqX0rcemcqnWS?=
 =?us-ascii?Q?Q50sU04UXkU1BdkgzbpbQRyAkhUNsozrTcJm7tfpxEMfJ4QZoQtDKhSFP0kx?=
 =?us-ascii?Q?JJl4pfUrWLsdGskKofNEwtiVHhuZiGEfO5Yw7Gbzy0puAaL3l69lvJUcR9lQ?=
 =?us-ascii?Q?42Y0lVTdNSebkmDAlmtbK4f7e2+FiWMmWWzLb572rSXgN5KEpaP/erPDu+2r?=
 =?us-ascii?Q?NTcMlxi+Zr/kNnZHztl78Ipt3ZperQ3Fa0x1r9HByVpcD2cOvYAHRfRX+xhj?=
 =?us-ascii?Q?fE6QGsYi6w8pWE3si3EAxaPm5qWRUW5R4oiW85kfAVY3o0mFcIsQeTzhtwAU?=
 =?us-ascii?Q?/TROjJMt7O4sRJfqRhfIhanjuxlEvwfidLaAtFfjsWT7Feel+sDk7OfBN5uO?=
 =?us-ascii?Q?D27rHGRvEQ+R1CN4W7gBdccgPlAVUOLtVBlEjrenLPJ5Y1SMDxjCjO1lHN+M?=
 =?us-ascii?Q?UKBsm017XB0a+5MJG6Jbfr2lCiQ9G58x5BKpGMWKaFB3/D5Bex6cjwVG+buI?=
 =?us-ascii?Q?+T/AKBzA1KyvjzCu809/KY0tPAYoaJA531W0Ib8g1UpCf5/mtVIl5whoso6S?=
 =?us-ascii?Q?et0L8v91vCSEQoE2Qk7YiqhEm5OnXwm4jC/LUUPsLOF3/LJW2HqBijarF+AW?=
 =?us-ascii?Q?FQHeLjMHLdKbx3JcJMI2YH4PTIcySguMhSaD1KJBSRakR1dJrqxJw9MpuCah?=
 =?us-ascii?Q?4IrkJUyVYl6/et/EAozFyDGN7X0gag7hjQtuFVTi4w0fq7YyqmyhZGHlwKWL?=
 =?us-ascii?Q?OvBZTwRfzRiZVWzfD5EWLPoSxiS8kUwc5RUX0bK+09DTWZ12viaWxZFZNJge?=
 =?us-ascii?Q?L00okCmh7TTNYomJWaWUFteqXSY7U23YygGuYT7StuTPyyvN6UppYjuIKMMx?=
 =?us-ascii?Q?f/W4jLcordUhaCzASx0mgpH8B1HfP+x4NEpAZIi1ne/aMjDRCXp9FlyVmM4F?=
 =?us-ascii?Q?k5awJHDfj3XsWUpMVfUiLg8SuJtz5k/Ad0MisYqSJDEDYgd5a5ZVeDRz+8r5?=
 =?us-ascii?Q?1SDlzINdXgAmFrIAWgfVnt7a3uLzaa8TghZtBzePJ9ax3ZnXx9KG5Tz4oj2v?=
 =?us-ascii?Q?0ED35rWuLPR1GSAJyovsC1Kxuegi5WEl7f9BOUxTfyqJlH4r317a7ZliUqfK?=
 =?us-ascii?Q?C1rD4E6YS2f01daI/66AE9IXOivS5sSDVYElu+eZgm192D64Zc98ermWySoJ?=
 =?us-ascii?Q?+ZH1ISvXPYjxIHJ/PhXkjGo5b/8pB2dVF4rHjlzYHGaOYPpRH0xkNxE/Ei9k?=
 =?us-ascii?Q?8yEi/qZVYzJKA+U95xusvx3FKHzDTU+JcXiketiTIU1bp7wWjK89wkuSmW/J?=
 =?us-ascii?Q?X45jwwnQ4MzONmxKoosXZNEuE6MTG4i3/4ANLphM7nots7Mp6OtwFiFteaRh?=
 =?us-ascii?Q?d3m2BftbJgdrq9XX36DCbmwEE5oxlAOBhUk2/v8T9zQsuenjZhGSvE5xQmdm?=
 =?us-ascii?Q?p14IzDXCZqMe3SVrMTJa5/EUykDCjGM0KooLbAaXLPtN2YW1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gwnSc5aM6x/Roe7esqI7PnOadHrvpPBj4lMqRHv6siiTJhqAV8W3fJ6k465vBdpLrV7dp4yVKWgyELfkfr8tQSh1YgxcxsltqmiD3MIZqvtRDFPdm4BLvCpLd7soxlK861aDRlik5HuE9pUQUZqoor1H+ZJHOhzLsd5NdgZarPKdA4NiC1rWLcpKjrMXLhYhjEPykv0qcKy/n8ZEZOYDn9IIuTT3KEaFDBrd9NkGKrE/OajsNtNfmTj7wVvnSU260qu1WYuuO+JL8BCEAqTSHnSvbDMdK3tOGJ0EbzEt7Am9lV6KPKkwjKVATU3vrJKMZeXnVuzE2OSFQqZNByoB9g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74bf9a7-f321-4609-9553-08de7fc75e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 23:38:58.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MeWAeGz76dlI9X4X3nqySA/FafhyYKvlCYjs9DhQlLAnpAlyhhl2zUjwQu2xsNrMHA3KraJyR1XnFke3sUQ/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
X-OriginatorOrg: intel.com

+	sbridge_dev->n_devs =3D table->n_devs_per_imc;

Do you need this? I thought that kzalloc_flex() filled in the __counted_by =
field of the structure for you.

-Tony
