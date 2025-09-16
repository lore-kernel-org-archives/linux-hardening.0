Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6531BD9CE;
	Tue, 16 Sep 2025 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004640; cv=fail; b=gaJvVjO7VJe+R6pUtKVXWV2mS86I0m84vmrkYRtaKvF2aRWRWN4z0Lprs5YdcaC8jxG2Eh+fwd2j1t1bdKhrW9bPbByIuWoXrbA8vSgZidFYn40iYeXSVBlw3ShwBuCYjZOcrGahTUDOMRbljGHYAtY+Nkd6rFjqLP8m1wYNBiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004640; c=relaxed/simple;
	bh=XisTl8iWjeXeLUD655cfZDp4b2ItGnr4ikLadNmswE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iWYjU6niZMFe4P2WVL/ilLH/9LHNCeEEhmnPBte/n0L/kefps5Jhf8r8yO5fnrnKBPS8/+SbPPwvrQ4y2gXQQB0OtR4kjxjixzS0XdPTG3JXhe7D5FkRJn5/CpGNmAPYlqUcZTkmBKtcjV8aTVKNUqvrr/kYARIcwejjqbj7Ki4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NYvaKLwL; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NYvaKLwL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKKtpHK2VVlHnpSG3OilmabLmr0JuXibatDh081kRSm1i6Om1H7/IMnHhKxr2aWciwYNnL+M8Vt4kehB358vxW4FXRy1WNBWDpFllpQuv4DWorBPsufspEbTm1027XPIvHec42aM+5K062jMi1XUG0Q0cEJXeh+fAsGa6O/qJw68M+h5/ZXnmeEzTqLCHajvMmlIwTNJqlsLkO3V4Q3DAlDOeWElMFLh5eSU0XU/nOuuPVoaEnoQGveL/6YtIswjHIb5hijsr02wbcx+E224rnC941042tx4qjPSTk9C8zYGB+2/wr10P3RDyyK2pUVk8olxFOpu45VppHqZ+E4n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWPs40D8/nc6ZYMTzVYGjThnRrRZLMTWgFwZ3Xzu470=;
 b=CyucJ8XdjP9TT2gncOPQ03PmFc9N/PB3K3d/8JfL59K25OjpAVvHNCpYCht2fKEomLM2mcQOq2A6j1SGSuExXUJRgFqLa7ThnJ0/t6zGcjR+Wb1rbv7zn1tZOt2pOPTETYOEc4PzLB4TEU5nfA06+ljeNo4SG/W90mPu9rUnA4oLYkqZrIQw7FdrjYd4PZwJtyblEVH/YoqR0pCs7Nz3qsEajX9G4XCeT7raQnVjPKjk9xTAJKckxkPuBLvaM0U/zyhmlVIwg6PKAMwvijoTD/HUX8turMDdK/rfZrJagIbAMQ1N7kMwcIpvgZJVrtzLUVe7Lcvc1uB2N24DmbAvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWPs40D8/nc6ZYMTzVYGjThnRrRZLMTWgFwZ3Xzu470=;
 b=NYvaKLwLxjBYqzGTw/uBMj/vSSyUtdVs8ZBkmViNu1Rs+3VrbtymuX82MV8QAXl7j7VxJIECI2vMy4ul1gJrvqTD+iSFCrC+dNx09riddniTYK9UZeDJBNtmEn3LrsnG9I++7EOZ11sOsg9/zruuazgufWRQ2uVVsZze7wnMLhc=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 06:37:08 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 06:37:08 +0000
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
Thread-Index:
 AQHcIkZvn4aTq4cirkSmmfELS1IUxLSMotAAgADGrwCAALgFgIAA6baQgABff+CABfhCYA==
Date: Tue, 16 Sep 2025 06:37:08 +0000
Message-ID:
 <DM4PR12MB6109842EA1FFBD183C57AA8E8C14A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
 <20250910112954.553353-3-manikanta.guntupalli@amd.com>
 <aMGtdFxlXRanIAuM@lizhi-Precision-Tower-5810>
 <DM4PR12MB6109FB1956E8AC4979DFE85A8C09A@DM4PR12MB6109.namprd12.prod.outlook.com>
 <aMLufaWnrhPxVyxm@lizhi-Precision-Tower-5810>
 <DM4PR12MB61093B9BB9B3EF1D9F6B499E8C08A@DM4PR12MB6109.namprd12.prod.outlook.com>
 <DM4PR12MB61099BA795FD6DA057DD08E58C08A@DM4PR12MB6109.namprd12.prod.outlook.com>
In-Reply-To:
 <DM4PR12MB61099BA795FD6DA057DD08E58C08A@DM4PR12MB6109.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|CH3PR12MB8533:EE_
x-ms-office365-filtering-correlation-id: 709d9046-bd8b-4514-3f62-08ddf4eb7599
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+Xt8S/8vGo5Tc1OdcWIYHfXFajXBLv4T3cABKQVk2bt8X0QH8Y7XveLun7Nl?=
 =?us-ascii?Q?9Vy9webLiJH0vuGAe9q/t1XQ/vwt9G2u1kUvYMJkQ/rkwBMYdBuaQfDNPXSy?=
 =?us-ascii?Q?8grTZZkM+sZywM+jWHSn3g+8AgvpAhDXJoaTRpMvbgMgcyTBgJYxvNZLMZBY?=
 =?us-ascii?Q?dObsHg/YPgH161sbrUQWOiR4VPGcgmXqa92FLdU8+P7REeVZ381Qn7HlhgS+?=
 =?us-ascii?Q?aNzeDWzNBOkgZhhRscmkT6lxSl1nXy7F1/yXxumoUDVXwSphU4jF8SKYqeIO?=
 =?us-ascii?Q?w+GZhVj6xjBugRBqG/rdottDcGUl7Cq8kShE8qx4LlW+o8aUISk1lLCE3i66?=
 =?us-ascii?Q?lYdEuY5wR9jGYQkyZFxXZP9ipIH3f760ybwJu0nAva/E3dl6Ofx5GpR3KbRN?=
 =?us-ascii?Q?rL9bCuQvlrUksPpxVVEhCFVwW8ODSrZHcsg2dYYRqLKCGeZbCKRnrka2d/d6?=
 =?us-ascii?Q?jRj3bXRBY/s2PU8nPN7l0Hb+GHNCPvcr2v9tVrd9eY8jZI78EaZPovxv+ljH?=
 =?us-ascii?Q?9P1peEx9/maHq/TeJlvbkuk1iOqmIXJQQHx2PEJEtT/DRrjwwXjeePQIf41P?=
 =?us-ascii?Q?8NTrX0cUwo/fRpCF2sZ+zvhae3f9hAWnh0a7EQnA4sCAYpnOBen6J8GMmJ45?=
 =?us-ascii?Q?kqI+Sm5kI3c5ThIfqb0kI4TmOSxiuUlPMyO1+CLhdTLfr9zykiDM7jUwPdlc?=
 =?us-ascii?Q?T33QBSUnM0DKZvoaS9LZ2vXYoRRiyYfv7/G4G9xbBBU6KHj3TqaMHBiPRdQu?=
 =?us-ascii?Q?kxcZMy8L1cMx4huwH87PSmck5HXDM/EqgBFegDsSZanCoWP8TH3Mi8AWjs1K?=
 =?us-ascii?Q?SLt9hifBlVzcYlKgMe2PnEzHSV2WXxRYQz1MChKjd/6DZD5JF7+U1aaKQ9tx?=
 =?us-ascii?Q?sVL4XvNUJW0r4T1bSZB4G2UwLCwvQlF3ZRIZQyWQZALFY+ktDnf6mR/ZU0XO?=
 =?us-ascii?Q?8WAC8PrtMlOwBnp1fGnmb737NrB6Ci2H+70zAtm6JCW0bJEw8E5BfMi/Nn3y?=
 =?us-ascii?Q?1itsUUo/w+XT2oB+n68OcCeL3bCgc4j7S9KgenHpXggj+Ajs4xMcLdtsV2if?=
 =?us-ascii?Q?oTSbi+nRZcc0CF8Bec7+sRi2PXOgkJkNtxTl/rph3Au1HeYPk/cfvWe2/jBn?=
 =?us-ascii?Q?rRFqGH44cN7P0yx0MnIs6eE3dHAg2fOZC3M7/T3PHCbuTTMkUdKroMm/8Xyg?=
 =?us-ascii?Q?IV9zxIVLoxaTeXRwJvKsBEPU/aL577OIHvlLQkTaYCtZBZwSq7TjJBPCxuKk?=
 =?us-ascii?Q?62ZfbU0dh3TzzpV+o0RTTPFgqQAkH3sxfvh8PQYPA/TfXjzkIaNgsGM4DXDZ?=
 =?us-ascii?Q?mGB+GDmnNmJb+CvXTI40/hfWIkGnsXY4nG86WvEJGLDdWIjiP2ObumEsELiP?=
 =?us-ascii?Q?6Zx4hfmFm3Jl1f7s+1r0JCZ/4NPELcx4qhFeMHQ8MxkVznwAmnEo1OR6dYmx?=
 =?us-ascii?Q?W4XXgFqNP5U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TRLAmoRm676uJniV/wQ5sU07evEW6a3KD2oP3meTCDctBE4wAZxJXafF4oMf?=
 =?us-ascii?Q?lE0y8xQMNJ+NfMGjtv/fTprFB+8CbwOoDSG+XE82dhAs0d6WW9hBME9eOLka?=
 =?us-ascii?Q?mB8rsWSf9ypoXS5Y1RntS9qGxaIrfRU1qQUnOvNHI92e6wNyrkCqP4oWrv8f?=
 =?us-ascii?Q?86rFejObczv1GAAE3T4REVxTRTU/4XZCVn+5Vt6KDhTRiJA7DkeMBXsKzaUH?=
 =?us-ascii?Q?QWHO6d9vRIodqrerDiwk1MpDFLxz99ABrfBc7l0y/GNDCMcUZo+F7goGZAJE?=
 =?us-ascii?Q?srBw08/3SBzCrQm4sMVUbjI6p2yoi/GRIZdYLlq9TU8+PkNAoDOTdiSzWM2e?=
 =?us-ascii?Q?oqUFEncW6ti9Jj9rR9xj0NXHFIvL1RLRnBmABhD/1w9waeUsKduM+kIbdBaX?=
 =?us-ascii?Q?RVZ4nob6rAsH904d1Zxp2ILsoHCyx7OcN0zTECanCcXdz1D7n9DS5VibHbJq?=
 =?us-ascii?Q?bSfAU5eI7FHrZXpjVWvHygVkn1oTu+Okr61G55bDwUs7RxQYJo/E1xTLGGX/?=
 =?us-ascii?Q?9ZSnj0eVsH59n/3iG3gUOOgjJ9Qv9WQaGTGMwIpWPlOdu5juX/MvY+gBsTIU?=
 =?us-ascii?Q?kLDgEut5cddwLk1EpkUBDOZKQDDlBT/Ym47PA6lXg2ToZOC5i7IRUTAqhfor?=
 =?us-ascii?Q?vd6oEXhnaJVW0qzWoFfXlDQuosMkBlPM7tEiHP7IpRuUumdAHthDnq7gGDMm?=
 =?us-ascii?Q?aGxRRmAd5piXNQDrF1048NYC9cObCaCGeEOEsJNz2lfQzb1KpbwB06DfS2Mw?=
 =?us-ascii?Q?buC9BbZqO6rdyCpRP+0Fxihi/JgbGzCj2icjTocVs6PJwk+GdcqwytzfNhBy?=
 =?us-ascii?Q?TLta3tibVjjx1p8rGkhI+j0Yu4jIZL6WqIYXHGKZuhgpO+cP4QkMyU5+6ylB?=
 =?us-ascii?Q?ICSU+bXVtEt/SktJX5IQPNdyosscQfa6EDmJ78cFoWkAh4iXWaJLgDlIQoAc?=
 =?us-ascii?Q?tw8jfXGRYZmTGhg93GH/mYff1pDMrEByRa3d1xKj25nJnYfxqhAK2Mh2UzzV?=
 =?us-ascii?Q?ezhRuB/iloF6vGSGYbN44ik2wTCcS9rmvEUdzQMZzc9mVe2Eb9QhjE/KXmBF?=
 =?us-ascii?Q?b1WODhTtLg/llgOUGnW3Sc26sS3O/Etdm9hg12b1mspYQsoUKSPnbRtzY4jU?=
 =?us-ascii?Q?uIDPE0LCMmIRdvSgwyFJSYxmGJHneJ7gAmvr4Vwyn58G2mtG48rEAfZaJlIU?=
 =?us-ascii?Q?kEaqnohxn/l8Agz0pOPYq20/FT0f3whWV/EUIg56y8hRFz1OiIa2pY1WhaDK?=
 =?us-ascii?Q?zZaROC2QmxXZKXlREVHdl7aPF1Z2z1m+Tk1XwXfHqRJK0Wv4Vl3bHZ8+6ZLP?=
 =?us-ascii?Q?wB0Hle3ep0/7Jv8/o7GBAH/mZ35AsdZNGgNzWooPoBpPUfVDw+tTb23FI/k2?=
 =?us-ascii?Q?IxCTh+FV35M6TGNTaquVFbvlrgayIcn7gG/s2PDarzOxkAJoeMqpaXk4iJen?=
 =?us-ascii?Q?mhGl4zcBKGCYbjQpOvEhay66JmFIGiIdcefzBHARkNsBGwzXsUl+L8f7/ZjB?=
 =?us-ascii?Q?qAaCWkDruEJWrNkiNQQgnACkw+s4eDlgvsoQ69fLt6s6Q5ecmIZ7J5wgOW+V?=
 =?us-ascii?Q?SNlsAIY27dO2CCyBBe8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 709d9046-bd8b-4514-3f62-08ddf4eb7599
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 06:37:08.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUBoYLgvPSwq9sEVZJoSwwMTJJrVWod5d9mJgmQW+Aep5kq0JSwNzLeldQgWTQwkh3KQL3zdpMuA9BxsrfKqQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533

[Public]

Hi,

> -----Original Message-----
> From: Guntupalli, Manikanta
> Sent: Friday, September 12, 2025 4:56 PM
> To: 'Frank Li' <Frank.li@nxp.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>;
> 'alexandre.belloni@bootlin.com' <alexandre.belloni@bootlin.com>;
> 'robh@kernel.org' <robh@kernel.org>; 'krzk+dt@kernel.org' <krzk+dt@kernel=
.org>;
> 'conor+dt@kernel.org' <conor+dt@kernel.org>; 'kees@kernel.org'
> <kees@kernel.org>; 'gustavoars@kernel.org' <gustavoars@kernel.org>;
> 'jarkko.nikula@linux.intel.com' <jarkko.nikula@linux.intel.com>; 'linux-
> i3c@lists.infradead.org' <linux-i3c@lists.infradead.org>;
> 'devicetree@vger.kernel.org' <devicetree@vger.kernel.org>; 'linux-
> kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; 'linux-
> hardening@vger.kernel.org' <linux-hardening@vger.kernel.org>; Pandey, Rad=
hey
> Shyam <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> <srinivas.goud@amd.com>; Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>=
;
> 'manion05gk@gmail.com' <manion05gk@gmail.com>
> Subject: RE: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller drive=
r
>
> Hi,
>
> > -----Original Message-----
> > From: Guntupalli, Manikanta
> > Sent: Friday, September 12, 2025 11:25 AM
> > To: Frank Li <Frank.li@nxp.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > <michal.simek@amd.com>; alexandre.belloni@bootlin.com;
> > robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> > jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > hardening@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> > Subject: RE: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller
> > driver
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Thursday, September 11, 2025 9:15 PM
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
> > > On Thu, Sep 11, 2025 at 06:07:59AM +0000, Guntupalli, Manikanta wrote=
:
> > > > [Public]
> > > >
> > > > Hi,
> > > >
> > > > > -----Original Message-----
> > > > > From: Frank Li <Frank.li@nxp.com>
> > > > > Sent: Wednesday, September 10, 2025 10:25 PM
> > > > > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > > > > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > > > > <michal.simek@amd.com>; alexandre.belloni@bootlin.com;
> > > > > robh@kernel.org; krzk+dt@kernel.org;
> > > > > conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> > > > > jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> > > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > > > hardening@vger.kernel.org; Pandey, Radhey Shyam
> > > > > <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> > > > > <srinivas.goud@amd.com>; Datta, Shubhrajyoti
> > > > > <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> > > > > Subject: Re: [PATCH V6 2/2] i3c: master: Add AMD I3C bus
> > > > > controller driver
> > > > >
> > > > > On Wed, Sep 10, 2025 at 04:59:54PM +0530, Manikanta Guntupalli wr=
ote:
> > > > > > Add an I3C master driver and maintainers fragment for the AMD
> > > > > > I3C bus controller.
> > > > > >
> > > > > > The driver currently supports the I3C bus operating in SDR i3c
> > > > > > mode, with features including Dynamic Address Assignment,
> > > > > > private data transfers, and CCC transfers in both broadcast
> > > > > > and direct modes. It also supports operation in I2C mode.
> > > > > >
> > > > > > Signed-off-by: Manikanta Guntupalli
> > > > > > <manikanta.guntupalli@amd.com>
> > > > > > ---
> > > > > > Changes for V2:
> > > > > > Updated commit description.
> > > > > > Added mixed mode support with clock configuration.
> > > > > > Converted smaller functions into inline functions.
> > > > > > Used FIELD_GET() in xi3c_get_response().
> > > > > > Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
> > > > > > Used parity8() for address parity calculation.
> > > > > > Added guards for locks.
> > > > > > Dropped num_targets and updated xi3c_master_do_daa().
> > > > > > Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
> > > > > > Dropped PM runtime support.
> > > > > > Updated xi3c_master_read() and xi3c_master_write() with
> > > > > > xi3c_is_resp_available() check.
> > > > > > Created separate functions: xi3c_master_init() and xi3c_master_=
reinit().
> > > > > > Used xi3c_master_init() in bus initialization and
> > > > > > xi3c_master_reinit() in error paths.
> > > > > > Added DAA structure to xi3c_master structure.
> > > > > >
> > > > > > Changes for V3:
> > > > > > Resolved merge conflicts.
> > > > > >
> > > > > > Changes for V4:
> > > > > > Updated timeout macros.
> > > > > > Removed type casting for xi3c_is_resp_available() macro.
> > > > > > Used ioread32() and iowrite32() instead of readl() and
> > > > > > writel() to keep consistency.
> > > > > > Read XI3C_RESET_OFFSET reg before udelay().
> > > > > > Removed xi3c_master_free_xfer() and directly used kfree().
> > > > > > Skipped checking return value of i3c_master_add_i3c_dev_locked(=
).
> > > > > > Used devm_mutex_init() instead of mutex_init().
> > > > > >
> > > > > > Changes for V5:
> > > > > > Used GENMASK_ULL for PID mask as it's 64bit mask.
> > > > > >
> > > > > > Changes for V6:
> > > > > > Removed typecast for xi3c_getrevisionnumber(),
> > > > > > xi3c_wrfifolevel(), and xi3c_rdfifolevel().
> > > > > > Replaced dynamic allocation with a static variable for pid_bcr_=
dcr.
> > > > > > Fixed sparse warning in do_daa by typecasting the address
> > > > > > parity value to u8.
> > > > > > Fixed sparse warning in xi3c_master_bus_init by typecasting
> > > > > > the pid value to u64 in info.pid calculation.
> > > > > > ---
> > > > > >  MAINTAINERS                         |    7 +
> > > > > >  drivers/i3c/master/Kconfig          |   16 +
> > > > > >  drivers/i3c/master/Makefile         |    1 +
> > > > > >  drivers/i3c/master/amd-i3c-master.c | 1009
> > > > > > +++++++++++++++++++++++++++
> > > > > >  4 files changed, 1033 insertions(+)  create mode 100644
> > > > > > drivers/i3c/master/amd-i3c-master.c
> > > > > >
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > > > > 1af81124bba3..ff603ce5e78d 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -11693,6 +11693,13 @@ L: linux-i2c@vger.kernel.org
> > > > > >  S: Maintained
> > > > > >  F: drivers/i2c/i2c-stub.c
> > > > > >
> > > > > > +I3C DRIVER FOR AMD AXI I3C MASTER
> > > > > > +M: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > > > > > +R: Michal Simek <michal.simek@amd.com>
> > > > > > +S: Maintained
> > > > > > +F: Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> > > > > > +F: drivers/i3c/master/amd-i3c-master.c
> > > > > > +
> > > > > >  I3C DRIVER FOR ASPEED AST2600
> > > > > >  M: Jeremy Kerr <jk@codeconstruct.com.au>
> > > > > >  S: Maintained
> > > > > > diff --git a/drivers/i3c/master/Kconfig
> > > > > > b/drivers/i3c/master/Kconfig index 13df2944f2ec..4b884a678893
> > > > > > 100644
> > > > > > --- a/drivers/i3c/master/Kconfig
> > > > > > +++ b/drivers/i3c/master/Kconfig
> > > > > > @@ -1,4 +1,20 @@
> > > > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > > > +
> > > > > > +config AMD_I3C_MASTER
> > > > > > +   tristate "AMD I3C Master driver"
> > > > > > +   depends on I3C
> > > > > > +   depends on HAS_IOMEM
> > > > > > +   help
> > > > > > +     Support for AMD I3C Master Controller.
> > > > > > +
> > > > > > +     This driver allows communication with I3C devices using t=
he AMD
> > > > > > +     I3C master, currently supporting Standard Data Rate (SDR)=
 mode.
> > > > > > +     Features include Dynamic Address Assignment, private tran=
sfers,
> > > > > > +     and CCC transfers in both broadcast and direct modes.
> > > > > > +
> > > > > > +     This driver can also be built as a module.  If so, the mo=
dule
> > > > > > +     will be called amd-i3c-master.
> > > > > > +
> > > > > >  config CDNS_I3C_MASTER
> > > > > >     tristate "Cadence I3C master driver"
> > > > > >     depends on HAS_IOMEM
> > > > > > diff --git a/drivers/i3c/master/Makefile
> > > > > > b/drivers/i3c/master/Makefile index aac74f3e3851..109bd48cb159
> > > > > > 100644
> > > > > > --- a/drivers/i3c/master/Makefile
> > > > > > +++ b/drivers/i3c/master/Makefile
> > > > > > @@ -1,4 +1,5 @@
> > > > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > > > +obj-$(CONFIG_AMD_I3C_MASTER)               +=3D amd-i3c-master=
.o
> > > > > >  obj-$(CONFIG_CDNS_I3C_MASTER)              +=3D i3c-master-cdn=
s.o
> > > > > >  obj-$(CONFIG_DW_I3C_MASTER)                +=3D dw-i3c-master.=
o
> > > > > >  obj-$(CONFIG_AST2600_I3C_MASTER)   +=3D ast2600-i3c-master.o
> > > > > > diff --git a/drivers/i3c/master/amd-i3c-master.c
> > > > > > b/drivers/i3c/master/amd-i3c-master.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..cd9d85a0be80
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/i3c/master/amd-i3c-master.c
> > > > > > @@ -0,0 +1,1009 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * I3C master driver for the AMD I3C controller.
> > > > > > + *
> > > > > > + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> > > > > > + */
> > > > > > +
> > > > > ...
> > > > > > +
> > > > > > +/* timeout waiting for the controller finish transfers */
> > > > > > +#define XI3C_XFER_TIMEOUT_MS                       10000
> > > > > > +#define XI3C_XFER_TIMEOUT
> > > > >       (msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))
> > > > >
> > > > > Do I missed your reply? I have not seen
> > > > > https://lore.kernel.org/linux-i3c/aL7+Urm4NB9kwOwQ@lizhi-Precisi
> > > > > on
> > > > > -T
> > > > > ower-5810/
> > > > >
> > > > > If you need define two macro for it. Need unit
> > > > > XI3C_XFER_TIMEOUT_JIFFIES to avoid confuse.
> > > > Sure, I'll update the macro name to XI3C_XFER_TIMEOUT_JIFFIES to
> > > > avoid
> > > confusion.
> > > > >
> > > > >
> > > > > > +
> > > > > > +#define xi3c_getrevisionnumber(master)                        =
                     \
> > > > > > +   (FIELD_GET(XI3C_REV_NUM_MASK,
> > > > >       \
> > > > > > +              ioread32((master)->membase +
> > > > > > + XI3C_VERSION_OFFSET)))
> > > > > > +
> > > > >
> > > > > ...
> > > > >
> > > > > > +static void xi3c_master_wr_to_tx_fifo(struct xi3c_master *mast=
er,
> > > > > > +                                 struct xi3c_cmd *cmd) {
> > > > > > +   u8 *tx_buf =3D (u8 *)cmd->tx_buf;
> > > > > > +   u32 data =3D 0;
> > > > > > +   u16 len;
> > > > > > +
> > > > > > +   len =3D cmd->tx_len;
> > > > > > +   if (len > 0) {
> > > > > > +           len =3D (len >=3D XI3C_WORD_LEN) ? XI3C_WORD_LEN : =
len;
> > > > > > +           memcpy(&data, tx_buf, len);
> > > > > > +           tx_buf +=3D len;
> > > > > > +           cmd->tx_len -=3D len;
> > > > > > +   }
> > > > > > +   cmd->tx_buf =3D tx_buf;
> > > > > > +
> > > > > > +   /* Write the 32-bit value to the Tx FIFO */
> > > > > > +   iowrite32be(data, master->membase + XI3C_WR_FIFO_OFFSET);
> > > > > > + }
> > > > >
> > > > > i3c_writel(readl)_fifo() did similar things, why not use it?
> > > > >
> > > > > Did you miss my review comment or I missed your reply?
> > > > You have missed my earlier reply on this.
> > > > The helpers i3c_writel_fifo() and i3c_readl_fifo() rely on the
> > > > CPU's native endianness, whereas in this case the FIFO should
> > > > always be accessed in
> > > big-endian format.
> > > > Hence, we cannot use the common helpers directly.
> > > >
> > > > For reference, here's my previous reply:
> > > >
> > >
> >
> https://lore.kernel.org/all/DM4PR12MB6109F6D5D032723C675472448C0FA@DM4
> > > > PR12MB6109.namprd12.prod.outlook.com/
> > >
> > > Sorry, can you improve i3c_writel(readl)_fifo() to support endianness=
?
> > > I think not only you have this kind problem in future.
> > Sure, will add support for endianness.
> To add support for endianness, we could not find a big-endian counterpart=
 to
> writesl().
> Please let me know if I missed any existing helper.
Endianness support for i3c_writel_fifo() and i3c_readl_fifo() would
require writesl_be() and readsl_be(), which are not currently available.
Implementing them introduces additional dependencies, so we suggest
handling endianness support in a follow-up patch series instead.
Please advise.

> > > >
> > > > >
> > > > > ...
> > > > > > +
> > > > > > +static const struct of_device_id xi3c_master_of_ids[] =3D {
> > > > > > +   { .compatible =3D "xlnx,axi-i3c-1.0" },
> > > > > > +   { },
> > > > > > +};
> > > > > > +
> > > > > > +static struct platform_driver xi3c_master_driver =3D {
> > > > > > +   .probe =3D xi3c_master_probe,
> > > > > > +   .remove =3D xi3c_master_remove,
> > > > > > +   .driver =3D {
> > > > > > +           .name =3D "axi-i3c-master",
> > > > > > +           .of_match_table =3D xi3c_master_of_ids,
> > > > > > +   },
> > > > > > +};
> > > > > > +module_platform_driver(xi3c_master_driver);
> > > > > > +
> > > > > > +MODULE_AUTHOR("Manikanta Guntupalli
> > > > > > +<manikanta.guntupalli@amd.com>"); MODULE_DESCRIPTION("AXI
> I3C
> > > > > > +master driver");
> > > > > MODULE_LICENSE("GPL");
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > >
> >
>

Thanks,
Manikanta.
