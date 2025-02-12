Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3720B7F0;
	Wed, 12 Feb 2025 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372776; cv=fail; b=KnrNwE1E3oY3YBjqd6jhnfBf2HAvNYnhJIVGCTrwv0Ltxi6IgRS1c+K/IO9k+AN/9RhpQVbpInaFhy+j+lmB3m4W+HCKo+A9IsHr7tsLQxn4Ozb/w+85lGJYcFKfIQ+LkSoG/uK16WmSYg9SMdgIN8H8HoCVS/mYqIYmOgD3LAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372776; c=relaxed/simple;
	bh=axdB9ZGeBps30w5L8LRMgOg31DIPfC7h/6s3gAJ8Jmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kXTZVJFZQ4mSXwEwYOOY+co6bgIxEMQWni6gjYmBY7dUnuqqjnCM/x3Z+MfQbpXHNFU3ZtVOevziLK5DdGcaxlssoZN4xHmj18NcbkxxVW1rAXwB/Ksd1dJr1DIfO5ORptPfwTFc0EPzDOvEt5oBhG0R0dGUM5sqyMY/84O8eog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k5J/MJPt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dii03SEh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k5J/MJPt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dii03SEh"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEtaSi008419;
	Wed, 12 Feb 2025 15:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FAo3bBK2zDEK8+fMrF
	buTWU2kzqVR+0gEfnyzcS6TPY=; b=k5J/MJPt/uEgMCUlfZnKgbq5vip85LFZub
	ZpuBjSu7iW3sDwx8FIV2xjEd3LSVrNt1ez1ktsagqW/d2FPEmK0cS07g4jZfdBw1
	Nab4jQUQp8u3fSoRxizF2Vto+eVxHmEaW3NMfabvcJLPyhMfQQFeeml9PcDztlfY
	O4zKpTSWUa3qDT2/Yxj2xrlf3OeW2WshvIo5E4kRoWZkEUjnqdBekhz/a1/lHA6V
	eatH9Ws/hPZeHIAMoYS3pTCjYZn0W/IJxn+GXPvp6lM01QgSansgE6P3dbp/AIh5
	CcLLnPsaIpFdlLEKD9BfT5zNqJqVJRkyVG2BOZr5CPnVgTZMPu8w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t47ge7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 15:05:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CDlvKr012797;
	Wed, 12 Feb 2025 15:05:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqabtsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 15:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIoa3BqJMFRplj5/O2mI9dqxJW3WKsqweljGmVsWi7Y3oYXa+qxG309y2lstKd2cniX52Q5wZhJJ14MsSogq5DS8Bi8+eb6FF8PPLOPrclSd9dvToNBZJM8drIwKZXYX88prDOz53Vyvmmi06NpJXtRQBEiiy6xSTGyZ/lhWw4c7qd3llrSwxJy8J9YyuUiw2YVMLzhcswtFIUJ3+ku2FFgxgNnjdclgS6j4kRLchEvYJTyAzX8I/l3ygiZA3i/fbwlXPeUDkzIgef4z7udg1aA+culoAXtEfPny6VGRdjN7u2t2sOdeHFVjKS3klCyDlm/tncw5rpRUK/+dX9f9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAo3bBK2zDEK8+fMrFbuTWU2kzqVR+0gEfnyzcS6TPY=;
 b=gPmpjCxV65n+xbbd1f/pVSmM/flJJfD80dYxf1d0pfWYZ+zaOQCeSAhVE+O17TW6ZZC1Q9Z5EsDa9IxXJxPcn8nXJQTDbfw6bhUwT7W5U+oYGmEA9vbkdLkfO6BFGxhSV8NRIJZHWHvmCouWRqY2livQOMHLfSBe4NBwo/amrOokR+69wvIB/sFIe7W0sG+ch/+74HyhmOsRxs1hozAM5PEy6c722AzWDruCkh4NtWbQUxDgEtB+ENx/Hz8wl2sCqHSJZ+A6RIQ3ILqJHyVBHYIEasLFq/cHqziyG7mbatbv1XJTS2ccq8qYvT0FccqGYy6aKi7hcg5ZoL9SNPgP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAo3bBK2zDEK8+fMrFbuTWU2kzqVR+0gEfnyzcS6TPY=;
 b=Dii03SEhxv/r0gekw11Zk+M4axRzQxbp3qmC/SZSLMvFbhAPFxHlti4kDYhmIz7O5C14VFB1NKO0ETVcNWrc6LxfcG5Ei2Zlx6HDFm/xBvY2wbw0brFCll6fbZee248TChP0jdQrb8EgPjeUoX2Pn6+e6J0dJy6I2AFLwYQ1Dpo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 12 Feb
 2025 15:05:10 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 15:05:10 +0000
Date: Wed, 12 Feb 2025 10:05:03 -0500
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
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
Message-ID: <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
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
References: <20250212032155.1276806-1-jeffxu@google.com>
 <20250212032155.1276806-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212032155.1276806-2-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0053.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: e2334e02-2c23-4fbe-6a4d-08dd4b76a4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jM393CBKF9RzuozuhdkoJA9eJ07IaAG1eoG63v61RHkVa3z7CUFK3WgsNwiU?=
 =?us-ascii?Q?OqKyX3kSIJ9535CGF7+kQrlMZt/toDV9/VaIfexYVDZUcjDmD9+kKc9b6sS0?=
 =?us-ascii?Q?+I7gGFS2RrbUyt9O60jgDPwwNq8eJTxAg8imSnSf3VSPrZHb7rABrdOkjXSq?=
 =?us-ascii?Q?LFedJiLNsjTfww6g+zFzVouT8YF4R8oGbx6MDYHzwccErQxBtZe4vy9ROMzb?=
 =?us-ascii?Q?UzU62xKV3D453bSI+wNBOcPNYLw3yEqRNNsHTJAX/udZgEisjtmAlgO+xpEp?=
 =?us-ascii?Q?4dIZqsCmlRbQGPMarGQGSyKT5Gr63pTz21O7gHtL+RXJ6gHh0TRJoVYt849b?=
 =?us-ascii?Q?xqHgksFuEn4WRM7icp9ln4rgTmtfhCzAJ6mbsnvDpGp3+HbL9AHDWwRfXJTS?=
 =?us-ascii?Q?gARX18w0+NL9WSGgq5KdDCgLbyLu+BrmKtZ5uHlufWt4kVCDFGsI0lz3NGne?=
 =?us-ascii?Q?gUweQSVd3zyrm8Y8Q9AaBb307d6nu7Q0VgLsZUNydDjJt3KFlXH9nKmKdan2?=
 =?us-ascii?Q?jK3NcdQSCLCaHlLp1s8N95XxcDAIbR341/PO5mPFNfJjJ18lojB7X9ButJ/X?=
 =?us-ascii?Q?nWMulnbSrqZx+wfXohzZapTfgSICgoHxvLPEWSA6tXGBTAsnRWcwJGj3OLOZ?=
 =?us-ascii?Q?qGtNwLPNmHCXXVBIQIKjMvrkPLmbPnkMx7DLn6IGed2UlF6fG0td9mrcPtkL?=
 =?us-ascii?Q?LiXeYVptnwZKAv2ZTdxr2CBaLtD1+7XEt7kX9JCycQ71tArxWYtwEOyykiGg?=
 =?us-ascii?Q?tYhxBsJYFOhd1L3UmfFzI4GapyMDgiXUjNWpcoD0IzN4Vnnce//gpMCPvoN2?=
 =?us-ascii?Q?tVRaYr7XyByyzBYoDD39aGqrrTpplYGWBVjHysjLxeKt9sqNdr0JMcXIIeF7?=
 =?us-ascii?Q?GIotp5k2AKf4YhARai7FAKtAevF7BKi/ncierLizKXPlTXgmVtlehGz/DTkL?=
 =?us-ascii?Q?TQIeIUBLJvvM+4RG8ZV15SfzsJjtxXlYeXwE+LE2zCJ9eI9wVzgrnwv6hvKm?=
 =?us-ascii?Q?S2U7Fg3tS0sV2XVLBv8myUAA3EYKP8Cwwj4k1xd0jrhDhncMfyigiZa+lo4H?=
 =?us-ascii?Q?ErEPIfLLorKszaJJNyzbd7PDiBTde6Pw8Cb41pnSEs3FQjb6lwvkcAnX1lj2?=
 =?us-ascii?Q?J0H/mD2l/GoLQFcR0XbUyB6IlACF+63P1JlkCGi5qQ7lV2MU7I+lOWE2vHYm?=
 =?us-ascii?Q?xUngYeOJaMWla8mTunYJjohj9zQlgfvgdzjGWJPOHEJPVHJHG1i15CqdGbO8?=
 =?us-ascii?Q?bBgyMBHnxcRyfbliysZF/rMGBxKXZXy6HMJ8rnZRx8LTXSGPJGuMqFkoQc51?=
 =?us-ascii?Q?zinNw5a2jJhp/DTTTasVyH/tTW2oaTSC5kSO0RfZeVFpkqSr/zhYLGWd1PdO?=
 =?us-ascii?Q?PWEfgUGwQQNsxsBGi3HaWJUGLKsRvTb2zcvhUi3AhZSZKVB4AA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qNtMYjt3Utzv86Jd2Ee5x/dHPX2Z2WiSK618sNb4iCD+kiEQEqECKRqPI9u2?=
 =?us-ascii?Q?i1NPpRbCkU+yDSdXP1qx3vMoe+ooK89PoswCi68dwtsRMp1CNUqPyJDJIn1Q?=
 =?us-ascii?Q?0+A73fFIszooN5W1lSokX8M0WWas3Yc2eBInrZMTwBTLNeacQfrTesmZKqtE?=
 =?us-ascii?Q?aPbHqUxbIiFmtMj8fOVfBwV3wjT7NRBA1afbwhc66b8HRGFHd9mWCChwTaTr?=
 =?us-ascii?Q?epS6gUi3hwDQbB/E1Xfnw8B/kZ3PHk+wYOWKT4bGGr3gZ7iT/eu8/RliMLII?=
 =?us-ascii?Q?gIiKSRgrD58x2iZAUYORy1i4KLgpewY4LiCCMulFSAHTYKLjvc37ZQyXijwU?=
 =?us-ascii?Q?4J2giATDePU2SZW87vegLNER8i2axJjVATTYTSE2HoNhHPvFtfX57EtZATZ1?=
 =?us-ascii?Q?HIwN9enlROJ5Asl97NF4oyVQlTJJUl4NZtvNBe8AoLyTb/7DO/OXzvM5S+PF?=
 =?us-ascii?Q?DgpVQKVxC2f3r5m/oVQVNUPwNUSgeto7E2SI9jldekeigSQDmj2d5BPC9QiO?=
 =?us-ascii?Q?qqDCQg5qQIUIhs/T3aWEgIQQex2eeFgkVHJ0m3FmYxhVfZ+LOgIQB2XXVvB5?=
 =?us-ascii?Q?eHSk1hsjvItyh5YgX/6OOirxIAu+M9tD4my78GayI5oIDt7iTvDjeYnBQFJ+?=
 =?us-ascii?Q?3HA3hJS1WqFvKSgpOwvdUFlUNS6jKlq0k69TgMtG/QH41b4lWJt2YCBcnug6?=
 =?us-ascii?Q?QeTeYf+qycx/BOzNl7eeraVxFN5TzO5epIgm9yCdZBRyvaA9KeTod2mlLtyU?=
 =?us-ascii?Q?wytVDG6KDAuEU9uK/TUF2l38sqrX3zFJlQePLlXvm7XcEEI7Tm/8hI9xl0bN?=
 =?us-ascii?Q?RLRPBMgrzkgXHfAiPpEz+UwxOuPsoyd+08MfHVCF4OJvLM8QJomLL3FO9Jbw?=
 =?us-ascii?Q?vhWXsdyTqism49ZUsyFa+PuPx3Vj+NbG0XzSu+v74hQCoictSp/6ImyHQvL1?=
 =?us-ascii?Q?kneVs/mH1ppygHoQDm5rx5RQ9POsTuCyES/ovGkGRPVTUnNuTQpQ7pNZx4h5?=
 =?us-ascii?Q?pAT3P7JnZ/nv164ACO7g1ILD+KEELhSKasEKN83KXPBWafkSPa/1gYwALVm7?=
 =?us-ascii?Q?tSeliC+DBaR5uYfL2znhEFZLnozvM4eMMX8uT/4QLcD0nGiMggp7Toez0W9d?=
 =?us-ascii?Q?UotCIqlq/v6uIZsfyLl9tGZpbOX4DJpbq1NaoHDUsKceC4cwcvDTnKU/GrQZ?=
 =?us-ascii?Q?1RpWq9m61nCJJJCdWLKyu8UhGOHeLqZy9sBXEgm6l9Dx9Si6s52dc/E9ae2p?=
 =?us-ascii?Q?0T/MWVMgH1cCIAMogWvRGesX5w4BQ1Lf64TaD9kMcL+MDJtY1sr/zimgoSHT?=
 =?us-ascii?Q?19XLOOJjU/TlGCRMwWxJAWJQjXXNOo5wtA5U9mz/UJLyA6vv8qJjfhrm6626?=
 =?us-ascii?Q?C6cDlfRBZuOkkYKmIckmguPjtTBr6+f+W/kazJsgnpqqgTZq20Vpc6WUNqa5?=
 =?us-ascii?Q?BUUmtJA6gqL27chmYvDBZWBGktL7QCqdn34tmagRrFCburWKvRrLw2DlaCwE?=
 =?us-ascii?Q?YAmyhBs1VVWAlzs3x8neNzi3rwkPRK+A17dxTxGMnJ4oKznRQFsq1mDFdVQA?=
 =?us-ascii?Q?uUfjQPBA4zWWo1xIIDa8K3m8GNUsYGPV3BM5n8k0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7fjX4LBh5pkc78Q2mVD4HbyPgsE/FdNHQe78+Tzq1wxg0tmOQofiDTGFqJJNxUBMy5XFv8Wsxq5PjfPXfdMIjwPbMTKTlxxYvcH1lOYTjcz85/kNiO55okTzgraPArAO4YgA3q45VSRqT+8x26jqX0D2iOwuKIoRynx4fPFD+pxFTbko3SpMhnq1q5Z63H49duH24ijoPlpvs+aYPqLOr1aNQ9aZNt3TCOVhsw6gAE1Oklv7sumMno0Qon5xYnsZ6W4e873+5WTAVV6smCFrxODu/Wk4z4twkgALNtO++ZMftWplmPJ3hbBkh2ba3niamrPavQV2fs+AlNg56+HANLOq9Q9UBXgykOU/ZYNhhTNOevKJLJbSU1SBkvVmbt7FqoJeM3zGstG4sGQ03KWkP94MgO3+8rQkSY9/bLL8P40wLdRsr+e4ryt2+RwAW9D499aDgvqymw1rq05alkOZiXUKxMM1+s/arA8GcwouEsKM+NTv3+MJnSuOruMRj/v8cAWXQa0I+tBoxhJpDIJt3g0XODq3JV/5YdANk6vns2/rEg7rEB/DTTs4FDmVLKTHkW32G8k6e3CA/1LWlD+ZgoVTUIQEsn497pZcnilVwFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2334e02-2c23-4fbe-6a4d-08dd4b76a4c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:05:10.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kE3eH6+zdI9P1iLS7i6e4CaXGuAQD2W2nojbjXe9qQC3In40lp7Ktn8lbcMEiIsi0BOKgmXf12xfFwDSN5/p4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120114
X-Proofpoint-ORIG-GUID: z0X-xhT8RajKFxVHBnv5FDcWuUp05C-5
X-Proofpoint-GUID: z0X-xhT8RajKFxVHBnv5FDcWuUp05C-5

* jeffxu@chromium.org <jeffxu@chromium.org> [250211 22:22]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide infrastructure to mseal system mappings. Establish
> two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and a header file (userprocess.h)
> for future patches.
> 
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
> and gVisor are also known to change the vdso/vvar mappings. Consequently,
> this feature cannot be universally enabled across all systems. As such,
> CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.
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
> Additionally, this patch introduces a new header,
> include/linux/usrprocess.h, which contains the mseal_system_mappings()
> function. This function helps the architecture determine if system
> mapping is enabled within the current kernel configuration. It can be
> extended in the future to handle opt-in/out prctl for enabling system
> mapping sealing at the process level or a kernel cmdline feature.
> 
> A new header file was introduced because it was difficult to find the
> best location for this function. Although include/linux/mm.h was
> considered, this feature is more closely related to user processes
> than core memory management. Additionally, future prctl or kernel
> cmd-line implementations for this feature would not fit within the
> scope of core memory management or mseal.c. This is relevant because
> if we add unit-tests for mseal.c in the future, we would want to limit
> mseal.c's dependencies to core memory management.
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

I found it odd that the history and V4 links were not here, but I
realised that was in 0/7 instead.

> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  include/linux/userprocess.h | 18 ++++++++++++++++++
>  init/Kconfig                | 18 ++++++++++++++++++
>  security/Kconfig            | 18 ++++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100644 include/linux/userprocess.h
> 
> diff --git a/include/linux/userprocess.h b/include/linux/userprocess.h
> new file mode 100644
> index 000000000000..bd11e2e972c5
> --- /dev/null
> +++ b/include/linux/userprocess.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_USER_PROCESS_H
> +#define _LINUX_USER_PROCESS_H
> +#include <linux/mm.h>

Why is this in a new file and not mm.h directly?  Anyone who needs to
use this will pull in mm.h anyways, and probably already has mm.h
included.

> +
> +/*
> + * mseal of userspace process's system mappings.
> + */
> +static inline unsigned long mseal_system_mappings(void)
> +{
> +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> +	return VM_SEALED;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +#endif

Looking in mm.h, there are examples of config checks which either set
the bit or set it to 0.  This means you wouldn't need the function at
all and the precompiler would do all the work (although with a static
inline, I'm not sure it would make a big difference in instructions).

For instance, you could do:
#ifdef CONFIG_64BIT                                                                                                      
/* VM is sealed, in vm_flags */
#define VM_SEALED       _BITUL(63)

#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
#define VM_SYSTEM_SEAL		VM_SEALED
else
#define VM_SYSTEM_SEAL		VM_NONE
#endif

#else /* CONFIG_64BIT */
#define VM_SYSTEM_SEAL		VM_NONE
#endif

Then you can use VM_SYSTEM_SEAL in the system mappings function in the
list of flags instead of having a variable + calling the static
function.

I didn't look close enough to see if the 32bit version is necessary.

> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b..892d2bcdf397 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
>  config ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	bool
>  
> +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS

ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS is more clear.  HAS may mean it's
supported or it could mean it's enabled. SUPPORTS is more clear that
this is set if an arch supports the feature.  After all, I think HAS
here means it "has support for" mseal system mappings.

I see that both are used (HAS and SUPPORTS), but I'm still not sure what
HAS means in other contexts without digging.

> +	bool
> +	help
> +	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  To enable this feature, the architecture needs to update their
> +	  speical mappings calls to include the sealing flag and confirm
> +	  that it doesn't unmap/remap system mappings during the life
> +	  time of the process. After the architecture enables this, a
> +	  distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage access
> +	  to the feature.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config HAVE_PERF_EVENTS
>  	bool
>  	help
> diff --git a/security/Kconfig b/security/Kconfig
> index f10dbf15c294..bfb35fc7a3c6 100644
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
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  Note: CHECKPOINT_RESTORE, UML, gVisor are known to relocate or
> +	  unmap system mapping, therefore this config can't be enabled
> +	  universally.

I guess add rr to the list, since that's also reported to have issues as
well.

> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 
