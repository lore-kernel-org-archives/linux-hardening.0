Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA01258CC2;
	Fri, 28 Feb 2025 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738790; cv=fail; b=qVm+1VPMZ7aG77FE8t/jK9UrMahb+ESrRH0RsIF2x8feO0gbacXJSKsXcfW4v+d96hW2EEIaCcegxVLIqoRTSx9LFyHszjhoe7nG8LRkFy4g1TsMK9TIc5lbySf91Z6iDVaHpOo2agHreeMhueYJZMEZtXZ6uC5ytbpx0SE+g6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738790; c=relaxed/simple;
	bh=8HtKsauvW+JSN/c1mK3YSLJIPvY/ZNZJmOFXpiH6T/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPqIVeU1u6vMvorYYuaifGHFzTZx2iLhzoTfOOFENQeJhpIqlPKHgQTtqupNnoS1FA1Ojo5ieyZjX85PUCGg3Y0ukzQRzZpUnh195rYUwpzAkEJhpKlXAVKkI+Bxz8hQemMjeZh9UxVoAqFJ9eFklKzQVW8yYdE83RCQRqCBopg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jegd+3JF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N6Qb/8V8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jegd+3JF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N6Qb/8V8"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S9Bd0g010417;
	Fri, 28 Feb 2025 10:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YNb1jBEwST/G1UEMj3RagoULXS5ovHFhgESEDwJ8n7I=; b=
	jegd+3JFo+Eqs2LrXR2a8TFDRvOp/6c5rtu7JHvLy1waMdNW+1sUWxIZk5hWIqAR
	LW4hy/GUjQihSsxeW5/7DpCiEUHvQ+JiiWbTJDMSabwyYRSx8wGhXpH/zr0hOXFP
	VyJtpAsEfJR8s6urKh9NEJnyPSjItG7C6kbelZRh6WCXWOoFTwuJgvXpRCsNqqVq
	ECIjc1dXfF7yy5lF/H9OABuA7K+VwLw29mSRA7HuAlp/r2yFrVzvsiq62ZKk3NMg
	Pfqbe1F8fJgS3dz+/qkreJHQjFdjubRNUUmXDbGdeOnJvNT3MrXd++e5cDgtPNPD
	u3685mOSbUzNLLSjvH2Edg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse59ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 10:32:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S96Qvh025428;
	Fri, 28 Feb 2025 10:32:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51m2aup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 10:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaukmMaypgMuVc+Wg0/YxkPKBUhDxawfzG0BdtwYYwaOZCSKCbqejyE14t2u6FevjHWryHLzkyV0zJsNP7gHURIyNPJmpy96IUvGy5O6jAp0DYmusi5QkcNSOmWi7wqbsn6vPnHD4MIRDQkivyC6pYjYognG2o1+2DeuRNGyB+R5rjzl1rX40HwOPbd22GLOOVAqTbjA3cWRUN6A4NKjPdN/qvkBQaQIz24zATQmNTnEfBLMfxmzcW5DqUFqfTw7rApDs9VgDsGLIQSYWiSmcWsT/n2SCB4WHAQ9oMaKC7nt+qc9nX0OWdvkIpO5jaT3iljZG0I78Yo36HrNIGCVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNb1jBEwST/G1UEMj3RagoULXS5ovHFhgESEDwJ8n7I=;
 b=cjyz5Z8VSyfdValXC4CHXyUW9h+9fie03MZ2mz0nZB5RdqQe3Cew1EKPTl2Zq6yjRBjSWw64SWBpJvFOvDMaYeIk0zfFhRPdsc5qsdoYPx5szA9Db+oVT2vAYPf17Fp0EjknNZUDrRw118Oa0RwdhfVxBZOJjp4EkYZz3NFJG+jfPVdTnLLdSLgbE7dsDl/Jd12Fuxlv5Guk74CxqgMj9lNuPfzfFJe5qwHz59lRfaMVPJjA6+q1JGI3AJw5hLthCFul9CA5V7PRVIaZZkunCzEevL+i9hHyC9Z3Sg8rMIstQfvGcLc+CX9fgn5ZchbqRf9TRSTSUWWvmgiLzU3Y9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNb1jBEwST/G1UEMj3RagoULXS5ovHFhgESEDwJ8n7I=;
 b=N6Qb/8V8iinfgD7ZNfUue9tH9inrubprM8IVlOKYXNWbLMlMsJ5N5j+LdRikiruQqp53XX52cfeVFvmSBx9043RTgvgvSkTWGniJzGVU9JHOSgIZdfE8lhi02N1oRdi9IzhNAMuHgWBBZ5zZGJt/JkdYWU6Gy2gVdgwBTXDpL5Y=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB7524.namprd10.prod.outlook.com (2603:10b6:8:15c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 10:32:26 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 10:32:26 +0000
Date: Fri, 28 Feb 2025 10:32:24 +0000
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
Subject: Re: [PATCH v7 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <5797d6f7-51e9-4610-9305-0ac4a82ba577@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-2-jeffxu@google.com>
 <9abd68d9-3e6d-46a0-b92c-5aee0a90abf3@lucifer.local>
 <CABi2SkXT0z9YFsEkf3-HH0r_NuXXs_SJid9yzjuu0SwuxxWmZw@mail.gmail.com>
 <b7a38abf-f102-47b4-b085-213298c51aae@lucifer.local>
 <CABi2SkWeXJXmuE8OETJvbmxzGjk1e+5FUT9Gi2ZC35M-TcZWEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkWeXJXmuE8OETJvbmxzGjk1e+5FUT9Gi2ZC35M-TcZWEA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0298.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::22) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: dcafae23-7457-42f7-9eea-08dd57e331e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWFVMzFZQ0o4N2FhUFBGVTh0TWE3NGI3d0c3d3YzWmNaNG4zUmRJU1VRUktr?=
 =?utf-8?B?aFlmTW00K3ppN25TQTF4L1FVSlRQRldhV1VZUVExVk1Pei93WU5rd096NVRo?=
 =?utf-8?B?K1lEWEJ0SGFvWm5odTh2M2FSeThxRzl4VlRqMit6OTByYjdTcXpyaTR1ZExI?=
 =?utf-8?B?aWhsT1ZjcnlZOE1RQlRqak0zMWI2bHFHL1BNelgxODRGMFpPUy9wdzlTMS92?=
 =?utf-8?B?SU5vb3BuejNqMTVjaFFzRm5YdkpwdCs2SVBqb2FlNkFLbWlWcWhHdmJXRFpU?=
 =?utf-8?B?ZjVWWmY3emRxeHRucitnMEEvT1ZXRHFEQ0huQzhHVkZLUmNpWVJGd2srRC9W?=
 =?utf-8?B?QzFpSGdmTUFmL0ZCU3ErRWNZeUliUlJjbHRMSGlaMHpVMW9sMFBxcXRVTDF1?=
 =?utf-8?B?Q2tWemJ6NVFmb0E1MzU5Y1c1UnVIdkNvN0xZUjBYUXZLV3A4T3lPNnpRMlkz?=
 =?utf-8?B?ZDhpMk1KVHFjUXpTZms5NVdNWnBnbXVMRUZZSS9HZ3g2RWc0TGhaZXlIVndv?=
 =?utf-8?B?T2s4ZkRtTk5WbDM5NW01SldzWW1wUTJmYkpqcEtjU2lvbHcwT0JQT0Z0UVU1?=
 =?utf-8?B?cmtVZzF0NWtiN0Y0MytuOGl0eUJaeFlVdUZvcG5vN0ErMCtPYnAvWS9GVmdU?=
 =?utf-8?B?cWhYcnF2U0F1NHBzK0FCekRiYTZHVi8rdHQ4azcrK0xvRWYrWHI5Szl6U2Rp?=
 =?utf-8?B?dTlxbGlHTnhoMEpPZVlHSlh3cDZwR0RRRFIrbllmOVlxSFJUaGRNSXk2YmZm?=
 =?utf-8?B?L1N3bFFJNGNPSTEwb0NUWjhvMHY3OEJsMDhaNWk0RkRHVGJkYVNLVjNyNzI5?=
 =?utf-8?B?ZzRQbi8vU2MrMWNVemswUXZsQ3R3amRYT214K0JEVmhydHdqRXUxbFRCYkow?=
 =?utf-8?B?cytIS2o4cFVjNDZZcjJ2YW5FVE9OT0lzVEIvRzNUM01xbFFIc0xaUzFXcFJK?=
 =?utf-8?B?alJldEFZb3lYdUg4WnJTRjNuMFBmdDFBSlorcEhMUW0xTEZKSHBDUVA4bnh0?=
 =?utf-8?B?dGtCTmsveXp3aHJObU00ZklNYzl6OWwyUmZGVk5WcVdacmN1aEFtQnR2cFlP?=
 =?utf-8?B?Y3VwV1pQVHd1eGI3UTJCUm1ZdmJvTkpETlZCTW9kM3p1RGJLK0RjMXh2NnN0?=
 =?utf-8?B?aDZpVzdRaUlOT0tvR3YzalBUVXBkbll6Mzh5ckJTbUNYK2xzRGRuYXBxRE9w?=
 =?utf-8?B?TXRRclpzTFZtdlRsT0FJUFJNV2l2eUgvZGYvNmMzbEh4MDZKeHByWVFKUzNi?=
 =?utf-8?B?N2RqQ0J2dnBKdEtRVWoxK3hvb1N3OC9RZW1HR1loOEgvUTRpKzZKeVVrdGpO?=
 =?utf-8?B?MnlnL0puYmhZay93OE5XREdFUzlINmxnOFVGNWJmbGdZK2FUU2U1T0taVGgw?=
 =?utf-8?B?NngzOHRHUkkxblhFV2ZSYnBmQlcrRTBtNGx6ZUNLaDlNbDVLK2ZRUU1ua3gy?=
 =?utf-8?B?WVJ5cjh5b2NJMkhTelltVmhTbkVZNlZIOFZtREdmbWVabGVHYmZ0SWpFZEs0?=
 =?utf-8?B?Ym0wbDE3RE4xZk1CUFR6NGQ2MzdRY1lRSGVoSVdvZ2V5ZEp1UWROTjY5Wm1W?=
 =?utf-8?B?QXpsOFJ5SmtMQ3dJeTFxZkNiTklsRE1YQWhtSjIvODQvcHRjZGhDK20rSExC?=
 =?utf-8?B?b3lEVmlVeHVsbXdCTmZyRGNYMlhRazlJOFVPNy9vSnlNM1lWNWZub1p1Wk9n?=
 =?utf-8?B?WjNORExsOHFndTFuMEhKR2s3ZWY1ZmVvaFhSUHplWU5ENEpyWFZCd3Y0b0dO?=
 =?utf-8?B?UVBoZkhqRUs1V2E3L0NRLzIzdEFpUTluTHpJNWlXK0xKVWlZMUxMeVJtU1FB?=
 =?utf-8?B?Zm8zYXlqUkJ2UVZyUWRhbFhmYTRUV0NnQTc2WXpJVER6dFlKbXVBSTBLYlNZ?=
 =?utf-8?Q?fL8F6nk+7gxlY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkFSOGdnSk84QlVid2RqVWRtWE1NRGROTE83MkdPUHlVbmVKUTNDU3ZaL3E4?=
 =?utf-8?B?cHl6bUFGdFRuNTRZWHlWektwaGVFOHhMeTlhVmdpeDk3eHJwMXpjYWI5UXg2?=
 =?utf-8?B?eUdvdjBQU2NyV0VxeGZrQmRxYkMySmN0MXJ3WFhVTzVGazFUVmt2bytpQXhP?=
 =?utf-8?B?K0IyL1ZJdUp0bGRPUTFJOGx3Nkw4U2VrUjQzYkJtRUNsbVBQRVdVaWNqbUwz?=
 =?utf-8?B?ci9seEc2WkRVeEUyK0s5NS9QNUoyTzhhb0RYY1VtZ05JWDFaVlJKdHN4Zmli?=
 =?utf-8?B?dHppRG9lTnA3MURWNitXWnFYYmpFejdudTJSalpyU3hHbkJQZXM0dnBrNmFh?=
 =?utf-8?B?ZmRVSnBuR1RlSWlHeFF6amJVaVZCaDNiTnJ3RUpwbFFHK1ZCbC82MGZ2cFlr?=
 =?utf-8?B?bFhaOGpwcEFydk5xRmxXK3play9QaUpoWXdsTktjVy8wZEFDL1J6NHkwNDVi?=
 =?utf-8?B?MHo2b3JqTHQ1eVVQYUQ1Q0hTTmNtUWdXcFBRYStsQUxHQ2ZEYUtvbmFDMFdZ?=
 =?utf-8?B?cVRPbXBOekJac1B6U1BYYUFXcHZOWWxpcCt6eE40aC8reVpOOTYrUElid3Zj?=
 =?utf-8?B?bGdRY2xCQzd1M2dZVTNPUEx0OHVaZ0hZVThVTVVFa1JVU29TSGFVUGo0bm1D?=
 =?utf-8?B?U3ppcm4yL1AvSVAzazR1VkpRYk9iMnpHOVkwclpkd3kyblV4MkpqNUFRejQw?=
 =?utf-8?B?U1pCdVV3N2xrcXpVWjcxdFduNXI3dVA1NnhFQURMeEEvRVhZUnM1emgxb2NN?=
 =?utf-8?B?RituTUE5bUdXK1ZOL3NwOWFGMmUwMUNSUmlxeHViOThqbWt4aWRtRDJEZ2Z0?=
 =?utf-8?B?dC93RFM4N2VlNzA2dEgzN3hIUEZrRXZ2em8zVG8ybFhGdHkvcGRTMGovYXRv?=
 =?utf-8?B?TURKL21HbkJlci8xVjl4ODhscnhtaUVpK1NDZCt1cW1EM0xBVFRqekFpQU1H?=
 =?utf-8?B?YjdJd2l1REoyaElwWmtpeXFlODBVZ09SaEZRWVJiRmd5U1RPYnlEMGpKMDk4?=
 =?utf-8?B?VXpPdmN4NVgwc3BLbGw1QWlmbXp3ZTdUcTFDVXIya1lNWlF4blpmSnZvTXRv?=
 =?utf-8?B?dk1lRXJnVzd2KzRCSlYxUUhENjExb1EwSlJ5ODZ2SmJPYTEySUlSTDFuN0o0?=
 =?utf-8?B?eDd2T21Wb3F3QWRBdkJoSG5wZEFneG44ZXVTaUdxN1E0QWx5aVU5UW42aWxP?=
 =?utf-8?B?eUZyVTZlR2V5MUNmQzV1S3hpSG9kcmd1cVdaR1VBaTl2bTBWOEl5Vm9yM0dH?=
 =?utf-8?B?WGdaam1PK2tuUmRkVGRtV20zSmQvd2FZVmpzQTlqMnZlVzZMWG9tQXN1dU5I?=
 =?utf-8?B?WHdvRkY1WHI0M3ozZFdVcUFNSGxSWFpTSjdiTkFDaEtiMVRTWHo4YU9zZTY1?=
 =?utf-8?B?RDZwMkRhejhWQmc3T2JHZnFrY0dFMkJhOXJQUndjOElLY3hoazhlK3lIeWhX?=
 =?utf-8?B?c0czTXVEMWJ1YTIxVVZxMjlFQkVnS3diVlQwaDRnS1RHZFBONUp6WTcxZDI3?=
 =?utf-8?B?dnhPQk5BZVNlNTUydDFzUlZPYy96b1A1aGl0RnRON2ZGYmFJalc1UzFsV3Nn?=
 =?utf-8?B?aTNTT1ZvMWlKRXB0YVZ2dnpid0pmQTZ4VDFyT1ZNc1ovRHAwQlh6U1VucCs0?=
 =?utf-8?B?U21pVVQ1UHhHSjFRNTY5N3d0bkZEaWVJYWIyTEpGTjF6bk9Sa3pmODZoSTNz?=
 =?utf-8?B?K054VWN3dXF0bXBuQzR5aVBVbWZBNThLUllBZ1Zyek1Rc0JMaXlEVzZKSkhi?=
 =?utf-8?B?bm9hQTJKNUdlSklkNkpUMFNMQ21vUk9IZmFQZWttS2hvRnAvaUVyY2JDcmNW?=
 =?utf-8?B?M2R2d2ROQjNoME1Ub1UvbDZOWCtUMmZZTVJSWTBVbmppcjFQdlkvaGp4YmR3?=
 =?utf-8?B?bEh3Vm5Kb3pBYzVFZnR5RmlsMTA5ZDF6NXdnaXlTR3RSTHlTVW16YTVVcmJX?=
 =?utf-8?B?SnlkMEo2NEdVdHN3UlZsc0tVdTI5UkRpOU5jeTdNOWR5M0dackZIWkNpWGVK?=
 =?utf-8?B?UXRBem1kRHVIVFNValV2K2xEbEJQVFhETFpObjlkam54NWgvdC9GcU9rVUVG?=
 =?utf-8?B?VEs3cWIyZUJiRGppeGMzYk9wY2NScEFxb3NGeTRnMFVQVXlyMnQvb2FHK1A4?=
 =?utf-8?B?bFhmcmNtS0d0a08rM3FhTWNKQnpiTEJpZCtlV1ZNN1Z2QkdUeStzdm83VCsv?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j+pU/tlfykhXe3xSy4uXLrf8e0F0FVH2wdltyzz2kZ2UFCuss+fowUQEyiIY9fEUGjUJNXrMyLAdfS41OjgJCZQA+LCxmX3B2bgoFSLZvH7zdKTr1xXYWScrLr8Jlm8XIs0Sxhx9E+mLhqphTicUBf0GOkaxtlwb39j7WaOuQ1tPOI1aZJ4bkL7CIWS9NRQyDAJfZDPE+gNvVeigO47eSuhSUfCiZ8hYO558ynNoos4wf14d7MLO4NFz6HXg92/RKQRWIJhucsp/KxKQyYW31tK2mws60CcDsBIy4m2FD/nASCjA7ZAYq3mN3suTrbJzf4VL6DctJj92mOjM1/fMUntxyfR0QhC3PCkhoFJTfCHgZNXIVwR2dbJMP5yLXV/HipDb6IHwCv7lTXDxj761pvPB5CAPqxY92ob2XmYpAyRSEphlXHaF63ykv1LhkB03MrGMCqmi8m5KWtDKMCfNbzVyc8QbG/Ssls0BS8+tj8ynBG+8qb5gbwRtL68nRI+/jk+/pyWJdFYqiQk62PVdDwBikrNN087IYY4K/ASZPr/sqwxMGi9D3wC8FLBhEFPfJQS7+FmEZQHeZEg0poIUwv9y7D7CK6izXRZkDMijhao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcafae23-7457-42f7-9eea-08dd57e331e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:32:26.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46lM47mqZxhvgFknKSE0RdCey5nDb0C84yigPpEnJSS71UV14WGYJgQ42HomKzY8AlN3si/Uq4Ouv/J5hkjR0dYWVhZg6C+bjZ8leyMZYAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280075
X-Proofpoint-ORIG-GUID: MXuUqaiT8y2BHqD-_RvijQe6UEOrvMVD
X-Proofpoint-GUID: MXuUqaiT8y2BHqD-_RvijQe6UEOrvMVD

On Thu, Feb 27, 2025 at 04:04:03PM -0800, Jeff Xu wrote:
> On Tue, Feb 25, 2025 at 10:04 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 05:33:24PM -0800, Jeff Xu wrote:
> > > On Mon, Feb 24, 2025 at 10:05 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > > > +     bool
> > > > > +     help
> > > > > +       Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > > > > +
> > > > > +       A 64-bit kernel is required for the memory sealing feature.
> > > > > +       No specific hardware features from the CPU are needed.
> > > > > +
> > > > > +       To enable this feature, the architecture needs to update their
> > > > > +       special mappings calls to include the sealing flag and confirm
> > > > > +       that it doesn't unmap/remap system mappings during the life
> > > > > +       time of the process. After the architecture enables this, a
> > > > > +       distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage access
> > > > > +       to the feature.
> > > >
> > > > Architectures also need to be confirmed not to require any form of VDSO
> > > > relocation, which as discussed in previous series some arches appear to
> > > > need to do. I'd mention that here.
> > > >
> > > This might need clarification, the system mapping includes vdso, right
> > > ? Why the focus on vdso ?
> >
> > My mistake, I thought scope was more limited than this when I first
> > looked. Please disregard the focus on VDSO here... :)
> >
> > >
> > > The sentence  "... it doesn't unmap/remap system mappings during the
> > > lifetime of the process."  already cover what you want here, I think.
> > >
> >
> > Right, I guess it just doesn't quite _emphasise_ it enough for me. Something
> > like the below would really help bring that out:
> >
> >         The existing of this flag for an architecture implies that it does not
> >         require the remapping of these system mappings during process lifetime,
> >         so sealing these mappings is safe from a kernel perspective.
> >
> I'm not sure I get the difference, but I can add it,  is below OK ?
>
> To enable this feature, the architecture needs to update their
> special mappings calls to include the sealing flag and confirm
> that it doesn't unmap/remap system mappings during the life
> time of the process. The existence of this flag for an architecture
> implies that it does not require the remapping of these system
> mappings during process lifetime, so sealing these mappings is
> safe from a kernel perspective. After the architecture enables this,
> a distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to
> manage access to the feature.

Sounds great, cheers!

>
> Thanks
> -Jeff
