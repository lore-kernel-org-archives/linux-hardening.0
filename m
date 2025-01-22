Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67B16F8F5;
	Wed, 22 Jan 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566701; cv=fail; b=nF9HnTKAwC/y6bj4PuY/wEouzbBRza5V7s7s/ovRn+XbHqSrpaEnZJuGMXro7d86fSzWHZvKFyfypuCjca0y0zCrFObeBN2Y8brbPsc5O7dBAY8Ecnsr3eIoEL8RX/IKKwQPKU2xrI7gcSKVs3bsWTl4n+UEW1NRLHGBcv8/7W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566701; c=relaxed/simple;
	bh=5xfvQ7hagZmM6ZjYVViPYhev0lwVeRThgRUbuxctaUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H0FSqR08H/56mKhxVJd9zTpD8JQ4vQLinu//NgnFq7G2Vf92JSmw9tbkDLGfMTpK0geQiHmUj5BlEnKgAV5MaLFwRnGC5cuE81gXLlbgN65cQiRP5S+5TEnuBvx6CayF5vU+WdU0T30WEPaH6BP7tGDxyJ14p8EoJPS2BHYk454=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RgusdTJi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ynXDumqb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RgusdTJi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ynXDumqb"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGXffa024581;
	Wed, 22 Jan 2025 17:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nczoGiY2pk8CdKsmrZTmSACiyDNf98b0zRhxOLEKNPo=; b=
	RgusdTJiRfSBBG2RM8rU+OcYi6zRjTv2UV9fK/PtmUtf8dHBgHqZdcSQHqMQRzvE
	skCdZ5vTVQoxPMqBFClHqWtt6vpIHNX2QZspFJBgBeTxaOHdbLh2SB61nfSjKuWF
	sd11qLv8gnUERZKrqCgSiHb5+AlxoJVW3lKMJuSGHMs4QxiWbe2PIRKx/kv/PqWL
	tuidod8EM6uDNuI1c1Q+AIvwWVAyywVuNlyqH+XH4zznsx6eR2CC34pNJegowkfO
	9y/tRHnt6b6kUqYc0MZrFs/OM8nh7ODxz6cHQVESJgHvoUjAfWgu+NZ1DAXhFru+
	s9sPiio9JycQpV5Ma4U9OQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsg53r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 17:24:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGZ0aS030477;
	Wed, 22 Jan 2025 17:24:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491fke7mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 17:24:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nqm5PF/EEdesetUPyKYUp2rJ2iC+LGBjqFtmcQXNj+A7sI1lFGIIN4b+c/DBvKvsHgzQuE4sryEx4+4lXIkCApfMHd2XFDMmbLkxiIlSGtRJUWfT9A61ui3Uy5aQHqyx2QarG/R5OOpdhF860mpcuD2bsZfmLz6bylKuquKpc5WzZETrehDI9jRiDxsLuDGgLzsGZqLa7bcQTXPFpwmzFWrkk93lGKtBC7OrX7lyZE5XhauXJ0TRuqHFrFXMoFzGJBy5fqTiKc01m2cQgHd2J0V4htEM70X7NewM8TenjtoPe3p3wWLLlgYzp1Kdcn80gQyTmZ3dxwQf83EUH4NM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nczoGiY2pk8CdKsmrZTmSACiyDNf98b0zRhxOLEKNPo=;
 b=VGS443imtKpcwe/nGYxeJYDY4n0Z3/L/t+nMkC/tzUKP+22d1P5B+iT9vGX/txdCyhTlhsR1FaTg8otGr0yU5zPSrW1LRK1Owe9iZm680t0zp4goCrDQdugHTlJGHGBtNClBJVBgJCGMENvdAsP/wfas9b/DssroWnCX//rvYEdgapk7GizZVPbL38m7nekG9aCeOTWCpBhl8M+G4Rm1DqEW8FyLILAKs90KPYkA2se90OL693dul0SCJyaehmekCq8GP5ZN9FyJkDE4GeLUhNy2LTTSfufZiEatZqYYToe+w1Q/fHWSmCS9yzQQOAeSBoip6oj1gsFnRlPl94+Qxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nczoGiY2pk8CdKsmrZTmSACiyDNf98b0zRhxOLEKNPo=;
 b=ynXDumqbHSHwj57BfDnUq0PzYO7dKIvL00ea5fKkjAWSJpXKh40+I5qcCggXY+ZNKx0CHEqbA7WDXRkF5E5uMPALRjogP1qXj3nUQRzaD2wZDzmxv5DoFptjPrfnib2eWOsMfkR5se5WoS3pxztSaJ5bHloIsmQZqNCDx+FJIhQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MW4PR10MB5810.namprd10.prod.outlook.com (2603:10b6:303:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 17:24:00 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 17:24:00 +0000
Date: Wed, 22 Jan 2025 12:23:32 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: enh <enh@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Kees Cook <kees@kernel.org>, akpm@linux-foundation.org,
        jannh@google.com, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
        mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
        deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
        peterz@infradead.org, ardb@google.com, rientjes@google.com,
        groeck@chromium.org, mpe@ellerman.id.au,
        Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <l7pexkoo7t7p5u6gobgc46lxvpgpe2lywaqwa4b6vjddt3ccnq@mh6x72cxfhyv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	enh <enh@google.com>, Jeff Xu <jeffxu@chromium.org>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Benjamin Berg <benjamin@sipsolutions.net>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org, 
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, 
	davem@davemloft.net, hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
References: <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
 <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
 <ocstrhpyoyxzurvvxbrbnlzfqzo6hiqt7dxj7vu45ipj4min6z@ffnpao72slda>
 <CAJgzZopv+jKmDncYDJEQTymqQ1oRpy8HNpOsmcoM7Chb=uBJzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJgzZopv+jKmDncYDJEQTymqQ1oRpy8HNpOsmcoM7Chb=uBJzg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MW4PR10MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: f708048f-b28b-40cb-ab54-08dd3b098f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0wyb3I2MWdZZktNRmVwUWpFU0ZHZjlCQUVjZDEwVi8xcHp3UFh6cTU1TTEz?=
 =?utf-8?B?aXppVlRZaGl6OFBLaU1qcUJrN2h1dGJ4MlJlSVBVbUhPK0dDWlNRYXF6bita?=
 =?utf-8?B?MW5xUitaSzVPSUwyeXpoZUhXZkwvTlVMMTRhbEkrSGkwWHZja1FCc29TYmx5?=
 =?utf-8?B?bm1Cd2hHb3ZZTGYxMTBzY2xVdFU4aEVOQ2RxTGVWV2VMcVIzb0hIQUpSY0dC?=
 =?utf-8?B?WWhtYkdrSXQ4SUlUaGxXa25NTUpOTGRwMURBZVByVFpTNDFMQTM5TnJiQlVr?=
 =?utf-8?B?eDFmUDU4bEwxMG9SNi91T0k1WU9xcE5YSXpISE9BelVuTitGUE1iYnZPWnBC?=
 =?utf-8?B?dWxXaFlqL2EwbkR1MlNDR05MZXFPWGhSSXNrQ2g5bnV3TFlsbkYwYldlVmhm?=
 =?utf-8?B?WTFZbU9McTY5M3BqejBkUjFxSWxSbXZrOGpNL1VCeTRqLzRSR1J3MllVWm14?=
 =?utf-8?B?Rzg1V0FRdXMvbTBMYzVVbTBwYnpyNEpERGNVbTN2VUxVYnZjelpvcUg0R3p3?=
 =?utf-8?B?azB5ZDJuam05akhGNEYxTEQ5Q1V6RnFua200NUVHZm01bXBHWVlhbEJLU2Rp?=
 =?utf-8?B?NmJvb1grRG8zS2xZL0w4MmVaVUQzZkl6WHJJRGNHR2RWVldVQWFpVXBNa1Zm?=
 =?utf-8?B?WXpXRXZBN0ZMeEcwRkkrNXJJUWRoNGlsUkY4V2xudHJYYzE0NDI5M3F0S0Y3?=
 =?utf-8?B?MEd1Nk95V1BkRjdKNXRSRllxSWZLMlFsbStjSjlOY3hIMzJHYTRIWkE4YlFJ?=
 =?utf-8?B?MW5ZMFBZRlNZcFBVR1hPaWpYSzdsckwzNXFIRFNiU05aYWw5ZktKbm83a25N?=
 =?utf-8?B?d3pmTnJ2dlRHVWlNWHg5N2tXM3lCUnVlZGYwbHEwZHhyTTh3cUw3YmFCL1RU?=
 =?utf-8?B?eXRRTmFKM1Y3aDhhSERVbDJvSkp1M3lWNmxMR0llSDdwL1ZXbUo2d0Naa3d3?=
 =?utf-8?B?dEoxWGI0am1lZ1pNZVMyK2JDYjh0TmJZcE14SEJGYVVZbi92bXRRNEZGcWtM?=
 =?utf-8?B?cVN2Z1VNRDFPdlFTMGhXMWNQN3JLZTlMQWhjdjluNnR3RFNCTkE2eFZUQUVY?=
 =?utf-8?B?VW5yb2Q2UStBRnVMbElqTndyd3RCV3lFR0Y2WHpFZ1RMa1d4NkZ5TWpBbkFo?=
 =?utf-8?B?RFhubWpBd0hEeDMxMVZSS1VqOWxHWDdlVmttVEcwWGRpdmtXR096eTRXcHFp?=
 =?utf-8?B?bE5ZdDRPV1ozajQybFpaWWszRkJBdE1rbDVJYnJDQUxuODlSU0xBbzRJQkJr?=
 =?utf-8?B?SHNZY3Z1d0hLamNNcjA2eS84TkZxOUxQQm5vKzlKSFJNek5VVStVbGM3UzBS?=
 =?utf-8?B?QjlNaDVlWHlTVkhZZ1QrbWdUOG1FSHVrMXlHcWZ1SGR1Y3VlbC9rSk1OVWNJ?=
 =?utf-8?B?clptdWQ5V2p0L0ppWGg5MTYzWmloUUVzVzAwOXZsLytBcnZhbVFxeVVsb2FK?=
 =?utf-8?B?UWQybGtydGQwQ3NnUnl3OUNKVnhqeGdTQ0hrVUlnYTRMcjBPTUUzQUx6U0o5?=
 =?utf-8?B?UGFCWmlCWElRWm9SNlpTemkrays4d25BSXhzak44VjJFdjVLYWc5N2tQTWJh?=
 =?utf-8?B?c0owY2dIeU1ielZZSVdRYjBrVE5UQWg3MDRvc284N1NwbDJxSUoraDVNUWdP?=
 =?utf-8?B?bUlodVh6N2xsVU9QTzZXSVRTb0JZMjRiWUJ2d3U2cGgwMVo1ejJTQ01TOER5?=
 =?utf-8?B?Ni9rQmpoYnZzUGljaUtOMFRpd0VtVVpMTXlLUHplc0p1NXladEZtVnJHZ3Fz?=
 =?utf-8?B?T2xNUVkveHlpdTYvK2VmeCtPK0JGU1FZOGtTYlF0UzdDdU13emExL3poK2hn?=
 =?utf-8?B?ODNQcjZVeUlwREhxQXFLZzdCdDF2Q0QzeDgwcWd2NHc5MUFYVmZ0bHYrSmxV?=
 =?utf-8?Q?dlD3aRaUwvy2+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWR3bXFKclVHQ2RSSHU4UWlGYnp3OEtnOTYvRS8xNjF4UTQzVnQ3emlIWkQv?=
 =?utf-8?B?V3VLTHRmZU03YUVTcE5rSTFBQ0RXMDVYRDJHRU8wYXQ5V0h6R3lReko3bWZN?=
 =?utf-8?B?alpmWEZBZW11dWw2OHFON2dUeUdEOEpDSzNhMFpXeUFPOEdRK3hRK0xBVGxI?=
 =?utf-8?B?Q05XcFZEMnNkSkZ0MHJodk5wc0syNVl5c0hkZVhvb2VGYy9QOHh6ZGxDMmlI?=
 =?utf-8?B?M3J1UHhBSm9pcVJCakV1aTh3NExyTWVmcmp6YStGZnpobkZRWmQzTmZzdHA0?=
 =?utf-8?B?dXdCdnVsTFVibXNyTnpyYjZWSjNOeXpRbWN0VWpGaDNLaUR1dGsvVkk1anN5?=
 =?utf-8?B?VHE1NFNZSGZPdytrQTV6alJXd3R4UG0rVnB0eHhxTDZrY2hKTXkzQjZBNjNQ?=
 =?utf-8?B?Wmt2czYyd2d2dzliU3ZLUnpoWCt0TU1aLzVpejZ6eWRxQjU4dzY2WENwdDBH?=
 =?utf-8?B?elFsYlR4SEltL3RMa05NVWJMQ3YwUm1GUW0yMHMzV0NnWVFHQzNWb1MvLzlB?=
 =?utf-8?B?K3NLU2F6TVJGdjFkejJCZGdoOHhDc3pvNHBnL05qVFpXaUZDajEydktyTW55?=
 =?utf-8?B?dHZ2MUx3cXI1bzN3ZDFKY2FEcm9nVnowenE4ZUpzMk1Leld4Z3ZyNjBuckw0?=
 =?utf-8?B?OVptR0lEckhaL2puSWthdE9xdThQeFJpdE1ZamdQMVBmQkRCUmQyY3ZhK3Fk?=
 =?utf-8?B?OWJ5ZkRwRGI5U3RNd3g1b1NlT3k4YVhTV3RsVWFUdnNZamRuc0p2K08wMVpB?=
 =?utf-8?B?M2wyNlZkOGY1V0lQYXc3cWM2azUrZ2V2RHdpQWRvSi9vajhGby9rKytmSXBw?=
 =?utf-8?B?V1BmWmJuOUgvbUJqbG5VOVJTZ1YwWHlaOVFGUXRTaGRRR0tUeDhNWEZyekc2?=
 =?utf-8?B?RWhBRVBsTHJaTzFuWmVSaWI0Mk4zREVTWFpieXByVmFqck9lYU5za1p6Q1BK?=
 =?utf-8?B?OXZrQXZNRnI1eE1hdEplZXdoWkdQMlJ1M2Yrc3JSbW9NdzNPclBJZlhjVHJN?=
 =?utf-8?B?b0dNRjhVQUZBcTh1SlVSSW5KWXFoZ3RNVm44L25jc0xnbGkvcnpTSW9peXh0?=
 =?utf-8?B?dmM2eWtOVmY2bXpCZVdoL3JnTUQ0OXlqSVZ6K2pQcTdxWWxBZVdHUUNlMC9T?=
 =?utf-8?B?OG8yUWJ3cG9FMWFUVno4SVQySlRUaFM4bkgwd3lIZVNmSWFZTHR4M0tGTHRY?=
 =?utf-8?B?NDN1MWtwSDBGRGJrcml4SGZJRUl0SUtQcjdhL1VzTi9KY1NLOTdwWWY1aGpY?=
 =?utf-8?B?RHBOOTY4RmZKQ1gwbXlqRlRVMzRDYmc2OEdnNWRrcjRDM1ZnNlVKY0hqRHIv?=
 =?utf-8?B?dU9YaTUzNHNxVXc3TTNoT0dycEtXdFl0N2plTnVCUktCM0p3SWFmT2VrWWR2?=
 =?utf-8?B?c3hNQ3VjMXY4VkJ6Nzl4Tk5mY3RpK3pMVXhza1JCUzlPVTE5MUJlQlgxazl0?=
 =?utf-8?B?Y0JVTmZCYXZHdEpZWXErbk5vSHlxVlJwZTRwYnNaTDAxVDVpMDIwT0kwNlhG?=
 =?utf-8?B?MVZsOWI4TW9WKys0WUVDNzY3ZTdWV1V0SndpZjFFL2pZc1IxOUcydHI4OTl2?=
 =?utf-8?B?OEU3U2JtVXlZUG90bk9wcVc4M1MzMFBBb1pKakE5dHJ5U3VMTmROSGkxdlNJ?=
 =?utf-8?B?TU9uUkFjUTZ1UGxpV1lVdExJejdkMDVhRGpwR0l5YkRsdjNSSmx0aXl6NWd2?=
 =?utf-8?B?ZlVIblh6RzZ1SFQ4LzViM3pTeFNhTTZ0dDNKVlBCWnNYZFBVaXNiTjk5UTll?=
 =?utf-8?B?STVjalpzbmhLeE9uY1pia2gxVWlKVWpOOUI1Y0Q4Z2RCWG0xZnpGOTFYRys5?=
 =?utf-8?B?L29TUTJWb1pXV3dmSXpNd2U0WjlUKzJYTEdQUlZPS1V3dVNxVFN4UUU3Wkl5?=
 =?utf-8?B?UWRaN0tNbkVCV25aTEJQaC9VRmIyT1BVSzJIbGs2TDFUTmJlZzl1cE9PZUkv?=
 =?utf-8?B?MTgwVk5zYkxGRndvczJGVElYeFp6UGcyUTcyMHo2VENvQUs5UWhXZHZqTGpG?=
 =?utf-8?B?VDQ0WWhJNm10N3ZOcU16NVgzUUZPWFlkV3RPMmlsVm84WEdMVWYzenJQSzVB?=
 =?utf-8?B?NUxOelkxMjZjM3UyamZGVDdoL2EvbDh4NkZJZFBPcnNKNHRaUDR0UVpMVWVa?=
 =?utf-8?Q?m+8KtDgYdh+0bMjkaghbL3ndm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZE/0WIUqtMoB34cu6JG98AoQ0u3AZjHa2KoY/l0dRCtmkaghpB/IKoToodPKV1M8Nn0luvHjnY6HOt405MUdRPtvu2xSUDbfeQDXk6TlJFt0Cm2FeTvDsvyzddalJEy44i2MYQLcWmoIhHxt0giF53Ovb98MoC5OuDYHPu+bwyIWevZVALb5uMhiKAzIyjFb6PJehxmVH5W8YM3RcbpdGxAnHdzoD9K/SzbmcodXGmEdFG4P+buuzRt5AHjywIZHD25Xv7eYrYFciefwddIqqlvorlayQGmnVC67CA7FjW37LG845pXDbaSvXVbULYaoIAshY9mhd4s+fsk/8J6It9uDqfHyYY44FvyOqIDtPbJyjaMdHqEowjopoLjgdWFZnmYQNrDa9hIjx0RjklyB054M+1Cpnn7QbbqD3xYscV9LgYjChnCEjqW1LX7Hg2Rxy+m/sfmNikiRMfZH4oEG9EqVu/GnkOCLAp5L8n7iV+y+7cVAXpF/KYjnAdLVkn0ZE4WPlLi1fUBDyRsvI5UlzNxtvxnazV55E39mzhxsnefIgbtG72uniYSO78e4JDVPgywp/mG4NRIFDcG6Tqs4u1g6XbVPWB2WxcKhIWwO9F8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f708048f-b28b-40cb-ab54-08dd3b098f14
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 17:23:59.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7pg7UaWtqzZW043+lmFuDXnk3cGy1xedfgZG1CiznQUeGncekkyCB+4TW13va9gYBQOjG6UouVpT59iGIoxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220127
X-Proofpoint-GUID: -ovGBpeC-3IJHmfPaekXVrOSTC9u6G-f
X-Proofpoint-ORIG-GUID: -ovGBpeC-3IJHmfPaekXVrOSTC9u6G-f

* enh <enh@google.com> [250121 10:38]:
> On Fri, Jan 17, 2025 at 5:08=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * enh <enh@google.com> [250117 14:35]:
> > ...
> >
> > >
> > > as a maintainer of a different linux libc, i've long wanted a "tell m=
e
> > > everything there is to know about this vma" syscall rather than havin=
g
> > > to parse /proc/maps...
> > >
> >
> > You mean an ioctl()-based API to query VMAs from /proc/<pid>/maps?
>=20
> i wasn't imagining an ioctl(), no, just a regular syscall, but that
> would work too.
>=20
> > Andrii had something like that [1], check out ed5d583a88a92 ("fs/procfs=
:
> > implement efficient VMA querying API for /proc/<pid>/maps")
>=20
> yeah, that would work for the use cases i've seen too (some of which
> are similar to the ones mentioned in the patch description, but other
> ones too).
>=20
> the other motivation we've had that i didn't notice mentioned there is
> avoiding the awkward /proc/<pid>/maps behavior when you have too many
> vmas to fit all the output into a page.

We are making changes in this area.  Can you elaborate on the 'awkward'
part?  The locking or the tearing of data?

The way you state the page, it makes me think it's the tearing that is
the issue?  I think the ioctl would be worse for the possible tearing of
data.

Thanks,
Liam


