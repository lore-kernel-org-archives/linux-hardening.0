Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4A1E493;
	Tue, 11 Mar 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698202; cv=fail; b=b6dfFRy8HF45ORpahKMOVrmXVvIB8A3V3UHE7xSYswJANNZxpR9SvuhCsmCrHTzlENZ4mUQvENIwgGOn5tHoXZcUblMvykblOH5rryB6Bbk/Rhp9p9YWsQGtWXxsRQLzszW9vrFyROgWtzc8HkFnTGIEJ6scWKwaV3U42Ok1Zbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698202; c=relaxed/simple;
	bh=UlClTTBF7vcElcfjO/v1TuCcM7zEOxXTmB/zKJFK06A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BhmgT1rF7YuY3bBDDF23NjpkrRWfdlIFtnsNhJAiqTUHTgxHc/l6z1ELi6wVHYIY2phXKeLguVdn8RGKuh495MPZFHT2E+8MYuaH5e5/n53td9G4h202t4tW7/P3veAVYmtPPJlzVvhL/ddtFYR4wGMsi3VlwfMpin4gmRj8HKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GUX0SRpD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LyzFKRM8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GUX0SRpD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LyzFKRM8"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fsmW012934;
	Tue, 11 Mar 2025 13:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ccwv/eeZdFWRw4DVS3
	0gQy7FRK/YS1RHLPSwpUjtx1w=; b=GUX0SRpDxyLV7EkHxVcC97702MZv9ch4M8
	BR7ef/C2hV7B4SimJOmO041dbyFplKt4W0qO9j/fErUEhAnW2fC3gMrn094Jq3M8
	KnFPkjOJ9WOerD/QcAoiDnn2Xt+DFfyREhXZk0UT7N3mCBDBQ0zkMN8k0BNpu8Aa
	R9hB/9CIDEiKYUGWfKpPs7jcCZ+odInsFgkTE2JvraeQZVNjpBWcTV1OntuwbpY/
	LJyeioodI/ee9OSHbNjcOlusCdzXtSQYQ2jMsKOM/5iRDeXGT3Lqd71/cZSu/jvP
	tpO0eBG8sERcoLQIgw0+HAyKiEwtUBIUyNC5KwMczQ+baQ8w0/yQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458caccr9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:02:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCEhNR030525;
	Tue, 11 Mar 2025 13:02:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcnb9ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 13:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSLVHAMgTgg/+Iqe3FEcggnZpUJRvGadXeLtBnSNCe7RxDUI2Db/O56qbZcZItUXJTaZhI9nuIiiwiWYaC9JTkp8zlpyGNTLBdti228ouiCiyc5J7/XSINU0RMB/hjIeYBEecCgtNasbiaF+5IG9rOYeFk+ybgwLH//WHIeg5j9EtPxKnrIm4SVAv3TweHi4dqtUZs0LkaxgVEF9vBTxGNfci2ymyt5g5K9a4qyqhdILLJhOSAgzOr3VtaGmETorBEyFLi72vxJqauWYe1Bs+mHGC+4RdPveEcIwWEUMhi1cu1AKFnlrqm75M1hV93RF4mXhbvJ10WivGfKbJSTlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ccwv/eeZdFWRw4DVS30gQy7FRK/YS1RHLPSwpUjtx1w=;
 b=NrQ0ZDanThRpQDMa6DsER83Wefi2xFXU4hvyTIUraylrYhelBJrmu+d9qRSiPw6pVAHDCB2t+yCp8upfUrSxiNlUnlVoOiVcgppCtnZbRkweN+l7jzrOj+R2esMsia/ZRznhGJW/P87AO7u8XTpiPPBRtxkSzDsnonq/o8gcLyC6v+upLw6MVQwfq6oEtdWhT+u/qQTqYKVzDWWLup+qOkXudGE9uPgSBMuvN9CHoQSTozTr/GZmfVdeyLUt1xJh+BNUUcjn9i/4RLM9dlcWEAYU7tV4CnWTLs998UopD8R/7TuyR3/hJLjro5eg8Dccu1i582hyqdDQdmtnOxO56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ccwv/eeZdFWRw4DVS30gQy7FRK/YS1RHLPSwpUjtx1w=;
 b=LyzFKRM8Pux6TR50fQkngrfu25HgwNMWbU/Rfi9aXhzxvW87ktyv9VEXEkmbtDpx8Yo0AV95mZOFG9/aZtuHZpoAzDfQdrAM6WP0OY2nNjpQFXK6vLNEpfPuha6vzcdkb+jvgC9Sa1i+ycIX29jysga0u+v1eSjf9VMOXJ+XvVU=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 13:02:50 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 13:02:50 +0000
Date: Tue, 11 Mar 2025 13:02:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <kees@kernel.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH mm-unstable 0/2] mseal system mappings fix + s390
 enablement
Message-ID: <a326735d-ca3e-4aee-9f98-4e742dfc15f5@lucifer.local>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311123326.2686682-1-hca@linux.ibm.com>
X-ClientProxiedBy: LO4P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::8) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: 8786ecca-4ebb-44dd-a070-08dd609d06ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N0i7m5gEwsNZxGmHmrVrXxpcpCTQoszeRGMiYFt3N2R8s2SU4bqCTCAYe5KW?=
 =?us-ascii?Q?ySei77ZNlfE4T70Q0ulkQ3eAXLanQ0Vovv8iyxCbvbHEXS8gQKwlKYUYH7KW?=
 =?us-ascii?Q?MfN9J1pOy2Ikx5RdhYvYPrv1vFt1XLO1EHB5P5d3DJc2h93u2YDGsOAdBA+u?=
 =?us-ascii?Q?8LlfD4wjob9x+vl/Y10xUeACoGDUPXqlckGxA9uilR7Uw0trnZlStO7iC7wQ?=
 =?us-ascii?Q?YLKVx2ylXoZkY22f8vCoVyDuIxSdy3JMj4Nvy8mErCUnRQKbj8aGNFXw1cV8?=
 =?us-ascii?Q?/oEzeBqLFbvhyJVV3CYJwjypidfygl4kIzx4/ZnpZhstEeWYmdDGrT+JkKsQ?=
 =?us-ascii?Q?btWmRIijLjCgqLAsGCTeIvYXd8EtnG1EEK+M/wsy05pam9MPGaWksFJAGhtW?=
 =?us-ascii?Q?NaaeNfPDlBrdbnwZ5hQc/KLt0GtgoVvHzApGWcaCEP2vt3LWjLpQEmjna+lK?=
 =?us-ascii?Q?GRiSbq86Nu0VQBOMUWaqNdm5HUPO/hfCnQzPvcQAm5rq5OMbwvDhC0vREKar?=
 =?us-ascii?Q?XvrMveZLYKbMCJ9wNL+r783A75TNjRcGNQSowtkboxUc7r1eadU23n5O5mLX?=
 =?us-ascii?Q?4G61eSlYr5eyvZlGvve4tXd0VS3IgsO5MKTtnPbv/gGf1p8XGiBBHPYjhVrl?=
 =?us-ascii?Q?PYXt+yTps+dDqaltN4V9T0sZY8HFj5cjZp0UZ4Jw63GMiN0V/bwY8jGeRscq?=
 =?us-ascii?Q?UHguCSsXehlZ2/Dv9jTXWbQ5QCVpiNwGHq94nxtWkuc5aSmD/jECjqAQGldX?=
 =?us-ascii?Q?oy3bD/WonoMLQa6KMjXix0NV5eDXJT1bem2AjVxHyO1bVMS/OplACKEdxcLQ?=
 =?us-ascii?Q?KBAUsE1xhkKB8SGKbk5spN9bqfWmo1oK3NQdxe5G2ULxg2hff7OXLftrP3cm?=
 =?us-ascii?Q?herGcxqjHkKbgP8N0rH2sJ3XAOxuz4icGqkwNUpwzVd/kdWh995ZFK62P++r?=
 =?us-ascii?Q?UaxW3AccDr1K8g6PzYH75wS4adPzEp5HUF6c3yV1ZSbl9sGJ9lamoFsAJaUE?=
 =?us-ascii?Q?iyzVfbn+BL1l6GFx7AlkmiX1+gfMbvAm1Qc2seswYwsZem4Rp91mOA8xkhnv?=
 =?us-ascii?Q?ty+7jbXFmBDYb3sLdMRdR9pyQKgOPNru8xT9qeVV4K381UuGTJ3Vl/9GrOwC?=
 =?us-ascii?Q?wQXjqnQTurp8ggt74FnK9ESwi4GqzHu5g12Bse2kfzKkT3tdnB7d7mapi3sG?=
 =?us-ascii?Q?SKXLB7tGTb6hEog4O9VOMyuziHocl7/Zz08ZShLR3KNueEnNMO1JXBDMF8zS?=
 =?us-ascii?Q?WOblQaAtFg8uFwoOL0g2oGs7GQtsAXy3YQP8hvsb20Lfp4tx82zxZb2TMuN3?=
 =?us-ascii?Q?/7fx1GSZf1cneuB3vKZ6ZfW93k0lxPaUzSwbtLNKDak3J3bX//BkNuUyqYVe?=
 =?us-ascii?Q?sbMu8MmceoywZwWpwONlzCJhsijs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lPp0KAAZjd640RBQiI+s1wNxUXHCzgbpeV06Vz2ebS5E0bwwVRfByyPMnQ/D?=
 =?us-ascii?Q?zVQAVetLVfNVPpxBPQ+8NIxajOVlof8ZxPGF1Er79F+KRuDNsUl7LjK5oGBI?=
 =?us-ascii?Q?4RBBYReQEXOT4AwZH5Wf3kW+h8mlH+Fy9EZxvm21fAJDp6TJ6241BPaJl33y?=
 =?us-ascii?Q?OwfsIcweuQSMo5+HAxrM1TjidgAb08Kk8I6MdbqKrIXpVNAIMzmWoq+QScXS?=
 =?us-ascii?Q?5cllW8kwbq/b65nGTF+jNxrAvNGbivG+rMERJWb1JSWmYQRqfOi9FBXQ5+u4?=
 =?us-ascii?Q?G6uZbhFgv7uqsCvyICtKlDx8NiyQ9636j3sC9FG3Wd68fIIIiBu+XA/IYyIC?=
 =?us-ascii?Q?Aa+HFbmpxNHxCOj0MxuizwXExXPnQLKBW7eVhoCvStCToZH0FMAM9iWW4XEw?=
 =?us-ascii?Q?HYGHP2eD+4YKFqhwtrX3BLD7Ql+tXIMyDz99Qp48vx1XumI/r7SdOPfElmaN?=
 =?us-ascii?Q?OpgubpDzKgNkHIRS7G/6hTvJ3MT843zIGTSnZXFJ85pO4KR/T36NU4TxMMUE?=
 =?us-ascii?Q?KDxRacN9v+6fo+720zR1WuvQ6GCy1+79uAuNODrf6p1XlZURqbLzb5UwZqFO?=
 =?us-ascii?Q?UiJ/Q8C4Qd2PzKISe7TlFua73VEyw2ULnl14ER6l6wpa8k4rm/Pq7Gvs+z6y?=
 =?us-ascii?Q?/pHiD66EVkD/PoKhoHTVbL8l14T0J23fst4HMdShSahgXm6sHfB7MO5VQDQ+?=
 =?us-ascii?Q?nrprVEVJUtctOd4uhFe5jjeYrkOzbaBnU6E4udC7vhvgzv0C/arHd1eM9YBa?=
 =?us-ascii?Q?1nQVS1AZcrBVrRprMJMV8hZwp5ZsQuR9cTJ4jjzcnJbClwyBfwHvp5JTcz2u?=
 =?us-ascii?Q?5KqQFyCCH2Gp9V646OWOEwnaT07f+h4jWAqevylcEMYty9rvPFK/1MyldDn/?=
 =?us-ascii?Q?D3uMqhL8dEgRbysEuHk/eXXA3H2vm923BKjdog4RKgETBnofp7iN/xgQP0Vg?=
 =?us-ascii?Q?e1vOE3TS311OdwBxKZKqC79XgpqevQh6+yLSWv6fosbCkYBEwvYsJZX2pTO7?=
 =?us-ascii?Q?p4EUVZ/8yvEzlUG+VpxMR3sQVsdAEhNzynlD2Hh6qakZmejp6LUMgpBH+cxt?=
 =?us-ascii?Q?4SdE/SfW0LqrLvn2qn9No7COsN9CgN+olV0UI1Ten3pNE7/VhxDKARHKOmvM?=
 =?us-ascii?Q?j7AbzvlU6S/TsJGbk4iVeRZWZ4N/jW/Hr+YsDQcSVho/hYT6KdwvGdnn+2q+?=
 =?us-ascii?Q?opls2UxsYxcgMJr4NGzksSXews65n8bhp7ydQ/PG7kmfcY+V2UTYZ649e+up?=
 =?us-ascii?Q?E4RXeAdgrolz+E8j267nEUdgvmwxaffkzCR5mqDGH16AfovNjuoa8RUh3WwP?=
 =?us-ascii?Q?0Cn4aR+9fJA0NFEbHLbtXkDdd21Fgxhu8lmcao6RRfnKJGxucD2BqCtUeCOm?=
 =?us-ascii?Q?5xMzoDm6Vhz828qDlnWOhAj6VdCKS5NMVwJrKduC/5r73L32qTttDTLg+7ns?=
 =?us-ascii?Q?ZDjkw1/mGd8r/C4REEnYdeEOt1BgqnT0fUXpjW9kyTCoO2wRy87E6tX+wapM?=
 =?us-ascii?Q?bLgDeTMNE4ODivMZu3wIgkD9OYEToKOoJyaf0AICnwRIFgShU7dT9wwlybCO?=
 =?us-ascii?Q?0h1kudBA2f/zfJDUOAllm7htbE4KYeSWGDEWWfQYXaTvuSbo06e3AeiftSFQ?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IpRqkOel8B7v3goN8j/leIf93YBJ5is0hOaaRdL6eW+QuQ079ag6qEnQrP8yAMipKVjnoXsk2szojg6nWYV/GZ0/QCsuNLRs2aoNT8ETzF+eLFmOTlLpAjwXoQ25VuM5rAKDrsu7i5Z2JoS3OVC2A74dM0hYDa2rBJJc96IaHweQwOfFnrQK8puuVOI1oXF84ZHZXnTTcSKmT0XcoHDs47DoSU1+9YZRknmm8psY4iq0IogWAWT0rhpCmVu7k3GOL/SGDtQDFuOrXRriYZzZL2pEeKXC1PSS0BcgrN6uMzNhAviMo/crCJmykWZf4s3msEVJqsrlnYPMUh+hZbBMGDkBWsphPFZXq8fObJD7W1WF6BrX7s4eLwvAK+90oXd1atVBExSd1MVYNytdOkdQGAsLNkpIZgNDVkiG9x8E1kwcM6GmbRFXW1ERuKdbyWoOUJFJXVvXTGi3IhFMDIQcwEs2z2roGTzUdMMNan1XNc8yEoCsuqS6XLUpoTwU0gH1Wu8aqf4k9CQzJ7h2VeAx7wXt3J37439fyaVHtwAEVJrRQu4HJLhQpJVu8VeIWySwRdQuMkJVRwUH3NXJL5APV2JXuOvj1HCAo28g2dVUYcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8786ecca-4ebb-44dd-a070-08dd609d06ee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 13:02:50.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k98o4hD/Z+DYZPhkqldrVhv/RtVRtNZ6a1pjov0opdAZQ1CLHvkPL2nXfxKrkMy1khlFqBfEwH8K8+b2QVjgoH30MRN0A/UVNMzOiXr3fU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=620 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110083
X-Proofpoint-ORIG-GUID: eOqX5iTXiO_feLtGzh7hz6m2nRNpJ9y8
X-Proofpoint-GUID: eOqX5iTXiO_feLtGzh7hz6m2nRNpJ9y8

On Tue, Mar 11, 2025 at 01:33:24PM +0100, Heiko Carstens wrote:
> When rebasing the mseal series on top of the generic vdso data storage
> the VM_SEALED_SYSMAP vm flag for the vvar mapping got lost. Add that again.

I'm confused by this? Some merge patch resolution thing?

I don't think this should be at the top of a description of a series, seems more
like an addendum.

>
> Also add s390 support for MSEAL_SYSTEM_MAPPINGS.

'Also' = the whole thing this series does?

Can you confirm that s390 absolutely does not rely upon
moving/manipulating/etc. the VDSO, VVAR, etc. mappings?

You should say that here.

>
> Heiko Carstens (2):
>   mseal sysmap: generic vdso vvar mapping
>   mseal sysmap: enable s390
>
>  arch/s390/Kconfig       | 1 +
>  arch/s390/kernel/vdso.c | 2 +-
>  lib/vdso/datastore.c    | 3 ++-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.45.2
>
