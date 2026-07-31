Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F92342509
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 05:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785475072; cv=none; b=dSm4b91X9yy1Qk9mZCVKeJVVsa7OfRfpy4p5O6M1ni8In6uMb0hKNIAYnuDTi1y+tdtSgXQd/d+QoblSFPDGl/fopIwAQ7l1iroyDigo1Np52m3xWS9JO9LCXG15qGUcIbz5Yi3sQUAmoMnLE7fUfFMffMGzTZjzWNlzaE/eQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785475072; c=relaxed/simple;
	bh=+ifn7TPyaS/v88SE5fF3Ld45basZHGCj3sLEvw+LGds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnoMeNXJAmbu45J2DsgaL/1gooBJjYhL7PiOLXHEX5vY+/LrzJx9dxyHnSQDNhluu7PDCHYIqywJzCm0mj7Vv1BEpPHC1uO/6/bLv2dAX6nJGzhTdo2BSI7NpV0pxfa3ypJ+yjYfUK/nsFZgSy+ea+TR7F3KKY7FfeRGrizWSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XUO806ZZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I0gaoc/R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XUO806ZZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I0gaoc/R"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V4ujv92860052
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 05:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pMFXbffvl97DMV9TirEObrCg5VECPoYzJf7iRTf5+8w=; b=XUO806ZZ5Qv54rzI
	fOlIXClmuhtI613DX7t10KPabt3Az9nnCA3u+9TP4lEEAZ/oY2Xhq7dbbGvpEXMa
	bORZuQUqexMQgRkkokiEtMb/D2ONMyI0cFIzc+ZSsK9ANNtUNsE4M/aSTLuZsZW2
	P8uGjmY/pfbBRAbqW14qqZdXM4dJKfNiCdgQKGJnxYs4xYQl3OsbPaEIdvYfMT+l
	h3/pzRcGUHSOKHsrdKzgd6tJjUphQFuuIqsm1QD6bUEA8sBU6/Dvpq+sjR9CrGab
	XVE+uZ0iPUvG87/x+WGhxEyY1oVOi3qA+QUw7FxbzeHloBhP49iz+rVsP7UOZjRL
	fYmyOQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frmyqg2rp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 05:17:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so1207376a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785475067; x=1786079867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMFXbffvl97DMV9TirEObrCg5VECPoYzJf7iRTf5+8w=;
        b=I0gaoc/R95ck205qYQ/bvTRC3bwC2QM3wmbiza+2Sezl1psj6NM9wWkLAMg0khCcpp
         Vxxio8porRYPQOe6EFm0Nr5JNxKYd2b+bPPJkXhMtXYSCRkOpJpZlroiUkak6VMTB5EE
         HKssqW4kXDzWZ6nM1ce3cpJVKsCZm0zJ36sKaQmhkTOAViEyUp5aPqCuEI+/T52VXJB1
         O4+VgASzJzwO2Kie20Nq8eumacLHSzWAjAnom+uVjglkYdBBHooHbSiiyG1nm5WvX5zj
         8zxN0YG3J6FzsTChDTSNE8g2zmpTelc4U1FBeLSnDlj0L4DIRgN/uE6z7z9RAYK32Z9d
         igDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785475067; x=1786079867;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMFXbffvl97DMV9TirEObrCg5VECPoYzJf7iRTf5+8w=;
        b=GIIMZU3AbDHOhWnsEssTW9lG4VS5s0vc4XqlhQ1PaTtIKX2AOIZqe07LCin0sO1s/M
         LhdaTz4IL86vwn0zX4DW/TjfzyevBbLhkW2RjGKLUprdIEhkRPS4esMxvj2X+yZIWeTB
         EP5En/GeKAXDIerXfV1thqge1eEHXnIIOBIA9e78vdivJlBdavFohYsXHHpfmQGxNdRa
         Nnqr1Spv8Z166IkA+qns95F94Cl5yPy70U5vb5vDJcQ+qj/PMl5+EoJ6+HPI7LFl8/bu
         U9noxKwPwLtiN+wgSyCiDJcXTxjnhxTmgYrdPgoGTUuFitoIKrbfWcropOgVRlZnzWt0
         unng==
X-Forwarded-Encrypted: i=1; AHgh+RombGz5JDk3A1Ac6XDHSCt2AabP3TdOPhb67XLpMmqYXSORYwRZhxhXf65iWEcx6ZquL938Hhrx144RQUOP3XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsmxshjyADv/PSdLbPIuAs7LQfSNCYS7MWRg+7pybl7IV9Lsv8
	FZegOb4N2Y78BP5mOGdjzwjGPdjILCUkZ50S2M2xctsmLsJchlrUbyTpaKBH/uiNdSvR99zvp98
	11andzK92AG2xaP4SQckF6nAH8RnqQIMpmHrBOFqt0CeEgvkZ7DCg+OnhnjU/HepqE/i74Vc=
X-Gm-Gg: AR+sD10Xza5AqSs93XBj8MYcDk/zBn/Xb6uqHLDBxxQv6E2Xouml5NcO+D0d4IBA+s1
	Q5od1DPoPUDY1lx9gYBlJD3CsnXG6g9wvslivDXO+KRzc3vtgRq6Gd6y2ZS84ltnFs6knek7J0Q
	WvzbbO8YvFbYiQZxxFJwVnY+yfFmt9E6MxjEccNeyq54eW92vo68/4lsJx9id7jrj/J+sBOEYth
	g/i2ZABlvjqb8tmk78f4l6VNHxMDdylBfu2Yb+9XzaT5rpDZaKP/X1jUStCTJF0evCbfwa+FGso
	PfxmnIlWQ9EnoqCxoF3gj3ja1CYb4AzhYZalevyS4e+AndErkFbrn5rOZzmknrVqLV0KRffyrM8
	r8vWrQHMINcx/NXmjL54tqR7/eYuL3wo=
X-Received: by 2002:a17:90b:57c7:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-38fb13794b9mr658165a91.22.1785475067404;
        Thu, 30 Jul 2026 22:17:47 -0700 (PDT)
X-Received: by 2002:a17:90b:57c7:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-38fb13794b9mr658133a91.22.1785475066917;
        Thu, 30 Jul 2026 22:17:46 -0700 (PDT)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2962928sm158032a91.3.2026.07.30.22.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 22:17:46 -0700 (PDT)
Message-ID: <2131585b-a511-4d4d-acf2-8a0cca2d4b89@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:47:38 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
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
        manaf.pallikunhi@oss.qualcomm.com
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
 <20260727-b4-qmi-tmd-v6-1-973cd3a226af@oss.qualcomm.com>
 <78ed74b8-a810-4253-af7d-65bddd223fd7@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <78ed74b8-a810-4253-af7d-65bddd223fd7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzMyBTYWx0ZWRfXzNMNdfYnUkwI
 pJofXP4mw6isLOHa9FFGy3eBKzmH9GeUXDIbCSVEanyAApAOPOx89Y9tMii8kYRsb+VZrw512kj
 +y//XYXQi9fSz2SmrYsYnzY2649VgLc=
X-Proofpoint-GUID: uRnr28-fEcNosNb5bJH-EcTvfOZxbUfs
X-Proofpoint-ORIG-GUID: uRnr28-fEcNosNb5bJH-EcTvfOZxbUfs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzMyBTYWx0ZWRfX1uD5fOjKr9fn
 qmdUl/3+l+z/z6/PH79h1oNQx7zan4EmbOKzCkkDG9xuzpZ9UOd7+GfemQd7SqDef0Pwsoyp4y2
 9j4CxRjRTQlnIVnBy6UFUwbRzjxh5WuzSKdIupeHrzGJWJ7swOdEu/glHAxgemeE1JpxYGVcil9
 PYDx4WbU4U5G9+CbdbibpDH6DictdYOSd1xpfIfwilOgxNkkz0W3171kJ7eIrcm30WKQZLvpKL6
 RqKr+l048bwldU42C1JbY5kFl04813J5dMecIusImdOfTCNdxf7Ul77ybOtxoyjsj3Fo2e/dH59
 +qVWVE2BAnNzpnGcd2dAShKcz429N7dabymtk9OXB15NVFK7nHwI4daqq0ovBrm1848eB2K3mAF
 4uvQKLoqgC06PNPW3rX+wWcM8lCac0bNQ/rcj7pswhmllsrNLSy+u0yqtqM8CY51k9B8OUK7w/f
 ftZXRfbE1KiPZjcNktQ==
X-Authority-Analysis: v=2.4 cv=Xb65Co55 c=1 sm=1 tr=0 ts=6a6c2ffc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=u1gbKAuDKbG4FYLZLx0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310033



On 7/31/2026 12:02 AM, Daniel Lezcano wrote:
> 
> Hi Gaurav,
> 
> 
> On 7/27/26 16:22, Gaurav Kohli wrote:
>> Document the optional #cooling-cells property for Qualcomm PAS
>> remoteproc nodes so they can be used as thermal cooling devices via
>> the QMI Thermal Mitigation Device (TMD) interface.
>>
>> Qualcomm remote processors expose TMD endpoints that support thermal
>> throttling through firmware. The cooling-device specifier uses 3 cells:
>>
>>    <&phandle device_id min_state max_state>
>>
>> where device_id selects the TMD endpoint (for example PA, modem, or
>> CDSP software mitigation), with constants defined in:
>> include/dt-bindings/thermal/qcom,pas.h
>>
>> Example usage in a thermal zone:
>>
>>    cooling-maps {
>>        map0 {
>>            trip = <&cpu_alert>;
>>            cooling-device = <&remoteproc_cdsp
>>                             QCOM_TMD_CDSP_SW
>>                             0 THERMAL_NO_LIMIT>;
>>        };
>>    };
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   .../bindings/remoteproc/qcom,pas-common.yaml         |  9 +++++++++
>>   MAINTAINERS                                          |  1 +
>>   include/dt-bindings/thermal/qcom,pas.h               | 20 ++++++++++ 
>> ++++++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas- 
>> common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas- 
>> common.yaml
>> index 11faf655f530..f75cab6b4ed9 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> @@ -77,6 +77,15 @@ properties:
>>         channels and devices related to the ADSP.
>>       unevaluatedProperties: false
>> +  '#cooling-cells':
>> +    description: |
>> +      Cooling device with three cells:
>> +        Cell 0: Cooling device id as defined in
>> +                include/dt-bindings/thermal/qcom,pas.h
>> +        Cell 1: Minimum cooling state
>> +        Cell 2: Maximum cooling state
>> +    const: 3
> 
> I'm not sure it is necessary to re-explain what is the property format 
> as it is already described in thermal-cooling-devices.yaml

thanks Daniel for review.
Krzysztof suggested to add path here also for better explanation.
> 
> Other than that:
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
>>     glink-edge:
>>       $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>>       description:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dcffe9fc54f6..3f1e2bbf7099 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3423,6 +3423,7 @@ F:    drivers/watchdog/gunyah_wdt.c
>>   F:    include/dt-bindings/arm/qcom,ids.h
>>   F:    include/dt-bindings/firmware/qcom,scm.h
>>   F:    include/dt-bindings/soc/qcom*
>> +F:    include/dt-bindings/thermal/qcom,pas.h
>>   F:    include/linux/firmware/qcom
>>   F:    include/linux/soc/qcom/
>>   F:    include/soc/qcom/
>> diff --git a/include/dt-bindings/thermal/qcom,pas.h b/include/dt- 
>> bindings/thermal/qcom,pas.h
>> new file mode 100644
>> index 000000000000..f603bddef9a8
>> --- /dev/null
>> +++ b/include/dt-bindings/thermal/qcom,pas.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +/*
>> + * Qualcomm PAS remoteproc cooling device indices
>> + *
>> + * These indices are used in device tree cooling-maps to reference
>> + * specific TMD devices provided by PAS-managed remote processors via 
>> QMI.
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +#ifndef _DT_BINDINGS_THERMAL_QCOM_PAS_H
>> +#define _DT_BINDINGS_THERMAL_QCOM_PAS_H
>> +
>> +/* CDSP thermal mitigation device id */
>> +#define QCOM_TMD_CDSP_SW    0
>> +
>> +/* Modem thermal mitigation device id */
>> +#define QCOM_TMD_PA    0
>> +#define QCOM_TMD_MODEM    1
>> +
>> +#endif /* _DT_BINDINGS_THERMAL_QCOM_PAS_H */
>>
> 

