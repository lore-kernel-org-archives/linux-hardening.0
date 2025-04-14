Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5A29C32A
	for <linux-hardening@vger.kernel.org>; Mon, 14 Apr 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633726; cv=none; b=Hbqom9JM7OCsjuYIDGtOV0DQsExqbXEU5+/Cpmn7E3gSh9MXTAjWdSXprLgmsUIsGrETUNUoqJSlrelHg4NCIias1xTgrbMRraaSf28x4J0+RtKf4I6gjH5XZ/G9jOF23U6aeXJ1R4TCBtnzqWovWawsGHmjDx8LGYKQGe6VUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633726; c=relaxed/simple;
	bh=yLMAV/ruHL+C9lrddVCJdOuY2FwYy7O7zZy7waKpQcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mx8iPQeatWlkKD8AIKhyZsHARGFK9fpcUClkZKrpgsv7CVkEh7u9miyngbQ4xTtv/9kho8EqR+f7G+5sYMluQeKndXvnFRbKGCdGgh7O4Myou1Do2DIKo1wfZR3ELV/Oa839ho7D9NX7gGGB1KdqHIm6iFkMfeTwyJerV6jzA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yd+9BpfE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yd+9BpfE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99qg6011402
	for <linux-hardening@vger.kernel.org>; Mon, 14 Apr 2025 12:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pcD1hnXGwP4oWvtyhTXiHED+
	7VwXoSi69a6mb6yqA1g=; b=Yd+9BpfEuiDZ4o/Ei13vwKatWPUgywArkggTGnCI
	aUqEK9J9iWqvBpLlxSiHIiQQq5PJg/vPsNHry2jB3eKMYj/wSY2m16gPSoy6SrAn
	hNPTp5iVvDB9KiH4NXikB+J1aiQk9I7pOHGl2jCV12mTCbyDnL1rr41hr1+9h3wV
	RUNUCh1oBMbfacU+FgGhTNHxEs22+Uql/ZBoqUJLm5/Kr48jRxmNQe2uG14YoYFB
	4DL8er5NgTCnE8LEpuHwQBBArM49t9h30D13KxV509+j7X7Pw5FjpTKg/t0GRPUt
	NlSf8BfEFiNA3jePsKh4MUpwx3yn1v7r2WCvwJUE01XksA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wcg7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 14 Apr 2025 12:28:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0a3ff7e81so803734885a.3
        for <linux-hardening@vger.kernel.org>; Mon, 14 Apr 2025 05:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744633722; x=1745238522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcD1hnXGwP4oWvtyhTXiHED+7VwXoSi69a6mb6yqA1g=;
        b=lpUVDexOHIeQXohvq6i5uOHtfqrO3iru7qwdPqVy2YQ1ssGgtiEMFDmaZ9cU0W95oB
         nFxGrxPnrBrvNWkRUpHHJNxJ8WPzGmAYiekTui7kiI398qkwnbDxAo1NOYwFIMc6vIhk
         kczrIQ0rT03TQLWlUeKSEE5vovMGR0TU9qH39f7uRBO/8a7IKJ4bNh4UwZWcsvHx+k2O
         Yma9GSfGsRe6FnjeLMe3OZAM15KLFoczw8POIcPaCYzFxnnEANe3qd2JB2ICnBkMCjqk
         lsnnHNgR2aDbE2ajkTbW7T8h96gRhgbAiMg8IDGXG0U3KyTPqOO161JjrpbzuoK7+GTB
         6eVg==
X-Forwarded-Encrypted: i=1; AJvYcCX5szm5VXXCrZG0n2CQDuVMTJM4IblF4rJcFlMt8f6X+XBVUxbzavuxQ3iTu8ZQ9HEdJ7iyWjpGpw2ddaYEByk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHk4cEyrjdjn9vqWCtgxjAumj2lW0UWUfNIbF79dPYbfpNhZCL
	h2Tppa1tvMtfvPDJ1s7ZgzAh+em9Bryj46jtj3G49sPEEhPZYRNWLIOhftEwZvWCTVGrnsEpL35
	fuatFZrGzb/W0wN16gadk++tJAaIwb6j2wsrjRgnXtOITXbK89P41OSNHV3KPonszSTY=
X-Gm-Gg: ASbGncu4ZbuO84wmxrYqHktRgG3kDmYlKs4CT+VBneVL/ENd0/gq5bNNSQarxRO1TFz
	Li1c4bAFoWp/6+8Wttp2ncc1kkNRAvntUK6bEN0z4RRMdUjloT3lJwwxow/u0JabcIqjLtg5qLR
	cdyhmMKqoVtOs+wlIx/XvobQfBdMd1uErJh/KXrKuUe1qPrGjahX6lF0TojCDNMxX/xID/QuIhC
	PlwG862NaW+CP+VKZQSDrzVDhOihtt1OpRsLIFA2R2vwcQTXKlQeadCyfpGMLLsLtwvODyDa5Ic
	U6271QBA3ZNVzvS+vt/1rvGxqiYztROgPKU7VO2FgGsC9vd9YHsJfnMheVhQJuN2dtIkzoPZF78
	=
X-Received: by 2002:a05:620a:178d:b0:7c5:3c62:804c with SMTP id af79cd13be357-7c7af10c99cmr1793638085a.21.1744633722074;
        Mon, 14 Apr 2025 05:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsetSET612d6fMhQCBXpRJnTz65qWucBdrgE0bNMyx8ZlJtaAzw/28Nhs4mXaotD4AP0m9Gg==
X-Received: by 2002:a05:620a:178d:b0:7c5:3c62:804c with SMTP id af79cd13be357-7c7af10c99cmr1793633485a.21.1744633721593;
        Mon, 14 Apr 2025 05:28:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d238b8bsm1084415e87.88.2025.04.14.05.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:28:40 -0700 (PDT)
Date: Mon, 14 Apr 2025 15:28:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Subject: Re: [PATCH 0/4] Retrieve information about DDR from SMEM
Message-ID: <qdip4rtk2zusxkdlui4ujnybsh7jfqk25tazx477tueytp6cbm@dom2fduk2r6z>
References: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
 <685e784c-3f36-4cd1-9c34-7f98c64d50f2@oss.qualcomm.com>
 <0bec3e62-0753-4c3d-abe1-1a43356afc80@oss.qualcomm.com>
 <e7bd2840-dd93-40dd-a1bc-4cd606a34b44@oss.qualcomm.com>
 <CAO9ioeUeNeSxz7ADZ-BbJbhEKkszVS+SmbqaZCgTpL=csak=hg@mail.gmail.com>
 <b04464b6-2ad9-4866-88e9-437e96645726@oss.qualcomm.com>
 <sgjporlde6bgcp2mhr3r5c6wj3a3u37s5nlrrokbutsyizixod@7shpt55muqki>
 <4e265348-3466-49fb-82e2-255205052d1e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e265348-3466-49fb-82e2-255205052d1e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67fcff7b cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=MwWKvEgEnNFHFowGc98A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: xbOyE9x0EUHKpJr9h9s0i62iD0qd36KO
X-Proofpoint-GUID: xbOyE9x0EUHKpJr9h9s0i62iD0qd36KO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=470 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140091

On Fri, Apr 11, 2025 at 12:52:32PM +0200, Konrad Dybcio wrote:
> On 4/11/25 12:50 PM, Dmitry Baryshkov wrote:
> > On Fri, Apr 11, 2025 at 12:03:03PM +0200, Konrad Dybcio wrote:
> >> On 4/11/25 11:57 AM, Dmitry Baryshkov wrote:
> >>> On Fri, 11 Apr 2025 at 12:49, Konrad Dybcio
> >>> <konrad.dybcio@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 4/9/25 5:49 PM, Konrad Dybcio wrote:
> >>>>> On 4/9/25 5:44 PM, Dmitry Baryshkov wrote:
> >>>>>> On 09/04/2025 17:47, Konrad Dybcio wrote:
> >>>>>>> SMEM allows the OS to retrieve information about the DDR memory.
> >>>>>>> Among that information, is a semi-magic value called 'HBB', or Highest
> >>>>>>> Bank address Bit, which multimedia drivers (for hardware like Adreno
> >>>>>>> and MDSS) must retrieve in order to program the IP blocks correctly.
> >>>>>>>
> >>>>>>> This series introduces an API to retrieve that value, uses it in the
> >>>>>>> aforementioned programming sequences and exposes available DDR
> >>>>>>> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> >>>>>>> information can be exposed in the future, as needed.
> >>>>>>
> >>>>>> I know that for some platforms HBB differs between GPU and DPU (as it's being programmed currently). Is there a way to check, which values are we going to program:
> >>>>>>
> >>>>>> - SM6115, SM6350, SM6375 (13 vs 14)
> >>>>
> >>>> SM6350 has INFO_V3
> >>>> SM6375 has INFO_V3_WITH_14_FREQS
> >>>
> >>> I'm not completely sure what you mean here. I pointed out that these
> >>> platforms disagreed upon the HBB value between the DPU/msm_mdss.c and
> >>> a6xx_gpu.c.
> >>> In some cases (a610/SM6115 and a619/SM6350) that was intentional to
> >>> fix screen corruption issues. I don't remember if it was the case for
> >>> QCM2290 or not.
> >>
> >> As I said below, I couldn't get a good answer yet, as the magic value
> >> is not provided explicitly and I'll hopefully be able to derive it from
> >> the available data
> > 
> > I see...
> > Is this data even supposed to be poked into? The foo_WITH_bar types
> > doesn't sound like a very stable API.
> 
> Yeah, it was designed with both the producer and consumer being part
> of a single codebase, always having the data structures in sync..

I feel somewhat worried about parsing those structures then. But... the
only viable alternative is to have an in-kernel list of possible
platform configurations and parse the /memory@foo/ddr_device_type
property.

-- 
With best wishes
Dmitry
