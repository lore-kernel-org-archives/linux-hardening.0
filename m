Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776352580F9;
	Fri, 28 Feb 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738767; cv=fail; b=rUQvnAP0wzb2OhOn+d5I1N2Z6qRaKWux4z/EBNANC1klV+rPTfoY6KzUC/zGPoSlYfiucvXa7WPqv0Sv5c2ulWclxsxu5NpppLmVlvGBy8ecI07MHojT23WORmEMpdAMpZ+SZynV8TUHbBIUfbC1BOk/XgHnXPjfDbICAzPHhyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738767; c=relaxed/simple;
	bh=mjwd9Bw2syQuYupcs70L/PnXfMyMq5Fpe7KYLd2pIrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A7Eh+qclsCOvfEcRAuFVsv45HGsWo0N0Th81khb7pbYrxF3p9vowhoiIdmYzHuCAfSOH7rLpjSIXM8sQIl7UyoLY13Bw84Z+DADdhlNpdchfNScAYdAS/+PZr4Ti+1gsv4J2icnHqgeBVP4iWVOy+d63fgIAEUkJN/ZJ0IlkckQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lJNr51no; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JAA4o3gt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lJNr51no";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JAA4o3gt"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S9BqLd024917;
	Fri, 28 Feb 2025 10:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Q4Pp37HiX/U+QeRJCigkxevjexcrySv8uqYTqwb4DBY=; b=
	lJNr51noQaa8p2yZ2bY3mrmsTxLwK6dCpUFeFZLNmGGLhIOKs7YCESdm8eeifwRw
	oOzZMHIKvv9b9lYb5d0AXJMLNsrgGccl6RehK90Kfv2sPderb7nkEBhYSlUDDplW
	iGyPyRiHJm6OroILFySK9hWK7zebEdQW+aJtuDg6cQ1b7NGorOUYTCPs2EgVH69z
	HmrwCla/bGT3aBX6rbeRypxN8KprQJIP8qq1IuEDu4tgugQhM+WkbxfN0azBCHuo
	WmY8e2NpPHzGeUuTCf80k8AK+rNu7zQTUxSj2kwJpS9X56Uxm6B4rQm26Mbn+hMo
	8T+JS0Glu81ksQEu41RXTQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf5ay7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 10:31:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S8JtiZ010114;
	Fri, 28 Feb 2025 10:31:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51d5d3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 10:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCIrDlFo+gLhFNe7YTb/2vLDXl4vlQA9qpKit/nDVMU7G+DOl77q4DytU2jts/02mQU29+53BWeiAl53CFHZiEhEPrBjca3NuzgykGoy9xH97A20GUA4bZuBEQGbxIGXthWRs/W37WrqkKmdfuU8IgJenut8XOTcoxz1v0feeE0lWn+TdmQByIrKCgEPNKwjlNOnZs33NliHSNeDJih6YAvo/cmDTQSAEpeee7UuWAarPy7Czs9fVn8JOnVlL+4DnbKcaAxmxQjxZjUgIaCLd/z9sg4hMb6pnhgmeE0qequHmLYBBfGfjcwOxEOWekmoDi6yjDMlgkXhshQI1QOuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4Pp37HiX/U+QeRJCigkxevjexcrySv8uqYTqwb4DBY=;
 b=fN4AZhk0aSoFF25alLq8Het65d4xK1EpSoXhviihFgtLJXFQJ5spPlzMvGZHsGO0ReJztn/0WUCBqslxPLdo9aI5fRK1+G6ABPbV+vhaRgo6iQke+4w6OalYBlye9frdch2Avy5YL5z+jRTmi9n+sMdbk5AQy8TN8rgtxVAcrKoe3TMhlNHvTIgZCi0CVorPye5wXndB1Jtswn7mgEZjZQZX6ravvn0Mc9fEmEKQKtyfpwBS5Usb8c6owXV3BfhAkVED2xBgLdclYexnkE1qd1BC5Z1TM0ItBNIEqSWPFJquVQ4icRDy6vBTbZuTbE9ST6FRAToKM+I6oIWzCCGe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4Pp37HiX/U+QeRJCigkxevjexcrySv8uqYTqwb4DBY=;
 b=JAA4o3gtGWVOcejYwFPmwoZZ7ErTxite9MejO1jnTnvp/cPVHfaW5M7Cww7O71vIsp4EzU0YG55MfCxuXfj4a8aMJrHO+1b/Zgq9mgzq7qpQreiUSpoMF+JFXkGrXkg8n/pzehrIguz1nNAfDgJtlR+K1moZp8ZmwoAq8PNGVqY=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB7524.namprd10.prod.outlook.com (2603:10b6:8:15c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 10:31:43 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 10:31:43 +0000
Date: Fri, 28 Feb 2025 10:31:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
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
Message-ID: <7d436f5d-083d-4d7f-ac98-39d7ec0ae73b@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-5-jeffxu@google.com>
 <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local>
 <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
 <ea970928-ccea-4314-9cde-b64fa1a7824e@lucifer.local>
 <qk4m74uscjxdnlchcxolvgbw7ijppzqk57ajyc4m6jjixq5gti@lokjqegpftzh>
 <CABi2SkUprOT=TEDQb62SByjyW+csarKnGypdmxVdktj=+C9_yg@mail.gmail.com>
 <ba04b513-0eb5-425d-b24c-82c9f9b6c7ee@lucifer.local>
 <CABi2SkV6JJwJeviDLsq9N4ONvQ=EFANsiWkgiEOjyT9TQSt+HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkV6JJwJeviDLsq9N4ONvQ=EFANsiWkgiEOjyT9TQSt+HA@mail.gmail.com>
X-ClientProxiedBy: LO4P302CA0026.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::18) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: aa61077b-5585-41d8-cc2c-08dd57e3188b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnZFT3pZV25SK3FkbEFydjdybmcrMjBvT084QjJCS2F5eW5HRTdwR3kxdHA1?=
 =?utf-8?B?Z05CekhjNUo2NnZDOFBDcmhCcmx1NXBWRjJBd0FVOEVvT0hwMktHcDh6MlVj?=
 =?utf-8?B?VEw0azAzamFodTlReE43cWVrMlNpNGZHZUcrem9JM1ZBZjIvK212L3Jqa2F2?=
 =?utf-8?B?S2tjRThzUHBPQnJBTEl5YTdlYTFNOE9CNjZPV3hxdklYU0c0RDNaNy92UjYv?=
 =?utf-8?B?WEM5bHRzOHdxUG5VNlpTNmpBMFBVMjJNYzNTclhJUzg3cTgveHh4WHhDZnh3?=
 =?utf-8?B?Z2ZZNThiK1JZNCtmQTRCSkoxaVN4aVNnU0hwOVRyMmRJZWl3M21veWg5WGVU?=
 =?utf-8?B?SWRMczlXVXdNdWloMG1RRFBBdWxJL2Rudk9RTTVuclNzV0dqRFFMd2pJWDIr?=
 =?utf-8?B?eExFWjJWNDFEelpDU3IyNWx6NFFsRlVwOXVBTkVZY1hBbWJaMlp6L2xGMHg5?=
 =?utf-8?B?OTY4MUVXWVdPTTB0TUtHU2hyL1MvQmMxeFNkWVplOVlLWXZQQi95UVVTblJy?=
 =?utf-8?B?T1NpQTFWRHV4ZFVRMDhOVVU4SERDdWl1dzBnSzhKV0xVZjRiSUl6VHdEYmxF?=
 =?utf-8?B?UFRNNXhrVVdZK2F3MFltUmNuTXlhY0FNNmFGcWhsZ3ZXMUhxMEZHWTFycWUz?=
 =?utf-8?B?dEd2RzNOWUhJdGJzblhTdXhOVEdoT2ZnUlk4SjkrSjNFUGxJeFZiMUhydEdi?=
 =?utf-8?B?bThZazZ4a2lBRUx3TjF2UncxOFJtVnNXS05qL3pxSVpsQU9QdXZVckxzMVdT?=
 =?utf-8?B?NGVXMWtOU0Z3NDFmdzlZODV6MGNSczNWMExuK0xlNTg0dXpXa3JLV0tCa1ZZ?=
 =?utf-8?B?dlNuZjNVZjZKcFI0MGRYR3grTU16TGpLc2g1cGhMMlphM3YyMllLYnp5VSsy?=
 =?utf-8?B?SzgzbFZhbG1lZWhVd0QzZWphdHV2V09hYy9OelRqSzdSMXFQMjdHUkZISm53?=
 =?utf-8?B?S3hlSW9JamRZL2V6emN3T3d2aHMvc3VjVVlkdnp2Q2F4YUFKSkJXSXBHeWpT?=
 =?utf-8?B?bTdURE0vRm9qa1dOVzkxZEozN056aEVodlBCQUZ1blFiMzFPZEZUeFYwRUlZ?=
 =?utf-8?B?QTYzTEtEVWdmWXhCNUgzaG5WTVM0MEFLaHh1d1lZZUtCV2RUMG91cm5XUVE5?=
 =?utf-8?B?WWxxc2pDOEQ3bzVha1NjTzZ0SUVyR1IvaWdmN0dYYUs5Q1V2VGR1eXNuQnc1?=
 =?utf-8?B?SWRrbHhEek1BTkJiVTlHd0ZGc2hnU0JUUlhicEhaSjRuRVBaTjJZTzJGQlRo?=
 =?utf-8?B?bUJiYVFhdDg5RlBKVGFJWkhnOEo4ZHhQdEV5NTd6RnhFTVkxNTFvbTJqcC9V?=
 =?utf-8?B?emdsMVVpclJWTVRQVmlaQjE1Z3ZEUlkyKzlabHFSa1lpalh2bnYvV0NCdnNH?=
 =?utf-8?B?cCtYcnBoYXB0bVE1bWZwMlVQLzN3emhkMHl6UFVTSDZVMXVzaWQxNzZCanBm?=
 =?utf-8?B?cncxcXhod1QxdjlYMG1VREViMEVKbjBQWFVJa0NEVVdJTzg0UEQ2WWtpc1Rn?=
 =?utf-8?B?akZrL3BqNndHK1diTjRGQjQ5Y25PaCtmajFPOUlwSmxmWHlpV2FxdXcxd290?=
 =?utf-8?B?OC9BYXdicVY4MDhzZW55TWN6NFg2Ulp0dW1tZW1IaUZZdkdIM1hKMmxCQ2Ux?=
 =?utf-8?B?MHJwNGJ6UlI0b0NhdWxQVHZpdnRMVk5WQ1dNbk1FY3A5MTRSa3R4dC91d0tQ?=
 =?utf-8?B?c2YrR0VnRlBENFZ3a0JMVzdUL2NiazVLWHZYZDVTTHJPSXZ6Vm44VDM1amhm?=
 =?utf-8?B?a2tLaUxoOWY3cnlWVU9PczF0L241M0loZGwyTk94bjh6RnFDSjZ5QndjeW1s?=
 =?utf-8?B?Qlk1NGdTSjNZTlY4OFhGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3dVZVdtTTF4QTRMdnhkeU5nN3pOSmZaSzNLOU5OdTZyVFVPdWZ5ejQvMUIw?=
 =?utf-8?B?YXpTc2VZMWlOYWdBZjMvbWZ4aVpCVXNuMUtSdlg4cFdjdTk5dTZORUhmTXhT?=
 =?utf-8?B?MlE2T05XQ01QMUo1dW1FWkFjWXI1bWhMb1Bwc1dDbll3TWRXTllJZDdKdThD?=
 =?utf-8?B?Sm9xTHJFNVM2RW5QNTZyazB4czZYOWFjZUJJMGNSMzJIaHVWc0xreUdic3FK?=
 =?utf-8?B?bGM0ajgvUXRlYUZPN24ya3plSkVGYkk1Y1ExYmtVY2xqM0oySWJydmh1WEtP?=
 =?utf-8?B?Q2FCOXFyd1NGRk9aMXVJZk8wTzFZdU1malYzcUtsWFBlWGY1bm5NVlkvOXBG?=
 =?utf-8?B?Qjd5V0pMZ0FORGlYaFE1Smd1ZDFMaTRsQWtnMDFKZ1JHQzNJNmlkbkVEem5H?=
 =?utf-8?B?M0U4Z0dzYk9JUjVXei90MFVnd0ZOYjZ0d3JXNFRWdDV6TDhRRm9OUVl2T051?=
 =?utf-8?B?WXdVeGxKaHBxc2JaYW5jOURwZDJtUFhFZTBFdkZ2MlJObnA4WW9VUzZtbmwr?=
 =?utf-8?B?OVZIYlhiK3QwZjRPNUlKWDBWMUVKRG1LTk5XeER0WWFjTG1LZEduSlY0d2Jk?=
 =?utf-8?B?L0dKWjZvQmhJU1JJNitIbW1MbmdLUWdnNlhZZ0xONkN5bkxrVFoveVdoRDRa?=
 =?utf-8?B?WjRlRHRkNkhKcW5KZ2tvdnIwbVRLWmZ4VHlDYU02VkUyam8xbUgrNmtVNmpm?=
 =?utf-8?B?NkJVeWhtdXhjTEcwVjNhdndML0Flemk2OFFZOUlLSVVXeTQyZzkvd1VTYk8x?=
 =?utf-8?B?Y3ltVG02TW1RUUg2cGlYR3lhS0ZHbS9VK2JvU3R0V2x3c0NSZk1xM1FnZjM5?=
 =?utf-8?B?d25XTkdxR0VaQzFod3ZiRDlCeEdVNkY0Ynl3NjFkMXVmZnFYbnZ4NDYwTFRO?=
 =?utf-8?B?RTBsWkZpbDF2TDU0YVN5S2hEeVlQekNlQ3N4K3JsOXYvL2ZDbTc3SFptaTQ0?=
 =?utf-8?B?OE01YVVFSHBVaHZBanVrS3NsTlN6dGpoYjFteXR5M0JDMmpMamMxZFFpSUl6?=
 =?utf-8?B?aDhHK29Oc2t6RVdwQm5LUWs1RVVwR3VXcHQyK3dTOHcrQitpc1hwQk8xYVJw?=
 =?utf-8?B?aERBRWhQNnZnWnNUdTJoVFpDTHh2b2FlZi9LR0ozb3FiWkxlZndjaFNyRk9I?=
 =?utf-8?B?WDNmc1l2M0ViRUwvTTNpNTdRYmRyYVg4aWZ4UnI4Y0hLY1VRWEhZanEzVitW?=
 =?utf-8?B?b3dKQ3o1bHVIeXdCQzRJK2hQWWRMdkFhbk1yMzFZZVd3S1pMT0huMURxNlND?=
 =?utf-8?B?NFhsYnhReklkZXIyYXM3ZmhYVEVFSHdPZ0JkVjFiK3BDN1d4OWZZS29qQStx?=
 =?utf-8?B?OTlza2U2d0tkUVJoRnNHMVV3ak9PSXp5dkQwV2xiVlZqWm02cTNpVmJ2dDhl?=
 =?utf-8?B?TGNUaXBaSHVPeVNVR0hTdTRobDk0VWQ3OUQyYjhHajRmd3dmUlZQbVBRa2dT?=
 =?utf-8?B?alJ3UTZhVXFWMU12Skl5cTA3bk42RXA5dkZUc1hwRWJwNlJMOXFyMnd0SXdp?=
 =?utf-8?B?Q1YwdG5qWWVnNkh4eXhqWmZueUYrNDhaNkN1VExCZHZQTGRRRnRralFENEsx?=
 =?utf-8?B?NVBJanpIRFQvVlNoNk1rMXVkVFlzUzZ5ZWpnNHNIZHNRVkMyejd3T2JNV0ZF?=
 =?utf-8?B?K2ZTNzRLZ3l5cm5DYkFaUnk3Q2xQYUF3WkVLcitob3RVeDZ5WWQyVnFZRE5Z?=
 =?utf-8?B?cHFlTVd3cXdtNUw4TEJmNjBKWDdxVE0wUnF4aENvaTNEQ1Q0NVdENG8xMEhs?=
 =?utf-8?B?cVVPYzhoemlUTDVHalg3a2wvZUJST0JjYWJLd0E2cFNnTzdRb2pDZ1hvM3RU?=
 =?utf-8?B?Y0thQWNqWlRibXArN1QyZzcxSzA3bzZIRG9iSkhsdHlHOXpqa01MQ21LaG1m?=
 =?utf-8?B?OUtCVjd2b1hSMVhOMnNVRThWT01neXFid01xQktUbWFoTWV1Y2h0dkdER0hi?=
 =?utf-8?B?WTVjMjRDd21HSCsyV3U3ZXowU0JVNHFUQWVub1NIektkRUNUa1d6OWFYZHd5?=
 =?utf-8?B?S290SGVlN0VraitYRzVBMko0RU1aMHdzMnhNM2N2ZXJUMUhhQXNORWs2YnFC?=
 =?utf-8?B?Kzk2QnRvc21hdU4wdkIwb1RHMzNmYURBYlpwUHlCdmx4TUNXaHRMOStiSmNZ?=
 =?utf-8?B?RkVDSmV0dlNmMzVyMTJJYTNvMG1IYVNDU0tRbkxuZ001RzhDdGh0KzRNbllr?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d4k6tnz/RWWvMCyi7M0ALTSss5oaFYO3Ryq9mP3or6xX3j+CKQVS995ptC82KERRpLqh/rcg0lP1y1JpeCj7O2L9F9iFm7nu3s+O20pK/Xo/XAI8JHmG+h7f+zgctYUCR2GPVgcxO5HoZ+M/S4T5lBHqKq7+zQYjRQrqg1e117WvIRGulNQA0gQw79EIDE3hxm1P0ywcGKdNgJQEjCJ+R2KCeeGM0tW0RMHAvz2WhJbojx1BrmAblXgj5ZCVMBrQWMvHArg5j8iG9qkhSCy8UPM7/dZtlnEz/cYdIb0Vhb6GY6+6gl2N8x9YRX3VAeaUZujyRLDFNjjwcBcTZOlerB5HPvDAojBMEebRqTnB1enckvNR+iIY9PVwWv3hVVy7mX2hr7htwTjDQKrUTEpSvosSwA2pOIni6THaIsPSMWUI5DEzJ8A9+TmJIHM2NQKHnUhQ8NJw/1hHj767vOeTLcKJTrBcy5oSEY+VU8rQXvZcpNq2dLEuyykDCXTDpMMg+C6vuus7EEggKzGK48j8uYb+uIfYyRVvoDbIT0phUQ8MoWmMcvHPO2nmP4UU6zkpTg+AP6xajfreeB/MUcxvN9ziDrL5PF2x4D40l/IfENE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa61077b-5585-41d8-cc2c-08dd57e3188b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:31:43.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sy50oevNRTwONSUYwrxhSA6q0cb2mEMStWWWjSpKP7wkxidVk0dhKpvsYVynmeZawiTXQfLkH7xHh8DDncNBzOpz7skxl6HhktP8o7Sggk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280075
X-Proofpoint-ORIG-GUID: sisGd79iYcsp16u1X3vF1n_hA3-4be_Q
X-Proofpoint-GUID: sisGd79iYcsp16u1X3vF1n_hA3-4be_Q

On Thu, Feb 27, 2025 at 04:48:23PM -0800, Jeff Xu wrote:
> On Wed, Feb 26, 2025 at 9:43 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 09:17:10AM -0800, Jeff Xu wrote:
> > > On Wed, Feb 26, 2025 at 9:12 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > > >
> > > > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250226 00:26]:
> > > > > On Tue, Feb 25, 2025 at 02:26:50PM -0800, Jeff Xu wrote:
> > > > > > On Mon, Feb 24, 2025 at 10:20 PM Lorenzo Stoakes
> > > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org wrote:
> > > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > > >
> > > > > > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> > > > > > > > the vdso, vvar, and compat-mode vectors and sigpage mappings.
> > > > > > > >
> > > > > > > > Production release testing passes on Android and Chrome OS.
> > > > > > >
> > > > > > > This is pretty limited (yes yes I know android is massive etc. but we must
> > > > > > > account for all the weird and wonderful arm64 devices out there in context of
> > > > > > > upstream :)
> > > > > > >
> > > > > > > Have you looking through all arm64-code relating to vdso, vvar, compat-mode
> > > > > > > vectors, sigpage mapping and ensured nothing kernel-side relies upon relocation?
> > > > > > > Some arches actually seem to want to do this. Pretty sure PPC does... so a bit
> > > > > > > nervous of that.
> > > > > > >
> > > > > > Can you please point out where PPC munmap/mremap the vdso ?
> > > > > >
> > > > > > Previously, when you mentioned that, I thought you meant user space in
> > > > > > PPC, I didn't realize that you meant that kernel code in PPC.  I
> > > > > > tried, but didn't find anything, hence asking.
> > > > >
> > > > > Jeff, please stick to replying to review. 'Have you looking through all
> > > > > arm64-code'.
> > > > >
> I checked the kernel code and couldn't find any instances of kernel
> unmap/remap system mapping in any architecture. But I could be wrong,
> so I've also included developers from different architectures since
> V1, and hoping to get some insight.

Thanks, yeah me also. Perhaps you said somewhere but I missed, apologies if
so. Might be worth adding explicitly to commit messages, though I think you
allude to it actually.

>
> > > > > I ended up doing this myself yesterday and found no issues, as with x86-64.
> > > > >
> Thank you for double checking.

No problem, in the went was fairly quick.

>
> > > > > I said I'm _pretty sure_ PPC does this. Liam mentioned something about
> > > > > it. We can discuss it, and I can find specifics if + when you try to add
> > > > > this to PPC.
> > > > >
> > > >
> > > > PPC allows the vma to be munmapped then detects and falls back to the
> > > > slower method, iirc.
> > > >
> > > Is this code in the kernel or userspace?
> > >
> > > If PPC doesn't want to create vdso for all its userspace apps, we
> > > could instead "don't create" vdso during the execve call.
> > >
> > >
> > > > They were against the removal of the fallback; other archs also have
> > > > this infrastructure.  Really, if we fixed the fallback to work for
> > > > all platforms then it would probably also remove the possibility of a
> > > > remap over the VDSO being a problem (if it is today, which still isn't
> > > > clear?).
> > > >
> > > Any past thread/communication about this that I can read ?
> >
> > Jeff, I'm sure you don't intend to, but I find it quite disrespectful that you
> > ignored my feedback here (and elsewhere, regarding you ignoring 4 sets of
> > feedback).
> >
> I'm just interested in the details :),  If we know why PPC needs to
> unmap/remap vdso, then there are additional data points to consider,
> when we develop pre-process level control for this feature. But sure,
> we can postpone this.
>
> > This?
> >
> > https://elixir.bootlin.com/linux/v6.13.4/source/arch/powerpc/kernel/vdso.c#L236
> >
> OK, you meant the failed case ? i.e. when install_special_mappings
> failed ? That is a case that I haven't considered. It looks like error
> handling, and I was expecting the install_special_mappings to never
> fail, maybe I'm wrong here for PPC.
>
> > Was [0] a relevant discussion?
> >
> Sorry, I'm kind of lost.  This link doesn't give a reason why PPC
> needs to be unmap. If it is due to CRIU or  other user space apps,
> that is not an architecture dependency, maybe a distribution
> dependency.

Yeah I actually think the web might be somewhat tangled here, I don't know
but...

>
> Anyway, we can postpone this discussion for PPC, I don't mean to make
> you spend more time responding to me. Please feel free to ignore this
> one.

...agreed, let's postpone this to there, at least hopefully these links provide
some basis for further research! :)

>
> Thanks.
> -Jeff
>
>
> > [0]: https://lore.kernel.org/all/lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyuso6jcy3b2dq@7ju6cea62jgk/
> >
> > >
> > > Thanks
> > > -Jeff
> > >
> > >
> > > > Thanks,
> > > > Liam

Cheers, Lorenzo
