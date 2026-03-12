Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8A35DA61;
	Thu, 12 Mar 2026 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282910; cv=fail; b=fS3praDL6vj1kQUWWgDTMwhVIP6Od5qw1VqaAof1bLO3Shhie6WvbKDlmmig83b+Wht4mlDsNbeVo3gXJyHhd8RFcdwOMPyBlxgKHHyc0KjDHNSKRJnkdWEMZD+m2RKFyyB+Hun2GDniQeIugFCSZ5AYoOLa5juFqvzp4/DhGIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282910; c=relaxed/simple;
	bh=oVYVJHihgKWwTEzsOmvK1HWoD8BVtcAGbxjJGBEPL1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NmISpb9neDyWIdWdhHbcw+0NkcdCUk0BGxZ830yjSuBteZKTMBo6G77WxzdreJei4uE/8HfnCQhF47CPmEQUl1CMAKVpCoaEQXrqgadp3dPfDEqJupvRlVtJYbkemAmMcayJp4gQq0Ks0XbCh9anm2dyTW8Pu/fbXacrBIA5N3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYjgaKEK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYjgaKEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773282910; x=1804818910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oVYVJHihgKWwTEzsOmvK1HWoD8BVtcAGbxjJGBEPL1c=;
  b=UYjgaKEK6F2G1MAh9aj9Hv27dWDQEXoksj58HBOnwwE7wE6RS9pms3Sq
   bT8s1D9iPlF+NRbhFPKnrsZbIMYdIzYBJo/uI5jejy4RwBieyDPAj7eGo
   U4dw7XkSLMqtPGnv/M4JEqnkJ+s6C4k0QfByec1vz/QuC2H9KLFf+dbSS
   bVD7Il5fbuShyE3ALGeCPYeECwxE/yLg0qpFWz6iJep4VcN6CH3vVJSSj
   jBcaG8MI5W4cP2kCM8a1B/aeAttt84MR0agrO0N21Xgs9bwD3dxm329r/
   9LQtlZIUfosdFaQfRuWR0t49+U9DQwrK7J30I1oIGlYeVm3Lcof+Sz+eD
   Q==;
X-CSE-ConnectionGUID: eTe1DM9bQni4qcVeQWv3Zw==
X-CSE-MsgGUID: qvtK/y0NSsGcBYm8uEcHtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74259692"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74259692"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:35:09 -0700
X-CSE-ConnectionGUID: cD9SasxFTtOJtAPLYAb6eQ==
X-CSE-MsgGUID: O34bceKwRs+/9lAduot7NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="243691421"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:35:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:35:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 19:35:07 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axghInuwgzlHEHG8jSTrqw5sY82UGcc21/2FHC9mS3a3r32RmK2uoPJiMez+vWCXJuG1EQARR8Ce8mjFXC0HxSu1TVMkXnKG847jKFPG4F/xblJ20nWUR5a5aWmPMZxmmq3iOE/ffAXL3SXgErwZHd6h1iVe9aussfFqFTgG1DRJQvHJMWJTyEbY70a2hZ1ZraMUPqq7XtWxe4r3FSrQC9bFfAjq6LoDnYdW6Fo+F1P6BO22u6AYR77U2dknodY+kZm/Zn2kQJZY77MPLHIf9/0JJq0a9PAqsslZVAcHI7LlY9e50k9Alm0EemeLV/1kMOoIX2cVOVM8sFgBvqeQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0vsIchIz+Aig1vEn+alQCU0NS3QqCTZlrfO8fdvWQI=;
 b=MrsxGFm6LLbNw5QBRtpWqS+1RLhz08fZfvkI0xEsUi3W6eJTSOBmZ3HbeIUNwaTarrUcnClPRZl6MYhIOQ1VkHSFqQNas0abK8Q6TT/6/zgVyliosc5J/DV1l0ciph+2olls1niPOCTT83Xxod75BAZyNti8tNeX7/ybbl6pGkclxplWocZuQUuKwgGty4Y2CCkAlf3Scz0UAGzvJP66cYJu7BKKNJv9/10KAJSU4Nl01ty1LK3n5xptaEmwF6YwllevfxQ44KwnWme8i18O+NaNqogtthzwWpoZ+PC+45CsrvF7Zu9TnRQ+mcS9XJ52xdyS+ZF/Lg4sYDUEBzjBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by BL3PR11MB6530.namprd11.prod.outlook.com (2603:10b6:208:38d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 02:35:05 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 02:35:04 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Rosen Penev <rosenp@gmail.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Borislav Petkov
	<bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\\b__counted_by(_le|_be)?\\b"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] EDAC, i7core: use kzalloc_flex
Thread-Topic: [PATCH] EDAC, i7core: use kzalloc_flex
Thread-Index: AQHcsa6lgsFrryaXvUOnijE6qWI20bWqLUTg
Date: Thu, 12 Mar 2026 02:35:04 +0000
Message-ID: <CY8PR11MB71347ED4467F6A4B4AA796BF8944A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20260311232638.18585-1-rosenp@gmail.com>
In-Reply-To: <20260311232638.18585-1-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|BL3PR11MB6530:EE_
x-ms-office365-filtering-correlation-id: 828322e4-f5e6-4883-65f7-08de7fdff805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: TW+/BuDy7kz0UIyu6qPS8aU7qI8ylXFkoBNeMCT/B/7ezhG6aeBKQcqTcAgTvZ+GotwOdewE3wgpZlvUucFVNs0YZOQgHv7r4dtwgOYcAfiR0eyi2gtyoCpa7xd8IgZE45Ichnf6qXgHZpw/K3/kIf3hPWw/7ycoLvzB1VkH7g/SWuzEyl3B5mJ2rJvatZKq03k1CbCc+AGWOL8jA0b81GAZwZJ6jbrA83qBNsEEmJfGR4ItjaR8TKMSTwfGctCGlNobp3XQxSx+aYSvqsdRGLn7IVEZp5T6rMqcexAKYivp/rJpl8IUGgdEpB7dcNcs+9sgfLFLeP9voQH8fqOpino+i7RljmOOYVEWCpMMntBq9rgB7zTZvwqRxH/twSxgTtuogaVutHh6xnwXLa6YnimYViwjAcot8pHPBEOyN4f4vNmB1fHnPgJJHow+h7BWJeNHks4GeVCgUz5+zZ7r5WvADee5y0/9gscBzYxpsgrgbkpPKEDNFM6XJDFkmvppfYgvgffE8u0N9jZ36gk8IBoodmn+uXREOgKBFnbv4F4h5hb/kW7cpWpI5i7sBCDO5HfXzi1l8IIsC1787oz9COtxNz/q4+4aD8TmNZJIFa2ID88MEIzzCiXWrjFUIcd6VMoUEMrrkG/Yx32GbecL3CUpf8OpI2WvTUFP4cSE9pH4fgQV521V0jnofD82/CCojOWAAJFdQUbbjVIfADj7iRgdEOm2/mp9237SKBhdjEPFzUtrEMkSsdcXRUPSB3+dHyT16dPIGXwls8g2JRDvAjXZgv+18jNG75ejDpCGroA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+15Mljk0zuuVYVXtyKuBmi13kZQRddfoZMTNYSIqdv9AskMZO5cdTLBDfr6p?=
 =?us-ascii?Q?0kexjjDLSBICFRH4VXmGkLllsvrRcOJeTUjKSegVPkMiI9LsNZyWaBI6GksT?=
 =?us-ascii?Q?oshGrDWm/e4byZRnBVlJSB6GUxEinjgZ9ufkLMonN5bhvkEPs0byr/YpfBmN?=
 =?us-ascii?Q?fiTTamX+sgvzxKYMWYCp6VDWghqLpFvHASdqRI55AlnmpTGAwt3IY/msY/CY?=
 =?us-ascii?Q?kn5YSxL1KYUB0RJAj9tiLk6ztzFdxYSOJh4zHZiGIT++nbQJ//cZBVQ382PV?=
 =?us-ascii?Q?zQKAXZBA4I/8B3aSViF6y1FsnyXQAaLTK7IkZ+eYRan5i59MnADzdnurRvnU?=
 =?us-ascii?Q?FQR50VxMll228sP3oLg6vRnRCbfiQmRZAxGmVHBh06HVzIZ2kFQTHqWEyUZO?=
 =?us-ascii?Q?vjqFisNJgAce9s0qRix2dIaWFWwx01pUoBxlRto1hnrT2eHZCFxhh9x82si3?=
 =?us-ascii?Q?WsCw4G6onMo51C5xHliL0LfjJfj3phTcT6whvH/iMwqDRoDTc+FJ29B0sUFR?=
 =?us-ascii?Q?P7aIJWdNUEa4LSwQ2zk09pXDVAAEqs14v39SB+ATmI1ZWxEWdH+GxM5j0S3u?=
 =?us-ascii?Q?FPfk+GO+OdO02abGlD8qXt2YO8bnHFtFMAb9lnIjCUjYOr5Yy4nt4obA+Vl7?=
 =?us-ascii?Q?FMG6N/6V1lLKn8/4adOEBm1SvCCN6t6K/jGxti9SCP6RjJYVGgIWGqJf5BMc?=
 =?us-ascii?Q?PUlJH4gbqkBKprijR3IdrxNFlYLp8MGfaJNo6I4IJvejVJrHqz/HRaxtRC9V?=
 =?us-ascii?Q?i8WmDO4dqVUY9blBsf0ASjR87H9ezXQdmWndjMmzBBWMLQZKFv2B7poQDQnA?=
 =?us-ascii?Q?0XyEelBrz49nNI6SJrNC05mscNa39BIMJIQ3ycfK8DqKQYt0cr6l0IdtyAmS?=
 =?us-ascii?Q?A1gekpIxLJ9FqepzKA4iaK46akcwRfoJrD0kMb3C8i99wjDHPhoUb2uI4pXv?=
 =?us-ascii?Q?/yasSIB+3kVMkDsFEmVrKnU75+0eL83y2hf2CsN8nUrnp0rsexueV5jlKTWu?=
 =?us-ascii?Q?VHBUsJ91gHj2xzvYWLKUzgLUnQhPctpOtZo8EL8y2p6sm7pvDEHR50bWqjIk?=
 =?us-ascii?Q?2QBraJbDYfPrByPGIysnHnFYmAv5wEDAqXRvXeHN3tOaXqQVM9zD1P9OMgLH?=
 =?us-ascii?Q?xwSXGhhHEMQk6d/kAegu96feX4UyDM1azoDxZRYsEq/764QhKqi0KKMInZcG?=
 =?us-ascii?Q?kH2d3rIBHThOlGjtQ20nsFQiSNZra7wxDhTLyRhs3OwJY0uMyo6F/XEt0PUY?=
 =?us-ascii?Q?sasdKXyKcGy3mXogV/NHbqzIk5LC5xxzhT68HQIKCWlOi6eF/CuGpXKjLjFh?=
 =?us-ascii?Q?YtE4Yc4EkLIEZseQjDI9NL1xRysaxUgkKv8MxNPI7NIYBnm0pp5RkrsETlXK?=
 =?us-ascii?Q?uSTIjcox/Xgn7fKYMXvGu0RviQg7IHvcYeInkFcWcOROrieDEH4/YW2mAFIh?=
 =?us-ascii?Q?O0voHGRoSUc/xbM3ybehxdbGZsDeK17ER0Lwkqc/x9kmC649npS5AsdfxZuX?=
 =?us-ascii?Q?A8O5KHAy62Xslxs69tS1Rv3LTD2AyJB9wVOGMkLiEqrSsU6pL0Jr5uPOOgl4?=
 =?us-ascii?Q?JntTQ1z6nSR66otyrjr3O+FkM0+VGuc1RFRck21hn5vtFXS3/3Xuxi+WEwcU?=
 =?us-ascii?Q?b3NrFqlk8XDyTjN/ox6u2WAhG06HUyNvTCEK6mzcS7B9Lr3/eZym9j6DxYFu?=
 =?us-ascii?Q?ht+PeHMFd9/cXPITr11QjD8f7bp37TTxqBlJvxoa7B4JE/FnCBiKsB7Z190I?=
 =?us-ascii?Q?wZQHUsXOeA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fpMGQaXEGMJa8m2Ei+Og5Or2nGG4r4gTqY2tnY+7nPnyxEYlrgK078FUpoHRV/02lf1SGoRtpEAGJfrzlKWNIbMTkQ24+/wtIIv1v5drCD6+Kio4Lq3WqrXCfalmYv5PuBicQmXpxImpCeilWvFWyAnr+yT5Ey+UYYR+PGXGxv0vcfOHicArTR7o+BT1LM2ONX3x3S5trU/kUPdCcllNLtwM9j5p2h3XYiJXkgoPvYtfwM6byMn64K4L4lciitnpcm3kmy0AdqsTgYZ1AOnwO5ANdL6iqKSCimFddLh5Us52FH40iIenCK5Uc5ymfjSej2RblpHMlqLfEyKFJYZklQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828322e4-f5e6-4883-65f7-08de7fdff805
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 02:35:04.8269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHGF5EbuJaxFOcq+tYopZoU1A5ZgcrIfcAOGSrsk9LaV7o4NV/5q3OFz7tSPr4SX2LaNLlgBrsOPW9ouibdycw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6530
X-OriginatorOrg: intel.com

> From: Rosen Penev <rosenp@gmail.com>
> [...]
> Subject: [PATCH] EDAC, i7core: use kzalloc_flex
>=20

Could you use this style of subject? Thx.

    EDAC/i7core: Use kzalloc_flex()

> Simplifies allocations by using a flexible array member in this struct.
>=20
> Add __counted_by to get extra runtime analysis.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/edac/i7core_edac.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c inde=
x
> 0f783173d0ec..b87c4c6471ea 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -240,9 +240,9 @@ struct pci_id_table {  struct i7core_dev {
>  	struct list_head	list;
>  	u8			socket;
> -	struct pci_dev		**pdev;
> -	int			n_devs;
>  	struct mem_ctl_info	*mci;
> +	int			n_devs;
> +	struct pci_dev		*pdev[] __counted_by(n_devs);
>  };
>=20
>  struct i7core_pvt {
> @@ -455,18 +455,12 @@ static struct i7core_dev *alloc_i7core_dev(u8
> socket,  {
>  	struct i7core_dev *i7core_dev;
>=20
> -	i7core_dev =3D kzalloc_obj(*i7core_dev);
> +	i7core_dev =3D kzalloc_flex(*i7core_dev, pdev, table->n_devs);
>  	if (!i7core_dev)
>  		return NULL;
>=20
> -	i7core_dev->pdev =3D kzalloc_objs(*i7core_dev->pdev, table->n_devs);
> -	if (!i7core_dev->pdev) {
> -		kfree(i7core_dev);
> -		return NULL;
> -	}
> -
> -	i7core_dev->socket =3D socket;
>  	i7core_dev->n_devs =3D table->n_devs;
> +	i7core_dev->socket =3D socket;

What's the reason for moving this line of code down here?

Other than the comments above:

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
