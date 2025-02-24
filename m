Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD71F5FA;
	Mon, 24 Feb 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431255; cv=fail; b=UDmLHEufsfXqNmOiQ5wmg25IsuFHI9K+7/UYT3BIJ5Sv+vdOZ6uAKGHJvlGh3c0Y17J0m3yBJo4iNu82QYb0cSR2AxAgB3jyPw7yI1JnQELjYHz0n9pvtLKbQtlKDzhFNF7VJepdRuybAIclnpBFbkhSQdlOU3WOm/k+pKRlgIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431255; c=relaxed/simple;
	bh=wWcEGxNw/Cr7YmQwb+GjdkEXPF/cob3/VH6hCEGhoP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RgzqYkTK92zNt2RBxp0wRe16/5f209zhkVWC896FtxDzfVehrWFATTZZ/c6wzW8r3mksCqgmKQtYqhAhH2NPdFr6I9nlunDj8reGgtyZCmee75iotTKnDgjLRTfJmsPwCD76FCtrQMyl1ZhSFepqFUv05M8hf8f9q6xDYHAcQfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qup1n07J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zyTgimK3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qup1n07J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zyTgimK3"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKfeEW000622;
	Mon, 24 Feb 2025 21:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+FkCmN2pVhEbsm36F5
	/1mQnoOPAi6iaCvOz4qjmUAVk=; b=Qup1n07Jh8kaUrMBLqcID4jPfj8aEYZxm5
	PA7ajsK9Hk7hISWS2ZqZv8beaJiDpBAN2RGXOKSwhbOzI5R8j46E7+gAX8QDrPLt
	18bXiN7PiXJ94iBjAw4+IgTxIYGLLNLHyyXcHFC8Nxaju5iWzBS5RPk1fN7PncNE
	zgijloPoGI/2dEO+5hy/mRY6c1D0Q6oQrPjovXDMttq1xSL/e2FirqvfOfn6tnqq
	qRcYP5YDyErCKeJbalE/i6z2Lb2j4eW1rhSvBv+X0yGKYrSfTSiH62zXnHXVtGsO
	kAQZnELW0yNnXoofF8bnqecQNp6ERqbj6T4lu1Q946+GlBScMFLA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66sbk0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 21:06:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJtvU6024492;
	Mon, 24 Feb 2025 21:06:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51895v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 21:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEj3hq4iR08/B5jzLY7hQeyLxr8zZMzKvpOqIRWMXmMYKgjArG35nTTRdJMVssmOE4sAFutr5957CVlOF9RgOivc1b1w3paA5Y29naAqjtZ6anlo4arIRp39KQFq/46joXOCxVNMQr7L7f5su61+KVMP6KpabVdAq570KfIeic4Y/r/sa7jfQTsHDN7X/7jejDG8kRsQHx+6ppqnApQAdxdrFCetMlmh2zDSdU9JIIZNIETyqQlumbf6ghKjPPCCPLDskhVWTpnVSqYP+F6FFCHF33SDdz1Y7CL5r4ywuJ5vvswYuttles3+gVGR/MqVbXKF8rwYCguYBooKt7nGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FkCmN2pVhEbsm36F5/1mQnoOPAi6iaCvOz4qjmUAVk=;
 b=rZ+lvDynEVjSvC2NX1UDishK42JB5eKRcYdx9u1bceE5QvZJYk3TgHY3VHldochUycrfMK4snszC8zyPA3GSFSynd5GtcBagc84ZK/yb+o8u3s9WauvfGK1zOzGVBjZz036c3q7o7uiY7dhZQsasocSwbkWu+mLp8ztDtV9bUwtYcrW+wlbVOZo+414z2kj99UFObVrTWNx4u0edzZx+Mui0HZ6NW1+uJIhikBeYJgvtj70lyJ+pbOk6lOlJtHm9DpnoXQ79wQ2J5ZFLfXSiaYMnCc1wD5PoE9RSYMzCZNuY9VDVzv7pIZcK/iYEcmcya0PClid/6pv7jfvghTd6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FkCmN2pVhEbsm36F5/1mQnoOPAi6iaCvOz4qjmUAVk=;
 b=zyTgimK3WwlNs+geYfhRB/XqlPPsXM06uo5Zhj5rCJanDAEJ4cTyWrUF0PhhictRd/dBrjUhmUINQB795etWWaeQkHjzLCiUjngf9kbT9FPIyyeCyA8i1Ng+4RIyQFk0JHdU9teVSScP+JGbClopOtvQeS1vPuQmiDsZZwjgHJg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 21:06:46 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 21:06:46 +0000
Date: Mon, 24 Feb 2025 16:06:40 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
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
Subject: Re: [PATCH v6 3/7] mseal, system mappings: enable x86-64
Message-ID: <6kyr7f4huquncaofkwoyozpbj6svhpj5o2f375f6ohqlgyrq5n@urqssz5pca3r>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
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
 <20250224174513.3600914-4-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224174513.3600914-4-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::28) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: af4dec99-0cc6-42af-6bf0-08dd551725b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bVmkUY/19iV262qZsC5o/h5MLgW0Nv51O9jLJ6YaoPcQVozLW5X/7A8cf2i/?=
 =?us-ascii?Q?KtO4+PNDzdFkbCEl36riyQi9qqP2Kz+r8g+aU5wA6GwGwtovJpG9VUI5Dd6d?=
 =?us-ascii?Q?/PphiJg7WSl6fThNgwaKJ+fO4Fj/3pgIZ7fSL/PmPZ6azTz4nHLBSep6G/4Z?=
 =?us-ascii?Q?+xfuGhtYlF/01rdEesj5uqZMJiipusiu2oi9nyBn4gsZQcepWAsevR2RjlO8?=
 =?us-ascii?Q?wSOBNDGj3udp/e6AHhz0q3ZgAx0iMeyIMV9FTvDp0oUWYoQw4tJtrHn3v73O?=
 =?us-ascii?Q?Rgx4INb4MpH7bhwiYx6VFR9XJ76fR4f3zBKHa3qEOlokSZbVqYSa5YaXSnad?=
 =?us-ascii?Q?iix7ayTBEyOpQY3ZUSGISPe7uSEzGYxQqbw9nmxxxuIv0vFbndaM2xGz81Re?=
 =?us-ascii?Q?odiuTyiEYxbDoDbPBnjLfdQT4q+IQ1hYGRlY/O8kiJ0m6rtOcBK1Ysp7Ocj6?=
 =?us-ascii?Q?CrHO1lDzGyZq+cNiyT1zdgyPF1Z6UG0Ftql3YnvhSBCEqO5qWbkBEdS8EMim?=
 =?us-ascii?Q?yO6gJLaayS6PIlWEFrze3ApQWnuIqcif9SEFbfiLYva4VW6EydB/YQ6ShM8o?=
 =?us-ascii?Q?dHvR60xfB/GOudMmyJAagqJG6JjD/2w6ApHGPSCblCghEZlhoV/Tb5EqSDdg?=
 =?us-ascii?Q?qKVEqzbiDjkr18BhZdKriNWZaPuoYdHPdkTUzrZzbPPy6TvSlacXPnN46hMl?=
 =?us-ascii?Q?uyG+sfD9nPp/7kuK6VrEqtUGqsr95Hi3WK7Zk6z8rtysEjQZecWChPoHmz4K?=
 =?us-ascii?Q?TWKkjfDzfAe7ECPJC5SENsbNFwi/Bl0/SP2r64SkbNITfO1DSCH/++Oqo9er?=
 =?us-ascii?Q?eX5T7EdHR0mjfXf/UrwRkiJW5k03ZTdCGsAqGRfm+ve4gXLfKbjsgcijOnCm?=
 =?us-ascii?Q?F3GbxwhuZsy6scavUuSPUo+cMsLr7F+RjH55KfKTCMd+76EGsZWAs5eRFG9q?=
 =?us-ascii?Q?gkA4jJfymP4s26T2OUhLNKYpRTRSfgTRbSnsEAquoA1fe0D2TfJUY0bRMrrC?=
 =?us-ascii?Q?vlO7LfSHiGRVHRXNs4T7Jj1twoR6SA2RfihcqGOW98iH0jULBd9sFXk5ZhxU?=
 =?us-ascii?Q?CVi3BLxm9MjQUN/d1XWZVbIagBc6yxJxQeZjCKJz+GGh8t9EFdAzI2dRw2Ct?=
 =?us-ascii?Q?oMbuSM2C78x0j49U6OjjI01LF15nBmg7tYa8BDSdOquGUEF9SjRdrpvpOYoV?=
 =?us-ascii?Q?jgmOwZ//UyySy9FMrCsiclPCaXNUXa9vLMjdXRU+ifi+LaSJ0EAn9UjuK1T1?=
 =?us-ascii?Q?3NdtwAsX26McWeWPqrKvqrekOdDvaPBMPz+Wczj3U8QPneohmD/Zsmeiazxe?=
 =?us-ascii?Q?kKgrTEFxZsC0vcwTZuBRMmgWLF//6geMV4ldFyFV+u28JYIsTnALNnFs3u/n?=
 =?us-ascii?Q?+hFtv6qg3K9/hsbHcRnbptjfja/T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FXQ8jCkrP1+qf2V96t/6PGttwbDK35YIxQAv7QyGH6oB9Z7iD4BXueVhD9lZ?=
 =?us-ascii?Q?UAxgtsDzP5nlG/TeyhnuZ28FeOGUFszkBVAtJYDRmf6Tu+nmt1KpVTa6g4+6?=
 =?us-ascii?Q?neeUsF9THTlyZXnHYBjtxIvurC1Sqy3HCbnaWgi020dLifgSAZN9XEndeEph?=
 =?us-ascii?Q?extb7XXT9MlaU3SnV4x2QJ19VplcdpaFngeVUpMR76R5A9shck1OLXiWqgzV?=
 =?us-ascii?Q?PSWTvw/p4ILTqY4KEf1JdW+qg1QvbB6TAu9hvUEgJxq6YPKzEbGN49vscb0j?=
 =?us-ascii?Q?seSPg0vhS8/QTO2CaT51bucsiQC8DPXs3P8fwpjD/ek4e2a+Sgy69XNA59bk?=
 =?us-ascii?Q?jxae8hXz+kpzuGtjaD93lBM8/lPKcLHc76iMIg/IA/t5+B91KVL/T/PHOLiZ?=
 =?us-ascii?Q?Fj9z0rFgF2nlyuNiuzh9/s4CJsCbIBIi/WUK3SBZBbHUew+9QecfbNJI7reP?=
 =?us-ascii?Q?YM6+PTVyXvqygyvhIV/xpKoJjYNQ7wsfiOPCDJ1QqnGgh50rjt6A+KwkoAnC?=
 =?us-ascii?Q?XXwcTCe/LkNRfkOelev8onb6W91BOrbh4fFyJ81Z4bjGy3tmi2rWv4TWwnEt?=
 =?us-ascii?Q?dcWf+XNBzolUCTxPusAHJj/2i5H704mGpSVLbXee4P08OheG61SFRarRvdQc?=
 =?us-ascii?Q?1CC3zpmjQhVaxECMTAk2DzjPYaQ+OaLu+3pRLmVEAL0QUTIt8l/SN5LoquSP?=
 =?us-ascii?Q?WK7eoTwwgyFSwy86YMp5Ai8lgHpG4N3OPqcLJa/vxSbwGJOocNI4Ny9Iedsl?=
 =?us-ascii?Q?Nb6Cs4hLaWnqKD2+LyjAZG6WO403l7C9OZ99O5uGWB/YBKRpAePKdT4VbUx9?=
 =?us-ascii?Q?u2aZ39ch4YjiY09FWyNXaUIgvzvDtxyOo2Fa/IEkT+5WspcLkwUNyPvYH+Hz?=
 =?us-ascii?Q?8cTx3RJQ0gDnhORCDQwBgtnecX4kP1NAbjBZMEdSDPeteuNm+sBi58E2PUbu?=
 =?us-ascii?Q?m0SZyMiEPohOVFjh/E1uB9s401NrydU6wAO7LgqcO57xU8JWH1CWfsurZhsf?=
 =?us-ascii?Q?Vn4wu/5l2JnpmwioEFhT7QmJdfopSNGeGGjmlL0YNIhF3iRsA24C7BvwxcEo?=
 =?us-ascii?Q?I+PpNosWDilJnyWqOhJQQgfzjS0asriDJQ+rtkvE/q4Jz0aIdNBrhkCwknLO?=
 =?us-ascii?Q?uW9gm8yHvGhsl8hgT0/oPotsAVuS17PqBcz721ie5ryVTRtW3x+QHiEXpQcA?=
 =?us-ascii?Q?kNRA9OAJgrxvPMeBBlx5w8PqzVFOpvckW99dOnIPSI7h1Rf19YxwwiqULJsf?=
 =?us-ascii?Q?ZFqVhOHNyiFP1ma3h0U23rg3wSV8j4g6KEkD7mE2GILeghzyJzyCFTPEIP3n?=
 =?us-ascii?Q?f16DsxUy3NvtM8Ns2qCtyqqgdG+eb9AXrPhGE3X1NTTY6J+5BjaR4/fQ2Gcd?=
 =?us-ascii?Q?iD7Pivtw64Sy0YPOxJnEykVcsZzJjZ9M3ltWywq2ryqY3qGx0Hj9FjkgjTn8?=
 =?us-ascii?Q?SaYrVy1NTNGreTDA0D1FEKgX7LzY1URQ8wssJgsrY5GOgpTA0G2ItGh6HmC2?=
 =?us-ascii?Q?st81pQja5JQnRKpI7N0G+OI+YR7R7swVBsVhR1H8oNnRPaTsSyNtIJ9yKITK?=
 =?us-ascii?Q?Fy7L0RjYdEjA37otJHYLlilwwvMNSSH5ITrB3f8D1afC1bthkUsvAy545zc5?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	odHBGvLUzmYCmeZJRp+M3ILfTyF3nDaZmsr5FdFuZhnZCNR9fGqkOYq7Ga5faITIYPXZqJuO/pzohrr/tUJcyvMK85VDPfKYGGTKGZtmscVhNwX3KB6e5EHim33Thy2a/RiPnjVh00hyvTm9mcf+2MgTVYxr1Tf9TvG2mlPMxcXc4PEo3kxKtWEdxqc0kDLluriiyXPwpoG70aeRuwtyu8Ib9eS/ecvQAucpLKW9wPKu2AAZx1WVl66h9kaFgvrIsqbSt1pHquPUnHp903rLHOCZUVfbc7DUd3MugCK8eVlwVRJnIrl0M3oiUZUt0eh+zg1tlnqcoG+cYFGysgy7uWH3xUQ1aU+oTswsxD+dPcHpg1I+ylj/MDW3XhUa7Xj3UI+DUt2C4kOf15mfdc2ebR3sjO9l4iJ7Z22aK4Oeg6ii/4gWfHo9JbOsjSHHBHG/gTaOHignBO3lGTYl1MFKRbAaE/VoUf+CjNoj+pIsYYdr3iE+VA2W0ba8SMg4ZdeTPNFTBKD3hWH04J5G6o6vmBP0dLskEFqUSbJPjHwnWfOmpBxn7lF2t3BJp1pG7CUSDdZB2ygAjB4b6iwagHN1+LUuxqCKAvANa0/vNWT10cs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4dec99-0cc6-42af-6bf0-08dd551725b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:06:46.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1j3tiJU2PT4MXwG6NWd75wz959TZtX+CBwWNEN4RBn7RBHREXwLgPkIPq5BCXnCXlCvs03lPeGh0mfT0gW0Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240134
X-Proofpoint-GUID: IcREgc2jHE6nFbfFxcz9EhFGLVFtkTqV
X-Proofpoint-ORIG-GUID: IcREgc2jHE6nFbfFxcz9EhFGLVFtkTqV

* jeffxu@chromium.org <jeffxu@chromium.org> [250224 12:45]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> covering the vdso, vvar, vvar_vclock.
> 
> Production release testing passes on Android and Chrome OS.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  arch/x86/Kconfig          |  1 +
>  arch/x86/entry/vdso/vma.c | 16 ++++++++++------
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 87198d957e2f..8fa17032ca46 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -26,6 +26,7 @@ config X86_64
>  	depends on 64BIT
>  	# Options that are inherently 64-bit kernel only:
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 39e6efc1a9ca..54677964d0b5 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -247,6 +247,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	unsigned long text_start;
> +	unsigned long vm_flags;
>  	int ret = 0;
>  
>  	if (mmap_write_lock_killable(mm))
> @@ -264,11 +265,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  	/*
>  	 * MAYWRITE to allow gdb to COW and set breakpoints
>  	 */
> +	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> +	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
>  	vma = _install_special_mapping(mm,
>  				       text_start,
>  				       image->size,
> -				       VM_READ|VM_EXEC|
> -				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +				       vm_flags,

Why not just | VM_SEALED_SYSMAP here, and everywhere else?

>  				       &vdso_mapping);
>  
>  	if (IS_ERR(vma)) {
> @@ -276,11 +278,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  		goto up_fail;
>  	}
>  
> +	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> +	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
>  	vma = _install_special_mapping(mm,
>  				       addr,
>  				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
> -				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       vm_flags,
>  				       &vvar_mapping);
>  
>  	if (IS_ERR(vma)) {
> @@ -289,11 +292,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  		goto up_fail;
>  	}
>  
> +	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> +	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
>  	vma = _install_special_mapping(mm,
>  				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
>  				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
> -				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       vm_flags,
>  				       &vvar_vclock_mapping);
>  
>  	if (IS_ERR(vma)) {
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 
