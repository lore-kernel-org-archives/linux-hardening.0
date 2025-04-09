Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A183269820
	for <linux-hardening@vger.kernel.org>; Wed,  9 Apr 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213479; cv=none; b=J6dDx9p6sxFdTWuMR8jpb0KR5ODlp48gLMjC7D49tBO3uhD7CauJR1V+lG+sJdaiiQtiELnkDNZEbhXSLdXOHToyC1v/Pv2Hnmz5++PHULujjlbCD2abMvKOxX1v0vLVvxGK0gXumrx5se2lNBaf9O6OTOIUsIMQ4yGFOiCB8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213479; c=relaxed/simple;
	bh=UeuCyXLhXUjc128ilY+JpuRORw7wF28aBCmlfY8BXsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAcBmLVKtlRjwT8WOjkSNYKaJKhfTAp3RweCBO2RTobhMGn1KnvXlFs8v+i3o2o3EfO35qcMF1vzUwuoujOH0WXaVqsj1HSNezRC1Bs9ugA+1TIrrhtUNEc+649BWRZX+ES3ayqh/tifVR/nR50Csm5bTdcrPSxiTz9b6QCMh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TWRAM9wL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TWRAM9wL"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398SREn002332
	for <linux-hardening@vger.kernel.org>; Wed, 9 Apr 2025 15:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jf9Ry+p2QQQupfgw9vOlP3Ifvgj581gqI0fqXPxyhMg=; b=TWRAM9wLBxqUMUOp
	936fUT/TBvmCbxUFWKW/cG7VqA8rE+UhFA/ur7uT0cj7S+cipzBvhPb/KBmwrU36
	TQLv6z1O2ntFSPaxOXgRIJ+B36Die/6n8xZ/Rg3PbRA8+xz+KRglopxtYQPQfgze
	wXNtWUFaQi9pwbA0fo0GsPNuvD+YLiRfF3KhO0IL/4qPvo3ezADfziS7dr+Pky2l
	8comIh1oY3UbvXJxx6Uw9UHMr0OvSZ0a+dqBf6YsULlZzLj+850W8VHIpYNxSmvs
	E8ywtn6Xnk8wvyXYf3BHhJ3fNzvtqQ4xjo++qhO8bS0N1bZmRO5OBx2iambMT7YN
	goH6SQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1krtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 15:44:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5f3b94827so1252344985a.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 08:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213475; x=1744818275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jf9Ry+p2QQQupfgw9vOlP3Ifvgj581gqI0fqXPxyhMg=;
        b=I3rHh91iO4s6WkBoYRqq0rFKAXTUWdL8Bk+mwaHkWM9aA6ETvnusAOCKL/FcDnjfnn
         7PB4r8yIpBMyoQ+6rsNeLWn79RP383z1GTC027fibYbkEOA45uwslq2lW5oYrTtxTMZ5
         VXuTwqL1sYP6yQI14pKbEMQtr5b+kFlGwzgIQS6QPXWvWuIOhtCeIwq8F3WMJXktABCE
         9gATqOs686/fshUeDpfQ+6fVE9LVPyfTDEjrE4jJQxsnXa0lBs1KC+Tzs4ZwqeHCI5gy
         jRX2c+g6KX21RCcLNptJ0kiDiYBqL4ygQp9NmwHX1qpXcLtKJoEz2nB9P+O2j9M1kFvR
         hDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvJH7C8GbwsZtY/0Jkc6kDJCosdQtGH+Hw57RPwPr7bcH7gurUKq6q/VUT62/adPsx6OAJoGGzNgE+HPwaHKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXAjbqBThu5BMpNo9fI5EqdehOQAbG8nUVEC3w2c2FePJ+R5y
	73IT7tuM1zOklwHSeDNyRQV1QUDBA/HmjLAyjGbzAI3EWosES8zdf8magqWzQ6pX7ulVXTnc31i
	MFMBg3tsw7tkfuPzrJmyJkq/DujQ0w6NQQBUIUIH7EuhM27/pSTbXeLalkXGQM8BkoMk=
X-Gm-Gg: ASbGnctBIEIc7n/IQtdEO3LkReJG+MJXqla5aIe29QlMCEWye7PDTXxtAG8HggdeGBq
	cvTPAOrqfr1xgXtFRg8+T8STekePxX8xN38r96YqllIVeuCQjtV5hLsgy5wr5C1ul+ypAPwR7KZ
	8WGozxNbqqsXX3n7VaZ2V8g7XYfABUVQL+xxTMycTyRHrmBtTZKUWKhx7UwfRVqk4MuGUXBcmv/
	VNT7eLTJKNed474XBL5dAkmq/jYgb87+5dnFbwIgNakj/+0FRvqPHdctIk01WPappQNUi7h//uo
	0+BbLRjCDkLtItBEFDUJttB4TS/FrCwLGiCMIbGz+XAgyHqLbJ17cA1uI/VKxaYX/xo=
X-Received: by 2002:a05:620a:6223:b0:7c7:a212:d1e7 with SMTP id af79cd13be357-7c7a212d215mr251123385a.32.1744213475111;
        Wed, 09 Apr 2025 08:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR79I/nR+rW+zjtLRr7uRkQezm/LzIKrYmKHQlSC0gniwNCOb3Sxvl8FOipevKYywu+GxHkQ==
X-Received: by 2002:a05:620a:6223:b0:7c7:a212:d1e7 with SMTP id af79cd13be357-7c7a212d215mr251120085a.32.1744213474747;
        Wed, 09 Apr 2025 08:44:34 -0700 (PDT)
Received: from [10.187.209.180] (37-33-188-210.bb.dnainternet.fi. [37.33.188.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f465f7b0asm2007281fa.98.2025.04.09.08.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 08:44:34 -0700 (PDT)
Message-ID: <685e784c-3f36-4cd1-9c34-7f98c64d50f2@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 18:44:36 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Retrieve information about DDR from SMEM
To: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BGEsmmesMG2HL583rXrQJXFg-bsvyubc
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f695e3 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gh1egkeLKbPt9jDVRuYeUQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=9wHiH3TPsHwm208gvmQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: BGEsmmesMG2HL583rXrQJXFg-bsvyubc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=692 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090099

On 09/04/2025 17:47, Konrad Dybcio wrote:
> SMEM allows the OS to retrieve information about the DDR memory.
> Among that information, is a semi-magic value called 'HBB', or Highest
> Bank address Bit, which multimedia drivers (for hardware like Adreno
> and MDSS) must retrieve in order to program the IP blocks correctly.
> 
> This series introduces an API to retrieve that value, uses it in the
> aforementioned programming sequences and exposes available DDR
> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> information can be exposed in the future, as needed.

I know that for some platforms HBB differs between GPU and DPU (as it's 
being programmed currently). Is there a way to check, which values are 
we going to program:

- SM6115, SM6350, SM6375 (13 vs 14)
- SC8180X (15 vs 16)
- QCM2290 (14 vs 15)


> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Konrad Dybcio (4):
>        soc: qcom: Expose DDR data from SMEM
>        drm/msm/a5xx: Get HBB dynamically, if available
>        drm/msm/a6xx: Get HBB dynamically, if available
>        drm/msm/mdss: Get HBB dynamically, if available
> 
>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  13 +-
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  22 ++-
>   drivers/gpu/drm/msm/msm_mdss.c        |  35 ++++-
>   drivers/soc/qcom/Makefile             |   3 +-
>   drivers/soc/qcom/smem.c               |  14 +-
>   drivers/soc/qcom/smem.h               |   9 ++
>   drivers/soc/qcom/smem_dramc.c         | 287 ++++++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/smem.h         |   4 +
>   8 files changed, 371 insertions(+), 16 deletions(-)
> ---
> base-commit: 46086739de22d72319e37c37a134d32db52e1c5c
> change-id: 20250409-topic-smem_dramc-6467187ac865
> 
> Best regards,


-- 
With best wishes
Dmitry
