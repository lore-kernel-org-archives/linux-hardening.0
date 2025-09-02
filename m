Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483C2E090A;
	Tue,  2 Sep 2025 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797018; cv=fail; b=u6ZpfAagP2baIf9USU1EbjBEWG6mlnvzb2AWC95Pkxy/JL8YvM/+yOlryvhmGTyVIZp3ZjMG7rFh17ePniogkjxv5ilL4FBrgjrZgMEQkT5WhxUGIWKmP6dsHwFGvFMVGeSoe/fc/t6wgFm/8z4vH7WWHWNWeG/9gY1RhQdoBNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797018; c=relaxed/simple;
	bh=+QbClH4RuwN+Key0rUcPVlRcQh5ZU4kJ3qnleRH9094=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KaLjYs628kdKFDIvs7n73a/tc7EX+coUIPaKz3HhJ8Q8IsLt0Wl3C+bn+HZne1ekaUwQQl3ymJ/mu6Lqy0v43cVttk/PZwLJLc0INjoHJSL4jeuDF11iCpVws2CnSkuaQ427tp3voICQKltsVVpIVb+5zdBanpQi+BpXzEvHO2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tk9gaoWR; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tk9gaoWR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mifRT7NkcyHa8OU4numZag4vJYppTfKl8PJoAUJGLPxWvc9LYHSRRAuNMy+XQ4zyMQ8reU6SL3Mj5xwznjpoTyjLvCbopTPvCtqnWKGtpenP99JjxlLEOHvcAAWVhCW0/l2L5w7mu7B2TTH5iKJd4GHkf1C68yeMZvzzslW4/zTiYn0QAhdCpoN+/2aM6ZA3I8148hTzDoJzF/MSLE1iSkQZKY7kd7PzxXBosEu0BAwSVwYE7ON5WGwtnbWNXX/T3M3KCGAYiLmBM8HTOaM1MBBK76OW98kkRRSGF8YYqX3cO1km4SeCHPcTFMb6oF2P4+jPFxwXEtMlmXuMd3FHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd754F7sezqMx3aTnO2D09tUf5pVfa6eaKizY+NrIOE=;
 b=rYj1enDSuw9q/+NkMUTGo3bMsC2wB1UAX3wuRm4lWyIPV2disljNKWGdA2ZWyt1RIivt2fbZDeyyc9WGpQ6S/q/O7nyblR4N+ke9JewSo3qLEa+gpf1TElUov/dFovBcJYqw/hIbS2bPWUfS9VKonHvYBfeTnwIBUokAQZcIDh39ElzfFuWjl+VZL0isuyw3WEfilj9g+HYlBH0zPUR9vk6viqHlYQfXoGy8pppijZW2BnIHhUzvRkfobgeV+qyRixahKJRIXTCsqIlDF+WagZbR+qjoM2j3af71y4bYaI5KcGMXZJcvMTT68auW25EyUxE46idN6/j08gUWY84HFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rd754F7sezqMx3aTnO2D09tUf5pVfa6eaKizY+NrIOE=;
 b=tk9gaoWRZ1RrbU5/fk4DEaUDFRbPA3nHGB8PwdsLPl0BRegOYbQOETCnX/sQyMm0bjLb9d5HSCkly8Ms9j+VCsRbD8+xZ/Lq8Ip0SmjpRWHPBxCWIMXT/dWlTPbG2M5AhAJe1mQhUdNbwlyyBGARnBtwOANXBXLyewZ4L26hbi0=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 07:10:12 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%7]) with mapi id 15.20.9052.024; Tue, 2 Sep 2025
 07:10:12 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
	"Frank.Li@nxp.com" <Frank.Li@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "Pandey,
 Radhey Shyam" <radhey.shyam.pandey@amd.com>, "Goud, Srinivas"
	<srinivas.goud@amd.com>, "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH V2 2/2] i3c: master: Add AMD I3C bus controller driver
Thread-Topic: [PATCH V2 2/2] i3c: master: Add AMD I3C bus controller driver
Thread-Index: AQHcGQhSrlaRhqh2AkWz1F3/d3Q4/bR+x4EAgAC21yA=
Date: Tue, 2 Sep 2025 07:10:12 +0000
Message-ID:
 <DM4PR12MB6109780755A2328968922CB38C06A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250829171327.2590730-1-manikanta.guntupalli@amd.com>
 <20250829171327.2590730-3-manikanta.guntupalli@amd.com>
 <202509012012480348cc7a@mail.local>
In-Reply-To: <202509012012480348cc7a@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-02T07:07:12.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|PH7PR12MB5711:EE_
x-ms-office365-filtering-correlation-id: f99a95b4-6feb-4279-55be-08dde9efc26f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?maVlfvc3QfgvG4cuoYXOT+5I7kMzupt/Uoj/T06d6VDxfUBbtDL15sdvJwPT?=
 =?us-ascii?Q?KKP0R49Y2EW+A+5rpQWi4XkEEbWNoICmVU1DLpNknTLq4VhJPt97SLpf31ke?=
 =?us-ascii?Q?zHM8xcx3pikOaJPOTc0icVu8e1adb8Fe/Uu/Yrf3E396oeeDABN19iGesqNa?=
 =?us-ascii?Q?Dxf+uzPP06w7qgTcDKOofOgNSjKlrLD+sq4VAIoB9TJXvbvB9Sv6x1La0vAv?=
 =?us-ascii?Q?HJ8n1rIo0fgt8DccwBbR5YB+Y18Le9e/+yhPInufvq1jDa3DBK0SORIwXiT6?=
 =?us-ascii?Q?DtLl1Q4O7bc98mKXdjOCP9mZ9kPE61X4ZDcHjQwJCfRhoBVmKonb329agX4L?=
 =?us-ascii?Q?2FUKCJddcKa00OPTle+imtIvZMiFs9WILBBArq3tEqQ04c3H2GE8NxBphGpF?=
 =?us-ascii?Q?Vl60K7YB9giL5+lVfrBw698CLDeq9LavqirPvCITWvqTSpFnWyq08YHNyECL?=
 =?us-ascii?Q?ULEEFzpoMSNC3Xn8v6B65GCUgieF8NPPJg+QsUW+vNm/5zJyZqo//TsOH0mT?=
 =?us-ascii?Q?oZwKE+RJAT4Gq9czdN+GNt6aiQLxWnXvFBTFnqQd3uV5U42hftZafMMGylvO?=
 =?us-ascii?Q?I6mjD9FpQadMxlrkqrYbTBsVfBw61p+eQ6TmWuKz7aANueQY6/+FlGwXNiya?=
 =?us-ascii?Q?vUV6rWA3CJhD68nMULuBRDK2xFyIQVfFvPl/W+fF1lE7iEPOyr2BtdrwKpnR?=
 =?us-ascii?Q?Kxjch9JDBOo07F3IAfIKyY93WR43NnoW+qugN/rH10MNLjcViwjH/xm8cuIV?=
 =?us-ascii?Q?nLWMlv3jGBcOKWreXr7RDp3D3qy8LhzoY4BlTnOOFRzemsMhqAQibDclzC5i?=
 =?us-ascii?Q?RHUYZJgw21iuW/+0HORRvi+phR3471Fzj2yjNTn3VW/Lh7BNBzoViWD+mOY4?=
 =?us-ascii?Q?LWBLDHPlt8xfr4M0zAq+tvetx4JS1lqmViX/hWh2DfVLyF9V22WULCZthTgX?=
 =?us-ascii?Q?YDJszRfn1Px1moMgH/mTVZwDxZfU4ojjVJ+30KtFIloNPKVRhELdAGjbBP5K?=
 =?us-ascii?Q?6z9gM4I6J8lSxkGQZ8PdBvSKcoda+oo6QXmQaxxVGwjbRn6PTLpXnjFm/Msb?=
 =?us-ascii?Q?38eUAulw6E/WifYH0z0NchJ8A/kBP9CubcVliPgE9uyqYGqmHgjXwOyCRj8J?=
 =?us-ascii?Q?aQGXaAV8/Tv1J38e+zn5M7LkWGtS/yT8H8Shf/8LY80bcx9rogDjqgoSwxeB?=
 =?us-ascii?Q?lZQA3NhBTdhKzimQGj8CfWmkG1UY0NbOWMb+ByjaoN4o2ozPZP9uCV/cJbDy?=
 =?us-ascii?Q?Q+aAKEAUOZ79Xj3YisgMp/hCwLJW+rueDZc+/Q7jYNi+/i5Ma/yu4SvGP4D6?=
 =?us-ascii?Q?2jUORRHe10YIT+HtzZPj1cVF8rnkzks4JT+zjdLeL4aF+rhYP61lrWsH9QYc?=
 =?us-ascii?Q?8vBgaokn0DkXB+o/j3eyVeAuAs4TaLU3uVo0xp+id+vET5vsEwhgrX9YdrFb?=
 =?us-ascii?Q?qpEOqF8kOSdkRATBurj8wB7+kq6PsAuw+/+aBHGkKzd9MIU0LV4I5g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rjuvj7OBGBjw0GcuImPHx8qmYWikOpBrfBsca74+uxdl/fpmV0MRVc6FZQA0?=
 =?us-ascii?Q?WXGtYuxCnMnpSpPtzVdpQgeI3WkW9jS8rBhrsI0q4OfinUMqEFAtrYwsieRz?=
 =?us-ascii?Q?gJEeMCdI61ZS2DvxndG5oYxEIbmQOmli9ZLFEOOU0xOctWP0WPDD28o2moAh?=
 =?us-ascii?Q?PhU31uyvvQ6qHDE00IGNPV6EUH6ME4DjLPYH513ulWAUY+o6gO0imqyGQUqh?=
 =?us-ascii?Q?N18kH39qp9Z8CnxOwkb4F8rk4T7tEm+FOPEPuAtuklU578+4OB0AKOoR7WRU?=
 =?us-ascii?Q?vnVh4pxBE0iN9tTy1mcRJhB73OG3wukMf0ksOMWeYOzynb718NvXBLpMoOvp?=
 =?us-ascii?Q?MAQt/+97U5xKuzqoqniSw60m9fnptdHihy50kCJJxeAF+AAf2lW3ybQhjaSr?=
 =?us-ascii?Q?bJyi8nGmVQeXFIfS3QEhClF8opnPdwSQuRMTAfLQ9FdgwOmVuHXE6/+BdhVa?=
 =?us-ascii?Q?ITax38/yTeYuGKdVM3rhABIBWFNQR0bRJw6t+WVbKrCv16Vpn//KUbbzxrpG?=
 =?us-ascii?Q?9AgYgYvSe981oGPstWv4ppAtZIPuuIWyZpfZQKhmVuzI1h5ypSqo/Isez9Gg?=
 =?us-ascii?Q?4Z1yY+Jg3hAVN/O0VXt494nOYS5tj+lpQgKz78JKKN/f6JtmMFqdjV/2K4s6?=
 =?us-ascii?Q?r/SW04Xk+ppf+H1J3RgAog7SB89IGRmJ8ZoJLXfTuhPYb2UhFGIRzaJqbD+S?=
 =?us-ascii?Q?yv4c44L8L+8zwYnfcrXf2DjwnXXxY63vT3I2su7yE+io/E7C/4hc5Ic/F57Q?=
 =?us-ascii?Q?3cWGlCr10fnSiPBOkZymrGljjgsB5DsRA32FCg2XAi1aimV8gwRuWDKbxECv?=
 =?us-ascii?Q?X/PsMZ5AOxncBUtTUTpLvWJvWfRTyQ2vnlTNMinePveIc2tZZScbemtvfQKn?=
 =?us-ascii?Q?UClhvjknH0m7m8a1oFRg81hzzbo0S6kl1E5CUussyhQPalke2qyg3A+PtzAS?=
 =?us-ascii?Q?DFNGk05JY72++pgxe7RhP+wKtZNmmiPhVFH8AbFINxnLgHFXV6xyys+uTths?=
 =?us-ascii?Q?jNQMIQfrE3k7g3I76q/30ZR7gMGqc3SW1idK3v20lRb4hzqe/iHQhfOTEOG7?=
 =?us-ascii?Q?8zGwFXzlWi8nM/1JdYgaUtSyF88k281jMEXsZkauvw/Xz/lp/dtkjvgZobNv?=
 =?us-ascii?Q?su2D8vrYLTb2aOf0KltKDunUctiskf2ctAKYSucE49E4tV+5P2n8DiWT69fM?=
 =?us-ascii?Q?1JxNFMvy79TiCRz6BSsDktIlLxtMWOlb3GT4aBqWdEDACMhkZxVqLoNE1wOe?=
 =?us-ascii?Q?5yh0R4mypZeRKzKJwcWfwcycY3l6iADvhzSRkzYg+WzHBn9+kLl/itXMIK0F?=
 =?us-ascii?Q?dD1uLVfRYcv14k7UKATb3E8221Azuca8zsgdbO1etCz6Ns+dz3DL/zhTbBPL?=
 =?us-ascii?Q?2YOi98hXVsToAcbNe3IDAylBRisH/rjvKTR6sW/nO+pJjUogAm+F+yb2tsCA?=
 =?us-ascii?Q?L4EXzeT35evpHpyYnxOpopfI+NY4wIq+ITDEQJS60dM0PQMa94/iZ24a1F5R?=
 =?us-ascii?Q?ZteQATFnHlY86yyhZoLSR6xzZvf6AkUb7kfFW6B9nMLi+exZ7IFKChPL1+t/?=
 =?us-ascii?Q?h0K7Jpv1xfVY8oZVjsw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f99a95b4-6feb-4279-55be-08dde9efc26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 07:10:12.4410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbmfoxPzMMRaQz3iDgPFKLIHRDO1NAeEzJf4Pon6N9cXaakY0j2glbfDhYfue+2JoLLmz049CRxcXKuwwXpYTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,

> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: Tuesday, September 2, 2025 1:43 AM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>;
> Frank.Li@nxp.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.or=
g;
> kees@kernel.org; gustavoars@kernel.org; jarkko.nikula@linux.intel.com; li=
nux-
> i3c@lists.infradead.org; devicetree@vger.kernel.org; linux-kernel@vger.ke=
rnel.org;
> linux-hardening@vger.kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> Subject: Re: [PATCH V2 2/2] i3c: master: Add AMD I3C bus controller drive=
r
>
> On 29/08/2025 22:43:27+0530, Manikanta Guntupalli wrote:
> > +static void xi3c_master_reset_fifos(struct xi3c_master *master) {
> > +   u32 data;
> > +
> > +   /* Reset fifos */
> > +   data =3D readl(master->membase + XI3C_RESET_OFFSET);
> > +   data |=3D XI3C_FIFOS_RST_MASK;
> > +   writel(data, master->membase + XI3C_RESET_OFFSET);
> > +   udelay(10);
>
> As pointed out by checkpatch:
> usleep_range is preferred over udelay, I guess it would be fine in this f=
unction.
In the error path, xi3c_master_reinit() gets called, which in turn calls xi=
3c_master_reset_fifos(). Since a spinlock is held at that point, we cannot =
sleep. Therefore, udelay() is used intentionally to avoid sleep.
>
> > +   data &=3D ~XI3C_FIFOS_RST_MASK;
> > +   writel(data, master->membase + XI3C_RESET_OFFSET);
> > +   udelay(10);
> > +}
> > +
>
> --

Thanks,
Manikanta.
