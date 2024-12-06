Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40001C54A3;
	Fri,  6 Dec 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513985; cv=fail; b=m+uOhA/rIWvO5lBp/B8pDC14whJdXry9E8ELQljXxwCStXqrzYfO8lCytKDtQGCEwJCfLUVktmQa+AsAGs6oL6GtCwK+Urtsluo8r3ky4JkxRaWLv06NN1ugoXPTCTRbZbOGWNJSteh4Cab7Cq3CmvcbX7c5vk4DPNu5YjbTW78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513985; c=relaxed/simple;
	bh=qauYUjadT9/AMQumVeJIbSwggqbRu2WqBENk3gTigX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UskgMY5xXU3KK1eb52qbn2PfGsgLl0HDirEZe2OEKgVI6ie2vNzIBEIO2zRVv3iQCx1KF0rrvrgxWvLPgFJQanQt7u1/XF5eWa/qDOxOsyKJyzDN+1k9jCcmKymJibI7IYNY4VfngyZgRtuHSNpVciHvo0YQfpTwiPTJPB+YSOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mIJ9/1Mi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a+ZILl+L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mIJ9/1Mi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a+ZILl+L"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6JMlJt008068;
	Fri, 6 Dec 2024 19:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=I2o1J+i39QIcuDHU2r
	hyyPG53YYre9mbaJYWLShW6v0=; b=mIJ9/1MicSGJqzuHW82u81LaqDp7VqO498
	27QsPgnzuAw9Eq4nxWiaJ/WqW9ZKrmBHFkaDtC5Qn+uwVyUsMoRkyHAOvuxXRuBZ
	7Vyp7iABjYLyPpcolqiiZ+yCyyrwOHfPMH496rMdFgDQzCNbxetLrdXY2fxn4gEd
	r5xIxRGCYMBuOb2QXNPQvkxXSan2D2/MwKblkpJizOI4SdL0bOWbiZ6jf4fs541t
	0VtId2FVVA1YzRCEk/KFprW3i4ZOFogioMhRBAYUZl50KBKXk3EKwgkp8jCIgU6A
	iNOA4C1hzc+g27NsqkhTcCTklE7uj6AAIPKRZvWzfptjBYcmPzTg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk962n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:39:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6IgDr7011741;
	Fri, 6 Dec 2024 19:39:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5cpkea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:39:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuhrD8JI46CXIHjZBoKykEOfb7OsPiMnsiPUuTmmlX88yvO147kQHc4Vyscyqo9SB6WBL1mAMPznWme3ufGh7wpZDWFQ+vmUVXygd2tSN4Gr2V90dF+18yCVIwMSxT4oAfB6uTDzRcKKGUMDb0TfSUpV9fEh5KlXYW2oCibuyhK6a8O0LuN9VId0QeD+crpAZQZdbtwVdXra3FzaMOprDqZYf8QKhuc0Y38WLOtMVMGefIizK8tCfwKtQHuVBMM9y/olShAnpP20A/Tjr02Bxg/slOz9TCQTqeoQoj9ypucOUVesN8hbCmcUETArzmzJghaRlqy8G7tmOVDaOCMe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2o1J+i39QIcuDHU2rhyyPG53YYre9mbaJYWLShW6v0=;
 b=scm5fPMJBiqS3aliPcqSJ+5xXLw5QbLOWfXp8g6E1fLyqzdUa9IcZhMvW5vi22csDNYIUGna8ZTskovp+8ekqk3Y7WFeEPiAljSCA6YMiFajqkTbbpR0vS0n/sUkYKq2xIi0KDignDtc2AvEivCxCEKP4qVxfhB7ctipGTuz9YISaxXLqlr/Fpq7updR8EvVJEVo9VBgtO2V6Vup/TZk3THppaeQDV6tkEr63EWCKBcmWlKhmTPf5OLFJhPplVRwLxiSe2A8eseKu9fAmI5GEVa40uHgVBiLwmDW4tPCZa73pKR0XoiGWA51KLCk+Ett3oT8EX3giAtaCE92OIgEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2o1J+i39QIcuDHU2rhyyPG53YYre9mbaJYWLShW6v0=;
 b=a+ZILl+LpgNE/T/aQTQ5VLAyX0kyLE45ZPIpuYC68wEHRBXTlGALVtaFeLQXNgzuM1Ud9nuzGTTpKVPJCmWleyJnPJru5ECkm99uPxW2rVNUzoKIhceKzkzOawzxAsqFpJsCUrQUFpNkM43liNWFFjP019uHKnDsMfUrgW6w6Uw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6647.namprd10.prod.outlook.com (2603:10b6:510:221::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 19:39:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 19:39:24 +0000
Date: Fri, 6 Dec 2024 19:39:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org,
        pedro.falcato@gmail.com, rdunlap@infradead.org,
        Jeff Xu <jeffxu@google.com>
Subject: Re: [PATCH] mseal: remove can_do_mseal
Message-ID: <456abc34-9071-46f0-8c70-62377484dbf0@lucifer.local>
References: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
 <20241206193309.3026213-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206193309.3026213-1-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0625.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 27026b3f-c947-45c8-46fb-08dd162db03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sSNNQd1E88cZlzd0YCMVxTypX0L7cmd+Laq+BmAuuWCC/PP8b16GkmI2oIG1?=
 =?us-ascii?Q?Y1AQzBidijiD5NsbvzgaH+i1AwlE0sNiILMnY78hBjeyKY1OlpmWCFNHpiaG?=
 =?us-ascii?Q?y6Z/k1ykwLpqcARV58VNv9bFbu8H2ZnWjKAUUmj1Wvj4ZzkckZ5GoB81QgF8?=
 =?us-ascii?Q?n5El8y+Eq3gDlmMhZLZ7OHb0B8YXgvrbqTSIu0TQWHMiP98p//E7zIvYZOIH?=
 =?us-ascii?Q?1zbjoTGzDI1yJaSnEhGoo9MvXxDMknygJ2mOX8UywDIPz3SbBEc5OCc2eHg9?=
 =?us-ascii?Q?rDQ14QcMRiV/8bXRzaQpgrbcv9uSIU80BrPAzPNnZ9TpWozGW39tUyr/5qcv?=
 =?us-ascii?Q?qH+epHxj+PyrNVdkxFmHUBMQuu6aoTA3fRG7jW+AbzP0nsQ7Ke3YLDbSsNWE?=
 =?us-ascii?Q?eTdnIUlimi9ifS5hKblRH7U5FRtKmKSdd84c7Qxq9R4zBEo/ltH7vEWgrLkq?=
 =?us-ascii?Q?0mCSF0qHchufmE2nHV58W326pp/mAFTEHBQaXsRFTrJ8eO+Lf89MVnWJRb1V?=
 =?us-ascii?Q?ziRt8XOH2KDrrcNAnn58uKGvG08k8tVEjutF3l5iwEi5oz69R5Ay+KTO+9pu?=
 =?us-ascii?Q?OLjUWAuk/nTztepIz3KLQhDlqZ0ztTziKUQeImfWWqm79XcMXtpSx/DCxC/z?=
 =?us-ascii?Q?5+CtmgwRi/0iqIK3yE6E6uC0LnZZa8v0GyxG+m9OhTG8jGs//x6GRctF6I9l?=
 =?us-ascii?Q?eOISU+wJm44U5FzNKJx8Ni00Ac84Hl9+mbiECaNfwpdOhChHAl2zSvqLpmy8?=
 =?us-ascii?Q?IvTggCZyRthXW2ihJ13Xkllc65owxKdsoTWJ4ntcpWBSbO226eM76FYfoCGo?=
 =?us-ascii?Q?iQ2YYmPNv1oLX3ki5ndhl5gICZs2mnW0egK2hr6quvlyzApokPmy5UsG9zYO?=
 =?us-ascii?Q?qsNOai1Rt7qtVzLcar5WPexCjQ2L+oAOjpJOxuX5llxSv22/579L5kmVGVss?=
 =?us-ascii?Q?VWnx72NwkHakPZFBLRl6Z5ZUBcYfOSeYOexOWbPEm9eZXMKDGBPkDlnINvGx?=
 =?us-ascii?Q?FuX1Ddqmni7F+TNnW6+NGeWlj01yd04izTnH/vTGjYBgm7+S8paAvBkEz2WH?=
 =?us-ascii?Q?nZ9/5welHnryBfJhfXY8OclA7RJLdCU1pkLxy3K9BzVc9PixqYNfNeBmYH1Y?=
 =?us-ascii?Q?OLsaySiSF3MpNDMe0qIkDVQHflL7HGj5+hQMn4kWrtHOvksMnLojQoV6LsMq?=
 =?us-ascii?Q?AX9rfxNhMQbzt0wDWg8mqlWadCTMEvbWhnuPXqUOQDFsCB4L/k3hH1xv7hSq?=
 =?us-ascii?Q?6UPDee0s0j0zmnBgVkkmafW4XrdWMC/KOCvifxS9Tpnfz+XELnekYY2Pcqyo?=
 =?us-ascii?Q?msRN9+WCQRLyZQEL0aJXuu0otFIF4S27l3uAF56Kzu7ZTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9mom3zF7sEC+0PqcSAuZQUp70BzY584XqQ5eecg4UaiJPn4a7Sg38pCzHNQ?=
 =?us-ascii?Q?KpGUn9xl2Q1o9VlL916tzto59FN3Chxou4bNkuz8YrkQhFyzfsP0BY/G9Ows?=
 =?us-ascii?Q?O1F2fgpELc9dnsbN1vcrRdyKdcPRg8tUi5m2vqfTs7dznMArtJ5PcJnS1vV+?=
 =?us-ascii?Q?LW3qsZ5n3Ejg9SufF/U4WoFQYy1qDUNs5dC5sXnnXkLdW2QVQ29Uehs7P4I0?=
 =?us-ascii?Q?9pLQqYbMKiNxsDp+9Mpy1HbiU/A2CLDV+YrE7+fvDlcE4JYLy3hKWn810mGz?=
 =?us-ascii?Q?2IpfMyXscCi5dIzjx1ELXc3Vqpa3ShkYHNhEUj9ujPlPOhXgDg42Ebj17iDk?=
 =?us-ascii?Q?QLH3yHZgT7sUtIIj1SU8ZarVWOXyzJdxUHvU8GayTCUyJotzKMB0qVXqUdhR?=
 =?us-ascii?Q?vewo/YfrSk+nyA2G7ZhbHl1Z+lH4E80X1GHf/aQ4L1eVsd/0mpdcwnijXnoM?=
 =?us-ascii?Q?sZkwopONqCw4qAmRGFfWx2E8+x78/ynKe3KLg1ZO1fjTKh2EEY+qN3dfLFZE?=
 =?us-ascii?Q?fcZRg4Ui8KY9B1uqaSR/pMVZpgvdnxyrw8+rlsxEh5/wsBdHyOvq/MVA8Old?=
 =?us-ascii?Q?A6qGd77To2JYiiZFH8psufVl7y6+QLmspnYXenksr7RBFVgNcTeArUV96Uus?=
 =?us-ascii?Q?nmrILJHIsMO+wAi+3/xjWemWAe7EF3mE+MGeBeUXYUR9nbDuP5MwOa2tmyfC?=
 =?us-ascii?Q?GuOWFsFGRGGeYgvbt9x5VY5KHRqoH0sdqxajaaEQ54kukk3ihSiVxt9s3gC6?=
 =?us-ascii?Q?7c3xxfI0Z5bCPMY8dY2HpdOMj2M363qc8b6tVT7uLOSTsLQooQMAuLDKxDPN?=
 =?us-ascii?Q?M8dIWg8n4aItQn+QtBgkLseGGjEqw495z5HiCe9IO4rJp8CemrabX7rThkTt?=
 =?us-ascii?Q?COwfa2ybSjKYU5dCdlrfcXbqHjZNNlcw2hSv2XmZKfBmRnR4c4lWjOWF7oL3?=
 =?us-ascii?Q?558relAH1QyN3CP+4mM+BWbwcEmS6rhDtBruHPu82Lalh2KWGEHaBKXzkap9?=
 =?us-ascii?Q?mK0kXJgzoVhIiBPZYdjY86uS/ftLJHB241YKr5a4po76JpPuFlmRyT0T3r1i?=
 =?us-ascii?Q?B/HgGFRBSoptNlfy8mZjAJ0XpsdkYx46uqGeXfOXrFvpnAPwiOU6JV2Vmqrk?=
 =?us-ascii?Q?uAdpD2FsDgKVuivExmkzkznLDNePjv4ihDqz+YnyvkWAiYBfgk3jjH/4E5Ee?=
 =?us-ascii?Q?+12Y6ppH9LRX52F4IgNF5ZftG7B5tgKOp1woDUtZepdBQJumY6uJnJiwgXQ8?=
 =?us-ascii?Q?O6Z1ssZLVO3zLSVgRfsLoWY2lCccU4lQvp2qZIeS9fTTYAK8mOl+pazBMTFr?=
 =?us-ascii?Q?Ch7/H2z76+9RPLVFT9iYsu+d8mEXEQoWoedouyG6L5YnTJKdBune2HLlvMjd?=
 =?us-ascii?Q?o+CDIgVJQ8esaHjdMxIPPmYUt9wqoailwSR1ge7laxGN2/O2cU6XFw3xFqDw?=
 =?us-ascii?Q?RKNXhf70IULTyQpG+SjD3T5Rf9HtW1HCuxJ2Ekecg0MAgn3+DLQsYAiXQNoS?=
 =?us-ascii?Q?sX52rrjkMc14/ZXEJK3i+zWsaushvCD4HmmYXs3COr2zB5ub5f2wsrI9YrKy?=
 =?us-ascii?Q?TsLijIqMn+AA0Tf5naysaPmWmMj9jvVQGKv50VbcP3C+7tdCrRNpGuSThFXO?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8kHrr3bDBFnTt1oPxxtDcZI0i0LK3QdhAUDXNklgaSH+fihP/RwqTKsXGYCf0jdrBzn7Fk7P6sv24rXGpKR0UVCF4RbaPq1vO8JWXz4n9wSsxh9xYNGaVbi+hKUDLCcM21lvOVZ4HK6hnIV6QV2R/X9yhy0M4gDVbpLic6fiaEpmajK+7ofgPylzAMGyRuikEwULnXDwtfTBv0otOyYoCeiLYrKXkUu27Rlid7DkzgNoO4dO3lhjLHCZ64CbNNMN9RpXMdelToH1fJ6S1Ne5k0p9H0PieTBoTLRwtZnk7Kj0E1SHdy2BDWxtXgxfYxJiM8Kl60WhTefyE8h8KWiDjoJBBUad8BPySaHgXlMVqd4BaUDv50b8gal16m3jiYJqrkZvhVnkyt+NwvqQfOD7e8NgJRTdQV4di1uANiWRkbGzMSRm/ItZzdLnqDdrpwzbApguJLoza0AIWSiMoYl5l6OjpyX5LhmJZTx3NwHVYPNYovqmuyP5DBKnZs3Lf3PjlINTEx0yertT2z/+o2wgn/tTx6PopfVdWC+3WLqbr7dXZEYiVM4GlwXhrH53RUuUsoKLXcTYDCDsn2NzrcxN7ybTBn2goT0/29T+g35hA6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27026b3f-c947-45c8-46fb-08dd162db03f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 19:39:24.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57dL/hjvRJUG7xnNYHTsrUJ0qQ8OXsnAkJvybLH109mCuj+AaDMIuEYaDeGRUupoAV37umYF6sNh2weKooYJgSMFbu4dR4AHMmjndDT6MIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_13,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060147
X-Proofpoint-ORIG-GUID: pxa9qzrqNM-VcU53fWpTiyt_FpMrw1MK
X-Proofpoint-GUID: pxa9qzrqNM-VcU53fWpTiyt_FpMrw1MK

On Fri, Dec 06, 2024 at 07:33:09PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
>
> Hi Andrew,
>
> Is that possible to squash this change on top of
> "mseal: move can_do_mseal to mseal.c" on the mm-unstable ?
>
> This is the first time I m doing this, because I saw dev did this before,
> and saying this is the prefered approach.
>
> I could also send v2 which is what I usually do.
>
> Thanks
> -Jeff
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Hi Jeff,

Fix-patches and the like are usually for stuff that's been taken and this, I
don't believe has (I might be wrong actually).

But anyway, as a reviewer it's easier for me to deal with a v2 in this case, I
am not going to give tags to the original version of this and want to make it
explicit I am only giving them to the corrected version.

So from my perspective could you do a favour and send as a v2 as it makes my
life easier anyway? :)

Thanks, Lorenzo

> ---
>  mm/mseal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mseal.c b/mm/mseal.c
> index e167220a0bf0..08e6f328d9c7 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -225,9 +225,9 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
>  	unsigned long end;
>  	struct mm_struct *mm = current->mm;
>
> -	ret = can_do_mseal(flags);
> -	if (ret)
> -		return ret;
> +	/* Verify flags not set. */
> +	if (flags)
> +		return -EINVAL;
>
>  	start = untagged_addr(start);
>  	if (!PAGE_ALIGNED(start))
> --
> 2.47.0.338.g60cca15819-goog
>
