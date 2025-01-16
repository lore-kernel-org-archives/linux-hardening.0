Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486C145A03;
	Thu, 16 Jan 2025 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047824; cv=fail; b=DVMhl/E0xnA5FU03JgkkRdlD9qHa2Vxazxvp4N+YSVWZuMKWqNXk10lo82o/TU3UlzNqs4s/aOyZOot+sTPZW1WHuZCqPQcwaxVOk5LbG2xduG7YTFN/TIZtH4m2PHa8q136Q8eLppmr30pFM9hqBRRFqRWjzBgQA/uGL0YDuF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047824; c=relaxed/simple;
	bh=VyIV83C1B8CPkZKdJk5DGhmHlnVqFMij4Q1qitdHcis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jJq7oLXRqnniGa+Lb1pqHTM5oTSEZ5Ds50sXEjLozkcdcG+A67ePMIWgmr9EZWt7vYQKYA4cc3yiFLZ4pal5rsgi+DcFROx0kEUM4T5DAwpQqW2rBdqYQCVbgt8zctY4mtYQgiWwppGUMob5eVBllAd+Vo2aMfI0eWuVcDbPpc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PSb0IP5W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x7ZxoCjy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PSb0IP5W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x7ZxoCjy"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GH0ist005198;
	Thu, 16 Jan 2025 17:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Akln4iEOgTcBwfPmUIg+BHkiG0uX9AyJCEnYQgaAIXI=; b=
	PSb0IP5WkwmcaaB0IJ37R7pwClrYTuzkhwIk6OtcRrwQNpn6IDDth8hUUCIIMlVL
	mnnM4pGoQskil0OjF6hRpyLPd3xKZ02jutQFwFPlH8vRSqlSuIPIVFucickdQa+U
	MXQ22v8KU+99kWg3QbKNWPkRbcyvc5zFEiV0IEmFsJSgeV65f/RYirU/RfXkZ369
	ms3VoYrLtIvRG6wbg0jHjhIUuiyqwK5ffoOMQgxp0yxBwxYNCWEwf+c7D6NdInz4
	aLDt7KgpPVyVF73O1jQ5l8tNP1gKGBr+WSTlvPJKayMOws7DjN0PPZLnQAYmZKuJ
	Qc+RF4eu07iX1fPriWt6HA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7yaqmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 17:16:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GH4IJC035036;
	Thu, 16 Jan 2025 17:16:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3b2mey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 17:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OB/mxZpJIQJO6N2qWP+e+RJTr6dRkO39bj2TfWD00LUiT8zxMU6nQ2otQXGizyeUS6bP92q2kJBK8z/lZJlKjZiAIsMHeDLE8qLBFwygKn+q+GngblwfJPPBNbQq7bDFVAzKpPqKhCxhqEVPXyWxcWwjLZux5RUcVhC7kKC7P+WBn8/IGEJmQlYreKz9Tct3tT1D6eE853p+uVby9Sy0bjcjQiXSowkjQCPN3Xg+tUdxkcCcxlIB721bBI+O+FnZw18oE+U1VqVKdAJtYilJxPFOk1vc6izbnYG9AX/Id6mgg0JtSp6SDx+QsJqeVudqBMahIrIoeXBCNeTqLCwnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Akln4iEOgTcBwfPmUIg+BHkiG0uX9AyJCEnYQgaAIXI=;
 b=A+01RXbgQJiNPGVxdH6dyIPhrud6fqhdJW+PrEM1uMFWs163pxQXpnaReEzLVgDn06iR/CqWWtVKYQiujffVcRl/q3jERWlP0BRxgeJlPen4zAMnEMuETQ1PRGS5VQX59mQmG2rdm+AZ/kYF1cvmJdcBLGtNZ1OPr+RHUGyT92tRn+kmS/ahNnQFSgiHYi3dTaribsuvXkOJPR6fdzLcMc9u1kpsWnoSuWoPJrF4xpfsPnoDObap2hcBQqo990vNiDf0aLLu/urAN+P+wbp45jmBL8wchR93sVqvLN1b7JSGj6wWybtRUxRvvZosVd0VgnhIJtjHD1q9jpyRm1SrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Akln4iEOgTcBwfPmUIg+BHkiG0uX9AyJCEnYQgaAIXI=;
 b=x7ZxoCjyjWY5T7a3CJVKypTvY7cyX35WQwMQ/SZkC4yieVGdSXjD4m156IuRBxDooduaIFdv6LuzRXHYW4NsXK2pd+GyS2RlBaQpXgJwW/xEiHY8PTcUrepuQ28441r9e3u8JS9FGkQ6E4KhgtW7/2ESWUNvDhrFnMYAP+R7prY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 17:16:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 17:16:15 +0000
Date: Thu, 16 Jan 2025 17:16:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>,
        akpm@linux-foundation.org, jannh@google.com,
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
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <37b57df4-4687-4ed3-88b1-578bf5471751@lucifer.local>
References: <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
 <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
X-ClientProxiedBy: LO4P123CA0678.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 183c9f35-3580-4025-43b5-08dd36517b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm9lYW12QXdsSE93TDk2SDZqYm1KLzZ0ZEhmblorN3FsOGNxMUI1SUs4TC8z?=
 =?utf-8?B?M00vK2UzbXlqdFZadzIwT0JmRDBxemkyTDJSR2JGVVJ5OG84Mkpxa3JMZitp?=
 =?utf-8?B?ZlFwZWU4WmJmQmVzditDMVYvMXI2RnhXNHc1ZWFJSjlEVkNBbFRuaENLdkFx?=
 =?utf-8?B?K01LenFuZll5bW1FbU5VZEU3Z0VEd0lSWjVZeEswMkhneFFnK2tKZURraW5z?=
 =?utf-8?B?SlZwWlFONnVKNGd0MnVIdGN6V3pCYklFUVE3dXNsNXNQZWxBb3A5UFRwUUxR?=
 =?utf-8?B?dm5UVEVOSDlaMHhLZXB4Mm9FNmthbnQwQ24zUWFqaFFJM3dJaTF4K2RFaGZH?=
 =?utf-8?B?T2hkTGRvWERDaW5kak9VeU9vcHlMa2JrbVJQZXJPWGl3WHVkazk4S0xmbVhM?=
 =?utf-8?B?WkowYmNsdXZKMjNObkZoVml1V0p6QUlZYVR0U2dLSXYrOHphSXpQQzJPVU9D?=
 =?utf-8?B?Q1FyRDU5ZHlJZ1o2N2tTZnljVHZJWUxoRk9oUHBEU29zTW9rMFM1WEFENEdF?=
 =?utf-8?B?SW1ab0tCUUh5ZnQyUHJiRDNDQXc0L0pSejJLUE5ZVkxKSEM5OXY0NDFmQ3dD?=
 =?utf-8?B?NDNGQ1ArQ1NWc3JUSlE1ME5hb3Faa1hQand3bVIxaVlvU3hNZE5GNFAvdVpo?=
 =?utf-8?B?bVBBZHlFOXg2Rzg5bVcrTE9GekFlQ1V3KzFFSFdmQi9HRERuQlZVTGFJZmNo?=
 =?utf-8?B?akRscE12NDlOaWZ6VmE0ZVF2eEJFUFN2QXpqWXZKcUJTeGlNWVVuVmpuUmY2?=
 =?utf-8?B?aGN1VjBJWmIwY0loUWlnaGh5VklnRWhQSlFnc05LVW5DbmJQSG1KN3Z4WGVl?=
 =?utf-8?B?L3NucjRyS0pic3Z3QUdZbm1CU011YzJhRW1CcFZvOWJkeVlsWmJDUWVzcVVr?=
 =?utf-8?B?a1FvKy9pMG03VC9WRExYTDVCY2hpOUI1aVJFR2wvanRzZDBMTzFtaWdOQXRB?=
 =?utf-8?B?ZTl6QUtRcDZTaCtrc0thc2tNWTFpZW9HaGxucWpqdTdDUW93T3NmYy83RmFX?=
 =?utf-8?B?UmM0Unl4ZDNzSDMrNjAxZDM2NEJaTTg1bFdPbXRzWmJqTGJVTEFvZ1lqRXFW?=
 =?utf-8?B?U1V1aWNaZWppNVBNaHJJL0lkQ212YU82SldJaVIyK3Q1eG4rSytUNWEreER1?=
 =?utf-8?B?bDJqRUlVSFI0RUxQWEZSSmVxS1o0VDhIRHhoK3puWGY3MVpmNzdjZFgxd2dm?=
 =?utf-8?B?R04zYW5rcEdHaWZtR2gyajZrV2lkQ1czT3dTdGtCeGVMcTFCeDJpeGEwem1x?=
 =?utf-8?B?cVg1eUcrVUxaL20rRGRSbkZ6RnJEZ3Q2T3liOFVlS1ZOazhPUEhPNDZuMHhk?=
 =?utf-8?B?VnZmdzBrMkQwbSt0RVhSVU1zalVaTVBmeU5lR2QxZy9ONTJmNUs5L3NyV1RW?=
 =?utf-8?B?b3pMM0FhTytlOTRjN01JTFNuRUdmTkdSZ3o1VGFPbC9sK2h2OUptYWJSSXJP?=
 =?utf-8?B?dk9aS3VtNm9TYWlUcDlZSDBaeW45WXpGOVNYZE9HVWd6aGVONmVSTDlyYWh6?=
 =?utf-8?B?OUxJVnVOWnNaNXc1UnpzVDgxQWo3MjhOK0w3eUZUcDJFR2RTNEg0cXR3R0JC?=
 =?utf-8?B?VTl1UUFaSFA2d0hPdlN0d2ZVTWZtSVAxdEwxVXdYNUw4elRRL25VZldjd1Ra?=
 =?utf-8?B?YlpQc21aZlBIQmdhSXVZWFFBZjUrYUg1QXYrcG1nd0lRSktaZTNZRGEySGdl?=
 =?utf-8?B?YU4yQ1dEYkxvNnJIRlU4YnBhVnl5N3lJdjNHTTlJb3NJYlZ5VzRmMElRZFJW?=
 =?utf-8?B?azRMM3ViNnR0eUFXUFhLZEdJR0Z5R2xkM0kwSG05eDBBdElpZy9Ja01vaVNG?=
 =?utf-8?B?ckl4UjB6ZUQ2K1hQTVNnbm52TzdkNWt2QkNDUmQxRTg5d2wybGk4bXJVTlAw?=
 =?utf-8?Q?5vTXbV3KmVPjz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGw2UVpPSXVheG5NQVRFc1hsY2lvR0lqeTNBS0NJVHo1dDNuNkp3RTFLWGs3?=
 =?utf-8?B?eHN4RGhhUm1RZXRnMG5MQ1NyQlIrNFJPaFcrd0VpMnMwWTZRcEFDYVdoWUVE?=
 =?utf-8?B?N1hFclRkTlEzOEkya2hiQmpjeGtYQjlMdUFONTB6NUlnSDBFalp3TGk5L1RS?=
 =?utf-8?B?cnk0RGNnZDc4U1FsendhbDF2ajBkYnRFQmJwcGR1VUI1eXRMbkRpQ29xd1Y1?=
 =?utf-8?B?T1ZuZmEvZ2phTDZaaXpiNmtYZnFhQ1JZZFFHY1hmMGZiaGpNOUNOTDFEcVNs?=
 =?utf-8?B?RlZzUFZYcU16amp2Z0V6d2libVcrNW1PMlZrSzRBNXVHS2FHdjdSeWZ1UGdy?=
 =?utf-8?B?MjdZNnYrTU9DUVREa3M4OU5XSEFEQUltcnczT3puK0FFQjBJdkVvWU0vSGRZ?=
 =?utf-8?B?b0RVVWtDVXRXY1A2K0FOM1M2bE0vdG1CMmZjNlNlVVRMWkFUYVNlS1Nld3Vz?=
 =?utf-8?B?UWZNdWpOb1E0QjU5eTdZRXg5djN0ZHFpK0lkaXAwR1ZoaWdJY1V1aVNROHdZ?=
 =?utf-8?B?K3h3SzJ5aXNZeDcvaTYyQmdhOEdqelo2M1pnVGVZU1JZTzQzNDhyWDBveHhM?=
 =?utf-8?B?Y3NSakVVUVgvemZYTXo3RCtPcUhON3RDT2lEc3RLRUFhVkJlSVlieElIZm11?=
 =?utf-8?B?ZXJFM2p1MWJjQXJnZC9CSk9lTVF6ditzTXpLZEQwWnVtS1RITHhNQmcvWUhK?=
 =?utf-8?B?RVdhVXZRaGxwcU1RR1d4dHFCUHlOcVVOM3MrWWRZVzIyZCtMUVIyZC9LVnVq?=
 =?utf-8?B?Q2VseXlKUFI5MDBTdkZuUlBXc3ZRakgrTmtzQ3B2TmZISVBnQTNDOWZJUzdt?=
 =?utf-8?B?MVhTV29mNHZmQWFENkFES05WaE95MWRJWkphNjR0alZCekIvcU5XVzFtQnl3?=
 =?utf-8?B?Z1R3dXJ6TXhESXpTU0VTTERicWhEaVBiNndOWVBFd0RxL1NOQjBjakhYdmpS?=
 =?utf-8?B?LzNNUUtMWWs1cVZITlhFL3Z3WmVPS3I0ZnBaU24zTUR6Y0ZZNmVVMFpUdjRx?=
 =?utf-8?B?b2FPU3pIQzFvTXEzZjRRQkpRVEZpM0JaNXhuWnJHYU55dGlHZ1l6ckw5eUtr?=
 =?utf-8?B?ZjFQVXN4bDRwamQvdU9yWjBQbjNDajNvSGFGTzBVQ1pQb3UrV2JZd0JyUmhp?=
 =?utf-8?B?ZUNnL1J4WStKclBWclFpZitBOXNzOWNOLzNqOHdlbTF3cnlsZzZCRWlwU2ll?=
 =?utf-8?B?UXI4bVY5NzlRbmd4NHpIZmFiRlhXb1RTM1RFWUVPSUp0YVdKL3Q5VG5FL2U5?=
 =?utf-8?B?ODVPMFpvSmFpUlF5Wm12VUVSRUp0bkdzMmwyOElhRWRCVC9EelBBOG9ieW5J?=
 =?utf-8?B?bVpxWElyQkR6TEFrU2dPVHJpQ0wrMGFvaG5SdEs0emNHREMyOE1IeGNzQ0w4?=
 =?utf-8?B?TGdaNndkUitseXJZOUFTdFAyZTRvVXpacjNUUGY5dC9nVXFoSU5kR2RTUUc5?=
 =?utf-8?B?ZnRZNzhnTTFPWDYwNXJUMnhXZjVNRzdjMWxxaExCRGZZbUhNU1VsOTFKQVdL?=
 =?utf-8?B?N3hWSjdTQ1RPMnE3U01CN1JtTVRrMkl4NzNyc1lwdE5hSjBBNUZLRmR2Vkg1?=
 =?utf-8?B?RnZndU1ablp5N3NLNVVveWhvZ1h6akZKYWNWY3BKeG00RjBsL2Y1dy93NWR2?=
 =?utf-8?B?MXBDNVBvRS81aVBudGIvdnNjd0x6QXVncTBrK29zY09LMmxTOXBKZlVTSldv?=
 =?utf-8?B?cnQwM2QwTGo2b3hGcm91TVIyOHROQ0xYaFY0VndaSzN2eVVnR1ZyTzJQNm1n?=
 =?utf-8?B?b1llRThjYXY0NHV4cS9HbFFod29hSFpUb3NjaStLVnh3MHFUWXlTWDVrK3V3?=
 =?utf-8?B?R0V0UVRBbExhREIrRGFWekhOc3k0S1pFWnRROGhqcGJaUGw3dWdLTENORnRz?=
 =?utf-8?B?aTgySTd6YjJvOU5wWWxpT0NsWHpGakJaWGxiVnNad0QycnhlU1VJRWlnUGJh?=
 =?utf-8?B?ZTRGZ3FRc0loYTN0MksvaGRSeEVCbWR5b1lZeXhRRnJHU0ZVbTVSWDhXWFZ1?=
 =?utf-8?B?V2d6bjZLQmhCbitIazIwK0doVXNtMkZEZ3BhNXJhRUhsTmZzbVBCUEQ5alhy?=
 =?utf-8?B?Z2tJZkdLd1JtZkVYQTRtMytnVVc0TE15dnpIRE9sV3NwMlcraGd6Q2l1SmZx?=
 =?utf-8?B?MklyNEc1UWFFS0xLc3d3VW1VaVlSTHQvbGNFYm1udXlvVE9qdXNsdXlpK3Zl?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uJnFoKlAhUvbkAxyrOHNAK/lHJmRhV5jqXHtmN6dD2GFkm8shQRb9+nndmKwRqU9sp68CixNmn8eZnhmGok0EjE+BmxTcils7CgCDfcDp4ZyYTO7m9/iis8/8t4p8y47otw30SmsS585QwaN7FwHiw8uRLDFPTefAYzeGhHJ9jYxlMNFX9n0/aPV2KIqwZOggMweUEVw5K9yXy8DGzJIbZ3RBOj0Bppjep2FRatb87+uYzw9LcArNmehrLI3BJzcrP6RGLUcVfRUs0dLDuDX67JkBGZCB7jz6Cmx3jat0BRRYH2svwGyQLQjkCIO0SkVEn3Azd9eNstXPj69vnE6fqfLBOhwng2OTkbqwo+8Ht6U6b1IYJms6VKPgFh922fZbqKO4XbdWfBvj+eW5Al5e8aoKX8sQOWPNr9yvonh0E7az1aLdXAIv4FDqWPCcOngkKlFCC7ecagxDSAT6C28DyoYxi/nz9K0OV/Yw780rw2h4yvgn1umiaJHYpoQguQnu+/JJn8X6FFwUC10TXcJSq8tSUJ/4fCiLUHmJFsq+Rb+taNc6y36ZuBxWEZ/xw1NZAaq+ir5mV1q5HDga8CW9d+x/JtvVxNHQX8DfhLhko0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183c9f35-3580-4025-43b5-08dd36517b7b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 17:16:15.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9sOvXcVRVujqoIk9D8a8mvX9CzU5Vk8ocsGd65hkYdCpKVctMMLrIVex1oJKxcShkG5XOGKjzdjOB2r5ujdeub1QTqAvcCmDlUcz0IVW9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_07,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160129
X-Proofpoint-ORIG-GUID: dEFPwDWOubWlOPk0P_XkwOsUT6egLum9
X-Proofpoint-GUID: dEFPwDWOubWlOPk0P_XkwOsUT6egLum9

On Thu, Jan 16, 2025 at 06:01:47PM +0100, Benjamin Berg wrote:
> Hi Lorenzo,
>
> On Thu, 2025-01-16 at 15:48 +0000, Lorenzo Stoakes wrote:
> > On Wed, Jan 15, 2025 at 12:20:59PM -0800, Jeff Xu wrote:
> > > On Wed, Jan 15, 2025 at 11:46 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> >
> > [SNIP]
> > >
> > > > I've made it abundantly clear that this (NACKed) series cannot allow the
> > > > kernel to be in a broken state even if a user sets flags to do so.
> > > >
> > > > This is because users might lack context to make this decision and
> > > > incorrectly do so, and now we ship a known-broken kernel.
> > > >
> > > > You are now suggesting disabling the !CRIU requirement. Which violates my
> > > > _requirements_ (not optional features).
> > > >
> > > Sure, I can add CRIU back.
> > >
> > > Are you fine with UML and gViso not working under this CONFIG ?
> > > UML/gViso doesn't use any KCONFIG like CRIU does.
> >
> > Yeah this is a concern, wouldn't we be able to catch UML with a flag?
> >
> > Apologies my fault for maybe not being totally up to date with this, but what
> > exactly was the gViso (is it gVisor actually?)
>
> UML is a separate architecture. It is a Linux kernel running as a
> userspace application on top of an unmodified host kernel.
>
> So really, UML is a mostly weird userspace program for the purpose of
> this discussion. And a pretty buggy one too--it got broken by rseq
> already.
>
> What UML now does is:
>  * Execute a tiny static binary
>  * map special "stub" code/data pages at the topmost userspace address
>    (replacing its stack)
>  * continue execution inside the "stub" pages
>  * unmap everything below the "stub" pages
>  * use the unmap'ed area for userspace application mappings
>
> I believe that the "unmap everything" step will fail with this feature.
>

Ahhh interesting.

>
> Now, I am sure one can come up with solutions, e.g.:
>    1. Simply print an explanation if the unmap() fails
>    2. Find an address that is guaranteed to be below the VDSO and use a
>       smaller address space for the UML userspace.
>    3. Somehow tell the host kernel to not install the VDSO mappings
>    4. Add the host VDSO pages as a sealed VMA within UML to guard them
>

Right.

> UML is a bit of a niche and I am not sure it is worth worrying about it
> too much.
>
> Benjamin

Well in that case then it's number_of_things_to_worry_about--; here :)

Cheers Benjamin!

[snip]
