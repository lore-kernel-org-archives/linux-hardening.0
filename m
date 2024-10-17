Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E01DE88C;
	Thu, 17 Oct 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180958; cv=fail; b=UMMpx7DJTZXKhTYJ2XBCvYu4KhGeUf/tqexEDwhykGR4wSCupxBheghmxkqfS3EOvrMg3wdFUBcHdJFnFq49Oa1dxccdUP65CGnsKQOLW5QRJuJtjCTh/UyPlfKe7qI7UkGb/ZCFrrSxiYCZ2pbsL77ar65C+lTIe4W2H9IDMRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180958; c=relaxed/simple;
	bh=LvTAzEmyJXSOtvc64gcjm/0OjIUsbQfgDr4/2lh+Y9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pDbQldUFx8O1A/70VXuDOmz/LF5rCwhq4AkzEQ4RMvTswFl2eChfLCjgcibjKZLFT1+waLHR/wNXFmxlX4LMwyHTsXPvQJpnrbAXdDTx4kVub7Ymr5ZWAudopWJvnevAbv7JwGmayHZ1Mnx8EWuq4Rbajtv0kx2emac+rUXseg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fKad18G/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ekNF3YcB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fKad18G/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ekNF3YcB"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBebJ000357;
	Thu, 17 Oct 2024 16:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rXFsEkWrckTuwm/GrSnr/xia4cUZeL00BDNSfBDyPXA=; b=
	fKad18G/OyGisEGUmLEPXq9FsIuBW19B/7tGXpYN+KcxYB8UmrTuPiCvsUyRT+Fj
	B2viglLHQA7ZmW3NED1AFA6xT3g3eKY1dPGw0kZ+vKRwCf6xQmBG3KHjnm4Q2199
	ENKv+zVV3RdDyFSaovu0Ur4Lc4IGg1/0iy/Za89/qACgEeoSVqD3Xnio9C8uss4r
	b5NniJzD30zNTNKYjgEr6dzis8LGl6Uuc2z6WjxaaCpgMDhVih3GxdP8VFYkN0PN
	9cHrv6WN+tAqD+VU2aPaD8VFZQbCnA0DPIQziExJbjj90bVE6LiMoo3GsAnBKsln
	6xmMAFzfG0430Qc1i2LZ+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09p918-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 16:01:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HF7kUe011010;
	Thu, 17 Oct 2024 16:01:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgsaqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 16:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2uthKByIegqGRoTyQF+zhpMJERsI8a5fXHAzEEZChMXw8KHm9Lx7dgTuDwws6KGPSiZ30FuGT/yannYNIgKJcrCIcjASyTPYincshaqdKdYsx5Agm/G1OmAoV2/ufu1lwZy/BNoGga+vfGw6fgZepddWomTcIr7muyLRlAUOutqD9Bs8NAbnrIQBbWHakjQQ2VT1fSp+Pu0ZLT7seDmtXPgHhMBgvXRn5YN0o2m8D7Pv3ppLn1fzSN3tfZzgnHCW2pybu8sFkBptWAvL4KMkS8Imq0F51iEEUcT8/1IRRy04+c61qHyl79KJoW5qRN3dOZH18c3yA6RTIjt4+UdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXFsEkWrckTuwm/GrSnr/xia4cUZeL00BDNSfBDyPXA=;
 b=NsvzBAgYDy6S1QIIWXl/APlFctlsYFDzu5kjMmB0AUKFl4AySyRZqBpOm94Nnf5LtyNVv6RBS5TuDL9+dyEnf2VTt13GDRoOPu/IZg5xq9Hjsfum/RtufiltkUqUV9sVI50pNSsKN+YL/rfvxhKTmbHleqgFoIW9F2qLramE4/Q8pdflEqSWSwMGeNZEpsw7Yb9dWXd/xF790WmJIhUHcyHRWL+4+W4eemoEz4HZJAYglU6k7utEJnJcZe6XDOwXEd/C74Q7kollJZ/dQuuER1NOE64GrRSAD1w7DSImk/Lm2beU/YcXtFjxTg27lCFqpprBN2DjOaJi4+tJ+iUMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXFsEkWrckTuwm/GrSnr/xia4cUZeL00BDNSfBDyPXA=;
 b=ekNF3YcBqMe9B1bV6qd1/kIakSs2kU8horvJ/rfeGjIp9NU0tR2TJMkw/kPf32WxH9zQ6PiyDxDZVPfDdac0Sp8Q6saqEZzQxf4y+6On2ZePoE/XnOxnQoMJsPWifyVWD+3mQgh11G76ojegGHKXfpGJx12MdcyrNDfOBcfyvJc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB7345.namprd10.prod.outlook.com (2603:10b6:8:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 16:01:39 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:01:36 +0000
Date: Thu, 17 Oct 2024 12:01:32 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
        peterz@infradead.org, ardb@google.com, enh@google.com,
        rientjes@google.com, groeck@chromium.org, lorenzo.stoakes@oracle.com
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
Message-ID: <agkliam473nmhxirk76psryxh5qkrncdhwzyoyf4w4efkxnubw@vkeini5qa6xw>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org, 
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, 
	davem@davemloft.net, hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
References: <20241014215022.68530-1-jeffxu@google.com>
 <20241014215022.68530-2-jeffxu@google.com>
 <6r5sxlhfujr2expiscsfpdjtraqlvy6k3cznmv25lo6usmyw7x@igmuywngc5xi>
 <CABi2SkUfXrRLg7+ZrLjMEQzh4FtU0EAfckdiDuza1mFKzi0SAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkUfXrRLg7+ZrLjMEQzh4FtU0EAfckdiDuza1mFKzi0SAg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: b40648ad-c7cf-47cb-52bb-08dceec4fa32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S010Q1F1MjN0ZDFDVU9oUDlDRTJ2QlBhc1luQXdpb3RLb0ZKYlhEUDdIUEpF?=
 =?utf-8?B?Q01jYnA1NjdlT3V5Mk9uaXBTekp5WWprOFBZYktLeE5nRFNYaTNGMlpvR0ww?=
 =?utf-8?B?WVMyRGJucHh1c21JdWZqK3RwZk5UdHEvSFNZQW01MlRsbzBpYUlXaHlwZStT?=
 =?utf-8?B?VnRGbUFQRFRkcWFQMlU1Mm9ka1I3UzRCVzFBblZsS2RBWi95UFQzbGhsSTh1?=
 =?utf-8?B?c0lrTlFjWEtNK3dQMTlHbkFmWDZ2cmNuTW43bDZZZGo4TVVnQ2NMbnBaNFV5?=
 =?utf-8?B?MlhwY3F4U2xHM0s3Q1VZNjFxWGdhQkxDQlpVNGR2K0UwV3BObE9DR0lKQmtm?=
 =?utf-8?B?ekNNdnQwakcybFZVNUR0R2hBVTBsWG1uWTNrMzNFcThqeTVQSG05cTQ4TGVa?=
 =?utf-8?B?WSs3QkNGcXBGWnAzY0l1NUxMYjEwQVowV2JPVDJwYnkvaklQcnJUMzZPVWtj?=
 =?utf-8?B?UEdEc1hNU2lqUmpUbzRxai9LZUJOMG1BQ2JqMFFSTHE4WkJFSE5MTnpwcWZv?=
 =?utf-8?B?RFZBZ242WlRnZnRKT1hseFRodWtPVGlHOTI1dnAxL1pmdGljM1Q3Wk9Lak04?=
 =?utf-8?B?QSttbEdYOHdrc0N0SU5PdUpzTVBDdG13SitEK3lLbE1WNDgzakxsYVBZOGdr?=
 =?utf-8?B?Q25RWG9mU3AwcTk4V25VaXFPWlZIUnMzOWNUSzVDUG8rRll4TDlqelR0WmtT?=
 =?utf-8?B?ZE9kc3l2SVZSSzlDcE12MEJFaUhUUS9tQ3Y0cTNTODBNSWJHS2lWcmFEQlgx?=
 =?utf-8?B?UUNtbDFwcUJpSHc3WWtrS0NrOFdwdjR5VzhrMzVtdEJWdzhBY1dSb2pZU0xQ?=
 =?utf-8?B?UFdlSi9LVGdOYTZoTHdhclRmWUdYZDhBa0pyQ2FuaThzdk5FQkp3RGJwWkxi?=
 =?utf-8?B?cjV0T2cxN0RRVlJIdE9TTjZ5TGlUNzRZQkhEM1dGRERLc1R3ZU9HOGh1UTli?=
 =?utf-8?B?Mi9VdnRFY2tTMU1sOWxGUmV2MFJYclU0RUVocFJodFZOQWZWZXlNZHJEempC?=
 =?utf-8?B?Yi9iTGExTmcvUmhXQ0sxUVZRbUpXSUhOVzdNaW1SRTlWOGVEREZoTGVnTkpT?=
 =?utf-8?B?bHZ2VmlLQVYvNGtmUklycHdzcUJpZERzcTlyVGVRakxoNnZEaDZ0RkFYaTQv?=
 =?utf-8?B?N1E2T0ZjeW40Nk8xRjkvMlBFTnd6R1lCYXhhTDVrUGJaZWFZWDNWMXpDQUx6?=
 =?utf-8?B?SU1LVGVTRTVMWHJhSUdFYkdUS3ZQNE9wMXdITURsY0tXQmI3MXBuc2luSTFP?=
 =?utf-8?B?T3pvaG0rWnVYZ2hYRm1NcEcrbmxiMkpNVEZ5ZzdhYllDNlVEQmhXV3NjK2xm?=
 =?utf-8?B?am9pN1lmaVdJQnJRbFd3STZJU3BFREVTWWkvcmVmd3I1dVNyRkFQaHRYQVJy?=
 =?utf-8?B?Mi8vWDcxbHQzWFFmekQrU2xIS2ZHcGhqeHBPMjNzaVFPcE9LVWpJbGxxK2VV?=
 =?utf-8?B?eGY5ZEdremdKcEc5elJVb05wckEwc3JpZE1VY3Z1dEVIRWEyUVZYVTQrSnor?=
 =?utf-8?B?QzUwWm14ZlJQVlYxdE9wNUllcm1lUTNGanlBelA2blk2R3RUSEtoZkxkUFd2?=
 =?utf-8?B?eU43M01XYWpqNU56aDBXNDcrdHFlLzMzUFg3YS95MXpicDRJczRZbTJVdHc0?=
 =?utf-8?B?NUZzWlI4ZkR3QjVZempNcEkxTHczWHloYXU2d2ZjOVFPV1VHbU5vb3dHMTZE?=
 =?utf-8?B?M08rajExK3lrZ2hJT1dEa3BYS2JmemhjWnhmTVR6cnF1ZEs4MmM3dE1ZcjVH?=
 =?utf-8?Q?7kvBzkymPwBd0dZhomXmIvLEVKKVh6lT3vqoHDJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a21PMHFITGFIZVByZ3NwUFhlcGpDckNab2R5YXI0VUU1OUF5WTQ5dUQvL2xs?=
 =?utf-8?B?Y1c5aE1qdUFoVVliclVDaHRKdWxiNWtCK2dKanZwUTVGWUJNRDZRSHQxMTRC?=
 =?utf-8?B?M1kxYnFCeXdMWXFzTzVCMWFSQm9WMUJieWtJbDhpZ2padWlTZ0dpOXVpaUJ5?=
 =?utf-8?B?NHgvamFjeVVQbFJsdGU1RlhBSUtmT01qdUVrbEZyWWJDQkVXcHpTVFgrSlhD?=
 =?utf-8?B?OE9uZk5rbE1HQzAwZncybTh0OWQ1VllXYnBZQmd2YjVXWEtyQ0N0cG82a0xq?=
 =?utf-8?B?L3JaK3BHbHJlVllWUk5BY1NhOEVZekMrbXAwTnc1UWU0UnpNcDRhRkNnc1pT?=
 =?utf-8?B?S0RINFB1MW85d0IyM0hjNGFGV2ZEZFhNblpPbDd5TldoMUY1ZEdIbnZTYndj?=
 =?utf-8?B?Qjk3RUxTa1NGUEk3U1ltT0tCT2dQTXk0dkdpbnlqNVVOb3lzWGlTSE50TFJz?=
 =?utf-8?B?dUZTWlVPY0RyN0tHS1YxV0N0OFZibk5WK3NZWHExNC9wN2tJaXdpajBOOEVJ?=
 =?utf-8?B?OE1KSzVsMGdIQXBzbS9QWGhlK3ZmWFNMdW0rVUZXTmhMZ3JYQ1g2dHNocEs4?=
 =?utf-8?B?b0QvRkR5Uk1DV1cra1YxSlRra29nRlpKVllqZEJIWER3emk4c3UreXNiK25o?=
 =?utf-8?B?VnZNWXRuQVh5blFLRkdqUHNNN3hjUlZBYitsR0xlMzk3bDBHRWZBemtpMU9Y?=
 =?utf-8?B?Nk9KMStxV0h0bXI0dGkzWko5NS9UYTczWEtMNFZXdWxQdGlOOTVDUzBNUlhk?=
 =?utf-8?B?MDFLVkNjekFJL1piUXQ3UzVjY2l5MVpxU0dDcmhzTGloL0FYQnd4VUJNelFF?=
 =?utf-8?B?Q0RoWWFlNmtYU1lnWFZkc3VhbWNDODhTQjFxeXlqbDFIcVFzUE9rWnR0UVBx?=
 =?utf-8?B?NS9nTnExWFRMNVVkYmZuR0tkVjR3WEpGZU1pMGF3enZvTzZDSnpqMDRaZk54?=
 =?utf-8?B?MTVYUzRqVDZEZklJZTdCQWFNNnBhd0N6Zm1jeC8xNGFOME5WZzNxVmdnRktE?=
 =?utf-8?B?cDFqcnE3WFMvSWNWUWJ0OUE5S0lYVmpvQmxTM0Znek5DU1IvUmlXQW5tQ095?=
 =?utf-8?B?OE5HM1NRYVppczBNWmVtY1NWcHg1T2c2dWR2OEVjcFBjWHdKR0Q5ZWg5ZEY2?=
 =?utf-8?B?ZXRDY2pEaUR5QkltOThieC9RRGxodlUrVENyYmVmdGlZc25QbDJtYXNUU3Zt?=
 =?utf-8?B?WDBpdEtaQVNzUlZTRndJQjJsWDcxamFDUXUxRnVtTzZhbzVqTnB0UkpobWl3?=
 =?utf-8?B?T01FK2VPOXNQS2hUa3dhZk43Z1JVU1JPU3k5V25MeG8yTW03MU1yenBBRmUz?=
 =?utf-8?B?WE1ZVndVRTV6ZVEwbTMvLzRZQXFLNUc3U2IyclFDTHVhelMvS3MrVWdOTDZG?=
 =?utf-8?B?aks0KzhOTWFSWWVXaUVmT1NQN3gyaVA1RlV0L0VKN1J1NzFFMEZrTkJKTkhV?=
 =?utf-8?B?Mk9LbllETkNlb1JiUldUU3hJdmRsSE9vVE1WOVdQNGxYNFhVYzJzLzBlejBU?=
 =?utf-8?B?ckhLKzBxZ2JUak1IODdOMUhmOVFId09tWFc1YnJwRWVaR0Uwa3FMcjI5bjdJ?=
 =?utf-8?B?eTFuSzhnWGNRRVppMWhCVHVWR3NWK1Q1dkhMOVZYNXBHTVUxd2FtYVgza1Zu?=
 =?utf-8?B?NkdJdjlOVGhvOTFZOVpXVFcxTFJQQlR0QUZZVXl4Rmp2amRycy9BTVl4YkJC?=
 =?utf-8?B?WWh4Lzh4a3hoU0ZnYUdNM1JQYk9RY0RlUkE0L1dyV2F2NFFCNFZCcUxTc01r?=
 =?utf-8?B?NUR6bm5ETUxZdDNKSUFwN2gvZ1Y3MVVBQ2hiWTl3bThmSUdWZ2NLL2hGUFpj?=
 =?utf-8?B?TVdxNXlIdTdXd3lpUzFlcFg1aXBNdGtMeFFYM1NqZW9JSjF2dXNtcU83YitB?=
 =?utf-8?B?b1M4RTkxWEtLK2pxVDNmQmlTVmhDWVlWZ1ZaZElLZzNOZ1VEbGJzZjUvMGVU?=
 =?utf-8?B?dE44d2pTTE01WE5DbDR4NTJzRXZJUzVZM1NjSG9ucFJNellPQXRRc2ZDTXRa?=
 =?utf-8?B?TEhxK2Q5TGN2VjJlR2toU0pVcit1eEllVUt4MnZrQkxETlJUVTZHQmlBbFVB?=
 =?utf-8?B?WTN2aWJPbjB5V1lFRnlZRUd5VHdiSW1EWkQ5amRydG04cDNEYXF3dVNaU1Bi?=
 =?utf-8?B?TnVINDZZbzQ1UUtoSHRNSmdWT3JVQU84U3Bsb3FkOXd4emNJNUkzdTBCaXZV?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WvoXfqrjJWnHrk2+PMZUIYoON21XJao7j+yn0DjJiF3zXQ2ncBfc/6rpy6eaDNbY9xx8yRBrVZQkT2Sj2GwcoSxPSBFnu9H/bhI5Wmn3sS9skED8cTLhH3dMZ61rszqahkspN7CTDGjbtd2omij7WVKrZ3ws0cbP9MoE9QEnO0aIcMrL2A54cE9saFSTyo/DnC5wcH2OuodENaKW5I0Hv6uQVAYfwViod/i6Op4ygHOFmvkexScECtmwYPzxnHHmhkkcUvuysjQiK/5LyKYds5pVNRw2eHlwSFcxSeupB1rOv83eN2KVen2yR/5KcS8j1QpgEWGXftLkt1N6BUrpBMtzFD67P7pLdWBEnkpvEXdW37iiMaLJywVpkEZrR1k3j5NbOmnnfQDYr88zSnLNh+Ih+3ruETz/t7HFXG/hWzNcD8aWvTJUM4Gr8X/5pfofzIy/YqPMZNZHOrz2MBL0O7ZxbQg+0rNw7wcQKRu3xiWcUI6RzsmHzL9TfzDYsBJKeqcWbmbG+sHOQoxXU/e+UXT8bew7MM3WqUKXD2nRj3DELed6QCwYoOrrCe0A0FDJdofQqkGM/GuaRcAXtLBb0bMnL8sy/nDg52OeKnDQo2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40648ad-c7cf-47cb-52bb-08dceec4fa32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:01:36.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmFAI2+2cpbJysCMjLQh7YNYpKNcSda4FMcePLAz7Bspx66vP9Vf9sjHhGCTyiqqh4CwMrK5hG8oYZKvvtUgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170110
X-Proofpoint-GUID: 9TRPokMKtm8a4NcFASphhYD7uNrulp14
X-Proofpoint-ORIG-GUID: 9TRPokMKtm8a4NcFASphhYD7uNrulp14

> On Wed, Oct 16, 2024 at 6:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
...

> > > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/v=
syscall/vsyscall_64.c
> > > index 2fb7d53cf333..20a3000550d2 100644
> > > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > > @@ -32,6 +32,7 @@
> > >  #include <linux/mm_types.h>
> > >  #include <linux/syscalls.h>
> > >  #include <linux/ratelimit.h>
> > > +#include <linux/fs.h>
> > >
> > >  #include <asm/vsyscall.h>
> > >  #include <asm/unistd.h>
> > > @@ -366,8 +367,12 @@ void __init map_vsyscall(void)
> > >               set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> > >       }
> > >
> > > -     if (vsyscall_mode =3D=3D XONLY)
> > > -             vm_flags_init(&gate_vma, VM_EXEC);
> > > +     if (vsyscall_mode =3D=3D XONLY) {
> > > +             unsigned long vm_flags =3D VM_EXEC;
> > > +
> > > +             update_seal_exec_system_mappings(&vm_flags);
> > > +             vm_flags_init(&gate_vma, vm_flags);
> > > +     }
> > >
> > >       BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=3D
> > >                    (unsigned long)VSYSCALL_ADDR);
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 77364806b48d..5030879cda47 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> >
> > Does it make sense for this to live in exec?  Couldn't you put it in th=
e
> > mm/mseal.c file?  It's vma flags for mappings and you've put it in
> > fs/exec?
> >
> If you are referring to utilities related to kernel cmdline, they
> should be in this file.

You created a wrapper for the command line, but then included the user
in this file as well.

hugetlbfs reads the command line as well, in cmdline_parse_hugetlb_cma.
That parser lives with the rest of the hugetlb code in hugetlb.c

I think this has to do with your view as this is an exec thing, where I
think it's an mm thing.  My arguments are that you are directly adding
flags to vmas and it's dealing with mseal which has memory in the name
with the file living in the mm/ directory.  If I wanted to know what's
using mseal, I'd start there and totally miss what you are adding here.

Besides applying a vma flag to exec mappings, why do you feel like it
belongs in fs/ ?

>=20
> > > @@ -68,6 +68,7 @@
> > >  #include <linux/user_events.h>
> > >  #include <linux/rseq.h>
> > >  #include <linux/ksm.h>
> > > +#include <linux/fs_parser.h>
> > >
> > >  #include <linux/uaccess.h>
> > >  #include <asm/mmu_context.h>
> > > @@ -2159,3 +2160,55 @@ fs_initcall(init_fs_exec_sysctls);
> > >  #ifdef CONFIG_EXEC_KUNIT_TEST
> > >  #include "tests/exec_kunit.c"
> > >  #endif
> > > +
> > > +#ifdef CONFIG_64BIT
> > > +/*
> > > + * Kernel cmdline overwrite for CONFIG_SEAL_SYSTEM_MAPPINGS_X
> > > + */
> > > +enum seal_system_mappings_type {
> > > +     SEAL_SYSTEM_MAPPINGS_NEVER,
> > > +     SEAL_SYSTEM_MAPPINGS_ALWAYS
> > > +};
> > > +
> > > +static enum seal_system_mappings_type seal_system_mappings __ro_afte=
r_init =3D
> > > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS) ? SEAL_SYSTEM_MA=
PPINGS_ALWAYS :
> > > +     SEAL_SYSTEM_MAPPINGS_NEVER;
> > > +
> > > +static const struct constant_table value_table_sys_mapping[] __initc=
onst =3D {
> > > +     { "never", SEAL_SYSTEM_MAPPINGS_NEVER},
> > > +     { "always", SEAL_SYSTEM_MAPPINGS_ALWAYS},
> > > +     { }
> > > +};
> > > +
> > > +static int __init early_seal_system_mappings_override(char *buf)
> > > +{
> > > +     if (!buf)
> > > +             return -EINVAL;
> > > +
> > > +     seal_system_mappings =3D lookup_constant(value_table_sys_mappin=
g,
> > > +                     buf, seal_system_mappings);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +early_param("exec.seal_system_mappings", early_seal_system_mappings_=
override);
> > > +
> > > +static bool seal_system_mappings_enabled(void)
> > > +{
> > > +     if (seal_system_mappings =3D=3D SEAL_SYSTEM_MAPPINGS_ALWAYS)
> > > +             return true;
> > > +
> > > +     return false;
> > > +}
> >
> > This function seems unnecessary, it is called from another 3-4 line
> > function only.
> >
> It is more readable this way.

It really isn't - you don't have to cram everything into one if
statement.

>=20
> > > +
> > > +void update_seal_exec_system_mappings(unsigned long *vm_flags)
> > > +{
> > > +     if (!(*vm_flags & VM_SEALED) && seal_system_mappings_enabled())
> >
> > Why !(*vm_flags & VM_SEALED) here?
> >
> If vm_flags is already sealed, then there is no need to check
> seal_system_mappings_enabled.
>=20
> > > +             *vm_flags |=3D VM_SEALED;
> > > +
> > > +}
> >
> > Instead of passing a pointer around and checking enabled, why don't you
> > have a function that just returns the VM_SEALED or 0 and just or it int=
o
> > the flags?  This seems very heavy for what it does, why did you do it
> > this way?
> >
> Why is that heavy ? passing a pointer for updating variables is natural.

What you have here will pass a pointer to a function, dereference the
pointer and potentially call another function to check seal system
mappings is enabled to dereference a pointer to or a bit.  I would hope
the compiler improves this, but that depends on the compiler.

What you *could* do is call a function to check the seal system mappings
is enabled and return the bit to set.  The caller would just need to or
the bit on value without dereferencing the pointer.  We may be able to
even inline the function you call.

So I am suggesting removing two dereferences and a function call (maybe
two?) while making the code more compact and readable.  This is what I
mean by heavy.

>=20
> > The name is also very long and a bit odd, it could be used for other
> > reasons, but you have _system_mappings on the end, and you use seal but
> > it's mseal (or vm_seal)?  Would mseal_flag() work?
> >
> It could be longer :-)
>  it means update_sealing_flag_for_executable_system_mappings.
> mseal_flag is too short and not descriptive.

mseal_exec_flags() ?

>=20
> > > +#else
> > > +void update_seal_exec_system_mappings(unsigned long *vm_flags)
> > > +{
> > > +}
> > > +#endif /* CONFIG_64BIT */
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 42444ec95c9b..6e44aca4b24b 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> >
> > Again, I don't understand why fs.h is the place for mseal definitions?
> >
> include/linux/fs.h contains other exec related function signatures. So
> it is better to keep them at the same header.

I don't see this as an exec related function, it's changing vma flags.
Besides this new function, the fs/exec.c deals with the stack flags.
Well, this header has VM_MAY{READ/WRITE/EXEC} for nommu - but I don't
think we can really count those here and they are used to translate
things anyways.

Recently, we have been trying to modularize the vma code for better
testing.  Spreading the code across many files will make that testing
harder to do in isolation.

>=20
> > > @@ -3079,6 +3079,7 @@ ssize_t __kernel_read(struct file *file, void *=
buf, size_t count, loff_t *pos);
> > >  extern ssize_t kernel_write(struct file *, const void *, size_t, lof=
f_t *);
> > >  extern ssize_t __kernel_write(struct file *, const void *, size_t, l=
off_t *);
> > >  extern struct file * open_exec(const char *);
> > > +extern void update_seal_exec_system_mappings(unsigned long *vm_flags=
);
> >
> > We are dropping extern where possible now.
> >
> extern can be dropped, it appears not causing link error.
> > >
> > >  /* fs/dcache.c -- generic fs support functions */
> > >  extern bool is_subdir(struct dentry *, struct dentry *);
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index c47a0bf25e58..e9876fae8887 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1506,7 +1506,7 @@ static int xol_add_vma(struct mm_struct *mm, st=
ruct xol_area *area)
> > >       }
> > >
> > >       vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > > -                             VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> > > +                             VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM=
_SEALED,
> > >                               &xol_mapping);
> >
> > Changing all uprobes seems like something that should probably be
> > mentioned more than just the note at the end of the change log, even if
> > you think it won't have any impact.  The note is even hidden at the end
> > of a paragraph.
> >
> > I would go as far as splitting this patch out as its own so that the
> > subject line specifies that all uprobes will be VM_SEALED now.
> >
> > Maybe it's fine but maybe it isn't and you've buried it so that it will
> > be missed by virtually everyone.
> >
> I will  add "It is sealed from creation." in the above "uprobe" section.

That in inadequate for what you are changing.  Doing it this way risks
breaking things because no one will notice.

>=20
> >
> > >       if (IS_ERR(vma)) {
> > >               ret =3D PTR_ERR(vma);
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 57fd5ab2abe7..d4717e34a60d 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2133,6 +2133,7 @@ struct vm_area_struct *_install_special_mapping=
(
> > >       unsigned long addr, unsigned long len,
> > >       unsigned long vm_flags, const struct vm_special_mapping *spec)
> > >  {
> > > +     update_seal_exec_system_mappings(&vm_flags);
> > >       return __install_special_mapping(mm, addr, len, vm_flags, (void=
 *)spec,
> > >                                       &special_mapping_vmops);
> >
> > If you were to return a flag, you could change the vm_flags argument to
> > vm_flags | mseal_flag()
> >
> passing pointer seems to be the most efficient way.

I disagree.  Here is the godbolt.org output for gcc x86-64 14.2 of your
code (with some added #defines to make it compile)

seal_system_mappings:
        .long   1
seal_system_mappings_enabled:
        push    rbp
        mov     rbp, rsp
        mov     eax, DWORD PTR seal_system_mappings[rip]
        cmp     eax, 1
        jne     .L2
        mov     eax, 1
        jmp     .L3
.L2:
        mov     eax, 0
.L3:
        pop     rbp
        ret
update_seal_exec_system_mappings:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 8
        mov     QWORD PTR [rbp-8], rdi
        mov     rax, QWORD PTR [rbp-8]
        mov     rax, QWORD PTR [rax]
        and     eax, 2
        test    rax, rax
        jne     .L6
        call    seal_system_mappings_enabled
        test    al, al
        je      .L6
        mov     rax, QWORD PTR [rbp-8]
        mov     rax, QWORD PTR [rax]
        or      rax, 2
        mov     rdx, rax
        mov     rax, QWORD PTR [rbp-8]
        mov     QWORD PTR [rax], rdx
.L6:
        nop
        leave
        ret
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     QWORD PTR [rbp-8], 0
        lea     rax, [rbp-8]
        mov     rdi, rax
        call    update_seal_exec_system_mappings
        mov     rax, QWORD PTR [rbp-8]
        leave
        ret

----- 48 lines -----
Here is what I am suggesting to do with replacing the passing of a
pointer with a concise "vm_flags | mseal_exec_flags()" (with the same
added #defines to make it compile)

seal_system_mappings:
        .long   1
mseal_exec_flags:
        push    rbp
        mov     rbp, rsp
        mov     eax, DWORD PTR seal_system_mappings[rip]
        cmp     eax, 1
        jne     .L2
        mov     eax, 2
        jmp     .L3
.L2:
        mov     eax, 0
.L3:
        pop     rbp
        ret
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     QWORD PTR [rbp-8], 0
        call    mseal_exec_flags
        mov     edx, eax
        mov     rax, QWORD PTR [rbp-8]
        or      eax, edx
        leave
        ret

----- 26 lines -----

So as you can see, there are less instructions in my version; there are
47.92% less lines of assembly.

Your vsyscall version is even worse.

It is very tiresome to do code inspections and be told flat-out "no"
repetitively.

Liam
