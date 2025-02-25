Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06B1FBEAE;
	Tue, 25 Feb 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497059; cv=fail; b=UxYHbpt3ygtx/QWNKQS8viYsFv7ApmV0L0ZGBqWmnX3cZDFGSdb2Sj2h7ULsCEFnYNS38TeeO9j3VPZgvewh9KrdU7EK/cF+1I+Jsc5hdH1RWNQ7C5p2Osf1cEr8yx/fpLw9WhK7cAYdppswISKydES7t7uyPAp3Hz5Ncz//0wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497059; c=relaxed/simple;
	bh=FIonS8j8utSO37C0YgXTE7BNO9QtEjs920RGsC0IcBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/ne6T6LdP7v9NWik7ZLKMoYzLgSYSPOdm+eK2+IMjUHUAWRJlNQcwhWjrYzRheIZGAOQucLjCZ+2UdB1MzPQu3JXdrzLattqSM6Al+Qso3yd7qzaB9dN3/Evy5RdivtAEBhDzWtppKQQRyMpPRWpq4PNWM193TqwQDp1B8zGtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QBSuz1U5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HX4fyv7/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QBSuz1U5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HX4fyv7/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMbEe002021;
	Tue, 25 Feb 2025 15:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IxesPbkVUJFlz7JD1a
	/p9H8nYmqggrnTi/RTPolXuSY=; b=QBSuz1U5zoem2gsUL6bdo15Dj6oCRpqn+N
	RcCOdn+X7uG2y4iQjw+oV60w7erwIUZSfeVcD2tJkl8iTuESdM4P/DqeEMWcZXlR
	322albB3qtlCGG9HzGdFN9DxEQjGVzChoQLL/SwIwCxben4g8bmjPIqWwnYJFCPD
	mF793bxWMP+mcvbiP11jzHYvuilO9KcNZvyHnAXSbZlGZHGhbYIbTWRK5cot/Z8K
	6lsX8g2necPqb3uBJ1gdj1Z7DX1L3Ns6zk76/RN87ovkQfMLz5hYcXdmr/25oPBF
	l+SHzkhXysS3Uk0J0AINqxeWCyMk1gjXuIfxx0ZWwG54mjJ8RP9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2dj15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:23:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PEudk0002741;
	Tue, 25 Feb 2025 15:23:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y519kcb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:23:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8OYpkdwp64xyf+p/EvPnffmJYAgTtbjX1dC6Xo+EG6DU5g5dFUmkRkGK9+/iBCGM826oGwcstmCLmNMEByabMbLO6Az9pQFucVEYJLV6YcPConC4Vs7YNR/ouZMtC8NBTXE0pgHOZzObtT1VqupKQJ7JFgDKf3msuKkRyWKaMoUhQNsyXy97hOhUIEjGm2O/qYQZDoRlC5RtiPVRzHRfpJ0iLm7OMrCQ0WPG8kMNzExe8k64Kas8mUKF3Oh16nUwTma3npXL3SOmONBuCwdhy5+IvfuPqpwNW2TxgOu2fQIQXwOuxjKKsivrrvjqEzGCJvdrs1HR50chZNuBIi07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxesPbkVUJFlz7JD1a/p9H8nYmqggrnTi/RTPolXuSY=;
 b=C/kn5Ujzh0yqLTW4Pza2Xq9+RZzl85w+0VcqIfzuKVpLRduV/q2qdNY8rzRncWZ5g2hfKi2nkcVamloGLVduo82lYaX+9vc9Kw8UWy4Dg1NnDMotycgLNOsIa+UbrUBs7E81cbNWrDJsz5lK0UUwjP0eUwy1WWdYofEUesAi3OtsKsOTmTWAyGISN3rzxKRVb+YcbbsJ6ay4xVCJYZx/jzvvwr1Nmh38g6yhMmHGcqj2pNkuvQoz0blnTMeRflOGdmfKdfgvi551bq3Uwk3A7UoYcC8tenkB1fpy0Xwvm59sxKPxvC5F0FiT/8TOjkJVQ1PIkNIMauj2lR356NJNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxesPbkVUJFlz7JD1a/p9H8nYmqggrnTi/RTPolXuSY=;
 b=HX4fyv7/2BDfMIXMmTLb0Nj7o9eREDs6bGVBVBXoXMs/z+BCZ5OD7ze2VblP6OKYY4ncULpjQnCCqJ4OivihRDnK1u+8NCayOVT93TH3Jg0Ab0ItbRAkILpEgiAPlrxAc2+F+pW+6QKYfk/E6nm5fCiK1GG/9Ds0eklz60pBr6k=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BN0PR10MB5064.namprd10.prod.outlook.com (2603:10b6:408:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 15:23:02 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:23:02 +0000
Date: Tue, 25 Feb 2025 10:22:56 -0500
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
Subject: Re: [PATCH v7 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <bekot7b4mhgdsp636e4zltao4bnqoeiu46yehrwpuzydfgt3ya@t5njn75sbvym>
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
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-2-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::30) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BN0PR10MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a44b71a-3c19-4959-7cca-08dd55b04b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eve8DWKC8+NjkuQZRMFrA0R94emstpQNitqYH3+MExy4X0I9gbeYuwz+rb9M?=
 =?us-ascii?Q?X+B8cRGcfgZyc4uIGEPz2OIIFKpc8bABJGT3gfmjN7Ff0p9NMy6RgJDeknli?=
 =?us-ascii?Q?/xNPz3nY6LWI0HsB5Kel2vb3OwAWdsw+799CQz0wpkbMmGmR47CeZ/5mFaYA?=
 =?us-ascii?Q?zi71kwPtj3rHbo2xcDEvYqlCvFYJ7oRtwZcAjuUu1bJ3M3jBQWctxY4+8Js2?=
 =?us-ascii?Q?+onI7nGkVa2xH01thU6zq4+fU/sHBE1wadgWQhRSOsSFSc+Axpi60PhGffrK?=
 =?us-ascii?Q?ksswCiac7kHeUMcAOg2XCX2hhbg6GUQZEVZSTrOOfNZ2RbCn5GzlN8Vvwv5g?=
 =?us-ascii?Q?G4ct0xT753EwE7Z7UNvftwe0MN+LW9qq+nh09ykf0xvGISNkdTQDzrUQ/M+2?=
 =?us-ascii?Q?AssaN1qMI3l3ZJtJe1w5lPeErCQIM6JzeZkg0K9ZHWy5UuxmR2aNF8DOA3CA?=
 =?us-ascii?Q?oXcMoGS1E+ADxNNl3tgMmdjZgNyf0a092+Yp3gUgHyZBGaimtEsNtpChVSC4?=
 =?us-ascii?Q?6sNu4szEdywSt0df2z/8Fy0T5jI/Ug40UeapO2+IoSEQOTS4gcjIccpXaRs3?=
 =?us-ascii?Q?3ztzOmpFLFnT7mBzeSkuZxCDSwhmTT1GL5FHbUF7pTpnNYt8dfaZadQYCofH?=
 =?us-ascii?Q?4uj7cYUNXn9FhdmpxiMQcvktA7rJWEdza+lQ2zqMpZPIpn8Z2GJNjD7uWgVq?=
 =?us-ascii?Q?8nKq5h1cpVSO9WtEmtKw40QC9Rg0TLESrAicVEaxh8XjyScje/cWniBTv4z3?=
 =?us-ascii?Q?jx9eJWQoMRzKWTR8Z2yr+1DqV8w/S7Wiz5ETIFkXQaqDcqReINBgrsld/T81?=
 =?us-ascii?Q?yBhOCPtQnZX1jdlfqEp6WoXKRn1sI8qDaFBtudSgU/KJYkGAQv4mmub3YdeZ?=
 =?us-ascii?Q?iwRxUjdqnucuPawcZWS2doQxpbIQ3Q9/q0hMtft+pGmiziEKVLMN0RPeGulL?=
 =?us-ascii?Q?4kV4oNe3YdbaxTshZRDh/jervW22Sn5MyyH3QBWkIAgzsgpb06i9byzD/Zyj?=
 =?us-ascii?Q?oWhgykhiU/fXTmoNqkxMVVcpYpqdRG/pnTBGYjFnsoDDDNxr08SSCjUL0ADR?=
 =?us-ascii?Q?90xPwI92FjeKkDmqOLDo3VqJikjaOHit2TTK9nDBXZtmzy5u01+PSfgn9xIH?=
 =?us-ascii?Q?rRhUThuPPpys0SAq8HDHh21y4BE9TQmXvF4xS+TAGNM2IebKaXXloJzGiXds?=
 =?us-ascii?Q?teSkturGbnQEfekjOKIB9+iuVfbdXWIoHJOJQBe3kkIL2kdwaNzzclaXK5oq?=
 =?us-ascii?Q?SkUuWwjNjLVfJIk3Ue/SRtytq5Y5NtAZLlrfzDWgEp9LiBTkZSQa0dC81XyK?=
 =?us-ascii?Q?0MyegeDEP3ihGLZssvyPF3sOLVKCtrFTbCbi0Qnym5UATXRBT4t1Y/qvB15W?=
 =?us-ascii?Q?a4x1dIpQLMpZSN1o0ojLEE8XO+8H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7xrkXodC7Bvame+lP2GpLY3Ng4Hdkw26CyF/8/J80a/amTj+6tscPVXj/nW/?=
 =?us-ascii?Q?gzM6bksEC1enR/m483qO7K0EBEbsz+oFyvkgIZTu6wfih3raKD4pS9jpdI+p?=
 =?us-ascii?Q?rvOvprWuwz92cWEVyUqL/rqwCt7rZtg4jRxqSaZLcSnfJKXxP/cGAUMJGGtr?=
 =?us-ascii?Q?mz1HdgYv5PqSgFLdMe7daxWOw6soHKtxZTd4XW0jaesBvplDBq38Dhcc5ZBE?=
 =?us-ascii?Q?PkLlvABi7mpUg11l6WJvHKFHZlLlsgYHIxKJSwNtET8O+QYNnkNDNhieXKkL?=
 =?us-ascii?Q?3538LxWhkVdFifu93FfW8ZX2vvf/AGtgUV1r2wdZsi49qH2BtnZfAkN90J41?=
 =?us-ascii?Q?fMr9Ifc9PR/0jmoqxSyjlJ8vv16ijnsb/LsgOty+3ZwR/UVoWU4gjyiMyUg2?=
 =?us-ascii?Q?EQdLAiadjRuO53tcw2weWg8szSarqDCJINlT3/1AvF6M6DaOcnO+6EUeiUmz?=
 =?us-ascii?Q?RmPaFfsod5zjyBzB58NiP+pArrywdIdgh5ejumMpGNlm13g47A6EAglzrIAN?=
 =?us-ascii?Q?yVl74Z6vZmM0yV1EGZPfEWQXuLizkzLV5ACd+duu/8sqCUYFNWDROiO5ZhZP?=
 =?us-ascii?Q?6gr9Bdz1S4SFkaHcY18xpuSxsMuEB+f5g5z4brVrk60/4ILjqlVjl6q25RTv?=
 =?us-ascii?Q?MRLX28xD7h9eccGnm6XfLu/p2tZlx1calDXreGG/n/DcmcXXCwHeWMnWawoy?=
 =?us-ascii?Q?YWRRX/Oo5ag1QC6DDLjFKKCLtuEspOKR1SoSRnsR3/Pp0+5YVa/FzECwdr0j?=
 =?us-ascii?Q?PZhuPRAekPLkq9MvvIEHtyb4mMVV/+hu6H5IITW96gKydkxUywwwAUZi0r3N?=
 =?us-ascii?Q?g0UZTPJNncwE6+yuJP62T07KSMT0mFwMAA494rACrems5j72J1rj+UZj0N1K?=
 =?us-ascii?Q?N7dVhExwcyJst2kyLZFAtPqj1mVR2VrSY6B3QW/I3rH2xO/PzefhK6IrLqYt?=
 =?us-ascii?Q?dcwa3uEq0Rc8XegKmE+x6CGOM9TIBf3yXgF/Eef8CdRXaWpEDR7X42lyUoEX?=
 =?us-ascii?Q?pWl8RB50wG8BAp+VLK0OGy49S8Dq4Cihdt88CHyuOZKCAmYvumptdpyAsgP9?=
 =?us-ascii?Q?wxf5eXQBI0PdXa9nWRAozMfVXJvc6QvRg+qusiTuWUKu/VNC4FGTquLF28uF?=
 =?us-ascii?Q?sLQu5rGzTsjIckscTs55RAjB419qtHVQRH64zX9Pa0RFRR6oXX90A0T8yw9k?=
 =?us-ascii?Q?1IfKbiU6Hj436/Ai9Na4QLkunYJRK5DvvamnFoUEDB6DylQXkyFst098oMVN?=
 =?us-ascii?Q?SyZgISYiLJVS/6tWhAW79E04nGaWjpbLs5huAy+tHXgKcCmIcxhFaSOybL6H?=
 =?us-ascii?Q?RTI1CBa+gQ4ayKx1PoRsA6ePxpEsroyuZhigp3lg7saxxQxEXDRqtM8uqlb5?=
 =?us-ascii?Q?sMqblsb7p87ppEzviMYuq8TDco7GbnPnSMOI8BejN67mDkjXMexdWiJZjwW8?=
 =?us-ascii?Q?2sgTopqLbIHi4B9sTk7Zljyp+jmS3ThXazVvx8Mpe0j0cQgCPNekIGgXRLVn?=
 =?us-ascii?Q?sf0BpSpMYI2ZF5J4k5moMA9d+E0b3xaX8GjYNyYmoqdI7ZXvHUW6fzwWjMdq?=
 =?us-ascii?Q?uZPKhTKYKv2PVQhUsO9SrP361IbIqQ85oMlLzi+wOJL7rvEpgsfo0YqA5KoP?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4WIkUnne/43Uhj+IzJT8T8uFgnBoSuMKPSCkFWDQNJ3xHrTrVxC6Xh1GbVt2nzH/CTm7DnLM/ddGNKj6lD3majwHnYsoPas2kg/oQ6WC0AuH1fmD29eU40mXeFKHMmLQUpBJ/WJoMIvPda9DCe5w1SxhBoiwWK/h1yQdW8YDcbSc5R/sfAiCJ0CVpuLfB+cdolq9BJ8aslgrNBmiNIQQIt+NQ8OikaaLq2cXnOFvpN5p/0bhMsA5ZXx4FmaGgt8bVaR1OrE5tHtGcDpp/K6rU1Wqb2TubdKWGsnlsIkGt14X9E48kNOZ//yFj5suTrSuMMaP5DSJsmIipv656/RqDyJLmsSpuaom2SLzbPubzmGB3dlhnhpvLzM1RWMSIdsTmZQuRfh0YQNjFWK7ZWK0NfXzm9QkP4D3y66DQye/AF03BcC8oEQpYDEdvYD369yanixe472R3p2PmT0pxlw8QwiOJAnVZqVsNEB72g5e9KTDXE8CL+PB+xrv5x+2OGUeJsdcQFQ0j8VVVyIqQa1/6g8/zqOk4e4oXAYQIV/BfU9kGogtkh1D7jncKytzsQ01dr3a9LBQBz9lZXzCDBF8Kfr1h+DCoTuHa79VvU3oBaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a44b71a-3c19-4959-7cca-08dd55b04b72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:23:02.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jtXM9XZd6DH4GIK0BJQ8wIArok9KG2CUlYoB0qqKx/7HFGgEAMQZmGZZosu5+YNNy/WyYYUeyutPFQ7v9FpfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250101
X-Proofpoint-ORIG-GUID: r_rY0dvVA4PTthcnC7OJdzf1TSfGzkyv
X-Proofpoint-GUID: r_rY0dvVA4PTthcnC7OJdzf1TSfGzkyv

* jeffxu@chromium.org <jeffxu@chromium.org> [250224 17:52]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide infrastructure to mseal system mappings. Establish
> two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> macro for future patches.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  include/linux/mm.h | 10 ++++++++++
>  init/Kconfig       | 18 ++++++++++++++++++
>  security/Kconfig   | 18 ++++++++++++++++++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..8b800941678d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
>  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  
> +
> +/*
> + * mseal of userspace process's system mappings.
> + */
> +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> +#define VM_SEALED_SYSMAP	VM_SEALED
> +#else
> +#define VM_SEALED_SYSMAP	VM_NONE
> +#endif
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b..07435e33f965 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
>  config ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	bool
>  
> +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS

I think we said ARCH_SUPPORTS_ for software features in v5 of the series
[1].  Can we also make this change please?

...

Thanks,
Liam

[1]. https://lore.kernel.org/all/202502131142.F5EE115C3A@keescook/
