Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B11DFDE;
	Tue, 25 Feb 2025 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740463577; cv=fail; b=odbdGubSwOHlINjXe/Ar1jHsd9WW/Hb/ZgW+WDoIMs8+nYmVcdr1bTpwrtuQBNgSvVY+pA3GK/H/eYXeeFvBq5ldF7GZf2svtBXovVttM1Dv1Deu5A11FlYsYCuW8DQzxRPbZ64OljjY+xOoHe5iK+vkHTmQCxFkPPJEMpynmXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740463577; c=relaxed/simple;
	bh=6IrTFOAzIgUSgOTP4+IPqL/H4pvaTebsjmtURLGT0Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mnfh77J36BNwWxX/CGtV02YXr2mkktK59S7WR/2Jgnj8lN3HT5I6h0AjKsgbVI5PFk6XEoJUbOUtWApD83e+oOepXFGJ/lVh+oVgkt6yxX/jfJZMBQszSsCH+n0uNUfUyXJfu6DkJXVKVA2zzq2wMDsLqwcHS/WRdDJwVT9TDHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X/GHF1e7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nrUeleXS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X/GHF1e7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nrUeleXS"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1Bb53010155;
	Tue, 25 Feb 2025 06:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vnyHhUt/CGclaQhGqj
	HC8y4jDl2s9g2GsH08bTk7UWc=; b=X/GHF1e7bMRDo7ExppUEmuyoXD0HJCLo7Z
	lQqVMOD9kRV2Rd72KwsBOfGgVn1/sRpu3Y5iwue90NKOmKrKYGZD5JLmIfDl5vnU
	nVPUAcnsOR6GMetq5fXMva+w9AHji9nP67AnQGHPEkAcxaSZc9xfDPv1WiWM3/5q
	2+RjHdk6EfXkfXNdcTJAvKZ/x1LNTOhSK7ViIQPvf/llKt+6gLAInxeKBSlbgVyX
	qY7//dAsbnEQj9XUW2rkuBqV2KCGyyWVs1gEE5rLSn5re4737bs31JuogtHol7+9
	n6bA2NpkaLwo6A9QazUab0rT17QT2sJwWxi+WoGkrpgJN2wDsH0A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6mbm9r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:05:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P3SqTZ002792;
	Tue, 25 Feb 2025 06:05:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518xud1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg05XCCdbXH9ku0CCVDLyIlLNvR83V8rgTJ1R7vDZCn0CyUfL7cUQkaREuGQj4XA9qWvRsVh/rjwhRKw+N2cYLeXViyBAKJiWPzT+0U+fjPg49SxNRFwTL39/og7bK5nDWe/eRNv9g1HQ6qhlPZgWCghBJcRGertLJ6vTgXsMRInTvJb95OKywX1d0Kbz2wFFmQU+nBpw15zvpqclYvBzddx9ap4Og601QkRhybQGdL1nfm6GL/hDN870EWByQVOD7Qs21Onypr15wQdnIMQ0qBQLJ7vZ3fYmK8sGTPRF5XleyIyOPldqEVeONlZPd6Megbf3PpVKMrKe7RsfrTDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnyHhUt/CGclaQhGqjHC8y4jDl2s9g2GsH08bTk7UWc=;
 b=M+isx7ozd90mpdQs3TfHKUBSfK1MAds5BGyr06i+F67VA6hTFb+JCLU2HytQ5SakSBijql93qQhpj8zrEOASr1xoxpUGRlqBh4nH9rnrJTW38EpZixHLeTIrafkAQKIMTfvp3CnXugpiDNj72w7CblVAfQ9vhG4pdAruPdwsEAPwsMlSgTbuVCiTeY4s4jGnkI+0gUiSn0PtHPwwpgaH3ZnG3I63Vh7jAsBL4l5HJUJRwpLEx7fHf5Kf9QZcKfciWxzkcI9QJsbjAWvFkpikV/mZHQ1mQwOGa4euTuXswcQtZBj3SF8xLvkTzUZsfCUaz9QVZblOVG85yg7Z8oDHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnyHhUt/CGclaQhGqjHC8y4jDl2s9g2GsH08bTk7UWc=;
 b=nrUeleXS2zARdG6xzqN2TCzHL3OFVlH7avf5JP1rTYOB9VmRn1XyGnCyrCQurWEU7XBCR5qxt6Y2D3fNAxNpmwyIpCvGQEKIXIuOouxvlENkRqf6DY/LOadF3dQjGl5Jn5vgveXnIcFsJRbpT3g93DQQNXAuIR3Gol19EF5Tm0I=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB6031.namprd10.prod.outlook.com (2603:10b6:8:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:05:24 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:05:23 +0000
Date: Tue, 25 Feb 2025 06:05:21 +0000
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
Subject: Re: [PATCH v7 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <9abd68d9-3e6d-46a0-b92c-5aee0a90abf3@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-2-jeffxu@google.com>
X-ClientProxiedBy: LO4P265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::9) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 66beb434-db87-48c2-78eb-08dd5562645f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7r2tfVBHaGAM4xmiUzRiGcHwBXS8o94GO0KfTBrNwpz5ShO21iyuToCg1k+3?=
 =?us-ascii?Q?yPTxR0DEpvyzDmUazQoJ6ziy9U1Jis5wIYWve8KhDBIhSaYjGSFpj++ju/Fo?=
 =?us-ascii?Q?7SqxLcDsqdz/19J41e6oW0OghRuVyZbEWARHe1WDBbhviy0EbvNfnuPDTQk8?=
 =?us-ascii?Q?/jGc5jgzMTKf0Lab1sZl4jQNOJtH/7mTZc8vj5gY0arYSCV9EoTgScUX2j/v?=
 =?us-ascii?Q?ySWwlsWhVNchXPgnG2CJBa056QNg9s5TARs6oJHeZlHkMoyyZUh49rtUpHdu?=
 =?us-ascii?Q?usXBI70T8qilBYYh6JFDnC6bL2XQL93lS9JrL09+MtjqHt9/FSAkk0bFQgFL?=
 =?us-ascii?Q?z006ZgrqE00gkoOvwl34U1mJUFTog22mu57bGl8Jb/rNtbnGRPkGg57HomKf?=
 =?us-ascii?Q?ntqmpKJdd+zL1/TJmqVtc3Vt/cLTlfgHTXi5yjwf2+VUi8RKDV14RE6GTrIa?=
 =?us-ascii?Q?LvK0NrhUTiwp87/YA68M04sQGG6pqXyX4dVTu8ROFdbsCJbrGODBwCySzVNU?=
 =?us-ascii?Q?6jQkokvJKss8uVV/OBYlu9tkbKnzsEv7GQvQpKwUXOTpjzVIBrphz5AVB/Qe?=
 =?us-ascii?Q?Rndx0a7NbBFcJbqURe/VNVTvWzs2nqOjU+uivXlXP5cdk4TyqAmrJnDc3UQi?=
 =?us-ascii?Q?JKoLwD9b0gPW8OnObNorWrNJ6sxvhXlllEUcCqLRtpbdcJ1srLCDFGAlbOvB?=
 =?us-ascii?Q?LAwe8hMkXTut01/58R7nvcBL3vbYswAJdfBYQLW3G7AcWnb56Hw1Pih/Imak?=
 =?us-ascii?Q?UQiB5r4oH/7T7VEfsoMDL7JXFiHR9WU7yF/UUmV4QcyTNmXa9rrX9JgLKZWz?=
 =?us-ascii?Q?itUfKR/3vbyeK9rrA+NMOat1pAgDaQ5PlB8z1raNr7jm8H0RT0t+WyU0D1Pt?=
 =?us-ascii?Q?cw8U80aTwaA5NIFn88myR2XDSZ9u6A5R7JbjsR2kCTNw9frTuwr6Qs3VyZ3o?=
 =?us-ascii?Q?vjhdE2QMPX5KCaZjxf9YTnSnIg3MeRmWkCJlimLx8iVpULmH9aGdr7vHZZmD?=
 =?us-ascii?Q?hYCAEiPUREvzWxbLVidcgGScZgxAaulTfneAreh6sSWtmF0rg0nrBtouovlh?=
 =?us-ascii?Q?t4SKGnXG3ZC2xN4QMxu+l6SxAKDWMzuNEfA5UTefKxFVwRhjMm73X+eJdsWc?=
 =?us-ascii?Q?e7rgeClUlPbc9rRetRV6Q7g+vKnXf7x9PIZbxNLqV55VmdS2uv45ynSjo2bz?=
 =?us-ascii?Q?h7bp6P95itowtnt94awAxgvFcd1FTq3MsWiuDypmGXb+cohnXnnKDTsPNASr?=
 =?us-ascii?Q?DJeDQ/sq9B/oSFVh+FJ3R8JrfTgZAy+D4kQt1maZSWTDl/ya4wGChJmaA07n?=
 =?us-ascii?Q?2u3gxFQQSCoL+dxhEC1SGRteZIviEqsw8k5UIqoAnCcyynmlbknowvNnU8Me?=
 =?us-ascii?Q?8NExIroQii/h5vUQ++Jjj3n6vuZE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hwTikGoJW8OMzc3c1J63qdh0PYhst/hvBAYu63cvckH/0g6eWF+U/3IkOgCN?=
 =?us-ascii?Q?Px8eiq5GS9M9Qpg/CLMBIrzgMAPkPrf857dXAB2lDSRCZ2p8A5D0g9UVciJB?=
 =?us-ascii?Q?aITFHn6QvM75839aBAGfJmmJ/ulLjXRFRQCYXu0GoSGUGlXEwBrOv9r5mlc9?=
 =?us-ascii?Q?YXn/8iKfytyCf71PKGsMT4C51xP/4XtzOzHHaRlz1RFU+ltW7HnMdjwiHNYO?=
 =?us-ascii?Q?Mq6pGED2QwFZZLj38RPos9gFWyrmcOrAPgNGTqufTTUBycicIlDauoS7iebd?=
 =?us-ascii?Q?AALJYGc1ZCWz08JvwQffNR0+WtvtNuIgUvfLMHG8vHsTp7/dtrNadIucvgUC?=
 =?us-ascii?Q?mRUiZSc2MzBO9iobPfL1gDGa+UGm2ZqmOs1S3Rb1KVoBuvEg9C709/SF67Yt?=
 =?us-ascii?Q?gH+jjsm4hXbHGbgYiGkWWJlXqN+5kO5pzH6ZPFOBecNTb5TbAKgtSIxMekjw?=
 =?us-ascii?Q?GtxxL7OvNwchBa7poa6EWHz0VnOyyXYKvRGwfuIK1qfbmjAPx3fOHtNw8y2P?=
 =?us-ascii?Q?0bdvF0T+lZfjL3zcwy5tgqS3OIMoFQJ5Ow4VMSAhl0+B1DzLBmCSh/kLw4fn?=
 =?us-ascii?Q?Ae7apGVZNWFWdjU8tHb3bhPZdKtNOIfYW41/wMXAN5VQTL7VwvN3jRZn/ZVX?=
 =?us-ascii?Q?LGcQR6wTF/tc8eXwFymPXiKRtQ2cSP2FbD02ZKzZjDVaCz8nb7aQ5wrQg7ed?=
 =?us-ascii?Q?1C/or0Hu0n5AiiZZuMqbWsHZlhYJlXtgVIuSryHKauyOQgzkOl1aqwF2/fZF?=
 =?us-ascii?Q?qLi0OVi2+BPgb1N94Yxid4Twt6XxvtULLttCrieK6hYMve/lTkiNXyLRcwOl?=
 =?us-ascii?Q?yv1C2YkIeyw+pTmbhknoYs7W8Cr40MgfjDVq3USXhPkNBhKTdryawhtUYQ6Q?=
 =?us-ascii?Q?eUrhg7+j+f7vQVTKIyvKDyeZRmU4IPF3aynlWBokqVP8fWxGoKdbR0sDpJXZ?=
 =?us-ascii?Q?uYnfMICs2biVfvHyQfeUnqcbvXaEl0bCExIn5d+sZU+BMA956OJ6MqiEG9N6?=
 =?us-ascii?Q?zbSbqLVZgRN1okaODJ/mXba3S7HcfX/yj2VpY1I/D5dJsoRAW7EQwvTibUnz?=
 =?us-ascii?Q?euGfVVGuvjtntmYXN7wEFLfiftikbOhUweAa8f8rDzFHn1DuWThE1b30vHnP?=
 =?us-ascii?Q?asTs2Pgo0p3cfXjCPxYekMnRdCWrUsExbQFye1XiEHyQ58ela5RJ5GPx3O2c?=
 =?us-ascii?Q?+Z1jwfA8OQUG2R3mqTshKS0Cc5lHPvKHcDPTwQrCepsmBz6U2BSNekRHdq23?=
 =?us-ascii?Q?jgPV8Njt02Kf3G90f1uKOISovcpgIww3kB5mKdjFWT7LMHDfD1/MtG96ssHm?=
 =?us-ascii?Q?ANrQPC3nf7+4UI1WQ0ryu4k6vSKqz6Lg7U1mVe1df19/UzPOo9OTVazhjbXn?=
 =?us-ascii?Q?BIzQuxAFaIixRF8cFwtx7wtRTe4hww+/bHuvj0Un3fVd0Go4Ev/z9Yb7pqe9?=
 =?us-ascii?Q?8VSRjaFpljQ/9JM8OUHQzXJvIAWeeeL4ZpOtLxWCAzBdCvacfzSKZrncRE1L?=
 =?us-ascii?Q?iuKVQ1SNyL5EH+2V0iLRBEGL+gMaHnh76OPAI3WOjx4Vg3JGBRhtbC1qHiWo?=
 =?us-ascii?Q?c+w6Gqy5RRQp892kETZMc9NulyD+i3dDgCNI2R70Q6vxB6CSQQx4n5byJP0E?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xBKIzZYsZT96mv2nEjyQkJJHyq41C3YkNPoIT2m2u6e8m753ZAmfAcyb3eqJGu/WmxGVmy8Cs1tgSiDLzfcpPPITOnlmajIYjYpfr9oCJSjM2rdUTFwtJpgcYLxsWKiXQuQVTgqVokxdVj5po3nFAB4limD7jXjcH3bMiDwlpz5VKwKW/ZmzGQTtY2yM79/rtkgoYLye0qF4lahayEW4orgs532ODXNPNfSraGv33tu8Xt5VoXJXN1pJrieb4QqfSCmYoGQarfKqSWUB2Pt3Cvs7O1I2eJyvWREK0tW4NM6u9nMbstVE7VgSzm2UYtnQDgMfDXR8ZiyJ4Rd1ysvzsAl+0jkioph8lnNW5Bvj9ShjTIB/3IGJu8bZwatf8pPwXfS9/r5FSLe2NMv2yRoGKcJNQYOnDXzzBGcKTl8XaObgFFDtJ+T7dHJm66l9f7C0NqoscMkqLz3/J3Z5Av0QX10paQi0Qjayq3WjIqcQyumI/UvmMXkmLKbqs0QXsrv6VSpD3/JB4E6TKY4wL9C+h3cbuEUOiO53xc8qCI3wvIkoKS2mQ2YT+G/wrfIG7gZOtkiilpKm2XJjjl5BIfvKTMWdRFecHE9VU4p69kEo43o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66beb434-db87-48c2-78eb-08dd5562645f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:05:23.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcGcIONQIUl5SylMUNGMN8U2wmztrSYr6n4Ys5QPfebluEbtNyf/s7b25+5NjgsnYadi1u545W15rkyrF28MORAQPmXPGYXgp2hLwCiTFz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250038
X-Proofpoint-ORIG-GUID: oWMWX0KsLoT-_D78dFq6dq1v8KKuA12S
X-Proofpoint-GUID: oWMWX0KsLoT-_D78dFq6dq1v8KKuA12S

On Mon, Feb 24, 2025 at 10:52:40PM +0000, jeffxu@chromium.org wrote:
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

This is much better than the original thanks.

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
> +	bool
> +	help
> +	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  To enable this feature, the architecture needs to update their
> +	  special mappings calls to include the sealing flag and confirm
> +	  that it doesn't unmap/remap system mappings during the life
> +	  time of the process. After the architecture enables this, a
> +	  distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage access
> +	  to the feature.

Architectures also need to be confirmed not to require any form of VDSO
relocation, which as discussed in previous series some arches appear to
need to do. I'd mention that here.

> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config HAVE_PERF_EVENTS
>  	bool
>  	help
> diff --git a/security/Kconfig b/security/Kconfig
> index f10dbf15c294..15a86a952910 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,24 @@ config PROC_MEM_NO_FORCE
>
>  endchoice
>
> +config MSEAL_SYSTEM_MAPPINGS
> +	bool "mseal system mappings"
> +	depends on 64BIT
> +	depends on ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> +	depends on !CHECKPOINT_RESTORE
> +	help
> +	  Seal system mappings such as vdso, vvar, sigpage, uprobes, etc.

Let's be specific here, 'etc.' could mean _anything_. Also you aren't
sealing most of this, let's just list what you are _actually_ sealing
here. Which is AFAIK VDSO only?

You can update this later as time goes on if/when you expand this.

> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  Note: CHECKPOINT_RESTORE, UML, gVisor, rr are known to relocate or
> +	  unmap system mapping, therefore this config can't be enabled
> +	  universally.

Thanks for putting this here, appreciate it!

Could we tweak this though? I'd like to make it crystal clear, so I don't
think 'note' sufficies and this sounds a little too vague.

I think 'warning' is more appropriate here since you're breaking things for
people who might be unaware. And we need to say this -breaks- programs:

WARNING: This feature breaks programs which rely on relocating or
         unmapping system mappings.

         Known broken software at the time of writing includes
         CHECKPOINT_RESTORE, UML, gVisor and rr.

I think this is critical.

> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> --
> 2.48.1.658.g4767266eb4-goog
>
