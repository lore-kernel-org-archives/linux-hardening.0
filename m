Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3E8494;
	Thu, 14 Nov 2024 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545738; cv=fail; b=sNbs2dnb74gPqFNcGXMkRrL/Ib7iueFgPAZCjwXKRKuDJNs7y7jO/ftDTtnpmDqOlugoYL/EDWXaEUMWDh8cL12ivN94HeXTIGB0c8W6/bZR73opt8m1jZDFFDnS0dKJWy0I+aqet9TEMW++da6CLSpOB3BL1bFItJL7dukpdDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545738; c=relaxed/simple;
	bh=0t2jlJTABec0WKnydVeLkkIXzDscfyHm3OWtJN9sciY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phna29bXiiDCtaeiqcZNgdxxtuwHLgcKhc3/Wvv+1jX6U1KRJtuUrPIPkNz3wlqykBXJmZEvD8jfpzD+7ZBo9Eh+Sk5GSWQrSapIY85JqSyiTFTIDbempXsfalhHNRruTwOFNjgaDpFiYA+biA5JA8AqxtIG3gdGZJurPl9S/VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mgFywm9c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uI9fyH6Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgFywm9c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uI9fyH6Q"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNBaql011027;
	Thu, 14 Nov 2024 00:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xoquei0oe04U4e3Ynr
	NzgGMuwFmTwhCIizD/XH85QHY=; b=mgFywm9ciHFjVHj3A2pdXIpq7jQLLKM8Ct
	T4HO2mY/mOEZeak0TXBP9sn7UshOP3nfqWKD9RJwoVmsOwbB6HWDX3ZMIIYjAw02
	EFQlCn1iFXJsrgHuFydq3tAgBdQa0Q1NEWE/BS51YFdCy2PlS1hGAWWQ8km4TqFi
	7Vb9V9RP6koUU4KUxCqcfSpo57OA25KjvqcNL4RWyT8nwOtAu+OpDIM5bw2klfog
	KKMy6TjAMtiKVrXRwHrL/7qjQVWLp8PjOI8YpW1//UFXhiX7BKpOQSgkcoehWjOB
	1897DRsGBS6NJDNePkQfFf5BtCPunBTHoJjCATEZ/fm7f6okxFQQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4ht9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 00:54:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNsEoj000384;
	Thu, 14 Nov 2024 00:54:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp9feen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 00:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSRMQrORzQmeEMJJ52oPaK5FY+UPTgqBPGgtcvPEQfs01mNNGFOVGDj9CB3Sg7ca7LjWh7fwvSoDYZ7Sbmwm+AmhD9iBhvkgH6sP90x85rF8SsZlYK6+hRb0i8/InYaG9hoDhvG41rCed9PW5lXJVjSoFmXjlPKXsTG/A7BP/i8WFRAPL8QIvpGLIf7CAsyT9TpFPSnUWFJtyGLqlFajB0lWxmrvfAv2srnrSYHKeLtuRHF2RznpdRmCevXXtxgaGYRmJaeAHH9xB0lwPeiWFPPvcQ8Q7yS/di3CNTRzaxUr9EQDvloanuCB3FbMgerotGbNtDs30MV+GFX6hbf41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoquei0oe04U4e3YnrNzgGMuwFmTwhCIizD/XH85QHY=;
 b=u28JfkKBnCbC0f1ORtBILdPxLVeHMRMqz0yKD7rpDwed926+sMGA5iqvLYKWu1fKcYvoH/lnikqEpyOFZZpgZm2l5U/eHCI3bODcV1YbIFZhpDNYuJoZ+M/idvQbOno7d6uW4bUwrnQLCoQwqoXq74Qcf6+pB8QX4RB49oK/fYkFxuoKIibK1hg1KIFTjg11Y0WDuLAx4E/WI/wjTzPN1m1HxMzmtFgLPvV+bYZJejtcgP+x2QJL57Gi/LTeoOdQZRrxc1zfuPjDqvPDWij99kM1iLqLIHx/py7VKKaPsCeh0IXTMnUETrMs1F9yv6ZOxqk7knNYwRM5EJOArZhAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoquei0oe04U4e3YnrNzgGMuwFmTwhCIizD/XH85QHY=;
 b=uI9fyH6QZdJ4+kc5WYRISJjsVKjZBXuaAMUhFgM37Xawjb6eAOi4n5jV6YYkhVd9odCHHaPqXuo3RCmsJPZp6h6i809+rkiRtdQoq/hItoy+emISBfxy7F7GxrvZeoDdFbNf56tta8WcZcYgvAAyHw1H/ynyXutYaJk+2ThPzmE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ2PR10MB7706.namprd10.prod.outlook.com (2603:10b6:a03:56f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 00:54:47 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 00:54:47 +0000
Date: Wed, 13 Nov 2024 19:54:41 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
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
        ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
        peterz@infradead.org, ardb@google.com, enh@google.com,
        rientjes@google.com, groeck@chromium.org, lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 1/1] exec: seal system mappings
Message-ID: <w2kg2rvvp3vwgqlvvtnne2dccnhjamc2g5zxm2ko47khkodedw@ftzp7ekf4sft>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
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
References: <20241113191602.3541870-1-jeffxu@google.com>
 <20241113191602.3541870-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113191602.3541870-2-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ2PR10MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de0f11a-f3e3-445b-ee27-08dd0446efad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W6aKI4U/4gHGb2Yc/mT93nUoKtGIi4TKINxVJVEDNKYqSE6tZo4PglZB7OEV?=
 =?us-ascii?Q?COd2QOReUY9pMviXqDxvdrQuAIJxoDacFR32snDtuC24S1pJD/JbgwYJWTA0?=
 =?us-ascii?Q?bXeB4qBVEjbrYOeYdlk9BVvWf51QfmOiuhohXIzUx5fmSv5oxDssP4m0ltP4?=
 =?us-ascii?Q?tT47QKooF9GIurKsMNOxKTot4TtClGETAv6K3ix9B8crKmMTEHLPv3htDa/y?=
 =?us-ascii?Q?C0mfuBzGgKGU3N8zAp6RXyyMLZwz6jwXbqM29dw+Y0ENTp3O9HzRZhjdO31C?=
 =?us-ascii?Q?yv4ihCHmBRq9bWTcwsNGUhOTlriLdl5XNbTDxcTVnJ//CQ7yEjnKqxNd9adP?=
 =?us-ascii?Q?70QiJbfOVOKmvvfI/+UmdlC2JEnyruGA4HrkzLQKHr1H0vauDNWLF/GPyOcr?=
 =?us-ascii?Q?pHDZ6Of5TwoV2OOpZMLtWx1/HixysbetmkqBQdbLpqnPrH/QfFyYKgUXg81A?=
 =?us-ascii?Q?06EkkTh5dWpUSY1p7UlJb0MwItnwKMSYEwUtHyc/f3OHz14v8zpjI2D8Xx1I?=
 =?us-ascii?Q?UO2EJTCGZ3oc3AtHzPgp4Sm4zZsOIeG1EdK7yZrw/IuAdR4l4PTOCLakOzZX?=
 =?us-ascii?Q?3nv16LtJNMIGJeKgVk5o94wrthM3+IEhXgFr5vGR2N5tCIMPjabP+frP4gvp?=
 =?us-ascii?Q?HljHwJ0wiahm1mN7Hx6DK3nf0HtNJV9RSlDMzxBR81Wai1ZPyQkJPCcmXIbn?=
 =?us-ascii?Q?3XO+ar7Q5rqNGqi97KDFnxn0EyrN/OE/KP5UgWaS+/dDQLQhBvvqk+GE2YF0?=
 =?us-ascii?Q?ePc33AgKTkz6V+mK4tuwpDu/um8J+XwQTKjRK/MrYEF9mqvdneQYpA2Lf9Ss?=
 =?us-ascii?Q?XX1f+D1+VQ7cUbEFlnc0fcC9r79qajBnSSJdjW+SKxDv75DoQt+jCbyA+twf?=
 =?us-ascii?Q?+rBZg7NwOvORHGyfD/XPtWxfjDDFZLy55MziknQuMyTQiTi4aFI5PTZki9je?=
 =?us-ascii?Q?QTWqS2RWPUJGXmOTfDOUVn4YNg0ItdnNvcnDe3jnNMgTd4fWZKP8wD+MC6nN?=
 =?us-ascii?Q?yav08JhO6/MEZOx/ZdmXwaxHuwxgY+56nAxZGM10qSo4RZiSAoPgWBcNUl9F?=
 =?us-ascii?Q?hA+oozbdfJ8x5WRq4JCO9lsQWuYcjZwTWHiUpVMWk+Voa/FWpBhdwpw7bJrV?=
 =?us-ascii?Q?eRp6TN44hW9JnsxJw/zWvupOrwfjxw+ePEQTguBzBlA3qOKH5DSPmMLZD3y7?=
 =?us-ascii?Q?ApA1oPrbOfKiz1BkZhndoW0xhbNRV0jPGN7CMjII9i/3jLKk4Y6msgoXpQpi?=
 =?us-ascii?Q?wcla3vJMQQ8To4R/bijnTnjUhgblpiofYxSo0fp9T3F0ZCPTgmFhV/Bthe27?=
 =?us-ascii?Q?BfEU0gO7Gs80HOvnWmT3wgGP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XrT7W0aYXwjT56uf3aOQyf096XmGYPVPBZEPODMQuxv0ZgtdkDTWjiMhUirO?=
 =?us-ascii?Q?tgGZdripA+NGgwbdWgyzKEqVpBwUugx1Jp8NgzZgYHbAqyyVtEY6tGid7r4/?=
 =?us-ascii?Q?7kWYKFsVOKGoV8nZfc5Xc9DQANOQBZmFuFUfrmFv923h2u+dVW8TOvz4rsmY?=
 =?us-ascii?Q?GgihePQy6YwHFQf2ASAEcis8CA35s2iHASsJ8KBJycUAnQ+FyYXImFoiyGqM?=
 =?us-ascii?Q?qTF1FChFiRBfLmgmFavfG0KI+AMoIwKeQJytXeh07mlJgKULLDKvmgrdyvgq?=
 =?us-ascii?Q?/Yt32ypiVVUYQLEDSMGtJkFGbfQCUzRsg/QMAkTD/tQo82iH8KPnEcn6Oh2W?=
 =?us-ascii?Q?NbWYAuIof/5SY2NDto1JpmQj70IgLXsny+TMjNy35guRp3xfZBy8uXxgRoih?=
 =?us-ascii?Q?vj1t7ycPtcBVpCO/i2s8batypEm6WvWPdPnysH/uuVwonYVBihzhaPDfz91n?=
 =?us-ascii?Q?Le96CD0K//xozfW+qP8XtKPOFfvQbzMHF8NvyhRR4UphBq+ZG3qPkc/d0Wuy?=
 =?us-ascii?Q?KGKXpMmFwAcYzQLIlIPN6C3lSQSWIp8LnlYNm7aFyy6GLmozGHPntflKt4SN?=
 =?us-ascii?Q?v12Qz9v9JyJJmgj6rtFqOdARUjAWK3p6aBpYoygAKIc1CkZcoF5MmmlsiPlm?=
 =?us-ascii?Q?lk3lRiH/8fSXn59QqwcBMufOkE8lpWWyw+kFvbPqlO5hZq9M4Mr0EXcivqHZ?=
 =?us-ascii?Q?r62wz12KoQENeJDs7Fi4ya+Co0qtsZD5/mR8IWSp1UJgpn3xVyEJdVWIptwy?=
 =?us-ascii?Q?565w17+0c2pq/aJayLOsUdPmrLGVsUmYdlrOClc6y/KBx70bESP8rk1KHudX?=
 =?us-ascii?Q?2nnPw1/vR0prku837yVhvw//VdukScqFPLatSOBWGOp7tmXLtSx4MldjUvcH?=
 =?us-ascii?Q?F+ofugticfG40p6ROq18pobsZRDNYF1kT9lwosYxmlm5zZf+NKJKcBmFwzo3?=
 =?us-ascii?Q?WCEZJRS6XPp3hCIRZA5ibOinWzcrjLmpqe2zN55ZLa6w+WXQDR3nSPdE3VQo?=
 =?us-ascii?Q?zYVpBC3o3szCAYE4bYF/yer/oJ8q4t2QVb9DxK3o3245tSt/5w4ECKYM4KqF?=
 =?us-ascii?Q?eD4kr+/YEnPULygrdH9/BYgo/X3EeygLFcDXZFpd+cDsqyrEXO+kOZaxsMiS?=
 =?us-ascii?Q?MD8WUQ4EDCwuSGQkmqKFfezA7YaOTGFtY3+XhYoJatofLbqKaupLhW3/kRjg?=
 =?us-ascii?Q?P3llpSSjvmGK8Hvb9hPjRzW6QuqUBtUDJbbZhvpLnRPWIUYHIFFG4ggVk3uw?=
 =?us-ascii?Q?NoLulMYkbzPDYB4Mu2N+bxqck7OfPt9SiAV8SeqpsSZ72aGildnI3VhUYL4W?=
 =?us-ascii?Q?1SHLLsuj3KScJxcLpJK+NQ+drLcrc6OqeDEn71/nZXCEwOq5thluTnqmqNoJ?=
 =?us-ascii?Q?lhQEL33YLnpr1mZ5mMe5moGo0bC/YVidP0gsLtIo3UkKjx+/4vLdn6Kva8kV?=
 =?us-ascii?Q?N1aUzyEF1wUtfv7Lj1uhFhyXRBtMNDAl+69gR3UvT9RE88RD3y8fmEsHVf9z?=
 =?us-ascii?Q?uHxPE1wkZ39OWzZR5r1YWSJ6Psa6GbaIEOoo4kE39upCddom+JLT+IxIDGUu?=
 =?us-ascii?Q?0cGTqjcOdZvXQtG37jxRmhrqsNA6CBgRNG/qBA6wpV08MSZ0tv8ywqAQyQng?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XBjWMR8MwXN66nDG4X/gfs+ADDfKLRgfhQHp93eU8a2RJCuVnIiJdaEgDJaLjHaAJYnCFP2pYpbh05JWdPfFM1BWvxDHSWlbYMur7ZU6tfqjmFfT320nPWWRaq7Fb/dUYX1qGGi3kKWttF8C7vG4kbV0KTvoqGhZYbyX+/mnP6ei1SuVorEgPUdG56TS4wxYK7uCUv+GrUJ589+OxI5y2gPD+UTDbNN0ziXMP1V3MFnEFIJ//z/4SUfSLwXYNPZlhchgOSvXq+dRxtff0lwqNt0w6uDQWGfYB6Cl4lnQvA4gTm3NdK8pF7iM28lENeISf4iay10Dw1HGxE5P5O/LgxvpfXOaCdc3arzhsG77LHAZULsUXv8s98Xa0d31Qqv54fsA3rZj6g1NGJ90CtCMxu2N01pJ/xD0cjsaG7r6qdqpesPkJD61t/ERIYXlKeI6jaPZPW2hIADiIKuIX32W8NVUjnqeLFVIdt2Jqh9o15ARGF/GSbZPRFblP99mYGLcxwkFIK9bGzrMOl/9wdAC3/CWtyQRQvRCR257vei30kcRpcnyJ7WyZaYYg5oezsr0huM236vWAErtkX6f1b95yH0Kxetg4iJIgvNqFBVZVWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de0f11a-f3e3-445b-ee27-08dd0446efad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 00:54:47.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBmUlGUtxlC4VZVkaBK7uVKGEOrBrnRAzizgtexjflrcvl3BXI7HfLB2y9PTxnq/Et2DuWnC8Jf7a2W4N7o5zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_17,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140004
X-Proofpoint-ORIG-GUID: 7dYDnD__r8-47OzgXfn6xygh_td3zEtk
X-Proofpoint-GUID: 7dYDnD__r8-47OzgXfn6xygh_td3zEtk

* jeffxu@chromium.org <jeffxu@chromium.org> [241113 14:16]:
> From: Jeff Xu <jeffxu@chromium.org>

Thanks, this looks much better.  Some minor things below.

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
> as the process's lifetime [1]. It is sealed from creation.

Why are you referencing mseal.rst for the uprobe mapping lifetime?  I
can't find anything in there about uprobe.

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
> across all systems. To address this, a kernel configuration option has
> been introduced to enable or disable this functionality.

It also can't be used on 32 bit systems, as per your kernel-parameters
changes (and mseal specification).  This is missing from the changelog.

> 
> [1] Documentation/userspace-api/mseal.rst
> [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  .../admin-guide/kernel-parameters.txt         | 10 +++++
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 ++++-
>  include/linux/mm.h                            | 12 ++++++
>  mm/mmap.c                                     | 10 +++++
>  mm/mseal.c                                    | 39 +++++++++++++++++++
>  security/Kconfig                              | 11 ++++++
>  6 files changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e7bfe1bde49e..469a65b3cf50 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1538,6 +1538,16 @@
>  			Permit 'security.evm' to be updated regardless of
>  			current integrity status.
>  
> +	exec.seal_system_mappings = [KNL]
> +			Format: { no | yes }
> +			Seal system mappings: vdso, vvar, sigpage, vsyscall,
> +			uprobe.
> +			This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPINGS
                             ^^^^^^^^^ overrides ?
> +			- 'no':  do not seal system mappings.
> +			- 'yes': seal system mappings.
> +			If not specified or invalid, default is the KCONFIG value.
> +			This option has no effect if CONFIG_64BIT=n
> +
>  	early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
>  			stages so cover more early boot allocations.
>  			Please note that as side effect some optimizations
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 2fb7d53cf333..185553376f39 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -366,8 +366,13 @@ void __init map_vsyscall(void)
>  		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
>  	}
>  
> -	if (vsyscall_mode == XONLY)
> -		vm_flags_init(&gate_vma, VM_EXEC);
> +	if (vsyscall_mode == XONLY) {
> +		unsigned long vm_flags = VM_EXEC;
> +
> +		vm_flags |= seal_system_mappings();
> +

nit, extra line here.

> +		vm_flags_init(&gate_vma, vm_flags);
> +	}
>  
>  	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
>  		     (unsigned long)VSYSCALL_ADDR);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index df0a5eac66b7..f787d6c85cbb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
>  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  
> +#ifdef CONFIG_64BIT
> +/*
> + * return VM_SEALED if seal system mapping is enabled.
> + */
> +unsigned long seal_system_mappings(void);
> +#else
> +static inline unsigned long seal_system_mappings(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 57fd5ab2abe7..bc694c555805 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapping(
>  	unsigned long addr, unsigned long len,
>  	unsigned long vm_flags, const struct vm_special_mapping *spec)
>  {
> +	/*
> +	 * At present, all mappings (vdso, vvar, sigpage, and uprobe) that
> +	 * invoke the _install_special_mapping function can be sealed.
> +	 * Therefore, it is logical to call the seal_system_mappings_enabled()
> +	 * function here. In the future, if this is not the case, i.e. if certain
> +	 * mappings cannot be sealed, then it would be necessary to move this
> +	 * check to the calling function.
> +	 */
> +	vm_flags |= seal_system_mappings();
> +

Thank you for making this change into an or operation with a single
function.  It is much easier to figure out what is going on.

But.. this will add the VM_SEALED flag on any 64bit architecture that
enables the SEAL_SYSTEM_MAPPINGS config.  That will happen by bots with
random config builds.  I don't know if they have test cases that
specifically unmap the vmas you are sealing (ppc64 probably tries to
unmap the vdso).

I do know that I've had syzbot bugs that unmap _all_ vmas.  I'm guessing
you will get bot notification on these failures for any 64bit
architecture.  You may want to look into it to avoid such fuzzing
failures, but we still need this to be tested somehow.

>  	return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
>  					&special_mapping_vmops);
>  }
> diff --git a/mm/mseal.c b/mm/mseal.c
> index ece977bd21e1..0a9d1e9faa28 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c

Thank you for moving this to mseal.c

> @@ -7,6 +7,7 @@
>   *  Author: Jeff Xu <jeffxu@chromium.org>
>   */
>  
> +#include <linux/fs_parser.h>
>  #include <linux/mempolicy.h>
>  #include <linux/mman.h>
>  #include <linux/mm.h>
> @@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
>  {
>  	return do_mseal(start, len, flags);
>  }
> +
> +/*
> + * Kernel cmdline overwrite for CONFIG_SEAL_SYSTEM_MAPPINGS

overwrite or override?  I think the difference is that overwrite implies
permanence where override doesn't.  I'm fine with either, it just reads
a bit odd to me.

> + */
> +enum seal_system_mappings_type {
> +	SEAL_SYSTEM_MAPPINGS_DISABLED,
> +	SEAL_SYSTEM_MAPPINGS_ENABLED
> +};
> +
> +static enum seal_system_mappings_type seal_system_mappings_v __ro_after_init =
> +	IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_ENABLED :
> +	SEAL_SYSTEM_MAPPINGS_DISABLED;
> +
> +static const struct constant_table value_table_sys_mapping[] __initconst = {
> +	{ "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> +	{ "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> +	{ }
> +};
> +
> +static int __init early_seal_system_mappings_override(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	seal_system_mappings_v = lookup_constant(value_table_sys_mapping,
> +			buf, seal_system_mappings_v);
> +	return 0;
> +}
> +
> +early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
> +
> +unsigned long seal_system_mappings(void)
> +{
> +	if (seal_system_mappings_v == SEAL_SYSTEM_MAPPINGS_ENABLED)
> +		return VM_SEALED;
> +
> +	return 0;
> +}
> diff --git a/security/Kconfig b/security/Kconfig
> index 28e685f53bd1..63b87a218943 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,17 @@ config PROC_MEM_NO_FORCE
>  
>  endchoice
>  
> +config SEAL_SYSTEM_MAPPINGS
> +	bool "seal system mappings"
> +	default n
> +	depends on 64BIT
> +	depends on !CHECKPOINT_RESTORE
> +	help
> +	  Seal system mappings such as vdso, vvar, sigpage, vsyscall, uprobes.
> +	  Note: CHECKPOINT_RESTORE might relocate vdso mapping during restore,
> +	  and remap will fail if the mapping is sealed, therefore
> +	  !CHECKPOINT_RESTORE is added as dependency.

You could also add a portion here about your override functionality on
command line. "this can be disabled or enabled by..."

I really think having something that can be found by searching for mseal
is really desirable here.  That is, make menuconfig, press / for search,
type mseal -> find this feature.  If this was MSEAL_SYSTEM_MAPPINGS,
searching for seal or mseal would work and would serve to link the
config option to the mseal document.

Right now there is no information in the help that will allow it to be
found by 'mseal'.  There is also nothing in the documentation that
states this exists, which you should probably update with this feature?

Thanks,
Liam
