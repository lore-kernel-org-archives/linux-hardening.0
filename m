Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154942036F2;
	Wed, 13 Nov 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530230; cv=fail; b=lhveIA/53+fFzvmLMPUEZg5BM0cJ2+aKBfHu020M+XR29uQHiaYxh1wQTuP8kUyyF0l45U2cNkkZuEQdUJBFhHzT3bDBC4PY3aeNj++9DdwIG1PAIdmxRJlDd1eEHV6IwhdWrnQwkj7WQaSjYbEVclEs1QQTyRhiPUSEi/c8QlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530230; c=relaxed/simple;
	bh=FWjADJ5WEakQdCUV3WGP2j1azc7wj/fPkt+C3dTYGTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MCWbokwKNUIvcia3eNu1JD002rJPTmAojHdeT35yVeYiJyFkHpc68t+WMrGfe9RNuSKj6iSTWGUdWNcV7PN+HcXiwdaRznz85eZ+rDpScMgxQT4+UQA+ZHAUcSNi1NeeWS0LR0/4NmrNhMmFuXo+XIY6kusiQAOQAcgtYOaR8yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jCovXfNr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LFfEvoU2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jCovXfNr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LFfEvoU2"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBcgp022649;
	Wed, 13 Nov 2024 20:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ZZ1bAlQPrjmxhVAxHI
	22hJp1VZf89GEqpQGiX4Mv1g8=; b=jCovXfNrw6gCNlLL/iz34HUbEsmxgxpJZO
	zOGKgzXjo4uYV7DbnR3Gt+4pKQRH088qUpDm4Rw6swIZM9ex5oSfYVgq5TqM1hKQ
	J4MFXDIOqW88fw6OwcC1zKaLHNrKeaWQ2mPI0tszDO46IGURRcq8fnzK2s9EbGFl
	8Qovj2AcBN2Buanwp9Rz4wFathQ7CRBEfQLWEgrhOC1Jx6NjppV3bWDqlmRiTA17
	wO1mwz5fdvpxl3WT0m9ldE79p+O43p75/2ns1iJn/NvpUTg7ReCvthatiLSt5wgi
	fykS8IfGjE61CfmctMAsKR215iAsB/65rgZ9OA2uR6tYo3lGIlhg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4hekh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 20:36:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIxaap022744;
	Wed, 13 Nov 2024 20:36:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw0bdax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 20:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTHbqcEAx6FMa71Yjf0j/+Fm5swrGATo6Xdr8Rf1zw0e+tnyRosGYVOfKH9Uh6z/5vTMa1wjyEHxzeQZCxAZWnanyG5qP2QxiEFdE8G0QXfXVZfOUnhmswcsOclc+3T9Zb2sN5/NzXN2LuSITvnPwar4OY+QclG5nzs21tqHIize2k5DuKEyGcILxHA0HtlKHntRodxlF5uX79peQm/kap4ELXF4F37h/ZeXvWbCgI3KrsVZc76SRjD9XuszczbKjFBcW531Zop/KM6cfdEfTVeDss0PoBhYaWocLJD9YVaPGG/OWxpfXSP+qVFQ6gxHTHBoYdxvrVw7Qx1qpGxEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ1bAlQPrjmxhVAxHI22hJp1VZf89GEqpQGiX4Mv1g8=;
 b=SpyMbuarKqi8t0uPaeE/Fv2N+rDgQGUtKp+lIyp/nU+FjrIXrWMPa19aCNSfZAUZtzQeM+a3d7yrZ14SS032r/D3gInaYGNHTWll2gGnL+ZMQpYVB7GJQPR9VHsIiQiVqPA0GAF1BV0mLdcfmLvb01NvgOh/PxjnAm0hbpiVN4fSYcPSqXanNKgykDfViY9b2TpA+kPwec/T/liHy2YRdI7QkCNvVIVL4YAYWlhOukezHx2fXDpLPqdLYkvZ0BIW/NtFzBZUdLtR6peAeG5h597UhgbRI+eSw9iXBwx66xiuMUhziNKV7ymWihggKVHoK5Ltr7CEm5rJEfbFRCtt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ1bAlQPrjmxhVAxHI22hJp1VZf89GEqpQGiX4Mv1g8=;
 b=LFfEvoU2lfkeMz1VOUuLY8TmAR29LMHCvWySoWNQHyVQ5evU+ZBSqPg9q7vOc1WalZdaPBzOSnfsVkAE2HQSz1AfaBjRHHyh/2l1eIUp0VCYbeI3hLVT8k7C9xpCGQTlTN1Vb8to9fuDZnlplDLn0tnsFldORoBinEKizFmVCA0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7954.namprd10.prod.outlook.com (2603:10b6:8:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.31; Wed, 13 Nov
 2024 20:36:08 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 20:36:08 +0000
Date: Wed, 13 Nov 2024 20:36:02 +0000
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
        enh@google.com, rientjes@google.com, groeck@chromium.org
Subject: Re: [PATCH v3 0/1] seal system mappings
Message-ID: <14600b0e-6d6f-4ee3-9230-3d1f7b807710@lucifer.local>
References: <20241113191602.3541870-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113191602.3541870-1-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dea26e2-ba47-4f7a-51e1-08dd0422cd5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AssWcoRiQzb4oHIhGwPcOdbeSRdOn8LY/74sFKQw0v4+FQd3SlLb7p5/Ee/7?=
 =?us-ascii?Q?Hbk9xrTlEliEnu2reU2jC7JmARh8rTkU554GOY+G9eneu2L8bLrpe7Ut4K2S?=
 =?us-ascii?Q?OQQwjnMimxbegraMBYU3kJG63izipJRbYgwvGmV6ef1jvmZahimYuEKbxRNY?=
 =?us-ascii?Q?vJifRCeYhMOq0dxjrlXiHjO/ryp0YW5mB0XyQrl3WZKsIUTck/YKUPNb+Axs?=
 =?us-ascii?Q?sJ4kE7YULO74FAN0dhS5rSR3AmVCa70sK+6r3SxlvNDmK+79qR3NAal46vGD?=
 =?us-ascii?Q?DJNOlW7cZ2vitfAHEgm6n6qkz1JDV884wDQhtT5boUAXYKWI5xXY0JzB+xxV?=
 =?us-ascii?Q?3gNzOZbkUNoKc2oGU4KOEcH//Ia6LtiZb++J9qM+cwB2lZz1SoFdz2405C6K?=
 =?us-ascii?Q?YsXWYO0pGmmDDyzaGxiDndfP3nEu37eRVKzyNxVK155OWpDpCtrn/TDz4tlF?=
 =?us-ascii?Q?BKuoek6O2/TxqzKjkTsOd+/vwPygoY+4AAO+MLuNnj/V17F1kRs0DQqOmNE4?=
 =?us-ascii?Q?ihiGtUDuT//CL6iCXh9CPteg373MgVRjE5XH8NryLPKAIKrFtGBiWBbSm4fD?=
 =?us-ascii?Q?X7vsxMWyA2MWmsGeyF7OpvCSjXe+YrFL1ironabwIeegjpeDOkxDrQq8Cfrq?=
 =?us-ascii?Q?QJ+ibZc4PIAUZpw/IOxddeToo7F2laKlDTznAcFgByquc8yLJdndFnzJmHHK?=
 =?us-ascii?Q?PYbcnbXN8qRqRR/SKtiXw8Tb3tbUKbYfCoSyaTdsvf2FCEN9NqOtmThtULy0?=
 =?us-ascii?Q?H0prgrbfBwsHDtCPPn4+UEDqzdFrIjMg5YAjOBCYWCGcoPhplkKu9spqu7PU?=
 =?us-ascii?Q?wbv5picFsMfCEpNmNR29xpadPjUj0DsFUI0ECvaI+NizA/+isMar8y2DbadL?=
 =?us-ascii?Q?q9QKq7XIOu52m+cMbwHtdp0DEjT91Eg0ky8Bu0eQN7QrEYc88Jm/v+g8Yce/?=
 =?us-ascii?Q?fQY8PA2ybIPe8Lx6hAaosYm+VX4IyqfywUcSsZScUyPfYZkFQadmgmUq6OiB?=
 =?us-ascii?Q?uHC2X1xVF3LOoTzN7j1OMfop4aNh+5t0Ftjk//Pg2JOPmcRRKONf3HErljGZ?=
 =?us-ascii?Q?vIXH4xfSMShV0JHqV5cQHP+h4X29wyVzUs6lLis2S8A6gKjlBKuvUYfpsk/5?=
 =?us-ascii?Q?oO/Z2dzULsNrpY+fBw19dM/b/bYhelgLPgWqjqiIRwaeWUYjFpVQbutaAZGP?=
 =?us-ascii?Q?iN9P+6X09RcqIvvR5ldRvUP7V+/bG3+7yqH+oahm1+yv/5eN9D6RWmBTQB54?=
 =?us-ascii?Q?vTEQt1SFNR32e5pOIa6QNUqvthpo/7GHdK+LHJGXXVB8k3aGU9ZE/5gKjE02?=
 =?us-ascii?Q?a6EbZ6XUG+tx7Koct3O5Ng88?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eR44vm0tc+Ye56TVZiM+DDjm3DJfEPyXzMJt2ikfVz3x2qurHUslilhOF377?=
 =?us-ascii?Q?hLHM4CR51WHIx/1et6FuNxaPW9LNTMhL0basRvujaerXDozNsFtgQj9kV4po?=
 =?us-ascii?Q?vtXrafu8tcjnWsik4BHTrPnqrRiRDL6TYZCmJzYOHbblyyEX6f9l2r7tlpMp?=
 =?us-ascii?Q?9uAVYTW2etW8s9mG4TN8HdrAXnGeRNwFL/OVzWMyvu28s887xuNZoEg3R9CP?=
 =?us-ascii?Q?GkAnvhnSwcovztMjGaKDK5qokRcXS211eupJviDOhKdJCNpeYWk7LGGFh7jF?=
 =?us-ascii?Q?ez4kvpp/f/qeFi6Z/CbEHH5Uww0wb6tibKJY+3Wwpgse3qYLRuAHa94dPeUe?=
 =?us-ascii?Q?G3HxtAykZ3Owz5XgBOnDGlgxHyV/2b2rQpqw15ipFszyaUWE8pzeEF/ZC7Kj?=
 =?us-ascii?Q?mlBp9Eg88T7ZtiWgFOargKAhbYhXthlODkdo1ERiF87DQw+vePP5wq1r9fkO?=
 =?us-ascii?Q?WROQyv05jlkrsaQnjFWD6lXnQhXelrN8/zenDJAUVMFgw8o1HL/CUGTnNNi6?=
 =?us-ascii?Q?ZjAWeR+yBIQA+CYNNOmjjOin6+64SkY69r2GAdPy606vtUXGnq6lRFCqvzqZ?=
 =?us-ascii?Q?9OQYoH48GLre3h7LeJMZKkzhh+Up9zuZEy2PpQBPp3me+o/Wkq1CaR/mc2q6?=
 =?us-ascii?Q?CZc/UJdHIKpqEEaZRK6kS+mft12oDnmLGES46RhRVXPxz+Gm03x29idIyOzW?=
 =?us-ascii?Q?bXXe/sltB4OCDrz7NWDhSX4szt6Nb8cUWORQk5RILDFVNsWWY5XLBcwzvRLH?=
 =?us-ascii?Q?FHPljkivJPbg1TBR6aTd9giuqzOjBaUswAe12iWIRM/QkPCNoYqvlhsyNFl1?=
 =?us-ascii?Q?Xsc4hOWiAIeu4YS0DFqzofofecSqeiQctpooGpGyA8AxMWYAIf1hgEXR3xIx?=
 =?us-ascii?Q?gIT6AhztLgjpOdcysOoUylC63p3pAREHwveYEXCn2jZwU6rzRkCj8xgXtyuc?=
 =?us-ascii?Q?6I2O4Pz4e8++7RFKJbsm7eJewIg5chhajm3gTvhAqDrWPtCoDEjBFPzkHXUO?=
 =?us-ascii?Q?G/4u4uwTUEwqdHm79bGu+QfSPNmE/KSqLW1VakygQMZTrc6AkxHM0tm5IXT4?=
 =?us-ascii?Q?lkUCCUC8q5AK5OGveriphS6AKWBFQriN9xx6xT4C/vru0wN2LHpLBjkB5XMS?=
 =?us-ascii?Q?wf2XetURxsF5DFYnYKmo+OF+9yp5Mjn99WmxBCDYiK9k6J8mhM7VqSP5zIbz?=
 =?us-ascii?Q?mS8d7NkkUCPqZD+Qr/BhaKfzcBJU0rApTHWwZQDJBWLRJLytRaNLMq1vTPP9?=
 =?us-ascii?Q?t37kbKpHOLb9FvwlEC8aQ3uSCvHE+e5vqGAcPjcEg+FUlgYgm30/MHO63Ktc?=
 =?us-ascii?Q?66jjdiMdULdszvIGw++hbSNLteOp+t7BWEeFphFuHVDH6XpQPgGFSXDTMciw?=
 =?us-ascii?Q?sXuvsC5Nm2Sg0qutgguwojED2uOAvp6c+z1JOP2dsMVY04/JqkC6QWfaMjXM?=
 =?us-ascii?Q?Gv0YgjPMjbunknDQMrLef3mfxAdHJSGpUQ697SgMx8unZiToHX+FuVwdel0L?=
 =?us-ascii?Q?p2h4sbUUK86YGfsqhXMgmCpgPbjba6JfVMhspTC7o4nFrsfwy5mMRP0qeFY6?=
 =?us-ascii?Q?Y5ZDLHrX460StBhCi5K3GvOylzo9Iz5WNk7zou+201ECghXIWEbXafo3st7n?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KtijnIXl1NWOuR4UDvb/EP1TD9Dt3HywoYoGYn+GMXhv7Wjg6x20fPypZ2jA9iF80NgcazPzxKJ11C53xhYVrlACw6/tFaQvqVQIYpO43CwlG1M+8kXk6s2pNFFxgOJc3EmYQuJ+C6YK8x4hReyU9HSjzRfPmyOWlsiu4Lo68b3IObyCr50kN5ZPh20Q2M+7AICaZI2VlYWpEzT+RUS8u0Tqn3FUgCh/8k6gaRUHf9H0OLhihHi/9ma0KQ40oiHksB49I9PRDNW/WGAn4Tpo0+VpAStjzSdFQT0Bo/yAsvZMUTErMFg1D+gdzAkBIK+dta79lnrauyQtlMcPgcQUXTm0Ev8KPCLCVhYfvqgFwoLlkBuitVb5ag1hEGSS2rGODIgK/GalBSJWra5OxHPc3j/YDUEjzHjL3pLaZSRDm6RCBv0t1D20I8d+LidCBXD8ShOD90PpTBq9pUJZCNm1l3dQtws5MQp7WRqdd3ssKKVisl8gm502OFKjtN9m1Fge/UXDJLHzfVRP8pUp398t9pZFNDcvFwYUkPZ7fMxoaIMwudfgdITOVTIhY4g3Vzf8Cn3MzZE4lvJSeCzIokgjibFeHH9JS3xq18dYOxcNpIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dea26e2-ba47-4f7a-51e1-08dd0422cd5c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:36:07.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n/ZqloB9lvo0RuGYCal3A3QbwMothgym+TIzbeEFOYfYseBq16bFFXd6vfQF4eYdjf0u6rE/oAbF354u6YzWbGL72Eqixbey7XYYxKCVgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_12,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130169
X-Proofpoint-ORIG-GUID: 9JW3-fmidsGJEeEzDjQVjB2qy7v2CCv_
X-Proofpoint-GUID: 9JW3-fmidsGJEeEzDjQVjB2qy7v2CCv_

You left kernel test bots and review unanswered on v2, which makes it
difficult to know whether you actually addressed everything.

Please respond to all outstanding comments in the v2 thread so we know,
thanks, even if it is to say 'this is no longer an issue as v3 addresses'.

On Wed, Nov 13, 2024 at 07:16:01PM +0000, jeffxu@chromium.org wrote:
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
> as the process's lifetime [1]. It is sealed from creation.
>
> The vdso, vvar, sigpage, and uprobe mappings all invoke the
> _install_special_mapping() function. As no other mappings utilize this
> function, it is logical to incorporate sealing logic within
> _install_special_mapping(). This approach avoids the necessity of
> modifying code across various architecture-specific implementations.

Some arches unmap VDSO's which mseal prevents, so are those broken now? Did
you test this?

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
>
> [1] Documentation/userspace-api/mseal.rst
> [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/

I don't see any mention to testing, and this affects multiple different
architectures.

Please describe what testing you performed and on what architectures.

I suggest we allow this only for architectures you have explicitly tested,
especially as this is 'hidden' from arch maintainers who might find this
change surprising.

>
> History:
> V3:
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
>  .../admin-guide/kernel-parameters.txt         | 10 +++++
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 ++++-
>  include/linux/mm.h                            | 12 ++++++
>  mm/mmap.c                                     | 10 +++++
>  mm/mseal.c                                    | 39 +++++++++++++++++++
>  security/Kconfig                              | 11 ++++++
>  6 files changed, 89 insertions(+), 2 deletions(-)
>
> --
> 2.47.0.277.g8800431eea-goog
>
