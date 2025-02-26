Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364732248AC;
	Wed, 26 Feb 2025 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589961; cv=fail; b=XQk5GiJOkuPO4s8G6nYeKmwo+8+OdrM7ED3eGMmPCtguGFVSeN8mb32UjCtiPMnvIzS7AF1TpvccHgiIn+/wvHbxbUU0btF6O823vv+9KkGBdiL9sSoFLtrbA5Ex6WP0xytLQNRn2I0b45aV6STc3VBQgFkzpcqCrgqWGBPq3Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589961; c=relaxed/simple;
	bh=gbGUgtZUkJVv8DDcwZG6nRqOCpRHUtOg0JU+DL9SCHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sb93kmg/caybketNkOHaJrINr7VUNbqVt1Sy7+JASfFIjQWwriqoji7mR9h5wYB+704LHzx/ORJbcSQPW8GfTNNUt+Je4fIpp7JAQqcfWdqwtsHRXHakvChR3QNo45phKAb9FPz8rk8te0mK1NNNYGNupzRb9MeCPxbCGYKnmLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XCr1GQqQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uJaFOruS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XCr1GQqQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uJaFOruS"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtakr005829;
	Wed, 26 Feb 2025 17:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8SDgjOlmx6nvyt91WOm2XuDRulvPM7+DM3+nr55l3MY=; b=
	XCr1GQqQkDOEgDOsEQjRW8k2r6aD7EDgfC4RJvEN0LMGAxHBInBV/BGjwP+9Vev+
	paMWdZuLwelPkoSUg4DgOe+hiZaMpwJ7cM61uObiAPXim9kEqBG1qTqXg/f8ffZC
	qmjw25VugMmYHnBrzsh+45cBKEWqPhO1U7wYnBEqNPUao37rso0+vXkZ8gmLTlFP
	Js5qjjrK7/IlqRpBE9JLFF/goUKG9yRcwXmR51Slhh3mVlOUdSIAsFUEfuwBsiiO
	ig7jfgG53J1cCD3DAy/fqQNU3UBwb8zXAXImnuXq0HECxJeIF0+0KYQc+HxX6e6T
	IofShBe8hV/6k1rK9DpSzA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf1kyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 17:11:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFjG13002714;
	Wed, 26 Feb 2025 17:11:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51b6pdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 17:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gipNYiHvnTuzoFagwZ177+RA7WNvUP9gjLtoKWOjf4lmNDI4hkbPCUInnV43dGUtrsh3flqmcFBii33jr1SCiEjKWvXmFEUlFBfQutBvCS1ImCOYObSi79dsM+dTRn7O8udPA779GfWKZYNNAMmahNgTDXmOe4BrlFZ1GJeCeA83Ox8otAUuTH4z+gyl1Z1+8I9jEnIVLTIpoVbjg5J/AaYY9fVTLLhTjkErDMJ4lAzZvNGgl02/lJjuaa/xAh1nDbjw9dWvNnjQbcDtv3yoEAVeCvVor2X9nyeYF7dNXZsdQQe3+ZiEdA6NQz0ni1HK3bzmBA5//+/saJIy8e8Fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SDgjOlmx6nvyt91WOm2XuDRulvPM7+DM3+nr55l3MY=;
 b=c8uFG+dqDkmdNR5wrIVIBbf80ySg1Ckl+HBtsNFHEqZu8vaFPqr3ptXvWtDv4PbJQM19uiwog900f77kgFYNBu2X9cJNZ7Mujj689udg+j53huvGYCwi5hvfyLFsasNdt38E+8P3SSFIxG6W1G7dYw1DLajcHlp4t4n99Q/3nZqZ6icJQsFuFDaLfECtuUS4vbtRP2PQ4uSoP+d7jRDsNpuuiPUxHaJSCYBeu0igdZEWa1LiHaGtg+/kP5pD1rFywDwRIqypgc0FRiLc8hQBvESGHJ7ilJBFh3kTQ1tQHG/wlEPCUYccu/9vwoGRUKWPJncUk+ypodmW0l1uJjiCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SDgjOlmx6nvyt91WOm2XuDRulvPM7+DM3+nr55l3MY=;
 b=uJaFOruSVUikZhnBGiU8Zt9UpY1QEPnTWedsRhham+LYa08R9KKo23FQGWQnlHmAUXzuG/lQaTaN11Q7+vZmUWhv8M5qy9hHXRiDnChgBgLg88hqa98UR2hDuG1uUMQJqt3Oq6d4j1mzTf5R0NHDhRcB5F9Mk+GOytl/sF2E9Jw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA3PR10MB8186.namprd10.prod.outlook.com (2603:10b6:208:511::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 17:11:50 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 17:11:50 +0000
Date: Wed, 26 Feb 2025 12:11:44 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        vbabka@suse.cz, adhemerval.zanella@linaro.org, oleg@redhat.com,
        avagin@gmail.com, benjamin@sipsolutions.net,
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
Subject: Re: [PATCH v7 4/7] mseal, system mappings: enable arm64
Message-ID: <qk4m74uscjxdnlchcxolvgbw7ijppzqk57ajyc4m6jjixq5gti@lokjqegpftzh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	jorgelo@chromium.org, sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, johannes@sipsolutions.net, 
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-5-jeffxu@google.com>
 <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local>
 <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
 <ea970928-ccea-4314-9cde-b64fa1a7824e@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ea970928-ccea-4314-9cde-b64fa1a7824e@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA3PR10MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c09cf4-7d40-4a0c-00f5-08dd5688a89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THRkOG5mLytVWEtycmRuR09Pb2JKRDI4VnJLbWwxcVZmRDJWOC9mTkFlcVVF?=
 =?utf-8?B?MUxZSmRONWZVUVBIT2JVRmdWUHpxNjgrNlJSNVhab1gvVmlTeGVyZUM5ek9Z?=
 =?utf-8?B?Y3kvUTZRMFZkbk85dTZvUkFIV3pDVTZrY1AvYzNNNUZxdXd5VWV3SkROMTRj?=
 =?utf-8?B?ZGVKTDRZSXBaT2NJTlYwZUl0QktDZmd3WTlNM0JwVTlvRUFWNUZER2VRbk00?=
 =?utf-8?B?a0NJZjR5aFJrUVhFS0pVMmRkYkYrQkFPc2hVaitnZnBjeG5iTWpMZXowMkl0?=
 =?utf-8?B?L1ZJTjRNK3ZRKy9QT1lKdGZ3MVpSSkgwR3FMQ2VLSm1wcEp6cjBNWVFqVkZS?=
 =?utf-8?B?aGpvcnJJeGgzMkNMV01PYnhTdm1PazRxcVlEUzhPQzBWN29jSFJPTmlJQ3lD?=
 =?utf-8?B?NlJFNzRUS2lKMnllUWdpSGI4Z1lGQmRLaWdReDlPUytHbkI0ZS9KeDhMN09v?=
 =?utf-8?B?QnplNUVRTys4SDdVd3k4NXlPZXBGM0t6WVVTMXViZ3RpdnlnTzU1aWhVQ0N5?=
 =?utf-8?B?SEp5WkNnYnBPZGQ1UWtldlpLL1VNbllzeWhFUFJwWXZkeFdJUGhrWjdxdzVs?=
 =?utf-8?B?UVZUcUV1aDNIWWROT0Z4dzJxSkNtTzhUKzNOK3h0RlZoOGpLRkpmMURWTFpU?=
 =?utf-8?B?Vk0wSXZ2NTd5OHpZYVN0ZWF0K3Jxbm1MS2cwUHAwdTMyZDdYV2E5VTNNdjh6?=
 =?utf-8?B?WGlJekY1c0lGNmpYSDhsMGw1MjZoNVpjZ1ZNakZqdG1WY01ha1QvVjROa0J3?=
 =?utf-8?B?aC81dWVjbEJTOW8yQldaa0hKYU41cnVMbjE5MFRLblk4YlgreEF2RjRvdXMx?=
 =?utf-8?B?c0docXJHdnpFVk9KQ0JtZzVoK3F3UktlVjdBTENsZlVvOSsxN2pZOEMveUZQ?=
 =?utf-8?B?M1ZtWm90U2puWTZZRmdkVkttbU12dWNOVGQyOU90T3N5Z3FRUzlJQkVhcUhB?=
 =?utf-8?B?eWtQSHc5OTZhSW54bVBObC9tV2JoMGlzcnk5TzF0T0xYamR4K3BQcEhjMjJY?=
 =?utf-8?B?SmdQWXcycGRqaDF0WE1RTkZXUEMwRnAxRXFpa2M4MldRNzJLVTVqYlV5OW9i?=
 =?utf-8?B?MmdXUWxuWGhKQ0svWWtmM0x6NkhRYXNKeWt2T1ZkajRXRUl6c2wvK0JwalJL?=
 =?utf-8?B?SEFTVWxQQ01sSElOdFkxc0NreDlya1Z6c3hoWjR5dHN0ckNadG4vcFFaOG1C?=
 =?utf-8?B?WlBKdUtnKzcxRHNXbnJBMzRJRkdXdkhUNm5jMDc2cnZNemFIbjM0Uk84QmVa?=
 =?utf-8?B?S3JxYnFmV3d0SmRzc21MWkVmRzdpVENWLzBOdHoybUpUMHVmVm5vWmF5akpF?=
 =?utf-8?B?WUt5VG45dERMcTMwYk5KR0hZblJSUmtuTVFtSkQ2MnAxZldnZDZjNzJHZkpj?=
 =?utf-8?B?VTJPRFFsN1oyb1o5dVRRYW9wY0txQVVGS1h0YllvMGZpR08zNlZCSzl3Ymk5?=
 =?utf-8?B?QUFzVDgycGx1RnBRYXhSZnA4cmpmR1h1SFNTdDBOcENXNnRCSEY0U0I0V0g0?=
 =?utf-8?B?cFdLQkRHbFk3MzFHakhjWjlJMEJyNTBJOU14OU82bFZMRk9vUGg0Ni9sOGNE?=
 =?utf-8?B?ZEhQNnZRb2tXN3RZd2I5bjM0a0JEY0Zxa2VWTXc1SUFTSkRWZGlwa1FtODlT?=
 =?utf-8?B?OXRyR3BCNmpUVk5NN2pHWEhqazY5Qm5YczRxZ25scENDSGtLemZxRUxOQUZh?=
 =?utf-8?B?dkR5UGlNUWJHQzhQMUd6RzdWUzJjT3JEdFArR3dSU0doaDNLZndqUkxramFN?=
 =?utf-8?B?c2x6eG9aQ0laU2dkQUQyRTdVM0pCaGJzNFZyZmJpeUlldUNzeEtlVTRpRnRl?=
 =?utf-8?B?MDdOUTZ1VW9jQzhuM09WbloxRGlDVXhJeit5NDh2MDBaSFU4UWxCZ3Zzc2k5?=
 =?utf-8?B?MGJXdnZkZmZ2NDd5cjlCajUzd0FKN2kwd0lnUDA1N25NeFFkd0diUmplR2gr?=
 =?utf-8?Q?JSNJ5WNcK/bVyP0l111QcaEQ+dx1D6Kr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWFESEo4UUludElQZ24rS2dXYUpVTkhwOGJPQ09CZmw2bzRLWXVFS1ZLUkVE?=
 =?utf-8?B?Wnp3SjlOOHhhVnN4cGp2V252RG83ZUIxVXNia0FuUTNieWRUN0hvamRBUVAr?=
 =?utf-8?B?RWUyeW8xUGlYa3h3eVl1bXJRQldOMWNsUXJWZFF6SG1rQ1Nid1BZcjhjVXQz?=
 =?utf-8?B?NkFUQnVQOGZPRklNK1A1NUZqVWNpa09pbVFiTkRqRmthQ09lM2c3V1VZQzZr?=
 =?utf-8?B?SUNwTlArVXg2OVZpYlprZEpkVG8zdFpUQ01rc2lFRS9aUHpkR3hvSmVwdk44?=
 =?utf-8?B?VXZhK2p5enAza3JnNFhEQ2pSUmk1T1JmMTViaWlKUTVLcDM2d1c0Zi8xaEZK?=
 =?utf-8?B?Y3RqNGdydFNaV3dKbU5oV3BoWDYweW8xaWFvdVpPWTJIWTk2ckZtRmQwT1lR?=
 =?utf-8?B?dWJNdldyeFpXYWExYmtodkZEb0tlOHhKUUNHQVdXZXVzNGhkU0dtZlZVQnR2?=
 =?utf-8?B?OHQwOGJzTmlHSlR4VzR0VEVXclhxdGhMM3lxZ05lejYrNjJMcVZYOHpqbFcx?=
 =?utf-8?B?V1FGM01KbXZha2dybzM5dFlmeTAzU3BObjVnb0NOcWx5cUI4NkdaU0M0dFFn?=
 =?utf-8?B?S2JJTjUwUVc4b1ZrZGYxbGhBbW1rVjhGb2JrakJXdkZpWFNkd2hLclJ4cEF4?=
 =?utf-8?B?RWN0S2QvSDZtLzdkTFJRQjVjOHpHS1kyckgzUi80TkdJb0JCdTVHbEltT09i?=
 =?utf-8?B?WVNzOUtwdE5NcUFtc0UvdlJrL01IdVQyQlcySDFyQUhvV05XQVZoUEg5RWVS?=
 =?utf-8?B?T3BaR0NmekVMdWQ1VGd2cmZiNzBncUVPZFVpOC9XQnJGbWxrVC9vMnhrYUtS?=
 =?utf-8?B?ZkxsR2plZHNIeEFwZmozZmtIcWIzbC94M0ZqTFd4WWJZRFNuRXZoNHYrWHZP?=
 =?utf-8?B?WDlGQmhEaXA4REQrSm1xRHIrSzlRSDBoN25pcWIvdEY2Nm9LZTJmNnYwZ1Y2?=
 =?utf-8?B?N3ZWczdQemcrUkhCUmk2S0dJMWdyVjIxNEI4TXZLajMwdTF1bzBRNTZiYU5W?=
 =?utf-8?B?U2VsYStoY0pMQjFMNC9jb1FzQ0N6Vk5xSll0cWoyc1lnNzhlVnV0VEp2eUha?=
 =?utf-8?B?RWczRlZBTUI3TlpiZWFqZWNzTkJDc0ovN0xvUmh1N3JMSGxMdjhNUk4yVWhk?=
 =?utf-8?B?UERDb2RocTZ1cjFudXJlUXNUL0IrbFlSSi8wbnIrSVpSUDh3ejRHK09vZ1Er?=
 =?utf-8?B?TElUNWlkdG04bXZ6Ky9zUTA2eDFxT3ZWdGNPU3FvbktXM3JiU2xSZ0FuK01q?=
 =?utf-8?B?aW83UnIxcnloZk13dkliOEF1VWJnRHp4N2VBMHhDN002UzAvRi92S3hlci8r?=
 =?utf-8?B?bzhpQVRsV3dTZG1NMnlxK1d5N0tZa2E1MHlOY3Z5V1BuWnJxdG12SDdqSjJT?=
 =?utf-8?B?cWIrTUozdVlCbzR0QjMveEtuRnlTVzFMREhLcC9VSHpvczQyU3FTSjY5bDBZ?=
 =?utf-8?B?K1lkN3FZZSt2U2p1MXM4YUZHSHZ0WS9Xc2RxVWRMQnpGQldnd3pxNVNjUmY3?=
 =?utf-8?B?aUhUQkpuK255VnZ4WnpWU0Z3WitWNmxFdU05TTAxTkZVaU9pVVdBMlh6UVN4?=
 =?utf-8?B?NWlQOHBZcWNJWDZmUktJOFAzcHBmT3JaMEVzNGJUQkcxNGo3VkRJMjFHQk1G?=
 =?utf-8?B?blBqaVViZWtJMUNFZXBtRG9UU0UvanFLbjREN1ZBeTJIcHFQODh3RjNmSHNp?=
 =?utf-8?B?UWxocFVvYVhyanlNbjU4NStUYjhWdkE0Z1gvaW1pYm5DaG1TR0tZamZRMzVG?=
 =?utf-8?B?L1BldXpUSGcxc3lMdVh0Y3kyV2QxaHhjaWhtTGVIWWhUSURwUkU2c0hIbFZB?=
 =?utf-8?B?R3ZDZVpEeHZGU2tUVDZjdXBHZ05ZVWtyQjRBTXlXWm03eUF6VS9uMGxPSEhz?=
 =?utf-8?B?Uk41WjJWWGh1T2tZUWVyMXhzVndmcC9LRGNmSUVvb1hlY1VOWGZ0dklFMVZG?=
 =?utf-8?B?aEJld0R5T05KMG1sbkVFazRnL1JuZnEvanY1NUdTU250dzFTUE56TFFORUxj?=
 =?utf-8?B?US9Ja2FuTHJNOXloNjcwNlRxTFZZZ0pPdXJmSjhuRU1FbG01SWpaQWpVdHZv?=
 =?utf-8?B?ZllJM3dPR0I4QWpOQ2dwdjZ1bHBDSkowNXR1RWNkK3ZmZE1rVjMvWTJVTEhh?=
 =?utf-8?Q?3A22j6jkYoi/o0Sya0WK6m9iP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zu8jveDWK1PtkR7NN0B4Af6kC2iJAH0CjzbuuV/wILOXRCJ0d3zxGnhxiwcj6xJ326w+Pyx88IcbqfMivswQiDvw3/3tv2W2Do2HAA12ipMx+Q7vu/P+Fcrd6EQm2NohfsZgAC1UAeqyxMQ7dx3nbbkGJhD3CWkO8Xp+yr0e3rZ2iyv79CsdXh3wn2530XV7CQsjutVuOLUUesU1n0AqkrPWP8hRSRWGV89/OWJuv0T8DG0une7NajqQfREyoQluogSqa2xKrSo25rOY12lQ7ah7jXJ0RSOezhBh3RMfgMDYS80FomC96AqizYyonUQEFlNQPue5fMjjqOWxB+6yRHaW6ZYUBEhAcl48wnvn2KflG0tgqDHdf3GdiBEginqi03+PRLwDqvUnIK4GfuxIdqNor7J/0zQWx6mVoEOkGygqT+Ksj8/+g0ZLKO8h0qivJDnpsd66b2VjLLMer4f7OJlV5nbD6YVS20WpVAT8d/ULf7xB7rtRsApGMDZuM+A06rBnptc7OjVXSc95JSu5fjAV6bnh271l1WrTIvmFebj1wJU1Zp9IJe698nuISJ1NByi8rS8Kz7c5PQYdPfJXh7DvkUf7XNhugKr1OjrmKmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c09cf4-7d40-4a0c-00f5-08dd5688a89d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:11:50.2339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXjxHRp7I6h7wLmBR457/Jj/+GG+9+DX2/UzZivKOJ3XAveu5gLeYtNtPZgK+5BjQOT3HSLArWSCUidcfBafiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260135
X-Proofpoint-ORIG-GUID: yAMCgK4qZ9vFeOmZ886BY7BRx8nJQ5wE
X-Proofpoint-GUID: yAMCgK4qZ9vFeOmZ886BY7BRx8nJQ5wE

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250226 00:26]:
> On Tue, Feb 25, 2025 at 02:26:50PM -0800, Jeff Xu wrote:
> > On Mon, Feb 24, 2025 at 10:20=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> > > > the vdso, vvar, and compat-mode vectors and sigpage mappings.
> > > >
> > > > Production release testing passes on Android and Chrome OS.
> > >
> > > This is pretty limited (yes yes I know android is massive etc. but we=
 must
> > > account for all the weird and wonderful arm64 devices out there in co=
ntext of
> > > upstream :)
> > >
> > > Have you looking through all arm64-code relating to vdso, vvar, compa=
t-mode
> > > vectors, sigpage mapping and ensured nothing kernel-side relies upon =
relocation?
> > > Some arches actually seem to want to do this. Pretty sure PPC does...=
 so a bit
> > > nervous of that.
> > >
> > Can you please point out where PPC munmap/mremap the vdso ?
> >
> > Previously, when you mentioned that, I thought you meant user space in
> > PPC, I didn't realize that you meant that kernel code in PPC.  I
> > tried, but didn't find anything, hence asking.
>=20
> Jeff, please stick to replying to review. 'Have you looking through all
> arm64-code'.
>=20
> I ended up doing this myself yesterday and found no issues, as with x86-6=
4.
>=20
> I said I'm _pretty sure_ PPC does this. Liam mentioned something about
> it. We can discuss it, and I can find specifics if + when you try to add
> this to PPC.
>=20

PPC allows the vma to be munmapped then detects and falls back to the
slower method, iirc.

They were against the removal of the fallback; other archs also have
this infrastructure.  Really, if we fixed the fallback to work for
all platforms then it would probably also remove the possibility of a
remap over the VDSO being a problem (if it is today, which still isn't
clear?).

Thanks,
Liam
