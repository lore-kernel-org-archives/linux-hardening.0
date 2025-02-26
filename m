Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282D1DED6D;
	Wed, 26 Feb 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550176; cv=fail; b=r2JXLCvOGvX2Xe46F/ko+Zvrf/nl4cgeGaREKwqKtGSqO/05XPEnJgQB3j32kzA9fYhiviLgXAewf0VRNJuWF72aikTypl08ghH3K7Kit9gjbFNhoyxXt8og/ShGNnI7eMgLqfcShQAnalnVDuGjYAEafXKV0g0io2RBI1bGdbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550176; c=relaxed/simple;
	bh=/9Ybzk7RMmqlqZYBgurZDrGC7IgymGnvPURmS4bLYT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nCGQI/wdg3+RWnKU8uW7hA82W/fKYvbwkRCLC5sIVZm0zDji2qQJ3l7axCmjbRsGZ17qnbLidVhq5IRBm7UR9ggtoJP+FhdpdqO/gr4VjHw8a443XpmjM6iRtb7rg19o02tY3sYhyBDEYpzCSrug853Zvsi9j2eU+wLnGFNcrHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NdRaqq1V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fbNuGqwq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NdRaqq1V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fbNuGqwq"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5Xk7r018394;
	Wed, 26 Feb 2025 06:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CMhVJaa4FBkW8PC6yCKFDYKiZGDEEQ7Veye5cZxN3WE=; b=
	NdRaqq1V0VCI6pPJg18hiqCjXZKwPgjy1CjSDOF22VJLxPqMDHZ5WzH2n5TJaPI3
	lLSYQpy0nhaFqirdaQkMrZUrLjk4pXZCi8SWooa842Jo0flFgZbSzPUebuv33PJ0
	R5SI0ihTHAh57VRd2Yj47dXtUUT+sI43Q5RxSyT/GBMuopethueWGOe7sx/kT7jz
	3psEZpSrdZZVUDYvx027mc6xPyMWSn1sPFV2EgVkGnvXPM5JXmQtB3IuZKSxmKOi
	vxr86OFxzPI2dZWJ5E2YNtvWCRZQMdPBImbHMYlLK06U7jAfuVrGHPCgMHYZt/kE
	PEc3iajl2gIXbWYIq9BiYw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf0e9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 06:08:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5VG3M002867;
	Wed, 26 Feb 2025 06:08:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51af4qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 06:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNk14ZwMIVUn4sx3F3D1CHhTFSLICpdcdE/2p24dHuogf9K9TXtOMphZcuQBWF1ZvrfnyMWwY1WU4W2H5JqS2dFBjQTOwnXCkEF1L/yVxpU1aHJ/19tgJXrCyHvUcDZNlGLwlrMhG7BEDE6Y/198H1BJ1VUfb8mZQ1SFTUx+ttckPEkGozv6/fzHu/T6Ra9pGVk82SKyfbDNYGYU6wHxJeGpzNXr4xeueexkwxkqsf2+UyN0vpuG6TEGmBxL/U7HxzO3aW6en2B/RfBJpBgCQQPqXyOiLtI9XcZQ7G6qGHKISNh40L3mPsHU9ofrgd6ZbIB2F5W2+QtJgG9mMDDTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMhVJaa4FBkW8PC6yCKFDYKiZGDEEQ7Veye5cZxN3WE=;
 b=ZsjpR81R8rfe3w5CxOztLbyTRXeviBPf9s7oswg2WD2WCG3fWQ2A72vj8rbaRtzAr2dqy6t06MzMqvsKJgqkrvfSfXXZFkybYmBUN/IY7xLwaTxa1o9ZSpj+m8wYpSSepFp9yBwMYoTERtZdBUG2b0UQbaXCyBZAfTKXzr0a3YY05c+6wjoX/CJuwr+CjyvaunUl5gdyEG8mtBaAB8iqvIdrjWGpzJUlvBN2BMTd3fzSjPx/LET9Ncfr2vhJjdYKjECHVquwEcI6X6p7ly07dVJfp3aD2/8ENZCTwHXOO/GHTdg+27woYr9PPxPZFoRL6AGfmYcNpoDjKsB8C2Ua7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMhVJaa4FBkW8PC6yCKFDYKiZGDEEQ7Veye5cZxN3WE=;
 b=fbNuGqwqvAMSstIw4VbeVAjgtA8LCQm4nhXJF3FMvn6haFDw8NCDP7vWRj2IeE++G8mVER9JoYe7W9T7pIjKXAmxS+Ou8rF7GJ/aZbyoVYH6uEC7O28tGlOqDYRU+rRzdjvp0nbJr6RchLGW94XiqmzTYzTnRE1XGlVQhdZb3sA=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH3PPFAE1A1621A.namprd10.prod.outlook.com (2603:10b6:518:1::7bd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 06:08:42 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 06:08:42 +0000
Date: Wed, 26 Feb 2025 06:08:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
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
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
Message-ID: <d3793bf2-fe96-41c4-8fed-b67b789fb153@lucifer.local>
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-8-jeffxu@google.com>
 <7e1bfbf2-3115-408d-a40c-ae51a7ffffe4@lucifer.local>
 <CABi2SkXcYnSOTPHy=VYCUGA9UpXSt_2fCqF8sWS8nxrah5ziPw@mail.gmail.com>
 <CABi2SkXbtF1GmbJWO+F2KM7sFv6yh4cHpNGkes4A0aRWd+fiQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXbtF1GmbJWO+F2KM7sFv6yh4cHpNGkes4A0aRWd+fiQA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0683.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH3PPFAE1A1621A:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b629e2b-7876-4819-320e-08dd562c053b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlpYK3djaWx2dWlsQ0g5UUd2NzZYeEpud0NRbVpXWXF3eXlTeEVjS2grc014?=
 =?utf-8?B?OVFGQWxMK0owdis1VzE5SzNTRDJkU3FEeWhuMEp1bXJVNUV6YS9LREtPM1R1?=
 =?utf-8?B?Qmo3OXY2QmZpakZZZC9GRVNiUGpsQkR6MG5ZVjd0WjNFejV3OW5mSTdpSmJn?=
 =?utf-8?B?elFsYVQrRUlPMUxhb3FZWXQyWkxyRTQrRThmWEFEa09WNklVV09Bd0FYZCt1?=
 =?utf-8?B?NU13Z2xVSHlycjVhQUtPY0N3cUdYcWhnZmI2ektyazQzbSs1ZHN6YWwwSEQ1?=
 =?utf-8?B?TVhXRVpMbm1NZ3lsYUtvekVMTVJlVGVKeDUyUEREMnhPNnJzeUJqcFFyYXZS?=
 =?utf-8?B?TGpobU0rdjFKY2Jva3VCTDc1ZENBUUQ4d1JrZ2cwN2tYVll0Q0pIQXNHbEsv?=
 =?utf-8?B?U2VxMkJmUVB3cWtvT0w5bUJNQU1wU2dnTzhoV1ZyNXFMTmtzdUNLcnlWbmdB?=
 =?utf-8?B?SmsrekoyNW5BRjlqamFKd0E3VGFTTkU0aGExREpBTE13Zkg4TGZrUzluMWlI?=
 =?utf-8?B?NlJQdnoyejc1Qm5VaGthUGlVbUg1NTBSQk5QOVF1NFN2YlRvTFUvWGZ2ZEMx?=
 =?utf-8?B?M09kNDdzb2NsZmZ3Vm9LN2hKcFI1TmFSKzA0ZTZOb09RdWRxS0E4cUxuajF0?=
 =?utf-8?B?YkMvc0llQzYxVHpicFAwVlNSTDlBaG1ZVHhROGp1UVdsNDZUTE9hQlNBUHZJ?=
 =?utf-8?B?S282Yi9Ma3IvSXRZZzVPckt6UWU3RXdKUkxTLzVQK2Uwa1NBV2JuUXpsSDVI?=
 =?utf-8?B?a3dGc0I3S0NEOE04TlBnMWtLaW91eENXK1FkOTc2KzNLekJYRU9RaWdkNjlR?=
 =?utf-8?B?OEpIb1AyaFEvRDNLdThxdlNscVhWQUNWdExwa2hBMjR0M0RKL3RKNUU3SzRo?=
 =?utf-8?B?YXMxU3dCaytzZ21ReXY3VzZqRUNTWittZFR5Z05PZWJEZzVqUi9TSjJUaUFQ?=
 =?utf-8?B?RENaNHYxalJGQVhMZUIyUzJDVXl0VnExMXUvS3pmU3hrQVVNcFUyTk1MSlFE?=
 =?utf-8?B?akRtbE5iTUhYQzNKbVI0dFpIL3hYYjBwZzBGYlpjMEo1c2MvUXlHMnRiSU8x?=
 =?utf-8?B?czBETm15ZjJEQU9sbU0zaG9pZHM5bnB4L3J5ckg3OVBDbUVxZzZZYzBoQmIz?=
 =?utf-8?B?QzlGSTJJd3JvMEttcVBKcWJTZkxpV2srWWdUQ3V3L0JIS2NmdHJ5NmFZNC9h?=
 =?utf-8?B?bUJPNzJITHNHTXhNbFA1MEtkeWFlN1BqZWllN25NdW5rRzlDMHBwWDdOdVdJ?=
 =?utf-8?B?WUtPNmZjTUx3LzIrbGFDNnlMWU1UTEdzMmpkVWUwZENyaXZOVjUxbmszRHBI?=
 =?utf-8?B?VUhLYTZSNXpqSkR2ak1oUHh3RDlhU3k1RVZLbHlyOEZYU2xmMnk0VFFuaXIx?=
 =?utf-8?B?cFlNZVE4NTJGdTVHRmt6eVdUSlF6YVV1QUlRQXRnZDJWSXM4TG40RUEyeTlD?=
 =?utf-8?B?S1ZiOWRhajlUcTR4aVZiR0JOQVB2cHg3NWcxbzdYdVg3ZFhlQlpBVEh3VFF2?=
 =?utf-8?B?T3YrMEhWNlVDZFcxZkJSUEh2OCt6Ym5MZnRham00bndnWGRSZEgwVU01RUZs?=
 =?utf-8?B?RnZNMml1WmxjS1MrQS9HNWhYdVd4MnpHalBJZi9tellsanM3aHF1aDdyeHJt?=
 =?utf-8?B?M0NPOW4wdHVWdDJ0dHFyNGJFaWZXWFhRSnZrSkN4VlVCbTRSSm4vTnk2VTdV?=
 =?utf-8?B?bml6S2RJVnNiTTBTbUZLckpMazlHMWM4N2J2M3h1MHJvcGRZTktOOUxpNmFT?=
 =?utf-8?B?aDRacnNOcnZuVFVuNGxBTU5TQUQ1T1VKamRSZlZNVTkvWGV3VWVJem1pNVNn?=
 =?utf-8?B?Zk1aVmRXdFk4SzF5T2IwOGZPbnBLemh3WHZoMTVDVlRXY0FaQTBybS8vMnU3?=
 =?utf-8?Q?dnYHHRC4MC5n7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0crQnRlS0JGL1JhOTJ4L1RLOEc3NWE4UWNtWGVNaUd4UFdnR1JsWEkzZE13?=
 =?utf-8?B?VjU5eDhEdEd1QUJMNlRTcUFmcGp2U3BGYnY1d0tpdVJNYzUxYzA1UDZkbk1m?=
 =?utf-8?B?UEtlVVRyUkltdXZyc0ZWYzNIRFZ6N1ZZK3BNZDFVaVdRVlhtb0Fhd3h2SW45?=
 =?utf-8?B?KzBFaTRwazZudW53bWV1TjUyN0pjSnlZbXVUMEZmV0lJRWJOc2lJbDhucHZH?=
 =?utf-8?B?S3MrWDVZTjlZSSt5NHZTaXZOdEwyYXNqSkFybUtFa3Nud3oweWNxV2ZWREsz?=
 =?utf-8?B?eHZHYUFIZ053SzZlcmFDL2FmenFRUzR3VndDdWs1cThXSnN1MDh2NVpWTkhJ?=
 =?utf-8?B?NXZ3bWlpelNKRkFyV1I4K2JYOTdhSHYreFh6Y2tUcXk1YzFMSVVkWlVmUjBQ?=
 =?utf-8?B?ZGx5OEFoeUZ0UFBhTzNvUFQwM1Q4cU9rSmVNUVM1UTIxc3ExRG52Nk9pZ2wv?=
 =?utf-8?B?WUxBTm4rbXlqOWUwZmhVSUYzZjNWSHZ5bU9DTEUvV3ArSjh3VWJWTGJOWk5T?=
 =?utf-8?B?MW1iSEdUdXU4bzB2ZUdFQ2xZTzJPWXBwaEZoU2xUM2lVdDlNUytPTmR6ZkNq?=
 =?utf-8?B?V3I4alJzY2hnVmNRUzBIK3lmdE95RVFCSE95RGx1TkJ0d0NidWdMMmtoZlpj?=
 =?utf-8?B?emFDNUxPTXVobkNmUkRDTmNKOTVLSGt6ZFU1YmcxUWFiN01mYVI5RmtZS1lV?=
 =?utf-8?B?Z0N3eXM3MEpvS1oyZHBIbDRXUTJacW9RRzlYak9ReFNBVDdnTEZabHJpTlBl?=
 =?utf-8?B?MUdVeUJ0dExYWXNKQ3UzSGI5UVBVWFNOZ3lTM1A1NUVpdDVrVWJEZWRpL3hM?=
 =?utf-8?B?V3l5QVZmSEl2czZXQmhuWTd4SWNDNWtiVFVoSDlYWFF3MnZoVHdHTEdPems4?=
 =?utf-8?B?SWpsQms5dlUwWTdXZ0ZhVWh0YUVEVzhNVWlWWEdyb3gzUERBZ1VnNGpkQkM1?=
 =?utf-8?B?YzdiQzJWS0NxUXZsK01QY0ZKNE96eWZSbDVEYUw0V1YwK1c0aHVqVWxmR0JX?=
 =?utf-8?B?aVNNNEZtZWV0QlRFQ0FQeWNET1RuTE9Vc0JsQTNZeWVzem9DMGh4RkNSZ2hL?=
 =?utf-8?B?dUJhV2p0SmpGZEg0MU9qUE8yS2EydTBwU2NvSTdzN3ZJTzZ1MVBGVFZGYXdk?=
 =?utf-8?B?aUpmYWJxOVpxWTNIeXB3UlRja3JZWGhpc2o5NTBJUEYxeHllb1ZBVFhQOHBR?=
 =?utf-8?B?bVQvVjBta2VQNURoL3IzTWVUUUJLU0JzaDhPL0VPZ1JQTWk3QXp6dzYweTdX?=
 =?utf-8?B?UFJzVXRYdm9CZzcwa05xeURzUEJ0M3pZbnZzUUlHdzY5dFc2K3RrYUFkcHFQ?=
 =?utf-8?B?d1hsRjM5YlFaMXJUQll3VEZ6SURyaitqM2x3Mm53VGhCWWFyOXdwNE5aUVd4?=
 =?utf-8?B?U2J2Y0JXNWJlNjlOanRKYXVsSlRSc1FyenREdTM3RHV1YW5FSlduYnBiTG1l?=
 =?utf-8?B?bkJocVgzNldIM2RlNmFlWTdQc3QxVVBRalBZZTZIWlJMU3NOd1czSXNIcFlx?=
 =?utf-8?B?UDFMdG4vZGJieEtUOFczdlhTbEF4b2lFQnBBS0UzOGU1K20yZ24wQ01lVmkz?=
 =?utf-8?B?eXdMNGs2RGNVdGsrS3loMUY2TW00Y1llNG0xd3dZcUZIeGx5VjJ6NUN5YUhn?=
 =?utf-8?B?Y2RZSmVYNGx2WFVtOWhiSk9IUDJMTWgrUWF0Zm9objg4OWxucG1hYXhZcmFj?=
 =?utf-8?B?RUZJUnZjTUNaVXBOTWVPY2d1cGg1VjQvbkVpZFAyc1VVV053Qmx3aVVFcEtR?=
 =?utf-8?B?SnVSM2ZPeHUyeUtNbmJ2NDE3c0UxL0VMZWhENGFoVElwaDJaRWZBUkI2OFZn?=
 =?utf-8?B?cHltQ2F5UklFZXZ3RjBJTFVrclNKNE5iRlpleW1vZ3lZV1ZyMjZTNzZWUmhF?=
 =?utf-8?B?bFg3MEZHbFk0c1NRUzFvZEdVaVlxTElXVktqc3Nic0hMZlltZXREalpUZ095?=
 =?utf-8?B?Q1NsZ1B2NkZLaTlOY2ZIZmFNNnVJVVlFNVNYODM5aTN2RGE0UXFXTUx1RTl0?=
 =?utf-8?B?UkNWS2FkTldVZVhBenIvTUtFS2N1azZhM1pYS2k5VWdETGI0dVNxQXU2ODZS?=
 =?utf-8?B?RzI4MVV2QUVGT2pUUzNleFVxcEorcVNVWUpPS1JacVhWYmxDbG44Y21ZVnVC?=
 =?utf-8?B?b1A2WE9VazY4TkZublo3RjlST1lLY05nU2l6OXJydlpmTm44bEx1MC9kbG8v?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IBSax9CKJkXipKtbx6wkryWnttHyjv1Df+8idpYLoXGqg/bFI6ZvURVmSpMInXApFlJ4BNYT4pbq1TsyXdJ9tdZJo6xaMtp5Tdt7oFISArd/KRuXJwt4Yj2GYL3tR/3iUjizSbjjIGZHqC9AoMVxXHYU4RSW7upBvsAdvJ1pYeLx68pGKdrxqcXBifLiz1pL2UrptWFrXQ/dLB/wBPMkB3znerZrW4eBEUFvvS0iZEEhB8BcUR/dVwdI1o5Y8WS0HQOHMG2dXX7ywAzpsFJpgyOAekdEeWLS6n+0PQEbygJpYggTRbfgmClJc55cnYf5WW1iXE/BxQ32vO68ZlPTTUHHu2RXpknm0yKUHcbINSTt4G+bOS9Qxxal80WLT3u0cZKaJ+f8QpQmmJU9rBfvvavgmmyfcG/MdByJFvh3VNCPNgOFSTPQeutXFz1i3VeinRBPAin3giWgVNgl9/DVaHqmg6+720s/XtPKm/NRQ5o9Yjq65Or3ySztS+cWPBHkAE6oyn7v1BVSKqzTzZ7BFwucgCVxI2FqlTHeiWaeVylNIV8TsPtDr6SqdXg0PWXpbpwsNOmcq4ZWBDyQEfQLnh0bA7cUTvyFNkFtHQDW5l8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b629e2b-7876-4819-320e-08dd562c053b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 06:08:42.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpeztgdrV8akhmu30BBezv3JiR/GyDCsMOJGG/ax8OiRRZH28o+/p3m1aGoVe+v0FPTW0HltDvz3unT9C8zBdwHj9oVjHkCAFcrQdl6+hug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAE1A1621A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260047
X-Proofpoint-ORIG-GUID: af-0zqC3bzBiE-a_dqm6NZVU553097qg
X-Proofpoint-GUID: af-0zqC3bzBiE-a_dqm6NZVU553097qg

On Tue, Feb 25, 2025 at 02:36:52PM -0800, Jeff Xu wrote:
> On Tue, Feb 25, 2025 at 2:31 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > On Mon, Feb 24, 2025 at 10:07 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 05:45:13PM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > Update memory sealing documentation to include details about system
> > > > mappings.
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > ---
> > > >  Documentation/userspace-api/mseal.rst | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> > > > index 41102f74c5e2..10147281bf2d 100644
> > > > --- a/Documentation/userspace-api/mseal.rst
> > > > +++ b/Documentation/userspace-api/mseal.rst
> > > > @@ -130,6 +130,13 @@ Use cases
> > > >
> > > >  - Chrome browser: protect some security sensitive data structures.
> > > >
> > > > +- System mappings:
> > > > +  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
> > > > +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
> > > > +  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr are
> > > > +  known to relocate or unmap system mapping, therefore this config can't be
> > > > +  enabled universally.
> > >
> > > Thanks for adding this.
> > >
> > > Similar comments to the Kconfig update - you are listing features that do not
> > > exist yet, please just list what you're doing, specifically, and avoid the vague
> > > 'etc.', we don't need to be vague.
> > >
> > OK, I will remove etc and list the known mappings here.
> >
> > > As per the Kconfig comment - you need to be a lot more clear, I think you're
> > > duplicating the text from there to here, so again I suggest something like:
> > >
> > > WARNING: This feature breaks programs which rely on relocating or
> > >          unmapping system mappings.
> > >
> > >          Known broken software at the time of writing includes
> > >          CHECKPOINT_RESTORE, UML, gVisor and rr.
> > >
> > Sure.
> >
> > > You also seem to be writing very little here, it's a documentation page, you can
> > > be as verbose as you like :)
> > >
> > > You really need to add some more detail here in general - you aren't explaining
> > > why people would want to enable this, what you're mitigating, etc. from that you
> > > explain _why_ it doesn't work for some things.
> > >
>
> The mseal.rst already includes below regarding the protection/mitigation.

But not specifically why you'd want to do that for system mappings.

I guess you mean it's _implied_ that it would be sensible to do this for
system mappings and I suppose again I'm asking for emphasis on this

>
> Memory sealing additionally protects the mapping itself against
> modifications. This is useful to mitigate memory corruption issues where a
> corrupted pointer is passed to a memory management system. For example,
> such an attacker primitive can break control-flow integrity guarantees
> since read-only memory that is supposed to be trusted can become writable
> or .text pages can get remapped. Memory sealing can automatically be
> applied by the runtime loader to seal .text and .rodata pages and
> applications can additionally seal security critical data at runtime.

Right, this is exactly the kind of thing you need but obviously adjusted to
mention system mappings, and why they are especially problematic (again -at
risk of sounding like a security idiot here :) - I'm guessing sand box
breakout, rop, syscall, find a way to write, and un-sandboxed code now does
unexpected stuff).

>
> I could copy  some sections from cover-letter to here, specifically
> for special mappings.

yeah that'd be good, while the cover letter will be copied in automatically
by Andrew to the series, it's really nice to have it at a glance in docs
for users who go to docs.kernel.org etc.

>
> >
> >
> >
> >
> >
> > > You're also not mentioning architectural limitations here, for instance that you
> > > can only do this on arches that don't require VDSO relocation and listing
> > > known-good arches.
> > >
> Sure, I will mention the architecture that has this enabled
> (x86,arm,uml) -- I don't think there is an architecture limitation
> though. mseal is a software feature. The reason why other
> architectures don't have it is due to the fact that I don't have the
> HW for testing

Yeah I mean just list the arches that you've tested, more or less.

Thanks!

>
>
>
> > > This is a documentation file, you can go wild :) the more information here the
> > > better.
> > >
> > > WARNING
> > > =======
> > >
> > > > +
> > > >  When not to use mseal
> > > >  =====================
> > > >  Applications can apply sealing to any virtual memory region from userspace,
> > > > --
> > > > 2.48.1.601.g30ceb7b040-goog
> > > >
