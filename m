Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E322540A;
	Wed, 26 Feb 2025 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593782; cv=fail; b=JTwttZlRT9nunsJNAN8S8RPB/VMjPRs8QzN0J1SPUdSmDFMujfG83o00Jc2HH3RsvDjovvzNd1kR0dfKSjHkTZ+TEbHeaEsBDowM8CoWa93QwhkFdXEggJ7JSccP4ecK7AwnaZ+ua9Wb9YpVFj69ujVo89ST/XXR+41A+vKsVVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593782; c=relaxed/simple;
	bh=HJsfyLIPbjbFeIvHOxfT0AME6TpxhRHKrCp4I98Wpr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Voc3whJevSiZKoEHCYyGz2RwdKaq5fL3gnhfE5nCxBQBXIKdLOSP8Q9Lbt8UlLHD9jWc0D9YQg3ytywEyCxvZXHVgE4xmkyt989x+MUYIDQhofalJJ9VcnvfxAz0j4JpVBBWDMa6c4FLGTOf8+ko0mh8OKH4wysD/EYbj0TB4XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bFVL6/xQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o3zGS/xa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bFVL6/xQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o3zGS/xa"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QHtZSu031142;
	Wed, 26 Feb 2025 18:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SexyYlZe8Ub6r8pxefkA6wDieDUW656zii7RaDXNEGY=; b=
	bFVL6/xQrlIym0pxmjaWmPJ7hczcu8PDC0tHFEPQogjYFQS3+x4f0FsL3M++Rbtl
	vydF4TtXPd8X+h1Zf/vNjY63QuCsR78JmMv87P1zxnkWaDIId9a1Qg4dMK1+SE8F
	Ak62uZveaK0kazYEkaqq8aMvTgeIYC5f6qgiqS3Kkx9hYMsaW7OiLs9UuziyAd23
	qkB6OVElDfz4GmXt4AfWj2UZI1iggXMq8yE61ruk9th0/zGVFubLiMWxgUrD37nT
	/SQpALB6y0azj3OBKJjOWD8X2fAi6qr4rb4AJbOYI6SfoeAwFId0OlnxhmGogX5G
	0NFZET5ReO2Fz7Nkj+hMtw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse9rjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 18:14:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QI528a010247;
	Wed, 26 Feb 2025 18:14:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51as5u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 18:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k23p/5DiF8x88tw1cDRbimL4lMNNr+62DoBg3eIWNEcj7KQsNSyGUaJMqj0ORXvkCSNuANHg98OQPQnYQUhqCdEoUb1xDD2zmf4ou40ysw4JZRnjRqFSGLcdJ7XzVPJKlvjM14UEUXWqF5e/louzS5TpfDczAPIB/0zGE2yN7I3PW5rsNWN/vnouSlXHV5EvGxcrC4hp8hyQkzNRtwLjHHDB5NT65MCn+b/ns7xBqVRATXyNgcKHXMUsushKqYOo34jNw5dXpeHa5AhbuNuSYkjb1Grh0IRNI2bZvva3GD5w2ysuSbuKTzSTa0/k3YcDm7aFo6CBhSiZlCnlnNlXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SexyYlZe8Ub6r8pxefkA6wDieDUW656zii7RaDXNEGY=;
 b=cpa9kQWqKueZBj72YgbUbye+6KETRTkiva5DusgkbSJqZVtvxnvPiTOHfA+BmvVznik3nYdokexBIg586BVhPHA3rcTZMBpVFgSQtd9q5EbxmX6+JDNvwOzDDHms5lFNoZHkSR9PT3FMUJVW3knj7eCprh94LYlUNte7J3g7th1QK5VbQu41839KcIBs+VqGGtAcrE/i3Ur9ffP+Fj+ljD/cVTnMk8zVhfOoUdHSXeBxqNL+V4IePa5HFI/y312ig9RKxpjY4Xzi/mDIvBg1m8gvgY4kvS/FgJhuq0dN7PcmsByqwWpHNXwwf3wUherQjxIKhp/xsGCHtrYKVBJ/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SexyYlZe8Ub6r8pxefkA6wDieDUW656zii7RaDXNEGY=;
 b=o3zGS/xafR6BGOt/nkVa3G7YYmtl6YGGMcSB8e3neGQLNE4zHDVeydlTZKB5FOpxr9e9t6WMPN658Z8FoDwXljWgIIZCSYJXqN7ORnS3kXf53CYvuBvWkyMLb7RjlzD+MKIBVr8SdUzBswSZuT1PikKIp91lbbtUFaFdIUBQBOE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SN7PR10MB6596.namprd10.prod.outlook.com (2603:10b6:806:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 18:14:19 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 18:14:19 +0000
Date: Wed, 26 Feb 2025 18:14:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        vbabka@suse.cz, adhemerval.zanella@linaro.org, oleg@redhat.com,
        avagin@gmail.com, benjamin@sipsolutions.net,
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
Subject: Re: [PATCH v7 4/7] mseal, system mappings: enable arm64
Message-ID: <aedde96f-c1fe-4d88-bef1-1d07aef72c44@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-5-jeffxu@google.com>
 <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local>
 <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
 <ea970928-ccea-4314-9cde-b64fa1a7824e@lucifer.local>
 <qk4m74uscjxdnlchcxolvgbw7ijppzqk57ajyc4m6jjixq5gti@lokjqegpftzh>
 <CABi2SkUprOT=TEDQb62SByjyW+csarKnGypdmxVdktj=+C9_yg@mail.gmail.com>
 <ba04b513-0eb5-425d-b24c-82c9f9b6c7ee@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba04b513-0eb5-425d-b24c-82c9f9b6c7ee@lucifer.local>
X-ClientProxiedBy: LO4P265CA0286.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SN7PR10MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1d2a81-bbf3-4303-da72-08dd5691632b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW1wbWRkRzVOTWI3cmdEc0Y1VEZ5KzNRT0J5dTBWamtXRDJ2OTFXc1VVU1or?=
 =?utf-8?B?UjhWMkorcTE4V2MvRzRHOHY2aVdCVC9YcFB3ZWw5T0FSRXdiWXJxS3Q4Z2Jr?=
 =?utf-8?B?aDN1UG9DRC9GRnpGa0pqUzZESlB2cUpYZkR4MUREQzNTenB5NExQdUIxTWtu?=
 =?utf-8?B?TlFlUFRpbEpDck1zcEJEcTh0VnJaYkY1R0JJa056LzJidnVjY3NYQ1lFeFB5?=
 =?utf-8?B?d1hwejRONG1FY1JOS1ZyeGZvSjQ3OHprNkZCcHp0cGRtRHNQR1JJM0xWYk5B?=
 =?utf-8?B?RFdzaERYZzEyd0FTYUNDUkRYbjBJZTJNRU5JKzBsd1YrVCtqOG9ESzh4Qk5W?=
 =?utf-8?B?dmR6LytJSmFPVFZMbmZpSEZ2K0oyb3lPUzdYaGZ4Mm9nTjVFdFFKWnB1dG5B?=
 =?utf-8?B?NU1pWUs2SXo5c1I5dFFZTUJIUGg4bytoSVp3R3kwSEYyc0NOSytLL3M3NmlI?=
 =?utf-8?B?VGVRVUJQOGpSSWJIYnZsRUFObDNyeURkWFRPdFpGSWlpRzcyMCtXOE5Rayt0?=
 =?utf-8?B?WER6c08wL0ZKeUVnVzF2S25qS3l2c3Z3cUpRaWUxSGNJTmNjSWRaeUFCOHZo?=
 =?utf-8?B?OHJlcnZyZ0ZxVitFQ3Nta2VVOXpiM0FYTWtSeHZaKythLzRGSXd3dHdKQi9z?=
 =?utf-8?B?K1h0MW12RFRwOHBBNkxLUjEvYkc0NjRDU0hqVFpxUVA4eG51RGdwckpTUk96?=
 =?utf-8?B?cm9RVkhxTlIyVHA4bEM5Y0lVTkhsYnJaU3NnbURmWW5HVWZHU21pZDZsT1lp?=
 =?utf-8?B?cTFUaDdiV1R1MkpGL1NtWTR5ckYyQ0drYmlmVEM4eG5CWjIvMUh4RE5qYVVZ?=
 =?utf-8?B?eEJQdjQ4UEUvUmp6VkxaL1M3a2orYm9SaXFjWlV3VFgxWEFqMHk3akMzZUsz?=
 =?utf-8?B?bDlCZjY1alJmN0JDV3dDWHh4YUpqZWswVVhCQ0paRFlDdmx4VlE0NmV0Z0sz?=
 =?utf-8?B?cXluREhOZ2Y3ZlRLWlpiOGhQekZYTm9EWGxtTG0rZW5wQWRjRk5nTHpHYkhZ?=
 =?utf-8?B?TVVNYXVkUUI3RGdFRnhSQTFxV2J3cU4vSTVDb0NVY2JQSEpNTzlEQUpqWEdX?=
 =?utf-8?B?dVdqdmZxay9WYTlVWWgxdWxYampmOS9uSE92OWwzNzRWTndzSUwxaldycHAr?=
 =?utf-8?B?ZzZZOENVaDFxOXF5L2M1S0xvSVlqVmhIM3VudE9DejFFT3BZZ0JMaU0yb2k4?=
 =?utf-8?B?bXhmZzg2WmxNOWsvUTV2Nmp4TDFycmpkWGZEQUVzbWFmWVZkeFk5MHJxMEV2?=
 =?utf-8?B?UFZCS29WU3FIVzZJeWhQT0Y5LzNIMzZpNmRzaHVuVHBjUEFRdVRFTkQweC8r?=
 =?utf-8?B?VFNDS2Z6OHRpMkI4aGN2TTRnYzJTV1I2Q2hlTzJMTjZ0SWV4amN4NExvbDFH?=
 =?utf-8?B?SjNmZ1FDeGcwWDV6VHdUREIwRWNEQ1ZKcXZRL3JJYVJzVUxFOXU4NWNKdG9X?=
 =?utf-8?B?ODNpSGhOQmZIUERDQU9IYkZya2dFU3JKQVhaek9FWmNqQXZCYUpHcFU4cUwr?=
 =?utf-8?B?SzFIby9nQlR0NjBHM2g0NjgxVmoySENmZzJzZVdJdXZyYkVxSlNxaG5kZTBN?=
 =?utf-8?B?VmtwbTJaVm04eFh3dkJkQXNncjZNTlJiM09GMWpLZ3VFM3cwOUNTYUZDR3N0?=
 =?utf-8?B?cUF3UzhPRUxNS3U1b3VSWXFFVndRMkszdEZIc2hxeFlZc1RrTlljWnV2UDQ0?=
 =?utf-8?B?Wkk3RG1Id2c1TVBiejlSRnFmQVBVbDF2VXlNUSsrSFdmU3V3Z29aWjVBYmZx?=
 =?utf-8?B?UG5yaWYrOW9VcmZPMG1oRERzbnlsd3k4V2NuZnJUVWZ0ekJ6YkNWc2dSNjUz?=
 =?utf-8?B?Y21Pc3VyK0xYYTBCTURpZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWNMb1pkN00vT25YbXJpbmFWVU5DZzd4L1pxRHNVQnNpT1JOTGJSSWRNOXow?=
 =?utf-8?B?SWgvZHpFQnBCY3c0azFPY29zRkpiV2J6dk5WR2daRlhIVDE3NkhhWWFSb0FK?=
 =?utf-8?B?enVtQlNnSWR0SHdlSWNwZGZKK01veU1RMHJ5Q1Y5QjBOVDVDd1dKQXk3RUU3?=
 =?utf-8?B?S0VDL0ZzRW9DRE96VlkyTkowZ3dVV1lZZDhKb3VjczdQR2RHYUxkZWpQbk1M?=
 =?utf-8?B?S2xGbTFHVllsTk1hUXhwMCtSTFdiZzhmMGUzK2c5R0lad0dIdmUzMi9TWlNt?=
 =?utf-8?B?OXEyS0tueVhKdlpNNzl4UFc5Qi9oa29ldjNyLzFCLzNwVDBhMXRwanNKZDdP?=
 =?utf-8?B?bVJYMVFFYXZySTAzUzR1NDhFekp6Qm9vUTV0THlPN1dMMldmZTE3UWdzWTBz?=
 =?utf-8?B?eUJqYzg0STh0aTdrUXpGN2xiU2dabzhIRlNzWDQ4SjBDSllhNUxtNVNIcUNs?=
 =?utf-8?B?aGxXRVpXNFd6YTVySGZ1ZlVSOEk3Wnp0cFVaa0hZRmJyOTNPemMvejRicmZk?=
 =?utf-8?B?dTZPeU93blp4dUp3NzdlMC9rRkVueHAxbkpzTEtKUStkUGpiSGNaYzdpLzN3?=
 =?utf-8?B?dzlNV244OUwwTFJReVVhSnRtdTVKbmNuNW9BQm01L0ZOV1RHZlI2c2FJRmZH?=
 =?utf-8?B?UXZrZ3lvVksva2JOQ0Q5a1RseEFSaVJvZFBNMXU3aExMeTVYQ3RtTndzTnI1?=
 =?utf-8?B?YWNkNjN1UzM2bGNsMUY3TThCcktNamJrZFFaQm9XV0M0TEd6VGlpN29TWkpo?=
 =?utf-8?B?YUhtVFM2OHo5TE1haGo4UnQzb2lQNDJNQll6RUdIYTRDSnVITnROODh3Qy9r?=
 =?utf-8?B?a0pWS0Q5ZUNBalZzSGlKekEwaWZRdFdjTVBBN1hhYmtGZ1dtclJDcjN2VXFj?=
 =?utf-8?B?Y0g3d09rNks5dlAybkhkaXl2eTVseEUvN1NJbUV6UTBhaW9YK2Z3eS9vSFFy?=
 =?utf-8?B?bjEyZm0rZmJDSmxzL1dzSmluMEY4QU5iYWNaL0xDUVY2N1ZzNitNR1Y0MnV3?=
 =?utf-8?B?a1JqcndSdE5qbHVSZVhtb3ArSUpPVkhtS3hITUlPSGxTS3NuUFovUzA4TW9K?=
 =?utf-8?B?bGhTdmVQdjBETm5PcjFIMVlxNWR6ZlRyRFJKWHRISGQxSktaNGU4amZtYWo5?=
 =?utf-8?B?azFiZUJIZEZtU1VrV2s2a05CNytvTEpXdFRNV1k4OTZLaGJyQ3U4VTRWWHVC?=
 =?utf-8?B?ejFmWi9GaDE3ekFJdGt4eVB2VHJxbzJkVnJKbEQxdjhkbVVFdzZpTVVmY3M4?=
 =?utf-8?B?UWhrL1RObWIxaHNJd25mVE04YmdIaTNxT285YnB3OGpBTG5ValB3TTBDSGZB?=
 =?utf-8?B?eEVDLy9aQlBGWnVwcTluT295eHV1SWtINDdJMDQ1NjdQdU5uUkxRNnZ3bUxm?=
 =?utf-8?B?ZHhMOUpvc0k5UldZcjA4SklBQ2J4ZjhPcFhrb2h3N21sSGZhaGN5SldrdDZU?=
 =?utf-8?B?NThha01RTDkva2lpdktuOXlISExSNldyYnFYeFhyM2VPU3BWcEZGRFlLNWUx?=
 =?utf-8?B?UHBHUk1mWDc1b29ZcU5SaTRwWVlhVnQ0VXpTVVlKa21VWno1VksvSlFKWkk3?=
 =?utf-8?B?c3c0UXErcVp3RXNmY2lsQ0trZkxZNXRZS1FJNDYwMnBGN2FsTVFGQWdLL1dX?=
 =?utf-8?B?VVdLOEVtRTVZYkVlR1VMVkRLTXFnYXVaLzBiZXMxdEJEdnROYThwajRkUnI2?=
 =?utf-8?B?QUtNY3NRcE5oSTR2ZlhTdlpWdFRSU0QzSVFEMk9YS2ZLaGJ0ZndMc3VxTDVy?=
 =?utf-8?B?YzdnalJvNzhjK2Q1dnFmdlFHMDEzQnZwQjA5dXN4MlE0RGdXUnlRN2pXU3Ja?=
 =?utf-8?B?cFpYd1czVDMrNzBZcjZKWWh5YTJnUXNNeHdwU2x4S1A2bm9tN1hoRzhZVC9P?=
 =?utf-8?B?MktJYys4ZXp5MUFkS3U1OW9sRXo2VVRjNTAwaEppQXBpakw4T0FQdTY4eFcw?=
 =?utf-8?B?a0NXQ211dFRzN2lJTFpKTWJ6TWJUZzhSZTJZQXFpN1o2REVzWGs4NUNTajg5?=
 =?utf-8?B?TmY2UWlFNDZuVFpta1dEdlJydUJaMUJPekRiMFo5UStRRHQwSDJoSERJdkda?=
 =?utf-8?B?eUNFN1BDT0tPVFdwdlA5RmJqazN3NjdxZFk4cGZGYTgxeFg2d2hmWFdDQ3Br?=
 =?utf-8?B?UXdLU0szZGNNTk1WRE1US1dtNEVsaTNHaGhHT2tYbGdPZW9VUTQ3Q3hHOHlp?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NlGSxlRoRb8SDeDhC5N4XIms3DCpOKzZGTroP1RjHZEwGgFiyHfWGC12j3cI8jKjZtglZd8PppJnvqGlvEm3Rh6PPSalgTB1id7PCXe+wDsxZFwO2Kuxjk/vzim4atL1jLtDPTybGLYS/Dc6lXog+OcSaa/y0+S4fi2kjPsAjhyiagy2Opr1N9f7ngnWh5F99w9WN+83/7CJuO31e9BQXsR1hAplvp+fwK1F4leRNnQs1eivRr7VkRf/VE3KDhodAgRVEflLLsZ6zx9xwU6KYMvc3Rr1nJ/5OQSPTGza6e4UEVrGTOrUeUq8PAMvgKDHko5w9vFt0l0YwnR9CGBmMzoo/KvwTrAmFW2tzsbMLa09zihy2+xnZU5zFk7TTpZdLmEg4BnopneKqsuLjW7fTGmNYw4LvyKR5wWtZ4sNAFO/iViXQWPhypcoEEzfTmY+mbE5N3DpAN4s1034LUqaSkM6Bbk/IprhLOGpnpw5TmTrGe+OBMaGU1TrxSvTatsbjPwwYNijqge9RrArrDfKsHWRwC5hjW4ztVJ2KyV5c/evDsqRuxfgDPNOUcfDpSnXAroa/uD9OuOiCyQts0vbo68g1WsPtnDPwTKCsnTMMQY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1d2a81-bbf3-4303-da72-08dd5691632b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 18:14:19.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlMiiDMkd52XQ4oMPpIXjEmn02mlqgDuYZbJ5WEFarFIoUVSbBYIk4ru73WnYaisvQ6ilTJIUJypWiR2qLADbnnMNgaGiLo9cnAfBJhvPYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260143
X-Proofpoint-GUID: cxGx8jX9TcF3DhTBvQ6LqEZaV8brdVbE
X-Proofpoint-ORIG-GUID: cxGx8jX9TcF3DhTBvQ6LqEZaV8brdVbE

On Wed, Feb 26, 2025 at 05:43:22PM +0000, Lorenzo Stoakes wrote:
> On Wed, Feb 26, 2025 at 09:17:10AM -0800, Jeff Xu wrote:
> > On Wed, Feb 26, 2025 at 9:12 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250226 00:26]:
> > > > On Tue, Feb 25, 2025 at 02:26:50PM -0800, Jeff Xu wrote:
> > > > > On Mon, Feb 24, 2025 at 10:20 PM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org wrote:
> > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > >
> > > > > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> > > > > > > the vdso, vvar, and compat-mode vectors and sigpage mappings.
> > > > > > >
> > > > > > > Production release testing passes on Android and Chrome OS.
> > > > > >
> > > > > > This is pretty limited (yes yes I know android is massive etc. but we must
> > > > > > account for all the weird and wonderful arm64 devices out there in context of
> > > > > > upstream :)
> > > > > >
> > > > > > Have you looking through all arm64-code relating to vdso, vvar, compat-mode
> > > > > > vectors, sigpage mapping and ensured nothing kernel-side relies upon relocation?
> > > > > > Some arches actually seem to want to do this. Pretty sure PPC does... so a bit
> > > > > > nervous of that.
> > > > > >
> > > > > Can you please point out where PPC munmap/mremap the vdso ?
> > > > >
> > > > > Previously, when you mentioned that, I thought you meant user space in
> > > > > PPC, I didn't realize that you meant that kernel code in PPC.  I
> > > > > tried, but didn't find anything, hence asking.
> > > >
> > > > Jeff, please stick to replying to review. 'Have you looking through all
> > > > arm64-code'.
> > > >
> > > > I ended up doing this myself yesterday and found no issues, as with x86-64.
> > > >
> > > > I said I'm _pretty sure_ PPC does this. Liam mentioned something about
> > > > it. We can discuss it, and I can find specifics if + when you try to add
> > > > this to PPC.
> > > >
> > >
> > > PPC allows the vma to be munmapped then detects and falls back to the
> > > slower method, iirc.
> > >
> > Is this code in the kernel or userspace?
> >
> > If PPC doesn't want to create vdso for all its userspace apps, we
> > could instead "don't create" vdso during the execve call.
> >
> >
> > > They were against the removal of the fallback; other archs also have
> > > this infrastructure.  Really, if we fixed the fallback to work for
> > > all platforms then it would probably also remove the possibility of a
> > > remap over the VDSO being a problem (if it is today, which still isn't
> > > clear?).
> > >
> > Any past thread/communication about this that I can read ?
>
> Jeff, I'm sure you don't intend to, but I find it quite disrespectful that you
> ignored my feedback here (and elsewhere, regarding you ignoring 4 sets of
> feedback).

Apologies, I meant to reword this to sound less harsh but somebody phoned
me and I hit send...

What I mean to say is I think you _do_ ack what I've said here, but you
think it's not useful to reply because there's not really a converastion to
be had.

Whereas I'm saying it'd be useful to ack :)

Sorry I did not mean for this to sound quite so 'full on'.

>
> This?
>
> https://elixir.bootlin.com/linux/v6.13.4/source/arch/powerpc/kernel/vdso.c#L236
>
> Was [0] a relevant discussion?
>
> [0]: https://lore.kernel.org/all/lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyuso6jcy3b2dq@7ju6cea62jgk/

I did in the end go and check this, so hopefully this is useful at least.

But again, I really think we should hold off on PPC stuff until we come to
it and focus on getting this series into mergeable state.

Am doing my best to try to get you there ASAP as there's been a lot of
delays here.

>
> >
> > Thanks
> > -Jeff
> >
> >
> > > Thanks,
> > > Liam

Cheers, Lorenzo
