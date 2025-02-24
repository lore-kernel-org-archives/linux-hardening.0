Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEA16CD1D;
	Mon, 24 Feb 2025 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424749; cv=fail; b=Ou81qGM7STWUV6M8K1W6dkIHTHtU8SOP4iZ6vVM7lf1tnKvb8vuQR1DQRL1gMZydKbikpaOEnc/qptbaqrnCDormKvKVjuUV0s0ayGWzhYAd7R2Sxu7UetQT82n4KXXzbZ0oIgnlw685zIutAkjppX3mOzKUmcLmF0pE0lOQFjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424749; c=relaxed/simple;
	bh=X77ppp/RwzKlE52lZpvK2JyydbBQabklvXtadkdodwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=euEdIRoiqlSbfvkv2vW8IYvtKfB4lpw43PjVKmZK18HXKITb3g0H8QeB2dZcRc3iMASembo82R/H/4ZnUJBQbGd1nWcWJWHaTP7BBFSZrfpPZYVhjnpqaYX8AdjAIQAe2S7UH5m7dxDKYiR8hXLZYWA6/BGVL8LQgcj6Ni1d+qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bFBXwSUx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VBEp+yCu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bFBXwSUx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VBEp+yCu"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OIfc2f027771;
	Mon, 24 Feb 2025 19:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wicZF92kP1dMHLslUj
	pldfTVMNaLeHyEYfoTXx0X90A=; b=bFBXwSUx3X9ByiXE8kjoatN5xBPovPr+qN
	sUYgy7RdieDXaBnKZ2thcM2vLu2vOXc9NW2dKimzW+0LilrsATMZvnvHdMPt0H0J
	uil8zHiWZWVidqsPbrXnhfReYvFVOlpQUCuF0Z40hke2UwzyHhLxPfQW+BhwMXEs
	Wm08itU7kQkl4v9hb8FWw4XnWIk3iYsGMbIq75PrHLQZP1W93Pppg+CbaJWmbIJF
	lMmwx/kllS0RBix7knbvxxjGOwFhg0Cl1gUTtMJUStIayMAwG0agdVswO49SqPWv
	+Hd5dsEh4XpEgEOo2Y/nxvdfYdqpjNEcg2hcIUJowtWTE8ifdD1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bkcxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:18:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OIVwWK002691;
	Mon, 24 Feb 2025 19:18:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518cd95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPkUpCJopMIE6dAYMd9wDtsjZrjFPRSzCvZ3wT80jf5H3D+QMlydGRvXzTKXMTL44rJDLhMJICIagaKSJ1rxVwyKqEQ4fyvtpGqofRzrAt7iUZGM+ozqVWvqfENH9Ill+ob1loCq09QuHtH8RfWWPu/92A+M1XUARavZbtaTuLoL37l9pLh4dAEDL+iX4Q0+9xJrUbQNUSplEG+/AwDQm+Y+5FB8o/oAZ46MddKbI6SPj8xeo6xSjkLZwXVADPA+HiqKE53VRgH37Rr987r50z5yfsXRsxYTNpfySmv31OcZcjd1pICLz2CtTBENI2P7OVvJ5vV9JasmRrv8trfmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wicZF92kP1dMHLslUjpldfTVMNaLeHyEYfoTXx0X90A=;
 b=dMoJ7Sbtw9rqncGvLGALOsLdWTsa5uADHmt91emIioaJHGwg0QeEuTjGFGfXHN3RoxNN5MiORYeJJqLKvKvvKnIXUgZJsDw/wPncLSWaxfvrTTlPoekBRqe3WKOt+NxO/zOBn1UUqcYmvJnd/STcbSTwdbiobniBBmz0a9VqtDx607UPp4mMCGXZI2mKLM47Uxb/uhtzpS1QatGNrkvqE9q6ljQ7BP01M+3Qds+15xV6AW/j+5N06G9f5pQeimuwxjqtX4obCyj11DYymLdy29KPsKEAaAHxFig93nKjy1HBscVphcbcHg6HxLziYQOiIxcIo5AV2I72XvIgvjVzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wicZF92kP1dMHLslUjpldfTVMNaLeHyEYfoTXx0X90A=;
 b=VBEp+yCu1sKOL6XGVpckjiJUiFqGbvXIEy+tuZS7uDQYoSsHwSM0VHAeAJIluV7FjQpQl649M0eYCmvzPbAOEcUsyIfJPVpjrwud0cfi7X+r1aLPIaymBP2/5TXefSw20JgVZKpZOCBxdYVgAaX9szOIe83wZgO3UmFbz2kJRG0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY5PR10MB6166.namprd10.prod.outlook.com (2603:10b6:930:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 19:18:16 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:18:16 +0000
Date: Mon, 24 Feb 2025 14:18:09 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        vbabka@suse.cz, lorenzo.stoakes@oracle.com,
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
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <gr4i4o7cy2nxah52kiyglzl4ax63zdblvwqvqbdl7vhlfdy3ko@izskzrcapjxq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
 <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
 <CABi2SkUfABFR+SpjBzHT9dEcsJ0OOHiyttKkQVhqrHLrtZzopA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkUfABFR+SpjBzHT9dEcsJ0OOHiyttKkQVhqrHLrtZzopA@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0058.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY5PR10MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: adcbf46e-9f7e-4d98-3ee8-08dd5507fd44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QCwwdlcSJhzc+ZndAU/4Os4Gao4ohWgmb3Ijtu2PVnIB1ec20v+3xPpxcS8J?=
 =?us-ascii?Q?4bsoT4r3Ir9yuHISTZ2BZYU3iD8BwXv/ZuVlVUFA2r4EaFfH/NBq5YUAmI58?=
 =?us-ascii?Q?PutcIxdAfSFf65FStNJLRii8u5TCIvRiuLS7/on8KUbVio+UsJ3UuQvTxttS?=
 =?us-ascii?Q?b+4/EAdIv2/N5q2cDWbEK3TlkQX7Kf+fvd0kdhfSSAovUu4/HA02kI+tEQpX?=
 =?us-ascii?Q?1DO5H31zbkOxqjdZZAePoSoFzXOEBpYCsRe10yaFevMldf43GHb2OZ8KCVXs?=
 =?us-ascii?Q?5BNMIQaeZn+ybVoFUsoL2GUnpakK7hg/oRaPu2tNJs3eAuR27XUPC7+1/rJh?=
 =?us-ascii?Q?ifEOTbDDL6CXwohMsMzDWyKjull7misu2i7I/uiub8aXMuFwpyUsBjZxZMT2?=
 =?us-ascii?Q?WORRxG9r0Gg1votQt4Y5tCcHCGimqJ1k8uRtgevc7kXEDRAaC9WqSnhB2Hd/?=
 =?us-ascii?Q?6GSaAb1V0QYXTCS00MAlZ9bAR5uax3piwCs/ZD46c+pgJe02xTKlQhQv0rLv?=
 =?us-ascii?Q?JLSTqTZP6qtD/3W+m0gYHE73QFl53kPY7kWX1kaM1whCNONCS9oEH44b9sOh?=
 =?us-ascii?Q?QLm3HB8GmfJ84KzM6taCR2qGOrhJvxmisrnJ6AkgHlfyBioct9VhvRjCThhx?=
 =?us-ascii?Q?jsq8tMYI1B4b2GW5Wo8MrlNolskMY5RHIXleeq5CfCID3QgaD1wigXJeN8WK?=
 =?us-ascii?Q?JgIj6+muFtL5Qe2KaSG8UQrVJvNsjqNRE6ewGo0i80X/hMno4dedmdkv3mvu?=
 =?us-ascii?Q?EvKtFxqcNZuNxP1/GTk1djxv3nw7efQK2e+1jQoB1ooGm1XtrIx2GfeXae4J?=
 =?us-ascii?Q?tb1FFL6mHUEWkXAC1kEvLy7Lop2uRz/fPpf3a89+4BekGXHHJ585AVVts/Ae?=
 =?us-ascii?Q?+T2KMMCmQ5Oo5bv6fFpeWU6bwh7EwOyGWfU6dvrMb9PJ80/9QN5i9eJb+72G?=
 =?us-ascii?Q?v7/XsXFDcgpd7a/gCQ44Spd2kU5nPCuGfUaKfvqN9Mb1sOh0vUUPf1w5+9se?=
 =?us-ascii?Q?55Mh5S4lZdabPFMWM4HRY6eCW487c6RY7SSGfmfP3/dAwm9vn0XNGIOI05xb?=
 =?us-ascii?Q?3LB6xw3imrahFpLfMw7ZREUskVvXD53GZdKr0J7o5iDHesFWtgfz10r4G6yj?=
 =?us-ascii?Q?RONw8bHTSnzsytAOb3QG9n7CdF3C9pEAQPZpt4TW00nUkhlBQMNAc73iRLJZ?=
 =?us-ascii?Q?jNDNRjwJM5r7v1BiWw8Ed+LvqVyUK5w+sGaJRubrm9PgMxQsuMWC3FR8/bF/?=
 =?us-ascii?Q?E/su5VLTaKQae16JNfKaxN/NGWD0zlxupr01ORupKCvoPp9qdY7e6ePwEHMG?=
 =?us-ascii?Q?eQXo1Be5rxWO6SJ89XWFAdn4aQtD8fDauMVPToghLEZfKKTjW819TSgO1uw9?=
 =?us-ascii?Q?ZkvW7+UTOjyQnSt6JmeoKDzjfrh8Dhy/HQ56SwqqclMpoOVS6N1hayFV3SG+?=
 =?us-ascii?Q?/7A1vKN3WG4HPotfAcDpcvXY8IyKX+vA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+GXuy0QUQFq3nfqRpS9SQWZCP8BIRWIMnWJ19NmRTLOPkfIEuz457EH5VCF+?=
 =?us-ascii?Q?ie3QJG6Z1EGjxjE9qRpljQFbuBg4UCvre1VKx2wK6Iy2X0rKUjT4JZx3Rygz?=
 =?us-ascii?Q?b0LA+DUfPPUredigUnNJOYjOm730RYLTiqTWkYj77tHRveccYueIGrMkWFPt?=
 =?us-ascii?Q?+Es62703ATM7aQBpDxzosYutqRrMLhOGO1x7Ke9cZYu34slUtnvr+aNAJNKB?=
 =?us-ascii?Q?zCSeR4punGWJ4qXyR//3lpBbuXu9ycOQhVagowo43ORX9kcpCZpRDzXaR7aC?=
 =?us-ascii?Q?ii+fmfFN32aYpDwi3ZGYKcSC65tYdPxqDNAXTqRlulnBeg1swKwttf7kp82p?=
 =?us-ascii?Q?Mfga5aCilcnqEHGAWDWLUXSo9EgfZ0dhqGlAmpeVH+HWPrD6UaqN9RxEhbfI?=
 =?us-ascii?Q?KviRMLqdyzCX1Ukx+voFAsf22e+CLr6SdubIYJ7Nnk7OmjJ1Kl9zAuA49a8Q?=
 =?us-ascii?Q?Ko6rG1XL6qL6lwiSfSScIag42TC5FzFGCkJW3NgknZpgJRiYMZAroIzQ/3da?=
 =?us-ascii?Q?BxpZ/mmsSg2sSdwkGkx5F78rm8JP/yCjWQy7GymdxHAZsKh7aI1IhHm7jYMs?=
 =?us-ascii?Q?Tmj++eLo1KzcRnYVHXmhM08Ski+kWoXuMN0+aQHgwgLcnkXt2ACnlNlLXCGK?=
 =?us-ascii?Q?edvcrz+tnHRauPsTVoZ49dPy7uwm0QBmNESUIN8XrZy/RmXXnyRdla3Pro0v?=
 =?us-ascii?Q?ZyYKibiKs2TBYKM0A/tOP4NmG/3cq7rRRY+Pq8f6/Ppbbu/2Xcysyg4EhI/G?=
 =?us-ascii?Q?7uDtSOz/n2Ib75BHlx4PfXP6cLs1vATPgib9DCaLYGuVgOz2S/pCuoI9qXwj?=
 =?us-ascii?Q?/r+Iva8kEgfZrUhBi5K2brO+fjC3erTezPjXpXLoVc3oTivi/cJoVjXo1G9p?=
 =?us-ascii?Q?b9OnjdVrUHB2T/WnxTklyEbGMhZAOeopVvszzuHR+cwuWjGkKMlIp184E4Cy?=
 =?us-ascii?Q?6Q0LAT0LrAi1h8FvzmbH7WANLZ1V/U4FomlyrDCGDNsz1Ds0/DkKOFnn1Kx1?=
 =?us-ascii?Q?EqE6WcJJII7prSH8YBgPrWceHLeSoEasFvS3+mRyv3jPVCBVInBR/EzUyzzy?=
 =?us-ascii?Q?Bwg8pNohMoQii9k2i6RrWP55oOou3kyO2ZyxXyp/zN+/vcY7DzihcCOxAq0p?=
 =?us-ascii?Q?g9OYgnrIDGdbv8R7GFp6FEGww0eVEUT0UTLBveoV3mEhb7NMDobNdUFb4jlP?=
 =?us-ascii?Q?OeWRYBzMXfKP2VSWTh+f6pYEAgM3PA/BeKG63wAYtxf6fz4awKAJJlCg2mIy?=
 =?us-ascii?Q?4DuNSOpp3o57wchmBpxAJMqnJY4PRMJGCflejQs3ZkRdWbxLg9Jj8Bl7W5EN?=
 =?us-ascii?Q?Q18tmBCKVuwxS9DGneA595LiBHI7x+qrqRG3a1BrFq/zOXFK4ahzii5MQW8H?=
 =?us-ascii?Q?hkfYCIiDpyhNK92fl7lJcKP1QF61WYCqMQLIKvVmXq4tD+UvCj/K/SDdOfw9?=
 =?us-ascii?Q?bSk1Ex0enPcAoFWGD8evV51YPglHsSJ03YrPkBlT9hziqzFGYFLa0czpW4v1?=
 =?us-ascii?Q?8GaLfO7bO1VWrsm+1PXN/cK9k8SfXhz7UNpxeUvFwgOTb/xbJeQs97bgJv+0?=
 =?us-ascii?Q?9EOzhi4nL73Zefq8kzlpj9r8XdMnqu68xy5z2LR7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ckVLfzMfAEbQI52rMKnAiE5xtTkRo0uNHxh7hniXPH5qn3+jYL7k1IBYBVeFPMNS7NThQIHbCxInx0se7JQujsfvm7acqZgursSPdyOSaun2H11/XbwwPed6XfsV7GfiQrCGcxkboUeitQwfA5UOF99fB6DFGzPcS+LTWmlqDoqChUXOIAexiDG2mvsBLqTWGdfgpEt7L8qBC6pbOyPt9OBkeazRTkfBNt6ktABTA8MdFoHMHSSVyXE1db2pY0wWvKbOyjg9/VWwwBMl0WIbaIHIKxJsgzIdex3fyM9XNdjb5zyUsbquK2aSw5/4jjhCIO7Y6rC7sOVP58WM+0Cg6nUJR25w7qfeuSkdjS7qY1F2jahaCP2EId+JBVjE3ZGg30z1FIQnSt30HtpN7q+J/TV3bFpzYvMi4YIuVUSkSengv2Pg4iXuAWOG3uW89dsDF+pUrGumXiB1a3LFSe+34rqdGnCGgPXIR3XGLpBfZAWsPFSWQRyI4z0VbfpOEvFGCnyP7QlVtS8FRLifS2GTj3hKn7RhowIleA89EppEmUCyeFnBPIzTYg1aSxeaPPB44jmSza7Sn4btGjHo+2NFkE9/WPPc7wyyzXJCTdsN4PE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcbf46e-9f7e-4d98-3ee8-08dd5507fd44
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:18:16.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNEVnOfVGUJzK1AJcIU+ZYoWLh/tBXKYLZJtSrGkASmMr66j7bNV9h3dbYrpIFKfGP7sMREaJ/Hr5zx4au2C2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240124
X-Proofpoint-ORIG-GUID: -0_A01huRZxHL-gBRG1MPj4zcXTPKaVn
X-Proofpoint-GUID: -0_A01huRZxHL-gBRG1MPj4zcXTPKaVn

* Jeff Xu <jeffxu@chromium.org> [250224 14:07]:
...

> > >
> > > #ifdef CONFIG_64BIT
> > > [ilog2(VM_SEALED)] = "sl",
> > > #endif
> > >
> > > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the problem
> > > in case that  "#ifdef CONFIG_64BIT" line is missing.
> >
> > I don't think it is reasonable to insist on doing things differently in
> > the kernel because you have external tests that would need updating.
> > These things can change independently, so I don't think this is a valid
> > argument.
> >
> > If these are upstream tests, and we need these tests to work then they
> > can be fixed.
> >
> As above, this is actually kernel code, not test.

Okay, so then they could be easily fixed to work with changing the flags
and it would transparently function in your ChromeOS code base. That's a
good way of doing things.

It doesn't make sense here since, as stated in this thread, we need two
defines.  But it does mean we are less locked into how this functions
and it could change later, if needed.

Also, do we need something like the above test for VM_SEALED_SYS?

Thanks,
Liam

