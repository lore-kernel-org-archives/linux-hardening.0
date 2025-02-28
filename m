Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0261F4C93;
	Fri, 28 Feb 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763862; cv=fail; b=SVAZgpeFgmAHI+cxbp2Vg4xhemLU+ZYPT/vcdug3BnhGNnb7X0fGCu4VxJUUWb/zD1xO8wJu6WZ5nIS7owxp51KK0OKCy8ZAS51O/yQQCJ8++E1gbqn5Lyv7hUJJ7pn36d65ywCpMxOnCypJ7FdPAwVBOTx7iOZdbEn/46GNaY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763862; c=relaxed/simple;
	bh=cv6TRHQTv9awt99I9Zgzg2ApOCV937kDBFuMxRpZXMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sQJ80IbGbxyfpZ3XED6ASG1UaguWtF8xEjyuH6ZjCI7Kw4Al1vbkexSvrX9uRMLPT5MtjF1en+8lqlSJSyu8yAEXQU03Buee/nAF9chq2xdUG0Mpi2feb6D7UJP/zEneW7BZflhVsY3nNzYPvHxZLdyIExtonoRgeAqyPy00zcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Aqbo9WBD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CeSz1iMF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aqbo9WBD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CeSz1iMF"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEH42p005714;
	Fri, 28 Feb 2025 17:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=cv6TRHQTv9awt99I9Z
	gzg2ApOCV937kDBFuMxRpZXMc=; b=Aqbo9WBDuFLnNlWasnBTRsv/HFBFhN+kny
	m+RcbgzfpOqs1DPpc7k91ZMs7sDllU6VPsZ6mRFy99htGqyZoR+HRlVWJ8ObSS+3
	9206BOexR90CriwCfmAiAi7rKOrW9x9Pum27KPx4MS/WH1RVLDjUEj5Ss5gPTkJF
	qur2IGdr0Ceg9RnvQTMASMvPRVc7RC2iLCqjokNCyFhKjBFY0ZjOS1QUR5QFiG52
	mAM6pIFgkEZU4J0un0/wY784EvIeHxGgph+yCoVXw4T1nmynA7J9ZlumFljUaiMI
	BDesS0OZjfN2xN7UiNRxIZ5v8fiNu+I1BBHnG/DQujaackRZ0BDw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psce41f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 17:30:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SGwtlH010205;
	Fri, 28 Feb 2025 17:30:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dkts8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 17:30:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDpKWXaF4JYffebUVis3XsX+D7IG7YT3h4qFstjWQ7Qpdh3plcWfZklXgtm1xaiUwB00x8vI+0vDdqUSl4ihZ5P8hs+UsRnEx5sBJ+iC+wNwj4zMjcDDliNnSIW4v/I5JTlSnnftgdwz1V6RvPCVNnERrc9J+9PNEfHqn14b0PccVNICB4WxVffyU/8DwDaSgk+g9/+ws72ad9ZofXWoiLp599ZECvHXeCo8N6gyulZ8osbvSz6PSlsU/xsQlti9q+S2z0H7M98IDV7bqoeyj0ZyS1/n3uOcNRIVYplVXgBB+JJxR1V+98wB4RP3hs1gMVitfQe6pB3vEXmeIx571Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv6TRHQTv9awt99I9Zgzg2ApOCV937kDBFuMxRpZXMc=;
 b=B43TlnnuozB+nnG4OSKCFodqbd19n1AV9bZPWS53C6HmcoZBkS7JAQnmJ20WewrMiPeRTIgBgQ8lUpfA7dXwxWwIPBHtqT8ERTuz6U6dGBVyMFPpRfIAdT8xNgVWrpS/ILUp6FV75mNv2aB+dE2qrX/h0S5YP9rP5Gh+jHse4KG2nt68gT0zU2v+0WOAPXzzyf8iteBJeGdPaHNyaS4gK6R2slsJ4Xe+6Tb2uoGpmdwStIKUPXGa45so6vqgmA75d7M7eEkFVTq8KTOm53/E6k46xc/ghvSQN2joFxA3z/yX+sN2AaJSkTSl5ZbPEwNzuRgNUJEfnMDGqo3fYTR1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv6TRHQTv9awt99I9Zgzg2ApOCV937kDBFuMxRpZXMc=;
 b=CeSz1iMFiVlOxG/hNPJf37NXoamgoHfw1m78ApoFylcWLLiQNC2jH2WWcX1htjVp98xZDeeePo2d1UTg1RVNj5/VOcc8OULe1BkbJOmx/3Z2cinuGm6uKATtJCCKGm+48NNRX0oJ9nXqnlcSltrGcrY/y4WbVWf8qax6g/AkEgY=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SA1PR10MB7710.namprd10.prod.outlook.com (2603:10b6:806:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:30:12 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.023; Fri, 28 Feb 2025
 17:30:12 +0000
Date: Fri, 28 Feb 2025 17:30:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        linux-mm@kvack.org, Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Stephen =?utf-8?Q?R=C3=B6ttger?= <sroettger@google.com>,
        "hch@lst.de" <hch@lst.de>, "ojeda@kernel.org" <ojeda@kernel.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>, Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Peter Xu <peterx@redhat.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "gerg@kernel.org" <gerg@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ardb@google.com" <ardb@google.com>, Elliott Hughes <enh@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: your mail
Message-ID: <a05e6abc-f767-4b29-96fd-1ce055ce8a51@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <e697ee1d-6075-4f24-8365-32aa4bc84d7e@lucifer.local>
 <CABi2SkXcgB1Zjztqc1W4M-5j9z_wMCRaEtK-wLL3x9_qC1aGHQ@mail.gmail.com>
 <f65bd1bf-4e81-454a-afaa-f84c13cc6227@lucifer.local>
 <CABi2SkV2_-LYGjROm3cs8nHrzBiw7pjpe0i7QGNPsPKHSeajog@mail.gmail.com>
 <60f5b979-2969-4cb0-ad3d-262908869c5f@lucifer.local>
 <CABi2SkX8QM7W0uCUBPFhjrC3psr1HDHLe2i-9hzh81UyKsBuQA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkX8QM7W0uCUBPFhjrC3psr1HDHLe2i-9hzh81UyKsBuQA@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::12) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SA1PR10MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 38800717-5c0d-4884-f843-08dd581d8e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URhrN/MylfKP39Ge93h6ZDVVz0oLDFEH6HxUoTk9jx47C14SrN0B/Wp6hzW7?=
 =?us-ascii?Q?Jg+fJiNNpyTSMKb+h+UkTd6VkLqwDmOhBuQ6WNI982Fs8x7duNXriiNIxm+H?=
 =?us-ascii?Q?ci4QcHoQGbT59ImnncC4wBpOluqxJUIFWfg0NyeE2SMTqZhN9elvwNr1HZwb?=
 =?us-ascii?Q?GPVp4ytR/Ca6nu0H/Fg9foESBJaIKvFMPyEeqzbhUArC2HXh6s1CP3GnIqju?=
 =?us-ascii?Q?3DxEIKOrpRfxGvj2JUpJO+goGJXYx7+cXXxm2bRqUyHYJJ3gSAcR/TYheS5U?=
 =?us-ascii?Q?52jcOjBZ8cVBJm6b821gsKLaSWhX41WgXfNVzA/Hma3G5naNGf9OBMZZWpZG?=
 =?us-ascii?Q?27KebisqUarM4Sgx+DNgGo0cwQWQfalj/Znrz2hGk4chsebr8hDnaV97Ws2u?=
 =?us-ascii?Q?OLw/dt9DluFozQeWw+iYmlrlOhnQgzaUVD7j6BScfElLf5NqUStLMqWQy1J3?=
 =?us-ascii?Q?jCh6MX4P3mWG6OiJkgNipCvOt/RnOsPCjFHY3lqY9uTUgbIccYrNEn60eB7B?=
 =?us-ascii?Q?dkenbmXREu0OB22ZsFAhcU330vhpjWa835RT/1sbjC0vfRAAPDEmi3H6Eyn3?=
 =?us-ascii?Q?mmvvJc+GIK4OYbWcyHHBW9En/nenImYCLwV8pD5IYR09p1SEa4yIIkYosXF/?=
 =?us-ascii?Q?y6tD1NSSAke6NmIPNv/wXrcsht86e9rAZrogO7eAUQ17lMi6mY+Pv7HcNMRv?=
 =?us-ascii?Q?n0EFANKk76JdI4h7HyWAw4Ll7pkRN3mS41+bDWrAC0UiX2bFAP/duhYjL0ss?=
 =?us-ascii?Q?WmABNgLlYVMfs1OHjnih/bCr/p2DWvVAGOOJ2U2JjV5c0a6bq9f8+ZEclbDp?=
 =?us-ascii?Q?daxyxGUS/Ljdi0jk/kfSiIfD6y94JlrBSWhj7JPs0NA2XR2MUgjqcUs6LHqH?=
 =?us-ascii?Q?WvzKfS581V+uFGd33nnqQmNetocL53gChyjPSXQGmac+fLKZMwXaQ9mEzHpU?=
 =?us-ascii?Q?pytReNWUkLYUSLn5lLa5h8jZXbUBT+cUfoXdQw1rRhqKOegKZ1uCcNSXthC7?=
 =?us-ascii?Q?pMGT12WDiIXycKYjkI7T6UMNuMf3oz2gke1HgmLxCEa89w7ilAGX+KJzsF9m?=
 =?us-ascii?Q?9+sN6ZqjbuC8yj34/JRNfyuphyLhwcPjyCuvyx6o0hEztEcmltSuP+CFDRN/?=
 =?us-ascii?Q?3PES5iwl8iJeg4jb0q6QXOCetuzQ5kgaDh+MgpISFjntI8mP+UNCjxLjyeOw?=
 =?us-ascii?Q?xRlruxnMCJ2WF+dNd2EUXgBJ5nXKb+N7o7mhmIGDBudsmGMKn/oTa4qU3S+W?=
 =?us-ascii?Q?ojoW0Bq/NQ0tv2SByT+bYKWODRiCkMfe9jH1tL42FSrtasvy4v61g3jUJW6I?=
 =?us-ascii?Q?54p/48+cw7/t6gJE2iW8a7usyTeu/1T9Y7Vu9heYPVRUKMJk2U/tFZsM0ePd?=
 =?us-ascii?Q?kLyvAs8qhS4ONFMrrgilRDzUHTkm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zbfmCe39OCFvSFJsnyXtaY8bcVl1P/DVHlg9yS9vYNcSlJZbTnjDVyHiB2fk?=
 =?us-ascii?Q?wY5oYhqwnKLGpK3izIjtfRfXhp7Do9I9dCnzlpyQ9Chf4a23CQs5KVHCqsdo?=
 =?us-ascii?Q?XIy76L5kO3VKGhWidLlQ1vTSjzduU9I+/zSwZVyDzS6DHVNg9q3O+8lVT+d6?=
 =?us-ascii?Q?giCb2XVYUyLbAZ1M9yTLFBWP06kA0d1Rmg8C8r+uSBeI+O3GKhz8IbIPu97i?=
 =?us-ascii?Q?dOG6PwaOjBqKkdasgESNYEjk+AUwgd9YSOPRf9u1BwjXbKy/kIFTwiPjIEMo?=
 =?us-ascii?Q?T8Xnr15yePmAk5e4qdHzgtkIcpYkymMTgvMuhZ0tdS7uaOdfVkIwl9CqmnZM?=
 =?us-ascii?Q?ovVEasJ6zcXmJWgffoU4bAYxKLivA/CK1b1v5BDozUBsq0ZnIRfLaITnmz2J?=
 =?us-ascii?Q?ID4DlpUCPmfepSYRSIAWtPjZTIyPpwFBC5blX1zF1kyLguqKlnd+e7FMNHRx?=
 =?us-ascii?Q?TWIq320dmKv5EK9UGdrevANDf803Ed0DJjxfAwf0DHoKlNd5ZC6sfh3iDek4?=
 =?us-ascii?Q?fNjRtBG4BZW/rx5pxSRoQndvUHN6dA80GICvD548dPFeUQ5bgoIOQyIahzIG?=
 =?us-ascii?Q?Bo6oWcxdd+igqyEIYQMPJfCo7lhjNCGINTL3C3d/EvFdD6s95Wwv2TbIOOTo?=
 =?us-ascii?Q?ZiqTgvUC3OiqDSVIe/z6IGCRcUvhfPkVfYcNL7CxOJrvo60Cd0F8pLsBFJEB?=
 =?us-ascii?Q?MUy1PJJGzzgLMxoGpPKnpPHt5ptFbYIbxKn+p/2tIXYIXbOwQ0fwK6XPY8Kn?=
 =?us-ascii?Q?8kQXicCAGHZIQafSiQ9gK1+uXRS2Yze4apEEjePmC7vde9nsqzF/67WgdEql?=
 =?us-ascii?Q?lCfdDEUAMbbV45MHiUB/4sP2c+vYcJ1Qm9SUxBGvLa6vqeMwl4v0DQHd8s8R?=
 =?us-ascii?Q?6Xbowz5afPrKQ5RO8KAd8VTlQUKkpWfRKOEygvSTY8Pv8UQnqdcdNLkFw0u7?=
 =?us-ascii?Q?7yMXx0ivPyo/jmnIk527nvsuWF4Kn1Iz8uKXWjju3tUh9OK9a8U7+J8xVOhu?=
 =?us-ascii?Q?vnb8FD48uBkDmViELB7aZrnn2PBOji/7JxKGclKzfT6Qf72OQYmE1Ang49Kt?=
 =?us-ascii?Q?ekZT7pMhFBZkJU8kexokrZ9OFq+db14MKVHx430j0DIfkqZR02rnrIVAf3S6?=
 =?us-ascii?Q?BIzKisx3I938jhuyqDwxRaOo7hfBXapjxyyCwCdI77p2Uhu1aHeAAB2kI9e2?=
 =?us-ascii?Q?TB1NT1AZMpfebtlcU534Rl8IVahuyBzqqX17vKKUIArbAEa2dzDcg6X6DZbR?=
 =?us-ascii?Q?FtqMNZb2riUD1c9KSOR6dhFmSl2wP+aFwpFBzQa5YJC1mwgnU2k3U3r/BZWr?=
 =?us-ascii?Q?BNaJfzjVttznXZSf0rfA45zg+byiyBoqaZfJ888RGVa4KnoGlzROM4+47Hm0?=
 =?us-ascii?Q?f3EU1fXXvX63J9sU3mVKcP9ecnX+3jRt5vE48XQpp5L44r14xJ8A8hi+QSHX?=
 =?us-ascii?Q?W5jYMIe6VDxc2NYzC4HaTsHY0EJUjd8P0uoQ7a1e/fXrWxP14KKnNY05CPBX?=
 =?us-ascii?Q?LOA0ZKPIt6iZubOw2JUzQDWqAH0yG3t/qt/CxCrYvXkIUW+9Ch5u8fdGVUQH?=
 =?us-ascii?Q?mo3nqYWbhMlnZkQYk6XP4ecdlopmgt4KN2ImkX6Abibhh5LiE8CWYKuQwS9T?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jJcXKeApv2i8yuZP/psbO31CUGHQ4ruicBczRi6BwomQmPZIrtDhn8rpY0nMw8qMNYuEGhfpbrY0RdzNr6tBrBskz+cThLoNFVplE/oK/0LY3EZrf90pgBmGFazQFMPZJuvdSZgGhYuyn4nUWPEjBnZ6oSs0AJCXOChX5pJjkOK9uwTtchM+rc5Lnn9MaVQaVryeMPAJBQZwYOWNpyMJwGwWJi9aKig7ROjhABvd/Q/7cQoGCsGcFCsLklMPxs4LdFyRQi9KSEgmTvwymwB2ApBbdeNpQRGtlBPLWrVifaz3jPeI9jIZ2Rzso1s9tajGPAPNHqvblxz0zpv+oujcHCuemoVQeKLeQSmyDIfGJOJPdlHUXGSsCUSM59gydtiA07byeMMhtE89h4a/KICp9lTSUOR+7ErY/9tl4Ffi1F5zD3Zyeo/C41QUQQgqwFN6AyMY5w1aAbmpZYvBXSg9HCGs1DcBc2xMiQeN1EF8OOPF1tMgMp3O0iEGeZ0ZDilGMsscnejyYAacOYesqB7tAfnCTal+V+6PfxdvqZsW7lOLPidPx4uAJJ1A/5peJvoyRutqRDeg5orWjIHYzBoHkYOW3uLE4E6V0Ye+YgMRyAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38800717-5c0d-4884-f843-08dd581d8e41
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:30:12.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PNr4rcgvyn05b+UNzzCsCtVKuCIQfJs/WAd8l9YT/LUU76V+wt9h4gF28OdoFA+n5ZsFRXynYjhcO9UztnmJONVRIMa1OC1Umc7U/UTjQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280128
X-Proofpoint-GUID: N6DeDMTT8NOThdYAv6jTrGNNBWXJF8tS
X-Proofpoint-ORIG-GUID: N6DeDMTT8NOThdYAv6jTrGNNBWXJF8tS

On Fri, Feb 28, 2025 at 09:24:11AM -0800, Jeff Xu wrote:

[snip]

> > >
> > > When the vdso is marked with "sl", mremap() will fail, that's part of
> > > the mseal() business logic and belongs in mseal_test. The mseal_test
> > > already covers the mseal, and this series doesn't change mseal.
> > >
> > > As for the "sl", as I responded in the "refactor mseal_test" [1] , it
> > > will be part of the verifying step:
> > >
> > > [1] https://lore.kernel.org/all/CABi2SkUv_1gsuGh86AON-xRLAggCvDqJMHxT17mGy-XutSTAwg@mail.gmail.com/
> >
> > OK cool thanks. I will look at this when I can, I'm just snowed under
> > pre-LSF and have been sick so backlog, backlog as discussed off-list. But
> > it's not been forgotten (whiteboard etc. etc.)
> >
> Ya, no worry about that review, please take time to recover, I will wait.
> And appreciate your time and take priority for reviewing this series.

Thanks :)

[snip]

> > >
> > > Option two is to create a new path:
> > > tools/testing/selftests/sealsysmap. Then, add
> > > CONFIG_SEAL_SYSTEM_MAPPING=y to the config file and add a selftest to
> > > this path. This seems to be the preferred way by selftest, but we need
> > > a new dir for that.
> >
> > OK I like option 2 let's do this.
> >
> > But let's call it mseal_system_mappings (yes I"m being nitty again :) I
> > really want to try to _explicitly_ say 'mseal' because we have other forms
> > of sealing.
> >
> Sure.

Thanks!

>
> If long path names aren't a problem, I will use mseal_system_mappings,
> otherwise mseal_sysmap.

I think long form is fine.

[snip]

> > >
> > > In any case, I think the risk is low, and the code changes are quite
> > > simple, and fully tested.
> >
> > Yeah indeed, but I'd really like _something_ if possible. If option 2 is
> > relatively quick let's get that sorted out!
> >
> Great ! I will work on option 2.

Perfect cheers!

>
> Thanks
> -Jeff
