Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A328A2CB;
	Thu, 13 Feb 2025 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477536; cv=fail; b=IUTwvwUYI31z+IsBa9ezshmzRB/cv1TW8j4j15xVqLdFBZJQisPgeC5sDU0so97Vx7y5IDJvzYWUZ/fqtDAGpycQFar/A+KmZbVjdaUJO9BnBnPgJrBkE21APtU+9qHtlZBLdTF2Wydxn6m/XX7Suvzozj2JtutacM6ON2vsQ4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477536; c=relaxed/simple;
	bh=jur0G/cswFEv9oHTynzYQlU7xb1toQl0T08cdNc05Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L7HUYOHzDzdKmxgLWys2H2TRtn/qCegEK3MX8MmTOi/+htnUYlXcWTKNOmd7eveyonEYX3XYEsQFnyIXV/UVSHs4oNLSbFtcx5E9J3xhKngl7udZ1GMYzjyJyD2hdo8l74Og389xtgAYrQ2nJNJ2rhZHb4FzH0WZdJ9F0ULQOh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UH/oO5nK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ddvww+OE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UH/oO5nK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ddvww+OE"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfYgd026117;
	Thu, 13 Feb 2025 20:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Z01JjS78AEdMIzH+km
	apgbR78H0q/H/sH5WJLeRI4mY=; b=UH/oO5nKhXXuwbx5vdGkLZ59i7y6QcDAAi
	LQPBIz+F726zrHlBBoMZQr3Fm5+Y2uOdcF5TMHHMPZ06a+gSIZSN8t3Nz3rEIIrl
	XOm7PTOdQiUkHZV+e9+rCNVGV8Gt2yVbt0k931XdEish7DcdoR/BeEztM7f0VwrZ
	hGzlV/mTb0fSnV0uDiiBZgZI7rcMtfJkV+Q+gZvFWjVXe5AMhldK/xRnn8qSCmfp
	JhqwECKzxD9pwTNHTh1gJ+OmTQNRDSkGUuH7m8Q2m/TxaEQFjDHUiIaLSREdy9vA
	Cm2YtU4JZ5V8SUYLTFTQMghVsi2M0jq5gQiL/EFFOEw33gEq+uoA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qytfct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 20:10:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIfI8b017566;
	Thu, 13 Feb 2025 20:10:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqjj830-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 20:10:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzXovbhhL49zIbrFA0ag0jTSzZRjBhxiryiQ9PrpWVq36Zwo8AAnSX2EwKviiPzfFnOr5ptbUAgguKfHOX9+xJahn6hVg6Xlm/VxSNiRjqUzNozh+tkjd/uOd0x1pA8qgwYCBtsIuIWgw6ni+yDNq6nh7w3FZd0OvWaB0JcYDVRgFqsQWT696jM0EvtIU3SZtAaewNcUe/Fv0EtO1m+SpnASadaR8ZWu2bzjxF7iknSaogAjwFYcGyA7bDX9zqL7cvzrTc6/OIsid4tvG3LOb05JUWNSPpFFvSN2Wjag7AuJ/HjsCqebc0DqKpiILY1jUeAY4Jod6mfDZgozKSNEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z01JjS78AEdMIzH+kmapgbR78H0q/H/sH5WJLeRI4mY=;
 b=ECW9lGiu0/1Fj/P9ErzQq35gtmuQPXUt3mqqHWW/Ye2WoDpIZsXQCV8pmGRR/jsjqdShy8bZnoJcSU8ZJoiq3COfAgwhrcnsu9pUk49/CdNdtdSjlznNhrgYhDdRP4BOIEiopAs+V4kpUB2SvUyQl3jMeEt1i28AszQP09yybAh2Ha5fpoimQtx5nbZHKxjSX0htnZkGKuh9UQcBvvrK2v9qF8I1TmBlkinJA4p2nnxp976mHFhpPQLqWOMx1oFfZfryUUCR+E09AUMdHI+3EOSC5peB5oyfqMqL6bDnwafJrRYJBg3ThmA+34cJ7PO0PLIZ3B446Zv2ZFvfHNEgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z01JjS78AEdMIzH+kmapgbR78H0q/H/sH5WJLeRI4mY=;
 b=Ddvww+OEWUOA/1vKNTbmJgMJOH6aj1UBCYk5qJPG0ZUmYW/B7zbKFIZKtWUn3vZSMOLbeeJB8ldEooVa4tzxYWnqG1eaKgkdZTNOG7ddV5HGXcXJoErNAT3zidGmCWkNjKOUxGPHvRwzJpWqSlKeDKSB7l8uPu3jXAvvB4ejJTU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ2PR10MB7655.namprd10.prod.outlook.com (2603:10b6:a03:547::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 20:10:46 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 20:10:46 +0000
Date: Thu, 13 Feb 2025 15:10:39 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, jeffxu@chromium.org,
        akpm@linux-foundation.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
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
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
Message-ID: <ml3x5qchmnehdzz2rxsdcdghivaqffojiweuhvpvzw45u3l5bh@23sblrom3m36>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250212032155.1276806-1-jeffxu@google.com>
 <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <202502121401.B6EF2D4517@keescook>
 <fyqlqgtbscwh4fiwmjtkb74k4ratlelwh2vzfyaeatbc3tcicb@5uvfy4hq5xde>
 <CD0870ED-6857-45EF-9C28-F27475964D71@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD0870ED-6857-45EF-9C28-F27475964D71@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ2PR10MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc00e5a-0af5-4a5a-ca2e-08dd4c6a8036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mOE0p0fh8CtMNlzWfjHEqNWBhdlEbFj9WmK1/TWG36BdCYQfYPluGVlI9OHr?=
 =?us-ascii?Q?N/+N/oTh4XDuSgroIckT38E9irSgUbQaUjHqmwD98h2rOZg0ereMf34tPIZo?=
 =?us-ascii?Q?LN9RpROxvqq8qla+OhTkptH3/L2GRDbG1aCZHOLg7D82CLmfRlBfg8D+WZbK?=
 =?us-ascii?Q?h9UoEZYbpMtKiXuM+Ds2ciklnmQLJzTQZK7yeuHQG1DAuGf3WrBWQrtenprj?=
 =?us-ascii?Q?l6sOeY4xEFmiURE4cAutwYLXq9nphOlE1bTA7cgemekxxtXnlfmQO7rJsgJ7?=
 =?us-ascii?Q?zNezJmi77QUQEFcejOTN+lv9rNKGxwpdcFfRd9QGE/NNBbeg96pQ3SeGYfgH?=
 =?us-ascii?Q?WSfDcndJmp9NWZFOPsGruwcKg1KUy802Q4dU68nkAqn5PNs2KJ25qekFKd57?=
 =?us-ascii?Q?NuhZpTwfjkfQtvWFZVuhu/dnw+vLGd6iZ0RPqA1ZbUsuC/gQrZktxpCp8xCJ?=
 =?us-ascii?Q?anjaJBW/iiE0xlEffu7jt8kziHORGYV85VMxPcLdfjL4NyGsW7s7wQ3ty1Ea?=
 =?us-ascii?Q?mC7Il6kjXdRqIOmjsVt/IGHY8JfOP1XIckI4bdGavzWVMVZn3Eg6NOly2sYa?=
 =?us-ascii?Q?I3tDFzXxfRQSPn2LkBXI5SAMctscEoAYQBrwlASJMQ1IoIT4EWpx3Y1absEb?=
 =?us-ascii?Q?dD6mMITTVLIaXDlEXyFM6ZJMdrzvU4FBXwE7Ay1kdBHC7LxFXi5jOdyjeKXG?=
 =?us-ascii?Q?f6dk7GvpfUzn7ymvXtyVHQfsEAhGe6FHU2IezFtq7FlBoh+Un2iWxzwSWgU5?=
 =?us-ascii?Q?oI9U/V89ICJDDy91x34aKBhK+cVXAqT+H9ehT1f/Qd76C8BagPtaNP9BdsYK?=
 =?us-ascii?Q?+LrCfQsQC5GX7z34P2xu9yIzGqfjfCtWpSWwlY2xgdtxq/gxP0RBotAYiFFq?=
 =?us-ascii?Q?dn14PcWrGgI5dJuPj9pju/6+kvgot07wMZMOgzS1Uh6YnFEO4Q81fSHax6G1?=
 =?us-ascii?Q?rDl9Gfk9QjWjs3cHtrMfCpsDmsa0j3X/yP7TknbmyteBlxvs6bt2/rngtTdd?=
 =?us-ascii?Q?XXm59ybKq1zqeWZC5sasRoZAc0X3m6Kz9ds/Qzf1rWgTCHhcjiQw/nGFVccl?=
 =?us-ascii?Q?goThecyaJLEKw0m1MQ7m+OH3sc+2QP0a4OWLOQ7O6wzLEZp5UHDRIu0oRJqI?=
 =?us-ascii?Q?88VylzdLcaqw82cTCvNILJv0BLs888m7a0IA+RepnZt66eFPYpJhC44QZDNj?=
 =?us-ascii?Q?RWwiduNPmpp/+Yf5ZK6oci4VmrCY06uo7tkMGsgMr2874tfj/37Fqmd89dcK?=
 =?us-ascii?Q?FQeuEqDuFDC9ya0JVC6LOjANjbaHC152Qh08zJ3myTWap9FN2ADaoQMZnohO?=
 =?us-ascii?Q?TYWH2O9XpPivzeGAxqHSlQFbDUOy8QPkXzDX9tNTg95+XWX+fg2jNZBObnER?=
 =?us-ascii?Q?bqabbyGfmONlIZRTiJPADMiXkPF3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nFZZgyRmjGc+rfH+Lg+u3S0LkqCusaRQ4986Ue/GERl1wEGBUQhcjJ8Y8jZ0?=
 =?us-ascii?Q?43mEyNYTGXGfpjdN+fK1XaXUNA4XtqmWeyGHd6uHqtyctj+TDJeIPsLz0ohQ?=
 =?us-ascii?Q?AyPD2gcqPH8slZTRPo2nE2O3X5gTuhGbhcAUBgf9acrquGo0f2Zpkc5wl3Zl?=
 =?us-ascii?Q?tADjvKJomEAgtMrPnnnJflnuB+YkjfBo34YSpkkILUh8sHEWM8KvsNkL5fB+?=
 =?us-ascii?Q?Bww9TfFKIvSoab0sPtzvh5uXwpMjVWcSIg/DC3z9I4/F03FaT2ojZbUY62SD?=
 =?us-ascii?Q?S8+MnVMTS//Y+h7Eq7FfkcQUINs93Bok6e74hpv7m4W3uyZnbCCqKaQKqS0J?=
 =?us-ascii?Q?IUDcQopBNWilqIFAEnMTT7VhT30GX3j6JkMyONWmxyUPpZqvzd2iGO36lhlA?=
 =?us-ascii?Q?CLMWwJvoIJ6mmc3lqBh2ccBbj4bc2M2g+OFIyMUjO3cHrKOGudAiWc9g8XTQ?=
 =?us-ascii?Q?SPSPR9m8YwzHAOYWrOCvQpkSA27uJ7cCntnoRIKngQOZmPc+n3ED/GtFUiyc?=
 =?us-ascii?Q?CqUxDjctBNFuoSriL13h5G4GplHCGrEntyRVROK0iZVUdDNpBBuXhTn7i0hk?=
 =?us-ascii?Q?S2kGijQCDg2Bxs/EPKK1+nDChmiRIG/qf8NVA2jsoXk3G0F1uPr7yy/XSdfI?=
 =?us-ascii?Q?fPEZn1Dw8Igg0QX5aglgSw6VL+3gDJyuTZ2M6yJn3TCkpnezgduvh7f0L+fm?=
 =?us-ascii?Q?EsRGr/rVUy84bJLfgYtsXAis0z88Y3BjYr6smH1s/crXwHiIDFHk+5o7alet?=
 =?us-ascii?Q?u+tSv/Igl4yU6zcv/RSgS1fr+ZtHsTnXbW0pzRwbOP50Op0Ai504PLOPjpvL?=
 =?us-ascii?Q?tOBpVEbH/lU3vnLREY6/9kQ80A9N2TKQWLXs/DA2zxeJSgmDnkk9euBt+YO3?=
 =?us-ascii?Q?AvXHFKNHxahL8vfunxUFGPQ/3wyGlu2UlZydCdcN/97v2GWjRHv12J+zo2G/?=
 =?us-ascii?Q?FD//2ydy0Tj15OE+ZHfxgoZkUVB/TMYY5xuXIY5VA0XOpVbD7kpLzbQa10zb?=
 =?us-ascii?Q?e0lfWnHHDur1aTSFXOFwRgqRL3VUJ9Aa85pb7hyzF63PXSrCTssl6+gI6ooZ?=
 =?us-ascii?Q?CgovAV+6GsysL1rrz+DSZnxBPaXytjVvgKvHmIOH9xf5Ksh+CpwZHTVXLlbO?=
 =?us-ascii?Q?QAkP2Y2Uyr/WBaJactMbP2C7Jrzpd5bJNb7SxiirIdSZj57gdn7vaTQdhhGI?=
 =?us-ascii?Q?5Mc1HjcPLlScNYsA42t2HturK9ZdJ6pzDNFTxvWudjbcMjJ3cBHAmMJy+4Vv?=
 =?us-ascii?Q?ygNYiFuF83lUmtleqNfU2X6q24lIbb0LF0CMYsTaxZFr90kLjcAuQzyo7ntY?=
 =?us-ascii?Q?7Cn8xc0Sx5bjoAdlqL7O9Vw42CVn+Yn5KYo+BDmsLKx1/YEVJ6Evrzw0TgeM?=
 =?us-ascii?Q?id64YvkGhJ2pWq1+a3vfsUQ5SJcoCrUqMw5uo3yURpb0fwFIT9nLkE4nosjE?=
 =?us-ascii?Q?NVyNMnNCqOZ8NIStSl62f9GavwYu8cJo1Re7OPDyF4hka99Pifmd5M9WrCyS?=
 =?us-ascii?Q?4tguLg/6OXTeddaqjJKjXGTfqXbrg/JZARP8M1fbNjHu/4gS5hyksBmUJ5pD?=
 =?us-ascii?Q?0Ssc6WrLZ7HeVI3JFKJfVEC+BHkX7lTtGhgOTAZ1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N7bs5bzm97Ynw6YdKAD1h43S2G6qgNyqTNqg17YQ4aSShBLxcno8MNrebYxE9bTpw7qkL9Ha9I+mY0rwuKFAJ+86GGcY5vNQ9CMBHgKSp2oW+t5EwulpqNoIFVQug3mvOVl5m63CJ94aKr0d+TMcxrB6hAMbJsTyE0kBCoVWzjEy4mykdmzPmtLkuXcxthWdazJb3sCLDfU0H/MHimHUVI5pJ4qrFRm8pzNzr6RmLqI8naCOpVSYZSfMXYBOhXI4vLqFjgf5VIXVCm65fDDbcJfFeaK4C8Mz48okjkcxcjJpNs3AH5Z58ncjLojw/VjsfTpQeOnOprV7N10BcJwvwmT7ex5CVk0V4hYiHO1Rm7Wzp5S1e9fRVYibvnX1FqArfR7Uc8k0F1rP0FbN5LD2cYCUr8TAClNuCc72tpq0sYAzycYZLQ4Mf5wYhAt9eIAsr2dq+TgovGStLeZ/KtBwApiohuzEnLnw0U2jkmdFTK9IleIqvoHjtr0BKlXJUiiwrGilm3OOLXWMs3B+iPAUYRWJ02aA1dOLflg9Z8Q86vI07FYbiNw6KOG78OKQrNn8j1k06mNaOQ6IXprZYa1pUtL/yQo5cQyK0yckJgAG2hQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc00e5a-0af5-4a5a-ca2e-08dd4c6a8036
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 20:10:45.9547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/QMTczT1/pNelz9MDhrCOg/Q3GP7teRGkKDDORCGrdvUEKziQmr7O6PzdhNAI97W56tpfad8e5JDUX4FH3fQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130142
X-Proofpoint-ORIG-GUID: L73l9SD0qTw4kpdCK4_6EXFwALvavL5P
X-Proofpoint-GUID: L73l9SD0qTw4kpdCK4_6EXFwALvavL5P

* Kees Cook <kees@kernel.org> [250213 14:34]:
> 
> 
> On February 13, 2025 10:35:21 AM PST, "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> >* Kees Cook <kees@kernel.org> [250212 17:05]:
> >> On Wed, Feb 12, 2025 at 11:24:35AM +0000, Lorenzo Stoakes wrote:
> >> > On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wrote:
> >> > > From: Jeff Xu <jeffxu@chromium.org>
> >> > >
> >> > > The commit message in the first patch contains the full description of
> >> > > this series.
> >> > 
> >> > Sorry to nit, but it'd be useful to reproduce in the cover letter too! But
> >> > this obviously isn't urgent, just be nice when we un-RFC.
> >> 
> >> I advised Jeff against this because I've found it can sometimes cause
> >> "thread splitting" in that some people reply to the cover letter, and
> >> some people reply to the first patch, etc. I've tended to try to keep
> >> cover letters very general, with the bulk of the prose in the first
> >> patch.
> >
> >Interesting idea, but I think thread splitting is less of a concern than
> >diluting the meaning of a patch by including a lengthy change log with a
> >fraction of the text being about the code that follows.
> >
> >I think this is the reason for a cover letter in the first place; not
> >just version control.  After all, we could tack the version information
> >into the first patch too and avoid it being in the final commit message.
> 
> Okay, so to be clear: you'd prefer to put the rationales and other stuff in the cover, and put more specific details in the first patch? I've not liked this because cover letters aren't (except for akpm's trees) included anywhere in git, which makes archeology much harder.

Yes, rationales in the cover letter.  I like the way the akpm's tree
does things because it's the best of both worlds.  There is also a
separation of the cover letter with the actual commit message on the
first patch.

Having the full cover letter on patch 1 makes it difficult to understand
*that* patch on its own during review.

I've also gotten emails from Linus asking why in the ____ing ____ I did
it this way when I said why in the cover letter.. to that note I like
the patches to have _all_ the necessary details for that one patch,
including the sometimes "this is changed in the very next patch" lines
to spell out in-transit patches, or what ever else is needed from the
cover letter/context.

Taking this example, we have a 111 line cover letter and a patch that
adds a new file with a single function, and two kconfig options.  The
justification and reason for the patch is in the middle of that huge
block of text.  That seems silly.

That is to say:
Cover letters have the rationale and over-arching reason.
Patches have more than enough details to code inspect and know why this
patch is necessary.

Thanks,
Liam
