Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9E23C8D6;
	Wed, 26 Feb 2025 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594085; cv=fail; b=GuNUTq5PxoTEWFmAVqNwsexeLO+P22a9tepGAAqHpzOQ1QsAuuZiGiWCHfNVQrEwc6FcuosdUXHMLIwY2Gc1HaW3Rle7FvBzCnULgIsHOERPlbLccZnfp2MSTbFm9aWFKFJMEIIfNZmtHyBm85+wpg210E5IesopbhmHLYoOeGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594085; c=relaxed/simple;
	bh=AarKNmYnVgT4IhXyruH/aenq7zhgrpe1PkvOqn7UVfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tt5YvI+PyNC/wDHThN5dbPm56Ta3z/ugqC94rI8uHOS/62ikn8f8LTGG0HkB2MCJ0wgaugoUDZtdE8lft+ZvQOdoewF0mS8foTbYxVd0BYVfg2VKwc1mF2tg/IuJ+XxZ9hDU8toomWSRXGEFab0dboHcgj3tpQMii6SaMUVNJTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GmIcCK4Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GqGaht7p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GmIcCK4Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GqGaht7p"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QHtZTn031142;
	Wed, 26 Feb 2025 18:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ho3mRwAbIhkmU9Gja2
	2dYcNgwh9JF+7vaKoVxVMj/tU=; b=GmIcCK4Y5yaVS2i0yMfk22adAoolYEfug7
	X1ClgUIlTRcoze4atFEe3/YPT4O6rvJFqxriso343AJ+JlZo1GGTz1iGeaBFquLc
	a45VywcN/NoQh8OSxo3MO7qQ5AySmSubDZHZkDS6ivLNgXOgNp/G2r66Y3YQD/Rg
	o8fdt65r/V0Dq0w+LiSFkqIkxuRp+0zkHQaji2aOYMaNXW0Xj2AM8S/H8DtYQjAG
	/Dh21PGu3u4o2AiBawNd7lPoxoYiVtPvRkL45Xlgu53+UHU2kXiU94n0fCoP1lL5
	CcCfeXUtWsGrebCjj9DRW2yS78+iU8wpJng5irGihLNctsvm36iw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse9s2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 18:19:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QHVQuK002741;
	Wed, 26 Feb 2025 18:19:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51b9dtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 18:19:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvpooZ+FdVwYIeYO6MgMMHEPNUjqisj2RvR7McaqhZUV0RsOH5eC86dFd9S0dBMR8so8wSOT2duFErp6eJewkW8HCjq++a41ulRS3EwIvNTB9lGMcyRTKbluY3z8GwlQ79d6AIKDI727OYsAvAxHA5yvtsddO5KvRKLgya0sqQldgX+gHyXB8X1cuVA6oWuLzg1rBl0dqkbWVv6Amoje5Ka1MXsIMWw2qnH45+hiDMcU20it4KClXrrW3wQCfgeuySRoxtpvfe4RrFuUB84rSb5Ceds1eouPeEVyPZUhwsP2axQV9qIYP0p2x3VfOhNK6Q/HjzrV8wsKPITGwc01/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho3mRwAbIhkmU9Gja22dYcNgwh9JF+7vaKoVxVMj/tU=;
 b=r7qtE69HeEgq170vewPVTIZKd74c/HAL5ZmDqMlu5oCBJE2iuh7UZud+Wwg7gx3rpE5oJC3EZ8WTNoTeQsEiR3bKHK2C4CBn7d/Ku75a1LXsZVd2e3q+kLTfEBhdCt8Trmlr6yMVoofOJxrapgsT5BkNpD+XhDQVXxQDCzXX0k+wswZiTesr6lWP22zq7wyNVZkTqAczGLrqg4VohkoxzTmvOGy6b2HOpAptXGqqlMOnnXzxV52tXAddLcfsEa2HKjmCVhGb4KFtFtzloVipFg5TqXNg9Ucq28BpnnR7cIiSBIzFKmhFWxnVrMT1lnhHqaj8maz/oe1crpMWpOTPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho3mRwAbIhkmU9Gja22dYcNgwh9JF+7vaKoVxVMj/tU=;
 b=GqGaht7p4COOFn3xCBbel/RobU79st8vhW42eRxYN9iq+QDvi/tey30IcVj67IxaThlq6dCCBwVwEMIqqb6BEHLysEvpHciag+AVOAfUpX+/daK5StcCE2rHmr78rFPNvq1W/DW47TJa5Vj1bBLzE/6DhixBhhSOTvD9mg7MUnA=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 18:19:39 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 18:19:39 +0000
Date: Wed, 26 Feb 2025 13:19:18 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>, jeffxu@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        adhemerval.zanella@linaro.org, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Message-ID: <qhdax7njcpjfprjmp6l5nhg2ach4qzbhfevviw6fbevnsdwflf@7sauzehmu74t>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Oleg Nesterov <oleg@redhat.com>, jeffxu@chromium.org, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, adhemerval.zanella@linaro.org, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com>
 <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
 <20250226180135.GI8995@redhat.com>
 <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de201c5-8375-429d-965a-08dd569221c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ELV7CHXTQJMU1EEDyNE8+68I/bxnXcGwVoMRT5Yih3oUXE4mKYSo+mx75//Z?=
 =?us-ascii?Q?w2Pxab4eMina/HDjKdDvAxffRrhorfwlXqyevbNDvlu/tiAKF1Le7m17dzKM?=
 =?us-ascii?Q?n7dH6B+4X+O3C2tF61FGceUjhtt++pQhL7Rnb70Dy5l003Nwo+/9TieOJUhO?=
 =?us-ascii?Q?qdGRmtKPw8h/RVJdoAoBOchcgiJMzSMlJ09nscn6hud7I1dAW8rwAftKVh3J?=
 =?us-ascii?Q?igHKdZlKvED/WC98Um+FV54TkHB/wMP3YgZxQPJeLuDSaW5LzQmU8f930p3z?=
 =?us-ascii?Q?s6oOs3aotDZ71YD6rx0JjXaEUDioxt1W1vwVfFgwa9xu1FoMQvXxve5hiYmI?=
 =?us-ascii?Q?yZiwGhy532xFOqynlJjsCRVNkucCHzQIFFY9ke9Dl/CiFtoCqXGdY6TWMtNA?=
 =?us-ascii?Q?EVB+A0M564qgxX+5sGsX3MKMdlwNPexdqhoUYuqJBXBvYWNuo1Jz9Gl8KVfw?=
 =?us-ascii?Q?bJRr3bhTCBCsM1M2ZBg6yMf78tsefirOQIpj9v283ZGUaIHZsj1LmR0tiVk8?=
 =?us-ascii?Q?RQBdGO4F7CPMsvWMeGeJY5kjZLJce+4QAgvOf8Ep6v0Az0g4eS1E4qjKGsWT?=
 =?us-ascii?Q?LC7mFplmALPGxbry95kEbvVWZvIBVmlBxw7q1JwSsCid41Ml4pngQbn9BPKp?=
 =?us-ascii?Q?jVwn89FrC50i4TnWbdPIwrfdv7cTvc+SH+KdWKI1OnPqCXCG4SvizOuqZvMB?=
 =?us-ascii?Q?mnH3PVsUDYnJBd4eQuECkaxzdSZtrOzySndTWL5L92LjF7B2/YFKHQi0OAix?=
 =?us-ascii?Q?U/FXmk0c/+yVo2lTW/LlMl5JkjWsGc6jaG/z+k5upasG2HFxpw1VSiRbC6gz?=
 =?us-ascii?Q?RsP2t1STyk/QxaV11PmJWGi18WdAsKmk3HtQmWa9ZqGTWn+MTqfN3WY+zeY9?=
 =?us-ascii?Q?g62LecCZKrKpxtmbvc76Dz9/KFU/yn0tBmk3KhXsM5TrgFHOD/uFfj10MRb/?=
 =?us-ascii?Q?0i4aPwz4DVt5kmFDWAd0OcGV9Bm1TsQA3DlJ4kytsn+4dqUi/tO6j4NUpyD1?=
 =?us-ascii?Q?E3YkDh1hvcflQDb9UJ/gG4yqegNB9P7XOXpAExQCQepIEBC0CFpDd9PmhiTp?=
 =?us-ascii?Q?k5kElafvvCH/JjJO+gVd/XmiL0B56fFecpbguNUKUwE1t7jSgsPc87p0wGTU?=
 =?us-ascii?Q?J/Q7TdaLHZBmkBdt0QQuwGgPUx4P7dX8pYvQG8J45yrSB/HIDCYGrp9hGf2k?=
 =?us-ascii?Q?dVjhdDxcrHoa7XMozOlLGfg37S4PpvmK/8SR4nJRPBWFEI0HtmBqCrq67SdZ?=
 =?us-ascii?Q?tIeov1WdtkhWljFs8aekc2PrhoHWXhRKqQrliqT26pgAxqFRGqc+zm+ypH1v?=
 =?us-ascii?Q?Mg+sQrDo5DH0C7w8XzumG9t3JX0HhM2JoNjEMok1mu1HQIkyPg3LVq28Ksx8?=
 =?us-ascii?Q?bx3qwUzMu8R6Eq8bOAhk74vXkN/a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SCOIlJdwtwyuL/u0KW3UoiLijm6Vu0G0z9aWmOEmur20T9dyN2d4OszlFPkE?=
 =?us-ascii?Q?F5cGv0nNA6IHxvXu0Rg6a1poaw8h3q+LJkEgRuleHQAxWudZ8/WiAwdeROHl?=
 =?us-ascii?Q?tDwOoS2G0ImpLEPCT9vOtE5GHMrwNHxKSqvsiKaS2gPpBh3ooHC/KsnQF1Hr?=
 =?us-ascii?Q?jTjqksJ1FsAnij7cmd6dUadbpd9aR6zmy+6hxoIdYmmexuICee6LEhIpmAVt?=
 =?us-ascii?Q?HYvywlw5XkoJcXBZLiWZ2mX7r1dSqjg5YgqVzx9lLMtC9Dnb4OVG/F1G2bZB?=
 =?us-ascii?Q?gJJjt1s8nrGX9tPjtnxSZoXB6mxv/ypSBf/ropoHtKgXPQxvX0ODLG627WYb?=
 =?us-ascii?Q?EGrWx+PPxSY+CZTobLuYJIKVaaJkiyNFz6bYUkhe9WXwwcPzGT/iQAE1Gzt8?=
 =?us-ascii?Q?w1PnuavHWAkqV5a11bLlCUm5WsEOtA2atkKtD/AyWgEoSVQPv3NIImlZY+KJ?=
 =?us-ascii?Q?b0JeKfWY2pLBHJv0mfDhnoxQ60KIYJkssztjIKC6xLo7TOGBAo2FWP3A7lcQ?=
 =?us-ascii?Q?LLQDzagEiTgJm99dUxSE6XQ9qqfcxZJzSeYDccXAfFgB7IpFAHOs94Z8H++s?=
 =?us-ascii?Q?qCYnuHtcCa7Xxd7g82c9vZmZU8M0fhJlO+9W9tzXyWX4PugcC3lnrFY/bAKT?=
 =?us-ascii?Q?ntp5k8CDaSPIcIFpmk23z3FE3VJdDdSbbjf3YOxVpckgb/Jixv+VUJVn3rJG?=
 =?us-ascii?Q?Cv3eaeBazVjMBvXm0kGJYhJc3aPuvUk+0Wj7KzI2f+9TyICt8od72ivOCZ3F?=
 =?us-ascii?Q?CgtaqcT6u/MG1M9wAKQuS1ZN1hKPl43ITFBxQhN4QsbqYwJnuF8lvjd76tUv?=
 =?us-ascii?Q?Jdv2wVqyAm7jO8fybJLRK6UvukoRJ2U3XPJQKWtF50//BFOn32sJm/iyZX7u?=
 =?us-ascii?Q?46UIz3kd6z4IpSK9QkgZt7rAFCfQCRHe071e5QwNbKDa6kiYx/Hfbrnw3a5i?=
 =?us-ascii?Q?7ME/vP9nqgCwmtwOBu4Q74AWzaT2fboN2IrchKJxKZLF9AJHsq2Rp4letr6m?=
 =?us-ascii?Q?/uWyVXrfZ6U75J45vBpN/5vjPue/B2znbLZlhxDm7K385o+yac/I5jmMdvJg?=
 =?us-ascii?Q?cNq8o4t9JyiNQ1zcVY+f+AvM1GhiAWqm0Uly0jJBehUFxBbmL/j8rEUW3d6X?=
 =?us-ascii?Q?T1UX1NcMEw2QyJolBVcxB6a2PEQ4nUDzvgrW9gD0AQPyW2NYPJSn9yLOBSRL?=
 =?us-ascii?Q?miIcls9HHnwfCvEdXfrQGS8sdUxb0LTtBm9RWkU3mMfu2IGO7h7UtKAx/7wD?=
 =?us-ascii?Q?05GZjt17rUI+cXw1H+vc8JaN6OGKvzLsy+kKzywp5MVNrgXhTYzzG83HcfqT?=
 =?us-ascii?Q?7swkWWjDoasaiR8Og1kjVSisSQr2aJ10KHsmS48VNh8+f5JWrNsjCXh2dCRG?=
 =?us-ascii?Q?uowVvzWLy5KfBwoQnvwQEuOOOjkK1UWJ76POp7ueK54LVCL0U2za20maUyCJ?=
 =?us-ascii?Q?CMsdUaWvCCrbWTifBpsJ8biyJwauDbOjaSap5iLOZ826OqYcZZgI/DkycuKo?=
 =?us-ascii?Q?3L3/ppXFyS5PWPbQ87kKxyvybFHT+Fd90tscmxoOj72WXcn1Ms2a/WF1FBR7?=
 =?us-ascii?Q?PwjHgaqzCC3cwK9X6fBkT1TPH2GNQqLYB8QahNIo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r+aSDsqH22FFMJ4NBemvCVwKGwu862zZ4uV2PE1J1mw/Ov7WewowIeNS/jpQrRxCpxz1MkKO3eU0NDa1IquuSMWVbNXhis7ERTtz0KAHTn/pWAyyiS0UzM0N4TmRYD33CvUXQb6/nBbc60D9FV4LPNeN5UtMxz27pP5raQRAYDuP8UdKkNOWw/pDeoge+741BhBl33ksXd3uwJOk0JMer5eZk4xVXT0hTmBHQ3nC8yjehm1Xa6PKultoZhgknQzJUDtwPLeDRyZ3bWf1+TMTSRmvHVioksATLuqQDb6F99L2ga8PwrFVLOiTkhyWVc4WHYIVur0tgtZTP4hxsfmAW+ZRLjMxuCk5dDdrVTmnjU6hUX6ArsdDigVVfbPPyxvznwmmp/kh/30z/Vd/IDbFyG+wl4twSmF9jtLtN4cmnxWoPuQWrEfpP9VUnu7Q19HeilpJF3a8mQiV5yQa6b1d6zCvdudR2eyPBDc16syFw30uVYanJJnITTm8IAdZcUnakkRPrTTM9YzGcPXmTwzXx3v+wmWHe1L6m5+2g3YWWefa7y7TBOdtAdmG7lzyIt2pzYMmVqaFBeuLORxK06sBCIp7g07EPYT0TWA7wKEOWsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de201c5-8375-429d-965a-08dd569221c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 18:19:38.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPpYF7Wm/PBTr+QeXvo6AWSiUgwSotrF7sXb/w23YrEt7kOk6uP7jWo8Ki6oXzVDs6JexxKgbeN8oMkBBFbyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260144
X-Proofpoint-GUID: wX7IgNhRW4Doy4cDzjY1C7YUaj3dNQwX
X-Proofpoint-ORIG-GUID: wX7IgNhRW4Doy4cDzjY1C7YUaj3dNQwX

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250226 13:06]:
> On Wed, Feb 26, 2025 at 07:01:36PM +0100, Oleg Nesterov wrote:
> > On 02/26, Lorenzo Stoakes wrote:
> > >
> > > On Wed, Feb 26, 2025 at 05:26:04PM +0100, Oleg Nesterov wrote:
> > > > On 02/24, jeffxu@chromium.org wrote:
> > > > >
> > > > > Unlike other system mappings, the uprobe mapping is not
> > > > > established during program startup. However, its lifetime is the same
> > > > > as the process's lifetime. It could be sealed from creation.
> > > >
> > > > Agreed, VM_SEALED should be always for the "[uprobes]" vma, regardless
> > > > of config options.
> > >
> > > If you think this ought to be the case generally, then perhaps we should
> > > drop this patch from the commit and just do this separately as a
> > > permanent-on thing, if you are sure this is fine + want it?
> >
> > See below...
> >
> > > An aside - we _definitely_ cannot allow this -system mapping stuff- to be
> > > enabled without a config option,
> >
> > This is clear.
> >
> > But as for uprobes in particular I do think that VM_SEALED is always fine.
> >
> > Do we really want it? I dunno. If a task unmaps its "[uprobes]" vma it
> > will crash when it hits the uprobes bp next time. Unless the probed insn
> > can be emulated and it is not ret-probe. Do we really care? Again, I don't
> > know.
> >
> > Should this change come as a separate patch? I don't understand why it should
> > but I am fine either way.
> >
> > In short. please do what you think is right,  VM_SEALED can't hurt uprobes ;)
> >
> > > > 	#ifdef CONFIG_64BIT
> > > > 	/* VM is sealed, in vm_flags */
> > > > 	#define VM_SEALED	_BITUL(63)
> > > > +	#else
> > > > +	#define VM_SEALED	0

nit, we have VM_NONE for this (it's also 0, so no real difference)

> > > > 	#endif
> > >
> > > This has been raised a few times. Jeff objects to this
> >
> > OK,
> >
> > > > and then simply
> > > >
> > > > 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > > > -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> > > > +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED,
> > > >
> > > > ?
> > >
> > > Nah you'd have to do:
> > >
> > >
> > > > 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > > 				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO
> > > #ifdef CONFIG_64BIT
> > > 				VM_SEALED
> > > #endif
> > > 				,
> >
> > Why??? With the proposed change above VM_SEALED == 0 if !CONFIG_64BIT.
> >
> 
> Like I said, Jeff opposes the change. I disagree with him, and agree with you,
> because this is very silly.

Discussion here [1].

> 
> But I don't want to hold up this series with that discussion (this is for his
> sake...)
> 
> > Oleg.
> >
> 
> Jeff - perhaps drop this and let's return to it in a follow up so this series
> isn't held up?
> 

...

Thanks,
Liam

[1]. https://lore.kernel.org/all/CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com/
