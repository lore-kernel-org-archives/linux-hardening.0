Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5118F2D8;
	Wed, 26 Feb 2025 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547625; cv=fail; b=SiavaYznf2P2iu/aBk+VBMmqDJ3j98dvWp0pdb2YBcz2IT38N9DvLpDDuUcuhIpdhVg3Na6+vw4qWwu7zjcNTr+GaQRrz+4MbuBCC/fFakYLHxDDGfjZHvkbeNruaOH02Kq3e5cGxSM+jcBJw/2DVn1iNBQi4PgwVI/dMAg1dAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547625; c=relaxed/simple;
	bh=/9vEdXbDXznh+67Ln3LbDbZt/4FVVQe5tHvkCsTeqUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tg5cW4xky00a3/kEUuBeOA4jnijjLssZAR765hd8tJXAVJHci6kCgJj+tUoPAX25LtiMT18CTIl+GTWwjvVRteh3ku81HYhOKG0fciKYVvFaEkNhC/twUd8OHDVinnfZwayztpG+SmAtzWgyV9WWDzn/acScmlLIThHTlL68ncU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MK3IkgUE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DR+fC1jF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MK3IkgUE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DR+fC1jF"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5Pnmt006832;
	Wed, 26 Feb 2025 05:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=J/HyyxRks05rQBLqtqMXSI+u3QGyPIRoA7dtNNFVqqY=; b=
	MK3IkgUEz6HYiOVvvZmGEfHZn+DJlWHwmK5EkUyOS1tv3a4E8Do/bAR8n9FVZ1KI
	F/nzkrBVKnPEprFyg0CMeRwC5zdxdpV0QyHDsOn5I3BVHgnp8cDndVidqMGuobo/
	0TC1RZJpVlgrHyJphUnMZyd9fEBQ2+OTZ9VZmxT1fhQaYOcD6AZZ122WNhRulgBj
	RL3w6hBQiwM7+oBAkzc/9mLXaKw4wsrkqlP/ZpxV2PGUV8pv15FKmzvGLx8ogk26
	gIr86SOg2pchMpms2Jdkeg8SYXzlGPpxRmrR7TFB90MvI4F9Lx4UEZlCfjLHUwqz
	eUfq34hn8uzHxISGZ1I/hg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psc8drd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:26:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q4C2nY007534;
	Wed, 26 Feb 2025 05:26:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51g7n0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNkzXPEPQIo0vfPb49cIRHC2ZUwEcekao55QNeVFhDQjMs1wdPTQQ28yZgcpFJ53Tpo8frf1r5zBL6e4lG+M8oCstom9WfkSQVlgIg0ix76yCwZWl3KkA1IpFSYNANaVbvHDSnCz6Ji7vegL9HURAIb2biYZ/r2OEhI4j48TCcAUSXUMGEjWXc9mUSgUwEj0nY2BaBho8T4wpi+uBW9C532pLXpR4BReixEwXL6SoAHWXvZ4u4clPlNuUi0/kF9PPC9s5GitMZ1jC+LWGlTOBhPaP8qPnmAO0/vvqfJ2sBHNKMemv8o2KVb6onfInqvujgTh7wnybYOT06R82nyJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/HyyxRks05rQBLqtqMXSI+u3QGyPIRoA7dtNNFVqqY=;
 b=VEpye+9FpAjYHaIYt9pPYBJBUIr7Pw8RKRlpaTIvKvZPkdxVp/bgvjoaRnwel+6e1yJY0Q6NblSGooWsLeiYAq8Fpw7YEbyLZBkwdGWt+wyxQtyAwPTcqYk4XOuJ7n/y5JJs14jvLOABUAGqovoDrIcyjmPm8fQ5Kv5e33K7XDmPZ2XkN2cQFkekYzUIxW1EylKQVZYP3gV7QqSzMZmhNIJcQSpYz6DIYs6yRSThytCrh1vegUHnQaLn59TgoxULrIqlBx7fzFpqB50JIwuksa0cs6eEHcHGu8a3ZAYf2CMLdYbGaZC/r+8UrMXSiKDG8+hlY9uf8Bllk0cD352K4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/HyyxRks05rQBLqtqMXSI+u3QGyPIRoA7dtNNFVqqY=;
 b=DR+fC1jFt+a5px0r4DKQGOLhKmVQ3yxubvjG1463QUm0w+V5iGEGBCFD2jdA5al1dXLNbtx15UpLynieWOLu9iH98O8NJlsKFOBDj2g/1GiEJoyjlAdfrLJidQzhis85W5rrroKTK+hIEo6Ol9Fl1x5Jzelt6IVQ0vZhCAkASo0=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 05:26:04 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:26:04 +0000
Date: Wed, 26 Feb 2025 05:25:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
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
Subject: Re: [PATCH v7 4/7] mseal, system mappings: enable arm64
Message-ID: <ea970928-ccea-4314-9cde-b64fa1a7824e@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-5-jeffxu@google.com>
 <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local>
 <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::15) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: f3add11f-7264-4c9c-6631-08dd56261041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmxKelJ5UGYzQjZyekdzVGZIZlBmMDNQQ1FpUXR1U21rbzM5U3k2ekVRRjVT?=
 =?utf-8?B?UGp0SEFuUC8veXBwazVKcmxzWnhhdzdONnl5cjRHdWxGRkVsQm9xY3A0bWw1?=
 =?utf-8?B?a3NZZytuNTRlRXFVVndRRzNQZlFub1RqNXJ6V0taZVUvRkc4Tm5HUzRLa1ZY?=
 =?utf-8?B?aFRQZmVEZ2g3eVVVL1BTY0R1UEtEQ1VzNktWNzBTR3oyaW55SVVqdm15Rk8v?=
 =?utf-8?B?Wnc5MCtmZUJtYVIwejNkdnNyZjBiUkxqcHNMS1RWbkxVTjUyRUcwSC9MeVJS?=
 =?utf-8?B?SUFlNUw5NDR0RFN1TXlteTNUc01Bb0RtODg1NUFyUWxqRGhJK1VnencyNkdi?=
 =?utf-8?B?azA5d2YyQXFKZGJmNE9Cb2cybUJNbjhRT2hRUGRZdnUrc3ZZWlBUdS81UEx1?=
 =?utf-8?B?KzB2SkJISTNmb0JFWWZjMXV0TjlIeWUxR0JMUjFiUUEyN0dzRlYxeThKM3Vw?=
 =?utf-8?B?d1FuSWs5M0c1K0d4WFBpcU9KZ1Iyc250RHdVVyt0alRzWkRrY1NsOUVNYmNX?=
 =?utf-8?B?WFU2bU44WllkakdUbDZiVWk0QlF4K2RDV3VibjlKeU1WeUYvalRLbmtIcndy?=
 =?utf-8?B?Ulo1eTYyU0hOaUJyTUdsRmRSRTJuSzR3TVQ1bTRBaTI2ZzhGYndab0d5eWhW?=
 =?utf-8?B?NXhJOGNPNFJDbndNYVN4WEpxeFpjaDFRa2tCQlNrWWdVbU1oWU56TzMvOXg5?=
 =?utf-8?B?ZFhib0dBL0hzM295TGFXZmpJWk84a0dzUndCZ094ZUVuNDA4Smdud254QnZa?=
 =?utf-8?B?d2pLN3IrLzNJV3ZEN05IYk52R2d0RWcyUlEvYllvQ2pRSERLRHh4L2tvQ0dy?=
 =?utf-8?B?cXBSbysxUldjd2g5ZWl4ak9JcHJhM2o4SGxnUG5xSEg1ak81WUkrajhaTTNE?=
 =?utf-8?B?NHd0UW5ZVUdBTWZzTitRK2drUFpseXhQMFlVWUZtR010OVZrWXB6NFpDSmF4?=
 =?utf-8?B?Y21nTVh1QTJ0a0dnLzhvRUlzc29tc3RSdEtIUnVoblNCd2lSSWhiTEJIUVFs?=
 =?utf-8?B?UUdWVCtxTmpWSmljMmtjZVdDVFhVckVrZUJYcEZpaFV4aGVSQ3JJZUxBSWkv?=
 =?utf-8?B?dEZDbG9pcFBuUEVZOEdhT3ArU09nV2VXeEp6Rk5hOTNvalVQT1pFcmdaUzBw?=
 =?utf-8?B?K0JncXFFNDNJb1huNXltQkw4ZnpJRjRnZzZoN2l2Z04zY3lEbXM4L3ExVTFN?=
 =?utf-8?B?ZTl1cEliMDNITGhZSUh0L1QrMUg1bk04L2VwYzQyUHc4WUxNZVdTMlhzalhv?=
 =?utf-8?B?MmcxUWI5b05KSjRXZ3RaSWxRWEhTTkpiZUF6K2lKN245NzFGVUVMeXN4SUlt?=
 =?utf-8?B?a2k5UHM2KzZSQXUxaDQ5dWxFNWJoS1IvT0dIT2UwS0RBN0pRRm9jMW1TOFJu?=
 =?utf-8?B?VU1FSXRNRVg3RnVlWVJEbTgwWkkySDJhcmR2V2FWcmhVY043cmc4VWo5NXd6?=
 =?utf-8?B?bmd3Vkk2VThIWUlaUXp2Tm5ZeHE0cmVtcmpWWW4vOUxXRzl3dmo5a2l0cTRG?=
 =?utf-8?B?NzdmU0l1TlB4RWV2d2lEVnlPS2p5SHpYOHNkZ25rK2NPaEdnTTIxY3NNSzk4?=
 =?utf-8?B?elIrY2xiWWlCdFdFK1JZNDUzQnhtUHVtS3lTUkc3MWtNeFZZWkpaQllYVUVB?=
 =?utf-8?B?VmMyTENtKzl2Q2FaaGhBUXVkYWNqeWg0YUpPTkd2NHM1dmIyTjVhVHlNOG05?=
 =?utf-8?B?MTNnUzZabFYyYUtwL3FndFVKS21ocTJjNGdVbXBZdGtUYXFaL3hWZENwQTFh?=
 =?utf-8?B?MWdHUjlTSEJVSUdzM2xhMVpRUUxFNVRuU2xnaEwwL1oyN21ENGFFNSsrbU40?=
 =?utf-8?B?c2c5dE8ycENKTDZVOFlQQm5GT1FPTzgrTnZLbnhPVW11T25xODE5bTlUZ3pP?=
 =?utf-8?Q?5Sl4pWYQ8Nz7j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWJYL3huQllHRnpWRnYyK1B2SW1TaFhDZHNjR3g2S094bEhTSWFlTGNpclVK?=
 =?utf-8?B?eUhERHczYk1WVlFIWFhyNlFqRGNkNmRPYXBBOUN5Y0o4YnNuVFBqSW9UM0xn?=
 =?utf-8?B?NTNDRWlXRzRibEYzd01PVVIzSjdTRHdiV0lNRnRHQks3aTBYamwrTHA0WVpK?=
 =?utf-8?B?R05xUkZYOWZOcU5Uc3pEdDBtWVV4MXoydkJyWnBiWCs3VUFBNWZHakV4R2lV?=
 =?utf-8?B?SFRsOUdKL0FkOThGNUZEYXRnbXp5YXpQdlFhZ05zdlBUVmpsNEZMMzdMaTlW?=
 =?utf-8?B?MkN0ZWhrVU0zVENKZDA0amNEQjNUdzVGN0NmRHY4d2t4c0NRM2NFVnpmbW44?=
 =?utf-8?B?V3pOWDBLMldBZ2M3L2xDY3F4K2o1dmJueFp1a0pUQzNNSGFkT0NBQzBHOW5l?=
 =?utf-8?B?VVZvSFhDd1ZDR3JjL25uTEM0eDNjNTVpMk52T0c2aGdRWDNaOGlZa2wzWVVZ?=
 =?utf-8?B?bFpDaXkwSkJqdUdjQ2lGaGNNcUxubTBkaGI2bS93NXpVYWN0OXk5WlBhOVZZ?=
 =?utf-8?B?dFE2a0NlejZRb3FBaEtpZlZMeTVIUFpLU1lBTnhIekY1d1h2NzlTblozaHND?=
 =?utf-8?B?KzZZc0lZanBSUkNwUWxnMUFJTmtFVWgwR1pnNnRnR2tIYnpWTXJYUHpRTVVm?=
 =?utf-8?B?Z3VIeDVOa0dWSk1pL1NEc3NKSnZOaXJRQll5MG9DVURBU1RLUHJ0dC9hOXpr?=
 =?utf-8?B?ZkVYOWJjak5PTlB6b21BUXdycUFBL2llakJBVjZxRE5KWUR2UFJUTFljb2RE?=
 =?utf-8?B?ZXM1bXRCeXp6bHNlOWo2NG9tM3ZFS3M5a0wrOXZNNXBPcTh2WDZqSGh0QnRJ?=
 =?utf-8?B?YnhZNDRCck1yZk85b3E5QVhDd2lUV09vOUk1T1o1MWVXdFgycmxMYmwwLzNx?=
 =?utf-8?B?Yk9rRXQwZi80S3JQa2NHRFlUV3dOZWFKTUlzcWNHUnZNN0pQdHlkVmZVSmV4?=
 =?utf-8?B?TDhqUHJnN0ROQldtbDZQcUNoVnpUa3ExV1k0U0xQcStFaGdBU0VqU01kT1pn?=
 =?utf-8?B?TWxLWDNGTTh1RWFKWXV3bzJaU3ZnenY4RVk2cDFGNFFkWklGaXFrdnp0bzIr?=
 =?utf-8?B?UTFDa3p1RFcrZWVWeFRDZlpKUldGbWQzU2xVSytoUHNFQ2hBV2p5ZEg3VGdw?=
 =?utf-8?B?cGdPeG96ZmRvNHhoZmJwNEJpajEvbTN5T3lFRDRsRE8vWFZyeTZMMEhualhw?=
 =?utf-8?B?YVVmWmFMaTlxbXdyNm5WS0tFVlRpOHQyN1BQdW1oY2dHc3NnQmR1ZndGUm5z?=
 =?utf-8?B?MWtsWU5wd2xSMXovMGRnc0NxRHpPc2FCbzRyY09pNDhLQ0NiYXpmSEFMRk1m?=
 =?utf-8?B?d0xQSGFkelhJU1RpeFZZSEtlejFpWmZxa0oxUUoyL0RXcjNOaUhlZFYza2p4?=
 =?utf-8?B?bHpIRGlWUzdaV0RpKzcyczdDckNkL1R5bW8zV3FtR1RvOW43b0ZreXYzcDZh?=
 =?utf-8?B?U1FlMVpMMDR2U01OMnNtT093akdYVFNsay82SFdKa0xJM2I3QU9kV0hMdmt5?=
 =?utf-8?B?c1pFelpOMlNidGMyNFZlVXcvS3NyL2ZLT2hoWE1TQmcyVTZCSi9wTE5Bb0or?=
 =?utf-8?B?bmkvemN4V3YrWU84WGpNNjJVL0JjVEREV2lFOUpwKzJuSmhOYTJaOTBOeHUx?=
 =?utf-8?B?aUhEcHJBTXFpZUFLRjNnd3hNZUd6VFlJRkFqSk82OEJCNFpDWngrc0Ztbm1z?=
 =?utf-8?B?ZzhmVThzSndBQ3lTK0QvbmVad2JRZFlKMzA5QStTYlZTZGw2cTVLeHZYRFJM?=
 =?utf-8?B?dVl2WW5Kc2xDSnUwVnRCWmE4S1RoNHVrbkR2SHVhcGk1c3hjWnVJS1RrMjhD?=
 =?utf-8?B?VDRCa0tPVjFvNHRnSWNKb0tpREJHYWFIODhBdGNnL2VWeEdqWTBRbjhjbTVE?=
 =?utf-8?B?anlLNkxESDhtcW9BSkZBRWg3ZmlybmhzbWV2WER4SnZqdW95Y0V6c1pQQVlB?=
 =?utf-8?B?SGdiOVB3L2NQNWlKdWhBSHlkMjFuWkRWdTB0NXhKN094bllkZUJHMzhkWnVa?=
 =?utf-8?B?YkhuU05nMHY0MnNHdFdNWFpNMHYra0JHNnlRMTJHeWxGSmk3aW45VVB0NHE0?=
 =?utf-8?B?Mm9YaWV2WWthei82ZDBSWS9tV0ZzVS82SjYzcVJGRFdzekg4dGJHWTE5MHFP?=
 =?utf-8?B?ejdkWGJFQVpvWGV2eFcwYlh0elMyVlRuc3hmblBJV21pWVNLd3VSQzcxd1Y3?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d1GdgkwD62cNapA+C2FpN4d0fc0BRVOKoKkjuVzGRRPR9mmQqwigpMpii2/Pni8XrF97orIAWeBsTlaxANDLvcK4CUwUR7EWf1JOF10KbWJyobjAx2gtpT/UZNGQ4g76H5Fe7t3E4qdw31C4fbs7RaP2TGQORskdiX0c20FZzdiT16hnWD0xumlKC4ovN+Pza9mMhJJciw9wz3gGl2Knts7M/4i8TO1ZPyMEdJeSAUbDvlao8xjI7vXcr8SZ0WVFo4b/KhhY+0KE9xnFh8IC++Dtc8l485irps8pNkAJ+GLJWQiyy+Cne3axJIn5u/kNDE48hVCorLyfc5nvUHGHeln1shVzKjtkuG7bD9jc+53wKSs1tnwtbAdiXcD0rbfhYLmFY0SFYiAcnOryw8pjrhAXKc0KuqXUXAcYHA1+zlWzORYGVxM/uMrGVKvmA/IBduRLwDVrlqaaxRIhtsjCthtp5troB77nxJERdI1qVOopPM5TTzPK2DqQBDxCwkIsHkv5EbvSu9BVqPsP09mmrp0/lzZ6sIiw6QlfPNQD0e1dyXYJQHscefRPV0GNYB/my1eu6669S3VKxv0HWn6HSVsaWMrO9xIJqkLPb9Ct5w0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3add11f-7264-4c9c-6631-08dd56261041
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:26:04.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shjTYxPbe+XIaDBpBZh+WcvqLX+2Ljv+QETeyYvzDQnnyg/1URFk0btBc06byHz4D/s5mY2H8wAcDWdS2iCR0UT81wL9OxovLBOj6BosFh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260041
X-Proofpoint-GUID: QT-L0k03a2EWgD8G7R8lhvnadkZ4H-Qa
X-Proofpoint-ORIG-GUID: QT-L0k03a2EWgD8G7R8lhvnadkZ4H-Qa

On Tue, Feb 25, 2025 at 02:26:50PM -0800, Jeff Xu wrote:
> On Mon, Feb 24, 2025 at 10:20 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> > > the vdso, vvar, and compat-mode vectors and sigpage mappings.
> > >
> > > Production release testing passes on Android and Chrome OS.
> >
> > This is pretty limited (yes yes I know android is massive etc. but we must
> > account for all the weird and wonderful arm64 devices out there in context of
> > upstream :)
> >
> > Have you looking through all arm64-code relating to vdso, vvar, compat-mode
> > vectors, sigpage mapping and ensured nothing kernel-side relies upon relocation?
> > Some arches actually seem to want to do this. Pretty sure PPC does... so a bit
> > nervous of that.
> >
> Can you please point out where PPC munmap/mremap the vdso ?
>
> Previously, when you mentioned that, I thought you meant user space in
> PPC, I didn't realize that you meant that kernel code in PPC.  I
> tried, but didn't find anything, hence asking.

Jeff, please stick to replying to review. 'Have you looking through all
arm64-code'.

I ended up doing this myself yesterday and found no issues, as with x86-64.

I said I'm _pretty sure_ PPC does this. Liam mentioned something about
it. We can discuss it, and I can find specifics if + when you try to add
this to PPC.

Please try to respect my time...

>
> Thanks.
> -Jeff
