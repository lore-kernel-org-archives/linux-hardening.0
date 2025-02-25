Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CD256C7A;
	Tue, 25 Feb 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740463818; cv=fail; b=bSUHJkGAvGf7j3l9QR8joRxnbkmdXJRfFsUCvJOxGxhKSNsyOR0EpyjUK25vE/HHJrAL9tl41/StWe9F+zK0p3m9kPYUAKCFGEEfPU7d4A0fHkPrWQHQEEb83y6EIgb+fHJZ0l5sSfzFowzD+2e/hxumcJmryBAcOr9Ht53kOcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740463818; c=relaxed/simple;
	bh=l64d4yC3Y49SXkQjSpUCs+bEJ9R+JAum5wIQ5y4r6U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FZmnfe2eqF9EXAzmbjTDYkAC0XdXzLkx8OyZ21AMJL/lCHXDYnokIGJ+GnyzeMa25si7SocjJVRr/Nrn7F1VM7K+cpGwazW09CUJXcI9xMvTwaMRf3MO+qH0bQh6T++8hjKOZMPi0zmv40rz4No+B3bszvOlo8RWiGN+xBlVflw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mcg4ufOF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zkdlkwoW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mcg4ufOF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zkdlkwoW"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BcuP016832;
	Tue, 25 Feb 2025 06:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bEuR4ysJbUwlhlIGQIDhVPqnyWwsRL3nI7cCn3CiiEo=; b=
	mcg4ufOFT4GkpJ2vTTMFRtzVQqCNPzCjFVloe1zSK2wdwHOQMTcSwQq4EoHe0MEX
	ktckkBVthtr+SZqvYlaqMdU2lcxZR6LzewVnZZduIfFcE9tkfypGUNrnz9AlJ8h7
	hm+mYA5c/KAudbuYTtWHL1L5l4gJjFrG1/PmtzUZvtr5LT+JFKZgEdLX24H2UNYe
	f1bSpcRnc09cpC9PAQN7LDpmthD6B/P8a2oMCg/cvGhC4uqEfIEsgaXGpUWisD/a
	gSOz8XxFILqAWLDxcrOVBJmErOeVWvFLSXYlB4eigdQ0q5cRm+QsxFHkVmAHy9ps
	Tqb5PeYGUmPxGBpi/jucWg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66sc7qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:09:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P67NKT002747;
	Tue, 25 Feb 2025 06:09:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518xy1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:09:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eggzBLOJoI3gBYNcUnH7hOOSWne/6lS2nSp48iIJbdPso9k5i0/Ah2vteSYsdQGclcm7GWUWQSz3Gc8JstP0WWKG9yEPXXTOq93lkXTuo3ZW8xYkiK5iJknnlpcmPpp3neloCha4IdI+dEr1E2xDOsj6z5TCTMf02Vc9ZTMClUlLNAAam9mlLf+t7uphPWGVuHjPvkAkCMbiS1BaPkcuRzers7qVIssE6FisETewg4kSwFauDT8TFC2noJc7bLqVBrieyfmzpR0UYFv353LExtm3j7k2ueX7EfV7p88q0/UuEeYPomvc2MbymsIbmA8YWlzIRz89QljGzCP8GKlMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEuR4ysJbUwlhlIGQIDhVPqnyWwsRL3nI7cCn3CiiEo=;
 b=SUPEI/VI6n0rTHxb13COAdJFdERoFUwnJwCNfT5UA1ZW58kf6zMt8ks3aGhpF99bRxcpMMN43+eddH5F4D35+aA5Vb6zyWFAXkWJWm7Rm4bXmasZvuSy9djodIvJ+RJhKToV5qPboGd26ttADXK5Ic/gD2rCPWE+n1GDjyESjBda3cetoq9fUG4uFpW4Qr4idTm8yBCP73+fL1Em/qoVBKNaO9VGsZk43OWBO4RnbpnSJrdxNzSfZnuPcdejM7zNYsl1YL02OAPW0ZIOiYZ/bdWS4jJhQk3Nuca3nCawPgskFZidb9CAcieDD3KlIMH9Y2WMJlkkOckz/MGkzMqnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEuR4ysJbUwlhlIGQIDhVPqnyWwsRL3nI7cCn3CiiEo=;
 b=zkdlkwoWkmVXJ4x05vWhmPMDeCX5TXPfbLpiPpzi++EmkweCTHCwxTSKcAKC3gNEYBYh6XImF2gMYslqzxBIIPYAJoqIbBhoRvvJgfPBrsZp9ni4rQA5hhqOk3IU9QIH597Ix4GwJ07VejtoRXZP/rV0Vm26mRgalrU9CePHTSI=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB6031.namprd10.prod.outlook.com (2603:10b6:8:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:09:34 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:09:34 +0000
Date: Tue, 25 Feb 2025 06:09:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        vbabka@suse.cz, Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
        adobriyan@gmail.com, johannes@sipsolutions.net, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v7 0/7] mseal system mappings
Message-ID: <eb9c3f8d-1fac-4ae3-8e91-cccf351ca67e@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <CAKbZUD03mBKVfOTQ4me79bZTLgWP8QLyD1PSxTcpw2YPmtsyUQ@mail.gmail.com>
 <CABi2SkUaUMTS06mKm5_k7m=NpfyDR=L45xqp1i+FkvPJHT4-TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUaUMTS06mKm5_k7m=NpfyDR=L45xqp1i+FkvPJHT4-TQ@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0271.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::7) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 121157e9-ab16-492c-a364-08dd5562f99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0EwY0FPVFhKdFV2Sm95WFRYdW83d0txUmE5bm5qWmlxcmV0YTlBWDZqRC9i?=
 =?utf-8?B?TmYzdG1LTDBYeEVKeCsrZEdKNmUvS1J1aHZGajh3ODFZMTIxNGgwYkhTVkFS?=
 =?utf-8?B?bkd0cXNyaGp4UHhhZUh0d21ZalRzSGVUUC81TDJLZURoaU01c2ZIV0lEaStC?=
 =?utf-8?B?Ri85ZjJnc1ZWRkZacHU1Mm5MMVhtejAvaUhRZWEzdnNPaGUzcmI1TTE2R0lR?=
 =?utf-8?B?QS90a25ZNEpVeEpxblNKMHMvV1RoTUpFR1M5NHRuZW81Z2hHSTEvKzFWN1la?=
 =?utf-8?B?UVBEaG5yYlpJeG1UMEJKb1RDTmVYTDVhdWh3MVpPYk1wOVFKRytHSTBVR2pU?=
 =?utf-8?B?THc4SDRNcmduckF0QnRTSVlqWDVSaHpiSW15VmI0THBkU1Rybkc3YkxNUmk5?=
 =?utf-8?B?amNFUW1yVTVxeUxjbDYzV0hMRS84SXgwTGRROHBzOGgxWFhMT2V2SHBxbWJl?=
 =?utf-8?B?M3kzYWZYeTM5RnBOb2Q3V0lFSUlVR1RDYkF3TE9rdVp0TEpDVDVkREcvRU5T?=
 =?utf-8?B?aFpEYlpVT25Gekk0U1dFTFFJN1NwcFNwRmIvYmFZN1oxOVh5K1B1SEwzR0cv?=
 =?utf-8?B?MUtuQjRrWEJVNHhoQlEzU3NiMDlKczNBbzNPcFNNZy9XS0dTODkwMW9nTDIy?=
 =?utf-8?B?MFMzNFY4eE8wVHpMMXNOUGpKeDRyKzNvVzd3VU9RVW9FUngwSk1zcGVQUGxY?=
 =?utf-8?B?LzFIVWpUWG1Gc05LVWZZVnZpdmFpN3kzb3ZzUkRwelhNOEhyN2ZxSXhyMVFa?=
 =?utf-8?B?M1JzZUNZcEhOV0RCMC8xN241VW5OVE5EL0hJeHkyZ3pLZGZ6TW9lTndWOVVI?=
 =?utf-8?B?VlNacnRvdFIyUnVXa3kwK2ZsQ3NIT01OalJHRndqS2ExY1NVbkkzaVZ5VWZo?=
 =?utf-8?B?UzFTLytTUE1UVk5CenJ0UC9NMmpVYWljcTBXY0U0TlJ2ckVsUnZ5Qnp0MHZu?=
 =?utf-8?B?cm5LRzl4SzlxalV6TWdvQXNGTlRGN2pUdkJtcG92cTBMaDFqTUcrdHQwQm44?=
 =?utf-8?B?SnU5VGdMaGtGK203V2xwazhvZGZVV0YzMC9mUkVkTVh5L1FYbWlDeEVGckVq?=
 =?utf-8?B?UmVBQVRwUHBLZE4vcTBzTG9lTzFSU3FReUkwMUo4akhnOGt0Y0NPRGo1elh4?=
 =?utf-8?B?WExsOHFuTFVxaFVkK05CV1dkN3VTWTBnOVFzZ09RZDl4TjhEbWNYaGVTY2wv?=
 =?utf-8?B?cmJDeE41bHBRVXN2aVdkU2tzcVdlTlp5bGlTdGV4S1l3UXpQYit4KytZSWlK?=
 =?utf-8?B?NU1ucXVadnBKWGlaejdiMGZ4SXNJZVIrcllLVTdFOFprN1ZoeitqWHJkQnYw?=
 =?utf-8?B?aWhLdlNvTDh3YWtncytPaHBQRkVWbXJRdC9JYjVSTEY3SERodWk4VUFoUTdt?=
 =?utf-8?B?bXFVNys5QlIxaVR4YkgzWnN1aTk5SkRSWnhyZmt4cEpMTU5zejlhbGR2L1BD?=
 =?utf-8?B?MllxbnB2c0F3dzAyUnkzVjBXdHV0UlN3UmZ2TTB6MG1ob3BUdmpMZHBERzRs?=
 =?utf-8?B?Smx3WldHcmNuNjhPUU55MEtKalhiWVNVYnhMWC9sc2RKQ3dRc1NTOTVZTXly?=
 =?utf-8?B?QUd3eFFaLzRPMWx1TkZicmZRVGxwU2RQbHNCVzdTY25JNnY3RXV2R1JYdXdN?=
 =?utf-8?B?VWxjcGN4OFhpanJJaDYxNXJvTmhteGtaSDQ3anAzVDR5aW5idkt4L0dXTXJl?=
 =?utf-8?B?ZCt4T3ZEbFFZMUI4Nkpma1NlOUZCUFlEaHBYYTdPOUtPMFpiNDBFWWhVSjJl?=
 =?utf-8?B?MVRQQ0xJQ0hiNDFzK2RrVDJlQXROaUF2MGFZWCtjajd0OEZPY3N6dUo4bEJl?=
 =?utf-8?B?YmI4WWtERE1iVnpLVFFoOHVzYVJkREczMVYxem95WG9TOFo0UThDZnc5TVEv?=
 =?utf-8?Q?1GdYWkmsxE8Mz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmF4Rmpudi9DaDArNU0wOFV0Q2ViY2tDQkgyWnhRcjJBM3pxb1BrVkxHelhB?=
 =?utf-8?B?Rkc1UkZWMnZkZzhML1hzeGFxbS9GR1RCMnU5M0RhT3J6dStrMTB0cWFlcXdX?=
 =?utf-8?B?elpPM2NNOUxEblFhZHZEZVVCZnpiL1ZxVHJNZ2Zrd2lSdm05bDlMTHlOV3Q0?=
 =?utf-8?B?RG1tQmJidXM1Q3g2WmIvK040Sy93cnZjTzI1WVcwR2FSeVVDczNkaUtkN2Ew?=
 =?utf-8?B?RnNkWFh1WGRVM2poZFFCVUNPTjkzbWJxS3VOL1VPc1QzQVJrR2taYnh2U1JG?=
 =?utf-8?B?akhSLzI3cnBhQVd6R2JaYmVwUllmSE5BQzBQWlVJS2xES3lTT2IvRmtMdnQ3?=
 =?utf-8?B?d1ZEWHc1R3JpRWpLYXNDWWtVRS82V1pZNVNEbnRUUlBjdlhidk5XZUFqNll6?=
 =?utf-8?B?c25pZHN4eHdueVhnZlVuSHZUM1oxUWludmw4eDU4Z3l5SG5zRWpZWDdHL1hj?=
 =?utf-8?B?Nm5PMXFWUCtpYU0rbzd3OWl6dG1YeDh2TnJXcUdUcnlMRUYzVEQ3TkJvRElB?=
 =?utf-8?B?TWFzTEZnZTVWbWFieGs5VWJWaWY3dUlVOW9iVGpFRXZ1M2pkUFVZVkorL2gw?=
 =?utf-8?B?bzBhTHQ4cFNhL25WYnRGNXVwME93NGFvQmRwRnlBSGIrKzZCeWNnb25ucmdE?=
 =?utf-8?B?ZnVERFpJcWJXc3NBUzdKV0REdFlMY0hnOVRGeXlodDZFR3ZZN1pHTloydHBs?=
 =?utf-8?B?ZmsvWjQ4U0Y2SzVkSlVBc1BybmEwcGEyMXF6cnRhUldqdWNpM3ZDeFk3THNh?=
 =?utf-8?B?SkoydFlWMTZTaTcxWEp2cmtDYXU1aE9lODF0OWpjQm1QMHArOVZCbTN0dUFZ?=
 =?utf-8?B?MkhMZWJOeUdER0FuLzh2M3lrNGFSMS9DNjNCV0cvWWwyOTlGRCtqKzV2ando?=
 =?utf-8?B?V0tETnZERHBLbUxEcVF6RkJOUEgvVXlST3FLZXNFYUx6VDNQSzNMaEZrMEtC?=
 =?utf-8?B?UDlobE5QYWZiY0o2L3JMMzJaRG1BanVxTnlOaUpnYlVjY2s0a1lJdFEzZWN6?=
 =?utf-8?B?aWJnYWx6d0ZEcVZLK3RUSFRqREpXcnorMWVhRFhXTnlKM3A2cldMSkxyZGR4?=
 =?utf-8?B?TnlPOGdqVEVKK3RKeEh6S1owSCtlRnltYVdSb2tBR05jdmVpQit3RXpFSGRY?=
 =?utf-8?B?SW5BcG54ZFlaOFkyd0grNlgzbVNoQWhBd3Z0eEREckRQYnV3NnB6YlhGRHVU?=
 =?utf-8?B?Q2xRaWh2TG1aZTlPV09pU3FMMEpKUWtYYmNQenNrRll4cEUxOGR5anBaQ01p?=
 =?utf-8?B?RG1nL0EyMW02enJwTk1RMHdxYzNtSENpaUdUWlVBa2pLOXQ1VTAwT3E4WlpX?=
 =?utf-8?B?T01KUm1DSWdvWk4xeWx1ZHdURDhNaC85azViWUUwYU9iZ1hkVzMvOE53aFla?=
 =?utf-8?B?VGhDL0dEaUZBT1RURlpZWDlHZDVnRlRDM3dNTnVEZ3FtODF4L2t0Qi9sUFo0?=
 =?utf-8?B?cFNvM1AwNkZFUlJmUTZKV25jdVZEYnRMMjZxSDIrd3FPT1RBeHg2enZVeDdW?=
 =?utf-8?B?OTFZa0lKVnB5UDg5ZlpjVHJwcHNoZUhLUWhHczl0WTNGMStRMXBJZ1dFeHRj?=
 =?utf-8?B?SFZaTVZOYXBGbDBXclZjNWV2dVc4MjJNZUM2MExEMkRhNU1ZZzFSSkp1ZnRE?=
 =?utf-8?B?Zi9sRGV3Q1lUN1VBVTd0QStSeWF5d01USE94cHlISXJoTnAxVzdFZmlqZE92?=
 =?utf-8?B?S1JjTUcyRXNnQndaSG1ROUdNcGZ1bXVndFBJeXJKY1N0RXhwK25LMDVYZ3l2?=
 =?utf-8?B?SWNoOGZuMUlrV21tWjhZdWxXNThrZnMyaUh1Q3lyR0ZubWVDZHdhb1JhTFRu?=
 =?utf-8?B?VUozVEk0MXZ0enZhenoyRlkrV1Q1SlBSZjJRMGovMjdrRUJLVGlaS3kzWG0x?=
 =?utf-8?B?b0YwaGxRT051cncycVhWMmYwTjNadi95U3crWFFDeDZ6eFh5Q1pvYjlGQWwz?=
 =?utf-8?B?dUx1QWk1NHp0N0h6WWRydGdwU1YrZXd2UnFzbVhVR2ZSNHI0RkVWU1J1LzBW?=
 =?utf-8?B?dGNoNXVqOFJVVmhTOHFTc1ZDcEtXUVYyQ29UUzhpY2NZWVplQ3lMYWNWSEVK?=
 =?utf-8?B?YXprbndBYWRLUXBJemJ0UjdLcDVMUCtSYmorTlhuQmpIdU5qRHRucCsxRi9V?=
 =?utf-8?B?aWZWZE5ueFhVNGhHR2swN01lWUM2ZU1XcU9IeDF5eDVvREJFejEreHpqSVBn?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wo/8yklBXzwfY3fh3Zdznu59uGCSayUdoLDNRXUN4g1TCpRj3U0PMFSBJtbk5M/9r54zyCyA+AiJ9QdcEQ3sw2zHldsEBlWQjxWKGZkqEfc2e9pRL/FvTyUc/q6S1WUw9SqL2j1NQ5XHnVeJMe4fe6GLmfpKfxxdXD7VkQ/AJd/ytKaxX6gNDv9iZgEWGJOF1jq7VhqAfmofMNZe8I+ZZKGRBvykrLQJ4dPCk+Z3w9HcTsk/hMtGEyoZfKKkM8KsF0UFbOOk3nMxBG8MQtS8KZTlEMQjZJyLYLeJbL4PtCYraBZ+yx5utrzHD9M4bo2VwCSqR0nvYYXuEZ44Jt+Ax6lSCMN3H8s5wEu26KFCmglHIQoJBKHGz5LPiW/ZqXkR1RJwRnaBIrQfhuZg40X/Y3n2B7s1FuisUR5j+hPHzVDd6zpcWNsnU9FxzTx2vCFNeydTcFGpxUrihua1hYssHKsKqHkVrlARBzUoePq6tbwtDl6o7CobyrxFZ6qHDbjXKQP9l4sWzPcnbszVUIkLfyKMO31AkhVZJ8Z711+KrwiMlxmpXUotnViVpMfkdKH4fuwxigVFpH67WcO+optLQ2IB8zSEfHrAZMRX615Vy9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121157e9-ab16-492c-a364-08dd5562f99b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:09:34.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/td5Pc9F1H2TojblbZ94dhxyPOxT/Jbx5u7QVYy93L9yBcfP2BMOJc+cwVIEBuhcfVNWZZV9QO48mKh26ZWj6G+TRf4JH6NEWrqcZLAGNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250038
X-Proofpoint-GUID: f8F3OUrtR0vp47575S058UBiso-jHV6J
X-Proofpoint-ORIG-GUID: f8F3OUrtR0vp47575S058UBiso-jHV6J

On Mon, Feb 24, 2025 at 03:07:03PM -0800, Jeff Xu wrote:
> On Mon, Feb 24, 2025 at 3:03 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 10:52 PM <jeffxu@chromium.org> wrote:
> > >
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > This is V7 version, addressing comments from V6, without code logic
> > > change.
> > >
> > > --------------------------------------------------
> > >
> > > History:
> > > V7:
> > >  - Remove cover letter from the first patch (Liam R. Howlett)
> > >  - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
> > >  - logging and fclose() in selftest (Liam R. Howlett)
> >
> > Jeff, please don't send out new versions of the patchset that quickly.
> > We were having a discussion on v5, you sent v6 today (acceptable) and
> > now v7 (while changing barely anything of note). It's hard to track
> > things this way, and you're just flooding a bunch of mailboxes.
> >
> Ah, I apologize. Sure.
>
> -Jeff

Thanks, I am behind the eight ball on this in a post-viral fatigue haze, so I'd
especially appreciate relaxing a bit on series pace here haha.

I mean being reasonable I don't want you to feel you're needing to be told 'ok
send vX' now, but I'd simply suggest - wait until things 'settle down' a bit on
comments + everything's addressed and the 'usual suspects' have commented, then
this is a good time to send next version.

I realise I'm maybe not well placed to say this as I've previouisly been famous
for resending WAY too quick haha, but it's something I've worked on myself so I
guess, I relate...

>
>
> > Thanks,
> > Pedro

Thanks!
