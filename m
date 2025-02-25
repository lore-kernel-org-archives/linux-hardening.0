Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F3290F;
	Tue, 25 Feb 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497524; cv=fail; b=Fj/h3gCSDUst3VvxrnNUwmL7aobVANonoj7A8ZvbA/LEOUVmsDvyBfXW597tdrk5esMl9IrFQ8hTifWYd/TUnCXIB5oT6G5fqYE92UXVlSY3RBnUhufwHaa4PlxCRIy8nl9uvKSwDwgihAQnfVXj+hAfh9e+PGk03SZcZ/w3FhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497524; c=relaxed/simple;
	bh=7Jr1l00RrHKC+BdQA8dYodRqldMHP2VL/cKnWsiPmI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tvyNLMxd2mf1tvvMe0BG8pj2OKqs7AxQcyKiMeDrcQm4f8V83rNGTOrEH8MWoxLulRsF1dRSz0LEkULCh2wf9q56jteLxHQQtlLglGuHVSXQxbINrQnhfXn/ROqQE0DtVSq8Qe8h53GfR1eXmR9kWaGOv2DlwD6OkPONTY93pwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cgG+mblu; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mYHSUyRU reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cgG+mblu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mYHSUyRU"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMb90006516;
	Tue, 25 Feb 2025 15:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7Jr1l00RrHKC+BdQA8dYodRqldMHP2VL/cKnWsiPmI8=; b=
	cgG+mblurTxhoZsmmgudCetHWruHVT6mF69O33TSS+PxnGCkWIkPWDtH1Cwux9CJ
	vGFOYyBnhxqjXsZ+F8GVgJMiUwNmgpoXrP0hViqPSZa63JUurdO9WPApFbM0/IrD
	zSUiiuvIbHe6nRASDqs3zOkx6ZV2ZojihNG/qbs+YKEZVAy8HAPq/TchRH2m1+nT
	Hebj5x+zq8Jo7DmWbt+vsYl090IVeKzSKsR60uTjNw6L+alKXHGE8V8YlDxWAH+6
	KdZP0CTV+nV0fdm3IfGnusZjY2V6Lg4S4ampX+oqMxMwYAwWRn2g7bo3yBMXW10Z
	wiF13UnAznzyZSS1LTqYvw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bnggs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:31:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PF7giZ010281;
	Tue, 25 Feb 2025 15:31:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5193tgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:31:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVD5skCwqy6nktJkrV4+5zVmivupahjf1s+fm3E0oO6SeYYMz0I6hgsVc5nsSYfjed4R7/+46aw6/qTx/W6xPopbHjLtZ5ttSPgz2AZIy/wnrg3AM00sxxcH5yNiatKSUPg8gJnA2DaMbkqFvZsKuwxK/GRIFvtaNLXDM1xciTifDW48JvNy3RgRdEOTMvxTLzLxwAFAQwR8w1taXrPAh4viGiR8BFWbfmIhwdrZAIculY5tAruuPzUNnRB8UQIaCYPrtx4dDmXhg5kmeBX26ejlhp9zAOoDyuRsW8RfSnM88Dc3yvXpiJuPq1vK0VeX6Hx4IAZAP4yyxIKJ+tUkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGOc5aRs5HzBkO6Af4cIPeSo8o7e9w4Mtvz1FDGwrBE=;
 b=qjQ+ys342l8sLUpZvJA7ZvSxnOLiLhGy9AFV65NlVEv9ME5Z2P0sO4QLASKI3t59y3BkL7HQa2PSXeWNcOFn8GB4L1B7+5cO1lIZYqDv9OzVzYOrlB2BwwZ5l1sauDEShqQhNWgA0JeKrxT5w3/U3zOHIKquW6mNKX2OfG9PMT/j+WPMYF6Oo5wKWDYWSd0UrajVk7Drx47vZKabjnRW07JeqGD/MgGO8P45GXi0bUJdSgU00pr1ijr8MUm9P/ghsO04Kh5N8ScIX537Xswq+990o/S+NlrYshiNfsBRz3oOJIqis020GG983qNlMOX+NaZ3dcuE+ERFiX2foC1s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGOc5aRs5HzBkO6Af4cIPeSo8o7e9w4Mtvz1FDGwrBE=;
 b=mYHSUyRUvOeQbX/mPKtvFPc2Hsh8mFHOIfmK5bBwkV0J4MZtGYzGd726phmhYRuME5Ra667msJl2aQkz1xrykYv/Mth8kIxydnCMcLW6yyWG+0wvFFBBprEzP8ll8+x4nHXW9fSyOIQICZYbKnF0i57mB3dXuXlugfTgBwMAzn0=
Received: from BN8PR10MB4099.namprd10.prod.outlook.com (2603:10b6:408:b7::32)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 15:31:09 +0000
Received: from BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d]) by BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:31:09 +0000
Date: Tue, 25 Feb 2025 15:31:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: "Berg, Benjamin" <benjamin.berg@intel.com>,
        "jeffxu@chromium.org" <jeffxu@chromium.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>, "gerg@kernel.org" <gerg@kernel.org>,
        "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>, "enh@google.com" <enh@google.com>,
        "thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>,
        "hch@lst.de" <hch@lst.de>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sroettger@google.com" <sroettger@google.com>,
        "ardb@google.com" <ardb@google.com>,
        "jorgelo@chromium.org" <jorgelo@chromium.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "mike.rapoport@gmail.com" <mike.rapoport@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aleksandr.mikhalitsyn@canonical.com" <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
Message-ID: <de5577b5-5d9d-4173-99f7-8c156c53f175@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-6-jeffxu@google.com>
 <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local>
 <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
 <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local>
 <DC169C8C-BF10-4125-AA91-29E48BB1AD6A@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DC169C8C-BF10-4125-AA91-29E48BB1AD6A@kernel.org>
X-ClientProxiedBy: LO4P123CA0512.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::18) To BN8PR10MB4099.namprd10.prod.outlook.com
 (2603:10b6:408:b7::32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB4099:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fd63a7-74fd-417d-a543-08dd55b16d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?O9C1uW45wf5UHXb/Dipw9Phcwq/t8nQy3Mei9wdjiL2ooatNxYvvJpCZo1?=
 =?iso-8859-1?Q?kx1mc1xRt6lOJoNH8rawu4UDy+EAh+/FK1/KoTJ1R8fMbXOvxdn4VkZ0/s?=
 =?iso-8859-1?Q?nu6SRUrHQz1CXkgY/1Fxvo4rJCJ498tPYzkOJnV4PZgCHuX0f5ez8fa8wY?=
 =?iso-8859-1?Q?7v0mTwDdt6pKHnSE0OZBumq0lgQEmm/s4l4mSaaYDW19jG5PS1QhSDtpj6?=
 =?iso-8859-1?Q?QROC5aosspeJfw/7fZbSZx2ptVsnKp119Q9HzVPQo2PtR1c7L+Wdd0ejvX?=
 =?iso-8859-1?Q?Mt67qYMjK4z/zpaLo334rOOTU2W+WEWPl2RgEKKAPqpQXvmJVqr48LJyrM?=
 =?iso-8859-1?Q?5cEu8yDwNzQ92w2xWZCriV53IBTqj1c5RClIpMyG8SIJ4xk427IzPYnJTO?=
 =?iso-8859-1?Q?W6klLaLFoCphcPg6BQmJqBvu5w4N0HUa7UJitJhbQ/DKj3V95y9ZdtYfDC?=
 =?iso-8859-1?Q?8lygxcsZM7Ya08MnuO6CZNTmnyFvsXVy/1EQalGIqKGDN2jQxA7+Bs2f2N?=
 =?iso-8859-1?Q?BaN3r+uct3xhXFND2XKrDLx3LT6nliyofceIUc4cGyuJ+vaF+vHuEJjeK1?=
 =?iso-8859-1?Q?MZg68zfwLb7D+OVfQ8m9sw0NdrTuYOYTEa1MqaLTCFatSBf9VIrz6SI2mM?=
 =?iso-8859-1?Q?fpDbZWoC403WzRBh293sZhyZjVX8+YpFJGKLwJq7G1agdnYQIUFfcTfr3Z?=
 =?iso-8859-1?Q?2i46282Asdo8J/i2y16b/977/rd0Iv+2FO2Uva+OWgfZPc7A/D87zPjCxk?=
 =?iso-8859-1?Q?EunijQtkhHmSnR+8BYlEipWz0SGK9We/Vd5TbSLM1RjiNvZZ2JwHQQ7rJt?=
 =?iso-8859-1?Q?zuG0AXuGuLRf47r4UVXbODdMx7ponHgRPhCLDxxvFEi5f5FeWWCu39IAGm?=
 =?iso-8859-1?Q?F3Vi05CUmCXeEjZCcVpgasFletUD3A57Deo7kSOWVTMJASrbcoH53B+kzr?=
 =?iso-8859-1?Q?56XLzmBEKXskQ2USbNZ29MzAqAX5JCFwGGIHuJon7G3XNyfGHuDIDpDsb/?=
 =?iso-8859-1?Q?z43u1q3gRjpGhtZCJiU+Zzvm34QhkfjhhswD8VspzZTEydd2DUqec9wE2/?=
 =?iso-8859-1?Q?l9AlRoWCTJszeaPsLTlhmzGdiiNdOgYnAm1HSyWuurVSs9Hs62V7u1363H?=
 =?iso-8859-1?Q?qUFTqa9HbIjrbvd1ndEXn4ty93qmX7fClibltHU/TFeisX3FEVqOudAAQ6?=
 =?iso-8859-1?Q?khfgpkd/2qi5T6upNiudYBgkoXQMhClI5rtp2d9qj7mpa/Xt8A5pAyZShh?=
 =?iso-8859-1?Q?2ZwLEn4fkZjpthFVi+QhbvI2zo8p9Sx/V8O06CsmUtOJ9hGUC+g4GdIFQ5?=
 =?iso-8859-1?Q?IfSorRxbUkADoDGmgdxO434aH7JNyLgxE0xmvxOPiNeFrSMQBgem0S/zcI?=
 =?iso-8859-1?Q?MKGhx8PR809KfI6wYtwIB0eFHeQvvxTh2ByVysb9FxJIFAgupihUBWbf3y?=
 =?iso-8859-1?Q?rHyiWEoCsWjSA/GT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB4099.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?bxJS9pTvEvixIl8pS010fjsBOd+9n3rPAIl7oTQcSA894gDMeF4dpL+Nm1?=
 =?iso-8859-1?Q?L5k/4O3/Su0UXtS7MXdT69/940OMdHeJ08j1G7MwXDWxyqGDHMWHn8xi2C?=
 =?iso-8859-1?Q?3Ye0bfLcpo0Wd2EBPaqb6MiqZBXYprpUPrfHQgKbLyQP0Sbqmk1XX/Yo5C?=
 =?iso-8859-1?Q?MvLp3K7QI12lBZtuC0j+bF94k8Bvk2T+catpe8pcqzeJUaH419xAahtwu1?=
 =?iso-8859-1?Q?td6Xhqmt8dLi+NRe5o5zF04eSJp78yrmT3Ceh9j5x3qE2RmwqyTOQ6uT8I?=
 =?iso-8859-1?Q?JeFNsBBaAFOFhM10vHzZLNgJ4tYFRbAUr7g/MVvwaldTGUszVZw4GflXUo?=
 =?iso-8859-1?Q?RkOnqEOXUteHsRj8MRIYC9vpJDghGR0MbGtPJZtiFV9uLTHeUm5L5Ct3Fn?=
 =?iso-8859-1?Q?8NbzXILkvPX7S/hSOw45DdP/OGqXQbi9Lblu/VB/Oxa8104SYv0c+QrFKe?=
 =?iso-8859-1?Q?+IN+bBquQcWEVS4nJ5yr0SIfb/y5xZV6ED9Qz7AFeiUYqaOmuPJdYj4PBP?=
 =?iso-8859-1?Q?6jfMCoWyv/7OJCOeERoNeKZujIayFp99SqfeyrXXbxNJrSpdLnmjFyylRn?=
 =?iso-8859-1?Q?JiIR/hLuEVZF6iuC8qQPnqQOzDLn3hNBpsJgs9Af8GILErdyOyLGkPvATp?=
 =?iso-8859-1?Q?vfnMZcDrJwsH4FhDDvShZTL+rRAhmdp5kGMd9UADfFf45xcc3xAaUxngFf?=
 =?iso-8859-1?Q?RFLczQMvIjdL8HXKhHYOXdB5/VnwBHOseRLnEqOjLimnMg70Z+gsRXgQhI?=
 =?iso-8859-1?Q?rGsgq6hz65oqSwW3bHRkZfqQlT54bprC3UWvOAkdBPDskLeL9LkT2fa17o?=
 =?iso-8859-1?Q?6VrdRBwitsGp5EW1F4FgeJ5ITcVbi3dhdT/G4MGx7naN86SEH5DM9EB9m5?=
 =?iso-8859-1?Q?B0EP6AnSGhN22fFTuIvKZ8fJnWTicP2qUKLishNCSdYxsZ9+F/V+NPf9dZ?=
 =?iso-8859-1?Q?tbmecjT131QFxF/ZeOBZI8v3Y3vfLCTxI/nZlgURjzHiiN5Fcow00SFS6E?=
 =?iso-8859-1?Q?s0XFvwZlzBTHCpooGVNQBf1THEi1B/CsocbGFk4+liSeI7heDdDtlPTRad?=
 =?iso-8859-1?Q?Ir+vS9x6hYoEj4xxmxXa185D+qGBGDodpKXiFZRO9Te40KtflgkJBPq0kZ?=
 =?iso-8859-1?Q?Kd6S6yuvPApbp66cO3TY/1G3z+NANFSjyrEp+uG5eOFxSfgNcZAC0O+fJD?=
 =?iso-8859-1?Q?0hVzsDCEmWzpU819kf3BIz6iJ9CQ38ZWUuPGTU0qRua6gPxj9kSnis7X5F?=
 =?iso-8859-1?Q?3qJV+uNttyQ/H0TR8HNQBk/7QepuBRYGJDvoVdzWRpkSgFMG+216KCOe55?=
 =?iso-8859-1?Q?7YCbwWwuaE355ygl3JldHGAV35hqmcfBFcWxJeQwFOVBG+JxwI3gXHXQnP?=
 =?iso-8859-1?Q?5UYe/0xQs+CQsbMl+pEhYME/G1LdGM8R2W39clDOAkWN/U8MEDx9miGHD1?=
 =?iso-8859-1?Q?6EwqOFwbjS0Ws0hVW8gu++KiYt/S3DzpB2ZtGNTmPRqXbiq9tzkdKi7iPz?=
 =?iso-8859-1?Q?EipwZFqhYwN60vLfzRY0a7VHjMiJoFPYjNvgkw3eX/Cpa1UDaygeqd2GE0?=
 =?iso-8859-1?Q?QXVzniIlSivIHiZNH3LnLsdKxt+9xJ/9IvJOMM7S9sEo9LzheCrP5qj84u?=
 =?iso-8859-1?Q?V5giaicezVRSizF0VcFh1k3NPu+302HNeo9LiKY/ZF4nMAJhR2qDCabA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8i6bZKOq9C/vAr5+JmhqBOXjgzNdWlqB0Z9kk9zDrdK09NIzG/OzKpCZH6OLDvMkVEFcEghDJG69rlemUZHMFeGtW8LBJkBdF3SPFt4arwevpNotMppjnBc3+rn1c6EW3twJRic1CYu5Bg5dw21/EqS15JNY2iLcoieBjXll7/UrPnO+vnH8sgD8qGVPgzyOI2pU0kKkxuluzcY9PupnG7B+JRTVXpI8teJevzLHjnEsq4ZfCLHC82Wld+jqhm77vSv6+ViuzvihCc8bjdE7CHU5ujD+mtf6F5f+BicZX/IWlTGJ54iKdQGsfYMTrQIjXoneAu4R3ZOioTGvFUz5yhRKyzoSC/+xTBCzG13Azj/BuS5gcuX1AGBhRyaPhxvl4zJ/VIns9lqBdEIO1WgaMdCiRfdl2qr6+6QwsVVU2f+T3cuNWMWa9DFW2x8GRFK2WOM68zvCiPbis6u2lHdTPXJjmwfP8JVuQXYHSwMEqszW77a7Lhy8PmUQhWr2C/hZxxcCUJefjkAQy6lKqdDDATM3kKYbD+OSe986kmsEiWCOKG91h1tWXjn3hof2fLA7UjEiu/hYEsabhlh1gEmlO63rN7dBmupdlrnD4+hJct0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fd63a7-74fd-417d-a543-08dd55b16d7e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB4099.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:31:09.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYm8gHKk0q1HK6XxLcGsl/gR0ePqbAMdgLkeEJuhOMBYrCKLOuf5LhckNrEmUyOReyf8t/iFRjVrACWgHUccoGIDsbNtGmpYfUUxvJJy0MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250102
X-Proofpoint-ORIG-GUID: UKqh8XueMteImGXZxCc2TD8459o4amVm
X-Proofpoint-GUID: UKqh8XueMteImGXZxCc2TD8459o4amVm

On Tue, Feb 25, 2025 at 07:06:13AM -0800, Kees Cook wrote:
>
>
> On February 25, 2025 2:37:11 AM PST, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >On Tue, Feb 25, 2025 at 08:45:21AM +0000, Berg, Benjamin wrote:
> >> Hi,
> >>
> >> On Tue, 2025-02-25 at 06:22 +0000, Lorenzo Stoakes wrote:
> >> > On Mon, Feb 24, 2025 at 10:52:44PM +0000, jeffxu@chromium.org wrote:
> >> > > From: Jeff Xu <jeffxu@chromium.org>
> >> > >
> >> > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
> >> > > the vdso.
> >> > >
> >> > > Testing passes on UML.
> >> >
> >> > Maybe expand on this by stating that it has been confirmed by Benjamin (I
> >> > _believe_) that UML has no need for problematic relocation so this is known to
> >> > be good.
> >>
> >> I may well be misreading this message, but this sounds to me that this
> >> is a misinterpretation. So, just to clarify in case that is needed.
> >>
> >> CONFIG_MSEAL_SYSTEM_MAPPINGS does work fine for the UML kernel.
> >> However, the UML kernel is a normal userspace application itself and
> >> for this application to run, the host kernel must have the feature
> >> disabled.
> >>
> >> So, UML supports the feature. But it still *cannot* run on a host
> >> machine that has the feature enabled.
> >
> >Sigh ok. Apologies if I misunderstood.
> >
> >Is there any point having this for the 'guest' system? I mean security wise are
> >we concerned about sealing of system mappings?
>
> UML guests are used for testing. For example, it's the default target for KUnit's scripts. Having sealing working in the guest seems generally useful to me.
>

'Having sealing working' you mean system sealing? Because mseal works fine
(presumably in UML, not tried myself!)

System msealing lacks any test in this series (I did ask for them...), certainly
no kunit tests, so this seems a bit theoretical? Unless you're talking about the
theoretical interaction of kunit tests and VDSO sealing?

I mean can't we just introduce this at the time if we believe this'd be useful?

Adding stuff for entirely theoretical reasons is generally frowned upon and
isn't that the (at least one) definition of churn?

Can you give a really specific reason why this needs to be added?

For x86-64, arm64 the reason is obvious (albeit one can argue how much security
benefit msealing the VDSO truly gives).

For UML it just isn't, at all.

> >
> >I feel like having this here might just add confusion and churn if it's not
> >useful.
> >
> >If this is useless for UML guest, let's just drop this patch.
>
> But on the flip side, it's certainly not critical to have UML supported. I guess I just don't see a down side to keeping the patch.

Right, presumably you disagree that it might be confusing that to test mseal
_system_ sealing (not mseal itself) by enabling mseal system sealing in UML but
having to disable it in the host?

Because that seems really confusing to me (and why I explicitly cited it as a
reason I'm confused here, even the exchange above is confused).

If there benefit is basically theoretical/why not/nil, and the downside is
confusion + churn (albeit small churn), why not just wait until somebody writes
kunit tests?

If I saw a list of supported arches including UML, but also saw a note about it
not working in UML I'd definitely be confused.

Generally I'm not a fan of adding features mid-way through a series, the
revisions are meant to be refinements of the original, not an evolving thing.

So in general I'd prefer this to be added if + when we need it for something.

>
> -Kees
>
>
> --
> Kees Cook
