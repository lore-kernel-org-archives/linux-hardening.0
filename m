Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456C37160;
	Fri, 14 Feb 2025 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495501; cv=fail; b=oTRYtI4T6SwUo73EpfhDH/jgzRTBMI895J1HVG0EZdkKrhoWXbeyce+f5KZ07efiUa1tT4p3q0Gva/sFlmOwL36Rv79iigT9cbqjgKH92fqULVKbXjKAkT03H4kKf2K843X7gAkBfo8yoEtyxvpzYoMdoZ+8/EuLGP8RmmSGc5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495501; c=relaxed/simple;
	bh=VV0ism3DJmasU8qFGjV3VYVbba/8QG2CkOennx78pGY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M2H2hzYqrcz4U02EE1xR7xOrnUQIvBKYFAhecCEBSnbtW2vDoqrACjOoOrW3D9sIrLHSieWf5P7WIh6fatFfhignjoC+lSAzBRQn6kSehhvj+7BdpRen9R4N7Zr8aRrrkYENcNkpq9OPqT6mV2lI278B/sECEg0m6cFZHYWwm80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M5BsIjeT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HAMhjEmP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M5BsIjeT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HAMhjEmP"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DLt1HR023702;
	Fri, 14 Feb 2025 01:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XtxvdfcUEg4S41hCb0+NKJTpCzbV1zpARxhRf61XX1s=; b=
	M5BsIjeTvAy5zFVaiwU4h8pYunPdAktCrzyBGmHKZDGEP2EmthY/pqyw0rOVNJxt
	TbkEyj/IGsajl2OEyZHg/pCzLYTF/1wcYMIcGrD3lOk/CoYrSeMbu8yGUqGpHVls
	/uEWHswYT41BfoXAfkLAfEKiZPEq+W8w71LvYZ6g3/L890rz5ZDxKFZsdfGqFtjT
	8ANUlsaf8xm0T3YjxrygvG4ECK9HxszCJuOlZK9JrimuihpL3U+a4xRjkNCYPTBE
	p7VJeeyRJ2RJXpEm4XiTm+YpnmXYUC1PtnLfKwHkFJ0tjJb3n95G5cOU9xgAMLUI
	PABm4UlLw8/sqhFCC7SJRg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqb0g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 01:10:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51E0C5mP017412;
	Fri, 14 Feb 2025 01:10:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqjvd1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 01:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0kn3oZzvWWwkfPbMxt3ATBE6mfmvQLECw+XW3lrKzZs/np267RnvVObJnhipj00LCrOXgRngK7zPlxzx09Bn85RyQk9S7HZRZ2EpZcW1PfVMQberzQgS7/M5mhbQjLY0cUkiUrFBojdOQGURDWjVB4us2gYyNL+XFjPOBlwNe0Wlij7Gd097i+4yqMqI05eSgh+siCgiSabTmcxB9isRYmDmIUFObfQ892htNIfNqwvUD93A7wa3tLqzt2wdl6zIgGss7HAcKCsOwj5ZLk53zW7pBGHkK4POAWZXyStCgZQSelbGN9XGyj1PznUN3YP0UUFRL4DvsYNMCAHg5F0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtxvdfcUEg4S41hCb0+NKJTpCzbV1zpARxhRf61XX1s=;
 b=outu1KS5ZJseZOuiKPjnpw4elrLczelnBJx7gJxMzqGoBO2xNYvXH4ebpNsEqUm/xKwnoW0W00yt/A3yqVDrm3aHG8piTAb8RoAmeFdVDdpeHrnWe1FxSd7tnxg1+qpzlNhcqTe0QXmoBsUb8pNrr0oVXCyAiF+oHidC5nRj8ug5JxSq7Icm237uN7Eyf7K5bCYQIFkLbIOQX+KGhSOP+G/cFi0xUbCvcnhfUiK6dIxNdbUgPIOMdMFLEwZVROSyNGkK5uDWiPfn9Xxe231rC9+FfJJD4BrdOI4l0uINOViL3D9kxEUX1+aaa/3HcL6l9rvpbEYOkcaF3j1REJiwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtxvdfcUEg4S41hCb0+NKJTpCzbV1zpARxhRf61XX1s=;
 b=HAMhjEmPH6BoK7ZTyyTorZ4il0JKusyE4AWbFHqVqtPeZSv+xhl4gRxbNP7+BjcQOX2s0R+LY2NS+0pXjCF0w5WMomSjVgc7xEAK2+c2gD0dUnTdeA4UJ3G3M4OUmXrYpemLLXd6KVmGI8+whPHkKUYAYNMfoPBN6oUM0vDMo60=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB6049.namprd10.prod.outlook.com (2603:10b6:208:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.23; Fri, 14 Feb
 2025 01:10:50 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 01:10:50 +0000
Date: Thu, 13 Feb 2025 20:10:43 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>,
        akpm@linux-foundation.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
        adobriyan@gmail.com, johannes@sipsolutions.net,
        pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
        anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
Message-ID: <ex3y7knp5kmubeauwktvv4fdjqya7ndatzm7ht4gf773c72hc3@y4ow7k54fttj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250212032155.1276806-1-jeffxu@google.com>
 <20250212032155.1276806-2-jeffxu@google.com>
 <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
 <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
 <66q7feybn3q2vuam72uwmai322jdx3jtv2m5xmh75l6w6etqiv@knpsyh3o627k>
 <202502131142.F5EE115C3A@keescook>
 <t5hsasch3aybjujmjzs3shpiorcgzp5pjc4fmz77u574voi3hr@qomzrd2llv2q>
 <CABi2SkX3o-PdeuzownVkFT-oo8tjtaaS9ebOALu+r6O1S6W3sg@mail.gmail.com>
 <tfoitovawb6zwr7nvwfo2mnbahgtnoo6umvecj5mgtie4b5vuf@sloraia3ppfy>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <tfoitovawb6zwr7nvwfo2mnbahgtnoo6umvecj5mgtie4b5vuf@sloraia3ppfy>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0400.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 49630256-67be-45eb-b791-08dd4c946b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlhoYnB5OE1Hd1dERXdLdU1hRnUyNTdFZTdwejdUY0N3dmhTaXIwOElQV3BG?=
 =?utf-8?B?UnpEenRHdXB5V3hkMHJBeS9EYTU5VEN4WHE1SkYycHRiZFUvVUpiV2JqMXV3?=
 =?utf-8?B?UmZ0N0p3N080d29PVjllZDc2a0MyYXJsMFVaK1dadFVLa1lpRW9zSXRRTTR0?=
 =?utf-8?B?UW1ROC93L2pyaHc3QkUxN0JqUDlONGFqVTByaGNsT0NWR1poM2dZeEdhbVBV?=
 =?utf-8?B?ZW5PNDYweGJFN2ordFRpcFg0cUNJTVdkUkFwMENvZG8xV0NHck5iOWl0NnNu?=
 =?utf-8?B?bkNJRlBPYUk2REdQSkhGUWEyRGJobjI1UXJzejY2MmxHZ1RwQS8vTlJ2Y3NX?=
 =?utf-8?B?ZklzQmVibE1zQ3M3aHNFNUx2amdGWFMvWHJTMlJrL3RuOG9EOTFFZGVqZUpy?=
 =?utf-8?B?elRQeXl1Q0VNLzRMdE9tV1MrTlRjOFFnbGZGYTdGam9XN3RReEdoN29TVURR?=
 =?utf-8?B?WWNST0hNSHljeTVXVVNFNWUwNUVxWUlORHpzZ0F0SVhyYS9hYk1yRE9PZlg1?=
 =?utf-8?B?QTc1QWRnVzZzTHp3bWt1d2FuM1llSFI4c1dFSmE0Y2NEQkxtWFJqRHFIUWw2?=
 =?utf-8?B?V09oMk9zZzBza2R2bk4rQU1WTW1Ma3MwWWpGNHRVTXA4cUFabkFSN1BPMWZ4?=
 =?utf-8?B?bUJVdit1OU1GQzJ2dGxQVE0zQ3A2UTYwY2dMVkRJTjFLYzMxSGdqOVo4bnZZ?=
 =?utf-8?B?ZGZkaGpsUkVNUENTVHhld3ZkYWxxLzd6YU5vOVlGRHZ4ZVdLUHhCRGhOcFYr?=
 =?utf-8?B?L2oraEZ5ekdBejQ0WEdBYzhjSWM0Z1o0YkxJMnJ1Nm1acERRRWhKazJvS1pW?=
 =?utf-8?B?cEZOR0pUZVVsak51Uy9yTGltTXFkTU5LQ0t5bVE5VHlPaEYrckd2TUp4c0g0?=
 =?utf-8?B?VkNKaHQrZFRTZnYzZ0JzbGNvRllkSmkrazRKR1YxYlhTa29NN1lxMzY3SjBu?=
 =?utf-8?B?WWVSRTFKcXhqZE02SmNCdGgzQkxnWU1iYmVFc0VlQVV0U0dINklITzRZbXpu?=
 =?utf-8?B?YlE0VGhPNDJ4ejJLcHlPTUxETGdpUStJOG9YZWwwbXI2c0pPWUhBaFF5dVlj?=
 =?utf-8?B?VkRsUzZjdWIvOENWYlhVcmhmanFaM1ZUUGNGSmJhNVVyV2NzSWRYajNsVmNs?=
 =?utf-8?B?Q0podXhEMENhdGtadXVhSDhIOGNxNjVPSFl1R204VldwMEJuZGZFd1UvNG94?=
 =?utf-8?B?cjRPQjJRMmg4bksvMDdjNUdQbGxWVlUvMG5XK3NFaDk3MHk5ektHaWN1K3RB?=
 =?utf-8?B?K3RHSVNzSHpCbWM2K2lpdGoyQ0dKZlE3cGtBWmF6S3drZGt0SjV6ODRoNExs?=
 =?utf-8?B?eHM4enUzdFdMcVY4OUQ1bUFQNFdOOEdaT2JsQkpZMDcxbUFmanVLR3ArZGVy?=
 =?utf-8?B?ZDljcENOc3hKc0xwZVFGTmlsd3NhL2E1V1ZGWnk1VGM3TndUa0EzZ3Rob01P?=
 =?utf-8?B?SjJlV2MyL0FPV2ovOU5heTIyNHZyeGV5TURhLzhhSFFKWklxbHFjUlhyMzRw?=
 =?utf-8?B?bXBOaElQKzlTb3B3aWdtdG9yYkFMYzd3MnZIdnRqYUdjcGhkMnFaL2NTOUQ2?=
 =?utf-8?B?Wng3Qmo5MGF3Vi8vU1RmQmxzMjBoS0ZpWEs5QUcvT1ExSXJHS2ZEZUNPYm8z?=
 =?utf-8?B?QTJ0QTZjVzBwOTVacnJ6eFVtREdEb2U3bEJCenZRS0hON0pTN2pTTWRpN3VJ?=
 =?utf-8?B?MjRQeUk0NC9BME9TVVozYXNJT1BPWWZ0RUwvakw1VTBjL2RPbS9lZHFsQ2Zr?=
 =?utf-8?B?SWdVTjJxRDlxbVJIWmdKRklkNGk1MHc1N1o2V20yYmtjWGl1R2p5QnAxMWJu?=
 =?utf-8?B?czc5a0pkMzBYK0Iva0g1NVFEV0xzQ0RpYmFTMjdaZzVicm5yK3duQjhnLzJ2?=
 =?utf-8?B?M0hMczcrb0hBSGNrZFVPZWlUVlpwcXIxd2FMWXJ6Q1JZaE9MRlpwZFp5bWVn?=
 =?utf-8?Q?F1j/nG6N+04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzNNc3hQdEJsQm4wN1Z1TzBiOEJRK2NIaWNvVXI1ZDVia2lWVUhOek11NkFI?=
 =?utf-8?B?dllQS2wxQlBsWVFhQUVtWUpaZUx6ZFl4SzVIZUExM3dYd05qTnpsVjdqL1dE?=
 =?utf-8?B?OTFBZkQvMDNZV3MyQWdQbmlVdmYxeGhINkVFbzJVejdRczBZK0wrS2NOWm5Q?=
 =?utf-8?B?RGl4NWU1V1N5blBadE1tZjArcC9Pa2kzUDR3YVpFbkxscXFsQitLenFqRmho?=
 =?utf-8?B?bzJMdThhQXMvS3ZZRE5YdWQ5cWJqR2lGemZNeGVONGFQOE84QXJqemxpMzM5?=
 =?utf-8?B?NjE0N2UzNXVzWFJ2eDJaZmt2cXZ0eXpnWUk4ZFplL1hFTG1UNnkzV0lJTUNj?=
 =?utf-8?B?UEs1cDhWYXN0TmxDYW11ZGVDSEhCWTRLenAxcWNjUCtPUTRBYjNwa09tVUhP?=
 =?utf-8?B?U05QVUxmeWtzaUpIUi9iNE14Qy9iaGdITnpGaHQzcVZ3ZXBiS0o2bTJaMEZs?=
 =?utf-8?B?a0greW4wbDlPT3M3NENTWmptbUVMTXlMQm1rWDNENGVkQ3J6WkVCT3FZcVdC?=
 =?utf-8?B?NmJ3UHQ5VjlEMmpPbG9JT3RWNWs3UG95MVpSejhGY243L0FWSlNnS2lzSUtG?=
 =?utf-8?B?dzdNeFFNZkl0b283VHJWME0wNElaN2ptcENnS1UwWGpOd0ttcmV1T0V1YlFF?=
 =?utf-8?B?aEZENFdWZE1ZTmRTVGx0NU5iYm16YmNxZHp5WG9qTkZCRUU1cittOHAwMEox?=
 =?utf-8?B?V0dRYlpEejh6RE5QdHFRazFqVDFjVGwwZVpqNVJPSVNZaEJxMVVoOGxFUlYy?=
 =?utf-8?B?MnNaVnZVZnNKYVFpTjZNb1pYcEVOWE5Ga3VDa21rZ2RXNno4S1ZzUmJyL1Jv?=
 =?utf-8?B?R3Ezek1ZMy9zL2JKWTZHblJlUDZDcER1UkpZR2ZVOUhNTGdONDd5VFZQNTBu?=
 =?utf-8?B?R2dHY1ZZVGk4L0tINmNpdFpOb0s1RE95UTRJNk8rdDRKdXlVam4yTTJDanUr?=
 =?utf-8?B?SnJEMFFZczk0eldlVFV0cysxa1NLc0k4Q0FmRWFCUnFhQTdGUWhJcHF1Y1lU?=
 =?utf-8?B?c3doZy9ZM1JmNUVVWnJCZ0IxeGhRek5SNFgzSHUzNlhJL2prZlZyYUkrenNY?=
 =?utf-8?B?Tk9tV1Q5TmltM0JXYzdHR3ZkYXFRM21Nb3NhalZFT1hFVEVXR1VUQW9KM3lz?=
 =?utf-8?B?SGxvaEtucTFZNXljbEZBbjhnMDJRMEdjM1FvRnY2RmZrbkI4UjNDcHlCc0Iz?=
 =?utf-8?B?UHhna1R0QzVEbUtQNVZQWU9xUHVNcnhwdStGSFZyYjFwRnYyNEZZZENzeENW?=
 =?utf-8?B?Z2xMTHprZnEwanJsdWR3bkFVK1ZuNHNibWVNYzl4dVgrR291RThUZmRRYisy?=
 =?utf-8?B?Z2N3UlFDc0pUZ2ZGODR4MXVhMWI3enQ0amZJK2Ixb1pQdHVLMzBBZ2s1dkhv?=
 =?utf-8?B?bGZ1USt1MkswbmdqUVBvdElGT210OTJnZVNneXdkTDByS0djR2dNZWJrWXZU?=
 =?utf-8?B?MEVwbElMQXpSMlhsNEt0akYrTi9qdmUwWEQzRWtndTBBR2psbkVjWFpJVXdD?=
 =?utf-8?B?ekYwWU5qUmMwRGwyUFZJZ2VmZFdWTDd5MTMzVG5Nd2FKUnBzOTR1S1V4c2lE?=
 =?utf-8?B?RWhGdDZRR2grOXNsak1hNEFNTUVrak04by9RQVJtbTVVZkdsMjQ2aUx4VGN1?=
 =?utf-8?B?VFJUREtSUWlNZ3Fub0FLZzQwZnplWE1RNGtHM0R4dXVZNDVZcE03MTRwZjdn?=
 =?utf-8?B?SzJib216SHhOcWowTHhtZkI5azNWNzJwVzRGOFk5YlE2WS8rcHJnQ1ZwbVZp?=
 =?utf-8?B?a1JyODJLcXpGYzk4R01ZTWx2a3Jtd3BrK3lmMEY5V3MvaEpPTUpmbllaSHVG?=
 =?utf-8?B?OWFPSFNiamd5OGNSRkdOMFVXOGpwK25vTE9Tb1BrT0g0c0ZyZU5jUEplZ1Zy?=
 =?utf-8?B?UzhvRTA4Q3p3Ti9PTmdaNHJUNHN6aEFnMWFuYVhoLzZFR2RubVJ1K1Zmd3lu?=
 =?utf-8?B?a1h4K1Z4dm15aVp1MFBrbjhuWkZSMFE1cnd5NmdmazlYYjg2SG1sSXR0VnVI?=
 =?utf-8?B?MkJySWxQeGNlRktmbHNpWWtQUWptclAvVXVnRExxV0d2dGl0Y0ZIZGNMcWRW?=
 =?utf-8?B?eE5GNE5ZR1dYdnlsamNWUVJ5U1FIM3I3cTMzQ3FsMVJhWWxKRmR5NUlWY0Zz?=
 =?utf-8?Q?5/UgOd2IOoHNCjBCpLKCEr5CW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0I9KrPLdmH7OYCuTIrCAEJeHdZgZPwLyhdbu63kZ4sDj3kQXlqodAxOUBRL/xCFLdpTGjyNyzdH3zXBEUverhT0jh+ogljpVqDd+5EZpLvRGRA7O81blq98kXjrq5SCMrQhj/xp+5yhWVZVQop9K1CtiG7NB5Xfma+oqWa6V5DTh8pRnRGEa7QCNHPus0Bzw6SW/PeORfq++pao17dKX46k7ftQFuq66puQIxF7GLOD6nmnZjHv1j/2Vx9Jrqq7bc+0wLZjsx87LLNI9Jcu5p0dLCiJB2ffNvCJGYnIP6hWOcPBHNDCDcsdIMhOyUN+uwXSO/i0YjFF/KxvGU831XH7oNpg3Cvh+4uzHoa9O2PhU1DUUFR3lz8iHoWL2SKsX+dOF5iuIFTvNG3HUMTyRK60l14c8zGyR+PvKyv4vCiYhcqYejrFpiLuWElzumZpMwaTBGXm9vls8cavfGse6EakahWZeb6undcDSxLsK2XA/+2G4hqF9HfZMMvZhFfp/bUVmDsJvn6RZvXY7lM6X3bfNcFq3QMhSPJ7s0RV/YaQHApjnOsOKUDMvzGYN0s6RP0Wk7iXwU/cTuMCgOC2nn0quF8tbxgZUCVWf3V/Sq2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49630256-67be-45eb-b791-08dd4c946b6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 01:10:49.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FiBxDjphsL7Yem7MYdHZbrwha2uI0wjRWWcp1FkbjFH8wL3AZ557YASWzViZOL0FI23sJZG2X/l0V3gEeqXsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140005
X-Proofpoint-ORIG-GUID: nu_t5j4qOLbB3V8D9BUsPEwhiHwfiJT4
X-Proofpoint-GUID: nu_t5j4qOLbB3V8D9BUsPEwhiHwfiJT4

* Liam R. Howlett <Liam.Howlett@oracle.com> [250213 19:14]:
> * Jeff Xu <jeffxu@chromium.org> [250213 17:00]:
> > On Thu, Feb 13, 2025 at 12:54=E2=80=AFPM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> >=20
> > > > > >
> > > > > > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't pa=
rt of
> > > > > > the build. This is intentional. Any 32-bit code trying to use t=
he
> > > > > > sealing function or the VM_SEALED flag will immediately fail
> > > > > > compilation. This makes it easier to identify incorrect usage.
> > > > >
> > > > > So you are against using the #define because the VM_SYSTEM_SEAL w=
ill be
> > > > > defined, even though it will be VM_NONE?  This is no worse than a
> > > > > function that returns 0, and it aligns better with what we have t=
oday in
> > > > > that it can be put in the list of other flags.
> > > >
> > > > When I was reading through all of this and considering the history =
of
> > > > its development goals, it strikes me that a function is easier for =
the
> > > > future if/when this can be made a boot-time setting.
> > > >
> > >
> > > Reworking this change to function as a boot-time parameter, or whatev=
er,
> > > would not be a significant amount of work, if/when the time comes.
> > > Since we don't know what the future holds, it it unnecessary to engin=
eer
> > > in a potential change for a future version when the change is easy
> > > enough to make later and keep the code cleaner now.
> > >
> > Sure, I will put the function in mm.h for this patch. We can find a
> > proper place when it is time to implement the boot-time parameter
> > change.
> >=20
> > The call stack for sealing system mapping is something like below:
> >=20
> > install_special_mapping (mm/mmap.c)
> > map_vdso (arch/x86/entry/vdso/vma.c)
> > load_elf_binary (fs/binfmt_elf.c)
> > load_misc_binary (fs/binfmt_misc.c)
> > bprm_execve (fs/exec.c)
> > do_execveat_common
> > __x64_sys_execve
> > do_syscall_64
> >=20
> > IMO, there's a clear divide between the API implementer and the API use=
r.
> > mm and mm.h are the providers, offering the core mm functionality
> > through APIs/data structures like install_special_mapping().
> >=20
> > The exe layer (bprm_execve, map_vdso, etc)  is the consumer of the
> > install_special_mapping.
> > The logic related to checking if sealing system mapping is enabled
> > belongs to the exe layer.
>=20
> Since this is an all or nothing enabling, there is no reason to have
> each caller check the same thing and do the same action. You should put
> the logic into the provider - they all end up doing the same thing.
>=20
> Also, this is a compile time option so it doesn't even need to be
> checked on execution - just apply it in the first place, at the source.
> Your static inline function was already doing this...?
>=20
> I'm confused as to what you are arguing here because it goes against
> what you had and what I suggested.  The alternative you are suggesting
> is more code, more instructions, and the best outcome is the same
> result.

I think I understand what you are saying now: the interface to
install_special_mapping() needs to take the vma flag, as it does today.
What I don't understand is that what you proposed and what I proposed
both do that.

What I'm saying is that, since system mappings are enabled, we can
already know implicitly by having VM_SYSTEM_SEAL either VM_NONE or
VM_SEAL.

Turning this:

@@ -264,11 +266,12 @@ static int map_vdso(const struct vdso_image *image, u=
nsigned long addr)
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
 	 */
+	vm_flags =3D VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |=3D mseal_system_mappings();
 	vma =3D _install_special_mapping(mm,
 				       text_start,
 				       image->size,
-				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vm_flags,
 				       &vdso_mapping);

to this:

 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
 	 */
 	vma =3D _install_special_mapping(mm,
 				       text_start,
 				       image->size,
				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				       VM_SYSTEM_SEAL,
 				       &vdso_mapping);

No unsigned long vm_flags needed.  It's easier to read and I don't think
it's any more hidden than the vm_flags |=3D function call option.

>=20
> >=20
> > >
> > > > If mm maintainers prefer a #define for now, that's fine of course. =
The
> > > > value of VM_SYSTEM_SEAL can be VM_NONE on 32-bit.
> > >
> > > Thanks.  I think having a flag with VM_NONE on 32-bit is just as sane=
 as
> > > a "flags |=3D system_seal()" call that unconditionally returns 0 on
> > > 32-bit.
> > >
> > Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu=
.c,
> >=20
> > #ifdef CONFIG_64BIT
> > [ilog2(VM_SEALED)] =3D "sl",
> > #endif
> >=20
> > If #ifdef CONFIG_64BIT is missing, it won't be detected during compile =
time.
> >=20
> > Setting VM_SEALED to VM_NONE could simplify the coding in some cases
> > (get/set case), but it might make other cases error prone.
> >=20
> > I would prefer to not have VM_SEALED for 32 bit.
>=20
> But what I posted leaves VM_SEALED undefined for 32 bit, it defines
> VM_SYSTEM_SEALED which can be placed, for instance, into
> _install_special_mapping() arguments directly.  Reducing the change to
> just adding a new flag to the list.  And it's applied to all system
> mappings based on if it's enabled on compile or not.
>=20
> Also:
> include/linux/mm.h:#define VM_NONE              0x00000000
> so, I'm not sure what evaluation you are concerned about?  It would be
> defined as 0.
>=20
> Thanks,
> Liam
>=20
>=20
