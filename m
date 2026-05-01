Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E63CF05C;
	Fri,  1 May 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647303; cv=fail; b=BgDhxXVT7K8dLEOZxJRW2PSxQKgSDgE7DRNK2mb6YcYX90otYXe7Da/dLcR0ZS1KX8yXE5XbU2t2rz2XBDs4JRbkbRNNQILsG7qPbDFzlnGp7dZIeyZHKc5teKbp7ybc/EsYFFDwgASWYVjZRPAf+nHYLW4YqYLZl5JLkPmDnlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647303; c=relaxed/simple;
	bh=Jynfsgl/2uvunLKuI2KISaYk2aLWbm4M7XXBzUn3p4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/TLZpXP9Lb6N7nGDki2pxOTsB4aGpUdgUKLz+ONKDfiJGUKhPDCwKIjMHMQ8Rr5ednMuF+2zUsigmklDjSKuybC6u1f/iUdXHCsV6PhBDzPlVBnuzx22AiY0Gw9ibPnJi6xxBB+w+ChMGVrphai/LwjD8QIfbCnogQykXASep8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJnu5mk6; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJnu5mk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777647300; x=1809183300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jynfsgl/2uvunLKuI2KISaYk2aLWbm4M7XXBzUn3p4U=;
  b=FJnu5mk6RoRkafuOIh73lrn4j/bjIKmGkOQ3gJ3pMiiGLqbXMw4ndRhB
   bsnVkGdFgWI9+OozTl4cWiZItolmiqPUdpfcz3wSLh+6FMp+sPD6LbhK0
   5xfw1LirWX0lF/KRgOWgoMMsHMp58dpIpj3o0TARMx5XoMvEiDJLmALFF
   qv3GcgSu10ebhODd87MWGCtBi6knwUCbpyz9AjhOAt2Bty9CS/fcLlVjO
   tCKnU34JLPIg0osbiyQOmX5frpAGSuOzEfuawh/dcZxiu1Xv6zmQ39y3C
   wBKnj2YTP1x6dKmE3ayysURo4xtiBemU1ftM0mV3ag3hmW4a0+HhMrk+N
   A==;
X-CSE-ConnectionGUID: rx4swd9FSZWg+CRIGEHiBQ==
X-CSE-MsgGUID: HldV2wNNRgKFZOi/pFkJaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="96170245"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="96170245"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 07:54:58 -0700
X-CSE-ConnectionGUID: JJhLlPSuROCzbMeJb2o2+g==
X-CSE-MsgGUID: gYPjWG74SdiYxQMsWTInZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="239206089"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 07:54:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 07:54:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 1 May 2026 07:54:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 07:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOUFFn4Xtf33UFMxD3qX+ryG8NSQpTc53DJum4nodR92acNsRs0liZKNK/8Q6KUJ5pmLb6f1WwQcAVncmXfOi3y264/mkU3xmG/AQMD3eljkDyne+NLFThwUdtlFpPwq+lougkaDbLXZVWAFZY39zsBAiqPq6IJo8cCBuNbYJhojs+qzTQL/MGa5QVoZIemxLpyVqCQ6NfK5tOpGZaCAEYINkXrytd9lJDJwj/xMjDlmrZjt2Q8hzJqc2xRhVu1TFMGETR5m5l6n8wJ45xLtYZdZ7Clhf4fqLums/ZrVVmdA/iuRF+xCnLyB8BgYnM+e2DViRX2oaSXugZHbOjfwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ycS9r/COGJil9DRQNlsEvKdSxSFgJimaoOJXUiV5zY=;
 b=cw6beXFCIArEWiMYSgVi6LAOknU6NL0NG8mRrEmPFrg6qI8cBPr4Rg1F9DCSozifBxtNTYW62micje/36mN7lxe6HQwFETmvXoFqMaqAg5lwmvwAp33rI+4OECKZihaFHK3+Iy3ycQvkjJjWFRU9qpIaJZmmmwDXdclh80tw5OR0UV+g2GUQ3slt4BcKGgDsi41BhNyw1uf0KP3NLTK+1LiK+WX/frFaM/tbwGdVTrNwY+o1trkj7uYFGVWc+r+Wg4k3/cwMxsJymKO9V7DcyllwTnog/Rdil/KsfhQGMx4P56bKt/X1R7lBgMB8zHOHyYOlHcscZLCxRU3Evim77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 14:54:54 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 14:54:54 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Rosen Penev <rosenp@gmail.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not
 covered by other areas):Keyword:\\b__counted_by(_le|_be)?\\b"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH 2/2] EDAC/device: 3 to 1 allocations in edac_dev_feat_ctx
Thread-Topic: [PATCH 2/2] EDAC/device: 3 to 1 allocations in edac_dev_feat_ctx
Thread-Index: AQHc2Oz/fwypz4thqkCopjKRRk4KHrX5Qd1A
Date: Fri, 1 May 2026 14:54:54 +0000
Message-ID: <CY8PR11MB71343FC7ED0468C6A774CD8C89322@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20260430220046.72371-1-rosenp@gmail.com>
 <20260430220046.72371-3-rosenp@gmail.com>
In-Reply-To: <20260430220046.72371-3-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA0PR11MB7353:EE_
x-ms-office365-filtering-correlation-id: f58775d0-409b-4db0-8b2c-08dea7919ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: jEH/nYQYVMmVt805VmMxev2np4vY3pBkpo/ISTfWnhUYqqL+OOVNkE6jOm4375i01Ocjpu0DZoBkYorMrJY2frCGyStDe/gwRMiQQf05+MBeiA3m+4FQj0clbP7MmE+Umvi/X18KJR3vkZ3zw7hX83B3IUjYZGVMrl0nY1gQmQ49is1gVDfroX9/Q/HKZjU156vkScndnKAvH5DkyZv1FSqlMNteVRDXnw7g35ZHd5chUzdgADfkymjDWQoxP2aOsKnse0DdlHpWWTBMj6YGvhnVDwOJDXwT1VPnSy8a0CJHtGJZs59lsd3lBaP4ZlWon7Rymk7I+tT2sQSyfmXdk98eEuOkk3GPM0swmiSbOpk81UeB6j21VY5+mkGZkxhT47O5uG7x1vhG7y9qv5tDeisKBMa1qp4Hwf5YwUZvXSU/IJv5tslHhqjWOXPdGv/S0rlnHTBIbyBUzIGyZTKbLvA2Vmv4AZXYSJiYD0iRtDghWNDE8aSGY347wvD3kirRn2gOlUW45n6bAdxjmMKAn2kp0u8cE7CLdCNXrXqHOk5LLPHRwN0gtnz77E6HsFlUZkfAVLkiEX6QgfV6IBrBeujmdSOoGTVEa/kRSCsxjufke7Pn+Sp6fKSXK3XO11LbxB5qVpQ81FYxSqRlz6M3sei7kUQ6dyhKd4S6pYz5HgoYN5JEZZdCEQN1KgWqnGoB7Pdyseta/dh8nYcpUOB7oLsSsq4ayYabcJVejfAtj68YLpL4vkJ1lSKCxrV52hL8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yjX9iwTlz3/yoEhw3AbKUPmjRUgQ+g2RZZxVp5GRpgB3TphxE3V8Ro4Lgfdq?=
 =?us-ascii?Q?qtslPoYnDyK1Fqx+BbAa6OYZS9hMdP0XQLXRVkC5OBC61x8gW+vedurxdIU3?=
 =?us-ascii?Q?6/aIEG6mj7mqUXX0TCkZwN2YCnWG/Q9JfuTb0bmiF/Knfs4AhosG7ZGi/M7B?=
 =?us-ascii?Q?U8HxJQgsq7K8/niEZT1g0QxUhYHpViI+89Te3It7p5iapbywpw5IE6HV4CC4?=
 =?us-ascii?Q?fA5D+jcYukWoe+V812tl+ZXhBO1VRy4ENxdzBhkcBWOGPiFFHj0lTSlYtM/C?=
 =?us-ascii?Q?KXx/x2pG0AWUNTrp+ECRPmhOylA8+xX4TkH2ZX2e6sbMA2UiEKyFcuqYKJi8?=
 =?us-ascii?Q?KTC6xXVyXR6YkWN/LWkya8I/blDDDflE8NqpAByPpsP3BtVMNorOetlC9SyU?=
 =?us-ascii?Q?2E2Fe9FQ05Llvw3mRrj04G7uzVPOjmizdTFZGriBffTVGunybeVGETl/cBpX?=
 =?us-ascii?Q?oJqTfzoVBybK8PeKUWGpkix2xF/7uvGs0PuSO3UCHKCC7PfSXQDUNe3VwIyk?=
 =?us-ascii?Q?rEkoPM64Q/6JRuNO7WXd/rXkB3HtIPnFaCQdzo8UFH6VbTEA88UN+ql5hPL0?=
 =?us-ascii?Q?CNS3gpUfheeZNzgbCVWA7ZtllQwt98UgS4/mMIscA+Uu32EP3dce3HFkQTna?=
 =?us-ascii?Q?ne+TW5/XanaeRi6ABgDXS7yinBoTtYG+MulLqWFXcaEQexC+JUMQe24G65EO?=
 =?us-ascii?Q?gtTmX/ii4OsdfRvV2ER2TFdPr2kKvBQWtzfI9kI+mAWGvNLy5sS7mryEr4Ks?=
 =?us-ascii?Q?GmtoWIinIYAQu9CunuiYs2CJ1ESnD71Ayqh/cIvj39/Pg0JAvQkvp/8dsyF7?=
 =?us-ascii?Q?Zxb95UFw63LCcQo9BMszBkb0K+ZcvWF7mUUC6053Uyr7km8YZQXrj90mzLrB?=
 =?us-ascii?Q?MNC9IwvaLp6SwqWc/aDpB9e/V1/kE2SoVQ21hTejjL5l/c7Z2c7OUhnxVG0T?=
 =?us-ascii?Q?eFbIFZmtUKVYkF1JgrzAepkvb2Ky0wrG1F4BojLkp+ssV6pOO4SUHkneFoBZ?=
 =?us-ascii?Q?Gi+ltBtXveYPVhikgQiwoO/3qiaYp/iF+3EWq11rRIOi5EwWUl/pvEq7sVUg?=
 =?us-ascii?Q?TTiKlGv8BM5fG2tvfV+xA99pje85APbJah9isghJ3JIFZ6P4s2YfE5Sq5sK6?=
 =?us-ascii?Q?TqAeWqGKU37ix8sl+/EHLdOLBfqiwE9ryeL0L87+/80gwvupwWZ4eWadKk3I?=
 =?us-ascii?Q?u3QUoJLs/qfMjWy4YsXqyfZnfjKFtJU2bwLzHCDgWYPJABGlpNwc3/RPXHaL?=
 =?us-ascii?Q?zC/flv+U4TkSN5c/xqTxwqqX9dcYKt1SAK9FnjWwFFAgGb64hPkYc+Y51Tuc?=
 =?us-ascii?Q?ypTCM5yxjUiBGmSzv6DK6UD9Zg39b4ch2OJT4Ju9OZSRjRpnmLkEnyZlzvGN?=
 =?us-ascii?Q?ro9uTj09oLGRBaipsAqk/Mfh/lntKtFuTT6Rd63q9lEGjdHVK2taLSoesPw8?=
 =?us-ascii?Q?j+hwKKbvPELzuvUPlA/JmlRm76caUkcaGsmo7+1HcIqLuVz9JjDoMUwgyTTw?=
 =?us-ascii?Q?jly1XbW+AI7/ZXmeKvpA1WUt+w/qpb9IOBBmeAS4XnDljq0hlfLZjhmezqKN?=
 =?us-ascii?Q?6xa2JaZOswQT5yMIMxb0r7OHSWAmAmmoIdAdbpis20wiWt5KhDq1g0eJxI/+?=
 =?us-ascii?Q?UvwkJQINSD1+bJvmMnTAbSgqsh0GBX4vjgwnDUgvrTRbfHCXP+RiCDCjpbZZ?=
 =?us-ascii?Q?u6tXWMtVnUaXAL66l0XMPTgImtXiZWGgBgzchfg7a6VxjNJcQcwuWDbTYD2U?=
 =?us-ascii?Q?AjJ/qTymPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q6gkJoIHkawhht/AezvhtWwKJQWvzHUJ+c4P3tZI288kcDDq6Zi6VKnO3bBG8g8F27BruWxd5U7i09jr6aNMZDj04nJxXLCuNnMfUQy7Gy8gD2skjk8xtdNxQlrNfk5CLJNPo+K2MsObJTlhNZ5XXG9T7jEuh+Zqn6V+XG/J7n2D4rnkrDmie2hsEfvhQ9u23RKUvphkc0wL5zP5DPhxGQv8XEPVsSWgJhDedzs0AbRQ7Kx+gy5zWasCeCp8mzKYWPUtdqD98hLrP+G2FlPl6LbHaaVYBFfvK54PN71+s3S/aOTgpFsJeXs0G1Z5HMhTJpPQaofFYOIWkQT4pSKF0Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58775d0-409b-4db0-8b2c-08dea7919ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 14:54:54.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozCVkWmkjcNOaBvR7sTrYe8PLoBsuI7FwHT4CvFxClA4ya2l03expQ3ttPHZDqxTfoTlwUybNwftGgvlGCzu7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
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
> Subject: [PATCH 2/2] EDAC/device: 3 to 1 allocations in edac_dev_feat_ctx
>=20
> Simplifies memory handling slightly by using a flexible array member.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/edac/edac_device.c | 40 +++++++++++++-------------------------
>  include/linux/edac.h       |  2 +-
>  2 files changed, 15 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c inde=
x
> 9c21997a50e0..a6c41ce68f13 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -569,8 +569,6 @@ static void edac_dev_release(struct device *dev)  {
>  	struct edac_dev_feat_ctx *ctx =3D container_of(dev, struct
> edac_dev_feat_ctx, dev);
>=20
> -	kfree(ctx->mem_repair);
> -	kfree(ctx->scrub);
>  	kfree(ctx->dev.groups);
>  	kfree(ctx);
>  }
> @@ -612,6 +610,7 @@ int edac_dev_register(struct device *parent, char
> *name,
>  	int attr_gcnt =3D 0;
>  	int ret =3D -ENOMEM;
>  	int scrub_cnt =3D 0;
> +	size_t alloc_size;
>  	int feat;
>=20
>  	if (!parent || !name || !num_features || !ras_features) @@ -636,26
> +635,18 @@ int edac_dev_register(struct device *parent, char *name,
>  		}
>  	}
>=20
> -	ctx =3D kzalloc_obj(*ctx);
> +	alloc_size =3D struct_size(ctx, scrub, scrub_cnt);
> +	alloc_size +=3D sizeof(*ctx->mem_repair) * mem_repair_cnt;
> +	ctx =3D kzalloc(alloc_size, GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
>=20
> +	ctx->mem_repair =3D ctx->scrub + scrub_cnt;

The same concerns about pointer alignment risk and code readability as in:=
=20
https://lore.kernel.org/all/CY8PR11MB7134BF3800324EFA1B3172AA89322@CY8PR11M=
B7134.namprd11.prod.outlook.com/

-Qiuxu
