Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4826981E;
	Tue, 25 Feb 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490939; cv=fail; b=nZFgQvItu6dTmGfNtuodPj2Z2I5D+5+zoy1yxcPNoAzeKEZ9z1QE4rK6Ce0alFHV+Gl57yDYZSAPI9bbsXxvGZZ7nLpPKEcM6lLeXQQGEEwQJRTI2t4Z94cC0+u2TqMvbHtEBxFoU1CHhREBiFdvA6Vj7QgKz4sQcbezo8fg4BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490939; c=relaxed/simple;
	bh=VjCn9b7WkCoZXlGUQpXW2S+765tU0Jv7YKrkL4g2nD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OETAnQhMkvZJUkn0gkFFySfFmKSK92O+xE3DkcD9dt+0nMUgxRTIzANAGmAqdM+mJJI2CroRHCw4BH6Ca0NgfT3gcXQgMG8eKzq+TvY61b6tcqCMEjiNvpCaxyu/swI9fjsSkuPU4U3/4W4Cwlx6orMb2SANqlKs2BK13cWMI8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D7JrjGOk; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xE6M3rdd reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D7JrjGOk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xE6M3rdd"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PCfdwM012266;
	Tue, 25 Feb 2025 13:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HLgqxOrENauL6tcZlFWjUz7z+IFrvYQHj6jN6QeVfw8=; b=
	D7JrjGOk1wuCaUp08qHEDyYsKk2ldL6JgZ4gPl2dgBV86F60wPN1ga+NrK25Yi+i
	0Qty4mtGc7SRzZ9zJq9XHVg5WWW1zsqKgsU4vSFvrE8OTn3FJSA5Vz8qpQE6Gz9j
	QnHEeGyna2j8ZhHPrexZ9qiw5U3JknPOEmk1cqilMkGqydLWqfFOjAwJFi0kouNt
	AF1v+xGMGA3eZljc9ngKnzGnuEjNQaLkWfIFgR5I7p1rrADQxB8PiDHNOSg5jRyP
	tR2s/Do6loCK4rmsS6V57h55FBWAtm1v7TnNyFQ1wEmIX9ZnluGR3CC77CECCLi0
	qhcdATX0HALQifY9J0K2KA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gan7ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:41:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PCxPsQ024384;
	Tue, 25 Feb 2025 13:41:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y5196x61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLUwX70fV7ca66+akWoqw5QF2vQM2FxjnI+wETWgmsQOHlvodb7pw3ahkqcRBvsgmar/NtNaIXvF+xA9A5A1y9t0PN/y7qmC1jkpSrKyHqLw+hBhf/FZ32xpK+lcpfOyrVreibjIkPR4rlMqQ7SonvnzA5mbB6WBzCjZoBWfFj7CC+6ivW1DGYKuO9bA72/CNKD/ME7nC1G7S7iCjoFz7t7PqQ2ZCUKWLFOKsF/zsreWAtexg5L/QFxDUEaeDRIZu+LZI9MxJWjUq47jfyGGe5Bb96tSMTZcbZ2la1MUMB8DZKHbMNaecXMdtvtgccNXVkH0pfGAIYM55vX3Mo1/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQfBlC6l0yQ6qYwzX9iPYhFYMnP8XRn5rFXsWjonKPQ=;
 b=y7ME+VTdrA68S4Y8EgqOTE9yFCxy5FJoDixNIAiKNGMP/jcpcSjgdJmf9KGNi7F27e3qYPKy3/LhYtlgLvmTVlFkGK6jN6uzX/VA9olIfsiArT1uaAzAb/bOXrscTIIyPwpeGbKLdYN0o4jzGeIWGFKz2Iw6UbR+H6RJoTjBpX2UkVQafg22Bk/BZ2sCXR2bXUZWlNAdPcKNtqpeGL/PShB95/GA162unx//iC3IGAAn6Gc1D85dmqMg/JhJR1H4aNYJX9pf1TIcAUtP8MP1A3qldvgicqA+baLruKmksPSRUpRuHpJr4igyD1FnzH1vZOlqDTHpV4CsfUuz9Or8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQfBlC6l0yQ6qYwzX9iPYhFYMnP8XRn5rFXsWjonKPQ=;
 b=xE6M3rddXmie2hvis0+YbsaTGYT47rBMFhjvFxCvOpRPGzOZRb/wUCELSQfcwVsdwSn2WNtuZFX7caszBcG3aBjStpPzQpf/uheM3+65Kh9SAp1ea9AqQavacehR2uu9I2k3eWOEFG3H9mz+Q81x4aIQHeAW3jD6Cvk35PEmidM=
Received: from BN8PR10MB4099.namprd10.prod.outlook.com (2603:10b6:408:b7::32)
 by CH3PR10MB8213.namprd10.prod.outlook.com (2603:10b6:610:1f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 13:41:28 +0000
Received: from BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d]) by BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 13:41:28 +0000
Date: Tue, 25 Feb 2025 13:41:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: "jeffxu@chromium.org" <jeffxu@chromium.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>, "gerg@kernel.org" <gerg@kernel.org>,
        "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>, "enh@google.com" <enh@google.com>,
        "thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>,
        "hch@lst.de" <hch@lst.de>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sroettger@google.com" <sroettger@google.com>,
        "ardb@google.com" <ardb@google.com>,
        "jorgelo@chromium.org" <jorgelo@chromium.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "mike.rapoport@gmail.com" <mike.rapoport@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aleksandr.mikhalitsyn@canonical.com" <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
Message-ID: <19e81e87-7430-4e23-ac67-dbb987496dd4@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-6-jeffxu@google.com>
 <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local>
 <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
 <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local>
 <7e91bea34552472757a8eec425d1d10643ca584b.camel@sipsolutions.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e91bea34552472757a8eec425d1d10643ca584b.camel@sipsolutions.net>
X-ClientProxiedBy: LO6P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::14) To BN8PR10MB4099.namprd10.prod.outlook.com
 (2603:10b6:408:b7::32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB4099:EE_|CH3PR10MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2e7a19-7396-4baa-7d72-08dd55a21aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?TxWdfM8mj2+gynO7GLzvefRbBdBeqGXdIvgLSZawLwF3LSmOk7Op1vEXcO?=
 =?iso-8859-1?Q?aoBJBRgNVF8h5r5BUtDHbfRRmic/LsybnnZzo8R91sMlQ2YFYYaLV/fGl1?=
 =?iso-8859-1?Q?urjoEoHZ8XCxfaRVBrn5P6cmeZjhBIGk2++EXsx4CGugG7NOHvZJ+ypJ2k?=
 =?iso-8859-1?Q?jcb76k0tuns0fYqQ/cm2LH3cxEd5tmKAtlleEmrTUCSnAaY9dXU4XjUApg?=
 =?iso-8859-1?Q?su3lzisqz5wUojnJGgL4lZRJReBxYoJhSy3mcY3rukLVbjMrFZVn9k/ZzD?=
 =?iso-8859-1?Q?AfqSvVDXS8gAVQLGxexDNEQZ4x6mkCJ5kk4QKDybenCDwt9Z1L7QmwDVh2?=
 =?iso-8859-1?Q?J5b7uW0SiNtB4akYe23ft6F1fB9ayxx6TRTEXp9X0Y2c0EcScgTrfUYdT9?=
 =?iso-8859-1?Q?Qc/pzmwtBnPgnCNcG/I13MpbdDUEUhwruSHye3AHeLzWDtbg9yx3m3315U?=
 =?iso-8859-1?Q?PLJBWq5gjAiQHOZ+8/CMhfYJ8ll0nRPuOQ6uv5KQVp6m8CQ0Y2Eb6lP4Uf?=
 =?iso-8859-1?Q?an+yHh8uUK37cf1zgpVdMxcwNIpJltCQziCBITGsyfeysYNYQLGAzZ55O9?=
 =?iso-8859-1?Q?6TC13ghM6/3Dh2WIudDcSB5LKAPV1EmsgFG1s1SWVIW5fiXi7PVcg20xax?=
 =?iso-8859-1?Q?/bShSG98/2ru1pPxBcDLUrh0medMFHXoW6eeSl5yvcpAV0J4GOpIhh73iv?=
 =?iso-8859-1?Q?jqwSBlHMzEqlVzQ1QI/PL8uUaqkAzI160Fo+WwnC/mvvXZsr+V9mx52noM?=
 =?iso-8859-1?Q?xgcdDsJFOSHnMB6JFXSRbLtiXD1o0xugLXgm0Gnea35mYt0uHi8FJwXHNo?=
 =?iso-8859-1?Q?ebL+58ZsUoOpBok9/yO+Kl/dyq2BOw5dDsQPslZSJomqJqE2IazAKpAvVr?=
 =?iso-8859-1?Q?sah+lui/yObz5xUnwR3IyCKCMjTNVS5/sXlRrlLPCva09lrA7U8pymZ/lO?=
 =?iso-8859-1?Q?Rljml4ZxetObPVazygisaYwe7SdXFFJcg86Nq9HhCkEvLkjubpLECXCEod?=
 =?iso-8859-1?Q?1oyiayVlO3/kBVSHJUB2/+zpUBng43sSzKj7fZGc/Edo968f6gPoHXiI4m?=
 =?iso-8859-1?Q?2wR7gGmugRldqn5NXCkw8d/kL8qpFSmpx6MdwLXGvATTgCIx3zvHPwkU39?=
 =?iso-8859-1?Q?cG8sSp1DtbJ7nxzehO7ce0mY+skR4FAkCZx+87YVIsKucLbpz4cC++8hrv?=
 =?iso-8859-1?Q?rpje2aQXljfuDe1YqHNXOL2JymHNzmspZ0H6OXOdIcGgcDW5rTbPuuDmTp?=
 =?iso-8859-1?Q?iqH/BEXHZ6VtjM/D9Osviq9imeGHynUnwGDKjQc+IkDb95Vs39vK9iMNnJ?=
 =?iso-8859-1?Q?20A6qOoEQDt8mNNPQ3dI/WdSoglZKbTvaxiGKwsrVRHkdMukWZo5bSAA3v?=
 =?iso-8859-1?Q?qesRi2yxWP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB4099.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?/TCoXufoiNKLmVuGjugZkhhJCedECj2qTR1n4qL+ilxSpldbGThwjCJQXO?=
 =?iso-8859-1?Q?PVzIpfJYm6H1KeNk929omtfQ8WY0CmLoIiXfaWMmnct5kwq6iCCP3QYIMS?=
 =?iso-8859-1?Q?WncmuBZrJ1cDZGBEoKLgmbawFl4XhmwS28tG1pGIxWq5sxhDL/LK9ueTwL?=
 =?iso-8859-1?Q?vqTWkd9QIQCzvcM8XM0gnq3e7I9Tv5Vi5wIGWVylQorSZ7nnt7i1HRBRYd?=
 =?iso-8859-1?Q?7/Y/fB9XXvkFPVyMi3NmcIH0Po04b5cnXnbVwD5owqnsQcoAXaK2ae6yLm?=
 =?iso-8859-1?Q?beSjImtsqYVasaiarMhTmgmzoJYmw+e1SuAxHQsBXEOXIfCg4N+eXNvyvL?=
 =?iso-8859-1?Q?rrkvaaDLipXSFMDguS5QrXXSdWKmoYosyW33h2jZGaNAlWTzzljhtuVRlQ?=
 =?iso-8859-1?Q?MG9jhAvMMEPU9y7U65fh3dgi/4p6czQuBAhM9HFV5eWuN7ZPW5b2ZJcaRi?=
 =?iso-8859-1?Q?6HIay2GIGoa1K4UN34WVoNw0AAQeQJJ2E5lr7cptdcBdtVdPcBvBbmuIIZ?=
 =?iso-8859-1?Q?WRU9CNCzVnVdgQ0eM7IygxfPoVj4gXMec1Gkda06vbfB5CoZj7uO2fgx36?=
 =?iso-8859-1?Q?JvcT04EWAiYD+CYglIHsRkpe1Pkc/D+EKu6AuRPFzMB9Y+5jsY535kudnP?=
 =?iso-8859-1?Q?W6ZR9sl6LaeEMPiS79weK+8f/NE8z8YeaMZYx+bsTjlc6/NUc2F/jxcyBn?=
 =?iso-8859-1?Q?NHNN7TEiQvzInrq72lnkwRtc/wG4jwl3+DOizBwje0RjCSeRTujfSvw7nH?=
 =?iso-8859-1?Q?ONSAWSYC77OXVQp46aO20AVAwpDzz/hPHWEhe87rhRQoeRnveCnh6DNHmy?=
 =?iso-8859-1?Q?S+h7ozg2GCMdq17NMj9HoDEDAu1p1pS6T7X0WTrCZQETsUDuS911uH39EJ?=
 =?iso-8859-1?Q?CtHRY1SAyB9GIoccE4I0UpVVtuvU2rMi3d5G6/eCYjRUrSTSzK3fMa5NOf?=
 =?iso-8859-1?Q?rzX7+Mbi0ZIJvatiOzvuh+JJ17F0970/TOvKirzgVaFubilvMneeOrT+7S?=
 =?iso-8859-1?Q?8MYrETpTCqlaQsAsFbata2LgfQHbp9ZUfee/zWQPQvs6B4m/sjkScYaEM4?=
 =?iso-8859-1?Q?ttJxl8sBZgBjA+c9rngSu2/q36EuyLoYwIGcC4ok8zmJpKcqO5C9zSnbwb?=
 =?iso-8859-1?Q?bOuoVZYr8DSVyAjZXDxZcF4l8Qkd+/1MfcuKjV2eCL2lKZGXo6Wio315wH?=
 =?iso-8859-1?Q?+n97+lh9im8PxVkJ8W+/Nid1e7Bk3KVA33khi9Y3Mzfcdo7C0qXK/LEUOo?=
 =?iso-8859-1?Q?HTeOXpiqNAkGxrKigEI2S2BFVD1E+K0f/ojENRA0rTRH91umNBKSRWhFPG?=
 =?iso-8859-1?Q?VaSQTHQMOqghGrteW0PRSX4S4sFNCHc4bAC/w6xrBhgf0+QgvpPK4k/NYs?=
 =?iso-8859-1?Q?oIb4eq1MEDrCOUgMjL+HkfZEfB58M8/QPM5ogiB4Gi/2DByiSXh6pU+Kyn?=
 =?iso-8859-1?Q?vkJbXG38AHBcfi1mxT3kijNUfrmpt3SRN/eAmYzLL8YWReBCKKl/PJBV45?=
 =?iso-8859-1?Q?dBgjchWOuifTG+4Bhovv29iVNSuKX4l6ee1v3aeO8gmkaQlwIKwxQcq0nD?=
 =?iso-8859-1?Q?9yUr9nP6Zws9h1ZnfXqUHiX5bXmfGo43gGSFNQQ+3LgT/l+ZQpFQ3It84L?=
 =?iso-8859-1?Q?HydVTs9R4U1O5z1fIMCiQ0vSy3xkYz09DgRhuPm6Iu29nIR+8HQv7IRA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0atScIjO+bTwignb1AyuqrIw4SZU0rdZ4IJ3TxfuTlWPQNMZMQA2UrMaIBG84DjKF3He/d7I+Ehd5rsMcYt02uPO5lZByQOX48nrU8yB9k6RA1yqAOoRy4FGFSwwrgOkdBlFKgNboJjSwPqf26SiqxQnzNeW9nIZm1LPkrHUSzp8Bm1S7MCxCbzL8hdZrL+0y4KyId9BwF/mfY20+Xdh18d4/TfTznyN+gGlBZht/MajN6oyW0s2mwaxtBteuyRI5Nm8ImZH7ofOep28PLnlUzm7JkN3i9510B0kczfj16DE1BjIJgpsQ3BGc+CKGASG0IXR6qsmyG1kDVFLIR2+GvJWb1P4mejZ6ytFUuXTw2GC8byJrHqG5ekuAsPAfpR4iTqSAeJSdJ9sGDJFdt6aE5H0dOmlovkiGZvnUoti5LcsJdNYVGwuCBKzVasnsVjaAiyBU3IZDbXuoFk1ZfZEl0bu0PdQ4jZ0WGgI4P+gsuhU0I8Xpoo9WwyBGemB8EXWLKZvkYb0wt0EW13Ioz+EslYdFYxYeno5HD8scvssOHegKYbZZ5+GKfIc4JRBuGpo789xhi535D2EPuj3wtAw0J3guKxbO+HlP3e3AIbnpqw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2e7a19-7396-4baa-7d72-08dd55a21aee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB4099.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:41:28.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RZWJCpjOecjkar8NQC2/ARdfTrwPCWvlcb60yqYtObpuleBygcxkDGK9HIBjRt+mazkgCImSrW5AkxzRdWq9GxWI/7AJKhDTknvO4roUbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250094
X-Proofpoint-ORIG-GUID: 9u2ozqtGpBoOLNgzWjyOGqiDbXcMcw2f
X-Proofpoint-GUID: 9u2ozqtGpBoOLNgzWjyOGqiDbXcMcw2f

On Tue, Feb 25, 2025 at 01:24:49PM +0100, Benjamin Berg wrote:
> Hi,
>
> On Tue, 2025-02-25 at 10:37 +0000, Lorenzo Stoakes wrote:
> > On Tue, Feb 25, 2025 at 08:45:21AM +0000, Berg, Benjamin wrote:
> > > Hi,
> > >
> > > On Tue, 2025-02-25 at 06:22 +0000, Lorenzo Stoakes wrote:
> > > > On Mon, Feb 24, 2025 at 10:52:44PM +0000, jeffxu@chromium.org wrote:
> > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > >
> > > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
> > > > > the vdso.
> > > > >
> > > > > Testing passes on UML.
> > > >
> > > > Maybe expand on this by stating that it has been confirmed by Benjamin (I
> > > > _believe_) that UML has no need for problematic relocation so this is known to
> > > > be good.
> > >
> > > I may well be misreading this message, but this sounds to me that this
> > > is a misinterpretation. So, just to clarify in case that is needed.
> > >
> > > CONFIG_MSEAL_SYSTEM_MAPPINGS does work fine for the UML kernel.
> > > However, the UML kernel is a normal userspace application itself and
> > > for this application to run, the host kernel must have the feature
> > > disabled.
> > >
> > > So, UML supports the feature. But it still *cannot* run on a host
> > > machine that has the feature enabled.
> >
> > Sigh ok. Apologies if I misunderstood.
> >
> > Is there any point having this for the 'guest' system? I mean security wise are
> > we concerned about sealing of system mappings?
> >
> > I feel like having this here might just add confusion and churn if it's not
> > useful.
> >
> > If this is useless for UML guest, let's just drop this patch.
>
> I figured it is not a lot of churn and there isn't really any cost to
> enabling the feature.
>
> That said, the only possible real-life use case I can see is doing MM
> subsystem testing using UML. We certainly do not need the feature to
> run our UML based wireless stack and driver tests.

OK ack - my concern is users getting confused about this ironic host
vs. client thing, must disable the security feature in the _actual kernel_
to enable it in the client.

I'm not sure this is really worth it?

I mean I agree this isn't a _huge_ amount added here and I don't want to be
difficult - Jeff, Kees are you really keen on having this? Do you have
specific use cases in mind or was this just a 'because we can':>)

I guess if intent is to slowly add architectures, it's not totally insane
since we kinda know this one is ok so if that's what it is, probably won't
oppose it _too_ badly.

>
> Benjamin
>
> >
> > >
> > > Benjamin
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > > Tested-by: Benjamin Berg <benjamin.berg@intel.com>
> > > >
> > > > Anyway I know UML has at any rate been confirmed to be good to go +
> > > > patch looks
> > > > fine, so:
> > > >
> > > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > OK guess drop this tag please until we can figure this out, sorry Jeff.

(to be clear this is just temporary while we establish what's up with this
situation! :>)

> >
> > > >
> > > > > ---
> > > > >  arch/um/Kconfig        | 1 +
> > > > >  arch/x86/um/vdso/vma.c | 6 ++++--
> > > > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > > > > index 18051b1cfce0..eb2d439a5334 100644
> > > > > --- a/arch/um/Kconfig
> > > > > +++ b/arch/um/Kconfig
> > > > > @@ -10,6 +10,7 @@ config UML
> > > > >  	select ARCH_HAS_FORTIFY_SOURCE
> > > > >  	select ARCH_HAS_GCOV_PROFILE_ALL
> > > > >  	select ARCH_HAS_KCOV
> > > > > +	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > > >  	select ARCH_HAS_STRNCPY_FROM_USER
> > > > >  	select ARCH_HAS_STRNLEN_USER
> > > > >  	select HAVE_ARCH_AUDITSYSCALL
> > > > > diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
> > > > > index f238f7b33cdd..fdfba858ffc9 100644
> > > > > --- a/arch/x86/um/vdso/vma.c
> > > > > +++ b/arch/x86/um/vdso/vma.c
> > > > > @@ -54,6 +54,7 @@ int arch_setup_additional_pages(struct
> > > > > linux_binprm *bprm, int uses_interp)
> > > > >  {
> > > > >  	struct vm_area_struct *vma;
> > > > >  	struct mm_struct *mm = current->mm;
> > > > > +	unsigned long vm_flags;
> > > > >  	static struct vm_special_mapping vdso_mapping = {
> > > > >  		.name = "[vdso]",
> > > > >  	};
> > > > > @@ -65,9 +66,10 @@ int arch_setup_additional_pages(struct
> > > > > linux_binprm *bprm, int uses_interp)
> > > > >  		return -EINTR;
> > > > >
> > > > >  	vdso_mapping.pages = vdsop;
> > > > > +	vm_flags =
> > > > > VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> > > > > +	vm_flags |= VM_SEALED_SYSMAP;
> > > > >  	vma = _install_special_mapping(mm, um_vdso_addr,
> > > > > PAGE_SIZE,
> > > > > -		VM_READ|VM_EXEC|
> > > > > -		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > > > > +		vm_flags,
> > > > >  		&vdso_mapping);
> > > > >
> > > > >  	mmap_write_unlock(mm);
> > > > > --
> > > > > 2.48.1.658.g4767266eb4-goog
> > > > >
> > >
> > > Intel Deutschland GmbH
> > > Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
> > > Tel: +49 89 99 8853-0, www.intel.de
> > > Managing Directors: Sean Fennelly, Jeffrey Schneiderman, Tiffany Doon Silva
> > > Chairperson of the Supervisory Board: Nicole Lau
> > > Registered Office: Munich
> > > Commercial Register: Amtsgericht Muenchen HRB 186928
>
