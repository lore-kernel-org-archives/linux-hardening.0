Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67D8248B
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226620; cv=fail; b=KNvdG/2QOSmiUXOIjpoCtQdi5iwzQaPPDkOeScU1RPnLORkngM9x7JWaJ36ZIUkGtyREeZ3h+TX31nSa5mQ6jFQ50jAk4+anJMfDyI1zQbvtkQeJdPzNKJd4a0C2HmU2N27bGGmMHK0qKu+l5MT4pHdynPMeGE/Pjs5TKsXyKW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226620; c=relaxed/simple;
	bh=LwVQjJ1eIhfCpUt8d3Gqw7Sbp2pfQhXRiaIkWNvBsSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlOttw1TF3h7HiDt9lHRPsz5UQQl6eTV8AbmzEE9k3Kly4o7psgi6qUen6JZ7i4ZDgOdUZyM+poDuYYDBnYEFi0yr+s7CK8eJH4BFKP7lGO4X7wS01iCGagtoNjM8DstPrVzdgVjLkc6BRBgDNKU4nP7PTB/GmrJZ/jlGR5y2LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BkDpPNiu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O4gDvVvn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BkDpPNiu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O4gDvVvn"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGDmOa021235;
	Thu, 18 Sep 2025 20:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jYxLDklT0zpK45kGzWeeHPCD//MV5iKIzr/xdavb56Q=; b=
	BkDpPNiu2UDkWK2Am9o+x/IafiC+ajqzDpxuvB/T8OlvJGKlebxao89ecLhcvQGC
	Z+e9IM+zpFKrstUry0jEboMvEbjyYAJvvB2RINsAC3Dnn2JdPFY56WKB8JwAaKhh
	zQgKdJsPJH8n4LFwxBXVJZo9l7vDvw/jEV05oZkQtI+Z+KVCue2LBXJjps4XWNPE
	CtFkdLpmKAIy3KjxIaeZFEL2ITLahwa6gE0hBl1Kxf7mSwbaV8CVmEabSZ1hTWUJ
	FXpxBO4prKShzYA7hdR2Y6GNTIUljzUBFLL7lo5EDoH4dTtjhNJg2AX0SRpHCVJY
	HzGMt+ARngJ61J1DVPuCQQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9vb8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 20:14:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IJPwic036757;
	Thu, 18 Sep 2025 20:14:23 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fp59c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 20:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnWTs98sz/mEs8nNJtpIqCBiZcJQTPlejP8uATmhDl8J6HFx6QGdQH4FKdKBent2Ykj9JDnozYYYY+LMbpLGd1LfyWqIO6s/q3FRAJ0pOigausk8Yb54mEShZpWqZCxftaqEFmde2OD6s+2tCStsy/EAsFKjM/RzQrF0VEfMMIaVP27nf3kVUaAr8bV3SXmJb0TZ+gnsaSmkhZigSLLWcuJZasG3PDwN5HvJuW5sJDpK++3YnQOR4kY4HurRSqhsC2KbsFmnAebqdRG06va+h+tgokwaLdL3d51eU2sc+t9UdCJH0lDW5tSkdi+qrUCH71jwlslwvqm3OUMn9Ua0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYxLDklT0zpK45kGzWeeHPCD//MV5iKIzr/xdavb56Q=;
 b=R5mqqFAYDKBqykRk3FfM5tmY0R+FNh8gM3U473BW7aAq5W8wsdUoTWOqLTsWw48119Rmmx8UpXtgfChisbBXNucc27Ps8ETr4Is0fc59w5TSyzJ4EcVubZARQDeU7wuGLykueQLzm2080RUNeY4vr1hDbl/nhlsYpTBHZnsUN2pdZ9gO73mmTGj+ySGwsGLwVnWM4hoIfziaiomSvsM4CNri4DMrmqEtZ8pTCLop4ePL66dnpah75ehP1GuFZq+d+g5/caEjerIFFTXA2wuuulzGSvlfXCL2eN2A4ZnJVdk5S609IpYuIzmZvVEc8FLv+l1zf50Cn+ihxcZehYgqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYxLDklT0zpK45kGzWeeHPCD//MV5iKIzr/xdavb56Q=;
 b=O4gDvVvn0LowCFrsNNL1lHF5e5WBn4vb+6DrduE5Ulo4JKX2jT+xrrSg2FGN2S0DPzwxFqyuLIJWysp98QAe8vlE4xvGc+L56Oe1GXbD6k7qfVX09GOnjcjOTRkbaNZB5+FB+UHdZxoce8vfU4jr3EHIxnwjQvM/EQa53d8Dm3k=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 20:14:20 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 20:14:20 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>
CC: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
        Martin Uecker <uecker@tugraz.at>, Richard Biener <rguenther@suse.de>,
        Joseph
 Myers <josmyers@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan
 Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft
	<marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito
 Cheng <kito.cheng@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew
 Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Dan Li
	<ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de
 C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Topic: [PATCH v3 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Index: AQHcJQWCX+/DZs40NE+NxElz4QOQyrSXZ74AgAB9CgCAAXkNgIAACbWA
Date: Thu, 18 Sep 2025 20:14:20 +0000
Message-ID: <BC4A7BFB-6EF1-40D5-93DC-0322084F4D31@oracle.com>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-2-kees@kernel.org>
 <6F94A091-6948-4220-A972-236055C2440A@oracle.com>
 <202509171307.DC9740ABAB@keescook> <202509181229.FF689207B@keescook>
In-Reply-To: <202509181229.FF689207B@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|BN0PR10MB4901:EE_
x-ms-office365-filtering-correlation-id: bebe7fe8-b427-4f63-8dfb-08ddf6eff3b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IboldbliiJUvZ2YjI2bPVMDLevfuBsCbxveKaFPeohV6uk/qV+ziJCoivu3e?=
 =?us-ascii?Q?I3Mu5/npd3CLnMRXOdlCavzj4PiP/tSIwrpEM3+Jhkqqtw0Ep6Wod5/AEaOf?=
 =?us-ascii?Q?9H9N7ds7bEu2t7ChQ4tZbUUkKjk6hrpRKdZDHccpXqmPHy4G+s8QX+QKrsbl?=
 =?us-ascii?Q?ynXqQgESOV6K7LDLXM6zmqluNTxYw6VvAwsLNL9WYQSFnn6viT4Jx+sKDtxt?=
 =?us-ascii?Q?5hrEUFwQaPvf70lSlV5PxuuYjsudSPDr8NraoPVyMa6WQBiY0weG7WMCpY9K?=
 =?us-ascii?Q?rg5eAU34+R/MMiKwGCjQsw9Ja60RSHiAC9QWzPY1lzYzCQXerXdXOLn3T135?=
 =?us-ascii?Q?BLquIpFzQiSEFreTuFeB0/RE+a55aQNXN64dPvQSr0r/Wd35YJekrE8p4Ims?=
 =?us-ascii?Q?tc8U+ZtD51zpUPGs+Q5/jNPnlScATIFTALY6s0tOGFCN1WRJJqGgE+kYUWPz?=
 =?us-ascii?Q?PD73gS9E4FNoGAumpIkBioU/jDjaFc6RkTlROsD2lggx+gVZ+0+okSuZ9nq7?=
 =?us-ascii?Q?tNo3aGJ127DoNXH0wK35jusFhWKf7ys0ng2GoIf0v+FX2mYtM0SZ4K2AfpnU?=
 =?us-ascii?Q?PlbW275qzAZSvUXlAH112BA1rx4jTe7F6dW/j+l1HVITNTtmmVf8yN3TcNMM?=
 =?us-ascii?Q?q5QLyzGVyTygmSAQzP0CsGvU1gfucvmJjzGSvR4r3o/B5Hk47UZ0b1kbSArq?=
 =?us-ascii?Q?/FvyAHYIU7j8trnwVx/mxFgUI4HrDlCYmvY0sehBbm5a79oksnZzvJVuILMI?=
 =?us-ascii?Q?Ulz0VzRN+8hg1aKMqm76HVJJ9zxVuv6pqyuRALilUU+5KiHVH/JWB8t3JvDK?=
 =?us-ascii?Q?gG21b+K4SHf10oszL2uAgZevzHTEFZ8VOQPLf4778G6Hf54uNoyY0DJ0rqka?=
 =?us-ascii?Q?SXWBghVsofOEIusOm7Z7ImfB/4GNEfy0YbqFdMN553CNvDRwbj14MGZpPtUy?=
 =?us-ascii?Q?u6F/0T7J1wqxsvja1sXQKY+81G255/V5jKlzJ6G8jBPMc8KuNK7LnLBXx/L0?=
 =?us-ascii?Q?nChbAljRftAp8CTjru31x7tnTlebDiJNx6fv3v2abawkjMXBIlQbIm/Pj/Tx?=
 =?us-ascii?Q?vsO0d7YUdMGbkJ1oqxJ73cDuWpaW93Cmyn/I/ghGUGs0h2vwCzNbODSEDkqT?=
 =?us-ascii?Q?19crfB6lb71nJMpxjZLWhtowCMOqcYA90cOREdaahWG3ua3GesKQB8JvTHzk?=
 =?us-ascii?Q?78BlFV0wiJLweFobTXT9wh66ERPBhTq65aOL2sRStM+9413pm3+2f7XSOzyx?=
 =?us-ascii?Q?GWZj9DlEUDRjJO5ha+vYPUQdbARW5h/l7AMQMcq+E/nIYQW01EY5lUb5LNKR?=
 =?us-ascii?Q?T7jJOnJ0JlAEZ59iC4MSkgbV/lvaF7dOVNNcLACrGA9iM/e0s5TQR7550mZP?=
 =?us-ascii?Q?XaBx9RnLwHjamSSIZXEUZGN+PS+w+NA/chBNYk/OraIJKIwwnXmAbe1D+tzR?=
 =?us-ascii?Q?PGIIKPLLlIK1VgJLQRSnZeTA8x4qvu/At/3F1lFuCtljWrHr8VLZVQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e03E0JdIjV8FoZI4a+eZmhj/fqs1GdAQniiaH7YsrYuDIQo0kfPCmqIC1CgK?=
 =?us-ascii?Q?QkxaquXp34xXUBJ9ugO+Bkt4qmsxSmUpvBgb4Q2RwWZ7Er/QiBlpRT1VhYcM?=
 =?us-ascii?Q?SVdFlNkgYBqbrqYKSjW8F7I3uepk482/7VXoH+MgW2VI8xQeL/yICmgX+vIA?=
 =?us-ascii?Q?WOBLS1xEv0e+ohlhgv2aWHkOuAXSZcbuc+RpnyHTL3duoSdGcZ67fLqf9c++?=
 =?us-ascii?Q?xhJ95gnG+tqad92SobYN4rQEOQ7d7xy4BdYnMcSaNiwnDM/7Uhqb/TmlW4Pa?=
 =?us-ascii?Q?AUncXH9xGobzFUW/ZWujB8tCptU6rDWWSH6Wpm1DggE4OQbjO/0WeNjbnc1x?=
 =?us-ascii?Q?EJbgBFyit9SHgSZn8b16aAUNkJYTuL1oVyKFHFTfey1uh269l3ZO/onNY0KT?=
 =?us-ascii?Q?hqilaFdIdwAGbJckydDXMZALTJxGbQN8PPri3lNIo1E9HFfdmJOZyFECKJFi?=
 =?us-ascii?Q?9f6+OVKuBElTX7zSU0Y5ePi9pKmgU5wwlMdnnIySDPWZRBYWcvW1HC3w2gCC?=
 =?us-ascii?Q?WCAeeFRmAoVj0TBebUdETuDzplkD8HEVCJ4DZWsHKU9gmNOH6biw+3j0iZKY?=
 =?us-ascii?Q?ug3WblBoPtZARbpKZbxquNaHITKxFjPz6Bw1yM/WdgiMEwaNBDNUHDru5BI2?=
 =?us-ascii?Q?sF38Te207tH0yi9jhKUvC9HoSwttB/bNKJc1D/8rDruAe/GapVxRlS1hWuCa?=
 =?us-ascii?Q?6IK6rAvjiIcOorb6A0EVDhJ+t2iTiAPts+zZ6U5gEoYXnbGzeW9FakAyRLje?=
 =?us-ascii?Q?mmGZAB8OYdFuNag5taXDsYsExcm6fRGQHWsSMscFs1A1Bki+0E+DoTo0cISc?=
 =?us-ascii?Q?No1alslNM6rQnz0jj7mjV0YY5TzmZYbPVJVgx6PBaqdBW1qThFG4yBXFJwm7?=
 =?us-ascii?Q?INJXG3sNbQ7rsjfem8trZWsk1vw0gQmk/oM2No/eCS/cnEisAhKPD3K9Pi8W?=
 =?us-ascii?Q?72K7uzkKG4hi9IcuGA2TJ9uT1QONHbfhIymM6Xoyx2wsLWNbG2loMWj1FtEZ?=
 =?us-ascii?Q?rT0W+JR1I/NeVNncaOd9iApJpEUEp1Fcz1Ch/5IT4sSUbSFYGBaJ/Vjo1t0H?=
 =?us-ascii?Q?c7BZoFsCGbGr70S+eJUoviKFmaOeJvJejlVMwmQCEGrorVS3qcb07dInI3sZ?=
 =?us-ascii?Q?XpeS7FU/L4UTSl6ZzhFDXw70SH41oYMFUN9g35IyKsd9YhPjqFoO+u0EAVGe?=
 =?us-ascii?Q?ta+slxCjBwVph3liUsOMvDkQngEn0QZPAb4zSve+Qv5kX3DP0BQfDRs9Hk7v?=
 =?us-ascii?Q?XRdNGIAWyAWpx2HpVxruFCn3RggIzWIJ0pQeIrIqTg2VF/FGXkKb9v6Q+HMN?=
 =?us-ascii?Q?vtXhAb74DutvbceQqsKyhrbwZw0/ZgWCojZpgXBEEHny5sYWnvqsEdHaeEA7?=
 =?us-ascii?Q?lB/KheXj62jkoFnRNuzaCpjvAX2KC4Zfjp+X3ONoAR1o+EeLXyyXIu6yN+NQ?=
 =?us-ascii?Q?Wnkdpa46mRQelSWNXU3l+7mBpFHvrn6dapoJEsExetxXrxDUyB2vX98d0QW4?=
 =?us-ascii?Q?eEOanw7num2PHwpECMPGT6sD0kHslIEiQLh+Lb1BC2Qm2S56sHFJu2sRDhLE?=
 =?us-ascii?Q?IqLDHgVDYDQBMMCorWB+WQETQqXqhR91OrlL7rf5?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52A11804F6993F46851CC2F7B951C680@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xbEvuj6RgmfAPRjXuoGFH8PpW/HfACPUCqytL3ErTra06Sd3sHPGuDoadJGKzvZARFRxgYqDWMJ6njdrPuL6y+ql07u/QDG0FVxQw5JY4wSWtCTXhWID/FMwFBWJrewcyUPvo5sHdLW9SU8b28QUOzaFizMZPm/Y6bjU18iEn4vx/AAiJp+L9ybrUPagcwXgNEVIGATl0PhE/Bphxyh4UI8HEobXk9I54dLtIEi9DzQ3K/PfEB/7DQDraqXLf2sxBQX0DW08byge9q3IG89k++77yYgBNKM61IUovEROa2Kw2Mi5vmjikx6i1PFXAHntGvaGPyHPHErKKOm6OHBg9vNqHtLFmjz8LkHYNM9Qkq+IiABx3tZ6JtdENYHDuN847aW4OKLUILOHCh4Rwxnp7RFwnGPYrmCwUdcRW1zcM2bc4In1rhGegYmfRNKStHdd6T+YP6pYrnI+s383HyOV5WE/B2DDR2H/iCEECxSfsj3MohSPHxfv9h9EHr0L6J9wcD9qYVv4tEhwJOUQxSCcq3BVKEYkRM6sg/xbQsZicA8y06GamM8MKkub2EJeDDT/W14Hiioyrp93pRiK5xnWvEHBisjc1NZTwombF6gP4Ac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebe7fe8-b427-4f63-8dfb-08ddf6eff3b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 20:14:20.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MNBWSKeZC0cBCOyTcr+ahY5jIPu7H4oFXfLpDi7/OHQloqChRm7aSrpjPYHpFL1ezkiXoefREyZhCQSGwaAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180181
X-Proofpoint-ORIG-GUID: gaKffyJhmVgEwiQSdW_nY1FJEY-jwrXe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4WtfwS/DvnBY
 8WK43rGx5KzgxxV5bIAb+f1N0y7bs1vWeG3HmEtOgxNO9m1vcS1Isx+7rug+qoWaqCYxA7dKRWF
 iYAbnyl9O/maiuhL6v51gCI4B23Ioh4BpBx9rY6uBJt1dx1DZRIpXepJU2x4Y2Q/I3snfNxhFe0
 K/tPKZ6+AhA2EQAVZuYxN1pgUllyvh2wKNowyP1N/yDbilj0vTu0gFMk165mWu98B8HWxloO/Kb
 pio4rzysOOUC0B7R9Bc7WX1H7y+c7yd7lI7Jlo4JXkDWmhpvpA61h194T2ivfph8UVfv+PeaWn6
 rxqYBYbfoB50tnr/KB4U90qlp7W0cUKVH/1c5YoVbXmv0Lh46dcxa7vwokpEgI69YCWzHt8926G
 Tcy9BmjvmJIaGZmgYO29aeA9snqmfg==
X-Proofpoint-GUID: gaKffyJhmVgEwiQSdW_nY1FJEY-jwrXe
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cc6820 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=o-NLrnc4QYQIKT9aOCEA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12084



> On Sep 18, 2025, at 15:39, Kees Cook <kees@kernel.org> wrote:
>=20
> On Wed, Sep 17, 2025 at 02:09:54PM -0700, Kees Cook wrote:
>> On Wed, Sep 17, 2025 at 01:42:32PM +0000, Qing Zhao wrote:
>>>> On Sep 13, 2025, at 19:23, Kees Cook <kees@kernel.org> wrote:
>>>> +- Keep indirect calls from being merged (see earlier example) by
>>>> +  checking the KCFI insn's typeid for equality.
>>>=20
>>> Is this resolved by the following code:
>>>=20
>>> rtlanal.cc
>>> index 63a1d08c46cf..5016fe93ccac 100644
>>> --- a/gcc/rtlanal.cc
>>> +++ b/gcc/rtlanal.cc
>>> @@ -1177,6 +1177,11 @@ reg_referenced_p (const_rtx x, const_rtx body)
>>>    case IF_THEN_ELSE:
>>>      return reg_overlap_mentioned_p (x, body);
>>>=20
>>> +    case KCFI:
>>> +      /* For KCFI wrapper, check both the wrapped call and the type ID=
.  */
>>> +      return (reg_overlap_mentioned_p (x, XEXP (body, 0))
>>> +      || reg_overlap_mentioned_p (x, XEXP (body, 1)));
>>> +
>>=20
>> The above is needed for accurate register "liveness" checking. When the
>> above code is removed, the kcfi-move-preservation.c regression test
>> fails (since it doesn't see the clobbers).
>>=20
>> AFAICT, simply making it a new type of RTL (the DEF_RTL_EXPR), made it
>> unmergeable. I assume this is because whatever was doing the call
>> merging was looking strictly for "CALL" types, but I honestly don't know
>> where that was happening.
>=20
> Okay, I've found this. The pass that merged the regression test's calls
> is jump2. Specifically, the jump2 pass calls old_insns_match_p() which
> compares instruction patterns using rtx_equal_p(), and that is doing it
> naturally based on the RTL expression, i.e. matching RTL codes for KCFI,
> and then matching format (KCFI defines itself as "ee" format, i.e. 2
> expressions):
>=20
>  code =3D GET_CODE (x);
>  /* Rtx's of different codes cannot be equal.  */
>  if (code !=3D GET_CODE (y))
>    return false;
> ...
>  fmt =3D GET_RTX_FORMAT (code);
>  for (i =3D GET_RTX_LENGTH (code) - 1; i >=3D 0; i--)
>    {
>      switch (fmt[i])
>        {
> ...
>        case 'e':
>          if (!rtx_equal_p (XEXP (x, i), XEXP (y, i), cb))
>            return false;
>          break;
>=20
> So if it's the same call and the same typeid, it'll get merged, otherwise
> it won't. And I've validated this now with an addition to the regression
> test. It now makes 3 calls, once with typeid A, and then 2 calls with
> typeid B, and the typeid B calls get merged.
>=20
> So there was no special handling for CALL, it's just that CALL didn't hav=
e
> the typeid associated with it, and KCFI does. RTL working as intended. ;)

Yeah, this sounds very natural and reasonable now. Nice!
>=20
> (But my new mystery is why my new KCFI matching typeid merging happens
> on all backend _except_ arm... I will investigate that.)

Have fun. -:)

Qing
>=20
> -Kees
>=20
> --=20
> Kees Cook

