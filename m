Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6B8F45;
	Wed,  9 Oct 2024 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434574; cv=fail; b=Dzj8L552IWwXuT65pvYCsZMwfBcty0A0m3/Un+OfVvbZXUCqLs9fF1L3Klc/LLMQrcarkk0lkT/BV64rDdj8Io8vQwG0HlKVDbtJyO8SOca9FYKrAl1STR0JAvZllBZmk1CJ28g4i/fzNwYI/nZ4SjnNaa1HbFOCmgcYUeTBWbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434574; c=relaxed/simple;
	bh=Ld1yLTB9vKMYQRbdRF4ace4jcxmKRm8zsqsg3DF3img=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r25q4rdJqNdRMmEXEjtR5KtiGvRqlmOcg8+5Xf/YHwbthf5LXk0mT/5xzlrJyXCpwhQ6BQ0yUqqZVCtYotEw7JjW0lnzwOVLSraPpdiFubO8AL134SUHy0yz83AUg6T3A3H23ZjmLfPETNj8zm+7eB/R5ll20MOYhDFMW4LiVmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e++gHSjc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ueFBS0q6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e++gHSjc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ueFBS0q6"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Jtb4F007573;
	Wed, 9 Oct 2024 00:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ux7pkW7cKdBm1lHY4W3TH4iRZshUXD3lEBlYqmMDa+g=; b=
	e++gHSjcVDDDDCioDa/wT3kmtvIx1GZPLt+weVW4ipkifUhyTzWrhssDksakmttG
	KHV1i5iDcWxnF9SWklSa/lmDGXukAkhpdlfPz1kAQt+IFbcnsokeaTzHdykllSWy
	02ofRXTPfrw7IklTjjM9c8xmZ3gkJWLJ1bEC5IbtQ9rLzZsPZZwjk80w+CLC9WRd
	TwHkeuVMWlUTrmwJ3nWdws62SNdryAOTVUHlicDZMklIry3MVAKCwjqf6bFzeUak
	I6tmZIJxWm/JnUrHIg7WDgcQcHFohLZ5GR2xfL6hniBKCOEfmos4014LMXHiD1Gh
	1IgME3GvQsC/0p8kRrREMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303yf30y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 00:42:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498N8WFU038364;
	Wed, 9 Oct 2024 00:42:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw7y60w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 00:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMibGbPvJL8SGc9iC39treJKy0rr5m59esnT8Bq72OCGCd517n3Gtlxbt9yj0GJlHAgqySoAwNHwm3m2MEFqNBSVtisFxGtp+tsEgB6alLm5S5KGSXmqaWNnTcJrXiRzvenpjMvx9lclLKC2kNG2+BrffkAV7qZuHCD/RQsDTcKxd4kU3qqDSRkcPFp/F5lQgiHQn2DvBHPO/hWqoSiAG473GEE7pSI1Tr7AZFPjxSHG5idawj1RSjwYUvtmnDluLJDb85hveeOvkdve3P7I843z+4kyo9WAFEN9gdRdlMiJVbIzeeK79F7ZuhIkxHwNoe5zH5uVpmvl6S/7rqGQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux7pkW7cKdBm1lHY4W3TH4iRZshUXD3lEBlYqmMDa+g=;
 b=eczfEUreSo2efMV1LbnJWWG/E29wzIiq33NaSzF6mcKMDIQ3FGaIGcQUETQz+DNeMHKHvGmQNwQviWCYPnRWSJ4FOKCXxraZfkTe6x6Q2adNm8pHwRMska+I7kZ2YbvdI/OzkyYZ4QduvgDoB9KWEtWcdjhcm17cEf3roa33tToKsGW0fhlM2HPpJ0+JBWW52bn6fx1ccDP/ZYYu3qrxkBysAWbZe5zmLiu+/4aMdD0w9/nJtKr6Fy3iGsifdCi4mmXSw/xW3z85MRy+lVVtiaArdKQDn3jYN5EAZa+6kMm+C1JfQRZD1H7joWSGWKTj4wek6grCYGZnCfd2ptHJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux7pkW7cKdBm1lHY4W3TH4iRZshUXD3lEBlYqmMDa+g=;
 b=ueFBS0q6Ukmg61k2LX165ZGErILcoH6PJ/itwHzhAGljhms0C+mXFTL04gntZwuFiDVBAjovlee7M7bB0Wy7ywEogh0rYvlW8aTfyVPpGtQ6IOeovlj9txInnZmUf3WLisR+VK6zqtreKBcfibSaQx0cJ027S6eH9VbEGeMlOfw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB6980.namprd10.prod.outlook.com (2603:10b6:806:34e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 00:41:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 00:41:57 +0000
Date: Tue, 8 Oct 2024 20:41:52 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, mike.kravetz@oracle.com, Jason@zx2c4.com,
        deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com,
        mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org,
        ardb@google.com, enh@google.com, rientjes@google.com,
        groeck@chromium.org, lorenzo.stoakes@oracle.com,
        Jeff Xu <jeffxu@google.com>
Subject: Re: [RFC PATCH v1 0/1] seal system mappings
Message-ID: <xaklq4r2afsqqbdamowzjyzxztlkctg4kg7xuqnyi5fuc3vanx@hwchttyq2kdq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org, 
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, mike.kravetz@oracle.com, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, peterx@redhat.com, 
	hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, nathan_lynch@mentor.com, 
	dsafonov@virtuozzo.com, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com, Jeff Xu <jeffxu@google.com>
References: <20241004163155.3493183-1-jeffxu@google.com>
 <v32x3rszfq7twguleqpj3xejsh6gtupput4dgfmvv357lxznqs@dy6fzjuhrs3v>
 <CABi2SkVfPjfbAMVEK8KFzS4RsZefCo8LAW9r7BkiSweUxVeJpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkVfPjfbAMVEK8KFzS4RsZefCo8LAW9r7BkiSweUxVeJpQ@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 916cbfc4-2bbf-465b-7e7d-08dce7fb2d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0hPcXVHZFZIb0xSRWs0TEpSZDhQWWhRZTJUcWtkcE5EWm1HMW1NMy84bVFL?=
 =?utf-8?B?T2VyNzBha0FINXIzLzFmOXN1WmJXZ3ZPSFZmYVlnWHFPVFM2UzZ6SVBaNDNV?=
 =?utf-8?B?ZlRrc1VoSkRFWFI1V1pZSS9DQjdjN2JRQzVPbFJGdVdVbkN6NUFZQUhCdnV3?=
 =?utf-8?B?VzdKWENZT0FzTmpQdUkyZ3U0ODZmTCtqWHI3Q2JDWVU2YldWOThtUnBaLzhx?=
 =?utf-8?B?SDBhbDNka1lvR3pWa1A4OUU4OFFnS3VVUFZDa2gvVVYwSW83UEVCTDg0dVdi?=
 =?utf-8?B?UkZQbFk0Q3BpdFJhRzBZTEV6MGhNa3ViWlhJdXdRL1FiQ2hRNFZJNjNibmJ4?=
 =?utf-8?B?d1FOR0YxQWIwWjUrT2E0VmxxYWNVWlRnWC9lSlpDNGtneTRvbTRoejZpNUdL?=
 =?utf-8?B?cUxuYXczemszYS9JWkt0US9BVFpMMkxncUZYUnEyeEUxUDdFTXpodzd3YkFU?=
 =?utf-8?B?Z3k4MGhyTnA4YjlBR2RKdHdERlRBa0k4bUozTk9SUEVLUDhLM3F1b3AyMWRB?=
 =?utf-8?B?N1RrdmtPc3V5Tm1udWlCU1VSbnBsYlFaU2tBczR2ZjVvakVPOHJLc21vWG9Q?=
 =?utf-8?B?emN6NTBDZlJMaWRNMGY2VlRnVmg1WFVmTmNMQ29GNDFKSi9YSVhrZ0lMOWhq?=
 =?utf-8?B?b0ErVkxJV29GSUJmSUQwME1JajNoR1dEbUg5azBmM29DcCtDa1pFUFZvQytP?=
 =?utf-8?B?UWxoaDBDMlZlNzFSNXNGOWxIY05NYnB4TkFjVW8vVUU0VXpaZHphZW1wZ2Ja?=
 =?utf-8?B?M3pEVFRKMGZUUjdOMkhHV09VVjhwR0ZQR3NNT1g3ekNXR3hxQmpTdkxVNjgz?=
 =?utf-8?B?V0J0dFlhYUVZRHhlQ1BYL3I5MmFnQi9WK2VLNi9lNTZVTG43YmhGY0VZejAv?=
 =?utf-8?B?SnZac0syQk1kUTNPbkpKQnVjbXZ1em5sdE9DRDlhdHRvMVk0YUJQdEV3T0JW?=
 =?utf-8?B?QXVQVnJ3Ym5YK1NUMU5RbUVnYkZXUC9mWjNERlRjaTIveVdJa2RNN3pFdlc4?=
 =?utf-8?B?Zm1GZDlLYytRYmd3dWc4dUZVeWlEcUhENWVrbU53VEt5QTRzMnJFK3J4dTBl?=
 =?utf-8?B?TlRnMWZMbzZRTEhZYlJveFNmc0xCRGREbkQ4VURLMkM3aFRrSXMwTXhKVVVl?=
 =?utf-8?B?dGNBL2FOOFc4UkJaUGdJeFZpUy9QU0JHSWhDaWVrWUgwa3JWSldlS1QzTWow?=
 =?utf-8?B?OEs2ZjZzOG5JZXl6aUZSWmp0QUM2YjRQZUJaKzgxd25lamVoLzRqODAyRnQ1?=
 =?utf-8?B?b2F1dkdMM1B5ZWRHUmFVT2p0SGlMMkJSci83Um14SVJBSFh6TlIzUlVpQXFa?=
 =?utf-8?B?TkNqQXRid0k5bEtoa2JMYkFMT3l6UlIrVjNZbUU4MXBnSWdEbDJRRzRKa1dG?=
 =?utf-8?B?V3N1U1duNlYwaUMvNHJ1aDFOK1UvbDVXVjNjWmFxZDFzVzVqcGpyanRFR0s2?=
 =?utf-8?B?VFNSdlp6WVdaQ1F2R1QzUXlaQkpqQkpYSG90UFFTczU2bUZ3bEM4dzBYcTlv?=
 =?utf-8?B?ajI2ZUJMYkloNXpDNW9PUHVBOUh4cG9VdDdHMzFQaStqQnpTY1pPREJBczUy?=
 =?utf-8?B?QSt6WTdOeGpnUmpTazlMdEVpQS9jTXRHdlM4Q1Vib2JmQjZaUm4zdG9ObGZh?=
 =?utf-8?B?ckM4UFhsbldidDNYQU52YzluV1gySE9jUkRrY1RaOXl3MUNxeFIwV00vaDFo?=
 =?utf-8?B?YWZEOFZSalF5MU9jeG9iQk11T0J2QUR1Sk9KVVVoQ2tZcm9tUlZmcytRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzdPVTV4Z0RKVXhtYWJpeVhrZ2haTVVScnVBUXNSZng2bGZnRWVnbHFSa1o1?=
 =?utf-8?B?YVZSU2szSmpVUmhYajNXTjYrZjNxT0k3dnh3SmhYcTE3eW53eTVzSko3THE3?=
 =?utf-8?B?OTFzRkgrdXRuTmF6OVhSbXpyM1l3VkM1enNqNCtDWjJnTlJlYzV1cmdJbmRa?=
 =?utf-8?B?RmFOZHNDYXFZVHZMYm9manhmcWxCbUxDUVdNM2VzUnplcUlLQXg4TGZ6bFVu?=
 =?utf-8?B?WGdjaytEM3JRa2JySzAxb05FRDJQbTc4N1U4V042aC9INFU1a1BUbkw2dlNP?=
 =?utf-8?B?MmwyYjIxblZ2K29mbnk4am5McWdmK2xZUjFjTGk0TjhZbklwblhINVoyVURv?=
 =?utf-8?B?STc1TjAxM2d6TU5XRGRtVlllYWYzR21EUnNxVm5FamNZNVdyNGhJS1V6TmFp?=
 =?utf-8?B?UlpBWTUyTEZkdTkvdmNjTUJSY3BsYjc0dDdjLzJVUXpDbG9JWHl3Z1BvYUdo?=
 =?utf-8?B?L0REMWJlSmFGY0d2Zmw5R1J5ZjUxMXJOREhSZEh2SW9xWVFqNCtYVzdrTi9w?=
 =?utf-8?B?Y2Q5R3hVQklUSFZZcHgzRXZFalRSS1c2citIeEVCVVozUGtJRWZYRzBMVUMw?=
 =?utf-8?B?NFRGWGF6VUJ6RVp5UU9mUk9TYy9JdnlUaDgxQ3FsRmtDU0U1WnYrZGhXL3NL?=
 =?utf-8?B?Q2daVTM4bTVNYzVKUmdaaHVRQ1IyVHlUNGNQTVZLZk9kYnl3SzgxNnBCREFK?=
 =?utf-8?B?cUlQbmkzZjU4NTR6QVVBTjhBRTlHMWg3Yi9tVjJLNmZvS0NtMFQ3QjJVbVZt?=
 =?utf-8?B?TzRnMXVKV1FjcGZXZ2xYNExDMytKbTZmaGxIaklNNm1VdWNJb1RrY09VVEpu?=
 =?utf-8?B?aVY2NEtqTXJJcnp0a1hNMGdqaUNtY01VblBGLzhIOTkxOEJDUW8rbWVHSEV2?=
 =?utf-8?B?VjhKaTlpWkROUmRGZGRuaVFxWUlFMEhkU1VTUGtaTFh6YUgvdEt5SHJQVXJK?=
 =?utf-8?B?N1FDYkMyVHUveGFYVG9GVlA4T1U3bms2YWNVSUFITkpNcDBwQTQ5MEExV3dG?=
 =?utf-8?B?YmtibExhalFTNXcrNmhDZXFMSjc5YWhXS2dIbnlLRGtTTXY0RlIvMkJsMVZY?=
 =?utf-8?B?M3NOcFZIL2trTjloc2d2WkRqOUZaQUk4ekV2WXNVYnlNK2lveXpyZ2NoaTNy?=
 =?utf-8?B?cGJQd1ovRG9VaDVxMWVQTFB1UURtMTBNRlJ5MFlmQWU2OWkxVkRndzRCRlAy?=
 =?utf-8?B?YlJXMm91Rm9TQTZRMEh6NmVwNHI4OHZ2RGtXMVJjZGVXNzczaFI1SjN4Zkhs?=
 =?utf-8?B?bGJNRUFadXBYMTBkb0paQy9MRTZ4T1hBbk1Td2NLVHJLdjMxZmNIbG04bjd2?=
 =?utf-8?B?VXBIRG5hdjlOb1ZLK2FEWCtPc2JJc1BKcTEyd0hiUmJkNUVPVnhCZGM1bHNk?=
 =?utf-8?B?c1BFZ25aTVRvVGM1V3FTelhkNXllNGpONDh6MmprRjRVY0pPUzg4UzRRSFpV?=
 =?utf-8?B?VHREL0NrWkgyejY0N1c4a3I5R3VIckorREk4ZUpvdGZ2RzllbjRndVZVbk9W?=
 =?utf-8?B?TGFtQkRMTDQ2SzN3RjZrS2tqRDR2WitrZk41cVlOTk5Obnd0UXFaUmlrTHlP?=
 =?utf-8?B?UURoMlhoS3I1VmFVRHljb0UycmU3Q1g2RERhOTN0aHRGSnZmN1Nob1ZBemVh?=
 =?utf-8?B?MlQvMnIwVFliczRDclVKWXByL2J3ZGFsd0VaSDNtVEJrYlJTS0RYOTQvVEFU?=
 =?utf-8?B?YWYxd25Kc3ZybUVZN3BOaXhjcDczOHpzblh6Y1h1TnBDZjByZVR2aDk1Y3dH?=
 =?utf-8?B?aDJIWHFtOGlvMWpuTGtyU1NTWit2NTNOay9YV2VkRTVUc1RCSHhjeFRRS09Z?=
 =?utf-8?B?Tnc1ZExScnZMamZyaVNDUWZZYW5DekVtNEJaNDJ0aVFTM1QxZ2hlSUt5TzAv?=
 =?utf-8?B?cHFTQjBlRCtDZkFiZm9uK04raVZDSlV4QTd3ZGhmRVVlbWxWSmZ2VXg2aEpN?=
 =?utf-8?B?T3NIaXhRdnVyZXovbEViTGpHNStEWm1VM1AvdEw2cWJqVzNISEZZN1BCcEFI?=
 =?utf-8?B?U2FKSXNqYnZhd2o3VkllTEJIaWdyMU1DbWZuc3FONllCRFlHMUZtdVYyTDZv?=
 =?utf-8?B?QjRxMWNIalRpOFNLbHRLeDd2Z2ZhMFY4WVpQNHBObDlCR2s3dU41NTN2NHZa?=
 =?utf-8?Q?cC3r51g2/jap22+1rexkQ53X8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zeKffv4OjGHt2166/jJ1UtbaNtlFT+hopzCFM+10Pp8cRWQKnp1yjzvv/RMjA8C5xpx58HsdzZD7I77mPfgxUDX/bXpN0hvGJHrowY8DxXNWwgXrQmry6QVD8xYcSycZYZarPbP6QxcFvlaV/fDO1evipU8W1uj59E3SbPlvDanX4hqsZrf740rCsAQxHThjEcOrkY9q09CC4Umdi1s9kASTkuQyRqcpa+HM5V2BBKsU9caCg5q7N0T3tVPEY3/9ICE9S43vtJDmoFeL82XVGJNkkxrIQqk3f+Ut3mT2xfdurroFkRagfpyHXbomuv8U7sxpk7eypPZlrpn0BaHq3JZAjaD6A8ufX26mA1pJzD7/SFNGzbaFngj7qu9niFz8jgE+3fjR4vIMSm3dGkb7Nf9IZ75Bg5QOLRVyMAle1OI0kok7GdrGdQgDA7U70uC5ElkbodQ/3d0tMhhieRJzffk1BaJStO/qfIRUgtfyhwgmC4kv6JdTo/EUJTrn+X1b82rXVr/loazOR+K4vyyYkq3shSjAU132lyYJHuaLb8PBFndGPKoYUg36UaHfuL0s6MIJfC7WXdJH+LZ/yxAttTcVMTIE+f+GGi0oDKbBuCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916cbfc4-2bbf-465b-7e7d-08dce7fb2d9e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 00:41:57.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQDV6GyQB5Z0SOOx00LXik+z5vAXi/E2Tp4cZoLv2wJS5LDSu/EdjA3zK08239mMhNYC9aWLd1ZO2NtHCjTbww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_24,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090002
X-Proofpoint-ORIG-GUID: _5KhAAzuwYEBuLhbpN866RhPdL8h4_-f
X-Proofpoint-GUID: _5KhAAzuwYEBuLhbpN866RhPdL8h4_-f

* Jeff Xu <jeffxu@chromium.org> [241008 11:01]:
> Hi Liam,
>=20
> On Mon, Oct 7, 2024 at 7:19=E2=80=AFPM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * jeffxu@chromium.org <jeffxu@chromium.org> [241004 12:32]:
> > > From: Jeff Xu <jeffxu@google.com>
> > >
> > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > >
> > > Those mappings are readonly or executable only, sealing can protect
> > > them from ever changing during the life time of the process.
> > >
> > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > generated by the kernel during program initialization. These mappings
> > > are designated as non-writable, and sealing them will prevent them
> > > from ever becoming writeable.
> >
> > But it also means they cannot be unmapped, right?
> >
> > I'm not saying it's a thing people should, but recent conversations
> > with the ppc people seem to indicate that people do 'things' to the vds=
o
> > such as removing it.
> >
> > Won't this change mean they cannot do that, at least if mseal is enable=
d
> > on ppc64?  In which case we would have a different special mapping for
> > powerpc, or any other platform that wants to be able to unmap the vdso
> > (or vvar or whatever else?)
> >
> > In fact, I came across people removing the vdso to catch callers to
> > those functions which they didn't want to allow.  In this case enabling
> > the security of mseal would not allow them to stop applications from
> > vdso calls.  Again, I'm not saying this is a good (or bad) idea but it
> > happening.
> >
> > >
> > > Unlike the aforementioned mappings, the uprobe mapping is not
> > > established during program startup. However, its lifetime is the same
> > > as the process's lifetime [1], thus sealable.
> > >
> > > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > > _install_special_mapping() function. As no other mappings utilize thi=
s
> > > function, it is logical to incorporate sealing logic within
> > > _install_special_mapping(). This approach avoids the necessity of
> > > modifying code across various architecture-specific implementations.
> > >
> > > The vsyscall mapping, which has its own initialization function, is
> > > sealed in the XONLY case, it seems to be the most common and secure
> > > case of using vsyscall.
> > >
> > > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) ma=
y
> > > alter the mapping of vdso, vvar, and sigpage during restore
> > > operations. Consequently, this feature cannot be universally enabled
> > > across all systems. To address this, a kernel configuration option ha=
s
> > > been introduced to enable or disable this functionality. I tested
> > > CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS, which doesn=E2=80=
=99t use
> > > CHECKPOINT_RESTORE, to verify the sealing works.
> >
> > I am hesitant to say that CRIU is the only user of moving the vdso, as
> > the ppc people wanted the ability for the fallback methods to still
> > function when the vdso was unmapped.
> >
> > I am not sure we can change the user expected behaviour based on a
> > configuration option; users may be able to mmap/munmap but may not be
> > able to boot their own kernel, but maybe it's okay?
> >
> The text doesn't say CRIU is the **only** feature that is not
> compatible with this.

Fair enough.

I read it that way since you pointed out breaking criu is the reason for
not enabling this by default, although it's probably the biggest reason
against doing this.

>=20
> The default config is "CONFIG_SEAL_SYSTEM_MAPPINGS_NEVER", and
> distribution needs to opt-in for this feature, such as ChromeOS or
> Android or other safe-by-default systems that doesn't allow to unmap
> or remap vdso in production build.

Okay, but you never stated that they can't be unmapped or remapped in
this change; just that they will never become writeable.  It is worth
adding that detail in the description since it isn't entirely obvious
unless you know the workings of mseal.

>=20
> Thanks
> -Jeff
>=20
>=20
> > >
> > > [1] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4X=
kRkL-NrCZxYAyg@mail.gmail.com/
> > >
> > > Jeff Xu (1):
> > >   exec: seal system mappings
> > >
> > >  .../admin-guide/kernel-parameters.txt         |  9 ++++
> > >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
> > >  fs/exec.c                                     | 53 +++++++++++++++++=
++
> > >  include/linux/fs.h                            |  1 +
> > >  mm/mmap.c                                     |  1 +
> > >  security/Kconfig                              | 26 +++++++++
> > >  6 files changed, 97 insertions(+), 2 deletions(-)
> > >
> > > --
> > > 2.47.0.rc0.187.ge670bccf7e-goog
> > >
