Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2527CB2C
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364943; cv=none; b=biuvhwG7WvXBi+eJTTrDh8BQ5gpHgnF6g/ISSozrJJQZRMiYaU2GeeR/C1q7/zPgoReRaBoDDjzaiftJR2HrE13V6lYntm/oeqpBXSVZyAbzrZe6r0jVyB5/r8c+gf2GBOpudtnxExD8pycI//QqL1/v84LJGZ91SGaIBH+rGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364943; c=relaxed/simple;
	bh=1Cs7Olcf+iGn0kiLuKLVzTGFucVizSpTxlSXymspVxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkAkXWFaFFlEoZXd2nyCeiZ9nH4QH4+5Kwe1TNIoIFysuMtm8whjMkciu6WO9WVx/FLXH2DZGEcGeXqefqkiKcBDh0iV04MihNIQon2wGEdXW53EsdFwuoyBTI1El0Er0J3St90V633csgwHkNhbA2seWxLZOr4/zVkWeE52k/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=moQeEa2I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="moQeEa2I"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5nj6f028877
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 09:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Cs7Olcf+iGn0kiLuKLVzTGFucVizSpTxlSXymspVxU=; b=moQeEa2ISOojle/w
	/JoZ35u9aMiF2+p6HCZg34oGywaDgM3UO6AYsquLopCnm2ii7ww9VjjFFP+6ILWf
	1yWC6q24vXnxgxjQ1HdvUSFoWoMniTAKXLQenjw3n+7B179Zujl5ABxIQyNZBvHb
	FKsuGrlN+HAxQlaw9WhDATIC8yFlE1WrvzrFhOIxeJPBFk1+N7b/Hh0Tx7XroHrt
	SzmGACtbeVq9MutycP4bCOvwBrAn6juwgncxGlsrsd8v1kw8I9zFRB1wfSPpFPXM
	vnrVnTPxtVCU7Y2iXQ2nubr2mOfGdAswvuYdVe6buWL2r7RW3LegenEu7yxad+sW
	5DrE+g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbut027-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 09:49:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c552802e9fso44473285a.0
        for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 02:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744364939; x=1744969739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Cs7Olcf+iGn0kiLuKLVzTGFucVizSpTxlSXymspVxU=;
        b=XQrFX5+UlxXd888zT0RL+dPE/s5NFg+TjC7gk+AKpv+QEod2JQVdeZ3Qoo5icbkBM/
         3hqdQKZnDvbdRM3MwzGUQ/rCYOHobcpVUPACGrONkn2JIQfLm2uyMv1FiHqEQId4M6kc
         W5xef110gDJZKx4wFOv5XY5mh7CxV3yaSnB4lBS3aOvjGlpf6QQ2OABJIU31n2ISW+mR
         6nGhtY+wSQtVmwB4bfciheVOT4bl4/7JKF7oBZQk2twGFq9sWkmSo5PdkWAZdoqJ/d9y
         iRcojh0+eYBz+BAVbCLrM1WQthteO+HG16VxP0Iinq+05qzMRIfRcXVH8mVJ2MM6Ax1d
         I0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUldisMiWReFaDLz7TCjXIJRnkXso6CiiCCE1/PG+qgr0mNa6CNie251IhBJ6QMHsEEH+2abVwHEHccN0PqDv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFGTnoAS8c85QpPOAU7+TsFXgBbzEorR+uQaxTU9VP/wrF8gM
	TTa9DzYB5TXPqC5tJnp3qX/+sJZRAUZY+EG3GZtGN+9q0+LqL1avalm+JN0+/V4e/aClwIZmv3D
	z5YUtnMnf+8fh4Q2dVm2fliWdDZ7X/rCxplRQVDTYShRySURDUpcMFhxPN+2IUW2gt+w=
X-Gm-Gg: ASbGncvRLu+EJEluK9OnszbNk1DLmlSWjw+COBtn0/SbxJamU15e6BXlyTtCqZ70AAw
	VL90LsavyE6gWn5ya6+d737lKZ0DwIjLiExISCcFnlWuu040oGhWTcGzyhl4SepMmFDyofJczG7
	VV7M+3TN+WGHQmOY75yie03s0jDXYjp1IQVd4h5UR29ZnmSCKPnDSXSKep3iCZG1PoxRz+LyoMK
	Q0lqGftsCz3Or6CgYjuCLxotwyUecN0biFrYn2KVG2Jckcp3aQazHtaEAE84RpOrDXyF0+bfPV/
	se1cuIbVB8QsJfGpNzlWRDW0YWNQkhkPPzeapOf6mNcwjK6dOi0v7Y2VrGkWDZEqnQ==
X-Received: by 2002:a05:620a:254d:b0:7c3:e1ef:e44d with SMTP id af79cd13be357-7c7af04c112mr120740685a.0.1744364939590;
        Fri, 11 Apr 2025 02:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9uldhSMjj77tDXI8Od9HS0eE+YcyHVF3EP8I1eSD53hf5eI36oThMUSZZTFoT4LlFjZitIQ==
X-Received: by 2002:a05:620a:254d:b0:7c3:e1ef:e44d with SMTP id af79cd13be357-7c7af04c112mr120739985a.0.1744364939225;
        Fri, 11 Apr 2025 02:48:59 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4204sm415022866b.116.2025.04.11.02.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 02:48:58 -0700 (PDT)
Message-ID: <e7bd2840-dd93-40dd-a1bc-4cd606a34b44@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 11:48:55 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Retrieve information about DDR from SMEM
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
 <685e784c-3f36-4cd1-9c34-7f98c64d50f2@oss.qualcomm.com>
 <0bec3e62-0753-4c3d-abe1-1a43356afc80@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0bec3e62-0753-4c3d-abe1-1a43356afc80@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lnUdcTH5jwwtNZ09loSBfsAcYOzo7OYT
X-Proofpoint-ORIG-GUID: lnUdcTH5jwwtNZ09loSBfsAcYOzo7OYT
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f8e58d cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=ur0lq8UJKF3ET7YIcuwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=797 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110060

On 4/9/25 5:49 PM, Konrad Dybcio wrote:
> On 4/9/25 5:44 PM, Dmitry Baryshkov wrote:
>> On 09/04/2025 17:47, Konrad Dybcio wrote:
>>> SMEM allows the OS to retrieve information about the DDR memory.
>>> Among that information, is a semi-magic value called 'HBB', or Highest
>>> Bank address Bit, which multimedia drivers (for hardware like Adreno
>>> and MDSS) must retrieve in order to program the IP blocks correctly.
>>>
>>> This series introduces an API to retrieve that value, uses it in the
>>> aforementioned programming sequences and exposes available DDR
>>> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
>>> information can be exposed in the future, as needed.
>>
>> I know that for some platforms HBB differs between GPU and DPU (as it's being programmed currently). Is there a way to check, which values are we going to program:
>>
>> - SM6115, SM6350, SM6375 (13 vs 14)

SM6350 has INFO_V3
SM6375 has INFO_V3_WITH_14_FREQS

>> - SC8180X (15 vs 16)

So I overlooked the fact that DDR info v3 (e.g. on 8180) doesn't provide
the HBB value.. Need to add some more sanity checks there.

Maybe I can think up some fallback logic based on the DDR type reported.

>> - QCM2290 (14 vs 15)

I don't have one on hand, could you please give it a go on your RB1?
I would assume both it and SM6115 also provide v3 though..

Konrad
