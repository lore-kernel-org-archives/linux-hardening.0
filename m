Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629F1862A
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771460318; cv=none; b=QCmPWfyEwud9O/HbaloiUgZ8bV3EHjkoUYRwHNyDUN6U7cO9iMHvemKSrY4ZvV7AwOJQ6WvsMBqyOqsvNz9cazv3hFapWcmZEkqD4Z3l3ph9AAhCyrjtbd0ZTEHM7MRZLAxsJQU6lb9/BPFm8Suy7WFYtoq929SfMD7UseTsGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771460318; c=relaxed/simple;
	bh=yX58FE41c/ilP+wBoKhqYAK/S3q8rJQbjLJSPC8DJQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pD+vwaXmOvHared2CMMo62kz34ysdztXS67Tt20Iz5NH2zaG7NAqceNV2VzFnT68m+CGvdc8cWV582kze5hMfu1rBNUb/kUGtNWPuAvNWoxmNV/ND0EV2orrbHG/jG9WdeW/Ans5eijFRoBRu5xYehXEWEjUy0vptY8vqCxMCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FvXG60bx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EoVv67TD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvXG60bx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EoVv67TD"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IFmS4o421072
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 00:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VXIKfQNG9TrKEgU99HqIDj1sC/EgfQBOZENx2xktZTU=; b=FvXG60bxmkD/dPLI
	vGJrGFpo8R4nuvHrvE8g15jwPilGDG3QnWKy4sbJ+w22k3nKhZg/B4qNK7HP0epa
	i28tuXGgnyN4fr1zrRB+NyFFtLeRLXULXCfbDhFhutPDRvlnWUlKuQmER6TZnNMO
	YKLyKLzXWCJh68z04TBddVXDz1eAX7bwq8GCw/GLINTGTnDF4ORK1tVYZe6K9yXc
	mm24VjqA3Wcc9zv3RAb3IGXpybAqIWAw2ZI8WCSfriL+h5cbVrfQvVbht3yqowHG
	whkYx265eMmy72HvXnhn9BN3n4SpNIjVWP0KOOc4BK3JW6dhIZTHvqb5QGn0Ptfh
	TTX0Kw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd76e2uxd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 00:18:36 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1275c2ae713so12089987c88.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Feb 2026 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771460316; x=1772065116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXIKfQNG9TrKEgU99HqIDj1sC/EgfQBOZENx2xktZTU=;
        b=EoVv67TDmEs3jh+boQ/WV9/BwoU4oOmmg2zI6HXk3sSEXGmQz22CxxEOzp1h+bWq+o
         7Ez1Zbl0CrRdemyOerGTpQdBULdGja2jcADwsVF7cOil5BuS0tFfZalY7tKzh9z82gju
         pKTNtpaKx6wtdUgP8crag5r9he39zND2lM4hOBxjlXH8kVxWr01aWCjI6HIKGjIDSHih
         xmZKJzXeLhJEoWfJzTHc3IvU5kGTcef2mNL+1VZ/mhKqnFXRz5YRdZYQfdywGyHmTeYO
         Bg58zCrQhT7ByAa81FtopFj20CesjDj5ZrX/C3bdvtrMlhXLk1Cq2K8G87pEE/RxPc3q
         Uw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771460316; x=1772065116;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXIKfQNG9TrKEgU99HqIDj1sC/EgfQBOZENx2xktZTU=;
        b=vdh9/5bgvWcLf/xGdTRa+L79HIekSjK65oSeWxZFeyrNWAKDRiFbHmP5N+8QPU84FN
         dxn/SW8M28DL3Gp2n0+BSMUhiGkrHR0j8PrEUE51V/DySqiA6KTXNOPbNO5ffXTi9TYG
         0jOJ5aHd5aTVNUpXjlcC8h+ODqFbJEAm2GT1fssKFXgkB2HQ4vaOVxJ552vrvzahJlbu
         /HY6f1AKLgrtzQtdyCtBmKSrz457UXVtIFQQ7fhcj3E+RKSo0sMhiq6nnxtgMtJ4sXUx
         /viE9EF4PDqMHsvqd66wH7L4vW2PjrVc9gXShCLxMLQbMt0wWTFbS+pXk9wE2kfe0p3d
         qhLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8HT8qMokpWuvTzFnDuhKqfBTYe4RtTPof/u6gIngSe6NEEA9921KjCNlzBYt/bdmRVqa9ztCRJ1/j16BdlRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0TkeHNBFu5aps/U3Q1iVFGVp72JzY2C2tAClcymzlohKbIoP
	B+eUQpn3915/N5pVH6WLXg6DmWoZDD6HkPchfJaKZoLaTyGGQ7iNDJpeFv1A48xVFnkPQNbg7+c
	NTs11gRzPAf0Bn8D9dXf8ZIUyR2oJq05/kPXOda3HJyZ3jZ7A4/QXykehjtQ4khrmDtDi83M=
X-Gm-Gg: AZuq6aINYOYO4l+jT8ofNi7zPXqwHjR3X03YrJWmVM94h4B0xvgmXmlBjKhCtSVIzm7
	TzdtXIIs83VkJvLbFLuMPTv3yUb4IkKp7zL4H8tTq7Q/9VAYG/ZIW8nfNEt4sHKArYBSoeU7iOF
	3oj7Zj2/dLw0JCJuh/slNvxhpR9W3KPLkWyV8dnqN+sXrSciR/brbbLg3CJcLne7LECuPgEVqQw
	iMssul5HFv3msrzqfbIuTjMiJiApb/bjhkByAI/gQ5AS8fiE3MMIbXtda4vlo1hAhjGnzOhcqAu
	16xIBNHV3HK+EF20MsFsLXCZh8jqdSSmu8X6pT7ailyWchAWSlWnEsETeGD8X9VSI5IVb8hnidB
	seFa1D3YoJL8ctS4oc3Eyt/snusWQEAfhA/V5Sktl8QKLa7/Wzn+Ye+rPHs4Y1vuer3NKhNzXbU
	XZuchi8PzeHwhkcA==
X-Received: by 2002:a05:7022:4a3:b0:121:9f05:7e4c with SMTP id a92af1059eb24-1273addcd33mr9051069c88.16.1771460315783;
        Wed, 18 Feb 2026 16:18:35 -0800 (PST)
X-Received: by 2002:a05:7022:4a3:b0:121:9f05:7e4c with SMTP id a92af1059eb24-1273addcd33mr9051060c88.16.1771460315217;
        Wed, 18 Feb 2026 16:18:35 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cadb25sm25643780c88.10.2026.02.18.16.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 16:18:34 -0800 (PST)
Message-ID: <d2a02b4c-5f69-4f5e-bc0e-428b64e99d36@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 16:18:33 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <quic_kvalo@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <aZP4RI-uN2001cBh@kspp>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aZP4RI-uN2001cBh@kspp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OKsqHCaB c=1 sm=1 tr=0 ts=699656dc cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=za3tAlzF_62g-CIsXx4A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDAwMSBTYWx0ZWRfXxl/6gya3Qni5
 aUKuvHoVBxzUcQBjIGFk1tQbMO5xZV1N1+zC/R7vxzyT18kCuei5nhDLnb0J007NOFz3tqDd08R
 /+GF7EjoDDcTxe8XjKBRTc/dVeBR2/JdhFcfR/WDQHQ5tjrNmcki4JqUdKD6SeUlRQVWEtZ0gIb
 3HeSwnzqSFwBCi5HQ91b90pBXnovtTig/k2BYJ3vRMzom1WhvSGvFUUAwdmA2rOqq9ZXIRZWx7l
 fXZcrKRoeKR63S2Zd65uuNhEKrZbnzUExcknEFoga954XKyCvTEfAMuixhJvxlp04PkEIeJRxWZ
 rIi1eGawgloMVhvo5xd527sC5JU/Da5OvBcvcgKzDpzOwSSKDI8VL9ejP530C+HxWxrmLvH4msA
 rn75YTDvuOWRrgVywhUAZXpNQLiS5agb//5HWgQOv0BGJGRWfXDwLO1GmwlJPYWPu10vZT2vXOv
 qcMse8t4ECjKsmuOkEg==
X-Proofpoint-GUID: Kn9tDZJC3JDSx4JsCoO53C5b4503AXTO
X-Proofpoint-ORIG-GUID: Kn9tDZJC3JDSx4JsCoO53C5b4503AXTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_05,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190001

On 2/16/2026 9:10 PM, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> struct bss_bias_info is a flexible structure, this is a structure
> that contains a flexible-array member (struct bss_bias bss_bias[]).
> 
> Since struct roam_ctrl_cmd is defined by hardware, we create the new
> struct bss_bias_info_hdr type, and use it to replace the object type
> causing trouble in struct roam_ctrl_cmd, namely struct bss_bias_info.
> 
> Also, once -fms-extensions is enabled, we can use transparent struct
> members in struct bss_bias_info.
> 
> Notice that the newly created type does not contain the flex-array
> member `bss_bias`, which is the object causing the -Wfamnae warning.
> 
> After these changes, the size of struct roam_ctrl_cmd, along
> with its member's offsets remain the same, hence the memory layout
> doesn't change:
> 
> Before changes:
> struct roam_ctrl_cmd {
> 	union {
> 		u8                 bssid[6];             /*     0     6 */
> 		u8                 roam_mode;            /*     0     1 */
> 		struct bss_bias_info bss;            	 /*     0     1 */
> 		struct low_rssi_scan_params params;      /*     0     8 */
> 	} info;                                          /*     0     8 */
> 	u8                         roam_ctrl;            /*     8     1 */
> 
> 	/* size: 9, cachelines: 1, members: 2 */
> 	/* last cacheline: 9 bytes */
> } __attribute__((__packed__));
> 
> After changes:
> struct roam_ctrl_cmd {
> 	union {
> 		u8                 bssid[6];             /*     0     6 */
> 		u8                 roam_mode;            /*     0     1 */
> 		struct bss_bias_info_hdr bss;            /*     0     1 */
> 		struct low_rssi_scan_params params;      /*     0     8 */
> 	} info;                                          /*     0     8 */
> 	u8                         roam_ctrl;            /*     8     1 */
> 
> 	/* size: 9, cachelines: 1, members: 2 */
> 	/* last cacheline: 9 bytes */
> } __attribute__((__packed__));
> 
> With these changes fix the following warning:
> 
> drivers/net/wireless/ath/ath6kl/wmi.h:1658:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Create new separate struct bss_bias_info_hdr, and use
>    transparent struct members (in struct bss_bias_info)
>    instead of rearranging members in struct roam_ctrl_cmd.
>  - Update subject line - Add 'wifi:' prefix.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aR153k4ExCD-QTMq@kspp/
> 
>  drivers/net/wireless/ath/ath6kl/wmi.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/wmi.h b/drivers/net/wireless/ath/ath6kl/wmi.h
> index 3080d82e25cc..d2a5c96fc878 100644
> --- a/drivers/net/wireless/ath/ath6kl/wmi.h
> +++ b/drivers/net/wireless/ath/ath6kl/wmi.h
> @@ -1635,8 +1635,12 @@ struct bss_bias {
>  	s8 bias;
>  } __packed;
>  
> -struct bss_bias_info {
> +struct bss_bias_info_hdr {
>  	u8 num_bss;
> +} __packed;
> +
> +struct bss_bias_info {
> +	struct bss_bias_info_hdr;
>  	struct bss_bias bss_bias[];
>  } __packed;
>  
> @@ -1652,7 +1656,7 @@ struct roam_ctrl_cmd {
>  	union {
>  		u8 bssid[ETH_ALEN]; /* WMI_FORCE_ROAM */
>  		u8 roam_mode; /* WMI_SET_ROAM_MODE */
> -		struct bss_bias_info bss; /* WMI_SET_HOST_BIAS */
> +		struct bss_bias_info_hdr bss; /* WMI_SET_HOST_BIAS */
>  		struct low_rssi_scan_params params; /* WMI_SET_LRSSI_SCAN_PARAMS
>  						     */
>  	} __packed info;

That bss member appears to be completely unused
(bssid, roam_mode, and params are used)

So IMO the better solution is to remove bss from the union.
And I think struct bss_bias and struct bss_bias_info can also be removed.

/jeff




