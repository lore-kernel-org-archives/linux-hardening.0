Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E822ACDC;
	Thu, 16 Jan 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042591; cv=fail; b=NllFOPUE8amW2csB5PENVGxZgh3HUycGF+HSSaqVKvLL66XfY3JVNccGj7mosG93FHmY8e1zFQGmr/8VGz7PRdmY2Z8DKPKhd4Phq9/H0hVO2JDkTeKGUUeR3QrjjngyxR9AvQ9w+J2fu5K0O1gqx5nJEhRtBpqubb+P88KWf+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042591; c=relaxed/simple;
	bh=zxUJrKJNX/BGIHAt07F+bsKRBnarN5Y4PpwV6GsNkDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NneJwW2TX6rIUWfFx7KB3nyaWXM5iw+JyDgUvKfJ0dWf6jC+T/+rttx0fKTGgcskpT+30YlclxKbiRKG4ATTzjYDcUI5xNBKqEYFmYPJSZed/fS2K5DOTfk1GQfT2I7Yv6yxvqxQ0+o2n/B1MJOI9/RyjwBvPSlPpiaJF0f618M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bv/Iaq+B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nyfUIr3n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bv/Iaq+B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nyfUIr3n"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEucKN032623;
	Thu, 16 Jan 2025 15:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=b2vQtv4pmugvHCroJ19VDleiK7oR1Qk3ay+R+lrzUdc=; b=
	Bv/Iaq+BAcu8guFfopPO+caYmZxBgQT8uc6YzmYTVPxaIM7SxFhy5LWef1BQ5Jq5
	QaeRMQUMFdYYYicr3e0MLZZFmCcdowKQjhjQ84Y/ciixtfbuE563jaMB3/0Nx1js
	MJQ4OsWR9QnNMEbSI+Oi5btrDmiPs5WtcYxGd8nKoRls1e8XIa40C1dVkflfBhcH
	z3RomnaZEYn/Un0NCbvoYkHw64fuBWd8QI2UX2ttS3ElNMQSaHTD8qck5r0AueFb
	abG2i9BoBUWAJyjqVkyCJW62fWYCf2t9k7GjpzieVp7hQKVX9l1yCvhz8cKMZfcC
	HDhdcb0z1C8aL2rSIrsWcg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2jn3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:48:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEA8eb040334;
	Thu, 16 Jan 2025 15:48:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3axqee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:48:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvCmX4w/uNWKSJkowywvsvBNP4gRzwkl2w5SlxWe3Zd02dYuaGU6kXR8C4/Ws1sFsp1jL6X7CmH5Rh9I6ArVdD+Z4WCbqTexg9I3+6+brQ8q3tcIjbnj4GwiIQPAS9FcGHgv1Fi0z7QxOVhDzEVLGmFlU2SwsCYDexNqjZE2CwhspXIL/hP9PPwWnaRJ/rcxLIYEeoL4xgJT5C3TWfSuBs93xBagIXJjB4EO5qUfPV5XxUfMVJRU6MvLiwRyoCYKL/z9RF+gpqf/DfCaAdeqlVxRivDC/SD2dS6EHI883Npj1Wrd8tjG1pKC1p8a1RLs9NjmPV9qzBXcFz/QV7yzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2vQtv4pmugvHCroJ19VDleiK7oR1Qk3ay+R+lrzUdc=;
 b=CMAeRrnZHDYWk3OTB2Jm0qSvy6uklpxsC/wjAQrV26qn3EmtaiepLWIQHke9baflqL9EeeF2Ferua+CJTcDtvDMin+GrcuNJ3m5ZtHCTDAZfiYEuwIqqLLgOTo0qykUmjuG2T5LgLmgAQa6RRW3yWsgozqwkHVeVhpXF1vgvxpjNcLAvExlS1WGqIwtIi8QHyNR66M2lQagJ0qsgjiZCM6A06PQaZM/VSHkLBt19wXzz5USW+9b/nEYK+3jTHLkHGB42h2CI8lDf9xvNrOE6/RTlYZPNL+lzqCcCsEKNvuQHWuKeaVqzuPKl2blRM1gKFfxMqb+3oxuosNJQLm+8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2vQtv4pmugvHCroJ19VDleiK7oR1Qk3ay+R+lrzUdc=;
 b=nyfUIr3ngpEpHghChfBDqWJASUIPxQY4Pybzcf2efz0xNhs8i6yUrCmXD0GaRbM5yPvuy35f2BpF0oGKAaR55IMk6cUBnwY8LBT2hAwn9RXEPkiCE9iBYd2MOcYiQCtysaqgOERunh/mTsxyVaUbvIoksBR21JV6tYMKa1sz9XE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB7198.namprd10.prod.outlook.com (2603:10b6:208:3f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 15:48:52 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 15:48:52 +0000
Date: Thu, 16 Jan 2025 15:48:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>,
        Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0638.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fe31ec-d047-4c96-d20c-08dd36454653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmJ0RW83Z2g4MnNvTXViM3lualloNWQrTFJveTlqM2xreFp5TnZkbEU5V0dI?=
 =?utf-8?B?dCtHKzZCU2ZXdG4rN0d4NDc4SnlzMXpzcUZmNEpsM2hEbURBM0tCNXNEaFZF?=
 =?utf-8?B?QlJyR0toazNUQjFjWUtkODlTK1Rqbm5ucTRiejZyWVBQQUc1MHhDSGZUUzRo?=
 =?utf-8?B?KzVuaUZ6NSs1ZWo0QVRWTS80NmJKVnpXRDY4TUVlSWtpbHN1VzBUdkY2Q1FL?=
 =?utf-8?B?ZUlBZERHY2FHVTd5ZlM2U0VlRStXTVdxSUk5RVVDUTc2QUh4TTM5Tml1SlU3?=
 =?utf-8?B?aVZudE5TSmUvRDJJOXZsZTZYU3NkYkgzZ0R5ZG5KRHNscHBraUNqZDl3aHh6?=
 =?utf-8?B?VHRqcUM5Vk9YbDFYNzIzKy9IT3ZacUtkM0lmTXljZTd1VlU4MDcvV0EvTDhY?=
 =?utf-8?B?eHJ5bm9ZejFKMzhDWTVSMG5aOXB4bGdVd0h1N2JoTGlVbTc3VlpOa3d5MU1H?=
 =?utf-8?B?MDRlWDZYNXR4dHZvRldudUVVcVY2akpTWGdSR1JRY05yK1hyWTBqdE1vSEFF?=
 =?utf-8?B?bFoxNE85TUtlK1pzQW5UY2p3TWVGU21qR3RQYVJsK0lWdjFEYllqVTZUY3ls?=
 =?utf-8?B?V3pvYmd1ZGJCa0IzczdNbXJxc0VzbXNjd29SNXQ3Uys0Q1UxQ2UzYVI4S05B?=
 =?utf-8?B?NDlGQU9HU0FCTThxTGNxTEtmM3JNWkpKZDAxaWw0eWNNSUdyVnlWMG11d1Vl?=
 =?utf-8?B?WmhBUEdsRlA0TXBpNC9KNVBNOVdEOWc1U3ZWdE9UTUI3UVFuTFE4MW1CL3NP?=
 =?utf-8?B?QlpQODJHZ3lwRlgwVXlIWTJ4QTBJQzM0SWFLemNpcTJ6Y3FvQThmMjA2a1g1?=
 =?utf-8?B?WVpFVktvR3VDRVcwaW5HTUZ4aVdhMXM2S0lHRU9oUldaeVEwVGswTUd3c21H?=
 =?utf-8?B?akplMmNTR0d3OFplMmpnMUxFQ01xN1cyQWxkSkl4cW96QUVmSXY3Vkk2UnFn?=
 =?utf-8?B?eHdxc3lEcGdkcy8rRk56RDh6OXNhRC81cGltUmJXK1ZJbEg2YXB1TmdObGlY?=
 =?utf-8?B?cU0wbFpZZWV2OGJSQmg3bksydjFTN084YmJuTmFsM3hLYlgxRjVUeURkZkw0?=
 =?utf-8?B?ckdLOFg3Sk1rNWVrTEZaRFB4RkRpdFpRb2ZnZlZHaWpJZEhaVHBOTDBaUVJN?=
 =?utf-8?B?NWNpSkdadUJrOFVYUXVqSnlSMkJwU0NCY2t5WWt4OEU2M2V0MU1uRWdVcXha?=
 =?utf-8?B?L1dnSGNCZk5jV1YwbmN1dzArMDJ6aUZMdTNLLytVOXk5a1U0YkR1MkVmZ21n?=
 =?utf-8?B?TS9yZ0tETlV0akx2NGRkelc2cFRIU1E0L0U0NEdlT04zS0QwT2ZRWXJsKzlL?=
 =?utf-8?B?YW1MUmlvNDBDNCsvRGdOZDZBa1hkT0x5YnU4U3A5SlEvQ0NaQ3FUb3VmWnJz?=
 =?utf-8?B?SWNSV0lFMGJqUFprUGJ4QTV5UFBXMTA4dWJGSjVidzczSnptVHBEQlIyblFm?=
 =?utf-8?B?TTZ3azIrNkNsK0Rkd0Yzc3NOYzd3Q2ZMdWpkOWhMWE1Ic0hZRmVjeU03WDZp?=
 =?utf-8?B?NFRWUG9yWHVJSVJMM1dYUWQvSVFMQ3lESy9YcEU2NmZneXY2cTRvOXBiZFJi?=
 =?utf-8?B?YmxCdy9sUG1KWUJSdkpNaUNIM2oyUlBwTFZRS2c2cTJQVDNnaEpxeFF2Zi93?=
 =?utf-8?B?MmE3aWdYaW95bzd6dWViRGZnZnRacEVRYkVjcTgxNHIzY3Q1MDJndk1ZckVK?=
 =?utf-8?B?UUNmNHIyME8wL0pVK3N3Rmd3aEVtb0JOaUp1L0d2MWM3KzgzNnZIb1hMeksx?=
 =?utf-8?B?ZEhlc0Y5NVoyVWhNeWFXN1ZSQmhxcHhtNlpRMGprZm5lK2FXbUMxVmhHclV3?=
 =?utf-8?B?SXZkaXZTMjlxMDlhL0Mvci85V3VaZlcvcmVSUmk2ZTlqUFJDZDI2OGVhUUZa?=
 =?utf-8?Q?t0GesDgOSKL2I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YitHVWFYbkhnOHJSR0hQaTQwbnNyU3d3K2w5QkFzT1JKWDVDNVpzb1VIaXBK?=
 =?utf-8?B?b245MmJtVEtOblF2azBsZFRMSFVLd1hLTzlLdGFxYzZLdWJLZkZyczZySU9v?=
 =?utf-8?B?MkZycVVxZGwvTVVHMDk1UW40blYzN0s5NmNCbXNKbi9TM3ZlNGNoalhPQ0tw?=
 =?utf-8?B?UXhMd2dSeER6c084MGJuUmxicnhxRFNYS0xPem5HcVpIbmdTZlVpckxyblNT?=
 =?utf-8?B?NFZ0TUxOQlc3amtCU0xLTmYxWXNtS3NZRHlrS0NPMld0NWRLRWMzcE5YU1Rt?=
 =?utf-8?B?aW1RekdQUGs2QUJxRXROQWJkaW5hdWtySlo2K2dOMEIxeHdWaERXakN5TTdy?=
 =?utf-8?B?a1VNZjMvVEY1aEdjWHdOZ2lUSDYyQjZ4SS9ZM2tRUVNrNWdOcUJaY0o3YzN4?=
 =?utf-8?B?TzhhZlI1QlF5MGYrM2JibytSakpSRWtubEdIUGdtMTEwNVFSOWpEa2wrT1c3?=
 =?utf-8?B?RmgvWFhBMDgyRkNpTy91MmdYUHUrUTl1b2Z0UWdzRUlZcnh0T3lyaVBZRDhL?=
 =?utf-8?B?cWh4dFppZG9Id2Z2RU9PNTlWeXAvUDBLcDJoYnpISWROZGtObUtCUXZWbHFv?=
 =?utf-8?B?cmxVbm5pbDhNK0tJMWVlamJEK1AxSkQ0WFdhZCt4RGpYWEUwSWR0SmdBZHpM?=
 =?utf-8?B?alFpNFFZd1JVZ2NubUd1bGU1TTN6Nks5U2tJMXBrOGNISG9nOWNOank5Tk52?=
 =?utf-8?B?WmF5UmFQamQycWk1VTVBemFld1R4Sk44SmZQWGE4RUtpNWV6ZjBjVGxCdzl6?=
 =?utf-8?B?YkxlbWpWaU1wSlBjMERDMFE1a2liK2haVGFzTW1SdmljQnEvLzdZWFoxQXJ4?=
 =?utf-8?B?d2hHYzRvVnNUQnZMSUhydldNYy9vZ3U4R0pIY2RQanRQNlNaN1llb2hrazVy?=
 =?utf-8?B?RHJ2cVJBT0diOFBweThESUZwQVcrVnBCellVUEp1ejVQSEpQLzZMQ2dDdkcy?=
 =?utf-8?B?NDFMNUtMSCt1MW5XUUVvaTZwRDdKZFh4dmFKMUFaajExZW5DaVJDSjZxZ1JW?=
 =?utf-8?B?WGFpRmQ2akxCK3phcm14dExvU1YvN3ZDcUVicFI4THZFSnhoL21WZ1Q2ZXdx?=
 =?utf-8?B?eHNocTZGT1JSM1RLVDZJMjUzSS94VnljalA2TWFZZWVzeGFnOExyR1E3cnJ2?=
 =?utf-8?B?RWFMbXZmR1YxMWFJSElZMUpUMmpFRGc1UUd6blVnSnlOMmxHSG5xZWw4N1g0?=
 =?utf-8?B?RnVldjM4QmNSa0xxZGI2VnQ3dm9aaDVLeDJGdTJIRHUwb2UwT21kLzFMaGs5?=
 =?utf-8?B?RVBJMmJtNjhkWFlML0dLMytZbWFFVnY0NEc0azdmZFZ6MDQ3SENjOGhFbmNF?=
 =?utf-8?B?ZXdIb2pZWWpkOGJHc2ptQzJoNzkwc0NRUyticXUyM0VOMkdoaS9DWStmZEhE?=
 =?utf-8?B?SXR5M2JXSzdLL3ZERDJBSExlbEwrVTcrVVZENDRFR0ZhMzBLOW1CUitDdy9l?=
 =?utf-8?B?dks1dmJZRytUblRNTGdaU24wd0RsSmx5RWtpQmJXUzJEV1doU283clJJS3hF?=
 =?utf-8?B?TzBUWE9qbnE1Yk9RcnBuNkVUYlJvVUF2ZEZJVlY3MzFHODJEMWloVUlrU3Ur?=
 =?utf-8?B?Rk9HRlp2ZlpONFdnbVg4WW5WYmFYMEdwRTNQZGRuQ1cxNE9WeHlaTThoVmxU?=
 =?utf-8?B?Z2dyc0VORjM5YlFtV2trUjlhclJ5TC95KzltcWl3SHAvWDRISlRRZ2xOcVY4?=
 =?utf-8?B?YTR3Yi9wSTZJS1BHTkdxVmNTN1dIVytaSU5EcHpYTDh1dkh6VmhzKzlsYng1?=
 =?utf-8?B?dnJuaktZSUtUZlp5QzV4VTFVSnFQUTduTSthRGNqUW45c3VTbW15L05QM1pl?=
 =?utf-8?B?dXhSQXlHUzhHajlQVDhYVWRTaUl6eXg3RUptd1QyUnZIWGtIV1A3QWduTk4r?=
 =?utf-8?B?YkFremlFdGRmWW5LMHpoVG12RzVTMmpGd3duSnZPSFVMcXV3eFprZzBrdTlQ?=
 =?utf-8?B?YlVVdWg5OWorRTBmYmdFV2NJSzNYblV1RC96ZUd5VVhrSUM3T0tHWnZoOVNF?=
 =?utf-8?B?M2c1VmkySXkxSWpVdFNETDc0NWtac3Y1WWduOG5wQ0dxWkZDMW5hd3dad3JS?=
 =?utf-8?B?QWxGaXJIc0VvaUc0Vk5vSWp5ZXdmbjNob3dZWFRUTFd6M2JOL0JYSlhTNG5H?=
 =?utf-8?B?VUlUd3NvNXJaNFNIRDEwYjJqeitURGJURjB4TlFFemFZRTlCWjllbmFuajFJ?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6C7ECzYsU7KzvHgBmv1C8CDVzxuZEezKjEmxhNZdokb0GZGFAMVOPOm3OropptcDyxKYThDf4PTV88Jit6lScCi+pR0V39tWjc6NyWL4R3YrBfPMiwT3XaTCDP2O0qQI496UaM2o7Z72uZUeWaZMvNvMqkMEBFoHFYSB3eeP29zboFtCbG/SLPuJTm0t2B3oclNxpHeuDN3J4lqI9dJiYCD8QTGhsTAOFAEL+aEVN+ag2RRMoDG6NaxU72CVoY9dcvyt+h6nLdyV7oJNUVpRp4tk4jq/EPjD23dejgJ6KTqFgfzDPncWQasGIVWyC6+mKYtP8MvpcpcdYqfpp6L5YoDwFlscXe8ZuA5LhHx5lqLQDoBWNsJomUy2LOWMadFw4A1/eohCLUGGFKzZYq2uu8T4KHKCKHbBSPZEX3xstPq+fGtjVqz2OzPSHy1sZcEeZ24NqaRRaBF1ZJbZXCxva9VlwkdPYU3cGnBmbP8EGfQyofthvLDpF06rBvdlXB1sSHHbqqgcIDoeou423sJBORqq6jlMFFlgkx5cT1in8k7oANJuw5/rCpjxrOpvhL+ApGgxpfyqFSeH55l42PFo0a8qi9mLs9eOI/IPNS9jaos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fe31ec-d047-4c96-d20c-08dd36454653
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:48:51.9570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwKEp9AXSMrx0SHCMyc8kwfHScIw0xlYbaPt5/kSnYhclbXuBazThINXDpg3Lo47KbaSCgjFzi9q9FPzqiFM1YkaU+rYd+WOMcyGZGq/qeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501160119
X-Proofpoint-ORIG-GUID: j3QQy-zkOLEQQW2-Y9K6Pv1N8r7P2yMO
X-Proofpoint-GUID: j3QQy-zkOLEQQW2-Y9K6Pv1N8r7P2yMO

On Wed, Jan 15, 2025 at 12:20:59PM -0800, Jeff Xu wrote:
> Hi Lorenzo
>
> On Wed, Jan 15, 2025 at 11:46 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Jeff,
> >
> > My name is Lorenzo, not Lorenze.
> >
> I apologize.

No worries, sorry I realise it was probably a typo! But just in case you
didn't realise :P

>
> > I've made it abundantly clear that this (NACKed) series cannot allow the
> > kernel to be in a broken state even if a user sets flags to do so.
> >
> > This is because users might lack context to make this decision and
> > incorrectly do so, and now we ship a known-broken kernel.
> >
> > You are now suggesting disabling the !CRIU requirement. Which violates my
> > _requirements_ (not optional features).
> >
> Sure, I can add CRIU back.
>
> Are you fine with UML and gViso not working under this CONFIG ?
> UML/gViso doesn't use any KCONFIG like CRIU does.

Yeah this is a concern, wouldn't we be able to catch UML with a flag?

Apologies my fault for maybe not being totally up to date with this, but what
exactly was the gViso (is it gVisor actually?)

>
> > You seem to be saying you're pushing an internal feature on upstream and
> > only care about internal use cases, this is not how upstream works, as
> > Matthew alludes to.
> >
> > I have told you that my requirements are:
> >
> > 1. You cannot allow a user to set config or boot options to have a
> >    broken kernel configuration.
> >
> Can you clarify on the definition of "broken kernel configuration":

Anything that'd unexpected break userland in a way that would be entirely
unexpected.

Especially so if there is a real disconnect between the person who is
enabling the feature and the program.

For instance if a distro wants to be big on security, is (as is entirely
reasonable) concerned about an unsealed VDSO/VVAR/etc. being exploited, so
turns on the flag, but _doesn't realise_ or doesn't communicate (such a big
problem and difficult actually for many distros/vendors) that this will
break certain programs - and then users do a kernel update, and *bang*
their whole system is broken.

It's really this kind of scenario I'm worried about.

This is the crux of it really.

>
> Do you consider "setting mseal kernel cmd line under 32 bit build" as broken ?
> If so, this problem is not solvable and I might just not try to solve
> it for the next version.

Yeah, I really don't like the kernel cmd line thing, because of this risk
of disconnect - your justification for it is prima facie reasonable - the
distro didn't want to enable the thing by default but you want more
security - but then we have this issue with the possible disconnect between
'hey here is security feature X' vs. 'security feature X breaks Y, Z +
alpha'.

>
> If you just refer to a need to detect CRIU, in KCONFIG or/and kernel
> cmd line,  this is solvable.
>
> > 2. You must provide evidence that the arches you claim work with this,
> >    actually do.
> >
> Sure

See my reply to Kees as to what this comprises, sorry if I was not clear
previously.


>
> > You seem to have eliminated that from your summary as if the very thing
> > that makes this series NACKed were not pertinent.
> >
> In my last email, I tried to cover all code-logic related comments,
> which is blocking me.
> I also mentioned I will address non-code related comments
> (threat-model/test etc),  later.

Ack.

I felt that you hadn't hit on my fundamental objections and this was in
effect - a final analysis as to how you would be moving forward with v5 -
but apologies if you did intend to separately discuss them.

>
> > if you do not address these correctly, I will simply have to reject your v5
> > too and it'll waste everybody's time. I _genuinely_ don't want to have to
> > do this.
> >
> > Any solution MUST fulfil these requirements. I also want to see v5 as an
> > RFC honestly at this stage, since it seems we are VERY MUCH in a discussion
> > phase rather than a patch phase at this time.
> >
> Sure.

To be clear - if the series is viable, I want to see it merged. And to
further clarify - a simpler, smaller version of this that explicitly
disallows breakage in config options suffices (though we must clarify the
gVisor + UML things).

If I just wanted to reject this outright, I'd tell you :) (I don't).

I just need to feel vaguely less anxious about breaking things! :)

>
> > I really want to help you improve mseal and get things upstream, but I
> > can't ignore my duty to ensure that the kernel remains stable and we don't
> > hand kernel users (overly huge) footguns. I hate to be negative, but this
> > is why I am pushing back so much here.
> >
> Thanks. You can help me by answering my questions, and clarify your
> requirements. I appreciate your time to make this feature useful.

Sure, hopefully I have done so, do follow up if anything was unclear.

>
> Please take note that the security feature often takes away
> capabilities.  Sometimes it is impossible to meet security, usability
> or performance goals simultaneously. I'm trying my best to get all
> aspected satisfied.

Ack, and I realise it's often a difficult trade-off. I just worry about
compounding complexity in consequences of kernel configuration vs. userland
stuff + the disconnect between the two.

>
> -Jeff
>
> > Thanks!

Cheers, Lorenzo
