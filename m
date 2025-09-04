Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DCC2F998D;
	Thu,  4 Sep 2025 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980575; cv=fail; b=Hqz2xIZsjmP/ObzCuMUCVz1Ccb7kB+LhPmNwUSJ9kpfeISq36G82CaF0GMSbQVW1TXA4g1OWjmyztTMgywuopg9SyCsAQJI61OwTnELQbY5MSMLBpBqN6z5G34RRX6HLppJy7NKZhaWS7sSBwkdhuXkavpGsYoKN4807jCJtSVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980575; c=relaxed/simple;
	bh=OoYUvaS7qodR/A+AxTqK5EBTwL/pwnn6/OQDgCWNuYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qFJxTmMpKr0V4o5Fcn9Scqh+9mOrIYE2snk3F6L30EsERGoTcdTsnDVju50Vd/JeOGjfCLOer/LIsa70q5rqJ0Fjk8dzgPuyHGJD+XwQxA0LcdEGK/tgVKtaVdQz8WQZBrZf3fI/6IqgLERk/rGZUv6F+pibYtWef6eLv+FDGVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H0awWLYX; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H0awWLYX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYvRxrSKl7ynynf3YoJJEhcGMzWPqqiX3Hr8kw8tbDWHDxl26k5RWjlbSHmLof2qlxg2Ym9BnFZr1eh/YjxQyI9Rcc29AWQmYWrI6iHDN5CbDpvxNNseYXLSTS7Rm9vJsmKKn98CHxOa3Zf5Vt/VBSKeHGZPnrqUuaxutdw+nQF5Bj1714sCJaQ7Av/ST8glR8lE/5Tq0uall8Geh6yk4A1gLn35UD9DQCDi+tq5rDkcw1xZv3T/+dzotoElEomQ4LhIaqB/5XBA5b4FYnwYcnjoiW/vrok1FcPWYIVUmr/y8WxuAlq7oj1lZaaufBxIQWzOes5mCEFnqQsX5bLdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7jbkco7SF2JiPJqf09oUv0Ws8DcBKLg9SD0hfQz0EM=;
 b=ItuuzxxjU/XB95Fxzk78w/bh8HX3UuQ9XO+1rgpUJNY0hvGU8DzYJKglF6UZPJMqt/vQCrZsYUhlJyvk8KiMHtmhUggb6ZOwI0Jp/JGFghH5bB3VxDaCnExKQjIln+reVM2F297lAsykNrXGEnr54rcdxMse3ZMWuMMIN45Vwx9uHypYnzuoXv0J8z2x+x2TgIOECIeUEiXtyHNYKCKXz+zgzMPte0d4KsR0uA2j8mRTHgww1UoveZ4fJ/mGvFSQCt6Tk2qLn/UoYKU+0Q0MbW+vWX/ArI+ut6amdS25csT5u67E39BPsz7q62HwuUSpzB5wGKElBylljY5VVg6gHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7jbkco7SF2JiPJqf09oUv0Ws8DcBKLg9SD0hfQz0EM=;
 b=H0awWLYXZINUfSn3KsnSXZ1vdQAGPZuU2synBy8K1iAVy2nFhFcZjv9n9rbTZ8z9arBGRpVLJCKizoJJESWq2S069NJc0LjKUsiwNnmx4cJo6IE2ytjzro8siZpIqTfNUHwH6alrJXkWdJmFEktVHpZJQpHN8NBDRCuZkK+0NPc=
Received: from IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 4 Sep
 2025 10:09:25 +0000
Received: from IA1PR12MB6092.namprd12.prod.outlook.com
 ([fe80::6501:100:1d7:8136]) by IA1PR12MB6092.namprd12.prod.outlook.com
 ([fe80::6501:100:1d7:8136%3]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 10:09:25 +0000
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
Subject: RE: [PATCH V2 2/2] i3c: master: Add AMD I3C bus controller driver
Thread-Topic: [PATCH V2 2/2] i3c: master: Add AMD I3C bus controller driver
Thread-Index: AQHcGQhSrlaRhqh2AkWz1F3/d3Q4/bSBi9AAgAEZ8hA=
Date: Thu, 4 Sep 2025 10:09:24 +0000
Message-ID:
 <IA1PR12MB6092043688B7D23925AE34978C00A@IA1PR12MB6092.namprd12.prod.outlook.com>
References: <20250829171327.2590730-1-manikanta.guntupalli@amd.com>
 <20250829171327.2590730-3-manikanta.guntupalli@amd.com>
 <aLhQbDjeoEukMgpy@lizhi-Precision-Tower-5810>
In-Reply-To: <aLhQbDjeoEukMgpy@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-04T07:17:28.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6092:EE_|PH8PR12MB7325:EE_
x-ms-office365-filtering-correlation-id: 849376f1-05cb-4624-785b-08ddeb9b2069
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4Cwqcagnba2X+2BcxHjbds75wjIZgDW3V3MA9yetpCyx0XSsNHIbdO3mn/xT?=
 =?us-ascii?Q?R71wyBg8GeXc7byjzZCEe3oo09/r/L30yG3BKU8+kmAxppKjyndes2GD7sDX?=
 =?us-ascii?Q?PuJxrWN6ccmJxusag+V43Pkbp2B8ZAjgsa9gn19BfmT2ADgOCnnC6XXat/Lv?=
 =?us-ascii?Q?G2KKh4dE7Y1d+uGNRBRDmKu+KQ4cVwveMgyrpMjx3uK0nPIr1i7bievLzrpq?=
 =?us-ascii?Q?uZJ4IEbr+m3EXItXsu5w3Fjza5PD4rGDXl0lpLJH7pDsLhYppqT9XsCMkB8w?=
 =?us-ascii?Q?HGT16mNd4fYz6cS6oYwEZcI7iplffvJpKOh7JuFdB+iYR+C7bmvBvmNFzNr8?=
 =?us-ascii?Q?pTYHskeUxtb+4z8wL+Hxvhk+dXve9c9nt5LA5yhlw7gYMtTsW9sz2/7Hc1h5?=
 =?us-ascii?Q?ZBZSyBU8Uas45pbTu1/J+TMZhuRUoX4tcw892V0O/+TYnwxb8Yrw3TBP8Jv+?=
 =?us-ascii?Q?lPJMIp20OfADDezCwwAwmDe7RBebb0kLidBFvYexwWstDLEhE9fADnymzt7n?=
 =?us-ascii?Q?g/2rLNkTyJ16W1rPsQvPgfc4BQP42oOlswWzLyxly3Kep+xBBi18v6rahmAc?=
 =?us-ascii?Q?TXPytm59pzuZsbpywec720LyFzfgqAfBFnL5T0Dxwqylz18OgJ17KtyxEP6F?=
 =?us-ascii?Q?rW/rXmdRc1N34qCMlgEGlT1l6cQ3hFYmU2mQl+Ru/0dBjH+09lkqS8747wNd?=
 =?us-ascii?Q?sYKH1VBXjUD87uej6rZj/uT17uUOQMDvEIomjZlJ1kbirVh4rO4nRxwg1/rG?=
 =?us-ascii?Q?TeO7ucOMQcK0BLsPPUz9r2Fv36lpuXF79Y5/tmgx0Lol50f7iAbmOo1/bhp/?=
 =?us-ascii?Q?H/FGI1kFUBhh88GmywNWUXOEEEaIWFJrDoIMpD75f7Fotv0aP94CRa2uunyx?=
 =?us-ascii?Q?8SPJnKlOzZsKdbidQrccmVhECEEc0TmTdUNv/HW5E4lgrGkXQpFxmuFqOEu8?=
 =?us-ascii?Q?zIdUbI0zSyq7e+ns1mjbWuI5pCWAi2oYKPbxTHhXhdG0oLQtPE2hiYcP+FBc?=
 =?us-ascii?Q?x8eLZ9s6BeqSwkO5VYFpvoovQVKfI+JHjx+s41dIouZvGykYYDyMKZHJHjoA?=
 =?us-ascii?Q?reWn+/yZXlad8IgTymiugL2XXl8B93SAaTz5kLRDTWX8Pygugx3nL4wkvr0a?=
 =?us-ascii?Q?i0w9O7WLliFiS+gPwbDg+L14LIe+J+lcWi1/+BVvINIgfvoO8sWNXZ22nOiz?=
 =?us-ascii?Q?RIQoUaf+g8meLOii8kn8VaovY2siVFpVnUJATtuQuGYexC2u8xnVcCJb6jnq?=
 =?us-ascii?Q?eW5VIpExfytJCp0kR0UFUwWRB2dtkJ9AvRCp/5PhWEyVHfszdbtQjScR5uPA?=
 =?us-ascii?Q?2D9wdZetYrKG/8cC8Dx+g1dDMwwlwEA9e9+1jhr+P0faloVZQvsV/zPWIEDf?=
 =?us-ascii?Q?fP2mrr7ltCpj1QGUtG3wAO7lg8ZV47dgFvFoz91V6MjJX45L2K0UFKok/dap?=
 =?us-ascii?Q?d1T4IegUdaQTIsxWLVD9oJFRnQidQcHzSr0wgKCMXSFaw18IpmILpg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6092.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wQ0wx5Zo+o5+ySU1rPihugrdLP4SoI5BoCOxT4ssXFKj83P/DKQhk/T1F4WA?=
 =?us-ascii?Q?YZ0Nfur26qu1pJ4rq77VZJFiB+veTjD2B/JcCo9i7cH6/L6I4yU/q0RILxj7?=
 =?us-ascii?Q?C8+lwj7SgiMN61OOtS7Qgl92kocESPWx52fl0l8U1P5u34zHs8OoM2b5QrG7?=
 =?us-ascii?Q?PKI4A14I3FG1GBcBbzi5y508qmUKezxKgsamV2BTGJZofpcbi6AFBkIAnJzt?=
 =?us-ascii?Q?+zJcdKQTtfT0V+kQPQbppq8pEnSAofhyX1E8779i/oIhBOFxda4FEwoTXsd2?=
 =?us-ascii?Q?Agz/Aqj4Wr4IK4KY/97/hRpbw48jcVQ01S7SfgxS0+ZDEv9mtRJx9BwQSwd5?=
 =?us-ascii?Q?1UQlAlnS/qvOavkKUpc+0MnKdbjHKEe7yhKq+k62PehO06TD2cHwMUJPCvNz?=
 =?us-ascii?Q?IoZdgthiJgbtw/akfa2sCf4jwepJdnChV9zIQ9J5fKJC7wVGI+asVaytynlF?=
 =?us-ascii?Q?aRZ+M5+mmY173Gt+9PYZl849JD/+m9FSU2UBxe0P1taeTjCuX6ukfO8lRfVM?=
 =?us-ascii?Q?lLZVfwpiZb7AweEHj2hvqx12hxS3k3OizUf8r/r+3Sz+9kASrswzac68StS/?=
 =?us-ascii?Q?KPlq/r1/nqc3NdA/k9UqnWIggztbJJQI9gESv5k3zVIrjlxjlJ/RP/EySHzh?=
 =?us-ascii?Q?k/B4DVdV7tlLpqZ4bB7porntmdf/CFWj6m+BTKmGGC3NzYzcnJYoau0+69w1?=
 =?us-ascii?Q?CpLKgbM+OyV66mf2HCposDNdykAF8CSSmRrtpBF9x1BYDekk6is3F6qsLT2d?=
 =?us-ascii?Q?OgG8H/wSY9zNLD6Az35jGvzX8UHldo4Fp7Cdj7dlZWMSbXT59BJQEoLXeHCB?=
 =?us-ascii?Q?0lMqpUyNmjmnr6RR+0DSTJ2L8/PCoKXRXVviGSSwReSwXkGTVHArdSH2FN+z?=
 =?us-ascii?Q?Zt58won1ZhpltNk3grlVMc9unvc+v5xDDZoxpWfPNXTdpBn3/nCkbZZbGwFE?=
 =?us-ascii?Q?0gHj8dVqgDqiUBuJv/Zrk3XzTTH1alsUDvP4c1sFg0VtNFTUxeBgqUdkfGcg?=
 =?us-ascii?Q?pGL9NQW4bQz4CDlX5d3D0179MM1VVnzanmGCMVpGjyXkFG3kYeBXuaZFQ031?=
 =?us-ascii?Q?1VsHws4YsJbDPIcZClbdZZLPdwD4gl8HQ0XNDLyKkf+luT6pRxIKxsq+DQSB?=
 =?us-ascii?Q?iJOt3DhEOo35bYWG6zSoRqOAwQNragJ1TM3vR2buBx0WBBVgfWue52ugZkMe?=
 =?us-ascii?Q?5IGvKVPr4f+UEsJ+hDviiNYdORKyoMDafBle5ikj0DnGdm0JVvYC5ghIdiRN?=
 =?us-ascii?Q?iHdhba6PVLA/g7KCAEJRvBjM96BCkfFL2eCTpREPi84lIK9AeifkfxMYss7/?=
 =?us-ascii?Q?mtBdX+V0Jae1nfT2UspN5jENHa7qz8Y8fcQEpAL3Ne3EDmyZIcU8WMg7v45o?=
 =?us-ascii?Q?IJR5ihwXKe2GGGSpUe59N/pkcNc8t1tNCHX6vZU9rU4krI/1Qh3+pDS+KP6z?=
 =?us-ascii?Q?1uthxUbsIOs2swfYxuKZlHbT3VjBJdWa8eGy0WB+9jrWpO9zbzgAO8NHCspr?=
 =?us-ascii?Q?wsvDvPj/uNzHOE+7ZYu3eu4mdjslOK/kA+P7yQD+EtouxByNROXSCeCn0xgk?=
 =?us-ascii?Q?kvdtlN9qqpifEw89wEg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6092.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849376f1-05cb-4624-785b-08ddeb9b2069
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 10:09:25.2195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coRhINDa00uMrgh5M+0FoV+AguAKeYQjlxBFrrx/MaDJY2uwZJvqFuya5rlTsPgBEfp44FtxaNml6LF7gsFoIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325

[Public]

Hi,

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, September 3, 2025 7:58 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>;
> alexandre.belloni@bootlin.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> hardening@vger.kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> Subject: Re: [PATCH V2 2/2] i3c: master: Add AMD I3C bus controller drive=
r
>
> On Fri, Aug 29, 2025 at 10:43:27PM +0530, Manikanta Guntupalli wrote:
> > Add an I3C master driver and maintainers fragment for the AMD I3C bus
> > controller.
> >
> > The driver currently supports the I3C bus operating in SDR i3c mode,
> > with features including Dynamic Address Assignment, private data transf=
ers,
> > and CCC transfers in both broadcast and direct modes. It also supports
> > operation in I2C mode.
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
> > ---
> >  MAINTAINERS                         |    7 +
> >  drivers/i3c/master/Kconfig          |   16 +
> >  drivers/i3c/master/Makefile         |    1 +
> >  drivers/i3c/master/amd-i3c-master.c | 1009 +++++++++++++++++++++++++++
> >  4 files changed, 1033 insertions(+)
> >  create mode 100644 drivers/i3c/master/amd-i3c-master.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0cb9e55021cb..28ee1554cb0b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11416,6 +11416,13 @@ L: linux-i2c@vger.kernel.org
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
> > index 77da199c7413..a77d288d2464 100644
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
> >     depends on I3C
> > diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> > index 3e97960160bc..c0167aa1f1b3 100644
> > --- a/drivers/i3c/master/Makefile
> > +++ b/drivers/i3c/master/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_AMD_I3C_MASTER)               +=3D amd-i3c-master.o
> >  obj-$(CONFIG_CDNS_I3C_MASTER)              +=3D i3c-master-cdns.o
> >  obj-$(CONFIG_DW_I3C_MASTER)                +=3D dw-i3c-master.o
> >  obj-$(CONFIG_AST2600_I3C_MASTER)   +=3D ast2600-i3c-master.o
> > diff --git a/drivers/i3c/master/amd-i3c-master.c b/drivers/i3c/master/a=
md-i3c-
> master.c
> > new file mode 100644
> > index 000000000000..f74febe4d17d
> > --- /dev/null
> > +++ b/drivers/i3c/master/amd-i3c-master.c
> > @@ -0,0 +1,1009 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * I3C master driver for the AMD I3C controller.
> > + *
> > + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/i3c/master.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/ioport.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/unaligned.h>
> > +
> > +#define XI3C_VERSION_OFFSET                        0x00    /* Version
> Register */
> > +#define XI3C_RESET_OFFSET                  0x04    /* Soft Reset Regis=
ter */
> > +#define XI3C_CR_OFFSET                             0x08    /* Control
> Register */
> > +#define XI3C_ADDRESS_OFFSET                        0x0C    /* Target A=
ddress
> Register */
> > +#define XI3C_SR_OFFSET                             0x10    /* Status
> Register */
> > +#define XI3C_CMD_FIFO_OFFSET                       0x20    /* I3C Comm=
and
> FIFO Register */
> > +#define XI3C_WR_FIFO_OFFSET                        0x24    /* I3C Writ=
e Data
> FIFO Register */
> > +#define XI3C_RD_FIFO_OFFSET                        0x28    /* I3C Read=
 Data
> FIFO Register */
> > +#define XI3C_RESP_STATUS_FIFO_OFFSET               0x2C    /* I3C Resp=
onse
> status FIFO Register */
> > +#define XI3C_FIFO_LVL_STATUS_OFFSET                0x30    /* I3C CMD =
&
> WR FIFO LVL Register */
> > +#define XI3C_FIFO_LVL_STATUS_1_OFFSET              0x34    /* I3C RESP=
 &
> RD FIFO LVL Register */
> > +#define XI3C_SCL_HIGH_TIME_OFFSET          0x38    /* I3C SCL HIGH
> Register */
> > +#define XI3C_SCL_LOW_TIME_OFFSET           0x3C    /* I3C SCL LOW
> Register */
> > +#define XI3C_SDA_HOLD_TIME_OFFSET          0x40    /* I3C SDA
> HOLD Register */
> > +#define XI3C_TSU_START_OFFSET                      0x48    /* I3C STAR=
T
> SETUP Register  */
> > +#define XI3C_THD_START_OFFSET                      0x4C    /* I3C STAR=
T
> HOLD Register */
> > +#define XI3C_TSU_STOP_OFFSET                       0x50    /* I3C STOP
> Setup Register  */
> > +#define XI3C_OD_SCL_HIGH_TIME_OFFSET               0x54    /* I3C OD S=
CL
> HIGH Register */
> > +#define XI3C_OD_SCL_LOW_TIME_OFFSET                0x58    /* I3C OD S=
CL
> LOW  Register */
> > +#define XI3C_PID0_OFFSET                   0x6C    /* LSB 4 bytes of t=
he
> PID */
> > +#define XI3C_PID1_BCR_DCR                  0x70    /* MSB 2 bytes of t=
he
> PID, BCR and DCR */
> > +
> > +#define XI3C_CR_EN_MASK                            BIT(0)  /* Core Ena=
ble */
> > +#define XI3C_CR_RESUME_MASK                        BIT(2)  /* Core Res=
ume
> */
> > +#define XI3C_SR_RESP_NOT_EMPTY_MASK                BIT(4)  /* Resp Fif=
o not
> empty status mask */
> > +
> > +#define XI3C_BCR_MASK                              GENMASK(23, 16)
> > +#define XI3C_DCR_MASK                              GENMASK(31, 24)
> > +#define XI3C_PID_MASK                              GENMASK(63, 16)
> > +#define XI3C_SCL_HIGH_TIME_MASK                    GENMASK(17, 0)
> > +#define XI3C_SCL_LOW_TIME_MASK                     GENMASK(17, 0)
> > +#define XI3C_SDA_HOLD_TIME_MASK                    GENMASK(17, 0)
> > +#define XI3C_TSU_START_MASK                        GENMASK(17, 0)
> > +#define XI3C_THD_START_MASK                        GENMASK(17, 0)
> > +#define XI3C_TSU_STOP_MASK                 GENMASK(17, 0)
> > +#define XI3C_REV_NUM_MASK                  GENMASK(15, 8)
> > +#define XI3C_PID1_MASK                             GENMASK(15, 0)
> > +#define XI3C_WR_FIFO_LEVEL_MASK                    GENMASK(15, 0)
> > +#define XI3C_CMD_LEN_MASK                  GENMASK(11, 0)
> > +#define XI3C_RESP_CODE_MASK                        GENMASK(8, 5)
> > +#define XI3C_ADDR_MASK                             GENMASK(6, 0)
> > +#define XI3C_CMD_TYPE_MASK                 GENMASK(3, 0)
> > +#define XI3C_CMD_TID_MASK                  GENMASK(3, 0)
> > +#define XI3C_FIFOS_RST_MASK                        GENMASK(4, 1)
> > +
> > +#define XI3C_OD_TLOW_NS                            500000
> > +#define XI3C_OD_THIGH_NS                   41000
> > +#define XI3C_I2C_TCASMIN_NS                        600000
> > +#define XI3C_TCASMIN_NS                            260000
> > +#define XI3C_MAXDATA_LENGTH                        4095
> > +#define XI3C_MAX_DEVS                              32
> > +#define XI3C_DAA_SLAVEINFO_READ_BYTECOUNT  8
> > +
> > +#define XI3C_I2C_MODE                              0
> > +#define XI3C_I2C_TID                               0
> > +#define XI3C_SDR_MODE                              1
> > +#define XI3C_SDR_TID                               1
> > +
> > +#define XI3C_WORD_LEN                              4
> > +
> > +/* timeout waiting for the controller finish transfers */
> > +#define XI3C_XFER_TIMEOUT                  (msecs_to_jiffies(10000))
> > +#define XI3C_XFER_TIMEOUT_MS                       10000
>
> Only define one TIMEOUT should be enough
We will fix.
>
> s/XI3C_XFER_TIMEOUT/(msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))
>
> > +
> > +#define xi3c_getrevisionnumber(master)                                =
             \
> > +   ((u8)(FIELD_GET(XI3C_REV_NUM_MASK,                                 =
     \
> > +                   readl((master)->membase + XI3C_VERSION_OFFSET))))
> > +
> > +#define xi3c_wrfifolevel(master)                                      =
     \
> > +   ((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_OFFSET) &
>               \
> > +          XI3C_WR_FIFO_LEVEL_MASK))
> > +
> > +#define xi3c_rdfifolevel(master)                                      =
     \
> > +   ((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_1_OFFSET)
> &     \
> > +          XI3C_WR_FIFO_LEVEL_MASK))
> > +
> > +#define xi3c_is_resp_available(master)                                =
             \
> > +   ((u8)(FIELD_GET(XI3C_SR_RESP_NOT_EMPTY_MASK,
>       \
> > +                   readl((master)->membase + XI3C_SR_OFFSET))))
>
> Are you sure need type force convert at above macro?
Not needed, we will fix.
>
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
> > +   struct xi3c_cmd cmds[] __counted_by(ncmds);
> > +};
> > +
> > +/**
> > + * struct xi3c_master - I3C Master structure
> > + * @base: I3C master controller
> > + * @dev: Pointer to device structure
> > + * @xferqueue: Transfer queue structure
> > + * @xferqueue.list: List member
> > + * @xferqueue.cur: Current ongoing transfer
> > + * @xferqueue.lock: Queue lock
> > + * @membase: Memory base of the HW registers
> > + * @pclk: Input clock
> > + * @lock: Transfer lock
> > + * @daa.addrs: Slave addresses array
> > + * @daa.index: Slave device index
> > + */
> > +struct xi3c_master {
> > +   struct i3c_master_controller base;
> > +   struct device *dev;
> > +   struct {
> > +           struct list_head list;
> > +           struct xi3c_xfer *cur;
> > +           /* Queue lock */
> > +           spinlock_t lock;
> > +   } xferqueue;
> > +   void __iomem *membase;
> > +   struct clk *pclk;
> > +   /* Transfer lock */
> > +   struct mutex lock;
> > +   struct {
> > +           u8 addrs[XI3C_MAX_DEVS];
> > +           u8 index;
> > +   } daa;
> > +};
> > +
> > +static inline struct xi3c_master *
> > +to_xi3c_master(struct i3c_master_controller *master)
> > +{
> > +   return container_of(master, struct xi3c_master, base);
> > +}
> > +
> > +static int xi3c_get_response(struct xi3c_master *master)
> > +{
> > +   u32 resp_reg, response_data;
> > +   int ret;
> > +
> > +   ret =3D readl_poll_timeout(master->membase + XI3C_SR_OFFSET,
> > +                            resp_reg,
> > +                            resp_reg & XI3C_SR_RESP_NOT_EMPTY_MASK,
> > +                            0, XI3C_XFER_TIMEOUT_MS);
> > +   if (ret) {
> > +           dev_err(master->dev, "AXI I3C response timeout\n");
> > +           return ret;
> > +   }
> > +
> > +   response_data =3D readl(master->membase +
> XI3C_RESP_STATUS_FIFO_OFFSET);
> > +
> > +   /* Return response code */
> > +   return FIELD_GET(XI3C_RESP_CODE_MASK, response_data);
> > +}
> > +
> > +static void xi3c_master_wr_to_tx_fifo(struct xi3c_master *master,
> > +                                 struct xi3c_cmd *cmd)
> > +{
> > +   u8 *tx_buf =3D (u8 *)cmd->tx_buf;
> > +   u32 data =3D 0;
> > +   u16 len;
> > +
> > +   len =3D cmd->tx_len;
> > +   if (len > 0) {
> > +           len =3D (len >=3D XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
> > +           memcpy(&data, tx_buf, len);
> > +           tx_buf +=3D len;
> > +           cmd->tx_len -=3D len;
> > +   }
> > +   cmd->tx_buf =3D tx_buf;
> > +
> > +   /* Write the 32-bit value to the Tx FIFO */
> > +   iowrite32be(data, master->membase + XI3C_WR_FIFO_OFFSET);
> > +}
> > +
> > +static void xi3c_master_rd_from_rx_fifo(struct xi3c_master *master,
> > +                                   struct xi3c_cmd *cmd)
> > +{
> > +   u32 data;
> > +   u16 len;
> > +
> > +   /* Read from Rx FIFO */
> > +   data =3D ioread32be(master->membase + XI3C_RD_FIFO_OFFSET);
> > +
> > +   /* Data extraction to rx buffer */
> > +   len =3D cmd->rx_len;
> > +   if (len > 0) {
> > +           len =3D (len >=3D XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
> > +           memcpy((u8 *)cmd->rx_buf, &data, len);
> > +           cmd->rx_buf =3D (u8 *)cmd->rx_buf + len;
> > +           cmd->rx_len -=3D len;
> > +   }
> > +}
>
> Check i3c_writel_fifo() and i3c_readl_fifo(), which do the similar thing.
i3c_writel_fifo() and i3c_readl_fifo() follow the native endianness of the =
CPU.
However, in this case the FIFO should always be handled in big-endian forma=
t.
Therefore, we cannot use i3c_writel_fifo() and i3c_readl_fifo() directly.
>
> > +
> > +static void xi3c_master_write_to_cmdfifo(struct xi3c_master *master,
> > +                                    struct xi3c_cmd *cmd, u16 len)
> > +{
> > +   u32 transfer_cmd =3D 0;
> > +   u8 addr;
> > +
> > +   addr =3D ((cmd->addr & XI3C_ADDR_MASK) << 1) | (cmd->rnw & BIT(0));
> > +
> > +   transfer_cmd =3D cmd->type & XI3C_CMD_TYPE_MASK;
> > +   transfer_cmd |=3D (u32)(!cmd->continued) << 4;
> > +   transfer_cmd |=3D (u32)(addr) << 8;
> > +   transfer_cmd |=3D (u32)(cmd->tid & XI3C_CMD_TID_MASK) << 28;
>
> Can you use GEN_MASK to avoid hardcode 4, 8, 28
We found the GEN_MASK macro and its usage only under arch/alpha/.
It does not appear to be a generic API available for other architectures.
>
> > +
> > +   /*
> > +    * For dynamic addressing, an additional 1-byte length must be adde=
d
> > +    * to the command FIFO to account for the address present in the TX=
 FIFO
> > +    */
> > +   if (cmd->is_daa) {
> > +           xi3c_master_wr_to_tx_fifo(master, cmd);
> > +
> > +           len++;
> > +           master->daa.index++;
> > +           cmd->is_daa =3D false;
> > +   }
> > +
> > +   transfer_cmd |=3D (u32)(len & XI3C_CMD_LEN_MASK) << 16;
>
> And 16 here.
Same here.
>
> > +   writel(transfer_cmd, master->membase + XI3C_CMD_FIFO_OFFSET);
> > +}
> > +
> > +static inline void xi3c_master_enable(struct xi3c_master *master)
> > +{
> > +   writel(readl(master->membase + XI3C_CR_OFFSET) |
> XI3C_CR_EN_MASK,
> > +          master->membase + XI3C_CR_OFFSET);
> > +}
> > +
> > +static inline void xi3c_master_disable(struct xi3c_master *master)
> > +{
> > +   writel(readl(master->membase + XI3C_CR_OFFSET) &
> (~XI3C_CR_EN_MASK),
> > +          master->membase + XI3C_CR_OFFSET);
> > +}
> > +
> > +static inline void xi3c_master_resume(struct xi3c_master *master)
> > +{
> > +   writel(readl(master->membase + XI3C_CR_OFFSET) |
> XI3C_CR_RESUME_MASK,
> > +          master->membase + XI3C_CR_OFFSET);
> > +}
> > +
> > +static void xi3c_master_reset_fifos(struct xi3c_master *master)
> > +{
> > +   u32 data;
> > +
> > +   /* Reset fifos */
> > +   data =3D readl(master->membase + XI3C_RESET_OFFSET);
>
> you mix use readl and ioread32, can you keep consistence?
We will fix.
>
> > +   data |=3D XI3C_FIFOS_RST_MASK;
> > +   writel(data, master->membase + XI3C_RESET_OFFSET);
> > +   udelay(10);
>
> udelay() may not include MMIO operation, it may delay less than 10us.
> suggest readl() before udelay() to make sure value reach XI3C_RESET_OFFSE=
T.
We will fix.
>
> > +   data &=3D ~XI3C_FIFOS_RST_MASK;
> > +   writel(data, master->membase + XI3C_RESET_OFFSET);
> > +   udelay(10);
> > +}
> > +
> > +static inline void xi3c_master_init(struct xi3c_master *master)
> > +{
> > +   /* Reset fifos */
> > +   xi3c_master_reset_fifos(master);
> > +
> > +   /* Enable controller */
> > +   xi3c_master_enable(master);
> > +}
> > +
> > +static inline void xi3c_master_reinit(struct xi3c_master *master)
> > +{
> > +   /* Reset fifos */
> > +   xi3c_master_reset_fifos(master);
> > +
> > +   /* Resume controller */
> > +   xi3c_master_resume(master);
> > +}
> > +
> > +static struct xi3c_xfer *
> > +xi3c_master_alloc_xfer(struct xi3c_master *master, unsigned int ncmds)
> > +{
> > +   struct xi3c_xfer *xfer;
> > +
> > +   xfer =3D kzalloc(struct_size(xfer, cmds, ncmds), GFP_KERNEL);
> > +   if (!xfer)
> > +           return NULL;
> > +
> > +   INIT_LIST_HEAD(&xfer->node);
> > +   xfer->ncmds =3D ncmds;
> > +   xfer->ret =3D -ETIMEDOUT;
> > +
> > +   return xfer;
> > +}
> > +
> > +static inline void xi3c_master_free_xfer(struct xi3c_xfer *xfer)
> > +{
> > +   kfree(xfer);
> > +}
>
> why not direct call kfree()?
We will fix.
>
> > +
> > +static int xi3c_master_read(struct xi3c_master *master, struct xi3c_cm=
d *cmd)
> > +{
> > +   unsigned long timeout;
> > +   u16 rx_data_available;
> > +   u16 data_index;
> > +
> > +   if (!cmd->rx_buf || cmd->rx_len > XI3C_MAXDATA_LENGTH)
> > +           return -EINVAL;
> > +
> > +   /* Fill command fifo */
> > +   xi3c_master_write_to_cmdfifo(master, cmd, cmd->rx_len);
> > +
> > +   timeout =3D jiffies + XI3C_XFER_TIMEOUT;
> > +   /* Read data from rx fifo */
> > +   while (cmd->rx_len > 0 && !xi3c_is_resp_available(master)) {
> > +           if (time_after(jiffies, timeout)) {
> > +                   dev_err(master->dev, "XI3C read timeout\n");
> > +                   return -EIO;
> > +           }
> > +
> > +           rx_data_available =3D xi3c_rdfifolevel(master);
> > +           for (data_index =3D 0;
> > +                data_index < rx_data_available && cmd->rx_len > 0;
> > +                data_index++)
> > +                   xi3c_master_rd_from_rx_fifo(master, cmd);
> > +   }
> > +
> > +   /* Read remaining data */
> > +   rx_data_available =3D xi3c_rdfifolevel(master);
> > +   for (data_index =3D 0;
> > +        data_index < rx_data_available && cmd->rx_len > 0;
> > +        data_index++)
> > +           xi3c_master_rd_from_rx_fifo(master, cmd);
> > +   return 0;
> > +}
> > +
> > +static int xi3c_master_write(struct xi3c_master *master, struct xi3c_c=
md *cmd)
> > +{
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
> Does existed helper function i3c_writel_fifo() handle this?
As mentioned above, due to the endianness conflict with i3c_writel_fifo(),
it doesn't fit this case directly.
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
> > +static int xi3c_master_xfer(struct xi3c_master *master, struct xi3c_cm=
d *cmd)
> > +{
> > +   int ret;
> > +
> > +   if (cmd->rnw)
> > +           ret =3D xi3c_master_read(master, cmd);
> > +   else
> > +           ret =3D xi3c_master_write(master, cmd);
> > +
> > +   if (ret < 0)
> > +           goto err_xfer_out;
> > +
> > +   ret =3D xi3c_get_response(master);
> > +   if (ret)
> > +           goto err_xfer_out;
> > +
> > +   return 0;
> > +
> > +err_xfer_out:
> > +   xi3c_master_reinit(master);
> > +   return ret;
> > +}
> > +
> > +static void xi3c_master_dequeue_xfer_locked(struct xi3c_master *master=
,
> > +                                       struct xi3c_xfer *xfer)
> > +{
> > +   if (master->xferqueue.cur =3D=3D xfer)
> > +           master->xferqueue.cur =3D NULL;
> > +   else
> > +           list_del_init(&xfer->node);
> > +}
> > +
> > +static void xi3c_master_dequeue_xfer(struct xi3c_master *master,
> > +                                struct xi3c_xfer *xfer)
> > +{
> > +   guard(spinlock_irqsave)(&master->xferqueue.lock);
>
> Add empty line here.
We will fix.
>
> > +   xi3c_master_dequeue_xfer_locked(master, xfer);
> > +}
> > +
> > +static void xi3c_master_start_xfer_locked(struct xi3c_master *master)
> > +{
> > +   struct xi3c_xfer *xfer =3D master->xferqueue.cur;
> > +   int ret =3D 0, i;
> > +
> > +   if (!xfer)
> > +           return;
> > +
> > +   for (i =3D 0; i < xfer->ncmds; i++) {
> > +           struct xi3c_cmd *cmd =3D &xfer->cmds[i];
> > +
> > +           ret =3D xi3c_master_xfer(master, cmd);
> > +           if (ret)
> > +                   break;
> > +   }
> > +
> > +   xfer->ret =3D ret;
> > +   complete(&xfer->comp);
> > +
> > +   xfer =3D list_first_entry_or_null(&master->xferqueue.list,
> > +                                   struct xi3c_xfer,
> > +                                   node);
> > +   if (xfer)
> > +           list_del_init(&xfer->node);
> > +
> > +   master->xferqueue.cur =3D xfer;
> > +   xi3c_master_start_xfer_locked(master);
> > +}
> > +
> > +static inline void xi3c_master_enqueue_xfer(struct xi3c_master *master=
,
> > +                                       struct xi3c_xfer *xfer)
> > +{
> > +   init_completion(&xfer->comp);
> > +   guard(spinlock_irqsave)(&master->xferqueue.lock);
> > +   if (master->xferqueue.cur) {
> > +           list_add_tail(&xfer->node, &master->xferqueue.list);
> > +   } else {
> > +           master->xferqueue.cur =3D xfer;
> > +           xi3c_master_start_xfer_locked(master);
> > +   }
> > +}
> > +
> > +static inline int xi3c_master_common_xfer(struct xi3c_master *master,
> > +                                     struct xi3c_xfer *xfer)
> > +{
> > +   int ret, timeout;
> > +
> > +   guard(mutex)(&master->lock);
> > +   xi3c_master_enqueue_xfer(master, xfer);
> > +   timeout =3D wait_for_completion_timeout(&xfer->comp,
> > +
> msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS));
> > +   if (!timeout)
> > +           ret =3D -ETIMEDOUT;
> > +   else
> > +           ret =3D xfer->ret;
> > +
> > +   if (ret)
> > +           xi3c_master_dequeue_xfer(master, xfer);
> > +
> > +   return ret;
> > +}
> > +
> > +static int xi3c_master_do_daa(struct i3c_master_controller *m)
> > +{
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
> > +   xi3c_master_free_xfer(xfer);
> > +
> > +   for (i =3D 0; i < master->daa.index; i++) {
> > +           ret =3D i3c_master_add_i3c_dev_locked(m, master->daa.addrs[=
i]);
> > +           if (ret)
> > +                   goto err_daa_mem;
>
> see comments in svc-master-i3c.c
>
> /*
>          * Register all devices who participated to the core
>          *
>          * If two devices (A and B) are detected in DAA and address 0xa i=
s assigned to
>          * device A and 0xb to device B, a failure in i3c_master_add_i3c_=
dev_locked()
>          * for device A (addr: 0xa) could prevent device B (addr: 0xb) fr=
om being
>          * registered on the bus. The I3C stack might still consider 0xb =
a free
>          * address. If a subsequent Hotjoin occurs, 0xb might be assigned=
 to Device A,
>          * causing both devices A and B to use the same address 0xb, viol=
ating the I3C
>          * specification.
>          *
>          * The return value for i3c_master_add_i3c_dev_locked() should no=
t be
> checked
>          * because subsequent steps will scan the entire I3C bus, indepen=
dent of
>          * whether i3c_master_add_i3c_dev_locked() returns success.
>          *
>          * If device A registration fails, there is still a chance to reg=
ister device
>          * B. i3c_master_add_i3c_dev_locked() can reset DAA if a failure =
occurs while
>          * retrieving device information.
>          */
>
> I think it also fits your case.
Yes, that makes sense. We will skip checking the return value of i3c_master=
_add_i3c_dev_locked(),
since subsequent steps will rescan the entire bus regardless of the return =
status.
>
> > +
> > +           pid_bcr_dcr[i] =3D FIELD_GET(XI3C_PID_MASK,
> > +                                      get_unaligned_be64(pid_bufs[i]))=
;
> > +           dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, pid_bc=
r_dcr[i]);
> > +   }
> > +
> > +   return 0;
> > +
> > +err_daa:
> > +   xi3c_master_free_xfer(xfer);
> > +err_daa_mem:
> > +   xi3c_master_reinit(master);
> > +   return ret;
> > +}
> > +
> > +static bool
> > +xi3c_master_supports_ccc_cmd(struct i3c_master_controller *master,
> > +                        const struct i3c_ccc_cmd *cmd)
> > +{
> > +   if (cmd->ndests > 1)
> > +           return false;
> > +
> > +   switch (cmd->id) {
> > +   case I3C_CCC_ENEC(true):
> > +   case I3C_CCC_ENEC(false):
> > +   case I3C_CCC_DISEC(true):
> > +   case I3C_CCC_DISEC(false):
> > +   case I3C_CCC_ENTAS(0, true):
> > +   case I3C_CCC_ENTAS(0, false):
> > +   case I3C_CCC_RSTDAA(true):
> > +   case I3C_CCC_RSTDAA(false):
> > +   case I3C_CCC_ENTDAA:
> > +   case I3C_CCC_SETMWL(true):
> > +   case I3C_CCC_SETMWL(false):
> > +   case I3C_CCC_SETMRL(true):
> > +   case I3C_CCC_SETMRL(false):
> > +   case I3C_CCC_ENTHDR(0):
> > +   case I3C_CCC_SETDASA:
> > +   case I3C_CCC_SETNEWDA:
> > +   case I3C_CCC_GETMWL:
> > +   case I3C_CCC_GETMRL:
> > +   case I3C_CCC_GETPID:
> > +   case I3C_CCC_GETBCR:
> > +   case I3C_CCC_GETDCR:
> > +   case I3C_CCC_GETSTATUS:
> > +   case I3C_CCC_GETMXDS:
> > +           return true;
> > +   default:
> > +           return false;
> > +   }
> > +}
> > +
> > +static int xi3c_master_send_bdcast_ccc_cmd(struct xi3c_master *master,
> > +                                      struct i3c_ccc_cmd *ccc)
> > +{
> > +   u16 xfer_len =3D ccc->dests[0].payload.len + 1;
> > +   struct xi3c_xfer *xfer;
> > +   struct xi3c_cmd *cmd;
> > +   int ret;
> > +
> > +   xfer =3D xi3c_master_alloc_xfer(master, 1);
> > +   if (!xfer)
> > +           return -ENOMEM;
> > +
> > +   u8 *buf __free(kfree) =3D kmalloc(xfer_len, GFP_KERNEL);
> > +   if (!buf) {
> > +           xi3c_master_free_xfer(xfer);
> > +           return -ENOMEM;
> > +   }
> > +
> > +   buf[0] =3D ccc->id;
> > +   memcpy(&buf[1], ccc->dests[0].payload.data, ccc->dests[0].payload.l=
en);
> > +
> > +   cmd =3D &xfer->cmds[0];
> > +   cmd->addr =3D ccc->dests[0].addr;
> > +   cmd->rnw =3D ccc->rnw;
> > +   cmd->tx_buf =3D buf;
> > +   cmd->tx_len =3D xfer_len;
> > +   cmd->type =3D XI3C_SDR_MODE;
> > +   cmd->tid =3D XI3C_SDR_TID;
> > +   cmd->continued =3D false;
> > +
> > +   ret =3D xi3c_master_common_xfer(master, xfer);
> > +   xi3c_master_free_xfer(xfer);
> > +
> > +   return ret;
> > +}
> > +
> > +static int xi3c_master_send_direct_ccc_cmd(struct xi3c_master *master,
> > +                                      struct i3c_ccc_cmd *ccc)
> > +{
> > +   struct xi3c_xfer *xfer;
> > +   struct xi3c_cmd *cmd;
> > +   int ret;
> > +
> > +   xfer =3D xi3c_master_alloc_xfer(master, 2);
> > +   if (!xfer)
> > +           return -ENOMEM;
> > +
> > +   /* Broadcasted message */
> > +   cmd =3D &xfer->cmds[0];
> > +   cmd->addr =3D I3C_BROADCAST_ADDR;
> > +   cmd->rnw =3D 0;
> > +   cmd->tx_buf =3D &ccc->id;
> > +   cmd->tx_len =3D 1;
> > +   cmd->type =3D XI3C_SDR_MODE;
> > +   cmd->tid =3D XI3C_SDR_TID;
> > +   cmd->continued =3D true;
> > +
> > +   /* Directed message */
> > +   cmd =3D &xfer->cmds[1];
> > +   cmd->addr =3D ccc->dests[0].addr;
> > +   cmd->rnw =3D ccc->rnw;
> > +   if (cmd->rnw) {
> > +           cmd->rx_buf =3D ccc->dests[0].payload.data;
> > +           cmd->rx_len =3D ccc->dests[0].payload.len;
> > +   } else {
> > +           cmd->tx_buf =3D ccc->dests[0].payload.data;
> > +           cmd->tx_len =3D ccc->dests[0].payload.len;
> > +   }
> > +   cmd->type =3D XI3C_SDR_MODE;
> > +   cmd->tid =3D XI3C_SDR_TID;
> > +   cmd->continued =3D false;
> > +
> > +   ret =3D xi3c_master_common_xfer(master, xfer);
> > +   xi3c_master_free_xfer(xfer);
> > +   return ret;
> > +}
> > +
> > +static int xi3c_master_send_ccc_cmd(struct i3c_master_controller *m,
> > +                               struct i3c_ccc_cmd *cmd)
> > +{
> > +   struct xi3c_master *master =3D to_xi3c_master(m);
> > +   bool broadcast =3D cmd->id < 0x80;
> > +
> > +   if (broadcast)
> > +           return xi3c_master_send_bdcast_ccc_cmd(master, cmd);
> > +
> > +   return xi3c_master_send_direct_ccc_cmd(master, cmd);
> > +}
> > +
> > +static int xi3c_master_priv_xfers(struct i3c_dev_desc *dev,
> > +                             struct i3c_priv_xfer *xfers,
> > +                             int nxfers)
> > +{
> > +   struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
> > +   struct xi3c_master *master =3D to_xi3c_master(m);
> > +   struct xi3c_xfer *xfer;
> > +   int i, ret;
> > +
> > +   if (!nxfers)
> > +           return 0;
> > +
> > +   xfer =3D xi3c_master_alloc_xfer(master, nxfers);
> > +   if (!xfer)
> > +           return -ENOMEM;
> > +
> > +   for (i =3D 0; i < nxfers; i++) {
> > +           struct xi3c_cmd *cmd =3D &xfer->cmds[i];
> > +
> > +           cmd->addr =3D dev->info.dyn_addr;
> > +           cmd->rnw =3D xfers[i].rnw;
> > +
> > +           if (cmd->rnw) {
> > +                   cmd->rx_buf =3D xfers[i].data.in;
> > +                   cmd->rx_len =3D xfers[i].len;
> > +           } else {
> > +                   cmd->tx_buf =3D (void *)xfers[i].data.out;
> > +                   cmd->tx_len =3D xfers[i].len;
> > +           }
> > +
> > +           cmd->type =3D XI3C_SDR_MODE;
> > +           cmd->tid =3D XI3C_SDR_TID;
> > +           cmd->continued =3D (i + 1) < nxfers;
> > +   }
> > +
> > +   ret =3D xi3c_master_common_xfer(master, xfer);
> > +   xi3c_master_free_xfer(xfer);
> > +   return ret;
> > +}
> > +
> > +static int xi3c_master_i2c_xfers(struct i2c_dev_desc *dev,
> > +                            struct i2c_msg *xfers,
> > +                            int nxfers)
> > +{
> > +   struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
> > +   struct xi3c_master *master =3D to_xi3c_master(m);
> > +   struct xi3c_xfer *xfer;
> > +   int i, ret;
> > +
> > +   if (!nxfers)
> > +           return 0;
> > +
> > +   xfer =3D xi3c_master_alloc_xfer(master, nxfers);
> > +   if (!xfer)
> > +           return -ENOMEM;
> > +
> > +   for (i =3D 0; i < nxfers; i++) {
> > +           struct xi3c_cmd *cmd =3D &xfer->cmds[i];
> > +
> > +           cmd->addr =3D xfers[i].addr & XI3C_ADDR_MASK;
> > +           cmd->rnw =3D xfers[i].flags & I2C_M_RD;
> > +
> > +           if (cmd->rnw) {
> > +                   cmd->rx_buf =3D xfers[i].buf;
> > +                   cmd->rx_len =3D xfers[i].len;
> > +           } else {
> > +                   cmd->tx_buf =3D (void *)xfers[i].buf;
> > +                   cmd->tx_len =3D xfers[i].len;
> > +           }
> > +
> > +           cmd->type =3D XI3C_I2C_MODE;
> > +           cmd->tid =3D XI3C_I2C_TID;
> > +           cmd->continued =3D (i + 1) < nxfers;
> > +   }
> > +
> > +   ret =3D xi3c_master_common_xfer(master, xfer);
> > +   xi3c_master_free_xfer(xfer);
> > +   return ret;
> > +}
> > +
> > +static int xi3c_clk_cfg(struct xi3c_master *master, unsigned long sclh=
z, u8 mode)
> > +{
> > +   unsigned long core_rate, core_periodns;
> > +   u32 thigh, tlow, thold, odthigh, odtlow, tcasmin, tsustart, tsustop=
, thdstart;
> > +
> > +   core_rate =3D clk_get_rate(master->pclk);
> > +   if (!core_rate)
> > +           return -EINVAL;
> > +
> > +   core_periodns =3D DIV_ROUND_UP(1000000000, core_rate);
> > +
> > +   thigh =3D DIV_ROUND_UP(core_rate, sclhz) >> 1;
> > +   tlow =3D thigh;
> > +
> > +   /* Hold time : 40% of tlow time */
> > +   thold =3D (tlow * 4) / 10;
> > +
> > +   /*
> > +    * For initial IP (revision number =3D=3D 0), minimum data hold tim=
e is 5.
> > +    * For updated IP (revision number > 0), minimum data hold time is =
6.
> > +    * Updated IP supports achieving high data rate with low reference
> > +    * frequency.
> > +    */
> > +   if (xi3c_getrevisionnumber(master) =3D=3D 0)
> > +           thold =3D (thold < 5) ? 5 : thold;
> > +   else
> > +           thold =3D (thold < 6) ? 6 : thold;
> > +
> > +   writel((thigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
> > +          master->membase + XI3C_SCL_HIGH_TIME_OFFSET);
> > +   writel((tlow - 2) & XI3C_SCL_LOW_TIME_MASK,
> > +          master->membase + XI3C_SCL_LOW_TIME_OFFSET);
> > +   writel((thold - 2) & XI3C_SDA_HOLD_TIME_MASK,
> > +          master->membase + XI3C_SDA_HOLD_TIME_OFFSET);
> > +
> > +   if (!mode) {
> > +           /* I2C */
> > +           writel((thigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
> > +                  master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
> > +           writel((tlow - 2) & XI3C_SCL_LOW_TIME_MASK,
> > +                  master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
> > +
> > +           tcasmin =3D DIV_ROUND_UP(XI3C_I2C_TCASMIN_NS,
> core_periodns);
> > +   } else {
> > +           /* I3C */
> > +           odtlow =3D DIV_ROUND_UP(XI3C_OD_TLOW_NS, core_periodns);
> > +           odthigh =3D DIV_ROUND_UP(XI3C_OD_THIGH_NS, core_periodns);
> > +
> > +           odtlow =3D (tlow < odtlow) ? odtlow : tlow;
> > +           odthigh =3D (thigh > odthigh) ? odthigh : thigh;
> > +
> > +           writel((odthigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
> > +                  master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
> > +           writel((odtlow - 2) & XI3C_SCL_LOW_TIME_MASK,
> > +                  master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
> > +
> > +           tcasmin =3D DIV_ROUND_UP(XI3C_TCASMIN_NS, core_periodns);
> > +   }
> > +
> > +   thdstart =3D (thigh > tcasmin) ? thigh : tcasmin;
> > +   tsustart =3D (tlow > tcasmin) ? tlow : tcasmin;
> > +   tsustop =3D (tlow > tcasmin) ? tlow : tcasmin;
> > +
> > +   writel((tsustart - 2) & XI3C_TSU_START_MASK,
> > +          master->membase + XI3C_TSU_START_OFFSET);
> > +   writel((thdstart - 2) & XI3C_THD_START_MASK,
> > +          master->membase + XI3C_THD_START_OFFSET);
> > +   writel((tsustop - 2) & XI3C_TSU_STOP_MASK,
> > +          master->membase + XI3C_TSU_STOP_OFFSET);
> > +
> > +   return 0;
> > +}
> > +
> > +static int xi3c_master_bus_init(struct i3c_master_controller *m)
> > +{
> > +   struct xi3c_master *master =3D to_xi3c_master(m);
> > +   struct i3c_bus *bus =3D i3c_master_get_bus(m);
> > +   struct i3c_device_info info =3D { };
> > +   unsigned long sclhz;
> > +   u64 pid1_bcr_dcr;
> > +   u8 mode;
> > +   int ret;
> > +
> > +   switch (bus->mode) {
> > +   case I3C_BUS_MODE_MIXED_FAST:
> > +   case I3C_BUS_MODE_MIXED_LIMITED:
> > +           mode =3D XI3C_I2C_MODE;
> > +           sclhz =3D bus->scl_rate.i2c;
> > +           break;
> > +   case I3C_BUS_MODE_PURE:
> > +           mode =3D XI3C_SDR_MODE;
> > +           sclhz =3D bus->scl_rate.i3c;
> > +           break;
> > +   default:
> > +           return -EINVAL;
> > +   }
> > +
> > +   ret =3D xi3c_clk_cfg(master, sclhz, mode);
> > +   if (ret)
> > +           return ret;
> > +
> > +   /* Get an address for the master. */
> > +   ret =3D i3c_master_get_free_addr(m, 0);
> > +   if (ret < 0)
> > +           return ret;
> > +
> > +   info.dyn_addr =3D (u8)ret;
> > +
> > +   /* Write the dynamic address value to the address register. */
> > +   writel(info.dyn_addr, master->membase + XI3C_ADDRESS_OFFSET);
> > +
> > +   /* Read PID, BCR and DCR values, and assign to i3c device info. */
> > +   pid1_bcr_dcr =3D readl(master->membase + XI3C_PID1_BCR_DCR);
> > +   info.pid =3D ((FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr) << 32) |
> > +               readl(master->membase + XI3C_PID0_OFFSET));
> > +   info.bcr =3D (u8)FIELD_GET(XI3C_BCR_MASK, pid1_bcr_dcr);
> > +   info.dcr =3D (u8)FIELD_GET(XI3C_DCR_MASK, pid1_bcr_dcr);
> > +
> > +   ret =3D i3c_master_set_info(&master->base, &info);
> > +   if (ret)
> > +           return ret;
> > +
> > +   xi3c_master_init(master);
> > +
> > +   return ret;
> > +}
> > +
> > +static void xi3c_master_bus_cleanup(struct i3c_master_controller *m)
> > +{
> > +   struct xi3c_master *master =3D to_xi3c_master(m);
> > +
> > +   xi3c_master_disable(master);
> > +}
> > +
> > +static const struct i3c_master_controller_ops xi3c_master_ops =3D {
> > +   .bus_init =3D xi3c_master_bus_init,
> > +   .bus_cleanup =3D xi3c_master_bus_cleanup,
> > +   .do_daa =3D xi3c_master_do_daa,
> > +   .supports_ccc_cmd =3D xi3c_master_supports_ccc_cmd,
> > +   .send_ccc_cmd =3D xi3c_master_send_ccc_cmd,
> > +   .priv_xfers =3D xi3c_master_priv_xfers,
> > +   .i2c_xfers =3D xi3c_master_i2c_xfers,
> > +};
> > +
> > +static int xi3c_master_probe(struct platform_device *pdev)
> > +{
> > +   struct xi3c_master *master;
> > +
> > +   master =3D devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
> > +   if (!master)
> > +           return -ENOMEM;
> > +
> > +   master->membase =3D devm_platform_ioremap_resource(pdev, 0);
> > +   if (IS_ERR(master->membase))
> > +           return PTR_ERR(master->membase);
> > +
> > +   master->pclk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > +   if (IS_ERR(master->pclk))
> > +           return dev_err_probe(&pdev->dev, PTR_ERR(master->pclk),
> > +                                "Failed to get and enable clock\n");
> > +
> > +   master->dev =3D &pdev->dev;
> > +
> > +   mutex_init(&master->lock);
>
> devm_mutex_init()
We will fix.
>
> Frank
> > +   spin_lock_init(&master->xferqueue.lock);
> > +   INIT_LIST_HEAD(&master->xferqueue.list);
> > +
> > +   platform_set_drvdata(pdev, master);
> > +
> > +   return i3c_master_register(&master->base, &pdev->dev,
> > +                              &xi3c_master_ops, false);
> > +}
> > +
> > +static void xi3c_master_remove(struct platform_device *pdev)
> > +{
> > +   struct xi3c_master *master =3D platform_get_drvdata(pdev);
> > +
> > +   i3c_master_unregister(&master->base);
> > +}
> > +
> > +static const struct of_device_id xi3c_master_of_ids[] =3D {
> > +   { .compatible =3D "xlnx,axi-i3c-1.0" },
> > +   { },
> > +};
> > +
> > +static struct platform_driver xi3c_master_driver =3D {
> > +   .probe =3D xi3c_master_probe,
> > +   .remove =3D xi3c_master_remove,
> > +   .driver =3D {
> > +           .name =3D "axi-i3c-master",
> > +           .of_match_table =3D xi3c_master_of_ids,
> > +   },
> > +};
> > +module_platform_driver(xi3c_master_driver);
> > +
> > +MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
> > +MODULE_DESCRIPTION("AXI I3C master driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.34.1
> >

Thanks,
Manikanta.
