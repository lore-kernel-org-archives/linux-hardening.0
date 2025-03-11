Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654D1917F4;
	Tue, 11 Mar 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700541; cv=fail; b=VwVfrqU/TCjKhHIS+sXof9cdNP8VrxorkRhBINIOF84zQISt/WO1BsTBKHjAHjcjArkCEEI8nE9uoGN04fyL8ip/wk3/rUSi8AIYKa3Ud6ebSXGVvENvkBbFQqaa3mepngzgtzN+Fa2IvpmSPmH+r/Hi2gXPVWBsmrRejVymji8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700541; c=relaxed/simple;
	bh=3fAPkmQIU2Sdpjw5sUlxTsZWeaiScyUtQJyHMcxOiBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HbQPEzfsBcs7Gt2Ay46II/Vc/nBzolWMezY+kkiHJKysgEgms7jfsc95etk3FMzV6Cx4Oiwj8u2pWnfiTG4d9wyeqmJ6rovCpTYaFDCT0b7qUKQhsbnTqU/fSgwXMniMZYDgG5ox/jrx8jH88i5EllZtSU2DOwgP6vswXL8F2/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dpzw4jBj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uZd7++qm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dpzw4jBj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uZd7++qm"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDN4LV008896;
	Tue, 11 Mar 2025 13:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3fAPkmQIU2Sdpjw5sU
	lxTsZWeaiScyUtQJyHMcxOiBY=; b=Dpzw4jBjHRUUx7aphYp8ZVwRrgPvSSuoNl
	uTjkdvkKAclZxCH+m0YyT0JjfTlsbuFxBxvFnHZe3h0RaD024HZydQUYp7qSHbjA
	YPqznsr/d7g7XmVGEksEHvLD0zANovhU/y9vXOmufsj6U9UxWyz1h5EpsAxCmp0i
	VpB8VA8DO+PX/rRM/nHnqv9KkXswJTB04PqLgh/a5KrguvuEp1fVOAPbA8i+gVn0
	w7Ql2LD5rDckn+zEQwmXZVU2VO5Hn7afYYgA17CWu+TVhoC2gUBdHfbNkTkP/D9R
	hgerHAq+x5VgWdRa0TvPmjOKDYmERSm/6u/OlaLwygv9S8XxXwVg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458caccudh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:42:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDN4fm030647;
	Tue, 11 Mar 2025 13:42:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcnd05u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfSPSzDwzxLmr6jpYQRitVsXKptoWoHRdhoXTYQpMEM4dxdKM1FiXDW2/Y+TdJTlTEiYj/aul+LnbHpeubo9Y8Vti+GYExwRly8S20H14CgOhntc3ndSgWp4kwY+7/O0QrmlgiPjWTEj2MxDivQaIH0BeDQI/qEV5BBgHl0gisDvxEhagqeGsvR805qN7Qm8aVytySNIaVcIvRUKWSftzbzBD8QoZmR5sbn/bLIOuvEll67XS7ZyVY8N3lQI3OtTIQIeuaeYvZrh7wEmneQnBfiQVApSbIMcWq/3YNkPYJkyPKhQLDO7Q0ffWdl00oX0YqFT8WXbT3TPyWFSRGMXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fAPkmQIU2Sdpjw5sUlxTsZWeaiScyUtQJyHMcxOiBY=;
 b=E7/Yw65jp0zSFyraMNygOyZ2Fl8bCgODoliER+avRR8eFs1tsVKonBnZ50+9ZYRTBTEt7iT2WqPQg3ah+ePUKZyeE509aWCN5VQoQdH572KL81khl2vUcKHSUUKQ1/0LC3MglbZbQzeAca77x5T3l9p44hTxqcAcHnSBeysBftfkQQL3oij6pPO0wrWbfz050efwPHeseqMT6hH6WZ1PyFjym5X467vLNNP0vMenK8svwxhVyBLQbDJZZvBzH/j7bIIHV62ScnNnaTY0OAkpRLKTTgKgBFw8c1hotKHT0fXnACjt7WrcQjiFU/V4s/Nyr2/5/D1xIVGwAnGyOEK8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fAPkmQIU2Sdpjw5sUlxTsZWeaiScyUtQJyHMcxOiBY=;
 b=uZd7++qmAquMIO49H4Oy7/TwZ+ks/8MxOiAwETkGAjDWqtkK6oT0hQ9vf+pRbutAjW/tRiI7bfEMtf9VLDq7d0fC9/BZpH1pV9b5GZ3GFNEJEuSUp/93WZn5IdRsvjN3awJ+IGRfUX4ynhEpNPxMa1B5//MUvzNLLXT+4kTiYf8=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA0PR10MB6794.namprd10.prod.outlook.com (2603:10b6:208:43a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 13:42:05 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 13:42:04 +0000
Date: Tue, 11 Mar 2025 13:42:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <kees@kernel.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH mm-unstable 0/2] mseal system mappings fix + s390
 enablement
Message-ID: <b8cf08ef-0125-466f-89d2-d499cbdcd3aa@lucifer.local>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <a326735d-ca3e-4aee-9f98-4e742dfc15f5@lucifer.local>
 <20250311133736.12846D42-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311133736.12846D42-hca@linux.ibm.com>
X-ClientProxiedBy: LO4P123CA0599.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA0PR10MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecf0da2-0f5b-4c89-ba6a-08dd60a2821f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iEWIkV08AVyTeqO9YXM0TDXL+7NP6MiCTtTnpN9JIFHXlvwB3HWAVZiNbNAm?=
 =?us-ascii?Q?O9MmEB6zzZGrcXpx5QblKoglC4ZMnQQcLpjw5pEwOZ96c5wUlVXPfAHE3Uc7?=
 =?us-ascii?Q?BojUYUlmYql/dWBjzHA7VARoHoYmeh5adM4aDLAGB0Edw6p/HuZtd+SLNL/9?=
 =?us-ascii?Q?AjKpABUzMKWIlhKlSgOH2YnOzFrcDZMHPrjb3+MnYe1aCR50LcJWIFfGTFkm?=
 =?us-ascii?Q?Yxk+nz9cz9YEnKLzcciWDxIb1aYnAoCTi85Gg1WSur0EhaD1P1jRCdMSI9XV?=
 =?us-ascii?Q?NCpri561QJ8lOg26JoVrlC0dTn14Wu/RTGwk/Zrh1ZvGuw9m8BT9Sl4g/YQp?=
 =?us-ascii?Q?vaSbHGFU329OrnHfOLLAQV97UBLfsJw06XDIxQEpLsjd3MDhZzk/OLQ5k8C0?=
 =?us-ascii?Q?/+TcpVfJNXqluf+t4CCLvUX7FaX5Mlk4JCUf4ZNkYukFp2u+J7fV32o08DiV?=
 =?us-ascii?Q?nIxKxhvp2G1CuCqZxRrCC/ePXSDmLpRCc1A3qLiJPPA+kd73kfMceFLyt+Fq?=
 =?us-ascii?Q?evEiqXWAIJ3D50MG5BtzbGEZxCp5QuPWnSuhNGs0pStg+b6VJlsHxwqENWhL?=
 =?us-ascii?Q?P7v+Dgx9UfqEeRYIavkWLJ8z6+VTRl84fB79LqFRySF8dD2ymMT7t8dMkMJJ?=
 =?us-ascii?Q?otIcxRk3mx2hxukbeo5PXrlm6ukzeeGRuj2d1T6RXjTNAqC1Fd7alCiWx2r0?=
 =?us-ascii?Q?g2T1jykWQOxUl3JLdY8l7mkgi7NHVbIs1Ar5eZlAjCycwsfS+TquaI+ZuB22?=
 =?us-ascii?Q?C1vMyLjVRCWUlXqd1HJuqkGeHdH6HiA6uBr19BKId2356jB82Y+jFLYwqwPr?=
 =?us-ascii?Q?AgpQi7tjS85Tgu5NyBF/nZVZrr5RJdTH5oB1G5IU82WKduNZltoJZg3ZdfAe?=
 =?us-ascii?Q?z37R9kzxy2KnErpFHQ1bbRlWOLczgHICTAjhHDqqxK7S21W5oEvHapQ+UI30?=
 =?us-ascii?Q?SVqmTfOvnS3et4bRMFdE+OJHK+s8/yxzQRgflRCcTL2yz3umUQ38Y8IX9yRh?=
 =?us-ascii?Q?qKaAaIa4iT1GT9WPEI7w6Uwji/hpMOT7CPE+CbnhtW4sDy6NSyaIVqxm7fvX?=
 =?us-ascii?Q?jN9Ylih7GnmwikzRa6XIPts4hB2wJ77XafOps1HLMN0LjqBPE3AFXn8hfOR8?=
 =?us-ascii?Q?vKX4XWnUx9G93aXHFZS/RkKTXeMOx6yAqhR3V6Ge1DJJ7lBkhsKkY8TWSd3a?=
 =?us-ascii?Q?YdJy6U+f29kLz+w3E2nzW0NXoKxsvjtoFqoBZQLM+8LwZV+g86ZNYJasO8e6?=
 =?us-ascii?Q?sY3tAtM3pjXyNkjas9fwWu0sv34L0iLDYvVM1tR9yvpxCglNvC/zZXuFtGdn?=
 =?us-ascii?Q?N8qe0jPKi8jO6D/wX7OAHqVp4fvakZB2XBZpe/2Qdx7RfgmmDNLyGdD+qoDl?=
 =?us-ascii?Q?PlnM++FHh8bpj/gCns+1gMK2wGaN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P1d4PDhG8OljT6fqYaKq7hoTENx8hd+u/Sf/iBNU+ODHJhmno5x0cC51GMge?=
 =?us-ascii?Q?RFfST/ZZ6Eem09YIRU6oIxdXe5hQ/3aN4G7wYMN7gf53UEp70yg2paf8RaSu?=
 =?us-ascii?Q?y+Z80fUsfo4rodWK5vfyBxDLxbpQtKNFH0/S6Do1GyrEKn997gPHna8DLIjh?=
 =?us-ascii?Q?SM71GWWB13L28ktMfz2zlZy63oCLv3F+INfX3afAwE3AZbCpyLSwg52Yf9ne?=
 =?us-ascii?Q?9qhEID1uVVVI8QHQ+wU5lh/LA27xLlmPJSeTqw2WKp/l30jyHVeUVX980GVf?=
 =?us-ascii?Q?ade3XsSyjhB+XzHuW6JfiJyR8Qjl68/QlhMIoP4NWEOCXGurxrXiGRSPpuKo?=
 =?us-ascii?Q?r6KoG9e9v6lg2wxdeHrWbBwazcBH6Ma122ck++eyK1NacDJ+d0BK305/FGGK?=
 =?us-ascii?Q?th9lZCuijojOOChOv0qhrWeo+K8sfDz3UVJu107FZyldkqSPoZBhcO3yrwCT?=
 =?us-ascii?Q?kU7cQfQiL662vKmOPulF0+WI/0356F6Xk7LgNjvkwHCTL/8opWU9dQkNuOwd?=
 =?us-ascii?Q?nP7jICEJ5SSGV281/TgMvFisU+/6O480anAtl5ihpgZnILEb21Bae/Dk9iM4?=
 =?us-ascii?Q?E48Ry5rpHZ4eJlvB6s4mqGiV4wB0FIb+nCFHGmKlyA5wVm5pNGME7KQFg9c2?=
 =?us-ascii?Q?ISJJYN2B7JabD2p34m9zMZnVatIsxl8AT+cWU9opJpKEv+PVHi2LfhhbvzCX?=
 =?us-ascii?Q?JX+7/HyLnr/F69LKU7F53Jh+ksnlGRv3JRSf8jw4+rTg3Nv+XlDZvoUSVFg0?=
 =?us-ascii?Q?FqVOqqCPz6KQx5vDVY0MXrdgHqB350P5rKHlVcXvoGwNe2KYH6smwll+zO6P?=
 =?us-ascii?Q?UFbp6715bm06Be4/OaZ6YuARuul/rvTtzTdKnFYx1in4V54wW48aQ801JaZy?=
 =?us-ascii?Q?kA2JUe1iicsm8PI/utuRa75ssbQLHEp/rfJ98frnnAqUC4vyw7XoTVMMTtwP?=
 =?us-ascii?Q?Ofy8D0sMbr9+KayJkZ3UKcuelyRtnEXCCsTUaiWRhFQ/XL7j6nBm086Oa+Kp?=
 =?us-ascii?Q?++FuWylqRd8CQuSrf6FF8iXwlv5pXImhiLSHHl7c1Xt/W14FkWw9WVGDX68Z?=
 =?us-ascii?Q?nHY63dQFVJXxh6ved2XwS5ivCetKqqHIWQDI5P5bUZulBsy6cyjPHNWB08Nm?=
 =?us-ascii?Q?AXRYcpbut4wlmU6xOTbysi6eRQvOoORZYddpZw4nn/cJRph4f8/S7cOW2t1c?=
 =?us-ascii?Q?fu/MHwg1mpCnGq+GEtIQdc1BR3hoEues5MJdFFFWxzZYKo02m0rtNoTV0Mm/?=
 =?us-ascii?Q?8tebM5SKNHXhFw6ZtfML08meTGLV6Ja0eBei3brvgXOFKiSQQW+QDyMaekKs?=
 =?us-ascii?Q?5qChxhqA12Rq2ecz+grnMD3pfGRTnplwTaH1m+QobUSxjukJ2vlKMeyilaHv?=
 =?us-ascii?Q?lpSYDRdlg7qW/zpjStWx495KnIpSG0LdxKH352HCA2uU2mh+eqhPEs2Pj4lL?=
 =?us-ascii?Q?Z8TrlEIHY0MIsz1mVTKCkkI+68tjvmTSTPjz4vvyY7DlVrA/+khhiWU+aVAu?=
 =?us-ascii?Q?ZbRb18vhwfxO15Iqw4XamZg7iW/u8uDpcQu364Ks7s9HoV948ZgQgP5f6qXU?=
 =?us-ascii?Q?p6l3C6OZuP03vz03+QpBQeWWw/Hc7FEoqy3WwpvTFict3sTNZxEtFBGDyT4Z?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bq2MQQZBMkglGM0zqzaEg4U1uO1HpsAlujZmDHp0fxVt269gYd3KOzpSIN56Km4SHDSXoPz3z2H1JgCx9ONmgDnzXa+aQA5e7xlPCXL2a1tO7EIxsQ7UKGsaCY6c1jhhRGfDXSL9iXpdz8PYormeQFSIS1yJesCDZYVTiY7h0gwOQ22KhvBjRih79HrJ8E7V2GRCkLMi5atwpKKyclnnoQKFxFfFvmzIeN9JjCv9r5H8QGSc9k/kU585onHiPiV+WBm/1RLpBcvGUqnKNSh5mKGyQSzI/jMVcVOmNqK48L65kXeBqQmgwmeTTcT+jgXbLciI0+D2iKsA8dkwRJ0D65H52xW/rkW5PgnsXNe5oO3Ybc//Tajm5rZ+zko24MQKLf+hr0uDk+nba9aA7Wu9H0vXGvC+pGq0fwrP0ByFPk+CPeT4V4lCLCG9KGBQIBY++ecAYo70/4aeezAQb1xh7wRQ3wAeCakNg6quLvQKuTrWSHmnN6Ii3i8xQaur8uS96Tz+TV9XiUMr7MnSLirjJMnr1GTqgMTQw7/po58B60KoWsCq5hu+CghRZ8z4rm7g/u27W61H6yEdrLkWebSIyYNBmwNmHioDU+3n7fzONzs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecf0da2-0f5b-4c89-ba6a-08dd60a2821f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 13:42:04.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+yMdLPLcOB+1kYdNAgfkC87yr0jO60oE7h0Lkw4zaNST4hk0MlvsljP0D+p+wp9R86WLI+ZwNBU1WuZigdu3VM1v8ZPNI9Dhv62YzZiD/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=789 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110087
X-Proofpoint-ORIG-GUID: ZPIBuvPihZ_qJya3Qu35OObOHcsi9Z9Q
X-Proofpoint-GUID: ZPIBuvPihZ_qJya3Qu35OObOHcsi9Z9Q

On Tue, Mar 11, 2025 at 02:37:36PM +0100, Heiko Carstens wrote:
> On Tue, Mar 11, 2025 at 01:02:47PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Mar 11, 2025 at 01:33:24PM +0100, Heiko Carstens wrote:
> > > When rebasing the mseal series on top of the generic vdso data storage
> > > the VM_SEALED_SYSMAP vm flag for the vvar mapping got lost. Add that again.
> >
> > I'm confused by this? Some merge patch resolution thing?
>
> See my other mail.
>
> > > Also add s390 support for MSEAL_SYSTEM_MAPPINGS.
> >
> > 'Also' = the whole thing this series does?
> >
> > Can you confirm that s390 absolutely does not rely upon
> > moving/manipulating/etc. the VDSO, VVAR, etc. mappings?
> >
> > You should say that here.
>
> Just like for arm64, and x86_64 the s390 part is just adding the new
> vm flag to the _install_mappings() call in vdso code. Otherwise there
> is nothing to be considered.

No, they are not just adding a flag, they are enabling the sealing of
system mappings, if a user chooses to make use of it, which already breaks
a number of useland applications that rely on remapping these.

if the architecture code ever needs to unmap/remap these, then this breaks
your architecture.

I think it would be sensible to clearly indicate that enabling this feature
does not break the s390 architecture and you've confirmed that by checking
the code and ensuring that nowhere does it rely upon doing this.

Likely that's the case, but I'd suggest you ought to make sure...

x86-64 and arm64 were checked for this and confirmed to not ever need this.

This is why we're restricting by architecture.
