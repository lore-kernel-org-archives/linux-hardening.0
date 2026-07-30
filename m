Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018202FD665
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429692; cv=none; b=RS1A6JQqBKXtgEw4kNoXoj3UoPFw0+vM+FbR6cqSbFgGKvci9RIiMmNU7bnEM5p5Wuxdu3X0gtEC/C7UlJTfobh5xrreCZyBCk0iaRX+sWdQSbEZnVG8nGzAHD2Fk466/Tw153RWc96Lg3GE2vYrTbO32oKCwT9wNmxwbpwtj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429692; c=relaxed/simple;
	bh=W1qHPOfiLKP9reR3QhYi9YeVhYLovQs0sDLJcbc29/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byo8loq0Ou9eILXFt2m+RdcBWuDLxvrT3Ex+nDLnC036QvvKwek/pQTXQs5YIlGPTOr8cLLp9ANq1XwdDS5eMr+OmZ8IUqaP7hGV3xjbPSBMrg3cTCs7gdhSUf41a+cgeUFBsRBafPsgOV/J7Sqx8CUb7HCEDsnYanBn2DWEt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P0dTlVDc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VmKViDoS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P0dTlVDc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VmKViDoS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWQpd1179761
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 16:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aF+l9BeJEjOCx930xc+un+WIoVHa/ZgTrH/eyrfC/jI=; b=P0dTlVDc8DfrJ4wI
	pytp3nTccA75LMtWp+hPPaH2FIDyucvJc7kaK5q8mDhNrGle7ySsOMYKUqPib6Ul
	n5BUUdH2o9OU6mc07tT2CVHB+KYKyl6YA3TeYBaHKxsXDhjDB/fK1LmSlom44ubz
	dJuxLCFcbzcQqer/yZgurp/AxMGPYU3fBu5eyPGylsomifbrpHShWeBY/+RwUSPB
	4UxFKqH1ynlD1DmpEiExcjSSP/0AVE75LqRlRRwG2uOGvS9p608BhwPmzvtP4ZRl
	MFzGDEfbPiLoJxjtdzWx3A2V1ipYpx6ycV4dmSEXgjY5XBxy45AgwG0ZOZqquiAj
	mV1tFQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8n80pu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 16:41:30 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66896a924a2so6087972d50.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785429689; x=1786034489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aF+l9BeJEjOCx930xc+un+WIoVHa/ZgTrH/eyrfC/jI=;
        b=VmKViDoSdRN6V1NdLzQSsY9D6kIdUkESqgdE9QGYHy9+OOBB+kbjbQ3LcIU7uEBIiv
         7LTHwM5BzfhGDCGMvhWu3UhxtlwQBLoEREeXWBvJX3wVX6DvUup3tME9hJ5HyKFsNkoI
         yE9ZQPFLmlKiH1OcVWituIrElCn5F3iqlIegxjjndKySE/yyYrggufje5ZuAZ9Kn79yP
         7hiToanYnAkiT2ehZ0/ZREDs1FkrteMs2GF6ECnMVGrK3HyB5Gm/ZAitrEmzKK+iCqVn
         xxFXwc157BMGq/FZrZoq1I07hHqJz+i+D13JjLLlTr/Yt9eAtfCBSiTQVHs8XQlfP7C9
         LUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429689; x=1786034489;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aF+l9BeJEjOCx930xc+un+WIoVHa/ZgTrH/eyrfC/jI=;
        b=aPu0bBeR5Kmz0KNUh08P8SplmCy7DWXwlHLg6HjWuxstYDzTMQOWQ81CMwCmhUm9GR
         TA+fzZ3xrD+bBnO9kCrC/nadoCbHY0cekOenP8kSZw/DkgQnh5IEXIKx1c+fu97BvxVN
         OImtAqo9DnD9FUgsB4h7Zt6pCcoNNmgUZitdE0FA3HF75VPw/ajA7pCmw7BklGsznTsO
         4fCa/othn/RQGiPEw9Op4v4IJk7zH5BFCQua/H1DSous4U1PnElswEptbrTu8D3XO1fb
         m54+vhcQHgzRf+XoXa1L33kXJgpZK+oBsbqYw/1eNPTOhiuqyqJs6+t4PcY7roPrAnQ/
         8CrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6Y/XzXXVLPpOU++g6gfYYzeDLd8I0J/PWPtHe3L1FEAaDJxwWGD6ySbtjHxB9JZtmHh+ijbs+z+UlAJLPXSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhOFgFCMySuqxSl33UAiMjRKLE2/Vxnqll87CZHRccVA4UIC1z
	Ay3e7T11fX81uiujHaUgegWVZchMkrFRvqVkD0vmbyV3tMbACUrkRtvguk3f+KEvv6omf68JvNs
	Lc9oOLmDCQpNpEyzt2GbiCGaEYjSbaafrHcJcB6duS9RGJX7PxZMrnqpQRduuydDmiKaOP7g=
X-Gm-Gg: AR+sD10aRcDrItETtj5TjUc2fowAoe8l8WZVCZSJ/2NvvXGn595wH209AK1w2oeImnl
	ELmdVBewTNMvcDcAKak9E9ofUEPkvrCf6CSnJ0soPvIrVvs08DyECJVLE1Q3z2gyIKQNo58wdN9
	rz0tjozcXSzI7ZC0zFPZ21mAuQSdyBfKvdIF92UFKdTetXDxrtXUewWuiGRT9US2CJ+T4u/Ukim
	aaeHdY8hxv9cDtESlySGR4vC5Y78K0tIlUG4OHRrHbh6N6ZKr3bxF0y8giis76nSlFMtC1sx/uN
	iPJ4+dXHJ+/JR+nueA9pPYIPEyKrfJZkatzom5JDOxT/QhVzl0qWJoen2qTxazib6P8WXTHyuQN
	oDxHoWAjBlHUUzTzG6W2dg0ZYl480htX/VDVmtiDYhgmiz71SZOxVpEyZHB4gp3UDyA==
X-Received: by 2002:a53:aecf:0:b0:667:b5d4:98a3 with SMTP id 956f58d0204a3-6693a62cff9mr530855d50.96.1785429688498;
        Thu, 30 Jul 2026 09:41:28 -0700 (PDT)
X-Received: by 2002:a53:aecf:0:b0:667:b5d4:98a3 with SMTP id 956f58d0204a3-6693a62cff9mr530830d50.96.1785429688008;
        Thu, 30 Jul 2026 09:41:28 -0700 (PDT)
Received: from ?IPV6:2a01:cde0:108:24ed:2206:62e9:bbc4:c360? ([2a01:cde0:108:24ed:2206:62e9:bbc4:c360])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c95ca34sm1627738d50.17.2026.07.30.09.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:41:27 -0700 (PDT)
Message-ID: <ac813518-1fc2-4262-a166-dc54545bff9b@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:41:20 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] arm64: dts: qcom: lemans: Enable CDSP cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
 <20260727-b4-qmi-tmd-v6-6-973cd3a226af@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-6-973cd3a226af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNSBTYWx0ZWRfX7IawB232qpI5
 8OEHNUi4hujYuUyukuVwxr9xFrVD3erg/Kyi/Yk/gfbLrNRtwafZck44ar1Q9IqrnsC3+Qswqbu
 W0rJnQbHrmg0W2ZxW5h8YtS0pvAObDwki0g9c/aBBpH+fLMrS/iAw60HXfxkcP79pHkR1xVd9MU
 yMEgB2tVIgNt4D0f6ONXLHxHjf1rSq6iD975XfBwIFJrfny6ENlHL5jxnsx3TbMqILQXzkZiMrH
 pCdVGqUyi6Z8Z3bylf3XlRGUkfOObikL+gMm72R4dCaz/KnERlJkt7iFR/SUYuSFjnaBC7xb5sO
 MrtebT0Ubqk92z4/8NPPEMZs0LTMK3SCCh6gyO55t/J46fIhpkzmoGeYzF0py6T/C4GqE5XSLpb
 GjCKk2dtNHTQur/rXxdo+HCLo8i9mmb+cvJtDd7xMRlnCFb/AyONhVLK+FXAhM5YGoueOyEIeiQ
 0lHHn1cBFyvIb8LIZHQ==
X-Authority-Analysis: v=2.4 cv=DNq/JSNb c=1 sm=1 tr=0 ts=6a6b7eba cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Oo7k-GI02y8c9wmTVmcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-ORIG-GUID: OUkrGRtUd8jJaCfGtDfSD76pUbV5dF51
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNSBTYWx0ZWRfX9duQiUEEghzV
 txUDcPOnj1eNliBJZTwItjNT71zldvxjCSbAB6MFudPTOCDE39iXdHoHdpOE+MYNxjX1fTUdnhw
 NIygds3mLx/EmUj0F+CTXKd3lBFA1yw=
X-Proofpoint-GUID: OUkrGRtUd8jJaCfGtDfSD76pUbV5dF51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300125

On 7/27/26 16:22, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in lemans.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 105°C.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

A side note, not related to these changes. The passive polling intervals 
look very short (10ms) on this platform, may be worth to double check 
these values in the future
