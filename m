Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF253DA5C1
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369821; cv=none; b=O5qMZcQQ55yGKY4TJrMTCWJR24bs76+N9sRvpicBViNlpcOekzoNcyVYyQZiLxcR7J+/0P+UNvF2U69RSP/dMsvA9S1aVt/gmu6kvovNBJONtLmKUQkGCr55Wp/znl5cG6Zz+3Pj+8Q1XZZ14HvOFMc+2JwbJICqO0WmoD7JgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369821; c=relaxed/simple;
	bh=xJHqPBiTn94yBzMImM4YOFZy7uS41sjz0uqcdavPIHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sk4i1ZcwNg6bvG6EBL0JCnv3zZEqv/J2lNBZLpkl5qMAEitR+i4afLNKr22COzhaQREwhDBKM5Oz6a9+2Oa7Z/XC/nqkUHFK/uAT9luRw1nmMkB78Paut5FOvAiBifKEE1sdsWiYNCE8dNos8SU0q561U8zKq98MCo3mrV77K2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FcizD0zR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PDFUrll7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FcizD0zR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PDFUrll7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7UBm3440498
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 09:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rSgFwP34wCo85AXhGbCR+4Z8PnplijHqeQr5lFbp24E=; b=FcizD0zRNxc6cpHg
	57cp96c0X25V4Dg1/329BfSZWxMwjav9fnBsOhuvrLjRGlirvmTJgyxdzfEzU6aH
	CmH9V1X6eiZoBbOm9uvewtLkESS3c2Qlr20WZQ0BEvEpHqfaabvVYzq5dHjehO2z
	kPyD83i6EfmB5A+IiXuDh4LjbzYDjzVcfxWBuuntAx6drxwRwYpRHtiYjuDF0miz
	p8owDTw1csDLaJV6VpPFMMo7y3nKmz7JzG7jyDWkPf7YYMiYuCW9XQqS6BNp2yRu
	+pYwUNxn5uTZVyoJGNZCEPBBFzPTYJcELIyDyFabnwm33FUv3w8GFc4pypy75gC1
	v8CCgw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac43t30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 09:50:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b047093195so21447066d6.3
        for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777369818; x=1777974618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSgFwP34wCo85AXhGbCR+4Z8PnplijHqeQr5lFbp24E=;
        b=PDFUrll7DcQ8/zHxh5ZIoyNvbqxP3o7PPcXaAYyswwFWmFCnaaVksDiRVy0JqwvY+n
         Ub+JiEzs/wrxFuVCZL60nf7OzbtasJbHEOXH7vvBUrLko8CcDtGBrkCvlbsAwMy+dYzS
         bz2NKtMTISHoUCOZ64y14B+oNLo9LOsxoC8IB95DTHTXPf/miw5PunP3viYkjaLC9VuP
         vadMt91hpqVUobQXAft25qkyATMKfwGKP1GAA6HSYRDw4JQ29TljTR/k2T979zLsEkEY
         MsyXkL5Bh/rn+RP5+wSsXWS5IxliIjVn4f8vIq83ioWG9wLeIhXIIib7zQmSK2KszsVi
         Pt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777369818; x=1777974618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSgFwP34wCo85AXhGbCR+4Z8PnplijHqeQr5lFbp24E=;
        b=rnq249NbhipSBoFO2DFbFaMXcpplW0gbGHqfoyRtI7r/6tbhyM+5Gn6sHENoJ7L5Z3
         XQQJq7eMNXUnG0P3vuYGtgS+eu98+uhb1aQtnJ6zOV49rxgztHpZOl4Y5e4aLcIzcNjS
         YwqFiKPtwzFsxLwGCOKjoeogaMHW9rse1NIx6Q84QTjhvR4irMEoLxEfJK8ci7eOdwwn
         +VlJC7dZj6Lzt6vnjP88dFBSRSZEi/w2CIWZf+emOZCQK2v+GNNpGzV8KNKY/DX3XweG
         4J8f0g/thZnlcm8lH1mi2rJpPE37iKXRYlXPiA0OkaONKfUYHmjKU3ABrAauw+jMzwGv
         5VoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ZV3TJWrLXgXWTYgWR5ve897YJ/XVX/VthhtvLvQz82uVg9vwhdQEXsJBwj9tV0QBYiugTY+QLJ5UU2kFqukg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA3Oa77Vto0E5W5LcoeAdy/SLtLOUdLjPxFq1fwXPoJtgcRb5G
	KW58LtjDZM5oJZjW56Bq7QP0xSlaF0N9iimln1VG01gTXxkOyXVWbOxembQGuBJBZbYapKV+tuI
	G9/GWTPx3ksJnetl0i6t6DZ/MIXWmE+ekvKU1KpcAb+9rfFkWOn4iPm4CvWCQLqm9v11+JeQ=
X-Gm-Gg: AeBDievLhRVfQm00FcwxZDu2Rt5Y5uX0GjYYfoUXqVHxcFoYZyq0tvIQcCdLo+f6ygN
	btsAEYjnqnISH+eGYr4cGoIxNkaFAwwAC+1P4uN69DQVEXTjkkKosgqQ715yGFpgSbZaV6aQ+Og
	LrTLCQRLlIQ7Ahj6tuye3gQvtkZIQ736Q/G9O8jhqWoxlwMMlY/pOmBB9uvwFdpKNcHtZk8e7B9
	KRv+mOINC3rs+HUy3gi8CSM3KsdQii97KqlWCY+79LrBIE9zTQGnicpBNBdoGigAUZ+e+77NB9n
	ZnpNFW3POABpW5ZYXFDxobQqH7K3bQUFaa5cf2/AEscPRQsK8R4RLx+9Odja5Wbw9+f6cc9yuXU
	NpFHA9c3MUWchyc9SCUfbjo/+OhmSfhLJUeUyj0p7TJh2XSauL2Zxi4W/+LU+M69Kl1uTU+/Ci/
	sL1+UMdDpn4zTEJg==
X-Received: by 2002:a05:6214:caf:b0:89c:e371:2b42 with SMTP id 6a1803df08f44-8b3e283bb10mr30341226d6.2.1777369818264;
        Tue, 28 Apr 2026 02:50:18 -0700 (PDT)
X-Received: by 2002:a05:6214:caf:b0:89c:e371:2b42 with SMTP id 6a1803df08f44-8b3e283bb10mr30341026d6.2.1777369817780;
        Tue, 28 Apr 2026 02:50:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80853e641sm77209466b.10.2026.04.28.02.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:50:16 -0700 (PDT)
Message-ID: <e752f72c-d0c7-406b-b9ea-4ef4e6911e72@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 11:50:13 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] dt-bindings: media: qcom,qcm2290-camss: Add OPE
 ISP subnode
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-11-f430e7485009@oss.qualcomm.com>
 <20260428-demonic-albatross-of-enrichment-aa6f26@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-demonic-albatross-of-enrichment-aa6f26@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8cvxq7UOkqmjVUUYD1Dhp4xk-2Z9CeHs
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69f082db cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=axVsYsM61IUpGc0LCtEA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 8cvxq7UOkqmjVUUYD1Dhp4xk-2Z9CeHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4NSBTYWx0ZWRfX6E5DdejA34k/
 sWQfo2eCrX+PEiDgjpQw2qFdKth8Irsr7WLzUtJ+RXjKe+rnWr6x5Lz4265l4cRNPVO099y6BqB
 BJJ7fp7csFCGGo71QbMkRlmVxSStq9iIM+xF7J0Jo9/AiQFVMc5nnFbxcMxYVHNMhefMvK2psf/
 BiRsQnkHz1A7InZbjXNsQznbGcbL8saXfwtmVGc57dFefZiRyivrdif9hFnNdls2M5uTqiXbJNN
 HX1l65py0IpbQlzkxQAwguPt6YlsGO5WdVxIGtuw/wfLIU4lCgmncksiPIilZDxZNhGElfXlet9
 og5MHWGP9FT+wK/4ia0Ed99IOrPSaPVOTqNJNpFUAm2lF60xDug/q7dozp1URPR6nND3MPgFLwQ
 ae2iY80eIs4a6QXdNfJOCpxUTdHoqv4Q/zEsIisoI1hfbPW15/oWxyxbacjKdgLXCK0fetlISLw
 D6ayd+1xJL3IVWKq6zQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280085

On 4/28/26 8:35 AM, Krzysztof Kozlowski wrote:
> On Mon, Apr 27, 2026 at 02:43:38PM +0200, Loic Poulain wrote:
>> Extend the qcm2290 CAMSS binding to describe CAMSS as a simple bus by
>> allowing child ISP nodes. Add the required address and size cells, as
>> well as ranges, and validate ISP subnodes against the existing
>> qcom,qcm2290-camss-ope schema.
>>
>> On qcm2290 the OPE (Offline Processing Engine) is a memory-to-memory
>> ISP (Image Signal Processor).
>>
>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/media/qcom,qcm2290-camss.yaml       | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
>> index 391d0f6f67ef5fdfea31dd3683477561516b1556..d8b356028e24c3c5b2e9b7f20e220db7d491ad68 100644
>> --- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
>> +++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
>> @@ -52,6 +52,14 @@ properties:
>>        - const: vfe1
>>        - const: vfe1_cphy_rx
>>  
>> +  '#address-cells':
> 
> Please use consistent quotes, either ' or "
> 
>> +    const: 2
> 
> This means the child will use 64-bit addressing, but does it need that?
> Or do you need that to have 36-bit DMA addressing? If there are true no
> needs for above, usually recommendation is to use narrowe address space
> for children, so only 32-bit.

I can't find data for this platform, but on e.g. Hamoa, most camera
components can address 36b

Konrad
