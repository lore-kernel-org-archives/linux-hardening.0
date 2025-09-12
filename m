Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1F2727FA;
	Fri, 12 Sep 2025 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757656486; cv=fail; b=FB+c0LZcDXIcqPgheOatCP0PUdVFpS75YjHRPuyG9vXw20uHRBIQ5MFWMM8jitXq70Tonft0KQtvGzqezPFEXTK0KCD/5pW+nLEsKSYq5tWKEznjBzQwPx+g/dtycXKYvkkv3iM4bGGhuMXrxiS8PwsgHMoJLcbbkVd1P/MmD5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757656486; c=relaxed/simple;
	bh=T532Xjdng7m2dX9xTfqjzZN8Ie613OOXgbBogVLc4b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NCMbeeRACEiYEZ1ddlWK7XCcWh1YS0Ez6/s2/6HT8RyT1pvUDmG3gdgc0Lff6sNZeoRTjsrwuksjjZiisv4+v18wO79AGp+P66cwiCEJOoKyq6+EFblPscrW+OINr2ZBzhky6uOdCAX5Fi0+UhoCrmLMn+6LHLcBgQbXEFbXNEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UPQnctuA; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UPQnctuA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfVf9qE05+X4sG4JPSwV+inA07BlEMqikhIpuJALeMqw9q0zEWr4B/t6dKJo+dQGQKs79oJZPKFfPg7oKQX/R1Bl9yCF0H/jMD0LPvQ/ATSqriIhPegPJJVc0bGy9jXDZf6jhlly55UE+0AdCNLGvpM+o1JWujKQIugxhbINaUSaRepG2OUfsyyHfKsxix6jI9btZgVSQKxaryx1dVCqVhcBTGrbQwAxYNyTodp8pVRMaAkr9cXFmGNSiE9LnJpN+IYjwEaS26JwoNSRTjabt/Vzfv6DFuS/xy1aJScrZINS2NW8TZmj5tOJL7HEnhgmdCye+w1VqHpSWiSkxYh3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQjftoEXfW8ZXWbKx9jaXCNnvH2KSdWGI1k3kWVUv5g=;
 b=YB2HF7FRAcbMTlwPLA01PuJ/W6oJ6a7LljA7zB0IfRLVTZ5FpNvo2jKTuVfOumF62jLAY8/wjRIhZ3pQBNLRMFaHgZGNjt8tL3Jqr+mFVIbiQifrJ2EzrGbBim26T43P2AzMLM57mR7yAhLr99cPcqQNTnUdkD7LRwCvwodOKnwYF9In4x7i0kT8ZKzwPcFyxqyQk5nGBX9UfZ9P+7FOHnLX5s2OgOZE1iVZ2oK7LQ8j9VxA4KaZgtquylH65C2jgN3pYkoIYEAfMHW7yfOJL9YWMS24js56mnHd9GjUePLAFUJvBR0h+iOieG45el1FGD+XeYH9Rmgz5dhY6oQrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQjftoEXfW8ZXWbKx9jaXCNnvH2KSdWGI1k3kWVUv5g=;
 b=UPQnctuATBBfAMTvPaRlR33OagRb/7yJZgLaOHugkNsCbQXXSXE2tZgQNNZ8qy/o2GG8SmmsBWFslepXztkFqfhGyBHxIpbQphTb4UItTCRZJnVwZqYKJ8oCbOROXQo+fNq2TO/U9Lw8iNSvGIcDtcej7fZomjIOhagnjXFrQHs=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:54:40 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 05:54:39 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, "jarkko.nikula@linux.intel.com"
	<jarkko.nikula@linux.intel.com>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "Goud, Srinivas" <srinivas.goud@amd.com>,
	"Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>, "manion05gk@gmail.com"
	<manion05gk@gmail.com>
Subject: RE: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller driver
Thread-Topic: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller driver
Thread-Index: AQHcIkZvn4aTq4cirkSmmfELS1IUxLSMotAAgADGrwCAALgFgIAA6baQ
Date: Fri, 12 Sep 2025 05:54:39 +0000
Message-ID:
 <DM4PR12MB61093B9BB9B3EF1D9F6B499E8C08A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
 <20250910112954.553353-3-manikanta.guntupalli@amd.com>
 <aMGtdFxlXRanIAuM@lizhi-Precision-Tower-5810>
 <DM4PR12MB6109FB1956E8AC4979DFE85A8C09A@DM4PR12MB6109.namprd12.prod.outlook.com>
 <aMLufaWnrhPxVyxm@lizhi-Precision-Tower-5810>
In-Reply-To: <aMLufaWnrhPxVyxm@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-12T05:42:03.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|MW4PR12MB7483:EE_
x-ms-office365-filtering-correlation-id: e6d67056-63e5-4ac2-54c3-08ddf1c0dcf0
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pcwhyA5RSdm/B3bA74sg+pQafwy2Z+u9VKM+EAfx3cLnaUvqpCT2rnDKuGbx?=
 =?us-ascii?Q?HNDPTM9cZ21m/V/xodcY7v0e6AIO/gw+5rFWKLvuba24nfATKV7I9RLQ4b/a?=
 =?us-ascii?Q?BPnMPT1vtyzLmUIlaLh3OMa9LqjXCSXADi3u9ajAowd2rR0+oReSJCNvBtjh?=
 =?us-ascii?Q?QvbW26nJQllaqzQ+lvyLf2jMhtrAYXQirJXmq/5syz/i+eKDUtzb1Z2N4WCe?=
 =?us-ascii?Q?f7Pup7vNDJCRQVlwmNt7niPvB60ht1+WKjxBGwZ04fulw+Jyek5AW3/S8Sj6?=
 =?us-ascii?Q?WzVSJBJhTruXs9K/0btFQfCpvVY+4XiTPPza8eA+dGepves4jgg+wgF84R7p?=
 =?us-ascii?Q?MtuzxF+d5/iQD1CpcJZIQD2OhRUD1wG+H7X+ugvYOG2NLze+hSQyd4oLGJSR?=
 =?us-ascii?Q?92xRwCnMxLG9aiIMBy4PYQaI1jA4HbxegJp3yOGHzcwhmVcV8l7RShqzifcl?=
 =?us-ascii?Q?QTVGfrA8YTWbekf4+bKu/9ewqO11uiCUR8Ei84eJbQcpmfz4vEKLC66zsJwf?=
 =?us-ascii?Q?ZJzXoITUnvxpSNwiPF3coyJb8ZRCHB4Y7VOrQto37DpRGbXfgb44xjyzWzIp?=
 =?us-ascii?Q?Zam4TLMQuhElQ9ztRKNLfe92LgdzcwtCfp23HQT21YHsO0usTUzCQUxvXEt9?=
 =?us-ascii?Q?FySk88nAQXNRTtocg2DNWE9vaAdGRM9iKetTe3PWH8vRKi4bdxxoaswrTbcX?=
 =?us-ascii?Q?eQG6Hp/FdE12ZEgMWq1muR3Sv8McRYDE/O3+i6uEPVYmMfNgWtPzm1PCTyoA?=
 =?us-ascii?Q?1FDr9djDSBgQVobcnfxM3AnVlDXHo60FgalQ2vMbBAiyulYtxDWcQVeyV4jZ?=
 =?us-ascii?Q?QO0lOWyQlnQLUvK3ykBdTgE8KrqReb/aeOIaJEtau6QjS07oChFgWX2dhKNU?=
 =?us-ascii?Q?zd/wVKiYoXyxMTZotLwHCii67TiGBI6TjNUvo0yXKcVmKdiRFn1nFo6j9CKo?=
 =?us-ascii?Q?YmzFeDwKzizZYmOzjynIY5YUmCBNcDgobpQIOiRQ2z7LkK6GXpx3+8/Lf/+Q?=
 =?us-ascii?Q?v+UXVe94flKIpGfmJ0Y+gr4PNIgTpPcNTT7tt+5UUXrDVY905/j4WZ9pQZP7?=
 =?us-ascii?Q?qFEmb2cNplD7iydUH6isbaxxiEsihti3BblI1q3O0kfRwKBEoGopEoU/3Ndo?=
 =?us-ascii?Q?cqviuluFHtXRBAdQ8m6++t+deaZUjQ7oEosoYyaKVuW1Z7PQaqcaIyQKga1Q?=
 =?us-ascii?Q?7Uz4xjuF0j4hrlk5WATVZZ5hCgxLz+Ir4AyjOSZTrzZIG7aeLbn61Poa44kX?=
 =?us-ascii?Q?8oSYsZ2zkpj1V1U6KneCHXjCcV0JsQgi3G3yGBQ43ivMaerDCDd7LmUJ9CDP?=
 =?us-ascii?Q?cjBf/Pr3iqQqlLfppI04VS7EhXSgnhhHbxsICQ7MEtUJg3zSaxTEp5KjIBXa?=
 =?us-ascii?Q?nYJspxfFWVUMrh8FjPEzTV2PXXMCS2ZjANyuASR8AvZxRaFUG4Eic9wd9l4w?=
 =?us-ascii?Q?00wul/hhZjw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LU4i79Ggt3p8rORmHN3H5hM8Pi5rZBpnY0O+LLCMqV4ASg16CxxkIRyGwOlp?=
 =?us-ascii?Q?6aV//NZdcXNh30qRgMb3daq7e4KnABdFJM5CAn2iBqJlaO+nLgphd5i8m5Fn?=
 =?us-ascii?Q?owFgDpank3pVlljYQI3aW+ol6Lj+DbLh3f0afvYY63o1FDqmVH5a+Bc4e9Pk?=
 =?us-ascii?Q?h5QfLwY3ZkaG8WGiAG1e/XDtQtOJ76Dr2B5cZmdbfo+thR/VmaFOC0ZPfDck?=
 =?us-ascii?Q?p5cQDh4Rn9zmTDoUxP1dGSZUwS9nMNLcTQzmwJWVUBDezle2a3BRels3TlDW?=
 =?us-ascii?Q?XOOVk5g58eN72/VddIoUE4N+Vhzb+1/eabiiligTd6A531MOEdkRsBYWIvNE?=
 =?us-ascii?Q?6F3kyc4KrXIIJ80qSGG3ed2fHvhjQgdHtdNvyG6pJkjkif7ROH51wrhUPd9+?=
 =?us-ascii?Q?VxAbWQpKlv2yXRVB4PoinPfSIkw4Eu9MEwOW2yb7SPj1sgxtJUEBg147ZnhQ?=
 =?us-ascii?Q?QkuCx7ILmVuwuxMLzksX26aSG6LUi6kf26RWx0IqJKfFcEiQ4FkQVpzCKiXy?=
 =?us-ascii?Q?54XbEhf2fnkrYoHSAzuu+e5qRAKskabrn4wLGW9563T02xWvxyxDyYaKPhaN?=
 =?us-ascii?Q?g60DAGEKk6FJ79CB3w+lThRE4ZmBj2EBOQzniWo6nULSUGaD4zO89nBXwkAO?=
 =?us-ascii?Q?CsT6tS8PJoqUeZmEyHzkr5fwGA72Z2lLb3EVRVknUkIYG1U7gcgqFbyyWdMY?=
 =?us-ascii?Q?cqHa6ILIzgrX7zViTRqz4qGwS0NqHJWXpy/CgpZm1zWUcO+EUtLi9lkY/bys?=
 =?us-ascii?Q?dXIdO0vRDNbkuoNYV++Airrax/sO5Q9jLUigSxw8cZ6g1zlgEl6sLKPBrRsu?=
 =?us-ascii?Q?Hb41URFql5DpP7/KMEOaertMFXoONiRdZA8CLDSAgZXXM9vDGN0za5f7aK67?=
 =?us-ascii?Q?K9ILFt3PncTuCcYJGAa7AgZ8hIRsKFFxP51bFMj5KDzalFinAinL7DChnTd4?=
 =?us-ascii?Q?U6XPVC7H0rcArffDIcVdgkssZP8gB55d3QdVaaxdSmEjIV7rcPKrRMqUCqfl?=
 =?us-ascii?Q?7x6DDyfcOufqXD3E/bML909Fi0xK0j8l4Uxh81aYg0Ia/keiRuVHvqtzM5X+?=
 =?us-ascii?Q?uLaoll44JA7tMlKK2TYDsqJ3hWIKEd1mvN+pddbZkEtR9VOPrLmODrx8RGLf?=
 =?us-ascii?Q?qHRRJewFxIDJnebnBx9VQKzIu0xcW4z5PDxDxkJe2gNvTX/mjQApCXpQ5Rnw?=
 =?us-ascii?Q?sUR+9r/AY+lOtQw+hSb+pFHmNae1V2NScstk/LeCYAlxMviGGZSVgdeh+6YC?=
 =?us-ascii?Q?IFq9OTiKnBLQi1Bf5npQtMSeUu3nil6dM1SnOS7FcFjFRzB6w7D1cd5/zl4p?=
 =?us-ascii?Q?bkkKWNVvsCHxl6lZD0uqmkJSaWSJQ+DzbI4pRq0/ahWaxnevTSyHaOb6cJaG?=
 =?us-ascii?Q?Qc6pofylZF6Qym+APkPDcqjOpW8ww0N4O5Y3FuizgmUZ6QEaxHsgRygfScLn?=
 =?us-ascii?Q?mfMAQM6T1bS5Sy/gIEVMnb2cV4gU9yhsDeNcWI8Up8vYMca/KRZJX5ViIull?=
 =?us-ascii?Q?y2jPbkJScCNhRqiX26l4AWYKAeYwXR5VGgVGJhRFx3yalUmzLZZQUooizJk8?=
 =?us-ascii?Q?p1jG10FM2HJEzV9+AgU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d67056-63e5-4ac2-54c3-08ddf1c0dcf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 05:54:39.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPfQpmZHNLiWLmY4cjVZfEd82eBYVAZDQre0Cv/2kvdcDKZWZiEYerOyeopXldBCwp1MYkRJzwCwhY4y7dr8vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483

[Public]

Hi,

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Thursday, September 11, 2025 9:15 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>;
> alexandre.belloni@bootlin.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> hardening@vger.kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> Subject: Re: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller drive=
r
>
> On Thu, Sep 11, 2025 at 06:07:59AM +0000, Guntupalli, Manikanta wrote:
> > [Public]
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Wednesday, September 10, 2025 10:25 PM
> > > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > > <michal.simek@amd.com>; alexandre.belloni@bootlin.com;
> > > robh@kernel.org; krzk+dt@kernel.org;
> > > conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> > > jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > hardening@vger.kernel.org; Pandey, Radhey Shyam
> > > <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> > > <srinivas.goud@amd.com>; Datta, Shubhrajyoti
> > > <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> > > Subject: Re: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller
> > > driver
> > >
> > > On Wed, Sep 10, 2025 at 04:59:54PM +0530, Manikanta Guntupalli wrote:
> > > > Add an I3C master driver and maintainers fragment for the AMD I3C
> > > > bus controller.
> > > >
> > > > The driver currently supports the I3C bus operating in SDR i3c
> > > > mode, with features including Dynamic Address Assignment, private
> > > > data transfers, and CCC transfers in both broadcast and direct
> > > > modes. It also supports operation in I2C mode.
> > > >
> > > > Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > > > ---
> > > > Changes for V2:
> > > > Updated commit description.
> > > > Added mixed mode support with clock configuration.
> > > > Converted smaller functions into inline functions.
> > > > Used FIELD_GET() in xi3c_get_response().
> > > > Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
> > > > Used parity8() for address parity calculation.
> > > > Added guards for locks.
> > > > Dropped num_targets and updated xi3c_master_do_daa().
> > > > Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
> > > > Dropped PM runtime support.
> > > > Updated xi3c_master_read() and xi3c_master_write() with
> > > > xi3c_is_resp_available() check.
> > > > Created separate functions: xi3c_master_init() and xi3c_master_rein=
it().
> > > > Used xi3c_master_init() in bus initialization and
> > > > xi3c_master_reinit() in error paths.
> > > > Added DAA structure to xi3c_master structure.
> > > >
> > > > Changes for V3:
> > > > Resolved merge conflicts.
> > > >
> > > > Changes for V4:
> > > > Updated timeout macros.
> > > > Removed type casting for xi3c_is_resp_available() macro.
> > > > Used ioread32() and iowrite32() instead of readl() and writel() to
> > > > keep consistency.
> > > > Read XI3C_RESET_OFFSET reg before udelay().
> > > > Removed xi3c_master_free_xfer() and directly used kfree().
> > > > Skipped checking return value of i3c_master_add_i3c_dev_locked().
> > > > Used devm_mutex_init() instead of mutex_init().
> > > >
> > > > Changes for V5:
> > > > Used GENMASK_ULL for PID mask as it's 64bit mask.
> > > >
> > > > Changes for V6:
> > > > Removed typecast for xi3c_getrevisionnumber(), xi3c_wrfifolevel(),
> > > > and xi3c_rdfifolevel().
> > > > Replaced dynamic allocation with a static variable for pid_bcr_dcr.
> > > > Fixed sparse warning in do_daa by typecasting the address parity
> > > > value to u8.
> > > > Fixed sparse warning in xi3c_master_bus_init by typecasting the
> > > > pid value to u64 in info.pid calculation.
> > > > ---
> > > >  MAINTAINERS                         |    7 +
> > > >  drivers/i3c/master/Kconfig          |   16 +
> > > >  drivers/i3c/master/Makefile         |    1 +
> > > >  drivers/i3c/master/amd-i3c-master.c | 1009
> > > > +++++++++++++++++++++++++++
> > > >  4 files changed, 1033 insertions(+)  create mode 100644
> > > > drivers/i3c/master/amd-i3c-master.c
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > > 1af81124bba3..ff603ce5e78d 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -11693,6 +11693,13 @@ L: linux-i2c@vger.kernel.org
> > > >  S: Maintained
> > > >  F: drivers/i2c/i2c-stub.c
> > > >
> > > > +I3C DRIVER FOR AMD AXI I3C MASTER
> > > > +M: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > > > +R: Michal Simek <michal.simek@amd.com>
> > > > +S: Maintained
> > > > +F: Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> > > > +F: drivers/i3c/master/amd-i3c-master.c
> > > > +
> > > >  I3C DRIVER FOR ASPEED AST2600
> > > >  M: Jeremy Kerr <jk@codeconstruct.com.au>
> > > >  S: Maintained
> > > > diff --git a/drivers/i3c/master/Kconfig
> > > > b/drivers/i3c/master/Kconfig index 13df2944f2ec..4b884a678893
> > > > 100644
> > > > --- a/drivers/i3c/master/Kconfig
> > > > +++ b/drivers/i3c/master/Kconfig
> > > > @@ -1,4 +1,20 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +config AMD_I3C_MASTER
> > > > +   tristate "AMD I3C Master driver"
> > > > +   depends on I3C
> > > > +   depends on HAS_IOMEM
> > > > +   help
> > > > +     Support for AMD I3C Master Controller.
> > > > +
> > > > +     This driver allows communication with I3C devices using the A=
MD
> > > > +     I3C master, currently supporting Standard Data Rate (SDR) mod=
e.
> > > > +     Features include Dynamic Address Assignment, private transfer=
s,
> > > > +     and CCC transfers in both broadcast and direct modes.
> > > > +
> > > > +     This driver can also be built as a module.  If so, the module
> > > > +     will be called amd-i3c-master.
> > > > +
> > > >  config CDNS_I3C_MASTER
> > > >     tristate "Cadence I3C master driver"
> > > >     depends on HAS_IOMEM
> > > > diff --git a/drivers/i3c/master/Makefile
> > > > b/drivers/i3c/master/Makefile index aac74f3e3851..109bd48cb159
> > > > 100644
> > > > --- a/drivers/i3c/master/Makefile
> > > > +++ b/drivers/i3c/master/Makefile
> > > > @@ -1,4 +1,5 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > +obj-$(CONFIG_AMD_I3C_MASTER)               +=3D amd-i3c-master.o
> > > >  obj-$(CONFIG_CDNS_I3C_MASTER)              +=3D i3c-master-cdns.o
> > > >  obj-$(CONFIG_DW_I3C_MASTER)                +=3D dw-i3c-master.o
> > > >  obj-$(CONFIG_AST2600_I3C_MASTER)   +=3D ast2600-i3c-master.o
> > > > diff --git a/drivers/i3c/master/amd-i3c-master.c
> > > > b/drivers/i3c/master/amd-i3c-master.c
> > > > new file mode 100644
> > > > index 000000000000..cd9d85a0be80
> > > > --- /dev/null
> > > > +++ b/drivers/i3c/master/amd-i3c-master.c
> > > > @@ -0,0 +1,1009 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * I3C master driver for the AMD I3C controller.
> > > > + *
> > > > + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> > > > + */
> > > > +
> > > ...
> > > > +
> > > > +/* timeout waiting for the controller finish transfers */
> > > > +#define XI3C_XFER_TIMEOUT_MS                       10000
> > > > +#define XI3C_XFER_TIMEOUT
> > >       (msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))
> > >
> > > Do I missed your reply? I have not seen
> > > https://lore.kernel.org/linux-i3c/aL7+Urm4NB9kwOwQ@lizhi-Precision-T
> > > ower-5810/
> > >
> > > If you need define two macro for it. Need unit
> > > XI3C_XFER_TIMEOUT_JIFFIES to avoid confuse.
> > Sure, I'll update the macro name to XI3C_XFER_TIMEOUT_JIFFIES to avoid
> confusion.
> > >
> > >
> > > > +
> > > > +#define xi3c_getrevisionnumber(master)                            =
                 \
> > > > +   (FIELD_GET(XI3C_REV_NUM_MASK,
> > >       \
> > > > +              ioread32((master)->membase + XI3C_VERSION_OFFSET)))
> > > > +
> > >
> > > ...
> > >
> > > > +static void xi3c_master_wr_to_tx_fifo(struct xi3c_master *master,
> > > > +                                 struct xi3c_cmd *cmd) {
> > > > +   u8 *tx_buf =3D (u8 *)cmd->tx_buf;
> > > > +   u32 data =3D 0;
> > > > +   u16 len;
> > > > +
> > > > +   len =3D cmd->tx_len;
> > > > +   if (len > 0) {
> > > > +           len =3D (len >=3D XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
> > > > +           memcpy(&data, tx_buf, len);
> > > > +           tx_buf +=3D len;
> > > > +           cmd->tx_len -=3D len;
> > > > +   }
> > > > +   cmd->tx_buf =3D tx_buf;
> > > > +
> > > > +   /* Write the 32-bit value to the Tx FIFO */
> > > > +   iowrite32be(data, master->membase + XI3C_WR_FIFO_OFFSET); }
> > >
> > > i3c_writel(readl)_fifo() did similar things, why not use it?
> > >
> > > Did you miss my review comment or I missed your reply?
> > You have missed my earlier reply on this.
> > The helpers i3c_writel_fifo() and i3c_readl_fifo() rely on the CPU's
> > native endianness, whereas in this case the FIFO should always be acces=
sed in
> big-endian format.
> > Hence, we cannot use the common helpers directly.
> >
> > For reference, here's my previous reply:
> >
> https://lore.kernel.org/all/DM4PR12MB6109F6D5D032723C675472448C0FA@DM4
> > PR12MB6109.namprd12.prod.outlook.com/
>
> Sorry, can you improve i3c_writel(readl)_fifo() to support endianness? I =
think not only
> you have this kind problem in future.
Sure, will add support for endianness.
>
> >
> > >
> > > ...
> > > > +
> > > > +static const struct of_device_id xi3c_master_of_ids[] =3D {
> > > > +   { .compatible =3D "xlnx,axi-i3c-1.0" },
> > > > +   { },
> > > > +};
> > > > +
> > > > +static struct platform_driver xi3c_master_driver =3D {
> > > > +   .probe =3D xi3c_master_probe,
> > > > +   .remove =3D xi3c_master_remove,
> > > > +   .driver =3D {
> > > > +           .name =3D "axi-i3c-master",
> > > > +           .of_match_table =3D xi3c_master_of_ids,
> > > > +   },
> > > > +};
> > > > +module_platform_driver(xi3c_master_driver);
> > > > +
> > > > +MODULE_AUTHOR("Manikanta Guntupalli
> > > > +<manikanta.guntupalli@amd.com>"); MODULE_DESCRIPTION("AXI I3C
> > > > +master driver");
> > > MODULE_LICENSE("GPL");
> > > > --
> > > > 2.34.1
> > > >
> >

Thanks,
Manikanta.
