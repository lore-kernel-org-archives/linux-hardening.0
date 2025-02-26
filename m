Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135AF7DA73;
	Wed, 26 Feb 2025 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549519; cv=fail; b=JZUawmkHh0ok/LC7MTmj+rkJPAqmUecxZMlmXZoqztVRcHI/U35MLg36wOGuWM7A++4OiukImnphQKFUCu+xVD+PqNP40DV4zNHS0d6dX+dePcbTYvc9VItJvZ/9Yh53LX3+6gIfOwQBsp2r6jsNUnZk+gHMOYMkNRJvnLI4QuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549519; c=relaxed/simple;
	bh=dDnQQ2suWJwVUnv+dWG8YZnyM/mnnX0Lee3+JFvy/FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QvIk6UIlCc+hBvcJINxbij+mc3eqy5fsf4a5jnhcY6jn+H/ee7yeiY53SEkycmBPvCxgBW1IRDAGAnf+fro2R+7JMu1lB7whrXrAfa5NYKqRcPr7nvClLWRecWlkk88P+2+pp3VTGXdFIZIg+Pc+qTIcJ3z3Y1AEAU5jiMoFcYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jdls1GUT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eRQCbkaA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jdls1GUT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eRQCbkaA"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5XcfQ029822;
	Wed, 26 Feb 2025 05:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Usk6OlARyqsFzYYGe7QTGh4I61e2ZF927fnLqC1AvTw=; b=
	Jdls1GUTuQtMsgsK8YLn1DAiJZZp8xCyKg+xnVy3O95tNw5HQRhIOgTifEyMTz+4
	7N5cRdcbZ9Q9Dr2Zs49XnGI0xzyZzagoXxys/G9MBTO8uKcWe+LnWuV5Ra6olDxX
	aDt9NPSnovUy1x432sH0tcnx5Tm1bvQjMGJynN7KGvbKp+k3MSjUFR7TogTqumn/
	M17uFh0dUNAbDWKWatyanubz5AGMlY1NkFjG3sZArFCx/a11gBW+cwGvCWp2D2hy
	RmwZ+Z5sah2VcqhwNsHNNq3D7oMwN5FniE05i9jqJdjwxoazT13mlJ7+R9neuCYS
	79XXLVK3caG7FqVprC7dLQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdgen0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:57:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5k1rL002916;
	Wed, 26 Feb 2025 05:57:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51aer4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:57:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfraKSwUqQ7Y+NOzVXCb6fKHq2JjHdrzxeiqYj+eIZRvPFO+icjXYXRJNxZbWMYSd1xF3g6GVNriBMF8tLhxzK9Dx0oHVkCKQLJV/8ysI5j2L/lxSc8rWfDDbCnJdlNEM5nxjQqExcUF9moycdbNpanDudGyTFYv1x8/zwl0m9ALTeVohXyvM1CD2MOE3swpPrGIgOXWhAYuDDaVgQHDEaDGBwJy16gK/ugBXm+msrEOdTM0VV6YmKfYVTvd5fPk1D2/Jnj6TZ7nKpYczwKlnW8mNfOuxLMdCLhOBhXtYpZfWZ/RSlsUfuHRGk0Gkw7zJaMBg1+IfQLJ82fvag8rpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usk6OlARyqsFzYYGe7QTGh4I61e2ZF927fnLqC1AvTw=;
 b=Qus9dMkEaU9vOC6a4H+UKaTXheg5N95Z86gFACofjjO5r9V7mpO5p6hZGH629CQKJGz3c73LBcFtzvzPZlkGn1v9UwQX1IJCjCYMWKEl5emf4m36ohiMvrQ1NBgOdXpASXdLT49uVoBgX54XidCU1sUaEbpwCppcqBq/b85aBLLReRT+v0gbypvRWcC2XvQP0NMMsyix5tv31pbHHW8LVJsojjokKeQ/JaIj1sugRcOtaZAAlNBuY5hwhq3i4tccjLH/7oZ3Rmipu8PWl0frp/b9qAlMCbsoDI4C6opAjDJY2o6EpJeY7w+twAXa9gS8uOakJ/91Sxy93KVx/+crow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usk6OlARyqsFzYYGe7QTGh4I61e2ZF927fnLqC1AvTw=;
 b=eRQCbkaA2RCVLit2+QRfM9OwJ/4/Q6k1GWBoBXqUzMCTVAsjgrDoEO3ULpl+TzrvdUkUkTifwHYIiUPIzQsLD4uujSXlMiVYIUMGpDolU9DNHjJ1LmDoLndkBVAqCkNvFrgdfrWv7hPrtI3OZv178KUskiX4bVQtpeaqV3bnG10=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by LV3PR10MB7914.namprd10.prod.outlook.com (2603:10b6:408:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 05:57:52 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:57:52 +0000
Date: Wed, 26 Feb 2025 05:57:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        vbabka@suse.cz, Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
        avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
        adobriyan@gmail.com, johannes@sipsolutions.net,
        pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
        anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Message-ID: <9eed1285-3876-4f64-a079-61a72f6349fa@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
 <55a9ff15-c72e-45cb-ab38-ad814011e27e@lucifer.local>
 <CABi2SkVRG8-j7T30tFQySOU9G8Lvyxqf_aRTrE2KXhj9GeBOkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVRG8-j7T30tFQySOU9G8Lvyxqf_aRTrE2KXhj9GeBOkw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::25) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|LV3PR10MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 240aae7c-111a-4a51-d93c-08dd562a81e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1VBbmhPcmxlSmRPRGFiRVVSQVJKNGZ0dlFkMnFLOG9ROFdTQmZuelRCZjlU?=
 =?utf-8?B?NTVUenNONGxSQnZzTXdqcjdOR25YZStVVnZVMVgwcmFjOVdkUkpGM3BvbGFX?=
 =?utf-8?B?bXNFeUlqUDYrd3VFQmNvVlcrTWJ5VVJMd3AwaVlSalhDVHV5YUtlYXQ1MFBO?=
 =?utf-8?B?ZzdpaFZRWEFwdEMySnJWV203bWNEOER4TFcwaFpMVE05Rk5xQnoydVI1QzlO?=
 =?utf-8?B?K2V0eTVpREhnRUxUS3FoMjFyY3dZVThLMUltNzREaFQxMStoUW45QkJkNWZq?=
 =?utf-8?B?RkkzQ09NemlkOS9Dc3JzNVRXTFJJcmlWNkpMZVdSbGRORkNIbVVxZytrTUhX?=
 =?utf-8?B?ZTRkQzkrYXpDLzNEcnUwd1ZiU3ZYLzdZN3VkUjhNMk5Ib2JVN0orYW50amtF?=
 =?utf-8?B?V0x2cGlhaG0wTkVSMDkwM212eENjaWh6NmtVaFF5K256MVEvNEoweVFXd1hE?=
 =?utf-8?B?clF2S3RycDFrblFaa29Kb09zbEZhQUtvWjZ1b2FYOHNTY0xRUVZsSTFoSWI0?=
 =?utf-8?B?ZDdIMTFoSkptUEdOTDE5V2hYWHJvN29kSGFoUnpvQjk2NUMyTXBBVTZQWE9E?=
 =?utf-8?B?dU5zTnpUby9VTjg5UFdWY2g4Y0tjTVpZUG1pYi9kN3VUMi84eTVEVml1U3FN?=
 =?utf-8?B?TnNwV09SdWw4RXZFNTBTaS92VStKaElnaDNVQzQ2WDJvMEl0WXplOVRITHR0?=
 =?utf-8?B?eWdHU0Mzbjdkb3pPam1Zcm5ENHA2TEVER0RXWXpKdzBLc0lFVFNTSXYwam1x?=
 =?utf-8?B?OWEycTNkUDZwbW51dVdIaFBUL0tMVjhLS1VWdHhyWUlUL2ZVOXZudDRoSm04?=
 =?utf-8?B?WG96eXpXTW5uWmxzaWtwRkErbW1TK3dWVlk4Smt1aUpoL01KdlZCK1NxcEYx?=
 =?utf-8?B?c3dyM1N5b0FRKzlnVmVnTjJWUEp5Y3ZqQzlpV1EwNGU4VkZUNzBUVFA5QnVS?=
 =?utf-8?B?MTlWN3BEUHBYNlgreUlhajNXOTJ1TUpaQXU0TnlIR2wySDNUNllzSTdnK2x3?=
 =?utf-8?B?TWpySmJHU3hscVVER1l4NGpPQlNOZklnMzcxUytTL3pjSVMweFB3VUd2RWhH?=
 =?utf-8?B?UUNBcjNISzczaGUyNkYyZ0U2ZHhlV0VrWklWbnVVRFVZdDBnNDU5NExwcjM1?=
 =?utf-8?B?M0hJMDk4RHF3ZWZta3ZaSlFjeGZNbndEeWM1eDcyTThGZDd0TTYybTFBelhL?=
 =?utf-8?B?ZWxpcnlleGhEWWp3N3QvWDdobSsxa3FmakliYkZHelZ3Sm8xTTRGWllHSW5k?=
 =?utf-8?B?U3JVZHlWWE1aaDF4dktncGU5T25BM3FNeVJ0VGJMaWlWc3ppaGdVYmVFL1VT?=
 =?utf-8?B?SkhxZlM4NmxCdTFNN0RoUHBKby9jdVZOUUI3dUl1Y1VVYTBLcSs3aWxPeHNT?=
 =?utf-8?B?UlZUZG05Mm0xa1lHbjB6Q251THhkVDRtaXJmQnFRT3htK3hQVWZab0VkZGNL?=
 =?utf-8?B?WTNvb1FMZmxCbVJHa3F5dWNxTm0vWUVhQnEwN1pkZktHM2F5WDVIY3BCdTlG?=
 =?utf-8?B?c0FMa1JYbUhRK0FNQUhTVmV4SXVNbkVjdllkV1NDVStuTStaQy80MGlHWHl6?=
 =?utf-8?B?Z2VMMWdOUXQzdTVtYVFUMWY0MmlvQnh1UG43SUN1WjJReEhxWVEwT1Z4REZB?=
 =?utf-8?B?U3l5M0pLVHR4UzBzcUtVVEJSbDJsc1ZBMGduZ25naXFpN1l3VkIxb1NETzJh?=
 =?utf-8?B?cWI3L1I5V2t6N2ZWVHVPYjBIQngxTjJsZ1ZHZFBmOEZ4RWE5UnBZQ2gxS1Jm?=
 =?utf-8?B?UExON2tQaEszaFc2b1l1c0ZHd0d6bFN4YlJxdkMrREkyVnpYekNOck5sVnlL?=
 =?utf-8?B?UHg0V2I3QUYzV2NRWGo1TGNYZjNKUzM5eUduVkFyZmF6OGJXblFyOGJ1MFNs?=
 =?utf-8?Q?iO8pw0d3d44Lt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei9GTDJNSytLYjQvVDdzcDhCY0REM1lRaWJPd04yRFhLWmJzYzJOMm9vayth?=
 =?utf-8?B?ZmFpbmdYenhxOEs1RkdSeEkxM0djTTcyVTFvcUc4OGlRTTVQU1N1N1pUbUtm?=
 =?utf-8?B?WlVFMzEvZmN0S0gvZHZXN0lCY3pyUWZ3cGRxTER2UVBRM0RsSzVlWW5NRVdo?=
 =?utf-8?B?Z1hEb21NdU9TK2xmc0s0REZQcmZ0Zm95Y3ZDL2E3aEVqUWU0UDZ1WFM3UXp0?=
 =?utf-8?B?MmlaUTZvL0xTYVc5WVNlbDVQRjVCN3JkR2xJN2h4WWZJT0hXNzBIL2NlQlMy?=
 =?utf-8?B?RWVhSE5nZEhSTjNmaUcwaXFRNitqQjdVblhjdU1sNEpIcXRyRHFHdVVvNEtp?=
 =?utf-8?B?dlloSUR6QmZaR3ZKR2VaR2hDRFpsRURFYUdCSEU1M2l6VTRzaG5sTTc1VjBZ?=
 =?utf-8?B?SDFnbWFZWllRVlNBTDJmTUJrcm44a0dQbmh4MzZaS1VJZEpaUFVHdFhXa3RQ?=
 =?utf-8?B?ZjhMSWZtUGt0TmExR1FxcmZoQ2l2cTdBRWo3d2VrbWhWcFFCaHV1T0IrUUht?=
 =?utf-8?B?b3kzMW1IQXdqd1VNWDRwQWhBWHlxY1Y2WjF5YU50Tm01emRmSEpuRGRqS0Zj?=
 =?utf-8?B?OFhBNmtleVNmU01sTHNuQWFXcUowVjMyQmN6MXRydzROZUZmWUk1RXpTVUZR?=
 =?utf-8?B?bUFDN1VjUVJMZU43SWFReG83S1ZYeHdqZGxpUEQ1WEZXWDgvWTBGMUYvb0Jz?=
 =?utf-8?B?SktDVFJZTW14ZlNHM2wzQllhamdrZVRxbGJnZmc4NXZWZkF2SnZYenpaZWhw?=
 =?utf-8?B?QWV3NE5xNGF2MEtzN29GMFFWUTF5a0tOUHJrMXN0V2hZMDNyblR3OWcrODgr?=
 =?utf-8?B?TmZpVnQ3bDgvWXpVK0VBenB2M1Y4U0hUWlY1TUZUZDloekUvclZyQzByaE9F?=
 =?utf-8?B?YndHQ0YrQml0ZWw1aDdGcFBUK1NLN2ZXOUR0aUJkcXpVeG1oaC8xeVczcGFI?=
 =?utf-8?B?UVFsODlzUnpocU9yWWF6WDNpMVBOLytXVFljMHY4SHplY2g2L0FMWERCeFhv?=
 =?utf-8?B?RXUrQUwwZUlNSmZjZWliOHNtS3dCNUhqVDJORzBqSWpNWmxzRjdrbnZDLzdY?=
 =?utf-8?B?V2w4dzc3OWw5RmIwRWhxSXBVK21sWjNsR3FTUEJLVjMwNFF1NDBaRkVNeGRX?=
 =?utf-8?B?ZmkwK0pvd1BDVFA3MHVJanJWcytCb21nN0sxUkV2SlhxQm14TnR1TVh2L1F2?=
 =?utf-8?B?NXJ6VjZFcUFkeXdpWm1jK0tLZ1ZreUFmM3c1bEJWOW1LRExrR1piS3U5Q01Q?=
 =?utf-8?B?U0psbGoxRjY2OFkxK0paYUZFV1l6cHhEQ0NONGVrSFhCUXFkWUVHY2NaVWVE?=
 =?utf-8?B?TWp6Yk81cE8rVVRxV3pvTEllY1p3VUMrWFFheUwwbDZqNzdsTTJIYkFrTUV5?=
 =?utf-8?B?ZDJtdTAxNVF5a0krOXpuYTN3TTdib1lBN3NkTnpDaTlMUHBRZ0ZzcjErTndj?=
 =?utf-8?B?NnNERElaTjJGZWpGK0pybVhCdFVNTkxsYXZEYlVyZWdxTlR2U3lhUU9uYkV4?=
 =?utf-8?B?QytKVldWQmFscGM2eW9pa016U2Ixb2RwZmN3a0RLcEZqTnZaNVF6VjVvcEhZ?=
 =?utf-8?B?SjZmbDF5bGJlbUhsVWxIZWtDUVkrUzh3eVlVYTl6b0FWeFFTRjd5WGRqanpD?=
 =?utf-8?B?TFc3MFJaZzFTeTdBMmJqREdlcFl1S25NZVR4a1ZWS2UzaGJPcWRDRTg3c2k0?=
 =?utf-8?B?Q2ZvRzRzOEVaYldkclBjeE16aklIMzlmaEFUWi9VMElOcEpIOTUzNnRqaVVQ?=
 =?utf-8?B?enc4dUFpVVNPUzdUSmtiNW5MM09zWVB0dHNYWlpQWExaOUI5VEEvWkRNd1BK?=
 =?utf-8?B?U1lFVkJPZWJuMkIrNEFHNkYxRkp6OXowSUM2OHpDMjlQdDhVeXlqNkRqQ3Ux?=
 =?utf-8?B?QWoyZ05aM29ucVcxdUwzOFFBZ0JENTJSTFIzV1JmOTBhVWZ0Y0Y0Uis2a0g4?=
 =?utf-8?B?VXFuMDh0SDZXbVl0ZlJjM1V5b0MrZ01BaGxWTEcxejFKNkFDRFpmSUFLcGhP?=
 =?utf-8?B?WkROQTIzekt2eWV2NjVicWVXMlR4U2F1ZjB1ZGt0L2VhL1gzdjlhbW1oaWpW?=
 =?utf-8?B?NzNrVHBYTjdxamZjTDl6WnJqVEpzV0ozdlBCTnl1Y2tHNk1EN0VFWk91blFp?=
 =?utf-8?B?eUo0VEMrUGk4NzdiQS9sZjZ1TU1SclVxOFZsWFgwOEpKODhocHBLUWRiMnk5?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PeaFaE3WEGmoAVPh/C27K39gVAoxkJcqT1t/RndhYs0ax8ASTIIueP5r0e9Ke3yYwjjrQOItf9CUw0TjyHQRiC75FILUvsaUWj9Wevvug6RTbSEPxU5NbfEbjoBxSNvViCDblVE8N0/rLAilV1MjBghwVPMgfyYcMDciEMLBE7hJ9wH/I1pSqubtTBIj+NyqUjS3jfDLzQXnCndhtOflHTgbtGAY0ucA5CGpbTMKamJ6c+wwP71mwSP0wWcBMDWNIKbdxynrOfY4vRfGkk97Ev4A6qqxx6z8lFx6AFexaW3GClbda3q2oTr/7WPKfUq0Jtueaj6D9qxY+B1HldEa8eEXoe6dX81wCxgX+GboNIgRkzx8IA/L1zieninOb56FYP4UiM6cJTV3hB/QV6qngQ423Pdh9pi7B6eDBZsvSGIVJ4EQh6aeZ6PpZuuOlLrsg7UaDPL/d01CDtf1VjlJA66CJTA3jalZ47d8n+NyOBs+csLskjxOqWPzAtJTgxTVl64qftXpGefQacmdgkESDmzWVNAXFlDTpZq0vMcU807vFjN8kry7zVuNmhc+yrmYBf9stS46tj5+xDyNBYFbnXC8GnYL2sL16ef6yaBhcdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240aae7c-111a-4a51-d93c-08dd562a81e0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:57:52.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IjdAgxDyMavI0LHZ14aUv54mJmOWZibyU+X8snRk2QWqNBAW9vC8deaVSoPfdQEdB/2w7Cigto3/IdQ43YIwUkZbmF/B0nkkDhJPl+ibAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260045
X-Proofpoint-GUID: JjCTJUdAMDhjAadAGkQDOQI-i1GtjMbd
X-Proofpoint-ORIG-GUID: JjCTJUdAMDhjAadAGkQDOQI-i1GtjMbd

On Tue, Feb 25, 2025 at 04:06:37PM -0800, Jeff Xu wrote:
> On Mon, Feb 24, 2025 at 10:24 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 10:52:45PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Provide support to mseal the uprobe mapping.
> > >
> > > Unlike other system mappings, the uprobe mapping is not
> > > established during program startup. However, its lifetime is the same
> > > as the process's lifetime. It could be sealed from creation.
> > >
> >
> > I thought we agreed not to enable this for now? What testing
> > have you done to ensure this is functional?
> >
> I honestly don't know much about uprobe. I don't recall that I agree
> to ignore that though.

OK sorry I realise you have done this from an early version of the series,
my mistake! Apologies.

I'm concerned you don't feel you know much about uprobe, but I guess you
defer to Oleg's views here?

If he's confirmed this is ok, then fine.

>
> As indicated in the cover letter, it is my understanding that uprobe's
> mapping's lifetime are the same as process's lifetime, thus sealable.

> [1]
> Oleg Nesterov, also cc, seems OK with mseal it in the early version of
> this patch [2]
>
> Are there any potential downsides of doing this? If yes, I can remove it.
>
> I'm also looking at Oleg to give more guidance on this :-), or if
> there are some functional tests that I need to do for uprobe.

Yeah, apologies, my mistake I forgot that this was from early, I thought it
was scope creep... but I double-checked and yeah, no haha.

>
>
> [1] https://lore.kernel.org/all/20241005200741.GA24353@redhat.com/
> [2] https://lore.kernel.org/all/20241005200741.GA24353@redhat.com/
>
> > I mean is this literally _all_ uprobe mappings now being sealed?
> >
> > I'd really like some more assurances on this one. And what are you
> > mitigating by sealing these? I get VDSO (kinda) but uprobes?
> >
> > You really need to provide more justification here.
>
> Sure. In our threat model, we need to seal all r-x, r--, and --x
> mappings to prevent them from becoming writable. This applies to all
> mappings, regardless of whether they're created by the kernel or
> dynamic linker.

All mappings? :P I mean I guess you mean somehow, all 'system' mappings
right?

I guess you mean that somehow some malicious user could manipulate these
mappings from a sandbox or such using a series of exploits that are maybe
more achievable that arbitrary code execution (rop with syscalls or sth? I
am not a security person - obviously! :)

And then un-sandboxed code could innocently touch and bang.

I mean that to me makes sense and cool, we're good. Something like this in
the doc, just a brief sentence like this for idiots (or perhaps you might
say, idiots when it comes to security :) like me would be great, thanks!

>
>
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  kernel/events/uprobes.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 2ca797cbe465..8dcdfa0d306b 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1662,6 +1662,7 @@ static const struct vm_special_mapping xol_mapping = {
> > >  static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
> > >  {
> > >       struct vm_area_struct *vma;
> > > +     unsigned long vm_flags;
> > >       int ret;
> > >
> > >       if (mmap_write_lock_killable(mm))
> > > @@ -1682,8 +1683,10 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
> > >               }
> > >       }
> > >
> > > +     vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
> > > +     vm_flags |= VM_SEALED_SYSMAP;
> > >       vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > > -                             VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> > > +                             vm_flags,
> > >                               &xol_mapping);
> > >       if (IS_ERR(vma)) {
> > >               ret = PTR_ERR(vma);
> > > --
> > > 2.48.1.658.g4767266eb4-goog
> > >
