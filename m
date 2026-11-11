Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794369467;
	b=NNIHtDz5R2nv6n2WVdHb7FXcjVpVUhnasAtgOrQJeqqxR4gJDw2RHjrBRO3dFg8BchH8
	 1M3HKrnNPj5rHWneCDOP4r8Wi9GOAvM6NwDR2qRlkslDjH5OpFufwB/3Q42R/uRI57ddQ
	 T/mTdx7Ana3UlzSJRnXrYgTUFhuMyv3dy9dA+yD1xMWfUozTeR670jvr/2xVQAzuPfNN+
	 TNfsTTQed8pPOhdlguh9UoNc/YT8qouAH/l3JgAB+jZ0LYs0CCPfR2cX/cjcjgBU8fYI6
	 GKO7VhRIDmRv+sDCdwrmthCD524rVpShubGIy2TQXjovuUqQ1tMVt4+G/v6e5F8LW/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369467;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yNAM5UZZ/Q1D+JhHKvPO55BJzC4IZQySNXA9plaDP0A=;
	b=hiU+2SgNcbCqa1xhqiz5vzJfE9kMkb1c//OfMefH1O2di/no/j9cxJVKYYwofsVsPoLK
	 dml76RYfZkvI8ITvemdSrnW+n38RUyuVFTD7NgWQ+jh3NR7Zq1n94hsMa4Mx2Am/mds4I
	 8wIEsDaJvDqYiS/lrgLpUtB9QUNtfg+Ac0ktPKRUS7DCKaof3gn6c7JxQEYeGDMGWqrPl
	 XB4gmguql7M2DTfujEHxIhJqxTWMlLLo0zFfZyejnWzdrl1VoHivZO+FULiWsaCfofVIn
	 AQEDQAb3WueAym8RjOcR+3xlClaoMdD8/eF/WU3XAumCHr2WNNPhhJp5OpCkhZg9PQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KUP9EY1o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.64
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FC606A31C;
	Wed, 11 Nov 2026 03:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D29FC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KUP9EY1o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CG77/cigi42K6TobMaXtsYhnZwaDl72wl/1k7hK2Fg8DmWNuP9mNUtN1kObrVwvq0QPj1iZamqQB0uBysIN035Trup30/+5+IjQ94eMvqlhhBFFOOPKgMnkK15bTZS+Z0wGLMm8sl8iV3NbVy/X+d0aFG/zyXfKpC/uv5nEHDwj+kTR0b2CCHJHZhxJSuFKt7PoljjakmI2jSxhtUr0dxDLUg/eN9JsMtFNWFOAasSv57a2toDo9Euy1h/i9XEy/UVVEHd78ntKd9S1fFXTvJpT6+IjBnApwJanJMU+IjQeVSsaTl8xODaxDtxZ673K/aUv53Ffip+eczKs5AslC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNAM5UZZ/Q1D+JhHKvPO55BJzC4IZQySNXA9plaDP0A=;
 b=HbCvm8U+5NuB0SvFrunWaXZZnQOSB/Hx1OZMfMmQGPZwxi0SGwWIoWZ5cHHcPeQfKjWK78s1B36TowX1IV3MbhzXbouWa6NR0h0SPlOVJwcEQBf5J+gvPl9y568vErftKLzdUuuSMXAp671OshmMYf0yQj5zJOzYOH1JooT5PAVGegj3ELW91Q/vhD8BXjbRCYxQKfgQNpqu/i0mbm+cZeNY9yPN9e/sDo6Wj8RD+gYdyU7raExjnGEacp0MJOUwX8Fmz5OUGCPjAcQHAqHau6kACGZKH9Cd5NtFdHPhUBVmTNskYuYDrYbRgdMxfciGnp2kApqZlrT8jvkgkgGbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNAM5UZZ/Q1D+JhHKvPO55BJzC4IZQySNXA9plaDP0A=;
 b=KUP9EY1o5NDraUwSt2C0Sc0qsXx0sFRD6O2dAJBH8NAHVVmJWD5QtoZUTbTuXzDdVGPCkjU9pjCCvZLxiR8lpVjB55rmryQJOs/WYIelv41RA2BpRg3PjmtbyomYyrq3A6LB+gUsULiOR++HitbvHVctuI5UtSIZHXwovPKFjHEeOo6A7docaqTwFqq+MoxtkaENd/h5oekVp/vwgzbCQm7lAhAql5h73iuA9dtDua/Nw6kq4tzVG8PFtepcsNmBIOVb/KgKiJyWLNhKozxJqReXHbjTo3rxZJjwIhBZgg4FYHqElg1sDvq5YXFFefRRfwL0CbUT+nWH8pZdbuGM2Q==
Received: from CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 03:57:43 +0000
Received: from CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc]) by CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 03:57:42 +0000
From: "Qiuxu (Leo) Zhuo" <qzhuo@nvidia.com>
To: Rosen Penev <rosenp@gmail.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, Kees Cook <kees@kernel.org>
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/ecs: simplify allocation for context
Thread-Topic: [PATCH v2] EDAC/ecs: simplify allocation for context
Thread-Index: AQHdcYMM7BH0NUEFSUiCjlFj1SgoALcoPkPQ
Date: Wed, 11 Nov 2026 03:57:42 +0000
Message-ID:
 <CY8PR12MB72909F270DC61ED7848A26EAD1712@CY8PR12MB7290.namprd12.prod.outlook.com>
References: <20261111021808.60779-1-rosenp@gmail.com>
In-Reply-To: <20261111021808.60779-1-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7290:EE_|SN7PR12MB7249:EE_
x-ms-office365-filtering-correlation-id: 23c59f02-b211-4586-6a0e-08df3fa7f004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 RXbh9mPnZhY4uXZwY+MkoHIvnnaGqKfNIg2vFXchht5rW7/NP1NNuUEqJYxIbXfu9Oj2XlsyBBjVgLvWSNSVzQNRrHFTsa1/lmFNdSmJWQfeiPa6IjPA/6HPb8ukxuuDTapW8T0nQZYhtP8mBhGMdZxAVB8Ht6kOqrGSknSBHNnthl7d73CFffxW905m6ndx37E5V9y2TD9gsVN5bJ5UmTuCIpl9/dEvokb96Q5UVqIxzSp5mWQXXw97E+H+kfXlSDHYNKM5jtLM93//kPm42PKmoqhIsrAc1a37gZn/rXnkykGOp0DicgaPUGrddSksWpIlQFDQDjy9s+RP98tinC22ItJ/imyvemTUH+72Mn6yCeECXsi/AMrfXH1jPQc9KxWC+bJKYKjUYdc8CwqhmxNEAaNtCYV/FdQ0aKiILXJXz7nahp33AMZomH059+wU4hZCgVv/yGzTtmqqcvYR4jkVpblupr8zTbesk+f7QDHIQObsVX/TXps+TTiq+BPTgQEUN1eH6G1w9BewWL6QTzZnp6cRcQBBLK9YEo5x9asHDUDo7loyrWuKHnaAKS8FzkIJNZolsISdq5pirzafjpvaQLtl2f26Kv/Z/rZrv9PhKr7+fXc+L8m8cEeQ/lfXsP3LPdRaooUJ/+BeVDXlqSxrIC1uIDvHYyLJ643EwcEuudHXMzvyBJ9OSNd/bKXEAtvp+VwXNiaRR0aSD0biSg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7290.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fDwlorKmXg1hL7LtDQiTiFxfLmG0XQ8eK2vTiSp64rXRSWrs8OWQwZiQcWcu?=
 =?us-ascii?Q?JX72HG8eXWHljbGyvo9jRBu08oiiTfljmpz4eAScIxxase16NgENfbrJVudf?=
 =?us-ascii?Q?NqRJlLujmzREy5+x2K1EYAFus81x9NvngpuK3mohNoGK0WVgZs2WRdRehGud?=
 =?us-ascii?Q?J/jVdhrz1IdrXno6v7jHpGfCdpRU59OpO/F/NeCcM5KIrA0jjZEpB8lim6Gz?=
 =?us-ascii?Q?7Hh8pM8XAbN43P/lYnSLakBEUWx3PZopJky85bPJVQySWruc8zkp/kUqffkS?=
 =?us-ascii?Q?K04HPlbaXla3msepVT1VtA7jOuXFGV4yv/967E47xdNXZZVTDAaUgmsqqr50?=
 =?us-ascii?Q?6NlHvHtdXZ+PcxcHc+VcFzpCqOHXmqEI/LN9hlZgYLke26PqphBV2LVC9KIW?=
 =?us-ascii?Q?u0xJrvZiXim+Kzki8t5SrgD4nH7FnXMt47QvCxsX+dBWP5P2szjyvBfJlHNo?=
 =?us-ascii?Q?EX9uRIIj0mZPAJSfc6+Km4zIo5Y0rMiF9IQsdFgZnHTZFCNljqCv1b2883Fl?=
 =?us-ascii?Q?2rS09mfO+CoQ87JgvlCoCN6xLhQGW6S12p4+hg6i/YtjWVVwLIUYilaEpRnV?=
 =?us-ascii?Q?jB+B8oAnahomRVLzC0gkjKd/OC0oq1FwfC8XznuLGST/Rj4d5htsNBvBT97y?=
 =?us-ascii?Q?b5fgwUG+YW1o4veLWg8CZfHKhtMidx9hMzLWp/eTP8G9AMg/TrLnHL/L5m7B?=
 =?us-ascii?Q?Ynu6LGBc+kfDdVx3FOymC5r6P4PiGIoMaIPn8a3u6X+cM0WqbCPupQI3/aAa?=
 =?us-ascii?Q?+/scUv1Pvf1Xd0LZTzc8HRjpiuuUnEh/cRlLVP9P07w9zLa0oMHwJcBxyCMu?=
 =?us-ascii?Q?xzzvkkunE+8PAG5iHjvBET5OVHcq+q9AibxNJGjpj5bbZdWUtAX5i2hPoPe+?=
 =?us-ascii?Q?KLtx5+65ZKvdsGoaGrfYH0CqvTWoJcymaCW/JloP8N/KUb5uG6dMSSr7VeD7?=
 =?us-ascii?Q?jFvs9GxTdjdgRUxeJ5N5ZyxnnsspJt5dfKr2gkYVSWAR4q25xV2BELNGALnj?=
 =?us-ascii?Q?2l1cvXwNofewN90/NEOVpDuyiuB3NqCDS52DZ6FPlK1mRChjt+T++fRChRvK?=
 =?us-ascii?Q?5Lq5qRAmpM5UhQz5S/ZjISs33/K7MCmGhrMYoqA8PZ+tztcIByNm3lqT7shz?=
 =?us-ascii?Q?J3hZAvV2R/8cX66IaKbB5DWxENF6txP18GUvnbnJBbagOFrd/WNt0QNAm/QS?=
 =?us-ascii?Q?wzXQ1p6MJgX0XlmLLak/7JJCSn147eMIWJBxj+kpVR+Ccd3FgPqlP1FUqyLt?=
 =?us-ascii?Q?b5yz/6DSgE6xFqnrXDlm6v/J1RdlHbuCpoZsatQHnhm1LcNRgEgEyV8y4HLH?=
 =?us-ascii?Q?DJnvK7V4RaKqycqSotdxcQVRlRjXT/f0IS12C3s8EFNLgyBycBlT9s1cMhhv?=
 =?us-ascii?Q?KxtnrXBPnDKrGBBUzEa8QMc1XBHaT18GvEHhY233iseWVccy5P8e9kIl3tCC?=
 =?us-ascii?Q?ubYVEOxvlsX+r+k9kIUU+PV8DPR0iG10vPH8yvuCYiCLBg+AJjH9+wwGlHWN?=
 =?us-ascii?Q?T/GSIUh63wvBQ+X7Lbr38HHV6mF7tuTixacFcUXmWzpPSvDRSGeTchzR4z2T?=
 =?us-ascii?Q?TTJ+/pyB2NmjGcREOX61sYlj8NdYsefWMtNPXgTbuXAXjpVKrOeh5RoJnZwV?=
 =?us-ascii?Q?jn0W4wloxvqHP/wiDFFD7DQynSsrajG6JbTYijslWVi03OKUS44EG9SmQOkH?=
 =?us-ascii?Q?xSj61N6fIWwBcK7WzAdTn11q5RNNej+M0nhUTWIJRjI6zPd5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7290.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c59f02-b211-4586-6a0e-08df3fa7f004
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:57:42.8773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvqR0ScCsxzWc8rfZR4Dnm3SJ+DI0Gk4LMCu26PzqaXKe11C+2DAAdavoPsfcmyDS3EBGO3PXziq5UCmeBEv9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249

> From: Rosen Penev <rosenp@gmail.com>
> Sent: Wednesday, November 11, 2026 10:18 AM
> To: Borislav Petkov <bp@alien8.de>; Tony Luck <tony.luck@intel.com>; Kees=
 Cook
> <kees@kernel.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>; linux-edac@vger.kernel.o=
rg; linux-
> kernel@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: [PATCH v2] EDAC/ecs: simplify allocation for context
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Use a flexible array member to combine allocations
>=20
> Add __counted_by for extra runtime analysis.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

LGTM. Thanks.

   Reviewed-by: Qiuxu Zhuo <qzhuo@nvidia.com>
