Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77830102D;
	Fri, 12 Sep 2025 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676343; cv=fail; b=ABFIqogA8qGQWsyE1o+0oPqaQ7LiccJRdH31T6D0JRiDOATTB61TnTCYu+XULP4Zy/ArtnpjeZX9//8zHsCy2igzYJRwJO/Zg4z765zKw2zKaamfQW9SucHTBOAyNPJ4JICCH5PvIv3ObSj7OqSraajtvKcj4TC1tsC4qC7g/qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676343; c=relaxed/simple;
	bh=0thVmV+5x9bTJhZcgJOrXFgAFYYxbh9GxxTjpG3ZGqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DuZCnAcZjrIxG5ivJZySi+nus80c69yVUVjZx0Gmx5l7VHxLzioylKPQL1GipED2GZ48U1Y7kFR7vIVK0Bl0NJUZADNHbt3IjKRHAZTJHPvFWj9kKxvUErI4kPCne7z5q0aTxsa+LuM5MdpoY4Vus6lbLzPs8b1g7cNVbPNQaK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EA0LxkeQ; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EA0LxkeQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xc3gwgL+N8IdPbjQGj1IXS2CuAPCMjVZZHAglWKXEFeu8rrJ1cUTSiOZofliQhHpBOe4UQ8t6mv+N9j2sva26XwvgwsLSmxDj63a2IawL7BSvrLBUuV0oOIsgscyVw9D1lR/VqIiNPJroBSA/UUs0UFLM6HiLlNhwP01/mQ6DRaOIiFqjBLpRXHem/LNyqHmmTWdQ1CamhU+D6JluEr7LGHXFf92Hmp3UTuvlt7IKIurYJQZQM0il98U6QsnIBoAKdDTmqMZH+ieL2lZQy8RWdYQwbRSChOeVws5gGGbWjBvarkRKJeR0/n2j+xanG1BJKowKJhhDCVSmw20FK6QXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGIZumPD4xA7836xf0FyCYFLg/9TG+TMmaVbds/pyWs=;
 b=yt+nOvS8W5cppI0qLaGesX1b4RNd5vqpqprzQNHy2owUoBi6EgNgxsU658pNVKrJZ+X9vGEq52O8iWiihaqtGC/WgGaLWeYopM9jSInUnAEOwelnv/qzxKWeJtxE0tccz1iB5iRwQu8Kh4TPfgDnXcES2EW9aHniawNAVEyEx8+0AIyo+DnwNxQDm0HpYhFH7u6ZzyEbJwMoqPAiClrLeUV2SLHUESzI1ajqeiDW5U4BXuX23AL/pX+Usu9RKLlc4NCPTB1hTgSFWcS4nR0u3n7lfKssvcquUQ4sF6VuH014lQUj9t2GSNMMNvKNpSDmltmr4DV3CVg//iTGMjW+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGIZumPD4xA7836xf0FyCYFLg/9TG+TMmaVbds/pyWs=;
 b=EA0LxkeQE65twRy29lNbhRA/QV4vc0+DoNw9xW6A9Na65XhJFuVVBV92gkMRp2nASvSVmFsIvXbMbO/wnWkXUGdljMTnwir4W0oWAp0RhyjKR2XP8wiF25OSbzMwD0V9EyVEfsfAk6vkL2neKbAml7YoeCXLU2ySqikqBzF8QAc=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 11:25:34 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 11:25:34 +0000
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
Thread-Index: AQHcIkZvn4aTq4cirkSmmfELS1IUxLSMotAAgADGrwCAALgFgIAA6baQgABff+A=
Date: Fri, 12 Sep 2025 11:25:33 +0000
Message-ID:
 <DM4PR12MB61099BA795FD6DA057DD08E58C08A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
 <20250910112954.553353-3-manikanta.guntupalli@amd.com>
 <aMGtdFxlXRanIAuM@lizhi-Precision-Tower-5810>
 <DM4PR12MB6109FB1956E8AC4979DFE85A8C09A@DM4PR12MB6109.namprd12.prod.outlook.com>
 <aMLufaWnrhPxVyxm@lizhi-Precision-Tower-5810>
 <DM4PR12MB61093B9BB9B3EF1D9F6B499E8C08A@DM4PR12MB6109.namprd12.prod.outlook.com>
In-Reply-To:
 <DM4PR12MB61093B9BB9B3EF1D9F6B499E8C08A@DM4PR12MB6109.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|CH0PR12MB8463:EE_
x-ms-office365-filtering-correlation-id: aed9f3bd-a960-406c-0837-08ddf1ef16d9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vd2CjiPNMlEQijvAtKfY3URIkUvV9AB9RNW+zBQHV9WKE54mp+Cyd9BPIi9Q?=
 =?us-ascii?Q?k2JuTYYYFYPCQ7K663fkjwc3onQ01FFvxgM5rUHCed2yl9pQPjKO/ySRhgyW?=
 =?us-ascii?Q?fWt21ui+dkADz9ex0YGZELhf3V8NUWmvTUFKbNs+FsRpTQNBic2EMOekrkup?=
 =?us-ascii?Q?gxAmWiDRqw39gWrDkfmLbj06ur3dqsZ9A5YOk7rvlKPiX1gEhjHmy9VU6Bv2?=
 =?us-ascii?Q?vcQtZKuCPdEcwpTb5uwoTjUePkn1ZUIEIZLcRVdaz3dlsIvZE9j4uOPJ7anF?=
 =?us-ascii?Q?+15G+hOruLGPlSQGZ9DMm8wUrRpz0T/4KxeGpDD5/FHND8rJaDFi6zHyNw5O?=
 =?us-ascii?Q?04hFZ+dOBoXRTKAd9mfxcZEY5ZdXwdmxglVPpPA8WPGaEZJva5y7ykL/WhcP?=
 =?us-ascii?Q?PVVEXOd8Qk/wRGrwbTVgMMnSRQyj3okfEaGxgJv0ab4lEFP1uCcUKZthuU6C?=
 =?us-ascii?Q?x5ieFnfSaaD/b3baZ3STjinfJwxcbYBA/2A5+R5+/Vvn8P1D2WON0FbxsrjB?=
 =?us-ascii?Q?wyZMBcY0+RSiMmChnW/G7beTxgIFz751P6ariwOIDyQ1/LCTORFSQ20XmJBB?=
 =?us-ascii?Q?3ukxDzrEF5T1DRhSIzasW1Boz6fbvAVAXFqjxear4sRD0A9RsbtsrY95JAbE?=
 =?us-ascii?Q?KZkgsSKTRJ5p/2YKXXayGsts9rIAQW3njgIjJi5TA2zsS1spiPua2QnGMgAh?=
 =?us-ascii?Q?QVnRYjIkYrT+ftRJrRTM5AdZBkunYcJIqab0yZP8926XsLCnpbHVLr8PoAFV?=
 =?us-ascii?Q?IZgIRZ13u7iH0LzrvJshCwfLNfqBahOOfqb8MoacGc3UTrVzxgyF6UPAFYyv?=
 =?us-ascii?Q?BnFwitOEjxeNVI25Y45IUCajICswTzIytf3jfCTD8Mn7PHSYx/Iaz1PQ6Uc2?=
 =?us-ascii?Q?3IA2Qk8GOV5+QG/u48/aIc/lipbXWPOZg11KmFZt6Jc2RclnxY85e8YLn+PL?=
 =?us-ascii?Q?velfE3SdvETSV/9rs6Rjttb34eT6eiPpRnohQno3wth40H590f2fqHvZzGSd?=
 =?us-ascii?Q?G5EVq3BotcOvsWP7cOYm1O0zOeGoXJTRw0J15GvLukL11oNeIuDy0lFg7pUY?=
 =?us-ascii?Q?PUi+zCcQAb6tYHwc5WBgEbDMDjCk04bOnT0DEfH5xw75GGsmUGJrVvka6mjU?=
 =?us-ascii?Q?XewDGMG/Gz5twASE+hG18glCNsNWks5xP3fG5d/ZKkTTSykkgpt3cMgYJTKO?=
 =?us-ascii?Q?4nX+Z4yVkRe2djYkAZIZBmYdHBiLqM5uIMFCD6CWzJ2demLlJy9edaBaDrCM?=
 =?us-ascii?Q?4h84b9gk1fKMLxkHpZexcxaR9wakAhmPNfdwvMb/yVMjJFUO68uTHLLZewWJ?=
 =?us-ascii?Q?MmwfiRQ5djWpxSVO0g1AwN690N5J+RwSS5CqK+rMpVhrF51f1ayziEjaY/z8?=
 =?us-ascii?Q?2qlwwWT+24KyjF2F8POj9wz8+X3vrGg1iZ9+Ijm9ujT22aiirjkh2w0o3eiB?=
 =?us-ascii?Q?IKP4npAFewI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4b+UG21++Lo5Ugt9HSih2vyvZkIcDjnNeLXzdgnTQSg7yIKLtKZmVynfO4X0?=
 =?us-ascii?Q?J4kwoaqqwMBR1G9bhsyso9+Yf9g9b567cmrOz/gOfPxIN79MREFJkMLy1xNS?=
 =?us-ascii?Q?KMH4iSMGwYq/teHDqEAwOcTysnQ0K4gy8OBix9X1Yn1Dlf/BQY3D0kZnAqPx?=
 =?us-ascii?Q?qWAj5j5Fw2tbhPlltQaZi5n2gsTUEcyYdqaICHxEVyDIlepTVbipAUoyWXpp?=
 =?us-ascii?Q?qi9h5V0i9ydHaPAySkQD9k49M8SPeubjsSGqx2CcQqGR5/K9w1vaPciCj2Fk?=
 =?us-ascii?Q?bu25XKOjOxVTVBCv5MzQQKakc75Z4YxkvKDPgJATZsAry3KP2FdY3a3w1sPE?=
 =?us-ascii?Q?j+YnqtZIMsnu1uAiAiSnW3Dz5msm3qwo6dX/YQqqbI9LOkteCbjlzRmtpfvB?=
 =?us-ascii?Q?Ihdslltx+aPFFGG6LTtd3f9NfR4GNUwKF2eoOji+QZbY9Ylqgb/H2WxV1wqo?=
 =?us-ascii?Q?lR2eoyL0clVBgYjBCX+3JRN69qbCwjJzmAcXL/JOfbq/x4UZ005CS6w6zNTf?=
 =?us-ascii?Q?G4XCjkqGTsyIKu2M5bOSzu4DtpYfFfqLqakwnJWl2h30JHtSg/fOMjx0f4gR?=
 =?us-ascii?Q?DiOeiLaePZ+nlTOgZ7OH1M4HWzTbAXqKQHYltelOiq898zHEGOZ4qvLS49SO?=
 =?us-ascii?Q?yw/W70YdClZhN6kXjpoCCcCmeMpQYN1qqdTZgys+XGony/Qg7eXn5FlI5VDx?=
 =?us-ascii?Q?StKLm1GfCBkA6QOTdLLuoQtS+q8J9y8d5F+Jw02MZtBrTcYlSxOTTtfSphMn?=
 =?us-ascii?Q?JBKZaIvgqBovdNu+s/yCxOU9AN+KSa2Z/IAHJZO9L+FRK1Eg/MU/S1m3kw9a?=
 =?us-ascii?Q?DqhMsyWDxcTxv1AXWlB04eEENlZlrfVJUMP7So03tlzjJhAno5swJvsoA3lX?=
 =?us-ascii?Q?Ek4US1ZmP/hbZZQJ06/Acylg5CBkUW3gBKP1N4O1VLOVeFGGK3YU9d7eQxCX?=
 =?us-ascii?Q?hjznOduZW0ObCTKil2frbdLfoDWZ/Gtok+i6h866TfN+EZgNiuFQzWvYipxM?=
 =?us-ascii?Q?gDAmzfJKFeziqNCicmLKTQRvOgwasb29CVlzY8WMedl1NEG4tMnk1Pl6UYxT?=
 =?us-ascii?Q?2sY8CN3rlaX+FqriTa95t1/H2cHgsKtxewSEyhcBDTjgY1hEjTYmShG1vvjL?=
 =?us-ascii?Q?MjlPxeD/MVKYsYLjIay5TO2urS3djnDi0fBwZiUDHAzfb7FoeXIeUFnancL5?=
 =?us-ascii?Q?V4qzyvZrNSrgLgHOkSIsMHVP4BxPlkXj+ej9HZRlytrxa7MpiRuZYQJXB91E?=
 =?us-ascii?Q?ytGK9zs5n6fl6LcUhRMCtgb2UJP4Hdeat7CcnguSQxUU97BT/tMxkHzBdDxe?=
 =?us-ascii?Q?tXVwLjKB+zCnZUG+Ghwi9MHr2F9ePpMyPtmZqWp01r7jW6iMX8daN3GuPiNQ?=
 =?us-ascii?Q?Yg/290BHdxEXQv29OyKG9ZvKXeHJFqNuz4bWVNg3NMVaaNIPuZH7zPJTHmtO?=
 =?us-ascii?Q?wc2OcNH05xHTlqcYL2QiRZDM2ypP9thW99BmNd991GLGRZ6ZkqlF52wFFX9E?=
 =?us-ascii?Q?fGcdPiKqnE0bw3pTtblLe1k/WHrJmVzjNia0NNPiTMcJxQbABk6cXcsM7/ar?=
 =?us-ascii?Q?8lRdTBjLDLjuf/RPNXk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aed9f3bd-a960-406c-0837-08ddf1ef16d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 11:25:33.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDapoCp3b78EvoN7x7pcvqwwQRESRgBB4MPT7HyRgn/RXaT2CD2y53l6FssL5GXkWYYQ8gpeBw5NXSP0zelNcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463

[Public]

Hi,

> -----Original Message-----
> From: Guntupalli, Manikanta
> Sent: Friday, September 12, 2025 11:25 AM
> To: Frank Li <Frank.li@nxp.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>;
> alexandre.belloni@bootlin.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> hardening@vger.kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> Subject: RE: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller drive=
r
>
> Hi,
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Thursday, September 11, 2025 9:15 PM
> > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > <michal.simek@amd.com>; alexandre.belloni@bootlin.com;
> > robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> > jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > hardening@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> > Subject: Re: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller
> > driver
> >
> > On Thu, Sep 11, 2025 at 06:07:59AM +0000, Guntupalli, Manikanta wrote:
> > > [Public]
> > >
> > > Hi,
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <Frank.li@nxp.com>
> > > > Sent: Wednesday, September 10, 2025 10:25 PM
> > > > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > > > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > > > <michal.simek@amd.com>; alexandre.belloni@bootlin.com;
> > > > robh@kernel.org; krzk+dt@kernel.org;
> > > > conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> > > > jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > > hardening@vger.kernel.org; Pandey, Radhey Shyam
> > > > <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> > > > <srinivas.goud@amd.com>; Datta, Shubhrajyoti
> > > > <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> > > > Subject: Re: [PATCH V6 2/2] i3c: master: Add AMD I3C bus
> > > > controller driver
> > > >
> > > > On Wed, Sep 10, 2025 at 04:59:54PM +0530, Manikanta Guntupalli wrot=
e:
> > > > > Add an I3C master driver and maintainers fragment for the AMD
> > > > > I3C bus controller.
> > > > >
> > > > > The driver currently supports the I3C bus operating in SDR i3c
> > > > > mode, with features including Dynamic Address Assignment,
> > > > > private data transfers, and CCC transfers in both broadcast and
> > > > > direct modes. It also supports operation in I2C mode.
> > > > >
> > > > > Signed-off-by: Manikanta Guntupalli
> > > > > <manikanta.guntupalli@amd.com>
> > > > > ---
> > > > > Changes for V2:
> > > > > Updated commit description.
> > > > > Added mixed mode support with clock configuration.
> > > > > Converted smaller functions into inline functions.
> > > > > Used FIELD_GET() in xi3c_get_response().
> > > > > Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
> > > > > Used parity8() for address parity calculation.
> > > > > Added guards for locks.
> > > > > Dropped num_targets and updated xi3c_master_do_daa().
> > > > > Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
> > > > > Dropped PM runtime support.
> > > > > Updated xi3c_master_read() and xi3c_master_write() with
> > > > > xi3c_is_resp_available() check.
> > > > > Created separate functions: xi3c_master_init() and xi3c_master_re=
init().
> > > > > Used xi3c_master_init() in bus initialization and
> > > > > xi3c_master_reinit() in error paths.
> > > > > Added DAA structure to xi3c_master structure.
> > > > >
> > > > > Changes for V3:
> > > > > Resolved merge conflicts.
> > > > >
> > > > > Changes for V4:
> > > > > Updated timeout macros.
> > > > > Removed type casting for xi3c_is_resp_available() macro.
> > > > > Used ioread32() and iowrite32() instead of readl() and writel()
> > > > > to keep consistency.
> > > > > Read XI3C_RESET_OFFSET reg before udelay().
> > > > > Removed xi3c_master_free_xfer() and directly used kfree().
> > > > > Skipped checking return value of i3c_master_add_i3c_dev_locked().
> > > > > Used devm_mutex_init() instead of mutex_init().
> > > > >
> > > > > Changes for V5:
> > > > > Used GENMASK_ULL for PID mask as it's 64bit mask.
> > > > >
> > > > > Changes for V6:
> > > > > Removed typecast for xi3c_getrevisionnumber(),
> > > > > xi3c_wrfifolevel(), and xi3c_rdfifolevel().
> > > > > Replaced dynamic allocation with a static variable for pid_bcr_dc=
r.
> > > > > Fixed sparse warning in do_daa by typecasting the address parity
> > > > > value to u8.
> > > > > Fixed sparse warning in xi3c_master_bus_init by typecasting the
> > > > > pid value to u64 in info.pid calculation.
> > > > > ---
> > > > >  MAINTAINERS                         |    7 +
> > > > >  drivers/i3c/master/Kconfig          |   16 +
> > > > >  drivers/i3c/master/Makefile         |    1 +
> > > > >  drivers/i3c/master/amd-i3c-master.c | 1009
> > > > > +++++++++++++++++++++++++++
> > > > >  4 files changed, 1033 insertions(+)  create mode 100644
> > > > > drivers/i3c/master/amd-i3c-master.c
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > > > 1af81124bba3..ff603ce5e78d 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -11693,6 +11693,13 @@ L: linux-i2c@vger.kernel.org
> > > > >  S: Maintained
> > > > >  F: drivers/i2c/i2c-stub.c
> > > > >
> > > > > +I3C DRIVER FOR AMD AXI I3C MASTER
> > > > > +M: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > > > > +R: Michal Simek <michal.simek@amd.com>
> > > > > +S: Maintained
> > > > > +F: Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> > > > > +F: drivers/i3c/master/amd-i3c-master.c
> > > > > +
> > > > >  I3C DRIVER FOR ASPEED AST2600
> > > > >  M: Jeremy Kerr <jk@codeconstruct.com.au>
> > > > >  S: Maintained
> > > > > diff --git a/drivers/i3c/master/Kconfig
> > > > > b/drivers/i3c/master/Kconfig index 13df2944f2ec..4b884a678893
> > > > > 100644
> > > > > --- a/drivers/i3c/master/Kconfig
> > > > > +++ b/drivers/i3c/master/Kconfig
> > > > > @@ -1,4 +1,20 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > > +
> > > > > +config AMD_I3C_MASTER
> > > > > +   tristate "AMD I3C Master driver"
> > > > > +   depends on I3C
> > > > > +   depends on HAS_IOMEM
> > > > > +   help
> > > > > +     Support for AMD I3C Master Controller.
> > > > > +
> > > > > +     This driver allows communication with I3C devices using the=
 AMD
> > > > > +     I3C master, currently supporting Standard Data Rate (SDR) m=
ode.
> > > > > +     Features include Dynamic Address Assignment, private transf=
ers,
> > > > > +     and CCC transfers in both broadcast and direct modes.
> > > > > +
> > > > > +     This driver can also be built as a module.  If so, the modu=
le
> > > > > +     will be called amd-i3c-master.
> > > > > +
> > > > >  config CDNS_I3C_MASTER
> > > > >     tristate "Cadence I3C master driver"
> > > > >     depends on HAS_IOMEM
> > > > > diff --git a/drivers/i3c/master/Makefile
> > > > > b/drivers/i3c/master/Makefile index aac74f3e3851..109bd48cb159
> > > > > 100644
> > > > > --- a/drivers/i3c/master/Makefile
> > > > > +++ b/drivers/i3c/master/Makefile
> > > > > @@ -1,4 +1,5 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > > +obj-$(CONFIG_AMD_I3C_MASTER)               +=3D amd-i3c-master.o
> > > > >  obj-$(CONFIG_CDNS_I3C_MASTER)              +=3D i3c-master-cdns.=
o
> > > > >  obj-$(CONFIG_DW_I3C_MASTER)                +=3D dw-i3c-master.o
> > > > >  obj-$(CONFIG_AST2600_I3C_MASTER)   +=3D ast2600-i3c-master.o
> > > > > diff --git a/drivers/i3c/master/amd-i3c-master.c
> > > > > b/drivers/i3c/master/amd-i3c-master.c
> > > > > new file mode 100644
> > > > > index 000000000000..cd9d85a0be80
> > > > > --- /dev/null
> > > > > +++ b/drivers/i3c/master/amd-i3c-master.c
> > > > > @@ -0,0 +1,1009 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * I3C master driver for the AMD I3C controller.
> > > > > + *
> > > > > + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> > > > > + */
> > > > > +
> > > > ...
> > > > > +
> > > > > +/* timeout waiting for the controller finish transfers */
> > > > > +#define XI3C_XFER_TIMEOUT_MS                       10000
> > > > > +#define XI3C_XFER_TIMEOUT
> > > >       (msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))
> > > >
> > > > Do I missed your reply? I have not seen
> > > > https://lore.kernel.org/linux-i3c/aL7+Urm4NB9kwOwQ@lizhi-Precision
> > > > -T
> > > > ower-5810/
> > > >
> > > > If you need define two macro for it. Need unit
> > > > XI3C_XFER_TIMEOUT_JIFFIES to avoid confuse.
> > > Sure, I'll update the macro name to XI3C_XFER_TIMEOUT_JIFFIES to
> > > avoid
> > confusion.
> > > >
> > > >
> > > > > +
> > > > > +#define xi3c_getrevisionnumber(master)                          =
                   \
> > > > > +   (FIELD_GET(XI3C_REV_NUM_MASK,
> > > >       \
> > > > > +              ioread32((master)->membase +
> > > > > + XI3C_VERSION_OFFSET)))
> > > > > +
> > > >
> > > > ...
> > > >
> > > > > +static void xi3c_master_wr_to_tx_fifo(struct xi3c_master *master=
,
> > > > > +                                 struct xi3c_cmd *cmd) {
> > > > > +   u8 *tx_buf =3D (u8 *)cmd->tx_buf;
> > > > > +   u32 data =3D 0;
> > > > > +   u16 len;
> > > > > +
> > > > > +   len =3D cmd->tx_len;
> > > > > +   if (len > 0) {
> > > > > +           len =3D (len >=3D XI3C_WORD_LEN) ? XI3C_WORD_LEN : le=
n;
> > > > > +           memcpy(&data, tx_buf, len);
> > > > > +           tx_buf +=3D len;
> > > > > +           cmd->tx_len -=3D len;
> > > > > +   }
> > > > > +   cmd->tx_buf =3D tx_buf;
> > > > > +
> > > > > +   /* Write the 32-bit value to the Tx FIFO */
> > > > > +   iowrite32be(data, master->membase + XI3C_WR_FIFO_OFFSET); }
> > > >
> > > > i3c_writel(readl)_fifo() did similar things, why not use it?
> > > >
> > > > Did you miss my review comment or I missed your reply?
> > > You have missed my earlier reply on this.
> > > The helpers i3c_writel_fifo() and i3c_readl_fifo() rely on the CPU's
> > > native endianness, whereas in this case the FIFO should always be
> > > accessed in
> > big-endian format.
> > > Hence, we cannot use the common helpers directly.
> > >
> > > For reference, here's my previous reply:
> > >
> >
> https://lore.kernel.org/all/DM4PR12MB6109F6D5D032723C675472448C0FA@DM4
> > > PR12MB6109.namprd12.prod.outlook.com/
> >
> > Sorry, can you improve i3c_writel(readl)_fifo() to support endianness?
> > I think not only you have this kind problem in future.
> Sure, will add support for endianness.
To add support for endianness, we could not find a big-endian counterpart t=
o writesl().
Please let me know if I missed any existing helper.
> >
> > >
> > > >
> > > > ...
> > > > > +
> > > > > +static const struct of_device_id xi3c_master_of_ids[] =3D {
> > > > > +   { .compatible =3D "xlnx,axi-i3c-1.0" },
> > > > > +   { },
> > > > > +};
> > > > > +
> > > > > +static struct platform_driver xi3c_master_driver =3D {
> > > > > +   .probe =3D xi3c_master_probe,
> > > > > +   .remove =3D xi3c_master_remove,
> > > > > +   .driver =3D {
> > > > > +           .name =3D "axi-i3c-master",
> > > > > +           .of_match_table =3D xi3c_master_of_ids,
> > > > > +   },
> > > > > +};
> > > > > +module_platform_driver(xi3c_master_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Manikanta Guntupalli
> > > > > +<manikanta.guntupalli@amd.com>"); MODULE_DESCRIPTION("AXI I3C
> > > > > +master driver");
> > > > MODULE_LICENSE("GPL");
> > > > > --
> > > > > 2.34.1
> > > > >
> > >
>

Thanks,
Manikanta.
