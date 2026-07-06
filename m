Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406903B9618
	for <linux-hardening@vger.kernel.org>; Mon,  6 Jul 2026 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361501; cv=none; b=nVCRSlK29orilmn8fKwq3JJjiKxC8T9b/NB6woNXEDFCdvKRKQTCUj18Pf0bA67ZasuGZioxnzWHPiizbhf9Y0Y4KFfSA7aN2UobPY3+brErKNT+rxdtn6e4UYTmnoDWjbnsYTkkBH4K4No4nVZO5KoqWoqlXPCNWoR/ir++GHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361501; c=relaxed/simple;
	bh=U4koz++ZA06ISm8vxFqnVpmFyDBe9iaAT7D7rWX0oR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eO4sDJ3w/lc0JUEyTTN33mbNYA/xLDTSBXAltCDdfXTAbk7pBZpsl99FULKnbH+GupKvWqsnLwoAct836boCRzP6QwWw9oSiqmf4BMlsQm6GhaxKNomNKQIB2IoXeiW3gFme1CGoZ132MYYiTkpvltfPV7Ph+pdcZMzHy5VaYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oyAoY2mD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OApJb2F8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oyAoY2mD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OApJb2F8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF5ae947311
	for <linux-hardening@vger.kernel.org>; Mon, 6 Jul 2026 18:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AdPbV9YRxG+cQo4afaZFPHUjWAQxmA2bvmATYgT6CTo=; b=oyAoY2mDnXL/VX8Z
	EBod0XnqCv7UgO1YwDq1XxWWC5SMRyo0RZF/U1lU6Igva/NONMIpSecUBdw+9xKC
	ujlK2eyCwPYcM5RE+IBvDP0AbFpbH6LsMftZY+CXk9Opnw9K+npEdRFjnLD2GlzH
	a8eHyq/q3yCaR//x8mS3bEGHi4Tykxv4CkT68rJoCiv6yf6Su9Nx4lGy0kFJimhd
	peP4f+JzySIWAQjy2gXu+DmbElL3DsGAEUO+fGeTfyRhnwQwsDy4fC4C3dgK6Vju
	5dW/qVhBTz40Qr2iPGQvhBnLe70lCcQ5BaaNikIIXQxrTVr85EByRRBhYRKM1Bxy
	WcUULw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h52q13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 06 Jul 2026 18:11:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e63df032bso10280085a.0
        for <linux-hardening@vger.kernel.org>; Mon, 06 Jul 2026 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783361498; x=1783966298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdPbV9YRxG+cQo4afaZFPHUjWAQxmA2bvmATYgT6CTo=;
        b=OApJb2F8bKGFA/EkasjNmPflbo5Zu2uz1eaeQX1/Y8XsgeBsnD+KCv7uOJ+eBBv4ZL
         LbRyHxyeVB3TlahzLDpaCpx+Fgm4h0Wp8Wv4SlLA20isbtJnhyPwzIOxbF1RgA+OR2zt
         QVPgvCQXdozjwWaVaLHZEcNsc0J01vK2CzCB2q68OXAIIXlaXM2qyBWEWrXC/368dnD0
         fTK2BcUNFekO1JuWlYAV7ZA5nSFbgsZhPc+3vRvXoQPJxfiwARjA2bmHUB3WAJYbgtyR
         6VgKw9w8GDixskyx71VLYCXHWFozePEscrru7a5BehTJJsJzSr5EldtcT8KcJycy2OzZ
         N/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361498; x=1783966298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdPbV9YRxG+cQo4afaZFPHUjWAQxmA2bvmATYgT6CTo=;
        b=jSCpW9jKtg6iWsP6cdJGY1soB/cEFU0LptvN/y0xJKXNDfz4P5flBA3DYAWbK8K1j0
         7SAUbpOte4/GI3aPT92O/3PoZQKvfAT9bmqcHtp6WuPJ7SJ/zBTCVrS2Ts4BvJOciyFZ
         anqRFMBzpRD6hgm3kH7S4NentcCit/vejTT/ng/qh8nc0aFoPqQp86Rsvykq9D9UVDzd
         pI+WQdJ1lAdfvGbhxUOJiTLGWASCYhMcZ8TXNFUnrVUkRDcEVaAN1Oa5nQ1GuVqHTGRu
         2izeOpN9r7foGt4as34fFa5U0TNI/6PSnxswm1GFDmvDJPPO2n1cd4e9dtWGCq8xIYm0
         2C/Q==
X-Forwarded-Encrypted: i=1; AHgh+RronR3LpyCkBfFJtiBk1t82cgjwqbbeB/jPFliexT5P27mETx5Sz+pFyb4YdEWPmvpX+2cB5GB8GgUgD7yHX5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4UyqWjwJgoYqZ/fPTIdPhrcWJK2Pj/qXnhcr8Z3fFZKqO2NJ
	KmsCN2TyPf24o9/gxYKuJqcNy+oe44IlCocMZ0/sfjN2m5IXkqjk4HGE9cNDn3MqGYz0Ke4V94Z
	o3WdMoV7cL+vsbHnmLIlvDw58q8nilqZY5s59zNBN1eiICxtP0+3fvtLtvmS5zXl8mQTFlCY=
X-Gm-Gg: AfdE7cmPf5Rj9T0jhdTlHh3M7np/NoI7Hhjs9N3gsG6RhJmBBr8EA9rFnHKuHpwBNvc
	nLv8SV/0nDwKECsLTVAP6GWGtEfZG0rJ7tBXdi0iBRqiSNHsDAJY1PkXZk/JdMynvb+l1wvGTHT
	MyFQyLenHPi5sugWoBy2IKTQ/qv+tiuPbpw0343RgtKg4W/9ZNZxQs6tU/pZwUmhO1qw2tiNcLS
	OioxQHqpcmHJBHmIJhBXN2WjbFUcbpk+ofeTGENULG2LqbC0eoxN5ZsmowEzkv3K0xLwMfhl3+f
	pVzvFytJvff6IssRu+e9eMoR8g5AP6BIThQNHgi3lEzupHk1UdHWP+uenbBg/IIY8zqYjASfEOL
	iGdQyG3hQCWMCx8LCTmHXJERyZE2IYyq/x26AHT/wUWFOCpRBOluapDNN8XVH5eolAmcw2Z/IjQ
	==
X-Received: by 2002:a05:620a:3944:b0:929:7356:2e51 with SMTP id af79cd13be357-92e8b29ea49mr2107011185a.11.1783361498232;
        Mon, 06 Jul 2026 11:11:38 -0700 (PDT)
X-Received: by 2002:a05:620a:3944:b0:929:7356:2e51 with SMTP id af79cd13be357-92e8b29ea49mr2107006285a.11.1783361497659;
        Mon, 06 Jul 2026 11:11:37 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm26585575f8f.3.2026.07.06.11.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 11:11:36 -0700 (PDT)
Message-ID: <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 20:11:35 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
 <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
 <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
 <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
 <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
 <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: H4aR1bMMchVG0d5_CrQqWL_O9UlaQA4O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE4MyBTYWx0ZWRfX2wTTd+rwpAhB
 s/B1PIhmnvE7vOia245YSecbZ4ZvRe5mix/HbqDWfpHF73u8RRqBeTGK5S+vpvlyaCtu2tFKDHj
 RRHPxx0mPvoNrUD1j6IIYLTLdsIU4Vo=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4befdb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Q9Cl1ItI0dfYaDPAyAEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE4MyBTYWx0ZWRfX2QP5oDFb41+Q
 JMwDYpwGjc6zZJFulamnFDj2znXgxgfZMvqARZZAbRuDFt0ml+D8gcndHr44dl7/NthAhOVia45
 7L2/uwW5xo1YXWN0FeVcLdGb4lVDFLn/TLda6LzyyhPbuYbYUjjhduO42R/xlM0XoBrPm0Luc+s
 Yir2RlJzxZKFr16V0zfBeTSa5ZDGPVJpkTE4FYJIu3QDRZ6RWI5g8238AVh5pxfux068MBeebeI
 ywf8PpY8ZabgM9Py9sGxP0ZTj2lOFUGZhb/Ra3AiJRkYW2Z3eCCsnpWI305kv7AvPL9V/5//5vf
 EIWiYdjeNdJ8B5/LOJK5xolKkw3ghcCGgpN5i6ryXWaAm7TrXexst5b7kdcy1nTgQbG7ZzL+Enq
 g9xchcQhppeFQKjMC/QBSBIh39DRO0o9cqDYod2KkDF6eMLrYJWkgOR8westTIHqHiNCQzoXSKe
 wWRdo5vqtihxj39shzQ==
X-Proofpoint-ORIG-GUID: H4aR1bMMchVG0d5_CrQqWL_O9UlaQA4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060183

On 7/6/26 19:47, Dmitry Baryshkov wrote:
> On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
>> On 7/3/26 17:42, Dmitry Baryshkov wrote:
>>> On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
>>>>
>>>>
>>>> On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
>>>>> On 7/3/26 7:03 AM, Gaurav Kohli wrote:
>>>>>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>>>>>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>>>>>
>>>>>> Qualcomm remote processors expose thermal mitigation endpoints
>>>>>> through QMI. These endpoints can be registered with the thermal
>>>>>> framework via the `#cooling-cells` property on the remoteproc node.
>>>>>>
>>>>>> The QMI TMD protocol identifies devices using string names (for example,
>>>>>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>>>>>> `#cooling-cells = <3>` requires numeric device id in the form:
>>>>>>
>>>>>>      <&phandle device_id min_state max_state>
>>>>>>
>>>>>> Define common TMD device index constants shared across currently
>>>>>> supported platforms. If a future target requires a different mapping,
>>>>>> additional target-specific constants can be introduced while preserving
>>>>>> existing DT ABI.
>>>>>>
>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

[ ... ]

>>> Why are you using only those TMD devices?
>>>
>>>> More constants can be added as needed.
>>>
>>> Kodiak is one of the supported platforms.
>>
>> What would be the benefit of having more than thirteen cooling devices
>> declared in the thermal framework and having only a couple of them mapped in
>> a thermal zone ?
>>
>> I agree there are more TMDs but if they are unused for the moment, why do we
>> need to add them ? Can we do that incrementally ?
> 
> That's what I am trying to understand: why the implementation uses only
> the selected two devices, if the modem on Kodiak supports others. How
> can we find out, which TMDs to use on other devices.

My understanding is that is an initial thermal setup. Gaurav will add 
them step by step while setting up all the thermal zones instead of 
sending a big patchset. And TBH, that will be much easier to review.
