Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5621504E;
	Thu, 27 Mar 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080476; cv=fail; b=qecM6dDp9Z3Fn7SonoHLRZL/IGXFmSSfx5rBJpoeTQAjLv2h0Igb3aclJEZKWfSBhHmZzH32wqa/jiGo5iKK8CMC/Omkmgdjp8osurESiHfF1LHD/iUEBIFtSkK5lmxvTnS0WJy5Slk2jlt3H9Zf7JgfDPlA4OL5SiFyK+w8cLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080476; c=relaxed/simple;
	bh=G6gLLyIPdMsPAM0kPWX9H3bq8dBGAV5sQR9kGI206Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qtSZwxP7T29h/yFxwgi39CEoYyYfPvAzz6LSCGCYF9c+Mh63XkhkjJxiyyafO0MzrpNIIhFkkjeNuvaBLflbypCHDwI9tKYA5UebBruslDN5uapzmCn7BZe/InxoQCMcdJSD4G2UA1LVsxBvIvwBZoflFaH0xA8Pf6gRlJiIU8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hWWDRzFR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kkei+LaF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hWWDRzFR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kkei+LaF"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCTJPY002568;
	Thu, 27 Mar 2025 13:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=XTAmezMk5IAigNODDg
	CJOUqiXaiSx1xTLPu/u9KF/nU=; b=hWWDRzFR1p3VLbE7fp8ySXLkDKpG8NPomz
	k/DPNDch1WNu7PGKnHCFdmwdmsTN7GA4D0MTYp6acZM8Y8EatIGmoy7YKFRe0172
	7KjmO4Mwn5wiT5zhsc4gcLICedny9/z0FWuduBM4FMn0q439mMmNKnD2zDGLit2y
	cMXLnFCErNP75nFDCjB/wpy3k2SDwsK/x6vw6Gphaj98h1jjEBdJ98602KVoH1wm
	GtxJ2QSQOjnLRTlOyXjd/nYmvzrXJtG6dhuWk5kZoKWRw7RfRBURdzbLmTz3756L
	BaCV/Q7FpHTl1fKwV04dFuMCdR0/ihNJ4OUY6HeU/OgK5mtOtcaQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrvc48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 13:00:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52RBJd8F029572;
	Thu, 27 Mar 2025 13:00:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc3r5u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 13:00:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+RmOsL7FsWBWoSkxQt9NZcyfAxKbHEeG6FaA6w8s6atIRmMndGdCl+FGQzqTf+yQ3Hs/lSJpOsyMrp4qbVo3DBYjRFuU98va4kJOuLzS7/rWm7Kh7bGbZd6Eque98q34iEH6e0pjNvNw50P9pfyDKgLnVsSfB+t9aoZqRDFFJ+agb2Pu4d0C/JqeX9fJH6Jb1UILHDek01YZRNt0r5xoI4aggLmn08DZr3oZiBRbajUxaSL616D51RwLtQWZCcx/qYQmIWCSeU1sKthIEsj0QiVHeoUvBhg46oFkP7JAnsVLjA2OcKTMaqbUCPFPhDZFk5dA7eGhWylHtIBQekEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTAmezMk5IAigNODDgCJOUqiXaiSx1xTLPu/u9KF/nU=;
 b=qlNzswOWCWKjXqCat6P9IEGfrU53yJJ2YzO0Vn0T62Wd+kK2s9sn+2d14pdAt9baRgL7UMbCNXYzZZBwr6rYgcITRiOaPxbsrNdWOVsdua5K0P0a84pZ6LSjAYwJU48AeMgQdWexLLlRjSJGVOvk2u1AgbGtuCLg4bY9or4aqcm84SzC29KLQRCC6S3HHgi7d5mFc1f2nGyJnxQ+E9vSCLCNn9gXmGtUe9egELeUpVQRkipxVsaprZWFSbRxE5BIhCDr7CpBHX8aYYNUsZwn8cxpDS7ZYwpTHUUQQcIGMLeOgWx8YQppWj98sjwUghGaDNoXE/IWyWcEa9+AsPgRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTAmezMk5IAigNODDgCJOUqiXaiSx1xTLPu/u9KF/nU=;
 b=kkei+LaFpXLKFklHoteZ7ZRQOBo8g88Yq+K8PxsGMRkPiAv9sRmKO1lHeGtxDFa0h+SOF3k1gg2yEDAG/HYUXPrkv0pJ5Kzav1HCzbxooNzIxJL+GBWYyCwp4K9WYcDvJfHpVFsGKxujw7qEpqL7iuOHLOYfKVwPEJABRaUbZX0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.27; Thu, 27 Mar
 2025 13:00:38 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:00:38 +0000
Date: Thu, 27 Mar 2025 22:00:34 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [RFC 0/5] slab: Set freed variables to NULL by default
Message-ID: <Z-VL8ptvIVL1A6po@harry>
References: <20250321202620.work.175-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321202620.work.175-kees@kernel.org>
X-ClientProxiedBy: YQZPR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: d6452c92-18bb-44c8-a118-08dd6d2f5efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FsdDcb3sEbVYMuwjMhb+IPY797339nHBuErDX/YtTL5U/EDxYWq5nvbiHVdl?=
 =?us-ascii?Q?t+8qSQ7vO4EJxK5aFCXpPnBKLsHPz4/yMbi+TEmE6Wfys9cJpKZXqncyDj63?=
 =?us-ascii?Q?90fh4Xe6+aQGhsBMTApCQpsq4e041BvpBphl5YzJRZBUchWzQLBcjEPLHoGD?=
 =?us-ascii?Q?k/0E0+ESQ1JNQV7TfmLk7hMXK138QZ+LtymLXai1ApV3z4qB3alWtXHZAQwT?=
 =?us-ascii?Q?3tuwbdvijt335Dbl530ojZN4dfiZHF9rkvr8Jm5i5SyjDcF0XTpkCk+xP7lH?=
 =?us-ascii?Q?dmaXXPb58ZjlPGBfqMWE5SqPYgxwXgU6zaBg+WIvjG+kZqa2F1fE1urLKBRG?=
 =?us-ascii?Q?VuA8MOGHop24UHejfZOCVhGgj+bt/2o64MWDJeEyw7QimjTx/fROUEc5TQ6T?=
 =?us-ascii?Q?odXuEPHkWvq8Z3KblNMoItBVpHyhnDA+SqUZ76alZs1/rZL93NVj1pnDsYPb?=
 =?us-ascii?Q?asT3ZziqJsynpoRu2s7UibT1P+qKCqib8GKDQCW0h5mfqO0S/81DZHaj3xkX?=
 =?us-ascii?Q?BTpIkjShN0VpIZc05QsQ/nv5cHMBRAf7dyV+gX+j/JC+kD+hImDCgvgSkokY?=
 =?us-ascii?Q?aDqB2piEAtyxXUNibbbp9FcTIFfw3bHTpTa7DoCbhoc6swhoydUUDX28drhS?=
 =?us-ascii?Q?wKZ0dftK0ANgWdC14pNkQJnJMNu9izirgVjK6lg5i5IlcQMvo1y/viE0DmPT?=
 =?us-ascii?Q?MgFwtgGEQ3A+VdqbLS/dN/EDq5OHucJpD6t0BmtVnmhiKceToM2GHpSlS3en?=
 =?us-ascii?Q?Vix8kWj4GfANiEw9ZLpFxcTaFef6TIg3xA2ieENOifEGWEPooMp3nBp41+FP?=
 =?us-ascii?Q?iNa2uvVDgIc6ziYJw6mzLDOhu0X/COkY5jbMs8FBoTNNrId8EgNfQTSxmgIU?=
 =?us-ascii?Q?X6ZEfgCmOnQg0p8RaD8EqvD6MB6F88lA4kFGdd1cH7MBQS1vGLQqBlwSNlFU?=
 =?us-ascii?Q?RQWdfGvXTUg6+mIeeEpPXDTv76nP0JAQ8Exl5/m1qA9h1ZwCSu6rNHkq27bu?=
 =?us-ascii?Q?umWehmVAr3AzIVaP1S4iDY8kqGBIokeLYWSE7NQbvZBqCr5xRjALD7BjCXMN?=
 =?us-ascii?Q?6vV9Gm5ws1z1VdRwynr6k2hUBCHhLi89UU0zDw+h47B68VGxUCvfSUV93vF+?=
 =?us-ascii?Q?EjGHByhEdzaKi2T5tbrspciJKyTkgsmapVVYNwrcJgaQ3gtbeeotTtpEJjO6?=
 =?us-ascii?Q?awb87icu7ekFE+hqgx743iDSNGMfxzR7c6XHwYD+szXDF8BzMBz/c44v2wYt?=
 =?us-ascii?Q?FO5XVab41MRpu6N2iVtwDTZ7zicLroB6hLC7ih0UQM4NTnsC/QyuAO56bPNi?=
 =?us-ascii?Q?zRJiWS2v+5JcKJZu5OMElT0TxSh90cXf9oSbY9gClscF+upCd86d/mH6PZgZ?=
 =?us-ascii?Q?e0bPgx0T0sXhu0ZWNh1KEXkLBiO5MZArtRzvucTStiPM3QObeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CMGFv+e/+Godtu8lRxtkMAntwhDpYuIl/kATSNwJPNEKbqxR8CY75svdKTMl?=
 =?us-ascii?Q?6x1UA9XluX2DBZXHmpL3eA5406TOJ7JtaXFLkA0IqjKwphi7GOGrsH1MMURX?=
 =?us-ascii?Q?v+uHkNU6hkk3tJuLLc15dTU7GNcJGEj7ocnKKgc+dqVMoyh/NI9j5pEIV93Y?=
 =?us-ascii?Q?woGdvceKH42i3JH+6cAwkNS9FxoV9Tqod/n2eYC8P4nzKPPIKj6whpcCdRXT?=
 =?us-ascii?Q?ctvDqrc5EbC3EKjmLJvYSHFqf+5XyQeXw873fyonwzyY7fweeKlVltv5drNl?=
 =?us-ascii?Q?EQadVZ/V8fxVvCPK3gSCtEOp+ew+vh5wGVYyaJb0HXWNQ4nt066ULRoja3cI?=
 =?us-ascii?Q?3AB6Civ7ApMg5VWPIbjImzVJQcWV5m2jA7KL/ut4YODQmO3xcWkkqQsCx/6h?=
 =?us-ascii?Q?hkMZcJpsjdGPW7c/0FLLgu8oclv0o0lSmOmS7/LBvnbtJayoHHpmrtG5FxFx?=
 =?us-ascii?Q?q1Z6ca3+l8iHC1RofnSmGsBJFyY6FJ2Qcrr8LU9elD64SYLijaiZv4yLbtzr?=
 =?us-ascii?Q?trzdqRXjGQxMbMsrIVnmn/VZ1CIXjzKd31LR6jOjDRLrvfdiBwd34/qStHmP?=
 =?us-ascii?Q?PBFxYbpXvExqGEqSI2nwT5+JLDp9TH7IgrNqA8sRX1QUyUakdSEo7A356tJt?=
 =?us-ascii?Q?3ak4RSmv+orEYnkRjBPDzOl9GAf/yfMbcxPE7/dpvDP6YlroAZHBfG1NTsM6?=
 =?us-ascii?Q?8xsGR30XT2LQOx44poaT/FbPHR+MITZ03D7Z5o5NTZPSxHe8a/uHR282Sx1E?=
 =?us-ascii?Q?G52jyUx2tNgMFit4+qX9bZfS7EexoF4JAkW8xYuKY2lQrpn7ri7/frLazXmf?=
 =?us-ascii?Q?TdKxiGLWC1mfVGOzEuqH9DjjGLGXq81y4NV3y6K8Sz11xSlGp0a2+Xtn6zpq?=
 =?us-ascii?Q?d20N+DV3KhxYvhiXpkhEbkN6dIy6gy/EE4sAAn4H6bZHrcscjk0oy7dgYrw8?=
 =?us-ascii?Q?E6/s/3faLHOSYKz4iVOC9020uz8gYtyS9uPjCYV9L5ZNbM0lijWywMUNL40o?=
 =?us-ascii?Q?EZbgGEKAuiw02gTvi46wPDYtFzegtdddJJ1YBJM5YWKlLtzUYcklKhGgOC1N?=
 =?us-ascii?Q?XUbFsWs/d5q7xq2Hp1JD84oX6jKcm9dBiq7noaNBcexRLCTSAW2UsQTjGagW?=
 =?us-ascii?Q?Nq9E5UTbFmmndGQfrqzyxN5aGdpKj2NrDhCiOQsAi+ygKYhTFtHEE8FVcdxa?=
 =?us-ascii?Q?VmGkXCrLvtmUIeMFxZY2kWgGm/y1W+jyltDJ+ttkM9PQI2ucXOwuGDtDrnwT?=
 =?us-ascii?Q?ABw1BYSi3lA2K9Tw4bMS4xR/A7ZnS0bGmr0Ju8QIrhFQ3j0XC2Gvwejfaep4?=
 =?us-ascii?Q?mGInXKwFUnVpR+4zPePrcvVxzcVI0vOfnjW1Q0WdE9Nx7P0QqZTXSoLnFYzL?=
 =?us-ascii?Q?bHljMxFfx/qtZUTDHIwbyvrlAehMPz2uBWQ7G3EYHpgoRJncLy1nNlDIXNUs?=
 =?us-ascii?Q?c2vcfMZyLJIofDhx5/80JSUhBsYY79Sn/JuhLnKTrE/VIYlgZ1Xo3lyxlt5n?=
 =?us-ascii?Q?A8WAb9pa70Les9SKMhF1q8QGCZfOHJ9rwOrVPEo3qTg+YtZl/30DJefsSk7s?=
 =?us-ascii?Q?zS4Po2Lnu9qijz4BIoZ3u9z1bj3CdUSe6qjNSLoc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hbAskDJJ3m/tzufsnbQanKFE9E1fSrDwwiFlCNvbn7U7bW4mHx9vej7w+c4Gzk25p3GlIKmsg6udRHEcTb9Gfz9u1LGWc83LyvmQOP/MfUH5+CRC8UfhrsgiRl3IJ1/DPUQanPiIc5EF8pKAWsPf22BWeJMEOhCFPoMyglWuRtFfFib1+/QqxpCupdhc2/bt/UonNB02EJejArp+CaQEb3RSI0iltJbcqDPShuVuzh7Texs3VlsYgkEpMiFTZttpIZgNOeznQTgwIIYTq95qrlAuQyEyrExz+cUVHPStqpyBtzs8PwsWwBboBB3wAg9LgMaTDIgCMqusz0lNqHMrG9oLIv+hTbiCZQKfSkSLmx9dmriWrE9frNPrHjMGhR6Wl/fOZA/gRt4X0+3k6cx7m1tHOWRHaB7akcpiorLrJqDr/seMbHx4FrGjke9xLSFcXb/eBMjYllXth0xRmgUm9T0VIzV6dTUJ1rtmLu/z+GOwjKSRyXpYvq/l2IJ2JGCi0ytEH/SclQWniO9Rjgl6hM1+aL8QXX7+wuvZgoNmA6eZ83mxODWdCjP6bAmo3V0o9pRyAMmNVbsV9NPtfFCLHO79suBKnf71w8pcfSHZKc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6452c92-18bb-44c8-a118-08dd6d2f5efd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:00:38.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkmW9Mz4F2TsVkN6T05kjTaLVrRIWTXva8KlQGPtqE/oVEbzCA0Kp6nLuwIJT6erwuYWY9iWIi4crovn/Huygg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270090
X-Proofpoint-GUID: 4lh4HdFxkiMED57OMgZxgxLU3AI1zeV7
X-Proofpoint-ORIG-GUID: 4lh4HdFxkiMED57OMgZxgxLU3AI1zeV7

On Fri, Mar 21, 2025 at 01:40:56PM -0700, Kees Cook wrote:
> Hi!
> 
> This is very much an RFC series, but I wanted to make sure it actually
> worked before I proposed it. This series seeks to give kfree() the
>` side-effect of assigning NULL to the kfree() argument when possible.
> This would make a subset of "dangling pointer" flaws turn into NULL
> derefs instead of Use-After-Free[1]. It effectively turns:
> 
> 	kfree(var);
> 
> into:
> 
> 	kfree(var);
> 	var = NULL;
> 
> when "var" is actually addressable. (i.e. not "kfree(get_ptrs())" etc.)

Maybe a dumb question, but if 'var' is a local variable, is it common that
a dangling pointer in a local variable to lead to a use-after-free bug?

Also, I don't expect this to have a significant performance impact, but have
you measured it and is the overhead low enough to enable it unconditionally?

> It depends on a builtin, __builtin_is_lvalue(), which is not landed in any
> compiler yet, but I do have it working in a Clang patch[2]. This should
> be essentially free (pardon the pun), so I think if folks can tolerate
> a little bit of renaming needed for when kfree is needed as a function
> and not a macro, it should be good. Please let me know what you think.

I don't have a strong opinion on the slab side, but now users of kfree
should be aware of this subtle change (e.g., when debugging code).

-- 
Cheers,
Harry (formerly known as Hyeonggon)


> Thanks!
> 
> -Kees
> 
> (Yes, I'm still working on the kmalloc_objs() series, but I needed to
> take a break from fixing all the allocation corner cases I've found there.)
> 
> [1] https://github.com/KSPP/linux/issues/87
> [2] https://github.com/kees/llvm-project/commits/builtin_is_lvalue/
> 
> Kees Cook (5):
>   treewide: Replace kfree() casts with union members
>   treewide: Prepare for kfree() to __kfree() rename
>   compiler_types: Introduce __is_lvalue()
>   slab: Set freed variables to NULL by default
>   [DEBUG] slab: Report number of NULLings
> 
>  arch/mips/alchemy/common/dbdma.c |  2 +-
>  include/linux/compiler_types.h   | 10 ++++++++++
>  include/linux/netlink.h          |  1 +
>  include/linux/slab.h             | 33 ++++++++++++++++++++++++++++++--
>  include/net/pkt_cls.h            |  5 ++++-
>  io_uring/futex.c                 |  2 +-
>  io_uring/io_uring.c              | 12 ++++++------
>  kernel/bpf/core.c                |  3 ++-
>  mm/slab_common.c                 | 12 ++++++++----
>  mm/slub.c                        |  6 +++---
>  net/sched/ematch.c               |  2 +-
>  net/wireless/nl80211.c           |  2 +-
>  12 files changed, 69 insertions(+), 21 deletions(-)
> 
> -- 
> 2.34.1
> 
