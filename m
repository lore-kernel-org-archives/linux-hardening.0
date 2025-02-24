Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA7205AD5;
	Mon, 24 Feb 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428098; cv=fail; b=RK9pcsqwxdNVlftV31Li34zimvVIbwUeVoj2ilJnY7lgGxN3fPQCdSOcjDQGI0NkKw5m2C+vWX42ck4VGafTMYsA0+CvRkJf5EmADDE99TRm4Y+jLMLnTrHpiiTe3PW+Je9ggcQK+KF8bKQWnDjl7C/Y5OqiWdkvtLzvSgao+jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428098; c=relaxed/simple;
	bh=inIBTSSTA4OifewTFbhliQC1Xow9MIEQ8KdEXSDvtgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eEXX0WngJXxQ9BzPUZb9MGNRwkIlkJRml22sU9Ivu5mpKf+914E2rs8LoOCU6ErAdbUu9OkoUc/3QVEnta1qiengE9n5PIm1AnO1Mttee4W8k1DMdQDZ/2JTh3Qghyj7VnrtaQGeA2ltCAMB7IeAWC6UQjSuFN6b4TgymopRYkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=onfr5eCn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a7NzzKnk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="onfr5eCn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a7NzzKnk"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJXh5T023372;
	Mon, 24 Feb 2025 20:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=inIBTSSTA4OifewTFbhliQC1Xow9MIEQ8KdEXSDvtgk=; b=
	onfr5eCnEJhfcG5TPoVHWvOG307BXoMjnQD1+OZ/xTrZeJNnjWG8TjdgQsZPeiZd
	1THRmohSVA11cwKx0stUTGWFCn7u/34v8T5dkGyvxSxJ02D4ZsJiwcdIQmOTaEda
	YHRZGa1pOCq1aAHYn73N8q+D2qqKu98Lc4xwZd/Mna9mq28x4xwY5YOLTjujXiFP
	fB4eyuUgJJz7v/bKQonhLEGPE7kWR8qVCqeqoepxgkmaNoAtIwjx2aPZijeTr62I
	M8qfWLsb/It/Bs5k5QaJucTJqbq4fyBjxRrYVmhiMq8LwsQrTqTDLWN+lHithLg7
	HgHFF5jKHhSQdck9UXr/Eg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5603hbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 20:14:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJVKMS024567;
	Mon, 24 Feb 2025 20:13:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y5187062-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 20:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDpJRYZL6OseWhGHJ18wrYxG8fx2168u9JhD5RDVyrEDrH+HcEoCyyybvRxhAEu89bMMANmCi2wXGYhbf7vPOD1gzEuUXVsB2zP/MaybLH7g9KwW4b25MjB4g23t7HptbOXOOTiT7sJp+CqRs0AtZmB9tKx6ybLqtIMBJ0HhgFRgbwU/5v2xZeQ7dqYjBuKBwLME9Ar5srOgePi96DX35lc0H+JK+B+GRehYgB2FevSTbcBQ1eLSYQ7exHEnrXyN/xmObA8KcXvF9VHe47WO39CS2IzpNfVcfXKjoUtywUYFJx1q0KUutjYNMbAJa2ZLZGC1R5qOHmyUMLXzktkR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inIBTSSTA4OifewTFbhliQC1Xow9MIEQ8KdEXSDvtgk=;
 b=aRoOfKJQ+11+72bjbjFOxX1M2fHZtIQTWgewR2YF7d4g+64ja7QYlfKdOF/ccryvNcgshygxoVXjy220lA+zgHHl2MJCZuufAI/M2jRc1pv0Islc0thkUOnoUvpEizEB7fF2FcMXa28NdeheSew3T44zoRgB7vJK3+jdbSEQzbqAUU6g0EZwwo23xuoY5x62aTYJtbMClg6F2/u774K0GLGo2fvCIQbycMJ1kyEESn7Jj4vCD/XnbH/ogb8IPYsffnAFjH4SlcFXxiKbb3AbFs0rsa08VmpW4a4A962dUDdiwQyOiJyDNaUXG9bLorO09bocgGXHKzlYyoZIFIH3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inIBTSSTA4OifewTFbhliQC1Xow9MIEQ8KdEXSDvtgk=;
 b=a7NzzKnkChLkjghv9HCMwV6Y8p8m8LVRGSjcpW5Vs+WWCeGiO1HPEj0WiwX0CowWdH3WBsIUDejHCzEkWxWaWKnThrbDhM8wd2s3m5irqb1yxnBwCWsEbcjs/04XUuvaIpX5tjmxzO2U5s5ae6M04fm9hj99MsxQmmCF+OysQtY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7504.namprd10.prod.outlook.com (2603:10b6:610:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 20:13:52 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:13:52 +0000
Date: Mon, 24 Feb 2025 15:13:45 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        vbabka@suse.cz, lorenzo.stoakes@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <dqaqin7elq2og66e2hju42cmwflu6bwag6fn2zzbapcehch4bp@2v5yrconussy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
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
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
 <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
 <CABi2SkUfABFR+SpjBzHT9dEcsJ0OOHiyttKkQVhqrHLrtZzopA@mail.gmail.com>
 <gr4i4o7cy2nxah52kiyglzl4ax63zdblvwqvqbdl7vhlfdy3ko@izskzrcapjxq>
 <CABi2SkXew-7bDD5c6ZDhbM3kRQPMTXrq=1cXX1rUvy1Yb+XvAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkXew-7bDD5c6ZDhbM3kRQPMTXrq=1cXX1rUvy1Yb+XvAQ@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: d04282ff-fd28-4b30-47d5-08dd550fc1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUdVRHNzUFhXUngxcXN1V0pwL08vOWpQUXdDRFpNZkNuNndLUytpZkE4UC9S?=
 =?utf-8?B?MFpzeitleGpXRWF4aGRVek1wbnEyT09wdjB1bHMrL1BvcDVjSnZ5blcxMTE1?=
 =?utf-8?B?cUtTSjl3dVF3eS9KaStjVmFtRFUwb3MzanprM1VRZ0xhWE9KSE5GUXg0MVVr?=
 =?utf-8?B?c2pROE5vUHU5NkRkbzc3TW1YNWx6V1NJYmk5dFBZNFdYUW0vajhzajNiWW15?=
 =?utf-8?B?UC84VkNQZHREWnRObENaY245QmxlbXZHNmRMTFJQVldGZmNmMDZyd09BNUJh?=
 =?utf-8?B?RWhNbnd6bXFqeVBNT1pNbUJGTWxsMmRqWU5uc3ZramlqYyt2RTZnSGtURms3?=
 =?utf-8?B?WG9oSEQxbk95Q1JKOEhDODlIUmpWSTJWUlA0M0JweWUvMzQxZU05R2xzbjNM?=
 =?utf-8?B?bzFaMmVQUFJNWS8zOXkzbGQ4MzV5K3ltdkp6OXJzR0liOFJrdi8rRmZmWXFE?=
 =?utf-8?B?VHRCd1FhYzUzOXUyMkNzajNubmdWNnppVm1RUmxoSGVaclZ1OE1ndlpNWnl2?=
 =?utf-8?B?UitRa0tucG9hZ2VWUjBYT3p3YzYzWW8xejluRmloMExVdC81UTNSejFKcDN1?=
 =?utf-8?B?WWNnc2tJM2xKeklTMWJyZUc4dzZ1a0ljTXIzU0ppVTRWK3dURmlSc2llNXlK?=
 =?utf-8?B?UnpUMUpGMjV5dDI2dGxQTmtNZEdTdEQya1AzcXV1dDBZTjYyZG5JTXBpTEdT?=
 =?utf-8?B?eDBOZ1dPbzdwSmJsMEd5Uk43TmVjdU5MQjhpMFhkNGRQTTQ5MXo4c1dReFlz?=
 =?utf-8?B?NzlzTVh2ekNhSGFHeHBCZHBwRi9lYmFBZVRMR1A3bnBoU1NBdTEyeHlpMmhU?=
 =?utf-8?B?RjcwSTBzc0psVWRwV3hpTmpWQkpaaGNDN0FHZEJURW55cGlZZ29Cb253NEQw?=
 =?utf-8?B?WFEyVEpsN3EzdkZTRG1ERFJBWER5RFRIbEhxZ3VZWjJtL2lqOVBFWEVWZjdJ?=
 =?utf-8?B?aDJlaEpESG4zK0VLeGFvSTFjb1ByMzFCQTVPcTc4SE1laTBhL3U5RWFoTi9I?=
 =?utf-8?B?dDVLYmFCOVllWDZKR0txaEtuaDhmaCtxVlljSE1UTFo4WmVEbmJZS2xPRFR1?=
 =?utf-8?B?bWdUUy9uM2ROci9nWDRLRmx0Qm8wSFRGZnhXMkQvRSt1TkdSZDlIY0ZWbnRx?=
 =?utf-8?B?ZUlEVzVpc00wcnAxWGppcHk0ejdQdFBkN2Ixd0Vaa3ZHeTJKUDlqSXBFZDBk?=
 =?utf-8?B?OUdwUEVrOXFFQVp5RFpRdlpnbk5ZcEFTVUd0Z0NOcFA1d2t5Z1pCQ1F2eDQ4?=
 =?utf-8?B?dVZzdHZYNWxjMWN6a2J0N29CcUVTRUt2cFlJOENxeVRQMGdRNjk5c2RTVG55?=
 =?utf-8?B?eDgwRjJvZWVkM1FhZ01UOTNTRG42VHVRMU5DZ0hVTkRNbkFGWW1OUFJSMkhG?=
 =?utf-8?B?Y3VLWmkrS3hWR01ua1VKOGhNUDVvd2hGbm9PNFlPcG1OTGJ6MFVhVkIwUWZR?=
 =?utf-8?B?WWxIbWxtVExCOVZrUkhJUWtCNlVPSnhmS1JIQmZ2c1MzTXh1cFp4RkluUUhv?=
 =?utf-8?B?ck1jbmE3bHV3T1ZQeHpET0pXWkxyTnNGQXRwRFFMcUdpK0JLdlpWQXcvMjJX?=
 =?utf-8?B?T0dyUXU1c2ExWGtUYThBUlZDVDEzRHJLbjIzcFQ4WHRRYkQxb2VMc3JDWWtO?=
 =?utf-8?B?aVplTVcrVVVSTnBWSW40RVQ0Zzg2TmNmVkQ3eVdNV2tNSW5aczJuS0F6azgx?=
 =?utf-8?B?WlpGKzBrYXNUakNRYXdlVktENE9YTGxkRHF0TUpSb0xDSWplYXdPL1FtUXdY?=
 =?utf-8?B?d3p0U2xyOUR6WDZ6TUJtNDFsUlVvRmNvZkxGdXpvdmdoV0pxOEtGdEd4ZUxB?=
 =?utf-8?B?bG9lVnpLMUhVMmhEbDNiY3U4cWx4RWszOGVmcjRmSU5oSmJnV1VxdFB3MnMz?=
 =?utf-8?Q?l7qtz8jbwC8mo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RENiQTRrZG1BYWwrVk1WUEdNVnUzUkxZanNra2JtT1ZwMjRFNUY1d0lhQjlW?=
 =?utf-8?B?dklOd0w0VXNOT25ud1RlTHI4a3oyWTNaNDgySXlwcHdnUzZnTEVVOW8yYjFo?=
 =?utf-8?B?SGF6RXpsMktJWUQrb0R3bG5naE5zVTRFZGRrNm95U3UwN1gzallSRHZuSWVI?=
 =?utf-8?B?QUtVNUU1WTBrNzBWenYvbmlKbVVFaG1EMHdHUHU3cG5ud0xFTWhMOHBtdTY3?=
 =?utf-8?B?VzU0QlhMeTFHbGxuQWRzeHN1VVM5RWQyM0E4dHcxNkNGRkQyRUFlemJFeHcx?=
 =?utf-8?B?Mk1JTjNHMmI1MTh0eWtWSjMrdGtpa1YrcHVaRnZ0WlVpQldvQWRocHQ5TkNW?=
 =?utf-8?B?NWgwdW9ROFZFQjJBMlhKVkNxMWNBQ3JNeHlSU2kyR1JhU1VuNHRpSTdEdFQv?=
 =?utf-8?B?K0hLU1JGdjZ4RGNIMkdqU1NmbmFBTG96ZE0zVWtBeW5vcDMrb1dxTFVCUVZG?=
 =?utf-8?B?bnBZYUIrSzROK1BRRUhyNFc2QnFlL0I0OGJaUGQxbGYzL1hDSlQ1bzZObk9W?=
 =?utf-8?B?TkMxeTgzZEYrSE95eXZZRmlBVFRFa05nMFFvalV1WHBTWUJMWnRaYUZDUGZZ?=
 =?utf-8?B?TXk0Zk1JK0RaUDBhbi9ZMGltVktZNzJmZ1UvdWI2dDQ1NyttMm55L2NDU3RC?=
 =?utf-8?B?aksxcVl3bU1pZkU5Y21ydlNuNVhlOHYxUkdaeTBCb1NiVHhNN1F2S3RDN3Bv?=
 =?utf-8?B?MnZzOUxrQVB5NXUwRmdjWTVEV1JGRkh2eHhpclRLa0hWM1JtbWZKV0hPTDdy?=
 =?utf-8?B?c05ZNVlzSWVxTCtoZEpFeVhGMTVMc1p6cEFuc01Va2d0YXNuSU14Ty9EWmI1?=
 =?utf-8?B?blRuaU0xV3ZxOGdhanpCTGp3SXQ2Nk1vUWNjVS9PYi9VWDRBYXBUNktTRHFV?=
 =?utf-8?B?WmVkZFA3Zlo5RkJONWdESkh0Mml4YWNxRUpINzQyOWY4dEQ1L2FWbmVDQloz?=
 =?utf-8?B?YytkWmlVR1JrSVdqeXJMMUx6d2FmYkNPd0RUKy9OZ1FCRUd6djRjbTZKK0Iv?=
 =?utf-8?B?UTlwR2ZGd1N5NnhyNTJ1Q3FOcGF1SWtody82MDU5VHd1WU52aGEyUzFEOUxL?=
 =?utf-8?B?MFBmSlJlbEJ2NEZFU2hjM3ZRTko0aGl6TjNOemdsSTdrNUVOVk44SmFvZXdy?=
 =?utf-8?B?empXYUhlVG1naUdhc1QrWVJXNUI1U0tJTEJKWUhXQnZyVXoreVJEN25HM0ha?=
 =?utf-8?B?ODdZWCsrZDg5dE5lb2dlYUxpekxDWHQvS1o0VHltTFdlK0dZQ3VVUm5aUks1?=
 =?utf-8?B?ZERKTGh0TDU3Z3RYbDhlMXQxWTZkWU5QUUpBbXNIZUp6ODc0bXhIT2tKYW9R?=
 =?utf-8?B?UGEyUFZJTFdicEdnQUZUZXVDK3kzWnNWY0RwZExSQXMzbWZIdElYc2ZkYnBB?=
 =?utf-8?B?cGoxRUNrMUNmUHlIZU9KU3l4SWNnOE96YklZdGdUVGtaSkxEMkhpTXljUE1C?=
 =?utf-8?B?TGUvbThIOEZDYjhIeDFxZlBZWUxnZWE1UG0xQVFIWEcyOXZESDF5bUZjRkpE?=
 =?utf-8?B?TGtEUklDejI0L2RJSVFUL084M3RkQjE4a0dOYkNSdC9yREdDNlN0cGRKc05Y?=
 =?utf-8?B?OGNhbkdRN3A3Y0x3cFlSYm1pajZKVFpidnk3bHdCSlJNQXRUc1NpS0E3cEFU?=
 =?utf-8?B?ZW1VWkZHMVZQSlcxZjU3SUZBWUFMUTk3REVqN0x3bStMZ29pWGJvVmVyYTlv?=
 =?utf-8?B?bGhtNEdVOTFnWG1hN0k4Q0Z6L09YbXllVmtndXFndW5pNERoSklkbWJkTFpa?=
 =?utf-8?B?MDRXOUhsMW9qa2kyQWttMGp5NkJycFlXWDlkQ1ZJWlNEY050Uk1uaVVhVVVr?=
 =?utf-8?B?blpSZ041TURIUlBnaEVleHdGU1pIQ0ZCNjdFZW15K0tjMmRZMjFDYlpocTc2?=
 =?utf-8?B?dE54SzU1T0xUY1pLUlkxZ3hQZjNjOG0yMUxyQkZHQmtXU2tlVy9SVlhlcTM5?=
 =?utf-8?B?dDhJK21wWnVBQUdpY2N3Y1B4SC9HOTFRNFg1OEw1S09LSWQxV3pxNVJLTm9B?=
 =?utf-8?B?VWVVa1hibUE4Q2VncnMvUzZISjlnQk1sRXpRZld6OW5nT2NTMXFLekdHUGFq?=
 =?utf-8?B?M3FydWVDTjZKQXlIcWZkekNycVc3dWNSNFU0b2hRbTZXeWZZQiticTBpYlQr?=
 =?utf-8?Q?Igx6vYjNhKZxnVOhETPnEaNjy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NbEnYzHlq73TXSmCSCFQ99t5QgWivRFY73k/WUGmi90uU5xsLW7piJn0Yhkx1+u9VXXeXp8Bj6YStJ2QIRIe2TsiPQCMGEb24Yt59OzViR9UsXt28ks7M5zFFdjH782xovGSFJf1teDiYD5yaUBzbr6PwavfvfWYfqfLhx0TomYSEqwLOUKEU1+Nc/M9/xGZvLBpQJRL6F7Rsie5FLcH7xQKQol2IVHExYe3dcQv0wZV2L/WdfnagsOZ5jKLcmSaSr0lsMe6TXzW0Th1oafB4pYyyV3xbB5EWmRRg+DvS1r9Cbke0K7aizIXwHxoq5nESxPug1c7J20kSqEJQ0hTm7WdVJ+4VtqKe5a+UoVcNSMJqxXvlPhnwlgVJKcKFHiOeoRI7NtzPW/PoyDTgnMUGgl1DKv7p6M+a8K7ka5eJCIvEMqCSk1JGncEkxklOdu9+qO4XRYI1UW2VfBAeGjLlOX8LBQUjOpyqzO0ajRjy9YkQTBUwpX2SDYcWG1gvwuBmPFVexdYNHPNoOXF7nGX5nHSk84KmWNEGN1RCW+UeWZG1l3NGBl6ncN0QNGd0eSLzk6QRtNW9dfIKD+mllIFH9/VS8yqgatgv8PzpGB7sBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04282ff-fd28-4b30-47d5-08dd550fc1b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:13:52.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkzSN54UJIKaoYcSKe7C2iFfzp7UYg8G1d0Z1ld44ffVxFUxUWY7GlUP8ABe5CUXofCs0mBzqes8QD7N/VWniQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240129
X-Proofpoint-GUID: DlYov5UQua-RBJUYk3wLh40o1s3KH7iz
X-Proofpoint-ORIG-GUID: DlYov5UQua-RBJUYk3wLh40o1s3KH7iz

* Jeff Xu <jeffxu@chromium.org> [250224 14:40]:
> On Mon, Feb 24, 2025 at 11:18=E2=80=AFAM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > Also, do we need something like the above test for VM_SEALED_SYS?
> >
> Do you mean adding selftest for sealing vdso ? or test the
> VM_SEALED_SYS macro in 32 bit vs 64 bits ?
>=20
> CONFIG_MSEAL_SYSTEM_MAPPINGS is by default disabled. I'm not sure
> about the common practice here.
>=20
> I also don't know how to detect CONFIG_MSEAL_SYSTEM_MAPPINGS from
> selftest, that is needed for the selftest.


Looking more into this, I think it's fine without anything in there
changing.

Thanks,
Liam
