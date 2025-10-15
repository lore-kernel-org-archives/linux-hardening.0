Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E92F90C4
	for <linux-hardening@vger.kernel.org>; Wed, 15 Oct 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563765; cv=fail; b=exYW1nxuCHIqBQBHsyEGhA8akdKKqIfXrNLw05vf9h0XxaVffzkraOeI1W9YcSaiIjhxeHi1/Qfu9ooMjJNMdejSPVz4qjXydRfFHE+HdXZqniA5DaPTtPUvXwsZVi13CEGIGvP8YoxWU8oYXUy4qToF0ZoqTaoyrNVhQpg3qM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563765; c=relaxed/simple;
	bh=dCGswu+dO8A5+iG1xIR/NKgiZw6drtgXxASYo3aDvuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mX6ljZW6L5XIwN0HNV6fy1UjeGL4IljppojEYCFuBvWZuQx6ox2VsVkTFRXVv1jQ+/i+eD1AFW3y9wOY+XPUZa4Wy+IGSWOo1YmkzyCJ4Vx17uJDgNK9KMGihePXG1mV/ffMqbdNCEWV0rFKIxCr7RBzZ8ymofYhOYldApnHCRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U7j/T2yH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NOJFrpoF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U7j/T2yH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NOJFrpoF"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJx233005074;
	Wed, 15 Oct 2025 21:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=k0btioRZUZ+ebVBG9F8bg3OW8X2UXVG7iGyNYRT88xA=; b=
	U7j/T2yHJYvkQbTN2prMnIZG811Go0DjOPalFHW3L3MUzRsTyOISnAnm97TKr/Wd
	LoZb/4LLq0kgKpfbF7Wg1nch3zYBJrBz/vYQ94EkqWiHXkNIaMwmiLnvDS4xPGuk
	MjIuBXh60o/Jenh5cbdmO/ns40B7D9Ix7nfnMthkCmopFEACrpzw+EDQNLL4dfB6
	5Fm/iQ+mjynOypx2Q5CjvYLdrrBTy9offg5HiR8m6t+onUW5js7uKBibUl4iU3jZ
	1gX/Esh/T/SJz4RoX9x7PnjTvpsEvM2eVMhq56tjZNU/p8fNKOWMdy8Ombit4VjJ
	J0UXoEE6r5P9tPwSn5fQ1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsryheq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 21:29:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59FLGPL5037915;
	Wed, 15 Oct 2025 21:29:09 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpgwecx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 21:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywqyW+HoDAmwafP+sZx9qadrB8Gv2KK+2HlOLZREcJ7Gg8KcDO3V2azayhzAJr67m+phG4qanOcLJ/FTHOrei+0ZErzNaEHgo+8G1VaEOP+M1iakt/EFyvRu8eI7X59ualGbehnWsIhwLidjo0fFIoZ+m6+RvYQwgPvRjgzxQW0vBYpdvHXC29ua6hV6F4ySpkNx18AZMujSLcVCDk8JtC++Eg/ZUtU8hg07h7G+Q4U3oiRwSFAletJ/ejwv/10qyUnkBQoq33TiE6E3jaxj4upAjfhn+8Wgyy0OV59U2KPNCTVFzOzSlnVJbGPzKL3mbGVd+mpaoFthjq2GIqQFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0btioRZUZ+ebVBG9F8bg3OW8X2UXVG7iGyNYRT88xA=;
 b=rWABprOvMSK+bdrbsNAqxrBf33SjSSWWUT0LcASQ0fIIpn/ckIG5X5p8BrYr5Xm5rA4s0i9PPWwVoi6mNvaGW+kcu1OZGciji/1J6pwhBT7RNLnTQE+xVumsxcbzg8O2pH0UnywQbvB+4ILRKRh+3yb6gRj37ztIVRoGFhnNJcHZJ5Pgc1u5RXF1rUDuSiIMiyIc2d577DGZ1JFkwz7n5P7pxpcDJl1fId5Ht8bISuFvdvup45rVxq+pL716A7uCfgwNmSglHdT+IjuuljjL21HblmkWffFcUBBoFUihzltGDR3aSmBDScnPQ97V1RJWWDLlK2LyGR/8wsxQnfdngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0btioRZUZ+ebVBG9F8bg3OW8X2UXVG7iGyNYRT88xA=;
 b=NOJFrpoF9mHgOIWZCHQiHVCScQUJSAfSLkOkhcFjvl+nPol5mL9wmZUdBU9JCZNyXTAmiIijl4VD1WAypXyvK3NgSPmH769apdxcLjmyoVp9KVfGwQeWV6bSA2tRVyTgryoyhJ+zs673hY9f5RnAWOT2LjUvdAdm7LgFksxXd9Y=
Received: from CY5PR10MB6011.namprd10.prod.outlook.com (2603:10b6:930:28::16)
 by DS0PR10MB7221.namprd10.prod.outlook.com (2603:10b6:8:f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 21:29:04 +0000
Received: from CY5PR10MB6011.namprd10.prod.outlook.com
 ([fe80::3aca:a3f6:e92f:782e]) by CY5PR10MB6011.namprd10.prod.outlook.com
 ([fe80::3aca:a3f6:e92f:782e%5]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 21:29:04 +0000
Message-ID: <6edbe975-fe81-4925-a759-a4163d2615c7@oracle.com>
Date: Thu, 16 Oct 2025 00:28:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
To: Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>
Cc: Claudiu Zissulescu <claziss@gmail.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <20250826042212.work.202-kees@kernel.org>
 <D882BBEB-31E0-48A9-A595-BC5B47EE4899@oracle.com>
 <d146466d-e5b6-450d-8b6c-c27ecc87b310@oracle.com>
 <7DFF075D-A922-4170-9199-0B1B477D79F3@oracle.com>
 <202510151420.340ED16A9@keescook>
Content-Language: en-US
From: Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>
In-Reply-To: <202510151420.340ED16A9@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0092.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::21) To CY5PR10MB6011.namprd10.prod.outlook.com
 (2603:10b6:930:28::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6011:EE_|DS0PR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 85248365-61e2-4c3d-c02c-08de0c31dd8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWNvUkVhNXFvd1BjdXZTZGZMRHUvQlVtcWk4bCsrc01xd1FMV2Z2VWNJZ1dz?=
 =?utf-8?B?MURoalN1dm56L25hWi9IVWFZTVYwRzFYejJOTUc3bUk2MkYxYVJmcU9YNkJh?=
 =?utf-8?B?Y011WWlCUHp3Q0dTcjh1akNqS29lTnM4aytleXFXRXZVOWhSWXVKRFVrcnVJ?=
 =?utf-8?B?Z2VTNDR2Z0ljdDBnVGN5c05xMzltYXdvakZhYW01OFNneityUlluKzArR1JE?=
 =?utf-8?B?djBUR25BS2FxcERZM1JpWmIzR1hCb0ZXTC9xek9neVVmd295QU9sR3VZcUw3?=
 =?utf-8?B?NjI3SDViMTNYWERNdVQ5N3pHbG15dmQ1MkhTRTV2MjBnOUdzRThMTXVPbmJN?=
 =?utf-8?B?RDM0d08xUlFmN3dIS3B5a3BsM3dLVTlPQkp2UEtOWWNGcDNYSFprWEhmNzlR?=
 =?utf-8?B?WlAyb0MxR3k0c2V6Q1JPUHhQdDI2UDJlVXlPNkNOTVoxd00rSXU5b1lVbGNz?=
 =?utf-8?B?MDBIMXpGS1JpNkZ3cy9xb3RJTjZQMzAzaHNPNjFnQ3Z4VU56aitqNkw0OFNX?=
 =?utf-8?B?Wkxoblc0QkhndWovQUx1R1BzSDZuLzV0U1hkK05UaUo3SVF0U2s5Nkw1NVlR?=
 =?utf-8?B?QmpNcWxXaXMwakY3T2llYmI3TDJJNEY3c1pqNzMzR0c4VGtheW85ZUhDcndC?=
 =?utf-8?B?WUNaeWIvb2l2WldSem0wMko0aGhhdm9vWVJ4N3N2OVI5RFNDcVNEVWFjN3c0?=
 =?utf-8?B?WUdLZWxKa2sySG12WnNySWlRc2JlZDV2SFpaaUJ3MHZrQ09PRW9BVVQyQjBn?=
 =?utf-8?B?RkM3L3pjTHR3aXA1cVZ1aGhuODJReGk0a2lvZ3ZTblkzU0M4MmtnaS9QUkpQ?=
 =?utf-8?B?UkM5cmtiQldKcEtpTFEvSGVnVjBTOGVpSVlEWkIxMm1ST09OTXlyb2ltQkp2?=
 =?utf-8?B?QXZ5WGVzL1E3K3RlSTdyM3g5QzhqWDhCTjRtd0tVSW9OVnhyQlBTaGRaQ2Rk?=
 =?utf-8?B?NmFLRGRSVmk5cHltVklhS0RDQzdKUmFKbFZEbExrclhONlF3ampmQ1ZFUkhK?=
 =?utf-8?B?N1dwTmQ2bTZQeStaMTRGZWZOSUpFbERsSWtUdnM2MUdXd3FwRWpGUEhOT0lZ?=
 =?utf-8?B?OU5BZzhyYWl4bGp2dWNkRC9vQlF4NkhOdVc1UzhqYjRDelBsdE5RbHMydm5q?=
 =?utf-8?B?M2hwaHNzQW5uL2NhT1pxSG9VaVcxNFQ0SC9vQmxIM2FPR2pUZUR3R3dQNDU2?=
 =?utf-8?B?aysxTnoxRnBSNFRMMC9RelFkSW01Uk9JWHd2VzFRU2VHdHRUcmRCY1B5dU02?=
 =?utf-8?B?WHVKQUhvVjBFaVdHU2NjSjB0R2tBYk05Kzk3d01WcHIzMVZlT2V1THpzMjJj?=
 =?utf-8?B?UGk0NFNVdkloc25tRlNjK3lrMDltYzRzaTBORlJTeThXUHROYzYwNGcyNXl1?=
 =?utf-8?B?QVliWkFWQUZQSWYwOHhFUTRjWDBLZnd3ZXJnZHFCbjcxKzZ3bXZId2JoamtR?=
 =?utf-8?B?am1xUzQreXpHQSs2STgyUnE5T3M3WEFYcXBEa1ZuNFRNY3lpU1ZjVDVacjAr?=
 =?utf-8?B?MGhRbkwyLzJud2I0WHFBS1lNQk95S0dORFJHbDd1K1JKdUN2WERqa0I2YTlr?=
 =?utf-8?B?MGdFQ1B0R3ZtL3pGVktQd2MxY0tyeXhRbmJyUXBhVlVDdmZEYWpEVnB4bzhm?=
 =?utf-8?B?Q0g4ZDhWU25wQ3JIK2Y3MUZtVXgzdXFPOGZZWHpsTi9LaWs2NW9VS0FqV05i?=
 =?utf-8?B?TnBqa1VvYm5YMGZ5bmJpSjNYZGx2SXFpUndjU0QvVk1aRkloQ05pSmNVYmdk?=
 =?utf-8?B?ZUxZV2FoN1RzbDluM0tudnUrYzV0TldEM05VSytudmljcE13RlN4NUdMS1Z5?=
 =?utf-8?B?NG0yb0E1ZENTWkx4NkZEbDRVSVp2a1A2ZVJYRGtQamNVN3pvRDVnZkdneUZY?=
 =?utf-8?B?RmZkU3B2WEE1SGdpS0FZMDhnRGY2eWttMmVySkVxQVlVSFVPVjFPUVlXV3JZ?=
 =?utf-8?Q?RLl8P2m6dgHKgz5ysFLTXpeImINDetIm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU92amxVeVNjYVNXTDlOUHVIVlN5UndPenFoVnVaTHNVMU9WN2xsd3F6dU4z?=
 =?utf-8?B?dVhYK3NpaGJiTVR0SVpNZCtTYncxMHR3OGlTQ3NQS3BycWxyT0gyeHVHQzNz?=
 =?utf-8?B?aThkTzE2L1dwTEMvdXJaUHFyUEpWWVp3RlBVYXd3MHpMV0xPR2diM2hHZjBF?=
 =?utf-8?B?L3Z1a2c3YkFPenJvUUsxWEFvVUZKSzFFdm9QSER3elpock1iNlgrcnJYblZW?=
 =?utf-8?B?ZjFqTFNDMTVJbG1TdlRRZnhqVzVSRmpTZE0xNEJKY0RHWXEvd1FlUGJ6WjZ0?=
 =?utf-8?B?ZUsvYjZkTUpIQUMrOTBBcGlYZ1hQRlZwYlhXOFJGL3ZzUjQwWk5aMHhXY1NH?=
 =?utf-8?B?bDZHL1hFM3QxWlhVSGNGNUVYbHlnL0VvVXNHTUUyM2FiR1hjNzhPNFh2d0E0?=
 =?utf-8?B?dlNhYXFrSGdNdWZGSUYwQjBxSmxKaWx3T29sUEl2K0k2RDc5TDJJVkE1NkMz?=
 =?utf-8?B?QlNuTWFOOGRuanFBcTJxeHZwaTZSSVJwckdZcG1ES2kyaHZHc1p0QzNpVzA2?=
 =?utf-8?B?Y1VBK0V4bUJKMnU2UmgzSUp5Z2lyc2ZDRVdjcjRlQjNoL1E2WWF2RkRndG1u?=
 =?utf-8?B?d2JPUWk1MWsrZkhxL0krMEFXVTdvRjNVbmFwWHQ1bllkazVac21MSEpmSnJ3?=
 =?utf-8?B?bkhIY2hKUkpXNG1pWlBEZkF3bVl6UHgvaXRqWDE1dGh2NGNLRWhUMWZuOEt2?=
 =?utf-8?B?YTFpTTFtZGJQWjh1c3pGMW9oK2dUSHBBRWxvQ1hBUWdRQmJsaTRYZGRNbytl?=
 =?utf-8?B?aktDVndQeXhTTlB4RnNaV3VocUEveUhhMWI5dWp0enRTNS9Tei9uL1N6MVBX?=
 =?utf-8?B?YTJVSTlDV1kwQnZpTFNZNmYyR2ZweFBubUhTNDJOdTdPOW9VZ0p3dzJWS2xy?=
 =?utf-8?B?TFhSQUtWd2lBMDZPbUd1Ym93anNCSWY1REx2UnpZUjc4dGtURTNmNHhBSGVT?=
 =?utf-8?B?QUtucStLRDd5aFM1ZjhnUzdVSmdLR0g1dVZoankzY3cxM0NrSjRXVjdXM0Vh?=
 =?utf-8?B?dkE5TU13bFQvRzZWY2J5OEc2NkJLZEpFdmZCb1VabTVzZTR0amV1TkFndVZq?=
 =?utf-8?B?N21RQnhVK2FtSFh0UitiVUNBbjZ4eU12NklzYmhZTDJmZWFZV29OYTNkM3lU?=
 =?utf-8?B?VUYrb1RiN240SWE1UklvRFprOWRsUDdlcGozZHJRZSs4V1o0R2oyMlFzL1hn?=
 =?utf-8?B?WHM5TW40WGg4eDkyeVVIRGFUa2lsUGlJSHlKSWh3VUFvSm9sL0Z0QURNRmd2?=
 =?utf-8?B?VThESGRQb0t6V2NzcjViMVRudTZyZWU4VGFyYy9QUHFuc08vM1llM0l3c1Bi?=
 =?utf-8?B?OWlEVGMwWHVLWXZwR1pKQ2R5SU1RZWZCV2tIbzZrL1lYdzZrWUhrOWsrV1o4?=
 =?utf-8?B?d1kzaTFMNTJ2aitheUVLdUM0R2xpSlRIWHlLZVJCMWE1MkZGVnJrT1dDdnMv?=
 =?utf-8?B?dVQrdEFaSk10VzZnY0FyQno1cEc2S2orNldXOXByYlRWQlZGMWFaN2V1bmRM?=
 =?utf-8?B?V09Ib3B3bktaYlgvWll1SExCcWVwbTRvT1V1eFRKaGJwV3hCOU1XRm95MXRh?=
 =?utf-8?B?TlZ2MExFbVFEcHpWUFpxcVVQRVhIUHZocDl3Y2dHZWFRK3l6NFIxaEVKRnNZ?=
 =?utf-8?B?SGYzOVJRL1pFYWt6cC8xTE43OHoySFF6Z0w0OCtORHBnazR5TVcySDM2TDFa?=
 =?utf-8?B?cFdHbjBsRDhscDJxRTdkTElYcXlqaFpNaVRiMzhaTzhqSmd1ZnZXY2lieCs5?=
 =?utf-8?B?TENOUURQWEdZdHZFMVhVYTdkazRTdEJJWmFMbm1KY1pnSUpacmluVFdsaWtv?=
 =?utf-8?B?T24wWU4vWkwwb1gzdTF3QVV3anQ4VlFuRGlYS2FxMC9HRUpFNytNekZUUE85?=
 =?utf-8?B?SXY1N1hidDJLVlJiSzI3SjN3eUtONXNGejdVQi9aVm1qemV6Q1RxZEcydm1C?=
 =?utf-8?B?ZmJFcTVsSTRoYXN2Mk9nbi9BZEpndktLcUdoamFqcG85Z0VWVCtKMjBQdy9p?=
 =?utf-8?B?cFlKNEhPTW9TTXV1aXpYNmo0Z3U0S3RRUzZZdjdMNmRrbm91TGxyR3FLTm1L?=
 =?utf-8?B?UkUxQjgrSjN1TGpqZjh4Yjk1RDh2akFYdERYUE1hV1h2blF6cWRSV08zQjhO?=
 =?utf-8?B?RkZLMDdJMEJWNHRBNFdQQ1lMZGRuckhtL2FONUR3V2k4MkpkSXlLcHIwL295?=
 =?utf-8?Q?hUjaj0lJfPW8bOMDiZ0V0y3wV6zq6GdFzTLtU5yBxZrs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kmB3Jehll31pS6/p7ol8Spk7dYxR0mzPQU+q44M2tRkB4bJM+65xCMG7Y6xgOL1cmGI+BFvvDoLFtoCKxR4OrvpMESiosMWsus/HvhHimG2ch0Vi2zmYo+gMKUwPqv75RmQzIKRyFY49zxoJDvm8Sj4h6/UlRwrkQmJp1lh7HneDqLvCa2YkKjTD4xV+r9LV+T6il5eh0IC+Qstf6UYfg2Oj1PqqSlH6n6Uqaq5EbLV+VKC1gDy9FM7ywrcFs2ENNdp/7DCkcnJvOC5oB3k6JUKhlyLPT4R9FSARcepXqCsfXK5W07ZUn3gxBd9AILWgRmvOxGaGjZeSItmOk97d5VG1Xjw47ztCvgLSdEE2wA8+piPO68uhLajOXUgTz97vm0ey3TQTO4rFFUAz3CK/657nniO/yNTiAQUP2PAE1E8XrfBl5jNIeTNuclCK33Hwu2pf3++8mCnVCmpVu6lAmFbLGZXhOygXPcC057+BmG61RbdkNcU3gYTK0t+7ndHJzNrVCtIcMk6KNE5Dyx45X9Jj1bsi7gidO5NL/KymPwX7znF0+FfsB867dYGgHFF43f1BcJQEA/EGc7hZgF+pX1rJ1yxpFCE5QNqin/yaU7k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85248365-61e2-4c3d-c02c-08de0c31dd8f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:29:04.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4tp//f79LsOMukmiEXxKSBsx0wRJLobrgPt+e3woYPnzob7uM25urip+lyyUBSRpMtAiK+Ad92RP5GuvdiGco0o/lbk6jbI8E/cmZtT7mZD1oFDNjLqtHy9gjwzNCHt5CoWssOtAmcJKbcSrPsinw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=871
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150163
X-Proofpoint-GUID: mPXM3E8PG24PAEPPuEy_-41X8hCMh4Eh
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68f01226 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NU5kEdxmNPGs0fOlqE0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX7S0OqYLNIwpY
 WDAkJijs5g4nYeYpNmpEeuq/x1y1/3O+KcFsn66o0rgRgF9JiHVHnfZs3/ran9KMXKS94GwoI6g
 yIV0gzmolTMrj6ars5SPm2lvas6MwvwfQaMzYvhBtPrFYYYtVQJ1sxUti2t9uY5jIJ4ZYU4BTZA
 y0dQ4YIFTR9RJIxj6f943/fWkGsXmwoTHhnH3htBzNM77R8l+OtvlgwzAEBDu5TmwZ5rbndnLY9
 62rlJQFCXXwzES8NZ/e7Kq5BmtLIOsexItyF76XgTwzKMs/Wu11i3Kp+QJdJq3Dmkg+0ltNY6h0
 xoeUGDqWQbTqbrZA2bpbKp0cJFd6sPt6VGvozISf4/Q5SMozJ7yNKEGuALQrmbfPFy4INmIsvy+
 sxeF2zOtaQqEGEh6VZUr0EVeVadS7V19k7lKwGXWbF9lrijvdrk=
X-Proofpoint-ORIG-GUID: mPXM3E8PG24PAEPPuEy_-41X8hCMh4Eh

It is difficult to do so, as there is no official qemu port for it.

I'll run a short check before committing your patch.

Cheers,
Claudiu

On 10/16/25 12:20 AM, Kees Cook wrote:
> On Wed, Oct 15, 2025 at 06:09:51PM +0000, Qing Zhao wrote:
>> Just want to make sure: have you done regression testing for this patch on a ARC machine already?
> 
> I have no such real hardware, but I've done Linux kernel builds with the
> resulting GCC ARC cross-compiler.
> 

