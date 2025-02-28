Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE125E461;
	Fri, 28 Feb 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739200; cv=fail; b=eDoMO1mb2tOk1sFMb3k73Db1240ByobBlKChFMb82rdj8qSII7CcZZWj/xHD43N07jetHF1N+Iepq7yAbj+3OOJyTE/muoCjB+EOJ2n7QL3f+l9N6ROKCXjAR2B204OZMM546FSqhhRao5draJGd8Mw62O39e2hwc66VExW5F48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739200; c=relaxed/simple;
	bh=jr+3HE+kvLnRkGnVZ1TmzNBqx9kbrmJsD2KpEbtXQws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/OWPVNQsGhN9Yuzf/v4+gmxRstAkBOqVX/sluf7q7h8QyNGp3AQAtmNAiJshp8i6ucXCs/YbYjpxwRD7SgJDGx8Y9AGWotYvjUhN+izxWEI4sJlmFChJZWZqA+2D2CdLmMvVLGIC6K0OoVbva4r8TTf05d0PdxOPZzrwbUH5iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AxZb5GhK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lFhLVS0U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AxZb5GhK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lFhLVS0U"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S9Berd010450;
	Fri, 28 Feb 2025 10:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RRUf07szAzm9Gd5epvQkIfD6FBrrZ9MbQqphkSzN+W0=; b=
	AxZb5GhKqY0WiWxgX+d5/+zDtT4IYOAHgC6UgBW8tctGC7N6EnKNXF8gLs2s533R
	0S0g1gWpiSipZqYaNFp6eQG59miv2y9K+f6hm6PbrZK68IzPfMP2PZzVHcgAfG2y
	fsQxZ2gcVP0zOMogjIIiH7ayvoMWBx6TINpCd5Xs2cqrR+6lFtzm17VVjHIomFh6
	IpQcbDGgZ31BOhIkyXdfb1yz9K2/9Y/v4kfMVVqip9sfRKLEm7VyqY3oe/SIwdYp
	NT5JrmnLWNeAURe0C3Yd+EpMTZ240ZRq5GhWQGSB6v6d7v7aWzNLhevnWPCh7NIb
	+QoHXFauXJmZvm2ORQgfHw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse59yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 10:39:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S8pBcB002777;
	Fri, 28 Feb 2025 10:39:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dnu4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 10:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZvN6ao10PY0ISkdfr5aNOjZEea7yLtO5YVGPIajfeNOBFVn0grXiXDkpEgQqUNjRFZFKq9ygEk0bu8tVPhWLBw3qAc0oOHhtn4YHDfzdmf/BZ6X+wF788Vzf8HHAcxPgZBsrzD92Vgs+DlVJ6T+hkj8NyHwJ9SLKdKBP8tdWBb4P5vJ3VosxiVY9cwdLXfGE1zHLkLExPjjvLzJr4xG/H31ig9CYE/9gXwmb2aTMbtY/YKqTq8iG9ZAUqE7QFGd8R5ZFFwQ4J7qSI8ukrJ951KghH4dO7h8oTl4Mu1lmxuyRIMM5dz+fypbFQY+WYgg4Mt24+lJmionv6E/GyHatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRUf07szAzm9Gd5epvQkIfD6FBrrZ9MbQqphkSzN+W0=;
 b=vhjezLP/rW3BYhmG14/pPdiJ55C0YVIU3f6mKWhWxiuODmw63rnJVSBjDyS+alYn1dvpWMt/je2kGm/jeYd/LzkcDpqR1bMyJeBNNU/GZr9g9yVpKpR0biKLJ4a/KuMkvj331ayAJXiFuuv1pzHWeTpFYGZ3YLNYQTNnjNETNV1cYAIed4A5FD5MQlbCO93RnSk3oXIR2fB0CAzW9yRpSD3SqotEw5k5Ku/Pd2C+MMW7SsgS4zle1j3/MDBegRAabXTsqW+hyCsf46IwXn0wEqYizGnx5eqvky/a+meumoSJBD9yPjwQ9Vz59fJohZUlYgj7qwIoZCFUjxJ/4suEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRUf07szAzm9Gd5epvQkIfD6FBrrZ9MbQqphkSzN+W0=;
 b=lFhLVS0USAeeW/FIQQ2z4iYNI5akvbbBVV1Bt53AdWV0xKzHGSJ+J4La0iYPAG3BBvOaKgrYNhRoHJDfoXClf6Q7qzpCQslUH3kCQ9/vawvg34OxjiDsg59kUxVG2IW88VY9Wh4aFX0yh9FozgfmkAT/Fu8ZE2GVZJMvJfnOg60=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB5215.namprd10.prod.outlook.com (2603:10b6:5:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:39:13 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 10:39:13 +0000
Date: Fri, 28 Feb 2025 10:39:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        vbabka@suse.cz, Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
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
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Message-ID: <97c821e6-e59f-4a7b-a309-acbb81108b86@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com>
 <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
 <20250226180135.GI8995@redhat.com>
 <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
 <20250226182050.GK8995@redhat.com>
 <ba83f8c3-6f8f-4ed9-81ec-104f72ea4ef1@lucifer.local>
 <CABi2SkUi6EOfMag37GOLNt3Fb71-QgYiXbcwVuiVTreRuEFW2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUi6EOfMag37GOLNt3Fb71-QgYiXbcwVuiVTreRuEFW2Q@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0127.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::6) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b1f50b-7dbd-4b3c-1b19-08dd57e4243d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDZENzlSMXl0SGROc0hsNGlHOEtoS0pvYVJtNFNOUE5NY2duNDcwZkNGdkFV?=
 =?utf-8?B?amNycmg1d0RPSVVicm1IVWRlSVVYMTNHTElwWU5vQldPUmt0YnJmVThTOFND?=
 =?utf-8?B?OW0zbENnRWlxd2xKZ0FXR01EQXJaTWNENlk3YjRONXl1SEwzamFabXYyR0lH?=
 =?utf-8?B?ZlJOWHpIMWtMT213TE1qdEozSmR0VFJiWTh2dG12aDAxT3N2a2hPeEF0a0dY?=
 =?utf-8?B?MW9TMHNETlJzWG5vSndkS1pHL0gwdURvdytDbmVweXpWV0U0OTB1anMwa1Zy?=
 =?utf-8?B?TFNBQkR1RnJHTk1pbnZqRi9VNy8vQnRpUUQ4MlFSTzZPUlQzT3pLdHFUd3VY?=
 =?utf-8?B?ejY1U0ZLMS9RclIxZytuL1NZdXVpQ0JNbHUzZFBrM0FVbXBnNVFhV1VIalpj?=
 =?utf-8?B?R2VpbFh3VUVFZXdTRWhpRTRTTThIRFNUeDAwbnY0UDIrSHlnSFR5WUVhRFNl?=
 =?utf-8?B?SklDQm1aWjdDOXBjUm9jbVRMRmR1emlwTFRwS01FSXdENXRReGFzR3hQQ0FM?=
 =?utf-8?B?dkxHMjUvREE5S0JHai9BcTJSU0VvZTBHT0hJaU05NExGZitCWHNsZW1xTlRs?=
 =?utf-8?B?NFNaSGtJL0g5NW5jTTNQM2VOTVhrdlZITWZneEF4TUlmbXIyRzg1NGZkaDIz?=
 =?utf-8?B?ZkVyKy9EZGpzOCtLY1pPVmMzMktXOHpKV3B1VmRyVEFRTnBWc2l5ejJGY0Vk?=
 =?utf-8?B?RW5RNmNGMThBMm5HZ0dVeCtUR0dVanNtdC9jcTBrbEUyR0JDdnl2b2pod3E5?=
 =?utf-8?B?K1cvQ093VW1JbEtLZkc3eFFOZE1BQ0NwanQ0K0VIRXo3SEhnM00xQm1DQVBS?=
 =?utf-8?B?WmdraEJIckwvVUJBc1d1STFqWDM3M0hwSWZUQzJGSTdxeEhqUEcra1lhNC9G?=
 =?utf-8?B?K3F1aFlOcDUxaUkxT2tBckN3c3h0Y2d2UlliSXpVaE00bXBVMzdGRFdOSEcw?=
 =?utf-8?B?bkpWdXpHUCtRT1ZOeEhLWlRneit0bUZsWDAwdlgyalhuUElSdnArOWlPVEtO?=
 =?utf-8?B?NTRtNnN1UVpySEQ0c0hOclRHK25vOFZGeFZuMDI0R1A3SGVQaGcxK0h6ajJQ?=
 =?utf-8?B?RnhySElQZnBrMmRNbW1IZGpnbzJKU053OGt1KzBEWVBZZGZuK0tTQjJVcUgz?=
 =?utf-8?B?NzZGSTViNlpLcllYMUFxYTlOYkFBNjZUcTdiM2Y3L3M5c2hKT01vc0p2Z1lH?=
 =?utf-8?B?VWZvNm9UaTdGbU5tMUsxNng4NEh5NUgyL3Jsb0VZTnJTZEg3UlRNcC9NTmZ4?=
 =?utf-8?B?ZXV3QnZqallOTTk4ZzYxR1M3SVlRT2pQaTV1NlNmMm05LzFLL2VzS2luRWxC?=
 =?utf-8?B?aitHaWwzN1Z4dlUrdGFFbXc3TWNseVdENE1WTyszZFc0NW14N0dqaEpvUlVO?=
 =?utf-8?B?T1lRdmRjV1VHc05zT1k0dWZSUWcxSVkrenQzTWlzaXlEa1pqaUlTMkllcnNx?=
 =?utf-8?B?ZlM4S1phTnlVeURZcDEva0U1ZUJPSmk0QlBZbGFDRDhMSElZNVRNVUw1NSt4?=
 =?utf-8?B?VEhTaklydFMwaEtwVWdUTC9mMW9ZU3cwN3h0OS9JMnhGb3ArU25iOGR3Z2dG?=
 =?utf-8?B?aTROZk5WcklMWS8wNitUWEpIbFZuZTZ5eE5scFdXUHQzdkUybTE3aEoyN0Jo?=
 =?utf-8?B?T282MW9LSjM2YkszaHh4S3VKRkxBYlNDZHNqS0ZGbHRlV2wzbmc4ZUVUSEJY?=
 =?utf-8?B?UWtVa0Zxb2R6RTlselI0bHVnczZuak84RlFLT3VSdnFsZ0ZqYXNkdVVOdDJZ?=
 =?utf-8?B?MmRRZjRNbWRvb29ONjd0TkpqTmtmZ0Z1UUsrSFVWaXJYb29Mdm11Y0ZxbzI5?=
 =?utf-8?B?NlY0b3JOR04rOXBoS1RKMmRjSlVqTWNPQ0hMaCsrUFZTY3pJQk9lY2kvNzFl?=
 =?utf-8?Q?vdDY0FYw7Ha8q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUF3WUJDOExEU0Zkc2M0S1FreTdOVFlKTno3MXorWjU1dXYvaUdzNHkzUjl0?=
 =?utf-8?B?K2NUMHJsNFhXY2ZPUElUekVCOTMzb2tWWGtNYUE0MStnek9GMlp3SERIdERu?=
 =?utf-8?B?TWJVd0NGNWFKeHpwYnl5SFFZcjRQNCt6amtHY3laMmdoWkRwY2xFSUVPQUpR?=
 =?utf-8?B?M2RGUjlqdmpwR0pibTFxRHFReXNoaWY1WllTa2lmbWpiODRqdCtXeTBqZWJC?=
 =?utf-8?B?NGNEc2paRkUyOXFrTlVMR1Z1SXlGMHhCT1JVL1BKVkJ6S3RJK3FvWDhzdi8w?=
 =?utf-8?B?Y3dUbVNBWVYxWFd2REhMWHZpc21aQk8zcnhwQ2FOODJaYzlXbFVjZ0w4RElm?=
 =?utf-8?B?VkMrSkxoV0I1VW02elBFeDZYOXJBdFFBcUNpZnRjQnNqcWt6cmJhT2lCQ2Vl?=
 =?utf-8?B?VVVYbVNaVjl6MXE0MkpWelFmRlA4bmpKUCtybnhxcnBvd1pVaGFPVGtqa3Qy?=
 =?utf-8?B?Q00yM0ppTlBSbWlkTmV0TFpXWm1yT3o4S3JKNjNHQTZGTEpsRjhNM0IrOEtH?=
 =?utf-8?B?VVFzSVcvTDkwZEhPdUM5cEhzQVFQa1lPY2ZrQTRrNTdNdWdwaVR5a0pONDEy?=
 =?utf-8?B?VlhXRmZwa2hweGhwMmw4VU1GSTlWZlJRQ3h2dEY5YWhkSVRBQ0JwUThJRTRx?=
 =?utf-8?B?VXRIZzdRRHJxaXNLLzFQVEN3aDJQTElqdkFwSVc3SjQxRTlQa3o3K2VlQ1BW?=
 =?utf-8?B?TmxsSS9nM2pPN3Z2bzJQQ1E5cUkyN3BMeFc3bzFzN0VCK0ZrMm5rMlRnU2hK?=
 =?utf-8?B?bFlxMjkvQVpDVU1DTlBMUWpjRndTSHFNL0xnK1oyQ3ZaMXVmNlpoVG9scXVN?=
 =?utf-8?B?Mm5EVlNQT1Zuc1VOVURBbWRWU3E4Z0V2RnNZYk13THNUZTE0YTRPRnNBejRU?=
 =?utf-8?B?NEdhUFFiS1RkNXpnTTAzbHZlYjFKWUxMREpuS1dSTS9DekxMWStLRENxckl0?=
 =?utf-8?B?ek8wSDBoc0R1WXFVb1VYSi9xRWVZNmd2V1ViNkhzWC9JYnpjbmw0WWtWQ3Jt?=
 =?utf-8?B?RVI5WkdkNzFXVDJHRnF4TFd5ZVVFVUVibTMwYmVuaTZZeTFwZnBMcHU5Rk1p?=
 =?utf-8?B?SEJPQ1FTK1hhY3h3NFRtM0QyZHpqR3Rud3JINkZoeDZVNUszYjlnL2Zpa1FE?=
 =?utf-8?B?NStNY2dMWklLeGZrdm52T0pUaThEWXlDUlZzUlpaZVBxbGZwdEZWamFyMUU4?=
 =?utf-8?B?dUtON3UvVFBTMHVOZE5uYlZTcGhGR3J6ZjFzaytlSnlXMHkrbUdiWmNrOW5K?=
 =?utf-8?B?NXExZ0RQMjJ0Z1BLUkV3OUd6T2FXMWdEa09jMnFVaGtXMzFyL3lMYklRSm1R?=
 =?utf-8?B?VnpGNzFtbEhtbms2MDRXT1NVLzBRclRjL254K1UyZVVtVjBwc1BmUk5lbnM0?=
 =?utf-8?B?M1pKcTNFNzI0bFd0VEw1SUI3OHB6VlVwcHM3VWtFc3JmU1Z4NmV2b0FUZ3A5?=
 =?utf-8?B?YVFpV3VDQnJObkh2WmZUYUdDL1ROZGtMVzk0YU1iWWF4YzhKZnkyNzR3ZXgw?=
 =?utf-8?B?N0M5dmhNY1ZVM0NneDE0K2dlaXlhSUlFNDJ5SFRKemx0c2RmakZnNU5FS3lr?=
 =?utf-8?B?ZDJwL1pPSkprZkdCY2R0NlVBcmJweE13MWwrTGNyQ2haaGFMWUpyUktaWkY0?=
 =?utf-8?B?a2g5QkoyejFXdldVbjVpNGdFdWdQMHFlNWgwTDBOdktBSmpjUDVMWlo0RnB1?=
 =?utf-8?B?ditZdmUvY2wvRExjUm1vbmVUUVc5UkdhdmZXT1lMQWdMTFZXUHd5ell2ZjMr?=
 =?utf-8?B?eU15ZWU5TmdEam9mcXQyZEZGYVE0MnJ6d3A3dFVMZVgwMVFzbVhWb1RJM0tD?=
 =?utf-8?B?VkltQnZPaHhFSW9mLyswMW1NRmdRREs4WVZjNng2aXNka3g3b1RSY2VqWFl5?=
 =?utf-8?B?STlnRS9xZ3hRdjRaZXZLUHU5NjdvTUtpQU5RN2NLdDk3aXFyak1qRnpnT01M?=
 =?utf-8?B?a1FJREFoTGR6S2ZaL01KdGhDTFdPLzV6eXVMbkxlS3VtQzJ3ckhVTS9CeDZB?=
 =?utf-8?B?NmNscGxYNnNRbjhkNEJkNGdiVUlmWlFqUkVXVmJlODlNaTU2RFBKNWRlR09J?=
 =?utf-8?B?c1lEUklRZzM3Tk55ZDFIREV2KzJpMkFlWWtjS3Q1ellVbGV0UElHalFSNDdu?=
 =?utf-8?B?KzdYazdha1FNMXhWZE5LVGVuaG5pYUdsNUVXZWhySy9NbDIvVlp3SFo0eEU4?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	44lQ15QrK007nGhP3tNSvkhXh4U1uKl6/4GH4+dfD4YFnduiF4XB2Ciq/qw//AJUDg5GMRwfjgNAv54yy7636tcElsmMliq+4z+jL9o+cKCoFgYdALrLiG1iz7qToADxpCyVKC4TtN6+x8IKZFmU3LNMRLmr59UHet/JGL5PeVHvFj124QN+fJBu0icDSFV/OzVo/o3PvKaVCv/slhV9zR40U+6cgRJshHto2WUeRr2TYoVR0ALQRUYdz9sLXUj2YiQwf98LozpjbTGl/4UGRChVNsgwqevDB3Y2J8mCst3p9fO9hGpODxtHN2UKyRVOUY/BturmRrzjJJo2FKpX3HuJ6e0WOHOWnDcgU/ZZqEub4IPHTeHQSRK9ZGhR/7fXNNilFIZ4i5HGfDenojPZObVbMxZabHlgiVQhW1dGKTdR9V4l7A8RpmMpjBYvT+DKPnB5ElInjdKDLFnhApLm/4CXYCOz50P4IAGPS7C0KY7DAtjinMMAIt0nxroBJAPVheApDyL6QUfRj2rLEOWegF3+OoXd1QLiQ9EFH2WLnlep1Snlgf4tm+jD5na6vncYn2LXbFJ9Z1O4JVW0tKgQhXoIebEiaq80lYwDY0lmXWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b1f50b-7dbd-4b3c-1b19-08dd57e4243d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:39:12.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA3lvGA+5b8KCzkCzd6odA9UksJwZqaX6MSIadtQ10C/3Ni2icWZ31rleBCbdHWYDWBdSsLKK9FPwhNDAclG+uUraziik21YABCbwqDEB8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280076
X-Proofpoint-ORIG-GUID: Mgj0ulSZ5oP-r6oanBuMlClnQuzGBMwE
X-Proofpoint-GUID: Mgj0ulSZ5oP-r6oanBuMlClnQuzGBMwE

On Thu, Feb 27, 2025 at 03:38:47PM -0800, Jeff Xu wrote:
> On Wed, Feb 26, 2025 at 10:25 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 07:20:50PM +0100, Oleg Nesterov wrote:
> > > On 02/26, Lorenzo Stoakes wrote:
> > > >
> > > > Like I said, Jeff opposes the change. I disagree with him, and agree with you,
> > > > because this is very silly.
> > > >
> > > > But I don't want to hold up this series with that discussion (this is for his
> > > > sake...)
> > >
> > > Neither me, so lets go with VM_SEALED_SYSMAP.
> > >
> > > My only objection is that
> > >
> > >       vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
> > >       vm_flags |= VM_SEALED_SYSMAP;
> > >
> > > looks unnecessarily confusing to me,
> > >
> > >       vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMAP;
> > >
> > > or just
> > >
> > >       vma = _install_special_mapping(...,
> > >                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMAP,
> > >                               ...
> > >
> > > looks more readable. But this is cosmetic/subjective, so I won't argue/insist.
> >
> > Agreed. This would be good.
> >
> > >
> > > > Jeff - perhaps drop this and let's return to it in a follow up so this series
> > > > isn't held up?
> > >
> > > Up to you and Jeff.
> > >
> > > But this patch looks "natural" to me in this series.
> >
> > OK, I mean in that case I'm ok with it as-is, as you confirms there's no
> > issue, I've looked at the code and there's no issue.
> >
> > It was only if we wanted to try the VM_SEALED thing, i.e. _always_ seal
> > then it'd do better outside of the series as there'd be a discussion about
> > maybe changing this CONFIG_64BIT thing yada yada.
> >
> > >
> > > Oleg.
> > >
> >
> > Jeff - in that case, do NOT drop this one :P but do please look at the
> > above style nit.
> >
> Ok.

Thanks :)

>
>
> > Let's keep things moving... :)
