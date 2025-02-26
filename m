Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8616F282;
	Wed, 26 Feb 2025 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549928; cv=fail; b=by5hEx/MakgI80MigGh1ktEgeu+ZCQw43UwFXgW4jU6ZbTVcYaZNXn5JMuWrRuOBxyhirMYm1Yqvv39CcsapadA9li3EE0X63BERkmdh6r2G7IrUJh2MpGFCbY8hpz6/37JjiCg22/mdUuRnyOGYpnxcIF4QDt+H15GbCsYqqWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549928; c=relaxed/simple;
	bh=W2kOFdJ7iQ3gdnZJITp9HIN2UtHaGGsacxTEIeQI8iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Icgdg44LyJ7iXGfVWGL440p05wacXH/gjtB167VuNFzAkLTROR6G6e+/a+RHpQCM+WJljBfCR8Fb33Fk7UTaArB/jReXAtJ6w0WVHDhgj1JTnleMjDfUu4PdhneiphXdRvgEzt6I3nL64b0jjHN9sAGOOItPl41UbS3Ji+9aWAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BQDyoLYO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xqyzTEpj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQDyoLYO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xqyzTEpj"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5YZMC020828;
	Wed, 26 Feb 2025 06:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=L4P8iCNFbUrRVL9WZRG3mtjzxcAhWoCdkOGNQeKZmJg=; b=
	BQDyoLYOd1RVNGRGkl83AIf8SwtAuqT5SndEDgnzHkHurTGGZHZrkYePTwEMNHYB
	bpTnRSCAzHC02cZ+tbmq10B+Lg692kPlIdqLIzKDU2g3kTjcElweraB9BIfI1VlB
	S95m3uLCMbpl40jjECm/zIcZgwSuwCpg6at8+JpRANQS5WNkaJAFyW6coCFDm4jH
	lRs4WgzJyQ5OLlhKP5j/nK1i3GN1H0A7CI4Yswb5JB3pflcCVNNHCodYY02Hed53
	a9kjDZ4ACarz9h47V3OzgFmhGCZRTZEHY8RAkI//nOTpgQ82LVAqQsHj7rBTWZ+I
	nughqs9ScaJEXD0S8um23A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf0du5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 06:04:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q3iXVe007531;
	Wed, 26 Feb 2025 06:04:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51g8pwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 06:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfWRNfwScUnO9Q3hxa92Dqt+kYygBV/P/ihmOCoz8r5NVDtuNjhsaH3uy/SYCdp/hHz7C2CHQV0niwkdY1uw2seOQkIm/vBrcOH3rJwhsqsJq6/DmJcN+ha/ir4s2/G4s5xFmpVe4xSThD6+XrETB8UTIRnpRqZjsSZT7Uc7S5idMNJ/LGMojCAGb80jxbk7dcJsbloNkCzsLTRPohc6k125w748I6VrRlOeVnX8pvjv6oRdThDx7CqigUuTCa47Kun/T6yYnOXVkpLxpYCmQtOiCvGdyz8rxo65LUc1H6WTKfmgoVgnqITbVLEZ2nYq58keIMrY6PEJn7Dsdc1yLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4P8iCNFbUrRVL9WZRG3mtjzxcAhWoCdkOGNQeKZmJg=;
 b=A058K3duytka59jdgt9uiwUa4qUdheVZY1rJIC4jRVvA2Pq3ny4+7OoVZlV3WS3ozkp8yGN/QTkSIo5/I8e9dmU7upgrvDnEYEzAy9yGMQIKAm0pnLxqmUug/Lkl51MgCSx0fd8L6Rmiy5TTDNrihqz7bBZeyNzpH0Su+KU2PUXu26eKntL0SiIfOXASMcglGvzHZQfaEQ8PLJI8Z5r1621u00sB7w7/td3lNE0jzQRDTpyJ7yTSUpVEHVOXVx2e1LPwCJ6+Hmfdgd/5oBMKEK/z78OHOiERrI4FRWCok7Cs5/urIGz07CsFZjluRTjVaB3+045Lenb1CULZbru4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4P8iCNFbUrRVL9WZRG3mtjzxcAhWoCdkOGNQeKZmJg=;
 b=xqyzTEpjVlzyMbDjNeFkKwnW1jS9YAVUfCkBGFMlBqDQRzMbovIruGaWHlfwan0q/AEBg5qbTcu8MbPUdq3GH6msvAMk8HkRvMiA1IThdQUh3xUWuzh337+skOazULUm5nxa3oD7WRp0rihWJl2+S5yNHKiYyfOE/ubbxyrGjfg=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH3PPFAE1A1621A.namprd10.prod.outlook.com (2603:10b6:518:1::7bd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 06:04:36 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 06:04:36 +0000
Date: Wed, 26 Feb 2025 06:04:34 +0000
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
Message-ID: <b7a38abf-f102-47b4-b085-213298c51aae@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-2-jeffxu@google.com>
 <9abd68d9-3e6d-46a0-b92c-5aee0a90abf3@lucifer.local>
 <CABi2SkXT0z9YFsEkf3-HH0r_NuXXs_SJid9yzjuu0SwuxxWmZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXT0z9YFsEkf3-HH0r_NuXXs_SJid9yzjuu0SwuxxWmZw@mail.gmail.com>
X-ClientProxiedBy: LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::18) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH3PPFAE1A1621A:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b6fea8-99b3-458d-d1b7-08dd562b72a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3gzZ2dhZXhINnUwbjhUVWpyQVhtYllManVxZkhwZElneVhYcTdwWWZzd01K?=
 =?utf-8?B?N0NDMmJIOGhhWXlOb1plWHA0Q2dSQ3J0T3ZUempwRUcrQkh4eWlYUDRNOW52?=
 =?utf-8?B?Vzg0QmdaTVVMQkpGb2tKamtNUWIrY1dnTTQxZUYzRjBuNU1EckdCOGdnNFdz?=
 =?utf-8?B?ZzlMbU95U1ExYWhyTmlFT1dVTlJTRkpUMGpHUGFvM3ZVSGQ2VmdjSHA3Z2VH?=
 =?utf-8?B?VjF6R3FOcXJ1UnZ0OFdIQ2pLV0I0cU1ScHBwUlF5N1lkRUVmN2k5ejk1Yy9U?=
 =?utf-8?B?dEp2T3VjZlExSUlleTBsdlZDdzZHTEF5WlREWDRrcHExaE53T0JZWE5kbDg5?=
 =?utf-8?B?bThGS3dLSnVDeHRUNWwxejdsYUpRQlI3bnlhOTdrUDdTajAwREdZNDhNTkpW?=
 =?utf-8?B?dkRQb2F3TmpPaEZ1RUFGb3JuNkExWGlBTjNuRERiRXRzeVd4UzRCcGlRL3Aw?=
 =?utf-8?B?KzRTQ2IycWVBendXei9HMzI0ZUJBN2tNbzJIeVMzSCt6bUduSW0rU29qWmtx?=
 =?utf-8?B?SlJ2TXR5YmpqT2tpcHMvVEVFNEx2NTFHRlJiM1ovYXBEaVRkRVpZUUQzZlJV?=
 =?utf-8?B?S1BaQTRuMjlQa2plL0hxWnNtZ0h2TjdlYlA1RDNMMGZDWHkvVTlDZm5lVDU5?=
 =?utf-8?B?WW1mT0hWbkh3em5pWm9zVzFDd2VYalVaU1cwTjVyTStlaXpzU09ibTlPT0li?=
 =?utf-8?B?UVBPY1lXY01sajYveWJwb1QwWHdqeFVCWWx4NWN2cUNrSW04dnhJcmF4aFkz?=
 =?utf-8?B?RHUwQ3RTK29DRlRYc0tXNXFsWnljOElMK3M4M1J6TlFvT2U5aXBWbG1KNlJQ?=
 =?utf-8?B?NkFkSUM3bFJJS0x2cDNRYmFtZnNIMk1qTHhvZ09iaE5yMGw4YzB5M0NiNXZy?=
 =?utf-8?B?QVRaUVBMbk03Um1wT1UvK3pMdWRWdURMYWpHRXdCZnhEVmdianZuTTQ3YVFH?=
 =?utf-8?B?aVRwUHZub1N6WlhER1o0Mk5PU1hTNlBML09iK1A1MEFuU2JTdkdqQXUwcGhO?=
 =?utf-8?B?Um1EWWc4S2hiN25wTklhMnpCc3VkUnlrSlNyLzc4Wll4VHlrVncwdG1QSE9w?=
 =?utf-8?B?NFE0VkdoOUgvNWkra2FDVVRjcHNPeGJPT2RGMXRpMzN5MnJOdk5nL3l4dlFZ?=
 =?utf-8?B?TTJVeHhhSEZEWGpiVTFjQVhWaHJxQ2ZKUlNHaVZuQUFOcnBLa1dkQnR2a0x0?=
 =?utf-8?B?SUVpTXZwd3BQYW9Eb2xmZVJ0dXI4OXRPakV2Sk9PK1ZqVHRPWWJsVUJDM0pE?=
 =?utf-8?B?YTJIUDN3VmhZSHZGNHFHdGZoNkErd3lHZHRKWGZkUWt0RkxmeXFja0d1T294?=
 =?utf-8?B?Q3ZxU2xrcmFpbmYvZG4yWWh1ckI5dWppNVRzQ1V0TTF4UHF5OWhVakdsOGRy?=
 =?utf-8?B?ODF3WDBQWk95S0ZIQ29UUC9CYkdKTUwrQm8zRDIwMXB3a21xbnBwRi9pZWZw?=
 =?utf-8?B?T3dWTSthRUNOaEtzMWx3dFE3NVpQdWlBbU9FVTh2K3BHRSs1d1hrUmdubUxq?=
 =?utf-8?B?Q2tyUmxWa1cxZXpEMmFGc2RsRXBkVE82dUxJaUxUbjhTdG5SVEQxQTR5OUJJ?=
 =?utf-8?B?OEdnYURKK1V3bCs0Q0FWdlJNRUxUT1pTNS9wdUZqM2xBRVFoTEJsektCY2k4?=
 =?utf-8?B?d0U4WGtSTlAwYXRaZ2xzN0NqUEJhejlXeG5wNGpMNVV5ckxpUThlamIvWXBj?=
 =?utf-8?B?U0I2bmNBZGt3Q0tTS0tWbnQyanZDcWNDTXY5cWNVVlAyNW05ZG5kbDJHT3Zn?=
 =?utf-8?B?Rndtbm1SSkRaUzdqU2poZDBiZmdCSithYmZKeG5oTGJDZGhWb29EcEE3NWJ0?=
 =?utf-8?B?aG1Vd01Pc1VqOWNQc2ZSa0o2SnJHeE5NVDRvRzdJUDZBUFQySk5YQ1A1d21Q?=
 =?utf-8?Q?RiNw0Wfj66y73?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODdOTVU4TXd3TFdCZzlxem5HZGw0ZUhjNTZVSk12c0FkZlFIZnRhYXhqZCtq?=
 =?utf-8?B?NC9jb25udk9GcURpRUtRT2t4NDFmQW5wd1JzYk4xTHprUnFmcW84U1Bmczkz?=
 =?utf-8?B?VFNQZ2Rwc2VRNGtnNmtHbXdPLzRwNFY1SHdOOHptVGVYNkhubVZadW1QKzR4?=
 =?utf-8?B?TXZOdnZFVHJWWElYU2ZCYktTcHNaSGFBeGdwcjhzTldzMSt6K1J2S0xFTzV1?=
 =?utf-8?B?WHJzY3c2RCtyak5MN01ENDR3Wnh4OVZqdDduam51UWhXbE5OWWFYYlljRTVH?=
 =?utf-8?B?ZnFrNEpLd0EwRkdzS0g2UzdHME94SVRxYjF3S0JxaFg4MkQ1bmV4YXdndU44?=
 =?utf-8?B?ZmZLY3BpOWhxRlpNcU14bG8xYnJrRGJmaTlSbGk0dEd6OXNRWnBXZmliYnFu?=
 =?utf-8?B?SW9LS2dnY0U3d25ydE9XMStxMkxEN0dFeURhNUZFZ0hLdWdhL1ZhRE8vSEF0?=
 =?utf-8?B?ZGxtYXBYaE5DRzJYQVdDRlI2K0VZYW5vK01XYlFCUG9wM3FzSTNocmEzMG9x?=
 =?utf-8?B?V09FU2dLNmZIVVpaeEc2eC9HNHlucU5pVzF4bFRPdDVtZnN4bzdLR0JFTFZR?=
 =?utf-8?B?Tjh2dDUzaGxDeUJsam00WnhXczFWQkNkT3Eyd1NIUVpXRlk0TGRqekNhNmJl?=
 =?utf-8?B?T2FoVmNqc0FEbDFHN0hXR01WOENFZk9VZnZzRzZmUzIrTStFWFN4Wlowc3Iy?=
 =?utf-8?B?d09KekpsUUM0eGpQcEJzdEpITUtVNUVSaS85Q2hHWGJGK2pZK1hSRDBIbGFQ?=
 =?utf-8?B?S21TcDZsYlpzS3QvaitrYUl6QjVNMldRRE0yd3Fqc0NEazdiRnJZa1JaZ3No?=
 =?utf-8?B?bzIyS1BsczVENjJZa0hjUDVoVFZST29GZ1ZFN0FSRHowUm54NThFeGJuU0ky?=
 =?utf-8?B?YmUvRVpVK1k2S0hvM0FiYVd6eFMyZjU1L0FkZDRlUVRZMTFXOE5ES1Y1STNT?=
 =?utf-8?B?RWd0MC9mWkIyL3B4Z3FIRU03d1R2cHREQi80WklnUDNjd1R6QThHeW1Jb1cz?=
 =?utf-8?B?Q1NrWUtZc1lpQ0lnZmt3UEFzcnM1VGdJNDdlSi9SeHczZFBsb1MxbFpNVThn?=
 =?utf-8?B?Rk14d2xGYUJUNEV3Z0hZakZPM2p2VFJjRWRseWRRQmc3TVRSbUJZdEEwZTEx?=
 =?utf-8?B?RDFYN1BKYWRlaDB5bk9acFFmNUxNN0d4ckxQOU93KzhTbXlHSnQ4eDVrVjZ5?=
 =?utf-8?B?bktVTWFrOFVsa1ZNQ0hOWHZTekJYNWF2NE1GNVdreWhrQkNiR3V5cG5nSXJv?=
 =?utf-8?B?aUZVZTZFbDI5czYxUkpoWThFeGFSckpzb1hwSS9wVHoyYmtDSy9DVDd6Z2Ji?=
 =?utf-8?B?a2E0SVdZeGdCYkxuclRVT3FCT0RlVFcwYnUzVS9LTm5QQWlraDFRK3B6UXJU?=
 =?utf-8?B?OGo2c09TbHdubkpXWDQzN0hTMUZSYlRzb25QZitzT1hCbGFZOGg3NDJDVzhp?=
 =?utf-8?B?Z08yMlUxbXVqYitsVzQ1K1Yyc0RRSnYwZ2Fybm90QkJHS0hhSVhhNmpLZ1pV?=
 =?utf-8?B?S3UyRDVyREFZUDVCaHZsdnpidkxDbStNcWtTTmExOTlXZTBNYTdsckY0dExY?=
 =?utf-8?B?OVZhSHNLQ3Vqb0ltS3crbnVTT1NicG1kTWR6S2Y4QlBNcmpYbE9jQmlQY0Z0?=
 =?utf-8?B?R1F0a1Fhb1czRFdWOGdtd2Y1VEZWYzloTk5XSlVWekNpc2kvUFNIUmhqVkFR?=
 =?utf-8?B?S1VyZ3o0Vis2MjJRMmFlN24vcGFqc3BLOUJLd2VVbEFQNGR6eTVROVJ1WUla?=
 =?utf-8?B?VnZOQ0V1UWJGZkhWeDc0Z2J3bjEyMUZYVlhVZnZYRkNIQlpUbnZEakRLa1Ir?=
 =?utf-8?B?V3E3ZzlPRlhMV2lWdTJnVmhaOFRUVTd5eGhQWUFpMnBjR2ZndU04SGlkTXo1?=
 =?utf-8?B?ejh5blpVQmRTRmpSbFV1b0U1eG9vVHpjYkJRYmdCM1c2b013MWJiOVRmbXZJ?=
 =?utf-8?B?dEdBZnVsOVpGZTI4UDNxMEo3WEorUDlnMFl5LzNoeWd6ZEZ1dVViMGxrVTZa?=
 =?utf-8?B?a0x2cjdTbUFmTFFXNVlCVVE5V0JEVVJEaGdZRm4vYng3clNkNWY0bDh6SUVH?=
 =?utf-8?B?dlUwN1paQnVodEZTUnpvK2J6V2tqLytwU1FsSkhBS2tTOG9MdWErcEErS21T?=
 =?utf-8?B?WEZSS0RLckZvc3A0TGdvMVY1MGM0QlFoaHVHZlFXVmdSM05FOUw5Tnh1TmdM?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bN59+sXvXex4/ofqeBMS0z5Bjb2gi4p54FvfcY2ymufmaWbIVUtcLhkHobVq9OlvLc1ioVvza4g5GJvGyxij8gZt5QuESJ1/eY4pL5ZN+uyb8jWCibtgRX5X63UCay9GHes9Mh2MFQecTDCY35ChKUgK8GLTbjdfm1+7vdLFpKbgIyoyKzyJXJHdh+QVnBX5ddEAKSsU9HhIk37zrcctGbFGI5GP3yBSA19Wl1y2DKASvkAOLM1im8CqcTs7ksClkYZ3cmBMjhiBwySxxywIUl+88Hj6a8aIuZ8oYOv49/3LzQrg8EtToJmMtGxyZieQyfjJeb0msP6mUFtv/lk29r35oWYOqYdOG829jlQ8Wqc9gYdS7sX6SgG183EnnpF1O8Qz6yQwEAhAQxuh/CUePPlcyKhsbHg6IOQqVB80WYbTTLbwsiidmdMfc3mjC5nY32JLjjBs76FhfY3GcFBVCGWV9cHXWW455Vw3vzs2RezX7eIBg5g92OH3gNN1DlKOarjOC118C/W6KC2K+mnpBzEEF/97jCjFVuMqYBBkiyWI8B8fdhPRsHAWdUIqJ/1L9xsiPYPj8tSc7vza36W2atJGWVGik/+U8fOwHJo70nw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b6fea8-99b3-458d-d1b7-08dd562b72a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 06:04:36.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NStNnJMnx/SOlW82dxxYoEooHF7Xqq7BwRXH1UZtqvoGvpI0w9tZRmPG6hCWOj0XMYABM9NYb/Mga7lgesW/8rUQxBjzz0xzJNAXEa1kt2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAE1A1621A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260046
X-Proofpoint-ORIG-GUID: KfhSsrZE4K5Nq5dXZI64kQ5TdAesUw-k
X-Proofpoint-GUID: KfhSsrZE4K5Nq5dXZI64kQ5TdAesUw-k

On Tue, Feb 25, 2025 at 05:33:24PM -0800, Jeff Xu wrote:
> On Mon, Feb 24, 2025 at 10:05 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > +     bool
> > > +     help
> > > +       Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > > +
> > > +       A 64-bit kernel is required for the memory sealing feature.
> > > +       No specific hardware features from the CPU are needed.
> > > +
> > > +       To enable this feature, the architecture needs to update their
> > > +       special mappings calls to include the sealing flag and confirm
> > > +       that it doesn't unmap/remap system mappings during the life
> > > +       time of the process. After the architecture enables this, a
> > > +       distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage access
> > > +       to the feature.
> >
> > Architectures also need to be confirmed not to require any form of VDSO
> > relocation, which as discussed in previous series some arches appear to
> > need to do. I'd mention that here.
> >
> This might need clarification, the system mapping includes vdso, right
> ? Why the focus on vdso ?

My mistake, I thought scope was more limited than this when I first
looked. Please disregard the focus on VDSO here... :)

>
> The sentence  "... it doesn't unmap/remap system mappings during the
> lifetime of the process."  already cover what you want here, I think.
>

Right, I guess it just doesn't quite _emphasise_ it enough for me. Something
like the below would really help bring that out:

	The existing of this flag for an architecture implies that it does not
	require the remapping of these system mappings during process lifetime,
	so sealing these mappings is safe from a kernel perspective.

>
> > > +
> > > +       For complete descriptions of memory sealing, please see
> > > +       Documentation/userspace-api/mseal.rst
> > > +
> > >  config HAVE_PERF_EVENTS
> > >       bool
> > >       help
> > > diff --git a/security/Kconfig b/security/Kconfig
> > > index f10dbf15c294..15a86a952910 100644
> > > --- a/security/Kconfig
> > > +++ b/security/Kconfig
> > > @@ -51,6 +51,24 @@ config PROC_MEM_NO_FORCE
> > >
> > >  endchoice
> > >
> > > +config MSEAL_SYSTEM_MAPPINGS
> > > +     bool "mseal system mappings"
> > > +     depends on 64BIT
> > > +     depends on ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > +     depends on !CHECKPOINT_RESTORE
> > > +     help
> > > +       Seal system mappings such as vdso, vvar, sigpage, uprobes, etc.
> >
> > Let's be specific here, 'etc.' could mean _anything_. Also you aren't
> > sealing most of this, let's just list what you are _actually_ sealing
> > here. Which is AFAIK VDSO only?
> >
> I will remove "etc" and list all the mappings.
>
> Those mappings are:
> vdso, vvar, vvar_vclock, vectors (arm compact-mode) and sigpage (arm
> compact-mode), uprobe.
>
> We seal all system mappings that x86-64 and arm64 have.

Perfect!

>
> > You can update this later as time goes on if/when you expand this.
> >
> > > +
> > > +       A 64-bit kernel is required for the memory sealing feature.
> > > +       No specific hardware features from the CPU are needed.
> > > +
> > > +       Note: CHECKPOINT_RESTORE, UML, gVisor, rr are known to relocate or
> > > +       unmap system mapping, therefore this config can't be enabled
> > > +       universally.
> >
> > Thanks for putting this here, appreciate it!
> >
> > Could we tweak this though? I'd like to make it crystal clear, so I don't
> > think 'note' sufficies and this sounds a little too vague.
> >
> > I think 'warning' is more appropriate here since you're breaking things for
> > people who might be unaware. And we need to say this -breaks- programs:
> >
> > WARNING: This feature breaks programs which rely on relocating or
> >          unmapping system mappings.
> >
> >          Known broken software at the time of writing includes
> >          CHECKPOINT_RESTORE, UML, gVisor and rr.
> >
> > I think this is critical.
> >
> Sure.

Perfect, thank you! Much appreciated.
