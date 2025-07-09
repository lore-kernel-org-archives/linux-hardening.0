Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61961FBEA8;
	Wed,  9 Jul 2025 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054263; cv=fail; b=tGTTqr6jgLUxG0TVIwp6qMx3sWt5x10kJZ4fWHJ7z5LDazkRRi7/eiJlgmywdC61C59bUIk+pwEd6iCMmS0JV1NQbDflGotwGBppBO1kGOdsXIf1lcNdLV1QWtiP4KvHccHEfpaZR0hdUSZ2oL6m9V6iC5/9kni/eIFsi5FgUVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054263; c=relaxed/simple;
	bh=FrHnshCTIDD3KrbQl3f2b9IW3JwMi1n+6dmI0XsFZAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IBw0MECN/GJ0Sm++In6Otqq2HVnU2K2pIh9q4r+qPd/M7i3GWRnoA3JD4Nk6hnIO4YMwqvb+KWspHMRRUGk1y0h37aR1SJMMdqpfZaOHqXW1/4VQ0DGIGHu6E0KQ7Kn9xMg/KFmtiJuR9kJa48HshQ0TYHAaFxOtsWwmZIC9vA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=ZjWQaJC2; arc=fail smtp.client-ip=52.101.69.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="ZjWQaJC2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Imm7vzAHoBWkyWsQjv3PmSKThPof331PZBT3DCNG6imUC6pdIvH7OI5f0ioegPKwe+s+eGZVbeIYRfNApLa2xaalTuqB6SRpnfUuaw4GHtP7riRNnpTR0ovZinzATcAK+KcSQLoa7JdiFHVqSkFZ6lB1rtpAVX2q6Hb8doh9q2QVHp1Zt7ZqXthBYQsgSbIfS0Wrh4GwvES3RzExBc3qcSZTAgPkKzomSocwN1WudB59tjg05ocsKF0u6k4UjdtqWQWEfJYq9VNfXFC06Eg4TOyYx10motcMzWEWVwtJFrH9mg8qi3HXRgg5AfQ1V5UzQrUJ+ZfS8hoPpiHp4W+XMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHKH0lFBPqQZa9thNM46FSaLd0nG71wf6ud6B7DhfSA=;
 b=oimgyhRzpftD5Uw/K6p8iK6ZGdTS9rKOg8JAqrkxstd4qoioiSErR9dGgXoCRW6RRi5DL0n4FmuSh/XDjAdaTSCgjqdV7wZPR/Cs4D5f8sSRgmV7c/uIulusysMBVYCVvdMhQVqD8YmrzY31hyl7p9U6W+xJWRoT5m+j2f2b4zv73rhfOfkxfwr6WZmYO9vFQEalkvEFkTErbMFiXerMXHT4DMTqM5EE3bIz9G6/okq6VrwLq6L8FMttlPXmc+I5723NBltQoidA9/5ecHwb++j1213O2FQ04RWMrgyiCILXFp3zn568wNLItiCJ2M0tCt3xjpy0mxyXUCH5s/41vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHKH0lFBPqQZa9thNM46FSaLd0nG71wf6ud6B7DhfSA=;
 b=ZjWQaJC2IHBh3kCM1DJqjxU9l6VguaUSc0y9TW9Oml3AJ506XZ+VayDQb/ZzGRzir8OF3v7s3cRg76EpNP60u+Lw8eUv8l3I5A9Bxf5BXDm6z57NZo9NefHhFhhtd/nWkU3UC427/W3GFDp92ucCuuT6nLE2YHCGJLDQp+Au0e+xIz+IqD3RB6xW8OQWN9r4sRXjhsRjYJDagcrdpjhfElPepYVtOWdYljS2NVNgdD1SwPciiOQI+jcC19JCwvxyo4+KggnnD5TP8GT/PUfaTILfRn9A74+QEgrpxyhIA332QMJANMSXS9ULVy58SsVjmEJT1p6mDk5f4diBsHtH4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com (2603:10a6:10:2f2::12)
 by AM7PR03MB6386.eurprd03.prod.outlook.com (2603:10a6:20b:1b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 09:44:17 +0000
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72]) by DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 09:44:16 +0000
Date: Wed, 9 Jul 2025 11:44:00 +0200
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shawn Guo <shawnguo2@yeah.net>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>, Frank Li <Frank.Li@nxp.com>,
	Markus Niebel <Markus.Niebel@tq-group.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Michael Walle <mwalle@kernel.org>, Heiko Schocher <hs@denx.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Tim Harvey <tharvey@gateworks.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Andre Przywara <andre.przywara@arm.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Kever Yang <kever.yang@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Tobias Graemer <Tobias.Graemer@mt.com>
Subject: Re: EXTERNAL - [PATCH v3 3/4] arm64: dts: freescale: Add
 Mettler-Toledo Snowflake V2 support
Message-ID: <aG454AroaRdsZzpZ@mt.com>
References: <20250624110408.128283-1-Wojciech.Dubowik@mt.com>
 <20250624110408.128283-4-Wojciech.Dubowik@mt.com>
 <aGy4qy1kN3RZ6nas@dragon>
 <4f2f2f95-d0f4-4d2f-8873-b1026340a8c9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2f2f95-d0f4-4d2f-8873-b1026340a8c9@kernel.org>
X-ClientProxiedBy: ZR0P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::8) To DU2PR03MB8123.eurprd03.prod.outlook.com
 (2603:10a6:10:2f2::12)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR03MB8123:EE_|AM7PR03MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: e02ede9f-22a5-4318-4b64-08ddbecd2b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5NIMK9mODr5FDG5io1jB09lHnKLgb4sst7E7C6twrVZReCy5Nh9h8gKqwK/f?=
 =?us-ascii?Q?hpC3ZKrUUQw7QStcPFr3F8SNFCQqwhQqPFqanYHpYyfuPhUAb/8m9+x20DgF?=
 =?us-ascii?Q?ILMcc+kVp9NjMwLTFIIGTlc3UCDi5nCTA5EvAlvKjeymPIGfeo+WaTgEhKmI?=
 =?us-ascii?Q?2NPsTaCqwsldDxx4ChrvhUJOcSCyVE4dwvsdyW2eNPuuG8hNqYUInoV297+j?=
 =?us-ascii?Q?BtAvjkdEJx14kaZmRCE/eKN5NOCAnSeCkTFLNSRBXnGpjf2BTCrs/8cLzpaA?=
 =?us-ascii?Q?BWc/8ACbprtTh4jhl2xDvyCGS/lpOjecgPxaQshvNN2FsMg6wDtDopAmUjHY?=
 =?us-ascii?Q?IZ0joAh2n7wca51K7hP/5pQfA40V8a9KAX5cbKlhZrdxXJohAaW/93iA654v?=
 =?us-ascii?Q?BjCziL8YvtyDE4a6+0Tmfj43rg27j404ZjgpjJZZVqWZUJUzCv2/r442B5jc?=
 =?us-ascii?Q?Xq8AmSFaq5Dh/0vr7trhiobzwjfSQbHMRB9GANVfHQSFuGDBLuCZbVKZVczZ?=
 =?us-ascii?Q?nT7QJZXmCW+lGRvlmt1EkCjFGBL2+1rc3XW+1Kkk7nKZynBisGulQCni6h8w?=
 =?us-ascii?Q?TwAGVPFwnPhScsygZil2/s+IPpqyYqgQ4Xr7b6UzoxKTe+n6F4koG6CoY6XC?=
 =?us-ascii?Q?OTpn6MQIzCeYSgThbIiTdoNan6xpK6S8WdyEQ4p6MwcnzLNdxNdDsDKLksDA?=
 =?us-ascii?Q?Fm3HEhByLAYejiMUlwHDXqustlM+4dlQJHYt4LKTl/1TYfXUGQwvpWpFYDY6?=
 =?us-ascii?Q?9N62Yw/LI5RHUUWE6FqqFagl5NbA5SfszR/jgAiGoBHERaygk/CQKtunQvya?=
 =?us-ascii?Q?j+lNWxHY8BTXgaSJ0h7QjYdZj19Elor01UxK2nU5NuTxfSgI8cvwoVOuU5rR?=
 =?us-ascii?Q?frUIqfbMYU7jmsJv3wrCcw6Z4TZ/zj2bbz2/ca2Sqa9z1hEk7kilv7yBANaR?=
 =?us-ascii?Q?G2SfGsySM+ZsLhb/EYJtdZZJMrOpo3UUAKe2G78lIAx3J7tjoKbMKwkcyK5T?=
 =?us-ascii?Q?ZnB4Fepky0Ry33NTG2BFXMmdag0giCChNXg4cHSr3Sv/L6fc5gw1dagNlhAi?=
 =?us-ascii?Q?skG7VGhpNh7dSBxKsY+eKEl1SB17IBkEKPjjRZ0y02zcHY0lfTJDzLtZawTb?=
 =?us-ascii?Q?3UD56zA1dc0RBeTgeWwq90618GMfC+5AbEfGnW2NDwNF6J4gisAvGg7jihmP?=
 =?us-ascii?Q?71wX3u7e+HhtCNpMtCvsQOnBGh9MRc27Soz4xi3LmG59Cs6TUeiOezgncFPv?=
 =?us-ascii?Q?inYAKqqPt5mdzARuF6RxfV9E2OqoaZOjJ9OsjzaQehaJIQxTIUZseVVp54pX?=
 =?us-ascii?Q?hMreBdepkyYfL8xQiNxFIeptmXoWiSGuAO3CNAoasnpu+v5xZZRkB3ePvCxq?=
 =?us-ascii?Q?vKF9RlauLmowxT+sbcp4ng48U1Ey4db00K290vznVd4pVXOuTtj+Mngt5h4e?=
 =?us-ascii?Q?9z2kp3nrqv9IBntj3N/AfnDW/k1TSIkojVPF8lkV3kocSBO+MEkp0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8123.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wXi00Jt7TTMivUgns1D6Wgw5lHujJpCnwBtP6ypztXcsLgyBz6glLNkvD0yE?=
 =?us-ascii?Q?A7Rsi9HeIK5Vcw/Oi9srFUQLk+Z7zEWLrBjEllN0rtalWiEzj9IxrjAeb8dZ?=
 =?us-ascii?Q?7AtHeAWoWLui26V4kKrjJAAhMBHQTB7wo18g3OlDeOofBz2FsNat5SB+kG5Y?=
 =?us-ascii?Q?S8bhBgB/XFaxguvfiXfFs+tmsPCvAJT+PKlMn1v5/6bjkle1DJokxllDW33G?=
 =?us-ascii?Q?6ZvKLDMKmteLg66M8FjeKM6zVoX1k+mvLc9uczkGToOxcKV28jEmMXYI3oQ1?=
 =?us-ascii?Q?1FREGe//OJZuR6plaFTQx43YIdT8j0KE3r6AUjCzh+X1LTCwVN4r25bqNhdP?=
 =?us-ascii?Q?/bOIsLIgluuYbkfEXIDlycdXXrNpl+WY/Jsl9mcFdBkyLCHCcfsY3p/A7gbm?=
 =?us-ascii?Q?AXVyuya1ZPTJ7/paSZNSbmCWnazqtBRjuIJledCltXmQhq9+HgSnUC0+lNYn?=
 =?us-ascii?Q?geYaUDzfF/2Pn7j0cMk5nOg2MDsg9zyBZKQtowR/O4QEYaA7mvRVHOf03Tzf?=
 =?us-ascii?Q?X9MtRUkQd7amJJ23I/3RuacVvoHFYw0VYTmSyv0t7Xfc7p2/ynGNlIRvCiCp?=
 =?us-ascii?Q?c4QiNkQPxNRQQnhHVJVn7MUFiJQzB15/efWyFkgVWEzRS2l2lWAk8tyrNk00?=
 =?us-ascii?Q?ir4CiKc1/hw51PsmMgA5arO1QeZGWkPzWQLWI9c06M2n6O7SroeMKa2w7rqp?=
 =?us-ascii?Q?TzxTunYF6vtYSVWz9PBtTDHDR/dps3MASlP2j7t4m24G4rUe21Lx8n1UW71Q?=
 =?us-ascii?Q?VElECoIKXHoflq5yD/dgnIwm7m4Rm35RyJUUinf59H6dnvlFP1K5LAQfn/ar?=
 =?us-ascii?Q?j0k0TD8TH8JAbf8y/uvTilkg9tXOsB9kBf2wJObldl82VFfDJ2HRgm54Hv+T?=
 =?us-ascii?Q?/GxCqGyaVIL/rikvCu6IIYQxcAfz8XzxEb1bYc9BYC5gL0ro5iqOUWOZo6Jv?=
 =?us-ascii?Q?oniSb2+HhZg83bVBzcOjT6Eoj68uA61aaLR1SSN2qV3Et5ln6HzSlqP3VwwE?=
 =?us-ascii?Q?OjdyPKmGAbt66yydpSmRMVwoCb7tN6uwteUwkFyxFnducFCCNtwXLp51zqcg?=
 =?us-ascii?Q?58CXqG9OeO5A+HHobReblHgpdnfS7zuGcxyhC8OriQTgHHj7uXSxgr8Db6pF?=
 =?us-ascii?Q?FZDMHW0tG0+C5ZAQH/KLSfB0pUqLqCGPvKu028mQstseuDahfqpj67ucitB+?=
 =?us-ascii?Q?Qdiywj9uyM/ipaT40Px3TxCvl4XJqz0ePU9ERM+SUQiPkpw/sj9rCaDMraMv?=
 =?us-ascii?Q?NfC7o2D5lZVjBxKcwEkFPb5XoV0+At40vsaOecwxSITRV0NMWl3hAPze4gTA?=
 =?us-ascii?Q?/vBn7wBaNTHTZxC3uQGOzaN8RhY67jppbIAgL1iCSB7tL/XeH9Cghktkq7vT?=
 =?us-ascii?Q?xxFJQgJzgyNjVdI1/t+z2JqzL6hp4si2v9dHcvuNPUYjL4j3c1n+bb6H3rUn?=
 =?us-ascii?Q?e4ncsOGWDotwgzkqlA18GJlwzRfWa3FnnE/H51QqE5Zldox+o2xWPoS+oXyQ?=
 =?us-ascii?Q?cbOwlPwd9tcrnj/8geq+PEtWk2LsiNCVWOdaph9OeOrRGKhDck9CKu21YfEN?=
 =?us-ascii?Q?tBmpj3LfHtjS6y7DgQRpBB8R+M0u9kDx9i6jngpn?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02ede9f-22a5-4318-4b64-08ddbecd2b73
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8123.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 09:44:16.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZlKC8As20IdQ6xIrYbEPTMWRSXOj/UI/KasDfJIv3KTPEKmX1MZOPtPzd5lkAuGd7/Jrtagv8HxmaG4O58BCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6386

On Tue, Jul 08, 2025 at 08:27:50AM +0200, Krzysztof Kozlowski wrote:
> On 08/07/2025 08:20, Shawn Guo wrote:
> >> +
> >> +	backlight: backlight {
> >> +		compatible = "pwm-backlight";
> >> +		pwms = <&pwm1 0 500000 0>;
> >> +		power-supply = <&reg_5v>;
> >> +		brightness-levels = <0 100>;
> >> +		num-interpolated-steps = <100>;
> >> +		default-brightness-level = <100>;
> >> +		status = "okay";
> > 
> > We usually use "okay" status to enable "disabled" devices.  It doesn't
> > seem to be needed here.
> 
> I already asked for this in v2. Changelog claims it was done, but I
> believe nothing here improved and they just sent the same patchset
> wasting review effort.
Sorry, I removed it for lvds but missed backlight. I will send new series
with a correction.
Best Regards,
Wojtek
> 
> Best regards,
> Krzysztof
