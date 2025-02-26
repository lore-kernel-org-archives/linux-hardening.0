Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38B33997;
	Wed, 26 Feb 2025 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549702; cv=fail; b=Kx6OrKYKcpqIpZN4hzL1fAosmlj8Z9edibU0VWdejCKst6nryBaWRz+uL/jO53nj6F/GV+WaSX7rgTY0RS6mOSJpJVhdm+dcevtCxLyv6i36bw9/hwm1M7qC7mfyqHz8Fgl1iPgr0Z7kT0L9KeYUDupkW1WwXsy9fc1eTRAdvIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549702; c=relaxed/simple;
	bh=VCqDP42JLjJC8TU/6oCsheQclhArrsCedwnkq/QBHWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qJPPZbSFefCDq+2eC9lT6lzEZ4NBvVw5900Th9jQkcWPhzGmAdhhqzRIXLS2Q4ET2XUs4pVViJG29q0+Z8sg4xaoFx9vY46JE2JLGD9cgC0lKGbqm9GpmUTDEDAv/1lftgBccs/QH5jQGyn7JrLBs8BpSUtjI0hBYK2TgW9q1xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BjvWjkm/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yxb1KuN0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BjvWjkm/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yxb1KuN0"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5Xd9X021480;
	Wed, 26 Feb 2025 06:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VCqDP42JLjJC8TU/6oCsheQclhArrsCedwnkq/QBHWY=; b=
	BjvWjkm/n7LQHYFOY2dhINZpPbtv1w63A3UZYX+FTiFf0PjlGgKvk35cYg5Y1Dn+
	OzrkTjmrJnh45GTLe588HklRD9dEfGk1FrmLmKeNdKBiTwqECD+zXZ3P+XDRQn01
	Z4/l+BVVPVwVZc5/1CFT20PhhFBeIKYLesu2dxZAtaGxuNHIg5Rqs2vx1L/ZbVUv
	jv3LoMuavrQbNm2gipSfkIFVOybdSD2wygzPUqtprqYup1M3PRlVfGCMow0UqNgH
	qEWbaNJTtdCt5dtIS8awDb4Zh3XLpkXSsJor6I2rDgfKhMqpQJ5BRAFVpTdD/Ay+
	G0ceKzNQ6iExooxh1iRxIw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse8dpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 06:00:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q46n4i025300;
	Wed, 26 Feb 2025 06:00:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51gs768-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 06:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwvYQK8FBEsGW4CKUs72XWedLQrXTVedsvxDwTT4Jegw556GnP4gGyg85BMpHElTLo2RCgNk5OsJj3z/fVxLbTDneHVnsVzTBqZ1uZFBx5bjgI6lF9CwPym0dOcY8Im+oAtNSu9I1HICA0jgkgr4QtCR580Sv9h50aY5ybf4Hemgogr4m29+e0AApx64jX7OTgSjfT0QFuqPb0nXvm3cCR+fvP2Jsik7EQGC4ejCaDmkrJb+KidfHMahELOT7pMxpIRDwNAU6d0EWB2l6Rx8LVn1Z8e/96VZ3WVAvxXjFTXbQCn5UwtBwr1nIAaMC2hxvpgHGgBlcDU9irbzhBq/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCqDP42JLjJC8TU/6oCsheQclhArrsCedwnkq/QBHWY=;
 b=MDith987jABZ+DggUmOA8T3MqcN4BSjqh4MxVO8cxTAbV9TdgNyfxY2CYbhQ7ZhZWR5CvcddNLeYLnjdhrFt97eEAgVzpIfjTcCWUxxonb5YtxSjmlElkiKM1usH7rPkryAqPkZFh2D6Lqde8/VtSUySekDy0Til5pCAAzrDXBcEP6HUk9o6QQoZJCMxYDXm49hPuQGf2pw+oiBzhGEj7KWM4YGt8teBr//VoxUKdD6GdPk+E+o7zP8w0qp3YCQ3rbGUeXwTZYesC8POE1sBEoFl4bJeHy1O4zgo9/J7Ee0JQ4sPwzVgn8xGJ5fzx44RwABfcb620Mvjwl2Zc/0Ecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCqDP42JLjJC8TU/6oCsheQclhArrsCedwnkq/QBHWY=;
 b=Yxb1KuN0hhiGPntkXVXLTVIEx9LXv27s0bQNP4HfGR5SEiwhmMRSGuY07eaqWbhGmJC06NGN/ekuY2qhsNv8lwF3AipiUi6TA9BIdcygDQGjXA5KOQKrQsYUi3dwfmvPze7zveKT4G5Bm0orFmzWFhu0dKSxjZqIqmpim7XQEuw=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH3PPFAE1A1621A.namprd10.prod.outlook.com (2603:10b6:518:1::7bd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 06:00:50 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 06:00:49 +0000
Date: Wed, 26 Feb 2025 06:00:46 +0000
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
        mike.rapoport@gmail.com
Subject: Re: [PATCH v7 0/7] mseal system mappings
Message-ID: <afbaee91-3bea-4127-9dc1-7b43b0090229@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <30b4de93-70e8-4384-ae56-9f6b6cf0f347@lucifer.local>
 <CABi2SkXkfFAMhmXP1CKHCZMxdKWcHx8T9_0-nwBPWycTbxOctQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXkfFAMhmXP1CKHCZMxdKWcHx8T9_0-nwBPWycTbxOctQ@mail.gmail.com>
X-ClientProxiedBy: LO6P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::19) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH3PPFAE1A1621A:EE_
X-MS-Office365-Filtering-Correlation-Id: 13183590-e4c9-47fb-4bc3-08dd562aeb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWJLZnRING1DWDJMVlhWeVBLWGgxc3VoUWJ6cmkwdUNPcnJNU1I0ZlVMajFP?=
 =?utf-8?B?U1QwaHdNcEx0cUEwOVNwMVRzMUZ2cTJHTEhUQ0p1cUNSTVV5K0RkeTdwTkZR?=
 =?utf-8?B?Y3ZIZGZ0d2c4WjdlL1BuRVVYNWJqeHhkWm1kOHM5WmVhT2RwWU9CZHo0Q2lR?=
 =?utf-8?B?cTJLVXpGRlQ1QnVtcXM0VVdKd1dWbEdTRjVWUjBmaUlIdDdBbGlnMjY2bmNG?=
 =?utf-8?B?YlJxWmQ3MHl0WjFnZTVkK3d5YUd2UW5QeGhSRXVSRitNYUhzNVlKVEdsSG8z?=
 =?utf-8?B?aHg5SFh2L2ZVYlVQbGhvOWNYanJxUGNjekVoc3V0UnZPb1FpbWk1eUh4QmlD?=
 =?utf-8?B?OWhKRDhQbWt3R2pRUU5PTWFJQnRZZk45cUJ2Si8rZy9WNGVMMGV3R1o2UWhi?=
 =?utf-8?B?aUI1bjNjVG1IangyKzBLS2pjRFhJZXQ0c0FjZTdHN2Y3aytSbVRLTXJ6aEFV?=
 =?utf-8?B?bUpjOHJ6eFZYVlVwM0VSV0o5MVluM09DdExYRERpWGRuV3U1ajc1SytJQ0V4?=
 =?utf-8?B?MU4zeEhISlhxQnY5Yy9IUVNhRkxtWTkyMVBUSm9XWG50TUE5ZktqWUhrWVpN?=
 =?utf-8?B?bjkxdGtNYVlrL1p1U1lSdGRrRWhXeGpYdXlxcXBrYmxueGJDa0Z4MHp3b1R3?=
 =?utf-8?B?TFJucEtNUEZaL2VPMVBMMnM5TVBsVEY2amppam1mSmdKczNzck1SSlVrM0Ez?=
 =?utf-8?B?TVVaL212azVxem04YnlCaWoxd0tpYmpGWDhZR1FMSVVsZTNKd3lVcHpMTEFS?=
 =?utf-8?B?SEJuQ3BEUG1JaEE2RlFQTm1sUjVMSStRVU5ZSDVGMkdYRTRYZUxjQ3hIeW1T?=
 =?utf-8?B?UXBxWVU0ZmNpK0w3OUx0Z2cwWXM3R2V3MTJuUTZtWk96RTJkb3Nvdk5HSTN2?=
 =?utf-8?B?SjlGUkFYWms3Y3Z3aG40SXl6RVR2MnhhMzB3amNVVFFSSUlOZzFZS0t0V1Zt?=
 =?utf-8?B?OExOZ096eVNjNkJKNWZiK0xyZW5JSmxPOVJtV0hHVTBqYzFkSnpnVUpZUWMy?=
 =?utf-8?B?cGJPWjE4UDlGUTdnU0Q4aThLKzdyckRzMXJRazZsOEIwYktpb1BMeXFCeGNm?=
 =?utf-8?B?T1JYdlJSekMwMythd1BlSmViYW9BM01XM2NoYUptTUNreEhGOXNrSXVLeFRS?=
 =?utf-8?B?ZWtzVjZGd21QbWh5YVdFcHRwMDdyNlp6U1BkYTcyK2UzZEluTEZ1dnFzSHJ6?=
 =?utf-8?B?cEh2SXFjdk5BSm9mOEFNbXorRmtDNlpENU5EQnpYZGFQZDEwYTBkSm1DSnVU?=
 =?utf-8?B?WDF2Tm9aQnMzTGZaQXF3NkF0STVHZCtWVyttQ2h6TTdQdWRhMW1ObVFhRzlV?=
 =?utf-8?B?VGN0eXl6ZzFFM2FFZGVVckpJTWpXbm9ac1F3NjNYWUM3VTgwL0F3dk9YYS9Z?=
 =?utf-8?B?U25nSlhxRE9zdmNEVVpURmhYR3Y3TktuRHZ0VTltblBJTC9DNFdvbzVlVlVB?=
 =?utf-8?B?RnJPZXVGQmxkVDZIdUlnb1JsTWlTV2FiVmZIZXZYSHlaNzBaR25lZU5BVWdp?=
 =?utf-8?B?eVYrdkw0d2RlNjN6ODBsdEFadlJsN3pkNkpYbzZRUUZZV3ZnVVNpd2tkbHli?=
 =?utf-8?B?Qi9pYUZwREtCVnlzOUFydlhrUHJ4ZXFyTUJtS1BHemlEeTh4c1ZjUG1CQnFx?=
 =?utf-8?B?T2M5R044MGlCcXpRUjRDSko1Vmp6UmhoZTg2a3hMaXJLbmt6ZVFxcjZmWGwr?=
 =?utf-8?B?eGRrV0RGU3FtOVN0MlRJM2QycXlGNndndDlib2ZaY0YvbnhzMmVmdWdIWDkz?=
 =?utf-8?B?a2dlT2MxV2VYc0pFN3pLeUVhRjBlUmhCT1pJaWR4cjRMdjM0cytUWnFDZlU4?=
 =?utf-8?B?QVpyU0xPRXU2a1dLZ3VqNEM2d1FZQnEveEJhMUVPbGpxeVNEWktjTUJ6SkZP?=
 =?utf-8?Q?N++ygJYqdprEv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2tRUm9sT1gxQkZULzJkTzlUOFNnVkF1b1F2dFQ4Yk1GM1RsRnZGMHJtTDA2?=
 =?utf-8?B?MlprQ1JoWlBwYmVjV256SlMzUDBzRlFySUdVejVrWHpZUU9uMnNTdGtpUXov?=
 =?utf-8?B?VVZpNWtFSE1FSUNPNWtJQWNkY1J0b2VGVzFYY1VycjBNMGJXVWdhcWNkcEs0?=
 =?utf-8?B?dGFPNUZXaEpPbkdPbU1NTWpEQVc5Uy9ZdXZEdjkySFJCeTl4UkdRV0dQS2ZT?=
 =?utf-8?B?U21tekM2UXNyMlZDdXFKQlNOdkVBMmdLSkZ4RjBZVFlZS21QOUE3ak54OVp6?=
 =?utf-8?B?RVZIV0g5SVJMV2E3Vld4Z2pIeklhdGtKS09aV2NkZmdZMHh4MEEvZm1EaWpZ?=
 =?utf-8?B?VXFtZm01UUlzWjR1NUIyOUdnTUZhdmRIR1hmdm5zUlF6Um5MRGl1dmZZbUZP?=
 =?utf-8?B?QWt1SnEwRzNGN0hsMmEweTNOMFdQaHJxVmxtR3RuTlMyVXhrdHNkeUtjQ2JR?=
 =?utf-8?B?VmNidU1tVGlDM1BKM0ZUMHhTWkl0cTNPY0wzREhUMngwTGZuRWcwTll1MUhl?=
 =?utf-8?B?OXc5UndESURZck1nTjJPaHZhRTU3R0JPaUVMeWxmbFlnQnVlc3BJVDlaaXdp?=
 =?utf-8?B?OFBZbHBWVzZPOWtHWWY0ZHU4R1hUOVJVc0tibmN5cTlJZ0JTSFp2YkNTTjJu?=
 =?utf-8?B?ckxXY0s2ZEM2aGRrT1VzSXp1c2JYTm8zUC9vR2JKazlOZlVpejBZSmVtT0tl?=
 =?utf-8?B?S3JXcTRoVHlISHZzcy9URDNaOER1emNYZ2FwSEJGd2Y3WGl0TFl5YnRhTmsw?=
 =?utf-8?B?TWFFSUVvRXM5RURvdWJnSmhuRGVDOS9MVm1DUVovRDMzYndXeDVVWmpEUVNp?=
 =?utf-8?B?YTY4MlRFWHBFRlVzWm5aaE04MmdRTEUyaUJyME93WEtBSlBwVFdML21zUGND?=
 =?utf-8?B?M1Jib1pHWkFEWFZqM3doRmZGYUFHdlE0L0VHdWl4eFFsTTlDVUVUTERweUxP?=
 =?utf-8?B?ZVB3MDZJb1owN3JOK3BGaHp4MUJxR2pITXBkNWkzaEV0Y2NVaGMxYU5Sd2dh?=
 =?utf-8?B?dC9wSnpjUUhPTVFqRzJZdXdYN0lmN01hUG4zUHh5L3o5bVV1dGtEVmhPb3JM?=
 =?utf-8?B?TWNsMXVhWWhlOFVqbFRtcmFWTldFUXdSR3puV2FPVEtKR25KcXVnVG51d0d5?=
 =?utf-8?B?QVBzSHJnWFRBSlFlY0xLWk1ibzJ5b05WdXhXbmwyYlVvUmZsZ1FJSEl0bVdV?=
 =?utf-8?B?a0lTbUdjNEZwZ3ZnMVVxRzFRRlVLWXZEb212RnBkeHdOR2ZqeDB4c3l2SzNQ?=
 =?utf-8?B?NVJmMURORlpITUtRMkN0Y05SY24wTmxud25POWUzT2RvMkpMTjVOUVZ0bXhY?=
 =?utf-8?B?dG41Z1JJUmF5L1lRUlQ1RTdlM0NnYWl0RCtDS3ljdk1Cb3B3KzQ4aXFtSmZt?=
 =?utf-8?B?VTA4YWJFYmVmQVNaUnRCZWF3NHVpUFljY0hUUXJvdEFQNFk3TkpJZjJ5dUJ3?=
 =?utf-8?B?SkNNTWlKZ0RmWU1TODREVmtmYmwxYUp6aEtwemhWaDByMFlHN2pXbHlRZXdj?=
 =?utf-8?B?eWJJYU5mWnRKUEYxZ0JNU0VRNDJNZ2dpVmU3T2dwOFNmKzRSNHhaa3BZWnNW?=
 =?utf-8?B?ekxaOXd0TjBLQi9GeUdsMkJTajFRaEZyTHlTcWdYVXBLRzVhU0grV2kzSHdj?=
 =?utf-8?B?TlhMMnV6ZEYzY1Nyb3pSSWFXV084K1hod3dqbGh4UElIK2pCQWNSMG9FbTVq?=
 =?utf-8?B?elZ1RElXaURkR3pRbVZ6aUFVckhBNnJzZXVZWFhiNjNFOVBPS2tVbEZjNUtj?=
 =?utf-8?B?djFwVGh5VUVTNEhuaGxjL1RqSHNvaWc4REZNTG8wMjViNENNWmtMcXl1Ynl3?=
 =?utf-8?B?VFBOYzAvU0gxQ1pmaHlDQUxVRnFYMitrOUg3dW5VY0hoYldwbFlYQ08rOEpV?=
 =?utf-8?B?TGRiT04yUjl5cE1CSk0wSVNyN3JNRTdncElhUE1vV0Q0RUZSOWZzM3dRUTYy?=
 =?utf-8?B?Z2JQZkc0SlgwaGQ5ZWRqUExpeTRhQi9McGZTaWtwMkVsNjZNUGFhMWRUOEUr?=
 =?utf-8?B?bGpNV2o1eHBKZWRTUVE1eXFZQXZvU014d2dLeWlpMmVkUkhzZ3p1MTNGaFh3?=
 =?utf-8?B?aUJkdzg2TytFSFdCY2lraEJId1Bnc2h4b0RNWHBTbmxJQWthV3JMWmtIc0l2?=
 =?utf-8?B?SEVWRU9xTW4yWllCUU9zc0hzOTErYXlIRlRUODUydzdtVzZNTkw2akZpNkpC?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zz8Ut2wbEEtdX7melS+1oTDHUPPcN2qvp8F+O9Gzn/ty0+4bO6t4+GYwYscGizMtLofh44I8GdeA+SXf7SPacHfm16Z48GCv+D6aDb8Y7iWwrPkBgm6h1guEr5cbTYDPIchuuuy1KqIZjNpAfvRN+0IL9q3Sceq8FtjzgIoX3/GF04s6oQfabrq/KaTG6tHdFrvYIeh1f5Z0nIZ5VLClTc2FypncY/lsg659nl8vADY1z0wY1qXMgDz6YSjBXr1M5JV8T0t3WJxvC7NX01vQidLPOXc9K12RldYp0EN9iLNqDxXMyzmLcqZN0xbS3EG5FHaWw3U6toCDYrkewcoR1i0FKx82RWKRIeA4y6D1R4bUgskFn2dl9hcsii8z7Injgb/QLHVGih1a3cq+L4Cj6IY5MLd2IwGGzhO5ifHaMVuDRlGjD78BlMATdVRc2MxYvqGa83tAOQZj7FpB8ohwZ1B7e7i+xowgUWdFfs9uXqJvvtvhScEVsQhSop2hOubCMO8FjvVp5+HKCWB9wF353fX7YTQT6Q+bHTYw+TurhbCoFG3U9PbZ4a08n1KL5SPVhv/1SmVjAphZFn6sy4/uU4AZVV1raZ0MAt+9h9B8RUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13183590-e4c9-47fb-4bc3-08dd562aeb1a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 06:00:49.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxmSC3JzGMdUtCdKexG7glyu/lu/PFwcRARFLhMgO3h2eBkX2/O+7Y26PBFn0jNapR39TVnlmf61qYg0T4CilWQoKTiagvTlx2mIByE2jzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAE1A1621A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502260046
X-Proofpoint-GUID: 889WRCCVTJdigOeDHWRibExuopab7za0
X-Proofpoint-ORIG-GUID: 889WRCCVTJdigOeDHWRibExuopab7za0

On Tue, Feb 25, 2025 at 04:17:01PM -0800, Jeff Xu wrote:
> On Tue, Feb 25, 2025 at 2:32 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > BTW can we please drop the 'mseal, system mappings' prefixes on this
> > series, it's really weird and makes it really hard for me to actually read
> > the individual summary lines for each commit. 'mseal:' will do.
> >
>
> I am not sure.
> I had comments about adding mseal, system mappings, as prefixes, and I
> think it is reasonable.

No it's really horrible (sorry I know it's hyperbolic but it really really looks
horrid to me) , I've never seen prefixes like that before in mm in my life and I
don't think it adds anything.

I also find it MIGHTY confusing.

Please remove this :) you can git log the relevant files to see the conventions
people use. Typically xxx: has something really short and sweet for the 'xxx'.

I realise this is subjective, but it's a small thing and would be helpful for
parsing your series at a glance.

Thanks!
