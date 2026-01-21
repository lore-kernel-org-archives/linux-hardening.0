Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B3481242
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999547; cv=none; b=Sf+ScWFCWGAiHQlX2E1oqKQAMHNfRJu1jYB+T+HNUSMgdV0Yp1+pHwzTlyisdmc2E5DXOUkTpRqtDMWrtO9C6oB5RkHDyzyLf37Vy21DsbOOQ8vQ/42do7aBE2wcZvB56uaxnC8bG/87eowgDl6kVEBq08hwMVwaQttbOWfAH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999547; c=relaxed/simple;
	bh=G4+FPG7lsr9cdLya5zE4pmWXyJuqYHbmPTf8gMOA978=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhzUztA2TOusrVimWPmXacON1E9OZedA30AYQLI0oM5IeioYHv6lfLBURCyqIChvU+gTSdijV2YXty/5U+4HBrfvJCUM++fkdX6n9HI39NBq83Zj3fFLWK9NiWUrMdAVtuXuSuM2mRXmaBYNRGkoO+0WV6IZLJMwcTm9F/gVFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VTJtBKpj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MdRSmx3W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VTJtBKpj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MdRSmx3W"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L9lKQi2840471
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 12:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0wgyzjP53pDYgT6DSPTCMkOEuzt2+jWBFYYtjNfK5Wc=; b=VTJtBKpjm3UfYAlB
	WgLTF1zHVtwEyzLcJ/XLLJSClBLfQRMhP54ePxyYwFbrefPau/1Xq44z2213AYpg
	EG+QCR5Nr1rZXDZkul/KOEiG9ZxX97NWhPZ4+9glhrdhG5bjxXBD+K25jy7Npg96
	sPCoZu+maY9YmED3y5FvhJ8pRi3cZr0b4HczKYDBkfc0Ib4qVS6c/xRKVAz27CT8
	eyjSP7cqGdvgMgkRVZ6zukHkMIgvTJEZDV5isRsFAyFCbq9MwbESgJU26EglQz5w
	eKw6e31nFY/tzix+gmunzHWrGR/iRCF4Ehu4wnx22Dbwh5ZidFjYExkxmja+VeBz
	D0Q1lQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btqm1t0pn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 12:45:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6b48c08deso75194285a.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 04:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768999544; x=1769604344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wgyzjP53pDYgT6DSPTCMkOEuzt2+jWBFYYtjNfK5Wc=;
        b=MdRSmx3WtfGVoifwUjsFLk3r3JDAOtVggCiDKzx899VggytT77OnOqmEQq1iucySd8
         QK5gfusEP2tYoE9q0fi7x5aavyrRvnvEC1fcdWVzAQAho8IkisgWEVv/2+rGT/nNcqAH
         XzVlNlwYD8CUf2gob7IfLZH3GrSXjDb2md5f52Ih3gCid0GOA+PwJn2ryUu6my0LNG2e
         XJ7ry/fMW/ISSXEpvjtT2q63kmSp8lip4EjgTM0oo9wTmkuTrlN8NgxijYGS3lW4QXdP
         J+3aDrWTYb1nCHOFPf4l978MdstteHH7HB+M7qgnWmzIwc3O++RTWhzhYScmrxa8h3Ci
         Zlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999544; x=1769604344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wgyzjP53pDYgT6DSPTCMkOEuzt2+jWBFYYtjNfK5Wc=;
        b=C7eg0Rjs76X219oWucb3gN5+5G+HfY36UuZKrMA3gcrjNOAPt5nxkLn3s+IstYABvU
         RTnVDknHrPnikzwl9bsB8mIiExjvnhHTOI20nY8uv51tXBhKzJIeAUTunnsbru7m0Duu
         LOkeci3HC+g1JgNAukozMn2VgO4y7wQhPsNU4hFgKuHXmsyj+ilQ4p5KP5qRD2EvUvgu
         /9nCTMnj+tIZ0mZ2wBaqw7rqzoz8MkMxW+YzIE1Hc60VJEYvHazGl23REhQCA1eliAgh
         CqlSrw/+JkBFK/zZPa0a79aOQ6MV9PNiheI78F/Uui6KZ54eDdYWz/Y1N2R3AjRmXYoN
         cfAg==
X-Forwarded-Encrypted: i=1; AJvYcCV78LQQH0enBYZFOaJbqKf7T9kn92B1zlHK+fy7NJfaQGWHfaJf+yp9RY9zYL6ST3gS9mhYHeZd/qiV1ihuHuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0MgP+V/UFjhzVb6edLh/LtKE2qUIuIX8miO4GUP3MHYUSwKy
	AigSyvCi4SaYFfl3RmbN4AVJ0LNMnuEbidxES4gOzjTam2PCfnvrtDbiAp3dHrbmFPjrlFr7UR8
	mtbR+eUYWe+qvi0cJgsFEC12eAWPMlB49V56/8DtZQ36LbNpDY55ogbb0RR6Gr/6gGtVQVDU=
X-Gm-Gg: AZuq6aJIAwFhmw8d4VHoN7OFbHweJpwCYHGnTCU3MmJJPYztSr5dMtqJ/wkvSEHH7kz
	j5SbUXxhq8U0O7GUlCJchDsud6NgiLyHn6D2OhXTR/qfpJW3Om8sHyG/+VedFobZcZAwNMruj65
	ijYDAgVPeuz2QrcEAfgzTC2fJlz8ib8U+v6YnMQ6EIO9PaBAYmomOmjVEu8m5yithIfV2yx3648
	gXcH6hzaNfLl/0Q6t5Xlni9D8PRgVC1ImE+HYode7TGHkl5HdPh5mHOB4KsxtOu6oVjFcf7h8S6
	doLFZvOAP34wygfM/8+1kcxyRIyh7d1OJDG4r1HlI0LcesmLIbPGCZVmRJ8kCNmFrMCkfmijB9g
	sXOru4thfJIp8CQ+4AOua+7lxoTFsr+Sy6fhTf8raYDFgvUSubjqXnTWUbNrar1nT/I8=
X-Received: by 2002:a05:620a:198d:b0:8a3:9d53:e1e5 with SMTP id af79cd13be357-8c6a660afdemr1968714085a.0.1768999543840;
        Wed, 21 Jan 2026 04:45:43 -0800 (PST)
X-Received: by 2002:a05:620a:198d:b0:8a3:9d53:e1e5 with SMTP id af79cd13be357-8c6a660afdemr1968712085a.0.1768999543386;
        Wed, 21 Jan 2026 04:45:43 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9763sm1487409866b.35.2026.01.21.04.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 04:45:42 -0800 (PST)
Message-ID: <01d254f7-8c62-4061-ba7e-f358f1904ba5@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 13:45:41 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Correct
 reserved memory ranges
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
        linux@mainlining.org
References: <20260116-xiaomi-willow-v2-0-4694feb70cdb@mainlining.org>
 <20260116-xiaomi-willow-v2-2-4694feb70cdb@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260116-xiaomi-willow-v2-2-4694feb70cdb@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEwNyBTYWx0ZWRfXwSmYzNB5Mcsf
 6MertsLUMJ9qcwtvBCD6u3qS8U+NJ+64tkfTQjgN9Z3w3xaC78h7JQuXTzMVBxfvn8BpWJVXJKn
 iqheKqL3L5Z5M3x3HayIFAhSDcX7ge2rv3lRBYAgcx4PNHCPgEQ6fRMFB7Rp0v/73PTW+MP36cE
 +UHHLsJaKIkJbW87JYSm7q2tLIhfz4O81fCJJHXXHoKE5j18pAfUozV7JoU8PszaqrlfEJAvkLN
 1w9av34WYHPKhIDzv3pPncDYjRORqJQY0F68ZgGeU+KDXPCHQZQ3T341NHl4mP0c+XZYwvqXiYj
 OOSIWmKyAtKpXWPjon/r4YkpR8fzxEl+KxT8RTWApKRrcjjx51neMQud8n3SK8Sa5r/TmzA9nc7
 qD31kJ3VaWjsRheWkeiti56oLSh8o7IsOwZ/VOmrv5gc7/3FP8jsYRbiMY6rofcTbG5lx0XNK6D
 2uBe3t2LVD4Yx2A15Yg==
X-Proofpoint-ORIG-GUID: G_7uGyencg7j38MA4umQbeN-sczhc1hT
X-Authority-Analysis: v=2.4 cv=dtnWylg4 c=1 sm=1 tr=0 ts=6970ca78 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=xRCo5Bcgn4OuC-SBfZIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: G_7uGyencg7j38MA4umQbeN-sczhc1hT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210107

On 1/16/26 4:54 PM, Barnabás Czémán wrote:
> The device was crashing on high memory load because the reserved memory
> ranges was wrongly defined. Correct the ranges for avoid the crashes.
> Change the ramoops memory range to match with the values from the recovery
> to be able to get the results from the device.
> 
> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Have you verified this new and improved(tm) map e.g. by booting up
the kernel with memtest=1 in cmdline?

Konrad
