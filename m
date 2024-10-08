Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6CE182C5;
	Tue,  8 Oct 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728354028; cv=fail; b=tYNS9Lxn83XK+XOm89xxpMmLGSrLao115HQgee4N3nw7HBhYdjdPME5LPAEW6Corz9J1pwT1KWBAZ7DM24kIfxuE0sD0pg35SurPsaeIgcFePybbwguMduWMslRkJiR3cHVj6pPEzYtmtF5JR73ILddkFDkkH+7EmULK8OF6dZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728354028; c=relaxed/simple;
	bh=8l2fI5z5aQ7xIzaGUJmiY907h+G4miXDsdzCdTMII94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKUB/dJVePCOWc8j68RRy80/T3ri8zvz6afWoPGYeLFfP1rxJF2B9sQRDQJ1es4XjO7ta8Y+whxSxCfYk8TthZxN08juXAQlw/LcBDK6VQRcIgamw1Ey9MqMU+rjMajpr4j68kUpF0KSjDpRf8PN9FcrRU03rEURqABYz2ZLNC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JsOzz69q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HgLo+rkg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JsOzz69q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HgLo+rkg"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4981McOv000647;
	Tue, 8 Oct 2024 02:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vMzDO2S6blWfoAZvuu1036ZNgD70LTPX5rTnIlNiyYE=; b=
	JsOzz69qinA1Hz9v1HwcZNLvN/D1ssnu8+CjXhIcZBqVIBVmJ34Ab0TFcGU76o9M
	dBbIXRENMZXSVMyuXoTT5OQecS8hNm71BdUaAxbiu6Mfgoczd+6lLlbDZ1/qZqeq
	lkR4TjZ4VshuQW24QbdZsjfkH9z3JWf6+0vpDqB+XwWzypKahyZhjeeQDXhxGYSk
	c+p5T1S3vqNRmRy3MPMbqiixFELHXLEDS0KRpgFkShmqzF71uPx0gMq7yWEQif/V
	gOOfXYDCdqkO2WfEknnAcNkkfTQw5yoVNLYNyby+TowwzBbs0P/r/47h+SLUyWPK
	i+TrGTfEtZvIleBtNbmXyQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ycs82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 02:19:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497Nlk4e024062;
	Tue, 8 Oct 2024 02:19:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwcuf3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 02:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6G7QBgLNAYaCT38j/HnIVXSHvthKNexFJtZbLy9Jy4O5kQw1XoCgNEfd2La7MjdYncUnPkj3hBrTfn5iyBKpvIRW8+nf498B1UI16HxZvIVrwfCI2EUjiMNbaVXx7YdSs4LIA9DNMLiRj5sMHdT/S/LXG9/gP/etlzgFB93v7Sbsf7aa5F7iZWrtfSZLptSC7LGqlEo0/FG6+2LemuyDUP96HaFuwBEFsCVcYpDYSE6NWbFYZgDJV0w/pLq1ng0Hk/9Lgj5WN4QuSJiaZruvSEsinlXhJrqFBjHxuXC5tf1Fa21WxDLTlfThl3EwrG91yv7vvB5nE8UWT0xnTXGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMzDO2S6blWfoAZvuu1036ZNgD70LTPX5rTnIlNiyYE=;
 b=ouY3Rodl9BBLJA3rysIUGh/GbvpbBIydPbndf2OmIe4pLIo5xgsyJOmL495FheeV0Thr1ELz9l0Ak+jUAQMsFDKwbkRbiL6EMlOLfO2jpkvlsY1kh7eO9D1Sedc1uqMdYPzFFf+EGYWDK+uDmJyMOj0uElHyQwfl1kfUkcjGEOMTvobMsRJpm1sLJ12bKcu4OdIMEpsS6hWBGyWbLxXlNjts1FB4UArFAO44u1fWXib2rYwKqUIQQhewltwFP8V25YTYFcLpWRMJEIklftBNQjTT3Nfd+4hbnBvmWyhgmsWR0GqTSh4+HErwHqd3DUZe921DIYRve1fF35LX+uP1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMzDO2S6blWfoAZvuu1036ZNgD70LTPX5rTnIlNiyYE=;
 b=HgLo+rkgbQLQpu39pGpkeZxw6C0r5QRmeVc+iNDxOnt2ZljtChhMBHAS6FriVyGdFIo0WeJ0JjVSqCQrC14kppL+ylBOQibfjagSWzMTlNyGV5HIHBVe/hZAqkv8uTFf3oDe/ZbOOLmmB1iJjjwAoClW+Sr60HSA8uR386z90Qw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH4PR10MB8052.namprd10.prod.outlook.com (2603:10b6:610:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 02:18:38 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 02:18:38 +0000
Date: Mon, 7 Oct 2024 22:18:34 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, mike.kravetz@oracle.com, Jason@zx2c4.com,
        deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com,
        mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org,
        ardb@google.com, enh@google.com, rientjes@google.com,
        groeck@chromium.org, lorenzo.stoakes@oracle.com,
        Jeff Xu <jeffxu@google.com>
Subject: Re: [RFC PATCH v1 0/1] seal system mappings
Message-ID: <v32x3rszfq7twguleqpj3xejsh6gtupput4dgfmvv357lxznqs@dy6fzjuhrs3v>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org, 
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, mike.kravetz@oracle.com, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, peterx@redhat.com, 
	hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, nathan_lynch@mentor.com, 
	dsafonov@virtuozzo.com, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com, Jeff Xu <jeffxu@google.com>
References: <20241004163155.3493183-1-jeffxu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241004163155.3493183-1-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH4PR10MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f51971d-65e3-4422-39fc-08dce73f851e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmxDZ0xhQWR5bm81OGNmVy82cy9tNDhNNFNhdjkvNVBMOGNFQWNEdkxEN01x?=
 =?utf-8?B?UnhBaWFhaVBwNkwyWVBWMG84Q1JCZHNsaTR1cUd2K0N1dWhxeE9mMlUyYkI5?=
 =?utf-8?B?Uy9KNGFBTGhldk4xaEw1YjNDbVVzb2k3d0JFVjEvaDlxSlRzR3lxdHphWDRs?=
 =?utf-8?B?cE4xYWZaZm5tNWRHM3N6SFNIaUoxSVk1Tmk4S2ZvVHVDZThPUFdsRnVFN2pY?=
 =?utf-8?B?YUVkUkEwWWhtNnJFbTZ0czArVlZKNSsrV0hLTDcwbGV1SEZXaXNWQUc1NnFM?=
 =?utf-8?B?Tmt2SlkxVGJTYkdDSlBaVWVTWTVWayt6THB1a2hQdGg0WWRNUWJIZ1NXU2lE?=
 =?utf-8?B?UlUvUjc2bzNVK1d6T1ZsYWtpSmFRQkFQY2RWL1B5OUk1QVk3NWVPWUJZQmht?=
 =?utf-8?B?QVR5aElCMGo0YXova1FtWFdYQlZhR1RnNXRmMHROYk95RDdXOHhjc09zQjZM?=
 =?utf-8?B?ekNVWFd5eU5Jdk1iSUxqbzJoRzNRc2x2RlFqTVZVZHVlUlZmYWVoL2IyV21h?=
 =?utf-8?B?UmRaS3dOZS9VVnNmZFRtY2VuZ0ZoQlZRMEUxTmN6WTNoTUpXMXVsL3dmcDdr?=
 =?utf-8?B?cVdYdEpwMmE2cG1sU0RIT0tqcm5PTG9RUHdKRElqVENxTXNaZFZOOG9jR3Bk?=
 =?utf-8?B?YjUvYmsrZGJwNHZ1VnpaVDJMZ0ttd0FjTFJsQVZidVRTZ1ljREdqUEF5VFJo?=
 =?utf-8?B?S2pGQ2h6OGt3U25lODM1ak1GYzlOYjA2dXFoeVpRQXJNWXM3ckkwZVdodFYr?=
 =?utf-8?B?WXhpR0s3b2NVditKd3cvMjlONEZ1UmhCVEhJUnVUbm1URHQ4b2N2M0dyMSti?=
 =?utf-8?B?MHg5a3BDSlpWRVNIZDQ2cFlMYWxOTDVaUXB1SDhTaUx1K2J2SkdzbFNSdkNH?=
 =?utf-8?B?bFIremg1aktXS255a1NjdWlpSnVLM2lUZEg3dnAwTHQxQ2gyT1lia1hBQjZn?=
 =?utf-8?B?eXF6QVZWbCtGYy84MEYzM0RxUis1clRLdVcvQmN0Wmk4Y21mcWMwZ0hKS3dy?=
 =?utf-8?B?UmxYY3o3bExZMkxxV1FxOSs1cDJFZ2d2V1oyYlo4WnFBUVlCVHA5eldKbTlT?=
 =?utf-8?B?Tk5jZFJwMzJSZ0d1aHpCaS9qUHRmQWdVNk9HMVZ0cGtBU1VPVE5HMnNGTzNP?=
 =?utf-8?B?cmRZTExncFZ0OUdMS1BVZC9wSTcyRXI5V1dGQ2wyOHRVYlg0MEJWNk1mb3pN?=
 =?utf-8?B?UE1VUWREMjQvVXRVM25PYVcrOGhZc2h2TGR6RTNvUldndkppK3RURFloKzkw?=
 =?utf-8?B?cTFjRFFoUmcwMDA4SVU0MHpxQUVBQURkbGMrMHBDT1ZmWHJRbjBkWWFNZGJP?=
 =?utf-8?B?L2l4NlBDaWJRbGZ3b2l6U3NiTmduN2ptVVhWK3dCbmR4clJKWkxxaWpNUFZh?=
 =?utf-8?B?SU5iTngzUU9hc21DaDRPOFBtbHI2OS9TZ3FuTGJjenZhZ1VXZDlSem5HWkVq?=
 =?utf-8?B?SDRBQ3FyY3JRSSsxQjZ0RXBzNXhmZUdlN0VIME16S2FFcmhkcEpBUnpVNGJP?=
 =?utf-8?B?VFVnYWRFNy9DZ1RpQVBCS3dmR2xKdVhjTThoNnorQzhvcWdFR1EvOE5vbzVH?=
 =?utf-8?B?V2tlL1lEbVlKVmxiTkhCVmdBb1NZRmFpTDhtZWpLVTJiTlhibXQzcG9ZVzZG?=
 =?utf-8?B?dEpJL0dxZXZiekJ0UWZ0akZzM2NYbjJZMFU3QytxeUEybGVaWTZJTVhIaEJZ?=
 =?utf-8?B?Q2FFNXl1WGRXQkxaQjhGa09Ua25WMEtuWjdSa04zZlpuc3NlbW4rS2V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTViejh1b3lpS0pFNm5ReE41Y1Q1d25OQTZJc294Lzd3QmZObVNJRXhrdUto?=
 =?utf-8?B?VFdkcERQdHNkMVpzdUN6L1RtN3oveXpvVmJWVWk3Uk56MnZOaVBObUNHL1JF?=
 =?utf-8?B?V3RUdElOTEhLd1ZhS1JFZGlzNnc4Mm1uNVl6UkpzZ2FpZW5PUEFtR2REdktR?=
 =?utf-8?B?NDMvZldvZlFjanYxWWo2Lzg0b1RCMExVNU5iVXVrbHBySWgzRGd0ckx0NmNj?=
 =?utf-8?B?Y1ArdUdZdnAvM1hWUzcyUTZnN1FiTjY2ellaWDQycy93ZUlPU1RBamhQeHMx?=
 =?utf-8?B?OGJlcGJZeVcxblJwSG5lRXY3bm1zL0pnbmNwNEEyRmZUMk5ETC9DMkxhRzNy?=
 =?utf-8?B?QXZSYW1STTg4UkE4VkJIY01QQzB6RlFYd3ZRcEdxOUVKN2V4TDRrVU9yMGlw?=
 =?utf-8?B?UWE1Q0Y4a1JQbVFMa3FLTzFsTGJYenorTkMvRWVFZDBicHNiTjlpakI0U1kz?=
 =?utf-8?B?c3doUmh2UDNlZVBvR012Mzd2QnBkNWZpWmdOVFd6TnovOEZkZlRCdEhCTzdp?=
 =?utf-8?B?d24ycmlhN3ExcE5ZVDYrVnN0QTE5bGxDS1dIeGxVcnRuNmp4QndSa0EzMmlC?=
 =?utf-8?B?UTRiWW05c1dzVjZtSW0xM2RVVkdVWGdUOUZtY2FVeVFtRlY3MHJoNG00RDA1?=
 =?utf-8?B?ZlE3b1JvME94SGRJamY5V0F0NC84Y3NQV08vYXBxcG9wTjVINE4yNElYSG9D?=
 =?utf-8?B?NVFWVDg1OHBZOTZKUDFaemNUcm11dkc5R0ViV0pkQ251V1g1ZzVFOVlXQ0JV?=
 =?utf-8?B?ZjUrT3o1RUo1VUJjME54amJiZ3M4eTM2bXc0Zk5hcklETDlXc2hzY0Zzd3Vq?=
 =?utf-8?B?WEljeE5EZ1QwamZXT3FyVnNTNzFVeXVJOGdoYXJNbUM4bDJjZzNESVdNY1Nv?=
 =?utf-8?B?ZkNhMTJNQ1NwMkhOY2tFQUlLUlpJWkpIUkZETVVJNGVtdSt6OWdjRlgrTHZP?=
 =?utf-8?B?VDRaRFRwUG1nWm85UzIvN1NoYm5hUEdKT00rMG1OS05TYTJ3L0NOOW5PRjU1?=
 =?utf-8?B?UGUvaEwzazVlR0pkVWtxMzF6UEJqZ3BhTUVEYjNJNC9nY3hrdGRMVUNPYnY2?=
 =?utf-8?B?eUJqd3U2R2g0US9pSVN4UEl0bGk5MjAvODFkbjdGUXh0eWk3R3VMQzk5UjR2?=
 =?utf-8?B?M05GUXFtc29jNDFVb2VPL0pTYjZJTEROcEVNc2VVUEVlRmxTOWh4RDVFWG0x?=
 =?utf-8?B?WGs4Y0lsSVBJTHFLOFVrL1VOQTlwc1AxYW5SbFdDRlRXMmhiVm5mY05pVWZE?=
 =?utf-8?B?Zm5COWEvTHJrbGt2ZVNNZzg4bDNlSEJKMTlWcjd5dlpIWkpTaGxsM2k1M3Ns?=
 =?utf-8?B?VFI2OWtUS3BoNXRJOGk5bTF2VFE3WG12Q1B4UXYzRXNJTTUrZGFxYWdzOFNj?=
 =?utf-8?B?UmVtTVhPWkh3YnJqaXVqODlEN1JFbVFVQ2pEdW5zbGs1VFlPcm92Um1LTmhG?=
 =?utf-8?B?UmFUVXVXSUc0T0cwbW9aTzFQb0NyU25pVWdpMFZlQWtWWlRyNHd1b3R1cUgx?=
 =?utf-8?B?MVhVdVNVbHRDdXFRUEVmcG95alEvZmpzY0RkRzlQZEphL0xCT3AvV2RNRy9i?=
 =?utf-8?B?MWJiMjRlaVNsVUZRZVVucDJicjlhdUxsT01xVzNuNWc2ZVA0RDIxOGRQamlY?=
 =?utf-8?B?NXdEcXh3TnpObER3dXBIVnMwZTVwQmZsQkNjc09nQXhWbzFoWUVMc2NmaGt2?=
 =?utf-8?B?ZklCVng3bW5jZGNXdDJEK3dnTERiSHFWa3VOY0hTYU5GdEJrSjZIOXQzUkpI?=
 =?utf-8?B?REI2UllYazNrb0x2M21PR0JXQmEvY1ptYzZCQkRwS1lpWDVBcW1TN1Y1ZU1s?=
 =?utf-8?B?R3p0TFV5eVFmTHdLeFhLOEFwVjloc09PaUZLTS8wTkdNMkJzTUs4M1hDTjRx?=
 =?utf-8?B?U0dKWnBPZjEzd1RLU0plclBZZzAyd3ZPVmc0NU9WNEdtNjdtUnJKR2dKNzZJ?=
 =?utf-8?B?anJoc091NHZRZmpadG9zQWtzWlY2bjh3SWhxemFCMTl1M1V1MUZGcFJXcWRn?=
 =?utf-8?B?TDc4dWxYOWlkUmZ6VHRaLzZ1bTdEUFp4YWZJUlYrdjRLVkFzK2sySG1rRmVi?=
 =?utf-8?B?Vjdpc0VlN080bkhqTEFhblhYOWZhQWkwd01XOW9nUGdGM3E3UDI2L1F6T2Mv?=
 =?utf-8?Q?JAjamwmw0N00TMP1Qf/bVt72G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ew73HTszgpNFB8F1hE2IhOXRVLD5TqZM0voJnuzYoxshP4GrLSrLl0AnZxp5uIQ+JlGVl6jdSSUABil/L8dwf/2ba5d3jILqH5rP0Cw//VRD8N25gD2U0djDGVVk7FzdZkR+zRepBiqkHVTb6dBDfplqS7uxSwgSS7JbKqaDT6XyMB9sPrjnK6IRxYdj93qL926nCgQq7y5nk8nelrxTUl5BAVNF+r4eHffDMFcj0QEyTxuIkafrEsHOQ2xNn1xq+nnhi6A9Ak07MmXHOj+Xbt0vTBmDTIfipTtkuDFP/S0aCGuuG2ElXn/uq/WlrWpoSVD5H4qv2HYNr3ErsY0V97RDPadAv2G12M+dJ8K7gGiIahpISTX49DBqMInaQdWDJsibGG2htDQ7a74xiEjaIAg9O/5K/YsM6y1j45HokbqZo5GYFpyUS4LlswdnQV5IoG2htJtvUJXXWf5OOw4g5CaNbIg6P4+FQqBozJPh8XDgcUOKn6lAvhnBHxqJyibsIcpIQUgMzs3JnqQ+55Fij4z2jDZEmGOC5pPMRPuXOEuPQ8+2HBl1I6/acjmVOhSiMWJb/vLU+P0VQFG0Nvn0TYYcTnzyChN4MqirW0FQhwg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f51971d-65e3-4422-39fc-08dce73f851e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 02:18:38.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNRKoZ28ZHts3yWM1gGXjgoD34oPlx1skoIztZgahue4JOZLxqmbNXTc8S/654to9NVuCXyJHIMm8NvIDqas6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_01,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080013
X-Proofpoint-ORIG-GUID: ZraNbgO-GbMsfTFs-SjbH-21zxhsd8p8
X-Proofpoint-GUID: ZraNbgO-GbMsfTFs-SjbH-21zxhsd8p8

* jeffxu@chromium.org <jeffxu@chromium.org> [241004 12:32]:
> From: Jeff Xu <jeffxu@google.com>
>=20
> Seal vdso, vvar, sigpage, uprobes and vsyscall.
>=20
> Those mappings are readonly or executable only, sealing can protect
> them from ever changing during the life time of the process.
>=20
> System mappings such as vdso, vvar, and sigpage (for arm) are
> generated by the kernel during program initialization. These mappings
> are designated as non-writable, and sealing them will prevent them
> from ever becoming writeable.

But it also means they cannot be unmapped, right?

I'm not saying it's a thing people should, but recent conversations
with the ppc people seem to indicate that people do 'things' to the vdso
such as removing it.

Won't this change mean they cannot do that, at least if mseal is enabled
on ppc64?  In which case we would have a different special mapping for
powerpc, or any other platform that wants to be able to unmap the vdso
(or vvar or whatever else?)

In fact, I came across people removing the vdso to catch callers to
those functions which they didn't want to allow.  In this case enabling
the security of mseal would not allow them to stop applications from
vdso calls.  Again, I'm not saying this is a good (or bad) idea but it
happening.

>=20
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [1], thus sealable.
>=20
> The vdso, vvar, sigpage, and uprobe mappings all invoke the
> _install_special_mapping() function. As no other mappings utilize this
> function, it is logical to incorporate sealing logic within
> _install_special_mapping(). This approach avoids the necessity of
> modifying code across various architecture-specific implementations.
>=20
> The vsyscall mapping, which has its own initialization function, is
> sealed in the XONLY case, it seems to be the most common and secure
> case of using vsyscall.
>=20
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the mapping of vdso, vvar, and sigpage during restore
> operations. Consequently, this feature cannot be universally enabled
> across all systems. To address this, a kernel configuration option has
> been introduced to enable or disable this functionality. I tested
> CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS, which doesn=E2=80=99t u=
se
> CHECKPOINT_RESTORE, to verify the sealing works.

I am hesitant to say that CRIU is the only user of moving the vdso, as
the ppc people wanted the ability for the fallback methods to still
function when the vdso was unmapped.

I am not sure we can change the user expected behaviour based on a
configuration option; users may be able to mmap/munmap but may not be
able to boot their own kernel, but maybe it's okay?

>=20
> [1] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL=
-NrCZxYAyg@mail.gmail.com/
>=20
> Jeff Xu (1):
>   exec: seal system mappings
>=20
>  .../admin-guide/kernel-parameters.txt         |  9 ++++
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
>  fs/exec.c                                     | 53 +++++++++++++++++++
>  include/linux/fs.h                            |  1 +
>  mm/mmap.c                                     |  1 +
>  security/Kconfig                              | 26 +++++++++
>  6 files changed, 97 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.47.0.rc0.187.ge670bccf7e-goog
>=20
