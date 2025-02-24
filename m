Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387311F5FA;
	Mon, 24 Feb 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431140; cv=fail; b=Qc8UwJdWz2k8FZp5i3PmMqkbgNG9UiUCDp/zZUqpRAmA4fgUS4ZPXJuEy7JAuVfKqfzXOviK4cBnJYu87raehHPgeEByoTVfmWj+vzd0orQMaQ9JrwFb98SdrUNpphK0O/dciqmcIzZnysTR67HFbk/lZWM2ir7WLICNsYbCxyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431140; c=relaxed/simple;
	bh=eoaT2h38/YH4j3KYVBpHpTwQnu+LEr6wuq6IE7SDU14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZOgjI7bCJnV7oJaTItkm+V5lcvgLK7q13Bfhxkbgmfa/ij4OYtOVGpCMXeeXlbq2K9lJEb+i64w6oPkGh5QVFZzEZDQ4Da2YOJP8GBEdz5Cjwo4kJMoHu+MDAd+UZVDQVJ1CAbcuCnQpVz+tdMDWghC2qplwODQPRD+ubaIgis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WSGeLeMb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gngxPXnr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WSGeLeMb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gngxPXnr"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKfgTI016963;
	Mon, 24 Feb 2025 21:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=k9p7qUtUDQIUBztzU7
	LyIXGZRHGLtkW89cm2dulxQpg=; b=WSGeLeMbDg5t9XQFpCoe6mBa4FnROilbOX
	DgP0pOBFaUwFHmAF6EUgUGtfbMGDewfub9E0dDer5pluFmb5lHxM8LzEKZ96bGAL
	NBRyMugEQCPeHhw8mFDaGhjy7AgkUXzxf6/oA60R38Xn2ArgsBmgmTq++g8GqGbL
	Ntur17OGeNPnO6cXZaie0KsO5kkZACsDpcJ19oeEmwYvyLNx1ymEmFlgFbcL7ZnD
	CyxYEFQIEYFIWeKdHn95TEfsnjdFXRWTjbJ3KCNW1Vl3wtKHg565/f33gafbYBrf
	KYStV+grTpPIn1WzZEA+oqUjjE1kBJ800sl8Zqnyyjt2cJtPbmlw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gakm8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 21:04:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJZ11B007597;
	Mon, 24 Feb 2025 21:04:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51e977y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 21:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cshZ7cgRtw0VuvenGV5VTTT/ATou2nqsXaS+7QCSwAAbYGL4TmPiNNiVkHGbMM7qgW9KxZsIgpu9NwhwvoC7+3MHlG6Jcdz+SOTNrRkPZTETGwBuwrXf25keXuOchlyqerqLOwdNJ8gy4uZGLVsiuyTbwPE2aOcNBFYuDUYP5uEtsaf9+zPWEpODpbgHBem/na5lIWn55LoVGduhESW7WXJ1d3RH1LzU1qIRKUwMpzRAkt6mD203Gwq1XE9poLQ1Bpj6FHOdOORe7pOlNgpBoNy6AUyvIvTb1VHRgBZcDzc93CT4h0fGcqMI6mz7HCvQOaFoTSG4BmtXKunpjrTJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9p7qUtUDQIUBztzU7LyIXGZRHGLtkW89cm2dulxQpg=;
 b=CmhUU5M094ybhmgXsP1TCfFbUyzfkIJt5fq3jJGsPzuCIyGxzuWh1ViwY9M/ZrgD1AXZKXufCPvBf1wRpisij35NjchyTFXVhMucJUx8LVjUfrLdkFBz+hf78FBxHvxDak9XcxFj9yhmraQxNk54qo0sfoVQAuMLjs9GGO98JLYJQHyhAgXMBipMK3monkVvx1PmxtRoaAZPAQanIZ+VF5rSflGpjJkrRRu33WwfnCZ2n6FmaBqQIsu5E8gAtdiJEAfguTlGEQV2lSsZwwFDPego1HZsDjA+WMzwS6DoPnXpbwfEJ6QRrO8y192FaMyh7ah36k81YqI2Ogp3TFkgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9p7qUtUDQIUBztzU7LyIXGZRHGLtkW89cm2dulxQpg=;
 b=gngxPXnr0DOKgdDDVCLazF8d1zDHwUOxNasT2uOw0OOhEIzAJTsQGBLB4FbfLe5FmrXccLk8soAms5m37fu2QcAy/OniMjc/CSZmxMedYwwyrI+FhSuR1YR7xBIh0ZG89XYsUBaiu5PrKuMABCjwQtEoWDPRvz4tXN6edU0VQp0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 21:04:41 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 21:04:40 +0000
Date: Mon, 24 Feb 2025 16:04:34 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
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
Subject: Re: [PATCH v6 2/7] selftests: x86: test_mremap_vdso: skip if vdso is
 msealed
Message-ID: <6oak6ibdf7yxan3cos3brcqojgjeud4rhlii5nlrlmu7lckalk@zypcm67ac2vk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
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
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-3-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224174513.3600914-3-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3414c6-f68a-40f5-9af2-08dd5516dacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ft70tfyzSILfEQQ+wZH4Ww3DdAjr9FDRWl1SxzF2CiXz3MI9cFJkW/yt5nq2?=
 =?us-ascii?Q?tn8U3ziQestaIyCoLVcUy3hjUznTtQkNB6Y6lS8VS9S9t1Gds6i5F+iCqRLx?=
 =?us-ascii?Q?kRvzVFsKenvyznRqxhPpR4z90L//bLOpJ1Ljt73p6MitMZ7/iJh9/nLdDLXY?=
 =?us-ascii?Q?p3ycQLed51vgXnH+To32Wa4uUwIOc5vzUHfbrmCm3IAye/L5VACYOWu9749z?=
 =?us-ascii?Q?DoMJtm7mmS514BH1rmE9pe5ZJEDNmTN8/v8qtzaCTg5hPtR744gWqwVX8gmO?=
 =?us-ascii?Q?R78h0sJdMwBthGGDk6ivHivwxS/LDDj0IKWpagTdo22xYJgxOuJj8Ob9Wk8z?=
 =?us-ascii?Q?ZG+JsEbGjwpbmcX9bW8/vvMD7IPqsVoqO84jl+FFfWx2h6oz2AH63H6n+PsM?=
 =?us-ascii?Q?Hi+0tme5vYO2PK27en4Y3+f8xH5L4+p9wm8YJA4cjvQHhEGJ+Qv5Bm0PBafn?=
 =?us-ascii?Q?kgeh7QcEV962VmGMRItherae7CFnB05sduS8n0vN60i7p3/T5FfeVitXdkuU?=
 =?us-ascii?Q?xejdbRbQVQ8tJ0EDOg95dVKFtE89CP8FC5LcZDx+JcRpHmx/cG9SX3zH6cfi?=
 =?us-ascii?Q?Gl43Kaox3JV1ugGivWgJjFk7ol8GpSO78RmwHIvYepVbI61lqK6Hnp/rD3g/?=
 =?us-ascii?Q?aj4am78W9UDSJfXKbQwzMbS/jiR9Zz1aTVCg2ePLFyAhvtHMMNy6LsYb/fDM?=
 =?us-ascii?Q?WEIRPD3V89F5AZC1+6F6caWUDmFiWxoz1twRQxkXTvfb1ukaNE51RCwKGK4H?=
 =?us-ascii?Q?y0EhEIc1BWm9OIyNUFp6f6wWQcMUXg/jp+q+PFZPKrwijHr21UPk3XEWLQn5?=
 =?us-ascii?Q?Ymnf5JVwZ3JJh/rvJ3AhmxH3uJ3d97WCGb0hldeK9lCDyVbNFpaS9/A3wUtb?=
 =?us-ascii?Q?mkCE1jZnddYww82bwhcAEVhKMQmjajLLCJgaUmh7oT69iCGju7q3egmFONgr?=
 =?us-ascii?Q?LqhNO2yiktVg57Ht0WGW1y5JLfOLa4kjM41ep8eqas4MhUKrA8xVzvx/ptEX?=
 =?us-ascii?Q?+pgh7PhydE2albXdFhz3d1nY0J+mBZo3v4s1hvAewCwgrPf+M2G92PW7lsE+?=
 =?us-ascii?Q?LGIDyBwQlEcvN/yfM9G5lDYzww1h+Y2OJlmhdIrbQNA/km0moEL5XCqTv9gF?=
 =?us-ascii?Q?lVXy/yshFC+hz3G83Mz2GqmuBqAqGAZa4K/q6j7yB3QoN7rCLjCRr5Qhunyq?=
 =?us-ascii?Q?qvx6BGNNv3yfluGNDEPTISNj8mJ6FkkOh+XqBX8reMGv4ydyQswSpLDR7zjO?=
 =?us-ascii?Q?vdiYzMPO8gy1aNJJiMGFw1az+2WgAgFg8NpswA9L9aT3tS6aWshql7ailylW?=
 =?us-ascii?Q?3eluXIPIRmTlFapzJ948myXoloHdtb9ue8HolZm8pIaOALtwOaP+2wswp/vM?=
 =?us-ascii?Q?kH8QDs9qrECUBfx7NSq4yUPI1Gx9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mlm/QkCKTWiC0ZFt/Ed1+KUd3ddNbsJi7lIf0y8Cu27ERbGaSGJJSdmX0qks?=
 =?us-ascii?Q?59SH7PAKtENMGx7yedxQepFEe3qGn6wj11JZaLU7kmccOLgcmc5wqUcM7EoR?=
 =?us-ascii?Q?wjezcQ5tJtHuQT78MAcfpazr4K61lzq4miORJsYJpUyn+NIL53eEzJbmFP6h?=
 =?us-ascii?Q?CXh0K69Bu7MRUuIB4gF44UUKtjfeAftQpt7T1MJOHXxR+3qgTbxzN/Rvg/MV?=
 =?us-ascii?Q?GLh0mgyt7iFXXfuwZS55IUh4HePG6/OXD24A6K1FK0Oq4QDOrKfepdgqocLW?=
 =?us-ascii?Q?UnFqHkspSrTMoakErwtsnepTibOnxkpUqxG/2myw1Hy2+9tKY06qtXC0+21B?=
 =?us-ascii?Q?C8N7o34RCcKYMlpBwkrKtRHZXAZq7BBC4STBHRHTJfPs24qmzs/CBdSkpAJL?=
 =?us-ascii?Q?lJ/aSMlxGYRuFrrAtFmekv5xkea80gdGh++PCY3oMwj66dnLtAs1glum31/c?=
 =?us-ascii?Q?egf9I34YyxS9DF+mddNFmlub2eP0tiA5KxIRB7BcsFf5UmXbfDxdVdJdut08?=
 =?us-ascii?Q?H0xoVZBvsMOh1Lkkw32/2xbIgC5/AsmP0xHHNj1dP/hNP35vaWxMI7J17LUu?=
 =?us-ascii?Q?mw/RAUzDGkwTS/sM3xvBuE9HnY3cLFH6yCaRa9kYTaUX6miXdR6k0FrFzka8?=
 =?us-ascii?Q?dyE3O8qdh0n/j5q79BIxZpy9w/e0Q3pVZwq+sB/5KVL9fmeeWhG06y75iEvS?=
 =?us-ascii?Q?1Fx2NI009G6ZuIY3eqw140zkl3TMtjHofcPTY+j+yNkiuw8kxzAcy8XwldsJ?=
 =?us-ascii?Q?vsqosoCn/PIXsQ2DfnzTosdI8AJM4trCJcgPretSIkH6zB7if4GRc61+ifIn?=
 =?us-ascii?Q?NPagofXbJChUw15XPBp/ELvZGoFw2LJC+01bK7EKW4IKO/CUB/+Yvkk2tZ0B?=
 =?us-ascii?Q?ENDFdEMJ0WnGo1EFBhdOlyayFp0QMQiDv2C3JSs7+4xVHTV5QRthfNzt7CUT?=
 =?us-ascii?Q?z4ohxOdAtBRg4AXOUIhlFf8M0aHrPcLxpTSuSmStUhBleHkDb0TG1GFiJlhr?=
 =?us-ascii?Q?83/laso2t15Kvg2ZlZd/OOEd8Whtn/YdbP7Ydh+sOWWdicwxhm48cn/VAFjq?=
 =?us-ascii?Q?0ADAPKLSvpK1qpSgaSI5wNEXQch8i+z7jmAGaqafZvbWoCX9qbqSeHIjKaLE?=
 =?us-ascii?Q?IXsK9Lcb6STY+Ac5uOQBt+/CiS3X4HXEwaNwmo54lrmIVtijrc+N7locIg7s?=
 =?us-ascii?Q?nu1ImGvERjPl2sckV0Rne6S0wbk6kplu/pXnOQSosrZquFyPmlKBr/Gc1suV?=
 =?us-ascii?Q?AKGGFGs/yP2PcgW5jPgV9Q0DWr2mN+zd6eg6spLa1aT79Caj/2wFGIuoSyDQ?=
 =?us-ascii?Q?g91n5qnGJiWltiyOBpw3Aj7CqKg1hq4ibEY6b+tn2f+8QlpIOfUZe1acho8T?=
 =?us-ascii?Q?CbYqNWyiqy1y5FOPJOl3UyPAAHOqAvpgr+mQwtV7TLRlRhAn4irxqdkzPQZJ?=
 =?us-ascii?Q?qZl/aIEDOUvBzDSGa9ki0avn76sqkF4RB/w783Yf7EKqSoEKyyytuQQirAss?=
 =?us-ascii?Q?d89gYh/tX5oUG9eHpPU+ATczTB+UVxgjU57KFzUiW0V+UGy4Dr6MzEWRIs5j?=
 =?us-ascii?Q?0TyblvCeUKfh8RoDMFUy/Azw1353vxXFCo/6iHL6kNnMY2xUerYPeoo/FvDo?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O0s0PlDfRYDO3DWmNPE5S7H25ZMn2oKrBb/KOCvADKaXO6t6AnU/G6ARjyvU1stQXtcOqftLtDgxQTvNIJRHGIbVGFzxX7+I+LiTiDiSvijmy77hQcLW2LDnVwpVvr38BQlY1rZ/q+eHoo21PF3Ca+uANGzyY/J3smepsZ3JlWY1sh91MPlUpoXrOYwU3FTLh4iDgKZHOFB8XRI7CcUoEviiQTGWrnGcjzJKyUDZjkMBsAfcHLf4D7SM+DZRdBtjUjC8rI9B3zJAN+DscynRBfcjzWtLDSEZDmHMaUjkQPQ+O/yRIOdXdWSGN4hrpBRfSGV023PhTnK0gXxHwSmK2onar9CgBCZfPdKlW6gHroNHN+7Nh8FQQy3Xd6di5BfGd8CfnEL1spVogJIfIJ8WTztsYT/NkQUCpFLbbVJEw4ySSX1bE+/q3JIpSBd0++v5EMoOTmTUewdrMxwIZELd7wi9kpspLkzheLoFpgyKWxp+lGfMBXq31iH1qQDo4gtV6sIWgDdH/11KPgonP90/QOyr7dglhTxAmxICzOzJUKDGv9Cn8BgkVZqcVZOGkqlrt5VXDmbwH8AHkrUCrSZfrMi6O6TjVgs514okw88r1nM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3414c6-f68a-40f5-9af2-08dd5516dacc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:04:40.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddPh84D2cHJeze9x4R9CECd01nr3PaMvzjqpmlXMychQlfsJHiiu2Wznd9VCmmiHteqDockyO3PdDFCYG2TtuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240134
X-Proofpoint-ORIG-GUID: Sfypg2Lx0K6IPeu36BBbTkuzRPychcM2
X-Proofpoint-GUID: Sfypg2Lx0K6IPeu36BBbTkuzRPychcM2

* jeffxu@chromium.org <jeffxu@chromium.org> [250224 12:45]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add code to detect if the vdso is memory sealed, skip the test
> if it is.

It also skips the test if fopen fails on smaps, but maybe that's super
rare?

> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
> index d53959e03593..c68077c56b22 100644
> --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> @@ -14,6 +14,7 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <string.h>
> +#include <stdbool.h>
>  
>  #include <sys/mman.h>
>  #include <sys/auxv.h>
> @@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
>  
>  }
>  
> +#define VDSO_NAME "[vdso]"
> +#define VMFLAGS "VmFlags:"
> +#define MSEAL_FLAGS "sl"
> +#define MAX_LINE_LEN 512
> +
> +bool vdso_sealed(FILE *maps)
> +{
> +	char line[MAX_LINE_LEN];
> +	bool has_vdso = false;
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (strstr(line, VDSO_NAME))
> +			has_vdso = true;
> +
> +		if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> +			if (strstr(line, MSEAL_FLAGS))
> +				return true;
> +
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  int main(int argc, char **argv, char **envp)
>  {
>  	pid_t child;
> +	FILE *maps;
>  
>  	ksft_print_header();
>  	ksft_set_plan(1);
>  
> +	maps = fopen("/proc/self/smaps", "r");
> +	if (!maps) {
> +		ksft_test_result_skip("Could not open /proc/self/smaps\n");

fork() below prints errno, should this also print errno?

> +		return 0;

I guess the logic here is that you might fail later because it's sealed
but you don't know?  Is this rare enough not to matter?

> +	}
> +
> +	if (vdso_sealed(maps)) {
> +		ksft_test_result_skip("vdso is sealed\n");
> +		return 0;
> +	}
> +

This file also has an #ifdef __i386__ later,  Using it here would
prevent unnecessary scanning of the maps file.  Probably not a big deal?

Do you need to close the maps file?

>  	child = fork();
>  	if (child == -1)
>  		ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 
