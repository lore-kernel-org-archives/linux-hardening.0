Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53D206274;
	Fri,  6 Dec 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504707; cv=fail; b=t7S2GuT+LFtc+YdoWRUI7Y+x3CKHDBemwcwC9vEfpdq3GJwvf/VEio3SYXlNAcQoPAVRvU8JwdnfbXcZZdOFuoB5hTDon/oXY0TF+2kX7a4WxuES4pyZfhgV7nXnnzqd7JVLKEBE9divQ6Y2PKaoR0gaZuBcu2kAYEQQpFV0C9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504707; c=relaxed/simple;
	bh=otn2NCLO1LnFelIwWYrvq5PwdkM/oAXvOfsE65HbXVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nIWe842dfvTGu2Dy/DA+msvjqGrMi0MBlEBwuLByjTmLILa/C5Zk2LATFCcrJpnRro5LcMrLW1TuNNdpLWZFJOedGmdergV9Qqi0DBx25X2VkC2hYCEU7t3Fz+R2b0+2pByy6nrtdmOIEXbJXVBegmNhhmzD4VAVz4kf5AGOHTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ctNTR3/4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xAKpC45D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctNTR3/4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xAKpC45D"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6FCYpA020860;
	Fri, 6 Dec 2024 17:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UYw9NxYaQvA6Usuq0eEuI7kj7qKx3IwUA1sr3c+zbBg=; b=
	ctNTR3/4nOqfq0t0vLhr2nqjY9l+uTT6pXesvlAri43QVkr7iPzJmOHXjX4XgWbK
	0MA0puExDMK1OXiDblrvEsB8+tWzbMtixumGT0Po+Adn4PHENWsQEgl5OYLcs76j
	HabEBcD2asEe8MRGMeaCdL2FRZgmikBqv1BTW111CDLPvSPPkfrccqCqDJ7RKmm6
	W3fMhQ/MHGLEM5xvH8Xi9vDzEzrqQTNQpILNBzaQD+8mIM9ubY4DvemwGfKqYAVN
	wdVQ5RiHSEOWw+8bTEjnrdHrkNuP33Sk3UXWDel60OGY9QCBQ4Cl3OVc9+l9FYxw
	GgQAPeUV8O/55hPGjXOySw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbwyw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 17:04:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6GYDGO036915;
	Fri, 6 Dec 2024 17:04:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5d2m7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 17:04:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgQDwRNkB/EWFNQq0ry0OEl9fgxajLu65cNme8U9zVKI6D/Nm6jzz0iN47656YLr2IsekrYmig5dR3xU9NLq6nKw0ODkdFBqUX0YxpDx1jrv4P6YHGkhc1WqZ1yIAdPs92ZcWN9695zpi4jTEg4fCC3xMPJ2X4saU4L6dfvNQ6AkuAWF1ITM1oA/4QsRqjcshuWskAaB0x6KhNkS4QywDNKXifcHDVag3t9in1UbkTc0JNjr0cN+i4xIHDmiLy/azktHY3HDuUZzuBYT//+5t90EfbdAVdCG2zNA95gMz1M665Kxptr8I0mUXEJfd7CQntU66g3JeAkw5hB5TrRJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYw9NxYaQvA6Usuq0eEuI7kj7qKx3IwUA1sr3c+zbBg=;
 b=n2YUkk/IFZUue9sjf+OVi/2S41hEWAfRZGwKbljNMfALsg3eXXr7zRCczkSlUdyrQSw5cUerYfGbrrFEuVALs/sTSR3ORXinJjKOK+u8V0f4R4KwdoJRQDySY4HPHFiRa+Jb6mExcpy4KuGYIBRARgKtDQmjJtLoIc9FSX2ekarVFSmOA2z2j5PXH7K7iWzJGYLfb8wFYvcS+iPtx4zmfUXwWdYl4hJityDKdWMTQKucGVNQHPhV2JOz7P3qh9g308uIxHx60snw9TT3LccCzVaOYhnbi6pDLnkjhI/vfwp+R/fWQKDSKmqW5b6F6TjM4vJa4AdNcIO5yfz1x5VoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYw9NxYaQvA6Usuq0eEuI7kj7qKx3IwUA1sr3c+zbBg=;
 b=xAKpC45DdwlaeWz1rsYTAthZxj2yBj5qXCwBqTAMvHtAcmd3QTGVKR/ryLBSsQBiCWgjt+Y56UeTlChr+GfkITsDf6qmyVcNcL3YD2c7vPs9/bBc4/KlsePGwS41vU9xa7yp0iYA50+/CmkAJTkDHSxX0XcvU01mev4EcBj9jZw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6528.namprd10.prod.outlook.com (2603:10b6:510:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 17:04:50 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 17:04:50 +0000
Date: Fri, 6 Dec 2024 17:04:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, keescook@chromium.org, pedro.falcato@gmail.com,
        rdunlap@infradead.org
Subject: Re: [PATCH v1] mseal: move can_do_mseal to mseal.c
Message-ID: <f4c704bc-3b9a-48bb-b1dc-8a73d181223c@lucifer.local>
References: <20241206013934.2782793-1-jeffxu@google.com>
 <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
 <d710d812-3dc0-406f-ac47-a782673d3d07@lucifer.local>
 <CABi2SkWkUmBdsUYhr-cE181oh=medLG0iXgHk6TYEuPgztxqOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkWkUmBdsUYhr-cE181oh=medLG0iXgHk6TYEuPgztxqOw@mail.gmail.com>
X-ClientProxiedBy: LO4P302CA0005.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e30a91-1d9d-4819-e016-08dd161818c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFNFeVZ4d3AxckxoTXZDbFlkWVJESjJaZ0J4V1hGODEvTldLZ2x2WWc3UjZ6?=
 =?utf-8?B?c3pVMnVrMnFNTklnYmdFVU1oaVA1RG9FSGV2VFR6clpTZ3Q1UDdOdXd5eGl6?=
 =?utf-8?B?SmxmbjJwTkY0UzJ4YUVtYUcycVFJcmdDenVzTHAvOXNyRXhUdHc0dlY4ZDA0?=
 =?utf-8?B?ZnNiTmw4MzZHVUtEMkNZclFhbU9TVXdmVktYU3BRSDlOSHFsZVdSazFGdCti?=
 =?utf-8?B?clFRRkZ4Tmt4YXQ2ZFR6VGcraTBuaGcwYUZWT0p3cFVQQlI5UklxWjlPc3M4?=
 =?utf-8?B?Nk9sa2xrOUpQMDdtQjFjTWhkQnhsWEF6UHp5SCtUMHlkbDlibDlDSTRRVW1x?=
 =?utf-8?B?R29qOS82Qlpsbk53dnNvRHNCT1Z6QVRmdFFmakloTnJsVEtVaThudTN3SXBR?=
 =?utf-8?B?Wjk4MG4xT28zZ1JTUnJLY3BzOUpZQWpSYVlzb3JacnVpeGkxTkhEQlQ2cWQ3?=
 =?utf-8?B?bjRBdHBIa3ZVcE4zajFpQXRuKzNJRVMrdEZ5VExGUXNXbnJrN2JEVFNaWWhD?=
 =?utf-8?B?OFphYmo5N0VRRzg2NTVtVXpqRGdTMFBOODRVdWFCVXQ3QXhDb2hRSGZYYWlW?=
 =?utf-8?B?OE5CN2tmQmJOaEJYaVdtYWRFN3VWcXJTUDRZNzN2TWxjMXVIeWVxS0F4ZGVZ?=
 =?utf-8?B?WVlZMkVnN1NkVTlVY2R2elZGL0xnRHlGYlNWQmlVTnErVTJFVGhaZDJXOXNT?=
 =?utf-8?B?NWRBNVBSQTB0eEJibzdGelVjS1Vtc2dodEl6NnloL1RHdSt4cEowbGcyeDZP?=
 =?utf-8?B?ZC81bHhlWENwUmhyZjN4blJJOGM2SGtyeTRGREM1TEgxUlRHbnI0UkVZaSt5?=
 =?utf-8?B?TTVja29PNnd5RFRPL0pVenRsUmdYSUQwK2svL3czWWI4ZnVSMW1qcFdMR0VM?=
 =?utf-8?B?UTBTc0tzSkhkUml1NEswTnpFWTVnTVR4bmQzVmh2MGZ1TmJQcUlTNGtGN09P?=
 =?utf-8?B?aTIva0tmRnRDMXUvOFBiY2VDNTN3MCtQeWkxSmVCczlRcG9LcytGeHFUdDBo?=
 =?utf-8?B?UnY4dHBtbFhRVXc0THdCa09lRS9TYkphUUZiTUt3L3AzRTNybUprMUpnOWRx?=
 =?utf-8?B?NDZVNFo2K0FVbS9pU21SRTByamxlUTBKSUhqSzhOdmFzYnpQc3JrY0I4eHFi?=
 =?utf-8?B?R0ptWFFyRnU0MzJmR2RLampaamFVT293elRNZ1dLTVR4MGM4YzkxbmZlZFNO?=
 =?utf-8?B?a3M4YUdFQ2V1QzBEeTZ3bVlDWXBDQkMrVkZXa1pHOEhBWTBZanZ0UU4yTzYw?=
 =?utf-8?B?VUladFcxelR5Rk5YRkZwMHpoQmZEMEkzZkRVai9nNnZaQnAxRnZjaklXNlFw?=
 =?utf-8?B?bWpNbzNuemxIOEgvR1ByVVVTMGJlYnB3R1B0SVA5UUJ1bnUxRHVMamNSZmZH?=
 =?utf-8?B?YStIbU5JaDJCc0ZTZDFKdUxaOTF2K25nZFNmZG90L2NTT1hMTHdCV0w0UzdU?=
 =?utf-8?B?VmdNYTFVUDJTNUtScGFKVXNNaXlLQzVOS3JpemJ5cHZpSUxlMkJrSWIyeGhW?=
 =?utf-8?B?UHBaSGZSZ3RoL3JZcGFxVm5BZUI1aGtXdTBkUmI0QUtuUytLMGxZUlMzM3dw?=
 =?utf-8?B?MHhLRmFRcTd0M2MyRnFGaVd0Z3VEVi91NVlZZWxlVHcwV3QxWkpzbUJGZmts?=
 =?utf-8?B?ZWQ2NC9YTGFRdXRLSXljSmFlakNSWW44NUtaNjJMalVneGs2SDlNSFA0V0R5?=
 =?utf-8?B?ZnZaanlPTGNvS2IvN3llRXVPQkVKMHhjQzJrOCt0YnRlR0JzVkR3RytIQjF4?=
 =?utf-8?B?NzlvVTFwbDd0T2FadnNFRXRqY0FaanlYREJJVGowcWhpYThlRDRQYWVFdlR5?=
 =?utf-8?Q?BjQqocMuHXHHRlkSXAC51PyPHvXZ+1Zd0J5Qs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVhHWFpSQlNPU3dtZzJZOFJHa3lkaUdTc1FxaUpRNFEyYUZuL1JJZXlET2Fu?=
 =?utf-8?B?OCtxazRlR0g4SFVRZ2xienQwTGw3OExVeTRlbEVsZmpPS0lMYjdBRjFVL2ta?=
 =?utf-8?B?QklNWGlyTW9STE9NR0lVVGZGLzQ5R05kaVVZclpjZXFDcnFWUjl0YmswVVQz?=
 =?utf-8?B?alpIN0VwWDdBRVhrbzNYYVpXdnhYTDdRd2Q4bnM0RUc1a29kNTJFWmJDR0kv?=
 =?utf-8?B?TVBqLzBsWjRCb1hldVYyclZ1UWpoL3d6czAwYzVySllBYXp3Y0dDdmExdjky?=
 =?utf-8?B?S2hYMlhUMjdlSmRvbWRsTDFkd2ZqOERxOU9jVjZnOXh5ejlId1B0bHlrbFRJ?=
 =?utf-8?B?dkFsOU5FTUtZQnFxbzE5ZTRpUGo2NHY2UEt5ZDBJWS9HMVZOamxadnFlMC9o?=
 =?utf-8?B?Z1pHQVFJSVNKaE9seTdadlNYZ3FqcVZkVDVCcDU2d3BVN2RlN3ErbTV3NFR1?=
 =?utf-8?B?TGZTK013VTJWV25iSmJXZTdnOE5OQVM4OFptV0dzTElqZlJRdWRkZEtETVpL?=
 =?utf-8?B?UnVWL2ZGZzJpVlhDMDluVi9keVJHM05sdy9rRFBQQkJ2TU95TTZ0NWxWcU5O?=
 =?utf-8?B?aVpQRGR3YThMbHJUSzQwMXZOM3lBL3dFczcrT3NwcDAyanpTQ3IwYUQ1V24z?=
 =?utf-8?B?bVZYS0JWWCt0QWx2TzBZSjVITWtKdEM2WjFkNDhEaFFGMkVFTU5wL1MwenRx?=
 =?utf-8?B?OWdXY250djMxblBXb21oMjNGRWZDQVMvWU5NYitUd1hscEkxbTFjelVUSzll?=
 =?utf-8?B?bjlTc0JIUURRRXJaMmd3VzJjbHMrV2c4cS9XcTUrZmpXUWx5YzR4MHZ2d1Y4?=
 =?utf-8?B?WUxWU1piZ1M3SE5Vb1pWMm8yQW1Nb2EveVN1UEF5YTBmQU9IM1JiUm1DLzdL?=
 =?utf-8?B?blBFdzBsb1VHakpPb3h5U2JETmdXMS8yQlA1cVZoYjkydW1rUnMxN2E1TWxY?=
 =?utf-8?B?dUp2UjdlaGVzc0tBaXd2MTVTSWR5emYxS1Bvb3NqOE00Z29zYzJCdHB6R1BI?=
 =?utf-8?B?cEYyTUFDb0hkSlkyZzRYRW90Zm5Yb3MxcjhJaDNSNE1idXQyczhnOVdKNFJ6?=
 =?utf-8?B?YTg3blhiQktDNVgwcTgvaDlWeG1KTS9XUnhvV0VBbjdxSks0M2pIUGJPdVNm?=
 =?utf-8?B?SnVUZDczQ1o0MGM4NXlSM0ZmdXRxWXY3Qkl3amZNbmc1SG5zaUJuTWNnSDQr?=
 =?utf-8?B?WGdpdHMxbGZLVHc2MjNTUWg4Y3lEdDc5dUxIVnBJdHNlNmJoYnArbjJKbSt3?=
 =?utf-8?B?SEVQSnRSZnpsTjJDbWZBNzkvT1BkTG5BRzBxTFhidFJ6VUlWQjU0VFMzVDVR?=
 =?utf-8?B?S2hibUp1YVhBUXlsQkozUkpmcmdacG5WUS9iRlNhcWtkemJTb1dGYTlGSWU2?=
 =?utf-8?B?c1Rob2tKL0lsQVBkcVRkNkkwZGpmL3BlUm1BMTYram9GU2QzRVpaNWtGdTRm?=
 =?utf-8?B?NWRCdHBTNksyT1pyMlV0OUlqRUpUbHd1ZzlaWUhHZFQ4YXVFcUM1VzlVdHRp?=
 =?utf-8?B?S0hNeEJ6VEgyb043RjgzeWRWZXdwTGJEck9yaURSbzQ3Q0xpUUNFREw1SVBr?=
 =?utf-8?B?ZkFLQktmc3NKS3N5Z09MME51YjJicEd3Tk9GSVlPdVRaNnVCckg2V1MzK2Nl?=
 =?utf-8?B?bVJrT1NibGUvZXh3R0ZkcHM5cEQ3ZEIxanJqZFloNlMyTDNtajU1WUpyT2Rz?=
 =?utf-8?B?ZDhaaXJPZ1lHam9STU5oN01KS0N5emwra0xsck90Y3lDWGlyYm50TG9RbTRu?=
 =?utf-8?B?ek9oTnN3elE5T0V3NEcwUCtrTkJLZXE3MHplbHVFTWYxeHZZV1RoanRQUysw?=
 =?utf-8?B?M3gwV1cyVlN4eExEUWF2ZlVFd0c4Y0R3VExRZGFNK0ZWZnRVRW9XbEpIRnhh?=
 =?utf-8?B?MHZzbnE5RXlRQlJaOTdwd0ZBVGk3c2hyZGg0ZGd0UGdEc0F6aTNvN1FzdGJn?=
 =?utf-8?B?b3U5ZnZ6TE50d3VHd1A1ZHdLRkl2WkU0SSt6eU9VdFY2YTJSdmpXN1d1aDhD?=
 =?utf-8?B?WHJQMUVjSXNSNHI3cGhMZjYveVZHdVdQdURYaWxhVUJTSmQ2SUw3VkJwMkZF?=
 =?utf-8?B?WnFpQ2JHK1M4cGpBUmhSNHVhbjhXNUV1RzRmeUp5V1ZjRWU3b01oWGhzUDZ3?=
 =?utf-8?B?R0JZOUcyNDR6SStDNXRZRWt5USsrcFdoREJqSzlKNGtXaDVtbDU2WVNjdnFU?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xQ1deah0BbX1bYuNPguc2Ptm8aPPyfTJH7mWBPGLmNG4zNT7Jy6m43AO8MU7ZXdvTiQzU3ATNg+tg6LcsgaDBylkIPIYQhTUKcOxds+NUsTgk7sBJGbVTh+rut+cLOs5Y5duRnmfF5QCI1QWS6DkOIccZGpOj4vcZIpnogHInoaQcrNOxqlxwfvkoHIfnkevSlw+HQXkzFAy3wP/TfOxSaQdeX0RIkkPYIek6lqq8tohFGmwBnPT8/0swJ7i91mQIk3K3h4yhuItnbEHZCGRUTvEYf3KR07+l9Vku9Kp37N2mrTt/8IlWIzJD4MnK87sSw+ESnDj6S0jTosEuq6ZCEkSscItokXdEr1es3PHnW0by7eb1TYWpYXZadfWmR6Uzvlff7dlg9r2omPBWOfbqed/8IrXSOtoN58yJxdMAjtZaANlBw7BxAf9MQyi2DzRLj0hSjy00nXGzw1fNPyQERs6g7llgsj3LPIIbaLb3EFVgJngDDOfWbRvPvS/8cFnd/jzTVFbdoMcnpXe370r/fYNt9OBzSUWP6BLUqNVp6efAd7G7oYZ4+KTEG6KArwKhstcTIeWfNKOaGCcZ5Q1CBImDZapFO+UUwy/6BbvTRQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e30a91-1d9d-4819-e016-08dd161818c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 17:04:50.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvVuebas6vocbNeXC1ItQiLxDEgWiNet+ZbvAVzLfv5/6YRU/8d0wpqZ5SZW3esHZUd7GI4cHyfMpC7qQPTSfvzr0Z3h1AZV/pprNym0mZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_12,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060128
X-Proofpoint-GUID: JstG8h64KxQeDSFWaUAyAOimUPxW269W
X-Proofpoint-ORIG-GUID: JstG8h64KxQeDSFWaUAyAOimUPxW269W

On Fri, Dec 06, 2024 at 08:17:40AM -0800, Jeff Xu wrote:
> On Fri, Dec 6, 2024 at 1:13 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Dec 05, 2024 at 11:25:43PM -0500, Liam R. Howlett wrote:
> > > * jeffxu@chromium.org <jeffxu@chromium.org> [241205 20:39]:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > No code logic change.
> > > >
> > > > can_do_mseal is called exclusively by mseal.c,
> > > > and mseal.c is compiled only when CONFIG_64BIT flag is
> > > > set in makefile. Therefore, it is unnecessary to have
> > > > 32 bit stub function in the header file.
> > >
> > > There is no reason to keep this function at all; it is used in one
> > > place, and that place uses three lines of code as well.
> > >
> > > In fact, having it separate from the comment about flags being reserved
> > > makes the function very puzzling.
> >
> > I entirely agree. Jeff - please just make this inline to do_mseal():
> >
> Sure.

Thanks, appreciate it!

>
> >         ...
> >
> >         /* Flags are reserved. */
> >         if (flags)
> >                 retrun -EINVAL;
> >
> >         ...
> >
> > If you do that then cool I'm happy for this patch to be taken.
> >
> > An aside - I actually think we need to move the bulk of this code to
> > mm/vma.c - it makes absolutely no sense to keep the internals in this file,
> > and that way we can userland test mseal functionality.
> >
> Is there a past discussion to read ? That will help me understand your
> strategy of unit testing mm code.
> Moving everything to vma.c, will lose log history, e.g. blame no
> longer helps, did we consider alternatives ?

Re; git blame - I'm not sure what alternative you think exists, and I've
moved brk(), mmap(), etc. with a history spanning >30 years, so I'm not
sure what blame history you're concerned about given how recent mseal is :)

There is always code that gets moved or changed. You can't stay attached to
your name appearing on a git blame line.

Re: discussion, there's dozens of discussions and patch sets totalling ~3k
lines of code... just search lore for vma testing, or search through my
commits in mm/vma.c and you can see.

I can put together links if you really need, but I think say [0] is a good
motivating example of how I was able to actually write unit tests for VMA
merge functionality which previously could not exist.

In any case you can use the git blame -C option to 'see through' things like
code moves.

The whole point of this is to be able to _unit_ test functionality under
circumstances that might be otherwise improbable/incredibly difficult to
obtain if run as part of a kernel and self testing.

Importantly it allows us to conduct fuzzing testing in future, something
key and fundamental to security testing.

I would say for somebody who has clearly stated his huge commitment to
testing and how critically vital it is especially in the security realm,
this is entirely something that is beneficial to the kernel and to mseal
stability and security.

If you want to see it 'in action', you can run the tests in
tools/testing/vma via:

$ make && ./vma

[0]https://lore.kernel.org/linux-mm/1c7a0b43cfad2c511a6b1b52f3507696478ff51a.1725040657.git.lorenzo.stoakes@oracle.com/

Thanks, Lorenzo

>
>
> > I may submit a patch to this effect at some point.
> >
> > Thanks, Lorenzo
> >
> > >
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > ---
> > > >  mm/internal.h | 16 ----------------
> > > >  mm/mseal.c    |  8 ++++++++
> > > >  2 files changed, 8 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/mm/internal.h b/mm/internal.h
> > > > index 74dc1c48fa31..5e4ef5ce9c0a 100644
> > > > --- a/mm/internal.h
> > > > +++ b/mm/internal.h
> > > > @@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
> > > >  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
> > > >                       int priority);
> > > >
> > > > -#ifdef CONFIG_64BIT
> > > > -static inline int can_do_mseal(unsigned long flags)
> > > > -{
> > > > -   if (flags)
> > > > -           return -EINVAL;
> > > > -
> > > > -   return 0;
> > > > -}
> > > > -
> > > > -#else
> > > > -static inline int can_do_mseal(unsigned long flags)
> > > > -{
> > > > -   return -EPERM;
> > > > -}
> > > > -#endif
> > > > -
> > > >  #ifdef CONFIG_SHRINKER_DEBUG
> > > >  static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
> > > >                     struct shrinker *shrinker, const char *fmt, va_list ap)
> > > > diff --git a/mm/mseal.c b/mm/mseal.c
> > > > index 81d6e980e8a9..e167220a0bf0 100644
> > > > --- a/mm/mseal.c
> > > > +++ b/mm/mseal.c
> > > > @@ -158,6 +158,14 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
> > > >     return 0;
> > > >  }
> > > >
> > > > +static inline int can_do_mseal(unsigned long flags)
> >
> > It makes no sense for this to be inline.
> >
> > > > +{
> > > > +   if (flags)
> > > > +           return -EINVAL;
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +
> > > >  /*
> > > >   * mseal(2) seals the VM's meta data from
> > > >   * selected syscalls.
> > > > --
> > > > 2.47.0.338.g60cca15819-goog
> > > >
