Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600B7DA73;
	Wed, 26 Feb 2025 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549567; cv=fail; b=pomuiabhn74Kv56hzs42KcvdSis0g2NqkF/A6XOSOMa2sZ6xYsQaLcFVrMLBaXF7FUdwdgBC/zvo/iEMnLErM6flyFTINtH7qfIL5Anc7MaTysOlVgSm8vroyb6Fp2uD3l2TimKmlyQ4BjtFLjm+0tQft0bdz483XASP0GRag+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549567; c=relaxed/simple;
	bh=bq3txARS16/8SR5KDc1aL40FXFyxSf/nIrV3xnRpQuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RV1yRliZIB0L9o2AYTrcfGwQLWke4ImCmLnqh9OXsjeodQOG5ouw+gWjgGwMyeiEUdW4aRTP/5xOsx7s0k/YeBgkKa20pveOPO8NrybN6PmZ4o8V+K0t4qRegUnVC9E2In4R85E/Uac/KT3zC+yDoZaYhtvsyROJGatiD/cSsu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hGFBXmR8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iX4o8qlN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hGFBXmR8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iX4o8qlN"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5XavR022132;
	Wed, 26 Feb 2025 05:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mVJoak4PDiFHx3o3hkGc39EzT8wl8s0fk6SQTRcL5T8=; b=
	hGFBXmR8Hibn6ph66akX9pqlBaeoyZjEcJm5QmBFxXesHem8Z/MeP6YREJ2xcypf
	Wkd3ztOk0M0W6HFOZTzegY2pXN9Gj+f22muhvhGI9+WywQW4+wKBEeHEsBciEOsN
	TjhSVp/JAZLjoTWP0QEycGuYwpOEZmu2AHJTjfeRrxztVpbBHbjlNLOf0jg2xToM
	e2aYtGahS/a8zR2RGdgyUEjFq28kzlZhGvNWieWKko8X8EsTqFsp07ECEXKvKAMU
	IYDl3tMJoan4HQOqhn3XckBs2iWMbthI0mL7VQyyWEn7YtGZuqnhR83mauYFysNI
	gDqtL0DQjJ6f9EE5ECsYKQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse0eem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:58:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q58Qrp010256;
	Wed, 26 Feb 2025 05:58:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y519xt9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPHCI/YHep5dT8fAI+J5rBEtKAoLtONWm/z+M/ThKf81lWuTSGsoQ//5CMjiLdvUrvJ5+v6iEWflR+p3gqreEy/1ZzPqdH8UhR6JIMt2VRT8QDhBjltXDfdR7z+Wv1O34bFRRH7KxF0bFwc1oJ1/wky+jXeYIxfraMaWr2wAoBdkSj2F7bGCFHPM7Z8GzCCRhe4DNtGxsyo9etRGOA9wY1/1Xb2E/Ym4HnjvOrCyTslWk48kMFU7Sr/kOIDoI45zDmr4XEF+vopOTC3qtyOxfj1qgNQR1de7CaHduUyePEQmwIwQZTC0AzhV13G8xYW9egeyFVPU0IRX2DHjDPlNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVJoak4PDiFHx3o3hkGc39EzT8wl8s0fk6SQTRcL5T8=;
 b=QOv+zdWrhJAtDk4OUUAOTTa4ASZdLaEG8EfvQP6sZdtywFWm/a1V/CxdnZ+ZGr6Zrv1cI9Dns05NapQshk3ylMXV0N+htHNX158/mPtfufVgSSe/OVwTbLS4ZaF3Vm7Cc579sa3w/5iYGNyEaXEygOKx39WmcGj92torQqsDcA2uAylnNBCfE0S/W38ybIsHV3Fe0Ujn2IiciLiu9h+79HbAWe569QXc+NMUq+iDr/RN1WcqyYpuUH1w5XoqU0944RKrKVlagIWXrziaROuYFL52nCZPLQJGGog8JsEA75+j8ENHz2HTySdbtkMt6LCy9531tuLZIxAgMM/cSGLflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVJoak4PDiFHx3o3hkGc39EzT8wl8s0fk6SQTRcL5T8=;
 b=iX4o8qlNnyk5KYZl/5s22unf91dpQw98brYwe4Gwb6VvPl+twwriS32iRtE31sX0TGKsKeypVa0sWt7BGSG5ORCg9AOi0gR9bjrouh5ntoEeeqC+//FMVnBqKuyaGFRQmI9TB0FNgnlUVr8Uvmpq6GqZ9G047Xns54g0r6aGED4=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by LV3PR10MB7914.namprd10.prod.outlook.com (2603:10b6:408:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 05:58:25 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:58:25 +0000
Date: Wed, 26 Feb 2025 05:58:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
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
        mike.rapoport@gmail.com, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v7 2/7] selftests: x86: test_mremap_vdso: skip if vdso is
 msealed
Message-ID: <f09fa8de-468b-40bb-aee3-a33ba0678dcd@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-3-jeffxu@google.com>
 <f300404f-91a9-40ae-8fcc-2e855b43ac76@lucifer.local>
 <CABi2SkWXvc0p5u+AwFEHXVM00nX=n3ROKwEp8RaYWEZ-3-n5sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkWXvc0p5u+AwFEHXVM00nX=n3ROKwEp8RaYWEZ-3-n5sw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0628.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::6) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|LV3PR10MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: f212f8e3-d932-463b-5714-08dd562a956c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dCtsSlo4eVNwRis0Z2p4UEVFNDFSR1dMZjk1dlh3ZzIwZGVGbVM2cjRUM0ZZ?=
 =?utf-8?B?Ti9MZUIyTnNieGxBNVNlQUZtZGkzWnlyZTFNUVpzSEplYUFxKzZtSWZpZ0t2?=
 =?utf-8?B?U3hod3g3VHVRa29BajhSUXlTU1BvcTU1YUUyY0x5TXdLWVZ4RjhVVjRnbVNv?=
 =?utf-8?B?anJmREY3U3RDUFZWZHJ5cFlrcmZWWUkyNFFEbmVqWTlxZDBSQ3VFTk9lTGtX?=
 =?utf-8?B?TmFqZE03OE5QQzBJc0s2djd6SzVwS1pIdDhXY3lzM1R1VytZZXl6d0dCTklU?=
 =?utf-8?B?eWpkQVNhMzhYQmpiRllEcUlNRFc2SHk0NElmMHhpWTdzUElmdkd5RERJamJm?=
 =?utf-8?B?SExvSjI0WDRtVUg0Ty9KUXZhaE5zOGt3QTk5ODh6TlFBUHVwZWwzK1RWbGQr?=
 =?utf-8?B?QVBMcWZmVWwrY1hjVDN1bVgrcytVQzdYL1FyZXI3aUZQRWJ6SjFNSFVmZVhD?=
 =?utf-8?B?cU56NXdUVUtYUDAyY0NlV0tBbUdNcW93SlNQeGZRcGpabFVTMUdSSG9QVWhN?=
 =?utf-8?B?V3NOZGVrRHE2dVh5QmVqSDBUWFAxQk1EVVdJeklEYTNWS3lJeWNCL0RVeWVp?=
 =?utf-8?B?L2tLODl5d2lwTGR0VE9HN3g5MFpZVVhhUEJXS2FsbnNwbzZzbFkvS0JaVjEx?=
 =?utf-8?B?VzRHTEVvajlPeExJdFV3dW1oYWVWU0JneDU5dGhQeEpzdFVCSENSdElxZWF4?=
 =?utf-8?B?dmZPbjlDaTNCWTBNR1o4a3ZFYUpiTTAvUkR5anFUS2lJNkM4VzUxeGg1QStJ?=
 =?utf-8?B?OGZycmhJcGlZRzNVRFJPVFRqcVhINFNvS1JRWGFKQVhnS3hoM0gxSkE3akpk?=
 =?utf-8?B?TWJOL2p0SGs4SmltckJyMlFMRGxlZStlSzI4M0hMdHkxRTVpVEJLM091MDk3?=
 =?utf-8?B?d1lYUzdxVXFQOSsyZTdpdFpMQ0huY3dQVkQvejY5TW44WElib3dPR2NxeGJp?=
 =?utf-8?B?SW5TTk5NRmFVdmYySzBaT3R0OEVXQ2d1UUFweENlZnJ3RFViSjk2Y1VPa0J3?=
 =?utf-8?B?M0hPdnJrNnFyV3hGRFRNbEliYVg1L1pGSmR1Sy9rS21iNGdGd3NZdEFhZFJO?=
 =?utf-8?B?K2ZGM0RmREFNZHZLZ3JUTURKV1Zic1BzaVNWVU8wLzZrcWNRYzQ5dFJZLzk2?=
 =?utf-8?B?Q2xIRGFtZFJmZzRrcm5HTndXNE5jdytkRVBGWUFCNHhTQzlldWJGSXdWWmZp?=
 =?utf-8?B?Y2RhUGw0VnpoclZ4ZEduUXAyVm8ySmk0UHJLbDFyOGRDVFpDQS8rZnpuSjhm?=
 =?utf-8?B?bFlFek9kZ3UvYWFmaTdzMDNLTk1lRXNzVkx4ejBGZ2tMRlBnZkFmajI3eXVw?=
 =?utf-8?B?WFkyeHA0akpRSG53Q0hsa1Z6RnhScldIUTJHSnR1TnR4N2h4VTBhUjdpYUJ4?=
 =?utf-8?B?N3cxd3hqcVcrYjRldWQyYTlVVE1jZnVRSTd3OEkweU5LRlh3Nm5EYWRZMHYr?=
 =?utf-8?B?Z0gwNWpOMnV4a2FtQ2N5U2pXanFsbFJyUjJGTk9nNitRNUE0c0Vib0NBQ3Zm?=
 =?utf-8?B?KzNsYmtRb0JRV21UWFIyWjJvQ1JNbDJmMS93cm05YXJhcnpDelFaZVJsUUty?=
 =?utf-8?B?aUFpMTdROTA1aytScXVxMlJ4aEJObFcwZVVvMUs1Wm1ZWlJpbjBOWnpBZzdO?=
 =?utf-8?B?QVVBbkQ5OC9UWnhpUU5kNFZheTIwYUdvc3VmcUNCWUpKRzNFSlJPWTMrMlRk?=
 =?utf-8?B?U2RXYURNVG9aYTRGU3dvdVJESlBwbDBjc1hTcno4dENReW5ycG95aGlSamtE?=
 =?utf-8?B?RWdBdGFRVGRFYkhNS0hHcE50U0hjUFh3RUNFbm9sdVo0ckVmbTA4T2FUWlJk?=
 =?utf-8?B?d1NTektFRmt0cWtEVndwbXlNYURHcmJmdzhGUlJKemJFZUlsZ3FPRFovOHdO?=
 =?utf-8?Q?W0AXJ/IF7Yq9E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0ZaSGpXZmZHY2hHb1dKL2F5OWxiVWQ4UUdOcnF3UXpKTWZWeGg2YkZ2M3Zt?=
 =?utf-8?B?YVBEQS9KMGRXTnlGNTc3bjlHL2FDVDZIVU9JbmpEMDV4cFFNcFdRSVN1ejJi?=
 =?utf-8?B?SmNBditSemdlMDM0K2tqMGZuOUZUd2p1MnowNWZHejBNQ1JUbG1WNkNlUjV2?=
 =?utf-8?B?Q0tnYUZEQTJSeHIrcFFrdzBrVEI0VUlmd211ZHNKdXRyQlRLeTVYdDlvM21x?=
 =?utf-8?B?RC8ySWR2NFlhTCtGV3NMMXQyanZwL2kzVXlNcHVpOVl4QUlKaDFRN201WWlV?=
 =?utf-8?B?QTlid1BNbnhXTE16SlgzY09WU3N5UkhFZEtJV3N1L1VTM2Y3S3pQNW1PM3Nv?=
 =?utf-8?B?VEdyY2dvNHNvUHlsV0dDQUlSRUpvZHNBQk5nT21MNWc3ZzY1WnZuUjNFK3pa?=
 =?utf-8?B?YW84Z090azZhdnVnczZRVkp6bmhWWmRSNTNOODEyVzVpWWVtK2xjVk5uc2t1?=
 =?utf-8?B?Vmc5d0xkemJTSVJjWk94M0hqbjlVRGxNSEFZQnBBWW1XN2Jna1d3OEc4T0d0?=
 =?utf-8?B?aFhkV1p1ZEhCT3pNQVVESnFDSDZuYTVWbGxMWXluWUlDZHQzZnE1ZTFBYmo1?=
 =?utf-8?B?R3pxVWpJR3E2M09BSU5WMnA0NnFSRlAvS0dzdmZReFptRFVKSk9IN1ZmcSsx?=
 =?utf-8?B?WHpISHNiTVFhNTcrcDVsL2pndTZyZ29ocExteUljbXI5SEd5Y3gzOHdEcWFT?=
 =?utf-8?B?UGVLR0pzcy83VGhEL3JRQWloYnQvV0dmK3AxZFVmMFN6Z1hjTlpLTnExbngw?=
 =?utf-8?B?K0oxbG1SMDZDeDJhdmdlaG94MnJ3Z0hGdnNJSnhHb0d3THhvTTNFRnFTaHVG?=
 =?utf-8?B?Y3BGNTV3K1diZ2RxZlc4VlRXaXkyMVJ6aVBrOVhNSTdnRlJnUlY3TklINytm?=
 =?utf-8?B?SDE0d2RsK0tBTDJJQUlZUVBENS83Q0xPTzhTOXI1bG9hTFBOeXAxaVF1NjZp?=
 =?utf-8?B?c0s2UkJnZGIvVDR4N2t3L2RHZEtseFMxZ0JiazY0OXB2ZGRaazJjeGNjSWdx?=
 =?utf-8?B?K0tFRllpa0dUY2UrTTR1cnF6bEZNRDJYdjhUUmN3cHFWZEhIZXNhdHpUeXd2?=
 =?utf-8?B?WWRmMldEWTdkcjRkWHVJYk5TRFJ1bWNyNE5RWWRtUXlPa0E3KzV1M25OYm5p?=
 =?utf-8?B?RGZBZ3hGbkI1dWdjRWs0NjEvVzc4MmpwL1p6S0lDb2VjbmVoS2pNYW1yUDZI?=
 =?utf-8?B?YlNxOXJOZWl0bWt3U0lvVXRuNkhQOWM2M3F2dGRBOUZGeDczZ0U0UlM4a0ho?=
 =?utf-8?B?RFA1Q3VPemVwMVFiNnJIdkhjOENrcW5zOHJOT2gvWHlBS0dmQk4vbSs0NmE2?=
 =?utf-8?B?Z3paYy9kZEJoeXAxUVRoTy9McmF5dDJiVURsUEV4VDJzWjR1ZU4vWFJIMVpa?=
 =?utf-8?B?WlJuSzZIR1lmNEhqRFZTZnVsb1FvLzg5RHZ5QlZvZjRHVmFzR3ZRc0JDdGZw?=
 =?utf-8?B?N2lpMjc3eFowM0RRMEl3a1pDWWhOb3BvWTFNK2gxMWQ4QmJqdzNSczQ2RUdG?=
 =?utf-8?B?S2lmWkUrUjFQRVdTaFQ5aVhrS095Q3ZlOHZxbTJOZytDYUY5S3Q1WnZLTjlG?=
 =?utf-8?B?MzUwRW12SU5DMVladllqVmpwWnk5bHU5ZG5rTXc2MFBLTE9wWGtENXlTQWs1?=
 =?utf-8?B?SWtSb0xhMHRHRWtjQ1BCWmppV3Y0UjBtMEJBSnpDWUt5SG41Skh6RG4zd1hh?=
 =?utf-8?B?TEdhNkxJVEwzVnA5N2lEWHI4eW1nMnJaWnAvL2h3TlkrdWRTaWZvN0FNRnVR?=
 =?utf-8?B?VGJ0RlBYYzRyc0sxdE1iaTFaMjhENW5FdzJOM2ZOMURSTmRNaWJ3UXVKZFZE?=
 =?utf-8?B?NWY3RGlpeEFHbGF4TjQwbGh2OEk2Z2cxbTJ2VXQ5U0wwcjBPN01aU0RmQ1Zq?=
 =?utf-8?B?MVQvWWFwYk9FM1hkdUZudEVrdS8vQVBrUGZJbUdNdWJQSlgrZUg1aU0vWXNu?=
 =?utf-8?B?MEQ0WTAvVmhwQ0QwWmNGbzNXOFRDUko1UFptanZISmJwTjBlS3VPbjZNdDJR?=
 =?utf-8?B?VEN1ckY0Q1RDajR0eW8wcjdzTEdoajFXMDFwZ1doN0hFZzlXajJUT3FkMFZK?=
 =?utf-8?B?SGtlU295QnJ5R28vc3JOeDZXYlFhZ2lHemFkUVV6cGs1NHgrMmhnWnRPM2JX?=
 =?utf-8?B?SzA1ekdMMG5EYmYxM0dBRGJsMkwwNzM4R1FFK1lqcCt3SFRtM2ZqUkVOR2sz?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XMBMpJxxLdLiznmcLkJthG114PcSL0VxFQnpPZC1r6jmUi+Wkanz0ylmbGH/ZWkfJkriJTMyzOtY5tBoXTGPljpob+gZDzeJErusvU269wMoUBJLC98F1/itGtkMDEUoj+iCEZrxpPCXFEVmUm5h10KIypZ2rlP/vFUqsp2fTYUM4zAZ14y1p4URJrD3swwFJk6R0Ph774suBc0S7ASg2LLG1wKOovBAqBMTiDfEm0Gtt6MV6sBe/V7BPoUILOgrnRmeXuiniuN+603zMBzrL/3KUo3IBCJ1GrHLzCGZqo2qTGvEwLncfrgLqCKcTnlH8bVp2ptyv7tI8U2ELnZGEl0AzFoAI2OnCA3gLP8hjgLLRj3Tz0OW+s1Sf7uFBNroPNw++JPCyjqV/6SC+1Or2I19aId21bJtmMAT0w9HE7zB9dMoAPTxohYz/BQ5ZU7uLXLr6nMIlJhmCP0A2WeFa0GbGGI7GfwXQ0wQ9gruN0UIyo9TQLK7Y1XLxKrr9NYwlm+NZfFOZHVhG3P+FgHwOPFMyl0m1kqB2/yT0fy4ZvlelqvCkV+xb9cFJCi6v4utCmrOvclD+6jCe2ONJahuXsUw4INPApvHH1gWfOMs8ts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f212f8e3-d932-463b-5714-08dd562a956c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:58:25.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CZKJ7U51XkjGilVe5un8tF7TyKeHlt7doaOxu7pwD7ufy/hLTQYbsI8KIV/Cm3vVWVmwTUVAjzHsS4cTXU3c5pGaoB64qanBkG6R30jH60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260046
X-Proofpoint-ORIG-GUID: rl50zh9UZQ2IWApUiaxdMPUs61q8dHv9
X-Proofpoint-GUID: rl50zh9UZQ2IWApUiaxdMPUs61q8dHv9

On Tue, Feb 25, 2025 at 02:37:46PM -0800, Jeff Xu wrote:
> On Mon, Feb 24, 2025 at 10:15 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 10:52:41PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Add code to detect if the vdso is memory sealed, skip the test
> > > if it is.
> >
> > I feel this is a little succinct of a commit message, but I guess it gets to the
> > heart of what you're doing here.
> >
> > Fundamentally I mean it makes sense, but I'm concerned that x86 has a test
> > -expliictly checking- whether mremap() of VDSO is possible - are there cases
> > where x86 might want to do this internal to the kernel?
> >
> > I guess not since this is essentially a userland self test and probably
> > asserting you can do this in the way rr, etc. do.
> >
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > Reviewed-by: Kees Cook <kees@kernel.org>
> >
> > Anyway, this aside, this looks fine, aside from nit below, so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > > ---
> > >  .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
> > > index d53959e03593..94bee6e0c813 100644
> > > --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> > > +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> > > @@ -14,6 +14,7 @@
> > >  #include <errno.h>
> > >  #include <unistd.h>
> > >  #include <string.h>
> > > +#include <stdbool.h>
> > >
> > >  #include <sys/mman.h>
> > >  #include <sys/auxv.h>
> > > @@ -55,13 +56,55 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
> > >
> > >  }
> > >
> > > +#define VDSO_NAME "[vdso]"
> > > +#define VMFLAGS "VmFlags:"
> > > +#define MSEAL_FLAGS "sl"
> > > +#define MAX_LINE_LEN 512
> > > +
> > > +bool vdso_sealed(FILE *maps)
> >
> > Should be static?
> >
> sure.

Thanks! :)

>
> > > +{
> > > +     char line[MAX_LINE_LEN];
> > > +     bool has_vdso = false;
> > > +
> > > +     while (fgets(line, sizeof(line), maps)) {
> > > +             if (strstr(line, VDSO_NAME))
> > > +                     has_vdso = true;
> > > +
> > > +             if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> > > +                     if (strstr(line, MSEAL_FLAGS))
> > > +                             return true;
> > > +
> > > +                     return false;
> > > +             }
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > > +
> > >  int main(int argc, char **argv, char **envp)
> > >  {
> > >       pid_t child;
> > > +     FILE *maps;
> > >
> > >       ksft_print_header();
> > >       ksft_set_plan(1);
> > >
> > > +     maps = fopen("/proc/self/smaps", "r");
> > > +     if (!maps) {
> > > +             ksft_test_result_skip(
> > > +                     "Could not open /proc/self/smaps, errno=%d\n",
> > > +                      errno);
> > > +
> > > +             return 0;
> > > +     }
> > > +
> > > +     if (vdso_sealed(maps)) {
> > > +             ksft_test_result_skip("vdso is sealed\n");
> > > +             return 0;
> > > +     }
> > > +
> > > +     fclose(maps);
> > > +
> > >       child = fork();
> > >       if (child == -1)
> > >               ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
> > > --
> > > 2.48.1.658.g4767266eb4-goog
> > >
