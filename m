Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FB171E4A;
	Tue, 11 Jun 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718089035; cv=fail; b=EnV31bUPMpKzbvVV7TiYcpBbdU+5GYYC++TM8DC4+AJ2EQWjzGKP0++4GiKd4Nbwco2l9x3zaDo3segMbbS/TsZ56FidFIpMAkgCDh/uzT2gmCOWq0KKVWCDxspc8hao2Ea81B/pe334fl8Xd+wo5ZMtpkMkF8xSZWt71dsh27o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718089035; c=relaxed/simple;
	bh=lO8ojCEFJK6EfE49m5SWi8qofLTWxHtAYjlaiGSSWn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GyzO2Lt0ek7grYoXnrQJG/7qmjaiLMebd9wG4QVJSUuz4qBBuvRLSbN5SoE7mdr5lRbFfsXiinmxNWxZIxPwQyg8L+dOtGTyfi/fVJE+6AJ5fIoqKvdi9J4dJNbsBz6O7JrRTXD1e0l7oak+pYSxhBYCbl3oMVE3+m9hvWadoDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTbP4a+S; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTbP4a+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718089034; x=1749625034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lO8ojCEFJK6EfE49m5SWi8qofLTWxHtAYjlaiGSSWn4=;
  b=nTbP4a+SDrZhtEWojQ7P35kRP9ZhO0Pmdz42Y28CIQ1DbDzndNtSxUQ0
   5/ZKjTTfq7hmt4ew2iC7CQIhv6UkhpJvP9CXEawjZyQcYg3ZxIP3I0vX5
   InF4X6YfQUu+3vpOMxqAh1eBJdgHYHarWuzCzEoU6ny8vsS1oiPy1Uy0y
   mBTE+iYETbTirfL+/c4EZVzTW93n+XjOi5tAws4BuX1aIBtRwNBZxRJou
   WGLzBuwi0LZjIpWvKwy8o26cCIUTTJnIYB2gTqZb3Ag4m6gkCg4EZip57
   SubbzgqJfaxLo0ugn/ENIBRUavzjB7YkhxBm/5fw4uJu311ihF5xTAdRn
   g==;
X-CSE-ConnectionGUID: VceWclEkTGm70R+5u0Of3Q==
X-CSE-MsgGUID: ljrYf1UpTvmfqHLgRoVpcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14610316"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14610316"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 23:57:13 -0700
X-CSE-ConnectionGUID: +5rUkaeRTaGESaoq/qSiBg==
X-CSE-MsgGUID: Rj18D5GITqq21+eri1PeQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39388049"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 23:57:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 23:57:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 23:57:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 23:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXBmIandqPJ64pRSzYm2XhzmTtKwjh44RyKd+HyfDiHkGrHHqKXDJUd40JwCX3dV1mLOYinLq/O6K2xKvfeWJwxxspRpShlJPooOyLJOTpWZCnH0sj0MH8zw6frh62WZkleue92LNIfdudfzzlmlVu5k0hcLwTug94tf/W407gQP5zAbKjQwLLYJtS7TCdbWGzuN34IG9YgtM85KcKmhKPAEqK0lOB8U/n64q5bPPrcGCI6acssgdKQVeT+A3JxjgKdvgOR8Pbn7pJ0kndXAX8qwGgVYyvNn5vzg/jQOml4YY7KokEvFpGGuitDyMpWzMkbLU00pxghErFzRCVn6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX4/FlaMIV6Dz/oGC7L4gEEonjIfZjK7GSOMVPP/eVA=;
 b=oLAnrzN3HAjRUxsDvtqBCLr5EF8dQQoZDXjVeJwi4V5AvsFFxdiUj7gDyT0U149V+Ryw2NmhKmcPlgE8zm0ZCfFjo0gPkFpc5ycu9Lp4vRDz8lffHJNFOdC7Q01+mqaJpzHtdTTOjxk2V4XIpezjAyNC+LMk2QLl29PKb+A9SJ0aZmJzSE1ycKF10FSbKY1U+Zy0D4tMytxRgbODkr6JzmukQotWcANHxQJS8guAbdgrBPdaX4C1NJNapN0Nq1P0L0HqBSqgGwlSaeGZ3mwJQp/qjBd0RmMzoTWZc0n+oe9+nlhATTNM1Zrp9lhh1zgny7kRPrObOapVLVhioZnUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW3PR11MB4633.namprd11.prod.outlook.com (2603:10b6:303:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 06:57:04 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 06:57:04 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC: David Gow <davidgow@google.com>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Sean
 Christopherson" <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Nadav Amit <nadav.amit@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>, Christian Brauner
	<brauner@kernel.org>, David Howells <dhowells@redhat.com>, Uros Bizjak
	<ubizjak@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] x86/uaccess: Fix missed zeroing of ia32 u64 get_user()
 range checking
Thread-Topic: [PATCH] x86/uaccess: Fix missed zeroing of ia32 u64 get_user()
 range checking
Thread-Index: AQHau3mO4jAkhXdPBUmV7VcXJhmY/LHCHgQw
Date: Tue, 11 Jun 2024 06:57:04 +0000
Message-ID: <CY8PR11MB71349DFC7229D5208824CAFB89C72@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240610210213.work.143-kees@kernel.org>
In-Reply-To: <20240610210213.work.143-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW3PR11MB4633:EE_
x-ms-office365-filtering-correlation-id: 0261d8aa-559d-4142-7b49-08dc89e3b3ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?NsDIJcJze8do7WjYYeCWa4FdyDGGyi6RdDvVi1I5Bjfq7uJi2T48vsG4le5Q?=
 =?us-ascii?Q?zWMy8whn8Y/qcuqWsgxnlrNzpPdsyxcM9DqB6geeOaUozS/LGA1a2QIeQ7N3?=
 =?us-ascii?Q?4re8aYpNXfenydD71VtO2tM4ATbQt+XuOSOTN2pkeyJyDD2RJSCilBvlINJp?=
 =?us-ascii?Q?klOSTrt7a+MHE7oNOtNEPJCbOlEr6w58CvfwolUc6dyKIQRllHGH/4Jqiuz2?=
 =?us-ascii?Q?9fBurasMoLi95FFxZHm6FAVala4ydN3jCH/elHCj0rji2rGopFY4X3tNifSf?=
 =?us-ascii?Q?KZBx9XhQQWdCqQdfQwY+PayMOuAhUQKq298FCBNpme4Z1TUKC8GstOrweGcI?=
 =?us-ascii?Q?PhbC50QFvDn2qYQLXUH/sd9X2ewLVMZuktwtLevFNzeqG0+1CKa2ql+l8SeI?=
 =?us-ascii?Q?l8DM74GO2VXfg3c6xOHc0DLZhHsTAz1FqA79XtQFhJwC1fcqQz8dbx0UHb0C?=
 =?us-ascii?Q?ZuS71UKlBgev3snfMq0QqySYHZJgREGv6JejOxfkYKnUoN4dw/50v5l7fuA6?=
 =?us-ascii?Q?rS/0xHnIn63AIm25bvzE5y2A1pZqjJyCOlilH2FvHjKudcpE8eL0NorneH02?=
 =?us-ascii?Q?aSRmASKF01Gp0p41uORX039a+Mw3CuF/P03nxBI1SFzwSooPHaIzVCmPoidi?=
 =?us-ascii?Q?LznBycbnw/xj/z9ovtfkhdhEXYCvAGS4fA/yLj9yeaUTcKlfJr74zWJhRV/d?=
 =?us-ascii?Q?Llq754BZ4bwmEW/f3rHljeC6wuZ1CsnvIqhHbvxmyPGww8hwE7NQcdYVwf4s?=
 =?us-ascii?Q?Y3eCLZlhTgDiRrgpPO1DYEsiNxuODAwoGUnYMsB/GTp2k1knFWr6tlpFv7q1?=
 =?us-ascii?Q?Ca2SUZ9WnXAYGQbPEn3m9zlyokYuDKrV3Bbh10+4eZrQVmxn+n/OGb1S1yB5?=
 =?us-ascii?Q?LohjRu7/ojAfzgldLnCTi+/bISy93OrAdhXic3cq2eDTdwe/umkHFtPHzNEe?=
 =?us-ascii?Q?vPOGk/MqwcinOL3dizORzHSYmuSyCAuTRpT1+IPn4s4n/y6diC2QEpNmnVDs?=
 =?us-ascii?Q?pS7yW9689uz2dTHY1yPZGtWoCbRM7q6wV/0mH+DqgU1E1WlESApnRUtUO5af?=
 =?us-ascii?Q?2Fx6zJ5l95xFY0ggqkb6Us4v/Pr0kibS/WxlJqS0DLzPDOfXQ9BJrnmaTvU0?=
 =?us-ascii?Q?8mCOUdjHbca6nU1vp0k0xBZZk+g3I8l5psWbfqNgqxcoOublzFBV21s2jF3/?=
 =?us-ascii?Q?0yEnfurpQtTukyxM78kd7gm+fxzaS/I4IL4Vlw6JyuMSaaXXCnZE+TuUyYL1?=
 =?us-ascii?Q?vhOaxdCSUw2mcfCUb+f1Ne0OywELPJMTxBckN7g3vI/oJzNXkPulm7jmI07L?=
 =?us-ascii?Q?zhVbnpdTpUMomnkHyY54RI4XVAcZTn7+gmke7QLX2xLFUx2HLJXpivnUmafB?=
 =?us-ascii?Q?wHSlVfQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KuM6eBV1Kfg/G03gRNcWP5AMFNGGzyFQsNkY7Mm5UkOFCjqt+ZQAWnVoq0xC?=
 =?us-ascii?Q?fiu7tWC/LwInTBV6WIU+zWx/K7U4kY9h7y+8C6MoRTHHSxXt8XmoJdNy59HZ?=
 =?us-ascii?Q?qbwIOzHawasTFnWBqyM6YELQvEMDiISIh9hEMUCZQ/kHPRgaIDCSwnDQRCtU?=
 =?us-ascii?Q?WNyNjtFYKumzMoFf/H3oL+5H+F/T8xAZUKzpT/TJmFvwrIs4WsGKjAIhN02P?=
 =?us-ascii?Q?FcHiPb7HykJZDlP896CAa/HtlApMxjOY61/xa8ftch0UqodJKeC17LigSrqc?=
 =?us-ascii?Q?umLrOfb7jTC+D8Q3wwCf0/m/YxlX8aHusLhaCK3IVQj1WukASLT+Ja66ITCB?=
 =?us-ascii?Q?cM2+dy4tdt/Hgxjw7HhOtp8/pa1EtQ/JPDx5Srpt6lGkgvQpHP5vaQhvCdnM?=
 =?us-ascii?Q?ecQuPCAiYrhyS2IVE9qpMth4mwv1F6juLW9+EZUYQeWbyk9CufVq4dRpysYp?=
 =?us-ascii?Q?agF+K9vTFUXuhbaYRQZtFDUxQ1tDK8+D6LSYQR1KzimO0HCjt2R1UNMlzwM/?=
 =?us-ascii?Q?QsPcm7rfAt0C3lPixK9BlrTST6lOGfZx5JGNfQs25nRMqzZWQ55zuT4eom2H?=
 =?us-ascii?Q?b3OEmuryFcF7QgnYYdHPfHlYgl/ek6dWYTwNYTgJP0cWjTCaPVLK5Ei6y8ea?=
 =?us-ascii?Q?P6mvamu3C2xqdxs2gIA4NzRFeD/2lENGUcgRCh1nfyVIkDZK8HOix7jKhGPO?=
 =?us-ascii?Q?JtLqbt10bjIBc4ED6iN2m3DiFhMWEvqOVkat6E5FVn/AhdqLgMTMhzoZM/SV?=
 =?us-ascii?Q?vlqhYgNNp1M7jnCsC++2ACH1NbKQiM6FryoraZhx2mOaLSf25V9J9t4IitmB?=
 =?us-ascii?Q?hGhOrt7/IjPDGfIKbm5WnZKPGgCQEwh9EbDAZ2Y7EnqXg4OnR0wMYjZobHmf?=
 =?us-ascii?Q?mvVOudYdPyNs/fiH+qfzwYOJpRGjHMf47lJxp/rSDGGBxucqCidS5V28uymW?=
 =?us-ascii?Q?Qc9KUbPKxtz6b+oiZK+n3pSqy275IC86sj5dYxcF1uDRhTPUeQne4ALPrZVp?=
 =?us-ascii?Q?WbZYZi+DNb1RVia0mp68T2NfR3/hrVxsxN9PL6oyAkVFIaA+Vh9uaxOA1SUp?=
 =?us-ascii?Q?JiLzuPxFvXqji/J3MJY8LUcA8isPdqqGSTgINSH5YK7v9rRybtWsymUNKyVO?=
 =?us-ascii?Q?bGgcrPuanE7jYtIw+cES9eMc1BKlJdqyXg8tzOEGkcEIdHCFT7tI7HkXJKBh?=
 =?us-ascii?Q?wNyEHhuck72xRAEhROR7NkR2Ay99pxg5uubl5PtOesHCNx9tN9hbFZ51znSw?=
 =?us-ascii?Q?rmqEhILg6f1XnW538ndpZ1FQv6WS8WeQIghK0sYKGFTjAOSGdKLN60uCvfgN?=
 =?us-ascii?Q?EmPZIxdUxxOVii+YsumzjMYaqhhND6pebq2ZrSCc+wRBSaPJGBksSpgyoHR8?=
 =?us-ascii?Q?NY+03gV5hAZau5yf2yLm4Xnal6YHSO21qr1LMHo3A2qmkg24wYaLlUgo1tqm?=
 =?us-ascii?Q?id5hHYldw4rq6xdIkG7327CGh189Xr8HtTOZH9G9bmn4nlJo4W63elHX+Nsi?=
 =?us-ascii?Q?HtKcNtZ+RA/NoFQffV+8EttawiLDnC3oAQzEOGEnfOv9QCtPImVM9lAfKG3v?=
 =?us-ascii?Q?sGlM29VfRjuxWD7qTkRQwD+X+CGHdhpgKO/80IXV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0261d8aa-559d-4142-7b49-08dc89e3b3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 06:57:04.4650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQhmMbYqUyMikyN4d3/egoylITLzVWX4s//m+f5SQeLJG5NFAgSRf4skEboGhCM63VcdncvzN2sCnavEFgokMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4633
X-OriginatorOrg: intel.com

> From: Kees Cook <kees@kernel.org>
> [...]
> Subject: [PATCH] x86/uaccess: Fix missed zeroing of ia32 u64 get_user() r=
ange
> checking
>=20
> When reworking the range checking for get_user(), the get_user_8() case o=
n
> 32-bit wasn't zeroing the high register. (The jump to bad_get_user_8 was
> accidentally dropped.) Restore the correct error handling destination (an=
d
> rename the jump to using the expected ".L" prefix).
>=20
> While here, switch to using a named argument ("size") for the call templa=
te
> ("%c4" to "%c[size]") as already used in the other call templates in this=
 file.
>=20
> Found after moving the usercopy selftests to KUnit:
>=20
>       # usercopy_test_invalid: EXPECTATION FAILED at
>       lib/usercopy_kunit.c:278
>       Expected val_u64 =3D=3D 0, but
>           val_u64 =3D=3D -60129542144 (0xfffffff200000000)
>=20
> Reported-by: David Gow <davidgow@google.com>
> Closes: https://lore.kernel.org/all/CABVgOSn=3Dtb=3DLj9SxHuT4_9MTjjKVxsq-
> ikdXC4kGHO4CfKVmGQ@mail.gmail.com
> Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user()
> and put_user()")
> Signed-off-by: Kees Cook <kees@kernel.org>
> [...]
>  arch/x86/include/asm/uaccess.h | 4 ++--
>  arch/x86/lib/getuser.S         | 6 +++++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/uaccess.h
> b/arch/x86/include/asm/uaccess.h index 0f9bab92a43d..3a7755c1a441
> 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -78,10 +78,10 @@ extern int __get_user_bad(void);
>  	int __ret_gu;							\
>  	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
>  	__chk_user_ptr(ptr);						\
> -	asm volatile("call __" #fn "_%c4"				\
> +	asm volatile("call __" #fn "_%c[size]"				\
>  		     : "=3Da" (__ret_gu), "=3Dr" (__val_gu),		\
>  			ASM_CALL_CONSTRAINT
> 	\
> -		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
> +		     : "0" (ptr), [size] "i" (sizeof(*(ptr))));		\
>  	instrument_get_user(__val_gu);
> 	\
>  	(x) =3D (__force __typeof__(*(ptr))) __val_gu;			\
>  	__builtin_expect(__ret_gu, 0);					\
> diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S index
> 10d5ed8b5990..a1cb3a4e6742 100644
> --- a/arch/x86/lib/getuser.S
> +++ b/arch/x86/lib/getuser.S
> @@ -44,7 +44,11 @@
>  	or %rdx, %rax
>  .else
>  	cmp $TASK_SIZE_MAX-\size+1, %eax
> +.if \size !=3D 8
>  	jae .Lbad_get_user
> +.else
> +	jae .Lbad_get_user_8
> +.endif
>  	sbb %edx, %edx		/* array_index_mask_nospec() */
>  	and %edx, %eax
>  .endif
> @@ -154,7 +158,7 @@ SYM_CODE_END(__get_user_handle_exception)
>  #ifdef CONFIG_X86_32
>  SYM_CODE_START_LOCAL(__get_user_8_handle_exception)
>  	ASM_CLAC
> -bad_get_user_8:
> +.Lbad_get_user_8:
>  	xor %edx,%edx
>  	xor %ecx,%ecx
>  	mov $(-EFAULT),%_ASM_AX
> --
> 2.34.1

LGTM. Thanks!

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
