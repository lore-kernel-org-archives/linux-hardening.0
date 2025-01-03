Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09171B21BD;
	Fri,  3 Jan 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735940348; cv=fail; b=F9UlYJbM50IMoiZM+KwZNOrrennGDVvPCjJq5aafr5LF3TTszXcChFw4efmjQV+ZhAIKCJqyZJavIfTjnS/R45HEKZ96dki59KOYJeioFo1e1ddqiTP2EjqAhCcbXwyMMgmpJWPFHs7dOt7w4DFK6fkLq8D06p1NBjaDiqOSBZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735940348; c=relaxed/simple;
	bh=IbWxVKT6TY/u+u/U9PMam6UE3PqwaupjQc8UXeZa+zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U0EXWTAYikzaaZaxQBODEVfaAKk5S/2A1ZrfhD4+gx9M2m6Xh+WyaQ9WTwUqBkDm4MBcyqVK6Z3WJl0TiuRmi8risuIN/L3PS+Mrka5DWOfIjUe6Y16JTeSBF1CFHQ3yTyx3y37l9C87vPAtIvw6hWVJe1S/MLEv2DGxivdbAc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zuu0zR3g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sTX9IK04; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zuu0zR3g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sTX9IK04"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503Id4vP025244;
	Fri, 3 Jan 2025 21:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=rlqPHJZ93RLYHQ2e+2
	rMIV0fgOEUbNUQ6zrYt336bcQ=; b=Zuu0zR3gfkxknhlR0jq5oEIe0VbmBvKPp4
	DT7dQLOpJMfrfcm+GkDsD9NV9NO3Fdh+GQ8dezG6NLcZ/iR3vLjBKysSQyEvcXq+
	/McEJAPianjr4QEy3nNB6CSLa7Usgtp1iRd91MQtYvlq5UyNjQifbEOavMSrsm+m
	6npiQtFr+sZd97DuOBlcYSpeD9RPmdwYzZQt53FKYWPIoFHtIblwAOGxKmeadi2x
	WDxSRIGK1gKM6hb8qa82XUfxmvi8qvZarBKuANyefksPn7wWDT47DthHJo/PbW0X
	UxOInRpHCpIP9vv1sN2BZhYksQ6xllvRYW6a2PyHptNWn58MEmTQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43wrb8bqhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 21:38:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503LYl45011770;
	Fri, 3 Jan 2025 21:38:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7sa5k4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 21:38:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxPDru1eXt51cvC+/OIrL6Hx4QUYheadpBRUXsk8Snjr8HrGLAoIBdDCFrLJPLltLdNdYp6Duv/p6TP/WtNBBgUfvcYGtCMTLJhTeCkzH61TGNQ4ozMVwW8MhaGiMNv/SB+zl/b9GQ2z9MhcThdqaGz2Un+ZAY29rIObvxylA20eHCb4c4o4FYDDZ8fz/cWH23YctvxZXevJ3Hg1sUsMvr2dicO7NSxN6DHPhqXwSg0ZPy0vLA8TDvJWIBK7SUiqIHjLa5/w5oE5sHrCwdbMkoov3cIHtNYtNVKbr2hpA9RJBNP8p+MKuodv82UCfHY909Y+5EIGSfu4NouLCsuSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlqPHJZ93RLYHQ2e+2rMIV0fgOEUbNUQ6zrYt336bcQ=;
 b=uL+3narZX+EOfNCfmmvRXb5nNYH8/7OXoSD8+GyZ+YcQJMl58slBdYE05OqYFWRWg6/JUuvVzzQrFC07uBeWhIAabkJ46648YXHNVFJh5qS4kSmkgJGds6ChVBOJmaC2JfkhsCkTLUdZd8GrszGHZ9MXvUXwwzhQV8lTYHBuw6os/gRBa+xW7hbKTrv/q+L+ExW8wLn9N/eC+kioC22MnZ2sqKaUaxYCEYxE0OV8bDPseo/bOtDeVxmpRRH5IeoHShP4nOqIU4VJXH1aCVK1dx0cExswdLgHUrEQFiwnqpH+eWMvlve1nEnsBRw3844YE06/6Cb/SzTItKAZsDhIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlqPHJZ93RLYHQ2e+2rMIV0fgOEUbNUQ6zrYt336bcQ=;
 b=sTX9IK04yTwOUrmyvdSsHq4FdlYWGhcDeF4ZEQsXVSRUfX4ld703WkQIn3KbpLW/uvrII3Xz1/5cX8YBO4HFMB5AjAajYhiil7wM8xroL0tiUxIMnMpIxlWr//GCek73+A2y/34jf0NeVlixWZq3M2GLBUJBaZi4u7UBUx+OrdM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6080.namprd10.prod.outlook.com (2603:10b6:8:c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Fri, 3 Jan
 2025 21:38:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 21:38:15 +0000
Date: Fri, 3 Jan 2025 21:38:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
        jannh@google.com, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
        mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
        deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>,
        Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412171248.409B10D@keescook>
X-ClientProxiedBy: LNXP265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a641d7-66d7-4a2a-ee3c-08dd2c3eedf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c16jsCRx0CgdtoPf65wRSmX4z6uBBfrE7LWvjXa6phjURhzeEuvmaxcsBrux?=
 =?us-ascii?Q?cww1dJvk3yy3fH+rLPmwAzGeSLpYf1q/iVva72G77FpRZqtiNncInxNlsJdA?=
 =?us-ascii?Q?IG0f4glZYvJo+paDXvSrbi6xlx5UlwaVlLXW0S8tDbu4m7roq7O6dOqeda6y?=
 =?us-ascii?Q?Ybkc3DRSzosDOpQEMZW+SECuZsroPwclYhTrGPI7IiKfYeLyTl8fwNvfwt2+?=
 =?us-ascii?Q?T6Tw/2ZdlCxGrzRGQww6YWwOevfq2MJIMIqy+J5n1gf3Lmf2S2xHn3CZlgym?=
 =?us-ascii?Q?Wh/p0P3c7ruVqdqrNdqNRO/NqKyLyE7WpeoC0p+PJqXPl4Jyut0gPiAlaNyv?=
 =?us-ascii?Q?ZtW85C4TH62SxuAMqoIHMqFa8lsN6gyBFqRaaWVVtilFivKXgbN0/7UI8noL?=
 =?us-ascii?Q?12m7VZZjYPxmKQ1SnHctu3hZQ57bjCf58rw3tHfUa0E8s+VgfxBaegpa0dIY?=
 =?us-ascii?Q?YHjUVDSX5BLOUZOKK6+XoF/pkBAesn2g0ub4LOcsedAgAo7k4R7oE7PCaQHf?=
 =?us-ascii?Q?Ss1gVR2S+BVSJtj9+34CBQJLRQNnucIm3fhWIh3lO4nb8dN0LFK6AMcRIa9z?=
 =?us-ascii?Q?+Q/tAy8UKSqYoTpdM+ynGiKrsRMcbC3w4bIy6hPoIvFX6xAALP7TfHkYGN1+?=
 =?us-ascii?Q?ciLu0Suza0E0DFSAObXaPfmUKAZA4StschMTS6cWas9ILGzAEuMi5ztmwcn/?=
 =?us-ascii?Q?TpsaVYIhB3XxtwO43g5/YhDR2YaF6nX2neC8BoA4ziQPBrtCelIHV/1lwqsI?=
 =?us-ascii?Q?tzHGd3IpnUNckYCTjSHUJiFadQ4MBlkxaK+tOdRrUqEKa9QDtAtWDNv+J6VT?=
 =?us-ascii?Q?CPdPWhcprHnBOLIqip19dz7vFTKu9Qz+P/NM3t3LibFX37yXlGi8jFWGbCjw?=
 =?us-ascii?Q?ntjNnQnFUxEGA9MZ8bo79K2NqIN/JN9T1imClhXR7iTk8E5gkQIMxCNNF36I?=
 =?us-ascii?Q?Yoi8KtUxC3BGrF3UvpPh88M0Fa3NAEewYUcu1kEwsa5rxeVylCh8Djh+IREy?=
 =?us-ascii?Q?7K24Lj64OjckVG1cUSIEKWZiCXYx4DvMu8SpZ63fgFo7LFa1J7dk6mqZ0K2x?=
 =?us-ascii?Q?GiLZi9pSkREcrXuxPBuicH1BpQ81gFB3IY5rOb0ezToFN99wkzvb0qGOtnLv?=
 =?us-ascii?Q?0fXBlNFk9zHJNt+FjmhtBKGG0z6MSFZWAnREQi6WQMruD1Wh6CB0/a6TfttH?=
 =?us-ascii?Q?DONJC88ZopzIq3mwFI+h0hsI0uaThLc6zC3dm41CIXaiIyvTgnlI1cNmglwn?=
 =?us-ascii?Q?FWacKUXtxKhsd0SX9jZZqogNEv0hkPHriafvaQvArjGwbn7lSwD9+CrL5Pmr?=
 =?us-ascii?Q?SmYNgJVNoDGUaC5oYIa0FCSyX5I9cKRM7tbdSjT/URYDEWiO4X5dk2/bCxQL?=
 =?us-ascii?Q?nNbl7tmEWD9qktbnVhqf4c513TNZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xsB2PS5U84/L0HgtrbsydV07OVABDuaRqQKI7eQnJsmYrFtObZz8LeJqQpws?=
 =?us-ascii?Q?961o31n5QXWB8UlX3Fa5e5Zqkzg+qtIyXh1KuZSNz6RVoC7QVBslBzDj/znn?=
 =?us-ascii?Q?Kw0fENjyBt/2jgdKSmCCWhWvbL+sULivqRTHOFvpRDWm0bZde3sEKY16EH03?=
 =?us-ascii?Q?c8ztOuw/M4SVvJ50RPScnR/0+bQC/zV6XuoN8zdmw/7Va/c0U9DpYXOvMpHq?=
 =?us-ascii?Q?OGcUDXWt4suhGDYIUokwzE86PUYCfLcpxbDVN4NBFvXD6eT+jh0ng6n3RvkO?=
 =?us-ascii?Q?ScMXmbx+AoaxArhyQq0Nz2w0T6CNHfGXWtpGO8/jotIpySM+1sZqXtjxAHEi?=
 =?us-ascii?Q?FboWH2VOge/zniH2+vo/KmahfhwanF5D33NpD8mN2XY8rKhxWsb/TID14Jiy?=
 =?us-ascii?Q?BorYy93LuWhSA8ovmoAp+CyU2m94D31u3A314M8NCzw2FAd25CCvXj87RpSN?=
 =?us-ascii?Q?+I1Q5OQcuK9UdlHc2BnPeHIYEIioGtCuuX7f9CwPbr8LNBdp8a9de96kGJMq?=
 =?us-ascii?Q?VJU+nJzJRxppa3RtnwNYQ+wAsFor42YxCk6tLqMgK9dHVxtmyZ/9DuiEhRSo?=
 =?us-ascii?Q?+mnUxVBLpyMaGGFKSvjtn0WGGrp4nmVAKTWe4IG8gT/gCREwuap2GT6aeycN?=
 =?us-ascii?Q?xchooCkzQLzTzs1LvgZbEDowtyrORDeuNqgCHxXgJejvDaruhUzoIaGvQTKX?=
 =?us-ascii?Q?U+jSaHiiJJ0izoEFAM52whZC0GQ2FZ9X8uJDVzeYJ2UYxgi4vetH9PAM3RL5?=
 =?us-ascii?Q?k6jU/rgx6WBz5bHZIC24xiR8ccOqAbBR8pZhldvIQwrEd03Sxt0pwmzcne7C?=
 =?us-ascii?Q?YLoKeDYZdneCHGtznTzWSqr+U3nHa42jqEp93Jb83cYnTLRe/YJLhc/7gnu2?=
 =?us-ascii?Q?l3Rb2RZoM0KCcMMXgCQTxWL+yVAhVYmstvZe55nSPcM1XUiMuDqGsyH9gTdW?=
 =?us-ascii?Q?BrFhp8tXgo4ujb2cvD+T9Sg/FkuOchQM6D9nCt9TAAXlUg4GntmBDXXnWx8B?=
 =?us-ascii?Q?9xsWNFpBZilMTR/EQksjMW9XzfS3O6v81hJkUymvnAE5+kq2sPvHrrJ8rU/k?=
 =?us-ascii?Q?xsfE71R57ifPFqj30NzEn4ga+h7H3G2MAdNcl4ePRdtydBtXdszgFQbIqw0t?=
 =?us-ascii?Q?8GisVbBOg7Jq1OnuDYiat7BLmeMgH8QO5rBdX4QkDXFXrRDBUIH//c9VHJ6G?=
 =?us-ascii?Q?LDy5P+d+F5mD20LbJBWFYd+AQiZv8e+nN8RB3w6IHaSoM/V1jo+KegjSxGSK?=
 =?us-ascii?Q?MeFJb6nKD7i++0O0c9uUCtjwDkNoFQ0c8vTem7RqLwwNzEGA5RsyG7HatcT+?=
 =?us-ascii?Q?kvWel2IroV6Kly7KJOmrNm1DXv4Y5SjFB11SV4fPPfJ9//YfnQjtSMse6ZUj?=
 =?us-ascii?Q?u7O7ob0HtXBRndp7l/+LCyc7MiKvDxvZfHe1qUbkvrP4iLH2COzbv1C7YHph?=
 =?us-ascii?Q?D+aOl5O7NE7CduyfbXdsjgqAMVg9cAO4HiEdnzJq76upVJwqBDeFkCfc2Oyz?=
 =?us-ascii?Q?cNPuX6F6G0mZiI6jfWpDbJ/OhpbF7/JPLb5F68jFvMTjOIYXFhZ6l9uUs1ac?=
 =?us-ascii?Q?q5W+fdIKeInq6Xvd8/iUVv0zN11txJHqLLb4uC4o4tszvN5j/rWaslZnBBTc?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nq28YLbOQBCf1sKNbyhR2MzHpB35iFIMy7+qypYLTg0t/PBz7H4yDifstxGz0JSBprdR3XMB2wgFd7oMCCwuaMg1VM4h/NBl2w+7k0pk+A5BFDKfhkbpAIqT/3iNGYWqFOtbtMcKEsuAk52ocSccUmYi7drV7i0FXmSjNWutSd0MBZq+MeTFA3M1etofmflxJ6Mlbkd6rE4EPVFsurrE5c/NMjvw8ScvG2VVctBjeywZKCxcJ4dbwHaaLtDJesRE0kklBXC2/MIQBTuX2kdIXIcdqmFbUD/2l8mLB8PfffH0033Z2KX31dOxdhdceCcvpAFSYM6whAE8mN51Jz/P+w0K3Jy58rJLCrsku258QmFy3guSl0vYCD953tUbXCo+kaiDzIDht+Ns3ApP/RKNOObjeijRp6fIpS19isz7+hyjAwkwUSAb+oKWBhTxRy/eRPGjPUaauF6tTbR1ZBxzLGfUtK5rnPEmKiycyGof5cUQWzuC4gu6+M7nDNBtvpUgz0N+vpBbrM0fQRj8iuMgriRlrXyNsx5pHebyoorK7akDokX1Dhei44tuzmD7YLE/dAOt3c6w+FF4XfJ5rHILUcwtOckzZLp75mYT43adPvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a641d7-66d7-4a2a-ee3c-08dd2c3eedf2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 21:38:15.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMCgfG7UnBRmatEq4KgZVZ7+Z6RLqW3TDwTo/E26c4wQWg0vFWmA6HMqZstIyljxkuWcE4JqP0uIyN43+YHOhLJoe7TbXeF0Em8SO4ghRLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030191
X-Proofpoint-GUID: h2UDuqXt6HoKLKnTWFyl50-VPdg6JP5o
X-Proofpoint-ORIG-GUID: h2UDuqXt6HoKLKnTWFyl50-VPdg6JP5o

On Tue, Dec 17, 2024 at 02:18:53PM -0800, Kees Cook wrote:
> On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing or unmapped during the life time of the process.
> > For complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization, and are
> > sealed after creation.
> > [...]
> >
> > +	exec.seal_system_mappings = [KNL]
> > +			Format: { no | yes }
> > +			Seal system mappings: vdso, vvar, sigpage, vsyscall,
> > +			uprobe.
> > +			- 'no':  do not seal system mappings.
> > +			- 'yes': seal system mappings.
> > +			This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=(y/n)
> > +			If not specified or invalid, default is the value set by
> > +			CONFIG_SEAL_SYSTEM_MAPPINGS.
> > +			This option has no effect if CONFIG_64BIT=n
>
> I know there is a v5 coming, but I wanted to give my thoughts to help
> shape it based on the current discussion threads.
>
> The callers of _install_special_mapping() cover what is mentioned here.
> The vdso is very common (arm, arm64, csky, hexagon, loongarch, mips,
> parisc, powerpc, riscv, s390, sh, sparc, x86, um). For those with vdso,
> some also have vvar (arm, arm64, loongarch, mips, powerpc, riscv, s390,
> sparc, x86). After that, I see a few extra things, in addition to
> sigpage and uprobes as mentioned already in the patch:
>
> arm sigpage
> arm64 compat vectors (what is this for arm?)
> arm64 compat sigreturn (what is this for arm?)
> nios2 kuser helpers
> uprobes

OK let's not get ahead of ourselves :)

VDSOs/gate VMAs are treated quite differently by different arches. So we
have to tread _very_ carefully here.

I believe PPC doe some 'tricky' things and may actually want to unmap, for
instance.

The problem with this kind of change is we're doing something fundamental
that impacts _every possible combinatorial combination of configs, arches,
and use cases_ for each of these which we seeming - just assume - will have
no issue with this.

This is insufficient, deeply. We need:

1. Strong justification (hand waving won't suffice).
2. Very extensive testing and checking, and _proof_ of this testing being
performed.
3. Buy-in from arch maintainers.

So far this series has provided none of those. This is why I am cautious
and pushing back here.

And I absolutely will not accept a user being able to turn on a switch in a
known-broken configuration. This is absolutely unacceptable.

It's equally unacceptable for a user to enable a feature that is
untested/confirmed on an architecture.

So let's be careful about Linus's edict here - the operative part being 'if
it doesn't break things'.

>
> As mentioned in the patch, there is also the x86_64 vsyscall mapping which
> eludes a regular grep since it's not using _install_special_mapping() :)

I mean I think we need to do better than grepping :)

This requires really careful testing and checking. So far only two
architectures have been checked, and no real evidence of the checking has
been provided.

I am ok, generally, with the concept of providing this as an opt-in
experimental feature.

But if we're going to look at default-on, which if we have confidence in
this, I'd actually back, we need a LOT more confidence that this is OK.

>
> So I guess the question is: can we mseal all of these universally under
> a common knob? Do the different uses mean we need finer granularity of
> knob, and do different architectures need flexibility here too? The
> patch handles the arch question with CONFIG_ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> (which I think will be renamed with s/SEAL/MSEAL/ if I am following the
> threads). This seems a good solution to me. My question is

But then immediately undoes this by enabling the feature to be turned on
regardless. This is emphatically _not_ good.


> about if sigpage, vectors, and sigreturn can also be included? (It seems
> like the answer is "yes", but I didn't see mention of the arm64 compat
> mappings.)

I oppose adding a bunch more things. Let's take this slowly, please.

And evidence of this being checked/tested really must be required.

>
> Linus has expressed the desire that security features be available by
> default if they don't break existing userspace and that they be compiled
> in if possible (rather than be behind a CONFIG) so that code paths are
> being exercised to gain the most exposure to finding bugs. To that end,
> it's best to have a kernel command line to control it if it isn't safe
> to have always enabled. This is how we've handled _many_ features so that
> the code is built into the kernel, but that end users (e.g. distro users)
> can enable/disable a feature without rebuilding the entire kernel.

See above - the operative part is 'if they don't break existing userspace',
and I would be so bold as to suggest he also means the kernel too :P

This isn't a green light to just enable a feature with little to no
testing/checking other than a verbal assurance because it involves
security.

>
> For a "built into the kernel but default disabled unless enabled at boot
> time" example see:
>
> config RANDOMIZE_KSTACK_OFFSET
>         bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
>         default y
>         depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> ...
> config RANDOMIZE_KSTACK_OFFSET_DEFAULT
>         bool "Default state of kernel stack offset randomization"
>         depends on RANDOMIZE_KSTACK_OFFSET
> ...
> #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>                            randomize_kstack_offset);
> ...
> early_param("randomize_kstack_offset", early_randomize_kstack_offset);

>
>
> For an example of the older "not built into the kernel but when built in
> can be turned off at boot time" that predated Linus's recommendation see:
>
> config HARDENED_USERCOPY
>         bool "Harden memory copies between kernel and userspace"
> ...
> static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
> ...
> __setup("hardened_usercopy=", parse_hardened_usercopy);
>
> (This should arguably be "default y" in the kernel these days, but
> whatever.)
>
> So, if we want to have a CONFIG_MSEAL_SYSTEM_MAPPINGS at all, it should
> be "default y" since we have the ...ARCH_HAS... config already, and then
> add a CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT that is off by default (since
> we expect there may be userspace impact) and tie _that_ to the kernel
> command-line so that end users can use it, or system builders can enable
> CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT.

Again, I hate to push on this, but I am simply not going to allow users to
enable features we know break things.

Users might not be aware this feature is broken for CRIU, and X, and Y and
whatever else we've not thought about and enable it thinking it helps
security, and end up with a broken system.

>
> For the command line name, if a namespace is desired, I'd agree that
> naming this "mseal.special_mappings" is reasonable. It does change process
> behavior, so I'm also not opposed to "process.mseal_special_mappings", and
> it happens at exec, so "exec.mseal_special_mappings" is fine by me too.
> I think the main question would be: will there be other things under the
> proposed "mseal", "process", or "exec" namespace? I'd like to encourage
> things being logically grouped since we have SO MANY already. :)
>
> Also from discussions it sounds like there may need to be even finer-gain
> control, likely via prctl, for dealing with the CRIU case. The proposal
> is to provide an opt-out prctl with CAP_CHECKPOINT_RESTORE? I think this
> is reasonable and lets this all work without a new CONFIG. I imagine it
> would look like:
>
> criu process (which has CAP_CHECKPOINT_RESTORE):
> 	- prctl(GET_MSEAL_SYSTEM_MAPPINGS)
> 	- if set:
> 		- remember we need to mseal mappings
> 		- prctl(SET_MSEAL_SYSTEM_MAPPINGS, 0)
> 		- re-exec with --mseal-system-mappings (or something)
> 	- perform the "fork a tree to restore" work
> 	- in each child, move around all the mappings
> 		- if we need to mseal mappings:
> 			- prctl(SET_MSEAL_SYSTEM_MAPPINGS, 1)
> 			- mseal each system mapping
> 		- eventually drop CAP_CHECKPOINT_RESTORE
> 		- become the restored process
>

This seems like putting the onus on CRIU users to deal with a known-broken
thing? That seems really unreasonable? And people would just have to have
the right userland code to work in the kernel with mseal?

Yeah I oppose entirely this unless I'm missing something?

> Does that all sound right? If so I think Jeff has all the details needed
> to spin a v5.

I think a v5 would have to fulfill the 3 points I raised earlier on, and
(to risk repeating myself) I absolutely will not accept a version of this
that allows a user to break their kernel or userspace, even if they ask for
it, sorry.

Also let's not add anything extra, let's focus on the minimum to start
with. I'd prefer a v5 to be opt-in, or to provide truly copious evidence in
favour of default-yes.

The issue with this is we're changing something totally fundamental and
then assuming every combination of arch, config options, userland code,
etc. will work.

It might even be worthwhile just trying to default-y this in the minimal
case, perhaps x86-64, non-CRIU - with evidence provided to support that
this is fine (i.e. showing that all code interfacing with the VDSO at no
point requires mseal'd operations, running a bunch of configs on test
boxes, etc. etc.)?

Let's tread carefully here.

>
> -Kees
>
> --
> Kees Cook
