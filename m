Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37913C67C
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071200; cv=fail; b=Bc1M3udLmsYZXqQoFa0Bgqg7y+ZTtHmEtHAHMShA6saRKOP9slKdGQn55oSsGjc97O7l/4k9ggnQDipUuG3GCHf1M2QXoplWa8QPd9Jqzc9VtM7rf1gxtkeNqViYS05FTzKYjTGSgciUk0BypaVvywGhOQoLssLxlWcF2jYpLDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071200; c=relaxed/simple;
	bh=qBzoB3Xvv43bzXzfYy9ZJ6kWec7BRovM5GV++Dn9JqM=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PGOsUlz0rlITTMJm9zsSNoPwjPuxqTu75G41CUTzBlJtVTbZQ4MoFtVY3ouPNl5KwHbJbg+xKonz0FX2h/wu7lxDsz/LHMcW7Tb3oKvVAbOVxw+YpJabi8BpUnATnQaDhm3WstWeUBP9lRVqJH5+WZqFD/KtC+mqiS3cciFAlM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Nt80GxHT; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Nt80GxHT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMA4eVsAz6hVT0yrx8lA4FweRwNaDcaF9uOU8IsTeMAQ472qUjnRkc1AfiwLZKTXdPjmx/hscsOKDA7MWLyUqpa/7EA/LGiDR4VAoYn9hW7HbxYqMsLwfqm7ZGw+qbNjFItcL7Vzc3SqrQ6uV98ZR7IGJ1icQKIoN6RzxjxiVsLjeF+a/h+ULMRQASaFYio2lB1r24R+SWs9tC3N3AU7sIKDzr8NGRCBmTbB9a2h4DwrVrgXsSUOkEybK8SliVzz5/fRqh2Toim3hZMJlljAr4espTjrLg2OKRRShdkqC1oF5BQuOZmjbeVEEYAd+KZdkQ9vV51v/qmMu4p46JafVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgsBcaBv3OiyXz+p7COYsVA5qHP+nO+WL3xrMrZMsMw=;
 b=MA56kOKzuxQN0o6te7sqv8FkBAfDukDk5DWQp1Lw3RB+EUyTqdTTHopYC1ytMdJBno5f3IeDVZRqLUbZstSlDI3pTjunArIWAPhhFZcKwWLV6ohI30F1pkiTATf7BrY5lpABoAdJ18X8QFdRAgrmJJJ2m+BYLJKG4r4qFmrZj0545+LMUFcwUi1hPWthNRY0jx43bQMPH2jeh/GiRQsVXsoJrhRW/R01E6F941C3SCeeJ6W7G0UIcqnrCmzTnrUcbStHaIyS8lhIMVWshu6KlLrRYzZeZoh0cI/eGJmigDY9R5T7AeOjXKo3HkBcP/Bx8LIvTDNaY3y6si8OgnkCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgsBcaBv3OiyXz+p7COYsVA5qHP+nO+WL3xrMrZMsMw=;
 b=Nt80GxHTh+zeHt+mG+0RN5RphNZeglNzndX9nvCfMLjxM36O9hMIiPxCrrKo81nMQ9i9mnQXi8N306B8eKWzjeKrFQRoVojjTuRUnnIVORD5j+sHxvVr7qSi9G8i59EvZYKMugRzbXVtJDRJXn641kgpXbUtBdS174Kd5lbzjgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSRPR01MB11634.jpnprd01.prod.outlook.com
 (2603:1096:604:22e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 06:53:13 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 06:53:13 +0000
Message-ID: <87sentnv6u.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/10] lib/string_choices: Add new helpers
In-Reply-To: <CAHp75VdeNoz=QoiMF6hK+eJZH2N7+vUm+1-ovmwGAY5NZ_zTqQ@mail.gmail.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
	<CAHp75VdeNoz=QoiMF6hK+eJZH2N7+vUm+1-ovmwGAY5NZ_zTqQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 06:53:13 +0000
X-ClientProxiedBy: TYCP301CA0062.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSRPR01MB11634:EE_
X-MS-Office365-Filtering-Correlation-Id: e76fab9d-d298-41a2-12a4-08dd5ae93bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EfzWDHcUJow9XeJgKqq6qXFwB4Ky+hnH8cGilZQZNZ/wnFHYWab4XZJjpSpm?=
 =?us-ascii?Q?/NmS/fRaA1XC5N+aOhhgac3xlchovTaoPPFMtYHeE1lIpfSV8l9UlcrlffpS?=
 =?us-ascii?Q?WoAYvgLgy2TDJYhyAJbwW0G5PJC/DO4sCMHNhBtxD7Ho6wOKLimAn1Fb0FtO?=
 =?us-ascii?Q?6EZZdEOKNtGWzIkBwNhA/9WDpOrWG2BMOfbUMVEjK//rxnme2vLb63IFjN4y?=
 =?us-ascii?Q?BHM/LpFtOMk/maYr9EOkWU+m7ftZnDxwrpeu/GwBzWT+6j+x+FiI8xehBOF6?=
 =?us-ascii?Q?kNYQ8CuMPro9zT3WG8k0W2npBEBWqyFInPhCBXSIxVWEtG2676PHvu72YRyb?=
 =?us-ascii?Q?yVv0JP4QiYQT8khgfSoagh5x0JbdhJobbTDr5sGZS15otC3xbvmuPOxgxsYE?=
 =?us-ascii?Q?TYRKMyfLDvRBGFw4lIcIekl97b/K69AWeJG173t/nlhmDWKmT9JiQPbSVNPU?=
 =?us-ascii?Q?CufOS02g/B0BUVm6JQ6LGu0/1sNr33Iy96Qv/zvzkGXHvmcwtWFtvAfIfUTA?=
 =?us-ascii?Q?NdgLXt8JI/k4CwpHUeXaIbmU7X75467rZAjn9G2YYQU9dGMBn+RagTAOOiZq?=
 =?us-ascii?Q?TlDWzMwjpjv1mSmwBVkZyIm3ALYc/zry1lHY6IjBaM28Rt/Qm2XKRVCJFr5F?=
 =?us-ascii?Q?MfDxfRji8g4jAMONRYOk9aIdSeovxPuVf0OxmHIUdk6plvYvl/v8Gy93ngJQ?=
 =?us-ascii?Q?/Gr/YON/7p1EXYFSZ9EsUYlzRlnMYw1CCT9l1iorcOMP+wk/Wqfmq739/8YG?=
 =?us-ascii?Q?TecKbh0N5+Sklh3wVrcoIwF5fchuWy4kBqaju1e3kcMYPv01Z3ttD7oAaJWj?=
 =?us-ascii?Q?ea6iItDZMiH+MKDrFZi/J70itNh1vNvLlfvZK7xXM7ZmVY1SK08sV62pklDw?=
 =?us-ascii?Q?uma2JXdunNR50w/hCpg8sSKbLrI2I0uqzxPHA9LCrHUK7y4E1NAQuSToRwoC?=
 =?us-ascii?Q?z65UpCmyudK4XcaaHemzrla3iAAai+7BAK2KSSZ9gsKn8pD3/fX8myGXaHHV?=
 =?us-ascii?Q?1i9Tv7jeIQlNnPpCSL/KdJMlpJZpx1+82jXaXvPKgEn0dPi1SN0WwZRtnh5W?=
 =?us-ascii?Q?zWDEfqKqfWV3HHfXOQY3S7LUCJfGUojNpCV6pbK+Rear9PpGOKTRwAR0p2sy?=
 =?us-ascii?Q?tlDlXm+4ufDNZOH1A7R8z4jvfNP0ZfH3MNCdh5LN7WMxT8xEKcaThFQ2fjtc?=
 =?us-ascii?Q?mFLLFg3oFnRThvgImOO06nmFNKDqoXT+ctclE5mffThSSOrVsk55v0Xu1bdV?=
 =?us-ascii?Q?CRYKEtFNizYsvzBchEXcoomJMgjVsdFrX4Bun332ssKKWYdJ4cOi+x/N/U5b?=
 =?us-ascii?Q?cA+fgHinNph5+ZbbxIQdMIodx4D8c9Mw4luuCvjaNi5dqGISsE2CV9jYgywp?=
 =?us-ascii?Q?I/BbHrp1jZt2wyUGrPC/hOPACOKwVhw/bfM4beuph/hrw6TtLh+G9CjtDKBl?=
 =?us-ascii?Q?uaUXnuC5W9xgiLuM/+y9MDItxbSlrCa9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/aT02MJXcf/MvPw8w6jvRnKvaxv5f1BiQsWIqe5lsbn3mTpHTb9OxpTuKSM?=
 =?us-ascii?Q?kkbIQF23PNBl0w2l8dnaiGd33aKWP8y24FK2CNlFla63IoyLMWSg0Uj15Zgj?=
 =?us-ascii?Q?DzyA7qtb+q7XzVu/5A+8TlrG0X2+GxA32NMprEASHnxOrTD4S9D/oBfI1q33?=
 =?us-ascii?Q?RKsDCy0s3l4VJDhMyw7khBursaXtFXl8RKq8AMCkjs+gUfVF3Y1mFk/3gzRl?=
 =?us-ascii?Q?SKN1l7xxrFsKJmZmXqaF/g5haT0MFB1/oebGAtd1+eobNhVuv/b2sGFDegCl?=
 =?us-ascii?Q?07MSDjz8eVcUbX3l0LqDk70Msf27GdTNv8G72DAizczI5mSmaNAvPU3LBWcr?=
 =?us-ascii?Q?1L3jo9uG6llcVAjtZ3n+QfB72I+nfQ6EUZ6qkf7JEm70poqk/kncnaa9Fzqy?=
 =?us-ascii?Q?mJdU3teX42VOcGzpuYKQOUDfCWNb39ZaqIlg0jw6/qFXraqLNYrwvVCBCMwT?=
 =?us-ascii?Q?ae8mHLbgAtU1n2uxsS6mcNlQrY08miW+ESsDqYqSyLncb+bW9+5gMG14EcfK?=
 =?us-ascii?Q?zkiIr19mgMpBcLG3c+yUsbr7TlVIIyu7uL+5DwDsV6GS6Pv3ABk/Z5FGUXoD?=
 =?us-ascii?Q?yXrlX8o3/CtjKAlXITn6CaCaBz+WxYpxQcA8iTdRFbtv9qZ3281hUcOudo22?=
 =?us-ascii?Q?We70uN3U6j1xkCFP0e35eRuQRYTJBGFkoCMPq5kcGZP/vUgG94AcMduGaMXX?=
 =?us-ascii?Q?wmox6raFKg7kyTpLkuQHD2QpzO+Kq409K2rGiOR9MRJ/4E72Lm+yjXKbkSvF?=
 =?us-ascii?Q?oBB233UoyAT9U7kIzF7IlwarDEDT22aDRd2KVs7y305XsAF4WDwBmak3JCEs?=
 =?us-ascii?Q?0iPZ8xAoil2EzbDw62fgfdQB2dT7ErbaN3EWSeihc04FukqiUOB9V4+aqpRm?=
 =?us-ascii?Q?gBUzkmf93O4KYST3KdTILjVMaXr4CQwGEchO3MoM1avttC8q/xSSQZX5eBJp?=
 =?us-ascii?Q?VcRIrrIdcDVhRGCJtRfppiihKAYUaEXYi/vdzyc+cFqN0XLm++jo9WahzKLA?=
 =?us-ascii?Q?mzykMyyohXjWNT2n4ddDvC9ilanm17GcJ3xE2lgAl1xLPfuqhzd8RQn2f0tx?=
 =?us-ascii?Q?nul/AgWdRyWibgKg13QexyFNUxVYdDrIOmX6RxxLwe29ECNq0nsfEXMkIoN6?=
 =?us-ascii?Q?U0yL5RUBJ3OuCruWAKoHtGNm0XTyWgQyWy5OjyR7qsRyiBud354qvvZba9yA?=
 =?us-ascii?Q?GfFDcm/tC3HV8MudUP6GFZc1aFp9cGrIITOI1vksOb5Y9WeODIWlhsLK5/tG?=
 =?us-ascii?Q?qvvlCXur+GrFd+wnxsJF2VNUwLzCe0jepmopT0X7O46zdQcjQl0Aex44zkbg?=
 =?us-ascii?Q?tbx/sEqT7KKMJ9Uere8Lse8bidNVJ+uHZFhKaHdbiivtFQjbnzx2z+r9qO0c?=
 =?us-ascii?Q?pyO6xH+fkM2q8FY4MJKWi/YVyjopVBqwNRh287A5LvpbjcjUkvEiq600pX6d?=
 =?us-ascii?Q?0kzm/+yPTPALF+lMJZr4c7lnbWCfjsHzDTaSD4wEaWsYFGo8bbfVtseQCTJA?=
 =?us-ascii?Q?X32jhs7Dt78tl3/HACvqXQBiEm58ok+hJ5Vs2DfSWvnYUeJkXCFnOXUX9Jex?=
 =?us-ascii?Q?YDSTl9Jf06gkQ5/VkB8jEWgACnrTRhvKiO++Ii1JH+MhERALoQ/uiZ33G9d1?=
 =?us-ascii?Q?DMaUI+u+P9H5pEsRtHcWrJg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76fab9d-d298-41a2-12a4-08dd5ae93bca
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 06:53:13.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfglZHFaBFasfu3hG0/+lPniToaYvuEb402NdykRte+4FuLsWtd7WM7X5lY1DQCpPFAn4+g5AVEsPNIRrbKrm2QfiUOWQDfSHKr3/WOrJb1gMLFdTZ3Ye6Qnm2fpbMKg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11634


Hi Andy

Thank you for the reply

> First of all, please rebase your series against the top of the Kees'
> branch: Also use --base when preparing the patch series.
> 
> When you do that, you will note that the helpers now are ordered
> alphabetically (which your series doesn't follow). So, you will need
> the next version. But wait a bit (2-3 days) before sending it out to
> give a chance to others to comment on your series and samples.

OK, will post v3 in next week.

> >         passed     / failed
> >         succeed    / failed
> >         success    / failed
> >         successful / failed
> >         succeeded  / failed
> >         worked     / failed
> 
> It looks like something with the 'successful' / 'succeeded' needs to be
> present.
> 
> But in general here is the BIG NOTE: some of the strings may be used
> in ABI, which must not change them.

It is indeed one of my concern.
Not only above, but some drivers are using capital letters at the beginning,
but helper uses all lowercase...

I agree we should not change string if it was used on dev_info() or something.
But I think it can be more flexible if it was used on dev_dbg() ? not sure...
I will indicate it (= the strings might be changed) on the patch in Step2,
and follow each maintainer / reviewer opinion. Is it OK for you ?

But hmm... I will double check the new helper, some of them might not needed
if it was used only on dev_info()...

Thank you for your help !!

Best regards
---
Kuninori Morimoto
