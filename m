Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1127FD4F;
	Tue, 15 Apr 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709129; cv=fail; b=HHGbeC6FN08eeKsoC4NRp7xYaOt7c+LBVuU++5bnVNtSEatE2iFs3YfPu/X7LSYqOB7Yw2GbCK9ynfe/6sKixDn1rO3chRh2ObPjpVQ6/tlr4kUc5N6q8SJOUAfWaYGnCpxFxXXgzkyJxkpI4r2qr7O0mOGV5YzdizXPbHwwqUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709129; c=relaxed/simple;
	bh=er979pORSqrGBn+KMGs34YpF6RmV9O5iqyE3U37RYHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXwkoCXbY9EPz/jf0eedtiI7xs5oZfv52Emkc4bV4tfW1m+b8qAbH2ap0zcTFrtALR5xQ2GVCMLHMP4kNcnwDIgPjlvmcxJ8dAjBrSsZ1S4Ck2WMhXGzKkld92r27HlX1p1dq/mPxHSRZEncgncKce+oa9gKJfWAUkdUKEp0amM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hYvFfNeb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=d2ZTcnij; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hYvFfNeb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="d2ZTcnij"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F4j5LD016759;
	Tue, 15 Apr 2025 04:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=EpveKrf09pVJBrX5Y5qiLrE3X0qBUjBr81AQ0Im0/HY=; b=
	hYvFfNeb9gwES26BHr/Bv2tUh19cJw6GrHrziYh+kMTzE2jBVQ2dXgL7vzs99ntT
	RSNzg3vcVYZgbmYL/IUOXlDbWiZot7MQSc8MbXzDyUB5X02DZeJSQh92yJ4Oae0t
	Ihk9m8rF2C9nsSFeZ4R73GZhu9r6NBUrWmRExk7oEcBEethTPShz+jnDa9ruC2CN
	XBURv/fIvXCURVbzlPD4f21nwfuFSaRzcqBo4RtDNN4ChxKmfcMI1noq9/kwNwS/
	J9tzviOhF+UQKEb5E8FP1m2UjBZXrhu9VTw6tn5vFRXQOuGvdj+WI5rlO3PHsJir
	Q+uMpQ31juZtUa8KXnqJkg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45ymkgub0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:24:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoFzWcEKJxNlCEooqGsAAaxvnZGDhbKLS3+Sqh9hFbBFvQyzR7P2N4rBtG0o6BS6dgcvdvpTsWzmzPmdn/xDMw2SI1+hvdh2LcN+dIc2yFtjZD0hvf1J3jPjVdZhlM8e88v3HzH0zLdJk7BIJcw8KJMMRvpO5A2+O3E16itj53r2FBE1fcTJ7rQaJLH8j+ISHewEStthTtB1u/r2Z7Iw9gJxJJCbkq+6XSpTP3atREsuAYPNDVK4L+yC9drrmJXzM7/9Xjqp6iNiDhykx+OjKFatk44xajXe6gBtHeHNY4qSQ68U9/Iek0bOhBdEA/bpRFCoqWtALUVfoIk54Hatbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpveKrf09pVJBrX5Y5qiLrE3X0qBUjBr81AQ0Im0/HY=;
 b=gqagTiwkEioLk+5q9csnIRABBudBzqVYNwC9VpC6Oasfb/nTvLn1053tFR6N/8A0z/9meHjldTwDS5NvrSZbGcYB4msW59/DieeYb426UZhi/rW3CI9wbvmDGl2L1GXzV6h3kVJZt5OmoCsRmUdiwnkPe46Yn7SsNfeV52GL+4UbrF7/AEQEi7NyfDDLz6IsJ23CzP+TpCn0D+PWDv83E5I4abyX804kt7w/5N0c6oX+67LUuXMvKvJLWZ7JXYidtvsVX0DgAy5J8pLx4h/cp25x2Z4oikynYVidjLpJin2Fawzs8Rum4zJXSH/7kN5tExmTKV4Yo33E/kpFIsS8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpveKrf09pVJBrX5Y5qiLrE3X0qBUjBr81AQ0Im0/HY=;
 b=d2ZTcnij5yiBRQsw+X/ArAGaE/YwWnmxgztrmbaYDy2xrUvIO6GZJAQmKdq7iCxUv6leHRB4ZsH/Ep4cs/eiQaj+GdkuOuOObGj5mxiXbmNQFclJtDG7MpRcaPw7Ed6klMM7vDOv7F2R4kUH6if222PY/Uho/0dOr4HH/vMUMSc=
Received: from CH0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:610:e6::15)
 by SN7PR19MB6924.namprd19.prod.outlook.com (2603:10b6:806:2a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 09:24:51 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::99) by CH0PR03CA0280.outlook.office365.com
 (2603:10b6:610:e6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 09:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 15 Apr 2025 09:24:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C93E6406541;
	Tue, 15 Apr 2025 09:24:49 +0000 (UTC)
Received: from [198.90.208.23] (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B1576820244;
	Tue, 15 Apr 2025 09:24:49 +0000 (UTC)
Message-ID: <e16b42f3-cc78-49fd-9850-d59a59b5b8e8@opensource.cirrus.com>
Date: Tue, 15 Apr 2025 10:24:49 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs-amp-lib: Annotate struct cirrus_amp_efi_data
 with __counted_by()
To: Thorsten Blum <thorsten.blum@linux.dev>,
        David Rhodes <david.rhodes@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250415090354.92211-2-thorsten.blum@linux.dev>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250415090354.92211-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SN7PR19MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fa0a8d-769f-4cbd-4e08-08dd7bff5fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGE1ZC92bTUzVlpZTis2RU82THdBSHZrZ2pqSWJMTC8veDgrZjRvL2ExbDdD?=
 =?utf-8?B?c0swZ3ptVXBhaHhkZ0EyeVd1M2wwdGdBZDU0S05lcUd4NUtML21VZ01nN3Bp?=
 =?utf-8?B?dUZNWlUzTWw1eDVnVWhnWjlDOHhMcDdFM0dtNUVEQy9nSzFCRTYybnJldTVk?=
 =?utf-8?B?Y1pCRDFQYTg2Mm5HdWpHUXF4WlJvL094RDRTY3A4bThSMElnTUxUOFFpK1Jl?=
 =?utf-8?B?blhVZ3JzcFI2UUVRbHQ1WnR4b255aWsxVzBDTG43RTdGK2dIR00xb245L08r?=
 =?utf-8?B?MXpUS3JnR2xmcWJueHN5ZEo4RHlHbGlYdnN6NzFYTUxWMUVXNVdDNFloL3oy?=
 =?utf-8?B?V0g2VkZjR1loT3hFdUpOYkFJazBTSnU2VzlGLzk0YzJSdVFHbXEvQmFueEd3?=
 =?utf-8?B?Sm94Rk42TUJVRnpEU0lxakxCakxmRy9uaG1ydVU3WHlHTTl2dTIxMXRIK0Zr?=
 =?utf-8?B?UGVwbkJHV3NUYk80Y3JyVXF1bVIvcWtndWErZFloNytjVW9FejVTbHNtdjBZ?=
 =?utf-8?B?YXFEQ1FLWDNUcXlnMzg2UUMyenNUS001U1JLQ1V4bTc4NFRCcTZDaWxCQnpT?=
 =?utf-8?B?WFh1QUlHUFNFZE9CeUtMS1FEaE5WeHdEZGw2RlEwM1FVeDFleUxLRVdzOTgw?=
 =?utf-8?B?UU4yaUl1cFk0Ni9MNmZqQ2tTNWgwT0lSU1lEYXQ5bW42OXJqMnR0U0hZdEZF?=
 =?utf-8?B?bFpvMHEvZjVHaTk1cEoxaUxYeW5KY0lwWkgwZE5wbVZhMnpVRE5aNDBFSXI1?=
 =?utf-8?B?L280ekVSWWgvdWt2eXQ2UXp4WmMwemdldGZKVWs2UTVaZTl6dkh6UWhKZzlm?=
 =?utf-8?B?ZUp4bHBzZ012RXYzcDV5dityTVl6V3VQbXQyQUp0Lzl0RFJmRXRJTXVUcUZO?=
 =?utf-8?B?dTZ2YTM4MUROdGk2aGV0dTVWZm5zRldlK2hSZE8vTStseUNkY1M4bVc2aW5t?=
 =?utf-8?B?RGQ1ZERFVXZtZ0wvTUJYbVM3MExodm5VZXJkazMrQWQ3Tm1vOWNkQTBnOVdC?=
 =?utf-8?B?dDJER2d1UG1uSGR4SGtOTVg1eEhwSjQvRi9UYytBOENiZzIza3R6VEdlZEJ5?=
 =?utf-8?B?QUlTbmVMUWtqRWN1N090eU1kUW94S0R4bm5FS2lZYTBsdHZEYUd4TElaemNs?=
 =?utf-8?B?Qzhsd1F0dEZDd2NtUUlTNFEzbTdNTGF0N1hvbmlvdWVCZHlxVmllS2xjbTAr?=
 =?utf-8?B?eHA5THp5RUlydHB3RUI0Wk1RTXRLS3R6R2prcjRIS0RWMGthSTNjVEowdmQv?=
 =?utf-8?B?d29sWEJpRjdqY3Y4Nkdua244dXRFRmY4SVZFa0QxeTlvZE1qSi9nakxoZ1hE?=
 =?utf-8?B?dlVGSC93ckhFWVpTckFlOHl5NVhRMXBZMDJFMC9NYWVNZ1hxdTZzNWhacVJz?=
 =?utf-8?B?dE1VMVp5V0Vzc3kwdUZIazJLUGEya0k0WVlVQlBZZXE1dXQ0VmhES1dNeEgz?=
 =?utf-8?B?aXFNaHkwbkNDS0NEZ3J5RXE1dEZTVVhmZGc3dnB3NVk5ODk3MHpSVXkxSUs0?=
 =?utf-8?B?UGM4MzlzdERVN0ExSzhPenJFVTBFNjM0Sm15REQyWUVML1RuTTZVUmQ1azhu?=
 =?utf-8?B?WTI5Qi93aFBwUnp4N0lsWlZhRDlJa1ZhdnpUN0hhcmxqNU1YNmR1N09DRzRE?=
 =?utf-8?B?R29paks1WGoveTdraTlLc0NtSjdTaVNXbXd0UEMrdk50TlRMelEwejBzUGY0?=
 =?utf-8?B?WmtRMzRmSFNHWlJaaXVTVjBScTBSN2k1Z25raDRjOXE1c211dVpMdkEwMSta?=
 =?utf-8?B?TGNkSlFyTENZWnFQN2pLVGNBL2J6K0JHVmlWYXB2RWluRW4zQmo0VFM1Um43?=
 =?utf-8?B?STEwRzBrUFFqU0R2a2FMaDBqVVVpNE9JQlArRjAwL3oxdlBCT0NKOHBJejEz?=
 =?utf-8?B?WkYxVW1IVysyVXJScFpwVkNtYkttWHkwbFpoYUtPRjVrekg1SWlqTW4vQ0h4?=
 =?utf-8?B?WVpoSzZKVGN3Y0s0UE5WZzhQSGQ1dDJENDFqRDQyY1JEdzZOcktpNEtyTHhC?=
 =?utf-8?B?bktrZ211Q2dSNkxvZlhSWTJCUWhqdTh2Zm5CVTRjWlZBMGNkUWgwR2xUZGpR?=
 =?utf-8?Q?GA+1Me?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 09:24:50.9259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fa0a8d-769f-4cbd-4e08-08dd7bff5fde
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6924
X-Authority-Analysis: v=2.4 cv=UMDdHDfy c=1 sm=1 tr=0 ts=67fe25e8 cx=c_pps a=joO5rFOndlhnht97C4Lqsw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=ff1tQCNp9SYM1ZEhO9YA:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: k9BpjfE0d25efhoDBvdwtM6HxUj6TaWh
X-Proofpoint-GUID: k9BpjfE0d25efhoDBvdwtM6HxUj6TaWh
X-Proofpoint-Spam-Reason: safe

On 15/04/2025 10:03 am, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   include/sound/cs-amp-lib.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
> index f481148735e1..5459c221badf 100644
> --- a/include/sound/cs-amp-lib.h
> +++ b/include/sound/cs-amp-lib.h
> @@ -23,7 +23,7 @@ struct cirrus_amp_cal_data {
>   struct cirrus_amp_efi_data {
>   	u32 size;
>   	u32 count;
> -	struct cirrus_amp_cal_data data[];
> +	struct cirrus_amp_cal_data data[] __counted_by(count);
>   } __packed;
>   
>   /**

I wrote a patch to do exactly the same, but you got your patch out
first! It is identical to my patch so:

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

(Note that I did some testing with Clang-19 and the __counted_by() seems
to only be checked in certain functions, like memcpy() and memset(). The
get_random_bytes() used in the KUnit test can overrun the array without
triggering any warning.)
