Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5112686AB
	for <linux-hardening@vger.kernel.org>; Wed,  9 Apr 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213801; cv=none; b=aqQI1e76M293u2BoKSom9glXC10XX9quUldwB+fYT6uD/jcQVt94A1qODTeJw9VZTqwbKDllrUodObXHPE1bRDLZn9RjFSdZbaAWojPAz8iP5hpUIeNNZwC/p0eJZehDqpkhHavJ+32mvCynJ/LpJaS3mfHkk9SKxWoePWp0IIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213801; c=relaxed/simple;
	bh=LCxmsUkc1L4qyYCSGKNDRxWncAmIJpFPTIKKf+qZMpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hc1NFU+5U7U1nE0sxsT6VrNSyiLm0oFmGI4SRhFyxXFntdDryo1kA0twbQ5v1PsKSNhRlZ3uPi3ZfgQR+G8VkAgrpdxsR3yBdrEN4jWlVNIPk/BBt69sFqDgHJpmB7hF7FdNWawa60rDVxCaTFRLbjjpxU3/EVZLBwQUhbkkBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=crSzCxjW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="crSzCxjW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539967mG006872
	for <linux-hardening@vger.kernel.org>; Wed, 9 Apr 2025 15:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OfB1diTu8S+2+IjYQiq6NxbHo6UapGpX/p/Wbz6Phn4=; b=crSzCxjWuljA7YwG
	3hvyP3B4qsWxqr+qYYgK9MlYP5erpW2GWyefuR1r5vpHD1cy8I9TWSE4Izkf0gVi
	9C+SZeQhcibQfmpJupsNlTbcXJC64QGCnttIYzLLBtWXRou5/MgEvypCqYO6Jh8B
	WW5QqllGLB1y4v+WWbjs4KMz2Hs3OkrkhjO7pRUqfKRCsNXcPJSi6Oo0QGqkOjea
	/imDrzNxxhX3QrN0yoE8jeojpfSpdauv+mF7J3E/c6wjMSTNOIcALw66p8Oc+xIA
	YhYeInXE1V7/Wqyyv3Hqqs5S1/QCgdCH4uJBuE0LZI+wIp7vpA8P9/r2RGgOs2qX
	3KN16g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3kv9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 15:49:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6eeb8a269a7so19749016d6.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 08:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213797; x=1744818597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfB1diTu8S+2+IjYQiq6NxbHo6UapGpX/p/Wbz6Phn4=;
        b=Ru2+KgezR1ZQzWZHpk5cTvnB9k5LRRber/fDIvQSPUszDOr4PkdzLyVFlNWGKIPv5O
         SMTIZNN8+mx39BxCGhXj0mV3QjeEhjLqa2Snh60kzzYb5XzCHnC9vix0LoATe1eZP8rU
         713P2TB8K2Zcw89t+q72AtSGU/L8EPrlCHXD0QiaRK99KOcFt7YZkrNRLekr/A0hps34
         yJdXEsUbVVj3YzYX6OZ+i0KOkL9CEA9Zm96XlOM0hNazFzjf57H/Bf+9wvOzvQCS5Xx7
         2LtHgfv2OXkVieV/4z+8l8vRJYUuaCSqN4tQS4WxF5cKH+rQrxju/L+8L7dHjWID5sW9
         MZVg==
X-Forwarded-Encrypted: i=1; AJvYcCVaQ9vDKZbPYlhLohT15fW8OnAZTwiUkdZMQ/8EVGYqlX4iJqm3GfimLwywKUxu7LaVlWuf3rM8Nl5K9Lmjtbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6Wqu1yOAIz4AaA5XVaOjWwHgw7qxIJ35t4n/nu70iH9CnsUD
	Iih+SA25QEAOdzwIVURmb825gmsuEynqOx7P8n9ux8/UsytN83I7jyivPVVlw3JfZ7e2vIfgJdK
	AnK0ZHQ+Xl60G55a4NMtvamhp5+7uTdu22KtSuNu4lGpOEXMymhhvngpa8Ug3U5/ys7M=
X-Gm-Gg: ASbGncufkcJ+L9G1Oe0kh8GyafNVlCe9yIS/tRxehEPZ2R96GQv7mzE1vRtllE2GPnZ
	YwEuO1d1qLz88svZVaC+OIodcNdSubCHclug7BaFXAQtrh7BjYQ/mwR0jFoJf19mrmbSWTbulRn
	cNCjEEGo+BJ8wSl8kI22EZsLoetc/mjXF6yzR2uFWGSlyGGNAhavIFmtKgOt4GCwxkJQ0SnZ5KU
	9aGhTzP+W4TjvsDgPb7ywef3CQpIc8mMfbDvYZzmw3Z/ZfQJvr95iuoewmV0lOHtCk7kKMnghP1
	d5dOZW+FMrBw6AacljimWb8JumKRZcxpgygildYnnjWcQniNZzRlEW5yQJQO25YHdQ==
X-Received: by 2002:a05:620a:4148:b0:7c0:bd67:7dd9 with SMTP id af79cd13be357-7c79cc38a2fmr170376585a.11.1744213797595;
        Wed, 09 Apr 2025 08:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgLb4SIntY1KrRW8OaT6UF39Sv6qcj05/CcAG4bsBVpRe7H1ghDwXTdXn925CoiQqmrP0N/Q==
X-Received: by 2002:a05:620a:4148:b0:7c0:bd67:7dd9 with SMTP id af79cd13be357-7c79cc38a2fmr170373785a.11.1744213797214;
        Wed, 09 Apr 2025 08:49:57 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4129sm117214066b.98.2025.04.09.08.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 08:49:56 -0700 (PDT)
Message-ID: <0bec3e62-0753-4c3d-abe1-1a43356afc80@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 17:49:53 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Retrieve information about DDR from SMEM
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
 <685e784c-3f36-4cd1-9c34-7f98c64d50f2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <685e784c-3f36-4cd1-9c34-7f98c64d50f2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KUCBxY4_6g4-LkJxrDJXiap5sSN9NfVy
X-Proofpoint-ORIG-GUID: KUCBxY4_6g4-LkJxrDJXiap5sSN9NfVy
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f69726 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=bKdCaboesIjPuyFXCNkA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=529 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090100

On 4/9/25 5:44 PM, Dmitry Baryshkov wrote:
> On 09/04/2025 17:47, Konrad Dybcio wrote:
>> SMEM allows the OS to retrieve information about the DDR memory.
>> Among that information, is a semi-magic value called 'HBB', or Highest
>> Bank address Bit, which multimedia drivers (for hardware like Adreno
>> and MDSS) must retrieve in order to program the IP blocks correctly.
>>
>> This series introduces an API to retrieve that value, uses it in the
>> aforementioned programming sequences and exposes available DDR
>> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
>> information can be exposed in the future, as needed.
> 
> I know that for some platforms HBB differs between GPU and DPU (as it's being programmed currently). Is there a way to check, which values are we going to program:
> 
> - SM6115, SM6350, SM6375 (13 vs 14)
> - SC8180X (15 vs 16)
> - QCM2290 (14 vs 15)

I believe the easiest way is to give them a smoke test.

In any case, unless something is really wrong, any changes made
by this patchset are supposed to be corrections

Konrad
