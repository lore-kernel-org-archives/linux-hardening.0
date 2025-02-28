Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98740256C8A;
	Fri, 28 Feb 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735381; cv=fail; b=ewaV/KkwAHNcSOCixVw90RSAEzDtyUNNThBbPHRs/cun6ZyHNNhtE/14PyC04n92dJxdWu6Fe+A49jWuWNEbo4la7/PYv7ltRuFtV3XjzNj6iZ4QTYEbkyU5tv4BKq3D1yJjvR9di/3JJIO0xfpqhJZn0F67+g9vQNGUyNWFXuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735381; c=relaxed/simple;
	bh=QbZpt3QpC7/3O7nMc2b4XuHj9aZ2yNCjUVVLOynjc1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F2VXSZyeXw9UW6wpXBRc3v0AsSM7hSb67OgRHITH5dVa7C/dBe5S6/b83G7TRzYFTe2aziBobzgP8lcToejhO7Kan/V5Myw8oWaU2YtbRXODrm4wBrqG8iI9pwyPo7KDMIw/Ickk7PvZ6RjLmT+en3BEQitVzFxtXukz14eyFL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QzCcslVl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AIWcS0Aa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QzCcslVl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AIWcS0Aa"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S9Be0N027517;
	Fri, 28 Feb 2025 09:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ruydLUBuUs+bQ1QDoJW07OEhUiT/g4Vc31oc84FW52U=; b=
	QzCcslVlFMeRrbMXmju/abP+hdK7BzYp9oxUWXv/SbeuGuxb5pQcfdf7VnZzsGPF
	WMWPKpYtkhxe49ipwyWRaiQV3oCrEKolc+2RSWDjexy1moLPZtHxtw6LC5ZVyTv5
	Ep8/7rhqr9kIzkcgvEk9Rh4hyK+IwRAW8OmMQs8z6Iwp9k1+cQd8htKD/Qb2S+L/
	z5Dr6kpF5lmaeUFLmH6q4J9inREsAgvQ2NZgEhtRnAanOGWu+iWxmOmA0t51Ouns
	IqnsUOb0rWAXFnZtIh4hcri1OQgjqCIzNkDwxJH7v3kcbCD++czkH18Sz6LqtlCW
	p6y89civSPT2Q3krMVltTg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse563k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 09:35:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S91M04025293;
	Fri, 28 Feb 2025 09:35:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51m0npg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 09:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEg+oknx7hsStCB/kj1fIIH2IaBgpGFxRdbfj15FavkK6tyzK+xtFgk2CZJeL4wtB5BXuz88kVXiILFqWA9GW8ZQ7O614Az00UoFwpa8fsmhkF5Z0X0hUlEW2fATPuHPTBN8SSxUSfoAdghjjXtRomEl1D/Pw9yqcX6294LyTfYIA5PTD/USJMP6TfRQcIhTP8jQ4yUig8hmiD3oy5u8NLc1Rw5jVwvbpF6L+zUAhXsj11HAZWPUGsff9cCiAu9nC0LuPBoGtFF9kPPaL3aexs6Qj4eoOUsjvpup8lt0rgGPN74PLocvqhdwIA4NeFmcS2I73kCfOuPx8FLUFt5M/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruydLUBuUs+bQ1QDoJW07OEhUiT/g4Vc31oc84FW52U=;
 b=Urk99QJDsQclo1/3gT746nu04HZj1ra1DSKwVZf7FTRD/I470WkEXsu/gHLPAar5YSDD/IFGNtoDvxdwv/rOrg2GsZUI2hzhM2C45np9IobzVXHKxVbHpzyklounbKqvjJyMERNzbAQ24HeIe50Rzv3sepRR9TDEOA+h2BPYtsKuZzk08lrX0t7yrtPir43Y+SOl0FxtCTM8gGEnBSmLPn88Hw0hj9bejiXVqWYkQU8K4igo+qSTL3FVQpfcaoGW8vaomvvfUXYqGlSa24hpf0eMUt5sltD/6ytCtnIvWW142+lN5BfdJvurF2XxiSQY6N4F1f+C4eMncTl4VDMSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruydLUBuUs+bQ1QDoJW07OEhUiT/g4Vc31oc84FW52U=;
 b=AIWcS0AawUTkEH9Tw57uo7JTxD0zjb6I3/BGaZsPlTcMLqV2SIfChSqfK0bgPlk2vionr0Qtt0tq6FIORCcPl1E81DiY4/d09rTXO3ors3dlQFvfXWfei51JfnJvIqoz2mDBJoVC47jufDgCKtT64OhoHte2zy0a+wYMvj0+Doc=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH8PR10MB6573.namprd10.prod.outlook.com (2603:10b6:510:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Fri, 28 Feb
 2025 09:35:18 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 09:35:18 +0000
Date: Fri, 28 Feb 2025 09:35:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        linux-mm@kvack.org, Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Stephen =?utf-8?Q?R=C3=B6ttger?= <sroettger@google.com>,
        "hch@lst.de" <hch@lst.de>, "ojeda@kernel.org" <ojeda@kernel.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>, Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Peter Xu <peterx@redhat.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "gerg@kernel.org" <gerg@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ardb@google.com" <ardb@google.com>, Elliott Hughes <enh@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: your mail
Message-ID: <60f5b979-2969-4cb0-ad3d-262908869c5f@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <e697ee1d-6075-4f24-8365-32aa4bc84d7e@lucifer.local>
 <CABi2SkXcgB1Zjztqc1W4M-5j9z_wMCRaEtK-wLL3x9_qC1aGHQ@mail.gmail.com>
 <f65bd1bf-4e81-454a-afaa-f84c13cc6227@lucifer.local>
 <CABi2SkV2_-LYGjROm3cs8nHrzBiw7pjpe0i7QGNPsPKHSeajog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkV2_-LYGjROm3cs8nHrzBiw7pjpe0i7QGNPsPKHSeajog@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0306.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::23) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH8PR10MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab13c75-a43f-430f-882d-08dd57db3675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzB5WjBNVWdJc2ZublV0TWhmcUxKb2x1QXd6Ym1kK2w4Z1k5RkY1NWRjRDNH?=
 =?utf-8?B?SVV6TWg1NlZaWmlNQUlXYjZ6N2FhbVYzSVNxTFpqcmxxVzJ1WVVlbzV3ZVlR?=
 =?utf-8?B?blVYUlI0aHlDNDRvS1cvdWltRDFwclk4N1FCTHJzZWhkQTFBTFBnYVdaY28z?=
 =?utf-8?B?Q21SRHBROFpHU0NyRXRxT3NxRG5aSzlUVUxXOElCRmFsSWxxUTk0Q2NHQ285?=
 =?utf-8?B?YmN1dGNld25DaTFtaDNxaXhqZDJyZmZqaVNoWTBxQXdQcGNBOWlucnU2dWJY?=
 =?utf-8?B?WHZmbVY0ZVZlSnlwS3pXUkhWOTdWUHFPdVcxUHFaRjg0c0dPcll3c3F1WnFh?=
 =?utf-8?B?b25lR3g0ZGpYUUxDQkhML09NUXduSUZ3dlFyWGRWNVRoUHRnWW15d1ZpQjA5?=
 =?utf-8?B?d2tpZXo3WXlsWjFjalJQSGV5ckpMY1NQYk53MVV1K0pkM1ljZXFieFl0YnEy?=
 =?utf-8?B?WFBwRHdRY3FPVHI5VElRK09NLzExNXBZd0RWTDRYWjJUQXhpbTV5L0JSblVB?=
 =?utf-8?B?R0ZKbW1WRHZGcEFvOEEvdWFlM3N1VlRKUUlpV2hTbzhhenY5aHVVdGlpNExl?=
 =?utf-8?B?MVFiK0lTRDFLbitzaE1KNVRvd3dkTS94M0VhV3czb0lkRC82T0hLVDVETm8y?=
 =?utf-8?B?R0o4RDcyZkM0dTRLSmtMU0RKNlZNRTQ2REtBYTliTjFUNnV3UVFnUys3dFVa?=
 =?utf-8?B?YkM4aTJ6NWtJa2hXL3NBRVduRmdzK3JPUFg0a3VJWVZHMzZSQUs1Q3FjRnha?=
 =?utf-8?B?bVJqWThkZk9KaXRtdHlwOVk1ZXhHWGE1c2FkQXhncCtvUmVGa3BlSzdsNUQ5?=
 =?utf-8?B?VTUzbHRucWxUUnBoSHlmWmQ4SHhTQm9YSnBGaHc5cmRzaStsWkNLOFAzOXJ5?=
 =?utf-8?B?TEcxWEF0MDZEcEJSU2pQVkFVOUpSM1pPNWJsNUJ4SGw2bmVNa1dybmMxKytt?=
 =?utf-8?B?eEtYeGNubG43R05JcDJEcW1zL2ltaW54S3ZGSFRwZlhBbmNQRTRQaUNQSmsv?=
 =?utf-8?B?TDVZVVc1bW45VSs4bkg5aG42SWNjaSsvbmNpOWIrRXFKTVpHRWJCZ25XTkYr?=
 =?utf-8?B?angvcVFJRkZNR09yOEFobHR5cVY1S0w0RnVDbWp1eTNGWmhmZDI4SEErdE8z?=
 =?utf-8?B?cWtrRUFmYUptRGdGL0ZSSld0RnBPTkN3YSt0dHI5azBmNjJ5dUJqSnFJeEM0?=
 =?utf-8?B?UzFQRzZaYVROZFk4ZDNkTWVUdEJLN0pWclhDM3IrakRkbUJkc1U3L2lHZnRo?=
 =?utf-8?B?ZXdXTng0QXNnSldpczlMTTZwWnhjU3FyaEIvRHpub2FEMWFOSStmNVoyeUhK?=
 =?utf-8?B?bGFjSEpUaFNaNzZyMnRDbU93ZEtKcndVQ1ZqNklPekdPa2dBb3krdWR3NUJv?=
 =?utf-8?B?NG1hZlJjRmRldDJWQnlkTkRMTm5ZdGZ6YTBHc2RIcHVOSU5uQUF1OSswSGZE?=
 =?utf-8?B?VEdPN05tN21OeDBNbHVaYmZGTUpMV0llWldRbCtSbVc1dHd0cmhCaVMwOXF4?=
 =?utf-8?B?WHhMQUprdTU4K2tqZzJnWVh0UnZRNVBLTVlYUUZ4YjNUNDJzMTNjckIxYXpr?=
 =?utf-8?B?ZXhzQVYya0grTVljUVBCUmN2Um9Mdkw0TVNCdHJ4RjlkaWVackhkOUc1MVAx?=
 =?utf-8?B?c3lOTTZyWTZPSTlBcElGbFdYMHR6UmVnZFZhQkFMS2RJbXp4a0NVRC9CMTNm?=
 =?utf-8?B?Rk1jTG1IRy81bHdxcERrRDF2K3FSckdIRU9Dak9kSjRTZlZ2MFgrTnByTGtD?=
 =?utf-8?B?b3ZFdFoyY1M5dTVOK2VHODQ4dW9JdkpBNDNsTlFsRGdvWVh3dXlkK0lZQWpm?=
 =?utf-8?B?YllJQXVyd0MzclI2RU8rcW56S3ZBSjRNbDhWUkNIVzU0UmYwM2VQRlR4RFlE?=
 =?utf-8?Q?nWMtIe/FjvmT+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEU5cjBBTmRqMVJuNGc3aWpKS1JhVmRLOGtuWDRlb1QvQW80SllFT3BzME1U?=
 =?utf-8?B?QzVhOGI4eTlQRDl4RS9tUm51K3F0aDlWSUdsT2RHbWJJSXVCY0lDVjE3d2ZY?=
 =?utf-8?B?dmtvRDJ4cSszbFVucEVSQ2F1SzVYcVZmK0YvOWJ1bzFta2xZdzhDNXNSTm15?=
 =?utf-8?B?ZE5xait5SWF3NnVaSGdQdXJURUtic2VKblFEWjlKMW5VTkNYK2M5a1FHYmlN?=
 =?utf-8?B?VUFtbWFxQlo1Mk1vRHkrRXVqWmxTY3dUNjRRNFlnYVl4NEpmU042QlkzclBK?=
 =?utf-8?B?V3gxYUdBcHRmUmc3ZGh4a3B4dGFVeE9RTTRySWd0SzA4dkoxbzdKVUVMRWRY?=
 =?utf-8?B?UVc4MktHem9oMnN0SGpUcmwxZUp0eVRYR0VCL3dNUzNiTFcvMW9PTUNDUWh5?=
 =?utf-8?B?cnNUL2ZpMHRpeWt0NnAwWElqTll1QzZqMG4wR2x6SnZ6dnVXVHFKMjFKRzFB?=
 =?utf-8?B?QzR1YWx1Q3oxbFJOZk13eFd4dmE5ZXdoM29NTEdNS1NzT1kvNWZEdjYrYkN1?=
 =?utf-8?B?ZS9CSE1JTWNOb3ZwZ0ZhVUFYMUN1UWRDMXBJU1VMQUh1dmNtbDhTVy9LZ3Bq?=
 =?utf-8?B?ZkoybE9oSXBnZ1VvZVBISmVzODNtR0Y4ejlLaVdSUWovUzM4d0lBUjltSExX?=
 =?utf-8?B?NTgyOEpxdDVQV2N3L1ZjUDhFZFNBYkRwTUVrRzRLQW9kL0ZRWWd0bG1lc2pC?=
 =?utf-8?B?VExncHpBZURtQnVPNjJ0T0FMdjBvc1BJalhmYmR1aFhudStJb0VzdTY5b21D?=
 =?utf-8?B?M0VETGtYZHY4emZySnJaYmJubzZZSFlmZTQwL3dwS1cySlAvL1pGbDdUczFz?=
 =?utf-8?B?NS81V1dMY1pCeWVTL09XNVZuZU44elRIU2dqVnZpTTI0SlY1U1JvSXFYRUZx?=
 =?utf-8?B?ZUlJMWFlOTlyV0gxZFZ6MjhhL3pXNmczcVl3TG1aR2hlak4wakFYL2RUMTFs?=
 =?utf-8?B?Z1RZZjZ5VGI2YXZmNlZlQzZBRmNSMHVBWFhJTTB6UmZVcjdCdXgvSjVaamd5?=
 =?utf-8?B?MmlQejhZc2tBZmZIN1o3NWtkejF6d093dHlheTZLVk1HTEJETHRHcVpTeEJH?=
 =?utf-8?B?N1I2Y0tYaFZENVJhcmZhT3JoU2ZRU3RaNE93eTlMR0Y3dmZSNHpPbDNGTHNU?=
 =?utf-8?B?UE5zL2RNSGR1K2EwdjZmQVp0MDVTdzBmNGxNWTdQNDZ5NVEyTzZkN1cvdllj?=
 =?utf-8?B?Y092ZmowRVpuZXcrMVBRSVFKbFlIcVVwZUJmWFZpUU5GaGxvSUwwQnZGVFdU?=
 =?utf-8?B?S2ZuYlVqSm5pSXI0Z0VBcHA3bzluN2JWeDZzaVVVTjNHeGl4Y0VTVm9BVE1H?=
 =?utf-8?B?clRwSm5GbEs4T2V2VElKd21NSy9ROThLNkdTSTZSMWtsUkNnMHgwRHRKUk90?=
 =?utf-8?B?WnBFY3cyRWFaa2Q0eTZoNUc0SnZiZllLVm1neG1PS21OQnlYRUlHc0MvMXEw?=
 =?utf-8?B?bkRZT0o0MXF5RUVONzlMU21NZ2EzcHY3RXBrU3BlRWc3cko5bXdGL1UyRWtm?=
 =?utf-8?B?aDh3eHZOMlBxQTl0QWJTY1o1c0ZvYTE1RnZoVXFla3d4NG9qU2hBNmFtaGpp?=
 =?utf-8?B?bVpiV1Q0Q2d5Z0xSSGtnczRYa0dabmxJVzlBOGxRSHJlbENNWllDb0w4UlNI?=
 =?utf-8?B?d3dwcE5IaVRRaVBpREUwV0FBUkFzZFJyRjdUN3E2U1F3cEhrTzBkVzViU01o?=
 =?utf-8?B?eEY0c0xpcTFYV05GcWhFbG9NTW8ySEowQmhoR0tzcGcvQmZZaDJBcGN5UTRm?=
 =?utf-8?B?NVY2UXZzTHRQTmc1d0xQWjEwTEhrcWlVSnFhQzZhaE8zbEIrblhNY2NaR2I4?=
 =?utf-8?B?TUxLUUtwSVh3bng1OUZSOXNyeC9JKzBvaHZIUGxLQWc0a1ZadHRaV3JwRzAv?=
 =?utf-8?B?RlRJRFFxSUNpd2lPZmJyVE5SYytoeXdIM0ViZmNRUnp3RzRrY3VxUE9oYVlG?=
 =?utf-8?B?YW5xWFlycWlUTVpDTitFY3I3QTA4eXJIR2tlaHFrK2dLQk1vWjJrUDNLcHNL?=
 =?utf-8?B?d0VOZHRIUWpSSVZ3TXF4eEtoRzdOZnhnNFBFZjNyWlNzU29NeW5vMWF3SWE0?=
 =?utf-8?B?YStsR0hac1ZrMFFGS2x2TTBNR2FLL2JMeEhQOTBINDQ5YVF4WEd6L29lbnpD?=
 =?utf-8?B?ME9Ockt6RUxRcDF3V2lBS3pudEVuMTZhQjFaRVlKUk14YnNiWnpIejl2MURL?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HiiaYKg0fRQ+Jjz63TAiBvTD4OqA0t+Aw+hujSNB9RuGzwwf+C+C5zUYiE91Z6qAZa6gBbk2ZhEANshc9Ml6ZJL3l7+IBtrz3b6YXmtUMfqnY4fjt4fZB1qX87I/MkLkGh03gIIW403J3PDfxnT26ck1WiHyicLxr32Y45y0yZsFcc6jKkrfMNZ2lqYRRo4SEzAW8LtH/kHWXd3UhU432JJMprnIyDuwdyiKWMBXyJSIt3xCCrNgJoult8XM8KoJnjJl4oJ15reIsZNkgYCRE+mITYAkrciGz/1cr0TYBYH42IH6XYmb4nsMdSPo5C0g0wHpdW650PuxS6geDuAKNPgfGhUzEc/DDhNHQh8gw5TZOqKRE3oD7y2unhwFdLaff/BAMSLZgqzRTlDADFJxBcrRkKeEuOfmPmDJ0/CAQulaFePUuZJDmhlgjAeZmznJDrzpJPC8VtiwwCCoIWhn+0E2kRBljchW1AHF7z2SGI86NRmxeiNGXhoaSN2/6I8jKjiQ+9HMHZkGV7m2xzEP0wlN4VJ/NR6XQPxRt2fFK+06lSE7h65C8KzHbAXo5s1XFvqJKaIAKg/JZcQBynPZ8M1ye5jj5CtHiqQ67SYeUFc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab13c75-a43f-430f-882d-08dd57db3675
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:35:18.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WS9gHyE8er8M4NDRbltXdnGdBWPubvMroEZwNPneSy9mgYXj7rKTrmCzbew6rjVyyQ48AOffU2ulzXj2D52mlzo+5yTQ7Mh+ULraPjPwF4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280068
X-Proofpoint-GUID: fzSh9Obavh70QMkzNd8n4-G6U0m5nRhX
X-Proofpoint-ORIG-GUID: fzSh9Obavh70QMkzNd8n4-G6U0m5nRhX

On Thu, Feb 27, 2025 at 04:55:06PM -0800, Jeff Xu wrote:
> Hi Lorenzo,
>
> On Tue, Feb 25, 2025, 9:43 PM Lorenzo Stoakes
> >
> > > > 2. Tests - could you please add some tests to assert that mremap() fails
> > > >    for VDSO for instance? You've edited an existing test for VDSO in x86 to
> > > >    skip the test should this be enabled, but this is not the same as a self
> > > >    test. And obviously doesn't cover arm64.
> > > >
> > > >    This should be relatively strightforward right? You already have code
> > > >    for finding out whether VDSO is msealed, so just use that to see if you
> > > >    skip, then attempt mremap(), mmap() over etc. + assert it fails.
> > > >
> > > >    Ideally these tests would cover all the cases you've changed.
> > > >
> > > It is not as easy.
> > >
> > > The config is disabled by default. And I don't know a way to detect
> > > KCONFIG  from selftest itself. Without this, I can't reasonably
> > > determine the test result.
> >
> > Please in future let's try to get this kind of response at the point of the
> > request being made :) makes life much easier.
> >
> There might be miscommunication ?
> This version is the first time you ask about adding a self test.

Yeah I thought I'd been clear but this might _very well_ have been me not
having been, so apologies if so.

I mean 'make sure it's tested' is an overloaded term right? So fact you've
tested on android, chromeos, etc. implies 'tested', but also self
tests/kunit/whatever.

>
> IIRC, you had comments about providing the details of what tests I did, in V4.
> As a follow-up, I added a test-info section in the cover letter of V5

Thanks. Appreciate that! And this really does point towards a
miscommunication on my part, will try to be super explicit in future.

>
> Though I have thought about adding a selftest since the beginning,
> there are two problems:
> 1> This config is by default disabled,
> 2> No good pattern to check KCONFIG from selftest.

Yeah agreed, it's a TOTAL pain.

I wish we had a better way of doing this. Maybe a self-volunteering
exercise (*goes to write on writeboard :P*)

>
> >
> > So I think it is easy actually. As I say here (perhaps you missed it?) you
> > literally already have code you added to the x86 test to prevent test
> > failure.
> >
> > So you essentially look for [vdso] or whatever, then you look up to see if
> > it is sealed, ensure an mremap() fails.
> >
> This suggestion doesn't test the core change of this series, which is
> to enable mseal for vdso.

Right, and thinking about it, what does this test? Just that mseal works
right?

It's sort of implicit that, if a VMA is sealed, the seal should work (or
rather, tested in mseal tests themselves, rather than mseal system
settings).

>
> When the vdso is marked with "sl", mremap() will fail, that's part of
> the mseal() business logic and belongs in mseal_test. The mseal_test
> already covers the mseal, and this series doesn't change mseal.
>
> As for the "sl", as I responded in the "refactor mseal_test" [1] , it
> will be part of the verifying step:
>
> [1] https://lore.kernel.org/all/CABi2SkUv_1gsuGh86AON-xRLAggCvDqJMHxT17mGy-XutSTAwg@mail.gmail.com/

OK cool thanks. I will look at this when I can, I'm just snowed under
pre-LSF and have been sick so backlog, backlog as discussed off-list. But
it's not been forgotten (whiteboard etc. etc.)

>
> > Of course this doesn't check to see if it _should_ be enabled or not. I'm
> > being nice by not _insisting_ we export a way for you to determine whether
> > this config option is enabled or not for the sake of a test (since I don't
> > want to hold up this series).
> >
> > But that'd be nice! Maybe in a
> > /sys/kernel/security endpoint...
> >
> >
> > ...but I think we can potentially add this later on so we don't hold things
> > up here/add yet more to the series. I suspect you and Kees alike would
> > prioritise getting _this series_ in at this point :)
> >
> > You could, if you wanted to, check to see if /proc/config.gz exists and
> > zgrep it (only there if CONFIG_IKCONFIG_PROC is set) and assert based on
> > that, but you know kinda hacky.
>
> Ya, it is hacky. None of the existing selftest uses this pattern, and
> I'm not sure /proc/config.gz is enabled in the default kernel config.

Yeah and I'm not sure I even like my hacky suggestion here, I mean let's be
honest, it sucks.

>
> One option is to have ChromeOS or Android to maintain an out-of-tree
> test, since the configuration will be enabled there.

Nah haha, though of course you can do what you want. Really want something
upstream.

>
> Option two is to create a new path:
> tools/testing/selftests/sealsysmap. Then, add
> CONFIG_SEAL_SYSTEM_MAPPING=y to the config file and add a selftest to
> this path. This seems to be the preferred way by selftest, but we need
> a new dir for that.

OK I like option 2 let's do this.

But let's call it mseal_system_mappings (yes I"m being nitty again :) I
really want to try to _explicitly_ say 'mseal' because we have other forms
of sealing.

Not your fault, but we overload terms like _crazy_ in mm and need to be
cautious as not to confuse vs. e.g. memfd seals.


>
> Option three is to add a self-test when we have a process-level opt-in
> solution. This would allow the test to deterministically know whether
> the vdso should be sealed or not.

Yeah one for future.

>
> >
> > But anyway, FWIW I think it'd be useful to assert that mremap() or munmap()
> > fails here for system mappings for the sake of it. I guess this is, in
> > effect, only checking mseal-ing works right? But it at least asserts the
> > existence of the thing, and that it behaves.
> >
> > Later on, when you add some way of observing that it's enabled or not, you
> > can extend the test to check this.
>
> I think it is best that we don't add a test that doesn't actually
> check the code change. Do you think one of the above three options
> works ? maybe the second option (with a new path) ?

Yeah I actually agree on reflection. And yes agreed option 2 is great,
thanks!

>
> In any case, I think the risk is low, and the code changes are quite
> simple, and fully tested.

Yeah indeed, but I'd really like _something_ if possible. If option 2 is
relatively quick let's get that sorted out!

>
> Thanks.
> -Jeff.

Cheers, Lorenzo
