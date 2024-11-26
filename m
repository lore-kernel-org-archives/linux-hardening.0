Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3319F410;
	Tue, 26 Nov 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639261; cv=fail; b=l2lsbRwnhaHO4vuAxmj1oRjTo/Nxey4smt2hwmpWZ3XcfxXU5y6Pt4vGwCzxe7GG8dDzl2cBkhYJhrSKf9mMF2Keeb62hJhhP8hTB2w6NV0z3P6wIKg7RO0V2xbqUSyOw5A7PMiTFXIrZgkmMmWEcYculUUdMpclsbCsxFzQmew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639261; c=relaxed/simple;
	bh=UOKBuMDvY+tVduSN1l9g0UZhTPj5B30a6ZbfMvyeC+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XEXGvBjoho0GILcd5ZV/ZrXla5GnzizJUwJcKtBX87OeNeLbnwmJ2ZPqVcAbvjff+lec8qrrW8JZqjmuWIvw1P501FKhT8C4Xq+hVkgxNttXjwfs5adAOlBQEoTNyRdzAEa5P48M9P9mEGml2XOBkmdqFjyR7lWFZSHrYIfjAL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mqAGPULY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y1C9ZUap; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mqAGPULY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y1C9ZUap"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQDLTAt023204;
	Tue, 26 Nov 2024 16:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=1cwGd/D5zzC/T8Pxkb
	FpwSQO7QB6LntR/Z3V6FpaH1I=; b=mqAGPULYMiXGia251Wi3j3GIDlTXZ/WqQk
	v8IU98h0BmCJF/eLR+mY/TWqhj2YRT1WMlh6ejsliafOxeAXm1iJotJU8OjocQnB
	rFkLQFmwmOgfP+2+vsBX5zR7LzU5d4CplHG4g0zsL6WPHRSwCKtCk6S6N5UbyL3d
	WWdylYvOFonmYA6nZyjqyJSHcIPe+cPgf3SLzJBDzjrXMdFH1GIvl5wzinRU6fBa
	C7urw2ZhaY2b0wJZpaiNa/nrbcJteBNojUXw3lBLcMvuxruUTs/VsmxLeSqZDqq2
	t7vSNF4JtCbLTW+ukqpOcD2XiIYTBdhTjwM8fXJpeiPS1Ad9UNMw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433838nyvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 16:40:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQGKpf6023494;
	Tue, 26 Nov 2024 16:39:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335g97d3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 16:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avxbKUE+3gQ/qiPqL3IWuNXuWeguSdGQXlT3BarWF6k8Zp5e7HSVNzcjtG6KWC9YhHNYXIEA2B5LC2vqiKYXO5ZrKi19jyUOn14ZqN24EjrTv/i4fB8+0NSAhA9j/eXKJrjpl354wikIBW+sYvVpi87ucUeeQVliAgMb9nO+wLMtWbI1FiVqH1keoNZvhOVNTdAj62xPWYvIb/tDsy0J4KwQuo2QwgrFwV75+yZPLOPb6eIBHcgfr5ZQ4TamygKgObL2ENQ4eIDdIbfZGPtSWeK0Dt0T0b9hXrPDVAYiS6mmV1U2bTbAahPwgiUJr3VXzwUETWh0SBrHdm/2p1cEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cwGd/D5zzC/T8PxkbFpwSQO7QB6LntR/Z3V6FpaH1I=;
 b=HfJ63DiT9RA5E901BckEm8xWdr5DRY5xMRWpLCAI8N4DFNBp1KJ0ap9J+2uxCel37wojrMAhBl5juwVOaFk6Bbg846IOOZLEouuJjKL4NlMCmH4LIcurpHv195k+3zv6VfCP0UQy01e8oMOgR10Lphj/s3WiwWAlRNfIelR79LyWCF8YHpAE0b2CXE+7Fnd27ZdR2LiJeQr1gDID0uK/mgF6LZJCsAsgwqKyzq9qeyqbRrRQ+5VPwYHVZsPcuIG2q5YINYG4yh2273m7YKxSxVGCobhb9mA8mR25xuivHdu4GzEv6bJmk7yv9MtNPCkx5SkWs2d9eBqOdgIMJEYpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cwGd/D5zzC/T8PxkbFpwSQO7QB6LntR/Z3V6FpaH1I=;
 b=Y1C9ZUapSarkLXH0dRjtNjpHsDxzKvAzTJ0tg+a70oQSsPx6QF5Ml+kzgoOcSRMc0JCNvI83J+B1phm8gDREqrhr0tJGbSCY+Y+B5wg4SKndbiPKmqs7tm2/to8ZmAZf1Ixqakb2sbPCkJ3AlI++u0nGztWfWDsGZD9Ll3LUuyM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA3PR10MB8188.namprd10.prod.outlook.com (2603:10b6:208:502::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 16:39:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 16:39:55 +0000
Date: Tue, 26 Nov 2024 16:39:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
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
        ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 0/1] Seal system mappings
Message-ID: <7494c3aa-378f-4bb6-bc44-59ea49ccc5e6@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125202021.3684919-1-jeffxu@google.com>
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA3PR10MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: a927face-af54-492a-634e-08dd0e38f528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZ7cfsyRXVrBTDhb4fKVcIzQemzjuNnmbUqHMzMiR3e2495IZeYkYk8jIL4W?=
 =?us-ascii?Q?5QD6gIb9gMrijC2AJfhDvA5EZouYE3iJhz/kVCNYEWe4cSpJTAXRCD1+BItw?=
 =?us-ascii?Q?hYRFDx7D6ZcRb8Thgf5LX749H/N7Utu48QkkTp5j81udfOsvmLNqj3YIWVzT?=
 =?us-ascii?Q?o9gFt6OePEaa80SqimWTfgrV7XVJ88GjRDDFAKCIh632Tv1bPJ655b9OApLH?=
 =?us-ascii?Q?ukeMLMDnTvG4R447T93TprakE5w9Iw1K5f77ikYPCrMq1+Pc7xPzB8/1HFb5?=
 =?us-ascii?Q?0qENF2blewYus1nrG+RCgCBUYD6nXu/iwNXU11ce+tSpY89AXkXm6HfebISi?=
 =?us-ascii?Q?GRCg0vJiQJAkckfptSGT1eroStfyM/fluxZSHBI5V8+THh3HTSUo0C4z/M9C?=
 =?us-ascii?Q?U6goIMjbdqdj5oYLxEl2Umw4bcQCNS5EtlY5aZ08fjEHmT89YEzbD6A2KlRZ?=
 =?us-ascii?Q?Xr03noOMfl1PtgGsMlC9RjanmX2qnANHikWo3BPYZB9OfEB+gN/XxM2CeiOe?=
 =?us-ascii?Q?FfC6GUYmrn3Sv67NQLvF95UztCSfpRs9jIDEmWa5b67Tw6AM4gmd1WmrydSe?=
 =?us-ascii?Q?Y+cZhnHSTA7sfSNXijYzYqSxpguqVqErS2KsI3/Q12xfjD4WOU42x7pSePic?=
 =?us-ascii?Q?vNhCDWYtif9Q5XE7o5Mn9mjFh7mGRL2NrqSsSeuXqUrlM+S2dzOoHiIFh+jQ?=
 =?us-ascii?Q?e4S3RwIPL4cTAOgIxqirQZKez0kLHvFFtAZEjueLeFXVwC5VIhuULFCoi4zx?=
 =?us-ascii?Q?wcnnBWaVG8IOhFVygp5xYLI76jgenO55fLAEe/jjYce/msV34Ws2fsRaNkCT?=
 =?us-ascii?Q?k94A/PEA15sa9Vdv+DWVy/vlEE84mcHFz7qKb6INZ8qDQejkMpqphghqNK+O?=
 =?us-ascii?Q?1sj8+ovNPGfcHYvCTM63lKnUyGwIjZq1DtW+3NwQHdnfwNUsvxP6n+3id+6m?=
 =?us-ascii?Q?SQQfmJaPgCL5xl566YtHqsA+seKmgn7qjodc6s9R/mJ14chrmxIE8RzAHIfX?=
 =?us-ascii?Q?HiOTA+f9Djiop+q7vBCkx2gA78uQ0/SrtHGWlfbtudHRx3Ew7ywOYPtmhdFE?=
 =?us-ascii?Q?RwyONodmlVVXQJ1Y9ZMa2OX+0mAel+muCAGUBwyPZkkDMxdn+p7lpjlPcluo?=
 =?us-ascii?Q?ElOqyHJNbG5x+6HXySI8UkoeTYqgP5cOtMR20Y86b2VxKXoDAm6GiKR3hmR1?=
 =?us-ascii?Q?fvsSZrQUqkaI013Dq9XpDk8Px4vqrrlyawGJJVB/JnBQK4pmPU0DyTIZ6LyA?=
 =?us-ascii?Q?ztkNk+ST0tavp+H1bZavA6wGpmav7U8bAbn9AWzN4Ua0hSAobyq9GkOiVnUP?=
 =?us-ascii?Q?GeeGbOxyW3HWqBGGnVtObXQoDSiet4DLOMA6oN3heaIxR79jLBT6uvurYUp0?=
 =?us-ascii?Q?OuFvzlY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YGgDwH0ynMjEsOVHC6zr5pJ21Qvt+DmO4pu3+UcnVRxJEReZ3/jvIJfmSbVf?=
 =?us-ascii?Q?r67uWkfwlAF0e8cOwLbgVTHNUrozQmHTL/IO7W4kTLertohLSR3CunR4uavP?=
 =?us-ascii?Q?LQPQm857tt/FOj95/6QzSftta3S9VB4WEWAnNAxwKOETJhtJhNZqEliGxak2?=
 =?us-ascii?Q?qdHIOdmyyLwlqN6JgpqVo3DHRRN0oBjt37DjRmaZEgjXNINANeYFDjzdJEGI?=
 =?us-ascii?Q?6INyC2z0Nko6N6L77DRRvTVqDklSVjprEz4khy8696v9pST9Or5rADlgruO8?=
 =?us-ascii?Q?ImQdl1Sb5hV8VDXbjRcTJOtlDuSCuRoccJcP5GyAITywirgXmub3bPfPR9Gw?=
 =?us-ascii?Q?ebjDYSZyJ0rfuHuvnbirLko9EbLRGDa24/O8y/CKop/pGK4UCm22/Lt6HcPq?=
 =?us-ascii?Q?aDRASrDtcB3shwoU4GTGhtJGL/oOwPAKRPWzRO7WIzEJOOCA9JHy0tpBLG58?=
 =?us-ascii?Q?CrXPFi6twobyitYR5ISf97LcZytxu0cppKFSenacMd6XS1E13yP+Y7mH//zS?=
 =?us-ascii?Q?2WG1z3kfUdk7IU4bJBrOwAfO/weiG6/eoqcErNn1cy8uM9TiP9SasCTo8Cq5?=
 =?us-ascii?Q?0RDHICtUZYo/HipKSPZftJe/0HsE7Ja9u1wV0mjmuEqu9/aQNn5oXW061ac/?=
 =?us-ascii?Q?VPMJI/HXc6LFG7X5zSvLAxXQYV1cbe4Tldto3xR2vdzr4DbSD2X6AA+pS/T3?=
 =?us-ascii?Q?t1pMPTyMl5wp6IwR4ZRTJu3Imr8u6TNHYw9+L9CdZeBjuzMj1pypWaFE5Ipj?=
 =?us-ascii?Q?6CRODNZ+G0pLVZ9QBz2jpjA7EcNpYARnSIn7A9a8oEOG3lNGCwGLBLU68WlV?=
 =?us-ascii?Q?1FAx8+dXYV/1o1TBpno+8+uegwuRizstO+HfeDBP4ZpobYBNL8i2VvhhrIJo?=
 =?us-ascii?Q?ApAQrWmVnyQEE1fmg5wDKJxl+VzFso2EqnHrzklQo0DMXcePaYdOaywOf7Eo?=
 =?us-ascii?Q?FXKk/QkC1A1SdzXU+vpSNiwQ8wv48e8ZfsVehJhxWf70i3nTzpltH8HEVAgj?=
 =?us-ascii?Q?8uC7XlfmX5OO6rpUy9tOibKoibAei9Q89G0BMnHgGsdoWoLqHGKX0i3iVyIY?=
 =?us-ascii?Q?d4+DK4Ku07xsjV42+wlLD6mtjv3ugzzrTLOb4Ecq/tk35yz1sEQ5gMT7+DNc?=
 =?us-ascii?Q?gM8qwmoE6gIa0wMBtWWlIntouFehj0trlDFKN9fc3uR0x0EgXvEeg7+EDSFF?=
 =?us-ascii?Q?FBA3NT4zz6Zbe9NPK+nCiddH/g2ho1zg1x6IjTZ52tUMiUd8XgcGJIFS5Dx3?=
 =?us-ascii?Q?raA3xx6qltTGWPbvRcnEU5zZ4jTunsW91HIyz/0flth8midkY35nVWK9PUg0?=
 =?us-ascii?Q?BaTPSk88NAhzNbbIhamvNAqXS4KU54wEimPzwWk+PR+ivm7rVZoDQQC1RjPP?=
 =?us-ascii?Q?xp8Mn3FTMNq+A/Tt9hg5sNgCQY04GLvz37PZ6b3bO8J9ynSV2VOnrLvoIsYa?=
 =?us-ascii?Q?BricEC75kPwKNYD5doxZXcOt8onZDiEjkwwLbjQN1/yx1eA9y/sM/JOnYj1V?=
 =?us-ascii?Q?58A2+P6nmAaojCPfJlBP4daJ6I7DF+qiFWY8kE9UaBkYpgJKgSyH/LiDv2+Q?=
 =?us-ascii?Q?IKnx4yI2iQgEWjt8XdowDuPdFqMNJlSQBKchCnOsh4L7g19OfhEoIIVRlIpz?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bn1jjW8sRbaTGLnMZ86feYXpS1IQiN/uDSNcukVIpyyShF/SbPQ79lVhPqVToes7m87vAgEPnPMdlD+C7Y/JHWmWwXSUOuMFq9xaBukf++kmNN4LxZJGHrhmLHR99rrzdrHxo0t1k+qu3/eEZg31r+qcBim59NZH7NHfFoXtPb6PI9zXIMFw46JJoOyETh+l2yGveCVlSVUam4xwIRqyw1iFwaQc+NH9t4W+/R/YPw5xDW5PdXW6+E6M14vkrw/vM+Nxtk/cLSqDe4A3VAqurtTNk0H5RvvcIvK+qdbh7rGPHWpvnBtzLNkXhktGX0i0J+u9PRr8brVavkjMOOvo8Cz+C8Ubs3+PDa7iJJ+YJ2LBKzPJ4/hTB6GtjwultaMun7iAyUs3uxAn2Zg9THNNliDbnMWO75a0naka1upWYqHSBs76qqHaTDxvRU2ZWNqa4JyDa0qvdbwnaFlxvFnLwM79Bo/fM58mGx7QjibhRettAq+fKXTAgDf0htKwoCNkP45u3czj12bITW1v5Pw0r+VGKpNl4rTR+hJeWRwVftQ0Btwd+iU9TWKOe5FFxPI5XAnyHWyrTUrn1EKp+bsxAPI/JaSzIMKUDyrY9jva9GM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a927face-af54-492a-634e-08dd0e38f528
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 16:39:55.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3fdBYZTUTtG5SonE+1c5zNMb8rTBC7GVRb+8sMoYIpzxmrcv7Ga2x94t41H1k10YuxIcyWdc5Xg+v8DBOXnvNRMf/1UOAK2eVQjPLKXdgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_14,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411260134
X-Proofpoint-ORIG-GUID: w2J1c5WP9ptZm5QiS-znVWLgVuqH3HJf
X-Proofpoint-GUID: w2J1c5WP9ptZm5QiS-znVWLgVuqH3HJf

+Vlastimil

Jeff... :)

Please review
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

You didn't cc- mantainers of code you are changing. And you reference my
name without cc'ing me here. I'm sure there's some relevant Taylor Swift
lyric...


On Mon, Nov 25, 2024 at 08:20:20PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Seal vdso, vvar, sigpage, uprobes and vsyscall.
>
> Those mappings are readonly or executable only, sealing can protect
> them from ever changing or unmapped during the life time of the process.
> For complete descriptions of memory sealing, please see mseal.rst [1].
>
> System mappings such as vdso, vvar, and sigpage (for arm) are
> generated by the kernel during program initialization, and are
> sealed after creation.
>
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [2]. It is sealed from creation.
>
> The vdso, vvar, sigpage, and uprobe mappings all invoke the
> _install_special_mapping() function. As no other mappings utilize this
> function, it is logical to incorporate sealing logic within
> _install_special_mapping(). This approach avoids the necessity of
> modifying code across various architecture-specific implementations.
>
> The vsyscall mapping, which has its own initialization function, is
> sealed in the XONLY case, it seems to be the most common and secure
> case of using vsyscall.
>
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the mapping of vdso, vvar, and sigpage during restore
> operations. Consequently, this feature cannot be universally enabled
> across all systems.
>
> Currently, memory sealing is only functional in a 64-bit kernel
> configuration.
>
> To enable this feature, the architecture needs to be tested to
> confirm that it doesn't unmap/remap system mappings during the
> the life time of the process. After the architecture enables
> ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> Alternatively, kernel command line (exec.seal_system_mappings)
> enables this feature also.
>
> This feature is tested using ChromeOS and Android on X86_64 and ARM64,
> therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
> Other architectures can enable this after testing. No specific hardware
> features from the CPU are needed.
>
> This feature's security enhancements will benefit ChromeOS, Android,
> and other secure-by-default systems.
>
> [1] Documentation/userspace-api/mseal.rst
> [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/
>
> History:
> V4:
>   ARCH_HAS_SEAL_SYSTEM_MAPPINGS (Lorenzo Stoakes)
>   test info (Lorenzo Stoakes)
>   Update  mseal.rst (Liam R. Howlett)
>   Update test_mremap_vdso.c (Liam R. Howlett)
>   Misc. style, comments, doc update (Liam R. Howlett)
>
> V3:
>   https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/
>   Revert uprobe to v1 logic (Oleg Nesterov)
>   use CONFIG_SEAL_SYSTEM_MAPPINGS instead of _ALWAYS/_NEVER (Kees Cook)
>   Move kernel cmd line from fs/exec.c to mm/mseal.c and misc. refactor (Liam R. Howlett)
>
> V2:
>   https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
>   Seal uprobe always (Oleg Nesterov)
>   Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg Nesterov)
>   Rebase to linux_main
>
> V1:
> https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/
>
> Jeff Xu (1):
>   exec: seal system mappings
>
>  .../admin-guide/kernel-parameters.txt         | 11 ++++++
>  Documentation/userspace-api/mseal.rst         |  4 ++
>  arch/arm64/Kconfig                            |  1 +
>  arch/x86/Kconfig                              |  1 +
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
>  include/linux/mm.h                            | 12 ++++++
>  init/Kconfig                                  | 25 ++++++++++++
>  mm/mmap.c                                     | 10 +++++
>  mm/mseal.c                                    | 39 +++++++++++++++++++
>  security/Kconfig                              | 24 ++++++++++++
>  10 files changed, 133 insertions(+), 2 deletions(-)
>
> --
> 2.47.0.338.g60cca15819-goog
>
