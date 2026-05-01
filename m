Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8EA2367DF;
	Fri,  1 May 2026 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646837; cv=fail; b=pN8yN2sv+z3Ufgz3hH1YGowlRgercVf7EAm6pLfxq89WJXkx4MhfS3KvmMeifUfrn79oxwOB54uabsIP78kVzB18crNLhJ8hgHOOnvVGIlboxqGeVmEcpSq2r1J1+BBeZwuHWMp5+dRsA6NDyev9yQG6GnSONMLdQjj9ZFllc9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646837; c=relaxed/simple;
	bh=qcMG3lOXAI4TwEjTytAc8FqmTxi3Y+vctfBDx249CK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L9Rk8+6pDVfXkQFnhUZBAr50+w7zOL8fooW0UleQCVj4wsQq5XqsnMIswJtOVVEapr7elowooa76/sF6n+5F/Bj/zblhfzCekquPlP9vIawNncVL62r1BED3bkyx+vn/Yq/thVsz4HKdwCOJzbT/9j8+lWWu8j9pclDzEEnzwqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZ03PaMS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZ03PaMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777646836; x=1809182836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qcMG3lOXAI4TwEjTytAc8FqmTxi3Y+vctfBDx249CK4=;
  b=jZ03PaMSV8Wh4A+oX4T7XtYTAck3+XK6PrcxhDps8JhTZbHcRk7kZSr6
   MWc+8azMDxPJ3Gvf4U0xl0JFemjHujQdufuc47S1ZOQPyMZzvGERGLbv9
   0eaj9X2EUW64n/jR05hRP1stUMOG0gAH5Zx7Qpv3c9+tJKHB5dju0B8yF
   EJZ10K42ujHy2im3v0W7XJ4SLWUpZ4EkR0XymODA2ZdZQeOEmoFhdERKA
   VIo6lss1VeghYd5jNwLG8G3Qypt49yb4Y6jjTG0k9a3rbn+soL9/1sb3J
   75G3dXmKCtQjcB39r7Lvm6db3gOAzYpZlw/euRhwOsy4W4X8c66nIUEfo
   w==;
X-CSE-ConnectionGUID: KlndwrsuQcyg85s/BXlNcQ==
X-CSE-MsgGUID: UyZxHgmYReCoyVX9gKmeFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="78802367"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="78802367"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 07:47:15 -0700
X-CSE-ConnectionGUID: ozTk35zsReuKKVtNcdntiA==
X-CSE-MsgGUID: qOzs8jdpSk+eDdyL1TA4wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="230526069"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 07:47:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 07:47:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 1 May 2026 07:47:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 07:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfbdRFcMVQbgj1teBISxQdPAMfodq+IRzbf0C+m4WSZBuUvLGQqYKQ1865cTQaQQ3nPqimTvSCdd0ChErZcPHAwgYl/hn/jn+iFw4Odb03KqcQjg/Huj5N2hCDFCQZ3VyZSe+Fq1UuxmaBhPy8iyR0OIlUBvXnemgxWRFL2Yz6yvmdoVhBAf/ZTES143ZRrz6puCeUqjTzUo/43zLht0RTVn3pLdxz3cEGX3DCjTMAqwFfto7ps52MzMoewT0s2Er7068o0sLPLkOsoRzFu6S0WHVNgHlF+D0/rvi5VGiNVPYns3f8d4sK/CEEYGT0s+x2+nH5io/QXGmrSkyaM6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/KvEPdeKgNwmH1ftiz1Jkq4vGLEBIzHkml/xx5Q134=;
 b=H1tFrErZw89MMup5iTfoS5xvfw8ylJHSgSD068Wz+FSd2QrQaiqiJFBsY7HETpdBJsm1ibIV2QmcDv8CyIuNXv6+tzvdYMWcM9iUSABYu9em8WdgIOvsXCzjRkbu7kJ84hBtPtHnaTvfccaBK1VQpUWzu4/53Y/aSvumNxbu1J1Ixnfe/bk9zRohRx0yqX4D+K/wl10ksZmlJTr4eWx+hjCAXIsIbYNELYjccUkMyKmlBfAFZF3+GcocRWq7V4GUA9N4s72x7ikCQbXCT/ZuTYMFMhIpcIQRCIKx0MOPKDMwUviD85FtXUuYIjoecySgUoB6zJ9gs1+vcEkLf/kJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB6546.namprd11.prod.outlook.com (2603:10b6:510:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 14:47:07 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 14:47:07 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Rosen Penev <rosenp@gmail.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not
 covered by other areas):Keyword:\\b__counted_by(_le|_be)?\\b"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH 1/2] EDAC/device: simplify info allocation
Thread-Topic: [PATCH 1/2] EDAC/device: simplify info allocation
Thread-Index: AQHc2OzwNy/ID9YTFUGwSx+I7LYAWbX5N/Mw
Date: Fri, 1 May 2026 14:47:07 +0000
Message-ID: <CY8PR11MB7134BF3800324EFA1B3172AA89322@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20260430220046.72371-1-rosenp@gmail.com>
 <20260430220046.72371-2-rosenp@gmail.com>
In-Reply-To: <20260430220046.72371-2-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB6546:EE_
x-ms-office365-filtering-correlation-id: b2df2ded-a472-4851-fa22-08dea7908471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 7IePGI/pUezPucQxkR/XWN5UgnTDuPD+OpCyCasFRo8WT6++1WIXqKQeYH+y4V2ZYVMdlST0Yi6xHijJ/2PrZth6/+/L33fKlec+O+HSdctKeEv0Q+uYJRWBL+iBfXM8t4+VfZgWNLGvp8mHtGzNGV1VytD71SigKrVRHxiWt5WXeKtNQqZmUwrZ2UELW1A6lZmrhSJn0tYRgE1XEQEK3VtF/sNfSD04i4qZ4WuAYxQryh4x9MMTxrtA4Gf/Bz/SOO/v+n+90jueB4kPY8JHSgePVR0LydWhGNbY5/oiFJyZm3XIOeGYHm3bW/F0n1CuLH/brlQlJXQF69MpEBpw359O3oLieQBhPSe8SNEYKpPVkwE/fdAHMT/g2VMGkmFxAPmsaMymflbTGCm4zjNzIXhgc0Oi4kv+RTQpmKDLpEWHKyDpkSqlCqUV4L1BliQVWwYkGii9Jwq2oY15TIK8Wi9WqStx9JGNY4gEe77Z00XjmoCgsEAxVSdqaW18ilrwb36kjPBV4fxazydUJV+mJY1HuwfvZXp29pIDPe/P6fOcweehq5QNJjkGWDSmJu5903VgyKF/IykbsKSK8qVsbNPs7i+Sg+6CyxEo4h8Bbtl1D4XXTqNfrpNVxK2yuXGhxhBlLoxzg0oUV859UEmlEcVF3+Mw0h+JmJfxjk6Dnf3mCE+bBUGbqa/SD63JO1Yef/XYGEv4KLerYYtEVfxAZB0xpjFAmhpPYbpOPRqjk0kVusRP2fWikGHOZWhW74pg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QVIAyMD4q6BOQllnIOuCK3nd9YojTSfxSl59tw2VpLpCPjMMeESnirwwA2fe?=
 =?us-ascii?Q?YjeuCVs+Q9UmHniApPbmXFNIFomMz8ar8D5e1DN1vJBgosn1lpv/HxkLu6d+?=
 =?us-ascii?Q?jWQcw/jvbF79ZN3jC6GgbC3omxYgzfNOKYVUOPNwaJnWGpXgbFaicQUJ4Imq?=
 =?us-ascii?Q?nzkw/Kh+IgQ/N26B2J05xe7K9WkVFIeancEa/svsJXWfkIlAl6+J1awp63SO?=
 =?us-ascii?Q?HWYyQ6bWafFiFgzwKke/oO/yv1a+b5HBk+96xixe9DJskTFytlqcRlqRFgPC?=
 =?us-ascii?Q?NwPCG0XYkI6nnOpqQCIdSxvrZjWWc07nAMuVpvJogIigbUsNLf9SHCM8ykI2?=
 =?us-ascii?Q?XOYRj0SRDpNmUp7lOO+a0wmMRZEnZAfpJk3cP2I3Sd11K/MIONp3mGISn02Z?=
 =?us-ascii?Q?EGqYUYQzneVX9g23EiXXnXIjmltdqxZ+FfVmWW+WI9KKmnVQf7OZR44wYUv8?=
 =?us-ascii?Q?W0iJIFW2rTbq0EVncFZNS3eDKjuCFl5nTlvFJurGvXVFKsILzNf0zas1N8an?=
 =?us-ascii?Q?rCMLOYHLTxtj2PBpsKxaMte1iSIe3VrHPQ9x1MpcS1wO98va01LOoPvbGOj+?=
 =?us-ascii?Q?crprj2mhJZFganJfmrK6t6fDf3mhqXpjd6OxOaS1snXPVoyMh6kmAiHLCyfY?=
 =?us-ascii?Q?jsifDbfiFC3OqdLt7wbo5Fknc2FH2gOC/qpIr6kbmjo/bTY6rdMXsMqECMQk?=
 =?us-ascii?Q?jjLJyzVaUUPV81+OtEnMyqYqwHYu8DwxlplJCCJPo7q8+uk48M3Lw95+N/ya?=
 =?us-ascii?Q?HxVPK3RaWTNPGqFOzgtuZMJLCBFniStHpUUsp+PD7brwCUyEdbR0kpSS463q?=
 =?us-ascii?Q?7vEiyHcdBzWih0AFi/TeAdzXg7cK7+tgdKfZG+fCcAk8thDhWuvA5F5Lk7RX?=
 =?us-ascii?Q?KmnCTUa+nyKlSmYGxint+QEEbPZFDzZzwosq2M/LQcjodCzEUUgHhH7KR4zH?=
 =?us-ascii?Q?c26G0iBjcXEvjZsMobzkkM5/r7mHThdyVDN74I6VZmoMCyFZfiJs4qs5kWnE?=
 =?us-ascii?Q?1/eYXQbSlH4LvxaICT14NxpwE7B5V+Q8tmw9cRD30nH6Ebnu9CxZJEYiIYP5?=
 =?us-ascii?Q?HK+R4TwnIs+Y/SmfqKXJKxUDA7rfTxvITQxlIYTvctRJnY83XZ1ASnbcovfw?=
 =?us-ascii?Q?Qpno6bi+lYakB2tFbsac8z2bBa9iRiwGB1L+MJaaOnziEyqHSzX26Yr/Sp8x?=
 =?us-ascii?Q?DvoLOmxWE0mBkURghEOM3JIPX89kR1AMtwxFTBMLCEUZuc7RrkyLQ7UEqXpX?=
 =?us-ascii?Q?Z1z9ggcAUzvWL7yzO7c6iv/mgjAgvebuVq0yColKnAp4hNNpjBDAAwyeg5KJ?=
 =?us-ascii?Q?3RL8dTO/ki6RM4JSwBx5WAOiCW4Libc0eLFYH7HZ8Oy1/yylYUUF19tlMUyn?=
 =?us-ascii?Q?tVgA1f01PISYDYPDHgK7oLf2CqhW2+Rt1xxTiLPUSTUFdqOlNuGCDk06Q4mQ?=
 =?us-ascii?Q?/Cg9Vx8KTOVzrDBhKckPgDeT/VAzIbj0uRFeZ6YEjPp5I3ZO1lRoTki8YPMn?=
 =?us-ascii?Q?4DnvK/pAKXd42GSwKHFUQgiSLWRwqOSZanuOexrp0v7bwM568sk8qb9mEcZ+?=
 =?us-ascii?Q?T1m1H6jvJ0mlncPXL5gsy2W1ozOo4v288hLIUDmtdlir6tBL4Simlvx850AX?=
 =?us-ascii?Q?1XcXjEHkj1xGoAl3ZDNP2OQmyUCgeMauOPVDcuks7j57rcaMu5MrVUNTEdy2?=
 =?us-ascii?Q?sGOxqWgS7/9nu7ZZLNZP2CJ+angoMiT9Y+2NPtzjB8xWdhOjaJzOMRWKxEar?=
 =?us-ascii?Q?jOWyV/5+pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CZO0qmWDsR/NhetLrkFae72icFRRWqMCXrCY1I5KKCC0U5Bwc1l4PKgPzso++XzpYnuJmgdDuybge3fJGK8RXFuH1kGtydR35Jg8YYbRZaN69lE3lGNj55YePgTbz50z6+RCrBAePcw0fYB11XcIfr1EZIGYge798RGZB/oxiftCihOPrmBvIpyQp4hwEXGJ5WtVQRyz4iTEkjDn2z37z4+uLjYtB8RE4BL2FCDS3YTEjeLJ/VbDl2u5GH9y4CAm1P9bRcnzohliuAFmy/2z9FRd/pXcU4RBYIWCSBGMoLx2g5ysWm5vpwioJg/ofAn64LtwuAUZ7TF9rNk0C4W3vA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2df2ded-a472-4851-fa22-08dea7908471
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 14:47:07.2159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKP1VQLRYAemBlCjBRmbpXayFZxdlXOSmgHHqOwm10IMDCro+fgNR/pNFpNudZ0ZqLgrrHLssW6ltZY+RiRS4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6546
X-OriginatorOrg: intel.com

> From: Rosen Penev <rosenp@gmail.com>
> Sent: Friday, May 1, 2026 6:01 AM
> To: linux-edac@vger.kernel.org
> Cc: Borislav Petkov <bp@alien8.de>; Luck, Tony <tony.luck@intel.com>; Kee=
s
> Cook <kees@kernel.org>; Gustavo A. R. Silva <gustavoars@kernel.org>; open
> list <linux-kernel@vger.kernel.org>; open list:KERNEL HARDENING (not
> covered by other areas):Keyword:\b__counted_by(_le|_be)?\b <linux-
> hardening@vger.kernel.org>
> Subject: [PATCH 1/2] EDAC/device: simplify info allocation
>=20
> Use a flexible array member to combine info and instance allocations.
> Simplifies allocation slightly.
>=20
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment to after allocation as kzalloc_flex already does with GCC >=3D=
 15.

I'm confused - I don't see kzalloc_flex()used in this patch.

>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/edac/edac_device.c | 23 ++++++++---------------
> drivers/edac/edac_device.h |  4 +---
>  2 files changed, 9 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c inde=
x
> cf0d3c2dfc04..9c21997a50e0 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -58,31 +58,25 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char
> *dev_name, unsigned nr_instance
>  			   char *blk_name, unsigned nr_blocks, unsigned
> off_val,
>  			   int device_index)
>  {
> -	struct edac_device_block *dev_blk, *blk_p, *blk;
> +	struct edac_device_block *blk_p, *blk;
>  	struct edac_device_instance *dev_inst, *inst;
>  	struct edac_device_ctl_info *dev_ctl;
>  	unsigned instance, block;
> +	size_t alloc_size;
>  	void *pvt;
>  	int err;
>=20
>  	edac_dbg(4, "instances=3D%d blocks=3D%d\n", nr_instances, nr_blocks);
>=20
> -	dev_ctl =3D kzalloc_obj(struct edac_device_ctl_info);
> +	alloc_size =3D struct_size(dev_ctl, instances, nr_instances);
> +	alloc_size +=3D sizeof(*dev_ctl->blocks) * nr_instances * nr_blocks;
> +	dev_ctl =3D kzalloc(alloc_size, GFP_KERNEL);
>  	if (!dev_ctl)
>  		return NULL;
>=20
> -	dev_inst =3D kzalloc_objs(struct edac_device_instance, nr_instances);
> -	if (!dev_inst)
> -		goto free;
> -
> -	dev_ctl->instances =3D dev_inst;
> -
> -	dev_blk =3D kzalloc_objs(struct edac_device_block,
> -			       nr_instances * nr_blocks);
> -	if (!dev_blk)
> -		goto free;
> +	dev_ctl->nr_instances =3D nr_instances;
>=20
> -	dev_ctl->blocks =3D dev_blk;
> +	dev_ctl->blocks =3D (struct edac_device_block *)(dev_ctl->instances +
> +nr_instances);
>=20

1. This assumes that the address=20
'dev_ctl->instances +nr_instances' is properly aligned for struct edac_devi=
ce_block,
but that is not guaranteed.

2. Using a flexible array member for a single structure member can be reaso=
nable and easy to read.
But this patch effectively turns two members into flexible arrays and requi=
res manual address calculation for
one of them (and there is alignment risk).  This makes code less readable t=
o me.
I'd prefer old code, as it's easier to follow ownership and no pointer alig=
nment risk.

>  	if (pvt_sz) {
>  		pvt =3D kzalloc(pvt_sz, GFP_KERNEL);
> @@ -93,7 +87,6 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char
> *dev_name, unsigned nr_instance
>  	}
>=20
>  	dev_ctl->dev_idx	=3D device_index;
> -	dev_ctl->nr_instances	=3D nr_instances;
>=20
>  	/* Default logging of CEs and UEs */
>  	dev_ctl->log_ce =3D 1;
> @@ -107,7 +100,7 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char
> *dev_name, unsigned nr_instance
>  		inst =3D &dev_inst[instance];

BUG:  'dev_inst' is used w/o initialization.=20

[...]
