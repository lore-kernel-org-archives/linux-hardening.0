Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150941624DC;
	Thu, 17 Apr 2025 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899379; cv=fail; b=sM7KpzIjnsw47h6jrLjuaLjiUcFLdCH87m9r+lPwEOFKg9+1gyUSpkuOZ+vVWd4EQ6+xDXGVJdx2VJc93Z93B35UcJSdmwH3Djs4hfr8jp7dCERjSnGyOrDE59kCkHffddhkqQWNcDz3Mr70fgLUgccdI9h5i0SSKuDUDFgh9EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899379; c=relaxed/simple;
	bh=xexuvIX0WetHre9JQy1Shy77QPwA/bivctQ+jW2wzsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t0fR4heaKUEznEyK/6CqSifKW3stPxeGmyu67eISz1owKC3S1NwBXGtyPG9tSnPIoFl2dLe+focJzMxPtxFDQaIrjK68IpD/37vS1OQG4OugiR5I8OQYkyA67b4uu4PwohD3mvTtBXWVvkT518VSWRoVq3g+MXLg8rVRXi88/oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kndkGU98; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yHWJxCzt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kndkGU98";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yHWJxCzt"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBpdaE002457;
	Thu, 17 Apr 2025 14:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WDKFvWMXJpi5FqPLcF
	BbjwnhsQHmfxLckJzHytynbf4=; b=kndkGU98p/jBTR/bzWUZ/C48Bb5TN77mke
	TNC21WVsU8cPZ48PwHgcmLXmG4YOhCMnq708P/M6+W2INLmU7dVZ8kQFinqyNX9T
	oOsb/+wsH+DRDJq2vk20I1MMUNqeduHBdCzMAwoxo3Qo+Q0UnqFiSN9Tt1/Qnzuk
	JemW9pr2Qz6nne3K6TBl5yz9pyUh0NrlhccJlovXnekeJnm02C2fUtf3VAkkewSK
	jkuiOTUGUO8etpPaxjDzY2VuT6hWQckMEgvMKb3ThrGUwbr2XS4LIX3DC5+K42Df
	tEHDSGFuYbwZ3jmtwrOWfHdzH8z9Y/MkkJDmmSNyQNhxIqRP/qbA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185mxdqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 14:15:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HDCHSF031216;
	Thu, 17 Apr 2025 14:15:26 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013059.outbound.protection.outlook.com [40.93.20.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbduet5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 14:15:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOG/hCmCh0T4bscUUU/hyufHpaO2deEEOH3Rsj3I9vdsKvvKzC/Dpn8cNYdWKuYxBWbKUf2rZTTam1CoQskNIfij499m4s2hZa+e/Pro7LtVflK+Opbwwx0+WCb0A/cKrf4vi7/Sd6/v+gH3HEhFqXva9pqYahrtPjVZybwwaFsHwjl8mabz0cQi4FMYz4OpJ3c4jknRvoMDVJw8CNVA68GSU6JMpe5d90XjJOy3JSwtz33+i49nfZahDecySktN/fiWsxV61qIHEiIV+96aitRfIecPwsmZsD7cdPURrQWX6bU1VugA4Zw630V51FiVzqDqaxGNtZiMTHHXpaOL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDKFvWMXJpi5FqPLcFBbjwnhsQHmfxLckJzHytynbf4=;
 b=kYIqgkYQIeU0awfGF/M/WzqeZSh5nuHogE7RqE7zjklTBy+QJI3rFi+xjMGs42Fy3eF+20OQSBb/8EwCR5I7hpJuvcMDyBkUTtNdP9Lx/88CJKWzZe54dVMF2qdmOEttCPtHg6ocnl9A6FqyfZo09arxGWeiOcyMjKB9SUi3pS6aodyFgHRqq63lGZkkb5bnSjzPoDvoW4MbwXBRpKydmhjDG1e2Av0B2bAEkcQEdMTX6J/irD5VhoI9kOeXDRnavVtnZVWG1HpzgHEctx9dyiRoXS0K7/rXnWBSl7niZAqwjF/dkoLXPTjEiyOfSZPEgWjx0pql88QPOQ7lbctJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDKFvWMXJpi5FqPLcFBbjwnhsQHmfxLckJzHytynbf4=;
 b=yHWJxCzt6xGlI8SWyNMdBC5P4WPD3eZjkc3UylbQpsKfBj4Rn6Iqsu2h3mxIVTi84nVaHOGeQYioRN7PCt9M6XG6R410V0RhIJnUu7XvtO57uqB+lvt8TyTMOg9gnHbeUMfGejPzU94cnZYHLOgftXvwZr9Pwjy0psceGGi07fQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM6PR10MB4377.namprd10.prod.outlook.com (2603:10b6:5:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Thu, 17 Apr
 2025 14:15:23 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 14:15:23 +0000
Date: Thu, 17 Apr 2025 23:15:11 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergio Perez Gonzalez <sperezglz@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, Thomas Huth <thuth@redhat.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] slab: Decouple slab_debug and no_hash_pointers
Message-ID: <aAEM73DrpbzdZF92@harry>
References: <20250415170232.it.467-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415170232.it.467-kees@kernel.org>
X-ClientProxiedBy: SL2P216CA0113.KORP216.PROD.OUTLOOK.COM (2603:1096:101::10)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM6PR10MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2394b3-ea62-45b8-785a-08dd7dba4ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yF68QenK5+zhl5qGYcszxBZ1Vo8eBuI1tzUCJ/rGZYLJB78mZsM7Iu/CQUDK?=
 =?us-ascii?Q?UZF+JWAzhNajK30Z2qAyEmUfixEsfe4GtsLV2g1jxmKUNhOzMS/k5eY/10E0?=
 =?us-ascii?Q?JjnhIeO55CEc4XM8dES2KFd9g0Qx9spVQvOgzQxy+V5axEtxWCsxT/OFe9xf?=
 =?us-ascii?Q?S9hU50g7RnnZRgvnpA5Rq4s4TBwc6vyJEf58nH0y/ezl2yTqqG+H3XtC5Tt5?=
 =?us-ascii?Q?pV5w6hsarUqkwPnYHrVmUjTVOwoJVZ2qqF5SUytt9fnn5aDdHIShUCyeW2b6?=
 =?us-ascii?Q?d/HnT/QHu6CpA9HiWHiREjPoGfnmVv1Ld1UotZSWVGiJeJS5fqAhVRdaGSSN?=
 =?us-ascii?Q?2uQ94/BjSXRd1s3aPwV9ln2gduAIvJnDAMq/cUkv7LxDxZXxNA9/5oFi2BWo?=
 =?us-ascii?Q?i8ygttjMsMa4EcLHe1lxheT4zVZBp+odWxSrAa0o7oeG+OkZyZ5h/RSdQaKu?=
 =?us-ascii?Q?Z52FjtXYa8Bf6mlVgFZKfYvkiOTftkCMw7e4jE/M9HsPgHRQgF0naJS897UV?=
 =?us-ascii?Q?t55tcP836FqPZ2M1GExvc5lYx6DNkxHtvjoCu9GPXh3CB9kFJzXwSdNmarfr?=
 =?us-ascii?Q?EaH7GdRZvyYVzP0uYWt1kJEuB2bqqzCLe+RHxNoATvSfqnP4pxt1RryJurQ3?=
 =?us-ascii?Q?PrdcT8e/eT0XNwaEJsm3ySdCMJyETDRlpmYUWv/GPnXyr2WgPIYu3HjT6/Jc?=
 =?us-ascii?Q?WethaqWk6kqvXetrC+nvrYQES67Z9/jD8vUu8A9cxHTS3EgNjB8l0kRaQtgZ?=
 =?us-ascii?Q?vXdI8NFl135wR1lJhr7yPn/tl8zX0aymdzJDyyWQiOgR/6lcSGo7fAhKtKjl?=
 =?us-ascii?Q?AGxLHLikttU15t7pTPBTrHzfAdGgHXMgH5fdzAt77AKSipVCKrPMCW7Zvs24?=
 =?us-ascii?Q?cFXvybKEb9N4k7sCiDqZDTcvc47vGX1EI8uZj91JU1cBE2Z3y1omAWYvH4MN?=
 =?us-ascii?Q?vLAdovlmHtXInz4SHhd7ZzApxY8Ugdu2dlZJvGC5zSQdlKr5V3GbUVODl1Gp?=
 =?us-ascii?Q?bmFRyaIJ/2IcOc5Qjh5yZwT3klEjRMlFSIHe0eMmaPi2sKhZcNf0dj6i0VgY?=
 =?us-ascii?Q?B44xc0tQTGfQ/WbjbOo01q+TUNquh7q59JA5Q+m5FSKsRyGb+u1eTmcV4fYv?=
 =?us-ascii?Q?utiuxpPcaLrq71CbcM5ooMKAb8wY2Q0P5Ysc8/uUELjFmWtR8n3F15pEQL3r?=
 =?us-ascii?Q?r0R9b3aaWiEaw50IYG3U63EwcnL5YGVrt9GcWDfVz45/nxGRebO6Hc2eHsq0?=
 =?us-ascii?Q?HxPqZ889oEYdSHrHdOikELa4bT8FamUcn1w1GFXS47h3ySLEeKQwAre93HH0?=
 =?us-ascii?Q?ia8k3HVnTPtp3/gL1mk8Xnfjd9Gp+jQJcvKdigvSmGHwxQhjwSmbC4bs8wWD?=
 =?us-ascii?Q?f2FuA5mbCGVf4MxfEFcftJf+fYp3TqgzhQJbyXrlEeY3FQ/yoLEKfGYHXtuX?=
 =?us-ascii?Q?ur/6npZ22hk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J7Tp2lny7k4/ILQM4IQ2F+6Jr0H3uJqDJmzp8ylW2sFHqauWC9ZVKc654R00?=
 =?us-ascii?Q?FkpPM17nLHopyfMwK19gzLt2NcK3dZ8+CICJAM+3PvRb1goMEyLJWefbarK5?=
 =?us-ascii?Q?2OjdYe4yAYHF9HxYrkoolEi7XGMZ/fqjISQc0+vX8Vm6tkda7pwWcC9RgDIp?=
 =?us-ascii?Q?SpExcDAzjn3d/amacGklEkdb+VOGsPDDXqxVVjc2CjLV1Nuae2t5J6m0foII?=
 =?us-ascii?Q?7VCNBuqn28NUEZHGD5RmmkvDaH0nHFnR9IRQEc9Mh24GU0A3TQl33oruqqoD?=
 =?us-ascii?Q?YrzLF+QTTUdgLIj56Lx5sDHMX9bGHsSFHMwPg/ZZ3NSN6geHJdRTcbLrwEMI?=
 =?us-ascii?Q?cjcQmXieSieLkJnARlmHczCUzvj0IwUa2WQjPi1JRKUtuGD7pQS1w7rQF/xM?=
 =?us-ascii?Q?fQlD0fHqQDYawdWVQ3nZSsdTpe2E8ODOOxNRMsQ1BOfAW7KGF+qPiqNAxYiV?=
 =?us-ascii?Q?PBs+jDmM1N/PeqCv/Zvzu8aQ3GJglmBvacSl9qj+fiNw5l4/MfO1Gykhke/k?=
 =?us-ascii?Q?AvuHUHXakk+nr+NMyn5rIDHu/9yELniDBkHDxrVmexb/8zp7uQmtlrIuJxoA?=
 =?us-ascii?Q?ykmV+ohgbmz5H/LA48X6RqO0BGi2eaJZl7nbCPiGj5a+8xhZr7ea4poHmZDy?=
 =?us-ascii?Q?32yiC3onTIxkROsD6YCfO8TYXNdEmImRSCiFzSO6hYEdR92UUOWmtnLM1aic?=
 =?us-ascii?Q?kT31Om315PJWKO7qlZvQa6yzLwgfB7n/poHS0Y+29CK6q/vecqEtDkA0CCRE?=
 =?us-ascii?Q?3Q2iLmIANvpss7Y5UpLmMcsbQN+Vb6BdaBOp6fpjqfBsNuSbaIu96J9U8VLV?=
 =?us-ascii?Q?Iap+KCesmOqkFsMiqnvkuB6q+c2ed0EKx9cwlndgrBpSXh4lLeA+x4Ji9nLB?=
 =?us-ascii?Q?Z59DKwQVBopY8/mrdFUEONnJFyWD/QMOiYZRmZ+aqH4w6pCZU0twkYguFv54?=
 =?us-ascii?Q?IgwM6Xc3JSDl9idvCZr6ijstQTjxV6zYWf4lnWZ1Piyxuei6mljBrZfAY+xu?=
 =?us-ascii?Q?+mzwIgs4usT6bukn89Ilf08TyPq5ESRUGVEGUyQ5SX9pnJdw+vRdLHlIqrPY?=
 =?us-ascii?Q?FBjqH/PKooX6sSuaQ9AcWGpReb5U1K443J+qTJc2ff1vIaRSaQPrsx33RGrt?=
 =?us-ascii?Q?HpYra+MR7tV6KSbSIG1rAD791LTR4j5l8ixmIIzEqbT+uBf/LNrST09A6F5T?=
 =?us-ascii?Q?RWnYrPUPIJw3YDCN69m4uk194iwtRmYAC7qfgkLksLJpIHaaQuxoP0/apUAS?=
 =?us-ascii?Q?y73Gcc7bdPOgAzJ83RlXBMfM3PaXzo4JEE636r29I5DVW+/NdnmxNlQuC23b?=
 =?us-ascii?Q?I+dBN3qZ+kL9aOOciAsiZN5FnwaheEKGi+RzzZ2OjTGqzIcH5pfVGj0gA29j?=
 =?us-ascii?Q?E6hBrlUfUn6IX7QqiFPySKsNK0dvH9BDHV/elWnjq6F05+dNL6Ace0S1Gwqv?=
 =?us-ascii?Q?JgGGYWvC5grDXg3KYs3ReA1PKNcwzyxyXaDFTtlsO1vx9xUyTSg1tCns1Pqc?=
 =?us-ascii?Q?WO5oBuk7znwxX4N6IzkIstbK7lIW409yFB8bzPZWBT4MROo8tFKVeYFmq3PU?=
 =?us-ascii?Q?j7w0MSJ8Q0nq0Ec6nkZna6tvA9vq813pTdNyb2if?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HoqY7xaJW3THzekc2Buh4EJFkM/ZgcYgOZPhAUt7hkA7XXCAaIZasnNTBbOBtXDxDR9/oPvnJG4iT/uiMgt4a6PUdLVzEnTo4S+EsPrW7JouYPoXgojmzlhnh+kDJCNSLmHNHBX9UZ9h2zrZyx5IaBw4U+J0rRBBncLe9Mx4UwGTmBF4ZfxkgyCjbWYc082xfSj6gRmkct4esa4+OJFLh+BJyeknjaDGANH13hYOLoqDeps0MGd8LbM/8LX45IHKIvD7mRvqsopeZDS1rFJwllkAEuUbPoJqXxivsmhMvUEcAQI/xGi8ZhflpLIMJ7haFo+Rf/fb3GjnpPPfY2tx3lGwnWM/oQlsEgLyCh0HSwxHc8eIbtKw01bxN/lBLsfd5J3aTl1gQWj4nnA+rFy52qal7jtp1raYeXD7U6HKlRBciFQZ4wAaGlM1ZMSE0G3/PsvGm/Ja4SenYY19bvSnSGqIONUnJkY1BH0oxX0AU+R+SD268b8Sm39rXj+I6oZj38UW7zpuXwBdwp5RPYr3fKVGy9VvCoqAlzhwBHYNTHzJl5FHNq9p34bt1at+53IHlLgG1UJzs3wVv+G9Ah9LtFY3A0IigqqBH1gBH3/X2C4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2394b3-ea62-45b8-785a-08dd7dba4ac3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:15:23.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFJ/i7R3NiC/DfrpEtx7YbGGhQMFZ8O/n+TynbRIdFo2Pz+EUEJ9ugcOxpUqxJKJeoKrjvsubBTJ3XoiMnaPsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170106
X-Proofpoint-ORIG-GUID: vfQj61f2NMN8oUVSgsAbX6pi2AW8xCTV
X-Proofpoint-GUID: vfQj61f2NMN8oUVSgsAbX6pi2AW8xCTV

On Tue, Apr 15, 2025 at 10:02:33AM -0700, Kees Cook wrote:
> Some system owners use slab_debug=FPZ (or similar) as a hardening option,
> but do not want to be forced into having kernel addresses exposed due
> to the implicit "no_hash_pointers" boot param setting.[1]

Is this behavior documented somewhere or it's only in the code?
I couldn't find anything other than the code.

> Introduce the "hash_pointers" boot param, which defaults to "auto"
> (the current behavior), but also includes "always" (forcing on hashing
> even when "slab_debug=..." is defined), and "never". The existing
> "no_hash_pointers" boot param becomes an alias for "hash_pointers=never".
> 
> This makes it possible to boot with "slab_debug=FPZ hash_pointers=always".
> 
> Link: https://github.com/KSPP/linux/issues/368  [1]
> Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
> Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

By the way, while this patch does not change existing behavior of
slub_debug implying no_hash_pointers, kmem_cache_init() is not the only
place that enables slub_debug_enabled static key.

Maybe we should update __kmem_cache_create_args() too?
(in a separate patch)

--
Cheers,
Harry / Hyeonggon
