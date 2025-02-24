Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906F38DE9;
	Mon, 24 Feb 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425588; cv=fail; b=rGXZFgpl3vNL6KJsEl6VUTkLHcunxnoMV4aQIIu58P7H44gBS75t+suIgTRm8l095vltfmbRDkpSzLqgJtbLO6LJnsSwVpnnABvgNBAKop68fEJAxxzWNDseYOMxzELYJ32qTtEcE/UePL48jaDgC7mU6iw2zogaH2bSTmcmL2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425588; c=relaxed/simple;
	bh=6fCKKxrd3whQyPzy3fMK988gMSJMiiTiolX7uKeMCus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Em8xvvAAvE2ExxCzUVMVBwOnf+BMpgFeUsnYMN0dYyftPGABRCAkHaaI0AiSSBp1+L30LKSL4USGGqDmVO/DZ0GRHJ6UOvYXzfgP0UgRF1JBIu0mkZJTbIylv7Mgi9QsmNr4t2R7ePti3byBF1TRkCgdjDdEXBTng1xm0RdGpcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EM7os2lT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y1CQj4/d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EM7os2lT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y1CQj4/d"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJSPL6025801;
	Mon, 24 Feb 2025 19:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lJvulDDIYUUUBvkAgcy0HzqadmSRbBjKBuagCZ5ZAsw=; b=
	EM7os2lTRtHJ9e6NR5uRQLmBJ5c7OLlboXuGkA1jiQdBkJFh36AzA+VFCasPmfC/
	wy99LIgOdDdd0AQOsEhsZlSpO3ZVbQxhJnVsu0tnd03lQQbiSrwFPqnvDeZHyuUG
	pU4olshEs3L/9odJ+RyeQtK1KH60mG9tMndg2HE0rj5ynHCFjG7epn/aoylFXKfr
	+CoAeou5buSdRjITtWg0ODEjr9qQcOl+Fb1PNaw8o23nhvbxy/psbRFD9GY5a/QC
	3WHuEJgB7nZFemwyx9qzJz9RyfGQAZ8QiHQoST9myBCgN4d/C1iZlwgi/pw/dIya
	lr2fYMT2JBhtyhvB56g7pg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9bcd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:32:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OIHPiN007366;
	Mon, 24 Feb 2025 19:32:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51e58ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:32:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IweaM4uCPDKj36WRxIJlZwy+MJPStAL1dmQ9KEXvwfk8wEX5nYeMjQBTvQXCzzU12BnrAcOxQ2jJ4r/lOnNkKFy8brPLucexi0R21QvZhqf8pLEG6M971VO7WfEl6Qom/UWa3g8tF2Z5Vyv8fcTALiZ0T67cdf76YaVBmMpJwWyoR6gM2jMXM6H7oL1lNB+u0g4ruRBF0xBSfjYRk21+zqJvpbDKnkgjOKxsGorabkAOf81c8wIggYOtif9LtNbM80LWKHClToLWZaFb52jO6n3WDgHbQvd48CcwCRyEmakAGqZs37000t1JUgXt1jKFgV2J2ENVHLV4hvI/kdwXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJvulDDIYUUUBvkAgcy0HzqadmSRbBjKBuagCZ5ZAsw=;
 b=jDWKYSpwuHakcooaqYYdZi2Be9duxg9jE0VuESL1M4WGHdqn2lpPTUxTZy3mAydYT3VHClCl6jHbxzPoRXr9U1IAGkZ/vZmkBbNAr5tps5j6zv1A8gH4cPMyIk9arrFPfUiseATzJd5gut4oSnd+n5ZVNJFK4/rcnCI5KX75X04hD5yL7LbgFZla81Hh3LcGoaxZOKx8gfDKbsWFnFlSU+/kLjoDAPYSIERgyzIj/aZe5orfIVbmINwir60uWv2OesK5ILUsJjJeQu9CxnIVcNEEkbkY6+e3iQUDHVu4xomg464QL7xKz4WMSATsk+tOVEwVIdF5u5KKd4QzuYkMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJvulDDIYUUUBvkAgcy0HzqadmSRbBjKBuagCZ5ZAsw=;
 b=Y1CQj4/dZ7aP7/rF2H2lM/63sBMRqo6gGXqSFjCXK0JVuX5UBBB7ss7M/frhoi8e5yLjbvxBMgcmnCFnDwQPamaFwRlDAO00XCGbmRWuG8PJpDI1YyJwPVFR1Mo3gEMeOlSolDmE0wOTibFj8taM5ncqggWaUQRqIeKwRUd+4KU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 19:32:11 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:32:11 +0000
Date: Mon, 24 Feb 2025 14:32:04 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        akpm@linux-foundation.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
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
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <hnlyeo4bnmxlraihgpdqfucxfpkqu7zmcxs5yqokohudliotpe@ngiv444c2bdp>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
 <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com>
 <202502241053.1FF33D5B0@keescook>
 <lvzy3x2tv4uskn7dmatdqwqhhs4xv4vumk5f46thunndxqro6q@egremlepcgo7>
 <CABi2SkVv8+hNt-WjO2jp8zUNOiabncU35vNXApQi8yhBxcf86w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkVv8+hNt-WjO2jp8zUNOiabncU35vNXApQi8yhBxcf86w@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN2PR10MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7f3a4e-e823-432d-5c02-08dd5509ef32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anNRejFvU3l3OThDTVN2MDJLRzFsa21iVk1xZFN1S3U3eU90cnRIdGVCRkI2?=
 =?utf-8?B?SEl2S295NEQzUzJCK0lYenZDMHNEQXFaZDVWbFZSc0VGYmhpRURIamVncUdy?=
 =?utf-8?B?K3Jvc0N0bkhpZnZ6THViZUxpaWZEUElxcE5wK3ZaMzJkSjVmUkVqOFYyY0w1?=
 =?utf-8?B?TkQ1cnhIcTNVcWU1K21pUTdZVmNnREVHVWJjTHVsTm1pNWF0RGx3c256V2tK?=
 =?utf-8?B?M0pSNUtYV29nZDFGWm8rWkVvdzYzbGpXL0RoZUNGSndmRHlqYkNrTGhNWXlT?=
 =?utf-8?B?YnhpcEEzWElMalVYY3FUZytQY2xJNHFMd0RxaEVrNzBJbVFMek9aaFJPeXRr?=
 =?utf-8?B?L0JQWitiQURMY1ZTU3ZmNWd0QkRRLzRjY0RPZHg4TTBVWGVGRkNuVmp6Q1FK?=
 =?utf-8?B?Wmo3MElUeUtVZXZiUS9WN3Zua21ra2Z6KzJSNWo4TTE4cTBEckdTUlErd0lj?=
 =?utf-8?B?WTd5d1BxdlpGTVZ6ZjNPTVQ5cWd3VzVEc1d2NGErUkRVQkl6bTkxTHdqOEpH?=
 =?utf-8?B?WUFIOTRNcitSMS80SklWTFJTNHV6Ky9GSjhjNE03ZjhjVVFsN0ZxYWZySm1Z?=
 =?utf-8?B?ZmNFTjJzV3hzUmR6MjZKbzd3TkhuTGJPNXJCS2JQMTJIVE42bStQZzFBOWxx?=
 =?utf-8?B?d2ZBVWJHcWFDNDUyUExpOGNrNTUwM21HZFBHbnZIbWo5M09hdngzQmhrb3dW?=
 =?utf-8?B?Z0JpK1lvN051U1BMUUVWdE1aRTMxZDRHQm9icmNHbEtvdnhMT21FL0RWSm9I?=
 =?utf-8?B?YSttK0VXVXVMc1Y0NjR0cXZiMEZ0cE5tb25EeitqdjExL0E2Y0FXT3RuN3Qw?=
 =?utf-8?B?bDRqeUZ5TDlHQWw3TmpLdGY3Z21hazZHemVVK1QyRXp2M2E4T3I0a2pYem5U?=
 =?utf-8?B?bEIzUVRDaGx4U2V6OTdzOW1IdERGYlBHMUQ4U3JiTU1Edk5PU2R3c1ZvWHdD?=
 =?utf-8?B?dkpmMnkxdUhrcnd6bXpjYkJuSTc1bk9idWRSSFIzU3NuRjRiUjNxc2w3UURx?=
 =?utf-8?B?SjMyTzRJZE40VXF3eVc4WlZxWG1VWTQ0Z1lRQXRpK0NzYXIvdHBFZHlLaHNV?=
 =?utf-8?B?L3lISTdSRmtHVEY1alZQMHhMWUFUQlBjNFo0a3FITVZ5RThmYVk2ejVmbjJG?=
 =?utf-8?B?UW4rMjd5VGpZbXZ0bnE4NzRVTUQvOTgyamh1OW5JSXlzQmJkeVhPcm5hZU9G?=
 =?utf-8?B?dUxxWFd5Y0JzUFFHNWRudllydHFZMkxLa1dLUXg4c3c5ZDdnaEJ3S3Qxd201?=
 =?utf-8?B?YkQxWldja0FKQVZ6MU9aY2FGZVg0ZE1MYnlTa0ZRYTkySzBJRklPdE9WdmZF?=
 =?utf-8?B?MEIybHFVNVlUeDRBb09PODJuTHZ3alNXSUZjVXFUV0ZOWUtSVkZGTnhaS0JP?=
 =?utf-8?B?Z1lQZi9yb3BhOXEvSW1ReGJ4bG4wM3R6RklxazhlZDFualFJazhHQ2wvbFFF?=
 =?utf-8?B?NEpOT2VlVzdhNGROWDdncXdMQ3JWbFlLSmZKQnZvK1JRM2lUaTNoM0d0aWpq?=
 =?utf-8?B?WS84V0FPNHMrdUxLZTd6K3Nsb0JrcWFBY3cxQWRuU0gyMHVTdHF5NkttMGNN?=
 =?utf-8?B?VUp2bHp0SGJGSkltcjVZclY0WFBKTE5YVHh0WWgyTWJ6OEFUU3JIN0NFWjZi?=
 =?utf-8?B?b1U1L0RxZ1huSEJVelV1OTJ0eEQ3cDJPdXdydTI4UnNYWVJyd2dlS0NsNVpZ?=
 =?utf-8?B?V2tWMElzRzQ3R2lpeDRQVlZwaEJUM3o3Qkx4WVlraFpjdldGeWxIVU9jQlg1?=
 =?utf-8?B?d0ZoSjkyQnYydVcwR3RrS29FbmZTZXIxTnRvRUtKSWw4SWlYbXZPSHZKWCtJ?=
 =?utf-8?B?bWd1QnpBenQ5aTZJQVVsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2FOSnMzbXpQU0ZBZ1RCZEJ2ZmJ2dVd4WDFIektKOGhneW1TREpsN3BuZjNG?=
 =?utf-8?B?SWNUMjRORENXTjYwTXlicUVwWnRiNEVGSWx6VVZuVjFPTlFaN0pxdVFWUjRt?=
 =?utf-8?B?OE9NWEdXN1BiSDZtbVI5b1M0MjA3cndKTGpxb2xDN1RQNk5OSG5uNUQ2Smlh?=
 =?utf-8?B?eUxFb0hJK3RnaFc2bVpPSUJQNXAzMjZHVnZxbkNVMXIzZzltOWZUbkhGUnRh?=
 =?utf-8?B?YTcvUS95WDhnendDcFkrWVBJOTZyenFOSjlIejIyQStyckhGbFRMaXgxWFE1?=
 =?utf-8?B?ME82VEE2UDNvQVhzOEJwc080a2RBaWdMUVROcnRzRHJ2QU5iQ1lyZ3Zhb2xa?=
 =?utf-8?B?d2lMRVJvQkdadmQ3c0hLNU1td3Rab0I4U1FDNk1UQmdDbGZpVGd0aWNhaFpn?=
 =?utf-8?B?T0w1NkhqWmtpMDJrOEovRk1nbUx1ZTlOWVQyYzUxM1ZNamphT3ArT3FjWUJr?=
 =?utf-8?B?OEJyYm5vYnFiTitySzVEdEdYTjZuWXJhRDlndjV0a2VLaXR2QUp1Y2JPMDlj?=
 =?utf-8?B?QXJGZTU1bmZOeHVZclVKQ2k1UzVFQ2tkdmZNSTVoUVZldG9QUHFvSFkwVWd5?=
 =?utf-8?B?MDEzd0E3R0FobDVSOFkrb2VzK2NzOVdiQXF6TytkU05KTCtYdnBWS01aeDV5?=
 =?utf-8?B?eUlVNGI2K29kU3kzZTloeXB6YVFuMjhMa3hhOG5kWUtuZnVBdHBNcjMrVmFJ?=
 =?utf-8?B?d0JoYWwvNlVnMTZuK3NkdEJaWUVaK3VnODhTK2VNTlAyOEhFeGU0U3BvMXFi?=
 =?utf-8?B?L2ZZUG82SnMwcklrR0l2YVRjcXJsemhodktnS2xCMDRqUm81d1ZJSzBvcnZz?=
 =?utf-8?B?UFE0ZStqTjRacVRUZmpneURXYzdPd1FXeDdtbUFhdkJUVnN3R1hHdkp3NmNX?=
 =?utf-8?B?cEwwZkxSVllpdXJ6ZHBRUUo3clpyYU5YdWRhMUVoQVJQaVRHY2wwdFBYdHZh?=
 =?utf-8?B?b0R2Tmdka3poYStDQkV6U3J1ZnlQcTcrM1pJdThSR3ZCVm82aEg1eTRSYXBB?=
 =?utf-8?B?MlhxSWZSdThxQkFiVW9BY0ZQR0pVQmJKT1NCcEpveEVHbHpSNi9vVzhzNTFn?=
 =?utf-8?B?ZmxzZDVta2Myb0tRNGNtQXlpdDZSZk9JMmRUdVJzamsvSHcxUXBHeWQyUTg3?=
 =?utf-8?B?dy9iYWxBVi8xUXJPTGZpbThwaHdOMWlPdEFJNlI4eGpOT0xLRXRMSTlIdmo4?=
 =?utf-8?B?dE14SEVsZGM0d2cyaGo1NTl1WkluVGN5Z2x6YWR5aUVNNjlWNWd0QlowYURo?=
 =?utf-8?B?dFA0S0NDaE1sQ0pCSkhlVUVjcjZrWEJrbnplR2k3dG1OQ1ZYTVU2S2F3RkNl?=
 =?utf-8?B?YlFhOTFtNzdpZzFUNlQ5WE4zMTNrTG5DRnhZdkdQTFY3c2lOUC80dFIzR1Jt?=
 =?utf-8?B?RlVuaWkrUzBsVXZaRGRRaGU2TmdlTTErMnBFRDNmTnJSOTFSK3NXVnlHdC9i?=
 =?utf-8?B?d2lCdTU0NTBEU2E3S3ZkUzR1eFVvcmxIK2tUcWl3MVNsSmcvK3ZFQXE5OTRX?=
 =?utf-8?B?Z3J3Y3VmZ1JuOVBkUjZYTTA0VlNiQVVBa0R0enFyc3hVVEpYZTNXeHd0akZN?=
 =?utf-8?B?TjQyVVV5aVN6bm1LeWptcGNQdU9HRTZtL09iMFF0azFrQlkzRG5MNFVhVzVs?=
 =?utf-8?B?RFNyNXVidUdVOFdRWXlHbXZvdkxFa2Irc09hQ09lb0J3bzM0MmRnKzh3MUR1?=
 =?utf-8?B?b2N4NE10bUxZdzkzUDgrcGZFTVV1MVZlcVZaZzRYNHpCNElEMkhwcXNDMFVP?=
 =?utf-8?B?bkk4THgrZ2doSGtjQUc3d1d6d3J3Y2RuSUp3b3ZHNkJpNWVsN2F1SVFHRUpz?=
 =?utf-8?B?L1g4RzdGNkkrMlZwcVhZa3RzQngrVE8zZEQ2TlZnOGljV1JnUCtRWlJQWEUz?=
 =?utf-8?B?T3g0ZXJ0bHVxUnd1Tlh5MXBtKzZyOFlvQnk5YXdPM2lxcXkvV1BKZGZCazNi?=
 =?utf-8?B?ZnFyM25LbnFGNDJvYnFyeFNTNnRKRkVYTC9sdjJ4V2tIMHZGdUE1ZzFQSkRU?=
 =?utf-8?B?Y3B4WEgvRGJBVDc2Q3JRRjZYc1l1cTVodnhhZjZaTVoreCtoL2JaLzNtcnJH?=
 =?utf-8?B?emFhUmdqUmx1RzRUQVA1eGg0L2FIcXpYN0dsWHdHYy9BcU4xU0NNODRSMGZM?=
 =?utf-8?Q?c+lXanVI39n1g8bmENQTkI+v9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qHOUC9zWZ4fecxhwEhfBAEwI2euFf3iJOBSO+Qk4PVaPT04Ts5XIG/6r46dtH89cLX4LtMwZlZbd+b7+JtLsibw9c6ciL7XS6xxRxRmNBNMLG6NDX3A/ZsZZUDU/f23w6r635rT7jT4l/b7OdPJ9zMlk8711UBxJSkIrr8rDWPhajp9/VACAfBcL+B2Qy3zss1v8XIzYnRhZ/9oEfdg13UPyVizkKNP3y5KPN3RGLjF26iIme/9xz2WqRdEl/Xy+kvKIVNDku66QiI8wxWIi8zXcnjqWEQcySpUBscVtuyx4k24uj/MxkGjEaKeZBglO5XzCMtf7xpm6Ef8oQb59OKAh57uNkscB2x7NnDXrA9wjp1C6u8spFe4C8CnUbvBVjF7MGqzpPKXqXPt7HUVZ0bjuJxvuPCFc45hIUoyYYOLBkUXIH7orbo9QEuwijxKumaPZ17/3rWjC08LEHmt7ZmtBynqcBJYf+p81fTilQcCdS0FJnh/HIk4YVtAnwWWmJjsow3tH2K/FZAwoJjokurMcRF4do1Hsqbhs9x0ZHSAsJ7znj9lj4OcI6fnoXSbZNFktz0Pnu2o6BQMhf2B1gdfV5HGA44eLSvM+QLddmF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7f3a4e-e823-432d-5c02-08dd5509ef32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:32:11.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VspvYtERrxb+M05UACVhSpnAeRSwYr6dy5bFF2lPeu892H4+TzhsQLeXlydf3aR8VaYPb0HejDk+SKsa05AWrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240126
X-Proofpoint-GUID: akqwNaAkiK0Or9eiAPwRJEROWoyfaQ2g
X-Proofpoint-ORIG-GUID: akqwNaAkiK0Or9eiAPwRJEROWoyfaQ2g

* Jeff Xu <jeffxu@chromium.org> [250224 14:23]:
> On Mon, Feb 24, 2025 at 11:11=E2=80=AFAM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Kees Cook <kees@kernel.org> [250224 13:55]:
> > > On Mon, Feb 24, 2025 at 10:52:13AM -0800, Dave Hansen wrote:
> > > > On 2/24/25 10:44, Jeff Xu wrote:
> > > > > For example:
> > > > > Consider the case below in src/third_party/kernel/v6.6/fs/proc/ta=
sk_mmu.c,
> > > > >
> > > > > #ifdef CONFIG_64BIT
> > > > > [ilog2(VM_SEALED)] =3D "sl",
> > > > > #endif
> > > > >
> > > > > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the prob=
lem
> > > > > in case that  "#ifdef CONFIG_64BIT" line is missing.
> > > > >
> > > > > Please note, this has been like this since the first version of
> > > > > mseal() RFC patch, and I prefer to keep it this way.
> > > >
> > > > That logic is reasonable. But it's different from the _vast_ majori=
ty of
> > > > other flags.
> > > >
> > > > So what justifies VM_SEALED being so different? It's leading to pre=
tty
> > > > objectively ugly code in this series.
> > >
> > > Note that VM_SEALED is the "is this VMA sealed?" bit itself. The defi=
ne
> > > for "should we perform system mapping sealing?" is intentionally sepa=
rate
> > > here, so that it can be Kconfig and per-arch toggled, etc.
> > >
> >
> > Considering Dave is the second person that did not find the huge commit
> > message helpful, can we please limit the commit message to be about the
> > actual code and not the entire series?
> >
> > I thought we said that it was worth while making this change in v5?
> >
> I include the cover letter's content in the first commit message to
> clearly communicate the purpose of the entire patch series, saving
> maintainers' time when accepting the patch.

Having more text than patch for such a patch seems unreasonable.  I'd
find it more acceptable if it were a complicated race condition, but
everyone is getting lost in the summary.

>=20
> Should I still include that, and add what the first patch does, and
> separate it from the cover letter with  "----"? What do you think?

Here is my v5 answer, I think it was clear about not putting the entire
summary into the first patch.

[1]. https://lore.kernel.org/all/ml3x5qchmnehdzz2rxsdcdghivaqffojiweuhvpvzw=
45u3l5bh@23sblrom3m36/

Thanks,
Liam
