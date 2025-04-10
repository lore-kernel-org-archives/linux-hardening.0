Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A01F12FB
	for <linux-hardening@vger.kernel.org>; Thu, 10 Apr 2025 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744314581; cv=none; b=WPvoIdRk/B5npP0J1oOWh+8Z8HzdEoSF2o5r79hkK0nsG69nNT2HqxOGrl8xTEOg05Q4nElxLZC35XlmQSDGr8gFKOt1rCHNJ4B1N4jCgnYwXBJ+vRpn/9zhfNsMSqAligxYY0CgPNcuPkPmojIG2T+P+RcfDxsAPCCII/KXiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744314581; c=relaxed/simple;
	bh=CVUILzI3yY+5c0lQSYrQru/mE0icI42pipOKpURmQeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SltTtBf5e8gzoereU+kDBqXE5LdjChlBXt37pdYLNpfP59vRShQj4tHkV4QGGJoJgeyxtb9AfBGb8mRwqCmldttr3FmDwjow8JuWJeiKPQe/p9A99hFMwARDc1a5Ujq8vGeCjYEg4C86jdP81lfLtzzFYw1BYAeBQ9du4FehR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZpC/npS2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZpC/npS2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGEjeG028834
	for <linux-hardening@vger.kernel.org>; Thu, 10 Apr 2025 19:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aNhuwxgEqLQlGdQ0sOZNsXWl
	JqoDDoZqwpr4m2bgAv8=; b=ZpC/npS2kfZgcSJsiieah2iW9S2n+3kFAJli3xUZ
	whp5TGslpUiPVsr4vIPkzojf5GmDVamfBFj3b/bnJPSF3DRtwYckKtsl4ZLMSs+b
	jHLQx8rl+XchJtVaBA0gw5NEptWFXndkXcWSeggoGmpWBKLG022/bqS2deXhiRGN
	z2v6m1Vl8ape1N5ibjcx4H5W4llmhrqbXbPL1JD9uFTgpEZwfXStfBeN2+fIBPJd
	SnLMj+oXQSQMdRNEx1BnQ3S0rDL6g2DB+0cQSwlNAFf/gd3UGYg8yLwC+ACv8kEt
	NGeJEc26PIAVNF/63o2zoUWkIAJEST1sOkqGIvyXb5KSVA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbur6e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 10 Apr 2025 19:49:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c791987cf6so261273385a.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Apr 2025 12:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744314578; x=1744919378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNhuwxgEqLQlGdQ0sOZNsXWlJqoDDoZqwpr4m2bgAv8=;
        b=dNRDNZ2xjplFazQ4AmlTUQo4k0gskGbKggPCmv2HZ5D3B6k61AW0e9TQpkBsOWk4HO
         PC0iloEEzrW/pFdu6emhOxcbqtnggDESWblNqBCA3BOmCN6Ore1uSwgsA3OfSeK2pbqp
         UVRB3u2oMTCiRTPbWKBY/67/NbGYFZNTmbtU/qWHOM8jYS2ulL7sZhNz38rfPu/ys/Gy
         6x5rj05NjMGFD8mc4bunDE+ZFlylkaVsFq3Mz52XJS2DyXJaSxnMEbdgIgHM/AS1rJlC
         sKr07RjKjn8TTS4izZI+8tIfV1xxsKCbEVptBqP0jbXuXOB8xoV+LMT4+vYmdFslB3eF
         BiBw==
X-Forwarded-Encrypted: i=1; AJvYcCWYWQ/bpFkEHzncs2SREnsfCS7wVVG2HjcvUDlcs36+F1RvwakwwX0RZMy9tzE3gq8a482K5jPqe/IkAGP/v+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNbPomap1MR4iH/6E+1CwXP9GoCu7e9G4EZBqztzA7yWKbSds
	mAJzl+yobRyejZiUngtjbvHXSo0LbAX/ni/305kzzPexTPoY+EK2HOf8ClPaZOupj76QL83sW1S
	8l3mrOJFuUMgeBAoMsyOp4Zf4Q2UBbRSWjgkIIkfXB9NKEw3u+fk7gCdjzsnOqPlA/Qs=
X-Gm-Gg: ASbGncvWNTBLgtlnq3dEGNp16GK1opY/0jWR94oQaRdoHLhSF+gZKt2KKRAZZFdvi97
	nAwmud7bRpC1qXt5z50eJo2eqtShyNN2UQdiPHATZs5hBH0nlNes2g6yuVafMSc5egOZytrwsSk
	VGg8U8wyjHmTKYPH7p4srq3fSWei3MZxqPYmY8/CTifvykJSlfAEHKaQJrNOG4vjRLJ8+9C3CzI
	tysECjJhS0q/cF9EEvFeEJCd+Ig3hdhEnDdHkjoysQ9ZqQ/2PzFWYaoQ81jtwvwMEqQzOxWBfDI
	CrudMzFat6PEtiZ7gwzJpAP9DlrjJbxZ7D8MP2J0/9HERTy4Nb4CCOF4HoORPCAoHChiy9xdTuA
	=
X-Received: by 2002:a05:620a:2941:b0:7c5:4711:dc51 with SMTP id af79cd13be357-7c7af0f8841mr36837285a.2.1744314577842;
        Thu, 10 Apr 2025 12:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsp+mbswefuSskvfP4MGPlMZhuL5PnvXrRuwIIXDia3tt/3yJFdDa3tlw5fgy10G42iTdrsg==
X-Received: by 2002:a05:620a:2941:b0:7c5:4711:dc51 with SMTP id af79cd13be357-7c7af0f8841mr36833885a.2.1744314577477;
        Thu, 10 Apr 2025 12:49:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d86esm5793871fa.14.2025.04.10.12.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 12:49:36 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:49:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/4] Retrieve information about DDR from SMEM
Message-ID: <iebl74rolk2t6xyoedy5p2e7clssh4dvxtpzerykyivrhkao4g@dbmnpia3xtxv>
References: <20250410-topic-smem_dramc-v2-0-dead15264714@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-topic-smem_dramc-v2-0-dead15264714@oss.qualcomm.com>
X-Proofpoint-GUID: WLw9vQwiHGS5VzHP6f1vrfJX74SyZ9xo
X-Proofpoint-ORIG-GUID: WLw9vQwiHGS5VzHP6f1vrfJX74SyZ9xo
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f820d3 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OxrDjszf_QBMMd4ylzMA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=758 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100143

On Thu, Apr 10, 2025 at 07:43:43PM +0200, Konrad Dybcio wrote:
> SMEM allows the OS to retrieve information about the DDR memory.
> Among that information, is a semi-magic value called 'HBB', or Highest
> Bank address Bit, which multimedia drivers (for hardware like Adreno
> and MDSS) must retrieve in order to program the IP blocks correctly.
> 
> This series introduces an API to retrieve that value, uses it in the
> aforementioned programming sequences and exposes available DDR
> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> information can be exposed in the future, as needed.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Changes in v2:
> - Avoid checking for < 0 on unsigned types
> - Overwrite Adreno UBWC data to keep the data shared with userspace
>   coherent with what's programmed into the hardware
> - Call get_hbb() in msm_mdss_enable() instead of all UBWC setup
>   branches separately
> - Pick up Bjorn's rb on patch 1
> - Link to v1: https://lore.kernel.org/r/20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com
> 
> ---
> Konrad Dybcio (4):
>       soc: qcom: Expose DDR data from SMEM
>       drm/msm/a5xx: Get HBB dynamically, if available
>       drm/msm/a6xx: Get HBB dynamically, if available
>       drm/msm/mdss: Get HBB dynamically, if available
> 
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  12 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  15 +-
>  drivers/gpu/drm/msm/msm_mdss.c        |  30 ++--

This misses the dpu_hw_sspp.c, which uses ubwc_config from msm_mdss.c
(but the config isn't being updated with the acquired HBB value).

I'd suggest behaving it slightly differntly: can we please have a helper
module (in drivers/soc/qcom) which would return UBWC configuration data.
We can start with HBB values, migrating the rest of UBWC-related flags
one by one.

Also, were you able to solve the issue of the platforms where GPU and
MDSS disagreed upon HBB data?

>  drivers/soc/qcom/Makefile             |   3 +-
>  drivers/soc/qcom/smem.c               |  14 +-
>  drivers/soc/qcom/smem.h               |   9 ++
>  drivers/soc/qcom/smem_dramc.c         | 287 ++++++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/smem.h         |   4 +
>  8 files changed, 360 insertions(+), 14 deletions(-)
> ---
> base-commit: 46086739de22d72319e37c37a134d32db52e1c5c
> change-id: 20250409-topic-smem_dramc-6467187ac865
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry
