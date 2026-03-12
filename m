Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B53377EA9;
	Thu, 12 Mar 2026 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282502; cv=fail; b=FBNU/ZRM1aQQFclLm+sQH1W9niqFfcAACxkChrdhxZHREL6/3JGrhm7vTNkmYQGF4l6dTxM4QrB/yfkh+d9pKvi3QGQIvv9/9a4wolrRa0yI3ZF3b7vDGNuCZZGDZJjjEbREvtFqMrhC7Q9ngRUtDwEVXXoweSqx8wVBfFDHFtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282502; c=relaxed/simple;
	bh=mCfYgdd8pdZGH0gtRIUXWPjoCkvn/AVg91aBcOcakQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hw23xNxqIrfy/BHwp3gaHw+NyIhZVEkMKblF1zUDS8Q8IKSh5K+Uo12qhwEkqOqFC1+wE382b2oc8hDIm8NNisOWIn1vvoV6xWEdN4KpPKN5d3Tx8o0K88M7zaEfTDzZbzdAniNCDTXxctT5SGZqkopGch/BEBX2/6eF5I76P78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1m1INQf; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1m1INQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773282496; x=1804818496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mCfYgdd8pdZGH0gtRIUXWPjoCkvn/AVg91aBcOcakQU=;
  b=i1m1INQfQX2t1cUC9lR68A0SCd/nSF5ceMs64YemrWQOV56SnxA4jQTO
   ptyo1+yHb1aYKoyyFTtnTM3MLisLi1RqyXd7nQ5ItpRPs0IH9reDdr2KF
   q4qAH7mjm2vTOQ0XwusPO8Qag5lslAQX1fGbZhW54qeaJl51aEbDdZjRC
   3ZQ0gYQHyMDwqL104LP410pHrSUk0pRy8qabM/AuPz+JWiGHp/VRMKBiI
   0hezWjL8tDubKCYjAtqWUlInN49qG1bhEfGfgSfDu3jSlVHY23qY1AGBg
   WlhLslvYKaefXq7LdweByLWiF6evUYK8buFBoFq3KXTdQzcTdv+cv/D7m
   w==;
X-CSE-ConnectionGUID: deIjXVmfSHeFdPhiuovZ0A==
X-CSE-MsgGUID: Nvcr7Z2/RzmHov3d3LuxrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74407167"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74407167"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:28:16 -0700
X-CSE-ConnectionGUID: nVIGwTcFQ4mfwroaA6Sbrw==
X-CSE-MsgGUID: rQtt3RdSRs+Yxgvo4gOPqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="251166198"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:28:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:28:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 19:28:14 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrVSI3Krv+ziLYi9AM4LbenIFDDkmiOUk1/st7xuG9x4c2jclF/DCIzKbIV8UJeCdn2cqTdUtEEIhiNGOMZCExxuLPWpdO2cbRlpbckGeE9irVSkm/H2EHAAKFtRNrORH3OWWV4npXI2Z4mDWLYoCLQNQFd+O1WqPNZ4Fw8FGutkQGOAYW1SAfcoLalMoLBTD8gobd+RUAI93awBVMP6D4/ncM4Bx4YiHoseTSdtvi+ZptSwdepQjm+Ou45bQdxybevozSLNp8R8N3m6J9Gp4j4hd2mA8uQICrJL60bklXXynpRshS1vx1p/B5LFeCscVRlVMd4ArtQPDVqpojYl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vhS0LtSQNV2y/jEDGbN1qDzAxZb6k7oBIqbH1J5luI=;
 b=kLL7XTorGhDbQDpYagmAUXQJJYs78803dDvyJvuS4LRFhdTkeu+y9O/M40Lzk0A8XyGWd0e7piurGGU+1IzlnZ/NizQwPLurQtS610yVOmRkcdGLHZ/2nI9+4zGZ7ujml9KaTfH70uzy8IZt8m2RO1AZsFH1o7+mwxUuNBHXqY9aXJTK8bsOjSX/ohpRQjMp9Ns7pZvRcJzLgNII3fnRk0pHnx7uYuzSNvP6ldGsfGthjLReMWJWA6tdAYbIX/46pIKswzUDEUPXJ2YU84qeI2iy71JINNCAy0RCTDE0S6zOQJ70XV97qGNLAY+A/GgEiaPv21Qmo3uzz8ttmK3wCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 02:28:12 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 02:28:12 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Rosen Penev <rosenp@gmail.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not
 covered by other areas):Keyword:\\b__counted_by(_le|_be)?\\b"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] EDAC: sb_edac: use kzalloc_flex
Thread-Topic: [PATCH] EDAC: sb_edac: use kzalloc_flex
Thread-Index: AQHcsa6D4/38LH2sGkiaK5cIq1nXIbWqJRHw
Date: Thu, 12 Mar 2026 02:28:12 +0000
Message-ID: <CY8PR11MB7134FC62AB39DEC3AA26DE2A8944A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20260311232545.18492-1-rosenp@gmail.com>
In-Reply-To: <20260311232545.18492-1-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SN7PR11MB8025:EE_
x-ms-office365-filtering-correlation-id: a10a1f1f-d6d1-4a11-1eb7-08de7fdf0200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: aigum7YZd1CxcI8JRt/apDz9OeSnjodvY0KswPbzKjHiLjTOLus7bThUw/ozrVTCsoPq2ejB6y2LZEc9rCrmGO9Bw34J2mwTJuEuYcEQiPERgSNvzvefRr51j60svtkJ6t1m3nAX7+MbjdRjPy6egxrpBo2ycGy/lElh5SExi2VGoLdVm61iVv599vsa9Y+Sj7XrKoj31c+YR70zDRC08kaD5HnduWkwRxuWexKiW/9u925Bk7QX88YmHrgCjGrROms6xFJqlnsp/YtrJSlKMvwKjvHfxc97NHMRmib6Pau6Rp4P+ZmYABQS7EQGz6hxr6P+Mq3tfPJ+tIfxeURWhOReQAPSf051BCJwpqJkj/QmgxBQESivt8zRxU4iJYJifpwmSU2Su9dgMyU+u6VnRMR+AEafGZsv5NvE0H2hrKo1/nLgxeGQ+0X09f0j4/Ng+2NsO/C4Fuk4qre+wZHL41e98CAgouR+duZ5NhplreOJBtQojZ5qSs7lQh+yrBHkIr+QnCRh82PFM2/0FwB//dCO3iURXaYz6kAHySTJLS/RWU9h6Lo6sdeYzVj9CuY2zQfsNy5eg6EZD6oJVmeK6KVJNqyrWdmhm25y+hxelwYumxVSpW3syAwfn2aB+GrncQ4GpROoObWRWfMcH/Jh9oYQ88PXKyvWh+UNKBRcDQzfEhIjHLWCk1MM0B6PSr1Cu7yteR6HjCToei5U7tniwqR1IXRgeqOFSW/d/o6ZrXuf9GHBZlNovfQSqaPK8DFg0M/dAOUmswP85vVR8P/ukE4KCGDoQuX+pIdWFtv6qyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4iW+HFInK3YxitUSrK5PzT4R6/AKLLFwWyuISoCRK6dJaYnvv4G1VJ9DLzlR?=
 =?us-ascii?Q?opCvlJhJ4nrBb6/g2Apy33/5mRGHtVhFw7g8sJdDDxOZPxx8q6uBTBy6R4my?=
 =?us-ascii?Q?EufDuRhdfnlF1X750vgv6VmSOVBeAMMOq95UcJmPkpILS43Rk659KKc+FGKc?=
 =?us-ascii?Q?Ik0YSQj3g/5qJFOmktYWBIk5Dh10cwOQ3ppZVqUWEqUsSacS33+xS3YyeDhM?=
 =?us-ascii?Q?Y0z5OgAVEwrDl9YTGmzBjSobhwaqJvw4grfuTPYs6ArnqodCpoNTYvT5+cn6?=
 =?us-ascii?Q?4MdWb4RGegv62Yf2v4c9UQZphY6Xy9xMXrZsFzYIOY8KNmhzVO7R6CUUC6F1?=
 =?us-ascii?Q?YfO5zNyOzGuaHj08ojpi1WAN9XPcyb+XZCbQzQJ7eZL549Hol2/YRymR8XkP?=
 =?us-ascii?Q?39wrWFQmLTwIYc6u0Qdarg3ay6+JAMXWdMofmdjek9bknxbtbWKLPzgcNc8e?=
 =?us-ascii?Q?Sc6v+oXYQwZ+3HrnFZnFzZD/Y0cwZcgHQa24dsyFBnXb5rwWuoW4A5N+DOv1?=
 =?us-ascii?Q?vogz5Ix2em5/zxuA4f9dM+GRKyRzBae0X0zeZ6VLIcmXTKaPAZn+8EkoB4QG?=
 =?us-ascii?Q?Z09XHuvz4/+zw4KvDqq43O9LUgtlMbJpZG0Uix61xPPMB37HG8t0ey7QFqMv?=
 =?us-ascii?Q?YFN3my5S0cI72jtQr6o/nL241tJKywsyogXW9dCnRU1SrQCvR4EegL1huf8D?=
 =?us-ascii?Q?p8CEb4/ZUYKGEQWPylcdcHxpSKpzqOSWksH7jDWEn1jtslQMQMUDts3jcrqO?=
 =?us-ascii?Q?8t7RMS7m168y9JkkQm/0GALai3vGMF30QQlbb8Lv+SLV0dl9bfi1Us28h9ND?=
 =?us-ascii?Q?gEX99wyUMVl7x6zlE8PRNwFXoaHC5L/kAP3lDT9XMPSUuW6/Zn2G0hcJZn6z?=
 =?us-ascii?Q?Rh1fX51ggxQNLT5f7mFccHIFj3f8sk6pjhHmZB/KsJgqAS/LYv3QqiFeJaBq?=
 =?us-ascii?Q?1TsUCcyXcFVLxjtPO+aKba41HWnc4ESM6JzsSasiscfuHUadMCPRIFMCPZDI?=
 =?us-ascii?Q?/4aEYSFcFV+mlRjtTEu15I5hvLypZ+6CjLUno88+eFIr3WTDla1lqMKUL4J1?=
 =?us-ascii?Q?7SUne5f2gl35yQdckQHLIfJUAE0YhTRG+3AXMZZibO1Yk/2PlyBxKY4rGUH5?=
 =?us-ascii?Q?qd5kq0cnMk8o6l2EtFgLgpzIXfeoaXD1bVTqpz/f4i5a7VVjmBBWtmIbpJVq?=
 =?us-ascii?Q?pKFotKGdDavdg2tKRvvnjn9pID6IjeNxJ64ubybkr04056DKGlGR50cOjveI?=
 =?us-ascii?Q?aWJBLox9rxh+ppWe001hWqVrVaH36t66LmNLW1Vm8bKLjla/yxxTCmYwSAgi?=
 =?us-ascii?Q?nusWXVZZBVWiJsUmeIOWA+oh6sEiiMpcFm70AMdtdN17fSHhh18Fn2letMur?=
 =?us-ascii?Q?dAQid82zadEhmea5BixQFkAiuucL76W6cnuy+Wz2t9hkLjtP+QCpymo9lmH/?=
 =?us-ascii?Q?GSvTHX0cNVqOCu/Y6o2k3kmYnmgREE3cD6/xZp9MCp+SFhLg9iUoVMm9yNOh?=
 =?us-ascii?Q?RppjfM45wonyw/AvpEHEFSAGkNOkEYkKx80RTrFoUxBKmXJHhVLqkaSPNvAo?=
 =?us-ascii?Q?N0rR8BtBQS5Frb+xs1WZA5kVILId9IbIuDXlGvsENSVPBj7zhPfEg28zIMJ/?=
 =?us-ascii?Q?/vf3SSyR+xjLxexrO95/lp2m1mBuzSaCunOoQD9NrvxM6/hZlNJJfnuuzART?=
 =?us-ascii?Q?yzpJ6n3ArFvdjX5LPeWhBfJ3Ao1Z7cO/hUvOIuIUsJ+IQwEoGx+uhiYmYedD?=
 =?us-ascii?Q?UYX0hnJwPQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o4U04bwzNe/uiuNwQTmmZqrbyNpjTyd9pSeaU9JtaFjFV+Y49sDoBnLgnQO1i+aSSQFSwf0W6SCrpoZ7Z3mrVMlSktpTaXpKbPjK/VU2jlZBC+Uw+Su2FrV8mqPQFihP89OdeQwi+paO/1qqWd4AXB46AzzlUaI9q4KRTOzUDbNRduwm9vv31cKAoUrc8994Mi3qFkERx1zpQgM3Id3ylBBChxRfhcyesY6y3JxQFfPAGQxfNIzbXyAcQRB3R3gTUNsfd4QD7MqrRk+R0wNGF/hhw0T2LleE8kCihV/od47zROyeMt6e5mfgnOXt9TWpFvw0n32QTWnS2iCwTXlckQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10a1f1f-d6d1-4a11-1eb7-08de7fdf0200
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 02:28:12.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZjr57G9bBkd78KIt8z0KhFiOIT+ohdthInVBTgXc5ifTdxq+6K8uXXv3IF3anjQk9hLvlYvg3QGvgiTV0Yupw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8025
X-OriginatorOrg: intel.com


> From: Rosen Penev <rosenp@gmail.com>
> [...]
> Subject: [PATCH] EDAC: sb_edac: use kzalloc_flex

Could you use this style of subject:

  EDAC/sb: Use kzalloc_flex()

>=20
> Simplifies allocations by using a flexible array member in this struct.
>=20
> Add __counted_by to get extra runtime analysis.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/edac/sb_edac.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c index
> 09d4e816404b..7b282dfd093f 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -364,11 +364,11 @@ struct sbridge_dev {
>  	int			seg;
>  	u8			bus, mc;
>  	u8			node_id, source_id;
> -	struct pci_dev		**pdev;
>  	enum domain		dom;
>  	int			n_devs;
>  	int			i_devs;
>  	struct mem_ctl_info	*mci;
> +	struct pci_dev		*pdev[] __counted_by(n_devs);
>  };
>=20
>  struct knl_pvt {
> @@ -771,21 +771,14 @@ static struct sbridge_dev *alloc_sbridge_dev(int
> seg, u8 bus, enum domain dom,  {
>  	struct sbridge_dev *sbridge_dev;
>=20
> -	sbridge_dev =3D kzalloc_obj(*sbridge_dev);
> +	sbridge_dev =3D kzalloc_flex(*sbridge_dev, pdev, table-
> >n_devs_per_imc);
>  	if (!sbridge_dev)
>  		return NULL;
>=20
> -	sbridge_dev->pdev =3D kzalloc_objs(*sbridge_dev->pdev,
> -					 table->n_devs_per_imc);
> -	if (!sbridge_dev->pdev) {
> -		kfree(sbridge_dev);
> -		return NULL;
> -	}
> -
> +	sbridge_dev->n_devs =3D table->n_devs_per_imc;

What's the reason for moving this line of code up here?

>  	sbridge_dev->seg =3D seg;
>  	sbridge_dev->bus =3D bus;
>  	sbridge_dev->dom =3D dom;
> -	sbridge_dev->n_devs =3D table->n_devs_per_imc;
>  	list_add_tail(&sbridge_dev->list, &sbridge_edac_list);
> [...]

Other than the comments above:

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
