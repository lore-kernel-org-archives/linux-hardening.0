Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901EC35CBC4;
	Fri, 20 Mar 2026 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993964; cv=fail; b=BIBn9BKPs3cH36/JyMo5xpijKQwaMJLSSWgj2zYKhbQLaVk+N8IfvkLDBEo4K4nU8GUEQGIndvAqoFKgwwwMnPNyYSpuK9OLTewQmQLnEUTQywAoJwNV5p/y+KYNGUBuvgFbL7siv2zmODCgcZddjhKNAqQfBUETBEGAlRkzYn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993964; c=relaxed/simple;
	bh=cjmrgD2Y/NCbmdnTHcj5IHow7fAryndTb4K7xVqh3kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocilyT5CixV7speSmzkCUD/TBQHHCWC3urr9Vs5WP5ENepbVwbB8ZSnUa6S7a/vxFwxI+2H/0V4I7O/VMClUlqTCyycjw3jAYJI227w4VFq8qp4n10gxx6fyZXO0WIhaJ1xIdyZGd3Gq5kIZCUiN90Qt+IdcPqTvgHttisuLKUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqrZTCwQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqrZTCwQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773993963; x=1805529963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cjmrgD2Y/NCbmdnTHcj5IHow7fAryndTb4K7xVqh3kw=;
  b=YqrZTCwQAf8EprwWyXLjhKJD1wkdf9x4DQ6Tf95Ml7xjXi/HSzsceFrA
   wUrG7AHkOsuPiVR65H3tu83jkOtR0/KKrpk7wcnrGDR05ymsdVz9BK+Rq
   l1VOluVGUCbbCZYb7sT0b2QjxgcgydV8TYi6V0qLnkFqYLczTpMUMPe+2
   s/Dj5Z0CiMiyVJUXAR5UsBQZ6rkLpvd6BWK7ZB7ESxgDjucXK0KwlDL2P
   eApHMIl/maRzOAsJHZ7Z0raKrw15xsCCNm44aUcLh+zWo0uBUM5X+pHlN
   EwIyVS+sIjtLSn0ItmOC8JuHzIuCzqdYB7mUSfiw8oCSqVagaHx9OEkli
   w==;
X-CSE-ConnectionGUID: jFTiDcTKSLuUmvFrlVwlng==
X-CSE-MsgGUID: EMeF9hxXSDG8Io5tolxk3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85777754"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85777754"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:06:03 -0700
X-CSE-ConnectionGUID: qIOVKfTyQaKxTaFPaPSKwg==
X-CSE-MsgGUID: MXq0Hlo8TOSPdq9l1aP3nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222443566"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:06:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:06:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 01:06:02 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8GYrV1x5sg14xb62LyjHEe+wdts2mgzP/NPMxuriO2H9mz+uZLEY5uiesQDdFsFYw8P+Euo5tmsyWJ/Wkf1F2oma7HEy6lX0j8TYhao4VS93nyzTOaznmr4rMwypy9p3NGVo5KMvSxCqgWEGb6Ky+0Uz5czoeFKZR2x5tevNO1bS6bnL6rNA+giirREom/Uz5zSwlIltciLcGfV/cne1imDjR0qSFZNTzrNSrGBNvrFXExNfFWS2OF6FkPxRCcHH+GDxU0XNO+qwhEwFhjNvI1/dcunp+ZmFV142JTMoGprWppMkTMG5CWa0lVRRhyo6PJIHPzKSfWaHSj8HgJo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9QoSgZzXs7jlzzht3hvYOOT0VEVNeevhbL5Ljzsae8=;
 b=j8oA0pDzelZv+GLj2/ho0BuX1p6AoZIMxiTjmyD7HSu1W4wZqPvzxP9ITOe2NGHbRgsaX7Lg+4FzkAxlcJBBLv9zbMtS8oX7d2r+vsWXWi5KbkcNr8EH8HXFq+dqWBUfHLcBM84FUKIqvcQfDi09MDJF6QvcnK7FLWm0vJ26XrSDIqRMl2Q4WL/7YAKb0Qyej3duNeGxrb4tb0U1JCKUzEKQ60IPOuzJt33bhXg1oM9dSW+DoE+sWCoE7c38do3Ykmsn2pCUJ3mjBOHG53B6sw72QKD3Sm4eVGu8TY50MCDEs6MeHAUODqNXgTk7S5VcYY4VtXR/G5QbhHNW+I5zcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ0PR11MB4959.namprd11.prod.outlook.com (2603:10b6:a03:2de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 08:05:59 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 08:05:59 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Rosen Penev <rosenp@gmail.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not
 covered by other areas):Keyword:\\b__counted_by(_le|_be)?\\b"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCHv2] EDAC/mc: Use kzalloc_flex()
Thread-Topic: [PATCHv2] EDAC/mc: Use kzalloc_flex()
Thread-Index: AQHct900EMS5MJGfkEOAHRENt0pMU7W3EKig
Date: Fri, 20 Mar 2026 08:05:59 +0000
Message-ID: <CY8PR11MB7134662C1E03456417AF9771894CA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20260319201525.174493-1-rosenp@gmail.com>
In-Reply-To: <20260319201525.174493-1-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ0PR11MB4959:EE_
x-ms-office365-filtering-correlation-id: 35eb2584-a6a9-4c33-fb55-08de86578569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: KOREBGEvJB61fXcev6zjEalozR+aZ3FaWvMLiaoDR8Vp5JPA0bc+/ZAGFZQ8Zi3GsSgiSXdvX+BnWdHiKyLJ4ypbqnskplANrDF7NcoPzkz0ZJ05VO+xpfOEvMxPNFzRWmoLYcGyTwjb0hmc9sVVcOHK50o013eIgM6V5M6Tar+jXx61uCZ9ZQNHIvPgUxAPQla8mmFbT42qPZe5fO72JYJBSunXCJLZKfgzDnYGvvIDS8SVB7sjM99M9UvC62ZNLIZDoqVNIa7jX0X+btBvryzcTpmZpxWhO87La7iDo1pK/w3X6fxzyMm++9N/sdocgjwue2Swn6bJsDfFPHjCkwt7xH273mrqb6f/5VsNZx59EUioe8e/RpRMMlsCkNIeSf8qldZZ5GaZyRbD1N52yc/Qz2Z7GHVekbnXQ8zX5OV1CyH80WQ1mNT+BgNqfqP6Yo6ztDKBHhxV/Nexpi5a0tIs/71dJiFA6mKaMM8mJdzTD6u2+KK2FwuJmvsiqmfK0xg/k+NAhiVxzmFbm+1PNqkm0zr/qH1HdUNDIzc2du7d10VlGjxBtjjumR+/4GI4PDEo5vr1yd3Mro30tkt5qTOSZbqQIEODBeyfZPpc9afmLIFppkEsCMxTkUAEzcAEK7wa1DwSMjRKMaFgFYAXsAlTxYvnqmAfnKaZTiX+iYjw+dDQ3coSJzXA29gkHaJuWyPCafHXITA+ldreSKx/RXCjyKSLmIJXcXUanE+NDAAZPSDcgst8DJy9YqNRNqg8N/vnuPBFty29Kw+W7hvUzJ54RQHN7nJBul6W3yeh/1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?38M045LJkNVJuNYsRhJTOmNf2L2e6zPyhjEbRFBvbdwd4wuBc3sDjXy32+sm?=
 =?us-ascii?Q?leGlsRvTUU+0tDUXUjetWwN+4q3FQAOQUJhvm850KAomgJ5omfqFSatuLis+?=
 =?us-ascii?Q?CGkAh3UgAJc/tk7Om/34xfVRRT5IB4SDbZ7sVyEJgNj6B4jZNiG3Miws6KmH?=
 =?us-ascii?Q?cRo7kOdx04oITU0Co7RZBlNEBliDQGRZ8aQalbZsHmVgPtzr7fKmamq9TzYX?=
 =?us-ascii?Q?U7wAah6WuXpRDboxOHb7gBw41hbE7zvHXB8nibHZl4RH/nm9D573hNK5yHT0?=
 =?us-ascii?Q?nj/fmE0zr8bfRBfnaqtAUal5mVlEp1+OQFccPRxmIUAZb1JAtG+2gjcXnT/y?=
 =?us-ascii?Q?l/J5pAzrKkV+oOP4nk+Lqn34/dgdyLqbW8YWQUh72Y0uBXPRbfwviocdpxSr?=
 =?us-ascii?Q?UONISkrQTNfZ3fKdvEj2U1VZ+To247vy7BgNUR4hPiMG7GCLoBPrkzDa3vD0?=
 =?us-ascii?Q?KXy+LD+lthexQy5cXL9DE9ESOSIDLEzCukS2p5rShwlyJGRfpFx7EhoGgzhm?=
 =?us-ascii?Q?ovwPVnV87+r9rSRXExhHzvg3kQAbky03q5eci2ErAZDC8+0ZXFsR3roZFc4m?=
 =?us-ascii?Q?b+MbPc13itSWXzHuTE9kNeDD8euXMzNX8LmIcwNyINPbEkx+6V9SJSdN24Ni?=
 =?us-ascii?Q?RKHqYweFRawBArTxYowBpK6+eRjHlpH8TY9BTsnswwG/9tOrxpr5bZ6ffbMz?=
 =?us-ascii?Q?lxayl+HShNY4b9ae0h9x1KeFDuetBLUpehWeoGKbd128cPsRLSv2aHEkqQRA?=
 =?us-ascii?Q?MBb1YaCInQRJyNeW0zENDB776RoiN2rf40+nqu3QCmCuXLZ99WUYVh1WZG+H?=
 =?us-ascii?Q?8K3MHlSgOtGHrRXaHei7MbOJd+BDntA4ivwOfwxzd+IgqomX+6NrpIw6sBhx?=
 =?us-ascii?Q?X1R4T2Hecs5wZan4uBzWXeb8/b5gvlTs1o/h4MxiniGxLhHPPT3hvsp52+PX?=
 =?us-ascii?Q?Y3bMfvq9pIfJn9hXvEUa/YGltGacTRUSh6gYeQm80tg3mRQ+uF0aIgOUy79y?=
 =?us-ascii?Q?qiDMEsokM8qCt1ZeIe/CWItiGv3NYdaJVGlUBk8/2kVYCLf3DDmfCEMXDOXM?=
 =?us-ascii?Q?Y3gvpaZaNMh3kL8RS2x65lfl8/jA3pic3dR9JhbMLpEhmmfItlc5uMk6z+cy?=
 =?us-ascii?Q?85JSlmPeuGN4RUb5j/y6angry24W0fEdZ6X8oA+wLNimnVyqbVLumIp3Qdrs?=
 =?us-ascii?Q?a7aAFYwpku9Ow7yPHg2bBjIXCFrgel3WJ63uxQKk4qxkHbqaQ2VrLZ0sJv7S?=
 =?us-ascii?Q?h/oCFEmEPWC8EZpCTkV1PYCBcVF4CRU1jUmmw6ycIevlwbCA5Y5Ro1blRQ8G?=
 =?us-ascii?Q?qc/IZaQ/9BMqtIbqMnxqMYHVoZAq3y/YnjneN+lCJGGEIKLfmBpM45UQW7tO?=
 =?us-ascii?Q?GGzOunHeY4IHHgvkI69LLWZ+xqXUShCR7M8VP2ho1zKohGLEzLCiGVolx7PU?=
 =?us-ascii?Q?HPW7CMMyvOqDPjHgqNTuFmRuwdPH3ipH28Z/C5UOxU3WmFv/q54j5A87K9aE?=
 =?us-ascii?Q?njlRBB56frgxOVfd8k2QKrnUsalWJXOyG5XcNxgOmaX5EyHdkGiP5C65QZ+z?=
 =?us-ascii?Q?V+1noONXICKY/vPVa+4f2oIhpZTQjHR/OMur99yHsrjINPT7tZG0M1T2UPEv?=
 =?us-ascii?Q?VXkE6lnhKA9j4GB1riCOm7TnLf2KCTFj8t2h71g1LTQjfk+7tP7dMizCMAUp?=
 =?us-ascii?Q?rki/UYITf+j5S9hi3y5+GZs92jrOtRhOB9++PUWSucVPR1Mf71+S5+bO9TRg?=
 =?us-ascii?Q?A1srwx/CSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cADKq0IclmAEms49tofPVUEbnicAJE4TmetM7Arjpdk/G0xMexLoEsDmbD4Jhh5pv+8AOxQ+eopb/rdktWeR4/qEsky8q6yGeGXemm2bPPpYZXVwsgQG7BQQnukT3zDPBk6Sa12wPza3AIMgfrwqeR3IwhhsqSCL8oiPYUNc5SrmxbGVIsXZjtLlBeBt8XJ1HP0IqRBHYDsiTJL2dP2s4Aa9rxZgTuNrQq47D2rBHr9Zqsu3PamIXTRn/u2oj5Wj/+BMKNTr3CL2aLG/RrPsJf7+E459WaoM5JKx88f67VbJMNl1w1DPO+F5XGMgNq4T8R3ad1rtRzLezH9SD3T5Gw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eb2584-a6a9-4c33-fb55-08de86578569
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 08:05:59.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJhZxv/6sfkqVBIpPIQhkpIhw9vvq75mYaknFng/9O5dkHSR0qyWWSvsyywn0khQg+zjrGfh5LXTX1n3fmDnFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4959
X-OriginatorOrg: intel.com

> From: Rosen Penev <rosenp@gmail.com>
> Sent: Friday, March 20, 2026 4:15 AM
> To: linux-edac@vger.kernel.org
> Cc: Borislav Petkov <bp@alien8.de>; Luck, Tony <tony.luck@intel.com>; Kee=
s
> Cook <kees@kernel.org>; Gustavo A. R. Silva <gustavoars@kernel.org>; open
> list <linux-kernel@vger.kernel.org>; open list:KERNEL HARDENING (not
> covered by other areas):Keyword:\b__counted_by(_le|_be)?\b <linux-
> hardening@vger.kernel.org>
> Subject: [PATCHv2] EDAC/mc: Use kzalloc_flex()
>=20
> Convert struct mem_ctl_info to use flex array and use the new flex array
> helpers to simplify initialization.
>=20
> Add __counted_by for extra runtime analysis when requested.
>=20
> Move counting assignment immediately after allocation as required by
> __counted_by.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

LGTM,=20

  Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Thanks!
-Qiuxu
