Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D1273816;
	Wed, 25 Feb 2026 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986993; cv=fail; b=JNQdIm9cyfT5YkC9FWaWufQNFfacKvYNdk19un9alFKDF0YD1KBeZhAtUllP9tGgs035g2PQMdB6lp846gSPF9MQo2zgAORo1ZDOqo0ss5ke8IAypzPdnKKBvbF3lOZbo3A0G0frCFzGq1xGCbaNbrGXjz9uWVeRRriTL98Cwbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986993; c=relaxed/simple;
	bh=Y4vPjYRp0X38hf/j8BPPGE83nFaTUcYkJjT4WL9wuus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L9jq9dMR4MSWCKAcOmOBV5Vns/U0B2QEqHS6kKvoorwZuEg8gMfsR0PO9t088+QHbtaPz4evoIPkflwVowdA7tuib7lzsu3I/brHqXg8rQfxTUNMFK+6X15P6QYX/KrB8JKWDRzoGLuK+21+bMaeitVMz4VY8BrOxVYmu9BhP/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nAc+UXH0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yTVELkPb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nAc+UXH0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yTVELkPb"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIu9cY817942;
	Wed, 25 Feb 2026 02:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=H7OOl4hERf2cBLdnEm
	3ACqZiFIXLwY1sQEU2WQFExIU=; b=nAc+UXH0C9ZiJXhSZD5SeDpnNBfTC+bj6r
	q13O72/XdihdCcHJ4AqyznTtkjwar+jJM5flVLrjKWYaZmrF8I1ius6URhVgbYyQ
	q2mx5AXca5M3I+EUq/DiwRQP41wai+fSkZ86bIreCdAZGgYXfmue076fwDIpXdik
	aOi25XYy4iZLmF9X8tCU8mOMNnY4EBuGAFv9VGXYstZvVa9BIhYg2mdTdfE58sNW
	3OJDhxVs5D4SabD7l78SICCArGK0QT+9FaFXHYKl5IeKeAXI9Xd827tX1KsNfjX9
	iUKPuEkF0+F1+dInLJcPsg7ch84IvKkgIpBJe8rswq8nxIRHbX6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4ardd5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 02:36:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P1vZGL028533;
	Wed, 25 Feb 2026 02:36:17 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35agjwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 02:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAagXsv1UBhbGZ0ayD1TW96q9ASZIuOknky50Qppmc1qoyNssfX8nB/7y8FLDrpM7GJRV+42j5EnNXERHmEbqCs4XE52mcO5CpTKqGRxQqDEOHaPZ127kRkDerIUVFt+n7uf3uwCDn/B4bRq7lOwRUCNFH3MaP9kcjxQWzyWlYPxnQms7ydurOoGGdbWjl1r6Ek1RCYK3zxDxrz+66CUBtE7GX4DcHIvyunTBaGbq5Li6xSsdvssruuEJ/d5VpikSv8JSmHg0j+K49+ZZf16PZvDCwfjOUhVf9JLjyiqEDvY3yMAfnnlrsddJTS3gNKEL+k2YNOiUN4S+LMkTUhAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7OOl4hERf2cBLdnEm3ACqZiFIXLwY1sQEU2WQFExIU=;
 b=B2pFafOOOelfu1PfW7e0FRVzfYcbbXf26zYr/twFK4Vh4e/9sfmxVvCryiUlk4h9Sc9aZ75indNbI4om3bmUbZaiWw+7Ib9gvYabFxyJsUG/dDaEPyTIG2n1MX5o6uylpKSxnqb5YbmNDmTbllwvYTrQ9NTofDna5SXHxWDZVB36vVECv6T8u3/5VMSru3toKlgqmptF9FW+erQhsdaEVOOpASEaS3cJcQqjVWKq+FWKG30SbU2iCh7/aLoYfb5W3ndaehasXLAQiI+W9Gug7tBovjkBaTyRF0VDW2fwAkv764LX4DKWNq4S7DJLAw2r5hLfy+uFNXxDel2M15DddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7OOl4hERf2cBLdnEm3ACqZiFIXLwY1sQEU2WQFExIU=;
 b=yTVELkPbM3DqTAxbPoDT13FbxNEYXwn1LOV/Oyt+iN6rwQkqKxNQcLzrhP23cZGHj3CpqKp4jYTROuj1omyI3MJ2VMEUTL8Ra+1rtQXQNU9Nxh4fKyB+YndNFPEyss0njyevESa9mCA6DOea8/H6vZHqVm26d9vg3OyjlPVUu40=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5178.namprd10.prod.outlook.com (2603:10b6:610:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 02:36:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:36:14 +0000
Date: Wed, 25 Feb 2026 11:36:08 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] slab: Saturate to SIZE_MAX for allocation size overflows
Message-ID: <aZ5gGLOWvlRx0c8A@hyeyoo>
References: <20260225013954.work.319-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225013954.work.319-kees@kernel.org>
X-ClientProxiedBy: SEWP216CA0011.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::8) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c617ef4-3e3b-473b-3bc8-08de7416a4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k3BKVklNaihNggDI7teQT0/HzEAELqXS0d6R0x0tltcnBhzNkRNM12Gont15?=
 =?us-ascii?Q?/eA1vb2Pditg3cpycgRXzi7r7qY+ac5mDXwtkOMLK1f/Pq4Ngiwp+cClsHmP?=
 =?us-ascii?Q?+dwUq3+cSM+0k6u7+rckmYU6uXkg8v5zLoqKaYc5wnJZ3GtkMXORwYkFCPvV?=
 =?us-ascii?Q?jwO/uXYMX8XqYd1biFWry63BWuX/VzLlAH866wM/UAdMUUzi+Q2xd6HP8R5a?=
 =?us-ascii?Q?2uB51CoAaUym1MZEm6vlBl+AfscQgkWFWN1qigLtTlT6zYd8wqVENSOCpuk+?=
 =?us-ascii?Q?uTOhBjqgJRvxamJxfhtyCjXXgU/9QT8WpF1sZ1BSRR7IRPA/aHUUvLNN00L+?=
 =?us-ascii?Q?sWL7JzhO7dY7wteVwkagTGezsU6YgArlBRS18wxKTYMjNucn1fcb0Zwg6/JP?=
 =?us-ascii?Q?W1j1s7pgAol/G+jVavRxFd/xLxCbxmcdpale7t1efD86lWS6tmxghJE5OXzN?=
 =?us-ascii?Q?4RRJsPiTRaIQXlsETA+IyF165C6SzSsftQ0PwyoQ1hvpiuclMoDVp3RWxf0O?=
 =?us-ascii?Q?6q2O52C9S4ECMm8etiOx5VnOF32hByuDHo0srV+PnpseQrOtF9CUNxSMKWhK?=
 =?us-ascii?Q?41VGKFv05RJWI7OSESeCia7RrG3B+kLSzsWapUWtMmd4KZs1pQ1JylasxUci?=
 =?us-ascii?Q?CwJL2UhxFMsu6dPod6xFcozjzm13cWj+lZ8VNS7p/RrYlOrKwlv6BZ73NHOU?=
 =?us-ascii?Q?k/YlIlrpd4gNO2iUUOrlcrW8oDBmZtAu61wNkH+Z00nY4OxazPfH77l03vSh?=
 =?us-ascii?Q?VJP4Z+4jPPyG5hjxDaoG8kroVOY7+J9bwJsexL/6vJanb6Y/CvjQFxg5aRSJ?=
 =?us-ascii?Q?0soJqZawrYEc6lun6QqRMrf3/3de9CNp8eeHZkeZ4p0F479+/APNL8XB5tMR?=
 =?us-ascii?Q?7+llVOTQNsgHzAMFgMpq49z7CFpEO8j2+D2XLE4nzCvSCeCfaVhMsuJVlsaY?=
 =?us-ascii?Q?dcK4qJFIsnbJme5GSoOuPG4zF0PT0ohxqSWQ57BZrXjUrlGmaZXFN1nlZMRi?=
 =?us-ascii?Q?FMdBbjX9WLIRk7Eisn7nzDfAg4LukmMi8Z01YXQbcBCFlt5N4kBA5Y0l5POR?=
 =?us-ascii?Q?4XUBesHe1/6CspIGXNWXcJeJtFmaERCvbrv613HU+Nr1KGNU4J4PwMab8IVc?=
 =?us-ascii?Q?OxwS8LQuWBeorgEoK8LzGjOH/PeKhl2hwBquMFVy8vp1LE2Mw2t5RPAzQiRJ?=
 =?us-ascii?Q?O1FQAUS2oHuH533yWaqyEgBI4onZoj3icw3Q51OQKf1iSOtetBwR2WgA+/NR?=
 =?us-ascii?Q?lllfiSXMlg/HHUiNbtTdo0wfMuaJhFjccuecucIU6ROPG0txnrdELN8f9iRe?=
 =?us-ascii?Q?YzBRLOHotf5Jbg70y3j+5xYwrE/IJK0Y9WfhqoPbK16OK9W/jxhbvPQC/s9F?=
 =?us-ascii?Q?hDimKdlY0LJvFZkDZGsfyeLL0YRQmlRSVMYE9A171QDduB6VZJIDip+XXBTN?=
 =?us-ascii?Q?wgIzkLGbSVSFRjFIMieZFCHDBf3/vsXQs3V5hYPqfDMvyYadsL9nXarItTlv?=
 =?us-ascii?Q?3z7BOKJoTe/vB6QnJPAzIcS22veG3oeLtkInVRExfRzjhf4jefv8DYxuzd4+?=
 =?us-ascii?Q?qPRhyEIi9mJNRD8Duhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tWCYPtE+vatlcw8LoBtxnABniE5SrqfyDWjr1x122veWxx+fHOQlelp4hwwu?=
 =?us-ascii?Q?Ws3QJZk89iFrf0gKzZrw21j5LZhEvp5A7ELkkDvDaXrHsLKs0ABvn+QMJOF+?=
 =?us-ascii?Q?IDLsNovbMP5svDe+B0cxVSupDzUwCJRHqa76JQsGp7RrNgmZ7pk/8sp6npEg?=
 =?us-ascii?Q?Lr5pGUGjNfO93iXT3BNoo3OZ/KWG9c0yX4oIwKe63dXhzSgsT7pM/3meU/qx?=
 =?us-ascii?Q?IfzwL5cVsnJJ/diyho1xRZrH8lYYg5sPFQWdcqO+B80gMw2ScsN1LnG7sW/B?=
 =?us-ascii?Q?UDlQyPkDvK1v4E0jPtQFNUzyty18zNkDDu6M3NvXhtW0A3dqap1ejYHWXoDD?=
 =?us-ascii?Q?4Zlh7F3+F+J7dT0gDNh5wpIT/RYfpjp0ZoCYKQxLb+Fp5jdhtNYUFMACa04L?=
 =?us-ascii?Q?XExbIuQqlNmDdaUTMjbpqSx+PDLRLPUOOvJS4okU4TgVFoDlsGM6w31WO4c3?=
 =?us-ascii?Q?zJmQSCSz2zu380DnlZgURV3LcoJhdm6w6YH7sm1R3JWPdhGdGAs4X7pnkstf?=
 =?us-ascii?Q?e0t6ykuh8SmlEC/pCYNjqQs47v45W5SvfY2eWwMT08Oqami8bAoo6i58+uhJ?=
 =?us-ascii?Q?X1z5Imtg3lHownrS48f4G3M4ZRquJz3XdMWBvOWivXoNVgRjjYMqAeqbUcs7?=
 =?us-ascii?Q?928Mqje80LuGQaWJ+d7BPLFRwG4AD1GAS9hJQIuNKIKhIg10CsXKTmRNCmgA?=
 =?us-ascii?Q?9/YOuvdfflGkVe850rLUgISttQHUd69Z7rf0JyNHpUb9z6ya2/E9muBwWlON?=
 =?us-ascii?Q?U/ABLVk3PBu1BaOWVYeIDzh6kLst1HvYJWLdQKzN8OD9FI0Jh0khJ5p/CXOt?=
 =?us-ascii?Q?l4mX4Aukwr2NqfI7aQNOv3NxAJlkhlYeV68+d3RXdYe5+vFWeBy9TGKKsFLp?=
 =?us-ascii?Q?IzxRHXmpqEZ1dBuxQVHdzcRykm2jzLBKLH/gasbZ/9yENzGZ4eBuqNO4IIpw?=
 =?us-ascii?Q?4WP18GmKoMjngt56ncO/hbqRPamwFyA4SotJsepwJdH0uDScTgm0N2UUdmP4?=
 =?us-ascii?Q?3l5zXK9pHlYyXo/YhUThqY6X34mHMPetu1Wug5QY5b0kFQ6o3KW3/bIoI/Ji?=
 =?us-ascii?Q?lXjHQMW7FALYpoppfJgbxg5HCbYZOt52YV7+rCkVvV9WVJ+wst/Ly0kLF4c6?=
 =?us-ascii?Q?v19hCfKxsSfv0ohd9p6hfGIkaBgfdIY6mBQXIonleZympPC3Oc237GR+zfKj?=
 =?us-ascii?Q?opNO3RcCj93voxICydwELz2qfsszYAGnWJJ4OGYQ5GTcIBHcKbrAJYDg2J6g?=
 =?us-ascii?Q?U17OJvAXEzZ6Rof7Fnx8mo8EfSjcaFn9od78CsjPPAkTFyctlElLEdYF1URJ?=
 =?us-ascii?Q?LAzBR+ITdbFH/I0sM7S9IuU2LBVk4LiVXECCREc0Hck0G9QyS7F9SiolFtKx?=
 =?us-ascii?Q?HpP/HXRyRbDqPwXdB1IikVEi38xuyIu3JRvv9rPMwi0ETVrfbHSkkoA+98xD?=
 =?us-ascii?Q?njsUhqc8wZWulCBtYEuX+d76Vvt+e22uoxIcN8PU/qLtljN2L4vb8SBfAcn4?=
 =?us-ascii?Q?Zvph+1S+g9FgRx4NKm4V8GmroZZyUhO3q01zCM7Tk256RDwUy8MDnhMdcJ3m?=
 =?us-ascii?Q?s6bQY0zbaHdtGo9sr+mP+s+eU6PRZjw9iqGyzZhxk7EMJNaGbiLWODjaBuWw?=
 =?us-ascii?Q?Fa8YYaewfV5wMamrmgYbku+ZyWutYs335281+5OW4liqbiHvYK2fvTqll7yR?=
 =?us-ascii?Q?MxdvSTZyCZSyQJt074tj8CiENrDOe9HTh6XiSyv3YOfglWqGQD/PBmkcI3Kb?=
 =?us-ascii?Q?dvQRmcKSAA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SUShxQDoLGP3MlSOCnLxcl2rETq8IREgHrVv76U6sWscy8cwNX6/zK+8th2YwDYkXVI+I1m4k4NP4zUOto+rrnUG1XXDxNKTBwjFJE43YEFGBbhmQsRbJMNrBU9Za7D4+i82yg6E2P5fwML9xT2b656W+q8HXATy7eJtGtC9hbf97+gBUwNATRCQI9EBo8AZ9l2JMpn4fuXAD6PGlDDoIQ2x8UWhKPYFvub0IgnN99+z3DiiCP1lINWfCGSW5RKfcuJ3NYFkSWicTFN6lnrKqHSsgw/25sZDW/io5FdE/AWGSDvrMEmV89n+/QXn1AkxM2SbD+jXak4P3pEzMHkJQeLRRpZdOs9YgAiRCm/SFkdfJtpQO0QSXjtqDHMJUffjh9AmwzwJy8OF6if/fL1gSsknOvSM2knrNPS/BALjlU8k7Elrampc/kecLefvuyUym1jexr1ZIRVizwmoN1bX7yxJvnwJ/+XqbtD5RqAtdS0SHsfa7TaWlULef6OJzBWhxV368eXFZbaSHLA7MxvS0P41FxiXj1g01nLlez/dh6rAyuPH7Jp/BQFgtjxAfJzkJhwwkqR0m/TxzZ6p4QEZgh+bGt35eRwtWZektsTwYgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c617ef4-3e3b-473b-3bc8-08de7416a4e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 02:36:14.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN4kMKTXYrf3fB3aAaZYFrCQ6YVGVNjRUYOXaijfCrvJHStcfTMkD7oVfLq8efOh+qRZL0i9JOBZqKxRxIHb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=836
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250022
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699e6022 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=6aWCWNOAXrGhXeeEtyQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 7ota1PRW7Q09pZQHRzvW21EGUV5GLP0P
X-Proofpoint-GUID: 7ota1PRW7Q09pZQHRzvW21EGUV5GLP0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDAyMiBTYWx0ZWRfX1T0KzBomjcGH
 WG2hkScf+X7EYjNhfcR5Lgg138IVzF284OXUL4Lv/znSgzMC0pjISzAakubQl0YmgrYkfzpXDK1
 3Vr9Fu3b0cQGrcEHoN0zpBU4AE0XnQuDB0ZUSm5zPDMbHiyY8LC5sgZAXRDOKBFE8MtfLdG7rbP
 R7BGbQyG5CxdqaSdB3nBwruoBXPTAcqkWs2Q2EtTpTKPtVDAZ/DWP6HnAgbE6xwWcx8nIPJxYcc
 cUG/Wu8joXs1KB4WAogXSco/nKhW+ujPCQcOXNnU9T7tK5RgpUQ6BQM/vOMEY4oua/0I6knXpZC
 kOS1scSQNFyZwk2efdkRFHg3NmiOHbhTpvWAQaBxUAHrbtZ+uQd+Eo9YVOlBvxMCbY7QnYR3pUB
 JDsRP+G6/qe0Q+TjhYYQ3APCmgZI47tRo5aiRot6eUcvZCFAqILHMV/13FGGndUa7I2SQiFo4e4
 TOE0bM31WvWSBAgJQoQ==

On Tue, Feb 24, 2026 at 05:40:02PM -0800, Kees Cook wrote:
> Instead of silently returning NULL on size overflows from array
> allocations, saturate the request to SIZE_MAX so the error will be
> surfaced to the allocator (and still return NULL).
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Link: https://lore.kernel.org/lkml/a144cd1e-8bfc-4380-8f1b-071db0af0b2c@suse.cz/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Yes, since it's larger than order-1, it'll be passed to
the page allocator and will hit the order > MAX_PAGE_ORDER warning in
__alloc_frozen_pages_noprof(). 

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon
