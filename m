Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92F403EA3
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092960; cv=none; b=OtpyU0TBrXPv8gMllxPg3cxwEUsJSAmMDyrEixHY4WYv5ZemSLcXK5kDRu/zi1j6UPd/95q3PRBDyEOqu+cDqcPRPdP8wYKYBVXQLrwH2GPqtIYN85P4J1h8oYjRGDm5kOLzsQ17TZkHzB3VkVP+iAIg/KqeGdBW/c0lf418CXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092960; c=relaxed/simple;
	bh=6N+clulkPZ4b+YW1h7cMHtrZN8QWlpzXaaiZ3uRZxwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCOwCBCas6mgOWJaiB4Oz9KogtXXOwNElnEyFNIMP52Qnb8xTLsTC3jRbDVB/o6TXx5zPUwR+oJ9/SmjqU1Wd+wT6SuE5YSEW/H8vR1lqf3RtW7+GPa3mJN2fpvlsn2nmW2zq+Ut1Dg8EcJue7x2YsV/33MZVL3a2K6vsw5oOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dUWXN/28; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L8e3U612; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dUWXN/28";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L8e3U612"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ABNT7C1405181
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 12:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ol5IR1Aip1z35CTe1ZZdvuNeCl8yaycEOk4X8EMNnRs=; b=dUWXN/28H3Gtxug4
	ks41kiAke4JNBhKpMulTZDdrUnKYWHXkPzGTYn1fkasbP/PdAoYD5hX++Xc1kWwZ
	VMauhM3cYii9mZnp4PGhes7AfCoR8jGROnUt/GtpuDSsTm/eIMDDzLu5mtwrgVf3
	jPP+SCpIPoxKKLWeDucqIrr15Vn/9wVJo4VHekjxaYOMbZvJ+FSZc6dJPR9Dnhyv
	LlitetEZNfFG2feFczsldwHOu1lV/EHndPCsVzh8b+1oj6wIuqiMiD6EClifE7Xl
	SoSeMda94TdwCrgjgeuteZlc/LejPc07cqR9JY6GutmOO9K9zvOGCiAp5ivZlcqu
	em2RlA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epuketv3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 12:02:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso4502424b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781092957; x=1781697757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ol5IR1Aip1z35CTe1ZZdvuNeCl8yaycEOk4X8EMNnRs=;
        b=L8e3U612DLvib8hEIzZGEapMpB6gGJ5HquQ8Kbq8k/RN3rtzn6QZsDZkzypFEoN+nx
         V6eWPZ2IPabAlfcYGOF0CrROOUHOGPmmWr+RpzamamwV2r36DLuGT1/C/MP5H2E9XRgK
         SWuPW2vb7RBcxkF16lO/7FHaiUgGAsZRxXqU4XCUTQJfAgyGOPvavQyfM+uqmTf/Z4Hn
         sUw9LakynUpv7ad0BRgMB0cmw9bvhCFwari/OQJOiJ/bwFtvLI5syqloYodwnjmiBJFc
         y8dUC5RYu7vlt64ipCPvw3M38LfVXgJK3TzQ52bWuoQqC7EojOu04vfEM+fqiyrM7JZV
         jjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092957; x=1781697757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol5IR1Aip1z35CTe1ZZdvuNeCl8yaycEOk4X8EMNnRs=;
        b=UZ6/Xr39rQBaVHFTGYlD1hR/vih20LnqTzxf1jO4RM3VD0MjC3R0dv+ujJDOOfe4MQ
         d/Q0f9cmuze+sBto39+KEXuYvWYymLgIoKTMOz2X0mUxiBnTfd/z8CHW80htSWAN/toN
         55ruzlTN2BBQ6kJsChzFuG9Xvj04n9OpPci+WfqKOSBoQTwbQhLDfCfpTdXf++Sig3/I
         FEkY5CpfamdG8HMdy9Cd/45jxTbLtPq8SrdgMa6Lu/q9MgGBoVpvv4MA+YMbkeylP7EC
         6W4uOwlguOaU9y5g7jezMXG7iYyBvXRGBWPq/qWTsW0Z/1+CBit3p5uyfjeRUn/iJWtp
         EjpA==
X-Forwarded-Encrypted: i=1; AFNElJ/zA8BIiB38fUiTeqxB/em/oaoGb9jKlBmMKMqaH9QIn7NmDzZ7G6sUEERc3pxYV3B7Q8qS7DmO72KwyPBrF4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzin2QTX2aJnWYFjs7T6ubQp/1O/3jVnmSpz9hz8Qaa2bER3U8
	Vn65O90LC9cn0U8Tb7Cgh60RjBDa09AWogJGmvjQKyqWpodWU41NxN7v2q1Sm0LHHma1VmIRznk
	VnFXoaM/3xyvBrchAJcmh4F7AIqx4aH9ljl0z7wFFUYoB+9QpjxpWEpLdi7i00roTAY6qzbQ=
X-Gm-Gg: Acq92OGFVqaDxPEn9hHRib0LM2aH91kfM9cNsFpjAgKc8NSI3ShTkztuEvPkfZ0HtTK
	z78W/yS0ODkFPN765VuxDxVtDow5SMepOY0HuSyKPepl4+fxpXF1XZoKKL+XrAq7nGbo9CmN0+y
	brAo71P7RmjmMU+Nu1CYZFb0iJGFTC+hIAsWh5fbCWP2gF15q10+S5s3AGomWfY1hJyPyIFL5P8
	Xcn0FfowmS9LqS/sDmwcR0Gvgl/Mxy4+/8902e/hUKxeciZl/4SYFWbdtjFLcPdFqDzRNCroGlp
	NnNlwsT0ViNpM7S38RY9lO3BD5Al2yxLBk05TI/+qwdwSGNLEfi0AfgckfSgmcnMTrzg/pUs6fL
	xBZ7xYv32RdIuq0AKmxYIHxnKEwB5eulHVTStvZ7aSeDa4TK+ONObJdEix/OXq0g=
X-Received: by 2002:a05:6a00:c91:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-842b0feb656mr25453879b3a.46.1781092956966;
        Wed, 10 Jun 2026 05:02:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:c91:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-842b0feb656mr25453772b3a.46.1781092956257;
        Wed, 10 Jun 2026 05:02:36 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221cc3dsm24523372b3a.1.2026.06.10.05.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 05:02:35 -0700 (PDT)
Message-ID: <0593ec29-b670-46e6-8eaf-a146e96a719f@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 17:32:28 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <ujf53zya6hes3hkddhsmgu4wyabodnyg3zdwarxmcsoy6p5h3c@ild34ppiyvre>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <ujf53zya6hes3hkddhsmgu4wyabodnyg3zdwarxmcsoy6p5h3c@ild34ppiyvre>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExNCBTYWx0ZWRfX987j/IEK+gMW
 YKZFcQDhiFVy2y7/WoHos+WS7TdRfRGRkMzO64mTqVjR3rsyMEQ/RnjIvyOJzjjDrg4FvzZM0MA
 baX6dYiSsKLCh7D0H2rwy5VnQRy+cc2pjdvpVuWZWGvttIZWxv+LOw1u14JsyMGPCpZo+EK7xQ8
 bCGq2xFd29xetNijzRc7teyN7Tgr0GTMOtGI2zsfu12FNwOfS27XTO/lGJkw9Syvoddrc/MntC+
 rgqoHwzooPej1qXK5mZmHv3kNMeoFODynV3z/zK20R28yHVOGUWIfQt7RzsSLFEhHUYxcC7iWmb
 +YuwEQxaZv5YZDlaJ3cE4R0E6jGAP/rJeqOrhb+KcBq80v3qLUa6xAri4Vwnyp1c1SVpzLYTYqP
 +Vru7JW7B4cmyc+tHKBKWjpGShrFiNv5CP434Yxt85Q2bLSNcRlVXr4Hjei9lJAf7ns9TXkyu26
 MYA++WVVVMUJvW6ixxQ==
X-Proofpoint-ORIG-GUID: PyK9cjqQy5QrogoA13_KJwwaFpLQ9phG
X-Proofpoint-GUID: PyK9cjqQy5QrogoA13_KJwwaFpLQ9phG
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a29525e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=AQWUehsJRALLLA6uX2EA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100114



On 6/9/2026 4:17 PM, Dmitry Baryshkov wrote:
> On Tue, Jun 09, 2026 at 03:52:56PM +0530, Gaurav Kohli wrote:
>> Document Qualcomm PAS remoteproc thermal mitigation properties used for
>> QMI-based throttling.
>>
>> Add:
>> - #cooling-cells (2 or 3)
>> - tmd-names (thermal mitigation device names)
> 
> Describe _why_ you are performing these changes. For example. why do we
> need to handle two different cases for the #cooling-cells?
> 

Thanks Dmitry for review, Ack.

>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/remoteproc/qcom,pas-common.yaml    | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> index 4607b459131b..0d07a0750762 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> @@ -79,6 +79,20 @@ properties:
>>         channels and devices related to the ADSP.
>>       unevaluatedProperties: false
>>   
>> +  '#cooling-cells':
>> +    description:
>> +      Number of cooling cells; 2 for min/max cooling state and 3 when
>> +      selecting a thermal mitigation device index.
>> +    enum: [2, 3]
>> +
>> +  tmd-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description:
>> +      Names of the thermal mitigation devices available in remote processor
>> +      subsystem.
>> +    minItems: 1
>> +    maxItems: 5
> 
> Missing example with these properties.
> 

Thanks, will add example.

>> +
>>     glink-edge:
>>       $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>>       description:
>>
>> -- 
>> 2.34.1
>>
> 

