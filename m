Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15481CF8B;
	Tue,  3 Dec 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235247; cv=fail; b=BZ5AlqDfpoKzVXHKbHpb/kl9bH/v6PWiNePRvmIDgxkS5piCll/Dr2VyqOU6RWtBldoX+pNnaDNiLaQOJr+bGckrBkPMa0yV6V5wI/lBrVBJRGpxLQq+xgx6Cw5a3HUYecFkPC8WD4Ba8p0pG5vzi8AGK5TNNCAWDlYRTEYxpvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235247; c=relaxed/simple;
	bh=57r3fl9QZVOgvejGUIOOS/Nm2P0lJQ1uKfdZh7LmKSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bxQK974zyUWZM36OhfoJ4n4+zWqHqTdlfrIrerUWUIxjHM1/6xlpW+ZoRL79myvU52psOywhaWoogeMz+DyVIgHagn1y46jkIXQqwOjE7lsxjZvRDq2YgbqlZxYSthMXUGHEIFI4IpS/q7jt9umusEZb4nteYNz2ndgNPijUpR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e01in6F4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=niLXoFlC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e01in6F4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="niLXoFlC"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37XwHV002794;
	Tue, 3 Dec 2024 14:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TYG80WXL4bQEwNrZEt6CD7ue6OzwVjAQ7Wih8Cf2960=; b=
	e01in6F4KfQP3gaPwc128UE5wZ0mHqP+0YGodFXyPZRAhwJ9cFGWKne3e++Gna+l
	kbChDuO/ZJDCHnZbPwj0zBf5A0uMXzLFujQl7sj0Mg4wUwz5DOMMB6QAoMpfj9Jo
	qfxF2AXg9QfYTFnfHRZ+VnOPgEc/EFEPNUXL5qADA6UtqG2Gu2rkmcw6JcY4Lfvh
	tKYECaYUG96gK1dJgsQae92pVotC6ErjHblVEw5zdTlKcEZ4oj+g6ple88BqJqA/
	h0j3tt9PXSlvM09UMgFG7jd4JtfgocOXcywjCa3LU2IaWVQg3eLfvxcsSptT1LP1
	0N2cX1hg0wB80eiYzpRU/g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas638y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:13:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3DYSZg031180;
	Tue, 3 Dec 2024 14:13:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjcjpb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNVDWL+LL9N0qsyHs4EHQsSMUaHA4DcwUl6wF+7mN4mNCTxserxXwghLSjzqWxal9sf/b+D1p5cy9485uNp3arHQRX+a/DzgeF5BvlHB4GR07x7zcw7CPQPjgDoung5Xf9IV7J9VRBYfVAZYgMG4VwCQOeZiUQMLfV0SpmNb6XfEcgAvO6c15arwJWTpMli4tAULnxeLrjMmYQ1fZmbSJa2ALd9TWJRZHw+ocE8cdi7bY/cmSpvuPT0Z+Fqo6kHYQAACHKU7hejrktT7lWIH8SzdfM2s3j2CS5H6am8D0tYQY27yhQl3mFqRGqvx7q2EYsE1mIXx+afOhixKMFSogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYG80WXL4bQEwNrZEt6CD7ue6OzwVjAQ7Wih8Cf2960=;
 b=QtGxePP0C7ChAuBFkmGJC9G9ftmUewmzENGZSvrx76Y7pulwJ0dHvZZdUSN266cXAcdf89yl1pRiyFeBvZ2X7wpAwzXaQR8fGh/mXNnS7v6pndeNTeZ4j0JBvZO3BwY3gySOg5xynYgE/i3XXnkubKJGBi5cJeRYFi02CT/hewMeo5jRPpbTfxZ/pXaNZ+KucJ0Zin8mqoCLM7QNQJkLRTWMkefPNqcit3O9GlcuYCo6b1yb6MVzjm3RD2AB9HFGnqCEOaKmbgRNGhyXMNytPkKqh/1Ya7+UqgNczsoPzv95jC8Yus0b9zi9ztcsZEdDHjNsRPXAxJBQ/5dF29Zlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYG80WXL4bQEwNrZEt6CD7ue6OzwVjAQ7Wih8Cf2960=;
 b=niLXoFlC5bu0TK28Pppd0u/TbSGKlmtss4Xw6NbPeb7PYIkrPAVCasztyvWUk9PhHUqjYZ8Ka+rldhNz92uSrKbQI1/PVKYvRv6J94CR97simBQXAGQPvfCiO3NpsVFtDZKmpk1Rf2PbfKBKQKK2vp9rkTUJl1xQ2cMJLqe8qaM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:13:48 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:13:48 +0000
Date: Tue, 3 Dec 2024 14:13:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com,
        adhemerval.zanella@linaro.org, ojeda@kernel.org, adobriyan@gmail.com,
        jeffxu@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/1] binfmt_elf: seal address zero
Message-ID: <cfd3e288-c913-482d-a6ce-789fa6b0f2b3@lucifer.local>
References: <20240806214931.2198172-1-jeffxu@google.com>
 <172365478431.4159848.371478248517217096.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172365478431.4159848.371478248517217096.b4-ty@kernel.org>
X-ClientProxiedBy: LO4P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a06bc5d-d7cf-44f2-3801-08dd13a4b4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXlYZlA1ckxrWGZBUEhVYlNsTEZzcVF1SS9zemtOd0xIdGx1eHpWNk45SHlQ?=
 =?utf-8?B?dFo3TEl3UGVUS3prb0tmNW9FYlRJUlAvcXJGanBINmVRaW1jSS9DYzloaFoz?=
 =?utf-8?B?ZGxZUVE4aDFPMlFJS1pyTTdseXN6ZkFaeUhNOVhBdnkwZnFtNS9KNm5kT0ND?=
 =?utf-8?B?blpQdHovM3pLNVRqSWt5L1Buc01RSXgvR1pmUmZSTmZUSUVqblJHOGE3RFlt?=
 =?utf-8?B?NC9mZUFFQWR4anVrdXFYSWs1Y3RYdVoxRllJNmNiZHllZFlRVE9Jb3RkYXFX?=
 =?utf-8?B?Y1BoaW5HaXk0U04wUXJid2ZxN3FTWktUZkFaaHhNSmRZeml2UC9jbS9jbzI5?=
 =?utf-8?B?dk5oLzlGMXRrZTVucmp4WEV3L3hXZ01aakFRb3V1a3ZtNklxN2swWFZ3RzdL?=
 =?utf-8?B?cm51RmZ1UDJKbC9SLzVPVWtpbDd5UDEvdlFPMWZZUG05RTdEaGhMMFBLSkJK?=
 =?utf-8?B?T2V6MVhkTnhkOElKdkd2N0N1aUwyMCtVZ09OSTExZHBKVHA4NTJwTkxpVG9Y?=
 =?utf-8?B?M1dadG1xYzE0V3JITW1sWWY5dGZpV3FrQVROSmVkanlPbGE1YVZqeDRYKzZH?=
 =?utf-8?B?eWVQYkJpaVdVdTJWeFNqcFUwSWFyVU1IUmF3ZTdGazlPQ0pFbGIxMUJQRjJL?=
 =?utf-8?B?KzdYMnM0WkhRcGpwejBnQ0tIVjhYSFdGcGQybUxkZlhDMUdidUxQK0I1N0xF?=
 =?utf-8?B?SDZJOCtmd3hndnpsbllrcjg1bDhLMDh2RmNNamowNXV5M1dtbHQ2N25KZGpC?=
 =?utf-8?B?ZjVzcU1HYXJlNjNuZGNuV2h1ZkNzZHBxaUlHTytGL0hWbUxwQ2hwOUJLVUZN?=
 =?utf-8?B?NnQrQzNCamlqTzFrczdUK2FPMldyZE9DMDQxZUw3ZjFEcWFsZ2pqQXA3eURT?=
 =?utf-8?B?a0pvSlZVSDNudTlaTEtzQnk5cWs1NnZHbHQ5aEtVN2tML2ZjS2FQUUJIZnhJ?=
 =?utf-8?B?eUVZK2RxL0xvK3gwMzFhTTdKTlA0blNyTWpZTUdsaFp2cjNNMlpHSDNlNms1?=
 =?utf-8?B?d2NhcC9DeEhoeEZmck9UV0VKMmJFd2czMUxVdkxUcE9FeWIyLzhZRC9sTE8y?=
 =?utf-8?B?TGszalg5ZTBNUVNZSCs5dHVacmdyK0FjekFrZjIva3FVbVZzbHJPcEVia1Vt?=
 =?utf-8?B?SUtvVnc2Q0F2cGszZzE3c1hIemJLZFlNN1F6SHpQSHFkbmJyTzR4UDlWeWpz?=
 =?utf-8?B?ZGdwZysrU3MxazhrUmpXQjhVVVJwaHlWSnE2R2szckJ3aWVwQ3VzeS9JeEZX?=
 =?utf-8?B?aXhTR2J6NWZTd29hSFdNbUYzSXZzZ2FZaDRyTW8xTEwxQWFKYnFmKzkreFM3?=
 =?utf-8?B?TVBBd1hzaEtGbnJoNTE5ZmtWdVpJM1R1ekR4amRENlpVV1NpbjJQcTdjNGt5?=
 =?utf-8?B?R3dlSHRjb2Y1VGdUdndRY0NiQUFJdDdhNTVNWGw5MkY3Sk1TNVJjZ3Y0YkJZ?=
 =?utf-8?B?d1ZSY0lPazNoc1pXZTZaSmlZZW1DMnBDWmpncFZGM2ZKbGFoT216Z1ZXaFp3?=
 =?utf-8?B?aWdkb0FybGVYNC9CSzc3ellCT2lxMGp3dXVpa2hXY1AwbVVzVzR1TWw4MnN2?=
 =?utf-8?B?bmxrSHY0UWpISGh5WGhwT2crQXVCZ2R2YlM1RzY3eDQzYzNPRFNnWjhZR2w4?=
 =?utf-8?B?OUtvSEJoa0tWSG9kdkpYTDltY2pGbTZSc2Q5TG1vdkl4SHA1SlkvSDlldUJK?=
 =?utf-8?B?QlBEOGpGbW5PNkRiNXNoUDNzdTJLcGNmWENWOFlSaTlrNGtCT2tNN2JMcXVk?=
 =?utf-8?B?R1ZvbmJHcGs2VXY3Y3d4WlFOUDZyTU5kWlRvVkk0cmwzaHB1cmY0UXpZTm14?=
 =?utf-8?Q?jmecEug5ZXDTmDv4H04EDfmmXA+bssWZqwuRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3o0THJzWGVUa20zN1paaVRLN2lmSUhDWDR4NnoxVDNmU1k4cTZZamg2RVk2?=
 =?utf-8?B?a25HdGdCZkpBbEY2WjYwRDVZejZiQjNLRDAzSkhyOFNkemV4cWpBOVBmenJU?=
 =?utf-8?B?b29ud2xPNVpkZFBGN3FBNVYyQjlRbVhYejR5NlRLdDJxcWF0YnBQL05oYWFG?=
 =?utf-8?B?cjZnbjYyZ1NMWk4wcktxOU1sRFNOczdtRkd1RVE2dlNUWVNacy9tazVMQWJr?=
 =?utf-8?B?NVY2bElOQ1dXTHdaM3c2bFJhVHNwdmQ5TTVCdXpNL1BvRldjeWlHUkpHVUxB?=
 =?utf-8?B?UitoUmxEUnJaVm9pTS8xaTRyRjJYTTM0THJQcTRyQ1I5dEx6TDh0ZUhGUkY2?=
 =?utf-8?B?OUoyNzlQZ3NHRVpiM3JsZExwRnc3YWtJeXJoOXVOdlJVQm91SkNFWEtHSDVz?=
 =?utf-8?B?clFiOEtDOEdQYWxUb3hFNVVqa2pMRGNVdVJGSU1ocHlITmdsbFZNNVA1SFJ5?=
 =?utf-8?B?dDc1ZVE2YzlHNlNMNmhiT3ZBWGgxRmlMc3RWWEtGZnRzZE9XMG1tNnRLd2s1?=
 =?utf-8?B?dzJwc0lqMzlZbTJtYnl5bW9zb25wNW5BcmVBaEdWSk9pcjVWam1CU0FkREwz?=
 =?utf-8?B?d1RaMzZMankyaVEyZ0FRSG9aWVlQRWtKVUdsRks1T0JQT3JhYUV2Qkd1OUFj?=
 =?utf-8?B?OG5PcjFaZ3plWHVDdXNwbFBtSlpBME5zcXkzNy96UGU3VFNUS2h6YVZnK0R1?=
 =?utf-8?B?L1R0bW9ZbDlDeWpCT1g4NThtczFaWkFoSTZJVWVDNloxeUVxRG1LdGlzbDlF?=
 =?utf-8?B?djdERVRSV0xNNnY0V2tOTWFyZEdjK1Y3NEtpdnZZbkJheTdicXlNdXRodnBt?=
 =?utf-8?B?Wk5LeDdIY1dUOU04RFUrSnFkekUrb01TWkFaNCtoemgxMWRsMFU5N1NqaWxR?=
 =?utf-8?B?YzY5cFZlTUFJTmNVRTR6aGVUeDYrcjN6T1hMZS81ckVPZjZwQ28rTzd3bVZs?=
 =?utf-8?B?Y0dJWnZCSi9heENOK3p2Mkh6Z3NEenBRcGtBMlpKKzA4OGN0Z2tUUWhldnJD?=
 =?utf-8?B?OHlzcmtuMUJyZVNYaTRmL2JKWGNhYzRzaDhFRVNscnZTdnpTSTlkd2hJRUJp?=
 =?utf-8?B?NEhhYUJrV1l5LzVaS0lPcmRCdkNnK1F4R2tITWhRL3o4Ym5sYi9wUWUya2g0?=
 =?utf-8?B?UDBqenh2TVMzWUhldnNoSzlWSEJpb1QrOFJ5MlZ4bVFsdmxIOUFqWGxSTVFQ?=
 =?utf-8?B?VGtyYWNiQjB1VVRaVEZ5ZXZyUTRTWWV1dFIrWlU3a1pSY3ZicGhqR25tdUF1?=
 =?utf-8?B?Rit3N1B4Ukw0RWFiY2FiRzhQb3VEVlNuMHdHZ2JwQ3VjL0poZGo0N3pZbzMw?=
 =?utf-8?B?OHRlWVdZNTZ6bXpERm05bU83RERoaVgyU1FUVm1CZkhFYmdxQk5OaXNycHRT?=
 =?utf-8?B?Q01wMzV6TWxuc0NyUU9KYkp0MkZNdnk3WVV1ZjR4QUcvZEdTTm1vTHFKa1o5?=
 =?utf-8?B?aWhvZTcrUGFMMVp3OGphSzUzQXRsdGwrUGRXd2RXKzlTMzlMdVBiMDhKaUZZ?=
 =?utf-8?B?VzlQNFRQbDBYeUg5N3N4d25vSlp5R1ppRElGdGdhWXU4bSsraUtidE5IOGFw?=
 =?utf-8?B?T2MwVnFMSlhRMmw2Vk1SS1Y4OGFQcjAwRkxRZGY4bGVwZ05meEQ3Q2NBMi9T?=
 =?utf-8?B?ZjZUNEdkT3VmcUJrUlJzWlg5amN4LzUvekl6Z2NEd2dyazZKOVhlblIwU0l1?=
 =?utf-8?B?TGpvbzlRMU9kMURiVUFWaVN2VFZyaDVQeEtySkd1TVE3Tzdsb2FyY3B0TUhw?=
 =?utf-8?B?VE5ScmdGb3dkc2ZRV20wU0N1MGo2Y3hiYk9ZcE9HMmYyL3FobjBpQW1EcVVU?=
 =?utf-8?B?NWZzRkwxZFNabjBJRjkvTE1xU1YvMnl6Mkt0N2MzdXQ3WUdZRGRKOVNycE1R?=
 =?utf-8?B?TEIzNTNxZngrenNZaEkxTFJvK2tLMTBJR1pkMTUxZ0JpRXNaOXhSMGJoSEJU?=
 =?utf-8?B?eURQaUNqSU9TbVNnWFdjU0hDK21xTkpqeStTc0hWdjNWZlZoWVJuZEpsdHdz?=
 =?utf-8?B?QzF2N0h5eGhyY251UkxBUHFRZlVPSGkrMGFGbGM5R1JRdmIxNkZOcDRsd1d2?=
 =?utf-8?B?TW9xeWh2RTZ4RkNjMXlKUXpSTkNUOWIrMUluaURPMXRMaTRXaFRpL05qcVBn?=
 =?utf-8?B?bjVVbnZKMHFpM0ZRdTM4M2J4b2I2Y3RpYy80aHYwVTlhZDFoRFdVY2UrczlU?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gfgFoTOj8jUloyZ6N2Jv3naLbt+/ZOdTO0KhXYc8JyXaULu4OUOeO0BmRS9br77AorNnkQz6vxUecIVynPrwqEWCsKgqF/hyzVbVQK6h+DJI/ZOtQfIQAzhD1AE9DIMS4fKb3C4gUzfecM22RMaV2lWHYdBSgFt9PYBcjJW0m8Yn1Qp09WihIyBD6kHb3NkKxU+ms6nCVQkedjhFMgG9F8rRbzQiwxS76EQaC3+QhXUilrOhdlbUqQM95Kq+o7e7cAbAAF3L+VembBQp3x4Fv2z627BkEOlJJQZE+J9PwRPiat0ZJnMR1SVPO6sVBoB90evdrlLVvvc2pW8YJRrqVQRW41LgE09BYU8k1nr4OCon5VObgMrK0mlM4YjyFoU/Uc+wA6cK18AM6f9Shxj05vJPZ6AmLtB9u/sOUxB+8DAOPr2DM2JZw+m4uNZhiVUVZo6QJl3SrVtwGfS65M9UjiOZuO/kQVLCSYWZROV6q+mPIxCzlNF2m4JbbdEFT/5NNI+YoNsdgjYfTELkCd76KmJY7DZmHo5ju0XluymfzwMT0imPXHPPQ5brpBWeGr9yxJD3V5trI89eecZ4XdXDCuSfr4h6DAWMQEbi4yACupg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a06bc5d-d7cf-44f2-3801-08dd13a4b4a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:13:48.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCz6gsTSE7GDmPHGv8RQrXmw3Sk+/pRR4nCzpPRKf1lowQedytBp3xtNLpGYiVHnneB07UCoE9NVbo2g5ZJt8Fz4dUNGG5SAYHMNr0WsBPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_03,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=802
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030122
X-Proofpoint-GUID: rkx4xngIbjhVB42mCVZ-rxmQQ1tpJmia
X-Proofpoint-ORIG-GUID: rkx4xngIbjhVB42mCVZ-rxmQQ1tpJmia

On Wed, Aug 14, 2024 at 09:59:47AM -0700, Kees Cook wrote:
> On Tue, 06 Aug 2024 21:49:26 +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > In load_elf_binary as part of the execve(),  when the current
> > task’s personality has MMAP_PAGE_ZERO set, the kernel allocates
> > one page at address 0. According to the comment:
> >
> > /* Why this, you ask???  Well SVr4 maps page 0 as read-only,
> >     and some applications "depend" upon this behavior.
> >     Since we do not have the power to recompile these, we
> >      emulate the SVr4 behavior. Sigh. */
> >
> > [...]
>
> I added the cover letter details to the commit log and changed pr_warn()
> to pr_warn_ratelimited(), but otherwise, looked good.
>
> Applied to for-next/execve, thanks!
>
> [1/1] binfmt_elf: mseal address zero
>       https://git.kernel.org/kees/c/44f65d900698
>
> Take care,
>
> --
> Kees Cook
>
>

Hi Kees,

Reproducing diffstat here:

 fs/binfmt_elf.c    |  5 +++++
 include/linux/mm.h | 10 ++++++++++
 mm/mseal.c         |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

It seems that in commit 44f65d9006982 ("binfmt_elf: mseal address zero")
you took a patch that makes changes to mm code without any review/ack from
any mm maintainer.

While I realise this was a small change, in future can you make sure to
ensure you have that?

I know linux-mm was cc'd but clearly it was missed.

Thanks, Lorenzo
