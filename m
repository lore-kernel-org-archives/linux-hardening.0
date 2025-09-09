Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7131B806;
	Tue,  9 Sep 2025 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415013; cv=fail; b=XUB+Dkm6PYeNz9wF44qyalfK5h+5ztGAaJf1A0R5TnVwIKXzXSFptYfB8cnsV/LKBp7CT0MqWLkhqcrOR0wtfv+rvoFk0/UYCQVq7yosTgmuYHw3qGBdL9J3ysSnAH3VxQkoM/mU4MdikYyTrFkj9zN9vDWVrYs4Q8XlqL0ouy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415013; c=relaxed/simple;
	bh=ytke2R4le/YNNRp98hgypGDkJY9iNUnjYWT+xNCSRO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P3ScCHHQj9oL7555EcXUQ0QWbhmTXSOci7smjyAIgZB0pS0pZZyH9oTkPJGelr4EUGAq7sEHv4K5h71K9qZA2+wTY+WksPc5gUfIw5WEgnplbfGCvNNwrsT2LfCq/TdUIzxR/g2TdgR8D16ojdQXBORrn1dC2L/pSDTMvFWLfa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qzr0bxKB; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qzr0bxKB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kk3xdtAr63u/3X5fiNFJLcthhoSDBn2FW0Q7YfMvRBUaSl7NUubsBO1/FA9kY16lPTkHcVWj7tW7qWL9t8rolenVD/c1rl8xqj/m4tl2k6/u+JT2gCzvMOm4DGBa2zMrxb8MDm2mAG9G/XYwpZ+EkzCbz5gK5uDK7NNFxWEzGWAc+n0g/owMwqmJl3wVWYj4NYUWef2RLuDWMyLRmR5gDUI31+f/ITWTggNgz1TCi4XWKqe7a34MslfTiqmYYv7J4moLWLC6ULnFteDKel0dY67jldY/4uMHIyhvZXSlicLEK1Y9ivl1Xu6GcgUlIAIWCrJWcEp/Ty/0afjdkVW7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE4GTf6NnJ/P5WXIMpSjGUxeR6ZfY7R09jg1BC8SBsY=;
 b=sgOlaMZmjmNvGRtY7Kael+8UvHQObbxl/DEPciZef8UnC/lty8Bilu/oWSfp6Ft6PbN6w4raLn8930Ef+70ahQ4Uz4g6aXL130W3XrmvPQAc0Z3p+hoZ/o7werS9WYkVpp1K18ZdF0Dpc2vzxgZA2E1N6a7VRJ9uaWQZekKNjR8+bcn7cXWdnEhNDWQT8FhktqPaRf3AyGqXiJ/jQzK6fXojvXHrKLhd0/cjQR7qqr34llmCsoJ3dd3wN+/OupCp4NGkaS7QNnUBGP7zUK8+wChdReWZ6ztnxP+X+e4bhINxQpc8dB0kTJFCEan8GMmwXKtKrUeGMEZYu2P6TwAIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE4GTf6NnJ/P5WXIMpSjGUxeR6ZfY7R09jg1BC8SBsY=;
 b=Qzr0bxKBfUuhH8v/y7h5jojJNV1JohXbQiaCYAgqBU4tFgUqaq59d96N61BMyfCkftgGuZsUMs0JF0xxWr5wNfGrybZC8nxpakGnN3bPsWONR1zu3nwpV4pttQdiL1WFJ2n9JEsv8zc28/24WSCy9S6/Uf7u4Loxek/69NgA8a8=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 10:50:02 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:50:02 +0000
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
Subject: RE: [PATCH V5 2/2] i3c: master: Add AMD I3C bus controller driver
Thread-Topic: [PATCH V5 2/2] i3c: master: Add AMD I3C bus controller driver
Thread-Index: AQHcILLYmOX0ONeXB06A2TueGw6CyLSJctcAgAD0bfA=
Date: Tue, 9 Sep 2025 10:50:02 +0000
Message-ID:
 <DM4PR12MB6109F6D5D032723C675472448C0FA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250908112117.205270-1-manikanta.guntupalli@amd.com>
 <20250908112117.205270-3-manikanta.guntupalli@amd.com>
 <aL7+Urm4NB9kwOwQ@lizhi-Precision-Tower-5810>
In-Reply-To: <aL7+Urm4NB9kwOwQ@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-09T06:39:09.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|PH7PR12MB5902:EE_
x-ms-office365-filtering-correlation-id: 2a1e7abc-c1ff-484b-4ed5-08ddef8ea0f7
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dn846sZSdgCOtD5tHtKS5BQRv8sCjcaGGr3MtICL6NexW7WeKG5xIul+S5P/?=
 =?us-ascii?Q?On/rg66B+cexf3O1rrXqS7MbIOASdcHgGVAj3s2V1tDwET72g0N/Cb1UOcjZ?=
 =?us-ascii?Q?3mEb00H9V3zBL7KV39M3ik1kWTtEmpQ0REbU93cnEI/uOz51KpJeAm5thwWJ?=
 =?us-ascii?Q?atPK1hkVfG2z5fhr7/hV2uRuLVVPZ2Z4mBTP/uY1XYNlyVuM03iIaVnhpk5f?=
 =?us-ascii?Q?8FhvLCuGog32y3Bf4iM1d9K1rW6zne+R8rE13FpWmwGhnX5KkosV+5c0ik8O?=
 =?us-ascii?Q?jm0/XKkTyp3eSLxdlbx+KgBx06IRvH9kIYKHSwdKtz9dMzJwFefUsVeuoUz/?=
 =?us-ascii?Q?WZlYDvAqhleMbSaiadhot0OROH9YPIZ6MQEy1hivUqGQARE9tQmr5m0YxHgK?=
 =?us-ascii?Q?rxCgtr/wGfwdMkByJrXORMqopsXGsri1Qn+LztVmV6zRUfPoVOouNMQh1Dpz?=
 =?us-ascii?Q?NfzM2xPTOeUUkItx69GDiK8ZZZXTDxwdWU+6APcjDRvHP/kVfoefJXQUPEmB?=
 =?us-ascii?Q?aa1VUnadsiaMDi3qkOfquHgcfGH5TXX0qRbQm/A2AYbuIi2du6luv0+wQsRA?=
 =?us-ascii?Q?MHgLOdNeM1/2HQpPWaV784S4yYIlTtiCSmRxOFaY4/NkpsIaHtAfIruO3Xdz?=
 =?us-ascii?Q?yBo/EwO98pXhew78Cs778yI0kH+ffVkiC9ByeWGvhH/CU3kP0heoPuerbF3a?=
 =?us-ascii?Q?rL6Urjayf8/KdShc8ipa/v2vFzpVzsjBlRuT0vunXcB6udhE5zIeco03WZ/3?=
 =?us-ascii?Q?LqeN2sr2XvXechN3a3XmpCrW3MaqW7gRbfQiRVBSP/R5fc+62rjk0TZ1PdQO?=
 =?us-ascii?Q?v+6S2jshR+xWea24FAIAHgKoshJPemDkGB265Jpu/UeRtYF+8jzsgkw0fZiF?=
 =?us-ascii?Q?zFgoCMInUnytAhzy91wxSvBZ1f86tXev6TotJJH1tJ9Pu1SqU1JjLR8K4ADx?=
 =?us-ascii?Q?At15b1dBlr/pO2tp/lbGa6glJpqdzORS6rYvSUxMp/XO6/NBelnjq4zGXaTU?=
 =?us-ascii?Q?treOiTHXH0OTaiV1Woqzh4l6J3a61Y3wOAmaFELc0oRzsNh5uBaaUIcnzeRf?=
 =?us-ascii?Q?SZ2UrkORMvwPZWMIne3D2GRkm80FsmSoezx1M3LE5zJGOdj5rcWAFG37jEl2?=
 =?us-ascii?Q?9XfTZx28K9QSwaP7mzxHJaVKxty1r9MZTn5bN9AWtA0HOzTAWFcHoqhHN9op?=
 =?us-ascii?Q?/45WAavLelH0ATw9et81/szh5n/sOcC+4kh6TI5PiT1QgcI89ISNAfg+jB+l?=
 =?us-ascii?Q?rNCJ8gx2j2qM19JNNL279JfCThtgEO+ue4xo4zI5NtH8BRcNFUJnHATDYaho?=
 =?us-ascii?Q?wT+tHVeKyI1qUl3nH1sg8OiWPrSQE5xrPVjJp4jmgkXrweecRNtwbMlIffqE?=
 =?us-ascii?Q?S/hcbaxWXHgVebkryXXu6tk3uEFOqDf9kJIlveVrxV22KNtEugSq0hCT0Bur?=
 =?us-ascii?Q?HQLjk595CvzvQoSO27VvX6O0obhWsVJMSSHihWyAgt6WYwKHeGKpig=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gs4SFhCwiRBPB3wrPiui4hUUX7QkZqka+B94JtHnmV2ji/UFhDdZeGv9OLgv?=
 =?us-ascii?Q?wfcoUfETSmJJYSFrF1KrTrnL7CMyNNbkPTfRnPhfL2VH0gsE/SfjQvRZWG0Z?=
 =?us-ascii?Q?vChu0NZ9YxAw4flxPuPIEuzejmusOkG3aL3hnLhGVnM9eMo/lwzl5RefEX07?=
 =?us-ascii?Q?HLJUxfglIHihV+5b+Y11TWBQUDh7EkRRcWlp+6RtURaqCH0VfWDh+9w3VOOb?=
 =?us-ascii?Q?b85OlK0qC2UFhy2280csjTNxBKbLuUv7e8o/7vNPYyhE36mI7QWlG8qNSXSl?=
 =?us-ascii?Q?jeZVv4VKxojztXEAoDpc+WlUdDpS+vdXQKh0gVcqdGt2LTnI9+PMALgeEyuu?=
 =?us-ascii?Q?Sj/AJDUkcnxLB3wuqJbqz9dmCmqhRdkJBIZoZXzkM4d5JT5qdfT+lFtYGiDq?=
 =?us-ascii?Q?qG33K63R7VNllsWs/KJ//fb6zUBOaxGO0Np+pBQDSplEsQRNCix1BrzwiXcu?=
 =?us-ascii?Q?vBqTrOBsiMwaNU6FWWi0BmDOLBOPuQEVqlGy4cg15wJBIuCStr3BG3TwW08W?=
 =?us-ascii?Q?Jxdti/9YhFsu2+ePLoOsDxPN7GWrDt2YwsRpWF5Fdiv7UAzjrxq8lRqNMB4f?=
 =?us-ascii?Q?nUDOmaaM1ssiBIkkdeI/hkZOnl/Dc4FqKIAR6H1AjflNWUZUeOPJDO8WxZrM?=
 =?us-ascii?Q?jqZ5QZIHGYEogjOWeuCRCMA77MSEHrKx1i5jKouHWjoUPd5URANPm/fSm8w/?=
 =?us-ascii?Q?lq1iIiOFJVV9edDjxN1MkkvGdM1TgQFx6dckgiA7HbzEgNyZHfHw5KaXunRB?=
 =?us-ascii?Q?+eJr1i/KbtOAd8iI1PrmojYMa4FTSVP5e7sM81nUq7tCUocW4IPVPHHs6IW2?=
 =?us-ascii?Q?SJv8mRRL/AuSfz6YyKWKjOuqlWAS944kM54nOBqQmissbtZIpSklPxKd6oRt?=
 =?us-ascii?Q?Z2HfP7Q2ljGQND8T0RqFADsXLm3DzPlGV+CzmxcL2XELtcGNYVJpWY9jXvhE?=
 =?us-ascii?Q?Id5q7LGnUHVtlvKIwE8XYSu7DMK8BFZbkdW6yiX3MJPdw8IL+OVkBj8nCouo?=
 =?us-ascii?Q?KmmlBpS8m1ddCnTbvw9wXApCaAKPgMDy8q2uuplvMzORBgjvEVcddhRGRBtb?=
 =?us-ascii?Q?3K9I2FdUTwsYbCKmpHhjrOn/XF16gZi8xgOo+ZqT3J3R1uR4MaxovLCl+Rn9?=
 =?us-ascii?Q?USu7zNxRJXQoOW6NP9pP04wufRh0NTN/KfAxhg33QF0lkku/1tflU6rjZW4j?=
 =?us-ascii?Q?uqiRtpjUy+vgLar9iSYmgawVjMKrZQDPNVY3HFQQKlkaQjtbmUedEME8w3Gf?=
 =?us-ascii?Q?kqXJ5K9gX/Qd6p4zSzEAL79dudZZBHkHBJeoBt7Q0FKQq4duQqs0P5Qln5Mi?=
 =?us-ascii?Q?k1aES9kuMZAjz2ytblTc+M/4m+Sig1ZFwmYOPM9vQPoSD8FtNdzd5b2Ccp7L?=
 =?us-ascii?Q?KkEznB4H2P3gVSw2HsF7ohQgpFv1TzBDYBx2yit8NJ52s4bM9+Ys6EFZa/5S?=
 =?us-ascii?Q?XdRGdZOS5igNhvsSLKCH5cbW0RnsiwCYrwo770Iezqbctj1UVzT6iqv8/6cN?=
 =?us-ascii?Q?GtZTh5wr7MLq+4xRas/2+84rLQgApTi4CSOJc/WqjIEIkizxCn2wVfXFIgYq?=
 =?us-ascii?Q?FQShYPMuqPAHwnrDIiA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1e7abc-c1ff-484b-4ed5-08ddef8ea0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 10:50:02.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XWi//d9Ey0Dy2ZzInkSck6oqev7danD5laJh0/VJ6OTVCfN/DZ4RQCcIS7M5edLeYVraP6LWTaqzwkPKe6Rjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902

[Public]

Hi,

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Monday, September 8, 2025 9:34 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>;
> alexandre.belloni@bootlin.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> hardening@vger.kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> Subject: Re: [PATCH V5 2/2] i3c: master: Add AMD I3C bus controller drive=
r
>
> On Mon, Sep 08, 2025 at 04:51:17PM +0530, Manikanta Guntupalli wrote:
> > Add an I3C master driver and maintainers fragment for the AMD I3C bus
> > controller.
> >
> > The driver currently supports the I3C bus operating in SDR i3c mode,
> > with features including Dynamic Address Assignment, private data
> > transfers, and CCC transfers in both broadcast and direct modes. It
> > also supports operation in I2C mode.
> >
> > Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > ---
> > Changes for V2:
> > Updated commit description.
> > Added mixed mode support with clock configuration.
> > Converted smaller functions into inline functions.
> > Used FIELD_GET() in xi3c_get_response().
> > Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
> > Used parity8() for address parity calculation.
> > Added guards for locks.
> > Dropped num_targets and updated xi3c_master_do_daa().
> > Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
> > Dropped PM runtime support.
> > Updated xi3c_master_read() and xi3c_master_write() with
> > xi3c_is_resp_available() check.
> > Created separate functions: xi3c_master_init() and xi3c_master_reinit()=
.
> > Used xi3c_master_init() in bus initialization and xi3c_master_reinit()
> > in error paths.
> > Added DAA structure to xi3c_master structure.
> >
> > Changes for V3:
> > Resolved merge conflicts.
> >
> > Changes for V4:
> > Updated timeout macros.
> > Removed type casting for xi3c_is_resp_available() macro.
> > Used ioread32() and iowrite32() instead of readl() and writel() to
> > keep consistency.
> > Read XI3C_RESET_OFFSET reg before udelay().
> > Removed xi3c_master_free_xfer() and directly used kfree().
> > Skipped checking return value of i3c_master_add_i3c_dev_locked().
> > Used devm_mutex_init() instead of mutex_init().
> >
> > Changes for V5:
> > Used GENMASK_ULL for PID mask as it's 64bit mask.
> > ---
> >  MAINTAINERS                         |    7 +
> >  drivers/i3c/master/Kconfig          |   16 +
> >  drivers/i3c/master/Makefile         |    1 +
> >  drivers/i3c/master/amd-i3c-master.c | 1014
> > +++++++++++++++++++++++++++
> >  4 files changed, 1038 insertions(+)
> >  create mode 100644 drivers/i3c/master/amd-i3c-master.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 1af81124bba3..ff603ce5e78d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11693,6 +11693,13 @@ L: linux-i2c@vger.kernel.org
> >  S: Maintained
> >  F: drivers/i2c/i2c-stub.c
> >
> > +I3C DRIVER FOR AMD AXI I3C MASTER
> > +M: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > +R: Michal Simek <michal.simek@amd.com>
> > +S: Maintained
> > +F: Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> > +F: drivers/i3c/master/amd-i3c-master.c
> > +
> >  I3C DRIVER FOR ASPEED AST2600
> >  M: Jeremy Kerr <jk@codeconstruct.com.au>
> >  S: Maintained
> > diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> > index 13df2944f2ec..4b884a678893 100644
> > --- a/drivers/i3c/master/Kconfig
> > +++ b/drivers/i3c/master/Kconfig
> > @@ -1,4 +1,20 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config AMD_I3C_MASTER
> > +   tristate "AMD I3C Master driver"
> > +   depends on I3C
> > +   depends on HAS_IOMEM
> > +   help
> > +     Support for AMD I3C Master Controller.
> > +
> > +     This driver allows communication with I3C devices using the AMD
> > +     I3C master, currently supporting Standard Data Rate (SDR) mode.
> > +     Features include Dynamic Address Assignment, private transfers,
> > +     and CCC transfers in both broadcast and direct modes.
> > +
> > +     This driver can also be built as a module.  If so, the module
> > +     will be called amd-i3c-master.
> > +
> >  config CDNS_I3C_MASTER
> >     tristate "Cadence I3C master driver"
> >     depends on HAS_IOMEM
> > diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> > index aac74f3e3851..109bd48cb159 100644
> > --- a/drivers/i3c/master/Makefile
> > +++ b/drivers/i3c/master/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_AMD_I3C_MASTER)               +=3D amd-i3c-master.o
> >  obj-$(CONFIG_CDNS_I3C_MASTER)              +=3D i3c-master-cdns.o
> >  obj-$(CONFIG_DW_I3C_MASTER)                +=3D dw-i3c-master.o
> >  obj-$(CONFIG_AST2600_I3C_MASTER)   +=3D ast2600-i3c-master.o
> > diff --git a/drivers/i3c/master/amd-i3c-master.c
> > b/drivers/i3c/master/amd-i3c-master.c
> > new file mode 100644
> > index 000000000000..fb768680df45
> > --- /dev/null
> > +++ b/drivers/i3c/master/amd-i3c-master.c
> ...
> > +/* timeout waiting for the controller finish transfers */
> > +#define XI3C_XFER_TIMEOUT_MS                       10000
> > +#define XI3C_XFER_TIMEOUT
>       (msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))
>
> XI3C_XFER_TIMEOUT is not used.
XI3C_XFER_TIMEOUT is used in xi3c_master_read() and xi3c_master_write().
Please check.
>
> > +
> > +#define xi3c_getrevisionnumber(master)                                =
             \
> > +   ((u8)(FIELD_GET(XI3C_REV_NUM_MASK,                                 =
     \
> > +                   ioread32((master)->membase + XI3C_VERSION_OFFSET)))=
)
> > +
> > +#define xi3c_wrfifolevel(master)                                      =
     \
> > +   ((u16)(ioread32((master)->membase + XI3C_FIFO_LVL_STATUS_OFFSET)
> &     \
> > +          XI3C_WR_FIFO_LEVEL_MASK))
> > +
> > +#define xi3c_rdfifolevel(master)                                      =
     \
> > +   ((u16)(ioread32((master)->membase +
> XI3C_FIFO_LVL_STATUS_1_OFFSET) &      \
> > +          XI3C_WR_FIFO_LEVEL_MASK))
>
> Are you sure that these force type convert is neccesary?
We will fix.
>
> > +
> > +#define xi3c_is_resp_available(master)                                =
             \
> > +   (FIELD_GET(XI3C_SR_RESP_NOT_EMPTY_MASK,
>               \
> > +              ioread32((master)->membase + XI3C_SR_OFFSET)))
> > +
> > +struct xi3c_cmd {
> > +   void *tx_buf;
> > +   void *rx_buf;
> > +   u16 tx_len;
> > +   u16 rx_len;
> > +   u8 addr;
> > +   u8 type;
> > +   u8 tid;
> > +   bool rnw;
> > +   bool is_daa;
> > +   bool continued;
> > +};
> > +
> > +struct xi3c_xfer {
> > +   struct list_head node;
> > +   struct completion comp;
> > +   int ret;
> > +   unsigned int ncmds;
> > +   struct xi3c_cmd cmds[] __counted_by(ncmds); };
> > +
> ...
> > +
> > +static int xi3c_master_write(struct xi3c_master *master, struct
> > +xi3c_cmd *cmd) {
> > +   unsigned long timeout;
> > +   u16 wrfifo_space;
> > +   u16 space_index;
> > +   u16 len;
> > +
> > +   len =3D cmd->tx_len;
> > +   if (!cmd->tx_buf || cmd->tx_len > XI3C_MAXDATA_LENGTH)
> > +           return -EINVAL;
> > +
> > +   /* Fill Tx fifo */
> > +   wrfifo_space =3D xi3c_wrfifolevel(master);
> > +   for (space_index =3D 0; space_index < wrfifo_space && cmd->tx_len >=
 0;
> > +        space_index++)
> > +           xi3c_master_wr_to_tx_fifo(master, cmd);
>
> Does common helper function i3c_writel_fifo() help this? look like logic =
is similar.
No. The functions i3c_writel_fifo() and i3c_readl_fifo() operate using the =
CPU's native endianness.
In this case, the FIFO should always be accessed in big-endian format.
Therefore, we cannot use these common helpers directly.
>
> > +
> > +   /* Write to command fifo */
> > +   xi3c_master_write_to_cmdfifo(master, cmd, len);
> > +
> > +   timeout =3D jiffies + XI3C_XFER_TIMEOUT;
> > +   /* Fill if any remaining data to tx fifo */
> > +   while (cmd->tx_len > 0 && !xi3c_is_resp_available(master)) {
> > +           if (time_after(jiffies, timeout)) {
> > +                   dev_err(master->dev, "XI3C write timeout\n");
> > +                   return -EIO;
> > +           }
> > +
> > +           wrfifo_space =3D xi3c_wrfifolevel(master);
> > +           for (space_index =3D 0; space_index < wrfifo_space && cmd->=
tx_len >
> 0;
> > +                space_index++)
> > +                   xi3c_master_wr_to_tx_fifo(master, cmd);
> > +   }
> > +   return 0;
> > +}
> > +
> ...
> > +
> > +static int xi3c_master_do_daa(struct i3c_master_controller *m) {
> > +   struct xi3c_master *master =3D to_xi3c_master(m);
> > +   struct xi3c_cmd *daa_cmd;
> > +   struct xi3c_xfer *xfer;
> > +   u8 pid_bufs[XI3C_MAX_DEVS][8];
> > +   u8 data, last_addr =3D 0;
> > +   int addr, ret, i;
> > +   u8 *pid_buf;
> > +
> > +   u64 *pid_bcr_dcr __free(kfree) =3D kcalloc(XI3C_MAX_DEVS, sizeof(u6=
4),
> > +                                            GFP_KERNEL);
> > +   if (!pid_bcr_dcr)
> > +           return -ENOMEM;
> > +
> > +   xfer =3D xi3c_master_alloc_xfer(master, 1);
> > +   if (!xfer) {
> > +           ret =3D -ENOMEM;
> > +           goto err_daa_mem;
> > +   }
> > +
> > +   for (i =3D 0; i < XI3C_MAX_DEVS; i++) {
> > +           addr =3D i3c_master_get_free_addr(m, last_addr + 1);
> > +           if (addr < 0) {
> > +                   ret =3D -ENOSPC;
> > +                   goto err_daa;
> > +           }
> > +           master->daa.addrs[i] =3D (u8)addr;
> > +           last_addr =3D (u8)addr;
> > +   }
> > +
> > +   /* Fill ENTDAA CCC */
> > +   data =3D I3C_CCC_ENTDAA;
> > +   daa_cmd =3D &xfer->cmds[0];
> > +   daa_cmd->addr =3D I3C_BROADCAST_ADDR;
> > +   daa_cmd->rnw =3D 0;
> > +   daa_cmd->tx_buf =3D &data;
> > +   daa_cmd->tx_len =3D 1;
> > +   daa_cmd->type =3D XI3C_SDR_MODE;
> > +   daa_cmd->tid =3D XI3C_SDR_TID;
> > +   daa_cmd->continued =3D true;
> > +
> > +   ret =3D xi3c_master_common_xfer(master, xfer);
> > +   /* DAA always finishes with CE2_ERROR or NACK_RESP */
> > +   if (ret && ret !=3D I3C_ERROR_M2) {
> > +           goto err_daa;
> > +   } else {
> > +           if (ret && ret =3D=3D I3C_ERROR_M2) {
> > +                   ret =3D 0;
> > +                   goto err_daa;
> > +           }
> > +   }
> > +
> > +   master->daa.index =3D 0;
> > +
> > +   while (true) {
> > +           struct xi3c_cmd *cmd =3D &xfer->cmds[0];
> > +
> > +           pid_buf =3D pid_bufs[master->daa.index];
> > +           addr =3D (master->daa.addrs[master->daa.index] << 1) |
> > +                  (!parity8(master->daa.addrs[master->daa.index]));
> > +
> > +           cmd->tx_buf =3D (u8 *)&addr;
> > +           cmd->tx_len =3D 1;
> > +           cmd->addr =3D I3C_BROADCAST_ADDR;
> > +           cmd->rnw =3D 1;
> > +           cmd->rx_buf =3D pid_buf;
> > +           cmd->rx_len =3D XI3C_DAA_SLAVEINFO_READ_BYTECOUNT;
> > +           cmd->is_daa =3D true;
> > +           cmd->type =3D XI3C_SDR_MODE;
> > +           cmd->tid =3D XI3C_SDR_TID;
> > +           cmd->continued =3D true;
> > +
> > +           ret =3D xi3c_master_common_xfer(master, xfer);
> > +
> > +           /* DAA always finishes with CE2_ERROR or NACK_RESP */
> > +           if (ret && ret !=3D I3C_ERROR_M2) {
> > +                   goto err_daa;
> > +           } else {
> > +                   if (ret && ret =3D=3D I3C_ERROR_M2) {
> > +                           xi3c_master_resume(master);
> > +                           master->daa.index--;
> > +                           ret =3D 0;
> > +                           break;
> > +                   }
> > +           }
> > +   }
> > +
> > +   kfree(xfer);
> > +
> > +   for (i =3D 0; i < master->daa.index; i++) {
> > +           i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
> > +
> > +           pid_bcr_dcr[i] =3D FIELD_GET(XI3C_PID_MASK,
> > +                                      get_unaligned_be64(pid_bufs[i]))=
;
>
> you only use pid_bcr_dcr here, needn't dymatic alloc at all.
>
>               u64 data =3D FIELD_GET(XI3C_PID_MASK,
> get_unaligned_be64(pid_bufs[i]));
>               dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, data);
We will fix.
>
> Frank
>
> > +           dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, pid_bc=
r_dcr[i]);
> > +   }
> > +
> > +   return 0;
> > +
> > +err_daa:
> > +   kfree(xfer);
> > +err_daa_mem:
> > +   xi3c_master_reinit(master);
> > +   return ret;
> > +}
> > +
> ...
> > +};
> > +module_platform_driver(xi3c_master_driver);
> > +
> > +MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
> > +MODULE_DESCRIPTION("AXI I3C master driver");
> MODULE_LICENSE("GPL");
> > --
> > 2.34.1
> >


Thanks,
Manikanta.
