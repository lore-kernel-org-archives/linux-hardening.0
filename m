Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2291A239B;
	Mon, 21 Apr 2025 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228685; cv=fail; b=WqLcBUOpnBSB/GXjjL9CDVz9vYO25IDrPpLOJWsv88NbU+xsEr92YBLIuH4IwPxZTVvz+dMzBKN4jccL9vpCF0Io2NE0emxx2rHsL/3BJ6dFktAFEXSNMeW/dbk9VTiMDFZhIQH4JLtYrqQNJxqsAGCks6KroAv40ctZR6F74Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228685; c=relaxed/simple;
	bh=DW8jiVqihP0mhtqPRGLr0ntxt7veT+hIrAkSusdbb/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jl9UD3yQBDaCHRkI8axFJHZ9gUoNrqUzT28OXzqUy4KEtKMc6p8i+8o+pEst7G732E+08lTpKI6rfzhrco8vvI/awj8/Q86KUOkRVVHQNhfAUDQRZXsJqDFHAiS2ervpt/6wyPFlvfMn7ppCa+looyKpD3LSoJJ0K/f/zkMyF8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SBv9K6mT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nHTtXxGp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SBv9K6mT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nHTtXxGp"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L1CIWX016751;
	Mon, 21 Apr 2025 09:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=YgvE23alGpV2xye828
	XRx0ySm5jGPXiAhGJZeBFhIcg=; b=SBv9K6mT73AGRNxCng7NeIeT+O4QLNIs1g
	ux/4jjFfKI3Mi22o+gRHBWcyjcbye5ODm1OR00nopdPUpLEbI0gcgyLZpPi7Cu07
	8X+6mzW8mOyULA4n+Ba3X5mO6Lrvp20bj2J0uTBGvEtHuAsK8B3YXZAOWGULa8r5
	qVaJbfW7H4bjGlLbXnZ5nDNwrQSiEIraEOYQJSBZS7LH3evu+o3ZIYE2bXZ3Kg0W
	NYQw+rdE2Dl6cWFM4GBAYHkX9gcmQlNu4AF1BlbHSSgT9kvhsm+zqwYtH56/99wq
	mMsgEzKDsxyMFPRaQLVCfJtVczeCO96wCNut43Y9In2MdKsTqunA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644cst5bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 09:43:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53L70Hra002282;
	Mon, 21 Apr 2025 09:43:56 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464297u82d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 09:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suGLbOKsf1cav781YGV7HVqICcyhbZWWzBMNStSSg7BwS7I7hgDEjcp9lGFRWJOPGvFTzIm0hwwALcuaZlJD7rS+3ZOjJZva8jAEhFjfrIEqc0psdHFJ89EUw81eEhYPqJUI/C2YXba/O09ndiRUczBkUE8qXUzLd/f28WzFMku7n/EcFBVjk0ZJnyrcZvaL41WkpDOCe760OEj7q0jT6PQ22gHPvhEZwa+9QbCyYv/jxGqWnfgRDAoMaH6W8XwKxuV3ZaZPAgR82IDd7vdivMiQzcWrAslUVCj75jb1yu5nxZkqVlf4MRZPzT2yGoQD8cfCaCcVbACSznwmBrooRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgvE23alGpV2xye828XRx0ySm5jGPXiAhGJZeBFhIcg=;
 b=iXAkHwh5Tgmf9KwP2L1cwsb520QSrh/Nn+LVH1ju3yruKNH7SOAwNZuH0rCVUDzSe+OfeKoVdQGov8f8gfaDLoZBBVRi5piq8j5uD2Jk2mYHXxlWrGqzBd3VIUXfRAJWT+8IGVoI3KuUR1gQTmaIajy+Yn5nCTIs/xU9iygypo/HGsVRJFu2C1N7ENCa4QoYNVFBgjkC3eFG7evW/FEGBYc68JOOdcFSeCMo2y6T9ZvUs1KyvjmkdFXlqQTnthkqt7Q5rqIYGYsnXzWbJakuo8CtXHmN0kPhtoCgAOMie7rF58Fpqo1079a6d8O/SHZtN7RCpIToKPC4LFxOHQEPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgvE23alGpV2xye828XRx0ySm5jGPXiAhGJZeBFhIcg=;
 b=nHTtXxGpg/FtSZ4U/7AjJ4fuW9zv0m0rWTxUH0uPeeQ8zC2S1QjIfJrznyypAYvyJ9nNmxu7VEmYBBLSWYl50eLIzRi2JyPPpAQyj1yYxZlGURjOrG0bTKsRFwSFl94I2FHgszTEBrUx2e4qYVdUnW7TO92HkoulFHssy7bcMaI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 09:43:54 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 09:43:53 +0000
Date: Mon, 21 Apr 2025 18:43:42 +0900
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
Message-ID: <aAYTTjImzLM9qSo3@harry>
References: <20250415170232.it.467-kees@kernel.org>
 <aAEM73DrpbzdZF92@harry>
 <202504181307.254F81843@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504181307.254F81843@keescook>
X-ClientProxiedBy: SEWP216CA0069.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA3PR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: fc05d2d0-a160-41f0-7089-08dd80b90711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hDFPBl6ngV4gTH2rdA+RPsireQFf7AkUimTkn+AVdxW5TT/aDhI7v2avTUmw?=
 =?us-ascii?Q?DKf6JVrwbhpGQnRc7ynva3gq++uq57Yv1kk7I+dNNe2nkrguldDwFyAWdDl3?=
 =?us-ascii?Q?y7eJ3r0tXpyaB6NckWWMrFkwoKjQjt1uTT2NZxnM7s6hVSTMsDZsgVr3DI0F?=
 =?us-ascii?Q?H6BzIDo74w3+4emIHhugO1c7YWpuAOOUXSzHHXIaBNEclOOz4NYEl5tNsftJ?=
 =?us-ascii?Q?CU/oW9K9J071/q6CEa6MWqeYaXqO7DTKP4UmZw9znkOPqslMz/49GtNCXbg0?=
 =?us-ascii?Q?/lPlW8H3FvgQZSvF3h+UAlMgHdwrDyB6hsrPNIbqceH9C0dWGhq/tmUiCWYh?=
 =?us-ascii?Q?jpeXOLBkwXEYYCFz7SQ1bwcqbdCw996yJBW9ixd7UOKw2tavQ9HzkUn9iyfX?=
 =?us-ascii?Q?VG9phD20j0Km/oTis1HrsI/GVhNJ4mMAfEAxCwX9uIdx71jJK4scQDzUMlQK?=
 =?us-ascii?Q?YcmZ+3jVdxPNDRFDdVuI0elrN/OVp4tGc1vbcUnjhAvUuNbpzyCcu3odTGE5?=
 =?us-ascii?Q?qw70QtaPJk0DN8zS5iuFkfcT2NITw0FEN7baIhWVXRcHIW1C3eg+BPoS/y5m?=
 =?us-ascii?Q?DrRJ084zjK9qXAsY7h6cAVr4CP9v5dzms0RbM9LUqPg3LR0K/QJd8kIM+Ur3?=
 =?us-ascii?Q?UraCmB9x72Atdz9KHWzTZ6x1LU6y37I1dEzWtWtFGbsK5keJe0aATHAiG79V?=
 =?us-ascii?Q?7BVVh4DD5A/zEjq0PmAcvkeQHrVe2wFpt9k4YMbmG6UWwq1//HoTkiqHsmTb?=
 =?us-ascii?Q?+3yqCSygOMo+LJrNWYvfIOUhuBplFPrq82VOD6emQRsvnvTfXO91+dKgJsIx?=
 =?us-ascii?Q?1cYO7eA+Tf2xxQbkbYIBPjmy1hGGFUEDD1nARQKzVHECgy7iqAH2P/5vAESV?=
 =?us-ascii?Q?1QqVcuZK33R9pp3WK9HlO9SaNWqfWMrS36rNLQUM53V2SB8IKBCm+Z/2UhWv?=
 =?us-ascii?Q?SSYyc74wRLE3pEI6uhnmRW70Y58VMhyc7VzCiw776zw38iCbGadioEpw7X7M?=
 =?us-ascii?Q?5CsaUDsYZtofV2NzTyA3N1+Vbz1OxI0VMgfDSKh98pSKtktjWftMbguBW7qh?=
 =?us-ascii?Q?M5q4ZvEEGQqF3tJwBBhnKmUp4Ur8+TSSbrjfLA9ETrtSWQBwEesosFhjMnni?=
 =?us-ascii?Q?XRXm7xntJrrmt39/1fE9s2TINsynHVapAxmbvKoRH6PXQyi3AExqh7TzYvXs?=
 =?us-ascii?Q?jtBAVeUMC9nlLcDZQSADCypXR7ZZT3M57DXXJCte4FpwtG/14drYVlw5Kglu?=
 =?us-ascii?Q?MuurJjYlL4cErnFC+sii4rs9ztFEujg9YbT+4LLNPG5sCw8FkA3Le/dsY7S8?=
 =?us-ascii?Q?rVu5/U6FSblS6Ax2EWyAltOZ0/ZxaYSN+SxvIwfiIzCsMd342KmuE4O6yp/e?=
 =?us-ascii?Q?4SIPcL91VRtysMgKd5WPAznyYSrNuDSef3/cdWVAKMdGMVpMbbnB+1fafP2r?=
 =?us-ascii?Q?9kWDoKDjuwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aR29JyBim5Fof7Q5g5OZry7uwcITAoFSY0x7r5eVLsumnEMY8xn+tC5aBe3+?=
 =?us-ascii?Q?N9PXFKhhLJc5+l8PtoW+L7ip6NzUDQhaBAIvImkp/c54W3XAwrjyA6LDckFp?=
 =?us-ascii?Q?7yJNsOX7eMTUXh2h/xbkG/EeMlUGSwZqRXiuyuzgjYSEXs063dq5rmPfUamA?=
 =?us-ascii?Q?FlxmwIUTJuNhrO5F8YncLBAdooKmQy3AY7ANT2MdOdPfx6vTlxXYcUmm/L/N?=
 =?us-ascii?Q?GPoRlJUKqQmPkmfdnpdfTSmGWh+64xoKEMgtg7274UYQniSmLzvqh5WW8UoO?=
 =?us-ascii?Q?qFfc0qYxHYUXj9+4QHi9MoBHrxfMeBP0JtrCmyrEr7M4FPTMy80kLJmX6Qzs?=
 =?us-ascii?Q?h1jA4s2g5W+QXjyrGwLA71rq89FP3tAX0IvAU9+RORaxXRUllmuRIZD0Muvg?=
 =?us-ascii?Q?GluVikBcCuI57Q65rrAIy4qTCNSxaiE0i0nnzDN3dqi1+51YFnD5mBvkEjOu?=
 =?us-ascii?Q?kGWKncvx5Fd0NhcUVtffSwwWfWiKZ3qHdi6kwn88ctxMtGCP4aYK2xcoX60m?=
 =?us-ascii?Q?frOdkwZhTD5j8rqDZB64K6O1LmhBiSVBHy7VorDjLYqD4dYx+1rC2wYWoFkn?=
 =?us-ascii?Q?A/9cUC+hZXD7xjeQK1APMEa0n+JKrlTRmcfmW7msLHnzeTF4+LxgpRffbfOA?=
 =?us-ascii?Q?hSEvXryLyb9eiMPMFt4ZXUnkbNtKF1UENc7+ozmYy/GMoDRj/VMVXSAiJUpn?=
 =?us-ascii?Q?Z+7HApE86l1EavuE83pvDLWc2Y4BCHVfnJu8kN8u5tKeJeWrlrZz6MfZ3dLl?=
 =?us-ascii?Q?8k+n1rAeIvA5eJmD/euaMg8TO8tdwbiVJPp00U4GSxn4ixLlgttJQtW+r4XW?=
 =?us-ascii?Q?52i1I+8Bgu2MqiZXF5AGERQ3sq83HT/1bFekWQFmSYdS20+xuQgptRNjG/FK?=
 =?us-ascii?Q?o08KpkSwmwNLxyXR8qU9OGvKOJxGjqiwNhvTlhicjQus30Uqx2ImG80H0EpG?=
 =?us-ascii?Q?oz0apTNexSWAFFG5s2j8XDDQL2nAB7NadFf+85n0ar627FceGa36J5IOL+ko?=
 =?us-ascii?Q?9unrbQaDDDb2UMv5RN26BUfnWYP/NUGwgIFZAn9YoA9ICgjb/T862VksEtxJ?=
 =?us-ascii?Q?N0PjFlBHAHUxaKSme0xBYAnIcauK8aYAXtQEsp8EUjynK/J8xZnkJf42VajW?=
 =?us-ascii?Q?riGkmTLZBHvsTb67l8mxSwtkCjVWGeDp1QXjsuXG9tFa6Sv6/CYPGyVZck6+?=
 =?us-ascii?Q?/O5im9Mqsfmha508I3nrh7/pW+ufCnTtz4dtx+w0Mz5ucrENEhPPbO+k7pCw?=
 =?us-ascii?Q?6HWK80qFHEKDXBm6nW69W3epVxg0L65/HorJzBIewGb7eU/GR6HE80Y4bZNg?=
 =?us-ascii?Q?Bfj9FoWfxOS9aRjeHLlaZiYpJPucQ8KU5jUqiOPWLx4utX5V0KD7DKwKen33?=
 =?us-ascii?Q?CwyMwMB3mOfqfx1D46cAfU13v0vtOFmXy+sVrJtlr+K7c7PdQ9o50QqGh9tB?=
 =?us-ascii?Q?nNX13CahFasqOpRKGOf+NK9HWEO9FUSoAxGOYjYJAIFDOGkxddXsOx1TZByj?=
 =?us-ascii?Q?x6nVr6R/qGZAn553Env2jE9UukJxFVmd3m34T2T5Uq+nET8u7YPMMJDf6EGX?=
 =?us-ascii?Q?e9Ij7pmvDBfVk3kaeH3KUkIggXmO94Zpa8/BOZVI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Wi1kf8ybgYhDigTDMNsLXo8nLvfR8ENKW0rmJ1iN/OBGSne7TvNB8KsuewbV8UdyAzNaVBnjsp3Wvxn+2hGm6hDp3iQcaRy2X/obMTdu7jX9vEglPmB2+wkweG0vBdIUCL0/9Owd30sRqo4YdZrkoQvaKXmuhRROy1+KyfJT1sSu020P21bIKnBDzaoYFaxfBeRSd0TQnI18FtppAKvNnswrJwfJ/13zK2OU4JdlkUvBLaNh/5HHlctdae/JYqFTDCkR67eV4Ya4andhAvnoc3a+uxBvynbJoxhL97TLA/1cF7RPiBk7/0Jj1So5m3PxxlWHSdh+tT84uYRPJesmquKIg/lJ98N+7riPTW39d1iNvbRNQP0lRXd7zf39u331GFleFMJtMh/OVasYqbJTv6qgEHHCSEcDX6YXD6cw2CrSHoKkRHaE/TCHnbMwE3+KyraiF5TiNfD5FfsAqy3yVqURoHU4FEsy6KPDIcINBgklK1C1cT6b4YDVIp/7U50/TJMcYgcvRdyQ3L9e2abH6RiiBN//kjiIUiei1a/esNp9+OtdoygvbgxWLH4tlB2OHwaPhV099FY1wB9vzDhcvlgUrDeUtKUSHrK38JBvUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc05d2d0-a160-41f0-7089-08dd80b90711
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 09:43:53.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnhAT9jWuIvkBzt4vNFryuRXoef2YyLuKXZrUFE4Q6nPiRFzXNANEK/gptlwArgBC4e0fypRH0JicvRSVsOCKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210075
X-Proofpoint-ORIG-GUID: Xp11RnnPBuhA27ZbZ7e4enm2Aoz8VBBj
X-Proofpoint-GUID: Xp11RnnPBuhA27ZbZ7e4enm2Aoz8VBBj

On Fri, Apr 18, 2025 at 01:13:20PM -0700, Kees Cook wrote:
> On Thu, Apr 17, 2025 at 11:15:11PM +0900, Harry Yoo wrote:
> > On Tue, Apr 15, 2025 at 10:02:33AM -0700, Kees Cook wrote:
> > > Some system owners use slab_debug=FPZ (or similar) as a hardening option,
> > > but do not want to be forced into having kernel addresses exposed due
> > > to the implicit "no_hash_pointers" boot param setting.[1]
> > 
> > Is this behavior documented somewhere or it's only in the code?
> > I couldn't find anything other than the code.
> 
> Hmm, that's an excellent point. I don't see any mention of it in
> kernel-parameters.txt. Perhaps this?
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4568572205ee..982e6511a225 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6483,6 +6483,10 @@
>  			Documentation/mm/slub.rst.
>  			(slub_debug legacy name also accepted for now)
>  
> +			Using this option implies the "no_hash_pointers"
> +			option which can be undone by adding the
> +			"hash_pointers=always" option.
> +

Looks good to me as it correctly states current behavior.

>  	slab_max_order= [MM]
>  			Determines the maximum allowed order for slabs.
>  			A high setting may cause OOMs due to memory
> 
> > 
> > > Introduce the "hash_pointers" boot param, which defaults to "auto"
> > > (the current behavior), but also includes "always" (forcing on hashing
> > > even when "slab_debug=..." is defined), and "never". The existing
> > > "no_hash_pointers" boot param becomes an alias for "hash_pointers=never".
> > > 
> > > This makes it possible to boot with "slab_debug=FPZ hash_pointers=always".
> > > 
> > > Link: https://urldefense.com/v3/__https://github.com/KSPP/linux/issues/368__;!!ACWV5N9M2RV99hQ!No7Nk2rrOwtdh-XVVxppszL38saNKUNOLWogxasxGNiGfiS7gTVkUmDrw8J_YVAsbujlEb3hfb30$   [1]
> > > Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
> > > Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > > Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > Acked-by: David Rientjes <rientjes@google.com>
> > > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > ---
> > 
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > 
> > By the way, while this patch does not change existing behavior of
> > slub_debug implying no_hash_pointers, kmem_cache_init() is not the only
> > place that enables slub_debug_enabled static key.
> > 
> > Maybe we should update __kmem_cache_create_args() too?
> > (in a separate patch)
> 
> The state of pointer hashing should not change after boot. (It is
> intentionally designed to use __ro_after_init.)

Okay. In security perspective that makes sense.

IIRC the only case that dynamically creates debug caches is rcutorture
so probably doesn't matter that much.

-- 
Cheers,
Harry / Hyeonggon
