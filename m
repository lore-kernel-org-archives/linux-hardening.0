Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D73111AD;
	Thu, 17 Oct 2024 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729127455; cv=fail; b=GIdVsi4CFaJp0LX+EOnsC4qSWLgyR2lsIu7kDXVlKwGwTA/w/zQNYhrIgbMgDUcn/qQYOQhuNWdbEtbVuUUnv+3n1IMlQT0ti0537xnENps9h7qZkPXI0KgDN8a7Q38ANYfoR2gIfY1kLo5ADJ1A9B+8qJyLofay32GSoddO5MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729127455; c=relaxed/simple;
	bh=kV6trIpyS68r0Dec1o/rofnr+dMFUH0vgcFVP0xqD7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMJUdEgdmJBaDWuE7kofyrcMzGrR9jXfIiDTMz3dKHIRSUyUjrsr3yVBPz66IbJ0AaN8Lby44HZ83KbWbqvq7oSHI/En0yaGz0xf0VCYkmX+di/4JJKKy2x4j7U37I66AZ8UyptmC55Nx3shdHsMPRTj0qqeQSQKMfjkKsLdbIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c/fRJOtw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VS+AtTTX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c/fRJOtw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VS+AtTTX"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H0le0q022239;
	Thu, 17 Oct 2024 01:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=E51qVRM1ty9qmJ8l+y
	NyXXDIeCz4FbCNP63LdgeMPL4=; b=c/fRJOtwjKxbePJa7+ezVeZRjR/dQJfdxy
	68a7hxQ72QjXPnqUqZYek2L8pWcKqAv30wguhmF9qjbUP5m45W4p+8Yv6VQiSild
	Hq+I0sW8oryxWXsSvvmciF1dbRSEeevb7FKwKfl4HocU2lohuN4BGDcJtMnLD03+
	fM9mslJ9dFTq4STHMKAlW6C+Te142Iz18ZVSViyqEnVnZ0B5LuzkskqwuA6tT1be
	/mre6ZPM3babeFcLufjThhUL+HypqhGix56OltB+XYzYUK+JSu62CkhgnSSV5Z91
	JNEZzIiP2nWarX3qh4lgf9ucKC0jlPTwf2XU4AvC9G3H9fhum8DA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntd6gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 01:10:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H0LUjM036099;
	Thu, 17 Oct 2024 01:10:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjg066w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 01:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYP8oZODM+GKCP777Pv9TY0KPL0IVeofeLlJzwlaniP4s90PAHSLhGIuqCYkNgyUL9l46RXczxTZSW+FxQWdg51E24jwDxMapnJU3ZJrIBJb0LV0ZpQHbaWPXNp/r2jzawtuhXt2mYamlzOeWuQRf2UE7oXv9ufn+jJaxrVQQLSCEg06Lk84z4gMvT8iMbrECwfpNbp9R0Jhd0n9z4nHLkOB3jtKeBmRZrrdNVgi+TQ2vt1UqS/k80uZVHnOwfooXAzGGpw33KNjS+bCT53ikKJiz6Jp7uKdN/iVVxJN0tZypKSm0+laQLNkIbYqKHYI/a7CiHV6elzQ6WA2Ye4LLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E51qVRM1ty9qmJ8l+yNyXXDIeCz4FbCNP63LdgeMPL4=;
 b=c59KixdvXwoDhWBu4dcyXkKUZTk+DK4C77jNxidIxgFhi2TDq2Cr+AxSPqFVrIZ5rM3NlXuBSi+0jlEhDC63yqH082nxPHoURILIeFNzyxocl9HwgT5cs2pYjk89JMoW5dWRRCxBz4BG94gHIANZzuknjL3z+gvajPxmt3i32eJrhn05vWUylUV9mcmMT+cfAAe4REFxi6zEDDHSLmqVEJDAHmPtdrYgQbLB2GzOF7vpo5vlU4zbe7lP52IX9kxJu5W8RuCnTuEAQ3UY+5gks2oGS65eFSLiAByHOwHB0nXBO7qozznSgTSFcpjmg4cUZfm/Z4saHYOlxSVhp9UtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E51qVRM1ty9qmJ8l+yNyXXDIeCz4FbCNP63LdgeMPL4=;
 b=VS+AtTTXNo7Ydd1E8ojPXVE1rqEGaeL1I3+MgoxxjyHSk3O8F+SjMbq8t/LYfXU4T5evKS936hLqpdRvcXaOuy2KjTbBxGy3gFE6mcKqbnUqciXTOWFnY0NZ0pP1Tm1PvT4VpmQulS2dkq/PmK3vnEuMPyRYmfGTb3Mi5Kdzkas=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4676.namprd10.prod.outlook.com (2603:10b6:303:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 01:10:04 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 01:10:04 +0000
Date: Wed, 16 Oct 2024 21:10:01 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
        peterz@infradead.org, ardb@google.com, enh@google.com,
        rientjes@google.com, groeck@chromium.org, lorenzo.stoakes@oracle.com
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
Message-ID: <6r5sxlhfujr2expiscsfpdjtraqlvy6k3cznmv25lo6usmyw7x@igmuywngc5xi>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org, 
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, 
	davem@davemloft.net, hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
References: <20241014215022.68530-1-jeffxu@google.com>
 <20241014215022.68530-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014215022.68530-2-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0266.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f42166-7b1f-4e96-4daa-08dcee486edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+oV7otrubBYn5ZONc1JSgBbwrgIq6fAKdVjdacRUZD19XkiKdFfvIEOp4xgu?=
 =?us-ascii?Q?6Apumpvx3K5zz+4OooL9f0xdjJtaBHdq5MWfwkoOD4QojpV6/PO695WJyo9k?=
 =?us-ascii?Q?tiIa9+1jICWd7lAlAB9O3tSl3HYUtSZZZKugYy3Jp9/FQiGLDX0wFnwCGW+U?=
 =?us-ascii?Q?xep3UL8aYgSJJjOre5LKWS16BF9UGCReJ3KdgFasbkT1AdRiaWWDV2gjdZvK?=
 =?us-ascii?Q?dnAAIi7VtXLQ/VACbD1DhYgkK0+OqOPI72NeJgVe5rsRj9gJp++u5qoT3orI?=
 =?us-ascii?Q?Zt9Yjb9N0wUjwxcIW8crTiJV6QpLJZSVXZrl8uRrDAKG0y0nPVDw1ENIfyWb?=
 =?us-ascii?Q?39gfkFO9NBpmIgyLtpgap8ftUkCiCJDclAHMEBQOgrXuF+ihglPPScHbZgTV?=
 =?us-ascii?Q?zKSbZU4Xmq3FrhSlPssoeSTT81QboJ7wHPPuN/xRpSH/nJHEqCPCqFOD9/TD?=
 =?us-ascii?Q?9klj3/7H+s4+krrOfDVbLxp3oAek64TU8il3XdazVYKYZT8RG+l+0s9YBn8V?=
 =?us-ascii?Q?hP7qD/kmrkWYtnsYutusODVyG5lpaPD3wHkufy3XYLENOnHnVVjRMWNNQpVq?=
 =?us-ascii?Q?4BIqkQiAC3eI8PN2J82NfZAA5fjRh/PFga4noi1lnUAWjZaT1LabfxTScUbv?=
 =?us-ascii?Q?GrO0c3UDnKslra0d6TXwuXksrK1K65bAxJugU0SynQ1NhkFw9DU3TnXBdpL0?=
 =?us-ascii?Q?hlacEdStcewiQUkmHlaLrG1X5VhzCLkUcJKo/rnS/tMU+vIvWk4st/eOQvgi?=
 =?us-ascii?Q?gQyoyHJy2kGNHlnN6BC2s415kOvxw3g65sc0y2FfJx5mGZX1JviQGDR/0Mrd?=
 =?us-ascii?Q?4AOFkNrUw8iMNBpmDWblC8jOB3rs6OmDqverxeZ3Q+QUYpRUZ88rYOzCrzNC?=
 =?us-ascii?Q?Fw7kA9kB8KOra9rFvJweBgURutNvk3np2ipYmlmzT29p0Mi9W229Eu5dMJWY?=
 =?us-ascii?Q?B35n2/M+fLspLMnZ1PcKgS0r8KvhykU5OAW2YGhBslOAHOeltT3Jk8G4QCD7?=
 =?us-ascii?Q?3yrmaVWGwI62GFmt4x6ApOiObV0L3UYGCHv3SX3w64wrX2vTmsCyhy2+cgl0?=
 =?us-ascii?Q?C6gg6qvnWMrNN66BvT+kZLxHvs8biL+KxQk8nBFig6CjNbFvdpIZnllkjUrD?=
 =?us-ascii?Q?w7myKK13/uyzOIIob3apXLs0abS8c+vxShKJoLF9cYGQb6pfoFv2lDnV5j8i?=
 =?us-ascii?Q?ZERYFe/XBZv2nv0gRPPUzbrJh7CDtiXfzysXeVI8TKrJo58OXQfsLvqVHIGc?=
 =?us-ascii?Q?IsRB9Jf9geIShKKBl8HiP1xAIyw92T2JW4o9jzOtpY5Zj1HHsytt/vRFlPZQ?=
 =?us-ascii?Q?V6Wcjv9xyAgWlEXDLGWq9Yok?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4B9vOo2UfJFMqg5RUI+iutqCQ+fqIp/BFn8RbgvsQYWY5RJsFRsznPcP3KrG?=
 =?us-ascii?Q?rK0ZLfh40U6FhmzUPfX+uRGaDFaW+5KddwPFEF0FJQuDXs4Ki4fjcUG9w2wy?=
 =?us-ascii?Q?8fOe2ZllaAhvwIJtNnpAh09eXev7M1bSRUpTVpg7TOuNN/I3IGiEZeioXLBg?=
 =?us-ascii?Q?jPigh51892trFEsWlLY9q3UcCoZ5RRVmuI/JLN2PzderZBdeINke7ftPwoGC?=
 =?us-ascii?Q?8ycMLyDkTmp8mKkEQKTbO17dBiVQAlndD8Fpt6YuBQSQ/aiLHcI7b8Vuvznj?=
 =?us-ascii?Q?sFBaS4jz+yFY6aa1BmZ7j6nMsNDMYtY0PkkZkVvqoh1YvYwj9f+gPA5DPtnx?=
 =?us-ascii?Q?Yq7QaRJHJWAvP4wyHB5KeGJPW8MoSmrezQiTKZHx/GyWCK5AMfwYi5WOVFGe?=
 =?us-ascii?Q?W0hWng4XuXW9NtKhBb+dGrbJu8aVsPTKZAvAqwdYnVaXswTWoDJ0u4GpvFbB?=
 =?us-ascii?Q?rn4K+uQ52PYkBnHLVgMlD8UObQj17Zor0qGqLMRMub8mwAtuPMnhIaOz2pm3?=
 =?us-ascii?Q?ybxp2Y858VaXVtxSukxspn3EjdwHaj6l2mHn3GP1YMe/jNLzN7nrM0bDxjGS?=
 =?us-ascii?Q?VxqFBGzzvUzsqdv3h9trzISl1LoOMS7XYofRqiR1aQHR7doMhlOVtpvO0ZeW?=
 =?us-ascii?Q?VJkGGQU7vResWLC2YztlGf53kUy29N5rozCapIjGD/yxgErj9Gw7BSWz9n2k?=
 =?us-ascii?Q?x0odFrKBYM5k/pkrldoBxSbKc28LdpTCRqcIXh3lTNNSF3XVqciGAQQZ04Et?=
 =?us-ascii?Q?wX0MUdrC6biHSzrytGCVOoMYbvAST3wy468GefnWbx0GgUJThIdvT3Nn7vV2?=
 =?us-ascii?Q?qFg83An/IAiHg6GoIbzrVspJBCU/df5Ku50mxBRsU6OixoLC4NrYjpbvMfUY?=
 =?us-ascii?Q?QZ2iWJnJ51ewGkYQQjvAVpF8xNmop+zjsh4G4EVKwx9wO8KA7hTHYVj5SSTV?=
 =?us-ascii?Q?OWbbOLpDP3Sqj769i1VZOZfG5aghbVtUt5Ncxzy4E44OZj0nFe8Y0NgVo72V?=
 =?us-ascii?Q?Up5ndKDotU4KYA6NSR71zY95yLpenf/4CnW/f8Uu/S2VCuOgPjAWcgt27YIk?=
 =?us-ascii?Q?lcglz6k76aQXcNFb1r+9slBczv7XgxsthW0pjvNgFUH0bEvvzM1mTca9T3fQ?=
 =?us-ascii?Q?+OlnUOrJWCO568hX8Oc+ccZBH39YTJLSg8N3wYjw01J3HfA3PSuvP3/z4y9y?=
 =?us-ascii?Q?o5xMJDklDof9gLes8fcUpbB1w3EpEs06uI5481GWanUrcVuRNzRkgl/I2f8Q?=
 =?us-ascii?Q?HVYzJuuRsm2CW+OA+s+OQD3loFxdVf7lPTtCZKf2JSm53IkFL5dVK19eG3+P?=
 =?us-ascii?Q?Ft64Wc0meWEOgJ+LQdH9tbJCMZjgEaTc4O/GSkPSU8Xhpt/lfju2nAkEniqt?=
 =?us-ascii?Q?KgwdkSyy7VUqNIJQc3A1iSPbVJa1LYZlU1JwalJHmEUT46919KpJ3HVxgsvj?=
 =?us-ascii?Q?4BkEmcvSN1nV26iaUvyH14iUglVO9HAO8gdpy9pKwLnlzn43jD5Vl9Kin7Cc?=
 =?us-ascii?Q?5GQfQ9iE3z1ZhSKw6JCnwcpv6bT58JVVPp3/QI9O0uXzvk7zY07qdzuKAsYZ?=
 =?us-ascii?Q?yGHZ9cNPjpiADTqKg6lKDJ1JTGi1g3g60uTRwjr9p1eHjkCOydWvhQ7DDwKJ?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ptkSLkqlKN1jKy373PXHhgnYklFNqYgzb9Grphq+KMkPmfTozVEStuzpTMQTMEp4sCW0YdDfnyZmXjvJady6Dqt0KE0Iwz/Azs4S3YrwNT+y+3f42bKBqFWGSFkjWQNG4uyvO3O9AYszbN2Z+7Mc439BW3a18aQqcutfnlKfNwXrGXjx91YPNis9HN1rKSxFFcy/J06YhDKQbuUZ6XHXuAaBf3Ol4+PRa8EVzwkyFHgVe4eSDKuMJ7imxDLnEEBwvqWMs14P1B3otUSN5/arfrm4BIS+LWWIZjxpLc66sDirrjz0IRqdfdcLYY3EglaeJJnX7cm2b+wPfU3H5jA4BPemaB3vBxYN7UfZP7Lvk4E/J/+5DKRDg0dOWpHrfiiobeUHrNJ20j24rHqpMle012SR7Y4LOmivmy6VW2RyF5eHH/WuJR0kj7f432Xr6aZL+VbQYP3qbrxi7y3qVQItd2IiVsPAmmRnZKwnQ1pnztUHmQg27oudObd3PX2WaI8hKLurDSOrqXiT5t9V/ZaAkhYlLxfgZOB2qyJKCLDnGmr+yv/popvWG0d3EAVKUE78bjcYqDlARw0AZZzU7Ud6ceV4C2Fh+Q5iAjP15pFtlbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f42166-7b1f-4e96-4daa-08dcee486edb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 01:10:04.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EANhKj22Lo8x4qA/akdjKe51UJDw1FwfBhjPn1oTvZlhuoaOjsM8BYGMTvHDbMy7oLDJRXOdluRZia1xG+QBfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_19,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170007
X-Proofpoint-ORIG-GUID: GL4qcu-h_NcNf0MXBvE6k28jq8WMjvty
X-Proofpoint-GUID: GL4qcu-h_NcNf0MXBvE6k28jq8WMjvty

* jeffxu@chromium.org <jeffxu@chromium.org> [241014 17:50]:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Seal vdso, vvar, sigpage, uprobes and vsyscall.
> 
> Those mappings are readonly or executable only, sealing can protect
> them from ever changing during the life time of the process. For
> complete descriptions of memory sealing, please see mseal.rst [1].
> 
> System mappings such as vdso, vvar, and sigpage (for arm) are
> generated by the kernel during program initialization. These mappings
> are designated as non-writable, and sealing them will prevent them
> from ever becoming writeable.
> 
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [2], thus sealable.
> 
> The vdso, vvar, sigpage, and uprobe mappings all invoke the
> _install_special_mapping() function. As no other mappings utilize this
> function, it is logical to incorporate sealing logic within
> _install_special_mapping(). This approach avoids the necessity of
> modifying code across various architecture-specific implementations.
> 
> The vsyscall mapping, which has its own initialization function, is
> sealed in the XONLY case, it seems to be the most common and secure
> case of using vsyscall.
> 
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the mapping of vdso, vvar, and sigpage during restore
> operations. Consequently, this feature cannot be universally enabled
> across all systems. To address this, a kernel configuration option has
> been introduced to enable or disable this functionality. Note, uprobe
> is always sealed and not controlled by this kernel configuration.

Considering that uprobes are always sealed regardless of boot or kernel
config, the descriptions below all suffer from inaccurate descriptions.

It is also very easy to overlook that you are changing the default vm
flags of uprobe, especially considering the text implies that they are
not altered if you select "never".

> 
> [1] Documentation/userspace-api/mseal.rst
> [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  .../admin-guide/kernel-parameters.txt         | 10 ++++
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
>  fs/exec.c                                     | 53 +++++++++++++++++++
>  include/linux/fs.h                            |  1 +
>  kernel/events/uprobes.c                       |  2 +-
>  mm/mmap.c                                     |  1 +
>  security/Kconfig                              | 26 +++++++++
>  7 files changed, 99 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e7bfe1bde49e..02e5eb23d76f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1538,6 +1538,16 @@
>  			Permit 'security.evm' to be updated regardless of
>  			current integrity status.
>  
> +	exec.seal_system_mappings = [KNL]
> +			Format: { never | always }
> +			Seal system mappings: vdso, vvar, sigpage, uprobes,
> +			vsyscall.
> +			This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPINGS_*
> +			- 'never':  never seal system mappings.

Not true, uprobes are sealed when 'never' is selected.

> +			- 'always': always seal system mappings.
> +			If not specified or invalid, default is the KCONFIG value.
> +			This option has no effect if CONFIG_64BIT=n
> +
>  	early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
>  			stages so cover more early boot allocations.
>  			Please note that as side effect some optimizations
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 2fb7d53cf333..20a3000550d2 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -32,6 +32,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/syscalls.h>
>  #include <linux/ratelimit.h>
> +#include <linux/fs.h>
>  
>  #include <asm/vsyscall.h>
>  #include <asm/unistd.h>
> @@ -366,8 +367,12 @@ void __init map_vsyscall(void)
>  		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
>  	}
>  
> -	if (vsyscall_mode == XONLY)
> -		vm_flags_init(&gate_vma, VM_EXEC);
> +	if (vsyscall_mode == XONLY) {
> +		unsigned long vm_flags = VM_EXEC;
> +
> +		update_seal_exec_system_mappings(&vm_flags);
> +		vm_flags_init(&gate_vma, vm_flags);
> +	}
>  
>  	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
>  		     (unsigned long)VSYSCALL_ADDR);
> diff --git a/fs/exec.c b/fs/exec.c
> index 77364806b48d..5030879cda47 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c

Does it make sense for this to live in exec?  Couldn't you put it in the
mm/mseal.c file?  It's vma flags for mappings and you've put it in
fs/exec?

> @@ -68,6 +68,7 @@
>  #include <linux/user_events.h>
>  #include <linux/rseq.h>
>  #include <linux/ksm.h>
> +#include <linux/fs_parser.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -2159,3 +2160,55 @@ fs_initcall(init_fs_exec_sysctls);
>  #ifdef CONFIG_EXEC_KUNIT_TEST
>  #include "tests/exec_kunit.c"
>  #endif
> +
> +#ifdef CONFIG_64BIT
> +/*
> + * Kernel cmdline overwrite for CONFIG_SEAL_SYSTEM_MAPPINGS_X
> + */
> +enum seal_system_mappings_type {
> +	SEAL_SYSTEM_MAPPINGS_NEVER,
> +	SEAL_SYSTEM_MAPPINGS_ALWAYS
> +};
> +
> +static enum seal_system_mappings_type seal_system_mappings __ro_after_init =
> +	IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS) ? SEAL_SYSTEM_MAPPINGS_ALWAYS :
> +	SEAL_SYSTEM_MAPPINGS_NEVER;
> +
> +static const struct constant_table value_table_sys_mapping[] __initconst = {
> +	{ "never", SEAL_SYSTEM_MAPPINGS_NEVER},
> +	{ "always", SEAL_SYSTEM_MAPPINGS_ALWAYS},
> +	{ }
> +};
> +
> +static int __init early_seal_system_mappings_override(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	seal_system_mappings = lookup_constant(value_table_sys_mapping,
> +			buf, seal_system_mappings);
> +
> +	return 0;
> +}
> +
> +early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
> +
> +static bool seal_system_mappings_enabled(void)
> +{
> +	if (seal_system_mappings == SEAL_SYSTEM_MAPPINGS_ALWAYS)
> +		return true;
> +
> +	return false;
> +}

This function seems unnecessary, it is called from another 3-4 line
function only.

> +
> +void update_seal_exec_system_mappings(unsigned long *vm_flags)
> +{
> +	if (!(*vm_flags & VM_SEALED) && seal_system_mappings_enabled())

Why !(*vm_flags & VM_SEALED) here?

> +		*vm_flags |= VM_SEALED;
> +
> +}

Instead of passing a pointer around and checking enabled, why don't you
have a function that just returns the VM_SEALED or 0 and just or it into
the flags?  This seems very heavy for what it does, why did you do it
this way?

The name is also very long and a bit odd, it could be used for other
reasons, but you have _system_mappings on the end, and you use seal but
it's mseal (or vm_seal)?  Would mseal_flag() work?

> +#else
> +void update_seal_exec_system_mappings(unsigned long *vm_flags)
> +{
> +}
> +#endif /* CONFIG_64BIT */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 42444ec95c9b..6e44aca4b24b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h

Again, I don't understand why fs.h is the place for mseal definitions?

> @@ -3079,6 +3079,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
>  extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
>  extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
>  extern struct file * open_exec(const char *);
> +extern void update_seal_exec_system_mappings(unsigned long *vm_flags);

We are dropping extern where possible now.

>   
>  /* fs/dcache.c -- generic fs support functions */
>  extern bool is_subdir(struct dentry *, struct dentry *);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index c47a0bf25e58..e9876fae8887 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1506,7 +1506,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  	}
>  
>  	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED,
>  				&xol_mapping);

Changing all uprobes seems like something that should probably be
mentioned more than just the note at the end of the change log, even if
you think it won't have any impact.  The note is even hidden at the end
of a paragraph.

I would go as far as splitting this patch out as its own so that the
subject line specifies that all uprobes will be VM_SEALED now.

Maybe it's fine but maybe it isn't and you've buried it so that it will
be missed by virtually everyone.


>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 57fd5ab2abe7..d4717e34a60d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2133,6 +2133,7 @@ struct vm_area_struct *_install_special_mapping(
>  	unsigned long addr, unsigned long len,
>  	unsigned long vm_flags, const struct vm_special_mapping *spec)
>  {
> +	update_seal_exec_system_mappings(&vm_flags);
>  	return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
>  					&special_mapping_vmops);

If you were to return a flag, you could change the vm_flags argument to
vm_flags | mseal_flag()

>  }
> diff --git a/security/Kconfig b/security/Kconfig
> index 28e685f53bd1..4ec8045339c3 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,32 @@ config PROC_MEM_NO_FORCE
>  
>  endchoice
>  
> +choice
> +	prompt "Seal system mappings"
> +	default SEAL_SYSTEM_MAPPINGS_NEVER
> +	help
> +	  Seal system mappings such as vdso, vvar, sigpage, uprobes and
> +	  vsyscall.
> +	  Note: kernel command line exec.seal_system_mappings overwrites this.

Not true, uprobes are always sealed.

> +
> +config SEAL_SYSTEM_MAPPINGS_NEVER
> +	bool "Traditional behavior - not sealed"

Not true, uprobes are sealed.

> +	help
> +	  Do not seal system mappings.
> +	  This is default.
> +
> +config SEAL_SYSTEM_MAPPINGS_ALWAYS
> +	bool "Always seal system mappings"
> +	depends on 64BIT
> +	depends on !CHECKPOINT_RESTORE
> +	help
> +	  Seal system mappings such as vdso, vvar, sigpage, uprobes and
> +	  vsyscall.
> +	  Note: CHECKPOINT_RESTORE might relocate vdso mapping during restore,
> +	  and remap will fail if the mapping is sealed, therefore
> +	  !CHECKPOINT_RESTORE is added as dependency.
> +endchoice
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 
