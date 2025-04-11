Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ECCEEB1
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365485; cv=none; b=fAdFqfgMvszga9ZWtFkySw5XNhZRMD8MrhUV/NrWUWhIhYQLRYK4MHSAgMGSfVf4eahj7yf5sa3FJ1u+/tgm/jBHAVOnvWQhM8XMPrzR0Dui7xR6TKY5prIeX7V3bnjiYEeKny3lluShv7mFdLBPq+Ni5+uMEt9izQEa5YdzOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365485; c=relaxed/simple;
	bh=zsVOdD84X8pt+vFPxaVoFyBPCoT4S8sULlbK26J4FGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgqT4TVST78PZ0XJqRyJTTKywyZdyDVvko5tQ4Fn/fNTMfBUoIOcGF836hUImhvscNBzJT1cSpyhFTKDoZSYnDWIPZ+Ebhqqa6FW3v+6U4ezgyjw7ToRKIShopVmG/OSqCnEhGuHe+GzBr/AA4/Kgx8uWJslJjNH9fu/XqIMEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxOlhV7v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxOlhV7v"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B0T2UK028318
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 09:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=k+idOG9XotOwye43x+aZtsKS
	o5apYGkMFeSNzvPXUCA=; b=hxOlhV7v6VeJG+N0YGvU0gjoBJF6Yn4aA71CxGUC
	GYcp9uaTYZ8g29UzU0rmK5BJD5j+vDiWoU2KJQ46ld+4CGyz7s+SZabxzo5R3wSi
	Ybv/BUA3LcQp9THEOZFRn3n3IPkjSHa5cSAkHy76P+LvG6kcHQGxPXU2Pgq8SdsP
	jczEm4Ovqw4/QP6hK6qoqFkgUWoahjNO4yrGpR8RoiQc9caWBFo6aQ+weEa4JQ/8
	W52HPqmzJp4os2as8dyTd1cMESCp51Z0MYBw4Gzw88QkuzRzj6Psk1EZFXXB8k4S
	bMvgexwmkHI3S9tQw2ot1G8+Dnv3u5Wvj+/WusbdwCXL1w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1stc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 09:58:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af423fb4f0eso1231723a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 02:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744365481; x=1744970281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+idOG9XotOwye43x+aZtsKSo5apYGkMFeSNzvPXUCA=;
        b=a+ycWfDFPryfRazeYV3q3h05qHJlgcDDm91ktQzGLTZfqna9WiB/YdhJ56iYG62Is8
         0p/6clQnyHRCY5YXI84dafi2Xf+Xh3FvarcrHJC9aE0ZQqGNgHuYkt4vqKz4QSq2XHlp
         GkWBdjenHlcfygNNYBS671vyw9+ZT6fuLcj9pD6TUDyAeHuSNyVrG9S+4z0d3hbOl1qy
         BTiVItXvqEjP/XpOuQG8B+i3SRa4KbjY3FSLHZCwUK2g0g0DTxmqyyVUFkJFg+LSntlz
         zSnyri3MeeOdZ6eeDPqmzfMG62wQ07LGMy6etp5GYMIubDtQGWkgSGoj1DQDzZnH0a4d
         /PZw==
X-Forwarded-Encrypted: i=1; AJvYcCWvY15s3N0h/pzRv4EOO7KJSs5czbB+ikGx3jaEH+zu4DlymaRUpHl1RZEGpNDdB+pneUgaNmHMznKlUtykVWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznjzTIavRegg0vza+hWmAjLORaTRMeb5PBLcdB3LUid0ak+Xov
	PRsxfCXWFfxBJE47SUJQJDs5gwaFgo4wil0/MKgIWsMyHOgIDD7mfFe5s3snRWIsarOancW1Q5v
	G/6lwM8c+2AKwrFEzZZVVHlrte+iNaJPOXxlURr5p9AAsOUfbOqWKCqmwgM7xNVG8d3SWs6iyNU
	Bezt50Ho3WZ1mwCarm8dksbn0/ZspKZxJJXyh+rOemLQ==
X-Gm-Gg: ASbGncsVZrdqLaicwGHjq0xrnd6FLQgMYjQJsdJXaz1tlVB/AciMU9s2qOM1Gtnbcwm
	Fa1BTG/myKRFuP1dcSBXf5niDNTTbhbga7NI/quvx0BsK/eag6YaPT6EYzdKkL45q7iOl
X-Received: by 2002:a17:90b:6ce:b0:2fe:b470:dde4 with SMTP id 98e67ed59e1d1-30823670b3dmr4001694a91.12.1744365480556;
        Fri, 11 Apr 2025 02:58:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI1n5Z8D5yvjCWkAaXY4/KGC/DQqzFnZDGgKLa+mNp2DTPuSUov3tYEUj2t2409SXNjrimJVcrKkNOiyzN9oY=
X-Received: by 2002:a17:90b:6ce:b0:2fe:b470:dde4 with SMTP id
 98e67ed59e1d1-30823670b3dmr4001658a91.12.1744365480147; Fri, 11 Apr 2025
 02:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
 <685e784c-3f36-4cd1-9c34-7f98c64d50f2@oss.qualcomm.com> <0bec3e62-0753-4c3d-abe1-1a43356afc80@oss.qualcomm.com>
 <e7bd2840-dd93-40dd-a1bc-4cd606a34b44@oss.qualcomm.com>
In-Reply-To: <e7bd2840-dd93-40dd-a1bc-4cd606a34b44@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 12:57:48 +0300
X-Gm-Features: ATxdqUEgh6uca37YjS4OleFpbDuXY0MPOwXUGWqzyIIRj2finACospEgxJL2mn0
Message-ID: <CAO9ioeUeNeSxz7ADZ-BbJbhEKkszVS+SmbqaZCgTpL=csak=hg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Retrieve information about DDR from SMEM
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: oRNlFrIXp-CxIEYQl3p5NrE5nyqEwvVa
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f8e7aa cx=c_pps a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=aDpUdPclnTHmp7_NnesA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: oRNlFrIXp-CxIEYQl3p5NrE5nyqEwvVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=812 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110062

On Fri, 11 Apr 2025 at 12:49, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 4/9/25 5:49 PM, Konrad Dybcio wrote:
> > On 4/9/25 5:44 PM, Dmitry Baryshkov wrote:
> >> On 09/04/2025 17:47, Konrad Dybcio wrote:
> >>> SMEM allows the OS to retrieve information about the DDR memory.
> >>> Among that information, is a semi-magic value called 'HBB', or Highest
> >>> Bank address Bit, which multimedia drivers (for hardware like Adreno
> >>> and MDSS) must retrieve in order to program the IP blocks correctly.
> >>>
> >>> This series introduces an API to retrieve that value, uses it in the
> >>> aforementioned programming sequences and exposes available DDR
> >>> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> >>> information can be exposed in the future, as needed.
> >>
> >> I know that for some platforms HBB differs between GPU and DPU (as it's being programmed currently). Is there a way to check, which values are we going to program:
> >>
> >> - SM6115, SM6350, SM6375 (13 vs 14)
>
> SM6350 has INFO_V3
> SM6375 has INFO_V3_WITH_14_FREQS

I'm not completely sure what you mean here. I pointed out that these
platforms disagreed upon the HBB value between the DPU/msm_mdss.c and
a6xx_gpu.c.
In some cases (a610/SM6115 and a619/SM6350) that was intentional to
fix screen corruption issues. I don't remember if it was the case for
QCM2290 or not.

>
> >> - SC8180X (15 vs 16)
>
> So I overlooked the fact that DDR info v3 (e.g. on 8180) doesn't provide
> the HBB value.. Need to add some more sanity checks there.
>
> Maybe I can think up some fallback logic based on the DDR type reported.
>
> >> - QCM2290 (14 vs 15)
>
> I don't have one on hand, could you please give it a go on your RB1?
> I would assume both it and SM6115 also provide v3 though..
>
> Konrad



-- 
With best wishes
Dmitry
