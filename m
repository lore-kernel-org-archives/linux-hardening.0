Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740125BAAE;
	Tue, 11 Mar 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703788; cv=fail; b=bsbCfuHfzHrpVJEFMXwDhzqvErfiM8/hQkK/715NqhpaEXwz/7ETpfeSsfz2p4DrAxzxs6FetfV9Z8ZS9tWGOFJi0ouf6B4srNxf5f7CYY61RnS61pypzWOYxCU+IS7LkpPoncg2jVOqzyQDIXBbBOcYhnQKpPGURonW7bsMNf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703788; c=relaxed/simple;
	bh=ZwVpO8lF/Bsl3OmDksboHBQkmgPCWDG2IT4bXkDr+pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KNWnJrOM9KkHIqzUd22Thlb6FSd6ZainQntjyOQTToY3rc3FB8MEpugjW86kWKuMvVjpuf7al1PLhtK5tvr226TCeTC4+WEsVBbdGtlOTgJNAZAUM51RB09+vFn13ZF2WA/owHeNNnZV8KgxvVVc2gOn0Y/3PhIB+pyU+t2+U6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=janwmKcB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PWUqmb8a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="janwmKcB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PWUqmb8a"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMrCZ021079;
	Tue, 11 Mar 2025 14:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=080ycnLH8AF6I3zPqo
	tJD3mTf6F0NyCyiyN5vlwz/gI=; b=janwmKcBjWUVG0CoAfeOBm+YoG0byE7JeS
	bQ7Rm9Lal0JB3CHQIsjiGjwRbG2W9lFmJC9alvXyioYgcCErHbtwaTHkO0kKeexc
	5KV2n/+gWwgUEMWaZ8++Y2Hd76GV1p9az0+bw9uhhtX+xG8C3nltOPI8tRrCPYDL
	SyDDbWqOAlgSu3xPrXkzl2z30z6oqNpunBZVbTsHUAecsu4UEjbXgQyXhxWL62tF
	3esVS1b9aqkPHd5m79DSn/pMEc3IuvxjZD3/Im83Cx1Zu6U0SvMYHRl7bFCFhhj+
	lmOQHRtwhMP1gJWP1HAxpLS81xh8LrLk1jLUvtta2Uy1aABKpACw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cp350aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:36:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEOtK1026274;
	Tue, 11 Mar 2025 14:36:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb93m93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:36:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrShmB0atUcjC/1Yqnf06KqeU9+5e0nRRcokCbBI1+AX/aKCQTCSuWqQr71heOxSmQFqGATgex7JTGWfrukOJGD4gKWsgzRyfZ7m+ikItXF1ccbULs6EqzDAK7hjM/TwI2L2tYHga+rSJzGN7zbtX15wLqgeKsmFCnWs+Hk/iIaHx5oIvRILJNE2BGeGye0WuEd7FBS+jOgTVN+6TWreciEGhz222swwnNhHM1ge0TCo/hucgDI67Mz7JwkrJ5jq1wO2SgSJNU0cy5W9CcVG/dO6BQIkozgeW7Nb672ZvvWtY4GtG30BYTiDDBKXyre+8zM4Ywh7VVn79CFYR73I7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=080ycnLH8AF6I3zPqotJD3mTf6F0NyCyiyN5vlwz/gI=;
 b=FsD181Dd6Gb525UhrO9t/CpAQfeTxygODhrJOwjX02kfywGXsQ9VZd2C/ihcbNkfSU8EIZXPtDGK1nGADugTY6nWpRK6AXwix5L9VL24g7ht74cOfFuoZcOv/592TKHbjzYXMTwKgU4tOnDXRshXSCG1J1035PdKBJp1vGAmUwY/lugXTfXln6cQAOK97BiU9RaN6x3Aj6xm7wm06I6jDa7MdyJeTYq2QkEJOoin8tPvWDrIJeL2JnWl3LROSuUmmS2CW7uUCWvsY/FtHD/sgkhm5m9vamv2ukZi2/9Q3N+bYHn630qThVX7kpFF7KXYkBTXFktmPdUFO7cmzLO3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=080ycnLH8AF6I3zPqotJD3mTf6F0NyCyiyN5vlwz/gI=;
 b=PWUqmb8ao6WmaB/4GZI+zLesqDCsE/Z276BjDKAmrhsQeWOdMxiUdV9sChGpTInBX4IJIiavGls3wGOrxPviti4oLH1g7bOAfJVSCJZN5Me9mN9oZQFJkDcdTJDZUilld8T9Hy1o7YHCDPDAffaaOQhSSMg6orHwwk7SnlG6yHo=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:36:10 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 14:36:10 +0000
Date: Tue, 11 Mar 2025 14:36:07 +0000
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
Subject: Re: [PATCH mm-unstable 1/2] mseal sysmap: generic vdso vvar mapping
Message-ID: <3f2f341b-6e18-4850-8b9c-bac16906edb5@lucifer.local>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <20250311123326.2686682-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311123326.2686682-2-hca@linux.ibm.com>
X-ClientProxiedBy: LO6P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::19) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: a1657b44-8c9e-4a65-db0a-08dd60aa110b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qASwTkVse31xH6GVCU+5YVH9+97+9dfblaSTGRwJT+oM3MiN6NLtQasFMjHP?=
 =?us-ascii?Q?kw1uP43eMgeAjDX/lKmjkOMJOoy8VHrO+KuhoAUIKlpvuQEdz0zM7bxOt9c6?=
 =?us-ascii?Q?YZ0jCrS4It/L44ltbjumVaoNaZH8WzBi6LDtbwDtimGmz2I0o3+7oVsk1gYg?=
 =?us-ascii?Q?UtDyOpUeubPaTh8nxzGk3TNr8U6fZ0bMt1t8CcKXXSIxzSdEus38jISMy+SN?=
 =?us-ascii?Q?Ehe8Y8amUDoAN9aXP+TCwra0GcNRkiIVJzOJd2LJzbAAKBWr/dS/YxCV4xHB?=
 =?us-ascii?Q?J+6RHkFuVqk6vyw13MhzWGyC8pO7Ob2sVv5BHP1TdKp83z0Gea8qSmJLPEfm?=
 =?us-ascii?Q?kEeyuIGGmqtldZMZDbA4+3CTr44NL8kjHBthafsY8zYLd5sZmTbmiXAFeY5l?=
 =?us-ascii?Q?mvmiuUS48HCPpf8GrSisFhufIJ1Pu5UhPimQdluOc0RKrezWepPMlzshwvc/?=
 =?us-ascii?Q?dCWXIQhZrLibIVVsT/85bCvSI2FgwcFRuJ4U6Vx9dngJcFW+dW+cLyFyfSAy?=
 =?us-ascii?Q?dgdoSco3Ue/p7q3aiwYQc9GxplP205s6ZNVGdwxWxPucFI7BadfJeRaoWuHy?=
 =?us-ascii?Q?9C/It1H58wsWiNSGtbVL2siLyprEtdiWrQ71JKIohvHh7l6YKIPLlqZDohWF?=
 =?us-ascii?Q?OwlnqJvCnaN7t050qdm/dF0z9bwh0AXDFHBUNsYpl288By9L9uhFp5ildaST?=
 =?us-ascii?Q?StlmRn/QPt50gh8jrZG+7pMuS/MvX783wBKSIR/1sd2llB8fFqft2C1zMbJk?=
 =?us-ascii?Q?P0i/NGusqXktQYuYPIoei0hkQIgBRX2Rx2o1Of/RI1S7eQ2wfQ3gjK97wUBA?=
 =?us-ascii?Q?HqAaUv1kFo5m0s5DivqQYuiBYVC6Rfj9XfPfZhqWeizEIYZTXJSxYrxsXzoX?=
 =?us-ascii?Q?ExFG9vCRZCujfJzErnUmnNIHdmiPtCtnX42Cd3US7enB5Bj3mHqCl7KTk8uT?=
 =?us-ascii?Q?oLI0MszWy82yd/bOVTxc2KOaO6uFU6otJQtmZ2r9mcJoYpjPwzwX5EpQHLGF?=
 =?us-ascii?Q?FWUCO2MRNaP0XBEsDvzHvS0yQioE3adOsh7Kf5plh+WWLfMBTx/s7VpwjflN?=
 =?us-ascii?Q?8wzUm/N15HDc3qlHr7BXAYXFcMjH2aoUU7CBkQRzOS4HSPEOJ6aD61dMPXFx?=
 =?us-ascii?Q?Awk5bmKKbQHzD8WfQh19tRgJnbQI2qr2GCx0+jI/nzUZ8SbQBaP5ts9N9C2e?=
 =?us-ascii?Q?2+jHSNoNUhX48HWMDUemo/C4dfipPPkI8pftD8WIsTX3ojPe5/g4SC0QkZKv?=
 =?us-ascii?Q?rDlnAUjFrW/hYLCB7oAfr+t1XAe6KrA2j99cMBuyB6+1tBD0wcVOkG7ILR2C?=
 =?us-ascii?Q?u/QxylvvCsCAl/CzXZlV6M2zQ4Ggx5d3pnqoXcSKDsAAaz4JsdjomWilEsHY?=
 =?us-ascii?Q?RS6Wt/GvipUNmCyZ1IxMctBGjhUIe0XVzGQva1sTqa/KR6eueA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZGLhrAtUsXRv5bnff7FDgHJBtZGr8bCiELGe6iu2msyES40hhWspUq9JYxgK?=
 =?us-ascii?Q?bBzxmw0XE0qUWQE2swRJeVvITTKQkLOHt8TLR2GduL1ED7h1N1v5op/Aqw6f?=
 =?us-ascii?Q?3dj/yrBJ4u6ROp6fq/sJXyAcSv61GRrh5hFV2hWz852hEjt7lWKzQrfYPkqu?=
 =?us-ascii?Q?3MDSoypAXown0cmPbvXpHJqHsVeOyFBcFTHI7NCwztSyUrBq/Lm/7Ydq/USD?=
 =?us-ascii?Q?jlziQw4Qqjvab/+nSNrv2rli05bOU1SC1M7tnHP24hobwFfN379BuKdbE6AK?=
 =?us-ascii?Q?Bmv1BsnTdjPUxK/z0oAI3JgKJ3QbF+qE0xZhSGnW6bjYRgTgGvDhJWjGxzZN?=
 =?us-ascii?Q?9aFXTVRjRGzYh5ME+dHlimyCdxCYUV6vXozByOX036EBnjZuQNuFsKXnCrYw?=
 =?us-ascii?Q?gP9DBqEXCh++WMaMPX0Bthqbckowg+wrdb3XfBPHAlvlELlGCRgZEM9iUip4?=
 =?us-ascii?Q?lk8BtkgtWAoYQA/RUuA/6I5G/LQpHDl8fKDQUpZ2mIbsHFzVsOim15abkrbw?=
 =?us-ascii?Q?Iwhf9q2DpbVILDpxyXFxYK11jlVWi1fn894le3DWknrHYRozyFJpY+vbn2k9?=
 =?us-ascii?Q?G01AW0K9iWVIeO5urfOOLQyzxk1B8R98V0QbH7JzebrnRTtQf4h0Tuamiubw?=
 =?us-ascii?Q?h6wmznFfr6Fx7J3DXiTu7vxlVf8BmK0Z6L63JnqN0Tg+1BZDoBX62qMBd68E?=
 =?us-ascii?Q?uvhKCE3iVhYXGZ2XKvoWVRtuQVtEND6PrV/vX/47TvJYQkabUyoEz0U8EvTG?=
 =?us-ascii?Q?GTs/coJS60eHosED6HZL4ssRH4W40VN8gBc0WA48oIgy6L4QfPmjY7/mEhuh?=
 =?us-ascii?Q?OFblwJcEd9BaydzwhdsksJukEQSuu0dr/14KrhAV28xyNnB0Dsvs6JI8lZkJ?=
 =?us-ascii?Q?d9s/6YhVXVWzvrd4lRt4bSelScmMrkncY6Fxp6tfA7l0TnULcAzEP523o+p3?=
 =?us-ascii?Q?UrPsiWF+7Y3lEnaUhM9FhfOjrdg4eZzqL440/H88kHZ7BR4Wpbvxx51deGiS?=
 =?us-ascii?Q?a5YbgXYWCRvKV8Bzt6KGnB3XasEozjyCuMTlvHbyKjusOQSacXExYeZCMA2T?=
 =?us-ascii?Q?triLuDuV/GwxjgHTrhV0TephVNGhKIfbhLvVoX27hvCw/WDtF9Eh90cJLSZe?=
 =?us-ascii?Q?JCUQl8Ahc/U8+AGx37HPmJYUnODq3ZDesZgyHuCQPpunWt/h7QkaTkriihw2?=
 =?us-ascii?Q?XUGxmL8XZIa5ueCHlfRpl3+PLVg9GViyyPEsyP7aW04tbFQv69c6tL3VKgMT?=
 =?us-ascii?Q?ZhiJKD7IsvbAUzPm0w1fdEIO5CTbpv7Z/9YMkUjhtHnfDySow3++duuExJ8r?=
 =?us-ascii?Q?eFpz2dL4GcL86CJPnxJLlUgg/ZqKgyveIhVwVtw/G+hCWiWwuUmOhLnNhwyj?=
 =?us-ascii?Q?vxQWzOCxioFOtkrPb3hNjCWP0ZjJQxJe0ykSrZT/Gjl7KSwM65risdLuSEGz?=
 =?us-ascii?Q?CWHSm5uI+JI5M+nICYyOpcwYf6I/pm55tlrDV9j+pQEkJoNh6awz3WpcjcDd?=
 =?us-ascii?Q?ij1gDtO3/YvYWJf9XPTM1SkUZOE65gP4XS72h9eGdlPiu3YLgOUVeIZbnzj9?=
 =?us-ascii?Q?TJo3mKSr96+ZGTNy71H9arIMC7wrX+Q1+mj0yDB7T09AR7oACvpMWhrNW3Sy?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LJHgsmRhQDauOxccwvYItax0XZkRqMTm7dt27dDXP5JpfQsk6rc3Ydo3i0A/OnCfeCmNywqSobX0Ue+KcWgTd6TWnOVSL4b737IgQ2W/Zp93y4qXz+XZpIUqWei70Sbo6Q69J5xi899Ieiu/tmnPwHS+tnxQPS30j4uQjzqX6hB7FVHcxGXUaCYqGOmnY+BfvXSKdozwAlMJjUYVU+HuXTHD6g09DWme2WgCc9J/5QZQsKmupBi4ZY01CLpX+YFlkVn/PCUAnmlw3wwne0xhVSHQsykQx+zLF4OnFY6QYULz7Z/Qx4HWmexIaBqXL2pmPiqU2p/nBa+L959gGNQuV9f5KXp2zllT+La44gebVfNqG6PzodFl83PCKIb1RsvzkIb48KlAPyTcyiyP552UyFiup8fFO2XWchuAC5RqTVOFyajiK3cVA2vqUdEQg/P9uijI3BQM4waXjg7ut4GyosvGIgrZSl6yGxIsWg/ORPDYBaS/2f5oA2s7Op2M1b4l4dGiXg2JDpRE2LPmFw3E3/UwKnE4pQlOfempScGhB/MlpDA4y8jouVEqCT3nnwUs2/mSAqmqNuSASlqk5+iIfMiZPHiKRuBA+1Devukg+i8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1657b44-8c9e-4a65-db0a-08dd60aa110b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:36:10.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7beU/r43QimfwxnCEw3Gz9w/XjXtOdKeuAg7NohrNdQGM29NjnlE1i+VD/5RFsMRUTWzDVj6Po/pe0Kv+kQghZ9g4Kn66PHbOPevfcUWXMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110092
X-Proofpoint-GUID: ANErFiQCPzXG1uzu5H39fwdf5iL35Hk0
X-Proofpoint-ORIG-GUID: ANErFiQCPzXG1uzu5H39fwdf5iL35Hk0

On Tue, Mar 11, 2025 at 01:33:25PM +0100, Heiko Carstens wrote:
> With the introduction of the generic vdso data storage the VM_SEALED_SYSMAP
> vm flag must be moved from the architecture specific
> _install_special_mapping() call [1] [2] which maps the vvar mapping to
> generic code.
>
> [1] https://lkml.kernel.org/r/20250305021711.3867874-4-jeffxu@google.com
> [2] https://lkml.kernel.org/r/20250305021711.3867874-5-jeffxu@google.com
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Since CONFIG_MSEAL_SYSTEM_MAPPINGS this relies upon
ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS, this is safe to do in generic code
(otherwise VM_SEALED_SYSMAP is VM_NONE).

So all good and:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  lib/vdso/datastore.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
> index e227fbbcb796..b7c7386c98a9 100644
> --- a/lib/vdso/datastore.c
> +++ b/lib/vdso/datastore.c
> @@ -99,7 +99,8 @@ const struct vm_special_mapping vdso_vvar_mapping = {
>  struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned long addr)
>  {
>  	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
> -					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP | VM_PFNMAP,
> +					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP |
> +					VM_PFNMAP | VM_SEALED_SYSMAP,
>  					&vdso_vvar_mapping);
>  }
>
> --
> 2.45.2
>
