Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7265256C89;
	Tue, 25 Feb 2025 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464571; cv=fail; b=d1j5xfUEcHZZF9NAZMwA0Fcw0k8B8INXH3KZtWaTkzfI68f31sjnTbQI8xu1H6A3W2QH7NRESDuWrGBMKGhTe/IqjUQp0AiMaRQCQ1Ez4TNU0V15yoMNwn92UWfLVVo5pkjuqv11qhDC35xzjlONVlBeAYbQKyueA7KnqDvzsSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464571; c=relaxed/simple;
	bh=P4jXWmCvwUdf5w25K2H9UGQYRLcYEaRYIfekvO5G6Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IlGImA2OjlZ1/T7u2Nap/sbSy1Rjy1gQS8qHKYkBCk08PPiQJNlgIjffQnODcYm09tGeidU5oAjhqKI2PhApdDf1XddXDbdUzKKM7ayhvNaotbCPIzpggEO9kRIx00QR8h0Re74fRYNJzKGqP5sCfV/ABKr5IsMT897/v/DPUsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jFgm41z6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fUeqV3Kw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jFgm41z6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fUeqV3Kw"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BeOi002687;
	Tue, 25 Feb 2025 06:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=q69pMVWQvipx4wGvYG
	QExuC9Eq7cFaFI9dda9Svai4A=; b=jFgm41z6Pz9DJ0Fn6ECqX34ll6vFh6ysNq
	FSH04JYYEFLAnLk8pZJZiJElSZW4uR6hkoaSg3wYYvrlgY/6B144sYERfEFDQEI7
	5dYVwUcBJY4+Z4LSRpPKdxIDOK/35TtXerdDXX53JE7IBlNQtOMNPaRUaoWykq6p
	ayTLnHhOHOvEsGgnUZ9s5X+OujX3R44spxgBGAUIDGBgZPmXHdbOLcuILmZdjqA5
	x9eaXmU6cxxId9ryaVIBxgcpl4PBmev1VqjlTqDt9RckNKlmz/eONIjbNSc6dCQU
	BqZQ613TabU3Y/JL5NzhhK9shuFugAjhTrCzsrgBsrBf7cRORxNQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9c7e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:22:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P62mGw010247;
	Tue, 25 Feb 2025 06:22:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518fcaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 06:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVJX3S4ghQNpxu2sjkEcQl3oX6VngfXewegnC24aw42Ih4RfdCUn1B18gh3eug2jqwd+Knf12FKfp70YNhHH6gxT3B52fH4JbFE9G+CvZs1byS8O/DuOgoXemTkShntZutH91rHnEAwEFGHPIEdO608Gj9P95HE0mM5s+4aWktfPmQS0yaN5F/wYYtCDIrmF+GrSwRTXwtZaCfuCJasWpmlXqDaciQkXqODXxQvGrkZRDwOMyu51HjaF22+wiEbkTR+/O18KGbirbx8mNkcQZCK4Q5MMkNzhWDqDU3zUHi/Ybsm2xPs4IEvNMMXLoqtT0ojVaWrls78l0nXw3Px9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q69pMVWQvipx4wGvYGQExuC9Eq7cFaFI9dda9Svai4A=;
 b=V2tB1CVe18ZD681+gNQDGxiysq9Fv/sG/QuUr49GgPPciOI4Hx2cRv2apLWj4l5EBgY9vgRwbaymHx9znJwqOaI7KsQX/fZVs4MRll2DrIluhWOq+7IM4UOeXvXOGLaCVk+hNDip95iKig5lQ8oKnfqtHWEeEbKsTYqdQLiWBtYhXciBfW8pQoMVn4qt58im+jg3WJtWIFxEA0GzMCLaZ6CGPN57oPyPHXddbx1VWOJRGJxxRu/Mf1JQEtALayJIaUtn6nK+gLiDDn4B7VqI2q8WhcN9Y356c+dOOc0BYcX/3Af1SRpxfKjnaQ7paqbPyXJBxdQUE3L4X65iCR+lGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q69pMVWQvipx4wGvYGQExuC9Eq7cFaFI9dda9Svai4A=;
 b=fUeqV3KwGfF0MEwZUc5h8rlf0fBO8AnAZZSMl0gkCNyadkEWbwm7ERe65gqq2xX3Efel+T1yf8VJAlBdIsmwUHCr+4KhEVl7H/T9w9u3HzUxRvXJeJPZ5P83ryWVT65v5dazsRl4I739K4YBI6uOD8UQFdggMUfRn7wrMU3Ydfo=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MW6PR10MB7686.namprd10.prod.outlook.com (2603:10b6:303:24a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:22:03 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 06:22:03 +0000
Date: Tue, 25 Feb 2025 06:22:01 +0000
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
        mike.rapoport@gmail.com, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
Message-ID: <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-6-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-6-jeffxu@google.com>
X-ClientProxiedBy: LO4P265CA0218.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::19) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MW6PR10MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d61bd4-0556-4b34-c54b-08dd5564b825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iii3MyimpnrfX7+38qfh08+apY3Pmjvs5CEaXIM1tr88+7CIm6rQQxLZdrbL?=
 =?us-ascii?Q?NvsOz6VEVhT0N3WdQ+u8z3eFOWxt1oWT81fmZM6px4vOlGZl345VXNdogiDu?=
 =?us-ascii?Q?qs5cMAWQiDh3qrbLikqKDeUbNXklJhZZ9MhWhhs2datRdWDGcmjuxH/eNUaJ?=
 =?us-ascii?Q?fmp3ZKcW7O1oTUK5Kj9jRtqzEUmSOjjzAbypu7jVJiH4rporn4Iosz6pUr4l?=
 =?us-ascii?Q?ap4RkGWBux8MsHeXmyvAWdPMMy3YP7L2JlEtOlU+ppptP5gT9/h10Osalykg?=
 =?us-ascii?Q?Yi8VYBx2lTWKHxpvuHSu9gaiFwK48n+1SOz+95jKiJz3RoPVPEe0YP3A8r6R?=
 =?us-ascii?Q?HSS+NFmRt3Nqa7vn3k90coXxQ/00JzJSUX2DEAyVpec3jX6r6gq/Q4/tkNvp?=
 =?us-ascii?Q?xEdaNlJhBVMAZhF3IhLJczoYgQebYtc9Tqz2/PVG/XDi3SetYiELcaQOVCVc?=
 =?us-ascii?Q?9pBztD21+YxHggtjhLwUvJm1nzS6zLVvIecI1n1h/v1gPosG0cep/bp42n0m?=
 =?us-ascii?Q?X6thK1rcXqM0Z4PfPtAFVnr/YzvgyCTZAvEuRXEms+ELJxLd6tRUgtDlmH0e?=
 =?us-ascii?Q?PQYwWRuTmyHlPIam9VypwTjH9qbIk6kEf0r77FvyGr+uCtzurovMYTjcO8Zi?=
 =?us-ascii?Q?F4NMgL7mZjc0kNraofRTgxhaskYJ2JySGkc8hkX0DZ2TXetN3E6U6prcT3g7?=
 =?us-ascii?Q?cjcXHCrpmcBb2jtveawnsEDbPfZFpn7cWVd9tlNq0V7Hm0C673tHDql44nsd?=
 =?us-ascii?Q?B5eEsN759dpCd9Q6NfdjP/j18+3EwYE2x64Ww6CiNYEfaC9qukJyFKCqFZsD?=
 =?us-ascii?Q?kMr1gKZq5He/dDlU94MpZ1ea2PI4xfuwrnPS+id453jaxf4VkKy+z308NU/R?=
 =?us-ascii?Q?hEXuUDinXmFLjnsu5m4nlPhfuznpPOupC1TUaneNxtoxmveGLQ8kxPr9fSqm?=
 =?us-ascii?Q?r7hgB1BRAtVmlvEy0B5qjs7d+4kk1DM49oywxI2wsmc6LUkFUCqNZIgT/6X9?=
 =?us-ascii?Q?ptC1tbNJckRSwOnu4QyQaRQtuEMIrNciTbAVoBmDBrI1cynFEyXPLgeYufQq?=
 =?us-ascii?Q?xNOmmX4qiXFi0cChBwquycHx4l3c4JpfeyAXUlh1cOfRDLFhc3VWgPtQpROY?=
 =?us-ascii?Q?JgQViEsHsJ9Fd+xfT1aNMLjUzjdC6XYLVL6H3AZpOkkRuTjJEYMBt+guXQ3J?=
 =?us-ascii?Q?zP94kSdXrRF6t+8QnsMgsrYboy54Ty8qFZkqR9N71aFkcJQwmUnIFUmX8rYa?=
 =?us-ascii?Q?+CeZDFcxXk3eQ/uXEZuRkHf6ki0b++QZ/RkXHP1n6chJfajPteZR1mvJooTy?=
 =?us-ascii?Q?dEWDgsJCv+ZZnufzHcaRfyTRyizoM/rrRaIgNt3pCmhGmNjw+AfZFWLCmMph?=
 =?us-ascii?Q?qWIYKoQpZ1dFAvk6bYqCwrIg5uxk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bYCu5imPMK2svYFPzF+3YZl30v6dxKRhrdKsVQdaoaS9lQT68W1qH58B0eRz?=
 =?us-ascii?Q?XqnnkyUSmsYtWfaWL27JjLM10Q/vBLBNO5e5TgonxkaNcj5tRqDEFNyQYPCQ?=
 =?us-ascii?Q?eqol9Aumdi8a6zJ0LTTRgf6UqThD91FJpEOii2QsbzXaDIYp7C424UhQTAxq?=
 =?us-ascii?Q?rIDQL1lzve2Ro21GoEUEXRRZocDRC8DLZ0kGR6G9RLZ1rUef4n+4w7Ka5+mP?=
 =?us-ascii?Q?cONMvYkTQExXLatXYEEisl/Z9DsNUTA0FNB2EEU1sPiTZuSOAc8NU5Ypx6Jm?=
 =?us-ascii?Q?KFU5WrzMQTgUK5qNx+891+BdOeTqWtEW0GLTw75i91gkbvP+E+bNp2NhLyP5?=
 =?us-ascii?Q?WG0N/FJ+6GQ/TSjThG7opjRWqsHAs/kOmG5cTwYIoW4XfnX1E50DoeZhvEco?=
 =?us-ascii?Q?4FVgjBNzHHwGToL7SEdf7aXR/GfOegI8rcKxis0gNoll9kSuYZUyUKU9K4KH?=
 =?us-ascii?Q?cWTrXSwt1sVY1edumptvC4CFfV1xYjpALRTTYGTkaF/3LJtMjFG+khaOFLxh?=
 =?us-ascii?Q?/WlU2kqWPzF58ImwTcn4ecYJ1V9BHIC7E8z7vRN2xaxZonDrSXyGNAdqLbzY?=
 =?us-ascii?Q?92/mm9CgBhv8ExtfzGCtTUEaWsASNLgXprxvaQJ1ghU2gL3UI6kQZyY/VyOt?=
 =?us-ascii?Q?UCfEX8AzvK7w4jjH7Yssk2Z8bFplpjfn4hT9QUdExBdOD1ZcZuWjYs5RE+X2?=
 =?us-ascii?Q?Ir2CXtXdLPk2M3i8Kk7N+y3bAFNhXEoSg3Fv/roqHcmznwY9byl/7QaEAI/2?=
 =?us-ascii?Q?V5blZDZ7ryAJWwHc9I6Y3G3V5x2ThPWjx7NXfi0gh+cD7EEeIHyFH/TOqr7i?=
 =?us-ascii?Q?riB3BMCQPgOJQkqCSviIho5txTLnQNHLRV0bnT6xmnLpsI21eYKM7MKn+UAA?=
 =?us-ascii?Q?2nlpBjgUmWPjrz2MAn4kT5q+r2DjpWBnIl6G/nySsbSpW/8YddC1IEfSSaxv?=
 =?us-ascii?Q?lYHMKac92cF42ltG8kD2Dqc2pMzV8uVNmbWUOEB3sAbCsWdnEwVdpWA/bYJb?=
 =?us-ascii?Q?HMlIYEJudNODfnK4ibh+vUsQy7y0zyvPGAaFvschj2K4Iljno3ZOB5rpXSf6?=
 =?us-ascii?Q?dd+w3Fh1//H/UdodeOfhTdIfDS4RWtZKqMbOWHTRAnuPsOgb/oGo5RrQrEii?=
 =?us-ascii?Q?HtwdLlywPlHbvf+Ez4Txh+GthPm84c7tJLh9rriLg2D/M0CAZYSGzCWSMCxp?=
 =?us-ascii?Q?Ag7ILC7LA4yI0uqBQM3dvS3ULiyKr7cwdA9Vm6b+Qs5aTaFcGYjcll7fd+pb?=
 =?us-ascii?Q?bG6ZY8dMCpm3fyO8vWUc1yF+8J5eJk+NFyJHeTaQxOZKkw/uOu6Zy1iWn747?=
 =?us-ascii?Q?LmEs87o0YSIuaKCJ2Ae4NNeHpXcI0xgd8n9nssx1tBGRsa6e3y56OG7ZCHjx?=
 =?us-ascii?Q?nvNMpN0C6co4+STPrAOjxzi8HcbL6b0/0ZIBWp0cxuJAiiM6bOxyKdndjffV?=
 =?us-ascii?Q?YZx2+akXoZUHpMF2Ledbz29R0I/FU0h7G9mSkaSHR155CdTFUKFiFg9WXhLV?=
 =?us-ascii?Q?2FGXdEZlkM2zWKLAAEFi0mLSCSBzL8jJylKqSrEXFMkcv3rzzCjk+ricueNu?=
 =?us-ascii?Q?5vr3PC+75tGKS+uGkf6vjhndDWPbfB5013dhiz6ckv6nmVreKOQWdVReanYW?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K4B4+4K28ZVp/bWKg8+3p7Ib1rFCFrMvs0rcmN7gGZ7nHwXjSuqW0Ppc6QIgEHhANiryl2AVjJScYQ/g+gx5sMVZ9KqPGq8rGjozssPI2pZUaNAugPZsypZ7dgggWSnke1PYqwmlgJotMbp0/jsJi8AkUH8SsNRR9SzwIPo1ymmkpkWgnteNXltIVBz9B94wazRianCjUuH1LK0s6i5whs1lBLVVnB+OiG06eBwJBvLgkaeDQ/sP8tAf9+4QWJ2Nd8pXm4xJKB6LAXtkV4m7Lsz823WfFP9hKKJ/wCvwDHh9Snpi6VRdJaai0FNnBXH02LwBqPFQR/GkB0aUjpZhBBIzlG/SHkjjC/W0xVmO7raCZz/fER9fqxSR9YANrnCbgfjKFToZgpZllxJlzFsXnFDmCfuQTuWFVuy09rU4c+XRcJj2r/dwB6+ZSMU3XI/DQ1JMuk98lzQgVlJn/x8jQq0KzIKEKhgsxBDCqMKZXf5YhpHUC3t6dA4nJt8bpb82uk9kneaP/b5Y7y4evygQgTk0u3YT9oDih39jrFtJJlmteW4MOOQ9pNhtHlJQBP+08yQU975U3P2GHFBq7bgPLeEGSUiafvcDfe7jFOPZ31Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d61bd4-0556-4b34-c54b-08dd5564b825
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:22:03.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5iihSEHeMkZxtp30EkwPWdJjjxopmc+VKiPZGxcy9JtfjbFQuUgw+hUbFJLucg7Uh6Nv9i+4DLajKvxN9eNCmPxM2z+tOLc9AVcFPthqdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250040
X-Proofpoint-GUID: EV41GWgwsxG-8LRtc9DNH_QcImnVQ8NO
X-Proofpoint-ORIG-GUID: EV41GWgwsxG-8LRtc9DNH_QcImnVQ8NO

On Mon, Feb 24, 2025 at 10:52:44PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
> the vdso.
>
> Testing passes on UML.

Maybe expand on this by stating that it has been confirmed by Benjamin (I
_believe_) that UML has no need for problematic relocation so this is known to
be good.

>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Tested-by: Benjamin Berg <benjamin.berg@intel.com>

Anyway I know UML has at any rate been confirmed to be good to go + patch looks
fine, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/um/Kconfig        | 1 +
>  arch/x86/um/vdso/vma.c | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 18051b1cfce0..eb2d439a5334 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -10,6 +10,7 @@ config UML
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_KCOV
> +	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_HAS_STRNCPY_FROM_USER
>  	select ARCH_HAS_STRNLEN_USER
>  	select HAVE_ARCH_AUDITSYSCALL
> diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
> index f238f7b33cdd..fdfba858ffc9 100644
> --- a/arch/x86/um/vdso/vma.c
> +++ b/arch/x86/um/vdso/vma.c
> @@ -54,6 +54,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  {
>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm = current->mm;
> +	unsigned long vm_flags;
>  	static struct vm_special_mapping vdso_mapping = {
>  		.name = "[vdso]",
>  	};
> @@ -65,9 +66,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  		return -EINTR;
>
>  	vdso_mapping.pages = vdsop;
> +	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> +	vm_flags |= VM_SEALED_SYSMAP;
>  	vma = _install_special_mapping(mm, um_vdso_addr, PAGE_SIZE,
> -		VM_READ|VM_EXEC|
> -		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +		vm_flags,
>  		&vdso_mapping);
>
>  	mmap_write_unlock(mm);
> --
> 2.48.1.658.g4767266eb4-goog
>
