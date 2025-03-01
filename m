Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012052.outbound.protection.outlook.com [52.103.2.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADED442C;
	Sat,  1 Mar 2025 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740807989; cv=fail; b=VDUYLvZ09guJ93nRnP7+A4NPncjpQoZgvCayYXFlJpuEOeJcp8fG/55sUnP8BQQaa9MOg0R2JUIsClLfTzLZh9IUpaH19RH2/cMeXwLvndrO4t9z+5eBfVyTM/nH6LQkE3f4DN4Ul9OtGmRVhKKkfHlL49Om66jqcs/eobD7bpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740807989; c=relaxed/simple;
	bh=GprdDI0JpLtU9w9tcOavjIZ9FMNk+Us+Nj6A0CiPh18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DArO/ZdzEeHaE/XrUGPcnktfNCgJiTJWbGs+NKUqC6kbNYopXF+ZhI5CcRkPJL3aM26bd6V0G+9tDUtydPcZgHpaLxkcYQgYCdCy+FFT1/TB+4vW9xF+es1ZxcOYOozl0UtZBimomVIUCbsYeEz2W3wgdHohiESYXR0zO3GaQEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jKWpntrT; arc=fail smtp.client-ip=52.103.2.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jKWpntrT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiSaeC8NyXlWQaz6mg+NQcKv621xbjdYkxXSjDRoUxTB0L0n2zvenE2Dijc1Q+vDFGTu10a2/0vZ8oGIpWWgnlLw5Ot+jhLbVGSRDPQ8ZaLyGsWSXIahetTdxJGKYpNwPW7gCZxvp+it5APvfeEGTfi7LkrD72ZB1Ms2jBjUGEvSf3YiQOzYmj9TOui1P+A6tGvJYlQVzDD0KIMu3Y5mKJ902zqA9YUdn7Un2uoxYZyJO2ikqep8lOcu1UkRI6whUFcmX8nQgH9WpOOA73OTamWHIP5J2haYNgc3zuyP87aRFJlNwGPCGgBzxGJJ+F4lpDqF8Kfrwn6LXZehGqRRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzkC/VSwnAbaZMd/I/KyQQo8/TysW9c9NAVwe+g8oKc=;
 b=vfZN5v0vRqR9o5XuVZATxzZYQrtrakxgXCMz8vO34Oh/UZIq2L0ZftvUHuONfDTBvwH2pYSt/s7KWh68Msv4JrsjXJdNeT6HcytVHuKG75c2/kvZREPON27L2HuoHcREfExh2FTw17TaqNuaUjKjsfeTgjSXWNmgvJeuIoccVQg01qljKWA5KK87BmtCbBJ/0T5zhWOgd3LzP4xLcJF3t8ucrTlkXoJzYInwXngrlFnlifKRjUn9aKGVu3QCFWRWDdU+FgT+2ZJ2CIDB1FeW8HvOtW9fbTM7FrSu4z4PgO3YOQbaqVIuaqt9YdS0RdC8YXAE6SfHbQPTlAN5diGDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzkC/VSwnAbaZMd/I/KyQQo8/TysW9c9NAVwe+g8oKc=;
 b=jKWpntrT/hrfbKNHgv2FzrvDlbc3OZMhIuSeUawNt1TfKGfvmd/sLSnJNT98pBwqaOYLCzk/FAWqnHo+tJLofYG75c4dafGZWYsa5Um5mHBMGTSIDk+JUcDusjp/ijIE0ULNXurOBpG2jki4KC1DJzVVGYYcZwAKNSwLcRXUtuk3ZfqKAoO7rHQgcSb6HlmhMBuAKXiJWjRm3aDsWj/nQDoNwH30v9oRWpjbzRqNGdXM02LMMpEJToEZ2dhHRMgONd/G3YohI4zAVuXM/e6hSpLu2O2D+E84UaVLT1kkPGLf1Ur3QP3JecpkHGM+zDnzqrq+2rBPJ+kMFGYlZycJNQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10037.namprd02.prod.outlook.com (2603:10b6:510:2f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Sat, 1 Mar
 2025 05:46:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8466.020; Sat, 1 Mar 2025
 05:46:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kees Cook <kees@kernel.org>, Venkat Rao Bagalkote
	<venkat88@linux.vnet.ibm.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Luc Van Oostenryck
	<luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Marco Elver
	<elver@google.com>, Alexander Potapenko <glider@google.com>, Tony Ambardar
	<tony.ambardar@gmail.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2] compiler.h: Introduce __must_be_noncstr()
Thread-Topic: [PATCH v2] compiler.h: Introduce __must_be_noncstr()
Thread-Index: AQHbiggOdBfdZVuP5UCg069MGJGJH7NdxdEw
Date: Sat, 1 Mar 2025 05:46:24 +0000
Message-ID:
 <SN6PR02MB4157CA61D04CD12D7CED5E1DD4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250228174130.it.875-kees@kernel.org>
In-Reply-To: <20250228174130.it.875-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10037:EE_
x-ms-office365-filtering-correlation-id: 5b38f8d4-26ba-4484-131d-08dd58846716
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799006|8062599003|461199028|10035399004|3412199025|440099028|4302099013|41001999003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lGMpLXEtZw6unRg/fuE+BXZgPk4sumOYdijGSrv3Q+AeiN28Oa1DgHMAbVgQ?=
 =?us-ascii?Q?cNFIAoSMDPAptZKsFPIMOVJKY3CyVkyOw1Mi4iUYYcdr/MdxyYUTmCvCha4F?=
 =?us-ascii?Q?uC1oen2lXkasS82JLE/ZCI10qYVem/bi6IR8VfFl5U1kp2YzKM58wuR+sIgR?=
 =?us-ascii?Q?f38uVEq4z4eM6oSu7vfi4/GhKNI6y4NYP6a3FQr6aDg95AmDiUV2v9qteJKG?=
 =?us-ascii?Q?tZcIAtQLTkeAUX2U5aLvOVrbdnno86K+Hx9TxqOVtAt+5I+mAOrfrRGPqJJx?=
 =?us-ascii?Q?zxMCKeiGeVhr5AaeKkBM02/hIlVzDDVLBqDvMIOp0LK24m4OWtnshrN9Vmiq?=
 =?us-ascii?Q?9o9u4up9+/3640wTD1T7eCNt+AQFZgOGPnep71ZzFXS5KXX2fo6PyP3EHZ6K?=
 =?us-ascii?Q?swTei0y5B8Zzmu1VlM6zwGgzwyDs8uQXR0H5q3BqOPgTCOaX9FWoWO8lHb6b?=
 =?us-ascii?Q?5+5N286OW3BOqWOCkd4ztBlw/74rvTs/we+M/ECAWa+nRYtlpdGadfHf/z2O?=
 =?us-ascii?Q?MpzvV2jsBDGakENlOjh2e/81DB1ZnqdcprNXoO9WIGLLHwvfSjqMyknzGBAk?=
 =?us-ascii?Q?B7WVbitg5nNJLMTsPR7yLJanYPaWl//9myTFJTynE0h2yhvft9OHKPU9/EQH?=
 =?us-ascii?Q?VtgkOacY1xl0HunoBj0wujYk2i1+BtzZosPFqBIZ3vDY5gwKluIXp6mR/c2w?=
 =?us-ascii?Q?KWdXaMSNe0js0SqyvBSv1vttp2Q4YqvN2nh43uWXm60/e1MJrMs1GG8OOEqp?=
 =?us-ascii?Q?4A48FmqqaK83PBq5IDUQ4v/BbsefafU9zj/mvx5xKIGjwjWKLw2/SAIgaNbY?=
 =?us-ascii?Q?pZL4uy1V5/dlpri1iKnSpNsR/DCdydyfOIJ14GAINcb1jwYs1qhsqJPV5IrL?=
 =?us-ascii?Q?5RAKrzNVgDANrLSH9RBvedLRhMQmZpGz0dORpaVSrbDHETkbweffBvSLLT0e?=
 =?us-ascii?Q?k+HriVO+4kcafQK3Azht8v2egcDlPOCQ3LxbQc/qaq1BORDFlbxqHxsKtpum?=
 =?us-ascii?Q?I2zLxR4yHroOu9yM1HEnnRAuL70CBUR5TzmgHzWBfs3mfN05hFAEysPqaQx6?=
 =?us-ascii?Q?IA8PcxgmYFqxcD7hLi9KQsqUiB8bV/oMIdSR23I8lSDUz9hKhz+XLlLjN6gV?=
 =?us-ascii?Q?Fb+aAMizqofEv+OakDVbgKIqY2OcAp0ta5sQbLqGS8qpcWvYni7CXvADKgtG?=
 =?us-ascii?Q?R6jR1UOvjfAmMBKuURAo68nT1a9rInIZGGnWCs+kEarsc+FZ8BTWED8j11ms?=
 =?us-ascii?Q?v24wS8KJ/HC8uzkzn+6x?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B3SbnrBZjpE+QuCYi4Ycu5W4jXaSeavsPZySn8rsSF79FhSlzU2GuA4a6KVO?=
 =?us-ascii?Q?Mf8AEAMKOKAwrqHZrJFDomzsr4jll4zTHCZ33uGDA6LsGrzUHUO1Us176qrs?=
 =?us-ascii?Q?7/wjHEUpdx0NdwWMGns3E/xJa0wZhlCUdVZ2fIOuLhZB9a9AyWG2W80cSxsP?=
 =?us-ascii?Q?O2xMwk0Oq04qi7r+eEspFBN4lNaBfO1foQbR3lQpQDt6HH5U9dyuohGcWy1Q?=
 =?us-ascii?Q?m+67UW7jHMGt0jVR9jP3pnv4a3CRemtT1D62j2zigRlJ16sghQ30l9qWP6+c?=
 =?us-ascii?Q?laF9+mfnzlekaMLyROKmE7yjfXv39ONUhDrNnUAw5sEHyzzkUwmNzyeSyBhE?=
 =?us-ascii?Q?vdIdD6EvOaEDFc/UCJEtyqMEa43hEO8qHcALmIHZAaOWIHcCss4Cus4IPBsz?=
 =?us-ascii?Q?nPBUOctlNcVofZMgo2WmHiR3kyO/N+AFjjETLnztl8cZoLkkX2zRCXAb3oWq?=
 =?us-ascii?Q?fyweu1tgektwkkFdInuSr3R06+7goF8O000tiQx7upEDw//AS/nsAYQ8h6bN?=
 =?us-ascii?Q?8VLmPBPnEFa6u8PkbrolnmBsO+2ywe2XyqU0awJq+LRyVgk4eariejOnlYx1?=
 =?us-ascii?Q?0aHhaBrTLBEzNX9S/y32jt1Gq0Kl6aGxCZ3VFijjFf4q+4s+l7CzdkIAFeoh?=
 =?us-ascii?Q?3vCE0oDs9kGnOZLULGIPsBGtryybwPcf80LaZZgwk26jyOo35GtEWQ+u+LJz?=
 =?us-ascii?Q?r2h/v2MtCiuDatuoIpfoXUAfEoZg/R4uF6Z5I+notTcbUP4IozzBnWvjor4W?=
 =?us-ascii?Q?1fj58G4YmudLAi5TGUEcAHRoT4LeJ/LqaMuHRJfbUmkgw8wZkacHiU59OsCh?=
 =?us-ascii?Q?Q8KfKgsSVl1KjWwR2xDqYxsJ9Hfbx91cQ4eYJNDplWzA9hlCU/cVOLj6rW1A?=
 =?us-ascii?Q?yOJXZ7witQdweDHnwwfB+kS8VzdzRYvmkTG/vJHW6BVnUWZnI4qfeTae2QRx?=
 =?us-ascii?Q?jmvIQpkoUOkvVpv418SUUzpLq+KdeVovdg6LOpUPzarSXRFU4Zh05EAj7ovj?=
 =?us-ascii?Q?24XYkOy6At3m0UAy6s7jnFdD1wy3I0CPPlQEr1VduZ1FYRJLC35JirggVjoE?=
 =?us-ascii?Q?tajcolbimkO6sCBJ1kAW+f7mpmK+t3RQy3WdIkzZJnIkMDzZBTmFiqqCKVQI?=
 =?us-ascii?Q?HvRnh6GgrW7ItUnULbMOLUVwHw/MjUiA4Q98woXbw58o3Bpl8qOQtgEUND98?=
 =?us-ascii?Q?wzjkUBdpoPqfymDmkgWHab0Ga6UfcydvYUWQCBZ7dvQBxPDpSkINrEOboz8?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b38f8d4-26ba-4484-131d-08dd58846716
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2025 05:46:24.4509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10037

From: Kees Cook <kees@kernel.org> Sent: Friday, February 28, 2025 9:42 AM
>=20
> In preparation for adding more type checking to the memtostr/strtomem*()
> helpers, introduce the ability to check for the "nonstring" attribute.
> This is the reverse of what was added to strscpy*() in commit 559048d156f=
f
> ("string: Check for "nonstring" attribute on strscpy() arguments").
>=20
> Note that __annotated() must be explicitly tested for, as GCC added
> __builtin_has_attribute() after it added the "nonstring" attribute. Do
> so here to avoid the !__annotated() test triggering build failures
> when __builtin_has_attribute() was missing but __nonstring was defined.
> (I've opted to squash this fix into this patch so we don't end up with
> a possible bisection target that would leave the kernel unbuildable.)
>=20
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Closes: https://lore.kernel.org/all/adbe8dd1-a725-4811-ae7e-76fe770cf096@=
linux.vnet.ibm.com/=20
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/compiler.h       | 18 +++++++++++++++++-
>  include/linux/compiler_types.h |  9 ++++++---
>  2 files changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 200fd3c5bc70..d5201464c5e6 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -206,9 +206,25 @@ void ftrace_likely_update(struct ftrace_likely_data =
*f, int val,
>  #define __must_be_byte_array(a)
> 	__BUILD_BUG_ON_ZERO_MSG(!__is_byte_array(a), \
>  							"must be byte array")
>=20
> +/*
> + * If the "nonstring" attribute isn't available, we have to return true
> + * so the __must_*() checks pass when "nonstring" isn't supported.
> + */
> +#if __has_attribute(__nonstring__) && defined(__annotated)
> +#define __is_cstr(a)		(!__annotated(a, nonstring))
> +#define __is_noncstr(a)		(__annotated(a, nonstring))
> +#else
> +#define __is_cstr(a)		(true)
> +#define __is_noncstr(a)		(true)
> +#endif
> +
>  /* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribut=
e. */
>  #define __must_be_cstr(p) \
> -	__BUILD_BUG_ON_ZERO_MSG(__annotated(p, nonstring), "must be cstr (NUL-
> terminated)")
> +	__BUILD_BUG_ON_ZERO_MSG(!__is_cstr(p), \
> +				"must be C-string (NUL-terminated)")
> +#define __must_be_noncstr(p) \
> +	__BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
> +				"must be non-C-string (not NUL-terminated)")
>=20
>  #endif /* __KERNEL__ */
>=20
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index 981cc3d7e3aa..f59393464ea7 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -446,11 +446,14 @@ struct ftrace_likely_data {
>  #define __member_size(p)	__builtin_object_size(p, 1)
>  #endif
>=20
> -/* Determine if an attribute has been applied to a variable. */
> +/*
> + * Determine if an attribute has been applied to a variable.
> + * Using __annotated needs to check for __annotated being available,
> + * or negative tests may fail when annotation cannot be checked. For
> + * example, see the definition of __is_cstr().
> + */
>  #if __has_builtin(__builtin_has_attribute)
>  #define __annotated(var, attr)	__builtin_has_attribute(var, attr)
> -#else
> -#define __annotated(var, attr)	(false)
>  #endif
>=20
>  /*
> --
> 2.34.1
>=20

Compile tested on x86 with gcc 9.4.0, and it resolves the compile
problem I was originally seeing with linux-next-20250226.

Tested-by: Michael Kelley <mhklinux@outlook.com>
