Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E682BD11
	for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236119; cv=none; b=BBT/HPLdqRONiHCB2i7vA4ZP6P2VR5s8Wn4PUOqfcl9wST3MR2iuCGiabYZ4zRll5uQTJQLUV5Wjpvyk4OIebZSVEehmScI0sIWSzqjEjyCyoXHhr5SIuvi/fJCV0xdJ9fk9lUhlsapqfls5Lyd6ozhm2NC0RHlYNVJj9OFtMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236119; c=relaxed/simple;
	bh=5gZSMGQXg8tquDZUHTjwonp9XgiymACki5PrRI0VGQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvSpTO/df/O373Ksj6uNzW+Erf49KR4KVp+6eQp6P2w50bYe4YNKJpBFT6x4k5HtfnAfX4hjIiCnGZEOmWgDR+Hew2ZHOUOYff/R/jerDRsuCDsCt2xfk34hgS8Msd//hwV6+CwCtNoyHharnjBzVMO4GouFlv1QgIjl9+KZ4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BvIbudgq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BvIbudgq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AKKnr3017425
	for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 01:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RpKCKjeAbIqONMFiJVjOlSnMTDfFUoERYTpc2AfR5UM=; b=BvIbudgqxtCpqPJw
	UctRfJH+t4FfLmbBS6DWZo9mMKVxF5V7lzk8yXZYKku9oAy3Nf6ldJRHQbz2kPv8
	9vMUCZeAWOvVectx3FNt0oFFcDj0UShnLZ8Ky62Fuqf288E/Ros9Hs1eINEyzOFh
	xxiwy10rL+2G8ugX/42G4w/ndw2vNLynDlZ+EY6g+vHkm+pa20AT7if5kCstvjPZ
	awy1/cXk0qNkAR34tEpPNF5zFTWw4NtuCUYcDce9RLZjLgbf+NcRzyJuYNrtlbHZ
	qkYE8gQOMqjoe0aVzNBa91jSEQTJCovtC7UntEA0FHevXah6jlcC0Pgwtj/19Ebt
	bo73+A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0gux1uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 01:08:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21f4f0570e2so100973725ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 10 Feb 2025 17:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739236114; x=1739840914;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpKCKjeAbIqONMFiJVjOlSnMTDfFUoERYTpc2AfR5UM=;
        b=eB/AKaFhGJKitFDVLNSKiv4c2kGoVhWA2ZX9g6a6A+g05bnBNnn8tVX0WglD7mGsxN
         Oxgm3ge83mqXXGlkSQXpTvoKlO45rdfqj2TdNxSIQHIVHcQ5r9zaInjeSlb4KB2FtxXK
         T4aIT14U1L906E2nL5a1dmIl0L103O2l3tasd75q6dmbfVitjSmRw7wXtEOlzsPzWW7p
         OdtMIiXaRcsYkt1vE9lNOhWg6ScZWcDZh/Cxm8X+iRMDoEgUwsNy5ZVNuZ5M1Kd/y0xc
         qxnRwPlNqVmKXyWQkRTv7D3uHtnFkSZv/W1TezBbKz2ycCYczD0M8dthSAXM+VamK5HS
         iV+g==
X-Forwarded-Encrypted: i=1; AJvYcCWhczUJ3zIt3PP5jhNi/DOKkJg+H6w8hkui4SFBq65dFqS+sH/dTSGJL+cBfUIpZvI23Ri4Yd+yyLliFzsJ4Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0DNV7wS6vR/WWtBZtHqaw4zH7vmRR5E1TP4EXO8LxQTfBBC7
	Zs8I0lAzw5NOEeIkY5n5aeqRXCK1y+eylLKLjKZMgQiN63YzAWWTXYeP5hYH/p7WeL1Ca+lvMLp
	jr4woX2nO7ZSLHSYzSJbN61rivvh+1rmPTlbeeVuR2YnYpMgCE+XYtBELjKAA16UEEno=
X-Gm-Gg: ASbGncuE6UmDbjvsHRIHCuolUJFuXRJqEAJu6H5FBu+6LhTew4eIpEwmOUkj5dAY7z6
	aiFExF28GjhwsBH7ZpWTXjEI40LU2ML3cxrJ3EdU7lIR3qSXVhDKCSbAMmKhY2ykynCjgHk9YV8
	6Sr3a3l3WuzWP7VGE16rdX6FG42ZAEeYLyDZ3+CJabiNcbJ/A2NNwS48BgD/U9sCtJf3qXisHef
	NJORchfG4nX/NOiTOmvsmfRkcDK549ZrsXnMRBVRN9MAaN5VIutJUBnybVHkmPIH7Noa/HQOG8P
	y0vNnPwKxvQ6IWuGtcQicKLgdEcCB79PzlvIvQGxNbaXxi2+sj/XaKqn4TEDJ2o8fLhZOkFAHA=
	=
X-Received: by 2002:a17:902:e74a:b0:216:4064:53ad with SMTP id d9443c01a7336-21f4e7ed222mr262295815ad.48.1739236113867;
        Mon, 10 Feb 2025 17:08:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/lVU6NZTzrLR3oJdGFyeLKiV8JfyCXjnYy2BiRewTlx0CpGjULYWYSq5eGpYAPKlbHbIRHw==
X-Received: by 2002:a17:902:e74a:b0:216:4064:53ad with SMTP id d9443c01a7336-21f4e7ed222mr262295425ad.48.1739236113498;
        Mon, 10 Feb 2025 17:08:33 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36560c94sm83817485ad.91.2025.02.10.17.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 17:08:33 -0800 (PST)
Message-ID: <a7ca4e4b-c432-4f2b-81c6-c7b06cd12de1@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 17:08:31 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix uninitialized variable and remove goto
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Kalle Valo <kvalo@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo
 <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20250209-ath12k-uninit-v1-1-afc8005847be@ethancedwards.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250209-ath12k-uninit-v1-1-afc8005847be@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wruwolPSj90FCdH_asnNAOnoFPNOE43-
X-Proofpoint-GUID: wruwolPSj90FCdH_asnNAOnoFPNOE43-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_01,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502110004

On 2/9/2025 8:36 PM, Ethan Carter Edwards wrote:

commit subject should be as specific as possible.
suggest you at least mention the function

> There is a possibility for an uninitialized *ret* variable to be
> returned in some code paths.
> 
> This moves *ret* inside the conditional and explicitly returns 0 without
> an error. Also removes goto that returned *ret*.

ath driver convention is to declare function variables at the beginning of the
function -- please do not relocate the definition of 'ret'

> 
> Addresses-Coverity-ID: 1642337 ("Uninitialized scalar variable")

Is that an official kernel tag? IMO the proper tag would be

Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1642337

(is there a shorter URL?)

see https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

> Fixes: b716a10d99a28 ("wifi: ath12k: enable MLO setup and teardown from core")
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 0606116d6b9c491b6ede401b2e1aedfb619339a8..ae75cdad3bd6b6eb80a35fee94c18d365d123cbd 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -908,7 +908,6 @@ int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag)
>  {
>  	struct ath12k_hw *ah;
>  	struct ath12k *ar;
> -	int ret;
>  	int i, j;
>  
>  	for (i = 0; i < ag->num_hw; i++) {
> @@ -918,14 +917,13 @@ int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag)
>  
>  		for_each_ar(ah, ar, j) {
>  			ar = &ah->radio[j];
> -			ret = __ath12k_mac_mlo_ready(ar);
> +			int ret = __ath12k_mac_mlo_ready(ar);
>  			if (ret)
> -				goto out;
> +				return ret;
>  		}
>  	}
>  
> -out:
> -	return ret;
> +	return 0;
>  }
>  
>  static int ath12k_core_mlo_setup(struct ath12k_hw_group *ag)
> 
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20250209-ath12k-uninit-18560fd91c07
> 
> Best regards,

replacing goto out with return ret and unconditional return 0 LGTM.

can you respin a v2 with the other comments addressed?

/jeff
