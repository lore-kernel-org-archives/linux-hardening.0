Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E819E7D1;
	Fri, 17 Jan 2025 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151770; cv=fail; b=Et2i4gTH9gUHDGl+tOFnvoFcyog3or7NNdVrdffrOBA04aEuVnj7TShNOZibp9PExbr38U5t4Rd7Z4R7ZYU2HpBfZRWdtCQ+vNEYZPQN/LcLJUWhCDJkEsdE/yHSwYoXCBBJi4oXTsVEO8wO64ZhrxZmqxKGNfDZ7QHXDTa7+wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151770; c=relaxed/simple;
	bh=f5vaVeaR+cXP8zWyLP6oTpxZRY9SI3DBKph6nMwYoSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kurmt+87FC8Qx8TtL9hWYAEAh2W/DkFXr8ojufXWRdTDimzrJD0cRG1RTKyKhFUNpNjd+s5dFPbtTnNaAYlwAv89XlgviHkZoIpztivqmZH1Qcd3VzJ0n39Ao/HamafU8Th3VfpeuFAUrgIQIofbFdRs9gjwjyRfbTOCwIFkOHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G5kli8Za; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OO88sswu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G5kli8Za";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OO88sswu"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HKg8NM022007;
	Fri, 17 Jan 2025 22:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=j4fNYdWQbkEFDyu0BP
	tv/qihyqVxwLNsXAyi5Y+BmNQ=; b=G5kli8ZagrCVIf1Hec62/SWmJ4xLhPxOHU
	BQJAKNYqBNxncv8odwMWeRtWP5nwvadWkxzaEolmkz3zQfuCFKk7sv2/uIY0y/qS
	ix3Se+bK4pZLYCQLoNRkYgJomKR6u8D9LhZ4Dyi8JJ0buZ7A0iNOaVNeL79a5PZJ
	pzkMdtuF03Zegt0ahyaC89h9mWzb6esEAVIcJaN+FNIkZFOPr/WwIEF52cD43CRa
	Rr0mVGyuDBoiaZl6lFrwgAw5/eGgRnsz13CbfftwzJdCwTGwcd6rNgCu3QXPYpDW
	LH/SFvxAiahKsbly5mvREA4fPU+priKO4uW756b+g9UdhNYBfzFQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4475mfjxk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 22:08:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50HLqB7j039281;
	Fri, 17 Jan 2025 22:08:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3cngxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 22:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ4HXVMAJseEOdLPJ69t1L7XG1RAGQCFJkUD7rAIe9wskuDZ8+/G2TUtJh24XING97rpkXKY5ItVNKvmvnEx3CsB36LpPo14YOLAKZ/amY8MOKYjI2JmOKAg5Pv6sPomPmpHfyuqQHjXxhaWIGDUzUCqxVJVwttwdXn648ORMrkPdag2kB3dUcjE03Ody7qnnC/4J9VuH5ewmA4Jda8E7P69ZGNKrLlMQjPEu2Dby1VDChmseKRMhF1UQbYOdElqNoq+imYgN0WLgHKy2K3h026ePUIzSWeq8z5+4LpBcYOesLXrPF9KTuLNOPS+E1PfyeHPFn9/6FJj96wlQ4Rjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4fNYdWQbkEFDyu0BPtv/qihyqVxwLNsXAyi5Y+BmNQ=;
 b=c6hdZ+FVcC/MioweSrsSR9Gxe2UVHaFjXpheyuLsLszwuVfJv5uN3n2ybMcpljhxzwClcj4iv+qCpHiwOlld6lNe/R1sq/gSkYhXN9jaDSBFNTEedj1Ee1GePrEfoO5DXoHJVp4DptWrJCN8VLWK0chEXDcfL6lp3Gn5ioSwcArm1EjMeusRQzaqGL0oQYPAwgSF7kehnpmEbuWnpxKZgjdoLEezu4Q7EArjng0kJF8DAP5pumxg5bAKrltrNpMmT4y7qHXh7ZWYcrnyWqXGEMsAg2AXaSLahFBevrfnxqcofwqCvCA1N62tnbQMCpR+h1gT9HyNx5+zkDhQVka++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4fNYdWQbkEFDyu0BPtv/qihyqVxwLNsXAyi5Y+BmNQ=;
 b=OO88sswuScFyWp//k9cUmi6E+5y5OI5DQzPKeb/FogFAIjmusQKeIyYxbY4GN3uCLuDTGKsalwm+Poniw/3kSCZr6Lk5J8V8dOhLjnoZwBoUzsWs/i6mMkIMXIYGAVMw1N1drhxOX2NJOa7rfGXHX7BS1pq+nw4XqnlbFV1qB5o=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB7199.namprd10.prod.outlook.com (2603:10b6:208:3f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 22:08:30 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 22:08:29 +0000
Date: Fri, 17 Jan 2025 17:08:23 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: enh <enh@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Kees Cook <kees@kernel.org>, akpm@linux-foundation.org,
        jannh@google.com, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
        mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
        deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
        peterz@infradead.org, ardb@google.com, rientjes@google.com,
        groeck@chromium.org, mpe@ellerman.id.au,
        Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <ocstrhpyoyxzurvvxbrbnlzfqzo6hiqt7dxj7vu45ipj4min6z@ffnpao72slda>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	enh <enh@google.com>, Jeff Xu <jeffxu@chromium.org>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Benjamin Berg <benjamin@sipsolutions.net>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org, 
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, 
	davem@davemloft.net, hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
References: <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local>
 <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::25) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: ce76a319-851c-45a3-62bb-08dd37437978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XCU4EnFqIPq/aQYXOrnYcS4lVfjoCqTRNaQBDQV9y+GeesObE0zq2wqgCK+Z?=
 =?us-ascii?Q?igb6VM2doTGi9FSnsXQtwZ6ByDRUO2/Po/yGH8nGidzm5MntwuoPCd3eZvWW?=
 =?us-ascii?Q?Of9f/jXQmHU9EEbo4ziChVDH6QPWZfs64UDRXhygNoUsSM/HJKlBdEx3z2W6?=
 =?us-ascii?Q?kLb0bROGdw6tP28e8qUEJNY7xGzg4KU9zhFK1yDvnSJHRaxcvN1ZidGhJVLe?=
 =?us-ascii?Q?rov85Q2l9U2nB4MHU7pUdnCaN3toK84PmGU1hGKZlLV3uuIEnAE8feI3wfRU?=
 =?us-ascii?Q?zSYXYJ8ETls3X/LU0MdpyPxX8om8H9HgEPJTM3epynN0Fb9d/UAvvFRLrj6o?=
 =?us-ascii?Q?uf6Q+IWRREUTAYqsu73M5ffCTlQsh+v3Bo07jfm4qvhXB2cPb+mVv6HvcMjl?=
 =?us-ascii?Q?yvnTglFcSl2dj14F0hPD0O0h8YGiiUSvDjPtmTxNffMhQwrvGF1T834ENa7w?=
 =?us-ascii?Q?3+IgrJsphhF77ANaDk/wF8B0OfKcZNWZN6KE3WNbk/Nx22Gwehb+8CXi4tkL?=
 =?us-ascii?Q?gmv8R5kbLqdbbQmISpQqgeN/KtVaxEX+wxddgZrG6DNZ8DZv/urZQLfrrBzv?=
 =?us-ascii?Q?5+B8FLr6D9sTfryae0FeQworSfi+Svj0v8DAZLE/JAc8c5Cw03RK4ZxzB9q0?=
 =?us-ascii?Q?Jknvjt7J1w4kIEHxco1BoV4pTRbJ56uxp/OuHaNyQunqQtiQ3yipVzr3QJtI?=
 =?us-ascii?Q?VAc96Y8HOD6ZYlqSll767ZXBE6+sbk6E55mHfrOnzfp6v3yhzdSo3S4vPuDG?=
 =?us-ascii?Q?PAdHePONmPAuNcYWMBycWlzAlkGuKYqFy77jfOvJDJ9QoWNp+lkLcp9FFQui?=
 =?us-ascii?Q?NUJgyQ9CwYNsDocL/LPZq2THezVO9Mjq3P7j4OiO9qxnTVQen6d8rvVRbFJ6?=
 =?us-ascii?Q?LvNyuw56b05f9KiCIXRSmnGEuwwOrw/AlpbFMc6Xqlbel3MRJlTmphLmiLRk?=
 =?us-ascii?Q?1MjblIRDjVCUQW+oJYM4Du0aSKkRgWgWla+GzA/VlufMo1JuY0apIQVhqsyq?=
 =?us-ascii?Q?Wio+jmJqEdt4rj8MriC5Zj+NiZuDZpXPG9Si+IVfj+SDYW5C8vHiRjSK9Ajm?=
 =?us-ascii?Q?Ln16qU9TMJ0FBJW4xWFmhcNeDK5JZLavgs6eReKVCZzjlLrAQiq4Xj5Shj6w?=
 =?us-ascii?Q?bKNB3vhfXAMYQ+sPIdseHjEZRMJZuh+6kjFcVVnLMR2b2fRg4L/KXoT3rKLo?=
 =?us-ascii?Q?+a7YMwXxL/d7OgHfvpuixqdVyPYmyQXO/A0rgkRp+jmqdgFG1/p+TcbnkYF0?=
 =?us-ascii?Q?uUu9jcSm/WWhphMGM0Pkt1Xe0KsXoiR7ywsez73lrgOsssarAz/VEItgpXlN?=
 =?us-ascii?Q?I6T9ldtUJ5zudL62qShSCk6NfjAvYuIBq7odMiUb6pzrnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mb9ymZqRBdIboxdntb2M/yNlOtq/fnq5lEWVgY2p1Jpz/gypO39NkKkFRkuD?=
 =?us-ascii?Q?2xY7wAbAV/254PXS0c2jg2v9K7Fxslb0FO8DiJOPxuH0w7qKJv6R/QG9RKvS?=
 =?us-ascii?Q?zJdEYUVmx4JBHAFBTrcpd91kM3zVbxXAnZDbUg3isp6ahfIszkaX3cOgm6zG?=
 =?us-ascii?Q?DbqP1w0Rz9uBaUZKolUGq/9+/CQv1kC5Juu0aPqKYSHRX0xu9aef8EBAEowS?=
 =?us-ascii?Q?+Il4xAX+rYgr5btUXFIspitfF6Ii5vxk7lbh+dg501Acd2BOLArlow/6PNVX?=
 =?us-ascii?Q?p8TelIaLE29lEQFoMNzRAOcktNehsLTZXyjnsLHUrh7F6qHUtpDs8D/WWZTN?=
 =?us-ascii?Q?Oc5BroR2rcjygs382O2RZFHfLFvRRxfXCmWVAKQmByc4kirvFfJg4D7DSWgV?=
 =?us-ascii?Q?N2Vg4Jc/e4ki6stpQN5xJWTgzCU6YPibK5gGRd3wyJYw11kn7WQp1B/OC8/v?=
 =?us-ascii?Q?5poXoowGb/G6goMU5m1xYqq9D2WaAliVa6fmbPYHuxiDyk5FJ0Lb8Psv4TEg?=
 =?us-ascii?Q?R16asJ8gkIuze56TtSykIFzwg2kaHgiQDCh/34K0aP0LuuuIpHU1AW0mR4zM?=
 =?us-ascii?Q?SwSfhCa8gi6y2/Nuf2FR3RSO+2CAzdhzYnwgdcJaEnT05X/vaeC8st+zYmjX?=
 =?us-ascii?Q?CCTfWJAFcVylB69HGVZKUO7LeXoQJz9CAT8fdoFg6A3GcZRD1VP6d+5eXyAo?=
 =?us-ascii?Q?v3e82+qfWVwDBqkO3bKsCatkxrJIc0vxt8RRjU7Wv4q944QExIgU45QMkbD5?=
 =?us-ascii?Q?zdkEJl57BpwdR9AHr7XdWBKP0SxySvuPRms/AE3cGcO3WRYULx9CxC3VQUNN?=
 =?us-ascii?Q?uA1iv7YawwOYPAYvG4GE87AdyWxCNq2QGH4wD9FVmQUo741JvpBHV2XCajX7?=
 =?us-ascii?Q?UmK7kyJg+3EvomS8SD3FWwEHcl6XhyPZqTsvK9bpSfJD7wZhIKvQvSIaALVA?=
 =?us-ascii?Q?g31rwdQ58NNujTGkYyDx3KbLZPswMSpudQf5NtD5sL566G/l+rc69HEQSgVw?=
 =?us-ascii?Q?bCfdUlMlCvpspg9SKDmc9h100ut2ULS9x/hMP+gQCgqQFCyVM1TfSu6Gce/k?=
 =?us-ascii?Q?Cl1PvwBlTTrUCEMP6zNre92AWNb4JWjp5jCw9uU3sUp5eOTT1PVeLLk74Dli?=
 =?us-ascii?Q?YEl6k8NiNCqJe2lgnjNW3Zinud2Y9k+ayfcAYAb54SNRjx3sbGYngEfd5BdA?=
 =?us-ascii?Q?PzQmi/cjrhLBUjzjZqJQ/OzFZvlkMYfxZEsQTvgQtPwMY/UoOaHISM9Eeo+R?=
 =?us-ascii?Q?foUXiM65lvIEpkLRRy7becA9N9NzQr+ZSi7F10aAEY7YpzGmD5jFMGh4NjF7?=
 =?us-ascii?Q?l0dN1CkQfYQtID40lgGXUjySsM7p2J2WsVc03SYQIZH8TVPaQ9072+FbXH4I?=
 =?us-ascii?Q?BceNUZbcBlRgCjZk32H0JcoW+kDdo5s7BSt3ObNYPnePfvcLGPnTPErgyx3R?=
 =?us-ascii?Q?McOuHxMAFNaWNtrDprN/gTV9mb59gAMpPuMwmL0glGOhWejSvtuhGS0OfyfP?=
 =?us-ascii?Q?2gWE/TK08a9vxYbQ9dITviGzkeJe4TQMKBOc/TOhsmDSGGhNjnkGEt/a0aK9?=
 =?us-ascii?Q?t2KRWSGLIciwqcoijrzRSu+jMl8RxBiiNXP/fcDD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WDJUy77CZRNB1VoST9dxPSGBXq19t5pzTUAm/FfoOLwkeGNqaW+KpY1iR9AtAm/HcyaiGhg7nFFbq9+2Pw2axVS6hiRf3aTvya2SJWCuTVAFurtJ6Xpm5K92fNmBttW09Bt6yDCGPq7yMOyY2qV5qtoY3LiW6kiMRrrMOIs4N2cCETSiMHdV5rETwjB7OtfVeyfbhS6t4DsNp4F27cGeUt7EQxKsxDpG5qVjMicuqFHknPYTzEMo/uT2F7ffSwKUTBWJboKSLgK4U30a0ADD2R9sCV9Zre/CZZye5LXhblApxMQFLYxfZCwY79i6h1HTqvOyHuKrYXaqIIRIsA32SYiyVtZh35bbxuubNAsrBudbW7VsxkzPYuyMmWD97UQIrLYHd3PK3Wsvx/EgscfOEGturXz7DlbOZLTCsgYlzbfJVAA70KBxOZLkaTQSiSARTXS/CvkIbPemyteSzFelrCt1mxaAaSAfb7LAfl9gf3Y0hD4aqt9xvuc0EG5lSIiH/d3LamuZgcd8MMBzSj08W+CWkDmms7QsK73GBzavdL+RbgjZh8RPj7bjOF7QJAMLIbbjIM+47bgULzwi7cYyQq4FrlUJMxjRe4A4frzyvoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce76a319-851c-45a3-62bb-08dd37437978
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 22:08:29.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQV1jbr0TpQy2HeHbXKCNQU29QKm167yi+hjFAa5j2zwi/3EjlwrHIHuYkYJeB/DaxpFt1BdyWV5/SRs1F0ARw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_07,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=989 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501170171
X-Proofpoint-GUID: thMuDhEufLhZ1-HdhOBBAcn85FqzLwhJ
X-Proofpoint-ORIG-GUID: thMuDhEufLhZ1-HdhOBBAcn85FqzLwhJ

* enh <enh@google.com> [250117 14:35]:
...

> 
> as a maintainer of a different linux libc, i've long wanted a "tell me
> everything there is to know about this vma" syscall rather than having
> to parse /proc/maps...
> 

You mean an ioctl()-based API to query VMAs from /proc/<pid>/maps?

Andrii had something like that [1], check out ed5d583a88a92 ("fs/procfs:
implement efficient VMA querying API for /proc/<pid>/maps")

Regards,
Liam

[1]. https://lore.kernel.org/linux-mm/20240627170900.1672542-1-andrii@kernel.org/
