Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300731A3BA1;
	Wed, 26 Feb 2025 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591920; cv=fail; b=oTQWfTFiXMsy8YY2CkZ5a9Kp+1GmSRTeXDeyV3TI3KRsbiUUzZILDdFRQEhVyY9bH7wY6JyxG2z9U2PrtyRp8oI3y9Z1fOSop7Mc7vfdq4kInTenIfSCM2YyCZ/vrQdPxg68RUrM2RyLhSKsza93wD4EhBj4wC2HNdmC1s2Iq18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591920; c=relaxed/simple;
	bh=4FVwsZx5qAx/itGafXLFAL9gHBpVsvZ68An1jj+bmUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j5dm4tN+hkW8sOY9YynCwhqxC/SEgUR4k6mJHn4yjSLDpmxq8vD9Ocd5HFlxaNmszhRMn9+f2wQi6xQVePBdyG1f4q8lzL/RSlFdw7+19o/JZQg87P25WW7Cp6qE3hJNJl8qm4UH7TBVIw6N5rBDQZM0jQd09I6GxA6AmiflRPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yqq4jgNS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nEC5VQOM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yqq4jgNS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nEC5VQOM"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtZFr016993;
	Wed, 26 Feb 2025 17:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=whZu8XfRwrYU2TYgZTL+d7S/+4BAfcUktEs3q76X4gc=; b=
	Yqq4jgNSXbcvaI3kxu4Vs7ZPlgizIzJgjuBDWaZ/GpKnbhSrrxHmLjvXRvsyUeSu
	syAWhKHoJnmB2BmnwXe5Ol7uc7ihINstRDcIcsxsQ/PrY6gAPeubGoiz02bSsMM4
	Fes020dNH8Js3nsSfbHEmymrn3yPFkrOJV72uksdJE9r0JDM2deHJKFPPdtY72hl
	rHEsITkEKA4EFuC+w+d5SE/6Y5wt8atOv3WrCp8OMp2zu1sVCZbF0zkQe5Dz2cST
	CSHM9ug3VAS0vxPdrYGi9aKiEeip1kT55L2XhbSTSjoEm5HWn98T0efOmnbIBeS9
	P97UEZsW2bpv0zcUzXnCJg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse9pby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 17:43:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QGVpfh007511;
	Wed, 26 Feb 2025 17:43:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51h1x8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 17:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OApMrLFMfYU4teO7W8N3P4eaU03VkhQyedwA2VqT7XMRKkdQanoUn5IhjBAX8MQbbRx9C0Vjz652n07fvXKETIQFwcpVB477+tggRCev7+S+iW42Hx3+DAMP2Wa5zkuqzjoZs5QReO4qfpu0uSXw/gMHFFj+QazkFcy5p5+Ee+w3zWeWewNydr9++Cxx58QKDIllXZz/zgNILHFngas5pM8ivN/sVIO1C55ILKwhTaJgIEmG99Cve2mQ2zlTPTf52EMjO3n02y17Scr18GJm0ja/JfG+p2gWa2WZu5iGNggD0vtSewD3l/sDQWsBuFigUKyuwfxYpoVZK4Mw7vIzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whZu8XfRwrYU2TYgZTL+d7S/+4BAfcUktEs3q76X4gc=;
 b=UZiThKNHy6QP/u1+6J8AtadPOt2J9AkD/zJrkbyJJF5V0MpBu4kqLkX0AwS5ftLvPd/4gmZGk04wnDtMw5V7BT4cILfAhBDdh/Cw3lvkEizwrV7TH+arpBvbSLYJ2LcOBEwvw5xxBJUhPomM+pbkL907t01K1Z2pyuBPvX4SkBnZIwZTFVKnT43Btxxj1Ac9Am6z54+v6m0Ypy4GRShm1H+CsQsqCk9wIgP7Z+9Wh5zOFXF+iJqfGSUIVIPR4LsYFWhVcTheGXAk2/e1K9R1bZlBSYPBsHcTAQJ3mPHCJpZs3zICjy+t6opXQM+CIIhQ4kdq4ELsw9J8oRHiU/bxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whZu8XfRwrYU2TYgZTL+d7S/+4BAfcUktEs3q76X4gc=;
 b=nEC5VQOMgIuuo2raXWHszp1WcwnWWLcKIRFeqQHSbKGSoCajg7RjtVA/TkAKKBKh9PER0F+waV/t/fIeHz1gudCYiC66Zt0sKp/boSCRexRniyzo+j7I+dkKE+EZD9MIcily5pVGh9Z6t2tG/dOK6uZr4ZwrDTZ3hQlJtg1R/Z0=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MW6PR10MB7589.namprd10.prod.outlook.com (2603:10b6:303:23b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:43:24 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:43:24 +0000
Date: Wed, 26 Feb 2025 17:43:22 +0000
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
Message-ID: <ba04b513-0eb5-425d-b24c-82c9f9b6c7ee@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-5-jeffxu@google.com>
 <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local>
 <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
 <ea970928-ccea-4314-9cde-b64fa1a7824e@lucifer.local>
 <qk4m74uscjxdnlchcxolvgbw7ijppzqk57ajyc4m6jjixq5gti@lokjqegpftzh>
 <CABi2SkUprOT=TEDQb62SByjyW+csarKnGypdmxVdktj=+C9_yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUprOT=TEDQb62SByjyW+csarKnGypdmxVdktj=+C9_yg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0551.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::19) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MW6PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 26300618-db07-40e5-5242-08dd568d115b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnhOOE9zb0dIOGI1SENWSXR6VnozNldRRzFLa2hhdnkxV01KYm1FT1hlaTVK?=
 =?utf-8?B?Wm84Z1pSK1ltTWtGNXBUVzJBc0J6cDVBM3Z4d0VRdGFDNEdCRm1nMDV5SWFa?=
 =?utf-8?B?eUQrZE5HZWpoYjNUVWZ2dTU3ZlhvM2RTZ3FnNTFERm9yYUpNdEpEMFlManQv?=
 =?utf-8?B?YWJMVFc5bWZIaXVvUGZnNjZXdGh2Z0UwU00xMTdkOG53bG84em1BZHhnbjV5?=
 =?utf-8?B?a0hIVms1ZHJ0bEtTZ3N3d3Z4ZGNUenpYdEo5WHNzMDdPc3J3ZE8vOWVsU2FX?=
 =?utf-8?B?QXNWNkN2T2pKN01GYkFyQ25VV3RWY2Q4MnpsUDFIVHlhNXdiVUY3ZjZBdnpn?=
 =?utf-8?B?ZFZKVUFPaFNkcnVlS09vSVpKUnJkSjJBbE95MVVuVGtacG9uQ0RGZVUzTUc1?=
 =?utf-8?B?aC90OFFmMUNLNFlOMm9kRHNOZHVNcDNxTGdMZ3FDTU95cTNwaGM5QkxnUGNx?=
 =?utf-8?B?SVNTVDgvRlJodHhuTXMyUGp1Q2MraVJlQTVvWGdsclZtNWhJWDNyL0NYSGlN?=
 =?utf-8?B?RHZINVRPZnF4TjZoY1A4WTh5VlJlN1FReDdWSU5xU3dIWmhpY09JYXZKVHdx?=
 =?utf-8?B?bFNUSlpSUHFLTFhMeTBMbk1BYWxHRFdCRnFXQ3RoWlRTb3dzRmdYUGR6R1hV?=
 =?utf-8?B?VE53a0FYZGlEd1RZeG5Nb0JhM3RWY3g3eEk5OVF0Tkx1NHFMZXRRSWFJR2Mx?=
 =?utf-8?B?R0JsZUxrQnhac0hkamZZVTloMzNteUY1dmRBanNUTVNwNXNNeUNvaXgrZW4z?=
 =?utf-8?B?SjZNSk1RWFUyVUhtZ3NhQitFUUg2d21QbUNJeVBtQSs1UWhETDFsUHIyZ0pB?=
 =?utf-8?B?VE5TdFdSZU1LTDJsRldhelBHenRKOGlwSHZtUnBQTlNmZXAwQStrL0lIaTgv?=
 =?utf-8?B?VGJlWDRiYUtld1E4M0VvOGtyNGdlUnM2MW1wY0hscks1NC9sa0xNZmE4UjNv?=
 =?utf-8?B?WGFrdnA1TUFJZ2kzZENkK01GYzZVeEowQ29pRU54SGFBTnFRQ1NHQ3cySVJE?=
 =?utf-8?B?QXpjU1g2VG0vK3RYeEVMWEpoeUIzYy9TdnJ6YVRmdTNrQXJpZUM5NVg0cUMz?=
 =?utf-8?B?V041YjhLRFFjZUI0VkVJOVYzNm9haHY3NG13U1hHek41Y2tOREFuTjVTSita?=
 =?utf-8?B?REs2Q3VBYkRVeW93VmNHejVmSTFxWmRHLzB2eFpZTU9yemVlZlZobjZKZ3ZT?=
 =?utf-8?B?Q3RFaFVqUVdZak1TYitqYnNXSk4vVWNoQ3IwNzVLWkRhenQxTXA5QkhTM2Yv?=
 =?utf-8?B?R3MrbGhXY1QwT2hVbW12ZEdnV0dYRkhxakVFNHV1S3lWdWd4OVhabUx4QUdR?=
 =?utf-8?B?K0JWZzZIZzlsRFpXZnNaWDRHeHd6amh2Ny85SVhRaC9vZE1KNVZ2RXNvRmE2?=
 =?utf-8?B?OFBiQ1RuSGllSXBmTW1GSkZrbG5jcmpxU2Z6dk1KbWJObFE5UjRHN0pab2lS?=
 =?utf-8?B?Z3lCUW9hckd1ZTRRWnRPY1ZnbUF4MWFyN1ZTRUJqSytPTnJoc2lOQ3I4eGpq?=
 =?utf-8?B?RXM5bDBucVlwQ0trcXk4QU9NK1BXYnMwTkVEdUUwMzNYL0lEdTdoY0d0aEtB?=
 =?utf-8?B?VzZZc1dwazNYQktVcnhRL2MzendPMXM5MDZjcDVrbWlUNUtYUHQydWhLdWw0?=
 =?utf-8?B?TTdmT0pDQkdvaktMVWMrbUlxRWsxZXJQQ0JEaXNPcTdqS2N0WU0rZXdTeUs1?=
 =?utf-8?B?ZG5tQnNobHBRa3BaOThjNUVNODRDK0w0ZW52TFNxOHVRR24yZ2pYb1E5SDVh?=
 =?utf-8?B?elMvbDZHU2JkZnpOUTBIbTNLRGltRHAxWGc1MXpEaTNHYzhDTmMrcnN5L3JJ?=
 =?utf-8?B?OW5PK2tvb1RkZ3pmdWFTdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3pDQmpiTnRUL244cXpqR2tnUTFkVnhwSFlNWlIxQmFiNDBJNW5qYXZuRDVi?=
 =?utf-8?B?bnBKeTRyeWZ5TWYwdTY4MWlCMWRPYlREVXBhRjNya2ltTk5wVGd1VkV6UWpJ?=
 =?utf-8?B?OVdGdXV0M0lDNkU0emI5M0xHNnZ1RHdrWG52VXZQTlJyd0piVUVPS1QwYmM1?=
 =?utf-8?B?clY3a05sZ1ZhZGVwc1V3WWVUcWM3b0dQR0IvM2dpK2RSdlFlaU45RXY0bjBN?=
 =?utf-8?B?R3Q4VXpTVWU5cG9BdDdRZHMrU3JIejB0S2VONGFzVnYwTkFpVVY4cVJqRmFi?=
 =?utf-8?B?UWZ6REdKcUZKRXpabXBNb0FXN3dYM3hlMVREUDhTUUtwTkhwaTdHT3ZXbzJF?=
 =?utf-8?B?bkpOWXdWcjUzU2YyVks3SEZ4c2lCbGN4VnRDMG42M0s5Qld2NDFjNTBwOHhZ?=
 =?utf-8?B?aHVlYUpKQjFhTWZLeVlOS1NHQ2NIVWtKb3NGWmQxZkdSb2pFUlNlZlB6S2o4?=
 =?utf-8?B?VTFTUDZPeS9uY3hTQmN0MldaNHdwM3RwM1dYTnl3VjBuQWpzYncrN2dseSt4?=
 =?utf-8?B?VURxMG9DTU15dTVhV3JMR1dERUd5ak1oSkhlUFZKN0dsNGJaWHNNOTc5ODJI?=
 =?utf-8?B?MVFDS0V5ZDdCaVBIa1dGWHJJdUl1L25ka3h2VXpXL0g2RGxrQThjN3hIK0g0?=
 =?utf-8?B?eWJjdUtBZEp4d1RjVFk2Z0xZS1BHZGpOSldwcmhnb1puV1Q1UmhvUlRncktI?=
 =?utf-8?B?TmVsRHRCbVp3MDM5blB3MDEwU1BDSngyRkxrWjAvSkIvVVN2SmFyaVJ2NVI0?=
 =?utf-8?B?MXhERU5HVmswcjZCeTQ4Vlg1SER2UHVtSEwzeTZORWV5Y2pEU3FmeE16L1Vy?=
 =?utf-8?B?bEJDbWlHWTFLaFQvRUxvTm9Rckl0ZHNRWHkzVHBmRUJGa3A4dmdIK0hmL3Iv?=
 =?utf-8?B?eER0MlNJaHJ4Mld6aXZ5RTVrc0NSUDJtdEdJNVVnbXRUN0x6c0ZWd1ArOUt3?=
 =?utf-8?B?SnNneElVR3RhVWxLUHE2SUdtbyt3UE9DMTB1ZXdaZkZKTkJMZmprYU51VU1p?=
 =?utf-8?B?UFNLMXhHVCs5dGlXcmUzZEdjOElMbDk1WlJjNE9BVU5nb0Q4SjlYN01MVE5M?=
 =?utf-8?B?c0pqZmZPYVFlQU9PTjM4VzZhY2dBb0YzRkRRdXp5TThGM2kzREZOTUdZNWo5?=
 =?utf-8?B?M0xuNmM2eTNWbVg0eXN5ZEI4d1p1RFg0QzZkL3lhRTdvdFdWRDQ3RVdMNXIw?=
 =?utf-8?B?TWhtbWkwOVo3b0JKMlk3YW0ydEFnN2k1TlIvazl0bDNTMWlEVE55QUZxUGE5?=
 =?utf-8?B?NjRsdkk2dDFsMDFiR3cvOXFoNkhkb2lacjNadXJReE1ER0QxUTRhbERMcGpJ?=
 =?utf-8?B?SXluM3hJN3E4VENXelNHYTFaemQycXVzNS90NzdlOWZjbnpHcSs1OUlFTmVv?=
 =?utf-8?B?aW5MY2phVS9qVmdYNFJFYUxZVzVPeVNRVkdwZWYvTkUwMk5tZEp1SUlvVzZy?=
 =?utf-8?B?STJ6TXRXTnVzTmdKQTR4K1oxSkFyeCtJZ09RZlk0RkhoOEJBWHlCQTJkdjNS?=
 =?utf-8?B?SUNDQ1NGRE5MQUZvQUp1aE9DbHJ1UU8zUHhKQ1Nrc1NhMnRvK0poSnRaVVV3?=
 =?utf-8?B?Si9sYWEyekpFa0pNd0JiNDR5SzR3OGEvalRuQm1XRkp2MzQrUUt1NkRpelhv?=
 =?utf-8?B?R1N1NmxNV1FYa2ozSTU4WXlyUENZR1ZnbWVvRFBUQytGdDRwY1drNDl0c1Nh?=
 =?utf-8?B?ZTN1UkI4MVdkelFHUWRma1JGSVVFdHk2VG4ycVp2eVR3YjhzMjk3MlJ0WHo4?=
 =?utf-8?B?MmNONnJGdkc2Q3RkQ01ILzRoMWh2ZXVvTmJWSkVObzYvenFkOGxOM01DWjFr?=
 =?utf-8?B?eklQL0NDQURNVTJJNmtBUXo5QXdsdlh4QmlSbmpaSHYrSlQzNytCbXV0U2JE?=
 =?utf-8?B?Vm1FODZsTzk1NWZram1YMkpGUVRkQUZCNTZnMWg4M0dUdzdIQUFBNXU0WWls?=
 =?utf-8?B?ejY1RVhnQ2pNcEVEVVdlZE9HOFZkQVBBR3J0dElxY1hHMTBqelVOK1BaZW1M?=
 =?utf-8?B?QnJucnVCQlEvRlZvbUdBV3V4Y20xSk96OERSMXFEMTlGK29PYjVTWjlvVGhN?=
 =?utf-8?B?ck1jZ1hTaHAyVVIvTnZqN2F6U3BpOGFoR3dXYUlhT1d5R3hJSEdPVjh1bFJm?=
 =?utf-8?B?RzJzbDJGZ0M0SnBueFJOeU1EUTZmbkdRL2lKbkhMYTVIMDd5c09jT0VJTlRX?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iWAUsuUWPs14jcxCBfh+bxUZi2cMpG31Cy2+Fe4FyJCZ1bxpTbfdo/7zI4FctZ04u3MAmiQL+RaDXb6BfHJfSr8up2uocVin3LrXCRYa5pu2aMHH1I/KeU45F+5ae+ChEwUaGUUXXrrWSyN8sRjbfM5zI8+55Ul+qm1K1xJQJFwsDwx6UQcwf2/PRkfHCKUr5h8zMGysqCvnlx40rOG9rVYh0fDXFraCv4KkYTDNoEQOzoHcaIuGPziNTP1QPR0jTCGCtnsk7lj1n/Yfk/c3lNvFHvOMlH0/fRxHkdvut8Jnikv6WXANLCs2bHtj8mF/QUImc+NC26ARYE0B5oACVsmXCshn2hAvGt9Iy8zOC66NNL4XxbYeqvUHDPyxE7G8qCh4Vb8N45td/K4beu5HJ1pnmUF47e2lzsvWIrlyBeJ3f91ksk5CxYhUasrM9JTHuIit1B5fM+bRiSvOgOWMMUqtot4fJaLOhBiI0f22qpfOHHfQvbgVxanoRd6tklEnRicigVVtFD6/+BrXOY7Z/5IcfDukVn+GDASp/s+/5ocVe4UEpiA2doqDhjruWGM5+Unr77E8bikrPNB7uKULUwgV2Z7GjDy/SM4fQVEHv/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26300618-db07-40e5-5242-08dd568d115b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:43:23.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYvdIYL5VT9rNGT8+C1baWrbNSvljQ9lYwxGT5h+hsQqv9oEnLLZ80ZWKKmZp0VoLZYUZBXeFWnCbdnDjBthVBdSpmK+hK1ghHw3Q4CwzDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260140
X-Proofpoint-GUID: 3KvRuseDHkJyIKaEm3tRHWd9m80Fa0nM
X-Proofpoint-ORIG-GUID: 3KvRuseDHkJyIKaEm3tRHWd9m80Fa0nM

On Wed, Feb 26, 2025 at 09:17:10AM -0800, Jeff Xu wrote:
> On Wed, Feb 26, 2025 at 9:12 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250226 00:26]:
> > > On Tue, Feb 25, 2025 at 02:26:50PM -0800, Jeff Xu wrote:
> > > > On Mon, Feb 24, 2025 at 10:20 PM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org wrote:
> > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > >
> > > > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> > > > > > the vdso, vvar, and compat-mode vectors and sigpage mappings.
> > > > > >
> > > > > > Production release testing passes on Android and Chrome OS.
> > > > >
> > > > > This is pretty limited (yes yes I know android is massive etc. but we must
> > > > > account for all the weird and wonderful arm64 devices out there in context of
> > > > > upstream :)
> > > > >
> > > > > Have you looking through all arm64-code relating to vdso, vvar, compat-mode
> > > > > vectors, sigpage mapping and ensured nothing kernel-side relies upon relocation?
> > > > > Some arches actually seem to want to do this. Pretty sure PPC does... so a bit
> > > > > nervous of that.
> > > > >
> > > > Can you please point out where PPC munmap/mremap the vdso ?
> > > >
> > > > Previously, when you mentioned that, I thought you meant user space in
> > > > PPC, I didn't realize that you meant that kernel code in PPC.  I
> > > > tried, but didn't find anything, hence asking.
> > >
> > > Jeff, please stick to replying to review. 'Have you looking through all
> > > arm64-code'.
> > >
> > > I ended up doing this myself yesterday and found no issues, as with x86-64.
> > >
> > > I said I'm _pretty sure_ PPC does this. Liam mentioned something about
> > > it. We can discuss it, and I can find specifics if + when you try to add
> > > this to PPC.
> > >
> >
> > PPC allows the vma to be munmapped then detects and falls back to the
> > slower method, iirc.
> >
> Is this code in the kernel or userspace?
>
> If PPC doesn't want to create vdso for all its userspace apps, we
> could instead "don't create" vdso during the execve call.
>
>
> > They were against the removal of the fallback; other archs also have
> > this infrastructure.  Really, if we fixed the fallback to work for
> > all platforms then it would probably also remove the possibility of a
> > remap over the VDSO being a problem (if it is today, which still isn't
> > clear?).
> >
> Any past thread/communication about this that I can read ?

Jeff, I'm sure you don't intend to, but I find it quite disrespectful that you
ignored my feedback here (and elsewhere, regarding you ignoring 4 sets of
feedback).

This?

https://elixir.bootlin.com/linux/v6.13.4/source/arch/powerpc/kernel/vdso.c#L236

Was [0] a relevant discussion?

[0]: https://lore.kernel.org/all/lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyuso6jcy3b2dq@7ju6cea62jgk/

>
> Thanks
> -Jeff
>
>
> > Thanks,
> > Liam
