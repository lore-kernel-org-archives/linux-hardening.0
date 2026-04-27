Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28AE3D4133
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299769; cv=none; b=eyfbKZkUkjJsPfI0PdzAzLo7Y9zxe4GcNC2PZy7tAXcLDMadoJAk4b1FaOm9g6yPWz7dzOsq/AWX9F6I45/FIWKIKURgEyPc88vD80cijaS3i2A3Uqmc/LS/zdL8BA4Ma/BTHAnQbuBCNXJJc77ysfJcFgCQMTE24zFrjGriN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299769; c=relaxed/simple;
	bh=//5y8usvnlLYIU6Nfwsa3ikRzmN9fsBFZ2GRchFaaCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTn5KgBSUOlDTSVxgETsbjc4Tb2VyiZGeE3f44/H59QQhNveR/eo/xWacJeh+rNsyCvagTREXc0TMTmHXYMSvFtcRFu099jkuBkVOjIxzPedKr3RTdJnwmuz7Pr/NKB7VlZBNIMOTGDrwqnup8n5xc7JNr4tfWfD8DjEg54yca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jh0mNiGJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MZnSCGKm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jh0mNiGJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MZnSCGKm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RDc8Z23962022
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 14:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LTFrH73lEwXqL7N/MOKb8e5ZwbO+LjToc1hBsxjavBc=; b=Jh0mNiGJnaEQYxKK
	omUPGyG5j1o8r/izROyiLXmknMGdYdLnYKcpkqfA3k3TmiLW5iQTVZGncB0Ou0J8
	Vx3yu4YEhG/ZuIGgdCaooPiLGcV8+S0QEQVkBcQytIYcibuTiZ4Me2evpAT2U8yw
	fNbCfLj41pdpXXR1wXaaUNbiFRnez2VMzwgZEvUMzGjRkc1wdUVGIcsI8w6Mvofa
	sJ69vuFcXPtLLceNPR5p+tzVPVg79t5Q8hRJfHzjWM4d+sq18Vk4fjHFhk0TIBe2
	Etb2k4lt+cnTxZS7HmnQnZb5iZ2ur1FIyijdiUlv+x8AuyQMkQxmmWXUZ20QtrL8
	1pNVGw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt4k31fq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 14:22:45 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6055c46b2c8so642041137.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777299764; x=1777904564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTFrH73lEwXqL7N/MOKb8e5ZwbO+LjToc1hBsxjavBc=;
        b=MZnSCGKm60ubRgUHscjOi0lUffsmH38o11RlQwBLtcuvPVOo1VtLhe6ulLvf9zFxak
         NialSHyF3xur4V6N0As/ANT9fxLSlti2ZIrXwny29D6gIMMYkECGjFGmpWaYXXUedCHl
         zFF4V6rOFlv2n001EABBW+aoYhcKVhx6IAEXkXSxc/dx4ZIst8E9dYhwojA5j+1iHTbW
         FWiz5ZTrMJvRnXmbA2lkYVSxke3f9CU58m/F4wM2hRJiV7qyKnYVt0SOSQLiIG5LMbi7
         s/+EilXYhGISIX50U0EkSYTDk3qmeye9yPp+Pq2K2136jpyfkTxdiTP3DmsmW9INKx3+
         buQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299764; x=1777904564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTFrH73lEwXqL7N/MOKb8e5ZwbO+LjToc1hBsxjavBc=;
        b=jxX2wl6uS2/cdN9u0+qv5Mb6Xe/iMCcij7S7Vb0D0/gguGKBaNKNFgN3ZzdT64wmZ8
         7z3+3qwPmXWBuLPdHhqreGoQXAzWmaQFAr7d6lW69jfvof/e0SG2jLA6ZNiZvROU/HBu
         eTJYdznGEgwzIZx2BleSo85kFMy8ZdGWYI46hM47UNkO4BRerS5KQ6m2vARaUgxhjcY3
         QPd5WVdqU10DEgykPK0W8bcm1aR/ov4aFeGLBxMGpEHPS4SMnlhUB3z3/VuCVjNsxwNT
         Za+Fy4BQcnHDzI2WQr1yBt2Z1BTWweJlBGFW05Y/HkIHxdG2hkyAQpNUXbjJbsk+jazR
         R8SQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+k34s5TQcy7svk1QYRs3M+aoOCjR5vbIetWNHOeTfkvqNZR6S1Gck73E1Rv1M1RMw2hU0EDn0ATW4Pcdu4hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjkw7Xc1CwbsDlqeBKyhz6ujF2jfoqabr7Zwhsd4xHkyYH26Jx
	xWW0OAwgbJlZju8MEBacFFK0scqeru+dIcYmX1wLuwx/EqBdLC9GUIgjoj9ZEEQ6X2bWCYEuSbI
	fPnpJND81Lz5MnWxxIk0ViY1fcrIeH+GW+g1wrmViKNQxOHLPnxmkl+vrNJfLg++t7OsZFXE=
X-Gm-Gg: AeBDietvaeFy8EszoFbV00lh2y7POeBqO6w3pQCUOIc7l9KTGRsyg2vk7xv7F+gpuAu
	32aIjHNybgxihwOL/dGQM3Z5firnXONgx5R/0bsI8GZtjvky0iUGJXebDxHrJzqxPC0DVC4nCYH
	Azm+8Vjg5cw9t1xTtI4Vd/cfCD1FLe21Nk90CAuMcanrOacQrTGpdEUC7TqHhtBzXh1qfa+CZmr
	ZEL5J+RwG/O2x4esJDcwk2lxGFoamtcq9gS24TwH91er8s+h0NUmLW0EDzzmrRdKW91Bq4N/U7r
	F3BcmdRuR9rIWu8skfRxlyT3LvLKC9UKShDafxmfikcQ28/gqswH3aeZlcO2jkaoy6FNRNNbMpr
	HdXK13gH6pbCLpBSIVdGWTmljHoqhOZIklaNcVpThXaa9sh6szmsw8F6is/dGW3HNWfCl59wWBo
	roT64hRPGJ2S9q9A==
X-Received: by 2002:a05:6102:5c2:b0:612:13af:f5de with SMTP id ada2fe7eead31-616f6ef8614mr6671736137.3.1777299764457;
        Mon, 27 Apr 2026 07:22:44 -0700 (PDT)
X-Received: by 2002:a05:6102:5c2:b0:612:13af:f5de with SMTP id ada2fe7eead31-616f6ef8614mr6671724137.3.1777299764061;
        Mon, 27 Apr 2026 07:22:44 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553223bsm1134937766b.55.2026.04.27.07.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 07:22:42 -0700 (PDT)
Message-ID: <aead10a8-45be-4f7a-ac6c-35a99a716b3c@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 16:22:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-10-f430e7485009@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260427-camss-isp-ope-v2-10-f430e7485009@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE1MiBTYWx0ZWRfXxiuAXBEZCQeE
 69xrBcj8Xhv02o6reeLxtxwOcfZCZcj+i+jZZI69ooG/VJGQGRSQtcHD9TD9TTJUKO0Izgo0cVT
 0ZJ8uq2QPQx3tJCvwvrbgHUgp76PPc+71w/E359+HaWXvbLaE8LXGWtPKqwHHSQGCPhRpcm9Q1I
 Y3CiYAOwnRrMfO2WnzecYKCWFQ5C63c2pYMoUhLgilqm5sOQgV7OvoYCl8v6W0MlYPyejq1u48O
 xDjUHXW6VIWSZHlrXw2Z49YQ8VjRJ8wLWhk5VK0LW4bZLThlw7aW+2CFEAb46N4cAYpRbnwEJp+
 oLcthzrtFqellzDi9P6mtUeuL6HuUQ2reR4gbrqIzJCbTmJmWdsID6AjY9vvW2f3VBlQD+7z+0U
 9XdrOxz/pJQnLF444bgh7KxbXT/7zZtELUyY8lI5LwMqReYibtZ1rcT8T2wqUiNNyvilyKi9A3D
 02+Yc9nYkfdcyrlAUXg==
X-Authority-Analysis: v=2.4 cv=a7QAM0SF c=1 sm=1 tr=0 ts=69ef7135 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=HtS05e-23YgY9VhomDQA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: ejDVc3kv5GU_A2CsXh4iX6TEtclAO80T
X-Proofpoint-ORIG-GUID: ejDVc3kv5GU_A2CsXh4iX6TEtclAO80T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270152

On 4/27/26 2:43 PM, Loic Poulain wrote:
> Add Devicetree binding documentation for the Qualcomm Camera Subsystem
> Offline Processing Engine (OPE) found on platforms such as Agatti.
> The OPE is a memory-to-memory image processing block which operates
> on frames read from and written back to system memory.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

[...]

> +        clocks = <&gcc GCC_CAMSS_OPE_CLK>,
> +                 <&gcc GCC_CAMSS_OPE_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_NRT_AXI_CLK>;

Should the two AXI clocks be aggregated by camss-top instead?

Otherwise we run the risk of the OPE driver setting a rate of A
and another sub-device setting a rate of B

Konrad
