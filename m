Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C00221FCD;
	Thu, 11 Sep 2025 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570887; cv=fail; b=E08OWLiEyYwAdBTUo8Gg0q6lJVQawO2e5rlvEDk9USdx6n5uuYnSRYYqV/619JDyGh/Fo5rC9zhw2aJXqzL09ZWWuEMqLR6Lldp2yBXLfFG2e/zHDQMYZnloNdWSd+rsKFNVETbTn3DC6m8FfYBWUEkqg2UkA8HJF9C67iT4/Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570887; c=relaxed/simple;
	bh=GhDKWn+KwehBLQCUb//49s7ECnbxfCiWvsdt5VYAYjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AR/VFu0zd+S6IEjpk4W0Mrd4qIAktqE6JvdyPiJX7RHg8hf0KlXxJuNYQdue39bv4UhM2dsgVWgxO2pCPgCgDapsO/Ow4XgTV0ABrKDYaVZivtdwtjYNOIYhJyrPCTy4weuiHcWNX+ez0ARcwF4j7JIZgTlw5i8Sm8y/kosRVjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V2aTw8nL; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V2aTw8nL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZggIsL3N5sedT0i130/2in/yrOY3cFeiO3VQozEP0xqOdTYspOPPHqpL0ziLyUSOAbIFmebXcaOv0STfNteAYDEfQSCgjuOLoyrr7JS8PlKXu8NsOyEMDIISn8WxffrMp6+pntiLMRI14hThZMFM5yJnZlNEye6dLJ+oYwYZ9nxp9OWrJYgSNrd1jGPJu6RbRMJ8XyERqVxZ91M4BATIjhCIXB8zmdi2MQ+V6ycAhBWQoax016ICQB42dWMYx9uAKMvFhIrieTdYD/dOyhq84idm6EA1/Ip18BOHUTMiIzV5+XMa6J82VVJT+JrcUYyk0Xrd1Z1nGQdwiMUIgf8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2q24isugxZunHXXg1l2QNH7AuFiLkWbbAWjgbzLELc=;
 b=s/qRx6tin+J3xEbqAmn4cZ3vrTUTaWK007KxM5auPLMbH9znqo6NtwUCygCQbcHmiTDTENqdYjkJ3im1VlIXq2T2h1I+aKWKSQa1bA3VcA6eefcuLYY019B5BwFITaRk5zPukEkzcJc7vORgMKSGesqZlADo8NphgURFBLzuILe2WwxI0lXLD4v05633HBCBc+g/zJ8zY/70MzSiIqQe1rZA8xeFc/dyfMgxHB1Vsot71jaPxVY8iLFx3VlIYp20z+0WXrjdMiMH27aeLcICg3NCLgOCJd5vEr+Ko/vPFuKjvpp3o83j8csVE9+HpYjmgJJr5LVnzR1N3N7U+E4cUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2q24isugxZunHXXg1l2QNH7AuFiLkWbbAWjgbzLELc=;
 b=V2aTw8nLTTQZ11eILCXyKaMek/MVbTNCz3GN5XbeDKvqbQXCUiJng+mFiLxWcEiR3/9KDoZ1+RVDNh2XAkJiWt7/ogjEt2ufs8B4V1aqep+sShhdPHRNX5Z51VbftgsRw6Ai3aYqZ4aJHxZl3XhG/9A1Rts/Zr7oK0FCxOtMNZw=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 06:08:00 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 06:08:00 +0000
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
Thread-Index: AQHcIkZvn4aTq4cirkSmmfELS1IUxLSMotAAgADGrwA=
Date: Thu, 11 Sep 2025 06:07:59 +0000
Message-ID:
 <DM4PR12MB6109FB1956E8AC4979DFE85A8C09A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
 <20250910112954.553353-3-manikanta.guntupalli@amd.com>
 <aMGtdFxlXRanIAuM@lizhi-Precision-Tower-5810>
In-Reply-To: <aMGtdFxlXRanIAuM@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-11T04:46:45.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|DS0PR12MB7535:EE_
x-ms-office365-filtering-correlation-id: 04068ff3-d680-4911-4b23-08ddf0f98f63
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jWjRw0RZt2jqWYlUSCo6bmwKB6z/dd1FjrAmEbe0DTAEPE9rtyMADIdt53Io?=
 =?us-ascii?Q?XbVe08TglgXoS3zxVEIO0qfbNFeEB6tlgKGrIqrCmMhqUraveKFXVhM44OMo?=
 =?us-ascii?Q?uojJRG7rChGDCeuO3Q5ItNA5dT68p1jimpXYyx7XVGWEwOtUhaYKAT6xMN7P?=
 =?us-ascii?Q?T9Tm5IiBKSZDbY00gRBlHXt1kN02tuvDgzMB8H8VyHRjxkc64WAog7bE38of?=
 =?us-ascii?Q?Ayl2PJy1T8PhFM+p5/0f3Zm6Tt1q0TNQhwhZUQvZ/FjajOui3tXFe2/GTXEs?=
 =?us-ascii?Q?dzYkwtktKDppmdlRc4jxejH8e3NtGVPlA0kpf60lrtuw39PwD4TttP88Qrff?=
 =?us-ascii?Q?k5hcFXwURdZmMJVB+Q+SdRFetHz1JXDnCPwzE4rUJz4+s17JkinzDf+30MP8?=
 =?us-ascii?Q?TcFynuzfe1k+SzIWfeG9s6xwcA6TkAzgR8XRRxOGs4xs5ieQz0CEPpaGGAtD?=
 =?us-ascii?Q?9zFzK+AycwJbQnigCC0I5Tho1fV9ywVokr5Js46/LwHo9xH5dlZ1DnG8pSE8?=
 =?us-ascii?Q?0D+j9/6ut24Tu+bFeySiLsLk0c9KIsfN0Q3yZ7x6SKMsAbjGDl8EaGerpx7V?=
 =?us-ascii?Q?asL3fT/BrtEmUNPrmqtHgL5v6FtXfyR3h5G+X8MxbP9f4hxvPj0ql4mJIuct?=
 =?us-ascii?Q?iV8ACf3qKiyweWaGGsbZe3I0yWQ++jyfUffuBnRDTvER1CDHpyZ1LepRQwOf?=
 =?us-ascii?Q?aCxKsVTHm7qnAa+3GtpzpQCOhELhI9M9cU3coRvX5+xaWZOH6AtL8PUu1PHD?=
 =?us-ascii?Q?v4fLSXp7vehlR93OV/QTssCfdwqVJkJvzHMvy4xXSEj8lQQGEr7ihQEkozAP?=
 =?us-ascii?Q?HOHt4lMT/kKYPdx4I65prYZLgJvy2WAFwIHWSEzJ3AG643N/IpeNBvPjMIcp?=
 =?us-ascii?Q?sYpuLfUv74oj8q4BRIk0mZ8n6zi697PFWq9afESN0mn2vxKDNVfdDcw0DUue?=
 =?us-ascii?Q?WGvUUjI1RvVyWGS5tfJySngjCJX6n3sCmxfiIhPY8r0vH0EEKGPNO2MqwJ20?=
 =?us-ascii?Q?BrwBP7oZtSz6dPpLkZjECeroLsUyuNQrGzPjw2M3SkwGyhWOg9jENytiHvIN?=
 =?us-ascii?Q?ZL9ls0SZtpE7t+kS8UH9NQe+SZn/eUtjiDBeVX/Z+JYZ+lfRS22FWrEDqNlF?=
 =?us-ascii?Q?9H2SQGK9fyClkcxKBOeJFXrIHHG+HBgMdXDB00M/pJtgvKbcTcS3uJkntGIZ?=
 =?us-ascii?Q?Dm7SMMXOcIdXduZJlfHthgufh74yEqKf3IAdZn37g/DPeKKQ0sgjfHGzHluz?=
 =?us-ascii?Q?s+FFCwZTSwE0agyAEB2bhXSP/jy5vZiTDJg/Idq7iaBPu2gKbmc9PicwyNIV?=
 =?us-ascii?Q?0z2To8Km0CljlgOWHne7jBakMLpw5OHQwxBqoo35NiqgdrFGadX5j0kFKQsK?=
 =?us-ascii?Q?VFXrh8mKwDgkFIs57qaGVbyMLhCEaFOxucdetS1CrOCjspm3k9bd5XmcPB/7?=
 =?us-ascii?Q?aa7Ox2c1z6lsESuW9p+OBdK+zwBRApnC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D1DbS+0n2xDUhvZTNRKrpcqSz78tD3O1+gEHwfprfONX17uid+ggsf1eKPkn?=
 =?us-ascii?Q?FsrBmmeny5/9OUcfp3snp+kbZJNdJ1bMxEBh2Nqa5cP1qJ5o5BWjsp/HvsCT?=
 =?us-ascii?Q?SlXWfWpOmEWNMdhMBP8WTtjmicRnDe4HbEiQtU5qlTqMr5/E20YLkp+REDpd?=
 =?us-ascii?Q?UK1SWSU39dEtuss0keeEqfHsOYXjdQxv5TbKSd1MH5MjfQkh0AxTY7tNC9ke?=
 =?us-ascii?Q?hGWtnVZb0RaF/Qz1Q0gJjtet9FRHoTYsCKY1vAof5qgOw8X0D/JZKj+x4ioB?=
 =?us-ascii?Q?pZZVBQlZVz0k5MPG4uLYoh/voLMkvIwgnA4Qol/50ayVzQ8Wr4GfUXppDw6e?=
 =?us-ascii?Q?4E8H2SfTIE/tlSnoDvEBGFy7FXMGGMZRgIBETPrjuGnp1v+r474NiaAK5LmM?=
 =?us-ascii?Q?k06V3a+INzoJSjMEUwIxZNRez+VXilNmoEOYAfuuhHUPzWRHJMB2SRSQkozw?=
 =?us-ascii?Q?oy+K1SfTbO90IOALwQ/dtm9akXbk5/Mm2aIczxQS9YbYyCmtMfYfDctivCNK?=
 =?us-ascii?Q?+HGMgfHlkusj3L7Cn1ko+NGyj+y12R0mvMSyXtS/eH2QNq9Tzs/Bz/SdZM08?=
 =?us-ascii?Q?v2fUPUNgVu+AIFmFN+hD3+HMf2PjYsteTPAKyzmaepmj+s+bQKHJYqrZpSUV?=
 =?us-ascii?Q?HGyL5xrGhJL3NU1SYZIn68LLXcGbZ/qKY8pRtS6F+p0sJYeX60m9Gj4rVGgE?=
 =?us-ascii?Q?Kpws18VDU4/zENnYhgxCOslddV/3JCQyEKMijz0f7pMloqgR9tyCgFfji/nb?=
 =?us-ascii?Q?nUwf4tWo3JrbiKJrZ7xJIlEGBFpx6NT5bGRIv2vz2UWxIY26PQSUIKUQaT1x?=
 =?us-ascii?Q?FQqvaYfbjBZ4TgXd8BE7+D4rukdsBtTLl2pzXRTJFogjPFsaY+ZA5luLEfA9?=
 =?us-ascii?Q?wIuYL3a5SEU0foflGPyX3IMfjONdpf3vFqjx6An+evt0zqCU8HHlcqearVYL?=
 =?us-ascii?Q?RppXnaIteFsJNRJoqkY9us4AyltRlRewI3irCYm4nPeEMQ+Yps2IM+TsJ1ga?=
 =?us-ascii?Q?r0Zk9VPgbms4ATIWyC5gcvfAej56lXycBjEhejYrYdUWyG+5OyaQSqj5f+pm?=
 =?us-ascii?Q?02fl3og9PQ+kWcxwuOizgfD2nGjTUOuUNfu0T5a+56KwkMNU/5xR8ZEJA8vn?=
 =?us-ascii?Q?iMr1PCRpgzqYCExKFSVX0416wB1wvl6p+ZX2zod0IV+S/yA3J4kn/nlGybu8?=
 =?us-ascii?Q?e3svfYfh/NSiob/wCKWu2QClpDdE6NoZ87Sp1nWjZ9mHag8TNxd7wNGUejTB?=
 =?us-ascii?Q?zNMbNRXFvokoNt/HmYBGNMAlnaMZEmsOPd6rKB2jWdT7anbFSnI8u8XoodXo?=
 =?us-ascii?Q?Kcyat2G+AjIanJ6D4vqGy8oDeT098qASkcxyu6+s22d95c7YYW7BVUoS66f2?=
 =?us-ascii?Q?685jXP1Q3XbwILPee7EZcRryq7fNI+SP0caARpAgAVsSPCuppkZ8Y+JkZzwX?=
 =?us-ascii?Q?NJzsawSVpKL0vPV/w0Q+wGyo9LKdFDAP8iZVNlRUj3yZflggi5jIpWAoectx?=
 =?us-ascii?Q?7mTfQzFtpcfQLpHQGy8XJkjIsv5dS/MmObCh9urtt15BrS9vxEWOmFtgG1tc?=
 =?us-ascii?Q?uG1BEa+0J5ocQfN7l9Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04068ff3-d680-4911-4b23-08ddf0f98f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 06:07:59.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WC+nf9aT82qR1fk+Idon/jzzuII2TyM0+YWaWjCkWTlOKKfjOwAYjP0aK/cmkCnXPK2oB00YZEJ9vc/aCgkcZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535

[Public]

Hi,

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, September 10, 2025 10:25 PM
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
> On Wed, Sep 10, 2025 at 04:59:54PM +0530, Manikanta Guntupalli wrote:
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
> >
> > Changes for V6:
> > Removed typecast for xi3c_getrevisionnumber(), xi3c_wrfifolevel(), and
> > xi3c_rdfifolevel().
> > Replaced dynamic allocation with a static variable for pid_bcr_dcr.
> > Fixed sparse warning in do_daa by typecasting the address parity value
> > to u8.
> > Fixed sparse warning in xi3c_master_bus_init by typecasting the pid
> > value to u64 in info.pid calculation.
> > ---
> >  MAINTAINERS                         |    7 +
> >  drivers/i3c/master/Kconfig          |   16 +
> >  drivers/i3c/master/Makefile         |    1 +
> >  drivers/i3c/master/amd-i3c-master.c | 1009
> > +++++++++++++++++++++++++++
> >  4 files changed, 1033 insertions(+)
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
> > index 000000000000..cd9d85a0be80
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
> ...
> > +
> > +/* timeout waiting for the controller finish transfers */
> > +#define XI3C_XFER_TIMEOUT_MS                       10000
> > +#define XI3C_XFER_TIMEOUT
>       (msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))
>
> Do I missed your reply? I have not seen
> https://lore.kernel.org/linux-i3c/aL7+Urm4NB9kwOwQ@lizhi-Precision-Tower-=
5810/
>
> If you need define two macro for it. Need unit XI3C_XFER_TIMEOUT_JIFFIES =
to
> avoid confuse.
Sure, I'll update the macro name to XI3C_XFER_TIMEOUT_JIFFIES to avoid conf=
usion.
>
>
> > +
> > +#define xi3c_getrevisionnumber(master)                                =
             \
> > +   (FIELD_GET(XI3C_REV_NUM_MASK,
>       \
> > +              ioread32((master)->membase + XI3C_VERSION_OFFSET)))
> > +
>
> ...
>
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
> > +   iowrite32be(data, master->membase + XI3C_WR_FIFO_OFFSET); }
>
> i3c_writel(readl)_fifo() did similar things, why not use it?
>
> Did you miss my review comment or I missed your reply?
You have missed my earlier reply on this.
The helpers i3c_writel_fifo() and i3c_readl_fifo() rely on the CPU's native=
 endianness,
whereas in this case the FIFO should always be accessed in big-endian forma=
t.
Hence, we cannot use the common helpers directly.

For reference, here's my previous reply:
https://lore.kernel.org/all/DM4PR12MB6109F6D5D032723C675472448C0FA@DM4PR12M=
B6109.namprd12.prod.outlook.com/

>
> ...
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
> MODULE_LICENSE("GPL");
> > --
> > 2.34.1
> >

Thanks,
Manikanta.
