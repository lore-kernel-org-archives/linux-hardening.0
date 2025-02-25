Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E920AF82;
	Tue, 25 Feb 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496775; cv=fail; b=XU6YqA6vPI3eGt2nggEwD0daNtvbNUPbR+mFGXwEwdy3H3V0Ee2q7HDs5L/Cwln7jGnpHDD4IbDMzbHMoxtkXkYK+Oe8Yw5efngHO443igftWlw/pe+CxAiNEdzk3ybaGcYugCn4M3nwfQHEzlYGml4xC13IUkZSL/dbMGIqWaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496775; c=relaxed/simple;
	bh=gvEx/vxoSnblfi6h5N42rtt9NChR0gioamreQQBgwAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bq/mHBHIDb/4lJEJh8BvcbtSXNRu00Zs1DLSkNkL5PaAACdrfUsKjWWBLa7unvEOwSZrsmNJfmDqvCO/XppHz+iL6nl8SKEqwjy1rHgQx4d06TnqaWl+m/KlXMMNTYFUMpJVW1NNX1Yi7ADBtIHP5BpcWXoibhNuOia4gqu8+E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oKlnI6hM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NrX6Sk7g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKlnI6hM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NrX6Sk7g"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFCMkH011937;
	Tue, 25 Feb 2025 15:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=T22PzFk6Fi6K0EBQ2+
	fk0coXQf7eOyeOw9UbFs0QTYc=; b=oKlnI6hMXLXnuBCZdwVWn5yTrW+1+LaIhn
	H2GQ113HF3JkQDp6t4SXbW3/IXm0zkvEDiwJkVFCnOr1CgoJ0xgQMWwHuYvYALKk
	/PAyB5s5oQKUXDrPuKck8W7uBxdHmob+ZmPIuBglT4i3P/+8pyGfQ69JDyEenQjO
	TvdWLvdlYOYPcXjMjbVKWgalHgsrwSes05EPn7pN30TM2XDczR/UdSSnkUPX2Xvl
	kKiiLvT1UFqxmHCFjnQze7Q1Z/GbexO6y06DX4EDRWYCR694d3RdqbrxcZuS3tXe
	aFwp4wKhsa2DRXea8tZ0tZeBx70/CYyzlsRaminlMfScXIJikYPw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t5fbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:18:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PEHHAm008186;
	Tue, 25 Feb 2025 15:18:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51fce35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beEQ0vvu0HjEbAF5bOOPbmUfBjHNrFDp7QF9KlK98mc6vRENN2j1+geNxdQWMt9WM0YyMqOWuJvbVolge/1ROaz/z18NxbjFM7WwqpSvNsX9rIzVq22ovjHhSdADVurTyh0xNPKkou0cbFVOSYwvTpVxxJ63bSQW6J2QOBez5YIx+ZQgXlE15AJcT1YpF2/yKV+f3rCQClQec/kk3Nduwu3wFoKXkjHcMSL2H3g7A2MIhEffAI132MlG52hqFMXO9VmifIbkg9xnvZqmQZianp/S5h309YUCTTVjSAdeoIUSCYRdvH7hH3ICu/c3/EYjB+nuJC8Qf1+yaSbza/PQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T22PzFk6Fi6K0EBQ2+fk0coXQf7eOyeOw9UbFs0QTYc=;
 b=cuCAqi7kC1/HUHdIKqO5ivYiuUOLVD0IzTMeRydulcdxH5Njqc7eaCfGdSulI0N0n0s7xYOqvoTcpK1zQ2hCo6GNUp2sIu1owqQFuX1nysxDDW2qjvdu/5UAlGg+4JQe/kCOKwxaQBdhTvaY57kzcIoPM0KzSDelmQ8PuwQv42kf0xfCHwCaxisAQxQREDNx77GspihU0e2zJqI0RYNVB9PZAgi0y/Ud5IAW3YmxnLnFXp3QeySwe2JNMqV3r0fzLrx4BqjsFM4bL4GJdmXfPQrjOsuAxQA8m34vGyRbHKuy+0tePPbOHt8LVvHciQO+3KUhD67zLIFS1b+RUsKGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T22PzFk6Fi6K0EBQ2+fk0coXQf7eOyeOw9UbFs0QTYc=;
 b=NrX6Sk7gJgAsqYT4mJm7/NSvYE/hbgfAQXe8uR4n2cbWx983vTtRt1aPaeT7A78GqrrLLqNJXeMIrEMmtjBsrNVbuirIN5gZ+lFdNaxeUaJIq6HGG7JjdTwEsPSTm/mx8DGMUPL95sVQAMOase9KklOQ55VDY2EXyDCY8CvQuWo=
Received: from BN8PR10MB4099.namprd10.prod.outlook.com (2603:10b6:408:b7::32)
 by MN0PR10MB5910.namprd10.prod.outlook.com (2603:10b6:208:3d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 15:18:38 +0000
Received: from BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d]) by BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:18:38 +0000
Date: Tue, 25 Feb 2025 15:18:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
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
Subject: Re: [PATCH v7 0/7]  mseal system mappings
Message-ID: <e697ee1d-6075-4f24-8365-32aa4bc84d7e@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To BN8PR10MB4099.namprd10.prod.outlook.com
 (2603:10b6:408:b7::32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB4099:EE_|MN0PR10MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba3e0d8-789d-4ef6-9c11-08dd55afadde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70IV5xTU0U6gDDihT4JMqke769h3lD8K1jhDyb17LOsymAVFu/gYHYU7DV6/?=
 =?us-ascii?Q?JQsvXlR6M3KvASL7oQN0XZtISjHEw1NI+WHB8nVl0c+V11Dzx0eP2pwqeGoM?=
 =?us-ascii?Q?IgXHTYJNdVeXXLq+Q213YmBnHFUOtsghGXG0XXik35te+PIHs7UHk4FtGgyu?=
 =?us-ascii?Q?R3eSIMK31TxPAhD4p+a2/ofDNCegE1kgzd3dGjnzSr357ZxPjuP9At9l1rv7?=
 =?us-ascii?Q?fxger0I0Gw/qOuIufSJiLVNyd1Vicdu+00t6lo7WmNZ8dHL3TE3ieoSLYGKE?=
 =?us-ascii?Q?sK/myUJyA+KoDoHA0woEo/TW8VlEBOg+lA/VZwYULI9DErcuxSNg6nSCX7Uo?=
 =?us-ascii?Q?+1IzO7/RbRtAEye7+amCRaoWjOLx6cTqxI4ZgfCseRadJixy7NEaEPfHKIZg?=
 =?us-ascii?Q?9zx09/Czgzh1rj3w0JmDSztKiBPq8clIg0+glpFwov/Q2viVcqomf8wDtwOC?=
 =?us-ascii?Q?vbLhvIff10deqUcKMq9Eztyy8crfcfCIhS9OJ+0HfznO6SaOYN6tdLHqTLWL?=
 =?us-ascii?Q?0GsS6f8FPdo7Z5Md/PzeHRM0qFsX3bRXG6HumF/I5GUuuHfZjhl+0HbxMuZn?=
 =?us-ascii?Q?/d3rrFU4qNx9oTBRiHvxR8OB1RkCXDUwZmATDUnk45207u6kwmCTzV2SQymj?=
 =?us-ascii?Q?wwZQX/289hZ/Oxy/nC7KRYaX/1JeE6yF6GtFMWZrKywwMFDQshCwDB5Dkhk9?=
 =?us-ascii?Q?rcLbIldMFvI1lHOQRIYDIZL/9h6IV0gbJQyYK1Ly3wFBB7qBNtkWa5gzi9x5?=
 =?us-ascii?Q?/WcnTUwTv3gHa9Ao9MsLT499JMX88Q6MlDm8LiWaOK/edm5ct47VwWiYew4G?=
 =?us-ascii?Q?49IA3bUcNZlHLUapyWq5Pxk9z2GRwlRmNhI5PeSy0umg0h4HtvKRuDOe7eqK?=
 =?us-ascii?Q?M7oU4UKvcpT4lDIMecVbTfB0quuehzjBooCNvVx5oeygfFRdOB7qosTLtlx7?=
 =?us-ascii?Q?xVzKoitBb62C+J3XteHlvcD/L/6x3MiXFTYqYWmT3xwi3zMhDgMRW3L23MpJ?=
 =?us-ascii?Q?4l+7yEc7Ip4L1h09z5zTfai5PLSoGahDKDoV6Qb8eJDFDH2QNdMc7BcIZlcL?=
 =?us-ascii?Q?jNE9xHtGYwfDDxH3JI3B9HFDJjkqb39dDrdRGHRVgZqIUKnBug0/qUsH9Gb8?=
 =?us-ascii?Q?hBNEDEwvP58o5ejjbMDQyLwGvBv7PhKXmeOf9k3EONjd55HchZfEBcMwUKIG?=
 =?us-ascii?Q?SdCKcntmbt26NAReNMmztLXUX3JIhSsBdPMYIWUIWFIoVlaRrfpoF9Tpea0n?=
 =?us-ascii?Q?lYZTUAsYgTK7k1fOC7qj7dzufoXSPJ7Sb7EwPM5yblVmX5zXE8l6yH16LusY?=
 =?us-ascii?Q?c8RXBdvN02LR+jq0ptwVwjkg29JIGtaa01WeG2ZZ+/4hDcK40Sc1vcOQjCA7?=
 =?us-ascii?Q?tSStR9DTH50mLRx67fgytcHiqLj/hm2/jFw9wVIgrVYwOrHgkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB4099.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tjjyvFs27aJw6f9MFo362M0QhPWhgK+7f4ETsiUuSGL4l67T9sUfUBWq5LHz?=
 =?us-ascii?Q?ziZ0PjGU/TWo2ckF7gWpCItRAnva53ZWcpXdtG1TXh4W8NVAQm1dDCXua7vm?=
 =?us-ascii?Q?RV9CGomIh9fz8fw6GbxROA1ixfn5fpIlCdHyhGCyurUnXaELNnlGcsWbYgyu?=
 =?us-ascii?Q?u3HCULQGCeTQRSMmjfvrXzSkWHpyaRed4AEywHp9u/XlNkWB+ycqh+NBIOmi?=
 =?us-ascii?Q?wfz4mHp6qFt+vFRreDBfl0VFOYaUtJBbWsqMbDV/5M7k/wJ429wZUJ+Jet76?=
 =?us-ascii?Q?wSRs4+KUlg+WaH4lf1ZsAKYlYWQElhx+wQks2yeSvfpoIW8VuLYZzJfJHFnR?=
 =?us-ascii?Q?R5R5i0uzNODBuwMZDW/D4IWV5mTQOQA3s4OyHydVzdfVOvC9iEUvqkPACIjt?=
 =?us-ascii?Q?4uF11cPcyZ5dSKuqAy5HrZhWi8xMzSAAcTtqxj33yrlOeYKvWmx7HBHayVgw?=
 =?us-ascii?Q?qGu0TCtkCYnJpEhhL17/8L7D2s5fzMOYpYZS8LWoFPwUBEzv2DCSRZlnbE9e?=
 =?us-ascii?Q?ArZrizyRg0BKR7suYPp4Nf9LbS/YFHjD4mcyECLqzzb+k3Hp3UOYjrPYk/D0?=
 =?us-ascii?Q?67GY6csAMl959G/GLilJxXEgPCz+c+UXxL8uUHzxuXZ1jIRhnYcmsHpIfX5H?=
 =?us-ascii?Q?NcmKNLyr6BgNnY+WdvXyfNyXF/6W+IBjXZn+i9bcfc1jHeqQ/E3XkPGDWuYu?=
 =?us-ascii?Q?CYFIy3dYdw5ibn4M6jV4hLiSpI3CHu+s7Xosb/RBsGRbZwH73HaSgxxlJ1kn?=
 =?us-ascii?Q?wag0r0vt824TbKDJCsju3am+dx4cu3xzntP1J6+EAkwJ8XC+nugL8l2+L0vp?=
 =?us-ascii?Q?0somTf0Nzrv3JJW7Zhgot7nfqambGvMXwm1RvdKT+AWvpsJWOyQzMMQYs7bx?=
 =?us-ascii?Q?uBXxMgasTL1P+pgKkPc2CEwgXcJ/PYhwW7Ewzjm9dSRhr4hm2fg6cbAxS/SN?=
 =?us-ascii?Q?jh1OJf9pi3p3eudTgjA5WihdNxdAeZH+0TjtZ2pGJpJneJfVYDfUI/2gRqKH?=
 =?us-ascii?Q?FWANOprlokOopKHFX2IBl5g3sbDHYVPvIC4Qb8zAzodMZfholAJnMupfyyiB?=
 =?us-ascii?Q?5ASiD40MSJ3PZtBcNGCf1iP7EoA1pYhDAZ+FHT9bZNSJ791WpeBLsA7aAMh3?=
 =?us-ascii?Q?CJdr+sHuIOp3DFj5qlBPUcyNAQkSyl6yBYoiD7MSSeRTBQ6Nv2e29QDGq7MX?=
 =?us-ascii?Q?yPLhBowDqY+nrMtZ/3/5QQ4ruF3PoFH6Y4av7oj3Uyfwa54mo4/j5Q4Jc1vI?=
 =?us-ascii?Q?kZHvXQbUPeSMrTrz4ZJbiXVSl1QVM3tHgSJkBZ0k1K+sFEAlu6+2iXDKPB4A?=
 =?us-ascii?Q?bEqdTNcmzXd//Dref0NpVV3P0eracXaIPiiRZnXBSG2nqHpwH/mA18xsa8WY?=
 =?us-ascii?Q?FNu4fqHOe3g3dNN/Hg6AM0B9h/RDMF61bk2Wxj4FlVrXfT8i6nKj1StZu99q?=
 =?us-ascii?Q?uBlVDoMfI4gfCw86T0i4rXTxHJ4lYKRD8nr2MEC7M5aKNxe5JCDOG0dqLeAN?=
 =?us-ascii?Q?iUq037bJN6u6HJPYE70+YP4Yv4kyq8PiFRxiqR/Lplo7fLXiA6qBnAg7sSju?=
 =?us-ascii?Q?keJGlfGrwTVtSGqXIE2GzXPbrgtpJ6uEJDtAUA0CdFjEnm6T+UABBJPekn2x?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+qncushjv1xfCU4lVSCwdRxo0AK5FCwSohNgpNgeRdMTPZlKbCZ2IDD1giv5/WJ6tmEEoVgf4pGggo7OQK+0rPCrAu7NPA3rU05Skk5ifumgo+sAv5vRkJfAmoxOTxw23zBgx/MPnrn8S6Hf7sJJDBRHakrk99cbhPM3P1xXQRScEUifq01iPK9w6R540UqqLWYP1u8jrh39Uocfoe6OHmWElI3g7aw//TtQAe4mKUvp7fj/LKxvdWT600qUsh1l+DtJODfajsxNdaZ5im1bBop/5xCXiIWcMIWTxzwhkjbGVpbA/DTXAMrmzXB5zgtnz5sp35PXmD8amo4qxhrOjaTZlIv76ZEopUZzm1+7l9lR8MXd486UPHJupjVhJ7rPFjuJMv4BAqwjk9vdHpZbep9rrowlWO6ta5LqH9rkAj1ZLjbj5qgZlCFoHd1ZxI41RiV2FMbsqa7AZXBig17iembfTSg+0K5x5R9G6MAT+GIylGO4+bj49UTwBuQDvExEzyjQ8ecGlL6aKkENLjdJeLx8dSTXo/MNx8Rh5F1lXtSNu0ccYQoW9H6AGRrtBQ3dm/aMo7sZBw5yOUfKe4U3W7qB7iYAcoAexSxqswZDOc8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba3e0d8-789d-4ef6-9c11-08dd55afadde
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB4099.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:18:38.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqI9xgVRENgocJim4MxrQtdVOj+EV03f5QT3TyXnnQZ1YxT6W3xDogZUisszhDRI/CNSIBbNYS2Hl/pR9ODMtPccAGBZCGcjM/WtZFidl6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250101
X-Proofpoint-GUID: BZ4JmLQSydKbhyHZ1TSVdw7psJYyqKsK
X-Proofpoint-ORIG-GUID: BZ4JmLQSydKbhyHZ1TSVdw7psJYyqKsK

Jeff - looking further in this series, I asked for a couple things for this
series which you've not provided:

1. Some assurance based on code that the kernel-side code doesn't rely on
   VDSO/VVAR etc. mapping. I gave up waiting for this and went and checked
   myself, it looks fine for arm64, x86-64. But it might have been nice had
   you done it :) Apologies if you had and I just missed it.

2. Tests - could you please add some tests to assert that mremap() fails
   for VDSO for instance? You've edited an existing test for VDSO in x86 to
   skip the test should this be enabled, but this is not the same as a self
   test. And obviously doesn't cover arm64.

   This should be relatively strightforward right? You already have code
   for finding out whether VDSO is msealed, so just use that to see if you
   skip, then attempt mremap(), mmap() over etc. + assert it fails.

   Ideally these tests would cover all the cases you've changed.

Please do try to ensure you address requests from maintainers to save on
iterations, while I get the desire to shoot out new versions (I've been
guilty of this in the past), it makes life so much easier and will reduce
version count if you try to get everything done in a one go.

Having said the above, we're really not far off this being a viable
series. You just need to address comments here (+ in v6...) + provide some
tests.

Thanks!

On Mon, Feb 24, 2025 at 10:52:39PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> This is V7 version, addressing comments from V6, without code logic
> change.
>
> --------------------------------------------------
>
> History:
> V7:
>  - Remove cover letter from the first patch (Liam R. Howlett)
>  - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
>  - logging and fclose() in selftest (Liam R. Howlett)
>
> V6:
>   https://lore.kernel.org/all/20250224174513.3600914-1-jeffxu@google.com/
>

Nitty, but it's really useful to actually include the history for all of
these.

> V5
>   https://lore.kernel.org/all/20250212032155.1276806-1-jeffxu@google.com/
>
> V4:
>   https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.com/
>
> V3:
>   https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/
>
> V2:
>   https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
>
> V1:
>   https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/
>
> --------------------------------------------------
> As discussed during mseal() upstream process [1], mseal() protects
> the VMAs of a given virtual memory range against modifications, such
> as the read/write (RW) and no-execute (NX) bits. For complete
> descriptions of memory sealing, please see mseal.rst [2].
>
> The mseal() is useful to mitigate memory corruption issues where a
> corrupted pointer is passed to a memory management system. For
> example, such an attacker primitive can break control-flow integrity
> guarantees since read-only memory that is supposed to be trusted can
> become writable or .text pages can get remapped.
>
> The system mappings are readonly only, memory sealing can protect
> them from ever changing to writable or unmmap/remapped as different
> attributes.
>
> System mappings such as vdso, vvar, and sigpage (arm), vectors (arm)
> are created by the kernel during program initialization, and could
> be sealed after creation.
>
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [3]. It could be sealed from creation.
>
> The vsyscall on x86-64 uses a special address (0xffffffffff600000),
> which is outside the mm managed range. This means mprotect, munmap, and
> mremap won't work on the vsyscall. Since sealing doesn't enhance
> the vsyscall's security, it is skipped in this patch. If we ever seal
> the vsyscall, it is probably only for decorative purpose, i.e. showing
> the 'sl' flag in the /proc/pid/smaps. For this patch, it is ignored.
>
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the system mappings during restore operations. UML(User Mode Linux)
> and gVisor, rr are also known to change the vdso/vvar mappings.
> Consequently, this feature cannot be universally enabled across all
> systems. As such, CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.
>
> To support mseal of system mappings, architectures must define
> CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS and update their special mappings
> calls to pass mseal flag. Additionally, architectures must confirm they
> do not unmap/remap system mappings during the process lifetime.
>
> In this version, we've improved the handling of system mapping sealing from
> previous versions, instead of modifying the _install_special_mapping
> function itself, which would affect all architectures, we now call
> _install_special_mapping with a sealing flag only within the specific
> architecture that requires it. This targeted approach offers two key
> advantages: 1) It limits the code change's impact to the necessary
> architectures, and 2) It aligns with the software architecture by keeping
> the core memory management within the mm layer, while delegating the
> decision of sealing system mappings to the individual architecture, which
> is particularly relevant since 32-bit architectures never require sealing.
>
> Prior to this patch series, we explored sealing special mappings from
> userspace using glibc's dynamic linker. This approach revealed several
> issues:
> - The PT_LOAD header may report an incorrect length for vdso, (smaller
>   than its actual size). The dynamic linker, which relies on PT_LOAD
>   information to determine mapping size, would then split and partially
>   seal the vdso mapping. Since each architecture has its own vdso/vvar
>   code, fixing this in the kernel would require going through each
>   archiecture. Our initial goal was to enable sealing readonly mappings,
>   e.g. .text, across all architectures, sealing vdso from kernel since
>   creation appears to be simpler than sealing vdso at glibc.
> - The [vvar] mapping header only contains address information, not length
>   information. Similar issues might exist for other special mappings.
> - Mappings like uprobe are not covered by the dynamic linker,
>   and there is no effective solution for them.
>
> This feature's security enhancements will benefit ChromeOS, Android,
> and other high security systems.
>
> Testing:
> This feature was tested on ChromeOS and Android for both x86-64 and ARM64.
> - Enable sealing and verify vdso/vvar, sigpage, vector are sealed properly,
>   i.e. "sl" shown in the smaps for those mappings, and mremap is blocked.
> - Passing various automation tests (e.g. pre-checkin) on ChromeOS and
>   Android to ensure the sealing doesn't affect the functionality of
>   Chromebook and Android phone.
>
> I also tested the feature on Ubuntu on x86-64:
> - With config disabled, vdso/vvar is not sealed,
> - with config enabled, vdso/vvar is sealed, and booting up Ubuntu is OK,
>   normal operations such as browsing the web, open/edit doc are OK.
>
> In addition, Benjamin Berg tested this on UML.
>
> Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/ [1]
> Link: Documentation/userspace-api/mseal.rst [2]
> Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/ [3]
>
>
>
>
> Jeff Xu (7):
>   mseal, system mappings: kernel config and header change
>   selftests: x86: test_mremap_vdso: skip if vdso is msealed
>   mseal, system mappings: enable x86-64
>   mseal, system mappings: enable arm64
>   mseal, system mappings: enable uml architecture
>   mseal, system mappings: uprobe mapping
>   mseal, system mappings: update mseal.rst
>
>  Documentation/userspace-api/mseal.rst         |  7 +++
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/kernel/vdso.c                      | 22 +++++++---
>  arch/um/Kconfig                               |  1 +
>  arch/x86/Kconfig                              |  1 +
>  arch/x86/entry/vdso/vma.c                     | 16 ++++---
>  arch/x86/um/vdso/vma.c                        |  6 ++-
>  include/linux/mm.h                            | 10 +++++
>  init/Kconfig                                  | 18 ++++++++
>  kernel/events/uprobes.c                       |  5 ++-
>  security/Kconfig                              | 18 ++++++++
>  .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
>  12 files changed, 132 insertions(+), 16 deletions(-)
>
> --
> 2.48.1.658.g4767266eb4-goog
>
