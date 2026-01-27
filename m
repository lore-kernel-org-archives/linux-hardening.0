Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2834A77F
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769514926; cv=none; b=XKhVVIPuO5+8kjByFlL90dVfsZubxR04nSoDbISX70/iRRmMrigxHRskxqlrgIsP/AQZ6pWmgGngJNdDThA3GP0Z0BftTOf9qc82bJJg6axYfXbDfm68xnTRu5b1SxntqP+HcZUDGJHdWr8SI5u+yqJbblVT+GOPbOSdj4YoN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769514926; c=relaxed/simple;
	bh=o9v9hHV5L3vmq+RKzllPOVxRj4a7zOG+09H9v/8+dek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E72JiRcK/cHcuEMXkjeyXYzH/+9TdM6VxGRn+2zZg0XyOU6A5k4LpdD2NeIphfENJ6ec4pSNmmtqcxDYQTRSEMicXQU/MYafAwvYfp6/Ss6+1kB3eEFhAxjkWHfd5Ng+Sm4T71z8iWO7Chqxbrl0X8m0bFZv+2OuzwI1Y8n2cnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i8ZVhDTO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CLUqT2X4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i8ZVhDTO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CLUqT2X4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R876xp2378873
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 11:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a9Sj7eF8b1E+BkZwjsDmL9S3HQBAEI31EvuBR0bF4wo=; b=i8ZVhDTOXPCYbR/R
	lafK+Mhg89Uinr0/bMU26cFy+TsW7FAbEkmlH0ZA//TRvkjaziIAJ27KZFqgUjzF
	rRRKKFhJbX/jLSXN+Ez0ZJj+1hHDIBpK+Y70vUkTHbkuyOtM6s9wDgbFn5gRvS4i
	tGNn3NOdFg/UyKya0NsGSBs0MHSQIuy0hJemsmAh4QbeQT6uJZeOfnu9a5/OxLIT
	ENAY6iu5AlI9Tc5d9AYs+YCsjLfVr56uA31fuqS2dweNUURScykPjhySAjTCQSUH
	eZOADN6ChSF0zcB/9rORHdK61xNUwEJKJYgMl+RrnD8gI6aSsppbJV1Ooo8wmOKx
	YhFoqQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjr8r8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 11:55:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c522c44febso81861485a.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 03:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769514923; x=1770119723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9Sj7eF8b1E+BkZwjsDmL9S3HQBAEI31EvuBR0bF4wo=;
        b=CLUqT2X4j8MoI4ElcjYtOsWOTC5MPKiZ/gSgOuoWFJzKtOdsDv2WVlyeuDjOBsr+rB
         +uEdEwMVPM/a8sLtukID9EMDXEINqnNq0gPZAUOWDkopOCrB+3WKKLS8nsN7W8PenWnZ
         +vpk989CJ7wMhmOeBmj1RvPH3SHRMsrEo6bstdKAmVcqwwP1pqvy8ftJUeadSKTXLUKR
         VALU5Oxa1umDpiE83q8KfWekNNELndOMxi/xBt4akuYImLUn7qvzZbU2/B2IJ567Q16+
         6OPLKvCj6KPJ5rqOsf67IF44NiYpbmJZ9HYN+mm3rDcujMtcY8zX/cNDqg2srYCSa1Pg
         UspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769514923; x=1770119723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9Sj7eF8b1E+BkZwjsDmL9S3HQBAEI31EvuBR0bF4wo=;
        b=Dt5om0+0I7AhiXtzAa0v+ry71qKSP2U8S4GzkbzUmfcwTYepgjuxk6U3UovDE9Wuxz
         +zGJIKNaJyTMQ/qdkdepSXj8mC0CIftFM0EY4dgJOI40qtLQGFVG99diSH3yOBBF3gC6
         NPctDLWxksdHT5DsSj6D9F4wuhGfRYq68JLh6vL+XFpb12Wl98mUapXP7+tKR5RWNyTJ
         fBQv8ZI9CwgW0cZIW5i4aNTUdpMNtyqxDbiFMGKEEZKBdZdMjr0nOEsgrffrZkTO0mXU
         Z/xZiwHje6psnTlMMkXvcrHEYePHa+2Lz6nn1j4lnDeNRRVLoc/UnU2dTxMY/fmJ+eK/
         5PMw==
X-Forwarded-Encrypted: i=1; AJvYcCUPEP/o3hHD0slPWPJHHeMcrcdw8NdEOXhlD+DzwyTK0WHw8nRavxdSF+giyACoBjw/AcLuUFqTAQpr4Sb9w/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgfTaaLaqHfNHwBe6PWsqWfk9NHY3Q9Rj3GUdQJIvbbMNii0s
	VEw9idMRTUj1f3MQXggPKibxim8wway032KDQjHMfGOkJiqLT4enKC0S38RJpUZX8vPvE2fQrtz
	WrKT1teKd/fNHvhci7dmxSKucO+xnoIuA2CvhezGc/r0XF3dpo9sZEC8DHzLzWIqYZ//RIiI=
X-Gm-Gg: AZuq6aJUBFBkc/jJ+GP/zpd1uAKGKyqSHQBFaOtEg8q2PeOWMj0FNUcG10aft++NvpT
	hAqC9HoibKY+sSaZty0SX3FanPd6YfTRNZLbCFIygM74bylCklE+bUDjb7V2MiVTkLY0BHbacuw
	7XREaxZ6JGNe2w4bbCAf6lrwr1XlXD3j56ZxUGO54tLR6GYStuWbQg3SrYBKK24LBWVvRkWb0DT
	m7Zg84jWz7LpISjrL5yszdtedHAxYi3MQ78zCSopHy+pvTCoUoCT1yDdPoQBuP0ydrbkUvAfFMf
	qGbUJcdz7IN25V1TCrJ1AISsDAy381NPFoJPAwERryup/YFIkeB5Ukciw62LuE4QuHspWE3DEI8
	1eiUuiV/KhTvn4RvpUgPtKSf0hA1WBKUrcSJizL8xxAMqAX1urGwHtNNEpCiMzvic4rk=
X-Received: by 2002:a05:620a:19a3:b0:8c0:cec5:148c with SMTP id af79cd13be357-8c70b9b3ca3mr104160085a.11.1769514923438;
        Tue, 27 Jan 2026 03:55:23 -0800 (PST)
X-Received: by 2002:a05:620a:19a3:b0:8c0:cec5:148c with SMTP id af79cd13be357-8c70b9b3ca3mr104156885a.11.1769514922939;
        Tue, 27 Jan 2026 03:55:22 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b418494sm792980166b.21.2026.01.27.03.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 03:55:22 -0800 (PST)
Message-ID: <d996747e-b727-4116-9124-08a2a8827250@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 12:55:19 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: Add Redmi Note 8T
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Gabriel Gonzales <semfault@disroot.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Biswapriyo Nath <nathbappai@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260126-xiaomi-willow-v3-0-aad7b106c311@mainlining.org>
 <20260126-xiaomi-willow-v3-7-aad7b106c311@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260126-xiaomi-willow-v3-7-aad7b106c311@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rOMREMaoZCN5UfJEmS77Fmbq_g9ZHop5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5NiBTYWx0ZWRfXwqAnznH5+NNB
 quiGMIH0BK9l7cFOvFUG+KdLlSoLigNj1U/V5Fwb+gefg+nY3zvee2MK2q4uzPSd2zy6r8nv/o7
 9ySnFUvhrUWjU5n56hxPQvDeHIlJmQ/bPtzAxmNo9UAjG0po46sAYM9r/oxvdUYpdMZ4dMqdWhF
 YpqjwDdLtD2i3klJtEZsf9K6KmZbHayUJTcv59F3566bE5vmjQrUDyv3cAB29HwwhkjsIx6/ADU
 xEPPrf8kQ4ObndWn+eCrvdLtrGNYucj7oDuBRowBsj2rvy2XS/Eeb/Y6HFDOVuUJVJt1j2mfWuF
 Pw0iHISGZ2oJhp1B5GYr7eUwFoK6hKaOZJ/CnuYjnOhs/5qDvpAWqACjqoQRpCc4O2uvnzDYVpL
 spq68/uy1vgv/W3CQdBs9TJPSoj/9XlCJ5pNWp08aHzrkPWTk7sHry/nF8eZElihiPfpV5tEG1T
 0/4epZ5TCdTavp8l2Hw==
X-Authority-Analysis: v=2.4 cv=b+i/I9Gx c=1 sm=1 tr=0 ts=6978a7ac cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OuZLqq7tAAAA:8
 a=QCooW88KiTORuWKV444A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: rOMREMaoZCN5UfJEmS77Fmbq_g9ZHop5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270096

On 1/26/26 5:34 PM, Barnabás Czémán wrote:
> Redmi Note 8T (willow) is very similar to Redmi Note 8 (ginkgo)
> the only difference is willow have NFC.
> Make a common base from ginkgo devicetree for both device.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
