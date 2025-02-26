Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA722A7F4;
	Wed, 26 Feb 2025 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593282; cv=fail; b=uJs5/LBKa1RRrh+M00yFx2RSBX6nK+nqXlgBbT4ad4NNqanpMDpzlmsTg6L4B1PFyEjb8rTcWswX2dk+0ZAJ6T5ojvzzNeG5K9Czt/TT0IhZMCWDkXDdklBDC3GxDpMjsJQ7TDxaXYW6nYIpCols+n8pjbcO84ipWEEgtTu34fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593282; c=relaxed/simple;
	bh=hHKSBQSvy3BgPUni/5FyxqA1/QtBgqcVEQRbnY0w4jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MkbS4ByEXtuZSChYmmsOneeVUJ1niNyms+IIAKX9A1D5deaqUeDNUHl2GZ8wnsydRHagIdlATeqZjoiGeFxwo1Kb0jKMyj4YDTQEeIXVJTiSI5izVDf7DBQONGi6mCQj2DTNhaR1SA6oA57BT0Rfu7kMc/iE6osnfZ+Piu+31G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ktOcbinI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W+TEkLbR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ktOcbinI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W+TEkLbR"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QHtawA018256;
	Wed, 26 Feb 2025 18:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=csx0QGzyRqngdc0Yf7
	9xdlX/rAYj6ycDoFLhqlNaULc=; b=ktOcbinIo8YffLFdI1Qw7tgNyW5kury7o4
	qJ2/cQ4LIOmKAzTNI0fsAckjZpiLgUKoQORnPY2zTUNwRsay+PmC89hugxc1pWQZ
	BejSmVzZSfkro8IG8lnfVShtTwkwTpfR5OKn8gItR9JZvPBHz4VdQ1MR4bpIIBa7
	JeGc7NDktSy0JZzf2JJTOoTztX+Lz1BxuFsk2s2ATqBfsK9O3qs/jooOQ0Q+w1XV
	uAf3HuJbweY6oDdqnLWbLeRykYE/uPpzHQJfDBMnZY+GvAlv4eQzwdZEpQLpeT52
	ExcpLRy8dZdug5ITNz+zfWnXoxTUewIzozDLxXVmmpQOYNE633nw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdhtvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 18:06:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QH1CFE002704;
	Wed, 26 Feb 2025 18:06:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51b8use-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 18:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyHqdrmPJNFSgsQcrbN2iSut/leBqzjtI/3xJbnSd6y3voN3YESnN6o94MFF9MprG21e/fQRLFsslgBqi0OMYvxPhe0QsxwzeW5wHrsuJuvwMKFdMGJeKBLLb+8pWSx5/16XzbCVt0KSssPI+d7EbRh4iRIx5BGubY1BgOh4LmG5GrIADwCQU63IvajxZtKpY4eek/FJ52Z6Y4/KwT4wFJbXhck3ODGum6DhEIDLam38rOmDbbE2LekP8mC4O5dZ3Q0vKWN7QJnImFjEAdtM2yrAoH1ww40smrAmM1nQlznkuB2S2QN9Hla4H0Q0Lz96hBYZx+it8XFKwCgYQ4W3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csx0QGzyRqngdc0Yf79xdlX/rAYj6ycDoFLhqlNaULc=;
 b=CBGS7N0WsCAsBgzzL+bFDqYv+kD8pDpD4A4r+BJpTMZLh2COX7K9u5atTXYRUxfZ9K3Iv7qpJydGvYA9hACvZa0+KyexO40FzoVOeptjKRlv1McIxKOM8Jdgmp21WPtiunzN48W/VQ1Ttc4MwBW4HWyoEWGZZ3AXnb83KKC0O3ZzdTi42qI+CK/AgeRKBUpyWu/9wBnsHdWPdqUm+JQUDaBvMouN/zDjP4QqJxaBjhS5g5pI+NtH1Xkgv9qSnHfSNJ7cRDk3emKiXRf91tpFw4HkW6ehbygPkxH7yVMG5GUmHnELoZKTkGUtFy7ovN0eaYO3/Tbuq1KA1tRNaJRyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csx0QGzyRqngdc0Yf79xdlX/rAYj6ycDoFLhqlNaULc=;
 b=W+TEkLbRC1wT567A/ZKFIohIGDrPVAyCw9D/zyC/uBEvVoy9dXhkqZZRY6CRzdJ/Jr24tGR47EixE8+mwCxA/7KAXjX3F/P0gkHWnEEouPD0AglZCAAPWMJxJS/dwxPK2GEPsMMTXMV9WAAVwIqslLr6kXirC8FXGO7DTRpxQ7g=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB5627.namprd10.prod.outlook.com (2603:10b6:510:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 18:06:11 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 18:06:11 +0000
Date: Wed, 26 Feb 2025 18:06:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
        jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
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
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Message-ID: <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com>
 <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
 <20250226180135.GI8995@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226180135.GI8995@redhat.com>
X-ClientProxiedBy: LO2P123CA0048.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::36)
 To MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 228b8a76-7106-47a5-8cce-08dd56904081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R3KoARSNWomIqkO79Dhrk1KpUwMNU+zjy38+1xdx+pMmpMY34DlCa/nB54A5?=
 =?us-ascii?Q?E8mXyeMeFdtdQ4TffxhgrX2WEz4klEsQAN7G0wChbysASwy1Fb8lHyLGS2ru?=
 =?us-ascii?Q?SQ0kMChIZ4H3dKeExrc3LfDtQMpWc9av/ts9Uim6EdmJabfAk7UJBEcV2cNK?=
 =?us-ascii?Q?mtxLHf1xqAwUYSRhLVhu1GmsvkCjQt4vXAEyn51h8oC1MVR5GghkA3RrsCVj?=
 =?us-ascii?Q?ksfBNpr5n9feSQQiULWCBk+UDlRXp1YhPNDi7Lf/bh+1eXV3DSx5yatHfKCP?=
 =?us-ascii?Q?3Fe4oOce5OA+IEIVHjng1NcsWzdih2P5zJ2kHm+kkFrpFd92bzu9AGiJubXL?=
 =?us-ascii?Q?Q/PL42yPaEeIDeKp13by3RddT9qamPAf9Aa1ZM3dH1+Ml/n87LH0nrNGfrB6?=
 =?us-ascii?Q?f/w1MG0mZYKYgPZ7/t4DpKiOexjFLyGuSZTLScNCc+ToMm0NC9odyMaF7aJY?=
 =?us-ascii?Q?m2e0lw3W4js1jpPC1W1vOAtUv7frSINeRZn/mrGOfrVUPeE2hnUhSQKLNhL1?=
 =?us-ascii?Q?TajcbQY/kSs2f9iRrMHF2Z/MeseDBvESHmd9hDQU8k/Jhmr+Ps6zuM1dmRV5?=
 =?us-ascii?Q?r+gt2otY4H2+uLfmvSVJCyZ3Jnl/34ioVomCQ66b9gXne6z+yHMTA4vfSOxa?=
 =?us-ascii?Q?9tW8U5ylXKzvWo2TCdWeoE95T8S6rqP44W5dMk+Lmiw8g95Lc+6kxFk5n7D9?=
 =?us-ascii?Q?BbC6y4d9ZfLtBJA0j3ch+XZk5+pWIdynx2/qvLfPPnOW7GqyaAhnjyPFBqIo?=
 =?us-ascii?Q?+ayCg1K5RYCE/aw7oOeuJ5BaZwERC9SHRd7rjVFAzuD8Akrqj1huUGbhFscA?=
 =?us-ascii?Q?Nq6eXxGaUkdPq35fXrfHjcoAVG84UKBQYGT2p+sH1Joo9ER24hXgENwFiLNL?=
 =?us-ascii?Q?uwa+MD+6Rg36w+WQCqmmAAlSXGOM7Mq3FO292YEYrUpfA0iPWZlLV3LrCtin?=
 =?us-ascii?Q?wH/PE9P+/xipj4HeazQvoyq+/wuDhG/8vgMXwqKYQ9XO174T26V1RCA89Inn?=
 =?us-ascii?Q?ihF0bUTmvtRa72L/9upknEi3j3AjmsW5HeAD8LXfD5ZZVTRSnvNzUZO52061?=
 =?us-ascii?Q?wFC9yynr1gx88/FBhgD0tN9oM1I3siwyjoFB9lgBzyldPwaFCwphE+KY59CV?=
 =?us-ascii?Q?gblGWTeTGr3WTPlkDExIgMygldKaZQL4tPJ+06cow8lGpqJYZl+EP5xf6mbL?=
 =?us-ascii?Q?wJwXqJBTXUVKqhxvXjOnEJZtAvOopXjQnbgWEovwYQWbswq/VS6EO89pOykE?=
 =?us-ascii?Q?5iGul/Uz1BarNZI8RyHut+PU7jBs9nxTFg7uJj+N8EDjuj+RW4q/fIgYE3PE?=
 =?us-ascii?Q?N1IFDwrRKjS7ovymlYGJIxIwxi9O0j8xISAR1xZCO3vAFPoqPjSB3cjr0elr?=
 =?us-ascii?Q?NRKdeJehNeTQZwaSde7hk7FaWchL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rlI62BfMj6TjupUgbYTVHdWEtHlgor2lVYABuOxJ8xKF/PKr09KIxtBbqA3J?=
 =?us-ascii?Q?kbKEWgluiSurln4d5F6qNkx81bY8hFQsqGipGNaO28KLvs25cMTdC7APvIte?=
 =?us-ascii?Q?CtbtReaPKJ/+BcUUMpiIUUtk4q6nYRfHKwG1r5z2ftoQ8yi/VmZuHgcIWUIh?=
 =?us-ascii?Q?7BCMBj3nGPlUo6/ccm/XdVvVhytBoTS/LWwGJyVMTUT85+bypJGZWoZbPlUg?=
 =?us-ascii?Q?5MxhK4NrpeQ+y0nSZdCmGCvpkLEXFlXjpXV4CLL/YlBr+NazpWHUnS2tvETD?=
 =?us-ascii?Q?7CBvPqsCIlsjzCskcPao7fOSQPGWVVP1naT5ImD+l64YOcUHSHLJFZ3/62x8?=
 =?us-ascii?Q?IBrrLGDhz469J5XroxOXxIn70ph/8ZKPYAXCxe3fJPaHNvpIPl4vnTF3+CEH?=
 =?us-ascii?Q?6QUc+aeEoJ5UqQfO6fE6eQTbztMs6ccaPKfR6WhZyALHjfrB1eeaCPrwfZXF?=
 =?us-ascii?Q?lweHZbN2wKcGh2NROsV4SBtOptcsunXOvTYVt7hSn0wQv8k0VwMEozLJkB+a?=
 =?us-ascii?Q?PFmhAErwPrdSHtZ/+CUWSFG0Z+7/gIQgFFAnBMfMXUSFlkQLszJnze+obsZj?=
 =?us-ascii?Q?5lNvFblGv3d82lf4XmGVc0x9pplUnI+M8R/Gn6qVz5xoyLsOxCuSiWELqaCZ?=
 =?us-ascii?Q?ZDOm2VRIS/jxqijwxftNiMZzD6MHMGLinyTPrfFudJMGRdECfQ5NHF+R0QhZ?=
 =?us-ascii?Q?nJHa1/qvKlE2RWtGfIass5jlcTM6wNl7vRxYsJKANgpga/dzkcnl5AEoav3c?=
 =?us-ascii?Q?0DtxJf7sWszmrgGxx6Eashh6twjHLlBp1CCI65OSLXLArLalpj2D/PtKgFha?=
 =?us-ascii?Q?33KrW89K4hTZvttSP+IfnRlaIm0MQLqyeKOKG9zIw34nosXxJxqhr1oaIvJV?=
 =?us-ascii?Q?ND95SlPFaDtbSujnHRAuNzNPdMIxl0zKXW3/VCMJh7uAaeldnqRHsOb0QEA6?=
 =?us-ascii?Q?2Iwmn7LJRzsPExjsm40VNEkaixMLkQU2MwdeoA3SWlxDhZfDVVXuMxbgK8Vr?=
 =?us-ascii?Q?o7sNciBagTeCo7lGpPSTindJFT4UuIMabZJwsA8uPf4t5OLPkDEmyYnEBU5Q?=
 =?us-ascii?Q?H7GpQMheOXZz1BLR1nRuuw3Ewd1x8r5KZDwfCZcFAToaS3yNrtgIg9e3C4uq?=
 =?us-ascii?Q?0b/jgSII3bnyIx/p2RQVq/zDc9BIV8awnsQUZbkouI76ODjSz5m4t65+j3Wy?=
 =?us-ascii?Q?JAekZDZU8A9KnBOro8HK1Oj2qioBbs+V1lGbpHO91bdJrL3g9oFGVwe8RgaJ?=
 =?us-ascii?Q?wFqkRfT34FNACNrkiIR4zo6CE3mt2buRU3BI3yBJO2V88L9eFXj/iz6RFq/Y?=
 =?us-ascii?Q?kvmfOpMmds69pzG/l6B1idxMj0CEZrsXdIJv27K4wYmmHanAy7SlCVvnlhen?=
 =?us-ascii?Q?eVbUt9eGlh1GaNEIEAqcfSR0NGRpdxlDO54MuHYQketJqqZguiDgO+gj1L3v?=
 =?us-ascii?Q?kdm0Odva0YsWIFlby6eNlTdIcGFAoDTj9fV45z4q5GwJkOexs5LJMDqh4SL+?=
 =?us-ascii?Q?+n/xB0h23E6elYSVLfAkPnP33nLIhY0W1NlQgsjmTiLzoa+7yAZuYpCBTqQd?=
 =?us-ascii?Q?72hIj1o150OppcXWo+8XIF1buhK1E89edpECwKDH/I0hTQAQQVAvTJESdc5v?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xVmBxTDqmD/tx/I5VlIcCRXEesmGXkqJ6yolV5bSHkizy6C3kTdjYhOcOSJsAreNKVOofcOlNqqkgR8i8k/tzNDkiyZ88U9QjCAMSCWBle79R/gHh3O+iI6twrp8KLcFr3XFtZQ/iMCjHaqbdLN9ydr7Aw91AqsVtbf0UlLwJBV/sMXDZbjxzf3Pfz3m5RqEvBBeWCYnns+Ivr9eHJri6R0hdTEoCKrH7Vfee0Ynjr2dqRfQ0Jn+dvpk3d+Bi5dBWbDZy15XhfbxY5dBJ3k6i665qX9Y6cLSDublDQrR/uR5YABoFs0YZoXC+CoeO2tBJqaL0z3bJK+X1auygcZnitEvOADhXBTKQrGuYD97rETT/BPhSr1EWGCr7vXrTQ6D0hCLhWp+NZfbH4QOSRfUo2t927HM7075/8DVdhyZP/1UrTJxAysvEkjUm4K1q6M9RLiP3GhjbXmVRV2fcChihKAUI3BkYMoCo/+Pmzr5lXRp8cbIwHB6AtMD1fm08GDlhOmCBM+qzj6U7WJekaPSiHO71L301411jkVFyIIPV7j0HjgxLdURn2qlysqFNQrWk0zgxdIvrdq3v80a5Bi8VmJzH3UsaxE6sSqscAHeHOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228b8a76-7106-47a5-8cce-08dd56904081
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 18:06:11.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ywbs7kMLKzS33/VTMERVQfMpobiPF9OM6y73mrclgqmk2vqep/v30CmqYIe5AE31UBV3DCMMsUaeQ6IsLMj5BLWzZrLcDEL5bwPdEY9abVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260142
X-Proofpoint-GUID: gLntwTq6kdI033tYR7l2DZ4kHDs4f8UZ
X-Proofpoint-ORIG-GUID: gLntwTq6kdI033tYR7l2DZ4kHDs4f8UZ

On Wed, Feb 26, 2025 at 07:01:36PM +0100, Oleg Nesterov wrote:
> On 02/26, Lorenzo Stoakes wrote:
> >
> > On Wed, Feb 26, 2025 at 05:26:04PM +0100, Oleg Nesterov wrote:
> > > On 02/24, jeffxu@chromium.org wrote:
> > > >
> > > > Unlike other system mappings, the uprobe mapping is not
> > > > established during program startup. However, its lifetime is the same
> > > > as the process's lifetime. It could be sealed from creation.
> > >
> > > Agreed, VM_SEALED should be always for the "[uprobes]" vma, regardless
> > > of config options.
> >
> > If you think this ought to be the case generally, then perhaps we should
> > drop this patch from the commit and just do this separately as a
> > permanent-on thing, if you are sure this is fine + want it?
>
> See below...
>
> > An aside - we _definitely_ cannot allow this -system mapping stuff- to be
> > enabled without a config option,
>
> This is clear.
>
> But as for uprobes in particular I do think that VM_SEALED is always fine.
>
> Do we really want it? I dunno. If a task unmaps its "[uprobes]" vma it
> will crash when it hits the uprobes bp next time. Unless the probed insn
> can be emulated and it is not ret-probe. Do we really care? Again, I don't
> know.
>
> Should this change come as a separate patch? I don't understand why it should
> but I am fine either way.
>
> In short. please do what you think is right,  VM_SEALED can't hurt uprobes ;)
>
> > > 	#ifdef CONFIG_64BIT
> > > 	/* VM is sealed, in vm_flags */
> > > 	#define VM_SEALED	_BITUL(63)
> > > +	#else
> > > +	#define VM_SEALED	0
> > > 	#endif
> >
> > This has been raised a few times. Jeff objects to this
>
> OK,
>
> > > and then simply
> > >
> > > 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > > -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> > > +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED,
> > >
> > > ?
> >
> > Nah you'd have to do:
> >
> >
> > > 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > 				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO
> > #ifdef CONFIG_64BIT
> > 				VM_SEALED
> > #endif
> > 				,
>
> Why??? With the proposed change above VM_SEALED == 0 if !CONFIG_64BIT.
>

Like I said, Jeff opposes the change. I disagree with him, and agree with you,
because this is very silly.

But I don't want to hold up this series with that discussion (this is for his
sake...)

> Oleg.
>

Jeff - perhaps drop this and let's return to it in a follow up so this series
isn't held up?

Thanks.
