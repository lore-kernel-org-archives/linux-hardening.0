Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6E1FDE18;
	Tue, 25 Feb 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479638; cv=fail; b=b6CTPBNpjSLAXO2HbMa3oNcQ+xfPdWqcymOEMtAFssaFq/5bGVG2ThEkBF6RFpGRC2ZzzW1bZO1IShy6sDwSkZzyFpUhhXcpQvvjuLpVrkDVIeVEXuty+iW7yB55zfAS06FmLhCv5CUee83ja+udyYiIiwli9IlKrvb5cA2lZPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479638; c=relaxed/simple;
	bh=rVHVgyqP0d37Pcl4YL4Wliwot5zHzdzyOqDCgz5du4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fl5T2qH2Uncvm9AJVThEXEbXMu70U0uLjP+iQvbzKnkh2ypUZLgk4hNWowIcKCPNoHuIUSMfwphOSb3T9iFIiZF3W+bN0cJytIJ36NKlDf230hBmR653ssttOjzMi0B//mNBrR1kLvyqUTAdBeGgG5dGUaUxcBu4kSZ81UgCi50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sp5KWjtl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DcxPuDOO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sp5KWjtl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DcxPuDOO"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PABb0D000488;
	Tue, 25 Feb 2025 10:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=rVHVgyqP0d37Pcl4YL
	4Wliwot5zHzdzyOqDCgz5du4E=; b=Sp5KWjtln9ca9MyaI+jN3MoQRRu1lo2hty
	N9hXh/mc/od26Ey1ye7a7Ps4BfqT55Xor8T4sIn85gwkFdEy4Q+UXqM14QKf7kJk
	dMm/wdiejVBLw6ywbJfDDRNN9oI1b5rfpJUgACNaqMlrAdOoKL2ytynWIfl0g+Ih
	YokmGqMF4tyoG3cC+43sH3jitk9ZpdmlKQjSAWGUhaJLshMuJp4AfaNUGpRKcZ8D
	l3dQyqcZJeiWQG9idWb2VzRfeZrj9pzaMdSnZTkyNlOWGjF+c18bfaC0tqkR1606
	l7QxGUFYWpl2NRaufesFlAnX6dy7ZH3a78bEcg3YLSblcUgvsiCg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t4sbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:32:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8lLvD002759;
	Tue, 25 Feb 2025 10:32:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5196uev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1Ooo4O4tvh3Dh7YHY0D/STjowuTZFzCEwRlVMl41waptpVeQ9/aUQ4H5r84KwrXOJOjPKraV1xy/2Ejf8UrV1UhWMCztFVG7YlhUnOwzCvdznC6rUOpCcUHfpL9Yt/i81zp6WywdyNEvNVspNmE2x5F2c+Z5eJPG4SsZsQnQTQPK4GYef11KxNEVpS7cR7aWuE/iyO+lbziTy4eeAJ4JG31X6pwWLsud5b59n5Ac3mMfVpbE48NuLWe+X2uxX/f9Jc+nAREgKsZcXlibvtCNz+jU0NOwZ3+fLmZcti8eJ5ppsxGuWi1lGI4GCZ+McbMQ6tLCaP3v7VMXrrInTDCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVHVgyqP0d37Pcl4YL4Wliwot5zHzdzyOqDCgz5du4E=;
 b=I5LaQvk+QPF7apo18aLxn2aj5Ax2IPZCofxlrX3nZBu858cfpDIOsGmk/zCNHK0V3p6+Eq23kBoDKPEUAGhIkQjbFB5HnDmnMAVhanGZCzQzaPI/zK7HaS0WDvFO6nH0n31DtGz7Rielakpw1ujCT4scml8mFMv7A8/PCzN6jCK1A1KclH7ce0w5SSEHpDWaOtmxvokHNSIeyy+ev/mNCQEcHK9ZsFfndxrwvQMMkTQSvck1fk5H1FnAS+Yeb2TYAybAbpcipBCXUAnN7s0h3N/LaOFpFyX2WtGGe+RkS4e4V0ojzg8CuVGR3RL9i+qH0fGgVrkUVjYjBWMsTuWICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVHVgyqP0d37Pcl4YL4Wliwot5zHzdzyOqDCgz5du4E=;
 b=DcxPuDOOXofnWt+ioTtqV8pOBWOFCKLfswm3yG+aJQJ+WVWYFX0zePTlj6wj5mIKIJjzsKW7DiLkwg8Iok5g8z7dC9RnWl4D/ZZtM6jCYkT45PkwOtBh48b2godpUOUUbxYgOXDHQsqMYbY+CMp9cGdaTuwdQ/zHKNBFSfM2smc=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ1PR10MB5907.namprd10.prod.outlook.com (2603:10b6:a03:48a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 10:32:36 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 10:32:36 +0000
Date: Tue, 25 Feb 2025 10:32:34 +0000
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
Subject: Re: [PATCH v7 0/7]  mseal system mappings
Message-ID: <30b4de93-70e8-4384-ae56-9f6b6cf0f347@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
X-ClientProxiedBy: LO4P265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::9) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ1PR10MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d29fb8-a235-4ebe-2a62-08dd5587b8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1BtM52IVdV22jKuDrqrtxEw3ambBWCrbxihKPeNRD29mYAFpKeSWMg0BQyrP?=
 =?us-ascii?Q?iul0ww+4jWQRgS6QI5B0GPfNjx5+InC2QmVskD1AtyhcEXUDyyLYzJyh22MN?=
 =?us-ascii?Q?3SaFZ288XVqUZJMiD7JshMcu4aFwZ7aBIunRJaZ1R0LEnpPyeATG/zECvaKm?=
 =?us-ascii?Q?otXzwvK2BD3HqC9OyTpXsL0/d89ys5L2dBEZhxS4jieah42/GCCD7VtXFVPi?=
 =?us-ascii?Q?I3W999/SBv1o0XLAtIrBsG5VP4g3XTHvbLpRT6YzpoTcORQkwl+p6fTdQtgj?=
 =?us-ascii?Q?kNqdLvGt3WoMYx6xHx9LpR8okroE00PzHImDEhzijEuRM5gzMbNC8toxAFkE?=
 =?us-ascii?Q?N5K9ik55Ic9gWnPqZHrVd66Yb+VtZCiDP46G+0VbvoCMZBp/T/Ii3ElifZjF?=
 =?us-ascii?Q?uhUbTKTpBjNGGFwh0/pVYBTd42ro+kadz9Dr9KA1UIuaNI2oU5wNEuk50aIi?=
 =?us-ascii?Q?kRgl7EX2ZG/BWiSkUHh9pP5EWN9mLbXttse6PAwM1CK8C1qcFYhXKrYekMvX?=
 =?us-ascii?Q?BW6JWciOCQ0ot18utkVl9AykMeqDtmIcil5dB6p67FoMINdYA6LDTWxiC50H?=
 =?us-ascii?Q?/UcfUAJ96MFKhnPD+L8D0a/+3rQk0zzQLuPJExhmP85OcZbUL4ioWc0VzLji?=
 =?us-ascii?Q?1cJPnUicKDD26p8zcRHWRyOkv8ScI9hoQMEWwCYvVkWCyuZgFgg9SEEoCVuj?=
 =?us-ascii?Q?gZuFSQdp4/A8+bK9XwP9nAEPgVR+HgU1JbIMK++d9P0i6ntpukHr0ITfC3px?=
 =?us-ascii?Q?alfeqPQpKfJw/p2ujs3Q7IKxWFANuCDLCkbDPisC6HcT3P70Bb04aYrFLzuQ?=
 =?us-ascii?Q?KsMI0XwD3PB52gN1RYRjJ75vmkZ/Fm10oNHYCnmz/MF1XVHfAUm64JMrA9QM?=
 =?us-ascii?Q?tg4LjlbD3wu8Neq6B+lrsRh8CUc2G2E3bnVDvPcF3WmcZ8eErRyM7hnvYKOo?=
 =?us-ascii?Q?HOSVXcIX1znDk6OKvjcBo0Zn/yIcKv63yf/UIql0SRnv+rb/H22wUKVM9nOR?=
 =?us-ascii?Q?CaH+SfEH5o6rjoK1xfEKEBrbBI724i/Fv8/bTbCuoWiUbYc5USNqaGU+cyza?=
 =?us-ascii?Q?g2AwRhBvDPCfnX1nQ+/CIqLs+U3NtgAYT841RqfLIp+D5wcKX+kc6AR9I8Jn?=
 =?us-ascii?Q?WLtgvz4NYJmDWLSPuoeB9JbUt8BSGCzGdn/h8FI6wqUMgnXtS5qjoAf0Gc8d?=
 =?us-ascii?Q?4HYFMIsJaNUKAxhNgjF7udpXyqO46MXpW95OjbzZujXTHsiZmo1X+9r+oyZE?=
 =?us-ascii?Q?xajbeiNmt+p69QbJ5n/NOD96OZ2Z7b+pfyW3QPJpCpPebkPOcGbm2GHHCTAM?=
 =?us-ascii?Q?MwAZVvFtt4aMgas9ytQy20Qy8GXvhKFjojJyEFYXHVYxYEWoWMAtMq6R9N32?=
 =?us-ascii?Q?s88dWWksNLmSNNhzXEXU7ymZuy4C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9g3Hj8vJfqWFt1BwV2Aaj+RRsPK2jodNMRHUDTDv9PmhyKccuOq9yGi+94Gl?=
 =?us-ascii?Q?yQlJlRuaPZkydxajYMY4FgBEX3tS+6gYppe0UIBY1DvSg/+z+3E7LOQYoAG2?=
 =?us-ascii?Q?Lb3exj7q5YSKQHKxf3PkWbuCq9YCwDJZz/tQtpMBaqwVHrhLG+V5SSPrDz0J?=
 =?us-ascii?Q?rTleDKfejM2j8o6iQtLlJY0q0d1IC9FF94yyXvwR6I5BA5hS0X+arRB2TuPw?=
 =?us-ascii?Q?5D354bSUBE//Z9daCF3+4mjCS3yH0M2kcLv5Rw5te1V8HGXgdA3tRd2DI0a+?=
 =?us-ascii?Q?SHOVXaGdLkRAaUUKsspdgDM12/WmENUoVvEUD2HL+Lz1aHbPgbRlcoCbPCge?=
 =?us-ascii?Q?ljVV3Ki2uhZDRUzEdAaTW44l0wFGx5ProHBjf9hQHwk+M7JARpG8ZLa3nWI2?=
 =?us-ascii?Q?LvLYi5bUwIHiWXc07QB5zd0H+ozz5cb8PlgUYpMY/sk0EXgcbKLOj1Ga1edn?=
 =?us-ascii?Q?EDs9dkdN4sS2AbFnD8pMzdh79m5nvFe3Cn0ZOGKZ5xoF6ZpXhNUTi53r0Fl7?=
 =?us-ascii?Q?6fWp+kR0Zp3wS0RBGsafcSG+7qTDYY+QUUoFsGCxtgIA6eI7yVUJiWV3j5UE?=
 =?us-ascii?Q?g3uYf70QUFt9hMFsU5fDZ97HiGv+70GZFyLQwwTXIdJ3hdhY3a2peUOksgyT?=
 =?us-ascii?Q?823eD3yeV1JNMBjj4k6Yw2S4xhhhd2jOp1mWKpNH6BnD00rg6m/wPJIyfXkL?=
 =?us-ascii?Q?ixb+RkoGI0f3UTVv3F07s7s7Nb/58cILQE+KzXp39Kz7Q9cMlctdPO7l0nP8?=
 =?us-ascii?Q?NXqu9++YIb8dzbIFpHz4N9VrlLEe8aQwXUI/r8YbYysCsfgm1Wv99HqGmq6U?=
 =?us-ascii?Q?K3YlHDhXYepEO0rYJJYAKayKl2bvYrcK0LR/6Ck+k5YFbAqa5pRTZ+ZFsaIr?=
 =?us-ascii?Q?RErbqzMMUisoRh8z8VAYA6pYHOcIjQ4wgI2nmggWwq6uGUJYY7A29tleyOoO?=
 =?us-ascii?Q?8knawBcGof7MfBLrM3elt3tXwjsFYwsHXurS+WByt5w98/nTZBiY5eJb1kHw?=
 =?us-ascii?Q?fHkPxwNs+PIPqYnRLzeop4Lv5Y6ePRWbCkfyuYRg15VvcLXY48m403Y7lmSp?=
 =?us-ascii?Q?2d+gpDtpdqc0Iu6M5uVogJBG+sUGHFI+JGNVdaNhBZ+6k7mkxEXBAkJuxOZW?=
 =?us-ascii?Q?ozcrkKFBJJkO3BtVyjsAX7WKQfe+x92Q7xYzi4s36w7dadrHhzFRL9EZ30DP?=
 =?us-ascii?Q?DT+9rFK5+RMcGsAKZOvqu2PdaKRJruSvBOr0lo4fcmoDa8700Oc4yqK6q2PI?=
 =?us-ascii?Q?VvpbzSZ7NXTyFb4LDWpcf8qJcUm14Hi/paGCGcn2bciOADu/p1ZZFiCdRVn9?=
 =?us-ascii?Q?QrTZch2ey1sjoEC2pZ23/Z4LqJyRf7sFGWE5WXtaBaMycBULYYGIkAMLvW7f?=
 =?us-ascii?Q?XKa7WKzt/9iGXIRdOF/5es97z1z6WbMCWeOkUI1Juh7SpIrvXTQkzFJedNeg?=
 =?us-ascii?Q?Pp8h4Zj/SiP+oDgKC8PXSS/uLaGl97G8QtSDCD4ugwB2LjTHNU6pG03fAVRi?=
 =?us-ascii?Q?mLrG/fHWyiA0yGF4kwUMeob/Xf5EDF/+UGLh1X7M34VpiiHFRxlXbnNVQqN2?=
 =?us-ascii?Q?CNsqNWMT3l9ikeRGA+tZDfj25GOAzuEwaEpmq4NAaGhDoQWftfV5Aqp62n2A?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wFxipzTy3l8pyLkKMtB6EI4SS6jHHJqnNXinN85ob1MJNIYcGr/G3eenkaWITU9vw34n60mElz356AEn4Lczx/64K5Q5KdF42anr6ttmQxpI6zRl9CGfiNYKHHvX6kZjcOcrBQFLyKp7hUPH1+FLsmJuRDumCIpegCNn07jmnCSVlGN2ISSEZMdhCTJeoNmcxCAYCtuQG5lBka7AB4n//P0tjsoBd7ysM+34zZulPGFW9ukjE102c2REorLPLjP8wQ6wXqUnlcbeYpVexBj/YhLu4tVUtiOqQYsYy035m5TnYW21KSX2fetnMnu+9hsvLDwFy72m0vUY4WeFWNsaAK82VWO5icKd6TPA1ibLRHGy4aVLOfkZgTyPYRfu3AVRsMNhbdFc4UXZHnGJN4qINS/WzAuZV34lPFaik4UsZHUDz0r6lHMxGYfARf8GM2sKOSEOJJxfpWU2cWC/lANlL2frs175Oz3xV9M447JJvW9d6vEQiLj3ff/6hHwrkEwLR6bJ3Cy+UO3tVKhII5gtJL5FKyhSF1vp9KewQDxLLQU1TNcfYGlhdvL5EQWD8TbOeSmqvTzNUl/yudYjnlHfk8DzoffnDcYEmpELW14QfV0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d29fb8-a235-4ebe-2a62-08dd5587b8b5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:32:36.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCB+tsm0oKTo6GBcJRXeCcnTIn4Z/p5HBe2Pjv7ZfsuKU31a+CaUFhDPYv6BVOa3YbhQg7kfqwr/QIpMwPeuKdeJdQitxlDLAPau7UPxLAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=749 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250073
X-Proofpoint-GUID: dsGt-qw11nZNg5XNlnHPezD_aPWyYV5i
X-Proofpoint-ORIG-GUID: dsGt-qw11nZNg5XNlnHPezD_aPWyYV5i

BTW can we please drop the 'mseal, system mappings' prefixes on this
series, it's really weird and makes it really hard for me to actually read
the individual summary lines for each commit. 'mseal:' will do.

I mean really you could argue it's 'mm: mseal: ...' but I'm not quite
_that_ pedantic :)
