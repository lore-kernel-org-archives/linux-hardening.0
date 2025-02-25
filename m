Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4432256C77;
	Tue, 25 Feb 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464712; cv=fail; b=sxvyvPQjX/6SunFrRNUg0q8OJRSCC6u6XChSUBgaUIBCfYPKczePDdqzD/Z0kcBySu5vUZleWISvHzzG2j+DE2n7QSQDrhFdEsdUoiddSeg8uI9LjYLKmtMsUW2yxZhe3aJ0AVafYDo/tPslp31a0DmaRtez/9k940u9jhrqylA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464712; c=relaxed/simple;
	bh=JVjawY9aZCejlwFom3POnVhafUIkw285Vbm+Y9CUleQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajk86NbiYedOTTuPhPcggfljzXHNW3MJMBJngvAeV65TF9hEnMbSgy0Wc6xRTJ85P2jbpFLf+CjRgAatZwkW8jy916OB5KO17Ey7pTgwf9HHX4slnf9u7j4q89qF3bHY63JuOaJgZiFUHkI668EZ7kC3MDCSsihOLnicrQ9lVoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=klL13hu/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GbJRxdzZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="klL13hu/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GbJRxdzZ"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1Bh63030876;
	Tue, 25 Feb 2025 06:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Imj5l8BQhu2cXCQZ64
	glERtmq0Ba0vP+wPcV3vlEcdA=; b=klL13hu/h1ijw23sKignRvWCmgkkTyve2I
	rZFvir4TPIFiqBAJtQCNCmWyE4U9hOUpiEYhysVumKHg8g7DtTYXUqeHLSNcXTzl
	u6qEvYXIZsfuZ8Qd6Fi7fa8QQj7ObHls26kQOk2RAA/oUlUUCwbUI9NiLBIRF5VF
	MZZdakQrVaPCucD9iZJSCJqcnhyG3e8Khz/8NHue1Y++13fssjUQf3/W58v0muAP
	rjKO5EF+QYMHKwV52qFMR05PifewhPRAKRa3fnqAPb36w7TQMGIywYnMPtuExl/h
	9UTFuw5Q/uTV6Jy+V5kNO0RC6t6aMHms6aMSPEE77n8cWlG9bn+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t48y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:24:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P5FCBv025292;
	Tue, 25 Feb 2025 06:24:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51f8qg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:24:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAgXD8cojySyMPfUkBsUlO5XLCODOiEFz2z9zyg2mVIC4rwxdn1KtFct0vXHvIhg5m6wyH4gmZTLJDNgVGuTNR6XddzovHKQTgi/efpU3PxRPqXPSsMZ0/pGmLaNwXxmYYQwpQ53KAZZY9TENs2e9Iag38r1tNt0syT1sKTjQ1Nj0H6yCssx21reqfpjoz+AykWTaDMSWDaKkC/BoUrn1WhIyZFHxIjpwYwQb7RlWr64pBkwc9LJbcX3UJ0is/ub6wLSxHH3K9k7dAGw8uCWywPcRLNPb/fgTRk2sxAN+9anUVp4wD22zt92v2zQMHFs75Obuq/Ck99NqSnX4gPuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Imj5l8BQhu2cXCQZ64glERtmq0Ba0vP+wPcV3vlEcdA=;
 b=SL1VLjHd6mReRraW8oTVkkxNVDgeTjnNqQToDKuJuT80+8+psyBmoqJV5+9tEWpDsb9nYqHyRRL17cK+tL7JMKEeCTwRj/edyxfCM97ORPmEAdR7VKoyWow/qbI51Q+AURteiLV5xbwvcjFpQCLrETYU1dQEK35kv/CX8BhsGdhjjYxVYAksE1FNE5z4/GSxk+FkQzzxjA5qhFMD6RQ+w2RaBieGlvEb2WJZKYzs4XBC74UQYlN/AN5sT0bA4DPiEHNFqfib9KkQCs0fQco1+pMvYrVpfbx69mtIwhDTJuqW7DPQMGENbhfl54g+xvk3zn9eL1UalC6zGFjP85Bs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imj5l8BQhu2cXCQZ64glERtmq0Ba0vP+wPcV3vlEcdA=;
 b=GbJRxdzZXGnMKjhSN4ob8ayYCONDZbDktKclrqbm69BS+DVg9nvcukUT5lPUBYeXmxMwyAQ/fLnMMQxMMSf8Zcxn6nA0mGagRZLBrr/lpLE5WFLs4vphBkSPqmL4DRPX3tcXAcK14NHMmtjBjbfjDIN44CVlso1+45PzS5FlKYQ=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MW6PR10MB7686.namprd10.prod.outlook.com (2603:10b6:303:24a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:24:24 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:24:24 +0000
Date: Tue, 25 Feb 2025 06:24:22 +0000
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
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Message-ID: <55a9ff15-c72e-45cb-ab38-ad814011e27e@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-7-jeffxu@google.com>
X-ClientProxiedBy: LNXP123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::30) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MW6PR10MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 156e5aae-7b35-4f64-7913-08dd55650c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kSaIdhl+Oi10DjQN/qG4YnpC67KTJ3FJ441eh7CKDASLVUU+f4qpiSiy5hM6?=
 =?us-ascii?Q?m+ACRf+/g/Gyo9fuYD0Ud+vn0HMR4DlHoqOm1WALmCPLZID4T8S3m0pOVU2k?=
 =?us-ascii?Q?HFemkG+tLHfqCcOMpQQ5NdwbuOtsaA1JpjUvxb1Vzj9Fs7b1ynURRIf4YiEq?=
 =?us-ascii?Q?dumAm7ZAuUK4cgkOAziYJlMiIAeqixsSi14rixT+hJ4jSTsvTwG35nTO8R2q?=
 =?us-ascii?Q?2/k5ejErAf9e9sKtYOTwE6uXU6djyuRoEaHAXwoUzU0sOPdbXy+IvotQiBjB?=
 =?us-ascii?Q?/lY4674Q620JsUZor8hEkGQ52BJZQWH16jtCFV0LFs/Tfi8HIk2FQsr+9YYr?=
 =?us-ascii?Q?v6DI5iDhwVR0zflOArxBr98hcS6jPhErTfd1S5Mn7PeIAXUT1RbG/AyZgJX7?=
 =?us-ascii?Q?TEz3NqqaVZfoztz6JEyJaL7U3J0Mp+qnXmt6EbyNR4RByHNp48ZV4SJZnOuJ?=
 =?us-ascii?Q?PuXsUG2OqBlhHr5AYrZTB/9vg4ri0ppNNmP2PXBck4saAbGMGyXtUheWOYst?=
 =?us-ascii?Q?5e2OHG1DuNlVbCQe80Nw4GXXRrSSsaqQu//ThaICnnUMbqB19b7yf2I2p3Ck?=
 =?us-ascii?Q?8BunxgUIrxvEnmJ5yXUQ2sEdMKJAdg3556Q/v7s8Gghop0FdWIhOzvbppfTL?=
 =?us-ascii?Q?s86X7vz7im6UZwrQWBTd1PPTj6jwDsg3YTYyiXqUGaJ/Y1W2OTg7nmKT2vjB?=
 =?us-ascii?Q?egRi37Mcg+2UV3z2jtPr5ppcy8YsCrqU+vVPT3iqN9xUx/VqF+D24jDGZWbB?=
 =?us-ascii?Q?RsHaj55J7+L+5cLyz6ipUJzNHvZC6yc2NYi4EVVkiPey6j3nZlfA7Y67uDWW?=
 =?us-ascii?Q?3Jn7EL/wwbs4fj4A22iaaGYmARYQVJz1thZ0OXdTznrCkZ9pLs1mVe1q8nyq?=
 =?us-ascii?Q?2Sii2yyUaAJkckvqJasr3rf3NV1M2ecHNEqzkiekUcNB5xioIxAMu7dkAvH5?=
 =?us-ascii?Q?dY85w11qZKbSfoximlzAetNc0vlGfnf4KR25latMGfB8pQP87+SiK45YbUMr?=
 =?us-ascii?Q?NvPR2FuOlkXZSoGsACwdhvdMzPDn1v702Fztjpw1s8poIByWACQcyXIUrZ8t?=
 =?us-ascii?Q?MGkf++parJH025Rz1LTdXG0L1ezstANBKFDEDY8xGBmfcX5EIV0XWs+d/bB8?=
 =?us-ascii?Q?3u1WCI62heKXiWC/gN31zpEtNQOa44Nneg69Ipf1vu5+Sq7JEVTHN4xiahHh?=
 =?us-ascii?Q?xbVON1VJFNtAqnrGp6c8mjNEmDx2JLGlvlA+oICn4Xvql2oYCuJs6PBqKuEg?=
 =?us-ascii?Q?NnoaQWsr6E/ObOE2AIAxyvRJ47Y40W5pKnhqnNe8pV3d4JfNfSDROF/Dp+cq?=
 =?us-ascii?Q?84pASfExXXj4Ax54Qh8in58PFh0F0yLp/ps0tVT4hK0D1ABmHuXVn24dGT8K?=
 =?us-ascii?Q?Va/GLlF4nU5V2c41pfJjgk9tQOCC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?70/qTRJg93QvsPvz3hFcTnl/Q0R2PNTfGwJZQEpDCLI9ZHnWQEpUvseK7Y+w?=
 =?us-ascii?Q?RD3HvMKtu6iBktmfDvn/xSew/+eIZy5GK9ZDRy3r3dHX3VfcZz4KWtzziFOb?=
 =?us-ascii?Q?aiFeh+7SLF0HVhEqxJq34tMTb7a4SOM8ZyvMrIF5/owTuLg/iNB2TNw2WZHJ?=
 =?us-ascii?Q?vPHy7eWsdF+SDmLXx02f4zg+ZTEpeKXiYsqdoC7p+k9g+T1z1ddJfWP2n9yW?=
 =?us-ascii?Q?VEUR4CCFvZZfPTn5mh3Cukaj945IpyfaP5Fbe68HQNYdo+CKI9MsJIj6Jch/?=
 =?us-ascii?Q?bwITEMstfKAf2nA1RXctCX6SIkYmY6r8ah0/GsfTbQi+ZEVGnCPTZor4w0v1?=
 =?us-ascii?Q?L19NqJSeFdC83/8acwQQtWwvLoL++cRBaN0JaGssI7dsepAtZCnUJ7M+g+m4?=
 =?us-ascii?Q?J2G3+ZpFz+NpRR5iAPuTBh8wiZtUOgnDSpaW8sSBEn+yd9OlS42yK/aCMPXR?=
 =?us-ascii?Q?Vry0ikEVqp/hGWZK2soj8OtPCm465yYgz3AOsIz8z/Nb0XnRc8qw2rYrEHnz?=
 =?us-ascii?Q?UsZshtkTUjZ5bsNInZU3OCu3plI0gCxUaMppnpiP1aCrOvo+NPcxZvNrK8H4?=
 =?us-ascii?Q?8MihMNgmETX9L/m5zcrW+2tp53jV+s4dagAm2VOpQhPDMNlzZ7imW5vdvU06?=
 =?us-ascii?Q?qQVqecaWsRWYLlkONFh18RJUZQvNF3oD5h4W+ZASFj7HgaGz6mUj4u93HVGs?=
 =?us-ascii?Q?CZcV8g0mzKSq+XtDSZuIppCbhDSY4q5Ia+f4bBsZeSf5pJMvkMMqDpB8bvlz?=
 =?us-ascii?Q?NI7oN2mmAg+MZjwnFeQTXupeEgkc7A67oqfTJXYprJQrf6BcqFE3CW8OgBu/?=
 =?us-ascii?Q?rapfXRC0Z5Ph2Vu5/aK1C43/1oEJMowKOAShN5g9PEEqyFTTc5TEYqgyfSWe?=
 =?us-ascii?Q?hNrQJXfw6t/fWL4OTnCaTEL5RH4BvlxtEpg3rY1KkyrHDZ4KD0c+sOsec7US?=
 =?us-ascii?Q?pNv6pSDPOdRB1Yxv+sJctWceXnJFaRqLa7khayLHTfcOE+Psd5yMjI6Mnil2?=
 =?us-ascii?Q?7uyFznr0XwOSUnFe309niBKXIxcBjJ3C5uz6rtXCNe4WN9FmZRZgkQpDYj4L?=
 =?us-ascii?Q?vER3h4bjELKg8bPTqsQPOnS0eQsr17RDbhpMni20hEx6SVfBGRfg0m0/tnke?=
 =?us-ascii?Q?bjkL6Yh7yBV6lJ3dgLR8NABVbQWYT9NW5rvLYnFyOPXvMGcKJwF618Y/J22n?=
 =?us-ascii?Q?eL+ICUjQTm5NzCn32ldEY4tee3ymgwZIsoFPdXg6kVuTgRVc9fQJEYkIgB9Z?=
 =?us-ascii?Q?1OX/5CbE8U853IYAx2XHVIUt+Gx9DrdjP6NXnft0ALZucG3mCbXX2LFWb4zT?=
 =?us-ascii?Q?4lLjzjKNTfQEFlrDrtj/MUF1rfBfZwKYvtrSHJBwwRZJGK+ngr5Fmkx1IEyl?=
 =?us-ascii?Q?9Lot0MNtq106o/UYW4Kxrkle534HaQ7tq0m5MLNFQZYbQaZyHxkxM4oFDwdg?=
 =?us-ascii?Q?jiKd6N/Ep9DQmlIHCvc3JwWtMKwQDxNisRGq80QtckLoA0Joboandvcob8zy?=
 =?us-ascii?Q?QBGsJicifZuOfvKH7+2GlLINWI7TgCWRf9Q69CIYussvoAsGXP7g+aYASIPS?=
 =?us-ascii?Q?9bMoIYpWyQujlzNLxo+uYNcUbGf7c96rl/IZ6qzhYHwAClZo9LLrJ6TC2Czv?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7vfgrPholfv5ria0MiABKhcbNWTCT5ksh8oSmhHF41muGRetbmDgzeuchtllcHtTVishEraFbAyTczShlUmH9BFdhpxJPzDpSnh+VCo6lsj7JUy2EUs6nRMoSH1fVWk0kErXAsfzmYKOh2p2IPyP0Lrx4Ox4tvS8CLNbd5wjAoizYLdwC2zBUR1goaZBEPtpJgGvrvua+PvyNs0odKGu9EQUIZ4em5pl6eJLwxb8DiX4ULyxtCav/N2wGAqhXlO+oyXWu0dkDX2W8khLxmaU+hlMpPF4PeU68cXDvv97v5tVkwPYfQOBEFghPW6Ijbk3zDx3XX7BNiKVgfOoZvplfy8zQgJcTD0eSaeoRScUkYOUXM9pldqfwTc/cLzeVMvEAHeiDS5zFXHWxQdEZbKQYnguyo4UDWsS1ni1E51dxSyVnifZTjGESBK0vwvHrD9q0ERgmOE1YKIGU+sTxsx3DhRFZt7zdKIgRIdar0bCmbSRH2ja4XdH1gk1NnL21IG76Bp8dNUm+LmtWCiFam6WQ7dCp/bba7pviIV0j7+8E3RfbedA71u/eOPP6BPlCYk5Y14U2bve0VzjBeJuyk/Nk8xwhs+1OQzNiOIShMTO74o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156e5aae-7b35-4f64-7913-08dd55650c25
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:24:24.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmtQRbBvXfpKy09anPH0kXWOlnM4G2pXOtRvfcWFXJbqEe9F8varb283ccJpf5jm0QjwrKz7vJRQzbBtzNvrafSdAWXq+JnOpK8s5ezgnMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250040
X-Proofpoint-GUID: VRcjIQZUvZ4QMAX0FGPVYwkw4aQrPpD6
X-Proofpoint-ORIG-GUID: VRcjIQZUvZ4QMAX0FGPVYwkw4aQrPpD6

On Mon, Feb 24, 2025 at 10:52:45PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Provide support to mseal the uprobe mapping.
>
> Unlike other system mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime. It could be sealed from creation.
>

I thought we agreed not to enable this for uprobes for now? What testing
have you done to ensure this is functional?

I mean is this literally _all_ uprobe mappings now being sealed?

I'd really like some more assurances on this one. And what are you
mitigating by sealing these? I get VDSO (kinda) but uprobes?

You really need to provide more justification here.

> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  kernel/events/uprobes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2ca797cbe465..8dcdfa0d306b 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1662,6 +1662,7 @@ static const struct vm_special_mapping xol_mapping = {
>  static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  {
>  	struct vm_area_struct *vma;
> +	unsigned long vm_flags;
>  	int ret;
>
>  	if (mmap_write_lock_killable(mm))
> @@ -1682,8 +1683,10 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  		}
>  	}
>
> +	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
> +	vm_flags |= VM_SEALED_SYSMAP;
>  	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> +				vm_flags,
>  				&xol_mapping);
>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
> --
> 2.48.1.658.g4767266eb4-goog
>
