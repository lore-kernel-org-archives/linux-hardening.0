Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB3C199FAB
	for <linux-hardening@vger.kernel.org>; Fri,  7 Aug 2026 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063112; cv=none; b=hUcrmJnxqV7m/bv4obXQX4mK6pOiQOjJ3MqCquHqFsy6v7WH9NfXPOb/dL9C5H/W+xyDP93jnsV5BSMtrt0eC2Xv40zIvAnVJaX/DOfXNDagJXgVBx4HNSA6y+kFpoSRJIwRUzyz2fLqzT4fQLSusJpfNfrP0x0G8eVIfaf+ypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063112; c=relaxed/simple;
	bh=dsWMhdIrqSK6WxQqUiMqdWFZLYDnTD9M2oM1sYypADk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCs5GzeJvuPJHYktNGA/jKE7CCzQMb9Z8A0to27r1SgrXq/6VAr2sPGw+LUlVnoSDrezaQNkWfupN/WQi3ljpmDNk3442w1jt7n+IIPlO/bydggf3ZSldiXwwnxVEewul1jDRdJpSw9uF1N0hZCH9rZXubKzzsQbp3JLeEWXIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lWxfGMft; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TITZg+4Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lWxfGMft";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TITZg+4Z"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Gls03218076
	for <linux-hardening@vger.kernel.org>; Fri, 7 Aug 2026 00:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JY6AEkRNUFU/eSw3bdP8Dhft
	bSXAEXPlKY7ke5titbY=; b=lWxfGMft2Mxn5rO6npfQrfmWwzbDbl0mNP4X/Gv2
	GQPgKfxuuS5jHPPG8KM2tHlIRaHVqQsD8uW+T732mKnonUdLtisy0mc+t4YbVY8C
	d1/SeNxamkuw9I1+8laLfaaZ0iqIKfx+EaRdVJ8Zq11TIIbSfK7G7HXPUgfrILY7
	Ts2sSV8YGNcDEksPqZBWaceYqlXgN2ERMlhMTRfnFNrT6NNK+SuMzCP5ogPqi264
	Uz/JpEKkiRmZIM1IKk+LqbKW/QYRxgJym2r3wjgXVLSAvwS2CxP3rc2jFk7Uio6+
	iQ9m9Kfc6EJETQ6JZMGZIQzfDy9M1eFEpExDbof2v64Nqw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hse7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 07 Aug 2026 00:38:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb6433e9d4so3480396a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 06 Aug 2026 17:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786063109; x=1786667909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JY6AEkRNUFU/eSw3bdP8DhftbSXAEXPlKY7ke5titbY=;
        b=TITZg+4ZRe3CDND7M5ejwEANPS5wn46rBf1ASzUejOcriqTBxopAFUE86J3G/Bf2zc
         k4uJIHKdbuXRO3Q6n3iggCh3aA0CcU+Xs/4jdRmyhGhThGMoC1SoIh6UZJdmBnjAANdL
         RCHEwjoC7hPSIWDb1u+tZeWLLpSQgZnAokHkvCu53CXzDBOzpGvCsijbyHwkb/rYv05Y
         upBw4SQpCRHL3YfLo641NJM43LvpHV/OX+DjsvOzY6zZm2rdtbESBKW8jvfLY+N0VVCP
         d5gm8KTbkjVahJ5Xh13Cyj/miTfx1s++cGOLizMqQjmrxAVbHXOrEZ8re8XVekGfErmz
         Kv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786063109; x=1786667909;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JY6AEkRNUFU/eSw3bdP8DhftbSXAEXPlKY7ke5titbY=;
        b=H/TLejNBXc5WjfAnCSTesDAnQHp3CV/BdsI61kbm9pFCsy/LRh/IRuORnbwuggPGsM
         d5zokPpp94TemwTmMvCCuMZKdQMAeLhqJzvoKNB8Ry+d4Gj9ACRcemsSYY+nm49gBWKF
         xiDCzEZWUcuRsxDCuwmOvN4DhTLUcXTHTkluZZlZl95lXk7vp13EJeoys3C4Nck+qNBU
         2/E8+tdCevbCmbtRUQQtaaLSuTwrH9ycMxSv1jZ5j0+L6LFmYqNy50kGYx0AheWZAp97
         QBKSaKr8ukY0Nj/c0KuUNDyTNgmQVonjz07Lb+t8WoFfdhNWAje/MQ+upaec1DVXrt5G
         NoJA==
X-Forwarded-Encrypted: i=1; AHgh+RqFAS/Vi2QxauyHrqgcbH8XWd0qOSrngO7rSASwf12B/wmp7vp9fuNw3A9HAU4LDb7TrvP9dgSCbgt9Kwge4H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC7TkKHk+H8kKohuKyRfx+uYHjA7P9BqbR8jodfqklR4l68yck
	Bc4KKQH/xOWKrXi3YIqtRd5/di8LrgLk2lYlTHUObwOBk/B1nk6uEts7iYRo3vGPQw6HU5TNPiW
	uCeeFc8/cLDmfSqS4/RyXx5DJhywrZianxHx5ymCOrTxmY/mz6szqV3aheauenjeMJshCX9A=
X-Gm-Gg: AR+sD12ALSp3m+5JvISm+PuWdBVMpPaTTKWPuLc+7M4OLVj6WprZh+xW+QCFzefLhT5
	5cRcqc2/BNiM3VZPuUq1y/NX9Ndqoj0qGvRcSGqGnP6sMhSA17gN/DD1sLTtc4Lhb/6Zrqi4NMh
	eH5vCR1YHSJmk5Y5VIEvNXJM1bFjcenrYiyn6V8oN6ob2KlQ71x+nx57iOW1bytz7dJ49rTwPCS
	9q1o3xOFmWDzI+oe1RHuYYEdKxLTrXuwFaFnA5RW/EpTpY5h6ibHVF40oO7H1ewJriXweb/BR4o
	s4AZ0UNE/gTEC4WuxqKDmQ3Os7pomG/DyTCnqy7Ls4vzRNEP5BgYtWXtXU9y9zKMHlOIevT62XN
	HBz8LH7jSKZNtivEDPtlt7urAhPiiZssNLT43pzbFk3J+Sh6yjw==
X-Received: by 2002:a05:6a21:139a:b0:3c3:c07b:5322 with SMTP id adf61e73a8af0-3cb8602693bmr24170266637.34.1786063109211;
        Thu, 06 Aug 2026 17:38:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:139a:b0:3c3:c07b:5322 with SMTP id adf61e73a8af0-3cb8602693bmr24170219637.34.1786063108809;
        Thu, 06 Aug 2026 17:38:28 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e90asm648336eec.3.2026.08.06.17.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:38:28 -0700 (PDT)
Date: Thu, 6 Aug 2026 17:38:26 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, tony.luck@intel.com,
        bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
        xueshuai@linux.alibaba.com, lenb@kernel.org, kees@kernel.org,
        gustavoars@kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/3] ACPI: APEI: GHES: Refactor Grace decoder helpers
Message-ID: <anUpAigVklVNG7ij@hu-ashoraj-lv.qualcomm.com>
References: <20260724122054.36162-1-kaihengf@nvidia.com>
 <20260804122318.88193-1-kaihengf@nvidia.com>
 <20260804122318.88193-2-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804122318.88193-2-kaihengf@nvidia.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDAwMSBTYWx0ZWRfX4xtkXdqu7ewW
 n9lx1DD2K9kODwK1fjhY/Fi7bESTlkyu0wJEqU+IPKKHYC2MXmYO2iwStYdbR8gzVF/8596Aq/2
 yL0SL1Zt/qfMODpnUlkqOkdTvnZ+tq4=
X-Authority-Analysis: v=2.4 cv=PK0/P/qC c=1 sm=1 tr=0 ts=6a752905 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=u8maBWZV0gvdrbkAJa4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDAwMSBTYWx0ZWRfXx9P/mZKXKH7J
 VTdNlT2x5bPr6Ol/iPl4YxnCYgf9+xz8qngPtexazjHHgiAZR6K4q+TzpkWIGBQKHtsySxoLAGB
 NrtOO4SVnwfU7OoTWmsMpEqWFvB24DokQ87LuYhTxFJD0+KdYSIgbxma48NM3wGMMcTmdmrX1uE
 +FQl/VYD46eDjeWRhDswQENiaf6R1OlOODwB5aRBvwlbpLf/4otSSXc8OlD3qrh7x/5hVA+Jg/v
 sjn2AvJP9L5YhlGOk6YOD8iu22/2kZjkACT/CWLKZK2oLIxcLPvPZ4PnFa2/CLxVaiHeZTc7DZ9
 E9u4Ld166p6Rr1ywYzmn3cegPenwbN2pIG7OEtahE5EdeuSzW2i51k2pfYHebbfeOjPkoC6LV8F
 f4C4D0oEY3QspBwOl+JQj+QkOyK/nP3EgEyMCrzyAxOdKXeanF682Q91Dok4oMbIGoDTjof3oZp
 INUsno86op2mnsNKbvw==
X-Proofpoint-GUID: pPuslyM-Fpt-Xv7FFCZgJbqZcYEirJwV
X-Proofpoint-ORIG-GUID: pPuslyM-Fpt-Xv7FFCZgJbqZcYEirJwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070001

On Tue, Aug 04, 2026 at 08:23:15PM +0800, Kai-Heng Feng wrote:
> Split the Grace CPER processing into a separate decode step and a
> print step so the parser can be exercised by KUnit without a live
> ACPI device. Introduce ghes-nvidia.h to hold shared types that the
> Vera decoder added in the next commit will also reference.
> 
> Parse the Grace wire payload with __packed structs and
> get_unaligned_le*() for multi-byte fields, matching the Vera
> decoder style. Reject nvidia_ghes_grace_reg_pair() calls with a
> non-zero register count and a NULL grace_regs pointer, and
> rate-limit Grace decoder diagnostics.
> 
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Hi Kai,

> ---
> v3:
>  - Use __packed + get_unaligned_le*() for Grace multi-byte fields,
>    including register pairs (Shuai Xue).
>  - Keep __counted_by / struct_size; reject NULL grace_regs when
>    number_regs != 0; document the helper contract.
>  - Rate-limit Grace decoder and notify error messages.
> v2:
>  - No change.
> ---
>  MAINTAINERS                     |   2 +-
>  drivers/acpi/apei/ghes-nvidia.c | 160 ++++++++++++++++++++++----------
>  drivers/acpi/apei/ghes-nvidia.h |  50 ++++++++++
>  3 files changed, 160 insertions(+), 52 deletions(-)
>  create mode 100644 drivers/acpi/apei/ghes-nvidia.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5114e6db7307..aa9c2ae58ac5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19348,7 +19348,7 @@ NVIDIA GHES VENDOR CPER RECORD HANDLER
>  M:	Kai-Heng Feng <kaihengf@nvidia.com>
>  L:	linux-acpi@vger.kernel.org
>  S:	Maintained
> -F:	drivers/acpi/apei/ghes-nvidia.c
> +F:	drivers/acpi/apei/ghes-nvidia*
>  
>  NVIDIA VRS RTC DRIVER
>  M:	Shubhi Garg <shgarg@nvidia.com>
> diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
> index 597275d81de8..e7cc912344fd 100644
> --- a/drivers/acpi/apei/ghes-nvidia.c
> +++ b/drivers/acpi/apei/ghes-nvidia.c
> @@ -9,13 +9,18 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
> +#include <linux/unaligned.h>
>  #include <linux/uuid.h>
>  #include <acpi/ghes.h>

One naive question, do these CPER decoding for vendor specific pieces
belong in the kernel? Or you would manage them from user space?


>  
> -static const guid_t nvidia_sec_guid =
> +#include <kunit/visibility.h>
> +#include "ghes-nvidia.h"
> +
> +static const guid_t nvidia_grace_sec_guid =
>  	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
>  		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
>  
> +/* Grace CPER section wire layout (header without flexible register array). */
>  struct cper_sec_nvidia {
>  	char	signature[16];
>  	__le16	error_type;
> @@ -25,84 +30,137 @@ struct cper_sec_nvidia {
>  	u8	number_regs;
>  	u8	reserved;
>  	__le64	instance_base;
> -	struct {
> -		__le64	addr;
> -		__le64	val;
> -	} regs[] __counted_by(number_regs);
> -};
> +	struct nvidia_ghes_grace_reg regs[] __counted_by(number_regs);
> +} __packed;
> +

[snip]

Cheers,
Ashok
