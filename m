Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4520ADE6;
	Wed, 12 Feb 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359549; cv=fail; b=urDJ16GmPFBSXnN4YfffU4yErvmv8t9qMR75B1yU+3EUGF5Kh/zCWP5OMiXjT+km4DOBsUjCdV1C38QMgMrG/bnQ232z5bP5UgJadHt000ZJsV0CPdlfpBYdAI5q41acKk6pFlGFzr8NPJiDm3rdccnO3xz40bDYNnck7eHoJ9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359549; c=relaxed/simple;
	bh=l9Jn0uecvHmRcsKWoETKu6Qhae84qWO7d9Msz1JtMek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U5abb6rU1fgy3g6C5VrY4H7fa4vEJk/ffeX8wlKfC5kSSGRWLOarrIo+YRwgbHx+qyK/ZWhibo/m2yN5d2sjP8TEzXKL2HQymt/Nvlw2S/IRpRWzg01pOu+rFvADv/3mrtGTIL+T+FxmoE/uASwc/QPQyiblhq40vToz8MzHtYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QcBNx+LS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rtLLivYu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QcBNx+LS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rtLLivYu"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C1BqjH030154;
	Wed, 12 Feb 2025 11:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Iqxghtz7BkkdOdkq80
	8CbmtD1YQGj1keFZZLwKIqTm0=; b=QcBNx+LSdNDpqb5wwors9qE1ah/koEOgw7
	+lv0vtjCV+T41BTFTiui+Ol5ZVEXDj+E6RGCPKeEbQHwTX+E3LrzHTFNV2J9Hx4R
	o24RM66OUzl/XE03HvgTaSJ86B5AAdNIvMasECOb4Wy8zFAwqQicJjOMO1RN3aXS
	aYLGxTyn6Z8FCJ/wphk/UAxPWZRWj+4Cgg2TQ/QNV/BUQuCnr/cju7Prqi/KF+G2
	/WhpvgnoTU7uls8xc501qfFpdbU3SZZSkSKdvbzkYvS6U5pZ468DZ+cRLOdPlDo0
	C3mMI8MZOz5BFJhRgqautjJNmcK1RC4PZLC/graXiemJbFJ9xqKg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2f61q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 11:24:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CBJo3R012768;
	Wed, 12 Feb 2025 11:24:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqa3vpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 11:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoupdL0rU248cYc/ucSqeNwSj+Set0Jr6nS2+kIoIfNqWUVAHrl2YOJg8vwttLw7Ah9lFGj3WjVdKHS9vEtCDiZY7d+OBEr70tijqR9gJom6npx4RO9siuYstdDBBojyfulav/+y20c7+BnfQge9Mjb7NdsX4sCtGZCLgZNHQwVbExu02/AyhP9UWWZYzqMWDuSshPKQUc9rPUF367lQ2g6IpXU48bH5wIEfFfzNPP7ZMQcOq/hcQCQkiJzaKaX3gRnfqS6oQEl5QMIFg5khkOmT+QvB+kEzJlAvJ9chQJyTrOIktFiR7vBf+EGPt3zhhL4UotRKx9hIYPjr5FLekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iqxghtz7BkkdOdkq808CbmtD1YQGj1keFZZLwKIqTm0=;
 b=Nk739z1kNcEt7hOX8LAQ7/ZoT4DgTi62YqbKwlkq8OLO7iH6gLEGTmHVk5n77hVNwXBQ0knJmgepOOAstlsv9JxJDHhBIDaSRf+O8OOjZq2cc0rdQVoS3gjYWi5k4UNr+KUsshJY/6uz79AQUiorRkPf1Qe5QBdU08KmmsHjuCF0PUk377XxCcabyu2249zdWxwWBFgIu52v6wPXBEH/MN1e36IGPDbTtequ6rzfS0Vosv3fmSrZZ+Wj0SDpm8b5Vvzm5TADvFee8h2FFc+m4drQXnKKx61Zc3vfoTquY5OUuh2rgY4rSgagr2MzqJQNLyMpVdN34WRIAI0n6jMJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iqxghtz7BkkdOdkq808CbmtD1YQGj1keFZZLwKIqTm0=;
 b=rtLLivYuUbhcs6xfkuyyGZPVPhpXVkM64EwXA5jxJATwjAFiHz+TslwQXg6rzYlF/j4UDUO1WxsUYnLKO8kzizydft4gOlUZzLo8jlUJfWi7R4wzYDCuEnevNZhzVsiLhgDyyyTxabJH4yZxZPYO87Xx+7PjLIw9kvu3qAnNgX8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6039.namprd10.prod.outlook.com (2603:10b6:8:b7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Wed, 12 Feb 2025 11:24:41 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Wed, 12 Feb 2025
 11:24:41 +0000
Date: Wed, 12 Feb 2025 11:24:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
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
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
Message-ID: <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
References: <20250212032155.1276806-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212032155.1276806-1-jeffxu@google.com>
X-ClientProxiedBy: LO0P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f4e7ab-b246-48f9-4cef-08dd4b57d7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+rGQIlrZB3F1r/NaK61fuwpp7beeZcyWVUalRkUmXikKxUCDtWLtlQLO8xiv?=
 =?us-ascii?Q?32V4aLiIfQ1nIpE8c3GFYZvrzYKIVoMHTCuR8Jjnmyj1TnXQ3AzF5Zq1Stec?=
 =?us-ascii?Q?L7SV0k62UNpwVl4/7BPv1ZJFTfuoNabSkase6GNjtGPhCbc//BkMO3h8N/m9?=
 =?us-ascii?Q?1aNwnUJLIOCIaUiEhEvPyUuoSbeaqr3+9auVLTC7wnEPY7dD8Xw8uY2IMYbS?=
 =?us-ascii?Q?A6X7EsU8risK2ecbeyHZ81+wnPL6/O+cb95o7hZW+K2CwIDMI7mrrSP+QwrL?=
 =?us-ascii?Q?/ccfmkVOqNdz6XcMwcT58VMSrbFrqMKcrqaYifjDE/SyNyN/UdnmXI/nTD5I?=
 =?us-ascii?Q?oQZnUjFRU1ZOI/84nv3CTVzJHVYbzC4jP4S58ol9UuwrPhVUgL199QRcCq6x?=
 =?us-ascii?Q?3ktD0AVRGN2OQakJKOrF6TQh7HEaWI35O+WpLBvYGpRopCMHMhHx4I8QqHAU?=
 =?us-ascii?Q?GKNwd+zkEULJtaxoGrj4ogMjCXLKfgw2P1KLhMx5hycyNy/BkCTb6OZhJ6OU?=
 =?us-ascii?Q?lorpCmFBobHrPuA+sEWWupB3RzaF7Byj4ZA4yfAt3zoEkpLMcPgQLrW+b7gm?=
 =?us-ascii?Q?M6kOFbXc3E8lLcRpOX5jQczQfd1iDE2a2VfzN/TPrmOl7UfVq8Rc1tfvBd10?=
 =?us-ascii?Q?a6tNEkRYz4IzgsQr4CithgQti1AY6EIDdaoT1KQvYh/OOkE9O61iAMFdKmUJ?=
 =?us-ascii?Q?R8jM/cPfKq/vSgmefTwCQbtt9Nm2HWlfGATEqCRfcw7iVB18MDzqe83Gt1P9?=
 =?us-ascii?Q?5cWfuvB4TzOucSPmakX/CFcfpdux5+576MqoOtK3cv8go/UtS8zNvYTNubYk?=
 =?us-ascii?Q?iqD/lguvzEP/qsdy682ULSP47DZAGIoKeesHdP4vcjY02538zr2TJiB1p/YE?=
 =?us-ascii?Q?bWr6uQzO8pjv4n4/fY1GkR++9zvbdrVm3yIVhrF3PwGOMD9S/HivijUcdvNY?=
 =?us-ascii?Q?/AuevgxcIpzDwSQEl2FHZWMJ2Ic3EQEikGzjh8mxNQA59mf4PSbUp3xIjvje?=
 =?us-ascii?Q?Yu6qNnSxyf1clPqA5rC5VtYTFRnMhhCX2Bg+q9gc/EVfN06ozf8EP0uw6aGY?=
 =?us-ascii?Q?GJxQs7mhgAFZJM0nB1YR/GcM6oMfTg82Uuk42nqGuBPRM4uCMklT1RJrm+5L?=
 =?us-ascii?Q?2prStEd1/j2qdb+gm9UW6uKfZ3zb5nt4I4rlKpyXrZKxZHOTyO1l4aiAN6Pd?=
 =?us-ascii?Q?n5D5ZLQfdHry3L5mtRhfKqx/Qabr5Aw893AP4ID5QC38lYFeKns4n4TXfmXF?=
 =?us-ascii?Q?UtbXzWEetPeE+wsmVj5asXO7B50Sz1z3LY8Twg/mE8BWxRptG2deU2yduFEe?=
 =?us-ascii?Q?Fr2+OWe6w7u+ULhlQcxWgSKUe+1fAItUhS3DFGma3HO5+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pIGZVdvWkOmRVz/I2NmSQIgXCDF0bK4LpSH8zvtIuRmKzaGGxtkBNPTH0UMv?=
 =?us-ascii?Q?FEljvCmE+TyWVQfKOv4hVkDcAwwiK0HBMZqBYjKxXBJWUGbVc1vRB2rgazS+?=
 =?us-ascii?Q?YdiPBR6P2bsBoYKZNriq05sSBYTwTGgwHqtxpVEDq3yduIwdckKQ+R/d8pp/?=
 =?us-ascii?Q?THKGAvlm5O9FaLiz0QC0SnCQkpFl+uti2Bco4oUM1Sovb9XMWEn04B7e2UgE?=
 =?us-ascii?Q?TJatxZ6VKUO9wdK6cM3pn9GvMM2tOw+88feypGznuGRYXVHziRZhxFRD+7WZ?=
 =?us-ascii?Q?PsYUbxpRQG5FQQavRcbi3cAzmd6+oe1iPa+8rqSZ5O6jm4oj2A0OcXZhXynm?=
 =?us-ascii?Q?oUQofXSIE3zHCJE9gbHY6LFCl7MIzBpGA6OoxY6DO8zMAA8cBWwBDutNao17?=
 =?us-ascii?Q?9w/8KxgNkzwm15GgB4W3wsdHFFekKBaYG2C+iEuKojDfHYn3pKlnGs3Y5eDI?=
 =?us-ascii?Q?xN4e8P5auiB7xxiDzIEKCUWTla5xNfS19HUNOD3s6MOHnXDcpk1zdq76O7pY?=
 =?us-ascii?Q?bawMIMnKQVOBeI9xA25pTYzi41MQwBpZQe/G+w0nt0C5Eb1qlfzFvNj7QMue?=
 =?us-ascii?Q?YWomWLIIB6LvSLMpSbKUJq4iak9kUtavE1H9alsab3Flrxo1/plkBQikHGUk?=
 =?us-ascii?Q?vqo89LGfSaFDXLvISOGIihV1w1KWvXQ7knJy9ue9vZQndS0y7R58N5EAfsTa?=
 =?us-ascii?Q?umky5jKa5/sVNfB5qVn8qQI8qtxzua5p+J3aqTSJkKsaWra5ypl/4eVKk1Re?=
 =?us-ascii?Q?xqbqPq0ury8HPSo3yXW+NxmSFxYKFGJsxzDZTgpdWrCr2O2+uEYM44AzV9HK?=
 =?us-ascii?Q?nPUsxpCu2pphVrDW2pN0g6dNXIyzkBfTXfgJbP/Gs0Eva/Y6PviEMJJmV2lW?=
 =?us-ascii?Q?IKOmdO1KnzZbtteaxArRHlv71XhucfzL9s2nD3mv0WORtPfmUKbUGU3JbC1w?=
 =?us-ascii?Q?JlAg2Ee9sFvDqitpJspwDwh7uRnMKEpKEEZyrVhNxhoaMl6XI8q5zB5WvR/m?=
 =?us-ascii?Q?6WOwGcEy8wA7AMCsfft/gYfbl7d2Nw1mxt0yuVHgwQuGAHlFYhtyPAzpozHS?=
 =?us-ascii?Q?UrH2wJt13P91u0OaHY5MP1CS03KlrDuC57htceMYmeQTWiRIyQt0e70CkGrb?=
 =?us-ascii?Q?OKM/rzjXaKLx0yr7jilM/ZCtCFz3Y4Gwqwi/IZIR+vSKgZ5f/uLgQF5iIc35?=
 =?us-ascii?Q?1DjzgdV2mL3XWeVIFgE0sABbqE6Io6tnl6X3ezM/fN2kreYZdHZCjAWB7Bg3?=
 =?us-ascii?Q?Fv/N1B6fZ5t8/8H4Ur5y5RLuTQpwZeOJse7etPWLPZsCqvsiZ56G0F9wejTm?=
 =?us-ascii?Q?Gz/mBjnubvA5bHNiPNfC0kiPOZb4CoFitndoKHKG8gPEK4Wt9x/taJ4spSwp?=
 =?us-ascii?Q?7MmMV8UGnIfimlIaZLQ8/TLxUt2OEWeMBKKW51IhUJxmDKlfUw7YJHr3VjY8?=
 =?us-ascii?Q?13GsVwljuFxoSVBcZIR2tmhcdY7lkmOJMdngL/Fxhu9MU0+TwKqiBjJ6YjA5?=
 =?us-ascii?Q?+6CGO8UJxGcOVHd7wCRKnDwPI524LeiWazAOKL8BA9OxmtVf6lQb8PqY2cHr?=
 =?us-ascii?Q?RIZO2/Ec1fEbDifiii94QKSGJCpnb5lEigFLru6Vy/M1mpda1XtJIdMpDbo2?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iaoUqfQm4yiKAxJebpXvZ59Y0Y0qP6UeF9thbpvN21dwYpssNqnXPpcaT77PtvX5Z7IYHG2yPl/poGnIPBRTscWZp6VQwoKeBemWTjjpOUjqgYRG0E7hzVola4pMRe06J2+yMZFqd+Q1pMYcMzUsv7UPQ6b6uo3LwqqoACMTyIzMJRkFITnN/7GK6evRdg3lEmRF8g8iB0iAjMl6U5mxIkeBoiROEV7xgyhiLxMnzsvFcMcG1r70c0+4U3oZO6xaRS2o/BHfeUrrrBRHIhvQCXup9cb5wAP5XbtlO69yjiB7UbfLH3NNoRC5SIPkt4zaRKJvoE7KZu/mN5Lk3jcaBP73v45oNFhT6T63TbqhOEnWC1kBxSxcbD+CUO284QEV0UQpA35PwxPuerdCYpz/dHkbgmmtGxbDs/EpBdtShNIcGMyGcaGRd+d5UrVpXiJ5n7Ed/wzYTX2Q94B9h/NLkF7DKGoacoEVkIocq8vGUe5QYE8M6/Cu8e5y1fSj6P1D7Al8ewRnb8i4YwINlCSpbIUplit9CzSY5qNFK6K+UkxjdFWqhvd0tTsUE1agR/jBLAv6SW0QrY+cUwStqG1qcs/wOlH8mRHzMR+FRsx609c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f4e7ab-b246-48f9-4cef-08dd4b57d7a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 11:24:41.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKy9krpyXSVlHNk8hKf6hhzmr17i6kfHRJI3XvPihQlgHm+mEHUtyiCjHJTIf3e440hlhQlEK4Gzmrzc/QoyG39sDuWR8C+nQCWX3Nb3Kno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120088
X-Proofpoint-GUID: RnnQdv30FwbIf3k5kWkbzDeJgQtHJiZq
X-Proofpoint-ORIG-GUID: RnnQdv30FwbIf3k5kWkbzDeJgQtHJiZq

On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> The commit message in the first patch contains the full description of
> this series.

Sorry to nit, but it'd be useful to reproduce in the cover letter too! But
this obviously isn't urgent, just be nice when we un-RFC.

Thanks for sending as RFC, appreciated, keen to figure out a way forward
with this series and this gives us space to discuss.

One thing that came up recently with the LWN article (...!) was that rr is
also impacted by this [0].

I think with this behind a config flag we're fine (this refers to my
'opt-in' comment in the reply on LWN) as my concerns about this being
enabled in a broken way without an explicit kernel configuration are
addressed, and actually we do expose a means by which a user can detect if
the VDSO for instance is sealed via /proc/$pid/[s]maps.

So tools like rr and such can be updated to check for this. I wonder if we
ought to try to liaise with the known problematic ones?

It'd be nice to update the documentation to have a list of 'known
problematic userland software with sealed VDSO' so we make people aware.

Hopefully we are acheiving the opt-in nature of the thing here, but it
makes me wonder whether we need a prctl() interface to optionally disable
even if the system has it enabled as a whole.

That way, rr for instance can just turn it off for debugging purposes. To
be clear I am not trying to add additional extranous tasks here - my one
and only motive is to ensure that the feature works and we address concerns
about any possible breakage.

And I _want the series to land_ :>) I suspect we're close now.

I am tied up with a number of other tasks at the moment so apologies if I
take a second to get back to this series, but just wanted to say thanks for
addressing my various points, and that I will definitely provide review
(it's on the whiteboard, the only true guarantee I will do something :P).

I will also come back to your testing series which I owe you review on,
which is equally on the same whiteboard...

Thanks, Lorenzo

[0]:https://lwn.net/Articles/1007984/

>
> ------------------
> History:
>
> V5
>   - Remove kernel cmd line (Lorenzo Stoakes)
>   - Add test info (Lorenzo Stoakes)
>   - Add threat model info (Lorenzo Stoakes)
>   - Fix x86 selftest: test_mremap_vdso
>   - Restrict code change to ARM64/x86-64/UM arch only.
>   - Add userprocess.h to include seal_system_mapping().
>   - Remove sealing vsyscall.
>   - Split the patch.
>
> V4:
>   https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.com/
>
> V3:
>   https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/
>
> V2:
>   https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
>
> V1:
>   https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/
>
> Jeff Xu (7):
>   mseal, system mappings: kernel config and header change
>   selftests: x86: test_mremap_vdso: skip if vdso is msealed
>   mseal, system mappings: enable x86-64
>   mseal, system mappings: enable arm64
>   mseal, system mappings: enable uml architecture
>   mseal, system mappings: uprobe mapping
>   mseal, system mappings: update mseal.rst
>
>  Documentation/userspace-api/mseal.rst         |  5 +++
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/kernel/vdso.c                      | 23 +++++++----
>  arch/um/Kconfig                               |  1 +
>  arch/x86/Kconfig                              |  1 +
>  arch/x86/entry/vdso/vma.c                     | 17 ++++++---
>  arch/x86/um/vdso/vma.c                        |  7 +++-
>  include/linux/userprocess.h                   | 18 +++++++++
>  init/Kconfig                                  | 18 +++++++++
>  kernel/events/uprobes.c                       |  6 ++-
>  security/Kconfig                              | 18 +++++++++
>  .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
>  12 files changed, 137 insertions(+), 16 deletions(-)
>  create mode 100644 include/linux/userprocess.h
>
> --
> 2.48.1.502.g6dc24dfdaf-goog
>
