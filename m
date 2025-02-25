Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C233981;
	Tue, 25 Feb 2025 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740463682; cv=fail; b=R9E5UaIh0Vm1tVei4TPmk8cxDo9AP7cUmt8cNFPNIFXzH34lZGL/A3eXC3s2C+tcUwhEBB723AaEFQkE2sPFn6GekJYG+JArJ72sLm0C2kzT0SYjjQskhvo1z5HQ3t/oNzmcIB7K8GW1kdngJdGQ1L81z9qqkY0svOecVNjVD6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740463682; c=relaxed/simple;
	bh=F3g0y8H2pxam8JVmLZI/67CGQBh6M2WTtu6EMXcmtz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXClOnhyifnT8HZg5RUbvL8sEsht+2WDgZ+z0zaJPyC5G+g5E9mk61gpwYab9fnUXhIqoSgvzhb1X1kOuxDWl8pHrD+k6XN2cauewHYUNlr17W64uMb4vTRZWjxfbV++VrIJYOrCni6TNOgQXBGL+k4Lv3Zudc8PvOugzH59wGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WHpC3sHw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wId406dm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WHpC3sHw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wId406dm"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BlT5001671;
	Tue, 25 Feb 2025 06:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=f4ScejQ7+gE7rDCUFw
	xa5dNmaUKOY0NWO4N+RMdYVH8=; b=WHpC3sHwdo9vwC+xDgm1g+0Hbt8fF6BWYm
	xaTV3KaGTkA1HCoJPA+O2MabAi8kstIB5bZS3j97WZ+l8z2LsjSAVIXkQAjnaOVa
	KlMAJSdjE0AVjn6X1IYF/kblMEvm7Pq6WwPtZh7nvFlxCksBhW14Ko0KDWsWeToL
	FHD9bCZnh5LbyP7UIFwoljDwq4PMAOkFdMfDwer63dFJ6FJh3TL+IfMiVlrp43gT
	L1jkAsvvD1sW9XC9+pNarJbjx3E8J6Le9YxQj4uWtVszCA/JVRPZrH2HKkdfQ/+7
	mi20Eeoueqp2nKybWuE7OD1E+UriCTuyK+AJ9i7ZTnezn54Q3gxw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y560492h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:07:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P5UxLG002799;
	Tue, 25 Feb 2025 06:07:17 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518xvyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:07:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3Y3k4Cq20cN3Rw5SUbFdlCj6RDrGRoZECyAe1R0i9kb8uDfV+NZb6kJcQh//scxtfE3SIu3SB7VGLR27ZO5eyAo2JtglbrwrAWNS0Jidc5hPzyMkcXGTqihlrFdwAGH0cX4xRQMCLIygoEbqwdCn+I/VWXd2mB0rzMVXJ3hgAev34ZO6rPH13Pz0eg6Lzr1agpuvpzuD3EkTMLYLdRNF/Yj+AOBmYcRG9D3qZQQd23HlGZBHEqPvFLJ1ReK0H1XRJyfU6A60xNGWoYzPFL+erBjNEfWPKYHbxqP0NMuEiARN3iazuqRvW8ww5pFW63Pv4vWZr5fhG+fsxharuSDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4ScejQ7+gE7rDCUFwxa5dNmaUKOY0NWO4N+RMdYVH8=;
 b=VRHyaoe6h5In1znsRaMSj1/uybkvs99b6f7fpxOYn/Pcoh1Oh639JUdEJ3HgMwaN8TADS9Cqu5c9ip0HBPVwqW/AKI9LqO/qHiJflRf854atocnxqdk3fkkiT22xE40RTnHydcu9TmSNOxSlCFjVzjFtgQV6c/SU9zGCGkvP0T77PMgGwhZWs1PQPaHpPmpAzntdpU1xVZ+bx0zmIivtzwOS9elIHFkR3I4QXnxrRWdeTf8vCL3XmXYLSxVQKad7xrpcD0CH3zHY21/E2Ct28niSMje6GO7rjqtdcyNnLzSQuuX+ODBddUpFTQZl7bsiIfGpPfEXVBdCKRjTr3MS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4ScejQ7+gE7rDCUFwxa5dNmaUKOY0NWO4N+RMdYVH8=;
 b=wId406dm/kJc83fBZvTKKegX86a7gojbEUH/olTPY7o9xTSt/tom4vjfxw5RQYC+TvOr1jDKwqbQxSEKQqVQ7n8PGnpi0HUyCbG5mQmoqZYaAccOnBLDjPfHvAxB+qhVzbXyFo2oe33wgee78OhRmIOvaOc5Z7St6P+iYv8fnXM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB6031.namprd10.prod.outlook.com (2603:10b6:8:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:07:13 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:07:13 +0000
Date: Tue, 25 Feb 2025 06:07:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
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
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
Message-ID: <7e1bfbf2-3115-408d-a40c-ae51a7ffffe4@lucifer.local>
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-8-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224174513.3600914-8-jeffxu@google.com>
X-ClientProxiedBy: LO4P302CA0035.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c902c7f-9ee7-471e-9db2-08dd5562a5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uujWXKfejDJnKGsv8znXjjOpigOiqPfMk9NRqzlKZ2NKGR2Z7vuz9HsG/EIM?=
 =?us-ascii?Q?GlxvCctwzfoNOibVR7n96Fo6jl0f/k4ZuTAAMN19V18ocaG6Ppsij1LzR3XP?=
 =?us-ascii?Q?8TZNBVEeG1urSRHOExalA1aWolGVl27N8jWbZlSGDXkhh3px+P+eN1UszFEo?=
 =?us-ascii?Q?ldH1LAUa8ybVCv+3PbFju1ih6bo+xs5eW0ccpXtp0vzhSFj+sOsNLNo9laP3?=
 =?us-ascii?Q?PTEJAHo1Qp92LXNbHyYzrB+5vOx2UcdL2WbgEaIZvmJcklDRIBtT+gr7jd7j?=
 =?us-ascii?Q?NjZp50l312VM4XOfD6klsQhtpoLb175HNpb9X9sDjp9PKAHFP+/l80rMys8E?=
 =?us-ascii?Q?aE/iWIq4LMG0G/vVPRvpmWcV2ApISIRne6RCEKJ3F2p1TMmMXuIpXLdnxb+E?=
 =?us-ascii?Q?X6RxQADa7QXa09Wcw2EBKXBmp6dYiQI6yvPM3EvoYZQfNZsU49k5XNP28yVA?=
 =?us-ascii?Q?V7wSWgeSR56I+hhQZchmCy+yzGYDHToL2PIg+I9mkbWB01XALPPofcQwsz4e?=
 =?us-ascii?Q?+0sWmkyQ7csB4yIQNhZXdHcZwYJt9TsMJFHRmMzOv5+YVQMhIUbLImo1n836?=
 =?us-ascii?Q?90JMveH2PUqBeanmTUsQotjbS/+NCj6UvbbtJz6UXNRrBblrI1/Q3SnoAasq?=
 =?us-ascii?Q?faSfLTjUJjLAzYWi1dh85rp7jepYtRlM5TEX+gfShu7n3s/2jraqJ0RWuWSF?=
 =?us-ascii?Q?XLfcwq/DMpY7kqOOqiOe7V/tiHxTDY9W+3+dNRSxaM9AsMqAirGAlwkHGrdv?=
 =?us-ascii?Q?mGJD3FDJX7kqteKtCr5En+NkxhJ985pdorcjKbdDxh7sI5tGQcOtE/AGBKFy?=
 =?us-ascii?Q?5vxwq5fvuumz2Kw+bOr/LWfb0R3l7TCpd+0c0bx0F4XpyFNR62enlqgYVDiG?=
 =?us-ascii?Q?IAZQ78I2LSRyjB9QYPjtH/C2rUaGNob4CwkMNPwzLy7DGji74NARoyzy85JU?=
 =?us-ascii?Q?WQbuQNN96AaKc6d4XWhwJ2L3EqHyOFzfF5GOZzNpFkmgKZvzMLlIDnAlby0N?=
 =?us-ascii?Q?j/jg4JOhg+T4TMcQ0eTmD35a+pRRyI5gNnG2caR49r9h3BXKB62Ha4t1Sxdq?=
 =?us-ascii?Q?xIbl1PRz6UjhPUvQ1WQy2ujuA0HznPZqxLi/oCEk24f3etRTyPjAzAJB8095?=
 =?us-ascii?Q?Qd6PAIRFtR5SYWrabKxbbMQJ+yNFwzrzREjJQOE82eIZCl/dOrISmefkCSOh?=
 =?us-ascii?Q?KB/aLwacZyDMDNtj9JL67fNfIrqt9FE/bbziEJpu69gHwmqPqOA676ncV03o?=
 =?us-ascii?Q?KQoMFDH4bM2yHQ1XKGM07wodPuKEW4J/FZjZ5AXOgg2YVL5nDPBZntuvilIq?=
 =?us-ascii?Q?Z3puZB8ZY3xuiCsXlOcyQA3cCKJ0UrGDSknD47r5ySO0NRDKPEL3fEqa5pH3?=
 =?us-ascii?Q?d/ISzkaj9tiABNdqYUQjZjY5WiQX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9wx6EB52LsfYqXGGsCcVQqnWioWWeVHvj2IrJBl5xtMIjyTLE1VNcut5A1nH?=
 =?us-ascii?Q?N2xlrWnpfHNrgFLXAi0VNg7GjI8QtFC1BJSvQi+blDqJJTjMlWvjfAlKpZTo?=
 =?us-ascii?Q?JmGEOUA12gRAlp2oNEmuKULCPeOurn3nEY1k3KgT9PYz1Yx4jK43WwhEpZrV?=
 =?us-ascii?Q?h6IWrKTr3tLBlcKa0RGKXycVofud8MsCKCv9euu24s8qAXXo3BQ1XkDand98?=
 =?us-ascii?Q?PsxRqSJG7Df9bCmuHtMnvTiFc2I0cRYV3xZYsPuX8qWY19wOTiPuLLJvAeiW?=
 =?us-ascii?Q?t3h4vnJ0jLGIsuiBF5DtMYNswA22es6lTw8UYpRPSLgMJVuj4zsOzKy4Qa1r?=
 =?us-ascii?Q?ISGP99TwfRvu+GKWrXNVQ7fMak0bd/6m5UAy/ERxyw7mmcSYgZe2KWy0EU6v?=
 =?us-ascii?Q?h67ml354NMPZxXed881JCdbsP/vjxsAwXUvvoOt4JAWS26UgVRgB+32r6Uf/?=
 =?us-ascii?Q?30iPdBRm8Vx+T/m/6wrwdYv9Jqiaf98MLt5ezrrdHNiaaoIlFf+75BjYnU7i?=
 =?us-ascii?Q?lcFqV3l+BWlFfxCgElWbwVqRDXVQw4dRQo6af+zJo/9vLd8iVSI3hcivaeKF?=
 =?us-ascii?Q?mio6hNU4snnkRHWKBefl2ubTkFU+TDF8RDxjzUlBf5uf1Tz1YTKrr9sfsXsP?=
 =?us-ascii?Q?keHG+SQR87sGff/Q/SUqefgPU4vkXyrG0lxNd9+13AbgAnN4ZKpceHypUAqi?=
 =?us-ascii?Q?HJAM3iJYYwu3miW0GAkol9iHu9+2tiSxkGJvHjrc+6z5A0xCyOEc0rYKEcpt?=
 =?us-ascii?Q?n/RxaRlH6yHYJ4NAsSDU51qxw8fqH/89tAR29h690EBYqMcvCdRBXaIQEPLS?=
 =?us-ascii?Q?9LtBxdMDiyVMv8FbyPlcMvbWcxMKoch+WrRMZHVr4lPU871QK4JNpNBULXkB?=
 =?us-ascii?Q?wyfG/7MlhTIW3CIUrQS8vaOcTIyh9B/HCqjIG513ARwCyRBO+73sM8IRt9z9?=
 =?us-ascii?Q?cay6Pa5aB4YYOUdJbUHTV2tz6+RFs48VXxMicB4cv9pk26yl90pDXXwP02MP?=
 =?us-ascii?Q?xRfAReg6kFgnUU5+mTIm2Pk7QbqIfhLcgE1qA1aBKzXofiBcIkjK4ZtcvU5b?=
 =?us-ascii?Q?UC5FinyaRFOccqT3ZwLfkGeVBdWxsjKPdY2DwfCBuPQQaaeKUh7ZwvaZLeem?=
 =?us-ascii?Q?gGyE8uXcq0KXCckw0VnldQ0mHmCTFkTl+Nk+VbplULaDbhKYQrt4X5JTuG+T?=
 =?us-ascii?Q?b49/biWab3K7nPOE4gb8/2Ofwus5YkQIPRgPCLaa8GGBSrzE824fyshmCtdT?=
 =?us-ascii?Q?mmMQLUb1MYO0/sQwYZfmXA9KCxH6gG2uQWUEvVuW5CtJP8A+tQHgDFYNfZZz?=
 =?us-ascii?Q?88yOz+vyeNi6TPgLqI8C11iwtSIrrWObJYOnyWnct5cxyFNy1kIdFoeWz+/I?=
 =?us-ascii?Q?4qpNaruELEyraa7PymOCiF1nRr+WXyBnDXXCeLy+A5Dixi5wsc2/ETq9TopJ?=
 =?us-ascii?Q?Vbuebd5JfiH94we6+MMKnfoT2nCTgtAGDwXShfTT94+xEPlTmHALxGwKeC1+?=
 =?us-ascii?Q?iJVrW2WxAj/r1Gzytt/PDEg2j0TOOf3jKTNnjUE8u0j9CrUIvYbQoVFn+2pM?=
 =?us-ascii?Q?R09eyGWx3LiyC3MZNaFwzGGtBy29kEMzknrz1dIeazRGDL/Ep2cF4WS+7TdX?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sFVHa2iWLRi04qShGrSardTnzReeLepXDJmvOdCC5d9wKN/gJYaGLczOh1bSolpRR4gXC6XCz6wWTj4/Ad2/zihcdX5kF+7Ku2xwMX83U3pnF1cpxe1lVxlLv1qlPeWTr1vlBIDgC07CJ6Zpxp/CZ2Zk5sQzNyvU+GNN6CSwLkbRdT7nhhdAnaNAL+6+1z5LMCVH6CxF++imiPgV/5A7mAjgMd67Jv6HhNistNtBYUJLgAU0LOdfQumPudQ3Sn/JikNTsaT7Re7+msLFw0eRJrmSfUq/JlfLHhdGwlKEO6R/sw7z+2Z2CYpOH/v/FSHKSvTsePjoxfBtkYtHwxRDJPVr/fZd4tKxBCL5ctxuK2uIZkxtou5Q3S4YYny6lA6wWV461BM/mq2pYICn2OxCBXyn4juQXZ0KQOrgULEJbieI+xC2wEiu0KsG7FEOsX5Qly1Wzq3q+AgWmQu4EGv10E3j4z4oZ4eUc5AvKgYOC9YzlWuACh6ycSoW7G0QodCHAmEWTkSAqhD2nPJeZZC3WJmQ164ScDks4dvDCKaOvAojfYtDVkYZHHeLxvXHDdvFedCHIweoUndQzSLwg0ETETgJMwSr3YmTgZe8+ROYy2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c902c7f-9ee7-471e-9db2-08dd5562a5d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:07:13.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Z/58UwroQ75zYRlNWdujK0rXejwAEzQZdN5FceMuKb+6bA4bz1Rzep+PZaDBKMup6Ihfs5PEm7d2qka7/g8rguauNYz4lqc8/ExmVEOqVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250038
X-Proofpoint-GUID: zIjjpKq5dVCMFpkq7mWUFLhOpe8LXC7K
X-Proofpoint-ORIG-GUID: zIjjpKq5dVCMFpkq7mWUFLhOpe8LXC7K

On Mon, Feb 24, 2025 at 05:45:13PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Update memory sealing documentation to include details about system
> mappings.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  Documentation/userspace-api/mseal.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> index 41102f74c5e2..10147281bf2d 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -130,6 +130,13 @@ Use cases
>
>  - Chrome browser: protect some security sensitive data structures.
>
> +- System mappings:
> +  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
> +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
> +  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr are
> +  known to relocate or unmap system mapping, therefore this config can't be
> +  enabled universally.

Thanks for adding this.

Similar comments to the Kconfig update - you are listing features that do not
exist yet, please just list what you're doing, specifically, and avoid the vague
'etc.', we don't need to be vague.

As per the Kconfig comment - you need to be a lot more clear, I think you're
duplicating the text from there to here, so again I suggest something like:

WARNING: This feature breaks programs which rely on relocating or
         unmapping system mappings.

         Known broken software at the time of writing includes
         CHECKPOINT_RESTORE, UML, gVisor and rr.

You also seem to be writing very little here, it's a documentation page, you can
be as verbose as you like :)

You really need to add some more detail here in general - you aren't explaining
why people would want to enable this, what you're mitigating, etc. from that you
explain _why_ it doesn't work for some things.

You're also not mentioning architectural limitations here, for instance that you
can only do this on arches that don't require VDSO relocation and listing
known-good arches.

This is a documentation file, you can go wild :) the more information here the
better.

WARNING
=======

> +
>  When not to use mseal
>  =====================
>  Applications can apply sealing to any virtual memory region from userspace,
> --
> 2.48.1.601.g30ceb7b040-goog
>
